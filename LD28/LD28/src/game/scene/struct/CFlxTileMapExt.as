package game.scene.struct 
{
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
    import org.flixel.system.FlxTile;
	
	/**
     * ...
     * @author Husky
     */
    public class CFlxTileMapExt extends FlxTilemap 
    {
        
        public function CFlxTileMapExt() { }
        
        /**
         * Load map frim bitmapData
         * @param sCsvData
         * @param bdTiles
         * @param uiTileWidth
         * @param uiTileHeight
         * @param uiAutoTile
         * @param uiStartingIndex
         * @param uiDrawIndex
         * @param uiCollideIndex
         */
        public function LoadMapByBD(sCsvData:String, bdTiles:BitmapData,
                                    uiTileWidth:uint, uiTileHeight:uint,
                                    uiAutoTile:uint = OFF, uiStartingIndex:uint = 0,
                                    uiDrawIndex:uint = 1, uiCollideIndex:uint = 1) : CFlxTileMapExt
        {
            this.auto = uiAutoTile;
			this._startingIndex = uiStartingIndex;
            
            //Figure out the map dimensions based on the data string
			this._data = [];
            
			var aColumns:Array;
			var aRows:Array = sCsvData.split("\n");
			this.heightInTiles = aRows.length;
            this.widthInTiles = aRows[0].split(",").length;
            
            var uiRow:uint = 0;
			var uiColumn:uint = 0;
            for (uiRow = 0; uiRow < this.heightInTiles; uiRow++)
            {
                aColumns = aRows[uiRow].split(",");
                
                //If read the invalid column data (It's will exist, check the csv)
                if (aColumns.length <= 1)
                {
                    this.heightInTiles = this.heightInTiles - 1;
                    continue;
                }
                
                for (uiColumn = 0; uiColumn < widthInTiles; uiColumn++)
                {
                    this._data.push(uint(aColumns[uiColumn]));
                }
            }

            //Pre-process the map data if it's auto-tiled
			var ui:uint = 0;
			totalTiles = this.widthInTiles*this.heightInTiles;
			if(auto > OFF)
			{
				this._startingIndex = 1;
				uiDrawIndex = 1;
				uiCollideIndex = 1;
                
                for (ui = 0; ui < totalTiles; ui++)
                {
                    this.autoTile(ui);
                }
			}
            
            //Figure out the size of the tiles
			this._tiles = bdTiles;
			this._tileWidth = uiTileWidth;
			this._tileWidth = (this._tileWidth == 0) ? this._tiles.height : this._tileWidth;
			this._tileHeight = uiTileHeight;
			this._tileHeight  = (this._tileHeight == 0) ? this._tileWidth : this._tileHeight;
            
            //create some tile objects that we'll use for overlap checks (one for each tile)
			var uiTilesObjects:uint = (this._tiles.width/this._tileWidth)*
                                      (this._tiles.height/this._tileHeight);
			uiTilesObjects = (auto > OFF) ? uiTilesObjects : uiTilesObjects + 1;
			this._tileObjects = new Array(uiTilesObjects);
            for (ui = 0; ui < uiTilesObjects; ui++)
            {
                this._tileObjects[ui] = new FlxTile(this , ui, _tileWidth, _tileHeight,
                                                    (ui >= uiDrawIndex),
                                                    (ui >= uiCollideIndex) ? 
                                                     allowCollisions : NONE);
            }
            
            //create debug tiles for rendering bounding boxes on demand
			this._debugTileNotSolid = this.makeDebugTile(FlxG.BLUE);
			this._debugTilePartial = this.makeDebugTile(FlxG.PINK);
			this._debugTileSolid = this.makeDebugTile(FlxG.GREEN);
			this._debugRect = new Rectangle(0, 0, this._tileWidth, this._tileHeight);
            
            //Then go through and create the actual map
			this.width = this.widthInTiles*this._tileWidth;
			this.height = this.heightInTiles*this._tileHeight;
			this._rects = new Array(totalTiles);
            
            for (ui = 0; ui < totalTiles; ui++)
            {
                this.updateTile(ui);
            }
				
			this.InitBaseGraphics();
			
			return this;
        }
        
        private function InitBaseGraphics():void 
        {
            _flashPoint.x = _flashPoint.y = 0;
			_flashRect = new Rectangle(0, 0, _tiles.width, _tiles.height);
        }
    }
}