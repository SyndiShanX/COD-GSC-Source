/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_60c9f7551ce6c823.gsc
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
#namespace namespace_53f73cda;

function init() {}

function main() {
  level.doa.var_7a2db350 = [];
  level.doa.var_8d14dcbf = [];
}

function function_215e1efb() {
  self notify("181e2a51f4b6bc73");
  self endon("181e2a51f4b6bc73");
  self thread namespace_268747c0::function_978c05b5();
  self thread namespace_268747c0::function_5418a00f();
  result = self waittill(#"destroy_hazard");
  self.var_9760b617 = 1;

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_7a2db350, self);
    namespace_1e25ad94::debugmsg("Deleting Pole trap permenently at:" + self.origin);
  }

  if(isDefined(self.script_models)) {
    arrayremovevalue(self.script_models, undefined);

    foreach(model in self.script_models) {
      model notify(#"destroy_hazard");
    }

    foreach(model in self.script_models) {
      if(isDefined(model.trigger)) {
        model.trigger namespace_268747c0::function_54f185a();
        model.trigger = undefined;
      }

      model namespace_e32bb68::function_ae271c0b("hazard_electric_trap_active");
      model namespace_83eb6304::turnofffx("hazard_electric_trap_red");
      model namespace_83eb6304::turnofffx("hazard_electric_trap_green");
      model namespace_83eb6304::turnofffx("hazard_electric_trap_active");
    }

    foreach(model in self.script_models) {
      model namespace_83eb6304::function_8a1f8325();
      util::wait_network_frame();
      model delete();
    }

    self.script_models = undefined;
  }

  self.var_9760b617 = undefined;
}

function function_3bea16f1(trap, var_7c56394 = 0, origin = trap.origin) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  hazard = namespace_ec06fe4a::spawnmodel(origin, "zombietron_electrical_pole");

  if(isDefined(hazard)) {
    hazard.targetname = "hazard";
    hazard.var_fd5301f9 = "pole";
    hazard solid();
    hazard thread function_4eec8432();

    if(isDefined(trap)) {
      if(!isDefined(trap.script_models)) {
        trap.script_models = [];
      }

      if(!isDefined(trap.script_models)) {
        trap.script_models = [];
      } else if(!isarray(trap.script_models)) {
        trap.script_models = array(trap.script_models);
      }

      trap.script_models[trap.script_models.size] = hazard;
    }
  } else {
    return;
  }

  if(isDefined(trap)) {
    trap.var_7c56394 = var_7c56394;
    trap thread function_215e1efb();
  }

  return hazard;
}

function function_4eec8432() {
  self endon(#"death", #"destroy_hazard");
  self.active = 0;
  self namespace_83eb6304::turnofffx("hazard_electric_trap_red");
  self namespace_83eb6304::function_3ecfde67("hazard_electric_trap_green");
  wait 5;

  while(true) {
    wait randomfloatrange(5, 15);
    self namespace_83eb6304::function_3ecfde67("hazard_electric_trap_red");
    self namespace_83eb6304::turnofffx("hazard_electric_trap_green");
    self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pole_warning");
    wait 1.2;
    self namespace_83eb6304::turnofffx("hazard_electric_trap_red");
    self namespace_83eb6304::turnofffx("hazard_electric_trap_green");
    self namespace_83eb6304::function_3ecfde67("hazard_electric_trap_active");
    self.active = 1;
    self thread function_a0fe5f28();
    wait randomfloatrange(4, 10);
    self.active = 0;
    self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pole_off");
    self namespace_83eb6304::turnofffx("hazard_electric_trap_active");
    self namespace_83eb6304::turnofffx("hazard_electric_trap_red");
    self namespace_83eb6304::function_3ecfde67("hazard_electric_trap_green");
  }
}

function function_a0fe5f28() {
  self endon(#"death", #"destroy_hazard");
  var_5fdeec29 = 8500;
  assert(!isDefined(self.trigger));

  while(isDefined(self) && is_true(self.active)) {
    if(!isDefined(self.trigger)) {
      self.trigger = namespace_268747c0::function_5bfa98c9("pole", self.origin, 512, 1, 700);

      if(isDefined(self.trigger)) {
        self.trigger.origin = self.origin;
        self.trigger.angles = self.angles;
      }
    }

    if(isDefined(self.trigger)) {
      result = self.trigger waittilltimeout(0.25, #"trigger");

      if(result._notify == # "timeout") {
        continue;
      }

      guy = result.activator;

      if(isDefined(guy)) {
        if(!isDefined(guy.doa)) {
          continue;
        }

        if(is_true(guy.var_2b989b2e)) {
          continue;
        }

        if(!isDefined(guy.doa.hazard_hit)) {
          guy.doa.hazard_hit = 0;
        }

        curtime = gettime();

        if(curtime < guy.doa.hazard_hit) {
          continue;
        }

        guy.doa.hazard_hit = curtime + 1500;
        guy namespace_e32bb68::function_3a59ec34("evt_doa_hazard_pole_impact");
        guy namespace_83eb6304::function_3ecfde67("hazard_electric");

        if(is_true(guy.var_47267079) || is_true(guy.boss)) {
          continue;
        }

        if(isPlayer(guy) || isvehicle(guy)) {
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

function function_28826539(trap, page = 0, origin) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  if(page) {
    if(!isDefined(level.doa.var_7a2db350)) {
      level.doa.var_7a2db350 = [];
    } else if(!isarray(level.doa.var_7a2db350)) {
      level.doa.var_7a2db350 = array(level.doa.var_7a2db350);
    }

    level.doa.var_7a2db350[level.doa.var_7a2db350.size] = trap;
    return;
  }

  return function_3bea16f1(trap, 0, origin);
}

function function_97d551b(var_2c5f6748) {
  level.doa.var_7a2db350 = [];
  level.doa.var_8d14dcbf = [];
  level thread function_16abf3d3();
  state = namespace_4dae815d::function_59a9cf1d();

  if(state == 0) {
    if(getdvarint(#"hash_1ea1b9dc5e765aa9", 0)) {
      var_157df687 = 40;
      var_2c5f6748 = 40;
    } else {
      if(level.doa.roundnumber < 8) {
        return;
      }

      var_157df687 = math::clamp(1 + randomint(2 + int((level.doa.roundnumber - 4) / 5)), 1, 40);
    }

    if(isDefined(var_2c5f6748) && var_157df687 > var_2c5f6748) {
      var_157df687 = var_2c5f6748;
    }

    if(var_157df687 <= 0) {
      return;
    }
  }

  if(isDefined(level.doa.var_a77e6349)) {
    var_71da84c = [[level.doa.var_a77e6349]] - > function_87f950c1("elec_pole");
  } else {
    var_71da84c = [[level.doa.var_39e3fa99]] - > function_242886d5("elec_pole");
  }

  if(var_71da84c.size == 0) {
    return;
  }

  if(state == 0) {
    while(var_157df687) {
      trap = var_71da84c[randomint(var_71da84c.size)];

      if(is_true(trap.var_9760b617)) {
        waitframe(1);
        continue;
      }

      var_157df687--;
      radius = 85;

      if(isDefined(trap.radius)) {
        radius = int(trap.radius);
      }

      origin = trap.origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 0);
      origin = function_a971a62f(origin, trap.origin, radius);

      if(isDefined(origin)) {
        pole = function_28826539(trap, 0, origin);

        if(isDefined(pole)) {
          level.doa.var_8d14dcbf[level.doa.var_8d14dcbf.size] = pole;
        }
      }
    }

    return;
  }

  foreach(trap in var_71da84c) {
    function_28826539(trap, 1);
  }
}

function function_16abf3d3() {
  self notify("44a4d8b4694b55f4");
  self endon("44a4d8b4694b55f4");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_7a2db350) {
      time = gettime();

      if(isDefined(trap.var_eb9d64bb) && time < trap.var_eb9d64bb) {
        continue;
      }

      trap.var_eb9d64bb = time + 2000 + randomint(600);

      if(!isDefined(trap.script_models)) {
        activate = 0;

        if(isDefined(trap.var_f8660931)) {
          distsq = distancesquared(trap.origin, trap.var_f8660931.origin);

          if(distsq < sqr(3200)) {
            activate = 1;
          }
        }

        if(!activate) {
          trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 1600);

          if(isDefined(trap.var_f8660931)) {
            activate = 1;
          } else {
            trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce(trap.origin, 600);

            if(isDefined(trap.var_f8660931)) {
              activate = 1;
            }
          }
        }

        if(activate && !is_true(trap.var_9760b617)) {
          function_3bea16f1(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN pole trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 1800);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out pole trap at:" + trap.origin);
      }
    }
  }
}

function function_a971a62f(origin, var_5c526bd9 = origin, var_c705f304 = 85) {
  min_dist = 36;
  min_dist_squared = min_dist * min_dist;
  pushed = 1;
  max_tries = 5;

  while(pushed && max_tries > 0) {
    max_tries--;
    pushed = 0;

    foreach(hazard in level.doa.var_8d14dcbf) {
      if(!isDefined(hazard)) {
        continue;
      }

      dist_squared = distancesquared(origin, hazard.origin);

      if(dist_squared < min_dist_squared) {
        dir = origin - hazard.origin;
        dir = vectornormalize(dir);
        var_d8176d62 = origin - var_5c526bd9;
        var_d8176d62 = vectornormalize(dir);

        if(vectordot(dir, var_d8176d62) < 0) {
          dir *= -1;
        }

        origin += dir * min_dist;
        pushed = 1;
      }
    }
  }

  dist_squared = distancesquared(origin, var_5c526bd9);

  if(dist_squared > sqr(var_c705f304)) {
    return undefined;
  }

  trace = worldtrace(origin + (0, 0, 32), origin + (48, 0, 32));
  var_cb85c7c9 = trace[#"fraction"] == 1 && trace[#"surfacetype"] == "none";

  if(!var_cb85c7c9) {
    return undefined;
  }

  trace = worldtrace(origin + (0, 0, 32), origin + (-48, 0, 32));
  var_cb85c7c9 = trace[#"fraction"] == 1 && trace[#"surfacetype"] == "none";

  if(!var_cb85c7c9) {
    return undefined;
  }

  trace = worldtrace(origin + (0, 0, 32), origin + (0, 48, 32));
  var_cb85c7c9 = trace[#"fraction"] == 1 && trace[#"surfacetype"] == "none";

  if(!var_cb85c7c9) {
    return undefined;
  }

  trace = worldtrace(origin + (0, 0, 32), origin + (0, -48, 32));
  var_cb85c7c9 = trace[#"fraction"] == 1 && trace[#"surfacetype"] == "none";

  if(!var_cb85c7c9) {
    return undefined;
  }

  return namespace_ec06fe4a::function_65ee50ba(origin);
}