package org.dame.utils 
{
	import org.dame.utils.Misc;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import org.flixel.FlxG;
	 
	/**
	 * ...
	 * @author Charles Goatley
	 */
	public class ImageBank
	{
		private static var images:Vector.<ImageData>;
		private static var backupImages:Vector.<ImageData> = null;
		
		private static var numberOfFilesQueued:uint = 0;
		private static var hadFileError:Boolean = false;
		
		private static var imageBank:ImageBank = new ImageBank();
		
		public static function Initialize():void
		{
			images = Vector.<ImageData>([]);
		}
		
		public static function LoadImage( file:String, Callback:Function = null, CallbackData:Object = null, LoadFailedCallback:Function = null ):void
		{
			if ( file == null )
			{
				if ( LoadFailedCallback != null )
				{
					LoadFailedCallback(file);
				}
				return;
			}
			
			file = Misc.GetStandardFileString(file);
		
			// See if the image is already loaded.
			var i:uint = images.length;
			while( i-- )
			{
				var data:ImageData = images[i];
				if ( Misc.FilesMatch(data.file,file) )
				{
					data.refCount++;
					if ( Callback != null )
					{
						if ( data.image!=null )
						{
							Callback( data.image, data.file, CallbackData );
						}
						else
						{
							data.callbacks.push(Callback);
							data.callbackDatas.push(CallbackData);
						}
					}
					return;
				}
			}
			
			// Load the new image.
			
			data = new ImageData;
			data.file = file;
			data.loadFailedCallback = LoadFailedCallback;
			data.image = null;
			data.refCount = 1;
			data.callbacks = Vector.<Function>([]);
			data.callbackDatas = Vector.<Object>([]);
			if ( Callback != null )
			{
				data.callbacks.push(Callback);
				data.callbackDatas.push(CallbackData);
			}
			images.push( data );
			
			LoadImageData(data);
		}
		
		private static function LoadImageData( data:ImageData ):void
		{
			numberOfFilesQueued++;
			var ext:String = getExtension( data.file );
			var imageRequest:URLRequest = new URLRequest(data.file);
			
			var imageLoader:Loader = data.loader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded, false, 0, true);
			imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, genericErrorHandler,false,0,true);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, genericErrorHandler, false, 0, true);
			// Still appears to be no way of getting an error when the image loaded is too big.
			imageLoader.load(imageRequest);
		}
		
		private static function getExtension( filename:String ):String
		{
			var arr:Array = filename.split(".");
			var len:uint = arr.length;
			return arr[len - 1];
		}
		
		
		private static function genericErrorHandler(event:Event):void
		{
			numberOfFilesQueued--;
			hadFileError = true;
			//AlertBox.Show("Error" + event.text, "Warning", AlertBox.OK);
			if ( numberOfFilesQueued == 0)
			{
				purgeListAndShowErrors();
			}
		}
		
		private static function imageLoaded(event:Event):void
		{
			var loader:Loader = Loader(event.target.loader);
			
			var i:uint = images.length;
			while( i-- )
			{
				var data:ImageData = images[i];
				if ( event.target.loader == data.loader )
				{
					var ext:String = getExtension( data.file );
					if ( data.image == null )
					{
						data.image = event.target.content;
					}
					for ( var j:int = 0; j < data.callbacks.length; j++)
					{
						var callback:Function = data.callbacks[j];
						callback( data.image, data.file, data.callbackDatas[j] );
					}
					data.loadFailedCallback = null;
					data.callbacks.length = 0;
					data.callbackDatas.length = 0;
					break;
				}
			}
			
			numberOfFilesQueued--;
			purgeListAndShowErrors();
		}
		
		public static function RemoveImageRef( file:String ):void
		{
			var i:uint;
			var data:Object;
			
			for ( i = 0; i < images.length; i++ )
			{
				data = images[i];
				if (  Misc.FilesMatch( data.file, file ) )
				{
					data.refCount--;
					if ( data.refCount == 0 )
					{
						images.splice(i, 1);
					}
					return;
				}
			}
		}
		
		private static function purgeListAndShowErrors():void
		{
			// If there are no more files left to load and we had some errors then
			// display error messages and remove the entries from the list.
			if ( numberOfFilesQueued == 0 && hadFileError )
			{
				hadFileError = false;
				numberOfFilesQueued = 0;
				var fileError:String = "";
				var i:uint;
				var data:ImageData;
				var errorCount:uint = 0;
				for ( i = 0; i < images.length; i++ )
				{
					data = images[i];
					if ( data.image == null )
					{
						if ( data.loadFailedCallback != null )
						{
							data.loadFailedCallback( data.file );
						}
						errorCount++;
						if( errorCount <= 15 )
							fileError += "\n" + data.file;
						trace("file error: " + data.file);
						images.splice(i, 1);
						i -= 1;
					}
				}
			}
		}
		
		public static function Clear():void
		{
			var i:uint = images.length;
			while ( i-- )
			{
				if ( images[i].image &&  images[i].image.bitmapData )
				{
					images[i].image.bitmapData.dispose();
				}
				//FlxG.removeCachedBitmap( images[i].file.nativePath );
			}
			images.length = 0;
		}
		
	}

}

import flash.display.Bitmap;
import flash.display.Loader;
import flash.net.URLStream;
import flash.net.URLVariables;

internal class ImageData
{
	public var changed:Boolean = false;
	public var file:String;
	public var refCount:uint = 1;
	public var image:Bitmap;
	public var callbackDatas:Vector.<Object>;
	public var callbacks:Vector.<Function>;
	public var loadFailedCallback:Function = null;
	public var loader:Loader;
}
