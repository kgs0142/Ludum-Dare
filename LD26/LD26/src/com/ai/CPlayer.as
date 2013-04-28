package com.ai 
{
    import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
     * ...
     * @author Husky
     */
    public class CPlayer extends FlxSprite 
    {
        
        public function CPlayer(nX:Number, nY:Number) 
		{
            this.x = nX;
            this.y = nY;

            this.acceleration = new FlxPoint(0, 80);
            this.maxVelocity = new FlxPoint(100, 150);
            this.drag = new FlxPoint(350, 350);
            //this.elasticity = 0;
        }
        
    }

}