
// Params 0
// Size: 0x219
function brvehiclesinit()
{
    level.modecontrolledvehiclespawningonly = 1;
    level.ignorevehicletypeinstancelimit = 1;
    var0 = getdvarint( "scr_br_dynamic_spawn_veh_buffer", 24 );
    level.br_totalvehiclesmax = 128 - var0;
    level.br_totalvehiclesspawned = 0;
    level.br_helosmax = getdvarint( "scr_br_helos_max", 3 );
    level.defuse_spawners = getdvarint( "scr_br_truck_max", -1 );
    level.defuse_nag = getdvarint( "scr_br_dauntless_max", -1 );
    level.define_trial_mission_init_func = getdvarint( "scr_br_bomber_max", -1 );
    level.br_vehtargetnametoref = [];
    level.br_vehtargetnametoref[ "atv_spawn" ] = "atv";
    level.br_vehtargetnametoref[ "cargotruck_spawn" ] = "cargo_truck";
    level.br_vehtargetnametoref[ "cargotrucksusp_spawn" ] = "cargo_truck_susp";
    level.br_vehtargetnametoref[ "cargotruckmg_spawn" ] = "cargo_truck_mg";
    level.br_vehtargetnametoref[ "cargotrucksuspaa_spawn" ] = "cargo_truck_susp_aa";
    level.br_vehtargetnametoref[ "copcar_spawn" ] = "cop_car";
    level.br_vehtargetnametoref[ "hoopty_spawn" ] = "hoopty";
    level.br_vehtargetnametoref[ "hooptytruck_spawn" ] = "hoopty_truck";
    level.br_vehtargetnametoref[ "jeep_spawn" ] = "jeep";
    level.br_vehtargetnametoref[ "largetransport_spawn" ] = "large_transport";
    level.br_vehtargetnametoref[ "littlebird_spawn" ] = "little_bird";
    level.br_vehtargetnametoref[ "littlebirdmg_spawn" ] = "little_bird_mg";
    level.br_vehtargetnametoref[ "veh_a10fd" ] = "veh_a10fd";
    level.br_vehtargetnametoref[ "veh_bt" ] = "veh_bt";
    level.br_vehtargetnametoref[ "mediumtransport_spawn" ] = "medium_transport";
    level.br_vehtargetnametoref[ "motorcycle_spawn" ] = "motorcycle";
    level.br_vehtargetnametoref[ "openjeep_spawn" ] = "open_jeep";
    level.br_vehtargetnametoref[ "open_jeep_carpoc_spawn" ] = "open_jeep_carpoc";
    level.br_vehtargetnametoref[ "pickuptruck_spawn" ] = "pickup_truck";
    level.br_vehtargetnametoref[ "tacrover_spawn" ] = "tac_rover";
    level.br_vehtargetnametoref[ "technical_spawn" ] = "technical";
    level.br_vehtargetnametoref[ "van_spawn" ] = "van";
    level.br_vehtargetnametoref[ "convoytruck_spawn" ] = "convoy_truck";
    level.br_vehtargetnametoref[ "veh_indigo" ] = "veh_indigo";
    level._effect[ "vehicle_flares" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx" );
}

// Params 0
// Size: 0xc
function brvehiclesonstartgametype()
{
    setupvehiclespawnvolumes();
    brvehiclesreset();
}

// Params 0
// Size: 0x360
function setupvehiclespawnvolumes()
{
    var0 = "vehicle_volume";
    
    if ( getdvarint( "scr_br_veh_vol_simple", 1 ) )
    {
        var0 = "vehicle_volume_simplified";
    }
    
    level.brvehspawnvols = getentarray( var0, "script_noteworthy" );
    
    foreach ( var2 in level.brvehspawnvols )
    {
        initvehiclespawnvolume( var2 );
    }
    
    level.br_vehicleallspawns = [];
    level.br_vehiclealwaysspawns = [];
    level.br_helospawns = [];
    level.deletex1stashhud = [];
    level.defend_death_counter = [];
    level.debug_warpplayer_monitor = [];
    var4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
    
    foreach ( var6 in var4.databyref )
    {
        var7 = [[ var6.getspawnstructscallback ]]();
        
        if ( isdefined( level.play_nag_players_hvt_callouts ) )
        {
            var7 = [[ level.play_nag_players_hvt_callouts ]]( var7 );
        }
        
        if ( isdefined( level.´l!á±™'{Õ˜wºH)ß+9suz{«¶É@Ýõ`& ) )
        {
            var7 = [[ level.´l!á±™'{Õ˜wºH)ß+9suz{«¶É@Ýõ`& ]]( var14, var7 );
        }
        
        ref_13e0c( var7 );
        hudcoststring( var7, "atv_spawn", "atv", "motorcycle_spawn", "motorcycle", "motorcycle_spawn_percent" );
        hudcoststring( var7, "cargotruck_spawn", "cargo_truck", "cargotrucksusp_spawn", "cargo_truck_susp", "cargotrucksusp_spawn_percent" );
        hudcoststring( var7, "cargotrucksusp_spawn", "cargo_truck_susp", "cargotrucksuspaa_spawn", "cargo_truck_susp_aa", "cargotrucksuspaa_spawn_percent" );
        hudcoststring( var7, "jeep_spawn", "jeep", "openjeep_spawn", "open_jeep", "openjeep_spawn_percent" );
        hudcoststring( var7, "veh_bt", "veh_bt", "veh_a10fd", "veh_a10fd", "bt_to_a10fd_spawn_percent" );
        hudcoststring( var7, "cargotrucksuspaa_spawn", "cargo_truck_susp_aa", "openjeep_spawn", "open_jeep", "cargotruckaa_to_openjeep_conv_percent" );
        hudcoststring( var7, "jeep_spawn", "jeep", "open_jeep_carpoc_spawn", "open_jeep_carpoc", "jeep_to_armoredsuv_spawn_percent" );
        hudcoststring( var7, "openjeep_spawn", "open_jeep", "open_jeep_carpoc_spawn", "open_jeep_carpoc", "openjeep_to_armoredsuv_spawn_percent" );
        level.br_vehicleallspawns = scripts\engine\utility::array_combine_unique( level.br_vehicleallspawns, var7 );
        
        foreach ( var9 in var7 )
        {
            if ( isdefined( var9.script_priority ) && var9.script_priority > 0 && ( level.defuse_spawners < 0 || !tv_station_fastrope_two_infil_start_targetname_array( var9 ) ) )
            {
                var10 = level.br_vehiclealwaysspawns.size;
                level.br_vehiclealwaysspawns[ var10 ] = var9;
                continue;
            }
            
            if ( isdefined( var9.targetname ) && ( var9.targetname == "littlebird_spawn" || var9.targetname == "littlebirdmg_spawn" ) )
            {
                level.br_helospawns[ level.br_helospawns.size ] = var9;
                continue;
            }
            
            if ( level.defuse_spawners >= 0 && tv_station_fastrope_two_infil_start_targetname_array( var9 ) )
            {
                level.deletex1stashhud[ level.deletex1stashhud.size ] = var9;
                continue;
            }
            
            if ( level.defuse_nag >= 0 && uid( var9 ) )
            {
                level.defend_death_counter[ level.defend_death_counter.size ] = var9;
                continue;
            }
            
            if ( level.define_trial_mission_init_func >= 0 && tutorial_intro( var9 ) )
            {
                level.debug_warpplayer_monitor[ level.debug_warpplayer_monitor.size ] = var9;
                continue;
            }
            
            foreach ( var2 in level.brvehspawnvols )
            {
                if ( ispointinvolume( var9.origin, var2 ) )
                {
                    var10 = var2.vehiclespawns.size;
                    var2.vehiclespawns[ var10 ] = var9;
                    break;
                }
            }
        }
    }
}

// Params 1
// Size: 0x6a
function initvehiclespawnvolume( var0 )
{
    var0.vehiclespawns = [];
    var0.vehiclesspawned = 0;
    
    switch ( level.mapname )
    {
        case "mp_donetsk":
        case "mp_kstenod":
        case "mp_don3":
            assignvehicleminimumsforvolume( var0 );
            break;
        case "mp_don4":
            cargo_truck_mg_mp_ondeathrespawncallback( var0 );
            break;
        case "mp_wz_island":
            cargo_truck_mg_mp_spawncallback( var0 );
            break;
    }
}

// Params 1
// Size: 0x191
function cargo_truck_mg_mp_spawncallback( var0 )
{
    var0.minvehicles = 0;
    
    switch ( var0.targetname )
    {
        case "ag_center":
            var0.minvehicles = 2;
            break;
        case "airfield":
            var0.minvehicles = 1;
            break;
        case "airfield_bomber":
            var0.minvehicles = 1;
            break;
        case "airstrip":
            var0.minvehicles = 0;
            break;
        case "airstrip_bomber":
            var0.minvehicles = 1;
            break;
        case "arsenal":
            var0.minvehicles = 1;
            break;
        case "beachhead":
            var0.minvehicles = 1;
            break;
        case "caldera":
            var0.minvehicles = 1;
            break;
        case "capital":
            var0.minvehicles = 3;
            break;
        case "docks":
            var0.minvehicles = 1;
            break;
        case "mines":
            var0.minvehicles = 1;
            break;
        case "ruins":
            var0.minvehicles = 1;
            break;
        case "subpen":
            var0.minvehicles = 2;
            break;
        case "village":
            var0.minvehicles = 1;
            break;
        case "lagoon":
            var0.minvehicles = 1;
            break;
        case "radiostation":
            var0.minvehicles = 3;
            break;
        case "resort":
            var0.minvehicles = 1;
            break;
    }
}

// Params 1
// Size: 0x215
function cargo_truck_mg_mp_ondeathrespawncallback( var0 )
{
    var0.minvehicles = 0;
    
    switch ( var0.targetname )
    {
        case "boneyard":
            var0.minvehicles = 2;
            break;
        case "summit":
            var0.minvehicles = 2;
            break;
        case "summit_helipad":
            var0.minvehicles = 1;
            break;
        case "downtown":
            var0.minvehicles = 4;
            break;
        case "downtownpark":
            var0.minvehicles = 1;
            break;
        case "farm":
            var0.minvehicles = 4;
            break;
        case "gulag":
            var0.minvehicles = 1;
            break;
        case "hospital":
            var0.minvehicles = 0;
            break;
        case "junkyard":
            var0.minvehicles = 1;
            break;
        case "layover":
            var0.minvehicles = 3;
            break;
        case "lumber":
            var0.minvehicles = 2;
            break;
        case "militarybase":
            var0.minvehicles = 3;
            break;
        case "port":
            var0.minvehicles = 2;
            break;
        case "quarry":
            var0.minvehicles = 2;
            break;
        case "stadium":
            var0.minvehicles = 1;
            break;
        case "storagewars":
            var0.minvehicles = 1;
            break;
        case "super":
            var0.minvehicles = 1;
            break;
        case "torez":
            var0.minvehicles = 1;
            break;
        case "transit":
            var0.minvehicles = 2;
            break;
        case "tvstation":
            var0.minvehicles = 1;
            break;
        case "duga":
            var0.minvehicles = 1;
            break;
        case "abandoned":
            var0.minvehicles = 1;
            break;
        case "test_zone":
            var0.minvehicles = 1;
            break;
    }
}

// Params 1
// Size: 0x1d3
function assignvehicleminimumsforvolume( var0 )
{
    var0.minvehicles = 0;
    
    switch ( var0.targetname )
    {
        case "boneyard":
            var0.minvehicles = 2;
            break;
        case "dam":
            var0.minvehicles = 2;
            break;
        case "downtown":
            var0.minvehicles = 4;
            break;
        case "downtownpark":
            var0.minvehicles = 1;
            break;
        case "farm":
            var0.minvehicles = 4;
            break;
        case "gulag":
            var0.minvehicles = 1;
            break;
        case "hospital":
            var0.minvehicles = 0;
            break;
        case "junkyard":
            var0.minvehicles = 1;
            break;
        case "layover":
            var0.minvehicles = 3;
            break;
        case "lumber":
            var0.minvehicles = 2;
            break;
        case "militarybase":
            var0.minvehicles = 3;
            break;
        case "port":
            var0.minvehicles = 2;
            break;
        case "quarry":
            var0.minvehicles = 2;
            break;
        case "stadium":
            var0.minvehicles = 1;
            break;
        case "storagewars":
            var0.minvehicles = 1;
            break;
        case "super":
            var0.minvehicles = 1;
            break;
        case "torez":
            var0.minvehicles = 1;
            break;
        case "transit":
            var0.minvehicles = 2;
            break;
        case "tvstation":
            var0.minvehicles = 1;
            break;
        case "test_zone":
            var0.minvehicles = 1;
            break;
    }
}

// Params 0
// Size: 0x7e
function emptyallvehicles()
{
    if ( !isdefined( level.vehicle ) || !isdefined( level.vehicle.instances ) )
    {
        return;
    }
    
    foreach ( var1 in level.vehicle.instances )
    {
        foreach ( var3 in var1 )
        {
            if ( scripts\cp_mp\vehicles\vehicle_occupancy::ref_141de( var3 ) )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( var3 );
            }
        }
    }
}

// Params 1
// Size: 0xb1
function deleteextantvehicles( var0 )
{
    if ( !isdefined( level.vehicle ) || !isdefined( level.vehicle.instances ) )
    {
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_spawn::ref_14212();
    level.suppressvehicleexplosion = 1;
    
    foreach ( var2 in level.vehicle.instances )
    {
        var3 = scripts\mp\vehicles\damage::get_death_callback( var7 );
        
        foreach ( var5 in var2 )
        {
            if ( isdefined( var0 ) && scripts\engine\utility::array_contains( var0, var5 ) )
            {
                continue;
            }
            
            scripts\cp_mp\vehicles\vehicle_spawn::ref_14219( var5 );
            var5 [[ var3 ]]( undefined );
        }
    }
    
    level.suppressvehicleexplosion = 0;
}

// Params 4
// Size: 0xe0
function tryspawnavehicle( var0, var1, var2, var3 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "vehicleSpawns" ) )
    {
        return;
    }
    
    if ( ( var0 == "little_bird" || var0 == "little_bird_mg" ) && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "littleBirdSpawns" ) )
    {
        return;
    }
    
    if ( ( var0 == "cargo_truck" || var0 == "cargo_truck_mg" ) && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "truckSpawns" ) )
    {
        return;
    }
    
    if ( var0 == "jeep" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "jeepSpawns" ) )
    {
        return;
    }
    
    if ( var0 == "tac_rover" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "tacRoverSpawns" ) )
    {
        return;
    }
    
    if ( var0 == "atv" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "atvSpawns" ) )
    {
        return;
    }
    
    if ( var0 == "motorcycle" && scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "motorcycleSpawns" ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnvehicle( var0, undefined, undefined, var1 ) )
    {
        var4 = spawnavehicle( var0, var1, var3 );
        
        if ( isdefined( var4 ) )
        {
            return var4;
        }
    }
    
    return undefined;
}

// Params 3
// Size: 0xb2
function spawnavehicle( var0, var1, var2 )
{
    var3 = var1.origin;
    var4 = var1.angles;
    
    if ( !isdefined( var4 ) )
    {
        var4 = ( 0, randomfloat( 360 ), 0 );
    }
    
    var5 = spawnstruct();
    var5.origin = var3;
    var5.angles = var4;
    var5.spawntype = "GAME_MODE";
    var6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( var0, var5, var2 );
    
    if ( isdefined( var6 ) )
    {
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "postSpawnVehicle" ) )
        {
            scripts\mp\gametypes\br_gametypes::ref_12e05( "postSpawnVehicle", var6, var0 );
        }
        
        scripts\mp\gametypes\br_analytics::dialog_monitor_shieldstow( var6, var0 );
        
        if ( var0 == "little_bird" || var0 == "little_bird_mg" )
        {
            var6.isheli = 1;
        }
        
        if ( !isdefined( var6.unique_id ) )
        {
            var6 scripts\engine\flags::assign_unique_id();
        }
    }
    
    return var6;
}

// Params 0
// Size: 0x5aa
function spawninitialvehicles()
{
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
    level.br_totalvehiclesspawned = 0;
    var1 = 0;
    var2 = [];
    var3 = level.br_vehicleallspawns;
    var4 = scripts\engine\utility::array_randomize( level.br_vehiclealwaysspawns );
    
    foreach ( var6 in var4 )
    {
        var7 = spawnstruct();
        var8 = level.br_vehtargetnametoref[ var6.targetname ];
        var9 = tryspawnavehicle( var8, var6, "alwaysSpawn", var7 );
        
        if ( isdefined( var9 ) )
        {
            level.br_totalvehiclesspawned++;
            var2 = var6;
            var10 = 0;
            
            foreach ( var12 in level.brvehspawnvols )
            {
                if ( ispointinvolume( var6.origin, var12 ) )
                {
                    var12.vehiclesspawned++;
                    var10 = 1;
                    break;
                }
            }
            
            if ( var10 )
            {
            }
            
            if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
            {
                break;
            }
            
            waitframe();
            continue;
        }
        
        <error>++;
    }
    
    var1 = undefined;
    var6 = undefined;
    var19 = 0;
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var20 = scripts\engine\utility::array_randomize( level.brvehspawnvols );
        
        foreach ( var12 in var20 )
        {
            var22 = var12.minvehicles;
            
            if ( isdefined( var22 ) && var22 > 0 )
            {
                if ( var22 > var12.vehiclespawns.size )
                {
                }
                
                if ( var12.vehiclesspawned < var22 && var12.vehiclespawns.size > 0 )
                {
                    var23 = scripts\engine\utility::array_randomize( var12.vehiclespawns );
                    
                    for ( var24 = 0; var12.vehiclesspawned < var22 && var24 < var23.size ; var24++ )
                    {
                        var3 = spawnstruct();
                        var2 = var23[ var24 ];
                        var4 = level.br_vehtargetnametoref[ var2.targetname ];
                        var5 = tryspawnavehicle( var4, var2, var12.targetname, var3 );
                        
                        if ( !isdefined( var5 ) )
                        {
                            var19++;
                            continue;
                        }
                        
                        level.br_totalvehiclesspawned++;
                        <error> = var2;
                        var12.vehiclesspawned++;
                        
                        if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                        {
                            break;
                        }
                        
                        waitframe();
                    }
                    
                    if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                    {
                        break;
                    }
                }
            }
        }
        
        var19 = undefined;
        var12 = undefined;
    }
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var26 = 0;
        var27 = scripts\engine\utility::array_randomize( level.br_helospawns );
        
        foreach ( var0 in var27 )
        {
            var1 = spawnstruct();
            var2 = level.br_vehtargetnametoref[ var0.targetname ];
            var3 = tryspawnavehicle( var2, var0, "heloSpawn", var1 );
            
            if ( isdefined( var3 ) )
            {
                level.br_totalvehiclesspawned++;
                <error> = var0;
                var26++;
                
                if ( var26 >= level.br_helosmax )
                {
                    break;
                }
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    if ( level.defuse_spawners > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var30 = 0;
        var31 = scripts\engine\utility::array_randomize( level.deletex1stashhud );
        
        foreach ( var0 in var31 )
        {
            var1 = spawnstruct();
            var2 = level.br_vehtargetnametoref[ var0.targetname ];
            var3 = tryspawnavehicle( var2, var0, "truckSpawn", var1 );
            
            if ( isdefined( var3 ) )
            {
                level.br_totalvehiclesspawned++;
                <error> = var0;
                var30++;
                
                if ( var30 >= level.defuse_spawners )
                {
                    break;
                }
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    if ( level.defuse_nag > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var34 = 0;
        var35 = scripts\engine\utility::array_randomize( level.defend_death_counter );
        
        foreach ( var0 in var35 )
        {
            var1 = spawnstruct();
            var2 = level.br_vehtargetnametoref[ var0.targetname ];
            var3 = tryspawnavehicle( var2, var0, "veh_a10fd", var1 );
            
            if ( isdefined( var3 ) )
            {
                level.br_totalvehiclesspawned++;
                <error> = var0;
                var34++;
                
                if ( var34 >= level.defuse_nag )
                {
                    break;
                }
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    if ( level.define_trial_mission_init_func > 0 && level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var38 = 0;
        var39 = scripts\engine\utility::array_randomize( level.debug_warpplayer_monitor );
        
        foreach ( var0 in var39 )
        {
            var1 = spawnstruct();
            var2 = level.br_vehtargetnametoref[ var0.targetname ];
            var3 = tryspawnavehicle( var2, var0, "veh_bt", var1 );
            
            if ( isdefined( var3 ) )
            {
                level.br_totalvehiclesspawned++;
                <error> = var0;
                var38++;
                
                if ( var38 >= level.define_trial_mission_init_func )
                {
                    break;
                }
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    if ( level.defuse_spawners >= 0 )
    {
        <error> = scripts\engine\utility::array_remove_array( <error>, level.deletex1stashhud );
    }
    
    if ( level.defuse_nag >= 0 )
    {
        <error> = scripts\engine\utility::array_remove_array( <error>, level.defend_death_counter );
    }
    
    if ( level.define_trial_mission_init_func >= 0 )
    {
        <error> = scripts\engine\utility::array_remove_array( <error>, level.debug_warpplayer_monitor );
    }
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var23 = 0;
        <error> = scripts\engine\utility::array_remove_array( <error>, <error> );
        <error> = scripts\engine\utility::array_randomize( <error> );
        
        foreach ( var0 in <error> )
        {
            var2 = level.br_vehtargetnametoref[ var0.targetname ];
            
            while ( !scripts\cp_mp\vehicles\vehicle_tracking::canspawnvehicle() )
            {
                wait 1;
            }
            
            var1 = spawnstruct();
            var3 = tryspawnavehicle( var2, var0, "randomSpawns", var1 );
            
            if ( isdefined( var3 ) )
            {
                level.br_totalvehiclesspawned++;
                var23++;
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    var44 = 0;
    var52 = <error> + var5;
    
    if ( var44 > 0 )
    {
        return;
    }
}

// Params 0
// Size: 0x3c
function brvehiclespawnvolreset()
{
    level.br_totalvehiclesspawned = 0;
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
    
    foreach ( var2 in level.brvehspawnvols )
    {
        var2.vehiclesspawned = 0;
    }
}

// Params 0
// Size: 0x39
function waitforvehiclestodeletethenspawninitial()
{
    level endon( "game_ended" );
    level notify( "br_vehiclesWaitForDelete" );
    level endon( "br_vehiclesWaitForDelete" );
    waitframe();
    waittillframeend();
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "spawnInitialVehicles" ) )
    {
        scripts\mp\gametypes\br_gametypes::ref_12e05( "spawnInitialVehicles" );
        return;
    }
    
    spawninitialvehicles();
}

// Params 0
// Size: 0x20
function brvehiclesreset()
{
    emptyallvehicles();
    deleteextantvehicles();
    brvehiclespawnvolreset();
    thread waitforvehiclestodeletethenspawninitial();
    level notify( "br_vehiclesReset" );
}

// Params 0
// Size: 0x1c
function brvehicleonprematchstarted()
{
    wait 1.5;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal( 0 );
    brvehiclesreset();
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuseglobal( 1 );
}

// Params 0
// Size: 0x2d
function enemy_monitor_reload()
{
    var0 = scripts\engine\utility::array_combine( level.vehicle.instances[ "little_bird" ], level.vehicle.instances[ "little_bird_mg" ] );
    return var0;
}

// Params 0
// Size: 0x2d
function enemy_molotov_launch()
{
    var0 = scripts\engine\utility::array_combine( level.vehicle.instances[ "veh_a10fd" ], level.vehicle.instances[ "veh_bt" ] );
    return var0;
}

// Params 2
// Size: 0x1fa
function dangercircletick( var0, var1 )
{
    if ( !isdefined( level.vehicle ) || !isdefined( level.vehicle.instances ) )
    {
        return;
    }
    
    var2 = 160;
    var3 = 36;
    var4 = 100;
    var5 = getdvarfloat( "scr_br_heli_circle_damage_tick", var4 );
    var6 = enemy_monitor_reload();
    
    if ( isdefined( var6 ) )
    {
        foreach ( var8 in var6 )
        {
            var9 = 0;
            var10 = var8.origin;
            var11 = distance2d( var0, var10 );
            
            if ( var11 + var2 > var1 )
            {
                var9 = 1;
            }
            else
            {
                var12 = var8 gettagorigin( "tail_rotor_jnt" );
                var11 = distance2d( var0, var12 );
                
                if ( var11 + var3 > var1 )
                {
                    var9 = 1;
                }
            }
            
            if ( var9 )
            {
                var8 dodamage( var5, var10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
        }
    }
    
    var14 = getdvarint( "scr_br_aircraft_circle_damage_tick", 85 );
    
    if ( isdefined( level.vehicle.instances[ "veh_a10fd" ] ) )
    {
        foreach ( var16 in level.vehicle.instances[ "veh_a10fd" ] )
        {
            var17 = 0;
            var10 = var16.origin;
            var11 = distance2d( var0, var10 );
            
            if ( var11 > var1 )
            {
                var17 = 1;
            }
            
            if ( var17 )
            {
                var16 dodamage( var14, var10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
        }
    }
    
    var19 = getdvarint( "scr_br_bomber_circle_damage_tick", 100 );
    
    if ( isdefined( level.vehicle.instances[ "veh_bt" ] ) )
    {
        foreach ( var21 in level.vehicle.instances[ "veh_bt" ] )
        {
            var22 = 0;
            var10 = var21.origin;
            var11 = distance2d( var0, var10 );
            
            if ( var11 > var1 )
            {
                var22 = 1;
            }
            
            if ( var22 )
            {
                var21 dodamage( var19, var10, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
        }
        
        return;
    }
}

// Params 6
// Size: 0x99
function hudcoststring( var0, var1, var2, var3, var4, var5 )
{
    var6 = getdvarfloat( var5, 0 );
    
    if ( var6 == 0 )
    {
        return;
    }
    
    var6 = clamp( var6, 0, 100 ) / 100;
    var7 = [];
    
    foreach ( var9 in var0 )
    {
        if ( vars_update( var9, var1, var2 ) )
        {
            var7 = var9;
        }
    }
    
    var7 = scripts\engine\utility::array_randomize( var7 );
    var11 = floor( var7.size * var6 );
    
    for ( var12 = 0; var12 < var7.size && var12 < var11 ; var12++ )
    {
        var7[ var12 ].targetname = var3;
        var7[ var12 ].refname = var4;
    }
}

// Params 3
// Size: 0x3c, Type: bool
function vars_update( var0, var1, var2 )
{
    if ( isdefined( var0.targetname ) && var0.targetname == var1 )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == var2 )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x93
function ref_13e0c( var0 )
{
    var1 = getdvarfloat( "lb_mg_spawn_percent", 0 );
    
    if ( var1 == 0 )
    {
        return;
    }
    
    var1 = clamp( var1, 0, 100 ) / 100;
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( update_bomb_vest_controller( var4 ) )
        {
            var2 = var4;
        }
    }
    
    var2 = scripts\engine\utility::array_randomize( var2 );
    var6 = floor( var2.size * var1 );
    
    for ( var7 = 0; var7 < var6 ; var7++ )
    {
        var4 = var2[ var7 ];
        var4.targetname = "littlebirdmg_spawn";
        var4.refname = "little_bird_mg";
    }
}

// Params 1
// Size: 0x42, Type: bool
function update_bomb_vest_controller( var0 )
{
    if ( isdefined( var0.targetname ) && var0.targetname == "littlebird_spawn" )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == "little_bird" )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x7e, Type: bool
function tv_station_fastrope_two_infil_start_targetname_array( var0 )
{
    if ( isdefined( var0.targetname ) && var0.targetname == "cargotruck_spawn" )
    {
        return true;
    }
    
    if ( isdefined( var0.targetname ) && var0.targetname == "cargotruckmg_spawn" )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == "cargo_truck" )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == "cargo_truck_mg" )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x42, Type: bool
function uid( var0 )
{
    if ( isdefined( var0.targetname ) && var0.targetname == "veh_a10fd" )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == "veh_a10fd" )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x42, Type: bool
function tutorial_intro( var0 )
{
    if ( isdefined( var0.targetname ) && var0.targetname == "veh_bt" )
    {
        return true;
    }
    
    if ( isdefined( var0.refname ) && var0.refname == "veh_bt" )
    {
        return true;
    }
    
    return false;
}

