
// Params 0
// Size: 0x48
function init()
{
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É = spawnstruct();
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.encounters = [];
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.Šs+‡ú²7ÛºæVN}Ò = 0;
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¡}@Û·9gµ8lï = 0;
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¬sªJõÈSAÓ.J# = [];
    init_dvars();
    init_defaults();
}

// Params 0
// Size: 0x18
function init_dvars()
{
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.ºnÒñ)]†”n = getdvarint( "scr_default_maxagents", 48 );
}

// Params 1
// Size: 0x1e, Type: bool
function can_request_num_agents( var0 )
{
    return var0 <= level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.ºnÒñ)]†”n - level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¡}@Û·9gµ8lï;
}

// Params 1
// Size: 0x20
function end_encounter_by_id( var0 )
{
    var1 = level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.encounters[ var0 ];
    
    if ( isdefined( var1 ) )
    {
        end_encounter( var1 );
        return;
    }
}

// Params 0
// Size: 0x55
function init_defaults()
{
    _handlevehiclerepair::init();
    var0 = [];
    GscBinSkip0( 0x2e, "nothing", 1 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x30
function get_agent_class_by_name( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¬sªJõÈSAÓ.J#[ var0 ] ) )
    {
        var0 = "default";
    }
    
    return level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¬sªJõÈSAÓ.J#[ var0 ];
}

// Params 2
// Size: 0x4c
function make_spawn_params_list( var0, var1 )
{
    if ( !isdefined( var0 ) || var0.size <= 0 )
    {
        return level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.§2°heW{¼;#ÁAoÕ©ã*f@}š;
    }
    
    var2 = spawnstruct();
    var2.spawn_type = "list";
    var2.spawn_points = var0;
    var2.ºİøoªg8'CBÛ—;õ = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 0 );
    return var2;
}

// Params 3
// Size: 0x50
function make_spawn_params_radius( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.spawn_type = "radius";
    var3.¦Ók´›}N‘-«Í = scripts\engine\utility::ter_op( isdefined( var0 ), var0, 100 );
    var3.– %Ïqqú¡°?w0 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 2500 );
    var3.ºİøoªg8'CBÛ—;õ = scripts\engine\utility::ter_op( isdefined( var2 ), var2, 0 );
    return var3;
}

// Params 4
// Size: 0x69
function init_encounter_params_swarm( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.type = "swarm";
    var4.ŠÖ"çó;øv·À K4k:ûî = scripts\engine\utility::ter_op( isdefined( var0 ), var0, 1 );
    var4.ºÅ{eÈI…ñ&z•C = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 9999 );
    var4.class = get_agent_class_by_name( var2 );
    var4.†‹¸ãAóÅá·Æ®: = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.§2°heW{¼;#ÁAoÕ©ã*f@}š );
    return var4;
}

// Params 2
// Size: 0x47
function init_encounter_params_waves( var0, var1 )
{
    var2 = spawnstruct();
    var2.type = "waves";
    var2.ŠLİgYn = var0;
    var2.ŠÖ"çó;øv·À K4k:ûî = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 1 );
    var2.†‹¸ãAóÅá·Æ®: = level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.§2°heW{¼;#ÁAoÕ©ã*f@}š;
    return var2;
}

// Params 4
// Size: 0x5a
function make_wave( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.¢Â%1©!øc3p = scripts\engine\utility::ter_op( isdefined( var0 ), var0, 1 );
    var4.„ÉÃÈ;†{¦§#
Càêª(ñ = scripts\engine\utility::ter_op( isdefined( var1 ), var1, 0 );
    var4.†‹¸ãAóÅá·Æ®: = scripts\engine\utility::ter_op( isdefined( var3 ), var3, level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.§2°heW{¼;#ÁAoÕ©ã*f@}š );
    var4.class = get_agent_class_by_name( var2 );
    return var4;
}

// Params 5
// Size: 0x6f
function register_agent_class( var0, var1, var2, var3, var4 )
{
    if ( isdefined( var0 ) )
    {
        var5 = spawnstruct();
        var5.type = scripts\engine\utility::ter_op( isdefined( var1 ), var1, "actor_enemy_lw_br" );
        var5.ref_1404d = scripts\engine\utility::ter_op( isdefined( var2 ), var2, 0 );
        var5.ƒÅ{{£ë1ØVë[•ò = scripts\engine\utility::ter_op( isdefined( var3 ), var3, "agent_encounter_manager_default" );
        var5.¡‰j
`KÔs÷»Àğ«p™ = scripts\engine\utility::ter_op( isdefined( var4 ), var4, 1 );
        level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¬sªJõÈSAÓ.J#[ var0 ] = var5;
        return;
    }
}

// Params 2
// Size: 0xfb
function start_encounter( var0, var1 )
{
    if ( !validate_new_encounter( var1 ) )
    {
        return undefined;
    }
    
    var2 = spawnstruct();
    var2.id = level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.Šs+‡ú²7ÛºæVN}Ò;
    var2.agents = [];
    var2.params = var1;
    var2.origin = var0;
    var2.ºnÒñ)]†”n = var1.ŠÖ"çó;øv·À K4k:ûî;
    var2.Œ7¨W:öÿxñû = 0;
    var2.—Å°ı?fGÌZÀ€ò = 0;
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.Šs+‡ú²7ÛºæVN}Ò++;
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¡}@Û·9gµ8lï += var1.ŠÖ"çó;øv·À K4k:ûî;
    
    if ( !isdefined( var1.type ) )
    {
        var1.type = "swarm";
    }
    
    switch ( var1.type )
    {
        case "waves":
            thread wave_encounter_think();
            break;
        case "swarm":
            thread swarm_encounter_think();
            break;
        default:
            break;
    }
    
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.encounters[ var2.id ] = var2;
    return var2;
}

// Params 1
// Size: 0x39, Type: bool
function validate_new_encounter( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.ŠÖ"çó;øv·À K4k:ûî ) )
    {
        return false;
    }
    
    if ( !can_request_num_agents( var0.ŠÖ"çó;øv·À K4k:ûî ) )
    {
        return false;
    }
    
    if ( !isdefined( var0.†‹¸ãAóÅá·Æ®: ) )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x68
function end_encounter()
{
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.¡}@Û·9gµ8lï -= self.params.ŠÖ"çó;øv·À K4k:ûî;
    
    foreach ( var1 in self.agents )
    {
        var1 despawnagent();
    }
    
    level.“mÂ¥¯V7Æö]ÍYÉ¾¶æXì•É.encounters[ self.id ] = undefined;
    self notify( "encounter_end" );
}

// Params 0
// Size: 0x104
function wave_encounter_think()
{
    level endon( "game_ended" );
    self endon( "encounter_end" );
    wave_encounter_set_wave( 0 );
    
    for ( ;; )
    {
        var0 = self.initoperatorunlocks;
        
        while ( self.Œ7¨W:öÿxñû < self.•

ÍêÚ}:{°c )
        {
            if ( self.agents.size >= self.ºnÒñ)]†”n || scripts\mp\mp_agent::getfreeagentcount() <= 0 )
            {
                break;
            }
            
            var1 = rear_door_collision( var0.†‹¸ãAóÅá·Æ®: );
            
            if ( isdefined( var1 ) )
            {
                spawn_agent( var1[ 0 ], var1[ 1 ], var0.class, var0.†‹¸ãAóÅá·Æ®:.ºİøoªg8'CBÛ—;õ );
            }
            
            waitframe();
        }
        
        if ( self.Œ7¨W:öÿxñû >= self.•

ÍêÚ}:{°c && self.•

ÍêÚ}:{°c - self.—Å°ı?fGÌZÀ€ò <= var0.„ÉÃÈ;†{¦§#
Càêª(ñ )
        {
            if ( self.¸O‹ÑÄ—Ñ@Í|EÙ + 1 >= self.params.ŠLİgYn.size )
            {
                break;
            }
            
            wave_encounter_set_wave( self.¸O‹ÑÄ—Ñ@Í|EÙ + 1 );
            continue;
        }
        
        self waittill( "agent_death" );
        wait 1;
    }
    
    while ( self.agents.size > 0 )
    {
        self waittill( "agent_death" );
    }
    
    end_encounter();
}

// Params 1
// Size: 0x5c
function wave_encounter_set_wave( var0 )
{
    if ( var0 < 0 || var0 >= self.params.ŠLİgYn.size )
    {
        return;
    }
    
    self.¸O‹ÑÄ—Ñ@Í|EÙ = var0;
    self.initoperatorunlocks = self.params.ŠLİgYn[ var0 ];
    self.Œ7¨W:öÿxñû = self.agents.size;
    self.•

ÍêÚ}:{°c = self.initoperatorunlocks.¢Â%1©!øc3p + self.agents.size;
    self.—Å°ı?fGÌZÀ€ò = 0;
}

// Params 0
// Size: 0xab
function swarm_encounter_think()
{
    level endon( "game_ended" );
    self endon( "encounter_end" );
    self.•

ÍêÚ}:{°c = self.params.ºÅ{eÈI…ñ&z•C;
    
    while ( self.Œ7¨W:öÿxñû < self.•

ÍêÚ}:{°c )
    {
        if ( self.agents.size >= self.ºnÒñ)]†”n || scripts\mp\mp_agent::getfreeagentcount() <= 0 )
        {
            self waittill( "agent_death" );
            wait 1;
        }
        
        var0 = rear_door_collision();
        
        if ( isdefined( var0 ) )
        {
            spawn_agent( var0[ 0 ], var0[ 1 ], self.params.class, self.params.†‹¸ãAóÅá·Æ®:.ºİøoªg8'CBÛ—;õ );
        }
        
        waitframe();
    }
    
    while ( self.—Å°ı?fGÌZÀ€ò < self.•

ÍêÚ}:{°c )
    {
        self waittill( "agent_death" );
    }
    
    end_encounter();
}

// Params 5
// Size: 0xab
function spawn_agent( var0, var1, var2, var3, var4 )
{
    if ( self.agents.size >= self.ºnÒñ)]†”n )
    {
        return undefined;
    }
    
    if ( scripts\mp\mp_agent::getfreeagentcount() <= 0 )
    {
        return undefined;
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = "team_two_hundred";
    }
    
    var5 = undefined;
    
    if ( var3 && isdefined( level.£'¡Šã^ø…4™›%ª¨¯Û™èƒ›š· ) )
    {
        var5 = _testing_ending::spawnnewparachuteagent( var0, var1, var2.ref_1404d, var2.type, var4 );
    }
    else
    {
        var5 = _testing_ending::spawnnewagent( var0, var1, var2.ref_1404d, var2.type, var4 );
    }
    
    if ( isdefined( var5 ) )
    {
    }
    
    var5.class = var2;
    var5.isinlaststand = &handle_agent_death_info;
    self.Œ7¨W:öÿxñû++;
    self.agents[ self.agents.size ] = var5;
    thread watch_agent_death( var5 );
    return var5;
}

// Params 1
// Size: 0x56
function rear_door_collision( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = self.params.†‹¸ãAóÅá·Æ®:;
    }
    
    var1 = undefined;
    
    switch ( var0.spawn_type )
    {
        case "radius":
            var1 = get_spawn_point_radius( var0 );
            break;
        case "list":
            var1 = get_spawn_point_from_list( var0 );
            break;
        default:
            break;
    }
    
    return var1;
}

// Params 1
// Size: 0x48
function get_spawn_point_radius( var0 )
{
    var1 = randomfloatrange( 0, 360 );
    var2 = anglestoforward( ( 0, var1, 0 ) );
    var3 = randomfloatrange( var0.¦Ók´›}N‘-«Í, var0.– %Ïqqú¡°?w0 );
    var4 = self.origin + var2 * var3;
    var4 = getclosestpointonnavmesh( var4 );
    return [ var4, ( 0, randomfloatrange( 0, 360 ), 0 ) ];
}

// Params 1
// Size: 0x1c
function get_spawn_point_from_list( var0 )
{
    var1 = randomintrange( 0, var0.spawn_points.size );
    return var0.‡‰À[¨pÀHü_[ var1 ];
}

// Params 1
// Size: 0x18
function inrease_ai_budget_by( var0 )
{
    self.ºnÒñ)]†”n += var0;
    self notify( "agent_death" );
}

// Params 1
// Size: 0x39
function watch_agent_death( var0 )
{
    level endon( "game_ended" );
    self endon( "encounter_end" );
    var0 waittill( "death" );
    self.agents = scripts\engine\utility::array_remove( self.agents, var0 );
    self.—Å°ı?fGÌZÀ€ò++;
    self notify( "agent_death" );
}

// Params 1
// Size: 0x39
function handle_agent_death_info( var0 )
{
    var1 = [];
    GscBinSkip0( 0x2e, "eAttacker", var0.eattacker );
    // Unknown operator ( 0x2e, iw8, PC )
}

