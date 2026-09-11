
// Params 0
// Size: 0xe, Type: bool
function victoryscreenexfil_should_enable()
{
    return level.script == "mp_wz_island";
}

// Params 0
// Size: 0x79
function victoryscreenexfil_init()
{
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè = spawnstruct();
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.š¦ÉYö,‘+¹Œ–ÜÙ = 1;
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.‘FóëÚ¢|Óë…sƒÿôıå8HƒÒu– = &victoryscreenexfil_override_ending_structs;
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.ˆİè{¤eÂ3-K]™ë@ğ¿jk;››— = &victoryscreenexfil_ending_viewing_player_setup;
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.«ÿ­Jx¡Ã8xn¢Ş?Sou& = &victoryscreenexfil_get_winners;
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.¡^…@£™[ÛĞp‚6£) = "victory_screen";
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.•“U:s8'ëW¾¯ãåEPŒ b€@M = &victoryscreenexfil_ending_pack_override;
    level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.dúhè™Šîsgc = create_player_anims_array();
}

// Params 1
// Size: 0x5a
function victoryscreenexfil_override_ending_structs( var0 )
{
    if ( level.script == "mp_wz_island" )
    {
        var1 = [];
        var2 = ( 21605, -50768, 440 );
        var3 = scripts\engine\utility::drop_to_ground( var2, 1000, -1000, ( 0, 0, 1 ) );
        var1 = scripts\mp\gametypes\br_ending::init_level_drop_structs( var3, ( 0, 300, 0 ) );
        return var1;
    }
    
    return var3;
}

#using_animtree( "" );

// Params 1
// Size: 0x1b9
function victoryscreenexfil_ending_pack_override( var0 )
{
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self.ref_13ce3 = get_victoryscreenexfil_transient();
        unloadinfiltransient( self.ref_13ce3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var1 = getdvarfloat( "scr_br_end_transient_wait", 6 );
        wait var1;
    }
    
    if ( self.winners.size == 0 )
    {
        scripts\mp\gametypes\br_ending::init_death_animations( self );
    }
    
    self.ref_121b8 = [];
    var2 = 0;
    var3 = "scene";
    self.ref_121b8[ var2 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( var3 + var2 );
    
    for ( var4 = 0; var4 < self.winners.size ; var4++ )
    {
        var5 = self.winners[ var4 ];
        var6 = level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.dúhè™Šîsgc[ var4 ].ˆ%ûì‹À%ÙxkK;
        var7 = var6;
        var8 = undefined;
        self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::back_vector( var5, var6, var7, var8 );
    }
    
    var9 = scripts\mp\gametypes\br_ending::ref_135ca( "veh8_mil_air_mindia8" );
    self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::back_struct( var9, %wz_victoryscreen_helicopter );
    var10 = scripts\mp\gametypes\br_ending::ref_135ca( "veh_s4_mil_ratrace_suv_wz" );
    self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::back_struct( var10, $wz_victoryscreen_suv );
    self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_victoryscreen_sh001_cam );
    var2++;
    
    for ( var4 = 0; var4 < self.winners.size ; var4++ )
    {
        self.ref_121b8[ var2 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( var3 + var2 );
        self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::backendevent( var4, &victoryscreenexfil_player_highlight_camera_start );
        self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.dúhè™Šîsgc[ var4 ].£†‘¦m(>—ÅóŸ );
        var2++;
    }
    
    self.ref_121b8[ var2 ] = scripts\mp\gametypes\br_ending::init_bomb_objective( var3 + var2 );
    self.ref_121b8[ var2 ] scripts\mp\gametypes\br_ending::awardstadiumblueprint( %wz_victoryscreen_sh012_cam );
    thread watch_ending_all_scenes_end();
}

// Params 0
// Size: 0x3e
function watch_ending_all_scenes_end()
{
    self waittill( "all_scenes_end" );
    var0 = 0.2;
    
    foreach ( var2 in level.players )
    {
        var2 thread scripts\mp\gametypes\br_ending::nag_get_in_heli( var0 );
    }
}

// Params 0
// Size: 0x1c0
function create_player_anims_array()
{
    var0 = [];
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc04;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh004_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc02;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh002_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc06;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh006_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc05;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh005_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc01;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh011_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc03;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh003_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc07;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh007_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc08;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh008_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc10;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh009_cam;
    var0 = var1;
    var1 = spawnstruct();
    var1.ˆ%ûì‹À%ÙxkK = %wz_victoryscreen_idle_npc09;
    var1.£†‘¦m(>—ÅóŸ = %wz_victoryscreen_sh010_cam;
    var0 = var1;
    return var0;
}

// Params 0
// Size: 0x8
function get_victoryscreenexfil_transient()
{
    return "mp_infil_wz_island_ending_victory_screen_tr";
}

// Params 1
// Size: 0x53
function enable_player_hightlight( var0 )
{
    if ( var0 == 0 )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
        return;
    }
    
    if ( var0 == 1 )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
        return;
    }
    
    if ( var0 == 2 )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
        return;
    }
    
    if ( var0 == 3 )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
        return;
    }
}

// Params 1
// Size: 0xb
function victoryscreenexfil_player_highlight_camera_start( var0 )
{
    enable_player_hightlight( var0 );
}

// Params 0
// Size: 0x30
function victoryscreenexfil_ending_viewing_player_setup()
{
    self endon( "disconnect" );
    var0 = 0.5;
    var1 = 1;
    self setclientomnvar( "ui_world_fade", 1 );
    self playerhide( 1 );
    wait var0;
    scripts\mp\gametypes\br_ending::musictriggerthink( var1 );
}

// Params 1
// Size: 0x20
function victoryscreenexfil_get_winners( var0 )
{
    var1 = min( level.P¢ëOÅ°Ü½¹0%Ú ’JïÓbè.dúhè™Šîsgc.size, var0.size );
    return scripts\engine\utility::array_slice( var0, 0, var1 );
}

