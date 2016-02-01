package game.ui 
{
    import adobe.utils.CustomActions;
    import game.ai.Player;
	import husky.flixel.MyGroup;
	
	/**
     * ...
     * @author Husky
     */
    public class HUD extends MyGroup 
    {
        private var m_Player:Player;
        
        private var m_HpBar:HpBar;
        
        private var m_EnBar:EnBar;
        
        private var m_ComboUI:ComboUI;
        
        private var m_DialogUI:Dialog;
        
        public function HUD(player:Player) 
        {
            m_Player = player;
            
            m_DialogUI = new Dialog();
            this.add(m_DialogUI);
            
            m_HpBar = new HpBar(m_Player);
            this.add(m_HpBar);
            
            m_EnBar = new EnBar(m_Player)
            this.add(m_EnBar);
            
            m_ComboUI = new ComboUI();
            this.add(m_ComboUI);
            
            this.add(new ScoreUI());
        }
        
        public function get enBar():EnBar 
        {
            return m_EnBar;
        }
        
        public function get comboUI():ComboUI 
        {
            return m_ComboUI;
        }
    }
}

import game.ai.Player;
import husky.flixel.MyGroup;
import nc.component.system.script.NcLuaManager;
import nc.system.NcSystems;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.plugin.photonstorm.FlxBar;


class ScoreUI extends FlxText
{
    public function ScoreUI() : void
    {
        super(20, 145, 200);
        this.scrollFactor.x = this.scrollFactor.y = 0;
    }
    
    override public function update():void 
    {
        super.update();
        this.text = "Score: " + FlxG.score.toString();
    }
}

class HpBar extends MyGroup
{
    [Embed(source="../../../assets/StuffSet.png")]
    private var STUFF_PIC:Class;
    
    private var m_uiHp:uint;
    
    private var m_Player:Player;
    
    private var m_vHpIcon:Vector.<FlxSprite>;
    
    //-----------------------------------------------
    private var m_pStartPoint:FlxPoint;
    
    private var m_nGap:Number;
    
    public function HpBar(player:Player) 
    {
        m_Player = player;
        m_uiHp = player.health;
        
        m_vHpIcon = Vector.<FlxSprite>([]);
        
        for (var ui:uint = 0; ui < 3; ui++)
        {
            var spr:FlxSprite = new FlxSprite();
            spr.scrollFactor.x = spr.scrollFactor.y = 0;
            spr.loadGraphic(STUFF_PIC, false, false, 16, 16);
            spr.addAnimation("idle", [2], 0, false);
            spr.play("idle");
            
            m_vHpIcon.push(spr);
        }
        
        m_pStartPoint = new FlxPoint(0, 0)
        m_nGap = 0.0;
        
        var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
        luaMgr.SetGlobal("HpBar", this);
        luaMgr.DoString("InitialHpBar()");
    }
    
    override public function update():void 
    {
        super.update();
        
        this.SetHp(m_Player.health);
    }
    
    override public function destroy():void 
    {
        for (var ui:uint = 0; ui < m_vHpIcon.length; ui++)
        {
            this.add(m_vHpIcon[ui]);
        }
        
        super.destroy();
        
        m_Player = null;
        
        m_vHpIcon.splice(0, m_vHpIcon.length);
        m_vHpIcon = null;
    }
    
    private function SetHp(hp:int) : void
    {
        hp = (hp > Player.MAX_LIFE) ? Player.MAX_LIFE : hp;
        hp = (hp < 0) ? 0 : hp;
        
        this.clear();
        
        for (var ui:uint = 0; ui < hp; ui++)
        {
            m_vHpIcon[ui].x = m_pStartPoint.x + (m_vHpIcon[ui].width* + m_nGap)*ui;
            m_vHpIcon[ui].y = m_pStartPoint.y;
            
            this.add(m_vHpIcon[ui]);
        }
    }
    
    public function SetHpBarStartPoint(nX:Number, nY:Number) : void
    {
        m_pStartPoint.x = nX;
        m_pStartPoint.y = nY;
    }
    
    public function SetHpBarGap(nGap:Number) : void
    {
        m_nGap = nGap;
    }
}

class EnBar extends FlxBar
{
    private var m_Player:Player;
    
    public function EnBar(player:Player)
    {
        super(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 35, 3, null, "", 0, 5, true);
        
        m_Player = player; 
        
        this.scrollFactor.x = this.scrollFactor.y = 0;
        
        var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
        luaMgr.SetGlobal("EnBar", this);
        luaMgr.DoString("InitialEnBar()");
    }
    
    override public function update():void 
    {
        super.update();
        
        this.currentValue += FlxG.elapsed;
    }
    
    public function InitialEnBar(nX:Number, nY:Number, uiColor:uint) : void
    {
        this.x = nX;
        this.y = nY;
        this.color = uiColor;
    }
}

class Dialog extends MyGroup
{
    [Embed(source="../../../assets/Dialog.png")]
    private static const DIALOG_BG_PIC:Class;
    [Embed(source="../../../assets/RotatedBoneSet.png")]
    private static const ROTATE_BONE_SET:Class;
    
    private var m_sprBg:FlxSprite;
    private var m_sprBone:FlxSprite;
    private var m_tfDialog:FlxText;
    
    //Fade in & Fade out
    private var m_bFadeIn:Boolean;
    private var m_nTotalFadeInTime:Number;
    private var m_nFadeInTime:Number;
    
    private var m_bFadeOut:Boolean;
    private var m_nTotalFadeOutTime:Number;
    private var m_nFadeOutTime:Number;
    
    public function Dialog() : void
    {
        m_bFadeIn = false;
        m_bFadeOut = false;
        
        m_sprBg = new FlxSprite(0, 0, DIALOG_BG_PIC);
        m_sprBg.scrollFactor.x = m_sprBg.scrollFactor.y = 0;
        this.add(m_sprBg);
        
        m_tfDialog = new FlxText(0, 0, 100);
        m_tfDialog.scrollFactor.x = m_tfDialog.scrollFactor.y = 0;
        m_tfDialog.size = 8;
        this.add(m_tfDialog);
        
        m_sprBone = new FlxSprite();
        m_sprBone.scrollFactor.x = m_sprBone.scrollFactor.y = 0;
        m_sprBone.loadGraphic(ROTATE_BONE_SET, true, false, 15, 15, true);
        m_sprBone.addAnimation("spin", [0, 1, 2, 9, 3, 4, 5, 6, 7, 8, 9, 10, 11], 10, true);
        m_sprBone.play("spin");
        this.add(m_sprBone);
        
        var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
        luaMgr.SetGlobal("DialogUI", this);
        luaMgr.DoString("InitialDialogUI()");
        
        m_sprBg.alpha = 0;
        m_sprBone.alpha = 0;
        m_tfDialog.alpha = 0;
        
        m_tfDialog.text = "TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest";
    }
    
    override public function update():void 
    {
        super.update();
        
        if (m_bFadeIn == true)
        {
            m_nFadeInTime -= FlxG.elapsed;
            if (m_nFadeInTime <= 0.0)
            {
                this.Show();
                m_bFadeIn = false;
            }
            else
            {
                m_sprBg.alpha = (m_nTotalFadeInTime - m_nFadeInTime)/m_nTotalFadeInTime;
                m_sprBone.alpha = (m_nTotalFadeInTime - m_nFadeInTime)/m_nTotalFadeInTime;
                m_tfDialog.alpha = (m_nTotalFadeInTime - m_nFadeInTime)/m_nTotalFadeInTime;
            }
        }
        else if (m_bFadeOut == true)
        {
            m_nFadeOutTime -= FlxG.elapsed;
            if (m_nFadeOutTime <= 0.0)
            {
                this.Hide();
                m_bFadeOut = false;
            }
            else
            {
                m_sprBg.alpha = m_nFadeOutTime/m_nTotalFadeOutTime;
                m_sprBone.alpha = m_nFadeOutTime/m_nTotalFadeOutTime;
                m_tfDialog.alpha = m_nFadeOutTime/m_nTotalFadeOutTime;
            }
        }
    }
    
    public function SetDialogText(sText:String) : void
    {
        m_tfDialog.text = sText;
    }
    
    public function Show() : void
    {
        m_sprBg.alpha = 1;
        m_sprBone.alpha = 1;
        m_tfDialog.alpha = 1;
    }
    
    public function Hide() : void
    {
        m_sprBg.alpha = 0;
        m_sprBone.alpha = 0;
        m_tfDialog.alpha = 0;
    }
    
    public function FadeIn(nTime:Number = 0.5) : void
    {
        m_bFadeIn = true;
        m_nTotalFadeInTime = nTime;
        m_nFadeInTime = nTime;
        m_bFadeOut = false;
    }
    
    public function FadeOut(nTime:Number = 0.5) : void
    {
        m_bFadeOut = true;
        m_nTotalFadeOutTime = nTime;
        m_nFadeOutTime = nTime;
        m_bFadeIn = false;
    }
    
    public function InitialBG(nX:Number, nY:Number) : void
    {
        m_sprBg.x = nX;
        m_sprBg.y = nY;
    }
    
    public function InitialSpinBone(nX:Number, nY:Number) : void
    {
        m_sprBone.x = nX;
        m_sprBone.y = nY;
    }   
    
    public function InitialDialogText(nX:Number, nY:Number, nWidth:Number, nHeight:Number, uiColor:uint) : void
    {
        m_tfDialog.x = nX;
        m_tfDialog.y = nY;
        m_tfDialog.width = nWidth;
        m_tfDialog.height = nHeight;
        m_tfDialog.color = uiColor;
    }
}

class ComboUI extends MyGroup
{
    private var m_tfCombo:FlxText;
        
    private var m_uiCombo:uint;
    
    public function ComboUI() 
    {
        m_tfCombo = new FlxText(0, 0, 100);
        m_tfCombo.scrollFactor.x = m_tfCombo.scrollFactor.y = 0;
        this.add(m_tfCombo);
        
        m_uiCombo = 0;
        
        var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
        luaMgr.SetGlobal("ComboUI", this);
        luaMgr.DoString("InitialComboUI()");
    }
    
    public function SetCombo(uiCombo:uint) : void
    {
        m_uiCombo = uiCombo;
        
        if (m_uiCombo < 5)
        {
            m_tfCombo.text = "Combo: " + m_uiCombo.toString();
        }
        else
        {
            m_tfCombo.text = "Bowling Smash!!";
        }
        
        this.Show();
    }
    
    public function ClearCombo() : void
    {
        m_uiCombo = 0;
        this.Hide();
    }
    
    public function Show() : void
    {
        m_tfCombo.alpha = 1;
    }
    
    public function Hide() : void
    {
        m_tfCombo.alpha = 0;
    }
    
    public function InitialComboUI(nX:Number, nY:Number, uiColor:uint) : void
    {
        m_tfCombo.x = nX;
        m_tfCombo.y = nY;
        m_tfCombo.color = uiColor;
    }
    
    public function get uiCombo():uint 
    {
        return m_uiCombo;
    }
}


















