package game.module 
{
    import com.greensock.TweenLite;
    import nc.component.system.script.NcLuaManager;
    import nc.system.NcSystems;
    import org.flixel.FlxG;
    import org.flixel.FlxText;
	/**
     * ...
     * @author Husky
     */
    public class EndModule extends MenuModule 
    {
        protected override function AfterCreateScene():void 
        {
            super.AfterCreateScene();
            
            btnContinue.visible = false;
            btnNewGame.visible = false;
            
            m_Player.x += 30;
            m_Player.visible = true;
            
            littleBoy.x -= 20;
            littleBoy.play("play");
            
            sprBall.x -= 24;
            sprBall.alpha = 1;
            
            var flxText:FlxText = new FlxText(70, 140, 200, "Thanks for playing! :)");
            flxText.scrollFactor.x = flxText.scrollFactor.y = 0;
            this.add(flxText);
            
            var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
            luaMgr.SetGlobal("endModule", this);
            
            TweenLite.delayedCall(15, function () : void
            {
                FlxG.switchState(new MenuModule());
            });
        }
    }
}