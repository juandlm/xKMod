//**********************************************************************************************\\
//EACH AND EVERY SINGLE CONFIGURATION BELOW WAS DONWLOADED FROM THE RESPECTIVE LEAGUE WEBSITES	\\
//ESL: http://gfx.esl.eu/gfx/media/eu/codbo/config/configpack.rar								\\
//CEVO: http://www.cevo.com/FILES/cevo_cod_blackops_config.zip									\\
//CLANBASE: http://www.clanbaseradio.com/codbo/cbwar.cfg										\\
//**********************************************************************************************\\

esl()
{
	setDvar( "scr_hardcore", "0" );
	setDvar( "scr_disable_attachments", "1" );
	setDvar( "scr_intermission_time", "15" );
	setDvar( "scr_game_graceperiod", "15" );
	setDvar( "sv_privateClients", "0" );
	setDvar( "sv_vac", "1" );
	setDvar( "scr_team_kickteamkillers", "0" );
	setDvar( "scr_team_teamkillspawndelay", "0" );
	setDvar( "playlist_enabled", "0" );
	setDvar( "scr_player_sprinttime", "4" );
	setDvar( "scr_player_suicidespawndelay", "0" );
	setDvar( "scr_teambalance", "0" );
	setDvar( "sv_kickBanTime", "60" ); // Seconds
	setDvar( "sv_reconnectlimit", "0" );
	setDvar( "sv_timeout", "600" );
	setDvar( "sv_zombietime", "2" );
	setDvar( "g_inactivity", "0" );
	setDvar( "scr_game_spectatetype", "1" );
	setDvar( "scr_game_allowfinalkillcam", "0" );
	setDvar( "scr_game_allowkillcam", "0" );
	setDvar( "scr_player_forcerespawn", "1" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "scr_game_perks", "0" );
	setDvar( "scr_game_hardpoints", "0" );
	setDvar( "scr_game_killstreaks", "0" );
	setDvar( "scr_allowbattlechatter", "0" );
	setDvar( "scr_disable_equipment", "1" );
	setDvar( "scr_disable_attachments", "1" );
	setDvar( "scr_rocket_event_trigger1", "0" );
	setDvar( "scr_rocket_event_off", "0" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "g_allowvote", "0" );
	setDvar( "sv_floodProtect", "4" );
	setDvar( "sv_maxPing", "0" );
	setDvar( "sv_maxRate", "25000" );
	setDvar( "sv_minPing", "0" );
	setDvar( "scr_weapon_allowc4", "0" );
	setDvar( "scr_weapon_allowsatchel", "0" );
	setDvar( "scr_weapon_allowbetty", "0" );
	setDvar( "scr_weapon_allowrpgs", "0" );
	setDvar( "scr_weapon_allowmines", "0" );
	setDvar( "scr_game_pinups", "0" );
	setDvar( "g_revive", "0" );
	setDvar( "g_redCrosshairs", "0" );
	setDvar( "ui_hud_showobjicons", "1" );
	setDvar( "voice_deadChat", "0" );
	setDvar( "voice_global", "0" );
	setDvar( "sv_voice", "0" );
	setDvar( "sv_voicequality", "3" );
	setDvar( "g_voiceChatTalkingDuration", "500" );
	setDvar( "g_allow_teamchange", "1" );


	//Search and Destroy
	setDvar( "scr_sd_globalbattlechatterprobability", "0" );
	setDvar( "scr_sd_bombtimer", "45" );
	setDvar( "scr_sd_defusetime", "7.5" );
	setDvar( "scr_sd_game_spectatetype", "1" );
	setDvar( "scr_sd_multibomb", "0" );
	setDvar( "scr_sd_planttime", "5" );
	setDvar( "scr_sd_playerrespawndelay", "0" );
	setDvar( "scr_sd_timelimit", "2.5" );
	setDvar( "scr_sd_waverespawndelay", "0" );

	// Team Deathmatch
	setDvar( "scr_tdm_globalbattlechatterprobability", "0" );
	setDvar( "scr_tdm_bonus_leader", "0" );
	setDvar( "scr_tdm_numlives", "0" );
	setDvar( "scr_tdm_playerrespawndelay", "0" );
	setDvar( "scr_tdm_roundlimit", "1" );
	setDvar( "scr_tdm_score_assist", "0" );
	setDvar( "scr_tdm_score_death", "0" );
	setDvar( "scr_tdm_score_headshot", "0" );
	setDvar( "scr_tdm_score_kill", "100" );
	setDvar( "scr_tdm_scorelimit", "0" );
	setDvar( "scr_tdm_score_suicide", "0" );
	setDvar( "scr_tdm_timelimit", "15" );
	setDvar( "scr_tdm_waverespawndelay", "0" );

	//Capture the Flag
	setDvar( "scr_ctf_globalbattlechatterprobability", "0" );
	setDvar( "scr_ctf_enemycarriervisible", "0" );
	setDvar( "scr_ctf_flagrespawntime", "0" );
	setDvar( "scr_ctf_idleflagreturntime", "30" );
	setDvar( "scr_ctf_numlives", "0" );
	setDvar( "scr_ctf_playerrespawndelay", "10" );
	setDvar( "scr_ctf_roundlimit", "3" );
	setDvar( "scr_ctf_roundswitch", "1" );
	setDvar( "scr_ctf_scorelimit", "10" );
	setDvar( "scr_ctf_timelimit", "10" );
	setDvar( "scr_ctf_touchreturn", "1" );
	setDvar( "scr_ctf_waverespawndelay", "0" );

	// Demolition Gametype Settings
	//
	setDvar( "scr_dem_globalbattlechatterprobability", "0" );
	setDvar( "scr_dem_bombtimer", "45" );
	setDvar( "scr_dem_defusetime", "7.5" );
	setDvar( "scr_dem_extratime", "5" );
	setDvar( "scr_dem_numlives", "0" );
	setDvar( "scr_dem_planttime", "5" );
	setDvar( "scr_dem_roundlimit", "1" );
	setDvar( "scr_dem_roundswitch", "0" );
	setDvar( "scr_dem_scorelimit", "0" );
	setDvar( "scr_dem_timelimit", "10" );

	//
	// Domination Gametype Settings
	//
	setDvar( "scr_dom_globalbattlechatterprobability", "0" );
	setDvar( "scr_dom_flagcapturetime", "10" );
	setDvar( "scr_dom_numlives", "0" );
	setDvar( "scr_dom_playerrespawndelay", "0" );
	setDvar( "scr_dom_roundlimit", "1" );
	setDvar( "scr_dom_scorelimit", "0" );
	setDvar( "scr_dom_timelimit", "10" );
	setDvar( "scr_dom_waverespawndelay", "0" );

	// Headquarters Gametype Settings
	//
	setDvar( "koth_autodestroytime", "60" );
	setDvar( "scr_koth_globalbattlechatterprobability", "0" );
	setDvar( "koth_capturetime", "20" );
	setDvar( "koth_delayPlayer", "0" );
	setDvar( "koth_destroytime", "10" );
	setDvar( "koth_kothmode", "0" );
	setDvar( "scr_koth_numlives", "0" );
	setDvar( "scr_koth_playerrespawndelay", "0" );
	setDvar( "scr_koth_roundlimit", "1" );
	setDvar( "scr_koth_roundswitch", "0" );
	setDvar( "scr_koth_scorelimit", "0" );
	setDvar( "koth_spawnDelay", "60" );
	setDvar( "koth_spawntime", "45" );
	setDvar( "scr_koth_timelimit", "10" );
	setDvar( "scr_koth_waverespawndelay", "0" );


	//
	// Sabotage Gametype Settings
	//
	setDvar( "scr_sab_globalbattlechatterprobability", "0" );
	setDvar( "scr_sab_bombtimer", "45" );
	setDvar( "scr_sab_defusetime", "7.5" );
	setDvar( "scr_sab_hotpotato", "0" );
	setDvar( "scr_sab_numlives", "0" );
	setDvar( "scr_sab_planttime", "5" );
	setDvar( "scr_sab_playerrespawndelay", "10" );
	setDvar( "scr_sab_roundlimit", "1" );
	setDvar( "scr_sab_roundswitch", "0" );
	setDvar( "scr_sab_scorelimit", "0" );
	setDvar( "scr_sab_timelimit", "10" );
	setDvar( "scr_sab_waverespawndelay", "0" );

}

esl1v1()
{
	setDvar( "scr_hardcore", "0" );
	setDvar( "scr_disable_attachments", "1" );
	setDvar( "scr_intermission_time", "15" );
	setDvar( "scr_game_graceperiod", "15" );
	setDvar( "sv_privateClients", "0" );
	setDvar( "sv_vac", "1" );
	setDvar( "scr_team_kickteamkillers", "0" );
	setDvar( "scr_team_teamkillspawndelay", "0" );
	setDvar( "playlist_enabled", "0" );
	setDvar( "scr_player_sprinttime", "4" );
	setDvar( "scr_player_suicidespawndelay", "0" );
	setDvar( "scr_teambalance", "0" );
	setDvar( "sv_kickBanTime", "60" ); // Seconds
	setDvar( "sv_reconnectlimit", "0" );
	setDvar( "sv_timeout", "600" );
	setDvar( "sv_zombietime", "2" );
	setDvar( "g_inactivity", "0" );
	setDvar( "scr_game_spectatetype", "1" );
	setDvar( "scr_game_allowfinalkillcam", "0" );
	setDvar( "scr_game_allowkillcam", "0" );
	setDvar( "scr_player_forcerespawn", "1" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "scr_game_perks", "0" );
	setDvar( "scr_game_hardpoints", "0" );
	setDvar( "scr_game_killstreaks", "0" );
	setDvar( "scr_allowbattlechatter", "0" );
	setDvar( "scr_disable_equipment", "1" );
	setDvar( "scr_disable_attachments", "1" );
	setDvar( "scr_rocket_event_trigger1", "0" );
	setDvar( "scr_rocket_event_off", "0" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "g_allowvote", "0" );
	setDvar( "sv_floodProtect", "4" );
	setDvar( "sv_maxPing", "0" );
	setDvar( "sv_maxRate", "25000" );
	setDvar( "sv_minPing", "0" );
	setDvar( "scr_weapon_allowc4", "0" );
	setDvar( "scr_weapon_allowsatchel", "0" );
	setDvar( "scr_weapon_allowbetty", "0" );
	setDvar( "scr_weapon_allowrpgs", "0" );
	setDvar( "scr_weapon_allowmines", "0" );
	setDvar( "scr_game_pinups", "0" );
	setDvar( "g_revive", "0" );
	setDvar( "g_redCrosshairs", "0" );
	setDvar( "ui_hud_showobjicons", "1" );
	setDvar( "voice_deadChat", "0" );
	setDvar( "voice_global", "0" );
	setDvar( "sv_voice", "0" );
	setDvar( "sv_voicequality", "3" );
	setDvar( "g_voiceChatTalkingDuration", "500" );
	setDvar( "g_allow_teamchange", "1" );
	
	// SD Settings
	setDvar( "mr_rating", 8 );
	setDvar( "scr_sd_globalbattlechatterprobability", "0" );
	setDvar( "scr_sd_bombtimer", "45" );
	setDvar( "scr_sd_defusetime", "7.5" );
	setDvar( "scr_sd_game_spectatetype", "1" );
	setDvar( "scr_sd_multibomb", "0" );
	setDvar( "scr_sd_numlives", "1" );
	setDvar( "scr_sd_planttime", "5" );
	setDvar( "scr_sd_playerrespawndelay", "0" );
	setDvar( "scr_sd_timelimit", "2.5" );
	setDvar( "scr_sd_waverespawndelay", "0" );

	// DM Settings
	setDvar( "scr_dm_globalbattlechatterprobability", "0" );
	setDvar( "scr_dm_bonus_leader", "0" );
	setDvar( "scr_dm_numlives", "0" );
	setDvar( "scr_dm_playerrespawndelay", "0" );
	setDvar( "scr_dm_roundlimit", "1" );
	setDvar( "scr_dm_scorelimit", "0" );
	setDvar( "scr_dm_score_suicide", "0" );
	setDvar( "scr_dm_timelimit", "10" );
	setDvar( "scr_dm_waverespawndelay", "0" );
}

cevo()
{
	//
	// 'Basic' Settings
	//


	setDvar( "g_redCrosshairs", "0" );
	setDvar( "scr_allowbattlechatter", "0" );
	setDvar( "scr_disable_attachments", "1" );
	setDvar( "scr_game_perks", "0" );
	setDvar( "scr_disable_equipment", "1" );
	setDvar( "scr_game_allowkillcam", "0" );
	setDvar( "scr_player_forcerespawn", "1" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "scr_game_spectatetype", "1" );
	setDvar( "scr_hardcore", "0" );
	setDvar( "scr_team_kickteamkillers", "0" );
	setDvar( "scr_team_teamkillspawndelay", "0" );
	setDvar( "playlist_enabled", "0" );
	setDvar( "scr_player_sprinttime", "4" );
	setDvar( "scr_player_suicidespawndelay", "0" );
	setDvar( "scr_teambalance", "0" );

	//
	// 'Client' Settings
	//
	setDvar( "sv_disableClientConsole", "0" );
	setDvar( "sv_reconnectlimit", "3" );
	setDvar( "sv_timeout", "240" );
	setDvar( "sv_zombietime", "2" );
	setDvar( "g_inactivity", "0" );

	//
	// 'KillStreaks' Settings
	//
	setDvar( "scr_game_hardpoints", "0" );
	setDvar( "scr_game_killstreaks", "0" );
	setDvar( "scr_hardpoint_allowdogs", "0" );
	setDvar( "scr_hardpoint_allowhelicopter_comlink", "0" );
	setDvar( "scr_hardpoint_allowradardirection", "0" );
	setDvar( "scr_hardpoint_allowsupply", "0" );
	setDvar( "scr_hardpoint_allowhelicopter_gunner", "0" );
	setDvar( "scr_hardpoint_allowcounteruav", "0" );
	setDvar( "scr_hardpoint_allowhelicopter_player", "0" );
	setDvar( "scr_hardpoint_allowmortar", "0" );
	setDvar( "scr_hardpoint_allownapalm", "0" );
	setDvar( "scr_hardpoint_allowrcbomb", "0" );
	setDvar( "scr_hardpoint_allowairstrike", "0" );
	setDvar( "scr_hardpoint_allowauto_turret", "0" );
	setDvar( "scr_hardpoint_allowauto_turret", "0" );
	setDvar( "scr_hardpoint_allowradar", "0" );

	//
	// 'Server' Settings
	//
	setDvar( "g_allowvote", "1" );
	setDvar( "sv_floodProtect", "4" );
	setDvar( "sv_maxPing", "0" );
	setDvar( "sv_maxRate", "25000" );
	setDvar( "sv_minPing", "0" );
	setDvar( "sv_privateClients", "0" );
	setDvar( "sv_kickBanTime", "300" );
	setDvar( "sv_vac", "1" );

	//
	// 'Tweakables' Settings
	//
	setDvar( "g_deadChat", "0" );
	setDvar( "scr_game_allowfinalkillcam", "1" );
	setDvar( "scr_team_allowHardpointStreakAfterDeath", "0" );
	setDvar( "scr_game_allowkillcam", "0" );
	setDvar( "g_allow_teamchange", "1" );
	setDvar( "scr_player_allowrevive", "0" );
	setDvar( "scr_game_deathpointloss", "0" );
	setDvar( "scr_team_fftype", "1" );
	setDvar( "scr_game_onlyheadshots", "0" );
	setDvar( "scr_team_teamkillspawndelay", "0" );
	setDvar( "scr_game_allowfinalkillcam", "1" );
	setDvar( "scr_player_sprinttime", "4" );
	setDvar( "scr_game_suicidepointloss", "0" );
	setDvar( "scr_player_suicidespawndelay", "0" );
	setDvar( "scr_teambalance", "0" );
	setDvar( "scr_team_teamkillpointloss", "1" );
	setDvar( "scr_team_teamkillspawndelay", "0" );
	setDvar( "scr_team_teamkillerplaylistbanpenalty", "0" );
	setDvar( "scr_team_teamkillerplaylistbanquantum", "0" );

	//
	// 'VoIP' Settings
	//
	setDvar( "voice_deadChat", "0" );
	setDvar( "voice_global", "0" );
	setDvar( "sv_voicequality", "3" );
	setDvar( "g_voiceChatTalkingDuration", "500" );
	setDvar( "sv_voice", "1" );

	//
	// 'Search and Destroy' Gametype Settings
	//
	setDvar( "scr_sd_globalbattlechatterprobability", "0" );
	setDvar( "scr_sd_globalbattlechatterprobability", "0" );
	setDvar( "scr_sd_bombtimer", "55" );
	setDvar( "scr_sd_defusetime", "7" );
	setDvar( "scr_sd_game_spectatetype", "1" );
	setDvar( "scr_sd_multibomb", "0" );
	setDvar( "scr_sd_numlives", "1" );
	setDvar( "scr_sd_planttime", "5" );
	setDvar( "scr_sd_playerrespawndelay", "0" );
	setDvar( "scr_sd_roundlimit", "0" );
	setDvar( "scr_sd_roundswitch", "6" );
	setDvar( "scr_sd_scorelimit", "13" );
	setDvar( "scr_sd_timelimit", "1.5" );
	setDvar( "scr_sd_waverespawndelay", "0" );

	//
	// Playlist dvars
	//
	setDvar( "playlist_enabled", "0" );
	setDvar( "playlist_excludeMap", "" );
	setDvar( "playlist_excludeGametype", "" );
	setDvar( "playlist_excludeGametypeMap", "" );
}

clanbase()
{
	//
	// Server Settings
	//

	setDvar("scr_hardcore", "0");

	setDvar("scr_player_sprinttime", "4");
	setDvar("scr_player_forcerespawn", "1");
	setDvar("scr_player_suicidespawndelay", "0");
	setDvar("scr_intermission_time", "10");
	setDvar("scr_game_graceperiod", "10");
	setDvar("scr_game_spectatetype", "1");
	setDvar("scr_game_allowfinalkillcam", "0");
	setDvar("scr_game_allowkillcam", "0");
	setDvar("scr_game_perks", "0");
	setDvar("scr_game_hardpoints", "0");
	setDvar("scr_game_killstreaks", "0");
	setDvar("scr_game_pinups", "0");
	setDvar("scr_team_fftype", "1");
	setDvar("scr_team_kickteamkillers", "0");
	setDvar("scr_team_teamkillspawndelay", "0");
	setDvar("scr_team_fftype", "1");
	setDvar("scr_teambalance", "0");
	setDvar("scr_allowbattlechatter", "0");
	setDvar("scr_disable_equipment", "1");
	setDvar("scr_disable_attachments", "1");
	setDvar("scr_rocket_event_trigger1", "0");
	setDvar("scr_rocket_event_off", "0");
	setDvar("scr_weapon_allowc4", "0");
	setDvar("scr_weapon_allowsatchel", "0");
	setDvar("scr_weapon_allowbetty", "0");
	setDvar("scr_weapon_allowrpgs", "0");
	setDvar("scr_weapon_allowmines", "0");
	setDvar("ui_hud_showobjicons", "1");
	setDvar("playlist_enabled", "0");
	setDvar("voice_deadChat", "0");
	setDvar("voice_global", "0");
	setDvar("g_revive", "0");
	setDvar("g_redCrosshairs", "0");
	setDvar("g_allowvote", "0");
	setDvar("g_voiceChatTalkingDuration", "500");
	setDvar("g_allow_teamchange", "1");
	setDvar("g_inactivity", "0");
	setDvar("sv_vac", "1");
	setDvar("sv_floodProtect", "4");
	setDvar("sv_maxPing", "0");
	setDvar("sv_maxRate", "25000");
	setDvar("sv_minPing", "0");
	setDvar("sv_zombietime", "2");
	setDvar("sv_voice", "0");
	setDvar("sv_voicequality", "3");
	setDvar("sv_privateClients", "0");
	setDvar("sv_kickBanTime", "60"); // Seconds
	setDvar("sv_reconnectlimit", "0");
	setDvar("sv_timeout", "600");



	//
	// Search and Destroy Settings
	//
	setDvar("scr_sd_globalbattlechatterprobability", "0");
	setDvar("scr_sd_bombtimer", "45");
	setDvar("scr_sd_defusetime", "7.5");
	setDvar("scr_sd_game_spectatetype", "1");
	setDvar("scr_sd_multibomb", "0");
	setDvar("scr_sd_planttime", "5");
	setDvar("scr_sd_playerrespawndelay", "0");
	setDvar("scr_sd_timelimit", "2.5");
	setDvar("scr_sd_waverespawndelay", "0");

	//
	// Capture The Flag Settings
	//
	setDvar("scr_ctf_globalbattlechatterprobability", "0");
	setDvar("scr_ctf_enemycarriervisible", "0");
	setDvar("scr_ctf_flagrespawntime", "0");
	setDvar("scr_ctf_idleflagreturntime", "30");
	setDvar("scr_ctf_numlives", "0");
	setDvar("scr_ctf_playerrespawndelay", "10");
	setDvar("scr_ctf_roundlimit", "2");
	setDvar("scr_ctf_roundswitch", "1");
	setDvar("scr_ctf_scorelimit", "0");
	setDvar("scr_ctf_timelimit", "15");
	setDvar("scr_ctf_touchreturn", "1");
	setDvar("scr_ctf_waverespawndelay", "0");
	setDvar("scr_ctf_game_spectatetype", "1");

	//
	// Deathmatch Settings
	//
	setDvar("scr_dm_globalbattlechatterprobability", "100");
	setDvar("scr_dm_bonus_leader", "0");
	setDvar("scr_dm_numlives", "0");
	setDvar("scr_dm_playerrespawndelay", "0");
	setDvar("scr_dm_roundlimit", "2");
	setDvar("scr_dm_score_death", "0");
	setDvar("scr_dm_score_headshot", "0");
	setDvar("scr_dm_score_kill", "100");
	setDvar("scr_dm_scorelimit", "0");
	setDvar("scr_dm_score_suicide", "100");
	setDvar("scr_dm_timelimit", "15");
	setDvar("scr_dm_waverespawndelay", "0");

	//
	// Team Deathmatch Settings
	//
	setDvar("scr_tdm_globalbattlechatterprobability", "0");
	setDvar("scr_tdm_bonus_leader", "0");
	setDvar("scr_tdm_numlives", "0");
	setDvar("scr_tdm_playerrespawndelay", "0");
	setDvar("scr_tdm_roundlimit", "2");
	setDvar("scr_tdm_score_assist", "50");
	setDvar("scr_tdm_score_death", "0");
	setDvar("scr_tdm_score_headshot", "0");
	setDvar("scr_tdm_score_kill", "100");
	setDvar("scr_tdm_scorelimit", "0");
	setDvar("scr_tdm_score_suicide", "100");
	setDvar("scr_tdm_timelimit", "15");
	setDvar("scr_tdm_waverespawndelay", "0");
	setDvar("scr_tdm_game_spectatetype", "1");
}

clanbaseHC()
{
	//
	// Server Settings
	//

	setDvar("scr_hardcore", "1");
	setDvar("scr_player_maxhealth", "30");
	setDvar("scr_player_healthregentime", "0");

	setDvar("scr_player_sprinttime", "4");
	setDvar("scr_player_forcerespawn", "1");
	setDvar("scr_player_suicidespawndelay", "0");
	setDvar("scr_intermission_time", "10");
	setDvar("scr_game_graceperiod", "10");
	setDvar("scr_game_spectatetype", "1");
	setDvar("scr_game_allowfinalkillcam", "0");
	setDvar("scr_game_allowkillcam", "0");
	setDvar("scr_game_perks", "0");
	setDvar("scr_game_hardpoints", "0");
	setDvar("scr_game_killstreaks", "0");
	setDvar("scr_game_pinups", "0");
	setDvar("scr_team_fftype", "1");
	setDvar("scr_team_kickteamkillers", "0");
	setDvar("scr_team_teamkillspawndelay", "0");
	setDvar("scr_team_fftype", "1");
	setDvar("scr_teambalance", "0");
	setDvar("scr_allowbattlechatter", "0");
	setDvar("scr_disable_equipment", "1");
	setDvar("scr_disable_attachments", "1");
	setDvar("scr_rocket_event_trigger1", "0");
	setDvar("scr_rocket_event_off", "0");
	setDvar("scr_weapon_allowc4", "0");
	setDvar("scr_weapon_allowsatchel", "0");
	setDvar("scr_weapon_allowbetty", "0");
	setDvar("scr_weapon_allowrpgs", "0");
	setDvar("scr_weapon_allowmines", "0");
	setDvar("ui_hud_showobjicons", "1");
	setDvar("playlist_enabled", "0");
	setDvar("voice_deadChat", "0");
	setDvar("voice_global", "0");
	setDvar("g_revive", "0");
	setDvar("g_redCrosshairs", "0");
	setDvar("g_allowvote", "0");
	setDvar("g_voiceChatTalkingDuration", "500");
	setDvar("g_allow_teamchange", "1");
	setDvar("g_inactivity", "0");
	setDvar("sv_vac", "1");
	setDvar("sv_floodProtect", "4");
	setDvar("sv_maxPing", "0");
	setDvar("sv_maxRate", "25000");
	setDvar("sv_minPing", "0");
	setDvar("sv_zombietime", "2");
	setDvar("sv_voice", "0");
	setDvar("sv_voicequality", "3");
	setDvar("sv_privateClients", "0");
	setDvar("sv_kickBanTime", "60"); // Seconds
	setDvar("sv_reconnectlimit", "0");
	setDvar("sv_timeout", "600");



	//
	// Search and Destroy Settings
	//
	setDvar("scr_sd_globalbattlechatterprobability", "0");
	setDvar("scr_sd_bombtimer", "45");
	setDvar("scr_sd_defusetime", "7.5");
	setDvar("scr_sd_game_spectatetype", "1");
	setDvar("scr_sd_multibomb", "0");
	setDvar("scr_sd_planttime", "5");
	setDvar("scr_sd_playerrespawndelay", "0");
	setDvar("scr_sd_timelimit", "2.5");
	setDvar("scr_sd_waverespawndelay", "0");

	//
	// Capture The Flag Settings
	//
	setDvar("scr_ctf_globalbattlechatterprobability", "0");
	setDvar("scr_ctf_enemycarriervisible", "0");
	setDvar("scr_ctf_flagrespawntime", "0");
	setDvar("scr_ctf_idleflagreturntime", "30");
	setDvar("scr_ctf_numlives", "0");
	setDvar("scr_ctf_playerrespawndelay", "10");
	setDvar("scr_ctf_roundlimit", "2");
	setDvar("scr_ctf_roundswitch", "1");
	setDvar("scr_ctf_scorelimit", "0");
	setDvar("scr_ctf_timelimit", "15");
	setDvar("scr_ctf_touchreturn", "1");
	setDvar("scr_ctf_waverespawndelay", "0");
	setDvar("scr_ctf_game_spectatetype", "1");

	//
	// Deathmatch Settings
	//
	setDvar("scr_dm_globalbattlechatterprobability", "100");
	setDvar("scr_dm_bonus_leader", "0");
	setDvar("scr_dm_numlives", "0");
	setDvar("scr_dm_playerrespawndelay", "0");
	setDvar("scr_dm_roundlimit", "2");
	setDvar("scr_dm_score_death", "0");
	setDvar("scr_dm_score_headshot", "0");
	setDvar("scr_dm_score_kill", "100");
	setDvar("scr_dm_scorelimit", "0");
	setDvar("scr_dm_score_suicide", "100");
	setDvar("scr_dm_timelimit", "15");
	setDvar("scr_dm_waverespawndelay", "0");

	//
	// Team Deathmatch Settings
	//
	setDvar("scr_tdm_globalbattlechatterprobability", "0");
	setDvar("scr_tdm_bonus_leader", "0");
	setDvar("scr_tdm_numlives", "0");
	setDvar("scr_tdm_playerrespawndelay", "0");
	setDvar("scr_tdm_roundlimit", "2");
	setDvar("scr_tdm_score_assist", "50");
	setDvar("scr_tdm_score_death", "0");
	setDvar("scr_tdm_score_headshot", "0");
	setDvar("scr_tdm_score_kill", "100");
	setDvar("scr_tdm_scorelimit", "0");
	setDvar("scr_tdm_score_suicide", "100");
	setDvar("scr_tdm_timelimit", "15");
	setDvar("scr_tdm_waverespawndelay", "0");
	setDvar("scr_tdm_game_spectatetype", "1");
}