/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1782.gsc
*************************************************/

_id_E416() {
  level._effect["base_plasma_smoke"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_smoke");
}

_id_E417(var_0) {
  var_0._id_7177 = [];
  var_1 = 6;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = scripts\cp\utility::_id_0C48("zmb_globproj_zm", (0, 0, 0), (0, 0, 0));
    var_3.owner = self;
    var_3.team = self.team;
    var_3.weapon_name = "zmb_globproj_zm";
    var_3 linkto(var_0, "", (0, 0, 0), (0, 0, 0));
    var_3 hide(1);
    var_0._id_7177[var_0._id_7177.size] = var_3;
    var_3 thread _id_715C();
  }

  thread _id_716E(var_0);
  thread _id_716D(var_0);
  var_0 thread _id_715C();
}

_id_716D(var_0, var_1) {
  var_0 notify("grenadeOnExplode");
  var_0 endon("grenadeOnExplode");
  var_0 thread scripts\cp\utility::_id_A695("death", "end_explode");
  var_0 endon("end_explode");
  var_2 = var_0.owner;
  var_3 = var_0._id_7177;
  var_4 = var_0._id_BA94;
  var_0 waittill("explode", var_5);

  if(!isDefined(var_2)) {
    return;
  }
  _id_7161(var_5, var_1, var_3, var_4);
}

_id_716E(var_0) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);

  if(isDefined(var_1) && isPlayer(var_1)) {
    return;
  }
  thread _id_716D(var_0, var_0.angles);
  return;
}

_id_7161(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = anglestoup(var_1);
    var_7 = vectordot(var_6, (0, 0, 1));
    var_8 = _func_0002(var_7);
    var_4 = var_8 >= 45;
    var_5 = var_8 >= 145;
  }

  var_9 = undefined;
  var_10 = [];

  if(level.teambased) {
    var_9 = scripts\cp\utility::_id_6DC4(scripts\cp\utility::_id_6BE2(self.team));
  } else {
    var_9 = level.characters;
  }

  var_11 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  foreach(var_13 in var_9) {
    var_14 = distancesquared(var_0, var_13.origin);

    if(var_14 > 13225 || var_14 < 7225) {
      continue;
    }
    var_15 = _func_02C1(var_0, var_13.origin, var_11, undefined, 0, "physicsquery_closest");

    if(!isDefined(var_15) || var_15.size > 0) {
      continue;
    }
    var_10[var_10.size] = var_13;
  }

  if(var_10.size > 0) {
    var_10 = scripts\engine\utility::array_randomize(var_10);
  }

  var_17 = 0;
  var_18 = 0;
  var_19 = 1.5;
  var_20 = (0, 0, 0);
  var_21 = (0, 0, 0);

  if(var_4 || var_5) {
    var_20 = var_6 * 115;
    var_21 = var_6 * 3;
  }

  var_22 = randomint(46);
  var_23 = 0;

  for(var_24 = 0; var_24 < var_2.size; var_24++) {
    var_25 = undefined;
    var_26 = randomint(2);

    if(var_26 && var_17 < var_10.size) {
      var_27 = var_10[var_17].origin - var_0;
      var_27 = (var_27[0], var_27[1], 0);
      var_17++;
    } else if(var_23 < 6) {
      var_28 = var_22 + 72.0 * var_23;
      var_29 = 85 + randomint(31);

      if(var_23 == 5) {
        var_29 = 0;
      }

      var_27 = (cos(var_28), sin(var_28), 0) * var_29 + var_20;
      var_23++;
    } else {
      var_30 = randomint(360);
      var_31 = 85 + randomint(31);
      var_27 = (cos(var_30), sin(var_30), 0) * var_31 + var_20;
    }

    if(!var_5) {
      var_27 = var_27 + (0, 0, 200 + randomint(200));
    }

    var_27 = var_27;
    var_32 = var_0 + var_21;
    var_33 = var_2[var_24];
    var_33 show();
    var_33 unlink(1);
    var_33 = scripts\cp\utility::_id_0C48("zmb_globproj_zm", var_32, var_27, undefined, undefined, var_33);
    var_33.owner = self;
    var_33.team = self.team;
    var_33.weapon_name = "zmb_globproj_zm";

    if(var_24 == 0) {
      var_33 setscriptablepartstate("explosion", "active");
    } else {
      var_33 setscriptablepartstate("explosion", "neutral");
    }

    var_33 setscriptablepartstate("trail", "active");
    thread _id_9EFF(var_33, var_19);
  }
}

_id_9EFF(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_2);
  var_3 = 3 + randomfloat(0.15);
  var_0 thread _id_715C(var_1 + var_3);
  var_0 setscriptablepartstate("trail", "neutral");
  var_0 setscriptablepartstate("explosion", "active");
  var_4 = 60;
  var_5 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_4, 60);
  var_5.angles = var_0.angles;
  var_5.owner = self;
  var_5 _meth_80DB();
  var_5 linkto(var_0);
  var_5 hide();
  var_5._id_9EFE = var_0;
  var_5 thread _id_10C21();
  var_6 = vectordot(anglestoup(var_5.angles), (0, 0, 1));

  if(var_6 <= 0) {
    var_0._id_B9DD = "poolWall";
    var_0 setscriptablepartstate("poolWall", "active");
  } else {
    var_0._id_B9DD = "poolGround";
    var_0 setscriptablepartstate("poolGround", "active");
  }

  wait(var_1);
  var_0 notify("extinguish");
  var_0 setscriptablepartstate(var_0._id_B9DD, "activeEnd", 0);
}

_id_715C(var_0) {
  self endon("death");
  self notify("grenadeCleanup");
  self endon("grenadeCleanup");

  if(isDefined(var_0)) {
    self.owner scripts\engine\utility::_id_108AE(var_0, "disconnect");
  } else {
    self.owner waittill("disconnect");
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_9979(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self getentitynumber();
  self notify("mainScriptableCleanup" + var_3);
  self endon("mainScriptableCleanup" + var_3);

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    var_0 waittill("death");
  }

  if(isDefined(var_2)) {
    wait(var_2);
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_10C21() {
  self endon("death");
  self.owner endon("disconnect");
  var_0 = self.owner;
  var_1 = var_0.team;

  if(!isDefined(self._id_F61B)) {
    self._id_F61B = [];
  }

  thread _id_10C22();
  thread _id_F613();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2) && !isagent(var_2)) {
      continue;
    }
    if(var_2 != var_0 && level.teambased && var_2.team == var_1) {
      continue;
    }
    self._id_F61B[var_2 getentitynumber()] = var_2;
    var_2 _id_1097(self._id_9EFE);
  }
}

_id_10C22() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    foreach(var_2, var_1 in self._id_F61B) {
      if(!isDefined(var_1)) {
        self._id_F61B[var_2] = undefined;
        continue;
      }

      self._id_F61B[var_2] = undefined;
      var_1 thread _id_C47F(self._id_9EFE);
    }

    waitframe();
  }
}

_id_F613() {
  self endon("death");
  self._id_9EFE endon("death");
  self._id_9EFE waittill("extinguish");

  foreach(var_1 in self._id_F61B) {
    if(isDefined(var_1)) {
      var_1 thread _id_C47F(self._id_9EFE);
    }
  }

  self delete();
}

_id_B8E4(var_0, var_1) {
  var_2 = spawnfx(scripts\engine\utility::getfx("base_plasma_smoke"), var_0);
  triggerfx(var_2);
  wait(var_1);
  var_2 delete();
}

_id_E687() {
  if(!istrue(self._id_A531)) {
    if(isDefined(self._id_1210) && self._id_1210 != "zombie_brute" && self._id_1210 != "zombie_grey" && self._id_1210 != "superslasher" && self._id_1210 != "slasher" && self._id_1210 != "soldier_agent") {
      self setscriptablepartstate("burning", "active", 1);
    }
  }

  thread _id_10AA1();
}

_id_52E4() {
  self notify("endBurning");
  self._id_2D7C = undefined;

  if(istrue(self._id_A531)) {
    return;
  }
  if(scripts\cp\utility::_id_872B()) {
    if(isDefined(self._id_1210) && self._id_1210 != "zombie_brute" && self._id_1210 != "zombie_grey") {
      self setscriptablepartstate("burning", "inactive", 1);
    }
  } else if(isPlayer(self))
    self setscriptablepartstate("burning", "neutral", 1);
}

_id_10AA1() {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self endon("endBurning");
  level endon("pvpve_round_end");
  thread _id_3877();
  var_0 = self._id_2D7C;
  var_1 = 0;
  var_2 = var_0._id_2D96[0];
  var_3 = var_2.owner;
  var_4 = var_2.weapon_name;

  for(;;) {
    if(_id_8796()) {
      var_0._id_2D92 = var_0._id_2D92 + 0.05;
      var_0._id_2D91 = 0;

      if(var_1 <= 0 && var_0._id_2D96.size > 0) {
        var_5 = _id_6934();
        self dodamage(var_5, var_2.origin, var_3, var_2, "MOD_EXPLOSIVE", var_4);
        var_1 = 0.25;
      } else
        var_1 = var_1 - 0.05;
    } else {
      var_0._id_2D91 = var_0._id_2D91 + 0.05;

      if(var_0._id_2D91 > 0.25) {
        thread _id_52E4();
      }
    }

    wait 0.05;
  }
}

_id_3877() {
  self endon("endBurning");
  self endon("disconnect");
  scripts\engine\utility::_id_10888(self, "death", self, "last_stand", level, "pvpve_round_end");
  thread _id_52E4();
}

_id_1097(var_0) {
  var_1 = self._id_2D7C;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1._id_2D96 = [];
    var_1._id_2D92 = 0;
    var_1._id_2D91 = 0;
    self._id_2D7C = var_1;
  }

  var_2 = var_1._id_2D96.size;

  if(!_id_7549(var_0)) {
    var_1._id_2D96[var_2] = var_0;
  }

  if(var_2 == 0) {
    _id_E687();
  }
}

_id_C47F(var_0) {
  if(isDefined(self._id_2D7C)) {
    var_1 = self._id_2D7C;
    var_2 = [];

    for(var_3 = 0; var_3 > var_1._id_2D96.size; var_3++) {
      var_4 = var_1._id_2D96[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      if(var_4 == var_0) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    if(var_2.size > 0) {
      var_1._id_2D96 = var_2;
    } else {
      _id_52E4();
    }
  }
}

_id_7549(var_0) {
  if(isDefined(self._id_2D7C)) {
    var_1 = self._id_2D7C;

    foreach(var_3 in var_1._id_2D96) {
      if(var_3 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_8796() {
  return isDefined(self._id_2D7C) && isDefined(self._id_2D7C._id_2D96) && self._id_2D7C._id_2D96.size > 0;
}

_id_6934() {
  var_0 = self._id_2D7C._id_2D92;
  var_1 = undefined;

  if(var_0 > 1.0) {
    var_1 = 30;
  } else if(var_0 > 0.5) {
    var_1 = 20;
  } else {
    var_1 = 10;
  }

  return var_1;
}