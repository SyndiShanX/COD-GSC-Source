
// Params 0
// Size: 0xe7
function main()
{
    level endon( "game_ended" );
    
    if ( getdvarint( "scr_br_zombie_encounters", 0 ) < 1 )
    {
        ref_146fd( "Zombie Spawning Disabled" );
        return;
    }
    
    scripts\mp\mp_agent::init_agent( "mp/iw8_default_agent_definition.csv" );
    scripts\engine\scriptable::ref_12f5b( "button", &ref_146ae );
    initzombievariables();
    level.disable_oob_immunity_on_riders = 1;
    level.playerexitlaststand = &ref_146f7;
    level.playerclearjailtimeouthud = &ref_146bb;
    level.ref_146b8 = getdvar( "scr_br_zombie_encounter_zone", "br_zombies_zone1" );
    level.ref_146e9 = getdvarint( "scr_br_zombie_encounter_no_target_go_to_spawn", 1 );
    level.ref_146ca = getdvarint( "scr_br_zombie_max_num_in_a_round", 40 );
    level.ref_146ad = undefined;
    scripts\mp\gametypes\br_alt_mode_zai::ref_14708();
    level.deployed = getdvarfloat( "scr_br_zombie_spawning_wait_time", 1.5 );
    level.deploy_subway_car_at_station = getdvarint( "scr_default_maxagents", 10 );
    ref_146fd( "Zombie Spawning Enabled for " + level.ref_146b8 );
    
    while ( !scripts\mp\flags::playerzombiethermalcleanup( "prematch_done" ) )
    {
        wait 1;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
}

// Params 0
// Size: 0x2cf
function initzombievariables()
{
    level.ref_14687 = spawnstruct();
    level.ref_14687.ref_146da = getdvarint( "scr_br_zombie_plunder_on_death_amount_base", 1 );
    level.ref_14687.ref_146db = getdvarint( "scr_br_zombie_plunder_on_death_amount_emp", 2 );
    level.ref_14687.ref_146dc = getdvarint( "scr_br_zombie_plunder_on_death_amount_explosion", 2 );
    level.ref_14687.ref_146dd = getdvarint( "scr_br_zombie_plunder_on_death_amount_gas", 2 );
    level.ref_14687.ref_146de = getdvarint( "scr_br_zombie_plunder_on_death_amount_weakpoint", 3 );
    level.ref_14687.ref_146d8 = getdvarint( "scr_br_zombie_plunder_multiplier", 50 );
    level.ref_14687.onuseitem = getdvarfloat( "scr_br_zombie_explosion_damage", 35 );
    level.ref_14687.onusethanksbc = getdvarfloat( "scr_br_zombie_explosion_damage_vehicle_percent", 0.95 );
    level.ref_14687.mortar_cooldown = getdvarfloat( "scr_br_zombie_emp_radius", 275 );
    level.ref_14687.packs = 1;
    level.ref_14687.ref_146b7 = getdvarint( "scr_br_zombie_enable_variable_speed", 1 );
    level.ref_14687.ref_146b6 = getdvarint( "scr_br_zombie_enable_variable_health", 1 );
    level.ref_14687.ref_146b5 = getdvarint( "scr_br_zombie_enable_variable_damage", 1 );
    level.ref_14687.ref_11a55 = getdvarint( "scr_br_zombie_ai_damage_low", 15 );
    level.ref_14687.ref_11bdc = getdvarint( "scr_br_zombie_ai_damage_mid", 20 );
    level.ref_14687.spawn_entity_carriable = getdvarint( "scr_br_zombie_ai_damage_high", 35 );
    level.ref_14687.ref_146a5 = getdvarfloat( "scr_br_zombie_ammo_on_death_chance", 0.4 );
    level.ref_14687.ref_146a7 = getdvarfloat( "scr_br_zombie_armor_on_death_chance", 0.25 );
    level.ref_14687.ref_146a6 = getdvarint( "scr_br_zombie_ai_armor_drop_amount", 1 );
    level.ref_14687.open_close_initial = getdvarfloat( "scr_br_zombie_ai_explosive_mod_damage_modifier", 5 );
    level.ref_14687.ref_146c7 = 0;
    level.ref_146a0 = "gas_on_death";
    level.ref_1469f = "explosion_on_death";
    level.ref_1469e = "emp";
    level.ref_146a2 = "weakpoint";
    level.‘Jé·kK•}:ò+ú“Xs²N = "ranger";
    level.ref_1469d = "base";
    level._effect[ "zmb_ai_crawling_out_of_ground" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_ground.vfx" );
    level._effect[ "zmb_ai_crawling_out_of_vent" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_vent.vfx" );
    level._effect[ "zmb_ai_base_death" ] = loadfx( "vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx" );
    level._effect[ "zmb_ai_gas_death" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_gas_death.vfx" );
    level._effect[ "zmb_ai_explosion_death" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx" );
    level._effect[ "zmb_ai_emp_charge" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse_chargeup.vfx" );
    level._effect[ "zmb_ai_emp_pulse" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse.vfx" );
    level._effect[ "zmb_ai_emp_death" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_death.vfx" );
    level._effect[ "zmb_ai_weakpoint_death" ] = loadfx( "vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx" );
    scripts\mp\utility\sound::besttime( "br_zmb_sfx" );
}

// Params 0
// Size: 0x4e
function ref_146b0()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "terminate_ai_threads" );
    var0 hide();
    wait 0.2;
    var0 show();
    wait 2;
    
    if ( getdvarint( "scr_br_zombie_encounters", 0 ) >= 1 && isdefined( level.ref_14687 ) )
    {
        var0 thread scripts\mp\gametypes\br_alt_mode_zai::ref_146d4();
        return;
    }
}

// Params 0
// Size: 0x4, Type: bool
function ref_146f7()
{
    return false;
}

// Params 0
// Size: 0xe, Type: bool
function ref_146fe()
{
    return getdvarint( "scr_br_zombie_log", 0 ) > 0;
}

// Params 5
// Size: 0x2a6
function ref_146fa( var0, var1, var2, var3, var4 )
{
    if ( !scripts\engine\utility::string_starts_with( var0, "actor_" ) )
    {
        var0 = "actor_" + var0;
    }
    
    if ( !isdefined( level.agent_definition[ var0 ] ) )
    {
        return undefined;
    }
    
    if ( !isdefined( var3 ) || !isdefined( var3.script_animation ) )
    {
        var3 = spawnstruct();
        var3.script_animation = "spawn_ground";
        var3.targetname = "spawnStruct";
        var3.origin = var1;
    }
    
    if ( isdefined( var3 ) && isdefined( var3.targetname ) )
    {
        ref_146fd( "Zombie will spawn At " + var3.targetname );
    }
    
    var5 = scripts\mp\mp_agent::spawnnewagent( var0, "team_two_hundred", var1, var2, undefined, var3 );
    
    if ( isdefined( var5 ) )
    {
        ref_146fd( "Spawned zombie : " + var0 );
        thread ref_146b0();
        
        if ( isdefined( var4 ) )
        {
            var5.ref_14704 = var4;
            
            switch ( var4 )
            {
                case "base":
                    var5 setscriptablepartstate( "ai_glow", "base_loop" );
                    playsoundatpos( var5.origin, "zmb_spawn_type_default" );
                    break;
                case "ranger":
                case "gas_on_death":
                    var5 setscriptablepartstate( "ai_glow", "gas_loop" );
                    playsoundatpos( var5.origin, "zmb_spawn_type_gas" );
                    break;
                case "explosion_on_death":
                    var5 setscriptablepartstate( "ai_glow", "exp_loop" );
                    playsoundatpos( var5.origin, "zmb_spawn_type_exp" );
                    break;
                case "emp":
                    var5 setscriptablepartstate( "ai_glow", "emp_loop" );
                    playsoundatpos( var5.origin, "zmb_spawn_type_emp" );
                    break;
                case "weakpoint":
                    var5 setscriptablepartstate( "ai_glow", "weak_loop" );
                    thread carriablemagicgrenades( var5, "c_t9_zmb_ndu_zombie_honorguard_helmet_barbed" );
                    playsoundatpos( var5.origin, "zmb_spawn_type_armor" );
                    break;
                default:
                    var5 setscriptablepartstate( "ai_glow", "base_loop" );
                    break;
            }
        }
        
        if ( !isdefined( var3.ref_146ea ) )
        {
            var3.ref_146ea = getclosestpointonnavmesh( var3.origin );
        }
        
        switch ( var3.script_animation )
        {
            case "spawn_ground":
                if ( isdefined( level._effect[ "zmb_ai_crawling_out_of_ground" ] ) )
                {
                    playfx( scripts\engine\utility::getfx( "zmb_ai_crawling_out_of_ground" ), var5.origin );
                }
                
                break;
            case "spawn_wall_low":
                if ( isdefined( level._effect[ "zmb_ai_crawling_out_of_vent" ] ) )
                {
                    playfx( level._effect[ "zmb_ai_crawling_out_of_vent" ], var5.origin );
                }
                
                break;
            default:
                if ( isdefined( level._effect[ "zmb_ai_crawling_out_of_ground" ] ) )
                {
                    playfx( scripts\engine\utility::getfx( "zmb_ai_crawling_out_of_ground" ), var5.origin );
                }
                
                break;
        }
    }
    else
    {
        ref_146fd( "Spawn Failed " + var0 );
    }
    
    return var5;
}

// Params 3
// Size: 0x56
function carriablemagicgrenades( var0, var1, var2 )
{
    level endon( "zai_round_over" );
    level endon( "game_ended" );
    self endon( "terminate_ai_threads" );
    
    if ( !istrue( var2 ) )
    {
        wait 0.25;
    }
    
    self attach( var0, var1 );
    self.hashelmet = 1;
    self.•$æÛSxƒ b‚÷Û¯»ŸD = spawnstruct();
    self.•$æÛSxƒ b‚÷Û¯»ŸD.model = var0;
    self.•$æÛSxƒ b‚÷Û¯»ŸD.tag = var1;
}

// Params 2
// Size: 0x2c
function detachhelmetfromzombie( var0, var1 )
{
    self detach( self.•$æÛSxƒ b‚÷Û¯»ŸD.model, self.•$æÛSxƒ b‚÷Û¯»ŸD.tag );
    self.hashelmet = 0;
    self.•$æÛSxƒ b‚÷Û¯»ŸD = undefined;
}

// Params 1
// Size: 0xe, Type: bool
function ref_1470e( var0 )
{
    return !accesscard::ref_13303( var0, 1 );
}

// Params 1
// Size: 0x2b2
function ref_146a4( var0 )
{
    level endon( "game_ended" );
    var1 = ref_14711( getentarray( var0.target, "targetname" ) );
    
    for ( ;; )
    {
        level.ref_146d7 = 0;
        
        foreach ( var3 in level.players )
        {
            var3.trial_targs = 0;
        }
        
        foreach ( var6 in var1 )
        {
            var6.isactive = 0;
            var6.ref_1252f = 0;
        }
        
        var8 = [];
        
        foreach ( var3 in level.players )
        {
            if ( ref_1470e( var3 ) )
            {
                var8 = var3;
            }
        }
        
        foreach ( var6 in var1 )
        {
            foreach ( var3 in var8 )
            {
                if ( var3 istouching( var6 ) )
                {
                    if ( !istrue( var3.trial_targs ) )
                    {
                        var3.trial_targs = 1;
                        level.ref_146d7 += 1;
                    }
                    
                    var6.isactive = 1;
                    var6.ref_1252f += 1;
                }
            }
        }
        
        level.ref_146a3 = [];
        
        foreach ( var6 in var1 )
        {
            if ( var6.isactive )
            {
                level.ref_146a3[ level.ref_146a3.size ] = var6;
                
                foreach ( var17 in level.vehicle.instances )
                {
                    foreach ( var19 in var17 )
                    {
                        if ( var19 istouching( var6 ) )
                        {
                            thread ref_14701();
                        }
                    }
                }
                
                foreach ( var23 in level.mines )
                {
                    if ( isdefined( var23 ) && isdefined( var23.equipmentref ) && var23.equipmentref == "equip_tac_cover" )
                    {
                        if ( var23 istouching( var6 ) )
                        {
                            thread ref_14701();
                        }
                    }
                }
            }
        }
        
        foreach ( var3 in level.players )
        {
        }
        
        var28 = ref_14710();
        wait var28;
    }
}

// Params 0
// Size: 0x23
function ref_14701()
{
    var0 = createnavobstaclebyent( self, "team_two_hundred" );
    wait ref_14710() - 0.05;
    
    if ( isdefined( var0 ) )
    {
        destroynavobstacle( var0 );
        return;
    }
}

// Params 0
// Size: 0x10
function ref_14710()
{
    return getdvarfloat( "scr_br_zombie_volume_wait_time", 1 );
}

// Params 0
// Size: 0x2a
function ref_146ac()
{
    level endon( "game_ended" );
    level endon( "zai_round_over" );
    
    for ( ;; )
    {
        if ( vehicle_collision_init( level.ref_146ad ) )
        {
            thread scripts\mp\gametypes\br_alt_mode_zai::ref_146ee();
            return;
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0x96
function ref_14711( var0 )
{
    foreach ( var2 in var0 )
    {
        var2.ref_14723 = [];
        
        if ( !isdefined( var2.script_linkname ) )
        {
            continue;
        }
        
        if ( !isdefined( var2.script_linkto ) )
        {
            continue;
        }
        
        var3 = var2 scripts\engine\utility::get_linked_ents();
        
        if ( var3.size > 0 )
        {
            foreach ( var5 in var3 )
            {
                var2.ref_14723[ var2.ref_14723.size ] = var5;
            }
        }
    }
    
    return var0;
}

// Params 1
// Size: 0x432
function ref_146ff( var0 )
{
    level endon( "game_ended" );
    level endon( "zai_round_over" );
    var1 = getdvarint( "scr_br_zombie_respawn_time", 5 );
    ref_146fd( "Zombie Spawning Zone '" + var0.target + "', Goal of " + level.deploy_subway_cars_on_track + " active" );
    level.ref_146ef = [];
    level.ref_146ad = var0;
    level.ref_146d7 = 0;
    level.ref_146a3 = [];
    var2 = getentarray( var0.target, "targetname" );
    
    if ( var2.size == 0 )
    {
        ref_146fd( "Zombie Spawning Zone '" + var0.target + "' has no volumes" );
        return;
    }
    
    if ( isdefined( level.teamnamelist ) && !scripts\engine\utility::array_contains( level.teamnamelist, "team_two_hundred" ) )
    {
        level.teamnamelist = scripts\engine\utility::array_add( level.teamnamelist, "team_two_hundred" );
    }
    
    thread ref_146a4( level );
    thread ref_146ac();
    level thread scripts\mp\gametypes\br_alt_mode_zai::ref_146ba();
    ref_14707();
    var3 = scripts\mp\utility\player::getplayersinradius( var0.origin, 6000 );
    
    foreach ( var5 in var3 )
    {
        var5.unsetbettermissionrewards = 1;
    }
    
    if ( level.ref_14687.packs == 1 )
    {
        foreach ( var5 in var3 )
        {
            var5 scripts\mp\hud_message::showsplash( "br_zai_begin" );
        }
    }
    else if ( level.ref_14687.packs == 2 )
    {
        foreach ( var5 in var3 )
        {
            var5 scripts\mp\hud_message::showsplash( "br_zai_begin_multiple" );
        }
    }
    
    level thread scripts\mp\gametypes\br_alt_mode_zai::ref_12666( var0.origin );
    
    for ( ;; )
    {
        if ( level.ref_146d7 > 0 )
        {
            var11 = [];
            
            foreach ( var13 in level.ref_146ef )
            {
                if ( isalive( var13 ) )
                {
                    var11 = var13;
                    continue;
                }
                
                if ( isdefined( var13 ) )
                {
                    var13 notify( "terminate_ai_threads" );
                }
            }
            
            level.ref_146ef = var11;
            
            if ( get_checking_area_alias() )
            {
                var15 = [];
                var16 = getdvarint( "scr_br_zombie_force_ground", 0 );
                var17 = getdvarint( "scr_br_zombie_force_vent", 0 );
                var18 = [];
                
                foreach ( var20 in level.ref_146a3 )
                {
                    var18 = var20;
                    var18 = scripts\engine\utility::array_combine( var18, var20.ref_14723 );
                }
                
                var18 = scripts\engine\utility::array_remove_duplicates( var18 );
                
                foreach ( var20 in var18 )
                {
                    var23 = scripts\engine\utility::getstructarray( var20.target, "targetname" );
                    
                    foreach ( var25 in var23 )
                    {
                        if ( !istrue( var25.disabled ) )
                        {
                            if ( var16 )
                            {
                                if ( isdefined( var25.script_animation ) && var25.script_animation == "spawn_ground" )
                                {
                                    var15 = var25;
                                }
                                
                                continue;
                            }
                            
                            if ( var17 )
                            {
                                if ( isdefined( var25.script_animation ) && var25.script_animation == "spawn_wall_low" )
                                {
                                    var15 = var25;
                                }
                                
                                continue;
                            }
                            
                            var15 = var25;
                        }
                    }
                }
                
                var15 = scripts\engine\utility::array_randomize( var15 );
                
                for ( var28 = 0; var28 < var15.size && get_checking_area_alias() ; var28++ )
                {
                    var25 = var15[ var28 ];
                    var29 = level.ref_14709[ level.ref_146f0 ];
                    var13 = ref_146fa( "enemy_lw_base_zombie", var25.origin, var25.angles, var25, var29 );
                    level.ref_146ef[ level.ref_146ef.size ] = var13;
                    
                    if ( var29 == level.ref_146a0 )
                    {
                        level.deploy_suicide_truck_in_lumber_yard--;
                    }
                    else if ( var29 == level.ref_1469f )
                    {
                        level.deploy_suicide_truck_in_farm--;
                    }
                    else if ( var29 == level.ref_1469e )
                    {
                        level.deploy_suicide_truck_in_blockade--;
                        var13 thread scripts\mp\gametypes\br_alt_mode_zai::ref_146b3();
                    }
                    else if ( var29 == level.ref_146a2 )
                    {
                        level.deployable_cover_cancel--;
                    }
                    else if ( var29 == level.ref_1469d )
                    {
                        level.deploy_subway_cars_on_track--;
                    }
                    
                    var13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f5( var29 );
                    var13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f3( var29 );
                    var13 scripts\mp\gametypes\br_alt_mode_zai::ref_146f4( var29 );
                    level.ref_146f0++;
                    wait level.deployed;
                }
            LOC_00000428:
            }
        }
        
        wait var1;
    }
}

// Params 0
// Size: 0x3db
function ref_14707()
{
    level.ref_14709 = [];
    level.ref_14687.packs = 1;
    var0 = [];
    var1 = 0;
    var2 = 0;
    
    if ( level.ref_14687.ref_145a8 > 0 )
    {
        switch ( level.ref_14687.ref_145a8 )
        {
            case 2:
                if ( level.deploy_suicide_truck_in_lumber_yard < 0 )
                {
                    level.deploy_suicide_truck_in_lumber_yard = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.05 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 3 );
                break;
            case 3:
                if ( level.deploy_suicide_truck_in_farm < 0 )
                {
                    level.deploy_suicide_truck_in_farm = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.1 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 3 );
                break;
            case 4:
                if ( level.deploy_suicide_truck_in_blockade < 0 )
                {
                    level.deploy_suicide_truck_in_blockade = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.1 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 5 );
                break;
            case 5:
                if ( level.deploy_suicide_truck_in_lumber_yard < 0 )
                {
                    level.deploy_suicide_truck_in_lumber_yard = 6;
                }
                
                if ( level.deploy_suicide_truck_in_farm < 0 )
                {
                    level.deploy_suicide_truck_in_farm = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.2 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 5 );
                break;
            case 6:
                if ( level.deploy_suicide_truck_in_lumber_yard < 0 )
                {
                    level.deploy_suicide_truck_in_lumber_yard = 6;
                }
                
                if ( level.deploy_suicide_truck_in_blockade < 0 )
                {
                    level.deploy_suicide_truck_in_blockade = 6;
                }
                
                var0 = [ level.ref_146a2 ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.2 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 5 );
                break;
            case 7:
                if ( level.deploy_suicide_truck_in_lumber_yard < 0 )
                {
                    level.deploy_suicide_truck_in_lumber_yard = 6;
                }
                
                if ( level.deployable_cover_cancel < 0 )
                {
                    level.deployable_cover_cancel = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e, level.ref_146a2, level.ref_1469d ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.3 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 5 );
                break;
            case 8:
                if ( level.deploy_suicide_truck_in_farm < 0 )
                {
                    level.deploy_suicide_truck_in_farm = 6;
                }
                
                if ( level.deployable_cover_cancel < 0 )
                {
                    level.deployable_cover_cancel = 6;
                }
                
                var0 = [ level.ref_146a0, level.ref_1469f, level.ref_1469e, level.ref_146a2, level.ref_1469d ];
                var1 = getdvarfloat( "scr_br_zombie_ai_extra_zombie_spawn_chance", 0.3 );
                var2 = getdvarint( "scr_br_zombie_ai_extra_zombie_spawn_quantity", 5 );
                break;
            default:
                break;
        }
        
        if ( var0.size > 0 )
        {
            if ( randomfloat( 1 ) < var1 )
            {
                level.ref_14687.packs = 2;
                var3 = randomint( var0.size );
                
                for ( var4 = 0; var4 < var2 ; var4++ )
                {
                    level.ref_14709[ level.ref_14709.size ] = var0[ var3 ];
                }
            }
        }
    }
    
    for ( var4 = 0; var4 < level.deploy_suicide_truck_in_lumber_yard ; var4++ )
    {
        level.ref_14709[ level.ref_14709.size ] = level.ref_146a0;
    }
    
    for ( var4 = 0; var4 < level.deploy_suicide_truck_in_farm ; var4++ )
    {
        level.ref_14709[ level.ref_14709.size ] = level.ref_1469f;
    }
    
    for ( var4 = 0; var4 < level.deploy_suicide_truck_in_blockade ; var4++ )
    {
        level.ref_14709[ level.ref_14709.size ] = level.ref_1469e;
    }
    
    for ( var4 = 0; var4 < level.deployable_cover_cancel ; var4++ )
    {
        level.ref_14709[ level.ref_14709.size ] = level.ref_146a2;
    }
    
    if ( level.deploy_subway_cars_on_track < 0 )
    {
        level.deploy_subway_cars_on_track = level.ref_146ca - level.ref_14709.size;
    }
    
    for ( var4 = 0; var4 < level.deploy_subway_cars_on_track ; var4++ )
    {
        level.ref_14709[ level.ref_14709.size ] = level.ref_1469d;
    }
    
    level.ref_14709 = scripts\engine\utility::array_randomize( level.ref_14709 );
}

// Params 5
// Size: 0xba
function ref_146ae( var0, var1, var2, var3, var4 )
{
    level notify( "zai_computer_used" );
    
    if ( !getdvarint( "scr_br_enable_zai_button_in_prematch", 0 ) && !isdefined( level.prematchstarted ) )
    {
        return;
    }
    
    if ( !issubstr( var0.targetname, "zombie" ) )
    {
        return;
    }
    
    if ( vehicle_collision_init( var0 ) )
    {
        return;
    }
    
    if ( isdefined( level.ref_146ad ) )
    {
        var3 scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME/ZOMBIE_EVENT_IS_ALREADY_ACTIVE" );
        var3 playlocalsound( "br_pickup_deny" );
        return 0;
    }
    
    if ( !isdefined( var0.targetname ) || !isdefined( level.ref_146b8 ) || var0.targetname != level.ref_146b8 )
    {
        return;
    }
    
    level.ref_146ad = var0.targetname;
    level.ref_146f0 = 0;
    level.create_ai_type_override = var0.origin;
    var0 scripts\mp\gametypes\br_alt_mode_zai::ref_13d96();
    thread ref_146ff( level );
}

// Params 0
// Size: 0x1a
function ref_146bb()
{
    if ( level.ref_146e9 )
    {
        return self.spawner.ref_146ea;
    }
    
    return undefined;
}

// Params 0
// Size: 0x25, Type: bool
function get_checking_area_alias()
{
    if ( level.ref_146f0 < level.ref_14709.size && level.ref_146ef.size < level.deploy_subway_car_at_station )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x49
function vehicle_collision_init()
{
    var0 = self;
    
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) )
    {
        return 0;
    }
    
    var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var3 = var2 * var2;
    
    if ( distance2dsquared( var0.origin, var1 ) > var3 )
    {
        return 1;
    }
    
    return 0;
}

// Params 1
// Size: 0x4
function ref_146fd( var0 )
{
    
}

