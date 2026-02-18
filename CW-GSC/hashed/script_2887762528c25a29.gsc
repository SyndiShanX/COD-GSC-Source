/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2887762528c25a29.gsc
***********************************************/

#using script_17dcb1172e441bf6;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_9529b92d;

function init() {}

function main() {
  level.doa.var_6733605b = [];
}

function function_e073d92f() {
  self notify("3b218896f68a5246");
  self endon("3b218896f68a5246");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_6733605b, self);
    namespace_1e25ad94::debugmsg("Deleting Pressure Plate trap permenently at:" + self.origin);
  }

  util::wait_network_frame();

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
    self.script_model = undefined;
  }

  if(isDefined(self.var_1de20e4f)) {
    self.var_1de20e4f delete();
    self.var_1de20e4f = undefined;
  }

  if(isDefined(self.var_b60f5693)) {
    self.var_b60f5693 delete();
    self.var_b60f5693 = undefined;
  }
}

function function_a2e3342e(trap, var_7c56394 = 0) {
  assert(isDefined(trap.target), "<dev string:x38>");
  trap.script_model = namespace_ec06fe4a::spawnmodel(trap.origin, "zombietron_pressure_plate", trap.angles);

  if(isDefined(trap.script_model)) {
    trap.script_model.targetname = "hazard";
    trap.script_model.var_fd5301f9 = "pressureplate";
  }

  trap.var_1de20e4f = namespace_ec06fe4a::spawnmodel(trap.origin, "zombietron_pressure_plate_holder", trap.angles);
  trap.var_7c56394 = var_7c56394;
  trap.var_84a0207b = getEntArray(trap.target, "targetname");

  if(trap.var_84a0207b.size == 0) {
    trap.var_84a0207b = struct::get_array(trap.target, "targetname");
  }

  assert(trap.var_84a0207b.size > 0, "<dev string:x5e>");
  array::notify_all(trap.var_84a0207b, "plate_assigned");
  trap thread function_3864f6a5();
  return trap;
}

function function_b3e13787(trap, page = 0) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  if(page) {
    if(!isDefined(level.doa.var_6733605b)) {
      level.doa.var_6733605b = [];
    } else if(!isarray(level.doa.var_6733605b)) {
      level.doa.var_6733605b = array(level.doa.var_6733605b);
    }

    level.doa.var_6733605b[level.doa.var_6733605b.size] = trap;
    return;
  }

  function_a2e3342e(trap);
}

function function_865e002e() {
  self notify("3403e7d2fd3d360f");
  self endon("3403e7d2fd3d360f");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_6733605b) {
      time = gettime();

      if(isDefined(trap.var_eb9d64bb) && time < trap.var_eb9d64bb) {
        continue;
      }

      trap.var_eb9d64bb = time + 2000 + randomint(600);

      if(!isDefined(trap.script_model)) {
        activate = 0;

        if(isDefined(trap.var_f8660931)) {
          distsq = distancesquared(trap.origin, trap.var_f8660931.origin);

          if(distsq < sqr(3200)) {
            activate = 1;
          }
        }

        if(!activate) {
          trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 800);

          if(isDefined(trap.var_f8660931)) {
            activate = 1;
          }
        }

        if(activate) {
          function_a2e3342e(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN pressure plate trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 1200);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out pressure plate trap at:" + trap.origin);
      }
    }
  }
}

function function_b2a0e8d2() {
  level.doa.var_6733605b = [];
  level thread function_865e002e();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("pressureplate");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("pressureplate");
  }

  foreach(trap in traps) {
    function_b3e13787(trap, page);
  }
}

function function_3864f6a5() {
  self notify("328702548bd94911");
  self endon("328702548bd94911");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_e073d92f();

  if(!isDefined(self.script_model)) {
    self notify(#"destroy_hazard");
  }

  var_d71f280f = self.origin;
  upposition = var_d71f280f + (0, 0, 12);
  self.script_model moveto(upposition, 0.5);

  while(isDefined(self)) {
    waitframe(1);

    if(!isDefined(self.trigger)) {
      self.trigger = namespace_268747c0::function_5bfa98c9("pressureplate", self.origin);

      if(isDefined(self.trigger)) {
        self.trigger.origin = self.origin + (0, 0, 36);
        self.trigger.angles = self.angles;
      }

      continue;
    }

    result = self.trigger waittill(#"trigger");
    self.script_model namespace_e32bb68::function_3a59ec34("zmb_press_pad_down");
    self.script_model moveto(var_d71f280f, 0.5);
    array::notify_all(self.var_84a0207b, "plate_activated");

    while(isDefined(result.activator) && result.activator istouching(self.trigger)) {
      waitframe(1);
    }

    self.script_model namespace_e32bb68::function_3a59ec34("zmb_press_pad_up");
    self.script_model moveto(upposition, 0.5);
    array::notify_all(self.var_84a0207b, "plate_deactivated");
  }
}