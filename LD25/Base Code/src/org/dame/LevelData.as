package org.dame 
{
    import com.ai.CPlayer;
    import com.ai.CTrigger;
    import org.dame.objects.BoxData;
    import org.dame.objects.CircleData;
    import org.dame.objects.LayerData;
    import org.dame.objects.PathData;
    import org.dame.objects.PathNode;
    import org.dame.objects.TextData;
    import org.dame.tiles.FlxTilemapExt;
    import org.dame.utils.FileLoader;
    import org.dame.utils.ImageBank;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.utils.clearInterval;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import flash.utils.setInterval;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelData extends BaseLevel
	{
		public var name:String;
		
		private var alreadySetup:Boolean = false;
		public var sprites:Vector.<FlxSprite> = Vector.<FlxSprite>([]);
		public var collideGroup:FlxGroup = new FlxGroup; // things we collide with
		public var overlapGroup:FlxGroup = new FlxGroup; // things we overlap with.
		public var collidingSpritesGroup:FlxGroup = new FlxGroup; // sprites that collide with the collideGroup.
		
		private var levelLoadedCallback:Function = null;
		
		// the group where the player must be added.
		public var spritesGroup:LayerData = null;
		
		private var numItemsLoading:int = 0;
		private var waitForLoadIntervalId:uint;
		
		private static const FADE_TIME:Number = 1;
		
		public function LevelData() 
		{
			//masterLayer = this;	// for backwards compatibility.
            ImageBank.Initialize();
		}
		
		private function setup( ):void
		{
			// If the bounds are less than the screen dimensions then stretch them so the bounds are centred on the screen.
			var wid:int = boundsMax.x - boundsMin.x;
			if ( wid < FlxG.width )
			{
				var diffX:int = ( FlxG.width - wid ) / 2;
				boundsMin.x -= diffX;
				boundsMax.x += diffX;
			}
			var ht:int = boundsMax.y - boundsMin.y;
			if ( ht < FlxG.height )
			{
				var diffY:int = ( FlxG.height - ht ) / 2;
				boundsMin.y -= diffY;
				boundsMax.y += diffY;
			}
			
			for each( var map:FlxTilemapExt in tilemaps.members )
			{
				if ( hitTilemaps.members.indexOf( map ) == -1 )
				{
					map.solid = false;
				}
			}
			
			alreadySetup = true;
		}
		
		public function LoadMap(filename:String, onAddCallback:Function, onLevelLoaded:Function ):void
		{
			levelLoadedCallback = onLevelLoaded;
			FileLoader.LoadFile(filename, xmlLoaded, XML, onAddCallback, null );
		}
		
		private function xmlLoaded(filename:String, xml:XML, callbackData:Object ):void
		{
			var onAddCallback:Function = callbackData as Function;
			name = "Level_" + String(xml.@name);
			boundsMin = new FlxPoint(xml.@minx, xml.@miny);
			boundsMax = new FlxPoint(xml.@maxx, xml.@maxy);
			bgColor = uint(xml.@bgColor);
			
			var pathLinks:Dictionary = new Dictionary;
			
			for each( var layerXML:XML in xml.layer )
			{
				var layer:LayerData = new LayerData(layerXML.@name, layerXML.@xScroll, 
                                                    layerXML.@yScroll);
				var properties:Array = GetPropertiesFromXML(layerXML);
				if ( layer.name == "sprites" )
				{
					spritesGroup = layer;
				}
                
				for each( var spriteXML:XML in layerXML.sprite )
				{
					var SpriteClass:Class = GetSpriteClassFromName(spriteXML.attribute("class"));
					if ( SpriteClass != null )
					{
						var sprite:FlxSprite = addSpriteToLayer(null, SpriteClass, layer, 
                                                                spriteXML.@x, spriteXML.@y, 
                                                                spriteXML.@angle, layer.xScroll, 
                                                                layer.yScroll, spriteXML.@flip == true, 
                                                                spriteXML.@xScale, spriteXML.@yScale, 
                                                                GetPropertiesFromXML(spriteXML), onAddCallback );
						if ( spriteXML.hasOwnProperty("@pathId") )
						{
							var pathId:int = int(spriteXML.@pathId);
							if ( paths.length > pathId )
							{
								var path:PathData = paths[pathId];
								path.childAttachNode = int(spriteXML.@attachNode);
								path.childAttachT = Number(spriteXML.@attachT);
							}
							else
							{
								pathLinks[pathId] = { xml:spriteXML, obj:sprite };
							}
						}
						CheckLinksXML(spriteXML, sprite);
					}
				}
                
				for each( var shapeXML:XML in layerXML.shape )
				{
					var shape:Object;
					if ( shapeXML.@type == "box" )
					{
						shape = new BoxData(shapeXML.@x, shapeXML.@y, shapeXML.@angle, shapeXML.@wid, shapeXML.@ht, layer );
					}
					else if ( shapeXML.@type == "circle" )
					{
						shape = new CircleData(shapeXML.@x, shapeXML.@y, shapeXML.@radius, layer);
					}
					else if ( shapeXML.@type == "text" )
					{
						shape = new TextData( shapeXML.@x, shapeXML.@y, shapeXML.@wid, shapeXML.@ht, shapeXML.@angle, shapeXML.@text, shapeXML.@font, shapeXML.@size, uint(shapeXML.@color), shapeXML.@align );
					}
					shapes.push(shape);
					callbackNewData( shape, onAddCallback, layer, GetPropertiesFromXML(shapeXML), shapeXML.@xScroll, shapeXML.@yScroll );			
					CheckLinksXML(shapeXML, path);
				}
                
				for each( var pathXML:XML in layerXML.path )
				{
					var nodes:Array = [];
					var isSpline:Boolean = pathXML.@spline == true;
					for each( var nodeXML:XML in pathXML.nodes.node )
					{
						var newNode:PathNode = new PathNode( Number(nodeXML.@x), Number(nodeXML.@y));
						nodes.push( newNode );
						if ( isSpline )
						{
							newNode.tan1 = new FlxPoint( Number(nodeXML.@tan1x), Number(nodeXML.@tan1y) );
							newNode.tan2 = new FlxPoint( Number(nodeXML.@tan2x), Number(nodeXML.@tan2y) );
						}
					}
					var pathobj:PathData = new PathData( nodes, pathXML.@closed == true, isSpline, layer );
					pathId = paths.length;
					if( pathLinks[pathId] )
					{
						// We couldn't attach the sprite to the path before as the path hadn't been created...
						pathobj.childSprite = pathLinks[pathId].obj;
						spriteXML = pathLinks[pathId].xml;
						pathobj.childAttachNode = int(spriteXML.@attachNode);
						pathobj.childAttachT = Number(spriteXML.@attachT);
					}
					paths.push(pathobj);
					callbackNewData( pathobj, onAddCallback, layer, GetPropertiesFromXML(pathXML), layer.xScroll, layer.yScroll );
					
					CheckLinksXML(pathXML, pathobj);
				}
				for each( var mapXML:XML in layerXML.map )
				{
					var file:String = mapXML.@tiles;// Misc.GetStandardFileString(mapXML.@tiles);
					numItemsLoading++;
					
					var callbackData:Object = { bmp:null, csv:null, mapXML:mapXML, layer:layer, onAddCallback:onAddCallback, properties:properties };
					ImageBank.LoadImage(file, tilemapLoaded, callbackData );
					FileLoader.LoadFile(mapXML.@csv, csvLoaded, String, callbackData, null);
				}
				
				setup();
				add(layer);
			}
			
			// Link objects together.
			if ( xml.hasOwnProperty("links") )
			{
				for each( var linkXML:XML in xml.links.link )
				{
					try
					{
						createLink(linkedObjectDictionary[int(linkXML.@from)], linkedObjectDictionary[int(linkXML.@to)], onAddCallback,  GetPropertiesFromXML(linkXML) );
					}
					catch(error:Error)
					{
						trace("failed to create link from " + linkXML.@from + " to " + linkXML.@to);
					}
					
				}
			}
			
			if ( levelLoadedCallback != null )
			{
				if ( numItemsLoading )
				{
					waitForLoadIntervalId = setInterval(waitForAllItemsToLoad, 100, levelLoadedCallback);
				}
				else
				{
					levelLoadedCallback(this);
				}
			}
		}
		
		private function waitForAllItemsToLoad( levelLoadedCallback:Function ):void
		{
			if ( numItemsLoading == 0)
			{
				clearInterval(waitForLoadIntervalId);
				levelLoadedCallback(this);
			}
		}
		
		private function csvLoaded( filename:String, data:Object, callbackData:Object ):void
		{
			callbackData.csv = data as String;
			if ( callbackData.bmp )
				createTilemap(callbackData);
		}
		private function tilemapLoaded( bmp:Bitmap, filename:String, callbackData:Object ):void
		{
			callbackData.bmp = bmp.bitmapData;
			if ( callbackData.csv )
				createTilemap(callbackData);
		}
		
		private function createTilemap(data:Object):void
		{
			var csvData:String = data.csv;
			var bmpData:BitmapData = data.bmp.clone();
			var mapXML:XML = data.mapXML;
			var layer:LayerData = data.layer;
			var map:FlxTilemapExt = new FlxTilemapExt;
			map.loadMapExt( csvData, null, mapXML.@tileWidth, mapXML.@tileHeight, FlxTilemap.OFF, 0, mapXML.@drawIdx, mapXML.@collIdx, bmpData);
			map.x = mapXML.@x;
			map.y = mapXML.@y;
			map.scrollFactor.x = layer.xScroll;
			map.scrollFactor.y = layer.yScroll;
			if ( mapXML.hasHits )
			{
				hitTilemaps.add(map);
				collideGroup.add(map);
			}
			tilemaps.add(map);
			var tileProperties:Dictionary = GetTileDataPropertiesFromXML(mapXML);
			for ( var tileIdObj:Object in tileProperties )
			{
				var tileId:int = tileIdObj as int;
				var tileProps:Array = tileProperties[tileId];
				var j:int = tileProps.length;
				
				while ( j-- )
				{
					var propname:String = tileProps[j].name;
					if ( propname == "CAN_JUMP" )
					{
						map.setTileProperties(tileId, FlxObject.CEILING, null, null, 1);
					}
				}
			}
			if (data.onAddCallback != null)
			{
				data.properties.push( { name:"%DAME_tiledata%", value:tileProperties } );
				data.onAddCallback(map, null, this, layer.xScroll, layer.yScroll, data.properties);
			}
			
			layer.add(map);
			numItemsLoading--;
		}
		
		private function GetPropertiesFromXML(xml:XML ):Array
		{
			var properties:Array = [];
			if ( xml.hasOwnProperty("properties") )
			{
				for each( var propXML:XML in xml.properties.prop )
				{
					properties.push( { name:String(propXML.@name), value:String(propXML.@value) } );
				}
			}
			return properties;
		}
		
		private function GetTileDataPropertiesFromXML(xml:XML ):Dictionary
		{
			var tileProperties:Dictionary = null;
			if ( xml.hasOwnProperty("properties") && xml.properties.hasOwnProperty("tile") )
			{
				tileProperties = new Dictionary;
				for each( var tileXml:XML in xml.properties.tile )
				{
					var properties:Array = [];
					tileProperties[(int)(tileXml.@id)] = properties;
					for each( var propXML:XML in tileXml.prop )
					{
						properties.push( { name:String(propXML.@name), value:String(propXML.@value) } );
					}
				}
			}
			return tileProperties;
		}
		
		private function CheckLinksXML( xml:XML, obj:Object ):void
		{
			if ( xml.hasOwnProperty("@linkId") )
			{
				linkedObjectDictionary[ int(xml.@linkId) ] = obj;
			}
		}
		
		// References requires for getDefinitionByName to work.
		//private static var CoinRef:Coin = null;
		
		private function GetSpriteClassFromName(name:String):Class
		{
			try
			{
				var className:String = "com.ai." + name;
				var ClassReference:Class = getDefinitionByName( className ) as Class;
				return ClassReference;
			}
			catch ( error:Error)
			{
			}
			return null;
		}
		
		public function fadeoff():void
		{
			for each( var tilemap:FlxTilemapExt in tilemaps.members )
			{
				tilemap.visible = false;
			}
			var i:int = sprites.length;
			while (i--)
			{
				if ( sprites[i].exists )
				{
					sprites[i].visible = false;
				}
			}
		}
		
		public function fadeon():void
		{
			for each( var tilemap:FlxTilemapExt in tilemaps.members )
			{
				tilemap.visible = true;
			}
			var i:int = sprites.length;
			while (i--)
			{
				if ( sprites[i].exists )
				{
					sprites[i].visible = true;
				}
			}
		}
		
		override public function addSpriteToLayer(obj:FlxSprite, type:Class, layer:FlxGroup, xpos:Number, ypos:Number, angle:Number, scrollX:Number, scrollY:Number, flipped:Boolean = false, scaleX:Number = 1, scaleY:Number = 1, properties:Array = null, onAddCallback:Function = null):FlxSprite
		{
			var spr:FlxSprite = super.addSpriteToLayer(obj, type, layer, xpos, ypos, angle, scrollX, scrollY, flipped, scaleX, scaleY, properties, onAddCallback);
			
			if ( !(spr is CTrigger) && !(spr is CPlayer) )
			{
				sprites.push(spr);
			}
			
			// could add to the collideGroup here as well...
			
			//if (spr is CTrigger || spr is Coin) // or any other overlapping sprite
			//{
				//overlapGroup.add(spr as FlxSprite);
			//}
            
			return spr;
		}
		
	}

}