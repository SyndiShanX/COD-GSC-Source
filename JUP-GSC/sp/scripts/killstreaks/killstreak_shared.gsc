/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\killstreaks\killstreak_shared.gsc
********************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace killstreak_shared;

function registerkillstreakinitfunction(bundlenamexhash, initfunc) {
  if(!isDefined(level.var_7233e8ba4d09f124)) {
    level.var_7233e8ba4d09f124 = [];
  }

  assertex(!isDefined(level.var_7233e8ba4d09f124[bundlenamexhash]), "Killstreak Init function redefinition.");
  level.var_7233e8ba4d09f124[bundlenamexhash] = initfunc;
}

function initializekillstreak(streakrefxhash) {
  if(!isDefined(level.var_7233e8ba4d09f124)) {
    return;
  }

  initfunc = level.var_7233e8ba4d09f124[streakrefxhash];

  if(!isDefined(initfunc)) {
    return;
  }

  level[[initfunc]]();
}

function parsestreakbundles(killstreaklistname) {
  if(!isDefined(killstreaklistname)) {
    return false;
  }

  globals = level.streakglobals;

  if(isDefined(globals.streakbundles)) {
    return false;
  }

  globals.streakbundles = [];
  globals.var_2150da9328528bb9 = [];
  killstreaklistbundle = getscriptbundle(killstreaklistname);

  if(!isDefined(killstreaklistbundle)) {
    return false;
  }

  foreach(index, killstreaklistentry in killstreaklistbundle.killstreak_list) {
    if(!isnumber(index)) {
      continue;
    }

    if(!isDefined(killstreaklistentry)) {
      continue;
    }

    killstreakbundlename = killstreaklistentry.bundle;

    if(!isDefined(killstreakbundlename)) {
      continue;
    }

    assert(isxhashasset(killstreakbundlename));

    if(killstreakbundlename == % "killstreak:killstreak_none") {
      continue;
    }

    if(killstreakbundlename == % "hash_40daaf59ab8992e5") {
      continue;
    }

    bundle = getscriptbundle(killstreakbundlename);

    if(!isDefined(bundle)) {
      continue;
    }

    streakref = bundle.killstreakref;

    if(!isDefined(streakref) || streakref == "none") {
      assert(isDefined(streakref));
      continue;
    }

    bundle.var_19fb085453713468 = killstreakbundlename;
    function_2ff74098fad17213(killstreaklistentry, streakref);
    globals.streakbundles[streakref] = bundle;
    globals.var_2150da9328528bb9[streakref] = index;
    assert(isstring(streakref));
    streakrefxhash = getxhash(streakref);
    game["dialog"][streakrefxhash] = "killstreak_team_leader" + "_earned";
    game["dialog"][streakref + "_teamleader_friendly_inbound"] = "killstreak_team_leader" + "_ally_callout";
    game["dialog"][streakref + "_teamleader_enemy_inbound"] = "killstreak_team_leader" + "_enemy_callout";
    game["dialog"][streakref + "_teamleader_destroyed"] = "killstreak_team_leader" + "_crash";
    game["dialog"][streakref + "_teamleader_timeout"] = "killstreak_team_leader" + "_timeout";
    streakpoints = bundle.score;

    if(isDefined(streakpoints) && streakpoints > 0) {
      registerscoreinfosharedfunc(hashcat(#"killstreak_", streakref), #"value", streakpoints);
    }

    initializekillstreak(getxhash(streakref));

    if(istrue(level.var_63121fffa39a5238)) {
      [[level.var_b8057c65baf0784a.var_d9f305202f6f3913]](bundle);
    }
  }

  return true;
}

function function_2ff74098fad17213(killstreaklistentry, var_acde90128b823518) {
  if(!isDefined(killstreaklistentry.ref)) {
    assert(isDefined(killstreaklistentry.ref));
    return;
  }

  if(var_acde90128b823518 == "replace_me") {
    return;
  }

  assert(var_acde90128b823518 == killstreaklistentry.ref);
}

function killstreak_savenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }

  if(self isnightvisionon()) {
    self.pers["useNVG"] = 1;
    self.pers["killstreak_forcedNVGOff"] = 1;
    self nightvisionviewoff(1);
    return;
  }

  self.pers["useNVG"] = 0;
  self.pers["killstreak_forcedNVGOff"] = 0;
}

function killstreak_restorenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }

  if(istrue(self.pers["useNVG"])) {
    self nightvisionviewon(1);
    self.pers["killstreak_forcedNVGOff"] = 0;
  }
}

function function_aa5200593ca327d2() {
  if(isDefined(level.killstreakthermalvisionset)) {
    function_c0b0a582ff9e4d57(level.killstreakthermalvisionset);
  }

  function_c0b0a582ff9e4d57("killstreak_thermal");
  function_c0b0a582ff9e4d57("killstreak_thermal_fog");
  function_c0b0a582ff9e4d57("killstreak_flash", 0.1);
  function_c0b0a582ff9e4d57("killstreak_static", 0.1);
  function_c0b0a582ff9e4d57("killstreak_slamzoom", 0.1);
  function_c0b0a582ff9e4d57("killstreak_color_light_damage", 0.1, 0.1, 0.3);
  function_c0b0a582ff9e4d57("killstreak_color_heavy_damage", 0.1, 0.2, 0.5);
  function_c0b0a582ff9e4d57("killstreak_thermal_light_damage", 0.1, 0.1, 0.3);
  function_c0b0a582ff9e4d57("killstreak_thermal_heavy_damage", 0.1, 0.2, 0.5);
  function_c0b0a582ff9e4d57("killstreak_ads_shutter", 0.25, 0.1, 0.25);
  function_c0b0a582ff9e4d57("killstreak_weapon_change_shutter", 0.025, 0.08, 0.15);
}

function function_c0b0a582ff9e4d57(visionsetname, fadeintime, fadewait, fadeouttime) {
  if(!isDefined(level.killstreakvisionsets)) {
    level.killstreakvisionsets = [];
  } else if(isDefined(level.killstreakvisionsets[visionsetname])) {
    return;
  }

  visionsetinfo = spawnStruct();
  visionsetinfo.name = visionsetname;
  visionsetinfo.type = function_a8f5c03158446d60(visionsetname);

  if(!isDefined(fadeintime)) {
    fadeintime = 0;
  }

  visionsetinfo.fadeintime = fadeintime;

  if(!isDefined(fadewait)) {
    fadewait = 0;
  }

  visionsetinfo.fadewait = fadewait;

  if(!isDefined(fadeouttime)) {
    fadeouttime = 0;
  }

  visionsetinfo.fadeouttime = fadeouttime;
  level.killstreakvisionsets[visionsetname] = visionsetinfo;
}

function function_a8f5c03158446d60(visionsetname) {
  visionsetformat = undefined;

  if(issubstr(visionsetname, "thermal")) {
    visionsetformat = "thermal";
  } else if(issubstr(visionsetname, "color")) {
    visionsetformat = "color";
  }

  return visionsetformat;
}

function function_58707ddfdd9744fa(visionsetname) {
  visionsetinfo = function_3de44eb7cdde2614(visionsetname);

  if(!isDefined(visionsetinfo)) {
    return;
  }

  thread function_a271c8ce1dd6c1b1(visionsetinfo);
}

function function_c144de677d9b9175(visionsetname, visionsetstrength) {
  visionsettype = function_a8f5c03158446d60(visionsetname);

  if(!isDefined(visionsetstrength)) {
    visionsetstrength = "light";
  }

  damagevisionset = "killstreak_" + visionsettype + "_" + visionsetstrength + "_damage";
  function_58707ddfdd9744fa(damagevisionset);
}

function function_3de44eb7cdde2614(visionsetname) {
  if(!isDefined(level.killstreakvisionsets) || !isDefined(visionsetname) || !isDefined(level.killstreakvisionsets[visionsetname])) {
    assertmsg("<dev string:x1c>");
    return undefined;
  }

  return level.killstreakvisionsets[visionsetname];
}

function killstreak_waittillexplode(var_e127af0eab592c1a, var_e127ae0eab5929e7, var_e127ad0eab5927b4, var_e127ac0eab592581, var_e127ab0eab59234e, var_e127aa0eab59211b) {
  ent = spawnStruct();

  if(isDefined(var_e127af0eab592c1a)) {
    thread function_e91e598bf5bb2ee5(var_e127af0eab592c1a, ent);
  }

  if(isDefined(var_e127ae0eab5929e7)) {
    thread function_e91e598bf5bb2ee5(var_e127ae0eab5929e7, ent);
  }

  if(isDefined(var_e127ad0eab5927b4)) {
    thread function_e91e598bf5bb2ee5(var_e127ad0eab5927b4, ent);
  }

  if(isDefined(var_e127ac0eab592581)) {
    thread function_e91e598bf5bb2ee5(var_e127ac0eab592581, ent);
  }

  if(isDefined(var_e127ab0eab59234e)) {
    thread function_e91e598bf5bb2ee5(var_e127ab0eab59234e, ent);
  }

  if(isDefined(var_e127aa0eab59211b)) {
    thread function_e91e598bf5bb2ee5(var_e127aa0eab59211b, ent);
  }

  ent waittill("returned", msg, param1, param2, param3, param4, param5, param6, param7, param8);
  ent notify("die");
  explodeinfo = spawnStruct();
  explodeinfo.msg = msg;
  explodeinfo.param1 = param1;
  explodeinfo.param2 = param2;
  explodeinfo.param3 = param3;
  explodeinfo.param4 = param4;
  explodeinfo.param5 = param5;
  explodeinfo.param6 = param6;
  explodeinfo.param7 = param7;
  explodeinfo.param8 = param8;
  return explodeinfo;
}

function function_e91e598bf5bb2ee5(msg, ent) {
  self endon("death");
  ent endon("die");
  self waittill(msg, param1, param2, param3, param4, param5, param6);
  ent notify("returned", msg, param1, param2, param3, param4, param5, param6);
}