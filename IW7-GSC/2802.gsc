/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2802.gsc
**************************************/

splashgrenadeinit() {
  level._effect["base_plasma_smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_plasma_smoke");
  scripts\mp\powerloot::func_DF06("power_splashGrenade", ["passive_smoke", "passive_increased_duration", "passive_increased_spread", "passive_increased_radius", "passive_increased_entities"]);
}

splashgrenadeused(var_0) {
  var_0.grenades = [];
  var_1 = scripts\mp\powerloot::func_7FC2("power_splashGrenade", 6);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = scripts\mp\utility\game::_launchgrenade("globproj_mp", (0, 0, 0), (0, 0, 0));
    var_3.owner = self;
    var_3.team = self.team;
    var_3.weapon_name = "globproj_mp";
    var_3.parentinflictor = var_0 getentitynumber();
    var_3 linkto(var_0, "", (0, 0, 0), (0, 0, 0));
    var_3 hide(1);
    var_0.grenades[var_0.grenades.size] = var_3;
    var_3 thread istrialversion();
  }

  thread func_85CE(var_0);
  thread func_85CD(var_0);
  var_0 thread istrialversion();
}

func_85CD(var_0, var_1) {
  var_0 notify("grenadeOnExplode");
  var_0 endon("grenadeOnExplode");
  var_0 thread scripts\mp\utility\game::notifyafterframeend("death", "end_explode");
  var_0 endon("end_explode");
  var_2 = var_0.owner;
  var_3 = var_0.grenades;
  var_4 = var_0.power;
  var_0 waittill("explode", var_5);

  if(!isDefined(var_2)) {
    return;
  }
  setinteractwithethereal(var_5, var_1, var_3, var_4);
}

func_85CE(var_0) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);
  var_0 setscriptablepartstate("beacon", "active", 0);

  if(isDefined(var_1) && isplayer(var_1)) {
    scripts\mp\weapons::grenadestuckto(var_0, var_1);

    foreach(var_3 in var_0.grenades) {
      var_3.isstuck = var_0.isstuck;
    }

    thread scripts\mp\missions::func_D3A8(var_1, self);
  } else {
    thread func_85CD(var_0, var_0.angles);
  }
}

setinteractwithethereal(var_0, var_1, var_2, var_3) {
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
    var_9 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(self.team));
  } else {
    var_9 = level.characters;
  }

  var_11 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  foreach(var_13 in var_9) {
    if(!isDefined(var_13) || var_13 == self || !scripts\mp\utility\game::isreallyalive(var_13)) {
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
  var_19 = scripts\mp\powerloot::func_7FC1("power_splashGrenade", 1.5);
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

    var_27 = scripts\mp\powerloot::func_7FC7("power_splashGrenade", var_27);
    var_32 = var_0 + var_21;
    var_33 = var_2[var_24];
    var_33 show();
    var_33 unlink(1);
    var_33 = scripts\mp\utility\game::_launchgrenade("globproj_mp", var_32, var_27, undefined, undefined, var_33);
    var_33.owner = self;
    var_33.team = self.team;
    var_33.weapon_name = "globproj_mp";

    if(var_24 == 0) {
      var_33 setscriptablepartstate("explosionLarge", "active");
    }

    var_33 setscriptablepartstate("trail", "active");
    thread func_B79A(var_33, var_19);
  }
}

func_B79A(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_2);
  var_3 = 3 + randomfloat(0.15);
  var_0 thread istrialversion(var_1 + var_3);
  var_0 setscriptablepartstate("trail", "neutral");
  var_0 setscriptablepartstate("explosion", "active");
  var_4 = scripts\mp\powerloot::func_7FC4("power_splashGrenade", 60);
  var_5 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_4, 60);
  var_5.angles = var_0.angles;
  var_5.owner = self;
  var_5 getrankxp();
  var_5 linkto(var_0);
  var_5 hide();
  var_5.var_B799 = var_0;
  var_5 thread func_13B91();
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

istrialversion(var_0) {
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

func_B24D(var_0, var_1, var_2) {
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

func_13B91() {
  self endon("death");
  self.owner endon("disconnect");
  var_0 = self.owner;
  var_1 = var_0.team;

  if(!isDefined(self.var_127C0)) {
    self.var_127C0 = [];
  }

  thread func_13B93();
  thread func_127B9();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isplayer(var_2) && !scripts\mp\utility\game::func_9F22(var_2)) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_2)) {
      continue;
    }
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2.owner), var_2.owner, var_2);

    if(!level.friendlyfire && var_3 != var_0 && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_3, var_0))) {
      continue;
    }
    thread scripts\mp\missions::func_D3A8(var_2, var_0);
    self.var_127C0[var_2 getentitynumber()] = var_2;
    var_2 func_17B0(self.var_B799);
  }
}

func_13B93() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    foreach(var_2, var_1 in self.var_127C0) {
      if(!isDefined(var_1)) {
        self.var_127C0[var_2] = undefined;
        continue;
      }

      if(!scripts\mp\utility\game::isreallyalive(var_1) || !var_1 istouching(self)) {
        self.var_127C0[var_2] = undefined;
        var_1 thread func_E0DC(self.var_B799);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_127B9() {
  self endon("death");
  self.var_B799 endon("death");
  self.var_B799 waittill("extinguish");

  foreach(var_1 in self.var_127C0) {
    if(isDefined(var_1)) {
      var_1 thread func_E0DC(self.var_B799);
    }
  }

  self delete();
}

func_D51E(var_0, var_1) {
  var_2 = spawnfx(scripts\engine\utility::getfx("base_plasma_smoke"), var_0);
  triggerfx(var_2);
  wait(var_1);
  var_2 delete();
}

func_10D77() {
  if(isplayer(self)) {
    self setscriptablepartstate("burning", "active", 0);
  }

  thread func_139C0();
}

func_6312() {
  self notify("endBurning");
  self.var_3291 = undefined;

  if(isplayer(self)) {
    self setscriptablepartstate("burning", "neutral", 0);
  }
}

func_139C0() {
  self endon("death");
  self endon("disconnect");
  self endon("endBurning");
  thread func_40E8();
  var_0 = self.var_3291;
  var_1 = 0;

  for(;;) {
    if(func_9D76()) {
      var_0.var_32A1 = var_0.var_32A1 + 0.05;
      var_0.var_32A0 = 0;

      if(var_1 <= 0 && var_0.var_32A4.size > 0) {
        var_2 = var_0.var_32A4[0];
        var_3 = var_2.owner;
        var_4 = var_2.weapon_name;
        var_5 = func_7E11();
        self getrandomarmkillstreak(var_5, var_2.origin, var_3, var_2, "MOD_EXPLOSIVE", var_4);
        var_1 = 0.25;
      } else {
        var_1 = var_1 - 0.05;
      }
    } else {
      var_0.var_32A0 = var_0.var_32A0 + 0.05;

      if(var_0.var_32A0 > 0.25) {
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

func_17B0(var_0) {
  var_1 = self.var_3291;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1.var_32A4 = [];
    var_1.var_32A1 = 0;
    var_1.var_32A0 = 0;
    self.var_3291 = var_1;
  }

  var_2 = var_1.var_32A4.size;

  if(!func_8BD9(var_0)) {
    var_1.var_32A4[var_2] = var_0;
  }

  if(var_2 == 0) {
    func_10D77();
  }
}

func_E0DC(var_0) {
  if(isDefined(self.var_3291)) {
    var_1 = self.var_3291;
    var_2 = [];

    for(var_3 = 0; var_3 > var_1.var_32A4.size; var_3++) {
      var_4 = var_1.var_32A4[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      if(var_4 == var_0) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    if(var_2.size > 0) {
      var_1.var_32A4 = var_2;
    } else {
      func_6312();
    }
  }
}

func_8BD9(var_0) {
  if(isDefined(self.var_3291)) {
    var_1 = self.var_3291;

    foreach(var_3 in var_1.var_32A4) {
      if(var_3 == var_0) {
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
  var_0 = self.var_3291.var_32A1;
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