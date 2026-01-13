/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\split_grenade.gsc
**************************************************/

init() {}

func_10A54(var_0) {
  var_0.throwtime = gettime();
  var_0.var_1180D = anglesToForward(self getplayerangles());
  var_0 setscriptablepartstate("trailDelayed", "active", 0);
  var_0 thread func_40FA(undefined, self);
  var_0.var_B79B = [];
  for(var_1 = 0; var_1 < 2; var_1++) {
    var_2 = scripts\mp\utility::_launchgrenade("split_grenade_mini_mp", var_0.origin, (0, 0, 0), 100, 1);
    scripts\mp\utility::_meth_85C6(var_2, "split_grenade_mp");
    var_2.exploding = 1;
    var_2.parentinflictor = var_0 getentitynumber();
    var_2 linkto(var_0);
    var_2 hide(1);
    var_2 forcehidegrenadehudwarning(1);
    var_2 thread func_40FA(var_0, self);
    var_0.var_B79B[var_1] = var_2;
  }

  thread func_13A84(var_0, 2);
  thread func_13B68(var_0);
}

func_13B68(var_0) {
  var_0 endon("death");
  self notify("watchStuck");
  self endon("watchStuck");
  var_0 waittill("missile_stuck", var_1);
  if(isplayer(var_1)) {
    thread func_C576(var_0, var_1);
    return;
  }

  thread func_C55D(var_0, var_1);
}

func_C576(var_0, var_1) {
  if(var_0.weapon_name == "split_grenade_mp") {
    scripts\mp\weapons::grenadestuckto(var_0, var_1, 1);
  }

  thread func_0118(var_0);
}

func_C55D(var_0, var_1) {
  var_0 endon("death");
  var_2 = gettime() - var_0.throwtime / 1000;
  var_3 = (0, 0, 120) + var_0.var_1180D * 940;
  var_4 = (0, 0, -800) * var_2;
  var_5 = var_3 + var_4;
  var_6 = anglestoup(var_0.angles);
  var_7 = vectordot(var_5, var_6);
  var_5 = var_5 + -2 * var_7 * var_6;
  var_8 = anglestoup(vectortoangles(var_5));
  var_0.weapon_name = "split_grenade_mini_mp";
  var_0.var_B79B[var_0.var_B79B.size] = var_0;
  var_9 = max(0, 2) * 9 / -2;
  for(var_0A = 0; var_0A < 3; var_0A++) {
    var_0B = angleclamp(var_9 + var_0A * 9);
    var_0C = rotatepointaroundvector(var_8, var_5, var_0B);
    var_0C = var_0C * 0.55;
    var_0D = randomfloatrange(0.75, 1);
    var_0E = var_0.var_B79B[var_0A];
    var_0E.exploding = 0;
    var_0E show();
    var_0E unlink();
    var_0E forcehidegrenadehudwarning(0);
    var_0E = scripts\mp\utility::_launchgrenade("split_grenade_mini_mp", var_0.origin, var_0C, 100, 1, var_0E);
    var_0E setscriptablepartstate("trail", "active", 0);
    thread func_13A84(var_0E, var_0D);
    thread func_13B68(var_0E);
    var_0E thread func_40FA(undefined, self);
  }

  var_0.var_B79B[0] setscriptablepartstate("split", "active", 0);
}

func_13A84(var_0, var_1) {
  var_0 endon("death");
  var_0 notify("watchFuse");
  var_0 endon("watchFuse");
  wait(var_1);
  thread func_0118(var_0);
}

func_0118(var_0) {
  var_0 notify("death");
  var_0.exploding = 1;
  var_0.origin = var_0.origin;
  var_0 forcehidegrenadehudwarning(1);
  var_0 setscriptablepartstate("explode", "active", "false");
  wait(5);
  var_0 delete();
}

func_40FA(var_0, var_1) {
  self endon("death");
  self notify("cleanupGrenade");
  self endon("cleanupGrenade");
  if(isDefined(var_0)) {
    childthread func_40FE(var_0);
  }

  if(isDefined(var_1)) {
    childthread func_40FD(var_1);
  }
}

func_40FE(var_0) {
  var_0 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_40FD(var_0) {
  var_0 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}