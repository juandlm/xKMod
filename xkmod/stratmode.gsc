#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() 
{ 
	thread onPlayerConnect();
	thread createServerHUD();
	thread disableBombsites();

	level.prover_hud = newHudElem();
	level.prover_hud.x = -19;
	level.prover_hud.y = 35;
	level.prover_hud.horzAlign = "right";
	level.prover_hud.vertAlign = "top";
	level.prover_hud.alignX = "right";
	level.prover_hud.alignY = "middle";
	level.prover_hud.alpha = 1;	
	level.prover_hud.fontScale = 1.6;
	level.prover_hud setText( "^1xK^0Mod" );
	
	level.version_text = newHudElem();
	level.version_text.x = -25;
	level.version_text.y = 50;
	level.version_text.horzAlign = "right";
	level.version_text.vertAlign = "top";
	level.version_text.alignX = "right";
	level.version_text.alignY = "middle";
	level.version_text.alpha = 1;
	level.version_text.fontScale = 1.5;
	level.version_text.color = (1,1,1);
	level.version_text setText( "BETA" );
	
	level.mode_text = newHudElem();
	level.mode_text.x = -10;
	level.mode_text.y = 70;
	level.mode_text.horzAlign = "right";
	level.mode_text.vertAlign = "top";
	level.mode_text.alignX = "right";
	level.mode_text.alignY = "middle";
	level.mode_text.alpha = 1;
	level.mode_text.fontScale = 1.5;
	level.mode_text.color = (1,1,1);
	level.mode_text setText( "^3Strat ^7Mode" );
	
	setDvar( "sv_cheats", 1 );
	setDvar( "scr_" + level.gametype + "_timelimit", 0 );
	setDvar( "scr_" + level.gametype + "_numlives", 0 );
}

disableBombsites() 
{
	if ( level.gametype == "sd" && isDefined( level.bombZones ) )
	{
		for ( i = 0; i < level.bombZones.size; i++ )
		{
			level.bombZones[i] maps\mp\gametypes\_gameobjects::disableObject(); 
		}
	}
}

onPlayerConnect() 
{ 
	for(;;) 
	{ 
		level waittill("connecting", player); 
		player thread nadeTraining();
		player thread createInfos();
		player thread monitorActions();
	} 
}

onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");
		
		self thread doSuicide();
	}
}

monitorActions()
{ 
	self endon("disconnect");
	
	for(;;) 
	{ 
		wait 0.05;
		if ( self.sessionstate != "playing" )
			continue;

		if ( self useButtonPressed() && !self meleeButtonPressed() ) 
		{ 
			useButtonTime = 0;
			
			while ( self useButtonPressed() && !self meleeButtonPressed() ) 
			{ 
				useButtonTime += 0.05;
				wait 0.05; 
			}
				if ( useButtonTime > 0.5 || !useButtonTime ) 
				continue; 
			
			for ( i = 0; i < 0.5; i += 0.1 ) 
			{ 
				wait 0.1;
				
				if ( self useButtonPressed() && !self meleeButtonPressed() ) 
				{ 
					loadPos();
					break; 
				} 
			} 
		} 
		if ( self meleeButtonPressed() && !self useButtonPressed() ) 
		{
			meleeButtonTime = 0;
			while ( self meleeButtonPressed() && !self useButtonPressed() )
			{ 
				meleeButtonTime += 0.05; 
				wait 0.05; 
			}
			if ( meleeButtonTime > 0.5 || !meleeButtonTime ) 
				continue; 
				
			for ( i = 0; i < 0.5; i += 0.1 ) 
			{ 
				wait 0.1;
				if ( self meleeButtonPressed() && !self useButtonPressed() ) 
				{ 
					savePos(); 
					break; 
				} 
			} 
		} 
		if ( self meleeButtonPressed() || self useButtonPressed() ) 
		{ 
			wait 0.1;
			bothButtonTime = 0; 
			while ( bothButtonTime < 0.5 && self meleeButtonPressed() && self useButtonPressed() ) 
			{
				bothButtonTime += 0.05;
				wait 0.05; 
			}
			if ( bothButtonTime > 0.35 ) 
			{ 
				if ( !isDefined( self.nofly ) ) 
				{ 
					self.nofly = true;
					self.hint1 setText( "Enable: Hold ^3[{+melee}] ^7+ ^3[{+activate}]" );
					self.hint2.color = (0.5, 0.5, 0.5);
					self.hint3.color = (0.5, 0.5, 0.5); 
				} 
				else 
				{
					self.nofly = undefined; 
					self.hint1 setText( "Disable: Hold ^3[{+melee}] ^7+ ^3[{+activate}]" );
					self.hint2.color = (1, 1, 1); 
					self.hint3.color = (1, 1, 1);
					
				} 
			}
			while ( self meleeButtonPressed() && self useButtonPressed() )
				wait 0.05; 
		} 
	} 
} 

loadPos() 
{ 
	self endon( "disconnect" );
	if ( !isDefined( self.savedorg ) ) 
		self iprintln("No Previous Position Saved");
	else
	{ self freezecontrols( true );
		wait 0.05; 
		
	self setOrigin( self.savedorg );
	self SetPlayerAngles ( self.savedang ); 
	self freezecontrols( false );
	self iprintln("Position Loaded"); 
	} 
} 

savePos() 
{ 
	if ( !self isOnGround() ) 
		return;

	self.savedorg = self.origin;
	self.savedang = self GetPlayerAngles(); 
	self iprintln("Position Saved"); 
} 

nadeTraining() 
{
	self endon( "disconnect" );
	for(;;) 
	{ 
		self waittill ( "grenade_fire", grenade, weaponName );
		grenades = getentarray("grenade","classname");

		for ( i = 0; i < grenades.size; i++ ) 
		{ 
			self giveWeapon( weaponName );
			self setWeaponAmmoClip( weaponName, 1 );
			if ( isDefined( grenades[i].origin ) && !isDefined( self.flying ) && !isDefined( self.nofly ) ) 
			{ 
				if ( distance( grenades[i].origin, self.origin ) < 140 ) 
				{
					self.flying = true;
					grenades[i] thread nadeFlying( self, weaponName ); 
				} 
			} 
		} 
		wait 0.1; 
	} 
}

nadeFlying( player, weaponName ) 
{ 
	player endon( "disconnect" ); 
	time = 3;

	if ( weaponName == "frag_grenade_mp" ) 
		time = 3; 
		
	else if ( weaponName == "flash_grenade_mp" ) 
		time = 1.5; 
		
	else 
		time = 1; 
		
	old_player_origin = player.origin;
	player.flyobject = spawn( "script_model", player.origin );
	player.flyobject linkto( self ); 
	player linkto( player.flyobject );
	stop_flying = false; 
	return_flying = false; 
	
	while ( isDefined( self ) ) 
	{
		if ( player attackButtonPressed() ) 
		{ 
			stop_flying = true; 
			break; 
		}
		if ( player useButtonPressed() ) 
		{
			return_flying = true; 
			break; 
		} 
		wait 0.05; 
	} 
	if ( stop_flying || return_flying )
		wait 0.1;

	else 
	{ 
		for ( i = 0; i < time - 0.5; i += 0.1 )
		{
			wait 0.1; if ( player useButtonPressed() ) 
				break; 
		} 
	} 
	player.flyobject unlink();
	
	if ( stop_flying ) 
	{
		for ( i = 0; i < time + 0.4; i += 0.1 )
		{
			wait 0.1; 
			if ( player useButtonPressed() )
				break; 
		} 
	} 
	
	player.flyobject moveto( old_player_origin, 0.1 );
	wait 0.2; 
	player unlink(); 
	player.flying = undefined;
	if ( isDefined( player.flyobject ) ) 
		player.flyobject
		delete(); 
}

createInfos() 
{ 
	self.hint1 = newClientHudElem(self);
	self.hint1.x = -7;
	self.hint1.y = 150;
	self.hint1.horzAlign = "right"; 
	self.hint1.vertAlign = "top";
	self.hint1.alignX = "right"; 
	self.hint1.alignY = "middle";
	self.hint1.fontScale = 1.4;
	self.hint1.font = "default";
	self.hint1.color = (1, 1, 1);
	self.hint1.hidewheninmenu = true;
	self.hint1 setText( "Disable: Hold ^3[{+melee}] ^7+ ^3[{+activate}]" ); 
	
	self.hint2 = newClientHudElem(self);
	self.hint2.x = -7; 
	self.hint2.y = 165; 
	self.hint2.horzAlign = "right";
	self.hint2.vertAlign = "top"; 
	self.hint2.alignX = "right"; 
	self.hint2.alignY = "middle";
	self.hint2.fontScale = 1.4; 
	self.hint2.font = "default";
	self.hint2.color = (1, 1, 1); 
	self.hint2.hidewheninmenu = true;
	self.hint2 setText( "Stop: Press ^3[{+attack}]" ); 
	
	self.hint3 = newClientHudElem(self);
	self.hint3.x = -7; 
	self.hint3.y = 180; 
	self.hint3.horzAlign = "right";
	self.hint3.vertAlign = "top"; 
	self.hint3.alignX = "right"; 
	self.hint3.alignY = "middle"; 
	self.hint3.fontScale = 1.4; 
	self.hint3.font = "default";
	self.hint3.color = (1, 1, 1);
	self.hint3.hidewheninmenu = true;
	self.hint3 setText( "Return: Press ^3[{+activate}]" ); 
	
	self.hint4 = newClientHudElem(self); 
	self.hint4.x = -7; 
	self.hint4.y = 225; 
	self.hint4.horzAlign = "right";
	self.hint4.vertAlign = "top"; 
	self.hint4.alignX = "right";
	self.hint4.alignY = "middle";
	self.hint4.fontScale = 1.4;
	self.hint4.font = "default"; 
	self.hint4.color = (1, 1, 1);
	self.hint4.hidewheninmenu = true;
	self.hint4 setText( "Save: Press ^3[{+melee}] ^7twice" ); 
	
	self.hint5 = newClientHudElem(self);
	self.hint5.x = -7; 
	self.hint5.y = 240; 
	self.hint5.horzAlign = "right"; 
	self.hint5.vertAlign = "top";
	self.hint5.alignX = "right";
	self.hint5.alignY = "middle"; 
	self.hint5.fontScale = 1.4; 
	self.hint5.font = "default"; 
	self.hint5.color = (1, 1, 1);
	self.hint5.hidewheninmenu = true;
	self.hint5 setText( "Load: Press ^3[{+activate}] ^7twice" );
	
} 

createServerHUD() 
{ 
	nadetraining = newHudElem(); 
	nadetraining.x = -7; 
	nadetraining.y = 130;
	nadetraining.horzAlign = "right"; 
	nadetraining.vertAlign = "top";
	nadetraining.alignX = "right"; 
	nadetraining.alignY = "middle"; 
	nadetraining.fontScale = 1.4; 
	nadetraining.font = "default";
	nadetraining.color = (1, 1, 1);
	nadetraining.hidewheninmenu = true;
	nadetraining setText( "^1Nadetraining" );
	
	position = newHudElem();
	position.x = -7;
	position.y = 205;
	position.horzAlign = "right";
	position.vertAlign = "top"; 
	position.alignX = "right"; 
	position.alignY = "middle";
	position.fontScale = 1.4; 
	position.font = "default"; 
	position.color = (1, 1, 1);
	position.hidewheninmenu = true; 
	position setText( "^1Position" );
}

doSuicide()
{
	self endon("disconnect");
	self endon("death");
	
	for(;;) 
	{
		if(self ActionSlotthreeButtonPressed()) 
		{
			self suicide();
		}
		wait .05;
	}
}