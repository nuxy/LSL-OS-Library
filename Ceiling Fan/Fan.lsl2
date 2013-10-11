/*
 *  Ceiling Fan
 *  Script to simulate rotating fan in LSL and Open Simulator platforms
 *
 *  Copyright 2011-2013, Marc S. Brooks (http://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to a primitive that resembles a ceiling fan (pos: bottom/center)
 *    Add a corresponding sound clips to inventory 'ceiling_fan'
 */

integer channel = 500; // fan button channel
integer volume  = 1.0;

default
{
	state_entry()
	{
		llListen(channel, "", NULL_KEY, "On");
		llListen(channel, "", NULL_KEY, "Off");
	}

	listen(integer channel, string name, key id, string msg)
	{
		if (msg == "On")
		{
			llTargetOmega(llRot2Up(llGetLocalRot()), PI, 4.0);
			llLoopSound("ceiling_fan", volume);
		}

		if (msg == "Off")
		{
			llTargetOmega(llRot2Up(llGetLocalRot()), 0, 0.0);
			llStopSound();
		}
	}
}
