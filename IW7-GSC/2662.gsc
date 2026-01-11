/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2662.gsc
***************************************/

splashgrenadeinit() {
  level._effect["base_plasma_smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_smoke");
}

splashgrenadeused(var_00) {
  var_0.grenades = [];
  var_01 = 6;

  for(var_02 = 0; var_02 < var_01; var_2++) {
    var_03 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", (0, 0, 0), (0, 0, 0));
    var_3.owner = self;
    var_3.team = self.team;
    var_3.weapon_name = "zmb_globproj_zm";
    var_03 linkto(var_00, "", (0, 0, 0), (0, 0, 0));
    var_03 hide(1);
    var_0.grenades[var_0.grenades.size] = var_03;
    var_03 thread istrialversion();
  }

  thread func_85CE(var_00);
  thread func_85CD(var_00);
  var_00 thread istrialversion();
}

func_85CD(var_00, var_01) {
  var_00 notify("grenadeOnExplode");
  var_00 endon("grenadeOnExplode");
  var_00 thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  var_00 endon("end_explode");
  var_02 = var_0.owner;
  var_03 = var_0.grenades;
  var_04 = var_0.power;
  var_00 waittill("explode", var_05);

  if(!isDefined(var_02)) {
    return;
  }
  setinteractwithethereal(var_05, var_01, var_03, var_04);
}

func_85CE(var_00) {
  var_00 endon("death");
  var_00 waittill("missile_stuck", var_01);

  if(isDefined(var_01) && isplayer(var_01)) {
    return;
  }
  thread func_85CD(var_00, var_0.angles);
  return;
}

setinteractwithethereal(var_00, var_01, var_02, var_03) {
  var_04 = 0;
  var_05 = 0;
  var_06 = undefined;

  if(isDefined(var_01)) {
    var_06 = anglestoup(var_01);
    var_07 = vectordot(var_06, (0, 0, 1));
    var_08 = acos(var_07);
    var_04 = var_08 >= 45;
    var_05 = var_08 >= 145;
  }

  var_09 = undefined;
  var_10 = [];

  if(level.teambased) {
    var_09 = scripts\cp\utility::getteamarray(scripts\cp\utility::getotherteam(self.team));
  }
  else {
    var_09 = level.characters;
  }

  var_11 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  foreach(var_13 in var_09) {
    if(!isDefined(var_13) || var_13 == self || !scripts\cp\utility::isreallyalive(var_13)) {
      continue;
    }
    var_14 = distancesquared(var_00, var_13.origin);

    if(var_14 > 13225 || var_14 < 7225) {
      continue;
    }
    var_15 = physics_raycast(var_00, var_13.origin, var_11, undefined, 0, "physicsquery_closest");

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

  if(var_04 || var_05) {
    var_20 = var_06 * 115;
    var_21 = var_06 * 3;
  }

  var_22 = randomint(46);
  var_23 = 0;

  for(var_24 = 0; var_24 < var_2.size; var_24++) {
    var_25 = undefined;
    var_26 = randomint(2);

    if(var_26 && var_17 < var_10.size) {
      var_27 = var_10[var_17].origin - var_00;
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

    if(!var_05) {
      var_27 = var_27 + (0, 0, 200 + randomint(200));
    }

    var_27 = var_27;
    var_32 = var_00 + var_21;
    var_33 = var_2[var_24];
    var_33 show();
    var_33 unlink(1);
    var_33 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", var_32, var_27, undefined, undefined, var_33);
    var_33.owner = self;
    var_33.team = self.team;
    var_33.weapon_name = "zmb_globproj_zm";

    if(var_24 == 0) {
      var_33 setscriptablepartstate("explosion", "active");
    }
    else {
      var_33 setscriptablepartstate("explosion", "neutral");
    }

    var_33 setscriptablepartstate("trail", "active");
    thread func_B79A(var_33, var_19);
  }
}

func_B79A(var_00, var_01) {
  var_00 endon("death");
  var_00 waittill("missile_stuck", var_02);
  var_03 = 3 + randomfloat(0.15);
  var_00 thread istrialversion(var_01 + var_03);
  var_00 setscriptablepartstate("trail", "neutral");
  var_00 setscriptablepartstate("explosion", "active");
  var_04 = 60;
  var_05 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_04, 60);
  var_5.angles = var_0.angles;
  var_5.owner = self;
  var_05 getrankxp();
  var_05 linkto(var_00);
  var_05 hide();
  var_5.func_B799 = var_00;
  var_05 thread func_13B91();
  var_06 = vectordot(anglestoup(var_5.angles), (0, 0, 1));

  if(var_06 <= 0) {
    var_0.poolscriptablepart = "poolWall";
    var_00 setscriptablepartstate("poolWall", "active");
  } else {
    var_0.poolscriptablepart = "poolGround";
    var_00 setscriptablepartstate("poolGround", "active");
  }

  wait(var_01);
  var_00 notify("extinguish");
  var_00 setscriptablepartstate(var_0.poolscriptablepart, "activeEnd", 0);
}

istrialversion(var_00) {
  self endon("death");
  self notify("grenadeCleanup");
  self endon("grenadeCleanup");

  if(isDefined(var_00)) {
    self.owner scripts\engine\utility::waittill_any_timeout_no_endon_death(var_00, "disconnect");
  }
  else {
    self.owner waittill("disconnect");
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_B24D(var_00, var_01, var_02) {
  self endon("death");
  var_03 = self getentitynumber();
  self notify("mainScriptableCleanup" + var_03);
  self endon("mainScriptableCleanup" + var_03);

  if(isDefined(var_01)) {
    wait(var_01);
  }
  else {
    var_00 waittill("death");
  }

  if(isDefined(var_02)) {
    wait(var_02);
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_13B91() {
  self endon("death");
  self.owner endon("disconnect");
  var_00 = self.owner;
  var_01 = var_0.team;

  if(!isDefined(self.func_127C0)) {
    self.func_127C0 = [];
  }

  thread func_13B93();
  thread func_127B9();

  for(;;) {
    self waittill("trigger", var_02);

    if(!isplayer(var_02) && !isagent(var_02)) {
      continue;
    }
    if(!scripts\cp\utility::isreallyalive(var_02)) {
      continue;
    }
    if(var_02 != var_00 && level.teambased && var_2.team == var_01) {
      continue;
    }
    self.func_127C0[var_02 getentitynumber()] = var_02;
    var_02 func_17B0(self.func_B799);
  }
}

func_13B93() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    foreach(var_02, var_01 in self.func_127C0) {
      if(!isDefined(var_01)) {
        self.func_127C0[var_02] = undefined;
        continue;
      }

      if(!scripts\cp\utility::isreallyalive(var_01) || !var_01 istouching(self)) {
        self.func_127C0[var_02] = undefined;
        var_01 thread func_E0DC(self.func_B799);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_127B9() {
  self endon("death");
  self.func_B799 endon("death");
  self.func_B799 waittill("extinguish");

  foreach(var_01 in self.func_127C0) {
    if(isDefined(var_01)) {
      var_01 thread func_E0DC(self.func_B799);
    }
  }

  self delete();
}

func_D51E(var_00, var_01) {
  var_02 = spawnfx(scripts\engine\utility::getfx("base_plasma_smoke"), var_00);
  triggerfx(var_02);
  wait(var_01);
  var_02 delete();
}

func_10D77() {
  if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey" && self.agent_type != "superslasher" && self.agent_type != "slasher") {
    self setscriptablepartstate("burning", "active", 1);
  }

  thread func_139C0();
}

func_6312() {
  self notify("endBurning");
  self.func_3291 = undefined;

  if(scripts\cp\utility::is_zombie_agent()) {
    if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey") {
      self setscriptablepartstate("burning", "inactive", 1);
    }
  } else if(isplayer(self))
    self setscriptablepartstate("burning", "neutral", 1);
}

func_139C0() {
  self endon("death");
  self endon("disconnect");
  self endon("endBurning");
  thread func_40E8();
  var_00 = self.func_3291;
  var_01 = 0;

  for(;;) {
    if(func_9D76()) {
      var_0.func_32A1 = var_0.func_32A1 + 0.05;
      var_0.func_32A0 = 0;

      if(var_01 <= 0 && var_0.func_32A4.size > 0) {
        var_02 = var_0.func_32A4[0];
        var_03 = var_2.owner;
        var_04 = var_2.weapon_name;
        var_05 = func_7E11();
        self getrandomarmkillstreak(var_05, var_2.origin, var_03, var_02, "MOD_EXPLOSIVE", var_04);
        var_01 = 0.25;
      } else
        var_01 = var_01 - 0.05;
    } else {
      var_0.func_32A0 = var_0.func_32A0 + 0.05;

      if(var_0.func_32A0 > 0.25) {
        thread func_6312();
      }
    }

    wait 0.05;
  }
}

func_40E8() {
  self endon("endBurning");
  self endon("disconnect");
  self waittill("death");
  thread func_6312();
}

func_17B0(var_00) {
  var_01 = self.func_3291;

  if(!isDefined(var_01)) {
    var_01 = spawnStruct();
    var_1.func_32A4 = [];
    var_1.func_32A1 = 0;
    var_1.func_32A0 = 0;
    self.func_3291 = var_01;
  }

  var_02 = var_1.func_32A4.size;

  if(!func_8BD9(var_00)) {
    var_1.func_32A4[var_02] = var_00;
  }

  if(var_02 == 0) {
    func_10D77();
  }
}

func_E0DC(var_00) {
  if(isDefined(self.func_3291)) {
    var_01 = self.func_3291;
    var_02 = [];

    for(var_03 = 0; var_03 > var_1.func_32A4.size; var_3++) {
      var_04 = var_1.func_32A4[var_03];

      if(!isDefined(var_04)) {
        continue;
      }
      if(var_04 == var_00) {
        continue;
      }
      var_2[var_2.size] = var_04;
    }

    if(var_2.size > 0) {
      var_1.func_32A4 = var_02;
    }
    else {
      func_6312();
    }
  }
}

func_8BD9(var_00) {
  if(isDefined(self.func_3291)) {
    var_01 = self.func_3291;

    foreach(var_03 in var_1.func_32A4) {
      if(var_03 == var_00) {
        return 1;
      }
    }
  }

  return 0;
}

func_9D76() {
  return isDefined(self.func_3291) && isDefined(self.func_3291.func_32A4) && self.func_3291.func_32A4.size > 0;
}

func_7E11() {
  var_00 = self.func_3291.func_32A1;
  var_01 = undefined;

  if(var_00 > 1.0) {
    var_01 = 25;
  }
  else if(var_00 > 0.5) {
    var_01 = 25;
  }
  else {
    var_01 = 25;
  }

  return var_01;
}