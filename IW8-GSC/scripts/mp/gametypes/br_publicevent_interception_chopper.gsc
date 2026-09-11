
// Params 0
// Size: 0x92
function init()
{
    var0 = spawnstruct();
    var0.attackerswaittime = &ascendermodelview;
    var0.isfeaturedisabled = &deactivate;
    var0.ref_14382 = &ref_14382;
    var0.‹Á¿ø{ÏXX;â# / = &postinitfunc;
    var0.weight = getdvarfloat( "scr_br_pe_interception_weight", 0 );
    var0.ref_11b78 = getdvarint( "scr_br_pe_interception_max_times", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "interception", "0    20  20  20          0   0   0   0" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "interception" );
    thread tracegroundheightexfil();
    scripts\mp\gametypes\br_publicevents::ref_12b35( 17, var0 );
}

// Params 0
// Size: 0x25
function postinitfunc()
{
    tr_vis_radius_override_lod2();
    initloottables();
    thermite_linktostuck();
    thermite_watchglstuck();
    scripts\engine\scriptable::ref_12f5b( "scriptable_interception_bag", &chopper_bag_used );
}

// Params 0
// Size: 0x2e2
function tr_vis_radius_override_lod2()
{
    level.ref_12e2b = spawnstruct();
    level.ref_12e2b.¶¹…õ›¾²Êsëcí°ÒŞæ¹ = get_possible_event_locations();
    level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã = [];
    level.ref_12e2b.sg_ontimerexpired = getdvarint( "scr_interception_hasLootPinata", 1 );
    level.ref_12e2b.ref_11f1f = getdvarint( "scr_interception_numEnemyAgents", 5 );
    level.ref_12e2b.spawnregions = getdvarint( "scr_interception_chopperWaitTime", 120 );
    level.ref_12e2b.²* —#—V}1'Ë—'» = getdvarint( "scr_interception_prePinataUses", 4 );
    level.ref_12e2b.šè0¯[(ŸÚÍ¸=§²WÒ ¿(Èìà = getdvarint( "scr_interception_cashLootedXpSmall", 50 );
    level.ref_12e2b.•¡ÿ³Öê7c°Séo£/·Ko=tâ = getdvarint( "scr_interception_cashLootedXpLarge", 100 );
    level.ref_12e2b.Š ;VÍ£¯µK6VõÁ = getdvarint( "scr_interception_agentKilledXp", 10 );
    level.ref_12e2b.ªÆØ¹ĞõZÜ•7 = [ "cashlootsm", "cashlootmd", "cashlootlrg", "cashlootepic", "cashlootlegend" ];
    var0 = getdvar( "scr_interception_minCashRewards", "" );
    level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ = [];
    
    if ( var0 != "" )
    {
        var1 = strtok( var0, " " );
        
        foreach ( var3 in var1 )
        {
            level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ[ level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ.size ] = int( var3 );
        }
    }
    else
    {
        level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ = [ 15, 0, 0, 0, 0 ];
    }
    
    var5 = getdvar( "scr_interception_maxCashRewards", "" );
    level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡ = [];
    
    if ( var5 != "" )
    {
        var6 = strtok( var5, " " );
        
        foreach ( var3 in var6 )
        {
            level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡[ level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡.size ] = float( var3 );
        }
    }
    else
    {
        level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡ = [ 25, 0, 0, 0, 0 ];
    }
    
    if ( level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡.size != level.ref_12e2b.ªÆØ¹ĞõZÜ•7.size || level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ.size != level.ref_12e2b.ªÆØ¹ĞõZÜ•7.size )
    {
    }
    
    level.ref_12e2b.ref_11bab = [ "brloot_plunder_cash_uncommon_1", "brloot_plunder_cash_uncommon_2", "brloot_plunder_cash_uncommon_3" ];
    level.ref_12e2b.waitteardowninfilmapomnvars = [ "brloot_plunder_cash_rare_1", "brloot_plunder_cash_rare_2" ];
    level.ref_12e2b.ref_14292 = [ "brloot_plunder_cash_epic_1", "brloot_plunder_cash_epic_2" ];
    level.ref_12e2b.¯A§5õH°‡mP8§_ = [ "brloot_ammo_12g", "brloot_ammo_50cal", "brloot_ammo_rocket", "brloot_ammo_919", "brloot_ammo_762" ];
    level.ref_12e2b.
£û¹BYğ = !level.br_circle_disabled;
    level._effect[ "vfx_smk_signal_green" ] = loadfx( "vfx/iw8_cp/prop/vfx_smk_signal_green" );
}

// Params 0
// Size: 0x7f
function initloottables()
{
    var0 = [];
    
    switch ( getdvar( "mapname" ) )
    {
        default:
            switch ( scripts\mp\utility\game::getgametype() )
            {
                default:
                    GscBinSkip0( 0x2e, "brloot_offhand_kioskdrop", 1 );
                    // Unknown operator ( 0x2e, iw8, PC )
            }
            
            break;
    }
    
    _handlevehiclerepair::ref_11a45( "interception_final_pinata", var0 );
}

// Params 0
// Size: 0xa7
function tracegroundheightexfil()
{
    waitframe();
    
    if ( !isdefined( game[ "dialogForAllTeams" ] ) )
    {
        game[ "dialogForAllTeams" ] = [];
    }
    
    register_interception_dialogue( "interception_agent_respawn", "dx_bra_hcpt_public_events_agent_respawn" );
    register_interception_dialogue( "interception_event_start", "dx_bra_bchr_public_events_event_start" );
    register_interception_dialogue( "interception_chopper_crash", "dx_bra_hcpt_public_events_helicopter_crash" );
    register_interception_dialogue( "interception_chopper_health_75", "dx_bra_hcpt_public_events_helicopter_health_low" );
    register_interception_dialogue( "interception_chopper_health_50", "dx_bra_hcpt_public_events_helicopter_health_50" );
    register_interception_dialogue( "interception_chopper_health_25", "dx_bra_hcpt_public_events_helicopter_health_25" );
    register_interception_dialogue( "interception_chopper_return", "dx_bra_hcpt_public_events_helicopter_return" );
    register_interception_dialogue( "interception_loot_bag", "dx_bra_hcpt_public_events_loot_interact" );
    register_interception_dialogue( "interception_empty_bag", "dx_bra_hcpt_public_events_loot_interact_empty" );
}

// Params 3
// Size: 0x43
function play_vo_near_location( var0, var1, var2 )
{
    var3 = scripts\common\utility::playersincylinder( var1, var2 );
    
    foreach ( var5 in var3 )
    {
        if ( scripts\mp\utility\player::isreallyalive( var5 ) )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var5 );
        }
    }
}

// Params 0
// Size: 0x217
function get_possible_event_locations()
{
    var0 = [];
    
    switch ( getdvar( "mapname" ) )
    {
        case "mp_sm_island_1":
            GscBinSkip0( 0x2e, var0.size, ref_12ade( ( -224, -302, 1290 ), [], 100, 700 ) );
            // Unknown operator ( 0x2e, iw8, PC )
        default:
            GscBinSkip0( 0x2e, var0.size, ref_12ade( ( -146, -246, 20 ), [ [ ( -146, -246, 0 ), ( 146, -246, 0 ) ], [ ( -246, -146, 0 ), ( 246, -146, 0 ) ] ], 100, 500 ) );
            // Unknown operator ( 0x2e, iw8, PC )
    }
    
    return var0;
}

// Params 4
// Size: 0x44
function ref_12ade( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.minecart_run = var0;
    var4.ªàK<Øø’'«£ú> = var1;
    var4.minigun_internal = var2;
    var4.¬’ûbóQÃ`­?£³ = var3;
    var4.ref_13b91 = 0;
    var4.new_rider_combat_logic = [];
    return var4;
}

#using_animtree( "" );

// Params 0
// Size: 0x53
function thermite_linktostuck()
{
    level.scr_anim[ "plunder_extract_heli" ][ "heli_in" ] = %iw8_br_plunder_heli_in;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_loop" ] = $iw8_br_plunder_heli_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_out" ] = %iw8_br_plunder_heli_out;
}

// Params 0
// Size: 0xd8
function thermite_watchglstuck()
{
    level.scr_animtree[ "plunder_extract_heli" ] = #animtree;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_in" ] = $iw8_br_plunder_heli_rope_in;
    level.scr_animname[ "plunder_extract_heli" ][ "rope_in" ] = "iw8_br_plunder_heli_rope_in";
    level.scr_anim[ "plunder_extract_heli" ][ "rope_out" ] = %iw8_br_plunder_heli_rope_out;
    level.scr_animname[ "plunder_extract_heli" ][ "rope_out" ] = "iw8_br_plunder_heli_rope_out";
    level.scr_anim[ "plunder_extract_heli" ][ "bag_in" ] = %iw8_br_plunder_heli_bag_in;
    level.scr_animname[ "plunder_extract_heli" ][ "bag_in" ] = "iw8_br_plunder_heli_bag_in";
    level.scr_anim[ "plunder_extract_heli" ][ "bag_out" ] = %iw8_br_plunder_heli_bag_out;
    level.scr_animname[ "plunder_extract_heli" ][ "bag_out" ] = "iw8_br_plunder_heli_bag_out";
}

// Params 2
// Size: 0x1c
function register_interception_dialogue( var0, var1 )
{
    game[ "dialog" ][ var0 ] = var1;
    game[ "dialogForAllTeams" ][ var0 ] = 1;
}

// Params 0
// Size: 0x1df
function ascendermodelview()
{
    level.ref_12e2b.¶¹…õ›¾²Êsëcí°ÒŞæ¹ = scripts\engine\utility::array_randomize( level.ref_12e2b.¶¹…õ›¾²Êsëcí°ÒŞæ¹ );
    var0 = undefined;
    var1 = 0;
    var2 = 0;
    
    if ( level.ref_12e2b.
£û¹BYğ )
    {
        var1 = scripts\mp\gametypes\br_circle::inithelirepository() < 30 + level.ref_12e2b.spawnregions && !scripts\mp\gametypes\br_circle::islastcircle();
        var2 = scripts\mp\gametypes\br_circle::inithelirepository() < 30 && !scripts\mp\gametypes\br_circle::islastcircle();
    }
    
    foreach ( var4 in level.ref_12e2b.¶¹…õ›¾²Êsëcí°ÒŞæ¹ )
    {
        if ( !level.ref_12e2b.
£û¹BYğ )
        {
            if ( !scripts\engine\utility::array_contains( level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã, var4.minecart_run ) )
            {
                var0 = var4;
            }
            
            continue;
        }
        
        if ( var2 )
        {
            if ( scripts\mp\gametypes\br_circle::updatescavengerhud( var4.minecart_run ) && !scripts\engine\utility::array_contains( level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã, var4.minecart_run ) )
            {
                var0 = var4;
            }
            
            continue;
        }
        
        if ( var1 )
        {
            if ( scripts\mp\gametypes\br_circle::updatescavengerhud( var4.minecart_run ) && scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var4.minecart_run ) && !scripts\engine\utility::array_contains( level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã, var4.minecart_run ) )
            {
                var0 = var4;
            }
            
            continue;
        }
        
        if ( scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var4.minecart_run ) && !scripts\engine\utility::array_contains( level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã, var4.minecart_run ) )
        {
            var0 = var4;
        }
    }
    
    if ( isdefined( var0 ) )
    {
        foreach ( var7 in level.players )
        {
            var7 thread scripts\mp\hud_message::showsplash( "br_pe_interception_start" );
            
            if ( scripts\mp\utility\player::isreallyalive( var7 ) )
            {
                level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "interception_event_start", var7 );
            }
        }
        
        level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã[ level.ref_12e2b.©à²YMIOû=ìßÅ£÷Í¡Áêê;ûwPã.size ] = var0.minecart_run;
        thread ref_13794( var0 );
        scripts\common\vehicle_code::vehicle_start_ai_avoidance();
        return;
    }
}

// Params 0
// Size: 0x2
function deactivate()
{
    
}

// Params 0
// Size: 0x39
function ref_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    
    if ( getdvarint( "scr_br_loadout_delay", 0 ) == 1 && level.br_circle.circleindex <= 1 )
    {
        level waittill( "br_circle_closing" );
        return;
    }
}

// Params 1
// Size: 0x26e
function ref_13794( var0 )
{
    var0.½ÇX6×«ëø × = spawn( "trigger_radius", var0.minecart_run + ( 0, 0, -30 ), 0, var0.¬’ûbóQÃ`­?£³, var0.¬’ûbóQÃ`­?£³ * 2 );
    var1 = randomfloat( 360 );
    var2 = var0.minecart_run + -1 * anglestoforward( ( 0, var1, 0 ) ) * 26000 + ( 0, 0, 3300 );
    var3 = vectortoangles( var0.minecart_run - var2 );
    var4 = 99;
    var5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter( level.players[ randomint( level.players.size ) ], var2, var3, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_mercenary_extraction_x" );
    
    if ( !isdefined( var5 ) )
    {
        return;
    }
    
    var6 = var0.minecart_run * ( 1, 1, 0 ) + ( 0, 0, 3300 );
    var0.heli = var5;
    var5.ref_11980 = var0;
    var5.damagecallback = &callback_vehicledamage;
    var5.speed = 50;
    var5.accel = 125;
    var5.health = 10000;
    var5.maxhealth = var5.health;
    var5.defendloc = var0.minecart_run;
    var5.lifeid = 0;
    var5.flaresreservecount = var4;
    var5.pathgoal = var6;
    var5.ref_121ff = var0.minecart_run + anglestoforward( var3 ) * 26000 + ( 0, 0, 3300 );
    var5.endpoint = var6;
    var5.select_mountain_two_spawners = var3[ 1 ];
    var5.animname = "plunder_extract_heli";
    var5.leaving = 0;
    var5.§¤êœœ¬Í£ØËc,/K¹³ì{ = 0;
    var5.‚_Ò—³ 7“!†°ıŠ±ÃÊ = 0;
    var5.×¼VFÔ+°Ñ4‰“Ú = 0;
    var5.•J6,^YM¡Ê…cGĞ&,NÚ = 0;
    var5.scenenode = spawn( "script_model", var5.defendloc );
    var5.scenenode.angles = var3;
    var5.scenenode setmodel( "tag_origin" );
    var5.vehiclename = "magma_plunder_chopper";
    var5 setcandamage( 1 );
    var5 setmaxpitchroll( 10, 25 );
    var5 vehicle_setspeed( var5.speed, var5.accel );
    var5 sethoverparams( 50, 100, 50 );
    var5 setturningability( 0.05 );
    var5 setyawspeed( 45, 25, 25, 0.5 );
    ref_13693( var5 );
    thread showquestcircletoplayer();
    thread handledestroydamage();
    thread givebrbonusxp();
    var5 method_87e8();
    thread helidestroyvehiclescollisionnotify();
    thread givebrweaponxp();
}

// Params 0
// Size: 0xe5
function givebrweaponxp()
{
    self endon( "death" );
    self endon( "leaving" );
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    self.scenenode thread scripts\common\anim::anim_single_solo( self, "heli_in" );
    thread scripts\common\anim::anim_single_solo( self.rope, "rope_in", "origin_animate_jnt" );
    thread scripts\common\anim::anim_single_solo( self.crate, "bag_in", "origin_animate_jnt" );
    var0 = givequestsplash( self.pathgoal, self.ref_11980 );
    thread heli_spawn_smoke_marker();
    scripts\mp\gametypes\br_quest_util::ref_140b1( self.ref_11980.§ Ÿ€£»5æR;ÈGZ(³ô, "dom" );
    var1 = spawnstruct();
    var1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 11, 4, 2, self.ref_11980.§ Ÿ€£»5æR;ÈGZ(³ô );
    var1 scripts\mp\gametypes\br_quest_util::ref_1316f( 1000 );
    var1 scripts\mp\gametypes\br_quest_util::ref_13369();
    thread quest_circle_cleanup_on_chopper_death( level );
    self waittill( "goal" );
    var1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
    thread givespecialistbonusifneeded();
    givebmodevloadouts( self.endpoint, var0 );
}

// Params 1
// Size: 0x28
function quest_circle_cleanup_on_chopper_death( var0 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    self endon( "goal" );
    self waittill( "death" );
    var0 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
}

// Params 0
// Size: 0x4f
function heli_spawn_smoke_marker()
{
    var0 = spawn( "script_model", self.ref_11980.§ Ÿ€£»5æR;ÈGZ(³ô - ( 0, 0, 3 ) );
    var0 setmodel( "tag_origin" );
    self.mæµŞ[ÊÎ™á•¹è = var0;
    wait 1;
    playfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_green" ), var0, "tag_origin" );
}

// Params 2
// Size: 0x71
function givebmodevloadouts( var0, var1 )
{
    self endon( "death" );
    var2 = var0[ 0 ];
    var3 = var0[ 1 ];
    var4 = ( var2, var3, var1 );
    self setvehgoalpos( var4, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    self vehicle_setspeed( 25, 31.25 );
    thread chopper_start_agent_spawn( 0.1, 0.8 );
    thread agent_watch_danger_circle( level );
    self waittill( "goal" );
    self sethoverparams( 1, 1 );
    thread giverandomloadoutindex();
}

// Params 0
// Size: 0x7b
function helidestroyvehiclescollisionnotify()
{
    self endon( "heli_gone" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "collision", var0, var1, var2, var3, var4, var5, var6, var7 );
        
        if ( isdefined( var7 ) && nuke_vault_suicidebomber_internal( var7 ) )
        {
            var7 dodamage( var7.health, self.origin, self, self, "MOD_CRUSH" );
            self dodamage( self.maxhealth / 2, self.origin, var7, var7, "MOD_CRUSH" );
        }
    }
}

// Params 0
// Size: 0x25, Type: bool
function nuke_vault_suicidebomber_internal()
{
    return isalive( self ) && ( scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle" );
}

// Params 1
// Size: 0xb3
function agent_watch_danger_circle( var0 )
{
    level endon( "game_ended" );
    
    if ( getdvarint( "scr_br_circle_disable" ) == 0 )
    {
        while ( var0.new_rider_combat_logic.size > 0 || isdefined( var0.heli ) && !var0.heli.leaving )
        {
            foreach ( var2 in var0.new_rider_combat_logic )
            {
                if ( isdefined( var2 ) && isalive( var2 ) )
                {
                    if ( !scripts\mp\gametypes\br_circle::updateprestreamrespawn( var2.origin ) )
                    {
                        var2 dodamage( var2.health, var2.origin, var2, undefined, "MOD_TRIGGER_HURT", undefined );
                    }
                }
            }
            
            wait 0.1;
        }
        
        scripts\common\vehicle_code::vehicle_stop_ai_avoidance();
        return;
    }
}

// Params 2
// Size: 0x1b8
function chopper_start_agent_spawn( var0, var1 )
{
    waitframe();
    var2 = level.ref_12e2b.ref_11f1f - self.ref_11980.new_rider_combat_logic.size;
    
    if ( var2 == 0 )
    {
        return;
    }
    
    var3 = 360 / var2;
    var4 = anglestoforward( self.angles );
    
    for ( var5 = 0; var5 < var2 ; var5++ )
    {
        var6 = var3 * var5;
        var7 = var3 * ( var5 + 1 );
        var8 = randomfloatrange( var6, var7 );
        var9 = self.ref_11980.¬’ûbóQÃ`­?£³ * var0;
        var10 = self.ref_11980.¬’ûbóQÃ`­?£³ * var1;
        var11 = randomfloatrange( var9, var10 );
        var12 = vectornormalize( rotatevector( var4, ( 0, var8, 0 ) ) );
        var13 = self.ref_11980.minecart_run + var12 * var11;
        var13 = getclosestpointonnavmesh( var13 );
        var14 = getgroundposition( var13, 32, 2000, 1500 );
        var15 = 0;
        
        while ( distancesquared( var14, var13 ) > 1024 && var15 < 5 )
        {
            var15++;
            var8 = randomfloatrange( var6, var7 );
            var12 = vectornormalize( rotatevector( var4, ( 0, var8, 0 ) ) );
            var11 = randomfloatrange( var9, var10 );
            var13 = self.ref_11980.minecart_run + var12 * var11;
            var13 = getclosestpointonnavmesh( var13 );
            var14 = getgroundposition( var13, 32, 2000, 1500 );
        }
        
        var16 = spawn_guard_agent( var14, self.ref_11980, ( 0, 0, 180 ), 1, "actor_enemy_lw_br", "team_twenty" );
        thread agent_mini_map_pings();
        thread agent_watch_death( var16 );
        
        if ( var5 < self.ref_11980.ªàK<Øø’'«£ú>.size )
        {
            var16.ƒóóG@NxŸrà!w = self.ref_11980.ªàK<Øø’'«£ú>[ var5 ];
        }
        
        self.ref_11980.new_rider_combat_logic = scripts\engine\utility::array_add( self.ref_11980.new_rider_combat_logic, var16 );
        waitframe();
    }
}

// Params 0
// Size: 0x44
function agent_mini_map_pings()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    self endon( "death" );
    var0 = 0.5;
    var1 = 15;
    
    for ( ;; )
    {
        self setperk( "specialty_radarblip", 1 );
        wait var0;
        self unsetperk( "specialty_radarblip", 1 );
        wait var1;
    }
}

// Params 1
// Size: 0x11e
function agent_watch_death( var0 )
{
    self endon( "game_ended" );
    self waittill( "death", var1 );
    var0.new_rider_combat_logic = scripts\engine\utility::array_remove( var0.new_rider_combat_logic, self );
    
    if ( isplayer( var1 ) )
    {
        var1 thread scripts\mp\rank::giverankxp( "kill", level.ref_12e2b.Š ;VÍ£¯µK6VõÁ, var1 getcurrentweapon() );
        var1 thread scripts\mp\rank::scoreeventpopup( "kill" );
    }
    
    var2 = [];
    
    if ( randomint( 2 ) == 1 )
    {
        GscBinSkip0( 0x2e, var2.size, "brloot_plunder_cash_common_1" );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    switch ( randomint( 3 ) )
    {
        case 0:
            GscBinSkip0( 0x2e, var2.size, "brloot_armor_plate" );
            // Unknown operator ( 0x2e, iw8, PC )
        case 1:
            var3 = randomintrange( 0, level.ref_12e2b.¯A§5õH°‡mP8§_.size );
            var2 = level.ref_12e2b.¯A§5õH°‡mP8§_[ var3 ];
            break;
    }
    
    var4 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    
    foreach ( var6 in var2 )
    {
        var7 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var4, self.origin + ( 0, 0, 2 ), self.angles, self );
        var8 = scripts\mp\gametypes\br_pickups::spawnpickup( var6, var7, 1, 1 );
    }
}

// Params 0
// Size: 0x35
function giverandomloadoutindex()
{
    self endon( "death" );
    self endon( "leaving" );
    wait level.ref_12e2b.spawnregions;
    play_vo_near_location( "interception_chopper_return", self.origin, 1000 );
    thread givequestreward();
}

// Params 5
// Size: 0x220
function chopper_bag_used( var0, var1, var2, var3, var4 )
{
    var0 endon( "death" );
    var0 endon( "leaving" );
    var0.entity.ref_11980.heli endon( "leaving" );
    var5 = level.ref_12e2b.²* —#—V}1'Ë—'» + level.ref_12e2b.sg_ontimerexpired;
    var6 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var7 = ref_13c2d( var0.entity, var0.origin, 100, [ var0.entity ] );
    var8 = var7[ 2 ] + 2;
    var0.entity.ref_11980.ref_13b91++;
    
    if ( var0.entity.ref_11980.ref_13b91 >= var5 )
    {
        var0 setscriptablepartstate( "scriptable_interception_bag", "unusable" );
        
        if ( level.ref_12e2b.sg_ontimerexpired )
        {
            level thread _handlevehiclerepair::ref_13673( "interception_final_pinata", ( var0.origin[ 0 ], var0.origin[ 1 ], var8 ), randomint( 3 ) + 2, 0 );
            var3 thread scripts\mp\rank::giverankxp( "br_cacheOpen", level.ref_12e2b.•¡ÿ³Öê7c°Séo£/·Ko=tâ );
            var3 thread scripts\mp\rank::scoreeventpopup( "br_cacheOpen" );
        }
        else
        {
            chopper_gunner_assigntargetmarkers( var0.entity, var6, var8, 1, 1 );
            var3 thread scripts\mp\rank::giverankxp( "br_cacheOpen", level.ref_12e2b.šè0¯[(ŸÚÍ¸=§²WÒ ¿(Èìà );
            var3 thread scripts\mp\rank::scoreeventpopup( "br_cacheOpen" );
        }
        
        play_vo_near_location( "interception_empty_bag", var0.origin, 800 );
        thread givequestreward();
        return;
    }
    
    chopper_gunner_assigntargetmarkers( var0.entity, var6, var8, 1, 1 );
    var3 thread scripts\mp\rank::giverankxp( "br_cacheOpen", level.ref_12e2b.šè0¯[(ŸÚÍ¸=§²WÒ ¿(Èìà );
    var3 thread scripts\mp\rank::scoreeventpopup( "br_cacheOpen" );
    
    if ( var0.entity.ref_11980.ref_13b91 == 2 )
    {
        chopper_start_agent_spawn( var0.entity.ref_11980.heli, 0.75, 1 );
        play_vo_near_location( "interception_agent_respawn", var0.origin, 800 );
        return;
    }
    
    if ( scripts\engine\utility::cointoss() )
    {
        play_vo_near_location( "interception_loot_bag", var0.origin, 800 );
        return;
    }
}

// Params 0
// Size: 0x1e
function givespecialistbonusifneeded()
{
    self endon( "death" );
    self endon( "leaving" );
    level waittill( "game_ended" );
    thread givequestreward();
}

// Params 0
// Size: 0xe0
function givequestreward()
{
    self endon( "death" );
    self notify( "leaving" );
    self.leaving = 1;
    
    foreach ( var1 in level.players )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_pe_interception_end" );
    }
    
    self sethoverparams( 25, 20, 10 );
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    thread scripts\common\anim::anim_single_solo( self.rope, "rope_out", "origin_animate_jnt" );
    thread scripts\common\anim::anim_single_solo( self.crate, "bag_out", "origin_animate_jnt" );
    self waittill( "goal" );
    self vehicle_setspeed( self.speed, self.accel );
    self setvehgoalpos( self.ref_121ff, 1 );
    self settargetyaw( self.select_mountain_two_spawners );
    self waittill( "goal" );
    self stoploopsound();
    self notify( "heli_gone" );
    giveachievementsmoke();
    giveawardfake();
}

// Params 13
// Size: 0x1be
function callback_vehicledamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var1 = var1.owner;
        }
    }
    
    if ( var1 == self )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    if ( !self.§¤êœœ¬Í£ØËc,/K¹³ì{ )
    {
        if ( !self.•J6,^YM¡Ê…cGĞ&,NÚ && self.health < self.maxhealth * 0.25 )
        {
            self.•J6,^YM¡Ê…cGĞ&,NÚ = 1;
            self.×¼VFÔ+°Ñ4‰“Ú = 1;
            self.‚_Ò—³ 7“!†°ıŠ±ÃÊ = 1;
            play_vo_near_location( "interception_chopper_health_25", self.origin, 1000 );
            thread vo_bark_lockout( lookupsoundlength( "interception_chopper_health_25", 1 ) / 1000 );
        }
        else if ( !self.×¼VFÔ+°Ñ4‰“Ú && self.health < self.maxhealth * 0.5 )
        {
            self.×¼VFÔ+°Ñ4‰“Ú = 1;
            self.‚_Ò—³ 7“!†°ıŠ±ÃÊ = 1;
            play_vo_near_location( "interception_chopper_health_50", self.origin, 1000 );
            thread vo_bark_lockout( lookupsoundlength( "interception_chopper_health_50", 1 ) / 1000 );
        }
        else if ( !self.‚_Ò—³ 7“!†°ıŠ±ÃÊ && self.health < self.maxhealth * 0.75 )
        {
            self.‚_Ò—³ 7“!†°ıŠ±ÃÊ = 1;
            play_vo_near_location( "interception_chopper_health_75", self.origin, 1000 );
            thread vo_bark_lockout( lookupsoundlength( "interception_chopper_health_75", 1 ) / 1000 );
        }
    }
    
    var2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage( var1, var5, var4, var2, self.maxhealth, 3, 4, 5 );
    scripts\mp\killstreaks\killstreaks::killstreakhit( var1, var5, self, var4, var2 );
    var1 scripts\mp\damagefeedback::updatedamagefeedback( "" );
    
    if ( self.health - var2 <= 900 && ( !isdefined( self.smoking ) || !self.smoking ) )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
}

// Params 1
// Size: 0x21
function vo_bark_lockout( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    self.§¤êœœ¬Í£ØËc,/K¹³ì{ = 1;
    wait var0;
    self.§¤êœœ¬Í£ØËc,/K¹³ì{ = 0;
}

// Params 5
// Size: 0x1db
function chopper_gunner_assigntargetmarkers( var0, var1, var2, var3, var4 )
{
    var5 = [];
    
    if ( var3 )
    {
        var6 = randomintrange( 1, 3 );
        
        for ( var7 = 0; var7 < var6 ; var7++ )
        {
            var5 = "brloot_armor_plate";
        }
    }
    
    if ( var4 )
    {
        var8 = randomintrange( 1, 3 );
        
        for ( var7 = 0; var7 < var8 ; var7++ )
        {
            var9 = randomintrange( 0, level.ref_12e2b.¯A§5õH°‡mP8§_.size );
            var5 = level.ref_12e2b.¯A§5õH°‡mP8§_[ var9 ];
        }
    }
    
    for ( var7 = 0; var7 < level.ref_12e2b.ªÆØ¹ĞõZÜ•7.size ; var7++ )
    {
        var10 = randomintrange( level.ref_12e2b.’¾°JE_‰oƒÃPz‡óëªÈ[ var7 ], level.ref_12e2b.™ÚmÃÀÑ‡¿{šÑc…ŸÈ¡[ var7 ] + 1 );
        
        for ( var11 = 0; var11 < var10 ; var11++ )
        {
            var5 = level.ref_12e2b.ªÆØ¹ĞõZÜ•7[ var7 ];
        }
    }
    
    var5 = scripts\engine\utility::array_randomize( var5 );
    
    foreach ( var13 in var5 )
    {
        var14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var1, ( var0.origin[ 0 ], var0.origin[ 1 ], var2 ), var0.angles, var0 );
        var15 = "";
        
        switch ( var13 )
        {
            case "cashlootsm":
                var15 = "brloot_plunder_cash_common_1";
                break;
            case "cashlootmd":
                var15 = scripts\engine\utility::random( level.ref_12e2b.ref_11bab );
                break;
            case "cashlootlrg":
                var15 = scripts\engine\utility::random( level.ref_12e2b.waitteardowninfilmapomnvars );
                break;
            case "cashlootepic":
                var15 = scripts\engine\utility::random( level.ref_12e2b.ref_14292 );
                break;
            case "cashlootlegend":
                var15 = "brloot_plunder_cash_legendary_1";
                break;
            default:
                var15 = var13;
                break;
        }
        
        var16 = scripts\mp\gametypes\br_pickups::spawnpickup( var15, var14, 1, 1 );
    }
}

// Params 0
// Size: 0x5a
function showquestcircletoplayer()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "swapped" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
    }
}

// Params 0
// Size: 0xd5
function givebrbonusxp()
{
    self endon( "heli_gone" );
    self endon( "swapped" );
    var0 = self.owner;
    var1 = self.team;
    self waittill( "death", var2, var3, var4, var5 );
    play_vo_near_location( "interception_chopper_crash", self.origin, 1000 );
    var6 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    chopper_gunner_assigntargetmarkers( self, var6, self.origin[ 2 ], 0, 0 );
    
    foreach ( var8 in level.players )
    {
        var8 thread scripts\mp\hud_message::showsplash( "br_pe_interception_destroyed" );
    }
    
    giveachievementsmoke();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) && !istrue( self.isdepot ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread giveammo( 75 );
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    givelaststandifneeded( var2 );
}

// Params 0
// Size: 0xb9
function handledestroydamage()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "swapped" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        var9 = scripts\mp\utility\weapon::mapweapon( var9, var13 );
        
        if ( ( var9.basename == "aamissile_projectile_mp" || var9.basename == "nuke_mp" ) && var4 == "MOD_EXPLOSIVE" && var0 >= self.health )
        {
            callback_vehicledamage( var1, var1, 9001, 0, var4, var9, var3, var2, var3, 0, 0, var7 );
            giveachievementwildfire();
        }
    }
}

// Params 1
// Size: 0xfd
function ref_13693( var0 )
{
    var1 = spawn( "script_model", ( 0, 0, 0 ) );
    var1 setmodel( "misc_rapelling_rope_01_fiber_br" );
    var1 linkto( var0, "origin_animate_jnt", ( 11, 20, 42 ), ( 0, 180, 0 ) );
    var1.animname = "plunder_extract_heli";
    var1 scripts\common\anim::setanimtree();
    var0 scripts\common\anim::anim_first_frame_solo( var1, "rope_in", "origin_animate_jnt" );
    var2 = spawn( "script_model", ( 0, 0, 0 ) );
    var2 setmodel( "br_mercenary_extraction_delivery_bag" );
    var2 linkto( var0, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var2.animname = "plunder_extract_heli";
    var2 scripts\common\anim::setanimtree();
    var0 scripts\common\anim::anim_first_frame_solo( var2, "bag_in", "origin_animate_jnt" );
    var0.rope = var1;
    var0.crate = var2;
    var2.ref_11980 = var0.ref_11980;
}

// Params 0
// Size: 0x49
function giveachievementsmoke()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate delete();
    }
    
    if ( isdefined( self.ref_11980.½ÇX6×«ëø × ) )
    {
        self.ref_11980.½ÇX6×«ëø × delete();
    }
    
    giveachievementwildfire();
}

// Params 1
// Size: 0x86
function givelaststandifneeded( var0 )
{
    var1 = self gettagorigin( "tag_origin" ) + ( 0, 0, 40 );
    playfx( scripts\engine\utility::getfx( "little_bird_explode" ), var1, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( var1, "veh_chopper_support_crash" );
    earthquake( 0.4, 800, var1, 0.7 );
    playrumbleonposition( "grenade_rumble", var1 );
    physicsexplosionsphere( var1, 500, 200, 1 );
    self notify( "explode" );
    wait 0.35;
    giveachievementwildfire();
    giveawardfake();
}

// Params 0
// Size: 0x9
function giveawardfake()
{
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( self );
}

// Params 1
// Size: 0x55
function giveammo( var0 )
{
    self endon( "explode" );
    self notify( "heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( var0, var0, var0 );
    self settargetyaw( self.angles[ 1 ] + var0 * 2.5 );
}

// Params 0
// Size: 0x30
function giveachievementwildfire()
{
    if ( isdefined( self.vfxent ) )
    {
        self.vfxent stoploopsound();
        self.vfxent delete();
    }
    
    if ( isdefined( self.mæµŞ[ÊÎ™á•¹è ) )
    {
        self.mæµŞ[ÊÎ™á•¹è delete();
        return;
    }
}

// Params 2
// Size: 0x2d
function givequestsplash( var0, var1 )
{
    var2 = 715;
    var3 = ref_13c2d( var0, 100, [ self ] );
    var4 = var3[ 2 ];
    var5 = var4 + var2;
    var1.§ Ÿ€£»5æR;ÈGZ(³ô = var3;
    return var5;
}

// Params 3
// Size: 0x53
function ref_13c2d( var0, var1, var2 )
{
    var3 = -99999;
    var4 = ( var0[ 0 ], var0[ 1 ], var3 );
    var5 = scripts\engine\trace::create_world_contents();
    var6 = undefined;
    
    if ( isdefined( var1 ) )
    {
        var6 = scripts\engine\trace::sphere_trace( var0, var4, var1, var2, var5 );
    }
    else
    {
        var6 = scripts\engine\trace::ray_trace( var0, var4, var2, var5 );
    }
    
    if ( isdefined( var6 ) )
    {
        return var6[ "position" ];
    }
    
    return undefined;
}

// Params 0
// Size: 0x2
function ____ai_helpers()
{
    
}

// Params 6
// Size: 0xd6
function spawn_guard_agent( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = "actor_enemy_lw_br";
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = 0;
    }
    
    if ( !isdefined( var5 ) )
    {
        var5 = "team_two_hundred";
    }
    
    var6 = spawnstruct();
    var6.„ù¸?¯ã+Ã†fû›û{NëKpĞã-{ = 1;
    var7 = _testing_ending::spawnnewparachuteagent( var0, var2, 1, var4, var5 );
    
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var7.guid = var7 getguid();
    var7 setgoalvolumeauto( var1.½ÇX6×«ëø × );
    var7.move_closest_chopper_boss_vandalize_node_down = 1;
    var7 _testing_ending::ammobox_getbufferedattachmentsourceweapon();
    var7 thread _testing_ending::alwaysdoskyspawnontacinsert();
    var7 thread _testing_ending::activeparachutersfactionvo();
    var7 thread _testing_ending::activestate();
    
    if ( var3 )
    {
        var7 _testing_ending::scriptable_token_scriptable_touched_callback( 250 );
    }
    
    var7.maxsightdistsqrd = 9000000;
    level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_add( level.deposit_from_compromised_convoy_delayed.ref_1363d, var7 );
    return var7;
}

// Params 0
// Size: 0x2
function activate_destructible_cinderblock()
{
    
}

