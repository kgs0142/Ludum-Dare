local FlxG = as3.class.org.flixel.FlxG;
local SceneMgr = as3.class.game.scene.CSceneManager.Get();
local Controllers = as3.class.game.controller.Controllers;
local FlxControl = as3.class.org.flixel.plugin.photonstorm.FlxControl;
local EndModule = as3.class.game.module.EndModule;
local MySaves = as3.class.game.scene.MySaves;
local BlackGuy = as3.class.game.ai.BlackGuy;
local LittleBoy = as3.class.game.ai.LittleBoy;

local LEFT = 0x0001;

local RIGHT = 0x0010;

function lua_clear_dialog()
    if (DialogUI ~= nil) then
        DialogUI.Hide();
        DialogUI.SetDialogText("");
    end
end

function lua_e001( )
    DialogUI.SetDialogText("You can move by pressing 'A' and 'D', jump with'W', 'R' to reset.");
    DialogUI.Show();
end

function lua_e002( )
    DialogUI.SetDialogText("If you energy is enough, you can press 'A' or 'D' twice to dash.");
    DialogUI.Show();
end

function lua_e003( )
    DialogUI.SetDialogText("You only get one ball as weapon, click to throw, and don't forget to get it back!");
    DialogUI.Show();
end

--test spawn enemy
function lua_e004( )
    local enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;

    trigger.AddEnemyOnTargetLoc(enemy);
end

function lua_e005( )
    DialogUI.SetDialogText("Catch the ball on fly will add combo, when combo is enough the ultimate is ready!");
    DialogUI.Show();
end

--test spawn enemy
function lua_e006( )
    local enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.facing = LEFT;

    trigger.AddEnemyOnTargetLoc(enemy);
end

function lua_first_stage_clear()
    FlxG.fade(0xFF000000, 0.5, lua_goto_next_stage_001)
end

function lua_goto_next_stage_001()
    MySaves.levels = "Level_Second_Stage";
    MySaves.checkPoint = "default_spawn_point";

    FlxG.resetState();
end

----------------------------------------------------------------------------------------------
--spawn enemy
function lua_e007()
    local enemy = BlackGuy.new();
    enemy.facing = LEFT;
    enemy.SetHp(1);
    enemy.SetController(Controllers.CreateController("ChasePlayerController"));
    trigger.AddEnemyOnTargetLoc(enemy);
end

--spawn enemy
function lua_e008()
    local enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy, 0, -20);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy, 0, -40);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy, 0, -60);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy, 0, -80);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    trigger.AddEnemyOnTargetLoc(enemy, 0, -100);
end

--spawn enemy
function lua_e009()
    local enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);
end

--spawn enemy
function lua_e010()
    local enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 20, 0);
end

--spawn enemy
function lua_e011()
    local enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, -20, 0);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, -40, 0);

    enemy = BlackGuy.new();
    enemy.SetHp(1);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, -60, 0);
end

--spawn enemy
function lua_e012()
    local enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);
end


--spawn enemy
function lua_e013()
    local enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.facing = LEFT;
    enemy.acceleration.x = 0;
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("ChaseAndAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, -50);
end

function lua_second_stage_clear()
    FlxG.fade(0xFF000000, 0.5, lua_goto_next_stage_002)
end

function lua_goto_next_stage_002()
    MySaves.levels = "Level_Third_Stage";
    MySaves.checkPoint = "default_spawn_point";

    FlxG.resetState();
end

-----------------------------------------------------------------------------------------

--spawn enemy
function lua_e014()
    local enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 20);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 40);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 60);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 80);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 100);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 120);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 140);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 160);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 180);

    enemy = BlackGuy.new();
    enemy.SetHp(10);
    enemy.color = 0xDB0606;
    enemy.SetController(Controllers.CreateController("IdleAttackController"));
    trigger.AddEnemyOnTargetLoc(enemy, 200);
end

--spawn little boy
function lua_e015()
    local littleBoy = LittleBoy.new();
    littleBoy.play("onChair");
    trigger.AddEnemyOnTargetLoc(littleBoy);
end

function lua_save_boss_spawn_point( )
    MySaves.checkPoint = "boss_spawn_point";
end

function lua_e016()
    trigger.AddWallOnLoc();
end

--Add Boss
function lua_e017()
    local boss = BlackGuy.new();

    boss.SetHp(30);
    --boss.SetHp(1);
    --test

    boss.scale.x = 6;
    boss.scale.y = 3;
    boss.width = 40;
    boss.height = 46;
    boss.offset.x = -20;
    boss.offset.y = -15;
    boss.acceleration.y = 200;

    gamePlayModule.SetChaseTargetToDie(boss, lua_kill_boss_ingame);

    gamePlayModule.PlayBossMusic();

    boss.SetController(Controllers.CreateController("BossJumpAttackController"));
    trigger.AddEnemyOnTargetLoc(boss);
end

function lua_kill_boss_ingame()
    gamePlayModule.player.bLockControl = true;
    gamePlayModule.CameraFlash(as3.tolua(0xFFFFFF), 0.2, lua_kill_boss_ingame_001);
end

function lua_kill_boss_ingame_001()
    gamePlayModule.CameraFlash(as3.tolua(0xFFFFFF), 0.2, lua_kill_boss_ingame_002);
end

function lua_kill_boss_ingame_002()
    gamePlayModule.CameraFlash(as3.tolua(0xFFFFFF), 0.2, lua_kill_boss_ingame_003);
end

function lua_kill_boss_ingame_003()
    FlxG.fade(0xFF000000, 1.0, lua_kill_boss_ingame_004)
end

function lua_kill_boss_ingame_004()
    FlxG.switchState(EndModule.new());
end



