/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3615.gsc
************************/

func_6137() {
  level._effect["impact_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_thegreatzapper.vfx");
  level._effect["fuse_shock"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._effect["battery_explosion"] = loadfx("vfx\iw7\core\equipment\emp\vfx_equip_emp_a2_barrel_model.vfx");
  var_00 = getEntArray("phys_battery_destructible", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread func_6134();
  }
}

func_6134() {
  self endon("barrel_death");
  self endon("barrel_delete");
  lib_0E1D::func_2840("emp", 120, 350, 9100, 15000, 80, 28);
  thread func_6135();
  var_00 = 3;
  var_01 = 0;
  var_02 = 120;
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    if(isDefined(var_06) && isai(var_06)) {
      continue;
    }

    if(isDefined(var_06) && isDefined(var_06.var_9D62)) {
      continue;
    }

    if(isDefined(var_0E) && scripts\engine\utility::weaponclass(var_0E) == "sniper") {
      var_05 = 999999;
      var_00 = 0;
    }

    var_02 = int(var_02 - var_05);
    if(var_02 <= 0 && !isDefined(self.var_C528)) {
      var_02 = 50;
    }

    if(var_02 <= 0) {
      break;
    }

    self.var_2836 = var_02;
    if(var_02 <= 50) {
      if(!var_01) {
        if(!var_04) {
          var_04 = 1;
          if(soundexists("emp_battery_damaged_warning_lp")) {
            thread scripts\sp\utility::play_loop_sound_on_tag("emp_battery_damaged_warning_lp", "tag_origin", 1, 1);
          }
        }

        playFXOnTag(scripts\engine\utility::getfx("fuse_shock"), self, "tag_origin");
        var_01 = 1;
        self.var_C528 = 1;
      }

      var_0F = var_02 / 50;
      var_00 = var_00 * var_0F;
      thread lib_0E1D::func_2835(var_00);
    }

    if(isDefined(var_07)) {
      var_10 = length(var_07);
      if(var_10 > 20) {
        var_11 = vectornormalize(var_07);
        var_12 = 20;
        if(isDefined(var_09) && var_09 == "MOD_IMPACT") {
          var_12 = 3;
        }

        var_07 = var_11 * var_12;
      }

      self physicslaunchserver(var_08, var_07 * 1000);
    }

    if(!isDefined(var_09)) {
      continue;
    }

    var_13 = strtok(var_09, "_");
    if(!scripts\engine\utility::array_contains(var_13, "BULLET")) {
      continue;
    }

    var_14 = scripts\engine\utility::spawn_tag_origin(var_08);
    var_15 = vectornormalize(self.origin - var_08);
    var_16 = vectortoangles(var_15 * -1);
    var_14.angles = scripts\engine\utility::flat_angle(var_16);
    var_14 linkto(self);
    if(!var_03) {
      var_03 = 1;
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
  var_00 = 0.3;
  var_01 = sortbydistance(level.var_CAF7, self.origin);
  foreach(var_03 in var_01) {
    if(var_03 == self) {
      continue;
    }

    var_04 = distance(self.origin, var_03.origin);
    if(var_04 > self.var_CAF6) {
      continue;
    }

    var_05 = self.var_CAF6 - var_04;
    var_06 = var_05 / self.var_CAF6;
    var_07 = var_00 * var_06;
    if(var_04 <= self.var_CAF6) {
      var_03 thread lib_0E1D::func_2837(self.origin, var_04, var_07);
    }

    if(var_04 <= 340) {
      var_03 thread func_6136(self.origin, var_04, var_07);
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

func_6136(param_00, param_01, param_02) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait(param_02);
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C528)) {
    return;
  }

  var_03 = 95;
  var_04 = 340;
  if(param_01 <= 90) {
    var_05 = 20;
    var_06 = 90 - param_01 / var_04;
    var_07 = 70 + var_06 * var_05;
  } else {
    var_06 = var_07 - var_03 / var_07;
    var_07 = var_07 * var_04;
  }

  self notify("damage", var_07);
}