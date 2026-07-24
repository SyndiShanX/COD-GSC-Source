/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2662.gsc
**************************************/

splashgrenadeinit() {
  level._effect["base_plasma_smoke"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_smoke");
}

splashgrenadeused(var_0) {
  var_0.grenades = [];
  var_1 = 6;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", (0, 0, 0), (0, 0, 0));
    var_3.owner = self;
    var_3.team = self.team;
    var_3.weapon_name = "zmb_globproj_zm";
    var_3 linkTo(var_0, "", (0, 0, 0), (0, 0, 0));
    var_3 hide(1);
    var_0.grenades[var_0.grenades.size] = var_3;
    var_3 thread _id_85B4();
  }

  thread _id_85CE(var_0);
  thread _id_85CD(var_0);
  var_0 thread _id_85B4();
}

_id_85CD(var_0, var_1) {
  var_0 notify("grenadeOnExplode");
  var_0 endon("grenadeOnExplode");
  var_0 thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  var_0 endon("end_explode");
  var_2 = var_0.owner;
  var_3 = var_0.grenades;
  var_4 = var_0.power;
  var_0 waittill("explode", var_5);

  if(!isDefined(var_2)) {
    return;
  }
  _id_85B9(var_5, var_1, var_3, var_4);
}

_id_85CE(var_0) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);

  if(isDefined(var_1) && isPlayer(var_1)) {
    return;
  }
  thread _id_85CD(var_0, var_0.angles);
  return;
}

_id_85B9(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = anglestoup(var_1);
    var_7 = vectordot(var_6, (0, 0, 1));
    var_8 = acos(var_7);
    var_4 = var_8 >= 45;
    var_5 = var_8 >= 145;
  }

  var_9 = undefined;
  var_10 = [];

  if(level.teambased) {
    var_9 = scripts\cp\utility::getteamarray(scripts\cp\utility::getotherteam(self.team));
  } else {
    var_9 = level.characters;
  }

  var_11 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  foreach(var_13 in var_9) {
    if(!isDefined(var_13) || var_13 == self || !scripts\cp\utility::isreallyalive(var_13)) {
      continue;
    }
    var_14 = distancesquared(var_0, var_13.origin);

    if(var_14 > 13225 || var_14 < 7225) {
      continue;
    }
    var_15 = physics_raycast(var_0, var_13.origin, var_11, undefined, 0, "physicsquery_closest");

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
    var_33 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", var_32, var_27, undefined, undefined, var_33);
    var_33.owner = self;
    var_33.team = self.team;
    var_33.weapon_name = "zmb_globproj_zm";

    if(var_24 == 0) {
      var_33 setscriptablepartstate("explosion", "active");
    } else {
      var_33 setscriptablepartstate("explosion", "neutral");
    }

    var_33 setscriptablepartstate("trail", "active");
    thread _id_B79A(var_33, var_19);
  }
}

_id_B79A(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_2);
  var_3 = 3 + randomfloat(0.15);
  var_0 thread _id_85B4(var_1 + var_3);
  var_0 setscriptablepartstate("trail", "neutral");
  var_0 setscriptablepartstate("explosion", "active");
  var_4 = 60;
  var_5 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_4, 60);
  var_5.angles = var_0.angles;
  var_5.owner = self;
  var_5 enablelinkTo();
  var_5 linkTo(var_0);
  var_5 hide();
  var_5._id_B799 = var_0;
  var_5 thread _id_13B91();
  var_6 = vectordot(anglestoup(var_5.angles), (0, 0, 1));

  if(var_6 <= 0) {
    var_0.poolscriptablepart = "poolWall";
    var_0 setscriptablepartstate("poolWall", "active");
  } else {
    var_0.poolscriptablepart = "poolGround";
    var_0 setscriptablepartstate("poolGround", "active");
  }

  wait(var_1);
  var_0 notify("extinguish");
  var_0 setscriptablepartstate(var_0.poolscriptablepart, "activeEnd", 0);
}

_id_85B4(var_0) {
  self endon("death");
  self notify("grenadeCleanup");
  self endon("grenadeCleanup");

  if(isDefined(var_0)) {
    self.owner scripts\engine\utility::waittill_any_timeout_no_endon_death(var_0, "disconnect");
  } else {
    self.owner waittill("disconnect");
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_B24D(var_0, var_1, var_2) {
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

_id_13B91() {
  self endon("death");
  self.owner endon("disconnect");
  var_0 = self.owner;
  var_1 = var_0.team;

  if(!isDefined(self._id_127C0)) {
    self._id_127C0 = [];
  }

  thread _id_13B93();
  thread _id_127B9();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2) && !isagent(var_2)) {
      continue;
    }
    if(!scripts\cp\utility::isreallyalive(var_2)) {
      continue;
    }
    if(var_2 != var_0 && level.teambased && var_2.team == var_1) {
      continue;
    }
    self._id_127C0[var_2 getentitynumber()] = var_2;
    var_2 _id_17B0(self._id_B799);
  }
}

_id_13B93() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    foreach(var_2, var_1 in self._id_127C0) {
      if(!isDefined(var_1)) {
        self._id_127C0[var_2] = undefined;
        continue;
      }

      if(!scripts\cp\utility::isreallyalive(var_1) || !var_1 istouching(self)) {
        self._id_127C0[var_2] = undefined;
        var_1 thread _id_E0DC(self._id_B799);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_127B9() {
  self endon("death");
  self._id_B799 endon("death");
  self._id_B799 waittill("extinguish");

  foreach(var_1 in self._id_127C0) {
    if(isDefined(var_1)) {
      var_1 thread _id_E0DC(self._id_B799);
    }
  }

  self delete();
}

_id_D51E(var_0, var_1) {
  var_2 = spawnfx(scripts\engine\utility::getfx("base_plasma_smoke"), var_0);
  triggerfx(var_2);
  wait(var_1);
  var_2 delete();
}

_id_10D77() {
  if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey" && self.agent_type != "superslasher" && self.agent_type != "slasher") {
    self setscriptablepartstate("burning", "active", 1);
  }

  thread _id_139C0();
}

_id_6312() {
  self notify("endBurning");
  self._id_3291 = undefined;

  if(scripts\cp\utility::is_zombie_agent()) {
    if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey") {
      self setscriptablepartstate("burning", "inactive", 1);
    }
  } else if(isPlayer(self))
    self setscriptablepartstate("burning", "neutral", 1);
}

_id_139C0() {
  self endon("death");
  self endon("disconnect");
  self endon("endBurning");
  thread _id_40E8();
  var_0 = self._id_3291;
  var_1 = 0;

  for(;;) {
    if(_id_9D76()) {
      var_0._id_32A1 = var_0._id_32A1 + 0.05;
      var_0._id_32A0 = 0;

      if(var_1 <= 0 && var_0._id_32A4.size > 0) {
        var_2 = var_0._id_32A4[0];
        var_3 = var_2.owner;
        var_4 = var_2.weapon_name;
        var_5 = _id_7E11();
        self dodamage(var_5, var_2.origin, var_3, var_2, "MOD_EXPLOSIVE", var_4);
        var_1 = 0.25;
      } else
        var_1 = var_1 - 0.05;
    } else {
      var_0._id_32A0 = var_0._id_32A0 + 0.05;

      if(var_0._id_32A0 > 0.25) {
        thread _id_6312();
      }
    }

    wait 0.05;
  }
}

_id_40E8() {
  self endon("endBurning");
  self endon("disconnect");
  self waittill("death");
  thread _id_6312();
}

_id_17B0(var_0) {
  var_1 = self._id_3291;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1._id_32A4 = [];
    var_1._id_32A1 = 0;
    var_1._id_32A0 = 0;
    self._id_3291 = var_1;
  }

  var_2 = var_1._id_32A4.size;

  if(!_id_8BD9(var_0)) {
    var_1._id_32A4[var_2] = var_0;
  }

  if(var_2 == 0) {
    _id_10D77();
  }
}

_id_E0DC(var_0) {
  if(isDefined(self._id_3291)) {
    var_1 = self._id_3291;
    var_2 = [];

    for(var_3 = 0; var_3 > var_1._id_32A4.size; var_3++) {
      var_4 = var_1._id_32A4[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      if(var_4 == var_0) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    if(var_2.size > 0) {
      var_1._id_32A4 = var_2;
    } else {
      _id_6312();
    }
  }
}

_id_8BD9(var_0) {
  if(isDefined(self._id_3291)) {
    var_1 = self._id_3291;

    foreach(var_3 in var_1._id_32A4) {
      if(var_3 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_9D76() {
  return isDefined(self._id_3291) && isDefined(self._id_3291._id_32A4) && self._id_3291._id_32A4.size > 0;
}

_id_7E11() {
  var_0 = self._id_3291._id_32A1;
  var_1 = undefined;

  if(var_0 > 1.0) {
    var_1 = 25;
  } else if(var_0 > 0.5) {
    var_1 = 25;
  } else {
    var_1 = 25;
  }

  return var_1;
}