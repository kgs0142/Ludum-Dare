package com.ui.flash 
{
    import adobe.utils.CustomActions;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
	
	/**
     * 輪形UI（要當養分UI用）
     * @author Husky
     */
    public class CWheelUI extends Sprite 
    {
        public static const COLOR_NORMAL:String =     "COLOR NORMAL";
        public static const COLOR_HIGH_LIGHT:String = "COLOR HIGH LIGHT";
        
        private static const START_ANGLE:Number = -90;
        
        private var m_arrArcSpr:Vector.<CSprArc>;
        
        ///The amount of arcs
        private var m_uiNumArcs:uint;
        private var m_nInnerRadius:Number;
		private var m_nOuterRadius:Number;
        
        public function CWheelUI()
		{
            m_arrArcSpr = Vector.<CSprArc>([]);
            
            this.mouseEnabled = false;
            this.mouseChildren = false;
		}
        
        /**
		 * Creates the buttons that make up the wheel menu.
		 */
        public function Create(uiNumArcs:uint, nOuterRadius:Number = 27, 
                               nInnerRadius:Number = 5) : void
        {
            m_uiNumArcs = uiNumArcs;
			m_nOuterRadius = nOuterRadius;
			m_nInnerRadius = nInnerRadius;
            
			for (var ui:uint = 0; ui < m_uiNumArcs; ui++)
			{
                var sprArc:CSprArc = new CSprArc(Math.PI*2/m_uiNumArcs, 
                                                 m_nOuterRadius, 
                                                 m_nInnerRadius);

				sprArc.uiID = ui;
				sprArc.rotation = START_ANGLE + 360/m_uiNumArcs*ui;
                
				this.addChild(sprArc);
				m_arrArcSpr.push(sprArc);
			}

			this.filters = [new DropShadowFilter(4, 45, 0, 1, 4, 4, .2, 4)];
        }
        
        /**
         * Render
         * @param	uiHightLightNum 高亮的數量
         */
        public function Render(uiHightLightNum:uint = 0) : void
        {
            var ui:uint = 0;
            for (ui = 0; ui < m_uiNumArcs; ui++)
            {
                m_arrArcSpr[ui].Render(CWheelUI.COLOR_NORMAL);
            }
            
            for (ui = 0; ui < uiHightLightNum; ui++)
            {
                m_arrArcSpr[ui].Render(CWheelUI.COLOR_HIGH_LIGHT);
            }
        }
        
        public function Release() : void
        {
            
        }
        
        //public function show() : void
        //{
            //
        //}
        //
        //public function hide() : void
        //{
            //
        //}
        
        ///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
    }
}

/**
 * 弧形UI，構成輪形UI
 */
import com.ui.flash.CWheelUI
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Shape;

class CSprArc extends Sprite
{
    private var m_uiID:uint;
    
    private var m_uiColor:uint;
    private var m_uiBorderColor:uint;
	private var m_uiHighLightColor:uint;
    
    private var m_nArc:Number;
    private var m_nOuterRadius:Number;
    private var m_nInnerRadius:Number;
    //private var m_nIconRadius:Number;
    
    private var m_shpBG:Shape;
    
    //private var m_sprIconHolder:Sprite;
    
    /**
	 * Constructor.
	 * @param arc The radians of the arc to draw.
	 * @param outerRadius The outer radius of the arc. 
	 * @param innerRadius The inner radius of the arc.
	 */
	public function CSprArc(nArc:Number, nOuterRadius:Number, nInnerRadius:Number)
	{
        m_uiColor = 0x474747;
        m_uiBorderColor = 0x000000;
        m_uiHighLightColor = 0xFFEB69;
        
		m_nArc = nArc;
        //m_nIconRadius = nIconRadius;
		m_nInnerRadius = nInnerRadius;
		m_nOuterRadius = nOuterRadius;
		
		m_shpBG = new Shape();
		addChild(m_shpBG);
		
		//m_sprIconHolder = new Sprite();
		//addChild(m_sprIconHolder);
	}
    
    /**
	 * Draws an arc of the specified color.
	 * @param color The color to draw the arc.
	 */
	public function Render(sState:String = CWheelUI.COLOR_NORMAL):void
	{
        var uiColor:uint = (sState == CWheelUI.COLOR_NORMAL) ? 
                            m_uiColor : m_uiHighLightColor;
        
		m_shpBG.graphics.clear();
		m_shpBG.graphics.lineStyle(1.5, m_uiBorderColor);
		m_shpBG.graphics.beginFill(uiColor);
		m_shpBG.graphics.moveTo(m_nInnerRadius, 0);
		m_shpBG.graphics.lineTo(m_nOuterRadius, 0);
        
        var i:Number = 0
        //0.5是弧的平滑度
		for (i = 0; i < m_nArc; i += 0.05)
		{
			m_shpBG.graphics.lineTo(Math.cos(i)*m_nOuterRadius, Math.sin(i)*m_nOuterRadius);
		}
        
		m_shpBG.graphics.lineTo(Math.cos(m_nArc)*m_nOuterRadius, 
                                Math.sin(m_nArc)*m_nOuterRadius);
		m_shpBG.graphics.lineTo(Math.cos(m_nArc)*m_nInnerRadius, 
                                Math.sin(m_nArc)*m_nInnerRadius);
        
		for(i = m_nArc; i > 0; i -= 0.05)
		{
			m_shpBG.graphics.lineTo(Math.cos(i)*m_nInnerRadius, 
                                    Math.sin(i)*m_nInnerRadius);
		}
        
		m_shpBG.graphics.lineTo(m_nInnerRadius, 0);
		
		this.graphics.endFill();
	}
    
    //show, normal, hightlight
    //public function show() : void
    //{
        //
    //}
    
    ///////////////////////////////////
	// getter / setters
	///////////////////////////////////
    
    public function get uiID() : uint { return m_uiID; }
    public function set uiID(value:uint) : void { m_uiID = value; }
    
    /**
	 * Sets / gets base color.
	 */
    public function get uiColor() : uint { return m_uiColor; }
    public function set uiColor(value:uint) : void { m_uiColor = value; }
    
    /**
	 * Sets / gets border color.
	 */
    public function get uiBorderColor() : uint { return m_uiBorderColor; }
    public function set uiBorderColor(value:uint) : void { m_uiBorderColor = value; }
    
    /**
	 * Sets / gets highlight color.
	 */
    public function get uiHighLightColor() : uint { return m_uiHighLightColor; }
    public function set uiHighLightColor(value:uint) : void { m_uiHighLightColor = value; }
    
    /**
	 * Overrides rotation by rotating arc only, allowing label / icon to be unrotated.
	 */
	public override function set rotation(value:Number) : void { m_shpBG.rotation = value; }
	public override function get rotation() : Number { return m_shpBG.rotation; }
}