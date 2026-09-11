
// Params 0
// Size: 0x8b
function init()
{
    var0 = spawnstruct();
    var0.weight = getdvarfloat( "scr_br_pe_fafir_weight", 0 );
    var0.ref_140cf = &ref_140cf;
    var0.attackerswaittime = &attackerswaittime;
    var0.ref_14382 = &ref_14382;
    var0.‹Á¿ø{ÏXX;â# / = &postinitfunc;
    var0.ref_11b78 = getdvarint( "scr_br_pe_fafir_max_times", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "fafir", "0    20  20  20          0   0   0   0" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "fafir" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 18, var0 );
}

// Params 0
// Size: 0x2ce
function test_bag_pickup()
{
    level.’-ªP}·¢‘y:k8¨&£ = spawnstruct();
    level.’-ªP}·¢‘y:k8¨&£.instances = [];
    level.’-ªP}·¢‘y:k8¨&£.“Š[( ¢Ju×sG³`ğ•cà¸ = getdvarint( "scr_br_pe_fafir_strike_volbomb_normal_amount", 3 );
    level.’-ªP}·¢‘y:k8¨&£.Š{BĞıÂ'Wç¢Õ‹ÚQÊ·MÓ = getdvarint( "scr_br_pe_fafir_strike_volbomb_cosmetic_amount", 7 );
    level.’-ªP}·¢‘y:k8¨&£.±«ÈF§ÿùoY)è—à/Zî˜P £w = getdvarint( "scr_br_pe_fafir_strike_explosion_radius", 1000 );
    level.’-ªP}·¢‘y:k8¨&£.¥E‚h¢ (®á+W˜P¡V§ãØqp² = getdvarint( "scr_br_pe_fafir_strike_targeting_radius", 1500 );
    level.’-ªP}·¢‘y:k8¨&£.–ùÇá>’kĞõ=3@©Zk = getdvarint( "scr_br_pe_fafir_strike_low_range", 10000 );
    level.’-ªP}·¢‘y:k8¨&£.‘°:kp‰jeoWq–²ö°Ñ = getdvarint( "scr_br_pe_fafir_strike_med_range", 30000 );
    level.’-ªP}·¢‘y:k8¨&£.­Üè'K­²×–;†“›³Ê = getdvarint( "scr_br_pe_fafir_strike_high_range", 50000 );
    level.’-ªP}·¢‘y:k8¨&£.¦ÂóËL¿“¨Lb¢ä Ôó9?w:yj = getdvarint( "scr_br_pe_fafir_strike_gravity_low_range", 20000 );
    level.’-ªP}·¢‘y:k8¨&£.¦ñ#ƒóggÿÍA‹@Å2yI“'¸@? = getdvarint( "scr_br_pe_fafir_strike_gravity_med_range", 12000 );
    level.’-ªP}·¢‘y:k8¨&£.—Ö§súû£))ˆ£SÛ™#·a»_Øñ[ = getdvarint( "scr_br_pe_fafir_strike_gravity_high_range", 7500 );
    level.’-ªP}·¢‘y:k8¨&£.oæÑäKÖ¬}ÍÁ•ÊÈ6íİÉ°æÙY = getdvarint( "scr_br_pe_fafir_strike_speed_low_range", 8000 );
    level.’-ªP}·¢‘y:k8¨&£.“g¹:“´µY×Í²Ê‘µVF9sÎV = getdvarint( "scr_br_pe_fafir_strike_speed_med_range", 10000 );
    level.’-ªP}·¢‘y:k8¨&£.›5ı*sbB?k“½‹(Îeÿ3 = getdvarint( "scr_br_pe_fafir_strike_speed_high_range", 12000 );
    level.’-ªP}·¢‘y:k8¨&£.‡&û÷²Cá{Ö^pøš»g7 = getdvarfloat( "scr_br_pe_fafir_toxic_scalar", 1 );
    level.’-ªP}·¢‘y:k8¨&£.™ëc¯ÃCæ–F»rp0HS·çm?= = getdvarfloat( "scr_br_pe_fafir_toxic_radius_spread_time", 20 ) * level.’-ªP}·¢‘y:k8¨&£.‡&û÷²Cá{Ö^pøš»g7;
    level.’-ªP}·¢‘y:k8¨&£.7µU[éßË8X÷,`›b = getdvarint( "scr_br_pe_fafir_toxic_lifetime", 10 ) + level.’-ªP}·¢‘y:k8¨&£.™ëc¯ÃCæ–F»rp0HS·çm?=;
    level.’-ªP}·¢‘y:k8¨&£.¦•åÈ/9Óğ šKÇ€¿0 = getdvarint( "scriptable_cityKillerMaxRadius", 3000 ) * level.’-ªP}·¢‘y:k8¨&£.‡&û÷²Cá{Ö^pøš»g7;
    level.’-ªP}·¢‘y:k8¨&£.¯•Ÿğ VŸûùARoÈÌæ = getdvarint( "scriptable_cityKillerMinRadius", 1000 ) * level.’-ªP}·¢‘y:k8¨&£.‡&û÷²Cá{Ö^pøš»g7;
    level.’-ªP}·¢‘y:k8¨&£.£Ij{#ˆYìC£¿pw×«82_ = getdvarint( "scr_br_pe_fafir_toxic_initial_damage_per_tick", 12 );
    level.’-ªP}·¢‘y:k8¨&£.½es
Cè9-)Ü?#ó+Êh7	Ü = getdvarint( "scr_br_pe_fafir_toxic_vfx_height_threshold", 2250 );
    level.’-ªP}·¢‘y:k8¨&£.¯	»í@p±“©NÈôI!S‰h³ê‹÷§ÇÃ˜h = getdvarint( "scr_br_pe_fafir_toxic_vfx_grid_division_count", 5 );
    level.’-ªP}·¢‘y:k8¨&£.ªxg ø9[Œ‹y2E@å»™Hó_³ÁÃ	~—ÎJ³ˆO = getdvarint( "scr_br_pe_fafir_toxic_vfx_inner_clouds_spacing", 200 );
    level.’-ªP}·¢‘y:k8¨&£.YSÿ!O[oBGñø¨cfhË´è1EÍ[¹@uñ = getdvarint( "scr_br_pe_fafir_toxic_vfx_allow_high_net_lod", 0 );
    level.½œ»ŞyŒ‡ÓHĞß1˜Xµr = spawnstruct();
    level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.Šâ›H³Ohµh-Ÿ°ã[ = getdvarfloat( "scr_br_pe_fafir_shake_intensity", 0.4 );
    level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.„/óSˆÀ…-º¼à‡" = getdvarfloat( "scr_br_pe_fafir_shake_duration", 2 );
    level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.±™Hs± ãæ…û« = getdvarint( "scr_br_pe_fafir_shake_radius", 100000 );
    
    if ( !isdefined( level.P	xuÓ`Ëy³I ) )
    {
        level.P	xuÓ`Ëy³I = spawnstruct();
    }
    
    level.’-ªP}·¢‘y:k8¨&£.brushmodel = getent( "lava_bomb_collision", "targetname" );
}

// Params 0
// Size: 0x77b
function initlocations()
{
    if ( !isdefined( level.’-ªP}·¢‘y:k8¨&£ ) )
    {
        level.’-ªP}·¢‘y:k8¨&£ = spawnstruct();
    }
    
    level.’-ªP}·¢‘y:k8¨&£.locations = [];
    level.’-ªP}·¢‘y:k8¨&£.¸ÚÁùU¿_ÙÔOğƒ = [];
    level.’-ªP}·¢‘y:k8¨&£.£à“YÙKŞ®æ×ÛlXÒ{›› = [];
    
    switch ( getdvar( "mapname" ) )
    {
        case "mp_wz_island":
            level.’-ªP}·¢‘y:k8¨&£.locations = [ ( 3082.75, 531, 3426.75 ), ( -14610.3, -12734.8, 881.5 ), ( -30700.5, -30311.5, 858 ), ( 18984.8, 55917.8, 177.5 ), ( 11026, 58585.5, 369.25 ), ( 46963, 38986.5, 260 ), ( 38221.3, 43254.5, 790.75 ), ( 30958.5, 45074.3, 1291 ), ( 21384.8, 40108.5, 1602.25 ), ( 12078.5, 47861.3, 907.25 ), ( 2654.75, 42867.3, 1085.75 ), ( -3461, 49297.3, 1250 ), ( -5693.5, 41866.8, 1256.5 ), ( -15242.5, 46205, 719.75 ), ( -20261.8, 45778.8, 337.25 ), ( -32990.3, 26086.5, 787.75 ), ( -17402, 36106.3, 1182.75 ), ( -14247.8, 28359.5, 3020.25 ), ( -5332, 34753, 1072.75 ), ( -1080.5, 29989.8, 1039.25 ), ( 7745, 28819, 4245.5 ), ( 9750.75, 39446, 684 ), ( 24995.5, 35181.3, 2466.25 ), ( 21065, 29575.3, 3971 ), ( 34786.5, 27204, 1852.5 ), ( 38203.5, 36513.5, 1552 ), ( 41069.5, 30401.8, 1173.75 ), ( 46662.3, 30476.5, 846.75 ), ( 46819.8, 24629.5, 455.25 ), ( 42717, 17092, 592 ), ( 35921.5, 18815.8, 1496.5 ), ( 26347.8, 22039.3, 2620 ), ( 9477.75, 26347.3, 4764.5 ), ( -6003.75, 22718.8, 1144.25 ), ( -9154.25, 13834.8, 1952.25 ), ( -21083.5, 20147.5, 2969.5 ), ( -15159.5, 15410.5, 3658 ), ( -32427.5, 16901.8, 965.75 ), ( -44351.3, 20528, 1350.75 ), ( -43726.3, 13898.5, 1498 ), ( -46765.5, 5591.5, 1037 ), ( -39000.8, 10171.5, 1018.75 ), ( -26540.5, 9793.25, 2641 ), ( -18704, 6078.25, 3231 ), ( -13530, 1944.25, 501 ), ( -2328.25, 12017, 3782.5 ), ( 16580.8, 2717.5, 4509.5 ), ( 24099.8, 7489.63, 2703.65 ), ( 33171.6, 11259.9, 764.4 ), ( 34758.8, 1038.88, 1176.9 ), ( 44042.3, 8120.63, 319.15 ), ( 41879.8, -9966.37, 581.15 ), ( 33530.6, -5854.87, 1941.9 ), ( 31117.8, -11487.4, 4010.65 ), ( 24049.3, 394.384, 2771.4 ), ( 20321.8, -7697.87, 3877.4 ), ( 2836, -4967.25, 2143.75 ), ( 8858, -9607.5, 1846.5 ), ( -5219, -10765.8, 1613.25 ), ( -3979, -1912.75, 1836 ), ( -16345, -3826, 490.75 ), ( -24598.8, -10701.5, 413 ), ( -34330.5, -2566.5, 2456.25 ), ( -39473, -9290.75, 504 ), ( -45097, -915, 374 ), ( -45472.8, -17987.5, 352.25 ), ( -30157.8, -22111.5, 880.75 ), ( -28950.3, -14795.5, 1002 ), ( -22409, -23093.3, 885.5 ), ( -4722, -21771.5, 1522.25 ), ( -18.25, -17327, 2117.75 ), ( 9180.75, -16978, 2204.75 ), ( 1223.5, -25339.3, 2078.25 ), ( 23497.5, -19198, 3800 ), ( 14550.5, -18653.3, 3252.75 ), ( 29858.5, -17783.3, 5292 ), ( 37167, -24164, 1819 ), ( 44628.8, -21343.3, 247.5 ), ( 41856, -34492.8, 345.5 ), ( 35045, -31877, 561.5 ), ( 27212, -39539.3, 639 ), ( 18059, -29311.8, 5492.25 ), ( 13484.3, -38331, 3908.75 ), ( 3570.5, -32594.3, 3602.5 ), ( 11620.8, -38958.8, 3607.25 ), ( -4822.75, -37830.8, 2399 ), ( -7818.75, -29843.5, 1771.75 ), ( -21943.3, -31186.3, 984.5 ), ( -15532.3, -38377, 2156 ), ( -16523.3, -40508.8, 2140.5 ), ( -11912, -51806.3, 1303.5 ), ( -5092.25, -46423.3, 2244 ), ( 724, -43629.8, 3482.5 ), ( 11386.8, -47546.8, 1521.25 ), ( 20423.5, -50600.5, 413 ), ( 19471.8, -46557.3, 752.25 ), ( 29467.8, -45889.8, 494.5 ), ( 37662, -48701, 256.25 ), ( 46085.3, -40378.5, 214.5 ), ( 33670, -55129.5, 353.5 ), ( 23173.3, -56253.8, 243 ), ( 3455.25, -54708.8, 1094.25 ) ];
            break;
        case "mp_br_mechanics":
            level.’-ªP}·¢‘y:k8¨&£.locations = [ ( -2219, -2155, 58 ), ( 5000, -4426, 58 ), ( 4000, -4426, 58 ), ( 3000, -4426, 58 ), ( 2000, -4426, 58 ) ];
            break;
    }
    
    level.’-ªP}·¢‘y:k8¨&£.¸ÚÁùU¿_ÙÔOğƒ = [ ( -55000, 63000, 0 ), ( -25000, 63000, 0 ), ( 0, 63000, 0 ), ( 25000, 63000, 0 ), ( 55000, 63000, 0 ), ( -55000, -63000, 0 ), ( -25000, -63000, 0 ), ( 0, -63000, 0 ), ( 25000, -63000, 0 ), ( 55000, -63000, 0 ), ( 55000, 63000, 0 ), ( 55000, 33000, 0 ), ( 55000, 0, 0 ), ( 55000, -33000, 0 ), ( 55000, -63000, 0 ), ( -55000, 63000, 0 ), ( -55000, 33000, 0 ), ( -55000, 0, 0 ), ( -55000, -33000, 0 ), ( -55000, -63000, 0 ) ];
}

// Params 0
// Size: 0x6e
function postinitfunc()
{
    level._effect[ "vfx_lava_bomb_gas_explosion" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_explosion" );
    level._effect[ "vfx_lava_bomb_gas_cloud" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud" );
    level._effect[ "vfx_lava_bomb_gas_cloud_player" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud_player" );
    level._effect[ "vfx_lava_bomb_gas_cloud_distant" ] = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_lava_bomb_gas_cloud_distant" );
    scripts\mp\utility\sound::besttime( "br_event_fafir" );
    test_bag_pickup();
    initlocations();
    thread circlewatcher();
}

// Params 0
// Size: 0xd, Type: bool
function ref_140cf()
{
    return scripts\mp\utility\game::round_vehicle_logic() == "olaride";
}

// Params 0
// Size: 0x18
function ref_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var0 = forest_combat();
    wait var0;
}

// Params 0
// Size: 0x26
function attackerswaittime()
{
    level endon( "game_ended" );
    thread volcanoexplode( level, level.’-ªP}·¢‘y:k8¨&£.“Š[( ¢Ju×sG³`ğ•cà¸ );
}

// Params 0
// Size: 0x2b
function forest_combat()
{
    var0 = getdvarfloat( "scr_br_pe_fafir_starttime_min", 90 );
    var1 = getdvarfloat( "scr_br_pe_fafir_starttime_max", 395 );
    
    if ( var1 > var0 )
    {
        return randomfloatrange( var0, var1 );
    }
    
    return var0;
}

// Params 1
// Size: 0x35, Type: bool
function checkpositionavailability( var0 )
{
    for ( var1 = 0; var1 < level.’-ªP}·¢‘y:k8¨&£.£à“YÙKŞ®æ×ÛlXÒ{››.size ; var1++ )
    {
        if ( var0 == level.’-ªP}·¢‘y:k8¨&£.£à“YÙKŞ®æ×ÛlXÒ{››[ var1 ] )
        {
            return false;
        }
    }
    
    return true;
}

// Params 2
// Size: 0x36, Type: bool
function players_in_radius( var0, var1 )
{
    var2 = level.’-ªP}·¢‘y:k8¨&£.¦•åÈ/9Óğ šKÇ€¿0 + level.’-ªP}·¢‘y:k8¨&£.¥E‚h¢ (®á+W˜P¡V§ãØqp²;
    var3 = scripts\mp\utility\player::getplayersinradius( var0, var2 ).size;
    var4 = scripts\mp\utility\player::getplayersinradius( var1, var2 ).size;
    return var3 >= var4;
}

// Params 2
// Size: 0x182
function volcanoexplode( var0, var1 )
{
    var3 = [];
    
    if ( getdvarint( "scr_br_fafir_focus_players", 1 ) == 1 )
    {
        level.’-ªP}·¢‘y:k8¨&£.locations = scripts\engine\utility::array_sort_with_func( level.’-ªP}·¢‘y:k8¨&£.locations, &players_in_radius );
    }
    else
    {
        level.’-ªP}·¢‘y:k8¨&£.locations = scripts\engine\utility::array_randomize( level.’-ªP}·¢‘y:k8¨&£.locations );
    }
    
    for ( var2 = 0; var2 < var0 ; var2++ )
    {
        if ( var2 >= level.’-ªP}·¢‘y:k8¨&£.locations.size )
        {
            break;
        }
        
        if ( checkpositionavailability( level.’-ªP}·¢‘y:k8¨&£.locations[ var2 ] ) )
        {
            thread ref_1368b( level, level.’-ªP}·¢‘y:k8¨&£.locations[ var2 ] );
            var3 = level.’-ªP}·¢‘y:k8¨&£.locations[ var2 ];
            continue;
        }
        
        var0++;
    }
    
    wait 0.05;
    level.’-ªP}·¢‘y:k8¨&£.¸ÚÁùU¿_ÙÔOğƒ = scripts\engine\utility::array_randomize( level.’-ªP}·¢‘y:k8¨&£.¸ÚÁùU¿_ÙÔOğƒ );
    
    for ( var2 = 0; var2 < var1 ; var2++ )
    {
        waitframe();
        thread ref_1368b( level, level.’-ªP}·¢‘y:k8¨&£.¸ÚÁùU¿_ÙÔOğƒ[ var2 ] );
    }
    
LOC_0000011f:
    level.’-ªP}·¢‘y:k8¨&£.£à“YÙKŞ®æ×ÛlXÒ{›› = var3;
    wait 6 - level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.„/óSˆÀ…-º¼à‡" - 0.05;
    scripts\mp\gametypes\br_gametype_olaride::startshake( level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.Šâ›H³Ohµh-Ÿ°ã[, level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.„/óSˆÀ…-º¼à‡", 0, ( 8387, 15066, 8191 ), level.½œ»ŞyŒ‡ÓHĞß1˜Xµr.±™Hs± ãæ…û« );
    scripts\engine\utility::exploder( "lava_bomb_volcano_explosion" );
}

// Params 2
// Size: 0x12e
function ref_1368b( var0, var1 )
{
    var2 = ( 8387, 15066, 8191 );
    var3 = spawn( "script_model", var2 );
    
    if ( var1 )
    {
        var4 = ref_11a9f( var0, 1000, 12, 2 );
        var3.circleent = var4;
        var5 = scripts\common\utility::playersincylinder( var0, 2000 );
        
        foreach ( var7 in var5 )
        {
            if ( !isdefined( var7 ) || !scripts\mp\utility\player::isreallyalive( var7 ) )
            {
                continue;
            }
            
            scripts\mp\gametypes\br_killstreaks::isbrsquadleader( var7, "fafir_strike", 0 );
            var7 playsoundtoplayer( "lava_rock_incoming_warning", var7 );
        }
    }
    
    wait 6;
    var3 setmodel( "ks_fafir_br" );
    var3 dontinterpolate();
    var3 unmarkkeyframedmover( 1 );
    var9 = distance2d( var2, var0 );
    var10 = calculaterockthrowvalues( var9 );
    var11 = var10[ 0 ];
    var12 = var10[ 1 ];
    var10 = undefined;
    var13 = var9 / var11;
    var14 = -1 * var12;
    var15 = trajectorycalculateinitialvelocity( var3.origin, var0, ( 0, 0, var14 ), var13 );
    var3 movegravity( var15, var13, var12 );
    var3 setscriptablepartstate( "trail", "active", 0 );
    wait var13;
    var3 setscriptablepartstate( "trail", "neutral", 0 );
    var3.origin = var0;
    waitframe();
    thread projectileimpact( var3, var13, var1 );
}

// Params 3
// Size: 0x95
function projectileimpact( var0, var1, var2 )
{
    self setscriptablepartstate( "explode", "active", 0 );
    doinstantdamagezone( level.’-ªP}·¢‘y:k8¨&£.±«ÈF§ÿùoY)è—à/Zî˜P £w, var2 );
    
    if ( var1 )
    {
        thread rocksetupfumes( var2 );
        
        if ( isdefined( level.’-ªP}·¢‘y:k8¨&£.brushmodel ) )
        {
            self.¯YíTX‹sï…×šE¨ü = spawn( "script_model", var2 + ( 0, 0, 75 ) );
            self.¯YíTX‹sï…×šE¨ü.angles = ( 90, 0, 0 );
            self.¯YíTX‹sï…×šE¨ü clonebrushmodeltoscriptmodel( level.’-ªP}·¢‘y:k8¨&£.brushmodel );
            return;
        }
        
        return;
    }
    
    wait var0;
    self delete();
}

// Params 4
// Size: 0x29
function ref_11a9f( var0, var1, var2, var3 )
{
    var4 = getmaxobjectivecount( var0[ 0 ], var0[ 1 ], var1 );
    var4 setmapcirclecolorindex( var2 );
    var4 setmapcircleiconindex( 21 );
    var4 setmapcirclestyleindex( var3 );
    return var4;
}

// Params 1
// Size: 0xa9
function calculaterockthrowvalues( var0 )
{
    var1 = level.’-ªP}·¢‘y:k8¨&£.“g¹:“´µY×Í²Ê‘µVF9sÎV;
    var2 = level.’-ªP}·¢‘y:k8¨&£.¦ñ#ƒóggÿÍA‹@Å2yI“'¸@?;
    
    if ( var0 > level.’-ªP}·¢‘y:k8¨&£.­Üè'K­²×–;†“›³Ê )
    {
        var1 = level.’-ªP}·¢‘y:k8¨&£.›5ı*sbB?k“½‹(Îeÿ3;
        var2 = level.’-ªP}·¢‘y:k8¨&£.—Ö§súû£))ˆ£SÛ™#·a»_Øñ[;
    }
    else if ( var0 > level.’-ªP}·¢‘y:k8¨&£.‘°:kp‰jeoWq–²ö°Ñ )
    {
        var1 = level.’-ªP}·¢‘y:k8¨&£.“g¹:“´µY×Í²Ê‘µVF9sÎV;
        var2 = level.’-ªP}·¢‘y:k8¨&£.¦ñ#ƒóggÿÍA‹@Å2yI“'¸@?;
    }
    else if ( var0 > level.’-ªP}·¢‘y:k8¨&£.–ùÇá>’kĞõ=3@©Zk )
    {
        var1 = level.’-ªP}·¢‘y:k8¨&£.oæÑäKÖ¬}ÍÁ•ÊÈ6íİÉ°æÙY;
        var2 = level.’-ªP}·¢‘y:k8¨&£.¦ÂóËL¿“¨Lb¢ä Ôó9?w:yj;
    }
    
    return [ var1, var2 ];
}

// Params 0
// Size: 0x19
function destroycrate()
{
    if ( isdefined( self.molotov_delete_oldest_trigger ) )
    {
        self.molotov_delete_oldest_trigger delete();
    }
    
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

// Params 1
// Size: 0x134
function rocksetupfumes( var0 )
{
    var1 = spawn( "script_model", var0 );
    var1 setmodel( "ks_fafir_br" );
    waitframe();
    var1.origin = var0;
    var1.height = scripts\cp_mp\parachute::getc130height() * 2;
    var1.initialwinningteam = 0;
    var1.ref_129e0 = int( level.’-ªP}·¢‘y:k8¨&£.¦•åÈ/9Óğ šKÇ€¿0 );
    var1.ref_129e1 = int( level.’-ªP}·¢‘y:k8¨&£.¯•Ÿğ VŸûùARoÈÌæ );
    var1.ref_129df = var1.ref_129e1;
    var1.circleent = self.circleent;
    var1.Š“{6m = self;
    var1.sfx_infil_hackney_heli2_rope = 0;
    thread begincountdown();
    
    if ( getdvarint( "scr_fafir_use_hotspots_for_lava_bombs", 0 ) )
    {
        var2 = getdvarfloat( "scr_fafir_outer_visionset_outer_radius_factor", 4 );
        var3 = getdvarfloat( "scr_fafir_outer_visionset_inner_radius_factor", 3 );
        var4 = getdvarfloat( "scr_fafir_inner_visionset_outer_radius_factor", 0.5 );
        var5 = getdvarfloat( "scr_fafir_inner_visionset_inner_radius_factor", 0.5 );
        function_0448( var0, "lava_bomb_near_gas", var1.ref_129e0 * var2, var1.ref_129e1 * var3, level.’-ªP}·¢‘y:k8¨&£.7µU[éßË8X÷,`›b );
        waitframe();
        function_0448( var0, "lava_bomb_in_gas", var1.ref_129e0 * var4, var1.ref_129e0 * var4 - 1, level.’-ªP}·¢‘y:k8¨&£.7µU[éßË8X÷,`›b );
    }
    
    return var1;
}

// Params 0
// Size: 0x9e
function begincountdown()
{
    level endon( "game_ended" );
    self endon( "fumes_dissipate" );
    self.Š“{6m.circleent setmapcirclestyleindex( 0 );
    scripts\mp\gametypes\br_quest_util::init_tactical_boxes( 12, 0, 1, self.origin );
    scripts\mp\gametypes\br_quest_util::ref_13369();
    scripts\mp\gametypes\br_quest_util::ref_1316f( self.ref_129e0 );
    var0 = ( 0, 0, self.height / 2 );
    var1 = self.origin - var0;
    self.trigger = spawn( "trigger_radius", var1, 0, self.ref_129e0, self.height );
    scripts\mp\utility\trigger::makeenterexittrigger( self.trigger, &ref_12027, &ref_12030, undefined, undefined, &ref_13da5 );
    self.trigger.…ù	Q#®Íˆ = self;
    wait 5;
    thread spreadfumes();
}

// Params 0
// Size: 0xfe
function spreadfumes()
{
    level endon( "game_ended" );
    self endon( "fumes_dissipate" );
    self.sfx_infil_hackney_heli2_rope = 1;
    var0 = playfx( scripts\engine\utility::getfx( "vfx_lava_bomb_gas_explosion" ), self.origin );
    thread track_target_group_complete();
    self.onscavengerbagpickup = gettime();
    thread dissipate();
    var1 = 0;
    
    for ( ;; )
    {
        var2 = gettime();
        var3 = ( var2 - self.onscavengerbagpickup ) / 1000;
        var1 = var3 / level.’-ªP}·¢‘y:k8¨&£.™ëc¯ÃCæ–F»rp0HS·çm?=;
        var1 = clamp( var1, 0, 1 );
        self.ref_129df = self.ref_129e1 * ( 1 - var1 ) + self.ref_129e0 * var1;
        self.angles = ( 0, var1 * 179, 0 );
        var4 = 1;
        var5 = self.height;
        var6 = 0.4;
        var7 = var1 * self.height * var6;
        self.initialwinningteam = clamp( var7, var4, var5 );
        self.circleent.origin = ( self.circleent.origin[ 0 ], self.circleent.origin[ 1 ], self.ref_129df );
        waitframe();
    }
}

// Params 2
// Size: 0x110
function doinstantdamagezone( var0, var1 )
{
    wait 0.15;
    radiusdamage( var1, var0, 200, 200, self, "MOD_EXPLOSIVE", "lava_bomb_mp", 0, 1, 1 );
    
    if ( getdvarint( "scr_br_fafir_damage_vehicles", 1 ) )
    {
        var2 = tablesort( self.origin + ( 0, 0, -100 ), var0, 400 );
        
        foreach ( var4 in var2 )
        {
            if ( isalive( var4 ) && var4.health > 1 )
            {
                var4 dodamage( var4.health, self.origin, self, self, "MOD_CRUSH" );
            }
        }
    }
    
    var6 = float( var0 * var0 );
    
    if ( isdefined( level.cratedata ) && isdefined( level.cratedata.crates ) )
    {
        foreach ( var8 in level.cratedata.crates )
        {
            if ( isdefined( var8 ) )
            {
                var9 = distance2dsquared( var8.origin, self.origin );
                
                if ( var9 < var6 )
                {
                    thread destroycrate();
                }
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0xe2
function dissipate()
{
    level endon( "game_ended" );
    wait level.’-ªP}·¢‘y:k8¨&£.7µU[éßË8X÷,`›b;
    level.’-ªP}·¢‘y:k8¨&£.instances = scripts\engine\utility::array_remove( level.’-ªP}·¢‘y:k8¨&£.instances, self );
    
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) && updatelocationbesttimehud( var1, self ) && isalive( var1 ) )
        {
            deregisterallclientvfx( var1 );
            var1 notify( "lava_bomb_exit" );
            exitdamagetick( var1, self.trigger.…ù	Q#®Íˆ );
            setplayergasvfxactive( var1, 0 );
        }
    }
    
    self.trigger delete();
    wait 0.5;
    self.Š“{6m.¯YíTX‹sï…×šE¨ü delete();
    self.Š“{6m delete();
    self.mapcircle delete();
    self.circleent delete();
    track_settings();
    self notify( "fumes_dissipate" );
    self delete();
}

// Params 1
// Size: 0x54
function setplayergasvfxactive( var0 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( self.¹ß£ï±¥ ‚j¹óp·ş< ) )
    {
        stopfxontagforclients( scripts\engine\utility::getfx( "vfx_lava_bomb_gas_cloud_player" ), self, "j_head", self );
        self.¹ß£ï±¥ ‚j¹óp·ş< = undefined;
    }
    
    if ( var0 )
    {
        self.¹ß£ï±¥ ‚j¹óp·ş< = scripts\engine\utility::getfx( "vfx_lava_bomb_gas_cloud_player" );
        playfxontagforclients( self.¹ß£ï±¥ ‚j¹óp·ş<, self, "j_head", self );
        return;
    }
}

// Params 1
// Size: 0xa8
function deregisterallclientvfx( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = var0 getentitynumber();
    var2 = 4;
    var3 = 0;
    
    if ( !isdefined( self.ref_124ff ) )
    {
        return;
    }
    
    if ( !isdefined( self.ref_124ff[ var1 ] ) )
    {
        return;
    }
    
    foreach ( var5 in self.ref_124ff[ var1 ] )
    {
        var6 = var5[ 0 ];
        var7 = var5[ 1 ];
        var8 = var5[ 2 ];
        var9 = stopfxontagforclients( var6, var7, var8, var0 );
        var10 = isplayer( var7 ) || isbot( var7 ) || isagent( var7 );
        
        if ( !var10 )
        {
            var7 delete();
        }
        
        var3++;
        
        if ( var3 >= 4 )
        {
            var3 = 0;
            waitframe();
        }
    }
}

// Params 0
// Size: 0x91
function track_target_group_complete()
{
    level endon( "game_ended" );
    self endon( "fumes_dissipate" );
    self.ref_142a3 = [];
    self.ref_142a4 = [];
    waitframe();
    self.track_get_teleport_velocity = gettime();
    self.track_get_teleport_target = self.track_get_teleport_velocity + level.’-ªP}·¢‘y:k8¨&£.7µU[éßË8X÷,`›b * 1000;
    thread track_timer_think();
    
    for ( ;; )
    {
        var0 = gettime();
        var1 = ( var0 - self.track_get_teleport_velocity ) / 1000;
        var2 = var1 / level.’-ªP}·¢‘y:k8¨&£.™ëc¯ÃCæ–F»rp0HS·çm?=;
        var2 = clamp( var2, 0, 1 );
        self.ref_129df = self.ref_129e1 * ( 1 - var2 ) + self.ref_129e0 * var2;
        waitframe();
    }
}

// Params 0
// Size: 0x115
function track_timer_think()
{
    var0 = spawnstruct();
    var1 = self.ref_129e0;
    var0.ref_11a58 = self.origin + ( var1 * -1, var1 * -1, 0 );
    var0.ref_11a59 = self.origin + ( var1, var1 * -1, 0 );
    var0.ref_14039 = self.origin + ( var1 * -1, var1, 0 );
    var0.ref_1403a = self.origin + ( var1, var1, 0 );
    var2 = level.’-ªP}·¢‘y:k8¨&£.¯	»í@p±“©NÈôI!S‰h³ê‹÷§ÇÃ˜h;
    var3 = self.ref_129e0 * 2;
    var4 = var3 / var2;
    var5 = ( self.origin[ 0 ] - self.ref_129e0, self.origin[ 1 ] - self.ref_129e0, 0 );
    trackcarpunches( self.origin );
    
    for ( var6 = 0; var6 < var2 ; var6++ )
    {
        for ( var7 = 0; var7 < var2 ; var7++ )
        {
            var8 = var4 * var6;
            var9 = ( var8, 0, 0 );
            var10 = var4 * var7;
            var11 = ( 0, var10, 0 );
            var12 = var5 + var9 + var11;
            
            if ( distance2d( var12, self.origin ) < self.ref_129e0 )
            {
                trackcarpunches( var12 );
            }
        }
    }
    
    track_last_good_position();
}

// Params 1
// Size: 0x7e
function trackcarpunches( var0 )
{
    var1 = spawnstruct();
    var1.index = self.ref_142a3.size;
    var1.origin = var0;
    var1.angles = ( 0, 0, 0 );
    var1.state = "valid";
    var1.parent = undefined;
    var1.ref_14293 = undefined;
    var2 = distance( var1.origin, self.origin );
    var1.loot_getitemcountlefthand = self.ref_129e0 - var2;
    self.ref_142a3[ self.ref_142a3.size ] = var1;
}

// Params 0
// Size: 0x67
function track_last_good_position()
{
    trackcashevent( self.ref_142a3[ 0 ] );
    
    foreach ( var1 in self.ref_142a3 )
    {
        if ( var1.state != "valid" )
        {
            continue;
        }
        
        var2 = 150;
        
        if ( var1.loot_getitemcountlefthand <= var2 )
        {
            continue;
        }
        
        trackcashevent( var1 );
    }
}

// Params 1
// Size: 0x17b
function trackcashevent( var0 )
{
    if ( var0.state != "valid" )
    {
        return;
    }
    
    var0.state = "selected";
    var1 = physics_createcontents( [ "physicscontents_solid", "physicscontents_water" ] );
    var2 = ( 0, 0, 100000 );
    var3 = var0.origin + var2;
    var4 = var0.origin - var2;
    var5 = [];
    var6 = physics_raycast( var3, var4, var1, var5, 0, "physicsquery_closest", 1 );
    var7 = var0.origin;
    
    if ( isdefined( var6 ) && var6.size > 0 )
    {
        var7 = var6[ 0 ][ "position" ];
    }
    
    var8 = scripts\engine\utility::ter_op( var0.loot_getitemcountlefthand < 3000, 200, 1500 );
    var0.ref_14293 = spawnfx( scripts\engine\utility::getfx( "vfx_lava_bomb_gas_cloud_distant" ), var7 + ( 0, 0, randomfloatrange( 0, var8 ) ) );
    
    if ( level.’-ªP}·¢‘y:k8¨&£.YSÿ!O[oBGñø¨cfhË´è1EÍ[¹@uñ )
    {
        var0.ref_14293 unmarkkeyframedmover( 1 );
    }
    
    self.ref_142a4[ self.ref_142a4.size ] = var0;
    var9 = risk_flagspawncount();
    
    foreach ( var11 in self.ref_142a3 )
    {
        if ( var11.state != "valid" )
        {
            continue;
        }
        
        var12 = distance2d( var0.origin, var11.origin );
        
        if ( var12 <= level.’-ªP}·¢‘y:k8¨&£.ªxg ø9[Œ‹y2E@å»™Hó_³ÁÃ	~—ÎJ³ˆO )
        {
            var11.parent = var0;
            var11.state = "occupied";
            var11.color = var9;
        }
    }
    
    thread track_is_operational( var0 );
}

// Params 1
// Size: 0x51
function track_is_operational( var0 )
{
    level endon( "game_ended" );
    var0 endon( "fumes_dissipate" );
    
    for ( ;; )
    {
        if ( scripts\engine\utility::updatescrapassistdata( self.origin, var0.origin, var0.ref_129df + 1500 ) )
        {
            if ( isdefined( self.ref_14293 ) )
            {
                triggerfx( self.ref_14293 );
            }
            
            break;
        }
        
        wait 1;
    }
}

// Params 0
// Size: 0x51
function track_settings()
{
    foreach ( var1 in self.ref_142a4 )
    {
        if ( isdefined( var1.ref_14293 ) )
        {
            var1.ref_14293 delete();
        }
    }
    
    self.ref_142a3 = [];
    self.ref_142a4 = [];
    self notify( "fumes_dissipate" );
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

// Params 2
// Size: 0x16
function ref_12027( var0, var1 )
{
    var2 = var0;
    thread damagetickwatcher( var2 );
}

// Params 2
// Size: 0x1e
function ref_12030( var0, var1 )
{
    var2 = var0;
    exitdamagetick( var2, var1.…ù	Q#®Íˆ );
    setplayergasvfxactive( var2, 0 );
}

// Params 1
// Size: 0x127
function damagetickwatcher( var0 )
{
    while ( !var0.sfx_infil_hackney_heli2_rope )
    {
        waitframe();
    }
    
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "lava_bomb_enter" );
    self endon( "lava_bomb_enter" );
    self endon( "lava_bomb_exit" );
    var0 endon( "fumes_dissipate" );
    wait 0.1;
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( updatelocationbesttimehud( var0 ) && candamageplayer() )
        {
            if ( !istrue( self.­Ú‹60ÿ“RÖyÚ—&ñç‘;§÷aºÏºé ) )
            {
                var1 = getdvarfloat( "scr_fafir_lava_bomb_visionset_in_transition_time", 1 );
                self visionsetnakedforplayer( "lava_bomb_in_gas", var1 );
                self.­Ú‹60ÿ“RÖyÚ—&ñç‘;§÷aºÏºé = 1;
                setplayergasvfxactive( 1 );
            }
            
            var2 = level.’-ªP}·¢‘y:k8¨&£.£Ij{#ˆYìC£¿pw×«82_;
            
            if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
            {
                if ( !scripts\mp\gametypes\br_pickups::ks_circlecount( self ) )
                {
                    scripts\mp\gametypes\br_pickups::plunderrepositoryref( "lava_bomb_fumes" );
                }
                
                scripts\cp_mp\gasmask::processdamage( var2 );
            }
            else
            {
                if ( scripts\mp\utility\killstreak::isjuggernaut() )
                {
                    var2 = scripts\mp\gametypes\br_jugg_common::ref_11c95( var2 );
                }
                
                var3 = self;
                
                if ( scripts\mp\gametypes\br_public::hasarmor() )
                {
                    scripts\mp\gametypes\br_public::damagearmor( var2 );
                }
                else
                {
                    self dodamage( var2, self.origin, var3, undefined, undefined, "city_killer_mp", "j_body" );
                }
                
                if ( isplayer( self ) )
                {
                    scripts\mp\gametypes\br_circle::ref_13e18();
                }
            }
        }
        else
        {
            exitdamagetick( var0 );
        }
        
        wait 1;
    }
}

// Params 1
// Size: 0x54
function exitdamagetick( var0 )
{
    if ( !isplayeroutsidealldamagezones() )
    {
        return;
    }
    
    var1 = getdvarfloat( "scr_fafir_lava_bomb_visionset_out_transition_time", 4 );
    self visionsetnakedforplayer( "", var1 );
    setplayergasvfxactive( 0 );
    self.­Ú‹60ÿ“RÖyÚ—&ñç‘;§÷aºÏºé = 0;
    
    if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
    {
        scripts\mp\gametypes\br_pickups::plunderrankupdate( "lava_bomb_fumes" );
    }
    
    if ( !isalive( self ) )
    {
        self notify( "lava_bomb_exit" );
        return;
    }
}

// Params 0
// Size: 0x73, Type: bool
function candamageplayer()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( istrue( self.start_death_from_above_sequence ) )
    {
        return false;
    }
    
    if ( istrue( self.gulag ) && istrue( self.inrespawnc130 ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::ref_125f3() && scripts\mp\gametypes\br_public::ref_125ec() )
    {
        return false;
    }
    
    if ( istrue( self.ref_14439 ) )
    {
        return false;
    }
    
    if ( istrue( self.unset_relic_thirdperson ) )
    {
        return false;
    }
    
    if ( istrue( self.gulag ) )
    {
        if ( istrue( self.gulagarena ) || istrue( self.jailed ) )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x95, Type: bool
function playerisingasvfxzheightcheck()
{
    var0 = physics_createcontents( [ "physicscontents_solid", "physicscontents_water" ] );
    var1 = ( 0, 0, 50 );
    var2 = 1;
    var3 = level.’-ªP}·¢‘y:k8¨&£.½es
Cè9-)Ü?#ó+Êh7	Ü + var2;
    var4 = self.origin + var1;
    var5 = self.origin - var3;
    var6 = [ self ];
    var7 = physics_raycast( var4, var5, var0, var6, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( var7[ 0 ] ) )
    {
        var8 = var7[ 0 ][ "position" ];
        
        if ( self.origin[ 2 ] - var8[ 2 ] < level.’-ªP}·¢‘y:k8¨&£.½es
Cè9-)Ü?#ó+Êh7	Ü )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x82, Type: bool
function updatelocationbesttimehud( var0 )
{
    var1 = playerisingasvfxzheightcheck();
    
    if ( distance( self.origin, var0.origin ) < var0.ref_129df && var1 )
    {
        return true;
    }
    
    var2 = distance2d( self.origin, var0.origin ) <= var0.ref_129df;
    var3 = var0.initialwinningteam / 2;
    var4 = abs( var0.origin[ 2 ] - self.origin[ 2 ] ) <= var0.initialwinningteam / 2;
    
    if ( var2 && var1 )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x88, Type: bool
function isplayeroutsidealldamagezones()
{
    var0 = 0;
    
    foreach ( var2 in level.’-ªP}·¢‘y:k8¨&£.instances )
    {
        if ( !isdefined( var2.trigger ) )
        {
            continue;
        }
        
        if ( scripts\engine\utility::array_contains( var2.trigger.triggerenterents, self ) )
        {
            var3 = updatelocationbesttimehud( var2 );
            
            if ( !var3 )
            {
                var0++;
            }
        }
    }
    
    return level.’-ªP}·¢‘y:k8¨&£.instances.size == var0 || level.’-ªP}·¢‘y:k8¨&£.instances.size == 0;
}

// Params 2
// Size: 0x20, Type: bool
function ref_13da5( var0, var1 )
{
    if ( isplayer( var0 ) || isbot( var0 ) || isagent( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0xb9
function circlewatcher()
{
    level endon( "game_ended" );
    jumpiffalse(!isdefined( level.br_circle ) || istrue( level.br_circle_disabled )) LOC_0000001d;
    return;
}

// Params 2
// Size: 0x67, Type: bool
function ispointinsafelocation( var0, var1 )
{
    var2 = level.br_level.default_class_chosen[ level.br_circle.circleindex + 1 ];
    var3 = float( level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ] );
    
    if ( !isdefined( var2 ) || !isdefined( var3 ) )
    {
        return false;
    }
    
    var4 = distance2dsquared( var0, var2 );
    var5 = var3 - var1;
    
    if ( var4 < var5 * var5 )
    {
        return true;
    }
    
    return false;
}

