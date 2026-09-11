
// Params 0
// Size: 0x3ea
function init()
{
    level.classmap[ "class0" ] = 0;
    level.classmap[ "class1" ] = 1;
    level.classmap[ "class2" ] = 2;
    level.classmap[ "custom1" ] = 0;
    level.classmap[ "custom2" ] = 1;
    level.classmap[ "custom3" ] = 2;
    level.classmap[ "custom4" ] = 3;
    level.classmap[ "custom5" ] = 4;
    level.classmap[ "custom6" ] = 5;
    level.classmap[ "custom7" ] = 6;
    level.classmap[ "custom8" ] = 7;
    level.classmap[ "custom9" ] = 8;
    level.classmap[ "custom10" ] = 9;
    level.classmap[ "axis_recipe1" ] = 0;
    level.classmap[ "axis_recipe2" ] = 1;
    level.classmap[ "axis_recipe3" ] = 2;
    level.classmap[ "axis_recipe4" ] = 3;
    level.classmap[ "axis_recipe5" ] = 4;
    level.classmap[ "axis_recipe6" ] = 5;
    level.classmap[ "allies_recipe1" ] = 0;
    level.classmap[ "allies_recipe2" ] = 1;
    level.classmap[ "allies_recipe3" ] = 2;
    level.classmap[ "allies_recipe4" ] = 3;
    level.classmap[ "allies_recipe5" ] = 4;
    level.classmap[ "allies_recipe6" ] = 5;
    level.classmap[ "gamemode" ] = 0;
    level.classmap[ "custgamemode" ] = 0;
    level.classmap[ "custgamemode1" ] = 0;
    level.classmap[ "custgamemode2" ] = 1;
    level.classmap[ "custgamemode3" ] = 2;
    level.classmap[ "custgamemode4" ] = 3;
    level.classmap[ "custgamemode5" ] = 4;
    level.classmap[ "custgamemode6" ] = 5;
    level.classmap[ "custgamemode7" ] = 6;
    level.classmap[ "custgamemode8" ] = 7;
    level.classmap[ "custgamemode9" ] = 8;
    level.classmap[ "custgamemode10" ] = 9;
    level.classmap[ "custgamemode_d1" ] = 0;
    level.classmap[ "custgamemode_d2" ] = 1;
    level.classmap[ "custgamemode_d3" ] = 2;
    level.classmap[ "custgamemode_d4" ] = 3;
    level.classmap[ "custgamemode_d5" ] = 4;
    level.classmap[ "callback" ] = 0;
    level.classmap[ "default1" ] = 0;
    level.classmap[ "default2" ] = 1;
    level.classmap[ "default3" ] = 2;
    level.classmap[ "default4" ] = 3;
    level.classmap[ "default5" ] = 4;
    level.classmap[ "default6" ] = 5;
    level.classmap[ "default7" ] = 6;
    level.classmap[ "default8" ] = 7;
    level.classmap[ "default9" ] = 8;
    level.classmap[ "default10" ] = 9;
    level.classmap[ "default11" ] = 10;
    level.classmap[ "juggernaut" ] = 0;
    level.defaultclass = "CLASS_ASSAULT";
    
    if ( getdvarint( "scr_br_mmp_defaultLoadouts", 0 ) )
    {
        level.classtablename = "mp/classtable_br_default_mmp.csv";
    }
    else if ( level.gametype == "br" || level.gametype == "brtdm" )
    {
        level.classtablename = "mp/classtable_br_default.csv";
    }
    else if ( scripts\mp\utility\game::tv_station_intro_camera() )
    {
        var0 = getdvarint( "scr_classtable_override", 0 );
        
        switch ( var0 )
        {
            case 1:
                level.classtablename = "mp/classtable_snipers_only.csv";
                break;
            default:
                level.classtablename = "mp/classtable.csv";
                break;
        }
        
        setomnvar( "ui_classtable_override", var0 );
    }
    else if ( getdvarint( "scr_test_loadouts", 0 ) )
    {
        level.classtablename = "mp/classtable_test.csv";
    }
    else if ( scripts\mp\utility\game::isanymlgmatch() )
    {
        level.classtablename = "mp/classtable_cdl.csv";
    }
    else
    {
        level.classtablename = "mp/classtable.csv";
    }
    
    thread onplayerconnecting();
    thread onplayerspawned();
}

// Params 1
// Size: 0x6
function getclasschoice( var0 )
{
    return var0;
}

// Params 1
// Size: 0x23
function getweaponchoice( var0 )
{
    var1 = strtok( var0, "," );
    
    if ( var1.size > 1 )
    {
        return int( var1[ 1 ] );
    }
    
    return 0;
}

// Params 2
// Size: 0x26
function cac_getweapon( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "weapon" );
}

// Params 3
// Size: 0x2d
function cac_getweaponattachment( var0, var1, var2 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "attachmentSetup", var2, "attachment" );
}

// Params 3
// Size: 0x2d
function force_interrupt_current_combat_action( var0, var1, var2 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "attachmentSetup", var2, "variantID" );
}

// Params 2
// Size: 0x26
function cac_getweaponlootitemid( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "lootItemID" );
}

// Params 2
// Size: 0x26
function cac_getweaponvariantid( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "variantID" );
}

// Params 2
// Size: 0x26
function cac_getweaponcamo( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "camo" );
}

// Params 2
// Size: 0x26
function cac_getweaponreticle( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "reticle" );
}

// Params 2
// Size: 0x22
function cac_getkillstreak( var0, var1 )
{
    var2 = self getplayerdata( level.loadoutsgroup, "squadMembers", "killstreakSetups", var0, "killstreak" );
    return var2;
}

// Params 0
// Size: 0x1d
function cac_getcharacterarchetype()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        return self.changedarchetypeinfo.archetype;
    }
    
    return "archetype_assault";
}

// Params 1
// Size: 0x25
function cac_getequipmentprimary( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 0, "equipment" );
}

// Params 1
// Size: 0x25
function cac_getextraequipmentprimary( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 0, "extraCharge" );
}

// Params 1
// Size: 0x26
function cac_getequipmentsecondary( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 1, "equipment" );
}

// Params 1
// Size: 0x26
function cac_getextraequipmentsecondary( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "equipmentSetups", 1, "extraCharge" );
}

// Params 0
// Size: 0x2b
function cac_getsuper()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        return self.changedarchetypeinfo.super;
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypeSuper" );
}

// Params 1
// Size: 0x19
function cac_getfieldupgrade( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "fieldUpgrades", var0 );
}

// Params 0
// Size: 0x62
function cac_getgesture()
{
    var0 = "none";
    
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        var1 = level.archetypeids[ self.changedarchetypeinfo.archetype ];
        var0 = self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypePreferences", var1, "gesture" );
    }
    else
    {
        var0 = self getplayerdata( level.loadoutsgroup, "squadMembers", "gesture" );
    }
    
    return scripts\cp_mp\gestures::getgesturedata( var0 );
}

// Params 0
// Size: 0x1e
function cac_getaccessoryweapon()
{
    var0 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\mp\accessories::getaccessoryweaponbyindex( var0 );
}

// Params 0
// Size: 0x1e
function cac_getaccessorydata()
{
    var0 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\mp\accessories::getaccessorydatabyindex( var0 );
}

// Params 0
// Size: 0x1e
function force_interrupt_all_current_combat_actions()
{
    var0 = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\mp\accessories::register_respawn_functions( var0 );
}

// Params 2
// Size: 0x21
function cac_getloadoutperk( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "loadoutPerks", var1 );
}

// Params 2
// Size: 0x21
function cac_getloadoutextraperk( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "extraPerks", var1 );
}

// Params 0
// Size: 0x2b
function cac_getloadoutarchetypeperk()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        return self.changedarchetypeinfo.trait;
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypePerk" );
}

// Params 1
// Size: 0x1e
function cac_getusingspecialist( var0 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "usingSpecialist" );
}

// Params 2
// Size: 0x26
function cac_getweaponcosmeticattachment( var0, var1 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "cosmeticAttachment" );
}

// Params 3
// Size: 0x28
function cac_getweaponsticker( var0, var1, var2 )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", var0, "weaponSetups", var1, "sticker", var2 );
}

// Params 3
// Size: 0x23
function recipe_getkillstreak( var0, var1, var2 )
{
    return scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var0, var1, "class", "kilstreakSetups", var2, "killstreak" );
}

// Params 2
// Size: 0x14
function table_getarchetype( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutArchetype", var1 + 1 );
}

// Params 2
// Size: 0x14
function table_getloadoutname( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutName", var1 + 1 );
}

// Params 3
// Size: 0x3a
function ref_139e4( var0, var1, var2 )
{
    var3 = scripts\engine\utility::ter_op( var2 == 0, "loadoutPrimaryAddBlueprintAttachments", "loadoutSecondaryAddBlueprintAttachments" );
    var4 = tablelookup( var0, 0, var3, var1 + 1 );
    
    if ( var4 == "" )
    {
        return 0;
    }
    
    return istrue( int( var4 ) );
}

// Params 3
// Size: 0x2c
function table_getweapon( var0, var1, var2 )
{
    if ( var2 == 0 )
    {
        return tablelookup( var0, 0, "loadoutPrimary", var1 + 1 );
    }
    
    return tablelookup( var0, 0, "loadoutSecondary", var1 + 1 );
}

// Params 4
// Size: 0x5f
function table_getweaponattachment( var0, var1, var2, var3 )
{
    var4 = "none";
    
    if ( var2 == 0 )
    {
        var4 = tablelookup( var0, 0, "loadoutPrimaryAttachment" + var3 + 1, var1 + 1 );
    }
    else
    {
        var4 = tablelookup( var0, 0, "loadoutSecondaryAttachment" + var3 + 1, var1 + 1 );
    }
    
    if ( var4 == "" || var4 == "none" )
    {
        return "none";
    }
    
    return var4;
}

// Params 3
// Size: 0x2c
function table_getweaponcamo( var0, var1, var2 )
{
    if ( var2 == 0 )
    {
        return tablelookup( var0, 0, "loadoutPrimaryCamo", var1 + 1 );
    }
    
    return tablelookup( var0, 0, "loadoutSecondaryCamo", var1 + 1 );
}

// Params 3
// Size: 0x2c
function table_getweaponreticle( var0, var1, var2 )
{
    if ( var2 == 0 )
    {
        return tablelookup( var0, 0, "loadoutPrimaryReticle", var1 + 1 );
    }
    
    return tablelookup( var0, 0, "loadoutSecondaryReticle", var1 + 1 );
}

// Params 4
// Size: 0x3b
function ref_139e6( var0, var1, var2, var3 )
{
    var4 = undefined;
    
    if ( var2 == 0 )
    {
        var4 = tablelookup( var0, 0, "loadoutPrimaryVariantID", var1 + 1 );
    }
    else
    {
        var4 = tablelookup( var0, 0, "loadoutSecondaryVariantID", var1 + 1 );
    }
    
    return ref_139e7( var3, var4 );
}

// Params 2
// Size: 0x241
function ref_139e7( var0, var1 )
{
    if ( var0 == "none" )
    {
        return 0;
    }
    
    if ( !isdefined( level.confirm_good_pickup_location ) )
    {
        level.confirm_good_pickup_location = [];
        level.confirm_good_pickup_location[ "iw8_ar_tango21" ] = [ 1 ];
        level.confirm_good_pickup_location[ "iw8_ar_mike4" ] = [ 5 ];
        level.confirm_good_pickup_location[ "iw8_ar_kilo433" ] = [ 3 ];
        level.confirm_good_pickup_location[ "iw8_ar_scharlie" ] = [ 3 ];
        level.confirm_good_pickup_location[ "iw8_sm_uzulu" ] = [ 4 ];
        level.confirm_good_pickup_location[ "iw8_sh_romeo870" ] = [ 5 ];
        level.confirm_good_pickup_location[ "iw8_sh_dpapa12" ] = [ 3 ];
        level.confirm_good_pickup_location[ "iw8_lm_mgolf34" ] = [ 4 ];
        level.confirm_good_pickup_location[ "iw8_sn_kilo98" ] = [ 16 ];
        level.confirm_good_pickup_location[ "iw8_sn_alpha50" ] = [ 2 ];
        level.confirm_good_pickup_location[ "iw8_sn_hdromeo" ] = [ 4 ];
        level.confirm_good_pickup_location[ "iw8_pi_golf21" ] = [ 3 ];
        level.confirm_good_pickup_location[ "iw8_pi_cpapa" ] = [ 15 ];
        var2 = getdvar( "scr_blockedClassTableVariants", "" );
        
        if ( var2 != "" )
        {
            var3 = strtok( var2, "," );
            
            foreach ( var5 in var3 )
            {
                var6 = strtok( var5, "|" );
                
                if ( var6.size == 2 )
                {
                    var7 = var6[ 0 ];
                    var8 = int( var6[ 1 ] );
                    
                    if ( !isdefined( level.confirm_good_pickup_location[ var7 ] ) )
                    {
                        level.confirm_good_pickup_location[ var7 ] = [];
                    }
                    
                    level.confirm_good_pickup_location[ var7 ][ level.confirm_good_pickup_location[ var7 ].size ] = var8;
                }
            }
        }
    }
    
    var10 = undefined;
    
    if ( isdefined( level.confirm_good_pickup_location[ var0 ] ) )
    {
        var10 = level.confirm_good_pickup_location[ var0 ];
    }
    
    var11 = 0;
    var12 = getdvarint( "scr_forceClassTableVariantRandom", 0 );
    
    if ( var12 == 1 )
    {
        var11 = scripts\mp\utility\weapon::runspawnmodule_isolated( var0, var10 );
    }
    else
    {
        var13 = strtok( var1, " " );
        var14 = [];
        
        foreach ( var16 in var13 )
        {
            var17 = int( var16 );
            
            if ( !isdefined( var10 ) || !scripts\engine\utility::array_contains( var10, var17 ) )
            {
                var14 = var17;
            }
        }
        
        if ( var14.size != 0 )
        {
            var11 = var14[ randomint( var14.size ) ];
        }
    }
    
    if ( var11 == -1 )
    {
        var11 = scripts\mp\utility\weapon::runspawnmodule_isolated( var0, var10 );
    }
    
    var19 = scripts\mp\utility\weapon::ref_1458c( var0, var11 );
    
    if ( !var19 )
    {
        var11 = 0;
    }
    
    return var11;
}

// Params 3
// Size: 0x1a
function table_getperk( var0, var1, var2 )
{
    return tablelookup( var0, 0, "loadoutPerk" + var2 + 1, var1 + 1 );
}

// Params 3
// Size: 0x1a
function table_getextraperk( var0, var1, var2 )
{
    return tablelookup( var0, 0, "loadoutExtraPerk" + var2 + 1, var1 + 1 );
}

// Params 2
// Size: 0x14
function table_getequipmentprimary( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutEquipmentPrimary", var1 + 1 );
}

// Params 2
// Size: 0x22, Type: bool
function table_getextraequipmentprimary( var0, var1 )
{
    var2 = tablelookup( var0, 0, "loadoutExtraEquipmentPrimary", var1 + 1 );
    return isdefined( var2 ) && var2 == "TRUE";
}

// Params 2
// Size: 0x14
function table_getequipmentsecondary( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutEquipmentSecondary", var1 + 1 );
}

// Params 2
// Size: 0x22, Type: bool
function table_getextraequipmentsecondary( var0, var1 )
{
    var2 = tablelookup( var0, 0, "loadoutExtraEquipmentSecondary", var1 + 1 );
    return isdefined( var2 ) && var2 == "TRUE";
}

// Params 2
// Size: 0x14
function table_getsuper( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutSuper", var1 + 1 );
}

// Params 2
// Size: 0x22, Type: bool
function table_getspecialist( var0, var1 )
{
    var2 = tablelookup( var0, 0, "loadoutSpecialist", var1 + 1 );
    return isdefined( var2 ) && var2 == "TRUE";
}

// Params 2
// Size: 0x14
function table_getgesture( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutGesture", var1 + 1 );
}

// Params 2
// Size: 0x14
function table_getaccessory( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutAccessory", var1 + 1 );
}

// Params 2
// Size: 0x14
function table_getexecution( var0, var1 )
{
    return tablelookup( var0, 0, "loadoutExecution", var1 + 1 );
}

// Params 3
// Size: 0x17
function table_getkillstreak( var0, var1, var2 )
{
    return tablelookup( var0, 0, "loadoutStreak" + var2, var1 + 1 );
}

// Params 1
// Size: 0x5c
function loadout_getplayerstreaktype( var0 )
{
    var1 = undefined;
    
    switch ( var0 )
    {
        case "streaktype_support":
            var1 = "support";
            break;
        case "streaktype_specialist":
        case "specialist":
            var1 = "specialist";
            break;
        case "streaktype_resource":
            var1 = "resource";
            break;
        default:
            var1 = "assault";
            break;
    }
    
    return var1;
}

// Params 1
// Size: 0x4c
function getloadoutstreaktypefromstreaktype( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return "streaktype_assault";
    }
    
    switch ( var0 )
    {
        case "support":
            return "streaktype_support";
        case "specialist":
            return "streaktype_specialist";
        case "assault":
            return "streaktype_assault";
        default:
            return "streaktype_assault";
    }
}

// Params 1
// Size: 0x51
function loadout_getclassteam( var0 )
{
    if ( self.team == "spectator" )
    {
        var0 = "none";
    }
    
    var1 = undefined;
    
    if ( issubstr( var0, "axis" ) )
    {
        var1 = "axis";
    }
    else if ( issubstr( var0, "allies" ) )
    {
        var1 = "allies";
    }
    else
    {
        var1 = "none";
    }
    
    return var1;
}

// Params 1
// Size: 0x5f
function loadout_clearplayer( var0 )
{
    loadout_clearweapons( var0 );
    _detachall( var0 );
    scripts\mp\equipment::clearallequipment();
    
    if ( isdefined( self.loadoutarchetype ) )
    {
        clearscriptable();
    }
    
    scripts\mp\archetypes\archcommon::removearchetype( self.loadoutarchetype );
    loadout_clearperks( var0 );
    scripts\mp\perks\weaponpassives::forgetpassives();
    scripts\cp_mp\gestures::cleargesture();
    scripts\cp_mp\execution::_clearexecution();
    scripts\mp\accessories::clearplayeraccessory();
    scripts\mp\perks\perkpackage::ref_12301();
    
    if ( !istrue( var0 ) )
    {
        resetfunctionality();
        resetactionslots();
    }
}

// Params 1
// Size: 0x67
function loadout_clearweapons( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( isdefined( self.primaryweaponobj ) )
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.primaryweaponobj );
        }
        
        if ( isdefined( self.secondaryweaponobj ) && self.secondaryweaponobj.basename != "none" )
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.secondaryweaponobj );
        }
    }
    else
    {
        self takeallweapons();
    }
    
    self.primaryweapon = undefined;
    self.primaryweaponobj = undefined;
    self.secondaryweapon = undefined;
    self.secondaryweaponobj = undefined;
}

// Params 1
// Size: 0x28
function loadout_giveperk( var0 )
{
    if ( !isdefined( self.loadoutperks ) )
    {
        self.loadoutperks = [];
    }
    
    scripts\mp\utility\perk::giveperk( var0 );
    self.loadoutperks[ self.loadoutperks.size ] = var0;
}

// Params 1
// Size: 0x5f
function loadout_removeperk( var0 )
{
    if ( isdefined( self.loadoutperks ) )
    {
        var1 = 0;
        var2 = [];
        
        foreach ( var4 in self.loadoutperks )
        {
            if ( !var1 )
            {
                if ( var4 == var0 )
                {
                    scripts\mp\utility\perk::removeperk( var4 );
                    var1 = 1;
                    continue;
                }
            }
            
            var2 = var4;
        }
        
        self.loadoutperks = var2;
        return;
    }
}

// Params 1
// Size: 0x60
function loadout_clearperks( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( isdefined( self.loadoutperks ) )
        {
            foreach ( var2 in self.loadoutperks )
            {
                scripts\mp\utility\perk::removeperk( var2 );
            }
        }
    }
    else
    {
        scripts\mp\perks\perks::_clearperks();
        self notify( "all_perks_cleared" );
    }
    
    self.loadoutperks = [];
    self notify( "loadout_perks_cleared" );
}

// Params 0
// Size: 0x26b
function loadout_getclassstruct()
{
    var0 = spawnstruct();
    var0.loadoutarchetype = "none";
    var0.loadoutprimary = "none";
    var0.loadoutprimaryattachments = [];
    var0.loadoutprimaryattachmentids = [];
    
    for ( var1 = 0; var1 < 10 ; var1++ )
    {
        var0.loadoutprimaryattachments[ var1 ] = "none";
        var0.loadoutprimaryattachmentids[ var1 ] = 0;
    }
    
    var0.loadoutprimarycamo = "none";
    var0.loadoutprimaryreticle = "none";
    var0.loadoutprimarylootitemid = 0;
    var0.loadoutprimaryvariantid = -1;
    var0.loadoutprimarycosmeticattachment = "none";
    var0.loadoutprimarystickers = [];
    
    for ( var2 = 0; var2 < 4 ; var2++ )
    {
        var0.loadoutprimarystickers[ var2 ] = "none";
    }
    
    var0.loadoutsecondary = "none";
    var0.loadoutsecondaryattachments = [];
    var0.loadoutsecondaryattachmentids = [];
    
    for ( var1 = 0; var1 < 10 ; var1++ )
    {
        var0.loadoutsecondaryattachments[ var1 ] = "none";
        var0.loadoutsecondaryattachmentids[ var1 ] = 0;
    }
    
    var0.loadoutsecondarycamo = "none";
    var0.loadoutsecondaryreticle = "none";
    var0.loadoutsecondarylootitemid = 0;
    var0.loadoutsecondaryvariantid = -1;
    var0.loadoutsecondarycosmeticattachment = "none";
    var0.loadoutsecondarystickers = [];
    
    for ( var2 = 0; var2 < 4 ; var2++ )
    {
        var0.loadoutsecondarystickers[ var2 ] = "none";
    }
    
    var0.loadoutmeleeslot = "none";
    var0.loadoutperksfromgamemode = 0;
    var0.loadoutperks = [];
    var0.loadoutstandardperks = [];
    var0.loadoutextraperks = [];
    var0.loadoutrigtrait = "specialty_null";
    var0.loadoutusingspecialist = 0;
    var0.loadoutequipmentprimary = "none";
    var0.loadoutextraequipmentprimary = 0;
    var0.loadoutequipmentsecondary = "none";
    var0.loadoutextraequipmentsecondary = 0;
    var0.loadoutsuper = "none";
    var0.loadoutgesture = "none";
    var0.loadoutaccessorydata = "none";
    var0.loadoutaccessoryweapon = "none";
    var0.loadoutstreaksfilled = 0;
    var0.loadoutstreaktype = "streaktype_assault";
    var0.loadoutkillstreak1 = "none";
    var0.loadoutkillstreak2 = "none";
    var0.loadoutkillstreak3 = "none";
    var0.tweakedbyplayerduringmatch = 0;
    var0.gamemodeforcednewloadout = 0;
    var0.uavbestid = 0;
    return var0;
}

// Params 1
// Size: 0x2c1
function zombieregenratescaleingas( var0 )
{
    var1 = spawnstruct();
    var1.loadoutarchetype = var0.loadoutarchetype;
    
    if ( isdefined( var0.ref_11960 ) )
    {
        var1.ref_11960 = var0.ref_11960;
    }
    
    var1.loadoutprimary = var0.loadoutprimary;
    var1.loadoutprimaryattachments = var0.loadoutprimaryattachments;
    var1.loadoutprimaryattachmentids = var0.loadoutprimaryattachmentids;
    var1.loadoutprimarycamo = var0.loadoutprimarycamo;
    var1.loadoutprimaryreticle = var0.loadoutprimaryreticle;
    var1.loadoutprimarylootitemid = var0.loadoutprimarylootitemid;
    var1.loadoutprimaryvariantid = var0.loadoutprimaryvariantid;
    var1.loadoutprimarycosmeticattachment = var0.loadoutprimarycosmeticattachment;
    var1.loadoutprimarystickers = var0.loadoutprimaryweaponstickers;
    
    if ( isdefined( var0.ref_11961 ) )
    {
        var1.ref_11961 = var0.ref_11961;
    }
    
    var1.loadoutsecondary = var0.loadoutsecondary;
    var1.loadoutsecondaryattachments = var0.loadoutsecondaryattachments;
    var1.loadoutsecondaryattachmentids = var0.loadoutsecondaryattachmentids;
    var1.loadoutsecondarycamo = var0.loadoutsecondarycamo;
    var1.loadoutsecondaryreticle = var0.loadoutsecondaryreticle;
    var1.loadoutsecondarylootitemid = var0.loadoutsecondarylootitemid;
    var1.loadoutsecondaryvariantid = var0.loadoutsecondaryvariantid;
    var1.loadoutsecondarycosmeticattachment = var0.loadoutsecondarycosmeticattachment;
    var1.loadoutsecondarystickers = var0.loadoutsecondarystickers;
    var1.loadoutmeleeslot = var0.loadoutmeleeslot;
    var1.loadoutperksfromgamemode = var0.loadoutperksfromgamemode;
    var1.loadoutperks = var0.loadoutperks;
    var1.loadoutstandardperks = var0.loadoutstandardperks;
    var1.loadoutextraperks = var0.loadoutextraperks;
    var1.loadoutrigtrait = var0.loadoutrigtrait;
    var1.loadoutusingspecialist = var0.loadoutusingspecialist;
    var1.loadoutequipmentprimary = var0.loadoutequipmentprimary;
    var1.loadoutextraequipmentprimary = var0.loadoutextraequipmentprimary;
    var1.loadoutequipmentsecondary = var0.loadoutequipmentsecondary;
    var1.loadoutextraequipmentsecondary = var0.loadoutextraequipmentsecondary;
    var1.loadoutsuper = var0.loadoutsuper;
    var1.loadoutgesture = var0.loadoutgesture;
    var1.loadoutaccessorydata = var0.loadoutaccessorydata;
    var1.loadoutaccessoryweapon = var0.loadoutaccessoryweapon;
    var1.loadoutstreaksfilled = var0.loadoutstreaksfilled;
    var1.loadoutstreaktype = var0.loadoutstreaktype;
    var1.loadoutkillstreak1 = var0.loadoutkillstreak1;
    var1.loadoutkillstreak2 = var0.loadoutkillstreak2;
    var1.loadoutkillstreak3 = var0.loadoutkillstreak3;
    var1.tweakedbyplayerduringmatch = var0.tweakedbyplayerduringmatch;
    var1.gamemodeforcednewloadout = var0.gamemodeforcednewloadout;
    var1.uavbestid = var0.uavbestid;
    var1 = loadout_updateclass( var1, "copied" );
    return var1;
}

// Params 3
// Size: 0x2c6
function loadout_updateclassteam( var0, var1, var2 )
{
    var2 = loadout_getclassteam( var1 );
    var3 = getclassindex( var1 );
    self.class_num = var3;
    self.classteam = var2;
    var0.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "archetype" );
    var0.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 0, "weapon" );
    
    if ( var0.loadoutprimary == "none" )
    {
        var0.loadoutprimary = "iw8_fists";
    }
    else
    {
        for ( var4 = 0; var4 < 10 ; var4++ )
        {
            var0.loadoutprimaryattachments[ var4 ] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 0, "attachmentSetup", var4, "attachment" );
        }
        
        for ( var5 = 0; var5 < 4 ; var5++ )
        {
            var0.loadoutprimarystickers[ var5 ] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 0, "sticker", var5 );
        }
    }
    
    var0.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 0, "camo" );
    var0.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 0, "reticle" );
    var0.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 1, "weapon" );
    
    for ( var4 = 0; var4 < 10 ; var4++ )
    {
        var0.loadoutsecondaryattachments[ var4 ] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 1, "attachmentSetup", var4, "attachment" );
    }
    
    for ( var5 = 0; var5 < 4 ; var5++ )
    {
        var0.loadoutsecondarystickers[ var5 ] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 1, "sticker", var5 );
    }
    
    var0.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 1, "camo" );
    var0.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "weaponSetups", 1, "reticle" );
    var0.loadoutmeleeslot = "none";
    var0.loadoutequipmentprimary = "none";
    var0.loadoutextraequipmentprimary = 0;
    var0.loadoutequipmentsecondary = "none";
    var0.loadoutextraequipmentsecondary = 0;
    var0.loadoutsuper = "none";
    var0.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var2, var3, "class", "gesture" );
    var0.loadoutstreaksfilled = 1;
    var0.loadoutkillstreak1 = recipe_getkillstreak( var2, var3, 0 );
    var0.loadoutkillstreak2 = recipe_getkillstreak( var2, var3, 1 );
    var0.loadoutkillstreak3 = recipe_getkillstreak( var2, var3, 2 );
}

// Params 2
// Size: 0x36f
function loadout_updateclasscustom( var0, var1 )
{
    var2 = getclassindex( var1 );
    self.class_num = var2;
    
    if ( !isdefined( var2 ) )
    {
        var3 = scripts\engine\utility::ter_op( isdefined( self.name ), self.name, "<undefined>" );
        var4 = scripts\engine\utility::ter_op( isdefined( var1 ), var1, "<undefined>" );
        scripts\mp\utility\script::laststand_dogtags( "loadout_updateClassCustom() called on " + var3 + " with invalid class = " + var4 );
    }
    
    var0.loadoutarchetype = cac_getcharacterarchetype();
    var0.loadoutprimary = cac_getweapon( var2, 0 );
    
    for ( var5 = 0; var5 < 10 ; var5++ )
    {
        var0.loadoutprimaryattachments[ var5 ] = cac_getweaponattachment( var2, 0, var5 );
        var0.loadoutprimaryattachmentids[ var5 ] = force_interrupt_current_combat_action( var2, 0, var5 );
    }
    
    var0.loadoutprimarycamo = cac_getweaponcamo( var2, 0 );
    var0.loadoutprimaryreticle = cac_getweaponreticle( var2, 0 );
    var0.loadoutprimarylootitemid = cac_getweaponlootitemid( var2, 0 );
    var0.loadoutprimaryvariantid = cac_getweaponvariantid( var2, 0 );
    var0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment( var2, 0 );
    
    for ( var6 = 0; var6 < 4 ; var6++ )
    {
        var0.loadoutprimarystickers[ var6 ] = cac_getweaponsticker( var2, 0, var6 );
    }
    
    var0.loadoutsecondary = cac_getweapon( var2, 1 );
    
    for ( var5 = 0; var5 < 10 ; var5++ )
    {
        var0.loadoutsecondaryattachments[ var5 ] = cac_getweaponattachment( var2, 1, var5 );
        var0.loadoutsecondaryattachmentids[ var5 ] = force_interrupt_current_combat_action( var2, 1, var5 );
    }
    
    var0.loadoutsecondarycamo = cac_getweaponcamo( var2, 1 );
    var0.loadoutsecondaryreticle = cac_getweaponreticle( var2, 1 );
    var0.loadoutsecondarylootitemid = cac_getweaponlootitemid( var2, 1 );
    var0.loadoutsecondaryvariantid = cac_getweaponvariantid( var2, 1 );
    var0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment( var2, 1 );
    
    for ( var6 = 0; var6 < 4 ; var6++ )
    {
        var0.loadoutsecondarystickers[ var6 ] = cac_getweaponsticker( var2, 1, var6 );
    }
    
    var0.loadoutequipmentprimary = cac_getequipmentprimary( var2 );
    var0.loadoutextraequipmentprimary = cac_getextraequipmentprimary( var2 );
    var0.loadoutequipmentsecondary = cac_getequipmentsecondary( var2 );
    var0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary( var2 );
    var0.loadoutsuper = cac_getsuper();
    var0.loadoutgesture = cac_getgesture();
    loadout_updateclassaccessory( var0 );
    var0.loadoutstreaksfilled = 1;
    var0.loadoutkillstreak1 = cac_getkillstreak( 0, var1 );
    var0.loadoutkillstreak2 = cac_getkillstreak( 1, var1 );
    var0.loadoutkillstreak3 = cac_getkillstreak( 2, var1 );
    var0.loadoutusingspecialist = cac_getusingspecialist( var2 );
    var7 = 0;
    
    foreach ( var9 in var0.loadoutprimaryattachments )
    {
        if ( var9 != "none" )
        {
            var7++;
        }
    }
    
    var11 = 0;
    
    foreach ( var9 in var0.loadoutsecondaryattachments )
    {
        if ( var9 != "none" )
        {
            var11++;
        }
    }
    
    var14 = int( tablelookup( "mp/statstable.csv", 4, var0.loadoutprimary, 18 ) );
    
    if ( var14 < var7 )
    {
        for ( var5 = 0; var5 < 10 ; var5++ )
        {
            var0.loadoutprimaryattachments[ var5 ] = "none";
            var0.loadoutprimaryattachmentids[ var5 ] = 0;
        }
    }
    
    var14 = int( tablelookup( "mp/statstable.csv", 4, var0.loadoutsecondary, 18 ) );
    
    if ( var14 < var11 )
    {
        for ( var5 = 0; var5 < 10 ; var5++ )
        {
            var0.loadoutsecondaryattachments[ var5 ] = "none";
            var0.loadoutsecondaryattachmentids[ var5 ] = 0;
        }
        
        return;
    }
}

// Params 2
// Size: 0x5b1
function loadout_updateclassgamemode( var0, var1 )
{
    var2 = getclassindex( var1 );
    self.class_num = var2;
    var3 = self.pers[ "gamemodeLoadout" ];
    
    if ( isdefined( var3[ "loadoutArchetype" ] ) )
    {
        var0.loadoutarchetype = var3[ "loadoutArchetype" ];
    }
    else if ( isbot( self ) )
    {
        var4 = scripts\mp\bots\bots_loadout::bot_loadout_class_callback();
        var0.loadoutarchetype = var4[ "loadoutArchetype" ];
    }
    else
    {
        var0.loadoutarchetype = cac_getcharacterarchetype();
    }
    
    if ( isdefined( var3[ "loadoutRigTrait" ] ) )
    {
        var0.loadoutrigtrait = var3[ "loadoutRigTrait" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimaryAddBlueprintAttachments" ] ) )
    {
        var0.ref_11960 = var3[ "loadoutPrimaryAddBlueprintAttachments" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimary" ] ) )
    {
        var0.loadoutprimary = var3[ "loadoutPrimary" ];
    }
    
    for ( var5 = 0; var5 < 10 ; var5++ )
    {
        var6 = getattachmentloadoutstring( var5, "primary" );
        
        if ( isdefined( var3[ var6 ] ) )
        {
            var0.loadoutprimaryattachments[ var5 ] = var3[ var6 ];
        }
    }
    
    for ( var7 = 0; var7 < 4 ; var7++ )
    {
        var8 = getstickerloadoutstring( var7, "primary" );
        
        if ( isdefined( var3[ var8 ] ) )
        {
            var0.loadoutprimarystickers[ var7 ] = var3[ var8 ];
        }
    }
    
    if ( isdefined( var3[ "loadoutPrimaryCamo" ] ) )
    {
        var0.loadoutprimarycamo = var3[ "loadoutPrimaryCamo" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimaryCosmeticAttachment" ] ) )
    {
        var0.loadoutprimarycosmeticattachment = var3[ "loadoutPrimaryCosmeticAttachment" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimaryReticle" ] ) )
    {
        var0.loadoutprimaryreticle = var3[ "loadoutPrimaryReticle" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimaryVariantID" ] ) )
    {
        var0.loadoutprimaryvariantid = var3[ "loadoutPrimaryVariantID" ];
    }
    
    if ( isdefined( var3[ "loadoutPrimaryVariantID" ] ) && scripts\mp\utility\game::getgametype() == "arena" )
    {
        if ( isdefined( var3[ "roundWinStreakPrimaryCamoTeam" ] ) && isdefined( self.pers[ "team" ] ) && var3[ "roundWinStreakPrimaryCamoTeam" ] == self.pers[ "team" ] )
        {
            if ( isdefined( var3[ "roundWinStreakPrimaryCamo" ] ) )
            {
                var0.loadoutprimarycamo = var3[ "roundWinStreakPrimaryCamo" ];
            }
        }
        
        if ( var3[ "loadoutPrimaryVariantID" ] != -1 )
        {
            setomnvar( "ui_arena_primaryVariantID", var3[ "loadoutPrimaryVariantID" ] );
        }
    }
    
    if ( isdefined( var3[ "loadoutSecondaryAddBlueprintAttachments" ] ) )
    {
        var0.ref_11961 = var3[ "loadoutSecondaryAddBlueprintAttachments" ];
    }
    
    if ( isdefined( var3[ "loadoutSecondary" ] ) )
    {
        var0.loadoutsecondary = var3[ "loadoutSecondary" ];
    }
    
    for ( var5 = 0; var5 < 10 ; var5++ )
    {
        var6 = getattachmentloadoutstring( var5, "secondary" );
        
        if ( isdefined( var3[ var6 ] ) )
        {
            var0.loadoutsecondaryattachments[ var5 ] = var3[ var6 ];
        }
    }
    
    for ( var7 = 0; var7 < 4 ; var7++ )
    {
        var8 = getstickerloadoutstring( var7, "secondary" );
        
        if ( isdefined( var3[ var8 ] ) )
        {
            var0.loadoutsecondarystickers[ var7 ] = var3[ var8 ];
        }
    }
    
    if ( isdefined( var3[ "loadoutSecondaryCamo" ] ) )
    {
        var0.loadoutsecondarycamo = var3[ "loadoutSecondaryCamo" ];
    }
    
    if ( isdefined( var3[ "loadoutSecondaryCosmeticAttachment" ] ) )
    {
        var0.loadoutsecondarycosmeticattachment = var3[ "loadoutSecondaryCosmeticAttachment" ];
    }
    
    if ( isdefined( var3[ "loadoutSecondaryReticle" ] ) )
    {
        var0.loadoutsecondaryreticle = var3[ "loadoutSecondaryReticle" ];
    }
    
    if ( isdefined( var3[ "loadoutSecondaryVariantID" ] ) )
    {
        var0.loadoutsecondaryvariantid = var3[ "loadoutSecondaryVariantID" ];
    }
    
    if ( isdefined( var3[ "loadoutSecondaryVariantID" ] ) && scripts\mp\utility\game::getgametype() == "arena" && var3[ "loadoutSecondaryVariantID" ] != -1 )
    {
        if ( isdefined( var3[ "roundWinStreakecondaryCamoTeam" ] ) && isdefined( self.pers[ "team" ] ) && var3[ "roundWinStreakecondaryCamoTeam" ] == self.pers[ "team" ] )
        {
            if ( isdefined( var3[ "roundWinStreakSecondaryCamo" ] ) )
            {
                var0.loadoutsecondarycamo = var3[ "roundWinStreakSecondaryCamo" ];
            }
        }
        
        if ( var3[ "loadoutSecondaryVariantID" ] != -1 )
        {
            setomnvar( "ui_arena_secondaryVariantID", var3[ "loadoutSecondaryVariantID" ] );
        }
    }
    
    if ( isdefined( var3[ "loadoutMeleeSlot" ] ) )
    {
        var0.loadoutmeleeslot = var3[ "loadoutMeleeSlot" ];
    }
    
    var0.loadoutperksfromgamemode = isdefined( var3[ "loadoutPerks" ] );
    
    if ( isdefined( var3[ "loadoutPerks" ] ) )
    {
        var0.loadoutperks = var3[ "loadoutPerks" ];
    }
    
    var0.ref_1195e = isdefined( var3[ "loadoutExtraPerks" ] );
    
    if ( isdefined( var3[ "loadoutExtraPerks" ] ) )
    {
        var0.loadoutextraperks = var3[ "loadoutExtraPerks" ];
    }
    
    if ( isdefined( var3[ "loadoutEquipmentPrimary" ] ) )
    {
        var0.loadoutequipmentprimary = var3[ "loadoutEquipmentPrimary" ];
    }
    
    if ( isdefined( var3[ "loadoutExtraEquipmentPrimary" ] ) )
    {
        var0.loadoutextraequipmentprimary = var3[ "loadoutExtraEquipmentPrimary" ];
    }
    
    if ( isdefined( var3[ "loadoutEquipmentSecondary" ] ) )
    {
        var0.loadoutequipmentsecondary = var3[ "loadoutEquipmentSecondary" ];
    }
    
    if ( isdefined( var3[ "loadoutExtraEquipmentSecondary" ] ) )
    {
        var0.loadoutextraequipmentsecondary = var3[ "loadoutExtraEquipmentSecondary" ];
    }
    
    if ( isdefined( var3[ "loadoutSuper" ] ) )
    {
        var0.loadoutsuper = var3[ "loadoutSuper" ];
    }
    
    if ( isbot( self ) )
    {
        var0.loadoutaccessoryweapon = "none";
        var0.loadoutaccessorydata = "none";
        var0.loadoutaccessorylogic = "none";
    }
    else
    {
        loadout_updateclassaccessory( var0 );
    }
    
    if ( isdefined( var3[ "loadoutGesture" ] ) )
    {
        if ( var3[ "loadoutGesture" ] == "playerData" )
        {
            if ( isbot( self ) )
            {
                var0.loadoutgesture = "none";
            }
            else
            {
                var0.loadoutgesture = cac_getgesture();
            }
        }
        else
        {
            var0.loadoutgesture = var3[ "loadoutGesture" ];
        }
    }
    
    if ( isdefined( var3[ "loadoutKillstreak1" ] ) && var3[ "loadoutKillstreak1" ] != "specialty_null" || isdefined( var3[ "loadoutKillstreak2" ] ) && var3[ "loadoutKillstreak2" ] != "specialty_null" || isdefined( var3[ "loadoutKillstreak3" ] ) && var3[ "loadoutKillstreak3" ] != "specialty_null" )
    {
        var0.loadoutstreaksfilled = 1;
        var0.loadoutkillstreak1 = var3[ "loadoutKillstreak1" ];
        var0.loadoutkillstreak2 = var3[ "loadoutKillstreak2" ];
        var0.loadoutkillstreak3 = var3[ "loadoutKillstreak3" ];
    }
    
    if ( isdefined( var3[ "loadoutUsingSpecialist" ] ) )
    {
        var0.loadoutusingspecialist = 1;
        return;
    }
}

// Params 2
// Size: 0x761
function zone_get_node_nearest_2d_bounds( var0, var1 )
{
    var2 = getclassindex( var1 );
    self.class_num = var2;
    var3 = self.pers[ "gamemodeLoadout" ];
    var4 = issubstr( var1, "custgamemode_d" );
    
    if ( !var4 )
    {
        var0.loadoutarchetype = cac_getcharacterarchetype();
        
        if ( isdefined( var3[ "loadoutPrimaryAddBlueprintAttachments" ] ) )
        {
            var0.ref_11960 = var3[ "loadoutPrimaryAddBlueprintAttachments" ];
        }
        
        if ( isdefined( var3[ "loadoutPrimary" ] ) )
        {
            var0.loadoutprimary = var3[ "loadoutPrimary" ];
            
            for ( var5 = 0; var5 < 10 ; var5++ )
            {
                var6 = getattachmentloadoutstring( var5, "primary" );
                
                if ( isdefined( var3[ var6 ] ) )
                {
                    var0.loadoutprimaryattachments[ var5 ] = var3[ var6 ];
                }
            }
            
            for ( var7 = 0; var7 < 4 ; var7++ )
            {
                var8 = getstickerloadoutstring( var7, "primary" );
                
                if ( isdefined( var3[ var8 ] ) )
                {
                    var0.loadoutprimarystickers[ var7 ] = var3[ var8 ];
                }
            }
            
            if ( isdefined( var3[ "loadoutPrimaryCamo" ] ) )
            {
                var0.loadoutprimarycamo = var3[ "loadoutPrimaryCamo" ];
            }
            
            if ( isdefined( var3[ "loadoutPrimaryCosmeticAttachment" ] ) )
            {
                var0.loadoutprimarycosmeticattachment = var3[ "loadoutPrimaryCosmeticAttachment" ];
            }
            
            if ( isdefined( var3[ "loadoutPrimaryReticle" ] ) )
            {
                var0.loadoutprimaryreticle = var3[ "loadoutPrimaryReticle" ];
            }
            
            if ( isdefined( var3[ "loadoutPrimaryVariantID" ] ) )
            {
                var0.loadoutprimaryvariantid = var3[ "loadoutPrimaryVariantID" ];
            }
        }
        else
        {
            var2.loadoutprimary = cac_getweapon( var4, 0 );
            
            for ( var5 = 0; var5 < 10 ; var5++ )
            {
                var2.loadoutprimaryattachments[ var5 ] = cac_getweaponattachment( var4, 0, var5 );
                var2.loadoutprimaryattachmentids[ var5 ] = force_interrupt_current_combat_action( var4, 0, var5 );
            }
            
            var2.loadoutprimarycamo = cac_getweaponcamo( var4, 0 );
            var2.loadoutprimaryreticle = cac_getweaponreticle( var4, 0 );
            var2.loadoutprimarylootitemid = cac_getweaponlootitemid( var4, 0 );
            var2.loadoutprimaryvariantid = cac_getweaponvariantid( var4, 0 );
            var2.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment( var4, 0 );
            
            for ( var7 = 0; var7 < 4 ; var7++ )
            {
                var2.loadoutprimarystickers[ var7 ] = cac_getweaponsticker( var4, 0, var7 );
            }
        }
        
        if ( isdefined( var5[ "loadoutSecondaryAddBlueprintAttachments" ] ) )
        {
            var2.ref_11961 = var5[ "loadoutSecondaryAddBlueprintAttachments" ];
        }
        
        if ( isdefined( var5[ "loadoutSecondary" ] ) )
        {
            var2.loadoutsecondary = var5[ "loadoutSecondary" ];
            
            for ( var5 = 0; var5 < 10 ; var5++ )
            {
                var6 = getattachmentloadoutstring( var5, "secondary" );
                
                if ( isdefined( var5[ var6 ] ) )
                {
                    var2.loadoutsecondaryattachments[ var5 ] = var5[ var6 ];
                }
            }
            
            for ( var7 = 0; var7 < 4 ; var7++ )
            {
                var8 = getstickerloadoutstring( var7, "secondary" );
                
                if ( isdefined( var5[ var8 ] ) )
                {
                    var2.loadoutsecondarystickers[ var7 ] = var5[ var8 ];
                }
            }
            
            if ( isdefined( var5[ "loadoutSecondaryCamo" ] ) )
            {
                var2.loadoutsecondarycamo = var5[ "loadoutSecondaryCamo" ];
            }
            
            if ( isdefined( var5[ "loadoutSecondaryCosmeticAttachment" ] ) )
            {
                var2.loadoutsecondarycosmeticattachment = var5[ "loadoutSecondaryCosmeticAttachment" ];
            }
            
            if ( isdefined( var5[ "loadoutSecondaryReticle" ] ) )
            {
                var2.loadoutsecondaryreticle = var5[ "loadoutSecondaryReticle" ];
            }
            
            if ( isdefined( var5[ "loadoutSecondaryVariantID" ] ) )
            {
                var2.loadoutsecondaryvariantid = var5[ "loadoutSecondaryVariantID" ];
            }
        }
        else
        {
            var2.loadoutsecondary = cac_getweapon( var4, 1 );
            
            for ( var5 = 0; var5 < 10 ; var5++ )
            {
                var2.loadoutsecondaryattachments[ var5 ] = cac_getweaponattachment( var4, 1, var5 );
                var2.loadoutsecondaryattachmentids[ var5 ] = force_interrupt_current_combat_action( var4, 1, var5 );
            }
            
            var2.loadoutsecondarycamo = cac_getweaponcamo( var4, 1 );
            var2.loadoutsecondaryreticle = cac_getweaponreticle( var4, 1 );
            var2.loadoutsecondarylootitemid = cac_getweaponlootitemid( var4, 1 );
            var2.loadoutsecondaryvariantid = cac_getweaponvariantid( var4, 1 );
            var2.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment( var4, 1 );
            
            for ( var7 = 0; var7 < 4 ; var7++ )
            {
                var2.loadoutsecondarystickers[ var7 ] = cac_getweaponsticker( var4, 1, var7 );
            }
        }
        
        if ( isdefined( var5[ "loadoutMeleeSlot" ] ) )
        {
            var2.loadoutmeleeslot = var5[ "loadoutMeleeSlot" ];
        }
        
        var2.loadoutequipmentprimary = cac_getequipmentprimary( var4 );
        var2.loadoutextraequipmentprimary = cac_getextraequipmentprimary( var4 );
        var2.loadoutequipmentsecondary = cac_getequipmentsecondary( var4 );
        var2.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary( var4 );
        var2.loadoutsuper = cac_getsuper();
        var2.loadoutgesture = cac_getgesture();
        loadout_updateclassaccessory( var2 );
        var2.loadoutstreaksfilled = 1;
        var2.loadoutkillstreak1 = cac_getkillstreak( 0, var3 );
        var2.loadoutkillstreak2 = cac_getkillstreak( 1, var3 );
        var2.loadoutkillstreak3 = cac_getkillstreak( 2, var3 );
        var2.loadoutusingspecialist = cac_getusingspecialist( var4 );
        return;
    }
    
    if ( isdefined( var5[ "loadoutPrimaryAddBlueprintAttachments" ] ) )
    {
        var2.ref_11960 = var5[ "loadoutPrimaryAddBlueprintAttachments" ];
    }
    
    if ( isdefined( var5[ "loadoutPrimary" ] ) )
    {
        var2.loadoutprimary = var5[ "loadoutPrimary" ];
        
        for ( var5 = 0; var5 < 10 ; var5++ )
        {
            var6 = getattachmentloadoutstring( var5, "primary" );
            
            if ( isdefined( var5[ var6 ] ) )
            {
                var2.loadoutprimaryattachments[ var5 ] = var5[ var6 ];
            }
        }
        
        for ( var7 = 0; var7 < 4 ; var7++ )
        {
            var8 = getstickerloadoutstring( var7, "primary" );
            
            if ( isdefined( var5[ var8 ] ) )
            {
                var2.loadoutprimarystickers[ var7 ] = var5[ var8 ];
            }
        }
        
        if ( isdefined( var5[ "loadoutPrimaryCamo" ] ) )
        {
            var2.loadoutprimarycamo = var5[ "loadoutPrimaryCamo" ];
        }
        
        if ( isdefined( var5[ "loadoutPrimaryCosmeticAttachment" ] ) )
        {
            var2.loadoutprimarycosmeticattachment = var5[ "loadoutPrimaryCosmeticAttachment" ];
        }
        
        if ( isdefined( var5[ "loadoutPrimaryReticle" ] ) )
        {
            var2.loadoutprimaryreticle = var5[ "loadoutPrimaryReticle" ];
        }
        
        if ( isdefined( var5[ "loadoutPrimaryVariantID" ] ) )
        {
            var2.loadoutprimaryvariantid = var5[ "loadoutPrimaryVariantID" ];
        }
    }
    else if ( !isagent( self ) && self calloutmarkerping_getent() && getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 )
    {
        zoomkey( var2 );
    }
    else
    {
        var2.loadoutprimary = table_getweapon( level.classtablename, var4, 0 );
        
        for ( var5 = 0; var5 < 10 ; var5++ )
        {
            var2.loadoutprimaryattachments[ var5 ] = table_getweaponattachment( level.classtablename, var4, 0, var5 );
        }
        
        var2.loadoutprimarycamo = table_getweaponcamo( level.classtablename, var4, 0 );
        var2.loadoutprimaryreticle = table_getweaponreticle( level.classtablename, var4, 0 );
        var2.loadoutsecondary = table_getweapon( level.classtablename, var4, 1 );
        
        for ( var5 = 0; var5 < 10 ; var5++ )
        {
            var2.loadoutsecondaryattachments[ var5 ] = table_getweaponattachment( level.classtablename, var4, 1, var5 );
        }
        
        var2.loadoutsecondarycamo = table_getweaponcamo( level.classtablename, var4, 1 );
        var2.loadoutsecondaryreticle = table_getweaponreticle( level.classtablename, var4, 1 );
    }
    
    var2.loadoutequipmentprimary = table_getequipmentprimary( level.classtablename, var4 );
    var2.loadoutextraequipmentprimary = table_getextraequipmentprimary( level.classtablename, var4 );
    var2.loadoutequipmentsecondary = table_getequipmentsecondary( level.classtablename, var4 );
    var2.loadoutextraequipmentsecondary = table_getextraequipmentsecondary( level.classtablename, var4 );
    var2.loadoutgesture = table_getgesture( level.classtablename, var4 );
    var2.loadoutsuper = table_getsuper( level.classtablename, var4 );
    var2.loadoutusingspecialist = table_getspecialist( level.classtablename, var4 );
    loadout_updateclassaccessory( var2 );
    var2.loadoutarchetype = cac_getcharacterarchetype();
    var2.loadoutkillstreak1 = cac_getkillstreak( 0, var3 );
    var2.loadoutkillstreak2 = cac_getkillstreak( 1, var3 );
    var2.loadoutkillstreak3 = cac_getkillstreak( 2, var3 );
    var2.loadoutrigtrait = cac_getloadoutarchetypeperk();
    
    if ( getdvarint( "scr_superForceLightTank", 0 ) )
    {
        var2.loadoutsuper = "super_bradley";
        return;
    }
}

// Params 1
// Size: 0x2fa
function loadout_updateclasscallback( var0 )
{
    if ( !isdefined( self.classcallback ) )
    {
        scripts\engine\utility::error( "self.classCallback function reference required for class 'callback'" );
    }
    
    var1 = self [[ self.classcallback ]]();
    
    if ( !isdefined( var1 ) )
    {
        scripts\engine\utility::error( "array required from self.classCallback for class 'callback'" );
    }
    
    if ( isdefined( var1[ "loadoutArchetype" ] ) )
    {
        var0.loadoutarchetype = var1[ "loadoutArchetype" ];
    }
    
    if ( isdefined( var1[ "loadoutPrimaryAddBlueprintAttachments" ] ) )
    {
        var0.ref_11960 = var1[ "loadoutPrimaryAddBlueprintAttachments" ];
    }
    
    if ( isdefined( var1[ "loadoutPrimary" ] ) )
    {
        var0.loadoutprimary = var1[ "loadoutPrimary" ];
    }
    
    for ( var2 = 0; var2 < 10 ; var2++ )
    {
        var3 = getattachmentloadoutstring( var2, "primary" );
        
        if ( isdefined( var1[ var3 ] ) )
        {
            var0.loadoutprimaryattachments[ var2 ] = var1[ var3 ];
        }
    }
    
    if ( isdefined( var1[ "loadoutPrimaryCamo" ] ) )
    {
        var0.loadoutprimarycamo = var1[ "loadoutPrimaryCamo" ];
    }
    
    if ( isdefined( var1[ "loadoutPrimaryReticle" ] ) )
    {
        var0.loadoutprimaryreticle = var1[ "loadoutPrimaryReticle" ];
    }
    
    if ( isdefined( var1[ "loadoutPrimaryVariantID" ] ) )
    {
        var0.loadoutprimaryvariantid = var1[ "loadoutPrimaryVariantID" ];
    }
    
    if ( isdefined( var1[ "loadoutSecondaryAddBlueprintAttachments" ] ) )
    {
        var0.ref_11961 = var1[ "loadoutSecondaryAddBlueprintAttachments" ];
    }
    
    if ( isdefined( var1[ "loadoutSecondary" ] ) )
    {
        var0.loadoutsecondary = var1[ "loadoutSecondary" ];
    }
    
    for ( var2 = 0; var2 < 10 ; var2++ )
    {
        var3 = getattachmentloadoutstring( var2, "secondary" );
        
        if ( isdefined( var1[ var3 ] ) )
        {
            var0.loadoutsecondaryattachments[ var2 ] = var1[ var3 ];
        }
    }
    
    if ( isdefined( var1[ "loadoutSecondaryCamo" ] ) )
    {
        var0.loadoutsecondarycamo = var1[ "loadoutSecondaryCamo" ];
    }
    
    if ( isdefined( var1[ "loadoutSecondaryReticle" ] ) )
    {
        var0.loadoutsecondaryreticle = var1[ "loadoutSecondaryReticle" ];
    }
    
    if ( isdefined( var1[ "loadoutSecondaryVariantID" ] ) )
    {
        var0.loadoutsecondaryvariantid = var1[ "loadoutSecondaryVariantID" ];
    }
    
    if ( isdefined( var1[ "loadoutMeleeSlot" ] ) )
    {
        var0.loadoutmeleeslot = var1[ "loadoutMeleeSlot" ];
    }
    
    if ( isdefined( var1[ "loadoutEquipmentPrimary" ] ) )
    {
        var0.loadoutequipmentprimary = var1[ "loadoutEquipmentPrimary" ];
    }
    
    if ( isdefined( var1[ "loadoutExtraEquipmentPrimary" ] ) )
    {
        var0.loadoutextraequipmentprimary = var1[ "loadoutExtraEquipmentPrimary" ];
    }
    
    if ( isdefined( var1[ "loadoutEquipmentSecondary" ] ) )
    {
        var0.loadoutequipmentsecondary = var1[ "loadoutEquipmentSecondary" ];
    }
    
    if ( isdefined( var1[ "loadoutExtraEquipmentSecondary" ] ) )
    {
        var0.loadoutextraequipmentsecondary = var1[ "loadoutExtraEquipmentSecondary" ];
    }
    
    if ( isdefined( var1[ "loadoutSuper" ] ) )
    {
        var0.loadoutsuper = var1[ "loadoutSuper" ];
    }
    
    if ( isdefined( var1[ "loadoutGesture" ] ) )
    {
        var0.loadoutgesture = var1[ "loadoutGesture" ];
    }
    
    var0.loadoutstreaksfilled = isdefined( var1[ "loadoutStreak1" ] ) || isdefined( var1[ "loadoutStreak2" ] ) || isdefined( var1[ "loadoutStreak3" ] );
    
    if ( isdefined( var1[ "loadoutStreakType" ] ) )
    {
        var0.loadoutstreaktype = var1[ "loadoutStreakType" ];
    }
    
    if ( isdefined( var1[ "loadoutStreak1" ] ) )
    {
        var0.loadoutkillstreak1 = var1[ "loadoutStreak1" ];
    }
    
    if ( isdefined( var1[ "loadoutStreak2" ] ) )
    {
        var0.loadoutkillstreak2 = var1[ "loadoutStreak2" ];
    }
    
    if ( isdefined( var1[ "loadoutStreak3" ] ) )
    {
        var0.loadoutkillstreak3 = var1[ "loadoutStreak3" ];
        return;
    }
}

// Params 2
// Size: 0x17b
function loadout_updateclassdefault( var0, var1 )
{
    var2 = getclassindex( var1 );
    self.class_num = var2;
    
    if ( !isdefined( var2 ) )
    {
        var3 = "<undefined>";
        var4 = "<undefined>";
        
        if ( isdefined( self.name ) )
        {
            var3 = self.name;
        }
        
        if ( isdefined( var1 ) )
        {
            var4 = var1;
        }
        
        scripts\mp\utility\script::laststand_dogtags( "loadout_updateClassDefault() called on " + var3 + " with invalid class = " + var4 );
    }
    
    if ( !isagent( self ) && self calloutmarkerping_getent() && getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 )
    {
        zoomkey( var0 );
        loadout_updateclassaccessoryheadless( var0 );
    }
    else
    {
        zoneislocked( var0, var2 );
        loadout_updateclassaccessory( var0 );
    }
    
    var0.loadoutequipmentprimary = table_getequipmentprimary( level.classtablename, var2 );
    var0.loadoutextraequipmentprimary = table_getextraequipmentprimary( level.classtablename, var2 );
    var0.loadoutequipmentsecondary = table_getequipmentsecondary( level.classtablename, var2 );
    var0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary( level.classtablename, var2 );
    var0.loadoutgesture = table_getgesture( level.classtablename, var2 );
    var0.loadoutsuper = table_getsuper( level.classtablename, var2 );
    var0.loadoutusingspecialist = table_getspecialist( level.classtablename, var2 );
    var0.loadoutarchetype = cac_getcharacterarchetype();
    var0.loadoutkillstreak1 = cac_getkillstreak( 0, var1 );
    var0.loadoutkillstreak2 = cac_getkillstreak( 1, var1 );
    var0.loadoutkillstreak3 = cac_getkillstreak( 2, var1 );
    var0.loadoutrigtrait = cac_getloadoutarchetypeperk();
    
    if ( getdvarint( "scr_superForceLightTank", 0 ) )
    {
        var0.loadoutsuper = "super_bradley";
        return;
    }
}

// Params 2
// Size: 0xce
function zoneislocked( var0, var1 )
{
    var0.loadoutprimary = table_getweapon( level.classtablename, var1, 0 );
    
    for ( var2 = 0; var2 < 10 ; var2++ )
    {
        var0.loadoutprimaryattachments[ var2 ] = table_getweaponattachment( level.classtablename, var1, 0, var2 );
    }
    
    var0.loadoutprimarycamo = table_getweaponcamo( level.classtablename, var1, 0 );
    var0.loadoutprimaryreticle = table_getweaponreticle( level.classtablename, var1, 0 );
    var0.loadoutsecondary = table_getweapon( level.classtablename, var1, 1 );
    
    for ( var2 = 0; var2 < 10 ; var2++ )
    {
        var0.loadoutsecondaryattachments[ var2 ] = table_getweaponattachment( level.classtablename, var1, 1, var2 );
    }
    
    var0.loadoutsecondarycamo = table_getweaponcamo( level.classtablename, var1, 1 );
    var0.loadoutsecondaryreticle = table_getweaponreticle( level.classtablename, var1, 1 );
}

// Params 1
// Size: 0x145
function zoomkey( var0 )
{
    if ( !isdefined( self.showextractiontime ) )
    {
        if ( !isdefined( level.showextractiontime ) )
        {
            var1 = randomint( 200 );
            level.showextractiontime = var1;
            level.showhint = var1;
        }
        else
        {
            level.showextractiontime++;
            level.showhint++;
        }
        
        self.showextractiontime = level.showextractiontime;
        self.showhint = level.showhint;
    }
    
    var2 = zone_stompeenemyprogressupdate( self.showextractiontime, 1 );
    var3 = zone_stompeenemyprogressupdate( self.showhint, 0 );
    var4 = var2[ 0 ];
    var5 = var2[ 1 ];
    var6 = var3[ 0 ];
    var7 = var3[ 1 ];
    var0.loadoutprimary = var4;
    
    foreach ( var10, var9 in var5.attachcustomtoidmap )
    {
        var0.loadoutprimaryattachments[ var0.loadoutprimaryattachments.size ] = var10;
        var0.loadoutprimaryattachmentids[ var0.loadoutprimaryattachmentids.size ] = var9;
    }
    
    var0.loadoutprimaryvariantid = var5.variantid;
    var0.loadoutsecondary = var6;
    
    foreach ( var9 in var7.attachcustomtoidmap )
    {
        var0.loadoutsecondaryattachments[ var0.loadoutsecondaryattachments.size ] = var10;
        var0.loadoutsecondaryattachmentids[ var0.loadoutsecondaryattachmentids.size ] = var9;
    }
    
    var0.loadoutsecondaryvariantid = var7.variantid;
}

// Params 2
// Size: 0xb9
function zone_stompeenemyprogressupdate( var0, var1 )
{
    var2 = 0;
    var3 = -1;
    var4 = getdvarint( "scr_limit_headless_to_core", 1 );
    
    for ( ;; )
    {
        foreach ( var6 in level.weaponlootmapdata )
        {
            if ( var6.variantid == 0 || var6.update_focus_fire_objective || !isdefined( var6.attachcustomtoidmap ) )
            {
                continue;
            }
            
            if ( var4 && isdefined( var6.tut_bot_nameplate ) && !var6.tut_bot_nameplate )
            {
                continue;
            }
            
            var7 = strtok( var8, "|" )[ 0 ];
            
            if ( var1 != scripts\mp\utility\weapon::iscacprimaryweapon( var7 ) )
            {
                continue;
            }
            
            var3++;
            
            if ( var3 == var0 )
            {
                return [ var7, var6 ];
            }
        }
    }
}

// Params 1
// Size: 0x20
function loadout_updateclassaccessory( var0 )
{
    var1 = cac_getaccessoryweapon();
    var2 = cac_getaccessorydata();
    var3 = force_interrupt_all_current_combat_actions();
    loadout_updateclassaccessoryinternal( var0, var1, var2, var3 );
}

// Params 1
// Size: 0x81
function loadout_updateclassaccessoryheadless( var0 )
{
    var1 = getarraykeys( level.accessoryweaponbyindex );
    
    if ( !isdefined( self.Ø∏±|“ΩÔœ7Vä£XX:»®s ) )
    {
        if ( !isdefined( level.Ø∏±|“ΩÔœ7Vä£XX:»®s ) )
        {
            var2 = randomint( var1.size );
            level.Ø∏±|“ΩÔœ7Vä£XX:»®s = var2;
        }
        else
        {
            level.Ø∏±|“ΩÔœ7Vä£XX:»®s++;
            
            if ( level.Ø∏±|“ΩÔœ7Vä£XX:»®s >= var1.size )
            {
                level.Ø∏±|“ΩÔœ7Vä£XX:»®s = 0;
            }
        }
        
        self.Ø∏±|“ΩÔœ7Vä£XX:»®s = level.Ø∏±|“ΩÔœ7Vä£XX:»®s;
    }
    
    var3 = var1[ self.Ø∏±|“ΩÔœ7Vä£XX:»®s ];
    var4 = scripts\mp\accessories::getaccessoryweaponbyindex( var3 );
    var5 = scripts\mp\accessories::getaccessorydatabyindex( var3 );
    var6 = scripts\mp\accessories::register_respawn_functions( var3 );
    loadout_updateclassaccessoryinternal( var0, var4, var5, var6 );
}

// Params 4
// Size: 0xb1
function loadout_updateclassaccessoryinternal( var0, var1, var2, var3 )
{
    var4 = getdvarint( "scr_limit_accessories", -1 );
    
    if ( var4 >= 0 && isdefined( var1 ) )
    {
        if ( !isdefined( level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ ) )
        {
            level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ = [];
        }
        
        level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ = scripts\engine\utility::array_removeundefined( level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ );
        
        if ( level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ.size < var4 )
        {
            level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ[ level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ.size ] = var1;
        }
        else if ( scripts\engine\utility::array_contains( level.è??Ä∫ã(ÜsµËù˚Ì«õ˚ˇÅ, var1 ) )
        {
        }
        else
        {
            var0.loadoutaccessoryweapon = "none";
            var0.loadoutaccessorydata = "none";
            var0.loadoutaccessorylogic = "none";
            return;
        }
    }
    
    var0.loadoutaccessoryweapon = var1;
    var0.loadoutaccessorydata = var2;
    var0.loadoutaccessorylogic = var3;
}

// Params 1
// Size: 0x35
function loadout_updatestreaktype( var0 )
{
    if ( istrue( var0.loadoutusingspecialist ) )
    {
        self.streaktype = "streaktype_specialist";
    }
    else
    {
        self.streaktype = "streaktype_assault";
    }
    
    var0.loadoutstreaktype = self.streaktype;
}

// Params 2
// Size: 0x2fd
function loadout_updateabilities( var0, var1 )
{
    if ( !isdefined( self.pers[ "loadoutPerks" ] ) )
    {
        self.pers[ "loadoutPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutStandardPerks" ] ) )
    {
        self.pers[ "loadoutStandardPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutExtraPerks" ] ) )
    {
        self.pers[ "loadoutExtraPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutRigTrait" ] ) )
    {
        self.pers[ "loadoutRigTrait" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutUsingSpecialist" ] ) )
    {
        self.pers[ "loadoutUsingSpecialist" ] = 0;
    }
    
    var2 = getsubstr( var1, 0, 7 ) == "default";
    var3 = getsubstr( var1, 0, 14 ) == "custgamemode_d";
    
    if ( var0.loadoutperksfromgamemode )
    {
        var0.loadoutstandardperks = var0.loadoutperks;
        
        if ( var0.ref_1195e )
        {
            var0.loadoutextraperks = var0.loadoutextraperks;
            return;
        }
        
        return;
    }
    
    if ( !scripts\mp\utility\perk::perksenabled() )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        if ( isdefined( self.pers[ "loadoutPerks" ] ) )
        {
            var0.loadoutperks = self.pers[ "loadoutPerks" ];
            return;
        }
        
        return;
    }
    
    if ( var1 == "juggernaut" || var1 == "copied" )
    {
        return;
    }
    
    var4 = loadout_getclassteam( var1 );
    
    for ( var5 = 0; var5 < 3 ; var5++ )
    {
        var6 = "specialty_null";
        
        if ( var4 != "none" )
        {
            var7 = getclassindex( var1 );
            var6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var4, var7, "class", "loadoutPerks" );
        }
        else if ( var2 || var3 )
        {
            var7 = getclassindex( var1 );
            var6 = table_getperk( level.classtablename, var7, var5 );
        }
        else
        {
            var6 = cac_getloadoutperk( self.class_num, var5 );
        }
        
        if ( isdefined( var6 ) && var6 != "specialty_null" )
        {
            var0.loadoutperks[ var0.loadoutperks.size ] = var6;
            var0.loadoutstandardperks[ var0.loadoutstandardperks.size ] = var6;
        }
    }
    
    for ( var5 = 0; var5 < 3 ; var5++ )
    {
        var6 = "specialty_null";
        
        if ( var4 != "none" )
        {
            var7 = getclassindex( var1 );
            var6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var4, var7, "class", "extraPerks" );
        }
        else if ( var2 || var3 )
        {
            var7 = getclassindex( var1 );
            var6 = table_getextraperk( level.classtablename, var7, var5 );
        }
        else
        {
            var6 = cac_getloadoutextraperk( self.class_num, var5 );
        }
        
        if ( isdefined( var6 ) && var6 != "specialty_null" )
        {
            var0.loadoutextraperks[ var0.loadoutextraperks.size ] = var6;
        }
    }
    
    var6 = "specialty_null";
    
    if ( var4 != "none" )
    {
        var7 = getclassindex( var1 );
        var6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", var4, var7, "class", "archetypePerk" );
    }
    else
    {
        var6 = cac_getloadoutarchetypeperk();
    }
    
    if ( isdefined( var6 ) && var6 != "specialty_null" )
    {
        var0.loadoutperks[ var0.loadoutperks.size ] = var6;
        self.pers[ "loadoutRigTrait" ] = var6;
        var0.loadoutrigtrait = var6;
    }
    
    var7 = getclassindex( var1 );
}

// Params 1
// Size: 0xaa
function loadout_getclasstype( var0 )
{
    var1 = loadout_getclassteam( var0 );
    
    if ( var1 == "none" && !isdefined( var0 ) )
    {
        return "custom";
    }
    
    if ( var1 != "none" )
    {
        return "team";
    }
    
    if ( issubstr( var0, "custom" ) )
    {
        return "custom";
    }
    
    if ( var0 == "gamemode" )
    {
        return "gamemode";
    }
    
    if ( issubstr( var0, "custgamemode" ) )
    {
        return "custgamemode";
    }
    
    if ( var0 == "callback" )
    {
        return "callback";
    }
    
    if ( var0 == "juggernaut" )
    {
        return "juggernaut";
    }
    
    if ( var0 == "copied" )
    {
        return "copied";
    }
    
    return "default";
}

// Params 2
// Size: 0x74
function ref_1194e( var0, var1 )
{
    var2 = loadout_getclasstype( var1 );
    
    switch ( var2 )
    {
        case "team":
            break;
        case "custom":
            break;
        case "custgamemode":
            break;
        case "gamemode":
            ref_1194f( var0, var1 );
            break;
        case "callback":
            break;
        case "default":
            break;
        case "juggernaut":
            break;
    }
    
    return var0;
}

// Params 2
// Size: 0x16b
function loadout_updateclass( var0, var1 )
{
    if ( !isagent( self ) && self calloutmarkerping_getent() && getdvarint( "scr_forceHeadlessCustomization", 1 ) == 1 && scripts\mp\utility\game::getgametype() != "br" )
    {
        var1 = "default" + randomint( 5 ) + 1;
    }
    
    var2 = loadout_getclasstype( var1 );
    
    switch ( var2 )
    {
        case "team":
            loadout_updateclassteam( var0, var1 );
            break;
        case "custom":
            loadout_updateclasscustom( var0, var1 );
            break;
        case "gamemode":
            loadout_updateclassgamemode( var0, var1 );
            break;
        case "custgamemode":
            zone_get_node_nearest_2d_bounds( var0, var1 );
            break;
        case "callback":
            loadout_updateclasscallback( var0 );
            break;
        case "default":
            loadout_updateclassdefault( var0, var1 );
            break;
        case "juggernaut":
            break;
        case "copied":
            break;
    }
    
    if ( !istrue( game[ "isLaunchChunk" ] ) )
    {
        self.pers[ "defaultOperatorSkinIndex" ] = scripts\mp\teams::pickdefaultoperatorskin( var0.loadoutprimary );
    }
    
    loadout_updatehasnvg( var0 );
    loadout_updateclassfistweapons( var0 );
    loadout_updatestreaktype( var0 );
    loadout_updateabilities( var0, var1 );
    var0 = loadout_validateclass( var0, var1 );
    
    if ( !isbot( self ) && isdefined( level.set_systems_init_flag ) && level.set_systems_init_flag )
    {
        zvelscale( var0 );
    }
    else
    {
        loadout_updateclassfinalweapons( var0 );
    }
    
    if ( isdefined( level.ref_11c88 ) )
    {
        self [[ level.ref_11c88 ]]( var0 );
    }
    
    return var0;
}

// Params 1
// Size: 0xe2
function loadout_updateclassfistweapons( var0 )
{
    if ( isdefined( level.set_systems_init_flag ) && level.set_systems_init_flag && issameweapon( var0.loadoutprimary ) )
    {
        var0.loadoutprimary = var0.loadoutprimary;
    }
    else if ( var0.loadoutprimary == "none" )
    {
        var0.loadoutprimary = "iw8_fists";
    }
    
    if ( scripts\mp\utility\game::handle_carry_special_item() )
    {
        if ( var0.loadoutsecondary == "none" )
        {
            var0.loadoutsecondary = "none";
            return;
        }
        
        return;
    }
    
    if ( var0.loadoutsecondary == "none" && var0.loadoutprimary != "iw8_fists" && !istrue( self.isjuggernaut ) )
    {
        var0.loadoutsecondary = "iw8_fists";
        return;
    }
    
    if ( var0.loadoutprimary == "iw8_fists" && var0.loadoutsecondary == "iw8_fists" )
    {
        var0.loadoutsecondary = "none";
        return;
    }
}

// Params 1
// Size: 0x16
function loadout_updatehasnvg( var0 )
{
    if ( scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        var0.loadouthasnvg = 1;
        return;
    }
}

// Params 2
// Size: 0x32
function loadout_validateclass( var0, var1 )
{
    var2 = scripts\mp\utility\game::isanymlgmatch() && issubstr( var1, "default" );
    
    if ( issubstr( var1, "custom" ) || var2 )
    {
        return scripts\mp\validation::validateloadout( var0 );
    }
    
    return var0;
}

// Params 1
// Size: 0x90
function loadout_forcearchetype( var0 )
{
    var1 = getdvarint( "forceArchetype", 0 );
    
    if ( var1 > 0 )
    {
        var2 = getdvarint( "forceArchetype", 0 );
        
        switch ( var2 )
        {
            case 1:
                var0.loadoutarchetype = "archetype_assault";
                break;
            default:
                var0.loadoutarchetype = "archetype_assault";
                break;
        }
        
        return;
    }
    
    if ( var1 == -1 )
    {
        var3 = [ "archetype_assault" ];
        var4 = randomint( var3.size );
        var0.loadoutarchetype = var3[ var4 ];
        self iprintlnbold( "Random Archetype: " + var3[ var4 ] );
        return;
    }
}

// Params 1
// Size: 0x172
function loadout_updateplayerarchetype( var0 )
{
    if ( !istrue( self.btestclient ) )
    {
        if ( !isdefined( level.aonrules ) || level.aonrules == 0 )
        {
        }
    }
    
    self.loadoutarchetype = var0.loadoutarchetype;
    scripts\mp\weapons::updatemovespeedscale();
    var1 = 1;
    var2 = 2;
    var3 = 4;
    var4 = 8;
    var5 = 0;
    var6 = undefined;
    var7 = undefined;
    var8 = 400;
    var9 = 400;
    var10 = 900;
    
    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        var9 = 133.333;
        var10 = 1800;
    }
    
    switch ( self.loadoutarchetype )
    {
        case "archetype_assault":
            var5 = var1 | var2 | var3;
            var6 = &scripts\mp\archetypes\archassault::applyarchetype;
            var7 = "vestlight";
            self.clothtype = var7;
            break;
        default:
            if ( !istrue( self.btestclient ) )
            {
                if ( !isdefined( level.aonrules ) || level.aonrules == 0 )
                {
                }
            }
            
            break;
    }
    
    self setcamerathirdperson( 0 );
    
    if ( getdvarint( "debug_iw7_backwards_compat" ) )
    {
        self allowdoublejump( var5 & var1 );
        self allowwallrun( var5 & var3 );
        self allowdodge( var5 & var4 );
    }
    else
    {
        self allowdoublejump( 0 );
        self allowwallrun( 0 );
        self allowdodge( 0 );
    }
    
    self allowslide( var5 & var2 );
    self allowlean( 0 );
    self energy_setmax( 0, var8 );
    self energy_setenergy( 0, var8 );
    self energy_setrestorerate( 0, var9 );
    self energy_setresttimems( 0, var10 );
    self energy_setmax( 1, 50 );
    self energy_setenergy( 1, 50 );
    self energy_setrestorerate( 1, 10 );
    self energy_setresttimems( 1, scripts\engine\utility::ter_op( scripts\mp\utility\game::isanymlgmatch(), 2500, 0 ) );
    
    if ( isdefined( var6 ) )
    {
        self [[ var6 ]]();
    }
}

// Params 1
// Size: 0x1ce
function loadout_updateclassfinalweapons( var0 )
{
    if ( istrue( var0.ref_11960 ) )
    {
        var0.loadoutprimaryobject = fixsuperforbr( var0.loadoutprimary, var0.loadoutprimaryattachments, var0.loadoutprimarycamo, var0.loadoutprimaryreticle, var0.loadoutprimaryvariantid, var0.loadoutprimaryattachmentids, var0.loadoutprimarycosmeticattachment, var0.loadoutprimarystickers, istrue( var0.loadouthasnvg ) );
    }
    else
    {
        var0.loadoutprimaryobject = buildweapon( var0.loadoutprimary, var0.loadoutprimaryattachments, var0.loadoutprimarycamo, var0.loadoutprimaryreticle, var0.loadoutprimaryvariantid, var0.loadoutprimaryattachmentids, var0.loadoutprimarycosmeticattachment, var0.loadoutprimarystickers, istrue( var0.loadouthasnvg ) );
    }
    
    var0.loadoutprimaryfullname = createheadicon( var0.loadoutprimaryobject );
    
    if ( var0.loadoutsecondary == "none" )
    {
        var0.loadoutsecondaryfullname = "none";
        var0.loadoutsecondaryobject = undefined;
    }
    else
    {
        if ( istrue( var0.ref_11961 ) )
        {
            var0.loadoutsecondaryobject = fixsuperforbr( var0.loadoutsecondary, var0.loadoutsecondaryattachments, var0.loadoutsecondarycamo, var0.loadoutsecondaryreticle, var0.loadoutsecondaryvariantid, var0.loadoutsecondaryattachmentids, var0.loadoutsecondarycosmeticattachment, var0.loadoutsecondarystickers, istrue( var0.loadouthasnvg ) );
        }
        else
        {
            var0.loadoutsecondaryobject = buildweapon( var0.loadoutsecondary, var0.loadoutsecondaryattachments, var0.loadoutsecondarycamo, var0.loadoutsecondaryreticle, var0.loadoutsecondaryvariantid, var0.loadoutsecondaryattachmentids, var0.loadoutsecondarycosmeticattachment, var0.loadoutsecondarystickers, istrue( var0.loadouthasnvg ) );
        }
        
        var0.loadoutsecondaryfullname = createheadicon( var0.loadoutsecondaryobject );
    }
    
    if ( var0.loadoutmeleeslot != "none" )
    {
        self giveweapon( var0.loadoutmeleeslot );
        self assignweaponmeleeslot( var0.loadoutmeleeslot );
        return;
    }
}

// Params 4
// Size: 0xe2
function loadout_updateplayerweapons( var0, var1, var2, var3 )
{
    var4 = respawnitems_getrespawnitems();
    var5 = respawnitems_hasweapondata( var4 );
    var6 = level.magcount;
    var7 = loadout_giveprimaryweapon( var0, var4, var5 );
    var8 = loadout_givesecondaryweapon( var0, var4, var5 );
    zombievehiclelaststand( var0, var7, var8, var4, var5, var6 );
    self.loadoutmeleeslot = var0.loadoutmeleeslot;
    
    if ( !isdefined( var7 ) )
    {
        scripts\mp\utility\script::laststand_dogtags( var0.loadoutprimary );
    }
    
    if ( isdefined( var7 ) && self hasweapon( var7 ) )
    {
        var9 = var7;
    }
    else
    {
        var9 = var9;
    }
    
    if ( isdefined( var9 ) && var9.basename != "none" && isdefined( var8 ) && var8.basename == "iw8_fists_mp" )
    {
        var9 = var9;
    }
    
    if ( !isai( self ) )
    {
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var9 );
    }
    
    if ( !isdefined( var3 ) || var3 )
    {
        var4 = shouldskipfirstraise( var9, var4 );
        
        if ( !isagent( self ) )
        {
            self setspawnweapon( var9, !var4 );
        }
    }
    
    self.spawnweaponobj = var9;
    ref_11951();
}

// Params 0
// Size: 0x51
function zombierespawning()
{
    if ( isdefined( self.primaryweaponobj ) && !self hasweapon( self.primaryweaponobj ) )
    {
        loadout_giveprimaryweapon( self.classstruct );
        thread ref_13c58();
    }
    
    if ( isdefined( self.secondaryweaponobj ) && !self hasweapon( self.secondaryweaponobj ) )
    {
        loadout_givesecondaryweapon( self.classstruct );
        thread ref_13c58();
        return;
    }
}

// Params 3
// Size: 0x9c
function loadout_giveprimaryweapon( var0, var1, var2 )
{
    self.loadoutprimary = var0.loadoutprimary;
    self.loadoutprimarycamo = var0.loadoutprimarycamo;
    self.loadoutprimaryattachments = var0.loadoutprimaryattachments;
    self.loadoutprimaryattachmentids = var0.loadoutprimaryattachmentids;
    self.loadoutprimaryreticle = var0.loadoutprimaryreticle;
    self.loadoutprimarylootitemid = var0.loadoutprimarylootitemid;
    self.loadoutprimaryvariantid = var0.loadoutprimaryvariantid;
    var3 = zombiespawninair( "primary", var0.loadoutprimaryobject, var1, var2 );
    self.primaryweapon = var0.loadoutprimaryfullname;
    self.primaryweaponobj = var0.loadoutprimaryobject;
    self.pers[ "primaryWeapon" ] = var0.loadoutprimaryfullname;
    return var3;
}

// Params 3
// Size: 0x9c
function loadout_givesecondaryweapon( var0, var1, var2 )
{
    self.loadoutsecondary = var0.loadoutsecondary;
    self.loadoutsecondarycamo = var0.loadoutsecondarycamo;
    self.loadoutsecondaryattachments = var0.loadoutsecondaryattachments;
    self.loadoutsecondaryattachmentids = var0.loadoutsecondaryattachmentids;
    self.loadoutsecondaryreticle = var0.loadoutsecondaryreticle;
    self.loadoutsecondarylootitemid = var0.loadoutsecondarylootitemid;
    self.loadoutsecondaryvariantid = var0.loadoutsecondaryvariantid;
    var3 = zombiespawninair( "secondary", var0.loadoutsecondaryobject, var1, var2 );
    self.secondaryweapon = var0.loadoutsecondaryfullname;
    self.secondaryweaponobj = var0.loadoutsecondaryobject;
    self.pers[ "secondaryWeapon" ] = var0.loadoutsecondaryfullname;
    return var3;
}

// Params 4
// Size: 0x76
function zombiespawninair( var0, var1, var2, var3 )
{
    var4 = undefined;
    
    if ( !istrue( var3 ) )
    {
        var4 = var1;
    }
    else
    {
        var4 = respawnitems_getweaponobj( var2, var0 );
    }
    
    if ( !getqueuedspleveltransients( var4 ) )
    {
        if ( scripts\mp\riotshield::isriotshield( var4 ) && !scripts\mp\flags::gameflag( "prematch_done" ) && isdefined( self.infil ) && !istrue( self.stopchallengetimers ) )
        {
        }
        else
        {
            var4 = scripts\mp\weapons::updatesavedaltstate( var4 );
            scripts\cp_mp\utility\inventory_utility::_giveweapon( var4, undefined, undefined, 1 );
            scripts\mp\weapons::updatetogglescopestate( var4 );
            scripts\mp\perks\weaponpassives::loadoutweapongiven( var4 );
        }
    }
    
    return var4;
}

// Params 6
// Size: 0x1fc
function zombievehiclelaststand( var0, var1, var2, var3, var4, var5 )
{
    var6 = [];
    
    if ( isdefined( var0.loadoutprimaryobject ) && var0.loadoutprimaryobject.basename != "none" )
    {
        GscBinSkip0( 0x2e, var6.size, var0.loadoutprimaryobject );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( isdefined( var0.loadoutsecondaryobject ) && var0.loadoutsecondaryobject.basename != "none" )
    {
        GscBinSkip0( 0x2e, var6.size, var0.loadoutsecondaryobject );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    foreach ( var8 in var6 )
    {
        var8.should_spawn_boss_one = var8 hasattachment( "maxammo", 1 );
    }
    
    if ( isdefined( level.ref_11c73 ) )
    {
        self [[ level.ref_11c73 ]]( var6 );
    }
    else if ( istrue( var4 ) )
    {
        respawnitems_giveweaponammo( var3, "primary" );
        respawnitems_giveweaponammo( var3, "secondary" );
    }
    else if ( var5 != 3 )
    {
        if ( isdefined( var1 ) )
        {
            spawnammocountoverride_giveweaponammo( var1, "primary", var5 );
        }
        
        if ( isdefined( var2 ) )
        {
            spawnammocountoverride_giveweaponammo( var2, "secondary", var5 );
        }
    }
    else
    {
        foreach ( var8 in var6 )
        {
            if ( istrue( var8.should_spawn_boss_one ) )
            {
                var11 = weaponmaxammo( var8 ) - weaponstartammo( var8 );
                var12 = self getweaponammostock( var8 );
                self setweaponammostock( var8, var12 + var11 );
            }
        }
    }
    
    if ( !istrue( var4 ) && var5 == 3 )
    {
        foreach ( var8 in var6 )
        {
            if ( istrue( var8.hasalternate ) )
            {
                var15 = var8 getaltweapon();
                var16 = weaponclass( var15 );
                
                if ( var16 == "grenade" && istrue( var8.should_spawn_boss_one ) )
                {
                    self setweaponammostock( var15, 1 );
                }
                else if ( var16 == "spread" )
                {
                    self setweaponammoclip( var15, scripts\engine\utility::ter_op( istrue( var8.should_spawn_boss_one ), 8, 6 ) );
                }
                
                continue;
            }
            
            if ( scripts\mp\utility\weapon::turnexfiltoside( var8 ) )
            {
                self setweaponammostock( var8, self getweaponammostock( var8 ) + weaponclipsize( var8 ) * 3 );
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x7
function ref_11951()
{
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 1
// Size: 0x124
function loadout_updateplayerperks( var0 )
{
    loadout_giveperk( "specialty_selectivehearing" );
    
    if ( scripts\mp\utility\game::islaststandenabled() )
    {
        scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
    }
    
    loadout_giveperk( "specialty_location_marking" );
    
    if ( scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        loadout_giveperk( "specialty_tracker_jammer" );
    }
    
    if ( var0.loadoutstandardperks.size > 0 )
    {
        var1 = getdvarint( "scr_loadoutPerksOff", 0 ) == 0;
        
        if ( var1 )
        {
            scripts\mp\perks\perks::giveperks( var0.loadoutperks, 0 );
        }
    }
    
    self.pers[ "loadoutPerks" ] = var0.loadoutperks;
    self.pers[ "loadoutStandardPerks" ] = var0.loadoutstandardperks;
    self.pers[ "loadoutExtraPerks" ] = var0.loadoutextraperks;
    self.pers[ "loadoutRigTrait" ] = var0.loadoutrigtrait;
    self.pers[ "loadoutUsingSpecialist" ] = var0.loadoutusingspecialist;
    
    if ( isdefined( self.avoidkillstreakonspawntimer ) && self.avoidkillstreakonspawntimer > 0 )
    {
        thread scripts\mp\perks\perks::giveperksafterspawn();
    }
    
    if ( !isagent( self ) && scripts\mp\utility\dvars::getintproperty( "scr_showperksonspawn", 1 ) == 1 && game[ "state" ] != "postgame" )
    {
        scripts\mp\perks\perks::setomnvarsforperklist( "ui_spawn_perk_", self.pers[ "loadoutPerks" ] );
    }
}

// Params 1
// Size: 0xb1
function loadout_updateplayerequipment( var0 )
{
    var1 = respawnitems_getrespawnitems();
    var2 = respawnitems_hasequipmentdata( var1 );
    self.loadoutequipmentprimary = var0.loadoutequipmentprimary;
    self.loadoutequipmentsecondary = var0.loadoutequipmentsecondary;
    var3 = undefined;
    
    if ( !var2 )
    {
        var3 = var0.loadoutequipmentprimary;
    }
    else
    {
        var3 = respawnitems_getequipmentref( var1, "primary" );
    }
    
    var4 = undefined;
    
    if ( !var2 )
    {
        var4 = var0.loadoutequipmentsecondary;
    }
    else
    {
        var4 = respawnitems_getequipmentref( var1, "secondary" );
    }
    
    scripts\mp\equipment::giveequipment( var3, "primary" );
    scripts\mp\equipment::giveequipment( var4, "secondary" );
    
    if ( var2 )
    {
        respawnitems_giveequipmentammo( var1, "primary" );
        respawnitems_giveequipmentammo( var1, "secondary" );
    }
    
    if ( scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        thread scripts\mp\equipment\nvg::runnvg();
        thread loadout_updateplayernvgs();
    }
}

// Params 0
// Size: 0x9f
function loadout_updateplayernvgs()
{
    self endon( "death_or_disconnect" );
    self notify( "loadout_updatePlayerNVGs" );
    self endon( "loadout_updatePlayerNVGs" );
    var0 = 0;
    
    if ( game[ "roundsPlayed" ] == 0 && !istrue( self.hasspawned ) )
    {
        if ( !scripts\mp\flags::gameflag( "infil_will_run" ) || scripts\mp\flags::gameflag( "infil_started" ) )
        {
            var0 = 1;
        }
    }
    else if ( istrue( self.pers[ "useNVG" ] ) )
    {
        var0 = 1;
    }
    
    if ( istrue( self.inspawncamera ) )
    {
        scripts\engine\utility::ref_143a5( "spawned_player", "fadeUp_start" );
    }
    
    while ( !isdefined( self.operatorcustomization ) )
    {
        waitframe();
    }
    
    if ( var0 )
    {
        self nightvisionviewon( 1 );
    }
    
    scripts\mp\equipment\nvg::nvg_update3rdperson( var0 );
}

// Params 1
// Size: 0x144
function loadout_updateplayersuper( var0 )
{
    var1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();
    
    if ( !var1 && var0.loadoutsuper == "super_bradley" )
    {
        var0.loadoutsuper = "super_pac_sentry";
    }
    
    var2 = var0.loadoutsuper;
    var3 = respawnitems_getrespawnitems();
    var4 = respawnitems_hassuperdata( var3 );
    
    if ( var4 )
    {
        var2 = respawnitems_getsuperref( var3 );
    }
    
    if ( isdefined( scripts\mp\supers::getcurrentsuper() ) )
    {
        var5 = scripts\mp\supers::getcurrentsuperref();
        
        if ( var5 == var2 && !haschangedarchetype() )
        {
            scripts\mp\supers::givesuperweapon( self.super );
            return;
        }
    }
    
    if ( var2 == "none" || !level.allowsupers )
    {
        scripts\mp\supers::clearsuper();
        self.loadoutsuper = undefined;
        return;
    }
    
    if ( level.allowsupers && isdefined( self.pers[ "gamemodeLoadout" ] ) && isdefined( self.pers[ "gamemodeLoadout" ][ "loadoutSuper" ] ) )
    {
        self.loadoutsuper = self.pers[ "gamemodeLoadout" ][ "loadoutSuper" ];
        scripts\mp\supers::givesuper( self.loadoutsuper, 1 );
        return;
    }
    
    if ( var2 == "super_bradley" && !scripts\cp_mp\vehicles\light_tank::light_tank_supported() )
    {
        scripts\mp\supers::clearsuper();
        self.loadoutsuper = undefined;
        return;
    }
    
    self.loadoutsuper = var0.loadoutsuper;
    scripts\mp\supers::givesuper( var2, 1 );
    
    if ( var4 )
    {
        scripts\mp\supers::setsuperbasepoints( respawnitems_getsuperpoints( var3 ) );
        scripts\mp\supers::setsuperextrapoints( respawnitems_getsuperextrapoints( var3 ) );
    }
}

// Params 1
// Size: 0x36
function loadout_updateplayergesture( var0 )
{
    if ( !istrue( self.btestclient ) )
    {
        if ( var0.loadoutgesture != "none" )
        {
            self.loadoutgesture = var0.loadoutgesture;
            scripts\cp_mp\gestures::givegesture( var0.loadoutgesture );
        }
    }
}

// Params 1
// Size: 0x43, Type: bool
function zombiethermalon( var0 )
{
    var1 = getdvarint( "scr_t9_watch_suppression", 0 );
    
    if ( var1 && isdefined( var0.loadoutaccessorydata ) )
    {
        var2 = scripts\mp\accessories::register_script_model_animation( var0.loadoutaccessorydata );
        
        if ( isdefined( var2 ) && var2 == "t9" )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0x67
function loadout_updateplayeraccessory( var0 )
{
    if ( !istrue( self.btestclient ) )
    {
        if ( isdefined( var0.loadoutaccessoryweapon ) && var0.loadoutaccessoryweapon != "none" )
        {
            if ( zombiethermalon( var0 ) )
            {
                return;
            }
            
            self.loadoutaccessorydata = var0.loadoutaccessorydata;
            self.loadoutaccessoryweapon = var0.loadoutaccessoryweapon;
            scripts\mp\accessories::giveplayeraccessory( var0.loadoutaccessorydata, var0.loadoutaccessoryweapon, var0.loadoutaccessorylogic );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x15
function loadout_updateplayerstreaktype( var0 )
{
    self.streaktype = loadout_getplayerstreaktype( var0.loadoutstreaktype );
}

// Params 2
// Size: 0x435
function loadout_updateplayerkillstreaks( var0, var1 )
{
    if ( !level.allowkillstreaks )
    {
        var0.loadoutkillstreak1 = "none";
        var0.loadoutkillstreak2 = "none";
        var0.loadoutkillstreak3 = "none";
    }
    
    if ( var0.loadoutstreaksfilled == 0 && isdefined( self.streakdata ) && self.streakdata.streaks.size > 0 && var1 == "gamemode" )
    {
        var2 = 0;
        
        foreach ( var4 in self.streakdata.streaks )
        {
            if ( var2 == 0 )
            {
                var0.loadoutkillstreak1 = var4;
                var2++;
                continue;
            }
            
            if ( var2 == 1 )
            {
                var0.loadoutkillstreak2 = var4;
                var2++;
                continue;
            }
            
            if ( var2 == 2 )
            {
                var0.loadoutkillstreak3 = var4;
                break;
            }
        }
    }
    
    if ( scripts\mp\utility\game::usefloorrocks() )
    {
        var2 = 0;
        var6 = getdvar( "scr_game_classtable_streak_override", "uav,precision_airstrike,directional_uav" );
        
        if ( var6 != "" )
        {
            var6 = strtok( var6, "," );
            
            foreach ( var4 in var6 )
            {
                if ( var2 == 0 )
                {
                    var0.loadoutkillstreak1 = var6[ 0 ];
                    var2++;
                    continue;
                }
                
                if ( var2 == 1 )
                {
                    var0.loadoutkillstreak2 = var6[ 1 ];
                    var2++;
                    continue;
                }
                
                if ( var2 == 2 )
                {
                    var0.loadoutkillstreak3 = var6[ 2 ];
                    break;
                }
            }
        }
    }
    
    if ( level.allowkillstreaks && getdvar( "scr_restrict_killstreaks", "" ) != "" )
    {
        var9 = [];
        
        if ( getdvar( "scr_template_killstreaks", "" ) != "" )
        {
            var9 = strtok( getdvar( "scr_template_killstreaks", "" ), " " );
            
            for ( var10 = 0; var10 < 3 ; var10++ )
            {
                if ( var10 < var9.size )
                {
                    var11 = var9[ var10 ];
                    
                    if ( !isdefined( level.killstreaksetups[ var11 ] ) )
                    {
                        var9 = "none";
                    }
                    
                    continue;
                }
                
                var9 = "none";
            }
        }
        else
        {
            GscBinSkip0( 0x2e, 0, "toma_strike" );
            // Unknown operator ( 0x2e, iw8, PC )
        }
        
        var12 = strtok( getdvar( "scr_restrict_killstreaks", "" ), " " );
        
        foreach ( var14 in var12 )
        {
            if ( var0.loadoutkillstreak1 == var14 )
            {
                var0.loadoutkillstreak1 = var9[ 0 ];
                continue;
            }
            
            if ( var0.loadoutkillstreak2 == var14 )
            {
                var0.loadoutkillstreak2 = var9[ 1 ];
                continue;
            }
            
            if ( var0.loadoutkillstreak3 == var14 )
            {
                var0.loadoutkillstreak3 = var9[ 2 ];
            }
        }
    }
    
    var16 = [ var0.loadoutkillstreak1, var0.loadoutkillstreak2, var0.loadoutkillstreak3 ];
    
    if ( level.allowkillstreaks )
    {
        self.pers[ "hackedStreaks" ] = 0;
        var16 = replacetankwithwheelson( var0 );
    }
    
    self.loadoutusingspecialist = var0.loadoutusingspecialist;
    self getfollowedplayer( self.loadoutusingspecialist );
    
    if ( var0.loadoutusingspecialist && level.allowkillstreaks )
    {
        var16 = replacewithspecialistkillstreaks( var0 );
    }
    
    var17 = respawnitems_getrespawnitems();
    var18 = respawnitems_hasstreakdata( var17 );
    
    if ( var18 && level.allowkillstreaks )
    {
        var16 = respawnitems_getstreaks( var17 );
    }
    
    if ( level.allowkillstreaks )
    {
        var16 = sortkillstreaksbycost( var16 );
    }
    
    if ( !isagent( self ) )
    {
        var19 = scripts\mp\killstreaks\killstreaks::arekillstreaksequipped( var16 );
        
        if ( !var19 )
        {
            self notify( "givingLoadout" );
            var20 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();
            var21 = scripts\mp\killstreaks\killstreaks::getavailableequippedkillstreakstructs();
            
            if ( !scripts\mp\utility\perk::_hasperk( "specialty_support_killstreaks" ) && !isdefined( self.earnedmaxkillstreak ) )
            {
                scripts\mp\killstreaks\killstreaks::clearkillstreaks();
            }
            
            for ( var22 = 0; var22 < var16.size ; var22++ )
            {
                var23 = var16[ var22 ];
                
                if ( isdefined( var23 ) && var23 != "none" && var23 != "" )
                {
                    scripts\mp\killstreaks\killstreaks::equipkillstreak( var23, var22 + 1 );
                }
            }
            
            for ( var24 = var20.size - 1; var24 >= 0 ; var24-- )
            {
                var23 = var20[ var24 ];
                
                if ( !var23.isspecialist )
                {
                    scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct( var20[ var24 ], "other" );
                }
            }
            
            for ( var24 = 0; var24 < var21.size ; var24++ )
            {
                var23 = var21[ var24 ];
                
                if ( !var23.isspecialist )
                {
                    scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct( var21[ var24 ], "other" );
                }
            }
        }
    }
    
    self notify( "equipKillstreaksFinished" );
}

// Params 1
// Size: 0x9b
function sortkillstreaksbycost( var0 )
{
    for ( var1 = 0; var1 < var0.size - 1 ; var1++ )
    {
        if ( isdefined( var0[ var1 ] ) && var0[ var1 ] != "none" && var0[ var1 ] != "" )
        {
            for ( var2 = var1 + 1; var2 < var0.size ; var2++ )
            {
                if ( isdefined( var0[ var2 ] ) && var0[ var2 ] != "none" && var0[ var2 ] != "" )
                {
                    var3 = scripts\mp\killstreaks\killstreaks::calcstreakcost( var0[ var1 ] );
                    var4 = scripts\mp\killstreaks\killstreaks::calcstreakcost( var0[ var2 ] );
                    
                    if ( var4 < var3 )
                    {
                        var5 = var0[ var2 ];
                        var0 = var0[ var1 ];
                        var0 = var5;
                    }
                }
            }
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x11
function loadout_updateplayeractionslots( var0, var1 )
{
    self setactionslot( 3, "altmode" );
}

// Params 2
// Size: 0x172
function loadout_updatefieldupgrades( var0, var1 )
{
    if ( var1 == "juggernaut" )
    {
        return;
    }
    
    self.loadoutfieldupgrade1 = var0.loadoutfieldupgrade1;
    self.loadoutfieldupgrade2 = var0.loadoutfieldupgrade2;
    
    if ( setgamebattleplayerstats( self.loadoutfieldupgrade1 ) )
    {
        self.loadoutfieldupgrade1 = "super_deadsilence";
    }
    
    if ( setgamebattleplayerstats( self.loadoutfieldupgrade2 ) )
    {
        self.loadoutfieldupgrade2 = "super_deadsilence";
    }
    
    if ( scripts\mp\utility\game::isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2 )
    {
        self.loadoutfieldupgrade2 = "none";
    }
    
    if ( level.allowsupers )
    {
        var2 = scripts\cp_mp\utility\game_utility::getmapname();
        
        if ( issubstr( var2, "mp_m_" ) && var2 != "mp_m_speed" )
        {
            self.loadoutfieldupgrade1 = player_give_killstreak( self.loadoutfieldupgrade1 );
            self.loadoutfieldupgrade2 = player_give_killstreak( self.loadoutfieldupgrade2 );
            
            if ( self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2 )
            {
                self.loadoutfieldupgrade2 = "none";
            }
        }
        
        thread scripts\mp\supers::watchplayersuperdelayweapon();
        thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();
        
        if ( scripts\mp\utility\game::getgametype() == "br" )
        {
            var3 = player_get_carepackage_sentry( self.loadoutfieldupgrade1 );
            
            if ( isdefined( level.forcegivesuper ) )
            {
                self [[ level.forcegivesuper ]]( var3 );
                return;
            }
            
            return;
        }
        
        return;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self.ref_11954 = player_get_carepackage_sentry( self.loadoutfieldupgrade1 );
        
        if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            if ( isdefined( level.forcegivesuper ) )
            {
                self [[ level.forcegivesuper ]]( "super_ammo_drop" );
            }
        }
        
        self.loadoutfieldupgrade1 = "none";
        self.loadoutfieldupgrade2 = "none";
        
        if ( getdvarint( "scr_disablePerks", 0 ) == 0 )
        {
            scripts\mp\perks\perkpackage::perkpackage_initpersdata();
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x1c
function player_get_carepackage_sentry( var0 )
{
    if ( !isdefined( var0 ) || var0 == "none" )
    {
        return "super_ammo_drop";
    }
    
    return var0;
}

// Params 1
// Size: 0x3b
function player_give_killstreak( var0 )
{
    switch ( var0 )
    {
        case "super_weapon_drop":
        case "super_emp_drone":
        case "super_recon_drone":
            var0 = "super_ammo_drop";
            break;
        default:
            break;
    }
    
    return var0;
}

// Params 5
// Size: 0x131
function loadout_updateplayer( var0, var1, var2, var3, var4 )
{
    loadout_updateplayerstreaktype( var1 );
    loadout_updateplayerarchetype( var1 );
    
    if ( !istrue( level.noweaponsonstart ) )
    {
        loadout_updateplayerweapons( var1, var2, var3, var4 );
    }
    
    loadout_updateplayerperks( var1 );
    
    if ( !istrue( level.noweaponsonstart ) )
    {
        loadout_updateplayerequipment( var1 );
    }
    
    if ( !istrue( game[ "isLaunchChunk" ] ) && scripts\mp\utility\game::getgametype() != "br" )
    {
        loadout_updateplayerkillstreaks( var1, var2 );
    }
    
    loadout_updateplayeractionslots( var1, var2 );
    
    if ( !istrue( game[ "isLaunchChunk" ] ) )
    {
        loadout_updatefieldupgrades( var0, var2 );
    }
    
    self.pers[ "lastClass" ] = self.class;
    self.lastclass = self.class;
    self.lastarchetypeinfo = self.changedarchetypeinfo;
    
    if ( isdefined( self.gamemode_chosenclass ) )
    {
        self.pers[ "class" ] = self.gamemode_chosenclass;
        self.pers[ "lastClass" ] = self.gamemode_chosenclass;
        self.class = self.gamemode_chosenclass;
        self.lastclass = self.gamemode_chosenclass;
        self.gamemode_chosenclass = undefined;
    }
    
    if ( isdefined( self.revive_chosenclass ) )
    {
        self.pers[ "class" ] = self.revive_chosenclass;
        self.pers[ "lastClass" ] = self.revive_chosenclass;
        self.class = self.revive_chosenclass;
        self.lastclass = self.revive_chosenclass;
    }
    
    scripts\mp\teams::setupplayermodel();
    loadout_updateplayeraccessory( var1 );
}

// Params 2
// Size: 0x225
function setmlgspectatorclientloadoutdata( var0, var1 )
{
    if ( isagent( var0 ) )
    {
        return;
    }
    
    var0 endon( "disconnect" );
    var0 notify( "setMLGSpectatorClientLoadoutData()" );
    var0 endon( "setMLGSpectatorClientLoadoutData()" );
    var0 updatemlgammoinfo();
    var0 disableplayeruseforallplayers( level.laststand );
    var0 setclientweaponinfo( 0, var1.loadoutprimaryfullname );
    var0 setclientweaponinfo( 1, var1.loadoutsecondaryfullname );
    
    if ( isdefined( self.equipment[ "primary" ] ) )
    {
        var2 = scripts\mp\equipment::getequipmenttableinfo( self.equipment[ "primary" ] );
        var0 setclientloadoutinfo( "primaryPower", var2.id );
    }
    
    if ( isdefined( self.equipment[ "secondary" ] ) )
    {
        var3 = scripts\mp\equipment::getequipmenttableinfo( self.equipment[ "secondary" ] );
        var0 setclientloadoutinfo( "secondaryPower", var3.id );
    }
    
    if ( scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata() )
    {
        var4 = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue( var0, "damageDone" );
        scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue( var0, "damageDone", var4 );
    }
    
    if ( isdefined( self.loadoutfieldupgrade1 ) )
    {
        var0 setclientloadoutinfo( "fieldUpgrade", scripts\mp\supers::getsuperid( self.loadoutfieldupgrade1 ) );
    }
    
    var5 = scripts\mp\supers::getsuperid( var1.loadoutsuper );
    var0 setclientloadoutinfo( "super", var5 );
    
    if ( isai( var0 ) )
    {
        for ( var6 = 0; var6 < var1.loadoutperks.size ; var6++ )
        {
            var7 = var1.loadoutperks[ var6 ];
            var8 = scripts\mp\perks\perks::getperkid( var7 );
            var0 setclientloadoutinfo( var6 + 1 + "_perk", var8 );
        }
    }
    else
    {
        if ( var7.loadoutperksfromgamemode )
        {
            var7.loadoutstandardperks = var7.loadoutperks;
        }
        
        for ( var6 = 0; var6 < self.pers[ "loadoutPerks" ].size ; var6++ )
        {
            var7 = self.pers[ "loadoutPerks" ][ var6 ];
            var8 = scripts\mp\perks\perks::getperkid( var7 );
            var6 setclientloadoutinfo( var6 + 1 + "_perk", var8 );
        }
        
        for ( var6 = 0; var6 < var7.loadoutextraperks.size ; var6++ )
        {
            var7 = var7.loadoutextraperks[ var6 ];
            var8 = scripts\mp\perks\perks::getperkid( var7 );
            var6 setclientloadoutinfo( var6 + 1 + "_extraPerk", var8 );
        }
    }
    
    var9 = var7.loadoutrigtrait;
    var10 = scripts\mp\perks\perks::getperkid( var9 );
    var6 setclientloadoutinfo( "rigTrait", var10 );
    var11 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef( var7.loadoutarchetype );
    var6 setclientloadoutinfo( "archetype", var11 );
}

// Params 0
// Size: 0x2d
function shouldallowinstantclassswap()
{
    if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) || istrue( self.isjuggernaut ) )
    {
        disableclassswapallowed();
    }
    
    if ( !isdefined( self.instantclassswapallowed ) )
    {
        return 1;
    }
    
    return self.instantclassswapallowed;
}

// Params 0
// Size: 0x118
function swaploadout()
{
    if ( scripts\engine\utility::ent_flag_exist( "swapLoadout_blocked" ) && scripts\engine\utility::ent_flag( "swapLoadout_blocked" ) )
    {
        self endon( "death_or_disconnect" );
        self endon( "joined_team" );
        self endon( "joined_spectators" );
        self notify( "swapLoadout" );
        self endon( "swapLoadout" );
        
        if ( !scripts\engine\utility::ent_flag( "swapLoadout_pending" ) )
        {
            scripts\engine\utility::ent_flag_set( "swapLoadout_pending" );
        }
        
        self waittill( "swapLoadout_blocked" );
    }
    
    setclass( self.pers[ "class" ] );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    scripts\mp\weapons::savetogglescopestates();
    scripts\mp\weapons::savealtstates();
    
    if ( scripts\mp\utility\game::allowclasschoice() )
    {
        scripts\mp\utility\stats::incpersstat( "classChanges", 1 );
    }
    
    giveloadout( self.pers[ "team" ], self.pers[ "class" ], undefined, 1 );
    var0 = scripts\mp\utility\game::unset_relic_grounded() && !scripts\mp\flags::gameflag( "prematch_done" );
    
    if ( var0 && isdefined( level.calculateclientmatchdataextrainfopayload ) )
    {
        self [[ level.calculateclientmatchdataextrainfopayload ]]();
    }
    
    if ( scripts\engine\utility::ent_flag_exist( "swapLoadout_pending" ) && scripts\engine\utility::ent_flag( "swapLoadout_pending" ) )
    {
        scripts\engine\utility::ent_flag_clear( "swapLoadout_pending" );
        scripts\engine\utility::ent_flag_set( "swapLoadout_complete" );
        return;
    }
}

// Params 5
// Size: 0x100
function giveloadout( var0, var1, var2, var3, var4 )
{
    self notify( "giveLoadout_start" );
    self.gettingloadout = 1;
    
    if ( isdefined( self.perks ) )
    {
        self.oldperks = self.perks;
    }
    
    loadout_clearplayer( var3 );
    var5 = zombiesignorevehicleexplosions();
    var5 = ref_1194e( var5, var1 );
    self.select_bridge_two_spawners = var5;
    var6 = undefined;
    
    if ( isdefined( self.preloadedclassstruct ) )
    {
        var6 = self.preloadedclassstruct;
        self.preloadedclassstruct = undefined;
        self.class_num = getclassindex( var1 );
        
        if ( scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            self setmoverantilagged( self.class_num );
        }
    }
    else
    {
        var6 = loadout_getclassstruct();
        var6 = loadout_updateclass( var6, var1 );
    }
    
    self.classstruct = var6;
    loadout_updateplayer( var5, var6, var1, var2, var4 );
    
    if ( var1 != "juggernaut" )
    {
        if ( scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            loadout_lognewlygivenloadout( var5, var6, var1 );
        }
    }
    
    self.gettingloadout = 0;
    respawnitems_clear();
    self notify( "changed_kit" );
    self notify( "giveLoadout" );
    scripts\mp\rank::tryresetrankxp();
    
    if ( !istrue( game[ "isLaunchChunk" ] ) && !isagent( self ) )
    {
        scripts\mp\killstreaks\killstreaks::resetforloadoutswitch();
    }
    
    scripts\mp\playerlogic::trydisableminimap();
}

// Params 3
// Size: 0x164
function loadout_lognewlygivenloadout( var0, var1, var2 )
{
    if ( !isplayer( self ) && !isalive( self ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( level.codcasterenabled )
    {
        thread setmlgspectatorclientloadoutdata( self, var1 );
    }
    
    if ( getdvarint( "TLRPKRKMS" ) == 0 )
    {
        return;
    }
    
    if ( var1.uavbestid )
    {
        var3 = 99;
        var4 = "copied";
    }
    else
    {
        var3 = getclassindex( var4 );
        var4 = loadout_getclasstype( var4 );
        var5 = getsubstr( var4, 0, 7 ) == "default";
        
        if ( var5 )
        {
            var3 += 20;
        }
    }
    
    var6 = var3.tweakedbyplayerduringmatch || var3.gamemodeforcednewloadout;
    var3.tweakedbyplayerduringmatch = 0;
    var3.gamemodeforcednewloadout = 0;
    var7 = 0;
    
    if ( !isdefined( self.pers[ "loggedClasses" ] ) )
    {
        self.pers[ "loggedClasses" ] = [];
    }
    
    var8 = -1;
    
    foreach ( var10 in self.pers[ "loggedClasses" ] )
    {
        var11 = self.pers[ "loggedClasses" ][ var12 ];
        
        if ( var11 == var3 )
        {
            if ( var6 )
            {
                var7 += 1;
                continue;
            }
            
            var8 = var12;
        }
    }
    
    if ( var8 == -1 || var3.uavbestid )
    {
        var8 = self.pers[ "loggedClasses" ].size;
        self.pers[ "loggedClasses" ][ var8 ] = var3;
        loadout_logloadout( var2, var3, var8, var7, var4 );
    }
    
    self.loadoutindex = var8;
}

// Params 5
// Size: 0x32b
function loadout_logloadout( var0, var1, var2, var3, var4 )
{
    var5 = 1;
    var6 = var4;
    var7 = var3;
    
    if ( isdefined( self.matchdatalifeindex ) )
    {
        var8 = self.matchdatalifeindex;
    }
    else
    {
        var8 = -1;
    }
    
    var9 = scripts\mp\matchdata::gettimefrommatchstart( gettime() );
    var10 = var2.loadoutprimary;
    var11 = [];
    
    for ( var12 = 0; var12 < 10 ; var12++ )
    {
        var11 = var2.loadoutprimaryattachments[ var12 ];
        
        if ( !isdefined( var11[ var12 ] ) )
        {
            var11 = "";
        }
    }
    
    var13 = var2.loadoutprimarycamo;
    var14 = var2.loadoutprimaryreticle;
    var15 = var2.loadoutprimarylootitemid;
    var16 = var2.loadoutprimaryvariantid;
    var17 = var2.loadoutsecondary;
    var18 = [];
    var12 = 0;
    
    if ( var12 < 10 )
    {
        GscBinSkip0( 0x2e, var12, var2.loadoutsecondaryattachments[ var12 ] );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    var19 = var2.loadoutsecondarycamo;
    var20 = var2.loadoutsecondaryreticle;
    var21 = var2.loadoutsecondarylootitemid;
    var22 = var2.loadoutsecondaryvariantid;
    var23 = var2.loadoutequipmentprimary;
    var24 = var2.loadoutequipmentsecondary;
    var25 = [];
    var26 = 3;
    
    for ( var27 = 0; var27 < var26 ; var27++ )
    {
        var28 = "specialty_null";
        
        if ( isdefined( var2.loadoutstandardperks[ var27 ] ) )
        {
            var28 = var2.loadoutstandardperks[ var27 ];
        }
        
        var25 = var28;
    }
    
    var29 = [];
    var30 = var2.loadoutextraperks.size;
    
    if ( var30 > 3 )
    {
        var30 = 3;
    }
    
    for ( var27 = 0; var27 < var30 ; var27++ )
    {
        var29 = var2.loadoutextraperks[ var27 ];
    }
    
    for ( var27 = 0; var27 < 3 ; var27++ )
    {
        if ( !isdefined( var29[ var27 ] ) )
        {
            var29 = "null";
        }
    }
    
    self dlog_recordplayerevent( "dlog_event_player_loadout", [ "loadout_index", var3, "class_type", var7, "mid_match_edit_count", var8, "first_use_life_index", var8, "time_ms_from_match_start", var9, "primary_weapon_setup_weapon", var10, "primary_weapon_setup_attachment_0", var11[ 0 ], "primary_weapon_setup_attachment_1", var11[ 1 ], "primary_weapon_setup_attachment_2", var11[ 2 ], "primary_weapon_setup_attachment_3", var11[ 3 ], "primary_weapon_setup_attachment_4", var11[ 4 ], "primary_weapon_setup_camo", var13, "primary_weapon_setup_reticle", var14, "primary_weapon_setup_loot_item_id", var15, "primary_weapon_setup_variant_id", var16, "secondary_weapon_setup_weapon", var17, "secondary_weapon_setup_attachment_0", var18[ 0 ], "secondary_weapon_setup_attachment_1", var18[ 1 ], "secondary_weapon_setup_attachment_2", var18[ 2 ], "secondary_weapon_setup_attachment_3", var18[ 3 ], "secondary_weapon_setup_attachment_4", var18[ 4 ], "secondary_weapon_setup_camo", var19, "secondary_weapon_setup_reticle", var20, "secondary_weapon_setup_loot_item_id", var21, "secondary_weapon_setup_variant_id", var22, "primary_grenade", var23, "tactical_gear", var24, "loadout_perk_0", var25[ 0 ], "loadout_perk_1", var25[ 1 ], "loadout_perk_2", var25[ 2 ], "extra_loadout_perk_0", var29[ 0 ], "extra_loadout_perk_1", var29[ 1 ], "extra_loadout_perk_2", var29[ 2 ], "killstreak_0", var2.loadoutkillstreak1, "killstreak_1", var2.loadoutkillstreak2, "killstreak_2", var2.loadoutkillstreak3, "field_upgrade_0", var1.loadoutfieldupgrade1, "field_upgrade_1", var1.loadoutfieldupgrade2 ] );
}

// Params 0
// Size: 0x28, Type: bool
function hasvalidationinfraction()
{
    return isdefined( self.pers ) && isdefined( self.pers[ "validationInfractions" ] ) && self.pers[ "validationInfractions" ] > 0;
}

// Params 0
// Size: 0x36
function recordvalidationinfraction()
{
    if ( isdefined( self.pers ) && isdefined( self.pers[ "validationInfractions" ] ) )
    {
        self.pers[ "validationInfractions" ] = self.pers[ "validationInfractions" ] + 1;
        return;
    }
}

// Params 1
// Size: 0x42
function _detachall( var0 )
{
    if ( !istrue( var0 ) )
    {
        self.headmodel = undefined;
    }
    
    if ( isdefined( self.riotshieldmodel ) )
    {
        scripts\mp\riotshield::riotshield_detach( 1 );
    }
    
    if ( isdefined( self.riotshieldmodelstowed ) )
    {
        scripts\mp\riotshield::riotshield_detach( 0 );
    }
    
    if ( !istrue( var0 ) )
    {
        self detachall();
    }
    
    scripts\mp\equipment\nvg::clearnvg( istrue( var0 ) );
}

// Params 0
// Size: 0x6f
function trackriotshield_ontrophystow()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    
    for ( ;; )
    {
        self waittill( "grenade_pullback", var0 );
        
        if ( var0.basename != "trophy_mp" )
        {
            continue;
        }
        
        if ( !isdefined( self.riotshieldmodel ) )
        {
            continue;
        }
        
        scripts\mp\riotshield::riotshield_move( 1 );
        self waittill( "offhand_end" );
        
        if ( scripts\mp\riotshield::isriotshield( self getcurrentweapon() ) && isdefined( self.riotshieldmodelstowed ) )
        {
            scripts\mp\riotshield::riotshield_move( 0 );
        }
    }
}

// Params 1
// Size: 0x4f, Type: bool
function valuehud( var0 )
{
    if ( isdefined( var0 ) && var0.basename != "none" )
    {
        if ( scripts\mp\utility\weapon::issuperweapon( var0.basename ) )
        {
            return true;
        }
        
        var1 = scripts\mp\utility\weapon::getequipmenttype( var0.basename );
        
        if ( isdefined( var1 ) && var1 == "lethal" )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x3e
function ref_13c57()
{
    for ( ;; )
    {
        self waittill( "grenade_pullback", var0 );
        
        if ( !nullweapon( var0 ) && var0.basename == "c4_mp_p" && scripts\mp\riotshield::isriotshield( self getcurrentweapon() ) )
        {
            self.ref_1207e = 1;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x48
function ref_13c5d()
{
    if ( !istrue( self.ref_1207e ) )
    {
        var0 = self getheldoffhand();
        
        if ( !nullweapon( var0 ) && var0.basename != "c4_mp_p" && scripts\mp\riotshield::isriotshield( self getcurrentweapon() ) && valuehud( var0 ) )
        {
            self.ref_1207e = 1;
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x42
function ref_13c5f()
{
    self.ref_12d52 = undefined;
    self.ref_12d51 = undefined;
    
    for ( ;; )
    {
        self waittill( "weapon_switch_started", var0 );
        
        if ( !scripts\mp\riotshield::isriotshield( var0 ) )
        {
            self.ref_12d52 = gettime() + 200;
            continue;
        }
        
        self.ref_12d52 = undefined;
        self.ref_12d51 = undefined;
    }
}

// Params 0
// Size: 0x27
function ref_13c5e()
{
    for ( ;; )
    {
        self waittill( "weapon_switch_canceled", var0 );
        waittillframeend();
        
        if ( scripts\mp\riotshield::isriotshield( var0 ) )
        {
            self.ref_12d52 = undefined;
            self.ref_12d51 = undefined;
        }
    }
}

// Params 1
// Size: 0x16f
function ref_13c58( var0 )
{
    self notify( "trackRiotShield_monitorShieldAttach" );
    self endon( "trackRiotShield_monitorShieldAttach" );
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "riotshield_detach" );
    
    if ( isdefined( self.infil ) )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
    }
    
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0x30
function ref_13c5a()
{
    var0 = isdefined( self.riotshieldmodel );
    var1 = isdefined( self.riotshieldmodelstowed );
    
    if ( !var1 )
    {
        if ( var0 )
        {
            scripts\mp\riotshield::riotshield_move( 1 );
            return;
        }
        
        scripts\mp\riotshield::riotshield_attach( 0, scripts\mp\riotshield::riotshield_getmodel() );
        return;
    }
}

// Params 0
// Size: 0x30
function ref_13c59()
{
    var0 = isdefined( self.riotshieldmodel );
    var1 = isdefined( self.riotshieldmodelstowed );
    
    if ( !var0 )
    {
        if ( var1 )
        {
            scripts\mp\riotshield::riotshield_move( 0 );
            return;
        }
        
        scripts\mp\riotshield::riotshield_attach( 1, scripts\mp\riotshield::riotshield_getmodel() );
        return;
    }
}

// Params 0
// Size: 0x2a
function ref_13c5b()
{
    var0 = isdefined( self.riotshieldmodel );
    var1 = isdefined( self.riotshieldmodelstowed );
    
    if ( var0 )
    {
        scripts\mp\riotshield::riotshield_detach( 1 );
    }
    
    if ( var1 )
    {
        scripts\mp\riotshield::riotshield_detach( 0 );
        return;
    }
}

// Params 0
// Size: 0x50
function ref_13c5c()
{
    if ( scripts\mp\riotshield::riotshield_hasweapon() )
    {
        var0 = scripts\mp\riotshield::isriotshield( self getcurrentweapon() );
        
        if ( var0 )
        {
            ref_13c59();
            return;
        }
        
        ref_13c5a();
        return;
    }
    
    var1 = isdefined( self.riotshieldmodel );
    var2 = isdefined( self.riotshieldmodelstowed );
    
    if ( var1 )
    {
        scripts\mp\riotshield::riotshield_detach( 1 );
    }
    
    if ( var2 )
    {
        scripts\mp\riotshield::riotshield_detach( 0 );
        return;
    }
}

// Params 1
// Size: 0x25
function riotshieldonweaponchange( var0 )
{
    if ( scripts\mp\riotshield::riotshield_hasweapon() )
    {
        thread ref_13c58();
        return;
    }
    
    ref_13c5c();
    ref_12d4e();
    self notify( "riotshield_detach" );
}

// Params 1
// Size: 0x34
function ref_12d4e( var0 )
{
    self.watch_for_heli_bosses_dead = undefined;
    self.watch_for_heli_death = undefined;
    self.ref_1443a = undefined;
    
    if ( istrue( var0 ) )
    {
        self.hasriotshield = undefined;
        self.hasriotshieldequipped = undefined;
        self.riotshieldmodel = undefined;
        self.riotshieldmodelstowed = undefined;
        return;
    }
}

// Params 9
// Size: 0xeb
function fixsuperforbr( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    var9 = buildweaponassetname( var0, var4 );
    var10 = scripts\mp\utility\weapon::weaponattachcustomtoidmap( var0, var4 );
    
    if ( !isdefined( var10 ) )
    {
        var10 = [];
    }
    
    var11 = [];
    
    foreach ( var16, var13 in var10 )
    {
        var14 = scripts\mp\utility\weapon::attachmentmap_tounique( var16, var9 );
        var15 = scripts\mp\utility\weapon::carryiteminfo( var14 );
        
        if ( isdefined( var15 ) )
        {
            var11 = 1;
        }
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( var16 in var1 )
        {
            if ( var11.size > 0 )
            {
                var14 = scripts\mp\utility\weapon::attachmentmap_tounique( var16, var9 );
                var15 = scripts\mp\utility\weapon::carryitemomnvar( var14 );
                
                if ( isdefined( var11[ var15 ] ) )
                {
                    continue;
                }
            }
            
            var18 = 0;
            
            if ( isdefined( var5 ) && isdefined( var5[ var19 ] ) )
            {
                var18 = var5[ var19 ];
            }
            
            var10 = var18;
        }
    }
    
    return buildweapon_attachmentidmap( var0, var10, var2, var3, var4, var6, var7, var8 );
}

// Params 7
// Size: 0x2b
function fixcollision( var0, var1, var2, var3, var4, var5, var6 )
{
    var7 = scripts\mp\utility\weapon::weaponattachcustomtoidmap( var0, var3 );
    
    if ( !isdefined( var7 ) )
    {
        var7 = [];
    }
    
    return buildweapon_attachmentidmap( var0, var7, var1, var2, var3, var4, var5, var6 );
}

// Params 8
// Size: 0x53
function buildweapon_attachmentidmap( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = [];
    var9 = [];
    
    foreach ( var11 in var1 )
    {
        var8 = var12;
        var9 = var11;
    }
    
    return buildweapon( var0, var8, var2, var3, var4, var9, var5, var6, var7 );
}

// Params 9
// Size: 0x1ec
function buildweapon( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( isdefined( var1 ) )
    {
    }
    else
    {
        var1 = [];
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = "none";
    }
    
    if ( isdefined( var4 ) && var4 <= 0 )
    {
        var4 = undefined;
    }
    
    var9 = buildweaponassetname( var0, var4 );
    var10 = buildweaponattachmentidmap( var1, var5 );
    
    if ( istrue( var8 ) )
    {
        if ( scripts\mp\utility\weapon::weaponsupportslaserir( var9 ) )
        {
            var11 = scripts\mp\utility\weapon::getweaponnvgattachment( var9 );
            
            if ( !isdefined( var10[ var11 ] ) )
            {
                if ( var10.size > 0 )
                {
                    var10 = 0;
                }
            }
        }
    }
    
    var12 = buildweaponuniqueattachmenttoidmap( var0, var10, var4 );
    
    if ( isdefined( var6 ) && var6 != "none" )
    {
        var6 = player_get_secondary_weapon_object( var6 );
        GscBinSkip0( 0x2e, var6, 0 );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    var12 = filterinvalidattachmentsfromidmap( var12, var9 );
    var12 = getbrendsplashpostgamestate( var12, var9 );
    
    if ( !isdefined( var9 ) || var9 == "" )
    {
        scripts\mp\utility\script::laststand_dogtags( "buildWeapon - bad weaponAssetName - rootName: " + scripts\engine\utility::ter_op( isdefined( var0 ), var0, "null" ) + ", variant: " + scripts\engine\utility::ter_op( isdefined( var4 ), var4, "none" ) );
    }
    
    var13 = getcompleteweaponname( var9, [], undefined, var2, var4 );
    
    if ( isdefined( var9 ) && !isdefined( var13 ) )
    {
        scripts\mp\utility\script::laststand_dogtags( "buildWeapon - null weapon: weaponAssetName = " + var9 + ", rootName = " + scripts\engine\utility::ter_op( isdefined( var0 ), var0, "null" ) + ", variant = " + scripts\engine\utility::ter_op( isdefined( var4 ), var4, "none" ) );
    }
    
    foreach ( var15 in var12 )
    {
        var13 = var13 withattachment( var16, var15 );
    }
    
    if ( isdefined( var7 ) )
    {
        for ( var17 = 0; var17 < var7.size ; var17++ )
        {
            var18 = var7[ var17 ];
            
            if ( var18 == "none" )
            {
                continue;
            }
            
            if ( "i/" != getsubstr( var18, 0, 2 ) )
            {
                var18 = "i/" + var7[ var17 ];
            }
            
            var13 = var13 setsticker( var17, var18 );
        }
    }
    
    if ( isdefined( var13.scope ) && !isstartstr( var13.scope, "ironsdefault" ) )
    {
        var19 = getreticleindex( var3 );
        
        if ( isdefined( var19 ) )
        {
            var13 = var13 withreticle( var19 );
        }
    }
    
    return var13;
}

// Params 1
// Size: 0x28
function player_get_secondary_weapon_object( var0 )
{
    switch ( var0 )
    {
        case "t9_charm_rebirthIsland_01":
            var0 = "t9_charm_rebirthisland_01";
        default:
            break;
    }
    
    return var0;
}

// Params 2
// Size: 0x47
function buildweaponattachmentidmap( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( isdefined( var1 ) && var5 < var1.size )
        {
            var2 = var1[ var5 ];
            continue;
        }
        
        var2 = 0;
    }
    
    return var2;
}

// Params 3
// Size: 0x17e
function buildweaponuniqueattachmenttoidmap( var0, var1, var2 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = [];
    }
    
    var1 = scripts\engine\utility::array_remove_key( var1, "none" );
    var3 = scripts\mp\utility\weapon::weaponattachdefaulttoidmap( var0, var2 );
    var4 = buildweaponassetname( var0, var2 );
    var5 = [];
    
    if ( isdefined( var3 ) )
    {
        var5 = combinedefaultandcustomattachmentidmaps( var3, var1 );
    }
    
    var6 = [];
    
    if ( var5.size > 0 )
    {
        var5 = filterattachmenttoidmap( var5, var0 );
        
        foreach ( var8 in var5 )
        {
            var9 = scripts\mp\utility\weapon::attachmentmap_tounique( var10, var4 );
            var6 = var8;
        }
    }
    
    var11 = [];
    var12 = 0;
    var13 = undefined;
    
    foreach ( var20, var8 in var6 )
    {
        var15 = scripts\mp\utility\weapon::attachmentmap_toextra( var20 );
        
        if ( isdefined( var15 ) )
        {
            var16 = 0;
            
            if ( isdefined( var2 ) )
            {
                var17 = scripts\mp\utility\weapon::attachmentmap_tobase( var15 );
                var16 = scripts\mp\utility\weapon::attachmentmap_extratovariantid( var17, var0, var2 );
            }
            else if ( var8 != 0 )
            {
                var16 = var8;
            }
            
            var18 = scripts\mp\utility\weapon::attachmentmap_tounique( var15, var4 );
            var11 = var16;
        }
        
        var19 = scripts\mp\utility\weapon::attachmentmap_tobase( var20 );
        
        if ( !isdefined( var13 ) && tv_station_fastrope_two_infil_rider_start_targetname( var19 ) )
        {
            var13 = var20;
        }
        
        if ( !var12 && ( useeventtype( var19 ) || useeventtimestamp( var20 ) ) )
        {
            var12 = 1;
        }
    }
    
    if ( var11.size > 0 )
    {
        var6 = scripts\engine\utility::array_combine_unique_keys( var6, var11 );
    }
    
    if ( isdefined( var13 ) && var12 && !issubstr( var0, "s4_" ) )
    {
        var13 = scripts\engine\utility::ter_op( var13 == "calsmg_mike4", "calsil_mike4smg", "calsil" );
        var6 = 0;
    }
    
    return var6;
}

// Params 2
// Size: 0x61
function combinedefaultandcustomattachmentidmaps( var0, var1 )
{
    var2 = [];
    
    foreach ( var5, var4 in var0 )
    {
        if ( scripts\engine\utility::array_contains_key( var1, var5 ) )
        {
            continue;
        }
        
        var2 = var4;
    }
    
    foreach ( var4 in var1 )
    {
        var2 = var4;
    }
    
    return var2;
}

// Params 2
// Size: 0x168
function filterattachmenttoidmap( var0, var1 )
{
    var2 = [];
    var3 = [];
    var4 = [];
    var5 = getfirstarraykey( var0 );
    var4 = var5;
    
    for ( var6 = 0; var6 < var4.size ; var6++ )
    {
        var7 = var4[ var6 ];
        
        if ( var7 != "none" )
        {
            var8 = scripts\mp\utility\weapon::attachmentmap_tounique( var7, var1 );
            var9 = 1;
            
            for ( var10 = 0; var10 < var2.size ; var10++ )
            {
                var11 = var2[ var10 ];
                
                if ( var11 == "" )
                {
                    continue;
                }
                
                if ( var7 == var11 )
                {
                    var9 = 0;
                    break;
                }
                
                var12 = scripts\mp\utility\weapon::attachmentsconflict( var7, var11, var1, var8, var3[ var10 ] );
                
                if ( var12 == var7 )
                {
                    var2 = "";
                    var3 = "";
                    continue;
                }
                
                if ( var12 != "" )
                {
                    var2 = "";
                    var3 = "";
                    var9 = 0;
                    var13 = [];
                    var13 = strtok( var12, " " );
                    
                    for ( var14 = 0; var14 < var13.size ; var14++ )
                    {
                        var4 = var13[ var14 ];
                    }
                    
                    break;
                }
            }
            
            if ( var9 )
            {
                var15 = var2.size;
                var2 = var7;
                var3 = var8;
            }
        }
        
        if ( var6 == var4.size - 1 )
        {
            var5 = getnextarraykey( var0, var5 );
            
            if ( isdefined( var5 ) )
            {
                var4 = var5;
            }
        }
    }
    
    var16 = [];
    
    for ( var6 = 0; var6 < var2.size ; var6++ )
    {
        var7 = var2[ var6 ];
        
        if ( var7 != "" )
        {
            var17 = scripts\engine\utility::ter_op( isdefined( var0[ var7 ] ), var0[ var7 ], 0 );
            var16 = var17;
        }
    }
    
    return var16;
}

// Params 2
// Size: 0x4a
function filterinvalidattachmentsfromidmap( var0, var1 )
{
    var2 = getcompleteweaponname( var1 );
    var3 = [];
    
    foreach ( var6, var5 in var0 )
    {
        if ( var2 canuseattachment( var6 ) )
        {
            var3 = var5;
            continue;
        }
        
        thread invalidattachmentwarning( var6, var1 );
    }
    
    return var3;
}

// Params 2
// Size: 0xa3
function getbrendsplashpostgamestate( var0, var1 )
{
    if ( !isdefined( level.´rŸöh≠êlµpUû"çoÈ ⁄`wˇ ) )
    {
        level.´rŸöh≠êlµpUû"çoÈ ⁄`wˇ = [];
    }
    
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        var5 = var10;
        
        foreach ( var9, var7 in var0 )
        {
            var8 = scripts\mp\utility\weapon::attachmentmap_tobase( var10 );
            
            if ( isdefined( level.carryingplayer[ var9 ] ) && isdefined( level.carryingplayer[ var9 ][ var8 ] ) )
            {
                var5 = level.carryingplayer[ var9 ][ var8 ];
                level.´rŸöh≠êlµpUû"çoÈ ⁄`wˇ[ var5 ] = var8;
            }
        }
        
        var2 = var4;
    }
    
    return var2;
}

// Params 2
// Size: 0x3d
function invalidattachmentwarning( var0, var1 )
{
    var2 = "Invalid Attachment: " + var0 + " on " + var1;
    
    if ( isdefined( self ) && isplayer( self ) )
    {
        if ( getdvarint( "scr_playtest", 0 ) == 1 )
        {
            self iprintlnbold( var2 );
        }
    }
}

// Params 2
// Size: 0xd
function buildweaponassetname( var0, var1 )
{
    return scripts\mp\utility\weapon::weaponassetnamemap( var0, var1 );
}

// Params 1
// Size: 0x2d
function getreticleindex( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return undefined;
    }
    
    var1 = int( tablelookup( "mp/reticleTable.csv", 1, var0, 5 ) );
    
    if ( !isdefined( var1 ) || var1 == 0 )
    {
        return undefined;
    }
    
    return var1;
}

// Params 1
// Size: 0x20, Type: bool
function tv_station_fastrope_two_infil_rider_start_targetname( var0 )
{
    return var0 == "calcust" || var0 == "calsmg" || var0 == "calsmgdrums";
}

// Params 1
// Size: 0x46, Type: bool
function useeventtimestamp( var0 )
{
    return scripts\engine\utility::string_starts_with( var0, "barsil_" ) || var0 == "barcust2_mpapa5" || scripts\engine\utility::string_starts_with( var0, "front_valpha" ) || var0 == "barlight_valpha" || var0 == "barheavy_valpha" || var0 == "barshort_valpha";
}

// Params 1
// Size: 0x10
function useeventtype( var0 )
{
    return scripts\engine\utility::string_starts_with( var0, "silencer" );
}

// Params 1
// Size: 0x9
function vehicle_checkpiggybackexploit( var0 )
{
    return var0 method_87b8();
}

// Params 2
// Size: 0xd
function getweaponpassives( var0, var1 )
{
    return scripts\mp\loot::getpassivesforweapon( var0, var1 );
}

// Params 3
// Size: 0x4a, Type: bool
function weaponhaspassive( var0, var1, var2 )
{
    var3 = getweaponpassives( var0, var1 );
    
    if ( !isdefined( var3 ) || var3.size <= 0 )
    {
        return false;
    }
    
    foreach ( var5 in var3 )
    {
        if ( var2 == var5 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x55
function getweaponvariantattachments( var0, var1 )
{
    var2 = [];
    var3 = getweaponpassives( var0, var1 );
    
    if ( isdefined( var3 ) )
    {
        foreach ( var5 in var3 )
        {
            var6 = scripts\mp\passives::getpassiveattachment( var5 );
            
            if ( !isdefined( var6 ) )
            {
                continue;
            }
            
            var2 = var6;
        }
    }
    
    return var2;
}

// Params 0
// Size: 0x6f
function replenishloadout()
{
    var0 = self.pers[ "team" ];
    var1 = self.pers[ "class" ];
    var2 = self getweaponslistall();
    
    for ( var3 = 0; var3 < var2.size ; var3++ )
    {
        var4 = var2[ var3 ];
        self givemaxammo( var4 );
        self setweaponammoclip( var4, 9999 );
        var5 = var4.basename;
        
        if ( var5 == "claymore_mp" || var5 == "claymore_detonator_mp" )
        {
            self setweaponammostock( var4, 2 );
        }
    }
}

// Params 0
// Size: 0xc5
function onplayerconnecting()
{
    for ( ;; )
    {
        level waittill( "connected", var0 );
        var0 enableplayerbreathsystem( 0 );
        
        if ( !isdefined( var0.pers[ "class" ] ) )
        {
            var0.pers[ "class" ] = "";
        }
        
        if ( !isdefined( var0.pers[ "lastClass" ] ) )
        {
            var0.pers[ "lastClass" ] = "";
        }
        
        var0.class = var0.pers[ "class" ];
        var0.lastclass = var0.pers[ "lastClass" ];
        var0.changedarchetypeinfo = var0.pers[ "changedArchetypeInfo" ];
        var0.lastarchetypeinfo = undefined;
        
        if ( !isdefined( var0.pers[ "validationInfractions" ] ) )
        {
            var0.pers[ "validationInfractions" ] = 0;
        }
    }
}

// Params 0
// Size: 0x253
function onplayerspawned()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        level waittill( "player_spawned", var0 );
        var0 enableplayerbreathsystem( 1 );
        
        if ( getdvarint( "scr_br_alt_mode_zxp", 0 ) )
        {
            if ( istrue( var0.iszombie ) )
            {
                var0 method_87aa( "zombie" );
                var0 setentitysoundcontext( "gender", "zombie" );
            }
            else if ( isdefined( var0.operatorcustomization ) && isdefined( var0.operatorcustomization.gender ) && var0.operatorcustomization.gender == "female" )
            {
                var0 method_87aa( "female" );
            }
            else
            {
                var0 method_87aa( "" );
            }
        }
        else if ( getdvarint( "scr_br_alt_mode_gxp", 0 ) )
        {
            if ( istrue( var0.unset_relic_gun_game ) )
            {
                var0 method_87aa( "ghost" );
                var0 setentitysoundcontext( "gender", "zombie" );
            }
            else if ( isdefined( var0.operatorcustomization ) && isdefined( var0.operatorcustomization.gender ) && var0.operatorcustomization.gender == "female" )
            {
                var0 method_87aa( "female" );
            }
            else
            {
                var0 method_87aa( "" );
            }
        }
        else if ( istrue( level.setplayerselfrevivingextrainfo ) && scripts\mp\utility\game::getgametype() == "infect" && var0.team == "axis" )
        {
            var0 method_87aa( "zombie" );
        }
        else if ( isdefined( var0.operatorcustomization ) && isdefined( var0.operatorcustomization.gender ) && var0.operatorcustomization.gender == "female" )
        {
            var0 method_87aa( "female" );
        }
        else
        {
            var0 method_87aa( "" );
        }
        
        var0 stoplocalsound( "deaths_door_death" );
        
        if ( isdefined( var0.ref_12135 ) )
        {
            var0 clearsoundsubmix( "iw8_mp_spawn_camera" );
            var0.ref_12135 stoploopsound( self.ref_12136 );
            var0.ref_12135 delete();
            var0.ref_12135 = undefined;
            var0.ref_12136 = undefined;
        }
        
        if ( isdefined( var0.operatorcustomization.clothtype ) && var0.operatorcustomization.clothtype != "" )
        {
            if ( istrue( var0.iszombie ) )
            {
                var0 setclothtype( "cloth" );
            }
            else
            {
                var0 setclothtype( var0.operatorcustomization.clothtype );
            }
            
            continue;
        }
        
        var0 setclothtype( "vestlight" );
    }
}

// Params 2
// Size: 0x13
function fadeaway( var0, var1 )
{
    wait var0;
    self fadeovertime( var1 );
    self.alpha = 0;
}

// Params 1
// Size: 0xa
function setclass( var0 )
{
    self.curclass = var0;
}

// Params 0
// Size: 0x50, Type: bool
function haschangedclass()
{
    if ( isdefined( self.lastclass ) && self.lastclass != self.class || !isdefined( self.lastclass ) )
    {
        return true;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "infect" && ( !isdefined( self.last_infected_class ) || self.last_infected_class != self.infected_class ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x2a, Type: bool
function haschangedarchetype()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        if ( !isdefined( self.lastarchetypeinfo ) )
        {
            return true;
        }
        
        if ( self.changedarchetypeinfo != self.lastarchetypeinfo )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x67
function resetactionslots()
{
    self setactionslot( 1, "" );
    self setactionslot( 2, "" );
    self setactionslot( 3, "" );
    self setactionslot( 4, "" );
    
    if ( !isagent( self ) && !self isconsoleplayer() )
    {
        self setactionslot( 5, "" );
        self setactionslot( 6, "" );
        self setactionslot( 7, "" );
        return;
    }
}

// Params 0
// Size: 0xe9
function resetfunctionality()
{
    self enableequipdeployvfx( 0 );
    
    if ( !isagent( self ) )
    {
        self setclientomnvar( "ui_hide_hud", 0 );
        vehicle_allowplayeruse( self, 1 );
        
        if ( level.minimaponbydefault )
        {
            self setclientomnvar( "ui_hide_minimap", 0 );
        }
        else
        {
            self setclientomnvar( "ui_hide_minimap", 1 );
        }
    }
    
    scripts\common\input_allow::clear_all_allow_info();
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141ca( self, 1 );
    scripts\common\utility::allow_script_weapon_switch( 0 );
    self.doublejumpenergy = undefined;
    self.doublejumpenergyrestorerate = undefined;
    self.enabledcollisionnotifies = undefined;
    self.enabledequipdeployvfx = undefined;
    self.minimapstatetracker = undefined;
    self.isstunned = undefined;
    self.isblinded = undefined;
    self.nocorpse = undefined;
    self.prematchlook = undefined;
    self.ladderexecutionblocked = undefined;
    scripts\mp\damage::resetattackerlist();
    scripts\mp\damage::clearcorpsetablefuncs();
    ref_12d4e();
    scripts\cp_mp\utility\player_utility::cleardemeanorsafe();
    scripts\mp\weapons::clearburnfx();
    scripts\mp\equipment\molotov::ref_11cb6();
    scripts\mp\equipment\throwing_knife_mp::ref_13b52();
    scripts\mp\equipment\flash_grenade::clearflash( 1 );
    scripts\mp\equipment\gas_grenade::gas_clear( 1 );
    
    if ( !isagent( self ) )
    {
        scripts\mp\utility\player::spawn_carriables_from_scriptables_total_percentage();
        scripts\cp_mp\killstreaks\helper_drone::markeduioff();
    }
    
    scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
    scripts\mp\utility\player::_resetenableignoreme();
    scripts\cp_mp\utility\player_utility::ref_125d0();
}

// Params 0
// Size: 0x11
function clearscriptable()
{
    self setscriptablepartstate( "CompassIcon", "defaultIcon" );
}

// Params 3
// Size: 0xce
function changearchetype( var0, var1, var2 )
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        var3 = self.changedarchetypeinfo;
        
        if ( var3.archetype == var0 && var3.super == var1 && var3.trait == var2 )
        {
            return;
        }
    }
    
    var4 = spawnstruct();
    var4.archetype = var0;
    var4.super = var1;
    var4.trait = var2;
    self.changedarchetypeinfo = var4;
    self.pers[ "changedArchetypeInfo" ] = var4;
    
    if ( isdefined( self.pers[ "class" ] ) && self.pers[ "class" ] != "" )
    {
        preloadandqueueclass( self.pers[ "class" ] );
        
        if ( shouldallowinstantclassswap() )
        {
            thread swaploadout();
            return;
        }
        
        if ( isalive( self ) )
        {
            self iprintlnbold( game[ "strings" ][ "change_rig" ] );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x2c
function getattachmentloadoutstring( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var1 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment" );
    
    if ( var0 == 0 )
    {
        return var2;
    }
    
    return var2 + var0 + 1;
}

// Params 2
// Size: 0x2c
function getstickerloadoutstring( var0, var1 )
{
    var2 = scripts\engine\utility::ter_op( var1 == "primary", "loadoutPrimarySticker", "loadoutSecondarySticker" );
    
    if ( var0 == 0 )
    {
        return var2;
    }
    
    return var2 + var0 + 1;
}

// Params 0
// Size: 0x5
function getmaxprimaryattachments()
{
    return 10;
}

// Params 0
// Size: 0x5
function getmaxsecondaryattachments()
{
    return 10;
}

// Params 1
// Size: 0x19
function getmaxattachments( var0 )
{
    return scripts\engine\utility::ter_op( var0 == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments() );
}

// Params 2
// Size: 0xea
function fillemptystreakslots( var0, var1 )
{
    if ( !level.allowkillstreaks )
    {
        return;
    }
    
    var2 = [];
    var3 = [];
    
    foreach ( var5 in var0 )
    {
        if ( var5 == "none" )
        {
            var2 = var6;
            continue;
        }
        
        var3 = var5;
    }
    
    if ( var2.size > 0 )
    {
        self.pers[ "hackedStreaks" ] = 1;
    }
    
    foreach ( var8 in var2 )
    {
        var9 = findfirststreakdifferentcost( var3 );
        
        if ( var8 + 1 == 1 )
        {
            var1.loadoutkillstreak1 = var9;
        }
        else if ( var8 + 1 == 2 )
        {
            var1.loadoutkillstreak2 = var9;
        }
        else
        {
            var1.loadoutkillstreak3 = var9;
        }
        
        var3 = var9;
    }
    
    return [ var1.loadoutkillstreak1, var1.loadoutkillstreak2, var1.loadoutkillstreak3 ];
}

// Params 1
// Size: 0xa3
function findfirststreakdifferentcost( var0 )
{
    var1 = [];
    
    foreach ( var8, var3 in game[ "killstreakTable" ].tabledatabyref )
    {
        if ( !istrue( int( var3[ "shownInMenu" ] ) ) )
        {
            continue;
        }
        
        var4 = 0;
        
        foreach ( var6 in var0 )
        {
            if ( var8 == var6 || scripts\mp\killstreaks\killstreaks::calcstreakcost( var8 ) == scripts\mp\killstreaks\killstreaks::calcstreakcost( var6 ) )
            {
                var4 = 1;
                break;
            }
        }
        
        if ( !istrue( var4 ) )
        {
            var1 = var8;
        }
    }
    
    return var1[ 0 ];
}

// Params 1
// Size: 0xa0
function replacetankwithwheelson( var0 )
{
    if ( !level.allowkillstreaks )
    {
        return;
    }
    
    var1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();
    
    if ( !var1 )
    {
        if ( var0.loadoutkillstreak1 == "bradley" )
        {
            var0.loadoutkillstreak1 = "pac_sentry";
        }
        else if ( var0.loadoutkillstreak2 == "bradley" )
        {
            var0.loadoutkillstreak2 = "pac_sentry";
        }
        else if ( var0.loadoutkillstreak3 == "bradley" )
        {
            var0.loadoutkillstreak3 = "pac_sentry";
        }
        
        self.pers[ "hackedStreaks" ] = 1;
    }
    
    return [ var0.loadoutkillstreak1, var0.loadoutkillstreak2, var0.loadoutkillstreak3 ];
}

// Params 1
// Size: 0x1e
function replacewithspecialistkillstreaks( var0 )
{
    return [ "specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus" ];
}

// Params 0
// Size: 0x66
function updateinstantclassswapallowed()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    self.instantclassswapallowed = 1;
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        var0 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs( scripts\mp\utility\game::round_vehicle_logic() );
        
        if ( var0 )
        {
            scripts\mp\flags::gameflagwait( "prematch_fade_done" );
            ref_13fe4();
        }
    }
    else
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
        ref_13fe4();
    }
    
    disableclassswapallowed();
}

// Params 0
// Size: 0x56
function ref_13fe4()
{
    self endon( "death" );
    var0 = scripts\engine\utility::ter_op( scripts\mp\utility\game::ismlgmatch(), 5, 15 );
    
    if ( scripts\mp\gamelogic::generate_randomized_primary_weapon_objs( scripts\mp\utility\game::round_vehicle_logic() ) )
    {
        while ( scripts\mp\utility\game::updatehistoryhud( self ) )
        {
            waitframe();
        }
        
        self waittill( "parachute_complete" );
    }
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_tune_up" ) )
    {
        var0 = scripts\engine\utility::ter_op( scripts\mp\utility\game::ismlgmatch(), 5, 5 );
    }
    
    wait var0;
}

// Params 0
// Size: 0x35
function disableclassswapallowed()
{
    if ( istrue( self.instantclassswapallowed ) )
    {
        self.instantclassswapallowed = 0;
        
        if ( scripts\mp\utility\game::isteamreviveenabled() )
        {
            self.revive_chosenclass = self.class;
            self.pers[ "next_round_class" ] = self.class;
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x11, Type: bool
function isvalidclass( var0 )
{
    return isdefined( var0 ) && var0 != "";
}

// Params 1
// Size: 0xc
function getclassindex( var0 )
{
    return level.classmap[ var0 ];
}

// Params 2
// Size: 0x17
function preloadandqueueclass( var0, var1 )
{
    var2 = loadout_getorbuildclassstruct( var0 );
    preloadandqueueclassstruct( var2, var1 );
    return var2;
}

// Params 3
// Size: 0x1f
function preloadandqueueclassstruct( var0, var1, var2 )
{
    var3 = scripts\mp\playerlogic::getplayerassets( var0 );
    scripts\mp\playerlogic::loadplayerassets( [ var3 ], var1, var2 );
    self.preloadedclassstruct = var0;
}

// Params 1
// Size: 0x109
function loadout_getorbuildclassstruct( var0 )
{
    if ( self.team == "spectator" && !isdefined( var0 ) )
    {
        var0 = "custom1";
    }
    
    var1 = loadout_getclasstype( var0 );
    var2 = getcachedloadoutstruct( var0, var1 );
    var3 = var1 == "custom" || var1 == "default";
    
    if ( var3 && scripts\mp\utility\game::unset_relic_grounded() )
    {
        self.wam_sequence = var0;
    }
    
    if ( isdefined( var2 ) )
    {
        if ( !isdefined( var2.loadoutprimaryobject ) && isdefined( var2.loadoutprimaryfullname ) )
        {
            var2.loadoutprimaryobject = asmdevgetallstates( var2.loadoutprimaryfullname );
        }
        
        if ( !isdefined( var2.loadoutsecondaryobject ) && isdefined( var2.loadoutsecondaryfullname ) )
        {
            var2.loadoutsecondaryobject = asmdevgetallstates( var2.loadoutsecondaryfullname );
        }
    }
    
    if ( isdefined( var2 ) )
    {
        if ( var0 == "gamemode" )
        {
            var4 = loadout_getclassstruct();
            var4 = loadout_updateclass( var4, var0 );
            var5 = compareclassstructs( var4, var2 );
            
            if ( !var5 )
            {
                var4.gamemodeforcednewloadout = 1;
                trytocacheclassstruct( var4, var0, var1 );
                return var4;
            }
        }
        
        return var2;
    }
    
    var6 = loadout_getclassstruct();
    var6 = loadout_updateclass( var6, var0 );
    trytocacheclassstruct( var6, var0, var1 );
    return var6;
}

// Params 0
// Size: 0x22
function zombiesignorevehicleexplosions()
{
    if ( !isdefined( self.pers[ "globalLoadoutStruct" ] ) )
    {
        ref_11950();
    }
    
    return self.pers[ "globalLoadoutStruct" ];
}

// Params 0
// Size: 0x57
function ref_11950()
{
    var0 = spawnstruct();
    
    if ( !isagent( self ) )
    {
        var0.loadoutfieldupgrade1 = cac_getfieldupgrade( 0 );
        var0.loadoutfieldupgrade2 = cac_getfieldupgrade( 1 );
    }
    else
    {
        var0.loadoutfieldupgrade1 = "none";
        var0.loadoutfieldupgrade2 = "none";
    }
    
    self.pers[ "globalLoadoutStruct" ] = var0;
}

// Params 0
// Size: 0x3f, Type: bool
function zombieregenratescaleoutgas()
{
    var0 = zombiesignorevehicleexplosions();
    ref_11950();
    var1 = zombiesignorevehicleexplosions();
    
    if ( var0.loadoutfieldupgrade1 != var1.loadoutfieldupgrade1 )
    {
        return true;
    }
    
    if ( var0.loadoutfieldupgrade2 != var1.loadoutfieldupgrade2 )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x47
function ref_1194f( var0, var1 )
{
    var2 = self.pers[ "gamemodeLoadout" ];
    
    if ( isdefined( var2[ "loadoutFieldUpgrade1" ] ) )
    {
        var0.loadoutfieldupgrade1 = var2[ "loadoutFieldUpgrade1" ];
    }
    
    if ( isdefined( var2[ "loadoutFieldUpgrade2" ] ) )
    {
        var0.loadoutfieldupgrade2 = var2[ "loadoutFieldUpgrade2" ];
        return;
    }
}

// Params 1
// Size: 0x4f, Type: bool
function loadout_editcachedclassstruct( var0 )
{
    var1 = loadout_getclasstype( var0 );
    var2 = getcachedloadoutstruct( var0, var1 );
    
    if ( isdefined( var2 ) )
    {
        var3 = loadout_getclassstruct();
        var3 = loadout_updateclass( var3, var0 );
        var4 = compareclassstructs( var3, var2 );
        
        if ( !var4 )
        {
            var3.tweakedbyplayerduringmatch = 1;
            trytocacheclassstruct( var3, var0, var1 );
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x4e
function getcachedloadoutstruct( var0, var1 )
{
    switch ( var1 )
    {
        case "custgamemode":
        case "custom":
        case "gamemode":
        case "default":
            if ( !isdefined( self.pers[ "classCache" ] ) )
            {
                break;
            }
            
            return self.pers[ "classCache" ][ var0 ];
    }
    
    return undefined;
}

// Params 3
// Size: 0x38
function trytocacheclassstruct( var0, var1, var2 )
{
    switch ( var2 )
    {
        case "custgamemode":
        case "custom":
        case "gamemode":
        case "default":
            addclassstructtocache( var0, var1 );
            break;
    }
}

// Params 2
// Size: 0x32
function addclassstructtocache( var0, var1 )
{
    if ( !isdefined( self.pers[ "classCache" ] ) )
    {
        self.pers[ "classCache" ][ var1 ] = [];
    }
    
    self.pers[ "classCache" ][ var1 ] = var0;
}

// Params 1
// Size: 0x21
function loadout_emptycacheofloadout( var0 )
{
    if ( !isdefined( self.pers[ "classCache" ] ) )
    {
        return;
    }
    
    self.pers[ "classCache" ][ var0 ] = undefined;
}

// Params 0
// Size: 0x13
function loadout_gamemodeloadoutchanged()
{
    self.pers[ "classCache" ][ "gamemode" ] = undefined;
}

// Params 1
// Size: 0x71
function copyclassfornextlife( var0 )
{
    self setclientomnvar( "ui_loadout_copied", gettime() );
    thread allow_cp_munitions();
    var1 = undefined;
    
    if ( isdefined( var0.juggcontext ) && isdefined( var0.juggcontext.prevclassstruct ) )
    {
        var1 = var0.juggcontext.prevclassstruct;
    }
    else
    {
        var1 = var0.classstruct;
    }
    
    self.pers[ "copiedClass" ] = zombieregenratescaleingas( var1 );
    self.pers[ "lastKiller" ] = var0;
}

// Params 0
// Size: 0x24
function allow_cp_munitions()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "spawned" );
    self setclientomnvar( "ui_loadout_changed", 11 );
}

// Params 2
// Size: 0xa8
function zombiesdamagezombies( var0, var1 )
{
    var0.loadoutsuper = var1.loadoutsuper;
    var0.loadoutstreaksfilled = var1.loadoutstreaksfilled;
    var0.loadoutstreaktype = var1.loadoutstreaktype;
    var0.loadoutkillstreak1 = var1.loadoutkillstreak1;
    var0.loadoutkillstreak2 = var1.loadoutkillstreak2;
    var0.loadoutkillstreak3 = var1.loadoutkillstreak3;
    var0.loadoutaccessoryweapon = var1.loadoutaccessoryweapon;
    var0.loadoutaccessorydata = var1.loadoutaccessorydata;
    var0.loadoutaccessorylogic = var1.loadoutaccessorylogic;
    var0.tweakedbyplayerduringmatch = 0;
    var0.gamemodeforcednewloadout = 0;
    var0.uavbestid = 1;
}

// Params 2
// Size: 0x74
function shouldskipfirstraise( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    if ( !istrue( self.hasspawned ) )
    {
        var1 = 1;
    }
    
    if ( scripts\cp_mp\utility\game_utility::shouldskipfirstraise() && istrue( self.hasspawned ) )
    {
        var1 = 1;
    }
    
    if ( istrue( self.ref_1443d ) )
    {
        var1 = 1;
    }
    
    if ( weaponclass( var0.basename ) == "mg" && !istrue( self.usingascender ) )
    {
        var1 = 1;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "infect" && istrue( self.faux_spawn_infected ) )
    {
        var1 = 1;
    }
    
    return var1;
}

// Params 4
// Size: 0x59
function respawnitems_saveplayeritemstostruct( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var3 = 0;
    
    if ( !isdefined( var0 ) || var0 )
    {
        respawnitems_saveweapons( var4 );
    }
    
    if ( !isdefined( var1 ) || var1 )
    {
        respawnitems_saveequipmentitems( var4 );
    }
    
    if ( !isdefined( var2 ) || var2 )
    {
        respawnitems_savestreaks( var4 );
    }
    
    if ( !isdefined( var3 ) || var3 )
    {
        respawnitems_savesuper( var4 );
    }
    
    return var4;
}

// Params 1
// Size: 0xa
function respawnitems_assignrespawnitems( var0 )
{
    self.respawnitems = var0;
}

// Params 0
// Size: 0x9, Type: bool
function respawnitems_hasrespawnitems()
{
    return isdefined( self.respawnitems );
}

// Params 0
// Size: 0x13
function respawnitems_getrespawnitems()
{
    if ( isdefined( self.respawnitems ) )
    {
        return self.respawnitems;
    }
    
    return undefined;
}

// Params 0
// Size: 0x8
function respawnitems_clear()
{
    self.respawnitems = undefined;
}

// Params 1
// Size: 0xe7
function respawnitems_saveweapons( var0 )
{
    var1 = [];
    var2 = self.primaryweapons;
    var3 = self.currentweapon;
    
    foreach ( var5 in var2 )
    {
        if ( scripts\mp\utility\weapon::iscacprimaryorsecondary( var5 ) )
        {
            var1 = var5;
        }
    }
    
    var7 = undefined;
    
    if ( isdefined( self.lastcacweaponobj ) )
    {
        var7 = self.lastcacweaponobj;
    }
    else if ( !scripts\mp\utility\weapon::iscacprimaryorsecondary( self.currentweapon ) )
    {
        var7 = self.currentweapon;
    }
    else if ( var1.size > 0 )
    {
        var7 = var1[ 0 ];
    }
    
    if ( getqueuedspleveltransients( var7 ) )
    {
        var7 = getcompleteweaponname( "iw8_fists_mp" );
    }
    
    respawnitems_saveweapon( var7, "primary", var0 );
    var8 = undefined;
    
    foreach ( var5 in var1 )
    {
        if ( !isnullweapon( var5, var7, 1 ) )
        {
            var8 = var5;
            break;
        }
    }
    
    if ( isdefined( var8 ) )
    {
        respawnitems_saveweapon( var8, "secondary", var0 );
        return;
    }
}

// Params 3
// Size: 0x78
function respawnitems_saveweapon( var0, var1, var2 )
{
    if ( !isdefined( var2.weapons ) )
    {
        var2.weapons = [];
    }
    
    var3 = spawnstruct();
    var2.weapons[ var1 ] = var3;
    var3.weaponobj = var0;
    var3.clipammo = self getweaponammoclip( var0 );
    var3.stockammo = self getweaponammostock( var0 );
    
    if ( var0.hasalternate )
    {
        var4 = var0 getaltweapon();
        var3.altclipammo = self getweaponammoclip( var4 );
        var3.altstockammo = self getweaponammostock( var4 );
        return;
    }
}

// Params 1
// Size: 0x1c
function respawnitems_saveequipmentitems( var0 )
{
    respawnitems_saveequipment( "primary", var0 );
    respawnitems_saveequipment( "secondary", var0 );
}

// Params 2
// Size: 0x6e
function respawnitems_saveequipment( var0, var1 )
{
    var2 = scripts\mp\equipment::getcurrentequipment( var0 );
    
    if ( !isdefined( var2 ) )
    {
        var2 = "none";
    }
    
    if ( !isdefined( var1.equipment ) )
    {
        var1.equipment = [];
    }
    
    var3 = spawnstruct();
    var1.equipment[ var0 ] = var3;
    var3.item = var2;
    
    if ( var2 != "none" )
    {
        var3.ammo = scripts\mp\equipment::getequipmentammo( var3.item );
        return;
    }
    
    var3.ammo = 0;
}

// Params 1
// Size: 0xb0
function respawnitems_savestreaks( var0 )
{
    var1 = spawnstruct();
    var1.streaks = [];
    var1.streakpoints = self.streakpoints;
    
    if ( !isdefined( self.streakpoints ) )
    {
        return;
    }
    
    var2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( var2 ) )
    {
        var1.streaks[ var1.streaks.size ] = var2.streakname;
    }
    
    var2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot( 2 );
    
    if ( isdefined( var2 ) )
    {
        var1.streaks[ var1.streaks.size ] = var2.streakname;
    }
    
    var2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot( 3 );
    
    if ( isdefined( var2 ) )
    {
        var1.streaks[ var1.streaks.size ] = var2.streakname;
    }
    
    if ( var1.streaks.size <= 0 )
    {
        return;
    }
    
    var0.streakstate = var1;
}

// Params 1
// Size: 0x3f
function respawnitems_savesuper( var0 )
{
    var1 = scripts\mp\supers::getcurrentsuperref();
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    var2 = spawnstruct();
    var0.superstate = var2;
    var2.super = var1;
    var2.superpoints = scripts\mp\supers::getcurrentsuperbasepoints();
    var2.extrapoints = scripts\mp\supers::getcurrentsuperextrapoints();
}

// Params 1
// Size: 0x14, Type: bool
function respawnitems_hasweapondata( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    return isdefined( var0.weapons );
}

// Params 2
// Size: 0x15
function respawnitems_getweaponobj( var0, var1 )
{
    return var0.weapons[ var1 ].weaponobj;
}

// Params 2
// Size: 0x6d
function respawnitems_giveweaponammo( var0, var1 )
{
    var2 = var0.weapons[ var1 ];
    self setweaponammoclip( var2.weaponobj, var2.clipammo );
    self setweaponammostock( var2.weaponobj, var2.stockammo );
    
    if ( var2.weaponobj.hasalternate )
    {
        var3 = var2.weaponobj getaltweapon();
        self setweaponammoclip( var3, var2.altclipammo );
        self setweaponammostock( var3, var2.altstockammo );
        return;
    }
}

// Params 1
// Size: 0x14, Type: bool
function respawnitems_hasequipmentdata( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    return isdefined( var0.equipment );
}

// Params 2
// Size: 0x15
function respawnitems_getequipmentref( var0, var1 )
{
    return var0.equipment[ var1 ].item;
}

// Params 2
// Size: 0x3e
function respawnitems_giveequipmentammo( var0, var1 )
{
    var2 = respawnitems_getequipmentref( var0, var1 );
    
    if ( !isdefined( var2 ) || var2 == "none" )
    {
        return;
    }
    
    var3 = var0.equipment[ var1 ].ammo;
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    scripts\mp\equipment::setequipmentammo( var2, var3 );
}

// Params 1
// Size: 0x14, Type: bool
function respawnitems_hasstreakdata( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    return isdefined( var0.streakstate );
}

// Params 1
// Size: 0x12
function respawnitems_getstreakpoints( var0 )
{
    return var0.streakstate.streakpoints;
}

// Params 1
// Size: 0x12
function respawnitems_getstreaks( var0 )
{
    return var0.streakstate.streaks;
}

// Params 1
// Size: 0x14, Type: bool
function respawnitems_hassuperdata( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    return isdefined( var0.superstate );
}

// Params 1
// Size: 0x12
function respawnitems_getsuperref( var0 )
{
    return var0.superstate.super;
}

// Params 1
// Size: 0x12
function respawnitems_getsuperpoints( var0 )
{
    return var0.superstate.superpoints;
}

// Params 1
// Size: 0x12
function respawnitems_getsuperextrapoints( var0 )
{
    return var0.superstate.extrapoints;
}

// Params 3
// Size: 0xdf
function spawnammocountoverride_giveweaponammo( var0, var1, var2 )
{
    var3 = var0;
    var4 = !var2;
    
    if ( var4 && !update_health_bar_to_players( var0 ) )
    {
        var5 = 0;
        var6 = 0;
        
        if ( var0 hasattachment( "akimbo", 1 ) )
        {
            self setweaponammoclip( var3, var5, "left" );
        }
    }
    else
    {
        var5 = var5.clipsize;
        var6 = var4 - 1;
    }
    
    if ( var4 == 7 )
    {
        var6 = weaponmaxammo( var5 );
    }
    else if ( issubstr( var5.basename, "iw8_sh_charlie725" ) && !var6 )
    {
        var6 = var5.clipsize * var6 + 18;
    }
    else
    {
        var6 = var5.clipsize * var6;
    }
    
    self setweaponammoclip( var5, var5 );
    self setweaponammostock( var5, var6 );
    
    if ( var2.hasalternate )
    {
        var7 = var2 getaltweapon();
        
        if ( var6 )
        {
            var8 = 0;
            var9 = 0;
        }
        else
        {
            var8 = self getweaponammoclip( var9 );
            var9 = self getweaponammostock( var9 );
        }
        
        self setweaponammoclip( var9, var8 );
        self setweaponammostock( var9, var9 );
        return;
    }
}

// Params 1
// Size: 0x4b
function update_health_bar_to_players( var0 )
{
    var1 = scripts\mp\utility\weapon::isknifeonly( var0.basename ) || scripts\mp\utility\weapon::turret_aimed_at_last_known( var0.basename ) || scripts\mp\utility\weapon::isaxeweapon( var0.basename ) || scripts\mp\utility\weapon::update_health_bar_to_player( var0 ) || scripts\mp\riotshield::isriotshield( var0.basename );
    return var1;
}

// Params 2
// Size: 0x2e0, Type: bool
function compareclassstructs( var0, var1 )
{
    if ( var0.loadoutarchetype != var1.loadoutarchetype )
    {
        return false;
    }
    
    if ( var0.loadoutprimary != var1.loadoutprimary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutprimaryattachments, var1.loadoutprimaryattachments ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutprimaryattachmentids, var1.loadoutprimaryattachmentids ) )
    {
        return false;
    }
    
    if ( var0.loadoutprimarycamo != var1.loadoutprimarycamo )
    {
        return false;
    }
    
    if ( var0.loadoutprimaryreticle != var1.loadoutprimaryreticle )
    {
        return false;
    }
    
    if ( var0.loadoutprimarylootitemid != var1.loadoutprimarylootitemid )
    {
        return false;
    }
    
    if ( var0.loadoutprimaryvariantid != var1.loadoutprimaryvariantid )
    {
        return false;
    }
    
    if ( var0.loadoutprimarycosmeticattachment != var1.loadoutprimarycosmeticattachment )
    {
        return false;
    }
    
    if ( var0.loadoutsecondary != var1.loadoutsecondary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutsecondaryattachments, var1.loadoutsecondaryattachments ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutsecondaryattachmentids, var1.loadoutsecondaryattachmentids ) )
    {
        return false;
    }
    
    if ( var0.loadoutsecondarycamo != var1.loadoutsecondarycamo )
    {
        return false;
    }
    
    if ( var0.loadoutsecondaryreticle != var1.loadoutsecondaryreticle )
    {
        return false;
    }
    
    if ( var0.loadoutsecondarylootitemid != var1.loadoutsecondarylootitemid )
    {
        return false;
    }
    
    if ( var0.loadoutsecondaryvariantid != var1.loadoutsecondaryvariantid )
    {
        return false;
    }
    
    if ( var0.loadoutsecondarycosmeticattachment != var1.loadoutsecondarycosmeticattachment )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutperks, var1.loadoutperks ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutstandardperks, var1.loadoutstandardperks ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( var0.loadoutextraperks, var1.loadoutextraperks ) )
    {
        return false;
    }
    
    if ( var0.loadoutusingspecialist != var1.loadoutusingspecialist )
    {
        return false;
    }
    
    if ( var0.loadoutmeleeslot != var1.loadoutmeleeslot )
    {
        return false;
    }
    
    if ( var0.loadoutperksfromgamemode != var1.loadoutperksfromgamemode )
    {
        return false;
    }
    
    if ( var0.loadoutrigtrait != var1.loadoutrigtrait )
    {
        return false;
    }
    
    if ( var0.loadoutequipmentprimary != var1.loadoutequipmentprimary )
    {
        return false;
    }
    
    if ( var0.loadoutextraequipmentprimary != var1.loadoutextraequipmentprimary )
    {
        return false;
    }
    
    if ( var0.loadoutequipmentsecondary != var1.loadoutequipmentsecondary )
    {
        return false;
    }
    
    if ( var0.loadoutextraequipmentsecondary != var1.loadoutextraequipmentsecondary )
    {
        return false;
    }
    
    if ( var0.loadoutsuper != var1.loadoutsuper )
    {
        return false;
    }
    
    if ( var0.loadoutgesture != var1.loadoutgesture )
    {
        return false;
    }
    
    if ( var0.loadoutstreaksfilled != var1.loadoutstreaksfilled )
    {
        return false;
    }
    
    if ( var0.loadoutstreaktype != var1.loadoutstreaktype )
    {
        return false;
    }
    
    if ( var0.loadoutkillstreak1 != var1.loadoutkillstreak1 )
    {
        return false;
    }
    
    if ( var0.loadoutkillstreak2 != var1.loadoutkillstreak2 )
    {
        return false;
    }
    
    if ( var0.loadoutkillstreak3 != var1.loadoutkillstreak3 )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x45, Type: bool
function checkclassstructarray( var0, var1 )
{
    if ( var0.size != var1.size )
    {
        return false;
    }
    
    foreach ( var3 in var0 )
    {
        if ( !isdefined( var1[ var4 ] ) )
        {
            return false;
        }
        
        if ( var1[ var4 ] != var3 )
        {
            return false;
        }
    }
    
    return true;
}

// Params 0
// Size: 0x2e
function computerrebootsequence_init()
{
    scripts\engine\utility::ent_flag_init( "swapLoadout_blocked" );
    scripts\engine\utility::ent_flag_init( "swapLoadout_pending" );
    scripts\engine\utility::ent_flag_init( "swapLoadout_complete" );
    scripts\engine\utility::ent_flag_set( "swapLoadout_blocked" );
}

// Params 0
// Size: 0x29
function ref_13f02()
{
    if ( scripts\engine\utility::ent_flag_exist( "swapLoadout_blocked" ) && scripts\engine\utility::ent_flag( "swapLoadout_blocked" ) )
    {
        scripts\engine\utility::ent_flag_clear( "swapLoadout_blocked" );
        return;
    }
}

// Params 1
// Size: 0x140
function zvelscale( var0 )
{
    var0.loadoutprimaryobject = var0.loadoutprimary;
    
    if ( issameweapon( var0.loadoutprimary ) )
    {
        var0.loadoutprimaryfullname = createheadicon( var0.loadoutprimaryobject );
    }
    
    if ( var0.loadoutsecondary == "none" )
    {
        var0.loadoutsecondaryfullname = "none";
        var0.loadoutsecondaryobject = undefined;
    }
    else
    {
        if ( istrue( var0.ref_11961 ) )
        {
            var0.loadoutsecondaryobject = fixsuperforbr( var0.loadoutsecondary, var0.loadoutsecondaryattachments, var0.loadoutsecondarycamo, var0.loadoutsecondaryreticle, var0.loadoutsecondaryvariantid, var0.loadoutsecondaryattachmentids, var0.loadoutsecondarycosmeticattachment, var0.loadoutsecondarystickers, istrue( var0.loadouthasnvg ) );
        }
        else
        {
            var0.loadoutsecondaryobject = buildweapon( var0.loadoutsecondary, var0.loadoutsecondaryattachments, var0.loadoutsecondarycamo, var0.loadoutsecondaryreticle, var0.loadoutsecondaryvariantid, var0.loadoutsecondaryattachmentids, var0.loadoutsecondarycosmeticattachment, var0.loadoutsecondarystickers, istrue( var0.loadouthasnvg ) );
        }
        
        var0.loadoutsecondaryfullname = createheadicon( var0.loadoutsecondaryobject );
    }
    
    if ( var0.loadoutmeleeslot != "none" )
    {
        self giveweapon( var0.loadoutmeleeslot );
        self assignweaponmeleeslot( var0.loadoutmeleeslot );
        return;
    }
}

