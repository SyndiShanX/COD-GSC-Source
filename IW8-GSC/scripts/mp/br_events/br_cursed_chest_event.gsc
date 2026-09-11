
// Params 0
// Size: 0x66
function init()
{
    test_bag_pickup();
    initvfx();
    initloottables();
    thread tracegroundheightexfil();
    scripts\engine\scriptable::scriptable_addusedcallback( &scriptable_used );
    _testing_ending::teamplunderexfiltimer();
    access_card::initzombievariables();
    _keypadscriptableused_bunkeralt::init();
    _ispointinbadarea::init();
    _keypadscriptableused::init();
    _initignoredtabspergamemode::init();
    scripts\mp\utility\sound::besttime( "br_event_cursed_chest" );
    thread spawncursedchestinmap();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "zombie", "hitByGasZombie", &onhitbypoisonzombie );
}

// Params 5
// Size: 0x43
function scriptable_used( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) || !isdefined( var0.type ) || var0.type != "br_loot_cursed_chest" )
    {
        return;
    }
    
    var0 setscriptablepartstate( "body", "phase_0" );
    var0 notify( "player_interacted", var3 );
}

// Params 0
// Size: 0x103
function initvfx()
{
    if ( isdefined( level.…¯î› CzŸ—³ÃF³·h y°ø# ) )
    {
        return;
    }
    
    level._effect[ "cursed_chest_ring" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_fire_ring_rnr_01" );
    level._effect[ "cursed_chest_charged_state_1" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_25" );
    level._effect[ "cursed_chest_charged_state_2" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_50" );
    level._effect[ "cursed_chest_charged_state_3" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_75" );
    level._effect[ "cursed_chest_explosion" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_explosion" );
    level._effect[ "cursed_chest_zombie_death" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_death" );
    level._effect[ "cursed_chest_zombie_soul_absorb" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_suction_chd_01" );
    level._effect[ "cursed_chest_zombie_soul_absorb_stop" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_chest_reaction" );
    level._effect[ "cursed_chest_super_zombie_flare" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_upgrade_flare" );
    level._effect[ "cursed_chest_super_zombie_pre_flare" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_pre_upgrade_flare" );
    level._effect[ "cursed_chest_super_zombie_helmet_distortion" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_helmet_armor" );
    level._effect[ "cursed_chest_super_zombie_helmet_break" ] = loadfx( "vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_helmet_armor_break" );
    level.…¯î› CzŸ—³ÃF³·h y°ø# = 1;
}

// Params 0
// Size: 0x97
function tracegroundheightexfil()
{
    waitframe();
    
    if ( !isdefined( game[ "dialogForAllTeams" ] ) )
    {
        game[ "dialogForAllTeams" ] = [];
    }
    
    register_cursed_chest_dialogue( "cursedchest_charge_100", "dx_bra_bchr_cursed_chest_charge_100" );
    register_cursed_chest_dialogue( "cursedchest_charge_75", "dx_bra_bchr_cursed_chest_charge_75" );
    register_cursed_chest_dialogue( "cursedchest_charge_50", "dx_bra_bchr_cursed_chest_charge_50" );
    register_cursed_chest_dialogue( "cursedchest_charge_25", "dx_bra_bchr_cursed_chest_charge_25" );
    register_cursed_chest_dialogue( "cursedchest_enemy_join", "dx_bra_bchr_cursed_enemy_join" );
    register_cursed_chest_dialogue( "cursedchest_event_complete", "dx_bra_bchr_cursed_event_complete" );
    register_cursed_chest_dialogue( "cursedchest_event_failed", "dx_bra_bchr_cursed_event_failed" );
    register_cursed_chest_dialogue( "cursedchest_event_start", "dx_bra_bchr_cursed_event_start" );
}

// Params 2
// Size: 0x1c
function register_cursed_chest_dialogue( var0, var1 )
{
    game[ "dialog" ][ var0 ] = var1;
    game[ "dialogForAllTeams" ][ var0 ] = 1;
}

// Params 0
// Size: 0x341
function initloottables()
{
    _handlevehiclerepair::init();
    var0 = [];
    GscBinSkip0( 0x2e, "brloot_plunder_cash_uncommon_1", 3 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x470
function test_bag_pickup()
{
    if ( isdefined( level.¯Sl«'nÊÈ}†V7:õŒÙœ×Kæ-Ñ ) )
    {
        return;
    }
    
    if ( !isdefined( level.©FW‹ÓFgxY1ËÅYq€'°› ) )
    {
        level.©FW‹ÓFgxY1ËÅYq€'°› = spawnstruct();
        level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ = [];
        level.©FW‹ÓFgxY1ËÅYq€'°›.instances = [];
    }
    
    level.©FW‹ÓFgxY1ËÅYq€'°›.¾wbQèâŞ»£ß¹óÊ^Ù[^ïÈx³ = getdvarint( "scr_cursed_chest_participation_radius", 1700 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.›º»k7ÏÍóqÊ;¦/«ˆ = getdvarint( "scr_cursed_chest_event_timeout_duration", 240 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ref_129e0 = getdvarint( "scr_cursed_chest_harvest_radius", 2000 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.›`š+È´'N‚Z8¬‹+ = getdvarint( "scr_cursed_chest_harvest_radius_height", 400 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.™¹6½'•¯Ñ{}í­Á•£• = getdvarint( "scr_cursed_chest_event_points_to_complete", 25 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ƒ­ÂÃú´›7GÜ±Yæõ:½ëæ…İæ = getdvarint( "scr_cursed_chest_max_instances_to_spawn", 2 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.›	ÁC…Ü+¯`×Íè…äGúXÑ}¹ÆÛœ¬ = getdvarint( "scr_cursed_chest_phase_1_start_at_score", 0 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.¸zyª¡ŞŠyWë›çK)/o{ùƒî7bŠ = getdvarint( "scr_cursed_chest_phase_2_start_at_score", 10 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.¬NÛĞo/¿•§sá‚û˜i‘6'2è = getdvarint( "scr_cursed_chest_phase_3_start_at_score", 15 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.¥WC°Í+¾Ì¯ÍÑ,'ú,}ÜÆÛ9+ = getdvarint( "scr_cursed_chest_phase_4_start_at_score", 20 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ª.ki˜5áÛñëÿj = getdvarint( "scr_cursed_chest_start_phase", 0 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.«¹Òçˆw_§{?Àû‰šÆÉ¹3eƒá<*“nø*  = getdvarint( "scr_cursed_chest_event_zombie_count_max_per_instance", 10 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡ = getdvarint( "scr_cursed_chest_event_zombie_spawn_radius_max", 600 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.½İ{M³š_íIë.ÓE¹f©@«£ç]¨e = getdvarint( "scr_cursed_chest_event_zombie_spawn_radius_min", 300 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.†°p»ò;»‡z°¹z‡‡šbàÒA[G„Í = getdvarint( "scr_cursed_chest_event_super_zombie_score_yield", 3 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.š›KZ—µ9òGãÖª¸ˆÙÓùiÛ€e  = getdvarint( "scr_cursed_chest_event_super_zombie_health_value", 1000 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ŠgÜ]ƒV'¾=ÛÖL´Ê}…œ­½Éë³°]V = getdvarint( "scr_cursed_chest_event_super_zombie_armor_value", 700 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ4²(‚š)	•³#g" = [ "walker", "runner", "sprinter", "gas_thrower", "weakpoint" ];
    level.©FW‹ÓFgxY1ËÅYq€'°›.–;!:Jş£©‘;À7S ‹R081“5*EÉã{³«ĞÙb = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.–;!:Jş£©‘;À7S ‹R081“5*EÉã{³«ĞÙb[ "walker" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_walker_phase_0", 1 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡;!¸ÈHBŠ¥¯Ûç]Ó‡P³öC@Bû¯‡óºãX¾z = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡;!¸ÈHBŠ¥¯Ûç]Ó‡P³öC@Bû¯‡óºãX¾z[ "walker" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_walker_phase_1", 0.4 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡;!¸ÈHBŠ¥¯Ûç]Ó‡P³öC@Bû¯‡óºãX¾z[ "runner" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_runner_phase_1", 0.6 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.;!BGR‚³c¿¹€ı a«û¶e8qCÚ@z›Š[V² = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.;!BGR‚³c¿¹€ı a«û¶e8qCÚ@z›Š[V²[ "walker" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_walker_phase_2", 0.2 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.;!BGR‚³c¿¹€ı a«û¶e8qCÚ@z›Š[V²[ "runner" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_runner_phase_2", 0.8 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.;!BGR‚³c¿¹€ı a«û¶e8qCÚ@z›Š[V²[ "gas_thrower" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_gas_thrower_phase_2", 0.9 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ;!R¸(iĞSß1Éj»	ˆCÉŸ)*ï[«_¾Ø|‘7ÀQÃ = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ;!R¸(iĞSß1Éj»	ˆCÉŸ)*ï[«_¾Ø|‘7ÀQÃ[ "walker" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_walker_phase_3", 0.2 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ;!R¸(iĞSß1Éj»	ˆCÉŸ)*ï[«_¾Ø|‘7ÀQÃ[ "runner" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_runner_phase_3", 0.5 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ;!R¸(iĞSß1Éj»	ˆCÉŸ)*ï[«_¾Ø|‘7ÀQÃ[ "gas_thrower" ] = getdvarfloat( "scr_cursed_chest_event_spawn_ratio_gas_thrower_phase_3", 0.9 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹ = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹[ 0 ] = level.©FW‹ÓFgxY1ËÅYq€'°›.–;!:Jş£©‘;À7S ‹R081“5*EÉã{³«ĞÙb;
    level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹[ 1 ] = level.©FW‹ÓFgxY1ËÅYq€'°›.‡;!¸ÈHBŠ¥¯Ûç]Ó‡P³öC@Bû¯‡óºãX¾z;
    level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹[ 2 ] = level.©FW‹ÓFgxY1ËÅYq€'°›.;!BGR‚³c¿¹€ı a«û¶e8qCÚ@z›Š[V²;
    level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹[ 3 ] = level.©FW‹ÓFgxY1ËÅYq€'°›.ˆ;!R¸(iĞSß1Éj»	ˆCÉŸ)*ï[«_¾Ø|‘7ÀQÃ;
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡¨${ãˆWÛ¸RÒúy‹ßø‘áç}I{_È*b¦T?A9yßp = [];
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡¨${ãˆWÛ¸RÒúy‹ßø‘áç}I{_È*b¦T?A9yßp[ 0 ] = getdvarfloat( "scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.05 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡¨${ãˆWÛ¸RÒúy‹ßø‘áç}I{_È*b¦T?A9yßp[ 1 ] = getdvarfloat( "scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.15 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡¨${ãˆWÛ¸RÒúy‹ßø‘áç}I{_È*b¦T?A9yßp[ 2 ] = getdvarfloat( "scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.2 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.‡¨${ãˆWÛ¸RÒúy‹ßø‘áç}I{_È*b¦T?A9yßp[ 3 ] = getdvarfloat( "scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.25 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.©y2Œ·{ƒâ?ùci:Ó Y¦ï±+¯ = getdvarint( "scr_cursed_chest_event_debug_show_spawn_nodes", 0 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.¸µ#ÊÄ®ì¾›·î}¬ìV7ë–Í™{ = getdvarint( "scr_cursed_chest_event_debug_show_event_info", 0 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.¡ñ+‰WõŒZ¹°‰cV¯g™‡ = getdvarint( "scr_cursed_chest_event_debug_disable_vfx", 0 );
    level.©FW‹ÓFgxY1ËÅYq€'°›.–t(¨Éıú/.‚şe1±S»xÆ2§ËJ³uª|Ş0Ï¸[‘êŞ = getdvarint( "scr_cursed_chest_event_debug_spawn_at_all_registered_locations", 0 );
    level.¯Sl«'nÊÈ}†V7:õŒÙœ×Kæ-Ñ = 1;
}

// Params 1
// Size: 0x3b
function playvoineventarea( var0 )
{
    foreach ( var2 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
    {
        if ( scripts\mp\utility\player::isreallyalive( var2 ) )
        {
            level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( var0, var2 );
        }
    }
}

// Params 3
// Size: 0x9a
function spawncursedchest( var0, var1, var2 )
{
    var3 = spawnstruct();
    
    if ( istrue( var2 ) )
    {
        var3.origin = var0;
    }
    else
    {
        var3.origin = getgroundposition( var0, 10, 300, 100 );
    }
    
    var3.angles = var1;
    var3.chest = easepower( "br_loot_cursed_chest", var3.origin, var3.angles + ( 0, 90, 0 ) );
    var3.chest.computer_force_player_to_exit = 1;
    level.©FW‹ÓFgxY1ËÅYq€'°›.instances = scripts\engine\utility::array_add( level.©FW‹ÓFgxY1ËÅYq€'°›.instances, var3 );
    thread event_waitforplayerinteraction();
}

// Params 0
// Size: 0x236
function spawncursedchestinmap()
{
    level endon( "game_ended" );
    
    if ( !scripts\mp\flags::playerzombiethermalcleanup( "prematch_fade_done" ) )
    {
        scripts\mp\flags::gameflaginit( "prematch_fade_done", 0 );
    }
    
    while ( !scripts\mp\flags::gameflag( "prematch_fade_done" ) )
    {
        waitframe();
    }
    
    wait 2;
    
    switch ( level.mapname )
    {
        case "mp_sm_island_1":
            registereventlocation( ( 9266, -352.5, 399 ), ( 0, 60, 0 ) );
            registereventlocation( ( -6639.5, 503.5, 871 ), ( 0, 90, 0 ) );
            var0 = 1;
            registereventlocation( ( 3114, 6777, 1180 ), ( 0, 60, 0 ), var0 );
            registereventlocation( ( -1278, 3704, 1365 ), ( 0, 195, 0 ), var0 );
            registereventlocation( ( -1427, -1055, 186 ), ( 0, 105, 0 ), undefined, 1 );
            break;
    }
    
    if ( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡.size <= 0 )
    {
        return;
    }
    
    var1 = 0;
    
    if ( level.©FW‹ÓFgxY1ËÅYq€'°›.–t(¨Éıú/.‚şe1±S»xÆ2§ËJ³uª|Ş0Ï¸[‘êŞ )
    {
        var1 = level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡.size;
    }
    else
    {
        var1 = level.©FW‹ÓFgxY1ËÅYq€'°›.ƒ­ÂÃú´›7GÜ±Yæõ:½ëæ…İæ;
    }
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        if ( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡.size <= 0 )
        {
            continue;
        }
        
        var3 = scripts\engine\utility::random( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ );
        spawncursedchest( var3.origin, var3.angles, var3.šî€oËCO_`ÒÚ0p•#ãp );
        level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ = scripts\engine\utility::array_remove( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡, var3 );
        
        if ( !level.©FW‹ÓFgxY1ËÅYq€'°›.–t(¨Éıú/.‚şe1±S»xÆ2§ËJ³uª|Ş0Ï¸[‘êŞ && isdefined( var3.spawn_group ) )
        {
            foreach ( var5 in level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ )
            {
                if ( !isdefined( var5.spawn_group ) )
                {
                    continue;
                }
                
                if ( var5.spawn_group == var3.spawn_group )
                {
                    level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ = scripts\engine\utility::array_remove( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡, var5 );
                }
            }
        }
    }
}

// Params 4
// Size: 0x52
function registereventlocation( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.origin = var0;
    var4.angles = var1;
    var4.šî€oËCO_`ÒÚ0p•#ãp = var3;
    
    if ( isdefined( var2 ) )
    {
        var4.spawn_group = var2;
    }
    
    level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡ = scripts\engine\utility::array_add( level.©FW‹ÓFgxY1ËÅYq€'°›.­K_o@¶SÅã£ÉşĞ³°f…ßØg«§Çí‡, var4 );
}

// Params 0
// Size: 0x4e
function event_waitforplayerinteraction()
{
    level endon( "game_ended" );
    self endon( "end_event" );
    self.event_active = 0;
    thread event_timeoutwatcher();
    self.chest waittill( "player_interacted", var0 );
    
    if ( istrue( self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 ) )
    {
        return;
    }
    
    self.¥cçY
º÷?ƒ¥ÙvÃË!à©¨e) = var0;
    self.¢µ¬µ×wC½ú°Æ£´ÙX£Ê2 = var0.team;
    thread event_startcursedchest();
}

// Params 0
// Size: 0x1db
function event_startcursedchest()
{
    self.participants = [];
    self.“í/°#ÙÓsÚ–î	z›(§‹à; = [];
    self.event_active = 1;
    self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 = 0;
    self.•Nâ{î‡¯‹ÇpŠ· = 0;
    self.‡pŸ{fHssœñ› = level.©FW‹ÓFgxY1ËÅYq€'°›.ª.ki˜5áÛñëÿj;
    self.çP0âSñ![n‹}á³J`/3RçåiĞ = [ level.©FW‹ÓFgxY1ËÅYq€'°›.›	ÁC…Ü+¯`×Íè…äGúXÑ}¹ÆÛœ¬, level.©FW‹ÓFgxY1ËÅYq€'°›.¸zyª¡ŞŠyWë›çK)/o{ùƒî7bŠ, level.©FW‹ÓFgxY1ËÅYq€'°›.¬NÛĞo/¿•§sá‚û˜i‘6'2è, level.©FW‹ÓFgxY1ËÅYq€'°›.¥WC°Í+¾Ì¯ÍÑ,'ú,}ÜÆÛ9+ ];
    self.‡(ëñ—³E8SCŞğøšª}7kG = 0;
    self.†µËİ©Ë}’/Sê>(E¶„ = 0;
    self.rBĞP!}'–·á—;w(¹¾J¨ = 0;
    self.•6CP)+‰ƒâr6˜»QÉ¶‘“Š = 0;
    self.§¤êœœ¬Í£ØËc,/K¹³ì{ = 0;
    event_changephase( self.‡pŸ{fHssœñ› );
    self.™¹6½'•¯Ñ{}í­Á•£• = level.©FW‹ÓFgxY1ËÅYq€'°›.™¹6½'•¯Ñ{}í­Á•£•;
    self.ref_13b97 = gettime();
    self.ref_13b96 = gettime() + level.©FW‹ÓFgxY1ËÅYq€'°›.›º»k7ÏÍóqÊ;¦/«ˆ * 1000;
    self.ref_129e0 = level.©FW‹ÓFgxY1ËÅYq€'°›.ref_129e0;
    self.›`š+È´'N‚Z8¬‹+ = level.©FW‹ÓFgxY1ËÅYq€'°›.›`š+È´'N‚Z8¬‹+;
    self.†ƒh33“'ÔÇ gç`ªK± = level.©FW‹ÓFgxY1ËÅYq€'°›.†ƒh33“'ÔÇ gç`ªK±;
    self.“Wxatı[¼ßsÀÕ‹—u = [];
    self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡ = level.©FW‹ÓFgxY1ËÅYq€'°›.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡;
    self.½İ{M³š_íIë.ÓE¹f©@«£ç]¨e = level.©FW‹ÓFgxY1ËÅYq€'°›.½İ{M³š_íIë.ÓE¹f©@«£ç]¨e;
    self.¾k8ù`C_£Ğ0 ı™«“º¸m‘o‡õ‡²ÜÏ«ñ = [];
    
    foreach ( var2, var1 in level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹ )
    {
        self.¾k8ù`C_£Ğ0 ı™«“º¸m‘o‡õ‡²ÜÏ«ñ[ var2 ] = event_calculatezombiespawnchances( "zombie_spawns_phase_" + var2, level.©FW‹ÓFgxY1ËÅYq€'°›.éí­&–Y}:^ƒYõÜÁ,»7¾“°Ñ–öúà¡›Ê¹[ var2 ] );
    }
    
    self.§Æúc|sÇhWÙEÇ = [];
    self.¢÷Ù‡C^ÑèÅ¡˜§Ûm	W?I=: = [];
    spawnnode_spawnallnodes();
    thread createeventtrigger();
    self.†¡Ê-"5À/Xøs¤˜uêRGßƒª = 0;
    
    for ( var3 = 0; var3 < 10 ; var3++ )
    {
        thread event_spawnzombiefromspawntable( self.¾k8ù`C_£Ğ0 ı™«“º¸m‘o‡õ‡²ÜÏ«ñ[ self.‡pŸ{fHssœñ› ] );
    }
    
    thread event_zombiereinforcementwatcher();
    thread event_registernearbyplayers();
    playvoineventarea( "cursedchest_event_start" );
    thread vo_bark_lockout( lookupsoundlength( "cursedchest_event_start", 1 ) / 1000 );
    thread event_showsplashafterregistration();
    scripts\common\vehicle_code::vehicle_start_ai_avoidance();
}

// Params 0
// Size: 0x4c
function event_showsplashafterregistration()
{
    level endon( "game_ended" );
    self waittill( "players_registered" );
    
    foreach ( var1 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        var1 thread scripts\mp\hud_message::showsplash( "cursed_chest_begin" );
    }
}

// Params 0
// Size: 0x6e
function event_registernearbyplayers()
{
    level endon( "game_ended" );
    waitframe();
    
    foreach ( var1 in level.players )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        var2 = distance2dsquared( self.origin, var1.origin ) < squared( level.©FW‹ÓFgxY1ËÅYq€'°›.¾wbQèâŞ»£ß¹óÊ^Ù[^ïÈx³ );
        
        if ( var2 )
        {
            event_registeractiveparticipant( var1 );
        }
    }
    
    self notify( "players_registered" );
}

// Params 1
// Size: 0x1a1
function event_addtoscorecount( var0 )
{
    if ( self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 )
    {
        return;
    }
    
    if ( self.•Nâ{î‡¯‹ÇpŠ· >= level.©FW‹ÓFgxY1ËÅYq€'°›.™¹6½'•¯Ñ{}í­Á•£• )
    {
        return;
    }
    
    self.•Nâ{î‡¯‹ÇpŠ· += var0;
    
    if ( !self.§¤êœœ¬Í£ØËc,/K¹³ì{ )
    {
        var1 = self.•Nâ{î‡¯‹ÇpŠ· / level.©FW‹ÓFgxY1ËÅYq€'°›.™¹6½'•¯Ñ{}í­Á•£•;
        
        if ( var1 >= 0.75 && !self.rBĞP!}'–·á—;w(¹¾J¨ )
        {
            playvoineventarea( "cursedchest_charge_75" );
            thread vo_bark_lockout( lookupsoundlength( "cursedchest_charge_75", 1 ) / 1000 );
            self.rBĞP!}'–·á—;w(¹¾J¨ = 1;
            self.†µËİ©Ë}’/Sê>(E¶„ = 1;
            self.‡(ëñ—³E8SCŞğøšª}7kG = 1;
        }
        else if ( var1 >= 0.5 && !self.†µËİ©Ë}’/Sê>(E¶„ )
        {
            playvoineventarea( "cursedchest_charge_50" );
            thread vo_bark_lockout( lookupsoundlength( "cursedchest_charge_50", 1 ) / 1000 );
            self.†µËİ©Ë}’/Sê>(E¶„ = 1;
            self.‡(ëñ—³E8SCŞğøšª}7kG = 1;
        }
        else if ( var1 >= 0.25 && !self.‡(ëñ—³E8SCŞğøšª}7kG )
        {
            playvoineventarea( "cursedchest_charge_25" );
            thread vo_bark_lockout( lookupsoundlength( "cursedchest_charge_25", 1 ) / 1000 );
            self.‡(ëñ—³E8SCŞğøšª}7kG = 1;
        }
    }
    
    var2 = self.çP0âSñ![n‹}á³J`/3RçåiĞ[ int( clamp( self.‡pŸ{fHssœñ› + 1, 0, self.çP0âSñ![n‹}á³J`/3RçåiĞ.size - 1 ) ) ];
    var3 = self.çP0âSñ![n‹}á³J`/3RçåiĞ.size - 1;
    ui_updateallparticipantshud();
    
    if ( !self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 && self.•Nâ{î‡¯‹ÇpŠ· >= self.™¹6½'•¯Ñ{}í­Á•£• )
    {
        thread vo_play_completed_sounds();
        thread event_completeevent( "complete", 4 );
        return;
    }
    
    if ( self.•Nâ{î‡¯‹ÇpŠ· >= var2 && self.‡pŸ{fHssœñ› < var3 )
    {
        event_changephase( self.‡pŸ{fHssœñ› + 1 );
        thread event_setsuperstatustozombies( self.‡pŸ{fHssœñ› );
        return;
    }
}

// Params 0
// Size: 0x2e
function vo_play_completed_sounds()
{
    level endon( "game_ended" );
    playvoineventarea( "cursedchest_charge_100" );
    wait lookupsoundlength( "cursedchest_charge_100", 1 ) / 1000;
    playvoineventarea( "cursedchest_event_complete" );
}

// Params 1
// Size: 0x21
function vo_bark_lockout( var0 )
{
    self endon( "end_event" );
    level endon( "game_ended" );
    self.§¤êœœ¬Í£ØËc,/K¹³ì{ = 1;
    wait var0;
    self.§¤êœœ¬Í£ØËc,/K¹³ì{ = 0;
}

// Params 1
// Size: 0x46
function event_changephase( var0 )
{
    self.‡pŸ{fHssœñ› = var0;
    var1 = "phase_" + int( var0 * 25 );
    self.chest setscriptablepartstate( "body", var1 );
    var2 = self.çP0âSñ![n‹}á³J`/3RçåiĞ[ self.‡pŸ{fHssœñ› ];
    
    if ( self.•Nâ{î‡¯‹ÇpŠ· != var2 )
    {
        self.•Nâ{î‡¯‹ÇpŠ· = var2;
        return;
    }
}

// Params 2
// Size: 0x16e
function event_completeevent( var0, var1 )
{
    level endon( "game_ended" );
    self notify( "end_event" );
    self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 = 1;
    
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    if ( !self.event_active )
    {
        self.chest freescriptable();
        return;
    }
    
    if ( var0 == "ended_by_gas" )
    {
        self.chest freescriptable();
    }
    
    thread event_killallzombies();
    self.trigger.mapcircle delete();
    
    switch ( var0 )
    {
        case "complete":
            foreach ( var3 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
            {
                if ( !isdefined( var3 ) )
                {
                    continue;
                }
                
                scripts\mp\gametypes\br_quest_util::displayplayersplash( var3, "cursed_chest_success" );
            }
            
            break;
        case "failed":
            foreach ( var3 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
            {
                if ( !isdefined( var3 ) )
                {
                    continue;
                }
                
                scripts\mp\gametypes\br_quest_util::displayplayersplash( var3, "cursed_chest_fail" );
            }
            
            break;
    }
    
    ui_deleteallparticipantshud();
    scripts\common\vehicle_code::vehicle_stop_ai_avoidance();
    var7 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 0.1 );
    wait var7;
    
    switch ( var0 )
    {
        case "complete":
            thread event_spawnrewards();
            break;
        case "failed":
            thread event_resetevent();
            break;
    }
    
    if ( isdefined( self.…£“<áá{(ã¯®#«Mß ) )
    {
        self.…£“<áá{(ã¯®#«Mß delete();
    }
    
    level.©FW‹ÓFgxY1ËÅYq€'°›.instances = scripts\engine\utility::array_remove( level.©FW‹ÓFgxY1ËÅYq€'°›.instances, self );
}

// Params 0
// Size: 0x44
function event_resetevent()
{
    wait 30;
    
    if ( isdefined( self.chest ) )
    {
        self.chest freescriptable();
    }
    
    level.©FW‹ÓFgxY1ËÅYq€'°›.instances = scripts\engine\utility::array_remove( level.©FW‹ÓFgxY1ËÅYq€'°›.instances, self );
    spawncursedchest( self.origin, self.angles );
}

// Params 0
// Size: 0x75
function event_timeoutwatcher()
{
    level endon( "game_ended" );
    self endon( "end_event" );
    
    for ( ;; )
    {
        if ( self.event_active && gettime() > self.ref_13b96 )
        {
            thread event_completeevent( "failed" );
            playvoineventarea( "cursedchest_event_failed" );
            break;
        }
        
        if ( getdvarint( "scr_br_circle_disable" ) == 0 )
        {
            var0 = !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( self.origin );
            
            if ( var0 )
            {
                thread event_startgasendtimer();
                break;
            }
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x1e
function event_startgasendtimer()
{
    level endon( "game_ended" );
    self endon( "end_event" );
    wait 30;
    thread event_completeevent( "ended_by_gas" );
}

// Params 0
// Size: 0x3f
function event_killallzombies()
{
    level endon( "game_ended" );
    
    foreach ( var1 in self.“Wxatı[¼ßsÀÕ‹—u )
    {
        var1.–ªF²°£¡¯&åú®9æ+Fë4•æÑ = 1;
        thread event_killzombieondelay();
    }
}

// Params 0
// Size: 0x32
function event_killzombieondelay()
{
    level endon( "game_ended" );
    self endon( "death" );
    wait randomfloatrange( 0, 1 );
    self dodamage( self.health, self.origin, self, undefined, "MOD_TRIGGER_HURT", undefined );
}

// Params 0
// Size: 0xbe
function event_spawnrewards()
{
    level endon( "game_ended" );
    self.chest setscriptablepartstate( "body", "opening" );
    wait 0.7;
    self.chest setscriptablepartstate( "body", "phase_100" );
    level thread _handlevehiclerepair::ref_13673( "cursed_chest_event_cash", self.origin + ( 0, 0, 35 ), 10, 1 );
    level thread _handlevehiclerepair::ref_13673( "cursed_chest_event_killstreaks", self.origin + ( 0, 0, 35 ), 3, 0 );
    level thread _handlevehiclerepair::ref_13673( "cursed_chest_event_perk_tokens", self.origin + ( 0, 0, 35 ), 5, 0 );
    level thread _handlevehiclerepair::ref_13673( "cursed_chest_event_equipment", self.origin + ( 0, 0, 35 ), 1, 0 );
}

// Params 0
// Size: 0x6f
function createeventtrigger()
{
    self.trigger = spawn( "trigger_radius", self.origin, 0, self.ref_129e0, self.›`š+È´'N‚Z8¬‹+ );
    scripts\mp\utility\trigger::makeenterexittrigger( self.trigger, &eventtrigger_onenter, &eventtrigger_onexit, undefined, undefined, &eventtrigger_filterfunc );
    self.trigger.«Àu#XĞâ;›¯“îh = self;
    self.trigger scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 6, 0, 0, self.origin );
    self.trigger scripts\mp\gametypes\br_quest_util::ref_1316f( level.©FW‹ÓFgxY1ËÅYq€'°›.ref_129e0 );
}

// Params 2
// Size: 0x18
function eventtrigger_onenter( var0, var1 )
{
    var2 = var0;
    event_registeractiveparticipant( var1.«Àu#XĞâ;›¯“îh, var2, 1 );
}

// Params 2
// Size: 0x8
function eventtrigger_onexit( var0, var1 )
{
    var2 = var0;
}

// Params 2
// Size: 0x19, Type: bool
function eventtrigger_filterfunc( var0, var1 )
{
    if ( isplayer( var0 ) || isbot( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0xc7
function event_registeractiveparticipant( var0, var1 )
{
    if ( !scripts\engine\utility::array_contains( self.participants, var0 ) )
    {
        self.participants = scripts\engine\utility::array_add( self.participants, var0 );
        
        if ( isdefined( var1 ) && var1 && !self.§¤êœœ¬Í£ØËc,/K¹³ì{ && !self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 )
        {
            foreach ( var3 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
            {
                if ( scripts\mp\utility\player::isreallyalive( var3 ) && var0.team != var3.team )
                {
                    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "cursedchest_enemy_join", var3 );
                }
            }
            
            thread vo_bark_lockout( lookupsoundlength( "cursedchest_enemy_join", 1 ) / 1000 );
        }
    }
    
    if ( !scripts\engine\utility::array_contains( self.“í/°#ÙÓsÚ–î	z›(§‹à;, var0 ) )
    {
        self.“í/°#ÙÓsÚ–î	z›(§‹à; = scripts\engine\utility::array_add( self.“í/°#ÙÓsÚ–î	z›(§‹à;, var0 );
        thread event_participantwatcher( var0 );
        return;
    }
}

// Params 1
// Size: 0x4b
function event_deregisteractiveparticipant( var0 )
{
    if ( scripts\engine\utility::array_contains( self.“í/°#ÙÓsÚ–î	z›(§‹à;, var0 ) )
    {
        self.“í/°#ÙÓsÚ–î	z›(§‹à; = scripts\engine\utility::array_remove( self.“í/°#ÙÓsÚ–î	z›(§‹à;, var0 );
        
        if ( isdefined( var0 ) )
        {
            if ( isdefined( self.trigger.mapcircle ) )
            {
                self.trigger scripts\mp\gametypes\br_quest_util::spawn_dogtags( var0 );
            }
            
            ui_hideeventhud( var0 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0xce
function event_participantwatcher( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 )
    {
        return;
    }
    
    level endon( "game_ended" );
    var0 notify( "cursed_chest_end_participant_watcher" );
    var0 endon( "cursed_chest_end_participant_watcher" );
    var1 = gettime();
    var2 = undefined;
    self.trigger scripts\mp\gametypes\br_quest_util::ref_1336a( var0 );
    var0.©FW‹ÓFgxY1ËÅYq€'°› = self;
    ui_showeventhud( var0 );
    
    while ( !self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 )
    {
        if ( !scripts\mp\utility\player::isreallyalive( var0 ) )
        {
            break;
        }
        
        var3 = distance2dsquared( self.origin, var0.origin );
        
        if ( var3 >= squared( level.©FW‹ÓFgxY1ËÅYq€'°›.¾wbQèâŞ»£ß¹óÊ^Ù[^ïÈx³ ) )
        {
            if ( !isdefined( var2 ) )
            {
                var2 = gettime();
            }
            else if ( gettime() >= var2 + 10000 )
            {
                break;
            }
        }
        else if ( isdefined( var2 ) )
        {
            var2 = undefined;
        }
        
        wait 1;
    }
    
    if ( self.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 )
    {
        return;
    }
    
    event_deregisteractiveparticipant( var0 );
}

// Params 2
// Size: 0xa6
function event_calculatezombiespawnchances( var0, var1 )
{
    var2 = [];
    var3 = 0;
    
    foreach ( var5 in var1 )
    {
        var3 += var5;
    }
    
    var7 = 0;
    var8 = getarraykeys( var1 );
    var9 = undefined;
    
    foreach ( var14, var5 in var1 )
    {
        var2 = [];
        var11 = var5 / var3;
        
        if ( var7 == 0 )
        {
            var12 = 0;
            var13 = var11;
        }
        else
        {
            var12 = var9[ 3 ];
            var13 = var12 + var11;
        }
        
        var2 = [ var5, var11, var12, var13 ];
        var9 = var2[ var14 ];
        var7++;
    }
    
    return var2;
}

// Params 1
// Size: 0x83
function event_spawnzombiefromspawntable( var0 )
{
    if ( self.†¡Ê-"5À/Xøs¤˜uêRGßƒª + self.“Wxatı[¼ßsÀÕ‹—u.size >= level.©FW‹ÓFgxY1ËÅYq€'°›.«¹Òçˆw_§{?Àû‰šÆÉ¹3eƒá<*“nø*  )
    {
        return;
    }
    
    var1 = randomfloat( 1 );
    
    foreach ( var3 in var0 )
    {
        var4 = var3[ 2 ];
        var5 = var3[ 3 ];
        
        if ( var1 >= var4 && var1 <= var5 )
        {
            self.†¡Ê-"5À/Xøs¤˜uêRGßƒª++;
            thread zombie_spawnagent( scripts\engine\utility::random( self.¢÷Ù‡C^ÑèÅ¡˜§Ûm	W?I=: ), var6 );
            break;
        }
    }
}

// Params 1
// Size: 0x64
function event_setsuperstatustozombies( var0 )
{
    foreach ( var2 in self.“Wxatı[¼ßsÀÕ‹—u )
    {
        if ( var3 == var0 )
        {
            return;
        }
        
        if ( istrue( var2.£Ëóc-AêW[4Hø‹jà‘šCT ) || istrue( var2.¾Û|—E;‹7€°RS= ) )
        {
            continue;
        }
        
        if ( !isalive( var2 ) )
        {
            var0 += 1;
            continue;
        }
        
        thread zombie_setsuperzombiestatus();
    }
}

// Params 0
// Size: 0x66
function event_zombiereinforcementwatcher()
{
    level endon( "game_ended" );
    self endon( "end_event" );
    
    for ( ;; )
    {
        if ( self.“Wxatı[¼ßsÀÕ‹—u.size <= 7 )
        {
            var0 = level.©FW‹ÓFgxY1ËÅYq€'°›.«¹Òçˆw_§{?Àû‰šÆÉ¹3eƒá<*“nø*  - self.“Wxatı[¼ßsÀÕ‹—u.size;
            var1 = randomintrange( 1, var0 + 1 );
            
            for ( var2 = 0; var2 < var1 ; var2++ )
            {
                thread event_spawnzombiefromspawntable( self.¾k8ù`C_£Ğ0 ı™«“º¸m‘o‡õ‡²ÜÏ«ñ[ self.‡pŸ{fHssœñ› ] );
            }
        }
        
        wait 3;
    }
}

// Params 0
// Size: 0x5e
function event_zombietoofarfromeventwatcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        var0 = distance2dsquared( self.origin, self.©FW‹ÓFgxY1ËÅYq€'°›.origin ) > squared( 2000 );
        
        if ( var0 )
        {
            self.–ªF²°£¡¯&åú®9æ+Fë4•æÑ = 1;
            self dodamage( self.health, self.origin, self, undefined, "MOD_TRIGGER_HURT", undefined );
            break;
        }
        
        wait 5;
    }
}

// Params 3
// Size: 0x12f
function zombie_spawnagent( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "end_event" );
    
    if ( !istrue( var2 ) )
    {
        wait randomfloatrange( 0, 8 );
    }
    
    var3 = [ "base", "explosion_on_death", "gas_on_death", "emp" ];
    
    if ( !isdefined( var1 ) )
    {
        var1 = scripts\engine\utility::random( var3 );
    }
    
    var4 = zombie_getzombietypeparameters( var1 );
    var5 = _testing_ending::spawnnewzombieagent( var0.origin, var0.angles, 0, "enemy_lw_zombie_default", var4.ªä¨“ÿA 'ÌvÊ§ );
    self.†¡Ê-"5À/Xøs¤˜uêRGßƒª--;
    
    if ( !isdefined( var5 ) )
    {
        return;
    }
    
    var5 hide();
    waitframe();
    var5 show();
    
    if ( isdefined( self.chest ) )
    {
        self.“Wxatı[¼ßsÀÕ‹—u[ self.“Wxatı[¼ßsÀÕ‹—u.size ] = var5;
        var5.©FW‹ÓFgxY1ËÅYq€'°› = self;
        var5.intelused = &zombie_cursedchestondeathcallback;
        var5.¥9)ëÆËĞ>ÄyP´AE÷ë«áRW0îwŒpèûêıùo™J
Hq, = &zombie_cursedchestondamagefinishedcallback;
    }
    
    var5.entered_playspace = 1;
    var5.ªOóZ0¦Åy{»çƒ = var4.ªOóZ0¦Åy{»çƒ;
    var5.£ı¢ğøá˜AÏÓ±-K·{“xO = var1;
    var5.¬»ğÈP·­­ ²Šø•g = 1;
    var5 accesscard::ref_13173( var4.Œ_Ë¿½Z5óñÓã} );
    
    if ( var5.£ı¢ğøá˜AÏÓ±-K·{“xO == "gas_thrower" )
    {
        var5 thread _luidecision::ref_1447f( var5, -1 );
    }
    
    if ( istrue( var4.¾Û|—E;‹7€°RS= ) )
    {
        thread zombie_setsuperzombiestatus();
    }
    
    thread event_zombietoofarfromeventwatcher();
}

// Params 1
// Size: 0x120
function zombie_setsuperzombiestatus( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( !isdefined( var0 ) || !var0 )
    {
        self.£Ëóc-AêW[4Hø‹jà‘šCT = 1;
        var1 = easepower( "br_loot_cursed_chest_zombie_super_upgrade_audio", self.origin );
        thread helper_cleanupaudioscriptableintime( level, var1 );
        waitframe();
        var1 setscriptablepartstate( "cc_zmb_super_upgrade", "cc_zmb_super_upgrade_charge" );
        playfxontag( scripts\engine\utility::getfx( "cursed_chest_super_zombie_pre_flare" ), self, "tag_origin" );
        wait 2;
    }
    
    playfxontag( scripts\engine\utility::getfx( "cursed_chest_super_zombie_helmet_distortion" ), self, "j_head" );
    playfx( scripts\engine\utility::getfx( "cursed_chest_super_zombie_flare" ), self.origin + ( 0, 0, 10 ) );
    var2 = easepower( "br_loot_cursed_chest_zombie_super_upgrade_audio", self.origin );
    thread helper_cleanupaudioscriptableintime( level, var2 );
    waitframe();
    var2 setscriptablepartstate( "cc_zmb_super_upgrade", "cc_zmb_super_upgrade_flare" );
    self.¾Û|—E;‹7€°RS= = 1;
    self.maxhealth = level.©FW‹ÓFgxY1ËÅYq€'°›.š›KZ—µ9òGãÖª¸ˆÙÓùiÛ€e ;
    self.health = level.©FW‹ÓFgxY1ËÅYq€'°›.š›KZ—µ9òGãÖª¸ˆÙÓùiÛ€e ;
    self.hashelmet = 1;
    _testing_ending::scriptable_token_scriptable_touched_callback( level.©FW‹ÓFgxY1ËÅYq€'°›.ŠgÜ]ƒV'¾=ÛÖL´Ê}…œ­½Éë³°]V );
    accesscard::ref_13173( "sprint" );
    self setscriptablepartstate( "ai_glow", "super_loop" );
}

// Params 2
// Size: 0x13
function helper_cleanupaudioscriptableintime( var0, var1 )
{
    self endon( "game_ended" );
    wait var1;
    var0 freescriptable();
}

// Params 1
// Size: 0x146
function zombie_getzombietypeparameters( var0 )
{
    var1 = spawnstruct();
    
    switch ( var0 )
    {
        case "walker":
            var1.ªä¨“ÿA 'ÌvÊ§ = "base";
            var1.Œ_Ë¿½Z5óñÓã} = "walk";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
        case "runner":
            var1.ªä¨“ÿA 'ÌvÊ§ = "explosion_on_death";
            var1.Œ_Ë¿½Z5óñÓã} = "run";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
        case "sprinter":
            var1.ªä¨“ÿA 'ÌvÊ§ = "emp";
            var1.Œ_Ë¿½Z5óñÓã} = "sprint";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
        case "gas_thrower":
            var1.ªä¨“ÿA 'ÌvÊ§ = "ranger";
            var1.Œ_Ë¿½Z5óñÓã} = "run";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
        case "weakpoint":
            var1.ªä¨“ÿA 'ÌvÊ§ = "weakpoint";
            var1.Œ_Ë¿½Z5óñÓã} = "walk";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
        default:
            var1.ªä¨“ÿA 'ÌvÊ§ = "base";
            var1.Œ_Ë¿½Z5óñÓã} = "walk";
            var1.ªOóZ0¦Åy{»çƒ = 1;
            break;
    }
    
    if ( isdefined( self.‡pŸ{fHssœñ› ) )
    {
        var1.¾Û|—E;‹7€°RS= = 0;
    }
    
    return var1;
}

// Params 9
// Size: 0x219
function zombie_cursedchestondeathcallback( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    var9 = distance2dsquared( self.©FW‹ÓFgxY1ËÅYq€'°›.origin, self.origin );
    
    if ( self.©FW‹ÓFgxY1ËÅYq€'°›.•ã¬ì+›è×à²sF–¹Ù¾Gö}+72 || var9 <= squared( self.©FW‹ÓFgxY1ËÅYq€'°›.ref_129e0 ) )
    {
        if ( istrue( self.¾Û|—E;‹7€°RS= ) )
        {
            for ( var10 = 0; var10 < level.©FW‹ÓFgxY1ËÅYq€'°›.†°p»ò;»‡z°¹z‡‡šbàÒA[G„Í - 1 ; var10++ )
            {
                thread zombie_sendhellfiretochest();
            }
        }
        
        thread zombie_sendhellfiretochest();
        var11 = scripts\engine\utility::ter_op( istrue( self.¾Û|—E;‹7€°RS= ), level.©FW‹ÓFgxY1ËÅYq€'°›.†°p»ò;»‡z°¹z‡‡šbàÒA[G„Í, self.ªOóZ0¦Åy{»çƒ );
        
        if ( istrue( var1.ref_12827 ) )
        {
            var11 *= 2;
        }
        
        event_addtoscorecount( self.©FW‹ÓFgxY1ËÅYq€'°›, var11 );
    }
    
    self.©FW‹ÓFgxY1ËÅYq€'°›.“Wxatı[¼ßsÀÕ‹—u = scripts\engine\utility::array_remove( self.©FW‹ÓFgxY1ËÅYq€'°›.“Wxatı[¼ßsÀÕ‹—u, self );
    var12 = spawnstruct();
    var12.attacker = var1;
    var12.victim = self;
    _initignoredtabspergamemode::ref_11ff1( var12 );
    _ispointinbadarea::ref_11ff1( var12 );
    
    if ( istrue( self.–ªF²°£¡¯&åú®9æ+Fë4•æÑ ) )
    {
        return;
    }
    
    if ( isdefined( var1 ) && ( isplayer( var1 ) || isbot( var1 ) ) )
    {
        var13 = distance2dsquared( self.origin, var1.origin ) < squared( level.©FW‹ÓFgxY1ËÅYq€'°›.¾wbQèâŞ»£ß¹óÊ^Ù[^ïÈx³ );
        
        if ( var13 )
        {
            event_registeractiveparticipant( self.©FW‹ÓFgxY1ËÅYq€'°›, var1 );
        }
        
        if ( isdefined( self.¾Û|—E;‹7€°RS= ) && self.¾Û|—E;‹7€°RS= )
        {
            var1 thread scripts\mp\rank::giverankxp( "br_zai_killed_super", 50, var1 getcurrentweapon() );
            var1 thread scripts\mp\rank::scoreeventpopup( "br_zai_killed_super" );
        }
        else
        {
            var1 thread scripts\mp\rank::giverankxp( "br_zai_killed", 10, var1 getcurrentweapon() );
            var1 thread scripts\mp\rank::scoreeventpopup( "br_zai_killed" );
        }
    }
    
    GscBinSkip1( 0x45, "eAttacker", var1 );
    // Unknown operator ( 0x45, iw8, PC )
}

// Params 15
// Size: 0x4b
function zombie_cursedchestondamagefinishedcallback( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    if ( scripts\mp\damage::armorvest_wasbroke( var1 ) )
    {
        stopfxontag( scripts\engine\utility::getfx( "cursed_chest_super_zombie_helmet_distortion" ), self, "j_head" );
        playfxontag( scripts\engine\utility::getfx( "cursed_chest_super_zombie_helmet_break" ), self, "j_head" );
        self.hashelmet = 0;
        return;
    }
}

// Params 0
// Size: 0x25f
function zombie_sendhellfiretochest()
{
    if ( !level.©FW‹ÓFgxY1ËÅYq€'°›.¡ñ+‰WõŒZ¹°‰cV¯g™‡ )
    {
        playfx( scripts\engine\utility::getfx( "cursed_chest_zombie_death" ), self.origin + ( 0, 0, 50 ) );
    }
    
    var0 = self.©FW‹ÓFgxY1ËÅYq€'°›;
    thread sfx_playdeathsoundviascriptable( level, self.origin, "br_loot_cursed_chest_zombie_death_audio", "cursed_chest_zombie_death_audio" );
    var1 = spawn( "script_model", self.origin + ( 0, 0, 50 ) );
    var1 setmodel( "tag_origin" );
    waitframe();
    playfxontag( scripts\engine\utility::getfx( "cursed_chest_zombie_soul_absorb" ), var1, "tag_origin" );
    var2 = self.origin + ( 0, 0, 50 );
    var3 = var0.origin + ( 0, 0, 10 );
    var1.angles = vectortoangles( var3 - var2 );
    var4 = distance( var2, var3 );
    var5 = var4 / var0.ref_129e0;
    var6 = 200 * var5 + 50;
    var6 += randomfloatrange( -1 * var6 * 0.2 / 2, var6 * 0.2 / 2 );
    
    if ( var6 < 50 )
    {
        var6 = 50;
    }
    
    if ( var6 > 250 )
    {
        var6 = 250;
    }
    
    var7 = var4 / var6;
    var8 = gettime();
    var9 = var8;
    var10 = var8 + var7 * 1000;
    var11 = randomint( 360 );
    var12 = randomfloatrange( 3, 4 );
    var13 = randomintrange( 50, 100 );
    var14 = 0;
    var15 = var2[ 2 ] - var3[ 2 ];
    
    if ( var15 < 80 )
    {
        var16 = randomintrange( 40, 80 ) + var15 / 2;
    }
    else if ( var16 < 160 )
    {
        var16 = randomintrange( 0, 40 ) + var16 / 2;
    }
    else
    {
        var16 = randomintrange( -40, 0 ) + var16 / 2;
    }
    
    var17 = 0;
    
    while ( var17 < 1 )
    {
        var11 = gettime();
        var18 = var13 + var14 * var17 * 180;
        var19 = sin( var17 * 180 ) * var15;
        var20 = rotatepointaroundvector( anglestoforward( var3.angles ), var19 * anglestoright( var3.angles ), var18 );
        var21 = ( 0, 0, var16 * sin( var17 * 180 + sin( var17 * 180 ) / -1 ) );
        var22 = vectorlerp( var4, var5, var17 ) + var21 + var20;
        var3.origin = var22;
        var17 = pow( ( var11 - var10 ) / 1000 / var9, 1.7 );
        waitframe();
    }
    
    playfx( scripts\engine\utility::getfx( "cursed_chest_zombie_soul_absorb_stop" ), var5 );
    stopfxontag( scripts\engine\utility::getfx( "cursed_chest_zombie_soul_absorb" ), var3, "tag_origin" );
    wait 2;
    var3 delete();
}

// Params 4
// Size: 0xb4
function onhitbypoisonzombie( var0, var1, var2, var3 )
{
    if ( isdefined( var0 ) && isdefined( var0.£ı¢ğøá˜AÏÓ±-K·{“xO ) && var0.£ı¢ğøá˜AÏÓ±-K·{“xO == "gas_thrower" )
    {
        if ( isdefined( var1 ) )
        {
            if ( isdefined( var2 ) && isalive( var2 ) )
            {
                var4 = easepower( "vfx_chem_rounds_enemy_hit", var1 );
                thread ref_12aab( var4 );
                
                if ( !istrue( var2.updateteamplunderscore ) )
                {
                    if ( isplayer( var2 ) )
                    {
                        stopfxontagforclients( level._effects[ "vfx_nova_round_scrnfx" ], var2, "j_head", var2 );
                        playfxontagforclients( level._effects[ "vfx_nova_round_scrnfx" ], var2, "j_head", var2 );
                    }
                    
                    var2.updateteamplunderscore = 1;
                    
                    if ( isdefined( self ) )
                    {
                        self playlocalsound( "bullet_chem_round_dmg_plr_trans" );
                    }
                }
                
                var2 thread _luidecision::ref_1447f( var0, 3 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x12
function ref_12aab( var0 )
{
    level endon( "game_ended" );
    wait var0;
    self freescriptable();
}

// Params 4
// Size: 0x21
function sfx_playdeathsoundviascriptable( var0, var1, var2, var3 )
{
    var4 = easepower( var1, var0 );
    waitframe();
    var4 setscriptablepartstate( var2, var3 );
    wait 5;
    var4 freescriptable();
}

// Params 1
// Size: 0x7e
function spawnnode_spawn( var0 )
{
    var1 = spawnstruct();
    var1.index = self.§Æúc|sÇhWÙEÇ.size;
    var1.origin = var0;
    var1.angles = ( 0, 0, 0 );
    var1.state = "valid";
    var1.parent = undefined;
    var1.ref_14293 = undefined;
    var2 = distance( var1.origin, self.origin );
    var1.loot_getitemcountlefthand = self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡ - var2;
    self.§Æúc|sÇhWÙEÇ[ self.§Æúc|sÇhWÙEÇ.size ] = var1;
}

// Params 0
// Size: 0x121
function spawnnode_spawnallnodes()
{
    var0 = spawnstruct();
    var1 = self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡;
    var0.ref_11a58 = self.origin + ( var1 * -1, var1 * -1, 0 );
    var0.ref_11a59 = self.origin + ( var1, var1 * -1, 0 );
    var0.ref_14039 = self.origin + ( var1 * -1, var1, 0 );
    var0.ref_1403a = self.origin + ( var1, var1, 0 );
    var2 = 10;
    var3 = self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡ * 2;
    var4 = var3 / var2;
    var5 = ( self.origin[ 0 ] - self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡, self.origin[ 1 ] - self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡, self.origin[ 2 ] );
    
    for ( var6 = 0; var6 < var2 ; var6++ )
    {
        for ( var7 = 0; var7 < var2 ; var7++ )
        {
            var8 = var4 * var6;
            var9 = ( var8, 0, 0 );
            var10 = var4 * var7;
            var11 = ( 0, var10, 0 );
            var12 = var5 + var9 + var11;
            
            if ( distance2dsquared( var12, self.origin ) < squared( self.†İ=íÚ&KV¾Í8…î7×“ÂÈÒºÜ¾k‡ ) )
            {
                if ( distance2dsquared( var12, self.origin ) > squared( self.½İ{M³š_íIë.ÓE¹f©@«£ç]¨e ) )
                {
                    spawnnode_spawn( var12 );
                }
            }
        }
    }
    
    thread spawnnode_selectnodestospawnon();
}

// Params 0
// Size: 0x43
function spawnnode_selectnodestospawnon()
{
    foreach ( var1 in self.§Æúc|sÇhWÙEÇ )
    {
        if ( var1.state != "valid" )
        {
            continue;
        }
        
        spawnnode_spawnonnodegrid( var1 );
    }
}

// Params 1
// Size: 0x127
function spawnnode_spawnonnodegrid( var0 )
{
    if ( var0.state != "valid" )
    {
        return;
    }
    
    var0.state = "selected";
    var1 = physics_createcontents( [ "physicscontents_solid", "physicscontents_water" ] );
    var2 = ( 0, 0, 250 );
    var3 = var0.origin + var2;
    var4 = var0.origin - var2;
    var5 = [];
    var6 = physics_raycast( var3, var4, var1, var5, 0, "physicsquery_closest", 1 );
    var7 = var0.origin;
    
    if ( isdefined( var6 ) && var6.size > 0 )
    {
        var7 = var6[ 0 ][ "position" ];
        var0.origin = getclosestpointonnavmesh( var7 );
        self.¢÷Ù‡C^ÑèÅ¡˜§Ûm	W?I=:[ self.¢÷Ù‡C^ÑèÅ¡˜§Ûm	W?I=:.size ] = var0;
    }
    
    var8 = risk_flagspawncount();
    
    foreach ( var10 in self.§Æúc|sÇhWÙEÇ )
    {
        if ( var10.state != "valid" )
        {
            continue;
        }
        
        var11 = distance2dsquared( var0.origin, var10.origin );
        
        if ( var11 <= squared( 150 ) )
        {
            var10.parent = var0;
            var10.state = "occupied";
            var10.color = var8;
        }
    }
}

// Params 0
// Size: 0x2e
function risk_flagspawncount()
{
    var0 = randomfloatrange( 0.4, 1 );
    var1 = randomfloatrange( 0.3, 0.6 );
    var2 = randomfloatrange( 0.3, 1 );
    return ( var0, var1, var2 );
}

// Params 0
// Size: 0x98
function ui_showeventhud()
{
    if ( !isdefined( self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ ) )
    {
        self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ = [];
        self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ[ "score_display" ] = ui_createhudelement( &"BR_CURSED_CHEST_EVENT/SCORE_DISPLAY", self.©FW‹ÓFgxY1ËÅYq€'°›.•Nâ{î‡¯‹ÇpŠ·, 1, ( 1, 1, 1 ), undefined, 0, 50 );
    }
    
    foreach ( var1 in self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ )
    {
        var1 scripts\mp\hud_util::showelem();
    }
    
    if ( isdefined( self.©FW‹ÓFgxY1ËÅYq€'°› ) )
    {
        self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ[ "score_display" ] setvalue( self.©FW‹ÓFgxY1ËÅYq€'°›.•Nâ{î‡¯‹ÇpŠ· );
        return;
    }
}

// Params 0
// Size: 0x38
function ui_hideeventhud()
{
    if ( !isdefined( self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ ) )
    {
        return;
    }
    
    foreach ( var1 in self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ )
    {
        var1 scripts\mp\hud_util::hideelem();
    }
}

// Params 0
// Size: 0x3e
function ui_deleteeventhud()
{
    if ( !isdefined( self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ ) )
    {
        return;
    }
    
    foreach ( var1 in self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ )
    {
        var1 scripts\mp\hud_util::destroyelem();
    }
    
    self.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ = undefined;
}

// Params 0
// Size: 0x56
function ui_updateallparticipantshud()
{
    foreach ( var1 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
    {
        if ( !isdefined( var1 ) )
        {
            return;
        }
        
        var1.•cØºNn•Fë6C²¹èõÊ;Êæ×ÕZ[ "score_display" ] setvalue( self.•Nâ{î‡¯‹ÇpŠ· );
        thread ui_scorepop();
    }
}

// Params 0
// Size: 0x34
function ui_deleteallparticipantshud()
{
    foreach ( var1 in self.“í/°#ÙÓsÚ–î	z›(§‹à; )
    {
        if ( !isdefined( var1 ) )
        {
            return;
        }
        
        ui_deleteeventhud( var1 );
    }
}

// Params 7
// Size: 0x93
function ui_createhudelement( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( !isdefined( var4 ) )
    {
        var4 = "TOPLEFT";
    }
    
    if ( !isdefined( var5 ) )
    {
        var5 = 0;
    }
    
    if ( !isdefined( var6 ) )
    {
        var6 = 0;
    }
    
    var7 = scripts\mp\hud_util::createfontstring( "default", var2 );
    var7.label = var0;
    var7.color = var3;
    var8 = 40;
    var9 = ( 1 - getdvarfloat( "LQORTPMNLL", 0 ) ) * var8;
    var10 = ( 1 - getdvarfloat( "NPLKLQMNPL", 0 ) ) * var8 / 2;
    var7 scripts\mp\hud_util::setpoint( var4, var4, 143 + var9, var6 + var10 );
    
    if ( isdefined( var1 ) )
    {
        var7 setvalue( var1 );
    }
    
    return var7;
}

// Params 0
// Size: 0x8d
function ui_scorepop()
{
    level endon( "game_ended" );
    self notify( "score_pop_triggered" );
    self endon( "score_pop_triggered" );
    var0 = 0.35;
    var1 = 0;
    var2 = gettime();
    var3 = var2;
    var4 = var2 + var0 * 1000;
    
    while ( var1 < 1 )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        var5 = 2;
        var6 = 1;
        
        if ( var1 < 0.5 )
        {
            var6 = var1 * 2 * var5;
        }
        else
        {
            var6 = var5 + var5 * ( 1 - var1 * 2 );
        }
        
        var1 = ( var3 - var2 ) / 1000 / var0;
        scripts\mp\hud_util::setsize( var6, var6 );
        waitframe();
    }
}

