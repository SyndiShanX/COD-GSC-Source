/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3839.gsc
**************************************/

_id_23FA() {
  level._effect["railgun_fire"] = loadfx("vfx/iw7/core/vehicle/mons/vfx_muzflash_cannon_mons.vfx");
  level._effect["asteroid_explosion_main"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_titan_explosion_large_cap");
}

_id_FA23(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_6664 = var_3 scripts\sp\utility::_id_7A8F();
    var_3._id_11168 = var_3 _id_7A98();

    foreach(var_5 in var_3._id_6664) {
      if(isDefined(var_5.model) && var_5.model == "ship_exterior_ca_railgun_a_25p") {
        var_3.turret = var_5;
      }
    }

    foreach(var_8 in var_3._id_11168) {
      if(var_8.targetname == "asteroid_root") {
        var_3._id_23EC = var_8;
      }
    }

    if(!isDefined(var_3.turret._id_6EBF)) {
      var_3.turret thread _id_9537();
    }

    if(isDefined(var_3._id_23EC.script_noteworthy) && var_3._id_23EC.script_noteworthy == "fx_chained") {
      var_3._id_23EC thread _id_2400();
    } else {
      var_3._id_23EC thread _id_2401();
    }

    var_3 thread _id_9703();
  }
}

_id_7A98() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_1[var_2], "script_linkname");

      if(var_3.size == 1) {
        var_0[var_0.size] = var_3[0];
        continue;
      }

      if(var_3.size > 1) {
        foreach(var_5 in var_3) {
          var_0[var_0.size] = var_5;
        }
      }
    }
  }

  return var_0;
}

_id_9703() {
  self waittill("trigger");
  self.turret notify("fire", self._id_23EC);
  wait 0.5;
}

_id_9537() {
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_6EBF = var_0 scripts\engine\utility::spawn_tag_origin();
  self._id_6EBF linkTo(self);
  var_1 = 3;

  for(;;) {
    self waittill("fire", var_2);
    _id_DC2A(var_2.origin);
    var_2 scripts\sp\utility::_id_137DF(0.8, 1, 1, 8);
    wait 0.75;
    playFX(scripts\engine\utility::getfx("railgun_fire"), self._id_6EBF.origin, anglesToForward(self._id_6EBF.angles));
    self playSound("sa_asteroid_railgun_fire");
    var_2 notify("hit");
    wait(var_1);
  }
}

_id_DC2A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  self rotateTo(vectortoangles(var_0 - self.origin), var_1, var_1 * 0.4, var_1 * 0.4);
  self waittill("rotatedone");
}

_id_2401() {
  self._id_E6E5 = scripts\engine\utility::spawn_tag_origin();
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self._id_6999 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "explode_pt") {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3 linkTo(self._id_E6E5);
      self._id_6999[self._id_6999.size] = var_3;
    }
  }

  self._id_3F2C = getEntArray(self.target, "targetname");

  foreach(var_6 in self._id_3F2C) {
    var_6 linkTo(self._id_E6E5);
  }

  self._id_321D = 2;
  self waittill("hit");
  self._id_E6E5 notify("stop_rotation");

  foreach(var_3 in self._id_6999) {
    var_3 thread _id_23FF(self._id_321D);
  }

  foreach(var_6 in self._id_3F2C) {
    var_6 unlink();
    thread _id_56AA(var_6, 9, 4096);
  }

  playFX(scripts\engine\utility::getfx("asteroid_explosion_main"), self.origin);
}

_id_2400() {
  self waittill("hit");

  foreach(var_1 in scripts\engine\utility::getStructArray(self.target, "targetname")) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "main_detonation") {
      playFX(scripts\engine\utility::getfx("asteroid_explosion_main"), var_1.origin);
      continue;
    }

    var_1 thread _id_23EE();
  }

  foreach(var_4 in getEntArray(self.target, "targetname")) {
    thread _id_56AA(var_4, 20, 4096);
  }
}

_id_23FB() {
  self endon("death");
  self endon("stop_rotation");
  var_0 = 10;
  var_1 = 3;
  var_2 = 0;
  var_3 = randomfloat(var_0);
  var_4 = 0;

  for(;;) {
    self rotateby((var_2, var_3, var_4), var_1, 0, 0);
    self waittill("rotatedone");
  }
}

_id_23FF(var_0) {
  wait(randomfloat(var_0));
  playFX(scripts\engine\utility::getfx("asteroid_explosion_main"), self.origin);
  self unlink();
  self delete();
}

_id_23EE() {
  var_0 = self;

  while(isDefined(var_0)) {
    wait(0.3 + randomfloat(0.45));
    playFX(scripts\engine\utility::getfx("asteroid_explosion_main"), var_0.origin);

    if(isDefined(var_0.target)) {
      var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      continue;
    }

    var_0 = undefined;
  }
}

_id_56AA(var_0, var_1, var_2) {
  if(isDefined(var_0.target)) {
    var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_0 moveTo(var_3.origin, var_1, var_1 * 0.2, var_1 * 0.6);
  } else
    var_0 moveTo(var_0.origin + vectorNormalize(var_0.origin - self.origin) * var_2, var_1, var_1 * 0.2, var_1 * 0.6);
}