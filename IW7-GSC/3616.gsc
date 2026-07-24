/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3616.gsc
**************************************/

_id_DE0F() {
  precachemodel("misc_exterior_oxygen_barrel_large");
  precachemodel("misc_exterior_oxygen_barrel_large_zerog");
  precachemodel("vfx_debris_oxygen_barrel_large_top");
  precachemodel("vfx_debris_oxygen_barrel_large_bottom");
  level._effect["barrel_flame_top"] = loadfx("vfx/iw7/levels/moon/scripted/scriptables/oxygen_tank/vfx_oxygen_tank_spewing_flames.vfx");
  level._effect["barrel_flame_small"] = loadfx("vfx/iw7/prop/vfx_dest_barrel_fire_sm.vfx");
  level._effect["barrel_explosion"] = loadfx("vfx/iw7/core/expl/vfx_red_barrel_oxygen_01.vfx");
  level._effect["barrel_explosion_zerog"] = loadfx("vfx/iw7/prop/vfx_misc_exterior_oxygenbarrel_large_zerog.vfx");
  level._effect["barrel_fire"] = loadfx("vfx/iw7/prop/vfx_dest_barrel_fire.vfx");
  var_0 = getEntArray("phys_barrel_destructible", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_DE0C();
  }
}

_id_DE0C() {
  self endon("barrel_death");
  self endon("barrel_delete");
  _id_0E1D::_id_2840("red", 120, 350, 9100, 15000, 80, 28);
  thread _id_DE0D();
  var_0 = 3;
  var_1 = 0;
  var_2 = 120;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_4) && isai(var_4)) {
      continue;
    }
    if(isDefined(var_4) && isDefined(var_4._id_9D62)) {
      continue;
    }
    if(isDefined(var_12) && scripts\engine\utility::weaponclass(var_12) == "sniper") {
      var_3 = 999999;
      var_0 = 0;
    }

    var_2 = int(var_2 - var_3);

    if(var_2 <= 0 && !isDefined(self._id_C528)) {
      var_2 = 50;
    }

    if(var_2 <= 0) {
      break;
    }

    self._id_2836 = var_2;

    if(var_2 <= 50) {
      if(!var_1) {
        if(soundexists("o2_barrel_fire")) {
          thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_fire");
        }

        playFXOnTag(scripts\engine\utility::getfx("barrel_fire"), self, "misc_exterior_oxygen_barrel_large");
        playFXOnTag(scripts\engine\utility::getfx("barrel_flame_top"), self, "tag_valve");
        var_1 = 1;
        self._id_C528 = 1;
      }

      var_13 = var_2 / 50;
      var_0 = var_0 * var_13;
      thread _id_0E1D::_id_2835(var_0);
    }

    if(isDefined(var_5)) {
      var_14 = length(var_5);

      if(var_14 > 20) {
        var_15 = vectorNormalize(var_5);
        var_16 = 20;

        if(isDefined(var_7) && var_7 == "MOD_IMPACT") {
          var_16 = 3;
        }

        var_5 = var_15 * var_16;
      }

      self physicslaunchserver(var_6, var_5 * 1000);
    }

    if(!isDefined(var_7)) {
      continue;
    }
    var_17 = strtok(var_7, "_");

    if(!scripts\engine\utility::array_contains(var_17, "BULLET")) {
      continue;
    }
    var_18 = scripts\engine\utility::spawn_tag_origin(var_6);
    var_19 = vectorNormalize(self.origin - var_6);
    var_20 = vectortoangles(var_19 * -1);
    var_18.angles = scripts\engine\utility::flat_angle(var_20);
    var_18 linkTo(self);

    if(soundexists("o2_barrel_hiss_loop")) {
      var_18 thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_hiss_loop");
    }

    playFXOnTag(scripts\engine\utility::getfx("barrel_flame_small"), var_18, "tag_origin");
    self._id_109DB = scripts\engine\utility::array_add(self._id_109DB, var_18);
  }

  while(isDefined(self._id_5945)) {
    scripts\engine\utility::waitframe();
  }

  self notify("barrel_death");
}

_id_DE0D() {
  self endon("barrel_delete");
  self waittill("barrel_death");
  physicsexplosionsphere(self.origin, self._id_CAF6, 0, 2.0);
  thread _id_0B1D::_id_DBDB(self.origin + (0, 0, 25), 0.2);
  earthquake(0.5, 0.8, self.origin, 700);
  thread scripts\sp\utility::_id_54EF(self.origin);
  thread _id_0E1D::_id_2831(350, self.origin);
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
      var_3 thread _id_DE0E(self.origin, var_4, var_7);
    }
  }

  var_9 = scripts\sp\utility::_id_81FF();

  foreach(var_11 in var_9) {
    var_12 = 400;
    var_13 = 370;

    if(isDefined(var_11.script_team) && var_11.script_team == "allies") {
      continue;
    }
    var_14 = distance(self.origin, var_11.origin);
    var_14 = 0;

    if(var_14 <= 25000) {
      var_6 = var_14 / 250 * 100;
      var_12 = var_12 - var_6 * var_13;

      if(getdvarint("barrel_debug")) {
        iprintln("BARREL DID " + var_12 + " TO VEH");
      }

      var_11 dodamage(var_12, self.origin, self, self, "MOD_EXPLOSIVE");
    }
  }

  var_16 = getaiarray("axis");

  foreach(var_18 in var_16) {
    var_12 = 400;
    var_13 = 370;

    if(!isDefined(var_18.subclass)) {
      continue;
    }
    if(var_18.subclass == "C6") {
      var_12 = var_12 + 20;
    }

    var_19 = distance(self.origin, var_18.origin);

    if(var_19 <= 250) {
      var_6 = var_19 / 250;
      var_12 = var_12 - var_6 * var_13;

      if(getdvarint("barrel_debug")) {
        iprintln("BARREL DID " + var_12 + " TO AI");
      }

      var_18 dodamage(var_12, self.origin, self, self, "MOD_EXPLOSIVE");
    }
  }

  var_21 = distance(self.origin, level.player.origin);

  if(var_21 <= 350) {
    var_6 = var_21 / 350;
    var_13 = 420;
    var_12 = 420 - var_6 * var_13;

    if(getdvarint("barrel_debug")) {
      iprintln("BARREL DID " + var_12 + " TO PLAYER");
    }

    if(!level.player scripts\sp\utility::_id_65DB("player_retract_shield_active")) {
      level.player dodamage(var_12, self.origin, self, self, "MOD_EXPLOSIVE");
    }
  }

  radiusdamage(self.origin, 2, 1, 0, self);
  scripts\engine\utility::waitframe();

  if(soundexists("o2_barrel_explode")) {
    thread scripts\engine\utility::play_sound_in_space("o2_barrel_explode", self.origin);
  }

  if(level.player scripts\sp\utility::_id_65DF("zero_gravity") && level.player scripts\sp\utility::_id_65DB("zero_gravity")) {
    playFX(scripts\engine\utility::getfx("barrel_explosion_zerog"), self.origin);
  } else {
    playFX(scripts\engine\utility::getfx("barrel_explosion"), self.origin);
  }

  foreach(var_23 in self._id_109DB) {
    killfxontag(scripts\engine\utility::getfx("barrel_flame_small"), var_23, "tag_origin");
    scripts\engine\utility::waitframe();

    if(isDefined(var_23)) {
      var_23 delete();
    }
  }

  killfxontag(scripts\engine\utility::getfx("barrel_fire"), self, "misc_exterior_oxygen_barrel_large");
  killfxontag(scripts\engine\utility::getfx("barrel_flame_top"), self, "tag_valve");
  scripts\engine\utility::waitframe();

  if(isDefined(self)) {
    self hide();
    thread _id_50B2(5);
  }
}

_id_50B2(var_0) {
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_DE0E(var_0, var_1, var_2) {
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