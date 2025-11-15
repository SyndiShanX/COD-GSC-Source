/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\split_grenade.gsc
**************************************************/

init() {}

func_10A54(param_00) {
  param_00.throwtime = gettime();
  param_00.var_1180D = anglesToForward(self getplayerangles());
  param_00 setscriptablepartstate("trailDelayed", "active", 0);
  param_00 thread func_40FA(undefined, self);
  param_00.var_B79B = [];
  for(var_01 = 0; var_01 < 2; var_01++) {
    var_02 = scripts\mp\utility::_launchgrenade("split_grenade_mini_mp", param_00.origin, (0, 0, 0), 100, 1);
    scripts\mp\utility::_meth_85C6(var_02, "split_grenade_mp");
    var_02.exploding = 1;
    var_02.parentinflictor = param_00 getentitynumber();
    var_02 linkto(param_00);
    var_02 hide(1);
    var_02 forcehidegrenadehudwarning(1);
    var_02 thread func_40FA(param_00, self);
    param_00.var_B79B[var_01] = var_02;
  }

  thread func_13A84(param_00, 2);
  thread func_13B68(param_00);
}

func_13B68(param_00) {
  param_00 endon("death");
  self notify("watchStuck");
  self endon("watchStuck");
  param_00 waittill("missile_stuck", var_01);
  if(isplayer(var_01)) {
    thread func_C576(param_00, var_01);
    return;
  }

  thread func_C55D(param_00, var_01);
}

func_C576(param_00, param_01) {
  if(param_00.weapon_name == "split_grenade_mp") {
    scripts\mp\weapons::grenadestuckto(param_00, param_01, 1);
  }

  thread func_0118(param_00);
}

func_C55D(param_00, param_01) {
  param_00 endon("death");
  var_02 = gettime() - param_00.throwtime / 1000;
  var_03 = (0, 0, 120) + param_00.var_1180D * 940;
  var_04 = (0, 0, -800) * var_02;
  var_05 = var_03 + var_04;
  var_06 = anglestoup(param_00.angles);
  var_07 = vectordot(var_05, var_06);
  var_05 = var_05 + -2 * var_07 * var_06;
  var_08 = anglestoup(vectortoangles(var_05));
  param_00.weapon_name = "split_grenade_mini_mp";
  param_00.var_B79B[param_00.var_B79B.size] = param_00;
  var_09 = max(0, 2) * 9 / -2;
  for(var_0A = 0; var_0A < 3; var_0A++) {
    var_0B = angleclamp(var_09 + var_0A * 9);
    var_0C = rotatepointaroundvector(var_08, var_05, var_0B);
    var_0C = var_0C * 0.55;
    var_0D = randomfloatrange(0.75, 1);
    var_0E = param_00.var_B79B[var_0A];
    var_0E.exploding = 0;
    var_0E show();
    var_0E unlink();
    var_0E forcehidegrenadehudwarning(0);
    var_0E = scripts\mp\utility::_launchgrenade("split_grenade_mini_mp", param_00.origin, var_0C, 100, 1, var_0E);
    var_0E setscriptablepartstate("trail", "active", 0);
    thread func_13A84(var_0E, var_0D);
    thread func_13B68(var_0E);
    var_0E thread func_40FA(undefined, self);
  }

  param_00.var_B79B[0] setscriptablepartstate("split", "active", 0);
}

func_13A84(param_00, param_01) {
  param_00 endon("death");
  param_00 notify("watchFuse");
  param_00 endon("watchFuse");
  wait(param_01);
  thread func_0118(param_00);
}

func_0118(param_00) {
  param_00 notify("death");
  param_00.exploding = 1;
  param_00.origin = param_00.origin;
  param_00 forcehidegrenadehudwarning(1);
  param_00 setscriptablepartstate("explode", "active", "false");
  wait(5);
  param_00 delete();
}

func_40FA(param_00, param_01) {
  self endon("death");
  self notify("cleanupGrenade");
  self endon("cleanupGrenade");
  if(isDefined(param_00)) {
    childthread func_40FE(param_00);
  }

  if(isDefined(param_01)) {
    childthread func_40FD(param_01);
  }
}

func_40FE(param_00) {
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_40FD(param_00) {
  param_00 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}