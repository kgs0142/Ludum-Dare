package husky.flixel.system 
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import husky.flixel.event.MyMouseEvent;
    import husky.flixel.MyGroup;
    import husky.flixel.MyModule;
    import husky.flixel.MySprite;
    import husky.flixel.structurt.MouseHandler;
    import husky.flixel.util.MyEventDispatcher;
    import husky.util.DesignContract;
    import org.flixel.FlxG;
    import org.flixel.system.input.Mouse;
    
	/**
     * Check the mouse event of MySprite
     * TODO: 還沒有做深度判斷
     * @author Husky
     */
    public class MouseChecker 
    {
        private static const MOUSE_MOVE_RADIUS:Number = 1.0;
        
        private static var ms_Instance:MouseChecker;
        
        public function MouseChecker(block:Class) 
        {
            DesignContract.PreCondition(block == BLOCK, "Do not new a singleton");
        }
        
        public static function Get() : MouseChecker
        {
            if (ms_Instance == null)
            {
                ms_Instance = new MouseChecker(BLOCK);
            }
            
            return ms_Instance;
        }
        
        public function Update() : void
        {
            var allMySpr:Vector.<MySprite> = (FlxG.state as MyModule).GetAllMySprByDepth();
            
            var vMySpr:Vector.<MySprite> = Vector.<MySprite>([]);
            var ui:uint = 0;
            var uiLength:uint = allMySpr.length;
            for (ui = 0; ui < uiLength; ui++)
            {
                if ((allMySpr[ui] as MySprite).mouseHandler.bMouseEnabled == true)
                {
                    vMySpr.push(allMySpr[ui]);
                }
            }
            
            var mySpr:MySprite;
            var handler:MouseHandler;
            var dispatcher:MyEventDispatcher;
            
            //所有人都要一直做的檢查
            uiLength = vMySpr.length;
            for (ui = 0; ui < uiLength; ui++)
            {
                mySpr = vMySpr[ui];
                handler = mySpr.mouseHandler;
                dispatcher = mySpr.eventDispatcher;
                
                //Check if mouse out
                if (handler.bMouseOut == false)
                {
                    //Mouse out
                    if (this.OverlapCheck(mySpr) == false)
                    {
                        handler.bMouseOut = true;
                        handler.bMouseOver = false;
                        
                        //dispatch Mouse out event
                        mySpr.eventDispatcher.DispatchEvent(new Event(MyMouseEvent.MOUSE_OUT));
                    }
                }
                
                //Check mouse press and up-------------------------------------------------------------------------
                if (handler.mouseDown.bLeft == true || handler.mousePress.bLeft == true)
                {
                    if (FlxG.mouse.pressed(Mouse.LEFT) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MOUSE_PRESS));
                        
                        handler.mousePress.bLeft = true;
                        
                        handler.mouseDown.bLeft = false;
                        handler.mouseUp.bLeft = false;
                        return;
                    }
                    else
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MOUSE_UP));
                        
                        handler.mouseUp.bLeft = true;
                        
                        handler.mouseDown.bLeft = false;
                        handler.mousePress.bLeft = false;
                        return;
                    }
                }
                
                if (handler.mouseDown.bMiddle == true || handler.mousePress.bMiddle == true)
                {
                    if (FlxG.mouse.pressed(Mouse.MIDDLE) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MIDDLE_MOUSE_PRESS));
                        
                        handler.mousePress.bMiddle = true;
                        
                        handler.mouseDown.bMiddle = false;
                        handler.mouseUp.bMiddle = false;
                        return;
                    }
                    else
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MIDDLE_MOUSE_UP));
                        
                        handler.mouseUp.bMiddle = true;
                        
                        handler.mouseDown.bMiddle = false;
                        handler.mousePress.bMiddle = false;
                        return;
                    }
                }
                
                if (handler.mouseDown.bRight == true || handler.mousePress.bRight == true)
                {
                    if (FlxG.mouse.pressed(Mouse.RIGHT) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.RIGHT_MOUSE_PRESS));
                        
                        handler.mousePress.bRight = true;
                        
                        handler.mouseDown.bRight = false;
                        handler.mouseUp.bRight = false;
                        return;
                    }
                    else
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.RIGHT_MOUSE_UP));
                        
                        handler.mouseUp.bRight = true;
                        
                        handler.mouseDown.bRight = false;
                        handler.mousePress.bRight = false;
                        return;
                    }
                }
            }
            
            //從淺算到深，其他需要依靠滑鼠是不是在上頭的事件
            var index:int = vMySpr.length - 1;
            while (index >= 0)
            {
                mySpr = vMySpr[index];
                handler = mySpr.mouseHandler;
                dispatcher = mySpr.eventDispatcher;
                
                //如果有比mySpr淺的物件在該點上 => 接下來都不用處理了
                //if (this.HasShallowerObjectOnPoint(mySpr, vMySpr) == true)
                //{
                    //return;
                //}
                
                if (this.OverlapCheck(mySpr) == false)
                {
                    //next
                    index--;
                    continue;
                }
                
                //Check if mouse over
                if (handler.bMouseOver == false)
                {
                    //Mouse over
                    handler.bMouseOver = true;
                    handler.bMouseOut = false;
                    
                    //dispatch Mouse over event
                    mySpr.eventDispatcher.DispatchEvent(new Event(MyMouseEvent.MOUSE_OVER));
                }

                //Check mouse down-----------------------------------------------------------------------------
                if (handler.mouseUp.bLeft == true ||
                    handler.mouseUp.bMiddle == true ||
                    handler.mouseUp.bRight == true)
                {
                    if (FlxG.mouse.justPressed(Mouse.LEFT) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MOUSE_DOWN));
                        
                        handler.mouseDown.bLeft = true;
                        
                        handler.mousePress.bLeft = false;
                        handler.mouseUp.bLeft = false;
                        return;
                    }
                    else if (FlxG.mouse.justPressed(Mouse.MIDDLE) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.MIDDLE_MOUSE_DOWN));
                        
                        handler.mouseDown.bMiddle = true;
                        
                        handler.mousePress.bMiddle = false;
                        handler.mouseUp.bMiddle = false;
                        return;
                    }
                    else if (FlxG.mouse.justPressed(Mouse.RIGHT) == true)
                    {
                        dispatcher.DispatchEvent(new Event(MyMouseEvent.RIGHT_MOUSE_DOWN));
                        
                        handler.mouseDown.bRight = true;
                        
                        handler.mousePress.bRight = false;
                        handler.mouseUp.bRight = false;
                        return;
                    }
                }
                
                //next
                index--;
            }
        }
        
        ///有沒有更淺得物件蓋在spr的上頭，並且遮住滑鼠的點
        private function HasShallowerObjectOnPoint(spr:MySprite, vSpr:Vector.<MySprite>) : Boolean
        {
            //從淺算到深
            var index:int = vSpr.length - 1;
            while (index >= 0)
            {
                if (vSpr[index] == spr)
                {
                    return false;
                }
                else if (this.OverlapCheck(vSpr[index]) == true)
                {
                    return true;
                }
                
                index--;
            }
            
            throw "This is impossible";
        }
        
        private function OverlapCheck(spr:MySprite):Boolean
        {
            //如果用這個，像素改變的時候(eg. alpha)，會被影響
            //return spr.pixelsOverlapPoint(FlxG.mouse);

            return spr.overlapsPoint(FlxG.mouse);
        }
    }
}

class BLOCK
{
    
}