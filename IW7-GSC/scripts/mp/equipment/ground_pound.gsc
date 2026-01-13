/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\ground_pound.gsc
*************************************************/

init() {
  groundpound_initimpactstructs();
}

func_8659(var_0) {
  self allowgroundpound(1);
  thread func_8654();
  thread groundpound_monitoractivation();
}

func_865A() {
  self allowgroundpound(0);
  if(self.loadoutarchetype == "archetype_heavy") {
    self setscriptablepartstate("groundPound", "neutral", 0);
  }

  self notify("groundPound_unset");
}

func_8654() {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  for(;;) {
    self waittill("groundPoundLand", var_0);
    thread groundpound_impact(self, var_0);
    scripts\mp\utility::printgameaction("ground pound land", self);
  }
}

groundpound_monitoractivation() {
  self endon("death");
  self endon("disconnect");
  self endon("groundPound_unset");
  for(;;) {
    self waittill("groundPoundBegin");
    thread groundpound_activate(self);
  }
}

groundpound_activate(var_0) {
  var_0 setscriptablepartstate("groundPound", "activated");
}

groundpound_impact(var_0, var_1) {
  var_0 setclientomnvar("ui_hud_shake", 1);
  var_0 setscriptablepartstate("groundPound", "impact");
  var_2 = groundpound_getbestimpactstruct(var_1);
  if(!isDefined(var_2)) {
    return;
  }

  var_3 = var_0.origin + (0, 0, 2);
  thread groundpound_impactphysics(var_3, var_2.physicsradmin, var_2.physicsradmax, var_2.physicsscale);
  if(isDefined(var_2.stopfxontag)) {
    var_4 = spawn("script_model", var_3);
    var_4.angles = var_0.angles;
    var_4.triggerportableradarping = var_0;
    var_4.weapon_name = "groundpound_mp";
    var_4.impactstruct = var_2;
    var_4.killcament = var_0;
    var_4 setentityowner(var_0);
    var_4 setotherent(var_0);
    var_4 setModel(var_2.stopfxontag);
    if(isDefined(var_2.updategamerprofileall) && isDefined(var_2.var_10E2C)) {
      var_4 setscriptablepartstate(var_2.updategamerprofileall, var_2.var_10E2C);
    }

    if(isDefined(var_2.deletiondelay)) {
      wait(var_2.deletiondelay);
    } else {
      scripts\engine\utility::waitframe();
    }

    var_4 delete();
  }
}

groundpound_impactphysics(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }

  if(!isDefined(var_2) || var_2 == 0) {
    return;
  }

  if(!isDefined(var_3) || var_3 == 0) {
    return;
  }

  wait(0.1);
  physicsexplosionsphere(var_0, var_2, var_1, var_3);
}

groundpound_victimimpacteffects(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 == var_1) {
    return;
  }

  if(var_1 scripts\mp\utility::isusingremote()) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_3.impactstruct;
  if(!isDefined(var_4)) {
    return;
  }

  if(!isDefined(var_4.shock) || var_4.shock == "") {
    return;
  }

  if(!isDefined(var_4.shockduration) || var_4.shockduration == 0) {
    return;
  }

  var_1 shellshock(var_4.shock, var_4.shockduration);
}

func_8653(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || var_2 != "groundpound_mp") {
    return var_4;
  }

  if(!isplayer(var_1)) {
    return var_4;
  }

  if(!isDefined(var_0)) {
    return var_4;
  }

  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(var_3)) {
    return var_4;
  }

  var_5 = var_3.impactstruct;
  if(!isDefined(var_5)) {
    return var_4;
  }

  var_6 = scripts\engine\utility::ter_op(level.hardcoremode, var_5.innerradsqrhc, var_5.innerradsqr);
  var_7 = scripts\engine\utility::ter_op(level.hardcoremode, var_5.innerdamagehc, var_5.innerdamage);
  var_8 = scripts\engine\utility::ter_op(level.hardcoremode, var_5.outerdamagehc, var_5.outerdamage);
  var_9 = var_1 scripts\mp\utility::isinarbitraryup();
  var_0A = scripts\engine\utility::ter_op(var_9, self gettagorigin("TAG_EYE", 1, 1), self gettagorigin("TAG_EYE"));
  var_0B = abs(vectordot(var_0A - var_3.origin, (0, 0, 1)));
  var_0C = scripts\engine\utility::ter_op(var_9, self gettagorigin("TAG_ORIGIN", 1, 1), self gettagorigin("TAG_ORIGIN"));
  var_0D = abs(vectordot(var_0C - var_3.origin, (0, 0, 1)));
  if(var_0B > var_5.maxzdelta && var_0D > var_5.maxzdelta) {
    return 0;
  }

  var_0E = var_6 != 0;
  if(var_0E) {
    var_0E = var_6 < 0;
    if(!var_0E) {
      if(!var_0E) {
        var_0F = distancesquared(var_3.origin, var_1.origin);
        if(var_0F <= var_6) {
          var_0E = 1;
        }
      }

      if(!var_0E) {
        var_0F = distancesquared(var_3.origin, var_1 gettagorigin("j_mainroot"));
        if(var_0F <= var_6) {
          var_0E = 1;
        }
      }

      if(!var_0E) {
        var_0F = distancesquared(var_3.origin, var_1 getEye());
        if(var_0F <= var_6) {
          var_0E = 1;
        }
      }
    }
  }

  if(var_0E) {
    var_4 = scripts\engine\utility::ter_op(var_7 > 0, var_7, var_4);
    if(!var_1 isonground()) {
      var_4 = var_4 * 1;
    }

    return var_4;
  }

  var_4 = scripts\engine\utility::ter_op(var_8 > 0, var_8, var_4);
  if(!var_1 isonground()) {
    var_4 = var_4 * 1;
  }

  return var_4;
}

groundpound_modifiedblastshieldconst(var_0, var_1) {
  if(level.hardcoremode) {
    if(scripts\mp\utility::getweaponbasedsmokegrenadecount(var_1) == "groundpound_mp") {
      var_0 = 0.65;
    }
  }

  return var_0;
}

func_8651(var_0) {
  return var_0 _meth_8499();
}

groundpound_initimpactstructs() {
  var_0 = spawnStruct();
  var_0.impactstructs = [];
  var_1 = groundpound_createimpactstruct();
  var_0.impactstructs[var_0.impactstructs.size] = var_1;
  var_1 = groundpound_createimpactstruct();
  var_1.var_B783 = 150;
  var_1.innerradsqr = 5625;
  var_1.innerradsqr = 5625;
  var_1.var_10E2C = "impact2";
  var_1.physicsradmax = 150;
  var_1.physicsscale = 2.5;
  var_0.impactstructs[var_0.impactstructs.size] = var_1;
  var_1 = groundpound_createimpactstruct();
  var_1.var_B783 = 225;
  var_1.innerradsqr = -1;
  var_1.innerradsqrhc = -1;
  var_1.var_10E2C = "impact3";
  var_1.physicsradmax = 225;
  var_1.physicsscale = 3;
  var_0.impactstructs[var_0.impactstructs.size] = var_1;
  var_1 = groundpound_createimpactstruct();
  var_1.var_B783 = 325;
  var_1.innerradsqr = -1;
  var_1.innerradsqrhc = -1;
  var_1.var_10E2C = "impact4";
  var_1.physicsradmax = 275;
  var_1.physicsscale = 3.5;
  var_0.impactstructs[var_0.impactstructs.size] = var_1;
  var_1 = groundpound_createimpactstruct();
  var_1.var_B783 = 425;
  var_1.innerradsqr = -1;
  var_1.innerradsqrhc = -1;
  var_1.var_10E2C = "impact5";
  var_1.physicsradmax = 325;
  var_1.physicsscale = 4;
  var_0.impactstructs[var_0.impactstructs.size] = var_1;
  var_0.impactstructs = scripts\engine\utility::array_sort_with_func(var_0.impactstructs, ::groundpound_compareimpactstruct);
  level.groundpound = var_0;
}

groundpound_createimpactstruct() {
  var_0 = spawnStruct();
  var_0.var_B783 = 48;
  var_0.maxzdelta = 125;
  var_0.innerradsqr = 0;
  var_0.innerradsqrhc = 0;
  var_0.innerdamage = 105;
  var_0.outerdamage = 55;
  var_0.innerdamagehc = 35;
  var_0.outerdamagehc = 20;
  var_0.stopfxontag = "perk_mp_groundPound_scr";
  var_0.updategamerprofileall = "effects";
  var_0.var_10E2C = "impact1";
  var_0.deletiondelay = 2;
  var_0.physicsradmin = 75;
  var_0.physicsradmax = 100;
  var_0.physicsscale = 2;
  var_0.shock = "concussion_grenade_mp";
  var_0.shockduration = 0.7;
  return var_0;
}

groundpound_compareimpactstruct(var_0, var_1) {
  return var_0.var_B783 > var_1.var_B783;
}

groundpound_getbestimpactstruct(var_0) {
  var_1 = undefined;
  foreach(var_3 in level.groundpound.impactstructs) {
    if(var_0 < var_3.var_B783) {
      continue;
    }

    var_1 = var_3;
    break;
  }

  return var_1;
}

func_8655(var_0, var_1, var_2, var_3) {}