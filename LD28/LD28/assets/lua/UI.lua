function InitialHpBar()
    HpBar.SetHpBarStartPoint(10, 3);
    HpBar.SetHpBarGap(1);
end

function InitialEnBar()
    EnBar.InitialEnBar(14, 20, 0x33C633);
end

function InitialDialogUI()
    DialogUI.InitialBG(75, 10);
    DialogUI.InitialSpinBone(170, 55);
    DialogUI.InitialDialogText(81, 14, 100, 100, 0x272822);
end

function InitialComboUI()
    ComboUI.InitialComboUI(178, 145, 0x272822);
end