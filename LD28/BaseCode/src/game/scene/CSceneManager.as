package game.scene 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import game.scene.struct.CBoxData;
    import game.scene.struct.CCircleData;
    import game.scene.struct.CFlxTileMapExt;
    import game.scene.struct.CShapeData;
    import game.scene.struct.CTextData;
    import game.scene.struct.FlxGroupLayer;
    import nc.component.system.NcLoader;
    import nc.system.NcSystems;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
    
	/**
     * ...
     * @author Husky
     */
    public class CSceneManager extends CBaseScene
    {
        private static var ms_Instance:CSceneManager;

        //the two FlxGroupLayer in level editing by DAME
		private var m_gSpritesLayer:FlxGroupLayer;
        private var m_gOthersLayer:FlxGroupLayer;
        private var m_pBoundsMin:Point;
        private var m_pBoundsMax:Point;
        
        /**
         * Create Scene by already loaded complete files from loader
         * @param sSceneXmlName
         * @param fnCreateLevelComplete
         */
        public function CreateScene(sSceneXmlName:String, fnCreateLevelComplete:Function) : void
        {
            var loader:NcLoader = NcSystems.Get().GetComponent(NcLoader);
            if (loader == null)
            {
                return;
            }
            
            var sXml:String = loader.GetAsset(sSceneXmlName) as String;
            var xml:XML = new XML(sXml);
            
            var sLevelName:String = "Level_" + String(xml.@name);
			var uiBgColor:uint = uint(xml.@bgColor);
            
            this.m_pBoundsMin = new Point(xml.@minx, xml.@miny);
			this.m_pBoundsMax = new Point(xml.@maxx, xml.@maxy);
            
            var pathLinks:Dictionary = new Dictionary;
            
            //process all the layers
			for each(var xmlLayer:XML in xml.layer)
			{
				var gLayer:FlxGroupLayer = new FlxGroupLayer(xmlLayer.@name, 
                                                             xmlLayer.@xScroll, 
                                                             xmlLayer.@yScroll);
				
                var vLayerProperties:Vector.<Object> = this.GetPropertiesFromXML(xmlLayer);
                
                //FIXME is this really necessary?
                //Set the group layer
				if (xmlLayer.name == "sprites")
				{
					m_gSpritesLayer = gLayer;
				}
                else if (xmlLayer.name == "others")
                {
                    m_gOthersLayer = gLayer;
                }
                
                //A layer only has one type(Sprite or Shape or Path or Map);
                //Others will do nothing.
                
                this.ProcessSprite(xmlLayer.sprite, gLayer);
                
                this.ProcessShape(xmlLayer.shape, gLayer);
                
                //Need not the path now
                //this.ProcessPath(xmlLayer.path);
                
                this.ProcessMap(xmlLayer.map, gLayer, vLayerProperties);
				
				this.Setup();
                
				this.add(gLayer);
			}
            
            // Link objects together.
            //--Don't need the link now--
			
            fnCreateLevelComplete(this);
        }
        
        protected function ProcessMap(xmlMapList:XMLList, gLayer:FlxGroupLayer,
                                      vLayerProperties:Vector.<Object>):void 
        {
            for each(var xmlMap:XML in xmlMapList)
            {
                var loader:NcLoader = NcSystems.Get().GetComponent(NcLoader);
                
                var sCsvName:String = NC_GET_NAME_NO_EXT(xmlMap.@csv);
                var sTextureName:String = NC_GET_NAME_NO_EXT(xmlMap.@tiles);
                
                var sCsvData:String = loader.GetAsset(sCsvName) as String;
                var bmpTexture:Bitmap = loader.GetAsset(sTextureName) as Bitmap;
                var bdTexture:BitmapData = bmpTexture.bitmapData.clone();
                
                var map:CFlxTileMapExt = new CFlxTileMapExt();
                map.LoadMapByBD(sCsvData, bdTexture, 
                                xmlMap.@tileWidth, xmlMap.@tileHeight,
                                FlxTilemap.OFF, 0, xmlMap.@drawIdx, xmlMap.@collIdx);
                map.x = xmlMap.@x;
                map.y = xmlMap.@y;
                map.scrollFactor.x = gLayer.xScroll;
                map.scrollFactor.y = gLayer.yScroll;
                
                //it's string...
                if (xmlMap.@hasHits == "true")
                {
                    m_gSolidTilemaps.add(map);
                    m_gCollide.add(map);
                }
                
                m_gTilemaps.add(map);
                
                var mapTileProperties:Dictionary = this.GetTileDataPropertiesFromXML(xmlMap);
                for (var tileIdObj:Object in mapTileProperties)
                {
                    var iTileId:int = tileIdObj as int;
                    var vTileProps:Vector.<Object> = mapTileProperties[iTileId];
                    
                    var uiLength:int = vTileProps.length;
                    for (var ui:uint = 0; ui < uiLength; ui++)
                    {
                        var propname:String = vTileProps[ui].name;
                        if (propname != "CAN_JUMP")
                        {
                            continue;
                        }
                        
                        map.setTileProperties(iTileId, FlxObject.CEILING, null, null, 1);
                    }
                }
                
                vLayerProperties.push(
                {
                    name:"%DAME_tiledata%", 
                    value:mapTileProperties
                });
                                       
                this.OnObjectAddedCallback(map, gLayer, 
                                           gLayer.xScroll, gLayer.yScroll,
                                           vLayerProperties);                       
                gLayer.add(map);
            }
        }
        
        protected function ProcessShape(xmlShapeList:XMLList, gLayer:FlxGroupLayer):void 
        {
            for each(var xmlShape:XML in xmlShapeList)
            {
                var shape:CShapeData;
                if (xmlShape.@type == "box")
                {
                    shape = new CBoxData(xmlShape.@x, xmlShape.@y, xmlShape.@angle, 
                                        xmlShape.@wid, xmlShape.@ht, gLayer);
                }
                else if (xmlShape.@type == "circle")
                {
                    shape = new CCircleData(xmlShape.@x, xmlShape.@y, 
                                           xmlShape.@radius, gLayer);
                }
                else if (xmlShape.@type == "text")
                {
                    shape = new CTextData(xmlShape.@x, xmlShape.@y, xmlShape.@wid, 
                                          xmlShape.@ht, xmlShape.@angle, xmlShape.@text, 
                                          xmlShape.@font, xmlShape.@size, 
                                          uint(xmlShape.@color), xmlShape.@align );
                }
                
                m_vShapes.push(shape);
                this.OnObjectAddedCallback(shape, gLayer, xmlShape.@xScroll, 
                                           xmlShape.@yScroll, 
                                           this.GetPropertiesFromXML(xmlShape));
                //CheckLinksXML(xmlShape, path);
            }
        }
        
        protected function ProcessSprite(xmlSpriteList:XMLList, gLayer:FlxGroupLayer) : void 
        {
            for each(var xmlSprite:XML in xmlSpriteList)
            {
                //Get Class by full class name (eg. "com.ai.CPlayer")
                //Need import all classes will use first.
                var clz:Class = getDefinitionByName(xmlSprite.attribute("class")) as Class;
                
                if (clz == null)
                {
                    trace("Sprite Class: " + xmlSprite.attribute("class") + " can't find");
                    continue;
                }
                
                //Create and add FlxSprite to layer
                this.AddSpriteToLayer(null, clz, gLayer, xmlSprite.@x, xmlSprite.@y, 
                                      xmlSprite.@angle, gLayer.xScroll, gLayer.yScroll, 
                                      xmlSprite.@flip == true, xmlSprite.@xScale, 
                                      xmlSprite.@yScale, this.GetPropertiesFromXML(xmlSprite));
                
                //The path of sprites
                //-----------------All delete, don't need this now--------------
            }
        }
        
        private function Setup():void 
        {
            // If the bounds are less than the screen dimensions then stretch them so the bounds are centred on the screen.
            var iDiff:int;
            var iWidth:int = this.m_pBoundsMax.x - this.m_pBoundsMin.x;
			if (iWidth < FlxG.width )
			{
				iDiff = (FlxG.width - iWidth)/2;
				this.m_pBoundsMin.x -= iDiff;
				this.m_pBoundsMax.x += iDiff;
			}
            
			var iHeight:int = this.m_pBoundsMax.y - this.m_pBoundsMin.y;
			if (iHeight < FlxG.height)
			{
				iDiff = (FlxG.height - iHeight)/2;
				this.m_pBoundsMin.y -= iDiff;
				this.m_pBoundsMax.y += iDiff;
			}
			
			for each(var map:CFlxTileMapExt in m_gTilemaps.members)
			{
				if (m_gSolidTilemaps.members.indexOf(map) == -1)
				{
					map.solid = false;
				}
			}
        }

        protected override function OnObjectAddedCallback(obj:Object, gLayer:FlxGroup,
                                                          nScrollX:Number, nScrollY:Number, 
                                                          vProperties:Vector.<Object>):Object
		{
            var obj:Object = super.OnObjectAddedCallback(obj, gLayer, 
                                                         nScrollX, nScrollY, vProperties);
                                                         
            return obj;
        }
        
        //-------------------------------------------------------------------------------
        public override function Initial() : void   
        {
            super.Initial();
            
            m_gSpritesLayer = null;
            m_gOthersLayer = null;
            
            //Add all the class will create during the processing.
            //CDoor;
            //COuterDoor;
            //CEnemy;
            //CPlayer;
            //CDiary;
        }
        
        public override function destroy() : void   
        {
            super.destroy();
            
            m_gSpritesLayer = null;
            m_gOthersLayer = null;
        }
        
        public function CSceneManager(proxy:CSSingletonProxy)
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
        
        public static function Get() : CSceneManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CSceneManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
    }
}

class CSSingletonProxy { }