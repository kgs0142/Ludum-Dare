
this.bgColor = 0xAA393C32;

var imagRoot = "assets/images/Level_2nd/";

this.bgSpr = new FlxSprite();
this.bgSpr.loadGraphic(imagRoot + "LevelBG_002.png");

this.shadowSpr = new FlxSprite();
this.shadowSpr.x = 8*2;
this.shadowSpr.y = 8*2;
this.shadowSpr.loadGraphic(imagRoot + "Level_2nd_shadow.png");
this.shadowSpr.alpha = 0.8;

//puzzles------------------------------------------------------------
var spr1 = new SpritePiece();
spr1.puzzlePieceName = imagRoot + "Level_2nd_001.png";
spr1.solvePieceName = imagRoot + "Level_2nd_S001.png";

var spr2 = new SpritePiece();
spr2.puzzlePieceName = imagRoot + "Level_2nd_002.png";
spr2.solvePieceName = imagRoot + "Level_2nd_S002.png";

this.spritePieceArray.push(spr1);
this.spritePieceArray.push(spr2);
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
    //trace("level test created");

    this.add(this.bgSpr);
    this.add(this.shadowSpr);

    //
    this.spritePieceGroup.setPosition(8*2, 8*2);

    this.CreatePuzzlePieces();
    this.AddPiecesToGroup();

    spr1.origin.set(100, 50);
    spr2.origin.set(200, 50);

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