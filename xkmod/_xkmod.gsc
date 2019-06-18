// Coded by XeroK
// Steam: xerok
// ESL: http://player.esl.eu/xerok
// xKMod LIVE

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{ 
	setDvar("ui_modname", "^9xK^0Mod ^7LIVEv1.1");
	game["modname"] = getDvar("ui_modname");
	
	precacheStatusIcon("demo_play");
	precacheShader("hud_flashbang");
	precacheShader("hud_willysmoke");
	
	level.serverDvars = [];
	
	game["allies_assault_count"] = 0; 
	game["allies_smg_count"] = 0; 
	game["allies_cqb_count"] = 0;
	game["allies_sniper_count"] = 0;
	
	game["axis_assault_count"] = 0; 
	game["axis_smg_count"] = 0; 
	game["axis_cqb_count"] = 0;
	game["axis_sniper_count"] = 0;
	
	setServerDvarDefault( "class_assault_limit", 64, 0, 64 );
	setServerDvarDefault( "class_smg_limit", 2, 0, 64 );
	setServerDvarDefault( "class_cqb_limit", 1, 0, 64 );
	setServerDvarDefault( "class_sniper_limit", 1, 0, 64 );
	
	level thread onPlayerConnect();
	level thread doServerDvars();
	level thread doTeamNames();
}

onPlayerConnect() 
{ 	
	for(;;) 
	{ 
		level waittill("connected", player);
		
		player setClientDvar("ui_modname", game["modname"]);
		player thread onPlayerSpawned();
		player thread updateServerDvars();
		player thread xKMod\shoutcast::ShoutCastOverlay_Update();
					
		if(player isdemoclient()) player.statusicon = "demo_play";
	} 
}

onPlayerSpawned()
{
	self endon("disconnect");
	
	//if(level.gametype == "sd") self thread doModInfo();
	
	for(;;) 
	{ 
		self waittill("spawned_player");
		
		self thread Perksinit();
		self thread doArreglos();
		self freezeControls(false);

		if ( level.gameType == "sd" && getDvar("xk_mode") == "public" )
		{
			self thread doCheckAlivePlayers2();
			self thread doAmmo();
			self thread doDropBomb();
			self thread maps\mp\gametypes\_rank::doStratTimer();
		}
		else if( getDvar("g_gametype") == "sd" && (getDvar("xk_mode") == "eslmatch" || getDvar("xk_mode") == "cevomatch" || getDvar("xk_mode") == "cbmatch" || getDvar("xk_mode") == "mymatch" ) )
		{
			self thread doCheckAlivePlayers();
			
			if(!game["ready_up"])
			{
				self thread doAmmo();
				self thread maps\mp\gametypes\_rank::doStratTimer();
			}
			self thread doDropBomb();
		}
	}
}

Perksinit()
{
	self ClearPerks();
	self thread doNoSway();
	self thread doExtraPerks();
}

doDvars()
{	
	self setClientDvars(	"aim_automelee_enabled", 0,
							"aim_automelee_range", 0,
							"bg_bobAmplitudeDucked", "0 0",
							"bg_bobAmplitudeProned", "0 0",
							"bg_bobAmplitudeSprinting", "0",
							"bg_bobAmplitudeStanding", "0",
							"bg_bobMax", "0",
							"bg_fallDamageMaxHeight", 350,
							"bg_fallDamageMinHeight", 140,
							"bg_viewBobMax", 0,
							"bg_weaponBobMax", 0,
							"cg_brass", 0,
							"cg_drawcrosshairnames", 0,
							"cg_drawFriendInColor", 0 ,
							"cg_fov_default_thirdperson", "1",
							"cg_fovscale", 1.125 );

	wait 0.05;

	self setClientDvars(	"cg_huddamageiconheight", 64 ,
							"cg_huddamageiconinscope", 0 ,
							"cg_huddamageiconoffset", 128 ,
							"cg_huddamageicontime", 2000 ,
							"cg_huddamageiconwidth", 128 ,
							"cg_nopredict", 0,
							"cg_playerHighlightEnemyColor", "1 1 1 1",
							"cg_viewzsmoothingmax", 16 ,
							"cg_viewzsmoothingmin", 1 ,
							"cg_viewzsmoothingtime", 0.1 ,
							"compassSpectatorsSeeEnemies", "0",
							"dynent_active", 0,
							"enable_global_wind", 0 ,
							"enable_grass_wind", 0 ,
							"enable_moving_paths", 0 ,
							"facepaintLodDist", "10" );

	wait 0.05;
	
	self setClientDvars(	"fx_marks", 0,
							"jump_slowdownEnable", 1,
							"phys_gravity", "-800",
							"player_forceRedCrosshair", "0",
							"player_meleeHeight", 10,
							"player_meleeRange", 60,
							"player_meleeWidth", 10,
							"playlist_enabled", "0",
							"r_brightness", "0",
							"r_contrast", "1",
							"r_desaturation", 0,
							"r_distortion", 0,
							"r_dlightLimit", 0,
							"r_exposuretweak", "0",
							"r_filmtweakInvert", 0,
							"r_flashLightShadows", 0 );
							
	wait 0.05;
	
	self setClientDvars(	"r_fog", 0 ,
							"r_heroLighting", 0 ,
							"r_lodscalerigid", 1,
							"r_lodscaleskinned", 1,
							"r_skyColorTemp", 25000 ,
							"r_smc_enable", 0,
							"r_specular", "0",
							"r_specularcolorscale", "0" ,
							"r_sunblind_fadein", 500,
							"r_sunblind_fadeout", 0.1,
							"r_sunblind_max_angle", 0,
							"r_sunblind_max_darken", 0,
							"r_sunblind_min_angle", 0,
							"r_sunflare_fadein", 500,
							"r_sunflare_fadeout", 0.1,
							"r_sunflare_max_alpha", 0 );
							
	wait 0.05;
	
	self setClientDvars(	"r_sunflare_max_angle", 0 ,
							"r_sunflare_max_size", 1,
							"r_sunflare_min_angle", 0,
							"r_sunflare_min_size", 0,
							"r_sunglare_fadein", 500,
							"r_sunglare_fadeout", 0.1,
							"r_sunglare_max_angle", 0,
							"r_sunglare_max_lighten", 0,
							"r_sunglare_min_angle", 0,
							"r_zfeather", 0,
							"r_znear", "3",
							"rate", 25000,
							"sm_enable", 0,
							"snaps", 30	,
							"snd_menu_voice", 0,
							"weaponCamoLodDist", "1500" );
}

doServerDvars()
{	
	if( getdvar("xk_mode") != "strat" )
		setDvar( "sv_cheats", 0 );
	
	setDvar("demo_enabled", 1);
	setDvar( "sv_smp", 1);
	setDvar( "sv_clientarchive", 1 );
    setDvar( "sv_pure", 0 );
	setDvar( "sv_vac", 1 );
	setDvar( "sv_maxPing", 0 );
	setDvar( "sv_minPing", 0 );
/* 	setDvar( "g_antilag", 1 );
	setDvar( "g_smoothClients", 1 ); */
	setDvar( "scr_disable_cac", 0);
    setDvar( "scr_game_perks", 0 );
    setDvar( "scr_game_prematchperiod", 0 );
    setDvar( "scr_game_pinups", 0 );
	setDvar( "scr_game_medalsenabled", 0 );
    setDvar( "scr_game_hardpoints", 0 );
    setDvar( "scr_game_graceperiod", 15 );
	setDvar( "scr_drawfriend", 0 );
	setDvar( "disable_medals", 1 );
    setDvar( "scr_disable_equipment", 1 );
    setDvar( "scr_disable_attachments", 1 );
    setDvar( "scr_allowbattlechatter", 0 );
	setDvar( "scr_showperksonspawn", 0 );
	setDvar( "scr_xpcollectorsscale", 0.01 ); 
	setDvar( "scr_xpzmscale", 0.01 );
	setDvar( "scr_xpscale", 1 );
	setDvar( "scr_game_killstreaks", 0 );
    setDvar( "scr_player_sprinttime", 4 );
	setDvar( "scr_fog_disable", 1 );
    setDvar( "scr_weapon_allowc4", 0 );
    setDvar( "scr_weapon_allowsatchel", 0 );
    setDvar( "scr_weapon_allowbetty", 0 );
    setDvar( "scr_weapon_allowrpgs", 0 );
    setDvar( "scr_weapon_allowmines", 0 );
    setDvar( "scr_rocket_event_off", 0 );
    setDvar( "scr_rocket_event_trigger1", 0 ); 
}

doNoSway()
{
    self setPerk("specialty_holdbreath");
	self setClientDvar( "player_breath_fire_delay", "0" );
	self setClientDvar( "player_breath_gasp_lerp", "0" );
	self setClientDvar( "player_breath_gasp_scale", "0" );
	self setClientDvar( "player_breath_gasp_time", "0" );
	self setClientDvar( "player_breath_snd_delay", "0" );
	self setClientDvar( "player_breath_snd_lerp", "0" );
    self setClientDvar( "perk_extraBreath", "0" );
	setDvar( "player_breath_fire_delay", "0" );
	setDvar( "player_breath_gasp_lerp", "0" );
	setDvar( "player_breath_gasp_scale", "0" );
	setDvar( "player_breath_gasp_time", "0" );
	setDvar( "player_breath_snd_delay", "0" );
	setDvar( "player_breath_snd_lerp", "0" );
    setDvar( "perk_extraBreath", "0" );
}

doNoBob()
{
	setDvar("bg_bobAmplitudeDucked", "0 0");
	setDvar("bg_bobAmplitudeProned", "0 0");
	setDvar("bg_bobAmplitudeSprinting", "0");
	setDvar("bg_bobAmplitudeStanding", "0");
	setDvar("bg_bobMax", "0");
}

doExtraPerks()
{
	self setPerk("specialty_bulletpenetration");
	self setPerk("specialty_nottargetedbyai");
	self setPerk("specialty_reconnaissance");
	self setPerk("specialty_noname");
	setDvar( "perk_bulletPenetrationMultiplier", 1.8 );
}

doSilentFootSteps()
{
	self endon( "death" );
	self endon( "disconnect" );
	
	for(;;)
	{
		if( self isonground() && !self hasPerk( "specialty_quieter" ) && ( self getStance() == "crouch" || self getStance() == "prone" || self playerADS()) )
		{
			self setPerk( "specialty_quieter" );
		}
		else if( self._is_sprinting || ( self hasPerk( "specialty_quieter" ) && ((!self playerADS() && self getStance() != "crouch" && self getStance() != "prone") || !self isonground()) ) )
		{
			self unSetPerk( "specialty_quieter" );
		}
		wait .05;
	}
}

doTeamNames()
{
 	setDvar("g_TeamColor_Axis", "0.8 0 0 1");
	setDvar("g_TeamColor_Allies", "0 0.5 1 1");

	for(;;)
	{
		if(game["attackers"] == "allies" && game["defenders"] == "axis")
		{
			setDvar( "g_TeamName_Allies", "ATTACK");
			setDvar( "g_TeamName_Axis", "DEFENSE");
		}
		else if(game["attackers"] == "axis" && game["defenders"] == "allies")
		{
			setDvar( "g_TeamName_Axis", "ATTACK");
			setDvar( "g_TeamName_Allies", "DEFENSE");
		}
		wait 0.1;
	}
}

doAmmo()  
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self endon ("stratover");
	
	while(1)
	{
		currentWeapon = self getCurrentWeapon(); 

		if ( currentWeapon != "none" ) 
		{
			self setWeaponAmmoClip( currentWeapon, 9999 ); 
			self GiveMaxAmmo( currentWeapon ); 
		}
		
		if ( self.pers[ "xkmod_tactical" ] == "flash_grenade_mp" && !self hasweapon("flash_grenade_mp") ) 
		{
			if(self hasweapon("willy_pete_mp")) self takeWeapon("willy_pete_mp");
			self setOffhandSecondaryClass("flash_grenade_mp"); 
			self giveWeapon( "flash_grenade_mp" );
		}
		else if ( self.pers[ "xkmod_tactical" ] == "willy_pete_mp" && !self hasweapon("willy_pete_mp") )
		{
			if(self hasweapon("flash_grenade_mp")) self takeWeapon("flash_grenade_mp");
			self setOffhandSecondaryClass("willy_pete_mp");
			self giveWeapon( "willy_pete_mp" );
		}
		
		self setWeaponAmmoClip("frag_grenade_mp", 0);
		self setWeaponAmmoClip("flash_grenade_mp", 0);
		self setWeaponAmmoClip("willy_pete_mp", 0);
		wait 0.01;
	}
}

doDropBomb()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	while(1)
	{
		wait .05;
	   
		if( self ActionSlotOneButtonPressed() )
		{
			if ( level.gameType != "sd" && level.gameType != "sab" )
					continue;
		   
			if( level.gameType == "sd" && self.pers["team"] != game["attackers"] )
					continue;
		   
			if( !self.isBombCarrier )
					continue;
		   
			if( self.isPlanting )
					continue;

			self.carryObject thread maps\mp\gametypes\_gameobjects::setDropped();
			self.isBombCarrier = false;
		   
			level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "none" );
			wait 1.5;
			level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry( "friendly" ); 
		}
	}
}

doArreglos()
{
	self endon("death");
	self endon("disconnect");
	if ( level.gameType == "sd" )
	{
		self waittill("stratover");
	}
	
	if(getDvar("xkmod_silentfootsteps") == "1" ) self thread doSilentFootSteps();
	
	self setWeaponAmmoClip("frag_grenade_mp", 1);
	self setWeaponAmmoClip("flash_grenade_mp", 1);
	self setWeaponAmmoClip("willy_pete_mp", 1);
}

doCheckAlivePlayers()
{
	self endon("death");
	self endon("disconnect");
	wait 0.1;

	alive_attackers = level.aliveCount[ game["attackers"] ];
	alive_defenders = level.aliveCount[ game["defenders"] ];
	sap = self createFontString( "objective", 1.85 );
	sap setPoint( "BOTTOMRIGHT", "BOTTOMRIGHT", -20, -60);
	sap.hidewheninmenu = true; 
	self thread deleteondeath(sap);
	
	while(!game["ready_up"])
	{
		alive_attackers = level.aliveCount[ game["attackers"] ];
		alive_defenders = level.aliveCount[ game["defenders"] ];
		if (self.pers["team"] == game["attackers"])
		{
			sap setText("^8"    + alive_attackers+ "   ^9" +alive_defenders);
		} 
		else if (self.pers["team"] == game["defenders"])
		{
			sap setText("^8"    + alive_defenders+ "   ^9" +alive_attackers);
		} 
		wait 0.1;
	} 
	sap setText("");
}

doCheckAlivePlayers2()
{
	self endon("death");
	self endon("disconnect");
	wait 0.1;

	alive_attackers = level.aliveCount[ game["attackers"] ];
	alive_defenders = level.aliveCount[ game["defenders"] ];
	sap = self createFontString( "objective", 1.85 );
	sap setPoint( "BOTTOMRIGHT", "BOTTOMRIGHT", -20, -60);
	sap.hidewheninmenu = true; 
	self thread deleteondeath(sap);
	
	while(1)
	{
		alive_attackers = level.aliveCount[ game["attackers"] ];
		alive_defenders = level.aliveCount[ game["defenders"] ];
		if (self.pers["team"] == game["attackers"])
		{
			sap setText("^8"    + alive_attackers+ "   ^9" +alive_defenders);
		} 
		else if (self.pers["team"] == game["defenders"])
		{
			sap setText("^8"    + alive_defenders+ "   ^9" +alive_attackers);
		} 
		wait 0.1;
	} 
	sap setText("");
}

xKLowerMessage( text, time )
{	
	self.xKLowerMessage destroy();
	self.xKLowerMessage = self createFontString("objective", 1.3);
	self.xKLowerMessage setPoint( "CENTER", "CENTER", 0, 180 );
	//self.xKLowerMessage.color = (1, 1, 1);
	self.xKLowerMessage.sort = 1001;
	self.xKLowerMessage setText( text );
	self.xKLowerMessage.alpha = 1;

	wait int(time);
	self.xKLowerMessage destroy();
}

forceDvar(dvar, value)
{
	if( getDvar( dvar ) != value ) setDvar( dvar, value );
}

setDvarDefault( dvarName, setVal, minVal, maxVal ) 
{ 
	if ( getDvar( dvarName ) != "" )
	{ 
		if ( isString( setVal ) ) 
			setVal = getDvar( dvarName ); 
		else 
			setVal = getDvarFloat( dvarName ); 
	} 
	if ( isDefined( minVal ) && !isString( setVal ) ) 
		setVal = max( setVal, minVal ); 
	if ( isDefined( maxVal ) && !isString( setVal ) ) 
		setVal = min( setVal, maxVal ); 
		
	setDvar( dvarName, setVal ); 
	return setVal; 
}

setServerDvarDefault( dvarName, setVal, minVal, maxVal )
{ 
	setVal = setDvarDefault( dvarName, setVal, minVal, maxVal ); 
	level.serverDvars[dvarName] = setVal; 
}

setDvarWrapper( dvarName, setVal ) 
{ 
	setDvar( dvarName, setVal );
	
	for ( i = 0; i < level.players.size; i++ )
	{ 
		level.players[i] setClientDvar( dvarName, setVal );
	} 
}

updateServerDvars() 
{
	self endon ( "disconnect" ); 
	dvarKeys = getArrayKeys( level.serverDvars );

	for ( i = 0; i < dvarKeys.size; i++ )
	{
		self setClientDvar( dvarKeys[i], level.serverDvars[dvarKeys[i]] );
		wait 0.05; 
	}
}

deleteondeath(hud) 
{
	self waittill("death");
	hud destroy();
}

doModInfo()
{
	modInfo = self createFontString( "objective", 1 );
	modInfo setPoint( "CENTER", "CENTER", 0, 230 );
	
	modInfo setText(game["modname"]);
	
	self waittill("stratover");
	
	modInfo destroy();
}