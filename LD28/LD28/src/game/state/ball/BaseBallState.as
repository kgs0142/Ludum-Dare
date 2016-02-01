package game.state.ball 
{
    import game.ai.Ball;
    import husky.state.IState;
	/**
     * ...
     * @author Husky
     */
    public class BaseBallState implements IState
    {
        protected var m_Instance:Ball;
        
        public function BaseBallState(instance:Ball) 
        {
            m_Instance = instance;
        }
        
        public function DoFirstRun() : void
        {
            
        }
		
		public function DoRun() : void
        {
            
        }
		
		public function DoLastRun() : void
        {
            m_Instance = null;
        }
    }
}