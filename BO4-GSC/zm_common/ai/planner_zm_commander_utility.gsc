/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ai\planner_zm_commander_utility.gsc
*********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_squad;
#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\ai\systems\planner_blackboard;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace planner_zm_commander_utility;

autoexec __init__system__() {
  system::register(#"planner_zm_commander_utility", &namespace_526571f4::__init__, undefined, undefined);
}

#namespace namespace_526571f4;

private __init__() {
  plannercommanderutility::registerutilityapi(#"commanderscoreage", &function_cb29a211);
  plannercommanderutility::registerdaemonapi(#"daemonzmaltars", &function_ea95685);
  plannercommanderutility::registerdaemonapi(#"daemonzmblockers", &function_80c4721f);
  plannercommanderutility::registerdaemonapi(#"daemonzmchests", &function_73588006);
  plannercommanderutility::registerdaemonapi(#"daemonzmpowerups", &function_ccdf2c6f);
  plannercommanderutility::registerdaemonapi(#"daemonzmswitches", &function_48fcded4);
  plannercommanderutility::registerdaemonapi(#"daemonzmwallbuys", &function_873b1369);
}

private function_ea95685(commander) {
  altars = [];

  if(isarray(level.var_76a7ad28)) {
    foreach(altar in level.var_76a7ad28) {
      if(!isDefined(altar)) {
        continue;
      }

      var_bc510a14 = array();
      var_bc510a14[#"origin"] = altar.origin;
      var_bc510a14[#"type"] = altar.script_unitrigger_type;

      if(!isDefined(var_bc510a14[#"__unsafe__"])) {
        var_bc510a14[#"__unsafe__"] = array();
      }

      var_bc510a14[#"__unsafe__"][#"altar"] = altar;
      altars[altars.size] = var_bc510a14;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_altars", altars);
}

private function_80c4721f(commander) {
  blockers = [];
  var_521da80d = array("zombie_door", "zombie_airlock_buy", "zombie_debris");

  foreach(var_b849a5e7 in var_521da80d) {
    doorblockers = getEntArray(var_b849a5e7, "targetname");

    foreach(doorblocker in doorblockers) {
      var_6f43058 = array();

      if(isDefined(doorblocker.purchaser)) {
        continue;
      }

      if(doorblocker._door_open === 1 || doorblocker.has_been_opened === 1) {
        continue;
      }

      if(isDefined(doorblocker.var_1661d836) && doorblocker.var_1661d836) {
        continue;
      }

      if(isDefined(doorblocker.var_c947f134) && doorblocker.var_c947f134) {
        continue;
      }

      if(isDefined(doorblocker.script_noteworthy)) {
        switch (doorblocker.script_noteworthy) {
          case #"electric_door":
          case #"local_electric_door":
          case #"electric_buyable_door":
            continue;
        }
      }

      var_6f43058[#"cost"] = doorblocker.zombie_cost;
      var_6f43058[#"origin"] = doorblocker.origin;

      if(!isDefined(var_6f43058[#"__unsafe__"])) {
        var_6f43058[#"__unsafe__"] = array();
      }

      var_6f43058[#"__unsafe__"][#"blocker"] = doorblocker;
      blockers[blockers.size] = var_6f43058;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_blockers", blockers);
}

private function_73588006(commander) {
  chests = [];

  if(isarray(level.chests)) {
    foreach(chest in level.chests) {
      if(!isDefined(chest)) {
        continue;
      }

      if(isDefined(chest.hidden) && chest.hidden) {
        continue;
      }

      var_559e6014 = array();
      var_559e6014[#"origin"] = chest.unitrigger_stub.origin;
      var_559e6014[#"cost"] = chest.zombie_cost;
      var_559e6014[#"type"] = chest.unitrigger_stub.script_unitrigger_type;

      if(!isDefined(var_559e6014[#"__unsafe__"])) {
        var_559e6014[#"__unsafe__"] = array();
      }

      var_559e6014[#"__unsafe__"][#"chest"] = chest;
      chests[chests.size] = var_559e6014;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_chests", chests);
}

private function_ccdf2c6f(commander) {
  powerups = [];

  if(isarray(level.active_powerups)) {
    foreach(powerup in level.active_powerups) {
      if(!isDefined(powerup)) {
        continue;
      }

      if(powerup.powerup_name == #"nuke") {
        continue;
      }

      var_131b0d64 = array();
      var_131b0d64[#"type"] = powerup.powerup_name;

      if(!isDefined(var_131b0d64[#"__unsafe__"])) {
        var_131b0d64[#"__unsafe__"] = array();
      }

      var_131b0d64[#"__unsafe__"][#"powerup"] = powerup;
      powerups[powerups.size] = var_131b0d64;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_powerups", powerups);
}

private function_48fcded4(commander) {
  switches = [];
  switchents = getEntArray("use_elec_switch", "targetname");

  if(isarray(switchents)) {
    foreach(switchent in switchents) {
      if(!isDefined(switchent)) {
        continue;
      }

      var_b353dc21 = array();
      var_b353dc21[#"origin"] = switchent.origin;
      var_b353dc21[#"cost"] = switchent.zombie_cost;

      if(!isDefined(var_b353dc21[#"__unsafe__"])) {
        var_b353dc21[#"__unsafe__"] = array();
      }

      var_b353dc21[#"__unsafe__"][#"switch"] = switchent;
      switches[switches.size] = var_b353dc21;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_switches", switches);
}

private function_873b1369(commander) {
  wallbuys = [];

  if(isarray(level._spawned_wallbuys)) {
    foreach(wallbuy in level._spawned_wallbuys) {
      if(!isDefined(wallbuy.trigger_stub)) {
        continue;
      }

      if(wallbuy.weapon.type === "melee") {
        continue;
      }

      var_75f73822 = array();
      var_75f73822[#"weapon"] = wallbuy.weapon;
      var_75f73822[#"origin"] = wallbuy.trigger_stub.origin;
      var_75f73822[#"height"] = wallbuy.trigger_stub.script_height;
      var_75f73822[#"length"] = wallbuy.trigger_stub.script_length;
      var_75f73822[#"width"] = wallbuy.trigger_stub.script_width;
      var_75f73822[#"type"] = wallbuy.trigger_stub.script_unitrigger_type;
      zombieweapon = level.zombie_weapons[wallbuy.weapon];
      var_75f73822[#"ammo_cost"] = zombieweapon.ammo_cost;
      var_75f73822[#"cost"] = zombieweapon.cost;
      var_75f73822[#"upgrade_weapon"] = zombieweapon.upgrade;

      if(!isDefined(var_75f73822[#"__unsafe__"])) {
        var_75f73822[#"__unsafe__"] = array();
      }

      var_75f73822[#"__unsafe__"][#"wallbuy"] = wallbuy;
      wallbuys[wallbuys.size] = var_75f73822;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"zm_wallbuys", wallbuys);
}

private function_cb29a211(commander, squad, constants) {
  assert(isDefined(constants[#"maxage"]), "<dev string:x38>" + "<dev string:x46>" + "<dev string:x73>");

  if(gettime() > squad.createtime + constants[#"maxage"]) {
    return false;
  }

  return true;
}