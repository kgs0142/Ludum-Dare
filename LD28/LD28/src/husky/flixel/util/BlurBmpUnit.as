package husky.flixel.util 
{
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import org.flixel.FlxG;
	/**
     * ...
     * @author Husky
     */
    public class BlurBmpUnit 
    {
        private var m_pPos:Point;
        private var m_bmpBlur:BitmapData;
        
        public function BlurBmpUnit(nX:Number, nY:Number, bmpd:BitmapData) : void
        {
            m_pPos = new Point(nX, nY);
            m_bmpBlur = bmpd;
        }
        
        public function Destroy() : void
        {
            m_pPos = null;
            m_bmpBlur.dispose();
            m_bmpBlur = null;
        }
        
        public function getMatrix() : Matrix
        {
            var m:Matrix = new Matrix();
            
            m.translate(m_pPos.x - FlxG.camera.scroll.x, 
                        m_pPos.y - FlxG.camera.scroll.y);
            return m;
        }
        
        public function get bmpBlur():BitmapData 
        {
            return m_bmpBlur;
        }
        
        public function get pPos():Point 
        {
            return m_pPos;
        }
    }
}

