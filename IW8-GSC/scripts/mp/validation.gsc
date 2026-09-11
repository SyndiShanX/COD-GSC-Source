
// Params 3
// Size: 0x5a
function validationerror( var0, var1, var2 )
{
    var3 = var0;
    
    if ( isdefined( var1 ) )
    {
        var3 = var3 + "_" + var1;
    }
    
    if ( isdefined( var2 ) )
    {
        var3 = var3 + " - " + var2;
    }
    
    if ( getdvarint( "scr_validate_print", 0 ) == 1 )
    {
    }
    
    if ( getdvarint( "scr_validate_assert", 0 ) == 1 )
    {
    }
    
    if ( getdvarint( "scr_validate_record", 0 ) == 1 )
    {
        scripts\mp\class::recordvalidationinfraction();
        return;
    }
}

// Params 2
// Size: 0x22
function vandalize( var0, var1 )
{
    var2 = getdvarint( "scr_checkValidAttachmentUnlock", 0 ) == 1;
    
    if ( var2 )
    {
        return scripts\mp\utility\weapon::carrier_cleanup( var0, var1 );
    }
    
    return 1;
}

// Params 2
// Size: 0x88, Type: bool
function isweaponvariantconditionallylocked( var0, var1 )
{
    if ( !isdefined( var1 ) || var1 <= 0 )
    {
        return false;
    }
    
    if ( !isdefined( level.½ÞÉY›£ä-õæ¡×æC¥¬6‘¾ÎÂäK°sÑ› ) )
    {
        level.½ÞÉY›£ä-õæ¡×æC¥¬6‘¾ÎÂäK°sÑ› = getdvarint( "scr_br_restrict_s4_shield_variants", 0 );
    }
    
    if ( level.½ÞÉY›£ä-õæ¡×æC¥¬6‘¾ÎÂäK°sÑ› )
    {
        if ( !isdefined( level.›¦S· )¹qŸv(›ƒ¹.S ) )
        {
            level.›¦S· )¹qŸv(›ƒ¹.S = [];
            level.›¦S· )¹qŸv(›ƒ¹.S[ "s4_me_rindigo|1" ] = 1;
            level.›¦S· )¹qŸv(›ƒ¹.S[ "s4_me_rindigo|2" ] = 1;
            level.›¦S· )¹qŸv(›ƒ¹.S[ "s4_me_rindigo|3" ] = 1;
        }
        
        var2 = var0 + "|" + var1;
        
        if ( isdefined( level.›¦S· )¹qŸv(›ƒ¹.S[ var2 ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0xacc
function validateloadout( var0 )
{
    var1 = scripts\mp\utility\weapon::weaponnumbermap( var0.loadoutprimary );
    var2 = 0;
    
    if ( !isdefined( var1 ) )
    {
        var2 = 1;
    }
    else if ( vehicle_checktrailvfx( var0.loadoutprimary ) )
    {
        var2 = 1;
    }
    
    if ( !scripts\mp\utility\weapon::iscacprimaryweapon( var0.loadoutprimary ) )
    {
        var2 = 1;
    }
    
    var3 = 0;
    var4 = 0;
    
    if ( attachmentisrestricted( var0.loadoutprimary ) )
    {
        var2 = 1;
        var3 = 1;
    }
    
    if ( !scripts\mp\weapons::vehicle_ai_avoidance_cleanup( var0.loadoutprimary ) )
    {
        var2 = 1;
        var3 = 1;
    }
    
    if ( var2 )
    {
        var5 = getdvar( "scr_weapon_restricted_primary" );
        
        if ( var5 == "" )
        {
            var5 = "iw8_ar_mike4";
        }
        
        var0.loadoutprimary = var5;
        var0.loadoutprimaryattachments = [];
        var0.loadoutprimarycamo = "none";
        var0.loadoutprimaryreticle = "none";
        var0.loadoutprimaryvariantid = -1;
        var0.loadoutprimaryattachmentids = [];
        var0.loadoutprimarycosmeticattachment = "none";
        var0.loadoutprimarystickers[ 0 ] = "none";
        var0.loadoutprimarystickers[ 1 ] = "none";
        var0.loadoutprimarystickers[ 2 ] = "none";
        var0.loadoutprimarystickers[ 3 ] = "none";
    }
    else
    {
        if ( vehicle_collision( var0.loadoutprimary, var0.loadoutprimaryvariantid ) || isweaponvariantconditionallylocked( var0.loadoutprimary, var0.loadoutprimaryvariantid ) )
        {
            var0.loadoutprimaryvariantid = -1;
        }
        
        for ( var6 = 0; var6 < var0.loadoutprimaryattachments.size ; var6++ )
        {
            var7 = var0.loadoutprimaryattachments[ var6 ];
            var8 = var0.loadoutprimaryattachmentids[ var6 ];
            
            if ( turretparent( var0.loadoutprimary, var0.loadoutprimaryvariantid, var7, var8 ) )
            {
                var0.loadoutprimaryattachmentids[ var6 ] = 0;
            }
            
            if ( var7 != "none" && ( perkisrestricted( var7, var0.loadoutprimary ) || !vandalize( var0.loadoutprimary, var7 ) ) )
            {
                var0.loadoutprimaryattachments[ var6 ] = "none";
                var4 = 1;
            }
        }
    }
    
    var1 = scripts\mp\utility\weapon::weaponnumbermap( var0.loadoutsecondary );
    var2 = 0;
    
    if ( !isdefined( var1 ) )
    {
        var2 = 1;
    }
    else if ( vehicle_checktrailvfx( var0.loadoutsecondary ) )
    {
        var2 = 1;
    }
    
    var9 = "specialty_munitions_2";
    var10 = !equipmentisrestricted( var9 ) && scripts\engine\utility::array_contains( var0.loadoutperks, var9 );
    
    if ( scripts\mp\utility\weapon::iscacprimaryweapon( var0.loadoutsecondary ) && !var10 )
    {
        var2 = 1;
    }
    
    if ( attachmentisrestricted( var0.loadoutsecondary ) )
    {
        var2 = 1;
        var3 = 1;
    }
    
    if ( !scripts\mp\weapons::vehicle_ai_avoidance_cleanup( var0.loadoutprimary ) )
    {
        var2 = 1;
        var3 = 1;
    }
    
    if ( var2 )
    {
        var11 = getdvar( "scr_weapon_restricted_secondary" );
        
        if ( var11 == "" )
        {
            var11 = "iw8_pi_mike1911";
        }
        
        var0.loadoutsecondary = var11;
        var0.loadoutsecondaryattachments = [];
        var0.loadoutsecondarycamo = "none";
        var0.loadoutsecondaryreticle = "none";
        var0.loadoutsecondaryvariantid = -1;
        var0.loadoutsecondaryattachmentids = [];
        var0.loadoutsecondarycosmeticattachment = "none";
        var0.loadoutsecondarystickers[ 0 ] = "none";
        var0.loadoutsecondarystickers[ 1 ] = "none";
        var0.loadoutsecondarystickers[ 2 ] = "none";
        var0.loadoutsecondarystickers[ 3 ] = "none";
    }
    else
    {
        if ( vehicle_collision( var0.loadoutsecondary, var0.loadoutsecondaryvariantid ) || isweaponvariantconditionallylocked( var0.loadoutsecondary, var0.loadoutsecondaryvariantid ) )
        {
            var0.loadoutsecondaryvariantid = -1;
        }
        
        for ( var6 = 0; var6 < var0.loadoutsecondaryattachments.size ; var6++ )
        {
            var7 = var0.loadoutsecondaryattachments[ var6 ];
            var8 = var0.loadoutsecondaryattachmentids[ var6 ];
            
            if ( turretparent( var0.loadoutsecondary, var0.loadoutsecondaryvariantid, var7, var8 ) )
            {
                var0.loadoutsecondaryattachmentids[ var6 ] = 0;
            }
            
            if ( var7 != "none" && ( perkisrestricted( var7, var0.loadoutsecondary ) || !vandalize( var0.loadoutsecondary, var7 ) ) )
            {
                var0.loadoutsecondaryattachments[ var6 ] = "none";
                var4 = 1;
            }
        }
    }
    
    var12 = [];
    GscBinSkip0( 0x2e, 1, 0 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 8
// Size: 0x23d
function validateweapon( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = scripts\mp\utility\weapon::getweaponrootname( var1 );
    var9 = scripts\mp\utility\weapon::iscacsecondaryweapon( var1 );
    var10 = scripts\engine\utility::ter_op( var7, "secondary", "primary" );
    var11 = scripts\engine\utility::ter_op( var7, 4, 1 );
    
    if ( isdefined( var1 ) && var1 != "none" && var1 != "iw8_fists" )
    {
        var0.pointcost++;
        
        if ( var7 )
        {
            if ( !var9 )
            {
                var0.pointcost++;
                var0.wildcards[ "overkill" ] = 1;
            }
        }
        else if ( var9 )
        {
            validationerror( "secondaryAsPrimary", undefined, var1 );
            var0.invaliditems[ var11 ] = 1;
        }
        
        var12 = scripts\mp\utility\weapon::weaponnumbermap( var8 );
        
        if ( !isdefined( var12 ) )
        {
            validationerror( "unknownWeapon", var10, var1 );
            var0.invaliditems[ var11 ] = 1;
        }
        else
        {
            var13 = tablelookup( "mp/statstable.csv", 0, var12, 41 );
            
            if ( int( var13 ) < 0 )
            {
                validationerror( "unreleasedWeapon", var10, var1 );
                var0.invaliditems[ var11 ] = 1;
            }
        }
        
        if ( !self isitemunlocked( var8, "weapon" ) && !weaponunlocksvialoot( var8 ) )
        {
            validationerror( "lockedWeapon", var10, var1 );
            var0.invaliditems[ var11 ] = 1;
        }
        
        if ( var5 == 0 )
        {
            if ( var6 != -1 )
            {
                validationerror( "emptyItemIDMismatch", var10, var1 );
                var0.invaliditems[ var11 ] = 1;
            }
        }
        else if ( var6 == -1 )
        {
            validationerror( "emptyVariantIDMismatch", var10, var1 );
            var0.invaliditems[ var11 ] = 1;
        }
        else
        {
            if ( !scripts\mp\loot::isweaponitem( var5 ) )
            {
                validationerror( "nonWeaponLootItemID", var10, var1 );
                var0.invaliditems[ var11 ] = 1;
            }
            
            var14 = scripts\mp\loot::getlootweaponref( var5 );
            
            if ( !isdefined( var14 ) )
            {
                validationerror( "badLootItemID", var10, var1 );
                var0.invaliditems[ var11 ] = 1;
            }
            else
            {
                var15 = scripts\mp\loot::lookupvariantref( var1, var6 );
                
                if ( !isdefined( var15 ) )
                {
                    validationerror( "badVariantRef", var10, var1 );
                    var0.invaliditems[ var11 ] = 1;
                }
                else if ( var15 != var14 )
                {
                    validationerror( "lootDataMismatch", var10, var1 );
                    var0.invaliditems[ var11 ] = 1;
                }
            }
        }
        
        validateattachments( var0, var2, var1, var8, var10 );
        return;
    }
}

// Params 5
// Size: 0x1e2
function validateattachments( var0, var1, var2, var3, var4 )
{
    var5 = scripts\mp\utility\weapon::weapongroupmap( var2 );
    var6 = getsubstr( var5, 7 ) + "Attach";
    var7 = scripts\engine\utility::ter_op( var4 == "primary", 2, 5 );
    var8 = 0;
    var9 = 0;
    var10 = scripts\engine\utility::ter_op( var4 == "primary", 2, 2 );
    
    foreach ( var12 in var1 )
    {
        var13 = 0;
        
        if ( isdefined( var12 ) && var12 != "none" )
        {
            var14 = scripts\mp\utility\weapon::getattachmenttype( var12 );
            
            if ( isdefined( var14 ) && var14 != "" )
            {
                var15 = scripts\mp\utility\weapon::attachmentmap_tounique( var12, var2 );
                
                if ( isdefined( var15 ) )
                {
                    if ( var14 == "rail" )
                    {
                        var13 = 1;
                    }
                }
            }
            
            var16 = var3 + "+" + var12;
            
            if ( !self isitemunlocked( var16, var6 ) )
            {
                validationerror( "lockedAttachment", var4, var12 );
                var0.invaliditems[ var7 ][ var0.invaliditems[ var7 ].size ] = var17;
            }
            
            if ( !scripts\mp\utility\weapon::carriedpunchcard( var3, var12 ) )
            {
                validationerror( "nonSelectableAttachment", var4, var12 );
                var0.invaliditems[ var7 ][ var0.invaliditems[ var7 ].size ] = var17;
            }
            
            if ( var13 )
            {
                var8++;
                var0.pointcost++;
            }
            else
            {
                var9++;
                
                if ( var9 <= var10 )
                {
                    var0.pointcost++;
                }
                else
                {
                    var0.wildcards[ var4 + "_attachment_" + var9 + 1 ] = 1;
                    var0.pointcost += 2;
                }
            }
        }
    }
    
    if ( var9 > 5 )
    {
        validationerror( "tooManyAttachments", var4, var9 );
        var0.invaliditems[ scripts\engine\utility::ter_op( var4 == "primary", 3, 6 ) ] = 1;
    }
    
    if ( var8 > 1 )
    {
        validationerror( "tooManyOpticAttachments", var4, var8 );
        var0.invaliditems[ scripts\engine\utility::ter_op( var4 == "primary", 3, 6 ) ] = 1;
        return;
    }
}

// Params 4
// Size: 0x103
function validatepower( var0, var1, var2, var3 )
{
    var4 = scripts\engine\utility::ter_op( var2 == "primary", 7, 8 );
    
    if ( isdefined( var1 ) && var1 != "none" )
    {
        if ( !isdefined( level.powers[ var1 ] ) )
        {
            validationerror( "unknownPower", var2, var1 );
            var0.invaliditems[ var4 ] = 1;
        }
        
        if ( !self isitemunlocked( var1, "power" ) )
        {
            validationerror( "lockedPower", var2, var1 );
            var0.invaliditems[ var4 ] = 1;
        }
        
        var5 = lookuppowerslot( var1 );
        
        if ( !isdefined( var5 ) )
        {
            validationerror( "unknownMenuPower", var2, var1 );
            var0.invaliditems[ var4 ] = 1;
        }
        else if ( var5 != var2 )
        {
            validationerror( "powerInWrongSlot", var2, var1 );
            var0.invaliditems[ var4 ] = 1;
        }
        
        var0.pointcost++;
    }
    
    if ( istrue( var3 ) )
    {
        var0.pointcost += 2;
        var6 = scripts\engine\utility::ter_op( var2 == "primary", "extra_lethal", "extra_tactical" );
        var0.wildcards[ var6 ] = 1;
        return;
    }
}

// Params 3
// Size: 0x1ca
function validateperks( var0, var1, var2 )
{
    var3 = [];
    GscBinSkip0( 0x2e, 1, 0 );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 4
// Size: 0x11d
function validatestreaks( var0, var1, var2, var3 )
{
    var4 = [ var1, var2, var3 ];
    
    foreach ( var6 in var4 )
    {
        if ( var6 == "none" )
        {
            continue;
        }
        
        var7 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo( var6 );
        
        if ( !isdefined( var7 ) )
        {
            validationerror( "unknownStreak", undefined, var6 );
            var0.invaliditems[ 12 ] = 1;
        }
        
        if ( !self isitemunlocked( var6, "killstreak" ) )
        {
            validationerror( "lockedStreak", undefined, var6 );
            var0.invaliditems[ 12 ] = 1;
        }
    }
    
    if ( var1 == var2 && var1 != "none" )
    {
        validationerror( "duplicateStreak", undefined, var1 );
        var0.invaliditems[ 12 ] = 1;
        return;
    }
    
    if ( var1 == var3 && var1 != "none" )
    {
        validationerror( "duplicateStreak", undefined, var1 );
        var0.invaliditems[ 12 ] = 1;
        return;
    }
    
    if ( var2 == var3 && var2 != "none" )
    {
        validationerror( "duplicateStreak", undefined, var2 );
        var0.invaliditems[ 12 ] = 1;
        return;
    }
}

// Params 2
// Size: 0x52
function validatearchetype( var0, var1 )
{
    if ( !isdefined( level.archetypeids[ var1 ] ) )
    {
        validationerror( "unknownArchetype", undefined, var1 );
        var0.invaliditems[ 10 ] = 1;
    }
    
    if ( !self isitemunlocked( var1, "rig" ) )
    {
        validationerror( "lockedArchetype", undefined, var1 );
        var0.invaliditems[ 10 ] = 1;
        return;
    }
}

// Params 3
// Size: 0x98
function validatesuper( var0, var1, var2 )
{
    if ( !isdefined( var1 ) || var1 == "none" )
    {
        return;
    }
    
    var3 = level.superglobals.staticsuperdata[ var1 ];
    
    if ( !isdefined( var3 ) )
    {
        validationerror( "unknownSuper", undefined, var1 );
        var0.invaliditems[ 11 ] = 1;
    }
    else if ( var3.archetype != var2 )
    {
        validationerror( "superOnWrongRig", undefined, var1 );
        var0.invaliditems[ 11 ] = 1;
    }
    
    if ( !self isitemunlocked( var1, "super" ) )
    {
        validationerror( "lockedSuper", undefined, var1 );
        var0.invaliditems[ 11 ] = 1;
        return;
    }
}

// Params 1
// Size: 0x4
function validatewildcards( var0 )
{
    
}

// Params 1
// Size: 0x26
function fixloadout( var0 )
{
    var1 = scripts\mp\class::loadout_getclassstruct();
    var1.loadoutarchetype = "archetype_assault";
    var1.loadoutprimary = "iw8_ar_mike4";
    return var1;
}

// Params 2
// Size: 0xc7
function fixweapon( var0, var1 )
{
    if ( var1 == "primary" )
    {
        var0.loadoutprimary = "iw8_ar_mike4";
        var0.loadoutprimarycamo = "none";
        var0.loadoutprimaryreticle = "none";
        var0.loadoutprimarylootitemid = 0;
        var0.loadoutprimaryvariantid = -1;
        
        for ( var2 = 0; var2 < scripts\mp\class::getmaxprimaryattachments() ; var2++ )
        {
            var0.loadoutprimaryattachments[ var2 ] = "none";
        }
        
        return;
    }
    
    var1.loadoutsecondary = "none";
    var1.loadoutsecondarycamo = "none";
    var1.loadoutsecondaryreticle = "none";
    var1.loadoutsecondarylootitemid = 0;
    var1.loadoutsecondaryvariantid = -1;
    
    for ( var2 = 0; var2 < scripts\mp\class::getmaxsecondaryattachments() ; var2++ )
    {
        var1.loadoutsecondaryattachments[ var2 ] = "none";
    }
}

// Params 3
// Size: 0x30
function fixattachment( var0, var1, var2 )
{
    if ( var1 == "primary" )
    {
        var0.loadoutprimaryattachments[ var2 ] = "none";
        return;
    }
    
    var0.loadoutsecondaryattachments[ var2 ] = "none";
}

// Params 2
// Size: 0x3d
function fixpower( var0, var1 )
{
    if ( var1 == "primary" )
    {
        var0.loadoutpowerprimary = "none";
        var0.loadoutextrapowerprimary = 0;
        return;
    }
    
    var0.loadoutpowersecondary = "none";
    var0.loadoutextrapowersecondary = 0;
}

// Params 2
// Size: 0x1a
function fixperk( var0, var1 )
{
    var0.loadoutperks = scripts\engine\utility::array_remove( var0.loadoutperks, var1 );
}

// Params 1
// Size: 0x2b
function fixkillstreaks( var0 )
{
    var0.loadoutkillstreak1 = "none";
    var0.loadoutkillstreak2 = "none";
    var0.loadoutkillstreak3 = "none";
}

// Params 1
// Size: 0x57
function fixarchetype( var0 )
{
    var0.loadoutarchetype = "archetype_assault";
    fixsuper( var0 );
    
    foreach ( var2 in var0.loadoutperks )
    {
        if ( isdefined( level.menurigperks[ var2 ] ) )
        {
            fixperk( var0, var2 );
            break;
        }
    }
}

// Params 1
// Size: 0x11
function fixsuper( var0 )
{
    var0.loadoutsuper = "none";
}

// Params 2
// Size: 0x192
function fixinvaliditems( var0, var1 )
{
    if ( isdefined( var1[ 0 ] ) )
    {
        var0 = fixloadout( var0 );
        return var0;
    }
    
    if ( isdefined( var1[ 1 ] ) )
    {
        fixweapon( var0, "primary" );
    }
    else
    {
        jumpiffalse(isdefined( var1[ 3 ] )) LOC_0000005a;
        
        for ( var2 = 0; var2 < scripts\mp\class::getmaxprimaryattachments() ; var2++ )
        {
            fixattachment( var0, "primary", var2 );
        }
        
        goto LOC_0000008d;
    }
    
    if ( isdefined( var2[ 4 ] ) )
    {
        fixweapon( var1, "secondary" );
    }
    else
    {
        jumpiffalse(isdefined( var2[ 6 ] )) LOC_000000d4;
        
        for ( var2 = 0; var2 < scripts\mp\class::getmaxsecondaryattachments() ; var2++ )
        {
            fixattachment( var1, "secondary", var2 );
        }
        
        goto LOC_00000107;
    }
    
    if ( isdefined( var2[ 7 ] ) )
    {
        fixpower( var2, "primary" );
    }
    
    if ( isdefined( var2[ 8 ] ) )
    {
        fixpower( var2, "secondary" );
    }
    
    foreach ( var8 in var2[ 9 ] )
    {
        fixperk( var2, var8 );
    }
    
    if ( isdefined( var2[ 10 ] ) )
    {
        fixarchetype( var2 );
    }
    else if ( isdefined( var2[ 11 ] ) )
    {
        fixarchetype( var2 );
    }
    
    if ( isdefined( var2[ 12 ] ) )
    {
        fixkillstreaks( var2 );
    }
    
    return var2;
}

// Params 1
// Size: 0x46
function lookuppowerslot( var0 )
{
    var1 = tablelookup( "mp/menuPowers.csv", 3, var0, 2 );
    
    if ( !isdefined( var1 ) || var1 != "1" && var1 != "2" )
    {
        return undefined;
    }
    
    return scripts\engine\utility::ter_op( var1 == "1", "primary", "secondary" );
}

// Params 1
// Size: 0x6, Type: bool
function weaponunlocksvialoot( var0 )
{
    return false;
}

// Params 1
// Size: 0x1f, Type: bool
function vehicle_checktrailvfx( var0 )
{
    return isdefined( level.weaponmapdata[ var0 ] ) && istrue( level.weaponmapdata[ var0 ].ref_13efc );
}

// Params 2
// Size: 0x43, Type: bool
function vehicle_collision( var0, var1 )
{
    if ( scripts\mp\utility\game::isanymlgmatch() )
    {
        return true;
    }
    
    if ( !isdefined( var1 ) || var1 <= 0 )
    {
        return false;
    }
    
    var2 = var0 + "|" + var1;
    return isdefined( level.weaponlootmapdata[ var2 ] ) && istrue( level.weaponlootmapdata[ var2 ].update_focus_fire_objective );
}

// Params 4
// Size: 0x101, Type: bool
function turretparent( var0, var1, var2, var3 )
{
    if ( scripts\mp\utility\game::isanymlgmatch() )
    {
        return true;
    }
    
    var4 = isdefined( var3 ) && var3 > 0 && var2 != "none";
    
    if ( !var4 )
    {
        return false;
    }
    
    var5 = getdvarint( "scr_attach_variants_enabled", 1 );
    var6 = isdefined( var1 ) && var1 > 0;
    
    if ( !var5 && !var6 )
    {
        return true;
    }
    
    var7 = var0 + "|" + var1;
    var8 = 0;
    
    for ( var9 = 1;  ; var9++ )
    {
        var10 = var0 + "|" + var9;
        
        if ( !isdefined( level.weaponlootmapdata[ var10 ] ) )
        {
            break;
        }
        
        if ( var5 || var10 == var7 )
        {
            if ( !level.weaponlootmapdata[ var10 ].update_focus_fire_objective )
            {
                if ( isdefined( level.weaponlootmapdata[ var10 ].attachcustomtoidmap ) )
                {
                    foreach ( var12 in level.weaponlootmapdata[ var10 ].attachcustomtoidmap )
                    {
                        if ( var3 == var12 && var2 == var13 )
                        {
                            var8 = 1;
                            break;
                        }
                    }
                }
                
                if ( var8 )
                {
                    break;
                }
            }
        }
    }
    
    return !var8;
}

