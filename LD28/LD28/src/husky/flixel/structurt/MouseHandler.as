package husky.flixel.structurt 
{
    import husky.flixel.MySprite;
    import org.flixel.FlxPoint;
	/**
     * Myspr滑鼠邏輯的結構物件
     * @author Husky
     */
    public class MouseHandler 
    {
        //Mouse logic------------------------------
        private var m_pLastMouse:FlxPoint;
        
        private var m_bMouseOver:Boolean;
        
        private var m_bMouseOut:Boolean;
        
        private var m_bMouseEnabled:Boolean;
        
        //因為目前不能做出組合鍵：eg. 左鍵按住同時右鍵連點
        private var m_mouseDown:MouseTernary;
        
        private var m_mousePress:MouseTernary;
        
        private var m_mouseUp:MouseTernary;
        
        //-----------------------------------------
        
        public function MouseHandler() 
        {
            m_pLastMouse = new FlxPoint(0, 0);
            m_bMouseEnabled = true;
            
            m_bMouseOver = false;
            m_bMouseOut = true;
            
            m_mouseDown = new MouseTernary();
            m_mousePress = new MouseTernary();
            m_mouseUp = new MouseTernary();
            
            //Initial
            m_mouseUp.bLeft = true;
            m_mouseUp.bMiddle = true;
            m_mouseUp.bRight = true;
        }
        
        public function Release() : void
        {
            m_pLastMouse = null;
            m_mouseDown = null;
            m_mousePress = null;
            m_mouseUp = null;
        }
        
        //Getter / Setter
        public function set bMouseOver(value:Boolean):void 
        {
            m_bMouseOver = value;
        }
        
        public function get bMouseOver() : Boolean
        {
            return m_bMouseOver;
        }
        
        public function get bMouseOut():Boolean 
        {
            return m_bMouseOut;
        }
        
        public function set bMouseOut(value:Boolean):void 
        {
            m_bMouseOut = value;
        }
        
        public function get bMouseEnabled():Boolean 
        {
            return m_bMouseEnabled;
        }
        
        public function set bMouseEnabled(value:Boolean):void 
        {
            m_bMouseEnabled = value;
        }
        
        public function get pLastMouse():FlxPoint 
        {
            return m_pLastMouse;
        }
        
        public function set pLastMouse(value:FlxPoint):void 
        {
            m_pLastMouse = value;
        }
        
        public function get mouseDown():MouseTernary 
        {
            return m_mouseDown;
        }
        
        public function get mousePress():MouseTernary 
        {
            return m_mousePress;
        }
        
        public function get mouseUp():MouseTernary 
        {
            return m_mouseUp;
        }
        
    }
}

//滑鼠三鍵用的三元flag
class MouseTernary
{
    private var m_bLeft:Boolean;
    
    private var m_bMiddle:Boolean;
    
    private var m_bRight:Boolean;
    
    public function MouseTernary() : void
    {
        m_bLeft = false;
        m_bMiddle = false;
        m_bRight = false;
    }
    
    public function get bLeft():Boolean 
    {
        return m_bLeft;
    }
    
    public function set bLeft(value:Boolean):void 
    {
        m_bLeft = value;
    }
    
    public function get bMiddle():Boolean 
    {
        return m_bMiddle;
    }
    
    public function set bMiddle(value:Boolean):void 
    {
        m_bMiddle = value;
    }
    
    public function get bRight():Boolean 
    {
        return m_bRight;
    }
    
    public function set bRight(value:Boolean):void 
    {
        m_bRight = value;
    }
}