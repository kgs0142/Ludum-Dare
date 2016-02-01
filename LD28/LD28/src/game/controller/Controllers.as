package game.controller 
{
	import adobe.utils.CustomActions;
    import game.controller.enemy.BossJumpAttackController;
    import game.controller.enemy.ChaseAndAttackController;
    import game.controller.enemy.ChasePlayerController;
    import game.controller.enemy.IdleAttackController;
    import husky.flixel.controller.BaseController;
    import husky.util.DesignContract;
	
	/**
     * ...
     * @author Husky
     */
    public class Controllers
    {
        private static const ALL:Object = 
        {
            "ChasePlayerController" : ChasePlayerController,
            "ChaseAndAttackController" : ChaseAndAttackController,
            "IdleAttackController" : IdleAttackController,
            "BossJumpAttackController": BossJumpAttackController
        }
        
        public static function CreateController(sName:String) : BaseController
        {
            DesignContract.PreCondition(ALL.hasOwnProperty(sName), "Don't have the controller: " + sName);
            
            return new ALL[sName]();
        }
        
        public function Controllers() 
        {
            
        }
        
    }

}