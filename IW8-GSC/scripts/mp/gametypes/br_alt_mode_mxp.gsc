
// Params 0
// Size: 0x2
function activate_laser_trap_parent()
{
    
}

// Params 0
// Size: 0x63
function init()
{
    if ( !getdvarint( "scr_br_alt_mode_mxp", 0 ) )
    {
        return;
    }
    
    unloadinfiltransient( "mp_infil_wz_island_greenbay_tr" );
    unloadinfiltransient( "mp_infil_wz_island_kenosha_tr" );
    teleportplayertoselection();
    tr_vis_radius_override_lod2();
    zombieregendelayscaleingas();
    vehicle_outline_watcher();
    post_safeges_weapon();
    testing();
    ref_13220();
    toggle_ai_settings();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "killstreak", "aim_override", &binocularsseegk );
    thread toggleusbstickinhand();
}

// Params 0
// Size: 0x5bf
function tr_vis_radius_override_lod2()
{
    level.disable_super_in_turret.brlootchoppercratedestroycallback = 1;
    level.disable_oob_immunity_on_riders = 1;
    level.ref_11e18 = spawnstruct();
    level.ref_11e18.¾YVÊè¥¶V‰•î²Væ‘ÒÂ±·Î6´æÊÍ = getdvarfloat( "scr_br_mxp_ee_time_between_lines", 1.5 );
    level.ref_11e18.–;²:>%ih»jÜ7ğ¼êS[À? µ;êÄJƒu = getdvarint( "scr_br_mxp_k_head_challenge_trig_height", 1250 );
    level.ref_11e18.¢¼µĞ²°ŒØX6V¹ì²N´vì+“9XÈÒºÜ = getdvarint( "scr_br_mxp_k_head_challenge_trig_radius", 750 );
    level.ref_11e18.ƒsÚĞØØÊÜì¬£9Zì•É4VZ³†è = getdvarint( "scr_br_mxp_k_challenge_trig_height", 1750 );
    level.ref_11e18.²¯QğÆôq7?ï1ĞøJƒOU0+‚ = getdvarint( "scr_br_mxp_k_challenge_trig_radius", 150 );
    level.ref_11e18.‹¿šCãå'²8
>¹ñ_ê¡g  = getdvarfloat( "scr_br_mxp_k_stand_on_head_dur", 2.5 );
    level.ref_11e18.±”Y•}6Û½±ÈÛİæ}‘]9ÑZ½¹ = getdvarfloat( "scr_br_mxp_ee_cooldown", 1 );
    level.ref_11e18.>Š¤kã;Dã(‡|Q£Ìui = getdvarint( "scr_br_mxp_kk_jump_trace_test_height", 2000 );
    level.ref_11e18.¶c÷­ë{‡|ÇÆ»¯š*PW’ = getdvarint( "scr_br_mxp_k_jump_distance_mid", 17500 );
    level.ref_11e18.±Öµ¦Wµ8Œ–›è…æØÊ­ZÈÜ¸ = level.ref_11e18.¶c÷­ë{‡|ÇÆ»¯š*PW’ * level.ref_11e18.¶c÷­ë{‡|ÇÆ»¯š*PW’;
    level.ref_11e18.†bmMÕ[ÁŒKnXÍ¬{¹Î = getdvarint( "scr_br_mxp_k_jump_distance_long", 27500 );
    level.ref_11e18.¾f’º…¨Ai£ğ0èç­¶Ù{ = level.ref_11e18.†bmMÕ[ÁŒKnXÍ¬{¹Î * level.ref_11e18.†bmMÕ[ÁŒKnXÍ¬{¹Î;
    level.ref_11e18.†x‹U°ùb’·Ä¬«x¡ = getdvarint( "scr_br_mxp_k_jump_gravity_min", 4000 );
    level.ref_11e18.§m©®kvœ,g¥G—µ- = getdvarint( "scr_br_mxp_k_jump_gravity_mid", 8000 );
    level.ref_11e18.©[J‚Ş‰¤øÙã = getdvarint( "scr_br_mxp_k_jump_gravity_max", 12500 );
    level.ref_11e18.M*ÊwIr³èŠ3  = getdvarint( "scr_br_mxp_k_jump_speed_short_range", 6000 );
    level.ref_11e18.–MÇPí¸ë5iÀƒ9 = getdvarint( "scr_br_mxp_k_jump_speed_mid_range", 7500 );
    level.ref_11e18.¯M[S]Ú7Á¬+‘¶XÃ = getdvarint( "scr_br_mxp_k_jump_speed_long_range", 9000 );
    level.ref_11e18.Šàƒ0•_#P¡p8ë“İSµ[¨´¥¨ = getdvarint( "scr_mxp_k_ground_pound_stun_duration", 2 );
    level.ref_11e18.›5t*mòÓp½S›ˆM' = getdvarint( "scr_mxp_k_ground_pound_radius", 4000 );
    level.ref_11e18.¸T’hhG³âR¨ÿó = getdvarfloat( "scr_mxp_k_roar_duration", 1.25 );
    level.ref_11e18.©‡ˆğAá•ªf}ƒª = getdvarfloat( "scr_mxp_g_roar_duration", 2.5 );
    level.ref_11e18.¯3Ä™€7¼I¨ÂÚ ½6ï8uMZ§‹W = getdvarfloat( "scr_mxp_light_feedback_duration", 0.5 );
    level.ref_11e18.›ƒ£Ú¬FÒ«­Ì¬•Œ°­F®ÉX-Ş¹ = getdvarfloat( "scr_mxp_medium_feedback_duration", 1 );
    level.ref_11e18.–ŠÑ•Xì/™²YF&Øm2êä…G–Ûæ = getdvarfloat( "scr_mxp_heavy_feedback_duration", 1.25 );
    level.ref_11e18.¢ïÙAyã%=ŸZ³	3ƒ0X‡m = getdvarint( "scr_mxp_light_feedback_range", 10000 );
    level.ref_11e18.“\£[V-]k3¬¬‰Âµ9›Ù+ = getdvarint( "scr_mxp_medium_feedback_range", 10000 );
    level.ref_11e18.½"ÑÊìË™Y¬‘&ÂÖä…7;• = getdvarint( "scr_mxp_heavy_feedback_range", 10000 );
    level.ref_11e18.wait_for_player_in_gas = getdvarint( "scr_br_mxp_k_min_actions", 2 );
    level.ref_11e18.wait_for_player_gulag_respawn = getdvarint( "scr_br_mxp_k_max_actions", 3 );
    level.ref_11e18.select_bunker_courtyard_spawners = getdvarfloat( "scr_br_mxp_g_ks_chance", 0.5 );
    level.ref_11e18.select_bunker_interior_groups = getdvarint( "scr_br_mxp_g_ks_max", 20000 );
    level.ref_11e18.select_bunker_interior_four_spawners = getdvarint( "scr_br_mxp_g_ks_max", 10000 );
    level.ref_11e18.‘·³æ[[–±6n'¬ÂÚ“,‘ZÕÜ = getdvarint( "scr_br_mxp_k_gz_small", 1000 );
    level.ref_11e18.wait_for_players_init_puzzle = getdvarint( "scr_br_mxp_k_ks_max", 20000 );
    level.ref_11e18.wait_for_player_to_getup = getdvarint( "scr_br_mxp_k_ks_max", 8000 );
    level.ref_11e18.waitandstartplunderpolling = getdvarint( "scr_br_mxp_k_ks_small", 2000 );
    level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM = getdvarint( "scr_br_mxp_damage_intel", 300 );
    level.ref_11e18.‡#µ³¬«Í–c7ŞÒY = getdvarint( "scr_br_mxp_damage_notice", 1200 );
    level.ref_11e18.‹uXêO0R×Ÿ½ßKÇ ùÃÃ = getdvarint( "scr_br_mxp_k_swat_aggro_radius", 6000 );
    level.ref_11e18.jÖnîÂ£,N·¡•KÎ† = getdvarint( "scr_br_mxp_k_swat_aggro_height", 3500 );
    level.ref_11e18.ƒ½#ş«Ç#éºRXùİc!fµ´ = getdvarint( "scr_br_mxp_k_swat_height_offset", 0 );
    level.ref_11e18.©¬Èzß •#?/wš = getdvarfloat( "scr_br_mxp_k_swat_yaw_mid", 40 );
    level.ref_11e18.‚¬„3à9ó‹Ÿó = getdvarfloat( "scr_br_mxp_k_swat_yaw_max", 115 );
    level.ref_11e18.—WOó7(âÎˆóË = getdvarint( "scr_br_mxp_k_swat_radius", 350 );
    level.ref_11e18.‚]x#Ï¿¨e+?€Ã = getdvarint( "scr_br_mxp_k_swat_height", 500 );
    level.ref_11e18.“«­Ò­–è°7-k7²,m = getdvarint( "scr_br_mxp_k_limit_anims_peak", 1 );
    level.ref_11e18.[µÂ£“£ÊX£°Æ¶ = getdvarint( "scr_br_mxp_k_alt_crate", 1 );
    level.ref_11e18.Å
_8šä Pªs = getdvarint( "scr_br_mxp_g_goal_dist", 100 );
    level.ref_11e18.¬“ßµ H+Wã³÷hy» = level.ref_11e18.Å
_8šä Pªs * level.ref_11e18.Å
_8šä Pªs;
    level.ref_11e18.¡!)ÒğP¶“ÉuŸ(6 = getdvarint( "scr_br_mxp_transfer_anger", 1 );
    level.ref_11e18.
”~²ûsl—¨( = getdvarint( "scr_br_mxp_g_aim_state", 5 );
    level.ref_11e18.šI'óïûˆ2Š€Í%;(e İy#s = getdvarint( "scr_br_mxp_g_target_airborne_height", 500 );
    level.ref_11e18.“b2kQ¸JÚOÇcE½_G·“P¨ = getdvarint( "scr_br_mxp_t_random_killstreak_circle", 6 );
    level.ref_11e18.•ˆ´¨z[2Sx‹'¥À# = getdvarint( "scr_br_mxp_k_look_down_radius", 6000 );
    
    if ( level.ref_11e18.wait_for_player_gulag_respawn < level.ref_11e18.wait_for_player_in_gas )
    {
        level.ref_11e18.wait_for_player_gulag_respawn = level.ref_11e18.wait_for_player_in_gas + 1;
    }
    
    level.ref_11e18.­ÚÒFc•¹ = [ "s4_mp_kenosha_idle_breath_01", "s4_mp_kenosha_idle_lookaround_01", "s4_mp_kenosha_idle_taunt_01", "s4_mp_kenosha_idle_knuckles_01", "s4_mp_kenosha_idle_knuckles_02" ];
    level.ref_11e18.¾w§PX"Ö = [ "s4_mp_greenbay_idle_breath_01", "s4_mp_greenbay_idle_lookaround_01", "s4_mp_greenbay_idle_taunt_01" ];
}

// Params 0
// Size: 0xd3
function teleportplayertoselection()
{
    game[ "dialog" ][ "g_incoming_attack" ] = "greenbay_killstreak_active";
    game[ "dialog" ][ "g_incoming_attack_player" ] = "greenbay_killstreak_active_player";
    game[ "dialog" ][ "g_attack_used" ] = "oshkosh_device_use_greenbay";
    game[ "dialog" ][ "k_incoming_attack" ] = "kenosha_killstreak_active";
    game[ "dialog" ][ "k_incoming_attack_player" ] = "kenosha_killstreak_active_player";
    game[ "dialog" ][ "k_attack_used" ] = "oshkosh_device_use_kenosha";
    game[ "dialog" ][ "k_jump_incoming" ] = "kenosha_titan_incoming";
    game[ "dialog" ][ "t_incoming_attack_player" ] = "titan_killstreak_active";
    game[ "dialog" ][ "scream_device_acquired" ] = "oshkosh_acquire";
    game[ "dialog" ][ "scream_device_acquired_desc" ] = "oshkosh_reward_desc";
    game[ "dialog" ][ "enemy_scream_device_acquired" ] = "oshkosh_acquired_enemy";
}

// Params 0
// Size: 0x38e
function toggle_ai_settings()
{
    level.ref_11e18.notetracks = [];
    var0 = [];
    var0 = [ "kenosha_chest_slam", "titan_roar" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_idle_taunt_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_idle_bark_01" ] = var0;
    var0 = [ "kenosha_chest_slam", "titan_roar", "titan_step" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_idle_knuckles_01" ] = var0;
    var0 = [ "kenosha_grab_rock", "kenosha_throw_rock" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_toss_attack_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_toss_attack_02" ] = var0;
    var0 = [ "kenosha_ground_pound" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_stomp_attack_01" ] = var0;
    var0 = [ "kenosha_chest_slam" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_swat_attack_fwd_01" ] = var0;
    var0 = [ "kenosha_chest_slam", "titan_step" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_swat_attack_l_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_idle_knuckles_02" ] = var0;
    var0 = [ "titan_step", "titan_roar" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_jump_start_01" ] = var0;
    var0 = [ "kenosha_stomp" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_leg_stomp_attack_01" ] = var0;
    var0 = [ "kenosha_leap_land" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_jump_stomp_01" ] = var0;
    var0 = [ "titan_step" ];
    level.ref_11e18.notetracks[ "s4_mp_kenosha_swat_attack_r_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_idle_lookaround_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_l_45" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_l_90" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_l_135" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_l_180" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_r_45" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_r_90" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_r_135" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_kenosha_turn_r_180" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_dive_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_emerge" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_l_45" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_l_90" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_l_135" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_l_180" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_r_45" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_r_90" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_r_135" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_turn_r_180" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_walk_left_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_walk_right_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_walk_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_walk_stop_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_idle_lookaround_01" ] = var0;
    var0 = [ "titan_roar" ];
    level.ref_11e18.notetracks[ "s4_mp_greenbay_idle_taunt_01" ] = var0;
    var0 = [ "greenbay_tail_smash" ];
    level.ref_11e18.notetracks[ "s4_mp_greenbay_tail_smash_01" ] = var0;
    level.ref_11e18.notetracks[ "s4_mp_greenbay_idle_bark_01" ] = var0;
}

// Params 0
// Size: 0x19
function toggleusbstickinhand()
{
    waittillframeend();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    thread ref_135ff();
    thread ee_setup();
}

// Params 0
// Size: 0x16
function zombieregendelayscaleingas()
{
    level._effect[ "greenbay_beam" ] = loadfx( "vfx/iw8_br/island/gameplay/mendota/vfx_br3_gbay_heatray_beam.vfx" );
}

// Params 0
// Size: 0xa8
function ee_setup()
{
    if ( getdvarint( "scr_br_mxp_ee_enabled", 1 ) )
    {
        scripts\engine\scriptable::ref_12f5b( "spy_equipment", &ee_spyequipmentscriptableused );
        var0 = getentitylessscriptablearrayinradius( "mendota_ee", "targetname" );
        
        if ( getdvarint( "scr_br_mxp_ee_wait_for_match_start", 1 ) )
        {
            foreach ( var2 in var0 )
            {
                var2 setscriptablepartstate( "spy_equipment", "off" );
            }
            
            scripts\mp\flags::gameflagwait( "prematch_fade_done" );
        }
        
        foreach ( var2 in var0 )
        {
            var2 setscriptablepartstate( "spy_equipment", "on" );
        }
        
        return;
    }
}

// Params 0
// Size: 0x103
function ref_135ff()
{
    if ( level.agentarray.size < 2 )
    {
        level waittill( "add_agents_to_game" );
    }
    
    var0 = getdvarint( "scr_br_alt_mode_mxp", 0 );
    
    if ( var0 == 2 )
    {
        set_mission_ai_cap( ( 13496.2, 11587, 8766.97 ), ( 0, 156.672, 0 ) );
        level.ref_11e18.setjailtimeouthud = level.ref_11e18.setincomingremovedcallback;
        level.ref_11e18.setincomingremovedcallback = undefined;
        set_mission_ai_cap( ( -16837.6, -16622, 888.125 ), ( 0, -128.981, 0 ) );
        waitandstartscorepolling( ( 11761, 12636, 8528 ), ( 0, -22, 0 ) );
        level.ref_11e18.wait_for_one_player_near_point = level.ref_11e18.wait_for_next_hack_complete;
        level.ref_11e18.wait_for_next_hack_complete = undefined;
        waitandstartscorepolling( ( -18417.4, -18107.9, 888.125 ), ( 0, 488.342, 0 ) );
    }
    else
    {
        thread set_omnvar_for_icon();
        thread waitfor_trigger_near_obit();
    }
    
    thread ref_13e32();
}

// Params 0
// Size: 0x100
function testing()
{
    level.ref_11e18.seq3_tanksettings = [];
    level.ref_11e18.seq3_tanksettings = [ players_in_correct_volume( ( -1300, 60000, -640 ) ), players_in_correct_volume( ( 25600, 62360, -640 ) ), players_in_correct_volume( ( 49100, 52054, -640 ) ), players_in_correct_volume( ( 58000, 23000, -640 ) ), players_in_correct_volume( ( 50500, -9000, -640 ) ), players_in_correct_volume( ( 49270, -47613, -640 ) ), players_in_correct_volume( ( 16640, -61500, -640 ) ), players_in_correct_volume( ( -18560, -55888, -640 ) ), players_in_correct_volume( ( -35500, -35000, -640 ) ), players_in_correct_volume( ( -50920, -6128, -640 ) ), players_in_correct_volume( ( -56870, 15000, -640 ) ), players_in_correct_volume( ( -34800, 40600, -640 ) ) ];
}

// Params 1
// Size: 0x22
function players_in_correct_volume( var0 )
{
    var1 = spawnstruct();
    var1.origin = var0;
    var1.score_event_civilian_killed = reset_use_think( var0 );
    return var1;
}

// Params 1
// Size: 0xc5
function reset_use_think( var0 )
{
    var1 = undefined;
    var2 = undefined;
    var3 = undefined;
    var4 = undefined;
    
    foreach ( var6 in level.ref_11e18.setlethalonunresolvedcollision )
    {
        var7 = distance2dsquared( var6, var0 );
        
        if ( !isdefined( var2 ) || var7 < var1 )
        {
            var3 = var1;
            var4 = var2;
            var1 = var7;
            var2 = var8;
            continue;
        }
        
        if ( !isdefined( var4 ) || var7 < var3 )
        {
            var3 = var7;
            var4 = var8;
        }
    }
    
    var9 = var2 - var4;
    
    if ( abs( var9 ) != 1 && abs( var9 ) != level.ref_11e18.setlethalonunresolvedcollision.size - 1 )
    {
    }
    
    if ( abs( var9 ) == level.ref_11e18.setlethalonunresolvedcollision.size - 1 )
    {
        var9 = 0 - var9;
    }
    
    return scripts\engine\utility::ter_op( var9 < 0, var2, var4 );
}

// Params 0
// Size: 0x108
function sappliedstages()
{
    var0 = level.ref_11e18.setincomingremovedcallback scripts\engine\utility::array_sort_with_func( getarraykeys( level.ref_11e18.seq3_tanksettings ), &post_race );
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        var1 = level.ref_11e18.seq3_tanksettings[ var0[ 0 ] ];
        return [ var1.score_event_civilian_killed, var1.origin ];
    }
    
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        var3 = var1[ var2 ];
        var1 = level.ref_11e18.seq3_tanksettings[ var3 ];
        
        if ( scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var1.origin ) )
        {
            return [ var1.score_event_civilian_killed, var1.origin ];
        }
    }
    
    for ( var2 = 0; var2 < var1.size ; var2++ )
    {
        var3 = var1[ var2 ];
        var1 = level.ref_11e18.seq3_tanksettings[ var3 ];
        
        if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var1.origin ) )
        {
            return [ var1.score_event_civilian_killed, var1.origin ];
        }
    }
    
    var1 = level.ref_11e18.seq3_tanksettings[ var1[ 0 ] ];
    return [ var1.score_event_civilian_killed, var1.origin ];
}

// Params 2
// Size: 0x43, Type: bool
function post_race( var0, var1 )
{
    var2 = level.ref_11e18.seq3_tanksettings[ var0 ].origin;
    var3 = level.ref_11e18.seq3_tanksettings[ var1 ].origin;
    return distancesquared( var2, self.origin ) < distancesquared( var3, self.origin );
}

// Params 2
// Size: 0x34d
function set_mission_ai_cap( var0, var1 )
{
    var2 = !isdefined( level.ref_11e18.setincomingremovedcallback );
    
    if ( var2 )
    {
        level.ref_11e18.setincomingremovedcallback = spawnnewagent( "greenbay", "wz_mv_greenbay", var0, var1, 3000, 8100, &postgamehitmarkerwaittime );
        level.ref_11e18.setincomingremovedcallback unmarkkeyframedmover( 1 );
        ref_13e31( level.ref_11e18.setincomingremovedcallback, "ui_mp_br_icon_greenbay", 8100 );
        ref_13187( 0, level.ref_11e18.setincomingremovedcallback getentitynumber() );
        level.ref_11e18.setincomingremovedcallback.turnrate = 0.01;
        level.ref_11e18.setincomingremovedcallback.linked_mover = 0;
        level.ref_11e18.setincomingremovedcallback.£ı¨y‚ø£ôb1o = [];
        level.ref_11e18.setincomingremovedcallback.šö1ú‡¥€iå7•û@ = [];
        level.ref_11e18.setincomingremovedcallback sethitlocdamagetable( "ai_mv_lochit_dmgtable" );
        level.ref_11e18.setincomingremovedcallback.x1fin_respawn = spawn( "script_model", var0 );
        level.ref_11e18.setincomingremovedcallback.x1fin_respawn setmodel( "tag_origin" );
        level.ref_11e18.setincomingremovedcallback.x1fin_respawn unmarkkeyframedmover( 1 );
        level.ref_11e18.setincomingremovedcallback.clear_look_at_ent = spawn( "script_model", var0 );
        level.ref_11e18.setincomingremovedcallback.clear_look_at_ent setmodel( "tag_player" );
        level.ref_11e18.setincomingremovedcallback.clear_look_at_ent unmarkkeyframedmover( 1 );
        level.ref_11e18.setincomingremovedcallback.clear_look_at_ent linkto( level.ref_11e18.setincomingremovedcallback, "tag_mouth_fx", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        level.ref_11e18.setincomingremovedcallback.…5@›5a¡Âf~*Á©–; = spawn( "script_model", var0 );
        level.ref_11e18.setincomingremovedcallback.…5@›5a¡Âf~*Á©–; setmodel( "tag_origin_greenbay" );
        level.ref_11e18.setincomingremovedcallback.…5@›5a¡Âf~*Á©–; unmarkkeyframedmover( 1 );
        level.ref_11e18.setincomingremovedcallback.…5@›5a¡Âf~*Á©–; linkto( level.ref_11e18.setincomingremovedcallback, "tag_mouth_fx", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
        
        if ( getdvarint( "scr_br_mxp_gk_precise_collision", 1 ) )
        {
            thread ginitializeplayercollision();
        }
        else
        {
            var3 = gkkilltriggercreate( level.ref_11e18.setincomingremovedcallback, 3000, 8100, "tag_origin" );
            level.ref_11e18.setincomingremovedcallback.¬Pê0éS¼p#—nßX›Â™5Sr = [ var3 ];
        }
    }
    else
    {
        ref_13e37( level.ref_11e18.setincomingremovedcallback );
        level.ref_11e18.setincomingremovedcallback asmsetstate( level.ref_11e18.setincomingremovedcallback.asmname, "idle" );
        level.ref_11e18.setincomingremovedcallback.origin = var0;
        level.ref_11e18.setincomingremovedcallback.x1fin_respawn.origin = var0;
    }
    
    level.ref_11e18.setincomingremovedcallback orientmode( "face current angles" );
    level.ref_11e18.setincomingremovedcallback setplayerangles( var1 );
    level.ref_11e18.setincomingremovedcallback.x1fin_respawn.angles = var1;
    return level.ref_11e18.setincomingremovedcallback;
}

// Params 0
// Size: 0x2b8
function ginitializeplayercollision()
{
    var0 = self;
    var0 endon( "death" );
    var0 agentsetclipmode( "large" );
    var1 = 0.1;
    var0.¡jÆ{ÆÒnZ·s6´7Ñ = [];
    var2 = getentarray( "greenbay_collision", "targetname" );
    
    foreach ( var4 in var2 )
    {
        var5 = "?";
        var6 = ( 0, 0, 0 );
        var7 = ( 0, 0, 0 );
        var8 = var4.script_noteworthy;
        
        if ( var8 == "head" )
        {
            var5 = "j_head";
            var6 = ( 360, 190, 35 );
            var7 = ( 0, 0, -90 );
        }
        else if ( var8 == "body" )
        {
            var5 = "j_spine4";
            var6 = ( -1670, -420, 30 );
            var7 = ( 0, -41, -90 );
        }
        
        var9 = spawnstruct();
        var9.•T>ÿ#K‡ò8˜ZÛ = var4;
        var9.tagname = var5;
        var9.´_û;êœ%ªŠÒ§™ = var6;
        var9.angleoffset = var7;
        var0.¡jÆ{ÆÒnZ·s6´7Ñ[ var8 ] = var9;
    }
    
    var11 = gkkilltriggercreate( var0, 400, 500, "j_head", 1, ( 50, -80, -250 ), ( 0, 0, 0 ) );
    wait var1;
    var12 = gkkilltriggercreate( var0, 230, 1100, "j_elbow_le", 1, ( 100, -80, 10 ), ( 0, 100, 100 ) );
    var13 = gkkilltriggercreate( var0, 230, 1100, "j_elbow_ri", 1, ( 100, -80, 10 ), ( 0, 100, 80 ) );
    wait var1;
    var14 = gkkilltriggercreate( var0, 550, 1900, "j_knee_le", 1, ( -400, -100, -100 ), ( 90, 0, -10 ) );
    var15 = gkkilltriggercreate( var0, 550, 1900, "j_knee_ri", 1, ( -400, -100, 100 ), ( 90, 0, -10 ) );
    wait var1;
    var16 = gkkilltriggercreate( var0, 800, 3300, "j_spine4", 1, ( -3350, -1050, 0 ), ( 90, 0, -10 ) );
    var17 = gkkilltriggercreate( var0, 800, 4800, "j_spine4", 1, ( -4000, 550, 0 ), ( 90, 0, -5 ) );
    level.ref_11e18.setincomingremovedcallback.¬Pê0éS¼p#—nßX›Â™5Sr = [ var11, var12, var13, var14, var15, var16, var17 ];
    var0.¦VÆÛcÒ›-Ş¹ÒÍ´£-cÒO²F = 1;
    thread gkrunplayercollision( var0 );
}

// Params 0
// Size: 0x35
function ref_1436f()
{
    if ( isdefined( level.ref_11e18.setincomingremovedcallback.idleanim ) )
    {
        while ( getanimlength( level.ref_11e18.setincomingremovedcallback.idleanim ) == 0 )
        {
            waitframe();
        }
        
        return;
    }
}

// Params 2
// Size: 0x231
function waitandstartscorepolling( var0, var1 )
{
    if ( !isdefined( level.ref_11e18.wait_for_next_hack_complete ) )
    {
        level.ref_11e18.wait_for_next_hack_complete = spawnnewagent( "kenosha", "wz_mv_kenosha_anim_body", var0, var1, 850, 3400 );
        level.ref_11e18.wait_for_next_hack_complete attach( "wz_mv_kenosha_anim_head" );
        level.ref_11e18.wait_for_next_hack_complete unmarkkeyframedmover( 1 );
        ref_13e31( level.ref_11e18.wait_for_next_hack_complete, "ui_mp_br_icon_kenosha", 3400 );
        ref_13187( 1, level.ref_11e18.wait_for_next_hack_complete getentitynumber() );
        level.ref_11e18.wait_for_next_hack_complete.turnrate = 0.01;
        level.ref_11e18.wait_for_next_hack_complete.£ı¨y‚ø£ôb1o = [];
        level.ref_11e18.wait_for_next_hack_complete.šö1ú‡¥€iå7•û@ = [];
        level.ref_11e18.wait_for_next_hack_complete sethitlocdamagetable( "ai_mv_lochit_dmgtable" );
        level.ref_11e18.wait_for_next_hack_complete.x1fin_respawn = spawn( "script_model", var0 );
        level.ref_11e18.wait_for_next_hack_complete.x1fin_respawn setmodel( "tag_origin" );
        level.ref_11e18.wait_for_next_hack_complete.x1fin_respawn unmarkkeyframedmover( 1 );
        khandkilltriggers( level.ref_11e18.wait_for_next_hack_complete, 1 );
        
        if ( getdvarint( "scr_br_mxp_gk_precise_collision", 1 ) )
        {
            thread kinitializeplayercollision();
        }
        else
        {
            var2 = gkkilltriggercreate( level.ref_11e18.wait_for_next_hack_complete, 850, 3400, "tag_origin" );
            level.ref_11e18.wait_for_next_hack_complete.¬Pê0éS¼p#—nßX›Â™5Sr = [ var2 ];
        }
    }
    else
    {
        ref_13e37( level.ref_11e18.wait_for_next_hack_complete );
        level.ref_11e18.wait_for_next_hack_complete asmsetstate( level.ref_11e18.wait_for_next_hack_complete.asmname, "idle" );
        level.ref_11e18.wait_for_next_hack_complete.origin = var0;
        level.ref_11e18.wait_for_next_hack_complete.x1fin_respawn.origin = var0;
    }
    
    level.ref_11e18.wait_for_next_hack_complete.angles = var1;
    level.ref_11e18.wait_for_next_hack_complete.x1fin_respawn.angles = var1;
    return level.ref_11e18.wait_for_next_hack_complete;
}

// Params 6
// Size: 0xac
function gkkilltriggercreate( var0, var1, var2, var3, var4, var5 )
{
    var6 = self;
    var7 = scripts\engine\utility::ter_op( istrue( var3 ), "trigger_rotatable_radius", "trigger_radius" );
    var8 = scripts\engine\utility::ter_op( isdefined( var4 ), var4, ( 0, 0, 0 ) );
    var9 = scripts\engine\utility::ter_op( isdefined( var5 ), var5, ( 0, 0, 0 ) );
    var10 = spawn( var7, var6.origin, 0, var0, var1 );
    var10.targetname = "mxpTrigger";
    var10.radius = var0;
    var10.height = var1;
    var10.¸@MCšµ`¤/[éK = var6;
    var10 enablelinkto();
    var10 linkto( var6, var2, var8, var9 );
    thread ref_13dce();
    scripts\mp\utility\trigger::makeenterexittrigger( var10, &secretstashlootcacheused );
    return var10;
}

// Params 0
// Size: 0xf
function gkkilltriggerdestroy()
{
    self notify( "destroy" );
    self delete();
}

// Params 0
// Size: 0x35
function ref_14372()
{
    if ( isdefined( level.ref_11e18.wait_for_next_hack_complete.idleanim ) )
    {
        while ( getanimlength( level.ref_11e18.wait_for_next_hack_complete.idleanim ) == 0 )
        {
            waitframe();
        }
        
        return;
    }
}

// Params 0
// Size: 0x4c
function ref_13e32()
{
    if ( getdvarint( "scr_br_mxp_t_prematch", 0 ) == 0 )
    {
        scripts\mp\flags::gameflagwait( "prematch_fade_done" );
        waittillframeend();
    }
    
    for ( ;; )
    {
        level.ref_11e18.setincomingremovedcallback method_87bc( gettime() + 10000 );
        level.ref_11e18.wait_for_next_hack_complete method_87bc( gettime() + 10000 );
        waitframe();
    }
}

// Params 2
// Size: 0x5
function ref_13e31( var0, var1 )
{
    
}

// Params 0
// Size: 0x58
function set_omnvar_for_icon()
{
    if ( getdvarint( "scr_br_mxp_t_prematch", 0 ) == 0 )
    {
        scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    }
    
    var0 = set_recent_spawn_time_threshold_override();
    var1 = var0[ 0 ];
    var2 = var0[ 1 ];
    var3 = var0[ 2 ];
    var0 = undefined;
    level.ref_11e18.setlastdroppableweaponobj = var3;
    set_mission_ai_cap( var1, var2 );
    ref_1436f();
    gstartnotifywatchers();
    set_player_hurt_trigger();
}

// Params 0
// Size: 0x1e6
function set_pitch_roll_for_ground_normal()
{
    for ( ;; )
    {
        var0 = set_recent_spawn_time_threshold_override( 20 );
        var1 = var0[ 0 ];
        var2 = var0[ 1 ];
        var3 = var0[ 2 ];
        var0 = undefined;
        level.ref_11e18.setlastdroppableweaponobj = var3;
        set_mission_ai_cap( var1, var2 );
        wait 1;
        var4 = level.ref_11e18.setincomingremovedcallback;
        set_maze_ai_stealth_settings( 0 );
        var4.linked_mover = 0;
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 0;
        set_relic_grounded( var4, 0 );
        set_relic_gas_martyr( var4 );
        waitframe();
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 1;
        set_relic_gas_martyr( var4 );
        waitframe();
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 2;
        set_relic_gas_martyr( var4 );
        waitframe();
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 3;
        set_relic_gas_martyr( var4 );
        waitframe();
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 4;
        set_relic_gas_martyr( var4 );
        waitframe();
        set_relic_dogtags( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_dfa( var4 );
        waitframe();
        set_relic_grounded( var4, 12 );
        waitframe();
        level.ref_11e18.setlastdroppableweaponobj = 5;
        set_relic_grounded( var4, 0 );
    }
}

// Params 1
// Size: 0x56
function set_recent_spawn_time_threshold_override( var0 )
{
    var1 = sat_choose_missing_piece();
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var1 = undefined;
    var4 = scripts\engine\utility::ter_op( var2 + 1 < level.ref_11e18.setlethalonunresolvedcollision.size, var2 + 1, 0 );
    var5 = level.ref_11e18.setlethalonunresolvedcollision[ var4 ];
    var6 = var5 - var3;
    var7 = vectortoangles( var6 );
    return [ var3, var7, var2 ];
}

// Params 0
// Size: 0x134
function sat_choose_missing_piece()
{
    var0 = randomint( level.ref_11e18.setlethalonunresolvedcollision.size );
    var1 = level.ref_11e18.setlethalonunresolvedcollision[ var0 ];
    var2 = 0;
    
    if ( getdvarint( "scr_br_mxp_g_close_to_plane", 1 ) > 0 && level.mapname == "mp_wz_island" && isdefined( level.infilstruct ) )
    {
        var3 = [];
        var4 = level.infilstruct.c130pathstruct.ref_1386e;
        var3 = ggetstartcanidates( var3, var4 );
        
        if ( var3.size == 0 )
        {
            var4 = level.infilstruct.c130pathstruct.neurotoxin_damage_monitor;
            var3 = ggetstartcanidates( var3, var4 );
        }
        
        if ( var3.size > 0 )
        {
            level.ref_11e18.¸K'k2Ä×Ü°PÛı§ = var3.size;
            var5 = randomint( var3.size );
            var0 = var3[ var5 ];
            var1 = level.ref_11e18.setlethalonunresolvedcollision[ var0 ];
            return [ var0, var1 ];
        }
        
        var3 = 1;
    }
    
    if ( getdvarint( "scr_br_mxp_normal_circle", 0 ) == 0 || istrue( var3 ) )
    {
        for ( var6 = 0; updateachievementhangtime( var2 ) && var6 < level.ref_11e18.setlethalonunresolvedcollision.size ; var6++ )
        {
            var1 = scripts\engine\utility::ter_op( var1 + 1 < level.ref_11e18.setlethalonunresolvedcollision.size, var1 + 1, 0 );
            var2 = level.ref_11e18.setlethalonunresolvedcollision[ var1 ];
        }
    }
    
    return [ var1, var2 ];
}

// Params 2
// Size: 0x6b
function ggetstartcanidates( var0, var1 )
{
    var2 = getdvarfloat( "scr_br_mxp_g_distance_to_plane", 25000 );
    var3 = var2 * var2;
    
    foreach ( var5 in level.ref_11e18.setlethalonunresolvedcollision )
    {
        if ( updateachievementhangtime( var5 ) )
        {
            continue;
        }
        
        var6 = distance2dsquared( var5, var1 );
        
        if ( var6 < var3 )
        {
            var0 = var7;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x113
function post_safeges_weapon()
{
    var0 = [];
    GscBinSkip0( 0x2e, var0.size, ( -6969, -62217, -628 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0xf6
function playerzombiesetuphud()
{
    var0 = getdvarint( "scr_br_mxp_g_node_dist", 20000 );
    var1 = [];
    GscBinSkip0( 0x2e, var1.size, level.ref_11e18.setlethalonunresolvedcollision[ 0 ] );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x160
function set_player_hurt_trigger()
{
    var0 = level.ref_11e18.setincomingremovedcallback;
    set_maze_ai_stealth_settings( 0 );
    var0.chopper_carepackage = undefined;
    set_distances_for_groups( var0 );
    
    for ( ;; )
    {
        if ( score_message() )
        {
            waitframe();
            continue;
        }
        
        var1 = sat_computer_think_new();
        
        if ( isdefined( var0.ref_12930 ) && !sales_discount() )
        {
            [[ var0.ref_12930 ]]( var0 );
        }
        else if ( var1 == 14 && !sales_discount() )
        {
            gstatetalk( var0 );
        }
        else if ( var1 == 15 && !sales_discount() )
        {
            gstatetalkwait( var0 );
        }
        else if ( isdefined( var0.vo_one_remain ) && !sales_discount() )
        {
            set_relic_grounded( var0, 12, 0 );
            set_relic_aggressive_melee_params( var0 );
        }
        else if ( var1 == 12 )
        {
            set_relic_aggressive_melee( var0 );
            set_relic_doubletap( var0 );
        }
        else if ( ginwalkingstate() )
        {
            if ( score_event_kill( var0 ) )
            {
                set_relic_grounded( var0, 12, 1 );
                set_player_munition_currency( var0 );
            }
            else
            {
                set_relic_dfa( var0 );
            }
        }
        else if ( var1 == 6 )
        {
        }
        else if ( var1 == 5 )
        {
            set_relic_amped( var0 );
        }
        else if ( var1 == 7 )
        {
            set_player_munition_currency( var0 );
            set_relic_bang_and_boom( var0 );
        }
        else
        {
            var2 = gismovingtocircle( var0 ) && !ghasreachedcircle( var0 );
            set_relic_focus_fire( var0, var2 );
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x41
function set_player_munition_currency( var0 )
{
    var1 = sandboxprintlinebold( var0 );
    level.ref_11e18.setlastdroppableweaponobj = var1;
    
    if ( gismovingtocircle( var0 ) && ghasreachedcircle( var0 ) )
    {
        gsetmovetocircle( var0, undefined );
    }
    
    if ( sales_discount() )
    {
        set_relic_headbullets();
        return;
    }
}

// Params 1
// Size: 0x150
function set_relic_aggressive_melee( var0 )
{
    if ( istrue( var0.¡A'€ˆ228@=… ) )
    {
        return;
    }
    
    if ( isdefined( level.ref_11e18.score_event_headshot ) && !sales_discount() )
    {
        var1 = level.ref_11e18.setlethalonunresolvedcollision[ level.ref_11e18.score_event_headshot ];
        
        if ( update_volume_flag( var1 ) )
        {
            var2 = set_minigun_target_loc( var0, level.ref_11e18.score_event_headshot );
            var3 = var2[ 0 ];
            var4 = var2[ 1 ];
            var5 = var2[ 2 ];
            var2 = undefined;
            
            if ( isdefined( var4 ) )
            {
                gupdateintelcrates( level.ref_11e18.score_event_headshot, var4 );
            }
            
            level.ref_11e18.score_event_headshot = var4;
        }
        
        if ( isdefined( level.ref_11e18.score_event_headshot ) && level.ref_11e18.setlastdroppableweaponobj != level.ref_11e18.score_event_headshot && !score_init( var0, level.ref_11e18.score_event_headshot ) )
        {
            var0.linked_mover = !var0.linked_mover;
        }
    }
    
    if ( !sales_discount() )
    {
        var6 = set_minigun_target_loc( var0 );
        var3 = var6[ 0 ];
        var4 = var6[ 1 ];
        var5 = var6[ 2 ];
        var6 = undefined;
        
        if ( var5 || score_event_nuked( var0 ) )
        {
            if ( level.ref_11e18.setlastdroppableweaponobj == var4 )
            {
                var4 = undefined;
            }
            
            gsetmovetocircle( var0, var4 );
            var0.¡A'€ˆ228@=… = var5;
            
            if ( var3 )
            {
                var0.linked_mover = !var0.linked_mover;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x16
function set_distances_for_groups( var0 )
{
    var0.nodeidle = 0;
    var0.ref_11ea7 = 0;
}

// Params 1
// Size: 0xbd
function set_relic_doubletap( var0 )
{
    if ( sendendofmatchdata( var0 ) )
    {
        set_distances_for_groups( var0 );
        
        if ( gismovingtocircle( var0 ) )
        {
            set_maze_ai_stealth_settings( 5 );
            return;
        }
        
        set_maze_ai_stealth_settings( 0 );
        return;
    }
    
    if ( !istrue( var0.¡A'€ˆ228@=… ) && tisreadytotalk( var0 ) )
    {
        var0.½¬gXUÃûóà{Ï = gettime() + getdvarint( "scr_br_mxp_next_talk", 40000 );
        set_maze_ai_stealth_settings( 14 );
        waitandstartparachuteoverheadmonitoring( 9 );
        return;
    }
    
    if ( istrue( var0.¡A'€ˆ228@=… ) )
    {
        var0.ref_11ea7 = 0;
    }
    
    if ( tcanrandomkillstreak( var0 ) && randomfloat( 1 ) <= level.ref_11e18.select_bunker_courtyard_spawners )
    {
        set_relic_doubletap_params_internal( var0 );
        return;
    }
    
    var0.ref_11ea7 = 1;
    set_relic_doubletap_params( var0 );
}

// Params 2
// Size: 0xe
function gsetmovetocircle( var0, var1 )
{
    var0.chopper_carepackage = var1;
}

// Params 1
// Size: 0xd, Type: bool
function gismovingtocircle( var0 )
{
    return isdefined( var0.chopper_carepackage );
}

// Params 1
// Size: 0x18, Type: bool
function ghasreachedcircle( var0 )
{
    return var0.chopper_carepackage == level.ref_11e18.setlastdroppableweaponobj;
}

// Params 1
// Size: 0xad, Type: bool
function sendendofmatchdata( var0 )
{
    if ( getdvarint( "scr_br_mxp_g_force_stay", 0 ) > 0 )
    {
        set_distances_for_groups( var0 );
        return false;
    }
    
    if ( sales_discount() )
    {
        return true;
    }
    else if ( istrue( var0.¡A'€ˆ228@=… ) )
    {
        return gismovingtocircle( var0 );
    }
    else if ( gismovingtocircle( var0 ) )
    {
        return true;
    }
    else if ( score_event_nuked( var0 ) )
    {
        return false;
    }
    else if ( tisreadytotalk( var0 ) )
    {
        return false;
    }
    else if ( score_event_fob_cleared() && !positioncheck( var0 ) )
    {
        return true;
    }
    else if ( !score_event_fob_cleared() && ( var0.nodeidle || var0.ref_11ea7 ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x27, Type: bool
function send_wave_spawns_to_roof( var0 )
{
    if ( score_event_fob_cleared() && positioncheck( var0 ) )
    {
        var1 = sandbox_safe_area();
        
        if ( isdefined( var1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x25, Type: bool
function positioncheck( var0 )
{
    if ( score_event_fob_cleared() )
    {
        return ( level.ref_11e18.score_event_headshot == level.ref_11e18.setlastdroppableweaponobj );
    }
    
    return false;
}

// Params 0
// Size: 0x16, Type: bool
function score_event_fob_cleared()
{
    if ( isdefined( level.ref_11e18.score_event_headshot ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x46, Type: bool
function isintelcratevalid( var0 )
{
    return isdefined( var0 ) && isdefined( var0.trial_flares ) && isdefined( var0.trial_flares.type ) && isdefined( var0.trial_flares.index ) && isdefined( var0.trial_flares.expiretime );
}

// Params 0
// Size: 0x78
function sandbox_safe_area()
{
    foreach ( var1 in level.train_hurt_damage_watcher )
    {
        if ( isintelcratevalid( var1 ) && var1.trial_flares.type == "g" && var1.trial_flares.index == level.ref_11e18.setlastdroppableweaponobj && gettime() >= var1.trial_flares.expiretime )
        {
            return var1;
        }
    }
}

// Params 0
// Size: 0x64
function sandbox_safe_area_count()
{
    foreach ( var1 in level.train_hurt_damage_watcher )
    {
        if ( isintelcratevalid( var1 ) && var1.trial_flares.type == "g" && var1.trial_flares.index == level.ref_11e18.setlastdroppableweaponobj )
        {
            return var1;
        }
    }
}

// Params 2
// Size: 0x6a
function gupdateintelcrates( var0, var1 )
{
    foreach ( var3 in level.train_hurt_damage_watcher )
    {
        if ( isintelcratevalid( var3 ) && var3.trial_flares.type == "g" && var3.trial_flares.index == var0 )
        {
            var3.trial_flares.index = var1;
        }
    }
}

// Params 1
// Size: 0x77, Type: bool
function score_event_nuked( var0 )
{
    if ( update_volume_flag( var0.origin ) && !gismovingtocircle( var0 ) )
    {
        return true;
    }
    
    if ( gismovingtocircle( var0 ) )
    {
        if ( istrue( var0.¡A'€ˆ228@=… ) )
        {
            return false;
        }
        else if ( ghasreachedcircle( var0 ) )
        {
            return false;
        }
        
        var1 = level.ref_11e18.setlethalonunresolvedcollision[ var0.chopper_carepackage ];
        
        if ( update_volume_flag( var1 ) )
        {
            return true;
        }
        
        if ( !score_event_turret_killed( var0 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x12
function score_event_turret_killed( var0 )
{
    return score_init( var0, var0.chopper_carepackage );
}

// Params 2
// Size: 0x9d, Type: bool
function score_init( var0, var1 )
{
    var2 = level.ref_11e18.setlastdroppableweaponobj - var1;
    
    if ( abs( var2 ) > 0 )
    {
        var3 = 0;
        var4 = 0;
        
        if ( var2 > 0 )
        {
            var3 = var2;
            var4 = level.ref_11e18.setlethalonunresolvedcollision.size - level.ref_11e18.setlastdroppableweaponobj + var1;
        }
        else
        {
            var4 = 0 - var2;
            var3 = level.ref_11e18.setlethalonunresolvedcollision.size - var1 + level.ref_11e18.setlastdroppableweaponobj;
        }
        
        if ( var3 < var4 && var0.linked_mover )
        {
            return true;
        }
        else if ( var4 < var3 && !var0.linked_mover )
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x13c
function set_minigun_target_loc( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = level.ref_11e18.setlastdroppableweaponobj;
    }
    
    var2 = var1;
    var3 = var1;
    
    for ( var4 = 0; var4 < level.ref_11e18.setlethalonunresolvedcollision.size ; var4++ )
    {
        var2 = sandboxprintlinebold( var0, var2 );
        var5 = level.ref_11e18.setlethalonunresolvedcollision[ var2 ];
        
        if ( !update_volume_flag( var5 ) )
        {
            return [ 0, var2, 0 ];
        }
        
        var3 = sandboxprintlineboldwait( var0, var3 );
        var6 = level.ref_11e18.setlethalonunresolvedcollision[ var3 ];
        
        if ( !update_volume_flag( var6 ) )
        {
            return [ 1, var3, 0 ];
        }
    }
    
    var7 = undefined;
    var8 = 0;
    
    if ( isdefined( level.ref_11bce ) && isdefined( level.ref_11bce.ref_12e2c ) )
    {
        var7 = level.ref_11bce.ref_12e2c.score_event_civilian_killed;
        
        if ( var7 == var1 )
        {
            var7 = var1;
        }
        else
        {
            var2 = var1;
            var3 = var1;
            
            for ( var4 = 0; var4 < level.ref_11e18.setlethalonunresolvedcollision.size ; var4++ )
            {
                var2 = sandboxprintlinebold( var0, var2 );
                var5 = level.ref_11e18.setlethalonunresolvedcollision[ var2 ];
                
                if ( var2 == var7 )
                {
                    break;
                }
                
                var3 = sandboxprintlineboldwait( var0, var3 );
                
                if ( var3 == var7 )
                {
                    var8 = 1;
                    break;
                }
            }
        }
    }
    
    return [ var8, var7, 1 ];
}

// Params 1
// Size: 0x17
function set_maze_ai_stealth_settings( var0 )
{
    level.ref_11e18.setincomingremovedcallback.state = var0;
}

// Params 0
// Size: 0x14
function sat_computer_think_new()
{
    return level.ref_11e18.setincomingremovedcallback.state;
}

// Params 0
// Size: 0x13, Type: bool
function ginnodestate()
{
    var0 = sat_computer_think_new();
    return var0 == 0 || var0 == 12;
}

// Params 0
// Size: 0xa, Type: bool
function score_event_enemy_killed()
{
    return sat_computer_think_new() == 9;
}

// Params 0
// Size: 0x14, Type: bool
function ginwalkingstate()
{
    var0 = sat_computer_think_new();
    return var0 == 2 || var0 == 3;
}

// Params 1
// Size: 0x2a
function sandbox_combat_area_bits( var0 )
{
    var1 = sandboxprintlinebold( var0 );
    var2 = level.ref_11e18.setlethalonunresolvedcollision[ var1 ];
    var3 = distance2d( var2, var0.origin );
    return var3;
}

// Params 1
// Size: 0x42
function gmonitorgoal( var0 )
{
    var0 notify( "goal_stopped" );
    var0 endon( "goal_stopped" );
    var0 endon( "walk_cycle_done" );
    
    for ( ;; )
    {
        if ( score_event_kill( var0 ) )
        {
            var0 notify( "goal_reached" );
            set_relic_grounded( var0, 12, 1 );
            set_player_munition_currency( var0 );
            return;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x73, Type: bool
function score_event_kill( var0 )
{
    var1 = 100;
    var2 = sandboxprintlinebold( var0 );
    var3 = level.ref_11e18.setlethalonunresolvedcollision[ var2 ];
    var4 = distance2d( var0.origin, var3 );
    
    if ( var4 <= level.ref_11e18.Å
_8šä Pªs )
    {
        return true;
    }
    
    var5 = level.ref_11e18.setlethalonunresolvedcollision[ level.ref_11e18.setlastdroppableweaponobj ];
    var6 = var3 - var5;
    var7 = var3 - var0.origin;
    var8 = vectordot( var6, var7 );
    return var8 <= 0;
}

// Params 1
// Size: 0x11b
function set_relic_doubletap_params_internal( var0 )
{
    var1 = tgetnextangertarget( var0 );
    
    if ( !isdefined( var1 ) )
    {
        if ( send_wave_spawns_to_roof( var0 ) )
        {
            var1 = sandbox_safe_area();
        }
        
        if ( !isdefined( var1 ) )
        {
            var1 = var0 scripts\mp\gametypes\_mxp_target::pristinestatehealthadd( level.ref_11e18.wait_for_player_to_getup, level.ref_11e18.wait_for_players_init_puzzle );
        }
    }
    else
    {
        tremoveangertarget( var0, var1 );
    }
    
    jumpiffalse(isdefined( var1 )) LOC_0000007e;
    var2 = randomizeattacklocation( var1.origin, level.ref_11e18.‘·³æ[[–±6n'¬ÂÚ“,‘ZÕÜ );
    var3 = vectortoangles( var2 - var0.origin );
    goto LOC_000000c2;
}

// Params 2
// Size: 0x32
function randomizeattacklocation( var0, var1 )
{
    var2 = randomfloat( var1 * 0.8 );
    var3 = randomfloatrange( -180, 180 );
    var4 = ( 0, var3, 0 );
    var5 = anglestoforward( var4 );
    return var0 + var5 * var2;
}

// Params 2
// Size: 0x28
function set_pressure_stability_reading( var0, var1 )
{
    var2 = vectortoangles( var1.origin - var0.origin );
    var3 = _getrandomlocations::serverroomdogtagrevive( var1.origin, var2 );
}

// Params 1
// Size: 0x28, Type: bool
function update_volume_flag( var0 )
{
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) )
    {
        return false;
    }
    
    return !scripts\mp\gametypes\br_circle::updateprestreamrespawn( var0 );
}

// Params 1
// Size: 0xc, Type: bool
function updateachievementhangtime( var0 )
{
    return !updaterespawnstatus( var0 );
}

// Params 1
// Size: 0x27, Type: bool
function updaterespawnstatus( var0 )
{
    var1 = relic_steelballs_stump_monitor();
    var2 = float( relic_team_proximity_monitor() );
    var3 = distance2dsquared( var0, var1 );
    
    if ( var3 < var2 * var2 )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x11
function relic_steelballs_stump_monitor()
{
    return level.br_level.default_class_chosen[ 1 ];
}

// Params 0
// Size: 0x11
function relic_team_proximity_monitor()
{
    return level.br_level.br_circleradii[ 1 ];
}

// Params 1
// Size: 0x27
function set_relic_dogtags( var0 )
{
    set_relic_gas_martyr( var0 );
    set_maze_ai_stealth_settings( 1 );
    ref_13c1d( var0, "s4_mp_greenbay_walk_start_01" );
    set_maze_ai_stealth_settings( 2 );
}

// Params 2
// Size: 0x9b
function set_relic_dfa( var0, var1 )
{
    var0 endon( "goal_reached" );
    var0 endon( "goal_interrupted" );
    thread gmonitorgoal( var0 );
    var2 = sat_computer_think_new();
    var3 = 1;
    
    if ( var2 == 2 )
    {
        if ( scripts\engine\utility::cointoss() || istrue( var1 ) )
        {
            ref_13c1d( var0, "s4_mp_greenbay_walk_01" );
        }
        else
        {
            set_maze_ai_stealth_settings( 3 );
            
            if ( var0.linked_mover )
            {
                ref_13c1d( var0, "s4_mp_greenbay_walk_right_01" );
            }
            else
            {
                ref_13c1d( var0, "s4_mp_greenbay_walk_left_01" );
            }
            
            var3 = 0;
        }
    }
    else
    {
        set_maze_ai_stealth_settings( 2 );
        ref_13c1d( var0, "s4_mp_greenbay_walk_01" );
    }
    
    var0 notify( "walk_cycle_done" );
}

// Params 1
// Size: 0x18
function set_relic_doomslayer( var0 )
{
    var0 notify( "goal_stopped" );
    ref_13c1d( var0, "s4_mp_greenbay_walk_stop_01" );
}

// Params 1
// Size: 0x52
function set_relic_amped( var0 )
{
    set_relic_gas_martyr( var0 );
    set_maze_ai_stealth_settings( 5 );
    ref_13c1d( var0, "s4_mp_greenbay_dive_01" );
    set_maze_ai_stealth_settings( 6 );
    ref_13c1c( var0, "s4_mp_greenbay_swim_01" );
    var1 = sandboxprintlinebold( var0 );
    var2 = level.ref_11e18.setlethalonunresolvedcollision[ var1 ];
    thread gstatemovetorootmotion( var0, var2 );
}

// Params 1
// Size: 0x27
function set_relic_bang_and_boom( var0 )
{
    level notify( "gStateMoveWait" );
    ref_13e37( var0 );
    ref_13c1d( var0, "s4_mp_greenbay_emerge" );
    set_maze_ai_stealth_settings( 12 );
}

// Params 2
// Size: 0x48
function gstatemovetorootmotion( var0, var1 )
{
    var2 = var0.origin;
    var3 = distance( var0.origin, var1 );
    var4 = var3 / getdvarint( "scr_br_mxp_g_speed", 3000 );
    ref_13ba1( var0 );
    var0.x1fin_respawn moveto( var1, var4 );
    wait var4;
    set_maze_ai_stealth_settings( 7 );
}

// Params 2
// Size: 0x22
function set_relic_focus_fire( var0, var1 )
{
    if ( scripts\engine\utility::cointoss() || istrue( var1 ) )
    {
        set_relic_amped( var0 );
        return;
    }
    
    set_relic_dogtags( var0 );
}

// Params 3
// Size: 0x31
function set_relic_grounded( var0, var1, var2 )
{
    if ( ginwalkingstate() )
    {
        set_relic_doomslayer( var0 );
    }
    else if ( sat_computer_think_new() == 6 )
    {
        set_relic_bang_and_boom( var0 );
    }
    
    set_maze_ai_stealth_settings( var1 );
}

// Params 2
// Size: 0xec
function sat_activate( var0, var1 )
{
    var2 = 22.5;
    var3 = 67.5;
    var4 = 112.5;
    var5 = 157.5;
    var6 = abs( var1 );
    var7 = scripts\engine\utility::sign( var1 ) < 0;
    
    if ( var6 <= var2 )
    {
        return [ "", 3, 0 ];
    }
    
    if ( var6 < var3 )
    {
        if ( var7 )
        {
            return [ "s4_mp_greenbay_turn_r_45", 2, 45 ];
        }
        
        return [ "s4_mp_greenbay_turn_l_45", 2, 45 ];
    }
    
    if ( var6 < var4 )
    {
        if ( var7 )
        {
            return [ "s4_mp_greenbay_turn_r_90", 3, 90 ];
        }
        
        return [ "s4_mp_greenbay_turn_l_90", 3, 90 ];
    }
    
    if ( var6 < var5 )
    {
        if ( var7 )
        {
            return [ "s4_mp_greenbay_turn_r_135", 4.5, 135 ];
        }
        
        return [ "s4_mp_greenbay_turn_l_135", 4.5, 135 ];
    }
    
    if ( var7 )
    {
        return [ "s4_mp_greenbay_turn_r_180", 5, 180 ];
    }
    
    return [ "s4_mp_greenbay_turn_l_180", 5, 180 ];
}

// Params 1
// Size: 0x4a
function set_relic_gas_martyr( var0 )
{
    var1 = var0.origin;
    var2 = sandboxprintlinebold( var0 );
    var3 = level.ref_11e18.setlethalonunresolvedcollision[ var2 ];
    var4 = var3 - var1;
    var5 = vectortoangles( var4 );
    var6 = angleclamp180( var5[ 1 ] );
    set_maze_ai_stealth_settings( 13 );
    set_relic_explodedmg( var0, var6, var3 );
}

// Params 0
// Size: 0x3a
function ggetnextindexorigin()
{
    var0 = sandboxprintlinebold( level.ref_11e18.setincomingremovedcallback );
    
    if ( !isdefined( var0 ) )
    {
        var0 = level.ref_11e18.setlastdroppableweaponobj;
    }
    
    var1 = level.ref_11e18.setlethalonunresolvedcollision[ var0 ];
    return [ var0, var1 ];
}

// Params 2
// Size: 0x5d
function sandboxprintlinebold( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = level.ref_11e18.setlastdroppableweaponobj;
    }
    
    if ( !var0.linked_mover )
    {
        return scripts\engine\utility::ter_op( var1 + 1 < level.ref_11e18.setlethalonunresolvedcollision.size, var1 + 1, 0 );
    }
    
    return scripts\engine\utility::ter_op( var1 - 1 >= 0, var1 - 1, level.ref_11e18.setlethalonunresolvedcollision.size - 1 );
}

// Params 2
// Size: 0x5d
function sandboxprintlineboldwait( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = level.ref_11e18.setlastdroppableweaponobj;
    }
    
    if ( !var0.linked_mover )
    {
        return scripts\engine\utility::ter_op( var1 - 1 >= 0, var1 - 1, level.ref_11e18.setlethalonunresolvedcollision.size - 1 );
    }
    
    return scripts\engine\utility::ter_op( var1 + 1 < level.ref_11e18.setlethalonunresolvedcollision.size, var1 + 1, 0 );
}

// Params 3
// Size: 0x63
function set_relic_explodedmg( var0, var1, var2 )
{
    var3 = var0.angles;
    var4 = angleclamp180( var3[ 1 ] );
    var5 = angleclamp180( var1 - var4 );
    var6 = sat_activate( var0, var5 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var9 = var6[ 2 ];
    var6 = undefined;
    
    if ( var7 != "" )
    {
        ref_13c1d( var0, var7 );
    }
    
    var10 = ( 0, var1, 0 );
    var0 orientmode( "face point", var2 );
}

// Params 1
// Size: 0x128
function set_relic_aggressive_melee_params( var0 )
{
    var1 = var0.vo_one_remain;
    var2 = -90;
    
    if ( !var0.linked_mover )
    {
        var2 = 90;
    }
    
    if ( isdefined( var1.origin ) )
    {
        var3 = var1.origin - var0.origin;
        var4 = vectortoangles( var3 );
        var5 = var4[ 1 ];
        var6 = var0.angles[ 1 ];
        var2 = angleclamp180( var5 - var6 );
    }
    
    var7 = sat_activate( var0, var2 );
    var8 = var7[ 0 ];
    var9 = var7[ 1 ];
    var10 = var7[ 2 ];
    var7 = undefined;
    set_maze_ai_stealth_settings( 11 );
    
    if ( var8 != "" )
    {
        ref_13c1d( var0, var8 );
    }
    
    if ( var0.vo_one_remain != var1 )
    {
        return;
    }
    
    _getrandomlocations::sequence_progression( 1 );
    set_maze_ai_stealth_settings( 8 );
    var0 setscriptablepartstate( "camo", "charge" );
    gplaystartaim( var0 );
    set_maze_ai_stealth_settings( 9 );
    var0 setscriptablepartstate( "camo", "full" );
    ref_13c1b( var0 );
    gblendtoaimwait( var1.origin );
    var11 = set_no_crash( var0 );
    set_maze_ai_stealth_settings( 10 );
    thread gdisablecamo( var0 );
    
    if ( istrue( var11 ) )
    {
        ref_13c1d( var0, "s4_mp_greenbay_atomic_ray_end_01" );
    }
    
    set_maze_ai_stealth_settings( 12 );
}

// Params 2
// Size: 0x38
function gdisablecamo( var0, var1 )
{
    var0 setscriptablepartstate( "camo", "discharge" );
    wait 4;
    var0 setscriptablepartstate( "camo", "fadeout" );
    wait 4;
    var0 setscriptablepartstate( "camo", "disabled" );
}

// Params 1
// Size: 0xe
function gblendtoaimwait( var0 )
{
    set_maze_ai_state( var0 );
    wait 2;
}

// Params 0
// Size: 0x1c
function gplaystartaim()
{
    var0 = ref_13c1c( "s4_mp_greenbay_atomic_ray_start_01" );
    var1 = getanimlength( var0 );
    var2 = var1 - 2;
    wait var2;
}

// Params 1
// Size: 0x17
function set_number_of_subway_cars_on_track( var0 )
{
    level.ref_11e18.setincomingremovedcallback.vo_one_remain = var0;
}

// Params 0
// Size: 0x13
function gendkillstreak()
{
    level.ref_11e18.setincomingremovedcallback.vo_one_remain = undefined;
}

// Params 1
// Size: 0x3d
function set_no_crash( var0 )
{
    var1 = undefined;
    select_woods_three_spawners( var0 );
    
    if ( isdefined( var0.vo_one_remain.ref_134e3 ) )
    {
        var1 = _getrandomlocations::server_structs( var0.vo_one_remain );
    }
    else
    {
        wait 6;
    }
    
    set_relic_gun_game( var0 );
    return var1;
}

// Params 1
// Size: 0x92
function select_woods_three_spawners( var0 )
{
    var0.…5@›5a¡Âf~*Á©–; setscriptablepartstate( "beam", "beam_enable" );
    var0 setscriptablepartstate( "beam", "beam_enable" );
    
    if ( isdefined( var0.vo_one_remain.start_area_fx_end ) )
    {
        var0.…5@›5a¡Âf~*Á©–; setotherent( var0.vo_one_remain.start_area_fx_end );
        var0.clear_mortar_settings = playfxontagsbetweenclients( scripts\engine\utility::getfx( "greenbay_beam" ), var0.clear_look_at_ent, "tag_player", var0.vo_one_remain.start_area_fx_end, "tag_player" );
        var0.clear_mortar_settings unmarkkeyframedmover( 1 );
        return;
    }
}

// Params 1
// Size: 0x4b
function set_relic_gun_game( var0 )
{
    var0.…5@›5a¡Âf~*Á©–; setscriptablepartstate( "beam", "beam_disable" );
    var0 setscriptablepartstate( "beam", "beam_disable" );
    var0.…5@›5a¡Âf~*Á©–; setotherent( undefined );
    
    if ( isdefined( var0.clear_mortar_settings ) )
    {
        var0.clear_mortar_settings delete();
        return;
    }
}

// Params 1
// Size: 0x34
function gstatetalkwait( var0 )
{
    if ( var0.¤	Y7r»¡œC == 0 )
    {
        gstateidle( var0, "s4_mp_greenbay_idle_taunt_01" );
        var0.¤	Y7r»¡œC = 1;
        return;
    }
    
    gstateidle( var0, "s4_mp_greenbay_idle_breath_01" );
}

// Params 2
// Size: 0xd
function gstateidle( var0, var1 )
{
    ref_13c1d( var0, var1 );
}

// Params 2
// Size: 0x80
function set_relic_doubletap_params( var0, var1 )
{
    if ( !isdefined( var0.’K

¸AÏ7@µåx ) || var0.’K

¸AÏ7@µåx + 1 >= level.ref_11e18.¾w§PX"Ö.size )
    {
        var0.’K

¸AÏ7@µåx = 0;
        var0.—;-c¬æ = scripts\engine\utility::array_randomize( level.ref_11e18.¾w§PX"Ö );
    }
    else
    {
        var0.’K

¸AÏ7@µåx++;
    }
    
    var2 = var0.’K

¸AÏ7@µåx;
    var3 = var0.—;-c¬æ[ var2 ];
    ref_13c1d( var0, var3 );
    var0.nodeidle = 1;
}

// Params 1
// Size: 0x76
function gstatetalk( var0 )
{
    var1 = level.ref_11e18.wait_for_next_hack_complete;
    var2 = var1.origin - var0.origin;
    var3 = vectortoangles( var2 );
    var4 = angleclamp180( var3[ 1 ] );
    set_relic_explodedmg( var0, var4, var1.origin );
    var5 = ref_13c1c( var0, "s4_mp_greenbay_idle_bark_01" );
    waitandstartparachuteoverheadmonitoring( 10 );
    var1 notify( "break_idle" );
    ref_13ed2( var0, var5 );
    var0.¤	Y7r»¡œC = 0;
    set_maze_ai_stealth_settings( 15 );
}

// Params 4
// Size: 0xd, Type: bool
function postgamehitmarkerwaittime( var0, var1, var2, var3 )
{
    return !score_event_enemy_killed();
}

// Params 0
// Size: 0x62
function waitfor_trigger_near_obit()
{
    if ( getdvarint( "scr_br_mxp_t_prematch", 0 ) == 0 )
    {
        scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    }
    
    var0 = waitformeleedamage();
    var1 = var0[ 0 ];
    var2 = var0[ 1 ];
    var3 = var0[ 2 ];
    var0 = undefined;
    level.ref_11e18.wait_for_open = var3;
    waitandstartscorepolling( var1, var2 );
    ref_14372();
    kstartnotifywatchers();
    kspawnchallengetrigger();
    kspawnheadchallengetrigger();
    waitforgulagfightstocomplete();
}

// Params 0
// Size: 0x76
function waitforallcrates()
{
    for ( ;; )
    {
        var0 = waitformeleedamage( 0 );
        var1 = var0[ 0 ];
        var2 = var0[ 1 ];
        var3 = var0[ 2 ];
        var0 = undefined;
        level.ref_11e18.wait_for_open = var3;
        waitandstartscorepolling( var1, var2 );
        wait 1;
        var4 = level.ref_11e18.wait_for_next_hack_complete;
        kstateplayswat( var4, 2 );
        waitframe();
        waitforremoteend( var4 );
        waitframe();
        waitfornukecarriernearlz( var4, 84.7375 );
        waitframe();
        waitforremoteend( var4 );
        waitframe();
        waitframe();
    }
}

// Params 1
// Size: 0x6b
function waitformeleedamage( var0 )
{
    var1 = randomint( level.ref_11e18.wait_for_player_eliminated.size );
    var2 = level.ref_11e18.wait_for_player_eliminated[ var1 ];
    var3 = scripts\engine\utility::ter_op( var1 + 1 < level.ref_11e18.wait_for_player_eliminated.size, var1 + 1, 0 );
    var4 = level.ref_11e18.wait_for_player_eliminated[ var3 ];
    var5 = var4 - var2;
    var6 = vectortoangles( var5 );
    var6 = ( 0, var6[ 1 ], 0 );
    return [ var2, var6, var1 ];
}

// Params 0
// Size: 0x93
function vehicle_outline_watcher()
{
    var0 = [];
    GscBinSkip0( 0x2e, var0.size, ( 11898.5, 12257.3, 8462.71 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0xa8
function vehicletrail()
{
    var0 = scripts\engine\utility::array_randomize( getarraykeys( level.ref_11e18.wait_for_player_eliminated ) );
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return [ var0[ 0 ], level.ref_11e18.wait_for_player_eliminated[ var0[ 0 ] ] ];
    }
    
    foreach ( var2 in var0 )
    {
        if ( var2 == level.ref_11e18.wait_for_open )
        {
            continue;
        }
        
        var3 = level.ref_11e18.wait_for_player_eliminated[ var2 ];
        
        if ( scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( var3 ) )
        {
            return [ var2, var3 ];
        }
    }
    
    return [ var0[ 0 ], level.ref_11e18.wait_for_player_eliminated[ var0[ 0 ] ] ];
}

// Params 0
// Size: 0xad
function waitforgulagfightstocomplete()
{
    var0 = level.ref_11e18.wait_for_next_hack_complete;
    var0.linked_mover = 0;
    waitandstartparachuteoverheadmonitoring( 0 );
    wait_in_spectate_for_time( var0 );
    
    for ( ;; )
    {
        var1 = vehoccupancy_lastbctime();
        
        if ( wait_for_morales_thanks() )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( var0.ref_12930 ) && !vehiclespawn_cargotruckmg() )
        {
            [[ var0.ref_12930 ]]( var0 );
        }
        else if ( var1 == 9 )
        {
            kstatetalkwait( var0 );
        }
        else if ( var1 == 10 )
        {
            kstatetalk( var0 );
        }
        else if ( isdefined( var0.vo_one_remain ) && !vehiclespawn_cargotruckmg() )
        {
            waitfornukecarriernearlz( var0 );
        }
        else
        {
            waitforoneplayernearlz( var0 );
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x4c
function wait_in_spectate_for_time( var0 )
{
    var0.ref_11ea4 = 0;
    var0.nodeidle = 0;
    var0.ref_11ea9 = 0;
    var0.ref_11ea7 = 0;
    var0.ref_11f40 = randomintrange( level.ref_11e18.wait_for_player_in_gas, level.ref_11e18.wait_for_player_gulag_respawn + 1 );
}

// Params 1
// Size: 0xc6
function waitforoneplayernearlz( var0 )
{
    if ( wait_for_weapons_free( var0 ) )
    {
        wait_in_spectate_for_time( var0 );
        waitforremoteend( var0 );
        return;
    }
    
    if ( !level.ref_11e18.[µÂ£“£ÊX£°Æ¶ && wait_for_time_or_notify( var0 ) )
    {
        waitforhvttrigger( var0 );
        return;
    }
    
    if ( kreadytoswat( var0 ) )
    {
        kstatechooseswat( var0 );
        return;
    }
    
    if ( var0.nodeidle && var0.ref_11ea7 )
    {
        var0.nodeidle = 0;
        var0.ref_11ea7 = 0;
    }
    
    var1 = [];
    
    if ( !var0.nodeidle )
    {
        GscBinSkip0( 0x2e, var1.size, &waitforplayerstoconnect );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( tcanrandomkillstreak( var0 ) )
    {
        GscBinSkip0( 0x2e, var1.size, &waitforplayerstoconnect_countdown );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    var2 = 0;
    
    if ( var1.size > 1 )
    {
        var2 = randomint( var1.size );
    }
    
    if ( var1.size > 0 )
    {
        [[ var1[ var2 ] ]]( var0 );
        return;
    }
    
    waitforplayerstoconnect( var0 );
}

// Params 1
// Size: 0x17
function kstatetalkwait( var0 )
{
    var0 endon( "break_idle" );
    kstateidle( var0, "s4_mp_kenosha_idle_breath_01" );
}

// Params 1
// Size: 0x72
function kstatetalk( var0 )
{
    var1 = level.ref_11e18.setincomingremovedcallback;
    var2 = var1.origin - var0.origin;
    var3 = vectortoangles( var2 );
    var4 = angleclamp180( var3[ 1 ] );
    kstaterotate( var0, var4, var1.origin );
    ref_13c1d( var0, "s4_mp_kenosha_idle_bark_01" );
    waitandstartparachuteoverheadmonitoring( 0 );
    
    if ( getdvarint( "scr_br_mxp_g_force_stay", 0 ) > 0 )
    {
        set_maze_ai_stealth_settings( 12 );
        return;
    }
    
    set_maze_ai_stealth_settings( 0 );
}

// Params 1
// Size: 0x9c, Type: bool
function wait_for_weapons_free( var0 )
{
    var1 = kgetnextindex();
    
    if ( vehiclespawn_cargotruckmg() )
    {
        return true;
    }
    else if ( kisingas( var0 ) )
    {
        if ( isdefined( var1 ) )
        {
            return ( level.ref_11e18.wait_for_open != var1 );
        }
        else
        {
            var2 = kgetlastindex();
            return ( level.ref_11e18.wait_for_open != var2 );
        }
    }
    else if ( wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !kisintelcrateingas() )
    {
        return true;
    }
    else if ( !wait_after_first_counter() && var1.ref_11ea4 >= var1.ref_11f40 )
    {
        return ( level.ref_11e18.wait_for_open != var2 );
    }
    
    return false;
}

// Params 1
// Size: 0x15
function kisingas( var0 )
{
    return kisindexingas( level.ref_11e18.wait_for_open );
}

// Params 1
// Size: 0x21, Type: bool
function kisindexingas( var0 )
{
    var1 = level.ref_11e18.wait_for_player_eliminated[ var0 ];
    
    if ( update_volume_flag( var1 ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x87
function waitforhvttrigger( var0 )
{
    var1 = vehiclespawninginto();
    
    if ( isdefined( var1 ) )
    {
        var2 = _getrandomlocations::ref_11a9f( var0.origin, level.ref_11e18.›5t*mòÓp½S›ˆM', 0, 5 );
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "dangerNotifyPlayersInRange" ) )
        {
            var0 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "dangerNotifyPlayersInRange" ) ]]( var0.origin, level.ref_11e18.›5t*mòÓp½S›ˆM', "kenosha_strike", 0 );
        }
        
        var3 = var1.origin;
        waitforplayerstoconnect( var0 );
        waitforplayerentering( var0, var3, var1 );
        var2 delete();
        return;
    }
}

// Params 0
// Size: 0x23, Type: bool
function vehicle_occupancy_setfriendlystatusdirty()
{
    if ( wait_after_first_counter() )
    {
        return ( level.ref_11e18.wait_and_destroy == level.ref_11e18.wait_for_open );
    }
    
    return false;
}

// Params 0
// Size: 0x16, Type: bool
function wait_after_first_counter()
{
    if ( isdefined( level.ref_11e18.wait_and_destroy ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x13, Type: bool
function kisintelcrateingas()
{
    return kisindexingas( level.ref_11e18.wait_and_destroy );
}

// Params 0
// Size: 0xdf
function vehiclespawninginto()
{
    foreach ( var1 in level.train_hurt_damage_watcher )
    {
        if ( isintelcratevalid( var1 ) && var1.trial_flares.type == "k" && var1.trial_flares.index == level.ref_11e18.wait_for_open && gettime() >= var1.trial_flares.expiretime )
        {
            return var1;
        }
    }
    
    if ( level.ref_11e18.[µÂ£“£ÊX£°Æ¶ )
    {
        foreach ( var1 in level.train_hurt_damage_watcher )
        {
            if ( isintelcratevalid( var1 ) && var1.trial_flares.type == "k" && gettime() >= var1.trial_flares.expiretime )
            {
                return var1;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x17
function waitandstartparachuteoverheadmonitoring( var0 )
{
    level.ref_11e18.wait_for_next_hack_complete.state = var0;
}

// Params 0
// Size: 0x14
function vehoccupancy_lastbctime()
{
    return level.ref_11e18.wait_for_next_hack_complete.state;
}

// Params 0
// Size: 0x1b, Type: bool
function kinjumpstate()
{
    var0 = vehoccupancy_lastbctime();
    return var0 == 1 || var0 == 2 || var0 == 3;
}

// Params 0
// Size: 0xc, Type: bool
function kinnodestate()
{
    var0 = vehoccupancy_lastbctime();
    return var0 == 0;
}

// Params 0
// Size: 0x5c
function khastomoveforkillstreak()
{
    if ( level.ref_11e18.“«­Ò­–è°7-k7²,m && level.ref_11e18.wait_for_open == level.ref_11e18.ŠRëW;ôè;llÛˆ~—Á
ë )
    {
        var0 = kgetnextindexorigin();
        var1 = var0[ 0 ];
        var2 = var0[ 1 ];
        var0 = undefined;
        
        if ( level.ref_11e18.wait_for_open != var1 )
        {
            return [ 1, var1 ];
        }
    }
    
    return [ 0, undefined ];
}

// Params 2
// Size: 0x179
function waitfornukecarriernearlz( var0, var1 )
{
    var2 = khastomoveforkillstreak();
    var3 = var2[ 0 ];
    var4 = var2[ 1 ];
    var2 = undefined;
    
    if ( var3 )
    {
        waitforremoteend( var0, var4 );
    }
    
    waitandstartparachuteoverheadmonitoring( 5 );
    var5 = var0.vo_one_remain;
    var6 = randomfloatrange( -180, 180 );
    var7 = angleclamp180( var0.angles[ 1 ] );
    
    if ( isdefined( var5.origin ) )
    {
        var8 = var5.origin - var0.origin;
        var9 = vectortoangles( var8 );
        var6 = var9[ 1 ];
    }
    
    var10 = angleclamp180( var6 - var7 );
    var11 = vehicleturretshootthread( var0, var10 );
    var12 = var11[ 0 ];
    var13 = var11[ 1 ];
    var14 = var11[ 2 ];
    var11 = undefined;
    
    if ( isdefined( var12 ) && var12 != "" )
    {
        ref_13c1d( var0, var12 );
    }
    else
    {
        var15 = ( 0, var10, 0 );
        var0.x1fin_respawn rotateby( var15, var13 );
    }
    
    if ( var0.vo_one_remain != var5 )
    {
        return;
    }
    
    ref_13c1d( var0, "s4_mp_kenosha_stomp_attack_01" );
    
    if ( var0.vo_one_remain != var5 )
    {
        return;
    }
    
    if ( kshoulddelaykillstreak( var0 ) )
    {
        waitforplayerstoconnect( var0 );
        
        if ( var0.vo_one_remain != var5 )
        {
            return;
        }
    }
    
    _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback( 1 );
    
    if ( var5.change_goal_radius_weapons_free_internal == 2 )
    {
        thread ref_13c1d( var0 );
    }
    else if ( var5.change_goal_radius_weapons_free_internal == 1 )
    {
        thread ref_13c1d( var0 );
    }
    else
    {
        thread ref_13c1d( var0 );
    }
    
    waitbombusestart( var0 );
    waitandstartparachuteoverheadmonitoring( 0 );
}

// Params 3
// Size: 0xb1
function waitforplayerentering( var0, var1, var2 )
{
    waitandstartparachuteoverheadmonitoring( 8 );
    var3 = angleclamp180( var0.angles[ 1 ] );
    var4 = var1 - var0.origin;
    var5 = vectortoangles( var4 );
    var6 = var5[ 1 ];
    var7 = angleclamp180( var6 - var3 );
    var8 = vehicleturretshootthread( var0, var7 );
    var9 = var8[ 0 ];
    var10 = var8[ 1 ];
    var11 = var8[ 2 ];
    var8 = undefined;
    
    if ( isdefined( var9 ) && var9 != "" )
    {
        ref_13c1d( var0, var9 );
    }
    else
    {
        var12 = ( 0, var7, 0 );
        var0.x1fin_respawn rotateby( var12, var10 );
    }
    
    if ( isdefined( var2 ) )
    {
        thread vehicle_playerenteredtrackedlittlebird( var0, var2, 1 );
    }
    
    ref_13c1d( var0, "s4_mp_kenosha_stomp_attack_01" );
    waitandstartparachuteoverheadmonitoring( 0 );
}

// Params 3
// Size: 0x1e
function vehicle_playerenteredtrackedlittlebird( var0, var1, var2 )
{
    var0 scripts\engine\utility::waittill_notify_or_timeout( "kenosha_ground_pound", 1.5 );
    var1 thread scripts\mp\gametypes\br_gametype_mendota::train_get_anim_ents_index();
}

// Params 1
// Size: 0x3a
function kshoulddelaykillstreak( var0 )
{
    var1 = gettime() - var0.vo_one_remain.starttime;
    
    if ( kiskillstreakplayerinitiated( var0 ) )
    {
        return ( var1 < getdvarint( "scr_br_mxp_k_ks_player_delay", 0 ) );
    }
    
    return var1 < getdvarint( "scr_br_mxp_k_ks_delay", 0 );
}

// Params 1
// Size: 0x32, Type: bool
function kiskillstreakplayerinitiated( var0 )
{
    return isdefined( var0.vo_one_remain ) && isdefined( var0.vo_one_remain.player ) && isplayer( var0.vo_one_remain.player );
}

// Params 1
// Size: 0x17
function waitfor_firstgroup_killedoffenough( var0 )
{
    level.ref_11e18.wait_for_next_hack_complete.vo_one_remain = var0;
}

// Params 1
// Size: 0x15
function kendkillstreak( var0 )
{
    level.ref_11e18.wait_for_next_hack_complete.vo_one_remain = undefined;
}

// Params 1
// Size: 0x5b
function waitbombusestart( var0 )
{
    if ( var0.vo_one_remain.change_goal_radius_weapons_free_internal == 2 )
    {
        var0 scripts\engine\utility::waittill_notify_or_timeout( "kenosha_stomp", 1.5 );
    }
    else
    {
        var0 scripts\engine\utility::waittill_notify_or_timeout( "kenosha_grab_rock", 1.5 );
    }
    
    var0 setscriptablepartstate( "rumble", "medium", 0 );
    _getrandomlocations::vehicle_spawn_cancelpendingrespawns( var0.vo_one_remain );
}

// Params 2
// Size: 0xfe
function vehicleturretshootthread( var0, var1 )
{
    var2 = 22.5;
    var3 = 67.5;
    var4 = 112.5;
    var5 = 157.5;
    var6 = abs( var1 );
    var7 = scripts\engine\utility::sign( var1 ) < 0;
    
    if ( var6 <= var2 )
    {
        return [ "", 1, 0 ];
    }
    
    if ( var6 < var3 )
    {
        if ( var7 )
        {
            return [ "s4_mp_kenosha_turn_r_45", 2.2, 45 ];
        }
        
        return [ "s4_mp_kenosha_turn_l_45", 2.2, 45 ];
    }
    
    if ( var6 < var4 )
    {
        if ( var7 )
        {
            return [ "s4_mp_kenosha_turn_r_90", 2.8, 90 ];
        }
        
        return [ "s4_mp_kenosha_turn_l_90", 2.8, 90 ];
    }
    
    if ( var6 < var5 )
    {
        if ( var7 )
        {
            return [ "s4_mp_kenosha_turn_r_135", 3, 135 ];
        }
        
        return [ "s4_mp_kenosha_turn_l_135", 3.3, 135 ];
    }
    
    if ( var7 )
    {
        return [ "s4_mp_kenosha_turn_r_180", 3.3, 180 ];
    }
    
    return [ "s4_mp_kenosha_turn_l_180", 3.3, 180 ];
}

// Params 1
// Size: 0xbe
function ksetnextidle( var0 )
{
    for ( var1 = 0; var1 < level.ref_11e18.­ÚÒFc•¹.size ; var1++ )
    {
        if ( !isdefined( var0.’K

¸AÏ7@µåx ) || var0.’K

¸AÏ7@µåx + 1 >= level.ref_11e18.­ÚÒFc•¹.size )
        {
            var0.’K

¸AÏ7@µåx = 0;
            var0.—;-c¬æ = scripts\engine\utility::array_randomize( level.ref_11e18.­ÚÒFc•¹ );
        }
        else
        {
            var0.’K

¸AÏ7@µåx++;
        }
        
        var2 = var0.—;-c¬æ[ var0.’K

¸AÏ7@µåx ];
        
        if ( !level.ref_11e18.“«­Ò­–è°7-k7²,m || level.ref_11e18.“«­Ò­–è°7-k7²,m && !issubstr( var2, "s4_mp_kenosha_idle_knuckles" ) )
        {
            break;
        }
    }
    
    return var0.’K

¸AÏ7@µåx;
}

// Params 2
// Size: 0xdc
function waitforplayerstoconnect( var0, var1 )
{
    var2 = [];
    
    if ( getdvarint( "scr_br_mxp_k_look_down_enabled", 1 ) == 1 )
    {
        var2 = kenemiesnearonground( var0 );
    }
    
    if ( var2.size > 0 )
    {
        var3 = kselectlookattarget( var0, var2 );
        var4 = angleclamp180( var0.angles[ 1 ] );
        var5 = var3.origin - var0.origin;
        var6 = vectortoangles( var5 );
        var7 = var6[ 1 ];
        var8 = angleclamp180( var7 - var4 );
        var9 = vehicleturretshootthread( var0, var8 );
        var10 = var9[ 0 ];
        var11 = var9[ 1 ];
        var12 = var9[ 2 ];
        var9 = undefined;
        
        if ( isdefined( var10 ) && var10 != "" )
        {
            ref_13c1d( var0, var10 );
        }
        
        ref_13c1d( var0, "s4_mp_kenosha_idle_lookingdown_01" );
    }
    else
    {
        var13 = ksetnextidle( var0 );
        var14 = var0.—;-c¬æ[ var13 ];
        ref_13c1d( var0, var14 );
    }
    
    var0.nodeidle = 1;
    var0.ref_11ea4++;
}

// Params 2
// Size: 0xd
function kstateidle( var0, var1 )
{
    ref_13c1d( var0, var1 );
}

// Params 3
// Size: 0x5d
function kstaterotate( var0, var1, var2 )
{
    var3 = var0.angles;
    var4 = angleclamp180( var3[ 1 ] );
    var5 = angleclamp180( var1 - var4 );
    var6 = vehicleturretshootthread( var0, var5 );
    var7 = var6[ 0 ];
    var8 = var6[ 1 ];
    var6 = undefined;
    
    if ( var7 != "" )
    {
        ref_13c1d( var0, var7 );
    }
    
    var9 = ( 0, var1, 0 );
    var0 orientmode( "face point", var2 );
}

// Params 2
// Size: 0x287
function waitforremoteend( var0, var1 )
{
    waitandstartparachuteoverheadmonitoring( 6 );
    var2 = var0.origin;
    var3 = var0.angles;
    jumpiffalse(isdefined( var1 )) LOC_0000003a;
    var4 = var1;
    var5 = level.ref_11e18.wait_for_player_eliminated[ var4 ];
    goto LOC_00000052;
}

// Params 0
// Size: 0xfb
function klaunchplayersduringjump()
{
    var0 = self;
    var0 notify( "kLaunchPlayersDuringJump" );
    var0 endon( "kLaunchPlayersDuringJump" );
    
    if ( var0.¡jÆ{ÆÒnZ·s6´7Ñ.size == 0 )
    {
        return;
    }
    
    var1 = getdvarfloat( "scr_br_mxp_lp_pre_jump_delay", 0.65 );
    var2 = getdvarint( "scr_br_mxp_lp_check_duration", 1000 );
    var3 = getdvarint( "scr_br_mxp_lp_check_radius", 550 );
    var4 = getdvarfloat( "scr_br_mxp_lp_check_interval", 0.5 );
    var5 = getdvarint( "scr_br_mxp_lp_speed", 5000 );
    wait var1;
    var6 = var0.¡jÆ{ÆÒnZ·s6´7Ñ[ "head" ].•T>ÿ#K‡ò8˜ZÛ;
    var7 = gettime() + var2;
    
    while ( gettime() < var7 )
    {
        var8 = getentarrayinradius( "player", "classname", var6.origin, var3 );
        
        foreach ( var10 in var8 )
        {
            if ( !isalive( var10 ) )
            {
                continue;
            }
            
            var11 = var10 getgroundentity();
            
            if ( isdefined( var11 ) && var11 == var6 )
            {
                var10 setvelocity( ( 0, 0, var5 ) );
            }
        }
        
        wait var4;
    }
}

// Params 1
// Size: 0x15
function kgetindexorigin( var0 )
{
    var1 = level.ref_11e18.wait_for_player_eliminated[ var0 ];
    return var1;
}

// Params 0
// Size: 0x27
function kgetnextindexorigin()
{
    var0 = kgetnextindex();
    
    if ( !isdefined( var0 ) )
    {
        var0 = kgetlastindex();
    }
    
    var1 = level.ref_11e18.wait_for_player_eliminated[ var0 ];
    return [ var0, var1 ];
}

// Params 2
// Size: 0xaa
function kgetjumpinfo( var0, var1 )
{
    var2 = spawnstruct();
    var2.ªh{E¨œ¿­›ƒË = level.ref_11e18.©[J‚Ş‰¤øÙã;
    var2.¢H
½•#Ï¹ = level.ref_11e18.M*ÊwIr³èŠ3 ;
    var3 = distance2dsquared( var0, var1 );
    
    if ( var3 > level.ref_11e18.¾f’º…¨Ai£ğ0èç­¶Ù{ )
    {
        var2.ªh{E¨œ¿­›ƒË = level.ref_11e18.†x‹U°ùb’·Ä¬«x¡;
        var2.¢H
½•#Ï¹ = level.ref_11e18.¯M[S]Ú7Á¬+‘¶XÃ;
    }
    else if ( var3 > level.ref_11e18.±Öµ¦Wµ8Œ–›è…æØÊ­ZÈÜ¸ )
    {
        var2.ªh{E¨œ¿­›ƒË = level.ref_11e18.§m©®kvœ,g¥G—µ-;
        var2.¢H
½•#Ï¹ = level.ref_11e18.–MÇPí¸ë5iÀƒ9;
    }
    
    return var2;
}

// Params 1
// Size: 0x11
function kstatesetindex( var0 )
{
    level.ref_11e18.wait_for_open = var0;
}

// Params 0
// Size: 0x2c
function kgetnextindex()
{
    if ( wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !kisintelcrateingas() )
    {
        return level.ref_11e18.wait_and_destroy;
    }
    
    return kgetsafenode();
}

// Params 0
// Size: 0x54
function kgetlastindex()
{
    var0 = undefined;
    var1 = undefined;
    
    for ( var2 = 0; var2 < level.ref_11e18.wait_for_player_eliminated.size ; var2++ )
    {
        var3 = level.ref_11e18.wait_for_player_eliminated[ var2 ];
        var4 = distance2dsquared( var3, level.grouptorewards );
        
        if ( !isdefined( var0 ) || var4 < var0 )
        {
            var0 = var4;
            var1 = var2;
        }
    }
    
    return var1;
}

// Params 0
// Size: 0xab
function kgetsafenode()
{
    var0 = level.ref_11e18.wait_for_open;
    var1 = level.ref_11e18.wait_for_open;
    
    for ( var2 = 0; var2 < level.ref_11e18.wait_for_player_eliminated.size ; var2++ )
    {
        var0 = scripts\engine\utility::ter_op( var0 + 1 < level.ref_11e18.wait_for_player_eliminated.size, var0 + 1, 0 );
        var3 = level.ref_11e18.wait_for_player_eliminated[ var0 ];
        
        if ( !update_volume_flag( var3 ) )
        {
            return var0;
        }
        
        var1 = scripts\engine\utility::ter_op( var1 - 1 >= 0, var1 - 1, level.ref_11e18.wait_for_player_eliminated.size - 1 );
        var4 = level.ref_11e18.wait_for_player_eliminated[ var1 ];
        
        if ( !update_volume_flag( var4 ) )
        {
            return var1;
        }
    }
}

// Params 1
// Size: 0xb6
function kenemiesinview( var0 )
{
    var1 = level.ref_11e18.wait_for_next_hack_complete gettagorigin( "j_head" ) + ( 0, 0, level.ref_11e18.ƒ½#ş«Ç#éºRXùİc!fµ´ );
    var2 = level.ref_11e18.‹uXêO0R×Ÿ½ßKÇ ùÃÃ;
    var3 = getentarrayinradius( "player", "classname", var1, var2 );
    var4 = tablesort( var1, var2, level.ref_11e18.jÖnîÂ£,N·¡•KÎ† );
    var5 = scripts\engine\utility::array_combine( var3, var4 );
    var6 = [];
    
    foreach ( var8 in var5 )
    {
        var9 = var8.origin[ 2 ] - var1[ 2 ];
        
        if ( var9 > 0 && var9 < level.ref_11e18.jÖnîÂ£,N·¡•KÎ† )
        {
            var6 = var8;
        }
    }
    
    return var6;
}

// Params 1
// Size: 0x3c
function kenemiesnearonground( var0 )
{
    var1 = level.ref_11e18.wait_for_next_hack_complete gettagorigin( "tag_origin" );
    var2 = level.ref_11e18.•ˆ´¨z[2Sx‹'¥À#;
    var3 = getentarrayinradius( "player", "classname", var1, var2 );
    var4 = var3;
    return var4;
}

// Params 2
// Size: 0x76
function kselectlookattarget( var0, var1 )
{
    var2 = anglestoforward( var0.angles );
    var3 = [];
    
    foreach ( var5 in var1 )
    {
        var6 = var5.origin - var0.origin;
        var7 = vectordot( var2, var6 );
        
        if ( var7 > 0 )
        {
            var3 = var5;
        }
    }
    
    if ( var3.size > 0 )
    {
        return scripts\engine\utility::random( var3 );
    }
    
    return scripts\engine\utility::random( var1 );
}

// Params 1
// Size: 0x4e, Type: bool
function kisplayerorplane( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( isalive( var0 ) && ( isplayer( var0 ) || isagent( var0 ) ) )
    {
        return true;
    }
    
    if ( var0 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() )
    {
        if ( var0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() || var0 scripts\common\vehicle::ishelicopter() )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x69, Type: bool
function kreadytoswat( var0 )
{
    if ( getdvarfloat( "scr_br_mxp_kk_swat_timer", 10 ) > 0 )
    {
        if ( isdefined( var0.¸4cùCË¯$&üÛ‘èò ) && gettime() - var0.¸4cùCË¯$&üÛ‘èò < 10000 )
        {
            return false;
        }
    }
    
    var1 = kenemiesinview( var0 );
    
    foreach ( var3 in var1 )
    {
        if ( kisplayerorplane( var3 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x19a
function kstatechooseswat( var0, var1 )
{
    var2 = kenemiesinview( var0 );
    var3 = 0;
    var4 = [];
    GscBinSkip0( 0x2e, 0, 0 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 2
// Size: 0x68
function kstateplayswat( var0, var1 )
{
    waitandstartparachuteoverheadmonitoring( 7 );
    var2 = [ "s4_mp_kenosha_swat_attack_fwd_01", "s4_mp_kenosha_swat_attack_l_01", "s4_mp_kenosha_swat_attack_r_01" ];
    var3 = [ 5.8, 4.5, 5 ];
    
    if ( !isdefined( var1 ) )
    {
        var1 = randomint( var2.size );
    }
    
    var4 = var2[ var1 ];
    var5 = var3[ var1 ];
    ref_13c1d( var0, var4 );
    var0.ref_11ea9 = 1;
    var0.ref_11ea4++;
}

// Params 1
// Size: 0x10c
function khandkilltriggers( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( isdefined( level.ref_11e18.wait_for_next_hack_complete.ƒ"-s²§û´şP°úê ) || isdefined( level.ref_11e18.wait_for_next_hack_complete.„":9-ÙÎ•'Í+ ) )
        {
            return;
        }
        
        level.ref_11e18.wait_for_next_hack_complete.ƒ"-s²§û´şP°úê = gkkilltriggercreate( level.ref_11e18.wait_for_next_hack_complete, level.ref_11e18.—WOó7(âÎˆóË, level.ref_11e18.‚]x#Ï¿¨e+?€Ã, "j_mid_ri_1" );
        level.ref_11e18.wait_for_next_hack_complete.„":9-ÙÎ•'Í+ = gkkilltriggercreate( level.ref_11e18.wait_for_next_hack_complete, level.ref_11e18.—WOó7(âÎˆóË, level.ref_11e18.‚]x#Ï¿¨e+?€Ã, "j_mid_le_1" );
        return;
    }
    
    if ( !isdefined( level.ref_11e18.wait_for_next_hack_complete.ƒ"-s²§û´şP°úê ) || !isdefined( level.ref_11e18.wait_for_next_hack_complete.„":9-ÙÎ•'Í+ ) )
    {
        return;
    }
    
    gkkilltriggerdestroy( level.ref_11e18.wait_for_next_hack_complete.ƒ"-s²§û´şP°úê );
    gkkilltriggerdestroy( level.ref_11e18.wait_for_next_hack_complete.„":9-ÙÎ•'Í+ );
}

// Params 1
// Size: 0x146
function waitforplayerstoconnect_countdown( var0 )
{
    var1 = tgetnextangertarget( var0 );
    
    if ( !isdefined( var1 ) )
    {
        if ( level.ref_11e18.[µÂ£“£ÊX£°Æ¶ )
        {
            var1 = vehiclespawninginto();
        }
        
        if ( !isdefined( var1 ) )
        {
            var1 = var0 scripts\mp\gametypes\_mxp_target::pristinestatehealthadd( level.ref_11e18.wait_for_player_to_getup, level.ref_11e18.wait_for_players_init_puzzle );
        }
    }
    else
    {
        tremoveangertarget( var0, var1 );
    }
    
    jumpiffalse(isdefined( var1 )) LOC_00000083;
    var2 = randomizeattacklocation( var1.origin, level.ref_11e18.waitandstartplunderpolling );
    var3 = vectortoangles( var2 - var0.origin );
    goto LOC_000000b1;
}

// Params 1
// Size: 0x3c, Type: bool
function wait_for_time_or_notify( var0 )
{
    var1 = khastomoveforkillstreak();
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var1 = undefined;
    
    if ( wait_after_first_counter() && vehicle_occupancy_setfriendlystatusdirty() && !var2 )
    {
        var4 = vehiclespawninginto();
        
        if ( isdefined( var4 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x86
function set_maze_ai_state( var0 )
{
    var1 = level.ref_11e18.setincomingremovedcallback;
    var1.gunposeoverride_internal = "disable";
    var1.upaimlimit = -90;
    var1.downaimlimit = 90;
    var1.rightaimlimit = -90;
    var1.leftaimlimit = 90;
    var1.aimyawspeed = 100;
    var2 = ( 0, 0, 0 );
    var3 = sandbox_combat_area();
    var4 = var1 setaimangles( var3, var0, 1, var2, 0, 0, 0 );
    gsetaimstate( var1, level.ref_11e18.
”~²ûsl—¨( );
}

// Params 2
// Size: 0xb
function gsetaimstate( var0, var1 )
{
    var0 setaimstate( var1 );
}

// Params 1
// Size: 0x2e
function sandbox_combat_area( var0 )
{
    var1 = level.ref_11e18.setincomingremovedcallback.origin;
    
    if ( isdefined( var0 ) )
    {
        var1 = var0;
    }
    
    return var1 + ( 0, 0, 8100 );
}

// Params 0
// Size: 0x22
function vehiclespawn_littlebirdmg()
{
    return level.ref_11e18.wait_for_next_hack_complete.origin + ( 0, 0, 3400 );
}

// Params 0
// Size: 0x133
function ref_13220()
{
    if ( !isdefined( level.agent_funcs[ "actor_greenbay" ] ) )
    {
        level.agent_funcs[ "actor_greenbay" ] = [];
    }
    
    level.agent_funcs[ "actor_greenbay" ][ "spawn" ] = &scripts\mp\mp_agent::default_spawn_func;
    level.agent_funcs[ "actor_greenbay" ][ "on_damaged" ] = &post_customization_func;
    level.agent_funcs[ "actor_greenbay" ][ "gametype_on_damage_finished" ] = &post_get_up_animation_function;
    
    if ( !isdefined( level.agent_definition ) )
    {
        level.agent_definition = [];
    }
    
    if ( !isdefined( level.agent_definition[ "actor_greenbay" ] ) )
    {
        level.agent_definition[ "actor_greenbay" ] = [];
    }
    
    level.agent_definition[ "actor_greenbay" ][ "animclass" ] = "greenbay";
    
    if ( !isdefined( level.agent_funcs[ "actor_kenosha" ] ) )
    {
        level.agent_funcs[ "actor_kenosha" ] = [];
    }
    
    level.agent_funcs[ "actor_kenosha" ][ "spawn" ] = &scripts\mp\mp_agent::default_spawn_func;
    level.agent_funcs[ "actor_kenosha" ][ "on_damaged" ] = &vehicle_occupancy_takeriotshield;
    level.agent_funcs[ "actor_kenosha" ][ "gametype_on_damage_finished" ] = &vehicle_occupancy_updateriotshield;
    
    if ( !isdefined( level.agent_definition[ "actor_kenosha" ] ) )
    {
        level.agent_definition[ "actor_kenosha" ] = [];
    }
    
    level.agent_definition[ "actor_kenosha" ][ "animclass" ] = "kenosha";
}

// Params 7
// Size: 0x106
function spawnnewagent( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = "actor_" + var0;
    var8 = scripts\mp\mp_agent::getfreeagent( var7 );
    
    if ( !isdefined( var3 ) )
    {
        var3 = ( 0, 0, 0 );
    }
    
    var8 scripts\mp\mp_agent::set_agent_team( "team_two_hundred" );
    var8 setmodel( var1 );
    var8 show();
    var8 spawnagent( var2, var3, level.agent_definition[ var7 ][ "animclass" ], var4, var5, undefined, 0 );
    var8.connecttime = gettime();
    var8.agent_height = var5;
    var8.agent_radius = var4;
    var8.callback = var0;
    var8.asmname = var0;
    var8.is_scripted_agent = 1;
    var8.scripted_mode = 1;
    var8.ignoreall = 1;
    var8 scripts\mp\mp_agent::set_agent_team( "team_two_hundred" );
    var8 scripts\mp\mp_agent::set_agent_health( 9999 );
    var8 scripts\mp\mp_agent::add_to_characters_array();
    var8 scripts\mp\mp_agent::activateagent();
    var8 scripts\engine\utility::set_ai_number();
    var8 animmode( "noclip" );
    var8.animationarchetype = var0;
    var8 scripts\asm\asm_mp::asm_init( var0, var0 );
    var8.intro_heli_animate_player = var6;
    return var8;
}

// Params 14
// Size: 0x73
function post_customization_func( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 )
{
    if ( shouldignorevehicleaabbcollision( var0, var1, var4 ) )
    {
        return;
    }
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback.ref_12930 ) || istrue( level.ref_11e18.playerregendelayspeed ) )
    {
        scripts\mp\gametypes\br_publicevent_fresno::sec_sys_struct_3( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        return;
    }
    
    tagentdamaged( var0, var1, var2, var4, var5 );
}

// Params 15
// Size: 0x15
function post_get_up_animation_function( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    var15 = 0;
}

// Params 14
// Size: 0x64
function vehicle_occupancy_takeriotshield( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 )
{
    if ( isdefined( level.ref_11e18.wait_for_next_hack_complete.ref_12930 ) || istrue( level.ref_11e18.playerregendelayspeed ) )
    {
        scripts\mp\gametypes\br_publicevent_fresno::sec_sys_struct_3( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        return;
    }
    
    tagentdamaged( var0, var1, var2, var4, var5 );
}

// Params 15
// Size: 0x15
function vehicle_occupancy_updateriotshield( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    var15 = 0;
}

// Params 5
// Size: 0x89
function tagentdamaged( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var4 ) && var4.basename == "greenbay_strike" )
    {
        return;
    }
    
    var5 = var1;
    
    if ( isdefined( var1.classname ) && ( var1.classname == "script_vehicle" || var1.classname == "misc_turret" ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var5 = var1.owner;
        }
    }
    
    if ( isplayer( var5 ) )
    {
        playerupdatetomahdamage( var5, self, var2, var3, var4, 0 );
        var5 scripts\mp\damagefeedback::updatedamagefeedback( "standard", 0, 0, "standard", 0, 1 );
        return;
    }
}

// Params 5
// Size: 0x158
function playerupdatetomahdamage( var0, var1, var2, var3, var4 )
{
    var1 = modifydamagebyweapon( var1, var2, var3 );
    playerupdatetomahdamagechallenges( var0, var1, var4 );
    var5 = self getentitynumber();
    var6 = 0;
    
    if ( !isdefined( var0.£ı¨y‚ø£ôb1o[ var5 ] ) )
    {
        var0.£ı¨y‚ø£ôb1o[ var5 ] = 0;
        var6 = 1;
    }
    
    var7 = int( var0.£ı¨y‚ø£ôb1o[ var5 ] / level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM );
    var8 = ( var7 + 1 ) * level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM;
    var9 = int( var0.£ı¨y‚ø£ôb1o[ var5 ] / level.ref_11e18.‡#µ³¬«Í–c7ŞÒY );
    var10 = ( var9 + 1 ) * level.ref_11e18.‡#µ³¬«Í–c7ŞÒY;
    var0.£ı¨y‚ø£ôb1o[ var5 ] += var1;
    scripts\mp\gametypes\br_public::updatebrscoreboardstat( "tomahDamage", int( var0.£ı¨y‚ø£ôb1o[ var5 ] / 10 ) );
    
    if ( var0.£ı¨y‚ø£ôb1o[ var5 ] >= var8 )
    {
        var6 = 1;
    }
    
    if ( var6 )
    {
        var11 = int( var0.£ı¨y‚ø£ôb1o[ var5 ] / level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM ) - var7;
        thread scripts\mp\gametypes\br_gametype_mendota::intel_collectedmisc( self, var11, var3.basename );
    }
    
    if ( var0.£ı¨y‚ø£ôb1o[ var5 ] >= var10 )
    {
        tupdateangertarget( var0, self, 1 );
    }
    
    if ( isplayer( self ) )
    {
        var12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon( var3 );
        var13 = isdefined( var12 ) && var12 == "precision_airstrike";
        
        if ( var13 )
        {
            if ( isdefined( self.brattractions ) )
            {
                self.brattractions++;
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x157
function modifydamagebyweapon( var0, var1, var2 )
{
    if ( var0 > level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM )
    {
        var0 = level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM;
    }
    
    var3 = weaponclass( var2 );
    var4 = scripts\mp\utility\weapon::getweaponrootname( var2 );
    var5 = 0;
    var6 = "scr_br_mxp_max_" + var3;
    var7 = 50;
    
    if ( var3 == "sniper" )
    {
        var7 = 150;
    }
    else if ( var1 == "MOD_EXPLOSIVE" )
    {
        var7 = level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM;
    }
    else if ( var3 == "rocketlauncher" || issubstr( var4, "_la_" ) )
    {
        var7 = level.ref_11e18.‹ÌØê¥ÃéŸ`¥&A‹³ƒM;
        var5 = 1;
    }
    
    var8 = getdvarfloat( var6, var7 );
    
    if ( var8 != 0 )
    {
        var0 = int( min( var0, var8 ) );
    }
    
    var9 = "scr_br_mxp_scale_" + var4;
    var7 = 0;
    
    if ( issubstr( var4, "manual_turret_flak" ) )
    {
        if ( var1 == "MOD_EXPLOSIVE" )
        {
            var0 = 0;
        }
        else
        {
            var0 = 100;
        }
    }
    else if ( var5 )
    {
        var7 = 5;
    }
    else if ( scripts\mp\utility\weapon::update_health_on_spawn( var2 ) )
    {
        var7 = 0.45;
    }
    else
    {
        var10 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon( var2 );
        
        if ( isdefined( var10 ) && var10 == "greenbay_strike" )
        {
            return 0;
        }
        
        if ( isdefined( var10 ) && var10 == "precision_airstrike" )
        {
            var7 = 0.6;
        }
    }
    
    var11 = getdvarfloat( var9, var7 );
    
    if ( var11 != 0 )
    {
        var0 = int( ceil( var0 * var11 ) );
    }
    
    return var0;
}

// Params 3
// Size: 0x51
function playerupdatetomahdamagechallenges( var0, var1, var2 )
{
    if ( istrue( var2 ) )
    {
        if ( var0 == level.ref_11e18.wait_for_next_hack_complete )
        {
            scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "mv_event_intel_4", var1 );
        }
        else
        {
            scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "mv_event_intel_5", var1 );
        }
        
        scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "mv_event_intel_6", 1 );
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::ref_1301e( "mv_event_intel_1", var1 );
}

// Params 1
// Size: 0x4f
function onplayerdisconnect( var0 )
{
    var1 = var0 getentitynumber();
    
    if ( isdefined( level.ref_11e18.setincomingremovedcallback ) )
    {
        level.ref_11e18.setincomingremovedcallback.šö1ú‡¥€iå7•û@[ var1 ] = undefined;
    }
    
    if ( isdefined( level.ref_11e18.wait_for_next_hack_complete ) )
    {
        level.ref_11e18.wait_for_next_hack_complete.šö1ú‡¥€iå7•û@[ var1 ] = undefined;
        return;
    }
}

// Params 1
// Size: 0x59
function tgetnextangertarget( var0 )
{
    if ( var0.šö1ú‡¥€iå7•û@.size > 0 )
    {
        var1 = var0 scripts\engine\utility::array_sort_with_func( var0.šö1ú‡¥€iå7•û@, &tcompareangertargets );
        
        foreach ( var3 in var1 )
        {
            if ( isdefined( var3.player ) )
            {
                return var3.player;
            }
        }
        
        return;
    }
}

// Params 3
// Size: 0x48
function tupdateangertarget( var0, var1, var2 )
{
    var3 = var1 getentitynumber();
    taddangertarget( var0, var1 );
    var0.šö1ú‡¥€iå7•û@[ var3 ].time = gettime();
    var0.šö1ú‡¥€iå7•û@[ var3 ].‘§v‡±Å=z€‚ += var2;
}

// Params 2
// Size: 0x48
function taddangertarget( var0, var1 )
{
    var2 = var1 getentitynumber();
    
    if ( !isdefined( var0.šö1ú‡¥€iå7•û@[ var2 ] ) )
    {
        var0.šö1ú‡¥€iå7•û@[ var2 ] = spawnstruct();
        var0.šö1ú‡¥€iå7•û@[ var2 ].player = var1;
        var0.šö1ú‡¥€iå7•û@[ var2 ].‘§v‡±Å=z€‚ = 0;
        return;
    }
}

// Params 2
// Size: 0x14
function tremoveangertarget( var0, var1 )
{
    var2 = var1 getentitynumber();
    var0.šö1ú‡¥€iå7•û@[ var2 ] = undefined;
}

// Params 2
// Size: 0x6f
function tcompareangertargets( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.player ) )
    {
        return 0;
    }
    
    if ( !isdefined( var1 ) || !isdefined( var1.player ) )
    {
        return 1;
    }
    
    if ( var0.‘§v‡±Å=z€‚ < var1.‘§v‡±Å=z€‚ )
    {
        return 1;
    }
    
    if ( var0.‘§v‡±Å=z€‚ > var1.‘§v‡±Å=z€‚ )
    {
        return 0;
    }
    
    return var0.time > var1.time;
}

// Params 2
// Size: 0x4f
function ref_13187( var0, var1 )
{
    var2 = "ui_large_agent_entity_numbers";
    var3 = 8;
    var4 = var3;
    var5 = 0;
    
    if ( var0 )
    {
        var5 = var3;
    }
    
    var6 = int( pow( 2, var4 ) ) - 1;
    var7 = ( var1 & var6 ) << var5;
    var8 = ~( var6 << var5 );
    var9 = getomnvar( var2 );
    var10 = var9 & var8;
    var11 = var10 + var7;
    setomnvar( var2, var11 );
}

// Params 2
// Size: 0x55
function playertransfertomahanger( var0, var1 )
{
    if ( !level.ref_11e18.¡!)ÒğP¶“ÉuŸ(6 || !isdefined( var0 ) || !isplayer( var0 ) || !isdefined( var1 ) || var0 == var1 )
    {
        return;
    }
    
    ttransferanger( level.ref_11e18.setincomingremovedcallback, var0, var1 );
    ttransferanger( level.ref_11e18.wait_for_next_hack_complete, var0, var1 );
}

// Params 3
// Size: 0x9b
function ttransferanger( var0, var1, var2 )
{
    var3 = var1 getentitynumber();
    
    foreach ( var5 in var0.šö1ú‡¥€iå7•û@ )
    {
        if ( isdefined( var5 ) && isdefined( var5.player ) && var5.player == var2 )
        {
            taddangertarget( var0, var1 );
            var0.šö1ú‡¥€iå7•û@[ var3 ].time = gettime();
            var0.šö1ú‡¥€iå7•û@[ var3 ].‘§v‡±Å=z€‚ += var5.‘§v‡±Å=z€‚;
            tremoveangertarget( var0, var2 );
        }
    }
}

// Params 0
// Size: 0x2
function ____notifywatchers()
{
    
}

// Params 0
// Size: 0x32
function kstartnotifywatchers()
{
    var0 = level.ref_11e18.wait_for_next_hack_complete;
    thread vehomn_clearleveldataforvehicle();
    thread kleaplandwatcher();
    thread kchestslamwatcher();
    thread troarwatcher();
    thread tstepwatcher();
}

// Params 0
// Size: 0x24
function gstartnotifywatchers()
{
    var0 = level.ref_11e18.setincomingremovedcallback;
    thread gtailsmashwatcher();
    thread troarwatcher();
    thread tstepwatcher();
}

// Params 0
// Size: 0x20
function vehomn_clearleveldataforvehicle()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "kenosha_ground_pound" );
        vehomn_clearcontrols();
    }
}

// Params 0
// Size: 0x2b
function kleaplandwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "kenosha_leap_land" );
        self setscriptablepartstate( "rumble", "medium", 0 );
    }
}

// Params 0
// Size: 0x36
function vehomn_clearcontrols()
{
    tstunplayersandremovearmor( self.origin + ( 0, 0, 50 ), level.ref_11e18.›5t*mòÓp½S›ˆM' );
    self setscriptablepartstate( "rumble", "heavy", 0 );
}

// Params 0
// Size: 0x2b
function kchestslamwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "kenosha_chest_slam" );
        self setscriptablepartstate( "rumble", "light", 0 );
    }
}

// Params 0
// Size: 0x2b
function gtailsmashwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "greenbay_tail_smash" );
        self setscriptablepartstate( "rumble", "heavy", 0 );
    }
}

// Params 0
// Size: 0x27
function troarwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "titan_roar" );
        thread troarfeedback();
        thread troarscreenfxmanager();
    }
}

// Params 0
// Size: 0xa8
function troarscreenfxmanager()
{
    level endon( "game_ended" );
    var0 = level.ref_11e18.¸T’hhG³âR¨ÿó;
    var1 = 0.25;
    var2 = 0;
    jumpiffalse(self == level.ref_11e18.setincomingremovedcallback) LOC_00000040;
    var0 = level.ref_11e18.©‡ˆğAá•ªf}ƒª;
    
    while ( var2 < var0 )
    {
        var3 = scripts\mp\utility\player::getplayersinradius( self.origin, level.ref_11e18.½"ÑÊìË™Y¬‘&ÂÖä…7;• );
        
        foreach ( var5 in var3 )
        {
            if ( isalive( var5 ) )
            {
                thread tplayroarscreenfx( var5 );
                thread screenfxendearlywatcher();
            }
        }
        
        wait var1;
        var2 += var1;
    }
}

// Params 1
// Size: 0x47
function tplayroarscreenfx( var0 )
{
    self notify( "tPlayRoarScreenFX_starting" );
    self endon( "tPlayRoarScreenFX_starting" );
    self setscriptablepartstate( "headVFX", "mendotaRoar", 0 );
    scripts\engine\utility::waittill_notify_or_timeout( "roar_screen_fx_end_early", var0 );
    self notify( "roar_screen_fx_end" );
    self setscriptablepartstate( "headVFX", "neutral", 0 );
}

// Params 0
// Size: 0x20
function screenfxendearlywatcher()
{
    self endon( "roar_screen_fx_end" );
    self endon( "tPlayRoarScreenFX_starting" );
    self waittill( "death_or_disconnect" );
    self notify( "roar_screen_fx_end_early" );
}

// Params 0
// Size: 0x34
function troarfeedback()
{
    if ( self == level.ref_11e18.setincomingremovedcallback )
    {
        self setscriptablepartstate( "rumble", "heavy_long", 0 );
        return;
    }
    
    self setscriptablepartstate( "rumble", "heavy", 0 );
}

// Params 0
// Size: 0x21
function tstepwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "titan_step" );
        thread tstepfeedback();
    }
}

// Params 0
// Size: 0x12
function tstepfeedback()
{
    self setscriptablepartstate( "rumble", "light", 0 );
}

// Params 0
// Size: 0x2
function active_healthpacks()
{
    
}

// Params 3
// Size: 0x3a
function tplaydialogforplayersinrange( var0, var1, var2 )
{
    var3 = scripts\common\utility::playersincylinder( var1, var2 );
    
    foreach ( var5 in var3 )
    {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var5 );
    }
}

// Params 0
// Size: 0x5b, Type: bool
function tcanrandomkillstreak()
{
    if ( istrue( self.ref_11ea7 ) )
    {
        return false;
    }
    
    var0 = khastomoveforkillstreak();
    var1 = var0[ 0 ];
    var2 = var0[ 1 ];
    var0 = undefined;
    
    if ( var1 )
    {
        return false;
    }
    
    if ( isdefined( level.br_circle.circleindex ) && level.ref_11e18.“b2kQ¸JÚOÇcE½_G·“P¨ <= level.br_circle.circleindex )
    {
        self.ref_11ea7 = 1;
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x9c
function kspawnheadchallengetrigger()
{
    var0 = level.ref_11e18.wait_for_next_hack_complete;
    var1 = level.ref_11e18.¢¼µĞ²°ŒØX6V¹ì²N´vì+“9XÈÒºÜ;
    var2 = level.ref_11e18.–;²:>%ih»jÜ7ğ¼êS[À? µ;êÄJƒu;
    var3 = "j_head";
    var4 = var0 gettagorigin( var3 );
    var5 = spawn( "trigger_radius", var4, 0, var1, var2 );
    var5.angles = var0 gettagangles( var3 );
    var5 enablelinkto();
    var5.x1loadout = 1;
    var5 linkto( var0, var3, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0 scripts\mp\utility\trigger::makeenterexittrigger( var5, &k_headchallengetriggerenter, &k_headchallengetriggerexit, undefined, "k_headChallengeTriggerExit", &k_headchallengetriggerfilter );
}

// Params 2
// Size: 0x19, Type: bool
function k_headchallengetriggerfilter( var0, var1 )
{
    if ( isplayer( var0 ) && isalive( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x22
function k_headchallengetriggerenter( var0, var1 )
{
    if ( !istrue( var0.©7ê¿ÅúªŸ- ) )
    {
        var0.©7ê¿ÅúªŸ- = 1;
        thread kstandingonheadwatcher();
        return;
    }
}

// Params 2
// Size: 0x1a
function k_headchallengetriggerexit( var0, var1 )
{
    if ( istrue( var0.©7ê¿ÅúªŸ- ) )
    {
        var0.©7ê¿ÅúªŸ- = 0;
        return;
    }
}

// Params 0
// Size: 0x31
function kstandingonheadwatcher()
{
    self endon( "k_headChallengeTriggerExit" );
    self endon( "disconnect" );
    scripts\engine\utility::waittill_notify_or_timeout( "death", level.ref_11e18.‹¿šCãå'²8
>¹ñ_ê¡g  );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "mv_event_intel_8" );
}

// Params 0
// Size: 0x95
function kspawnchallengetrigger()
{
    var0 = level.ref_11e18.wait_for_next_hack_complete;
    var1 = level.ref_11e18.²¯QğÆôq7?ï1ĞøJƒOU0+‚;
    var2 = level.ref_11e18.ƒsÚĞØØÊÜì¬£9Zì•É4VZ³†è;
    var3 = "tag_origin";
    var4 = var0 gettagorigin( var3 );
    var5 = spawn( "trigger_radius", var4, 0, var1, var2 );
    var5.angles = var0 gettagangles( var3 );
    var5 enablelinkto();
    var5.x1loadout = 1;
    var5 linkto( var0, var3, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var0 scripts\mp\utility\trigger::makeenterexittrigger( var5, &k_challengetriggerenter, undefined, undefined, undefined, &k_challengetriggerfilter );
}

// Params 2
// Size: 0x25
function k_challengetriggerenter( var0, var1 )
{
    var2 = var0 getvehicleowner();
    
    if ( isdefined( var2 ) && isplayer( var2 ) )
    {
        var2 scripts\cp\vehicles\vehicle_compass_cp::ref_12004( "mv_event_intel_9" );
        return;
    }
}

// Params 2
// Size: 0x2e, Type: bool
function k_challengetriggerfilter( var0, var1 )
{
    if ( isdefined( var0.vehiclename ) && var0.vehiclename == "veh_a10fd" && isdefined( var0 getvehicleowner() ) )
    {
        return false;
    }
    
    return true;
}

// Params 5
// Size: 0x1b
function ee_spyequipmentscriptableused( var0, var1, var2, var3, var4 )
{
    if ( var2 == "on" )
    {
        ee_activatespyequipment( var0, var3 );
        return;
    }
}

// Params 1
// Size: 0x2d
function ee_activatespyequipment( var0 )
{
    self setscriptablepartstate( "spy_equipment", "off" );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        ee_playspyequipmentdialog( self.script_noteworthy );
    }
    
    thread ee_spy_equipment_cooldown();
}

// Params 1
// Size: 0x116
function ee_playspyequipmentdialog( var0 )
{
    level endon( "game_ended" );
    
    switch ( var0 )
    {
        case "audio1":
            ee_play_dialog_and_wait( "dx_brm_nvof_titan_convo_shipments_one_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_shipments_two_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_shipments_three_10" );
            break;
        case "audio2":
            ee_play_dialog_and_wait( "dx_brm_nvof_titan_convo_carrier_one_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_carrier_two_10" );
            ee_play_dialog_and_wait( "dx_brm_nvof_titan_convo_carrier_three_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_carrier_four_10" );
            break;
        case "audio3":
            ee_play_dialog_and_wait( "dx_brm_sci1_titan_convo_seismic_one_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_seismic_two_10" );
            ee_play_dialog_and_wait( "dx_brm_sci1_titan_convo_seismic_three_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_seismic_four_10" );
            break;
        case "audio4":
            ee_play_dialog_and_wait( "dx_brm_nvof_titan_convo_lostcontact_one_10" );
            ee_play_dialog_and_wait( "dx_brm_sci1_titan_convo_lostcontact_two_10" );
            ee_play_dialog_and_wait( "dx_brm_nvof_titan_convo_lost_contact_three_10" );
            break;
        case "audio5":
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_noescape_one_10" );
            ee_play_dialog_and_wait( "dx_brm_sci1_titan_convo_noescape_two_10" );
            ee_play_dialog_and_wait( "dx_brm_sci2_titan_convo_noescape_three_10" );
            ee_play_dialog_and_wait( "dx_brm_sci1_titan_convo_noescape_four_10" );
            break;
    }
}

// Params 1
// Size: 0x37
function ee_play_dialog_and_wait( var0 )
{
    var1 = lookupsoundlength( var0 );
    playsoundatpos( self.origin, var0 );
    wait var1 / 1000;
    
    if ( level.ref_11e18.¾YVÊè¥¶V‰•î²Væ‘ÒÂ±·Î6´æÊÍ > 0 )
    {
        wait level.ref_11e18.¾YVÊè¥¶V‰•î²Væ‘ÒÂ±·Î6´æÊÍ;
        return;
    }
}

// Params 0
// Size: 0x24
function ee_spy_equipment_cooldown()
{
    self endon( "death" );
    wait level.ref_11e18.±”Y•}6Û½±ÈÛİæ}‘]9ÑZ½¹;
    self setscriptablepartstate( "spy_equipment", "on" );
}

// Params 2
// Size: 0x9b
function tstunplayersandremovearmor( var0, var1 )
{
    var2 = getentarrayinradius( "player", "classname", var0, var1 );
    
    foreach ( var4 in var2 )
    {
        if ( isalive( var4 ) )
        {
            if ( var4 scripts\mp\gametypes\br_public::hasarmor() )
            {
                var4 dodamage( var4.br_armorhealth, var0, self, self, "MOD_EXPLOSIVE", getcompleteweaponname( "kenosha_strike" ) );
            }
            
            var4 scripts\mp\weapons::setplayerstunned();
            var4 thread scripts\mp\weapons::cleanupconcussionstun( level.ref_11e18.Šàƒ0•_#P¡p8ë“İSµ[¨´¥¨ );
            var4 scripts\cp_mp\utility\shellshock_utility::_shellshock( "concussion_grenade_mp", "stun", level.ref_11e18.Šàƒ0•_#P¡p8ë“İSµ[¨´¥¨, 1 );
        }
    }
}

// Params 1
// Size: 0x13
function ref_13c1d( var0 )
{
    var1 = ref_13c1c( var0 );
    ref_13ed2( var1 );
}

// Params 1
// Size: 0x27, Type: bool
function tplayinterruptableanim( var0 )
{
    var1 = ref_13c1c( var0 );
    var2 = getanimlength( var1 );
    var3 = scripts\engine\utility::waittill_notify_or_timeout_return( "gk_driven_off", var2 );
    return var3 == "timeout";
}

// Params 0
// Size: 0x20
function ref_13c1b()
{
    self asmsetstate( self.asmname, "idle_aim" );
    self asmfireevent( self.asmname, "start_aim" );
}

// Params 1
// Size: 0x36
function ref_13c1c( var0 )
{
    var1 = "scripted_anim";
    var2 = archetypegetrandomalias( self.callback, var1, var0, 0 );
    var3 = self getanimentry( var1, var2 );
    self setanimstate( var1, var2, 1 );
    thread ref_13ba6( var0, var3 );
    return var3;
}

// Params 1
// Size: 0xc
function ref_13ed2( var0 )
{
    var1 = getanimlength( var0 );
    wait var1;
}

// Params 2
// Size: 0x6f
function ref_13ba6( var0, var1 )
{
    if ( !isdefined( level.ref_11e18.notetracks ) || !isdefined( level.ref_11e18.notetracks[ var0 ] ) )
    {
        return;
    }
    
    foreach ( var3 in level.ref_11e18.notetracks[ var0 ] )
    {
        var4 = getnotetracktimes( var1, var3 );
        var5 = getanimlength( var1 );
        thread ref_13ba7( var3, var5, var4 );
    }
}

// Params 3
// Size: 0x5e
function ref_13ba7( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "gk_driven_off" );
    var3 = 0;
    var4 = 0;
    
    foreach ( var6 in var2 )
    {
        var4 = var6 - var3;
        wait var1 * var4;
        self notify( var0 );
        var3 += var4;
    }
}

// Params 0
// Size: 0x56
function ref_13ba1()
{
    self.x1fin_respawn.origin = self.origin;
    self.x1fin_respawn.angles = self.angles;
    self linkto( self.x1fin_respawn, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.x1fin_respawn dontinterpolate();
}

// Params 0
// Size: 0x32
function ref_13e37()
{
    self unlink();
    self.x1fin_respawn.origin = self.origin;
    self.x1fin_respawn.angles = self.angles;
    self.x1fin_respawn dontinterpolate();
}

// Params 1
// Size: 0x6c
function tisreadytotalk( var0 )
{
    if ( isdefined( var0.½¬gXUÃûóà{Ï ) && gettime() < var0.½¬gXUÃûóà{Ï )
    {
        return 0;
    }
    
    if ( !ginnodestate() || !kinnodestate() )
    {
        return 0;
    }
    
    var1 = sandbox_combat_area();
    var2 = vehiclespawn_littlebirdmg();
    var3 = scripts\engine\trace::create_contents( 0, 1 );
    var4 = scripts\engine\trace::ray_trace_passed( var1, var2, [ level.ref_11e18.setincomingremovedcallback, level.ref_11e18.wait_for_next_hack_complete ], var3 );
    return var4;
}

// Params 0
// Size: 0x2e, Type: bool
function score_message()
{
    if ( istrue( level.ref_11e18.ref_12212 ) )
    {
        return true;
    }
    
    if ( getdvarint( "scr_br_mxp_pause", 0 ) )
    {
        if ( sales_discount() )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x2e, Type: bool
function wait_for_morales_thanks()
{
    if ( istrue( level.ref_11e18.ref_12212 ) )
    {
        return true;
    }
    
    if ( getdvarint( "scr_br_mxp_pause", 0 ) )
    {
        if ( vehiclespawn_cargotruckmg() )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x19, Type: bool
function sales_discount()
{
    return getdvarint( "scr_br_mxp_g_advance", 0 ) || getdvarint( "scr_br_mxp_g_keep_walking", 0 );
}

// Params 0
// Size: 0xc
function set_relic_headbullets()
{
    setdvar( "scr_br_mxp_g_advance", 0 );
}

// Params 0
// Size: 0x19, Type: bool
function vehiclespawn_cargotruckmg()
{
    return getdvarint( "scr_br_mxp_k_advance", 0 ) || getdvarint( "scr_br_mxp_k_keep_jumping", 0 );
}

// Params 0
// Size: 0xc
function waitforreturntobattlestance()
{
    setdvar( "scr_br_mxp_k_advance", 0 );
}

// Params 2
// Size: 0x6b
function secretstashlootcacheused( var0, var1 )
{
    if ( !isalive( var0 ) )
    {
        return;
    }
    
    if ( isplayer( var0 ) )
    {
        var0.ref_136dc = gkgetdeathspectatepoint( var1.¸@MCšµ`¤/[éK, var0 );
        var0 method_87e1( 1 );
        var0 kill( var1.origin, var1.¸@MCšµ`¤/[éK, var1 );
        return;
    }
    
    if ( var0 scripts\mp\gametypes\br_public::nuke_vault_suicidebombers() )
    {
        var0 dodamage( var0.health, var1.origin, var1.¸@MCšµ`¤/[éK, var1 );
        return;
    }
}

// Params 2
// Size: 0xe1
function gkgetdeathspectatepoint( var0, var1 )
{
    var2 = undefined;
    var3 = undefined;
    var4 = undefined;
    
    if ( var0.agent_type == "actor_greenbay" )
    {
        var2 = 3000;
        var3 = level.ref_11e18.setincomingremovedcallback.origin;
        var4 = level.mapcenter - var3;
    }
    else
    {
        var2 = 3400;
        var3 = level.ref_11e18.wait_for_next_hack_complete.origin;
        var4 = var1.origin - var3;
    }
    
    var4 = vectornormalize( ( var4[ 0 ], var4[ 1 ], 0 ) );
    var5 = ( var3[ 0 ], var3[ 1 ], var1.origin[ 2 ] );
    var6 = var5 + var4 * ( var2 + 500 );
    var7 = [ var0, var1 ];
    var8 = scripts\engine\trace::create_contents( 0, 1 );
    var9 = scripts\engine\trace::ray_trace( var5, var6, var7, var8 );
    var10 = var4 * -1;
    var11 = var9[ "position" ] + var10 * 50;
    var12 = vectortoangles( var10 );
    var13 = spawnstruct();
    var13.origin = var11;
    var13.angles = var12;
    return var13;
}

// Params 0
// Size: 0xa7
function ref_13dce()
{
    self endon( "destroy" );
    var0 = length2d( ( self.height / 2, self.radius, 0 ) );
    
    for ( ;; )
    {
        if ( self.classname == "trigger_rotatable_radius" )
        {
            var1 = anglestoup( self.angles );
        }
        else
        {
            var1 = ( 0, 0, 1 );
        }
        
        var2 = self.origin + var1 * self.height / 2;
        var3 = tablesort( var2, var0 );
        
        foreach ( var5 in var3 )
        {
            if ( isdefined( var5 ) && var5 istouching( self ) )
            {
                secretstashlootcacheused( var5, self );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x4f4
function kinitializeplayercollision()
{
    var0 = self;
    var0 endon( "death" );
    var0 agentsetclipmode( "large" );
    var1 = 0.1;
    var0.¡jÆ{ÆÒnZ·s6´7Ñ = [];
    var2 = getentarray( "kenosha_collision", "targetname" );
    
    foreach ( var4 in var2 )
    {
        var5 = "?";
        var6 = ( 0, 0, 0 );
        var7 = ( 0, 0, 0 );
        var8 = var4.script_noteworthy;
        
        if ( var8 == "head" )
        {
            var5 = "j_head";
            var6 = ( 520, -200, 0 );
            var7 = ( 180, 82, 90 );
        }
        else if ( var8 == "left_foot" )
        {
            var5 = "j_ankle_le";
            var6 = ( 360, -230, -30 );
            var7 = ( 0, -30, 90 );
        }
        else if ( var8 == "right_foot" )
        {
            var5 = "j_ankle_ri";
            var6 = ( 340, -165, 60 );
            var7 = ( 0, -20, 90 );
        }
        else if ( var8 == "left_shoulder" )
        {
            var5 = "j_shoulder_le";
            var6 = ( -310, 140, -20 );
            var7 = ( 180, 260, 110 );
        }
        else if ( var8 == "right_shoulder" )
        {
            var5 = "j_shoulder_ri";
            var6 = ( 300, -80, 0 );
            var7 = ( 180, 90, 65 );
        }
        else if ( var8 == "torso" )
        {
            var5 = "j_spineupper";
            var6 = ( 0, -200, 0 );
            var7 = ( 180, 110, 90 );
        }
        
        var9 = spawnstruct();
        var9.•T>ÿ#K‡ò8˜ZÛ = var4;
        var9.tagname = var5;
        var9.´_û;êœ%ªŠÒ§™ = var6;
        var9.angleoffset = var7;
        var0.¡jÆ{ÆÒnZ·s6´7Ñ[ var8 ] = var9;
    }
    
    var11 = gkkilltriggercreate( var0, 550, 670, "j_head", 1, ( -300, 0, 0 ), ( 180, 82, 90 ) );
    var12 = gkkilltriggercreate( var0, 500, 1200, "j_spineupper", 1, ( 800, 180, -600 ), ( 0, 0, 0 ) );
    wait var1;
    var13 = gkkilltriggercreate( var0, 400, 1600, "j_shoulder_le", 1, ( -100, 0, 0 ), ( 90, 0, 0 ) );
    var14 = gkkilltriggercreate( var0, 400, 1600, "j_shoulder_ri", 1, ( 100, 0, 0 ), ( -90, 0, 0 ) );
    wait var1;
    var15 = gkkilltriggercreate( var0, 400, 1100, "j_elbow_le", 1, ( -100, 0, 0 ), ( 90, -10, 0 ) );
    var16 = gkkilltriggercreate( var0, 400, 1100, "j_elbow_ri", 1, ( -100, 0, 0 ), ( -90, -10, 0 ) );
    wait var1;
    var17 = gkkilltriggercreate( var0, 350, 1000, "j_hip_le", 1, ( 200, 0, 0 ), ( 90, -15, 0 ) );
    var18 = gkkilltriggercreate( var0, 350, 1000, "j_hip_ri", 1, ( 200, 0, 0 ), ( 90, 0, 0 ) );
    wait var1;
    var19 = gkkilltriggercreate( var0, 320, 1400, "j_knee_le", 1, ( -100, 100, 0 ), ( 90, 0, 0 ) );
    var20 = gkkilltriggercreate( var0, 320, 1400, "j_knee_ri", 1, ( -100, 100, 0 ), ( 90, 0, 0 ) );
    wait var1;
    var21 = gkkilltriggercreate( var0, 450, 120, "j_ankle_le", 1, ( 470, -20, 30 ), ( 0, -32, 86 ) );
    var22 = gkkilltriggercreate( var0, 450, 120, "j_ankle_ri", 1, ( 470, 60, 30 ), ( 0, -23, 90 ) );
    level.ref_11e18.wait_for_next_hack_complete.¬Pê0éS¼p#—nßX›Â™5Sr = [ var11, var12, var13, var14, var15, var16, var13, var14, var19, var20, var21, var22 ];
    
    if ( getdvarint( "scr_br_mxp_kk_back_trigger", 1 ) )
    {
        var23 = gkkilltriggercreate( var0, 800, 2000, "j_spinelower", 1, ( -700, 0, 0 ), ( 90, 0, 0 ) );
        level.ref_11e18.wait_for_next_hack_complete.¬Pê0éS¼p#—nßX›Â™5Sr[ level.ref_11e18.wait_for_next_hack_complete.¬Pê0éS¼p#—nßX›Â™5Sr.size ] = var23;
    }
    
    var0.¦VÆÛcÒ›-Ş¹ÒÍ´£-cÒO²F = 1;
    thread gkrunplayercollision( var0 );
}

// Params 1
// Size: 0x147
function gkrunplayercollision( var0 )
{
    var1 = self;
    var1 endon( "death" );
    var1 notify( "gkRunPlayerCollision" );
    var1 endon( "gkRunPlayerCollision" );
    
    while ( !istrue( var1.¦VÆÛcÒ›-Ş¹ÒÍ´£-cÒO²F ) )
    {
        waitframe();
    }
    
    jumpiffalse(var0 == 1) LOC_00000088;
    
    foreach ( var3 in var1.¡jÆ{ÆÒnZ·s6´7Ñ )
    {
        var3.•T>ÿ#K‡ò8˜ZÛ unlink();
        var3.•T>ÿ#K‡ò8˜ZÛ linkto( var1, var3.tagname, var3.´_û;êœ%ªŠÒ§™, var3.angleoffset );
    }
    
    return;
}

// Params 1
// Size: 0x43
function gkcalculatecolliderpositioning( var0 )
{
    var1 = self;
    var2 = var1 gettagorigin( var0.tagname );
    var3 = var1 gettagangles( var0.tagname );
    var4 = var2 + rotatevector( var0.´_û;êœ%ªŠÒ§™, var3 );
    var5 = combineangles( var3, var0.angleoffset );
    return [ var4, var5 ];
}

// Params 0
// Size: 0xe8
function binocularsseegk()
{
    var0 = [ "physicscontents_actor", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicleclip" ];
    var1 = physics_createcontents( var0 );
    var2 = self getvieworigin();
    var3 = var2 + anglestoforward( self getplayerangles() ) * 50000;
    var4 = ignore_ents_when_targetting();
    var5 = scripts\engine\trace::ray_trace( var2, var3, var4, var1 );
    
    if ( getdvarint( "scr_br_mxp_precision_target_disable", 0 ) )
    {
        return scripts\engine\utility::ter_op( var5[ "hittype" ] == "hittype_none", undefined, var5[ "position" ] );
    }
    
    if ( var5[ "hittype" ] == "hittype_none" )
    {
        return undefined;
    }
    
    var6 = var5[ "position" ];
    
    if ( var5[ "hittype" ] == "hittype_entity" )
    {
        var7 = var5[ "entity" ];
        
        if ( isdefined( var7 ) && isdefined( var7.agent_type ) )
        {
            if ( var7.agent_type == "actor_greenbay" || var7.agent_type == "actor_kenosha" )
            {
                var6 = var7.origin;
            }
        }
    }
    
    return var6;
}

// Params 0
// Size: 0x4a
function ignore_ents_when_targetting()
{
    var0 = undefined;
    
    if ( isdefined( self.vehicle ) )
    {
        var0 = [ self.vehicle ];
    }
    else
    {
        var1 = self getgroundentity();
        
        if ( isdefined( var1 ) && isdefined( var1.classname ) && var1.classname == "script_vehicle" )
        {
            var0 = [ var1 ];
        }
    }
    
    return var0;
}

// Params 3
// Size: 0x5c, Type: bool
function shouldignorevehicleaabbcollision( var0, var1, var2 )
{
    return var2 == "MOD_CRUSH" && isdefined( var1 ) && isdefined( var0 ) && var1 == var0 && isdefined( var1.vehiclename ) && ( var1.vehiclename == "veh_a10fd" || var1.vehiclename == "veh_bt" || issubstr( var1.vehiclename, "little_bird" ) );
}

// Params 0
// Size: 0x2
function activate_destructible_cinderblocks()
{
    
}

