#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main()
{
	game["timeout_over"] = false;
	game["ready_up"] = true;
	thread TimeoutTimer();
	thread xKMod\readyup::main();
}

SaveScore()
{
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];

		player.pers["score_hold_to"] = player.pers["score"];
		player.pers["kills_hold_to"] = player.pers["kills"];
		player.pers["deaths_hold_to"] = player.pers["deaths"];
		player.pers["assists_hold_to"] = player.pers["assists"];
		player.pers["plants_hold_to"] = player.pers["plants"];
		player.pers["defuses_hold_to"] = player.pers["defuses"];
	}
}

TimeoutCall()
{
	if(!isDefined(game["timeout_axis"]) || !isDefined(game["timeout_allies"]))
	{
		game["timeout_axis"] = false;
		game["timeout_allies"] = false;
	}
	
	if (!isDefined(game["timeout_called"]))
		game["timeout_called"] = false;
	
	if (game["is_public_mode"])
	{
		self iprintln("^1Timeout is for Match Modes Only");
		return;
	}
	
	if (level.gametype != "sd")
	{
		self iprintln("^1Timeout is for S&D Only");
		return;
	}
	
	if (isDefined(level.ready_up_over) && !level.ready_up_over)
	{
		self iprintln("^1Timeout cannot be called in Ready-UP");
		return;
	}
	
	if (game["roundsplayed"]+1 == getDvarInt("scr_sd_roundswitch"))
	{
		self iprintln("^1Timeout cannot be called on the final round of a side");
		return;
	}
	
	if (game["roundsplayed"]+1 == getDvarInt("scr_sd_roundswitch")*2)
	{
		self iprintln("^1Cannot call timeout on the last round of the map");
		return;
	}
	
	if (game["timeout_called"])
	{
		self iprintln("^1Timeout already called, wait until next round.");
		return;
	}
	
	if (game["timeout_"+self.pers["team"]] > 2)
	{
		self iprintln("^13 Timeouts maximum per team");
		return;
	}
	
	xkteam = "";
	
	switch(self.pers["team"])
	{
		case "allies":
		xkteam = toLower(getDvar("g_TeamName_Allies"));
		break;
		
		case "axis":
		xkteam = toLower(getDvar("g_TeamName_Axis"));
		break;
		
		default:
		break;
	
	}
	
	iprintln("^1A timeout was called by: ^7"+self.name+" ("+ xkteam +")\n^1Match will be paused next round.");
	game["timeout_"+self.pers["team"]]++;
	game["timeout_called"] = true;
}

TimeoutTimer()
{
	level endon("kill_timeout_threads");
	
	m = 5;
	s = 0;
	
	level.xkmod_timeout_text = createServerFontString("objective", 1.4);
	level.xkmod_timeout_text setPoint( "CENTER", "CENTER", 0, 197 ); 
	level.xkmod_timeout_text.color = (1,1,1);
	level.xkmod_timeout_text.hidewheninmenu = false;

	while (m >= 0 && s >= 0)
	{
		s--;
		if(s < 0)
		{
			m -= 01;
			if(m > 0)
				s = 59;
		}
		level.xkmod_timeout_text setText("^7Time remaining:\n       "+m+"m"+s+"s");
		wait 1;
	}

	game["timeout_over"] = true;
}
