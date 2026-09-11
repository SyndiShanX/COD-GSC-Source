
// Params 0
// Size: 0x85
function delete_objective_on_death_safe()
{
    level.br_pickups = spawnstruct();
    level.forcegivesuper = &forcegivesuper;
    level.showuseresultsfeedback = &showuseresultsfeedback;
    level.ref_12c1f = &ref_12c1f;
    level.plunderrepositoryrestricted = &plunderrepositoryref;
    level.plunderrepositories = &plunderrankupdate;
    level.¡$Àê"Û)Ç{§-[£‘‘ó = getdvarint( "scr_gm_allow_adsdelay", 1 );
    level.Ž•,éfµá§"Å[5‹èÃ?«Úh[ = getdvarint( "scr_gm_allow_jumpingskip", 1 );
    level.“ö;XÍ­…nÚ5®¶àæm-8Ö,7®± = getdvarint( "scr_gm_allow_jumpingskip_manual", 0 );
    level.±‚À‹X3Û<å`²aÄ7xë<‘ = getdvarint( "OLLNLPLRR", 0 );
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &playergasmasktoggle );
    initarrays();
    toppercentagetoadjusteconomy();
}

// Params 0
// Size: 0xdf0
function initarrays()
{
    level.brloottablename = getdvar( "RKMMNSQKO", "mp/loot/br/default/loot_item_defs.csv" );
    
    if ( !isdefined( level.br_pickups ) )
    {
        level.br_pickups = spawnstruct();
    }
    
    level.br_pickups.init_relic_ammo_drain = [];
    level.br_pickups.›¾£kµ«ÅñâzÛ&kîØƒ‘Ùp¾¿þK = [];
    level.br_pickups.modetype = [];
    ref_12b33( "brloot_equip_gasmask", &plundermusicfirst );
    ref_12b33( "brloot_equip_gasmask_durable", &plundermusicfirst );
    level.br_pickups.br_equipname = [];
    level.br_pickups.stackable = [];
    level.br_pickups.maxcounts = [];
    level.br_pickups.counts = [];
    level.br_pickups.br_itemtype = [];
    level.br_pickups.br_itemrow = [];
    level.br_pickups.delay_hide_player_clip = [];
    level.br_pickups.br_equipnametoscriptable = [];
    level.br_pickups.br_weapontoscriptable = [];
    level.br_pickups.br_pickupsfx = [];
    level.br_pickups.br_killstreakreference = [];
    level.br_pickups.br_killstreaktoscriptable = [];
    level.br_pickups.br_superreference = [];
    level.br_pickups.delay_delete_rpg_missile = [];
    level.br_pickups.ref_13f09 = [];
    level.br_pickups.delay_give_lethal_grenade = [];
    level.br_pickups.br_allguns = [];
    level.br_pickups.br_lootguns = [];
    level.br_pickups.delay_safe_spawn_chopper_boss = [];
    level.br_pickups.br_crateguns = [];
    level.br_pickups.br_crateitems = [];
    level.br_pickups.br_gulagpickups = [];
    level.br_pickups.br_perkpoints = [];
    level.br_pickups.delay_push_player_clear_door_way = [];
    level.br_pickups.deletesoundents = [];
    level.br_lootiteminfo = [];
    level.br_weaponsprimary = [];
    level.br_weaponssecondary = [];
    level.br_throwables = [];
    level.br_usables = [];
    var0 = [];
    var1 = 0;
    var2 = "+";
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        var3 = tablelookupgetnumrows( level.brloottablename );
        var4 = getnospawntags();
        var5 = 0;
        
        while ( var5 < var3 )
        {
            var6 = tablelookupbyrow( level.brloottablename, var5, 0 );
            
            if ( !isdefined( var6 ) )
            {
            }
            else if ( var6 == "item" )
            {
                var7 = tablelookupbyrow( level.brloottablename, var5, 2 );
                
                if ( !isdefined( var7 ) )
                {
                    goto LOC_00000ab5;
                }
                
                if ( var7 == "weapon" )
                {
                    var8 = tablelookupbyrow( level.brloottablename, var5, 1 );
                    var9 = tablelookupbyrow( level.brloottablename, var5, 3 );
                    var10 = tablelookupbyrow( level.brloottablename, var5, 5 );
                    var11 = tablelookupbyrow( level.brloottablename, var5, 15 );
                    jumpiffalse(isdefined( var10 ) && var10.size > 0) LOC_0000044d;
                    var12 = int( var10 );
                    var13 = tablelookup( "loot/weapon_ids.csv", 0, var12, 1 );
                    jumpiffalse(var13 == "") LOC_000002e0;
                    scripts\mp\utility\script::laststand_dogtags( "lootID not found in weapon_ids.csv - lootID: " + var10 + " in row " + var5 + " from table " + level.brloottablename );
                    goto LOC_00000ab5;
                }
                else
                {
                    var17 = tablelookupbyrow( level.brloottablename, var11, 1 );
                    level.br_pickups.br_itemrow[ var17 ] = int( var11 );
                    var45 = tablelookupbyrow( level.brloottablename, var11, 8 );
                    
                    if ( isdefined( var45 ) && var45.size > 0 )
                    {
                        var45 = tolower( var45 );
                        level.br_pickups.br_equipname[ var17 ] = var45;
                        level.br_pickups.br_equipnametoscriptable[ var45 ] = var17;
                    }
                    
                    level.br_pickups.delay_delete_rpg_missile[ var17 ] = int( tablelookupbyrow( level.brloottablename, var11, 24 ) );
                    var46 = tablelookupbyrow( level.brloottablename, var11, 16 );
                    
                    if ( var46 != "" )
                    {
                        switch ( var46 )
                        {
                            case "1":
                                if ( isdefined( var45 ) && var45.size > 0 )
                                {
                                    level.equipment.table[ var45 ].defaultslot = "primary";
                                }
                                
                                level.br_throwables[ level.br_throwables.size ] = var17;
                                break;
                            case "2":
                                if ( isdefined( var45 ) && var45.size > 0 )
                                {
                                    level.equipment.table[ var45 ].defaultslot = "secondary";
                                }
                                
                                level.br_usables[ level.br_usables.size ] = var17;
                                break;
                            case "3":
                                if ( isdefined( var45 ) && var45.size > 0 )
                                {
                                    level.equipment.table[ var45 ].defaultslot = "health";
                                }
                                
                                break;
                            case "4":
                                if ( isdefined( var45 ) && var45.size > 0 )
                                {
                                    level.equipment.table[ var45 ].defaultslot = "super";
                                }
                                
                                break;
                            default:
                                break;
                        }
                    }
                    
                    if ( var13 == "killstreak" || var13 == "killstreak_nodrop" )
                    {
                        var47 = tablelookupbyrow( level.brloottablename, var11, 19 );
                        level.br_pickups.br_killstreakreference[ var17 ] = var47;
                        level.br_pickups.br_killstreaktoscriptable[ var47 ] = var17;
                    }
                    else if ( var13 == "super" || var13 == "super_nodrop" )
                    {
                        var48 = tablelookupbyrow( level.brloottablename, var11, 19 );
                        level.br_pickups.br_superreference[ var17 ] = var48;
                    }
                    else if ( var13 == "perkpoint" || var13 == "perkpoint_nodrop" )
                    {
                        var49 = tablelookupbyrow( level.brloottablename, var11, 19 );
                        level.br_pickups.br_perkpoints[ level.br_pickups.br_perkpoints.size ] = var17;
                    }
                    else if ( var13 == "lethal" || var13 == "lethal_nodrop" )
                    {
                        level.br_pickups.delay_push_player_clear_door_way[ level.br_pickups.delay_push_player_clear_door_way.size ] = var17;
                    }
                    else if ( var13 == "tactical" || var13 == "tactical_nodrop" )
                    {
                        level.br_pickups.deletesoundents[ level.br_pickups.deletesoundents.size ] = var17;
                    }
                    
                    var50 = int( tablelookupbyrow( level.brloottablename, var11, 4 ) );
                    var51 = int( tablelookupbyrow( level.brloottablename, var11, 18 ) );
                    
                    if ( var13 == "ammo" )
                    {
                        level.br_ammo_max[ var17 ] = var51;
                    }
                    
                    level.br_pickups.maxcounts[ var17 ] = var51;
                    level.br_pickups.stackable[ var17 ] = var51 > 1;
                    level.br_pickups.counts[ var17 ] = var50;
                    var13 = tolower( var13 );
                    level.br_pickups.br_itemtype[ var17 ] = var13;
                    level.br_pickups.br_pickupsfx[ var17 ] = tablelookupbyrow( level.brloottablename, var11, 15 );
                    var52 = tablelookupbyrow( level.brloottablename, var11, 3 );
                    level.br_pickups.delay_hide_player_clip[ var17 ] = int( var52 );
                }
                
                var53 = tablelookupbyrow( level.brloottablename, var11, 6 );
                var53 = strtok( var53, "&" );
                var54 = scripts\engine\utility::array_has_intersection( var53, var10 );
                level.br_pickups.delay_give_lethal_grenade[ var17 ] = var54;
            }
            else if ( var12 == "crate" )
            {
                var17 = tablelookupbyrow( level.brloottablename, var11, 1 );
                var55 = int( tablelookupbyrow( level.brloottablename, var11, 2 ) );
                
                if ( var55 > 0 )
                {
                    if ( isdefined( level.br_lootiteminfo[ var17 ] ) && isdefined( level.br_lootiteminfo[ var17 ].baseweapon ) )
                    {
                        for ( var56 = 0; var56 < var55 ; var56++ )
                        {
                            level.br_pickups.br_crateguns[ level.br_pickups.br_crateguns.size ] = var17;
                            level.br_pickups.br_allguns[ level.br_pickups.br_allguns.size ] = var17;
                        }
                    }
                    else
                    {
                        for ( var56 = 0; var56 < var56 ; var56++ )
                        {
                            level.br_pickups.br_crateitems[ level.br_pickups.br_crateitems.size ] = var18;
                        }
                    }
                }
            }
            else if ( var13 == "gulag" )
            {
                var18 = tablelookupbyrow( level.brloottablename, var12, 1 );
                var57 = tablelookupbyrow( level.brloottablename, var12, 2 );
                
                if ( !isdefined( level.br_pickups.br_gulagpickups[ var57 ] ) )
                {
                    level.br_pickups.br_gulagpickups[ var57 ] = [];
                }
                
                var58 = level.br_pickups.br_gulagpickups[ var57 ].size;
                level.br_pickups.br_gulagpickups[ var57 ][ var58 ] = var18;
            LOC_00000ab5:
            }
            
        LOC_00000ab5:
            var12++;
        }
        
        ref_12183( "brloot_equip_gasmask", getdvarint( "scr_br_gasMask_health", 108 ) );
        ref_12183( "brloot_equip_gasmask_durable", getdvarint( "scr_br_gasMask_health_durable", 216 ) );
        ref_12183( "brloot_plate_pouch", 8 );
    }
    
    setdvarifuninitialized( "scr_br_disableLootDropTrail", 0 );
    level.br_pickups.br_pickupdenyammonoroom = "MP/BR_AMMO_DENY_NO_ROOM";
    level.br_pickups.br_pickupdenyequipnoroom = "MP/BR_EQUIP_DENY_NO_ROOM";
    level.br_pickups.br_pickupdenyalreadyhaveweapon = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
    level.br_pickups.br_pickupdenyarmornotbetter = "MP/BR_ARMOR_DENY_NOT_BETTER";
    level.br_pickups.br_pickupdenyalreadyhaveks = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
    level.br_pickups.£¼&a²o°ƒ
ï£±Ë2X°éëž¼ Ëó‹½çÊ@Œ%2³…ëˆð = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
    level.br_pickups.™-#µ»O0ã\#›‡ÍÀÚk3Z“C9ó)që¼à´cÿ·K = "MP_BR_INGAME/ALREADY_HAVE_GULAG_TOKEN";
    level.br_pickups.delete_fan_blades = "MP_BR_INGAME/ALREADY_HAVE_SELF_REVIVE_ITEM";
    level.br_pickups.delete_furthest_respawn_enemy = "MP/BR_ARMOR_DENY_ARMOR_FULL";
    level.br_pickups.delete_ents_to_clean_up = "MP_BR_INGAME/ALREADY_HAVE_PLATE_POUCH_ITEM";
    level.br_pickups.delete_intro_lights = "MP_BR_INGAME/PLATE_POUCH_ALREADY_HAVE_MAX_PLATES";
    level.br_pickups.delete_headicon = "MP_BR_INGAME/PLATE_POUCH_EMPTY_SATCHEL";
    level.br_pickups.delete_headicon_on_death = "MP_BR_INGAME/PLATE_POUCH_FILLING_PLATES";
    level.br_pickups.delete_light = "MP/BR_PICKUP_DENY_PARACHUTING";
    level.br_pickups.delete_exfil_ai_structs = "MP_BR_INGAME/TABLET_PICKUP_FAILURE";
    level.br_pickups.delete_me = "MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED";
    level.br_pickups.delete_laser_entities = "KILLSTREAKS/JUGG_CANNOT_BE_USED";
    level.br_pickups.delete_keypad_display_models = "KILLSTREAKS/JUGG_TEAM_MAX_REACHED";
    level.br_pickups.delete_enemies_if_reaching_max_ai = "MP_BR_INGAME/ALREADY_HAVE_SPECIALIST_BONUS_ITEM";
    level.br_pickups.delete_elevator = "MP_BR_INGAME/ALREADY_HAVE_POINT_PERK";
    level.br_pickups.delete_ent = "MP_BR_INGAME/CIRCLE_PEEK_LIMIT";
    level.br_pickups.delete_entarray = "MP_BR_INGAME/CONTACT_ONLY_ITEM";
    level.br_pickups.delete_objective_on_death = "MP_BR_INGAME/TABLET_WRONG_TEAM_FAILURE";
    level.br_pickups.delete_name_fx = "MP_BR_INGAME/ARMOR_INSERT_IN_PROGRESS";
    level.br_pickups.br_dropoffsets = [ ( 24, 24, 6 ), ( -24, -24, 6 ), ( 24, -24, 6 ), ( -24, 24, 6 ), ( 48, 0, 6 ), ( -48, 0, 6 ), ( 0, -48, 6 ), ( 0, 48, 6 ), ( 72, 0, 6 ), ( -72, 0, 6 ), ( 0, -72, 6 ), ( 0, 72, 6 ), ( 72, -72, 6 ), ( -72, 72, 6 ), ( -72, -72, 6 ), ( 72, 72, 6 ) ];
    level.br_pickups.ref_12cb7 = getdvarint( "scr_br_respawn_token", 1 );
    level.br_pickups.ref_12cb5 = getdvarint( "scr_br_respawn_token_gulag", 1 );
    level.br_pickups.™íRÇ‚SäóÈ¯bH7È¨c£w—ãc¹û = getdvarint( "scr_br_gulag_token_gulag", 1 );
    level.br_pickups.modifydamagetohunter = getdvarint( "scr_br_drop_specialist_pickup", 0 );
    scripts\engine\scriptable::scriptable_addusedcallback( &lootused );
    scripts\engine\scriptable::ref_12f57( &lootused );
}

// Params 2
// Size: 0x2c
function ref_12183( var0, var1 )
{
    if ( isdefined( level.br_pickups.counts[ var0 ] ) && isdefined( var1 ) )
    {
        level.br_pickups.counts[ var0 ] = var1;
        return;
    }
}

// Params 4
// Size: 0x64
function remove_roof_nodes( var0, var1, var2, var3 )
{
    var4 = spawnstruct();
    var4.origin = var0;
    
    if ( isdefined( var1 ) )
    {
        var4.angles = var1;
    }
    else
    {
        var4.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( var2 ) )
    {
        var4.ref_12223 = var2;
    }
    else
    {
        var4.ref_12223 = 0;
    }
    
    var4.set_force_aitype_armored = var3;
    return var4;
}

// Params 8
// Size: 0x2f6
function getitemdroporiginandangles( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = 1;
    var9 = 1;
    var10 = getdvarint( "br_loot_trace_debug", 0 );
    var11 = 14;
    var12 = 50;
    var13 = 40;
    var14 = -5;
    var15 = 5;
    var16 = 10;
    var17 = 360 / var11;
    var18 = -5;
    var19 = 5;
    var20 = 40;
    var21 = 20;
    var22 = 60;
    var23 = -6;
    var24 = 16;
    var25 = -18;
    var26 = 0;
    var27 = 0;
    var28 = undefined;
    var29 = var24;
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    if ( isdefined( var6 ) )
    {
        var29 = var6;
    }
    
    var30 = int( var0.ml_p3_to_safehouse_transition / var11 );
    var31 = var0.ml_p3_to_safehouse_transition - var30 * var11;
    var32 = var2[ 1 ] + var31 * var17 + var30 * var16 + randomfloatrange( var18, var19 );
    var33 = var12 + var30 * var13 + randomfloatrange( var14, var15 );
    
    if ( isdefined( var4 ) )
    {
        var32 = var2[ 1 ] + var4;
    }
    
    if ( isdefined( var5 ) )
    {
        var33 = var5;
    }
    
    var34 = ( 0, var32, 0 );
    var35 = anglestoforward( var34 );
    var36 = var1 + var35 * var33;
    
    if ( var9 )
    {
        var37 = scripts\engine\utility::array_combine( tablesort( var36, 500, 500 ), level.ref_1403d );
        
        if ( isdefined( var3 ) )
        {
            GscBinSkip0( 0x2e, var37.size, var3 );
            // Unknown operator ( 0x2e, iw8, PC )
        }
        
        var38 = var1 + ( 0, 0, var21 );
        var39 = var36 + ( 0, 0, var21 );
        var40 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1 );
        var41 = scripts\engine\trace::ray_trace( var38, var39, var37, var40 );
        
        if ( var41[ "fraction" ] < 1 )
        {
            var36 = var41[ "position" ];
            var36 += var35 * var25;
        }
        else
        {
            var36 = var39;
        }
        
        var38 = var36;
        var39 = var36 + ( 0, 0, var22 );
        var41 = scripts\engine\trace::ray_trace( var38, var39, var37, var40 );
        
        if ( var41[ "fraction" ] < 1 )
        {
            var36 = var41[ "position" ] + ( 0, 0, var23 );
        }
        else
        {
            var36 = var39;
        }
        
        var41 = undefined;
        
        if ( istrue( var7 ) )
        {
            var41 = scripts\mp\gametypes\br_public::modifytriggerlocation( var36, 0, undefined, undefined, var37 );
        }
        else
        {
            var38 = var36;
            var42 = -1 * getdvarfloat( "bg_maxLootDropHeight", 2000 );
            var39 = var36 + ( 0, 0, var42 );
            var41 = scripts\engine\trace::ray_trace( var38, var39, var37, var40 );
        }
        
        if ( var41[ "fraction" ] < 1 )
        {
            var36 = var41[ "position" ] + ( 0, 0, var29 );
            var28 = var41[ "entity" ];
        }
        else
        {
            var36 = ( 0, 0, 0 );
            var26 = 1;
        }
    }
    else
    {
        var36 += ( 0, 0, var29 );
    }
    
    if ( var8 && !var26 )
    {
        var43 = scripts\engine\utility::ter_op( isdefined( self.intro_heli_add_player ), self.intro_heli_add_player, var20 );
        var27 = getscriptablereservedremaining( var1 + ( 0, 0, var43 ), var36 );
    }
    
    var0.ml_p3_to_safehouse_transition++;
    return remove_roof_nodes( var36, var34, var27, var28 );
}

// Params 1
// Size: 0x36
function relics_monitor_on_player( var0 )
{
    if ( isdefined( var0 ) && isdefined( level.br_lootiteminfo[ var0 ] ) && isdefined( level.br_lootiteminfo[ var0 ].playerstartjailsetcontrols ) )
    {
        return level.br_lootiteminfo[ var0 ].playerstartjailsetcontrols;
    }
    
    return undefined;
}

// Params 1
// Size: 0x24
function relic_vampire_globalfunc( var0 )
{
    if ( isdefined( var0 ) && isdefined( var0.scriptablename ) )
    {
        return relics_monitor_on_player( var0.scriptablename );
    }
    
    return undefined;
}

// Params 1
// Size: 0x42
function respawnplayer( var0 )
{
    if ( isdefined( var0 ) && isdefined( var0.scriptablename ) && isdefined( level.br_pickups.delay_hide_player_clip[ var0.scriptablename ] ) )
    {
        return level.br_pickups.delay_hide_player_clip[ var0.scriptablename ];
    }
    
    return undefined;
}

// Params 1
// Size: 0x34
function getgulagpickupsforclass( var0 )
{
    var1 = [ "none" ];
    
    if ( isdefined( var0 ) && isdefined( level.br_pickups.br_gulagpickups[ var0 ] ) )
    {
        var1 = level.br_pickups.br_gulagpickups[ var0 ];
    }
    
    return var1;
}

// Params 1
// Size: 0x12
function ref_119ed( var0 )
{
    return var0.count >> 0 & 2047;
}

// Params 1
// Size: 0x13
function ref_119ef( var0 )
{
    return var0.count >> 11 & 2047;
}

// Params 1
// Size: 0x12
function ref_119ee( var0 )
{
    return var0.count >> 22 & 31;
}

// Params 4
// Size: 0x3c
function ref_119f5( var0, var1, var2, var3 )
{
    var4 = 0;
    var4 += ( var1 & 2047 ) << 0;
    
    if ( isdefined( var2 ) )
    {
        var4 += ( var2 & 2047 ) << 11;
    }
    
    if ( isdefined( var3 ) )
    {
        var4 += ( var3 & 31 ) << 22;
    }
    
    var0.count = var4;
}

// Params 1
// Size: 0x59, Type: bool
function ref_11a48( var0 )
{
    if ( var0.type == "br_plunder_box" || var0.type == "br_portable_kiosk" || var0.type == "br_carriable_gasoline" )
    {
        return true;
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "lootUsedIgnore", var0 ) ) )
    {
        return true;
    }
    
    if ( istrue( var0.ref_11a48 ) )
    {
        return true;
    }
    
    return false;
}

// Params 5
// Size: 0x25f
function lootused( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    if ( istrue( var3 scripts\mp\gametypes\br_gametypes::ref_12e05( "playerSkipLootPickup", var0 ) ) || istrue( level.stop_end_breach_fx ) )
    {
        return;
    }
    
    if ( var0 getscriptableisloot() && !ref_11a48( var0 ) )
    {
        var5 = spawnstruct();
        var5.scriptablename = var0.type;
        var5.origin = var0.origin;
        var5.count = ref_119ed( var0 );
        var5.impulsefx = ref_119ef( var0 );
        var5.impactfunc_fire = ref_119ee( var0 );
        var5.tracknonoobplayerlocation = var0;
        var5.customweaponname = var0.customweaponname;
        var5.maxcount = level.br_pickups.maxcounts[ var5.scriptablename ];
        var5.stackable = level.br_pickups.stackable[ var5.scriptablename ];
        
        if ( !var5.count && isdefined( level.br_pickups.counts[ var5.scriptablename ] ) )
        {
            var5.count = level.br_pickups.counts[ var5.scriptablename ];
        }
        
        var5.isweaponfromcrate = var0.isweaponfromcrate;
        var5.turretsactive = var4;
        
        if ( isdefined( var0.weapon ) )
        {
            var5.weapon = var0.weapon;
            var5.×¶ œ[÷øêRCÏßWÉW& = 1;
        }
        
        var6 = cantakepickup( var3, var5 );
        
        if ( var6 == 1 )
        {
            var7 = onusecompleted( var3, var5, undefined, var4 );
            
            if ( isdefined( var0 ) && var7 )
            {
                ref_119f5( var0, var5.count, var5.impulsefx, var5.impactfunc_fire );
            }
            
            if ( !isdefined( var0 ) || var7 )
            {
                return;
            }
            
            ref_11a21( var0 );
            return;
        }
        
        var8 = 1;
        var9 = level.br_pickups.delay_delete_rpg_missile[ var5.scriptablename ];
        
        if ( var4 && istrue( var9 ) && var2 == "visible" )
        {
            var8 = 0;
        }
        
        if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e07( "skipPickupFeedback", var5, var4, var2, var3 ) ) )
        {
            var8 = 0;
        }
        
        if ( var6 == 17 || var6 == 21 )
        {
            var8 = 0;
        }
        
        if ( var8 )
        {
            var10 = scripts\mp\gametypes\br_gametypes::ref_12e06( "lootUsedGiveFeedback", var5, var3, var6 );
            
            if ( !isdefined( var10 ) )
            {
                if ( var6 == 3 )
                {
                    var3 playlocalsound( "weap_ammo_full" );
                }
                else if ( var6 == 25 )
                {
                    var3 playlocalsound( "br_pickup_ammo" );
                }
                else
                {
                    var3 playlocalsound( "br_pickup_deny" );
                }
                
                showuseresultsfeedback( var3, var6 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x42, Type: bool
function islootcache( var0 )
{
    return var0.type == "br_loot_cache" || var0.type == "br_loot_cache_lege" || var0.type == "br_reusable_loot_cache" || var0.type == "br_loot_cache_rogue";
}

// Params 2
// Size: 0x75
function update_gamebattles_char_loc( var0, var1 )
{
    if ( islootcache( var0 ) )
    {
        return var1;
    }
    
    if ( var0.type == "brloot_escape_radio" || var0.type == "br_cargotrain" || var0.type == "br_cargotrain_engine" || var0.type == "br_armortrain" || var0.type == "br_armortrain_engine" || var0.type == "br_tramway" )
    {
        return 0;
    }
    
    return 1;
}

// Params 2
// Size: 0x79
function ref_11a21( var0, var1 )
{
    if ( var0 getscriptableislinked() )
    {
        return;
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = var0.type;
    }
    
    if ( usb( var0.type ) )
    {
        if ( scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            level notify( "tablethide_kill_callout_" + var0.origin );
        }
        
        scripts\mp\gametypes\br_quest_util::ref_1207a( var0 );
    }
    
    if ( var0 getscriptableisreserved() && !istrue( var0.keepinmap ) )
    {
        lastunrulyscore( var0 );
        var0 freescriptable();
        return;
    }
    
    var0 setscriptablepartstate( var1, "hidden" );
}

// Params 4
// Size: 0x1c
function br_forcegivecustomreward( var0, var1, var2, var3 )
{
    var4 = br_createcustompickupitem( var0, var1, var3 );
    onusecompleted( var0, var4, var2, undefined, 0 );
}

// Params 6
// Size: 0x48, Type: bool
function br_forcegivecustompickupitem( var0, var1, var2, var3, var4, var5 )
{
    if ( istrue( var5 ) )
    {
        minsteps( var0, var1, var3, var4, var5 );
        return true;
    }
    
    var6 = br_createcustompickupitem( var0, var1, var3 );
    var7 = cantakepickup( var0, var6 );
    
    if ( var7 == 1 )
    {
        onusecompleted( var0, var6, var2, undefined, var4 );
        return true;
    }
    
    return false;
}

// Params 3
// Size: 0xb0
function br_createcustompickupitem( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.scriptablename = var1;
    var3.origin = var0.origin;
    var3.count = 0;
    var3.maxcount = level.br_pickups.maxcounts[ var3.scriptablename ];
    var3.stackable = level.br_pickups.stackable[ var3.scriptablename ];
    
    if ( isdefined( var2 ) )
    {
        var3.count = var2;
    }
    
    if ( !var3.count && isdefined( level.br_pickups.counts[ var3.scriptablename ] ) )
    {
        var3.count = level.br_pickups.counts[ var3.scriptablename ];
    }
    
    return var3;
}

// Params 2
// Size: 0x23
function resetplayerinventorywithdelay( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    wait var0;
    resetplayerinventory( var1 );
}

// Params 1
// Size: 0x92
function resetplayerinventory( var0 )
{
    var1 = scripts\mp\utility\game::round_vehicle_logic() == "kingslayer";
    self.br_inventory_slots = [];
    
    if ( !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
    {
        scripts\mp\gametypes\br_armor::disable_map_ammo_munitions();
    }
    
    disable_near_snake_cam_after_open();
    
    if ( isdefined( self.streakdata ) && !var1 && !istrue( level.ref_133d7 ) )
    {
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    }
    
    if ( !level.allowsupers )
    {
        ref_12c81();
    }
    
    if ( !istrue( var0 ) )
    {
        scripts\mp\gametypes\br_weapons::stripweaponsfromplayer();
        scripts\mp\equipment::takeequipment( "primary" );
        scripts\mp\equipment::takeequipment( "secondary" );
        scripts\mp\weapons::ref_1316b( getcompleteweaponname( "iw8_fists_mp" ) );
    }
    
    if ( scripts\mp\gametypes\br_public::shouldgetnewspawnpoint() )
    {
        ref_12c1f();
        return;
    }
}

// Params 0
// Size: 0x1d
function ref_12c81()
{
    scripts\mp\supers::clearsuper();
    self setclientomnvar( "ui_perk_package_state", 0 );
    self setclientomnvar( "ui_super_progress", 0 );
}

// Params 1
// Size: 0x81
function resetdefaultweaponammo( var0 )
{
    var1 = self getweaponslistall();
    var2 = 0;
    
    while ( var2 < var1.size )
    {
        var3 = var1[ var2 ];
        var4 = 0;
        
        if ( var3.inventorytype == "primary" )
        {
            if ( isdefined( var0 ) )
            {
                var5 = var3.clipsize;
                var4 = var5 * ( var0 - 1 );
            }
            else if ( level.magcount > 0 )
            {
                var5 = var4.clipsize;
                var5 *= level.magcount - 1;
            }
            else
            {
                var5 = 0;
            }
            
            self setweaponammoclip( var5, var5 );
        }
        
        var4++;
    }
}

// Params 1
// Size: 0x10
function initplayer( var0 )
{
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    resetplayerinventory( var0 );
}

// Params 1
// Size: 0x15e
function spawndebugpickupfromdevgui( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( !isbot( var2 ) && isalive( var2 ) )
        {
            var3 = var2.origin + anglestoforward( var2.angles ) * 100 + ( 0, 0, 12 );
            var4 = 0;
            
            if ( isdefined( level.br_pickups.counts[ var0 ] ) )
            {
                var4 = level.br_pickups.counts[ var0 ];
            }
            
            var5 = remove_roof_nodes( var3 );
            var6 = spawnpickup( var0, var5, var4 );
            
            if ( isdefined( var6 ) )
            {
                var7 = scripts\engine\trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
                var8 = [ var6 ];
                var9 = var6.origin + ( 0, 0, 50 );
                var10 = var9 + ( 0, 0, -200 );
                var11 = scripts\engine\trace::ray_trace( var9, var10, var8, var7 );
                
                if ( isdefined( var11[ "entity" ] ) && isdefined( var11[ "entity" ].targetname ) && var11[ "entity" ].targetname == "train_wz" )
                {
                    var12 = var11[ "entity" ];
                    var13 = rotatevectorinverted( var6.origin - var12.origin, var12.angles );
                    var14 = combineangles( invertangles( var12.angles ), var6.angles );
                    var6 validatecollision( var12, var13, var14 );
                }
            }
        }
    }
}

// Params 1
// Size: 0x29, Type: bool
function isweaponpickup( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "weapon";
}

// Params 1
// Size: 0x50, Type: bool
function isweaponpickupitem( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( isdefined( var0.weapon ) )
    {
        return ( istrue( var0.weapon.iscustomweapon ) || istrue( var0.×¶ œ[÷øêRCÏßWÉW& ) );
    }
    else if ( isdefined( var0.scriptablename ) )
    {
        return isweaponpickup( var0.scriptablename );
    }
    
    return false;
}

// Params 1
// Size: 0x2d
function takearmorpickup( var0 )
{
    var1 = level.br_pickups.br_equipname[ var0.scriptablename ];
    var2 = scripts\mp\gametypes\br_armor::isarmorbetterthanequipped( var1 );
    
    if ( var2 )
    {
        tryequiparmor( var0 );
        return;
    }
}

// Params 2
// Size: 0x171
function takeequipmentpickup( var0, var1 )
{
    var2 = level.br_pickups.br_equipname[ var0.scriptablename ];
    var3 = level.equipment.table[ var2 ].defaultslot;
    var4 = 0;
    
    if ( pickupissameasequipmentslot( var2, var3 ) )
    {
        if ( equipmentslothasroom( var2, var3 ) )
        {
            if ( var3 != "health" )
            {
                scripts\mp\damagefeedback::hudicontype( "br_ammo" );
            }
            
            var5 = scripts\mp\equipment::getequipmentslotammo( var3 );
            var6 = scripts\mp\equipment::getequipmentmaxammo( var2 );
            
            if ( var5 + var0.count > var6 )
            {
                var7 = var6 - var5;
                scripts\mp\equipment::setequipmentammo( var2, var6 );
                var0.count -= var7;
                var4 = 1;
            }
            else
            {
                scripts\mp\equipment::incrementequipmentslotammo( var3, var0.count );
            }
        }
        else if ( !getdvarint( "scr_br_no_inventory", 1 ) )
        {
            trypickupitem( var0.scriptablename, var0.count );
        }
    }
    else if ( !isdefined( self.equipment[ var3 ] ) || scripts\mp\equipment::getequipmentslotammo( var3 ) == 0 )
    {
        scripts\mp\equipment::giveequipment( var2, var3 );
        scripts\mp\equipment::setequipmentammo( var2, var0.count );
    }
    else if ( !getdvarint( "scr_br_no_inventory", 1 ) )
    {
        var8 = 1;
        
        if ( isdefined( var0.count ) )
        {
            var8 = var0.count;
        }
        
        trypickupitem( var0.scriptablename, var8 );
    }
    else
    {
        var9 = test_ai_anim();
        dropequipmentinslot( var9, var3, var1 );
        scripts\mp\equipment::giveequipment( var2, var3 );
        scripts\mp\equipment::setequipmentammo( var2, var0.count );
    }
    
    return var4;
}

// Params 4
// Size: 0x75
function dropequipmentinslot( var0, var1, var2, var3 )
{
    var4 = scripts\mp\equipment::getequipmentslotammo( var1 );
    
    if ( isdefined( var3 ) )
    {
        var4 = var3;
    }
    
    var5 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, self.equipment[ var1 ] );
    
    if ( isdefined( var5 ) )
    {
        var6 = undefined;
        
        if ( istrue( var2 ) )
        {
            var6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
        }
        
        var7 = getitemdroporiginandangles( var0, self.origin, self.angles, self, var6 );
        var8 = 0;
        var9 = spawnpickup( var5, var7, var4, 1 );
        
        if ( isdefined( var9 ) )
        {
            modeloadoutupdateammo( var9, self, var5 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x25
function modeloadoutupdateammo( var0, var1 )
{
    var2 = self;
    
    if ( var1 == "brloot_offhand_geigercounter" )
    {
        var2.owner = var0;
        var0.modespawnclient = var2;
        return;
    }
}

// Params 2
// Size: 0x21, Type: bool
function pickupissameasequipmentslot( var0, var1 )
{
    if ( isdefined( self.equipment[ var1 ] ) && self.equipment[ var1 ] == var0 )
    {
        return true;
    }
    
    return false;
}

// Params 2
// Size: 0x1a, Type: bool
function equipmentslothasroom( var0, var1 )
{
    if ( scripts\mp\equipment::getequipmentslotammo( var1 ) < scripts\mp\equipment::getequipmentmaxammo( var0 ) )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x1e, Type: bool
function takerespawntokenpickup( var0 )
{
    if ( !ref_12cb6() && !scripts\mp\gametypes\br_public::hasrespawntoken() )
    {
        addrespawntoken();
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x2c
function addrespawntoken( var0 )
{
    var1 = self;
    var1.hasrespawntoken = 1;
    var1 scripts\mp\gametypes\br_public::ref_1315b( 1 );
    
    if ( !istrue( var0 ) )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_respawn_token_pickup" );
        return;
    }
}

// Params 0
// Size: 0x16
function removerespawntoken()
{
    var0 = self;
    var0.hasrespawntoken = 0;
    var0 scripts\mp\gametypes\br_public::ref_1315b( 0 );
}

// Params 1
// Size: 0x1f, Type: bool
function takegulagtokenpickup( var0 )
{
    if ( istrue( level.usegulag ) && !scripts\mp\gametypes\br_public::hasgulagtoken() )
    {
        addgulagtoken();
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x2c
function addgulagtoken( var0 )
{
    var1 = self;
    var1.†Ù4,æv«ÆÂ:½Ö²› = 1;
    var1 scripts\mp\gametypes\br_public::setcanusegulagextrainfo( 1 );
    
    if ( !istrue( var0 ) )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_gulag_token_pickup" );
        return;
    }
}

// Params 0
// Size: 0x16
function removegulagtoken()
{
    var0 = self;
    var0.†Ù4,æv«ÆÂ:½Ö²› = 0;
    var0 scripts\mp\gametypes\br_public::setcanusegulagextrainfo( 0 );
}

// Params 1
// Size: 0x15, Type: bool
function ref_13a39( var0 )
{
    if ( !scripts\mp\gametypes\br_public::shouldgetnewspawnpoint() )
    {
        bdroppingshield();
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x55
function bdroppingshield( var0 )
{
    var1 = self;
    var1.shouldgetnewspawnpoint = 1;
    var1 scripts\mp\gametypes\br_public::ref_1315c( 1 );
    
    if ( !istrue( var0 ) )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_self_revive_token_pickup" );
    }
    
    var2 = level.maxteamsize == 1;
    
    if ( var2 && !var1 scripts\mp\utility\perk::_hasperk( "specialty_pistoldeath" ) )
    {
        var1 scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
        return;
    }
}

// Params 0
// Size: 0x40
function ref_12c1f()
{
    var0 = self;
    var0.shouldgetnewspawnpoint = 0;
    var0 scripts\mp\gametypes\br_public::ref_1315c( 0 );
    var1 = level.maxteamsize == 1;
    
    if ( var1 && var0 scripts\mp\utility\perk::_hasperk( "specialty_pistoldeath" ) )
    {
        var0 scripts\mp\utility\perk::removeperk( "specialty_pistoldeath" );
        return;
    }
}

// Params 0
// Size: 0x44, Type: bool
function ref_12cb6()
{
    return getdvarint( "scr_br_all_assassin_version", 0 ) || !istrue( level.br_pickups.ref_12cb7 ) || istrue( level.br_pickups.ref_12cb5 ) && isdefined( level.gulag ) && istrue( level.gulag.shutdown );
}

// Params 1
// Size: 0x43
function battle_tracks_tryplayingbattletrackswhenstandingonvehicle( var0 )
{
    var1 = self;
    self playsoundtoplayer( "br_legendary_loot_pickup", self );
    var1.should_use_velo_forward = 1;
    var1 setclientomnvar( "ui_br_has_plate_pouch", 1 );
    var1 scripts\mp\gametypes\br_public::sethasplatepouchextrainfo( 1 );
    
    if ( !istrue( var0 ) )
    {
        var1 thread scripts\mp\hud_message::showsplash( "br_plate_pouch_pickup" );
        return;
    }
}

// Params 0
// Size: 0x21
function ref_12c16()
{
    var0 = self;
    var0 setclientomnvar( "ui_br_has_plate_pouch", 0 );
    var0 scripts\mp\gametypes\br_public::sethasplatepouchextrainfo( 0 );
    var0.should_use_velo_forward = 0;
}

// Params 0
// Size: 0x85
function play_hud_reminder_vo()
{
    var0 = self;
    var1 = spawnstruct();
    var1.scriptablename = "brloot_armor_plate";
    var1.nvgvisionsetoverride = level.br_pickups.br_equipname[ var1.scriptablename ];
    var1.origin = self.origin;
    var1.maxcount = scripts\mp\equipment::getequipmentmaxammo( var1.nvgvisionsetoverride );
    var1.count = var1.maxcount;
    var1.stackable = level.br_pickups.stackable[ var1.scriptablename ];
    takeequipmentpickup( var0, var1 );
}

// Params 1
// Size: 0x47
function ref_13a2f( var0 )
{
    if ( scripts\mp\gametypes\br_public::should_damage_pavelow_boss() )
    {
        var1 = test_ai_anim();
        var2 = undefined;
        var3 = getitemdroporiginandangles( var1, self.origin, self.angles, self, var2 );
        spawnpickup( self.armorylights, var3, 1, 1 );
    }
    
    battle_tracks_getbattletracksid( var0.scriptablename );
}

// Params 1
// Size: 0x9c
function takesecretwinebottle( var0 )
{
    if ( !isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[› ) )
    {
        self.£ækX±c¾-æX›Œ×mÊË×K£•[› = [];
    }
    
    if ( !isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] ) )
    {
        self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] = 1;
        return;
    }
    
    if ( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] >= level.“æsIÑKíO ÓØ§ÏË%ë
ÕÛùÿ Ëƒ I.¥å—×Óóè5Pˆu˜8ËQ/[ "secret_bottle" ] )
    {
        var1 = test_ai_anim();
        var2 = undefined;
        var3 = getitemdroporiginandangles( var1, self.origin, self.angles, self, var2 );
        spawnpickup( "brloot_dropped_secret_bottle", var3, 1, 1 );
        return;
    }
    
    self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] = self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] + 1;
}

// Params 1
// Size: 0xbe
function takesecretshovel( var0 )
{
    if ( !isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[› ) )
    {
        self.£ækX±c¾-æX›Œ×mÊË×K£•[› = [];
    }
    
    if ( !isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] ) )
    {
        self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] = 1;
        
        foreach ( var2 in level.hÄ®äÒ+Œ}ÑN²…Í«äVë´ÆÊÜ )
        {
            var2 enablescriptablepartplayeruse( "secret_burried_treasure", self );
            var2 disablescriptablepartplayeruse( "secret_burried_treasure_no_shovel", self );
        }
        
        return;
    }
    
    if ( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] >= level.“æsIÑKíO ÓØ§ÏË%ë
ÕÛùÿ Ëƒ I.¥å—×Óóè5Pˆu˜8ËQ/[ "shovel" ] )
    {
        var4 = test_ai_anim();
        var5 = undefined;
        var6 = getitemdroporiginandangles( var4, self.origin, self.angles, self, var5 );
        spawnpickup( "brloot_dropped_secret_shovel", var6, 1, 1 );
        return;
    }
}

// Params 1
// Size: 0x36
function battle_tracks_getbattletracksid( var0 )
{
    var1 = self;
    var1.armorylights = var0;
    var2 = int( tablelookup( "mp/braccess_card.csv", 1, var0, 0 ) );
    var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "bunkerKeycardType", var2 );
    var1 scripts\mp\gametypes\br_alt_mode_zai::ref_11ff9( var0 );
}

// Params 0
// Size: 0x33
function ref_12bfc()
{
    var0 = self;
    
    if ( getdvarint( "scr_br_bunkersNoKeycardRequired", 0 ) )
    {
    }
    
    var0 scripts\mp\gametypes\br_alt_mode_zai::ref_1207d( var0.armorylights );
    var0.armorylights = undefined;
    var0 scripts\mp\gametypes\br_public::updatebrscoreboardstat( "bunkerKeycardType", 0 );
}

// Params 1
// Size: 0x18
function ref_13a33( var0 )
{
    var1 = var0.scriptablename;
    
    if ( var1 == "brloot_x1_map_fragment" )
    {
        return;
    }
}

// Params 1
// Size: 0x20
function takequestitem( var0 )
{
    var1 = var0.scriptablename;
    
    if ( var1 == "brloot_x2_stash_bomb" )
    {
        var0 scripts\mp\gametypes\br_x2_stash_quest::ref_14654( self );
        return;
    }
}

// Params 1
// Size: 0x38
function battle_tracks_togglethink( var0 )
{
    var1 = self;
    var2 = scripts\mp\perks\perks::hudcost( var0.scriptablename );
    self playsoundtoplayer( "br_legendary_loot_pickup", self );
    
    if ( isdefined( var2 ) && var2 != "" )
    {
        var1 scripts\mp\perks\perks::battle_tracks_tryinittogglestate( var2 );
        return;
    }
}

// Params 1
// Size: 0x35
function bearsetup( var0 )
{
    var1 = self;
    self playsoundtoplayer( "br_legendary_loot_pickup", self );
    var1.should_enter_combat_after_checking_decoy_grenade = 1;
    var1 scripts\mp\perks\perks::bears();
    
    if ( !istrue( var0 ) )
    {
        var1 thread scripts\mp\hud_message::showsplash( "specialist_perk_bonus" );
        return;
    }
}

// Params 0
// Size: 0x15
function ref_12c26()
{
    var0 = self;
    var0.should_enter_combat_after_checking_decoy_grenade = 0;
    var0 scripts\mp\perks\perks::ref_12c25();
}

// Params 4
// Size: 0x55
function playerpackdataintogulagomnvar( var0, var1, var2, var3 )
{
    self notify( "cancel_all_killstreak_deployments" );
    
    if ( istrue( var3 ) )
    {
        var4 = test_ai_anim();
        missing_window_blockers( var4, var2, var3, var0 );
        return;
    }
    
    if ( istrue( var2 ) )
    {
        var4 = test_ai_anim();
        missing_window_blockers( var4, var3 );
    }
    else
    {
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    }
    
    scripts\mp\killstreaks\killstreaks::awardkillstreak( var1, "other", undefined, undefined, undefined, 1 );
}

// Params 2
// Size: 0x47
function takekillstreakpickup( var0, var1 )
{
    if ( isdefined( var0 ) && isdefined( var0.tracknonoobplayerlocation ) && isdefined( var0.tracknonoobplayerlocation.spawnprojectile ) )
    {
        self.spawnx1stashlootcache = var0.tracknonoobplayerlocation.spawnprojectile;
    }
    
    send_notify_after_player_tac_vis( var0.scriptablename, var1 );
}

// Params 2
// Size: 0x30
function send_notify_after_player_tac_vis( var0, var1 )
{
    var2 = level.br_pickups.br_killstreakreference[ var0 ];
    
    if ( unset_relic_dogtags( var2 ) )
    {
        playerkilledspawn( var2 );
        return;
    }
    
    playerpackdataintogulagomnvar( var2, 1, var1 );
}

// Params 0
// Size: 0x3d, Type: bool
function should_do_vo_call()
{
    if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks ) && self.streakdata.streaks.size > 0 )
    {
        return isdefined( self.streakdata.streaks[ 1 ] );
    }
    
    return false;
}

// Params 1
// Size: 0x22, Type: bool
function haskillstreak( var0 )
{
    return should_do_vo_call() && self.streakdata.streaks[ 1 ].streakname == var0;
}

// Params 0
// Size: 0xd, Type: bool
function show_getcash_hint()
{
    return haskillstreak( "explosive_bow" );
}

// Params 1
// Size: 0x21
function unset_relic_dogtags( var0 )
{
    var1 = 0;
    
    switch ( var0 )
    {
        case "circle_peek":
            var1 = 1;
            break;
    }
    
    return var1;
}

// Params 1
// Size: 0x29
function playerkilledspawn( var0 )
{
    var1 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo( var0 );
    
    if ( isdefined( var1 ) && isdefined( var1.linkedtotag ) )
    {
        self [[ var1.linkedtotag ]]();
        return;
    }
}

// Params 1
// Size: 0x45
function forceusekillstreak( var0 )
{
    if ( should_do_vo_call() )
    {
        scripts\mp\killstreaks\killstreaks::removekillstreak( 1 );
    }
    
    scripts\mp\killstreaks\killstreaks::awardkillstreak( var0, "other", undefined, undefined, undefined, 1 );
    var1 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot( 1 );
    var2 = scripts\mp\killstreaks\killstreaks::triggerkillstreak( var1, 1 );
    
    if ( !var2 )
    {
        scripts\mp\killstreaks\killstreaks::removekillstreak( 1 );
    }
    
    return var2;
}

// Params 3
// Size: 0x7d
function _givebrsuper( var0, var1, var2 )
{
    if ( level.allowsupers )
    {
        scripts\mp\perks\perkpackage::ref_12300( var1 );
        var2 = scripts\mp\supers::getcurrentsuperpoints() >= scripts\mp\supers::getsuperpointsneeded();
    }
    else
    {
        scripts\mp\perks\perkpackage::perkpackage_giveimmediate( var1 );
        self setclientomnvar( "ui_perk_package_state", 3 );
        self setclientomnvar( "ui_perk_package_super1", scripts\mp\supers::getsuperid( var1 ) );
        self setclientomnvar( "ui_super_progress", 1 );
    }
    
    if ( isdefined( var0 ) )
    {
        scripts\mp\equipment::giveequipment( var0, "super" );
        scripts\mp\equipment::setequipmentammo( var0, var2 );
        
        if ( istrue( self.issuperdisabled ) )
        {
            self.loadoutextraperksfromgamemode = var2;
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0xc7
function takesuperpickup( var0, var1 )
{
    var2 = level.br_pickups.br_equipname[ var0.scriptablename ];
    var3 = level.br_pickups.br_superreference[ var0.scriptablename ];
    var4 = undefined;
    
    if ( isdefined( self.equipment[ "super" ] ) )
    {
        var4 = scripts\mp\equipment::getequipmentslotammo( "super" );
        
        if ( !isdefined( var4 ) )
        {
            scripts\mp\utility\script::laststand_dogtags( "Player has super,  " + self.equipment[ "super" ] + ", but ammo is undefined." );
        }
    }
    
    if ( isdefined( self.equipment[ "super" ] ) && isdefined( var4 ) && ( var4 > 0 || mortar_add_fov_user_scale() ) )
    {
        var5 = test_ai_anim();
        dropequipmentinslot( var5, "super", var1 );
    }
    
    _givebrsuper( var2, var3, var0.count );
    
    if ( level.allowsupers )
    {
        scripts\mp\supers::givesuperpoints( scripts\mp\supers::getsuperpointsneeded() );
        return;
    }
}

// Params 0
// Size: 0x28, Type: bool
function mortar_add_fov_user_scale()
{
    if ( istrue( self.unmark_on_death ) )
    {
        if ( isdefined( self.super ) && !self.super.usepercent )
        {
            return true;
        }
    }
    
    return false;
}

// Params 4
// Size: 0xb6
function forcegivesuper( var0, var1, var2, var3 )
{
    var4 = undefined;
    
    foreach ( var6 in level.br_pickups.br_superreference )
    {
        if ( var6 == var0 )
        {
            var4 = var7;
            break;
        }
    }
    
    var8 = undefined;
    
    if ( isdefined( var4 ) )
    {
        var8 = level.br_pickups.br_equipname[ var4 ];
        
        if ( istrue( var3 ) )
        {
            var9 = test_ai_anim();
            mintokensdropondeath( var9, var2, var3, var8 );
            return;
        }
        
        if ( istrue( var2 ) )
        {
            if ( isdefined( self.equipment[ "super" ] ) && scripts\mp\equipment::getequipmentslotammo( "super" ) > 0 )
            {
                var9 = test_ai_anim();
                dropequipmentinslot( var9, "super", var3 );
            }
        }
    }
    
    _givebrsuper( var9, var1, 1 );
}

// Params 2
// Size: 0x82
function takegasmask( var0, var1 )
{
    if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
    {
        var2 = undefined;
        
        if ( istrue( var1 ) )
        {
            var2 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
        }
        
        var3 = test_ai_anim();
        var4 = getitemdroporiginandangles( var3, self.origin, self.angles, self, var2 );
        spawnpickup( self.plundersilentcountdownendtime, var4, int( self.gasmaskhealth ), 1 );
    }
    
    scripts\cp_mp\gasmask::init( var0.count, var0.scriptablename );
    
    if ( scripts\cp_mp\gasmask::unlocked_escape_door( var0.scriptablename ) )
    {
        scripts\mp\gametypes\br_public::sethasgasmaskextrainfo( 2 );
        return;
    }
    
    scripts\mp\gametypes\br_public::sethasgasmaskextrainfo( 1 );
}

// Params 1
// Size: 0x2f
function plunderrepositoryref( var0 )
{
    if ( !isdefined( self.plunderrepositorywidget ) )
    {
        self.plunderrepositorywidget = [];
    }
    
    if ( isdefined( self.plunderrepositorywidget[ var0 ] ) )
    {
        return;
    }
    
    self.plunderrepositorywidget[ var0 ] = 1;
    thread ai_push_forward_watcher();
}

// Params 1
// Size: 0x2c
function plunderrankupdate( var0 )
{
    if ( !isdefined( self.plunderrepositorywidget ) )
    {
        self.plunderrepositorywidget = [];
    }
    
    if ( !isdefined( self.plunderrepositorywidget[ var0 ] ) )
    {
        return;
    }
    
    self.plunderrepositorywidget[ var0 ] = undefined;
    thread ai_push_forward_watcher();
}

// Params 0
// Size: 0x9a
function ai_push_forward_watcher()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !istrue( level.±‚À‹X3Û<å`²aÄ7xë<‘ ) )
    {
        var0 = self method_87eb();
        
        if ( var0 )
        {
            return;
        }
    }
    
    if ( istrue( self.gasmaskswapinprogress ) )
    {
        scripts\engine\utility::waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
        waitframe();
    }
    
    self notify( "gasMaskUpdateOnOff" );
    self endon( "gasMaskUpdateOnOff" );
    waittillframeend();
    
    if ( istrue( self.gasmaskequipped ) && ( !isdefined( self.plunderrepositorywidget ) || !self.plunderrepositorywidget.size ) )
    {
        thread ref_12c05();
        return;
    }
    
    if ( !istrue( self.gasmaskequipped ) && isdefined( self.plunderrepositorywidget ) && self.plunderrepositorywidget.size )
    {
        thread numkilled();
        return;
    }
}

// Params 1
// Size: 0x2a
function ks_circlecount( var0 )
{
    var1 = 0;
    var1 |= var0 isreloading();
    var1 |= var0 isthrowinggrenade();
    
    if ( level.¡$Àê"Û)Ç{§-[£‘‘ó != 0 )
    {
        var1 |= var0 scripts\mp\utility\player::isplayerads();
    }
    
    return var1;
}

// Params 0
// Size: 0x55, Type: bool
function get_area_clear_alias()
{
    var0 = 0;
    var1 = self;
    var0 |= var1 scripts\cp_mp\utility\player_utility::isinvehicle( 1 );
    var0 |= var1 isinfreefall();
    var0 |= var1 isparachuting();
    var0 |= var1 setautoboxcalculationusingdobj();
    
    if ( level.Ž•,éfµá§"Å[5‹èÃ?«Úh[ != 0 && ( !playerhasgasmasktoggle( var1 ) || level.“ö;XÍ­…nÚ5®¶àæm-8Ö,7®± != 0 ) )
    {
        var0 |= var1 isjumping();
    }
    
    return !var0;
}

// Params 0
// Size: 0x17
function playerhasgasmasktoggle()
{
    if ( !getdvarint( "OLLNLPLRR" ) )
    {
        var0 = self method_87eb();
        return var0;
    }
    
    return 0;
}

// Params 0
// Size: 0xc8
function numkilled()
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self playsoundtoplayer( "br_gas_mask_on_plr", self );
    self.gasmaskswapinprogress = 1;
    thread kiosksetupfiresaleforplayer( 0.2 );
    var0 = self getgestureanimlength( "ges_magma_gas_mask_on" );
    
    if ( get_area_clear_alias() )
    {
        thread ref_12735( "iw8_ges_plyr_gasmask_on", var0 );
    }
    
    self setclientomnvar( "ui_gas_mask", 2 );
    wait var0;
    self.gasmaskswapinprogress = 0;
    self notify( "gas_mask_swap_complete" );
    self.gasmaskequipped = 1;
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self method_87aa( "gasmask_female" );
    }
    else
    {
        self method_87aa( "gasmask_male" );
    }
    
    if ( isdefined( self.gasmaskhealth ) && self.gasmaskhealth <= 0 )
    {
        disable_near_snake_cam_after_open();
        return;
    }
}

// Params 2
// Size: 0x5c
function ref_12735( var0, var1 )
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var2 = getcompleteweaponname( var0 );
    self giveandfireoffhand( var2 );
    
    while ( get_area_clear_alias() && var1 > 0 )
    {
        if ( var1 > 1 )
        {
            var3 = 1;
            var1 -= 1;
        }
        else
        {
            var3 = var1;
            var1 = 0;
        }
        
        wait var3;
    }
    
    if ( self hasweapon( var2 ) )
    {
        self takeweapon( var2 );
        return;
    }
}

// Params 0
// Size: 0xd7
function ref_12c05()
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !istrue( self.gasmaskequipped ) )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
    var0 = self getgestureanimlength( "ges_magma_gas_mask_off" );
    thread knock_player_forward( 1.3 );
    
    if ( get_area_clear_alias() )
    {
        thread ref_12735( "iw8_ges_plyr_gasmask_off", var0 );
    }
    
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 1 );
    wait var0;
    self.gasmaskswapinprogress = 0;
    self setclientomnvar( "ui_gas_mask", 0 );
    self notify( "gas_mask_swap_complete" );
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self method_87aa( "female" );
    }
    else
    {
        self method_87aa( "" );
    }
    
    if ( !isdefined( self.gasmaskhealth ) || self.gasmaskhealth <= 0 )
    {
        handleweaponreloadammodrop();
        return;
    }
}

// Params 0
// Size: 0xf7
function disable_near_snake_cam_after_open()
{
    if ( !istrue( self.gasmaskequipped ) )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_crack_plr", self );
    thread kothlaststarttime( 0.6 );
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self method_87aa( "female" );
    }
    else
    {
        self method_87aa( "" );
    }
    
    self playsoundtoplayer( "br_gas_mask_depleted_plr", self );
    handleweaponreloadammodrop();
    var0 = self getgestureanimlength( "ges_magma_gas_mask_break" );
    
    if ( self isonground() )
    {
        thread scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_gasmask_break", var0 );
    }
    else
    {
        var1 = self.origin;
        var2 = scripts\mp\gametypes\br_public::modifytriggerlocation( var1, 0, -100000 );
        var3 = var1[ 2 ] - var2[ "position" ][ 2 ];
        
        if ( var3 < getdvarfloat( "scr_br_gasmask_animation_max_height", 40 ) )
        {
            thread scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_gasmask_break", var0 );
        }
    }
    
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 3 );
    wait var0;
    self.gasmaskswapinprogress = 0;
    self notify( "gas_mask_swap_complete" );
}

// Params 1
// Size: 0x32
function kiosksetupfiresaleforplayer( var0 )
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( isdefined( var0 ) && var0 > 0 )
    {
        wait var0;
    }
    
    self attach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
}

// Params 1
// Size: 0x41
function knock_player_forward( var0 )
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( isdefined( var0 ) && var0 > 0 )
    {
        wait var0;
    }
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
        return;
    }
}

// Params 1
// Size: 0x61
function kothlaststarttime( var0 )
{
    self endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( isdefined( var0 ) && var0 > 0.1 )
    {
        wait var0 - 0.1;
    }
    
    playfxontag( scripts\engine\utility::getfx( "vfx_gas_mask_break" ), self, "tag_weapon_left" );
    wait 0.1;
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
        return;
    }
}

// Params 2
// Size: 0x5b
function playergasmasktoggle( var0, var1 )
{
    if ( !getdvarint( "OLLNLPLRR" ) )
    {
        if ( var0 == "gas_mask_toggle" && scripts\cp_mp\gasmask::hasgasmask( self ) && !istrue( self.gasmaskswapinprogress ) )
        {
            var2 = self method_87eb();
            
            if ( var2 )
            {
                if ( istrue( self.gasmaskequipped ) )
                {
                    thread ref_12c05();
                    return;
                }
                
                if ( !istrue( self.gasmaskequipped ) )
                {
                    thread numkilled();
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x1b, Type: bool
function canholdammobox( var0 )
{
    if ( !isdefined( self.br_ammo[ var0 ] ) )
    {
        return true;
    }
    
    return !scripts\mp\gametypes\br_weapons::br_ammo_type_player_full( self, var0 );
}

// Params 1
// Size: 0x36, Type: bool
function isvest( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "armor" && issubstr( var0, "vest" );
}

// Params 1
// Size: 0x36, Type: bool
function isgasmask( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "gear" && issubstr( var0, "gasmask" );
}

// Params 1
// Size: 0x36, Type: bool
function usereload( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "specialist" && issubstr( var0, "specialist_bonus" );
}

// Params 1
// Size: 0x29, Type: bool
function isplunder( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "plunder";
}

// Params 1
// Size: 0x29, Type: bool
function usb( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "tablet";
}

// Params 1
// Size: 0x29, Type: bool
function uniquelootitemlookup( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "questitem_dogtag";
}

// Params 1
// Size: 0x29, Type: bool
function usablecarriables( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "questitem_misc";
}

// Params 1
// Size: 0x29, Type: bool
function isperkpointpickup( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "perkpoint";
}

// Params 1
// Size: 0x29, Type: bool
function istokenpickup( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "token";
}

// Params 1
// Size: 0x29, Type: bool
function use_milcrate( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "revive";
}

// Params 1
// Size: 0x3f, Type: bool
function iskillstreak( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && ( level.br_pickups.br_itemtype[ var0 ] == "killstreak" || level.br_pickups.br_itemtype[ var0 ] == "killstreak_nodrop" );
}

// Params 1
// Size: 0x49, Type: bool
function issuperpickup( var0 )
{
    return !update_operator_east_char_loc( var0 ) && isdefined( level.br_pickups.br_itemtype[ var0 ] ) && ( level.br_pickups.br_itemtype[ var0 ] == "super" || level.br_pickups.br_itemtype[ var0 ] == "super_nodrop" );
}

// Params 1
// Size: 0xc, Type: bool
function isplunderextract( var0 )
{
    return var0 == "brloot_plunder_extract";
}

// Params 1
// Size: 0xc, Type: bool
function updatecollectionui( var0 )
{
    return var0 == "brloot_plate_pouch";
}

// Params 1
// Size: 0xe
function turn_on_red_lights_along_track( var0 )
{
    return issubstr( var0, "access_card" );
}

// Params 1
// Size: 0x16, Type: bool
function update_operator_east_char_loc( var0 )
{
    return var0 == "br_loot_cache" || usb( var0 );
}

// Params 1
// Size: 0x29, Type: bool
function update_player_about_remaining_enemies( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "objective";
}

// Params 1
// Size: 0x29, Type: bool
function isinteltype( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && level.br_pickups.br_itemtype[ var0 ] == "intel";
}

// Params 1
// Size: 0x1d, Type: bool
function issecretwinebottle( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && var0 == "brloot_dropped_secret_bottle";
}

// Params 1
// Size: 0x1d, Type: bool
function issecretshovel( var0 )
{
    return isdefined( level.br_pickups.br_itemtype[ var0 ] ) && var0 == "brloot_dropped_secret_shovel";
}

// Params 1
// Size: 0xa4a
function cantakepickup( var0 )
{
    if ( self isskydiving() )
    {
        return 9;
    }
    
    var1 = scripts\mp\gametypes\br_gametypes::ref_12e05( "canTakePickupLoot", var0 );
    
    if ( isdefined( var1 ) )
    {
        return var1;
    }
    
    if ( scripts\mp\gametypes\br_public::isammo( var0.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback() )
        {
            return 16;
        }
        
        if ( !canholdammobox( var0.scriptablename ) )
        {
            return 3;
        }
        else
        {
            return 1;
        }
    }
    
    if ( isweaponpickupitem( var0 ) )
    {
        if ( istrue( self.isjuggernaut ) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback() )
        {
            return 16;
        }
        
        if ( istrue( self.tracking_max_health ) )
        {
            return 13;
        }
        
        if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
        {
            return 17;
        }
        
        if ( _debug_rooftop_activesat::closedangles() )
        {
            return 21;
        }
        
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_public::isequipment( var0.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( var0.scriptablename == "brloot_offhand_geigercounter" )
        {
            if ( self != var0.tracknonoobplayerlocation.owner )
            {
                return 20;
            }
            else
            {
                self.modespawnclient = undefined;
            }
        }
        
        var2 = level.br_pickups.br_equipname[ var0.scriptablename ];
        var3 = level.equipment.table[ var2 ].defaultslot;
        var4 = istrue( var0.turretsactive );
        
        if ( !isdefined( var3 ) )
        {
            scripts\mp\utility\script::laststand_dogtags( "No slot found for equipment : scriptableName = " + var0.scriptablename + ", equipName = " + scripts\engine\utility::ter_op( isdefined( var2 ), var2, "?" ) );
            return 4;
        }
        
        var5 = 1;
        
        if ( isdefined( var0.count ) )
        {
            var5 = var0.count;
        }
        
        if ( var4 && ( var3 == "primary" || var3 == "secondary" ) )
        {
            if ( isdefined( self.equipment[ var3 ] ) && pickupissameasequipmentslot( var2, var3 ) && equipmentslothasroom( var2, var3 ) )
            {
                return 1;
            }
            
            return 12;
        }
        
        if ( !isdefined( self.equipment[ var3 ] ) || scripts\mp\equipment::getequipmentslotammo( var3 ) == 0 )
        {
            return 1;
        }
        
        if ( pickupissameasequipmentslot( var2, var3 ) )
        {
            if ( equipmentslothasroom( var2, var3 ) )
            {
                return 1;
            }
            else if ( getdvarint( "scr_br_no_inventory", 1 ) )
            {
                return 4;
            }
        }
        
        if ( getdvarint( "scr_br_no_inventory", 1 ) )
        {
            return 1;
        }
        
        if ( !canslotitem( var0.scriptablename, var5 ) )
        {
            return 4;
        }
        else
        {
            return 1;
        }
    }
    
    if ( isplunder( var0.scriptablename ) )
    {
        if ( isdefined( level.br_plunder ) && isdefined( level.br_plunder.ref_127bf ) && self.plundercount >= level.br_plunder.ref_127bf )
        {
            return 11;
        }
        
        return 1;
    }
    
    if ( isgasmask( var0.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        return 1;
    }
    
    if ( usb( var0.scriptablename ) )
    {
        if ( var0.scriptablename == "brloot_blueprintextract_tablet" || var0.scriptablename == "brloot_blueprintextract_tablet_easterevent" )
        {
            return 1;
        }
        else if ( istrue( level.questinfo.ref_132e8 ) && scripts\engine\utility::array_contains( level.questinfo.ref_13745, self.team + self.squadindex ) || scripts\engine\utility::array_contains( level.questinfo.teamsonquests, self.team ) )
        {
            return 10;
        }
        else
        {
            logstring( "Quest Tablet picked up at " + gettime() + ", team = " + self.team + ", shouldApplyToSquad = " + istrue( level.questinfo.ref_132e8 ) + ", squadIndex = " + scripts\engine\utility::ter_op( isdefined( self.squadindex ), self.squadindex, -1 ) );
            return 1;
        }
    }
    
    if ( isperkpointpickup( var0.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        var6 = scripts\mp\perks\perks::hudcost( var0.scriptablename );
        
        if ( !getdvarint( "scr_perk_point_duplicates_allowed", 0 ) && scripts\mp\utility\perk::_hasperk( var6 ) )
        {
            return 27;
        }
        
        if ( var6 == "specialty_warhead" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_amped_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_tac_resist" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_battle_hardened_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_br_advancedscout" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_combat_scout_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_tactical_recon" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_engineer_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_extra_shrapnel" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_shrapnel_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_tune_up" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_tune_up_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_huntmaster" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_tracker_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_guerrilla" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_ghost_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_hardline" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_hardline_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_surveillance" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_high_alert_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_munitions_2" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_overkill_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_strategist" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_pointman_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_restock" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_restock_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_br_reinforced" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_tempered_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_quick_fix" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_quick_fix_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_covert_ops" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_cold_blooded_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_hustle" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_double_time_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_eod" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_eod_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_heavy_metal" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_kill_chain_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_scavenger_plus" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_scavenger_perk_loot", 0, 0 );
        }
        
        if ( var6 == "specialty_br_serpentine" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_serpentine_perk_loot", 0, 0 );
        }
        
        if ( var6 == "yellow" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_yellow_perks_loot", 0, 0 );
        }
        
        if ( var6 == "red" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_red_perks_loot", 0, 0 );
        }
        
        if ( var6 == "blue" )
        {
            thread scripts\mp\events::killeventtextpopup( "br_blue_perks_loot", 0, 0 );
        }
        
        return 1;
    }
    
    if ( istokenpickup( var1.scriptablename ) )
    {
        var7 = var1.scriptablename == "brloot_hvv_hero_token";
        var8 = var1.scriptablename == "brloot_hvv_villain_token";
        var9 = var7 || var8;
        
        if ( istrue( self.isjuggernaut ) && !var9 )
        {
            return 16;
        }
        
        if ( var1.scriptablename == "brloot_redeploy_token" )
        {
            if ( scripts\mp\gametypes\br_public::hasrespawntoken() )
            {
                return 8;
            }
            else
            {
                return 1;
            }
        }
        
        if ( var1.scriptablename == "brloot_gulag_token" )
        {
            if ( scripts\mp\gametypes\br_public::hasgulagtoken() || scripts\mp\gametypes\br_gulag::checkgulagusecount() )
            {
                return 28;
            }
            else
            {
                return 1;
            }
        }
        
        var4 = istrue( var1.turretsactive );
        
        if ( var9 )
        {
            if ( var4 )
            {
                if ( isdefined( self.ˆÆÆ°›£Cè{¶•Í ) )
                {
                    if ( self.ˆÆÆ°›£Cè{¶•Í == 1 && var7 || self.ˆÆÆ°›£Cè{¶•Í == 2 && var8 )
                    {
                        return 1;
                    }
                }
                
                return 12;
            }
            else
            {
                return 1;
            }
        }
        
        return 1;
    }
    
    if ( use_milcrate( var9.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( var9.scriptablename == "brloot_self_revive" )
        {
            if ( scripts\mp\gametypes\br_public::shouldgetnewspawnpoint() )
            {
                return 14;
            }
            else
            {
                return 1;
            }
        }
        
        return 1;
    }
    
    if ( iskillstreak( var9.scriptablename ) )
    {
        var10 = level.br_pickups.br_killstreakreference[ var9.scriptablename ];
        
        if ( var9.scriptablename == "brloot_specialist_bonus" && scripts\mp\gametypes\br_public::shouldlink() )
        {
            return 18;
        }
        
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( unset_relic_dogtags( var10 ) )
        {
            if ( var10 == "circle_peek" )
            {
                if ( !isdefined( level.ref_13aca[ self.team ] ) )
                {
                    level.ref_13aca[ self.team ] = 0;
                }
                
                var11 = level.ref_13aca[ self.team ] + level.br_circle.circleindex + 1;
                
                if ( var11 >= level.gulag_tutorial_vo.size )
                {
                    return 19;
                }
            }
            
            return 1;
        }
        
        if ( scripts\mp\utility\weapon::iskillstreakweapon( self getcurrentweapon() ) )
        {
            return 7;
        }
        
        if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks ) && self.streakdata.streaks.size > 0 && self.streakdata.streaks[ 1 ].streakname == level.br_pickups.br_killstreakreference[ var9.scriptablename ] )
        {
            return 7;
        }
        else
        {
            return 1;
        }
    }
    
    if ( issuperpickup( var9.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( scripts\mp\supers::issuperinuse() )
        {
            return 4;
        }
        
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_public::isarmor( var9.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( scripts\mp\gametypes\br_armor::isarmorbetterthanequipped( level.br_pickups.br_equipname[ var9.scriptablename ] ) )
        {
            return 1;
        }
        else
        {
            return 6;
        }
    }
    
    if ( updatecollectionui( var9.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( getdvarint( "scr_enablePouchRecycle", 0 ) == 1 && isdefined( var9.tracknonoobplayerlocation ) )
        {
            if ( scripts\mp\gametypes\br_public::should_use_velo_forward() )
            {
                var12 = scripts\engine\utility::ter_op( isdefined( self.equipment[ "health" ] ), scripts\mp\equipment::getequipmentslotammo( "health" ), 0 );
                var13 = scripts\mp\equipment::getequipmentmaxammo( level.br_pickups.br_equipname[ "brloot_armor_plate" ] );
                var14 = var9.tracknonoobplayerlocation.count;
                
                if ( var12 >= var13 )
                {
                    return 4;
                }
                else if ( var14 <= 0 )
                {
                    return 26;
                }
                else
                {
                    thread playerplaypickupanim( var9 );
                    play_hit_marker_to_player( var9, 0 );
                    return 25;
                }
            }
            else
            {
                return 1;
            }
        }
        
        if ( scripts\mp\gametypes\br_public::should_use_velo_forward() )
        {
            return 15;
        }
        else
        {
            return 1;
        }
    }
    
    if ( turn_on_red_lights_along_track( var9.scriptablename ) )
    {
        return 1;
    }
    
    if ( issecretwinebottle( var9.scriptablename ) )
    {
        return 1;
    }
    
    if ( issecretshovel( var9.scriptablename ) )
    {
        return 1;
    }
    
    if ( usablecarriables( var9.scriptablename ) )
    {
        if ( isdefined( var9.tracknonoobplayerlocation.team ) && self.team == var9.tracknonoobplayerlocation.team )
        {
            return 1;
        }
        else
        {
            return 4;
        }
    }
    
    if ( usereload( var9.scriptablename ) )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        if ( scripts\mp\gametypes\br_public::shouldlink() )
        {
            return 18;
        }
        
        return 1;
    }
    
    if ( var9.scriptablename == "brloot_ammo_grenade" )
    {
        if ( istrue( self.isjuggernaut ) )
        {
            return 16;
        }
        
        var15 = scripts\mp\equipment::getequipmentslotammo( "primary" );
        var16 = scripts\mp\equipment::getequipmentslotammo( "secondary" );
        
        if ( isdefined( var15 ) && var15 < 2 || isdefined( var16 ) && var16 < 2 )
        {
            return 1;
        }
        else
        {
            return 3;
        }
    }
    
    if ( var9.scriptablename == "Pillage_Cache" )
    {
        return 1;
    }
    
    if ( update_player_about_remaining_enemies( var9.scriptablename ) || isinteltype( var9.scriptablename ) )
    {
        return 1;
    }
    
    return 2;
}

// Params 1
// Size: 0x25, Type: bool
function unlocked_armory( var0 )
{
    if ( scripts\mp\weapons::isfistweapon( var0 ) || scripts\mp\utility\weapon::unset_relic_mythic( var0 ) || scripts\mp\utility\weapon::update_health_bar_to_player( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x3c
function uavfastsweepid( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return 0;
    }
    
    switch ( var0 )
    {
        case "brloot_tactical_device":
        case "brloot_x1_stash_cypher":
        case "brloot_x2_stash_bomb":
        case "brloot_offhand_geigercounter":
            return 1;
        default:
            return 0;
    }
}

// Params 8
// Size: 0x334
function spawnpickup( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    if ( var1.origin == ( 0, 0, 0 ) )
    {
        return;
    }
    
    var8 = 0;
    var9 = undefined;
    
    if ( isdefined( level.br_pickups.br_weapontoscriptable[ var0 ] ) )
    {
        var9 = level.br_pickups.br_weapontoscriptable[ var0 ];
    }
    else if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var4 ) && scripts\mp\riotshield::isriotshield( var4 ) )
    {
        var8 = 1;
        var9 = "brloot_weapon_me_riotshield";
    }
    else if ( scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var4 ) )
    {
        var10 = undefined;
        
        if ( getsubstr( var4.basename, 0, 3 ) == "s4_" )
        {
            var10 = getsubstr( var4.basename, 3, 5 );
        }
        else
        {
            var10 = getsubstr( var4.basename, 4, 6 );
        }
        
        if ( var10 == "mg" )
        {
            var10 = "lm";
        }
        
        if ( var10 == "mr" )
        {
            var10 = "sn";
        }
        
        if ( var10 != "me" && var10 != "pi" && var10 != "sh" && var10 != "sm" && var10 != "ar" && var10 != "lm" && var10 != "dm" && var10 != "sn" && var10 != "la" && var10 != "kn" )
        {
            return;
        }
        
        var8 = 1;
        var9 = "brloot_weapon_generic_" + var10;
    }
    else if ( unlocked_armory( var0 ) )
    {
        var9 = var0;
    }
    
    if ( !isdefined( var9 ) )
    {
        return;
    }
    
    if ( issubstr( var9, "me_riotshield" ) || issubstr( var9, "me_rindigo" ) || scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown( var4 ) && scripts\mp\riotshield::isriotshield( var4 ) )
    {
        var1.angles = ( var1.angles[ 0 ] - 90, var1.angles[ 1 ], var1.angles[ 2 ] );
    }
    
    heardparachuteoverheadtime();
    
    if ( var8 )
    {
        var11 = getnodecount( var9, var1.origin, var1.angles, var1.ref_12223, var4 );
        
        if ( isdefined( var11 ) )
        {
            var11.customweaponname = createheadicon( var4 );
            var11.weapon = var4;
        }
    }
    else
    {
        var11 = easepower( var11, var2.origin, var2.angles, var2.ref_12223 );
    }
    
    if ( !isdefined( var11 ) )
    {
        return;
    }
    
    if ( isdefined( var2.set_force_aitype_armored ) )
    {
        var12 = rotatevectorinverted( var2.origin - var2.set_force_aitype_armored.origin, var2.set_force_aitype_armored.angles );
        var13 = combineangles( invertangles( var2.set_force_aitype_armored.angles ), var2.angles );
        var11 validatecollision( var2.set_force_aitype_armored, var12, var13 );
        var11.set_force_aitype_armored = var2.set_force_aitype_armored;
    }
    
    ref_12b3a( var11 );
    
    if ( isdefined( var3 ) )
    {
        ref_119f5( var11, var3, var7, var8 );
    }
    else
    {
        ref_119f5( var11, 0 );
    }
    
    if ( !isdefined( var6 ) )
    {
        var6 = 1;
    }
    
    if ( !istrue( level.br_pickups.delay_delete_rpg_missile[ var11 ] ) )
    {
        var6 = 1;
    }
    
    if ( uavfastsweepid( var1 ) )
    {
        var11.init_weapon_placements = 1;
    }
    
    if ( !getdvarint( "scr_br_disableLootDropTrail" ) )
    {
        if ( istrue( var4 ) )
        {
            if ( var6 )
            {
                var11 setscriptablepartstate( var11, "dropped" );
            }
            else
            {
                var11 setscriptablepartstate( var11, "droppedNoAuto" );
            }
        }
    }
    
    var14 = level.br_pickups.init_relic_ammo_drain[ var11 ];
    
    if ( isdefined( var14 ) )
    {
        var11 [[ var14 ]]();
    }
    
    return var11;
}

// Params 2
// Size: 0x14
function ref_12b33( var0, var1 )
{
    level.br_pickups.init_relic_ammo_drain[ var0 ] = var1;
}

// Params 1
// Size: 0x21
function registerpickupremovedforspacecallback( var0 )
{
    level.br_pickups.›¾£kµ«ÅñâzÛ&kîØƒ‘Ùp¾¿þK = scripts\engine\utility::array_add( level.br_pickups.›¾£kµ«ÅñâzÛ&kîØƒ‘Ùp¾¿þK, var0 );
}

// Params 1
// Size: 0x252
function showuseresultsfeedback( var0 )
{
    switch ( var0 )
    {
        case 5:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveweapon );
            return;
        case 3:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.br_pickupdenyammonoroom );
            return;
        case 4:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.br_pickupdenyequipnoroom );
            return;
        case 6:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.br_pickupdenyarmornotbetter );
            return;
        case 7:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveks );
            return;
        case 8:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.£¼&a²o°ƒ
ï£±Ë2X°éëž¼ Ëó‹½çÊ@Œ%2³…ëˆð );
            return;
        case 28:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.™-#µ»O0ã\#›‡ÍÀÚk3Z“C9ó)që¼à´cÿ·K );
            return;
        case 14:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_fan_blades );
            return;
        case 9:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_light );
            return;
        case 10:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_exfil_ai_structs );
            return;
        case 11:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_me );
            return;
        case 13:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_name_fx );
            return;
        case 15:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_ents_to_clean_up );
            return;
        case 24:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_intro_lights );
            return;
        case 26:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_headicon );
            return;
        case 25:
            scripts\mp\hud_message::showmiscmessage( "plate_pouch_filling" );
            return;
        case 16:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_laser_entities );
            return;
        case 23:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_keypad_display_models );
            return;
        case 18:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_enemies_if_reaching_max_ai );
            return;
        case 27:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_elevator );
            return;
        case 19:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_ent );
            return;
        case 20:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_entarray );
            return;
        case 22:
            scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_objective_on_death );
            return;
        case 2:
            break;
    }
}

// Params 2
// Size: 0x24
function _removecashstateforplayer( var0, var1 )
{
    var0 notify( "reset_cash_wait" );
    var0 endon( "reset_cash_wait" );
    wait var1;
    var0.br_cash_count = undefined;
    var0.br_cash_time = undefined;
}

// Params 2
// Size: 0x397
function getcashsoundaliasforplayer( var0, var1 )
{
    var2 = "br_pickup_cash";
    var3 = 5000;
    var4 = var3 / 1000;
    var5 = gettime();
    var6 = scripts\mp\gametypes\br_public::shouldusegoldbarassets();
    
    if ( isplayer( var0 ) )
    {
        if ( !isdefined( var0.br_cash_count ) )
        {
            var0.br_cash_count = 0;
        }
        
        if ( !isdefined( var0.br_cash_time ) )
        {
            var0.br_cash_time = var5;
        }
        
        var7 = var5 - var0.br_cash_time;
        var0.br_cash_time = var5;
        
        if ( var7 < var3 )
        {
            var0.br_cash_count += 1;
        }
        
        thread _removecashstateforplayer( var0, var0 );
        var8 = "cash";
        
        if ( var6 )
        {
            var8 = "gold";
        }
        
        switch ( var1 )
        {
            case "brloot_plunder_cash_uncommon_2":
            case "brloot_plunder_cash_uncommon_1":
            case "brloot_plunder_cash_common_1":
            default:
                switch ( var0.br_cash_count )
                {
                    case 1:
                    case 0:
                        var2 = "br_pickup_" + var8 + "_01";
                        break;
                    case 2:
                        var2 = "br_pickup_" + var8 + "_02";
                        break;
                    case 3:
                        var2 = "br_pickup_" + var8 + "_03";
                        break;
                    case 4:
                        var2 = "br_pickup_" + var8 + "_04";
                        break;
                    case 5:
                    default:
                        var2 = "br_pickup_" + var8 + "_05";
                        break;
                }
                
                break;
            case "brloot_plunder_cash_rare_1":
            case "brloot_plunder_cash_uncommon_3":
                switch ( var0.br_cash_count )
                {
                    case 1:
                    case 0:
                        var2 = "br_pickup_" + var8 + "_med_01";
                        break;
                    case 2:
                        var2 = "br_pickup_" + var8 + "_med_02";
                        break;
                    case 3:
                        var2 = "br_pickup_" + var8 + "_med_03";
                        break;
                    case 4:
                        var2 = "br_pickup_" + var8 + "_med_04";
                        break;
                    case 5:
                    default:
                        var2 = "br_pickup_" + var8 + "_med_05";
                        break;
                }
                
                break;
            case "brloot_plunder_cash_epic_2":
            case "brloot_plunder_cash_epic_1":
            case "brloot_plunder_cash_rare_2":
                switch ( var0.br_cash_count )
                {
                    case 1:
                    case 0:
                        var2 = "br_pickup_" + var8 + "_lrg_01";
                        break;
                    case 2:
                        var2 = "br_pickup_" + var8 + "_lrg_02";
                        break;
                    case 3:
                        var2 = "br_pickup_" + var8 + "_lrg_03";
                        break;
                    case 4:
                        var2 = "br_pickup_" + var8 + "_lrg_04";
                        break;
                    case 5:
                    default:
                        var2 = "br_pickup_" + var8 + "_lrg_05";
                        break;
                }
                
                break;
            case "brloot_plunder_cash_legendary_1":
                switch ( var0.br_cash_count )
                {
                    case 1:
                    case 0:
                        var2 = "br_pickup_" + var8 + "_vlrg_01";
                        break;
                    case 2:
                        var2 = "br_pickup_" + var8 + "_vlrg_02";
                        break;
                    case 3:
                        var2 = "br_pickup_" + var8 + "_vlrg_03";
                        break;
                    case 4:
                        var2 = "br_pickup_" + var8 + "_vlrg_04";
                        break;
                    case 5:
                    default:
                        var2 = "br_pickup_" + var8 + "_vlrg_05";
                        break;
                }
                
                break;
        }
    }
    
    return var2;
}

// Params 4
// Size: 0x73f
function onusecompleted( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var4 = 0;
    
    if ( !isdefined( var0.count ) )
    {
        var0.count = 0;
    }
    
    if ( !istrue( var1 ) )
    {
        var5 = "br_pickup_generic";
        var6 = undefined;
        
        if ( isdefined( var0.scriptablename ) )
        {
            if ( isplunder( var0.scriptablename ) )
            {
                var5 = getcashsoundaliasforplayer( self, var0.scriptablename );
            }
            else if ( isdefined( level.br_pickups.br_pickupsfx[ var0.scriptablename ] ) && level.br_pickups.br_pickupsfx[ var0.scriptablename ].size > 0 )
            {
                var5 = level.br_pickups.br_pickupsfx[ var0.scriptablename ];
            }
            else if ( isweaponpickupitem( var0 ) )
            {
                var5 = "br_pickup_weap";
            }
            else
            {
                var5 = "br_pickup_ammo";
            }
            
            if ( isplunder( var0.scriptablename ) )
            {
                var6 = "br_plunder";
            }
            else if ( scripts\mp\gametypes\br_public::isammo( var0.scriptablename ) )
            {
                var6 = "br_ammo";
            }
            else if ( scripts\mp\gametypes\br_public::isarmorplate( var0.scriptablename ) )
            {
                var6 = "br_armor";
            }
        }
        
        self playsoundtoplayer( var5, self );
        var7 = var5 + "_3d";
        
        if ( soundexists( var7 ) )
        {
            self playsoundtoteam( var7, self.team, self, self );
        }
        
        if ( isdefined( var6 ) )
        {
            scripts\mp\damagefeedback::hudicontype( var6 );
        }
        
        if ( !istrue( var2 ) )
        {
            thread playerplaypickupanim( var0 );
        }
    }
    
    level notify( "pickedupweapon_kill_callout_" + var0.scriptablename + var0.origin );
    
    if ( isplunder( var0.scriptablename ) )
    {
        self notify( "self_pickedupitem_plunder" );
    }
    else if ( isweaponpickupitem( var0 ) )
    {
        self notify( "self_pickedupitem_weapon" );
    }
    else
    {
        self notify( "self_pickedupitem_" + var0.scriptablename );
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "onUseCompleted", var0 ) ) )
    {
        if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "takePickup" ) )
        {
            var4 = scripts\mp\gametypes\br_gametypes::ref_12e05( "takePickup", var0 );
        }
    }
    else if ( isweaponpickupitem( var0 ) )
    {
        scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
        generatespawnpoint();
        scripts\mp\gametypes\br_weapons::takeweaponpickup( var0 );
        var8 = respawnplayer( var0 );
        var9 = 0;
        
        if ( isdefined( var8 ) )
        {
            var9 = 1 << var8;
        }
        
        scripts\cp\vehicles\vehicle_compass_cp::ref_1205f( "weapon", var9 );
        var10 = isdefined( var0.scriptablename ) && var0.scriptablename == "brloot_weapon_lm_dblmg_lege";
        
        if ( var10 )
        {
            ref_11aac();
        }
    }
    else if ( scripts\mp\gametypes\br_public::isammo( var0.scriptablename ) )
    {
        var4 = scripts\mp\gametypes\br_weapons::takeammopickup( var0 );
    }
    else if ( scripts\mp\gametypes\br_public::isequipment( var0.scriptablename ) )
    {
        var4 = takeequipmentpickup( var0, var3 );
        var11 = 0;
        
        if ( level.br_pickups.br_itemtype[ var0.scriptablename ] == "lethal" )
        {
            var11 = 1;
        }
        else if ( level.br_pickups.br_itemtype[ var0.scriptablename ] == "tactical" )
        {
            var11 = 2;
        }
        else if ( scripts\mp\gametypes\br_public::isarmorplate( var0.scriptablename ) )
        {
            var11 = 4;
        }
        else if ( scripts\mp\gametypes\br_public::ishealitem( var0.scriptablename ) )
        {
            var11 = 8;
        }
        
        scripts\cp\vehicles\vehicle_compass_cp::ref_1205f( "equipment", var11 );
    }
    else if ( scripts\mp\gametypes\br_public::isarmor( var0.scriptablename ) )
    {
        takearmorpickup( var0 );
    }
    else if ( var0.scriptablename == "Pillage_Cache" && isdefined( level.givetagsfromcache ) )
    {
        self [[ level.givetagsfromcache ]]();
    }
    else if ( isplunder( var0.scriptablename ) )
    {
        scripts\mp\gametypes\br_plunder::takeplunderpickup( var0 );
        scripts\cp\vehicles\vehicle_compass_cp::ref_1205f( "plunder", var0.count );
    }
    else if ( istokenpickup( var0.scriptablename ) )
    {
        if ( issubstr( var0.scriptablename, "redeploy_token" ) )
        {
            takerespawntokenpickup( var0 );
        }
        
        if ( issubstr( var0.scriptablename, "gulag_token" ) )
        {
            takegulagtokenpickup( var0 );
        }
        
        if ( issubstr( var0.scriptablename, "hvv_hero_token" ) || issubstr( var0.scriptablename, "hvv_villain_token" ) )
        {
            scripts\mp\gametypes\br_gametype_olaride::takeherovillaintokenpickup( var0 );
        }
    }
    else if ( use_milcrate( var0.scriptablename ) )
    {
        ref_13a39( var0 );
    }
    else if ( isperkpointpickup( var0.scriptablename ) )
    {
        battle_tracks_togglethink( var0 );
    }
    else if ( iskillstreak( var0.scriptablename ) )
    {
        if ( var0.scriptablename == "brloot_specialist_bonus" )
        {
            bearsetup();
        }
        else
        {
            takekillstreakpickup( var0, var3 );
            
            if ( isdefined( var0.tracknonoobplayerlocation ) && isdefined( var0.tracknonoobplayerlocation.ref_11a40 ) && issubstr( var0.tracknonoobplayerlocation.ref_11a40, "cache" ) || istrue( var3 ) )
            {
                scripts\cp\vehicles\vehicle_compass_cp::ref_1205f( "killstreak", 0 );
            }
        }
    }
    else if ( issuperpickup( var0.scriptablename ) )
    {
        takesuperpickup( var0, var3 );
        scripts\cp\vehicles\vehicle_compass_cp::ref_1205f( "equipment", 16 );
    }
    else if ( isgasmask( var0.scriptablename ) )
    {
        takegasmask( var0, var3 );
    }
    else if ( usb( var0.scriptablename ) )
    {
        scripts\mp\gametypes\br_quest_util::ref_13a38( var0.tracknonoobplayerlocation );
    }
    else if ( updatecollectionui( var0.scriptablename ) )
    {
        if ( getdvarint( "scr_enablePouchRecycle", 0 ) == 1 )
        {
            if ( !scripts\mp\gametypes\br_public::should_use_velo_forward() )
            {
                battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
                play_hit_marker_to_player( var0, 1 );
            }
        }
        else
        {
            battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
            play_hud_reminder_vo();
        }
    }
    else if ( var0.scriptablename == "brloot_ammo_grenade" )
    {
        takegenericgrenadepickup( var0 );
    }
    else if ( turn_on_red_lights_along_track( var0.scriptablename ) )
    {
        ref_13a2f( var0 );
    }
    else if ( issecretwinebottle( var0.scriptablename ) )
    {
        takesecretwinebottle( var0.scriptablename );
    }
    else if ( issecretshovel( var0.scriptablename ) )
    {
        takesecretshovel( var0.scriptablename );
    }
    else if ( uniquelootitemlookup( var0.scriptablename ) )
    {
        ref_13a33( var0 );
    }
    else if ( usablecarriables( var0.scriptablename ) )
    {
        takequestitem( var0 );
    }
    else if ( usereload( var0.scriptablename ) )
    {
        bearsetup();
    }
    else if ( update_player_about_remaining_enemies( var0.scriptablename ) )
    {
        if ( var0.scriptablename == "brloot_escape_radio" )
        {
            if ( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "onPickupExfilRadio" ) && isdefined( var0.tracknonoobplayerlocation ) )
            {
                var0.tracknonoobplayerlocation thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onPickupExfilRadio", self );
            }
            else
            {
                var0 thread scripts\mp\gametypes\br_alt_mode_escape::obj_heli_assault3_fob( self );
            }
        }
        else if ( var0.scriptablename == "brloot_tactical_device" )
        {
            thread scripts\mp\gametypes\br_gametype_reveal_2::ref_13a1e( self );
        }
        else if ( var0.scriptablename == "brloot_mendota_screamer" )
        {
            var0 thread scripts\mp\gametypes\fresno\fresno_screamer::pickupscreamer( self );
        }
        else if ( var0.scriptablename == "brloot_zmb_stim" )
        {
            var0.tracknonoobplayerlocation thread scripts\mp\gametypes\br_alt_mode_zxp::onuse( self );
        }
    }
    else
    {
        var12 = 1;
        
        if ( isdefined( var0.count ) )
        {
            var12 = var0.count;
        }
        
        trypickupitem( var0.scriptablename, var12 );
    }
    
    var12 = 1;
    
    if ( isdefined( var0.count ) )
    {
        var12 = var0.count;
    }
    
    if ( isdefined( var0.tracknonoobplayerlocation ) && isdefined( var0.tracknonoobplayerlocation.ref_13f0a ) )
    {
        ref_128b5( var0.tracknonoobplayerlocation.ref_13f0a, self );
    }
    
    scripts\mp\gametypes\br_analytics::branalytics_lootpickup( self, var0.scriptablename, var12 );
    return var4;
}

// Params 1
// Size: 0x85
function playerplaypickupanim( var0 )
{
    self notify( "playerPlayPickupAnim" );
    self endon( "playerPlayPickupAnim" );
    self endon( "death" );
    self endon( "disconnect" );
    
    if ( isweaponpickupitem( var0 ) || !scripts\mp\gametypes\br_public::ref_12518() )
    {
        return;
    }
    
    if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "skipLootPickupAnim", var0 ) ) )
    {
        return;
    }
    
    var1 = getcompleteweaponname( "iw8_ges_plyr_loot_pickup" );
    
    if ( self hasweapon( var1 ) )
    {
        if ( self isgestureplaying( "iw8_ges_pickup_br" ) )
        {
            self stopgestureviewmodel( "iw8_ges_pickup_br", 0, 1 );
        }
        
        self takeweapon( var1 );
        waitframe();
    }
    
    scripts\mp\gametypes\br_public::ref_12616( "iw8_ges_plyr_loot_pickup", 1.17 );
}

// Params 0
// Size: 0x12
function test_ai_anim()
{
    var0 = spawnstruct();
    var0.ml_p3_to_safehouse_transition = 0;
    return var0;
}

// Params 1
// Size: 0x136
function droponplayerdeath( var0 )
{
    if ( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "dropOnPlayerDeath", var0 ) ) )
    {
        return;
    }
    
    if ( istrue( level.usegulag ) && ( scripts\mp\gametypes\br_public::isplayeringulag() || scripts\mp\gametypes\br_public::ref_1443c() ) )
    {
        return;
    }
    
    var1 = test_ai_anim();
    scripts\mp\gametypes\br_gametypes::ref_12e05( "addDropOnPlayerDeath", var1, var0 );
    
    if ( scripts\mp\utility\killstreak::isjuggernaut() )
    {
        scripts\mp\gametypes\br_jugg_common::droponplayerdeath( var1 );
    }
    
    var2 = scripts\mp\gametypes\br_gametypes::ref_12e05( "skipPrimaryWeaponDrop" );
    minplunderextractions( var1 );
    
    if ( !istrue( level.ref_133ea ) && !istrue( var2 ) )
    {
        missiontime( var1 );
    }
    
    if ( !istrue( level.ref_133cd ) )
    {
        mintokensdropondeath( var1 );
    }
    
    if ( getdvarint( "scr_br_dropPlatesAndSatchel", 1 ) == 1 || !istrue( scripts\mp\gametypes\br_public::should_use_velo_forward() ) )
    {
        missedinfilplayerhandler( var1 );
    }
    
    scripts\mp\gametypes\br_plunder::playerdropplunderondeath( var1, var0 );
    missed_shots( var1 );
    
    if ( !istrue( level.ref_133d7 ) && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" )
    {
        missing_window_blockers( var1 );
    }
    
    if ( !istrue( level.ref_133e6 ) )
    {
        mix_loot_pickups( var1 );
    }
    
    missions_clearinappropriaterewards( var1 );
    missionparticipation( var1 );
    minigun_turret_info( var1 );
    dropsecretbottles( var1 );
    dropsecretshovel( var1 );
    modifycrushdamage( var1 );
    mlgmodifyheadshotdamage( var1 );
    modifydamagetoprop();
    dropscreamerdevice( var1 );
    var0 = self.lastkilledby;
    
    if ( isdefined( var0 ) )
    {
        minshotstostage2acc( var1, var0 );
    }
}

// Params 1
// Size: 0x70
function minplunderextractions( var0 )
{
    foreach ( var2 in level.br_ammo_types )
    {
        if ( self.br_ammo[ var2 ] > 0 && isdefined( level.br_pickups.br_itemrow[ var2 ] ) )
        {
            var3 = var2;
            var4 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
            spawnpickup( var3, var4, self.br_ammo[ var2 ], 1 );
        }
    }
}

// Params 1
// Size: 0x3b
function missiontime( var0 )
{
    foreach ( var2 in self.equippedweapons )
    {
        if ( ref_132f9( var2, self ) )
        {
            ml_p1_func( var2, var0 );
        }
    }
}

// Params 2
// Size: 0xc9
function ml_p1_func( var0, var1 )
{
    var2 = undefined;
    var3 = 1;
    var4 = 0;
    var5 = 0;
    
    if ( isdefined( var0 ) )
    {
        if ( issameweapon( var0 ) )
        {
            var2 = var0;
            var3 = self getweaponammoclip( var2 );
            var4 = self getweaponammoclip( var2, "left" );
            
            if ( var2.hasalternate )
            {
                var6 = var2 getaltweapon();
                
                if ( !scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train( var2, var6 ) )
                {
                    var5 = self getweaponammoclip( var6 );
                }
            }
        }
        else if ( isstring( var0 ) )
        {
            var2 = relicsquadlink( var0 );
            
            if ( isdefined( var2 ) )
            {
                var3 = var2.clipsize;
            }
            else if ( isdefined( level.br_ammo_clipsize[ var0 ] ) )
            {
                var3 = level.br_ammo_clipsize[ var0 ];
            }
        }
    }
    
    if ( !isdefined( var2 ) )
    {
        return;
    }
    
    var7 = getitemdroporiginandangles( var1, self.origin, self.angles, self );
    var8 = scripts\mp\gametypes\br_weapons::weaponspawn( var2, self, var7, 0, 1 );
    
    if ( isdefined( var8 ) )
    {
        ref_119f5( var8, var3, var4, var5 );
    }
    
    return var8;
}

// Params 1
// Size: 0x2c
function relicsquadlink( var0 )
{
    var1 = undefined;
    
    if ( !isdefined( level.br_lootiteminfo ) && !isdefined( level.br_lootiteminfo[ var0 ] ) )
    {
        return;
    }
    
    return level.br_lootiteminfo[ var0 ].playerstartjailsetcontrols;
}

// Params 2
// Size: 0x69, Type: bool
function ref_132f9( var0, var1 )
{
    var2 = scripts\mp\utility\weapon::getweaponrootname( var0.basename );
    
    if ( var2 == "iw8_fists" || var2 == "iw8_knifestab" || var2 == "iw8_gunless" )
    {
        return false;
    }
    
    if ( var2 == "ks_use_crate_mp" )
    {
        return false;
    }
    
    if ( !issameweapon( var0 ) )
    {
        return false;
    }
    
    if ( var0.inventorytype != "primary" )
    {
        return false;
    }
    
    if ( var1 scripts\mp\gametypes\br_extract_quest::operatorsfxalias( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 4
// Size: 0x13b
function mintokensdropondeath( var0, var1, var2, var3 )
{
    var4 = istrue( var2 ) && isdefined( var3 );
    
    if ( var4 )
    {
        var5 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, var3 );
        
        if ( isdefined( var5 ) )
        {
            var6 = undefined;
            
            if ( istrue( var1 ) )
            {
                var6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
            }
            
            var7 = getitemdroporiginandangles( var0, self.origin, self.angles, self, var6 );
            spawnpickup( var5, var7, 1, 1 );
        }
        
        return;
    }
    
    if ( isdefined( self.equipment[ "primary" ] ) )
    {
        var8 = scripts\mp\equipment::getequipmentslotammo( "primary" );
        
        if ( var8 > 0 )
        {
            var9 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, self.equipment[ "primary" ] );
            
            if ( isdefined( var9 ) )
            {
                var7 = getitemdroporiginandangles( var1, self.origin, self.angles, self );
                spawnpickup( var9, var7, var8, 1 );
            }
        }
    }
    
    if ( isdefined( self.equipment[ "secondary" ] ) )
    {
        var8 = scripts\mp\equipment::getequipmentslotammo( "secondary" );
        
        if ( var8 > 0 )
        {
            var9 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, self.equipment[ "secondary" ] );
            
            if ( isdefined( var9 ) )
            {
                var7 = getitemdroporiginandangles( var1, self.origin, self.angles, self );
                var10 = spawnpickup( var9, var7, var8, 1 );
                
                if ( isdefined( var10 ) )
                {
                    modeloadoutupdateammo( var10, self, var9 );
                    return;
                }
                
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 4
// Size: 0xcd
function mix_loot_pickups( var0, var1, var2, var3 )
{
    var4 = istrue( var2 ) && isdefined( var3 );
    
    if ( var4 )
    {
        var5 = scripts\engine\utility::array_find( level.br_pickups.br_equipname, var3 );
        
        if ( isdefined( var5 ) )
        {
            var6 = undefined;
            
            if ( istrue( var1 ) )
            {
                var6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
            }
            
            var7 = getitemdroporiginandangles( var0, self.origin, self.angles, self, var6 );
            var8 = var7[ 0 ];
            var9 = var7[ 1 ];
            var10 = var7[ 2 ];
            var7 = undefined;
            spawnpickup( var5, var8, var9, 1, 1, var10 );
        }
        
        return;
    }
    
    if ( isdefined( self.equipment[ "super" ] ) )
    {
        var11 = int( max( scripts\mp\equipment::getequipmentslotammo( "super" ), scripts\mp\gametypes\br::roundnumber() ) );
        
        if ( var11 > 0 )
        {
            var4 = scripts\mp\supers::getcurrentsuperref();
            
            if ( isdefined( var4 ) && var4 == "super_fulton" )
            {
                if ( !istrue( level.brjuggsettings ) )
                {
                    return;
                }
            }
            
            dropequipmentinslot( var1, "super", var2, var11 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x4e
function missionparticipation( var0 )
{
    if ( isdefined( self.override_supply_drop_vfx ) && isdefined( self.overridefieldupgrade2 ) )
    {
        var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        var2 = spawnpickup( self.override_supply_drop_vfx, var1, 1, 1 );
        
        if ( isdefined( var2 ) )
        {
            var2 scripts\mp\gametypes\br_blueprint_extract_spawn::controlslinked( self.overridefieldupgrade2 );
            return;
        }
        
        return;
    }
}

// Params 1
// Size: 0x10f
function missedinfilplayerhandler( var0 )
{
    var1 = 0;
    var2 = undefined;
    
    if ( isdefined( self.equipment[ "health" ] ) )
    {
        var2 = level.br_pickups.br_equipnametoscriptable[ self.equipment[ "health" ] ];
        var1 = scripts\mp\equipment::getequipmentslotammo( "health" );
    }
    else if ( istrue( level.playerismatchedplayerready ) )
    {
        var2 = level.br_pickups.br_equipnametoscriptable[ "equip_armorplate" ];
        var1 = level.playerismatchedplayerready;
    }
    
    if ( istrue( level.ref_11bf1 ) && var1 < level.ref_11bf1 )
    {
        var1 = level.ref_11bf1;
        
        if ( !isdefined( var2 ) )
        {
            var2 = level.br_pickups.br_equipnametoscriptable[ "equip_armorplate" ];
        }
    }
    
    if ( var1 > 0 && isdefined( var2 ) )
    {
        if ( var1 > level.br_pickups.maxcounts[ var2 ] )
        {
            var1 -= level.br_pickups.maxcounts[ var2 ];
            var3 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
            spawnpickup( var2, var3, level.br_pickups.maxcounts[ var2 ], 1 );
        }
        
        var3 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        spawnpickup( var2, var3, var1, 1 );
        return;
    }
}

// Params 1
// Size: 0x4f
function missed_shots( var0 )
{
    if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
    {
        var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        var2 = spawnpickup( self.plundersilentcountdownendtime, var1, int( self.gasmaskhealth ), 1 );
        
        if ( isdefined( var2 ) )
        {
            var2.plunderpads = self.plunderpads;
        }
        
        hangar_doors_opening_quadrace();
        return;
    }
}

// Params 4
// Size: 0xe0
function missing_window_blockers( var0, var1, var2, var3 )
{
    var4 = scripts\mp\gametypes\br_gametypes::ref_12e07( "dropBRKillstreak", var0, var1, var2, var3 );
    
    if ( istrue( var4 ) )
    {
        return;
    }
    
    var5 = istrue( var2 ) && isdefined( var3 );
    
    if ( var5 )
    {
        var6 = undefined;
        
        if ( istrue( var1 ) )
        {
            var6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
        }
        
        var7 = getitemdroporiginandangles( var0, self.origin, self.angles, self, var6 );
        spawnpickup( level.br_pickups.br_killstreaktoscriptable[ var3 ], var7 );
        return;
    }
    
    if ( should_do_vo_call() )
    {
        var6 = undefined;
        
        if ( istrue( var3 ) )
        {
            var6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
        }
        
        var7 = getitemdroporiginandangles( var2, self.origin, self.angles, self, var6 );
        var8 = spawnpickup( level.br_pickups.br_killstreaktoscriptable[ self.streakdata.streaks[ 1 ].streakname ], var7 );
        
        if ( show_getcash_hint() && isdefined( self.spawnx1stashlootcache ) )
        {
            var8.spawnprojectile = self.spawnx1stashlootcache;
            self.spawnx1stashlootcache = undefined;
        }
        
        scripts\mp\killstreaks\killstreaks::removekillstreak( 1 );
        return;
    }
}

// Params 2
// Size: 0xd5
function minshotstostage2acc( var0, var1 )
{
    if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_br_ammoscavenger" ) )
    {
        var2 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var1.currentweapon );
        var3 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        var3.scavengerammo = 1;
        spawnpickup( var2, var3, var1.currentweapon.startammo, 1 );
    }
    
    if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_br_armorscavenger" ) )
    {
        var3 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        spawnpickup( "Armor_Plate", var3, 1, 1 );
    }
    
    if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_br_medicscavenger" ) )
    {
        var3 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        spawnpickup( "First_Aid", var3, 1, 1 );
    }
    
    if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_br_plunderscavenger" ) )
    {
        scripts\mp\gametypes\br_plunder::dropplunderbyrarity( 100, var0 );
        return;
    }
}

// Params 1
// Size: 0x3d
function missions_clearinappropriaterewards( var0 )
{
    if ( scripts\mp\gametypes\br_public::should_use_velo_forward() )
    {
        var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        var2 = scripts\mp\equipment::getequipmentslotammo( "health" );
        spawnpickup( "brloot_plate_pouch", var1, var2 );
        ref_12c16();
        return;
    }
}

// Params 2
// Size: 0x14a
function play_hit_marker_to_player( var0, var1 )
{
    var2 = var0.tracknonoobplayerlocation;
    
    if ( !isdefined( var2 ) )
    {
        var2 = var0;
    }
    
    var3 = 0;
    
    if ( isdefined( scripts\mp\equipment::getequipmentslotammo( "health" ) ) )
    {
        var3 = scripts\mp\equipment::getequipmentslotammo( "health" );
    }
    else
    {
        br_forcegivecustompickupitem( self, "brloot_armor_plate", 1, 0, 0 );
        scripts\mp\equipment::setequipmentslotammo( "health", 0 );
        var3 = scripts\mp\equipment::getequipmentslotammo( "health" );
    }
    
    if ( var2.count > 0 && var3 < scripts\mp\equipment::getequipmentmaxammo( "equip_armorplate" ) )
    {
        if ( var2.count + var3 <= scripts\mp\equipment::getequipmentmaxammo( "equip_armorplate" ) )
        {
            scripts\mp\equipment::incrementequipmentslotammo( "health", var2.count );
            
            if ( !var1 )
            {
                var2.count = 0;
                return;
            }
            
            return;
        }
        
        var4 = var2.count + var3 - scripts\mp\equipment::getequipmentmaxammo( level.br_pickups.br_equipname[ "brloot_armor_plate" ] );
        var5 = scripts\mp\equipment::getequipmentmaxammo( level.br_pickups.br_equipname[ "brloot_armor_plate" ] ) - var3;
        scripts\mp\equipment::incrementequipmentslotammo( "health", var5 );
        
        if ( var1 )
        {
            if ( getdvarint( "scr_dropExtraPlates", 1 ) == 1 )
            {
                var6 = test_ai_anim();
                var7 = getitemdroporiginandangles( var6, self.origin, self.angles, self );
                spawnpickup( "brloot_armor_plate", var7, var4, 1 );
                return;
            }
            
            return;
        }
        
        var4.count -= var7;
        return;
    }
}

// Params 1
// Size: 0x30
function minigun_turret_info( var0 )
{
    if ( scripts\mp\gametypes\br_public::should_damage_pavelow_boss() )
    {
        var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        spawnpickup( self.armorylights, var1 );
        ref_12bfc();
        return;
    }
}

// Params 1
// Size: 0x65
function dropsecretbottles( var0 )
{
    if ( isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[› ) && isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] ) )
    {
        for ( var1 = 0; var1 < self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] ; var1++ )
        {
            var2 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
            spawnpickup( "brloot_dropped_secret_bottle", var2 );
        }
        
        self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "secret_bottle" ] = 0;
        return;
    }
}

// Params 1
// Size: 0x65
function dropsecretshovel( var0 )
{
    if ( isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[› ) && isdefined( self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] ) )
    {
        for ( var1 = 0; var1 < self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] ; var1++ )
        {
            var2 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
            spawnpickup( "brloot_dropped_secret_shovel", var2 );
        }
        
        self.£ækX±c¾-æX›Œ×mÊË×K£•[›[ "shovel" ] = 0;
        return;
    }
}

// Params 1
// Size: 0x30
function mix( var0 )
{
    if ( scripts\mp\gametypes\br_public::shouldgetnewspawnpoint() )
    {
        var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
        spawnpickup( "brloot_self_revive", var1 );
        ref_12c1f();
        return;
    }
}

// Params 4
// Size: 0x48
function minsteps( var0, var1, var2, var3 )
{
    var4 = istrue( var3 ) && isdefined( var0 );
    
    if ( var4 )
    {
        var5 = undefined;
        
        if ( istrue( var2 ) )
        {
            var5 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
        }
        
        var6 = test_ai_anim();
        var7 = getitemdroporiginandangles( var6, self.origin, self.angles, self, var5 );
        spawnpickup( var0, var7, var1 );
        return;
    }
}

// Params 1
// Size: 0x40
function modifycrushdamage( var0 )
{
    if ( scripts\mp\gametypes\br_public::shouldlink() )
    {
        if ( level.br_pickups.modifydamagetohunter )
        {
            var1 = getitemdroporiginandangles( var0, self.origin, self.angles, self );
            spawnpickup( "brloot_specialist_bonus", var1 );
        }
        
        ref_12c26();
        return;
    }
}

// Params 1
// Size: 0x5c
function mlgmodifyheadshotdamage( var0 )
{
    if ( isdefined( level.obit_activation ) && isdefined( level.obit_activation.radio ) && isdefined( level.obit_activation.radio.owner ) && level.obit_activation.radio.owner == self )
    {
        thread scripts\mp\gametypes\br_alt_mode_escape::mlgmodifyheadshotdamage( var0 );
        return;
    }
    
    thread scripts\mp\gametypes\br_gametypes::ref_12e05( "onDropExfilRadio", var0 );
}

// Params 0
// Size: 0x4c
function modifydamagetoprop()
{
    if ( isdefined( level.ref_12ce8 ) && isdefined( level.ref_12ce8.ref_13a17 ) && isdefined( level.ref_12ce8.ref_13a17.owner ) && level.ref_12ce8.ref_13a17.owner == self )
    {
        thread scripts\mp\gametypes\br_gametype_reveal_2::modifydamagetoprop();
        return;
    }
}

// Params 1
// Size: 0x4f
function dropscreamerdevice( var0 )
{
    if ( isdefined( level.ref_11e18 ) && isdefined( level.ref_11e18.ref_12f3f ) && isdefined( level.ref_11e18.ref_12f3f.owner ) && level.ref_11e18.ref_12f3f.owner == self )
    {
        thread scripts\mp\gametypes\fresno\fresno_screamer::dropscreamer( var0 );
        return;
    }
}

// Params 1
// Size: 0x13, Type: bool
function ispickupstackable( var0 )
{
    return istrue( level.br_pickups.stackable[ var0 ] );
}

// Params 0
// Size: 0x22, Type: bool
function isitemslotopen()
{
    for ( var0 = 0; var0 < 8 ; var0++ )
    {
        if ( !isdefined( self.br_inventory_slots[ var0 ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Params 2
// Size: 0x17, Type: bool
function isitemfull( var0, var1 )
{
    return var1 + var0.count > var0.maxcount;
}

// Params 2
// Size: 0x50, Type: bool
function canstackpickup( var0, var1 )
{
    foreach ( var3 in self.br_inventory_slots )
    {
        if ( isdefined( var3.scriptablename ) && var3.scriptablename == var0 )
        {
            if ( !isitemfull( var3, var1 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Params 2
// Size: 0x20, Type: bool
function canslotitem( var0, var1 )
{
    if ( ispickupstackable( var0 ) )
    {
        if ( canstackpickup( var0, var1 ) )
        {
            return true;
        }
    }
    
    return isitemslotopen();
}

// Params 0
// Size: 0x22
function getfirstopenslot()
{
    for ( var0 = 0; var0 < 8 ; var0++ )
    {
        if ( !isdefined( self.br_inventory_slots[ var0 ] ) )
        {
            return var0;
        }
    }
    
    return -1;
}

// Params 1
// Size: 0xc7
function pickupitemintoinventory( var0 )
{
    if ( ispickupstackable( var0.scriptablename ) )
    {
        if ( canstackpickup( var0.scriptablename, var0.count ) )
        {
            foreach ( var2 in self.br_inventory_slots )
            {
                if ( isdefined( var2.scriptablename ) && var2.scriptablename == var0.scriptablename )
                {
                    if ( !isitemfull( var2, var0.count ) )
                    {
                        var2.count += var0.count;
                        var2.count = int( min( var2.count, var0.maxcount ) );
                        return;
                    }
                }
            }
        }
    }
    
    var4 = getfirstopenslot();
    
    if ( var4 == -1 )
    {
        return;
    }
    
    self.br_inventory_slots[ var4 ] = var0;
}

// Params 1
// Size: 0xbb
function dropitemfrominventory( var0 )
{
    if ( isdefined( self.br_inventory_slots[ var0 ] ) )
    {
        var1 = self.br_inventory_slots[ var0 ];
        var2 = remove_roof_nodes( self.origin + level.br_pickups.br_dropoffsets[ 0 ], self.angles );
        var3 = spawnpickup( var1.scriptablename, var2, var1.count );
        
        if ( isdefined( var1.armorhealth ) )
        {
            var3.armorhealth = var1.armorhealth;
        }
        else if ( isdefined( var1.helmethealth ) )
        {
            var3.helmethealth = var1.helmethealth;
        }
        else if ( isdefined( var1.gasmaskhealth ) )
        {
            var3.gasmaskhealth = var1.gasmaskhealth;
        }
        
        scripts\mp\gametypes\br_analytics::branalytics_lootdrop( self, var1.scriptablename );
        scripts\mp\gametypes\br_public::removeitemfrominventory( var0 );
        return;
    }
}

// Params 1
// Size: 0x1f
function useitemfrominventory( var0 )
{
    if ( isdefined( self.br_inventory_slots[ var0 ] ) )
    {
        tryuseitemfrominventory( self.br_inventory_slots[ var0 ], var0 );
        return;
    }
}

// Params 1
// Size: 0xc0
function ref_126e1( var0 )
{
    self endon( "disconnect" );
    self notify( "try_use_heal_slot" );
    
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
    {
        return;
    }
    
    if ( !isalive( self ) || scripts\mp\utility\player::isusingremote() || istrue( self.isdeploying ) || self.br_armorhealth >= self.br_maxarmorhealth )
    {
        return;
    }
    
    var1 = self.equipment[ "health" ];
    var2 = scripts\mp\equipment::getequipmentslotammo( "health" );
    var3 = self.br_maxarmorhealth;
    var4 = 1;
    
    if ( isdefined( var3 ) && var0 )
    {
        var4 = var3;
    }
    
    if ( istrue( self.tracking_max_health ) )
    {
        if ( isdefined( self.cam ) && get_axis_vehicles() )
        {
            self.cam += var4;
            return;
        }
        
        return;
    }
    
    self.cam = var4;
    
    if ( isdefined( var1 ) && isdefined( var2 ) && var2 > 0 )
    {
        thread scripts\mp\equipment\bandage::usequickslothealitem( var1, var2 );
        return;
    }
}

// Params 0
// Size: 0x8, Type: bool
function get_axis_vehicles()
{
    return !scripts\engine\utility::is_player_gamepad_enabled();
}

// Params 1
// Size: 0x4a
function takegenericgrenadepickup( var0 )
{
    var1 = scripts\mp\equipment::getequipmentslotammo( "primary" );
    
    if ( isdefined( var1 ) && var1 < 2 )
    {
        scripts\mp\equipment::incrementequipmentslotammo( "primary" );
    }
    
    var1 = scripts\mp\equipment::getequipmentslotammo( "secondary" );
    
    if ( isdefined( var1 ) && var1 < 2 )
    {
        scripts\mp\equipment::incrementequipmentslotammo( "secondary" );
        return;
    }
}

// Params 1
// Size: 0x37
function trypickupitemfroment( var0 )
{
    if ( canslotitem( var0.scriptablename, var0.count ) )
    {
        pickupitemintoinventory( var0 );
        return;
    }
    
    self iprintlnbold( "No room in inventory" );
    self playlocalsound( "br_pickup_deny" );
}

// Params 2
// Size: 0xb9
function trypickupitem( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( level.br_pickups.maxcounts[ var0 ] ) || !isdefined( level.br_pickups.stackable[ var0 ] ) )
    {
        return;
    }
    
    var2 = spawnstruct();
    var2.scriptablename = var0;
    var2.count = var1;
    var2.maxcount = level.br_pickups.maxcounts[ var0 ];
    var2.stackable = level.br_pickups.stackable[ var0 ];
    var2.itemtype = level.br_pickups.br_itemtype[ var0 ];
    
    if ( canslotitem( var2.scriptablename, var2.count ) )
    {
        pickupitemintoinventory( var2 );
        return;
    }
    
    self iprintlnbold( "No room in inventory" );
    self playlocalsound( "br_pickup_deny" );
}

// Params 2
// Size: 0xef
function tryequipmentfrominventory( var0, var1 )
{
    var2 = level.br_pickups.br_equipname[ var0.scriptablename ];
    var3 = level.equipment.table[ var2 ].defaultslot;
    
    if ( isdefined( self.equipment[ var3 ] ) && self.equipment[ var3 ] == var2 )
    {
        if ( equipmentslothasroom( var2, var3 ) )
        {
            scripts\mp\equipment::incrementequipmentslotammo( var3, level.br_pickups.counts[ var0.scriptablename ] );
            self.br_inventory_slots[ var1 ] = undefined;
            return;
        }
        
        return;
    }
    
    if ( !isdefined( self.equipment[ var3 ] ) || scripts\mp\equipment::getequipmentslotammo( var3 ) == 0 )
    {
        scripts\mp\equipment::giveequipment( var2, var3 );
        scripts\mp\equipment::setequipmentslotammo( var3, var0.count );
        self.br_inventory_slots[ var1 ] = undefined;
        return;
    }
    
    var4 = self.equipment[ var3 ];
    var5 = scripts\mp\equipment::getequipmentslotammo( var3 );
    scripts\mp\equipment::giveequipment( var2, var3 );
    scripts\mp\equipment::setequipmentslotammo( var3, var0.count );
    self.br_inventory_slots[ var1 ] = undefined;
    var6 = level.br_pickups.br_equipnametoscriptable[ var4 ];
    trypickupitem( var6, var5 );
}

// Params 2
// Size: 0x84
function droparmor( var0, var1 )
{
    var2 = remove_roof_nodes( self.origin + level.br_pickups.br_dropoffsets[ 0 ], self.angles );
    var3 = spawnpickup( var0, var2 );
    var3.count = 1;
    var3.helmethealth = 0;
    var3.armorhealth = 0;
    var3.gasmaskhealth = 0;
    
    if ( issubstr( var0, "helmet" ) )
    {
        var3.helmethealth = var1;
        
        if ( var0 == "brloot_armor_helmet_3" )
        {
            scripts\mp\utility\perk::removeperk( "specialty_stun_resistance" );
        }
    }
    
    scripts\mp\gametypes\br_analytics::branalytics_lootdrop( self, var0 );
}

// Params 1
// Size: 0x36
function trydroparmorfornewarmor( var0 )
{
    if ( scripts\mp\gametypes\br_public::ishelmet( var0 ) )
    {
        if ( isdefined( self.br_helmetlevel ) )
        {
            var1 = scripts\mp\gametypes\br_armor::helmetitemtypeforlevel( self.br_helmetlevel );
            
            if ( isdefined( var1 ) )
            {
                droparmor( var1, self.br_helmethealth );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x6e
function tryequiparmor( var0, var1 )
{
    if ( isdefined( var1 ) )
    {
        self.br_inventory_slots[ var1 ] = undefined;
    }
    
    trydroparmorfornewarmor( var0.scriptablename );
    
    if ( var0.scriptablename == "brloot_armor_helmet_1" )
    {
        scripts\mp\gametypes\br_armor::takehelmet( var0, 1 );
        return;
    }
    
    if ( var0.scriptablename == "brloot_armor_helmet_2" )
    {
        scripts\mp\gametypes\br_armor::takehelmet( var0, 2 );
        return;
    }
    
    if ( var0.scriptablename == "brloot_armor_helmet_3" )
    {
        scripts\mp\gametypes\br_armor::takehelmet( var0, 3 );
        return;
    }
}

// Params 2
// Size: 0x1d
function tryuseitemfrominventory( var0, var1 )
{
    if ( scripts\mp\gametypes\br_public::isequipment( var0.scriptablename ) )
    {
        tryequipmentfrominventory( var0, var1 );
        return;
    }
}

// Params 0
// Size: 0x11
function initpickupusability()
{
    scripts\common\interactive::interactive_addusedcallback( &brpickupsusecallback, "br_pickups" );
}

// Params 2
// Size: 0x40
function brpickupsusecallback( var0, var1 )
{
    var2 = cantakepickup( var1, var0 );
    showuseresultsfeedback( var1, var2 );
    
    if ( var2 != 1 )
    {
        return;
    }
    
    onusecompleted( var1, var0 );
    lastunrulyscore( var0 );
    
    if ( var0 isscriptable() )
    {
        var0 freescriptable();
        return;
    }
    
    var0 delete();
}

// Params 2
// Size: 0x3c
function setup_train_array( var0, var1 )
{
    if ( isdefined( self.equipment[ var1 ] ) && scripts\mp\equipment::getequipmentslotammo( var1 ) > 0 )
    {
        var2 = test_ai_anim();
        dropequipmentinslot( var2, var1 );
    }
    
    scripts\mp\equipment::giveequipment( var0, var1 );
    scripts\mp\equipment::setequipmentammo( var0, 1 );
}

// Params 1
// Size: 0x27
function ref_1398a( var0 )
{
    if ( scripts\mp\utility\game::getgametype() == "br" && !level.allowsupers )
    {
        var0 scripts\mp\equipment::takeequipment( "super" );
        return;
    }
}

// Params 0
// Size: 0x2b
function hangar_doors_opening_quadrace()
{
    if ( istrue( self.gasmaskequipped ) )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
    
    self.gasmaskswapinprogress = 0;
    handleweaponreloadammodrop();
}

// Params 0
// Size: 0x42
function handleweaponreloadammodrop()
{
    self.plunderpads = undefined;
    self.gasmaskhealth = undefined;
    self.plunderrepositorywidget = undefined;
    self.plundermusicthird = 0;
    self setclientomnvar( "ui_gas_mask", 0 );
    self setclientomnvar( "ui_head_equip_class", 0 );
    self setclientomnvar( "ui_gasmask_damage", 0 );
    scripts\mp\gametypes\br_public::sethasgasmaskextrainfo( 0 );
}

// Params 1
// Size: 0x5b
function riotshieldtaken( var0 )
{
    var1 = "brloot_armor_plate";
    var2 = level.br_pickups.br_equipname[ var1 ];
    var3 = level.equipment.table[ var2 ].defaultslot;
    
    if ( isdefined( self.equipment[ var3 ] ) )
    {
        var4 = scripts\mp\equipment::getequipmentslotammo( var3 );
        
        if ( var4 > 0 )
        {
            if ( istrue( var0 ) )
            {
                return var4;
            }
            else
            {
                return 1;
            }
        }
    }
    
    return 0;
}

// Params 2
// Size: 0x38
function riotshieldswitchaway( var0, var1 )
{
    var2 = self.br_ammo[ var0 ];
    var3 = level.br_ammo_clipsize[ var0 ];
    
    if ( !isdefined( var2 ) || !isdefined( var3 ) )
    {
        return 0;
    }
    
    if ( istrue( var1 ) )
    {
        return int( var2 );
    }
    
    return int( min( var3, var2 ) );
}

// Params 1
// Size: 0x23
function risk_currentflagstier( var0 )
{
    var1 = 5;
    
    if ( istrue( var0 ) )
    {
        return int( self.plundercount );
    }
    
    return int( min( self.plundercount, var1 ) );
}

// Params 1
// Size: 0x55
function riotshieldswitchawaytimer( var0 )
{
    switch ( var0 )
    {
        case 5:
            return "brloot_ammo_762";
        case 7:
            return "brloot_ammo_919";
        case 9:
            return "brloot_ammo_50cal";
        case 6:
            return "brloot_ammo_12g";
        case 8:
            return "brloot_ammo_rocket";
        default:
            break;
    }
}

// Params 1
// Size: 0x13
function risk_currentlocsinuse( var0 )
{
    var1 = self.lastdroppableweaponobj;
    var2 = createheadicon( var1 );
    return var2;
}

// Params 2
// Size: 0x1b3
function risk_currentflagsactive( var0, var1 )
{
    var2 = 1;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    var6 = undefined;
    
    switch ( var0 )
    {
        case 3:
            var3 = int( self.gasmaskhealth );
            var2 = scripts\cp_mp\gasmask::hasgasmask( self ) && !istrue( self.plundermusicthird );
            break;
        case 4:
            var3 = riotshieldtaken( var1 );
            var2 = var3 > 0;
            break;
        case 9:
        case 8:
        case 7:
        case 6:
        case 5:
            var7 = riotshieldswitchawaytimer( var0 );
            var3 = riotshieldswitchaway( var7, var1 );
            var2 = var3 > 0;
            break;
        case 0:
            if ( istrue( self.iszombie ) )
            {
                var2 = 0;
                break;
            }
            
            var3 = risk_currentflagstier( var1 );
            var2 = var3 > 0;
            break;
        case 1:
            var3 = scripts\engine\utility::ter_op( istrue( self.hasrespawntoken ), 1, 0 );
            var2 = var3 > 0;
            break;
        case 2:
            var3 = scripts\engine\utility::ter_op( istrue( self.shouldgetnewspawnpoint ), 1, 0 );
            var2 = var3 > 0;
            break;
        case 10:
            var8 = self.lastdroppableweaponobj;
            
            if ( !isdefined( var8 ) || nullweapon( var8 ) || !self hasweapon( var8 ) || var8 == getcompleteweaponname( "iw8_fists_mp" ) || self isskydiving() || istrue( self.usingascender ) )
            {
                var2 = 0;
            }
            else
            {
                var3 = self getweaponammoclip( var8 );
                var4 = self getweaponammoclip( var8, "left" );
                
                if ( var8.hasalternate )
                {
                    var9 = var8 getaltweapon();
                    
                    if ( !scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train( var8, var9 ) )
                    {
                        var5 = self getweaponammoclip( var9 );
                    }
                }
                
                var6 = var8;
            }
            
            break;
        default:
            var2 = 0;
            break;
    }
    
    return [ var2, var3, var4, var5, var6 ];
}

// Params 2
// Size: 0x62
function ref_12993( var0, var1 )
{
    var2 = "brloot_armor_plate";
    var3 = level.br_pickups.br_equipname[ var2 ];
    var4 = level.equipment.table[ var3 ].defaultslot;
    scripts\mp\equipment::decrementequipmentslotammo( var4, var1 );
    
    if ( istrue( self.tracking_max_health ) )
    {
        var5 = scripts\mp\equipment::getcurrentequipment( var4 );
        var6 = scripts\mp\equipment::getequipmentammo( var5 );
        
        if ( var6 < 1 )
        {
            self notify( "br_try_armor_cancel" );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x16
function ref_12992( var0, var1 )
{
    var2 = riotshieldswitchawaytimer( var0 );
    scripts\mp\gametypes\br_weapons::br_ammo_take_type( self, var2, var1 );
}

// Params 2
// Size: 0xc
function ref_12995( var0, var1 )
{
    scripts\mp\gametypes\br_plunder::ref_1261e( var1 );
}

// Params 2
// Size: 0xa
function ref_12996( var0, var1 )
{
    removerespawntoken();
}

// Params 2
// Size: 0xa
function ref_12997( var0, var1 )
{
    ref_12c1f();
}

// Params 2
// Size: 0xe3
function ref_12998( var0, var1 )
{
    var2 = self.lastdroppableweaponobj;
    var3 = getcompleteweaponname( "iw8_fists_mp" );
    var4 = var3;
    var5 = self getweaponslistprimaries();
    
    foreach ( var7 in var5 )
    {
        if ( var7.inventorytype != "primary" )
        {
            continue;
        }
        
        if ( var7 != var3 && var7 != var2 && !scripts\mp\utility\weapon::update_health_bar_to_player( var7 ) )
        {
            var4 = var7;
            break;
        }
    }
    
    if ( !scripts\mp\riotshield::isriotshield( var2 ) )
    {
        var9 = self getweaponammostock( var2 );
        var10 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( var2 );
        
        if ( isdefined( var10 ) )
        {
            self.br_ammo[ var10 ] = var9;
        }
    }
    
    if ( scripts\mp\utility\weapon::update_health_on_spawn( var2 ) )
    {
        self notify( "dropped_minigun" );
    }
    
    scripts\cp_mp\utility\inventory_utility::_takeweapon( var2 );
    scripts\mp\gametypes\br_public::ref_1264d();
    
    if ( !self hasweapon( var3 ) )
    {
        self giveweapon( var3 );
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons( self );
    self switchtoweaponimmediate( var4 );
    scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
    generatespawnpoint();
}

// Params 2
// Size: 0xcc
function ref_12994( var0, var1 )
{
    switch ( var0 )
    {
        case 3:
            if ( !istrue( self.plundermusicthird ) )
            {
                self.plundermusicthird = 1;
                thread ref_12c05();
            }
            
            break;
        case 4:
            ref_12993( var0, var1 );
            break;
        case 9:
        case 8:
        case 7:
        case 6:
        case 5:
            ref_12992( var0, var1 );
            break;
        case 0:
            ref_12995( var0, var1 );
            break;
        case 1:
            ref_12996( var0, var1 );
            break;
        case 2:
            ref_12997( var0, var1 );
            break;
        case 10:
            ref_12998( var0, var1 );
            break;
        default:
            return;
    }
}

// Params 2
// Size: 0xd3
function ref_1298e( var0, var1 )
{
    switch ( var0 )
    {
        case 3:
            return self.plundersilentcountdownendtime;
        case 4:
            return "brloot_armor_plate";
        case 9:
        case 8:
        case 7:
        case 6:
        case 5:
            return riotshieldswitchawaytimer( var0 );
        case 0:
            for ( var2 = level.br_plunder.ref_12954.size - 1; var2 >= 0 ; var2-- )
            {
                if ( var1 > level.br_plunder.ref_12954[ var2 ] )
                {
                    return level.br_plunder.names[ var2 ];
                }
            }
            
            return level.br_plunder.names[ 0 ];
        case 2:
            return "brloot_self_revive";
        case 1:
            return "brloot_respawn_token";
        case 10:
            return risk_currentlocsinuse( var1 );
        default:
            break;
    }
}

// Params 0
// Size: 0x1d
function ref_1298c()
{
    var0 = 120;
    self notify( "quickDropCleanupCache" );
    self endon( "quickDropCleanupCache" );
    wait var0;
    self.ref_12989 = undefined;
}

// Params 5
// Size: 0x7a
function ref_12986( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( self.ref_12989 ) )
    {
        self.ref_12989 = [];
    }
    
    var5 = spawnstruct();
    var5.vehicle_collision_updateinstanceend = var0;
    var5.slot = var1;
    var5.ent = var2;
    var5.moderemovefromteamlives = var3;
    var5.minigun_wait_between_shots = var4;
    var5.ref_1260b = self.origin;
    var5.ref_126f7 = self.angles[ 1 ];
    self.ref_12989[ self.ref_12989.size ] = var5;
    thread ref_1298c();
}

// Params 1
// Size: 0x51, Type: bool
function ref_1298b( var0 )
{
    var1 = 60;
    var2 = squared( var1 );
    var3 = 45;
    var4 = distancesquared( self.origin, var0.ref_1260b );
    
    if ( var4 > var2 )
    {
        return false;
    }
    
    var5 = abs( self.angles[ 1 ] - var0.ref_126f7 );
    
    if ( var5 > var3 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x5a
function ref_1298d( var0 )
{
    if ( !isdefined( self.ref_12989 ) )
    {
        return;
    }
    
    foreach ( var2 in self.ref_12989 )
    {
        if ( isdefined( var2.ent ) && var2.vehicle_collision_updateinstanceend == var0 )
        {
            if ( !ref_1298b( var2 ) )
            {
                continue;
            }
            
            return var2;
        }
    }
}

// Params 0
// Size: 0x9b
function ref_1298a()
{
    if ( !isdefined( self.ref_12989 ) )
    {
        return 0;
    }
    
    var0 = [];
    
    foreach ( var2 in self.ref_12989 )
    {
        if ( isdefined( var2.ent ) )
        {
            if ( !ref_1298b( var2 ) )
            {
                continue;
            }
            
            var0 = 1;
        }
    }
    
    var4 = undefined;
    var5 = 0;
    var6 = 0;
    var7 = [ 0, 13, 1 ];
    
    for ( ;; )
    {
        var4 = var6 * 14 + var7[ var5 ];
        
        if ( !istrue( var0[ var4 ] ) )
        {
            break;
        }
        
        var5++;
        
        if ( var5 >= var7.size )
        {
            var5 = 0;
            var6++;
        }
    }
    
    return var4;
}

// Params 3
// Size: 0x161
function ref_12991( var0, var1, var2 )
{
    var3 = undefined;
    
    switch ( var0 )
    {
        case 3:
            var3 = "br_inventory_drop_self_revive";
            break;
        case 4:
            var3 = "br_inventory_drop_armor";
            break;
        case 9:
        case 8:
        case 7:
        case 6:
        case 5:
            var3 = "br_inventory_drop_ammo";
            break;
        case 0:
            if ( var2 == "brloot_plunder_cash_uncommon_1" )
            {
                var3 = "br_inventory_drop_plunder_sm";
            }
            else if ( var2 == "brloot_plunder_cash_uncommon_2" )
            {
                var3 = "br_inventory_drop_plunder_sm";
            }
            else if ( var2 == "brloot_plunder_cash_uncommon_3" )
            {
                var3 = "br_inventory_drop_plunder_sm";
            }
            else if ( var2 == "brloot_plunder_cash_rare_1" )
            {
                var3 = "br_inventory_drop_plunder_med";
            }
            else if ( var2 == "brloot_plunder_cash_rare_2" )
            {
                var3 = "br_inventory_drop_plunder_med";
            }
            else if ( var2 == "brloot_plunder_cash_epic_1" )
            {
                var3 = "br_inventory_drop_plunder_lrg";
            }
            else if ( var2 == "brloot_plunder_cash_epic_2" )
            {
                var3 = "br_inventory_drop_plunder_lrg";
            }
            else if ( var2 == "brloot_plunder_cash_legendary_1" )
            {
                var3 = "br_inventory_drop_plunder_extra_lrg";
            }
            else
            {
                var3 = "br_inventory_drop_plunder_sm";
            }
            
            break;
        case 1:
            break;
        case 2:
            var3 = "br_inventory_drop_self_revive";
            break;
        case 10:
            var3 = "br_inventory_drop_weap";
            break;
        default:
            break;
    }
    
    if ( isdefined( var3 ) )
    {
        playsoundatpos( var1, var3 );
        return;
    }
}

// Params 5
// Size: 0x153, Type: bool
function ref_12987( var0, var1, var2, var3, var4 )
{
    var5 = ref_1298d( var0 );
    
    if ( isdefined( var5 ) )
    {
        var6 = var5.ent;
        var7 = var5.moderemovefromteamlives;
        var8 = var5.minigun_wait_between_shots;
        var9 = ref_119ed( var6 );
        var10 = ref_119ef( var6 );
        var11 = ref_119ee( var6 );
        
        if ( !ispickupstackable( var5.ent.type ) && !issubstr( var5.ent.type, "_cash" ) )
        {
            return false;
        }
        
        var12 = undefined;
        
        if ( isdefined( var6.set_force_aitype_armored ) )
        {
            var12 = var6.set_force_aitype_armored;
        }
        
        var13 = var9 + var1;
        var14 = var10 + var2;
        var15 = var11 + var3;
        var16 = ref_1298e( var0, var13 );
        var17 = getscriptablereservedremaining( var7 + ( 0, 0, 12 ), var7 );
        var18 = remove_roof_nodes( var7, var8, var17, var12 );
        var19 = spawnpickup( var16, var18, var13, 1, var4, 0, var14, var15 );
        
        if ( istrue( level. à¬f3#ØÙH³yRkÒë9'èoùç_ñhxz­ ) )
        {
            level notify( "br_pickup_item_dropped", var19, self );
        }
        
        scripts\mp\gametypes\br_analytics::branalytics_lootdrop( self, var16, undefined, var1 );
        
        if ( isdefined( var4 ) )
        {
            level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from( var19, self, var4 );
        }
        
        ref_12991( var0, var7, var16 );
        var5.ent = var19;
        thread ref_1298c();
        lastunrulyscore( var6 );
        
        if ( isent( var6 ) )
        {
            var6 delete();
        }
        else
        {
            var6 freescriptable();
        }
        
        return true;
    }
    
    return false;
}

// Params 5
// Size: 0x117
function ref_12990( var0, var1, var2, var3, var4 )
{
    var5 = ref_1298e( var0, var1 );
    
    if ( !isdefined( var5 ) )
    {
        return;
    }
    
    var6 = ref_1298a();
    var7 = test_ai_anim();
    var7.ml_p3_to_safehouse_transition = var6;
    var8 = getitemdroporiginandangles( var7, self.origin, self.angles, self );
    var9 = isgasmask( var5 );
    var10 = scripts\mp\gametypes\br_extract_quest::operatorsfxalias( var4 );
    var11 = get_base_focus_fire_multipler( var4 );
    
    if ( !var10 && var11 )
    {
        if ( var9 && istrue( self.gasmaskswapinprogress ) )
        {
            scripts\engine\utility::waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
            waitframe();
        }
        
        var12 = spawnpickup( var5, var8, var1, 1, var4, 0, var2, var3 );
        
        if ( var9 && isdefined( var12 ) )
        {
            var12.plunderpads = self.plunderpads;
        }
        
        if ( istrue( level. à¬f3#ØÙH³yRkÒë9'èoùç_ñhxz­ ) )
        {
            level notify( "br_pickup_item_dropped", var12, self );
        }
        
        ref_12986( var0, var6, var12, var8.origin, var8.angles );
        scripts\mp\gametypes\br_analytics::branalytics_lootdrop( self, var5, undefined, var1 );
        
        if ( isdefined( var4 ) )
        {
            level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from( var12, self, var4 );
        }
    }
    
    ref_12991( var0, var8.origin, var5 );
    
    if ( var9 )
    {
        hangar_doors_opening_quadrace();
        return;
    }
}

// Params 1
// Size: 0x12, Type: bool
function get_base_focus_fire_multipler( var0 )
{
    if ( scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x78
function ref_1298f( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    setuproundstarthud( var0 );
    var1 = risk_currentflagsactive( var0 );
    var2 = var1[ 0 ];
    var3 = var1[ 1 ];
    var4 = var1[ 2 ];
    var5 = var1[ 3 ];
    var6 = var1[ 4 ];
    var1 = undefined;
    
    if ( !var2 )
    {
        return;
    }
    
    ref_12994( var0, var3 );
    scripts\mp\class::disableclassswapallowed();
    var7 = ref_12987( var0, var3, var4, var5, var6 );
    
    if ( var7 )
    {
        return;
    }
    
    ref_12990( var0, var3, var4, var5, var6 );
}

// Params 1
// Size: 0x90
function ref_12988( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    setuproundstarthud( var0 );
    var1 = 1;
    var2 = risk_currentflagsactive( var0, 1 );
    var3 = var2[ 0 ];
    var4 = var2[ 1 ];
    var5 = var2[ 2 ];
    var6 = var2[ 3 ];
    var7 = var2[ 4 ];
    var2 = undefined;
    
    if ( !var3 )
    {
        return;
    }
    
    ref_12994( var0, var4 );
    scripts\mp\class::disableclassswapallowed();
    var8 = ref_12987( var0, var4, var5, var6, var7 );
    
    if ( !var8 )
    {
        ref_12990( var0, var4, var5, var6, var7 );
    }
    
    if ( isdefined( level.ref_1207b ) )
    {
        [[ level.ref_1207b ]]( self );
        return;
    }
}

// Params 1
// Size: 0x3c
function gethighestscore( var0 )
{
    switch ( var0 )
    {
        case 9:
        case 8:
        case 7:
        case 6:
        case 5:
            return 1;
        default:
            return 0;
    }
}

// Params 1
// Size: 0x39
function setuproundstarthud( var0 )
{
    if ( gethighestscore( var0 ) )
    {
        var1 = undefined;
        
        while ( self isreloading() )
        {
            if ( !istrue( var1 ) )
            {
                var1 = 1;
                self disableautoreload();
            }
            
            self cancelreload();
            waitframe();
        }
        
        if ( istrue( var1 ) )
        {
            self enableautoreload();
        }
        
        waitframe();
        return;
    }
}

// Params 2
// Size: 0x12b
function dangercircletick( var0, var1 )
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "loot" ) )
    {
        return;
    }
    
    var2 = var1 * var1;
    var3 = level.br_circle.circleindex;
    
    if ( var3 > level.br_circle.damagetick.size - 1 )
    {
        var3 = level.br_circle.damagetick.size - 1;
    }
    
    var4 = level.br_circle.damagetick[ var3 ];
    
    if ( isdefined( level.circledamagemultiplier ) )
    {
        var4 *= level.circledamagemultiplier;
    }
    
    level.br_pickups.modetype = scripts\engine\utility::array_removeundefined( level.br_pickups.modetype );
    
    for ( var5 = level.br_pickups.modetype.size - 1; var5 >= 0 ; var5-- )
    {
        var6 = level.br_pickups.modetype[ var5 ];
        
        if ( distance2dsquared( var6.origin, var0 ) > var2 )
        {
            var7 = var6.count;
            var8 = int( var7 - var4 );
            
            if ( var8 <= 0 )
            {
                var6 setscriptablepartstate( var6.type, "death" );
                lastgunkilltime( var6, 1 );
                thread lastunruly( level );
            }
            else
            {
                if ( var6 scripts\cp_mp\gasmask::lights_setup_plane( var7, var8 ) )
                {
                    var6 setscriptablepartstate( var6.type, "damage" );
                }
                
                ref_119f5( var6, var8 );
            }
        }
    }
}

// Params 0
// Size: 0x1c
function plundermusicfirst()
{
    level.br_pickups.modetype[ level.br_pickups.modetype.size ] = self;
}

// Params 1
// Size: 0x22
function lastunruly( var0 )
{
    waittillframeend();
    
    if ( isdefined( level.br_pickups.modetype ) )
    {
        level.br_pickups.modetype[ var0 ] = undefined;
        return;
    }
}

// Params 0
// Size: 0x42
function toppercentagetoadjusteconomy()
{
    var0 = level.br_pickups;
    var0.scriptables = [];
    var0.ref_12f7c = 0;
    var0.ref_12f7a = 0;
    var0.ref_12f7b = removestuckenemyondeathordisconnect();
    var0.ref_12f79 = getdvarint( "scr_br_pickupScriptablesCleanupBatchSize", 10 );
}

// Params 0
// Size: 0x57
function removestuckenemyondeathordisconnect()
{
    var0 = function_0434();
    var1 = getdvarint( "scr_br_loot_override", 0 );
    jumpiffalse(var1 > 0 && var1 < var0) LOC_00000025;
    var2 = var1;
    goto LOC_00000046;
}

// Params 1
// Size: 0x36
function ref_12b3a( var0 )
{
    var1 = level.br_pickups.ref_12f7a;
    var0.embassy_main = var1;
    level.br_pickups.scriptables[ var1 ] = var0;
    level.br_pickups.ref_12f7a++;
}

// Params 1
// Size: 0x1e
function lastunrulyscore( var0 )
{
    level.br_pickups.scriptables[ var0.embassy_main ] = undefined;
    var0.embassy_main = undefined;
}

// Params 0
// Size: 0xe2
function heardparachuteoverheadtime()
{
    var0 = level.br_pickups;
    
    if ( var0.scriptables.size < var0.ref_12f7b && enabledismembermenttag() > 0 )
    {
        return;
    }
    
    var1 = 0;
    
    for ( var2 = var0.ref_12f7c; var2 < var0.ref_12f7a ; var2++ )
    {
        if ( var1 == var0.ref_12f79 )
        {
            break;
        }
        
        var3 = var0.scriptables[ var2 ];
        
        if ( isdefined( var3 ) )
        {
            if ( istrue( var3.init_weapon_placements ) )
            {
                continue;
            }
            
            foreach ( var5 in level.br_pickups.›¾£kµ«ÅñâzÛ&kîØƒ‘Ùp¾¿þK )
            {
                var3 [[ var5 ]]();
            }
            
            var0.scriptables[ var2 ] = undefined;
            
            if ( isent( var3 ) )
            {
                var3 delete();
            }
            else
            {
                var3 freescriptable();
            }
            
            var1++;
        }
        else
        {
            var0.scriptables[ var2 ] = undefined;
        }
        
        var0.ref_12f7c++;
    }
}

// Params 0
// Size: 0x1c
function lastgoodjobplayer()
{
    lastunrulyscore( self );
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    self freescriptable();
}

// Params 1
// Size: 0xb
function lastgunkilltime( var0 )
{
    thread lastheatupdate( var0 );
}

// Params 1
// Size: 0x18
function lastheatupdate( var0 )
{
    self endon( "death" );
    wait var0;
    
    if ( isdefined( self ) )
    {
        lastgoodjobplayer();
        return;
    }
}

// Params 2
// Size: 0x27
function ref_12b3f( var0, var1 )
{
    while ( !isdefined( level.br_pickups ) )
    {
        waitframe();
    }
    
    level.br_pickups.ref_13f09[ "uniqueLootItem_" + var0 ] = var1;
}

// Params 2
// Size: 0x1c
function ref_128b5( var0, var1 )
{
    if ( isdefined( [[ level.br_pickups.ref_13f09[ var0 ] ]]( var1 ) ) )
    {
        return;
    }
}

// Params 0
// Size: 0x14
function ref_11aac()
{
    thread ref_14484();
    thread ref_144ef();
    thread ref_144e7();
}

// Params 0
// Size: 0x3e
function calculateaveragevelocities()
{
    self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\playeractions::allowactionset( "fakeJugg", 0 );
    
    if ( !istrue( level.loadout_updateammo ) )
    {
        scripts\common\utility::allow_mount_top( 0, "fakeJugg" );
        scripts\common\utility::allow_mount_side( 0, "fakeJugg" );
        return;
    }
}

// Params 0
// Size: 0x3e
function ref_12c12()
{
    self.playerstreakspeedscale = undefined;
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\playeractions::allowactionset( "fakeJugg", 1 );
    
    if ( !istrue( level.loadout_updateammo ) )
    {
        scripts\common\utility::allow_mount_top( 1, "fakeJugg" );
        scripts\common\utility::allow_mount_side( 1, "fakeJugg" );
        return;
    }
}

// Params 0
// Size: 0x2e
function ref_14484()
{
    self endon( "death_or_disconnect" );
    self endon( "dropped_minigun" );
    self endon( "juggernaut_start" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "switched_to_minigun" );
        calculateaveragevelocities();
    }
}

// Params 0
// Size: 0x54
function ref_144ef()
{
    self endon( "disconnect" );
    self endon( "juggernaut_start" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var0 = scripts\engine\utility::ref_143b5( "switched_from_minigun", "dropped_minigun", "death" );
        
        if ( isdefined( var0 ) )
        {
            ref_12c12();
            
            if ( var0 == "dropped_minigun" || var0 == "death" )
            {
                break;
            }
        }
    }
}

// Params 0
// Size: 0x55
function ref_144e7()
{
    self endon( "death_or_disconnect" );
    self endon( "dropped_minigun" );
    self endon( "juggernaut_start" );
    level endon( "game_ended" );
    var0 = 0;
    
    for ( ;; )
    {
        if ( !scripts\mp\utility\weapon::update_health_on_spawn( self getcurrentweapon() ) )
        {
            if ( istrue( var0 ) )
            {
                var0 = 0;
                self notify( "switched_from_minigun" );
            }
        }
        else if ( !istrue( var0 ) )
        {
            var0 = 1;
            self notify( "switched_to_minigun" );
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0xa6, Type: bool
function make_chair_ai_spawner( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isdefined( self.streakdata ) )
    {
        return false;
    }
    
    if ( !isdefined( self.streakdata.streaks ) || !isdefined( self.streakdata.streaks[ 1 ] ) )
    {
        return false;
    }
    
    var1 = self.streakdata.streaks[ 1 ];
    
    if ( !isdefined( var0.streakname ) || !isdefined( var1.streakname ) || var0.streakname != var1.streakname )
    {
        return false;
    }
    
    if ( !isdefined( var0.id ) || !isdefined( var1.uniqueid ) || var0.id != var1.uniqueid )
    {
        return false;
    }
    
    return true;
}

// Params 0
// Size: 0x2e
function addspawnlocation()
{
    self endon( "death_or_disconnect" );
    self notify( "cancelOffhandADS" );
    self endon( "cancelOffhandADS" );
    self notify( "offhand_ads_off" );
    wait 0.5;
    self notify( "offhand_ads_off" );
}

// Params 0
// Size: 0x8
function generatespawnpoint()
{
    thread addspawnlocation();
}

// Params 0
// Size: 0x25
function getnospawntags()
{
    var0 = getdvar( "MRRNLMKLQL" );
    var1 = strtok( var0, "&" );
    var1 = scripts\engine\utility::array_add( var1, "noSpawn" );
    return var1;
}

