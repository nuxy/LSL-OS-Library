/*
 *  Ceiling Fan Light
 *  Script to simulate rotating fan in LSL and Open Simulator platforms
 *
 *  Copyright 2011-2013, Marc S. Brooks (http://mbrooks.info)
 *  Licensed under the MIT license:
 *  http://www.opensource.org/licenses/mit-license.php
 *
 *  Usage:
 *    Add this to a primitive that resembles a ceiling light
 */

integer channel = 501; // lights button channel
integer verbose = TRUE;

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
			llSetPrimitiveParams([ PRIM_POINT_LIGHT, TRUE, <1.0, 1.0, 1.0>, 1.0, 10.0, 0.5 ]);
		}

		if (msg == "Off")
		{
			llSetPrimitiveParams([ PRIM_POINT_LIGHT, FALSE, <0.0, 1.0, 0.0>, 1.0, 10.0, 0.5 ]);
		}

		if (verbose)
		{
			llOwnerSay("Power " + msg);
		}
	}
}
