
this.bgColor = 0xFF88d7e7;

var imagRoot = "assets/images/Sprite-0001/";

var shadow = new FlxSprite();
shadow.x = 8*2;
shadow.y = 8*2;
shadow.loadGraphic(imagRoot + "Sprite-0001_shadow.png");
shadow.alpha = 0.5;

//puzzles------------------------------------------------------------
var spr1 = new SpritePiece();
spr1.puzzlePieceName = imagRoot + "Sprite-0001_1.png";
spr1.solvePieceName = imagRoot + "Sprite-0001_S1.png";
spr1.puzzleScaleXFactor = 1.1;

var spr2 = new SpritePiece();
spr2.puzzlePieceName = imagRoot + "Sprite-0001_2.png";
spr2.solvePieceName = imagRoot + "Sprite-0001_S2.png";
spr2.puzzleScaleYFactor = 1.1;

var spr3 = new SpritePiece();
spr3.puzzlePieceName = imagRoot + "Sprite-0001_3.png";
spr3.solvePieceName = imagRoot + "Sprite-0001_S3.png";

this.spritePieceArray.push(spr1);
this.spritePieceArray.push(spr2);
this.spritePieceArray.push(spr3);
//-------------------------------------------------------------------


var fg = new FlxSprite();
fg.setPosition(8*2, 8*2);
fg.makeGraphic(128, 128, 0x11222222);

var glass = new FlxSprite();
glass.x = 8*2;
glass.y = 8*2;
//glass.makeGraphic(128, 128, 0x55000000);
glass.loadGraphic("assets/images/Frame.png");
glass.blend = "screen";

function CreateFunction()
{
    trace("level test created");

    this.add(shadow);

    //
    this.spritePieceGroup.setPosition(8*2, 8*2);

    this.CreatePuzzlePieces();
    this.AddPiecesToGroup();

    spr1.origin.set(100, 50);
    spr2.origin.set(50, 50);
    spr3.origin.set(-50, 50);

    this.SetPuzzleValues(1.1, 1.5, 90);
    //this.SetPuzzleValues(0, 0, 0);

    this.add(this.spritePieceGroup);

    //
    this.add(fg);
    this.add(glass);


}

function UpdateFunction(elapsed)
{



}