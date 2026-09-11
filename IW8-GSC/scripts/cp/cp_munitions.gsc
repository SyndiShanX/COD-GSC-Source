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

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("cp/cp_munitiontable.csv", var0, 1);

    if(var1 == "") {
      break;
    }

    level.munitions_table_data[var1] = spawnStruct();
    level.munitions_table_data[var1].index = int(tablelookupbyrow("cp/cp_munitiontable.csv", var0, 0));
    level.munitions_table_data[var1].ref = var1;
    level.munitions_table_data[var1].cost = int(tablelookupbyrow("cp/cp_munitiontable.csv", var0, 4));
    level.munitions_table_data[var1].cooldown = float(tablelookupbyrow("cp/cp_munitiontable.csv", var0, 5));
  }
}

function givemunitionfromluinotify() {
  self endon("disconnect");
  level endon("game_ended");
  self.dpad_selection_index = 0;
  var0 = 3;
  var1 = 3;

  if(istrue(level.unlimitedmunitions)) {
    var1 = 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var1);

  for(;;) {
    self waittill("luinotifyserver", var2, var3);

    if(var2 == "radial_menu_munition") {
      var4 = 0;

      if(!ref_12474(var4)) {
        continue;
      }

      if(var3 >= 0 && var3 <= 2) {
        var5 = self.munition_slots[var3];

        if(isDefined(var5) && var5.ref != "none" && var5.ref != "empty1" && var5.ref != "empty2" && var5.ref != "empty3") {
          if(istrue(can_use_munition(var3))) {
            if(scripts\cp\cp_weapon::ref_124ad(self)) {
              var6 = ref_132c9(var5.ref);

              if(var6) {
                self.modeusesgroundwarteamoobtriggers = 1;
                scripts\cp\cp_weapon::minigamefinishcount(self);
                self waittill("weapon_change");

                while(scripts\cp\cp_weapon::ref_124ad(self)) {
                  waitframe();
                }

                self.modeusesgroundwarteamoobtriggers = undefined;

                if(!ref_12474(var4)) {
                  continue;
                }
              }
            }

            thread ref_12bdf(var5.ref, var3);
            var7 = scripts\cp\crafting_system::giveitembasedoncraftingstruct(var5.ref);

            if(var7) {
              if(triplecheck_jugg_spawned(var5.ref)) {
                self notify("munitions_used", var5.ref);
              }

              scripts\cp\cp_analytics::ref_119b6(self, var5.ref);
            } else {
              self notify("remove_munition_on_use");
            }
          }
        }
      }
    }
  }
}

function ref_12474(var0) {
  if(istrue(level.disable_munitions)) {
    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(!isDefined(self.munition_slots)) {
    if(var0) {
      iprintlnbold("self.munition_slots undefined");
    }

    return false;
  }

  if(self isonladder()) {
    if(var0) {
      iprintlnbold("IsOnLadder() failed");
    }

    return false;
  }

  if(istrue(self.spectating)) {
    if(var0) {
      iprintlnbold("self.spectating");
    }

    return false;
  }

  if(isDefined(self.currentpiece)) {
    if(var0) {
      iprintlnbold("self.currentPiece defined");
    }

    return false;
  }

  if(istrue(self.is_fast_traveling)) {
    if(var0) {
      iprintlnbold("self.is_fast_traveling");
    }

    return false;
  }

  if(istrue(self.inlaststand)) {
    if(var0) {
      iprintlnbold("self.inLastStand");
    }

    return false;
  }

  if(istrue(self.trackriotshield_tryback)) {
    if(var0) {
      iprintlnbold("self.instant_revive_buffer");
    }

    return false;
  }

  if(istrue(self.isreviving)) {
    if(var0) {
      iprintlnbold("self.isReviving");
    }

    return false;
  }

  if(isDefined(self.placementmodel)) {
    if(var0) {
      iprintlnbold("self.placementModel defined");
    }

    return false;
  }

  if(istrue(self.iscarrying)) {
    if(var0) {
      iprintlnbold("self.isCarrying");
    }

    return false;
  }

  if(isDefined(self.hostagecarried)) {
    if(var0) {
      iprintlnbold("self.hostageCarried defined");
    }

    return false;
  }

  if(level.gametype == "cp_pvpve") {
    if(var0) {
      iprintlnbold("level.gametype == cp_pvpve");
    }

    return false;
  }

  if(istrue(self.bgivensentry)) {
    if(var0) {
      iprintlnbold("self.bGivenSentry");
    }

    return false;
  }

  if(istrue(self.tablet_out)) {
    if(var0) {
      iprintlnbold("self.tablet_out");
    }

    return false;
  }

  if(istrue(self.b_in_vehicle)) {
    if(var0) {
      iprintlnbold("self.b_in_vehicle");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(istrue(self.waiting_to_spawn)) {
    if(var0) {
      iprintlnbold("self.waiting_to_spawn");
    }

    return false;
  }

  if(self isparachuting()) {
    if(var0) {
      iprintlnbold("self IsParachuting()");
    }

    return false;
  }

  if(self isskydiving()) {
    if(var0) {
      iprintlnbold("self IsSkydiving()");
    }

    return false;
  }

  if(isDefined(self.currentturret)) {
    if(var0) {
      iprintlnbold("self.currentTurret defined");
    }

    return false;
  }

  if(istrue(self.respawn_in_progress)) {
    if(var0) {
      iprintlnbold("respawn in progress");
    }

    return false;
  }

  if(istrue(self.isjuggernaut)) {
    if(var0) {
      iprintlnbold("self.isJuggernaut");
    }

    return false;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(var0) {
      iprintlnbold("self is nuclear core carrier");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(var0) {
      iprintlnbold("player in last stand");
    }

    return false;
  }

  if(istrue(self.islockedinkidnapanim)) {
    if(var0) {
      iprintlnbold("self.isLockedInKidnapAnim");
    }

    return false;
  }

  if(self isjumping()) {
    if(var0) {
      iprintlnbold("self IsJumping()");
    }

    return false;
  }

  if(!self isonground()) {
    if(var0) {
      iprintlnbold("self not IsOnGround()");
    }

    return false;
  }

  if(istrue(self.ref_140ae)) {
    if(var0) {
      iprintlnbold("self.usingObject");
    }

    return false;
  }

  if(istrue(self.try_to_punish_with_jugg)) {
    if(var0) {
      iprintlnbold("self.is_riding_heli");
    }

    return false;
  }

  if(istrue(level.ref_12b46)) {
    if(var0) {
      iprintlnbold(" Regroup to plane started so disabled Munitions till process is complete");
    }

    return false;
  }

  if(istrue(self.modeusesgroundwarteamoobtriggers)) {
    if(var0) {
      iprintlnbold("Still dropping minigun");
    }

    return false;
  }

  if(istrue(self.super_activated)) {
    if(self.super == "role_hunter" || self.super == "role_engineer") {
      if(var0) {
        iprintlnbold("Super ability still active");
      }

      return false;
    }
  }

  if(istrue(self.gascoughinprogress)) {
    if(var0) {
      iprintlnbold("gas cough in progress");
    }

    return false;
  }

  if(istrue(self.ref_140ab)) {
    if(var0) {
      iprintlnbold("still using munition");
    }

    return false;
  }

  if(!scripts\common\input_allow::is_input_allowed_internal("cp_munitions")) {
    if(var0) {
      iprintlnbold("munitions are not allowed");
    }

    scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  return true;
}

function ref_132c9(var0) {
  return true;
}

function ref_12bdf(var0, var1) {
  self notify("remove_munition_on_use");
  self endon("remove_munition_on_use");

  if(istrue(level.unlimitedmunitions)) {
    return;
  }

  thread ref_1301a(var0, var1);
  self waittill("munitions_used", var0);
  remove_munition(var1, var0);
}

function ref_1301a(var0, var1) {
  switch (var0) {
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

  self notify("munitions_used", var0);
}

function triplecheck_jugg_spawned(var0) {
  switch (var0) {
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
  var0 = level.disable_nvg;

  for(;;) {
    var1 = getDvar("scr_mun_test", "");

    if(var1 != "") {
      level.disable_nvg = 1;
      scripts\cp\equipment\nvg::removenvg();
    } else {
      level.disable_nvg = var0;

      if(!istrue(level.disable_nvg)) {
        scripts\cp\equipment\nvg::runnvg();
      }
    }

    wait 0.1;
  }
}

function update_lua_inventory_slot(var0) {
  self setclientomnvar("cp_munition_sel_slot_idx", var0);
}

function get_selection_index_loop_around(var0, var1, var2) {
  if(var0 > var2) {
    return var1;
  }

  if(var0 < var1) {
    return var2;
  }

  return var0;
}

function hasmaxammo() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("reset_wave_loadout", 5);
  wait 0.5;
  self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  var0 = 3;
  reset_munitions(self, var0);
  cargo_truck_mg_enterend();
}

function reset_munitions(var0, var1) {
  var0 notify("reset_munitions");
  var2 = [];
  var1 = 3;

  for(var3 = 0; var3 < var1; var3++) {
    if(isDefined(var0.munition_slots) && isDefined(var0.munition_slots[var3]) && isDefined(var0.munition_slots[var3].cooldown_progress)) {
      var2 = var0.munition_slots[var3].cooldown_progress;
    } else {
      var2[var3] = undefined;
    }

    var4 = var0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();

    if(!isDefined(var0.munition_slots) || !isDefined(var0.munition_slots[var3])) {
      var0.munition_slots[var3] = spawnStruct();
    }

    var0.munitions_in_playerdata[var3] = spawnStruct();

    if(scripts\cp\cp_globallogic::allow_munitions(var0)) {
      var0.munition_slots[var3].ref = get_munition(var0, var3);
      var0.munitions_in_playerdata[var3].ref = var0.munition_slots[var3].ref;
      var0.munition_slots[var3].cooldown = level.munitions_table_data[var0.munition_slots[var3].ref].cooldown;
      var0.munition_slots[var3].can_use = 0;
      var0.munition_slots[var3].cooldown_progress = undefined;

      if(isDefined(var2[var3])) {
        var0.munition_slots[var3].cooldown_progress = var2[var3];
      }

      if(!istrue(level.unlimitedmunitions)) {
        var0.munition_slots[var3].can_use = 0;

        if(!scripts\cp\loot_system::is_empty_or_none(var3)) {
          var0 setclientomnvar("cp_munition_1_timer", 1);
          var0 setclientomnvar("cp_munition_2_timer", 1);
          var0 setclientomnvar("cp_munition_3_timer", 1);
          var0.munition_slots[var3].can_use = 1;
        }
      }
    } else if(!isDefined(var0.init_munitions)) {
      var0.munition_slots[var3].ref = "none";
      var0.munition_slots[var3].cooldown = level.munitions_table_data[var0.munition_slots[var3].ref].cooldown;
      var0.munition_slots[var3].can_use = 0;
      var0.munition_slots[var3].cooldown_progress = undefined;
    }

    var5 = undefined;
    var6 = "cp_munition_slot_reset";
    var7 = undefined;

    switch (var3) {
      case 0:
        var5 = "cp_munition_slot_1";
        var7 = 1;
        break;
      case 1:
        var5 = "cp_munition_slot_2";
        var7 = 2;
        break;
      case 2:
        var5 = "cp_munition_slot_3";
        var7 = 3;
        break;
      case 3:
        var5 = "cp_munition_slot_4";
        break;
    }

    var8 = level.munitions_table_data[var0.munition_slots[var3].ref].index;

    if(isDefined(var5) && isDefined(var8) && isDefined(var7)) {
      var0 setclientomnvar(var5, var8);
    }
  }

  if(!isDefined(var0.init_munitions)) {
    var0.init_munitions = 1;
  }

  if(!isDefined(var0.loadout_changed_flag)) {
    var0.loadout_changed_flag = 0;
  }

  if(var0.loadout_changed_flag == 0) {
    var9 = 1;
  } else {
    var9 = 0;
  }

  var1 setclientomnvar("cp_loadout_changed", var9);
  var1.loadout_changed_flag = var9;

  if(istrue(level.unlimitedmunitions)) {
    thread cooldown_munition(var1, "munition_1_used", "cp_munition_1_timer", var1, var1.munition_slots[0].ref, var1.munition_slots[0].cooldown);
    thread cooldown_munition(var1, "munition_2_used", "cp_munition_2_timer", var1, var1.munition_slots[1].ref, var1.munition_slots[1].cooldown);
    thread cooldown_munition(var1, "munition_3_used", "cp_munition_3_timer", var1, var1.munition_slots[2].ref, var1.munition_slots[2].cooldown);
    thread cooldown_munition(var1, "munition_4_used", "cp_munition_4_timer", var1, var1.munition_slots[3].ref, var1.munition_slots[3].cooldown);
    return;
  }
}

function get_munition(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionWaveModeSetups", var0, "munition");
  } else {
    var1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionSetups", var1, "munition");
  }

  return var1;
}

function get_role_munition(var0) {
  var1 = undefined;

  if(getdvarint("scr_role_v1", 0)) {
    switch (self.class) {
      case "assault":
        var1 = "grenade_launcher";
        break;
      case "medic":
        var1 = "adrenaline";
        break;
      case "tank":
        var1 = "sentry";
        break;
      case "hunter":
        var1 = "drone_strike";
        break;
      case "engineer":
        var1 = "recon_drone";
        break;
      case "crusader":
        var1 = "riot_shield";
        break;
      default:
        break;
    }
  } else {
    switch (self.class) {
      case "assault":
        var1 = "ammo_crate";
        break;
      case "medic":
        var1 = "armor";
        break;
      case "tank":
        var1 = "armor";
        break;
      case "hunter":
        var1 = "ammo_crate";
        break;
      case "engineer":
        var1 = "grenade_crate";
        break;
      case "crusader":
        var1 = "grenade_crate";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var1)) {}

  return var1;
}

function cooldown_munition(var0, var1, var2, var3, var4, var5, var6) {
  level endon("game_ended");
  var2 endon("disconnect");
  var2 endon("reset_munitions");
  var2 notify(var0 + "_reset");
  var2 endon(var0 + "_reset");
  var7 = var4;
  var8 = getdvarfloat("scr_cooldown_scalar", 1);
  var4 = var7 * var8;
  var9 = undefined;

  for(;;) {
    var10 = 0;

    if(scripts\engine\utility::flag_exist("infil_complete") && !scripts\engine\utility::flag("infil_complete")) {
      var10 = 1;
    }

    if(var10) {
      waitframe();
      continue;
    }

    if(!isDefined(var2.munition_slots[var5].cooldown_progress)) {
      var2.munition_slots[var5].cooldown_progress = 0;
      var2 setclientomnvar(var1, 0);
    }

    if(istrue(var6)) {
      var2.munition_slots[var5].cooldown_progress = var4;
      var2 setclientomnvar(var1, 1);
      var6 = undefined;
    }

    if(var2.munition_slots[var5].cooldown_progress < var4) {
      var2.munition_slots[var5].can_use = 0;
    }

    while(var2.munition_slots[var5].cooldown_progress <= var4) {
      var11 = getdvarfloat("scr_cooldown_scalar", 1);

      if(var11 != var8) {
        var8 = var11;
        var4 = var7 * var8;
      }

      if(istrue(var2.has_inv_cooldown)) {
        var2.munition_slots[var5].cooldown_progress = var4 + 1;
      }

      if(var4 == 0) {
        var12 = 1;
      } else {
        var12 = min(var2.munition_slots[var5].cooldown_progress / var4, 1);
      }

      var2 setclientomnvar(var1, var12);

      if(var12 < 1) {
        var13 = 0.05;
        var2.munition_slots[var5].cooldown_progress += var13;
      } else {
        break;
      }

      wait 0.05;
    }

    var2.munition_slots[var5].can_use = 1;
    var14 = "cp_" + var3;

    if(istrue(var9)) {
      var2 thread scripts\cp\cp_hud_message::showsplash(var14, undefined, self);
    }

    var9 = 1;
    var2 waittill(var0);
    var2.munition_slots[var5].cooldown_progress = undefined;
    var2.munition_slots[var5].can_use = 0;
    var2.munition_slots[var5].ref_134e2 = undefined;
  }
}

function remove_munition_from_array(var0, var1) {
  for(var2 = 0; var2 < self.munition_slots.size; var2++) {
    if(isDefined(self.munitions_in_playerdata[var2]) && self.munitions_in_playerdata[var2].ref == var1) {
      if(var2 == var0) {
        self setclientomnvar("cp_munition_slot_reset", var2);
      }

      self.munitions_in_playerdata[var2] = undefined;
      self.munition_slots[var0].ref_134e2 = undefined;
      break;
    }
  }
}

function ref_11e0c(var0) {
  var1 = 0;

  switch (var0) {
    case "overwatch":
    case "pickup":
      var1 = 1;
      break;
  }

  if(var1) {
    return true;
  }

  return false;
}

function can_use_munition(var0) {
  if(self.munition_slots[var0].ref == "juggernaut" && istrue(self.isjuggernaut)) {
    return false;
  }

  if(self.munition_slots[var0].ref == "ac130" && istrue(level.gunshipinuse)) {
    return false;
  }

  if(self getcurrentweapon().basename == "tac_cover_mp") {
    return false;
  }

  if(istrue(self.munition_slots[var0].can_use)) {
    return true;
  }

  return false;
}

function remove_munition(var0, var1) {
  remove_munition_from_array(var0, var1);
  var2 = "none";

  if(var0 == 0) {
    var2 = "empty1";
    self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  } else if(var0 == 1) {
    var2 = "empty2";
    self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  } else if(var0 == 2) {
    var2 = "empty3";
    self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  }

  give_munition_to_slot(var2, var0);
  var3 = "cp_munition_1_timer";

  switch (var0) {
    case 0:
      var3 = "cp_munition_1_timer";
      break;
    case 1:
      var3 = "cp_munition_2_timer";
      break;
    case 2:
      var3 = "cp_munition_3_timer";
      break;
    case 3:
      var3 = "cp_munition_4_timer";
      break;
  }

  self setclientomnvar(var3, 0);
  check_for_empty_munitions();
  assign_highest_full_slot_to_active();
}

function check_for_empty_munitions() {
  var0 = 0;
  var1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  for(var2 = 0; var2 < var1; var2++) {
    if(isDefined(self.munition_slots) && isDefined(self.munition_slots[var2])) {
      if(!scripts\cp\loot_system::is_empty_or_none(var2)) {
        var0 += 1;
      }
    }
  }

  self.munition_slots_full = var0;
  self setclientomnvar("cp_munition_slots_full", var0);
}

function assign_highest_full_slot_to_active() {
  var0 = 0;

  for(var1 = self.munition_slots.size - 1; var1 > -1; var1--) {
    if(!scripts\cp\loot_system::is_empty_or_none(var1)) {
      self.dpad_selection_index = var1;
      break;
    }

    var0 += 1;
  }

  if(var0 == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function cargo_truck_mg_enterend() {
  var0 = 0;

  for(var1 = 0; var1 < self.munition_slots.size; var1++) {
    if(!scripts\cp\loot_system::is_empty_or_none(var1)) {
      self.dpad_selection_index = var1;
      break;
    }

    var0 += 1;
  }

  if(var0 == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function has_munition(var0) {
  foreach(var2 in self.munition_slots) {
    if(var2.ref == var0) {
      return true;
    }
  }

  return false;
}

function give_munition_to_slot(var0, var1, var2) {
  var3 = update_total_slots(var1);
  var4 = self;

  if(!isDefined(var1)) {
    var1 = var3 - 1;
  }

  if(!isDefined(self.munition_slots) || !isDefined(self.munition_slots[var1])) {
    self.munition_slots[var1] = spawnStruct();
  }

  self.munition_slots[var1].ref = var0;
  self.munition_slots[var1].cooldown = level.munitions_table_data[self.munition_slots[var1].ref].cooldown;
  self.munition_slots[var1].can_use = 1;
  self.munition_slots[var1].cooldown_progress = 1;

  if(isDefined(var2)) {
    self.munition_slots[var1].ref_134e2 = var2;

    if(isDefined(self.munition_slots[var1].ref_134e2) && ref_11e0c(self.munition_slots[var1].ref_134e2)) {
      if(var1 == 0) {
        self setplayerdata("cp", "alienSession", "escapedRank0", 1);
      } else if(var1 == 1) {
        self setplayerdata("cp", "alienSession", "escapedRank1", 1);
      } else if(var1 == 2) {
        self setplayerdata("cp", "alienSession", "escapedRank2", 1);
      }
    }
  }

  if(var0 == "none") {
    if(isDefined(self.munition_slots[var1].ref_134e2)) {
      self.munition_slots[var1].ref_134e2 = undefined;
    }
  }

  var3 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var5 = undefined;
  var6 = check_for_gl_proj_override(var4, var0);

  if(!istrue(self.munition_splash_supress)) {
    var6 = "cp_" + var6;
  }

  var4 thread scripts\cp\cp_hud_message::showsplash(var6, undefined, self);

  switch (var1) {
    case 0:
      var5 = "cp_munition_slot_1";
      thread cooldown_munition(var4, "munition_1_used", "cp_munition_1_timer", var4, var4.munition_slots[0].ref, var4.munition_slots[0].cooldown, 0);
      break;
    case 1:
      var5 = "cp_munition_slot_2";
      thread cooldown_munition(var4, "munition_2_used", "cp_munition_2_timer", var4, var4.munition_slots[1].ref, var4.munition_slots[1].cooldown, 1);
      break;
    case 2:
      var5 = "cp_munition_slot_3";
      thread cooldown_munition(var4, "munition_3_used", "cp_munition_3_timer", var4, var4.munition_slots[2].ref, var4.munition_slots[2].cooldown, 2);
      break;
    case 3:
      var5 = "cp_munition_slot_4";
      thread cooldown_munition(var4, "munition_4_used", "cp_munition_4_timer", var4, var4.munition_slots[3].ref, var4.munition_slots[3].cooldown, 3);
      break;
  }

  var7 = level.munitions_table_data[var4.munition_slots[var1].ref].index;

  if(isDefined(var5) && isDefined(var7)) {
    var4 setclientomnvar(var5, var7);
  }

  if(isDefined(var4.munition_slots_full) && var4.munition_slots_full == 0) {
    check_for_empty_munitions(var4);
    return;
  }
}

function update_total_slots(var0) {
  if(!isDefined(var0)) {
    var0 = 5;
  }

  var1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var0 >= var1 && var1 < 3) {
    var1 += 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var1);
  return var1;
}

function check_for_gl_proj_override(var0) {
  var1 = self;

  if(var0 == "grenade_launcher" && isDefined(var1.gl_proj_override)) {
    return (var1.gl_proj_override + "_proj");
  }

  return var0;
}

function create_munition_change_points(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.targetname = "interaction";
  var1.script_noteworthy = "loadout_change_interaction";
  var1.requires_power = 0;
  var1.spend_type = "null";
  var1.cost = 0;
  var1.b_cleared_for_drop = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var1);
}

function create_airdrop_spawn_structs() {
  wait 50;
  var0 = scripts\engine\utility::getStructArray("loadout_change_struct", "script_noteworthy");
  level.struct_array_loadout_locations = [];

  foreach(var2 in var0) {
    var2.b_cleared_for_drop = 1;
    var2.next_airdrop_time = gettime() + 50000;
    var2.team = "allies";
    var2.model = spawn("script_model", var2.origin);
    var2.model setModel(var2.script_modelname);

    if(!isDefined(var2.angles)) {
      var2.angles = (0, 0, 0);
    }

    var2.model.angles = var2.angles;
    level.struct_array_loadout_locations = scripts\engine\utility::array_add(level.struct_array_loadout_locations, var2);
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

function spawn_airdrop_at_point(var0) {
  if(!istrue(var0.b_cleared_for_drop)) {
    var0.next_airdrop_time = gettime() + 50000;
    return;
  }

  var0.b_cleared_for_drop = 0;
  var1 = getrandomnavpoint(var0.origin, 128);
  scripts\cp\crafting_system::airdrop_new_loadout_near_player(var0, var1);
  var0 waittill("change_loadout_timer");
  var0.next_airdrop_time = gettime() + 50000;
  var0.b_cleared_for_drop = 1;
}

function create_munitions_interaction() {
  scripts\cp\cp_interaction::register_interaction("loadout_change_interaction", "null", undefined, &loadout_change_hint, &loadout_change_activate, 0, 0, undefined);
  var0 = scripts\engine\utility::getStructArray("loadout_change_struct", "script_noteworthy");

  foreach(var2 in var0) {
    create_munition_change_points(var2);
  }
}

function loadout_change_hint(var0, var1) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

function loadout_change_activate(var0, var1) {
  var1 endon("disconnect");

  if(scripts\cp\crafting_system::is_player_allowed_to_airdrop(var1)) {
    if(scripts\cp\crafting_system::should_allow_airdrop()) {
      var1.loadout_in_progress = 1;
      scripts\cp\crafting_system::airdrop_new_loadout_near_player(var1);
      return;
    }

    return;
  }
}

function ref_12be1(var0, var1, var2) {
  var3 = var1 * var1;
  var4 = 20;

  if(isDefined(var2)) {
    var4 = var2;
  }

  var5 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var7 in var5) {
    var8 = getentitylessscriptablearrayinradius(undefined, undefined, var0, var1, var7);
    var9 = 0;

    foreach(var11 in var8) {
      var11 setscriptablepartstate(var7, "hidden");
      var9++;

      if(var9 % var4) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function ref_12be0(var0) {
  var1 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  if(isDefined(var0)) {
    var1 = var0;
  }

  foreach(var3 in var1) {
    var4 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var3);

    foreach(var6 in var4) {
      var6 setscriptablepartstate(var3, "hidden");
    }

    wait 0.1;
  }
}