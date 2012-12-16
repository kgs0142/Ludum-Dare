package com.global 
{
	/**
     * ...
     * @author Husky
     */
    public class CQTEQuest 
    {
        public static const QUEST:Object =
        {
          "000" : {"action": CDefine.RIGHT_CLICK, 
                    "times": 5,
                    "counting": 5,
                    "playerDialog": "",
                    "enemyDialog": ""
                  },
          "001" : {"action": CDefine.RIGHT_PRESS, 
                    "times": 0,
                    "counting": 1,
                    "playerDialog": "",
                    "enemyDialog": ""
                  },
          "002" : {"action": CDefine.LEFT_CLICK, 
                    "times": 5,
                    "counting": 5,
                    "playerDialog": "",
                    "enemyDialog": ""
                  },
          "003" : {"action": CDefine.MOUSE_MOVE, 
                    "times": 10,
                    "counting": 5,
                    "playerDialog": "",
                    "enemyDialog": ""
                  }
        }
        
        public function CQTEQuest() {}
        
    }

}