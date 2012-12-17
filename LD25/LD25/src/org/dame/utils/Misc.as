package org.dame.utils 
{
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Charles Goatley
	 */
	public class Misc
	{
		static public function clamp( val:Number, min:Number, max:Number ):Number
		{
			if ( val < min )
				return min;
			else if ( val > max )
				return max;
			return val;
		}
		
		static public function sign(value:Object):int
		{
			return ( value >= 0 ? 1 : -1 );
		}
		
		static public function lerp(t:Number, min:Number, max:Number ): Number
		{
			return min + ( t * ( max - min ) );
		}
		
		static public function FilesMatch(file1:String, file2:String ):Boolean
		{
			if ( !file1 || !file2 )
			{
				return false;
			}
			var pattern:RegExp = /\\/g;
			return ( file1.replace(pattern, "/" ).toLowerCase() == file2.replace(pattern, "/" ).toLowerCase() );
		}
		
		static public function GetCurrentURL():String
		{
			var url:String;
			if (ExternalInterface.available) 
			{
				return ExternalInterface.call("window.location.href.toString");
			}
			return "";
		}
		
		static public function GetStandardFileString(filename:String, relativePath:Boolean = true):String
		{
			var pattern:RegExp = /\\/g;
			if ( relativePath )
			{
				// Relative to data dir but needs to be relative to bin dir.
				//if ( Capabilities.playerType == "PlugIn" )
				//{
					//filename = "http://localhost/dambotsNew/games/Dame Samples/data/" + filename;
                    //FIXME remember to add security policy and change this
					//filename = "http://kgs0142.sg1006.myweb.hinet.net/www/Ludum_Dare/LD25/assets/" + filename;
				//}
				//else
				//{
					//filename = "../assets/" + filename;
				//}
                
                //filename = (CONFIG::release) ?
                //"http://kgs0142.sg1006.myweb.hinet.net/www/Ludum_Dare/LD25/assets/" + filename :
                //"../assets/" + filename;
                
                filename = "../assets/" + filename;
			}
            
			return filename.replace(pattern, "/" );
		}
		
		// Infinite line intersection. Returns true if intersection occurs within the line.
		// pt will contain the intersection point, wherever it is.
		static public function LineRayIntersection(x1:Number, y1:Number, x2:Number, y2:Number, rayX:Number, rayY:Number, rayDirX:Number, rayDirY:Number, pt:FlxPoint):Boolean
		{
			var bx:Number = x2 - x1;
			var by:Number = y2 - y1;
			var dx:Number = rayDirX - rayX;
			var dy:Number = rayDirY - rayY; 
			var b_dot_d_perp:Number = bx*dy - by*dx;
			if (b_dot_d_perp == 0)
			{
				pt.x = rayX;
				pt.y = rayY;
				return false;
			}
			var cx:Number = rayX-x1; 
			var cy:Number = rayY-y1;
			var t:Number = (cx * dy - cy * dx) / b_dot_d_perp; 
			
			pt.make(x1 + t * bx, y1 + t * by);
			
			return (t >= 0 && t < 1);
		}

	}

}