
// Params 0
// Size: 0x3d, Type: bool
function vehicle_damage_loadtable()
{
    if ( isdefined( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè ) )
    {
        return false;
    }
    
    if ( level.script == "mp_wz_island" && scripts\mp\utility\game::round_vehicle_logic() == "olaride" )
    {
        return false;
    }
    
    if ( level.script == "mp_wz_island" )
    {
        return true;
    }
    
    return false;
}

#using_animtree( "" );

// Params 1
// Size: 0x8ab
function vehicle_damage_getpristinestateminhealth( var0 )
{
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = puddle_triggers();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var1 = getdvarfloat( "scr_br_end_transient_wait", 7 );
        var2 = 1.71429;
        thread vehicle_damage_getpristinestatehealthadd( level );
        wait var1;
    }
    
    vehicle_damage_getinstancedataforvehicle();
    var3 = scripts\mp\gametypes\br_ending::ref_135ca( "lm_egy_aec_matador_01_exfil" );
    self.onpickupitem = var3;
    vehicle_damage_getstate();
    var4 = [ "head_mp_helicopter_crew", "j_spine4" ];
    var5 = [ var4 ];
    var6 = "body_pilot_helicopter_british";
    var7 = scripts\mp\gametypes\br_ending::ref_135ca( var6, undefined, var5 );
    self.max_ammo_check = var7;
    var8 = [ "head_mp_aus_s4_lucas_02_1a_exfil", "j_spine4" ];
    var9 = [ var8 ];
    var10 = "body_mp_aus_s4_lucas_01_inctv";
    var11 = scripts\mp\gametypes\br_ending::ref_135ca( var10, undefined, var9 );
    self.driver = var11;
    var12 = scripts\mp\gametypes\br_ending::ref_135ca( "tag_origin" );
    self.playerzombieisingas = var12;
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        scripts\mp\gametypes\br_ending::init_death_animations( self );
    }
    
    self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
    self.ref_142d0 = "mp_wz_island_exfil";
    
    if ( scripts\mp\utility\game::round_vehicle_logic() == "mendota" )
    {
        self.ref_142d0 = "mp_wz_island_exfil_mendota";
    }
    
    level._effect[ "vfx_exfil2_light_orangefixture_01" ] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_01" );
    level._effect[ "vfx_exfil2_light_orangefixture_02" ] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_02" );
    level._effect[ "vfx_exfil2_light_windowlights" ] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_windowlights" );
    level._effect[ "vfx_exfil2_light_dashboardlight" ] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_dashboardlight" );
    
    if ( getdvarint( "scr_br_ending_6_lighting", 0 ) == 1 )
    {
        var13 = getent( "exfil", "targetname" );
        var13 linkto( self.onpickupitem, "tag_origin", ( 5, 1, 78.5 ), ( 0, 0, 0 ) );
    }
    
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &allassassin_teams );
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    self.ref_121b8 = [];
    var14 = 0;
    
    if ( getdvarint( "scr_br_ending_6_binks", 1 ) == 1 )
    {
        self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene1" );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_dummycamera_sh010 );
        var14++;
    }
    
    self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene2" );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_givescore );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var3, $wz_ch3_exfil_truck_sh010 );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var7, %wz_ch3_exfil_doorchief_sh010 );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var11, %wz_ch3_exfil_driver_sh010 );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %wz_ch3_exfil_guy_01_sh010, %wz_ch3_exfil_guy_01_sh010 );
    
    if ( self.winners.size >= 4 )
    {
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %wz_ch3_exfil_guy_03_sh010, %wz_ch3_exfil_guy_03_sh010 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );
    }
    else if ( self.winners.size >= 3 )
    {
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );
    }
    else if ( self.winners.size >= 2 )
    {
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );
    }
    
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh010_ext );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_field_clip( "jeepExfil_gas_wall", self.origin, self.angles );
    self.ref_121b8[ var14 ].fxtag = "tag_origin";
    self.ref_121b8[ var14 ].playerzombiejumpcleanup = self.playerzombieisingas;
    var14++;
    self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene3" );
    
    if ( self.winners.size >= 2 )
    {
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_givescoreandxp );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh011_ext );
    }
    else
    {
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_givescoreandxpatframeend );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh013_solo_ext );
    }
    
    var14++;
    self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene4" );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_heavyvisualcallback );
    self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh012_ext );
    var14++;
    var15 = 1;
    
    if ( self.winners.size >= 2 )
    {
        self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene5" );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_inithitdamage );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var3, %wz_ch3_exfil_truck_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var7, %wz_ch3_exfil_doorchief_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var11, %wz_ch3_exfil_driver_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %wz_ch3_exfil_guy_02_sh020, %wz_ch3_exfil_guy_02_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p2_sh020_int );
        var15 = 2;
    }
    
    if ( self.winners.size >= 3 )
    {
        self.ref_121b8[ var14 + 1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene6" );
        self.ref_121b8[ var14 + 1 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_inithitdamage_br );
        self.ref_121b8[ var14 + 1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p3_sh021_int );
        var15 = 3;
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %wz_ch3_exfil_guy_03_sh020, %wz_ch3_exfil_guy_03_sh020 );
    }
    
    if ( self.winners.size >= 4 )
    {
        self.ref_121b8[ var14 + 2 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene7" );
        self.ref_121b8[ var14 + 2 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_initmoddamage );
        self.ref_121b8[ var14 + 2 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p4_sh022_int );
        var15 = 4;
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %wz_ch3_exfil_guy_04_sh020, %wz_ch3_exfil_guy_04_sh020 );
    }
    
    if ( var15 > 1 )
    {
        self.ref_121b8[ var14 + var15 - 1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene8" );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_isburningdown );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %wz_ch3_exfil_guy_01_sh021, %wz_ch3_exfil_guy_01_sh021 );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %wz_ch3_exfil_guy_02_sh021, %wz_ch3_exfil_guy_02_sh021 );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %wz_ch3_exfil_guy_03_sh021, %wz_ch3_exfil_guy_03_sh021 );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %wz_ch3_exfil_guy_04_sh021, %wz_ch3_exfil_guy_04_sh021 );
        self.ref_121b8[ var14 + var15 - 1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p1_sh023_mvp_int );
    }
    else
    {
        self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene9" );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( self, &vehicle_damage_lightvisualcallback );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var3, %wz_ch3_exfil_truck_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var7, %wz_ch3_exfil_doorchief_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_struct( var11, %wz_ch3_exfil_driver_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020 );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p1_sh024_solo_int );
    }
    
    var14 += var15;
    
    if ( getdvarint( "scr_br_ending_6_binks", 1 ) == 1 )
    {
        self.ref_121b8[ var14 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene10" );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::backendevent( [], &vehicle_damage_getmaxhealth );
        self.ref_121b8[ var14 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_ch3_exfil_dummycamera_sh020 );
        self.ref_121b8[ var14 ].clip_mover = 1;
        return;
    }
}

// Params 0
// Size: 0x6e
function puddle_triggers()
{
    switch ( level.script )
    {
        case "mp_donetsk2":
        case "mp_donetsk":
        case "mp_kstenod":
        case "mp_don3":
        case "mp_don4":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_quarry":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_mechanics":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_wz_island":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_tut2":
            return "mp_infil_wz_island_ending_truck_tr";
    }
    
    return undefined;
}

// Params 2
// Size: 0x44
function vehicle_damage_getmediumstatehealthratio( var0, var1 )
{
    var2 = self.origin + ( 0, 0, 1000 );
    var3 = vectornormalize( var2 - var1 );
    var4 = var2 + var3 * 3000;
    var5 = spawn( "script_model", var4 );
    var5 moveto( var2, var0 );
    wait var0;
    var5 delete();
}

// Params 1
// Size: 0xc2
function vehicle_damage_getpristinestatehealthadd( var0 )
{
    if ( level.defendkill.winners.size == 0 )
    {
        return;
    }
    
    if ( isnumber( var0 ) && var0 > 0 )
    {
        wait var0;
    }
    
    var1 = "br3_exfil_intro_3player";
    
    switch ( level.defendkill.winners.size )
    {
        case 1:
            var1 = "br3_exfil_intro_1player";
            break;
        case 2:
            var1 = "br3_exfil_intro_2player";
            break;
        case 3:
            var1 = "br3_exfil_intro_3player";
            break;
        case 4:
            var1 = "br3_exfil_intro_4player";
            break;
    }
    
    setmusicstate( var1 );
    
    foreach ( var3 in level.players )
    {
        var3 setsoundsubmix( "mp_br_exfil_fade", 4 );
    }
}

// Params 1
// Size: 0x8d
function vehicle_damage_getinstancedataforvehicle( var0 )
{
    if ( !scripts\mp\gametypes\br_public::turret_headicon() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    var1 = "br_exfil_ch3_jeep_intro_lr";
    var2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";
    
    if ( var2 )
    {
        var1 = "br_exfil_ch3_mxp_jeep_intro_lr";
    }
    
    foreach ( var4 in level.players )
    {
        var4 playlocalsound( var1 );
    }
    
    if ( var2 )
    {
        allassassin_update( "mendota_exfil_intro", 4.33, 1, 0, 1 );
        return;
    }
    
    allassassin_update( "mp_wz_ch3_exfil_intro", 4.33, 1, 0 );
}

// Params 1
// Size: 0x7b
function vehicle_damage_getmaxhealth( var0 )
{
    var1 = "br_exfil_ch3_jeep_outro_lr";
    var2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";
    
    if ( var2 )
    {
        var1 = "br_exfil_ch3_mxp_jeep_outro_lr";
    }
    
    foreach ( var4 in level.players )
    {
        var4 playlocalsound( var1 );
    }
    
    if ( var2 )
    {
        allassassin_update( "mendota_exfil_outro", 7.37, 0, 1, 1 );
        return;
    }
    
    allassassin_update( "mp_wz_ch3_exfil_outro", 7.37, 0, 1 );
}

// Params 5
// Size: 0x6d
function allassassin_update( var0, var1, var2, var3, var4 )
{
    foreach ( var6 in level.players )
    {
        if ( istrue( var3 ) )
        {
            var6 setclientomnvar( "ui_world_fade", 1 );
        }
        
        var6 setclientomnvar( "ui_br_bink_overlay_state", 10 );
    }
    
    playcinematicforall( var0, 1, istrue( var4 ) );
    wait 0.1;
    
    if ( istrue( var3 ) )
    {
        allies_push_up();
        allassassin_timeout_end( var1 );
        return;
    }
}

// Params 2
// Size: 0xb9
function allassassin_timeout_end( var0, var1 )
{
    if ( istrue( var1 ) )
    {
        foreach ( var3 in level.players )
        {
            var3 scripts\mp\gametypes\br_public::ref_1252b();
        }
    }
    
    wait var0;
    stopcinematicforall( 1 );
    
    if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
    {
        logstring( "bnk__jeepExfil_bink_play_end()" );
    }
    
    foreach ( var3 in level.players )
    {
        if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
        {
            logstring( "bnk_Player " + var3.name + " ui_br_bink_overlay_state : " + var3 calloutmarkerping_entityzoffset( "ui_br_bink_overlay_state", 0 ) );
        }
        
        var3 setclientomnvar( "ui_br_bink_overlay_state", 0 );
    }
}

// Params 2
// Size: 0x18
function allassassin_teams( var0, var1 )
{
    if ( var0 == "bink_complete" )
    {
        level notify( "bink_complete" );
        return;
    }
}

// Params 2
// Size: 0x1a
function allies_respawns( var0, var1 )
{
    wait var0;
    setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
    waitframe();
    preloadcinematicforall( var1, 1, 0 );
}

// Params 0
// Size: 0xc8
function allies_push_up()
{
    foreach ( var1 in level.players )
    {
        var1 playerhide();
    }
    
    if ( isdefined( level.defendkill.playerzombieisingas ) )
    {
        stopfxontag( scripts\engine\utility::getfx( "jeepExfil_gas_wall" ), level.defendkill.playerzombieisingas, "tag_origin" );
        level.defendkill.playerzombieisingas delete();
    }
    
    allfobtriggers();
    
    if ( isdefined( level.defendkill.onpickupitem ) )
    {
        level.defendkill.onpickupitem delete();
    }
    
    if ( isdefined( level.defendkill.max_ammo_check ) )
    {
        level.defendkill.max_ammo_check delete();
    }
    
    if ( isdefined( level.defendkill.driver ) )
    {
        level.defendkill.driver delete();
        return;
    }
}

// Params 4
// Size: 0x1c
function allassassin_update_timed( var0, var1, var2, var3 )
{
    var1 endon( var2 + "_end" );
    
    for ( ;; )
    {
        playfxontag( var0, var1, var2 );
        wait var3;
    }
}

// Params 2
// Size: 0xf
function allassassin_updatewait( var0, var1 )
{
    var0 notify( var1 + "_end" );
}

// Params 0
// Size: 0x74
function allassassin_updatecircle()
{
    thread allassassin_update_timed( level._effect[ "vfx_exfil2_light_orangefixture_01" ], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX", 0.5 );
    thread allassassin_update_timed( level._effect[ "vfx_exfil2_light_orangefixture_02" ], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX", 0.5 );
    thread allassassin_update_timed( level._effect[ "vfx_exfil2_light_windowlights" ], level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX", 0.5 );
}

// Params 0
// Size: 0x44
function allfobtriggers()
{
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX" );
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX" );
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX" );
}

// Params 1
// Size: 0x31
function vehicle_damage_givescore( var0 )
{
    if ( !scripts\mp\gametypes\br_public::turret_headicon() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    thread vehicle_damage_giveaward();
    thread allassassin_timeout_end( 0.15, 1 );
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 40 );
}

// Params 0
// Size: 0xa2
function vehicle_damage_giveaward()
{
    if ( level.defendkill.winners.size == 0 )
    {
        return;
    }
    
    var0 = "br_exfil_ch3_jeep_3person_lr";
    
    switch ( level.defendkill.winners.size )
    {
        case 1:
            var0 = "br_exfil_ch3_jeep_1person_lr";
            break;
        case 2:
            var0 = "br_exfil_ch3_jeep_2person_lr";
            break;
        case 3:
            var0 = "br_exfil_ch3_jeep_3person_lr";
            break;
        case 4:
            var0 = "br_exfil_ch3_jeep_4person_lr";
            break;
    }
    
    foreach ( var2 in level.players )
    {
        var2 playlocalsound( var0 );
    }
}

// Params 1
// Size: 0x11
function vehicle_damage_givescoreandxp( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 55 );
    allassassin_updatecircle();
}

// Params 1
// Size: 0x11
function vehicle_damage_givescoreandxpatframeend( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 60 );
    allassassin_updatecircle();
}

// Params 1
// Size: 0xc
function vehicle_damage_heavyvisualcallback( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 50 );
}

// Params 1
// Size: 0x21
function vehicle_damage_inithitdamage( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 55 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
}

// Params 1
// Size: 0x21
function vehicle_damage_inithitdamage_br( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 50 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
}

// Params 1
// Size: 0x21
function vehicle_damage_initmoddamage( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 55 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
}

// Params 1
// Size: 0x21
function vehicle_damage_isburningdown( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 60 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
}

// Params 1
// Size: 0x21
function vehicle_damage_lightvisualcallback( var0 )
{
    scripts\mp\gametypes\br_ending::brking_onplayerkilled( 65 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
}

// Params 1
// Size: 0x4
function vehicle_damage_loadtablecell( var0 )
{
    
}

// Params 1
// Size: 0x4
function vehicle_damage_mediumvisualcallback( var0 )
{
    
}

// Params 0
// Size: 0x42
function vehicle_damage_getstate()
{
    if ( !isdefined( level.br_circle ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return;
    }
    
    level.br_circle.dangercircleent brcirclemoveto( self.origin[ 0 ], self.origin[ 1 ], 9000, 0.05 );
}

// Params 0
// Size: 0x3e
function vehicle_damage_mp_init()
{
    level._effect[ "jeepExfil_rotorwash" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx" );
    level._effect[ "player_disconnect" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx" );
    level._effect[ "jeepExfil_gas_wall" ] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_gas_wall.vfx" );
}

