/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\planner_commander_utility.gsc
********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_squad;
#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\system_shared;

#namespace planner_commander_utility;

autoexec __init__system__() {
  system::register(#"planner_commander_utility", &plannercommanderutility::__init__, undefined, undefined);
}

#namespace plannercommanderutility;

private __init__() {
  plannerutility::registerplannerapi(#"hash_3032cc0c39eec160", &function_790fb743);
  plannerutility::registerplannerapi(#"hash_27cb7425e82f36b2", &function_a05a08bf);
  plannerutility::registerplannerapi(#"commanderblackboardvalueistrue", &strategyblackboardvalueistrue);
  plannerutility::registerplannerapi(#"hash_758a5e038102521d", &function_a75b29d8);
  plannerutility::registerplannerapi(#"commanderhasatleastxassaultobjects", &strategyhasatleastxassaultobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxdefendobjects", &strategyhasatleastxdefendobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxobjectives", &strategyhasatleastxobjectives);
  plannerutility::registerplannerapi(#"commanderhasatleastxplayers", &strategyhasatleastxplayers);
  plannerutility::registerplannerapi(#"commanderhasatleastxpriorityassaultobjects", &strategyhasatleastxpriorityassaultobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxprioritydefendobjects", &strategyhasatleastxprioritydefendobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxunassignedbots", &strategyhasatleastxunassignedbots);
  plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedassaultobjects", &strategyhasatleastxunclaimedassaultobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxunclaimeddefendobjects", &strategyhasatleastxunclaimeddefendobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedpriorityassaultobjects", &strategyhasatleastxunclaimedpriorityassaultobjects);
  plannerutility::registerplannerapi(#"commanderhasatleastxunclaimedprioritydefendobjects", &strategyhasatleastxunclaimedprioritydefendobjects);
  plannerutility::registerplannerapi(#"commanderhasforcegoal", &strategyhasforcegoal);
  plannerutility::registerplannerapi(#"hash_3328412ef57ec24f", &function_f6a3c6d5);
  plannerutility::registerplannerapi(#"commandershouldrushprogress", &strategyshouldrushprogress);
  plannerutility::registerplannerapi(#"commandershouldthrottleprogress", &strategyshouldthrottleprogress);
  plannerutility::registerplanneraction(#"hash_665ea68c4244269", &function_e0092cfc, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_38a4c999135f3595", &function_86270cca, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_30d4da4336523524", &function_14c766b3, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_5a63edd39e17c7fa", &function_52012b78, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderendplan", undefined, undefined, undefined, undefined);
  plannerutility::registerplannerapi(#"commanderincrementblackboardvalue", &strategyincrementblackboardvalue);
  plannerutility::registerplannerapi(#"hash_1e2223a7ca7420d2", &function_166d74b2);
  plannerutility::registerplannerapi(#"hash_63fe7d4f2c2b7232", &function_f162255b);
  plannerutility::registerplannerapi(#"commandersetblackboardvalue", &strategysetblackboardvalue);
  plannerutility::registerplannerapi(#"hash_757f8311986da567", &function_20de0d52);
  plannerutility::registerplannerapi(#"hash_b0021da8974ba24", &bunker_exposure_scale);
  plannerutility::registerplannerapi(#"commandersquadhaspathableescort", &strategysquadhaspathableescort);
  plannerutility::registerplannerapi(#"commandersquadhaspathableobject", &strategysquadhaspathableobject);
  plannerutility::registerplannerapi(#"commandersquadhaspathableobjective", &strategysquadhaspathableobjective);
  plannerutility::registerplannerapi(#"commandersquadhaspathableunclaimedobject", &strategysquadhaspathableunclaimedobject);
  plannerutility::registerplannerapi(#"commandersquadcopyblackboardvalue", &strategysquadcopyblackboardvalue);
  plannerutility::registerplannerapi(#"hash_405fef7ef4724a61", &function_86c0732e);
  plannerutility::registerplannerapi(#"commandersquadsortescortpoi", &strategysquadsortescortpoi);
  plannerutility::registerplanneraction(#"commandersquadassignforcegoal", &strategysquadassignforcegoalparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignpathableescort", &strategysquadassignpathableescortparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignpathableobject", &strategysquadassignpathableobjectparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignpathableobjective", &strategysquadassignpathableobjectiveparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignpathableunclaimedobject", &strategysquadassignpathableunclaimedobjectparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_58798fbbe44b7ef0", &function_b77887e, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignwander", &strategysquadassignwanderparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_5cd436bbd4c1e857", &function_34464159, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadcalculatepathableobjectives", &strategysquadcalculatepathableobjectivesparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadcalculatepathableplayers", &strategysquadcalculatepathableplayersparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadclaimobject", &strategysquadclaimobjectparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_544ff9246bf758e2", &function_d58b0781, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_4da9a3c5542078a", &function_45f841ea, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadcreateofsizex", &strategysquadcreateofsizexparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadorder", &strategysquadorderparam, undefined, undefined, undefined);
  plannerutility::registerplannerapi(#"commandersquadescorthasnomainguard", &strategysquadescorthasnomainguard);
  plannerutility::registerplannerapi(#"commandersquadescorthasnorearguard", &strategysquadescorthasnorearguard);
  plannerutility::registerplannerapi(#"commandersquadescorthasnovanguard", &strategysquadescorthasnovanguard);
  plannerutility::registerplanneraction(#"commandersquadescortcalculatepathablepoi", &strategysquadescortcalculatepathablepoiparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignmainguard", &strategysquadescortassignmainguardparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignrearguard", &strategysquadescortassignrearguardparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commandersquadassignvanguard", &strategysquadescortassignvanguardparam, undefined, undefined, undefined);
  plannerutility::registerplannerapi(#"commanderpathinghascalculatedpaths", &strategypathinghascalculatedpaths);
  plannerutility::registerplannerapi(#"commanderpathinghascalculatedpathablepath", &strategypathinghascalculatedpathablepath);
  plannerutility::registerplannerapi(#"commanderpathinghasnorequestpoints", &strategypathinghasnorequestpoints);
  plannerutility::registerplannerapi(#"commanderpathinghasrequestpoints", &strategypathinghasrequestpoints);
  plannerutility::registerplannerapi(#"commanderpathinghasunprocessedgameobjects", &strategypathinghasunprocessedgameobjects);
  plannerutility::registerplannerapi(#"commanderpathinghasunprocessedobjectives", &strategypathinghasunprocessedobjectives);
  plannerutility::registerplannerapi(#"commanderpathinghasunprocessedrequestpoints", &strategypathinghasunprocessedrequestpoints);
  plannerutility::registerplannerapi(#"commanderpathinghasunreachablepath", &strategypathinghasunreachablepath);
  plannerutility::registerplanneraction(#"commanderpathingaddassaultgameobjects", &strategypathingaddassaultgameobjectsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingadddefendgameobjects", &strategypathingadddefendgameobjectsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingaddobjectives", &strategypathingaddobjectivesparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingaddsquadbots", &strategypathingaddsquadbotsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingaddsquadescorts", &strategypathingaddsquadescortsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedgameobjects", &strategypathingaddtosquadcalculatedgameobjectsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingaddtosquadcalculatedobjectives", &strategypathingaddtosquadcalculatedobjectivesparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingcalculatepathtorequestedpoints", &strategypathingcalculatepathtorequestedpointsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectrequestpoints", &strategypathingcalculategameobjectrequestpointsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingcalculategameobjectpathability", &strategypathingcalculategameobjectpathabilityparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingcalculateobjectiverequestpoints", &strategypathingcalculateobjectiverequestpointsparam, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"commanderpathingcalculateobjectivepathability", &strategypathingcalculateobjectivepathabilityparam, undefined, undefined, undefined);
  registerutilityapi("commanderScoreBotChain", &function_61d2b8ef);
  registerutilityapi("commanderScoreBotPresence", &utilityscorebotpresence);
  registerutilityapi("commanderScoreBotVehiclePresence", &function_de2b04c0);
  registerutilityapi("commanderScoreEscortPathing", &utilityscoreescortpathing);
  registerutilityapi("commanderScoreForceGoal", &utilityscoreforcegoal);
  registerutilityapi("commanderScoreGameobjectPathing", &utilityscoregameobjectpathing);
  registerutilityapi("commanderScoreGameobjectPriority", &utilityscoregameobjectpriority);
  registerutilityapi("commanderScoreGameobjectsValidity", &utilityscoregameobjectsvalidity);
  registerutilityapi("commanderScoreNoTarget", &function_2985faa1);
  registerutilityapi("commanderScoreProgressThrottling", &utilityscoreprogressthrottling);
  registerutilityapi("commanderScoreTarget", &function_a65b2be5);
  registerutilityapi("commanderScoreTeam", &function_f389ef61);
  registerutilityapi("commanderScoreViableEscort", &utilityscoreviableescort);
  registerdaemonapi("daemonClients", &daemonupdateclients);
  registerdaemonapi("daemonGameobjects", &daemonupdategameobjects);
  registerdaemonapi("daemonGameplayBundles", &function_e6443602);
  registerdaemonapi("daemonMissionComponents", &function_7706a6fa);
  registerdaemonapi("daemonObjectives", &daemonupdateobjective);
}

private _assignsquadunclaimeddefendgameobjectparam(planner, squadindex) {
  defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
  validobjects = [];
  defendobject = undefined;

  foreach(gameobject in defendobjects) {
    if(!gameobject[#"claimed"]) {
      validobjects[validobjects.size] = gameobject;
    }
  }

  if(validobjects.size > 0) {
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    centroid = _calculatebotscentroid(doppelbots);
    defendobject = _calculateclosestgameobject(centroid, validobjects);
  }

  if(isDefined(defendobject)) {
    planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
  }
}

private _assignsquadassaultgameobjectparam(planner, squadindex) {
  assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");

  if(assaultobjects.size > 0) {
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    centroid = _calculatebotscentroid(doppelbots);
    assaultobject = _calculateclosestgameobject(centroid, assaultobjects);
    planner::setblackboardattribute(planner, "gameobjects", array(assaultobject), squadindex);
  }
}

private _assignsquaddefendgameobjectparam(planner, squadindex) {
  defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");

  if(defendobjects.size > 0) {
    doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
    centroid = _calculatebotscentroid(doppelbots);
    defendobject = _calculateclosestgameobject(centroid, defendobjects);
    planner::setblackboardattribute(planner, "gameobjects", array(defendobject), squadindex);
  }
}

private _calculatealliedteams(team) {
  return array(team);
}

private _calculatebotscentroid(doppelbots) {
  assert(isarray(doppelbots));
  centroid = (0, 0, 0);

  foreach(doppelbot in doppelbots) {
    centroid += doppelbot[#"origin"];
  }

  if(doppelbots.size > 0) {
    return (centroid / doppelbots.size);
  }

  return centroid;
}

private _calculateclosestgameobject(position, gameobjects) {
  assert(isvec(position));
  assert(isarray(gameobjects));

  if(gameobjects.size <= 0) {
    return undefined;
  }

  closest = gameobjects[0];
  distancesq = distancesquared(position, closest[#"origin"]);

  for(index = 1; index < gameobjects.size; index++) {
    newdistancesq = distancesquared(position, gameobjects[index][#"origin"]);

    if(newdistancesq < distancesq) {
      closest = gameobjects[index];
      distancesq = newdistancesq;
    }
  }

  return closest;
}

private function_65b16924(doppelbots, components) {
  assert(isarray(doppelbots));
  assert(isarray(components));
  var_1a9886d3 = array();

  if(doppelbots.size <= 0 || components.size <= 0) {
    return var_1a9886d3;
  }

  for(componentindex = 0; componentindex < components.size; componentindex++) {
    component = components[componentindex][#"__unsafe__"][#"component"];

    if(!isDefined(component)) {
      continue;
    }

    chained = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot) || !isDefined(bot.var_aeb3e046)) {
        break;
      }

      if(bot isinvehicle()) {
        break;
      }

      foreach(crumb in bot.var_aeb3e046) {
        teaminfo = crumb.var_5b8b19fe[bot.team];

        if(!isDefined(teaminfo)) {
          continue;
        }

        if(component.var_54a1987a === teaminfo.var_951e29f) {
          chained = 1;
        }
      }
    }

    if(chained) {
      var_d6d184 = array();
      var_d6d184[#"component"] = components[componentindex];
      var_1a9886d3[var_1a9886d3.size] = var_d6d184;
    }
  }

  return var_1a9886d3;
}

private _calculateallpathablegameobjects(planner, doppelbots, gameobjects) {
  assert(isarray(doppelbots));
  assert(isarray(gameobjects));
  pathablegameobjects = [];

  if(gameobjects.size <= 0) {
    return pathablegameobjects;
  }

  if(doppelbots.size <= 0) {
    return pathablegameobjects;
  }

  for(gameobjectindex = 0; gameobjectindex < gameobjects.size; gameobjectindex++) {
    gameobject = gameobjects[gameobjectindex][#"__unsafe__"][#"object"];

    if(!isDefined(gameobject)) {
      continue;
    }

    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      path = strategiccommandutility::calculatepathtogameobject(bot, gameobject);

      if(!isDefined(path)) {
        pathable = 0;
        break;
      }

      if(path.pathdistance > longestpath) {
        longestpath = path.pathdistance;
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"gameobject"] = gameobjects[gameobjectindex];
      pathablegameobjects[pathablegameobjects.size] = path;
    }

    if(getrealtime() - planner.planstarttime > planner.maxframetime) {
      var_ce386d7a = planner.api;
      planner.api = undefined;
      aiprofile_endentry();
      pixendevent();
      aiprofile_endentry();
      pixendevent();
      waitframe(1);
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(planner);
      pixbeginevent(planner.name);
      aiprofile_beginentry(planner.name);
      planner.api = var_ce386d7a;
      pixbeginevent(var_ce386d7a);
      aiprofile_beginentry(var_ce386d7a);
      planner.planstarttime = getrealtime();
    }
  }

  return pathablegameobjects;
}

private function_816f4052(planner, doppelbots, bundles) {
  assert(isarray(doppelbots));
  assert(isarray(bundles));
  pathablebundles = [];

  if(bundles.size <= 0) {
    return pathablebundles;
  }

  if(doppelbots.size <= 0) {
    return pathablebundles;
  }

  for(bundleindex = 0; bundleindex < bundles.size; bundleindex++) {
    bundle = bundles[bundleindex][#"__unsafe__"][#"bundle"];

    if(!isDefined(bundle)) {
      continue;
    }

    escort = undefined;

    switch (bundle.m_str_type) {
      case #"escortbiped":
        escort = bundle.var_27726d51;
        break;
      default:
        break;
    }

    if(!isDefined(escort)) {
      continue;
    }

    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      path = strategiccommandutility::calculatepathtoposition(bot, escort.origin);

      if(!isDefined(path)) {
        pathable = 0;
        break;
      }

      if(path.pathdistance > longestpath) {
        longestpath = path.pathdistance;
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"bundle"] = bundles[bundleindex];
      pathablebundles[pathablebundles.size] = path;
    }

    if(getrealtime() - planner.planstarttime > planner.maxframetime) {
      var_ce386d7a = planner.api;
      planner.api = undefined;
      aiprofile_endentry();
      pixendevent();
      aiprofile_endentry();
      pixendevent();
      waitframe(1);
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(planner);
      pixbeginevent(planner.name);
      aiprofile_beginentry(planner.name);
      planner.api = var_ce386d7a;
      pixbeginevent(var_ce386d7a);
      aiprofile_beginentry(var_ce386d7a);
      planner.planstarttime = getrealtime();
    }
  }

  return pathablebundles;
}

private function_77cd4593(planner, doppelbots, components) {
  assert(isarray(doppelbots));
  assert(isarray(components));
  pathablecomponents = [];

  if(components.size <= 0) {
    return pathablecomponents;
  }

  if(doppelbots.size <= 0) {
    return pathablecomponents;
  }

  var_80e29ead = 0;

  for(botindex = 0; botindex < doppelbots.size; botindex++) {
    if(doppelbots[botindex][#"type"] == "air") {
      var_80e29ead = 1;
      break;
    }
  }

  var_b73a1d4b = 0;

  for(botindex = 0; botindex < doppelbots.size; botindex++) {
    if(doppelbots[botindex][#"type"] == "ground") {
      var_b73a1d4b = 1;
      break;
    }
  }

  for(componentindex = 0; componentindex < components.size; componentindex++) {
    component = components[componentindex][#"__unsafe__"][#"component"];

    if(!isDefined(component)) {
      continue;
    }

    trigger = undefined;

    switch (component.m_str_type) {
      case #"goto":
        break;
      case #"destroy":
      case #"defend":
        trigger = var_80e29ead ? component.var_6bc907c4 : component.var_2956bff4;
        break;
      case #"capturearea":
        trigger = component.var_cc67d976;
        break;
      default:
        break;
    }

    if(!isDefined(trigger)) {
      continue;
    }

    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      path = strategiccommandutility::calculatepathtoobjective(bot, trigger);

      if(!isDefined(path)) {
        pathable = 0;
        break;
      }

      if(path.pathdistance > longestpath) {
        longestpath = path.pathdistance;
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"objective"] = components[componentindex];
      pathablecomponents[pathablecomponents.size] = path;
    }

    if(getrealtime() - planner.planstarttime > planner.maxframetime) {
      var_ce386d7a = planner.api;
      planner.api = undefined;
      aiprofile_endentry();
      pixendevent();
      aiprofile_endentry();
      pixendevent();
      waitframe(1);
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(planner);
      pixbeginevent(planner.name);
      aiprofile_beginentry(planner.name);
      planner.api = var_ce386d7a;
      pixbeginevent(var_ce386d7a);
      aiprofile_beginentry(var_ce386d7a);
      planner.planstarttime = getrealtime();
    }
  }

  return pathablecomponents;
}

private function_98bde2b6(doppelbots, entities) {
  assert(isarray(doppelbots));
  assert(isarray(entities));
  var_afb9d067 = [];

  if(entities.size <= 0) {
    return var_afb9d067;
  }

  if(doppelbots.size <= 0) {
    return var_afb9d067;
  }

  for(entityindex = 0; entityindex < entities.size; entityindex++) {
    entity = entities[entityindex][#"__unsafe__"][#"entity"];

    if(!isDefined(entity)) {
      continue;
    }

    var_cec03170 = getclosestpointonnavmesh(entity.origin, 200);
    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];
      position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);

      if(!isDefined(position) || !isDefined(var_cec03170)) {
        pathable = 0;
        break;
      }

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      queryresult = positionquery_source_navigation(var_cec03170, 0, 120, 60, 16, bot, 16);

      if(queryresult.data.size > 0) {
        path = _calculatepositionquerypath(queryresult, position, bot);

        if(!isDefined(path)) {
          pathable = 0;
          break;
        }

        if(path.pathdistance > longestpath) {
          longestpath = path.pathdistance;
        }
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"entity"] = entities[entityindex];
      var_afb9d067[var_afb9d067.size] = path;
    }
  }

  return var_afb9d067;
}

private _calculateallpathableobjectives(doppelbots, objectives) {
  assert(isarray(doppelbots));
  assert(isarray(objectives));
  pathableobjectives = [];

  if(objectives.size <= 0) {
    return pathableobjectives;
  }

  if(doppelbots.size <= 0) {
    return pathableobjectives;
  }

  for(objectiveindex = 0; objectiveindex < objectives.size; objectiveindex++) {
    trigger = objectives[objectiveindex][#"__unsafe__"][#"trigger"];

    if(!isDefined(trigger)) {
      continue;
    }

    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      path = strategiccommandutility::calculatepathtoobjective(bot, trigger);

      if(!isDefined(path)) {
        pathable = 0;
        break;
      }

      if(path.pathdistance > longestpath) {
        longestpath = path.pathdistance;
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"objective"] = objectives[objectiveindex];
      pathableobjectives[pathableobjectives.size] = path;
    }
  }

  return pathableobjectives;
}

private _calculateallpathableclients(doppelbots, clients) {
  assert(isarray(doppelbots));
  assert(isarray(clients));
  pathableclients = [];

  if(clients.size <= 0) {
    return pathableclients;
  }

  if(doppelbots.size <= 0) {
    return pathableclients;
  }

  for(clientindex = 0; clientindex < clients.size; clientindex++) {
    player = clients[clientindex][#"__unsafe__"][#"player"];

    if(!isDefined(player) || player isinmovemode("ufo", "noclip") || player.sessionstate !== "playing") {
      continue;
    }

    var_a0f4105 = strategiccommandutility::function_778568e2(player);
    clientposition = getclosestpointonnavmesh(player.origin, 200);
    pathable = 1;
    longestpath = 0;

    for(botindex = 0; botindex < doppelbots.size; botindex++) {
      bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        pathable = 0;
        break;
      }

      var_79c06ff6 = strategiccommandutility::function_778568e2(bot);

      if(var_79c06ff6 != var_a0f4105) {
        pathable = 0;
        break;
      }

      position = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);

      if(!isDefined(position) || !isDefined(clientposition)) {
        pathable = 0;
        break;
      }

      queryresult = positionquery_source_navigation(clientposition, 0, 120, 60, 16, bot, 16);

      if(queryresult.data.size > 0) {
        path = _calculatepositionquerypath(queryresult, position, bot);

        if(!isDefined(path)) {
          pathable = 0;
          break;
        }

        if(path.pathdistance > longestpath) {
          longestpath = path.pathdistance;
        }
      }
    }

    if(pathable) {
      path = array();
      path[#"distance"] = longestpath;
      path[#"player"] = clients[clientindex];
      pathableclients[pathableclients.size] = path;
    }
  }

  return pathableclients;
}

private _calculatepositionquerypath(queryresult, position, entity) {
  path = undefined;
  longestpath = 0;

  if(queryresult.data.size > 0) {
    index = 0;

    while(index < queryresult.data.size) {
      goalpoints = [];

      for(goalindex = index; goalindex - index < 16 && goalindex < queryresult.data.size; goalindex++) {
        goalpoints[goalpoints.size] = queryresult.data[goalindex].origin;
      }

      pathsegment = generatenavmeshpath(position, goalpoints, entity);

      if(isDefined(pathsegment) && pathsegment.status === "succeeded") {
        if(pathsegment.pathdistance > longestpath) {
          path = pathsegment;
          longestpath = pathsegment.pathdistance;
        }
      }

      index += 16;
    }
  }

  return path;
}

private _calculateprioritygameobjects(gameobjects, prioritygameobjectidentifiers) {
  prioritygameobjects = [];

  foreach(gameobjectentry in gameobjects) {
    identifier = gameobjectentry[#"identifier"];

    if(!isDefined(identifier)) {
      continue;
    }

    foreach(priorityidentifier in prioritygameobjectidentifiers) {
      if(identifier == priorityidentifier) {
        prioritygameobjects[prioritygameobjects.size] = gameobjectentry;
      }
    }
  }

  return prioritygameobjects;
}

private _updatehistoricalgameobjects(commander) {
  destroyedgameobjecttotal = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
  assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
  gameobjecttotal = 0;

  if(isarray(assaultobjects)) {
    foreach(assaultobjectentry in assaultobjects) {
      if(!isDefined(assaultobjectentry)) {
        continue;
      }

      if(assaultobjectentry[#"identifier"] === "carry_object") {
        continue;
      }

      gameobject = assaultobjectentry[#"__unsafe__"][#"object"];

      if(!isDefined(gameobject) || !isDefined(gameobject.trigger) || !gameobject.trigger istriggerenabled()) {
        destroyedgameobjecttotal++;
        continue;
      }

      gameobjecttotal++;
    }
  }

  gameobjecttotal += destroyedgameobjecttotal;
  blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_destroyed", destroyedgameobjecttotal);
  blackboard::setstructblackboardattribute(commander, #"gameobjects_assault_total", gameobjecttotal);
}

private daemonupdateclients(commander) {
  team = blackboard::getstructblackboardattribute(commander, #"team");
  clients = getplayers(team);
  doppelbots = [];
  players = [];
  vehicles = [];

  foreach(client in clients) {
    cachedclient = array();
    cachedclient[#"origin"] = client.origin;
    cachedclient[#"entnum"] = client getentitynumber();
    cachedclient[#"escortmainguard"] = array();
    cachedclient[#"escortrearguard"] = array();
    cachedclient[#"escortvanguard"] = array();

    if(strategiccommandutility::isvalidbot(client)) {
      if(!isDefined(cachedclient[#"__unsafe__"])) {
        cachedclient[#"__unsafe__"] = array();
      }

      cachedclient[#"__unsafe__"][#"bot"] = client;

      if(client isinvehicle()) {
        if(strategiccommandutility::function_4732f860(client)) {
          vehicle = client getvehicleoccupied();

          if(!isDefined(cachedclient[#"__unsafe__"])) {
            cachedclient[#"__unsafe__"] = array();
          }

          cachedclient[#"__unsafe__"][#"vehicle"] = vehicle;
          cachedclient[#"type"] = strategiccommandutility::function_4b0c469d(vehicle);
          vehicles[vehicles.size] = cachedclient;
        }
      } else {
        cachedclient[#"type"] = "bot";
        doppelbots[doppelbots.size] = cachedclient;
      }

      continue;
    }

    if(strategiccommandutility::isvalidplayer(client)) {
      if(!isDefined(cachedclient[#"__unsafe__"])) {
        cachedclient[#"__unsafe__"] = array();
      }

      cachedclient[#"__unsafe__"][#"player"] = client;
      players[players.size] = cachedclient;
    }
  }

  blackboard::setstructblackboardattribute(commander, #"bot_vehicles", vehicles);
  blackboard::setstructblackboardattribute(commander, #"doppelbots", doppelbots);
  blackboard::setstructblackboardattribute(commander, #"players", players);
}

private daemonupdategameobjects(commander) {
  if(isDefined(level.a_gameobjects)) {
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
    var_31b80437 = tolower(var_832340f2);
    gameobjects = array();
    var_1d83f398 = arraycopy(level.a_gameobjects);
    var_aa8d6440 = array();
    excluded = blackboard::getstructblackboardattribute(commander, #"gameobjects_exclude");
    excludedmap = array();

    foreach(excludename in excluded) {
      excludedmap[excludename] = 1;
    }

    restrict = blackboard::getstructblackboardattribute(commander, #"gameobjects_restrict");
    var_fffabd2 = array();

    foreach(var_c96f243d in restrict) {
      var_fffabd2[var_c96f243d] = 1;
    }

    for(gameobjectindex = 0; gameobjectindex < var_1d83f398.size; gameobjectindex++) {
      gameobject = var_1d83f398[gameobjectindex];

      if(!isDefined(gameobject) || !isDefined(gameobject.trigger)) {
        continue;
      }

      if(gameobject.type === "GenericObject") {
        continue;
      }

      if(!gameobject.trigger istriggerenabled()) {
        continue;
      }

      if(!(gameobject.team == commanderteam || gameobject.team == var_31b80437 || gameobject.absolute_visible_and_interact_team === commanderteam || gameobject.team == #"free")) {
        continue;
      }

      identifier = gameobject gameobjects::get_identifier();

      if(var_fffabd2.size > 0) {
        if(!isDefined(identifier) || !isDefined(var_fffabd2[identifier])) {
          continue;
        }
      }

      if(isDefined(identifier) && isDefined(excludedmap[identifier])) {
        continue;
      }

      if(isDefined(gameobject.var_a267844e)) {
        continue;
      }

      cachedgameobject = array();
      cachedgameobject[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, undefined, undefined, gameobject);

      if(strategiccommandutility::function_f59ca353(cachedgameobject[#"strategy"])) {
        continue;
      }

      cachedgameobject[#"claimed"] = 0;
      cachedgameobject[#"type"] = "gameobject";

      if(!isDefined(cachedgameobject[#"__unsafe__"])) {
        cachedgameobject[#"__unsafe__"] = array();
      }

      cachedgameobject[#"__unsafe__"][#"object"] = gameobject;

      if(!isDefined(cachedgameobject[#"__unsafe__"])) {
        cachedgameobject[#"__unsafe__"] = array();
      }

      cachedgameobject[#"__unsafe__"][#"entity"] = gameobject.e_object;

      if(isDefined(identifier) && (identifier == "air_vehicle" || identifier == "ground_vehicle")) {
        var_aa8d6440[var_aa8d6440.size] = cachedgameobject;
      } else {
        gameobjects[gameobjects.size] = cachedgameobject;
      }

      if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
        aiprofile_endentry();
        pixendevent();
        [
          [level.strategic_command_throttle]
        ] - > waitinqueue(commander);
        commander.var_22765a25 = getrealtime();
        pixbeginevent("daemonGameobjects");
        aiprofile_beginentry("daemonGameobjects");
      }
    }

    blackboard::setstructblackboardattribute(commander, #"gameobjects", gameobjects);
    blackboard::setstructblackboardattribute(commander, #"gameobjects_vehicles", var_aa8d6440);
  }
}

private function_e6443602(commander) {
  if(isDefined(level.var_97964e1)) {
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
    var_31b80437 = tolower(var_832340f2);
    bundles = array();

    foreach(gameplay in level.var_97964e1) {
      if(!strategiccommandutility::function_208c970d(gameplay, var_832340f2)) {
        continue;
      }

      gpbundle = gameplay.o_gpbundle;
      type = gameplay.classname;
      var_5f31ab8b = array();

      switch (type) {
        case #"hash_1c67b29f3576b10d":
          var_5f31ab8b[#"type"] = "escortbiped";
          break;
        default:
          continue;
      }

      var_5f31ab8b[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, gpbundle.m_s_bundle);

      if(!isDefined(var_5f31ab8b[#"__unsafe__"])) {
        var_5f31ab8b[#"__unsafe__"] = array();
      }

      var_5f31ab8b[#"__unsafe__"][#"bundle"] = gpbundle;
      bundles[bundles.size] = var_5f31ab8b;

      if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
        aiprofile_endentry();
        pixendevent();
        [
          [level.strategic_command_throttle]
        ] - > waitinqueue(commander);
        commander.var_22765a25 = getrealtime();
        pixbeginevent("daemonMissionComponents");
        aiprofile_beginentry("daemonMissionComponents");
      }
    }

    blackboard::setstructblackboardattribute(commander, #"gpbundles", bundles);
  }
}

private function_7706a6fa(commander) {
  if(isDefined(level.var_8239a46c) && level flagsys::get(#"hash_3a3d68ab491e1985")) {
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    var_832340f2 = strategiccommandutility::function_a1edb007(commanderteam);
    var_31b80437 = tolower(var_832340f2);
    components = array();
    var_35301d62 = array();
    var_35301d62[#"hash_f5c6c6aa7dc0f6d"] = array();
    var_35301d62[#"hash_6e9081699001bcd9"] = array();
    var_35301d62[#"hash_3bf68fbcb5c53b6c"] = array();
    var_35301d62[#"hash_4984fd4b0ba666a2"] = array();

    foreach(missioncomponent in level.var_8239a46c) {
      if(!strategiccommandutility::function_f867cce0(missioncomponent, commanderteam)) {
        continue;
      }

      component = missioncomponent.var_36f0c06d;
      type = missioncomponent.scriptbundlename;
      var_b313868d = array();

      switch (type) {
        case #"hash_f5c6c6aa7dc0f6d":
          var_b313868d[#"type"] = "defend";
          break;
        case #"hash_6e9081699001bcd9":
          var_b313868d[#"type"] = "destroy";
          break;
        case #"hash_3bf68fbcb5c53b6c":
          var_b313868d[#"type"] = "capturearea";
          break;
        case #"hash_4984fd4b0ba666a2":
          if(isDefined(component.var_c68dc48c) || isDefined(component.var_b95bcdc6)) {
            var_b313868d[#"type"] = "goto";
          } else {
            println("<dev string:x38>" + missioncomponent.origin + "<dev string:x5d>");
            continue;
          }

          break;
        default:
          continue;
      }

      var_b313868d[#"strategy"] = strategiccommandutility::function_423cfbc1(var_31b80437, undefined, missioncomponent);

      if(strategiccommandutility::function_f59ca353(var_b313868d[#"strategy"])) {
        continue;
      }

      if(!isDefined(var_b313868d[#"__unsafe__"])) {
        var_b313868d[#"__unsafe__"] = array();
      }

      var_b313868d[#"__unsafe__"][#"mission_component"] = missioncomponent;

      if(!isDefined(var_b313868d[#"__unsafe__"])) {
        var_b313868d[#"__unsafe__"] = array();
      }

      var_b313868d[#"__unsafe__"][#"component"] = component;
      components[components.size] = var_b313868d;
      arraysize = var_35301d62[type].size;
      var_35301d62[type][arraysize] = var_b313868d;

      if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
        aiprofile_endentry();
        pixendevent();
        [
          [level.strategic_command_throttle]
        ] - > waitinqueue(commander);
        commander.var_22765a25 = getrealtime();
        pixbeginevent("daemonMissionComponents");
        aiprofile_beginentry("daemonMissionComponents");
      }
    }

    blackboard::setstructblackboardattribute(commander, #"missioncomponents", components);

    foreach(componenttype, componentarray in var_35301d62) {
      blackboard::setstructblackboardattribute(commander, componenttype, componentarray);
    }
  }
}

private daemonupdateobjective(commander) {
  if(isDefined(level.a_objectives)) {
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
    objectives = array();

    foreach(objective in level.a_objectives) {
      if(isDefined(objective.m_done) && objective.m_done) {
        continue;
      }

      if(isDefined(objective.m_str_team) && objective.m_str_team != commanderteam) {
        continue;
      }

      if(isDefined(objective.m_a_player_game_obj) && objective.m_a_player_game_obj.size > 0) {
        currentbreadcrumb = 0;
        furthestobjective = undefined;
        teamplayers = getplayers(commanderteam);

        foreach(player in teamplayers) {
          playerentitynumber = player getentitynumber();
          objectiveid = objective.m_a_player_game_obj[playerentitynumber];

          if(isDefined(objectiveid) && objective_state(objectiveid) == "active") {
            cachedobjective = array();
            cachedobjective[#"entnum"] = playerentitynumber;
            cachedobjective[#"id"] = objectiveid;
            cachedobjective[#"origin"] = objective_position(objectiveid);

            if(!isDefined(cachedobjective[#"__unsafe__"])) {
              cachedobjective[#"__unsafe__"] = array();
            }

            cachedobjective[#"__unsafe__"][#"trigger"] = undefined;

            if(isDefined(player.a_t_breadcrumbs)) {
              cachedobjective[#"breadcrumbs"] = player.a_t_breadcrumbs.size;

              for(index = 0; index < player.a_t_breadcrumbs.size; index++) {
                if(player.t_current_active_breadcrumb == player.a_t_breadcrumbs[index]) {
                  cachedobjective[#"currentbreadcrumb"] = index;
                  cachedobjective[#"triggermax"] = player.t_current_active_breadcrumb.maxs;
                  cachedobjective[#"triggermin"] = player.t_current_active_breadcrumb.mins;
                  cachedobjective[#"radius"] = player.t_current_active_breadcrumb.radius;

                  if(!isDefined(cachedobjective[#"__unsafe__"])) {
                    cachedobjective[#"__unsafe__"] = array();
                  }

                  cachedobjective[#"__unsafe__"][#"trigger"] = player.t_current_active_breadcrumb;
                  break;
                }
              }
            } else {
              cachedobjective[#"breadcrumbs"] = 0;
              cachedobjective[#"currentbreadcrumb"] = 0;
            }

            if(currentbreadcrumb <= cachedobjective[#"currentbreadcrumb"]) {
              currentbreadcrumb = cachedobjective[#"currentbreadcrumb"];
              furthestobjective = cachedobjective;
            }
          }
        }

        if(isDefined(furthestobjective)) {
          objectives[objectives.size] = furthestobjective;
        }

        continue;
      }

      if(isDefined(objective.m_a_targets) && objective.m_a_targets.size > 0) {
        foreach(objectiveid in objective.m_a_game_obj) {
          if(isDefined(objectiveid) && objective_state(objectiveid) == "active") {
            foreach(target in objective.m_a_targets) {
              if(isDefined(target) && (isstruct(target) || isentity(target)) && isDefined(target.origin)) {
                cachedobjective = array();
                cachedobjective[#"id"] = objectiveid;
                cachedobjective[#"origin"] = target.origin;

                if(!isDefined(cachedobjective[#"__unsafe__"])) {
                  cachedobjective[#"__unsafe__"] = array();
                }

                cachedobjective[#"__unsafe__"][#"trigger"] = undefined;
              }
            }
          }
        }
      }
    }

    blackboard::setstructblackboardattribute(commander, #"objectives", objectives);
  }
}

function_790fb743(planner, constants) {
  assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x7c>" + "<dev string:x8a>" + "<dev string:xca>");
  attribute = planner::getblackboardattribute(planner, constants[#"key"]);

  if(isDefined(attribute) && isarray(attribute)) {
    return (attribute.size > 0);
  }

  return false;
}

private function_a05a08bf(planner, constants) {
  assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x7c>" + "<dev string:xf0>" + "<dev string:xca>");
  return isDefined(planner::getblackboardattribute(planner, constants[#"key"]));
}

private strategyblackboardvalueistrue(planner, constants) {
  assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x7c>" + "<dev string:x12c>" + "<dev string:xca>");
  return planner::getblackboardattribute(planner, constants[#"key"]) == 1;
}

private function_a75b29d8(planner, constants) {
  assert(isstring(constants[#"focus"]) || ishash(constants[#"focus"]), "<dev string:x7c>" + "<dev string:x165>" + "<dev string:xca>");
  target = planner::getblackboardattribute(planner, #"current_target");
  assert(isDefined(target));

  if(!isDefined(target)) {
    return false;
  }

  strategy = target[#"strategy"];
  assert(isstruct(strategy));

  if(!isstruct(strategy)) {
    return false;
  }

  var_90b56683 = strategiccommandutility::function_f4921cb3(constants[#"focus"]);
  targetfocus = strategy.("doppelbotsfocus");

  foreach(focus in var_90b56683) {
    if(targetfocus == focus) {
      return true;
    }
  }

  return false;
}

private function_e0092cfc(planner, constant) {
  planner::setblackboardattribute(planner, #"current_target", undefined);
  targets = planner::getblackboardattribute(planner, #"targets");
  assert(isarray(targets));

  if(!isarray(targets)) {
    return spawnStruct();
  }

  priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
  assert(isarray(priorities));

  foreach(priority in priorities) {
    if(targets[priority].size > 0) {
      planner::setblackboardattribute(planner, #"current_target", targets[priority][0]);
      break;
    }
  }

  return spawnStruct();
}

private function_86270cca(planner, constant) {
  target = planner::getblackboardattribute(planner, #"current_target");
  validsquads = planner::getblackboardattribute(planner, #"valid_squads");

  if(getdvarint(#"hash_6cad7fcde98d23ee", 0)) {
    var_41ecbdf4 = array();

    if(!isDefined(target) || !isarray(validsquads) || validsquads.size <= 0) {
      planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
      return spawnStruct();
    }

    gameobject = target[#"__unsafe__"][#"object"];

    if(isDefined(gameobject)) {
      foreach(squad in validsquads) {
        pathablegameobjects = _calculateallpathablegameobjects(planner, squad, array(target));

        if(pathablegameobjects.size > 0) {
          var_3703551e = array();
          var_3703551e[#"squad"] = squad;
          var_3703551e[#"pathablegameobjects"] = pathablegameobjects;
          var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
        }
      }
    }

    component = target[#"__unsafe__"][#"component"];

    if(isDefined(component)) {
      foreach(squad in validsquads) {
        pathablecomponents = function_77cd4593(planner, squad, array(target));

        if(pathablecomponents.size > 0) {
          var_3703551e = array();
          var_3703551e[#"squad"] = squad;
          var_3703551e[#"pathablecomponents"] = pathablecomponents;
          var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
        }
      }
    }

    bundle = target[#"__unsafe__"][#"bundle"];

    if(isDefined(bundle)) {
      foreach(squad in validsquads) {
        pathablebundles = function_816f4052(planner, squad, array(target));

        if(pathablebundles.size > 0) {
          var_3703551e = array();
          var_3703551e[#"squad"] = squad;
          var_3703551e[#"pathablebundles"] = pathablebundles;
          var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
        }
      }
    }

    planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
  } else {
    var_41ecbdf4 = array();

    foreach(squad in validsquads) {
      var_3703551e = array();
      var_3703551e[#"squad"] = squad;
      var_41ecbdf4[var_41ecbdf4.size] = var_3703551e;
    }

    planner::setblackboardattribute(planner, #"hash_1a25f2c4feaf60cf", var_41ecbdf4);
  }

  return spawnStruct();
}

private function_14c766b3(planner, constant) {
  possiblesquads = planner::getblackboardattribute(planner, #"possible_squads");
  target = planner::getblackboardattribute(planner, #"current_target");
  var_3db29cab = 0;

  if(target[#"type"] == "gameobject") {
    object = target[#"__unsafe__"][#"object"];

    if(isDefined(object) && isarray(object.keyobject) && object.keyobject.size > 0) {
      var_3db29cab = 1;
    }
  }

  players = planner::getblackboardattribute(planner, #"players");
  hasplayers = players.size > 0;
  var_8769837e = !hasplayers || target[#"strategy"].("doppelbotsinteractions") == #"first come first served";
  var_f75536ec = !hasplayers || target[#"strategy"].("companionsinteractions") == #"first come first served";
  airvehicles = strategiccommandutility::function_698a5382(target[#"strategy"]);
  groundvehicles = strategiccommandutility::function_54032f13(target[#"strategy"]);
  var_eda803e5 = groundvehicles;
  validsquads = [];

  foreach(squad in possiblesquads) {
    foreach(member in squad) {
      bot = member[#"__unsafe__"][#"bot"];

      if(!isDefined(bot)) {
        break;
      }

      if(!var_8769837e) {
        continue;
      }

      if(var_3db29cab && !bot gameobjects::has_key_object(object)) {
        continue;
      }

      if(airvehicles && member[#"type"] == "air") {
        validsquads[validsquads.size] = squad;
        break;
      }

      if(groundvehicles && member[#"type"] == "ground") {
        validsquads[validsquads.size] = squad;
        break;
      }

      if(var_eda803e5 && member[#"type"] == "bot") {
        validsquads[validsquads.size] = squad;
        break;
      }
    }
  }

  planner::setblackboardattribute(planner, #"valid_squads", validsquads);
  return spawnStruct();
}

private function_52012b78(planner, constant) {
  target = planner::getblackboardattribute(planner, #"current_target");
  assert(isDefined(target));

  if(!isDefined(target)) {
    return spawnStruct();
  }

  strategy = target[#"strategy"];
  assert(isstruct(strategy));

  if(!isstruct(strategy)) {
    return spawnStruct();
  }

  distribution = strategy.("doppelbotsdistribution");
  priority = strategy.("doppelbotspriority");
  targets = planner::getblackboardattribute(planner, #"targets");
  assert(isarray(targets));

  if(!isarray(targets)) {
    return spawnStruct();
  }

  switch (distribution) {
    case #"evenly":
      arrayremoveindex(targets[priority], 0);
      targets[priority][targets.size] = target;
      break;
    case #"greedy":
      break;
    case #"uniquely":
      arrayremoveindex(targets[priority], 0);
      break;
    default:
      assert(0);
      break;
  }

  planner::setblackboardattribute(planner, #"targets", targets);
  return spawnStruct();
}

private function_34464159(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  target = planner::getblackboardattribute(planner, "target", squadindex);
  bundle = target[#"__unsafe__"][#"bundle"];

  if(!isDefined(bundle)) {
    return spawnStruct();
  }

  team = planner::getblackboardattribute(planner, #"team");

  if(!strategiccommandutility::function_a0f88aca(bundle, team)) {
    return spawnStruct();
  }

  switch (bundle.m_str_type) {
    case #"escortbiped":
      entity = bundle.var_27726d51;
      break;
  }

  if(!isDefined(entity)) {
    return spawnStruct();
  }

  var_eec336d1 = [];

  if(!isDefined(var_eec336d1[#"__unsafe__"])) {
    var_eec336d1[#"__unsafe__"] = array();
  }

  var_eec336d1[#"__unsafe__"][#"entity"] = entity;
  entities = array(var_eec336d1);
  pathableescorts = function_98bde2b6(doppelbots, entities);
  planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
  return spawnStruct();
}

private strategysquadcalculatepathableobjectivesparam(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  objectives = planner::getblackboardattribute(planner, #"objectives");
  pathableobjectives = _calculateallpathableobjectives(doppelbots, objectives);
  planner::setblackboardattribute(planner, "pathable_objectives", pathableobjectives, squadindex);
  return spawnStruct();
}

private strategysquadcalculatepathableplayersparam(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  players = planner::getblackboardattribute(planner, #"players");
  pathableescorts = _calculateallpathableclients(doppelbots, players);
  planner::setblackboardattribute(planner, "pathable_escorts", pathableescorts, squadindex);
  return spawnStruct();
}

private strategyincrementblackboardvalue(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
  planner::setblackboardattribute(planner, constants[#"name"], planner::getblackboardattribute(planner, constants[#"name"]) + 1);
}

private function_166d74b2(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex > 0, "<dev string:x1ed>");
  currentsquad = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  possiblesquads = planner::getblackboardattribute(planner, #"possible_squads");

  for(i = 0; i < possiblesquads.size; i++) {
    var_b44338e1 = 1;

    foreach(possiblemember in possiblesquads[i]) {
      var_5dc382b8 = 0;

      foreach(currentmember in currentsquad) {
        if(possiblemember[#"entnum"] == currentmember[#"entnum"]) {
          var_5dc382b8 = 1;
          break;
        }
      }

      if(!var_5dc382b8) {
        var_b44338e1 = 0;
        break;
      }
    }

    if(var_b44338e1) {
      arrayremoveindex(possiblesquads, i);
      break;
    }
  }

  planner::setblackboardattribute(planner, #"possible_squads", possiblesquads);
  idlebots = array();

  for(squadindex = 0; squadindex < possiblesquads.size; squadindex++) {
    squad = possiblesquads[squadindex];

    for(memberindex = 0; memberindex < squad.size; memberindex++) {
      idlebots[idlebots.size] = squad[memberindex];
    }
  }

  var_26ae1214 = planner::getblackboardattribute(planner, #"idle_doppelbots").size;
  assert(var_26ae1214 > idlebots.size, "<dev string:x22e>");

  planner::setblackboardattribute(planner, #"idle_doppelbots", idlebots);
}

private function_f162255b(planner, constants) {
  targets = planner::getblackboardattribute(planner, #"targets");
  priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
  assert(isarray(priorities));

  foreach(priority in priorities) {
    if(targets[priority].size > 0) {
      arrayremoveindex(targets[priority], 0);
      break;
    }
  }

  planner::setblackboardattribute(planner, #"targets", targets);
}

private strategysetblackboardvalue(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
  planner::setblackboardattribute(planner, constants[#"name"], constants[#"value"]);
}

private function_20de0d52(planner, constants) {
  assert(isarray(constants));
  assert(isstring(constants[#"name"]) || ishash(constants[#"name"]));
  planner::setblackboardattribute(planner, constants[#"name"], array());
}

private strategyshouldrushprogress(planner, constant) {
  if(planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1) {
    enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");

    if(!isDefined(enemycommander)) {
      return 0;
    }

    lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
    upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
    destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
    totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");

    if(!isDefined(totalassaults)) {
      totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
    }

    enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
    enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");

    if(!isDefined(enemytotalassaults)) {
      enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
    }

    return strategiccommandutility::calculateprogressrushing(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
  }

  return 0;
}

private strategyshouldthrottleprogress(planner, constant) {
  if(planner::getblackboardattribute(planner, #"allow_progress_throttling") === 1) {
    enemycommander = planner::getblackboardattribute(planner, #"throttling_enemy_commander");

    if(!isDefined(enemycommander)) {
      return 0;
    }

    lowerbound = planner::getblackboardattribute(planner, #"throttling_lower_bound");
    upperbound = planner::getblackboardattribute(planner, #"throttling_upper_bound");
    destroyedassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_destroyed");
    totalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects");

    if(!isDefined(totalassaults)) {
      totalassaults = planner::getblackboardattribute(planner, #"gameobjects_assault_total");
    }

    enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
    enemytotalassaults = planner::getblackboardattribute(planner, #"throttling_total_gameobjects_enemy");

    if(!isDefined(enemytotalassaults)) {
      enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
    }

    return strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults);
  }

  return 0;
}

private strategysquadorderparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  assert(isstring(constants[#"order"]) || ishash(constants[#"order"]), "<dev string:x7c>" + "<dev string:x262>" + "<dev string:x295>");
  planner::setblackboardattribute(planner, "order", constants[#"order"], squadindex);
  return spawnStruct();
}

private strategysquadassignforcegoalparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x2bd>");
  forcegoal = planner::getblackboardattribute(planner, #"force_goal");
  planner::setblackboardattribute(planner, "force_goal", forcegoal, squadindex);
  return spawnStruct();
}

private strategysquadassignpathableescortparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x306>");
  pathableescorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);

  if(!isarray(pathableescorts) || pathableescorts.size <= 0) {
    return spawnStruct();
  }

  shortestpath = pathableescorts[0][#"distance"];
  types = array("player", "entity");

  foreach(type in types) {
    if(isDefined(pathableescorts[0][type])) {
      escort = pathableescorts[0][type];

      for(index = 1; index < pathableescorts.size; index++) {
        pathableescort = pathableescorts[index];

        if(pathableescort[#"distance"] < shortestpath) {
          shortestpath = pathableescort[#"distance"];
          escort = pathableescort[type];
        }
      }

      planner::setblackboardattribute(planner, "escorts", array(escort), squadindex);
    }
  }

  return spawnStruct();
}

private strategysquadassignpathableobjectparam(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x34c>");
  pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
  prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
  gameobject = undefined;

  foreach(priorityname in prioritynames) {
    foreach(pathablegameobject in pathablegameobjects) {
      if(pathablegameobject[#"gameobject"][#"identifier"] === priorityname) {
        gameobject = pathablegameobject[#"gameobject"];
        break;
      }
    }
  }

  if(!isDefined(gameobject)) {
    shortestpath = pathablegameobjects[0][#"distance"];
    gameobject = pathablegameobjects[0][#"gameobject"];

    for(index = 1; index < pathablegameobjects.size; index++) {
      pathablegameobject = pathablegameobjects[index];

      if(pathablegameobject[#"distance"] < shortestpath) {
        shortestpath = pathablegameobject[#"distance"];
        gameobject = pathablegameobject[#"gameobject"];
      }
    }
  }

  planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
  return spawnStruct();
}

private strategysquadassignpathableobjectiveparam(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  pathableobjectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
  shortestpath = pathableobjectives[0][#"distance"];
  objective = pathableobjectives[0][#"objective"];

  for(index = 1; index < pathableobjectives.size; index++) {
    pathableobjective = pathableobjectives[index];

    if(pathableobjective[#"distance"] < shortestpath) {
      shortestpath = pathableobjective[#"distance"];
      objective = pathableobjective[#"objective"];
    }
  }

  planner::setblackboardattribute(planner, "objectives", array(objective), squadindex);
  return spawnStruct();
}

private strategysquadassignpathableunclaimedobjectparam(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  pathablegameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
  prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
  gameobject = undefined;

  foreach(priorityname in prioritynames) {
    foreach(pathablegameobject in pathablegameobjects) {
      if(!pathablegameobject[#"gameobject"][#"claimed"] && pathablegameobject[#"gameobject"][#"identifier"] === priorityname) {
        gameobject = pathablegameobject[#"gameobject"];
        break;
      }
    }
  }

  if(!isDefined(gameobject)) {
    shortestpath = undefined;

    foreach(pathablegameobject in pathablegameobjects) {
      if(!pathablegameobject[#"gameobject"][#"claimed"] && (!isDefined(shortestpath) || pathablegameobject[#"distance"] < shortestpath)) {
        shortestpath = pathablegameobject[#"distance"];
        gameobject = pathablegameobject[#"gameobject"];
      }
    }
  }

  if(isDefined(gameobject)) {
    planner::setblackboardattribute(planner, "gameobjects", array(gameobject), squadindex);
  }

  return spawnStruct();
}

private function_b77887e(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x395>");
  currenttarget = planner::getblackboardattribute(planner, #"current_target");
  assert(isDefined(currenttarget), "<dev string:x3da>");
  planner::setblackboardattribute(planner, "target", currenttarget, squadindex);
  return spawnStruct();
}

private strategysquadassignwanderparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  planner::setblackboardattribute(planner, "order", "order_wander", squadindex);
  return spawnStruct();
}

private strategysquadclaimobjectparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);
  assert(gameobjects.size > 0, "<dev string:x42a>");

  foreach(gameobject in gameobjects) {
    gameobject[#"claimed"] = 1;
  }

  return spawnStruct();
}

private strategysquadcopyblackboardvalue(planner, constants) {
  assert(isstring(constants[#"from"]) || ishash(constants[#"from"]), "<dev string:x7c>" + "<dev string:x47e>" + "<dev string:x4ba>");
  assert(isstring(constants[#"to"]) || ishash(constants[#"to"]), "<dev string:x7c>" + "<dev string:x47e>" + "<dev string:x4eb>");
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  value = planner::getblackboardattribute(planner, constants[#"from"], squadindex);
  planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

private function_86c0732e(planner, constants) {
  assert(isstring(constants[#"from"]) || ishash(constants[#"from"]), "<dev string:x7c>" + "<dev string:x51a>" + "<dev string:x4ba>");
  assert(isstring(constants[#"to"]) || ishash(constants[#"to"]), "<dev string:x7c>" + "<dev string:x51a>" + "<dev string:x4eb>");
  value = planner::getblackboardattribute(planner, constants[#"from"]);
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  planner::setblackboardattribute(planner, constants[#"to"], value, squadindex);
}

private function_d58b0781(planner, constants) {
  return function_faa6dd57(planner, constants, constants[#"key"]);
}

private function_45f841ea(planner, constants) {
  return function_faa6dd57(planner, constants, #"hash_1a25f2c4feaf60cf");
}

private function_faa6dd57(planner, constants, var_92812a91) {
  squads = planner::getblackboardattribute(planner, var_92812a91);
  assert(isarray(squads));
  assert(squads.size > 0, "<dev string:x558>" + var_92812a91 + "<dev string:x58d>");

  if(!isarray(squads)) {
    return spawnStruct();
  }

  var_75ff48f8 = squads[0];
  var_d91b9923 = array();

  foreach(botentry in var_75ff48f8[#"squad"]) {
    bot = botentry[#"__unsafe__"][#"bot"];

    if(!isDefined(bot)) {
      continue;
    }

    var_d91b9923[bot getentitynumber()] = 1;
  }

  squadindex = planner::createsubblackboard(planner);
  assert(squadindex <= 17, "<dev string:x591>");
  planner::setblackboardattribute(planner, #"current_squad", squadindex);
  planner::setblackboardattribute(planner, "doppelbots", var_75ff48f8[#"squad"], squadindex);
  team = planner::getblackboardattribute(planner, #"team");
  planner::setblackboardattribute(planner, "team", team, squadindex);
  return spawnStruct();
}

private strategysquadcreateofsizexparam(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x5df>" + "<dev string:x61a>");
  doppelbots = planner::getblackboardattribute(planner, #"idle_doppelbots");
  assert(doppelbots.size >= constants[#"amount"], "<dev string:x643>" + constants[#"amount"] + "<dev string:x66d>");
  enlisteddoppelbots = array();
  idledoppelbots = array();

  for(index = 0; index < constants[#"amount"]; index++) {
    enlisteddoppelbots[enlisteddoppelbots.size] = doppelbots[index];
  }

  for(index = constants[#"amount"]; index < doppelbots.size; index++) {
    idledoppelbots[idledoppelbots.size] = doppelbots[index];
  }

  planner::setblackboardattribute(planner, #"idle_doppelbots", idledoppelbots);
  squadindex = planner::createsubblackboard(planner);
  assert(squadindex <= 17, "<dev string:x591>");
  planner::setblackboardattribute(planner, #"current_squad", squadindex);
  planner::setblackboardattribute(planner, "doppelbots", enlisteddoppelbots, squadindex);
  team = planner::getblackboardattribute(planner, #"team");
  planner::setblackboardattribute(planner, "team", team, squadindex);
  return spawnStruct();
}

private strategysquadescortassignmainguardparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
  squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);

  foreach(escort in escorts) {
    escort[#"escortmainguard"] = arraycombine(escort[#"escortmainguard"], squadbots, 1, 0);
  }

  planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
  planner::setblackboardattribute(planner, "order", "order_escort_mainguard", squadindex);
  return spawnStruct();
}

private strategysquadescortassignrearguardparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
  squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);

  foreach(escort in escorts) {
    escort[#"escortrearguard"] = arraycombine(escort[#"escortrearguard"], squadbots, 1, 0);
  }

  planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
  planner::setblackboardattribute(planner, "order", "order_escort_rearguard", squadindex);
  return spawnStruct();
}

private strategysquadescortassignvanguardparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
  squadbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);

  foreach(escort in escorts) {
    escort[#"escortvanguard"] = arraycombine(escort[#"escortvanguard"], squadbots, 1, 0);
  }

  planner::setblackboardattribute(planner, "escorts", escorts, squadindex);
  planner::setblackboardattribute(planner, "order", "order_escort_vanguard", squadindex);
  return spawnStruct();
}

private strategysquadescortcalculatepathablepoiparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);
  assert(isarray(escorts) && escorts.size > 0, "<dev string:x682>");
  escortpoi = array();
  planner::setblackboardattribute(planner, "escort_poi", escortpoi, squadindex);
  return spawnStruct();
}

private strategysquadescorthasnomainguard(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);

  foreach(escort in escorts) {
    if(escort[#"escortmainguard"].size > 0) {
      return true;
    }
  }

  return true;
}

private strategysquadescorthasnorearguard(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);

  foreach(escort in escorts) {
    if(escort[#"escortrearguard"].size > 0) {
      return false;
    }
  }

  return true;
}

private strategysquadescorthasnovanguard(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);

  foreach(escort in escorts) {
    if(escort[#"escortvanguard"].size > 0) {
      return false;
    }
  }

  return true;
}

private strategysquadsortescortpoi(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escortpois = planner::getblackboardattribute(planner, "escort_poi", squadindex);

  if(escortpois.size > 0) {
    for(index = 0; index < escortpois.size; index++) {
      closestindex = index;

      for(innerindex = index + 1; innerindex < escortpois.size; innerindex++) {
        if(escortpois[innerindex][#"distance"] < escortpois[closestindex][#"distance"]) {
          closestindex = innerindex;
        }
      }

      temp = escortpois[index];
      escortpois[index] = escortpois[closestindex];
      escortpois[closestindex] = temp;
    }
  }

  planner::setblackboardattribute(planner, "escort_poi", escortpois, squadindex);
}

private bunker_exposure_scale(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  assert(isstring(constants[#"key"]) || ishash(constants[#"key"]), "<dev string:x7c>" + "<dev string:x6e4>" + "<dev string:xca>");
  attribute = planner::getblackboardattribute(planner, constants[#"key"], squadindex);

  if(isDefined(attribute) && isarray(attribute)) {
    return (attribute.size > 0);
  }

  return false;
}

private strategysquadhaspathableescort(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  escorts = planner::getblackboardattribute(planner, "pathable_escorts", squadindex);
  return escorts.size > 0;
}

private strategysquadhaspathableobject(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);
  return isDefined(gameobjects) && gameobjects.size > 0;
}

private strategysquadhaspathableobjective(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  objectives = planner::getblackboardattribute(planner, "pathable_objectives", squadindex);
  return objectives.size > 0;
}

private strategysquadhaspathableunclaimedobject(planner, constant) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x19b>");
  gameobjects = planner::getblackboardattribute(planner, "pathable_gameobjects", squadindex);

  for(index = 0; index < gameobjects.size; index++) {
    if(!gameobjects[index][#"gameobject"][#"claimed"]) {
      return true;
    }
  }

  return false;
}

private strategyhasatleastxassaultobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x729>" + "<dev string:x61a>");
  return planner::getblackboardattribute(planner, #"gameobjects_assault").size >= constants[#"amount"];
}

private strategyhasatleastxdefendobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x766>" + "<dev string:x61a>");
  return planner::getblackboardattribute(planner, #"gameobjects_defend").size >= constants[#"amount"];
}

private strategyhasatleastxobjectives(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x7a2>" + "<dev string:x61a>");
  return planner::getblackboardattribute(planner, #"objectives").size >= constants[#"amount"];
}

private strategyhasatleastxplayers(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x7db>" + "<dev string:x61a>");
  return planner::getblackboardattribute(planner, #"players").size >= constants[#"amount"];
}

private strategyhasatleastxpriorityassaultobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x811>" + "<dev string:x61a>");

  if(strategyhasatleastxassaultobjects(planner, constants)) {
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    prioritymap = [];

    foreach(priorityname in prioritynames) {
      prioritymap[priorityname] = 1;
    }

    priorityobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");

    foreach(gameobject in gameobjects) {
      if(isDefined(gameobject[#"identifier"]) && isDefined(prioritymap[gameobject[#"identifier"]])) {
        priorityobjects++;
      }
    }

    return (priorityobjects >= constants[#"amount"]);
  }

  return false;
}

private strategyhasatleastxprioritydefendobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x856>" + "<dev string:x61a>");

  if(strategyhasatleastxassaultobjects(planner, constants)) {
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    prioritymap = [];

    foreach(priorityname in prioritynames) {
      prioritymap[priorityname] = 1;
    }

    priorityobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");

    foreach(gameobject in gameobjects) {
      if(isDefined(gameobject[#"identifier"]) && isDefined(prioritymap[gameobject[#"identifier"]])) {
        priorityobjects++;
      }
    }

    return (priorityobjects >= constants[#"amount"]);
  }

  return false;
}

private strategyhasatleastxunassignedbots(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x89a>" + "<dev string:x61a>");
  return planner::getblackboardattribute(planner, #"idle_doppelbots").size >= constants[#"amount"];
}

strategyhasatleastxunclaimedassaultobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x8d7>" + "<dev string:x61a>");
  unclaimedobjects = 0;
  gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");

  foreach(gameobject in gameobjects) {
    if(!gameobject[#"claimed"]) {
      unclaimedobjects++;
    }
  }

  return unclaimedobjects >= constants[#"amount"];
}

strategyhasatleastxunclaimeddefendobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x91d>" + "<dev string:x61a>");
  unclaimedobjects = 0;
  gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");

  foreach(gameobject in gameobjects) {
    if(!gameobject[#"claimed"]) {
      unclaimedobjects++;
    }
  }

  return unclaimedobjects >= constants[#"amount"];
}

strategyhasatleastxunclaimedpriorityassaultobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x962>" + "<dev string:x61a>");

  if(strategyhasatleastxassaultobjects(planner, constants)) {
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    prioritymap = [];

    foreach(priorityname in prioritynames) {
      prioritymap[priorityname] = 1;
    }

    priorityobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");

    foreach(gameobject in gameobjects) {
      if(isDefined(gameobject[#"identifier"]) && isDefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"]) {
        priorityobjects++;
      }
    }

    return (priorityobjects >= constants[#"amount"]);
  }

  return false;
}

strategyhasatleastxunclaimedprioritydefendobjects(planner, constants) {
  assert(isint(constants[#"amount"]), "<dev string:x7c>" + "<dev string:x9b0>" + "<dev string:x61a>");

  if(strategyhasatleastxassaultobjects(planner, constants)) {
    prioritynames = planner::getblackboardattribute(planner, #"gameobjects_priority");
    prioritymap = [];

    foreach(priorityname in prioritynames) {
      prioritymap[priorityname] = 1;
    }

    priorityobjects = 0;
    gameobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");

    foreach(gameobject in gameobjects) {
      if(isDefined(gameobject[#"identifier"]) && isDefined(prioritymap[gameobject[#"identifier"]]) && !gameobject[#"claimed"]) {
        priorityobjects++;
      }
    }

    return (priorityobjects >= constants[#"amount"]);
  }

  return false;
}

strategyhasforcegoal(planner, constants) {
  return isDefined(planner::getblackboardattribute(planner, #"force_goal"));
}

function_f6a3c6d5(planner, constants) {
  targets = planner::getblackboardattribute(planner, #"targets");
  assert(isarray(targets));

  if(!isarray(targets)) {
    return false;
  }

  priorities = array(#"hash_179ccf9d7cfd1e31", #"hash_254689c549346d57", #"hash_4bd86f050b36e1f6", #"hash_19c0ac460bdb9928", #"hash_160b01bbcd78c723", #"hash_c045a5aa4ac7c1d", #"hash_47fd3da20e90cd01", #"hash_64fc5c612a94639c", #"(-4) unimportant");
  assert(isarray(priorities));

  foreach(priority in priorities) {
    if(targets[priority].size > 0) {
      return true;
    }
  }

  return false;
}

private strategypathinghascalculatedpaths(planner, constants) {
  return planner::getblackboardattribute(planner, #"pathing_calculated_paths").size > 0;
}

private strategypathinghascalculatedpathablepath(planner, constants) {
  bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
  calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
  return calculatedpaths.size >= bots.size && botindex >= bots.size;
}

private strategypathinghasnorequestpoints(planner, constants) {
  return planner::getblackboardattribute(planner, #"pathing_requested_points").size <= 0;
}

private strategypathinghasrequestpoints(planner, constants) {
  return planner::getblackboardattribute(planner, #"pathing_requested_points").size > 0;
}

private strategypathinghasunprocessedgameobjects(planner, constants) {
  requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
  gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
  return gameobjectindex < requestedgameobjects.size;
}

private strategypathinghasunprocessedobjectives(planner, constants) {
  requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
  objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
  return objectiveindex < requestedobjectives.size;
}

private strategypathinghasunprocessedrequestpoints(planner, constants) {
  requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
  bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
  botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
  return pointindex < requestedpoints.size && botindex < bots.size;
}

private strategypathinghasunreachablepath(planner, constants) {
  botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
  calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
  return botindex > calculatedpaths.size;
}

private strategypathingaddassaultgameobjectsparam(planner, constants) {
  assaultobjects = planner::getblackboardattribute(planner, #"gameobjects_assault");
  planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", assaultobjects);
  return spawnStruct();
}

private strategypathingadddefendgameobjectsparam(planner, constants) {
  defendobjects = planner::getblackboardattribute(planner, #"gameobjects_defend");
  planner::setblackboardattribute(planner, #"pathing_requested_gameobjects", defendobjects);
  return spawnStruct();
}

private strategypathingaddobjectivesparam(planner, constants) {
  objectives = planner::getblackboardattribute(planner, #"objectives");
  planner::setblackboardattribute(planner, #"pathing_requested_objectives", objectives);
  return spawnStruct();
}

private strategypathingaddsquadbotsparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x9fd>");
  doppelbots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  planner::setblackboardattribute(planner, #"pathing_requested_bots", doppelbots);
  return spawnStruct();
}

private strategypathingaddsquadescortsparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x9fd>");
  escorts = planner::getblackboardattribute(planner, "escorts", squadindex);

  for(index = 0; index < escorts.size; index++) {
    player = escorts[index][#"__unsafe__"][#"player"];

    if(!isDefined(escorts[index][#"__unsafe__"])) {
      escorts[index][#"__unsafe__"] = array();
    }

    escorts[index][#"__unsafe__"][#"bot"] = player;
  }

  planner::setblackboardattribute(planner, #"pathing_requested_bots", escorts);
  return spawnStruct();
}

private strategypathingaddtosquadcalculatedgameobjectsparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x9fd>");
  calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
  gameobjects = planner::getblackboardattribute(planner, "gameobjects", squadindex);

  if(!isDefined(gameobjects)) {
    gameobjects = array();
  }

  if(isDefined(calculatedgameobjects) && calculatedgameobjects.size > 0) {
    gameobjects = arraycombine(gameobjects, calculatedgameobjects, 0, 0);
  }

  planner::setblackboardattribute(planner, "pathable_gameobjects", gameobjects, squadindex);
  return spawnStruct();
}

private strategypathingaddtosquadcalculatedobjectivesparam(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:x9fd>");
  calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
  objectives = planner::getblackboardattribute(planner, "objectives", squadindex);

  if(!isDefined(objectives)) {
    objectives = array();
  }

  if(isDefined(calculatedobjectives) && calculatedobjectives.size > 0) {
    objectives = arraycombine(objectives, calculatedobjectives, 0, 0);
  }

  planner::setblackboardattribute(planner, "pathable_objectives", objectives, squadindex);
  return spawnStruct();
}

private strategypathingcalculatepathtorequestedpointsparam(planner, constants) {
  requestedpoints = planner::getblackboardattribute(planner, #"pathing_requested_points");
  bots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  pointindex = planner::getblackboardattribute(planner, #"pathing_current_point_index");
  botindex = planner::getblackboardattribute(planner, #"pathing_current_bot_index");
  assert(bots.size > 0);
  assert(requestedpoints.size > 0);
  assert(pointindex < requestedpoints.size);
  assert(botindex < bots.size);

  if(bots.size > 0 && requestedpoints.size > 0 && pointindex < requestedpoints.size && botindex < bots.size) {
    bot = bots[botindex][#"__unsafe__"][#"bot"];
    goalpoints = array();
    startindex = pointindex;
    index = 0;

    while(pointindex < requestedpoints.size && index < 16) {
      goalpoints[goalpoints.size] = requestedpoints[pointindex];
      index++;
      pointindex++;
    }

    path = strategiccommandutility::calculatepathtopoints(bot, goalpoints);

    if(isDefined(path)) {
      calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");
      calculatedpaths[calculatedpaths.size] = path;
      planner::setblackboardattribute(planner, #"pathing_calculated_paths", calculatedpaths, undefined, 1);
    }

    if(isDefined(path) || pointindex >= requestedpoints.size) {
      pointindex = 0;
      botindex++;
    }

    planner::setblackboardattribute(planner, #"pathing_current_point_index", pointindex);
    planner::setblackboardattribute(planner, #"pathing_current_bot_index", botindex);
  }

  return spawnStruct();
}

private strategypathingcalculategameobjectrequestpointsparam(planner, constants) {
  requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
  gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");

  if(requestedbots.size <= 0 || requestedgameobjects.size <= 0) {
    return spawnStruct();
  }

  requestedbot = requestedbots[0];
  bot = requestedbot[#"__unsafe__"][#"bot"];
  gameobject = requestedgameobjects[gameobjectindex][#"__unsafe__"][#"object"];
  requestedpoints = array();

  if(strategiccommandutility::isvalidbotorplayer(bot) && isDefined(gameobject)) {
    requestedpoints = strategiccommandutility::querypointsaroundgameobject(bot, gameobject);
  }

  planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
  return spawnStruct();
}

private strategypathingcalculateobjectiverequestpointsparam(planner, constants) {
  requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
  objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");

  if(requestedbots.size <= 0 || requestedobjectives.size <= 0) {
    return spawnStruct();
  }

  requestedbot = requestedbots[0];
  bot = requestedbot[#"__unsafe__"][#"bot"];
  trigger = requestedobjectives[objectiveindex][#"__unsafe__"][#"trigger"];
  requestedpoints = array();

  if(strategiccommandutility::isvalidbotorplayer(bot) && isDefined(trigger)) {
    requestedpoints = strategiccommandutility::querypointsinsidetrigger(bot, trigger);
  }

  planner::setblackboardattribute(planner, #"pathing_requested_points", requestedpoints);
  return spawnStruct();
}

private strategypathingcalculateobjectivepathabilityparam(planner, constants) {
  requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  requestedobjectives = planner::getblackboardattribute(planner, #"pathing_requested_objectives");
  objectiveindex = planner::getblackboardattribute(planner, #"pathing_current_objective_index");
  calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");

  if(requestedbots.size == calculatedpaths.size) {
    longestpath = 0;

    for(index = 0; index < calculatedpaths.size; index++) {
      if(calculatedpaths[index].pathdistance > longestpath) {
        longestpath = calculatedpaths[index].pathdistance;
      }
    }

    objectiveentry = array();
    objectiveentry[#"distance"] = longestpath;
    objectiveentry[#"objective"] = requestedobjectives[objectiveindex];
    calculatedobjectives = planner::getblackboardattribute(planner, #"pathing_calculated_objectives");
    calculatedobjectives[calculatedobjectives.size] = objectiveentry;
    planner::setblackboardattribute(planner, #"pathing_calculated_objectives", calculatedobjectives);
  }

  return spawnStruct();
}

private strategypathingcalculategameobjectpathabilityparam(planner, constants) {
  requestedbots = planner::getblackboardattribute(planner, #"pathing_requested_bots");
  requestedgameobjects = planner::getblackboardattribute(planner, #"pathing_requested_gameobjects");
  gameobjectindex = planner::getblackboardattribute(planner, #"pathing_current_gameobject_index");
  calculatedpaths = planner::getblackboardattribute(planner, #"pathing_calculated_paths");

  if(requestedbots.size == calculatedpaths.size) {
    longestpath = 0;

    for(index = 0; index < calculatedpaths.size; index++) {
      if(calculatedpaths[index].pathdistance > longestpath) {
        longestpath = calculatedpaths[index].pathdistance;
      }
    }

    gameobjectentry = array();
    gameobjectentry[#"distance"] = longestpath;
    gameobjectentry[#"gameobject"] = requestedgameobjects[gameobjectindex];
    calculatedgameobjects = planner::getblackboardattribute(planner, #"pathing_calculated_gameobjects");
    calculatedgameobjects[calculatedgameobjects.size] = gameobjectentry;
    planner::setblackboardattribute(planner, #"pathing_calculated_gameobjects", calculatedgameobjects);
  }

  return spawnStruct();
}

private function_61d2b8ef(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
  order = plannersquadutility::getblackboardattribute(squad, "order");

  if(isDefined(doppelbots) && doppelbots.size > 0 && isDefined(order)) {
    foreach(botentry in doppelbots) {
      bot = botentry[#"__unsafe__"][#"bot"];

      if(isDefined(bot) && order == "follow_chain" && bot isinvehicle()) {
        return false;
      }
    }

    return true;
  }

  return true;
}

private utilityscorebotpresence(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");

  if(isDefined(doppelbots) && doppelbots.size > 0) {
    foreach(botentry in doppelbots) {
      bot = botentry[#"__unsafe__"][#"bot"];

      if(!strategiccommandutility::isvalidbot(bot)) {
        return false;
      }
    }

    return true;
  }

  return true;
}

private function_de2b04c0(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");

  if(isDefined(doppelbots) && doppelbots.size > 0) {
    foreach(botentry in doppelbots) {
      bot = botentry[#"__unsafe__"][#"bot"];

      if(!isDefined(bot)) {
        return false;
      }

      if(bot isinvehicle() && botentry[#"type"] == "bot") {
        return false;
      } else if(!bot isinvehicle() && botentry[#"type"] != "bot") {
        return false;
      }

      if(!strategiccommandutility::function_4732f860(bot)) {
        return false;
      }
    }
  }

  return true;
}

private utilityscoreescortpathing(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
  escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
  escortpoi = plannersquadutility::getblackboardattribute(squad, "escort_poi");

  if(!isDefined(doppelbots) || doppelbots.size <= 0) {
    return true;
  }

  if(!isDefined(escorts) || escorts.size <= 0) {
    return true;
  }

  if(!blackboard::getstructblackboardattribute(commander, #"allow_escort")) {
    return false;
  }

  if(_calculateallpathableclients(doppelbots, escorts).size < escorts.size) {
    return false;
  }

  if(isDefined(escortpoi) && escortpoi.size > 0) {
    return false;
  } else {
    assaultgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
    defendgameobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
    objectives = blackboard::getstructblackboardattribute(commander, #"objectives");

    if(assaultgameobjects.size > 0 || defendgameobjects.size > 0 || objectives.size > 0) {
      return false;
    }
  }

  return true;
}

utilityscoreforcegoal(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
  squadforcegoal = plannersquadutility::getblackboardattribute(squad, "force_goal");
  forcegoal = blackboard::getstructblackboardattribute(commander, #"force_goal");

  if(forcegoal !== squadforcegoal) {
    return false;
  }

  return true;
}

private utilityscoregameobjectpathing(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");

  if(!isDefined(doppelbots) || doppelbots.size <= 0) {
    return true;
  }

  foreach(botentry in doppelbots) {
    bot = botentry[#"__unsafe__"][#"bot"];

    if(!strategiccommandutility::isvalidbot(bot)) {
      continue;
    }

    if(isalive(bot) && !bot isingoal(bot.origin) && !bot haspath()) {
      return false;
    }
  }

  return true;
}

private utilityscoregameobjectpriority(commander, squad, constants) {
  priorityidentifiers = constants[#"priority"];

  if(!isDefined(priorityidentifiers) || priorityidentifiers.size <= 0) {
    return true;
  }

  squadobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");

  if(isDefined(squadobjects)) {
    prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);

    if(prioritygameobjects.size > 0) {
      return true;
    }
  }

  assaultobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault");
  defendobjects = blackboard::getstructblackboardattribute(commander, #"gameobjects_defend");
  activeidentifiers = [];
  currentsquadassignedpriority = 0;

  if(isarray(assaultobjects)) {
    prioritygameobjects = _calculateprioritygameobjects(assaultobjects, priorityidentifiers);

    foreach(gameobjectentry in prioritygameobjects) {
      activeidentifiers[gameobjectentry[#"identifier"]] = 1;
    }
  }

  if(isarray(defendobjects)) {
    prioritygameobjects = _calculateprioritygameobjects(defendobjects, priorityidentifiers);

    foreach(gameobjectentry in prioritygameobjects) {
      activeidentifiers[gameobjectentry[#"identifier"]] = 1;
    }
  }

  if(activeidentifiers.size > 0) {
    foreach(currentsquad in commander.squads) {
      if(currentsquad == squad) {
        continue;
      }

      squadobjects = plannersquadutility::getblackboardattribute(currentsquad, "gameobjects");

      if(isDefined(squadobjects)) {
        prioritygameobjects = _calculateprioritygameobjects(squadobjects, priorityidentifiers);

        foreach(gameobjectentry in prioritygameobjects) {
          activeidentifiers[gameobjectentry[#"identifier"]] = 0;
        }
      }
    }
  }

  foreach(value in activeidentifiers) {
    if(value) {
      return false;
    }
  }

  return true;
}

private utilityscoregameobjectsvalidity(commander, squad, constants) {
  gameobjects = plannersquadutility::getblackboardattribute(squad, "gameobjects");

  if(!isDefined(gameobjects)) {
    return true;
  }

  foreach(gameobjectentry in gameobjects) {
    gameobject = gameobjectentry[#"__unsafe__"][#"object"];

    if(!isDefined(gameobject) || isDefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()) {
      return false;
    }
  }

  return true;
}

private function_2985faa1(commander, squad, constants) {
  target = plannersquadutility::getblackboardattribute(squad, "target");

  if(!isDefined(target)) {
    return false;
  }

  return true;
}

private utilityscoreprogressthrottling(commander, squad, constants) {
  if(blackboard::getstructblackboardattribute(commander, #"allow_progress_throttling") === 1) {
    enemycommander = blackboard::getstructblackboardattribute(commander, #"throttling_enemy_commander");

    if(!isDefined(enemycommander)) {
      return false;
    }

    lowerbound = blackboard::getstructblackboardattribute(commander, #"throttling_lower_bound");
    upperbound = blackboard::getstructblackboardattribute(commander, #"throttling_upper_bound");
    destroyedassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_destroyed");
    totalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects");

    if(!isDefined(totalassaults)) {
      totalassaults = blackboard::getstructblackboardattribute(commander, #"gameobjects_assault_total");
    }

    enemydestroyedassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_destroyed");
    enemytotalassaults = blackboard::getstructblackboardattribute(commander, #"throttling_total_gameobjects_enemy");

    if(!isDefined(enemytotalassaults)) {
      enemytotalassaults = blackboard::getstructblackboardattribute(enemycommander, #"gameobjects_assault_total");
    }

    order = plannersquadutility::getblackboardattribute(squad, "order");

    if(strategiccommandutility::calculateprogressthrottling(lowerbound, upperbound, destroyedassaults, totalassaults, enemydestroyedassaults, enemytotalassaults)) {
      if(order === "order_attack") {
        return false;
      }
    } else if(order === "order_attack_surround") {
      return false;
    }
  }

  return true;
}

private function_a65b2be5(commander, squad, constants) {
  var_fcee18d7 = plannersquadutility::getblackboardattribute(squad, "target");

  if(!isDefined(var_fcee18d7)) {
    return true;
  }

  if(var_fcee18d7[#"type"] === "gameobject") {
    gameobject = var_fcee18d7[#"__unsafe__"][#"object"];

    if(!isDefined(gameobject) || isDefined(gameobject.trigger) && !gameobject.trigger istriggerenabled()) {
      return false;
    }
  } else if(var_fcee18d7[#"type"] === "destroy" || var_fcee18d7[#"type"] === "defend") {
    return false;
  } else if(var_fcee18d7[#"type"] === "capturearea") {
    return false;
  } else if(var_fcee18d7[#"type"] === "destroy" || var_fcee18d7[#"type"] === "goto") {
    missioncomponent = var_fcee18d7[#"__unsafe__"][#"mission_component"];
    commanderteam = blackboard::getstructblackboardattribute(commander, #"team");

    if(!strategiccommandutility::function_f867cce0(missioncomponent, commanderteam)) {
      return false;
    }
  }

  return true;
}

private function_f389ef61(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
  team = blackboard::getstructblackboardattribute(commander, #"team");

  if(!isDefined(doppelbots) || !isDefined(team)) {
    return true;
  }

  for(botindex = 0; botindex < doppelbots.size; botindex++) {
    bot = doppelbots[botindex][#"__unsafe__"][#"bot"];

    if(isDefined(bot) && bot.team != team) {
      return false;
    }
  }

  return true;
}

private utilityscoreviableescort(commander, squad, constants) {
  doppelbots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
  escorts = plannersquadutility::getblackboardattribute(squad, "escorts");
  players = blackboard::getstructblackboardattribute(commander, #"players");

  if(isDefined(escorts) && escorts.size > 0) {
    return true;
  }

  if(!isDefined(doppelbots) || doppelbots.size <= 0) {
    return true;
  }

  if(!isDefined(players) || players.size <= 0) {
    return true;
  }

  if(_calculateallpathableclients(doppelbots, players).size > 0) {
    return false;
  }

  return true;
}