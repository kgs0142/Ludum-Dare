package com.game 
{
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
	import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
	
	/**
     * Combine Flxsprite to a complex Flxsprite
     * @author Husky
     */
    public class CFlxMyGroup extends FlxGroup 
    {
        //Really not good .
        
        /**
		* If you changed the size of your sprite object after loading or making the graphic,
		* you might need to offset the graphic away from the bound box to center it the way you want.
		*/
		public var offset:FlxPoint;
		/**
		 * X position of the upper left corner of this object in world space.
		 */
		public var x:Number;
		/**
		 * Y position of the upper left corner of this object in world space.
		 */
		public var y:Number;
		/**
		 * The width of this object.
		 */
		public var width:Number;
		/**
		 * The height of this object.
		 */
		public var height:Number;
        //-----------------------------------------------------------------------
        
        private var m_nInitialX:Number;
        private var m_nInitialY:Number;
        
        //Can the player take it on the head?
        public var bCanTakeIt:Boolean;
        
        public function CFlxMyGroup(nInitialX:Number, nInitialY:Number) 
        {
            width = 24;
            height = 24;
            
            bCanTakeIt = true;
            
            x = nInitialX;
            y = nInitialY;
            m_nInitialX = x;
            m_nInitialY = y;
            
            offset = new FlxPoint();
        }
        
        //update the order to render
        override public function update():void 
        {
            super.update();

            this.members.sortOn("uiDepth", Array.NUMERIC);

            //REALLY STRANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            var aMembers:Array = [];
            for each (var obj:Object in this.members)
            {
                if (obj == null)
                {
                    continue;
                }
                
                aMembers.push(obj);
            }
            
            this.members.splice(0, this.members.length);
            this.members = aMembers
        }
        
        override public function draw():void 
        {
            //Set all flxsprite member's position to This.position
			var basic:FlxBasic;
			var i:uint = 0;
			while(i < length)
			{
				basic = members[i++] as FlxBasic;
                
                //--------------
                var spr:FlxSprite = basic as FlxSprite;
                if (spr != null)
                {
                    spr.x = this.x;
                    spr.y = this.y;
                }
                //----------------
                
				if((basic != null) && basic.exists && basic.visible)
					basic.draw();
			}
        }
        
        //Add:flxGroup1 add the differ parts of flxGroup2
        
        //Add:Only members are totally diffent flxGroup1 will do
        public static function AdditionTwoGroup(flxGroup1:CFlxMyGroup, flxGroup2:CFlxMyGroup) : Boolean
        {
            //Check if has the same member
            //var flxGroup1MySpr:CFlxMySprite;
            //var flxGroup2MySpr:CFlxMySprite
            //for each (flxGroup1MySpr in flxGroup2.members)
            //{
                //for each (flxGroup2MySpr in flxGroup1.members)
                //{
                    //if (flxGroup1MySpr.sName == flxGroup2MySpr.sName)
                    //{
                        //trace("Two groups have the same member.")
                        //return false;
                    //}
                //}
            //}
            //
            //for each (var flxSpr:CFlxMySprite in flxGroup2.members)
            //{
                //var spr:CFlxMySprite = new CFlxMySprite(flxSpr.clzGraphics, 
                                                        //flxSpr.sName, flxSpr.uiDepth);
                //spr.angle = flxSpr.angle;
                //flxGroup1.add(spr);
            //}
            //
            //return true;
            
            //Check if has the differ member
            var bAllTheSame:Boolean = false;
            var aSameMember:Vector.<CFlxMySprite> = Vector.<CFlxMySprite>([]);
            var flxGroup1MySpr:CFlxMySprite;
            var flxGroup2MySpr:CFlxMySprite;
            for each (flxGroup1MySpr in flxGroup1.members)
            {
                for each (flxGroup2MySpr in flxGroup2.members)
                {
                    if (flxGroup1MySpr.sName != flxGroup2MySpr.sName)
                    {
                        continue;
                    }
                    
                    aSameMember.push(flxGroup2MySpr);
                    break;
                }
            }
            
            //STRAGE, length is not really working right-----------------------
            var uiGroup2Length:uint = 0;
            var obj:Object;
            for each (obj in flxGroup2.members) { uiGroup2Length++ ; }
            if (uiGroup2Length == aSameMember.length)
            {
                trace("flxGroup1 has all the members of flxGroup2");
                return false;
            }
            //------------------------------------
            
            var aDifferMember:Array = [];
            var flxSpr:CFlxMySprite;
            for each (flxSpr in flxGroup2.members)
            {
                if (aSameMember.indexOf(flxSpr) != -1)
                {
                    continue;
                }
                
                aDifferMember.push(flxSpr);
            }
            
            for each (flxSpr in aDifferMember)
            {
                var spr:CFlxMySprite = new CFlxMySprite(flxSpr.clzGraphics, 
                                                        flxSpr.sName, flxSpr.uiDepth);
                spr.angle = flxSpr.angle;
                flxGroup1.add(spr);
            }
            
            
            //Play Add snd
            FlxG.play(SndAdd);
            
            return true;
        }
        
        //Sub:flxGroup1 sub the same parts of flxGroup2
        
        //Take all the same member?????
        
        //Cant subtract by mainpuzzlebox???????
        
        //Sub: Only the more member flxGroup1 will do
        //true -> substract
        //false -> didnt do substracting, switch the two Item
        public static function SubstractTwoGroup(flxGroup1:CFlxMyGroup, flxGroup2:CFlxMyGroup) : Boolean
        {
            //Cant use the less one to substract the more one
            //if (flxGroup1.length < flxGroup2.length)
            //{
                //trace("Cant use the less one to substract the more one");
                //return false;
            //}
            
            //for each (var flxLessMySpr:CFlxMySprite in flxGroup2.members)
            //{
                //for each (var flxMoreMySpr:CFlxMySprite in flxGroup1.members)
                //{
                    //if (flxLessMySpr.sName != flxMoreMySpr.sName)
                    //{
                        //continue;
                    //}
                    //
                    //flxGroup1.members.splice(flxGroup1.members.indexOf(flxMoreMySpr), 1 );
                    //flxGroup1.remove(flxMoreMySpr);
                    //return true;
                //}
            //}
            //
            //return false;
            
            var flxGroup1Spr:CFlxMySprite;
            var flxGroup2Spr:CFlxMySprite;
            var aSameMember:Vector.<String> = Vector.<String>([])
            for each (flxGroup2Spr in flxGroup2.members)
            {
                for each (flxGroup1Spr in flxGroup1.members)
                {
                    if (flxGroup1Spr.sName != flxGroup2Spr.sName)
                    {
                        continue;
                    }
                    
                    aSameMember.push(flxGroup1Spr.sName);
                }
            }
            
            //Dont have the same part
            if (aSameMember.length == 0)
            {
                return false;
            }
            
            for each (flxGroup2Spr in flxGroup2.members)
            {
                if (aSameMember.indexOf(flxGroup2Spr.sName) != -1)
                {
                    //flxGroup2.members.splice(flxGroup2.members.indexOf(flxGroup2Spr), 1 );
                    flxGroup2.remove(flxGroup2Spr);
                }
            }
            
            for each (flxGroup1Spr in flxGroup1.members)
            {
                if (aSameMember.indexOf(flxGroup1Spr.sName) != -1)
                {
                    //flxGroup1.members.splice(flxGroup1.members.indexOf(flxGroup1Spr), 1 );
                    flxGroup1.remove(flxGroup1Spr);
                }
            }
            
            //Play sub snd
            FlxG.play(SndSub);
            
            return true;
        }
        
        //Check if only has these child (to pass the stage)
        public function HasOnlyTheseChild(...params) : Boolean
        {
            //... ...
            var uiTotalMembers:uint = 0;
            
            var uiMatchMySpr:uint = 0;
            for each (var flxMySpr:CFlxMySprite in this.members)
            {
                if (flxMySpr != null)
                {
                    uiTotalMembers++;
                }
                
                for each (var sName:String in params)
                {
                    if (flxMySpr == null || flxMySpr.sName != sName)
                    {
                        continue;
                    }
                    
                    uiMatchMySpr++;
                    break;
                }
            }
            
            if (params.length == uiMatchMySpr &&
                //uiMatchMySpr == this.length)
                uiMatchMySpr == uiTotalMembers)
            {
                return true;
            }
            
            return false;
        }
        
        public function HasTheChild(sMemberName:String) : Boolean
        {
            for each (var flxMySpr:CFlxMySprite in this.members)
            {
                if (flxMySpr.sName == sMemberName)
                {
                    return true;
                }
            }
            
            return false;
        }
        
        public function InitialPosition() : void
        {
            this.x = this.m_nInitialX;
            this.y = this.m_nInitialY;
        }
        
		/**
		 * Tells this object to flicker, retro-style.
		 * Pass a negative value to flicker forever.
		 * 
		 * @param	Duration	How many seconds to flicker for.
		 */
		public function flicker(Duration:Number=1):void
		{
            for each(var flxObject:FlxObject in this.members)
            {
                //???RRREEEALLY STRANGE
                if (flxObject == null)
                {
                    this.members.splice(this.members.indexOf(flxObject), 1);
                    continue;
                }
                
                flxObject.flicker(Duration);
            }
		}
    }
}