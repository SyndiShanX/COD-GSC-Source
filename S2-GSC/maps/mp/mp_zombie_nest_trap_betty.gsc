/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_trap_betty.gsc
*************************************************/

func_9C97(param_00) {
  param_00 notify("bouncing_betty_trap_started");
  param_00.var_6667 = common_scripts\utility::func_46B7("trap_betty_fx_spawns", "script_noteworthy");
  var_01 = getEntArray(param_00.target, "targetname");
  level.var_9C97 = var_01[0];
  level.var_9C97.var_9C92 = param_00;
  level.var_9C97.var_9CBB = param_00.script_noteworthy;
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.script_noteworthy)) {
      continue;
    }

    if(var_03.script_noteworthy == "betty_trigger") {
      var_04 = common_scripts\utility::func_46B7(var_03.target, "targetname");
      if(!isDefined(var_04)) {
        return;
      }

      param_00 thread func_9CC4(var_03, var_04);
      wait 0.05;
    }
  }
}

func_8C2C(param_00) {
  thread func_9409();
  self.var_9409 = 0;
  while(!common_scripts\utility::func_562E(self.var_9409)) {
    var_01 = [];
    var_02 = [];
    var_03 = common_scripts\utility::random(param_00);
    param_00 = function_01AC(param_00, var_03.origin);
    for(var_04 = 0; var_04 < 4; var_04++) {
      var_02[var_04] = param_00[int(param_00.size / var_04 + 1) - 1];
    }

    for(var_04 = 0; var_04 < 4; var_04++) {
      var_01[var_04] = spawn("script_model", var_02[var_04].origin);
      var_01[var_04] setModel("tag_origin");
      var_01[var_04].var_65FA = func_2832(var_01[var_04]);
      var_01[var_04] thread func_3D8E(var_04 + 1);
    }

    wait(1.5);
  }
}

func_3D8E(param_00) {
  wait(1 / param_00);
  self.var_65FA fadeovertime(1);
  self.var_65FA.alpha = 0.65;
  wait(1);
  self.var_65FA fadeovertime(1);
  self.var_65FA.alpha = 0;
  wait(1);
  self.var_65FA destroy();
  self delete();
}

func_9409() {
  self.var_9409 = 0;
  common_scripts\utility::waittill_any("cooldown", "no_power", "deactivate", "ready");
  self.var_9409 = 1;
}

func_2832(param_00) {
  var_01 = newhudelem();
  var_01 setshader("hud_destructibledeathicon", 1, 1);
  var_01.alpha = 0;
  var_01.color = (1, 1, 1);
  var_01.x = param_00.origin[0];
  var_01.y = param_00.origin[1];
  var_01.z = param_00.origin[2];
  var_01 setwaypoint(0);
  var_01 settargetEnt(param_00);
  return var_01;
}

func_9CC4(param_00, param_01) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_02 = 0;
  var_03 = 0.15;
  if(isDefined(self.var_817A)) {
    var_04 = self.var_817A;
  } else {
    var_04 = 20;
  }

  var_05 = [];
  for(var_06 = 0; var_06 < param_01.size; var_06++) {
    var_05[var_06] = param_01[var_06].origin;
  }

  while(var_02 < var_04) {
    var_03 = randomfloat(0.75) + 0.5;
    wait(var_03);
    var_02 = var_02 + var_03;
    thread func_2E66(common_scripts\utility::random(var_05));
  }
}

func_2E66(param_00) {
  var_01 = param_00;
  if(!isDefined(self.var_5BBA)) {
    self.var_5BBA = (0, 0, 0);
  }

  self.var_5BBA = var_01;
  playFX(level._effect["bouncing_betty_explode"], var_01);
  lib_0378::func_8D74("aud_trap_betty_triggered", var_01);
  wait(0.6);
  var_02 = var_01 + (0, 0, 70);
  playFX(level._effect["bouncing_betty_explosion"], var_02);
  lib_0378::func_8D74("aud_trap_betty_explo", var_01);
  var_03 = lib_0547::func_408F();
  foreach(var_05 in var_03) {
    var_06 = distance(var_05.origin, var_02);
    if(var_06 < 256) {
      if(var_05 lib_0547::func_580A()) {
        var_05 dodamage(var_05.health * 0.25, var_02, level.var_9C97, level.var_9C97, "MOD_EXPLOSIVE", "trap_zm_mp");
      } else {
        maps / mp / mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6FEE(var_05);
        var_05 dodamage(var_05.health + 666, var_02, level.var_9C97, level.var_9C97, "MOD_EXPLOSIVE", "trap_zm_mp");
        if(!isDefined(self.hitbytrap)) {
          foreach(var_08 in level.players) {
            var_08 maps / mp / gametypes / zombies::func_47C7("kill_trap");
            self.hitbytrap = 1;
          }
        }
      }

      wait 0.05;
    }
  }

  foreach(var_08 in level.players) {
    var_06 = distance(var_08.origin, var_02);
    if(var_06 < 256) {
      var_08 dodamage(30 * 1 - var_06 / 256, var_02, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  earthquake(0.8, 0.6, var_02, 200);
  wait(0.4);
  self.var_1732 = 0;
}