/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\_spawn_plasma_projectile.gsc
***************************************************/

splashgrenadeinit() {
  level._effect["base_plasma_smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_smoke");
}

splashgrenadeused(param_00) {
  param_00.grenades = [];
  var_01 = 6;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", (0, 0, 0), (0, 0, 0));
    var_03.triggerportableradarping = self;
    var_03.team = self.team;
    var_03.weapon_name = "zmb_globproj_zm";
    var_03 linkto(param_00, "", (0, 0, 0), (0, 0, 0));
    var_03 hide(1);
    param_00.grenades[param_00.grenades.size] = var_03;
    var_03 thread istrialversion();
  }

  thread func_85CE(param_00);
  thread func_85CD(param_00);
  param_00 thread istrialversion();
}

func_85CD(param_00, param_01) {
  param_00 notify("grenadeOnExplode");
  param_00 endon("grenadeOnExplode");
  param_00 thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  param_00 endon("end_explode");
  var_02 = param_00.triggerportableradarping;
  var_03 = param_00.grenades;
  var_04 = param_00.power;
  param_00 waittill("explode", var_05);
  if(!isDefined(var_02)) {
    return;
  }

  setinteractwithethereal(var_05, param_01, var_03, var_04);
}

func_85CE(param_00) {
  param_00 endon("death");
  param_00 waittill("missile_stuck", var_01);
  if(isDefined(var_01) && isplayer(var_01)) {
    return;
  }

  thread func_85CD(param_00, param_00.angles);
}

setinteractwithethereal(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = 0;
  var_06 = undefined;
  if(isDefined(param_01)) {
    var_06 = anglestoup(param_01);
    var_07 = vectordot(var_06, (0, 0, 1));
    var_08 = acos(var_07);
    var_04 = var_08 >= 45;
    var_05 = var_08 >= 145;
  }

  var_09 = undefined;
  var_0A = [];
  if(level.teambased) {
    var_09 = scripts\cp\utility::getteamarray(scripts\cp\utility::getotherteam(self.team));
  } else {
    var_09 = level.characters;
  }

  var_0B = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  foreach(var_0D in var_09) {
    if(!isDefined(var_0D) || var_0D == self || !scripts\cp\utility::isreallyalive(var_0D)) {
      continue;
    }

    var_0E = distancesquared(param_00, var_0D.origin);
    if(var_0E > 13225 || var_0E < 7225) {
      continue;
    }

    var_0F = physics_raycast(param_00, var_0D.origin, var_0B, undefined, 0, "physicsquery_closest");
    if(!isDefined(var_0F) || var_0F.size > 0) {
      continue;
    }

    var_0A[var_0A.size] = var_0D;
  }

  if(var_0A.size > 0) {
    var_0A = scripts\engine\utility::array_randomize(var_0A);
  }

  var_11 = 0;
  var_12 = 0;
  var_13 = 1.5;
  var_14 = (0, 0, 0);
  var_15 = (0, 0, 0);
  if(var_04 || var_05) {
    var_14 = var_06 * 115;
    var_15 = var_06 * 3;
  }

  var_16 = randomint(46);
  var_17 = 0;
  for(var_18 = 0; var_18 < param_02.size; var_18++) {
    var_19 = undefined;
    var_1A = randomint(2);
    if(var_1A && var_11 < var_0A.size) {
      var_1B = var_0A[var_11].origin - param_00;
      var_1B = (var_1B[0], var_1B[1], 0);
      var_11++;
    } else if(var_17 < 6) {
      var_1C = var_16 + 72 * var_17;
      var_1D = 85 + randomint(31);
      if(var_17 == 5) {
        var_1D = 0;
      }

      var_1B = (cos(var_1C), sin(var_1C), 0) * var_1D + var_14;
      var_17++;
    } else {
      var_1E = randomint(360);
      var_1F = 85 + randomint(31);
      var_1B = (cos(var_1E), sin(var_1E), 0) * var_1F + var_14;
    }

    if(!var_05) {
      var_1B = var_1B + (0, 0, 200 + randomint(200));
    }

    var_1B = var_1B;
    var_20 = param_00 + var_15;
    var_21 = param_02[var_18];
    var_21 show();
    var_21 unlink(1);
    var_21 = scripts\cp\utility::_launchgrenade("zmb_globproj_zm", var_20, var_1B, undefined, undefined, var_21);
    var_21.triggerportableradarping = self;
    var_21.team = self.team;
    var_21.weapon_name = "zmb_globproj_zm";
    if(var_18 == 0) {
      var_21 setscriptablepartstate("explosion", "active");
    } else {
      var_21 setscriptablepartstate("explosion", "neutral");
    }

    var_21 setscriptablepartstate("trail", "active");
    thread func_B79A(var_21, var_13);
  }
}

func_B79A(param_00, param_01) {
  param_00 endon("death");
  param_00 waittill("missile_stuck", var_02);
  var_03 = 3 + randomfloat(0.15);
  param_00 thread istrialversion(param_01 + var_03);
  param_00 setscriptablepartstate("trail", "neutral");
  param_00 setscriptablepartstate("explosion", "active");
  var_04 = 60;
  var_05 = spawn("trigger_rotatable_radius", param_00.origin, 0, var_04, 60);
  var_05.angles = param_00.angles;
  var_05.triggerportableradarping = self;
  var_05 enablelinkto();
  var_05 linkto(param_00);
  var_05 hide();
  var_05.var_B799 = param_00;
  var_05 thread func_13B91();
  var_06 = vectordot(anglestoup(var_05.angles), (0, 0, 1));
  if(var_06 <= 0) {
    param_00.poolscriptablepart = "poolWall";
    param_00 setscriptablepartstate("poolWall", "active");
  } else {
    param_00.poolscriptablepart = "poolGround";
    param_00 setscriptablepartstate("poolGround", "active");
  }

  wait(param_01);
  param_00 notify("extinguish");
  param_00 setscriptablepartstate(param_00.poolscriptablepart, "activeEnd", 0);
}

istrialversion(param_00) {
  self endon("death");
  self notify("grenadeCleanup");
  self endon("grenadeCleanup");
  if(isDefined(param_00)) {
    self.triggerportableradarping scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_00, "disconnect");
  } else {
    self.triggerportableradarping waittill("disconnect");
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_B24D(param_00, param_01, param_02) {
  self endon("death");
  var_03 = self getentitynumber();
  self notify("mainScriptableCleanup" + var_03);
  self endon("mainScriptableCleanup" + var_03);
  if(isDefined(param_01)) {
    wait(param_01);
  } else {
    param_00 waittill("death");
  }

  if(isDefined(param_02)) {
    wait(param_02);
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_13B91() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.triggerportableradarping;
  var_01 = var_00.team;
  if(!isDefined(self.var_127C0)) {
    self.var_127C0 = [];
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

    if(var_02 != var_00 && level.teambased && var_02.team == var_01) {
      continue;
    }

    self.var_127C0[var_02 getentitynumber()] = var_02;
    var_02 func_17B0(self.var_B799);
  }
}

func_13B93() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    foreach(var_02, var_01 in self.var_127C0) {
      if(!isDefined(var_01)) {
        self.var_127C0[var_02] = undefined;
        continue;
      }

      if(!scripts\cp\utility::isreallyalive(var_01) || !var_01 istouching(self)) {
        self.var_127C0[var_02] = undefined;
        var_01 thread func_E0DC(self.var_B799);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_127B9() {
  self endon("death");
  self.var_B799 endon("death");
  self.var_B799 waittill("extinguish");
  foreach(var_01 in self.var_127C0) {
    if(isDefined(var_01)) {
      var_01 thread func_E0DC(self.var_B799);
    }
  }

  self delete();
}

func_D51E(param_00, param_01) {
  var_02 = spawnfx(scripts\engine\utility::getfx("base_plasma_smoke"), param_00);
  triggerfx(var_02);
  wait(param_01);
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
  self.var_3291 = undefined;
  if(scripts\cp\utility::is_zombie_agent()) {
    if(isDefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey") {
      self setscriptablepartstate("burning", "inactive", 1);
      return;
    }

    return;
  }

  if(isplayer(self)) {
    self setscriptablepartstate("burning", "neutral", 1);
  }
}

func_139C0() {
  self endon("death");
  self endon("disconnect");
  self endon("endBurning");
  thread func_40E8();
  var_00 = self.var_3291;
  var_01 = 0;
  for(;;) {
    if(func_9D76()) {
      var_00.var_32A1 = var_00.var_32A1 + 0.05;
      var_00.var_32A0 = 0;
      if(var_01 <= 0 && var_00.var_32A4.size > 0) {
        var_02 = var_00.var_32A4[0];
        var_03 = var_02.triggerportableradarping;
        var_04 = var_02.weapon_name;
        var_05 = func_7E11();
        self dodamage(var_05, var_02.origin, var_03, var_02, "MOD_EXPLOSIVE", var_04);
        var_01 = 0.25;
      } else {
        var_01 = var_01 - 0.05;
      }
    } else {
      var_00.var_32A0 = var_00.var_32A0 + 0.05;
      if(var_00.var_32A0 > 0.25) {
        thread func_6312();
      }
    }

    wait(0.05);
  }
}

func_40E8() {
  self endon("endBurning");
  self endon("disconnect");
  self waittill("death");
  thread func_6312();
}

func_17B0(param_00) {
  var_01 = self.var_3291;
  if(!isDefined(var_01)) {
    var_01 = spawnStruct();
    var_01.var_32A4 = [];
    var_01.var_32A1 = 0;
    var_01.var_32A0 = 0;
    self.var_3291 = var_01;
  }

  var_02 = var_01.var_32A4.size;
  if(!func_8BD9(param_00)) {
    var_01.var_32A4[var_02] = param_00;
  }

  if(var_02 == 0) {
    func_10D77();
  }
}

func_E0DC(param_00) {
  if(isDefined(self.var_3291)) {
    var_01 = self.var_3291;
    var_02 = [];
    for(var_03 = 0; var_03 > var_01.var_32A4.size; var_03++) {
      var_04 = var_01.var_32A4[var_03];
      if(!isDefined(var_04)) {
        continue;
      }

      if(var_04 == param_00) {
        continue;
      }

      var_02[var_02.size] = var_04;
    }

    if(var_02.size > 0) {
      var_01.var_32A4 = var_02;
      return;
    }

    func_6312();
  }
}

func_8BD9(param_00) {
  if(isDefined(self.var_3291)) {
    var_01 = self.var_3291;
    foreach(var_03 in var_01.var_32A4) {
      if(var_03 == param_00) {
        return 1;
      }
    }
  }

  return 0;
}

func_9D76() {
  return isDefined(self.var_3291) && isDefined(self.var_3291.var_32A4) && self.var_3291.var_32A4.size > 0;
}

func_7E11() {
  var_00 = self.var_3291.var_32A1;
  var_01 = undefined;
  if(var_00 > 1) {
    var_01 = 25;
  } else if(var_00 > 0.5) {
    var_01 = 25;
  } else {
    var_01 = 25;
  }

  return var_01;
}