
// Params 0
// Size: 0x2b
function get_olarideexfil_transient()
{
    switch ( level.script )
    {
        case "mp_br_mechanics":
            return "mp_infil_wz_island_ending_olaride_tr";
        case "mp_wz_island":
            return "mp_infil_wz_island_ending_olaride_tr";
    }
    
    return undefined;
}

// Params 0
// Size: 0x5d
function olarideexfil_loadtransient()
{
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = get_olarideexfil_transient();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var0 = getdvarfloat( "scr_br_end_transient_wait", level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ß@Su=JÁàÒ´6H¯$“Å„ );
        thread olarideexfil_fadetoblack( var0 - 1, 0.9, 1.5, 0.75, 1 );
        wait var0;
        return;
    }
}

// Params 2
// Size: 0x61
function olarideexfil_set_brcircle( var0, var1 )
{
    if ( !isdefined( level.br_circle ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return;
    }
    
    waitframe();
    var2 = ( self.origin + self.gameending.origin ) / 2;
    var3 = distance2d( var2, self.gameending.origin ) + var0;
    level.br_circle.dangercircleent brcirclemoveto( var2[ 0 ], var2[ 1 ], var3, var1 );
}

// Params 0
// Size: 0x202
function olarideexfil_music_sfx_start()
{
    level endon( "game_ended" );
    
    if ( self.winners.size == 0 )
    {
        return;
    }
    
    var0 = level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.°^Ö@£ô[€–pÇ6£);
    var1 = "mus_br3_olaride_exfill_heroes_3_players_intro";
    var2 = "br_exfil_olaride_heroes_part1_3person_lr";
    var3 = "br_exfil_olaride_heroes_part2_lr";
    
    if ( var0 == "heroes" )
    {
        var3 = "br_exfil_olaride_heroes_part2_lr";
        
        switch ( self.winners.size )
        {
            case 1:
                var1 = "mus_br3_olaride_exfill_heroes_1_player_intro";
                var2 = "br_exfil_olaride_heroes_part1_1person_lr";
                break;
            case 2:
                var1 = "mus_br3_olaride_exfill_heroes_2_players_intro";
                var2 = "br_exfil_olaride_heroes_part1_2person_lr";
                break;
            case 3:
                var1 = "mus_br3_olaride_exfill_heroes_3_players_intro";
                var2 = "br_exfil_olaride_heroes_part1_3person_lr";
                break;
            case 4:
                var1 = "mus_br3_olaride_exfill_heroes_4_players_intro";
                var2 = "br_exfil_olaride_heroes_part1_4person_lr";
                break;
        }
    }
    else if ( var0 == "villains" )
    {
        var3 = "br_exfil_olaride_villains_part2_lr";
        
        switch ( self.winners.size )
        {
            case 1:
                var1 = "mus_br3_olaride_exfill_villains_1_player_intro";
                var2 = "br_exfil_olaride_villains_part1_1person_lr";
                break;
            case 2:
                var1 = "mus_br3_olaride_exfill_villains_2_players_intro";
                var2 = "br_exfil_olaride_villains_part1_2person_lr";
                break;
            case 3:
                var1 = "mus_br3_olaride_exfill_villains_3_players_intro";
                var2 = "br_exfil_olaride_villains_part1_3person_lr";
                break;
            case 4:
                var1 = "mus_br3_olaride_exfill_villains_4_players_intro";
                var2 = "br_exfil_olaride_villains_part1_4person_lr";
                break;
        }
    }
    
    foreach ( var5 in level.players )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 playlocalsound( var2 );
        var5 playlocalsound( var1 );
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( var5 in level.players )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 setsoundsubmix( "mp_br_exfil_fade_olaride", 4 );
    }
    
    level waittill( "shot_080_started" );
    
    foreach ( var5 in level.players )
    {
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var5 playlocalsound( var3 );
    }
}

// Params 0
// Size: 0x1b
function olarideexfil_setupchopper()
{
    var0 = scripts\mp\gametypes\br_ending::ref_135ca( "veh8_mil_air_blima_scriptmodel" );
    var0 unmarkkeyframedmover( 1 );
    self.onkillingblow = var0;
}

// Params 1
// Size: 0xbe
function olarideexfil_choppershowrotors( var0 )
{
    var1 = level.defendkill.onkillingblow;
    
    if ( isdefined( var1 ) )
    {
        if ( istrue( var0 ) )
        {
            var1 showpart( "tag_main_rotor_blade_01" );
            var1 showpart( "tag_main_rotor_blade_02" );
            var1 showpart( "tag_main_rotor_blade_03" );
            var1 showpart( "tag_main_rotor_blade_04" );
            var1 showpart( "tag_tail_rotor_blade_01" );
            var1 showpart( "tag_tail_rotor_blade_02" );
            var1 showpart( "tag_tail_rotor_blade_03" );
            var1 showpart( "tag_tail_rotor_blade_04" );
            return;
        }
        
        var1 hidepart( "tag_main_rotor_blade_01" );
        var1 hidepart( "tag_main_rotor_blade_02" );
        var1 hidepart( "tag_main_rotor_blade_03" );
        var1 hidepart( "tag_main_rotor_blade_04" );
        var1 hidepart( "tag_tail_rotor_blade_01" );
        var1 hidepart( "tag_tail_rotor_blade_02" );
        var1 hidepart( "tag_tail_rotor_blade_03" );
        var1 hidepart( "tag_tail_rotor_blade_04" );
        return;
    }
}

// Params 0
// Size: 0x24
function olarideexfil_updatewinners()
{
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        scripts\mp\gametypes\br_ending::init_death_animations( self );
        return;
    }
}

// Params 0
// Size: 0x9e
function olarideexfil_fx_init()
{
    var0 = level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.°^Ö@£ô[€–pÇ6£);
    level._effect[ "player_disconnect" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx" );
    level._effect[ "olarideExfil_rotorwash" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_blima_rotor.vfx" );
    
    if ( var0 == "heroes" )
    {
        level._effect[ "olarideHeroesExfil_contrail" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_contrail.vfx" );
        level._effect[ "olarideHeroesExfil_trail" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_wing_trail.vfx" );
        return;
    }
    
    if ( var0 == "villains" )
    {
        level._effect[ "olarideVillainsExfil_bomb" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_bomb_sml_runner.vfx" );
        level._effect[ "vfx_tracer_front_straight" ] = loadfx( "vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_tracer_front_straight" );
        return;
    }
}

// Params 1
// Size: 0x38
function olarideexfil_setwind( var0 )
{
    foreach ( var2 in self.winners )
    {
        if ( isdefined( var2 ) )
        {
            var2 scripts\mp\utility\player::ref_1328c( var0, 1 );
        }
    }
}

// Params 0
// Size: 0x23
function olaridechopper_playfx()
{
    self endon( "death" );
    wait 0.1;
    playfxontag( scripts\engine\utility::getfx( "olarideExfil_rotorwash" ), self, "tag_origin" );
}

// Params 1
// Size: 0xc4
function olarideexfil_deleteloot( var0 )
{
    var1 = 50000;
    var2 = canceljoins( undefined, undefined, var0, var1 );
    
    if ( isdefined( var2 ) )
    {
        foreach ( var4 in var2 )
        {
            if ( !scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc( var4, 1 ) )
            {
                continue;
            }
            
            if ( var4 getscriptableisreserved() && !isdefined( var4.embassy_main ) )
            {
                continue;
            }
            
            var5 = undefined;
            
            if ( scripts\mp\gametypes\br_pickups::islootcache( var4 ) )
            {
                var5 = "body";
            }
            
            scripts\mp\gametypes\br_pickups::ref_11a21( var4, var5 );
        }
    }
    
    if ( isdefined( level.delete_pipe_ents.scriptables ) )
    {
        foreach ( var8 in level.delete_pipe_ents.scriptables )
        {
            if ( isdefined( var8 ) )
            {
                var8 delete();
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0x89
function olarideexfil_setuphudelement( var0 )
{
    var0.x = 0;
    var0.y = 0;
    var0 setshader( "black", 640, 480 );
    var0.alignx = "left";
    var0.aligny = "top";
    var0.horzalign = "fullscreen";
    var0.vertalign = "fullscreen";
    var0.sort = -1;
    var0.color = ( 0.15, 0.15, 0.15 );
    var0.alpha = 0;
    var0 sendcollectedclientanticheatdata( 1 );
}

// Params 5
// Size: 0x7f
function olarideexfil_fadetoblack( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    if ( isdefined( level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ ) )
    {
        return;
    }
    
    level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ = newhudelem();
    olarideexfil_setuphudelement( level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ );
    
    if ( isdefined( var1 ) )
    {
        level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ fadeovertime( var1 );
        level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@.alpha = 1;
        wait var1;
    }
    
    if ( isdefined( var2 ) )
    {
        wait var2;
    }
    
    if ( isdefined( var3 ) )
    {
        level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ fadeovertime( var3 );
        level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@.alpha = 0;
        wait var3;
    }
    
    if ( istrue( var4 ) )
    {
        level.õ;(Öä}∏Ù®∏Î–ó≤´ï.›ì+É‘'@ destroy();
        return;
    }
}

// Params 1
// Size: 0x40
function olarideexfil_preloadlocation( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( isdefined( var2 ) )
        {
            var2 calloutmarkerping_getinventoryslot( 0 );
            var2 scripts\mp\gametypes\br_public::ref_126b9( var0 );
        }
    }
}

// Params 2
// Size: 0x43
function olarideexfil_teleportplayers( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( isdefined( var3 ) && isalive( var3 ) )
        {
            var3 setorigin( var0 );
            var3 setplayerangles( var1 );
        }
    }
}

// Params 0
// Size: 0x3d
function olarideexfil_playerremovecinematicblacklayerifneeded()
{
    foreach ( var1 in level.players )
    {
        if ( isdefined( var1 ) && var1 scripts\mp\gametypes\br_gulag::ref_125ea() )
        {
            var1 thread scripts\mp\gametypes\br_gulag::ref_12523();
        }
    }
}

// Params 0
// Size: 0x9f
function heroesexfil_init()
{
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË = spawnstruct();
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ïìU:s8'ÎWæØ„ÂEPå bÄ@M = &heroesexfil_pack;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ëFÛÎ⁄¢|”ÎÖsÉˇÙ˝Â8HÉ“uñé = &heroesexfil_override_ending_structs;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.°^Ö@£ô[€–pÇ6£) = "heroes";
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ö¶…Yçˆ,ë+πåñ‹Ÿ = 1;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ß@Su=JÁàÒ´6H¯$“Å„ = 9;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.öﬂõ÷˚e∫-Ë(ÂX¿ÔRwìÎ = 1;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ôZ+sFñ‹ùÏZ+›•ÕÏ¡±¬ÚYúÌ9¥≥ñ7 = ( 11396, 14885, 8800 );
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.Øë;û˜†–ª¯a≥òòä‰ªõ=⁄8(ó2q´ = ( 5, 273, 0 );
    olarideexfil_fx_init();
}

#using_animtree( "" );

// Params 1
// Size: 0x8ab
function heroesexfil_pack( var0 )
{
    olarideexfil_loadtransient();
    olarideexfil_playerremovecinematicblacklayerifneeded();
    thread olarideexfil_music_sfx_start();
    self.ref_142d0 = "mp_wz_island_s05_exfil_g_ltm";
    scripts\mp\gametypes\br_gametype_olaride::brolaride_detachallflag();
    olarideexfil_setupchopper();
    heroesexfil_setupfightersaircraft();
    olarideexfil_deleteloot( self.origin );
    olarideexfil_deletesmokecolumn();
    olarideexfil_updatewinners();
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
    self.ref_121b8 = [];
    var1 = 0;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene1" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh010_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh010 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( $br_exfil_olaride_g_cam_sh010 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh010, %br_exfil_olaride_g_guy0_sh010_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh010, %br_exfil_olaride_g_guy1_sh010_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh010, %br_exfil_olaride_g_guy2_sh010_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh010, %br_exfil_olaride_g_guy3_sh010_fem );
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene2" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh020_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh020 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh020, %br_exfil_olaride_g_guy0_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh020, %br_exfil_olaride_g_guy1_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh020, %br_exfil_olaride_g_guy2_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh020, %br_exfil_olaride_g_guy3_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh020 );
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene3" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh030_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh030 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh030, %br_exfil_olaride_g_guy0_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh030, %br_exfil_olaride_g_guy1_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh030, %br_exfil_olaride_g_guy2_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh030, %br_exfil_olaride_g_guy3_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh030 );
    
    if ( self.winners.size >= 2 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene4" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh040_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh040 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh040, %br_exfil_olaride_g_guy0_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh040, %br_exfil_olaride_g_guy1_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh040, %br_exfil_olaride_g_guy2_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh040, %br_exfil_olaride_g_guy3_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh040 );
    }
    
    if ( self.winners.size >= 3 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene5" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh050_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh050 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh050, %br_exfil_olaride_g_guy0_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh050, %br_exfil_olaride_g_guy1_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh050, %br_exfil_olaride_g_guy2_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh050, %br_exfil_olaride_g_guy3_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh050 );
    }
    
    if ( self.winners.size == 4 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene6" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh060_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh060 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh060, %br_exfil_olaride_g_guy0_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh060, %br_exfil_olaride_g_guy1_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh060, %br_exfil_olaride_g_guy2_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh060, %br_exfil_olaride_g_guy3_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh060 );
    }
    
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene7" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh070_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh070 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh070, %br_exfil_olaride_g_guy0_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh070, %br_exfil_olaride_g_guy1_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh070, %br_exfil_olaride_g_guy2_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh070, %br_exfil_olaride_g_guy3_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh070 );
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene75" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh075_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh075 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_g_guy0_sh075, %br_exfil_olaride_g_guy0_sh075_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_g_guy1_sh075, %br_exfil_olaride_g_guy1_sh075_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_g_guy2_sh075, %br_exfil_olaride_g_guy2_sh075_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_g_guy3_sh075, %br_exfil_olaride_g_guy3_sh075_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh075 );
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene8" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olarideheroes_sh080_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_g_blima_sh080 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.£Õøps#cã|K«”ø˙¸90v, %br_exfil_olaride_g_suniform01_sh080 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.ìÕ€qä6èbs9z„hÁ¬≈, %br_exfil_olaride_g_suniform02_sh080 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_g_cam_sh080 );
}

// Params 1
// Size: 0x60
function olarideheroes_sh010_start( var0 )
{
    thread olarideexfil_set_brcircle( level.defendkill, 16500 );
    olarideexfil_setwind( level.defendkill, "10" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    scripts\mp\gametypes\br_ending::allplayers_setforcefov( 43 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 1, 1500 );
    thread olaridechopper_playfx();
    olarideexfil_choppershowrotors( 0 );
}

// Params 1
// Size: 0x25
function olarideheroes_sh020_start( var0 )
{
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 90 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x52
function olarideheroes_sh030_start( var0 )
{
    thread olarideexfil_set_brcircle( level.defendkill, 98000 );
    olarideexfil_setwind( level.defendkill, "20" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 4, 50 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x3a
function olarideheroes_sh040_start( var0 )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 3, 60, 1, 1 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x40
function olarideheroes_sh050_start( var0 )
{
    olarideexfil_setwind( level.defendkill, "40" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 3, 40 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x4c
function olarideheroes_sh060_start( var0 )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 4, 40 );
    thread olaridechopper_playfx();
    thread olarideexfil_fadetoblack( 3.2, 0.15, 0.05, 0.7, 1 );
}

// Params 1
// Size: 0x41
function olarideheroes_sh070_start( var0 )
{
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 75 );
    thread olaridechopper_playfx();
    thread olarideexfil_fadetoblack( 2.8, 0.15, 0.05, 0.7, 1 );
}

// Params 1
// Size: 0x72
function olarideheroes_sh075_start( var0 )
{
    olarideexfil_setwind( level.defendkill, "60" );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 3, 150, 2, 2 );
    thread olaridechopper_playfx();
    olarideexfil_teleportplayers( ( 13962, 8336, 7700 ), ( 338, 105, 0 ) );
    olarideexfil_preloadlocation( ( 13962, 8336, 7700 ) );
}

// Params 1
// Size: 0x6c
function olarideheroes_sh080_start( var0 )
{
    level notify( "shot_080_started" );
    scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();
    thread olaridechopper_playfx();
    thread heroesexfil_aircraftplayfx();
    thread heroesexfil_aircraftplayfx();
    var1 = 1;
    scripts\mp\gametypes\br_ending::allplayers_setforcefov( 43, var1 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 20, 5000 );
    thread olarideexfil_fadetoblack( 9.45, 0.25 );
}

// Params 1
// Size: 0x2a
function heroesexfil_override_ending_structs( var0 )
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, scripts\mp\gametypes\br_ending::init_level_drop_structs( ( 11389, 13673, 8664 ), ( 0, 0, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x54
function heroesexfil_setupfightersaircraft()
{
    var0 = spawn( "script_origin", ( 0, 0, 0 ) );
    var1 = "veh8_mil_air_suniform25";
    self.£Õøps#cã|K«”ø˙¸90v = var0 scripts\mp\gametypes\br_ending::ref_135ca( var1, "br_exfil_olaride_g_suniform01_sh080" );
    self.ìÕ€qä6èbs9z„hÁ¬≈ = var0 scripts\mp\gametypes\br_ending::ref_135ca( var1, "br_exfil_olaride_g_suniform02_sh080" );
    self.£Õøps#cã|K«”ø˙¸90v hide();
    self.ìÕ€qä6èbs9z„hÁ¬≈ hide();
}

// Params 0
// Size: 0x6b
function heroesexfil_aircraftplayfx()
{
    self endon( "death" );
    self show();
    self unmarkkeyframedmover( 1 );
    wait 0.1;
    playfxontag( scripts\engine\utility::getfx( "olarideHeroesExfil_contrail" ), self, "tag_engine_left" );
    playfxontag( scripts\engine\utility::getfx( "olarideHeroesExfil_contrail" ), self, "tag_engine_right" );
    playfxontag( scripts\engine\utility::getfx( "olarideHeroesExfil_trail" ), self, "tag_wingtip_left" );
    playfxontag( scripts\engine\utility::getfx( "olarideHeroesExfil_trail" ), self, "tag_wingtip_right" );
}

// Params 0
// Size: 0x17
function olarideexfil_deletesmokecolumn()
{
    if ( isdefined( level.é
ÉKãù_{8 “7 ) )
    {
        scripts\engine\utility::kill_exploder( level.é
ÉKãù_{8 “7 );
        return;
    }
}

// Params 0
// Size: 0x9f
function villainsexfil_init()
{
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË = spawnstruct();
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ïìU:s8'ÎWæØ„ÂEPå bÄ@M = &villainsexfil_pack;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ëFÛÎ⁄¢|”ÎÖsÉˇÙ˝Â8HÉ“uñé = &villainsexfil_override_ending_structs;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.°^Ö@£ô[€–pÇ6£) = "villains";
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ö¶…Yçˆ,ë+πåñ‹Ÿ = 1;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ß@Su=JÁàÒ´6H¯$“Å„ = 9;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.öﬂõ÷˚e∫-Ë(ÂX¿ÔRwìÎ = 1;
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.ôZ+sFñ‹ùÏZ+›•ÕÏ¡±¬ÚYúÌ9¥≥ñ7 = ( 12039, 13515, 8750 );
    level.çP¢ÎO≈∞‹Ωπ0%⁄ íJÔ”bË.Øë;û˜†–ª¯a≥òòä‰ªõ=⁄8(ó2q´ = ( 353, 159, 0 );
    olarideexfil_fx_init();
}

// Params 1
// Size: 0x87a
function villainsexfil_pack( var0 )
{
    olarideexfil_loadtransient();
    olarideexfil_playerremovecinematicblacklayerifneeded();
    thread olarideexfil_music_sfx_start();
    self.ref_142d0 = "mp_wz_island_s05_exfil_b_ltm";
    scripts\mp\gametypes\br_gametype_olaride::brolaride_detachallflag();
    olarideexfil_setupchopper();
    villainsexfil_setupprops();
    olarideexfil_deleteloot( self.origin );
    olarideexfil_updatewinners();
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "exfilStart", self.winners );
    self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
    self.ref_121b8 = [];
    var1 = 0;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene1" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh010_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh010 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh010 );
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene2" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh020_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh020 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh020 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh020 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh020, %br_exfil_olaride_b_guy0_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh020, %br_exfil_olaride_b_guy1_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh020, %br_exfil_olaride_b_guy2_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh020, %br_exfil_olaride_b_guy3_sh020_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh020 );
    villainsexfil_shootfromnotetrack();
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene3" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh030_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh030 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh030 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh030 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh030, %br_exfil_olaride_b_guy0_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh030, %br_exfil_olaride_b_guy1_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh030, %br_exfil_olaride_b_guy2_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh030, %br_exfil_olaride_b_guy3_sh030_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh030 );
    villainsexfil_shootfromnotetrack();
    
    if ( self.winners.size >= 2 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene4" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh040_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh040 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.É“Ô±S?˝Î`Ä, %br_exfil_olaride_b_pistol_sh040 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh040 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh040 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh040, %br_exfil_olaride_b_guy0_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh040, %br_exfil_olaride_b_guy1_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh040, %br_exfil_olaride_b_guy2_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh040, %br_exfil_olaride_b_guy3_sh040_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh040 );
        villainsexfil_shootfromnotetrack();
    }
    
    if ( self.winners.size >= 3 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene5" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh050_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh050 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.£À*Ì€>HªÚW, %br_exfil_olaride_b_grenade_sh050 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh050 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh050 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh050, %br_exfil_olaride_b_guy0_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh050, %br_exfil_olaride_b_guy1_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh050, %br_exfil_olaride_b_guy2_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh050, %br_exfil_olaride_b_guy3_sh050_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh050 );
        villainsexfil_shootfromnotetrack();
    }
    
    if ( self.winners.size == 4 )
    {
        var1++;
        self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene6" );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh060_start );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh060 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh060 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh060 );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh060, %br_exfil_olaride_b_guy0_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh060, %br_exfil_olaride_b_guy1_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh060, %br_exfil_olaride_b_guy2_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh060, %br_exfil_olaride_b_guy3_sh060_fem );
        self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh060 );
        villainsexfil_shootfromnotetrack();
    }
    
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene7" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh070_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh070 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.éüù]õÊ+ìL, %br_exfil_olaride_b_gunner1_sh070 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.Çüi€Ê¯=≥R, %br_exfil_olaride_b_gunner2_sh070 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 0 ], %br_exfil_olaride_b_guy0_sh070, %br_exfil_olaride_b_guy0_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 1 ], %br_exfil_olaride_b_guy1_sh070, %br_exfil_olaride_b_guy1_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 2 ], %br_exfil_olaride_b_guy2_sh070, %br_exfil_olaride_b_guy2_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_vector( self.winners[ 3 ], %br_exfil_olaride_b_guy3_sh070, %br_exfil_olaride_b_guy3_sh070_fem );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh070 );
    villainsexfil_shootfromnotetrack();
    var1++;
    self.ref_121b8[ var1 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( "scene8" );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::backendevent( [], &olaridevillains_sh080_start );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::back_struct( self.onkillingblow, %br_exfil_olaride_b_blima_sh080 );
    self.ref_121b8[ var1 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %br_exfil_olaride_b_cam_sh080 );
}

// Params 1
// Size: 0x85
function olaridevillains_sh010_start( var0 )
{
    thread olarideexfil_set_brcircle( level.defendkill, 7700 );
    scripts\mp\gametypes\br_ending::allplayers_setforcefov( 40 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 2, 2000 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    thread olaridechopper_playfx();
    olarideexfil_choppershowrotors( 0 );
    olarideexfil_teleportplayers( ( 13410, 10749, 9150 ), ( 5, 166, 0 ) );
    olarideexfil_preloadlocation( ( 13410, 10749, 9150 ) );
}

// Params 1
// Size: 0x43
function olaridevillains_sh020_start( var0 )
{
    playsoundatpos( ( 13753, 11136, 9199 ), "br_exfil_olaride_villains_axis_gunfight" );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 5, 150 );
    thread olaridechopper_playfx();
    olarideexfil_choppershowrotors( 1 );
}

// Params 1
// Size: 0x47
function olaridevillains_sh030_start( var0 )
{
    olarideexfil_setwind( level.defendkill, "10" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 3, 75 );
    thread olaridechopper_playfx();
    olarideexfil_choppershowrotors( 0 );
}

// Params 1
// Size: 0x40
function olaridevillains_sh040_start( var0 )
{
    olarideexfil_setwind( level.defendkill, "20" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 2, 75 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x4f
function olaridevillains_sh050_start( var0 )
{
    olarideexfil_setwind( level.defendkill, "30" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
    level.defendkill.É“Ô±S?˝Î`Ä delete();
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 2, 60 );
    thread olaridechopper_playfx();
}

// Params 1
// Size: 0x5a
function olaridevillains_sh060_start( var0 )
{
    thread olaridevillains_sh060_grenadeexplosound();
    olarideexfil_deletesmokecolumn();
    olarideexfil_setwind( level.defendkill, "40" );
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
    level.defendkill.£À*Ì€>HªÚW delete();
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 6, 75 );
    thread olaridechopper_playfx();
}

// Params 0
// Size: 0x1e
function olaridevillains_sh060_grenadeexplosound()
{
    wait 0.5;
    playsoundatpos( ( 13191, 11762, 9138 ), "frag_grenade_expl_trans" );
}

// Params 1
// Size: 0x90
function olaridevillains_sh070_start( var0 )
{
    if ( isdefined( level.defendkill.É“Ô±S?˝Î`Ä ) )
    {
        level.defendkill.É“Ô±S?˝Î`Ä delete();
    }
    
    olarideexfil_setwind( level.defendkill, "60" );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 8, 500, 1, 1 );
    thread olaridechopper_playfx();
    olarideexfil_teleportplayers( ( 13962, 8336, 7700 ), ( 338, 105, 0 ) );
    olarideexfil_preloadlocation( ( 13962, 8336, 7700 ) );
}

// Params 1
// Size: 0x78
function olaridevillains_sh080_start( var0 )
{
    level notify( "shot_080_started" );
    level.é
ÉKãù_{8 “7 = scripts\engine\utility::ter_op( getdvarint( "scr_br_caldera_volcano_olaride_smoke", 0 ), "olaride_volcano_smoke_big", "olaride_volcano_smoke_small" );
    scripts\engine\utility::exploder( level.é
ÉKãù_{8 “7 );
    scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();
    var1 = 1;
    scripts\mp\gametypes\br_ending::allplayers_setforcefov( 40, var1 );
    scripts\mp\gametypes\br_ending::brking_ontimelimit( 20, 5000 );
    thread olaridechopper_playfx();
    thread villainsexfil_bombplayfx();
    thread olarideexfil_fadetoblack( 12.5, 0.25 );
}

// Params 1
// Size: 0x2a
function villainsexfil_override_ending_structs( var0 )
{
    var0 = [];
    GscBinSkip0( 0x2e, 0, scripts\mp\gametypes\br_ending::init_level_drop_structs( ( 12805, 10896, 9068 ), ( 0, 0, 0 ) ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x31
function villainsexfil_bombplayfx()
{
    var0 = ( 11533, 13058, 15264 );
    playfx( scripts\engine\utility::getfx( "olarideVillainsExfil_bomb" ), var0 );
    wait 10.5;
    scripts\engine\utility::exploder( "lava_bomb_volcano_explosion" );
}

// Params 0
// Size: 0x57
function villainsexfil_setupprops()
{
    var0 = "offhand_wm_grenade_mike67";
    self.£À*Ì€>HªÚW = scripts\mp\gametypes\br_ending::ref_135ca( var0, "br_exfil_olaride_b_grenade_sh050" );
    var1 = "weapon_wm_stream_pi";
    self.É“Ô±S?˝Î`Ä = scripts\mp\gametypes\br_ending::ref_135ca( var1, "br_exfil_olaride_b_pistol_sh040" );
    var2 = "fullbody_zombie_a_br";
    self.éüù]õÊ+ìL = scripts\mp\gametypes\br_ending::ref_135ca( var2, "br_exfil_olaride_b_gunner1_sh020" );
    self.Çüi€Ê¯=≥R = scripts\mp\gametypes\br_ending::ref_135ca( var2, "br_exfil_olaride_b_gunner2_sh020" );
}

// Params 0
// Size: 0xb7
function villainsexfil_shootfromnotetrack()
{
    scripts\common\anim::addnotetrack_customfunction( self.winners[ 0 ].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack );
    
    if ( self.winners.size > 1 )
    {
        scripts\common\anim::addnotetrack_customfunction( self.winners[ 1 ].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack );
        scripts\common\anim::addnotetrack_customfunction( self.winners[ 1 ].animname, "fire_pistol", &scripts\mp\gametypes\br_ending::shoot_gun_pistol_from_notetrack );
    }
    
    if ( self.winners.size > 2 )
    {
        scripts\common\anim::addnotetrack_customfunction( self.winners[ 2 ].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack );
    }
    
    if ( self.winners.size > 3 )
    {
        scripts\common\anim::addnotetrack_customfunction( self.winners[ 3 ].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack );
        return;
    }
}

// Params 0
// Size: 0x36
function villainsexfil_gunnershootfromnotetrack()
{
    scripts\common\anim::addnotetrack_customfunction( self.éüù]õÊ+ìL.animname, "fire", &scripts\mp\gametypes\br_ending::shoot_sfx_from_notetrack );
    scripts\common\anim::addnotetrack_customfunction( self.Çüi€Ê¯=≥R.animname, "fire", &scripts\mp\gametypes\br_ending::shoot_sfx_from_notetrack );
}

