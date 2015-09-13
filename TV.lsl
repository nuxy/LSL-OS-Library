/**
 *  TV Media Player
 *  Script to play remote media in LSL and Open Simulator platforms
 *
 *  Copyright 2011-2015, Marc S. Brooks (https://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to a transparent primitive used to cover the screen
 */

string  video_url = "http://www.domain.com/video.mov";
string  text      = "TV Media Player";
integer playing;
integer lkey;

default
{
    touch_start(integer num)
    {
        if (llDetectedKey(0) == llGetOwner())
        {
            lkey = llListen(8192, "", llGetOwner(), "");

            llSetTimerEvent(60);

            string action;

            if (playing) {
                action = "Turn Off";
            }
            else
            {
                action = "Turn On";
            }
 
            llDialog(llDetectedKey(0), text, [action], 8192);
        }
    }

    listen (integer channel, string name, key id, string msg)
    {
        llListenRemove(lkey);

        if (msg == "Turn On") 
        {
            llSetLinkPrimitiveParams(LINK_ROOT, [ PRIM_FULLBRIGHT, ALL_SIDES, TRUE ]);
            llSetPrimitiveParams([ PRIM_POINT_LIGHT, TRUE, <1.0, 1.0, 1.0>, 1.0, 2.0, 2.0 ]);
            llSetLinkAlpha(LINK_ROOT, 100.0, ALL_SIDES);
            llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_URL, video_url]);

            playing = TRUE;
        }

        if (msg == "Turn Off")
        {
            llSetLinkPrimitiveParams(LINK_ROOT, [ PRIM_FULLBRIGHT, ALL_SIDES, FALSE ]);
            llSetLinkAlpha(LINK_ROOT, 0.0, ALL_SIDES);
            llSetPrimitiveParams([ PRIM_POINT_LIGHT, FALSE, <0.0, 1.0, 0.0>, 1.0, 2.0, 2.0 ]);
            llSleep(1.0);
            llParcelMediaCommandList([PARCEL_MEDIA_COMMAND_UNLOAD, PARCEL_MEDIA_COMMAND_URL, ""]);
 
            playing = FALSE;
        }
    }

    timer()
    {
        llListenRemove(lkey);
        llSetTimerEvent(0);
    }
}
