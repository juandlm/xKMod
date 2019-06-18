main()  
{ 
	mode = toLower( getDvar( "xk_mode" ) );
	
	if ( !isValidMode( mode ) )
		setDvar("xk_mode", "public"); 
		
	if( getDvar( "mr_rating" ) == "" && mode != "strat" && mode != "cevomatch" )
		setDvar( "mr_rating", 12 );
		
	if ( mode != "strat" && mode != "cevomatch" )
		MR_rating();
	
	if( getDvar( "match_knockout" ) == "" )
	{
		setDvar( "match_knockout", 0);
		matchKnockout();
	}
	
	if( getDvar( "xk_lan" ) == "" )
	{
		setDvar( "xk_lan", 0);
		lanMatch();
	}
	
	setServerConfig(mode);
}

setServerConfig(mode)
{
	if(isCompetitive( mode ))
	{
		setDvar("xkmod_silentfootsteps", "1");
		setDvar("xkmod_strattime", "6");
		setDvar("g_maxDroppedWeapons", "16");
		level maps\mp\gametypes\_weapons::addLimitedWeapon( "l96a1_mp", self, 0 );
		level maps\mp\gametypes\_weapons::addLimitedWeapon( "l96a1_ir_mp", self, 0 );
		level maps\mp\gametypes\_weapons::addLimitedWeapon( "ithaca_mp", self, 0 );
		setDvar( "class_assault_limit", 64 );
		setDvar( "class_smg_limit", 2 ); 
		setDvar( "class_cqb_limit", 1 ); 
		setDvar( "class_sniper_limit", 1 ); 
	}
	if( mode == "eslmatch")
	{
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::esl();
	}
	else if( mode == "1v1_eslmatch")
	{	
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::esl1v1();
	}
	else if( mode == "2v2_eslmatch")
	{	
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::esl();
	}
	else if( mode == "cevomatch")
	{
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::cevo();
	}
	else if( mode == "cbmatch")
	{
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::clanbase();
	}
	else if( mode == "cbmatch_hc")
	{
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod\rules\comp::clanbaseHC();
	}
	else if( mode == "mymatch")
	{
		game["is_public_mode"] = 0;
		game["is_match_mode"] = 1;
		xkmod_ruleset\custom_comp::main();
		setDvar( "scr_teambalance", 0 );
		setDvar( "g_allowVote", 0 );
		setDvar( "g_deadChat", 0 );
		setDvar( "scr_game_allowfinalkillcam", 0 );
		setDvar( "scr_game_allowkillcam", 0 );
		setDvar( "scr_game_spectatetype", 1 );
		setDvar( "scr_game_matchstarttime", 0 );
		setDvar( "sv_kickBanTime", 60 );
		setDvar( "sv_reconnectlimit", 0 );
		setDvar( "sv_timeout", 600 );
		setDvar( "sv_floodProtect", 4 );
		setDvar( "sv_voice", 0 );
		setDvar( "scr_intermission_time", 15 );
		setDvar( "scr_player_forcerespawn", 1 );
		setDvar( "scr_player_suicidespawndelay", 0 );
		setDvar( "scr_teamKillPunishCount", 0 );
		setDvar( "scr_team_kickteamkillers", 0 );
		setDvar( "scr_team_teamkillspawndelay", 0 );
		setDvar( "scr_team_fftype", 1 );
	}
	else if ( mode == "strat")
	{
		game["is_match_mode"] = 0;
		game["is_public_mode"] = 0;
		xkmod\stratmode::main();
	}
	else if ( mode == "public")
	{		
		game["is_match_mode"] = 0;
		game["is_public_mode"] = 1;
		xkmod_ruleset\custom_public::main();
	}
}

MR_rating()
{
	
	mr_rating = getDvarInt( "mr_rating" );
	
	setDvar( "scr_" + level.gametype + "_roundswitch", int( mr_rating ) );
	setDvar( "scr_" + level.gametype + "_roundlimit", int( mr_rating ) * 2 );
}

matchKnockout()
{
	scoreswitch = getDvarInt("scr_sd_roundswitch");
	
	if(level.gametype == "sd")
	{
		if(getDvarInt("match_knockout") == 1)
		{
			setDvar("scr_sd_scorelimit", int(scoreswitch) + 1 );
		}
		else if(getDvarInt("match_knockout") == 0)
		{
			setDvar("scr_sd_scorelimit", 0 );
		}
	}
}

lanMatch()
{
	if(getDvarInt("xk_lan") == 1)
	{
		setDvar( "g_antilag", 0 );
		setDvar( "g_smoothClients", 0 );
	}
	else if(getDvarInt("xk_lan") == 0)
	{
		setDvar( "g_antilag", 1 );
		setDvar( "g_smoothClients", 1 );
	}
}

isCompetitive( mode )
{
	if ( mode == "eslmatch" || mode == "cevomatch" || mode == "cbmatch" || mode == "mymatch" || mode == "1v1_eslmatch" || mode == "cbmatch_hc" )
		return true; 
	
	else
		return false;
}

isValidMode( mode ) 
{ 
	if ( mode == "eslmatch" || mode == "cevomatch" || mode == "cbmatch" || mode == "mymatch" || mode == "public" || mode == "strat" || mode == "1v1_eslmatch" || mode == "cbmatch_hc" )
	return true; 
	
	else
	return false;
}

modesMonitor() 
{
	old_mode = toLower( getDvar( "xk_mode" ) );
	old_mrat = getDvarInt( "mr_rating" );
	old_knout = getDvarInt( "match_knockout" );
	old_lan = getDvarInt( "xk_lan" );
	
	for(;;) 
	{
		mode = toLower( getDvar( "xk_mode" ) );
		mrat = getDvarInt( "mr_rating" );
		knout = getDvarInt( "match_knockout" );
		lan = getDvarInt( "xk_lan" );
		
		if ( mode != old_mode ) 
		{
			if ( isValidMode( mode ) )
			{ 
				level notify ( "restarting" );
				iPrintLN( "Changing to ^3"+ mode +" ^7game mode.\nRestarting the map..." );
				setServerConfig(mode);
				setDvar( "xk_mode", mode ); 
				wait 2; 
				map_restart( false ); 
			} 
			else 
			{ 
				if ( isDefined( mode ) && !isValidMode( mode ) )
				iPrintLN( "Invalid game mode: ^3" + mode + "\n^7Available modes: ^3public^7, ^3eslmatch^7, ^3cevomatch^7, ^3cbmatch^7, ^3mymatch ^7and ^3strat^7." );
				setDvar( "xk_mode", old_mode ); 
			} 
		} 
		else if ( mrat != old_mrat ) 
		{
			iPrintLN( "MR Rating changed.\nRestarting the map..." );
			matchKnockout();
			map_restart( false ); 
			break;
		} 
		else if ( knout != old_knout)
		{
			if(mode != "strat" && mode != "cevomatch")
			{
				matchKnockout();
				iPrintLN( "Knockout setting changed.\nRestarting the map..." );
				map_restart( false ); 
				break;
			}
			else if(mode == "strat" || mode == "cevomatch")
			{
				if ( isDefined( mode ))
					iPrintLN( "Knockout can't be activated under this game mode." );
				
				setDvar("match_knockout", old_knout);
				matchKnockout();
			}
		}
		else if ( lan != old_lan )
		{
			lanMatch();
			iPrintLN( "LAN Match setting changed.\nRestarting the map..." );
			map_restart( false ); 
			break;
		}
		wait 0.1; 
	} 
}