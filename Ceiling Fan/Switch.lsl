/**
 *  Ceiling Fan Switch
 *  Script to simulate rotating fan in LSL and Open Simulator platforms
 *
 *  Copyright 2011-2015, Marc S. Brooks (https://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to a primitive containing an image that resembles a switch
 *    Add a corresponding sound clips to inventory 'switch_on/switch_off'
 */

string  text    = "Ceiling Fan";
float   volume  = 1.0;
integer channel = 500;
integer enabled;
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

			if (enabled) {
				action = "Turn Off";
			}
			else
			{
				action = "Turn On";
			}
		
			llDialog(llDetectedKey(0), text, [action], 8192);
		}
	}

	timer()
	{
		llListenRemove(lkey);
		llSetTimerEvent(0);
	}
	
	listen (integer channel, string name, key id, string msg)
	{
		llListenRemove(lkey);

		if (msg == "Turn On")
		{
			llMessageLinked(LINK_THIS, 0, "On", NULL_KEY);
			llTriggerSound("switch_on", volume);

			enabled = TRUE;
		}

		if (msg == "Turn Off")
		{
			llMessageLinked(LINK_THIS, 0, "Off", NULL_KEY);
			llTriggerSound("switch_off", volume);

			enabled = FALSE;
		}
	}

	link_message(integer to, integer from, string msg, key id)
	{
		if (msg == "On" || msg == "Off")
		{
			llSay(channel, msg);
		}
	}
}
