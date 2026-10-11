/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2986aa4b0ff2bddf.gsc
*************************************************/

#using script_3d2770dc09c1243;
#using script_59ff79d681bb860c;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\outofbounds;
#namespace namespace_503ce3a6b9903b4d;

function init() {
  level.mit.roaming = spawnStruct();
  level.mit.roaming.var_18105e1cc239e2de = [];
  level.mit.roaming.success = 0;
  level.mit.roaming.failure = 0;
  level.mit.roaming.skipped = 0;
  function_48439182721444a3();
  level.mit.roaming.var_e73e689497f53ebe = function_6511dfbb689d29e() > 0;

  if(level.mit.roaming.var_e73e689497f53ebe) {
    level.mit.roaming.var_544980b7dba4d0d7 = function_6511dfbb689d29e();
    level.mit.roaming.var_53c155d78ef13723 = [];
  }
}

function private function_48439182721444a3() {
  var_879303adbf6f4b = [];

  foreach(gulag in getStructArray("gulag", "targetname")) {
    var_879303adbf6f4b[var_879303adbf6f4b.size] = gulag.origin;
  }

  var_b5793d83424910cf = getdvarfloat(@ "hash_eeafa4170c1c43c2", 0.1);

  if(var_879303adbf6f4b.size == 0) {
    function_ff2e3db4923b5a2a(var_b5793d83424910cf);
    return;
  }

  var_afa2c28b66a73fdb = getdvarfloat(@ "hash_4e1bd7e9f708b12", 1500);
  var_c1cf9d7f2b04766a = getdvarfloat(@ "hash_9e7ca2260359bf6f", 600);
  function_ff2e3db4923b5a2a(var_b5793d83424910cf, var_879303adbf6f4b, var_afa2c28b66a73fdb, var_c1cf9d7f2b04766a);
}

function function_3113f44ebafe71b1() {
  if(level.mit.roaming.var_e73e689497f53ebe && level.mit.roaming.var_53c155d78ef13723.size == 0 && !function_722991bb6bf8e992()) {
    return 0;
  }

  if(!isDefined(level.mit.roaming.starttime)) {
    level.mit.roaming.starttime = getsystemtime();
  }

  var_6ae256575845b834 = getdvarint(@ "hash_a4a2e148cc9957e0", -1);

  if(var_6ae256575845b834 < 0) {
    return 1;
  }

  if(var_6ae256575845b834 == 0) {
    return 0;
  }

  duration = getsystemtime() - level.mit.roaming.starttime;
  return duration <= var_6ae256575845b834;
}

function testprocess(var_a998844686a7ae57) {
  var_cbef341a3aeef001 = 32;
  self.mit.onplayerkilled = &onplayerkilled;
  self.mit.var_c2f04ca3110fa58a = 0;
  self.mit.var_d1dcf59fc3a6fa1 = undefined;
  self.mit.var_55e3383b71891dec = undefined;
  destination = undefined;

  if(isDefined(var_a998844686a7ae57)) {
    destination = var_a998844686a7ae57;
  } else if(level.mit.roaming.var_e73e689497f53ebe) {
    [startpos, destination, edgeindex, var_a591e94eb7ba335e] = function_7504406945361e53();
    self.mit.var_55e3383b71891dec = var_a591e94eb7ba335e;
    self.mit.edgeindex = edgeindex;
    success = resetposition(startpos);

    if(!success) {
      return;
    }
  } else {
    if(getdvarint(@ "hash_568a0d6a4a05aea4", 0) == 0) {
      var_7d2294c58a5c346 = 100;
      startpos = function_3ec57983d173d1e3();
      success = resetposition(startpos, var_7d2294c58a5c346);

      if(!success) {
        return;
      }
    }

    destination = function_f2a51e5bf06397e3();
  }

  assert(isDefined(destination));
  self.mit.botstartpos = self.origin;
  self.mit.botendpos = destination;
  enableparachute(0);
  self botsetdifficultysetting("slideChance", 0);
  setscriptgoal(destination, var_cbef341a3aeef001);
  childthread function_a27eb75c08f18c4f();
  childthread function_6885bdfe55f8f15d(destination);
  childthread function_e6c8677b0fb79d74(destination);
  childthread function_898085e0edaf6334(destination);
  var_b61d2f13ca2d857f = ["custom_fall_check_finished", "custom_stuck_check_finished", "path_event_check_finished"];
  waittill_any_in_array(var_b61d2f13ca2d857f);

  if(self.mit.var_d1dcf59fc3a6fa1 == "try_reversed_path") {
    var_b784ef2f37ba6722 = [self.mit.botendpos, self.mit.botstartpos, self.mit.edgeindex];
    level.mit.roaming.var_53c155d78ef13723[level.mit.roaming.var_53c155d78ef13723.size] = var_b784ef2f37ba6722;
  } else if(self.mit.var_d1dcf59fc3a6fa1 != "goal") {
    if(isDefined(var_a998844686a7ae57)) {
      freezebot(1);

      while(true) {
        wait 60;
      }
    }

    function_bd6ccbf4d735388f(self.mit.var_d1dcf59fc3a6fa1 != "<dev string:x1c>");
  }

  self.mit.var_c2f04ca3110fa58a = 1;
}

function endhandler() {
  if(!istrue(self.mit.var_c2f04ca3110fa58a) && isaliveplayer(self)) {
    report("unexpectedly", self, [function_57a85ec4923ff680("botPos", self.origin)]);
  }

  function_b8203431ac51b457();
  self.mit.edgeindex = undefined;
}

function private function_b8203431ac51b457() {
  if(!isDefined(level.mit.roaming.var_ef3e5cd2268d515e)) {
    level.mit.roaming.var_ef3e5cd2268d515e = getsystemtime();
  }

  switch (self.mit.var_d1dcf59fc3a6fa1) {
    case #"hash_cca707fc9f8c931":
      var_d086d7abbc40868a = undefined;
      return;
    case #"hash_8d43150f19c69bd6":
      level.mit.roaming.success++;
      var_d086d7abbc40868a = 1;
      break;
    case #"hash_c2ee5d89fcc2af22":
      level.mit.roaming.skipped++;
      var_d086d7abbc40868a = 3;
      break;
    default:
      level.mit.roaming.failure++;
      var_d086d7abbc40868a = 2;
      break;
  }

  if(isDefined(var_d086d7abbc40868a)) {
    function_2a96a08273f25d49(self.mit.edgeindex, var_d086d7abbc40868a);
  }

  finished = level.mit.roaming.success + level.mit.roaming.failure;

  if(level.mit.roaming.var_e73e689497f53ebe) {
    finished += level.mit.roaming.skipped;
  }

  var_b70b3cece73764b9 = 0;
  var_f252655fa64e5fe8 = 0;
  var_3c63fc0092f80c4e = getdvarint(@ "hash_43e58e4246e249d8", 60);

  if(getsystemtime() - level.mit.roaming.var_ef3e5cd2268d515e >= var_3c63fc0092f80c4e) {
    level.mit.roaming.var_ef3e5cd2268d515e = getsystemtime();
    var_b70b3cece73764b9 = 1;
  }

  if(level.mit.roaming.var_e73e689497f53ebe) {
    total = level.mit.roaming.var_544980b7dba4d0d7;
    ratio = finished / total;
    logstring("MIT/Roaming - current progress is: " + ratio + "(" + finished + " of " + total + ")");

    if(finished >= total) {
      var_b70b3cece73764b9 = 1;
      var_f252655fa64e5fe8 = 1;
    }
  }

  if(var_b70b3cece73764b9) {
    reportstring = "Test result: " + finished + " roaming cases, " + level.mit.roaming.success + " successes, " + level.mit.roaming.failure + " failures";

    if(level.mit.roaming.var_e73e689497f53ebe) {
      reportstring += ", " + level.mit.roaming.skipped + " skipped";
    }

    reportstring += ".";
    outputlog("Roaming", reportstring);
  }

  if(var_f252655fa64e5fe8) {
    outputlog("Roaming", "All done.");
  }
}

function private function_7504406945361e53() {
  assert(level.mit.roaming.var_e73e689497f53ebe && (level.mit.roaming.var_53c155d78ef13723.size > 0 || function_722991bb6bf8e992()));

  if(level.mit.roaming.var_53c155d78ef13723.size == 0) {
    var_a591e94eb7ba335e = 1;
    var_acd732c1b2599e94 = function_16660095c2af8e2e();
    startpos = var_acd732c1b2599e94.startpos;
    endpos = var_acd732c1b2599e94.endpos;
    edgeindex = var_acd732c1b2599e94.index;
  } else {
    var_a591e94eb7ba335e = 0;
    [startpos, endpos, edgeindex] = level.mit.roaming.var_53c155d78ef13723[level.mit.roaming.var_53c155d78ef13723.size - 1];
    level.mit.roaming.var_53c155d78ef13723[level.mit.roaming.var_53c155d78ef13723.size - 1] = undefined;
  }

  return [startpos, endpos, edgeindex, var_a591e94eb7ba335e];
}

function private onplayerkilled(deathdata) {
  if(!isbot(self)) {
    return;
  }

  interestingpos = [];
  interestingpos[interestingpos.size] = function_57a85ec4923ff680("deathPos", self.lastdeathpos);

  if(scripts\mp\outofbounds::ispointinoutofbounds(self.lastdeathpos, self.team)) {
    report("killed_by_oob", self, interestingpos, self.mit.botendpos, undefined, deathdata.meansofdeath);
  } else {
    if(isDefined(self.mit.var_9a0bbf45ee5bcf80)) {
      interestingpos[interestingpos.size] = function_57a85ec4923ff680("startFall", self.mit.var_9a0bbf45ee5bcf80);
    }

    report("death", self, interestingpos, self.mit.botendpos, undefined, deathdata.meansofdeath);
  }

  enableparachute(1);
}

function private function_a27eb75c08f18c4f() {
  var_30f1a5ab0be2ab6e = 0.5;
  lastorigin = self.origin;
  self.mit.var_df1c47227c3b4ea5 = [lastorigin];

  while(true) {
    wait var_30f1a5ab0be2ab6e;
    var_ff5e5f5119ac870b = 100;

    if(distancesquared(lastorigin, self.origin) > var_ff5e5f5119ac870b) {
      lastorigin = self.origin;
      self.mit.var_df1c47227c3b4ea5[self.mit.var_df1c47227c3b4ea5.size] = lastorigin;
    }
  }
}

function private function_6885bdfe55f8f15d(target) {
  var_2530eb2df770b9f9 = 0.5;
  var_7b00b13d4490deb3 = 100;
  var_63011ea497c73d82 = 4;
  lastpos = undefined;
  startfalltime = undefined;
  var_da4ef742b2605023 = function_cc7e90653e9dab25(var_63011ea497c73d82);

  while(true) {
    wait var_2530eb2df770b9f9;

    if(self isonground() || self isswimming() || self function_3e76c64a7bfe7be9()) {
      lastpos = undefined;
      startfalltime = undefined;
      continue;
    }

    curpos = self.origin;

    if(isDefined(lastpos)) {
      fallingspeed = (lastpos[2] - curpos[2]) / var_2530eb2df770b9f9;

      if(fallingspeed > var_7b00b13d4490deb3) {
        if(!isDefined(startfalltime)) {
          startfalltime = function_71b519a5e0525acc();
          self.mit.var_9a0bbf45ee5bcf80 = lastpos;
        }

        if(function_71b519a5e0525acc() - startfalltime >= var_da4ef742b2605023) {
          report("custom_fall", self, [function_57a85ec4923ff680("startFalling", self.mit.var_9a0bbf45ee5bcf80)], target, undefined, undefined);
          self notify("custom_fall_check_finished");
          return;
        }
      } else {
        startfalltime = undefined;
      }
    }

    lastpos = curpos;
  }
}

function private function_e6c8677b0fb79d74(target) {
  self endon("end_custom_stuck");
  var_45a16c7edeccb500 = 10;
  var_68c48f0a02281be6 = 32;
  var_b0f645bd38d985cc = 64;
  var_6d82c1563a4ff586 = 5000;

  for(lastpos = self.origin; true; lastpos = self.origin) {
    wait var_45a16c7edeccb500;
    var_f122a392f555d0c8 = function_71b519a5e0525acc();

    while(distance(lastpos, self.origin) < var_68c48f0a02281be6) {
      if(function_71b519a5e0525acc() - var_f122a392f555d0c8 < var_6d82c1563a4ff586) {
        waitframe();
        continue;
      }

      reason = detectdoor(self, var_b0f645bd38d985cc);

      if(!isDefined(reason)) {
        reason = detectladder(self, var_b0f645bd38d985cc);
      }

      report("custom_stuck", self, [function_57a85ec4923ff680("botPos", self.origin)], target, self function_b96cea3ba44fc035(), reason);
      self notify("custom_stuck_check_finished");
      return;
    }
  }
}

function private function_898085e0edaf6334(target) {
  var_535a43a18cffe1e = 2;
  var_f0fe2717cfcf68ea = 120;
  var_22dbda9670b4db7f = function_cc7e90653e9dab25(var_f0fe2717cfcf68ea);
  starttime = function_71b519a5e0525acc();
  endtime = starttime + var_22dbda9670b4db7f;
  path = undefined;
  var_e80b8c7309d74cae = undefined;

  while(true) {
    result = function_b564050a363f08ec(self, var_535a43a18cffe1e);
    newpath = self function_b96cea3ba44fc035();

    if(isDefined(newpath)) {
      path = newpath;
    }

    switch (result) {
      case #"hash_d4dde12b38318c68":
        if(function_71b519a5e0525acc() < endtime) {
          continue;
        }

        break;
      case #"hash_8d43150f19c69bd6":
        var_e80b8c7309d74cae = result;
        break;
      case #"hash_6081e19af94485b5":
        if(istrue(self.mit.var_55e3383b71891dec)) {
          var_e80b8c7309d74cae = "try_reversed_path";
        }

        break;
      default:
        break;
    }

    if(isDefined(var_e80b8c7309d74cae)) {
      self.mit.var_d1dcf59fc3a6fa1 = var_e80b8c7309d74cae;
    } else {
      report(result, self, [function_57a85ec4923ff680("botPos", self.origin)], target, path);
    }

    self notify("path_event_check_finished");
    return;
  }
}

function private report(situation, bot, position, target, path, comment) {
  if(!istrue(level.mit.roaming.var_5b2e8a31f3418367)) {
    header = "#time; #situation; #bot; #position; #begin; #end; #pathFind; #comment; #track";
    outputlog("Roaming", header);
    level.mit.roaming.var_5b2e8a31f3418367 = 1;
  }

  assert(isarray(position));

  if(function_cdbac84c6cf66a08(position[0].origin, path)) {
    self.mit.var_d1dcf59fc3a6fa1 = "skip";
    return;
  }

  self.mit.var_d1dcf59fc3a6fa1 = situation;
  posstr = "";

  foreach(pos in position) {
    posstr += pos.posdescription + pos.origin + " ";
  }

  pathstr = "";

  if(isDefined(path)) {
    for(i = 0; i < path.size; i++) {
      pathstr += path[i];
    }
  }

  reportstring = gettime() + "; " + situation + "; " + bot getentitynumber() + "; " + posstr + "; " + default_to(bot.mit.botstartpos, "") + "; " + default_to(target, "") + "; " + pathstr + "; " + default_to(comment, "") + ";";
  var_b47c51ade878375b = 4096;
  lineindex = 0;

  if(isarray(self.mit.var_df1c47227c3b4ea5)) {
    foreach(path in self.mit.var_df1c47227c3b4ea5) {
      pathstr = path + "";

      if(reportstring.size + pathstr.size >= var_b47c51ade878375b) {
        outputlog("Roaming", reportstring, lineindex > 0);
        reportstring = "";
        lineindex++;
      }

      reportstring += pathstr;
    }
  }

  outputlog("Roaming", reportstring, lineindex > 0);
  extrareport(situation, bot, position, target, path, comment);

  if(getdvarint(@ "hash_824c718cad3c0f17", 1)) {
    if(isDefined(level.mit.roaming.var_31e45429b9998458)) {
      level.mit.roaming.var_31e45429b9998458 += 1;
    } else {
      level.mit.roaming.var_31e45429b9998458 = 1;
    }

    function_f2bc01a7b0321f52("<dev string:x24>", position[0].origin, position[0].origin + (0, 0, 100), undefined, level.mit.roaming.var_31e45429b9998458);
  }
}

function private extrareport(situation, bot, position, target, path, comment) {
  reportstring = "";

  switch (situation) {
    case #"hash_e8bc3da4af287c2d":
      var_acc73b9be635b8be = isarray(position) && isDefined(position[1]) && position[1].posdescription == "startFall" && position[0].origin[2] < level.mit.var_513a313408516dc2;

      if(var_acc73b9be635b8be) {
        reportstring += "death_bot_fell_in_hole, " + position[0].posdescription + position[0].origin + ", " + position[1].posdescription + position[1].origin;
      }

      break;
    case #"hash_c023be270799b5f9":
      if(isDefined(comment)) {
        reportstring += "custom_stuck_by_" + comment;
        reportstring += ", " + position[0].origin;
      }

      break;
  }

  if(reportstring != "") {
    outputlog("Roaming_Bug", reportstring);
  }
}

function private function_cdbac84c6cf66a08(position, path) {
  return function_474c2bdac948dd09(position) || function_5fc639be43086a50(position, path) || function_30be3ceb758e4162(position, path);
}

function private function_474c2bdac948dd09(position) {
  var_ff5e5f5119ac870b = 100;

  foreach(var_4d547643f25a864 in level.mit.roaming.var_18105e1cc239e2de) {
    if(distancesquared(var_4d547643f25a864, position) < var_ff5e5f5119ac870b) {
      return true;
    }
  }

  level.mit.roaming.var_18105e1cc239e2de[level.mit.roaming.var_18105e1cc239e2de.size] = position;
  return false;
}

function private function_5fc639be43086a50(position, path) {
  if(!isDefined(level.mit.door) || !isarray(level.mit.door.var_baace84a7c08f5dd)) {
    return false;
  }

  var_749cb00edb06e02a = 64;
  subpaths = function_6a04d8387ace6ae8(position, path, var_749cb00edb06e02a, 1);

  if(!isDefined(subpaths)) {
    return false;
  }

  foreach(doorinfo in level.mit.door.var_baace84a7c08f5dd) {
    var_1e35e50e4b93eab6 = 64;
    var_11855ac71db6dc0d = doorinfo.door.origin;
    var_1a2dfa0e910c8a94 = var_11855ac71db6dc0d + anglesToForward(doorinfo.originangle) * var_1e35e50e4b93eab6;

    foreach(subpath in subpaths) {
      intersected = function_3c55380b5e177254(subpath[0], subpath[1], var_11855ac71db6dc0d, var_1a2dfa0e910c8a94);

      if(intersected) {
        return true;
      }
    }
  }

  return false;
}

function private function_30be3ceb758e4162(position, path) {
  if(!isDefined(level.mit.traversal) || !isarray(level.mit.traversal.var_eb99c06f565b2a3b)) {
    return false;
  }

  var_749cb00edb06e02a = 64;
  subpaths = function_6a04d8387ace6ae8(position, path, var_749cb00edb06e02a, 0);

  if(!isDefined(subpaths)) {
    return false;
  }

  foreach(traversalinfo in level.mit.traversal.var_eb99c06f565b2a3b) {
    traversalstart = traversalinfo[0].origin;
    traversalend = traversalinfo[1].origin;

    foreach(subpath in subpaths) {
      var_aef8c08e0b7f4061 = function_aef8c08e0b7f4061(traversalstart, traversalend, subpath[0], subpath[1]);

      if(var_aef8c08e0b7f4061) {
        return true;
      }
    }
  }

  return false;
}

function private function_6a04d8387ace6ae8(position, path, thresholddist, var_411f5d81b0a4c8a1) {
  if(!isDefined(position) || !isDefined(path) || !isarray(path) || path.size < 2) {
    return undefined;
  }

  if(!isDefined(thresholddist)) {
    thresholddist = 64;
  }

  res = [];

  for(i = 0; i < path.size - 1; i++) {
    p1 = path[i];
    p2 = path[i + 1];

    if(istrue(var_411f5d81b0a4c8a1) && i == 0) {
      d12 = vectorNormalize(p1 - p2);
      p1 += d12 * thresholddist;
    }

    if(function_7c9ea559aa168fb4(position, p1, p2, thresholddist)) {
      res[res.size] = [p1, p2];
    }
  }

  if(res.size > 0) {
    return res;
  }

  return undefined;
}

function private function_7c9ea559aa168fb4(position, start, end, thresholddist) {
  subpathlength = length2d(end - start);
  var_dcda148dbd56ce31 = length2d(position - start);
  var_f5708e0946783d54 = length2d(position - end);
  return abs(var_dcda148dbd56ce31 + var_f5708e0946783d54 - subpathlength) < thresholddist;
}

function private function_aef8c08e0b7f4061(traversalstart, traversalend, subpathstart, subpathend) {
  var_6d80ddc0fe3c4e03 = 1024;
  return distancesquared(traversalstart, subpathstart) < var_6d80ddc0fe3c4e03 && distancesquared(traversalend, subpathend) < var_6d80ddc0fe3c4e03;
}

function private function_f2a51e5bf06397e3() {
  if(getdvarint(@ "hash_a7dba9fd2c230875", 0)) {
    return function_2cd5adf6cf3179e5();
  }

  return function_3ec57983d173d1e3();
}

function private function_2cd5adf6cf3179e5() {
  var_4d2861d9375d49bc = 5;
  var_92b1717b42bb9cd4 = [30, 60, 90, 145, 180];
  var_d3c5b52b55e39c07 = [500, 1000, 1500, 2000, 2500];
  assert(var_92b1717b42bb9cd4.size == var_4d2861d9375d49bc && var_d3c5b52b55e39c07.size == var_4d2861d9375d49bc);
  var_9ccc7137eea64baf = 0.5;
  var_9ca95f37ee7fdc61 = 1;
  var_9178eec664b1667f = 1600;
  var_80055d9eec7074a5 = 200;
  yaw = self.angles[1];
  attempts = 0;
  finalpoint = undefined;

  while(attempts < var_4d2861d9375d49bc) {
    var_53ff1d53d1ec1f07 = angleclamp180(yaw - var_92b1717b42bb9cd4[attempts]);
    rightangle = angleclamp180(yaw + var_92b1717b42bb9cd4[attempts]);
    anglediff = anglesdelta((0, var_53ff1d53d1ec1f07, 0), (0, rightangle, 0));
    theta = var_53ff1d53d1ec1f07 + randomfloat(anglediff);
    radius = var_d3c5b52b55e39c07[attempts] * randomfloatrange(var_9ccc7137eea64baf, var_9ca95f37ee7fdc61);
    offset = radius * (cos(theta), sin(theta), 0);
    desiredpoint = self.origin + offset;
    var_8e438c1bacb25a0a = function_f8350ab882cc2439(desiredpoint);
    randompoints = getrandomnavpoints(var_8e438c1bacb25a0a, var_80055d9eec7074a5, 3, self);
    prevdistsq = -1;
    candidatepoint = undefined;

    foreach(point in randompoints) {
      distsq = lengthsquared(point - var_8e438c1bacb25a0a);

      if(distsq > prevdistsq) {
        candidatepoint = point;
        prevdistsq = distsq;
      }
    }

    function_35b98ade1d8d308d(desiredpoint, var_8e438c1bacb25a0a, candidatepoint);

    if(lengthsquared(candidatepoint - self.origin) > var_9178eec664b1667f) {
      finalpoint = candidatepoint;
      break;
    }

    attempts++;
  }

  if(!isDefined(finalpoint)) {
    finalpoint = function_3ec57983d173d1e3();
  }

  return finalpoint;
}

function function_3ec57983d173d1e3() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    minx = min(level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[1][0]);
    maxx = max(level.br_level.br_mapbounds[0][0], level.br_level.br_mapbounds[1][0]);
    miny = min(level.br_level.br_mapbounds[1][1], level.br_level.br_mapbounds[0][1]);
    maxy = max(level.br_level.br_mapbounds[1][1], level.br_level.br_mapbounds[0][1]);
    minz = level.br_level.c130_sealeveloverride;
    maxz = level.br_level.c130_heightoverride;
  } else {
    x1 = level.mapcorners[1].origin[0];
    x2 = level.mapcorners[0].origin[0];
    y1 = level.mapcorners[1].origin[1];
    y2 = level.mapcorners[0].origin[1];
    minx = min(x1, x2);
    maxx = max(x1, x2);
    miny = min(y1, y2);
    maxy = max(y1, y2);
    minz = scripts\cp_mp\parachute::getc130sealevel();
    maxz = scripts\cp_mp\parachute::getc130height();
  }

  randompoint = (randomfloatrange(minx, maxx), randomfloatrange(miny, maxy), randomfloatrange(minz, maxz));
  return function_f8350ab882cc2439(randompoint);
}

function private enableparachute(enabled) {
  self skydive_setdeploymentstatus(enabled);
  self skydive_setbasejumpingstatus(enabled);

  if(enabled == 1) {
    self skydive_cutautodeployon();
    return;
  }

  self skydive_cutautodeployoff();
}

function private freezebot(freeze) {
  self botsetflag("disable_movement", freeze);
  self botsetflag("disable_rotation", freeze);

  if(freeze) {
    self notify("end_custom_stuck");
    self setvelocity((0, 0, 0));
  }
}

function private resetposition(startpos, var_f24bccd9181848c1) {
  var_d22fdca158e266e = 50;
  failedresult = botteleport(startpos, var_d22fdca158e266e, var_f24bccd9181848c1);

  if(isDefined(failedresult)) {
    report("failed_teleport", self, [function_57a85ec4923ff680("newPoint", startpos)], undefined, undefined, failedresult);
    return false;
  }

  return true;
}

function private detectladder(bot, dist) {
  nodes = getnodesinradius(bot.origin, dist, 0);

  foreach(node in nodes) {
    if(isDefined(node.animscript) && issubstr(node.animscript, "ladder")) {
      return "ladder";
    }
  }

  return undefined;
}

function private detectdoor(bot, dist) {
  traceresult = navtrace(bot.origin, anglesToForward(bot.angles) * dist + bot.origin);

  if(istrue(traceresult)) {
    doors = getentitylessscriptablearray(undefined, undefined, bot.origin, dist, "door");

    foreach(door in doors) {
      includedangle = anglesdelta(door.angles, bot.angles);
      var_c32162f8d2bf2d4d = includedangle < 100 && includedangle > 80;

      if(var_c32162f8d2bf2d4d) {
        return ter_op(door scriptabledoorisclosed(), "closed_door", "opened_door");
      }
    }
  }

  return undefined;
}

function private function_57a85ec4923ff680(description, origin) {
  pos = spawnStruct();
  pos.posdescription = description;
  pos.origin = origin;
  return pos;
}

function private function_bd6ccbf4d735388f(takescreenshot) {
  if(takescreenshot && getdvarint(@ "hash_824c718cad3c0f17", 1) && isDefined(level.mit.roaming.var_31e45429b9998458)) {
    freezebot(1);
    level waittill("<dev string:x2f>" + level.mit.roaming.var_31e45429b9998458);
    freezebot(0);
  }
}

function private function_35b98ade1d8d308d(desiredpoint, var_8e438c1bacb25a0a, candidatepoint) {
  drawoption = getdvarint(@ "hash_e58e30094d98d46e", 0);

  if(drawoption <= 0) {
    return;
  }

  if(drawoption > 1 && getdvarint(@ "hash_72c1d25dd9519ff0", 0) != self getentitynumber()) {
    return;
  }

  var_22b471bd4bfb2324 = 200;
  yellow = (1, 1, 0);
  red = (1, 0, 0);
  green = (0, 1, 0);
  sphere(desiredpoint, 10, yellow, 0, var_22b471bd4bfb2324);
  sphere(var_8e438c1bacb25a0a, 10, red, 0, var_22b471bd4bfb2324);
  line(desiredpoint, var_8e438c1bacb25a0a, yellow, 1, 0, var_22b471bd4bfb2324);
  sphere(candidatepoint, 10, green, 0, var_22b471bd4bfb2324);
  line(var_8e438c1bacb25a0a, candidatepoint, green, 1, 0, var_22b471bd4bfb2324);
}

function function_63bde891e2fb515c(stuckpos) {
  self notify("<dev string:x53>");
  self endon("<dev string:x53>");

  while(true) {
    sphere(stuckpos, 6, (1, 0, 0), 0, 1);
    waitframe();
  }
}

# /