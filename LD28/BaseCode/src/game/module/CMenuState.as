package game.module 
{
    import com.brompton.component.system.BPLoader;
    import com.brompton.component.system.script.BPLuaManager;
    import com.brompton.entity.BPEntityManager;
    import com.brompton.system.CEntitySystem;
    import com.scene.CBaseScene;
    import com.scene.CSceneManager;
    import org.flixel.FlxEmitter;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxParticle;
    import org.flixel.FlxPath;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
	import org.flixel.FlxState;
    import org.flixel.plugin.photonstorm.FlxControl;
    import org.flixel.plugin.photonstorm.FlxControlHandler;
	
	/**
     * ...
     * @author Husky
     */
    public class CMenuState extends FlxState 
    {
        override public function create():void 
        {

            
        }
        
        override public function update():void 
        {
            super.update();
            
            BPEntityManager.Get().Update();
        }
    }
}