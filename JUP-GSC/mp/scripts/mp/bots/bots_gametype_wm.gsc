/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_wm.gsc
***************************************************/

#using script_3653c2969325f543;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\teams;
#namespace bots_gametype_wm;

function main() {
  function_96811b18496ea942(1, &function_d4299bd3cefff9f2);
  function_96811b18496ea942(2, &function_2023c59812a1896a);
  function_96811b18496ea942(3, &function_80669a2cc4016fb3);
  function_96811b18496ea942(4, &function_d4299bd3cefff9f2);
  function_96811b18496ea942(5, &function_bebf9ca11875f590);
  function_96811b18496ea942(6, &function_b72835f420d36cab);
  function_96811b18496ea942(7, &function_d4299bd3cefff9f2);
  function_96811b18496ea942(8, &function_d4299bd3cefff9f2);
  function_96811b18496ea942(9, &bot_hack_think);
  function_96811b18496ea942(10, &function_a329958947b1be20);
  function_96811b18496ea942(11, &function_47f50aa0634c3b02);
  function_96811b18496ea942(12, &function_c62f2faf741f9a21);
  level.var_350e53e094ac2a9f = game["attackers"];
  level.var_765b019e692c1beb = game["defenders"];
  setup_callbacks();
  function_a8c5e56892775215();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_wm_think;
}

function function_a8c5e56892775215() {}

function bot_wm_think() {
  self notify("bot_wm_think");
  self endon("bot_wm_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  self botsetflag("enable_deploy_parachute", 1);

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    if(self.health <= 0 || istrue(self.liveragdoll)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(level.zone)) {
      wait 0.05;
      continue;
    }

    objectivetype = level.zone.objectivetype;

    if(isDefined(objectivetype)) {
      if(!isDefined(level.var_395a230826837426[objectivetype]) || !istrue(self[[level.var_395a230826837426[objectivetype]]]())) {
        self botclearscriptgoal();
      }
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}

function function_b72835f420d36cab() {
  var_144da732d85f9cb9 = 512;

  if(!isDefined(self.vehicle_target)) {
    self.vehicle_target = random(level.escortvehicles);
  }

  if(!isDefined(self.vehicle_target)) {
    return false;
  }

  var_4baf4f8316b6450a = getrandomnavpoint(self.vehicle_target.origin, var_144da732d85f9cb9);

  if(!isDefined(var_4baf4f8316b6450a)) {
    return false;
  }

  if(!self botsetscriptgoal(var_4baf4f8316b6450a, 64, "critical")) {
    return false;
  }

  result = bot_waittill_goal_or_fail();

  if(result == "bad_path" && scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_launchfacility") {
    if(isDefined(self.vehicle_target.var_6bb0ab1fe092bd5d) && self.vehicle_target.var_6bb0ab1fe092bd5d <= 1) {
      for(nodeid = self.vehicle_target.var_6bb0ab1fe092bd5d; nodeid < self.vehicle_target.pathnodes.size; nodeid++) {
        nodepos = self.vehicle_target.pathnodes[nodeid];
        var_4baf4f8316b6450a = getrandomnavpoint(nodepos.origin, var_144da732d85f9cb9);

        if(!self botsetscriptgoal(var_4baf4f8316b6450a, 64, "critical")) {
          return false;
        }

        result = bot_waittill_goal_or_fail();

        if(result == "goal") {
          break;
        }
      }
    }
  }

  if(result == "goal") {
    botrepair = getdvarint(@ "hash_8d0535c35be2b9c0", 0);

    if(botrepair != 0 && is_equal(self.pers["<dev string:x1c>"], game["<dev string:x24>"])) {
      self botpressbutton("<dev string:x31>", 1);

      if(isDefined(self.vehicle_target.repairtrigger.progress) && self.vehicle_target.repairtrigger.progress > 0.5) {
        self.vehicle_target.repairtrigger.progress = 0.1;
      }
    }

    self botclearscriptgoal();
    return true;
  }

  return false;
}

function function_d4299bd3cefff9f2() {
  if(!isDefined(level.var_261c48ef4ff3d77a)) {
    return 0;
  }

  var_4dac0fb6eca3c18f = [];

  foreach(zone in level.var_261c48ef4ff3d77a) {
    if(!isDefined(zone.complete)) {
      var_4dac0fb6eca3c18f[var_4dac0fb6eca3c18f.size] = zone;
      continue;
    }
  }

  var_e6065833510c1c0c = random(var_4dac0fb6eca3c18f);
  level.var_261c48ef4ff3d77a = var_4dac0fb6eca3c18f;

  if(!isDefined(var_e6065833510c1c0c)) {
    return 0;
  }

  if(!isDefined(var_e6065833510c1c0c.nodes)) {
    var_e6065833510c1c0c.nodes = bot_get_valid_nodes_in_trigger(var_e6065833510c1c0c.trigger);
  }

  if(!isDefined(var_e6065833510c1c0c.entrance_indices)) {
    bot_cache_entrances_to_zones([var_e6065833510c1c0c]);
  }

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_launchfacility") {
    return function_1631df751543c615(var_e6065833510c1c0c);
  }

  if(is_equal(self.pers["team"], game["attackers"])) {
    if(!self botsetscriptgoal((-24616.4, 42112.4, -160), 256, "critical")) {
      return 0;
    }

    result = bot_waittill_goal_or_fail();

    if(result != "goal") {
      return 0;
    }
  }

  node = random(var_e6065833510c1c0c.nodes);

  if(!self botsetscriptgoal(node.origin, 16, "critical")) {
    return 0;
  }

  result = bot_waittill_goal_or_fail();

  if(result != "goal") {
    return 0;
  } else {
    self botclearscriptgoal();
  }

  return 1;
}

function function_1631df751543c615(var_e6065833510c1c0c) {
  node = random(var_e6065833510c1c0c.nodes);

  if(!self botsetscriptgoal(node.origin, 128, "critical")) {
    return false;
  }

  result = bot_waittill_goal_or_fail();

  if(result != "goal") {
    return false;
  } else {
    self botclearscriptgoal();
  }

  return true;
}

function function_2023c59812a1896a() {
  if(!isDefined(level.var_be550dbbd45701ee)) {
    return false;
  }

  if(is_equal(self.pers["team"], game["attackers"])) {
    foreach(bombzone in array_randomize(level.var_be550dbbd45701ee)) {
      if(!istrue(bombzone.complete)) {
        var_a199db824f7b26c8 = bombzone;
        self botclearbutton("use");
      }
    }

    point = getclosestpointonnavmesh(var_a199db824f7b26c8.curorigin);
    self botsetscriptgoal(point, 16, "critical");

    sphere(point, 16, (1, 1, 1), 0, 4000);

    result = bot_waittill_goal_or_fail();

    if(result == "goal") {
      self botpressbutton("use", 100);
      result = bot_usebutton_wait(100);
      self botclearscriptgoal();
    }
  } else {
    return false;
  }

  return true;
}

function function_bebf9ca11875f590() {
  if(!isDefined(level.var_f55e20c194c117f4)) {
    return false;
  }

  var_63a51796b1077bee = undefined;

  if(is_equal(self.pers["team"], game["attackers"])) {
    foreach(aasite in array_randomize(level.var_f55e20c194c117f4)) {
      if(!isDefined(aasite)) {
        continue;
      }

      objective = level.objectives[aasite.objectivekey];

      if(!istrue(objective.complete)) {
        var_63a51796b1077bee = aasite;
        self botclearbutton("use");
      }
    }

    if(!isDefined(var_63a51796b1077bee)) {
      return false;
    }

    point = var_63a51796b1077bee.origin - 64 * vectorNormalize(anglesToForward(var_63a51796b1077bee.angles)) + 64 * vectorNormalize(anglestoright(var_63a51796b1077bee.angles));
    point = getclosestpointonnavmesh(point);
    self botsetscriptgoal(point, 16, "critical");

    sphere(point, 16, (1, 1, 1), 0, 4000);

    result = bot_waittill_goal_or_fail();

    if(result == "goal") {
      self botpressbutton("use", 100);
      result = bot_usebutton_wait(100);
      self botclearscriptgoal();
    }
  } else {
    return false;
  }

  return true;
}

function bot_get_valid_nodes_in_trigger(trigger) {
  nodes = getnodesintrigger(trigger, 1);
  valid_nodes = [];

  foreach(node in nodes) {
    if(!node nodeisdisconnected() && !isnode3d(node) && node.type != "Begin" && node.type != "End") {
      valid_nodes[valid_nodes.size] = node;
    }
  }

  return valid_nodes;
}

function function_80669a2cc4016fb3() {
  if(!isDefined(self.var_1131c442fdb61642)) {
    self.var_1131c442fdb61642 = random(level.hostages);
  }

  if(!isDefined(self.var_1131c442fdb61642)) {
    return false;
  }

  if(function_7eeb6264cce0f89f()) {
    self botsetscriptgoal(level.var_c8bf3a4374d235bf.curorigin, 16, "critical");
    result = bot_waittill_goal_or_fail();

    if(result == "goal") {
      self botpressbutton("use", 1);
      result = bot_usebutton_wait(1);
    }
  } else if(is_equal(self.pers["team"], level.var_350e53e094ac2a9f)) {
    if(!isDefined(self.var_1131c442fdb61642.curorigin)) {
      return false;
    }

    self botsetscriptgoal(self.var_1131c442fdb61642.curorigin, 16, "critical");
    result = bot_waittill_goal_or_fail();

    if(result == "goal") {
      self botpressbutton("use", 1);
      result = bot_usebutton_wait(1);
    }
  }

  return true;
}

function bot_hack_think() {
  if(!isDefined(level.zone.hackzones)) {
    return false;
  }

  var_726a9696890786c2 = getdvarint(@ "hash_ed44a08b9b3977b4", 1000);
  teammates = scripts\mp\utility\teams::getteamdata(self.team, "alivePlayers");
  teammates = array_remove(teammates, self);
  var_1eb88dc02a294370 = undefined;
  bestscore = 0;
  isattacker = is_equal(self.pers["team"], game["attackers"]);

  foreach(zone in level.zone.hackzones) {
    if(!isDefined(zone) || istrue(zone.complete)) {
      continue;
    }

    var_9b10f05d6b9cbebd = 0;

    if(isDefined(zone.var_256648199aa47753)) {
      var_9b10f05d6b9cbebd = zone.var_256648199aa47753;
    }

    score = 0;

    if(isattacker) {
      if(!zone.hacked) {
        if(istrue(zone.ishacking)) {
          score += 200;
        } else {
          score += 300;
        }
      } else {
        score += 100;
        score -= var_9b10f05d6b9cbebd * 100;
      }
    } else if(zone.hacked) {
      if(istrue(zone.var_9832d5270deb1889)) {
        score += 200;
      } else {
        score += 300;
        score += var_9b10f05d6b9cbebd * 100;
      }
    } else {
      score += 100;
    }

    nearbyteammates = sortbydistancecullbyradius(teammates, zone.curorigin, var_726a9696890786c2);
    score -= nearbyteammates.size * 1;

    if(bestscore < score) {
      bestscore = score;
      var_1eb88dc02a294370 = zone;
      continue;
    }

    if(bestscore == score) {
      if(isDefined(var_1eb88dc02a294370)) {
        if(distance2dsquared(zone.curorigin, self.origin) < distance2dsquared(var_1eb88dc02a294370.curorigin, self.origin)) {
          var_1eb88dc02a294370 = zone;
        }
      }
    }
  }

  if(!isDefined(var_1eb88dc02a294370)) {
    return false;
  }

  shouldusebutton = isattacker && !var_1eb88dc02a294370.hacked && !istrue(var_1eb88dc02a294370.ishacking) || !isattacker && var_1eb88dc02a294370.hacked && !istrue(var_1eb88dc02a294370.var_9832d5270deb1889);

  if(shouldusebutton) {
    var_3a7e29744dcf854e = 16;
    point = getclosestpointonnavmesh(var_1eb88dc02a294370.curorigin);
    self botclearscriptgoal();
    waitframe();
    success = self botsetscriptgoal(point, var_3a7e29744dcf854e, "critical");

    if(!success) {
      return false;
    }

    sphere(point, var_3a7e29744dcf854e, (1, 0, 0), 0, 120);

    result = bot_waittill_goal_or_fail(2);

    if(result != "goal") {
      return false;
    }

    var_440b40d0c6eeb8d2 = getdvarint(@ "hash_cf260feea44f2491", 5);

    if(isDefined(self.lastdamagedtime) && gettime() - self.lastdamagedtime < var_440b40d0c6eeb8d2) {
      return true;
    }

    holdtime = getdvarint(@ "hash_20b6c6b984cdc05b", 3);
    self botpressbutton("use", holdtime);
    result = bot_usebutton_wait(holdtime, "damage");
    self botclearscriptgoal();
    return true;
  } else {
    var_1ea0f0660989cffb = 32;
    point = function_864ee9f5b187fb0a(var_1eb88dc02a294370.curorigin, 256, 1024);
    self botclearscriptenemy();
    success = self botsetscriptgoal(point, var_1ea0f0660989cffb, "critical");

    if(!success) {
      return false;
    }

    sphere(point, var_1ea0f0660989cffb, (1, 1, 1), 0, 120);

    result = bot_waittill_goal_or_fail(5);
    return (result == "goal");
  }

  return false;
}

function function_4473b5af345c0b75(startheight) {
  var_75bb4da43489d9ae = distance2d(self.origin, self.desiredlandingspot);
  var_e5da52ae39be43f3 = 500;
  var_e5fef95b22eec246 = 350;

  if(var_75bb4da43489d9ae < var_e5da52ae39be43f3 && startheight > var_e5fef95b22eec246) {
    self botpressbutton("cut_chute");
    var_aa17a2b26eaf935f = 10000;
    endtime = gettime() + var_aa17a2b26eaf935f;

    while(true) {
      currenttime = gettime();

      if(currenttime >= endtime) {
        break;
      }

      var_19ed8a8a2a03e81a = 50;
      var_d459f6d98bfb8aad = function_82dc476c43087820();
      var_c6f79a0dcb0aca65 = self.origin[2] - self.desiredlandingspot[2];

      if(var_c6f79a0dcb0aca65 < var_e5fef95b22eec246 && self isparachuting() || var_d459f6d98bfb8aad < var_19ed8a8a2a03e81a) {
        break;
      }

      var_6a8da31c699ef658 = 1;
      var_b8996303b685a203 = 800;
      gravity = getdvarint(@ "bg_gravity", var_b8996303b685a203);
      velocity = self getvelocity();
      var_966b732f6569a932 = abs(velocity[2]) * var_6a8da31c699ef658 + gravity * var_6a8da31c699ef658 * var_6a8da31c699ef658 * 0.5;
      var_ef86ab5709584341 = max(abs(velocity[2]) * var_6a8da31c699ef658, var_e5fef95b22eec246);
      var_4e25ddb1d88d3b34 = randomfloat(1) > 0.1;

      if(!self isparachuting() && var_d459f6d98bfb8aad < var_966b732f6569a932) {
        self botpressbutton("jump");
      } else if(self function_3c6bb30ae7106b7a() && var_d459f6d98bfb8aad > var_ef86ab5709584341) {
        if(var_4e25ddb1d88d3b34) {
          self botpressbutton("cut_chute");
        }
      }

      self botlookatpoint(self.desiredlandingspot, 0.05, "script_forced");
      verticalvelocity = max(abs(velocity[2]), 0.1);
      timetoland = var_c6f79a0dcb0aca65 / verticalvelocity;
      var_75bb4da43489d9ae = distance2d(self.origin, self.desiredlandingspot);
      var_4a1fb03882e4e567 = var_75bb4da43489d9ae / timetoland;
      targetdirection = self.desiredlandingspot - self.origin;
      targetdirection = vectorNormalize((targetdirection[0], targetdirection[1], 0));
      targetvelocity = targetdirection * var_4a1fb03882e4e567;
      deltavelocity = targetvelocity - velocity;
      var_b2bee1aed960f257 = vectortoangles(vectorNormalize(deltavelocity));
      self botsetscriptmove(var_b2bee1aed960f257[1], 0.05, 1);
      wait 0.05;
    }
  }
}

function function_82dc476c43087820() {
  var_c1d1fc4d9d46438d = -25000;
  groundpos = scripts\engine\utility::drop_to_ground(self.origin, 0, var_c1d1fc4d9d46438d);

  if(isDefined(groundpos)) {
    return (self.origin[2] - groundpos[2]);
  }

  return 0;
}

function function_762c429d94276c0(goal) {
  self.desiredlandingspot = goal;
  self botpressbutton("jump");

  while(self isskydiving() || self isparachuting()) {
    update_time = 0.05;
    var_2d1d4d719dbc9554 = vectorNormalize(self.desiredlandingspot - self.origin);
    var_b2bee1aed960f257 = vectortoangles(var_2d1d4d719dbc9554);
    self botlookatpoint(self.desiredlandingspot, update_time, "script_forced");
    self botsetscriptmove(var_b2bee1aed960f257[1], update_time, 1);

    if(self function_3c6bb30ae7106b7a()) {
      var_d459f6d98bfb8aad = function_82dc476c43087820();
      function_4473b5af345c0b75(var_d459f6d98bfb8aad);
    }

    wait update_time;
  }
}

function function_a329958947b1be20() {
  if(getmapname() == "mp_jup_skydiving") {
    isattacker = is_equal(self.team, game["attackers"]);
    hasinfil = scripts\mp\flags::gameflag("infil_started");
    var_5a7b6bd0f75ab6c5 = hasinfil && isattacker && self isskydiving() && self.origin[2] > 6000;

    if(var_5a7b6bd0f75ab6c5) {
      landingspot = (-10115, -23800, 5475);
      function_762c429d94276c0(landingspot);
    }
  }

  if(!isDefined(level.zone.currentphase)) {
    return false;
  }

  if(level.zone.currentphase == "hack") {
    return bot_hack_think();
  } else if(level.zone.currentphase == "bomb") {
    if(!isDefined(level.zone.bombzones)) {
      return false;
    }

    var_726a9696890786c2 = getdvarint(@ "hash_8da3d5284a0b0c3d", 1000);
    teammates = scripts\mp\utility\teams::getteamdata(self.team, "alivePlayers");
    teammates = array_remove(teammates, self);
    var_1eb88dc02a294370 = undefined;
    bestscore = 0;
    isattacker = is_equal(self.pers["team"], game["attackers"]);

    foreach(zone in level.zone.bombzones) {
      if(!isDefined(zone) || istrue(zone.complete)) {
        continue;
      }

      var_9b10f05d6b9cbebd = 0;

      if(isDefined(zone.var_256648199aa47753)) {
        var_9b10f05d6b9cbebd = zone.var_256648199aa47753;
      }

      score = 0;

      if(isattacker) {
        if(!zone.robbed) {
          if(istrue(zone.var_b7c18e4654e6881a)) {
            score += 200;
          } else {
            score += 300;
          }
        } else {
          score += 100;
          score -= var_9b10f05d6b9cbebd * 100;
        }
      } else if(zone.robbed) {
        if(istrue(zone.var_9832d5270deb1889)) {
          score += 200;
        } else {
          score += 300;
          score += var_9b10f05d6b9cbebd * 100;
        }
      } else {
        score += 100;
      }

      nearbyteammates = sortbydistancecullbyradius(teammates, zone.curorigin, var_726a9696890786c2);
      score -= nearbyteammates.size * 1;

      if(bestscore < score) {
        bestscore = score;
        var_1eb88dc02a294370 = zone;
        continue;
      }

      if(bestscore == score) {
        if(isDefined(var_1eb88dc02a294370)) {
          if(distance2dsquared(zone.curorigin, self.origin) < distance2dsquared(var_1eb88dc02a294370.curorigin, self.origin)) {
            var_1eb88dc02a294370 = zone;
          }
        }
      }
    }

    if(!isDefined(var_1eb88dc02a294370)) {
      return false;
    }

    shouldusebutton = isattacker && !var_1eb88dc02a294370.robbed && !istrue(var_1eb88dc02a294370.var_b7c18e4654e6881a) || !isattacker && var_1eb88dc02a294370.robbed && !istrue(var_1eb88dc02a294370.var_9832d5270deb1889);

    if(shouldusebutton) {
      var_3a7e29744dcf854e = 16;
      point = getclosestpointonnavmesh(var_1eb88dc02a294370.curorigin);
      self botclearscriptgoal();
      waitframe();
      success = self botsetscriptgoal(point, var_3a7e29744dcf854e, "critical");

      if(!success) {
        return false;
      }

      sphere(point, var_3a7e29744dcf854e, (1, 0, 0), 0, 120);

      result = bot_waittill_goal_or_fail(2);

      if(result != "goal") {
        return false;
      }

      var_927bef94aaecef83 = getdvarint(@ "hash_4108174fc6fa9fbf", 5);

      if(isDefined(self.lastdamagedtime) && gettime() - self.lastdamagedtime < var_927bef94aaecef83) {
        return true;
      }

      if(zone.robbed) {
        holdtime = getdvarint(@ "hash_a1aaf3a8323384a2", 5);
      } else {
        holdtime = getdvarint(@ "hash_dd35cc4eb6279867", 5);
      }

      self botpressbutton("use", holdtime);
      result = bot_usebutton_wait(holdtime, "damage");
      self botclearscriptgoal();
      return true;
    } else {
      var_1ea0f0660989cffb = 32;
      point = function_864ee9f5b187fb0a(var_1eb88dc02a294370.curorigin, 256, 1024);
      self botclearscriptenemy();
      success = self botsetscriptgoal(point, var_1ea0f0660989cffb, "critical");

      if(!success) {
        return false;
      }

      sphere(point, var_1ea0f0660989cffb, (1, 1, 1), 0, 120);

      result = bot_waittill_goal_or_fail(5);
      return (result == "goal");
    }
  }

  return false;
}

function function_47f50aa0634c3b02() {
  var_144da732d85f9cb9 = 512;
  var_3ed6540cb9f94f5c = 20;
  var_3613882be77daf1d = var_144da732d85f9cb9;
  var_4baf4f8316b6450a = undefined;
  var_35b2ce8c921ff7c7 = 0;
  delayseconds = undefined;

  if(!isDefined(self.vehicle_target)) {
    self.vehicle_target = level.escortvehicles[0];
  }

  isattacker = is_equal(self.pers["team"], game["attackers"]);

  if(!isDefined(self.vehicle_target) || !istrue(self.vehicle_target.var_29a4616e42091783)) {
    if(isattacker) {
      var_1604f1383b5b8325 = getEnt("wheelson_airdrop", "script_noteworthy");

      if(isDefined(var_1604f1383b5b8325)) {
        var_4baf4f8316b6450a = getclosestpointonnavmesh(var_1604f1383b5b8325.origin);
        var_35b2ce8c921ff7c7 = 1;
      }
    } else {
      var_1b68b02bda4e7dd8 = function_e17e6ea4a9ca9f04("tri_build_tank_trap");
      var_4baf4f8316b6450a = getrandomnavpoint(var_1b68b02bda4e7dd8.origin, var_3613882be77daf1d);
      delayseconds = 3;
    }
  }

  if(!isDefined(var_4baf4f8316b6450a)) {
    if(istrue(self.vehicle_target.var_65ab8f532ca7195)) {
      if(!isDefined(self.vehicle_target.var_bd58ba3741947988.nodes)) {
        self.vehicle_target.var_bd58ba3741947988.nodes = bot_get_valid_nodes_in_trigger(self.vehicle_target.var_bd58ba3741947988.trigger);
      }

      if(self.vehicle_target.var_bd58ba3741947988.nodes.size > 0) {
        nodetogo = random(self.vehicle_target.var_bd58ba3741947988.nodes);
        var_4baf4f8316b6450a = nodetogo.origin;
      }
    } else if(!isattacker) {
      if(function_286ec19da44b5f3(self.vehicle_target, self.pers["team"])) {
        var_1b68b02bda4e7dd8 = function_e17e6ea4a9ca9f04("tri_build_tank_trap");
        var_4baf4f8316b6450a = getrandomnavpoint(var_1b68b02bda4e7dd8.origin, var_3613882be77daf1d);
        delayseconds = 3;
      }
    }
  }

  if(!isDefined(var_4baf4f8316b6450a)) {
    if(isDefined(self.vehicle_target.tanknearbyrange)) {
      var_3613882be77daf1d = self.vehicle_target.tanknearbyrange;
    }

    var_4baf4f8316b6450a = getrandomnavpoint(self.vehicle_target.origin, var_3613882be77daf1d);
  }

  if(!isDefined(var_4baf4f8316b6450a)) {
    return false;
  }

  if(function_286ec19da44b5f3(var_4baf4f8316b6450a, self.pers["team"])) {
    return false;
  }

  if(isDefined(delayseconds)) {
    wait delayseconds;
  }

  if(!self botsetscriptgoal(var_4baf4f8316b6450a, 64, "critical")) {
    return false;
  }

  result = bot_waittill_goal_or_fail();

  if(result == "goal") {
    if(var_35b2ce8c921ff7c7) {
      self botpressbutton("use", 10);
    }

    self botclearscriptgoal();
    return true;
  }

  return false;
}

function function_c62f2faf741f9a21() {
  if(namespace_500f6f1bc37289b::function_88cb5e18754f7caf(level.zone)) {
    var_d1b2eaa0e8a848cb = undefined;
    bestscore = 0;
    isattacker = is_equal(self.pers["team"], game["attackers"]);
    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "players");
    var_fc29bd54654586f3 = getdvarint(@ "hash_ed44a08b9b3977b4", 400);

    if(isDefined(self.carryingflag)) {
      var_d1b2eaa0e8a848cb = level.zone.flagzone;
    } else {
      foreach(flag in level.zone.captureflags) {
        if(!isDefined(flag) || istrue(flag.complete)) {
          continue;
        }

        score = 0;

        if(isattacker) {
          if(istrue(flag.iscarrying)) {
            score += 200;
          } else {
            score += 300;
          }

          var_61e70cb9d6a225fd = distance2d(flag.curorigin, self.origin);
          score += 80000 / var_61e70cb9d6a225fd;
        } else {
          if(istrue(flag.iscarrying)) {
            score += 300;
          } else {
            score += 200;
          }

          var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, flag.curorigin, var_fc29bd54654586f3);
          score += var_95f2a51e7b487eb2.size * 50;
        }

        var_ed581a61684ae7ef = distance2d(flag.curorigin, level.zone.flagzone.curorigin);
        score += 160000 / var_ed581a61684ae7ef;

        if(bestscore < score) {
          bestscore = score;
          var_d1b2eaa0e8a848cb = flag;
        }
      }
    }

    if(!isDefined(var_d1b2eaa0e8a848cb)) {
      return 0;
    }

    shouldusebutton = isattacker && (!istrue(var_d1b2eaa0e8a848cb.iscarrying) || isDefined(self.carryingflag));

    if(shouldusebutton) {
      var_3a7e29744dcf854e = 16;
      point = getclosestpointonnavmesh(var_d1b2eaa0e8a848cb.curorigin);
      self botclearscriptgoal();
      waitframe();
      success = self botsetscriptgoal(point, var_3a7e29744dcf854e, "critical");

      if(!success) {
        return 0;
      }

      sphere(point, var_3a7e29744dcf854e, (1, 0, 0), 0, 120);

      result = bot_waittill_goal_or_fail(2);

      if(result != "goal") {
        return 0;
      }

      var_440b40d0c6eeb8d2 = getdvarint(@ "hash_cf260feea44f2491", 5);

      if(isDefined(self.lastdamagedtime) && gettime() - self.lastdamagedtime < var_440b40d0c6eeb8d2) {
        return 1;
      }

      self botpressbutton("use", 1);
      result = bot_usebutton_wait(1);
      self botclearscriptgoal();
      return 1;
    } else {
      var_1ea0f0660989cffb = 32;
      point = function_864ee9f5b187fb0a(var_d1b2eaa0e8a848cb.curorigin, 256, 1024);
      self botclearscriptenemy();
      success = self botsetscriptgoal(point, var_1ea0f0660989cffb, "critical");

      if(!success) {
        return 0;
      }

      sphere(point, var_1ea0f0660989cffb, (1, 1, 1), 0, 120);

      result = bot_waittill_goal_or_fail(5);
      return (result == "goal");
    }

    return 0;
  }

  var_e6065833510c1c0c = level.zone.flag_capture_zone;

  if(!isDefined(var_e6065833510c1c0c)) {
    return 0;
  }

  if(!isDefined(var_e6065833510c1c0c.nodes)) {
    var_e6065833510c1c0c.nodes = bot_get_valid_nodes_in_trigger(var_e6065833510c1c0c.trigger);
  }

  if(!isDefined(var_e6065833510c1c0c.entrance_indices)) {
    bot_cache_entrances_to_zones([var_e6065833510c1c0c]);
  }

  return function_1631df751543c615(var_e6065833510c1c0c);
}

function function_864ee9f5b187fb0a(origin, radius_min, radius_max) {
  r = randomfloatrange(radius_min, radius_max);
  angle = randomfloat(360);
  offset = (r * cos(angle), r * sin(angle), 0);
  pos = origin + offset;
  navpos = getclosestpointonnavmesh(pos);
  return navpos;
}

function function_96811b18496ea942(objectivetype, func) {
  if(!isDefined(level.var_395a230826837426)) {
    level.var_395a230826837426 = [];
  }

  level.var_395a230826837426[objectivetype] = func;
}

function function_7eeb6264cce0f89f() {
  return istrue(self.hashostage);
}

function clear_defend() {
  if(bot_is_defending()) {
    bot_defend_stop();
  }
}

function bot_is_capturing_zone(zone) {
  if(!bot_is_capturing()) {
    return false;
  }

  return self.current_zone == zone;
}

function bot_capture_koth_zone(zone) {
  self.current_zone = zone;
  optional_params["entrance_points_index"] = zone.entrance_indices;
  optional_params["override_origin_node"] = zone.center_node;
  bot_capture_zone(zone.trigger.origin, zone.nodes, zone.trigger, optional_params);
}

function function_83f5124a532560e(origin, radius) {
  if(is_equal(self.pers["team"], game["attackers"])) {
    enemies = scripts\mp\utility\teams::getteamdata(game["defenders"], "alivePlayers");
  } else {
    enemies = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
  }

  return sortbydistancecullbyradius(enemies, origin, radius);
}

function function_286ec19da44b5f3(target, team) {
  volumes = level.zone.subzones;

  if(isDefined(level.var_354c397f5458af46)) {
    volumes = level.var_354c397f5458af46;
  }

  foreach(volume in volumes) {
    volumeteam = game[volume.side];

    if(is_equal(team, volumeteam)) {
      continue;
    }

    if(isent(target) && target istouching(volume)) {
      return true;
    }

    if(isvector(target) && ispointinvolume(target, volume)) {
      return true;
    }
  }

  return false;
}

function function_e17e6ea4a9ca9f04(var_2d990af941dea69b) {
  var_34bd7f77c1bd7f95 = getEntArray(var_2d990af941dea69b, "targetname");
  var_34bd7f77c1bd7f95 = array_randomize(var_34bd7f77c1bd7f95);

  foreach(var_21aa880940b57e58 in var_34bd7f77c1bd7f95) {
    var_752efa2620c8bd5e = getEntArray(var_21aa880940b57e58.target, "targetname");

    foreach(var_3b7acff62849bb1d in var_752efa2620c8bd5e) {
      if(function_286ec19da44b5f3(var_3b7acff62849bb1d, self.pers["team"])) {
        continue;
      }

      return var_3b7acff62849bb1d;
    }
  }

  return undefined;
}