package org.dame 
{
    import com.ai.CPlayer;
    import com.ai.CTrigger;
    import org.dame.objects.BoxData;
    import org.dame.objects.ObjectLink;
    import org.dame.objects.TextData;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
     * The Base level of all the using levels inherit
     * @author Husky
     */
    public class CBaseLevel extends FlxState 
    {
        protected var currentLevel:LevelData;
		protected var lastLevel:LevelData;

		// List of all levels currently loaded
		public var levels:Vector.<LevelData>;

		protected var isLoadingLevel:Boolean;
		
		public var layerStage:FlxGroup;

        public function CBaseLevel() { }
        
        public override function create():void 
        {
            super.create();
            
            isLoadingLevel = false;
            layerStage = new FlxGroup();
            levels = Vector.<LevelData>([]);
        }
        
        protected function StartLevelLoaded(level:LevelData):void
		{
			//FlxG.bgColor = currentLevel.bgColor;
			//camera.setBounds(currentLevel.boundsMin.x + 1, 
                             //currentLevel.boundsMin.y + 1, 
                             //currentLevel.boundsMax.x - currentLevel.boundsMin.x, 
                             //currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
            FlxG.camera.setBounds(currentLevel.boundsMin.x + 1, 
                                  currentLevel.boundsMin.y + 1, 
                                  currentLevel.boundsMax.x - currentLevel.boundsMin.x, 
                                  currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
			layerStage.add(level);
			isLoadingLevel = false;
		}
        
		protected function FindLevelDataByName(levelName:String):LevelData
		{
			var i:int = levels.length;
			while (i--)
			{
				if ( levels[i].name == levelName )
				{
					return levels[i];
				}
			}
			return null;
		}
        
        //protected function MovePlayerToLevel(level:LevelData):void
		//{
			// reapply gravity and allow movement.
			//FlxG.paused = false;
			//if ( level["spritesGroup"] != null )
			//{
				//if ( currentLevel && currentLevel["spritesGroup"] != null )
				//{
					//var oldGroup:FlxGroup = currentLevel["spritesGroup"];
					//oldGroup.remove(player, true);
				//}
				//var newGroup:FlxGroup = level["spritesGroup"];
				//newGroup.add(player);
			//}
			//lastLevel = currentLevel;
			//currentLevel = level;
			//camera.setBounds(currentLevel.boundsMin.x, currentLevel.boundsMin.y, currentLevel.boundsMax.x - currentLevel.boundsMin.x, currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
		//}
        
        protected function LevelLoaded( level:LevelData, alreadyLoaded:Boolean = false ):void
		{
			if ( currentLevel ) 
			{
				currentLevel.fadeoff();
			}
			isLoadingLevel = false;
			if ( layerStage.members.indexOf(level) == -1 )
			{
				layerStage.add(level);
			}
            
			//MovePlayerToLevel(level);
            
			level.fadeon();
		}

		public function LoadLevel(name:String):void
		{
			try
			{
				var nextLevel:LevelData = FindLevelDataByName( name );
				if ( nextLevel )
				{
					// Move the player forward so that if the enter/exit CTriggers overlap the player
					// will be outside the one in the next level by the end of the transition.
					LevelLoaded(nextLevel, true);
				}
				else if( !nextLevel )
				{
					isLoadingLevel = true;
					nextLevel = new LevelData;
					var filename:String = "xmlSample/" + name + ".xml";
					FlxG.paused = true;
					nextLevel.LoadMap(filename, OnObjectAddedCallback, LevelLoaded);
					levels.push(nextLevel);
				}
			}
			catch ( error:Error)
			{
			}
		}
        
        //the fattest function here
        protected function OnObjectAddedCallback(obj:Object, layer:FlxGroup, level:LevelData, 
                                                 scrollX:Number, scrollY:Number, properties:Array):Object
		{
            //"id"? what's is it doing here?
			//if (properties)
			//{
				//var i:uint = properties.length;
				//while(i--)
				//{
					//if ( properties[i].name != "id" )
                    //{
                        //continue;
                    //}
                    //
                    //var name:String = properties[i].value;
                    //ids[name] = obj;
                    //break;
				//}
			//}
			
			//if (obj is CPlayer)
			//{
				//player = obj as CPlayer;
				//player.acceleration.y = 400;	// add some gravity.	
				//player.maxVelocity.y = 400;
				//camera.follow(player, FlxCamera.STYLE_LOCKON);
			//}
			//else 
            if ( obj is TextData )
			{
				var tData:TextData = obj as TextData;
				if ( tData.fontName != "" && tData.fontName != "system" )
				{
					tData.fontName += "Font";
				}
				return level.addTextToLayer(tData, layer, scrollX, scrollY, true, properties, OnObjectAddedCallback );
			}
			else if ( obj is BoxData )
			{
				// Create the CTrigger.
				var bData:BoxData = obj as BoxData;
				var cTrigger:CTrigger = new CTrigger(bData.x, bData.y, bData.width, bData.height);
				cTrigger.ParseProperties(properties);
				level.addSpriteToLayer(cTrigger, FlxSprite, layer, cTrigger.x, cTrigger.y, bData.angle, scrollX, scrollY);
				return cTrigger;
			}
			else if ( obj is ObjectLink )
			{
				var link:ObjectLink = obj as ObjectLink;
				var fromBox:CTrigger = link.fromObject as CTrigger;
				if ( fromBox )
				{
					fromBox.targetObject = link.toObject;
				}
			}
            
			return obj;
		}
    }
}