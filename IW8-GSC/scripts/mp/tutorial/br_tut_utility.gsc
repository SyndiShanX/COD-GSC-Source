
// Params 3
// Size: 0x8f
function tutorialinit( var0, var1, var2 )
{
    level.ttlos_suppressasserts = 1;
    level.ref_133e0 = 1;
    level.codcasterenabled = 0;
    level.prematchperiodend = 0;
    level.br_infils_disabled = 1;
    level.skipprematchdropspawn = 1;
    level.usegulag = 0;
    thread ongametypeready();
    thread ontutorialplayerconnect( var0 );
    
    if ( isdefined( var1 ) && isbuiltinfunction( var1 ) || isdefined( var2 ) && isbuiltinfunction( var2 ) )
    {
        thread ontutorialplayerfirstspawn( var1, var2 );
    }
    
    clear_objectives();
    level scripts\common\ui::lui_registercallback( "end_game", &tutorialutilonendgame );
    level scripts\common\ui::lui_registercallback( "allObjectivesComplete", &tutorialutilonallobjectivescomplete );
    level.∏/âÊãQŸÿ?∏¿#·ôSœ{=ÛAº‡¯Ô = gettime();
}

// Params 0
// Size: 0x38
function ongametypeready()
{
    while ( !isdefined( level.disable_super_in_turret ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.disable_super_in_turret.funcs ) )
    {
        waitframe();
    }
    
    level.disable_super_in_turret.funcs[ "playerWelcomeSplashes" ] = &emptyfunction;
}

// Params 0
// Size: 0x2
function emptyfunction()
{
    
}

// Params 1
// Size: 0x5f
function ontutorialplayerconnect( var0 )
{
    for ( ;; )
    {
        level waittill( "connected", var1 );
        
        if ( !isbot( var1 ) )
        {
            var1.delay_give_tactical_grenade = 0;
            var1.manualoverridewindmaterial = 1;
            var1.haspickedupplunderyet = 1;
            var1.highlight_atvs_until_router = [];
            var1 setclientomnvar( "ui_br_infiled", 1 );
            
            if ( isdefined( var0 ) && isbuiltinfunction( var0 ) )
            {
                self [[ var0 ]]( var1 );
            }
        }
    }
}

// Params 2
// Size: 0x48
function ontutorialplayerfirstspawn( var0, var1 )
{
    for ( ;; )
    {
        self waittill( "player_spawned", var2 );
        
        if ( !isbot( var2 ) )
        {
            if ( isdefined( var0 ) && isbuiltinfunction( var0 ) )
            {
                self thread [[ var0 ]]( var2 );
            }
            
            if ( isdefined( var1 ) && isbuiltinfunction( var1 ) )
            {
                thread onplayerammoupdate( var2 );
            }
            
            break;
        }
    }
}

// Params 1
// Size: 0x11
function onplayerammoupdate( var0 )
{
    self waittill( "ammo_update" );
    self [[ var0 ]]();
}

// Params 1
// Size: 0x3f
function tutorialutilonendgame( var0 )
{
    for ( var1 = 0; var1 < level.íLz0CA/¡≤ÂUHÉß ; var1++ )
    {
        if ( isdefined( level.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] ) && level.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] < level.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var1 ] )
        {
            send_objective_event( level, var1, 0, 1 );
        }
    }
}

// Params 1
// Size: 0x3f
function tutorialutilonallobjectivescomplete( var0 )
{
    for ( var1 = 0; var1 < level.íLz0CA/¡≤ÂUHÉß ; var1++ )
    {
        if ( isdefined( level.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] ) && level.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] < level.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var1 ] )
        {
            send_objective_event( level, var1, 1, 0 );
        }
    }
}

// Params 3
// Size: 0x12
function waittill_is_meleeing( var0, var1, var2 )
{
    return waittill_action_performed( &ismeleeing, var0, var1, var2 );
}

// Params 3
// Size: 0x12
function waittill_is_sprinting( var0, var1, var2 )
{
    return waittill_action_performed( &issprinting, var0, var1, var2 );
}

// Params 3
// Size: 0x12
function waittill_is_jumping( var0, var1, var2 )
{
    return waittill_action_performed( &isjumping, var0, var1, var2 );
}

// Params 3
// Size: 0x12
function waittill_is_mantling( var0, var1, var2 )
{
    return waittill_action_performed( &ismantling, var0, var1, var2 );
}

// Params 3
// Size: 0x13
function waittill_is_prone( var0, var1, var2 )
{
    return waittill_action_performed( &isprone, var0, var1, var2 );
}

// Params 3
// Size: 0x13
function waittill_is_crouching( var0, var1, var2 )
{
    return waittill_action_performed( &iscrouching, var0, var1, var2 );
}

// Params 3
// Size: 0x13
function waittill_is_standing( var0, var1, var2 )
{
    return waittill_action_performed( &isstanding, var0, var1, var2 );
}

// Params 3
// Size: 0x13
function waittill_is_shooting( var0, var1, var2 )
{
    return waittill_action_performed( &isshooting, var0, var1, var2 );
}

// Params 3
// Size: 0x13
function waittill_is_ads( var0, var1, var2 )
{
    return waittill_action_performed( &scripts\mp\utility\player::isplayerads, var0, var1, var2 );
}

// Params 3
// Size: 0x12
function waittill_is_reloading( var0, var1, var2 )
{
    return waittill_action_performed( &isreloading, var0, var1, var2 );
}

// Params 4
// Size: 0xbc
function waittill_action_performed( var0, var1, var2, var3 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = level.player;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0.1;
    }
    
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    var4 = 0;
    
    if ( isanimation( var0 ) )
    {
        if ( isdefined( var3 ) && var3 > 0 )
        {
            var5 = 0;
            
            while ( var5 < var3 )
            {
                if ( var1 builtin [[ var0 ]]() )
                {
                    var4 = 1;
                    break;
                }
                
                wait var2;
                var5 += var2;
            }
        }
        else
        {
            while ( !var1 builtin [[ var0 ]]() )
            {
                wait var2;
            }
            
            var4 = 1;
        }
        
        return var4;
    }
    
    if ( isdefined( var3 ) && var3 > 0 )
    {
        var5 = 0;
        
        while ( var5 < var3 )
        {
            if ( var1 [[ var0 ]]() )
            {
                var4 = 1;
                break;
            }
            
            wait var2;
            var5 += var2;
        }
    }
    else
    {
        while ( !var1 [[ var0 ]]() )
        {
            wait var2;
        }
        
        var4 = 1;
    }
    
    return var4;
}

// Params 1
// Size: 0x54
function waittill_leave_trigger( var0 )
{
    var1 = var0 + "_leave";
    
    if ( !scripts\engine\utility::flag_exist( var1 ) )
    {
        scripts\engine\utility::flag_init( var1 );
    }
    
    thread internal_monitor_trigger( var0, var1 );
    scripts\engine\utility::flag_wait( var1 );
    
    for ( ;; )
    {
        scripts\engine\utility::flag_clear( var1 );
        wait 0.25;
        
        if ( !scripts\engine\utility::flag( var1 ) )
        {
            self notify( "stop_monitor_" + var0 );
            break;
        }
    }
}

// Params 2
// Size: 0x33
function internal_monitor_trigger( var0, var1 )
{
    self endon( "stop_monitor_" + var0 );
    var2 = scripts\engine\utility::getent_or_struct( var0, "targetname" );
    
    if ( isdefined( var2 ) )
    {
        for ( ;; )
        {
            var2 waittill( "trigger" );
            scripts\engine\utility::flag_set( var1 );
        }
        
        return;
    }
}

// Params 4
// Size: 0x69
function show_hud_message_while_in_trigger_volume( var0, var1, var2, var3 )
{
    for ( ;; )
    {
        var4 = scripts\engine\utility::getent_or_struct( var1, "targetname" );
        
        if ( isdefined( var4 ) )
        {
            var4 waittill( "trigger" );
            level.player sethudtutorialmessage( var0 );
            
            if ( isdefined( var3 ) )
            {
                level.player playlocalsound( var3 );
            }
            else
            {
                level.player playlocalsound( "text_box_new" );
            }
            
            waittill_leave_trigger( var1 );
            level.player clearhudtutorialmessage();
            
            if ( var2 == 1 )
            {
                return;
            }
        }
    }
}

// Params 0
// Size: 0x16, Type: bool
function isstanding()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return self getstance() == "stand";
}

// Params 0
// Size: 0x16, Type: bool
function iscrouching()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return self getstance() == "crouch";
}

// Params 0
// Size: 0x16, Type: bool
function isprone()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return self getstance() == "prone";
}

// Params 0
// Size: 0x24, Type: bool
function isshooting()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.watch_for_players_touching_ground ) )
    {
        return false;
    }
    
    return gettime() - self.watch_for_players_touching_ground < 400;
}

// Params 2
// Size: 0xc, Type: bool
function islocationping( var0, var1 )
{
    return var0 == scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_getpoolidnavigation();
}

// Params 2
// Size: 0x16, Type: bool
function isobjectping( var0, var1 )
{
    return scripts\cp\vehicles\little_bird_mg_cp::addpostlaunchspawns( var0 ) || scripts\cp\vehicles\little_bird_mg_cp::addplundercarrycredit( var0 );
}

// Params 2
// Size: 0x1e
function isarmorping( var0, var1 )
{
    if ( !isobjectping( var0, var1 ) )
    {
        return 0;
    }
    
    return scripts\mp\gametypes\br_public::isarmorplate( var1.type );
}

// Params 2
// Size: 0x23
function isweaponping( var0, var1 )
{
    if ( !isobjectping( var0, var1 ) )
    {
        return 0;
    }
    
    return scripts\engine\utility::string_starts_with( var1.type, "brloot_weapon" );
}

// Params 2
// Size: 0x22, Type: bool
function ishostileping( var0, var1 )
{
    return scripts\cp\vehicles\little_bird_mg_cp::addplayeraslootleader( var0 ) || isent( var1 ) && scripts\cp\vehicles\little_bird_mg_cp::additionalrecondronetargets( var1, level.player );
}

// Params 1
// Size: 0x50
function waittill_player_pings( var0 )
{
    for ( ;; )
    {
        self waittill( "luinotifyserver", var1, var2 );
        
        if ( !isdefined( var1 ) || var1 != "calloutmarkerping_added" )
        {
            continue;
        }
        
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        if ( !isdefined( var0 ) )
        {
            return;
        }
        
        var3 = self calloutmarkerping_getsavedzoffset( var2 );
        
        if ( [[ var0 ]]( var2, var3 ) == 1 )
        {
            return;
        }
    }
}

// Params 5
// Size: 0x7e
function add_objective( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé ) )
    {
        self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé = [];
    }
    
    if ( !isdefined( self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê ) )
    {
        self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê = [];
    }
    
    if ( !isdefined( self.´‘Xv‡%∑ÎKè‡Û0; ) )
    {
        self.´‘Xv‡%∑ÎKè‡Û0; = [];
    }
    
    if ( !isdefined( self.íLz0CA/¡≤ÂUHÉß ) || self.íLz0CA/¡≤ÂUHÉß <= var0 )
    {
        self.íLz0CA/¡≤ÂUHÉß = var0 + 1;
    }
    
    self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] = 0;
    self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var0 ] = var2;
    self.´‘Xv‡%∑ÎKè‡Û0;[ var0 ] = var1;
    self.Ü∏â"WœË_Õö	Òµ˙¸Ô≤èHg.[ var0 ] = var4;
    thread objective_monitor_func_wrapper( var3, var0 );
}

// Params 2
// Size: 0x29
function objective_monitor_func_wrapper( var0, var1 )
{
    self endon( "allObjectivesComplete" );
    self endon( "end_game" );
    
    for ( ;; )
    {
        self [[ var0 ]]();
        
        if ( has_completed_objective( var1 ) )
        {
            break;
        }
    }
}

// Params 3
// Size: 0xc9
function send_objective_event( var0, var1, var2 )
{
    var3 = getsystemtime();
    var4 = var3 - self.≠	™∏:PÎ;∞Ë—´yv‹®Vòdùâ;
    
    if ( var1 == 0 && var2 == 0 )
    {
        self.≠	™∏:PÎ;∞Ë—´yv‹®Vòdùâ = var3;
    }
    
    self.players[ 0 ] dlog_recordplayerevent( "dlog_event_tutorial_objective", [ "area", self.ä7GË∞e2·ªãGûè*:˘h;ò›, "objective", self.Ü∏â"WœË_Õö	Òµ˙¸Ô≤èHg.[ var0 ], "duration_s", var4, "player_x", self.player.origin[ 0 ], "player_y", self.player.origin[ 1 ], "player_z", self.player.origin[ 2 ], "player_yaw", scripts\engine\utility::getplayeryaw( self.player ), "player_pitch", scripts\engine\utility::getplayerpitch( self.player ), "end_area", var1, "end_game", var2 ] );
}

// Params 5
// Size: 0xd1
function add_objectives_for_area( var0, var1, var2, var3, var4 )
{
    level.åﬁ‘≤çË¥Ÿ≤πÍKúY,»º = 0;
    setomnvar( "ui_br_objective_types", var0 + 1 << 8 );
    self.≠	™∏:PÎ;∞Ë—´yv‹®Vòdùâ = getsystemtime();
    self.ä7GË∞e2·ªãGûè*:˘h;ò› = var1;
    
    for ( var5 = 0;  ; var5++ )
    {
        var6 = tablelookupbyrow( var2, var5, 0 );
        
        if ( var6 == "" )
        {
            break;
        }
        
        var7 = int( var6 );
        
        if ( var7 == var0 )
        {
            var8 = tablelookupbyrow( var2, var5, 1 );
            
            if ( var8 == "" )
            {
                iprintln( "TUT ERROR: missing objectiveID at row " + var5 );
                return;
            }
            
            var9 = int( var8 );
            var10 = tablelookupbyrow( var2, var5, 3 );
            var11 = 1;
            
            if ( var10 == "" )
            {
            }
            else
            {
                var11 = int( var10 );
            }
            
            var12 = tablelookupbyrow( var2, var5, 4 );
            add_objective( var9, var8, var11, var3[ var9 ], var12 );
        }
    }
    
    if ( isdefined( var4 ) )
    {
        thread monitor_objectives_progress( var4 );
    }
    
    level.åﬁ‘≤çË¥Ÿ≤πÍKúY,»º = 1;
}

// Params 1
// Size: 0x5a
function monitor_objectives_progress( var0 )
{
    var1 = 15000;
    var2 = 0;
    var3 = 0;
    var4 = 0;
    
    while ( !has_completed_all_objectives() )
    {
        if ( var2 != num_completed_objectives() )
        {
            scripts\mp\tutorial\br_tut_ui::stop_nagging();
            var3 = gettime();
            var2 = num_completed_objectives();
            var4 = 0;
        }
        else if ( gettime() - var3 > var1 )
        {
            if ( !var4 )
            {
                scripts\mp\tutorial\br_tut_ui::start_nagging( var0 );
                var4 = 1;
            }
        }
        
        wait 0.1;
    }
}

// Params 0
// Size: 0x2a
function clear_objectives()
{
    self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé = undefined;
    self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê = undefined;
    self.´‘Xv‡%∑ÎKè‡Û0; = undefined;
    self.íLz0CA/¡≤ÂUHÉß = 0;
    self.≠	™∏:PÎ;∞Ë—´yv‹®Vòdùâ = 0;
    setomnvar( "ui_br_objective_types", 0 );
}

// Params 1
// Size: 0x87
function increment_objective( var0 )
{
    self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ]++;
    
    while ( !level.åﬁ‘≤çË¥Ÿ≤πÍKúY,»º )
    {
        wait 0.1;
    }
    
    if ( self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] < self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var0 ] )
    {
        setomnvarbit( "ui_br_objective_types", var0, 0 );
    }
    else
    {
        setomnvarbit( "ui_br_objective_types", var0, 1 );
        
        if ( !has_completed_all_objectives() )
        {
            play_checklist_sound( 0 );
        }
    }
    
    if ( isdefined( self.Ü∏â"WœË_Õö	Òµ˙¸Ô≤èHg.[ var0 ] ) )
    {
        send_objective_event( var0, 0, 0 );
    }
    
    waitframe();
    
    if ( has_completed_all_objectives() )
    {
        play_checklist_sound( 1 );
        self notify( "allObjectivesComplete" );
        return;
    }
}

// Params 1
// Size: 0x25, Type: bool
function has_completed_objective( var0 )
{
    if ( var0 < self.íLz0CA/¡≤ÂUHÉß )
    {
        if ( self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] >= self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var0 ] )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x3b
function num_completed_objectives()
{
    var0 = 0;
    
    for ( var1 = 0; var1 < self.íLz0CA/¡≤ÂUHÉß ; var1++ )
    {
        if ( isdefined( self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] ) && self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var1 ] >= self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var1 ] )
        {
            var0++;
        }
    }
    
    return var0;
}

// Params 0
// Size: 0x37, Type: bool
function has_completed_all_objectives()
{
    for ( var0 = 0; var0 < self.íLz0CA/¡≤ÂUHÉß ; var0++ )
    {
        if ( isdefined( self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] ) && self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] < self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var0 ] )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x8
function get_num_objectives()
{
    return self.íLz0CA/¡≤ÂUHÉß;
}

// Params 1
// Size: 0x40
function get_text_for_objective( var0 )
{
    var1 = "^7";
    
    if ( has_completed_objective( var0 ) )
    {
        var1 = "^+";
    }
    
    return var1 + self.´‘Xv‡%∑ÎKè‡Û0;[ var0 ] + ": " + self.Å—ˆâMïçé-ŸYπ˙∞lé¥ÏV}ÿ{´πé[ var0 ] + "/" + self.±€ƒ©Vçéñ≥Yπ˙;€∞c˙∆ﬁ]Ê[ var0 ];
}

// Params 3
// Size: 0x36
function init_resource_spawners( var0, var1, var2 )
{
    var3 = getentarray( var0, var1 );
    
    foreach ( var5 in var3 )
    {
        thread spawn_resource( var5, var2 );
    }
}

// Params 2
// Size: 0x69
function spawn_resource( var0, var1 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = 15;
    }
    
    for ( ;; )
    {
        if ( !isdefined( var0.•œ+ ÂCÁª≥;À ) )
        {
            wait var1;
            var2 = var0.script_noteworthy;
            
            if ( isdefined( var2 ) )
            {
                var0.•œ+ ÂCÁª≥;À = easepower( var2, var0.origin, var0.angles );
                scripts\mp\gametypes\br_pickups::ref_12b3a( var0.•œ+ ÂCÁª≥;À );
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Params 2
// Size: 0x34
function init_doors( var0, var1 )
{
    var2 = getentarray( var0, var1 );
    
    foreach ( var4 in var2 )
    {
        init_door( var4 );
    }
}

// Params 1
// Size: 0x149
function init_door( var0 )
{
    if ( isdefined( var0.initialized ) )
    {
        return;
    }
    
    var0.heli_intro = var0.angles;
    
    if ( isdefined( level.player ) )
    {
        var1 = vectornormalize( level.player.origin - var0.origin );
        
        if ( isdefined( var0.right ) )
        {
            var2 = vectordot( var0.right, var1 );
            var3 = var2 > 0;
        }
        else
        {
            var3 = 1;
        }
        
        var1.ref_1211f = scripts\engine\utility::ter_op( var3, var1.heli_intro - ( 0, 90, 0 ), var1.heli_intro + ( 0, 90, 0 ) );
    }
    
    if ( isdefined( var1.target ) )
    {
        var4 = getentarray( var1.target, "targetname" );
        
        foreach ( var6 in var4 )
        {
            switch ( var6.classname )
            {
                case "script_brushmodel":
                    var1.clip = var6;
                    var1.clip linkto( var1 );
                    break;
                case "script_model":
                    var1.ref_1211f = var6.angles;
                    var6 delete();
                    break;
                default:
                    break;
            }
        }
    }
    
    var1.initialized = 1;
}

// Params 2
// Size: 0x7f
function open_door( var0, var1 )
{
    var2 = getentarray( var0, "targetname" );
    
    if ( isdefined( var2 ) )
    {
        foreach ( var4 in var2 )
        {
            open_entity_door( var4, var1 );
        }
    }
    
    var6 = getentitylessscriptablearrayinradius( var0, "targetname" );
    
    if ( isdefined( var6 ) )
    {
        foreach ( var4 in var6 )
        {
            scriptable_door_operation( var4, "open", var1 );
        }
        
        return;
    }
}

// Params 2
// Size: 0xb3
function open_entity_door( var0, var1 )
{
    if ( isdefined( var0.opened ) && var0.opened == 1 )
    {
        return;
    }
    
    if ( !isdefined( var0.initialized ) )
    {
        init_door( var0 );
    }
    
    switch ( var0.classname )
    {
        case "script_origin":
        case "script_brushmodel":
        case "script_model":
            if ( isdefined( var1 ) )
            {
                thread scripts\engine\utility::play_sound_in_space( var1, var0.origin + ( 0, 0, 30 ) );
            }
            
            var0.opened = 1;
            var0 rotateto( var0.ref_1211f, 1, 0.2, 0.8 );
            break;
        default:
            var0.opened = 1;
            waitframe();
            break;
    }
}

// Params 1
// Size: 0xde
function ref_12116( var0 )
{
    var1 = getent( var0, "targetname" );
    
    if ( isdefined( var1.clip ) )
    {
        var1.clip = getent( var1.target, "targetname" );
        var1.clip linkto( var1 );
    }
    
    var2 = 90;
    
    if ( isdefined( var1.script_parameters ) )
    {
        var2 = float( var1.script_parameters );
    }
    
    var3 = var1.origin + anglestoright( var1.angles ) * var2;
    var4 = 2.8;
    thread scripts\engine\utility::play_sound_in_space( "gate_buzzer", var1.origin );
    wait 0.55;
    thread scripts\engine\utility::play_sound_in_space( "tut_lrg_metal_door_open", var1.origin );
    var1 moveto( var3, var4, var4 * 0.1, var4 * 0.9 );
    
    if ( isdefined( var1.clip ) )
    {
        if ( var1.clip.spawnflags & 1 )
        {
            var1.clip connectpaths();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x15
function freeze_scriptable_door( var0 )
{
    var1 = self;
    
    if ( !var1 scriptabledoorisclosed() )
    {
        return;
    }
    
    var1 scriptabledoorfreeze( var0 );
}

// Params 2
// Size: 0x7f
function close_door( var0, var1 )
{
    var2 = getentarray( var0, "targetname" );
    
    if ( isdefined( var2 ) )
    {
        foreach ( var4 in var2 )
        {
            close_entity_door( var4, var1 );
        }
    }
    
    var6 = getentitylessscriptablearrayinradius( var0, "targetname" );
    
    if ( isdefined( var6 ) )
    {
        foreach ( var4 in var6 )
        {
            scriptable_door_operation( var4, "close", var1 );
        }
        
        return;
    }
}

// Params 2
// Size: 0xb2
function close_entity_door( var0, var1 )
{
    if ( !isdefined( var0.opened ) || var0.opened == 0 )
    {
        return;
    }
    
    if ( !isdefined( var0.initialized ) )
    {
        init_door( var0 );
    }
    
    switch ( var0.classname )
    {
        case "script_origin":
        case "script_brushmodel":
        case "script_model":
            if ( isdefined( var1 ) )
            {
                thread scripts\engine\utility::play_sound_in_space( var1, var0.origin + ( 0, 0, 30 ) );
            }
            
            var0.opened = 0;
            var0 rotateto( var0.heli_intro, 1, 0.2, 0.8 );
            break;
        default:
            var0.closed = 1;
            waitframe();
            break;
    }
}

// Params 4
// Size: 0x69
function targetted_door_operation( var0, var1, var2, var3 )
{
    if ( !isdefined( var2 ) )
    {
        var2 = 50;
    }
    
    var4 = getentarray( var1, "script_noteworthy" );
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    var5 = getentitylessscriptablearrayinradius( undefined, undefined, var4[ 0 ].origin, var2, "door" );
    
    if ( var5.size == 0 )
    {
    }
    
    foreach ( var7 in var5 )
    {
        thread scriptable_door_operation( var7, var0 );
    }
}

// Params 2
// Size: 0xb1
function scriptable_door_operation( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var1 ) )
    {
        thread scripts\engine\utility::play_sound_in_space( var1, var2.origin + ( 0, 0, 30 ) );
    }
    
    switch ( var0 )
    {
        case "freeze":
            var2 scriptabledoorfreeze( 1 );
            break;
        case "thaw":
            var2 scriptabledoorfreeze( 0 );
            break;
        case "open":
            if ( var2 scriptabledoorisclosed() )
            {
                var2 constraintoscriptgoalradius();
            }
            
            break;
        case "close":
            if ( !var2 scriptabledoorisclosed() )
            {
                var2 vehicle_getinputvalue();
            }
            
            break;
        case "lock":
            if ( !var2 scriptabledoorisclosed() )
            {
                var2 vehicle_getinputvalue();
                
                while ( !var2 scriptabledoorisclosed() )
                {
                    waitframe();
                }
            }
            
            var2 scriptabledoorfreeze( 1 );
            break;
    }
}

// Params 2
// Size: 0x35
function monitor_trigger_for_player( var0, var1 )
{
    var2 = getent( var0, "targetname" );
    
    for ( ;; )
    {
        var2 waittill( "trigger", var3 );
        
        if ( var3 == level.player )
        {
            scripts\engine\utility::flag_set( var1 );
            break;
        }
    }
}

// Params 0
// Size: 0xa7
function update_player_trigger()
{
    self endon( "stop" );
    var0 = self;
    
    if ( isdefined( self.script_parameters ) )
    {
        if ( self.script_parameters == "door" )
        {
            setup_door_trigger();
        }
        
        if ( isstartstr( self.script_parameters, "bots<" ) )
        {
            thread trigger_on_bots_remaining();
        }
    }
    
    jumpiftrue(scripts\engine\utility::flag_exist( self.script_triggername )) LOC_00000055;
    scripts\engine\utility::flag_init( self.script_triggername );
    
    for ( ;; )
    {
        var0 waittill( "trigger", var1 );
        
        if ( var1 == level.player )
        {
            if ( isdefined( self.script_parameters ) && self.script_parameters == "shots" )
            {
                thread trigger_on_shot_fired( var1 );
            }
            else
            {
                scripts\engine\utility::flag_set( self.script_triggername );
            }
            
            break;
        }
    }
}

// Params 1
// Size: 0x37
function load_player_triggers( var0 )
{
    var1 = getentarray( var0, "targetname" );
    
    foreach ( var3 in var1 )
    {
        thread update_player_trigger();
    }
}

// Params 1
// Size: 0x2a
function trigger_on_door_open( var0 )
{
    level endon( "game_ended" );
    level endon( var0 );
    
    for ( ;; )
    {
        wait 0.5;
        
        if ( !self scriptabledoorisclosed() )
        {
            scripts\engine\utility::flag_set( var0 );
            break;
        }
    }
}

// Params 0
// Size: 0x52
function setup_door_trigger()
{
    var0 = self;
    var1 = 75;
    
    if ( isdefined( var0.script_radius ) )
    {
        var1 = int( var0.script_radius );
    }
    
    var2 = getentitylessscriptablearrayinradius( undefined, undefined, var0.origin, var1, "door" );
    
    if ( !isdefined( var2 ) || var2.size != 1 )
    {
        return;
    }
    
    thread trigger_on_door_open( var2[ 0 ] );
}

// Params 0
// Size: 0x8f
function trigger_on_bots_remaining()
{
    level endon( "game_ended" );
    level endon( self.script_triggername );
    var0 = int( getsubstr( self.script_parameters, 5 ) );
    
    for ( ;; )
    {
        jumpiftrue(isdefined( level.Øå9≠PH“?CSo )) LOC_00000030;
        wait 0.5;
    }
    
    for ( ;; )
    {
        wait 0.5;
        var1 = 0;
        
        foreach ( var3 in level.Øå9≠PH“?CSo )
        {
            if ( isalive( scripts\mp\tutorial\br_tut_bots::bot_entity( var3 ) ) )
            {
                var1 += 1;
            }
        }
        
        if ( var1 < var0 )
        {
            break;
        }
    }
    
    scripts\engine\utility::flag_set( self.script_triggername );
}

// Params 1
// Size: 0x58
function trigger_on_shot_fired( var0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( var0 );
    level endon( "game_ended" );
    
    if ( !scripts\engine\utility::flag_exist( var0 ) )
    {
        scripts\engine\utility::flag_init( var0 );
    }
    
    if ( !isdefined( self.watch_for_players_touching_ground ) )
    {
        return;
    }
    
    var1 = gettime();
    
    for ( ;; )
    {
        wait 0.1;
        
        if ( self.watch_for_players_touching_ground - var1 > 0 )
        {
            scripts\engine\utility::flag_set( var0 );
            return;
        }
    }
}

// Params 1
// Size: 0x14e
function debug_show_map_bounds( var0 )
{
    jumpiffalse(getdvarint( "scr_br_showMapBounds", 0 ) == 0) LOC_00000012;
    return;
}

// Params 1
// Size: 0x7, Type: bool
function circletimer( var0 )
{
    return true;
}

// Params 0
// Size: 0x25
function monitorarmorplateusage()
{
    while ( level.player calloutmarkerping_entityzoffset( "ui_br_armor_amount" ) < 1 )
    {
        wait 0.1;
    }
    
    level.ô
◊-Í¿2ìñÔ‡ = 1;
}

// Params 1
// Size: 0x57
function play_checklist_sound( var0 )
{
    if ( !isdefined( self.∏/âÊãQŸÿ?∏¿#·ôSœ{=ÛAº‡¯Ô ) )
    {
        self.∏/âÊãQŸÿ?∏¿#·ôSœ{=ÛAº‡¯Ô = gettime();
    }
    
    if ( self.∏/âÊãQŸÿ?∏¿#·ôSœ{=ÛAº‡¯Ô + 0.25 < gettime() || var0 )
    {
        self.∏/âÊãQŸÿ?∏¿#·ôSœ{=ÛAº‡¯Ô = gettime();
        
        if ( var0 )
        {
            level.player playsound( "checklist_completed" );
            return;
        }
        
        level.player playsound( "item_completed" );
        return;
    }
}

