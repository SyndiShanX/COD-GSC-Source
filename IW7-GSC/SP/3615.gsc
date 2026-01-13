/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3615.gsc
*********************************************/

func_6137() {
  level._effect["impact_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_thegreatzapper.vfx");
  level._effect["fuse_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._effect["battery_explosion"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_barrel_model.vfx");
  var_0 = getEntArray("phys_battery_destructible", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_6134();
  }
}

func_6134() {
  self endon("barrel_death");
  self endon("barrel_delete");
  lib_0E1D::func_2840("emp", 120, 350, 9100, 15000, 80, 28);
  thread func_6135();
  var_0 = 3;
  var_1 = 0;
  var_2 = 120;
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E);
    if(isDefined(var_6) && isai(var_6)) {
      continue;
    }

    if(isDefined(var_6) && isDefined(var_6.var_9D62)) {
      continue;
    }

    if(isDefined(var_0E) && scripts\engine\utility::weaponclass(var_0E) == "sniper") {
      var_5 = 999999;
      var_0 = 0;
    }

    var_2 = int(var_2 - var_5);
    if(var_2 <= 0 && !isDefined(self.var_C528)) {
      var_2 = 50;
    }

    if(var_2 <= 0) {
      break;
    }

    self.var_2836 = var_2;
    if(var_2 <= 50) {
      if(!var_1) {
        if(!var_4) {
          var_4 = 1;
          if(soundexists("emp_battery_damaged_warning_lp")) {
            thread scripts\sp\utility::play_loop_sound_on_tag("emp_battery_damaged_warning_lp", "tag_origin", 1, 1);
          }
        }

        playFXOnTag(scripts\engine\utility::getfx("fuse_shock"), self, "tag_origin");
        var_1 = 1;
        self.var_C528 = 1;
      }

      var_0F = var_2 / 50;
      var_0 = var_0 * var_0F;
      thread lib_0E1D::func_2835(var_0);
    }

    if(isDefined(var_7)) {
      var_10 = length(var_7);
      if(var_10 > 20) {
        var_11 = vectornormalize(var_7);
        var_12 = 20;
        if(isDefined(var_9) && var_9 == "MOD_IMPACT") {
          var_12 = 3;
        }

        var_7 = var_11 * var_12;
      }

      self physicslaunchserver(var_8, var_7 * 1000);
    }

    if(!isDefined(var_9)) {
      continue;
    }

    var_13 = strtok(var_9, "_");
    if(!scripts\engine\utility::array_contains(var_13, "BULLET")) {
      continue;
    }

    var_14 = scripts\engine\utility::spawn_tag_origin(var_8);
    var_15 = vectornormalize(self.origin - var_8);
    var_16 = vectortoangles(var_15 * -1);
    var_14.angles = scripts\engine\utility::flat_angle(var_16);
    var_14 linkto(self);
    if(!var_3) {
      var_3 = 1;
      if(soundexists("emp_battery_damaged_lp")) {
        var_14 thread scripts\sp\utility::play_loop_sound_on_tag("emp_battery_damaged_lp", "tag_origin", 1, 1);
      }
    }

    playFXOnTag(scripts\engine\utility::getfx("impact_shock"), var_14, "tag_origin");
    self.var_109DB = scripts\engine\utility::array_add(self.var_109DB, var_14);
  }

  while(isDefined(self.var_5945)) {
    scripts\engine\utility::waitframe();
  }

  self notify("barrel_death");
}

func_6135() {
  self endon("barrel_delete");
  self waittill("barrel_death");
  physicsexplosionsphere(self.origin, self.var_CAF6, 0, 2);
  earthquake(0.5, 0.8, self.origin, 700);
  thread lib_0E25::func_6133(self);
  thread scripts\sp\detonategrenades::func_DBDB(self.origin);
  var_0 = 0.3;
  var_1 = sortbydistance(level.var_CAF7, self.origin);
  foreach(var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }

    var_4 = distance(self.origin, var_3.origin);
    if(var_4 > self.var_CAF6) {
      continue;
    }

    var_5 = self.var_CAF6 - var_4;
    var_6 = var_5 / self.var_CAF6;
    var_7 = var_0 * var_6;
    if(var_4 <= self.var_CAF6) {
      var_3 thread lib_0E1D::func_2837(self.origin, var_4, var_7);
    }

    if(var_4 <= 340) {
      var_3 thread func_6136(self.origin, var_4, var_7);
    }
  }

  radiusdamage(self.origin, 2, 1, 0, self);
  scripts\engine\utility::waitframe();
  if(soundexists("emp_battery_explode")) {
    thread scripts\engine\utility::play_sound_in_space("emp_battery_explode", self.origin);
  }

  playFX(scripts\engine\utility::getfx("battery_explosion"), self.origin);
  foreach(var_0A in self.var_109DB) {
    killfxontag(scripts\engine\utility::getfx("impact_shock"), var_0A, "tag_origin");
    scripts\engine\utility::waitframe();
    if(isDefined(var_0A)) {
      var_0A delete();
    }
  }

  killfxontag(scripts\engine\utility::getfx("fuse_shock"), self, "tag_origin");
  scripts\engine\utility::waitframe();
  if(isDefined(self)) {
    self delete();
  }
}

func_6136(var_0, var_1, var_2) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait(var_2);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C528)) {
    return;
  }

  var_3 = 95;
  var_4 = 340;
  if(var_1 <= 90) {
    var_5 = 20;
    var_6 = 90 - var_1 / var_4;
    var_7 = 70 + var_6 * var_5;
  } else {
    var_6 = var_7 - var_3 / var_7;
    var_7 = var_7 * var_4;
  }

  self notify("damage", var_7);
}