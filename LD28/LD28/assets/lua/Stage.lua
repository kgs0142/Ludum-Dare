local FlxG = as3.class.org.flixel.FlxG;
local TweenLite = as3.class.com.greensock.TweenLite;
local MySaves = as3.class.game.scene.MySaves;
local GamePlayModule = as3.class.game.module.GamePlayModule;
local SceneMgr = as3.class.game.scene.CSceneManager.Get();

--Menu ingame
function lua_play_menu_ingame()
    menuModule.btnNewGame.visible = false;
    menuModule.btnContinue.visible = false;

    TweenLite.to(menuModule.sprTitle, 1.5, as3.toobject(
    {
       alpha = 0,
       onComplete = lua_menu_ingame_001
    }));
end

function lua_menu_ingame_001()
    TweenLite.to(menuModule.sprBall, 0.5, as3.toobject(
    {
       alpha = 1,
       onComplete = lua_menu_ingame_002
    }));
end

function lua_menu_ingame_002()
    menuModule.littleBoy.play("play");

    TweenLite.delayedCall(0.5, lua_menu_ingame_003);
end

function lua_menu_ingame_003()
    menuModule.enemy.visible = true;
    menuModule.enemy.facing = 0x0001;

    TweenLite.to(menuModule.enemy, 1.0, as3.toobject(
    {
       x = as3.tolua(menuModule.littleBoy.x) + 10,
       onComplete = lua_menu_ingame_004
    }));
end

function lua_menu_ingame_004()
    menuModule.littleBoy.acceleration.y = 0;
    menuModule.littleBoy.x = as3.tolua(menuModule.enemy.x) + 2;
    menuModule.littleBoy.y = as3.tolua(menuModule.enemy.y) - 10;
    menuModule.littleBoy.play("kidnap");

    TweenLite.delayedCall(2.0, lua_menu_ingame_005);
end

function lua_menu_ingame_005()
    menuModule.enemy.facing = 0x0010;
    TweenLite.to(menuModule.enemy, 1.0, as3.toobject(
    {
       x = as3.tolua(menuModule.littleBoy.x) + 200
    }));

    TweenLite.to(menuModule.littleBoy, 1.0, as3.toobject(
    {
       x = as3.tolua(menuModule.littleBoy.x) + 200,
       onComplete = lua_menu_ingame_006
    }));
end

function lua_menu_ingame_006()
    menuModule.player.visible = true;
    menuModule.player.velocity.y = -100;

    TweenLite.delayedCall(1.0, lua_menu_ingame_007);
end

function lua_menu_ingame_007()
    TweenLite.to(menuModule.player, 1.0, as3.toobject(
    {
       x = as3.tolua(menuModule.sprBall.x),
       onComplete = lua_menu_ingame_008
    }));
end

function lua_menu_ingame_008()
    menuModule.player.velocity.y = -100;
    FlxG.fade(0xFF000000, 0.5, lua_menu_ingame_009);
end

--go to first level
function lua_menu_ingame_009()
    MySaves.levels = "Level_First_Stage";
    MySaves.checkPoint = "default_spawn_point";

    FlxG.switchState(GamePlayModule.new());
end
-----------------------------------------------------------------------------------------









