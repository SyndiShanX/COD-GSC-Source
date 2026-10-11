/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\munitions.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_weapons;
#using scripts\cp\equipment\nvg;
#using scripts\cp\globallogic;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\player_flashlight;
#using scripts\cp\powers\cp_tactical_cover;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\assault_drone;
#using scripts\cp_mp\killstreaks\auto_drone;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\cruise_predator;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\hover_jet;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\killstreaks\ims;
#using scripts\killstreaks\killstreak_shared;
#using scripts\killstreaks\loitering_munition;
#using scripts\killstreaks\lrad;
#using scripts\killstreaks\missile_turret;
#namespace munitions;

function init_munitions() {
  level.munitions_table_data = [];
  level.ammoincompatibleweaponslist = ["iw9_la_mike32_mp"];
  level.var_e9059297c2017879 = [];
  level.var_89f755af301fc71e = ["gunship", "assault_drone", "chopper_gunner", "cruise_missile"];
  level.var_55c84262b9114f3c = ["gunship", "chopper_gunner", "cruise_missile", "precision_airstrike", "auto_drone", "hover_jet", "toma_strike", "loitering_munition", "missile_turret", "assault_drone"];
  level.var_fd57bc164397d837 = ["chopper_gunner", "cruise_missile", "auto_drone", "hover_jet", "precision_airstrike", "toma_strike", "uav", "switchblade_drone", "sentry", "cluster_spike", "assault_drone", "missile_turret"];
  level.var_affc75ae2955c39f = "tablet_start";
  val::group_register(level.var_affc75ae2955c39f, ["cp_munitions_pickup"]);
  setdvarifuninitialized(@ "hash_f897a05f1af906a1", 0);
  read_munition_table();

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "<dev string:x1c>" || level.createfx_enabled) {
    return;
  }

  initkillstreakdata();
  level.unlimitedmunitions = getdvarint(@ "hash_f897a05f1af906a1", 0);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_65a298ec5c2f2ff4);
}

function initkillstreakdata() {
  globals = spawnStruct();
  level.streakglobals = globals;
  globals.costomnvars = [];
  globals.costomnvars[1] = "ui_score_streak_cost";
  globals.costomnvars[2] = "ui_score_streak_two_cost";
  globals.costomnvars[3] = "ui_score_streak_three_cost";
  globals.slotomnvars = [];
  globals.slotomnvars[0] = "ui_score_streak_index_0";
  globals.slotomnvars[1] = "ui_score_streak_index_1";
  globals.slotomnvars[2] = "ui_score_streak_index_2";
  globals.slotomnvars[3] = "ui_score_streak_index_3";
  globals.availableomnvars = [];
  globals.availableomnvars[0] = "ui_score_streak_available_0";
  globals.availableomnvars[1] = "ui_score_streak_available_1";
  globals.availableomnvars[2] = "ui_score_streak_available_2";
  globals.availableomnvars[3] = "ui_score_streak_available_3";
  globals.var_8bbe6dc152f1dae0 = [];
  globals.var_8bbe6dc152f1dae0[1] = "ui_score_streak_last_round_earned_1";
  globals.var_8bbe6dc152f1dae0[2] = "ui_score_streak_last_round_earned_2";
  globals.var_8bbe6dc152f1dae0[3] = "ui_score_streak_last_round_earned_3";
  function_570918ef81285e16();
}

function function_570918ef81285e16() {
  globals = level.streakglobals;

  if(isDefined(globals.streakbundles)) {
    return;
  }

  globals.streakbundles = [];
  globals.var_2150da9328528bb9 = [];
  killstreaklistbundle = getscriptbundle(scripts\cp_mp\utility\killstreak_utility::function_708853c5d755f72());

  foreach(index, killstreaklistentry in killstreaklistbundle.killstreak_list) {
    if(!isnumber(index)) {
      continue;
    }

    if(!isDefined(killstreaklistentry)) {
      continue;
    }

    killstreakbundlename = killstreaklistentry.bundle;

    if(!isDefined(killstreakbundlename)) {
      continue;
    }

    assert(isxhashasset(killstreakbundlename));

    if(killstreakbundlename == % "killstreak:killstreak_none") {
      continue;
    }

    if(killstreakbundlename == % "hash_40daaf59ab8992e5") {
      continue;
    }

    bundle = getscriptbundle(killstreakbundlename);

    if(!isDefined(bundle)) {
      continue;
    }

    streakref = bundle.killstreakref;

    if(!isDefined(streakref) || streakref == "none") {
      assert(isDefined(streakref));
      continue;
    }

    bundle.var_19fb085453713468 = killstreakbundlename;
    function_2ff74098fad17213(killstreaklistentry, streakref);
    globals.streakbundles[streakref] = bundle;
    globals.var_2150da9328528bb9[streakref] = index;
  }
}

function function_65a298ec5c2f2ff4() {
  if(function_240f7f4e57340e8f()) {
    level.var_3a7f3e66e1a1d8f5 = 1;
  } else {
    level.var_3a7f3e66e1a1d8f5 = 4;
  }

  self.munition_slots = [];
  function_25b13e44dca57e67();
  killstreaklistbundle = getscriptbundle(scripts\cp_mp\utility\killstreak_utility::function_708853c5d755f72());

  foreach(killstreaklistentry in killstreaklistbundle.killstreak_list) {
    if(!isDefined(killstreaklistentry.bundle)) {
      continue;
    }

    initializekillstreak(getxhash(killstreaklistentry.ref));
  }
}

function function_25b13e44dca57e67() {
  total_slots = level.var_3a7f3e66e1a1d8f5;
  var_794a764136e46006 = [];

  for(i = 0; i < total_slots; i++) {
    self.munition_slots[i] = spawnStruct();
    self.munition_slots[i].ref = "none";
    self.munition_slots[i].cooldown = level.munitions_table_data[self.munition_slots[i].ref].cooldown;
    self.munition_slots[i].can_use = 0;
    self.munition_slots[i].cooldown_progress = undefined;
    self.munitions_in_playerdata[i] = spawnStruct();
    self.munitions_in_playerdata[i].ref = self.munition_slots[i].ref;
  }
}

function read_munition_table() {
  for(row = 0; true; row++) {
    munition = tablelookupbyrow("cp/cp_munitiontable.csv", row, 1);

    if(munition == "") {
      break;
    }

    level.munitions_table_data[munition] = spawnStruct();
    level.munitions_table_data[munition].index = int(tablelookupbyrow("cp/cp_munitiontable.csv", row, 0));
    level.munitions_table_data[munition].ref = munition;
    level.munitions_table_data[munition].cost = int(tablelookupbyrow("cp/cp_munitiontable.csv", row, 4));
    level.munitions_table_data[munition].cooldown = float(tablelookupbyrow("cp/cp_munitiontable.csv", row, 5));
  }
}

function function_77084f05581a035() {
  self.dpad_selection_index = 0;
  max_slots = level.var_3a7f3e66e1a1d8f5;
  total_slots = level.var_3a7f3e66e1a1d8f5;

  if(istrue(level.unlimitedmunitions)) {
    total_slots = 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", total_slots);
}

function function_b64f3836c1d7a06(notification, val) {
  if(isDefined(notification)) {
    switch (notification) {
      case #"hash_954f00101888049e":
        if(!istrue(level.var_c4ed9eb36c678ed4)) {
          break;
        }
      case #"hash_c02213513d8eb1f4":
        reason = 0;

        reason = getdvarint(@ "hash_5c04fc6164658276", 0);

        if(!istrue(self.isjuggernaut)) {
          if(!player_can_use_munitions(reason)) {
            break;
          }
        } else {
          val = function_346cde477a4fef90("nvg");

          if(!isDefined(val)) {
            break;
          }
        }

        if(val >= 0 && val <= 3) {
          munition = self.munition_slots[val];

          if(isDefined(munition) && munition.ref != "none" && munition.ref != "empty1" && munition.ref != "empty2" && munition.ref != "empty3") {
            if(istrue(can_use_munition(val))) {
              if(function_240f7f4e57340e8f() && isDefined(level.var_e9059297c2017879) && array_contains(level.var_e9059297c2017879, munition.ref)) {
                thread function_e9bcf4a2a0e6dc79(munition.ref);
              } else if(function_240f7f4e57340e8f() && isDefined(level.var_89f755af301fc71e) && array_contains(level.var_89f755af301fc71e, munition.ref)) {
                thread function_6dba5503031bcc38(munition.ref);
              }

              if(munition.ref == "nvg" && !istrue(level.disable_nvg) && !istrue(self.var_4d572a54ed8571c4)) {
                if(!istrue(self.pers["useNVG"])) {
                  self.pers["useNVG"] = 1;
                  self nightvisionviewon();
                } else {
                  self.pers["useNVG"] = 0;
                  self nightvisionviewoff();
                }

                break;
              }

              if(munition.ref == "flashlight" && istrue(level.player_flashlight)) {
                thread scripts\cp\player_flashlight::toggle_flashlight();
                break;
              }

              thread remove_munition_on_use(munition.ref, val);
              success = giveitembasedoncraftingstruct(munition.ref);

              if(success) {
                if(is_instant_use_munition(munition.ref)) {
                  self notify("munitions_used", munition.ref);
                }

                scripts\cp\cp_analytics::logevent_munitionused(self, munition.ref);

                if(function_240f7f4e57340e8f()) {
                  if(!scripts\cp\loot_system::is_empty_or_none(0)) {
                    self waittill("munition_removed");
                  }

                  while(level.var_50c7b4b50d222c0 >= 0 && !isDefined(scripts\cp_mp\pickups::function_821bfba97b1251ac(level.var_e85fcf89f70a718a[level.var_50c7b4b50d222c0]))) {
                    level.var_50c7b4b50d222c0--;
                  }

                  if(level.var_50c7b4b50d222c0 >= 0) {
                    index = scripts\cp_mp\pickups::function_821bfba97b1251ac(level.var_e85fcf89f70a718a[level.var_50c7b4b50d222c0]);
                    scripts\cp_mp\pickups::equipbackpackitem(index);
                  }
                }
              } else {
                self notify("remove_munition_on_use");
                self notify("killstreak_use_finished", munition.ref);
              }
            }
          }
        }

        break;
      default:
        break;
    }
  }
}

function function_e9bcf4a2a0e6dc79(ref) {
  self endon("disconnect");
  flag_set("player_demigod");
  self waittillmatch("killstreak_deploy_finished", ref);
  flag_clear("player_demigod");
  function_3f1ccafed0f5caee();
}

function function_6dba5503031bcc38(ref) {
  self endon("disconnect");
  ref = function_9ee17a338bde061b(ref);
  flag_set("player_demigod");
  flag_set("player_using_munition");
  level.var_f2dd7048c6084bbe = ref;
  self waittillmatch("killstreak_use_finished", ref);
  flag_clear("player_demigod");
  flag_clear("player_using_munition");
  level.var_f2dd7048c6084bbe = undefined;
  function_3f1ccafed0f5caee();
}

function function_3f1ccafed0f5caee() {
  if(isDefined(self.oobendtime) && gettime() >= self.oobendtime) {
    if(isDefined(self.last_good_pos)) {
      self setOrigin(self.last_good_pos);
      return;
    }

    scripts\cp\cp_outofbounds::playeroutoftimecallback();
  }
}

function player_can_use_munitions(reason) {
  if(istrue(level.disable_munitions)) {
    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(istrue(self.disable_munitions)) {
    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(!isDefined(self.munition_slots)) {
    if(reason) {
      iprintlnbold("self.munition_slots undefined");
    }

    return false;
  }

  if(self isonladder()) {
    if(reason) {
      iprintlnbold("IsOnLadder() failed");
    }

    return false;
  }

  if(istrue(self.spectating)) {
    if(reason) {
      iprintlnbold("self.spectating");
    }

    return false;
  }

  if(isDefined(self.currentpiece)) {
    if(reason) {
      iprintlnbold("self.currentPiece defined");
    }

    return false;
  }

  if(istrue(self.is_fast_traveling)) {
    if(reason) {
      iprintlnbold("self.is_fast_traveling");
    }

    return false;
  }

  if(istrue(self.inlaststand)) {
    if(reason) {
      iprintlnbold("self.inLastStand");
    }

    return false;
  }

  if(istrue(self.instant_revive_buffer)) {
    if(reason) {
      iprintlnbold("self.instant_revive_buffer");
    }

    return false;
  }

  if(istrue(self.isreviving)) {
    if(reason) {
      iprintlnbold("self.isReviving");
    }

    return false;
  }

  if(isDefined(self.placementmodel)) {
    if(reason) {
      iprintlnbold("self.placementModel defined");
    }

    return false;
  }

  if(istrue(self.iscarrying)) {
    if(reason) {
      iprintlnbold("self.isCarrying");
    }

    return false;
  }

  if(isDefined(self.hostagecarried)) {
    if(reason) {
      iprintlnbold("self.hostageCarried defined");
    }

    return false;
  }

  if(istrue(self.bgivensentry)) {
    if(reason) {
      iprintlnbold("self.bGivenSentry");
    }

    return false;
  }

  if(istrue(self.tablet_out)) {
    if(reason) {
      iprintlnbold("self.tablet_out");
    }

    return false;
  }

  if(istrue(self.b_in_vehicle)) {
    if(reason) {
      iprintlnbold("self.b_in_vehicle");
    }

    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(istrue(self.waiting_to_spawn)) {
    if(reason) {
      iprintlnbold("self.waiting_to_spawn");
    }

    return false;
  }

  if(self isparachuting()) {
    if(reason) {
      iprintlnbold("self IsParachuting()");
    }

    return false;
  }

  if(self isskydiving()) {
    if(reason) {
      iprintlnbold("self IsSkydiving()");
    }

    return false;
  }

  if(isDefined(self.currentturret)) {
    if(reason) {
      iprintlnbold("self.currentTurret defined");
    }

    return false;
  }

  if(istrue(self.respawn_in_progress)) {
    if(reason) {
      iprintlnbold("respawn in progress");
    }

    return false;
  }

  if(istrue(self.isjuggernaut)) {
    if(reason) {
      iprintlnbold("self.isJuggernaut");
    }

    return false;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(reason) {
      iprintlnbold("self is nuclear core carrier");
    }

    thread scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
    return false;
  }

  if(scripts\cp\laststand::player_in_laststand(self)) {
    if(reason) {
      iprintlnbold("player in last stand");
    }

    return false;
  }

  if(istrue(self.islockedinkidnapanim)) {
    if(reason) {
      iprintlnbold("self.isLockedInKidnapAnim");
    }

    return false;
  }

  if(self isjumping()) {
    if(reason) {
      iprintlnbold("self IsJumping()");
    }

    return false;
  }

  if(self isswimming()) {
    if(reason) {
      iprintlnbold("self IsSwimming()");
    }

    return false;
  }

  if(!self isonground() && !self isswimming()) {
    if(reason) {
      iprintlnbold("self not IsOnGround()");
    }

    return false;
  }

  if(istrue(self.usingobject)) {
    if(reason) {
      iprintlnbold("self.usingObject");
    }

    return false;
  }

  if(istrue(self.is_riding_heli)) {
    if(reason) {
      iprintlnbold("self.is_riding_heli");
    }

    return false;
  }

  if(istrue(level.regroup_process_started)) {
    if(reason) {
      iprintlnbold(" Regroup to plane started so disabled Munitions till process is complete");
    }

    return false;
  }

  if(istrue(self.dropping_minigun)) {
    if(reason) {
      iprintlnbold("Still dropping minigun");
    }

    return false;
  }

  if(istrue(self.super_activated)) {
    if(self.super.supername == "role_hunter" || self.super.supername == "role_engineer") {
      if(reason) {
        iprintlnbold("Super ability still active");
      }

      return false;
    }
  }

  if(istrue(self.gascoughinprogress)) {
    if(reason) {
      iprintlnbold("gas cough in progress");
    }

    return false;
  }

  if(istrue(self.using_mun)) {
    if(reason) {
      iprintlnbold("still using munition");
    }

    return false;
  }

  if(!val::get("cp_munitions")) {
    if(reason) {
      iprintlnbold("munitions are not allowed");
    }

    return false;
  }

  if(istrue(self.var_d5af94588739718c)) {
    if(reason) {
      iprintlnbold("using cctv");
    }

    return false;
  }

  if(istrue(self.var_23a6763562820c70)) {
    if(reason) {
      iprintlnbold("using oxygen");
    }

    return false;
  }

  if(istrue(self.oob)) {
    if(reason) {
      iprintlnbold("player out of bounds");
    }

    return false;
  }

  return true;
}

function should_drop_minigun(ref) {
  return true;
}

function remove_munition_on_use(ref, val) {
  self notify("remove_munition_on_use");
  self endon("remove_munition_on_use");

  if(istrue(level.unlimitedmunitions)) {
    return;
  }

  thread send_munition_used_notify(ref, val);
  self waittill("munitions_used", ref);
  remove_munition(val, ref);
}

function send_munition_used_notify(ref, val) {
  switch (ref) {
    case #"hash_349713b5ad494dda":
    case #"hash_b55ba82d2cec3b73":
      self waittill("chopper_gunner_used");
      break;
    case #"hash_b161e185f1b8e117":
      self waittill("auto_drone_used");
      break;
    default:
      return;
  }

  self notify("munitions_used", ref);
}

function is_instant_use_munition(ref) {
  switch (ref) {
    case #"hash_413c38e72fe8b5bf":
    case #"hash_58136b573f30f5be":
    case #"hash_634b246c3da5c56f":
    case #"hash_eca3b9673d38fd59":
      return true;
  }

  return false;
}

function mun_test_monitor() {
  self endon("disconnect");
  var_251347bbd289c8b3 = level.disable_nvg;

  while(true) {
    mun = getDvar(@ "hash_f98dd172396621e2", "");

    if(mun != "") {
      scripts\cp\utility::function_7bb9f9b4dc700888();
      scripts\cp\equipment\nvg::removenvg();
    } else if(!istrue(level.disable_nvg)) {
      scripts\cp\equipment\nvg::runnvg();
    }

    wait 0.1;
  }
}

function update_lua_inventory_slot(selection_index) {
  self setclientomnvar("cp_munition_sel_slot_idx", selection_index);
}

function get_selection_index_loop_around(desired_value, min_value, max_value) {
  if(desired_value > max_value) {
    return min_value;
  }

  if(desired_value < min_value) {
    return max_value;
  }

  return desired_value;
}

function clear_legacy_pickup_munitions() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("reset_wave_loadout", 5);
  wait 0.5;
  self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  total_slots = level.var_3a7f3e66e1a1d8f5;
  reset_munitions(self, total_slots);
  assign_lowest_full_slot_to_active();
}

function reset_munitions(player, total_slots) {
  player notify("reset_munitions");
  var_794a764136e46006 = [];
  total_slots = level.var_3a7f3e66e1a1d8f5;

  for(i = 0; i < total_slots; i++) {
    if(isDefined(player.munition_slots) && isDefined(player.munition_slots[i]) && isDefined(player.munition_slots[i].cooldown_progress)) {
      var_794a764136e46006[i] = player.munition_slots[i].cooldown_progress;
    } else {
      var_794a764136e46006[i] = undefined;
    }

    var_a52c671acca08378 = player scripts\cp\loadout::cac_getloadoutselectedidx();

    if(!isDefined(player.munition_slots) || !isDefined(player.munition_slots[i])) {
      player.munition_slots[i] = spawnStruct();
    }

    player.munitions_in_playerdata[i] = spawnStruct();

    if(scripts\cp\globallogic::allow_munitions(player)) {
      player.munition_slots[i].ref = player get_munition(i);
      player.munitions_in_playerdata[i].ref = player.munition_slots[i].ref;
      player.munition_slots[i].cooldown = level.munitions_table_data[player.munition_slots[i].ref].cooldown;
      player.munition_slots[i].can_use = 0;
      player.munition_slots[i].cooldown_progress = undefined;

      if(isDefined(var_794a764136e46006[i])) {
        player.munition_slots[i].cooldown_progress = var_794a764136e46006[i];
      }

      if(!istrue(level.unlimitedmunitions)) {
        player.munition_slots[i].can_use = 0;

        if(!scripts\cp\loot_system::is_empty_or_none(i)) {
          player setclientomnvar("cp_munition_1_timer", 1);
          player setclientomnvar("cp_munition_2_timer", 1);
          player setclientomnvar("cp_munition_3_timer", 1);
          player setclientomnvar("cp_munition_4_timer", 1);
          player.munition_slots[i].can_use = 1;
        }
      }
    } else if(!isDefined(player.init_munitions)) {
      player.munition_slots[i].ref = "none";
      player.munition_slots[i].cooldown = level.munitions_table_data[player.munition_slots[i].ref].cooldown;
      player.munition_slots[i].can_use = 0;
      player.munition_slots[i].cooldown_progress = undefined;
    }

    omnvar = undefined;
    var_a413dae711968957 = "cp_munition_slot_reset";
    slot = undefined;

    switch (i) {
      case 0:
        omnvar = "cp_munition_slot_1";
        slot = 1;
        break;
      case 1:
        omnvar = "cp_munition_slot_2";
        slot = 2;
        break;
      case 2:
        omnvar = "cp_munition_slot_3";
        slot = 3;
        break;
      case 3:
        omnvar = "cp_munition_slot_4";
        slot = 4;
        break;
    }

    index = level.munitions_table_data[player.munition_slots[i].ref].index;

    if(isDefined(omnvar) && isDefined(index) && isDefined(slot)) {
      player setclientomnvar(omnvar, index);
    }
  }

  if(!isDefined(player.init_munitions)) {
    player.init_munitions = 1;
  }

  if(!isDefined(player.loadout_changed_flag)) {
    player.loadout_changed_flag = 0;
  }

  if(player.loadout_changed_flag == 0) {
    new_value = 1;
  } else {
    new_value = 0;
  }

  player setclientomnvar("cp_loadout_changed", new_value);
  player.loadout_changed_flag = new_value;

  if(istrue(level.unlimitedmunitions)) {
    player thread cooldown_munition("munition_1_used", "cp_munition_1_timer", player, player.munition_slots[0].ref, player.munition_slots[0].cooldown, 0);
    player thread cooldown_munition("munition_2_used", "cp_munition_2_timer", player, player.munition_slots[1].ref, player.munition_slots[1].cooldown, 1);
    player thread cooldown_munition("munition_3_used", "cp_munition_3_timer", player, player.munition_slots[2].ref, player.munition_slots[2].cooldown, 2);
    player thread cooldown_munition("munition_4_used", "cp_munition_4_timer", player, player.munition_slots[3].ref, player.munition_slots[3].cooldown, 3);
  }
}

function function_af07aad35b55fd73(pickup_name) {
  if(!isDefined(pickup_name)) {
    return false;
  }

  if(issubstr(pickup_name, "brloot_munition")) {
    return true;
  }

  return false;
}

function get_munition(var_a52c671acca08378) {
  if(is_wave_gametype()) {
    munition = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionWaveModeSetups", var_a52c671acca08378, "munition");
  } else if(function_a3577e8e6c88a56b() || function_240f7f4e57340e8f()) {
    return "none";
  } else {
    if(var_a52c671acca08378 == 3) {
      return "none";
    }

    munition = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionSetups", var_a52c671acca08378, "munition");
  }

  return munition;
}

function get_role_munition(var_a52c671acca08378) {
  mun = undefined;

  if(!isDefined(mun)) {
    println("<dev string:x1e>");
  } else {
    println("<dev string:x41>" + mun);
  }

  return mun;
}

function cooldown_munition(activation_notify, var_a64c51188d789c25, player, munition, cooldown_time, slot, start_full) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("reset_munitions");
  player notify(activation_notify + "_reset");
  player endon(activation_notify + "_reset");
  var_395fc479a3ccd472 = cooldown_time;
  cooldown_scalar = getdvarfloat(@ "hash_c2da12edf7170dd7", 1);
  cooldown_time = var_395fc479a3ccd472 * cooldown_scalar;
  splash_shown = undefined;

  while(true) {
    paused = 0;

    if(flag_exist("infil_complete") && !flag("infil_complete")) {
      paused = 1;
    }

    if(paused) {
      waitframe();
      continue;
    }

    if(!isDefined(player.munition_slots[slot].cooldown_progress)) {
      player.munition_slots[slot].cooldown_progress = 0;
      player setclientomnvar(var_a64c51188d789c25, 0);
    }

    if(istrue(start_full)) {
      player.munition_slots[slot].cooldown_progress = cooldown_time;
      player setclientomnvar(var_a64c51188d789c25, 1);
      start_full = undefined;
    }

    if(player.munition_slots[slot].cooldown_progress < cooldown_time) {
      player.munition_slots[slot].can_use = 0;
    }

    while(player.munition_slots[slot].cooldown_progress <= cooldown_time) {
      var_6e96934d67c36a7c = getdvarfloat(@ "hash_c2da12edf7170dd7", 1);

      if(var_6e96934d67c36a7c != cooldown_scalar) {
        cooldown_scalar = var_6e96934d67c36a7c;
        cooldown_time = var_395fc479a3ccd472 * cooldown_scalar;
      }

      if(istrue(player.has_inv_cooldown)) {
        player.munition_slots[slot].cooldown_progress = cooldown_time + 1;
      }

      if(cooldown_time == 0) {
        progress_ratio = 1;
      } else {
        progress_ratio = min(player.munition_slots[slot].cooldown_progress / cooldown_time, 1);
      }

      player setclientomnvar(var_a64c51188d789c25, progress_ratio);

      if(progress_ratio < 1) {
        progress_increment = 0.05;
        player.munition_slots[slot].cooldown_progress += progress_increment;
      } else {
        break;
      }

      wait 0.05;
    }

    player.munition_slots[slot].can_use = 1;
    splashref = "cp_" + munition;

    if(istrue(splash_shown)) {
      player thread scripts\cp\cp_hud_message::showsplash(splashref, undefined, self);
    }

    splash_shown = 1;
    player waittill(activation_notify);
    player.munition_slots[slot].cooldown_progress = undefined;
    player.munition_slots[slot].can_use = 0;
    player.munition_slots[slot].source = undefined;
  }
}

function remove_munition_from_array(slot, munition) {
  for(i = 0; i < self.munition_slots.size; i++) {
    if(isDefined(self.munitions_in_playerdata[i]) && self.munitions_in_playerdata[i].ref == munition) {
      if(i == slot) {
        self setclientomnvar("cp_munition_slot_reset", i);
      }

      self.munitions_in_playerdata[i] = undefined;
      self.munition_slots[slot].source = undefined;
      break;
    }
  }
}

function munition_source_getridof(name) {
  var_38cc1dc20c14e9d0 = 0;

  switch (name) {
    case #"hash_11f18aa9ebd8bac6":
    case #"hash_52a1df2f94f2cfe5":
      var_38cc1dc20c14e9d0 = 1;
      break;
  }

  if(var_38cc1dc20c14e9d0) {
    return true;
  }

  return false;
}

function can_use_munition(slot) {
  if(self.munition_slots[slot].ref == "juggernaut" && istrue(self.isjuggernaut)) {
    return false;
  }

  if(self.munition_slots[slot].ref == "gunship" && istrue(level.gunshipinuse)) {
    return false;
  }

  if(self getcurrentweapon().basename == "tac_cover_mp") {
    return false;
  }

  if(istrue(self.munition_slots[slot].can_use)) {
    return true;
  }

  return false;
}

function remove_munition(slot, munition) {
  remove_munition_from_array(slot, munition);
  var_1dd5348e4e741473 = "none";

  if(slot == 0) {
    var_1dd5348e4e741473 = "empty1";
    self setplayerdata("cp", "alienSession", "escapedRank0", 0);
  } else if(slot == 1) {
    var_1dd5348e4e741473 = "empty2";
    self setplayerdata("cp", "alienSession", "escapedRank1", 0);
  } else if(slot == 2) {
    var_1dd5348e4e741473 = "empty3";
    self setplayerdata("cp", "alienSession", "escapedRank2", 0);
  }

  give_munition_to_slot(var_1dd5348e4e741473, slot);
  var_a64c51188d789c25 = "cp_munition_1_timer";

  switch (slot) {
    case 0:
      var_a64c51188d789c25 = "cp_munition_1_timer";
      break;
    case 1:
      var_a64c51188d789c25 = "cp_munition_2_timer";
      break;
    case 2:
      var_a64c51188d789c25 = "cp_munition_3_timer";
      break;
    case 3:
      var_a64c51188d789c25 = "cp_munition_4_timer";
      break;
  }

  self setclientomnvar(var_a64c51188d789c25, 0);
  check_for_empty_munitions();
  assign_highest_full_slot_to_active();
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint) {
    thread scripts\cp\loadout::function_7da7bd24b280d295();
  }

  self notify("munition_removed");
}

function check_for_empty_munitions() {
  munition_slots_full = 0;
  total_slots = self getplayerdata("cp", "inventorySlots", "totalSlots");

  for(i = 0; i < total_slots; i++) {
    if(isDefined(self.munition_slots) && isDefined(self.munition_slots[i])) {
      if(!scripts\cp\loot_system::is_empty_or_none(i)) {
        munition_slots_full += 1;
      }
    }
  }

  self.munition_slots_full = munition_slots_full;
  self setclientomnvar("cp_munition_slots_full", munition_slots_full);
}

function function_346cde477a4fef90(var_5a8f1accec64dc4a) {
  i = 0;

  foreach(slot in self.munition_slots) {
    if(slot.ref == var_5a8f1accec64dc4a) {
      return i;
    }

    i++;
  }

  return undefined;
}

function assign_highest_full_slot_to_active() {
  empty_slots = 0;

  for(i = self.munition_slots.size - 1; i > -1; i--) {
    if(!scripts\cp\loot_system::is_empty_or_none(i)) {
      self.dpad_selection_index = i;
      break;
    }

    empty_slots += 1;
  }

  if(empty_slots == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function assign_lowest_full_slot_to_active() {
  empty_slots = 0;

  for(i = 0; i < self.munition_slots.size; i++) {
    if(!scripts\cp\loot_system::is_empty_or_none(i)) {
      self.dpad_selection_index = i;
      break;
    }

    empty_slots += 1;
  }

  if(empty_slots == self.munition_slots.size) {
    self.dpad_selection_index = 0;
  }

  update_lua_inventory_slot(self.dpad_selection_index);
}

function has_munition(var_5940a3ac5c0c822c) {
  foreach(slot in self.munition_slots) {
    if(slot.ref == var_5940a3ac5c0c822c) {
      return true;
    }
  }

  return false;
}

function give_munition_to_slot(munition, slot, source, show_nag) {
  if(function_240f7f4e57340e8f()) {
    assertex(slot == 0, "Slot must be " + 0);
  }

  total_slots = update_total_slots(slot);
  player = self;

  if(!isDefined(slot)) {
    slot = total_slots - 1;
  }

  if(!isDefined(show_nag)) {
    show_nag = 1;
  }

  if(!isDefined(self.munition_slots) || !isDefined(self.munition_slots[slot])) {
    self.munition_slots[slot] = spawnStruct();
  }

  if(function_240f7f4e57340e8f()) {
    self.munition_slots[slot].ref = function_77cbcaf60caaf605(munition);
  } else {
    self.munition_slots[slot].ref = munition;
  }

  self.munition_slots[slot].cooldown = level.munitions_table_data[self.munition_slots[slot].ref].cooldown;
  self.munition_slots[slot].can_use = 1;
  self.munition_slots[slot].cooldown_progress = 1;

  if(isDefined(source)) {
    self.munition_slots[slot].source = source;

    if(isDefined(self.munition_slots[slot].source) && munition_source_getridof(self.munition_slots[slot].source)) {
      if(slot == 0) {
        self setplayerdata("cp", "alienSession", "escapedRank0", 1);
      } else if(slot == 1) {
        self setplayerdata("cp", "alienSession", "escapedRank1", 1);
      } else if(slot == 2) {
        self setplayerdata("cp", "alienSession", "escapedRank2", 1);
      }
    }
  }

  if(munition == "none") {
    if(isDefined(self.munition_slots[slot].source)) {
      self.munition_slots[slot].source = undefined;
    }
  }

  total_slots = self getplayerdata("cp", "inventorySlots", "totalSlots");
  omnvar = undefined;
  splashref = player check_for_gl_proj_override(munition);

  if(!istrue(self.munition_splash_supress)) {
    splashref = "cp_" + splashref;
  }

  player thread scripts\cp\cp_hud_message::showsplash(splashref, undefined, self);

  switch (slot) {
    case 0:
      omnvar = "cp_munition_slot_1";
      player thread cooldown_munition("munition_1_used", "cp_munition_1_timer", player, player.munition_slots[0].ref, player.munition_slots[0].cooldown, 0, 1);
      break;
    case 1:
      omnvar = "cp_munition_slot_2";
      player thread cooldown_munition("munition_2_used", "cp_munition_2_timer", player, player.munition_slots[1].ref, player.munition_slots[1].cooldown, 1, 1);
      break;
    case 2:
      omnvar = "cp_munition_slot_3";
      player thread cooldown_munition("munition_3_used", "cp_munition_3_timer", player, player.munition_slots[2].ref, player.munition_slots[2].cooldown, 2, 1);
      break;
    case 3:
      omnvar = "cp_munition_slot_4";
      player thread cooldown_munition("munition_4_used", "cp_munition_4_timer", player, player.munition_slots[3].ref, player.munition_slots[3].cooldown, 3, 1);
      break;
  }

  index = level.munitions_table_data[player.munition_slots[slot].ref].index;

  if(isDefined(omnvar) && isDefined(index)) {
    player setclientomnvar(omnvar, index);
  }

  if(istrue(show_nag) && getdvarint(@ "hash_210d16e93f2436f5", 0) == 0) {
    player thread nag_munitions();
  }

  if(isDefined(player.munition_slots_full) && player.munition_slots_full == 0) {
    player check_for_empty_munitions();
  }

  if(munition == "nvg") {
    player function_b1e64d364cf55b73(player has_munition("nvg"));
  }

  if(munition != "empty1") {
    level notify("munition_pickup", munition);
  }
}

function function_d3e4275ca1bc1207() {
  self notify("nag_munitions");
}

function nag_munitions() {
  self notify("nag_munitions");
  self endon("nag_munitions");
  self endon("disconnect");
  wait 12;

  if(getdvarint(@ "hash_6978b3f150582c40", 1)) {
    self notify("nag_munitions");
  }

  count = 0;

  while(count < 2) {
    if(istrue(self.var_7269deeba689cd65)) {
      self clearhudtutorialmessage();
      wait 5;
      return;
    }

    if(!scripts\cp\laststand::player_in_laststand(self)) {
      if(!function_9e1ff2e695fd901d()) {
        scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/USE_MUNITION_NAG", 2);
      } else {
        return;
      }

      count++;
      wait 30;
      continue;
    }

    count++;
    wait 30;
  }
}

function function_9e1ff2e695fd901d() {
  for(i = 0; i < self.munition_slots.size; i++) {
    if(!scripts\cp\loot_system::is_empty_or_none(i)) {
      return false;
    }
  }

  return true;
}

function function_50be8abfe68ddbfc() {
  for(i = 0; i < self.munition_slots.size; i++) {
    if(scripts\cp\loot_system::is_empty_or_none(i)) {
      return true;
    }
  }

  return false;
}

function update_total_slots(slot) {
  if(!isDefined(slot)) {
    slot = 5;
  }

  total_slots = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(slot >= total_slots && total_slots < level.var_3a7f3e66e1a1d8f5) {
    total_slots += 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", total_slots);
  return total_slots;
}

function check_for_gl_proj_override(munition) {
  player = self;

  if(munition == "grenade_launcher" && isDefined(player.gl_proj_override)) {
    return (player.gl_proj_override + "_proj");
  }

  return munition;
}

function remove_munitions_in_radius(org, radius, throttle_override) {
  radius_sq = radius * radius;
  throttle = 20;

  if(isDefined(throttle_override)) {
    throttle = throttle_override;
  }

  var_7507f409fee2b657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(name in var_7507f409fee2b657) {
    var_792740c4c87cf9fa = getentitylessscriptablearray(undefined, undefined, org, radius, name);
    count = 0;

    foreach(br_loot in var_792740c4c87cf9fa) {
      br_loot setscriptablepartstate(name, "hidden");
      count++;

      if(count % throttle) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function remove_munitions_globally(var_1d88cbbb14926330) {
  var_7507f409fee2b657 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  if(isDefined(var_1d88cbbb14926330)) {
    var_7507f409fee2b657 = var_1d88cbbb14926330;
  }

  foreach(name in var_7507f409fee2b657) {
    loot_array = getentitylessscriptablearray(undefined, undefined, undefined, undefined, name);

    foreach(br_loot in loot_array) {
      br_loot setscriptablepartstate(name, "hidden");
    }

    wait 0.1;
  }
}

function givegrenadelauncher() {
  self.last_weapon = self getcurrentweapon();

  if(istrue(self.has_gl)) {
    gun_list = self.equippedweapons;

    foreach(gun in gun_list) {
      if(gun.basename == "iw9_la_mike32_mp") {
        clip_size = weaponclipsize(gun);
        self setweaponammoclip(gun, clip_size);
      }
    }
  } else {
    gun_name = "iw9_la_mike32_mp";
    gun = scripts\cp_mp\weapon::buildweapon(gun_name);
    self giveweapon(gun);
    clip_size = weaponclipsize(gun);
    self setweaponammoclip(gun, clip_size);
    self setweaponammostock(gun, 0);
    self switchtoweapon(gun);
    self.has_gl = 1;
    val::set("give_grenade_launcher", "weapon_pickup", 0);
    disable_backpack_inventory(1);
    self.var_74a98fc784d043a0 = self.disable_munitions;
    self.disable_munitions = 1;
    thread remove_at_ammo_count(gun.basename, 0);
  }

  self notify("munitions_used", "grenade_launcher");
}

function function_dd25d8d11acb070() {
  wait 1;
  self waittill("weapon_switch_started");
  self.has_gl = undefined;
}

function remove_at_ammo_count(weapon_name, ammo_count) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_removed");
  childthread function_dd25d8d11acb070();
  weapon = undefined;
  list = self getweaponslist("primary");

  foreach(weap in list) {
    if(weap.basename == weapon_name) {
      weapon = weap;
      break;
    }
  }

  if(isDefined(weapon)) {
    while(true) {
      cur_ammo = self getammocount(weapon);

      if(cur_ammo <= ammo_count) {
        break;
      }

      if(!isDefined(self.has_gl)) {
        break;
      }

      waitframe();
    }

    val::reset_all("give_grenade_launcher");
    disable_backpack_inventory(0);

    if(isDefined(self.var_74a98fc784d043a0)) {
      self.disable_munitions = self.var_74a98fc784d043a0;
      self.var_74a98fc784d043a0 = undefined;
    } else {
      self.disable_munitions = 0;
    }

    self takeweapon(weapon);
    weapontoswitch = getweapontoswitchbackto();
    success = thread scripts\cp\cp_weapons::switchtoweaponreliable(weapontoswitch, 0);
    self.has_gl = undefined;
    self notify("weapon_removed", "grenade_launcher");
  }
}

function giveitembasedoncraftingstruct(crafteditem) {
  deployable = 1;
  self.var_7269deeba689cd65 = 1;

  switch (crafteditem) {
    case #"hash_a693a5088100be1f":
      self iprintln(" RESPAWN SYSTEM IS DEPRECATED. ");
      break;
    case #"hash_b55ba82d2cec3b73":
    case #"hash_349713b5ad494dda":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      if(scripts\cp\weapon::player_has_minigun(self)) {
        scripts\cp\weapon::drop_minigun(self);
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      success = scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_b83560470dd3f49b":
      success = giveammocrate();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_d95dd5d6012a0de1":
      success = function_d4d986dbfa3f3ab1();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_413c38e72fe8b5bf":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      if(isDefined(level.ac130_activate_function)) {
        self notify("attempt_use_gunship");
        success = self[[level.ac130_activate_function]]();

        if(!istrue(success)) {
          return false;
        }
      }

      scripts\cp_mp\killstreaks\gunship::tryusegunship();
      break;
    case #"hash_8c766d6477287bb6":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      success = scripts\cp_mp\killstreaks\airstrike::tryuseairstrike("precision_airstrike");

      if(!success) {
        return false;
      }

      break;
    case #"hash_4ad475e6e15635bd":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);
      break;
    case #"hash_e65b15f734e5ab84":
      scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1, 1);
      break;
    case #"hash_eca3b9673d38fd59":
      success = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_4c07a1218b26a890":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      result = scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredator();

      if(istrue(result)) {
        break;
      } else {
        return false;
      }
    case #"hash_6414903dd56a87f8":
      if(scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      scripts\cp_mp\killstreaks\helper_drone::tryusehelperdrone("radar_drone_recon");
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "activate_drone");
      break;
    case #"hash_c9ce32066612c729":
      deployable = 0;
      self notify("one_watcher_for_removing_deployables");
      giveriotshield();
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "killstreak_used");
      break;
    case #"hash_65872b6ad36f2e8a":
      deployable = 0;
      self notify("one_watcher_for_removing_deployables");
      givegrenadelauncher();
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "killstreak_used");
      break;
    case #"hash_25789111b74943b4":
      success = givearmorcrate();

      if(!istrue(success)) {
        return false;
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "killstreak_used");
      break;
    case #"hash_52d9b7ed584bec3e":
      if(!istrue(self.bgivensentry)) {
        scripts\cp_mp\killstreaks\manual_turret::tryusemanualturret("manual_turret");
      }

      break;
    case #"hash_fa4536bde6f7ad9":
    case #"hash_74e2f521aa352a6a":
      if(!istrue(self.bgivensentry)) {
        success = scripts\cp_mp\killstreaks\sentry_gun::tryusesentryturret("sentry_gun");

        if(!success) {
          return false;
        }
      }

      break;
    case #"hash_b571a6187bf67f9e":
      success = scripts\killstreaks\missile_turret::function_463f566c8cfddea5("missile_turret");

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_634b246c3da5c56f":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      if(self.skipuavupdate == 0) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      success = scripts\cp_mp\killstreaks\uav::tryuseuav("uav");

      if(!istrue(success)) {
        return false;
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "activate_uav");
      break;
    case #"hash_6637a8e7426ba85e":
      success = give_deployable_cover();

      if(!istrue(success)) {
        return false;
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "killstreak_used");
      break;
    case #"hash_4d35eb58f9d545f0":
      success = scripts\cp_mp\killstreaks\cluster_spike::function_43fcf054875c96c5();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_b161e185f1b8e117":
      scripts\cp_mp\utility\killstreak_utility::starttabletscreen("auto_drone", 0.75, 0);
      success = scripts\cp_mp\killstreaks\auto_drone::function_f5488ebdae28a1d8();

      if(!istrue(success)) {
        thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(1, 1);
        return false;
      }

      break;
    case #"hash_2f437058d5eef2ac":
    case #"hash_b4ac3581c343a029":
      if(istrue(level.no_aerial_munitions) || scripts\cp\cp_objectives::is_objective_active("collect_nuclear_core") || scripts\cp\cp_objectives::is_objective_active("exfil_plane")) {
        self iprintln("<dev string:x5b>");

        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      success = scripts\cp_mp\killstreaks\toma_strike::tryusetomastrike();

      if(!success) {
        return false;
      }

      break;
    case #"hash_4059066c2be514e6":
      thread scripts\cp\equipment\nvg::runnvg();
      break;
    case #"hash_58136b573f30f5be":
      self giveandfireoffhand("trophy_cp");
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "killstreak_used");
      break;
    case #"hash_1fc9d3e5733715bd":
      scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct("white_phosphorus");
      break;
    case #"hash_bf2f9adbd2b41d5":
      scripts\cp_mp\utility\killstreak_utility::starttabletscreen("hover_jet", 0.75, 0);
      success = scripts\cp_mp\killstreaks\hover_jet::tryusehoverjet();

      if(!istrue(success)) {
        thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(1, 1);
        return false;
      }

      self notify("munitions_used", "hover_jet");
      break;
    case #"hash_691f39dddd9116b8":
      success = scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupport("chopper_support");

      if(!istrue(success)) {
        return false;
      }

      self notify("munitions_used", "chopper_support");
      break;
    case #"hash_9e36e3bd3a9dd00d":
      success = scripts\cp_mp\killstreaks\assault_drone::tryuseassaultdrone();

      if(!istrue(success)) {
        return false;
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "activate_drone");
      break;
    case #"hash_e3f28d3556bd7625":
      if(istrue(level.no_aerial_munitions)) {
        scripts\cp\utility::hint_prompt("munition_unavailable", 1, 2);
        return false;
      }

      success = scripts\cp_mp\killstreaks\recon_drone::tryuserecondrone();

      if(!istrue(success)) {
        return false;
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "activate_drone");
      break;
    case #"hash_19dd9a3a4147e09e":
      success = scripts\killstreaks\lrad::function_5dae574697e78d96();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_7a687f6a4d685110":
      if(issharedfuncdefined(crafteditem, "tryUseKillstreak")) {
        success = self[[getsharedfunc(crafteditem, "tryUseKillstreak")]]();

        if(!isDefined(success) || !success) {
          return false;
        }
      }

      break;
    case #"hash_a1031216158c7882":
      success = scripts\killstreaks\loitering_munition::function_10fd15ea1cbf20d7();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_472d8b6c2f51a9c8":
      success = scripts\killstreaks\ims::tryuseims();

      if(!istrue(success)) {
        return false;
      }

      break;
    case #"hash_6362d6aae3e5a62e":
      if(isDefined(level.droneswarmactive) && level.droneswarmactive) {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
        return false;
      } else {
        if(issharedfuncdefined("drone_swarm", "tryUseDroneSwarm ")) {
          success = self[[getsharedfunc("drone_swarm", "tryUseDroneSwarm")]]();
        }

        if(!isDefined(success) || !istrue(success)) {
          return false;
        }
      }

      break;
    case #"hash_56979e0566996b2e":
      success = scripts\cp_mp\killstreaks\airdrop::tryuseairdropmarker();

      if(!istrue(success)) {
        return false;
      }

      self notify("munitions_used", "airdrop");
      break;
  }

  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint) {
    thread scripts\cp\loadout::function_7da7bd24b280d295();
  }

  if(deployable) {
    thread watcherforremovingdeployable();
  }

  function_ffd0ae3abd92c511(crafteditem);
  return true;
}

function watcherforremovingdeployable() {
  self notify("one_watcher_for_removing_deployables");
  self endon("one_watcher_for_removing_deployables");

  while(true) {
    self waittill("remove_any_active_items");

    if(isDefined(self.last_weapon)) {
      weapontoswitch = getweapontoswitchbackto();
      self switchtoweapon(weapontoswitch);
      self.last_weapon = undefined;
      clearlowermessage("crate_prompt");
    }
  }
}

function givearmorcrate() {
  return give_deployable_crate("iw8_armor_marker_cp");
}

function giveammocrate() {
  return give_deployable_crate("iw8_ammo_marker_cp");
}

function function_d4d986dbfa3f3ab1() {
  return give_deployable_crate("iw8_ammo_marker_cp");
}

function give_deployable_crate(crate_type) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  objweapon = makeweapon(crate_type);

  if(!istrue(scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(objweapon))) {
    self.super_activated = 0;
    scripts\cp\super::function_c5ea07dac9d83685();
    clientnum = self getentitynumber();
    setomnvar("ui_class_power_reloading", clientnum);
    delay_amount = 0.2;
    thread function_8f741e1e8e870100(delay_amount, 975);
    scripts\cp\super::superusefinished();
    scripts\cp\super::setsuperisinuse(0);
    return undefined;
  }

  msg = waittill_any_return_6("offhand_fired", "weapon_fired", "offhand_end", "weapon_change", "weapon_gesture_failed", "offhand_pullback");
  self.super_activated = 0;
  scripts\cp\super::function_c5ea07dac9d83685();
  clientnum = self getentitynumber();
  setomnvar("ui_class_power_reloading", clientnum);

  if(msg == "offhand_pullback" || msg == "weapon_change" || msg == "weapon_gesture_failed") {
    delay_amount = 0.2;
    thread function_8f741e1e8e870100(delay_amount, 975);
    scripts\cp\super::superusefinished();
    scripts\cp\super::setsuperisinuse(0);
    return undefined;
  }

  scripts\cp\super::setsuperisinuse(0);
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "equipment_deployed");
  return 1;
}

function function_8f741e1e8e870100(delay_amount, increase_amount) {
  wait delay_amount;
  scripts\cp\super::increase_super_progress(increase_amount);
}

function giveriotshield() {
  self.riot_shield_damage = 1000;
  self.last_weapon = self getcurrentweapon();

  if(!istrue(self.has_riot_shield)) {
    gun = "iw9_me_riotshield_mp";
    shield = makeweapon(gun);
    _giveweapon(shield);
    scripts\cp\cp_weapons::switchtoweaponreliable(shield);
    self.has_riot_shield = 1;
    thread remove_at_shield_death(gun, 0);
  }

  self notify("munitions_used", "riot_shield");
}

function remove_at_shield_death(weapon_name, health_value) {
  level endon("game_ended");
  self endon("disconnect");
  weapon = undefined;
  list = self getweaponslist("primary");

  foreach(weap in list) {
    if(weap.basename == weapon_name) {
      weapon = weap;
      break;
    }
  }

  if(isDefined(weapon)) {
    while(self.riot_shield_damage > health_value) {
      waitframe();
    }

    self.riot_shield_broken = 1;

    if(isDefined(self.riotshieldmodel)) {
      riotshield_detach(1);
    } else if(isDefined(self.riotshieldmodelstowed)) {
      riotshield_detach(0);
    }

    wait 1;
    self takeweapon(weapon);
    self switchtoweapon(self.last_weapon);
    self.has_riot_shield = undefined;
    self.riot_shield_broken = undefined;
  }
}

function givemunitionfromluinotify() {
  self endon("disconnect");
  level endon("game_ended");
  self.dpad_selection_index = 0;
  max_slots = level.var_3a7f3e66e1a1d8f5;
  total_slots = level.var_3a7f3e66e1a1d8f5;

  if(istrue(level.unlimitedmunitions)) {
    total_slots = 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", total_slots);

  for(;;) {
    self waittill("luinotifyserver", channel, val);

    if(channel == "radial_menu_munition") {
      function_d3e4275ca1bc1207();
      reason = 0;

      reason = getdvarint(@ "hash_5c04fc6164658276", 0);

      if(!player_can_use_munitions(reason)) {
        continue;
      }

      if(val >= 0 && val <= 2) {
        munition = self.munition_slots[val];

        if(isDefined(munition) && munition.ref != "none" && munition.ref != "empty1" && munition.ref != "empty2" && munition.ref != "empty3") {
          if(istrue(can_use_munition(val))) {
            thread remove_munition_on_use(munition.ref, val);
            success = scripts\cp\munitions::giveitembasedoncraftingstruct(munition.ref);

            if(success) {
              if(is_instant_use_munition(munition.ref)) {
                self notify("munitions_used", munition.ref);
              }

              scripts\cp\cp_analytics::logevent_munitionused(self, munition.ref);
              continue;
            }

            self notify("remove_munition_on_use");
          }
        }
      }
    }
  }
}

function give_deployable_cover() {
  if(self isthrowinggrenade()) {
    return;
  }

  self.prev_weapon_taccover = self getcurrentprimaryweapon();
  gun = "tac_cover_mp";
  self giveweapon(gun);
  self switchtoweapon(gun);
  self notifyonplayercommand("equip_deploy_end", "+weapnext");
  self notifyonplayercommand("equip_deploy_end", "+weapprev");
  self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
    self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
  }

  val::set("deployable_cover", "melee", 0);
  success = fire_deployable_cover();

  if(istrue(success)) {
    return 1;
  } else {
    val::reset_all("deployable_cover");
  }

  return undefined;
}

function fire_deployable_cover() {
  self endon("equip_deploy_end");
  self endon("last_stand");
  self endon("death_or_disconnect");
  grenade = scripts\cp\weapon::waittill_grenade_fire();

  if(isDefined(grenade.weapon_name) && grenade.weapon_name == "tac_cover_mp") {
    success = scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired_super();

    if(istrue(success)) {
      thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(grenade);
      val::reset_all("deployable_cover");

      foreach(player in level.players) {
        player thread scripts\cp\cp_hud_message::showsplash("cp_used_deployable_cover", undefined, self);
      }

      self notify("munitions_used", "deployable_cover");
      return 1;
    }
  }

  self notify("deploy_cover_failed");
  return undefined;
}

function function_9ee17a338bde061b(ref) {
  switch (ref) {
    case #"hash_74e2f521aa352a6a":
      return "sentry_gun";
    case #"hash_eca3b9673d38fd59":
      return "cruise_predator";
    default:
      return ref;
  }
}

function function_77cbcaf60caaf605(ref) {
  switch (ref) {
    case #"hash_4d5aa76e8707f47b":
      return "sentry";
    case #"hash_28d0236400e33fd0":
      return "cruise_missile";
    default:
      return ref;
  }
}

function function_8c2b940cf1550e4d(damage, attacker, inflictor, victimteam, sourceorigin, meansofdeath, weaponname) {
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  angles = (0, 0, 0);
  normal = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  idflags = undefined;

  if(isagent(self)) {
    self dodamage(damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname);
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    self dodamage(damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname);
    return;
  }

  weapon = makeweaponfromstring(weaponname);
  self notify("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, sourceorigin, angles, normal, inflictor);
}

function function_ffd0ae3abd92c511(crafteditem) {
  nummunitions = self getprogressiondata("spData", "numMunitions");

  if(nummunitions >= level.var_fd57bc164397d837.size) {
    self function_6a369480dbaf1090("jup_sp_boundandmagged", nummunitions);
    return;
  }

  for(i = 0; i < level.var_fd57bc164397d837.size; i++) {
    if(crafteditem == self getprogressiondata("spData", "usedMunitions", i)) {
      return;
    }
  }

  if(array_contains(level.var_fd57bc164397d837, crafteditem)) {
    self setprogressiondata("spData", "usedMunitions", nummunitions, crafteditem);
    nummunitions++;
    self setprogressiondata("spData", "numMunitions", nummunitions);

    if(nummunitions <= 5) {
      self function_6a369480dbaf1090("jup_sp_partyfavors", nummunitions);
    }

    self function_6a369480dbaf1090("jup_sp_boundandmagged", nummunitions);
  }
}