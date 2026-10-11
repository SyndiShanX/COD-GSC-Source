/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\dmz_ai_chopper.gsc
******************************************************/

#using script_646d60ff2fbd4ff2;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_util;
#using scripts\mp\outofbounds;
#using scripts\mp\poi;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace dmz_ai_chopper;

function debug() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_75b3234f60e90b47", 0) == 1) {
      namespace_fd5db9939c683aa4::function_6aa2e7131056a6a2(level.players[0].origin);
      setDvar(@ "hash_75b3234f60e90b47", 0);
    }
  }
}

function function_4c4df9aeb773709a(pos, vehicle, model, patrolradius, name) {
  patrollocation = pos;

  if(!isDefined(patrolradius)) {
    patrolradius = 4000;
  }

  startingposition = scripts\cp_mp\killstreaks\chopper_support::getpathstart(patrollocation);
  startingangles = vectortoangles(patrollocation - startingposition);
  startingposition = drop_to_ground(startingposition);
  startingposition += (0, 0, level.var_103b912267715093);
  chopper = spawnVehicle(model, "dmz_ai_chopper", vehicle, startingposition, startingangles);

  if(!isDefined(chopper)) {
    return;
  }

  chopper.poi = scripts\mp\poi::poi_findpoioriginisin(pos);
  chopper.speed = 60;
  chopper.originalspeed = chopper.speed;
  chopper.accel = 50;
  chopper.var_5424df833ac6a6f2 = chopper.accel;
  chopper.lifetime = 9999;
  chopper.team = "team_hundred_ninety_five";
  fakeowner = scripts\mp\ai_mp_controller::function_af3034a7c69d7edb("team_hundred_ninety_five");
  chopper.owner = fakeowner;
  chopper.angles = startingangles;
  chopper.flaresreservecount = 2;
  chopper.pathstart = startingposition;
  chopper.pathgoal = patrollocation;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.heightoffset = (0, 0, 1500);
  chopper.ignoreengagedist = getdvarint(@ "hash_db1f71003929b40e", 1) == 1;
  chopper.fpatrol = 1;
  chopper.handleeventcallback = &function_9910a6cd29958a7f;
  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setvehicleteam(chopper.team);
  chopper.ignorelist = [chopper];
  chopper.stage3accradius = 35;
  chopper.crashoffset = chopper.heightoffset[2] - 250;
  chopper.currenthealth = level.var_426503bd899fe79d;
  chopper.health = level.var_426503bd899fe79d;
  chopper.maxhealth = level.var_426503bd899fe79d;
  chopper.damagestate = 0;
  chopper scripts\mp\sentientpoolmanager::registersentient("Level_Vehicle", chopper.team);
  chopper.threatlist = [];
  chopper.patrolwaittime = 0;
  chopper.var_31a7627753153dae = 6;
  chopper.currentstate = "patrol";
  chopper.patrollocation = patrollocation;
  chopper.patrolradius = patrolradius;
  chopper.var_445449fe0511cad6 = 0;
  chopper.funcs["patrol"] = &chopper_patrol;
  chopper.funcs["idle"] = &chopper_idle;
  chopper.funcs["attack"] = &chopper_attack;
  chopper thread chopper_think();
  chopper thread function_5159bd9771a61868();
  chopper thread function_a4f67639da6c8a7d();
  chopper vehicleshowonminimap(0);
  chopper.vehiclename = name;
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(chopper.vehiclename, &chopper_postmodifydamage);
  scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, &chopper_handledeathdamage);

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    chopper thread[[getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
  }

  chopper thread function_6ccd7cebb1144062();

  return chopper;
}

function function_9910a6cd29958a7f(vehicle, ent, position, normal, normalspeed) {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

  if(isDefined(driver)) {
    function_3be784d69cc30a0(driver, 500, 1);

    if(self.currentstate != "attack") {
      function_7743aeff79a08975("idle");
    }
  }
}

function chopper_postmodifydamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::function_400022dabdb64055(data);

  if(isDefined(self.postmodifydamage)) {
    self thread[[self.postmodifydamage]](data);
  }

  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    function_3be784d69cc30a0(data.attacker, data.damage, 1);

    if(self.currentstate != "attack") {
      function_7743aeff79a08975("idle");
    }
  }

  return true;
}

function chopper_think() {
  self endon("death");
  self endon("explode");

  while(true) {
    [[self.funcs[self.currentstate]]]();
    waitframe();
  }
}

function chopper_handledeathdamage(data) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  self notify("death");
  return true;
}

function function_5159bd9771a61868() {
  self endon("death");

  while(true) {
    if(isDefined(self.poi)) {
      foreach(player in level.poi[self.poi]["players"]) {
        function_3be784d69cc30a0(player, 10);
      }
    }

    wait 10;
  }
}

function chopper_patrol() {
  self endon("death");
  self endon("state_change");
  self clearlookatent();
  self setneargoalnotifydist(300);

  if(!istrue(self.fpatrol)) {
    self vehicle_setspeed(20, 20);
  }

  self.fpatrol = 0;
  newgoal = self.patrollocation + anglesToForward((0, self.var_445449fe0511cad6, 0)) * int(self.patrolradius / 1.2);
  self.var_445449fe0511cad6 += 360 / self.var_31a7627753153dae;

  if(self.var_445449fe0511cad6 >= 360) {
    self.var_445449fe0511cad6 -= 360;
  }

  function_276c4659222d7c6a(newgoal, self.patrolwaittime > 0);
  wait self.patrolwaittime;
  self vehicle_setspeed(self.originalspeed, self.var_5424df833ac6a6f2);
  self.currentstate = "idle";
}

function function_7743aeff79a08975(state) {
  self.currentstate = state;
  self vehicle_setspeed(self.originalspeed, self.var_5424df833ac6a6f2);
  self notify("state_change");
}

function chopper_idle() {
  self endon("death");
  self endon("state_change");
  target = function_ef8a0089f2c25099();

  if(isDefined(target)) {
    self.currenttarget = target;
    self.currentstate = "attack";
    return;
  }

  self.currentstate = "patrol";
}

function chopper_attack() {
  self endon("death");
  self endon("state_change");
  self.fpatrol = 1;

  if(!isDefined(self.currenttarget)) {
    self.currentstate = "patrol";
    return;
  }

  if(isDefined(self.attackfunc)) {
    self[[self.attackfunc]](self.threatlist[self.currenttarget].player);
    return;
  }

  self.currentstate = "patrol";
}

function function_3be784d69cc30a0(player, value, ignoredist) {
  if(!isDefined(player) || !isDefined(player.guid)) {
    return;
  }

  if(!isDefined(self.threatlist[player.guid])) {
    self.threatlist[player.guid] = spawnStruct();
    self.threatlist[player.guid].player = player;
    self.threatlist[player.guid].threat = 0;
    self.threatlist[player.guid].ignoredist = 0;
  }

  if(istrue(ignoredist)) {
    self.threatlist[player.guid].ignoredist = ignoredist;
  }

  if(!isDefined(self.var_2edb1bbb4ad168ef) || !isDefined(self.var_38076ea016478f2f)) {
    self.var_2edb1bbb4ad168ef = player.guid;
    self.var_38076ea016478f2f = player.guid;
  } else if(!isDefined(self.threatlist[player.guid].up) && !isDefined(self.threatlist[player.guid].down) && self.var_38076ea016478f2f != player.guid) {
    self.threatlist[self.var_2edb1bbb4ad168ef].down = player.guid;
    self.threatlist[player.guid].up = self.var_2edb1bbb4ad168ef;
    self.var_2edb1bbb4ad168ef = player.guid;
  }

  self.threatlist[player.guid].threat += value;

  if(value > 0) {
    if(self.var_38076ea016478f2f == player.guid) {
      return;
    }

    checkid = self.threatlist[player.guid].up;
    checkedids = [];

    while(isDefined(checkid) && self.threatlist[checkid].threat < self.threatlist[player.guid].threat) {
      if(array_contains(checkedids, checkid)) {
        self.threatlist = [];
        self.var_38076ea016478f2f = undefined;
        self.var_2edb1bbb4ad168ef = undefined;
        return;
      }

      checkedids[checkedids.size] = checkid;
      checkid = self.threatlist[checkid].up;
    }

    if(!isDefined(checkid) || checkid != self.threatlist[player.guid].up) {
      function_83388ed388ddbddc(player.guid);
      function_9e2e41a3f8f5ded(player.guid, checkid);
    }

    return;
  }

  if(self.threatlist[player.guid].threat <= 0) {
    function_83388ed388ddbddc(player.guid);
    return;
  }

  if(self.var_2edb1bbb4ad168ef == player.guid) {
    return;
  }

  checkid = self.threatlist[player.guid].down;
  checkedids = [];

  while(isDefined(checkid) && self.threatlist[checkid].threat > self.threatlist[player.guid].threat) {
    if(array_contains(checkedids, checkid)) {
      self.threatlist = [];
      self.var_38076ea016478f2f = undefined;
      self.var_2edb1bbb4ad168ef = undefined;
      return;
    }

    checkedids[checkedids.size] = checkid;
    checkid = self.threatlist[checkid].down;
  }

  if(!isDefined(checkid) || checkid != self.threatlist[player.guid].down) {
    function_83388ed388ddbddc(player.guid);
    function_9e2e41a3f8f5ded(player.guid, self.threatlist[checkid].up);
  }
}

function function_83388ed388ddbddc(guid) {
  if(self.var_38076ea016478f2f == guid && self.var_2edb1bbb4ad168ef == guid) {
    self.var_38076ea016478f2f = undefined;
    self.var_2edb1bbb4ad168ef = undefined;
    return;
  }

  if(isDefined(self.threatlist[guid].down)) {
    if(!isDefined(self.threatlist[guid].up)) {
      self.var_38076ea016478f2f = self.threatlist[guid].down;
    }

    self.threatlist[self.threatlist[guid].down].up = self.threatlist[guid].up;
  }

  if(isDefined(self.threatlist[guid].up)) {
    if(!isDefined(self.threatlist[guid].down)) {
      self.var_2edb1bbb4ad168ef = self.threatlist[guid].up;
    }

    self.threatlist[self.threatlist[guid].up].down = self.threatlist[guid].down;
  }
}

function function_9e2e41a3f8f5ded(guid, guidbefore) {
  if(!isDefined(guidbefore)) {
    self.threatlist[self.var_38076ea016478f2f].up = guid;
    self.threatlist[guid].down = self.var_38076ea016478f2f;
    self.threatlist[guid].up = undefined;
    self.var_38076ea016478f2f = guid;
    return;
  }

  if(isDefined(self.threatlist[guidbefore].down)) {
    self.threatlist[self.threatlist[guidbefore].down].up = guid;
  }

  self.threatlist[guid].down = self.threatlist[guidbefore].down;
  self.threatlist[guidbefore].down = guid;
  self.threatlist[guid].up = guidbefore;

  if(!isDefined(self.threatlist[guid].down)) {
    self.var_2edb1bbb4ad168ef = guid;
  }
}

function function_204882e766bf721d() {
  while(true) {
    foreach(agent in level.agentarray) {
      if(!isDefined(agent.guid)) {
        continue;
      }

      if(percent_chance(50)) {
        function_3be784d69cc30a0(agent, randomint(400));
      }
    }

    wait 1;
  }
}

function function_6ccd7cebb1144062() {
  while(true) {
    if(getdvarint(@ "hash_9fea139a8dd1eaae", 0) == 1) {
      self notify("<dev string:x1c>");
      choppersupport_crash(100, level.players[0].origin);
      setDvar(@ "hash_9fea139a8dd1eaae", 0);
    }

    wait 1;
  }
}

function function_ef8a0089f2c25099() {
  checkedids = [];

  for(checktargetid = self.var_38076ea016478f2f; isDefined(checktargetid) && isDefined(self.threatlist[checktargetid]); checktargetid = self.threatlist[checktargetid].down) {
    if(array_contains(checkedids, checktargetid)) {
      self.threatlist = [];
      self.var_38076ea016478f2f = undefined;
      self.var_2edb1bbb4ad168ef = undefined;
      return undefined;
    }

    checkedids[checkedids.size] = checktargetid;
    threatinfo = self.threatlist[checktargetid];

    if(function_9eda5834c2fa3898(threatinfo)) {
      canseetarget = chopper_canseetarget(threatinfo.player);

      if(canseetarget) {
        return checktargetid;
      }
    }
  }

  return undefined;
}

function chopper_canseetarget(targetplayer, overridetestpoint) {
  if(targetplayer.notarget) {
    return 0;
  }

  contentsoverride = create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1, 0);
  ignorelist = self.ignorelist;

  if(isDefined(targetplayer.externalvehicle)) {
    ignorelist[ignorelist.size] = targetplayer.externalvehicle;

    if(isDefined(targetplayer.externalvehicle.turrets)) {
      ignorelist = array_combine(ignorelist, targetplayer.externalvehicle.turrets);
    }
  }

  linkedchildren = self getlinkedchildren();

  if(isDefined(linkedchildren)) {
    foreach(child in linkedchildren) {
      ignorelist[ignorelist.size] = child;
    }
  }

  if(isDefined(targetplayer.vehicle)) {
    ignorelist[ignorelist.size] = targetplayer.vehicle;
  }

  return ray_trace_passed(ter_op(isDefined(overridetestpoint), overridetestpoint, self.origin), targetplayer gettagorigin("j_head"), ignorelist, contentsoverride);
}

function tracegroundpoint(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  currz = self.origin[2] + 2000;
  minz = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates) {
      ignorelist[ignorelist.size] = crate;
    }
  }

  trc = sphere_trace((x, y, currz), (x, y, z), 800, ignorelist, undefined, 1);

  if(trc["position"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["position"][2];
  }

  return hightrace;
}

function getcorrectheight(x, y, rand) {
  offgroundheight = self.heightoffset[2];
  groundheight = tracegroundpoint(x, y);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(rand);
  return trueheight;
}

function function_e9cb677b6ba63162(target, dist, checks, startrot) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(startrot)) {
    startrot = 0;
  }

  toheli = self.origin - target.origin;
  toheli = vectorNormalize((toheli[0], toheli[1], 0)) * dist;
  rot = startrot;

  while(rot < startrot + 360) {
    testpos = rotatevector(toheli, (0, rot, 0));
    testpos += target.origin + self.heightoffset;

    if(scripts\mp\outofbounds::ispointinoutofbounds(testpos)) {} else {
      contentsoverride = create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
      canseetarget = chopper_canseetarget(target, testpos);

      if(canseetarget) {
        self setlookatent(target);
        function_276c4659222d7c6a(testpos, 1);
        return true;
      }
    }

    rot += 360 / checks;
  }

  return false;
}

function function_9f656e924a854c1b(target, dist, checks, startrot, overrideheight, var_4f4c3a288df043c0, var_5f1f469d27d6af1a) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target) || !isreallyalive(target)) {
    return false;
  }

  toheli = self.origin - target.origin;
  toheli = vectorNormalize((toheli[0], toheli[1], 0)) * dist;

  if(!isDefined(var_4f4c3a288df043c0)) {
    var_4f4c3a288df043c0 = 2;
  }

  if(!isDefined(startrot)) {
    startrot = 0;
  }

  rot = startrot;

  while(rot < startrot + 360) {
    if(!isDefined(target) || !isreallyalive(target)) {
      return false;
    }

    testdir = rotatevector(toheli, (0, rot, 0));
    testpos = testdir + target.origin + ter_op(isDefined(overrideheight), (0, 0, overrideheight), self.heightoffset);
    contentsoverride = create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
    canseetarget = chopper_canseetarget(target);
    canpathforward = ray_trace_passed(testpos, testpos - testdir * var_4f4c3a288df043c0, self.ignorelist, contentsoverride);

    if(canseetarget && canpathforward) {
      self.strafing = 1;
      function_276c4659222d7c6a(testpos, 1, (0, 0, 0), 1);
      self vehicle_setspeed(self.originalspeed * 2, self.accel);
      wait 1.5;
      self clearlookatent();

      if(!isDefined(target) || !isreallyalive(target)) {
        return false;
      }

      self notify("strafe_start");

      if(isDefined(self.funcs["strafe"])) {
        self thread[[self.funcs["strafe"]]](target);
      }

      function_276c4659222d7c6a(testpos - testdir * var_4f4c3a288df043c0, !isDefined(var_5f1f469d27d6af1a), undefined, 1);
      self notify("strafe_end");
      self vehicle_setspeed(self.originalspeed, self.accel);

      if(!isDefined(target) || !isreallyalive(target)) {
        return false;
      }

      self setlookatent(target);
      self.strafing = 0;
      return true;
    }

    rot += 360 / checks;
  }

  return false;
}

function function_276c4659222d7c6a(target, forcestopatgoal, forceheight, ignoreblocks) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("state_change");
  newpos = undefined;
  testtarget = target;

  if(!isvector(target)) {
    testtarget = target.origin;
  }

  ignorelist = self.ignorelist;
  linkedchildren = self getlinkedchildren();

  if(isDefined(linkedchildren)) {
    foreach(child in linkedchildren) {
      ignorelist[ignorelist.size] = child;
    }
  }

  while(true) {
    currentpos = self.origin;
    initialgoalpos = testtarget * (1, 1, 0) + (0, 0, self.origin[2]);
    obstructed = 0;
    xpos = testtarget[0];
    ypos = testtarget[1];

    if(istrue(ignoreblocks)) {
      obstructiontrace = sphere_trace(currentpos, initialgoalpos, 512, ignorelist);

      if(isDefined(obstructiontrace)) {
        if(obstructiontrace["hittype"] != "hittype_none") {
          xpos = obstructiontrace["position"][0];
          ypos = obstructiontrace["position"][1];
          obstructed = 1;
        }
      }
    }

    if(isDefined(forceheight)) {
      newpos = testtarget + forceheight;
    } else if(istrue(self.evasivemaneuvers)) {
      newx = xpos + randomintrange(-500, 500);
      newy = ypos + randomintrange(-500, 500);
      properz = getcorrectheight(newx, newy, 350);
      newpos = (newx, newy, properz);
    } else {
      properz = getcorrectheight(xpos, ypos, 20);
      newpos = (xpos, ypos, properz);
    }

    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    self setvehgoalpos(newpos, stopatgoal);
    waittill_any_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(obstructed)) {
      break;
    }
  }
}

function function_9eda5834c2fa3898(targetinfo) {
  extracheck = !isDefined(self.var_f09811d8bb92df96) || self[[self.var_f09811d8bb92df96]](targetinfo.player);
  extracheck &= targetinfo.ignoredist || isreallyalive(targetinfo.player) && distance2dsquared(self.origin, targetinfo.player.origin) < 36000000;
  targetinfo.ignoredist = 0;
  return isDefined(targetinfo.player) && !targetinfo.player.notarget && isreallyalive(targetinfo.player) && extracheck;
}

function function_a4f67639da6c8a7d() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  owner = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon)) {
      choppersupport_crash(100);
    }
  }

  chopper_explode();
}

function chopper_explode() {
  self notify("explode");
  self notify("state_change");
  self radiusdamage(self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(self.lootfunc)) {
    self[[self.lootfunc]]();
  }

  wait 0.35;
  chopper_cleanup(1);
}

function choppersupport_crash(speed, var_1f1fbcef1d9b080a) {
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  var_6847739e80fb4e81 = function_e2c4e07ce9823056(3500, 500, 1000);

  if(isDefined(var_1f1fbcef1d9b080a)) {
    var_6847739e80fb4e81 = var_1f1fbcef1d9b080a;
  }

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread chopper_spinout(speed);
  self vehicle_turnengineoff();
  waittill_any_timeout_2(5, "collision", "near_goal");
}

function function_e2c4e07ce9823056(crashdist, var_6c56ff5ecc704c48, var_6c7af55ecc98b102) {
  crashstart = self.origin;
  crashoffset = self.crashoffset;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self) && !scripts\mp\outofbounds::ispointinoutofbounds(crashend)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function chopper_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.4);
    wait 0.5;
  }
}

function chopper_splash(bossorigin, poiname) {
  if(level.var_eda461803cdadc2c < 0) {
    return;
  }

  if(level.var_eda461803cdadc2c > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, bossorigin) < level.var_eda461803cdadc2c) {
        playerlist[playerlist.size] = player;
      }
    }
  } else {
    playerlist = level.players;
  }

  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_boss_chopper_inbound", playerlist, poiname);
  scripts\cp_mp\overlord::playevent("boss_near", playerlist);
}

function chopper_droploot() {
  droplocation = chopper_finddroplocation(self.origin + (0, 0, 500));

  if(isDefined(droplocation)) {
    plundercrate = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrate(self.origin, droplocation);
    triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(plundercrate);
    triggerobject.usetimeoverride = 10;
  }
}

function chopper_finddroplocation(starttrace) {
  droplocation = undefined;
  endtrace = starttrace - (0, 0, 20000);
  ignorelist = [self, self.frontturret];
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignorelist);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    droplocation = trace["position"];
  }

  return droplocation;
}

function chopper_oncrateuse(player) {
  self.itemsdropped = 0;
  pickups = [];

  for(i = 0; i < 3; i++) {
    pos = drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (20, 0, 0), 120 * i));
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(pos);
    streak = ter_op(percent_chance(50), "brloot_killstreak_clusterstrike", "brloot_killstreak_precision_airstrike");
    pickup = scripts\mp\gametypes\br_pickups::spawnpickup(streak, dropinfo, 1);
    self.itemsdropped++;
  }

  for(i = 0; i < 8; i++) {
    pos = drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (40, 0, 0), 45 * i));
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(pos);
    var_8a3a7194e96ea2c = ter_op(i % 2 == 0, "brloot_valuable_goldbar", "brloot_plunder_cash_rare_1");
    pickup = scripts\mp\gametypes\br_pickups::spawnpickup(var_8a3a7194e96ea2c, dropinfo, 1);
    self.itemsdropped++;
  }

  for(i = 0; i < 6; i++) {
    var_1e251ffd71396d15 = random(["brloot_weapon_sm_papa90_rare", "brloot_weapon_sh_romeo870_rare", "brloot_weapon_sn_sbeta_lege"]);
    itemname = ter_op(i % 3 == 0, "brloot_armor_plate", var_1e251ffd71396d15);
    itemamount = ter_op(i % 3 == 0, 8, 1);
    pos = drop_to_ground(self.origin + rotatepointaroundvector((0, 0, 1), (30, 0, 0), 60 * i));
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(pos);
    pickup = scripts\mp\gametypes\br_pickups::spawnpickup(itemname, dropinfo, itemamount);
    pickups[pickups.size] = pickup;
    self.itemsdropped++;
  }

  foreach(ent in pickups) {
    ent.lootsource = "loot_chopper";
  }
}

function chopper_cleanup(wasdestroyed) {
  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}