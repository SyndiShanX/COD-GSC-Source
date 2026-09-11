
// Params 0
// Size: 0x6b
function main()
{
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_precache::main();
    scripts\mp\maps\mp_frontendc3s5\gen\mp_frontendc3s5_art::main();
    level.«ç“EZScâéãZ¯]j¯‚€ = 1;
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    scripts\cp_mp\frontendutils::ref_131e2();
    scripts\cp_mp\frontendutils::create_camera_position_list();
    scripts\cp_mp\frontendutils::setup_initial_entities();
    level.transition_interrupted = 0;
    var0 = 0.1;
    scripts\engine\utility::delaythread( var0, &scripts\cp_mp\frontendutils::playersetiszombie );
    thread init_fx();
    level.callbackplayerconnect = &callback_frontendplayerconnect;
    thread ref_11db7();
}

// Params 0
// Size: 0x4a
function ref_11db7()
{
    var0 = getent( "mp_lobby_floor_01", "targetname" );
    var1 = getent( "mp_lobby_floor_02", "targetname" );
    var2 = getent( "frontend_rfl_probe_01", "targetname" );
    var3 = getent( "frontend_rfl_probe_02", "targetname" );
    var2 linkto( var0 );
    var3 linkto( var1 );
}

// Params 0
// Size: 0xca
function init_fx()
{
    level._effect[ "lava" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_magmaflow_smk.vfx" );
    level._effect[ "steam" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_steampressure.vfx" );
    level._effect[ "dust" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_dust.vfx" );
    level._effect[ "vfx_br3_frontend_grid_smk" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_grid_smk.vfx" );
    level._effect[ "vfx_frontend_amb_mplobby_ch3_s5" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_ch3_s5.vfx" );
    level._effect[ "vfx_frontend_amb_mplobby_dust" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_dust.vfx" );
    level._effect[ "vfx_br3_dust_motes_fast_med" ] = loadfx( "vfx/iw8_br/island/gen_amb/vfx_br3_dust_motes_fast_med.vfx" );
    level._effect[ "vfx_br3_dust_motes_sml" ] = loadfx( "vfx/iw8_br/island/gen_amb/vfx_br3_dust_motes_sml.vfx" );
    level._effect[ "vfx_frontend_amb_mplobby_steampressure" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_steampressure.vfx" );
    level._effect[ "vfx_br3_frontend_magmaflow_smk" ] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_magmaflow_smk.vfx" );
}

// Params 0
// Size: 0x1e
function callback_frontendplayerconnect()
{
    thread onplayerconnectrunonce();
    thread scripts\cp_mp\frontendutils::frontend_camera_watcher( &gas_trap_cloud_structs );
    thread scripts\cp_mp\frontendutils::epictauntlistener();
    thread scripts\cp_mp\frontendutils::luinotifylistener();
}

// Params 0
// Size: 0x56
function onplayerconnectrunonce()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level.playerviewowner = self;
    
    if ( isdefined( level.playerconnectedevents ) )
    {
        return;
    }
    
    level.playerconnectedevents = 1;
    scripts\engine\utility::init_struct_class();
    scripts\cp_mp\frontendutils::playersetisbecomingzombie();
    scripts\cp_mp\frontendutils::playersetispropgameextrainfo();
    thread scripts\cp_mp\frontendutils::ref_13205();
    scripts\cp_mp\frontendutils::initialize_transition_array();
    self enablephysicaldepthoffieldscripting();
    wait 0.5;
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_fx::main();
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_lighting::main();
}

// Params 0
// Size: 0x37
function target_check_grenade()
{
    if ( isdefined( level.ref_13970 ) )
    {
        return;
    }
    
    level.ref_13970 = 1;
    var0 = getentarray( "sun_frontend_seasonal_target", "targetname" );
    
    if ( isdefined( var0 ) && var0.size > 0 )
    {
        level.ref_1396f = var0[ 0 ];
        return;
    }
}

// Params 1
// Size: 0x82
function gas_trap_cloud_structs( var0 )
{
    target_check_grenade();
    scripts\cp_mp\frontendutils::camera_section_change( var0 );
    var1 = istrue( level.ref_13370 );
    var2 = var1 && getdvarint( "frontend_seasonal_sun", 0 ) != 0 && isdefined( level.ref_1396f );
    
    if ( var2 )
    {
        var3 = "seasonal_nonwalking";
        
        if ( isdefined( var0 ) && isdefined( var0.name ) )
        {
            switch ( var0.name )
            {
                case "squad_lobby_detail":
                case "squad_lobby":
                    var3 = "seasonal_walking";
                    break;
            }
        }
        
        level.ref_1396f setscriptablepartstate( "sun", var3 );
        return;
    }
}

