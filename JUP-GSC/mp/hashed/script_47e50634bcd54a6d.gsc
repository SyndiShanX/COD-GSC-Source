/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_47e50634bcd54a6d.gsc
*************************************************/

#using script_3d2770dc09c1243;
#using script_59ff79d681bb860c;
#using scripts\engine\utility;
#namespace namespace_93ef1ea062af3119;

function init() {
  level.mit.traversal = spawnStruct();
  level.mit.traversal.traversals = collecttraversals(function_1d7afd2edf503358());
  level.mit.traversal.total = level.mit.traversal.traversals.size;
  level.mit.traversal.success = 0;

  level thread function_a087eafdd1fd738a();

  level.mit.traversal.traversalhistory = [];
  level.mit.traversal.var_eb99c06f565b2a3b = [];
}

function private collecttraversals(nodearray) {
  beginnode = [];
  endnode = [];

  foreach(node in nodearray) {
    if(!isDefined(node.type)) {
      continue;
    }

    nodename = function_df46390ffcc4d8f8(node);

    if(!isDefined(nodename)) {
      continue;
    }

    if(node.type == "Begin") {
      if(isDefined(beginnode[nodename])) {
        report("duplicated name: " + nodename + ", node1:" + node.origin + ", node2:" + beginnode[nodename].origin);
        continue;
      }

      beginnode[nodename] = node;
      continue;
    }

    if(node.type == "End") {
      if(isDefined(endnode[nodename])) {
        report("duplicated name: " + nodename + ", node1:" + node.origin + ", node2:" + endnode[nodename].origin);
        continue;
      }

      endnode[nodename] = node;
    }
  }

  namekeys = getarraykeys(beginnode);
  result = [];

  foreach(name in namekeys) {
    if(isDefined(endnode[name])) {
      size = result.size;
      result[size] = [];
      result[size][0] = beginnode[name];
      result[size][1] = endnode[name];
      beginnode[name] = undefined;
      endnode[name] = undefined;
    }
  }

  if(beginnode.size > 0) {
    foreach(key, value in beginnode) {
      report("unpaired begin node: " + key + ", " + value.origin);
    }
  }

  if(endnode.size > 0) {
    foreach(key, value in endnode) {
      report("unpaired end node: " + key + ", " + value.origin);
    }
  }

  return result;
}

function private function_1d7afd2edf503358() {
  nodearray = [];
  var_7e9ba60b8063b886 = function_f54e0e65561bd73d();
  var_c9c7886c2a8fe2b = 256;
  var_eb9bb6e61468ccfe = 512;
  var_e23afebc88f537a0 = 1024;
  var_11ebf20269a5fbf5 = 2048;
  var_f0a5cd7d92164e06 = var_c9c7886c2a8fe2b | var_eb9bb6e61468ccfe | var_e23afebc88f537a0 | var_11ebf20269a5fbf5;

  foreach(pair in var_7e9ba60b8063b886) {
    if(!(pair.var_7a2cc0284e4dbace &var_f0a5cd7d92164e06)) {
      continue;
    }

    var_2a54eaf7999d27f2 = pair.var_2a54eaf7999d27f2;
    nodeend = pair.nodeend;

    if(isDefined(var_2a54eaf7999d27f2)) {
      nodearray[nodearray.size] = var_2a54eaf7999d27f2;
    }

    if(isDefined(nodeend)) {
      nodearray[nodearray.size] = nodeend;
    }
  }

  return nodearray;
}

function private report(situation, bot, position, traversaltarget) {
  if(!istrue(level.mit.traversal.var_853b0ac91bee4934)) {
    header = "#time; #situation; #bot; #lastPosition; #traversalName; #traversalType; #traversalBegin; #traversalEnd; #comment";
    outputlog("Traversal", header);
    level.mit.traversal.var_853b0ac91bee4934 = 1;
  }

  botentitynumber = "";

  if(isDefined(bot)) {
    botentitynumber = bot getentitynumber();
  }

  lastposition = "";

  if(isDefined(position)) {
    lastposition = position;
  }

  traversalname = "";
  beginposition = "";
  endposition = "";
  traversaltype = "";

  if(isDefined(traversaltarget)) {
    traversalname = function_df46390ffcc4d8f8(traversaltarget[0]);
    beginposition = traversaltarget[0].origin;
    endposition = traversaltarget[1].origin;
    level.mit.traversal.var_eb99c06f565b2a3b[level.mit.traversal.var_eb99c06f565b2a3b.size] = traversaltarget;
    traversaltype = traversaltarget[0].animscript;
  }

  comment = "";

  if(isDefined(bot) && isDefined(bot.mit) && isDefined(bot.mit.comment)) {
    comment = bot.mit.comment;
  }

  reportstring = gettime() + "; " + situation + "; " + botentitynumber + "; " + lastposition + "; " + traversalname + "; " + traversaltype + "; " + beginposition + "; " + endposition + "; " + comment;
  outputlog("Traversal", reportstring);

  if(isDefined(level.mit.traversal.var_31e45429b9998458)) {
    level.mit.traversal.var_31e45429b9998458 += 1;
  } else {
    level.mit.traversal.var_31e45429b9998458 = 1;
  }

  if(isDefined(traversaltarget)) {
    function_f2bc01a7b0321f52("<dev string:x1c>", endposition, endposition + (0, 0, 100), traversaltarget, level.mit.traversal.var_31e45429b9998458);
  }
}

function private retryreport(situation, bot) {
  if(!function_b9b4e6815c62b52f(bot.mit.traversal, situation)) {
    report(situation, bot, bot.origin, bot.mit.traversal);
  }
}

function private function_df46390ffcc4d8f8(node) {
  if(isDefined(node.target)) {
    return node.target;
  }

  if(isDefined(node.targetname)) {
    return node.targetname;
  }

  return undefined;
}

function testprocess() {
  assert(!isDefined(self.mit.traversal));
  self botsetdifficultysetting("slideChance", 0);
  self.mit.traversal = taketraversal();

  if(!isDefined(self.mit.traversal)) {
    return;
  }

  self.mit.onplayerkilled = &onplayerkilled;
  var_d22fdca158e266e = 25;
  var_7d2294c58a5c346 = 50;
  failedresult = botteleport(self.mit.traversal[0].origin, var_d22fdca158e266e, var_7d2294c58a5c346);

  if(isDefined(failedresult)) {
    if(isstartstr(failedresult, "inaccurate")) {
      self.mit.comment = failedresult;
    } else {
      retryreport("teleport failed/" + failedresult, self);
      return;
    }
  }

  thread function_dec8f2a03738931b(self.mit.traversal);

  gotoendposition(self, self.mit.traversal);
}

function private taketraversal() {
  tpos = getdvarvector(@ "hash_19539497cc24bc9");

  if(isDefined(tpos) && level.players.size == 2) {
    level.mit.traversal.traversalhistory = [];
    return function_5a02aa402b327557(tpos);
  }

  if(level.mit.traversal.traversals.size == 0) {
    return undefined;
  }

  assert(level.mit.traversal.traversals.size > 0);

  for(index = 0; index < level.mit.traversal.traversals.size; index++) {
    current = level.mit.traversal.traversals[index];

    if(function_25eb6fee59a46e3a(current)) {
      level.mit.traversal.traversals = array_remove_index(level.mit.traversal.traversals, index);
      return current;
    }
  }

  return undefined;
}

function private function_25eb6fee59a46e3a(traversal) {
  var_92c13c6437a38a60 = 64;

  foreach(player in level.players) {
    if(!isbot(player) || !isaliveplayer(player)) {
      continue;
    }

    if(isDefined(player.mit) && isDefined(player.mit.traversal)) {
      isclose = distance(traversal[0].origin, player.mit.traversal[1].origin) < var_92c13c6437a38a60 || distance(traversal[1].origin, player.mit.traversal[0].origin) < var_92c13c6437a38a60;

      if(isclose) {
        return false;
      }
    }
  }

  return true;
}

function private gotoendposition(bot, traversal) {
  var_cbef341a3aeef001 = 30;
  var_4112bb19cc3c6a26 = 60;
  endposition = bot.mit.traversal[1].origin;
  begintime = function_71b519a5e0525acc();
  dist = distance(bot.mit.traversal[0].origin, endposition);
  var_68291b1086bff85 = (dist / var_4112bb19cc3c6a26 + 1) * 1000;
  bot setscriptgoal(endposition, var_cbef341a3aeef001);
  var_4ddf9c3e5ceddc6 = 0;
  var_172ffc4a18f645a9 = 15000;

  while(true) {
    result = function_b564050a363f08ec(bot, 0.1);

    if(result == "goal") {
      timeused = function_71b519a5e0525acc() - begintime;
      timerate = timeused / 1000 + "/" + var_68291b1086bff85 / 1000;

      if(!var_4ddf9c3e5ceddc6) {
        retryreport("never used traversal", bot);
      } else {
        if(timeused <= var_68291b1086bff85) {
          function_c6794b6366f34ce2(bot.mit.traversal, "on time goal " + timerate);
        } else {
          function_c6794b6366f34ce2(bot.mit.traversal, "late goal " + timerate);
        }

        level.mit.traversal.success++;
      }

      break;
    }

    if(result == "timeout") {
      if(!var_4ddf9c3e5ceddc6) {
        var_4ddf9c3e5ceddc6 = bot function_3e76c64a7bfe7be9(bot.mit.traversal[0].origin, bot.mit.traversal[1].origin);
      }

      timeused = function_71b519a5e0525acc() - begintime;

      if(gettimescale() == 4) {
        limitduration = var_172ffc4a18f645a9 * 5.5 / var_172ffc4a18f645a9 / 1000 / 4;
      } else {
        limitduration = var_172ffc4a18f645a9;
      }

      if(timeused > limitduration) {
        retryreport("time > " + var_172ffc4a18f645a9 / 1000 + "s", bot);
        break;
      }

      continue;
    }

    retryreport(result, bot);
    break;
  }
}

function private onplayerkilled(deathdata) {
  if(isDefined(self.mit) && isDefined(self.mit.traversal)) {
    retryreport("death", self);
    self.mit.traversal = undefined;
  }
}

function endhandler() {
  if(level.mit.traversal.success + level.mit.traversal.var_eb99c06f565b2a3b.size >= level.mit.traversal.total) {
    reportstring = "Test result: " + level.mit.traversal.total + " traversals, " + level.mit.traversal.success + " successes, " + level.mit.traversal.var_eb99c06f565b2a3b.size + " failures.";
    outputlog("Traversal", reportstring);
  }

  if(isDefined(self)) {
    self botsetflag("disable_movement", 0);
    self.mit.traversal = undefined;
  }
}

function function_3113f44ebafe71b1() {
  return level.mit.traversal.traversals.size > 0;
}

function private function_a087eafdd1fd738a() {
  level endon("<dev string:x29>");
  traversalposition = [];
  traversaltype = [];

  foreach(trvs in level.mit.traversal.traversals) {
    name = function_df46390ffcc4d8f8(trvs[0]);
    traversalposition[name] = trvs[0].origin;
    traversaltype[name] = trvs[0].animscript;
  }

  while(true) {
    wait 20;
    runningtask = 0;

    foreach(player in level.players) {
      if(!isbot(player)) {
        continue;
      }

      if(isDefined(player.mit.traversal)) {
        runningtask = 1;
        break;
      }
    }

    if(!runningtask && level.mit.traversal.traversals.size == 0) {
      break;
    }
  }

  foreach(k, v in level.mit.traversal.traversalhistory) {
    outputstring = v.size + "<dev string:x37>" + k + "<dev string:x37>" + traversalposition[k] + "<dev string:x37>" + traversaltype[k] + "<dev string:x37>";
    outputstring += string_join(v, "<dev string:x37>");

    for(i = 0; i < 3 - v.size; i++) {
      outputstring += "<dev string:x37>";
    }

    outputlog("<dev string:x3c>", outputstring);
  }
}

function private function_b9b4e6815c62b52f(traversal, str) {
  function_c6794b6366f34ce2(traversal, str);
  currentlength = level.mit.traversal.traversalhistory[function_df46390ffcc4d8f8(traversal[0])].size;

  if(currentlength < 3) {
    level.mit.traversal.traversals = array_add(level.mit.traversal.traversals, traversal);
    return true;
  }

  return false;
}

function private function_c6794b6366f34ce2(traversal, str) {
  name = function_df46390ffcc4d8f8(traversal[0]);

  if(!isDefined(level.mit.traversal.traversalhistory[name])) {
    level.mit.traversal.traversalhistory[name] = [];
  }

  len = level.mit.traversal.traversalhistory[name].size;
  level.mit.traversal.traversalhistory[name][len] = str;
}

function private function_5a02aa402b327557(pos) {
  foreach(trvs in level.mit.traversal.traversals) {
    if(distance(pos, trvs[0].origin) < 8) {
      return trvs;
    }
  }

  return undefined;
}

function private function_8c1b5b6ac49d6b0e(name) {
  foreach(trvs in level.mit.traversal.traversals) {
    if(name == function_df46390ffcc4d8f8(trvs[0])) {
      return trvs;
    }
  }

  return undefined;
}

function function_dec8f2a03738931b(traversal) {
  self notify("<dev string:x51>");
  self endon("<dev string:x51>");

  while(true) {
    sphere(traversal[0].origin, 30, (0, 1, 0), 0, 1);
    sphere(traversal[1].origin, 30, (0, 0, 1), 0, 1);
    draw_arrow_time(traversal[0].origin, traversal[1].origin, (1, 0, 0), 1);
    waitframe();
  }
}

# /