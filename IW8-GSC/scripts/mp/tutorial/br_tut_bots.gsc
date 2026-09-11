
// Params 0
// Size: 0x15f
function initialize_tutorial_bot_system()
{
    createthreatbiasgroup( "player_threat" );
    createthreatbiasgroup( "bot_harmless" );
    createthreatbiasgroup( "bot_victim" );
    createthreatbiasgroup( "bot_threat" );
    createthreatbiasgroup( "bot_assassin" );
    createthreatbiasgroup( "bot_attack_all" );
    setignoremegroup( "player_threat", "bot_harmless" );
    setignoremegroup( "player_threat", "bot_victim" );
    setignoremegroup( "player_threat", "bot_assassin" );
    setignoremegroup( "bot_harmless", "bot_harmless" );
    setignoremegroup( "bot_harmless", "bot_victim" );
    setignoremegroup( "bot_harmless", "bot_threat" );
    setignoremegroup( "bot_harmless", "bot_assassin" );
    setignoremegroup( "bot_harmless", "bot_attack_all" );
    setignoremegroup( "bot_threat", "bot_harmless" );
    setignoremegroup( "bot_threat", "bot_victim" );
    setignoremegroup( "bot_threat", "bot_assassin" );
    setignoremegroup( "bot_threat", "bot_threat" );
    setignoremegroup( "bot_victim", "bot_harmless" );
    setignoremegroup( "bot_victim", "bot_victim" );
    setignoremegroup( "bot_assassin", "bot_harmless" );
    setignoremegroup( "bot_assassin", "bot_victim" );
    setignoremegroup( "bot_assassin", "bot_threat" );
    setignoremegroup( "bot_assassin", "bot_assassin" );
    setignoremegroup( "bot_attack_all", "bot_harmless" );
    thread override_bot_functions();
    level.bots[ "players" ] = [];
    level.æB2¯√7ùps∫(¡Ÿ≥Wºß+ = &set_bot_loadoout;
}

// Params 0
// Size: 0x2b
function override_bot_functions()
{
    level.brlatespawnplayer = &bot_late_spawn;
    
    while ( !isdefined( level.bot_variables_initialized ) || !level.bot_variables_initialized )
    {
        waitframe();
    }
    
    level.bot_random_path_function = &bot_random_replacement_function;
}

// Params 0
// Size: 0x4, Type: bool
function bot_random_replacement_function()
{
    return false;
}

// Params 0
// Size: 0x28
function bot_late_spawn()
{
    if ( isdefined( self.botskinid ) && isdefined( self.botoperatorref ) && isdefined( self.botoperatorteam ) )
    {
        scripts\mp\teams::createoperatorcustomization();
    }
    
    scripts\mp\gametypes\br_infils::latespawnplayer();
}

// Params 0
// Size: 0x7
function override_player_connect()
{
    scripts\mp\playerlogic::callback_playerconnect();
}

// Params 9
// Size: 0xa1
function add_bot_to_table( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    level.bots[ "team" ][ var0 ] = var1;
    level.bots[ "origin" ][ var0 ] = var2;
    level.bots[ "facing" ][ var0 ] = var3;
    level.bots[ "operator" ][ var0 ] = var4;
    level.bots[ "skinID" ][ var0 ] = var8;
    level.bots[ "brains" ][ var0 ] = var6;
    level.bots[ "weapons" ][ var0 ] = var5;
    
    if ( !isdefined( var7 ) )
    {
        var7 = var0;
    }
    
    level.bots[ "display_name" ][ var0 ] = var7;
    level.í“E˘Õ∏ [rñ:á[ var7 ] = var0;
}

// Params 1
// Size: 0x54, Type: bool
function spawn_bot_from_table( var0 )
{
    var1 = level.bots[ "team" ][ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    var2 = level.bots[ "operator" ][ var0 ];
    var3 = level.bots[ "skinID" ][ var0 ];
    var4 = level.bots[ "display_name" ][ var0 ];
    spawn_bot( var4, var2, var1, var3 );
    return true;
}

// Params 2
// Size: 0xaf
function spawn_bot_group( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( var1 ) )
    {
    }
    
    var2 = [];
    
    for ( var3 = 0; var3 < var0.size ; var3++ )
    {
        var4 = load_bot_placement( var0[ var3 ] );
        var2 = var4;
        var5 = var1[ var4 ];
        
        if ( !isdefined( var5 ) )
        {
            continue;
        }
        
        var6 = 1 + ( var3 >> 4 );
        thread monitor_for_spawned_bot( level, var4, var5 );
        spawn_bot_from_table( var4 );
    }
    
    var7 = 1;
    
    while ( var7 )
    {
        waitframe();
        var7 = 0;
        
        foreach ( var9 in var2 )
        {
            if ( !isalive( bot_entity( var9 ) ) )
            {
                var7 = 1;
            }
        }
    }
    
    level.Øå9≠PH“?CSo = var2;
}

// Params 0
// Size: 0x3e
function group_bots_remaining()
{
    var0 = 0;
    
    foreach ( var2 in level.Øå9≠PH“?CSo )
    {
        if ( !bot_entity( var2 ) scripts\engine\utility::is_dead_sentient() )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 3
// Size: 0x42
function monitor_for_spawned_bot( var0, var1, var2 )
{
    for ( ;; )
    {
        level waittill( "bot_spawned", var3 );
        
        if ( isdefined( level.bots[ "players" ][ var0 ] ) )
        {
            var4 = bot_entity( var0 );
            var4 setsquadindex( var2 );
            thread follow_waypoints( var4 );
            break;
        }
    }
}

// Params 1
// Size: 0x33
function spawn_bot_from_table_and_wait( var0 )
{
    if ( spawn_bot_from_table( var0 ) )
    {
        for ( ;; )
        {
            level waittill( "bot_spawned", var1 );
            
            if ( isdefined( level.bots[ "players" ][ var0 ] ) )
            {
                break;
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x7b
function spawn_bots_from_table()
{
    self waittill( "br_spawned" );
    
    if ( level.player.size == 1 )
    {
        level.Ø5Ÿòa?:E∞“y»± = 1;
        
        foreach ( var4, var1 in level.bots[ "team" ] )
        {
            var2 = level.bots[ "operator" ][ var4 ];
            var3 = level.bots[ "skinID" ][ var4 ];
            scripts\engine\utility::delaythread( 5, &spawn_bot, var4, var2, var1, var4, var3 );
        }
        
        return;
    }
}

// Params 4
// Size: 0xad
function spawn_bot( var0, var1, var2, var3 )
{
    if ( !isdefined( level.Ø5Ÿòa?:E∞“y»± ) )
    {
        level.Ø5Ÿòa?:E∞“y»± = 1;
    }
    
    level.maxteamsize = 4;
    var4 = addbot( var0 );
    var4.botoperatorref = var1;
    
    if ( isdefined( var3 ) )
    {
        var4.botoperatorteam = scripts\engine\utility::ter_op( var2 == "allies", 0, 1 );
        var4.botskinid = var3;
    }
    
    var4.©f
Y7G-:ÂÎ-å = level.Ø5Ÿòa?:E∞“y»±;
    level.Ø5Ÿòa?:E∞“y»± += 1;
    var5 = spawnstruct();
    var5.bot = var4;
    var5.ready = 0;
    var5.abort = 0;
    var5.index = 1;
    var5.difficulty = undefined;
    var5.bot thread scripts\mp\bots\bots::spawn_bot_latent( var2, undefined, var5 );
}

// Params 0
// Size: 0xe0
function setup_tutorial_bot()
{
    var0 = self;
    var1 = var0.name;
    var2 = level.í“E˘Õ∏ [rñ:á[ var1 ];
    var0.key = var2;
    level.bots[ "start" ][ var2 ] = gettime();
    level.bots[ "players" ][ var2 ] = var0;
    
    if ( !bot_exists( var2 ) )
    {
        return;
    }
    
    var3 = level.bots[ "brains" ][ var2 ];
    var0.botoperatorteam = game[ "defenders" ];
    var0 setorigin( level.bots[ "origin" ][ var2 ] );
    var0 setplayerangles( ( 0, level.bots[ "facing" ][ var2 ], 0 ) );
    var0 botsetflag( "disable_movement", 1 );
    var0 botsetflag( "disable_rotation", 1 );
    
    if ( !isdefined( level.æB2¯√7ùps∫(¡Ÿ≥Wºß+ ) )
    {
        level.æB2¯√7ùps∫(¡Ÿ≥Wºß+ = &default_arm_bot;
    }
    
    var0 [[ level.æB2¯√7ùps∫(¡Ÿ≥Wºß+ ]]();
    var4 = var0 getthreatbiasgroup();
    var0 setthreatbiasgroup( "bot_harmless" );
    var0 thread [[ var3 ]]();
    level notify( "bot_spawned", var0 );
}

// Params 0
// Size: 0x8b
function default_arm_bot()
{
    while ( !isdefined( self.lastnormalweaponobj ) )
    {
        waitframe();
    }
    
    var0 = scripts\mp\gametypes\br_weapons::degrees_to_radians( "ar", "epic" );
    var1 = scripts\mp\gametypes\br_weapons::degrees_to_radians( "pi", "comm" );
    var2 = scripts\mp\utility\weapon::getweaponrootname( var0 );
    var3 = scripts\mp\utility\weapon::getweaponrootname( var1 );
    scripts\mp\gametypes\br_weapons::br_forcegiveweapon( var1, self, undefined );
    scripts\mp\gametypes\br_weapons::br_forcegiveweapon( var0, self, undefined );
    
    foreach ( var5 in self getweaponslistprimaries() )
    {
        self setweaponammoclip( var5, weaponclipsize( var5 ) );
        self setweaponammostock( var5, weaponmaxammo( var5 ) );
    }
}

// Params 0
// Size: 0xa8
function set_bot_loadoout()
{
    if ( !isdefined( self.key ) || !isdefined( level.bots[ "weapons" ][ self.key ] ) )
    {
        default_arm_bot();
        return;
    }
    
    var0 = level.bots[ "weapons" ][ self.key ];
    var1 = strtok( var0, "," );
    
    foreach ( var3 in var1 )
    {
        scripts\mp\gametypes\br_weapons::br_forcegiveweapon( var3, self, undefined );
    }
    
    foreach ( var6 in self getweaponslistprimaries() )
    {
        self setweaponammoclip( var6, weaponclipsize( var6 ) );
        self setweaponammostock( var6, weaponmaxammo( var6 ) );
    }
}

// Params 0
// Size: 0x21
function setup_human_player()
{
    var0 = self;
    var1 = var0 getsquadindex();
    var2 = var0 getthreatbiasgroup();
    var0 setthreatbiasgroup( "player_threat" );
    var0 setsquadindex( 0 );
}

// Params 2
// Size: 0x31
function bot_ping_other( var0, var1 )
{
    var2 = level.bots[ "players" ][ var1 ];
    self calloutmarkerping_create( 4 + var0, ( 0, 0, 82 ), var2.©f
Y7G-:ÂÎ-å );
}

// Params 1
// Size: 0xd
function bot_clear_ping_other( var0 )
{
    self calloutmarkerping_delete( 4 + var0 );
}

// Params 0
// Size: 0x36
function check_for_enemy_ping()
{
    var0 = self.team;
    
    for ( var1 = 1; var1 <= 2 ; var1++ )
    {
        var2 = self calloutmarkerping_getsavedzoffset( var1 );
        
        if ( isdefined( var2 ) && var2.team != var0 )
        {
            return var2;
        }
    }
}

// Params 4
// Size: 0x93
function run_to_spot( var0, var1, var2, var3 )
{
    self endon( "death" );
    
    if ( !isdefined( var2 ) )
    {
        var2 = 40;
    }
    
    self.message = "waiting.. " + var0;
    wait var0;
    self botsetscriptgoal( var1, var2, "tactical", undefined, undefined, 1 );
    self botsetflag( "disable_movement", 0 );
    self botsetflag( "disable_rotation", 0 );
    self.message = "run to " + var1;
    var4 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail( var3 );
    
    if ( var4 == "goal" )
    {
        self.message = "reached: " + var4;
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        self botclearscriptgoal();
        self.message = "timed out, so teleporting to location.";
        self setorigin( var1 );
        return;
    }
}

// Params 2
// Size: 0xa8
function wait_then_run_route( var0, var1 )
{
    self endon( "death" );
    self.message = "waiting.. " + var0;
    wait var0;
    self botsetflag( "disable_movement", 0 );
    self botsetflag( "disable_rotation", 0 );
    var2 = "goal";
    
    foreach ( var4 in var1 )
    {
        self botsetscriptgoal( var4, 40, "tactical", undefined, undefined, 1 );
        self.message = "run to " + var4;
        var2 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
        self.message = "reached: " + var2;
        
        if ( var2 != "goal" )
        {
            return var2;
        }
    }
    
    if ( var2 == "goal" )
    {
        self notify( "bot_is_there" );
    }
    
    return var2;
}

// Params 2
// Size: 0x44
function fire_repeatedly( var0, var1 )
{
    self endon( "death" );
    
    while ( var1 >= 0 )
    {
        self.message = "firing " + var1;
        var1 -= 1;
        wait var0;
        self botpressbutton( "attack" );
    }
    
    self.message = "done firing..";
    self notify( "bot_is_there" );
}

// Params 1
// Size: 0x23, Type: bool
function bot_exists( var0 )
{
    return isdefined( level.bots[ "team" ] ) && isdefined( level.bots[ "team" ][ var0 ] );
}

// Params 1
// Size: 0x12
function bot_entity( var0 )
{
    return level.bots[ "players" ][ var0 ];
}

// Params 1
// Size: 0x12
function bot_spawn_point( var0 )
{
    return level.bots[ "origin" ][ var0 ];
}

// Params 2
// Size: 0x27
function bot_notify( var0, var1 )
{
    if ( isdefined( level.bots[ "players" ][ var0 ] ) )
    {
        level.bots[ "players" ][ var0 ] notify( var1 );
        return;
    }
}

// Params 1
// Size: 0x5b
function load_player_targets( var0 )
{
    self.á5€ÒÂC1H3äg√∞¬ = [];
    var1 = getentarray( var0, "targetname" );
    
    if ( isdefined( var1 ) )
    {
        foreach ( var3 in var1 )
        {
            var4 = var3.script_noteworthy;
            
            if ( isdefined( var4 ) )
            {
                self.á5€ÒÂC1H3äg√∞¬[ var4 ] = var3.origin;
            }
        }
        
        return;
    }
}

// Params 1
// Size: 0xcc
function load_bot_placement( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return undefined;
    }
    
    if ( !isdefined( var0.script_noteworthy ) )
    {
        return undefined;
    }
    
    var1 = var0.script_noteworthy;
    
    if ( !isdefined( var0.script_namenumber ) || !isdefined( var0.script_team ) )
    {
        return undefined;
    }
    
    var2 = var0.script_namenumber;
    var3 = var0.script_team;
    var4 = undefined;
    
    if ( isdefined( var0.script_wtf ) )
    {
        var4 = int( var0.script_wtf );
    }
    
    var5 = undefined;
    
    if ( isdefined( var0.script_parameters ) )
    {
        var5 = var0.script_parameters;
    }
    
    var6 = var1;
    
    if ( isdefined( var0.script_label ) )
    {
        var6 = var0.script_label;
    }
    
    var7 = var0.origin + ( 0, 0, 3 );
    var8 = var0.angles[ 1 ];
    add_bot_to_table( var1, var3, var7, var8, var2, var5, &scripts\mp\tutorial\br_tut_utility::emptyfunction, var6, var4 );
    return var1;
}

// Params 1
// Size: 0xc6
function load_logic_waypoints( var0 )
{
    var1 = [];
    var2 = getentarray( var0, "targetname" );
    
    if ( isdefined( var2 ) )
    {
        foreach ( var4 in var2 )
        {
            var5 = var4.script_noteworthy;
            var6 = var4.script_namenumber;
            
            if ( !isdefined( var5 ) || !isdefined( var6 ) )
            {
                continue;
            }
            
            if ( !isdefined( var1[ var5 ] ) )
            {
                var1 = [];
            }
            
            var1[ var6 ] = var4;
            
            if ( isdefined( var4.script_startname ) && !scripts\engine\utility::flag_exist( var4.script_startname ) )
            {
                scripts\engine\utility::flag_init( var4.script_startname );
            }
            
            if ( isdefined( var4.script_triggername ) && !scripts\engine\utility::flag_exist( var4.script_triggername ) )
            {
                scripts\engine\utility::flag_init( var4.script_triggername );
            }
        }
    }
    
    return var1;
}

// Params 1
// Size: 0xcf
function set_player_attributes( var0 )
{
    var1 = self;
    
    if ( isdefined( var0.script_difficulty ) )
    {
        var1 botsetdifficulty( var0.script_difficulty );
    }
    
    if ( isdefined( var0.script_pathtype ) )
    {
        var1 botsetpathingstyle( var0.script_pathtype );
    }
    
    if ( isdefined( var0.script_stance ) )
    {
        var1 botsetstance( var0.script_stance );
    }
    
    if ( isdefined( var0.script_threatbiasgroup ) )
    {
        var1 setthreatbiasgroup( var0.script_threatbiasgroup );
    }
    
    if ( isdefined( var0.speed ) )
    {
        var1 scripts\engine\utility::set_movement_speed();
    }
    
    if ( isdefined( var0.script_flag ) )
    {
        var2 = strtok( var0.script_flag, "," );
        
        foreach ( var4 in var2 )
        {
            var5 = strtok( var4, "=" );
            var1 botsetflag( var5[ 0 ], int( var5[ 1 ] ) );
        }
        
        return;
    }
}

// Params 1
// Size: 0x113
function follow_waypoints( var0 )
{
    self endon( "death" );
    self endon( "abort_waypoint" );
    self endon( "game_over" );
    var1 = self;
    
    for ( var2 = var0[ "Start" ]; isdefined( var2 ) ; var2 = var0[ var2.target ] )
    {
        if ( isdefined( var2.script_delay ) )
        {
            wait var2.script_delay;
        }
        
        if ( isdefined( var2.script_startname ) )
        {
            scripts\engine\utility::flag_wait( var2.script_startname );
        }
        
        set_player_attributes( var1, var2 );
        
        if ( isdefined( var2.script_objective ) )
        {
            if ( var2.script_objective == "door" )
            {
                waypoint_door( var1, var2 );
            }
            else if ( var2.script_objective == "look_at" )
            {
                var3 = 0.1;
                
                if ( isdefined( var2.script_wait ) )
                {
                    var3 = var2.script_wait;
                }
                
                var1 botlookatpoint( var2.origin, var3 );
            }
            else
            {
                handle_objective_location( var1, var2 );
            }
        }
        
        if ( isdefined( var2.script_wait ) )
        {
            wait var2.script_wait;
        }
        
        if ( isdefined( var2.script_triggername ) )
        {
            scripts\engine\utility::flag_set( var2.script_triggername );
        }
        
        if ( !isdefined( var2.target ) )
        {
            break;
        }
    }
}

// Params 1
// Size: 0x72
function handle_objective_location( var0 )
{
    var1 = self;
    var2 = var0.origin;
    var3 = var0.angles[ 1 ];
    var4 = 10;
    
    if ( isdefined( var0.radius ) )
    {
        var4 = var0.radius;
    }
    
    var1 botsetflag( "disable_movement", 0 );
    var1 botsetflag( "disable_rotation", 0 );
    var1 botclearscriptgoal();
    var5 = var1 botsetscriptgoal( var2, var4, var0.script_objective, var3, undefined, 1 );
    
    if ( !var5 )
    {
        return var5;
    }
    
    var5 = var1 scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
    return 1;
}

// Params 1
// Size: 0x71
function waypoint_door( var0 )
{
    var1 = 200;
    
    if ( isdefined( var0.script_radius ) )
    {
        var1 = var0.script_radius;
    }
    
    var2 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, var1, "door" );
    
    if ( !isdefined( var0.script_parameters ) || var2.size == 0 )
    {
    }
    
    foreach ( var4 in var2 )
    {
        var4 scripts\mp\tutorial\br_tut_utility::scriptable_door_operation( var0.script_parameters );
    }
}

