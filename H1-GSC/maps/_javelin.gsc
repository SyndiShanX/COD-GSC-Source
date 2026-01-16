/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_javelin.gsc
********************************/

playerjavelinads() {
  if(self playerads() < 1.0)
    return 0;

  var_0 = self getcurrentweapon();

  if(!issubstr(var_0, "javelin"))
    return 0;

  return 1;
}

insidejavelinreticlenolock(var_0) {
  return target_isinrect(var_0, self, 25, 60, 30);
}

insidejavelinreticlelocked(var_0) {
  return target_isinrect(var_0, self, 25, 90, 45);
}

clearclutarget() {
  self notify("javelin_clu_cleartarget");
  self notify("stop_lockon_sound");
  level.javelinlockstarttime = 0;
  level.javelinlockstarted = 0;
  level.javelinlockfinalized = 0;
  level.javelintarget = undefined;
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  setomnvar("ui_javelin_lock_status", 0);
}

getbestjavelintarget() {
  var_0 = target_getarray();
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(insidejavelinreticlenolock(var_0[var_2]))
      var_1[var_1.size] = var_0[var_2];

    target_setoffscreenshader(var_0[var_2], "javelin_hud_target_offscreen");
  }

  if(var_1.size == 0)
    return undefined;

  var_3 = var_1[0];

  if(var_1.size > 1) {}

  return var_3;
}

isstillvalidtarget(var_0) {
  if(!isdefined(var_0))
    return 0;

  if(!target_istarget(var_0))
    return 0;

  if(!insidejavelinreticlelocked(var_0))
    return 0;

  return 1;
}

settargettooclose(var_0) {
  var_1 = 1000;

  if(!isdefined(var_0))
    return 0;

  var_2 = distance2d(self.origin, var_0.origin);

  if(var_2 < var_1)
    self weaponlocktargettooclose(1);
  else
    self weaponlocktargettooclose(0);
}

setnoclearance() {
  var_0 = 60;
  var_1 = 10;
  var_2 = 400;
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_5 = [];
  var_5[0] = (0, 0, 80);
  var_5[1] = (-40, 0, 120);
  var_5[2] = (40, 0, 120);
  var_5[3] = (-40, 0, 40);
  var_5[4] = (40, 0, 40);

  if(getdvar("missileDebugDraw") == "1")
    var_6 = 1;
  else
    var_6 = 0;

  var_7 = self getplayerangles();
  var_8 = anglestoforward(var_7);
  var_9 = anglestoright(var_7);
  var_10 = anglestoup(var_7);
  var_11 = self.origin + (0, 0, var_0) + var_9 * var_1;
  var_12 = 0;

  for (var_13 = 0; var_13 < var_5.size; var_13++) {
    var_14 = var_11 + var_8 * var_2 + var_10 * var_5[var_13][2] + var_9 * var_5[var_13][0];
    var_15 = bullettrace(var_11, var_14, 0, undefined);

    if(var_15["fraction"] < 1) {
      var_12 = 1;

      if(var_6) {

      } else
        break;
    } else if(var_6) {

    }
  }

  self weaponlocknoclearance(var_12);
}

javelincluloop() {
  self endon("death");
  self endon("javelin_clu_off");

  for (;;) {
    wait 0.05;
    var_0 = self getcurrentweaponclipammo();

    if(!var_0) {
      clearclutarget();
      continue;
    }

    if(level.javelinlockfinalized) {
      if(!isstillvalidtarget(level.javelintarget)) {
        clearclutarget();
        continue;
      }

      settargettooclose(level.javelintarget);
      setnoclearance();
      continue;
    }

    if(level.javelinlockstarted) {
      if(!isstillvalidtarget(level.javelintarget)) {
        clearclutarget();
        continue;
      }

      var_1 = gettime() - level.javelinlockstarttime;

      if(var_1 < level.locklength) {
        continue;
      }
      self notify("stop_lockon_sound");
      level.javelinlockfinalized = 1;
      wait 0.2;
      self weaponlockfinalize(level.javelintarget);
      self playlocalsound("javelin_clu_lock");
      settargettooclose(level.javelintarget);
      setnoclearance();
      setomnvar("ui_javelin_lock_status", 2);
      continue;
    }

    var_2 = getbestjavelintarget();

    if(!isdefined(var_2)) {
      continue;
    }
    level.javelintarget = var_2;
    level.javelinlockstarttime = gettime();
    level.javelinlockstarted = 1;
    setomnvar("ui_javelin_lock_status", 1);
    self weaponlockstart(var_2);
    thread looplocalseeksound("javelin_clu_aquiring_lock", 0.6);
  }
}

javelintoggleloop() {
  self endon("death");

  for (;;) {
    while (!playerjavelinads())
      wait 0.05;

    thread javelincluloop();

    while (playerjavelinads())
      wait 0.05;

    self notify("javelin_clu_off");
    clearclutarget();
  }
}

traceconstanttest() {
  for (;;) {
    wait 0.05;
    setnoclearance();
  }
}

init() {
  level.locklength = 2000;
  setomnvar("ui_javelin", 1);
  precacheshader("javelin_hud_target_offscreen");
  common_scripts\utility::array_thread(level.players, ::clearclutarget);
  setsaveddvar("vehHudTargetSize", 30);
  setsaveddvar("vehHudTargetScreenEdgeClampBufferLeft", 95);
  setsaveddvar("vehHudTargetScreenEdgeClampBufferRight", 95);
  setsaveddvar("vehHudTargetScreenEdgeClampBufferTop", 139);
  setsaveddvar("vehHudTargetScreenEdgeClampBufferBottom", 134);
  setsaveddvar("vehHudTargetingCornerLockTime", level.locklength / 1000);
  common_scripts\utility::array_thread(level.players, ::javelintoggleloop);
}

looplocalseeksound(var_0, var_1) {
  self endon("stop_lockon_sound");

  for (;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}