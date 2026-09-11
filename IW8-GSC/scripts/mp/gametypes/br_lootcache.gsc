
// Params 0
// Size: 0xcf
function brlootcache_init()
{
    scripts\engine\scriptable::ref_12f5b( "body", &lootcacheused );
    var0 = getdvar( "scr_br_debug_loot_name", "" );
    var1 = getdvar( "scr_br_debug_loot_probability", 0 );
    var2 = strtok( var0, " " );
    var3 = strtok( var1, " " );
    
    if ( var3.size == 0 )
    {
        GscBinSkip0( 0x2e, var3.size, "1.0" );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    level.dummy_backpack = [];
    
    for ( var4 = 0; var4 < var2.size ; var4++ )
    {
        var5 = spawnstruct();
        var5.name = var2[ var4 ];
        var6 = int( min( var4, var3.size - 1 ) );
        var5.ref_1289a = float( var3[ var6 ] );
        level.dummy_backpack[ level.dummy_backpack.size ] = var5;
    }
    
    if ( istrue( level.setplayerselfrevivingextrainfo ) )
    {
        setmatchdata( "halloweenTrickOrTreatRules", 1 );
        _getactualcost::init();
    }
    
    level.dummy_hint = [];
    thread ref_119ff();
}

// Params 1
// Size: 0x66, Type: bool
function get_bonus_targets( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::uniquelootitemid() )
    {
        if ( isdefined( level.playerhandleredeploy ) && isdefined( level.playerhandleredeploy[ var0 ] ) )
        {
            return false;
        }
    }
    
    if ( var0 == "brloot_respawn_token" && scripts\mp\gametypes\br_pickups::ref_12cb6() )
    {
        return false;
    }
    
    if ( ( var0 == "brloot_redeploy_token" || var0 == "brloot_gulag_token" ) && istrue( level.br_pickups.¨⁄Ü•ë¨G{[YÊ7 ) )
    {
        return false;
    }
    
    return true;
}

// Params 9
// Size: 0x214
function ref_11a41( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( istrue( var4 ) )
    {
        var9 = 35;
        
        if ( isdefined( var6 ) )
        {
            var10 = [ 115, 75, 95, 85, 105, 65 ];
            var11 = ( var1.ml_p3_to_safehouse_transition + var6 * 3 ) % var10.size;
            var12 = var10[ var11 ];
            var9 += 20 * var6;
        }
        else if ( var2.ml_p3_to_safehouse_transition % 2 > 0 )
        {
            var12 = 75;
        }
        else
        {
            var12 = 115;
        }
        
        var12 += randomfloatrange( -10, 10 );
        var13 = var12 + var3.ml_p3_to_safehouse_transition / 2 * 25 + randomfloatrange( -5, 5 );
        var12 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var3, var4, var5, var14, var12, var13 );
    }
    else if ( isdefined( self.intro_ride ) )
    {
        var14 = [[ self.intro_ride ]]( var3, var4, var5, var6, var7, var8, var14, var9 );
    }
    else
    {
        var14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var5, var6, var7, var12 );
    }
    
    if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var4 ) )
    {
        var15 = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo( var4 );
    }
    else
    {
        var15 = level.br_pickups.counts[ var5 ];
    }
    
    var16 = undefined;
    
    if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "pickupModifyCount" ) )
    {
        var15 = scripts\mp\gametypes\br_gametypes::ref_12e07( "pickupModifyCount", var5, var14, var15, var6 );
    }
    
    if ( isdefined( self.intro_moveplayercliphack ) )
    {
        var15 = [[ self.intro_moveplayercliphack ]]( var5, var15 );
    }
    
    jumpiffalse(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var5 )) LOC_0000019f;
    var17 = createheadicon( var5 );
    var18 = 0;
    
    if ( scripts\mp\utility\weapon::turnexfiltoside( var5 ) )
    {
        var16 = var15;
    }
    
    if ( var5.hasalternate )
    {
        var19 = var5 getaltweapon();
        
        if ( !scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train( var5, var19 ) )
        {
            var18 = scripts\mp\gametypes\br_weapons::br_getweaponstartingclipammo( var19 );
        }
    }
    
    var20 = scripts\mp\gametypes\br_pickups::spawnpickup( var17, var15, var15, 1, var5, undefined, var16, var18 );
    goto LOC_00000211;
}

// Params 5
// Size: 0x198
function ref_11a42( var0, var1, var2, var3, var4 )
{
    var5 = [];
    var6 = 0;
    var7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var7.ml_p3_to_safehouse_transition = self.itemsdropped;
    var7.playersetattractiontype = var4;
    var8 = [];
    
    foreach ( var10 in var0 )
    {
        if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var10 ) )
        {
            var11 = scripts\mp\utility\weapon::getweaponrootname( var10 );
            
            if ( get_bonus_targets( var11 ) )
            {
                var8 = var10;
            }
            
            continue;
        }
        
        if ( get_bonus_targets( var10 ) )
        {
            var8 = var10;
        }
    }
    
    var7.çó%Ö∞!¥∫pYÁoàZπ = var8.size;
    
    foreach ( var10 in var8 )
    {
        if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var10 ) )
        {
            var5 = ref_11a41( var10, var7, self.origin, self.angles, var1, 1, var2, var3, 1 );
            self.itemsdropped++;
            var14 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var10 );
            
            if ( isdefined( var14 ) )
            {
                var5 = ref_11a41( var14, var7, self.origin, self.angles, var1, 1, var2, var3 );
                self.itemsdropped++;
            }
            
            continue;
        }
        
        var15 = level.br_pickups.delay_hide_player_clip[ var10 ];
        
        if ( isdefined( var15 ) && var15 == 4 && var6 == 0 )
        {
            var5 = ref_11a41( var10, var7, self.origin, self.angles, var1, 1, var2, var3 );
            self.itemsdropped++;
            var6 = 1;
        }
        else
        {
            var5 = ref_11a41( var10, var7, self.origin, self.angles, var1, 0, var2, var3 );
            self.itemsdropped++;
        }
    }
    
    return var5;
}

// Params 2
// Size: 0xf
function ref_11a02( var0, var1 )
{
    return ref_11a42( var0, 1, var1 );
}

// Params 1
// Size: 0x82
function heli_flyloop( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "closed" );
    var1 = getdvarint( "scr_reusable_cache_recharge_time", 90 );
    var2 = 10;
    var3 = 1;
    var4 = var1 / var2;
    
    while ( var3 < var2 )
    {
        wait var4;
        self setscriptablepartstate( var0, "vfx" + var3 );
        var3++;
    }
    
    waitframe();
    var5 = getdvarint( "scr_reusable_cache_loot_sets", 3 );
    self.intel_collected = ( self.intel_collected + 1 ) % var5;
    self setscriptablepartstate( var0, "closing" );
    
    if ( scripts\mp\gametypes\br_publicevent_restock::use_dropkit_marker() )
    {
        scripts\mp\gametypes\br_publicevent_restock::ref_12c00();
        return;
    }
}

// Params 5
// Size: 0x251
function lootcacheused( var0, var1, var2, var3, var4 )
{
    if ( istrue( var0.computer_force_player_to_exit ) )
    {
        return;
    }
    
    if ( istrue( var3 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerSkipLootPickup", var0 ) ) )
    {
        return;
    }
    
    if ( isdefined( var0 ) && isdefined( var0.get_circle_back_nodes_on_same_side ) && ![[ var0.get_circle_back_nodes_on_same_side ]]( var0, var1, var2, var3, var4 ) )
    {
        return;
    }
    
    if ( ( var2 == "closed" || var2 == "closed_nocol" ) && !isdefined( var0.entity ) )
    {
        if ( var2 == "closed" )
        {
            var0 setscriptablepartstate( var1, "opening" );
        }
        else if ( var2 == "closed_nocol" )
        {
            var0 setscriptablepartstate( var1, "opening_nocol" );
        }
        
        if ( isdefined( var0 ) && isdefined( var0.ref_1406c ) )
        {
            GscBinSkip1( 0x74, var0.ref_1406c, var0, var1, var2, var3, var4 );
            // Unknown operator ( 0x74, iw8, PC )
        }
        
        var0.itemsdropped = 0;
        thread allow_forward_factor( var0, var1, var2, var3, var4 );
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "addSpawnLootContents" ) )
        {
            var0 thread scripts\mp\gametypes\br_gametypes::ref_12e05( "addSpawnLootContents" );
        }
        
        scripts\mp\gametypes\br_plunder::ref_11c91( "br_loot_cache", -1 );
        
        if ( isdefined( var0.type ) && var0.type == "br_loot_cache_rogue" )
        {
            var3 thread scripts\mp\utility\points::giveunifiedpoints( "br_rogueCacheOpen" );
            var3 dlog_recordplayerevent( "dlog_event_rogue_cache", [] );
        }
        else
        {
            var3 thread scripts\mp\utility\points::giveunifiedpoints( "br_cacheOpen" );
        }
        
        foreach ( var6 in level.teamdata[ var3.team ][ "activeSupplySweeps" ] )
        {
            if ( isdefined( var6 ) && var6.owner != var3 )
            {
                var6.owner thread scripts\mp\utility\points::giveunifiedpoints( "br_supply_sweep_assist", undefined, undefined, undefined, undefined, undefined, var6 );
            }
        }
        
        var3 scripts\cp\vehicles\vehicle_compass_cp::ref_12002();
        
        if ( !isdefined( var3.ref_11a01 ) )
        {
            var3.ref_11a01 = 1;
        }
        else
        {
            var3.ref_11a01++;
        }
        
        var3 scripts\mp\utility\stats::setextrascore1( var3.ref_11a01 );
        
        if ( istrue( level.setplayerselfrevivingextrainfo ) )
        {
            var3 thread _getactualcost::ref_12120( var0.type, var0, var3.calloutarea );
        }
        
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "lootCacheOpened" ) )
        {
            var3 thread scripts\mp\gametypes\br_gametypes::ref_12e05( "lootCacheOpened", var0 );
        }
        
        var8 = scripts\mp\gametypes\br_vip_quest::getplayervipquest( var3 );
        
        if ( isdefined( var8 ) )
        {
            var3 thread scripts\mp\events::killeventtextpopup( "br_vip_loot", 0, 0 );
            var8 scripts\mp\gametypes\br_quest_util::questtimersubtract( getdvarint( "scr_br_VIP_cacheTimeReduction", 5 ) );
        }
        
        level notify( "lootcache_opened_kill_callout" + var0.origin );
        level.dummy_hint = scripts\engine\utility::array_remove( level.dummy_hint, var0 );
        return;
    }
}

// Params 1
// Size: 0x27
function allow_earthquake( var0 )
{
    var1 = 0;
    var1 |= var0 == "br_loot_always_spawn_cache_common";
    var1 |= var0 == "br_loot_always_spawn_cache_legendary";
    var1 |= var0 == "br_loot_always_spawn_cache_holiday";
    return var1;
}

// Params 5
// Size: 0x5c5
function allow_forward_factor( var0, var1, var2, var3, var4 )
{
    var5 = [];
    var6 = "default";
    var7 = 0;
    
    if ( var0.type == "br_reusable_loot_cache" )
    {
        if ( !isdefined( var0.intel_collected ) )
        {
            var0.intel_collected = 0;
        }
        
        var7 = var0.intel_collected;
    }
    
    if ( isdefined( var0.ref_12f7f ) )
    {
        if ( isdefined( var0.ref_12f80 ) )
        {
            var8 = verifybunkercode( var0.ref_12f7f, var0.ref_12f80 );
        }
        else
        {
            var8 = verifybunkercode( var1.ref_12f7f );
        }
        
        var8 = scripts\engine\utility::array_randomize( var8 );
        var7 = "scriptCache";
    }
    else if ( allow_earthquake( var2.type ) && isdefined( level.playerwaittospawn ) )
    {
        var8 = [[ level.playerwaittospawn ]]( var2, var5 );
        var8 = "prePlaced";
    }
    else
    {
        var8 = pickscriptablelootitem( var3, var8 );
    }
    
    var9 = 0;
    
    if ( isdefined( var8 ) )
    {
        var9 = var8.size;
    }
    
    logstring( "_lootCacheUsedSpawnPickups " + var3.type + " " + var8 + " setIndex = " + var8 + " items.count = " + var9 );
    
    if ( isdefined( var8 ) )
    {
        var8 = ref_11a1a( var8, var6 );
    }
    
    if ( isdefined( var8 ) && var6 scripts\mp\utility\perk::_hasperk( "specialty_br_extra_killstreak_chance" ) )
    {
        var8 = ref_11a1d( var8, var6 );
    }
    
    var8 = ref_11a1e( var8, var6 );
    
    if ( isdefined( var8 ) )
    {
        if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war" )
        {
            if ( scripts\mp\flags::gameflag( "placement_updates_allowed" ) )
            {
                var10 = game[ "teamPlacements" ][ var6.team ];
                
                if ( !isdefined( level.lootchopper_initspawninfo ) )
                {
                    scripts\mp\gametypes\br_gametype_dmz::freefallfromplanestatemachine();
                }
                
                var11 = 100 - 100 * var10 / level.lootchopper_initspawninfo;
                
                if ( isdefined( level.debug_kill_tromeo ) && var11 < level.debug_kill_tromeo )
                {
                    var8 = ref_11a1b( var3, var8 );
                }
                else if ( isdefined( level.ref_13bdf ) && var11 > level.ref_13bdf )
                {
                    var8 = ref_11a1c( var3, var8 );
                }
            }
        }
        
        if ( isdefined( level.ref_11b50 ) )
        {
            var8 = ref_11a19( var8 );
        }
        
        if ( var3.type != "br_reusable_loot_cache" )
        {
            var8 = undefined;
        }
        
        if ( var3.type == "br_loot_cache_zom" )
        {
            if ( isdefined( var3.ref_12f80 ) )
            {
                var8 = var3.ref_12f80 % 3;
            }
            
            wait 0.7;
        }
        
        if ( isdefined( var3.type ) && var3.type == "br_loot_cache_rogue" )
        {
            var12 = [ "custom1", "custom2", "custom3", "custom4", "custom5", "custom6", "custom7", "custom8", "custom9", "custom10" ];
            var13 = var6 getplayerdata( level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex" );
            
            if ( !isdefined( var13 ) )
            {
                var13 = randomint( var12.size );
            }
            
            var13 = var12[ var13 ];
            var14 = var6 thread scripts\mp\gametypes\br_public::playerloadoutsaveselected( var13 );
            var15 = lootcontentsaddloadoutweapons( var6, var14 );
            
            foreach ( var17 in var15 )
            {
                var8 = var17;
            }
        }
        
        var8 = ref_11a02( var3, var8, var8 );
    }
    else
    {
        var19 = ( 0, 0, 0 );
        var20 = "mp/loot_set_cache_contents_base.csv";
        
        if ( getdvarint( "scr_br_alt_mode_cash", 0 ) )
        {
            var20 = "mp/loot_set_cache_contents_base_cash.csv";
        }
        else if ( getdvarint( "scr_br_alt_mode_gg", 0 ) )
        {
            var20 = "mp/loot_set_cache_contents_base_gg.csv";
        }
        else if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war" )
        {
            var19 = ( 0, 45, 0 );
            
            if ( var3.type == "br_loot_cache_lege" )
            {
                var20 = "mp/loot_set_cache_contents_lege_dmz_ground_tablets.csv";
            }
            else if ( var3.type == "br_loot_cache" )
            {
                var20 = "mp/loot_set_cache_contents_rare_dmz_ground_tablets.csv";
            }
        }
        
        var21 = chooseandspawnitems( var3, 2, 1, "weapon", var20, var19 );
        var8 = var21[ 0 ];
        var21 = chooseandspawnitems( var3, 0, 1, "ammo", var20, var19 );
        var8 = var21[ 0 ];
        var21 = chooseandspawnitems( var3, 0, 1, undefined, var20, var19 );
        var8 = var21[ 0 ];
        var21 = chooseandspawnitems( var3, 0, 1, undefined, var20, var19 );
        var8 = var21[ 0 ];
        var21 = chooseandspawnitems( var3, 2, 1, "plunder", var20, var19 );
        var8 = var21[ 0 ];
        var3 setscriptablepartstate( var4, "open" );
    }
    
    if ( getdvarint( "scr_spawn_hvv_tokens", 0 ) )
    {
        var22 = getdvarfloat( "scr_br_hvv_token_chance_on_loot", 0.5 );
        
        if ( randomfloat( 1 ) < var22 )
        {
            var23 = anglestoleft( var3.angles );
            scripts\mp\gametypes\br_gametype_olaride::spawnherovillaintoken( var3.origin + 50 * var23, var3.angles, undefined, var3.origin );
        }
    }
    
    var24 = "cache";
    
    switch ( var3.type )
    {
        case "br_lep_quest_cache":
        case "br_scavenger_quest_cache_adler":
        case "br_scavenger_quest_cache":
            var24 = "cache_scavenger";
            break;
        case "br_loot_cache_pow":
        case "br_loot_cache_reddoor":
        case "br_loot_cache_easterevent":
        case "br_loot_cache_lege":
            var24 = "cache_legendary";
            break;
        case "br_geiger_quest_cache":
            var24 = "cache_geigerstash";
            break;
        case "br_reusable_loot_cache":
            thread heli_flyloop( var3 );
            break;
        case "br_loot_cache_rogue":
            var24 = "cache_rogue";
            break;
    }
    
    if ( scripts\mp\gametypes\br_publicevent_restock::use_dropkit_marker() )
    {
        var3 scripts\mp\gametypes\br_publicevent_restock::ref_12cc0();
    }
    
    foreach ( var26 in var8 )
    {
        if ( isdefined( var26 ) )
        {
            var26.ref_11a40 = var24;
        }
    }
}

// Params 2
// Size: 0x84
function ref_11a1b( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var1 )
    {
        if ( issubstr( var4, "brloot_plunder" ) )
        {
            if ( var0.type == "br_loot_cache_lege" )
            {
                if ( var4 != "brloot_plunder_cash_legendary_1" && scripts\engine\utility::cointoss() )
                {
                    var4 = "brloot_plunder_cash_legendary_1";
                }
            }
            else if ( var4 != "brloot_plunder_cash_epic_2" && scripts\engine\utility::cointoss() )
            {
                var4 = "brloot_plunder_cash_epic_2";
            }
        }
        
        var2 = var4;
    }
    
    return var2;
}

// Params 2
// Size: 0x98
function ref_11a1c( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var1 )
    {
        if ( issubstr( var4, "brloot_plunder" ) )
        {
            if ( var0.type == "br_loot_cache_lege" )
            {
                if ( ( var4 == "brloot_plunder_cash_epic_2" || var4 == "brloot_plunder_cash_legendary_1" ) && scripts\engine\utility::cointoss() )
                {
                    var4 = "brloot_plunder_cash_epic_1";
                }
            }
            else if ( ( var4 == "brloot_plunder_cash_epic_2" || var4 == "brloot_plunder_cash_epic_1" ) && scripts\engine\utility::cointoss() )
            {
                var4 = "brloot_plunder_cash_rare_2";
            }
        }
        
        var2 = var4;
    }
    
    return var2;
}

// Params 1
// Size: 0x5a
function ref_11a19( var0 )
{
    var1 = [];
    
    foreach ( var3 in var0 )
    {
        if ( var3 != "brloot_access_card_red" )
        {
            var1 = var3;
            continue;
        }
        
        if ( level.ref_11b50 > level.armoryswitches )
        {
            var1 = var3;
            level.armoryswitches++;
        }
    }
    
    return var1;
}

// Params 6
// Size: 0xf1
function chooseandspawnitems( var0, var1, var2, var3, var4, var5 )
{
    var6 = [];
    var7 = 0;
    
    if ( !isdefined( var2 ) )
    {
        var2 = "";
    }
    
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    var8 = "mp/loot_set_cache_contents_base.csv";
    
    if ( isdefined( var3 ) )
    {
        var8 = var3;
    }
    
    var9 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    
    for ( var10 = 0; var10 < var1 ; var10++ )
    {
        if ( !isdefined( var5 ) )
        {
            var5 = 0;
        }
        
        var11 = registerscriptedspawnpoints( var2, var0, var5, var8 );
        
        if ( var11 == "" )
        {
            continue;
        }
        
        if ( get_bonus_targets( var11 ) )
        {
            var12 = self.angles;
            
            if ( isdefined( var4 ) )
            {
                var12 += var4;
            }
            
            var13 = level.br_pickups.delay_hide_player_clip[ var11 ];
            
            if ( isdefined( var13 ) && var13 == 4 && var7 == 0 )
            {
                var6 = ref_11a41( var11, var9, self.origin, var12, undefined, 1 );
                self.itemsdropped++;
                var7 = 1;
            }
            else
            {
                var6 = ref_11a41( var11, var9, self.origin, var12, undefined, 0 );
                self.itemsdropped++;
            }
        }
    }
    
    return var6;
}

// Params 2
// Size: 0xe0
function ref_11a1d( var0, var1 )
{
    if ( !isdefined( var1.display_hint_forced ) )
    {
        var1.display_hint_forced = 10;
    }
    
    var2 = 0;
    
    foreach ( var4 in var0 )
    {
        if ( issubstr( var4, "killstreak" ) )
        {
            var2 = 1;
            break;
        }
    }
    
    if ( !var2 )
    {
        if ( randomint( 100 ) < var1.display_hint_forced )
        {
            if ( !isdefined( level.vip_info ) )
            {
                level.vip_info = 0;
            }
            else
            {
                level.vip_info = randomint( 25 );
            }
            
            var6 = verifybunkercode( "killchain_boost", level.vip_info );
            
            foreach ( var8 in var6 )
            {
                var0 = var8;
            }
            
            var1.display_hint_forced = 10;
        }
        else
        {
            var1.display_hint_forced += 15;
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x4b
function ref_11a1a( var0, var1 )
{
    foreach ( var3 in level.dummy_backpack )
    {
        if ( var3.ref_1289a > randomfloat( 1 ) )
        {
            var0 = var3.name;
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x46
function ref_11a1e( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var2 = getdvarfloat( "scr_br_plunder_adjust_prob", 0.8 );
    
    if ( randomfloat( 1 ) < var2 && !vehicle_collision_takedamage( var0 ) )
    {
        if ( !ref_1373a( var1 ) )
        {
            var0 = "brloot_plunder_cash_uncommon_1";
        }
    }
    
    return var0;
}

// Params 1
// Size: 0x3d, Type: bool
function vehicle_collision_takedamage( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    foreach ( var2 in var0 )
    {
        if ( issubstr( var2, "brloot_plunder" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0xce, Type: bool
function ref_1373a()
{
    var0 = self;
    
    if ( !isalive( var0 ) )
    {
        return false;
    }
    
    var1 = 0;
    var2 = 0;
    var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( var0.team, var0.squadindex );
    
    foreach ( var5 in var3 )
    {
        if ( var5 scripts\mp\gametypes\br_public::unlockscriptabledoors() )
        {
            var2 = 1;
            continue;
        }
        
        if ( isdefined( var5.plundercount ) )
        {
            var1 += var5.plundercount;
        }
    }
    
    var7 = level.br_armory_kiosk.ref_13ac3;
    var8 = var0 scripts\mp\utility\perk::_hasperk( "specialty_br_cheaper_kiosk" );
    var9 = level.br_armory_kiosk.ref_13ac4;
    
    if ( !isdefined( var9 ) )
    {
        var9 = 0;
    }
    
    var10 = scripts\mp\gametypes\br_armory_kiosk::ai_push_to_position( undefined, level.br_armory_kiosk.ref_13ac2, 0, var7, var8, var9 );
    
    if ( var2 && isdefined( var10 ) && var1 < var10 )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x27
function ref_119ff()
{
    level endon( "game_ended" );
    level waittill( "prematch_fade_done" );
    var0 = getlootscriptablearrayinradius( "br_loot_cache_lege" );
    
    if ( isdefined( var0 ) )
    {
        level.dummy_hint = var0;
        return;
    }
}

// Params 1
// Size: 0x26
function lootcontentsaddloadoutweapons( var0 )
{
    level endon( "game_ended" );
    var1 = [];
    GscBinSkip0( 0x2e, var1.size, var0.loadoutprimaryobject );
    // Unknown operator ( 0x2e, iw8, PC )
}

