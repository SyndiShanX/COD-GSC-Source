/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
    self waittill("headgear_save", var_0, var_1, var_2);
    if(weaponclass(var_2) == "sniper") {
      thread func_E856();
    }
  }
}

func_E856() {
  self shellshock("concussion_grenade_mp", 2.5, 0, 1);
}

func_8C6F(var_0, var_1) {
  self.var_8BF8 = 1;
  var_2 = level.powers["power_headgear"].var_5FF3;
  scripts\mp\gamescore::trackbuffassist(var_0, self, "power_headgear");
  thread scripts\mp\killstreaks\emp_common::func_5AA9();
  var_3 = "j_spinelower";
  if(var_1) {
    self iprintlnbold("HEADGEAR APPLIED");
    var_3 = "j_head";
  } else {
    self iprintlnbold("BARRIER APPLIED");
  }

  var_4 = playFXOnTag(level.var_8C71["halo"], self, var_3);
  thread func_8C73(var_0, var_2, var_3);
  wait(var_2);
  thread func_8C72(var_0, var_3);
}

func_8C72(var_0, var_1) {
  self endon("disconnect");
  self endon("removeArchetype");
  stopFXOnTag(level.var_8C71["halo"], self, var_1);
  self.var_8BF8 = undefined;
  scripts\mp\gamescore::untrackbuffassist(var_0, self, "power_headgear");
}

func_8C73(var_0, var_1, var_2) {
  self endon("disconnect");
  self waittill("death");
  thread func_8C72(var_0, var_1, var_2);
}

func_8C70(var_0) {
  var_1 = [];
  var_2 = [];
  for(var_3 = 0; var_3 < 5; var_3++) {
    var_1[var_3] = ::scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 36));
    var_2[var_3] = spawn("script_model", var_1[var_3].origin);
    var_2[var_3] linkto(var_1[var_3]);
  }

  scripts\engine\utility::waitframe();
  playFX(level.var_8C71["wedge"], var_1[2].origin, anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()));
  var_4 = [16, 8, 0, -8, -16];
  for(var_3 = 0; var_3 < 5; var_3++) {
    thread func_68D8(var_1[var_3], var_4[var_3]);
  }

  foreach(var_6 in var_0) {
    if(distance2dsquared(self.origin, var_6.origin) < 100000 && isDefined(self func_840B(var_6.origin, 65))) {
      var_7 = var_6 damageconetrace(var_1[2].origin);
      if(var_7 > 0.2) {
        var_8 = self worldpointinreticle_circle(var_6 gettagorigin("tag_eye"), 65, 50);
        var_6 thread func_8C6F(self, var_8);
      }
    }
  }

  wait(3);
  foreach(var_11 in var_2) {
    var_11 delete();
  }

  foreach(var_14 in var_1) {
    var_14 delete();
  }
}

func_68D8(var_0, var_1) {
  playFXOnTag(level.var_8C71["wave"], var_0, "tag_origin");
  var_2 = rotatepointaroundvector(anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()), var_1);
  var_3 = self.origin + var_2 * 100000;
  var_4 = scripts\common\trace::ray_trace(self.origin + (0, 0, 96), var_3);
  if(!isDefined(var_4)) {
    var_5 = 3;
    var_4["position"] = var_3;
  } else {
    var_5 = 3 * var_5["fraction"];
    if(var_5 <= 0) {
      var_5 = 0.05;
    }
  }

  var_0 moveto(var_4["position"], var_5);
}