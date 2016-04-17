
this.bgColor = 0xAA393C32;

var imagRoot = "assets/images/Level_3rd/";

this.bgSpr = new FlxSprite();
this.bgSpr.loadGraphic(imagRoot + "LevelBG_003.png");

this.shadowSpr = new FlxSprite();
this.shadowSpr.x = 8*2;
this.shadowSpr.y = 8*2;
this.shadowSpr.loadGraphic(imagRoot + "Level_3rd_shadow.png");
this.shadowSpr.alpha = 0.8;

//puzzles------------------------------------------------------------
var spr1 = new SpritePiece();
spr1.puzzlePieceName = imagRoot + "Level_3rd_001.png";
spr1.solvePieceName = imagRoot + "Level_3rd_S001.png";

var spr2 = new SpritePiece();
spr2.puzzlePieceName = imagRoot + "Level_3rd_002.png";
spr2.solvePieceName = imagRoot + "Level_3rd_S002.png";

var spr3 = new SpritePiece();
spr3.puzzlePieceName = imagRoot + "Level_3rd_003.png";
spr3.solvePieceName = imagRoot + "Level_3rd_S003.png";

var spr4 = new SpritePiece();
spr4.puzzlePieceName = imagRoot + "Level_3rd_004.png";
spr4.solvePieceName = imagRoot + "Level_3rd_S004.png";

var spr5 = new SpritePiece();
spr5.puzzlePieceName = imagRoot + "Level_3rd_005.png";
spr5.solvePieceName = imagRoot + "Level_3rd_S005.png";

this.spritePieceArray.push(spr1);
this.spritePieceArray.push(spr2);
this.spritePieceArray.push(spr3);
this.spritePieceArray.push(spr4);
this.spritePieceArray.push(spr5);
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
    spr2.origin.set(50, 50);
    spr3.origin.set(0, 50);
    spr4.origin.set(160, 50);
    spr5.origin.set(0, 50);

    this.SetPuzzleValues(-0.2, 0.3, 120);
    //this.SetPuzzleValues(0, 0, 0);

    this.add(this.spritePieceGroup);

    //
    this.add(fg);
    this.add(glass);
}

function UpdateFunction(elapsed)
{



}