package game.object;

import flixel.FlxSprite;

/**
 * ...
 * @author Husky
 */
class SpritePiece extends FlxSprite
{
    public var puzzlePieceName:String;
    public var solvePieceName:String;
    
    //remember to set "origin";
    
    public var puzzleScaleX:Float = 0;
    public var puzzleScaleY:Float = 0;
    public var puzzleAngle:Float = 0;
    
    public var puzzleScaleXFactor:Float = 0;
    public var puzzleScaleYFactor:Float = 0;
    public var puzzleAngleFactor:Float = 0;
    
    public function new(?X:Float = 0, ?Y:Float = 0)
    {
        super(X, Y);
    }
    
    public function ClearPuzzle():Void 
    {
        this.puzzleScaleX = 0;
        this.puzzleScaleY = 0;
        this.puzzleAngle = 0;
        this.puzzleScaleXFactor = 0;
        this.puzzleScaleYFactor = 0;
        this.puzzleAngleFactor = 0;
        
        this.scale.set(1, 1);
        this.angle = 0;
    }
    
    public function CreatePuzzlePieceProcess():Void 
    {
        this.ClearPuzzle();
        
        this.loadGraphic(puzzlePieceName);
    }
    
    public function CreateSolvePieceProcess():Void 
    {
        this.ClearPuzzle();
        
        this.loadGraphic(solvePieceName);
    }
    
    override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);
        
        this.angle = puzzleAngle + puzzleAngleFactor;
        this.scale.set(1 + puzzleScaleX + puzzleScaleXFactor, 1 + puzzleScaleY + puzzleScaleYFactor);
    }
}