package game.gameObjects.scene;

import flixel.FlxCamera;
import flixel.FlxState;
import game.gameObjects.ai.Boss;
import game.gameObjects.ai.Monster_01;
import game.gameObjects.ai.Protagonist;
import game.gameState.BaseGameState;
import game.gameState.GamePlayState;
import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import utils.AssetPaths;

/**
 * Minor changing from the version of Samuel Batista
 */
class TiledLevel extends TiledMap
{
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/tile/";
	
	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
    public var collidableObjects:FlxGroup;
    public var overlapableObjects:FlxGroup;

	private var collidableTileLayers:Array<FlxTilemap>;
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();
        collidableObjects = new FlxGroup();
		overlapableObjects = new FlxGroup();
        
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
		
		// Load Tile Maps
		for (tileLayer in layers)
		{
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			
			if (tileLayer.properties.contains("nocollide"))
			{
				backgroundTiles.add(tilemap);
			}
			else
			{
				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();
				
				foregroundTiles.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}
	
	public function loadObjects(state:GamePlayState)
	{
		for (group in objectGroups)
		{
			for (o in group.objects)
			{
				loadObject(o, group, state);
			}
		}
	}
	
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:GamePlayState)
	{
		var x:Int = o.x;
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
        {
			y -= g.map.getGidOwner(o.gid).tileHeight;
        }
		
        var goType:String = o.custom.get("goType");
            
        switch (goType) 
        {
            case "Player":
                state.player = new Protagonist(x, y);
                state.player.Initial();
                state.add(state.player);
                FlxG.camera.follow(state.player, FlxCamera.STYLE_PLATFORMER);
                
            case "Monster_1":
                var monster:Monster_01 = new Monster_01(x, y);
                monster.Initial();
                state.add(monster);
                overlapableObjects.add(monster);
                
            case "Boss":
                state.boss = new Boss(x, y);
                state.boss.Initial();
                overlapableObjects.add(state.boss);
                
            case "Spike":
                var spike:Spike = new Spike(x, y);
                spike.Initial();
                spike.angle = o.angle;
                overlapableObjects.add(spike);
                
            case "DestroyableWall":
                var wall:DestroyableWall = new DestroyableWall(x, y);
                wall.Initial();
                //overlapableTiles.add(wall);
                collidableObjects.add(wall);
                
            case "Launcher":
                var launcher:Launcher = new Launcher(x, y);
                launcher.SetDirection(o.custom.get("direction"));
                launcher.SetFireDelay(Std.parseFloat(o.custom.get("delay")));
                launcher.Initial();
                state.add(launcher);                
                
            case "CheckPoint":
                var checkPoint:CheckPoint = new CheckPoint(x, y);
                checkPoint.Initial();
                checkPoint.width = o.width;
                checkPoint.height = o.height;
                overlapableObjects.add(checkPoint);
                
            case "DeadZone":
                var deadZone:DeadZone = new DeadZone(x, y);
                deadZone.Initial();
                deadZone.width = o.width;
                deadZone.height = o.height;
                overlapableObjects.add(deadZone);
                
            default:
                trace("unknown goType: " + goType);
        }
	}
	
    public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers == null)
		{
            return false;
        }
        
        for (map in collidableTileLayers)
        {
            // IMPORTANT: Always collide the map with objects, not the other way around. 
            //			  This prevents odd collision errors (collision separation code off by 1 px).
            return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
        }
        
		return false;
	}
    
    public function CollideWithObjects(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableObjects == null)
		{
            return false;
        }
        
        return FlxG.overlap(collidableObjects, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
        
		return false;
	}
    
	public function OverlapWithObjects(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (overlapableObjects == null)
		{
            return false;
        }
        
        //return FlxG.overlap(overlapableTiles, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
        return FlxG.overlap(overlapableObjects, obj, notifyCallback);
        
		return false;
	}
}