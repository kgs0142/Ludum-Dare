package husky.flixel 
{
    import flash.display.Sprite;
    import husky.flixel.MyGroup;
    import husky.util.DesignContract;
    import org.flixel.FlxBasic;
    import org.flixel.FlxState;
	
	/**
     * MyGroup, replace of FlxGroup
     * 深度還有問題，應該要考慮用Tree的結構來做
     * @author Husky
     */
    public class MyGroup extends FlxState 
    {
        private var m_Parent:MyGroup;
        
        public function MyGroup() 
        {
            m_Parent = null;
        }
        
        override public function add(object:FlxBasic):FlxBasic 
        {
            //DesignContract.PreCondition(object is MySprite || object is MyGroup, "Mygroup only add MySprite and MyGroup");
            
            if (object is MySprite)
            {
                (object as MySprite).SetParent(this);
            }
            else if (object is MyGroup)
            {
                (object as MyGroup).SetParent(this);
            }
            
            return super.add(object);
        }
        
        override public function remove(object:FlxBasic, Splice:Boolean = false):FlxBasic 
        {
            //DesignContract.PreCondition(object is MySprite || object is MyGroup, "Mygroup only add MySprite and MyGroup");
            
            if (object is MySprite)
            {
                (object as MySprite).CleanParent();
            }
            else if (object is MyGroup)
            {
                (object as MyGroup).CleanParent();
            }
            
            return super.remove(object, Splice);
        }
        
        override public function destroy():void 
        {
            super.destroy();
            
            m_Parent = null;
        }
        
        //Depth related function-----------------------------------------------------------------------
        ///the lesser deeper
        public function GetDepthOrder() : int
        {
            if (m_Parent == null)
            {
                return -1;
            }
            
            return m_Parent.members.indexOf(this) * 1000;
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
    }
}