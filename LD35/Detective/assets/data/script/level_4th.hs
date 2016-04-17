
this.bgColor = 0xAA393C32;

var imagRoot = "assets/images/Level_4th/";

this.bgSpr = new FlxSprite();
this.bgSpr.loadGraphic(imagRoot + "LevelBG_004.png");

this.shadowSpr = new FlxSprite();
this.shadowSpr.x = 8*2;
this.shadowSpr.y = 8*2;
this.shadowSpr.loadGraphic(imagRoot + "Level_4th_shadow.png");
this.shadowSpr.alpha = 0.5;

//puzzles------------------------------------------------------------
var spr1 = new SpritePiece();
spr1.puzzlePieceName = imagRoot + "Level_4th_001.png";
spr1.solvePieceName = imagRoot + "Level_4th_S001.png";

var spr2 = new SpritePiece();
spr2.puzzlePieceName = imagRoot + "Level_4th_002.png";
spr2.solvePieceName = imagRoot + "Level_4th_S002.png";

var spr3 = new SpritePiece();
spr3.puzzlePieceName = imagRoot + "Level_4th_003.png";
spr3.solvePieceName = imagRoot + "Level_4th_S003.png";

var spr4 = new SpritePiece();
spr4.puzzlePieceName = imagRoot + "Level_4th_004.png";
spr4.solvePieceName = imagRoot + "Level_4th_S004.png";

var spr5 = new SpritePiece();
spr5.puzzlePieceName = imagRoot + "Level_4th_005.png";
spr5.solvePieceName = imagRoot + "Level_4th_S005.png";

var spr6 = new SpritePiece();
spr6.puzzlePieceName = imagRoot + "Level_4th_006.png";
spr6.solvePieceName = imagRoot + "Level_4th_S006.png";

var spr7 = new SpritePiece();
spr7.puzzlePieceName = imagRoot + "Level_4th_007.png";
spr7.solvePieceName = imagRoot + "Level_4th_S007.png";

var spr8 = new SpritePiece();
spr8.puzzlePieceName = imagRoot + "Level_4th_008.png";
spr8.solvePieceName = imagRoot + "Level_4th_S008.png";

var spr9 = new SpritePiece();
spr9.puzzlePieceName = imagRoot + "Level_4th_009.png";
spr9.solvePieceName = imagRoot + "Level_4th_S009.png";

this.spritePieceArray.push(spr1);
this.spritePieceArray.push(spr2);
this.spritePieceArray.push(spr3);
this.spritePieceArray.push(spr4);
this.spritePieceArray.push(spr5);
this.spritePieceArray.push(spr6);
this.spritePieceArray.push(spr7);
this.spritePieceArray.push(spr8);
this.spritePieceArray.push(spr9);
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
    spr3.origin.set(50, 50);
    spr4.origin.set(50, 50);
    spr5.origin.set(300, 50);
    spr6.origin.set(50, 200);
    spr7.origin.set(50, 50);
    spr8.origin.set(50, 50);
    spr9.origin.set(230, 50);

    this.SetPuzzleValues(-1.1, 1.5, -90);
    //this.SetPuzzleValues(0, 0, 0);

    this.add(this.spritePieceGroup);

    //
    this.add(fg);
    this.add(glass);
}

function UpdateFunction(elapsed)
{



}