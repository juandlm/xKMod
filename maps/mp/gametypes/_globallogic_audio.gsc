#include maps\mp\_utility;

init()
{
        game["dialog"]["mission_success"] = "mission_success";
        game["dialog"]["mission_failure"] = "mission_fail";
        game["dialog"]["mission_draw"] = "draw";
        game["dialog"]["round_success"] = "encourage_win";
        game["dialog"]["round_failure"] = "encourage_lost";
        game["dialog"]["round_draw"] = "draw";
        game["dialog"]["timesup"] = "timesup";
        game["dialog"]["bomb_taken"] = "sd_bomb_taken_taken";
        game["dialog"]["bomb_lost"] = "sd_bomb_drop";
        game["dialog"]["bomb_defused"] = "sd_bomb_defused";
        game["dialog"]["bomb_planted"] = "sd_bomb_planted";
}

announceRoundWinner( winner, delay )
{
    if ( delay > 0 )
        wait delay;

    if ( !isDefined( winner ) || isPlayer( winner ) )
        return;

    if ( winner == "allies" )
    {
        leaderDialog( "round_success", "allies" );
        leaderDialog( "round_failure", "axis" );
    }
    else if ( winner == "axis" )
    {
        leaderDialog( "round_success", "axis" );
        leaderDialog( "round_failure", "allies" );
    }
    else
    {
        thread playSoundOnPlayers( "mus_round_draw"+"_"+level.teamPostfix["allies"] );
        thread playSoundOnPlayers( "mus_round_draw"+"_"+level.teamPostfix["axis"] );
    }
}

announceGameWinner( winner, delay )
{
    if ( delay > 0 )
        wait delay;

    if ( !isDefined( winner ) || isPlayer( winner ) )
        return;

    if ( winner == "allies" )
    {
        leaderDialog( "mission_success", "allies" );
        leaderDialog( "mission_failure", "axis" );
    }
    else if ( winner == "axis" )
    {
        leaderDialog( "mission_success", "axis" );
        leaderDialog( "mission_failure", "allies" );
    }
    else
    {
        leaderDialog( "mission_draw" );
    }
}


doFlameAudio()
{
    self endon("disconnect");
    waittillframeend;
    
    if (!isdefined ( self.lastFlameHurtAudio ) )
        self.lastFlameHurtAudio = 0;
        
    currentTime = gettime();
    
    if ( self.lastFlameHurtAudio + level.fire_audio_repeat_duration + RandomInt( level.fire_audio_random_max_duration ) < currentTime )
    {
        self playLocalSound("vox_pain_small");
        self.lastFlameHurtAudio = currentTime;
    } 
}


leaderDialog( dialog, team, group, excludeList, squadDialog )
{
    assert( isdefined( level.players ) );

    if ( level.splitscreen )
        return;
        
    if ( level.wagerMatch )
        return;
        
    if ( !isDefined( team ) )
    {
        leaderDialogBothTeams( dialog, "allies", dialog, "axis", group, excludeList );
        return;
    }
    
    if ( level.splitscreen )
    {
        if ( level.players.size )
            level.players[0] leaderDialogOnPlayer( dialog, group );
        return;
    }
    
    
    if ( isDefined( excludeList ) )
    {
        for ( i = 0; i < level.players.size; i++ )
        {
            player = level.players[i];
            if ( (isDefined( player.pers["team"] ) && (player.pers["team"] == team )) && !maps\mp\gametypes\_globallogic_utils::isExcluded( player, excludeList ) )
                player leaderDialogOnPlayer( dialog, group );
        }
    }
    else
    {
        for ( i = 0; i < level.players.size; i++ )
        {
            player = level.players[i];
            if ( isDefined( player.pers["team"] ) && (player.pers["team"] == team ) )
                player leaderDialogOnPlayer( dialog, group );
        }
    }
}

leaderDialogBothTeams( dialog1, team1, dialog2, team2, group, excludeList )
{
    assert( isdefined( level.players ) );
    
    if ( level.splitscreen )
        return;

    if ( level.splitscreen )
    {
        if ( level.players.size )
            level.players[0] leaderDialogOnPlayer( dialog1, group );
        return;
    }

    if ( isDefined( excludeList ) )
    {
        for ( i = 0; i < level.players.size; i++ )
        {
            player = level.players[i];
            team = player.pers["team"];
            
            if ( !isDefined( team ) )
                continue;
            
            if ( maps\mp\gametypes\_globallogic_utils::isExcluded( player, excludeList ) )
                continue;
            
            if ( team == team1 )
                player leaderDialogOnPlayer( dialog1, group );
            else if ( team == team2 )
                player leaderDialogOnPlayer( dialog2, group );
        }
    }
    else
    {
        for ( i = 0; i < level.players.size; i++ )
        {
            player = level.players[i];
            team = player.pers["team"];
            
            if ( !isDefined( team ) )
                continue;
            
            if ( team == team1 )
                player leaderDialogOnPlayer( dialog1, group );
            else if ( team == team2 )
                player leaderDialogOnPlayer( dialog2, group );
        }
    }
}


leaderDialogOnPlayer( dialog, group )
{
    if( isPregame() )
        return;
        
    team = self.pers["team"];

    if ( level.splitscreen )
        return;
    
    if ( !isDefined( team ) )
        return;
    
    if ( team != "allies" && team != "axis" )
        return;
    
    if ( isDefined( group ) )
    {
        if ( self.leaderDialogGroup == group )
            return;

        hadGroupDialog = isDefined( self.leaderDialogGroups[group] );

        self.leaderDialogGroups[group] = dialog;
        dialog = group;        
        
        if ( hadGroupDialog )
            return;
    }

    if ( !self.leaderDialogActive )
        self thread playLeaderDialogOnPlayer( dialog, team );
    else
        self.leaderDialogQueue[self.leaderDialogQueue.size] = dialog;
}


playLeaderDialogOnPlayer( dialog, team )
{
    self endon ( "disconnect" );
    
    self.leaderDialogActive = true;
    if ( isDefined( self.leaderDialogGroups[dialog] ) )
    {
        group = dialog;
        dialog = self.leaderDialogGroups[group];
        self.leaderDialogGroups[group] = undefined;
        self.leaderDialogGroup = group;
    }

    if( level.allowAnnouncer )
    {
        if ( level.wagerMatch )
            faction = "vox_wm_";
        else
            faction = game["voice"][team];
       
    }

    wait ( 3.0 );
    self.leaderDialogActive = false;
    self.leaderDialogGroup = "";

    if ( self.leaderDialogQueue.size > 0 )
    {
        nextDialog = self.leaderDialogQueue[0];
        
        for ( i = 1; i < self.leaderDialogQueue.size; i++ )
            self.leaderDialogQueue[i-1] = self.leaderDialogQueue[i];
        self.leaderDialogQueue[i-1] = undefined;
        
        self thread playLeaderDialogOnPlayer( nextDialog, team );
    }
}


musicController()
{
    level endon ( "game_ended" );
    
    level thread musicTimesOut();
    
    if( isPregame() )
        return;
    
    level waittill ( "match_ending_soon" );

    if ( isLastRound() || isOneRound() )
    {    
        if ( !level.splitScreen )
        {
            if( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
            {
                leaderDialog( "min_draw" );
            }
            else if( game["teamScores"]["allies"] > game["teamScores"]["axis"] )
            {
        
                leaderDialog( "winning", "allies", undefined, undefined, "squad_winning" );
                leaderDialog( "losing", "axis", undefined, undefined , "squad_losing" );
            }
            else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
            {
                    
                leaderDialog( "winning", "axis", undefined, undefined, "squad_winning" );
                leaderDialog( "losing", "allies", undefined, undefined , "squad_losing" );
            }
            else
            {
                leaderDialog( "timesup", "axis", undefined, undefined , "squad_30sec" );
                leaderDialog( "timesup", "allies", undefined, undefined , "squad_30sec" );
            }
    
            level waittill ( "match_ending_very_soon" );
            leaderDialog( "timesup", "axis", undefined, undefined , "squad_30sec" );
            leaderDialog( "timesup", "allies", undefined, undefined , "squad_30sec" );
        }
    }
    else
    {

        level waittill ( "match_ending_vox" );    

        leaderDialog( "timesup" );
    }
}

musicTimesOut()
{
    level endon( "game_ended" );
    
    level waittill ( "match_ending_very_soon" );
    
}

actionMusicSet()
{
    level endon( "game_ended" );
    level.playingActionMusic = true;
    wait(45);
    level.playingActionMusic = false;
}

play_2d_on_team( alias, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size; i++ )
    {
        player = level.players[i];
        if ( isDefined( player.pers["team"] ) && (player.pers["team"] == team ) )
        {
            player playLocalSound( alias );
        }    
    }
}
set_music_on_team( state, team, save_state, return_state, wait_time )
{
    // Assert if there are no players
    assert( isdefined( level.players ) );
    
    if ( !IsDefined( team ) )    
    {
        team = "both";
        if( getdvarint( #"debug_music" ) > 0 )
        {        
            println ("Music System - team undefined: Setting to both");
        }
    }
    if ( !IsDefined( save_state ) )    
    {
        save_sate = false;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - save_sate undefined: Setting to false");
        }
    }
    if ( !IsDefined( return_state ) )    
    {
        return_state = false;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - Music System - return_state undefined: Setting to false");            
        }    
    }    
    if ( !IsDefined( wait_time ) )    
    {
        wait_time = 0;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - wait_time undefined: Setting to 0");        
        }
    }
        
    for ( i = 0; i < level.players.size; i++ )
    {
        player = level.players[i];
        if ( team == "both" )
        {
            // if no team is set or team is set to "both" set same state for all players
            player thread set_music_on_player ( state, save_state, return_state, wait_time );            
        }    
        else if ( isDefined( player.pers["team"] ) && (player.pers["team"] == team ) )
        {
            player thread set_music_on_player ( state, save_state, return_state, wait_time );
    
            if( getdvarint( #"debug_music" ) > 0 )
            {
                println ("Music System - Setting Music State " + state + " On player " + player getEntityNumber());    
            }
        }
    }
}
set_music_on_player( state, save_state, return_state, wait_time )
{
    //self is player
    self endon( "disconnect" );
    
    assert( isplayer (self) );
    
    if ( !IsDefined( save_state ) )    
    {
        save_state = false;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - Music System - save_sate undefined: Setting to false");
        }
    }
    if ( !IsDefined( return_state ) )    
    {
        return_state = false;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - Music System - return_state undefined: Setting to false");        
        }
    }    
    if ( !IsDefined( wait_time ) )    
    {
        wait_time = 0;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - wait_time undefined: Setting to 0");            
        }
    }    
        if ( !IsDefined( state ) )    
    {
        state = "UNDERSCORE";
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - state undefined: Setting to UNDERSCORE");            
        }
    }    
    maps\mp\_music::setmusicstate( state, self );
    
    if ( isdefined ( self.pers["music"].currentState ) && save_state  )
    {
        //If we want to save the sate we set return state to current state 
        self.pers["music"].returnState = state;             
        
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - Saving Music State " + self.pers["music"].returnState + " On " + self getEntityNumber() );
        }
    }
    
    // Set previous state to the current active state
    self.pers["music"].previousState = self.pers["music"].currentState;
    
    self.pers["music"].currentState = state;
    
    if( getdvarint( #"debug_music" ) > 0 )
    {
        println ("Music System - Setting Music State " + state + " On player " + self getEntityNumber());
    }
    if ( isdefined ( self.pers["music"].returnState ) && return_state )
    {
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - Starting Return State " + self.pers["music"].returnState + " On " + self getEntityNumber() );
        }
        self set_next_music_state ( self.pers["music"].returnState, wait_time);
    }
        
}
return_music_state_player( wait_time )
{
    if ( !IsDefined( wait_time ) )    
    {
        wait_time = 0;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - wait_time undefined: Setting to 0");            
        }
    }    
    
    self set_next_music_state ( self.pers["music"].returnState, wait_time);
}
return_music_state_team( team, wait_time )
{
    if ( !IsDefined( wait_time ) )    
    {
        wait_time = 0;
        if( getdvarint( #"debug_music" ) > 0 )
        {
            println ("Music System - wait_time undefined: Setting to 0");            
        }
    }    
    for ( i = 0; i < level.players.size; i++ )
    {
        player = level.players[i];
        if ( team == "both" )
        {
            // if no team is set or team is set to "both" set same state for all players
            player thread set_next_music_state ( self.pers["music"].returnState, wait_time);
        }    
        else if ( isDefined( player.pers["team"] ) && (player.pers["team"] == team ) )
        {
            player thread set_next_music_state ( self.pers["music"].returnState, wait_time);
    
            if( getdvarint( #"debug_music" ) > 0 )
            {
                println ("Music System - Setting Music State " + self.pers["music"].returnState + " On player " + player getEntityNumber());    
            }
        }
    }    

}        
set_next_music_state ( nextstate, wait_time )
{
    // self is player
    // set next state to latest in the que
    
    self endon( "disconnect" );
    
    self.pers["music"].nextstate = nextstate;    
    //Debug Print CDC
    if( getdvarint( #"debug_music" ) > 0 )
    {
        println ("Music System - Setting next Music State " + self.pers["music"].nextstate + " On " + self getEntityNumber() );
    }
    if ( !IsDefined( self.pers["music"].inque ) )    
    {
        // ensure that false is default
        self.pers["music"].inque = false;
    }    
    if ( self.pers["music"].inque )
    {
        // if we have a que waiting and another happens we do not change states yet
        return;
        //Debug Print CDC
        println ("Music System - Music state in que" );
    }
    else
    {            
        // set que to true while we wait
        self.pers["music"].inque = true;    
        
        // wait time from state call default is 0
        if ( wait_time )
        {
            wait wait_time;
        }
        // Set the most current music state 
        self set_music_on_player ( self.pers["music"].nextstate, false );
        
        // remove the que return
        self.pers["music"].inque = false;    
    }
}

getRoundSwitchDialog( switchType )
{
    switch( switchType )
    {
        case "halftime":
            return "halftime";
        case "overtime":
            return "overtime";
        default:
            return "side_switch";
    }
}
