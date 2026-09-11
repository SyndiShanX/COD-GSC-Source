
// Params 0
// Size: 0x73
function init()
{
    level.yrÀïRß®‰]D•S = spawnstruct();
    level.yrÀïRß®‰]D•S.intel_used_logic = 0;
    level.yrÀïRß®‰]D•S.¶££ÒÖYæŞÚ6Y£¬F = 0;
    level.yrÀïRß®‰]D•S.state = 0;
    level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ = 255;
    level.yrÀïRß®‰]D•S.targets = getdvarleveleventtargets();
    level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ = level.yrÀïRß®‰]D•S.targets[ 0 ];
    _pemetersetdetails();
    thread ref_12933();
}

// Params 0
// Size: 0xe, Type: bool
function ispubliceventmeterenabled()
{
    return getdvarint( "br_pe_meter_enabled", 0 ) > 0;
}

// Params 0
// Size: 0x5c
function getdvarleveleventtargets()
{
    var0 = getdvar( "scr_br_pe_meter_event_targets", "10 15 20" );
    var1 = [];
    
    if ( var0 != "" )
    {
        var2 = strtok( var0, " " );
        
        foreach ( var4 in var2 )
        {
            var5 = int( var4 );
            var1 = var5;
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x61
function getdvarpemetereventweights( var0 )
{
    var1 = getdvar( "scr_br_pe_" + var0 + "_pe_meter_event_weights", "0 0 0 0 0 0 0 0" );
    var2 = [];
    
    if ( var1 != "" )
    {
        var3 = strtok( var1, " " );
        
        foreach ( var5 in var3 )
        {
            var2 = float( var5 );
        }
    }
    
    return var2;
}

// Params 0
// Size: 0x29
function getcurrentmeterlevel()
{
    var0 = level.yrÀïRß®‰]D•S.¶££ÒÖYæŞÚ6Y£¬F;
    var0 = clamp( var0, 0, level.yrÀïRß®‰]D•S.targets.size - 1 );
    return int( var0 );
}

// Params 0
// Size: 0x1c
function ref_12933()
{
    level endon( "cancel_public_event" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    setstatepemeter( 1 );
}

// Params 0
// Size: 0x2b
function triggernewpublicevent()
{
    level thread scripts\mp\gametypes\br_publicevents::give_intel_data( 1, getcurrentmeterlevel(), 1 );
    level.yrÀïRß®‰]D•S.¶££ÒÖYæŞÚ6Y£¬F += 1;
}

// Params 1
// Size: 0xae
function increasepubliceventmeter( var0 )
{
    if ( !ispubliceventmeterenabled() )
    {
        return;
    }
    
    if ( level.yrÀïRß®‰]D•S.state == 0 )
    {
        return;
    }
    
    if ( level.yrÀïRß®‰]D•S.intel_used_logic >= level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ )
    {
        return;
    }
    
    if ( !isdefined( var0 ) || var0 <= 0 )
    {
        scripts\mp\utility\script::laststand_dogtags( "PE Meter increase amount is undefined or <= 0." );
        return;
    }
    
    var1 = level.yrÀïRß®‰]D•S.intel_used_logic + var0;
    var1 = clamp( var1, 0, level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ );
    
    if ( var1 >= level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ )
    {
        triggernewpublicevent();
        _pemetersetdetails( var1, undefined, 0 );
        var2 = getdvarint( "scr_br_pe_meter_delay_before_reset", 1 );
        thread resetpemeter( var2 );
        return;
    }
    
    _pemetersetdetails( var1, undefined, undefined );
}

// Params 1
// Size: 0x2a
function resetpemeter( var0 )
{
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    var1 = 0;
    var2 = level.yrÀïRß®‰]D•S.targets[ getcurrentmeterlevel() ];
    _pemetersetdetails( var1, var2, 1 );
}

// Params 1
// Size: 0xd
function setstatepemeter( var0 )
{
    _pemetersetdetails( undefined, undefined, var0 );
}

// Params 0
// Size: 0x1a
function getmetercurrentratio()
{
    return level.yrÀïRß®‰]D•S.intel_used_logic / level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½;
}

// Params 3
// Size: 0x9e
function _pemetersetdetails( var0, var1, var2 )
{
    if ( isdefined( var0 ) )
    {
        level.yrÀïRß®‰]D•S.intel_used_logic = var0;
    }
    
    if ( isdefined( var1 ) )
    {
        level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ = var1;
    }
    
    if ( isdefined( var2 ) )
    {
        level.yrÀïRß®‰]D•S.state = var2;
    }
    
    var3 = getomnvar( "ui_br_pe_meter_data" );
    var4 = 0;
    var4 += ( int( level.yrÀïRß®‰]D•S.state ) & 3 ) << 16;
    var4 += ( int( level.yrÀïRß®‰]D•S.‚Ì	˜âèÑ³}½ ) & 255 ) << 8;
    var4 += ( int( level.yrÀïRß®‰]D•S.intel_used_logic ) & 255 ) << 0;
    
    if ( var3 != var4 )
    {
        setomnvar( "ui_br_pe_meter_data", var4 );
        return;
    }
}

