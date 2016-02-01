package game.scene 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.utils.Dictionary;
    import game.scene.struct.CPathData;
    import game.scene.struct.CShapeData;
	import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
	import flash.utils.getDefinitionByName;
    
	/**
     * ...
     * @author Husky
     */
    public class CBaseScene extends FlxGroup 
    {
        // This group contains all the tilemaps (CFlxTileMapExt).
		public var m_gTilemaps:FlxGroup;
        // This group contains all the tilemaps specified to use collisions.
		public var m_gSolidTilemaps:FlxGroup;
        
        //Collide Group
        public var m_gCollide:FlxGroup;
        
        protected var m_mapGuid:Dictionary;
        
        protected var m_vShapes:Vector.<CShapeData>;
        protected var m_vPaths:Vector.<CPathData>;
        
        public function CBaseScene() 
        {
        }
        
        public function Initial() : void
        {
            m_vPaths = Vector.<CPathData>([]);
            m_vShapes = Vector.<CShapeData>([]);
            m_mapGuid = new Dictionary();
            m_gCollide = new FlxGroup();
            m_gTilemaps = new FlxGroup();
            m_gSolidTilemaps = new FlxGroup();
        }
        
        protected function AddSpriteToLayer(spr:FlxSprite, clzSpr:Class, gLayer:FlxGroup,
                                         nXpos:Number, nYpos:Number, nAngle:Number, 
                                         nScrollX:Number, nScrollY:Number, 
                                         bFlipped:Boolean = false, nScaleX:Number = 1, 
                                         nScaleY:Number = 1, vProperties:Vector.<Object> = null, 
                                         onAddCallback:Function = null):FlxSprite
		{
			if(spr == null)
				spr = new clzSpr();
            
            spr.x = nXpos;
            spr.y = nYpos;
			spr.x += spr.offset.x;
			spr.y += spr.offset.y;
			spr.angle = nAngle;
            spr.scrollFactor.x = nScrollX;
            spr.scrollFactor.y = nScrollY;
            
			if (nScrollX != 1 || nScaleY != 1)
			{
				spr.scale.x = nScaleX;
				spr.scale.y = nScaleY;
				spr.width *= nScaleX;
				spr.height *= nScaleY;
				// Adjust the offset, in case it was already set.
				var newFrameWidth:Number = spr.frameWidth*nScrollX;
				var newFrameHeight:Number = spr.frameHeight*nScaleY;
				var hullOffsetX:Number = spr.offset.x*nScrollX;
				var hullOffsetY:Number = spr.offset.y*nScaleY;
				spr.offset.x -= (newFrameWidth - spr.frameWidth)/2;
				spr.offset.y -= (newFrameHeight - spr.frameHeight)/2;
			}
            
			if (spr.facing == FlxObject.RIGHT)
            {
				spr.facing = bFlipped ? FlxObject.LEFT : FlxObject.RIGHT;
            }
            
			gLayer.add(spr);
            
            this.OnObjectAddedCallback(spr, gLayer, nScrollX, nScaleY, vProperties);
            
			return spr;
		}
        
        //Call when added any of object on the map
        //the fattest function here
        protected function OnObjectAddedCallback(obj:Object, gLayer:FlxGroup,
                                                 nScrollX:Number, nScrollY:Number, 
                                                 vProperties:Vector.<Object>):Object
		{
            //use for guid's dictionary
			if (vProperties)
			{
				var uiLength:uint = vProperties.length;
                
                for (var ui:uint = 0; ui < uiLength; ui++)
                {
                    if (vProperties[ui].name != "guid")
                    {
                        continue;
                    }
                    
                    var value:String = vProperties[ui].value;
                    this.m_mapGuid[value] = obj;
                    break;
                }
			}
			
			//if (obj is CPlayer)
			//{
				//m_player = obj as CPlayer;
                //m_player.ParseProperties(properties);
			//}
			//else if (obj is CEnemy)
            //{
                //(obj as CBaseAI).ParseProperties(properties);
            //}
            //else if (obj is CIAObject)
            //{
                //(obj as CBaseAI).ParseProperties(properties);
            //}
            //else if ( obj is TextData )
			//{
				//var tData:TextData = obj as TextData;
				//if ( tData.fontName != "" && tData.fontName != "system" )
				//{
					//tData.fontName += "Font";
				//}
				//return level.addTextToLayer(tData, layer, scrollX, scrollY, true, properties, OnObjectAddedCallback );
			//}
			//else if ( obj is BoxData )
			//{
				// Create the CTrigger.
				//var bData:BoxData = obj as BoxData;
				//var cTrigger:CTrigger = new CTrigger(bData.x, bData.y, bData.width, bData.height);
                //
				//cTrigger.ParseProperties(properties);
				//
                //level.addSpriteToLayer(cTrigger, FlxSprite, layer, cTrigger.x, 
                                       //cTrigger.y, bData.angle, scrollX, scrollY);
				//return cTrigger;
			//}
			//else if ( obj is ObjectLink )
			//{
				//var link:ObjectLink = obj as ObjectLink;
				//var fromBox:CTrigger = link.fromObject as CTrigger;
				//if ( fromBox )
				//{
					//fromBox.targetObject = link.toObject;
				//}
			//}
            
			return obj;
		}
        
        ///Get all properties from xml
        protected function GetPropertiesFromXML(xml:XML):Vector.<Object>
        {
            var vProperties:Vector.<Object> = Vector.<Object>([]);
            
            if (xml.hasOwnProperty("properties") == false )
            {
                return vProperties;
            }
            
            for each(var xmlProp:XML in xml.properties.prop)
            {
                vProperties.push({"name": String(xmlProp.@name), 
                                  "value": String(xmlProp.@value)});
            }
            
            return vProperties;
        }
                
        protected function GetTileDataPropertiesFromXML(xmlMap:XML):Dictionary
		{
			if (xmlMap.hasOwnProperty("properties") == false || 
                xmlMap.properties.hasOwnProperty("tile") == false)
			{
                return null;
            }
            
            var mapTileProperties:Dictionary = new Dictionary();
            for each (var xmlTile:XML in xmlMap.properties.tile)
            {
                var vProperties:Vector.<Object> = Vector.<Object>([]);
                mapTileProperties[(int)(xmlTile.@id)] = vProperties;
                for each(var xmlProp:XML in xmlTile.prop)
                {
                    vProperties.push({name:String(xmlProp.@name), 
                                     value:String(xmlProp.@value) } );
                }
            }
                
			return mapTileProperties;
		}
        
        override public function destroy():void
		{
            m_mapGuid = null;
            m_gCollide = null;
			m_gTilemaps = null;
			m_gSolidTilemaps = null;
            
			var ui:uint;
			for (ui = 0; ui < m_vPaths.length; ui++)
			{
				var cPathdata:CPathData = m_vPaths[ui];
                cPathdata.Release();
                cPathdata = null;
			}
            m_vPaths.splice(0, m_vPaths.length);
			m_vPaths = null;

			for (ui = 0; ui < m_vShapes.length; ui++)
			{
				var cShape:CShapeData = m_vShapes[ui];
				if (cShape)
				{
					cShape.Release();
                    cShape = null;
				}
			}
            m_vShapes.splice(0, m_vShapes.length);
			m_vShapes = null;
		}
        
        public function get mapGuid():Dictionary 
        {
            return m_mapGuid;
        }
        
        public function set mapGuid(value:Dictionary):void 
        {
            m_mapGuid = value;
        }
    }

}