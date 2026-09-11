
// Params 2
// Size: 0x122
function vehicle_occupancy_getleveldataforvehicle( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldata();
    var3 = var2.vehicledata[ var0 ];
    
    if ( !isdefined( var3 ) )
    {
        if ( isdefined( var1 ) )
        {
            var3 = spawnstruct();
            var2.vehicledata[ var0 ] = var3;
            var3.seatdata = [];
            var3.enterstartcallback = undefined;
            var3.enterendcallback = undefined;
            var3.exitstartcallback = undefined;
            var3.exitendcallback = undefined;
            var3.reentercallback = undefined;
            var3.ref_11d02 = undefined;
            var3.restrictions = [];
            var3.damagemodifier = -1;
            var3.hideoccupant = undefined;
            var3.camera = "none";
            var3.threatbiasgroup = "Level_Vehicle";
            var3.exitextents = [];
            var3.exitextents[ "front" ] = undefined;
            var3.exitextents[ "back" ] = undefined;
            var3.exitextents[ "left" ] = undefined;
            var3.exitextents[ "right" ] = undefined;
            var3.exitextents[ "top" ] = undefined;
            var3.exitextents[ "bottom" ] = undefined;
            var3.exitoffsets = [];
            var3.exitdirections = [];
            var3.exittopcastoffset = undefined;
            var3.damagefeedbackgrouplight = "driver";
            var3.damagefeedbackgroupheavy = "all";
        }
    }
    
    return var3;
}

// Params 3
// Size: 0xbe
function vehicle_occupancy_getleveldataforseat( var0, var1, var2 )
{
    var3 = vehicle_occupancy_getleveldataforvehicle( var0, var2 );
    var4 = var3.seatdata[ var1 ];
    
    if ( !isdefined( var4 ) )
    {
        if ( istrue( var2 ) )
        {
            var4 = spawnstruct();
            var3.seatdata[ var1 ] = var4;
            var4.vehicledata = var3;
            var4.seatswitcharray = [];
            var4.exitids = [];
            var4.spawnpriority = undefined;
            var4.viewclamps = [];
            var4.viewclamps[ "top" ] = undefined;
            var4.viewclamps[ "bottom" ] = undefined;
            var4.viewclamps[ "left" ] = undefined;
            var4.viewclamps[ "right" ] = undefined;
            var4.hideheldweapon = undefined;
            var4.hidestowedweapon = undefined;
            var4.ref_13345 = undefined;
            var4.ref_13e8a = undefined;
            var4.ref_13e8b = undefined;
            var4.ref_13e92 = undefined;
        }
    }
    
    return var4;
}

// Params 1
// Size: 0x46
function vehicle_occupancy_registerinstance( var0 )
{
    var0.occupants = [];
    var0.occupantsreserving = [];
    var0.isempty = 1;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "registerInstance" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "registerInstance" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x4d
function vehicle_occupancy_deregisterinstance( var0 )
{
    var0.occupants = undefined;
    var0.occupantsreserving = undefined;
    var0.isempty = undefined;
    var0.ref_1287d = undefined;
    var0.brking_rankupdate = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "deregisterInstance" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "deregisterInstance" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0xd, Type: bool
function ref_141de( var0 )
{
    return isdefined( var0.occupants );
}

// Params 2
// Size: 0x2f
function vehicle_occupancy_getallvehicleseats( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( isdefined( var2 ) )
    {
        return getarraykeys( var2.seatdata );
    }
    
    return [];
}

// Params 3
// Size: 0x16f
function vehicle_occupancy_getavailablevehicleseats( var0, var1, var2 )
{
    var3 = [];
    var4 = vehicle_occupancy_getallvehicleseats( var0 );
    
    foreach ( var6 in var4 )
    {
        if ( !vehicle_occupancy_seatisavailable( var0, var6 ) )
        {
            continue;
        }
        
        var3 = var6;
    }
    
    if ( istrue( var1 ) )
    {
        if ( var3.size > 0 )
        {
            var8 = [];
            
            foreach ( var6 in var3 )
            {
                var10 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var6 );
                var11 = var10.spawnpriority;
                
                if ( !isdefined( var11 ) )
                {
                    var11 = 0;
                }
                else
                {
                    var11 = int( max( 0, var11 ) );
                }
                
                var8 = var11;
            }
            
            if ( istrue( var2 ) )
            {
                for ( var13 = 0; var13 < var3.size - 1 ; var13++ )
                {
                    var14 = var13;
                    
                    for ( var15 = var13 + 1; var15 < var3.size ; var15++ )
                    {
                        if ( var8[ var3[ var15 ] ] > var8[ var3[ var14 ] ] )
                        {
                            var14 = var15;
                        }
                    }
                    
                    if ( var14 != var13 )
                    {
                        var16 = var3[ var13 ];
                        var3 = var3[ var14 ];
                        var3 = var16;
                    }
                }
            }
            else
            {
                for ( var13 = 0; var13 < var5.size - 1 ; var13++ )
                {
                    var17 = var5[ var13 ];
                    
                    for ( var15 = var13 + 1; var15 < var5.size ; var15++ )
                    {
                        var18 = var5[ var15 ];
                        
                        if ( var10[ var18 ] > var10[ var17 ] )
                        {
                            var16 = var17;
                            var5 = var18;
                            var5 = var16;
                        }
                    }
                }
            }
        }
    }
    
    return var5;
}

// Params 3
// Size: 0x5b, Type: bool
function vehicle_occupancy_seatisavailable( var0, var1, var2 )
{
    var3 = var0.occupants[ var1 ];
    var4 = var0.occupantsreserving[ var1 ];
    
    if ( istrue( var0.brking_rankupdate ) )
    {
        return false;
    }
    
    if ( !isdefined( var3 ) && !isdefined( var4 ) )
    {
        return true;
    }
    
    if ( isdefined( var2 ) )
    {
        if ( isdefined( var3 ) && var3 == var2 )
        {
            return true;
        }
        
        if ( isdefined( var4 ) && var4 == var2 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 3
// Size: 0x27
function vehicle_occupancy_getseatoccupant( var0, var1, var2 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 1;
    }
    
    if ( isdefined( var0.occupants ) )
    {
        return var0.occupants[ var1 ];
    }
    
    return undefined;
}

// Params 2
// Size: 0x15
function vehicle_occupancy_getalloccupants( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    return var0.occupants;
}

// Params 2
// Size: 0x2e
function vehicle_occupancy_getalloccupantsandreserving( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    if ( !isdefined( var0.occupants ) )
    {
        return undefined;
    }
    
    return scripts\engine\utility::array_combine_unique( var0.occupants, var0.occupantsreserving );
}

// Params 2
// Size: 0x22
function ref_141d6( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 1;
    }
    
    if ( !isdefined( var0.occupants ) )
    {
        return undefined;
    }
    
    return var0.occupantsreserving;
}

// Params 2
// Size: 0x35
function vehicle_occupancy_getoccupantseat( var0, var1 )
{
    foreach ( var3 in var0.occupants )
    {
        if ( var3 == var1 )
        {
            return var4;
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x5d, Type: bool
function vehicle_occupancy_occupantisvehicledriver( var0 )
{
    if ( isdefined( var0.vehicle ) )
    {
        var1 = vehicle_occupancy_getoccupantseat( var0.vehicle, var0 );
        var2 = vehicle_occupancy_getleveldataforseat( var0.vehicle.vehiclename, var1 );
        
        if ( isdefined( var2.animtag ) )
        {
            var3 = tolower( var2.animtag );
            
            if ( var3 == "tag_seat_0" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 2
// Size: 0x20
function vehicle_occupancy_getdriver( var0, var1 )
{
    var2 = vehicle_occupancy_getdriverseat( var0, var1 );
    
    if ( isdefined( var2 ) )
    {
        return vehicle_occupancy_getseatoccupant( var0, var2, !istrue( var1 ) );
    }
    
    return undefined;
}

// Params 2
// Size: 0x84
function vehicle_occupancy_getdriverseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename, !istrue( var1 ) );
    
    if ( !isdefined( var2 ) )
    {
        return undefined;
    }
    
    var3 = var2.driverseatid;
    
    if ( !isdefined( var3 ) )
    {
        foreach ( var5 in var2.seatdata )
        {
            if ( isdefined( var5.animtag ) && tolower( var5.animtag ) == "tag_seat_0" )
            {
                var3 = var6;
                break;
            }
        }
        
        var2.driverseatid = var3;
    }
    
    return var3;
}

// Params 2
// Size: 0x39, Type: bool
function ref_141df( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var1 );
    
    if ( !isdefined( var2.animtag ) )
    {
        return false;
    }
    
    if ( tolower( var2.animtag ) != "tag_seat_0" )
    {
        return false;
    }
    
    return true;
}

// Params 5
// Size: 0x7e5
function vehicle_occupancy_enter( var0, var1, var2, var3, var4 )
{
    var5 = 0;
    
    if ( isdefined( var3 ) && isdefined( var3.useonspawn ) )
    {
        var5 = 1;
    }
    
    if ( !var5 && !var2 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    if ( istrue( var2.inlaststand ) )
    {
        return;
    }
    
    if ( istrue( var0.isdestroyed ) )
    {
        return;
    }
    
    if ( istrue( var0.oob ) )
    {
        if ( isdefined( var0.oobendtime ) && var0.oobendtime - gettime() < 100 )
        {
            return;
        }
    }
    
    if ( isdefined( var0.vehicletype ) && var0.vehicletype == "motorcycle_physics_mp" )
    {
        var6 = [ var0 ];
        var7 = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_glass", "physicscontents_item" ];
        var8 = physics_createcontents( var7 );
        
        if ( isdefined( var8 ) )
        {
            var9 = ( 0, 0, 1 );
            var10 = getdvarfloat( "scr_motoEnterRaycastHeight", 30 );
            var11 = getdvarfloat( "scr_motoEnterRaycastRadius", 0.5 );
            var12 = var0 physics_getentitycenterofmass()[ "unscaled" ];
            
            if ( isdefined( var12 ) )
            {
                var13 = var12 + var9 * var10;
                var14 = scripts\engine\trace::sphere_trace( var12, var13, var11, var6, var8 );
                
                if ( isdefined( var14 ) )
                {
                    var15 = distance( var12, var14[ "position" ] );
                    
                    if ( var15 < var10 )
                    {
                        return;
                    }
                }
            }
        }
    }
    
    if ( !scripts\cp_mp\vehicles\vehicle_tracking::_wakeupvehicle( var0, 0, 0 ) )
    {
        return 0;
    }
    
    foreach ( var17 in var0.occupantsreserving )
    {
        if ( isdefined( var17 ) && var17 == var2 )
        {
            return;
        }
    }
    
    var19 = vehicle_occupancy_getoccupantseat( var0, var2 );
    
    if ( istrue( vehicle_occupancy_seatisavailable( var0, var1, var2 ) ) )
    {
        vehicle_occupancy_stopmonitoringoccupant( var2 );
        
        if ( !isdefined( var3 ) )
        {
            var3 = spawnstruct();
        }
        
        var3.immediate = istrue( var4 );
        var3.raceendnotify = "vehicle_race_last_call";
        var3.raceendon = "vehicle_race_finished";
        
        if ( !var3.immediate )
        {
            thread vehicle_occupancy_raceplayerdeathdisconnect( var2, var3 );
            thread vehicle_occupancy_racevehicledeath( var0, var3 );
            thread vehicle_occupancy_raceseatunavailable( var0, var2, var1, var19, var3 );
            thread vehicle_occupancy_racecomplete( var19, var1, var3 );
        }
        
        if ( isdefined( var19 ) )
        {
            thread vehicle_occupancy_exitstart( var0, var19, var1, var2, var3 );
        }
        
        if ( isdefined( var1 ) )
        {
            thread vehicle_occupancy_enterstart( var0, var1, var19, var2, var3 );
        }
        
        vehicle_occupancy_updatefull( var0 );
        vehicle_occupancy_updateempty( var0 );
        
        if ( !var3.immediate )
        {
            var3 waittill( var3.raceendnotify );
            waittillframeend();
            var3 notify( var3.raceendon );
        }
        
        if ( !scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered( var0 ) )
        {
            var3.success = 0;
            
            if ( isdefined( var1 ) )
            {
                thread vehicle_occupancy_enterend( var0, var1, var19, var2, var3 );
            }
            
            return;
        }
        
        var20 = vehicle_occupancy_raceresults( var0, var2, var19, var1, var3 );
        
        if ( isdefined( var19 ) )
        {
            thread vehicle_occupancy_exitend( var0, var19, var1, var2, var3 );
        }
        
        if ( isdefined( var1 ) )
        {
            thread vehicle_occupancy_enterend( var0, var1, var19, var2, var3 );
        }
        
        vehicle_occupancy_updatefull( var0 );
        vehicle_occupancy_updateempty( var0 );
        
        if ( var20 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "changedSeats" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "changedSeats" ) ]]( var2, var0, var19, var1 );
            }
            
            thread vehicle_occupancy_monitoroccupant( var0, var2, var1 );
            var2 cancelreloading();
            
            if ( istrue( var2.tracking_max_health ) )
            {
                var2 notify( "br_try_armor_cancel" );
            }
            
            if ( isdefined( var19 ) )
            {
                var21 = ref_141df( var0, var19 );
                
                if ( istrue( var21 ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "stopChallengeTimer" ) )
                {
                    var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "stopChallengeTimer" ) ]]( "driving" );
                }
            }
            
            if ( isdefined( var1 ) )
            {
                var21 = ref_141df( var0, var1 );
                
                if ( istrue( var21 ) && !istrue( level.loadoutbrfieldupgrade ) )
                {
                    var22 = 0;
                    var23 = "";
                    var24 = "";
                    var25 = "";
                    var26 = "";
                    
                    switch ( var0.targetname )
                    {
                        case "apc_russian":
                            var23 = var2.ref_14238.apc;
                            var24 = var2.ref_14238.c4_pick_up_listener;
                            var22 = 1;
                            var25 = var2.ref_14238.c130airdrop_heightoverride;
                            break;
                        case "atv":
                            var23 = var2.ref_14238.check_cannot_spawn_tank;
                            var25 = var2.ref_14238.check_carrier_status;
                            var26 = var2.ref_14238.check_for_damage_scalar_change;
                            break;
                        case "cargo_truck_mg":
                        case "cargo_truck":
                            var23 = var2.ref_14238.get_extra_focus_fire_multipler;
                            var25 = var2.ref_14238.get_fake_digit_from_pool;
                            break;
                        case "jeep":
                            var23 = var2.ref_14238.vehicle_damage_endburndown;
                            var25 = var2.ref_14238.vehicle_damage_enginevisualclearcallback;
                            break;
                        case "little_bird_mg":
                        case "little_bird":
                            var23 = var2.ref_14238.x1opsenableelimination;
                            var25 = var2.ref_14238.x1opsendgame;
                            var26 = var2.ref_14238.zombieingas;
                            break;
                        case "tac_rover":
                            var23 = var2.ref_14238.ref_139f7;
                            var25 = var2.ref_14238.ref_139f8;
                            var26 = var2.ref_14238.ref_139fc;
                            break;
                        case "light_tank":
                            var23 = scripts\engine\utility::ter_op( isdefined( var0.spawndata.usealtmodel ), var2.ref_14238.ref_13a47, var2.ref_14238.ref_13a52 );
                            var24 = scripts\engine\utility::ter_op( isdefined( var0.spawndata.usealtmodel ), var2.ref_14238.ref_13a48, var2.ref_14238.ref_13a53 );
                            var22 = 1;
                            break;
                        case "motorcycle":
                            var23 = var2.ref_14238.ref_11d4d;
                            var25 = var2.ref_14238.ref_11d5f;
                            var26 = var2.ref_14238.ref_11d70;
                            break;
                        case "veh_a10fd":
                            var23 = var2.ref_14238.br_is_allowed_armor_insert;
                            var26 = var2.ref_14238.br_isplayerbeforeinitialinfildeploy;
                            break;
                        case "bomber":
                            var23 = var2.ref_14238.create_head_icon_for_crate;
                            var26 = var2.ref_14238.createjuggdroplocation;
                            break;
                        case "cargo_truck_susp_aa":
                        case "cargo_truck_susp":
                            var23 = "";
                            var25 = var2.ref_14238.get_fake_digit_from_pool;
                            break;
                        case "open_jeep":
                            var23 = "";
                            var25 = var2.ref_14238.vehicle_damage_enginevisualclearcallback;
                            break;
                        case "open_jeep_carpoc":
                            var23 = var2.ref_14238.‘õg?©»)-Øºã!žs£(ó;
                            var24 = var2.ref_14238.Œï¨ `c’»Y/'b§ï4sˆ>g›;
                            var22 = 1;
                            var25 = var2.ref_14238.…Œ§ß­_@ÐÑ`	ªJsyxþl/®û;
                            break;
                        default:
                            var23 = "";
                            var25 = "";
                            break;
                    }
                    
                    var0 setfacialindexfromasm( var25 );
                    
                    if ( var23 != "" && !isdefined( var0.gasfxair ) )
                    {
                        var0 setvehiclecamo();
                        var0 getmountconfigenabled( var23 );
                        
                        if ( var22 )
                        {
                            foreach ( var28 in var0.turrets )
                            {
                                var28 sendclientmatchdataforclient( var24 );
                                break;
                            }
                        }
                        
                        var0.ref_1426c = var26;
                        var0.gasfxair = 1;
                    }
                    
                    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "startChallengeTimer" ) )
                    {
                        var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "startChallengeTimer" ) ]]( "driving" );
                    }
                }
            }
            
            if ( !isdefined( var19 ) )
            {
                var30 = "ENTERED_VEHICLE";
            }
            else
            {
                var30 = "SEAT_SWITCH";
            }
            
            abilityleft::cleanuparenamolotovs( var1, var3, var2, var20 );
            scripts\cp_mp\vehicles\vehicle_dlog::ref_1418a( var1, var3, var2, var30 );
            return;
        }
        
        if ( isdefined( var20 ) && !istrue( var4.vehicledeath ) )
        {
            if ( istrue( var4.playerdeath ) || istrue( var4.playerlaststand ) || istrue( var4.playerdisconnect ) )
            {
                var31 = spawnstruct();
                var31.playerdeath = var4.playerdeath;
                var31.playerlaststand = var4.playerlaststand;
                var31.playerdisconnect = var4.playerdisconnect;
                thread vehicle_occupancy_exit( var1, var20, var3, var31, 1 );
                return;
            }
            
            vehicle_occupancy_reenter( var1, var20, var2, var3, var4 );
            return;
        }
        
        return;
    }
}

// Params 5
// Size: 0x18c
function vehicle_occupancy_exit( var0, var1, var2, var3, var4 )
{
    var5 = var1;
    
    if ( isdefined( var2 ) )
    {
        if ( !isdefined( var5 ) )
        {
            var5 = vehicle_occupancy_getoccupantseat( var0, var2 );
        }
        
        if ( !var2 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var4 = 1;
        }
        
        if ( istrue( var2.inlaststand ) )
        {
            var4 = 1;
        }
        
        vehicle_occupancy_stopmonitoringoccupant( var2 );
    }
    else
    {
        var4 = 1;
        vehicle_occupancy_purgedataforseatinstance( var0, var5 );
    }
    
    if ( istrue( var0.isdestroyed ) )
    {
        var4 = 1;
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = spawnstruct();
    }
    
    var3.immediate = istrue( var4 );
    var3.raceendnotify = "vehicle_race_last_call";
    var3.raceendon = "vehicle_race_finished";
    
    if ( !var3.immediate )
    {
        thread vehicle_occupancy_raceplayerdeathdisconnect( var2, var3 );
        thread vehicle_occupancy_racevehicledeath( var0, var3 );
        thread vehicle_occupancy_racecomplete( var5, undefined, var3 );
    }
    
    thread vehicle_occupancy_exitstart( var0, var5, undefined, var2, var3 );
    
    if ( !var3.immediate )
    {
        var3 waittill( var3.raceendnotify );
        waittillframeend();
        var3 notify( var3.raceendon );
    }
    
    var6 = vehicle_occupancy_raceresults( var0, var2, var5, undefined, var3 );
    thread vehicle_occupancy_exitend( var0, var5, undefined, var2, var3 );
    vehicle_occupancy_updatefull( var0 );
    vehicle_occupancy_updateempty( var0 );
    
    if ( !var6 )
    {
        if ( !istrue( var3.playerdeath ) && !istrue( var3.playerlaststand ) && !istrue( var3.playerdisconnect ) && !istrue( var3.vehicledeath ) )
        {
            vehicle_occupancy_reenter( var0, var5, undefined, var2, var3 );
            return;
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        var2 cancelreloading();
        var7 = ref_141df( var0, var5 );
        
        if ( istrue( var7 ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "challenges", "stopChallengeTimer" ) )
        {
            var2 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "challenges", "stopChallengeTimer" ) ]]( "driving" );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x45
function ref_141e2( var0, var1 )
{
    if ( level.teambased )
    {
        return ref_141e3( var0, var1.team );
    }
    
    if ( istrue( var0.playersetattractionoff ) )
    {
        ref_141c8( var0, var0 );
    }
    
    return isdefined( var0.ref_12564 ) && var0.ref_12564 == var1;
}

// Params 2
// Size: 0x45
function ref_141e0( var0, var1 )
{
    if ( level.teambased )
    {
        return ref_141e1( var0, var1.team );
    }
    
    if ( istrue( var0.playersetattractionoff ) )
    {
        ref_141c8( var0, var0 );
    }
    
    return isdefined( var0.ref_12564 ) && var0.ref_12564 != var1;
}

// Params 2
// Size: 0x3a
function ref_141e4( var0, var1 )
{
    if ( level.teambased )
    {
        return ref_141e5( var0, var1.team );
    }
    
    if ( istrue( var0.playersetattractionoff ) )
    {
        ref_141c8( var0, var0 );
    }
    
    return !isdefined( var0.ref_12564 );
}

// Params 1
// Size: 0x29
function ref_141d5( var0 )
{
    if ( !level.teambased )
    {
        if ( istrue( var0.playersetattractionoff ) )
        {
            ref_141c8( var0, var0 );
        }
        
        return var0.ref_12564;
    }
    
    return undefined;
}

// Params 2
// Size: 0x37
function ref_141e3( var0, var1 )
{
    if ( level.teambased )
    {
        if ( istrue( var0.playersetattractionoff ) )
        {
            ref_141c8( var0, var0 );
        }
        
        return ( isdefined( var0.ref_13aad ) && var0.ref_13aad == var1 );
    }
    
    return undefined;
}

// Params 2
// Size: 0x37
function ref_141e1( var0, var1 )
{
    if ( level.teambased )
    {
        if ( istrue( var0.playersetattractionoff ) )
        {
            ref_141c8( var0, var0 );
        }
        
        return ( isdefined( var0.ref_13aad ) && var0.ref_13aad != var1 );
    }
    
    return undefined;
}

// Params 2
// Size: 0x2c
function ref_141e5( var0, var1 )
{
    if ( level.teambased )
    {
        if ( istrue( var0.playersetattractionoff ) )
        {
            ref_141c8( var0, var0 );
        }
        
        return !isdefined( var0.ref_13aad );
    }
    
    return undefined;
}

// Params 1
// Size: 0x29
function ref_141d7( var0 )
{
    if ( level.teambased )
    {
        if ( istrue( var0.playersetattractionoff ) )
        {
            ref_141c8( var0, var0 );
        }
        
        return var0.ref_13aad;
    }
    
    return undefined;
}

// Params 1
// Size: 0x15
function ref_141f4( var0 )
{
    var0.playersetattractionoff = 1;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty( var0 );
}

// Params 1
// Size: 0x1b0
function ref_141c8( var0 )
{
    if ( level.teambased )
    {
        var1 = 0;
        var2 = var0.ref_13aad;
        
        if ( isdefined( var0.team ) && var0.team != "neutral" )
        {
            var0.ref_13aad = var0.team;
            var0.playersetattractionoff = undefined;
            var1 = 1;
        }
        
        if ( !var1 )
        {
            foreach ( var4 in var0.occupants )
            {
                if ( isdefined( var4 ) )
                {
                    var0.ref_13aad = var4.team;
                    var0.playersetattractionoff = undefined;
                    var1 = 1;
                    break;
                }
            }
        }
        
        if ( !var1 )
        {
            var0.ref_13aad = undefined;
            var0.playersetattractionoff = undefined;
        }
        
        if ( !isdefined( var2 ) && !isdefined( var0.ref_13aad ) )
        {
            return 0;
        }
        
        if ( isdefined( var2 ) && isdefined( var0.ref_13aad ) && var2 == var0.ref_13aad )
        {
            return 0;
        }
        
        ref_141d4( var0, var2, var0.ref_13aad );
        return 1;
    }
    
    var1 = 0;
    var6 = var2.ref_12564;
    
    if ( isdefined( var2.originalowner ) )
    {
        var2.ref_12564 = var2.originalowner;
        var2.playersetattractionoff = undefined;
        var1 = 1;
    }
    
    if ( !var1 )
    {
        var7 = vehicle_occupancy_getalloccupants( var2 );
        
        foreach ( var4 in var7 )
        {
            if ( isdefined( var4 ) )
            {
                var2.ref_12564 = var4;
                var2.playersetattractionoff = undefined;
                return;
            }
        }
    }
    
    if ( !isdefined( var6 ) && !isdefined( var2.ref_12564 ) )
    {
        return 0;
    }
    
    if ( isdefined( var6 ) && isdefined( var2.ref_12564 ) && var6 == var2.ref_12564 )
    {
        return 0;
    }
    
    ref_141d4( var2, var6, var2.ref_12564 );
    return 1;
}

// Params 3
// Size: 0x36
function ref_141d4( var0, var1, var2 )
{
    _calloutmarkerping_predicted_timeout::ref_14121( var0, var1, var2 );
    var3 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( !isdefined( var3.playersetattractionlocationindex ) )
    {
        return;
    }
    
    GscBinSkip1( 0x74, var3.playersetattractionlocationindex, var0, var1, var2 );
    // Unknown operator ( 0x74, iw8, PC )
}

// Params 2
// Size: 0x15
function vehicle_occupancy_setoriginalowner( var0, var1 )
{
    var0.originalowner = var1;
    vehicle_occupancy_updateowner( var0 );
}

// Params 4
// Size: 0x70
function vehicle_occupancy_setowner( var0, var1, var2, var3 )
{
    if ( !isdefined( var0.owners ) )
    {
        var0.owners = [];
    }
    else
    {
        vehicle_occupancy_clearowner( var0, var1 );
        var0.owners = scripts\engine\utility::array_removeundefined( var0.owners );
    }
    
    var0.owners[ var0.owners.size ] = var1;
    
    if ( isdefined( var3 ) && var3 == -1 )
    {
    }
    else
    {
        thread vehicle_occupancy_watchowner( var0, var1, var2, var3 );
    }
    
    vehicle_occupancy_updateowner( var0 );
}

// Params 1
// Size: 0x187
function vehicle_occupancy_updateowner( var0 )
{
    var0 notify( "vehicle_owner_update" );
    var1 = var0.owner;
    var2 = var0.ownerteam;
    var3 = undefined;
    
    if ( isdefined( var0.owners ) )
    {
        for ( var4 = var0.owners.size - 1; var4 >= 0 ; var4-- )
        {
            if ( vehicle_occupancy_isplayervalidowner( var0, var0.owners[ var4 ] ) )
            {
                var3 = var0.owners[ var4 ];
                break;
            }
        }
    }
    
    if ( !isdefined( var3 ) )
    {
        if ( vehicle_occupancy_isplayervalidowner( var0, var0.originalowner ) )
        {
            var3 = var0.originalowner;
        }
    }
    
    var0.owner = var3;
    var5 = 0;
    
    if ( isdefined( var3 ) || isdefined( var1 ) )
    {
        if ( !isdefined( var3 ) && isdefined( var1 ) )
        {
            var5 = 1;
        }
        else if ( isdefined( var3 ) && !isdefined( var1 ) )
        {
            var5 = 1;
        }
        else if ( var3 != var1 )
        {
            var5 = 1;
        }
    }
    
    var6 = 0;
    
    if ( isdefined( var3 ) )
    {
        if ( !isdefined( var2 ) || var2 != var3.team )
        {
            var6 = 1;
        }
        
        var0.ownerteam = var3.team;
        var0 setvehicleteam( var3.team );
        thread vehicle_occupancy_watchownerjoinedteam( var0, var3 );
    }
    else
    {
        if ( var5 )
        {
            var6 = 1;
        }
        
        var0.ownerteam = undefined;
    }
    
    if ( var5 )
    {
        if ( !level.teambased )
        {
            ref_141f4( var0 );
        }
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "updateOwner" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "updateOwner" ) ]]( var0 );
    }
    
    var7 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( isdefined( var7 ) && isdefined( var7.updateownercallback ) )
    {
        [[ var7.updateownercallback ]]( var0, var3, var5, var6 );
        return;
    }
}

// Params 2
// Size: 0x51
function vehicle_occupancy_clearowner( var0, var1 )
{
    var0 notify( "vehicle_clear_owner_" + var1 getentitynumber() );
    
    if ( isdefined( var0.owners ) )
    {
        var0.owners = scripts\engine\utility::array_remove( var0.owners, var1 );
    }
    
    if ( isdefined( var0.owner ) && var0.owner == var1 )
    {
        vehicle_occupancy_updateowner( var0 );
        return;
    }
}

// Params 2
// Size: 0x81
function vehicle_occupancy_setteam( var0, var1 )
{
    var2 = !isdefined( var0.team ) || var0.team != var1;
    var0.team = var1;
    
    if ( var0.classname == "script_vehicle" )
    {
        var0 setvehicleteam( var1 );
    }
    
    if ( var2 )
    {
        if ( level.teambased )
        {
            ref_141f4( var0 );
        }
    }
    
    var3 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( isdefined( var3 ) && isdefined( var3.updateteamcallback ) )
    {
        [[ var3.updateteamcallback ]]( var0, var1, var2 );
    }
    
    vehicle_occupancy_updateowner( var0 );
}

// Params 0
// Size: 0x64
function vehicle_occupancy_init()
{
    var0 = spawnstruct();
    level.vehicle.occupancy = var0;
    var0.vehicledata = [];
    var0.ref_13cea = getdvarint( "scr_transitionHideEnabled", 1 ) > 0;
    
    if ( var0.ref_13cea )
    {
        var0.ref_13ceb = 0;
        var0.ref_13cec = [];
    }
    
    vehicle_occupancy_initdebug();
    [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "init" ) ]]();
}

// Params 5
// Size: 0xce
function vehicle_occupancy_enterstart( var0, var1, var2, var3, var4 )
{
    var4 endon( var4.raceendon );
    var0.occupantsreserving[ var1 ] = var3;
    var3.ref_1425d = var0;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
    var5 = undefined;
    
    if ( var4.immediate )
    {
        var5 = gettime();
    }
    
    if ( isdefined( var4.enterstartwaitmsg ) )
    {
        var3 waittill( var4.enterstartwaitmsg );
    }
    
    vehicle_occupancy_deleteseatcorpse( var0, var1, 1 );
    
    if ( isdefined( var3 ) && var3 isthrowinggrenade() )
    {
        if ( !isdefined( var4.enterstartcomplete ) )
        {
            var4.enterstartcomplete = 1;
        }
        
        var4.success = 0;
        return;
    }
    
    var6 = vehicle_occupancy_getenterstartcallbackforseat( var0, var1 );
    
    if ( isdefined( var6 ) )
    {
        [[ var6 ]]( var0, var1, var2, var3, var4 );
    }
    
    if ( !isdefined( var4.enterstartcomplete ) )
    {
        var4.enterstartcomplete = 1;
    }
    
    if ( var4.immediate )
    {
        return;
    }
}

// Params 5
// Size: 0x5a
function vehicle_occupancy_exitstart( var0, var1, var2, var3, var4 )
{
    var4 endon( var4.raceendon );
    var5 = undefined;
    
    if ( var4.immediate )
    {
        var5 = gettime();
    }
    
    var6 = vehicle_occupancy_getexitstartcallbackforseat( var0, var1 );
    
    if ( isdefined( var6 ) )
    {
        [[ var6 ]]( var0, var1, var2, var3, var4 );
    }
    
    if ( !isdefined( var4.exitstartcomplete ) )
    {
        var4.exitstartcomplete = 1;
    }
    
    if ( var4.immediate )
    {
        return;
    }
}

// Params 5
// Size: 0x4b
function vehicle_occupancy_exitstartcallback( var0, var1, var2, var3, var4 )
{
    var4 endon( var4.raceendon );
    var5 = vehicle_occupancy_findplayerexit( var3, var0, var1, var2, var4 );
    
    if ( !var5 )
    {
        var4.exitstartcomplete = 0;
        ref_141d1( var3, 2 );
        
        if ( !istrue( var4.immediate ) )
        {
            waitframe();
            var4 notify( var4.raceendnotify );
            return;
        }
        
        return;
    }
}

// Params 5
// Size: 0x1b7
function vehicle_occupancy_enterend( var0, var1, var2, var3, var4 )
{
    if ( istrue( var4.success ) )
    {
        var0.occupants[ var1 ] = var3;
        var0.occupantsreserving[ var1 ] = undefined;
        var3.vehicle = var0;
        var3.ref_1425d = undefined;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "disableClassSwapAllowed" ) )
        {
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "disableClassSwapAllowed" ) ]]();
        }
        
        vehicle_occupancy_applyrestrictionstooccupant( var0, var1, var3, var4 );
        ref_141f9( var3, var0, var1 );
        vehicle_occupancy_hideoccupant( var0, var1, var3, var4 );
        vehicle_occupancy_applycameratooccupant( var0, var1, var2, var3, var4 );
        vehicle_occupancy_applydamagemodifiertooccupant( var0, var1, var3, var4 );
        ref_141db( var0, var1, var3, var4 );
        
        if ( !isdefined( var2 ) )
        {
            vehicle_occupancy_onentervehicle( var0, var1, var3, var4 );
        }
        
        var5 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var1 );
        
        if ( isdefined( var5.animtag ) && tolower( var5.animtag ) == tolower( "tag_seat_0" ) )
        {
            vehicle_occupancy_setowner( var0, var3, 1 );
        }
        
        if ( !isdefined( var2 ) )
        {
            var3 notify( "vehicle_enter" );
            
            if ( isdefined( var5.ref_12023 ) )
            {
                thread ref_141da( var3, var5, 1 );
            }
        }
        else
        {
            var3 notify( "vehicle_change_seat" );
            
            if ( isdefined( var5.ref_12023 ) )
            {
                thread ref_141da( var3, var5, 0 );
            }
        }
    }
    else
    {
        if ( isdefined( var3 ) )
        {
            var3.ref_1425d = undefined;
            var5 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var1 );
            
            if ( isdefined( var5.ref_13e92 ) )
            {
                vehicle_occupancy_taketurret( var3, var0, var5.ref_13e92, var4, 1 );
            }
            
            vehicle_occupancy_showoccupant( var0, var1, var3, var4, 1 );
        }
        
        if ( !istrue( var4.vehicledeath ) )
        {
            var0.occupantsreserving[ var1 ] = undefined;
        }
    }
    
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
    var6 = gettime();
    var7 = vehicle_occupancy_getenterendcallbackforseat( var0, var1 );
    
    if ( isdefined( var7 ) )
    {
        [[ var7 ]]( var0, var1, var2, var3, var4 );
    }
}

// Params 5
// Size: 0x13d
function vehicle_occupancy_exitend( var0, var1, var2, var3, var4 )
{
    if ( var4.success )
    {
        var0.occupants[ var1 ] = undefined;
        
        if ( isdefined( var3 ) )
        {
            var3 notify( "vehicle_seat_exit" );
            var5 = 0;
            
            if ( !isdefined( var2 ) )
            {
                var3.vehicle = undefined;
                var5 = 1;
            }
            
            vehicle_occupancy_removerestrictionsfromoccupant( var0, var1, var3, var4 );
            ref_141f9( var3, var0, var2 );
            vehicle_occupancy_showoccupant( var0, var1, var3, var4, var5 );
            vehicle_occupancy_removecamerafromoccupant( var0, var2, var3, var4 );
            vehicle_occupancy_removedamagemodifierfromoccupant( var0, var1, var3, var4 );
            ref_141f5( var0, var1, var3, var4 );
        }
        
        if ( !isdefined( var2 ) )
        {
            vehicle_occupancy_onexitvehicle( var0, var1, var3, var4 );
        }
        
        if ( !var0 scripts\common\vehicle_code::vehicle_is_stopped() && ref_141df( var0, var1 ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "br", "challengeEvaluator" ) )
            {
                var6 = spawnstruct();
                var6.onplayerkillednew = 1;
                var3 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "br", "challengeEvaluator" ) ]]( "br_mastery_ghostRideWhip", var6 );
            }
        }
    }
    
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty( var0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
    var7 = gettime();
    var8 = vehicle_occupancy_getexitendcallbackforseat( var0, var1 );
    
    if ( isdefined( var8 ) )
    {
        [[ var8 ]]( var0, var1, var2, var3, var4 );
    }
    
    if ( isdefined( var3 ) )
    {
        var3 usebuttondone();
        
        if ( !isdefined( var2 ) )
        {
            if ( isdefined( var3.ref_14277 ) )
            {
                var3.ref_14277 = undefined;
            }
            
            if ( isdefined( var3.ref_14276 ) )
            {
                var3.ref_14276 = undefined;
            }
        }
    }
}

// Params 5
// Size: 0x2e
function vehicle_occupancy_reenter( var0, var1, var2, var3, var4 )
{
    thread vehicle_occupancy_monitoroccupant( var0, var3, var1 );
    var5 = gettime();
    var6 = vehicle_occupancy_getreentercallbackforseat( var0, var1 );
    
    if ( isdefined( var6 ) )
    {
        [[ var6 ]]( var0, var1, var2, var3, var4 );
    }
}

// Params 0
// Size: 0xe
function vehicle_occupancy_getleveldata()
{
    return level.vehicle.occupancy;
}

// Params 3
// Size: 0xb6
function ref_141da( var0, var1, var2 )
{
    var3 = 5000;
    
    if ( istrue( var2 ) )
    {
        var0.ref_14277 = var1.ref_12023;
        GscBinSkip1( 0x74, scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "trySayLocalSound" ), var0, var1.ref_12023, undefined, 1 );
        // Unknown operator ( 0x74, iw8, PC )
    }
    
    if ( isdefined( var0.ref_14277 ) && isdefined( var0.ref_14276 ) && var0.ref_14277 != var1.ref_12023 && gettime() - var0.ref_14276 > var3 )
    {
        GscBinSkip1( 0x74, scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "trySayLocalSound" ), var0, var1.ref_12023 );
        // Unknown operator ( 0x74, iw8, PC )
    }
}

// Params 2
// Size: 0x17
function vehicle_occupancy_purgedataforseatinstance( var0, var1 )
{
    var0.occupants[ var1 ] = undefined;
    var0.occupantsreserving[ var1 ] = undefined;
}

// Params 4
// Size: 0x67
function vehicle_occupancy_onentervehicle( var0, var1, var2, var3 )
{
    ref_141f4( var0 );
    var0 scripts\cp_mp\vehicles\vehicle_spawn::ref_1421a();
    var2 setstance( "stand" );
    var2 scripts\common\utility::allow_array( vehicle_occupancy_getoccupantrestrictions(), 0 );
    thread ref_141f8( var2, var0, var1 );
    abilityleft::claymore_crate_use( var0, var2 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "onEnterVehicle", 1 ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "onEnterVehicle" ) ]]( var0, var1, var2, var3 );
        return;
    }
}

// Params 4
// Size: 0x11b
function vehicle_occupancy_onexitvehicle( var0, var1, var2, var3 )
{
    if ( !istrue( var3.playerdisconnect ) )
    {
        vehicle_occupancy_stopmovefeedbackforplayer( var2 );
        vehicle_occupancy_cleardamagefeedbackforplayer( var2 );
        
        if ( !istrue( var3.playerdeath ) )
        {
            if ( istrue( var3.playerlaststand ) )
            {
                var3.onprematchfadedone2 = "DEATH";
            }
            else if ( !isdefined( var3.onprematchfadedone2 ) )
            {
                var3.onprematchfadedone2 = "VOLUNTARY";
            }
            
            var2 scripts\common\utility::allow_array( vehicle_occupancy_getoccupantrestrictions(), 1 );
            thread scripts\cp_mp\vehicles\vehicle::ref_14203( var0, var2 );
        }
        else
        {
            var3.onprematchfadedone2 = "DEATH";
        }
        
        thread ref_141d9( var2, var3.playerdeath, var3.playerlaststand );
    }
    else
    {
        var3.onprematchfadedone2 = "DISCONNECT";
    }
    
    ref_141f4( var0 );
    
    if ( scripts\cp_mp\vehicles\vehicle_spawn::ref_14214() && var0.occupants.size == 0 )
    {
        var0 thread scripts\cp_mp\vehicles\vehicle_spawn::ref_1421d();
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "onExitVehicle", 1 ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "onExitVehicle" ) ]]( var0, var1, var2, var3 );
    }
    
    var2 notify( "player_vehicle_exit" );
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_exitevent( var0, var2, var1, var3.onprematchfadedone2 );
    abilityleft::claymore_forceclampangles( var0, var2, var1 );
}

// Params 1
// Size: 0x74
function vehicle_occupancy_updatefull( var0 )
{
    var1 = vehicle_occupancy_getavailablevehicleseats( var0 ).size <= 0;
    
    if ( var1 )
    {
        if ( !istrue( var0.isfull ) )
        {
            scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty( var0, "single" );
            scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
            var0.isfull = 1;
            return;
        }
        
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
        return;
    }
    
    if ( istrue( var0.isfull ) )
    {
        var0.isfull = undefined;
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty( var0, "single" );
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( var0 );
}

// Params 1
// Size: 0x5a
function vehicle_occupancy_updateempty( var0 )
{
    var1 = vehicle_occupancy_getavailablevehicleseats( var0 );
    var2 = vehicle_occupancy_getallvehicleseats( var0 );
    var3 = var1.size == var2.size;
    
    if ( !istrue( var0.isempty ) && var3 )
    {
        scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended( var0, 0 );
    }
    
    if ( istrue( var0.isempty ) && !var3 )
    {
        var4 = scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended( var0, 1, 0 );
    }
    
    var0.isempty = var3;
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getenterstartcallbackforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.enterstartcallback ), var3.enterstartcallback, var2.enterstartcallback );
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getenterendcallbackforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.enterendcallback ), var3.enterendcallback, var2.enterendcallback );
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getexitstartcallbackforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.exitstartcallback ), var3.exitstartcallback, var2.exitstartcallback );
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getexitendcallbackforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.exitendcallback ), var3.exitendcallback, var2.exitendcallback );
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getreentercallbackforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.reentercallback ), var3.reentercallback, var2.reentercallback );
}

// Params 4
// Size: 0x43
function vehicle_occupancy_applyrestrictionstooccupant( var0, var1, var2, var3 )
{
    if ( !vehicle_occupancy_movementisallowed( var0 ) )
    {
        if ( var1 == vehicle_occupancy_getdriverseat( var0 ) )
        {
            vehicle_occupancy_allowmovementplayer( var0, var2, 0, var1 );
        }
    }
    
    var4 = vehicle_occupancy_getrestrictionsforseat( var0, var1 );
    var2 scripts\common\utility::allow_array( var4, 0 );
    var2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons( "vehicle" );
}

// Params 4
// Size: 0x3d
function vehicle_occupancy_removerestrictionsfromoccupant( var0, var1, var2, var3 )
{
    if ( !istrue( var3.playerdeath ) )
    {
        vehicle_occupancy_allowmovementplayer( var0, var2, 1, undefined );
        var4 = vehicle_occupancy_getrestrictionsforseat( var0, var1 );
        var2 scripts\common\utility::allow_array( var4, 1 );
        var2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "vehicle" );
        return;
    }
}

// Params 0
// Size: 0x20
function ref_141dd()
{
    if ( !isdefined( level.spawn_deceleration ) )
    {
        level.spawn_deceleration = getdvarint( "scr_hideOccupantWithStack", 1 );
    }
    
    return level.spawn_deceleration;
}

// Params 4
// Size: 0x40
function vehicle_occupancy_hideoccupant( var0, var1, var2, var3 )
{
    if ( vehicle_shouldhideoccupantforseat( var0, var1 ) )
    {
        var2.nocorpse = 1;
        
        if ( ref_141dd() )
        {
            var2 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
        }
        else
        {
            var2 playerhide();
        }
        
        var2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons( "vehicle" );
        return;
    }
}

// Params 2
// Size: 0x67
function ref_141dc( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldata();
    
    if ( !var2.ref_13cea )
    {
        return;
    }
    
    var3 = var2.ref_13ceb;
    var2.ref_13ceb++;
    var0 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
    var2.ref_13cec[ var3 ] = var0;
    
    if ( !isdefined( var1.ref_13cec ) )
    {
        var1.ref_13cec = [];
    }
    
    var1.ref_13cec[ var3 ] = var0;
    var0 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons( "vehicle" );
    return var3;
}

// Params 3
// Size: 0x75
function ref_141f7( var0, var1, var2 )
{
    var3 = vehicle_occupancy_getleveldata();
    
    if ( !var3.ref_13cea )
    {
        return;
    }
    
    if ( istrue( var2 ) )
    {
        waitframe();
        waitframe();
    }
    
    if ( !var3.ref_13cea )
    {
        return;
    }
    
    if ( !isdefined( var3.ref_13cec[ var0 ] ) )
    {
        return;
    }
    
    var4 = var3.ref_13cec[ var0 ];
    
    if ( isdefined( var1 ) && isdefined( var1.ref_13cec ) )
    {
        var1.ref_13cec[ var0 ] = undefined;
    }
    
    if ( isdefined( var4 ) )
    {
        var4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
        var4 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "vehicle" );
        return;
    }
}

// Params 2
// Size: 0x78
function ref_141f6( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldata();
    
    if ( !var2.ref_13cea )
    {
        return;
    }
    
    if ( istrue( var1 ) )
    {
        waitframe();
        waitframe();
    }
    
    if ( !isdefined( var0.ref_13cec ) )
    {
        return;
    }
    
    foreach ( var4 in var0.ref_13cec )
    {
        if ( isdefined( var2.ref_13cec[ var5 ] ) )
        {
            var2.ref_13cec[ var5 ] = undefined;
            
            if ( isdefined( var4 ) )
            {
                var4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
            }
        }
    }
    
    var0.ref_13cec = undefined;
}

// Params 0
// Size: 0x47
function ref_141c9()
{
    var0 = vehicle_occupancy_getleveldata();
    
    if ( !var0.ref_13cea )
    {
        return;
    }
    
    foreach ( var2 in var0.ref_13cec )
    {
        if ( !isdefined( var2 ) )
        {
            var0.ref_13cec[ var3 ] = undefined;
        }
    }
}

// Params 5
// Size: 0x77
function vehicle_occupancy_showoccupant( var0, var1, var2, var3, var4 )
{
    if ( !istrue( var3.playerdeath ) )
    {
        var2.nocorpse = undefined;
    }
    
    if ( vehicle_shouldhideoccupantforseat( var0, var1 ) || istrue( var4 ) )
    {
        if ( ref_141dd() )
        {
            if ( istrue( var4 ) )
            {
                var2 scripts\cp_mp\utility\player_utility::ref_125d0();
                var2 playershow();
                var2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "vehicle" );
                return;
            }
            
            var2 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
            var2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "vehicle" );
            return;
        }
        
        var2 playershow();
        var2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs( "vehicle" );
        return;
    }
}

// Params 5
// Size: 0x37
function vehicle_occupancy_applycameratooccupant( var0, var1, var2, var3, var4 )
{
    var5 = vehicle_getcameraforseat( var0, var1 );
    
    if ( isdefined( var5 ) && var5 != "none" )
    {
        var6 = vehicle_getcameraforseat( var0, var2 );
        
        if ( var6 != var5 )
        {
            var3 cameraset( var5 );
            return;
        }
        
        return;
    }
}

// Params 4
// Size: 0x2e
function vehicle_occupancy_removecamerafromoccupant( var0, var1, var2, var3 )
{
    if ( isdefined( var1 ) )
    {
        var4 = vehicle_getcameraforseat( var0, var1 );
        
        if ( var4 == "none" )
        {
            var2 cameradefault();
            return;
        }
        
        return;
    }
    
    var2 cameradefault();
}

// Params 4
// Size: 0x39
function vehicle_occupancy_applydamagemodifiertooccupant( var0, var1, var2, var3 )
{
    var4 = vehicle_occupancy_getdamagemodifierforseat( var0, var1 );
    
    if ( isdefined( var4 ) && var4 != -1 )
    {
        var2 scripts\cp_mp\utility\damage_utility::adddamagemodifier( var0.vehiclename + "_" + var1, var4, 0, &vehicle_occupancy_damagemodifierignorefunc );
        return;
    }
}

// Params 4
// Size: 0x40
function vehicle_occupancy_removedamagemodifierfromoccupant( var0, var1, var2, var3 )
{
    if ( !istrue( var3.playerdeath ) )
    {
        var4 = vehicle_occupancy_getdamagemodifierforseat( var0, var1 );
        
        if ( isdefined( var4 ) && var4 != -1 )
        {
            var2 scripts\cp_mp\utility\damage_utility::removedamagemodifier( var0.vehiclename + "_" + var1, 0 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getrestrictionsforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.restrictions ), var3.restrictions, var2.restrictions );
}

// Params 2
// Size: 0x3d
function vehicle_shouldhideoccupantforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    
    if ( isdefined( var3.hideoccupant ) )
    {
        return istrue( var3.hideoccupant );
    }
    
    return istrue( var2.hideoccupant );
}

// Params 2
// Size: 0x77
function vehicle_getcameraforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( isdefined( var1 ) )
    {
        var3 = var2.seatdata[ var1 ];
        var4 = var2.camera;
        
        if ( isdefined( var3.camera ) )
        {
            var4 = var3.camera;
        }
        
        if ( isdefined( var3.animtag ) && tolower( var3.animtag ) == "tag_seat_0" )
        {
            var4 = "none";
        }
    }
    else
    {
        var4 = "none";
    }
    
    return var4;
}

// Params 2
// Size: 0x3a
function vehicle_occupancy_getdamagemodifierforseat( var0, var1 )
{
    var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var3 = var2.seatdata[ var1 ];
    return scripts\engine\utility::ter_op( isdefined( var3.damagemodifier ), var3.damagemodifier, var2.damagemodifier );
}

// Params 7
// Size: 0x4c, Type: bool
function vehicle_occupancy_damagemodifierignorefunc( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = scripts\cp_mp\utility\damage_utility::packdamagedata( var1, var2, var3, var5, var4, var0 );
    
    if ( var4 == "MOD_TRIGGER_HURT" )
    {
        return true;
    }
    
    if ( isdefined( var5 ) && var5.basename == "bomb_site_mp" )
    {
        return true;
    }
    
    if ( var2 scripts\cp_mp\utility\damage_utility::isstuckdamage( var7 ) )
    {
        return true;
    }
    
    return false;
}

// Params 3
// Size: 0x2c
function vehicle_occupancy_monitoroccupant( var0, var1, var2 )
{
    thread ref_141e8( var0, var1, var2 );
    thread vehicle_occupancy_monitorseatswitch( var0, var1, var2, 1 );
    thread vehicle_occupancy_monitorexit( var0, var1, var2 );
    thread ref_141e9( var0, var1, var2 );
}

// Params 1
// Size: 0x24
function vehicle_occupancy_stopmonitoringoccupant( var0 )
{
    var0 notify( "vehicle_occupancy_monitorControls" );
    var0 notify( "vehicle_occupancy_monitorSeatSwitch" );
    var0 notify( "vehicle_occupancy_monitorExit" );
    var0 notify( "vehicle_occupancy_monitorGameEnded" );
}

// Params 4
// Size: 0xd4
function vehicle_occupancy_monitorseatswitch( var0, var1, var2, var3 )
{
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var0 endon( "death" );
    var0 endon( "predeath" );
    level endon( "game_ended" );
    var1 notify( "vehicle_occupancy_monitorSeatSwitch" );
    var1 endon( "vehicle_occupancy_monitorSeatSwitch" );
    var4 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    
    if ( var4.seatdata.size <= 1 )
    {
        return;
    }
    
    var5 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var2 );
    
    if ( !isdefined( var5.seatswitcharray ) || var5.seatswitcharray.size <= 0 )
    {
        return;
    }
    
    if ( !isbot( var1 ) )
    {
        if ( var3 )
        {
            wait 0.2;
        }
        
        while ( var1 aicalcsuppressspot() )
        {
            waitframe();
        }
        
        while ( !var1 aicalcsuppressspot() )
        {
            waitframe();
        }
        
        var6 = vehicle_occupancy_getnextavailableseat( var0, var1, var2 );
        
        if ( isdefined( var6 ) )
        {
            thread vehicle_occupancy_enter( var0, var6, var1 );
        }
        
        ref_141d1( var1, 1 );
        thread vehicle_occupancy_monitorseatswitch( var0, var1, var2, 0 );
        return;
    }
}

// Params 3
// Size: 0x65
function vehicle_occupancy_getnextavailableseat( var0, var1, var2 )
{
    var3 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var2 );
    
    if ( !isdefined( var3.seatswitcharray ) || var3.seatswitcharray.size <= 0 )
    {
        return undefined;
    }
    
    foreach ( var5 in var3.seatswitcharray )
    {
        if ( vehicle_occupancy_seatisavailable( var0, var5, var1 ) )
        {
            return var5;
        }
    }
}

// Params 3
// Size: 0x77
function vehicle_occupancy_monitorexit( var0, var1, var2 )
{
    var1 notify( "vehicle_occupancy_monitorExit" );
    var1 endon( "vehicle_occupancy_monitorExit" );
    var0 endon( "death" );
    level endon( "game_ended" );
    vehicle_occupancy_monitorexitinternal( var0, var1, var2 );
    var3 = spawnstruct();
    
    if ( isdefined( var1 ) )
    {
        if ( !var1 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var3.playerdeath = 1;
        }
        
        if ( istrue( var1.inlaststand ) )
        {
            var3.playerlaststand = 1;
        }
    }
    else
    {
        var3.playerdisconnect = 1;
    }
    
    thread vehicle_occupancy_exit( var0, var2, var1, var3 );
}

// Params 3
// Size: 0x195
function vehicle_occupancy_monitorexitinternal( var0, var1, var2 )
{
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var3 = gettime() + 1000;
    var4 = 0;
    var1 setclientomnvar( "ui_veh_exit_button_holdtime", 0 );
    
    for ( ;; )
    {
        if ( !var1 usebuttonpressed() )
        {
            var4 = 1;
        }
        
        if ( var4 && gettime() >= var3 )
        {
            break;
        }
        
        waitframe();
    }
    
    var5 = level.framedurationseconds;
    var6 = getdvarint( "MQTOLLKKLQ", 250 ) / 1000;
    
    for ( ;; )
    {
        var7 = 0;
        var8 = var1 ismlgfreecamenabled();
        var9 = 0;
        var1 setclientomnvar( "ui_veh_exit_button_holdtime", 0 );
        var10 = isdefined( var0 ) && istrue( var0.loadandplayholoeffect );
        
        while ( var1 usebuttonpressed() )
        {
            var1 forcereloading();
            var1 startragdollfromvehicleimpact();
            var9 = 1;
            var7 += var5;
            var11 = var1 usinggamepad();
            var12 = var1 setvehiclehornsound();
            var13 = !var11 && !var12;
            var14 = !var11 && var12;
            var15 = var11 && var8 == 0;
            var16 = var11 && var8 > 0;
            var17 = var15 || var14;
            
            if ( var15 || var14 )
            {
                var1 setclientomnvar( "ui_veh_exit_button_holdtime", var7 / 0.3 );
            }
            
            if ( ( var17 && var7 > 0.3 || var13 ) && !var10 )
            {
                return;
            }
            else if ( var16 && var7 >= var6 )
            {
                var1 cancelreloading();
                var1 reloadbuttonpressed();
            }
            
            wait var5;
        }
        
        if ( var9 && var1 usinggamepad() && var8 > 0 && var7 < var6 && !var10 )
        {
            return;
        }
        else if ( var9 )
        {
            var1 cancelreloading();
            var1 reloadbuttonpressed();
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x5c
function ref_141d1( var0, var1 )
{
    var2 = undefined;
    
    switch ( var1 )
    {
        case 1:
            var2 = "VEHICLES/SEAT_SWITCH_OCCUPIED";
            break;
        case 2:
            var2 = "VEHICLES/CANNOT_EXIT";
            break;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
    {
        var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( var2 );
        return;
    }
}

// Params 3
// Size: 0x3d
function ref_141e9( var0, var1, var2 )
{
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var1 notify( "vehicle_occupancy_monitorGameEnded" );
    var1 endon( "vehicle_occupancy_monitorGameEnded" );
    
    if ( var2 == vehicle_occupancy_getdriverseat( var0 ) )
    {
        level waittill( "game_ended" );
        var1 allowmovement( 0 );
        return;
    }
}

// Params 3
// Size: 0xaa
function ref_141e8( var0, var1, var2 )
{
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var0 endon( "death" );
    level endon( "game_ended" );
    var1 notify( "vehicle_occupancy_monitorControls" );
    var1 endon( "vehicle_occupancy_monitorControls" );
    
    if ( scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427a( var1 ) )
    {
        return;
    }
    
    if ( true )
    {
        wait 1.5;
    }
    
    GscBinSkip4( 0x35, var0, var1, var2 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 1
// Size: 0x13
function ref_141d2( var0 )
{
    scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427b( var0 );
    var0 notify( "vehicle_occupancy_monitorControls" );
}

// Params 3
// Size: 0xaa
function ref_141ea( var0, var1, var2 )
{
    var3 = vehicle_occupancy_getdriverseat( var0 );
    
    if ( var2 == var3 )
    {
        var4 = var0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly();
        jumpiffalse(var4) LOC_00000081;
        
        for ( ;; )
        {
            var5 = var0 setstrafereverse( 0 );
            var6 = var0 setstrafereverse( 2 );
            var7 = var0 setstrafereverse( 1 );
            var8 = var0 setstrafereverse( 3 );
            
            if ( abs( var5 ) > 0 || abs( var6 ) > 0 || abs( var7 ) > 0 || abs( var8 ) > 0 )
            {
                ref_141d2( var1 );
            }
            
            wait 0.05;
        }
        
        return;
    }
}

// Params 4
// Size: 0x6d
function ref_141eb( var0, var1, var2, var3 )
{
    var4 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var2 );
    var5 = var4.ref_13e8a;
    
    if ( istrue( var3 ) )
    {
        var5 = var4.ref_13e8b;
    }
    
    if ( var0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() )
    {
        return;
    }
    
    if ( isdefined( var5 ) )
    {
        var6 = scripts\cp_mp\vehicles\vehicle::ref_14192( var0, var5 );
        
        if ( isdefined( var6 ) )
        {
            var6 scripts\engine\utility::ref_143a5( "turret_fire", "turret_reload" );
            ref_141d2( var1 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x75
function vehicle_occupancy_raceplayerdeathdisconnect( var0, var1 )
{
    var1 endon( var1.raceendon );
    var2 = var0 scripts\engine\utility::ref_143b5( "death", "disconnect", "last_stand_start" );
    
    if ( var2 == "death" )
    {
        var1.playerdeath = 1;
    }
    else if ( var2 == "disconnect" )
    {
        var1.playerdisconnect = 1;
    }
    else if ( var2 == "last_stand_start" )
    {
        var1.playerlaststand = 1;
    }
    
    var1 notify( var1.raceendnotify );
}

// Params 2
// Size: 0x2a
function vehicle_occupancy_racevehicledeath( var0, var1 )
{
    var1 endon( var1.raceendon );
    var0 waittill( "death" );
    var1.vehicledeath = 1;
    var1 notify( var1.raceendnotify );
}

// Params 5
// Size: 0x3e
function vehicle_occupancy_raceseatunavailable( var0, var1, var2, var3, var4 )
{
    var4 endon( var4.raceendon );
    
    while ( isdefined( var0 ) )
    {
        if ( !vehicle_occupancy_seatisavailable( var0, var2, var1 ) )
        {
            var4.seatunavailable = 1;
            var4 notify( var4.raceendnotify );
            break;
        }
        
        waitframe();
    }
}

// Params 3
// Size: 0x6d
function vehicle_occupancy_racecomplete( var0, var1, var2 )
{
    var2 endon( var2.raceendon );
    
    if ( isdefined( var0 ) && isdefined( var1 ) )
    {
        while ( !istrue( var2.enterstartcomplete ) || !istrue( var2.exitstartcomplete ) )
        {
            waitframe();
        }
    }
    else if ( isdefined( var0 ) )
    {
        while ( !istrue( var2.exitstartcomplete ) )
        {
            waitframe();
        }
    }
    else
    {
        while ( !istrue( var2.enterstartcomplete ) )
        {
            waitframe();
        }
    }
    
    var2 notify( var2.raceendnotify );
}

// Params 5
// Size: 0x123
function vehicle_occupancy_raceresults( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var4.success ) )
    {
        var4.success = 1;
    }
    
    if ( var4.immediate )
    {
        var4.playerdisconnect = scripts\engine\utility::ter_op( isdefined( var1 ), 0, 1 );
        
        if ( !var4.playerdisconnect )
        {
            var4.playerdeath = !var1 scripts\cp_mp\utility\player_utility::_isalive();
            var4.playerlaststand = istrue( var1.inlaststand );
        }
        
        var4.vehicledeath = istrue( var0.isdestroyed );
    }
    else if ( var4.success )
    {
        if ( isdefined( var2 ) && !istrue( var4.exitstartcomplete ) )
        {
            var4.success = 0;
        }
        
        if ( isdefined( var3 ) && !istrue( var4.enterstartcomplete ) )
        {
            var4.success = 0;
        }
        
        if ( istrue( var4.vehicledeath ) )
        {
            var4.success = 0;
        }
    }
    else
    {
        return 0;
    }
    
    if ( isdefined( var3 ) )
    {
        if ( istrue( var4.playerdeath ) || istrue( var4.playerlaststand ) || istrue( var4.playerdisconnect ) || istrue( var4.vehicledeath ) || istrue( var4.seatunavailable ) )
        {
            var4.success = 0;
        }
    }
    
    return var4.success;
}

// Params 4
// Size: 0x44
function vehicle_occupancy_watchowner( var0, var1, var2, var3 )
{
    var1 endon( "disconnect" );
    var0 endon( "death" );
    var0 endon( "vehicle_clear_owner_" + var1 getentitynumber() );
    
    if ( istrue( var2 ) )
    {
        var1 waittill( "vehicle_seat_exit" );
    }
    
    var4 = scripts\engine\utility::ter_op( isdefined( var3 ), var3, 20 );
    wait var4;
    thread vehicle_occupancy_clearowner( var0, var1 );
}

// Params 2
// Size: 0x32
function vehicle_occupancy_watchownerjoinedteam( var0, var1 )
{
    var1 endon( "disconnect" );
    var0 endon( "death" );
    var0 endon( "vehicle_owner_update" );
    var1 scripts\engine\utility::ref_143a5( "joined_team", "joined_spectators" );
    thread vehicle_occupancy_updateowner( var0 );
}

// Params 2
// Size: 0x65, Type: bool
function vehicle_occupancy_isplayervalidowner( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( var0.team ) )
    {
        if ( var0.team != "neutral" && var1.team != var0.team )
        {
            return false;
        }
    }
    else if ( isdefined( var0.originalowner ) )
    {
        if ( var1 != var0.originalowner )
        {
            return false;
        }
    }
    
    return true;
}

// Params 6
// Size: 0x2c8
function vehicle_occupancy_animateplayer( var0, var1, var2, var3, var4, var5 )
{
    thread vehicle_occupancy_stopanimatingplayer();
    self endon( "vehicle_occupancy_stopAnimatingPlayer" );
    var6 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var1 );
    
    if ( !isdefined( var6.animtag ) )
    {
        return;
    }
    
    var7 = spawn( "script_model", var0 gettagorigin( var6.animtag ) );
    var7.angles = var0 gettagangles( var6.animtag );
    var7 linkto( var0, var6.animtag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var7 setmodel( "viewhands_base_iw8" );
    var7 hide();
    self.animrig = var7;
    
    if ( isdefined( var4 ) || isdefined( var5 ) )
    {
        allowfultondropondeath( var4, var5 );
        thread allowleaderboardstatsupdates( 1 );
    }
    
    self animscriptentervehicle();
    
    if ( tolower( var6.animtag ) == "tag_seat_0" )
    {
        self vehicle_setstowedweaponvisibility( 0 );
        self vehicle_setheldweaponvisibility( 0 );
    }
    else if ( vehicle_shouldhideoccupantforseat( var0, var1 ) )
    {
        self vehicle_setstowedweaponvisibility( 0 );
        self vehicle_setheldweaponvisibility( 0 );
    }
    else
    {
        if ( istrue( var6.hidestowedweapon ) )
        {
            self vehicle_setstowedweaponvisibility( 0 );
        }
        
        if ( istrue( var6.hideheldweapon ) )
        {
            self vehicle_setheldweaponvisibility( 0 );
        }
    }
    
    if ( !isdefined( var6.ref_13e8a ) )
    {
        if ( !isdefined( var2 ) )
        {
            self setplayerangles( var7.angles * ( 0, 1, 0 ) );
        }
        else if ( tolower( var6.animtag ) == "tag_seat_0" )
        {
            self setplayerangles( var7.angles * ( 0, 1, 0 ) );
        }
    }
    
    self cancelmantle();
    var8 = undefined;
    var9 = istrue( var6.ref_1409c );
    
    if ( istrue( var8 ) )
    {
        self playerlinktodelta( var7, "tag_player", 0, getdvarfloat( "scr_vehicleViewClampOverrideRight", 180 ), getdvarfloat( "scr_vehicleViewClampOverrideLeft", 180 ), getdvarfloat( "scr_vehicleViewClampOverrideTop", 180 ), getdvarfloat( "scr_vehicleViewClampOverrideBottom", 180 ), var9, 1, 0 );
    }
    else if ( var6.viewclamps.size > 0 )
    {
        self playerlinktodelta( var7, "tag_player", 0, var6.viewclamps[ "right" ], var6.viewclamps[ "left" ], var6.viewclamps[ "top" ], var6.viewclamps[ "bottom" ], var9, 1, 0 );
    }
    else
    {
        self playerlinktodelta( var7, "tag_player", 0, 180, 180, 180, 180, var9, 1, 0 );
    }
    
    if ( istrue( var6.ref_145e0 ) )
    {
        self.animrig.ref_145e0 = 1;
        self setworldupreference( var0 );
    }
    
    var10 = vehicle_occupancy_getanimbasename( var0.vehiclename, var1 );
    
    if ( vehicle_occupancy_checkvalidanimtype( var10, var3 ) )
    {
        self.animname = var10;
        var7.animname = var10;
        var7 useanimtree( level.scr_animtree[ var10 ] );
        vehicle_occupancy_watchplayeranimate( var0, var3, var6.animtag );
    }
    else
    {
        scripts\engine\utility::ref_143a5( "death_or_disconnect", "last_stand_start" );
    }
    
    if ( isdefined( self ) )
    {
        thread vehicle_occupancy_stopanimatingplayer();
    }
    
    var7 delete();
}

// Params 3
// Size: 0x32
function vehicle_occupancy_watchplayeranimate( var0, var1, var2 )
{
    self endon( "death_or_disconnect" );
    self endon( "last_stand_start" );
    
    for ( ;; )
    {
        var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "anim", "player_solo" ) ]]( self, self.animrig, var1, var2 );
    }
}

// Params 0
// Size: 0x50
function vehicle_occupancy_stopanimatingplayer()
{
    if ( !isdefined( self.animrig ) )
    {
        return;
    }
    
    self notify( "vehicle_occupancy_stopAnimatingPlayer" );
    self vehicle_setstowedweaponvisibility( 1 );
    self vehicle_setheldweaponvisibility( 1 );
    self animscriptexitvehicle();
    self stopanimscriptsceneevent();
    
    if ( istrue( self.animrig.ref_145e0 ) )
    {
        self setworldupreference( undefined );
    }
    
    self.animname = undefined;
    self.animrig delete();
}

// Params 2
// Size: 0x14
function allowfultondropondeath( var0, var1 )
{
    self notify( "OverrideVehicleSeatAnimConditionals" );
    self overridevehicleseatanimconditionals( var0, var1 );
}

// Params 1
// Size: 0x2b
function allowleaderboardstatsupdates( var0 )
{
    self endon( "death_or_disconnect" );
    self notify( "OverrideVehicleSeatAnimConditionals" );
    self endon( "OverrideVehicleSeatAnimConditionals" );
    
    if ( istrue( var0 ) )
    {
        waitframe();
    }
    
    self overridevehicleseatanimconditionals( "", 0 );
}

// Params 2
// Size: 0x1d, Type: bool
function vehicle_occupancy_checkvalidanimtype( var0, var1 )
{
    if ( !isdefined( level.scr_anim[ var0 ] ) )
    {
        return false;
    }
    
    return isdefined( level.scr_anim[ var0 ][ var1 ] );
}

// Params 2
// Size: 0xf
function vehicle_occupancy_getanimbasename( var0, var1 )
{
    return var0 + "_" + var1;
}

// Params 2
// Size: 0xfe
function vehicle_occupancy_allowmovement( var0, var1 )
{
    if ( var1 )
    {
        var0.movementdisabled--;
        
        if ( var0.movementdisabled == 0 )
        {
            if ( isdefined( var0.occupants ) )
            {
                scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "movementDisabled", var0.occupants, var0.vehiclename );
                
                foreach ( var4, var3 in var0.occupants )
                {
                    vehicle_occupancy_allowmovementplayer( var0, var3, 1, var4 );
                }
            }
            
            return 1;
        }
        
        return;
    }
    
    if ( !isdefined( var0.movementdisabled ) )
    {
        var0.movementdisabled = 0;
    }
    
    var0.movementdisabled++;
    
    if ( var0.movementdisabled == 1 )
    {
        if ( isdefined( var0.occupants ) )
        {
            scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "movementDisabled", var0.occupants, var0.vehiclename );
            
            foreach ( var3 in var0.occupants )
            {
                vehicle_occupancy_allowmovementplayer( var0, var3, 0, var4 );
            }
        }
        
        return 0;
    }
}

// Params 1
// Size: 0x44
function vehicle_occupancy_clearallowmovement( var0 )
{
    if ( isdefined( self.occupants ) )
    {
        foreach ( var2 in self.occupants )
        {
            vehicle_occupancy_allowmovementplayer( 1, var2, var3 );
        }
    }
    
    var0.movementdisabled = undefined;
}

// Params 4
// Size: 0x85
function vehicle_occupancy_allowmovementplayer( var0, var1, var2, var3 )
{
    if ( var2 )
    {
        if ( istrue( var1.vehicledisabledmovement ) )
        {
            if ( var1 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                var1 scripts\common\utility::allow_movement( 1 );
            }
            
            var1.vehicledisabledmovement = undefined;
            return;
        }
        
        return;
    }
    
    var4 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var3 );
    
    if ( isdefined( var4.animtag ) && var4.animtag == "tag_seat_0" )
    {
        if ( !istrue( var1.vehicledisabledmovement ) )
        {
            if ( var1 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                var1 scripts\common\utility::allow_movement( 0 );
                var1.vehicledisabledmovement = 1;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x27
function ref_141ca( var0, var1 )
{
    if ( !istrue( var1 ) && istrue( var0.vehicledisabledmovement ) )
    {
        var0 scripts\common\utility::allow_movement( 1 );
    }
    
    var0.vehicledisabledmovement = undefined;
}

// Params 1
// Size: 0x1a, Type: bool
function vehicle_occupancy_movementisallowed( var0 )
{
    return !isdefined( var0.movementdisabled ) || var0.movementdisabled <= 0;
}

// Params 5
// Size: 0xd4
function vehicle_occupancy_getexitpositionandangles( var0, var1, var2, var3, var4 )
{
    var5 = vehicle_occupancy_getexitboundinginfo( var0 );
    var6 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var2 );
    var7 = [];
    
    foreach ( var9 in var6.exitids )
    {
        var10 = vehicle_occupancy_getexitposition( var0, var1, var9, var5, var3 );
        
        if ( isdefined( var10 ) )
        {
            var7 = var10;
            var11 = undefined;
            
            if ( !isdefined( var6.animtag ) || var6.animtag != "tag_seat_0" )
            {
                var11 = vehicle_occupancy_getexitangles( var0, var1, var9, var4 );
            }
            
            if ( isdefined( var0.vehiclename ) && ( var0.vehiclename == "veh_a10fd" || var0.vehiclename == "veh_bt" ) )
            {
                var11 = ( 0, var0.angles[ 1 ], 0 );
            }
            
            var7 = var11;
            return var7;
        }
    }
    
    var9 = undefined;
    var11 = undefined;
    return undefined;
}

// Params 5
// Size: 0x5a0
function vehicle_occupancy_getexitposition( var0, var1, var2, var3, var4 )
{
    if ( istrue( var3.exitsfailed[ var2 ] ) )
    {
        return undefined;
    }
    
    if ( isdefined( var3.exitpositions[ var2 ] ) )
    {
        return var3.exitpositions[ var2 ];
    }
    
    var5 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var6 = var5.exitoffsets[ var2 ];
    var7 = var5.exitdirections[ var2 ];
    
    if ( !isdefined( var6 ) )
    {
        var6 = ( 0, 0, 0 );
    }
    
    var8 = [ "physicscontents_solid", "physicscontents_item", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip" ];
    
    if ( getdvarint( "scr_vehicleExitWater", 1 ) == 0 )
    {
        GscBinSkip0( 0x2e, var8.size, "physicscontents_water" );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    var9 = physics_createcontents( var8 );
    var10 = var0 getlinkedchildren( 1 );
    
    if ( !isdefined( var10 ) )
    {
        var10 = [];
    }
    
    GscBinSkip0( 0x2e, var10.size, var0 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x3ba
function vehicle_occupancy_getexitboundinginfo( var0 )
{
    var1 = undefined;
    
    if ( isdefined( var0.exitboundinginfo ) && var0.exitboundinginfo.timestamp == gettime() )
    {
        var1 = var0.exitboundinginfo;
    }
    else
    {
        var2 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
        
        if ( isdefined( var2 ) && isdefined( var2.exitextents ) )
        {
            var3 = rotatevector( ( var2.exitextents[ "front" ], var2.exitextents[ "left" ] * -1, var2.exitextents[ "top" ] ), var0.angles );
            var4 = rotatevector( ( var2.exitextents[ "front" ], var2.exitextents[ "right" ], var2.exitextents[ "top" ] ), var0.angles );
            var5 = rotatevector( ( var2.exitextents[ "back" ] * -1, var2.exitextents[ "left" ] * -1, var2.exitextents[ "top" ] ), var0.angles );
            var6 = rotatevector( ( var2.exitextents[ "back" ] * -1, var2.exitextents[ "right" ], var2.exitextents[ "top" ] ), var0.angles );
            var7 = rotatevector( ( var2.exitextents[ "front" ], var2.exitextents[ "left" ] * -1, var2.exitextents[ "bottom" ] * -1 ), var0.angles );
            var8 = rotatevector( ( var2.exitextents[ "front" ], var2.exitextents[ "right" ], var2.exitextents[ "bottom" ] * -1 ), var0.angles );
            var9 = rotatevector( ( var2.exitextents[ "back" ] * -1, var2.exitextents[ "left" ] * -1, var2.exitextents[ "bottom" ] * -1 ), var0.angles );
            var10 = rotatevector( ( var2.exitextents[ "back" ] * -1, var2.exitextents[ "right" ], var2.exitextents[ "bottom" ] * -1 ), var0.angles );
            var11 = [ var3, var4, var5, var6, var7, var8, var9, var10 ];
            var12 = -99999;
            var13 = 99999;
            var14 = -99999;
            var15 = 99999;
            var16 = -99999;
            var17 = 99999;
            var18 = ( 0, var0.angles[ 1 ], 0 );
            
            foreach ( var20 in var11 )
            {
                var20 = rotatevectorinverted( var20, var18 );
                
                if ( var20[ 0 ] > var12 )
                {
                    var12 = var20[ 0 ];
                }
                
                if ( var20[ 0 ] < var13 )
                {
                    var13 = var20[ 0 ];
                }
                
                if ( var20[ 1 ] < var15 )
                {
                    var15 = var20[ 1 ];
                }
                
                if ( var20[ 1 ] > var14 )
                {
                    var14 = var20[ 1 ];
                }
                
                if ( var20[ 2 ] > var16 )
                {
                    var16 = var20[ 2 ];
                }
                
                if ( var20[ 2 ] < var17 )
                {
                    var17 = var20[ 2 ];
                }
            }
            
            var1 = spawnstruct();
            var0.exitboundinginfo = var1;
            var1 = var1;
            var1.vehicle = var0;
            var1.timestamp = gettime();
            var1.offsets[ "front" ] = var12;
            var1.offsets[ "back" ] = var13;
            var1.offsets[ "left" ] = var14;
            var1.offsets[ "right" ] = var15;
            var1.offsets[ "top" ] = var16;
            var1.offsets[ "bottom" ] = var17;
            var1.exitsfailed = [];
            var1.exitpositions = [];
            var1.orientedboxpoints = [];
            var1.unorientedboxpoints = [];
            var1.flipleftright = abs( angleclamp180( var0.angles[ 2 ] ) ) > 90;
            thread vehicle_cleanupexitboundinginfo();
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x43
function vehicle_cleanupexitboundinginfo()
{
    waitframe();
    
    if ( isdefined( self.vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( self.vehicle.exitboundinginfo ) )
    {
        return;
    }
    
    if ( self.vehicle.exitboundinginfo.timestamp != self.timestamp )
    {
        return;
    }
    
    self.vehicle.exitboundinginfo = undefined;
}

// Params 4
// Size: 0x1c2
function vehicle_occupancy_getexitangles( var0, var1, var2, var3 )
{
    if ( istrue( level.playerlocationtriggerexit ) )
    {
        var4 = ( 0, var0.angles[ 1 ], 0 );
        return var4;
    }
    
    var5 = vehicle_occupancy_getleveldataforvehicle( var1.vehiclename );
    var6 = vehicle_occupancy_getexitboundinginfo( var1 );
    var7 = var6.exitpositions[ var3 ];
    var8 = undefined;
    var9 = 0;
    
    if ( istrue( var4 ) )
    {
        var8 = var1.origin + rotatevector( var5.exitoffsets[ var3 ], var1.angles );
        var9 = 1;
    }
    
    if ( !isdefined( var8 ) )
    {
        var8 = var2 getvieworigin() + anglestoforward( var2 getplayerangles() ) * 550;
    }
    
    var10 = undefined;
    
    if ( istrue( var4 ) )
    {
        var10 = var7 + ( 0, 0, 22 );
    }
    else
    {
        var10 = var7 + ( 0, 0, 60 );
    }
    
    var11 = vectornormalize( var8 - var10 );
    
    if ( !var9 )
    {
        var12 = physics_createcontents( [ "physicscontents_vehicle", "physicscontents_item" ] );
        var13 = physics_raycast( var10, var10 + var11 * 300, var12, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( var13 ) && var13.size > 0 )
        {
            var14 = var13[ 0 ][ "entity" ];
            var15 = 0;
            
            if ( isdefined( var14 ) )
            {
                var16 = var1 getlinkedchildren( 1 );
                
                if ( !isdefined( var16 ) )
                {
                    var16 = [];
                }
                
                GscBinSkip0( 0x2e, var16.size, var1 );
                // Unknown operator ( 0x2e, iw8, PC )
            }
            
            if ( var16 )
            {
                var20 = var6.exitdirections[ var4 ];
                var4 = ( 0, var2.angles[ 1 ], 0 );
                
                if ( var20 == "left" || var20 == "right" )
                {
                    var21 = anglestoright( var4 );
                }
                else
                {
                    var21 = anglestoforward( var21 );
                }
                
                var13 -= var21 * vectordot( var13, var21 );
            }
        }
    }
    
    var22 = vectortoangles( var13 );
    var22 = ( clamp( var22[ 0 ], -12, 12 ), var22[ 1 ], 0 );
    return var22;
}

// Params 3
// Size: 0xed
function vehicle_occupancy_getfallbackexitpositionandangles( var0, var1, var2 )
{
    var3 = vectordot( ( 0, 0, 1 ), anglestoup( var0.angles ) ) < 0;
    var4 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var5 = undefined;
    var6 = undefined;
    
    if ( var3 )
    {
        if ( !isdefined( var4.exitfallbackoffsetinverted ) )
        {
            return undefined;
        }
        
        var5 = var4.exitfallbackoffsetinverted;
        var6 = anglestoup( var0.angles ) * -1;
    }
    else
    {
        if ( !isdefined( var4.exitfallbackoffset ) )
        {
            return undefined;
        }
        
        var5 = var4.exitfallbackoffset;
        var6 = anglestoup( var0.angles );
    }
    
    var7 = vehicle_occupancy_getexitcastcontents();
    var8 = vehicle_occupancy_getexitcastignorelist( var0 );
    var9 = var0.origin + var6 * var5;
    var10 = physics_getclosestpointtocapsule( var9, 16, 36, ( 0, 0, 0 ), 0, var7, var8, "physicsquery_closest" );
    
    if ( !isdefined( var10 ) || var10.size <= 0 )
    {
        return [ var9, var0.angles * ( 0, 1, 0 ) ];
    }
    
    return undefined;
}

// Params 5
// Size: 0xce
function vehicle_occupancy_findplayerexit( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) || isdefined( var3 ) || istrue( var4.playerdeath ) && !istrue( var4.playerlaststand ) )
    {
        return 1;
    }
    
    var5 = vehicle_occupancy_getleveldataforvehicle( var1.vehiclename );
    var6 = istrue( var5.allowairexit ) || istrue( var4.allowairexit ) || !var1 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !var1 vehicle_isonground();
    var7 = vehicle_occupancy_getexitpositionandangles( var1, var0, var2, var6, var4.playerlaststand );
    
    if ( isdefined( var7 ) )
    {
        var4.exitposition = var7[ 0 ];
        var4.exitangles = var7[ 1 ];
        return 1;
    }
    
    if ( istrue( var5.onprematchstarted2 ) )
    {
        var8 = var1 physics_getentitycenterofmass();
        var9 = var0 getboundsmidpoint();
        var4.exitposition = var8[ "unscaled" ] - var9;
        var4.exitangles = undefined;
        return 1;
    }
    
    return 0;
}

// Params 3
// Size: 0x79
function vehicle_occupancy_moveplayertoexit( var0, var1, var2 )
{
    if ( !isdefined( var0 ) || istrue( var2.playerdeath ) && !istrue( var2.playerlaststand ) || isdefined( var1 ) )
    {
        return 1;
    }
    
    if ( isdefined( var2.exitposition ) )
    {
        var0 unlink();
        var0 dontinterpolate();
        var0 setorigin( var2.exitposition, 1, 1 );
        var0 setstance( "stand" );
        
        if ( isdefined( var2.exitangles ) )
        {
            var0 setplayerangles( var2.exitangles );
        }
        
        return 1;
    }
    
    return 0;
}

// Params 0
// Size: 0x31
function vehicle_occupancy_getexitcastcontents()
{
    return physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_playerclip" ] );
}

// Params 1
// Size: 0x2f
function vehicle_occupancy_getexitcastignorelist( var0 )
{
    var1 = vehicle_occupancy_getleveldataforvehicle( var0.vehiclename );
    var2 = [ var0 ];
    
    if ( isdefined( var1.exitignorelistcallback ) )
    {
        var2 = [[ var1.exitignorelistcallback ]]( var0 );
    }
    
    return var2;
}

// Params 1
// Size: 0x1b
function vehicle_occupancy_animtagtoexittag( var0 )
{
    var0 = tolower( var0 );
    var1 = getsubstr( var0, 8, var0.size );
    return "tag_seat_exit" + var1;
}

// Params 1
// Size: 0x16
function vehicle_occupancy_watchmovefeedback( var0 )
{
    self endon( "death" );
    
    for ( ;; )
    {
        vehicle_occupancy_updatemovefeedback( var0 );
        waitframe();
    }
}

// Params 1
// Size: 0xd0
function vehicle_occupancy_updatemovefeedback( var0 )
{
    var1 = vehicle_occupancy_getseatoccupant( self, var0 );
    var2 = vehicle_occupancy_getalloccupants( self );
    
    if ( isdefined( var1 ) )
    {
        var3 = var1 getnormalizedmovement()[ 0 ];
        jumpiffalse(abs( var3 ) > 0.15) LOC_00000062;
        
        foreach ( var5 in var2 )
        {
            if ( var5 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                vehicle_occupancy_startmovefeedbackforplayer( var5 );
            }
        }
        
        return;
    }
    
    if ( isdefined( var5 ) )
    {
        foreach ( var5 in var5 )
        {
            if ( var5 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                vehicle_occupancy_stopmovefeedbackforplayer( var5 );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x23
function vehicle_occupancy_startmovefeedbackforplayer()
{
    if ( istrue( self.vehiclemoveshakeenabled ) )
    {
        return;
    }
    
    self.vehiclemoveshakeenabled = 1;
    self setscriptablepartstate( "vehicleMoveShake", "active1", 0 );
}

// Params 0
// Size: 0x22
function vehicle_occupancy_stopmovefeedbackforplayer()
{
    if ( !istrue( self.vehiclemoveshakeenabled ) )
    {
        return;
    }
    
    self.vehiclemoveshakeenabled = undefined;
    self setscriptablepartstate( "vehicleMoveShake", "neutral", 0 );
}

// Params 1
// Size: 0x1b7
function vehicle_occupancy_updatedamagefeedback( var0 )
{
    var1 = vehicle_occupancy_getleveldataforvehicle( self.vehiclename );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isdefined( var0.damage ) || var0.damage <= 0 )
    {
        return;
    }
    
    if ( !isdefined( var0.meansofdeath ) )
    {
        return;
    }
    
    var2 = undefined;
    var3 = undefined;
    
    switch ( var0.meansofdeath )
    {
        case "MOD_EXPLOSIVE_BULLET":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE":
        case "MOD_PISTOL_BULLET":
        case "MOD_RIFLE_BULLET":
            var2 = "light";
            var3 = var1.damagefeedbackgrouplight;
            break;
        case "MOD_EXPLOSIVE":
        case "MOD_PROJECTILE_SPLASH":
        case "MOD_IMPACT":
            var2 = "heavy";
            var3 = var1.damagefeedbackgroupheavy;
            break;
    }
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    if ( !isdefined( var3 ) || var3 == "none" )
    {
        return;
    }
    
    var4 = [];
    
    if ( var3 == "driver" )
    {
        foreach ( var6 in var1.seatdata )
        {
            if ( !isdefined( var6.animtag ) )
            {
                continue;
            }
            
            if ( var6.animtag == "tag_seat_0" )
            {
                var4 = [ vehicle_occupancy_getseatoccupant( self, var7 ) ];
                break;
            }
        }
    }
    else if ( var3 == "all" )
    {
        var4 = vehicle_occupancy_getalloccupants( self );
    }
    
    if ( !isdefined( var4 ) || var4.size == 0 )
    {
        return;
    }
    
    foreach ( var9 in var4 )
    {
        if ( !isdefined( var9 ) )
        {
            continue;
        }
        
        if ( !var9 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        if ( var2 == "light" )
        {
            thread vehicle_occupancy_lightdamagefeedbackforplayer();
            continue;
        }
        
        if ( var2 == "heavy" )
        {
            thread vehicle_occupancy_heavydamagefeedbackforplayer();
        }
    }
}

// Params 0
// Size: 0x59
function vehicle_occupancy_lightdamagefeedbackforplayer()
{
    self endon( "disconnect" );
    self endon( "vehicle_occupancy_clearLightDamageFeedbackPlayer" );
    
    if ( !isdefined( self.vehiclelightdamagefeedbackid ) )
    {
        self.vehiclelightdamagefeedbackid = 1;
    }
    
    self setscriptablepartstate( "vehicleDamageShakeLight", "active" + self.vehiclelightdamagefeedbackid, 0 );
    self.vehiclelightdamagefeedbackid = 1 + scripts\engine\utility::mod( self.vehiclelightdamagefeedbackid + 1, 3 );
    wait 0.15;
    thread vehicle_occupancy_clearlightdamagefeedbackplayer();
}

// Params 0
// Size: 0x20
function vehicle_occupancy_clearlightdamagefeedbackplayer()
{
    self notify( "vehicle_occupancy_clearLightDamageFeedbackPlayer" );
    self setscriptablepartstate( "vehicleDamageShakeLight", "neutral", 0 );
    self.vehiclelightdamagefeedbackid = undefined;
}

// Params 0
// Size: 0x59
function vehicle_occupancy_heavydamagefeedbackforplayer()
{
    self endon( "disconnect" );
    self endon( "vehicle_occupancy_clearHeavyDamageFeedbackPlayer" );
    
    if ( !isdefined( self.vehicleheavydamagefeedbackid ) )
    {
        self.vehicleheavydamagefeedbackid = 1;
    }
    
    self setscriptablepartstate( "vehicleDamageShakeHeavy", "active" + self.vehicleheavydamagefeedbackid, 0 );
    self.vehicleheavydamagefeedbackid = 1 + scripts\engine\utility::mod( self.vehicleheavydamagefeedbackid + 1, 3 );
    wait 0.3;
    thread vehicle_occupancy_clearheavydamagefeedbackplayer();
}

// Params 0
// Size: 0x20
function vehicle_occupancy_clearheavydamagefeedbackplayer()
{
    self notify( "vehicle_occupancy_clearHeavyDamageFeedbackPlayer" );
    self setscriptablepartstate( "vehicleDamageShakeHeavy", "neutral", 0 );
    self.vehicleheavydamagefeedbackid = undefined;
}

// Params 0
// Size: 0xc
function vehicle_occupancy_cleardamagefeedbackforplayer()
{
    vehicle_occupancy_clearlightdamagefeedbackplayer();
    vehicle_occupancy_clearheavydamagefeedbackplayer();
}

// Params 4
// Size: 0x8f
function vehicle_occupancy_giveturret( var0, var1, var2, var3 )
{
    if ( isdefined( var2.raceendon ) )
    {
        var2 endon( var2.raceendon );
    }
    
    if ( istrue( var3 ) )
    {
        GscBinSkip4( 0x35, var2, 1.5 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    if ( !var0 hasweapon( var1 ) )
    {
        var0 scripts\cp_mp\utility\inventory_utility::_giveweapon( var1 );
    }
    
    var4 = undefined;
    
    if ( var0 scripts\cp_mp\utility\inventory_utility::iscurrentweapon( var1 ) )
    {
        var4 = 1;
    }
    else
    {
        thread ref_141d3( var0, var2 );
        var4 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var1, 1, 1 );
    }
    
    ref_141cb( var0 );
    
    if ( isdefined( var2 ) && isdefined( var4 ) && !var4 )
    {
        var2.success = 0;
        var2 notify( var2.raceendnotify );
        return;
    }
}

// Params 6
// Size: 0xe9
function vehicle_occupancy_taketurret( var0, var1, var2, var3, var4, var5 )
{
    if ( isdefined( var3.raceendon ) )
    {
        var3 endon( var3.raceendon );
    }
    
    if ( istrue( var4 ) )
    {
        GscBinSkip4( 0x35, var3, 1.5 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    if ( var0 hasweapon( var2 ) )
    {
        var6 = undefined;
        thread ref_141cb( var0 );
        
        if ( var0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var2 ) )
        {
            var0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( getcompleteweaponname( var2 ) );
            var6 = 1;
        }
        else
        {
            if ( isdefined( var5 ) )
            {
                var7 = scripts\cp_mp\vehicles\vehicle::ref_14191( var1, var5 );
            }
            else
            {
                var7 = scripts\cp_mp\vehicles\vehicle::ref_14192( var2, var3 );
            }
            
            if ( isdefined( var7 ) )
            {
                var1 controlturretoff( var7 );
            }
            
            if ( var1 hasweapon( var3 ) )
            {
                var8 = var1 scripts\cp_mp\utility\inventory_utility::iscurrentweapon( var3 );
                
                if ( var8 )
                {
                    var1 scripts\cp_mp\utility\inventory_utility::_takeweapon( var3 );
                    var1 thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
                }
                else
                {
                    var1 thread scripts\cp_mp\utility\inventory_utility::getridofweapon( var3, 1 );
                }
            }
            
            var7 = 1;
        }
        
        if ( isdefined( var7 ) && !var7 )
        {
            var4.success = 0;
            var4 notify( var4.raceendnotify );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x1a
function vehicle_occupancy_givetaketurrettimeout( var0, var1 )
{
    wait var1;
    var0.success = 0;
    var0 notify( var0.raceendnotify );
}

// Params 2
// Size: 0x3b
function ref_141d3( var0, var1 )
{
    var0 endon( "death_or_disconnect" );
    var0 notify( "vehicle_occupancy_forceWeaponSwitchAllowed" );
    var0 endon( "vehicle_occupancy_forceWeaponSwitchAllowed" );
    
    if ( var0 scripts\common\utility::is_weapon_switch_allowed() )
    {
        return;
    }
    
    var0 enableweaponswitch();
    var1 waittill( var1.raceendon );
    thread ref_141cb( var0 );
}

// Params 1
// Size: 0x21
function ref_141cb( var0 )
{
    var0 notify( "vehicle_occupancy_forceWeaponSwitchAllowed" );
    
    if ( var0 scripts\common\utility::is_weapon_switch_allowed() )
    {
        var0 enableweaponswitch();
        return;
    }
    
    var0 disableweaponswitch();
}

// Params 1
// Size: 0x68
function vehicle_occupancy_ejectalloccupants( var0 )
{
    var1 = vehicle_occupancy_getallvehicleseats( var0 );
    
    foreach ( var3 in var1 )
    {
        var4 = vehicle_occupancy_getseatoccupant( var0, var3 );
        
        if ( isdefined( var4 ) )
        {
            var5 = spawnstruct();
            var5.allowairexit = 1;
            var5.onprematchfadedone2 = "INVOLUNTARY";
            thread vehicle_occupancy_exit( var0, var3, var4, var5, 1 );
        }
    }
}

// Params 0
// Size: 0x46
function vehicle_occupancy_getoccupantrestrictions()
{
    return [ "crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "crate_use", "ladder_placement", "execution_attack", "execution_victim" ];
}

// Params 0
// Size: 0x2e
function ref_141d8()
{
    return [ "usability_auto_use", "offhand_weapons", "melee", "reload", "autoreload", "weapon_switch", "cough_gesture" ];
}

// Params 0
// Size: 0x34
function vehicle_occupancy_getdriverrestrictions()
{
    return [ "usability_auto_use", "offhand_weapons", "melee", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture" ];
}

// Params 0
// Size: 0xa
function vehicle_occupancy_getcombatpassengerrestrictions()
{
    return [ "weapon_pickup" ];
}

// Params 0
// Size: 0xa
function vehicle_occupancy_getcombatcabpassengerrestrictions()
{
    var0 = vehicle_occupancy_getcombatpassengerrestrictions();
    return var0;
}

// Params 0
// Size: 0x7
function vehicle_occupancy_getpassivepassengerrestrictions()
{
    return vehicle_occupancy_getdriverrestrictions();
}

// Params 0
// Size: 0x21
function vehicle_occupancy_getturretpassengerrestrictions()
{
    var0 = vehicle_occupancy_getcombatpassengerrestrictions();
    GscBinSkip0( 0x2e, var0.size, "cough_gesture" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 3
// Size: 0x84
function vehicle_occupancy_disablefirefortime( var0, var1, var2 )
{
    var0 endon( "disconnect" );
    var0 notify( "vehicle_occupancy_disableFireForTime" );
    var0 endon( "vehicle_occupancy_disableFireForTime" );
    
    if ( !istrue( self.vehicledisablefire ) )
    {
        var0.vehicledisablefire = 1;
        var0 scripts\common\utility::allow_fire( 0, "vehicleDisableFire" );
    }
    
    if ( !isdefined( var0.vehicledisablefireendtime ) || !istrue( var2 ) )
    {
        var0.vehicledisablefireendtime = gettime() + var1;
    }
    
    while ( isdefined( var0.vehicledisablefireendtime ) && gettime() < var0.vehicledisablefireendtime )
    {
        wait 0.05;
    }
    
    thread vehicle_occupancy_cleardisablefirefortime( var0 );
}

// Params 2
// Size: 0x39
function vehicle_occupancy_cleardisablefirefortime( var0, var1 )
{
    var0 notify( "vehicle_occupancy_disableFireForTime" );
    
    if ( isdefined( var0.vehicledisablefire ) )
    {
        if ( !istrue( var1 ) )
        {
            var0 scripts\common\utility::allow_fire( 1, "vehicleDisableFire" );
        }
    }
    
    var0.vehicledisablefire = undefined;
    var0.vehicledisablefireendtime = undefined;
}

// Params 3
// Size: 0x2e
function ref_141f8( var0, var1, var2 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "takeRiotShield" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "takeRiotShield" ) ]]( var0, var1, var2 );
        return;
    }
}

// Params 3
// Size: 0x2e
function ref_141d9( var0, var1, var2 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "giveRiotShield" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "giveRiotShield" ) ]]( var0, var1, var2 );
        return;
    }
}

// Params 3
// Size: 0x2e
function ref_141f9( var0, var1, var2 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "updateRiotShield" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "updateRiotShield" ) ]]( var0, var1, var2 );
        return;
    }
}

// Params 4
// Size: 0x30
function ref_141db( var0, var1, var2, var3 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "hideCashBag" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "hideCashBag" ) ]]( var0, var1, var2, var3 );
        return;
    }
}

// Params 4
// Size: 0x30
function ref_141f5( var0, var1, var2, var3 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "showCashBag" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "showCashBag" ) ]]( var0, var1, var2, var3 );
        return;
    }
}

// Params 1
// Size: 0x42
function vehicle_occupancy_registersentient( var0 )
{
    if ( isdefined( var0.sentientdisabled ) && var0.sentientdisabled > 0 )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "registerSentient" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "registerSentient" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x2a
function vehicle_occupancy_unregistersentient( var0 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "unregisterSentient" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "unregisterSentient" ) ]]( var0 );
        return;
    }
}

// Params 1
// Size: 0x2a
function vehicle_occupancy_issentient( var0 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "isSentient" ) )
    {
        return [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "isSentient" ) ]]( var0 );
    }
}

// Params 1
// Size: 0x4c
function vehicle_occupancy_allowsentient( var0 )
{
    if ( var0 )
    {
        self.sentientdisabled--;
        
        if ( self.sentientdisabled == 0 )
        {
            vehicle_occupancy_registersentient( self );
            return;
        }
        
        return;
    }
    
    if ( !isdefined( self.sentientdisabled ) )
    {
        self.sentientdisabled = 0;
    }
    
    self.sentientdisabled++;
    
    if ( self.sentientdisabled == 1 )
    {
        vehicle_occupancy_unregistersentient( self );
        return;
    }
}

// Params 2
// Size: 0x78
function ref_141e7( var0, var1 )
{
    var2 = spawnstruct();
    var2.seatid = var1;
    var3 = vehicle_occupancy_getleveldataforseat( var0.vehiclename, var1 );
    
    if ( isdefined( var3.animtag ) )
    {
        var2.origin = var0 gettagorigin( var3.animtag );
        var2.angles = var0 gettagangles( var3.animtag );
    }
    else
    {
        var2.origin = var0.origin;
        var2.angles = var0.angles;
    }
    
    return var2;
}

// Params 3
// Size: 0x3f
function vehicle_occupancy_linkseatcorpse( var0, var1, var2 )
{
    var3 = vehicle_occupancy_getleveldataforseat( var1.vehiclename, var2 );
    
    if ( isdefined( var3.animtag ) )
    {
        var0 enablelinkto();
        var0 linkto( var1, var3.animtag );
        return;
    }
    
    var0 enablelinkto();
    var0 linkto( var1 );
}

// Params 4
// Size: 0x3e
function vehicle_occupancy_assignseatcorpse( var0, var1, var2, var3 )
{
    if ( !isdefined( var1.corpses ) )
    {
        var1.corpses = [];
    }
    
    vehicle_occupancy_deleteseatcorpse( var1, var2, 0 );
    var1.corpses[ var2 ] = var0;
    
    if ( !var3 )
    {
        var0.matchdata_logmultikill = 1;
        return;
    }
}

// Params 3
// Size: 0x2f
function ref_141cc( var0, var1, var2 )
{
    if ( isdefined( var1.corpses ) && isdefined( var1.corpses[ var2 ] ) )
    {
        var1.corpses[ var2 ] = undefined;
    }
    
    var0.matchdata_logmultikill = undefined;
}

// Params 3
// Size: 0x59
function vehicle_occupancy_deleteseatcorpse( var0, var1, var2 )
{
    if ( isdefined( var0.corpses ) && isdefined( var0.corpses[ var1 ] ) )
    {
        var3 = var0.corpses[ var1 ];
        
        if ( isdefined( var3 ) )
        {
            if ( !istrue( var3.matchdata_logmultikill ) || !var2 )
            {
                var0.corpses[ var1 ] delete();
                var0.corpses[ var1 ] = undefined;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x49
function vehicle_occupancy_deleteseatcorpses( var0 )
{
    if ( isdefined( var0.corpses ) )
    {
        foreach ( var2 in var0.corpses )
        {
            if ( isdefined( var2 ) )
            {
                var2 delete();
            }
        }
    }
    
    var0.corpses = undefined;
}

// Params 2
// Size: 0x50
function ref_141c6( var0, var1 )
{
    if ( istrue( var0.isdestroyed ) || !isdefined( var0.occupants ) )
    {
        var0.ref_1287d = undefined;
        return;
    }
    
    if ( var1 )
    {
        var0.ref_1287d--;
        return;
    }
    
    if ( !isdefined( var0.ref_1287d ) )
    {
        var0.ref_1287d = 0;
    }
    
    var0.ref_1287d++;
}

// Params 1
// Size: 0x39, Type: bool
function ref_141c7( var0 )
{
    if ( istrue( var0.isdestroyed ) || !isdefined( var0.occupants ) )
    {
        return false;
    }
    
    if ( isdefined( var0.ref_1287d ) && var0.ref_1287d > 0 )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x49
function vehicle_occupancy_generateseatswitcharray( var0, var1 )
{
    var2 = [];
    var3 = 0;
    
    for ( var4 = 0;  ; var4++ )
    {
        if ( !var3 )
        {
            if ( var0 == var1[ var4 ] )
            {
                var3 = 1;
            }
            
            continue;
        }
        
        var4 = scripts\engine\utility::mod( var4, var1.size );
        
        if ( var0 == var1[ var4 ] )
        {
            break;
        }
        
        var2 = var1[ var4 ];
    }
    
    return var2;
}

// Params 2
// Size: 0x24e
function vehicle_occupancy_killoccupants( var0, var1 )
{
    if ( !isdefined( var1.inflictor ) )
    {
        switch ( var1.meansofdeath )
        {
            case "MOD_GRENADE_SPLASH":
            case "MOD_GRENADE":
            case "MOD_PROJECTILE_SPLASH":
            case "MOD_PROJECTILE":
                if ( isdefined( var0.killcament ) )
                {
                    var0.killcament delete();
                }
                
                var0.killcament = var1.inflictor;
                var1.inflictor = var0;
                break;
        }
    }
    
    if ( !isdefined( var1.inflictor ) )
    {
        var1.inflictor = undefined;
    }
    
    var2 = var1.meansofdeath;
    
    if ( var2 == "MOD_PROJECTILE" )
    {
        var2 = "MOD_PROJECTILE_SPLASH";
    }
    else if ( var2 == "MOD_GRENADE" )
    {
        var2 = "MOD_GRENADE_SPLASH";
    }
    
    var3 = vehicle_occupancy_getallvehicleseats( self );
    
    foreach ( var5 in var3 )
    {
        var6 = vehicle_occupancy_getseatoccupant( self, var5 );
        
        if ( isdefined( var6 ) && var6 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var7 = var1.attacker;
            
            if ( scripts\common\utility::iscp() )
            {
                var6.shouldskipdeathsshield = 1;
                
                if ( !isdefined( var7 ) )
                {
                    if ( isdefined( var1.inflictor ) )
                    {
                        var7 = var1.inflictor;
                    }
                }
                
                if ( !isdefined( var7 ) )
                {
                    var7 = var6;
                }
                
                if ( isdefined( var7 ) && isdefined( var7.team ) )
                {
                    if ( var7.team == var6.team )
                    {
                        vehicle_occupancy_exit( self, var5, var6, undefined, 1 );
                        var6.skipvehiclespashdamage = 1;
                        continue;
                    }
                }
            }
            else if ( !isdefined( var7 ) || !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var7, var6 ) ) )
            {
                var7 = var6;
            }
            
            var6.donotmodifydamage = 1;
            var8 = 0;
            
            if ( level.gametype == "br" && istrue( var6.isjuggernaut ) )
            {
                if ( isdefined( var6.juggcontext.juggconfig.ref_14232 ) && var6.health > var6.juggcontext.juggconfig.ref_14232 )
                {
                    var8 = 1;
                }
            }
            
            if ( !istrue( var8 ) )
            {
                var9 = scripts\engine\utility::ter_op( isent( var7 ), var7, undefined );
                var6 dodamage( var6.maxhealth, var0.origin, var9, var1.inflictor, var2, var1.objweapon, "torso_upper" );
                
                if ( isdefined( level.ref_14254 ) )
                {
                    var6 thread [[ level.ref_14254 ]]();
                }
            }
            
            var6.donotmodifydamage = undefined;
            thread vehicle_occupancy_exit( var0, var5, var6, undefined, 1 );
        }
    }
    
    vehicle_occupancy_deleteseatcorpses( var0 );
}

// Params 0
// Size: 0x11
function vehicle_occupancy_initdebug()
{
    var0 = vehicle_occupancy_getleveldata();
    var0.debuginstances = [];
}

