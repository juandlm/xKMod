#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include xKMod\_xkmod;

setDvarsFromClass( classType )
{
	defaultprimary = "";
	
	switch(	classType )
	{
		case "assault":
		defaultprimary = "ak47";
		break;
		
		case "smg":
		defaultprimary = "ak74u";
		break;	
		
		case "cqb":
		defaultprimary = "ithaca";
		break;
		
		case "sniper":
		defaultprimary = "l96a1";
		break;
	}
	
	self setClientDvars(	"xkmod_cac_primary", "menu_mp_weapons_"+defaultprimary,
							"xkmod_cac_secondary", "menu_mp_weapons_python",
							"xkmod_cac_grenade", "hud_us_flashgrenade",
							"xkmod_cac_camo", "");
}

setDefaultClassChoice( classType )
{
	self.pers[ "xkmod_class" ] = classType;
	self.class = classType;
	self setClientDvar( "selected_class", classType );
	self setDvarsFromClass( classType );
	
	defaultdataforprimary = "";
	
	switch ( classType ) 
	{ 
		case "assault": 
		defaultdataforprimary = "ak47_mp";
		break;

		case "smg": 
		defaultdataforprimary = "ak74u_mp";
		break; 
		
		case "cqb": 
		defaultdataforprimary = "ithaca_mp";
		break; 
		
		case "sniper":
		defaultdataforprimary = "l96a1_mp";
		break; 
	}
	
	self.pers[ "xkmod_primary" ] = defaultdataforprimary;
	self.pers[ "xkmod_secondary" ] = "python_mp";
	self.pers[ "xkmod_tactical" ] = "flash_grenade_mp";
	self.pers[ "xkmod_camo" ] = "0";
}
				
giveLoadout(team, class)
{
	primary = self.pers[ "xkmod_primary" ];
	sidearm = self.pers[ "xkmod_secondary" ];
	lethal = "frag_grenade_mp";
	tactical = self.pers[ "xkmod_tactical" ];
	camo = int(self.pers[ "xkmod_camo" ]);
	
	if( isDefined( sidearm ) && (sidearm != "" && sidearm != "weapon_null_mp") ) 
	{
		self giveWeapon( sidearm );
		self setSpawnWeapon( sidearm );
		self giveMaxAmmo( sidearm );
	}
	if( isDefined( primary ) )
	{
		self giveWeapon( primary, 0, self calcWeaponOptions ( camo, 0, 0, 0, 0 ) );
		self setSpawnWeapon( primary );
		self giveMaxAmmo( primary );
	}
	if ( isDefined( lethal ) && (lethal != "" && lethal != "weapon_null_mp") )
	{
		self GiveWeapon( lethal );
		self SetWeaponAmmoClip( lethal, 1 );
		self SwitchToOffhand( lethal );
	}
	if ( isDefined( tactical ) && (tactical != "" && tactical != "weapon_null_mp") )
	{
		self setOffhandSecondaryClass( tactical );
		self giveWeapon( tactical );
		self SetWeaponAmmoClip( tactical, 1 );
	}
	
	self.cac_body_type = self maps\mp\gametypes\_class::getDefaultClassSlotWithExclusions( class, "body" );
	self.cac_head_type = self maps\mp\gametypes\_armor::get_default_head();
	self.cac_hat_type = "none";
	
	self maps\mp\gametypes\_armor::set_player_model();
	self maps\mp\gametypes\_class::initStaticWeaponsTime();

	self thread maps\mp\gametypes\_class::initWeaponAttachments( primary );
	self thread maps\mp\gametypes\_class::blackboxClassChoice( primary, sidearm, undefined, lethal, undefined );
	pixendevent(); 

	self maps\mp\gametypes\_class::cac_selector();
	
	choosedclass = self.pers[ "xkmod_class" ];
	
	switch ( choosedclass )
	{
		case "assault":
			self setMoveSpeedScale( 0.95 );
			break;
		case "smg":
			self setMoveSpeedScale( 1.0 );
			break;
		case "cqb":
			self setMoveSpeedScale( 1.0 );
			break;
		case "sniper":
			self setMoveSpeedScale( 1.0 );
			break;
		default:
			self setMoveSpeedScale( 1.0 );
			break;
	}
}

claimClass( teamName, classType )
{
	game[teamName + "_" + classType + "_count"]++;
	updateClassAvailability( teamName );
}

releaseClass( teamName, classType )
{
	game[teamName + "_" + classType + "_count"]--;
	updateClassAvailability( teamName );
}

updateClassAvailability( teamName )
{

	setDvarWrapper( teamName + "_allow_assault", (game[teamName + "_assault_count"] < getDvarInt( "class_assault_limit" )) );
	setDvarWrapper( teamName + "_allow_smg", (game[teamName + "_smg_count"] < getDvarInt( "class_smg_limit" )) );
	setDvarWrapper( teamName + "_allow_cqb", (game[teamName + "_cqb_count"] < getDvarInt( "class_cqb_limit" )) );
	setDvarWrapper( teamName + "_allow_sniper", (game[teamName + "_sniper_count"] < getDvarInt( "class_sniper_limit" )) ); 
}

updateClassAvailability2()
{
	a = [];
	
	for(i=0; i<level.players.size; i++)
	{
		a["assault"] = 0;
		a["demolitions"] = 0;
		a["sniper"] = 0;
		a["specops"] = 0;
		for(a=0; a<level.players.size; a++)
		{
			if(!isDefined(level.players[a].pers[ "xkmod_class" ]) || level.players[a].pers["team"] != level.players[i].pers["team"]) continue;
			if(level.players[a].pers[ "xkmod_class" ] == "smg") a["specops"]++;
			else if(level.players[a].pers[ "xkmod_class" ] == "cqb") a["demolitions"]++;
			else if(level.players[a].pers[ "xkmod_class" ] == "sniper") a["sniper"]++;
			else if(level.players[a].pers[ "xkmod_class" ] == "assault") a["assault"]++;
		}	
		if(level.players[i].pers["ui_xkmod_demolitions_count"] != a["demolitions"])
		{
			level.players[i].pers["ui_xkmod_demolitions_count"] = a["demolitions"];
			level.players[i] setClientDvar( level.players[i].pers["team"] + "_allow_cqb", (a["demolitions"] < getDvarInt( "class_cqb_limit" )));
		}
		if(level.players[i].pers["ui_xkmod_assault_count"] != a["assault"])
		{
			level.players[i].pers["ui_xkmod_assault_count"] = a["assault"];
			level.players[i] setClientDvar( level.players[i].pers["team"] + "_allow_assault", (a["assault"] < getDvarInt( "class_assault_limit" )));
		}	
		if(level.players[i].pers["ui_xkmod_sniper_count"] != a["sniper"])
		{
			level.players[i].pers["ui_xkmod_sniper_count"] = a["sniper"];
			level.players[i] setClientDvar( level.players[i].pers["team"] + "_allow_sniper", (a["sniper"] < getDvarInt( "class_sniper_limit" )));
		}
		if(level.players[i].pers["ui_xkmod_specops_count"] != a["specops"])
		{
			level.players[i].pers["ui_xkmod_specops_count"] = a["specops"];
			level.players[i] setClientDvar( level.players[i].pers["team"] + "_allow_smg", (a["specops"] < getDvarInt( "class_smg_limit" )));
		}
	}
}