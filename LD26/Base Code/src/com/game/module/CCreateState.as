package com.game.module 
{
    import com.brompton.component.system.BPLoader;
    import com.brompton.component.system.script.BPLuaManager;
    import com.brompton.entity.BPEntityManager;
    import com.brompton.system.CEntitySystem;
    import com.greensock.TweenLite;
    import com.scene.CBaseScene;
    import com.scene.CSceneManager;
    import flash.display.BlendMode;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
	import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	/**
     * ...
     * @author Husky
     */
    public class CCreateState extends FlxState 
    {
        
        public function CCreateState() 
        {
            
        }
        
        [Embed(source="../../../../assets/PlayerAnim.PNG")]
        private const TEST_PIC:Class;
        
        public override function create():void 
        {
            FlxG.bgColor = 0XFF222222;
            
            var gSpr:FlxGroup = new FlxGroup();
            var gUI:FlxGroup = new FlxGroup();
            //Test the dialog box
            //Use a FlxGroup to store
            //var sprDialog:FlxSprite = new FlxSprite(0, 150);
            //sprDialog.makeGraphic(FlxG.width, FlxG.height - sprDialog.y, 0XDD333333);
            //var tfDialog:FlxText = new FlxText(0 + 25, 150 + 10, FlxG.width - 50);
            //tfDialog.text = "BaraBara";

            //InputDialog([...,...])
            //ClearDialog
            //ShowDialog()  -> DialogNext event, DialogOver event
            
            //
            //
            //gUI.add(sprDialog);
            //gUI.add(tfDialog);
            //
            //--------------------------------------------------
            //Test bevel pixel
            gSpr.add(new FlxSprite(50, 50));
            gSpr.add(new FlxSprite(10, 70));
            gSpr.add(new FlxSprite(70, 0, TEST_PIC));
            
            
            var a:FlxSprite = new FlxSprite(10, 10);
            a.blend = BlendMode.SUBTRACT;
            
            var b:FlxSprite = new FlxSprite(10, 10);
            b.makeGraphic(24, 24);
            
            gSpr.add(b);
            gSpr.add(a);
            
            var sprBevel:SprBevelScreen = new SprBevelScreen();
            sprBevel.Create();
            gSpr.add(sprBevel);
            
            this.add(gSpr);
            this.add(gUI);
            
            return;
            
            
            
            
            
            
            
            BPEntityManager.Get().Create();
            
            CEntitySystem.Get().AddComponents
            (
                new BPLoader(),
                new BPLuaManager()
            );
            
            var loader:BPLoader = CEntitySystem.Get().GetComponent(BPLoader) as BPLoader;
            loader.PushAssetToLoad("assets/lua/Monster.lua");
            
            loader.PushAssetToLoad("assets/scene/Level_First.xml");
            loader.PushAssetToLoad("assets/scene/mapCSV_First_Backgrpund.csv");
            loader.PushAssetToLoad("assets/scene/mapCSV_First_Main.csv");
            loader.PushAssetToLoad("assets/TileTest002.png");
            loader.PushAssetToLoad("assets/TileSet003.png");
            
            loader.StartLoad(this.LoadAllAssetComplete);
        }
        
        private function LoadAllAssetComplete() : void
        {
            CSceneManager.Get().Initial();
            CSceneManager.Get().CreateScene("Level_First", this.CreateSceneComplete);
        }
        
        private function CreateSceneComplete(cScene:CBaseScene) : void
        {
            trace("Create scene complete");
            
            this.add(cScene);
        }
        
        override public function update():void 
        {
            super.update();
            
            BPEntityManager.Get().Update();
        }
    }

}