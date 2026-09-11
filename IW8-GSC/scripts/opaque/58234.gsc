
// Params 0
// Size: 0x446
function bot_gulag_think()
{
    var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_a10fd", 1 );
    var0.destroycallback = &bot_get_stored_custom_classes;
    var0.ref_13e92 = "tur_gun_fd_mp_seeking";
    level.pindia_headlights = getdvarint( "scr_fd_start_in_the_air", 0 );
    level.picking_up_minigun = getdvarfloat( "scr_fd_gunner_time_between_bullets", 0.1 );
    level.picked_up_weapon = getdvarint( "scr_fd_enable_sonar", 1 );
    level.pilot_model = getdvarint( "scr_fd_sonar_scan_angle", 35 );
    level.pilot_setups = getdvarint( "scr_fd_sonar_scan_range", 15000 );
    level.ph_checkforovertime = getdvarint( "scr_fd_additional_contrail_vfx", 1 );
    level.pickuptrigger = getdvarint( "scr_fd_wing_contrails_min_speed", 65 );
    level.pickup_truck_initomnvars = getdvarint( "scr_fd_cloud_contrails_min_speed", 100 );
    level.pickupchecks = getdvarint( "scr_fd_fast_contrails_min_speed", 90 );
    level.pilot_anim_loop = getdvarint( "scr_fd_oob_override_seconds", 40 );
    level.phfrozen = getdvarint( "scr_fd_collision_before_liftoff", 0 );
    level.pickprematchrandomloadout = getdvarint( "scr_fd_hide_pilot", 0 );
    level.pickedupcoreminigun = getdvarint( "scr_fd_gas_damage_players_airplane", 3 );
    level.pick_up_data = getdvarfloat( "scr_fd_dot_velocity_ground_no_damage", 0.15 );
    level.pick_from_preset_solutions = getdvarfloat( "scr_fd_dot_velocity_ground_little_damage", 0.85 );
    level.ŠÖ'§6<èø€ëÈ9K°iJZäåÑ½uÁ‘Žß  = getdvarint( "scr_fd_ignoreLandingGearDamage", 0 );
    level.â’ÐOrie»µñ‘¿Kø
p‹ª³!A¯ = getdvarint( "scr_fd_reduceLandingGearDamage", 1 );
    level.Î ™2ëF·ÑÙ•6Û±ÒÑåv'Þ]ÜFc7ZæìÎ²Â“ = getdvarfloat( "scr_fd_dot_velocity_ground_landing_gear", 0.25 );
    level.´ø!	ß— {2#gº4C3Ð^ø®ê1Ÿâˆ@‹š = getdvarfloat( "scr_fd_min_speed_factor_for_dot_velocity", 0.2 );
    level.pit_locations = getdvarint( "scr_fd_velocity_ground_little_damage", 2 );
    level.phase_three_combat = getdvarint( "scr_fd_auto_target", 1 );
    level.phase_zero_combat = getdvarfloat( "scr_fd_auto_target_enable_with_ads_only", 0 );
    level.phclass = getdvarfloat( "scr_fd_auto_target_refresh_time", 0.1 );
    level.phase_two_combat = getdvarfloat( "scr_fd_auto_target_angle", 2.25 );
    level.phaseindex = getdvarfloat( "scr_fd_auto_target_range", 12000 );
    level.pingedenemies = getdvarfloat( "scr_fd_dmg_mod_vs_fd", 5 );
    level.ping_response_time = getdvarfloat( "scr_fd_dmg_mod_vs_bt", 3.75 );
    level.pistolslide = getdvarfloat( "scr_fd_dmg_mod_vs_vehicles", 5 );
    level.pindia_vehicle_registration = getdvarfloat( "scr_fd_dmg_mod_vs_AA", 10 );
    level.pipe_room_dogtag_revive = getdvarfloat( "scr_fd_dmg_mod_vs_Player", 0.475 );
    level.phone_group_spawned = getdvarfloat( "scr_fd_dmg_multiplier_fuselage", 0.5 );
    level.phonehint = getdvarfloat( "scr_fd_dmg_multiplier_propeller", 1.5 );
    level.phone_group_spawned_timeout = getdvarfloat( "scr_fd_dmg_multiplier_landing_gear", 0 );
    level.phone = getdvarfloat( "scr_fd_dmg_multiplier_driverless", 10 );
    level.phoneisringing = getdvarfloat( "scr_fd_dmg_damage_pitch_threshold", 40 );
    level.phoneplayring = getdvarfloat( "scr_fd_dmg_damage_roll_threshold", 45 );
    level.phoneisnotringing = getdvarfloat( "scr_fd_dmg_damage_pitch_factor", 2 );
    level.phonemorsesinglescriptableused = getdvarfloat( "scr_fd_dmg_damage_roll_factor", 2 );
    level.phonesfx = getdvarfloat( "scr_fd_dmg_damage_upside_down_factor", 20 );
    level.phcountdowntimer = getdvarfloat( "scr_fd_dmg_burn_down_time", 4 );
    level.pickclassbr = getdvarint( "scr_fd_enable_server_hud", 0 );
    level.pickedpball = getdvarint( "scr_fd_force_netfield_high_lod", 1 );
    level.pickup_truck_initdamage = getdvarint( "scr_fd_aircraft_max_allowed", 30 );
    level.ph_setfinalkillcamwinner = getdvarfloat( "scr_fd_aircraft_respawn", 0 );
    level.ph_endgame = getdvarfloat( "scr_fd_aircraft_type", 1 );
    level.phase_five_combat = getdvarint( "scr_fd_aircraft_respawn_max_circle_index", 4 );
    level.ph_loadouts = getdvarint( "scr_fd_aircraft_fast_contrails_min_angle", 55 );
    level.phase_four_combat = getdvarint( "scr_fd_aircraft_speed_diff_damage", 1 );
    level.pickup_timeout = getdvarint( "scr_fd_aircraft_longer_vehicle_explosion", 0 );
    level.pickrandomspawn = getdvarint( "scr_fd_aircraft_ignore_self_collision", 1 );
    level.pistolweapon = getdvarint( "scr_fd_turret_owner_is_airplane", 0 );
    level.pilot_linkto_origin_offset = getdvarint( "scr_fd_skydive_ignore_auto_target", 1 );
    level.‚wcØdÓ¿ÏGû'ûÿ0ˆÕš;N = getdvarint( "scr_fd_damage_debounce_time_ms", 500 );
    level.ƒNô"©l9½r2ÑØžUÈ‘jû ×Ôˆ½É¹VQ = getdvarfloat( "scr_fd_damage_debounce_threshold_pct", 0.3 );
    level.pickup_sound_playerwm_handler = getdvarfloat( "scr_fd_impulse_dmg_threshold_high", 4.5 );
    level.pickup_sound_playervm_handler = getdvarfloat( "scr_fd_impulse_dmg_threshold_mid", 0.9 );
    level.pickup_sound_hvt_handler = getdvarfloat( "scr_fd_impulse_dmg_threshold_low", 0.3 );
    level.pickrandomvehiclespawn = getdvarfloat( "scr_fd_impulse_dmg_factor_low", 0.05 );
    level.pickup_saw_and_start_mission = getdvarfloat( "scr_fd_impulse_dmg_factor_mid_low", 0.2 );
    level.pickup_gasmask = getdvarfloat( "scr_fd_impulse_dmg_factor_mid_high", 0.75 );
    bot_is_capturing_hq_zone();
    bot_hq_start();
    bot_is_capturing_zone();
    bot_has_streak_in_crate();
    bot_has_player_enemy();
    bot_hp_allow_predictive_capping();
    bot_gun_pick_personality_from_weapon();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_a10fd", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_a10fd", "init" ) ]]();
    }
    
    bot_is_in_gas();
    bot_hq_think();
}

// Params 0
// Size: 0x2d
function bot_hq_think()
{
    thread ref_1327d();
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_a10fd", "initLate" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_a10fd", "initLate" ) ]]();
        return;
    }
}

// Params 0
// Size: 0x2e4
function bot_is_capturing_hq_zone()
{
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( "veh_a10fd", 1 );
    var0.enterstartcallback = &bot_get_low_on_all_ammo;
    var0.enterendcallback = &bot_get_human_picked_class;
    var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
    var0.exitendcallback = &bot_get_num_teammates_capturing_zone;
    var0.reentercallback = &bot_parachute_into_map;
    var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
    var0.exitextents[ "front" ] = 0;
    var0.exitextents[ "back" ] = 255;
    var0.exitextents[ "left" ] = 150;
    var0.exitextents[ "right" ] = 150;
    var0.exitextents[ "top" ] = 10;
    var0.exitextents[ "bottom" ] = 50;
    var0.allowairexit = 1;
    var1 = "back_left";
    var0.exitoffsets[ var1 ] = ( -150, 150, -45 );
    var0.exitdirections[ var1 ] = "left";
    var1 = "back_right";
    var0.exitoffsets[ var1 ] = ( -150, -150, -45 );
    var0.exitdirections[ var1 ] = "right";
    var1 = "back";
    var0.exitoffsets[ var1 ] = ( -255, 0, -45 );
    var0.exitdirections[ var1 ] = "back";
    var1 = "front";
    var0.exitoffsets[ var1 ] = ( 30, 0, -45 );
    var0.exitdirections[ var1 ] = "front";
    var1 = "front_left";
    var0.exitoffsets[ var1 ] = ( 90, 35, 45 );
    var0.exitdirections[ var1 ] = "left";
    var1 = "back_left";
    var0.exitoffsets[ var1 ] = ( -90, 35, 45 );
    var0.exitdirections[ var1 ] = "back";
    var2 = [ "pilot", "gunner" ];
    var3 = "pilot";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_a10fd", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "back_left", "back_right", "back" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d8();
    var4.ref_13e8a = getcompleteweaponname( "tur_gun_fd_mp_seeking" );
    var4.ref_13e92 = "tur_gun_fd_mp_seeking";
    var4.animtag = "tag_seat_0";
    var4.ref_12023 = "ping_vehicle_pilot";
    var3 = "gunner";
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "veh_a10fd", var3, 1 );
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var3, var2 );
    var4.exitids = [ "back_left", "back_right", "back" ];
    var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
    var4.animtag = "tag_seat_2";
    var4.ref_12023 = "ping_vehicle_rider";
    var4.ref_145e0 = getdvarint( "scr_fd_passenger_world_up_ref", 0 );
    var4.ref_1409c = getdvarint( "scr_fd_passenger_use_tag_angles", 1 );
}

// Params 0
// Size: 0x2d
function bot_hq_start()
{
    var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( "veh_a10fd", 1 );
    scripts\cp_mp\vehicles\vehicle_interact::ref_1419d( "veh_a10fd", "single", [ "pilot", "gunner" ] );
}

// Params 0
// Size: 0xa7
function bot_is_capturing_zone()
{
    var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e( "veh_a10fd", 1 );
    var0.id = 19;
    var0.seatids[ "pilot" ] = 0;
    var0.seatids[ "gunner" ] = 1;
    var0.ref_12da2[ 0 ] = 0;
    var0.ref_12da2[ 1 ] = 1;
    var0.ref_12da3[ "pilot" ][ "tur_gun_fd_mp_seeking" ] = 0;
    var0.ref_12da3[ "pilot" ][ "tur_gun_fd_mp_seeking" ] = 1;
    var0.ref_12da3[ "gunner" ][ "tur_gun_fd_mp_seeking" ] = 0;
    var0.ref_12da3[ "gunner" ][ "tur_gun_fd_mp_seeking" ] = 1;
}

// Params 0
// Size: 0xff
function bot_has_streak_in_crate()
{
    level.br_pe_chopper_crates = getdvarfloat( "scr_fd_health_override", 1500 );
    scripts\cp_mp\vehicles\vehicle_damage::ref_1416c( "veh_a10fd", level.br_pe_chopper_crates, undefined, undefined, undefined, level.phcountdowntimer );
    var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle( "veh_a10fd" );
    var0.class = "heavy";
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_a10fd", "light" );
    var1.ref_12024 = &bot_loadout_choose_from_custom_default_class;
    var1.ref_1202d = &bot_modify_behavior_from_loadout;
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_a10fd", "medium" );
    var1.ref_12024 = &bot_loadout_team;
    var1.ref_1202d = &bot_modify_behavior_from_tweakables;
    var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d( "veh_a10fd", "heavy" );
    var1.ref_12024 = &bot_loadout;
    var1.ref_1202d = &bot_match_rules_invalidate_loadout;
    scripts\cp_mp\vehicles\vehicle_damage::ref_1413d( "veh_a10fd" );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14178( "veh_a10fd", 10 );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14175( "veh_a10fd", &bot_nags );
    scripts\cp_mp\vehicles\vehicle_damage::ref_14171( "veh_a10fd", &bot_get_active_tactical_goals_of_type );
    scripts\cp_mp\vehicles\vehicle_damage::ref_1417b( "tur_gun_fd_mp_seeking", 5 );
}

// Params 0
// Size: 0x81
function bot_has_player_enemy()
{
    var0 = _calloutmarkerping_predicted_log::ref_1410f( "veh_a10fd", 1 );
    var0.challengeevaluator = 2;
    var0.keycardlocs_chosen = 0.75;
    var0.is_using_stealth_debug = 350;
    var0.is_valid_station_name = 525;
    var0.is_two_hit_melee_weapon = 875;
    var0.isakimbomeleeweapon = 5;
    var0.isallowedweapon = 20;
    var0.isakimbo = 40;
    var0.isattachmentgrenadelauncher = 0;
    var0.isattachmentselectfire = 0;
    var0.isassaulting = 0;
}

// Params 0
// Size: 0x2a
function bot_hp_allow_predictive_capping()
{
    level._effect[ "aircraft_explode" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_dauntless_death_exp.vfx" );
    level._effect[ "aircraft_explode_grd" ] = loadfx( "vfx/iw8_br/island/veh/vfx_br3_dauntless_death_exp_ground.vfx" );
}

#using_animtree( "" );

// Params 0
// Size: 0x38
function bot_gun_pick_personality_from_weapon()
{
    level.scr_anim[ "aircraft" ][ "spin_up" ] = %sdr_mp_veh_dalpha_propeller_spin_up;
    level.scr_anim[ "aircraft" ][ "spin_down" ] = $sdr_mp_veh_dalpha_propeller_spin_down;
}

// Params 0
// Size: 0x19
function bot_give_weapon()
{
    var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_a10fd" );
    var1 = var0.ref_13e92;
    return var1;
}

// Params 2
// Size: 0x17a
function bot_gametype_set_role( var0, var1 )
{
    if ( !isdefined( var0.angles ) )
    {
        var0.angles = ( 0, 0, 0 );
    }
    
    var0.modelname = "veh_s4_mil_air_dalpha_wz";
    var0.targetname = "veh_a10fd";
    
    if ( !isdefined( var0.vehicletype ) )
    {
        var0.vehicletype = "a10_warthog_fd";
    }
    
    var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var0, var1 );
    
    if ( !isdefined( var2 ) )
    {
        return undefined;
    }
    
    var3 = bot_give_weapon();
    var4 = bot_get_teammates_capturing_zone();
    var5 = bot_gametype_zones_precached( var2, var3, "veh_s4_mil_air_dalpha_wz_turret_attach", var4.tag, var4.tagoffset );
    scripts\cp_mp\vehicles\vehicle::ref_14207( var2, var5, getcompleteweaponname( var3 ) );
    var2.ref_13e92 = var3;
    
    if ( level.pistolweapon )
    {
        var5 setentityowner( var2 );
    }
    
    scripts\cp_mp\vehicles\vehicle::ref_14138( var2, "veh_a10fd", var0 );
    var2.objweapon = getcompleteweaponname( "tur_gun_fd_mp_seeking" );
    var2.shouldmodeplayfinalmoments = 0;
    var2.ref_120b4 = level.pilot_anim_loop;
    var2.ref_13e83 = "tag_flash";
    thread botisonplayerteam();
    thread botloadoutfavoritecamosecondary();
    _calloutmarkerping_predicted_timeout::ref_1412b( var2 );
    scripts\cp_mp\vehicles\vehicle::ref_14139( var2, var0 );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_a10fd", "create" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_a10fd", "create" ) ]]( var2 );
    }
    
    if ( getdvarfloat( "scr_br_fd_spawnProtectionTimer", 0 ) > 0 )
    {
        var2.ref_13a32 = gettime() + getdvarfloat( "scr_br_fd_spawnProtectionTimer", 0 ) * 1000;
    }
    
    thread helis_assault3_hangar_check_size();
    thread br_tacmap_icon();
    
    if ( level.pickedpball )
    {
        var2 unmarkkeyframedmover( 1 );
    }
    
    return var2;
}

// Params 0
// Size: 0x4dc
function helis_assault3_hangar_check_size()
{
    var0 = self;
    var0 endon( "death" );
    var0 vehphys_enablecollisioncallback( 1 );
    
    if ( getdvarint( "scr_br_fd_invincible", 0 ) )
    {
        return;
    }
    
    wait 5;
    var1 = [];
    
    for ( var2 = [];  ; var2 = min( var25 * level.ƒNô"©l9½r2ÑØžUÈ‘jû ×Ôˆ½É¹VQ, var0.maxhealth ) )
    {
        var0 waittill( "collision", var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        
        if ( isdefined( var10 ) && isdefined( var10.helperdronetype ) && var10.helperdronetype == "radar_drone_recon" )
        {
            continue;
        }
        
        if ( istrue( level.phfrozen ) && !istrue( var0.shouldmodeplayfinalmoments ) )
        {
            continue;
        }
        
        var12 = 0;
        
        if ( istrue( level.pickrandomspawn ) )
        {
            var12 = isdefined( var10 ) && var10 == var0;
        }
        
        if ( isdefined( var10.model ) && !var12 )
        {
            if ( var10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields() )
            {
                var10 _calloutmarkerping_handleluinotify_mappingdeletemarker::createteamdefenderflagbase();
                
                if ( isdefined( var0 ) )
                {
                    bot_should_cap_next_zone( var0, 9000, var10, var7 );
                }
                
                continue;
            }
            
            if ( istrue( var0.shouldmodeplayfinalmoments ) && ( unreachable_function( var10 ) || var10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() ) )
            {
                if ( isdefined( var10.owner ) && isdefined( var0.owner ) && var10.owner.team != var0.owner.team )
                {
                    var13 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 );
                    
                    foreach ( var15 in var13 )
                    {
                        var15 dodamage( 20, var0.origin, var10.owner, var15, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking" );
                    }
                    
                    var17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var10 );
                    
                    foreach ( var15 in var17 )
                    {
                        var15 dodamage( 20, var0.origin, var0.owner, var15, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking" );
                    }
                }
                
                var0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
                var0 dodamage( 9000, var7, undefined, undefined, "MOD_CRUSH" );
                var0 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
                var10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
                var10 dodamage( 9000, var7, undefined, undefined, "MOD_CRUSH" );
                var10 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
                continue;
            }
        }
        
        var20 = 1;
        var21 = 0;
        var22 = 0;
        
        switch ( var11 )
        {
            case 0:
                var20 = level.phone_group_spawned;
                break;
            case 1:
                var20 = level.phonehint;
                var21 = 1;
                break;
            case 2:
                var22 = 1;
                break;
            default:
                break;
        }
        
        if ( var21 )
        {
            var23 = var20;
        }
        else
        {
            var23 = var9 * var20;
        }
        
        if ( istrue( level.phase_four_combat ) )
        {
            var24 = length( var0 vehicle_getvelocity() - var0.br_toggle_armor_allows );
            var23 *= var24 / 17.6;
        }
        
        if ( abs( angleclamp180( var0.angles[ 0 ] ) > level.phoneisringing ) )
        {
            var23 *= level.phoneisnotringing;
        }
        
        if ( abs( var0.angles[ 2 ] ) > level.phoneplayring )
        {
            var23 *= level.phonemorsesinglescriptableused;
        }
        
        if ( var0.angles[ 2 ] > 90 || var0.angles[ 2 ] < -90 )
        {
            var23 *= level.phonesfx;
        }
        
        var25 = 0;
        
        if ( var23 > level.pickup_sound_playerwm_handler )
        {
            var25 = var0.maxhealth;
        }
        else if ( var23 > level.pickup_sound_playervm_handler )
        {
            var26 = level.pickup_sound_playerwm_handler - level.pickup_sound_playervm_handler;
            var27 = ( var23 - level.pickup_sound_playervm_handler ) / var26;
            var28 = var0.maxhealth * level.pickup_saw_and_start_mission;
            var29 = var0.maxhealth * level.pickup_gasmask;
            var25 = scripts\engine\math::lerp( var28, var29, var27 );
        }
        else if ( var23 > level.pickup_sound_hvt_handler )
        {
            var25 = var0.maxhealth * level.pickrandomvehiclespawn;
        }
        
        var30 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( var0 );
        
        if ( !isdefined( var30 ) )
        {
            var25 *= level.phone;
        }
        
        var31 = -1;
        
        if ( var11 != 1 )
        {
            var31 = abs( vectordot( var8, vectornormalize( var0.br_toggle_armor_allows ) ) );
            var32 = 1;
            
            if ( var22 && var9 < level.´ø!	ß— {2#gº4C3Ð^ø®ê1Ÿâˆ@‹š )
            {
                var32 = 0;
            }
            
            if ( var32 )
            {
                if ( var31 > level.pick_from_preset_solutions )
                {
                    var25 += var0.maxhealth * 0.25 + randomintrange( 50, 100 );
                }
                else if ( var31 > level.pick_up_data )
                {
                    var25 *= level.pit_locations;
                }
            }
        }
        else
        {
            var25 += 550;
        }
        
        if ( isdefined( var1[ var11 ] ) && var1[ var11 ] > gettime() )
        {
            if ( var25 < var2[ var11 ] )
            {
                continue;
            }
        }
        
        if ( var22 && var25 > 0 )
        {
            if ( level.ŠÖ'§6<èø€ëÈ9K°iJZäåÑ½uÁ‘Žß  )
            {
                continue;
            }
            
            if ( level.â’ÐOrie»µñ‘¿Kø
p‹ª³!A¯ && var31 <= level.Î ™2ëF·ÑÙ•6Û±ÒÑåv'Þ]ÜFc7ZæìÎ²Â“ )
            {
                continue;
            }
        }
        
        if ( var25 > 0 )
        {
            bot_should_cap_next_zone( var0, var25, var10, var7 );
            var1 = gettime() + level.‚wcØdÓ¿ÏGû'ûÿ0ˆÕš;N;
        }
    }
}

// Params 0
// Size: 0x2d
function br_tacmap_icon()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0.br_toggle_armor_allows = 0;
    
    for ( ;; )
    {
        waittillframeend();
        var0.br_toggle_armor_allows = var0 vehicle_getvelocity();
        waitframe();
    }
}

// Params 3
// Size: 0xba
function bot_should_cap_next_zone( var0, var1, var2 )
{
    var3 = self;
    
    if ( var0 > 650 )
    {
        br_pickupdenyweaponpickupap( var3, "screenshake_fd_coll_damage", "rumble_fd_coll_damage" );
    }
    
    var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 1 );
    
    if ( var3.health - var0 <= 0 )
    {
        if ( !istrue( var3.should_play_player_infil ) && ( var1.classname == "worldspawn" || var1 == var3 ) )
        {
            br_mapboundsfull();
        }
        else
        {
            var3 dodamage( var0, var2, undefined, undefined, "MOD_CRUSH" );
            var3 radiusdamage( var3.origin, 250, 200, 80, var3, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking" );
            var3.brlootchoppercrateactivatecallback = 1;
            var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
            return;
        }
    }
    
    var3 dodamage( var0, var2, undefined, undefined, "MOD_CRUSH" );
    var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143( 0 );
}

// Params 0
// Size: 0xdf
function br_mapboundsfull()
{
    var0 = self;
    var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 );
    
    foreach ( var3 in var1 )
    {
        var3.donotmodifydamage = 1;
        var3 dodamage( 99, var0.origin, var3, var3, "MOD_RIFLE_BULLET", "tur_gun_fd_mp_seeking" );
        var3.donotmodifydamage = undefined;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( var0 );
    
    foreach ( var6 in var1 )
    {
        var6.plotarmor = 1;
    }
    
    var0 radiusdamage( var0.origin, 250, 200, 80, var0, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking" );
    var0.brlootchoppercrateactivatecallback = 1;
    
    foreach ( var6 in var1 )
    {
        var6.plotarmor = 0;
    }
}

// Params 0
// Size: 0x61
function bot_get_teammates_capturing_zone()
{
    var0 = spawnstruct();
    
    if ( getdvarint( "aircraft_turret_tag_animate", 0 ) == 1 )
    {
        var0.tag = "tag_body_animate";
        var0.tagoffset = ( 58.87, 0, 60.052 );
    }
    else
    {
        var0.tag = "tag_turret";
        var0.tagoffset = ( 0, 0, 0 );
    }
    
    return var0;
}

// Params 5
// Size: 0x93
function bot_gametype_zones_precached( var0, var1, var2, var3, var4 )
{
    var5 = spawnturret( "misc_turret", var0 gettagorigin( var3 ), var1, 0 );
    var5 unmarkkeyframedmover( 1 );
    var5 linkto( var0, var3, var4, ( -1, 0, 0 ) );
    var5 setmodel( var2 );
    var5 setmode( "manual_target" );
    var5 setsentryowner( undefined );
    var5 makeunusable();
    var5 setdefaultdroppitch( 0 );
    var5 setturretmodechangewait( 1 );
    var5.angles = var0.angles;
    var5.vehicle = var0;
    var5.maxhealth = 999999;
    var5.health = var5.maxhealth;
    return var5;
}

// Params 2
// Size: 0x195
function bot_get_stored_custom_classes( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = spawnstruct();
        var0.inflictor = self;
        var0.objweapon = "tur_gun_fd_mp_seeking";
        var0.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner.br_pe_chopper_damage_time = var0.meansofdeath;
    }
    
    self notify( "predeath" );
    
    if ( istrue( level.pickup_timeout ) )
    {
        wait 0.2;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_damage::ref_14162( var0 );
    self setscriptablepartstate( "fx", "base" );
    self setscriptablepartstate( "cloud_contrail", "base" );
    self setscriptablepartstate( "fast_contrail", "base" );
    self setscriptablepartstate( "engine_smoke", "base", 0 );
    
    if ( isdefined( self.isballisticspecial ) )
    {
        foreach ( var3 in self.isballisticspecial )
        {
            self setscriptablepartstate( var3, "off" );
        }
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants( self, var0 );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals( undefined, undefined, 1 );
    thread bot_get_angles_to_goal();
    var5 = self gettagorigin( "tag_origin" );
    
    if ( !istrue( self.brlootchoppercrateactivatecallback ) )
    {
        self radiusdamage( self.origin, 250, 200, 80, self, "MOD_EXPLOSIVE", "tur_gun_fd_mp_seeking" );
    }
    
    var6 = scripts\engine\utility::ter_op( self.shouldmodeplayfinalmoments, "aircraft_explode", "aircraft_explode_grd" );
    playfx( scripts\engine\utility::getfx( var6 ), var5, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( var5, "car_explode" );
    earthquake( 0.4, 800, var5, 0.7 );
    playrumbleonposition( "grenade_rumble", var5 );
    physicsexplosionsphere( var5, 500, 200, 1 );
}

// Params 0
// Size: 0xc2
function botloadoutfavoritecamosecondary()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    wait 2;
    var1 = 1;
    var2 = [ var0 ];
    
    for ( ;; )
    {
        var3 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
        var4 = var0.origin + anglestoup( var0.angles ) * -600;
        var5 = scripts\engine\trace::ray_trace( var0.origin, var4, var2, var3, 0 );
        
        if ( isdefined( var5 ) )
        {
            if ( var1 && var5[ "hittype" ] == "hittype_none" )
            {
                var0 setscriptablepartstate( "landing_gear", "closing", 0 );
                var1 = 0;
            }
            else if ( !var1 && var5[ "hittype" ] != "hittype_none" )
            {
                var0 setscriptablepartstate( "landing_gear", "opening", 0 );
                var1 = 1;
            }
        }
        
        wait 0.3;
    }
}

// Params 0
// Size: 0x14f
function botisonplayerteam()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0.br_alt_mode_inflation = 0;
    var0.should_play_player_infil = 0;
    var1 = [ var0 ];
    
    for ( ;; )
    {
        if ( !isplane( var0 ) )
        {
            notaplaneerror( var0 );
            return;
        }
        
        var2 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
        var3 = scripts\engine\trace::ray_trace( var0.origin, var0.origin - ( 0, 0, 150 ), var1, var2, 0 );
        
        if ( isdefined( var3 ) )
        {
            if ( var3[ "hittype" ] == "hittype_none" )
            {
                var0.shouldmodeplayfinalmoments = 1;
                var0.should_play_player_infil = 1;
                var0 setscriptablepartstate( "single", "vehicle_use_in_air" );
            }
            else if ( istrue( var0.shouldmodeplayfinalmoments ) )
            {
                br_pickupdenyweaponpickupap( var0, "screenshake_fd_land", "rumble_fd_land" );
                var0.shouldmodeplayfinalmoments = 0;
                var0 setscriptablepartstate( "single", "vehicle_use" );
            }
            
            if ( var0 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "entity", "touchingBadTrigger" ) ]]() )
            {
                var0 dodamage( 10000, var0.origin, undefined, undefined );
            }
        }
        
        var4 = register_sequence_4_objectives( var0 );
        
        if ( var0.br_alt_mode_inflation != var4 && isdefined( var0.owner ) )
        {
            var0.br_alt_mode_inflation = var4;
            bots_with_player_enemy( var0.owner, 1 );
        }
        
        wait 0.2;
    }
}

// Params 0
// Size: 0x36
function bot_get_angles_to_goal()
{
    scripts\cp_mp\vehicles\vehicle::ref_14185( self );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "veh_a10fd", "delete" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_a10fd", "delete" ) ]]( self );
    }
    
    waitframe();
    scripts\cp_mp\vehicles\vehicle::ref_14186( self );
}

// Params 1
// Size: 0x27, Type: bool
function bot_nags( var0 )
{
    if ( isdefined( var0.damage ) && var0.damage > 0 )
    {
        self notify( "damage_taken", var0 );
    }
    
    return true;
}

// Params 1
// Size: 0xe, Type: bool
function bot_get_active_tactical_goals_of_type( var0 )
{
    thread bot_get_stored_custom_classes( var0 );
    return true;
}

// Params 0
// Size: 0x73
function bot_on_player_death()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "propeller_spin_up" );
    var0 notify( "propeller_spin_down" );
    
    if ( istrue( var0.ref_128e9 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "spin_up", 0 );
    var0.ref_128e9 = 1;
    wait getanimlength( level.scr_anim[ "aircraft" ][ "spin_up" ] );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "idle", 0 );
}

// Params 0
// Size: 0x70
function bot_next_difficulty_type_index()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "propeller_spin_down" );
    var0 notify( "propeller_spin_up" );
    
    if ( !isdefined( var0.ref_128e9 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "spin_down", 0 );
    var0.ref_128e9 = undefined;
    wait getanimlength( level.scr_anim[ "aircraft" ][ "spin_down" ] );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "propeller", "idle_no_spin", 0 );
}

// Params 1
// Size: 0xd4
function bot_get_distance_to_goal( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1.isballisticspecial ) )
    {
        var1.isballisticspecial = [];
    }
    
    if ( !scripts\engine\utility::array_contains( var1.isballisticspecial, "left_wing_damage" ) && randomfloat( 1 ) < 0.4 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "left_wing_damage";
    }
    
    if ( !scripts\engine\utility::array_contains( var1.isballisticspecial, "right_wing_damage" ) && randomfloat( 1 ) < 0.4 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "right_wing_damage";
    }
    
    if ( var0 && !scripts\engine\utility::array_contains( var1.isballisticspecial, "tail_damage" ) && randomfloat( 1 ) < 0.5 )
    {
        var1.isballisticspecial[ var1.isballisticspecial.size ] = "tail_damage";
        return;
    }
}

// Params 1
// Size: 0x36
function bot_nag( var0 )
{
    var1 = self;
    
    foreach ( var3 in var1.isballisticspecial )
    {
        var1 setscriptablepartstate( var3, var0, 0 );
    }
}

// Params 2
// Size: 0x25
function bot_loadout_choose_from_custom_default_class( var0, var1 )
{
    var2 = self;
    bot_get_distance_to_goal( var2, 0 );
    bot_nag( var2, "light" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14165( var0, var1 );
}

// Params 2
// Size: 0x11
function bot_modify_behavior_from_loadout( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416a( var0, var1 );
}

// Params 2
// Size: 0x26
function bot_loadout_team( var0, var1 )
{
    var2 = self;
    bot_get_distance_to_goal( var2, 1 );
    bot_nag( var2, "medium" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14167( var0, var1 );
}

// Params 2
// Size: 0x11
function bot_modify_behavior_from_tweakables( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_1416b( var0, var1 );
}

// Params 2
// Size: 0x26
function bot_loadout( var0, var1 )
{
    var2 = self;
    bot_get_distance_to_goal( var2, 1 );
    bot_nag( var2, "heavy" );
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14163( var0, var1 );
}

// Params 2
// Size: 0x11
function bot_match_rules_invalidate_loadout( var0, var1 )
{
    var2 = self;
    var2 scripts\cp_mp\vehicles\vehicle_damage::ref_14169( var0, var1 );
}

// Params 0
// Size: 0x30
function ref_1327d()
{
    level.bot_set_zone_nodes = spawnstruct();
    level.bot_set_zone_nodes.powers = [];
    bhadriotshield( level.bot_set_zone_nodes, "pilotgunner", "+attack", &botstopmovingonlaststand );
}

// Params 1
// Size: 0x66
function ref_14231( var0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommand( var6, var4 );
        }
    }
}

// Params 1
// Size: 0x6d
function ref_14230( var0 )
{
    if ( !isdefined( self ) || isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommandremove( var6, var4 );
        }
    }
}

// Params 4
// Size: 0x42
function bhadriotshield( var0, var1, var2, var3 )
{
    if ( isstring( var2 ) )
    {
        var2 = [ var2 ];
    }
    
    var0.powers[ var1 ] = spawnstruct();
    var0.powers[ var1 ].clients_hacked = var2;
    var0.powers[ var1 ].func = var3;
}

// Params 2
// Size: 0x47
function botstopmovingonlaststand( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( var2.vehicle ) )
    {
        return;
    }
    
    var2.vehicle.turret.turreton = 1;
    var2.vehicle.turret setmode( "manual" );
    thread bottompercentagetoadjusteconomy();
}

// Params 0
// Size: 0x13e
function bottompercentagetoadjusteconomy()
{
    var0 = self;
    var0 notify( "pilotTurretDebounce" );
    var0 endon( "pilotTurretDebounce" );
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_aircraft" );
    var0.vehicle endon( "death" );
    var1 = var0.vehicle.turret;
    
    if ( isdefined( var1 ) )
    {
        var1.owner = var0;
    }
    
    var2 = 6;
    
    for ( ;; )
    {
        var1 shootturret( var0.vehicle.ref_13e83, var2, 1 );
        
        if ( istrue( var0.vehicle.binoculars_onstateenterfunc ) )
        {
            var0.binoculars_onstateexitfunc[ 1 ] += 1;
        }
        else
        {
            var0.binoculars_onstateexitfunc[ 0 ] += 1;
        }
        
        if ( var0.vehicle.ref_13e83 == "tag_flash" )
        {
            var0.vehicle.ref_13e83 = "tag_flash_2";
        }
        else
        {
            var0.vehicle.ref_13e83 = "tag_flash";
        }
        
        br_pickupdenyweaponpickupap( var0.vehicle, "screenshake_fd_shoot", "rumble_fd_shoot" );
        ref_13fbf( var0, "ui_fd_target", 1, 12, 11, 0 );
        wait level.picking_up_minigun;
        
        if ( !var0 attackbuttonpressed() )
        {
            ref_13fbf( var0, "ui_fd_target", 0, 12, 1, 0 );
            return;
        }
    }
}

// Params 2
// Size: 0x3a
function ref_12636( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "death_or_disconnect" );
    var2 endon( "exiting_pilot_seat_aircraft" );
    
    for ( ;; )
    {
        var2 waittill( var1 );
        waittillframeend();
        var2 thread [[ var0.powers[ var1 ].func ]]( var0, var1 );
    }
}

// Params 1
// Size: 0x53
function ref_12635( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "exiting_pilot_seat_aircraft" );
    
    if ( isbot( var1 ) )
    {
        return;
    }
    
    foreach ( var3 in var0.powers )
    {
        thread ref_12636( var1, var0 );
    }
}

// Params 5
// Size: 0xe6
function bot_get_low_on_all_ammo( var0, var1, var2, var3, var4 )
{
    if ( !isplane( var0 ) )
    {
        notaplaneerror( var0 );
    }
    
    if ( isdefined( level.pindia_headlights ) && level.pindia_headlights > 0 )
    {
        var0.origin += ( 0, 0, level.pindia_headlights );
    }
    
    thread bot_gametype_get_num_players_on_team();
    thread bot_on_player_death();
    
    if ( var1 == "pilot" )
    {
        if ( istrue( level.phase_three_combat ) )
        {
            ref_13fbf( var3, "ui_fd_target", 2047, 0, 11, 1 );
            thread checkpoint_release_spawnpoint();
            thread binoculars_istargetinrange();
        }
        
        if ( istrue( level.picked_up_weapon ) )
        {
            init_player_health( var3 );
            thread ref_1315f();
        }
        
        thread ref_14231( var3 );
        thread ref_12635( var3 );
        
        if ( !istrue( level.phonesringing_singlemorse ) && istrue( level.pickclassbr ) )
        {
            thread br_allowloadout();
        }
        
        thread br_alt_mode_impulse_player();
        thread bot_pick_new_zone();
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc( var3, var4 );
}

// Params 0
// Size: 0x9b
function br_alt_mode_impulse_player()
{
    var0 = self;
    var0 endon( "exiting_pilot_seat_aircraft" );
    level endon( "game_ended" );
    wait 2;
    
    if ( !isdefined( var0.vehicle ) )
    {
        return;
    }
    
    var1 = var0.vehicle;
    var1 endon( "death" );
    var1.nuke_killplayerwithattacker = 0;
    
    while ( isdefined( var0 ) && isdefined( var0.vehicle ) )
    {
        if ( istrue( var1.shouldmodeplayfinalmoments ) && !istrue( var1.nuke_killplayerwithattacker ) )
        {
            var2 = var0 usinggamepad() && var0 fragbuttonpressed();
            var3 = !var0 usinggamepad() && var0 method_87d4();
            
            if ( var2 || var3 )
            {
                thread bot_get_flag_carrier();
            }
        }
        
        wait 0.2;
    }
}

// Params 0
// Size: 0x89
function bot_pick_new_zone()
{
    var0 = self;
    var0 endon( "exiting_pilot_seat_aircraft" );
    level endon( "game_ended" );
    wait 2;
    
    if ( !isdefined( var0.vehicle ) )
    {
        return;
    }
    
    var1 = var0.vehicle;
    var1 endon( "death" );
    
    if ( istrue( var1.shouldmodeplayfinalmoments ) )
    {
        return;
    }
    
    for ( ;; )
    {
        while ( var1 vehicle_getspeed() < 60 )
        {
            wait 0.2;
        }
        
        br_pickupdenyweaponpickupap( var1, "screenshake_fd_accell", "rumble_fd_accell" );
        
        while ( var1 vehicle_getspeed() > 60 )
        {
            wait 1.5;
        }
        
        if ( !isplane( var1 ) )
        {
            notaplaneerror( var1 );
            return;
        }
    }
}

// Params 0
// Size: 0xe0
function bot_get_flag_carrier()
{
    var0 = self;
    var0 endon( "death" );
    var0 notify( "engineSmokeThink" );
    var0 endon( "engineSmokeThink" );
    var0.nuke_killplayerwithattacker = 1;
    br_pickupdenyweaponpickupap( var0, "screenshake_fd_airbrake", "rumble_fd_airbrake" );
    var0 setscriptablepartstate( "engine_smoke", "engine_smoke", 1 );
    
    if ( soundexists( "s4_fd_air_brake" ) )
    {
        var0 playsoundtoplayer( "s4_fd_air_brake", var0.owner );
    }
    
    var1 = 1;
    
    for ( var2 = 1; isdefined( var0 ) && isdefined( var0.owner ) && ( var1 || var2 ) ; var2 = !var0.owner usinggamepad() && var0.owner method_87d4() )
    {
        wait 0.4;
        var1 = var0.owner usinggamepad() && var0.owner fragbuttonpressed();
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0.nuke_killplayerwithattacker = 0;
    var0 setscriptablepartstate( "engine_smoke", "base", 0 );
}

// Params 0
// Size: 0x205
function bot_gametype_get_num_players_on_team()
{
    var0 = self;
    var0 endon( "death" );
    var0 endon( "vehicle_contrails_debug" );
    level endon( "game_ended" );
    var0.ref_145c9 = 0;
    var0.helicrash = 0;
    var0.spawn_fake_letter = 0;
    
    for ( ;; )
    {
        if ( istrue( var0.ref_145c9 ) )
        {
            if ( var0 vehicle_getspeed() < level.pickuptrigger )
            {
                var0.ref_145c9 = 0;
                var0 setscriptablepartstate( "fx", "base", 0 );
            }
        }
        else if ( var0 vehicle_getspeed() > level.pickuptrigger )
        {
            var0.ref_145c9 = 1;
            var0 setscriptablepartstate( "fx", "trails", 0 );
        }
        
        if ( istrue( level.ph_checkforovertime ) )
        {
            if ( istrue( var0.helicrash ) )
            {
                if ( var0 vehicle_getspeed() < level.pickup_truck_initomnvars )
                {
                    var0.helicrash = 0;
                    var0 setscriptablepartstate( "cloud_contrail", "base", 0 );
                }
            }
            else if ( var0 vehicle_getspeed() > level.pickup_truck_initomnvars )
            {
                var0.helicrash = 1;
                var0 setscriptablepartstate( "cloud_contrail", "cloud_contrail", 0 );
            }
            
            if ( istrue( var0.spawn_fake_letter ) )
            {
                if ( var0 vehicle_getspeed() < level.pickupchecks || abs( var0.angles[ 2 ] ) < level.ph_loadouts )
                {
                    var0.spawn_fake_letter = 0;
                    var0.ref_138a5 = undefined;
                    var0 setscriptablepartstate( "fast_contrail", "base", 0 );
                }
            }
            else if ( var0 vehicle_getspeed() > level.pickupchecks && abs( var0.angles[ 2 ] ) > level.ph_loadouts )
            {
                var0.spawn_fake_letter = 1;
                var0.ref_138a5 = gettime();
                var0 setscriptablepartstate( "fast_contrail", "fast_contrail", 0 );
            }
        }
        
        if ( istrue( var0.spawn_fake_letter ) )
        {
            if ( isdefined( var0.ref_138a5 ) && gettime() - var0.ref_138a5 > 500 )
            {
                var0 setscriptablepartstate( "rumble_turn", "rumble_fd_turn", 0 );
                var0.ref_1443e = 1;
            }
        }
        else if ( istrue( var0.ref_1443e ) )
        {
            var0 setscriptablepartstate( "rumble_turn", "neutral", 0 );
            var0.ref_1443e = undefined;
        }
        
        wait 0.3;
    }
}

// Params 0
// Size: 0x30
function register_sequence_4_objectives()
{
    var0 = self;
    var1 = 0;
    
    if ( var0.shouldmodeplayfinalmoments )
    {
        var1 = 2;
    }
    else if ( var0 vehicle_getspeed() > 5 )
    {
        var1 = 1;
    }
    else
    {
        var1 = 0;
    }
    
    return var1;
}

// Params 5
// Size: 0x52
function bot_get_human_picked_class( var0, var1, var2, var3, var4 )
{
    if ( istrue( var4.success ) )
    {
        thread bot_get_landing_spot( var0, var1, var2, var3, var4 );
        return;
    }
    
    if ( !istrue( var4.playerdisconnect ) && !istrue( var4.playerdeath ) )
    {
        if ( var1 == "pilot" )
        {
            checkpoint_player_spawns_func( var3 );
            bot_pick_new_loadout_next_spawn( var3 );
            return;
        }
        
        return;
    }
}

// Params 5
// Size: 0x167
function bot_get_landing_spot( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var3.should_hide_buried_mother_corpse ) )
    {
        var3.should_hide_buried_mother_corpse = 1;
    }
    else
    {
        var3.should_hide_buried_mother_corpse += 1;
    }
    
    bot_pickup_origin( var3, var0, var1, var2, var4 );
    
    if ( isdefined( var3.carriable_set_dropped ) )
    {
        if ( isdefined( level.bot_shotguns ) )
        {
            var3 thread [[ level.bot_shotguns ]]();
        }
    }
    
    var5 = undefined;
    var6 = undefined;
    
    if ( isdefined( var2 ) && var2 == "gunner" )
    {
        var5 = "a10_warthog_fd";
        var6 = 3;
    }
    
    if ( var1 == "pilot" )
    {
        var0 setotherent( var3 );
        var0 setentityowner( var3 );
        var0.owner = var3;
        var3 controlslinkto( var0 );
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime( var3, 0 );
        var7 = scripts\cp_mp\vehicles\vehicle::ref_14192( var0, var0.ref_13e92 );
        var7.owner = var3;
        var3.vehicle.turret = var7;
        bot_gametype_get_allied_defenders_for_team( var3 );
        bots_with_player_enemy( var3, 1 );
        var3.binoculars_onstateexitfunc = [ 0, 0 ];
    }
    
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer( var0, var1, var2, undefined, var5, var6 );
    thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6( var4, 1 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter( var0, var2, var1, var3 );
    
    if ( getdvarint( "scr_enable_ap_visionset_override", 1 ) )
    {
        if ( isdefined( level.²(ÉgÈ— "c*C“°zQàGíµ× ) )
        {
            var3 visionsetnakedforplayer( level.²(ÉgÈ— "c*C“°zQàGíµ×, 0 );
        }
        else
        {
            var3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer( "mp_wz_island_ap" );
        }
    }
    
    wait 1;
    
    if ( istrue( level.pickprematchrandomloadout ) && isdefined( var3 ) && var1 == "pilot" )
    {
        var3 playerhide();
        return;
    }
}

// Params 5
// Size: 0x68
function bot_get_num_teammates_capturing_zone( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var1 ) && var1 == "pilot" )
    {
        thread ref_14230( var3 );
        bot_snipers( var3 );
        var3 notify( "exiting_pilot_seat_aircraft" );
        thread bot_next_difficulty_type_index();
        var3 notify( "aircraftHeadIconForceDelete" );
        bots_with_player_enemy( var3, 0 );
    }
    
    if ( istrue( var4.success ) )
    {
        var3 notify( "exiting_seat_aircraft" );
        bot_get_player_enemy( var0, var1, var2, var3, var4 );
        return;
    }
}

// Params 5
// Size: 0x13e
function bot_get_player_enemy( var0, var1, var2, var3, var4 )
{
    bot_protect_hq_zone( var3, var0, var1, var2, var4 );
    
    if ( var1 == "pilot" )
    {
        var0 setotherent( undefined );
        var0 setentityowner( undefined );
    }
    
    var5 = !isdefined( var2 );
    
    if ( var1 == "pilot" || var5 && var3 hasweapon( var0.ref_13e92 ) )
    {
        var6 = scripts\cp_mp\vehicles\vehicle::ref_14192( var0, var0.ref_13e92 );
        
        if ( !istrue( var4.playerdisconnect ) )
        {
            var3 enableturretdismount();
            var3 controlturretoff( var6 );
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime( var3, var4.playerdeath );
        }
        
        var6.owner = undefined;
        var6 setotherent( undefined );
        
        if ( !level.pistolweapon )
        {
            var6 setentityowner( undefined );
        }
        
        bot_pick_new_loadout_next_spawn( var3 );
    }
    
    if ( !istrue( var4.playerdisconnect ) )
    {
        var3 controlsunlink();
        
        if ( istrue( var4.playerdeath ) )
        {
            var3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
        }
        
        var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
        var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit( var3, var2, var4 );
        
        if ( !var7 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
            {
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( var3 );
            }
            else
            {
                var3 suicide();
            }
        }
    }
    
    if ( isdefined( level.ref_142d1 ) )
    {
        var3 visionsetnakedforplayer( level.ref_142d1, 0 );
    }
    else
    {
        var3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer( "", 0 );
    }
    
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit( var0, var1, var2, var3 );
}

// Params 1
// Size: 0x48
function bot_gametype_get_allied_defenders_for_team( var0 )
{
    if ( isdefined( var0.set_thirdperson ) )
    {
        return;
    }
    
    var0.set_thirdperson = 1;
    var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_a10fd" );
    
    if ( istrue( var1.ref_133d3 ) )
    {
        return;
    }
    
    var0 scripts\cp_mp\utility\damage_utility::adddamagemodifier( "ctmgGunnerMissileRedux", 0.4, 0, &bot_go_to_destination );
}

// Params 1
// Size: 0x43
function bot_pick_new_loadout_next_spawn( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.set_thirdperson ) )
    {
        return;
    }
    
    var0.set_thirdperson = undefined;
    var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "veh_a10fd" );
    
    if ( istrue( var1.ref_133d3 ) )
    {
        return;
    }
    
    var0 scripts\cp_mp\utility\damage_utility::removedamagemodifier( "ctmgGunnerMissileRedux", 0 );
}

// Params 7
// Size: 0x91
function bot_go_to_destination( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( var4 != "MOD_PROJECTILE_SPLASH" && var4 != "MOD_GRENADE_SPLASH" )
    {
        return 1;
    }
    
    if ( !isdefined( var5 ) )
    {
        return 1;
    }
    
    switch ( var5.basename )
    {
        case "tur_gun_fd_mp_seeking":
        case "iw8_la_t9launcher_mp":
        case "iw8_la_t9freefire_mp":
        case "lighttank_tur_mp":
        case "iw8_la_rpapa7_mp":
        case "iw8_la_kgolf_mp":
        case "iw8_la_juliet_mp":
        case "iw8_la_gromeo_mp":
        case "iw8_la_gromeoks_mp":
        case "iw8_la_mike32_mp":
        case "iw8_la_t9standard_mp":
            return 0;
        default:
            return 1;
    }
}

// Params 5
// Size: 0x1a
function bot_parachute_into_map( var0, var1, var2, var3, var4 )
{
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6( var4 );
    thread bot_pick_dd_zone_with_fewer_defenders( var0, var1, var2, var3, var4 );
}

// Params 5
// Size: 0x28
function bot_pick_dd_zone_with_fewer_defenders( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var2 ) && var2 == "pilot" )
    {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc( var3, var4 );
        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7( var5 );
        return;
    }
}

// Params 0
// Size: 0x5, Type: bool
function ref_13dda()
{
    return true;
}

// Params 1
// Size: 0xc4
function trophy_protectionsuccessful( var0 )
{
    self.ref_13ddf--;
    var1 = var0.origin;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_trophyDestroyTarget", "init" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_trophyDestroyTarget", "init" ) ]]( var0 );
    }
    
    var2 = trophy_getbesttag( var1 );
    self setscriptablepartstate( "trophy_detonate", var2 );
    var3 = vectortoangles( self gettagorigin( var2 ) - var1 );
    var4 = combineangles( var3, ( -90, 0, 0 ) );
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_trophyExplode", "init" ) )
    {
        self.explosion thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_trophyExplode", "init" ) ]]( var1, var4 );
    }
    
    if ( self.ref_13ddf == 0 )
    {
        self notify( "upgrade_message", "trophy_no_ammo" );
        self waittill( "trophy_ammo_refill" );
        return;
    }
    
    self notify( "upgrade_message", "trophy_ammo_used" );
}

// Params 1
// Size: 0x6d
function trophy_getbesttag( var0 )
{
    var1 = [ "tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4" ];
    var2 = undefined;
    var3 = undefined;
    
    foreach ( var5 in var1 )
    {
        var6 = self gettagorigin( var5 );
        var7 = distancesquared( var6, var0 );
        
        if ( var8 == 0 || var7 < var2 )
        {
            var2 = var7;
            var3 = var5;
        }
    }
    
    return var3;
}

// Params 0
// Size: 0x65
function bot_is_in_gas()
{
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "veh_a10fd", 1 );
    var0.maxinstancecount = 2;
    var0.priority = 75;
    var0.getspawnstructscallback = &bot_get_tdef_flag;
    var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc( "veh_a10fd", "spawnCallback" );
    var0.clearancecheckradius = 185;
    var0.clearancecheckheight = 138;
    var0.clearancecheckminradius = 185;
}

// Params 0
// Size: 0x54
function bot_get_tdef_flag()
{
    if ( isdefined( level.ref_1217d ) && level.ref_1217d.size != 0 )
    {
        var0 = level.ref_1217d;
    }
    else
    {
        var0 = scripts\engine\utility::getstructarray( "veh_a10fd", "targetname" );
    }
    
    if ( var0.size > 0 )
    {
        var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag( var0, 1 );
        
        if ( var0.size > 1 )
        {
            var0 = scripts\engine\utility::array_randomize( var0 );
        }
    }
    
    return var0;
}

// Params 1
// Size: 0x51
function bots_with_player_enemy( var0 )
{
    var1 = self;
    
    if ( !isdefined( var1 ) || !isdefined( var1.vehicle ) || isbot( var1 ) )
    {
        return;
    }
    
    var2 = var1.vehicle;
    
    if ( !isdefined( var2.br_alt_mode_inflation ) )
    {
        return;
    }
    
    var3 = bots_seek_player( var0, var2.br_alt_mode_inflation );
    var1 setclientomnvar( "ui_br_fd_state", var3 );
}

// Params 2
// Size: 0x23
function bots_seek_player( var0, var1 )
{
    var2 = 1;
    var3 = 3;
    var4 = int( var0 ) & var2;
    var4 += ( int( var1 ) & var3 ) << 1;
    return var4;
}

// Params 0
// Size: 0x6e
function br_allowloadout()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_aircraft" );
    var1 = -40;
    var2 = -135;
    var3 = 40;
    var4 = -135;
    var0.botloadoutfavoritecamoprimary = ref_12530( var0, var3, var4, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER" );
    
    while ( !isdefined( var0.vehicle ) )
    {
        wait 0.5;
    }
    
    thread br_ammo_update_ammotype_weapons();
}

// Params 0
// Size: 0x22
function bot_snipers()
{
    var0 = self;
    
    if ( isdefined( var0.botloadoutfavoritecamoprimary ) )
    {
        var0.botloadoutfavoritecamoprimary destroy();
    }
    
    var0.botloadoutfavoritecamoprimary = undefined;
}

// Params 0
// Size: 0xdd
function br_ammo_update_ammotype_weapons()
{
    var0 = self;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_aircraft" );
    
    for ( ;; )
    {
        if ( !isdefined( var0.vehicle ) )
        {
            return;
        }
        
        var1 = 0;
        
        foreach ( var3 in level.vehicle.instances[ "veh_a10fd" ] )
        {
            if ( istrue( var3.shouldmodeplayfinalmoments ) )
            {
                var1++;
            }
        }
        
        if ( isdefined( level.vehicle.instances[ "veh_bt" ] ) )
        {
            foreach ( var6 in level.vehicle.instances[ "veh_bt" ] )
            {
                if ( istrue( var6.shouldmodeplayfinalmoments ) )
                {
                    var1++;
                }
            }
        }
        
        var0.botloadoutfavoritecamoprimary setvalue( var1 );
        wait 3;
    }
}

// Params 8
// Size: 0x96
function ref_12530( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = init_player_plane_exit_anims( "default", 1 );
    var8.x = var0;
    var8.y = var1;
    var8.alignx = var2;
    var8.aligny = var3;
    var8.horzalign = var4;
    var8.vertalign = var5;
    var8.alpha = 1;
    var8.glowalpha = 0;
    var8.hidewheninmenu = 1;
    var8.archived = 0;
    
    if ( isdefined( var6 ) )
    {
        var8.label = var6;
    }
    
    if ( isdefined( var7 ) )
    {
        var8 setvalue( var7 );
    }
    
    return var8;
}

// Params 2
// Size: 0x86
function init_player_plane_exit_anims( var0, var1 )
{
    var2 = newclienthudelem( self );
    var2.elemtype = "font";
    var2.font = var0;
    var2.fontscale = var1;
    var2.basefontscale = var1;
    var2.x = 0;
    var2.y = 0;
    var2.width = 0;
    var2.height = int( level.fontheight * var1 );
    var2.xoffset = 0;
    var2.yoffset = 0;
    var2.children = [];
    var2.hidden = 0;
    return var2;
}

// Params 0
// Size: 0x17
function init_player_health()
{
    self.br_pelletmaxdamage = spawnstruct();
    self.br_pelletmaxdamage.ref_13a72 = [];
}

// Params 0
// Size: 0x3fb
function ref_1315f()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "aircraftHeadIconForceDelete" );
    var1 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
    {
        var1 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();
    }
    
    wait 2;
    
    while ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver( var0 ) )
    {
        var2 = [];
        var3 = rooftop_active( level.pilot_setups, level.pilot_model );
        var4 = var3[ 0 ];
        var5 = var3[ 1 ];
        var3 = undefined;
        
        foreach ( var7 in level.players )
        {
            if ( var7.team == var0.team )
            {
                continue;
            }
            
            if ( isdefined( level.br_pickupdenyalreadyhaveplatepouch ) )
            {
                if ( var7 [[ level.br_pickupdenyalreadyhaveplatepouch ]]() )
                {
                    continue;
                }
            }
            
            if ( isdefined( level.br_movingcirclemovedistmin ) )
            {
                if ( var7 [[ level.br_movingcirclemovedistmin ]]( "specialty_guerrilla" ) || var7 [[ level.br_movingcirclemovedistmin ]]( "specialty_covert_ops" ) )
                {
                    continue;
                }
            }
            
            if ( isdefined( var7.vehicle ) && isdefined( var7.vehicle.targetname ) && ( var7.vehicle.targetname == "veh_bt" || var7.vehicle.targetname == "veh_a10fd" ) )
            {
                if ( ref_1331b( var7.vehicle, var7 ) )
                {
                    var2 = scripts\engine\utility::array_add( var2, var7 );
                }
                
                continue;
            }
            
            if ( isdefined( var7.currentweapon ) && isdefined( var7.currentweapon.basename ) && ( var7.currentweapon.basename == "manual_turret_flak_mp_highrof" || var7.currentweapon.basename == "manual_turret_flak_mp" || var7.currentweapon.basename == "manual_turret_flak_vehicle" ) )
            {
                var2 = scripts\engine\utility::array_add( var2, var7 );
                continue;
            }
            
            var8 = ref_13d9c( var7.origin, var0.vehicle.origin, var4, var5 );
            
            if ( istrue( var8 ) )
            {
                var2 = scripts\engine\utility::array_add( var2, var7 );
            }
        }
        
        if ( isdefined( level.decoygrenades ) )
        {
            foreach ( var11 in level.decoygrenades )
            {
                if ( !isdefined( var11 ) )
                {
                    continue;
                }
                
                if ( isdefined( var11.team ) && var11.team == var0.team )
                {
                    continue;
                }
                
                var8 = ref_13d9c( var11.origin, var0.vehicle.origin, var4, var5 );
                
                if ( istrue( var8 ) )
                {
                    var2 = scripts\engine\utility::array_add( var2, var11 );
                }
            }
        }
        
        if ( isdefined( level.dummy_hint ) )
        {
            foreach ( var14 in level.dummy_hint )
            {
                if ( !isdefined( var14 ) )
                {
                    continue;
                }
                
                var8 = ref_13d9c( var14.origin, var0.vehicle.origin, var4, var5 );
                
                if ( istrue( var8 ) )
                {
                    var2 = scripts\engine\utility::array_add( var2, var14 );
                }
            }
        }
        
        if ( var2.size > 0 )
        {
            var16 = level.teamdata[ var0.team ][ "alivePlayers" ];
            
            if ( istrue( var1 ) )
            {
                var16 = level.squaddata[ var0.team ][ var0.squadindex ].players;
            }
            
            foreach ( var18 in var16 )
            {
                if ( !isalive( var18 ) )
                {
                    continue;
                }
                
                if ( isdefined( level.br_pickupdenyalreadyhaveplatepouch ) )
                {
                    if ( var18 [[ level.br_pickupdenyalreadyhaveplatepouch ]]() )
                    {
                        continue;
                    }
                }
                
                var19 = distance( var0.vehicle.origin, var18.origin );
                
                if ( var19 < 10000 )
                {
                    foreach ( var21 in var2 )
                    {
                        thread br_plunder_site_use_states( var18, var21 );
                    }
                }
            }
            
            if ( soundexists( "s4_fd_scan_ping" ) )
            {
                var0 playsoundtoplayer( "s4_fd_scan_ping", var0 );
            }
        }
        
        wait 3.25;
    }
}

// Params 2
// Size: 0xc9
function rooftop_active( var0, var1 )
{
    var2 = self;
    var2 notify( "get_sonar_cone_scan_vertices" );
    var2 endon( "get_sonar_cone_scan_vertices" );
    var3 = var2.vehicle.origin;
    var4 = anglestoforward( var2.vehicle.angles );
    var4 = ( var4[ 0 ], var4[ 1 ], 0 );
    var5 = vectorcross( var4, ( 0, 0, 1 ) );
    var6 = var4 * var0 * cos( var1 );
    var7 = var0 * sin( var1 );
    var8 = [];
    var9 = ( 0, 0, 0 );
    var10 = undefined;
    var11 = undefined;
    
    for ( var12 = 0; var12 < 2 ; var12++ )
    {
        var13 = var12 / 2 * 360;
        var14 = var3 + var6 + var7 * var5 * cos( var13 );
        var9 = var14;
        
        if ( isdefined( var11 ) )
        {
            var10 = var14;
            continue;
        }
        
        var11 = var14;
    }
    
    return [ var10, var11 ];
}

// Params 4
// Size: 0x1d
function ref_13d9c( var0, var1, var2, var3 )
{
    var4 = updatescrapassistdataforcecredit( var0, var1, var2, var3 );
    
    if ( var4 )
    {
        return 1;
    }
    
    return 0;
}

// Params 4
// Size: 0x31, Type: bool
function updatescrapassistdataforcecredit( var0, var1, var2, var3 )
{
    if ( !use_nvg_think( var0, var1, var2 ) )
    {
        return false;
    }
    
    if ( !use_nvg_think( var0, var2, var3 ) )
    {
        return false;
    }
    
    if ( !use_nvg_think( var0, var3, var1 ) )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x2c, Type: bool
function use_nvg_think( var0, var1, var2 )
{
    return ( var2[ 0 ] - var1[ 0 ] ) * ( var0[ 1 ] - var1[ 1 ] ) - ( var0[ 0 ] - var1[ 0 ] ) * ( var2[ 1 ] - var1[ 1 ] ) < 0;
}

// Params 1
// Size: 0x63, Type: bool
function ref_1331b( var0 )
{
    var1 = self;
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( var1 );
    
    if ( isdefined( var2 ) )
    {
        if ( var2 == var0 )
        {
            return true;
        }
    }
    else
    {
        var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var1 );
        
        foreach ( var5 in var3 )
        {
            if ( var5 == var0 )
            {
                return true;
            }
            
            break;
        }
    }
    
    return false;
}

// Params 2
// Size: 0xa6
function br_plunder_site_use_states( var0, var1 )
{
    var2 = self;
    var3 = undefined;
    
    if ( isdefined( var0.type ) && var0.type == "br_loot_cache_lege" )
    {
        var4 = "hud_icon_ground_marked_obj_leg";
        var3 = var0.origin;
    }
    else if ( updatedroprelicsfunc( var1 ) || var1 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader() )
    {
        var4 = "hud_icon_air_marked";
    }
    else
    {
        var4 = "hud_icon_ground_marked";
    }
    
    var5 = 8;
    var6 = 1;
    var7 = 500;
    var8 = 31500;
    var9 = var2 scripts\cp_mp\entityheadicons::setheadicon_singleimage( var4, var4, var5, var6, var8, var7, undefined, 1, 1, var4 );
    br_prematchspawnlocations( var4, var2 );
    scriptedspawnpointarray( var4, var2, var3 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var9 );
}

// Params 2
// Size: 0xa1
function scriptedspawnpointarray( var0, var1 )
{
    var2 = self;
    
    if ( !isdefined( level.br_movingcirclegulagcloseoffset ) )
    {
        return;
    }
    
    if ( !isdefined( var2 ) || !isdefined( var0 ) || !isdefined( var1 ) || !isdefined( var0.lastkilledby ) || !isdefined( var0.lastkilledby.team ) )
    {
        return;
    }
    
    if ( !isent( var0 ) || !isplayer( var0 ) )
    {
        return;
    }
    
    if ( var0.health != 0 )
    {
        return;
    }
    
    if ( var2 != var1 )
    {
        return;
    }
    
    if ( var2 == var1 && var0.lastkilledby.team == var1.team && var0.lastkilledby != var1 )
    {
        var1 thread [[ level.br_movingcirclegulagcloseoffset ]]( "br_fd_mark_assist" );
        return;
    }
}

// Params 1
// Size: 0x2d
function br_prematchspawnlocations( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "aircraftHeadIconForceDelete" );
    var0 scripts\engine\utility::waittill_notify_or_timeout( "death_or_disconnect", 3 );
}

// Params 0
// Size: 0x3c, Type: bool
function updatedroprelicsfunc()
{
    var0 = self;
    
    if ( isdefined( var0.vehicle ) && isdefined( var0.vehicle.targetname ) && var0.vehicle.targetname == "veh_a10fd" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x2e, Type: bool
function unreachable_function()
{
    var0 = self;
    
    if ( var0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( var0.targetname ) && var0.targetname == "veh_a10fd" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x40, Type: bool
function unrescuable_fail()
{
    var0 = self;
    
    if ( isdefined( var0.classname ) && var0.classname == "misc_turret" && isdefined( var0.model ) && var0.model == "veh_s4_mil_air_dalpha_wz_turret_attach" )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x160
function checkpoint_release_spawnpoint()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "exiting_pilot_seat_aircraft" );
    wait 2;
    
    if ( !isdefined( var0.vehicle ) )
    {
        ref_13fbf( var0, "ui_fd_target", 2047, 0, 11, 1 );
        return;
    }
    
    var0.br_standard_loadout = spawnstruct();
    var1 = var0.vehicle.turret;
    
    while ( isdefined( var0.vehicle ) )
    {
        var0.br_standard_loadout.checkpoint_set = [];
        
        if ( istrue( level.phase_zero_combat ) )
        {
            if ( !istrue( var0.vehicle.binoculars_onstateenterfunc ) )
            {
                ref_13fbf( var0, "ui_fd_target", 2047, 0, 11, 0 );
                wait level.phclass;
                continue;
            }
        }
        
        if ( istrue( level.phase_three_combat ) && isdefined( var0.vehicle.turret ) )
        {
            var2 = var0.vehicle.turret method_87cf( "tag_flash" );
            
            if ( checkpoint_trigger( var2 ) )
            {
                var0.br_standard_loadout.checkpoint_set[ 0 ] = var2;
            }
        }
        
        checkpoint_register( var0 );
        wait level.phclass;
        
        if ( isdefined( var0.br_standard_loadout ) && isdefined( var0.br_standard_loadout.target ) && !isalive( var0.br_standard_loadout.target ) )
        {
            var0.br_standard_loadout.target = undefined;
            checkpoint_register( var0 );
            ref_13fbf( var0, "ui_fd_target", 2047, 0, 11, 1 );
        }
    }
}

// Params 1
// Size: 0x140, Type: bool
function checkpoint_trigger( var0 )
{
    var1 = self;
    var2 = isdefined( var0 );
    
    if ( var2 )
    {
        var3 = isdefined( var0.owner );
        var4 = var3 && isdefined( var0.owner.team ) && var0.owner.team != "neutral";
        var5 = var3 && isdefined( var0.owner.vehicle ) && var0.owner.vehicle == var0;
        var6 = var5 && var4 && var0.owner.team != var1.team;
        var7 = isdefined( var0.team ) && var0.team != "neutral";
        var8 = undefined;
        var9 = isplayer( var0 ) && var0 isskydiving() && istrue( level.pilot_linkto_origin_offset );
        var10 = isplayer( var0 ) && istrue( var0.ref_125cd );
        var11 = isdefined( var0.agent_type ) && ( var0.agent_type == "actor_kenosha" || var0.agent_type == "actor_greenbay" );
        
        if ( var0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            if ( var6 )
            {
                return true;
            }
        }
        else if ( var7 && !var11 )
        {
            var8 = var0.team != var1.team;
            
            if ( var8 && !var9 && !var10 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 1
// Size: 0x1b
function checkpoints_init( var0 )
{
    return ( var0 gettagorigin( "tag_flash" ) + var0 gettagorigin( "tag_flash_2" ) ) / 2;
}

// Params 1
// Size: 0xe
function checkpoints_count( var0 )
{
    return var0 gettagangles( "tag_flash" );
}

// Params 3
// Size: 0x2a
function ref_127df( var0, var1, var2 )
{
    return ( var2[ 0 ] - var1[ 0 ] ) * ( var0[ 1 ] - var1[ 1 ] ) - ( var0[ 0 ] - var1[ 0 ] ) * ( var2[ 1 ] - var1[ 1 ] );
}

// Params 0
// Size: 0x20
function checkpoint_player_spawns_func()
{
    var0 = self;
    ref_13fbf( var0, "ui_fd_target", 2047, 0, 11, 1 );
    var0.br_standard_loadout = undefined;
}

// Params 0
// Size: 0x178
function checkpoint_register()
{
    var0 = self;
    var1 = var0.br_standard_loadout.checkpoint_set;
    
    if ( !isdefined( var1 ) || var1.size <= 0 )
    {
        var0.br_standard_loadout.target = undefined;
        ref_13fbf( var0, "ui_fd_target", 2047, 0, 11, 1 );
        return;
    }
    
    var2 = checkpoints_init( var0.vehicle.turret );
    var3 = anglestoforward( var0.vehicle.angles );
    var4 = var3 * level.phaseindex * cos( level.phase_two_combat );
    var5 = var2 + var4;
    var6 = undefined;
    var7 = undefined;
    
    foreach ( var9 in var1 )
    {
        var10 = ref_127df( var9.origin, var2, var5 );
        
        if ( !isdefined( var7 ) || var10 < var7 )
        {
            var7 = var10;
            var6 = var9;
        }
    }
    
    if ( isdefined( var0.br_standard_loadout.target ) && var6 == var0.br_standard_loadout.target )
    {
        ref_13fbf( var0, "ui_fd_target", var6 getentitynumber(), 0, 11, 0 );
        return;
    }
    
    var0.br_standard_loadout.target = var6;
    ref_13fbf( var0, "ui_fd_target", var6 getentitynumber(), 0, 11, 1 );
    
    if ( soundexists( "s4_fd_target_locked" ) )
    {
        var0 playsoundtoplayer( "s4_fd_target_locked", var0 );
    }
    
    if ( isdefined( var6.vehicle ) )
    {
        ref_13fbf( var0, "ui_fd_target", 1, 11, 1, 0 );
        return;
    }
    
    ref_13fbf( var0, "ui_fd_target", 0, 11, 1, 0 );
}

// Params 5
// Size: 0x6d
function ref_13fbf( var0, var1, var2, var3, var4 )
{
    var5 = self;
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var6 = int( pow( 2, var3 ) ) - 1;
    var7 = ( var1 & var6 ) << var2;
    var8 = ~( var6 << var2 );
    var9 = self calloutmarkerping_entityzoffset( var0 );
    
    if ( istrue( var4 ) )
    {
        self setclientomnvar( var0, var7 );
        return;
    }
    else if ( !isdefined( var9 ) )
    {
        var9 = var8;
    }
    
    var10 = var9 & var8;
    
    if ( !isdefined( var7 ) )
    {
        return;
    }
    
    var11 = var10 + var7;
    
    if ( var11 != var9 )
    {
        self setclientomnvar( var0, var11 );
        return;
    }
}

// Params 0
// Size: 0xbb
function binoculars_istargetinrange()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    
    if ( isbot( var0 ) )
    {
        return;
    }
    
    while ( !isdefined( var0.vehicle ) )
    {
        waitframe();
    }
    
    if ( !isdefined( var0.vehicle ) )
    {
        return;
    }
    
    var0.vehicle endon( "death" );
    var0 endon( "exiting_seat_aircraft" );
    var0.vehicle.binoculars_onstateenterfunc = 0;
    var1 = 0;
    
    while ( isdefined( var0.vehicle ) )
    {
        while ( var1 == var0 adsbuttonpressed() )
        {
            waitframe();
        }
        
        var1 = var0 adsbuttonpressed();
        
        if ( var1 )
        {
            var0.vehicle.binoculars_onstateenterfunc = 1;
            var0 setclientomnvar( "ui_airplane_ads_active", 1 );
            continue;
        }
        
        var0.vehicle.binoculars_onstateenterfunc = 0;
        var0 setclientomnvar( "ui_airplane_ads_active", 0 );
    }
}

// Params 1
// Size: 0x3b
function loadout_finalizeweapons( var0 )
{
    if ( !isdefined( self.loadout_fixcopiedclassstruct ) )
    {
        self.loadout_fixcopiedclassstruct = 1;
        self method_87d0( 0 );
        ref_13fec( var0, 1 );
        return;
    }
    
    var1 = ref_13fec( var0, 1 );
    
    if ( var1 )
    {
        self.loadout_fixcopiedclassstruct++;
        return;
    }
}

// Params 1
// Size: 0x38
function move_structs( var0 )
{
    if ( isdefined( self.loadout_fixcopiedclassstruct ) )
    {
        var1 = ref_13fec( var0, 0 );
        
        if ( var1 )
        {
            self.loadout_fixcopiedclassstruct--;
        }
        
        if ( !self.loadout_fixcopiedclassstruct )
        {
            self method_87d0( 1 );
            self.loadout_fixcopiedclassstruct = undefined;
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0xb8
function ref_13fec( var0, var1 )
{
    if ( !isdefined( self.loadout_getglobalclassstruct ) )
    {
        self.loadout_getglobalclassstruct = [ 0, 0, 0, 0, 0 ];
    }
    
    var2 = undefined;
    
    switch ( var0 )
    {
        case "vehicle":
            var2 = 0;
            break;
        case "gulag":
            var2 = 1;
            break;
        case "laststand":
            var2 = 2;
            break;
        case "skydive":
            var2 = 3;
            break;
        case "aa_turret":
            var2 = 4;
            break;
    }
    
    if ( !isdefined( var2 ) )
    {
        return 0;
    }
    
    if ( var1 )
    {
        if ( istrue( self.loadout_getglobalclassstruct[ var2 ] ) )
        {
            return 0;
        }
        
        self.loadout_getglobalclassstruct[ var2 ] = 1;
        return 1;
    }
    
    if ( istrue( self.loadout_getglobalclassstruct[ var2 ] ) )
    {
        self.loadout_getglobalclassstruct[ var2 ] = 0;
        return 1;
    }
    
    return 0;
}

// Params 2
// Size: 0x31
function br_pickupdenyweaponpickupap( var0, var1 )
{
    var2 = self;
    
    if ( !isplane( var2 ) )
    {
        notaplaneerror( var2 );
        return;
    }
    
    var2 setscriptablepartstate( "screenshake", var0, 0 );
    var2 setscriptablepartstate( "rumble", var1, 0 );
}

// Params 1
// Size: 0x2b, Type: bool
function isplane( var0 )
{
    return unreachable_function( var0 ) && var0.model == "veh_s4_mil_air_dalpha_wz" && var0.vehiclename == "veh_a10fd";
}

// Params 2
// Size: 0x27
function notaplaneerror( var0, var1 )
{
    var2 = "Vehicle is not a plane: vehicleName = " + var1.vehiclename + ", model = " + var1.model;
    var3 = var2 == undefined;
}

// Params 4
// Size: 0x123
function bot_pickup_origin( var0, var1, var2, var3 )
{
    var4 = self;
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    var4.br_pickupdenyalreadyhavequest = gettime();
    bot_set_difficultysetting( var4, var0, var1 );
    var5 = [];
    var6 = respawntags( var0 );
    var5 = "plane_type";
    var5 = var6;
    var7 = retreat_vehicle_collision_clear( var4, var2 );
    var5 = "player_type_enter";
    var5 = var7;
    
    if ( var7 == "enter_vehicle" )
    {
        var8 = restartcircleelimination( var4 );
        var5 = "entering_vehicle_status";
        var5 = var8;
        var9 = register_trap_room_objectives( var4 );
        var5 = "airplane_map_location";
        var5 = var9;
        var10 = register_valid_gametypes_for_create_script( var4 );
        var5 = "num_airplanes_in_air";
        var5 = var10;
        var11 = restock_dialoguesectionalogic( var4 );
        var5 = "player_input_type";
        var5 = var11;
    }
    else
    {
        var5 = "entering_vehicle_status";
        var5 = "";
        var5 = "airplane_map_location";
        var5 = "";
        var5 = "num_airplanes_in_air";
        var5 = 0;
        var5 = "player_input_type";
        var5 = "";
    }
    
    var4 dlog_recordplayerevent( "dlog_event_plane_player_enter", var5 );
}

// Params 4
// Size: 0x284
function bot_protect_hq_zone( var0, var1, var2, var3 )
{
    var4 = self;
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    var5 = [];
    var6 = respawntags( var0 );
    var5 = "plane_type";
    var5 = var6;
    var7 = retreatanddie( var4, var2 );
    var5 = "player_type_exit";
    var5 = var7;
    
    if ( var7 == "exit_vehicle" )
    {
        var8 = restartwrapper( var4, var3 );
        var5 = "exit_vehicle_cause";
        var5 = var8;
        var9 = respawntimedisable( var4 );
        var5 = "airplane_play_session";
        var5 = var9;
        
        if ( var8 == "death" )
        {
            var10 = register_techo_seat_data( var0 );
            var5 = "airplane_majority_dmg_type";
            var5 = var10;
            var11 = register_subway_track( var4 );
            var5 = "airplane_cause_death";
            var5 = var11;
            var12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 ).size + 1;
            var5 = "num_airplane_occupants";
            var5 = var12;
            var13 = register_trap_room_objectives( var4 );
            var5 = "airplane_exit_map_location";
            var5 = var13;
        }
        else
        {
            var5 = "airplane_majority_dmg_type";
            var5 = "";
            var5 = "airplane_cause_death";
            var5 = "";
            var5 = "num_airplane_occupants";
            var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 ).size + 1;
            var5 = "airplane_exit_map_location";
            var5 = "";
        }
    }
    else
    {
        var5 = "exit_vehicle_cause";
        var5 = "";
        var5 = "airplane_play_session";
        var5 = 0;
        var5 = "airplane_majority_dmg_type";
        var5 = "";
        var5 = "airplane_cause_death";
        var5 = "";
        var5 = "num_airplane_occupants";
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( var0 ).size + 1;
        var5 = "airplane_exit_map_location";
        var5 = "";
    }
    
    var4 dlog_recordplayerevent( "dlog_event_plane_player_exit", var5 );
    
    if ( isdefined( var4.br_pe_chopper_damage_time ) )
    {
        var4.br_pe_chopper_damage_time = undefined;
    }
    
    if ( isdefined( var4.br_onvehicledeath ) )
    {
        var4.br_onvehicledeath = undefined;
    }
    
    bot_set_difficultysetting( var4, var0, var1 );
    
    if ( isdefined( var4.binoculars_onstateexitfunc ) && unreachable_function( var0 ) )
    {
        if ( isdefined( var4.binoculars_onstateexitfunc[ 0 ] ) && isdefined( var4.binoculars_onstateexitfunc[ 1 ] ) && var4.binoculars_onstateexitfunc[ 1 ] > 0 )
        {
            var4 dlog_recordplayerevent( "dlog_event_plane_dauntless_ads_usage", [ "ads_bullets", var4.binoculars_onstateexitfunc[ 0 ], "auto_target_bullets", var4.binoculars_onstateexitfunc[ 1 ] ] );
        }
        
        var4.binoculars_onstateexitfunc = undefined;
        return;
    }
}

// Params 0
// Size: 0x44
function restartcircleelimination()
{
    var0 = self;
    
    if ( !isdefined( var0.should_hide_buried_mother_corpse ) )
    {
        return "";
    }
    
    if ( var0.should_hide_buried_mother_corpse < 0 )
    {
        return "first_time_entering";
    }
    
    if ( var0.should_hide_buried_mother_corpse == 0 )
    {
        return "re_entering_new_life";
    }
    
    return "re_entering_same_life";
}

// Params 0
// Size: 0x31
function respawntags()
{
    var0 = self;
    
    if ( unreachable_function( var0 ) )
    {
        return 1;
    }
    
    if ( var0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() )
    {
        return 2;
    }
    
    if ( var0 _calloutmarkerping_onpingchallenge::unset_force_aitype_riotshield() )
    {
        return 3;
    }
    
    return 0;
}

// Params 1
// Size: 0x1a
function retreat_vehicle_collision_clear( var0 )
{
    var1 = self;
    
    if ( isdefined( var0 ) )
    {
        return "seat_swapping";
    }
    
    return "enter_vehicle";
}

// Params 0
// Size: 0x1e
function register_trap_room_objectives()
{
    var0 = self;
    
    if ( !isdefined( var0.calloutarea ) )
    {
        return "";
    }
    
    return var0.calloutarea;
}

// Params 0
// Size: 0xd4
function register_valid_gametypes_for_create_script()
{
    var0 = self;
    var1 = 0;
    
    if ( !isdefined( level.vehicle ) || !isdefined( level.vehicle.instances ) )
    {
        return var1;
    }
    
    if ( isdefined( level.vehicle.instances[ "veh_a10fd" ] ) )
    {
        foreach ( var3 in level.vehicle.instances[ "veh_a10fd" ] )
        {
            if ( istrue( var3.shouldmodeplayfinalmoments ) )
            {
                var1++;
            }
        }
    }
    
    if ( isdefined( level.vehicle.instances[ "veh_bt" ] ) )
    {
        foreach ( var6 in level.vehicle.instances[ "veh_bt" ] )
        {
            if ( istrue( var6.shouldmodeplayfinalmoments ) )
            {
                var1++;
            }
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x1a
function restock_dialoguesectionalogic()
{
    var0 = self;
    
    if ( var0 usinggamepad() )
    {
        return "controller";
    }
    
    return "kbm";
}

// Params 1
// Size: 0x1a
function retreatanddie( var0 )
{
    var1 = self;
    
    if ( isdefined( var0 ) )
    {
        return "seat_swapping";
    }
    
    return "exit_vehicle";
}

// Params 1
// Size: 0x23
function restartwrapper( var0 )
{
    var1 = self;
    
    if ( !isdefined( var0.onprematchfadedone2 ) )
    {
        return "";
    }
    
    return tolower( var0.onprematchfadedone2 );
}

// Params 0
// Size: 0x28
function respawntimedisable()
{
    var0 = self;
    
    if ( !isdefined( var0.br_pickupdenyalreadyhavequest ) )
    {
        return 0;
    }
    
    var1 = int( ( gettime() - var0.br_pickupdenyalreadyhavequest ) / 1000 );
    return var1;
}

// Params 0
// Size: 0x61
function register_techo_seat_data()
{
    var0 = self;
    var1 = 0;
    var2 = 0;
    
    if ( isdefined( var0.waitthensetgendersoundcontext ) )
    {
        var3 = 1;
        
        while ( var3 < var0.waitthensetgendersoundcontext.size )
        {
            if ( var1 < var0.waitthensetgendersoundcontext[ var3 ] )
            {
                var1 = var0.waitthensetgendersoundcontext[ var3 ];
                var2 = var3;
            }
            
            var3 += 2;
        }
        
        var4 = var0.waitthensetgendersoundcontext[ var2 - 1 ];
        return var4;
    }
    
    return "";
}

// Params 0
// Size: 0x1e
function register_subway_track()
{
    var0 = self;
    
    if ( isdefined( var0.br_pe_chopper_damage_time ) )
    {
        return var0.br_pe_chopper_damage_time;
    }
    
    return "";
}

// Params 2
// Size: 0x107
function bot_set_difficultysetting( var0, var1 )
{
    var2 = self;
    var3 = -1;
    
    if ( !isdefined( level.ref_13b94 ) )
    {
        level.ref_13b94 = [ "bomber_pilot", 0, "bomber_gunner", 0, "dauntless_pilot", 0, "dauntless_passenger", 0 ];
    }
    
    switch ( var1 )
    {
        case "pilot":
            if ( unreachable_function( var0 ) )
            {
                var3 = 5;
            }
            else
            {
                var3 = 1;
            }
            
            break;
        case "gunner":
            var3 = 7;
            break;
        case "seat_four":
        case "seat_three":
        case "seat_two":
            var3 = 3;
            break;
        default:
            break;
    }
    
    if ( var3 < 0 || !isdefined( var2 ) )
    {
        return;
    }
    
    if ( !isdefined( var2.ref_13b95 ) )
    {
        var2.ref_13b95 = gettime();
        return;
    }
    
    var2.ref_13b95 = int( ( gettime() - var2.ref_13b95 ) / 1000 );
    level.ref_13b94[ var3 ] += var2.ref_13b95;
    var2.ref_13b95 = undefined;
    getentitylessscriptablearray( "dlog_event_plane_time_spent_per_seat", level.ref_13b94 );
}

