package husky.state 
{
	/**
     * ...
     * @author Husky
     */
    public class OOStateMachine 
    {
        private var pCurrState:IState;
        
        private var pInvalidState:IState;
        
        public function OOStateMachine(invalidState:IState)
        {
            pInvalidState = pCurrState = (invalidState ? invalidState : InvalidState.INSTANCE);
        }

        public function Update() : void
        {
            pCurrState.DoRun();
        }
        
        public function Release():void
        {
            this.SetState(pInvalidState);
        }
        
        public function SetState(nextState:IState):void
        {
            var prevState:IState = pCurrState;
            pCurrState = pInvalidState;
            
            prevState.DoLastRun();

            if (pCurrState == pInvalidState)
            {
                pCurrState = (nextState ? nextState : pInvalidState);
                pCurrState.DoFirstRun();
            }
        }
        
        ///這有問題，繼承的資訊會是錯的
        public function IsInState(stateClass:Class):Boolean
        {
            return pCurrState is stateClass;
        }
        
        public function get currentState():IState
        {
            return pCurrState;
        }
    }
}