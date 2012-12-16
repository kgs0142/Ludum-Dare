package org.dame.tiles 
{
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
    import org.flixel.FlxG;
    import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;

	/**
	 * FlxTilemapExt modified for with debug to show tile types and alpha fading. 
	 * 
	 * @author Charles Goatley
	 */
	public class FlxTilemapExt extends FlxTilemap
	{		
		private var alpha:Number;
		
		protected var _storedPixels:BitmapData = null;
		
		public function getRects(): Array { return _rects; }
		
		public var tileTypes:Dictionary = new Dictionary; // A look up of tileId(key) to TileTypes(value)
		
		public var tileCount:uint = 0;
		
		public function get tileWidth(): uint
		{
			return _tileWidth;
		}
		
		public function get tileHeight(): uint
		{
			return _tileHeight;
		}
		
		public function FlxTilemapExt() 
		{
			alpha = 1;
			super();	
		}
		
		// A version of loadMap that allows the tile graphic to be passed in directly from an existing bitmap.
		public function loadMapExt(MapData:String, TileGraphic:Class, TileWidth:uint=0, TileHeight:uint=0, AutoTile:uint=OFF, StartingIndex:uint=0, DrawIndex:uint=1, CollideIndex:uint=1, TileGraphicBitmap:BitmapData = null):FlxTilemap
		{
			auto = AutoTile;
			_startingIndex = StartingIndex;

			//Figure out the map dimensions based on the data string
			var columns:Array;
			var rows:Array = MapData.split("\n");
			heightInTiles = rows.length;
			_data = new Array();
			var row:uint = 0;
			var column:uint;
			while(row < heightInTiles)
			{
				columns = rows[row++].split(",");
				if(columns.length <= 1)
				{
					heightInTiles = heightInTiles - 1;
					continue;
				}
				if(widthInTiles == 0)
					widthInTiles = columns.length;
				column = 0;
				while(column < widthInTiles)
					_data.push(uint(columns[column++]));
			}
			
			//Pre-process the map data if it's auto-tiled
			var i:uint;
			totalTiles = widthInTiles*heightInTiles;
			if(auto > OFF)
			{
				_startingIndex = 1;
				DrawIndex = 1;
				CollideIndex = 1;
				i = 0;
				while(i < totalTiles)
					autoTile(i++);
			}

			//Figure out the size of the tiles
			_tiles = TileGraphicBitmap ? TileGraphicBitmap : FlxG.addBitmap(TileGraphic,false,true);
			_tileWidth = TileWidth;
			if(_tileWidth == 0)
				_tileWidth = _tiles.height;
			_tileHeight = TileHeight;
			if(_tileHeight == 0)
				_tileHeight = _tileWidth;
			
			//create some tile objects that we'll use for overlap checks (one for each tile)
			i = 0;
			var l:uint = (_tiles.width/_tileWidth) * (_tiles.height/_tileHeight);
			if(auto > OFF)
				l++;
			_tileObjects = new Array(l);
			var ac:uint;
			while(i < l)
			{
				_tileObjects[i] = new FlxTile(this,i,_tileWidth,_tileHeight,(i >= DrawIndex),(i >= CollideIndex)?allowCollisions:NONE);
				i++;
			}
			
			//create debug tiles for rendering bounding boxes on demand
			_debugTileNotSolid = makeDebugTile(FlxG.BLUE);
			_debugTilePartial = makeDebugTile(FlxG.PINK);
			_debugTileSolid = makeDebugTile(FlxG.GREEN);
			_debugRect = new Rectangle(0,0,_tileWidth,_tileHeight);
			
			//Then go through and create the actual map
			width = widthInTiles*_tileWidth;
			height = heightInTiles*_tileHeight;
			_rects = new Array(totalTiles);
			i = 0;
			while(i < totalTiles)
				updateTile(i++);
				
			initBaseGraphics();
			
			return this;
		}
		
		private function initBaseGraphics():void
		{
			_flashPoint.x = _flashPoint.y = 0;

			_flashRect = new Rectangle(0, 0, _tiles.width, _tiles.height);
			_storedPixels = new BitmapData(_tiles.width, _tiles.height);
			_storedPixels.copyPixels(_tiles, _flashRect, _flashPoint);
			
			tileCount = ( _tiles.width / tileWidth ) * (_tiles.height / tileHeight );
		}
		
		public function setAlpha( newAlpha:Number ) : void
		{
			alpha = newAlpha;
			var rec:Rectangle = new Rectangle(0, 0, width, height);
			var ct:ColorTransform = new ColorTransform();
			ct.alphaMultiplier = alpha; 
			_flashPoint.x = _flashPoint.y = 0;
			_tiles.copyPixels(_storedPixels,rec,_flashPoint);
			_tiles.colorTransform( rec, ct);
			setDirty(true);
		}
	}
}