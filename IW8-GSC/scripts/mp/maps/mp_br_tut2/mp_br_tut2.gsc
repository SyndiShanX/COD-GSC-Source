
// Params 0
// Size: 0xc6
function main()
{
    scripts\mp\maps\mp_br_tut2\mp_br_tut2_precache::main();
    scripts\mp\maps\mp_br_tut2\gen\mp_br_tut2_art::main();
    scripts\mp\maps\mp_br_tut2\mp_br_tut2_fx::main();
    scripts\mp\maps\mp_br_tut2\mp_br_tut2_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_br_tut2" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    scripts\mp\gametypes\br_gametypes::ref_12b11( "lastStandAllowed", &watch_flight_collision );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "onPlayerConnect", &bronplayerconnecttut );
    scripts\mp\tutorial\br_tut_utility::tutorialinit( &onplayerconnect, &onplayerfirstspawn, &scripts\mp\tutorial\br_tut_utility::emptyfunction );
    gascircleinit();
    scripts\mp\tutorial\br_tut_bots::initialize_tutorial_bot_system();
    thread handle_botspawn();
    thread modify_player_damage();
    init_tutorial_doors();
    level.endgame = &onplayergetsplunder;
    level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ = 0;
}

// Params 1
// Size: 0x49
function bronplayerconnecttut( var0 )
{
    var1 = spawnstruct();
    var1.operatorref = "t9kingsley_western";
    level.playercustomizationdata[ 0 ][ "axis" ] = var1;
    level.playercustomizationdata[ 0 ][ "axis" ].operatorskinindex = 1477;
    var0.defaultoperatorteam = "axis";
}

// Params 3
// Size: 0x66
function onplayergetsplunder( var0, var1, var2 )
{
    level.player clearhudtutorialmessage();
    var3 = 2.5;
    level.player thread scripts\mp\utility\player::hidehudenable();
    level.player thread scripts\mp\utility\player::hideminimap( 1 );
    thread fadeout( level.player );
    level.player setsoundsubmix( "fade_to_black_all_except_music", 4 );
    wait var3;
    
    if ( !isdefined( var2 ) || var2 == 0 )
    {
        level notify( "exitLevel_called" );
        exitlevel( 0 );
        return;
    }
}

// Params 1
// Size: 0x21
function ref_12999( var0 )
{
    self endon( "game_ended" );
    self endon( "pop_up_opened" );
    wait var0;
    level notify( "exitLevel_called" );
    exitlevel( 0 );
}

// Params 0
// Size: 0x9c
function ref_13e99()
{
    self endon( "game_ended" );
    thread ref_12999( 2 );
    
    for ( ;; )
    {
        level.player waittill( "luinotifyserver", var0, var1 );
        
        if ( var0 == "ftue_popup_state_change" )
        {
            if ( var1 == 4 )
            {
                self notify( "pop_up_opened" );
                continue;
            }
            
            if ( var1 == 0 || var1 == 1 || var1 == 2 || var1 == 5 )
            {
                level notify( "exitLevel_called" );
                exitlevel( 0 );
                continue;
            }
            
            if ( var1 == 3 )
            {
                setomnvar( "ui_br_ftue_popup", 0 );
                scripts\mp\bots\bots::drop_bots( 1, level.player.team );
                scripts\mp\gamelogic::restart();
            }
        }
    }
}

// Params 1
// Size: 0xa4
function fadeout( var0 )
{
    self.patchable_collision = newclienthudelem( self );
    self.patchable_collision.x = 0;
    self.patchable_collision.y = 0;
    self.patchable_collision setshader( "black", 640, 480 );
    self.patchable_collision.alignx = "left";
    self.patchable_collision.aligny = "top";
    self.patchable_collision.horzalign = "fullscreen";
    self.patchable_collision.vertalign = "fullscreen";
    self.patchable_collision.alpha = 0;
    self.patchable_collision fadeovertime( var0 );
    self.patchable_collision.alpha = 1;
}

// Params 1
// Size: 0xe
function onplayerconnect( var0 )
{
    var0.ref_12860 = 1;
}

// Params 1
// Size: 0x1c5
function onplayerfirstspawn( var0 )
{
    scripts\mp\tutorial\br_tut_utility::init_resource_spawners( "tut_ammo_respawner", "targetname", 20 );
    scripts\mp\tutorial\br_tut_utility::init_resource_spawners( "tut_armor_respawner", "targetname", 5 );
    initpopuptargets();
    flipalltargets( "down" );
    scripts\mp\tutorial\br_tut_utility::load_player_triggers( "player_trigger_area" );
    level.allowsupers = 0;
    var0 scripts\mp\tutorial\br_tut_bots::setup_human_player();
    var0 scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    var0 scripts\mp\gametypes\br_pickups::resetplayerinventory( 0 );
    var0 thread scripts\mp\tutorial\br_tut_ui::process_vo_queue( "", 10 );
    var0 thread scripts\mp\matchdata::monitorweaponfire();
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "jumpedFromPlane", &infiljumpguide, &scripts\mp\tutorial\br_tut_utility::emptyfunction, "InfilJump" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "playerLanded", &infilparachuteguide, &infilparachutedone, "InfilParachute" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "allObjectivesComplete", &movementchecklist, &movementchecklistdone, "MovementChecklistDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "friendlyReachedBox", &supplyboxguide, &supplyboxdone, "FriendlyReachedSupplyBox" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "gotLootWeapons", &pickuplootguide, &pickuplootdone, "PickupGunAndAmmo" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "allObjectivesComplete", &firingchecklistguide, &firingchecklistdone, "FiringChecklistDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "tacMapDone", &tacmapguide, &tacmapdone, "TacMapDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "singleCombatDone", &singlecombatguide, &singlecombatdone, "SingleCombatDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "usedLootArmor", &reviveallyguide, &reviveallydone, "PickupArmor" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "arrivedAtPingRoom", &movetopingroomguide, &movetopingroomdone, "MovedToPingRoom" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "allObjectivesComplete", &pingchecklist, &pingchecklistdone, "PingChecklistDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "groupCombatDone", &groupcombatguide, &groupcombatdone, "GroupCombatDone" );
    scripts\mp\tutorial\br_tut_progress_state::registertutorialprogressnotifystate( level, "outroDone", &outroguide, &endtutorial, "TutorialVictory" );
    thread scripts\mp\tutorial\br_tut_progress_state::tutorialprogress();
}

// Params 0
// Size: 0x3a
function init_tutorial_doors()
{
    scripts\mp\tutorial\br_tut_utility::init_doors( "tut_progress_gate_00", "targetname" );
    scripts\mp\tutorial\br_tut_utility::init_doors( "tut_progress_gate_01", "targetname" );
    wait 0.1;
    scripts\mp\tutorial\br_tut_utility::targetted_door_operation( "open", "electrical_room_exit", 250 );
}

// Params 0
// Size: 0x47
function handle_botspawn()
{
    level.±ÿÖóïNıì€ª = 400;
    
    for ( ;; )
    {
        level waittill( "player_spawned", var0 );
        var1 = issentient( var0 );
        var2 = -1;
        
        if ( isdefined( var0.©f
Y7G-:ÂÎ-å ) )
        {
            var2 = var0.©f
Y7G-:ÂÎ-å;
        }
        
        if ( isbot( var0 ) )
        {
            var0 scripts\mp\tutorial\br_tut_bots::setup_tutorial_bot();
        }
    }
}

// Params 0
// Size: 0x21
function init_level_bots()
{
    level.ÉÅ
[ÿ¢ãhA-r·Å = gettime() + 3600000;
    spawn_friendly_bot();
    thread spawn_enemy_bot();
    thread spawn_group_combat_bots();
}

// Params 0
// Size: 0x70
function spawn_friendly_bot()
{
    var0 = getent( "friendly", "targetname" );
    level.¶y
ê)«æPŸV!ìx = scripts\mp\tutorial\br_tut_bots::load_bot_placement( var0 );
    level.bots[ "skinID" ][ level.¶y
ê)«æPŸV!ìx ] = 1744;
    scripts\mp\tutorial\br_tut_bots::spawn_bot_from_table_and_wait( level.¶y
ê)«æPŸV!ìx );
    var1 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var1.´¨	·É™Î`√ = 1;
    var1 scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
    var1 setsquadindex( 0 );
    var1 scripts\mp\tutorial\br_tut_bots::load_player_targets( "friendly_target_spot" );
}

// Params 0
// Size: 0x27
function spawn_enemy_bot()
{
    var0 = getent( "single_combat", "targetname" );
    level.Ñ’`ıˇì±¶eŒŸ;F`R≤¯K = scripts\mp\tutorial\br_tut_bots::load_bot_placement( var0 );
    scripts\mp\tutorial\br_tut_bots::spawn_bot_from_table_and_wait( level.Ñ’`ıˇì±¶eŒŸ;F`R≤¯K );
}

// Params 0
// Size: 0x25
function spawn_group_combat_bots()
{
    var0 = getentarray( "group_combat", "targetname" );
    var1 = scripts\mp\tutorial\br_tut_bots::load_logic_waypoints( "group_waypoints" );
    scripts\mp\tutorial\br_tut_bots::spawn_bot_group( var0, var1 );
}

// Params 0
// Size: 0x80
function infiljumpguide()
{
    thread scripts\mp\tutorial\br_tut_ui::infil_sfx();
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &scripts\mp\tutorial\br_tut_utility::emptyfunction );
    level.player setclientomnvar( "ui_br_infil_started", 1 );
    level.player setclientomnvar( "ui_br_infiled", 1 );
    level.player scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    scripts\mp\flags::gameflagset( "prematch_fade_done" );
    level.player playsound( "tw_ac130_flyby" );
    wait 2;
    
    if ( level.players.size == 1 )
    {
        init_level_bots();
    }
    
    wait 1;
    level notify( "jumpedFromPlane" );
}

// Params 0
// Size: 0x116
function infilparachuteguide()
{
    var0 = level.player scripts\mp\gametypes\br::getspawnpoint( 0 );
    var1 = scripts\mp\tutorial\br_tut_bots::bot_spawn_point( level.¶y
ê)«æPŸV!ìx );
    var2 = ( 0, 90, 0 );
    waitframe();
    level.player setorigin( var0.origin, 1 );
    level.player setplayerangles( var2 );
    var3 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var4 = var0.origin[ 2 ] * 0.5;
    var3 setorigin( var1 + ( 0, 0, 1 ) * var4, 1 );
    level.freefallstartcb = &tutfreefallstart;
    level.parachutecompletecb = &tutparachutecomplete;
    level.player skydive_cutautodeployoff();
    level.player thread scripts\mp\gametypes\br_c130::parachute( undefined, 0, undefined, 0 );
    thread skydive_autodeploy_at_height( level.player );
    var3 thread scripts\mp\gametypes\br_c130::parachute( undefined, 0, undefined, 0 );
    var3 botsetflag( "disable_movement", 1 );
    level.player scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    level.player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    wait 1;
    scripts\mp\tutorial\br_tut_utility::waittill_action_performed( &isonground, level.player, 0.1, 20 );
    wait 0.1;
    level notify( "playerLanded" );
}

// Params 0
// Size: 0x13
function tutfreefallstart()
{
    var0 = self;
    var0 scripts\cp_mp\parachute::freefallstartdefault();
    var0 limitedmovement( 1 );
}

// Params 0
// Size: 0x12
function tutparachutecomplete()
{
    var0 = self;
    var0 scripts\cp_mp\parachute::parachutecompletedefault();
    var0 limitedmovement( 0 );
}

// Params 0
// Size: 0x68
function infilparachutedone()
{
    var0 = getent( "weapon_box", "targetname" );
    var1 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, 500, "door" );
    
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        var1[ var2 ] scripts\mp\tutorial\br_tut_utility::freeze_scriptable_door( 1 );
    }
    
    var3 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    thread friendly_path_to_armory();
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_landings_10", "dx_brm_sola_intro_break_anything_10" ] );
}

// Params 0
// Size: 0x16b
function supplyboxguide()
{
    var0 = getent( "weapon_box", "targetname" );
    var1 = "br_loot_cache_tutorial";
    
    if ( isdefined( var0.script_noteworthy ) )
    {
        var1 = var0.script_noteworthy;
    }
    
    var2 = spawn_scriptable_object( var1, var0.origin, var0.angles );
    var2.ref_12f7f = "tut_weapons_box_odds";
    
    if ( isdefined( var0.script_namenumber ) )
    {
        var2.ref_12f7f = var0.script_namenumber;
    }
    
    var3 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    
    for ( var4 = 0; !scripts\engine\utility::flag( "at_armory" ) ; var4 = 1 )
    {
        wait 0.1;
        
        if ( !var4 )
        {
            level.player sethudtutorialmessage( &"MP_BR_TUT2/GREET_ALLY_1" );
            scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_move_here_10", "dx_brm_sola_move_this_way_10" ], 5, 2 );
            var5 = var3.á5€ÒÂC1H3äg√∞¬[ "armory_enter" ];
            var3 calloutmarkerping_create( 0, var5 );
        }
    }
    
    var3 calloutmarkerping_delete( 0 );
    level.player clearhudtutorialmessage();
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    scripts\engine\scriptable::scriptable_addusedcallback( &scriptableused );
    wait 1;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_gear_10" ] );
    var6 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin + ( 0, -500, 0 ), 200, "door" );
    
    if ( var6.size > 0 )
    {
        var6[ 0 ] scripts\mp\tutorial\br_tut_utility::freeze_scriptable_door( 0 );
    }
    
    var3 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    thread friendly_path_to_supply_cache();
    var3 calloutmarkerping_create( 9, ( 0, 0, 25 ), var2.index );
}

// Params 5
// Size: 0x51
function scriptableused( var0, var1, var2, var3, var4 )
{
    if ( !var4 )
    {
        if ( isdefined( var0 ) && isdefined( var0.type ) && var0.type == "br_loot_cache_tutorial" )
        {
            var5 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
            var5 calloutmarkerping_delete( 9 );
            level.player clearhudtutorialmessage();
            level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ = 1;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2
function supplyboxdone()
{
    
}

// Params 0
// Size: 0x3e
function getplayerweaponcount()
{
    var0 = 0;
    var1 = level.player getweaponslist( "primary" );
    
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        if ( var1[ var2 ].basename != "iw8_fists_mp" )
        {
            var0 += 1;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x191
function pickuplootguide()
{
    if ( !level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ )
    {
        if ( level.player usinggamepad() )
        {
            level.player sethudtutorialmessage( &"MP_BR_TUT2/SUPPLY_BOX_HINT_1" );
        }
        else
        {
            level.player sethudtutorialmessage( &"MP_BR_TUT2/SUPPLY_BOX_HINT_1_KBM" );
        }
        
        scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_loot_open_box_10" ] );
    }
    
    while ( !level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ )
    {
        wait 0.1;
    }
    
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    level.player clearhudtutorialmessage();
    wait 2;
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var0 botlookatpoint( level.player.origin + ( 0, 0, 82 ), 3 );
    var1 = getplayerweaponcount();
    
    if ( var1 < 2 )
    {
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_loot_weapon_10" ] );
        var2 = 10000;
        var3 = 10000;
        scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_loot_weapon_20", "dx_brm_sola_loot_choose_10", "dx_brm_sola_loot_weapon_10" ], var2 / 1000, var3 / 1000 );
        var4 = gettime();
        var5 = 0;
        
        while ( var1 < 2 )
        {
            var1 = getplayerweaponcount();
            var6 = var1;
            
            if ( var1 < 1 )
            {
                if ( level.player usinggamepad() )
                {
                    level.player sethudtutorialmessage( &"MP_BR_TUT2/EQUIP_WEAPON" );
                }
                else
                {
                    level.player sethudtutorialmessage( &"MP_BR_TUT2/EQUIP_WEAPON_KBM" );
                }
            }
            else if ( var1 < 2 )
            {
                if ( level.player usinggamepad() )
                {
                    level.player sethudtutorialmessage( &"MP_BR_TUT2/EQUIP_WEAPON2" );
                }
                else
                {
                    level.player sethudtutorialmessage( &"MP_BR_TUT2/EQUIP_WEAPON2_KBM" );
                }
            }
            
            var6 = var1;
            
            if ( var6 != var1 )
            {
                level.player clearhudtutorialmessage();
                wait 0.2;
            }
            
            wait 0.1;
        }
    }
    
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    level notify( "gotLootWeapons" );
}

// Params 0
// Size: 0x84
function pickuplootdone()
{
    level.player clearhudtutorialmessage();
    thread monitortargetrangeentrance();
    wait 1;
    var0 = getent( "weapon_box", "targetname" );
    var1 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, 200, "door" );
    
    if ( var1.size > 0 )
    {
        var1[ 0 ] scripts\mp\tutorial\br_tut_utility::freeze_scriptable_door( 0 );
    }
    
    var2 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    thread friendly_path_to_target_range();
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_move_follow_10" ] );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
    wait 1;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_weapon_intro_10" ] );
}

// Params 0
// Size: 0x206
function tacmapguide()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var0 botlookatpoint( level.player.origin + ( 0, 0, 82 ), 2 );
    wait 1;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_tacmap_open_10" ] );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/TAC_MAP_HINT_1" );
    scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_tacmap_open_20", "dx_brm_sola_tacmap_open_10" ] );
    
    while ( level.player setadditionalstreamloaddist() == 0 || level.player isjumping() )
    {
        waitframe();
    }
    
    level.player clearhudtutorialmessage( 1 );
    level.player freezecontrols( 1 );
    setomnvar( "ui_br_tutorial_state", 1 );
    clear_blockers( "ladder_blocker_target_range" );
    waitframe();
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    level.player clearhudtutorialmessage();
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_tacmap_enemy_20" ] );
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_window" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.1, var1, 40, 5 );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
    scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_tacmap_location_10", "dx_brm_sola_tacmap_enemy_20" ] );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/TAC_MAP_HINT_2" );
    setomnvar( "ui_br_tutorial_state", 0 );
    
    while ( level.player setadditionalstreamloaddist() )
    {
        wait 0.1;
    }
    
    level.player freezecontrols( 0 );
    level.player clearhudtutorialmessage();
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    var2 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.Ñ’`ıˇì±¶eŒŸ;F`R≤¯K );
    var2 notify( "stop_shooting" );
    thread single_combat_brains();
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_move_move_10" ] );
    var3 = var0.á5€ÒÂC1H3äg√∞¬[ "revival_spot" ];
    var0 botsetstance( "stand" );
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 1, var3 );
    var0 setthreatbiasgroup( "bot_victim" );
    
    if ( var0.health > 5 )
    {
        var0 dodamage( var0.health - 5, var0.origin, undefined, undefined, "MOD_FALLING" );
    }
    
    var0 botsetflag( "disable_movement", 1 );
    var0 botsetflag( "disable_rotation", 1 );
    var0 calloutmarkerping_create( 7, ( 0, 0, 25 ), var2.©f
Y7G-:ÂÎ-å );
    wait 5;
    level notify( "tacMapDone" );
}

// Params 0
// Size: 0x1f
function tacmapdone()
{
    level.ÉÅ
[ÿ¢ãhA-r·Å = gettime() + 2000;
    level.ô
◊-Í¿2ìñÔ‡ = 0;
    level.player thread scripts\mp\tutorial\br_tut_utility::monitorarmorplateusage();
}

// Params 0
// Size: 0x3b
function ref_11d1f()
{
    self.ref_140b0 = 0;
    
    for ( ;; )
    {
        self waittill( "luinotifyserver", var0, var1 );
        
        if ( isdefined( var0 ) && var0 == "map_ping_mode_enable" )
        {
            if ( var1 )
            {
                self.ref_140b0 = 1;
                thread checkforsubgametypeoverrides();
            }
        }
    }
}

// Params 0
// Size: 0x1a
function checkforsubgametypeoverrides()
{
    self notify( "newTacMap" );
    self endon( "newTacmap" );
    wait 5;
    self.ref_140b0 = 0;
}

// Params 0
// Size: 0x7
function van_initomnvars()
{
    return self setadditionalstreamloaddist();
}

// Params 0
// Size: 0x43
function singlecombatguide()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    thread start_revival_actions();
    var1 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.Ñ’`ıˇì±¶eŒŸ;F`R≤¯K );
    scripts\mp\tutorial\br_tut_utility::waittill_action_performed( &scripts\engine\utility::is_dead_sentient, var1 );
    level.player clearhudtutorialmessage();
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    waitframe();
    level notify( "singleCombatDone" );
}

// Params 0
// Size: 0x10
function singlecombatdone()
{
    level.ÉÅ
[ÿ¢ãhA-r·Å = gettime() + 3600000;
}

// Params 0
// Size: 0x216
function reviveallyguide()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    
    if ( scripts\mp\utility\player::unset_relic_trex( var0 ) )
    {
        wait 1;
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_teammate_revive_20" ] );
        scripts\mp\tutorial\br_tut_ui::ref_143a2();
        level.player sethudtutorialmessage( &"MP_BR_TUT2/REVIVE_HINT_1" );
        scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_teammate_revive_10", "dx_brm_sola_teammate_revive_20" ] );
        
        while ( scripts\mp\utility\player::unset_relic_trex( var0 ) )
        {
            if ( isdefined( var0.beingrevived ) && var0.beingrevived == 1 )
            {
                scripts\mp\tutorial\br_tut_ui::stop_nagging();
            }
            
            waitframe();
        }
        
        scripts\mp\tutorial\br_tut_ui::stop_nagging();
        level.player clearhudtutorialmessage();
    }
    
    wait 1.5;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_teammate_revive_resp_10" ] );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
    
    if ( !level.ô
◊-Í¿2ìñÔ‡ )
    {
        wait 0.75;
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_hit_20" ] );
        scripts\mp\tutorial\br_tut_ui::ref_143a2();
    }
    
    wait 1;
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "gate_to_electrical_room" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.5, var1, 10 );
    var0 botlookatpoint( level.player.origin + ( 0, 0, 82 ), 3 );
    waitframe();
    
    if ( !reviveallyhasplayerpickeduparmorplate() )
    {
        var2 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, 500, "brloot_armor_plate" );
        var0 calloutmarkerping_create( 9, ( 0, 0, 25 ), var2[ 0 ].index );
        level.player sethudtutorialmessage( &"MP_BR_TUT2/ARMOR_HINT_1" );
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_armor_10" ] );
        scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_intro_armor_20", "dx_brm_sola_intro_armor_10" ] );
    }
    
    while ( !reviveallyhasplayerpickeduparmorplate() )
    {
        wait 0.5;
    }
    
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    level notify( "pickedUpLootArmor" );
    level.player clearhudtutorialmessage();
    var0 calloutmarkerping_delete( 9 );
    
    if ( !level.ô
◊-Í¿2ìñÔ‡ )
    {
        if ( level.player usinggamepad() )
        {
            level.player sethudtutorialmessage( &"MP_BR_TUT2/ARMOR_HINT_2" );
        }
        else
        {
            level.player sethudtutorialmessage( &"MP_BR_TUT2/ARMOR_HINT_2_KBM" );
        }
        
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_equip_vest_10" ] );
        scripts\mp\tutorial\br_tut_ui::ref_143a2();
        scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_intro_armor_vest_10" ] );
    }
    
    while ( !level.ô
◊-Í¿2ìñÔ‡ )
    {
        wait 0.1;
    }
    
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    level.player clearhudtutorialmessage();
    level notify( "usedLootArmor" );
}

// Params 0
// Size: 0x29, Type: bool
function reviveallyhasplayerpickeduparmorplate()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var1 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, 500, "brloot_armor_plate" );
    return var1.size == 0;
}

// Params 0
// Size: 0xa2
function reviveallydone()
{
    wait 1;
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var0 setthreatbiasgroup( "bot_assassin" );
    scripts\mp\tutorial\br_tut_utility::ref_12116( "tut_progress_gate_00" );
    var1 = scripts\mp\gametypes\br_weapons::degrees_to_radians();
    
    if ( isdefined( var1 ) )
    {
        var2 = scripts\engine\utility::getstruct( "weapon_ping", "targetname" );
        
        if ( isdefined( var2 ) )
        {
            spawn_scriptable_object( var1, var2.origin, var2.angles );
        }
    }
    
    wait 1;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_teammate_move_20", "dx_brm_sola_teammate_move_up_20", "dx_brm_sola_teammate_move_30" ] );
    scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_move_proceed_10", "dx_brm_sola_move_there_10" ] );
    thread monitorelectricalsubstationentrance();
    level.player clearhudtutorialmessage();
}

// Params 0
// Size: 0x85
function movetopingroomguide()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    thread friendly_path_to_sniper_tower();
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "electrical_room_entrance" ];
    var0 calloutmarkerping_create( 0, var1 );
    scripts\engine\utility::flag_wait( "electric_room_door" );
    var0 calloutmarkerping_delete( 0 );
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "electrical_room_exit" ];
    var0 calloutmarkerping_create( 0, var1 );
    scripts\engine\utility::flag_wait( "at_ping_area" );
    var0 calloutmarkerping_delete( 0 );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/PING_HINT_1" );
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_ping_spot_10" ] );
    level notify( "arrivedAtPingRoom" );
}

// Params 0
// Size: 0x2
function movetopingroomdone()
{
    
}

// Params 0
// Size: 0x134
function groupcombatguide()
{
    thread monitorgroupfightentrance();
    level.ÉÅ
[ÿ¢ãhA-r·Å = gettime();
    
    while ( !isdefined( level.Øå9≠PH“?CSo ) )
    {
        waitframe();
    }
    
    var0 = 0;
    var1 = 0;
    var2 = 0;
    var3 = 15000;
    
    for ( ;; )
    {
        var4 = scripts\mp\tutorial\br_tut_bots::group_bots_remaining();
        
        if ( var4 == 0 )
        {
            break;
        }
        
        var5 = level.Øå9≠PH“?CSo.size - var4;
        
        if ( gettime() - self.player.watch_for_players_touching_ground > var3 )
        {
            if ( !var0 )
            {
                var6 = [];
                
                if ( var4 == 3 )
                {
                    var6 = [ "dx_brm_sola_last_standing_3_10" ];
                }
                else if ( var4 == 2 )
                {
                    var6 = [ "dx_brm_sola_last_standing_2_10" ];
                }
                else if ( var4 == 1 )
                {
                    var6 = [ "dx_brm_sola_last_standing_1_10" ];
                }
                
                scripts\mp\tutorial\br_tut_ui::start_nagging( var6 );
                var0 = 1;
            }
        }
        else
        {
            scripts\mp\tutorial\br_tut_ui::stop_nagging();
            var0 = 0;
        }
        
        if ( var5 > 0 )
        {
            level.player clearhudtutorialmessage();
        }
        
        if ( var5 > 1 && !var1 )
        {
            var7 = scripts\engine\utility::random( [ "dx_brm_sola_enemy_hit_10", "dx_brm_sola_enemy_hit_20", "dx_brm_sola_enemy_hit_30" ] );
            scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ var7 ] );
            var1 = 1;
        }
        
        if ( var5 == level.Øå9≠PH“?CSo.size - 1 && !var2 )
        {
            scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_last_standing_1_10" ] );
            var2 = 1;
        }
        
        wait 0.5;
    }
    
    wait 1;
    level notify( "groupCombatDone" );
}

// Params 0
// Size: 0x75
function monitorgroupfightentrance()
{
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "group_target_ping" ];
    var0 calloutmarkerping_create( 0, var1 );
    scripts\engine\utility::flag_wait( "encounter_trigger" );
    var0 calloutmarkerping_delete( 0 );
    scripts\mp\tutorial\br_tut_utility::targetted_door_operation( "lock", "electrical_room_exit", 250 );
    scripts\mp\tutorial\br_tut_utility::targetted_door_operation( "lock", "sniper_tower_base_look", 600 );
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_enemy_incoming_30" ] );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/GROUP_FIGHT_HINT_1" );
}

// Params 0
// Size: 0x71
function monitorelectricalsubstationentrance()
{
    var0 = getent( "electrical_substation_entrance", "targetname" );
    var1 = var0.script_radius * var0.script_radius;
    
    for ( var2 = level.player.origin; distance2dsquared( var2, var0.origin ) > var1 ; var2 = level.player.origin )
    {
        wait 0.1;
    }
    
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    wait 0.125;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_ping_anything_10" ] );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
}

// Params 0
// Size: 0x7
function groupcombatdone()
{
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
}

// Params 0
// Size: 0x22
function outroguide()
{
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_intro_victory_10", "dx_brm_sola_intro_victory_20" ] );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
    level notify( "outroDone" );
}

// Params 0
// Size: 0x57
function endtutorial()
{
    level.gameended = 1;
    level.gameendtime = gettime();
    level notify( "game_ended" );
    var0 = game[ "defenders" ];
    setomnvarforallclients( "ui_br_player_position", 1 );
    level thread scripts\mp\gametypes\br::handleendgamesplash( var0 );
    wait 5;
    onplayergetsplunder( 0, "", 1 );
    thread ref_13e99();
    setomnvar( "ui_br_ftue_popup", 1 );
}

// Params 0
// Size: 0x12
function movementchecklistdone()
{
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    wait 1;
    scripts\mp\tutorial\br_tut_utility::clear_objectives();
}

// Params 0
// Size: 0x70
function movementchecklist()
{
    wait 1;
    var0 = [ &monitorsprinting, &monitorjumping, &monitorcrouching, &monitorprone, &monitorsliding ];
    var1 = [ "dx_brm_sola_intro_movement_10", "dx_brm_sola_intro_checklist_10" ];
    scripts\mp\tutorial\br_tut_utility::add_objectives_for_area( 0, "MovementChecklist", "mp/br_tut2_objectives.csv", var0, var1 );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/MOVEMENT_HINT_1" );
    
    while ( scripts\mp\tutorial\br_tut_utility::num_completed_objectives() < 2 )
    {
        wait 0.1;
    }
    
    level.player clearhudtutorialmessage();
}

// Params 0
// Size: 0x1a
function monitorsprinting()
{
    var0 = scripts\mp\tutorial\br_tut_utility::waittill_is_sprinting( level.player );
    
    if ( var0 )
    {
        scripts\mp\tutorial\br_tut_utility::increment_objective( 0 );
        return;
    }
}

// Params 0
// Size: 0x26
function monitorjumping()
{
    while ( !level.player isjumping() && !level.player ismantling() )
    {
        waitframe();
    }
    
    scripts\mp\tutorial\br_tut_utility::increment_objective( 1 );
}

// Params 0
// Size: 0x15
function monitorcrouching()
{
    scripts\mp\tutorial\br_tut_utility::waittill_is_crouching( level.player );
    scripts\mp\tutorial\br_tut_utility::increment_objective( 2 );
}

// Params 0
// Size: 0x15
function monitorprone()
{
    scripts\mp\tutorial\br_tut_utility::waittill_is_prone( level.player );
    scripts\mp\tutorial\br_tut_utility::increment_objective( 3 );
}

// Params 0
// Size: 0x1b
function monitorsliding()
{
    while ( level.player issprintsliding() == 0 )
    {
        waitframe();
    }
    
    scripts\mp\tutorial\br_tut_utility::increment_objective( 4 );
}

// Params 0
// Size: 0x50
function monitortargetrangeentrance()
{
    var0 = scripts\engine\utility::getent_or_struct( "tut_loc_1", "targetname" );
    var1 = 22500;
    
    for ( var2 = level.player.origin; distance2dsquared( var2, var0.origin ) > var1 ; var2 = level.player.origin )
    {
        waitframe();
    }
    
    flipalltargets( "up" );
}

// Params 0
// Size: 0x55
function firingchecklistdone()
{
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx ) calloutmarkerping_delete( 0 );
    level.player clearhudtutorialmessage();
    wait 1;
    scripts\mp\tutorial\br_tut_utility::clear_objectives();
    var0 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.Ñ’`ıˇì±¶eŒŸ;F`R≤¯K );
    thread single_combat_shooter();
    wait 2;
    scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_tacmap_alert_10" ] );
    scripts\mp\tutorial\br_tut_ui::ref_143a2();
}

// Params 0
// Size: 0x60
function firingchecklistguide()
{
    var0 = [ "dx_brm_sola_weapon_checklist_10" ];
    var1 = [ &monitorshooting, &monitorads, &monitorreload, &monitorweaponswitch ];
    scripts\mp\tutorial\br_tut_utility::add_objectives_for_area( 1, "FiringChecklist", "mp/br_tut2_objectives.csv", var1, var0 );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/FIRING_HINT_1" );
    
    while ( scripts\mp\tutorial\br_tut_utility::num_completed_objectives() < 2 )
    {
        wait 0.5;
    }
    
    level.player clearhudtutorialmessage();
}

// Params 0
// Size: 0x3c
function monitorshooting()
{
    while ( level.ref_13a8d < 5 )
    {
        wait 0.1;
    }
    
    scripts\mp\tutorial\br_tut_utility::increment_objective( 0 );
    
    if ( scripts\mp\tutorial\br_tut_utility::has_completed_objective( 0 ) )
    {
        if ( !scripts\mp\tutorial\br_tut_utility::has_completed_all_objectives() )
        {
            scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_weapon_good_10" ] );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x15
function monitorads()
{
    scripts\mp\tutorial\br_tut_utility::waittill_is_ads( level.player );
    scripts\mp\tutorial\br_tut_utility::increment_objective( 1 );
}

// Params 0
// Size: 0x15
function monitorreload()
{
    scripts\mp\tutorial\br_tut_utility::waittill_is_reloading( level.player );
    scripts\mp\tutorial\br_tut_utility::increment_objective( 2 );
}

// Params 0
// Size: 0x19
function monitorweaponswitch()
{
    scripts\mp\tutorial\br_tut_utility::waittill_action_performed( &isweaponchanged, level.player );
    scripts\mp\tutorial\br_tut_utility::increment_objective( 3 );
}

// Params 0
// Size: 0x48
function isweaponchanged()
{
    var0 = level.player getcurrentweapon();
    var1 = 0;
    
    if ( !isdefined( self.çº .W“+2ªY¡∑Ê ) )
    {
        var1 = 0;
    }
    else if ( !isdefined( var0 ) )
    {
        var1 = 1;
    }
    else
    {
        var1 = var0.basename != self.çº .W“+2ªY¡∑Ê.basename;
    }
    
    self.çº .W“+2ªY¡∑Ê = var0;
    return var1;
}

// Params 0
// Size: 0x10
function monitorgrenade()
{
    scripts\mp\tutorial\br_tut_utility::waittill_action_performed( &isthrowinggrenade, level.player );
}

// Params 0
// Size: 0x1d
function pingchecklistdone()
{
    scripts\mp\tutorial\br_tut_ui::stop_nagging();
    wait 1;
    scripts\mp\tutorial\br_tut_utility::clear_objectives();
    scripts\mp\tutorial\br_tut_utility::ref_12116( "tut_progress_gate_01" );
}

// Params 0
// Size: 0x5e
function pingchecklist()
{
    var0 = [ "dx_brm_sola_ping_try_10", "dx_brm_sola_ping_checklist_10", "dx_brm_sola_ping_spot_10" ];
    var1 = [ &monitorpinglocation, &monitorpingarmor, &monitorpingweapon, &monitorpinghostile ];
    scripts\mp\tutorial\br_tut_utility::add_objectives_for_area( 2, "PingChecklist", "mp/br_tut2_objectives.csv", var1, var0 );
    
    while ( scripts\mp\tutorial\br_tut_utility::num_completed_objectives() < 2 )
    {
        wait 0.5;
    }
    
    level.player clearhudtutorialmessage();
}

// Params 0
// Size: 0x19
function monitorpinglocation()
{
    level.player scripts\mp\tutorial\br_tut_utility::waittill_player_pings( &scripts\mp\tutorial\br_tut_utility::islocationping );
    waitframe();
    scripts\mp\tutorial\br_tut_utility::increment_objective( 0 );
}

// Params 0
// Size: 0x1a
function monitorpingarmor()
{
    level.player scripts\mp\tutorial\br_tut_utility::waittill_player_pings( &scripts\mp\tutorial\br_tut_utility::isarmorping );
    waitframe();
    scripts\mp\tutorial\br_tut_utility::increment_objective( 1 );
}

// Params 0
// Size: 0x1a
function monitorpingweapon()
{
    level.player scripts\mp\tutorial\br_tut_utility::waittill_player_pings( &scripts\mp\tutorial\br_tut_utility::isweaponping );
    waitframe();
    scripts\mp\tutorial\br_tut_utility::increment_objective( 2 );
}

// Params 0
// Size: 0x1a
function monitorpinghostile()
{
    level.player scripts\mp\tutorial\br_tut_utility::waittill_player_pings( &scripts\mp\tutorial\br_tut_utility::ishostileping );
    waitframe();
    scripts\mp\tutorial\br_tut_utility::increment_objective( 3 );
}

// Params 0
// Size: 0x163
function initpopuptargets()
{
    level.ref_132b6 = [];
    level.ref_13a8d = 0;
    level.å°W=úhÙJËyÛS;{¿»– = 0;
    
    foreach ( var1 in getentarray( "danger_target", "targetname" ) )
    {
        var2 = getentarray( var1.target, "targetname" );
        
        foreach ( var4 in var2 )
        {
            switch ( var4.classname )
            {
                case "script_model":
                    var1.plate = var4;
                    break;
                case "script_brushmodel":
                    var1.collision = var4;
                    break;
                default:
                    break;
            }
        }
        
        var1.plate linkto( var1 );
        var1.upangles = var1.angles;
        
        if ( !isdefined( var1.script_parameters ) )
        {
            var1.milestonephasepercent_drops = var1.angles - ( 90, 0, 0 );
        }
        else
        {
            var1.milestonephasepercent_drops = var1.angles + ( 90, 0, 0 );
        }
        
        var1.angles = var1.milestonephasepercent_drops;
        var1.state = "down";
        level.ref_132b6[ level.ref_132b6.size ] = var1;
        thread fliptarget( var1 );
        thread targetdmgmonitor();
    }
}

// Params 0
// Size: 0xbf
function targetdmgmonitor()
{
    if ( istrue( self.isactive ) )
    {
        return;
    }
    
    self.isactive = 1;
    self.hadarmor = undefined;
    self.hasarmor = undefined;
    var0 = undefined;
    var1 = undefined;
    
    for ( ;; )
    {
        self.plate waittill( "damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        
        if ( !level.å°W=úhÙJËyÛS;{¿»– )
        {
            if ( isplayer( var3 ) )
            {
                if ( isdefined( var6 ) )
                {
                    if ( scripts\engine\utility::isbulletdamage( var6 ) )
                    {
                        var3 thread scripts\mp\damagefeedback::updatehitmarker( "standard", 1 );
                        self.plate playsound( "br_sfx_target_report_metal_light" );
                        
                        if ( self.state == "up" )
                        {
                            thread fliptarget( "down" );
                            level.ref_13a8d++;
                            level notify( "popupTargetHit" );
                        }
                    }
                }
            }
        }
    }
}

// Params 2
// Size: 0x11a
function fliptarget( var0, var1 )
{
    if ( self.state == var0 )
    {
        return;
    }
    
    while ( isdefined( self.ismoving ) )
    {
        waitframe();
    }
    
    self.ismoving = 1;
    self.state = var0;
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0.3;
    }
    
    if ( var0 == "up" )
    {
        if ( !isdefined( level.ref_123b6 ) )
        {
            level.ref_123b6 = 0;
        }
        else if ( level.ref_123b6 == 6 )
        {
            level.ref_123b6 = 1;
        }
        
        if ( !isdefined( self.plate.index ) )
        {
            level.ref_123b6++;
            var2 = "ee_military_shooting_range_plate_enemy_01_ww2";
            self.plate setmodel( var2 );
            self.ref_123b6 = level.ref_123b6;
        }
        
        self.collision solid();
        self rotateto( self.upangles, var1, var1 * 0.9, var1 * 0.1 );
        self playsound( "br_sfx_target_flipup" );
        self.plate setcandamage( 1 );
        self.collision enableaimassist();
    }
    else if ( var0 == "down" )
    {
        self.collision disableaimassist();
        self.collision notsolid();
        self rotateto( self.milestonephasepercent_drops, var1, var1 * 0.9, var1 * 0.1 );
    }
    
    wait var1;
    self.ismoving = undefined;
}

// Params 2
// Size: 0xd9
function flipalltargets( var0, var1 )
{
    var2 = getentarray( "danger_target", "targetname" );
    var3 = [];
    var4 = undefined;
    var5 = -1000;
    var6 = 7050;
    var7 = 0;
    var8 = var2.size;
    
    for ( var9 = 0; var9 < var8 ; var9++ )
    {
        for ( var10 = 0; var10 < var8 ; var10++ )
        {
            if ( isdefined( var2[ var10 ] ) )
            {
                if ( var2[ var10 ].origin[ 0 ] > var5 )
                {
                    var5 = var2[ var10 ].origin[ 0 ];
                    var6 = var2[ var10 ].origin[ 1 ];
                    var4 = var2[ var10 ];
                    var7 = var10;
                }
            }
        }
        
        var3 = var4;
        var2[ var7 ] = undefined;
        var5 = -1000;
        var6 = 7050;
        var7 = 0;
    }
    
    foreach ( var12 in var3 )
    {
        thread fliptarget( var12, var0 );
        wait randomfloatrange( 0.05, 0.15 );
    }
}

// Params 1
// Size: 0x26
function clear_blockers( var0 )
{
    var1 = getentarray( var0, "targetname" );
    
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        var1[ var2 ] delete();
    }
}

// Params 0
// Size: 0x61
function ref_12849()
{
    var0 = level.br_level.default_class_chosen[ 0 ];
    level.br_level.default_class_chosen[ 1 ] = var0;
    level.br_level.default_class_chosen[ 2 ] = var0;
    level.br_level.default_class_chosen[ 3 ] = var0;
    level.br_level.default_class_chosen[ 4 ] = var0;
    level.br_level.default_class_chosen[ 5 ] = var0;
}

// Params 0
// Size: 0x10
function mapcenterfinalcircle_brtutorial()
{
    return ( 700, 5000, 0 );
}

// Params 0
// Size: 0x22a
function gascircleinit()
{
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "circle" );
    level.br_level = spawnstruct();
    level.br_level.ref_13884 = 1;
    level.mapcorners[ 0 ].origin = ( -1000, 2000, 0 );
    level.mapcorners[ 1 ].origin = ( 2350, 7050, 0 );
    level.mapsafecorners = [];
    level.mapsafecorners[ 0 ] = ( -1000, 2000, 0 );
    level.mapsafecorners[ 1 ] = ( 2350, 7050, 0 );
    var0 = level.mapcorners[ 0 ].origin[ 0 ];
    var1 = level.mapcorners[ 1 ].origin[ 0 ];
    var2 = level.mapcorners[ 1 ].origin[ 1 ];
    var3 = level.mapcorners[ 0 ].origin[ 1 ];
    level.br_level.delay_set_bomber_traversals = [];
    level.br_level.delay_set_bomber_traversals[ 0 ] = ( var0, var2, 0 );
    level.br_level.delay_set_bomber_traversals[ 1 ] = ( var1, var3, 0 );
    var0 = level.mapcorners[ 0 ].origin[ 0 ];
    var1 = level.mapcorners[ 1 ].origin[ 0 ];
    var2 = level.mapcorners[ 1 ].origin[ 1 ];
    var3 = level.mapcorners[ 0 ].origin[ 1 ];
    level.br_level.br_mapbounds = [];
    level.br_level.br_mapbounds[ 0 ] = ( var0, var2, 0 );
    level.br_level.br_mapbounds[ 1 ] = ( var1, var3, 0 );
    level.br_level.br_mapcenter = ( ( var0 + var1 ) / 2, ( var2 + var3 ) / 2, 0 );
    level.br_level.br_mapsize = ( abs( var1 - var0 ), abs( var3 - var2 ), 2000 );
    level.br_level.br_circleclosetimes = [ 99999 ];
    level.br_level.br_circledelaytimes = [ 99999 ];
    level.br_level.default_player_connect_black_screen = [ 0 ];
    level.br_level.default_suicidebomber_combat = [ 0 ];
    level.br_level.br_circleminimapradii = [ 3200 ];
    level.br_level.br_circleradii = [ 3200, 3200 ];
    scripts\mp\gametypes\br_circle::cacheentity();
    level.ref_12303 = 1;
}

// Params 0
// Size: 0x1d
function modify_player_damage()
{
    while ( !isdefined( level.modifyplayerdamage ) )
    {
        wait 0.25;
    }
    
    level.modifyplayerdamage = &tutorialmodifyplayerdamage;
}

// Params 11
// Size: 0x77
function tutorialmodifyplayerdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    if ( var3 > 0 )
    {
        if ( isbot( self ) )
        {
            if ( !scripts\mp\utility\player::unset_relic_trex( self ) && scripts\engine\utility::is_equal( var4, "MOD_FALLING" ) )
            {
                var3 = var3;
            }
            
            if ( scripts\mp\utility\player::unset_relic_trex( self ) && isdefined( self.´¨	·É™Î`√ ) )
            {
                var3 = 0;
            }
        }
        else if ( !isbot( self ) )
        {
            if ( !scripts\mp\utility\player::unset_relic_trex( self ) && self.health <= var3 )
            {
                var3 = 0;
            }
        }
    }
    
    return var3;
}

// Params 1
// Size: 0x34, Type: bool
function watch_flight_collision( var0 )
{
    if ( isbot( var0.victim ) )
    {
        if ( isenemyteam( var0.victim.team, level.player.team ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x90
function start_revival_actions()
{
    self endon( "death" );
    self endon( "disconnect" );
    var0 = self;
    var0.´¨	·É™Î`√ = 1;
    var1 = undefined;
    var2 = undefined;
    
    while ( !scripts\mp\utility\player::unset_relic_trex( self ) )
    {
        self dodamage( 1000, self.origin, var1, var2, "MOD_FALLING" );
        level.player playsound( "weap_alpha50_fire_plr" );
        waitframe();
    }
    
    var0 setthreatbiasgroup( "bot_harmless" );
    var0 botsetflag( "disable_movement", 1 );
    var0 botsetflag( "disable_rotation", 1 );
    wait 1;
    scripts\mp\tutorial\br_tut_ui::start_nagging( [ "dx_brm_sola_teammate_revive_enemy_10" ] );
    level notify( "player_downed", self );
}

// Params 0
// Size: 0x4c
function friendly_path_to_armory()
{
    self endon( "death" );
    var0 = self;
    scripts\mp\tutorial\br_tut_utility::waittill_action_performed( &isonground, var0 );
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "armory_enter" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.5, var1 );
    var2 = var0.á5€ÒÂC1H3äg√∞¬[ "armory_enter_look" ];
    var0 botlookatpoint( var2, 1 );
}

// Params 0
// Size: 0xb7
function friendly_path_to_supply_cache()
{
    self endon( "death" );
    wait 0.3;
    
    if ( !level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ )
    {
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_loot_sound_box_10" ] );
    }
    
    var0 = self;
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "supply_cache_wait" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.05, var1 );
    var2 = getent( "weapon_box", "targetname" );
    var0 botlookatpoint( var2.origin + ( 0, 0, 50 ), 4 );
    var3 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_entrance" ];
    var4 = vectortoyaw( var3 - var0.origin );
    var0 setplayerangles( ( 0, var4, 0 ) );
    wait 1;
    
    if ( !level.¨ç≈£_yJê'≤ ÿ∞§/ëz®≥ wÄßõ¯©¡ )
    {
        scripts\mp\tutorial\br_tut_ui::add_explicit_array_to_vo_queue( [ "dx_brm_sola_loot_open_box_10" ] );
    }
    
    level notify( "friendlyReachedBox" );
}

// Params 0
// Size: 0xb4
function friendly_path_to_target_range()
{
    self endon( "death" );
    var0 = self;
    var0 botsetflag( "disable_movement", 0 );
    var0 botsetflag( "disable_rotation", 0 );
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_entrance" ];
    var2 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_ladder" ];
    var3 = vectortoyaw( var2 - var1 );
    var0 setplayerangles( ( 0, var3, 0 ) );
    var0 botlookatpoint( var1, 1 );
    var0 botsetscriptgoal( var1, 10, "tactical", var3, undefined, 1 );
    scripts\engine\utility::flag_wait( "at_target_range" );
    self botclearscriptgoal();
    var2 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_ladder" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.1, var2 );
    var4 = var0.á5€ÒÂC1H3äg√∞¬[ "firing_range_look" ];
    var0 botlookatpoint( var4, 1 );
}

// Params 0
// Size: 0xf5
function friendly_path_to_sniper_tower()
{
    self endon( "death" );
    var0 = self;
    var1 = var0.á5€ÒÂC1H3äg√∞¬[ "sniper_tower_base" ];
    var2 = var0.á5€ÒÂC1H3äg√∞¬[ "sniper_tower_base_look" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.5, var1, 10 );
    var0 botlookatpoint( var2, 1 );
    scripts\engine\utility::flag_wait( "encounter_trigger" );
    clear_blockers( "ladder_blocker_sniper_tower" );
    var3 = var0.á5€ÒÂC1H3äg√∞¬[ "sniper_tower_top" ];
    var0 scripts\mp\tutorial\br_tut_bots::run_to_spot( 0.1, var3 );
    var2 = var0.á5€ÒÂC1H3äg√∞¬[ "sniper_tower_top_look" ];
    var0 botlookatpoint( var2, 1 );
    
    while ( !scripts\engine\utility::flag_exist( "encounter_room_trigger" ) )
    {
        wait 0.5;
    }
    
    scripts\engine\utility::flag_wait( "encounter_room_trigger" );
    level.player.Å‘-s≥VF}+õ+∂/ = undefined;
    
    for ( ;; )
    {
        waitframe();
        var4 = find_pinged_danger();
        
        if ( isdefined( var4 ) )
        {
            var0 botlookatpoint( var4, 5, "script_forced" );
            var0 botpressbutton( "attack", randomfloatrange( 0.1, 3 ) );
            wait randomfloatrange( 1, 4 );
        }
    }
}

// Params 0
// Size: 0xd1
function find_pinged_danger()
{
    for ( var0 = 4; var0 <= 6 ; var0++ )
    {
        if ( level.player calloutmarkerping_getfeedback( var0 ) )
        {
            var1 = level.player calloutmarkerping_getsavedzoffset( var0 );
            
            if ( isdefined( var1 ) && isbot( var1 ) )
            {
                level.player.Å‘-s≥VF}+õ+∂/ = var1;
            }
        }
    }
    
    var2 = 400;
    var3 = 10000;
    var0 = 1;
    
    while ( var0 <= 3 )
    {
        if ( level.player calloutmarkerping_getfeedback( var0 ) )
        {
            var4 = level.player setallstreamloaddist( var0 );
            
            if ( isdefined( level.player.Å‘-s≥VF}+õ+∂/ ) )
            {
                var5 = level.player.Å‘-s≥VF}+õ+∂/.origin;
                var6 = distance2dsquared( var5, var4 );
                var7 = distancesquared( var5, var4 );
                
                if ( distance2dsquared( var5, var4 ) < var2 && distancesquared( var5, var4 ) < var3 )
                {
                    var4 = level.player.Å‘-s≥VF}+õ+∂/ geteye();
                }
            }
            
            return var4;
        }
        
        var2++;
    }
}

// Params 0
// Size: 0x36
function single_combat_shooter()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    wait 0.25;
    
    for ( ;; )
    {
        self botpressbutton( "attack", 0.75 );
        wait randomfloatrange( 0.75, 1.75 );
    }
}

// Params 0
// Size: 0x117
function single_combat_brains()
{
    self endon( "death" );
    var0 = self;
    var1 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    level.ÉÅ
[ÿ¢ãhA-r·Å = gettime() + 216000000;
    var0 scripts\mp\tutorial\br_tut_bots::load_player_targets( "single_target_spot" );
    var0 setsquadindex( 0 );
    var2 = scripts\mp\tutorial\br_tut_bots::load_logic_waypoints( "single_combat_waypoints" );
    var3 = var2[ "Bandicoot" ];
    var4 = var3[ "single_combat_camp" ];
    thread notify_when_downed( level );
    var5 = var3[ "single_combat_attack" ];
    thread notify_when_entering_single_combat( level );
    var0 setsquadindex( 0 );
    var6 = var3[ "Start" ];
    var0 scripts\mp\tutorial\br_tut_bots::set_player_attributes( var6 );
    var0 botlookatpoint( var6.origin, 10 );
    scripts\engine\utility::flag_wait( var4.script_startname );
    var0 scripts\mp\tutorial\br_tut_bots::set_player_attributes( var4 );
    var0 botclearscriptgoal();
    var0 botsetscriptgoal( var4.origin, 20, var4.script_objective );
    var7 = var0 scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
    scripts\engine\utility::flag_wait( var5.script_startname );
    var0 scripts\mp\tutorial\br_tut_bots::set_player_attributes( var5 );
    var0 botclearscriptgoal();
    var0 botsetscriptgoal( var5.origin, 20, var5.script_objective );
    var7 = var0 scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

// Params 1
// Size: 0x32
function notify_when_downed( var0 )
{
    var1 = scripts\mp\tutorial\br_tut_bots::bot_entity( level.¶y
ê)«æPŸV!ìx );
    
    while ( !scripts\mp\utility\player::unset_relic_trex( var1 ) )
    {
        waitframe();
    }
    
    scripts\engine\utility::flag_set( var0 );
    level.player sethudtutorialmessage( &"MP_BR_TUT2/FIRST_FIGHT_HINT_1" );
}

// Params 1
// Size: 0x38
function notify_when_entering_single_combat( var0 )
{
    for ( ;; )
    {
        waitframe();
        
        if ( scripts\engine\utility::flag( var0 ) )
        {
            break;
        }
        
        var1 = level.player.watch_for_players_regrouping_to_plane;
        
        if ( isdefined( var1 ) && var1 > level.ÉÅ
[ÿ¢ãhA-r·Å )
        {
            break;
        }
    }
}

// Params 3
// Size: 0x1e
function spawn_scriptable_object( var0, var1, var2 )
{
    var3 = easepower( var0, var1, var2, 0 );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    scripts\mp\gametypes\br_pickups::ref_12b3a( var3 );
    return var3;
}

// Params 1
// Size: 0x1a
function skydive_autodeploy_at_height( var0 )
{
    while ( self.origin[ 2 ] > var0 )
    {
        waitframe();
    }
    
    self skydive_deployparachute();
}

