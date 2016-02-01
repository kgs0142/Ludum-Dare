package husky.state 
{
	/**
     * ...
     * @author Husky
     */
	internal class InvalidState implements IState
	{
		public static const INSTANCE:InvalidState = new InvalidState();
		
		public function InvalidState()
		{
		}

		public function DoFirstRun() : void
        {
            
        }
		
		public function DoRun() : void
        {
            
        }
		
		public function DoLastRun() : void
        {
            
        }
	}
}