package husky.flixel.util 
{
    import org.flixel.FlxPoint;
	/**
     * ...
     * @author Husky
     */
    public class FlxMathUtil 
    {
        public static function Distance(p1:FlxPoint, p2:FlxPoint) : Number
        {
            return Math.sqrt(Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2));
        }
    }
}