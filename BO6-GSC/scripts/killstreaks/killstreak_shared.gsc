/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\killstreaks\killstreak_shared.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\damage_tuning;
#using scripts\common\devgui;
#using scripts\common\targetmarkergroups;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace killstreak_shared;

function registerkillstreakinitfunction(bundlenamexhash, initfunc) {
  if(!isDefined(level.var_cbf94e52a3e25bd9)) {
    level.var_cbf94e52a3e25bd9 = [];
  }

  assert(!isDefined(level.var_cbf94e52a3e25bd9[bundlenamexhash]), "<dev string:x24>");
  level.var_cbf94e52a3e25bd9[bundlenamexhash] = initfunc;
}

function initializekillstreak(streakrefxhash) {
  if(!isDefined(level.var_cbf94e52a3e25bd9)) {
    return;
  }

  initfunc = level.var_cbf94e52a3e25bd9[streakrefxhash];

  if(!isDefined(initfunc)) {
    return;
  }

  level[[initfunc]]();
}

function private function_d9d8a1228a214d71(bundle) {
  assert(isstruct(bundle));

  if(isarray(bundle.airpatrolvehicleentries) && bundle.airpatrolvehicleentries.size == 0) {
    bundle.airpatrolvehicleentries = undefined;
  }

  if(isarray(bundle.crateentries) && bundle.crateentries.size == 0) {
    bundle.crateentries = undefined;
  }

  if(isarray(bundle.vehicleentries) && bundle.vehicleentries.size == 0) {
    bundle.vehicleentries = undefined;
  }

  damage_tuning::function_411e3a9facca4c3(bundle);
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
  globals.var_3ec1b34fdde2c734 = [];
  killstreaklistbundle = getscriptbundle(killstreaklistname);

  if(!isDefined(killstreaklistbundle)) {
    return false;
  }

  if(utility::issharedfuncdefined(#"splash", #"registersplashbundle")) {
    var_77191e87ccd4acdc = utility::getsharedfunc(#"splash", #"registersplashbundle");
  } else {
    var_77191e87ccd4acdc = undefined;
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

    if(!isDefined(streakref) || streakref == "\r+x5") {
      assert(isDefined(streakref));
      continue;
    }

    bundle.var_2666d35833d092b5 = killstreakbundlename;
    function_55b010832f620062(killstreaklistentry, streakref);
    function_d9d8a1228a214d71(bundle);
    globals.streakbundles[streakref] = bundle;
    globals.var_3ec1b34fdde2c734[streakref] = index;
    assert(isstring(streakref));
    streakrefxhash = getxhash(streakref);
    game["1\x9c\xec\xac\xdbS"][streakrefxhash] = "\x1d\xb0\x8f1\xa2j)\xa9n\xcf\xeb\x1c\xee \xd4\x89!i\xb7-\xd3\xf6" + "77\x1d\x8f0%\x01";
    game["1\x9c\xec\xac\xdbS"][streakref + "\xbf\xe6\v9\xf2\xb7*q\xc1+p\x98\xdb\xa1U\xf8\x99\xe4\x128\x98\x13K\x01\xd0)\xf3\xdb"] = "\x1d\xb0\x8f1\xa2j)\xa9n\xcf\xeb\x1c\xee \xd4\x89!i\xb7-\xd3\xf6" + "a\n9\x8a\xde\xf9\b\xc0\x01Q\x1bq\xc7";
    game["1\x9c\xec\xac\xdbS"][streakref + "Y\xc3d\xbf\x96p^\x90\x91>.W/\xeb\xc0\xd5\xd0s\xe8\x03\xa13?\x93\xd1"] = "\x1d\xb0\x8f1\xa2j)\xa9n\xcf\xeb\x1c\xee \xd4\x89!i\xb7-\xd3\xf6" + "\x93p\x80\xcf\xac0\xf8\x1ft\x84\x93\xdb7{";
    game["1\x9c\xec\xac\xdbS"][streakref + "GP}U:\xc4\x17\xdc\x96\x97\xc5\f\xf1=p\x11\x01\xb8\x93\xd2["] = "\x1d\xb0\x8f1\xa2j)\xa9n\xcf\xeb\x1c\xee \xd4\x89!i\xb7-\xd3\xf6" + "M\x03\x9a\xad\xf1@";
    game["1\x9c\xec\xac\xdbS"][streakref + "\xc2\xec\x84s5 \xeb\x8c\xbd\xbf\xfc\x19\x86R\x8c\x89\xb3\xa7s"] = "\x1d\xb0\x8f1\xa2j)\xa9n\xcf\xeb\x1c\xee \xd4\x89!i\xb7-\xd3\xf6" + "\xaf\xd1Z\xb5e\xde]:";
    streakpoints = bundle.score;

    if(isDefined(streakpoints) && streakpoints > 0) {
      namespace_bc7cdace2d7445a5::registerscoreinfosharedfunc(hashcat(#"killstreak_", streakref), #"value", streakpoints);
    }

    initializekillstreak(getxhash(streakref));

    if(istrue(level.var_6e059c9b350b4819)) {
      [[level.var_1fc7bca3dc2a80cb.var_872770300d071926]](bundle);
    }

    if(isDefined(var_77191e87ccd4acdc)) {
      [[var_77191e87ccd4acdc]](streakrefxhash, bundle.earnedsplash);
      [[var_77191e87ccd4acdc]](bundle.usedsplashref, bundle.usedsplash);
    }

    name = isDefined(bundle.name) ? function_6e15e836e5fd519a(bundle.name) : streakref;
    devgui::add_devgui_command("<dev string:x4e>" + name + "<dev string:x70>" + streakref + "<dev string:x76>", "<dev string:x7b>" + streakref + "<dev string:x98>", index);
  }

  return true;
}

function function_55b010832f620062(killstreaklistentry, var_614e30b261ab6da5) {
  if(!isDefined(killstreaklistentry.ref)) {
    assert(isDefined(killstreaklistentry.ref));
    return;
  }

  if(var_614e30b261ab6da5 == "\xe9\xe1\xca\x1e(#\x99u\xf4\xf3") {
    return;
  }

  assert(var_614e30b261ab6da5 == killstreaklistentry.ref);
}

function killstreak_savenvgstate() {
  if(!isDefined(self.pers["I\vFems"])) {
    return;
  }

  if(self isnightvisionon()) {
    self.pers["I\vFems"] = 1;
    self.pers["\x8b\\EM&$\xa1{F[f^\x1c\xd0\xd1\xbc\xc0\\\xa9\xdaM\xd6\xfe"] = 1;
    self nightvisionviewoff(1);
    return;
  }

  self.pers["I\vFems"] = 0;
  self.pers["\x8b\\EM&$\xa1{F[f^\x1c\xd0\xd1\xbc\xc0\\\xa9\xdaM\xd6\xfe"] = 0;
}

function killstreak_restorenvgstate() {
  if(!isDefined(self.pers["I\vFems"])) {
    return;
  }

  if(istrue(self.pers["I\vFems"])) {
    self nightvisionviewon(1);
    self.pers["\x8b\\EM&$\xa1{F[f^\x1c\xd0\xd1\xbc\xc0\\\xa9\xdaM\xd6\xfe"] = 0;
  }
}

function function_8ff66c8aa7307817() {
  if(isDefined(level.killstreakthermalvisionset)) {
    function_9a399b3ab282122(level.killstreakthermalvisionset);
  }

  function_9a399b3ab282122("\x8ab0ay]\xac=\x91\xe9\xc3\xb7\x92\x1e\xa7\xc7\x9bA");
  function_9a399b3ab282122("v\x89\x9b=\x01\xc5A\x1a\x1b\xf2\xb5\xcf\x88\xf7O\x89(\xdb\xc1\xa2c\x8d");
  function_9a399b3ab282122("\xe9`\f\xf64m\x95EQ0\xa2M\xf4\x0f\x14\xea", 0.1);
  function_9a399b3ab282122("\xe6\x169\"\xc7\xefQ\x0e\xce\x8dt\x88\xb2a\x97\xca\x15", 0.1);
  function_9a399b3ab282122("$Y\xb7\x90\xb1\x895.\xfaZTG\xee>>k)\x11\x9c", 0.1);
  function_9a399b3ab282122("\xc2<6\xfeB5j\xf5\xc78\xd7\xc6\xa6.2I\xd90\x9e\xe6\x9e\xb5PE\xd7\x14\x97\xfa6", 0.1, 0.1, 0.3);
  function_9a399b3ab282122("$\xc1~\x11?S\xd8l\xa6\x94\x15\t3\x18\xe5\xe7v\xfdn\x15\x14\xc3-\xe9\xcd\xa4\xe9\xec\xef", 0.1, 0.2, 0.5);
  function_9a399b3ab282122("]\x844~\b\x04]\xe7\xfc\xc23\x87\x92\xf9\xd9+8X>\a\xec\xe7\xad\x9c\xb6\xbc\xd2o\x9f\x1a\x05", 0.1, 0.1, 0.3);
  function_9a399b3ab282122("\xfbI\n\x1eu\x87+\xd4t\t\xbc^\x90\x9f\xac\xb9mr\x1a\x01\xdf\xfe4Dx\x9at\"\x10\xb7\xd4", 0.1, 0.2, 0.5);
  function_9a399b3ab282122("OT\xd8\xd9\xd3kR\xd2\x14S\xb1u%zG9n\xf7\xff\xe6\xd2\xab", 0.25, 0.1, 0.25);
  function_9a399b3ab282122("\xd6\x96l\xd8\xcd:\x93e\xc2[\xf5\xee\xcaX\x83\xf6n_c\x86\xb07\xce\x95\xbe\xe6C\xab\xa3\x1d\xacN", 0.025, 0.08, 0.15);
}

function function_9a399b3ab282122(visionsetname, fadeintime, fadewait, fadeouttime) {
  if(!isDefined(level.killstreakvisionsets)) {
    level.killstreakvisionsets = [];
  } else if(isDefined(level.killstreakvisionsets[visionsetname])) {
    return;
  }

  visionsetinfo = spawnStruct();
  visionsetinfo.name = visionsetname;
  visionsetinfo.type = function_e51c842888687ab5(visionsetname);

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

function function_e51c842888687ab5(visionsetname) {
  if(isxhashasset(visionsetname)) {
    return undefined;
  }

  visionsetformat = undefined;

  if(issubstr(visionsetname, "\x16N\xa2*f\xf0~")) {
    visionsetformat = "\x16N\xa2*f\xf0~";
  } else if(issubstr(visionsetname, "j=J\xe3\x1f")) {
    visionsetformat = "j=J\xe3\x1f";
  }

  return visionsetformat;
}

function function_88145ced909f1df3(visionsetname) {
  visionsetinfo = function_a321967789f8fbb5(visionsetname);

  if(!isDefined(visionsetinfo)) {
    return;
  }

  thread namespace_bc7cdace2d7445a5::function_f30c03015a864aa8(visionsetinfo);
}

function function_420a4c4aa3e43104(visionsetname, visionsetstrength) {
  visionsettype = function_e51c842888687ab5(visionsetname);

  if(!isDefined(visionsetstrength)) {
    visionsetstrength = "T\xf2\xa4:K";
  }

  damagevisionset = "\xe1P+\x1a \xe4\xd7-\xeel\xd8" + visionsettype + "w" + visionsetstrength + "\xd8\xaa\xf4\x17a\xe6\xd4";
  function_88145ced909f1df3(damagevisionset);
}

function function_a321967789f8fbb5(visionsetname) {
  if(!(isDefined(visionsetname) && isDefined(level.killstreakvisionsets) && isDefined(level.killstreakvisionsets[visionsetname]))) {
    assertmsg("<dev string:xc1>");
    return undefined;
  }

  return level.killstreakvisionsets[visionsetname];
}

function killstreak_waittillexplode(var_7bdb7557c8047a4b, var_7ea4ac170c19c7ce, var_e0da166162b98325, var_91df92823882cf18, var_1a15385b1b638aa7, var_aafe5d0574ef05ba) {
  ent = spawnStruct();

  if(isDefined(var_7bdb7557c8047a4b)) {
    thread function_a6a37030da5317a8(var_7bdb7557c8047a4b, ent);
  }

  if(isDefined(var_7ea4ac170c19c7ce)) {
    thread function_a6a37030da5317a8(var_7ea4ac170c19c7ce, ent);
  }

  if(isDefined(var_e0da166162b98325)) {
    thread function_a6a37030da5317a8(var_e0da166162b98325, ent);
  }

  if(isDefined(var_91df92823882cf18)) {
    thread function_a6a37030da5317a8(var_91df92823882cf18, ent);
  }

  if(isDefined(var_1a15385b1b638aa7)) {
    thread function_a6a37030da5317a8(var_1a15385b1b638aa7, ent);
  }

  if(isDefined(var_aafe5d0574ef05ba)) {
    thread function_a6a37030da5317a8(var_aafe5d0574ef05ba, ent);
  }

  ent waittill("s>H\xe6\xfb\xe6Gn", msg, param1, param2, param3, param4, param5, param6, param7, param8);
  ent notify("&\xc7\xee");
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

function function_a6a37030da5317a8(msg, ent) {
  if(msg != "\x1e\xfd\xd1\xa2\a") {
    self endon("\x1e\xfd\xd1\xa2\a");
  }

  ent endon("&\xc7\xee");
  self waittill(msg, param1, param2, param3, param4, param5, param6);
  ent notify("s>H\xe6\xfb\xe6Gn", msg, param1, param2, param3, param4, param5, param6);
}

function private is_indoors(ent) {
  contents = trace::create_contents(0, 1, 0, 1, 1, 0);
  targetpos = ent.origin;
  return !trace::ray_trace_passed(targetpos, targetpos + (0, 0, 10000), ent, contents);
}

function private function_dac8aeed3736a204(killstreakowner) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  suffix = killstreakowner.name;

  if(!isDefined(suffix)) {
    suffix = "";
  }

  self endon("\x8aXW:C\xc6\x06o\xec|\xf6z\xa9\xc2\xd2\xa8\xdec\xfb\x1e\x93\x04\x81J\xc4\xe6kS!c" + suffix);

  while(isDefined(self) && isDefined(killstreakowner.enemytargetmarkergroup) && targetmarkergroups::targetmarkergroupexists(killstreakowner.enemytargetmarkergroup)) {
    if(is_indoors(self)) {
      targetmarkergroupsetentitystate(killstreakowner.enemytargetmarkergroup, self, 1);
    } else {
      targetmarkergroupsetentitystate(killstreakowner.enemytargetmarkergroup, self, 0);
    }

    wait 0.5;
  }
}

function function_265a3618d798b973(killstreakowner) {
  if(!isDefined(killstreakowner.enemytargetmarkergroup) || !targetmarkergroups::targetmarkergroupexists(killstreakowner.enemytargetmarkergroup)) {
    return 0;
  }

  return function_edf64f5b1e5545a0(killstreakowner.enemytargetmarkergroup, self);
}

function private function_78a52b38d95eee99(player) {
  var_344488cff00a0dfc = [];
  var_84506d0b2668e192 = [];
  var_88ee8127e9b5e093 = [];
  players = level.players;

  foreach(player in players) {
    if(level.teambased && player.team == self.team || player == self) {
      var_88ee8127e9b5e093[var_88ee8127e9b5e093.size] = player;
      continue;
    }

    if(player namespace_bc7cdace2d7445a5::hasperksharedfunc("l\xc8\xd9\xfdc\x183\xc3J\xf3\x1e\xda\x8eS{|(\x05\xbf\xe4")) {
      continue;
    }

    if(player namespace_bc7cdace2d7445a5::hasperksharedfunc("\x98Y\x82a-yS\xa3\x10\xd9\xa6\xea\x80k\xb5M\x10\xdf\xa8%q\xb8\xc1^\xaa\a\x11\xbajlZ\x10")) {
      continue;
    }

    var_84506d0b2668e192[var_84506d0b2668e192.size] = player;
    var_344488cff00a0dfc[var_344488cff00a0dfc.size] = player;
  }

  if(!istrue(level.var_269588e119f4b3be)) {
    foreach(vehicle in vehicle_getarray()) {
      isenemy = 0;

      if(level.teambased) {
        team = vehicle.team;

        if(!isDefined(team) || team == "\xba\xa5\x1f\xc9m\x80i") {
          if(isDefined(vehicle.owner)) {
            vehicle.team = vehicle.owner.team;
          }
        }

        if(!isDefined(team)) {
          isenemy = 0;
        } else {
          isenemy = vehicle.team != self.team;
        }
      } else {
        isenemy = isDefined(vehicle.owner) && vehicle.owner != self;
      }

      if(isenemy) {
        var_84506d0b2668e192[var_84506d0b2668e192.size] = vehicle;
      }
    }
  }

  assignments = spawnStruct();
  assignments.var_344488cff00a0dfc = var_344488cff00a0dfc;
  assignments.enemytargetmarkergroup = var_84506d0b2668e192;
  assignments.friendlytargetmarkergroup = var_88ee8127e9b5e093;
  return assignments;
}

function function_4d705363752d249e(var_d4d3ea237c078048, enemymarkerwidget, friendlymarkerwidget, var_95a1304db7ace96a) {
  if(isbot(self)) {
    return;
  }

  if(!isDefined(enemymarkerwidget)) {
    enemymarkerwidget = "\xb0oX\xf3Z\xea\xcd\xff\xfa\x8d-\x1d\xbe\x18K7r\x89\x9a\xb0\x9b";
  }

  if(!isDefined(friendlymarkerwidget)) {
    friendlymarkerwidget = "\x01\x94qN\xb8\xec(*\xe9\x8d\\\xa6\xdfo\xa2\a\xc6|\xe6\xad\xf8_\xbdW";
  }

  var_344488cff00a0dfc = [];
  var_84506d0b2668e192 = [];
  var_88ee8127e9b5e093 = [];
  assignmentfunction = &function_78a52b38d95eee99;

  if(utility::issharedfuncdefined(var_d4d3ea237c078048, #"assigntargetmarkers")) {
    assignmentfunction = utility::getsharedfunc(var_d4d3ea237c078048, #"assigntargetmarkers");
  }

  assignments = self thread[[assignmentfunction]](self);

  if(isDefined(assignments.enemytargetmarkergroup)) {
    var_84506d0b2668e192 = assignments.enemytargetmarkergroup;
  }

  if(isDefined(assignments.friendlytargetmarkergroup)) {
    var_88ee8127e9b5e093 = assignments.friendlytargetmarkergroup;
  }

  if(isDefined(assignments.var_344488cff00a0dfc)) {
    var_344488cff00a0dfc = assignments.var_344488cff00a0dfc;
  }

  self.enemytargetmarkergroup = namespace_bc7cdace2d7445a5::function_6497bf9472d603a9(enemymarkerwidget, self, var_84506d0b2668e192, self, 0, 1, 1);
  self.friendlytargetmarkergroup = namespace_bc7cdace2d7445a5::function_6497bf9472d603a9(friendlymarkerwidget, self, var_88ee8127e9b5e093, self, 1, 1);

  if(!istrue(var_95a1304db7ace96a)) {
    foreach(enemy in assignments.var_344488cff00a0dfc) {
      enemy thread function_dac8aeed3736a204(self);
    }
  }

  self.var_3ed78f3e8fc057c1 = var_344488cff00a0dfc;
  markedgroups = spawnStruct();
  markedgroups.enemies = var_84506d0b2668e192;
  markedgroups.friendlies = var_88ee8127e9b5e093;
  markedgroups.var_344488cff00a0dfc = var_344488cff00a0dfc;
  return markedgroups;
}

function function_871d68d8717aed6d(target, player, var_95a1304db7ace96a) {
  if(isDefined(player.enemytargetmarkergroup) && targetmarkergroups::targetmarkergroupexists(player.enemytargetmarkergroup)) {
    targetmarkergroups::targetmarkergroup_markentity(target, player.enemytargetmarkergroup);

    if(!istrue(var_95a1304db7ace96a)) {
      target thread function_dac8aeed3736a204(player);
    }
  }
}

function function_cd6a4d47309b1361(killstreakowner) {
  if(isDefined(killstreakowner.enemytargetmarkergroup) && targetmarkergroups::targetmarkergroupexists(killstreakowner.enemytargetmarkergroup)) {
    targetmarkergroupsetextrastate(killstreakowner.enemytargetmarkergroup, self, 1);
  }
}

function killstreak_assigntargetmarkers(hideoverlaytargetmarkerfriendly) {
  if(isbot(self)) {
    return;
  }

  var_2991d2d5efbf0046 = [];
  var_2031958bccba554b = [];

  foreach(player in level.players) {
    if(level.teambased && player.team == self.team || player == self) {
      var_2031958bccba554b[var_2031958bccba554b.size] = player;
      continue;
    }

    if(namespace_bc7cdace2d7445a5::hasperksharedfunc("\xfc\x8d\x9fd>\xab\xb3\xf0}\x12$\xf2\xad\xf7\xd5\"+\x15b\x0e\xbdh\xa7}")) {
      continue;
    }

    var_2991d2d5efbf0046[var_2991d2d5efbf0046.size] = player;
  }

  self.enemytargetmarkergroup = targetmarkergroups::targetmarkergroup_on("\xe4J\xf7IIi\xbe\x1e\x96\xa4\xd9\x82\x01\xf7\xe4j'n\x1e\xb9\xde\x19\xb2\x9a", self, var_2991d2d5efbf0046, self, 0, 1, 1);

  if(!istrue(hideoverlaytargetmarkerfriendly)) {
    self.friendlytargetmarkergroup = targetmarkergroups::targetmarkergroup_on("\xc3\x11\xa2\xd3\xfd\xf3\xef\xfc6\xd8C\xdcq\xadA\xcd6M\xf4\xed\x1cuP;\xf9.\xf0", self, var_2031958bccba554b, self, 1, 1);
  }
}

function function_a0c4c04574ea7d74(var_c2cc697243b2f5b6) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  team = self.team;

  if(level.teambased && !isDefined(team)) {
    return;
  }

  while(true) {
    if(isDefined(level.activekillstreaks) && isDefined(self.enemytargetmarkergroup)) {
      foreach(ent in level.activekillstreaks) {
        if(level.teambased && ent.team === team) {
          continue;
        }

        foreach(category in var_c2cc697243b2f5b6) {
          if(!isDefined(category)) {
            continue;
          }

          if(ent.streakname === category || ent.vehiclename === category) {
            targetmarkergroups::targetmarkergroup_markentity(ent, self.enemytargetmarkergroup);
            break;
          }
        }
      }
    }

    waitframe();
  }
}

function function_b592c4693f295af2() {
  if(isbot(self)) {
    return;
  }

  suffix = self.name;

  if(!isDefined(suffix)) {
    suffix = "";
  }

  if(isDefined(self.var_3ed78f3e8fc057c1)) {
    foreach(player in self.var_3ed78f3e8fc057c1) {
      player notify("\x8aXW:C\xc6\x06o\xec|\xf6z\xa9\xc2\xd2\xa8\xdec\xfb\x1e\x93\x04\x81J\xc4\xe6kS!c" + suffix);
    }
  }

  self.var_3ed78f3e8fc057c1 = undefined;
  waitframe();

  if(isDefined(self.enemytargetmarkergroup)) {
    namespace_bc7cdace2d7445a5::function_d3929c5daaadb21d(self.enemytargetmarkergroup);
    self.enemytargetmarkergroup = undefined;
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    namespace_bc7cdace2d7445a5::function_d3929c5daaadb21d(self.friendlytargetmarkergroup);
    self.friendlytargetmarkergroup = undefined;
  }
}

function function_e2e20184ab1f77a9(streakname) {
  bundle = level.streakglobals.streakbundles[streakname];
  assetindex = function_31cdbcf8e68aa5a5(#"scriptbundle_killstreak", bundle.var_2666d35833d092b5);
  self setclientomnvar("\xd4\xc1\xb2\r%U9\xdc\xe3\xd2\x9b)#+d&\xaf{\xbf", assetindex);
}

function function_471b249275df5bee() {
  assetindex = function_31cdbcf8e68aa5a5(#"scriptbundle_killstreak", %"killstreak:killstreak_none");
  self setclientomnvar("\xd4\xc1\xb2\r%U9\xdc\xe3\xd2\x9b)#+d&\xaf{\xbf", assetindex);
}

function starttabletscreen(streakname, dofstartdelay, var_34c474b84511e1c8) {
  screeninfo = function_f995b984f7876b55(streakname);

  if(!isDefined(screeninfo)) {
    return;
  }

  thread tabletomnvarset(screeninfo.omnvar, screeninfo.index);
  bundle = level.streakglobals.streakbundles[streakname];

  if(!istrue(var_34c474b84511e1c8) && (!isDefined(bundle) || !istrue(bundle.var_2b7796681f16a89a))) {
    thread tabletdofset(dofstartdelay, 0);
  }
}

function stoptabletscreen(streakname, var_dae75d81bb1e788c, var_d8c4f138ae3e3edb) {
  screeninfo = function_f995b984f7876b55(streakname);

  if(!isDefined(screeninfo)) {
    return;
  }

  bundle = level.streakglobals.streakbundles[streakname];

  if(istrue(var_d8c4f138ae3e3edb) && (!isDefined(bundle) || !istrue(bundle.var_2b7796681f16a89a))) {
    function_d0b0de1630c75bf2();
  }

  thread tabletomnvarset(screeninfo.omnvar, -1, var_dae75d81bb1e788c);

  if(!isDefined(bundle) || !istrue(bundle.var_2b7796681f16a89a)) {
    thread tabletdofset(var_dae75d81bb1e788c, 1);
  }
}

function tabletomnvarset(omnvar, omnvarval, omnvardelay) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self notify("\xb7\xad\xcd\xceX\xe4\xfa\xcd\xca:\xeb:,\x98\x1b\xac\x1d");
  self endon("\xb7\xad\xcd\xceX\xe4\xfa\xcd\xca:\xeb:,\x98\x1b\xac\x1d");

  if(isDefined(omnvardelay) && omnvardelay > 0) {
    namespace_bc7cdace2d7445a5::function_3c424b8d0d9f5c37(omnvardelay);
  }

  self setclientomnvar(omnvar, omnvarval);
}

function private function_f995b984f7876b55(streakname) {
  if(!isDefined(streakname)) {
    iprintlnbold("<dev string:x14f>");

    return;
  }

  if(isDefined(streakname) && isDefined(level.streakglobals)) {
    screenindex = level.streakglobals.var_3ec1b34fdde2c734[streakname];
  } else {
    screenindex = 0;
  }

  screenomnvar = "W\xb4\xf5'V[\xed:\xac\xd7\x1b\xb7\x9b\xe8\xc9\xedc}\xcd\xb2\x17uVs\xd8e";

  if(!isDefined(screenindex)) {
    screenindex = level.superglobals.staticsuperdata[streakname].id;
    screenomnvar = "\xae\xd2\xd7s\xae\x83e\xc9\xeb\x1d\xc2\x89\xd8\xca\x8e\xeb\xb9\xb2\x8b\xab\xb2\xcd\xb1\xb2";

    if(!isDefined(screenindex)) {
      iprintlnbold("<dev string:x1a0>" + streakname);

      return;
    }
  }

  tabletinfo = spawnStruct();
  tabletinfo.index = screenindex;
  tabletinfo.omnvar = screenomnvar;
  return tabletinfo;
}

function private tabletdofset(dofdelay, stopdof) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self notify("\xf2\xb7I\x9b\x1d:\xb5\xef\xeez\xd9\x89!\xe7");
  self endon("\xf2\xb7I\x9b\x1d:\xb5\xef\xeez\xd9\x89!\xe7");

  if(isDefined(level.var_6c135d25b8e5b84a)) {
    val::group_set(level.var_6c135d25b8e5b84a, 0);
  }

  if(isDefined(dofdelay) && dofdelay > 0) {
    namespace_bc7cdace2d7445a5::function_3c424b8d0d9f5c37(dofdelay);
  }

  if(istrue(stopdof)) {
    function_ef8c27946fcd4535();
  } else {
    function_d0b0de1630c75bf2();
  }

  if(isDefined(level.var_6c135d25b8e5b84a)) {
    val::group_reset(level.var_6c135d25b8e5b84a);
  }
}

function function_d0b0de1630c75bf2() {
  self enablephysicaldepthoffieldscripting();
  self setphysicaldepthoffield(1, 0);
  self setphysicalviewmodeldepthoffield(30, 256);
}

function function_ef8c27946fcd4535() {
  self disablephysicaldepthoffieldscripting();
}

function private function_8dac55841b01d09f(currenttimems, alertstarttimems, alertdurationsec) {
  if(alertdurationsec > 0) {
    timeelapsedsec = utility::function_7db7b41478a3232a(currenttimems - alertstarttimems);
    timefraction = timeelapsedsec / alertdurationsec;
    return clamp(timefraction, 0, 1);
  }

  return 1;
}

function function_adadf8eab8b45e29(var_a844d7d87edf8180, vehicleendtimems, var_d701430d660caedf, var_826cf56026e90b43, var_7cd8239139250d5e, var_c869c69631b09e9d, var_a99a7d199e7d3b5a) {
  self endon("\x1e\xfd\xd1\xa2\a");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  alertdelay = var_a844d7d87edf8180 - var_d701430d660caedf;
  assert(alertdelay >= 0, "<dev string:x1e9>");
  wait alertdelay;
  currenttime = gettime();
  alertstarttime = currenttime;

  while(currenttime < vehicleendtimems) {
    self setscriptablepartstate(#"alert", #"on");
    assert(var_826cf56026e90b43 > 0, "<dev string:x26b>");
    wait var_826cf56026e90b43;
    self setscriptablepartstate(#"alert", #"off");
    lerptimelength = var_d701430d660caedf - var_a99a7d199e7d3b5a;
    assert(lerptimelength >= 0, "<dev string:x291>");
    timefraction = function_8dac55841b01d09f(currenttime, alertstarttime, lerptimelength);
    assert(var_7cd8239139250d5e > 0, "<dev string:x2d9>");
    assert(var_c869c69631b09e9d > 0, "<dev string:x302>");
    currentinterval = math::lerp(var_7cd8239139250d5e, var_c869c69631b09e9d, timefraction);
    wait currentinterval;
    totalwaittime = var_826cf56026e90b43 + currentinterval;

    if(totalwaittime < 0.05) {
      wait 0.05 - totalwaittime;
    }

    currenttime = gettime();
  }
}

function function_cb243c288c444d60(player, vehicle, backoffset, upoffset, camerasphereradius, orbitdistanceoverride, var_487b0868a738aa08, var_933a0d3e01741f7c) {
  focuspos = vehicle.origin + vehicle function_4ee12991d00d7be3();
  camangles = player getplayerangles();
  camforward = anglesToForward(camangles);
  camanglesflat = utility::flat_angle(camangles);
  camforwardflat = anglesToForward(camanglesflat);
  orbitrange = orbitdistanceoverride ?? vehicle function_4b49a9b8feef9ca5();
  desiredcampos = focuspos - orbitrange * camforward - camforwardflat * backoffset + (0, 0, upoffset);
  zoffset = (0, 0, camerasphereradius);

  if(isnumber(var_933a0d3e01741f7c)) {
    zoffset = anglestoup(vehicle.angles) * var_933a0d3e01741f7c;
  }

  collisioncontents = var_487b0868a738aa08 ?? trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  spheretrace = trace::sphere_trace(focuspos + zoffset, desiredcampos, camerasphereradius, vehicle, collisioncontents);
  result = spawnStruct();
  result.success = 0;

  if(spheretrace["\xda\x16\x81\aw}^i"] > 0) {
    result.success = 1;
    result.focuspos = focuspos;
    result.camerapos = spheretrace["1\xfd\x12\"\x9a\a\xf8\xb9\xbd\xf2\x16^\xb2M"];
  }

  return result;
}