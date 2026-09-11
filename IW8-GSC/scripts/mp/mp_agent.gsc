
// Params 1
// Size: 0x14a
function init_agent( var0 )
{
    if ( !isdefined( level.agent_definition ) )
    {
        level.agent_definition = [];
    }
    
    init_spawn_times();
    var1 = [];
    GscBinSkip0( 0x2e, "species", 3 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x10
function init_spawn_times()
{
    level.agent_available_to_spawn_time = [];
    level.agent_recycle_interval = 500;
}

// Params 0
// Size: 0x40
function setup_bt_and_asm()
{
    var0 = level.agent_definition[ self.agent_type ];
    
    if ( !isdefined( var0[ "behaviorTree" ] ) || var0[ "behaviorTree" ] == "" )
    {
        return;
    }
    
    scripts\mp\agents\scriptedagents::ai_init( var0[ "behaviorTree" ], var0[ "asm" ] );
}

// Params 1
// Size: 0x43
function setupweapon( var0 )
{
    self.weapon = var0;
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.grenadeweapon = isundefinedweapon();
    self.grenadeammo = 0;
}

// Params 0
// Size: 0x59
function ref_131fd()
{
    if ( !isdefined( level.gameskill ) )
    {
        level.gameskill = 0;
        level.difficultytype[ 0 ] = "mp";
        level.difficultysettings[ "sniper_converge_scale" ][ level.difficultytype[ level.gameskill ] ] = 1.3;
        level.difficultysettings[ "sniperAccuDiffScale" ][ level.difficultytype[ level.gameskill ] ] = 1;
        return;
    }
}

// Params 1
// Size: 0xa
function setup_spawn_struct( var0 )
{
    self.spawner = var0;
}

// Params 4
// Size: 0x44
function spawnnewagentaitype( var0, var1, var2, var3 )
{
    if ( !scripts\engine\utility::string_starts_with( var0, "actor_" ) )
    {
        var0 = "actor_" + var0;
    }
    
    if ( !isdefined( level.agent_definition[ var0 ] ) )
    {
        return undefined;
    }
    
    var4 = spawnnewagent( var0, level.agent_definition[ var0 ][ "team" ], var1, var2 );
    return var4;
}

// Params 6
// Size: 0xfc
function spawnnewagent( var0, var1, var2, var3, var4, var5 )
{
    var6 = getfreeagent( var0 );
    
    if ( isdefined( var6 ) )
    {
        if ( !isdefined( var3 ) )
        {
            var3 = ( 0, 0, 0 );
        }
        
        var6.connecttime = gettime();
        
        if ( isdefined( var5 ) )
        {
            setup_spawn_struct( var6, var5 );
        }
        
        if ( !isdefined( var1 ) )
        {
            var1 = "axis";
        }
        
        set_agent_team( var6, var1 );
        set_agent_model( var6, var6, var0 );
        set_agent_species( var6, var6, var0 );
        
        if ( is_scripted_agent( var0 ) )
        {
            var6 = spawn_scripted_agent( var6, var0, var2, var3 );
        }
        else
        {
            var6 = spawn_regular_agent( var6, var2, var3 );
        }
        
        set_agent_team( var6, var1 );
        setup_agent( var6, var0 );
        set_agent_spawn_health( var6, var6, var0 );
        set_agent_traversal_unit_type( var6, var6, var0 );
        add_to_characters_array( var6 );
        ref_131fd( var6 );
        
        if ( is_using_behaviortree( var0 ) )
        {
            setup_bt_and_asm( var6 );
        }
        
        if ( isdefined( var4 ) )
        {
            if ( issameweapon( var4 ) )
            {
                setupweapon( var6, var4 );
            }
            else
            {
                return undefined;
            }
        }
        
        activateagent( var6 );
        var6 scripts\engine\utility::set_ai_number();
    }
    
    return var6;
}

// Params 0
// Size: 0x1e
function watch_for_team_undefined()
{
    self endon( "death" );
    
    for ( ;; )
    {
        if ( !isdefined( self.team ) )
        {
            level notify( "agent_missing_team" );
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x32
function set_agent_traversal_unit_type( var0, var1 )
{
    if ( !can_set_traversal_unit_type( var0 ) )
    {
        return;
    }
    
    if ( !isdefined( anim.animselector ) )
    {
        scripts\anim\animselector::init();
    }
    
    var0.unittype = level.agent_definition[ var1 ][ "traversal_unit_type" ];
}

// Params 1
// Size: 0x12, Type: bool
function can_set_traversal_unit_type( var0 )
{
    if ( is_agent_scripted( var0 ) )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x3c
function set_agent_model( var0, var1 )
{
    var2 = level.agent_definition[ var1 ][ "setup_model_func" ];
    
    if ( isdefined( var2 ) )
    {
        var0 [[ var2 ]]( var1 );
        return;
    }
    
    var0 detachall();
    var0 setmodel( level.agent_definition[ var1 ][ "body_model" ] );
    var0 show();
}

// Params 1
// Size: 0x18, Type: bool
function is_scripted_agent( var0 )
{
    return level.agent_definition[ var0 ][ "animclass" ] != "";
}

// Params 1
// Size: 0x25, Type: bool
function is_using_behaviortree( var0 )
{
    if ( !isdefined( level.agent_definition[ var0 ] ) )
    {
        return false;
    }
    
    return level.agent_definition[ var0 ][ "behaviorTree" ] != "";
}

// Params 4
// Size: 0xab
function spawn_scripted_agent( var0, var1, var2, var3 )
{
    var0.onenteranimstate = speciesfunc( var0, "on_enter_animstate" );
    var0.is_scripted_agent = 1;
    var4 = level.agent_definition[ var1 ][ "radius" ];
    
    if ( !isdefined( var4 ) )
    {
        var4 = 15;
    }
    
    var5 = level.agent_definition[ var1 ][ "height" ];
    
    if ( !isdefined( var5 ) )
    {
        var5 = 50;
    }
    
    var6 = level.agent_definition[ var1 ][ "legacy" ];
    
    if ( !isdefined( var6 ) || isstring( var6 ) )
    {
        var6 = 0;
    }
    
    var0 spawnagent( var2, var3, level.agent_definition[ var1 ][ "animclass" ], var4, var5, undefined, var6 );
    var0.agent_height = var5;
    var0.agent_radius = var4;
    var0.legacy = spawnstruct();
    return var0;
}

// Params 3
// Size: 0x18
function spawn_regular_agent( var0, var1, var2 )
{
    var0.is_scripted_agent = 0;
    var0 spawnagent( var1, var2 );
    return var0;
}

// Params 1
// Size: 0xc
function is_agent_scripted( var0 )
{
    return var0.is_scripted_agent;
}

// Params 5
// Size: 0x23
function agent_go_to_pos( var0, var1, var2, var3, var4 )
{
    if ( is_agent_scripted( self ) )
    {
        self setgoalpos( var0 );
        return;
    }
    
    self botsetscriptgoal( var0, var1, var2, var3, var4 );
}

// Params 1
// Size: 0x27
function setup_agent( var0 )
{
    var1 = level.agent_definition[ var0 ];
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = var1[ "setup_func" ];
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    self [[ var2 ]]();
}

// Params 2
// Size: 0xc6
function set_agent_species( var0, var1 )
{
    if ( !isdefined( level.agent_funcs[ var1 ] ) )
    {
        level.agent_funcs[ var1 ] = [];
    }
    
    var0.species = level.agent_definition[ var1 ][ "species" ];
    
    if ( isdefined( var0.species ) && !isdefined( level.species_funcs[ var0.species ] ) || !isdefined( level.species_funcs[ var0.species ][ "on_enter_animstate" ] ) )
    {
        level.species_funcs[ var0.species ] = [];
        level.species_funcs[ var0.species ][ "on_enter_animstate" ] = &default_on_enter_animstate;
    }
    
    assign_agent_func( "spawn", &default_spawn_func );
    assign_agent_func( "on_damaged", &default_on_damage );
    assign_agent_func( "on_damaged_finished", &default_on_damage_finished );
    assign_agent_func( "on_killed", &default_on_killed );
}

// Params 2
// Size: 0x60
function assign_agent_func( var0, var1 )
{
    var2 = self.agent_type;
    
    if ( !isdefined( level.agent_funcs[ var2 ][ var0 ] ) )
    {
        if ( !isdefined( level.species_funcs[ self.species ] ) || !isdefined( level.species_funcs[ self.species ][ var0 ] ) )
        {
            level.agent_funcs[ var2 ][ var0 ] = var1;
            return;
        }
        
        level.agent_funcs[ var2 ][ var0 ] = level.species_funcs[ self.species ][ var0 ];
        return;
    }
}

// Params 2
// Size: 0x19
function set_agent_spawn_health( var0, var1 )
{
    set_agent_health( var0, level.agent_definition[ var1 ][ "health" ] );
}

// Params 1
// Size: 0xc
function get_agent_type( var0 )
{
    return var0.agent_type;
}

// Params 0
// Size: 0x9f
function getfreeagentcount()
{
    if ( !isdefined( level.agentarray ) )
    {
        return 0;
    }
    
    var0 = gettime();
    var1 = 0;
    
    foreach ( var3 in level.agentarray )
    {
        if ( !isdefined( var3.isactive ) || !var3.isactive )
        {
            if ( isdefined( var3.waitingtodeactivate ) && var3.waitingtodeactivate )
            {
                continue;
            }
            
            var4 = var3 getentitynumber();
            
            if ( isdefined( level.agent_available_to_spawn_time ) && isdefined( level.agent_available_to_spawn_time[ var4 ] ) && var0 < level.agent_available_to_spawn_time[ var4 ] )
            {
                continue;
            }
            
            var1++;
        }
    }
    
    return var1;
}

// Params 1
// Size: 0xc5
function getfreeagent( var0 )
{
    var1 = undefined;
    var2 = gettime();
    
    if ( isdefined( level.agentarray ) )
    {
        foreach ( var4 in level.agentarray )
        {
            if ( !isdefined( var4.isactive ) || !var4.isactive )
            {
                if ( isdefined( var4.waitingtodeactivate ) && var4.waitingtodeactivate )
                {
                    continue;
                }
                
                var5 = var4 getentitynumber();
                
                if ( isdefined( level.agent_available_to_spawn_time ) )
                {
                    if ( isdefined( level.agent_available_to_spawn_time[ var5 ] ) && var2 < level.agent_available_to_spawn_time[ var5 ] )
                    {
                        continue;
                    }
                    
                    level.agent_available_to_spawn_time[ var5 ] = undefined;
                }
                
                var1 = var4;
                var1.agent_type = var0;
                initagentscriptvariables( var1 );
                var1 notify( "agent_in_use" );
                break;
            }
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x52
function initagentscriptvariables()
{
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.spawntime = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self detachall();
    initplayerscriptvariables();
}

// Params 0
// Size: 0xa7
function initplayerscriptvariables()
{
    self.class = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    scripts\common\input_allow::clear_allow_info( "weapon" );
    scripts\common\input_allow::clear_allow_info( "weaponSwitch" );
    scripts\common\input_allow::clear_allow_info( "offhandWeaps" );
    scripts\common\input_allow::clear_allow_info( "usability" );
    self.nocorpse = undefined;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.ten_percent_of_max_health = undefined;
    self.command_given = undefined;
    self.current_icon = undefined;
    self.do_immediate_ragdoll = undefined;
    
    if ( isdefined( level.gametype_agent_init ) )
    {
        self [[ level.gametype_agent_init ]]();
        return;
    }
}

// Params 2
// Size: 0x30
function set_agent_team( var0, var1 )
{
    self.team = var0;
    self.agentteam = var0;
    self.pers[ "team" ] = var0;
    self.owner = var1;
    self setotherent( var1 );
    self setentityowner( var1 );
}

// Params 0
// Size: 0x31
function add_to_characters_array()
{
    for ( var0 = 0; var0 < level.characters.size ; var0++ )
    {
        if ( level.characters[ var0 ] == self )
        {
            return;
        }
    }
    
    level.characters[ level.characters.size ] = self;
}

// Params 1
// Size: 0x12
function agentfunc( var0 )
{
    return level.agent_funcs[ self.agent_type ][ var0 ];
}

// Params 1
// Size: 0x12
function speciesfunc( var0 )
{
    return level.species_funcs[ self.species ][ var0 ];
}

// Params 1
// Size: 0x3c
function validateattacker( var0 )
{
    if ( isagent( var0 ) && ( !isdefined( var0.isactive ) || !var0.isactive ) )
    {
        return undefined;
    }
    
    if ( isagent( var0 ) && !isdefined( var0.classname ) )
    {
        return undefined;
    }
    
    return var0;
}

// Params 1
// Size: 0x16
function set_agent_health( var0 )
{
    self.agenthealth = var0;
    self.health = var0;
    self.maxhealth = var0;
}

// Params 3
// Size: 0x6
function default_spawn_func( var0, var1, var2 )
{
    
}

// Params 2
// Size: 0x63, Type: bool
function is_friendly_damage( var0, var1 )
{
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.team ) && var1.team == var0.team )
        {
            return true;
        }
        
        if ( isdefined( var1.owner ) && isdefined( var1.owner.team ) && var1.owner.team == var0.team )
        {
            return true;
        }
    }
    
    return false;
}

// Params 13
// Size: 0x259
function default_on_damage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    var13 = self;
    var14 = undefined;
    
    if ( istrue( self.‚¶c¹ÐçÛ@ç÷ûAöË¸!ë§õé‡"ÑÏö?a ) )
    {
        var2 = int( var2 * 0 );
    }
    
    if ( istrue( self.ˆŠäYÈÕ+}¥æ±½ÚZ¹³}¶+±Ê+ë2…k°ìÊ ) && var4 == "MOD_MELEE" )
    {
        var2 = int( var2 * 0.1 );
    }
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) )
    {
        var14 = level.agent_funcs[ self.unittype ][ "gametype_on_damaged" ];
    }
    
    if ( isdefined( var14 ) )
    {
        var15 = [[ var14 ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        
        if ( isdefined( var15 ) )
        {
            return var15;
        }
    }
    else
    {
        var14 = level.agent_funcs[ self.agent_type ][ "gametype_on_damaged" ];
        
        if ( isdefined( var14 ) )
        {
            [[ var14 ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        }
    }
    
    if ( is_friendly_damage( var13, var0 ) )
    {
        return;
    }
    
    if ( istrue( var13.agentdamagefeedback ) )
    {
        var16 = 0;
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "isKillstreakWeapon" ) )
        {
            var16 = isdefined( var12 ) && [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "isKillstreakWeapon" ) ]]( var12.basename );
            
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "handleDamageFeedback" ) )
            {
                var1 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "handleDamageFeedback" ) ]]( var0, var1, var13, var2, var4, var12, var8, var3, 0, 0, var16 );
            }
        }
    }
    
    if ( istrue( self.„jïiÏ[_iïñzÐ·[–¸þ7Xá@ÉëÎcÇr ) )
    {
        self [[ level.agent_funcs[ var13.unittype ][ "on_damaged" ] ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11 );
    }
    
    if ( isdefined( level.binoculars_runadslogic ) )
    {
        var13 [[ level.binoculars_runadslogic ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11 );
        return;
    }
    
    if ( isdefined( var13.unittype ) && isdefined( level.agent_funcs[ var13.unittype ] ) && isdefined( level.agent_funcs[ var13.unittype ][ "on_damaged_finished" ] ) )
    {
        var13 [[ level.agent_funcs[ var13.unittype ][ "on_damaged_finished" ] ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11 );
        return;
    }
    
    var13 [[ level.agent_funcs[ var13.agent_type ][ "on_damaged_finished" ] ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11 );
}

// Params 15
// Size: 0x120
function default_on_damage_finished( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    var15 = self.health;
    var16 = var5;
    self.damagedby = var1;
    self.damagepoint = var6;
    self finishagentdamage( var0, var1, var2, var3, var4, var16, var6, var7, var8, var9, 0, var11, var12 );
    
    if ( self.health > 0 && self.health < var15 )
    {
        self notify( "pain" );
        scripts\asm\asm_mp::ref_12e1d();
    }
    
    if ( isalive( self ) )
    {
        if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) && isdefined( level.agent_funcs[ self.unittype ][ "gametype_on_damage_finished" ] ) )
        {
            var17 = level.agent_funcs[ self.unittype ][ "gametype_on_damage_finished" ];
            
            if ( isdefined( var17 ) )
            {
                [[ var17 ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
                return;
            }
            
            return;
        }
        
        if ( isdefined( self.agent_type ) )
        {
            var17 = level.agent_funcs[ self.agent_type ][ "gametype_on_damage_finished" ];
            
            if ( isdefined( var17 ) )
            {
                [[ var17 ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 9
// Size: 0xcd
function default_on_killed( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( isdefined( self.on_zombie_agent_killed_common ) )
    {
        self [[ self.on_zombie_agent_killed_common ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, 0 );
    }
    else
    {
        on_humanoid_agent_killed_common( var0, var1, var2, var3, var4, var5, var6, var7, var8, 0 );
    }
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) && isdefined( level.agent_funcs[ self.unittype ][ "gametype_on_killed" ] ) )
    {
        var9 = level.agent_funcs[ self.unittype ][ "gametype_on_killed" ];
        
        if ( isdefined( var9 ) )
        {
            [[ var9 ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8 );
        }
    }
    else
    {
        var9 = level.agent_funcs[ self.agent_type ][ "gametype_on_killed" ];
        
        if ( isdefined( var9 ) )
        {
            [[ var9 ]]( var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        }
    }
    
    deactivateagent();
}

// Params 2
// Size: 0x43
function default_on_enter_animstate( var0, var1 )
{
    self.aistate = var1;
    
    switch ( var1 )
    {
        case "traverse":
            self.do_immediate_ragdoll = 1;
            scripts\asm\shared\mp\utility::dotraversal();
            self.do_immediate_ragdoll = 0;
            break;
        default:
            break;
    }
    
    cleardamagehistory();
}

// Params 0
// Size: 0xe
function cleardamagehistory()
{
    self.recentdamages = [];
    self.damagelistindex = 0;
}

// Params 0
// Size: 0x17
function deactivateagent()
{
    var0 = self getentitynumber();
    level.agent_available_to_spawn_time[ var0 ] = gettime() + 500;
}

// Params 1
// Size: 0x1a
function getnumactiveagents( var0 )
{
    if ( !isdefined( var0 ) )
    {
        var0 = "all";
    }
    
    var1 = getactiveagentsoftype( var0 );
    return var1.size;
}

// Params 1
// Size: 0x6b
function getactiveagentsoftype( var0 )
{
    var1 = [];
    
    if ( !isdefined( level.agentarray ) )
    {
        return var1;
    }
    
    foreach ( var3 in level.agentarray )
    {
        if ( isdefined( var3.isactive ) && var3.isactive )
        {
            if ( var0 == "all" || var3.agent_type == var0 )
            {
                var1 = var3;
            }
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x52
function getaliveagentsofteam( var0 )
{
    var1 = [];
    
    foreach ( var3 in level.agentarray )
    {
        if ( isalive( var3 ) && isdefined( var3.team ) && var3.team == var0 )
        {
            var1 = var3;
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x61
function getactiveagentsofspecies( var0 )
{
    var1 = [];
    
    if ( !isdefined( level.agentarray ) )
    {
        return var1;
    }
    
    foreach ( var3 in level.agentarray )
    {
        if ( isdefined( var3.isactive ) && var3.isactive )
        {
            if ( var3.species == var0 )
            {
                var1 = var3;
            }
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x39
function getaliveagents()
{
    var0 = [];
    
    foreach ( var2 in level.agentarray )
    {
        if ( isalive( var2 ) )
        {
            var0 = var2;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x11
function activateagent()
{
    self.isactive = 1;
    self.spawn_time = gettime();
}

// Params 2
// Size: 0x26, Type: bool
function bot_choose_attack_role( var0, var1 )
{
    if ( var0 != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( var1 ) )
    {
        return false;
    }
    
    if ( !var1 scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        return false;
    }
    
    return true;
}

// Params 10
// Size: 0x28b
function on_humanoid_agent_killed_common( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    var10 = bot_choose_attack_role( var3, var0 );
    self asmdodeathtransition( self.asmname );
    
    if ( isdefined( self.deathanimduration ) )
    {
        var8 = self.deathanimduration;
    }
    else if ( var8 == 0 )
    {
        var8 = 500;
    }
    
    if ( isdefined( self.fncleanupbt ) )
    {
        self [[ self.fncleanupbt ]]();
    }
    
    if ( isdefined( self.nocorpse ) )
    {
        return;
    }
    
    var11 = self;
    self.body = self cloneagent( var8 );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( isdefined( var3 ) && var3 == "MOD_FIRE" )
        {
            self.ragdoll_directionscale = 0;
        }
        
        if ( !istrue( self._blackboard.invehicle ) || istrue( self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll ) )
        {
            if ( var10 )
            {
                self.body isbnetigrplayer( var0 );
                return;
            }
            
            if ( should_do_immediate_ragdoll( self ) )
            {
                if ( isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
                {
                    self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
                    return;
                }
                
                do_immediate_ragdoll( self.body );
                return;
            }
            
            thread delaystartragdoll( self.body, var6, var5, var4, var0, var3 );
            return;
        }
        
        self.body enablelinkto();
        
        if ( istrue( self._blackboard.chosenvehicleanimpos.linktoblend ) )
        {
            self.body linktoblendtotag( self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag, 0 );
        }
        else
        {
            self.body linktomoveoffset( self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag );
        }
        
        if ( isdefined( self._blackboard.vehicledeathwait ) )
        {
            thread delaystartragdoll( self.body, var6, var4, var0, var3 );
            return;
        }
        
        thread ref_129e6( self.body );
        return;
    }
    
    if ( istrue( self.burningtodeath ) )
    {
        if ( self isscriptable() )
        {
            var12 = self getscriptablepartstate( "burn_to_death_by_molotov", 1 );
            
            if ( isdefined( var12 ) && var12 == "active" )
            {
                self.body setscriptablepartstate( "burn_to_death_by_molotov", "active" );
                thread ref_13fc8( self.body );
                thread delaystartragdoll( self.body, var6, var5, var4, var0, var3 );
                return;
            }
            
            return;
        }
        
        return;
    }
    
    if ( var11 )
    {
        self.body isbnetigrplayer( var1 );
        return;
    }
    
    if ( should_do_immediate_ragdoll( self ) )
    {
        if ( isdefined( self.ragdollhitloc ) && isdefined( self.ragdollimpactvector ) )
        {
            self.body startragdollfromimpact( self.ragdollhitloc, self.ragdollimpactvector );
            return;
        }
        
        do_immediate_ragdoll( self.body );
        return;
    }
    
    thread delaystartragdoll( self.body, var7, var6, var5, var1, var4 );
}

// Params 1
// Size: 0x3e
function ref_129e6( var0 )
{
    self endon( "entitydeleted" );
    
    if ( self isragdoll() )
    {
        return;
    }
    
    if ( isdefined( var0 ) )
    {
        for ( ;; )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( var0 ) || var0 scripts\common\vehicle_code::vehicle_iscorpse() )
            {
                self unlink();
                self startragdoll();
                return;
            }
            
            waitframe();
        }
        
        return;
    }
}

// Params 1
// Size: 0x22, Type: bool
function should_do_immediate_ragdoll( var0 )
{
    if ( istrue( var0.do_immediate_ragdoll ) )
    {
        return true;
    }
    
    if ( istrue( var0.forceragdollimmediate ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x12d
function do_immediate_ragdoll( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( isdefined( var0.ragdollhitloc ) && isdefined( var0.ragdollimpactvector ) )
    {
        var0 startragdollfromimpact( var0.ragdollhitloc, var0.ragdollimpactvector );
        return;
    }
    
    var1 = 10;
    var2 = scripts\common\utility::getdamagetype( self.damagemod );
    
    if ( isdefined( self.attacker ) && isplayer( self.attacker ) && var2 == "melee" )
    {
        var1 = 5;
    }
    
    var3 = self.damagetaken;
    
    if ( var2 == "bullet" || isdefined( self.damagemod ) && self.damagemod == "MOD_FIRE" )
    {
        var3 = min( var3, 300 );
    }
    
    var4 = var1 * var3;
    var5 = max( 0.3, self.damagedir[ 2 ] );
    var6 = ( self.damagedir[ 0 ], self.damagedir[ 1 ], var5 );
    
    if ( isdefined( self.ragdoll_directionscale ) )
    {
        var6 *= self.ragdoll_directionscale;
    }
    else
    {
        var6 *= var4;
    }
    
    if ( self.forceragdollimmediate )
    {
        var6 += self.prevanimdelta * 20 * 10;
    }
    
    if ( isdefined( self.ragdoll_start_vel ) )
    {
        var6 += self.ragdoll_start_vel * 10;
    }
    
    var7 = self.damagelocation;
    
    if ( isdefined( self.ragdoll_damagelocation_none ) && var7 == "none" )
    {
        var7 = self.ragdoll_damagelocation_none;
    }
    
    var0 startragdollfromimpact( var7, var6 );
}

// Params 6
// Size: 0x132
function delaystartragdoll( var0, var1, var2, var3, var4, var5 )
{
    if ( isdefined( var0 ) )
    {
        var6 = var0 getcorpseanim();
        
        if ( animhasnotetrack( var6, "ignore_ragdoll" ) )
        {
            return;
        }
    }
    
    if ( isdefined( level.noragdollents ) && level.noragdollents.size )
    {
        foreach ( var8 in level.noragdollents )
        {
            if ( distancesquared( var0.origin, var8.origin ) < 65536 )
            {
                return;
            }
        }
    }
    
    waitframe();
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( var0 isragdoll() )
    {
        return;
    }
    
    var6 = var0 getcorpseanim();
    
    if ( animisleaf( var6 ) )
    {
        var10 = 0.35;
        var11 = getnotetracktimes( var6, "start_ragdoll" );
        
        if ( isdefined( var11 ) && var11.size > 0 )
        {
            var10 = var11[ 0 ];
        }
        else
        {
            var11 = getnotetracktimes( var6, "vehicle_death_ragdoll" );
            
            if ( isdefined( var11 ) && var11.size > 0 )
            {
                var10 = var11[ 0 ];
            }
        }
        
        var12 = var10 * getanimlength( var6 ) - level.frameduration / 1000;
        
        if ( var12 > 0 )
        {
            wait var12;
        }
    }
    
    self unlink();
    
    if ( isdefined( var0 ) )
    {
        if ( isdefined( var0.ragdollhitloc ) && isdefined( var0.ragdollimpactvector ) )
        {
            var0 startragdollfromimpact( var0.ragdollhitloc, var0.ragdollimpactvector );
            return;
        }
        
        var0 startragdoll();
        return;
    }
}

// Params 1
// Size: 0x57
function ref_13fc8( var0 )
{
    var1 = self.asm.archetype == "soldier_lw_br";
    
    if ( !var1 )
    {
        wait 0.7;
    }
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 getwartrackpassengerenabled( "burntbody_male_cp", 1 );
    
    if ( !var1 )
    {
        var0 dontinterpolate();
    }
    
    wait 0.95;
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 setscriptablepartstate( "burn_to_death_by_molotov", "inactive" );
}

