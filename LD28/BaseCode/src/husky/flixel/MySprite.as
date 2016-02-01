package husky.flixel 
{
    import husky.flixel.controller.BaseController;
    import husky.flixel.structurt.MouseHandler;
    import husky.flixel.util.MyEventDispatcher;
    import husky.util.DesignContract;
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
     * 深度還有問題，應該要考慮用Tree的結構來做
     * @author Husky
     */
    public class MySprite extends FlxSprite 
    {
        private var m_Parent:MyGroup;
        
        private var m_Controller:BaseController;
        
        ///Mouse struct
        private var m_MouseHandler:MouseHandler;
        
        ///Event dispatcher
        private var m_EventDispatcher:MyEventDispatcher;
        
        public function MySprite() 
        {
            m_Parent = null;

            m_Controller = new BaseController();
            
            m_MouseHandler = new MouseHandler();
            //m_MouseHandler.mouseEnabled = false;
            
            m_EventDispatcher = new MyEventDispatcher();
        }
        
        override public function update():void 
        {
            super.update();
            
            m_Controller.update();
            
        }
        
        override public function destroy():void 
        {
            super.destroy();
            
            m_EventDispatcher.Release();
            m_EventDispatcher = null;
            
            m_MouseHandler.Release();
            m_MouseHandler = null;
            
            this.CleanParent();
            
            if (m_Controller)
            {
                m_Controller.destroy();
                m_Controller = null;
            }
        }
        
        //Depth related function-----------------------------------------------------------------------
        ///the lesser deeper
        public function GetDepthOrder() : int
        {
            if (m_Parent == null)
            {
                return -1;
            }
            
            return (m_Parent.GetDepthOrder() + m_Parent.members.indexOf(this));
        }
        
        //Parent related function----------------------------------------------------------------------
        public function SetParent(cParent:MyGroup) : void
        {
            DesignContract.PreCondition(cParent is MyGroup, "MySpr can only add at MyGroup");
            
            m_Parent = cParent;
        }
        
        internal function CleanParent() : void
        {
            m_Parent = null;
        }
        
        //Controller related function---------------------------------------------------------------------------------------------
        public function SetController(controller:BaseController) : void
        {
            if (m_Controller)
            {
                m_Controller.destroy();
            }
            
            m_Controller = controller;
            
            m_Controller.Initial(this);
        }
        
        //---------------------------------------------------------------------------------------------
        
        
        //Getter/Setter
        public function get parent():MyGroup 
        {
            return m_Parent;
        }
        
        public function get controller():BaseController 
        {
            return m_Controller;
        }
        
        public function get eventDispatcher():MyEventDispatcher 
        {
            return m_EventDispatcher;
        }
        
        public function get mouseHandler():MouseHandler 
        {
            return m_MouseHandler;
        }
    }
}