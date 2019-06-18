#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main()
{
	oldtimelimit = getdvar("scr_sd_timelimit");
	oldgraceperiod = getdvar("scr_game_graceperiod");
	level thread readyupServerDvars();
	disableBombsites();
	disableSDBomb();
	precacheStatusIcon("compassping_friendlyfiring_mp");
	precacheStatusIcon("compassping_enemy");
	level.timeLimitOverride = true;
	level.rdyup = 1;
	setClientNameMode( "auto_change" );
	setGameEndTime( 0 );
	level.ready_up_over = false;

	
	RU_Period = createServerFontString( "objective", 1.6 );
	RU_Period setPoint( "CENTER", "CENTER", 0, -145 );
	RU_Period.sort = 1001;	
	RU_Period.foreground = false;
	RU_Period.hidewheninmenu = true;
	if (game["roundsplayed"] == 0)
		RU_Period setText( "Pre-Match Ready-Up Period" );
	else if(game["timeout_called"] == true)
		RU_Period setText( "Timeout Ready-Up Period" );
	else if(game["roundsplayed"] > 2 && !game["timeout_called"])
		RU_Period setText( "Half-Time Ready-Up Period" );
	
	level.prover_hud = newHudElem();
	level.prover_hud.font = "objective";
	level.prover_hud.x = -17;
	level.prover_hud.y = 35;
	level.prover_hud.horzAlign = "right";
	level.prover_hud.vertAlign = "top";
	level.prover_hud.alignX = "right";
	level.prover_hud.alignY = "middle";
	level.prover_hud.alpha = 1;	
	level.prover_hud.fontScale = 1.6;
	level.prover_hud.color = (0.82,0.016,0.016);
	level.prover_hud setText( "xK       " );
	
	level.prover_hud2 = newHudElem();
	level.prover_hud2.font = "objective";
	level.prover_hud2.x = -19;
	level.prover_hud2.y = 35;
	level.prover_hud2.horzAlign = "right";
	level.prover_hud2.vertAlign = "top";
	level.prover_hud2.alignX = "right";
	level.prover_hud2.alignY = "middle";
	level.prover_hud2.alpha = 1;	
	level.prover_hud2.fontScale = 1.6;
	level.prover_hud2 setText( "    ^0Mod" );
	
	level.version_text = newHudElem();
	level.version_text.font = "objective";
	level.version_text.x = -25;
	level.version_text.y = 50;
	level.version_text.horzAlign = "right";
	level.version_text.vertAlign = "top";
	level.version_text.alignX = "right";
	level.version_text.alignY = "middle";
	level.version_text.alpha = 1;
	level.version_text.fontScale = 1.5;
	level.version_text.color = (1,1,1);
	level.version_text setText( "LIVE" );
	
	if(getDvar("xk_mode") != "mymatch")
	{
		mode = getDvar( "xk_mode" );
		level.mode = newHudElem();
		level.mode.font = "objective";
		level.mode.x = -14;
		level.mode.y = 76;
		level.mode.horzAlign = "right";
		level.mode.vertAlign = "top";
		level.mode.alignX = "right";
		level.mode.alignY = "middle";
		level.mode.alpha = 1;
		level.mode.fontScale = 1.5;
		level.mode.color = (1,1,1);
		level.mode setText( "^7"+ mode );
	}
	else if(getDvar("xk_mode") == "mymatch")
	{
		mode = getDvar( "league_name" );
		level.mode = newHudElem();
		level.mode.font = "objective";
		level.mode.x = -14;
		level.mode.y = 76;
		level.mode.horzAlign = "right";
		level.mode.vertAlign = "top";
		level.mode.alignX = "right";
		level.mode.alignY = "middle";
		level.mode.alpha = 1;
		level.mode.fontScale = 1.5;
		level.mode.color = (1,1,1);
		level.mode setText( "^7"+ mode +"Match" );
	}
	
	if(getDvar("xk_mode") != "cevomatch")
	{
		mr_rating = getdvarInt( "mr_rating" );
		
		level.MR = newHudElem();
		level.MR.font = "objective";
		level.MR.x = -23;
		level.MR.y = 100;
		level.MR.horzAlign = "right";
		level.MR.vertAlign = "top";
		level.MR.alignX = "right";
		level.MR.alignY = "middle";
		level.MR.alpha = 1;
		level.MR.fontScale = 1.5;
		level.MR setText( "MR^3"+ int( mr_rating )  );
	}
	
	if(getDvarInt("match_knockout") == 1)
	{
		knockoutvalue = getdvarInt("scr_" + level.gametype + "_scorelimit");
		
		level.KNO = newHudElem();
		level.KNO.font = "objective";
		level.KNO.x = -14;
		level.KNO.y = 130;
		level.KNO.horzAlign = "right";
		level.KNO.vertAlign = "top";
		level.KNO.alignX = "right";
		level.KNO.alignY = "middle";
		level.KNO.alpha = 1;
		level.KNO.fontScale = 1.5;
		level.KNO setText( "Knock out at ^3"+ int( knockoutvalue )  );
	}
	else if(getDvarInt("match_knockout") == 0)
	{
		level.KNO = newHudElem();
		level.KNO.font = "objective";
		level.KNO.x = -5;
		level.KNO.y = 130;
		level.KNO.horzAlign = "right";
		level.KNO.vertAlign = "top";
		level.KNO.alignX = "right";
		level.KNO.alignY = "middle";
		level.KNO.alpha = 1;
		level.KNO.fontScale = 1.5;
		level.KNO setText( "No Knockout" );
	}
	
	wait .5;
	
	Ready_Up_Monitor_Loop();
	
	level.timeLimitOverride = false;
	
	wait .5;
	
	Ready_up_matchStartTimer();
	RU_Period destroy();
	game["ready_up"] = false;
	game["half_time"] = false;
	level notify("readyupisover");
	
	if (game["roundsplayed"] == 0 && (isDefined(game["timeout_called"]) && !game["timeout_called"])) 
		resetStats();

	if (isDefined(game["half_time"]) && game["half_time"] == true)
		holdStats();

	if(isDefined(game["timeout_called"]) && game["timeout_called"] == true)
	{
		level notify("kill_timeout_threads");
		level.xkmod_timeout_text destroy();
		holdStatsTO();
		game["timeout_called"] = false;
	}
	
	xKMod\_xkmod::forceDvar("g_deadChat", "0" );
	xKMod\_xkmod::forceDvar("g_revive", "0" );
	xKMod\_xkmod::forceDvar("scr_sd_numlives", "1" );
	xKMod\_xkmod::forceDvar("scr_sd_timelimit", oldtimelimit);
	xKMod\_xkmod::forceDvar("scr_game_graceperiod", oldgraceperiod);
	
	map_restart( true );
}

conditionReadyUp() 
{
	if(!isDefined(game["ready_up"]))
		game["ready_up"] = true;

	if(game["ready_up"])
		return true;
                
	return false;
}

disableBombsites()
{
	if ( level.gametype == "sd" && isDefined( level.bombZones ) )
	{
		for ( j = 0; j < level.bombZones.size; j++ )
		{
		level.bombZones[j] maps\mp\gametypes\_gameobjects::disableObject(); 
		}
	}
}

disableSDBomb()
{ 
	if ( level.gametype == "sd" ) 
	{
		trigger = getEnt( "sd_bomb_pickup_trig", "targetname" );
		visuals = getEnt( "sd_bomb", "targetname" ); 
		
		if ( isDefined( trigger ) ) 
			trigger delete();

		if ( isDefined( visuals ) )
			visuals delete(); 
			
		if ( isDefined( level.sdBomb ) )
			level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam( "none" ); 
	} 
}

holdStats()
{
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];

		player.pers["score"] = player.pers["score_hold"];
		player.pers["kills"] = player.pers["kills_hold"];
		player.pers["deaths"] = player.pers["deaths_hold"];
		player.pers["assists"] = player.pers["assists_hold"];
		player.pers["plants"] = player.pers["plants_hold"];
		player.pers["defuses"] = player.pers["defuses_hold"];
	}
}

holdStatsTO()
{
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];

		player.pers["score"] = player.pers["score_hold_to"];
		player.pers["kills"] = player.pers["kills_hold_to"];
		player.pers["deaths"] = player.pers["deaths_hold_to"];
		player.pers["assists"] = player.pers["assists_hold_to"];
		player.pers["plants"] = player.pers["plants_hold_to"];
		player.pers["defuses"] = player.pers["defuses_hold_to"];
	}
}

resetStats()
{	
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		
		player.pers["score"] = 0;
		player.pers["kills"] = 0;
		player.pers["assists"] = 0;
		player.pers["deaths"] = 0;
		player.pers["suicides"] = 0;
		player.pers["participation"] = undefined;
	
/* 		if (player.pers["team"] == "spectator")
			player thread xKMod\shoutcast::resetShoutcast(); */
	}
	
	game["teamScores"]["allies"] = 0;
	game["teamScores"]["axis"] = 0;
	maps\mp\gametypes\_globallogic_score::resetTeamScores();
}

Ready_Up_Monitor_Loop()
{	
	level.status = createServerFontString("objective", 1.4);
	level.status setPoint("TOPRIGHT", "TOPRIGHT", -17, 240);
	level.status.color = (1, 1, 1);
	level.status.hidewheninmenu = true;
	level.status setText("Status");
	
	level.waitingon = newHudElem();
	level.waitingon.x = -40;
	level.waitingon.y = 165;	
	level.waitingon.horzAlign = "right";
	level.waitingon.vertAlign = "top";
	level.waitingon.alignX = "center";
	level.waitingon.alignY = "middle";	
	level.waitingon.fontScale = 1.4;	
	level.waitingon.font = "objective";
	level.waitingon.color = (1, 1, 1);	
	level.waitingon.hidewheninmenu = true;
	level.waitingon setText("Waiting On");	
	
	level.playerstext = newHudElem();
	level.playerstext.x = -40;	
	level.playerstext.y = 205;	
	level.playerstext.horzAlign = "right";	
	level.playerstext.vertAlign = "top";	
	level.playerstext.alignX = "center";	
	level.playerstext.alignY = "middle";	
	level.playerstext.fontScale = 1.4;	
	level.playerstext.font = "objective";	
	level.playerstext.color = (1, 1, 1);	
	level.playerstext.hidewheninmenu = true;
	level.playerstext setText("Players");	
	
 	level.notreadyhud = newHudElem();
	level.notreadyhud.x = -40;	
	level.notreadyhud.y = 185;	
	level.notreadyhud.horzAlign = "right";
	level.notreadyhud.vertAlign = "top";
	level.notreadyhud.alignX = "center";	
	level.notreadyhud.alignY = "middle";	
	level.notreadyhud.fontScale = 1.4;	
	level.notreadyhud.font = "objective";	
	level.notreadyhud.color = (.98, .98, .60);
	level.notreadyhud.hidewheninmenu = true;
	
	while(!level.ready_up_over)
	{
		wait .5;
						
		if(!isDefined(self))
			return;
					
		level.inGracePeriod = true;
		
		not_ready_count = 0;
		
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			
			if(isDefined(level.players[i].ready))
				not_ready_count += level.players[i].ready;
			else
			{
				player.ruptally = -1;
				level.players[i] thread Player_Ready_Up_Loop();
			}
		}
		
		level.notreadyhud setValue(level.players.size - not_ready_count);
						
		if(level.players.size > 0 && not_ready_count == level.players.size || game["timeout_over"])
		{
			level.ready_up_over = true;
			game["timeout_over"] = false;
		}
	}
	
	level.waitingon destroy();
	level.notreadyhud destroy();
	level.playerstext destroy();
	level.status destroy();
}

Player_Ready_Up_Loop()
{
	self endon("disconnect");
	if (isDefined(self.in_ready_up_loop))		
	return;	
	
	self.in_ready_up_loop = true;
	self.ready = false;
	self iprintlnbold("Press ^3[{+activate}] ^7to Ready-Up");
	
	self.readyhud = self createFontString("objective", 1.4);
	self.readyhud setPoint("TOPRIGHT", "TOPRIGHT", -8, 220);
	self.readyhud.color = (1, 1, 1);
	self.readyhud.hidewheninmenu = true;
	self.readyhud setText("Loading");
	
	self.killing = self createFontString("objective", 1.4);
	self.killing setPoint("TOPRIGHT", "TOPRIGHT", -17, 305);
	self.killing.color = (1, 1, 1);
	self.killing.hidewheninmenu = true;
	self.killing setText("Killing");
	
	self.readytally = self createFontString("objective", 1.4);
	self.readytally setPoint("TOPRIGHT", "TOPRIGHT", -11, 320);
	self.readytally.color = (0.82,0.016,0.016);
	self.readytally.hidewheninmenu = true;
	self.readytally setText("Disabled");	

	while(!level.ready_up_over) 
	{
		wait .05;
		
		self freeze_player_controls(false);
		self setWeaponAmmoClip("frag_grenade_mp", 0);
		self setWeaponAmmoClip("flash_grenade_mp", 0);
		self setWeaponAmmoClip("willy_pete_mp", 0);

		if(!isDefined(self))
		return;
		
		self thread democlientStuff();
			
		if (self.ruptally >= 0)
		{
			self.killing setText("Kills");
			self.readytally setPoint("TOPRIGHT", "TOPRIGHT", -19, 320);
			self.readytally setValue(self.ruptally);
			wait 0.1;		
		}
		
		if(self useButtonPressed())
			self.ready = !self.ready;
			
							
		if(self.ready && !self isDemoClient()) 
		{
			self.statusicon = "compassping_friendlyfiring_mp";	
			self.readyhud setPoint("TOPRIGHT", "TOPRIGHT", -18, 255);
			self.readyhud.color = (0.016, 0.82, 0.016);
			self.readyhud setText("Ready");	
		} 
		else
		{
			if(!self isDemoClient())
			{
				self.statusicon = "compassping_enemy";
				self.readyhud setPoint("TOPRIGHT", "TOPRIGHT", -8, 255);
				self.readyhud.color = (0.82,0.016,0.016);	
				self.readyhud setText("Not Ready");	
			}
		}				
		while(self useButtonPressed())
		wait .05;       
	}
	
	self.readyhud destroy();
	self.killing destroy();
	self.readytally destroy();
}

Ready_up_matchStartTimer()
{	
	timer = 5;

	matchStartText = createServerFontString( "objective", 1.5 );
	matchStartText setPoint( "CENTER", "CENTER", 0, -40 );
	matchStartText.sort = 1001;
	matchStartText setText( "All Players are Ready" );
	matchStartText.foreground = false;
	matchStartText.hidewheninmenu = false;
	matchStartText.glowColor = (1, 1, 1);	
	matchStartText.glowAlpha = 1;	
	matchStartText setPulseFX( 100, 2000, 2000 );
	matchStartText maps\mp\gametypes\_hud::fontPulseInit();
	
	matchStartText2 = createServerFontString( "extrabig", 1.5 );	
	matchStartText2 setPoint( "CENTER", "CENTER", 0, -20 );	
	matchStartText2.sort = 1001;	
	matchStartText2 setText( game["strings"]["match_starting_in"] );
	matchStartText2.foreground = false;	
	matchStartText2.hidewheninmenu = false;	

	matchStartTimer = createServerTimer( "extrabig", 2.2 );
	matchStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
	matchStartTimer setTimer( timer );	
	matchStartTimer.sort = 1001;	
	matchStartTimer.foreground = false;	
	matchStartTimer.hideWhenInMenu = false;	
	
	wait timer;	

	matchStartText destroy();
	matchStartText2 destroy();
	matchStartTimer destroy();
}

democlientStuff()
{
	self endon("disconnect");
	
	if(self isdemoclient())
	{	
		wait 5;
		if(!self.ready) self.ready = true;
	}
}

readyupServerDvars()
{
	level endon( "readyupisover" );
	
	for(;;) 
	{ 
		xKMod\_xkmod::forceDvar("demo_enabled", "1");
		xKMod\_xkmod::forceDvar("g_deadChat", "1" );
		xKMod\_xkmod::forceDvar("g_revive", "1" );
		xKMod\_xkmod::forceDvar("scr_sd_numlives", "0");
		xKMod\_xkmod::forceDvar("scr_sd_timelimit", "0");
		xKMod\_xkmod::forceDvar("scr_game_graceperiod", "999");
		wait 0.1;
	} 
}