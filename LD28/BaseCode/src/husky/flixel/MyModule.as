package husky.flixel 
{
    import husky.flixel.system.MouseChecker;
	/**
     * Use MyModuel to replace of FlxState
     * @author Husky
     */
    public class MyModule extends MyGroup 
    {
		override public function create():void
		{
			
		}
        
        override public function update():void 
        {
            super.update();
            
            //Update all mouse events of MySpr in MyModule.
            MouseChecker.Get().Update();
            
        }
        
        //From deeper to shallower
        public function GetAllMySprByDepth() : Vector.<MySprite>
        {
            return this.GetMySprByDepth(this);
        }
        
        //Fix to a tree later please..
        private function GetMySprByDepth(myGroup:MyGroup) : Vector.<MySprite>
        {
            var vMySpr:Vector.<MySprite> = Vector.<MySprite>([]);
            
            for (var ui:uint = 0; ui < myGroup.length; ui++)
            {
                if (myGroup.members[ui] is MySprite)
                {
                    vMySpr.push(myGroup.members[ui] as MySprite);
                }
                else if (myGroup.members[ui] is MyGroup)
                {
                    var vTemp:Vector.<MySprite> = this.GetMySprByDepth(myGroup.members[ui]);
                    var spr:MySprite = vTemp.shift();
                    while (spr != null)
                    {
                        vMySpr.push(spr);
                        spr = vTemp.shift();
                    }
                }
            }
            
            return vMySpr;
        }
    }
}