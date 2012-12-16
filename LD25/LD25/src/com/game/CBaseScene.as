package com.game 
{
    import adobe.utils.CustomActions;
    import com.ai.CBaseAI;
    import com.ai.CEnemy;
    import com.ai.CPlayer;
    import com.ai.CTrigger;
    import com.ai.CIAObject;
    import com.global.CAssetDefine;
    import com.system.CAssetLoader;
    import com.system.CLuaManager;
    import com.system.CSceneManager;
    import com.util.CBitFlag;
    import event.CAssetEvent;
    import flash.events.Event;
    import flash.utils.Dictionary;
    import org.dame.LevelData;
    import org.dame.objects.BoxData;
    import org.dame.objects.ObjectLink;
    import org.dame.objects.TextData;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
	
	/**
     * The Base level of all the using levels inherit
     * @author Husky
     */
    public class CBaseScene extends FlxState 
    {
        protected var _currentLevel:LevelData;
		protected var lastLevel:LevelData;

		// List of all levels currently loaded
		public var levels:Vector.<LevelData>;

		protected var isLoadingLevel:Boolean;
		
		public var layerStage:FlxGroup;

        public var ids:Dictionary = new Dictionary(true);
        
        //player
        protected var m_player:CPlayer;
        
        public function CBaseScene() { }
        
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
        
        protected function LevelLoadedComplete( level:LevelData ):void
		{
            
        }
        
        //reload all the lua
        protected function ReloadLua() : void
        {
            //add ASSET_LOAD_COMPLETE Event
            CAssetLoader.Get().addEventListener(CAssetEvent.ASSET_LOAD_COMPLETE, 
                                                this.LoadCompleteHD);
            
            CAssetLoader.Get().LoadLua(CAssetDefine.GAME_PLAY_LUA_NAME,
                                       CAssetDefine.GAME_PLAY_LUA_PATH);
            CAssetLoader.Get().LoadLua(CAssetDefine.PLAYER_AI_LUA_NAME,
                                       CAssetDefine.PLAYER_AI_LUA_PATH);
            CAssetLoader.Get().LoadLua(CAssetDefine.EVENT_LUA_NAME,
                                       CAssetDefine.EVENT_LUA_PATH);
            CAssetLoader.Get().LoadLua(CAssetDefine.QTE_LUA_NAME,
                                       CAssetDefine.QTE_LUA_PATH);
        }
        
        protected function LoadCompleteHD(e:Event) : void
        {
            CAssetLoader.Get().removeEventListener(CAssetEvent.ASSET_LOAD_COMPLETE, 
                                                   this.LoadCompleteHD);
                                                   
            CLuaManager.Get().DoLuaString(CAssetDefine.GAME_PLAY_LUA_NAME);
            CLuaManager.Get().DoLuaString(CAssetDefine.PLAYER_AI_LUA_NAME);
            CLuaManager.Get().DoLuaString(CAssetDefine.EVENT_LUA_NAME);
            CLuaManager.Get().DoLuaString(CAssetDefine.QTE_LUA_NAME);
            
            //FIXME it's not all the case
            CSceneManager.Get().cTriggerFlag = new CBitFlag(4);
            
            FlxG.resetState();
        }
        
        //the fattest function here
        protected function OnObjectAddedCallback(obj:Object, layer:FlxGroup, level:LevelData, 
                                                 scrollX:Number, scrollY:Number, properties:Array):Object
		{
            //use for guid's dictionary
			if (properties)
			{
				var uiLength:uint = properties.length;
                
                for (var ui:uint = 0; ui < uiLength; ui++)
                {
                    if (properties[ui].name != "guid")
                    {
                        continue;
                    }
                    
                    var name:String = properties[ui].value;
                    ids[name] = obj;
                    break;
                }
			}
			
			if (obj is CPlayer)
			{
				m_player = obj as CPlayer;
                m_player.ParseProperties(properties);
			}
			else if (obj is CEnemy)
            {
                trace("Create enemy");
                (obj as CBaseAI).ParseProperties(properties);
            }
            else if (obj is CIAObject)
            {
                (obj as CBaseAI).ParseProperties(properties);
            }
            else if ( obj is TextData )
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
				
                level.addSpriteToLayer(cTrigger, FlxSprite, layer, cTrigger.x, 
                                       cTrigger.y, bData.angle, scrollX, scrollY);
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
        
        public function get player() : CPlayer { return m_player; }
        
        public function get currentLevel():LevelData 
        {
            return _currentLevel;
        }
        
        public function set currentLevel(value:LevelData):void 
        {
            _currentLevel = value;
        }
    }
}