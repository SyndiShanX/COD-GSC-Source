/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_dfbffa20f9a73d.gsc
***********************************************/

#using script_3d2770dc09c1243;
#using script_59ff79d681bb860c;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#namespace namespace_63bf3f1fa5dc2ff7;

function init() {
  var_36effc06510c1738 = spawnStruct();
  var_36effc06510c1738.doors = [];
  var_36effc06510c1738.total = 0;
  var_36effc06510c1738.success = 0;
  var_36effc06510c1738.var_baace84a7c08f5dd = [];
  level.mit.door = var_36effc06510c1738;
  doors = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "door");

  foreach(door in doors) {
    state = door getscriptablepartstate("door", 1);
    islocked = door function_fac544c98a3d9eb4();
    assert(!islocked);

    if(!isDefined(state) || state != "closed") {
      continue;
    }

    doormidpoint = door function_d90515f5e17dbc6f();

    if(!ispointonnavmesh(doormidpoint)) {
      continue;
    }

    door.failedtimes = 0;
    level.mit.door.doors[level.mit.door.doors.size] = door;
  }

  level.mit.door.total = level.mit.door.doors.size;
}

function testprocess() {
  assert(!isDefined(self.mit.var_97dd4f64f6425eaa));
  self botsetdifficultysetting("slideChance", 0);
  self.mit.onplayerkilled = &onplayerkilled;

  if(level.mit.door.doors.size <= 0) {
    return;
  }

  door = function_8563e304ebeb864e();
  self.mit.var_97dd4f64f6425eaa = door;

  if(!function_72a26ae8088df617(door)) {
    function_b2c0521b89512ba9(door);
    return;
  }

  doorinfo = function_5e5bd9a8b8896f3a(door);
  self.mit.var_97dd4f64f6425eaa.doorinfo = doorinfo;

  if(!isDefined(doorinfo)) {
    function_3ea375eb460f79a4("can't find test pos", self, undefined, door, undefined, undefined, 0);
    self.mit.var_97dd4f64f6425eaa.testingresult = 0;
    return;
  }

  var_d22fdca158e266e = 20;
  failedresult = botteleport(doorinfo.var_5394fc468396843c, var_d22fdca158e266e);

  if(isDefined(failedresult)) {
    function_3ea375eb460f79a4("teleport failed/" + failedresult, self, self.origin, door, doorinfo.var_5394fc468396843c, doorinfo.var_518a4e9f2d3b108d, 0);
    self.mit.var_97dd4f64f6425eaa.testingresult = 0;
    return;
  }

  self.mit.var_97dd4f64f6425eaa.testingresult = 0;

  for(targetpositions = [doorinfo.var_518a4e9f2d3b108d, doorinfo.var_5394fc468396843c]; targetpositions.size > 0; targetpositions = array_remove(targetpositions, nextpos)) {
    nextpos = targetpositions[0];

    if(!function_41eeb1b4bf5b7790(self, doorinfo, nextpos)) {
      break;
    }
  }

  door scriptabledoorclose();

  if(isDefined(self.mit.var_97dd4f64f6425eaa.testingresult)) {
    self.mit.var_97dd4f64f6425eaa.testingresult = targetpositions.size <= 0;
  }
}

function endhandler() {
  if(isDefined(self)) {
    if(isDefined(self.mit.var_97dd4f64f6425eaa) && isDefined(self.mit.var_97dd4f64f6425eaa.testingresult)) {
      if(istrue(self.mit.var_97dd4f64f6425eaa.testingresult)) {
        level.mit.door.success++;
      } else {
        door = self.mit.var_97dd4f64f6425eaa;
        door.failedtimes++;

        if(door.failedtimes >= 3) {
          level.mit.door.var_baace84a7c08f5dd[level.mit.door.var_baace84a7c08f5dd.size] = door.doorinfo;
          failinfo = door.var_b5968e1bb5f3a13d;
          report(failinfo.situation, failinfo.bot, failinfo.lastposition, door, failinfo.var_5394fc468396843c, failinfo.var_518a4e9f2d3b108d, failinfo.ispassed);
        } else {
          function_b2c0521b89512ba9(self.mit.var_97dd4f64f6425eaa);
        }
      }

      if(level.mit.door.success + level.mit.door.var_baace84a7c08f5dd.size >= level.mit.door.total) {
        reportstring = "Test result: " + level.mit.door.total + " doors, " + level.mit.door.success + " successes, " + level.mit.door.var_baace84a7c08f5dd.size + " failures.";
        outputlog("Door", reportstring);
      }
    }

    self botsetflag("disable_movement", 0);
    self.mit.var_97dd4f64f6425eaa = undefined;
  }
}

function private function_8563e304ebeb864e() {
  assert(level.mit.door.doors.size > 0);
  lastindex = level.mit.door.doors.size - 1;
  door = level.mit.door.doors[lastindex];
  level.mit.door.doors = array_remove_index(level.mit.door.doors, lastindex);
  return door;
}

function private function_b2c0521b89512ba9(door) {
  level.mit.door.doors = array_insert(level.mit.door.doors, door, 0);
}

function private function_3ea375eb460f79a4(situation, bot, lastposition, door, var_5394fc468396843c, var_518a4e9f2d3b108d, ispassed) {
  failinfo = spawnStruct();
  failinfo.situation = situation;
  failinfo.bot = bot;
  failinfo.lastposition = lastposition;
  failinfo.var_5394fc468396843c = var_5394fc468396843c;
  failinfo.var_518a4e9f2d3b108d = var_518a4e9f2d3b108d;
  failinfo.ispassed = ispassed;
  door.var_b5968e1bb5f3a13d = failinfo;
}

function function_3113f44ebafe71b1() {
  return level.mit.door.doors.size > 0;
}

function private function_72a26ae8088df617(door) {
  if(door scriptabledoorisclosed()) {
    return 1;
  }

  door scriptabledoorclose();
  wait 1;
  return door scriptabledoorisclosed();
}

function private function_5e5bd9a8b8896f3a(door) {
  var_dd4626b0fa4445e2 = [50, 70, 100];
  var_a53088f1b67dde16 = 50;
  var_29e0b716037acbd9 = 1.25;
  doormidpoint = door function_d90515f5e17dbc6f();

  foreach(dis in var_dd4626b0fa4445e2) {
    var_5394fc468396843c = function_f8350ab882cc2439(doormidpoint + anglesToForward(door.angles + (0, -90, 0)) * dis);
    var_5394fc468396843c = drop_to_ground(var_5394fc468396843c, var_a53088f1b67dde16);
    var_518a4e9f2d3b108d = function_f8350ab882cc2439(doormidpoint + anglesToForward(door.angles + (0, 90, 0)) * dis);
    var_518a4e9f2d3b108d = drop_to_ground(var_518a4e9f2d3b108d, var_a53088f1b67dde16);

    if(distance(var_5394fc468396843c, var_518a4e9f2d3b108d) <= 2 * dis * var_29e0b716037acbd9) {
      doorinfo = spawnStruct();
      doorinfo.door = door;
      doorinfo.originangle = door.angles;
      doorinfo.var_5394fc468396843c = var_5394fc468396843c;
      doorinfo.var_518a4e9f2d3b108d = var_518a4e9f2d3b108d;
      doorinfo.midpoint = doormidpoint;
      return doorinfo;
    }
  }

  return undefined;
}

function private function_41eeb1b4bf5b7790(bot, doorinfo, targetpos) {
  var_e68c4bb8093910b8 = 4.5;
  var_3961ee7d4ad90424 = 0.25;
  ispassed = 0;
  tickstart = function_71b519a5e0525acc();
  lastposition = bot.origin;

  while(true) {
    bot setscriptgoal(targetpos, 16);
    result = function_b564050a363f08ec(bot, var_3961ee7d4ad90424);

    if(!ispassed) {
      ispassed = function_d750fac76a6017c9(doorinfo, lastposition, bot.origin);
      lastposition = bot.origin;
    }

    if(result == "goal") {
      if(!ispassed) {
        function_3ea375eb460f79a4("bypass the door", bot, lastposition, doorinfo.door, doorinfo.var_5394fc468396843c, doorinfo.var_518a4e9f2d3b108d, ispassed);
        return false;
      }

      break;
    }

    if(gettimescale() == 4) {
      limitduration = var_e68c4bb8093910b8 * 2.125 / var_e68c4bb8093910b8 / 4;
    } else {
      limitduration = var_e68c4bb8093910b8;
    }

    if((result == "timeout" || result == "bad_path_stuck") && function_71b519a5e0525acc() - tickstart < limitduration * 1000) {
      continue;
    } else if(result == "bad_path_door_blocker_door_owner" || result == "bad_path_door_blocker_invalid_client") {
      doorinfo.door scriptabledoorclose();
      function_b2c0521b89512ba9(doorinfo.door);
      bot.mit.var_97dd4f64f6425eaa.testingresult = undefined;
      return false;
    }

    function_3ea375eb460f79a4(result, bot, lastposition, doorinfo.door, doorinfo.var_5394fc468396843c, doorinfo.var_518a4e9f2d3b108d, ispassed);
    return false;
  }

  return true;
}

function private function_d750fac76a6017c9(doorinfo, startpos, endpos) {
  var_1e35e50e4b93eab6 = 64;
  var_11855ac71db6dc0d = doorinfo.door.origin;
  var_1a2dfa0e910c8a94 = var_11855ac71db6dc0d + anglesToForward(doorinfo.originangle) * var_1e35e50e4b93eab6;
  return function_3c55380b5e177254(startpos, endpos, var_11855ac71db6dc0d, var_1a2dfa0e910c8a94);
}

function private onplayerkilled(deathdata) {
  if(!isbot(self)) {
    return;
  }

  report("death", self, self.lastdeathpos, self.mit.var_97dd4f64f6425eaa, undefined, undefined, 0);
}

function private report(situation, bot, lastposition, door, var_5394fc468396843c, var_518a4e9f2d3b108d, ispassed) {
  if(!istrue(level.mit.door.var_95c5f763c7b38e9c)) {
    header = "#time; #situation; #bot; #lastPosition; #doorIndex; #doorOrigin; #beforeDoorPos; #afterDoorPos; #isPassed";
    outputlog("Door", header);
    level.mit.door.var_95c5f763c7b38e9c = 1;
  }

  unknownpos = "unknownPos";
  lastposition = ter_op(isDefined(lastposition), lastposition, unknownpos);
  var_5394fc468396843c = ter_op(isDefined(var_5394fc468396843c), var_5394fc468396843c, unknownpos);
  var_518a4e9f2d3b108d = ter_op(isDefined(var_518a4e9f2d3b108d), var_518a4e9f2d3b108d, unknownpos);
  doorindex = -1;
  doororigin = (0, 0, 0);

  if(isDefined(door)) {
    doorindex = door.index;
    doororigin = door.origin;
  }

  reportstring = gettime() + ";" + situation + ";" + bot getentitynumber() + ";" + lastposition + ";" + doorindex + ";" + doororigin + ";" + var_5394fc468396843c + ";" + var_518a4e9f2d3b108d + ";" + ispassed;
  outputlog("Door", reportstring);

  if(isDefined(level.mit.door.var_31e45429b9998458)) {
    level.mit.door.var_31e45429b9998458 += 1;
  } else {
    level.mit.door.var_31e45429b9998458 = 1;
  }

  doormidpoint = door function_d90515f5e17dbc6f();
  camerapos = function_f8350ab882cc2439(doormidpoint + anglesToForward(door.angles + (0, 90, 0)) * 170);
  camerapos = drop_to_ground(camerapos, 50);
  camerapos = (camerapos[0], camerapos[1], camerapos[2] - 40);
  function_f2bc01a7b0321f52("<dev string:x1c>", doormidpoint, camerapos, door, level.mit.door.var_31e45429b9998458);
}