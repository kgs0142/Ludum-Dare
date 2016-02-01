package game.test;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.plugin.MouseEventManager;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class TestCard extends FlxSprite
{
    private static inline var TURNING_TIME:Float = 0.2; 
    
    private var _turned:Bool;
    private var _cardIndex:Int;
    
    //mouse event related
    private var _pressed:Bool;
    private var _clickRelatedPos:FlxPoint;
    
    public function new(X:Float, Y:Float, useCardGraphic:Bool = true) 
    {
        super(X, Y);
        
        if (useCardGraphic == true)
        {
            this.loadGraphic("assets/images/Deck.png", true, 123, 123);
        }
		
        this._pressed = false;
        
        this._turned = false;
		// The card starts out being turned around
		this.animation.frameIndex = 54;

        //Assign a rnd index.
        this._cardIndex = Std.random(53) + 1;
        
        //NOTE HERE
        //If you will have multiple cameras, you need to make sure which one is going to render your FlxObject, 
        //it might be unharmed in most situations, but in this case, becasue we will add mouse events, that need to calcuate by cameras
        //if you didn't do something, it might cause bugs you don't want.
        this.camera = FlxG.camera;
        this.cameras = [FlxG.camera];
        //
        
        
		// Setup the mouse events
        //MouseEventManager.add(object, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
		MouseEventManager.add(this, OnMouseDown, onMouseUp, OnMouseOver, onMouseOut, false);
    }
    
    private function OnMouseDown(Sprite:FlxSprite)
	{
		// Play the turning animation if the card hasn't been turned around yet
		if (this._turned == false)
		{
			this._turned = true;
            
			FlxTween.tween(scale, { x: 0 }, TURNING_TIME / 2, { complete: DoPickCard });
		}
        
        //cutom variable for handling the press event.
        this._pressed = true;
        this._clickRelatedPos = FlxG.mouse.getWorldPosition();
        this._clickRelatedPos.x -= this.x;
        this._clickRelatedPos.y -= this.y;
	}
	
    private function onMouseUp(Sprite:FlxSprite)
	{
        this._pressed = false;
	}
    
	private function OnMouseOver(Sprite:FlxSprite) 
	{
		color = 0x00FF00;
	}
	
    private function onMouseOut(Sprite:FlxSprite)
	{
		color = FlxColor.WHITE;
	}
    
    private function OnMousePressed():Void 
    {
        this.setPosition(FlxG.mouse.x - this._clickRelatedPos.x, FlxG.mouse.y - this._clickRelatedPos.y);
    }
    
    private function DoPickCard(Tween:FlxTween):Void
    {
		animation.frameIndex = this._cardIndex;
		
		// Finish the card animation
		FlxTween.tween(scale, { x: 1 }, TURNING_TIME / 2);
    }
    
    public override function update():Void 
    {
        super.update();
        
        if (this._pressed == true)
        {
            this.OnMousePressed();
        }
        
        //if (FlxG.mouse.justReleased ==  true)
        //{
            //this._pressed = false;
        //}
    }
    
    public override function destroy():Void 
    {
        super.destroy();
    }
}