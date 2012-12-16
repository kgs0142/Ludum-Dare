package com.global
{
    public final class CDefine
    {
        public static const FN_EMPTY:Function       = function() : void{};
        
        //QTE actions
        public static const LEFT_CLICK:String       = "Left_Click";
        public static const LEFT_PRESS:String       = "Left_Press";
        public static const RIGHT_CLICK:String      = "Right_Click";
        public static const RIGHT_PRESS:String      = "Right_Press";
        public static const MOUSE_MOVE:String       = "Mouse_Move";
        
        //QTE events
        //Rnd qte 1~4 
        public static const RANDOM_QTE_1:String     = "playerEnemyRandomQte1";
        public static const ENEMY_QTE_3_TIMES:String= "playerEnemyQte3Times";
        //ID DEFINE
        //public static const ID_GAME_MODULE:uint = 0x00000000;
        
        public function CDefine() { }
    }
}