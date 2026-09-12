/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_pickups.gsc
***********************************************/

function delete_objective_on_death_safe() {
  level.br_pickups = spawnStruct();
  level.forcegivesuper = &forcegivesuper;
  level.showuseresultsfeedback = &showuseresultsfeedback;
  level.ref_12c1f = &ref_12c1f;
  level.plunderrepositoryrestricted = &plunderrepositoryref;
  level.plunderrepositories = &plunderrankupdate;
  level.gasmaskadsdelay = getdvarint("scr_gm_allow_adsdelay", 1);
  level.gasmaskjumpingskip = getdvarint("scr_gm_allow_jumpingskip", 1);
  level.gasmaskjumpskipmanual = getdvarint("scr_gm_allow_jumpingskip_manual", 0);
  level.gasmasktoggledisable = getdvarint("OLLNLPLRR", 0);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&playergasmasktoggle);
  initarrays();
  toppercentagetoadjusteconomy();
}

function initarrays() {
  level.brloottablename = getDvar("RKMMNSQKO", "mp/loot/br/default/loot_item_defs.csv");

  if(!isDefined(level.br_pickups)) {
    level.br_pickups = spawnStruct();
  }

  level.br_pickups.init_relic_ammo_drain = [];
  level.br_pickups.removedforspacecallbacks = [];
  level.br_pickups.modetype = [];
  ref_12b33("brloot_equip_gasmask", &plundermusicfirst);
  ref_12b33("brloot_equip_gasmask_durable", &plundermusicfirst);
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
  var_0 = [];
  var_1 = 0;
  var_2 = "+";

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_3 = tablelookupgetnumrows(level.brloottablename);
    var_4 = getnospawntags();
    var_5 = 0;

    while(var_5 < var_3) {
      var_6 = tablelookupbyrow(level.brloottablename, var_5, 0);

      if(!isDefined(var_6)) {} else if(var_6 == "item") {
        var_7 = tablelookupbyrow(level.brloottablename, var_5, 2);

        if(!isDefined(var_7)) {
          goto LOC_00000ab5;
        }

        if(var_7 == "weapon") {
          var_8 = tablelookupbyrow(level.brloottablename, var_5, 1);
          var_9 = tablelookupbyrow(level.brloottablename, var_5, 3);
          var_10 = tablelookupbyrow(level.brloottablename, var_5, 5);
          var_11 = tablelookupbyrow(level.brloottablename, var_5, 15);
          jumpiffalse(isDefined(var_10) && var_10.size > 0) LOC_0000044d;
          var_12 = int(var_10);
          var_13 = tablelookup("loot/weapon_ids.csv", 0, var_12, 1);
          jumpiffalse(var_13 == "") LOC_000002e0;
          scripts\mp\utility\script::laststand_dogtags("lootID not found in weapon_ids.csv - lootID: " + var_10 + " in row " + var_5 + " from table " + level.brloottablename);
          goto LOC_00000ab5;
        } else {
          var_17 = tablelookupbyrow(level.brloottablename, var_11, 1);
          level.br_pickups.br_itemrow[var_17] = int(var_11);
          var_45 = tablelookupbyrow(level.brloottablename, var_11, 8);

          if(isDefined(var_45) && var_45.size > 0) {
            var_45 = tolower(var_45);
            level.br_pickups.br_equipname[var_17] = var_45;
            level.br_pickups.br_equipnametoscriptable[var_45] = var_17;
          }

          level.br_pickups.delay_delete_rpg_missile[var_17] = int(tablelookupbyrow(level.brloottablename, var_11, 24));
          var_46 = tablelookupbyrow(level.brloottablename, var_11, 16);

          if(var_46 != "") {
            switch (var_46) {
              case "1":
                if(isDefined(var_45) && var_45.size > 0) {
                  level.equipment.table[var_45].defaultslot = "primary";
                }

                level.br_throwables[level.br_throwables.size] = var_17;
                break;
              case "2":
                if(isDefined(var_45) && var_45.size > 0) {
                  level.equipment.table[var_45].defaultslot = "secondary";
                }

                level.br_usables[level.br_usables.size] = var_17;
                break;
              case "3":
                if(isDefined(var_45) && var_45.size > 0) {
                  level.equipment.table[var_45].defaultslot = "health";
                }

                break;
              case "4":
                if(isDefined(var_45) && var_45.size > 0) {
                  level.equipment.table[var_45].defaultslot = "super";
                }

                break;
              default:
                break;
            }
          }

          if(var_13 == "killstreak" || var_13 == "killstreak_nodrop") {
            var_47 = tablelookupbyrow(level.brloottablename, var_11, 19);
            level.br_pickups.br_killstreakreference[var_17] = var_47;
            level.br_pickups.br_killstreaktoscriptable[var_47] = var_17;
          } else if(var_13 == "super" || var_13 == "super_nodrop") {
            var_48 = tablelookupbyrow(level.brloottablename, var_11, 19);
            level.br_pickups.br_superreference[var_17] = var_48;
          } else if(var_13 == "perkpoint" || var_13 == "perkpoint_nodrop") {
            var_49 = tablelookupbyrow(level.brloottablename, var_11, 19);
            level.br_pickups.br_perkpoints[level.br_pickups.br_perkpoints.size] = var_17;
          } else if(var_13 == "lethal" || var_13 == "lethal_nodrop") {
            level.br_pickups.delay_push_player_clear_door_way[level.br_pickups.delay_push_player_clear_door_way.size] = var_17;
          } else if(var_13 == "tactical" || var_13 == "tactical_nodrop") {
            level.br_pickups.deletesoundents[level.br_pickups.deletesoundents.size] = var_17;
          }

          var_50 = int(tablelookupbyrow(level.brloottablename, var_11, 4));
          var_51 = int(tablelookupbyrow(level.brloottablename, var_11, 18));

          if(var_13 == "ammo") {
            level.br_ammo_max[var_17] = var_51;
          }

          level.br_pickups.maxcounts[var_17] = var_51;
          level.br_pickups.stackable[var_17] = var_51 > 1;
          level.br_pickups.counts[var_17] = var_50;
          var_13 = tolower(var_13);
          level.br_pickups.br_itemtype[var_17] = var_13;
          level.br_pickups.br_pickupsfx[var_17] = tablelookupbyrow(level.brloottablename, var_11, 15);
          var_52 = tablelookupbyrow(level.brloottablename, var_11, 3);
          level.br_pickups.delay_hide_player_clip[var_17] = int(var_52);
        }

        var_53 = tablelookupbyrow(level.brloottablename, var_11, 6);
        var_53 = strtok(var_53, "&");
        var_54 = scripts\engine\utility::array_has_intersection(var_53, var_10);
        level.br_pickups.delay_give_lethal_grenade[var_17] = var_54;
      } else if(var_12 == "crate") {
        var_17 = tablelookupbyrow(level.brloottablename, var_11, 1);
        var_55 = int(tablelookupbyrow(level.brloottablename, var_11, 2));

        if(var_55 > 0) {
          if(isDefined(level.br_lootiteminfo[var_17]) && isDefined(level.br_lootiteminfo[var_17].baseweapon)) {
            for(var_56 = 0; var_56 < var_55; var_56++) {
              level.br_pickups.br_crateguns[level.br_pickups.br_crateguns.size] = var_17;
              level.br_pickups.br_allguns[level.br_pickups.br_allguns.size] = var_17;
            }
          } else {
            for(var_56 = 0; var_56 < var_56; var_56++) {
              level.br_pickups.br_crateitems[level.br_pickups.br_crateitems.size] = var_18;
            }
          }
        }
      } else if(var_13 == "gulag") {
        var_18 = tablelookupbyrow(level.brloottablename, var_12, 1);
        var_57 = tablelookupbyrow(level.brloottablename, var_12, 2);

        if(!isDefined(level.br_pickups.br_gulagpickups[var_57])) {
          level.br_pickups.br_gulagpickups[var_57] = [];
        }

        var_58 = level.br_pickups.br_gulagpickups[var_57].size;
        level.br_pickups.br_gulagpickups[var_57][var_58] = var_18;
        LOC_00000ab5:
      }

      LOC_00000ab5:
        var_12++;
    }

    ref_12183("brloot_equip_gasmask", getdvarint("scr_br_gasMask_health", 108));
    ref_12183("brloot_equip_gasmask_durable", getdvarint("scr_br_gasMask_health_durable", 216));
    ref_12183("brloot_plate_pouch", 8);
  }

  setdvarifuninitialized("scr_br_disableLootDropTrail", 0);
  level.br_pickups.br_pickupdenyammonoroom = "MP/BR_AMMO_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyequipnoroom = "MP/BR_EQUIP_DENY_NO_ROOM";
  level.br_pickups.br_pickupdenyalreadyhaveweapon = "MP/BR_WEAPON_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyarmornotbetter = "MP/BR_ARMOR_DENY_NOT_BETTER";
  level.br_pickups.br_pickupdenyalreadyhaveks = "MP/BR_KILLSTREAK_DENY_ALREADY_HAVE";
  level.br_pickups.br_pickupdenyalreadyhaveredeploytoken = "MP_BR_INGAME/ALREADY_HAVE_RESPAWN_TOKEN";
  level.br_pickups.br_pickupdenyalreadyhavegulagtoken = "MP_BR_INGAME/ALREADY_HAVE_GULAG_TOKEN";
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
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups.ref_12cb7 = getdvarint("scr_br_respawn_token", 1);
  level.br_pickups.ref_12cb5 = getdvarint("scr_br_respawn_token_gulag", 1);
  level.br_pickups.gulagtokenclosewithgulag = getdvarint("scr_br_gulag_token_gulag", 1);
  level.br_pickups.modifydamagetohunter = getdvarint("scr_br_drop_specialist_pickup", 0);
  scripts\engine\scriptable::scriptable_addusedcallback(&lootused);
  scripts\engine\scriptable::ref_12f57(&lootused);
}

function ref_12183(var_0, var_1) {
  if(isDefined(level.br_pickups.counts[var_0]) && isDefined(var_1)) {
    level.br_pickups.counts[var_0] = var_1;
    return;
  }
}

function remove_roof_nodes(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;

  if(isDefined(var_1)) {
    var_4.angles = var_1;
  } else {
    var_4.angles = (0, 0, 0);
  }

  if(isDefined(var_2)) {
    var_4.ref_12223 = var_2;
  } else {
    var_4.ref_12223 = 0;
  }

  var_4.set_force_aitype_armored = var_3;
  return var_4;
}

function getitemdroporiginandangles(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1;
  var_9 = 1;
  var_10 = getdvarint("br_loot_trace_debug", 0);
  var_11 = 14;
  var_12 = 50;
  var_13 = 40;
  var_14 = -5;
  var_15 = 5;
  var_16 = 10;
  var_17 = 360 / var_11;
  var_18 = -5;
  var_19 = 5;
  var_20 = 40;
  var_21 = 20;
  var_22 = 60;
  var_23 = -6;
  var_24 = 16;
  var_25 = -18;
  var_26 = 0;
  var_27 = 0;
  var_28 = undefined;
  var_29 = var_24;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(isDefined(var_6)) {
    var_29 = var_6;
  }

  var_30 = int(var_0.ml_p3_to_safehouse_transition / var_11);
  var_31 = var_0.ml_p3_to_safehouse_transition - var_30 * var_11;
  var_32 = var_2[1] + var_31 * var_17 + var_30 * var_16 + randomfloatrange(var_18, var_19);
  var_33 = var_12 + var_30 * var_13 + randomfloatrange(var_14, var_15);

  if(isDefined(var_4)) {
    var_32 = var_2[1] + var_4;
  }

  if(isDefined(var_5)) {
    var_33 = var_5;
  }

  var_34 = (0, var_32, 0);
  var_35 = anglesToForward(var_34);
  var_36 = var_1 + var_35 * var_33;

  if(var_9) {
    var_37 = scripts\engine\utility::array_combine(tablesort(var_36, 500, 500), level.ref_1403d);

    if(isDefined(var_3)) {
      GscBinSkip0(0x2e, var_37.size, var_3);
    }

    var_38 = var_1 + (0, 0, var_21);
    var_39 = var_36 + (0, 0, var_21);
    var_40 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1);
    var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);

    if(var_41["fraction"] < 1) {
      var_36 = var_41["position"];
      var_36 += var_35 * var_25;
    } else {
      var_36 = var_39;
    }

    var_38 = var_36;
    var_39 = var_36 + (0, 0, var_22);
    var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);

    if(var_41["fraction"] < 1) {
      var_36 = var_41["position"] + (0, 0, var_23);
    } else {
      var_36 = var_39;
    }

    var_41 = undefined;

    if(istrue(var_7)) {
      var_41 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_36, 0, undefined, undefined, var_37);
    } else {
      var_38 = var_36;
      var_42 = -1 * getdvarfloat("bg_maxLootDropHeight", 2000);
      var_39 = var_36 + (0, 0, var_42);
      var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);
    }

    if(var_41["fraction"] < 1) {
      var_36 = var_41["position"] + (0, 0, var_29);
      var_28 = var_41["entity"];
    } else {
      var_36 = (0, 0, 0);
      var_26 = 1;
    }
  } else {
    var_36 += (0, 0, var_29);
  }

  if(var_8 && !var_26) {
    var_43 = scripts\engine\utility::ter_op(isDefined(self.intro_heli_add_player), self.intro_heli_add_player, var_20);
    var_27 = getscriptablereservedremaining(var_1 + (0, 0, var_43), var_36);
  }

  var_0.ml_p3_to_safehouse_transition++;
  return remove_roof_nodes(var_36, var_34, var_27, var_28);
}

function relics_monitor_on_player(var_0) {
  if(isDefined(var_0) && isDefined(level.br_lootiteminfo[var_0]) && isDefined(level.br_lootiteminfo[var_0].playerstartjailsetcontrols)) {
    return level.br_lootiteminfo[var_0].playerstartjailsetcontrols;
  }

  return undefined;
}

function relic_vampire_globalfunc(var_0) {
  if(isDefined(var_0) && isDefined(var_0.scriptablename)) {
    return relics_monitor_on_player(var_0.scriptablename);
  }

  return undefined;
}

function respawnplayer(var_0) {
  if(isDefined(var_0) && isDefined(var_0.scriptablename) && isDefined(level.br_pickups.delay_hide_player_clip[var_0.scriptablename])) {
    return level.br_pickups.delay_hide_player_clip[var_0.scriptablename];
  }

  return undefined;
}

function getgulagpickupsforclass(var_0) {
  var_1 = ["none"];

  if(isDefined(var_0) && isDefined(level.br_pickups.br_gulagpickups[var_0])) {
    var_1 = level.br_pickups.br_gulagpickups[var_0];
  }

  return var_1;
}

function ref_119ed(var_0) {
  return var_0.count >> 0 & 2047;
}

function ref_119ef(var_0) {
  return var_0.count >> 11 & 2047;
}

function ref_119ee(var_0) {
  return var_0.count >> 22 & 31;
}

function ref_119f5(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_4 += (var_1 & 2047) << 0;

  if(isDefined(var_2)) {
    var_4 += (var_2 & 2047) << 11;
  }

  if(isDefined(var_3)) {
    var_4 += (var_3 & 31) << 22;
  }

  var_0.count = var_4;
}

function ref_11a48(var_0) {
  if(var_0.type == "br_plunder_box" || var_0.type == "br_portable_kiosk" || var_0.type == "br_carriable_gasoline") {
    return true;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("lootUsedIgnore", var_0))) {
    return true;
  }

  if(istrue(var_0.ref_11a48)) {
    return true;
  }

  return false;
}

function lootused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipLootPickup", var_0)) || istrue(level.stop_end_breach_fx)) {
    return;
  }

  if(var_0 getscriptableisloot() && !ref_11a48(var_0)) {
    var_5 = spawnStruct();
    var_5.scriptablename = var_0.type;
    var_5.origin = var_0.origin;
    var_5.count = ref_119ed(var_0);
    var_5.impulsefx = ref_119ef(var_0);
    var_5.impactfunc_fire = ref_119ee(var_0);
    var_5.tracknonoobplayerlocation = var_0;
    var_5.customweaponname = var_0.customweaponname;
    var_5.maxcount = level.br_pickups.maxcounts[var_5.scriptablename];
    var_5.stackable = level.br_pickups.stackable[var_5.scriptablename];

    if(!var_5.count && isDefined(level.br_pickups.counts[var_5.scriptablename])) {
      var_5.count = level.br_pickups.counts[var_5.scriptablename];
    }

    var_5.isweaponfromcrate = var_0.isweaponfromcrate;
    var_5.turretsactive = var_4;

    if(isDefined(var_0.weapon)) {
      var_5.weapon = var_0.weapon;
      var_5.validpickupweapon = 1;
    }

    var_6 = cantakepickup(var_3, var_5);

    if(var_6 == 1) {
      var_7 = onusecompleted(var_3, var_5, undefined, var_4);

      if(isDefined(var_0) && var_7) {
        ref_119f5(var_0, var_5.count, var_5.impulsefx, var_5.impactfunc_fire);
      }

      if(!isDefined(var_0) || var_7) {
        return;
      }

      ref_11a21(var_0);
      return;
    }

    var_8 = 1;
    var_9 = level.br_pickups.delay_delete_rpg_missile[var_5.scriptablename];

    if(var_4 && istrue(var_9) && var_2 == "visible") {
      var_8 = 0;
    }

    if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e07("skipPickupFeedback", var_5, var_4, var_2, var_3))) {
      var_8 = 0;
    }

    if(var_6 == 17 || var_6 == 21) {
      var_8 = 0;
    }

    if(var_8) {
      var_10 = scripts\mp\gametypes\br_gametypes::ref_12e06("lootUsedGiveFeedback", var_5, var_3, var_6);

      if(!isDefined(var_10)) {
        if(var_6 == 3) {
          var_3 playlocalsound("weap_ammo_full");
        } else if(var_6 == 25) {
          var_3 playlocalsound("br_pickup_ammo");
        } else {
          var_3 playlocalsound("br_pickup_deny");
        }

        showuseresultsfeedback(var_3, var_6);
        return;
      }

      return;
    }

    return;
  }
}

function islootcache(var_0) {
  return var_0.type == "br_loot_cache" || var_0.type == "br_loot_cache_lege" || var_0.type == "br_reusable_loot_cache" || var_0.type == "br_loot_cache_rogue";
}

function update_gamebattles_char_loc(var_0, var_1) {
  if(islootcache(var_0)) {
    return var_1;
  }

  if(var_0.type == "brloot_escape_radio" || var_0.type == "br_cargotrain" || var_0.type == "br_cargotrain_engine" || var_0.type == "br_armortrain" || var_0.type == "br_armortrain_engine" || var_0.type == "br_tramway") {
    return 0;
  }

  return 1;
}

function ref_11a21(var_0, var_1) {
  if(var_0 getscriptableislinked()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0.type;
  }

  if(usb(var_0.type)) {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      level notify("tablethide_kill_callout_" + var_0.origin);
    }

    scripts\mp\gametypes\br_quest_util::ref_1207a(var_0);
  }

  if(var_0 getscriptableisreserved() && !istrue(var_0.keepinmap)) {
    lastunrulyscore(var_0);
    var_0 freescriptable();
    return;
  }

  var_0 setscriptablepartstate(var_1, "hidden");
}

function br_forcegivecustomreward(var_0, var_1, var_2, var_3) {
  var_4 = br_createcustompickupitem(var_0, var_1, var_3);
  onusecompleted(var_0, var_4, var_2, undefined, 0);
}

function br_forcegivecustompickupitem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_5)) {
    minsteps(var_0, var_1, var_3, var_4, var_5);
    return true;
  }

  var_6 = br_createcustompickupitem(var_0, var_1, var_3);
  var_7 = cantakepickup(var_0, var_6);

  if(var_7 == 1) {
    onusecompleted(var_0, var_6, var_2, undefined, var_4);
    return true;
  }

  return false;
}

function br_createcustompickupitem(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.scriptablename = var_1;
  var_3.origin = var_0.origin;
  var_3.count = 0;
  var_3.maxcount = level.br_pickups.maxcounts[var_3.scriptablename];
  var_3.stackable = level.br_pickups.stackable[var_3.scriptablename];

  if(isDefined(var_2)) {
    var_3.count = var_2;
  }

  if(!var_3.count && isDefined(level.br_pickups.counts[var_3.scriptablename])) {
    var_3.count = level.br_pickups.counts[var_3.scriptablename];
  }

  return var_3;
}

function resetplayerinventorywithdelay(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  wait var_0;
  resetplayerinventory(var_1);
}

function resetplayerinventory(var_0) {
  var_1 = scripts\mp\utility\game::round_vehicle_logic() == "kingslayer";
  self.br_inventory_slots = [];

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    scripts\mp\gametypes\br_armor::disable_map_ammo_munitions();
  }

  disable_near_snake_cam_after_open();

  if(isDefined(self.streakdata) && !var_1 && !istrue(level.ref_133d7)) {
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  }

  if(!level.allowsupers) {
    ref_12c81();
  }

  if(!istrue(var_0)) {
    scripts\mp\gametypes\br_weapons::stripweaponsfromplayer();
    scripts\mp\equipment::takeequipment("primary");
    scripts\mp\equipment::takeequipment("secondary");
    scripts\mp\weapons::ref_1316b(getcompleteweaponname("iw8_fists_mp"));
  }

  if(scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
    ref_12c1f();
    return;
  }
}

function ref_12c81() {
  scripts\mp\supers::clearsuper();
  self setclientomnvar("ui_perk_package_state", 0);
  self setclientomnvar("ui_super_progress", 0);
}

function resetdefaultweaponammo(var_0) {
  var_1 = self getweaponslistall();
  var_2 = 0;

  while(var_2 < var_1.size) {
    var_3 = var_1[var_2];
    var_4 = 0;

    if(var_3.inventorytype == "primary") {
      if(isDefined(var_0)) {
        var_5 = var_3.clipsize;
        var_4 = var_5 * (var_0 - 1);
      } else if(level.magcount > 0) {
        var_5 = var_4.clipsize;
        var_5 *= level.magcount - 1;
      } else {
        var_5 = 0;
      }

      self setweaponammoclip(var_5, var_5);
    }

    var_4++;
  }
}

function initplayer(var_0) {
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  resetplayerinventory(var_0);
}

function spawndebugpickupfromdevgui(var_0) {
  foreach(var_2 in level.players) {
    if(!isbot(var_2) && isalive(var_2)) {
      var_3 = var_2.origin + anglesToForward(var_2.angles) * 100 + (0, 0, 12);
      var_4 = 0;

      if(isDefined(level.br_pickups.counts[var_0])) {
        var_4 = level.br_pickups.counts[var_0];
      }

      var_5 = remove_roof_nodes(var_3);
      var_6 = spawnpickup(var_0, var_5, var_4);

      if(isDefined(var_6)) {
        var_7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
        var_8 = [var_6];
        var_9 = var_6.origin + (0, 0, 50);
        var_10 = var_9 + (0, 0, -200);
        var_11 = scripts\engine\trace::ray_trace(var_9, var_10, var_8, var_7);

        if(isDefined(var_11["entity"]) && isDefined(var_11["entity"].targetname) && var_11["entity"].targetname == "train_wz") {
          var_12 = var_11["entity"];
          var_13 = rotatevectorinverted(var_6.origin - var_12.origin, var_12.angles);
          var_14 = combineangles(invertangles(var_12.angles), var_6.angles);
          var_6 validatecollision(var_12, var_13, var_14);
        }
      }
    }
  }
}

function isweaponpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "weapon";
}

function isweaponpickupitem(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.weapon)) {
    return (istrue(var_0.weapon.iscustomweapon) || istrue(var_0.validpickupweapon));
  } else if(isDefined(var_0.scriptablename)) {
    return isweaponpickup(var_0.scriptablename);
  }

  return false;
}

function takearmorpickup(var_0) {
  var_1 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_2 = scripts\mp\gametypes\br_armor::isarmorbetterthanequipped(var_1);

  if(var_2) {
    tryequiparmor(var_0);
    return;
  }
}

function takeequipmentpickup(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.equipment.table[var_2].defaultslot;
  var_4 = 0;

  if(pickupissameasequipmentslot(var_2, var_3)) {
    if(equipmentslothasroom(var_2, var_3)) {
      if(var_3 != "health") {
        scripts\mp\damagefeedback::hudicontype("br_ammo");
      }

      var_5 = scripts\mp\equipment::getequipmentslotammo(var_3);
      var_6 = scripts\mp\equipment::getequipmentmaxammo(var_2);

      if(var_5 + var_0.count > var_6) {
        var_7 = var_6 - var_5;
        scripts\mp\equipment::setequipmentammo(var_2, var_6);
        var_0.count -= var_7;
        var_4 = 1;
      } else {
        scripts\mp\equipment::incrementequipmentslotammo(var_3, var_0.count);
      }
    } else if(!getdvarint("scr_br_no_inventory", 1)) {
      trypickupitem(var_0.scriptablename, var_0.count);
    }
  } else if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentammo(var_2, var_0.count);
  } else if(!getdvarint("scr_br_no_inventory", 1)) {
    var_8 = 1;

    if(isDefined(var_0.count)) {
      var_8 = var_0.count;
    }

    trypickupitem(var_0.scriptablename, var_8);
  } else {
    var_9 = test_ai_anim();
    dropequipmentinslot(var_9, var_3, var_1);
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentammo(var_2, var_0.count);
  }

  return var_4;
}

function dropequipmentinslot(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\equipment::getequipmentslotammo(var_1);

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[var_1]);

  if(isDefined(var_5)) {
    var_6 = undefined;

    if(istrue(var_2)) {
      var_6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
    }

    var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
    var_8 = 0;
    var_9 = spawnpickup(var_5, var_7, var_4, 1);

    if(isDefined(var_9)) {
      modeloadoutupdateammo(var_9, self, var_5);
      return;
    }

    return;
  }
}

function modeloadoutupdateammo(var_0, var_1) {
  var_2 = self;

  if(var_1 == "brloot_offhand_geigercounter") {
    var_2.owner = var_0;
    var_0.modespawnclient = var_2;
    return;
  }
}

function pickupissameasequipmentslot(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && self.equipment[var_1] == var_0) {
    return true;
  }

  return false;
}

function equipmentslothasroom(var_0, var_1) {
  if(scripts\mp\equipment::getequipmentslotammo(var_1) < scripts\mp\equipment::getequipmentmaxammo(var_0)) {
    return true;
  }

  return false;
}

function takerespawntokenpickup(var_0) {
  if(!ref_12cb6() && !scripts\mp\gametypes\br_public::hasrespawntoken()) {
    addrespawntoken();
    return true;
  }

  return false;
}

function addrespawntoken(var_0) {
  var_1 = self;
  var_1.hasrespawntoken = 1;
  var_1 scripts\mp\gametypes\br_public::ref_1315b(1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_respawn_token_pickup");
    return;
  }
}

function removerespawntoken() {
  var_0 = self;
  var_0.hasrespawntoken = 0;
  var_0 scripts\mp\gametypes\br_public::ref_1315b(0);
}

function takegulagtokenpickup(var_0) {
  if(istrue(level.usegulag) && !scripts\mp\gametypes\br_public::hasgulagtoken()) {
    addgulagtoken();
    return true;
  }

  return false;
}

function addgulagtoken(var_0) {
  var_1 = self;
  var_1.hasgulagtoken = 1;
  var_1 scripts\mp\gametypes\br_public::setcanusegulagextrainfo(1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_gulag_token_pickup");
    return;
  }
}

function removegulagtoken() {
  var_0 = self;
  var_0.hasgulagtoken = 0;
  var_0 scripts\mp\gametypes\br_public::setcanusegulagextrainfo(0);
}

function ref_13a39(var_0) {
  if(!scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
    bdroppingshield();
    return true;
  }

  return false;
}

function bdroppingshield(var_0) {
  var_1 = self;
  var_1.shouldgetnewspawnpoint = 1;
  var_1 scripts\mp\gametypes\br_public::ref_1315c(1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_self_revive_token_pickup");
  }

  var_2 = level.maxteamsize == 1;

  if(var_2 && !var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_1 scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
    return;
  }
}

function ref_12c1f() {
  var_0 = self;
  var_0.shouldgetnewspawnpoint = 0;
  var_0 scripts\mp\gametypes\br_public::ref_1315c(0);
  var_1 = level.maxteamsize == 1;

  if(var_1 && var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    return;
  }
}

function ref_12cb6() {
  return getdvarint("scr_br_all_assassin_version", 0) || !istrue(level.br_pickups.ref_12cb7) || istrue(level.br_pickups.ref_12cb5) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

function battle_tracks_tryplayingbattletrackswhenstandingonvehicle(var_0) {
  var_1 = self;
  self playsoundtoplayer("br_legendary_loot_pickup", self);
  var_1.should_use_velo_forward = 1;
  var_1 setclientomnvar("ui_br_has_plate_pouch", 1);
  var_1 scripts\mp\gametypes\br_public::sethasplatepouchextrainfo(1);

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("br_plate_pouch_pickup");
    return;
  }
}

function ref_12c16() {
  var_0 = self;
  var_0 setclientomnvar("ui_br_has_plate_pouch", 0);
  var_0 scripts\mp\gametypes\br_public::sethasplatepouchextrainfo(0);
  var_0.should_use_velo_forward = 0;
}

function play_hud_reminder_vo() {
  var_0 = self;
  var_1 = spawnStruct();
  var_1.scriptablename = "brloot_armor_plate";
  var_1.nvgvisionsetoverride = level.br_pickups.br_equipname[var_1.scriptablename];
  var_1.origin = self.origin;
  var_1.maxcount = scripts\mp\equipment::getequipmentmaxammo(var_1.nvgvisionsetoverride);
  var_1.count = var_1.maxcount;
  var_1.stackable = level.br_pickups.stackable[var_1.scriptablename];
  takeequipmentpickup(var_0, var_1);
}

function ref_13a2f(var_0) {
  if(scripts\mp\gametypes\br_public::should_damage_pavelow_boss()) {
    var_1 = test_ai_anim();
    var_2 = undefined;
    var_3 = getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_2);
    spawnpickup(self.armorylights, var_3, 1, 1);
  }

  battle_tracks_getbattletracksid(var_0.scriptablename);
}

function takesecretwinebottle(var_0) {
  if(!isDefined(self.small_island_key_items)) {
    self.small_island_key_items = [];
  }

  if(!isDefined(self.small_island_key_items["secret_bottle"])) {
    self.small_island_key_items["secret_bottle"] = 1;
    return;
  }

  if(self.small_island_key_items["secret_bottle"] >= level.small_island_secrets_struct.keyitemholdcount["secret_bottle"]) {
    var_1 = test_ai_anim();
    var_2 = undefined;
    var_3 = getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_2);
    spawnpickup("brloot_dropped_secret_bottle", var_3, 1, 1);
    return;
  }

  self.small_island_key_items["secret_bottle"] = self.small_island_key_items["secret_bottle"] + 1;
}

function takesecretshovel(var_0) {
  if(!isDefined(self.small_island_key_items)) {
    self.small_island_key_items = [];
  }

  if(!isDefined(self.small_island_key_items["shovel"])) {
    self.small_island_key_items["shovel"] = 1;

    foreach(var_2 in level.buried_treasure_piles) {
      var_2 enablescriptablepartplayeruse("secret_burried_treasure", self);
      var_2 disablescriptablepartplayeruse("secret_burried_treasure_no_shovel", self);
    }

    return;
  }

  if(self.small_island_key_items["shovel"] >= level.small_island_secrets_struct.keyitemholdcount["shovel"]) {
    var_4 = test_ai_anim();
    var_5 = undefined;
    var_6 = getitemdroporiginandangles(var_4, self.origin, self.angles, self, var_5);
    spawnpickup("brloot_dropped_secret_shovel", var_6, 1, 1);
    return;
  }
}

function battle_tracks_getbattletracksid(var_0) {
  var_1 = self;
  var_1.armorylights = var_0;
  var_2 = int(tablelookup("mp/braccess_card.csv", 1, var_0, 0));
  var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("bunkerKeycardType", var_2);
  var_1 scripts\mp\gametypes\br_alt_mode_zai::ref_11ff9(var_0);
}

function ref_12bfc() {
  var_0 = self;

  if(getdvarint("scr_br_bunkersNoKeycardRequired", 0)) {}

  var_0 scripts\mp\gametypes\br_alt_mode_zai::ref_1207d(var_0.armorylights);
  var_0.armorylights = undefined;
  var_0 scripts\mp\gametypes\br_public::updatebrscoreboardstat("bunkerKeycardType", 0);
}

function ref_13a33(var_0) {
  var_1 = var_0.scriptablename;

  if(var_1 == "brloot_x1_map_fragment") {
    return;
  }
}

function takequestitem(var_0) {
  var_1 = var_0.scriptablename;

  if(var_1 == "brloot_x2_stash_bomb") {
    var_0 scripts\mp\gametypes\br_x2_stash_quest::ref_14654(self);
    return;
  }
}

function battle_tracks_togglethink(var_0) {
  var_1 = self;
  var_2 = scripts\mp\perks\perks::hudcost(var_0.scriptablename);
  self playsoundtoplayer("br_legendary_loot_pickup", self);

  if(isDefined(var_2) && var_2 != "") {
    var_1 scripts\mp\perks\perks::battle_tracks_tryinittogglestate(var_2);
    return;
  }
}

function bearsetup(var_0) {
  var_1 = self;
  self playsoundtoplayer("br_legendary_loot_pickup", self);
  var_1.should_enter_combat_after_checking_decoy_grenade = 1;
  var_1 scripts\mp\perks\perks::bears();

  if(!istrue(var_0)) {
    var_1 thread scripts\mp\hud_message::showsplash("specialist_perk_bonus");
    return;
  }
}

function ref_12c26() {
  var_0 = self;
  var_0.should_enter_combat_after_checking_decoy_grenade = 0;
  var_0 scripts\mp\perks\perks::ref_12c25();
}

function playerpackdataintogulagomnvar(var_0, var_1, var_2, var_3) {
  self notify("cancel_all_killstreak_deployments");

  if(istrue(var_3)) {
    var_4 = test_ai_anim();
    missing_window_blockers(var_4, var_2, var_3, var_0);
    return;
  }

  if(istrue(var_2)) {
    var_4 = test_ai_anim();
    missing_window_blockers(var_4, var_3);
  } else {
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  }

  scripts\mp\killstreaks\killstreaks::awardkillstreak(var_1, "other", undefined, undefined, undefined, 1);
}

function takekillstreakpickup(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation.spawnprojectile)) {
    self.spawnx1stashlootcache = var_0.tracknonoobplayerlocation.spawnprojectile;
  }

  send_notify_after_player_tac_vis(var_0.scriptablename, var_1);
}

function send_notify_after_player_tac_vis(var_0, var_1) {
  var_2 = level.br_pickups.br_killstreakreference[var_0];

  if(unset_relic_dogtags(var_2)) {
    playerkilledspawn(var_2);
    return;
  }

  playerpackdataintogulagomnvar(var_2, 1, var_1);
}

function should_do_vo_call() {
  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0) {
    return isDefined(self.streakdata.streaks[1]);
  }

  return false;
}

function haskillstreak(var_0) {
  return should_do_vo_call() && self.streakdata.streaks[1].streakname == var_0;
}

function show_getcash_hint() {
  return haskillstreak("explosive_bow");
}

function unset_relic_dogtags(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "circle_peek":
      var_1 = 1;
      break;
  }

  return var_1;
}

function playerkilledspawn(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(var_0);

  if(isDefined(var_1) && isDefined(var_1.linkedtotag)) {
    self[[var_1.linkedtotag]]();
    return;
  }
}

function forceusekillstreak(var_0) {
  if(should_do_vo_call()) {
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);
  }

  scripts\mp\killstreaks\killstreaks::awardkillstreak(var_0, "other", undefined, undefined, undefined, 1);
  var_1 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);
  var_2 = scripts\mp\killstreaks\killstreaks::triggerkillstreak(var_1, 1);

  if(!var_2) {
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);
  }

  return var_2;
}

function _givebrsuper(var_0, var_1, var_2) {
  if(level.allowsupers) {
    scripts\mp\perks\perkpackage::ref_12300(var_1);
    var_2 = scripts\mp\supers::getcurrentsuperpoints() >= scripts\mp\supers::getsuperpointsneeded();
  } else {
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate(var_1);
    self setclientomnvar("ui_perk_package_state", 3);
    self setclientomnvar("ui_perk_package_super1", scripts\mp\supers::getsuperid(var_1));
    self setclientomnvar("ui_super_progress", 1);
  }

  if(isDefined(var_0)) {
    scripts\mp\equipment::giveequipment(var_0, "super");
    scripts\mp\equipment::setequipmentammo(var_0, var_2);

    if(istrue(self.issuperdisabled)) {
      self.loadoutextraperksfromgamemode = var_2;
      return;
    }

    return;
  }
}

function takesuperpickup(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.br_pickups.br_superreference[var_0.scriptablename];
  var_4 = undefined;

  if(isDefined(self.equipment["super"])) {
    var_4 = scripts\mp\equipment::getequipmentslotammo("super");

    if(!isDefined(var_4)) {
      scripts\mp\utility\script::laststand_dogtags("Player has super," + self.equipment["super"] + ", but ammo is undefined.");
    }
  }

  if(isDefined(self.equipment["super"]) && isDefined(var_4) && (var_4 > 0 || mortar_add_fov_user_scale())) {
    var_5 = test_ai_anim();
    dropequipmentinslot(var_5, "super", var_1);
  }

  _givebrsuper(var_2, var_3, var_0.count);

  if(level.allowsupers) {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
    return;
  }
}

function mortar_add_fov_user_scale() {
  if(istrue(self.unmark_on_death)) {
    if(isDefined(self.super) && !self.super.usepercent) {
      return true;
    }
  }

  return false;
}

function forcegivesuper(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_6 in level.br_pickups.br_superreference) {
    if(var_6 == var_0) {
      var_4 = var_7;
      break;
    }
  }

  var_8 = undefined;

  if(isDefined(var_4)) {
    var_8 = level.br_pickups.br_equipname[var_4];

    if(istrue(var_3)) {
      var_9 = test_ai_anim();
      mintokensdropondeath(var_9, var_2, var_3, var_8);
      return;
    }

    if(istrue(var_2)) {
      if(isDefined(self.equipment["super"]) && scripts\mp\equipment::getequipmentslotammo("super") > 0) {
        var_9 = test_ai_anim();
        dropequipmentinslot(var_9, "super", var_3);
      }
    }
  }

  _givebrsuper(var_9, var_1, 1);
}

function takegasmask(var_0, var_1) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_2 = undefined;

    if(istrue(var_1)) {
      var_2 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
    }

    var_3 = test_ai_anim();
    var_4 = getitemdroporiginandangles(var_3, self.origin, self.angles, self, var_2);
    spawnpickup(self.plundersilentcountdownendtime, var_4, int(self.gasmaskhealth), 1);
  }

  scripts\cp_mp\gasmask::init(var_0.count, var_0.scriptablename);

  if(scripts\cp_mp\gasmask::unlocked_escape_door(var_0.scriptablename)) {
    scripts\mp\gametypes\br_public::sethasgasmaskextrainfo(2);
    return;
  }

  scripts\mp\gametypes\br_public::sethasgasmaskextrainfo(1);
}

function plunderrepositoryref(var_0) {
  if(!isDefined(self.plunderrepositorywidget)) {
    self.plunderrepositorywidget = [];
  }

  if(isDefined(self.plunderrepositorywidget[var_0])) {
    return;
  }

  self.plunderrepositorywidget[var_0] = 1;
  thread ai_push_forward_watcher();
}

function plunderrankupdate(var_0) {
  if(!isDefined(self.plunderrepositorywidget)) {
    self.plunderrepositorywidget = [];
  }

  if(!isDefined(self.plunderrepositorywidget[var_0])) {
    return;
  }

  self.plunderrepositorywidget[var_0] = undefined;
  thread ai_push_forward_watcher();
}

function ai_push_forward_watcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(level.gasmasktoggledisable)) {
    var_0 = self method_87eb();

    if(var_0) {
      return;
    }
  }

  if(istrue(self.gasmaskswapinprogress)) {
    scripts\engine\utility::waittill_notify_or_timeout("gas_mask_swap_complete", 2);
    waitframe();
  }

  self notify("gasMaskUpdateOnOff");
  self endon("gasMaskUpdateOnOff");
  waittillframeend();

  if(istrue(self.gasmaskequipped) && (!isDefined(self.plunderrepositorywidget) || !self.plunderrepositorywidget.size)) {
    thread ref_12c05();
    return;
  }

  if(!istrue(self.gasmaskequipped) && isDefined(self.plunderrepositorywidget) && self.plunderrepositorywidget.size) {
    thread numkilled();
    return;
  }
}

function ks_circlecount(var_0) {
  var_1 = 0;
  var_1 |= var_0 isreloading();
  var_1 |= var_0 isthrowinggrenade();

  if(level.gasmaskadsdelay != 0) {
    var_1 |= var_0 scripts\mp\utility\player::isplayerads();
  }

  return var_1;
}

function get_area_clear_alias() {
  var_0 = 0;
  var_1 = self;
  var_0 |= var_1 scripts\cp_mp\utility\player_utility::isinvehicle(1);
  var_0 |= var_1 isinfreefall();
  var_0 |= var_1 isparachuting();
  var_0 |= var_1 setautoboxcalculationusingdobj();

  if(level.gasmaskjumpingskip != 0 && (!playerhasgasmasktoggle(var_1) || level.gasmaskjumpskipmanual != 0)) {
    var_0 |= var_1 isjumping();
  }

  return !var_0;
}

function playerhasgasmasktoggle() {
  if(!getdvarint("OLLNLPLRR")) {
    var_0 = self method_87eb();
    return var_0;
  }

  return 0;
}

function numkilled() {
  self endon("game_ended");
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  self.gasmaskswapinprogress = 1;
  thread kiosksetupfiresaleforplayer(0.2);
  var_0 = self getgestureanimlength("ges_magma_gas_mask_on");

  if(get_area_clear_alias()) {
    thread ref_12735("iw8_ges_plyr_gasmask_on", var_0);
  }

  self setclientomnvar("ui_gas_mask", 2);
  wait var_0;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("gasmask_female");
  } else {
    self method_87aa("gasmask_male");
  }

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0) {
    disable_near_snake_cam_after_open();
    return;
  }
}

function ref_12735(var_0, var_1) {
  self endon("game_ended");
  self endon("death_or_disconnect");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);

  while(get_area_clear_alias() && var_1 > 0) {
    if(var_1 > 1) {
      var_3 = 1;
      var_1 -= 1;
    } else {
      var_3 = var_1;
      var_1 = 0;
    }

    wait var_3;
  }

  if(self hasweapon(var_2)) {
    self takeweapon(var_2);
    return;
  }
}

function ref_12c05() {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_off_plr", self);
  var_0 = self getgestureanimlength("ges_magma_gas_mask_off");
  thread knock_player_forward(1.3);

  if(get_area_clear_alias()) {
    thread ref_12735("iw8_ges_plyr_gasmask_off", var_0);
  }

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 1);
  wait var_0;
  self.gasmaskswapinprogress = 0;
  self setclientomnvar("ui_gas_mask", 0);
  self notify("gas_mask_swap_complete");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  if(!isDefined(self.gasmaskhealth) || self.gasmaskhealth <= 0) {
    handleweaponreloadammodrop();
    return;
  }
}

function disable_near_snake_cam_after_open() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }

  self playsoundtoplayer("br_gas_mask_crack_plr", self);
  thread kothlaststarttime(0.6);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  handleweaponreloadammodrop();
  var_0 = self getgestureanimlength("ges_magma_gas_mask_break");

  if(self isonground()) {
    thread scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_gasmask_break", var_0);
  } else {
    var_1 = self.origin;
    var_2 = scripts\mp\gametypes\br_public::modifytriggerlocation(var_1, 0, -100000);
    var_3 = var_1[2] - var_2["position"][2];

    if(var_3 < getdvarfloat("scr_br_gasmask_animation_max_height", 40)) {
      thread scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_gasmask_break", var_0);
    }
  }

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("ui_gas_mask", 3);
  wait var_0;
  self.gasmaskswapinprogress = 0;
  self notify("gas_mask_swap_complete");
}

function kiosksetupfiresaleforplayer(var_0) {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  self attach("hat_child_hadir_gas_mask_wm_br", "j_head");
}

function knock_player_forward(var_0) {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
    return;
  }
}

function kothlaststarttime(var_0) {
  self endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(var_0) && var_0 > 0.1) {
    wait var_0 - 0.1;
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_gas_mask_break"), self, "tag_weapon_left");
  wait 0.1;

  if(self.gasmaskequipped) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
    return;
  }
}

function playergasmasktoggle(var_0, var_1) {
  if(!getdvarint("OLLNLPLRR")) {
    if(var_0 == "gas_mask_toggle" && scripts\cp_mp\gasmask::hasgasmask(self) && !istrue(self.gasmaskswapinprogress)) {
      var_2 = self method_87eb();

      if(var_2) {
        if(istrue(self.gasmaskequipped)) {
          thread ref_12c05();
          return;
        }

        if(!istrue(self.gasmaskequipped)) {
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

function canholdammobox(var_0) {
  if(!isDefined(self.br_ammo[var_0])) {
    return true;
  }

  return !scripts\mp\gametypes\br_weapons::br_ammo_type_player_full(self, var_0);
}

function isvest(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "armor" && issubstr(var_0, "vest");
}

function isgasmask(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "gear" && issubstr(var_0, "gasmask");
}

function usereload(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "specialist" && issubstr(var_0, "specialist_bonus");
}

function isplunder(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "plunder";
}

function usb(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "tablet";
}

function uniquelootitemlookup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "questitem_dogtag";
}

function usablecarriables(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "questitem_misc";
}

function isperkpointpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "perkpoint";
}

function istokenpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "token";
}

function use_milcrate(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "revive";
}

function iskillstreak(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "killstreak" || level.br_pickups.br_itemtype[var_0] == "killstreak_nodrop");
}

function issuperpickup(var_0) {
  return !update_operator_east_char_loc(var_0) && isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "super" || level.br_pickups.br_itemtype[var_0] == "super_nodrop");
}

function isplunderextract(var_0) {
  return var_0 == "brloot_plunder_extract";
}

function updatecollectionui(var_0) {
  return var_0 == "brloot_plate_pouch";
}

function turn_on_red_lights_along_track(var_0) {
  return issubstr(var_0, "access_card");
}

function update_operator_east_char_loc(var_0) {
  return var_0 == "br_loot_cache" || usb(var_0);
}

function update_player_about_remaining_enemies(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "objective";
}

function isinteltype(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "intel";
}

function issecretwinebottle(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && var_0 == "brloot_dropped_secret_bottle";
}

function issecretshovel(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && var_0 == "brloot_dropped_secret_shovel";
}

function cantakepickup(var_0) {
  if(self isskydiving()) {
    return 9;
  }

  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("canTakePickupLoot", var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  if(scripts\mp\gametypes\br_public::isammo(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback()) {
      return 16;
    }

    if(!canholdammobox(var_0.scriptablename)) {
      return 3;
    } else {
      return 1;
    }
  }

  if(isweaponpickupitem(var_0)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback()) {
      return 16;
    }

    if(istrue(self.tracking_max_health)) {
      return 13;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return 17;
    }

    if(_debug_rooftop_activesat::closedangles()) {
      return 21;
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::isequipment(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(var_0.scriptablename == "brloot_offhand_geigercounter") {
      if(self != var_0.tracknonoobplayerlocation.owner) {
        return 20;
      } else {
        self.modespawnclient = undefined;
      }
    }

    var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
    var_3 = level.equipment.table[var_2].defaultslot;
    var_4 = istrue(var_0.turretsactive);

    if(!isDefined(var_3)) {
      scripts\mp\utility\script::laststand_dogtags("No slot found for equipment : scriptableName = " + var_0.scriptablename + ", equipName = " + scripts\engine\utility::ter_op(isDefined(var_2), var_2, "?"));
      return 4;
    }

    var_5 = 1;

    if(isDefined(var_0.count)) {
      var_5 = var_0.count;
    }

    if(var_4 && (var_3 == "primary" || var_3 == "secondary")) {
      if(isDefined(self.equipment[var_3]) && pickupissameasequipmentslot(var_2, var_3) && equipmentslothasroom(var_2, var_3)) {
        return 1;
      }

      return 12;
    }

    if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0) {
      return 1;
    }

    if(pickupissameasequipmentslot(var_2, var_3)) {
      if(equipmentslothasroom(var_2, var_3)) {
        return 1;
      } else if(getdvarint("scr_br_no_inventory", 1)) {
        return 4;
      }
    }

    if(getdvarint("scr_br_no_inventory", 1)) {
      return 1;
    }

    if(!canslotitem(var_0.scriptablename, var_5)) {
      return 4;
    } else {
      return 1;
    }
  }

  if(isplunder(var_0.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.ref_127bf) && self.plundercount >= level.br_plunder.ref_127bf) {
      return 11;
    }

    return 1;
  }

  if(isgasmask(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    return 1;
  }

  if(usb(var_0.scriptablename)) {
    if(var_0.scriptablename == "brloot_blueprintextract_tablet" || var_0.scriptablename == "brloot_blueprintextract_tablet_easterevent") {
      return 1;
    } else if(istrue(level.questinfo.ref_132e8) && scripts\engine\utility::array_contains(level.questinfo.ref_13745, self.team + self.squadindex) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, self.team)) {
      return 10;
    } else {
      logstring("Quest Tablet picked up at " + gettime() + ", team = " + self.team + ", shouldApplyToSquad = " + istrue(level.questinfo.ref_132e8) + ", squadIndex = " + scripts\engine\utility::ter_op(isDefined(self.squadindex), self.squadindex, -1));
      return 1;
    }
  }

  if(isperkpointpickup(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    var_6 = scripts\mp\perks\perks::hudcost(var_0.scriptablename);

    if(!getdvarint("scr_perk_point_duplicates_allowed", 0) && scripts\mp\utility\perk::_hasperk(var_6)) {
      return 27;
    }

    if(var_6 == "specialty_warhead") {
      thread scripts\mp\events::killeventtextpopup("br_amped_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_tac_resist") {
      thread scripts\mp\events::killeventtextpopup("br_battle_hardened_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_br_advancedscout") {
      thread scripts\mp\events::killeventtextpopup("br_combat_scout_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_tactical_recon") {
      thread scripts\mp\events::killeventtextpopup("br_engineer_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_extra_shrapnel") {
      thread scripts\mp\events::killeventtextpopup("br_shrapnel_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_tune_up") {
      thread scripts\mp\events::killeventtextpopup("br_tune_up_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_huntmaster") {
      thread scripts\mp\events::killeventtextpopup("br_tracker_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_guerrilla") {
      thread scripts\mp\events::killeventtextpopup("br_ghost_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_hardline") {
      thread scripts\mp\events::killeventtextpopup("br_hardline_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_surveillance") {
      thread scripts\mp\events::killeventtextpopup("br_high_alert_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_munitions_2") {
      thread scripts\mp\events::killeventtextpopup("br_overkill_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_strategist") {
      thread scripts\mp\events::killeventtextpopup("br_pointman_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_restock") {
      thread scripts\mp\events::killeventtextpopup("br_restock_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_br_reinforced") {
      thread scripts\mp\events::killeventtextpopup("br_tempered_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_quick_fix") {
      thread scripts\mp\events::killeventtextpopup("br_quick_fix_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_covert_ops") {
      thread scripts\mp\events::killeventtextpopup("br_cold_blooded_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_hustle") {
      thread scripts\mp\events::killeventtextpopup("br_double_time_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_eod") {
      thread scripts\mp\events::killeventtextpopup("br_eod_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_heavy_metal") {
      thread scripts\mp\events::killeventtextpopup("br_kill_chain_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_scavenger_plus") {
      thread scripts\mp\events::killeventtextpopup("br_scavenger_perk_loot", 0, 0);
    }

    if(var_6 == "specialty_br_serpentine") {
      thread scripts\mp\events::killeventtextpopup("br_serpentine_perk_loot", 0, 0);
    }

    if(var_6 == "yellow") {
      thread scripts\mp\events::killeventtextpopup("br_yellow_perks_loot", 0, 0);
    }

    if(var_6 == "red") {
      thread scripts\mp\events::killeventtextpopup("br_red_perks_loot", 0, 0);
    }

    if(var_6 == "blue") {
      thread scripts\mp\events::killeventtextpopup("br_blue_perks_loot", 0, 0);
    }

    return 1;
  }

  if(istokenpickup(var_1.scriptablename)) {
    var_7 = var_1.scriptablename == "brloot_hvv_hero_token";
    var_8 = var_1.scriptablename == "brloot_hvv_villain_token";
    var_9 = var_7 || var_8;

    if(istrue(self.isjuggernaut) && !var_9) {
      return 16;
    }

    if(var_1.scriptablename == "brloot_redeploy_token") {
      if(scripts\mp\gametypes\br_public::hasrespawntoken()) {
        return 8;
      } else {
        return 1;
      }
    }

    if(var_1.scriptablename == "brloot_gulag_token") {
      if(scripts\mp\gametypes\br_public::hasgulagtoken() || scripts\mp\gametypes\br_gulag::checkgulagusecount()) {
        return 28;
      } else {
        return 1;
      }
    }

    var_4 = istrue(var_1.turretsactive);

    if(var_9) {
      if(var_4) {
        if(isDefined(self.lasthvvtoken)) {
          if(self.lasthvvtoken == 1 && var_7 || self.lasthvvtoken == 2 && var_8) {
            return 1;
          }
        }

        return 12;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(use_milcrate(var_9.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(var_9.scriptablename == "brloot_self_revive") {
      if(scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
        return 14;
      } else {
        return 1;
      }
    }

    return 1;
  }

  if(iskillstreak(var_9.scriptablename)) {
    var_10 = level.br_pickups.br_killstreakreference[var_9.scriptablename];

    if(var_9.scriptablename == "brloot_specialist_bonus" && scripts\mp\gametypes\br_public::shouldlink()) {
      return 18;
    }

    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(unset_relic_dogtags(var_10)) {
      if(var_10 == "circle_peek") {
        if(!isDefined(level.ref_13aca[self.team])) {
          level.ref_13aca[self.team] = 0;
        }

        var_11 = level.ref_13aca[self.team] + level.br_circle.circleindex + 1;

        if(var_11 >= level.gulag_tutorial_vo.size) {
          return 19;
        }
      }

      return 1;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(self getcurrentweapon())) {
      return 7;
    }

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && self.streakdata.streaks[1].streakname == level.br_pickups.br_killstreakreference[var_9.scriptablename]) {
      return 7;
    } else {
      return 1;
    }
  }

  if(issuperpickup(var_9.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(scripts\mp\supers::issuperinuse()) {
      return 4;
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::isarmor(var_9.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(scripts\mp\gametypes\br_armor::isarmorbetterthanequipped(level.br_pickups.br_equipname[var_9.scriptablename])) {
      return 1;
    } else {
      return 6;
    }
  }

  if(updatecollectionui(var_9.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(getdvarint("scr_enablePouchRecycle", 0) == 1 && isDefined(var_9.tracknonoobplayerlocation)) {
      if(scripts\mp\gametypes\br_public::should_use_velo_forward()) {
        var_12 = scripts\engine\utility::ter_op(isDefined(self.equipment["health"]), scripts\mp\equipment::getequipmentslotammo("health"), 0);
        var_13 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["brloot_armor_plate"]);
        var_14 = var_9.tracknonoobplayerlocation.count;

        if(var_12 >= var_13) {
          return 4;
        } else if(var_14 <= 0) {
          return 26;
        } else {
          thread playerplaypickupanim(var_9);
          play_hit_marker_to_player(var_9, 0);
          return 25;
        }
      } else {
        return 1;
      }
    }

    if(scripts\mp\gametypes\br_public::should_use_velo_forward()) {
      return 15;
    } else {
      return 1;
    }
  }

  if(turn_on_red_lights_along_track(var_9.scriptablename)) {
    return 1;
  }

  if(issecretwinebottle(var_9.scriptablename)) {
    return 1;
  }

  if(issecretshovel(var_9.scriptablename)) {
    return 1;
  }

  if(usablecarriables(var_9.scriptablename)) {
    if(isDefined(var_9.tracknonoobplayerlocation.team) && self.team == var_9.tracknonoobplayerlocation.team) {
      return 1;
    } else {
      return 4;
    }
  }

  if(usereload(var_9.scriptablename)) {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    if(scripts\mp\gametypes\br_public::shouldlink()) {
      return 18;
    }

    return 1;
  }

  if(var_9.scriptablename == "brloot_ammo_grenade") {
    if(istrue(self.isjuggernaut)) {
      return 16;
    }

    var_15 = scripts\mp\equipment::getequipmentslotammo("primary");
    var_16 = scripts\mp\equipment::getequipmentslotammo("secondary");

    if(isDefined(var_15) && var_15 < 2 || isDefined(var_16) && var_16 < 2) {
      return 1;
    } else {
      return 3;
    }
  }

  if(var_9.scriptablename == "Pillage_Cache") {
    return 1;
  }

  if(update_player_about_remaining_enemies(var_9.scriptablename) || isinteltype(var_9.scriptablename)) {
    return 1;
  }

  return 2;
}

function unlocked_armory(var_0) {
  if(scripts\mp\weapons::isfistweapon(var_0) || scripts\mp\utility\weapon::unset_relic_mythic(var_0) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0)) {
    return false;
  }

  return true;
}

function uavfastsweepid(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "brloot_tactical_device":
    case "brloot_x1_stash_cypher":
    case "brloot_x2_stash_bomb":
    case "brloot_offhand_geigercounter":
      return 1;
    default:
      return 0;
  }
}

function spawnpickup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.origin == (0, 0, 0)) {
    return;
  }

  var_8 = 0;
  var_9 = undefined;

  if(isDefined(level.br_pickups.br_weapontoscriptable[var_0])) {
    var_9 = level.br_pickups.br_weapontoscriptable[var_0];
  } else if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_4) && scripts\mp\riotshield::isriotshield(var_4)) {
    var_8 = 1;
    var_9 = "brloot_weapon_me_riotshield";
  } else if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_4)) {
    var_10 = undefined;

    if(getsubstr(var_4.basename, 0, 3) == "s4_") {
      var_10 = getsubstr(var_4.basename, 3, 5);
    } else {
      var_10 = getsubstr(var_4.basename, 4, 6);
    }

    if(var_10 == "mg") {
      var_10 = "lm";
    }

    if(var_10 == "mr") {
      var_10 = "sn";
    }

    if(var_10 != "me" && var_10 != "pi" && var_10 != "sh" && var_10 != "sm" && var_10 != "ar" && var_10 != "lm" && var_10 != "dm" && var_10 != "sn" && var_10 != "la" && var_10 != "kn") {
      return;
    }

    var_8 = 1;
    var_9 = "brloot_weapon_generic_" + var_10;
  } else if(unlocked_armory(var_0)) {
    var_9 = var_0;
  }

  if(!isDefined(var_9)) {
    return;
  }

  if(issubstr(var_9, "me_riotshield") || issubstr(var_9, "me_rindigo") || scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_4) && scripts\mp\riotshield::isriotshield(var_4)) {
    var_1.angles = (var_1.angles[0] - 90, var_1.angles[1], var_1.angles[2]);
  }

  heardparachuteoverheadtime();

  if(var_8) {
    var_11 = getnodecount(var_9, var_1.origin, var_1.angles, var_1.ref_12223, var_4);

    if(isDefined(var_11)) {
      var_11.customweaponname = createheadicon(var_4);
      var_11.weapon = var_4;
    }
  } else {
    var_11 = easepower(var_11, var_2.origin, var_2.angles, var_2.ref_12223);
  }

  if(!isDefined(var_11)) {
    return;
  }

  if(isDefined(var_2.set_force_aitype_armored)) {
    var_12 = rotatevectorinverted(var_2.origin - var_2.set_force_aitype_armored.origin, var_2.set_force_aitype_armored.angles);
    var_13 = combineangles(invertangles(var_2.set_force_aitype_armored.angles), var_2.angles);
    var_11 validatecollision(var_2.set_force_aitype_armored, var_12, var_13);
    var_11.set_force_aitype_armored = var_2.set_force_aitype_armored;
  }

  ref_12b3a(var_11);

  if(isDefined(var_3)) {
    ref_119f5(var_11, var_3, var_7, var_8);
  } else {
    ref_119f5(var_11, 0);
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!istrue(level.br_pickups.delay_delete_rpg_missile[var_11])) {
    var_6 = 1;
  }

  if(uavfastsweepid(var_1)) {
    var_11.init_weapon_placements = 1;
  }

  if(!getdvarint("scr_br_disableLootDropTrail")) {
    if(istrue(var_4)) {
      if(var_6) {
        var_11 setscriptablepartstate(var_11, "dropped");
      } else {
        var_11 setscriptablepartstate(var_11, "droppedNoAuto");
      }
    }
  }

  var_14 = level.br_pickups.init_relic_ammo_drain[var_11];

  if(isDefined(var_14)) {
    var_11[[var_14]]();
  }

  return var_11;
}

function ref_12b33(var_0, var_1) {
  level.br_pickups.init_relic_ammo_drain[var_0] = var_1;
}

function registerpickupremovedforspacecallback(var_0) {
  level.br_pickups.removedforspacecallbacks = scripts\engine\utility::array_add(level.br_pickups.removedforspacecallbacks, var_0);
}

function showuseresultsfeedback(var_0) {
  switch (var_0) {
    case 5:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    case 3:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyammonoroom);
      return;
    case 4:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
      return;
    case 6:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmornotbetter);
      return;
    case 7:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveks);
      return;
    case 8:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveredeploytoken);
      return;
    case 28:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhavegulagtoken);
      return;
    case 14:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_fan_blades);
      return;
    case 9:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_light);
      return;
    case 10:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_exfil_ai_structs);
      return;
    case 11:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_me);
      return;
    case 13:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_name_fx);
      return;
    case 15:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_ents_to_clean_up);
      return;
    case 24:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_intro_lights);
      return;
    case 26:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_headicon);
      return;
    case 25:
      scripts\mp\hud_message::showmiscmessage("plate_pouch_filling");
      return;
    case 16:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_laser_entities);
      return;
    case 23:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_keypad_display_models);
      return;
    case 18:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_enemies_if_reaching_max_ai);
      return;
    case 27:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_elevator);
      return;
    case 19:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_ent);
      return;
    case 20:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_entarray);
      return;
    case 22:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_objective_on_death);
      return;
    case 2:
      break;
  }
}

function _removecashstateforplayer(var_0, var_1) {
  var_0 notify("reset_cash_wait");
  var_0 endon("reset_cash_wait");
  wait var_1;
  var_0.br_cash_count = undefined;
  var_0.br_cash_time = undefined;
}

function getcashsoundaliasforplayer(var_0, var_1) {
  var_2 = "br_pickup_cash";
  var_3 = 5000;
  var_4 = var_3 / 1000;
  var_5 = gettime();
  var_6 = scripts\mp\gametypes\br_public::shouldusegoldbarassets();

  if(isPlayer(var_0)) {
    if(!isDefined(var_0.br_cash_count)) {
      var_0.br_cash_count = 0;
    }

    if(!isDefined(var_0.br_cash_time)) {
      var_0.br_cash_time = var_5;
    }

    var_7 = var_5 - var_0.br_cash_time;
    var_0.br_cash_time = var_5;

    if(var_7 < var_3) {
      var_0.br_cash_count += 1;
    }

    thread _removecashstateforplayer(var_0, var_0);
    var_8 = "cash";

    if(var_6) {
      var_8 = "gold";
    }

    switch (var_1) {
      case "brloot_plunder_cash_uncommon_2":
      case "brloot_plunder_cash_uncommon_1":
      case "brloot_plunder_cash_common_1":
      default:
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "br_pickup_" + var_8 + "_01";
            break;
          case 2:
            var_2 = "br_pickup_" + var_8 + "_02";
            break;
          case 3:
            var_2 = "br_pickup_" + var_8 + "_03";
            break;
          case 4:
            var_2 = "br_pickup_" + var_8 + "_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_" + var_8 + "_05";
            break;
        }

        break;
      case "brloot_plunder_cash_rare_1":
      case "brloot_plunder_cash_uncommon_3":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "br_pickup_" + var_8 + "_med_01";
            break;
          case 2:
            var_2 = "br_pickup_" + var_8 + "_med_02";
            break;
          case 3:
            var_2 = "br_pickup_" + var_8 + "_med_03";
            break;
          case 4:
            var_2 = "br_pickup_" + var_8 + "_med_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_" + var_8 + "_med_05";
            break;
        }

        break;
      case "brloot_plunder_cash_epic_2":
      case "brloot_plunder_cash_epic_1":
      case "brloot_plunder_cash_rare_2":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "br_pickup_" + var_8 + "_lrg_01";
            break;
          case 2:
            var_2 = "br_pickup_" + var_8 + "_lrg_02";
            break;
          case 3:
            var_2 = "br_pickup_" + var_8 + "_lrg_03";
            break;
          case 4:
            var_2 = "br_pickup_" + var_8 + "_lrg_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_" + var_8 + "_lrg_05";
            break;
        }

        break;
      case "brloot_plunder_cash_legendary_1":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "br_pickup_" + var_8 + "_vlrg_01";
            break;
          case 2:
            var_2 = "br_pickup_" + var_8 + "_vlrg_02";
            break;
          case 3:
            var_2 = "br_pickup_" + var_8 + "_vlrg_03";
            break;
          case 4:
            var_2 = "br_pickup_" + var_8 + "_vlrg_04";
            break;
          case 5:
          default:
            var_2 = "br_pickup_" + var_8 + "_vlrg_05";
            break;
        }

        break;
    }
  }

  return var_2;
}

function onusecompleted(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  var_4 = 0;

  if(!isDefined(var_0.count)) {
    var_0.count = 0;
  }

  if(!istrue(var_1)) {
    var_5 = "br_pickup_generic";
    var_6 = undefined;

    if(isDefined(var_0.scriptablename)) {
      if(isplunder(var_0.scriptablename)) {
        var_5 = getcashsoundaliasforplayer(self, var_0.scriptablename);
      } else if(isDefined(level.br_pickups.br_pickupsfx[var_0.scriptablename]) && level.br_pickups.br_pickupsfx[var_0.scriptablename].size > 0) {
        var_5 = level.br_pickups.br_pickupsfx[var_0.scriptablename];
      } else if(isweaponpickupitem(var_0)) {
        var_5 = "br_pickup_weap";
      } else {
        var_5 = "br_pickup_ammo";
      }

      if(isplunder(var_0.scriptablename)) {
        var_6 = "br_plunder";
      } else if(scripts\mp\gametypes\br_public::isammo(var_0.scriptablename)) {
        var_6 = "br_ammo";
      } else if(scripts\mp\gametypes\br_public::isarmorplate(var_0.scriptablename)) {
        var_6 = "br_armor";
      }
    }

    self playsoundtoplayer(var_5, self);
    var_7 = var_5 + "_3d";

    if(soundexists(var_7)) {
      self playsoundtoteam(var_7, self.team, self, self);
    }

    if(isDefined(var_6)) {
      scripts\mp\damagefeedback::hudicontype(var_6);
    }

    if(!istrue(var_2)) {
      thread playerplaypickupanim(var_0);
    }
  }

  level notify("pickedupweapon_kill_callout_" + var_0.scriptablename + var_0.origin);

  if(isplunder(var_0.scriptablename)) {
    self notify("self_pickedupitem_plunder");
  } else if(isweaponpickupitem(var_0)) {
    self notify("self_pickedupitem_weapon");
  } else {
    self notify("self_pickedupitem_" + var_0.scriptablename);
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("onUseCompleted", var_0))) {
    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("takePickup")) {
      var_4 = scripts\mp\gametypes\br_gametypes::ref_12e05("takePickup", var_0);
    }
  } else if(isweaponpickupitem(var_0)) {
    scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
    generatespawnpoint();
    scripts\mp\gametypes\br_weapons::takeweaponpickup(var_0);
    var_8 = respawnplayer(var_0);
    var_9 = 0;

    if(isDefined(var_8)) {
      var_9 = 1 << var_8;
    }

    scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("weapon", var_9);
    var_10 = isDefined(var_0.scriptablename) && var_0.scriptablename == "brloot_weapon_lm_dblmg_lege";

    if(var_10) {
      ref_11aac();
    }
  } else if(scripts\mp\gametypes\br_public::isammo(var_0.scriptablename)) {
    var_4 = scripts\mp\gametypes\br_weapons::takeammopickup(var_0);
  } else if(scripts\mp\gametypes\br_public::isequipment(var_0.scriptablename)) {
    var_4 = takeequipmentpickup(var_0, var_3);
    var_11 = 0;

    if(level.br_pickups.br_itemtype[var_0.scriptablename] == "lethal") {
      var_11 = 1;
    } else if(level.br_pickups.br_itemtype[var_0.scriptablename] == "tactical") {
      var_11 = 2;
    } else if(scripts\mp\gametypes\br_public::isarmorplate(var_0.scriptablename)) {
      var_11 = 4;
    } else if(scripts\mp\gametypes\br_public::ishealitem(var_0.scriptablename)) {
      var_11 = 8;
    }

    scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("equipment", var_11);
  } else if(scripts\mp\gametypes\br_public::isarmor(var_0.scriptablename)) {
    takearmorpickup(var_0);
  } else if(var_0.scriptablename == "Pillage_Cache" && isDefined(level.givetagsfromcache)) {
    self[[level.givetagsfromcache]]();
  } else if(isplunder(var_0.scriptablename)) {
    scripts\mp\gametypes\br_plunder::takeplunderpickup(var_0);
    scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("plunder", var_0.count);
  } else if(istokenpickup(var_0.scriptablename)) {
    if(issubstr(var_0.scriptablename, "redeploy_token")) {
      takerespawntokenpickup(var_0);
    }

    if(issubstr(var_0.scriptablename, "gulag_token")) {
      takegulagtokenpickup(var_0);
    }

    if(issubstr(var_0.scriptablename, "hvv_hero_token") || issubstr(var_0.scriptablename, "hvv_villain_token")) {
      scripts\mp\gametypes\br_gametype_olaride::takeherovillaintokenpickup(var_0);
    }
  } else if(use_milcrate(var_0.scriptablename)) {
    ref_13a39(var_0);
  } else if(isperkpointpickup(var_0.scriptablename)) {
    battle_tracks_togglethink(var_0);
  } else if(iskillstreak(var_0.scriptablename)) {
    if(var_0.scriptablename == "brloot_specialist_bonus") {
      bearsetup();
    } else {
      takekillstreakpickup(var_0, var_3);

      if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation.ref_11a40) && issubstr(var_0.tracknonoobplayerlocation.ref_11a40, "cache") || istrue(var_3)) {
        scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("killstreak", 0);
      }
    }
  } else if(issuperpickup(var_0.scriptablename)) {
    takesuperpickup(var_0, var_3);
    scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("equipment", 16);
  } else if(isgasmask(var_0.scriptablename)) {
    takegasmask(var_0, var_3);
  } else if(usb(var_0.scriptablename)) {
    scripts\mp\gametypes\br_quest_util::ref_13a38(var_0.tracknonoobplayerlocation);
  } else if(updatecollectionui(var_0.scriptablename)) {
    if(getdvarint("scr_enablePouchRecycle", 0) == 1) {
      if(!scripts\mp\gametypes\br_public::should_use_velo_forward()) {
        battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
        play_hit_marker_to_player(var_0, 1);
      }
    } else {
      battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
      play_hud_reminder_vo();
    }
  } else if(var_0.scriptablename == "brloot_ammo_grenade") {
    takegenericgrenadepickup(var_0);
  } else if(turn_on_red_lights_along_track(var_0.scriptablename)) {
    ref_13a2f(var_0);
  } else if(issecretwinebottle(var_0.scriptablename)) {
    takesecretwinebottle(var_0.scriptablename);
  } else if(issecretshovel(var_0.scriptablename)) {
    takesecretshovel(var_0.scriptablename);
  } else if(uniquelootitemlookup(var_0.scriptablename)) {
    ref_13a33(var_0);
  } else if(usablecarriables(var_0.scriptablename)) {
    takequestitem(var_0);
  } else if(usereload(var_0.scriptablename)) {
    bearsetup();
  } else if(update_player_about_remaining_enemies(var_0.scriptablename)) {
    if(var_0.scriptablename == "brloot_escape_radio") {
      if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onPickupExfilRadio") && isDefined(var_0.tracknonoobplayerlocation)) {
        var_0.tracknonoobplayerlocation thread scripts\mp\gametypes\br_gametypes::ref_12e05("onPickupExfilRadio", self);
      } else {
        var_0 thread scripts\mp\gametypes\br_alt_mode_escape::obj_heli_assault3_fob(self);
      }
    } else if(var_0.scriptablename == "brloot_tactical_device") {
      thread scripts\mp\gametypes\br_gametype_reveal_2::ref_13a1e(self);
    } else if(var_0.scriptablename == "brloot_mendota_screamer") {
      var_0 thread scripts\mp\gametypes\fresno\fresno_screamer::pickupscreamer(self);
    } else if(var_0.scriptablename == "brloot_zmb_stim") {
      var_0.tracknonoobplayerlocation thread scripts\mp\gametypes\br_alt_mode_zxp::onuse(self);
    }
  } else {
    var_12 = 1;

    if(isDefined(var_0.count)) {
      var_12 = var_0.count;
    }

    trypickupitem(var_0.scriptablename, var_12);
  }

  var_12 = 1;

  if(isDefined(var_0.count)) {
    var_12 = var_0.count;
  }

  if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation.ref_13f0a)) {
    ref_128b5(var_0.tracknonoobplayerlocation.ref_13f0a, self);
  }

  scripts\mp\gametypes\br_analytics::branalytics_lootpickup(self, var_0.scriptablename, var_12);
  return var_4;
}

function playerplaypickupanim(var_0) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(isweaponpickupitem(var_0) || !scripts\mp\gametypes\br_public::ref_12518()) {
    return;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("skipLootPickupAnim", var_0))) {
    return;
  }

  var_1 = getcompleteweaponname("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(var_1)) {
    if(self isgestureplaying("iw8_ges_pickup_br")) {
      self stopgestureviewmodel("iw8_ges_pickup_br", 0, 1);
    }

    self takeweapon(var_1);
    waitframe();
  }

  scripts\mp\gametypes\br_public::ref_12616("iw8_ges_plyr_loot_pickup", 1.17);
}

function test_ai_anim() {
  var_0 = spawnStruct();
  var_0.ml_p3_to_safehouse_transition = 0;
  return var_0;
}

function droponplayerdeath(var_0) {
  if(istrue(scripts\mp\gametypes\br_gametypes::ref_12e05("dropOnPlayerDeath", var_0))) {
    return;
  }

  if(istrue(level.usegulag) && (scripts\mp\gametypes\br_public::isplayeringulag() || scripts\mp\gametypes\br_public::ref_1443c())) {
    return;
  }

  var_1 = test_ai_anim();
  scripts\mp\gametypes\br_gametypes::ref_12e05("addDropOnPlayerDeath", var_1, var_0);

  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    scripts\mp\gametypes\br_jugg_common::droponplayerdeath(var_1);
  }

  var_2 = scripts\mp\gametypes\br_gametypes::ref_12e05("skipPrimaryWeaponDrop");
  minplunderextractions(var_1);

  if(!istrue(level.ref_133ea) && !istrue(var_2)) {
    missiontime(var_1);
  }

  if(!istrue(level.ref_133cd)) {
    mintokensdropondeath(var_1);
  }

  if(getdvarint("scr_br_dropPlatesAndSatchel", 1) == 1 || !istrue(scripts\mp\gametypes\br_public::should_use_velo_forward())) {
    missedinfilplayerhandler(var_1);
  }

  scripts\mp\gametypes\br_plunder::playerdropplunderondeath(var_1, var_0);
  missed_shots(var_1);

  if(!istrue(level.ref_133d7) && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer") {
    missing_window_blockers(var_1);
  }

  if(!istrue(level.ref_133e6)) {
    mix_loot_pickups(var_1);
  }

  missions_clearinappropriaterewards(var_1);
  missionparticipation(var_1);
  minigun_turret_info(var_1);
  dropsecretbottles(var_1);
  dropsecretshovel(var_1);
  modifycrushdamage(var_1);
  mlgmodifyheadshotdamage(var_1);
  modifydamagetoprop();
  dropscreamerdevice(var_1);
  var_0 = self.lastkilledby;

  if(isDefined(var_0)) {
    minshotstostage2acc(var_1, var_0);
  }
}

function minplunderextractions(var_0) {
  foreach(var_2 in level.br_ammo_types) {
    if(self.br_ammo[var_2] > 0 && isDefined(level.br_pickups.br_itemrow[var_2])) {
      var_3 = var_2;
      var_4 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup(var_3, var_4, self.br_ammo[var_2], 1);
    }
  }
}

function missiontime(var_0) {
  foreach(var_2 in self.equippedweapons) {
    if(ref_132f9(var_2, self)) {
      ml_p1_func(var_2, var_0);
    }
  }
}

function ml_p1_func(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0)) {
    if(issameweapon(var_0)) {
      var_2 = var_0;
      var_3 = self getweaponammoclip(var_2);
      var_4 = self getweaponammoclip(var_2, "left");

      if(var_2.hasalternate) {
        var_6 = var_2 getaltweapon();

        if(!scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train(var_2, var_6)) {
          var_5 = self getweaponammoclip(var_6);
        }
      }
    } else if(isstring(var_0)) {
      var_2 = relicsquadlink(var_0);

      if(isDefined(var_2)) {
        var_3 = var_2.clipsize;
      } else if(isDefined(level.br_ammo_clipsize[var_0])) {
        var_3 = level.br_ammo_clipsize[var_0];
      }
    }
  }

  if(!isDefined(var_2)) {
    return;
  }

  var_7 = getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  var_8 = scripts\mp\gametypes\br_weapons::weaponspawn(var_2, self, var_7, 0, 1);

  if(isDefined(var_8)) {
    ref_119f5(var_8, var_3, var_4, var_5);
  }

  return var_8;
}

function relicsquadlink(var_0) {
  var_1 = undefined;

  if(!isDefined(level.br_lootiteminfo) && !isDefined(level.br_lootiteminfo[var_0])) {
    return;
  }

  return level.br_lootiteminfo[var_0].playerstartjailsetcontrols;
}

function ref_132f9(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_2 == "iw8_fists" || var_2 == "iw8_knifestab" || var_2 == "iw8_gunless") {
    return false;
  }

  if(var_2 == "ks_use_crate_mp") {
    return false;
  }

  if(!issameweapon(var_0)) {
    return false;
  }

  if(var_0.inventorytype != "primary") {
    return false;
  }

  if(var_1 scripts\mp\gametypes\br_extract_quest::operatorsfxalias(var_0)) {
    return false;
  }

  return true;
}

function mintokensdropondeath(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_2) && isDefined(var_3);

  if(var_4) {
    var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_3);

    if(isDefined(var_5)) {
      var_6 = undefined;

      if(istrue(var_1)) {
        var_6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
      }

      var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
      spawnpickup(var_5, var_7, 1, 1);
    }

    return;
  }

  if(isDefined(self.equipment["primary"])) {
    var_8 = scripts\mp\equipment::getequipmentslotammo("primary");

    if(var_8 > 0) {
      var_9 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["primary"]);

      if(isDefined(var_9)) {
        var_7 = getitemdroporiginandangles(var_1, self.origin, self.angles, self);
        spawnpickup(var_9, var_7, var_8, 1);
      }
    }
  }

  if(isDefined(self.equipment["secondary"])) {
    var_8 = scripts\mp\equipment::getequipmentslotammo("secondary");

    if(var_8 > 0) {
      var_9 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["secondary"]);

      if(isDefined(var_9)) {
        var_7 = getitemdroporiginandangles(var_1, self.origin, self.angles, self);
        var_10 = spawnpickup(var_9, var_7, var_8, 1);

        if(isDefined(var_10)) {
          modeloadoutupdateammo(var_10, self, var_9);
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function mix_loot_pickups(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_2) && isDefined(var_3);

  if(var_4) {
    var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_3);

    if(isDefined(var_5)) {
      var_6 = undefined;

      if(istrue(var_1)) {
        var_6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
      }

      var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
      var_8 = var_7[0];
      var_9 = var_7[1];
      var_10 = var_7[2];
      var_7 = undefined;
      spawnpickup(var_5, var_8, var_9, 1, 1, var_10);
    }

    return;
  }

  if(isDefined(self.equipment["super"])) {
    var_11 = int(max(scripts\mp\equipment::getequipmentslotammo("super"), scripts\mp\gametypes\br::roundnumber()));

    if(var_11 > 0) {
      var_4 = scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_4) && var_4 == "super_fulton") {
        if(!istrue(level.brjuggsettings)) {
          return;
        }
      }

      dropequipmentinslot(var_1, "super", var_2, var_11);
      return;
    }

    return;
  }
}

function missionparticipation(var_0) {
  if(isDefined(self.override_supply_drop_vfx) && isDefined(self.overridefieldupgrade2)) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = spawnpickup(self.override_supply_drop_vfx, var_1, 1, 1);

    if(isDefined(var_2)) {
      var_2 scripts\mp\gametypes\br_blueprint_extract_spawn::controlslinked(self.overridefieldupgrade2);
      return;
    }

    return;
  }
}

function missedinfilplayerhandler(var_0) {
  var_1 = 0;
  var_2 = undefined;

  if(isDefined(self.equipment["health"])) {
    var_2 = level.br_pickups.br_equipnametoscriptable[self.equipment["health"]];
    var_1 = scripts\mp\equipment::getequipmentslotammo("health");
  } else if(istrue(level.playerismatchedplayerready)) {
    var_2 = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
    var_1 = level.playerismatchedplayerready;
  }

  if(istrue(level.ref_11bf1) && var_1 < level.ref_11bf1) {
    var_1 = level.ref_11bf1;

    if(!isDefined(var_2)) {
      var_2 = level.br_pickups.br_equipnametoscriptable["equip_armorplate"];
    }
  }

  if(var_1 > 0 && isDefined(var_2)) {
    if(var_1 > level.br_pickups.maxcounts[var_2]) {
      var_1 -= level.br_pickups.maxcounts[var_2];
      var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup(var_2, var_3, level.br_pickups.maxcounts[var_2], 1);
    }

    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup(var_2, var_3, var_1, 1);
    return;
  }
}

function missed_shots(var_0) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = spawnpickup(self.plundersilentcountdownendtime, var_1, int(self.gasmaskhealth), 1);

    if(isDefined(var_2)) {
      var_2.plunderpads = self.plunderpads;
    }

    hangar_doors_opening_quadrace();
    return;
  }
}

function missing_window_blockers(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gametypes\br_gametypes::ref_12e07("dropBRKillstreak", var_0, var_1, var_2, var_3);

  if(istrue(var_4)) {
    return;
  }

  var_5 = istrue(var_2) && isDefined(var_3);

  if(var_5) {
    var_6 = undefined;

    if(istrue(var_1)) {
      var_6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
    }

    var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
    spawnpickup(level.br_pickups.br_killstreaktoscriptable[var_3], var_7);
    return;
  }

  if(should_do_vo_call()) {
    var_6 = undefined;

    if(istrue(var_3)) {
      var_6 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
    }

    var_7 = getitemdroporiginandangles(var_2, self.origin, self.angles, self, var_6);
    var_8 = spawnpickup(level.br_pickups.br_killstreaktoscriptable[self.streakdata.streaks[1].streakname], var_7);

    if(show_getcash_hint() && isDefined(self.spawnx1stashlootcache)) {
      var_8.spawnprojectile = self.spawnx1stashlootcache;
      self.spawnx1stashlootcache = undefined;
    }

    scripts\mp\killstreaks\killstreaks::removekillstreak(1);
    return;
  }
}

function minshotstostage2acc(var_0, var_1) {
  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_br_ammoscavenger")) {
    var_2 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_1.currentweapon);
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_3.scavengerammo = 1;
    spawnpickup(var_2, var_3, var_1.currentweapon.startammo, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_br_armorscavenger")) {
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("Armor_Plate", var_3, 1, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_br_medicscavenger")) {
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("First_Aid", var_3, 1, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_br_plunderscavenger")) {
    scripts\mp\gametypes\br_plunder::dropplunderbyrarity(100, var_0);
    return;
  }
}

function missions_clearinappropriaterewards(var_0) {
  if(scripts\mp\gametypes\br_public::should_use_velo_forward()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = scripts\mp\equipment::getequipmentslotammo("health");
    spawnpickup("brloot_plate_pouch", var_1, var_2);
    ref_12c16();
    return;
  }
}

function play_hit_marker_to_player(var_0, var_1) {
  var_2 = var_0.tracknonoobplayerlocation;

  if(!isDefined(var_2)) {
    var_2 = var_0;
  }

  var_3 = 0;

  if(isDefined(scripts\mp\equipment::getequipmentslotammo("health"))) {
    var_3 = scripts\mp\equipment::getequipmentslotammo("health");
  } else {
    br_forcegivecustompickupitem(self, "brloot_armor_plate", 1, 0, 0);
    scripts\mp\equipment::setequipmentslotammo("health", 0);
    var_3 = scripts\mp\equipment::getequipmentslotammo("health");
  }

  if(var_2.count > 0 && var_3 < scripts\mp\equipment::getequipmentmaxammo("equip_armorplate")) {
    if(var_2.count + var_3 <= scripts\mp\equipment::getequipmentmaxammo("equip_armorplate")) {
      scripts\mp\equipment::incrementequipmentslotammo("health", var_2.count);

      if(!var_1) {
        var_2.count = 0;
        return;
      }

      return;
    }

    var_4 = var_2.count + var_3 - scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["brloot_armor_plate"]);
    var_5 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["brloot_armor_plate"]) - var_3;
    scripts\mp\equipment::incrementequipmentslotammo("health", var_5);

    if(var_1) {
      if(getdvarint("scr_dropExtraPlates", 1) == 1) {
        var_6 = test_ai_anim();
        var_7 = getitemdroporiginandangles(var_6, self.origin, self.angles, self);
        spawnpickup("brloot_armor_plate", var_7, var_4, 1);
        return;
      }

      return;
    }

    var_4.count -= var_7;
    return;
  }
}

function minigun_turret_info(var_0) {
  if(scripts\mp\gametypes\br_public::should_damage_pavelow_boss()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup(self.armorylights, var_1);
    ref_12bfc();
    return;
  }
}

function dropsecretbottles(var_0) {
  if(isDefined(self.small_island_key_items) && isDefined(self.small_island_key_items["secret_bottle"])) {
    for(var_1 = 0; var_1 < self.small_island_key_items["secret_bottle"]; var_1++) {
      var_2 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("brloot_dropped_secret_bottle", var_2);
    }

    self.small_island_key_items["secret_bottle"] = 0;
    return;
  }
}

function dropsecretshovel(var_0) {
  if(isDefined(self.small_island_key_items) && isDefined(self.small_island_key_items["shovel"])) {
    for(var_1 = 0; var_1 < self.small_island_key_items["shovel"]; var_1++) {
      var_2 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("brloot_dropped_secret_shovel", var_2);
    }

    self.small_island_key_items["shovel"] = 0;
    return;
  }
}

function mix(var_0) {
  if(scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("brloot_self_revive", var_1);
    ref_12c1f();
    return;
  }
}

function minsteps(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_3) && isDefined(var_0);

  if(var_4) {
    var_5 = undefined;

    if(istrue(var_2)) {
      var_5 = scripts\mp\gametypes\br_armory_kiosk::removefromdismembermentlist();
    }

    var_6 = test_ai_anim();
    var_7 = getitemdroporiginandangles(var_6, self.origin, self.angles, self, var_5);
    spawnpickup(var_0, var_7, var_1);
    return;
  }
}

function modifycrushdamage(var_0) {
  if(scripts\mp\gametypes\br_public::shouldlink()) {
    if(level.br_pickups.modifydamagetohunter) {
      var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("brloot_specialist_bonus", var_1);
    }

    ref_12c26();
    return;
  }
}

function mlgmodifyheadshotdamage(var_0) {
  if(isDefined(level.obit_activation) && isDefined(level.obit_activation.radio) && isDefined(level.obit_activation.radio.owner) && level.obit_activation.radio.owner == self) {
    thread scripts\mp\gametypes\br_alt_mode_escape::mlgmodifyheadshotdamage(var_0);
    return;
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12e05("onDropExfilRadio", var_0);
}

function modifydamagetoprop() {
  if(isDefined(level.ref_12ce8) && isDefined(level.ref_12ce8.ref_13a17) && isDefined(level.ref_12ce8.ref_13a17.owner) && level.ref_12ce8.ref_13a17.owner == self) {
    thread scripts\mp\gametypes\br_gametype_reveal_2::modifydamagetoprop();
    return;
  }
}

function dropscreamerdevice(var_0) {
  if(isDefined(level.ref_11e18) && isDefined(level.ref_11e18.ref_12f3f) && isDefined(level.ref_11e18.ref_12f3f.owner) && level.ref_11e18.ref_12f3f.owner == self) {
    thread scripts\mp\gametypes\fresno\fresno_screamer::dropscreamer(var_0);
    return;
  }
}

function ispickupstackable(var_0) {
  return istrue(level.br_pickups.stackable[var_0]);
}

function isitemslotopen() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self.br_inventory_slots[var_0])) {
      return true;
    }
  }

  return false;
}

function isitemfull(var_0, var_1) {
  return var_1 + var_0.count > var_0.maxcount;
}

function canstackpickup(var_0, var_1) {
  foreach(var_3 in self.br_inventory_slots) {
    if(isDefined(var_3.scriptablename) && var_3.scriptablename == var_0) {
      if(!isitemfull(var_3, var_1)) {
        return true;
      }
    }
  }

  return false;
}

function canslotitem(var_0, var_1) {
  if(ispickupstackable(var_0)) {
    if(canstackpickup(var_0, var_1)) {
      return true;
    }
  }

  return isitemslotopen();
}

function getfirstopenslot() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self.br_inventory_slots[var_0])) {
      return var_0;
    }
  }

  return -1;
}

function pickupitemintoinventory(var_0) {
  if(ispickupstackable(var_0.scriptablename)) {
    if(canstackpickup(var_0.scriptablename, var_0.count)) {
      foreach(var_2 in self.br_inventory_slots) {
        if(isDefined(var_2.scriptablename) && var_2.scriptablename == var_0.scriptablename) {
          if(!isitemfull(var_2, var_0.count)) {
            var_2.count += var_0.count;
            var_2.count = int(min(var_2.count, var_0.maxcount));
            return;
          }
        }
      }
    }
  }

  var_4 = getfirstopenslot();

  if(var_4 == -1) {
    return;
  }

  self.br_inventory_slots[var_4] = var_0;
}

function dropitemfrominventory(var_0) {
  if(isDefined(self.br_inventory_slots[var_0])) {
    var_1 = self.br_inventory_slots[var_0];
    var_2 = remove_roof_nodes(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
    var_3 = spawnpickup(var_1.scriptablename, var_2, var_1.count);

    if(isDefined(var_1.armorhealth)) {
      var_3.armorhealth = var_1.armorhealth;
    } else if(isDefined(var_1.helmethealth)) {
      var_3.helmethealth = var_1.helmethealth;
    } else if(isDefined(var_1.gasmaskhealth)) {
      var_3.gasmaskhealth = var_1.gasmaskhealth;
    }

    scripts\mp\gametypes\br_analytics::branalytics_lootdrop(self, var_1.scriptablename);
    scripts\mp\gametypes\br_public::removeitemfrominventory(var_0);
    return;
  }
}

function useitemfrominventory(var_0) {
  if(isDefined(self.br_inventory_slots[var_0])) {
    tryuseitemfrominventory(self.br_inventory_slots[var_0], var_0);
    return;
  }
}

function ref_126e1(var_0) {
  self endon("disconnect");
  self notify("try_use_heal_slot");

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    return;
  }

  if(!isalive(self) || scripts\mp\utility\player::isusingremote() || istrue(self.isdeploying) || self.br_armorhealth >= self.br_maxarmorhealth) {
    return;
  }

  var_1 = self.equipment["health"];
  var_2 = scripts\mp\equipment::getequipmentslotammo("health");
  var_3 = self.br_maxarmorhealth;
  var_4 = 1;

  if(isDefined(var_3) && var_0) {
    var_4 = var_3;
  }

  if(istrue(self.tracking_max_health)) {
    if(isDefined(self.cam) && get_axis_vehicles()) {
      self.cam += var_4;
      return;
    }

    return;
  }

  self.cam = var_4;

  if(isDefined(var_1) && isDefined(var_2) && var_2 > 0) {
    thread scripts\mp\equipment\bandage::usequickslothealitem(var_1, var_2);
    return;
  }
}

function get_axis_vehicles() {
  return !scripts\engine\utility::is_player_gamepad_enabled();
}

function takegenericgrenadepickup(var_0) {
  var_1 = scripts\mp\equipment::getequipmentslotammo("primary");

  if(isDefined(var_1) && var_1 < 2) {
    scripts\mp\equipment::incrementequipmentslotammo("primary");
  }

  var_1 = scripts\mp\equipment::getequipmentslotammo("secondary");

  if(isDefined(var_1) && var_1 < 2) {
    scripts\mp\equipment::incrementequipmentslotammo("secondary");
    return;
  }
}

function trypickupitemfroment(var_0) {
  if(canslotitem(var_0.scriptablename, var_0.count)) {
    pickupitemintoinventory(var_0);
    return;
  }

  self iprintlnbold("No room in inventory");
  self playlocalsound("br_pickup_deny");
}

function trypickupitem(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(level.br_pickups.maxcounts[var_0]) || !isDefined(level.br_pickups.stackable[var_0])) {
    return;
  }

  var_2 = spawnStruct();
  var_2.scriptablename = var_0;
  var_2.count = var_1;
  var_2.maxcount = level.br_pickups.maxcounts[var_0];
  var_2.stackable = level.br_pickups.stackable[var_0];
  var_2.itemtype = level.br_pickups.br_itemtype[var_0];

  if(canslotitem(var_2.scriptablename, var_2.count)) {
    pickupitemintoinventory(var_2);
    return;
  }

  self iprintlnbold("No room in inventory");
  self playlocalsound("br_pickup_deny");
}

function tryequipmentfrominventory(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.equipment.table[var_2].defaultslot;

  if(isDefined(self.equipment[var_3]) && self.equipment[var_3] == var_2) {
    if(equipmentslothasroom(var_2, var_3)) {
      scripts\mp\equipment::incrementequipmentslotammo(var_3, level.br_pickups.counts[var_0.scriptablename]);
      self.br_inventory_slots[var_1] = undefined;
      return;
    }

    return;
  }

  if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentslotammo(var_3, var_0.count);
    self.br_inventory_slots[var_1] = undefined;
    return;
  }

  var_4 = self.equipment[var_3];
  var_5 = scripts\mp\equipment::getequipmentslotammo(var_3);
  scripts\mp\equipment::giveequipment(var_2, var_3);
  scripts\mp\equipment::setequipmentslotammo(var_3, var_0.count);
  self.br_inventory_slots[var_1] = undefined;
  var_6 = level.br_pickups.br_equipnametoscriptable[var_4];
  trypickupitem(var_6, var_5);
}

function droparmor(var_0, var_1) {
  var_2 = remove_roof_nodes(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
  var_3 = spawnpickup(var_0, var_2);
  var_3.count = 1;
  var_3.helmethealth = 0;
  var_3.armorhealth = 0;
  var_3.gasmaskhealth = 0;

  if(issubstr(var_0, "helmet")) {
    var_3.helmethealth = var_1;

    if(var_0 == "brloot_armor_helmet_3") {
      scripts\mp\utility\perk::removeperk("specialty_stun_resistance");
    }
  }

  scripts\mp\gametypes\br_analytics::branalytics_lootdrop(self, var_0);
}

function trydroparmorfornewarmor(var_0) {
  if(scripts\mp\gametypes\br_public::ishelmet(var_0)) {
    if(isDefined(self.br_helmetlevel)) {
      var_1 = scripts\mp\gametypes\br_armor::helmetitemtypeforlevel(self.br_helmetlevel);

      if(isDefined(var_1)) {
        droparmor(var_1, self.br_helmethealth);
        return;
      }

      return;
    }

    return;
  }
}

function tryequiparmor(var_0, var_1) {
  if(isDefined(var_1)) {
    self.br_inventory_slots[var_1] = undefined;
  }

  trydroparmorfornewarmor(var_0.scriptablename);

  if(var_0.scriptablename == "brloot_armor_helmet_1") {
    scripts\mp\gametypes\br_armor::takehelmet(var_0, 1);
    return;
  }

  if(var_0.scriptablename == "brloot_armor_helmet_2") {
    scripts\mp\gametypes\br_armor::takehelmet(var_0, 2);
    return;
  }

  if(var_0.scriptablename == "brloot_armor_helmet_3") {
    scripts\mp\gametypes\br_armor::takehelmet(var_0, 3);
    return;
  }
}

function tryuseitemfrominventory(var_0, var_1) {
  if(scripts\mp\gametypes\br_public::isequipment(var_0.scriptablename)) {
    tryequipmentfrominventory(var_0, var_1);
    return;
  }
}

function initpickupusability() {
  scripts\common\interactive::interactive_addusedcallback(&brpickupsusecallback, "br_pickups");
}

function brpickupsusecallback(var_0, var_1) {
  var_2 = cantakepickup(var_1, var_0);
  showuseresultsfeedback(var_1, var_2);

  if(var_2 != 1) {
    return;
  }

  onusecompleted(var_1, var_0);
  lastunrulyscore(var_0);

  if(var_0 isscriptable()) {
    var_0 freescriptable();
    return;
  }

  var_0 delete();
}

function setup_train_array(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && scripts\mp\equipment::getequipmentslotammo(var_1) > 0) {
    var_2 = test_ai_anim();
    dropequipmentinslot(var_2, var_1);
  }

  scripts\mp\equipment::giveequipment(var_0, var_1);
  scripts\mp\equipment::setequipmentammo(var_0, 1);
}

function ref_1398a(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br" && !level.allowsupers) {
    var_0 scripts\mp\equipment::takeequipment("super");
    return;
  }
}

function hangar_doors_opening_quadrace() {
  if(istrue(self.gasmaskequipped)) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }

  self.gasmaskswapinprogress = 0;
  handleweaponreloadammodrop();
}

function handleweaponreloadammodrop() {
  self.plunderpads = undefined;
  self.gasmaskhealth = undefined;
  self.plunderrepositorywidget = undefined;
  self.plundermusicthird = 0;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
  scripts\mp\gametypes\br_public::sethasgasmaskextrainfo(0);
}

function riotshieldtaken(var_0) {
  var_1 = "brloot_armor_plate";
  var_2 = level.br_pickups.br_equipname[var_1];
  var_3 = level.equipment.table[var_2].defaultslot;

  if(isDefined(self.equipment[var_3])) {
    var_4 = scripts\mp\equipment::getequipmentslotammo(var_3);

    if(var_4 > 0) {
      if(istrue(var_0)) {
        return var_4;
      } else {
        return 1;
      }
    }
  }

  return 0;
}

function riotshieldswitchaway(var_0, var_1) {
  var_2 = self.br_ammo[var_0];
  var_3 = level.br_ammo_clipsize[var_0];

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return 0;
  }

  if(istrue(var_1)) {
    return int(var_2);
  }

  return int(min(var_3, var_2));
}

function risk_currentflagstier(var_0) {
  var_1 = 5;

  if(istrue(var_0)) {
    return int(self.plundercount);
  }

  return int(min(self.plundercount, var_1));
}

function riotshieldswitchawaytimer(var_0) {
  switch (var_0) {
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

function risk_currentlocsinuse(var_0) {
  var_1 = self.lastdroppableweaponobj;
  var_2 = createheadicon(var_1);
  return var_2;
}

function risk_currentflagsactive(var_0, var_1) {
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = undefined;

  switch (var_0) {
    case 3:
      var_3 = int(self.gasmaskhealth);
      var_2 = scripts\cp_mp\gasmask::hasgasmask(self) && !istrue(self.plundermusicthird);
      break;
    case 4:
      var_3 = riotshieldtaken(var_1);
      var_2 = var_3 > 0;
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      var_7 = riotshieldswitchawaytimer(var_0);
      var_3 = riotshieldswitchaway(var_7, var_1);
      var_2 = var_3 > 0;
      break;
    case 0:
      if(istrue(self.iszombie)) {
        var_2 = 0;
        break;
      }

      var_3 = risk_currentflagstier(var_1);
      var_2 = var_3 > 0;
      break;
    case 1:
      var_3 = scripts\engine\utility::ter_op(istrue(self.hasrespawntoken), 1, 0);
      var_2 = var_3 > 0;
      break;
    case 2:
      var_3 = scripts\engine\utility::ter_op(istrue(self.shouldgetnewspawnpoint), 1, 0);
      var_2 = var_3 > 0;
      break;
    case 10:
      var_8 = self.lastdroppableweaponobj;

      if(!isDefined(var_8) || nullweapon(var_8) || !self hasweapon(var_8) || var_8 == getcompleteweaponname("iw8_fists_mp") || self isskydiving() || istrue(self.usingascender)) {
        var_2 = 0;
      } else {
        var_3 = self getweaponammoclip(var_8);
        var_4 = self getweaponammoclip(var_8, "left");

        if(var_8.hasalternate) {
          var_9 = var_8 getaltweapon();

          if(!scripts\mp\gametypes\br_weapons::debug_spawn_crate_on_train(var_8, var_9)) {
            var_5 = self getweaponammoclip(var_9);
          }
        }

        var_6 = var_8;
      }

      break;
    default:
      var_2 = 0;
      break;
  }

  return [var_2, var_3, var_4, var_5, var_6];
}

function ref_12993(var_0, var_1) {
  var_2 = "brloot_armor_plate";
  var_3 = level.br_pickups.br_equipname[var_2];
  var_4 = level.equipment.table[var_3].defaultslot;
  scripts\mp\equipment::decrementequipmentslotammo(var_4, var_1);

  if(istrue(self.tracking_max_health)) {
    var_5 = scripts\mp\equipment::getcurrentequipment(var_4);
    var_6 = scripts\mp\equipment::getequipmentammo(var_5);

    if(var_6 < 1) {
      self notify("br_try_armor_cancel");
      return;
    }

    return;
  }
}

function ref_12992(var_0, var_1) {
  var_2 = riotshieldswitchawaytimer(var_0);
  scripts\mp\gametypes\br_weapons::br_ammo_take_type(self, var_2, var_1);
}

function ref_12995(var_0, var_1) {
  scripts\mp\gametypes\br_plunder::ref_1261e(var_1);
}

function ref_12996(var_0, var_1) {
  removerespawntoken();
}

function ref_12997(var_0, var_1) {
  ref_12c1f();
}

function ref_12998(var_0, var_1) {
  var_2 = self.lastdroppableweaponobj;
  var_3 = getcompleteweaponname("iw8_fists_mp");
  var_4 = var_3;
  var_5 = self getweaponslistprimaries();

  foreach(var_7 in var_5) {
    if(var_7.inventorytype != "primary") {
      continue;
    }

    if(var_7 != var_3 && var_7 != var_2 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_7)) {
      var_4 = var_7;
      break;
    }
  }

  if(!scripts\mp\riotshield::isriotshield(var_2)) {
    var_9 = self getweaponammostock(var_2);
    var_10 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_2);

    if(isDefined(var_10)) {
      self.br_ammo[var_10] = var_9;
    }
  }

  if(scripts\mp\utility\weapon::update_health_on_spawn(var_2)) {
    self notify("dropped_minigun");
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  scripts\mp\gametypes\br_public::ref_1264d();

  if(!self hasweapon(var_3)) {
    self giveweapon(var_3);
  }

  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  self switchtoweaponimmediate(var_4);
  scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
  generatespawnpoint();
}

function ref_12994(var_0, var_1) {
  switch (var_0) {
    case 3:
      if(!istrue(self.plundermusicthird)) {
        self.plundermusicthird = 1;
        thread ref_12c05();
      }

      break;
    case 4:
      ref_12993(var_0, var_1);
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      ref_12992(var_0, var_1);
      break;
    case 0:
      ref_12995(var_0, var_1);
      break;
    case 1:
      ref_12996(var_0, var_1);
      break;
    case 2:
      ref_12997(var_0, var_1);
      break;
    case 10:
      ref_12998(var_0, var_1);
      break;
    default:
      return;
  }
}

function ref_1298e(var_0, var_1) {
  switch (var_0) {
    case 3:
      return self.plundersilentcountdownendtime;
    case 4:
      return "brloot_armor_plate";
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      return riotshieldswitchawaytimer(var_0);
    case 0:
      for(var_2 = level.br_plunder.ref_12954.size - 1; var_2 >= 0; var_2--) {
        if(var_1 > level.br_plunder.ref_12954[var_2]) {
          return level.br_plunder.names[var_2];
        }
      }

      return level.br_plunder.names[0];
    case 2:
      return "brloot_self_revive";
    case 1:
      return "brloot_respawn_token";
    case 10:
      return risk_currentlocsinuse(var_1);
    default:
      break;
  }
}

function ref_1298c() {
  var_0 = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  wait var_0;
  self.ref_12989 = undefined;
}

function ref_12986(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.ref_12989)) {
    self.ref_12989 = [];
  }

  var_5 = spawnStruct();
  var_5.vehicle_collision_updateinstanceend = var_0;
  var_5.slot = var_1;
  var_5.ent = var_2;
  var_5.moderemovefromteamlives = var_3;
  var_5.minigun_wait_between_shots = var_4;
  var_5.ref_1260b = self.origin;
  var_5.ref_126f7 = self.angles[1];
  self.ref_12989[self.ref_12989.size] = var_5;
  thread ref_1298c();
}

function ref_1298b(var_0) {
  var_1 = 60;
  var_2 = squared(var_1);
  var_3 = 45;
  var_4 = distancesquared(self.origin, var_0.ref_1260b);

  if(var_4 > var_2) {
    return false;
  }

  var_5 = abs(self.angles[1] - var_0.ref_126f7);

  if(var_5 > var_3) {
    return false;
  }

  return true;
}

function ref_1298d(var_0) {
  if(!isDefined(self.ref_12989)) {
    return;
  }

  foreach(var_2 in self.ref_12989) {
    if(isDefined(var_2.ent) && var_2.vehicle_collision_updateinstanceend == var_0) {
      if(!ref_1298b(var_2)) {
        continue;
      }

      return var_2;
    }
  }
}

function ref_1298a() {
  if(!isDefined(self.ref_12989)) {
    return 0;
  }

  var_0 = [];

  foreach(var_2 in self.ref_12989) {
    if(isDefined(var_2.ent)) {
      if(!ref_1298b(var_2)) {
        continue;
      }

      var_0 = 1;
    }
  }

  var_4 = undefined;
  var_5 = 0;
  var_6 = 0;
  var_7 = [0, 13, 1];

  for(;;) {
    var_4 = var_6 * 14 + var_7[var_5];

    if(!istrue(var_0[var_4])) {
      break;
    }

    var_5++;

    if(var_5 >= var_7.size) {
      var_5 = 0;
      var_6++;
    }
  }

  return var_4;
}

function ref_12991(var_0, var_1, var_2) {
  var_3 = undefined;

  switch (var_0) {
    case 3:
      var_3 = "br_inventory_drop_self_revive";
      break;
    case 4:
      var_3 = "br_inventory_drop_armor";
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      var_3 = "br_inventory_drop_ammo";
      break;
    case 0:
      if(var_2 == "brloot_plunder_cash_uncommon_1") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_uncommon_2") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_uncommon_3") {
        var_3 = "br_inventory_drop_plunder_sm";
      } else if(var_2 == "brloot_plunder_cash_rare_1") {
        var_3 = "br_inventory_drop_plunder_med";
      } else if(var_2 == "brloot_plunder_cash_rare_2") {
        var_3 = "br_inventory_drop_plunder_med";
      } else if(var_2 == "brloot_plunder_cash_epic_1") {
        var_3 = "br_inventory_drop_plunder_lrg";
      } else if(var_2 == "brloot_plunder_cash_epic_2") {
        var_3 = "br_inventory_drop_plunder_lrg";
      } else if(var_2 == "brloot_plunder_cash_legendary_1") {
        var_3 = "br_inventory_drop_plunder_extra_lrg";
      } else {
        var_3 = "br_inventory_drop_plunder_sm";
      }

      break;
    case 1:
      break;
    case 2:
      var_3 = "br_inventory_drop_self_revive";
      break;
    case 10:
      var_3 = "br_inventory_drop_weap";
      break;
    default:
      break;
  }

  if(isDefined(var_3)) {
    playsoundatpos(var_1, var_3);
    return;
  }
}

function ref_12987(var_0, var_1, var_2, var_3, var_4) {
  var_5 = ref_1298d(var_0);

  if(isDefined(var_5)) {
    var_6 = var_5.ent;
    var_7 = var_5.moderemovefromteamlives;
    var_8 = var_5.minigun_wait_between_shots;
    var_9 = ref_119ed(var_6);
    var_10 = ref_119ef(var_6);
    var_11 = ref_119ee(var_6);

    if(!ispickupstackable(var_5.ent.type) && !issubstr(var_5.ent.type, "_cash")) {
      return false;
    }

    var_12 = undefined;

    if(isDefined(var_6.set_force_aitype_armored)) {
      var_12 = var_6.set_force_aitype_armored;
    }

    var_13 = var_9 + var_1;
    var_14 = var_10 + var_2;
    var_15 = var_11 + var_3;
    var_16 = ref_1298e(var_0, var_13);
    var_17 = getscriptablereservedremaining(var_7 + (0, 0, 12), var_7);
    var_18 = remove_roof_nodes(var_7, var_8, var_17, var_12);
    var_19 = spawnpickup(var_16, var_18, var_13, 1, var_4, 0, var_14, var_15);

    if(istrue(level.listen_for_pickup_items_dropped)) {
      level notify("br_pickup_item_dropped", var_19, self);
    }

    scripts\mp\gametypes\br_analytics::branalytics_lootdrop(self, var_16, undefined, var_1);

    if(isDefined(var_4)) {
      level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_19, self, var_4);
    }

    ref_12991(var_0, var_7, var_16);
    var_5.ent = var_19;
    thread ref_1298c();
    lastunrulyscore(var_6);

    if(isent(var_6)) {
      var_6 delete();
    } else {
      var_6 freescriptable();
    }

    return true;
  }

  return false;
}

function ref_12990(var_0, var_1, var_2, var_3, var_4) {
  var_5 = ref_1298e(var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }

  var_6 = ref_1298a();
  var_7 = test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = var_6;
  var_8 = getitemdroporiginandangles(var_7, self.origin, self.angles, self);
  var_9 = isgasmask(var_5);
  var_10 = scripts\mp\gametypes\br_extract_quest::operatorsfxalias(var_4);
  var_11 = get_base_focus_fire_multipler(var_4);

  if(!var_10 && var_11) {
    if(var_9 && istrue(self.gasmaskswapinprogress)) {
      scripts\engine\utility::waittill_notify_or_timeout("gas_mask_swap_complete", 2);
      waitframe();
    }

    var_12 = spawnpickup(var_5, var_8, var_1, 1, var_4, 0, var_2, var_3);

    if(var_9 && isDefined(var_12)) {
      var_12.plunderpads = self.plunderpads;
    }

    if(istrue(level.listen_for_pickup_items_dropped)) {
      level notify("br_pickup_item_dropped", var_12, self);
    }

    ref_12986(var_0, var_6, var_12, var_8.origin, var_8.angles);
    scripts\mp\gametypes\br_analytics::branalytics_lootdrop(self, var_5, undefined, var_1);

    if(isDefined(var_4)) {
      level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_12, self, var_4);
    }
  }

  ref_12991(var_0, var_8.origin, var_5);

  if(var_9) {
    hangar_doors_opening_quadrace();
    return;
  }
}

function get_base_focus_fire_multipler(var_0) {
  if(scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify(var_0)) {
    return false;
  }

  return true;
}

function ref_1298f(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  setuproundstarthud(var_0);
  var_1 = risk_currentflagsactive(var_0);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  var_5 = var_1[3];
  var_6 = var_1[4];
  var_1 = undefined;

  if(!var_2) {
    return;
  }

  ref_12994(var_0, var_3);
  scripts\mp\class::disableclassswapallowed();
  var_7 = ref_12987(var_0, var_3, var_4, var_5, var_6);

  if(var_7) {
    return;
  }

  ref_12990(var_0, var_3, var_4, var_5, var_6);
}

function ref_12988(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  setuproundstarthud(var_0);
  var_1 = 1;
  var_2 = risk_currentflagsactive(var_0, 1);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_6 = var_2[3];
  var_7 = var_2[4];
  var_2 = undefined;

  if(!var_3) {
    return;
  }

  ref_12994(var_0, var_4);
  scripts\mp\class::disableclassswapallowed();
  var_8 = ref_12987(var_0, var_4, var_5, var_6, var_7);

  if(!var_8) {
    ref_12990(var_0, var_4, var_5, var_6, var_7);
  }

  if(isDefined(level.ref_1207b)) {
    [[level.ref_1207b]](self);
    return;
  }
}

function gethighestscore(var_0) {
  switch (var_0) {
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

function setuproundstarthud(var_0) {
  if(gethighestscore(var_0)) {
    var_1 = undefined;

    while(self isreloading()) {
      if(!istrue(var_1)) {
        var_1 = 1;
        self disableautoreload();
      }

      self cancelreload();
      waitframe();
    }

    if(istrue(var_1)) {
      self enableautoreload();
    }

    waitframe();
    return;
  }
}

function dangercircletick(var_0, var_1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("loot")) {
    return;
  }

  var_2 = var_1 * var_1;
  var_3 = level.br_circle.circleindex;

  if(var_3 > level.br_circle.damagetick.size - 1) {
    var_3 = level.br_circle.damagetick.size - 1;
  }

  var_4 = level.br_circle.damagetick[var_3];

  if(isDefined(level.circledamagemultiplier)) {
    var_4 *= level.circledamagemultiplier;
  }

  level.br_pickups.modetype = scripts\engine\utility::array_removeundefined(level.br_pickups.modetype);

  for(var_5 = level.br_pickups.modetype.size - 1; var_5 >= 0; var_5--) {
    var_6 = level.br_pickups.modetype[var_5];

    if(distance2dsquared(var_6.origin, var_0) > var_2) {
      var_7 = var_6.count;
      var_8 = int(var_7 - var_4);

      if(var_8 <= 0) {
        var_6 setscriptablepartstate(var_6.type, "death");
        lastgunkilltime(var_6, 1);
        thread lastunruly(level);
      } else {
        if(var_6 scripts\cp_mp\gasmask::lights_setup_plane(var_7, var_8)) {
          var_6 setscriptablepartstate(var_6.type, "damage");
        }

        ref_119f5(var_6, var_8);
      }
    }
  }
}

function plundermusicfirst() {
  level.br_pickups.modetype[level.br_pickups.modetype.size] = self;
}

function lastunruly(var_0) {
  waittillframeend();

  if(isDefined(level.br_pickups.modetype)) {
    level.br_pickups.modetype[var_0] = undefined;
    return;
  }
}

function toppercentagetoadjusteconomy() {
  var_0 = level.br_pickups;
  var_0.scriptables = [];
  var_0.ref_12f7c = 0;
  var_0.ref_12f7a = 0;
  var_0.ref_12f7b = removestuckenemyondeathordisconnect();
  var_0.ref_12f79 = getdvarint("scr_br_pickupScriptablesCleanupBatchSize", 10);
}

function removestuckenemyondeathordisconnect() {
  var_0 = function_0434();
  var_1 = getdvarint("scr_br_loot_override", 0);
  jumpiffalse(var_1 > 0 && var_1 < var_0) LOC_00000025;
  var_2 = var_1;
  goto LOC_00000046;
}

function ref_12b3a(var_0) {
  var_1 = level.br_pickups.ref_12f7a;
  var_0.embassy_main = var_1;
  level.br_pickups.scriptables[var_1] = var_0;
  level.br_pickups.ref_12f7a++;
}

function lastunrulyscore(var_0) {
  level.br_pickups.scriptables[var_0.embassy_main] = undefined;
  var_0.embassy_main = undefined;
}

function heardparachuteoverheadtime() {
  var_0 = level.br_pickups;

  if(var_0.scriptables.size < var_0.ref_12f7b && enabledismembermenttag() > 0) {
    return;
  }

  var_1 = 0;

  for(var_2 = var_0.ref_12f7c; var_2 < var_0.ref_12f7a; var_2++) {
    if(var_1 == var_0.ref_12f79) {
      break;
    }

    var_3 = var_0.scriptables[var_2];

    if(isDefined(var_3)) {
      if(istrue(var_3.init_weapon_placements)) {
        continue;
      }

      foreach(var_5 in level.br_pickups.removedforspacecallbacks) {
        var_3[[var_5]]();
      }

      var_0.scriptables[var_2] = undefined;

      if(isent(var_3)) {
        var_3 delete();
      } else {
        var_3 freescriptable();
      }

      var_1++;
    } else {
      var_0.scriptables[var_2] = undefined;
    }

    var_0.ref_12f7c++;
  }
}

function lastgoodjobplayer() {
  lastunrulyscore(self);

  if(isent(self)) {
    self delete();
    return;
  }

  self freescriptable();
}

function lastgunkilltime(var_0) {
  thread lastheatupdate(var_0);
}

function lastheatupdate(var_0) {
  self endon("death");
  wait var_0;

  if(isDefined(self)) {
    lastgoodjobplayer();
    return;
  }
}

function ref_12b3f(var_0, var_1) {
  while(!isDefined(level.br_pickups)) {
    waitframe();
  }

  level.br_pickups.ref_13f09["uniqueLootItem_" + var_0] = var_1;
}

function ref_128b5(var_0, var_1) {
  if(isDefined([[level.br_pickups.ref_13f09[var_0]]](var_1))) {
    return;
  }
}

function ref_11aac() {
  thread ref_14484();
  thread ref_144ef();
  thread ref_144e7();
}

function calculateaveragevelocities() {
  self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("fakeJugg", 0);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(0, "fakeJugg");
    scripts\common\utility::allow_mount_side(0, "fakeJugg");
    return;
  }
}

function ref_12c12() {
  self.playerstreakspeedscale = undefined;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("fakeJugg", 1);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(1, "fakeJugg");
    scripts\common\utility::allow_mount_side(1, "fakeJugg");
    return;
  }
}

function ref_14484() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");

  for(;;) {
    self waittill("switched_to_minigun");
    calculateaveragevelocities();
  }
}

function ref_144ef() {
  self endon("disconnect");
  self endon("juggernaut_start");
  level endon("game_ended");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143b5("switched_from_minigun", "dropped_minigun", "death");

    if(isDefined(var_0)) {
      ref_12c12();

      if(var_0 == "dropped_minigun" || var_0 == "death") {
        break;
      }
    }
  }
}

function ref_144e7() {
  self endon("death_or_disconnect");
  self endon("dropped_minigun");
  self endon("juggernaut_start");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(!scripts\mp\utility\weapon::update_health_on_spawn(self getcurrentweapon())) {
      if(istrue(var_0)) {
        var_0 = 0;
        self notify("switched_from_minigun");
      }
    } else if(!istrue(var_0)) {
      var_0 = 1;
      self notify("switched_to_minigun");
    }

    waitframe();
  }
}

function make_chair_ai_spawner(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(self.streakdata)) {
    return false;
  }

  if(!isDefined(self.streakdata.streaks) || !isDefined(self.streakdata.streaks[1])) {
    return false;
  }

  var_1 = self.streakdata.streaks[1];

  if(!isDefined(var_0.streakname) || !isDefined(var_1.streakname) || var_0.streakname != var_1.streakname) {
    return false;
  }

  if(!isDefined(var_0.id) || !isDefined(var_1.uniqueid) || var_0.id != var_1.uniqueid) {
    return false;
  }

  return true;
}

function addspawnlocation() {
  self endon("death_or_disconnect");
  self notify("cancelOffhandADS");
  self endon("cancelOffhandADS");
  self notify("offhand_ads_off");
  wait 0.5;
  self notify("offhand_ads_off");
}

function generatespawnpoint() {
  thread addspawnlocation();
}

function getnospawntags() {
  var_0 = getDvar("MRRNLMKLQL");
  var_1 = strtok(var_0, "&");
  var_1 = scripts\engine\utility::array_add(var_1, "noSpawn");
  return var_1;
}