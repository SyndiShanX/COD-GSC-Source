/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3615.gsc
**************************************/

_id_6137() {
  level._effect["impact_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_thegreatzapper.vfx");
  level._effect["fuse_shock"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_gren_hit_c6_kill.vfx");
  level._effect["battery_explosion"] = loadfx("vfx/iw7/core/equipment/emp/vfx_equip_emp_a2_barrel_model.vfx");
  var_0 = getEntArray("phys_battery_destructible", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_6134();
  }
}

_id_6134() {
  self endon("barrel_death");
  self endon("barrel_delete");
  _id_0E1D::_id_2840("emp", 120, 350, 9100, 15000, 80, 28);
  thread _id_6135();
  var_0 = 3;
  var_1 = 0;
  var_2 = 120;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_6) && isai(var_6)) {
      continue;
    }
    if(isDefined(var_6) && isDefined(var_6._id_9D62)) {
      continue;
    }
    if(isDefined(var_14) && scripts\engine\utility::weaponclass(var_14) == "sniper") {
      var_5 = 999999;
      var_0 = 0;
    }

    var_2 = int(var_2 - var_5);

    if(var_2 <= 0 && !isDefined(self._id_C528)) {
      var_2 = 50;
    }

    if(var_2 <= 0) {
      break;
    }

    self._id_2836 = var_2;

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
        self._id_C528 = 1;
      }

      var_15 = var_2 / 50;
      var_0 = var_0 * var_15;
      thread _id_0E1D::_id_2835(var_0);
    }

    if(isDefined(var_7)) {
      var_16 = length(var_7);

      if(var_16 > 20) {
        var_17 = vectorNormalize(var_7);
        var_18 = 20;

        if(isDefined(var_9) && var_9 == "MOD_IMPACT") {
          var_18 = 3;
        }

        var_7 = var_17 * var_18;
      }

      self physicslaunchserver(var_8, var_7 * 1000);
    }

    if(!isDefined(var_9)) {
      continue;
    }
    var_19 = strtok(var_9, "_");

    if(!scripts\engine\utility::array_contains(var_19, "BULLET")) {
      continue;
    }
    var_20 = scripts\engine\utility::spawn_tag_origin(var_8);
    var_21 = vectorNormalize(self.origin - var_8);
    var_22 = vectortoangles(var_21 * -1);
    var_20.angles = scripts\engine\utility::flat_angle(var_22);
    var_20 linkTo(self);

    if(!var_3) {
      var_3 = 1;

      if(soundexists("emp_battery_damaged_lp")) {
        var_20 thread scripts\sp\utility::play_loop_sound_on_tag("emp_battery_damaged_lp", "tag_origin", 1, 1);
      }
    }

    playFXOnTag(scripts\engine\utility::getfx("impact_shock"), var_20, "tag_origin");
    self._id_109DB = scripts\engine\utility::array_add(self._id_109DB, var_20);
  }

  while(isDefined(self._id_5945)) {
    scripts\engine\utility::waitframe();
  }

  self notify("barrel_death");
}

_id_6135() {
  self endon("barrel_delete");
  self waittill("barrel_death");
  physicsexplosionsphere(self.origin, self._id_CAF6, 0, 2.0);
  earthquake(0.5, 0.8, self.origin, 700);
  thread _id_0E25::_id_6133(self);
  thread _id_0B1D::_id_DBDB(self.origin);
  var_0 = 0.3;
  var_1 = sortbydistance(level._id_CAF7, self.origin);

  foreach(var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }
    var_4 = distance(self.origin, var_3.origin);

    if(var_4 > self._id_CAF6) {
      continue;
    }
    var_5 = self._id_CAF6 - var_4;
    var_6 = var_5 / self._id_CAF6;
    var_7 = var_0 * var_6;

    if(var_4 <= self._id_CAF6) {
      var_3 thread _id_0E1D::_id_2837(self.origin, var_4, var_7);
    }

    if(var_4 <= 340) {
      var_3 thread _id_6136(self.origin, var_4, var_7);
    }
  }

  radiusdamage(self.origin, 2, 1, 0, self);
  scripts\engine\utility::waitframe();

  if(soundexists("emp_battery_explode")) {
    thread scripts\engine\utility::play_sound_in_space("emp_battery_explode", self.origin);
  }

  playFX(scripts\engine\utility::getfx("battery_explosion"), self.origin);

  foreach(var_10 in self._id_109DB) {
    killfxontag(scripts\engine\utility::getfx("impact_shock"), var_10, "tag_origin");
    scripts\engine\utility::waitframe();

    if(isDefined(var_10)) {
      var_10 delete();
    }
  }

  killfxontag(scripts\engine\utility::getfx("fuse_shock"), self, "tag_origin");
  scripts\engine\utility::waitframe();

  if(isDefined(self)) {
    self delete();
  }
}

_id_6136(var_0, var_1, var_2) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait(var_2);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_C528)) {
    return;
  }
  var_3 = 95;
  var_4 = 340;

  if(var_1 <= 90) {
    var_5 = 20;
    var_6 = (90 - var_1) / var_4;
    var_7 = 70 + var_6 * var_5;
  } else {
    var_6 = (var_4 - var_1) / var_4;
    var_7 = var_6 * var_3;
  }

  self notify("damage", var_7);
}