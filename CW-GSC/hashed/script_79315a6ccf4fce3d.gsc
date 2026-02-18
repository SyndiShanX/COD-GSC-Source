/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_79315a6ccf4fce3d.gsc
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
#namespace namespace_fb2125f;

function init() {}

function main() {}

function function_dcb0d632(damaged = 0, var_3463bd5c) {
  self notify("2b7ecfa4758d736a");
  self endon("2b7ecfa4758d736a");
  self endon(#"death");
  self thread namespace_268747c0::function_978c05b5();

  if(damaged) {
    self thread namespace_268747c0::function_5418a00f();
    result = self waittilltimeout(30, #"destroy_hazard");
  } else {
    result = self waittill(#"destroy_hazard");
  }

  if(isDefined(var_3463bd5c) && is_true(var_3463bd5c.var_7c56394) && (is_true(result.var_760a0807) || damaged)) {
    arrayremovevalue(level.doa.var_d1534e45, self);
    namespace_1e25ad94::debugmsg("Deleting barrel trap permenently at:" + self.origin);
  }

  self namespace_ec06fe4a::function_8c808737();
  self namespace_e32bb68::function_ae271c0b("barrel_ignite");
  self namespace_e32bb68::function_ae271c0b("barrel_warn");
  self namespace_83eb6304::turnofffx("barrel_fire");
  self namespace_83eb6304::turnofffx("barrel_fire_top");
  wait 0.5;
  self delete();
}

function function_db4a8bad(damaged = 0, barrel) {
  assert(isDefined(barrel));
  self notify("56fe998691e89973");
  self endon("56fe998691e89973");
  barrel endon(#"death");
  barrel thread function_dcb0d632(damaged, self);
  barrel thread function_7e0f72a5();
  barrel thread function_ed0bfdae();

  if(!damaged) {
    waitresult = barrel waittill(#"damage");
    barrel connectpaths();
  }

  barrel thread function_dcb0d632(1, self);

  if(isDefined(waitresult) && isDefined(waitresult.direction)) {
    impulse = waitresult.direction + (0, 0, 5);
    impulse = vectorscale(impulse, 3);
    barrel physicslaunch(barrel.origin, impulse);
  }

  barrel thread function_d971ecbd(12);
}

function function_7e0f72a5() {
  self endon(#"death");

  while(true) {
    result = level waittill(#"hash_c1cceae4479f2e5");
    distsq = distancesquared(self.origin, result.origin);

    if(distsq < sqr(256)) {
      dir = vectornormalize(self.origin - result.origin);
      impulse = dir + (0, 0, 10);
      impulse = vectorscale(dir, 60);
      self physicslaunch(self.origin, impulse);

      if(distsq < sqr(128) && !is_true(self.fuselit)) {
        self.takedamage = 1;
        self dodamage(10, self.origin);
      }
    }
  }
}

function function_ed0bfdae() {
  self endon(#"death");

  while(true) {
    result = level waittill(#"hash_50be6fd0db982086");
    distsq = distancesquared(self.origin, result.origin);

    if(distsq < sqr(72)) {
      dir = vectornormalize(self.origin - result.origin);
      impulse = dir + (0, 0, 15);
      impulse = dir + (0, 0, 15);
      impulse = vectorscale(impulse, 5);
      self physicslaunch(self.origin, impulse);

      if(!is_true(self.fuselit)) {
        self.takedamage = 1;
        self dodamage(1, self.origin);
      }
    }
  }
}

function function_d971ecbd(time) {
  self notify("259362ec3a4b2b9e");
  self endon("259362ec3a4b2b9e");
  self endon(#"death");
  self namespace_83eb6304::function_3ecfde67("barrel_fire_top");
  self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_redbarrel_ignite");
  self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_redbarrel_fuse_lp");
  detonationtime = gettime() + time * 1000;
  stage1 = detonationtime - 4500;
  var_38ec2561 = 0;

  while(true) {
    time = gettime();

    if(time >= detonationtime) {
      break;
    }

    result = self waittilltimeout(0.5, #"damage");

    if(result._notify == # "damage") {
      namespace_1e25ad94::debugmsg("Barrel (" + self getentitynumber() + ") took damage of: " + result.amount + " Health left: " + self.health);
      self.fuselit = 1;
      detonationtime -= 2000;
      stage1 -= 2000;
    }

    if(!var_38ec2561 && time > stage1) {
      var_38ec2561 = 1;
      self namespace_83eb6304::function_3ecfde67("explo_warning_light");
      self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_redbarrel_warning");
    }
  }

  self notsolid();
  self namespace_83eb6304::function_3ecfde67("explode_red_barrel");
  self namespace_83eb6304::turnofffx("barrel_fire_top");
  self namespace_83eb6304::turnofffx("red_shield_os");
  self namespace_83eb6304::turnofffx("explo_warning_light");
  self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_redbarrel_explosion");
  self namespace_e32bb68::function_ae271c0b("evt_doa_hazard_redbarrel_fuse_lp");
  self.takedamage = 0;
  radiusdamage(self.origin + (0, 0, 15), 96, 4000, 2000, self, "MOD_EXPLOSIVE");
  physicsexplosionsphere(self.origin, 1024, 256, 0.5);
  self disableaimassist();

  if(isDefined(self.var_82190347)) {
    self setModel(self.var_82190347);
    self solid();
    self physicslaunch(self.origin, (randomintrange(-10, 10), randomintrange(-10, 10), 5));
    self namespace_ec06fe4a::function_ecec1794();
    self namespace_83eb6304::function_3ecfde67("barrel_fire");
    self notsolid();
    return;
  }

  self notsolid();
  self namespace_ec06fe4a::function_8c808737();
  self thread namespace_ec06fe4a::function_52afe5df(0.5);
}

function function_6e3c8a46() {
  level.doa.var_d1534e45 = [];

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("explo_barrel");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("explo_barrel");
  }

  foreach(trap in traps) {
    function_3dd2c543(trap, page);
  }
}

function function_3dd2c543(trap, page = 0) {
  if(page) {
    if(!isDefined(level.doa.var_d1534e45)) {
      level.doa.var_d1534e45 = [];
    } else if(!isarray(level.doa.var_d1534e45)) {
      level.doa.var_d1534e45 = array(level.doa.var_d1534e45);
    }

    level.doa.var_d1534e45[level.doa.var_d1534e45.size] = trap;
    return;
  }

  function_647017bd(trap);
}

function function_f1ca69a7(model, var_639facc4, origin, angles, disconnect = 1) {
  hazard = namespace_ec06fe4a::spawnmodel(origin, model);

  if(isDefined(hazard)) {
    hazard setModel(model);
    hazard.var_82190347 = var_639facc4;
    hazard.targetname = "hazard";
    hazard.var_fd5301f9 = "barrel";
    hazard.angles = angles;
    hazard.takedamage = 1;
    hazard.health = 100000;
    hazard solid();

    if(disconnect) {
      hazard disconnectpaths();
    }

    hazard enableaimassist();
    self thread function_db4a8bad(0, hazard);
  }

  return hazard;
}

function function_647017bd(trap, var_7c56394 = 0, modelname = "zombietron_explosive_barrel", var_639facc4) {
  if(isDefined(trap.script_string)) {
    args = strtok(trap.script_string, ";");

    if(isDefined(args[0])) {
      modelname = args[0];
    }

    if(isDefined(args[1])) {
      var_639facc4 = args[1];
    }
  }

  hazard = trap function_f1ca69a7(modelname, var_639facc4, trap.origin, trap.angles);
  trap.script_model = hazard;
  trap.var_7c56394 = var_7c56394;
  return trap;
}

function function_2b60f30() {
  self notify("1343f00e4edb5ca3");
  self endon("1343f00e4edb5ca3");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_d1534e45) {
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

        if(activate) {
          function_647017bd(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN barrel trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 1800);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out barrel trap at:" + trap.origin);
      }
    }
  }
}