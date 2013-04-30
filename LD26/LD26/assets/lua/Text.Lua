local uiMgr = as3.class.com.game.CUIManager.Get();

--ShowText(sText:String, bFadeOut:Boolean, nDelayShow:Number = 0.0, 
--         nFadeInTime:Number = 0.0, nFadeOutTime:Number = 0.0, 
--         nDuration:Number = 0.0, fnStart:Function = null,
--         fnComplete:Function = null) : void

function Menu_Prologue()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n                          ''Pieces''", 
                   true, 0.5, 2.5, 2.5, 1.5, nil, Menu_PrologueComplete);
end

function Menu_PrologueComplete()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n\n\n               Click the door.", 
                   false, 0.0, 1.5, 0.5, 1.5, nil, nil);
end
----------------------------------------------------------------------------------------------

function Stage1_Prologue()
    --this.SetStopUpdate(true);

    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n      ''I always forget where my key is.''",
                    true, 0.25, 1.0, 1.0, 1.5, nil, Stage1_Text1);
end

function Stage1_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n                ''She will always find it.''",
                    false, 0.25, 1.0, 1.0, 1.0, nil, Stage1_Prologue_ShowUI_Callback);
end

function Stage1_Prologue_ShowUI_Callback()
    --this.SetStopUpdate(false);

    this.AddLeftMouseUITip(50, 30, 2.5);
end

-----------------------------------------------------------------------------------------------
function Stage2_Prologue()
    --this.SetStopUpdate(true);

    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n           ''When she was gone.''",
                    true, 0.25, 1.0, 1.0, 1.5, nil, Stage2_Text1);
end

function Stage2_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n           ''My time was stop passing...''",
                    false, 0.25, 1.0, 1.0, 1.5, nil, nil);
end

function Stage2_Prologue_ShowUI_Callback()
    --this.SetStopUpdate(false);
    this.AddRightMouseUITip(30, 30, 2.5);
end

-----------------------------------------------------------------------------------------------
function Stage3_Prologue()
    --this.SetStopUpdate(true);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n           ''I am so tired of life.''", 
                    true, 0.25, 1.0, 1.0, 1.5, nil, Stage3_Text1);
end

function Stage3_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It's tired to keep finding where she is.''", 
                    true, 0.25, 1.0, 1.0, 1.5, nil, Stage3_Text2);
end

function Stage3_Text2()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I am angry about her.''", 
                    false, 0.25, 1.0, 1.0, 1.5, nil, nil);
end

function Stage3_Prologue_ShowUI_Callback()
    --this.SetStopUpdate(false);
    this.AddMiddleMouseUITip(60, 30, 2.5);
end
-----------------------------------------------------------------------------------------------
function Stage4_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I make a doll.''", 
                    true, 0.0, 1.0, 1.0, 1.0, nil, Stage4_Text1)
end

function Stage4_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It has her cute round face.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage4_Text2);
end

function Stage4_Text2()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It has her brown hair.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage4_Text3);
end

function Stage4_Text3()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It has her pink color of cloth.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage4_Text4);
end

function Stage4_Text4()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It has her slender limbs.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage4_Text5);
end

function Stage4_Text5()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''It has her logy expression.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage4_Text6);
end

function Stage4_Text6()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I miss her.''", 
                    false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end

-----------------------------------------------------------------------------------------------
function Stage5_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''My heart is broken.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end

function Stage5_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I can never fix it up.''",
                     true, 0.25, 0.5, 2.5, 1.0, nil, Stage5_Text2);
end

function Stage5_Text2()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I'd rather empty it.''", 
                    false, 0.25, 1.5, 0.5, 1.0, nil, nil);
end

function Stage5_Text3()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''That's good.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage5_Text4);
end

function Stage5_Text4()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I like it.''", 
                    true, 0.25, 0.5, 0.5, 1.0, nil, Stage5_Text5);
end

function Stage5_Text5()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I like it... ....''", 
                    false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end
-----------------------------------------------------------------------------------------------
function Ending_Prologue()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n                    ''I am so lonly...''", 
                   true, 0.5, 2.5, 2.5, 5.5, nil, Ending_Text1);
end

function Ending_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n\n\n\n\n\n                            ''Thanks for playing : ).''", 
                   false, 0.5, 2.5, 2.5, 5.5, nil, nil);
end

--POST COMPO
----------------------------------------------------------------------------------------

function Stage6_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''She loves cats and dogs.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, Stage6_Text1);
end

function Stage6_Text1()
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''Where is the key?''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end

function Stage6_Text2()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I hate animals.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end

----------------------------------------------------------------------------------------
function Stage7_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''Life is always full of many obstacles.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, Stage7_Prologue_ShowUI_Callback);
end

function Stage7_Prologue_ShowUI_Callback()
    --this.SetStopUpdate(false);
    this.AddMiddleMouseUITip(60, 30, 2.5);
end

----------------------------------------------------------------------------------------
function Stage8_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''What time is it?''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, Stage8_Prologue_ShowUI_Callback);
end

function Stage8_Prologue_ShowUI_Callback()
    --this.SetStopUpdate(false);
    this.AddRightMouseUITip(30, 30, 2.5);
end
----------------------------------------------------------------------------------------
function Stage9_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I like paper cuts and tailor.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end
----------------------------------------------------------------------------------------
function Stage10_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I have hallucinations sometimes.''",
                     true, 0.25, 0.5, 0.5, 1.5, nil, Stage10_Text1);
end

function Stage10_Text1()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I'm not sure what is true.''",
                     false, 0.25, 0.5, 0.5, 1.0, nil, nil);
end

----------------------------------------------------------------------------------------
function Stage11_Prologue()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''The body of spider look like her cloth.''",
                     true, 0.25, 0.5, 0.5, 1.5, nil, Stage11_Text1);
end

function Stage11_Text1()
    --this.SetStopUpdate(true);
    --this.SetStopUpdate(false);
    uiMgr.ClearText();
    uiMgr.ShowText("\n\n\n  ''I hate spiders.''",
                     false, 0.25, 2.5, 0.5, 1.5, nil, nil);
end

