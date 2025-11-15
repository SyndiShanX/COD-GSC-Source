/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_loot_homunculus.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\wz_common\wz_ai_utils;

#namespace wz_loot_homunculus;

autoexec __init__system__() {
  system::register(#"wz_loot_homunculus", &__init__, undefined, undefined);
}

__init__() {
  level thread function_eaeb557();
}

function_eaeb557() {
  level endon(#"game_ended");
  item_world::function_1b11e73c();
  zombie_apoc_homunculus = getdynent("zombie_apoc_homunculus");
  a_homunculi = array::randomize(getdynentarray("spring_event_homunculus"));
  b_enable = isDefined(getgametypesetting(#"hash_53b5887dea69a320")) && getgametypesetting(#"hash_53b5887dea69a320");

  if(isDefined(zombie_apoc_homunculus)) {
    setdynentstate(zombie_apoc_homunculus, 3);
  }

  foreach(e_homunculus in a_homunculi) {
    setdynentstate(e_homunculus, 3);
  }

  item_world::function_4de3ca98();

  if(isDefined(zombie_apoc_homunculus)) {
    if(isDefined(level.var_fdbdcdfd) && level.var_fdbdcdfd) {
      setdynentstate(zombie_apoc_homunculus, 1);
    } else {
      setdynentstate(zombie_apoc_homunculus, 3);
    }
  }

  n_active = 0;

  foreach(e_homunculus in a_homunculi) {
    if(b_enable && n_active < 5 && !(isDefined(e_homunculus.b_disabled) && e_homunculus.b_disabled)) {
      setdynentstate(e_homunculus, 1);
      n_active++;

      if(isDefined(e_homunculus.target)) {
        var_d4265274 = function_c79d31c4(e_homunculus.target);

        foreach(var_2ba94f3f in var_d4265274) {
          if(var_2ba94f3f !== self) {
            var_2ba94f3f.b_disabled = 1;
          }
        }
      }

      continue;
    }

    setdynentstate(e_homunculus, 3);
  }
}

private event_handler[event_cf200f34] function_209450ae(eventstruct) {
  dynent = eventstruct.ent;

  if(dynent.targetname !== "spring_event_homunculus" && dynent.targetname !== "zombie_apoc_homunculus") {
    return;
  }

  dynent.health = 10000;

  if(!level flagsys::get(#"hash_507a4486c4a79f1d") || isDefined(dynent.var_1a909065) && dynent.var_1a909065) {
    return;
  }

  dynent.var_1a909065 = 1;
  var_7580ce3e = spawnStruct();
  var_7580ce3e.origin = dynent.origin + (0, 0, 32);
  setdynentstate(dynent, 2);
  wait 0.7;

  if(isDefined(dynent)) {
    setdynentstate(dynent, 3);
  }

  if(dynent.targetname == "spring_event_homunculus") {
    a_items = var_7580ce3e namespace_65181344::function_fd87c780(#"spring_event_homunculus_list", 5);
  } else {
    a_items = var_7580ce3e namespace_65181344::function_fd87c780(#"zombie_apoc_event_homunculus_list", 7);
  }

  foreach(item in a_items) {
    if(isDefined(item)) {
      item.origin = var_7580ce3e.origin;
    }
  }

  foreach(item in a_items) {
    if(isDefined(item)) {
      item thread function_7a1e21a9(var_7580ce3e.origin);
    }

    waitframe(randomintrange(1, 3));
  }

  var_7580ce3e struct::delete();
}

function_7a1e21a9(v_loc) {
  self endon(#"death");
  self.origin = v_loc;
  self.angles += (0, randomint(360), 0);
  n_x_offset = randomintrange(8, 32);
  n_y_offset = randomintrange(8, 32);

  if(math::cointoss(50)) {
    n_x_offset *= -1;
  }

  if(math::cointoss(50)) {
    n_y_offset *= -1;
  }

  v_loc += (n_x_offset, n_y_offset, 0);
  trace = bulletTrace(v_loc + (0, 0, 40), v_loc + (0, 0, -150), 0, undefined);

  if(trace[#"fraction"] < 1) {
    v_loc = trace[#"position"];
  }

  time = self wz_ai_utils::fake_physicslaunch(v_loc, 100);
  wait time;

  if(isDefined(self)) {
    self.origin = v_loc;
  }
}