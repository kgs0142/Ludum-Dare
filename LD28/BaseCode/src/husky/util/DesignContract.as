package husky.util 
{
	/**
     * ...
     * @author Husky
     */
    public class DesignContract 
    {
	    public static function Invariant(condition:Boolean, message:String = null) : Boolean 
        {
	        return PostCondition(condition, message);
	    }
	    
	    public static function PostCondition(condition:Boolean, message:String = null) : Boolean 
        {
	        if (!condition)
            {
	            throw new ArgumentError(message);
	        }
            
	        return true;
	    }
	    
	    public static function PreCondition(condition:Boolean, message:String = null) : void
        {
	        if (!condition) 
            {
	            throw new ArgumentError(message);
	        }
	    }
    }

}