package husky.state
{
	public interface IState
	{
		function DoFirstRun():void;
		
		function DoRun():void;
		
		function DoLastRun():void;
	}
}