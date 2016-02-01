package husky.flixel.controller 
{
    import husky.flixel.MySprite;
    import org.flixel.FlxObject;
	/**
     * ...
     * @author Husky
     */
    public class BaseController extends FlxObject 
    {
        
        //public function BaseController() 
        public function BaseController() 
        {
        }
        
        public function Initial(obj:MySprite) : void
        {
            
        }
        
        public override function update():void 
        {
            super.update();
        }
        
        override public function destroy():void 
        {
            super.destroy();
        }
    }
}