/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2050c3ca1efa3116.gsc
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
#namespace namespace_d20e7d3b;

function init() {}

function main() {
  level.doa.var_f9d893a7 = [];
}

function function_be14ecd2() {
  self notify("5634ec87c8202e49");
  self endon("5634ec87c8202e49");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_f9d893a7, self);
    namespace_1e25ad94::debugmsg("Deleting Pungi trap permenently at:" + self.origin);
  }

  util::wait_network_frame();

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }
}

function function_c5cbd3bf(trap, var_7c56394 = 0) {
  hazard = namespace_ec06fe4a::spawnmodel(trap.origin, "zombietron_pungi_sticks");

  if(isDefined(hazard)) {
    hazard.targetname = "hazard";
    hazard.var_fd5301f9 = "pungi";
    hazard.angles = trap.angles;
  }

  trap.script_model = hazard;
  trap.var_7c56394 = var_7c56394;
  trap thread function_20cf5ee5();
  return trap;
}

function function_f42615a9(trap, page = 0) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  if(page) {
    if(!isDefined(level.doa.var_f9d893a7)) {
      level.doa.var_f9d893a7 = [];
    } else if(!isarray(level.doa.var_f9d893a7)) {
      level.doa.var_f9d893a7 = array(level.doa.var_f9d893a7);
    }

    level.doa.var_f9d893a7[level.doa.var_f9d893a7.size] = trap;
    return;
  }

  function_c5cbd3bf(trap);
}

function function_157f1b14() {
  self notify("74100d7d43395c8");
  self endon("74100d7d43395c8");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_f9d893a7) {
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
          } else {
            trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce(trap.origin, 1200);

            if(isDefined(trap.var_f8660931)) {
              activate = 1;
            }
          }
        }

        if(activate) {
          function_c5cbd3bf(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN pungi trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 3600);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out pungi trap at:" + trap.origin);
      }
    }
  }
}

function function_433b5718() {
  level.doa.var_f9d893a7 = [];
  level thread function_157f1b14();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("pungi");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("pungi");
  }

  foreach(trap in traps) {
    function_f42615a9(trap, page);
  }
}

function function_20cf5ee5() {
  self notify("27ff784ba90e19c");
  self endon("27ff784ba90e19c");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_be14ecd2();

  if(!isDefined(self.script_model)) {
    self notify(#"destroy_hazard");
  }

  self.state = 1;

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }

  up = anglestoup(self.angles);
  var_16ddcf3 = vectorscale(up, -24);
  var_cae2bc5d = vectorscale(up, -48);
  wait randomfloat(10);

  while(true) {
    self.state = 1;
    self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pungi_spike_down");
    self.script_model moveto(self.origin + var_cae2bc5d, 0.15);
    self.script_model waittill(#"movedone");
    self.script_model hide();
    wait 12;
    self.script_model show();
    self.state = 2;
    self.script_model moveto(self.origin + var_16ddcf3, 0.15);
    self.script_model waittill(#"movedone");
    self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pungi_spike_set");
    self.script_model namespace_83eb6304::function_3ecfde67("pungi_hint");
    wait 3;
    self.state = 3;
    self thread function_1e690b43(0.15, 6);
    self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pungi_spike_up");
    self.script_model namespace_83eb6304::function_3ecfde67("pungi_activate");
    self.script_model moveto(self.origin, 0.15);
    wait 6;
    self.script_model namespace_83eb6304::turnofffx("pungi_hint");
  }
}

function function_1e690b43(movetime, lifetime) {
  self notify("230b91e7f276322c");
  self endon("230b91e7f276322c");
  self endon(#"destroy_hazard");
  self waittilltimeout(movetime + 0.1, #"movedone");

  while(isDefined(self) && self.state === 3) {
    if(!isDefined(self.trigger)) {
      self.trigger = namespace_268747c0::function_5bfa98c9("pungi", self.origin);

      if(isDefined(self.trigger)) {
        up = anglestoup(self.angles);
        offset = up * 12;
        self.trigger.origin = self.origin + offset;
        self.trigger.angles = self.angles;

        level thread namespace_1e25ad94::function_b57a9d84(self.trigger.origin, self.trigger.angles[1], self.trigger.length, self.trigger.width, self.trigger.height, lifetime);
      }
    }

    if(isDefined(self.trigger)) {
      result = self.trigger waittilltimeout(0.25, #"trigger");
      guy = result.activator;

      if(isDefined(guy) && isalive(guy)) {
        if(is_true(guy.var_47267079) || is_true(guy.boss)) {
          continue;
        }

        if(isvehicle(guy)) {
          continue;
        }

        if(isPlayer(guy) && isDefined(guy.doa.vehicle)) {
          continue;
        }

        if(!isDefined(guy.var_69a33279)) {
          guy.var_69a33279 = 0;
        }

        if(guy.var_69a33279 < gettime()) {
          guy namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pungi_spike_impact");
          guy namespace_83eb6304::function_3ecfde67("pungi_damage");
          guy.var_69a33279 = gettime() + 1000;
        }

        if(isPlayer(guy)) {
          guy dodamage(guy.health + 100, guy.origin);
        } else {
          guy thread namespace_ec06fe4a::function_570729f0(0.1);
        }
      }

      continue;
    }

    wait 0.25;
  }

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }
}