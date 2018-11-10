using System.Collections;
using System.Collections.Generic;
using UnityEngine;

enum STAT_TYPE {
    STAT_NONE = 0,
    STAT_HOME,
    STAT_VANGUARD,
    STAT_NEUTRAL,
    STAT_TOTAL
};

enum PLAYER_TYPE {
    PLAYER_NONE = 0,
    PLAYER_ONE,
    PLAYER_TWO,
    PLAYER_TOTAL
};

public class Square {
    //VARIABLES -- THESE ARE ALL PUBLIC SO THEY DON'T NEED ACCESSORS OR MUTATORS
    //
    //coordinate and movement
    public Vector2 coord;
    public bool is_moveable;
    //layer one variable
    //
    public int stat_type;
    //layer two variable
    //
    public bool is_well;
    //layer three variable
    //
    public bool is_summoning;
    //layer four variable
    //
    public bool is_base_1;
    public bool is_base_2;
    public int player_type;

    public Square(Vector2 coord) {
        //SETTING POSITION
        //
        this.coord = coord;
        //SETTING DEFAULT STATE OF SQUARE
        //
        is_moveable = true;
        stat_type = (int)STAT_TYPE.STAT_NONE;
        is_well = false;
        is_summoning = false;
        is_base_1 = false;
        is_base_2 = false;
        player_type = (int)PLAYER_TYPE.PLAYER_NONE;
    }
}
