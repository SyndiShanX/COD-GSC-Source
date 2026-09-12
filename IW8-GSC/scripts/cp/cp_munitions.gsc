/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_munitions.gsc
***********************************************/

function init_munitions() {
  level.register_munitions_interaction = &create_munitions_interaction;
  level.ammoincompatibleweaponslist = ["iw8_la_mike32_mp"];
  read_munition_table();
  setdvarifuninitialized("scr_unlimited_mun", 0);
  level.unlimitedmunitions = getdvarint("scr_unlimited_mun", 0);
}

function read_munition_table() {
  level.munitions_table_data = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 1);

    if(var_1 == "") {
      break;
    }

    level.munitions_table_data[var_1] = spawnStruct();
    level.munitions_table_data[var_1].index = int(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 0));
    level.munitions_table_data[var_1].ref = var_1;
    level.munitions_table_data[var_1].cost = int(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 4));
    level.munitions_table_data[var_1].cooldown = float(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 5));
  }
}

function givemunitionfromluinotify() {
  self endon("disconnect");
  level endon("game_ended");
  self.dpad_selection_index = 0;
  var_0 = 3;
  var_1 = 3;

  if(istrue(level.unlimitedmunitions)) {
    var_1 = 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var_1);

  for(;;) {
    self waittill("luinotifyserver", var_2, var_3);

    if(var_2 == "radial_menu_munition") {
      var_4 = 0;

      if(!ref_12474(var_4)) {
        continue;
      }

      if(var_3 >= 0 && var_3 <= 2) {
        var_5 = self.munition_slots[var_3];

        if(isDefined(var_5) && var_5.ref != "none" && var_5.ref != "empty1" && var_5.ref != "empty2" && var_5.ref != "empty3") {
          if(istrue(can_use_munition(var_3))) {
            if(scripts\cp\cp_weapon::ref_124AD(self)) {
              var_6 = ref_132C9(var_5.ref);

              if(var_6) {
                self.modeusesgroundwarteamoobtriggers = 1;
                scripts\cp\cp_weapon::minigamefinishcount(self);
                self waittill("weapon_change");

                while(scripts\cp\cp_weapon::ref_124AD(self)) {
                  waitframe();
                }

                self.modeusesgroundwarteamoobtriggers = undefined;

                if(!ref_12474(var_4)) {
                  continue;
                }
              }
            }

            thread ref_12BDF(var_5.ref, var_3);
            var_7 = scripts\cp\crafting_system::giveitembasedoncraftingstruct(var_5.ref);

            if(var_7) {
              if(triplecheck_jugg_spawned(var_5.ref)) {
                self notify("munitions_used", var_5.ref);
              }

              scripts\cp\cp_analytics::ref_119B6(self, var_5.ref);
            } else {
              self notify("remove_munition_on_use");
            }
          }
        }
      }
    }
  }
}

function ref_12474(var_0) {
  if(istrue(level.disable_munitions)) {
    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(!isDefined(self.munition_slots)) {
    if(var_0) {
      iprintlnbold("self.munition_slots undefined");
    }

    return false;
  }

  if(self isonladder()) {
    if(var_0) {
      iprintlnbold("IsOnLadder() failed");
    }

    return false;
  }

  if(istrue(self.spectating)) {
    if(var_0) {
      iprintlnbold("self.spectating");
    }

    return false;
  }

  if(isDefined(self.currentpiece)) {
    if(var_0) {
      iprintlnbold("self.currentPiece defined");
    }

    return false;
  }

  if(istrue(self.is_fast_traveling)) {
    if(var_0) {
      iprintlnbold("self.is_fast_traveling");
    }

    return false;
  }

  if(istrue(self.inlaststand)) {
    if(var_0) {
      iprintlnbold("self.inLastStand");
    }

    return false;
  }

  if(istrue(self.trackriotshield_tryback)) {
    if(var_0) {
      iprintlnbold("self.instant_revive_buffer");
    }

    return false;
  }

  if(istrue(self.isreviving)) {
    if(var_0) {
      iprintlnbold("self.isReviving");
    }

    return false;
  }

  if(isDefined(self.placementmodel)) {
    if(var_0) {
      iprintlnbold("self.placementModel defined");
    }

    return false;
  }

  if(istrue(self.iscarrying)) {
    if(var_0) {
      iprintlnbold("self.isCarrying");
    }

    return false;
  }

  if(isDefined(self.hostagecarried)) {
    if(var_0) {
      iprintlnbold("self.hostageCarried defined");
    }

    return false;
  }

  if(level.gametype == "cp_pvpve") {
    if(var_0) {
      iprintlnbold("level.gametype == cp_pvpve");
    }

    return false;
  }

  if(istrue(self.bgivensentry)) {
    if(var_0) {
      iprintlnbold("self.bGivenSentry");
    }

    return false;
  }

  if(istrue(self.tablet_out)) {
    if(var_0) {
      iprintlnbold("self.tablet_out");
    }

    return false;
  }

  if(istrue(self.b_in_vehicle)) {
    if(var_0) {
      iprintlnbold("self.b_in_vehicle");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(istrue(self.waiting_to_spawn)) {
    if(var_0) {
      iprintlnbold("self.waiting_to_spawn");
    }

    return false;
  }

  if(self isparachuting()) {
    if(var_0) {
      iprintlnbold("self IsParachuting()");
    }

    return false;
  }

  if(self isskydiving()) {
    if(var_0) {
      iprintlnbold("self IsSkydiving()");
    }

    return false;
  }

  if(isDefined(self.currentturret)) {
    if(var_0) {
      iprintlnbold("self.currentTurret defined");
    }

    return false;
  }

  if(istrue(self.respawn_in_progress)) {
    if(var_0) {
      iprintlnbold("respawn in progress");
    }

    return false;
  }

  if(istrue(self.isjuggernaut)) {
    if(var_0) {
      iprintlnbold("self.isJuggernaut");
    }

    return false;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(var_0) {
      iprintlnbold("self is nuclear core carrier");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(var_0) {
      iprintlnbold("player in last stand");
    }

    return false;
  }

  if(istrue(self.islockedinkidnapanim)) {
    if(var_0) {
      iprintlnbold("self.isLockedInKidnapAnim");
    }

    return false;
  }

  if(self isjumping()) {
    if(var_0) {
      iprintlnbold("self IsJumping()");
    }

    return false;
  }

  if(!self isonground()) {
    if(var_0) {
      iprintlnbold("self not IsOnGround()");
    }

    return false;
  }

  if(istrue(self.ref_140AE)) {
    if(var_0) {
      iprintlnbold("self.usingObject");
    }

    return false;
  }

  if(istrue(self.try_to_punish_with_jugg)) {
    if(var_0) {
      iprintlnbold("self.is_riding_heli");
    }

    return false;
  }

  if(istrue(level.ref_12B46)) {
    if(var_0) {
      iprintlnbold(" Regroup to plane started so disabled Munitions till process is complete");
    }

    return false;
  }

  if(istrue(self.modeusesgroundwarteamoobtriggers)) {
    if(var_0) {
      iprintlnbold("Still dropping minigun");
    }

    return false;
  }

  if(istrue(self.super_activated)) {
    if(self.super == "role_hunter" || self.super == "role_engineer") {
      if(var_0) {
        iprintlnbold("Super ability still active");
      }

      return false;
    }
  }

  if(istrue(self.gascoughinprogress)) {
    if(var_0) {
      iprintlnbold("gas cough in progress");
    }

    return false;
  }

  if(istrue(self.ref_140AB)) {
    if(var_0) {
      iprintlnbold("still using munition");
    }

    return false;
  }

  if(!scripts\common\input_allow::is_input_allowed_internal("cp_munitions")) {
    if(var_0) {
      iprintlnbold("munitions are not allowed");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  return true;
}

function ref_132C9(var_0) {
  return true;
}

function ref_12BDF(var_0, var_1) {
  self notify("remove_munition_on_use");
  self endon("remove_munition_on_use");

  if(istrue(level.unlimitedmunitions)) {
    return;
  }

  thread ref_1301A(var_0, var_1);
  self waittill("munitions_used", var_0);
  remove_munition(var_1, var_0);
}

function ref_1301A(var_0, var_1) {
  switch (var_0) {
    case "apache":
    case "chopper_gunner":
      self waittill("chopper_gunner_used");
      break;
    case "deployable_cover":
      self endon("deploy_cover_failed");
      self endon("munitions_used");
      self waittill("tac_cover_spawned");
      break;
    default:
      return;
  }

  self notify("munitions_used", var_0);
}

function triplecheck_jugg_spawned(var_0) {
  switch (var_0) {
    case "trophysystem":
    case "cruise_missile":
    case "ac130":
    case "uav":
      return true;
  }

  return false;
}

function mun_test_monitor() {
  self endon("disconnect");
  var_0 = level.disable_nvg;

  for(;;) {
    var_1 = getDvar("scr_mun_test", "");

    if(var_1 != "") {
      level.disable_nvg = 1;
      scripts\cp\equipment\nvg::removenvg();
    } else {
      level.disable_nvg = var_0;

      if(!istrue(level.disable_nvg)) {
        scripts\cp\equipment\nvg::runnvg();
      }
    }

    wait 0.1;
  }
}

function update_lua_inventory_slot(var_0) {
  self setclientomnvar("cp_munition_sel_slot_idx", var_0);
}

function get_selection_index_loop_around(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_1;
  }

  if(var_0 < var_1) {
    return var_2;
  }

  return var_0;
}

function hasmaxammo() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("reset_wave_loadout", 5);
  wait 0.5;
  self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  var_0 = 3;
  reset_munitions(self, var_0);
  cargo_truck_mg_enterend();
}

function reset_munitions(var_0, var_1) {
  var_0 notify("reset_munitions");
  var_2 = [];
  var_1 = 3;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(isDefined(var_0.munition_slots) && isDefined(var_0.munition_slots[var_3]) && isDefined(var_0.munition_slots[var_3].cooldown_progress)) {
      var_2 = var_0.munition_slots[var_3].cooldown_progress;
    } else {
      var_2[var_3] = undefined;
    }

    var_4 = var_0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();

    if(!isDefined(var_0.munition_slots) || !isDefined(var_0.munition_slots[var_3])) {
      var_0.munition_slots[var_3] = spawnStruct();
    }

    var_0.munitions_in_playerdata[var_3] = spawnStruct();

    if(scripts\cp\cp_globallogic::allow_munitions(var_0)) {
      var_0.munition_slots[var_3].ref = get_munition(var_0, var_3);
      var_0.munitions_in_playerdata[var_3].ref = var_0.munition_slots[var_3].ref;
      var_0.munition_slots[var_3].cooldown = level.munitions_table_data[var_0.munition_slots[var_3].ref].cooldown;
      var_0.munition_slots[var_3].can_use = 0;
      var_0.munition_slots[var_3].cooldown_progress = undefined;

      if(isDefined(var_2[var_3])) {
        var_0.munition_slots[var_3].cooldown_progress = var_2[var_3];
      }

      if(!istrue(level.unlimitedmunitions)) {
        var_0.munition_slots[var_3].can_use = 0;

        if(!scripts\cp\loot_system::is_empty_or_none(var_3)) {
          var_0 setclientomnvar("cp_munition_1_timer", 1);
          var_0 setclientomnvar("cp_munition_2_timer", 1);
          var_0 setclientomnvar("cp_munition_3_timer", 1);
          var_0.munition_slots[var_3].can_use = 1;
        }
      }
    } else if(!isDefined(var_0.init_munitions)) {
      var_0.munition_slots[var_3].ref = "none";
      var_0.munition_slots[var_3].cooldown = level.munitions_table_data[var_0.munition_slots[var_3].ref].cooldown;
      var_0.munition_slots[var_3].can_use = 0;
      var_0.munition_slots[var_3].cooldown_progress = undefined;
    }

    var_5 = undefined;
    var_6 = "cp_munition_slot_reset";
    var_7 = undefined;

    switch (var_3) {
      case 0:
        var_5 = "cp_munition_slot_1";
        var_7 = 1;
        break;
      case 1:
        var_5 = "cp_munition_slot_2";
        var_7 = 2;
        break;
      case 2:
        var_5 = "cp_munition_slot_3";
        var_7 = 3;
        break;
      case 3:
        var_5 = "cp_munition_slot_4";
        break;
    }

    var_8 = level.munitions_table_data[var_0.munition_slots[var_3].ref].index;

    if(isDefined(var_5) && isDefined(var_8) && isDefined(var_7)) {
      var_0 setclientomnvar(var_5, var_8);
    }
  }

  if(!isDefined(var_0.init_munitions)) {
    var_0.init_munitions = 1;
  }

  if(!isDefined(var_0.loadout_changed_flag)) {
    var_0.loadout_changed_flag = 0;
  }

  if(var_0.loadout_changed_flag == 0) {
    var_9 = 1;
  } else {
    var_9 = 0;
  }

  var_1 setclientomnvar("cp_loadout_changed", var_9);
  var_1.loadout_changed_flag = var_9;

  if(istrue(level.unlimitedmunitions)) {
    thread cooldown_munition(var_1, "munition_1_used", "cp_munition_1_timer", var_1, var_1.munition_slots[0].ref, var_1.munition_slots[0].cooldown);
    thread cooldown_munition(var_1, "munition_2_used", "cp_munition_2_timer", var_1, var_1.munition_slots[1].ref, var_1.munition_slots[1].cooldown);
    thread cooldown_munition(var_1, "munition_3_used", "cp_munition_3_timer", var_1, var_1.munition_slots[2].ref, var_1.munition_slots[2].cooldown);
    thread cooldown_munition(var_1, "munition_4_used", "cp_munition_4_timer", var_1, var_1.munition_slots[3].ref, var_1.munition_slots[3].cooldown);
    return;
  }
}

function get_munition(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionWaveModeSetups", var_0, "munition");
  } else {
    var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionSetups", var_1, "munition");
  }

  return var_1;
}

function get_role_munition(var_0) {
  var_1 = undefined;

  if(getdvarint("scr_role_v1", 0)) {
    switch (self.class) {
      case "assault":
        var_1 = "grenade_launcher";
        break;
      case "medic":
        var_1 = "adrenaline";
        break;
      case "tank":
        var_1 = "sentry";
        break;
      case "hunter":
        var_1 = "drone_strike";
        break;
      case "engineer":
        var_1 = "recon_drone";
        break;
      case "crusader":
        var_1 = "riot_shield";
        break;
      default:
        break;
    }
  } else {
    switch (self.class) {
      case "assault":
        var_1 = "ammo_crate";
        break;
      case "medic":
        var_1 = "armor";
        break;
      case "tank":
        var_1 = "armor";
        break;
      case "hunter":
        var_1 = "ammo_crate";
        break;
      case "engineer":
        var_1 = "grenade_crate";
        break;
      case "crusader":
        var_1 = "grenade_crate";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_1)) {}

  return var_1;
}

function cooldown_munition(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("reset_munitions");
  var_2 notify(var_0 + "_reset");
  var_2 endon(var_0 + "_reset");
  var_7 = var_4;
  var_8 = getdvarfloat("scr_cooldown_scalar", 1);
  var_4 = var_7 * var_8;
  var_9 = undefined;

  for(;;) {
    var_10 = 0;

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete")) {
      var_10 = 1;
    }

    if(var_10) {
      waitframe();
      continue;
    }

    if(!isDefined(var_2.munition_slots[var_5].cooldown_progress)) {
      var_2.munition_slots[var_5].cooldown_progress = 0;
      var_2 setclientomnvar(var_1, 0);
    }

    if(istrue(var_6)) {
      var_2.munition_slots[var_5].cooldown_progress = var_4;
      var_2 setclientomnvar(var_1, 1);
      var_6 = undefined;
    }

    if(var_2.munition_slots[var_5].cooldown_progress < var_4) {
      var_2.munition_slots[var_5].can_use = 0;
    }

    while(var_2.munition_slots[var_5].cooldown_progress <= var_4) {
      var_11 = getdvarfloat("scr_cooldown_scalar", 1);

      if(var_11 != var_8) {
        var_8 = var_11;
        var_4 = var_7 * var_8;
      }

      if(istrue(var_2.has_inv_cooldown)) {
        var_2.munition_slots[var_5].cooldown_progress = var_4 + 1;
      }

      if(var_4 == 0) {
        var_12 = 1;
      } else {
        var_12 = min(var_2.munition_slots[var_5].cooldown_progress / var_4, 1);
      }

      var_2 setclientomnvar(var_1, var_12);

      if(var_12 < 1) {
        var_13 = 0.05;
        var_2.munition_slots[var_5].cooldown_progress += var_13;
      } else {
        break;
      }

      wait 0.05;
    }

    var_2.munition_slots[var_5].can_use = 1;
    var_14 = "cp_" + var_3;

    if(istrue(var_9)) {
      var_2 thread scripts\cp\cp_hud_message::showsplash(var_14, undefined, self);
    }

    var_9 = 1;
    var_2 waittill(var_0);
    var_2.munition_slots[var_5].cooldown_progress = undefined;
    var_2.munition_slots[var_5].can_use = 0;
    var_2.munition_slots[var_5].ref_134E2 = undefined;
  }
}

function remove_munition_from_array(var_0, var_1) {
  for(var_2 = 0; var_2 < self.munition_slots.size; var_2++) {
    if(isDefined(self.munitions_in_playerdata[var_2]) && self.munitions_in_playerdata[var_2].ref == var_1) {
      if(var_2 == var_0) {
        self setclientomnvar("cp_munition_slot_reset", var_2);
      }

      self.munitions_in_playerdata[var_2] = undefined;
      self.munition_slots[var_0].ref_134E2 = undefined;
      break;
    }
  }
}

function ref_11E0C(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "overwatch":
    case "pickup":
      var_1 = 1;
      break;
  }

  if(var_1) {
    return true;
  }

  return false;
}

function can_use_munition(var_0) {
  if(self.munition_slots[var_0].ref == "juggernaut" && istrue(self.isjuggernaut)) {
    return false;
  }

  if(self.munition_slots[var_0].ref == "ac130" && istrue(level.gunshipinuse)) {
    return false;
  }

  if(self getcurrentweapon().basename == "tac_cover_mp") {
    return false;
  }

  if(istrue(self.munition_slots[var_0].can_use)) {
    return true;
  }

  return false;
}

function remove_munition(var_0, var_1) {
  remove_munition_from_array(var_0, var_1);
  var_2 = "none";

  if(var_0 == 0) {
    var_2 = "empty1";
    self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  } else if(var_0 == 1) {
    var_2 = "empty2";
    self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  } else if(var_0 == 2) {
    var_2 = "empty3";
    self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  }

  give_munition_to_slot(var_2, var_0);
  var_3 = "cp_munition_1_timer";

  switch (var_0) {
    case 0:
      var_3 = "cp_munition_1_timer";
      break;
    case 1:
      var_3 = "cp_munition_2_timer";
      break;
    case 2:
      var_3 = "cp_munition_3_timer";
      break;
    case 3:
      var_3 = "cp_munition_4_timer";
      break;
  }

  self setclientomnvar(var_3, 0);
  check_for_empty_munitions();
  assign_highest_full_slot_to_active();
}

function check_for_empty_munitions() {
  var_0 = 0;
  var_1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(self.munition_slots) && isDefined(self.munition_slots[var_2])) {
      if(!scripts\cp\loot_system::is_empty_or_none(var_2)) {
        var_0 += 1;
      }
    }
  }

  self.munition_slots_full = var_0;
  self setclientomnvar("cp_munition_slots_full", var_0);
}

function assign_highest_full_slot_to_active() {
  var_0 = 0;

  for(var_1 = self.munition_slots.size - 1; var_1 > -1; var_1--) {
    if(!scripts\cp\loot_system::is_empty_or_none(var_1)) {
      self.dpad_selection_index = var_1;
      break;
    }

    var_0 += 1;
  }

  if(var_0 == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function cargo_truck_mg_enterend() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self.munition_slots.size; var_1++) {
    if(!scripts\cp\loot_system::is_empty_or_none(var_1)) {
      self.dpad_selection_index = var_1;
      break;
    }

    var_0 += 1;
  }

  if(var_0 == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function has_munition(var_0) {
  foreach(var_2 in self.munition_slots) {
    if(var_2.ref == var_0) {
      return true;
    }
  }

  return false;
}

function give_munition_to_slot(var_0, var_1, var_2) {
  var_3 = update_total_slots(var_1);
  var_4 = self;

  if(!isDefined(var_1)) {
    var_1 = var_3 - 1;
  }

  if(!isDefined(self.munition_slots) || !isDefined(self.munition_slots[var_1])) {
    self.munition_slots[var_1] = spawnStruct();
  }

  self.munition_slots[var_1].ref = var_0;
  self.munition_slots[var_1].cooldown = level.munitions_table_data[self.munition_slots[var_1].ref].cooldown;
  self.munition_slots[var_1].can_use = 1;
  self.munition_slots[var_1].cooldown_progress = 1;

  if(isDefined(var_2)) {
    self.munition_slots[var_1].ref_134E2 = var_2;

    if(isDefined(self.munition_slots[var_1].ref_134E2) && ref_11E0C(self.munition_slots[var_1].ref_134E2)) {
      if(var_1 == 0) {
        self setplayerdata("cp", "alienSession", "escapedRank0", 1);
      } else if(var_1 == 1) {
        self setplayerdata("cp", "alienSession", "escapedRank1", 1);
      } else if(var_1 == 2) {
        self setplayerdata("cp", "alienSession", "escapedRank2", 1);
      }
    }
  }

  if(var_0 == "none") {
    if(isDefined(self.munition_slots[var_1].ref_134E2)) {
      self.munition_slots[var_1].ref_134E2 = undefined;
    }
  }

  var_3 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var_5 = undefined;
  var_6 = check_for_gl_proj_override(var_4, var_0);

  if(!istrue(self.munition_splash_supress)) {
    var_6 = "cp_" + var_6;
  }

  var_4 thread scripts\cp\cp_hud_message::showsplash(var_6, undefined, self);

  switch (var_1) {
    case 0:
      var_5 = "cp_munition_slot_1";
      thread cooldown_munition(var_4, "munition_1_used", "cp_munition_1_timer", var_4, var_4.munition_slots[0].ref, var_4.munition_slots[0].cooldown, 0);
      break;
    case 1:
      var_5 = "cp_munition_slot_2";
      thread cooldown_munition(var_4, "munition_2_used", "cp_munition_2_timer", var_4, var_4.munition_slots[1].ref, var_4.munition_slots[1].cooldown, 1);
      break;
    case 2:
      var_5 = "cp_munition_slot_3";
      thread cooldown_munition(var_4, "munition_3_used", "cp_munition_3_timer", var_4, var_4.munition_slots[2].ref, var_4.munition_slots[2].cooldown, 2);
      break;
    case 3:
      var_5 = "cp_munition_slot_4";
      thread cooldown_munition(var_4, "munition_4_used", "cp_munition_4_timer", var_4, var_4.munition_slots[3].ref, var_4.munition_slots[3].cooldown, 3);
      break;
  }

  var_7 = level.munitions_table_data[var_4.munition_slots[var_1].ref].index;

  if(isDefined(var_5) && isDefined(var_7)) {
    var_4 setclientomnvar(var_5, var_7);
  }

  if(isDefined(var_4.munition_slots_full) && var_4.munition_slots_full == 0) {
    check_for_empty_munitions(var_4);
    return;
  }
}

function update_total_slots(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  var_1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var_0 >= var_1 && var_1 < 3) {
    var_1 += 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var_1);
  return var_1;
}

function check_for_gl_proj_override(var_0) {
  var_1 = self;

  if(var_0 == "grenade_launcher" && isDefined(var_1.gl_proj_override)) {
    return (var_1.gl_proj_override + "_proj");
  }

  return var_0;
}

function create_munition_change_points(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "interaction";
  var_1.script_noteworthy = "loadout_change_interaction";
  var_1.requires_power = 0;
  var_1.spend_type = "null";
  var_1.cost = 0;
  var_1.b_cleared_for_drop = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

function create_airdrop_spawn_structs() {
  wait 50;
  var_0 = scripts\engine\utility::getStructArray("loadout_change_struct", "script_noteworthy");
  level.struct_array_loadout_locations = [];

  foreach(var_2 in var_0) {
    var_2.b_cleared_for_drop = 1;
    var_2.next_airdrop_time = gettime() + 50000;
    var_2.team = "allies";
    var_2.model = spawn("script_model", var_2.origin);
    var_2.model setModel(var_2.script_modelname);

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_2.model.angles = var_2.angles;
    level.struct_array_loadout_locations = scripts\engine\utility::array_add(level.struct_array_loadout_locations, var_2);
    thread run_airdrop_spawn_loop();
  }
}

function run_airdrop_spawn_loop() {
  for(;;) {
    if(gettime() > self.next_airdrop_time) {
      spawn_airdrop_at_point(self);
    }

    waitframe();
  }
}

function spawn_airdrop_at_point(var_0) {
  if(!istrue(var_0.b_cleared_for_drop)) {
    var_0.next_airdrop_time = gettime() + 50000;
    return;
  }

  var_0.b_cleared_for_drop = 0;
  var_1 = getrandomnavpoint(var_0.origin, 128);
  scripts\cp\crafting_system::airdrop_new_loadout_near_player(var_0, var_1);
  var_0 waittill("change_loadout_timer");
  var_0.next_airdrop_time = gettime() + 50000;
  var_0.b_cleared_for_drop = 1;
}

function create_munitions_interaction() {
  scripts\cp\cp_interaction::register_interaction("loadout_change_interaction", "null", undefined, &loadout_change_hint, &loadout_change_activate, 0, 0, undefined);
  var_0 = scripts\engine\utility::getStructArray("loadout_change_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    create_munition_change_points(var_2);
  }
}

function loadout_change_hint(var_0, var_1) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

function loadout_change_activate(var_0, var_1) {
  var_1 endon("disconnect");

  if(scripts\cp\crafting_system::is_player_allowed_to_airdrop(var_1)) {
    if(scripts\cp\crafting_system::should_allow_airdrop()) {
      var_1.loadout_in_progress = 1;
      scripts\cp\crafting_system::airdrop_new_loadout_near_player(var_1);
      return;
    }

    return;
  }
}

function ref_12BE1(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = 20;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_5 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var_7 in var_5) {
    var_8 = getentitylessscriptablearrayinradius(undefined, undefined, var_0, var_1, var_7);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_11 setscriptablepartstate(var_7, "hidden");
      var_9++;

      if(var_9 % var_4) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function ref_12BE0(var_0) {
  var_1 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  foreach(var_3 in var_1) {
    var_4 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var_3);

    foreach(var_6 in var_4) {
      var_6 setscriptablepartstate(var_3, "hidden");
    }

    wait 0.1;
  }
}