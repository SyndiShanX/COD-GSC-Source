
// Params 0
// Size: 0x21
function init()
{
    level.²Ù
•‡¯…íØÃS2ÛàèK¸(Ä = getdvarint( "scr_br_danger_notify_height", 1000 );
    level.²ŠØêsˆß3ãú«W”µØë = getdvarint( "scr_br_danger_notify_owner", 1 );
}

// Params 0
// Size: 0xa, Type: bool
function playercanpickupkillstreak()
{
    return !isdefined( self.brkillstreak );
}

// Params 1
// Size: 0x32
function takekillstreakpickup( var0 )
{
    var1 = level.br_pickups.br_equipname[ var0.scriptablename ];
    self.brkillstreak = var1;
    playerkillstreakhud( var1 );
    playergivetriggerweapon();
    thread playerhandlekillstreak( var1 );
}

// Params 1
// Size: 0x83
function playerkillstreakhud( var0 )
{
    self.brkillstreakhudlabel = scripts\mp\hud_util::createfontstring( "default", 0.75 );
    self.brkillstreakhudlabel scripts\mp\hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -70 );
    self.brkillstreakhudlabel.label = &"MP_BR_ACTIVATE_KILLSTREAK";
    var1 = game[ "killstreakTable" ].tabledatabyref[ var0 ][ "hudIcon" ];
    self.brkillstreakhudicon = scripts\mp\hud_util::createicon( var1, 30, 30 );
    self.brkillstreakhudicon scripts\mp\hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -45 );
}

// Params 0
// Size: 0x22
function playergivetriggerweapon()
{
    self giveweapon( "super_default_mp" );
    self setweaponammoclip( "super_default_mp", 1 );
    self assignweaponoffhandspecial( "super_default_mp" );
}

// Params 1
// Size: 0x43
function playerhandlekillstreak( var0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "special_weapon_fired", var1 );
        var2 = playertriggerkillstreak();
        
        if ( var2 )
        {
            playerremovekillstreak();
            return;
        }
        
        self setweaponammoclip( "super_default_mp", 1 );
    }
}

// Params 0
// Size: 0x22, Type: bool
function playertriggerkillstreak()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    var0 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct( self.brkillstreak );
    var1 = scripts\mp\killstreaks\killstreaks::triggerkillstreak( var0 );
    return istrue( var1 );
}

// Params 0
// Size: 0x37
function playerremovekillstreak()
{
    self takeweapon( "super_default_mp" );
    self.brkillstreak = undefined;
    
    if ( isdefined( self.brkillstreakhudlabel ) )
    {
        self.brkillstreakhudlabel destroy();
    }
    
    if ( isdefined( self.brkillstreakhudicon ) )
    {
        self.brkillstreakhudicon destroy();
        return;
    }
}

// Params 4
// Size: 0x75
function isbulletpenetration( var0, var1, var2, var3 )
{
    var4 = scripts\common\utility::playersincylinder( var0, var1, undefined, level.²Ù
•‡¯…íØÃS2ÛàèK¸(Ä );
    
    if ( !isdefined( var3 ) )
    {
        var3 = 1;
    }
    
    foreach ( var8 in var4 )
    {
        if ( isdefined( var8 ) && scripts\mp\utility\player::isreallyalive( var8 ) && ( var8.team != self.team || level.²ŠØêsˆß3ãú«W”µØë && var8 == self ) )
        {
            isbrsquadleader( var8, var2, var3 );
        }
    }
}

// Params 4
// Size: 0x190
function isbrsquadleader( var0, var1, var2, var3 )
{
    if ( isdefined( level.isbotpracticematch ) && isdefined( level.isbrgametypefuncdefined ) )
    {
        if ( isdefined( level.isbrgametypefuncdefined[ var1 ] ) && isdefined( level.isbrgametypefuncdefined[ var1 ][ var0.guid ] ) && gettime() < level.isbrgametypefuncdefined[ var1 ][ var0.guid ] )
        {
            var2 = 0;
        }
        else
        {
            level.isbrgametypefuncdefined[ var1 ][ var0.guid ] = gettime() + level.isbotpracticematch * 1000;
        }
    }
    
    if ( istrue( var2 ) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue( var1 ) )
    {
        var4 = scripts\mp\gametypes\br_public::disableannouncer( self );
        var5 = var4 + "_enemy_" + var1 + "_inbound";
        var0 scripts\mp\utility\dialog::leaderdialogonplayer( var5, "killstreak_used" );
    }
    
    var6 = spawnstruct();
    var6.ref_12466 = istrue( var2 );
    var6.ref_11ed2 = var1;
    
    switch ( var1 )
    {
        case "toma_strike":
            var1 = 1;
            break;
        case "precision_airstrike":
            var1 = 2;
            break;
        case "gulag_closed":
            var1 = 3;
            break;
        case "cash_deploy_closed":
            var1 = 4;
            break;
        case "respawn_disabled":
            var1 = 5;
            break;
        case "lep_toma_strike":
            var1 = 6;
            break;
        case "kenosha_strike":
            var1 = 7;
            break;
        case "greenbay_strike":
            var1 = 8;
            break;
        case "fafir_strike":
            var1 = 9;
            break;
        default:
            var1 = 0;
            break;
    }
    
    if ( var1 > 0 )
    {
        var0 setclientomnvar( "ui_br_danger_warning", var1 );
        isbunkeraltenabled( var0, var3 );
    }
    
    var0 scripts\mp\gametypes\br_gametypes::ref_12e05( "onKillstreakDanger", var6 );
}

// Params 2
// Size: 0x37
function isbunkeraltenabled( var0, var1 )
{
    var2 = var0 getxuid();
    
    if ( !isdefined( var1 ) )
    {
        var1 = 4;
    }
    
    level notify( "danger_notify_start_" + var2 );
    thread ref_14499( level, var0, var2 );
    thread ref_14499( level, var0, var2, undefined );
}

// Params 4
// Size: 0x4f
function ref_14499( var0, var1, var2, var3 )
{
    level endon( "danger_notify_start_" + var1 );
    level endon( "danger_notify_finished_" + var1 );
    level endon( "game_ended" );
    
    if ( isdefined( var2 ) )
    {
        var0 waittill( var2 );
    }
    else if ( isdefined( var3 ) )
    {
        wait var3;
    }
    
    if ( isdefined( var0 ) )
    {
        var0 setclientomnvar( "ui_br_danger_warning", 0 );
    }
    
    level notify( "danger_notify_finished_" + var1 );
}

