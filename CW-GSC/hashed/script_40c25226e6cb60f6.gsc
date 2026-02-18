/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_40c25226e6cb60f6.gsc
***********************************************/

#using script_164a456ce05c3483;
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
#namespace namespace_61052b71;

function init() {}

function main() {
  level.doa.var_17228d33 = [];
}

function function_5529395e() {
  self notify("21a1deafb5f08486");
  self endon("21a1deafb5f08486");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_17228d33, self);
    namespace_1e25ad94::debugmsg("Deleting physics box trap permenently at:" + self.origin);
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
}

function function_8b014c60(trap, var_7c56394 = 0) {
  assert(isDefined(trap.script_parameters), "<dev string:x38>");
  args = strtok(trap.script_parameters, ";");
  trap.var_b7a27a3a = 0;

  if(isDefined(trap.script_int)) {
    trap.var_b7a27a3a = int(trap.script_int);
  }

  switch (args[0]) {
    case # "velocity":
      assert(args.size >= 4, "<dev string:x57>");
      trap.velocityvector = (float(args[1]), float(args[2]), float(args[3]));
      trap.type = 0;
      break;
    default:
      assert(0);
      break;
  }

  trap.script_model = namespace_ec06fe4a::spawnmodel(trap.origin, trap.model, trap.angles);

  if(isDefined(trap.script_model)) {
    trap.script_model.targetname = "hazard";
    trap.script_model.var_fd5301f9 = "physicsbox";
  }

  trap.var_7c56394 = var_7c56394;
  trap thread function_d74e40c3();
  return trap;
}

function function_bb1d1cf9(trap, page = 0) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  if(page) {
    if(!isDefined(level.doa.var_17228d33)) {
      level.doa.var_17228d33 = [];
    } else if(!isarray(level.doa.var_17228d33)) {
      level.doa.var_17228d33 = array(level.doa.var_17228d33);
    }

    level.doa.var_17228d33[level.doa.var_17228d33.size] = trap;
    return;
  }

  function_8b014c60(trap);
}

function function_e74a3df6() {
  self notify("6a2e88ac4d6010df");
  self endon("6a2e88ac4d6010df");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_17228d33) {
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
          trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 3200);

          if(isDefined(trap.var_f8660931)) {
            activate = 1;
          }
        }

        if(activate) {
          function_8b014c60(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN physics box trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 3600);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out physics box trap at:" + trap.origin);
      }
    }
  }
}

function function_8bd713b2() {
  level.doa.var_17228d33 = [];
  level thread function_e74a3df6();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("physicsbox");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("physicsbox");
  }

  foreach(trap in traps) {
    function_bb1d1cf9(trap, page);
  }
}

function function_d74e40c3() {
  self notify("1f0b44627f606460");
  self endon("1f0b44627f606460");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_5529395e();

  if(!isDefined(self.script_model)) {
    self notify(#"destroy_hazard");
  }

  var_d71f280f = self.origin;
  upposition = var_d71f280f + (0, 0, 15);

  while(isDefined(self)) {
    waitframe(1);

    if(!isDefined(self.trigger)) {
      self.trigger = self namespace_268747c0::function_678eaf60("physicsbox", self.origin, 256, 1, 128);
      self.trigger.origin += (0, 0, self.var_b7a27a3a);
      self.trigger triggerenable(1);
      continue;
    }

    result = self.trigger waittill(#"trigger", #"hash_5dc5b7f198cd1bec");

    if(result._notify === # "hash_5dc5b7f198cd1bec") {
      wait 0.25;
      continue;
    }

    self.script_model moveto(upposition, 0.1);
    guy = result.activator;

    switch (self.type) {
      default:
        if(isPlayer(guy)) {
          self.script_model namespace_e32bb68::function_3a59ec34("zmb_physicsBoxVelocity");
          localvelocity = guy getvelocity() + self.velocityvector;
          guy setorigin(guy.origin + (0, 0, 30));
          waitframe(1);

          if(isDefined(guy)) {
            guy setvelocity(localvelocity);

            if(namespace_4dae815d::function_59a9cf1d() != 0) {
              guy thread namespace_7f5aeb59::function_a74228bc();
            }

            guy namespace_e32bb68::function_3a59ec34("evt_doa_springboard");
          }
        } else if(isactor(guy)) {
          if(isDefined(guy.launched)) {
            continue;
          }

          if(!issentient(guy)) {
            continue;
          }

          if(!is_true(guy.takedamage)) {
            continue;
          }

          if(is_true(guy.var_47267079) || is_true(guy.boss)) {
            continue;
          }

          if(!is_true(guy.var_e66cd6fb)) {
            guy.launched = 1;
            guy thread namespace_ec06fe4a::function_b4ff2191(self.velocityvector, 180, 0.3);
            guy namespace_e32bb68::function_3a59ec34("zmb_ragdoll_launched");
            guy namespace_e32bb68::function_3a59ec34("evt_doa_springboard");
          }
        }

        break;
    }

    wait 5;
    self.script_model moveto(var_d71f280f, 2);
    wait 2;
  }
}