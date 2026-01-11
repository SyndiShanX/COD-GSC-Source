/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\headgear.gsc
*********************************************/

init() {
  level.var_8C71 = [];
  level.var_8C71["wave"] = loadfx("vfx\iw7\_requests\mp\trail_kinetic_wave");
  level.var_8C71["wedge"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_wave_wedge");
  level.var_8C71["halo"] = loadfx("vfx\iw7\_requests\mp\vfx_light_headgear_halo");
}

func_E129() {
  self notify("remove_headgear");
}

func_E855() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_headgear");
  for(;;) {
    self waittill("headgear_save", var_00, var_01, var_02);
    if(weaponclass(var_02) == "sniper") {
      thread func_E856();
    }
  }
}

func_E856() {
  self shellshock("concussion_grenade_mp", 2.5, 0, 1);
}

func_8C6F(param_00, param_01) {
  self.var_8BF8 = 1;
  var_02 = level.powers["power_headgear"].var_5FF3;
  scripts\mp\gamescore::trackbuffassist(param_00, self, "power_headgear");
  thread scripts\mp\killstreaks\_emp_common::func_5AA9();
  var_03 = "j_spinelower";
  if(param_01) {
    self iprintlnbold("HEADGEAR APPLIED");
    var_03 = "j_head";
  } else {
    self iprintlnbold("BARRIER APPLIED");
  }

  var_04 = playFXOnTag(level.var_8C71["halo"], self, var_03);
  thread func_8C73(param_00, var_02, var_03);
  wait(var_02);
  thread func_8C72(param_00, var_03);
}

func_8C72(param_00, param_01) {
  self endon("disconnect");
  self endon("removeArchetype");
  stopFXOnTag(level.var_8C71["halo"], self, param_01);
  self.var_8BF8 = undefined;
  scripts\mp\gamescore::untrackbuffassist(param_00, self, "power_headgear");
}

func_8C73(param_00, param_01, param_02) {
  self endon("disconnect");
  self waittill("death");
  thread func_8C72(param_00, param_01, param_02);
}

func_8C70(param_00) {
  var_01 = [];
  var_02 = [];
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_01[var_03] = ::scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 36));
    var_02[var_03] = spawn("script_model", var_01[var_03].origin);
    var_02[var_03] linkto(var_01[var_03]);
  }

  scripts\engine\utility::waitframe();
  playFX(level.var_8C71["wedge"], var_01[2].origin, anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()));
  var_04 = [16, 8, 0, -8, -16];
  for(var_03 = 0; var_03 < 5; var_03++) {
    thread func_68D8(var_01[var_03], var_04[var_03]);
  }

  foreach(var_06 in param_00) {
    if(distance2dsquared(self.origin, var_06.origin) < 100000 && isDefined(self _meth_840B(var_06.origin, 65))) {
      var_07 = var_06 damageconetrace(var_01[2].origin);
      if(var_07 > 0.2) {
        var_08 = self worldpointinreticle_circle(var_06 gettagorigin("tag_eye"), 65, 50);
        var_06 thread func_8C6F(self, var_08);
      }
    }
  }

  wait(3);
  foreach(var_0B in var_02) {
    var_0B delete();
  }

  foreach(var_0E in var_01) {
    var_0E delete();
  }
}

func_68D8(param_00, param_01) {
  playFXOnTag(level.var_8C71["wave"], param_00, "tag_origin");
  var_02 = rotatepointaroundvector(anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()), param_01);
  var_03 = self.origin + var_02 * 100000;
  var_04 = scripts\common\trace::ray_trace(self.origin + (0, 0, 96), var_03);
  if(!isDefined(var_04)) {
    var_05 = 3;
    var_04["position"] = var_03;
  } else {
    var_05 = 3 * var_05["fraction"];
    if(var_05 <= 0) {
      var_05 = 0.05;
    }
  }

  param_00 moveto(var_04["position"], var_05);
}