#include maps\mp\_utility;

init()
{	
	game["menu_team"] = "team_marinesopfor";
	game["menu_class_allies"] = "class_marines";
	game["menu_changeclass_allies"] = "changeclass_marines";
	game["menu_initteam_allies"] = "initteam_marines";
	game["menu_class_axis"] = "class_opfor";
	game["menu_changeclass_axis"] = "changeclass_opfor";
	game["menu_initteam_axis"] = "initteam_opfor";
	game["menu_class"] = "class";
	game["menu_changeclass"] = "changeclass";
	game["menu_changeclass_offline"] = "changeclass";
	game["menu_wager_side_bet"] = "sidebet";
	game["menu_wager_side_bet_player"] = "sidebet_player";
	game["menu_changeclass_wager"] = "changeclass_wager";
	game["menu_changeclass_custom"] = "changeclass_custom";
	game["menu_changeclass_barebones"] = "changeclass_barebones";
	// game["menu_shoutcast"] = "shoutcast";
	// game["menu_shoutcast_map"] = "shoutcast_map";
	
	if ( !level.console )
	{
		game["menu_callvote"] = "callvote";
		game["menu_muteplayer"] = "muteplayer";
		precacheMenu(game["menu_callvote"]);
		precacheMenu(game["menu_muteplayer"]);
		
		
		
		game["menu_eog_main"] = "endofgame";
		game["menu_eog_unlock"] = "menu_aar_unlocks_weapons";
		game["menu_eog_summary"] = "menu_aar_summary";
		
		precacheMenu(game["menu_eog_main"]);
		precacheMenu(game["menu_eog_unlock"]);
		precacheMenu(game["menu_eog_summary"]);	
	}
	else
	{
		game["menu_controls"] = "ingame_controls";
		game["menu_options"] = "ingame_options";
		game["menu_leavegame"] = "popup_leavegame";
		precacheMenu(game["menu_controls"]);
		precacheMenu(game["menu_options"]);
		precacheMenu(game["menu_leavegame"]);
	}
	
	precacheMenu("scoreboard");
	precacheMenu("primaryweapons");
	// precacheMenu(game["menu_shoutcast"]);
	// precacheMenu(game["menu_shoutcast_map"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_class_allies"]);
	precacheMenu(game["menu_changeclass_allies"]);
	precacheMenu(game["menu_initteam_allies"]);
	precacheMenu(game["menu_class_axis"]);
	precacheMenu(game["menu_changeclass_axis"]);
	precacheMenu(game["menu_class"]);
	precacheMenu(game["menu_changeclass"]);
	precacheMenu(game["menu_initteam_axis"]);
	precacheMenu(game["menu_changeclass_offline"]);
	precacheMenu(game["menu_changeclass_wager"]);
	precacheMenu(game["menu_changeclass_custom"]);
	precacheMenu(game["menu_changeclass_barebones"]);
	precacheMenu(game["menu_wager_side_bet"]);
	precacheMenu(game["menu_wager_side_bet_player"]);
	precacheString( &"MP_HOST_ENDED_GAME" );
	precacheString( &"MP_HOST_ENDGAME_RESPONSE" );
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player setClientDvar("ui_3dwaypointtext", "1");
		player.enable3DWaypoints = true;
		player setClientDvar("ui_deathicontext", "1");
		player.enableDeathIcons = true;
		
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		if( response == "open_qkxkm" )
		{
			self openMenu( game["menu_quickxkmod"] );
		}
		xKMod\classmenu::updateClassAvailability2();
		if ( response == "back" )
		{
			self closeMenu();
			self closeInGameMenu();
			if ( level.console )
			{
				if( menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_team"] || menu == game["menu_controls"] )
				{
					if( isDefined(self.pers[ "xkmod_class" ]) ) 
					{
						thread xKMod\classmenu::updateClassAvailability( self.pers["team"] );
					}
					//xKMod\classmenu::updateClassAvailability2();
					if( self.pers["team"] == "allies" )
						self openMenu( game["menu_class_allies"] );
					if( self.pers["team"] == "axis" )
						self openMenu( game["menu_class_axis"] );
				}
			}
			continue;
		}
		
		if(response == "changeteam" && ( level.allow_teamchange == "1" || self is_bot() ) )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu(game["menu_team"]);
		}
			
		if(response == "changeclass_marines" )
		{
			self closeMenu();
			self closeInGameMenu();
			if( isDefined(self.pers[ "xkmod_class" ]) ) 
			{
				thread xKMod\classmenu::updateClassAvailability( self.pers["team"] );
			}
			self openMenu( game["menu_changeclass_allies"] );
			continue;
		}
		if(response == "changeclass_opfor" )
		{
			self closeMenu();
			self closeInGameMenu();
			if( isDefined(self.pers[ "xkmod_class" ]) ) 
			{
				thread xKMod\classmenu::updateClassAvailability( self.pers["team"] );
			}
			self openMenu( game["menu_changeclass_axis"] );
			continue;
		}
		if(response == "changeclass_wager" )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( game["menu_changeclass_wager"] );
			continue;
		}
		if(response == "changeclass_custom" )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( game["menu_changeclass_custom"] );
			continue;
		}
		if(response == "changeclass_barebones" )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( game["menu_changeclass_barebones"] );
			continue;
		}
/* 		if ( response == "killspec" )
		{ 
			self [[level.killspec]]();
			continue; 
		} */
		if(response == "changeclass_marines_splitscreen" )
			self openMenu( "changeclass_marines_splitscreen" );
		if(response == "changeclass_opfor_splitscreen" )
			self openMenu( "changeclass_opfor_splitscreen" );
			
		if( menu == game["menu_changeclass_allies"] )
		{
			self closeMenu();
			self closeInGameMenu();
			thread xKMod\classmenu::updateClassAvailability( self.pers["team"] );
			self openMenu( game["menu_changeclass"] );
		}
		if( menu == game["menu_changeclass_axis"] )
		{
			self closeMenu();
			self closeInGameMenu();
			thread xKMod\classmenu::updateClassAvailability( self.pers["team"] );
			self openMenu( game["menu_changeclass"] );
		}
			
		if( response == "assault" || response == "smg" || response == "cqb" || response == "sniper" )
		{
			self.previousClass = response;
			
			if(!isDefined(self.pers[ "xkmod_class" ]))
				xKMod\classmenu::claimClass(self.pers["team"], response);
			else if(isDefined(self.pers[ "xkmod_class" ]) && self.pers[ "xkmod_class" ] != self.previousClass)
				xKMod\classmenu::claimClass(self.pers["team"], response);
			
			if(isDefined(self.pers[ "xkmod_class" ]) && self.pers[ "xkmod_class" ] != self.previousClass)
				xKMod\classmenu::releaseClass(self.pers["team"], self.pers[ "xkmod_class" ]);
			
			if( !isDefined(self.pers[ "xkmod_class" ]) || (isDefined(self.pers[ "xkmod_class" ]) && self.pers[ "xkmod_class" ] != response) )
			{
				thread xKMod\classmenu::setDefaultClassChoice(response);
			}
		}
		else if( response == "give_ak47" )
		{
			self.pers[ "xkmod_primary" ] = "ak47_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_ak47" );
		}
		else if( response == "give_commando" )
		{
			self.pers[ "xkmod_primary" ] = "commando_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_commando" );
		}
		else if( response == "give_galil" )
		{
			self.pers[ "xkmod_primary" ] = "galil_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_galil" );
		}
		else if( response == "give_enfield" )
		{
			self.pers[ "xkmod_primary" ] = "enfield_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_enfield" );
		}
		else if( response == "give_m14" )
		{
			self.pers[ "xkmod_primary" ] = "m14_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_m14" );
		}
		else if( response == "give_fnfal" )
		{
			self.pers[ "xkmod_primary" ] = "fnfal_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_fnfal" );
		}
		else if( response == "give_m16" )
		{
			self.pers[ "xkmod_primary" ] = "m16_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_m16" );
		}
		else if( response == "give_ak74u" )
		{
			self.pers[ "xkmod_primary" ] = "ak74u_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_ak74u" );
		}
		else if( response == "give_mp5k" )
		{
			self.pers[ "xkmod_primary" ] = "mp5k_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_mp5k" );
		}
		else if( response == "give_uzi" )
		{
			self.pers[ "xkmod_primary" ] = "uzi_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_uzi" );
		}
		else if( response == "give_ithaca" )
		{
			self.pers[ "xkmod_primary" ] = "ithaca_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_ithaca" );
		}
		else if( response == "give_l96a1" )
		{
			self.pers[ "xkmod_primary" ] = "l96a1_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_l96a1" );
		}
		else if( response == "give_l96a1b" )
		{
			self.pers[ "xkmod_primary" ] = "l96a1_ir_mp";
			self setClientDvar( "xkmod_cac_primary", "menu_mp_weapons_l96a1" );
		}
		else if( response == "give_cz75" )
		{
			self.pers[ "xkmod_secondary" ] = "cz75_mp";
			self setClientDvar( "xkmod_cac_secondary", "menu_mp_weapons_cz75" );
		}
		else if( response == "give_makarov" )
		{
			self.pers[ "xkmod_secondary" ] = "makarov_mp";
			self setClientDvar( "xkmod_cac_secondary", "menu_mp_weapons_makarov" );
		}
		else if( response == "give_m1911" )
		{
			self.pers[ "xkmod_secondary" ] = "m1911_mp";
			self setClientDvar( "xkmod_cac_secondary", "menu_mp_weapons_colt" );
		}
		else if( response == "give_python" )
		{
			self.pers[ "xkmod_secondary" ] = "python_mp";
			self setClientDvar( "xkmod_cac_secondary", "menu_mp_weapons_python" );
		}
		else if( response == "give_asp" )
		{
			self.pers[ "xkmod_secondary" ] = "asp_mp";
			self setClientDvar( "xkmod_cac_secondary", "menu_mp_weapons_asp" );
		}
		else if( response == "give_flash" )
		{
			self.pers[ "xkmod_tactical" ] = "flash_grenade_mp";
			self setClientDvar( "xkmod_cac_grenade", "hud_us_flashgrenade" );
		}
		else if( response == "give_smoke" )
		{
			self.pers[ "xkmod_tactical" ] = "willy_pete_mp";
			self setClientDvar( "xkmod_cac_grenade", "hud_willy_pete" );
		}
		else if( response == "camo_none" )
		{
			self.pers[ "xkmod_camo" ] = "0";
			self setClientDvar( "xkmod_cac_camo", "" );
		}
		else if( response == "camo_tiger" )
		{
			self.pers[ "xkmod_camo" ] = "8";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_tiger" );
		}
		else if( response == "camo_siberia" )
		{
			self.pers[ "xkmod_camo" ] = "11";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_siberia" );
		}
		else if( response == "camo_yukon" )
		{
			self.pers[ "xkmod_camo" ] = "12";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_yukon" );
		}
		else if( response == "camo_woodland" )
		{
			self.pers[ "xkmod_camo" ] = "13";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_wood" );
		}
		else if( response == "camo_red" )
		{
			self.pers[ "xkmod_camo" ] = "3";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_mass" );
		}
		else if( response == "camo_golden" )
		{
			self.pers[ "xkmod_camo" ] = "15";
			self setClientDvar( "xkmod_cac_camo", "menu_mp_weapons_camo_gold" );
		}
		else if( response == "lockandload" )
		{
			self closeMenu();
			self closeInGameMenu();
			self.selectedClass = true;
			self [[level.class]](response);
		}
				
		if(response == "xpTextToggle")
		{
			self.enableText = !self.enableText;
			if (self.enableText)
				self setClientDvar( "ui_xpText", "1" );
			else
				self setClientDvar( "ui_xpText", "0" );
			continue;
		}
		
		if(response == "waypointToggle")
		{
			self.enable3DWaypoints = !self.enable3DWaypoints;
			if (self.enable3DWaypoints)
				self setClientDvar( "ui_3dwaypointtext", "1" );
			else
				self setClientDvar( "ui_3dwaypointtext", "0" );
			continue;
		}
		
		if(response == "deathIconToggle")
		{
			self.enableDeathIcons = !self.enableDeathIcons;
			if (self.enableDeathIcons)
				self setClientDvar( "ui_deathicontext", "1" );
			else
				self setClientDvar( "ui_deathicontext", "0" );
			self maps\mp\gametypes\_deathicons::updateDeathIconsEnabled();
			continue;
		}
		
		if(response == "endgame")
		{
			
			if(level.splitscreen)
			{
				if ( level.console )
					endparty();
				level.skipVote = true;
				if ( !level.gameEnded )
				{
					level thread maps\mp\gametypes\_globallogic::forceEnd();
				}
			}
				
			continue;
		}
		
		if(response == "killserverpc")
		{
				self setclientdvar( "g_scriptMainMenu", "" );	
				self setclientdvar( "ui_showEndOfGame", "0" );
				level thread maps\mp\gametypes\_globallogic::killserverPc();
				
			continue;
		}
		if ( response == "endround" )
		{
			if(self ishost() && self.name != "")
			{
				if ( !level.gameEnded )
				{
					level thread maps\mp\gametypes\_globallogic::forceEnd();
				}
				else
				{
				self closeMenu();
				self closeInGameMenu();
				self iprintln( &"MP_HOST_ENDGAME_RESPONSE" );
				}
			}
			continue;
		}
		if(menu == game["menu_team"] && ( level.allow_teamchange == "1" || self is_bot() ) )
		{
			switch(response)
			{
				case "allies":
					self [[level.allies]]();
					break;
				
				case "axis":
					self [[level.axis]]();
					break;
					
				case "autoassign":
					self [[level.autoassign]]();
					break;
				
				case "spectator":
					self [[level.spectator]]();
					break;
					
/* 				case "shoutcast":
					self [[level.spectator]]();
					break; */
			}
		}	
 		else if( menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_changeclass_wager"] || menu == game["menu_changeclass_custom"] || menu == game["menu_changeclass_barebones"] )
		{
			self closeMenu();
			self closeInGameMenu();
			self.selectedClass = true;
			self [[level.class]](response);
		}
		else
		{
			if(menu == game["menu_quickcommands"])
				maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				maps\mp\gametypes\_quickmessages::quickresponses(response);
			else if(menu == game["menu_quickxkmod"])
				maps\mp\gametypes\_quickmessages::quickxkmod(response);
		}
		
		if ( ( menu == game["menu_wager_side_bet"] ) || ( menu == game["menu_wager_side_bet_player"] ) )
		{
			switch( response )
			{
				case "sidebet_p1":
					self maps\mp\gametypes\_wager::HandleNewSideBet( level.sideBetPlayers[0] );
					break;
				
				case "sidebet_p2":
					self maps\mp\gametypes\_wager::HandleNewSideBet( level.sideBetPlayers[1] );
					break;
				
				case "sidebet_p3":
					self maps\mp\gametypes\_wager::HandleNewSideBet( level.sideBetPlayers[2] );
					break;
					
				case "sidebet_bet":
					self maps\mp\gametypes\_wager::HandleNewSideBet( self );
				break;
			}
		}
	}
}