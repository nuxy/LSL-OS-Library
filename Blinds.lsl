/**
 *  Horizontal Blinds
 *  Script to simulate window blinds in LSL and Open Simulator platforms
 *
 *  Copyright 2011-2015, Marc S. Brooks (https://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to a primitive containing an image that resembles blinds
 *    Add a corresponding sound clip to inventory named 'blinds_toggle'
 */

integer steps    = 10;
float   reversed = TRUE;
float   min      = 0.1;
float   volume   = 1.0;
vector  offset   = <0,0,1>;

default
{
    state_entry()
    {
        offset *= ((1.0 - min) / steps) * (offset * llGetScale());
        reversed -= 0.5;
    }

    touch_start(integer detected)
    {
        integer i;

        do llSetPrimitiveParams([PRIM_SIZE, llGetScale() - offset, PRIM_POSITION, llGetLocalPos() + ((reversed * offset) * llGetLocalRot())]);

        while ((++i) < steps);

        offset =- offset;

        llTriggerSound("blinds_toggle", volume);
    }
}
