package com.game.scene 
{
    import com.*;
    import com.ai.CPlayer;
    import com.ai.CTrigger;
    import com.ui.flash.CWheelUI;
    import flash.geom.Matrix;
    import flash.utils.Dictionary;
    import org.dame.CBaseLevel;
    import org.dame.LevelData;
    import org.dame.objects.BoxData;
    import org.dame.objects.ObjectLink;
    import org.dame.objects.TextData;
    import org.flixel.*;
    
	/* Complex Claws PlayState.as
	 * This sample code is intended to be used along with the flixelComplex exporter.
	 * */
	public class XmlState extends CBaseLevel
	{
		//private var ids:Dictionary = new Dictionary(true);
		
		private var player:CPlayer;
		//private var camera:FlxCamera;
		public static var text:FlxText;
		
        private var cWheelUI:CWheelUI = new CWheelUI();
        
		public function XmlState():void
		{
			super();
			//ImageBank.Initialize();
            FlxG.mouse.show();
		}
		
		override public function create():void
		{
            super.create();
            
			text = new FlxText(30, 43, 300,"Loading...");
			add(layerStage);
			add(text);
			//camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			//FlxG.resetCameras(camera);
			isLoadingLevel = true;
			currentLevel = new LevelData();
			currentLevel.LoadMap("xmlSample/Level_Area1.xml", OnObjectAddedCallback, 
                                 LevelLoadedComplete);
			levels.push(currentLevel);
            
            cWheelUI.Create(10);
            cWheelUI.Render(2);
		}
		
		private function LevelLoadedComplete( level:LevelData ):void
		{
			//FlxG.bgColor = currentLevel.bgColor;
            //cameras.
			FlxG.camera.setBounds(currentLevel.boundsMin.x + 1, 
                                  currentLevel.boundsMin.y + 1, 
                                  currentLevel.boundsMax.x - currentLevel.boundsMin.x, 
                                  currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
			layerStage.add(level);
			isLoadingLevel = false;
		}
		
		override public function update():void
		{
            if (isLoadingLevel == true)
            {
                return;
            }
            
            super.update();
			
			if ( !player )
			{
				return;
			}
			
            // map collisions			
            FlxG.collide(player, currentLevel.collideGroup);
            FlxG.collide(currentLevel.collidingSpritesGroup, currentLevel.collideGroup);
            
            //player-object collisions
            FlxG.overlap(player, currentLevel.overlapGroup, PlayerOverlap );

			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new XmlState() );
			}
		}
		
        override public function draw():void 
        {
            super.draw();
            
            var m:Matrix = new Matrix();
            m.translate(FlxG.width/2, FlxG.height/2);
            FlxG.camera.buffer.draw(cWheelUI,m);
        }
        
		private function TriggerEntered( plr:FlxSprite, cTrigger:CTrigger):void
		{			
            if (isLoadingLevel == true)
            {
                return;
            }
            
			if ( plr == player && 
				(cTrigger.moveDir == FlxObject.NONE || plr.facing == cTrigger.moveDir) )
			{
				LoadLevel( cTrigger.target );
			}
		}
		
		private function PlayerOverlap( plr:FlxSprite, obj:FlxSprite):void
		{
			if ( player == plr)
			{
				if ( obj is CTrigger )
				{
					TriggerEntered( plr, obj as CTrigger );
				}
				//else if ( obj is Coin )
				//{
					//obj.kill();
				//}
			}
		}
		
	}

}