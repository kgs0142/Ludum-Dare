package game.gameModule;

import flixel.FlxG;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import game.manager.AudioManager;
import game.manager.LevelManager;
import game.object.SpritePiece;

/**
 * ...
 * @author Husky
 */
class MenuModule extends FlxState
{
    private var titlePiece:SpritePiece;
    
    /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        this.bgColor = 0xAA393C32;
        
        this.titlePiece = new SpritePiece();
        this.titlePiece.puzzlePieceName = AssetPaths.TitleLock__png;
        this.titlePiece.solvePieceName = AssetPaths.TitleUnlock__png;
        
        if (LevelManager.Get().IsGameComplete() == false)
        {
            this.titlePiece.CreatePuzzlePieceProcess();
        }
        else 
        {
            this.titlePiece.CreateSolvePieceProcess();
        }
        
        this.add(titlePiece);
        
        
        var magnifier:SpritePiece = new SpritePiece(8*9, 8*20);
        magnifier.puzzlePieceName = AssetPaths.MagnifierLock__png;
        magnifier.solvePieceName = AssetPaths.MagnifierUnlock__png;
        if (LevelManager.Get().IsGameComplete() == false)
        {
            magnifier.CreatePuzzlePieceProcess();
        }
        else 
        {
            magnifier.CreateSolvePieceProcess();
        }
        
        this.add(magnifier);
        
        FlxTween.tween(magnifier, {puzzleScaleX: 0.5, puzzleScaleY: 0.5}, 1.0, {type: FlxTween.PINGPONG});
        
        LevelManager.Get().currentLevelIndex = 0;
        
        AudioManager.Get().MusicFadeInAndBGMFadeOut();
        
        FlxG.mouse.visible = true;
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        
        if (FlxG.mouse.justPressed)
        {
            //FlxG.switchState(new PlayModule());
            FlxG.switchState(new CutsceneModule());
            
            AudioManager.Get().PlaySound(AssetPaths.blip__wav, 0.3);
        }
	}
}