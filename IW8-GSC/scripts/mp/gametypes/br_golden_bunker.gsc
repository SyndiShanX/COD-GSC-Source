
// Params 0
// Size: 0x7
function init()
{
    initgoldbunkers();
}

// Params 0
// Size: 0xa3
function initgoldbunkers()
{
    level.¶Úz ¯š°°w¯3ï = [];
    
    for ( var0 = 1; var0 <= 7 ; var0++ )
    {
        var1 = getentitylessscriptablearrayinradius( "bunker" + var0, "targetname" );
        var2 = [];
        var3 = [];
        
        foreach ( var5 in var1 )
        {
            if ( issubstr( var5.script_noteworthy, "door" ) )
            {
                var2 = var5;
                continue;
            }
            
            var3 = var5;
        }
        
        level.¶Úz ¯š°°w¯3ï[ level.¶Úz ¯š°°w¯3ï.size ] = creategoldbunker( var3, var2 );
    }
    
    scripts\engine\scriptable::ref_12f5b( "bunker_keypad", &keypadused );
}

// Params 2
// Size: 0x1e
function creategoldbunker( var0, var1 )
{
    var2 = spawnstruct();
    var2.­ƒ¶V/Á#n = var0;
    var2.‘[CÏ±ëL˜€2‡ = var1;
    return var2;
}

// Params 5
// Size: 0x51
function keypadused( var0, var1, var2, var3, var4 )
{
    var5 = getdvarint( "scr_golden_bunker_skip_card", 0 ) == 1;
    
    if ( var5 || var3 scripts\mp\gametypes\br_public::should_damage_pavelow_boss( "brloot_access_card_gold_island_bunker" ) )
    {
        var6 = getgoldbunkerfromkeypad( var0 );
        thread openbunker( var6 );
        var3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4( "golden_vault_opened" );
        
        if ( !var5 )
        {
            var3 scripts\mp\gametypes\br_pickups::ref_12bfc();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x6a
function getgoldbunkerfromkeypad( var0 )
{
    foreach ( var2 in level.¶Úz ¯š°°w¯3ï )
    {
        foreach ( var4 in var2.­ƒ¶V/Á#n )
        {
            if ( var4.index == var0.index )
            {
                return var2;
            }
        }
    }
}

// Params 1
// Size: 0x7a
function openbunker( var0 )
{
    level endon( "game_ended" );
    
    foreach ( var2 in var0.­ƒ¶V/Á#n )
    {
        var2 setscriptablepartstate( "bunker_keypad", "used" );
    }
    
    wait 2;
    
    foreach ( var5 in var0.‘[CÏ±ëL˜€2‡ )
    {
        var5 setscriptablepartstate( "lm_door_bunker", "open" );
    }
}

