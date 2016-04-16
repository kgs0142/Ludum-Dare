package core.misc;

/**
 * This is a fixed related to the getter/setter of hscript, I guess this should be fixed in the future.
 * https://github.com/HaxeFoundation/hscript/issues/10
 * @author User
 */
class CustomInterp extends hscript.Interp 
{
    override function get( o : Dynamic, f : String ) : Dynamic 
    {
        if( o == null ) throw hscript.Expr.Error.EInvalidAccess(f);
        return Reflect.getProperty(o,f);
    }

    override function set( o : Dynamic, f : String, v : Dynamic ) : Dynamic 
    {
        if( o == null ) throw hscript.Expr.Error.EInvalidAccess(f);
        Reflect.setProperty(o,f,v);
        return v;
    }

}
