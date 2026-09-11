
// Params 0
// Size: 0x19e
function init()
{
    var0 = spawnstruct();
    var0.ref_11b78 = getdvarint( "scr_br_pe_plunder_crate_max_times", 2 );
    var0.isfeaturedisabled = &deactivate;
    var0.ref_140cf = &ref_140d1;
    var0.attackerswaittime = &atv_initdamage;
    var0.‹Á¿ø{ÏXX;â# / = &postinitplundercrate;
    var0.weight = getdvarfloat( "scr_br_pe_plunder_crate_weight", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "plunder_crate", "20   15  10  10          10  15  10  10" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "plunder_crate" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 12, var0 );
    var0 = spawnstruct();
    var0.ref_11b78 = getdvarint( "scr_br_pe_weapon_crate_max_times", 2 );
    var0.isfeaturedisabled = &deactivate;
    var0.attackerswaittime = &aud_breached_exit_wind;
    var0.ref_140cf = &ref_140d8;
    var0.‹Á¿ø{ÏXX;â# / = &postinitweaponcrate;
    var0.weight = getdvarfloat( "scr_br_pe_weapon_crate_weight", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "weapon_crate", "20   15  10  10          10  15  20  25" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "weapon_crate" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 13, var0 );
    var0 = spawnstruct();
    var0.ref_11b78 = getdvarint( "scr_br_pe_medical_crate_max_times", 2 );
    var0.isfeaturedisabled = &deactivate;
    var0.ref_140cf = &validatemedicalcrate;
    var0.attackerswaittime = &activatemedicalcrate;
    var0.‹Á¿ø{ÏXX;â# / = &postinitmedicalcrate;
    var0.weight = getdvarfloat( "scr_br_pe_medical_crate_weight", 0 );
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx( "medical_crate", "20   15  10  10          10  15  20  25" );
    var0.£¼#w]j‹ƒ½Ï‚UÀíÌI¸Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights( "medical_crate" );
    scripts\mp\gametypes\br_publicevents::ref_12b35( 20, var0 );
}

// Params 0
// Size: 0x7
function postinitplundercrate()
{
    postinitfunc();
}

// Params 0
// Size: 0x7
function postinitweaponcrate()
{
    postinitfunc();
}

// Params 0
// Size: 0x7
function postinitmedicalcrate()
{
    postinitfunc();
}

// Params 0
// Size: 0x7a
function postinitfunc()
{
    if ( isdefined( level.Ž­áWížã2“¹¿NH„¾Y ) )
    {
        return;
    }
    
    level.Ž­áWížã2“¹¿NH„¾Y = 1;
    game[ "dialog" ][ "cash_drop" ] = "bm_event_airdrop";
    game[ "dialog" ][ "weapon_drop" ] = "drop_resupply";
    game[ "dialog" ][ "medical_drop" ] = "medical_announcement";
    level.conf_fx[ "vanish" ] = loadfx( "vfx/core/impacts/small_snowhit" );
    
    if ( istrue( level.ref_1406f ) )
    {
        level.ref_11a1f = level.minigun_warning_time;
        level.ref_1395a = [];
        return;
    }
}

// Params 0
// Size: 0xd, Type: bool
function ref_140d1()
{
    var0 = scripts\mp\gametypes\br_armory_kiosk::resetarenaomnvardata();
    return var0 >= 1;
}

// Params 0
// Size: 0x5, Type: bool
function ref_140d8()
{
    return true;
}

// Params 0
// Size: 0x5, Type: bool
function validatemedicalcrate()
{
    return true;
}

// Params 0
// Size: 0xa
function atv_initdamage()
{
    attackpressed( 3 );
}

// Params 0
// Size: 0xa
function aud_breached_exit_wind()
{
    attackpressed( 1 );
}

// Params 0
// Size: 0xa
function activatemedicalcrate()
{
    attackpressed( 2 );
}

// Params 1
// Size: 0x3cb
function attackpressed( var0 )
{
    level.«³‰'úàV¯“°:•úÕ›V–µ¬{Ù²'É–È¬ = getdvarfloat( "scr_br_pe_crate_use_time", 5 );
    var1 = spawnstruct();
    
    switch ( var0 )
    {
        case 1:
            if ( !isdefined( level.shutdownattractionicontrigger ) )
            {
                level thread scripts\mp\gametypes\br_heavy_weapon_drop::init();
            }
            
            var1.delayeddetachbreak = "heavy_weapon_crate";
            var1.delaydropbags = "heavy_weapon_public";
            var1.delayed_depositing = "pe_chopper_crate";
            var1.delayedattach = "pe_chopper_on";
            var1.delayeddetach = "br_pe_weapon_crate_start";
            var1.delaydestroyhudelem = "weapon_drop";
            level.delete_ai = 1;
            break;
        case 2:
            if ( !isdefined( level.„‡¯Ó%‚sˆ).£è¬š ) )
            {
                level thread scripts\mp\gametypes\br_medical_crate_drop::init();
            }
            
            var1.delayeddetachbreak = "medical_crate";
            var1.delaydropbags = "medical_supplies";
            var1.delayed_depositing = "pe_chopper_crate";
            var1.delayedattach = "pe_chopper_on";
            var1.delayeddetach = "br_pe_medical_crate_start";
            var1.delaydestroyhudelem = "medical_drop";
            level.delete_ai = 0;
            level.«³‰'úàV¯“°:•úÕ›V–µ¬{Ù²'É–È¬ = scripts\mp\gametypes\br_medical_crate_drop::getusetimeoverride();
            break;
        case 3:
            level.delayed_explosion_things = getdvarint( "scr_br_pe_loadoutdrop_amount", 15000 );
            level thread scripts\mp\gametypes\br_lootchopper::init();
            level thread scripts\cp_mp\killstreaks\airdrop::teamplunderexfil();
            var1.delayeddetachbreak = "battle_royale_chopper_loot";
            var1.delaydropbags = "active";
            var1.delayed_depositing = "cashdrop_common_world";
            var1.delayedattach = "on";
            var1.delayeddetach = "br_pe_cash_crate_start";
            var1.delaydestroyhudelem = "cash_drop";
            level.delete_ai = 0;
            break;
    }
    
    var2 = scripts\cp_mp\killstreaks\airdrop::getleveldata( var1.delayeddetachbreak );
    var2.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var2.minimapicon = undefined;
    
    if ( isdefined( var2.…o; ´œy„‹ˆÈúÃãÝƒÊ]¨ ) )
    {
        var1.delaydropbags = var2.…o; ´œy„‹ˆÈúÃãÝƒÊ]¨;
    }
    
    if ( !istrue( var2.“·W¢Ú0è¸Éƒz ) )
    {
        scripts\mp\gametypes\br_publicevents::ref_13371( var1.delayeddetach );
    }
    
    scripts\mp\gametypes\br_public::brleaderdialog( var1.delaydestroyhudelem, 1 );
    var3 = scripts\mp\utility\teams::resetchallengetimer();
    var4 = getdvarint( "scr_br_pe_loadoutdrop_numTeamsPerCrates", 3 );
    
    if ( var0 == 2 )
    {
        var5 = getdvarint( "scr_br_pe_medicaldrop_minCrates", 5 );
    }
    else
    {
        var5 = getdvarint( "scr_br_pe_loadoutdrop_minCrates", 10 );
    }
    
    var6 = int( max( var5, var4 / var5 ) );
    var7 = [];
    var8 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var9 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    
    for ( var10 = 0; var10 < var6 ; var10++ )
    {
        if ( istrue( level.ref_1406f ) )
        {
            var7 = return_same_module_as_next_module( var8, var9 );
            continue;
        }
        
        var7 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var8, var9, 0.1, 0.9, 1 );
    }
    
    level.delete_covernodes = [];
    
    foreach ( var12 in var7 )
    {
        if ( isdefined( var12 ) )
        {
            var13 = undefined;
            var14 = undefined;
            var15 = var2.delayeddetachbreak;
            var16 = ( var12[ 0 ], var12[ 1 ], var12[ 2 ] + 10000 );
            var17 = ( 0, randomfloat( 360 ), 0 );
            var18 = var12;
            var19 = scripts\cp_mp\killstreaks\airdrop::dropcrate( var13, var14, var15, var16, var17, var18 );
            
            if ( !isdefined( var19 ) )
            {
                continue;
            }
            
            if ( !istrue( var3.©„àRc½nÞ‘+©Ù‚Ú¸ø:p ) )
            {
                var19 setscriptablepartstate( "trail", "active", 0 );
                var19.ref_13428 = spawn( "script_model", var16 + ( 0, 0, 58 ) );
                var19.ref_13428 setmodel( "ks_airdrop_crate_br" );
                var19.ref_13428 linkto( var19 );
                var19.ref_13428 setscriptablepartstate( "smoke_trail", "on" );
            }
            
            if ( isdefined( var2.delaydropbags ) )
            {
                var19 setscriptablepartstate( "objective", var2.delaydropbags );
            }
            
            if ( isdefined( var2.delayed_depositing ) )
            {
                var19 setscriptablepartstate( "objective_map", var2.delayed_depositing );
            }
            
            var20 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( var19 );
            var20.ref_140a0 = level.«³‰'úàV¯“°:•úÕ›V–µ¬{Ù²'É–È¬;
            level.delete_covernodes[ level.delete_covernodes.size ] = var19;
        }
    }
}

// Params 0
// Size: 0x8a
function deactivate()
{
    foreach ( var1 in level.delete_covernodes )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        playfx( level.conf_fx[ "vanish" ], var1.origin );
        
        if ( isdefined( var1.ref_13428 ) )
        {
            var1.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
            var1.ref_13428 delete();
        }
        
        var1 scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
        level.delete_covernodes = scripts\engine\utility::array_remove( level.delete_covernodes, var1 );
    }
}

// Params 2
// Size: 0x11e
function return_same_module_as_next_module( var0, var1 )
{
    var2 = undefined;
    var3 = [];
    
    foreach ( var5 in level.ref_11a1f )
    {
        if ( scripts\mp\gametypes\br_circle::updateprestreamrespawn( var5.origin ) )
        {
            var3 = scripts\engine\utility::array_add( var3, var5 );
        }
    }
    
    level.ref_11a1f = var3;
    var7 = freight_lift_dogtag_revive( level.ref_11a1f );
    var8 = 5;
    
    while ( var8 >= 0 )
    {
        var9 = randomfloat( var7 );
        var10 = play_scramble_for_player_until_cleared( level.ref_11a1f, var9 );
        
        if ( isdefined( var10 ) )
        {
            var11 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var10.origin, var10.radius, 0.1, 0.85, 1, 1 );
            
            if ( !scripts\mp\gametypes\br_circle::updateprestreamrespawn( var11 ) )
            {
                var11 = riskspawn_flagcaptured( var0, var10.origin, var10.radius );
            }
            
            if ( !istrue( update_objective_mlgicon( var11 ) ) )
            {
                var2 = var11;
            }
            
            if ( var8 == 0 )
            {
                var2 = var11;
            }
            
            if ( isdefined( var2 ) )
            {
                break;
            }
        }
        
        var7--;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( <error>, var0, 0.1, 0.85, 1, 1 );
    }
    
    level.ref_1395a[ level.ref_1395a.size ] = var1;
    return var1;
}

// Params 1
// Size: 0x4a, Type: bool
function update_objective_mlgicon( var0 )
{
    var1 = getdvarint( "scr_br_pe_lootcrate_min_dist", 2500 );
    var2 = var1 * var1;
    
    foreach ( var4 in level.ref_1395a )
    {
        if ( distance2dsquared( var0, var4 ) < var2 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x39
function freight_lift_dogtag_revive( var0 )
{
    var1 = 0;
    
    foreach ( var3 in var0 )
    {
        var1 += var3.radius;
    }
    
    return var1;
}

// Params 2
// Size: 0x42
function play_scramble_for_player_until_cleared( var0, var1 )
{
    var2 = 0;
    
    foreach ( var4 in var0 )
    {
        var2 += var4.radius;
        
        if ( var1 <= var2 )
        {
            return var4;
        }
    }
    
    return undefined;
}

// Params 3
// Size: 0x31
function riskspawn_flagcaptured( var0, var1, var2 )
{
    var3 = init_silo_platforms( var0, var1, var2 );
    var4 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent( var3.origin, var3.radius, 0, 0.85, 1, 1 );
    return var4;
}

// Params 3
// Size: 0x80
function init_silo_platforms( var0, var1, var2 )
{
    var3 = distance2d( var0, var1 );
    var4 = int( var2 / 2 );
    
    if ( var3 != 0 )
    {
        var5 = int( var1[ 0 ] - var4 / var3 * ( var1[ 0 ] - var0[ 0 ] ) );
        var6 = int( var1[ 1 ] - var4 / var3 * ( var1[ 1 ] - var0[ 1 ] ) );
    }
    else
    {
        var5 = int( var2[ 0 ] );
        var6 = int( var2[ 1 ] );
    }
    
    var7 = 0;
    var8 = spawnstruct();
    var8.origin = ( var5, var6, var7 );
    var8.radius = var6;
    return var8;
}

