/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\planner_squad_utility.gsc
****************************************************/

#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_chain;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace planner_squad_utility;

autoexec __init__system__() {
  system::register(#"planner_squad_utility", &plannersquadutility::__init__, undefined, undefined);
}

#namespace plannersquadutility;

private __init__() {
  plannerutility::registerplannerapi(#"hash_5414bc90f9b0a9a4", &function_790fb743);
  plannerutility::registerplannerapi(#"hash_4a94655debb4ee2f", &function_f6ec02a4);
  plannerutility::registerplannerapi(#"squadhasattackobject", &strategyhasattackobject);
  plannerutility::registerplannerapi(#"squadhasbelowxammo", &strategyhasbelowxammounsafe);
  plannerutility::registerplannerapi(#"squadhasblackboardvalue", &strategyhasblackboardvalue);
  plannerutility::registerplannerapi(#"squadhasdefendobject", &strategyhasdefendobject);
  plannerutility::registerplannerapi(#"squadhasescort", &strategyhasescort);
  plannerutility::registerplannerapi(#"squadhasescortpoi", &strategyhasescortpoi);
  plannerutility::registerplannerapi(#"squadhasforcegoal", &strategyhasforcegoal);
  plannerutility::registerplannerapi(#"squadhasobjective", &strategyhasobjective);
  plannerutility::registerplannerapi(#"hash_3e9c87665dfef699", &function_b384b9b6);
  plannerutility::registerplannerapi(#"hash_5dfbc649e2cdd6aa", &function_2083115a);
  plannerutility::registerplannerapi(#"squadhaspathableammocache", &strategyhaspathableammocache);
  plannerutility::registerplannerapi(#"hash_2b8bf371fba6de6a", &function_a0f209b7);
  plannerutility::registerplannerapi(#"hash_3ed9287b5cc1ec2c", &function_e96dd96b);
  plannerutility::registerplannerapi(#"hash_5678bc75fd7c0675", &function_50c7bd5a);
  plannerutility::registerplanneraction(#"hash_186a23f9ca83351f", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
  plannerutility::registerplanneraction(#"squadclearareatoattackobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatoattackobjectupdate, undefined);
  plannerutility::registerplanneraction(#"hash_553b7b133c2aee64", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &function_903aeb1c, undefined);
  plannerutility::registerplanneraction(#"squadclearareatodefendobject", &strategyclearareaobjectparam, &strategyclearareatoobjectinit, &strategyclearareatodefendobjectupdate, undefined);
  plannerutility::registerplanneraction(#"squadclearareatoescort", &strategyclearareatoescortparam, &strategyclearareatoescortinit, &strategyclearareatoescortupdate, undefined);
  plannerutility::registerplanneraction(#"squadclearareatogoldenpath", &strategyclearareatogoldenpathparam, &strategyclearareatogoldenpathinit, &strategyclearareatogoldenpathupdate, undefined);
  plannerutility::registerplanneraction(#"squadclearareatoobjective", &strategyclearareaobjectiveparam, &strategyclearareatoobjectiveinit, &strategyclearareatoobjectiveupdate, undefined);
  plannerutility::registerplanneraction(#"hash_12d15145a12cf7ed", &strategybotobjectparam, &function_b3ede444, &function_942e45dc, undefined);
  plannerutility::registerplanneraction(#"hash_23810516f86c60f", &strategybotparam, &function_6ed940fb, &function_4c91e90d, undefined);
  plannerutility::registerplanneraction(#"squadrushattackobject", &strategybotobjectparam, &strategyrushattackobjectinit, &strategyrushattackobjectupdate, undefined);
  plannerutility::registerplanneraction(#"squadrushcloserthanxammocache", &strategyrushammocacheparam, &strategyrushammocacheinit, &strategyrushammocacheupdate, undefined);
  plannerutility::registerplanneraction(#"squadrushdefendobject", &strategybotobjectparam, &strategyrushdefendobjectinit, &strategyrushdefendobjectupdate, undefined);
  plannerutility::registerplanneraction(#"hash_7c1f27a774d46b97", &strategyclearareatoescortparam, &function_5ac5aed, &function_a856fc9d, undefined);
  plannerutility::registerplanneraction(#"squadrushforcegoal", &strategybotgoalparam, &strategyrushforcegoalinit, &strategyrushforcegoalupdate, undefined);
  plannerutility::registerplanneraction(#"squadrushobjective", &strategyrushobjectiveparam, &strategyrushobjectiveinit, &strategyrushobjectiveupdate, undefined);
  plannerutility::registerplanneraction(#"squadwander", &strategybotparam, &strategywanderinit, &strategywanderupdate, undefined);
  plannerutility::registerplanneraction(#"squadendplan", undefined, undefined, undefined, undefined);
}

private _assigngameobject(bot, gameobject) {
  if(isDefined(bot) && isalive(bot) && isDefined(gameobject) && bot bot::function_343d7ef4()) {
    bot.goalradius = 512;

    if(isDefined(gameobject.e_object) && isvehicle(gameobject.e_object)) {
      bot setgoal(gameobject.e_object);
    } else if(isDefined(gameobject.trigger)) {
      _setgoalpoint(bot, gameobject.trigger.origin);
    } else {
      _setgoalpoint(bot, gameobject.origin);
    }

    if(gameobject.type == "use" || gameobject.type == "useObject" || gameobject.type == "carryObject") {
      if(!isDefined(bot.owner) || isbot(bot.owner) || !strategiccommandutility::isvalidplayer(bot.owner)) {
        bot bot::set_interact(gameobject);
      }
    }
  }
}

private _cleargameobject(bot) {
  if(strategiccommandutility::isvalidbot(bot)) {
    if(!isDefined(bot.owner) || isbot(bot.owner)) {
      bot bot::clear_interact();
    }
  }
}

private _calculateadjustedpathsegments(params) {
  params.adjustedpath = [];
  params.adjustedpathsegment = 0;

  if(isDefined(params.path) && isDefined(params.path.pathpoints) && params.path.pathpoints.size > 0) {
    adjustedpath = [];
    radius = function_48bd5e74(params.bots);
    segmentlength = radius * 1.5;
    pathpointssize = params.path.pathpoints.size;
    currentdistance = 0;
    currentpoint = params.path.pathpoints[0];
    adjustedpath[adjustedpath.size] = currentpoint;

    for(index = 1; index < pathpointssize; index++) {
      nextpoint = params.path.pathpoints[index];
      distancetonextpoint = distance2d(currentpoint, nextpoint);
      totaldistance = currentdistance + distancetonextpoint;

      if(totaldistance < segmentlength) {
        currentdistance += distancetonextpoint;
        currentpoint = nextpoint;
        continue;
      }

      if(totaldistance >= segmentlength) {
        distancetonextadjusted = segmentlength - currentdistance;
        ratiotonextadjusted = distancetonextadjusted / distancetonextpoint;
        currentpoint = lerpvector(currentpoint, nextpoint, ratiotonextadjusted);
        adjustedpath[adjustedpath.size] = currentpoint;
        currentdistance = 0;
        index--;
      }
    }

    adjustedpath[adjustedpath.size] = params.path.pathpoints[pathpointssize - 1];
    params.adjustedpath = adjustedpath;
    params.fallback = params.adjustedpath[0];

    if(params.adjustedpath.size >= 2) {
      direction = params.adjustedpath[1] - params.adjustedpath[0];
      direction = vectornormalize(direction);
      fallback = params.adjustedpath[0] - direction * 256;
      fallback = getclosestpointonnavmesh(fallback, 256);

      if(isDefined(fallback)) {
        if(tracepassedonnavmesh(params.adjustedpath[0], fallback)) {
          params.fallback = fallback;
        }
      }
    }
  }
}

private function_48bd5e74(bots) {
  foreach(bot in bots) {
    if(isDefined(bot) && bot isinvehicle()) {
      return 640;
    }
  }

  return 256;
}

private function_66f80bb1(bots) {
  foreach(bot in bots) {
    if(isDefined(bot) && bot isinvehicle()) {
      return (256 / 2 * 2.5);
    }
  }

  return 256 / 2;
}

private function_e1b14108(bots) {
  foreach(bot in bots) {
    if(isDefined(bot) && bot isinvehicle()) {
      return (256 * 1.5 * 2.5);
    }
  }

  return 256 * 1.5;
}

private function_8ff43349(bots) {
  foreach(bot in bots) {
    if(isDefined(bot) && bot isinvehicle()) {
      return (256 / 2 * 6 * 2.5);
    }
  }

  return 256 / 2 * 6;
}

private _debugadjustedpath(params) {
  if(getdvarint(#"ai_debugsquadareas", 0)) {
    bot = undefined;

    foreach(bot in params.bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        break;
      }
    }

    innerradius = function_66f80bb1(params.bots);
    outerradius = function_8ff43349(params.bots);

    for(index = 1; index < params.adjustedpath.size; index++) {
      start = params.adjustedpath[index - 1];
      end = params.adjustedpath[index];
      center = start + (end - start) * 0.5;

      recordline(start, end, (1, 0.5, 0), "<dev string:x38>");
      recordcircle(center, function_48bd5e74(params.bots), (1, 0, 0), "<dev string:x38>");

      if(isDefined(bot)) {
        offset = 10;
        pointdanger = _evaluatepointdanger(bot, center, innerradius, outerradius);

        record3dtext("<dev string:x45>" + pointdanger.inner, center, (1, 0, 0), "<dev string:x38>");
        record3dtext("<dev string:x4e>" + pointdanger.outer, center + (0, 0, offset), (1, 0.5, 0), "<dev string:x38>");

      }
    }

    currentpathsegment = params.adjustedpathsegment;

    if(isDefined(currentpathsegment) && isarray(params.adjustedpath) && currentpathsegment < params.adjustedpath.size - 2) {
      currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;

      recordsphere(currentcenter, 10, (0, 1, 0));

    }
  }
}

private _evaluateadjustedpath(params) {
  if(params.adjustedpath.size <= 0) {
    return;
  }

  bot = undefined;

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      break;
    }
  }

  currentpathsegment = params.adjustedpathsegment;
  innerradius = function_66f80bb1(params.bots);
  outerradius = function_8ff43349(params.bots);

  if(currentpathsegment > 0) {
    previouscenter = (params.adjustedpath[currentpathsegment - 1] + params.adjustedpath[currentpathsegment]) / 2;
    previouspointdanger = _evaluatepointdanger(bot, previouscenter, innerradius, outerradius);
  }

  currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  currentpointdanger = _evaluatepointdanger(bot, currentcenter, innerradius, outerradius);

  if(currentpathsegment < params.adjustedpath.size - 2) {
    nextcenter = (params.adjustedpath[currentpathsegment + 1] + params.adjustedpath[currentpathsegment + 2]) / 2;
    nextpointdanger = _evaluatepointdanger(bot, nextcenter, innerradius, outerradius);
  }

  injured = 0;

  foreach(bot in params.bots) {
    if(_isinjured(bot)) {
      injured = 1;
      break;
    }
  }

  reachedcurrent = 0;
  var_4fbb80f1 = function_e1b14108(params.bots);

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      if(distance2dsquared(bot.origin, currentcenter) <= var_4fbb80f1 * var_4fbb80f1) {
        reachedcurrent = 1;
        break;
      }
    }
  }

  if(reachedcurrent) {
    if(injured) {
      if(isDefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15) {
        params.adjustedpathsegment--;
      }

      return;
    }

    if(currentpointdanger.outer <= 50 && currentpointdanger.inner <= 15) {
      if(isDefined(nextpointdanger) && nextpointdanger.inner <= 15) {
        params.adjustedpathsegment++;
      }
    }

    if(currentpathsegment == params.adjustedpathsegment) {
      foreach(bot in params.bots) {
        if(strategiccommandutility::isvalidbot(bot) && isalive(bot) && !bot haspath() && (!isDefined(bot.enemy) || !bot cansee(bot.enemy))) {
          params.adjustedpathsegment++;
          break;
        }
      }
    }

    if(currentpathsegment == params.adjustedpathsegment) {
      if(currentpointdanger.inner > 15) {
        if(isDefined(previouspointdanger) && previouspointdanger.inner < currentpointdanger.inner && previouspointdanger.outer > 15) {
          params.adjustedpathsegment--;
        }
      }
    }
  }
}

private _evaluatepointdanger(bot, center, inner, outer) {
  pointdanger = spawnStruct();
  pointdanger.inner = tacticalinfluencergetthreatscore(center, inner, bot.team);
  pointdanger.outer = tacticalinfluencergetthreatscore(center, outer, bot.team);
  return pointdanger;
}

private _isinjured(bot) {
  if(strategiccommandutility::isvalidbot(bot) && isDefined(bot.health) && isDefined(bot.maxhealth)) {
    tacstate = bot bot::function_d473f7de();

    if(isDefined(tacstate)) {
      return (bot.health / bot.maxhealth <= (isDefined(tacstate.lowhealthratio) ? tacstate.lowhealthratio : 0));
    }
  }

  return false;
}

private _paramshasbots(params) {
  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      return true;
    }
  }

  return false;
}

private _setgoalpoint(bot, point, likelyenemyposition) {
  if(isDefined(bot) && isalive(bot) && isvec(point) && bot bot::function_343d7ef4()) {
    if(bot isinvehicle()) {
      vehicle = bot getvehicleoccupied();
      seatnum = vehicle getoccupantseat(bot);

      if(seatnum == 0) {
        vehicle setgoal(point);
      }

      return;
    }

    navmeshpoint = getclosestpointonnavmesh(point, 200);

    if(!isDefined(navmeshpoint)) {
      navmeshpoint = point;
    }

    bot setgoal(navmeshpoint);

    if(isDefined(likelyenemyposition) && isvec(likelyenemyposition)) {
      bot.var_2925fedc = likelyenemyposition;
      return;
    }

    bot.var_2925fedc = undefined;
  }
}

private function_a1574a8d(bot, trigger, likelyenemyposition) {
  if(isDefined(bot) && isDefined(trigger) && bot bot::function_343d7ef4()) {
    if(bot isinvehicle()) {
      vehicle = bot getvehicleoccupied();
      vehicle setgoal(trigger);
      return;
    }

    bot setgoal(trigger);

    if(isDefined(likelyenemyposition) && isvec(likelyenemyposition)) {
      bot.var_2925fedc = likelyenemyposition;
      return;
    }

    bot.var_2925fedc = undefined;
  }
}

private function_d065f4fd(adjustedpath, currentpathsegment, var_769cf7b7) {
  for(i = var_769cf7b7; i >= 0; i--) {
    lookaheadpoint = adjustedpath[currentpathsegment + var_769cf7b7];

    if(isDefined(lookaheadpoint)) {
      return lookaheadpoint;
    }
  }

  return undefined;
}

private strategybotgoalparam(planner, constants) {
  params = spawnStruct();
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.goal = planner::getblackboardattribute(planner, "force_goal");
  return params;
}

private strategybotobjectparam(planner, constants) {
  params = spawnStruct();
  objects = planner::getblackboardattribute(planner, "gameobjects");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.order = planner::getblackboardattribute(planner, "order");

  if(isDefined(objects) && isarray(objects)) {
    params.object = objects[0][#"__unsafe__"][#"object"];
  }

  target = planner::getblackboardattribute(planner, "target");

  if(isDefined(target)) {
    params.bundle = target[#"__unsafe__"][#"bundle"];
    params.component = target[#"__unsafe__"][#"component"];
    params.object = target[#"__unsafe__"][#"object"];
  }

  if(isDefined(params.object)) {
    foreach(bot in bots) {
      params.path = strategiccommandutility::calculatepathtogameobject(bot, params.object);

      if(isDefined(params.path)) {
        break;
      }
    }
  }

  if(isDefined(params.component)) {
    foreach(bot in bots) {
      params.path = strategiccommandutility::function_704d5fbd(bot, params.component);

      if(isDefined(params.path)) {
        break;
      }
    }
  }

  if(isDefined(params.bundle)) {
    foreach(bot in bots) {
      params.path = strategiccommandutility::function_2cce6a82(bot, params.bundle);

      if(isDefined(params.path)) {
        break;
      }
    }
  }

  return params;
}

strategybotparam(planner, constants) {
  params = spawnStruct();
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  return params;
}

private strategyclearareaobjectiveparam(planner, constants) {
  params = strategyrushobjectiveparam(planner, constants);
  params.adjustedpath = [];
  return params;
}

private strategyclearareaobjectparam(planner, constants) {
  params = strategybotobjectparam(planner, constants);
  params.adjustedpath = [];
  return params;
}

private strategyclearareatoescortinit(planner, params) {
  _calculateadjustedpathsegments(params);

  if(!isDefined(params.escort) || !_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private strategyclearareatoescortparam(planner, constants) {
  params = strategyrushescortparam(planner, constants);
  params.adjustedpath = [];
  return params;
}

private strategyclearareatogoldenpathinit(planner, params) {
  _calculateadjustedpathsegments(params);

  if(!_paramshasbots(params)) {
    if(!isDefined(params.goldengameobject) && !isDefined(params.goldenobjective)) {
      return 2;
    }
  }

  return 1;
}

private strategyclearareatogoldenpathparam(planner, constants) {
  params = spawnStruct();
  target = planner::getblackboardattribute(planner, "target");
  escortpoi = planner::getblackboardattribute(planner, "escort_poi");
  escorts = planner::getblackboardattribute(planner, "escorts");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.escort = escorts[0][#"__unsafe__"][constants[#"escortkey"]];

  if(isDefined(target)) {
    params.var_263ac6c8 = target[#"__unsafe__"][#"bundle"];
    params.var_d7403996 = target[#"__unsafe__"][#"component"];
    params.goldengameobject = target;
  }

  if(isDefined(escortpoi)) {
    params.goldenpathdistance = escortpoi[0][#"distance"];
    params.goldengameobject = escortpoi[0][#"gameobject"];
    params.goldenobjective = escortpoi[0][#"objective"];
  }

  if(isDefined(params.var_263ac6c8)) {
    if(isDefined(params.escort)) {
      params.path = strategiccommandutility::function_2cce6a82(params.escort, params.var_263ac6c8);
    }
  }

  if(isDefined(params.var_d7403996)) {
    if(isDefined(params.escort)) {
      params.path = strategiccommandutility::function_704d5fbd(params.escort, params.var_d7403996);
    }
  }

  if(isDefined(params.goldengameobject)) {
    gameobject = params.goldengameobject[#"__unsafe__"][#"object"];

    if(isDefined(params.escort) && isDefined(gameobject)) {
      params.path = strategiccommandutility::calculatepathtogameobject(params.escort, gameobject);
    }
  }

  if(isDefined(params.goldenobjective)) {
    trigger = params.goldenobjective[#"__unsafe__"][#"trigger"];

    if(isDefined(params.escort) && isDefined(trigger)) {
      params.path = strategiccommandutility::calculatepathtoobjective(params.escort, trigger);
    }
  }

  params.adjustedpath = [];
  return params;
}

private function_903aeb1c(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.escort) || !_paramshasbots(params)) {
    return 2;
  }

  escort = params.escort;

  if(!isDefined(escort)) {
    return 2;
  }

  if(!isDefined(params.fallback)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _setgoalpoint(bot, params.fallback, function_d065f4fd(params.adjustedpath, 0, 3));
      bot.goalradius = 256;
    }
  }
}

private strategyclearareatogoldenpathupdate(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.escort) || !_paramshasbots(params)) {
    return 2;
  }

  if(params.adjustedpath.size <= 0) {
    return 2;
  }

  escort = params.escort;
  currentpathsegment = 0;
  currentcenter = undefined;

  if(params.adjustedpath.size > 1) {
    params.adjustedpathsegment = 1;
    params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
    currentpathsegment = params.adjustedpathsegment;
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  }

  var_ba6c6b41 = function_48bd5e74(params.bots);

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      _setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
      bot.goalradius = var_ba6c6b41;
    }
  }

  return 3;
}

private strategyclearareatoobjectinit(planner, params) {
  _calculateadjustedpathsegments(params);

  if(!isDefined(params.object) && !isDefined(params.component) && !isDefined(params.bundle)) {
    return 2;
  }

  if(!_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private strategyclearareatoobjectiveinit(planner, params) {
  _calculateadjustedpathsegments(params);

  if(!isDefined(params.objective) || !_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private strategyclearareatoattackobjectupdate(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.object) && !isDefined(params.component) && !isDefined(params.bundle)) {
    return 2;
  }

  if(!_paramshasbots(params)) {
    return 2;
  }

  entity = undefined;
  trigger = undefined;

  if(isDefined(params.object)) {
    trigger = params.object.trigger;
  } else if(isDefined(params.component)) {
    foreach(bot in params.bots) {
      if(!isDefined(bot)) {
        continue;
      }

      trigger = strategiccommandutility::function_5c2c9542(bot, params.component);
    }
  } else if(isDefined(params.bundle)) {
    switch (params.bundle.m_str_type) {
      case #"escortbiped":
        entity = params.bundle.var_27726d51;
        break;
    }
  }

  if(!isDefined(trigger) && !isDefined(entity)) {
    return 2;
  }

  currentpathsegment = 0;
  currentcenter = undefined;

  if(params.adjustedpath.size > 1) {
    _evaluateadjustedpath(params);
    params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
    currentpathsegment = params.adjustedpathsegment;
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  }

  var_ba6c6b41 = function_48bd5e74(params.bots);

  foreach(bot in params.bots) {
    if(!strategiccommandutility::isvalidbot(bot)) {
      continue;
    }

    if(currentpathsegment >= params.adjustedpath.size - 2) {
      if(!isDefined(params.order) || params.order == "order_attack") {
        if(isDefined(params.object) && params.object.triggertype == "use") {
          _assigngameobject(bot, params.object);
        } else if(isDefined(trigger)) {
          function_a1574a8d(bot, trigger, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
        } else {
          _setgoalpoint(bot, entity.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
        }
      } else {
        if(isDefined(params.object)) {
          _setgoalpoint(bot, params.object.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
        } else if(isDefined(trigger)) {
          _setgoalpoint(bot, trigger.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
        } else {
          _setgoalpoint(bot, entity.origin, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
        }

        bot.goalradius = 512;
      }

      continue;
    }

    _cleargameobject(bot);
    bot.goalradius = var_ba6c6b41;
    _setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
  }

  if(isDefined(params.object) && params.object.trigger istriggerenabled()) {
    return 3;
  } else if(isDefined(params.component)) {
    return 3;
  } else if(isDefined(params.bundle)) {
    return 3;
  }

  return 1;
}

private strategyclearareatodefendobjectupdate(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.object) || !isDefined(params.object.trigger) || !_paramshasbots(params)) {
    return 2;
  }

  currentpathsegment = 0;
  currentcenter = undefined;

  if(params.adjustedpath.size > 1) {
    _evaluateadjustedpath(params);
    params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
    currentpathsegment = params.adjustedpathsegment;
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  }

  var_ba6c6b41 = function_48bd5e74(params.bots);

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);

      if(currentpathsegment >= params.adjustedpath.size - 2) {
        _setgoalpoint(bot, params.object.origin);
        bot.goalradius = 512;
        continue;
      }

      _setgoalpoint(bot, currentcenter);
      bot.goalradius = var_ba6c6b41;
    }
  }

  if(params.object.trigger istriggerenabled()) {
    return 3;
  }

  return 1;
}

private strategyclearareatoescortupdate(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.escort) || !_paramshasbots(params)) {
    return 2;
  }

  escort = params.escort;

  if(!isDefined(escort)) {
    return 2;
  }

  currentpathsegment = 0;
  currentcenter = undefined;

  if(params.adjustedpath.size > 1) {
    _evaluateadjustedpath(params);
    params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
    currentpathsegment = params.adjustedpathsegment;
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  }

  var_ba6c6b41 = function_48bd5e74(params.bots);

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);

      if(currentpathsegment >= params.adjustedpath.size - 2) {
        if(!bot isingoal(escort.origin)) {
          _setgoalpoint(bot, escort.origin);
          bot.goalradius = 512;
        }

        continue;
      }

      _setgoalpoint(bot, currentcenter);
      bot.goalradius = var_ba6c6b41;
    }
  }

  return 3;
}

private strategyclearareatoobjectiveupdate(planner, params) {
  _debugadjustedpath(params);

  if(!isDefined(params.objective) || !_paramshasbots(params)) {
    return 2;
  }

  currentpathsegment = 0;
  currentcenter = undefined;

  if(params.adjustedpath.size > 1) {
    _evaluateadjustedpath(params);
    params.adjustedpathsegment = int(max(min(params.adjustedpathsegment, params.adjustedpath.size - 2), 0));
    currentpathsegment = params.adjustedpathsegment;
    currentcenter = (params.adjustedpath[currentpathsegment] + params.adjustedpath[currentpathsegment + 1]) / 2;
  }

  var_ba6c6b41 = function_48bd5e74(params.bots);

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);

      if(currentpathsegment >= params.adjustedpath.size - 2) {
        trigger = params.objective[#"__unsafe__"][#"trigger"];

        if(isDefined(trigger)) {
          function_a1574a8d(bot, trigger);
        } else {
          _setgoalpoint(bot, params.objective[#"origin"]);
          bot.goalradius = 512;
        }

        if(isDefined(params.objective[#"radius"])) {
          bot.goalradius = params.objective[#"radius"];
        }

        continue;
      }

      _setgoalpoint(bot, currentcenter, function_d065f4fd(params.adjustedpath, currentpathsegment, 3));
      bot.goalradius = var_ba6c6b41;
    }
  }

  if(isDefined(params.objective) && objective_state(params.objective[#"id"]) == "active") {
    return 3;
  }

  return 1;
}

private strategyhasattackobject(planner, constants) {
  team = planner::getblackboardattribute(planner, "team");
  objects = planner::getblackboardattribute(planner, "gameobjects");

  if(isDefined(objects)) {
    foreach(object in objects) {
      if(object[#"team"] == team || object[#"team"] == #"any" || object[#"team"] == "free") {
        return true;
      }
    }
  }

  return false;
}

private strategyhasescort(planner, constants) {
  escorts = planner::getblackboardattribute(planner, "escorts");

  if(!isarray(escorts) || escorts.size <= 0) {
    return false;
  }

  escortkey = constants[#"key"];

  if(!isstring(escortkey) && !ishash(escortkey) || escortkey == "") {
    return true;
  }

  for(i = 0; i < escorts.size; i++) {
    escort = escorts[i][#"__unsafe__"][escortkey];

    if(isDefined(escort)) {
      return true;
    }
  }

  return false;
}

private strategyhasescortpoi(planner, constants) {
  escortpoi = planner::getblackboardattribute(planner, "escort_poi");
  return isarray(escortpoi) && escortpoi.size > 0;
}

private strategyhasforcegoal(planner, constants) {
  return isDefined(planner::getblackboardattribute(planner, "force_goal"));
}

private function_790fb743(planner, constants) {
  assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x57>" + "<dev string:x65>" + "<dev string:xa1>");
  attribute = planner::getblackboardattribute(planner, constants[#"key"]);

  if(isDefined(attribute) && isarray(attribute)) {
    return (attribute.size > 0);
  }

  return false;
}

private function_f6ec02a4(planner, constants) {
  assert(isfloat(constants[#"percent"]), "<dev string:x57>" + "<dev string:xc7>" + "<dev string:xfd>");

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bot = botinfo[#"__unsafe__"][#"bot"];

    if(!strategiccommandutility::isvalidbot(bot)) {
      continue;
    }

    weapons = bot getweaponslistprimaries();

    foreach(weapon in weapons) {
      if(isDefined(weapon) && weapon.name != "none") {
        currentammo = bot getammocount(weapon);
        maxammo = weapon.maxammo;

        if(isDefined(maxammo) && maxammo > 0) {
          ammofraction = currentammo / maxammo;

          if(ammofraction >= constants[#"percent"]) {
            return false;
          }
        }
      }
    }

    return true;
  }

  return false;
}

private strategyhasbelowxammounsafe(planner, constants) {
  assert(isfloat(constants[#"percent"]), "<dev string:x57>" + "<dev string:x127>" + "<dev string:xfd>");

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bot = botinfo[#"__unsafe__"][#"bot"];

    if(!strategiccommandutility::isvalidbot(bot)) {
      continue;
    }

    weapons = bot getweaponslistprimaries();

    foreach(weapon in weapons) {
      if(isDefined(weapon) && weapon.name != "none") {
        currentammo = bot getammocount(weapon);
        maxammo = weapon.maxammo;

        if(isDefined(maxammo) && maxammo > 0) {
          ammofraction = currentammo / maxammo;

          if(ammofraction < constants[#"percent"]) {
            return true;
          }
        }
      }
    }
  }

  return false;
}

private strategyhasblackboardvalue(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
  value = planner::getblackboardattribute(planner, constants[#"name"]);
  return value == constants[#"value"];
}

private strategyhasdefendobject(planner, constants) {
  team = planner::getblackboardattribute(planner, "team");
  objects = planner::getblackboardattribute(planner, "gameobjects");

  if(isDefined(objects)) {
    foreach(object in objects) {
      if(object[#"team"] != team && object[#"team"] != #"any" && object[#"team"] != "free") {
        return true;
      }
    }
  }

  return false;
}

private strategyhasobjective(planner, constants) {
  team = planner::getblackboardattribute(planner, "team");
  objects = planner::getblackboardattribute(planner, "objectives");

  if(isDefined(objects)) {
    foreach(object in objects) {
      if(objective_state(object[#"id"]) == "active") {
        return true;
      }
    }
  }

  return false;
}

private function_b384b9b6(planner, constants) {
  order = planner::getblackboardattribute(planner, "order");
  return order === constants[#"order"];
}

private function_2083115a(planner, constants) {
  team = planner::getblackboardattribute(planner, "team");
  target = planner::getblackboardattribute(planner, "target");

  if(isDefined(target)) {
    switch (target[#"type"]) {
      case #"gameobject":
        return true;
      case #"goto":
        return true;
      case #"destroy":
        return true;
      case #"defend":
        return true;
      case #"capturearea":
        return true;
      case #"escortbiped":
        return true;
    }
  }

  return false;
}

private strategyhaspathableammocache(planner, constants) {
  ammocaches = planner::getblackboardattribute(planner, "pathable_ammo_caches");
  return isDefined(ammocaches) && ammocaches.size > 0;
}

private strategyrushammocacheinit(planner, params) {
  if(!isDefined(params.ammo) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _setgoalpoint(bot, params.ammo.origin);
      bot.goalradius = 512;
      _assigngameobject(bot, params.ammo);
    }
  }

  return 1;
}

private function_a0f209b7(planner, constants) {
  assert(isfloat(constants[#"percent"]), "<dev string:x57>" + "<dev string:x15a>" + "<dev string:xfd>");

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bot = botinfo[#"__unsafe__"][#"bot"];

    if(!strategiccommandutility::isvalidbot(bot)) {
      continue;
    }

    weapon = bot getcurrentweapon();

    if(isDefined(weapon) && weapon.name != "none") {
      currentammo = bot getammocount(weapon);
      maxammo = weapon.maxammo;

      if(isDefined(maxammo) && maxammo > 0) {
        ammofraction = currentammo / maxammo;

        if(ammofraction < constants[#"percent"]) {
          return true;
        }
      }
    }
  }

  return false;
}

private function_b3ede444(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private function_942e45dc(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(!isalive(bot) || !strategiccommandutility::isvalidbot(bot) || !isDefined(bot.var_aeb3e046) || !bot.var_aeb3e046.size > 0 || bot bot_chain::function_58b429fb()) {
      continue;
    }

    goalinfo = bot function_4794d6a3();

    if(goalinfo.goalforced) {
      continue;
    }

    crumb = bot.var_aeb3e046[0];
    botnum = bot getentitynumber();

    if(isDefined(crumb.var_2777474d) && isDefined(crumb.var_2777474d[botnum])) {
      continue;
    }

    if(isDefined(crumb.target)) {
      var_8d50333d = struct::get_array(crumb.target, "targetname");
      botchains = [];

      foreach(var_ced34a87 in var_8d50333d) {
        if(var_ced34a87.variantname === "bot_chain") {
          botchains[botchains.size] = var_ced34a87;
        }
      }

      if(botchains.size > 0) {
        bot thread bot_chain::function_cf70f2fe(botchains[randomint(botchains.size)]);

        if(!isDefined(crumb.var_2777474d)) {
          crumb.var_2777474d = [];
        } else if(!isarray(crumb.var_2777474d)) {
          crumb.var_2777474d = array(crumb.var_2777474d);
        }

        crumb.var_2777474d[botnum] = 1;
        continue;
      }
    }

    component = crumb.var_36f0c06d;
    targetvol = undefined;

    if(isDefined(component)) {
      if(isDefined(component.var_2956bff4)) {
        targetvol = component.var_2956bff4;
      } else if(isDefined(component.e_objective) && isDefined(component.e_objective.mdl_gameobject)) {
        targetvol = component.e_objective.mdl_gameobject.trigger;
      }
    } else if(isDefined(crumb.trigger)) {
      targetvol = crumb.trigger;
    }

    if(isDefined(targetvol)) {
      bot setgoal(targetvol);
    }
  }

  return 1;
}

private function_6ed940fb(planner, params) {
  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      bot.goalradius = 256;
    }
  }

  return true;
}

private function_4c91e90d(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _setgoalpoint(bot, bot.origin);
      bot.goalradius = 256;
    }
  }

  return 3;
}

private strategyrushammocacheparam(planner, constants) {
  assert(isint(constants[#"distance"]) || isfloat(constants[#"distance"]), "<dev string:x57>" + "<dev string:x194>" + "<dev string:x1c6>");
  params = spawnStruct();
  params.bots = [];
  botpositions = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bot = botinfo[#"__unsafe__"][#"bot"];

    if(strategiccommandutility::isvalidbot(bot)) {
      botposition = getclosestpointonnavmesh(botinfo[#"origin"], 200);

      if(isDefined(botposition)) {
        botpositions[botpositions.size] = botposition;
      }

      params.bots[params.bots.size] = bot;
    }
  }

  possiblecaches = [];
  distancesq = constants[#"distance"] * constants[#"distance"];

  foreach(gameobject in level.a_gameobjects) {
    if(isDefined(gameobject) && gameobject gameobjects::get_identifier() === "ammo_cache") {
      closeenough = 1;

      foreach(botposition in botpositions) {
        if(distance2dsquared(gameobject.origin, botposition) > distancesq) {
          closeenough = 0;
          break;
        }
      }

      if(closeenough) {
        possiblecaches[possiblecaches.size] = gameobject;
      }
    }
  }

  path = undefined;
  shortestpath = undefined;
  closestammocache = undefined;

  foreach(ammocache in possiblecaches) {
    ammocachepos = getclosestpointonnavmesh(ammocache.origin, 200);

    if(isDefined(ammocachepos)) {
      pathsegment = generatenavmeshpath(ammocachepos, botpositions);

      if(isDefined(pathsegment) && pathsegment.status === "succeeded") {
        if(pathsegment.pathdistance > constants[#"distance"]) {
          continue;
        }

        if(!isDefined(path) || pathsegment.pathdistance < shortestpath) {
          path = pathsegment;
          shortestpath = pathsegment.pathdistance;
          closestammocache = ammocache;
        }
      }
    }
  }

  if(isDefined(closestammocache)) {
    planner::setblackboardattribute(planner, "pathable_ammo_caches", array(closestammocache));
    params.ammo = closestammocache;
  }

  return params;
}

private strategyrushammocacheupdate(planner, params) {
  if(!isDefined(params.ammo) || !_paramshasbots(params)) {
    return 2;
  }

  if(params.ammo.trigger istriggerenabled()) {
    foreach(bot in params.bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        _setgoalpoint(bot, params.ammo.origin);
        bot.goalradius = 512;
        _assigngameobject(bot, params.ammo);
      }
    }

    return 3;
  }

  return 2;
}

private strategyrushattackobjectinit(planner, params) {
  if(!isDefined(params.object) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(params.object.triggertype == "proximity") {
      function_a1574a8d(bot, params.object.trigger);
      continue;
    }

    _assigngameobject(bot, params.object);
  }

  return 1;
}

private strategyrushattackobjectupdate(planner, params) {
  if(!isDefined(params.object) || !_paramshasbots(params)) {
    return 2;
  }

  if(params.object.trigger istriggerenabled()) {
    return 3;
  }

  return 1;
}

private strategyrushdefendobjectinit(planner, params) {
  if(!isDefined(params.object) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      _setgoalpoint(bot, params.object.origin);
      bot.goalradius = 512;
    }
  }

  return 1;
}

private strategyrushdefendobjectupdate(planner, params) {
  if(!isDefined(params.object) || !_paramshasbots(params)) {
    return 2;
  }

  if(params.object.trigger istriggerenabled()) {
    return 3;
  }

  return 2;
}

private strategyrushescortparam(planner, constants) {
  params = spawnStruct();
  escorts = planner::getblackboardattribute(planner, "escorts");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.escort = escorts[0][#"__unsafe__"][#"player"];

  if(isDefined(params.escort)) {
    foreach(bot in bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        params.path = strategiccommandutility::calculatepathtoposition(bot, params.escort.origin);

        if(isDefined(params.path)) {
          break;
        }
      }
    }
  }

  return params;
}

private function_5ac5aed(planner, params) {
  if(!isDefined(params.escort) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot bot::clear_interact();
      var_4b3d8f59 = 0;

      if(sessionmodeiszombiesgame() && isDefined(params.bots[0]) && isalive(params.bots[0])) {
        groundent = params.escort getgroundent();

        if(isDefined(groundent) && groundent ismovingplatform()) {
          var_201e45bb = (randomfloatrange(groundent.mins[0], groundent.maxs[0]), randomfloatrange(groundent.mins[1], groundent.maxs[1]), 0);
          var_d0354e07 = (groundent.origin + var_201e45bb) * (1, 1, 0);
          var_2c574437 = var_d0354e07 + (0, 0, params.escort.origin[2] + 16);
          targetpoint = getclosestpointonnavmesh(var_2c574437, 64, 16);

          if(isDefined(targetpoint)) {
            var_4b3d8f59 = 1;
            bot setgoal(targetpoint, 1);
          }
        }
      }

      if(!var_4b3d8f59) {
        bot clearforcedgoal();
        bot setgoal(params.escort);
        bot.goalradius = 512;
      }
    }
  }

  return 1;
}

private function_a856fc9d(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.escort)) {
    if(sessionmodeiszombiesgame() && isDefined(params.bots[0]) && isalive(params.bots[0]) && isDefined(params.bots[0].goalent) && params.bots[0].goalent == params.escort) {
      groundent = params.escort getgroundent();

      if(isDefined(groundent) && groundent ismovingplatform()) {
        return 2;
      }
    }

    return 3;
  }

  return 2;
}

private strategyrushforcegoalinit(planner, params) {
  if(!isDefined(params.goal) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      bot setgoal(params.goal);
    }
  }

  return 1;
}

private strategyrushforcegoalupdate(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.goal)) {
    return 3;
  }

  return 2;
}

private strategyrushobjectiveinit(planner, params) {
  if(!isDefined(params.objective) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      _setgoalpoint(bot, params.objective[#"origin"]);
      bot.goalradius = 512;

      if(isDefined(params.objective[#"radius"])) {
        bot.goalradius = params.objective[#"radius"];
      }
    }
  }

  return 1;
}

private strategyrushobjectiveparam(planner, constants) {
  params = spawnStruct();
  objectives = planner::getblackboardattribute(planner, "objectives");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.objective = objectives[0];

  if(isDefined(params.objective)) {
    trigger = params.objective[#"__unsafe__"][#"trigger"];

    if(isDefined(trigger)) {
      foreach(bot in bots) {
        if(strategiccommandutility::isvalidbot(bot)) {
          params.path = strategiccommandutility::calculatepathtotrigger(bot, trigger);

          if(isDefined(params.path)) {
            break;
          }
        }
      }
    } else {
      foreach(bot in bots) {
        if(strategiccommandutility::isvalidbot(bot)) {
          params.path = strategiccommandutility::calculatepathtoposition(bot, objective_position(params.objective[#"id"]));

          if(isDefined(params.path)) {
            break;
          }
        }
      }
    }
  }

  return params;
}

private strategyrushobjectiveupdate(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.objective) && objective_state(params.objective[#"id"]) == "active") {
    return 3;
  }

  return 2;
}

private function_e96dd96b(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"focus"]) || ishash(constants[#"focus"]));
  target = planner::getblackboardattribute(planner, "target");

  if(isDefined(target)) {
    var_3d879b56 = target[#"strategy"];
    var_f8ffdb19 = strategiccommandutility::function_f4921cb3(constants[#"focus"]);
    squadbots = planner::getblackboardattribute(planner, "doppelbots");

    if(isstruct(var_3d879b56)) {
      foreach(botinfo in squadbots) {
        bot = botinfo[#"__unsafe__"][#"bot"];
        var_681a8d61 = "doppelbotsfocus";

        foreach(focus in var_f8ffdb19) {
          if(var_3d879b56.(var_681a8d61) == focus) {
            return true;
          }
        }
      }
    }
  }

  return false;
}

private function_50c7bd5a(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"tactics"]) || ishash(constants[#"tactics"]));
  var_e67e6f95 = constants[#"tactics"];
  target = planner::getblackboardattribute(planner, "target");

  if(isDefined(target)) {
    var_3d879b56 = target[#"strategy"];

    if(isstruct(var_3d879b56)) {
      return (var_3d879b56.("doppelbotstactics") == var_e67e6f95);
    }
  }

  return false;
}

private strategywanderinit(planner, params) {
  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      _cleargameobject(bot);
      bot.goalradius = 128;
    }
  }

  return true;
}

private strategywanderupdate(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      if(!isDefined(bot._wander_update_time)) {
        bot._wander_update_time = 0;
      }

      if(bot._wander_update_time + 3000 < gettime() || bot isingoal(bot.origin)) {
        searchradius = 1024;
        navmeshpoint = getclosestpointonnavmesh(bot.origin, 200);

        if(isDefined(navmeshpoint)) {
          forward = anglesToForward(bot getangles());
          forwardpos = bot.origin + forward * searchradius;
          cylinder = ai::t_cylinder(bot.origin, searchradius, searchradius);
          points = tacticalquery(#"stratcom_tacquery_wander", navmeshpoint, cylinder, forwardpos, bot);

          if(points.size > 0) {
            _setgoalpoint(bot, points[0].origin);
            bot._wander_update_time = gettime();
          }
        }
      }
    }
  }

  return 3;
}