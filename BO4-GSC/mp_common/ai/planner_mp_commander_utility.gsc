/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_commander_utility.gsc
*********************************************************/

#include scripts\core_common\ai\planner_commander;
#include scripts\core_common\ai\planner_squad;
#include scripts\core_common\ai\region_utility;
#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\ai\systems\planner_blackboard;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace planner_mp_commander_utility;

autoexec __init__system__() {
  system::register(#"planner_mp_commander_utility", &namespace_e2d53d54::__init__, undefined, undefined);
}

#namespace namespace_e2d53d54;

private __init__() {
  plannercommanderutility::registerdaemonapi("daemonControlZones", &function_c5bf12a5);
  plannercommanderutility::registerdaemonapi("daemonDomFlags", &function_88ab5a6e);
  plannercommanderutility::registerdaemonapi("daemonKothZone", &function_337c2c5d);
  plannercommanderutility::registerdaemonapi("daemonSdBomb", &function_4364713f);
  plannercommanderutility::registerdaemonapi("daemonSdBombZones", &function_c111c0aa);
  plannercommanderutility::registerdaemonapi("daemonSdDefuseObj", &function_7e03c94a);
  plannercommanderutility::registerutilityapi("commanderScoreAge", &function_cb29a211);
  plannercommanderutility::registerutilityapi("commanderScoreAlive", &function_e319475e);
  plannercommanderutility::registerutilityapi("commanderScoreControlZones", &function_f478ac94);
  plannercommanderutility::registerutilityapi("commanderScoreDomFlags", &function_78126acd);
  plannercommanderutility::registerutilityapi("commanderScoreStopWanderingDom", &function_8ee25278);
  plannercommanderutility::registerutilityapi("commanderScoreKothZone", &function_eb0a4e86);
  plannerutility::registerplannerapi(#"hash_6130077bb861d4fa", &raw\italian\sound\vox\scripted\zmb_tomb\vox_plr_1_exert_death_high_d_0.SN40.xenon.snd);
  plannerutility::registerplannerapi(#"hash_23ede7441ff7e15f", &function_34c0ebaf);
  plannerutility::registerplannerapi(#"hash_9d5448e604895e", &function_68a32d83);
  plannerutility::registerplannerapi(#"hash_58f852e4b26d4080", &function_380f4233);
  plannerutility::registerplannerapi(#"hash_6c55a3eed50ed047", &function_4792217e);
  plannerutility::registerplannerapi(#"hash_654106abca773945", &function_97e7d0d8);
  plannerutility::registerplannerapi(#"hash_783f83ce7a2dc41b", &function_493ead90);
  plannerutility::registerplannerapi(#"hash_19dd182b96412bae", &function_cd5b7cc9);
  plannerutility::registerplannerapi(#"hash_72014ae7e091d06f", &function_efa74ce4);
  plannerutility::registerplanneraction(#"hash_5c39c15c20a4b033", &function_b35625c2, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_5ad6d3a6bb956fb1", &function_a207b2e4, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_6a957e932b7f93aa", &function_9d8a9994, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_746e217e5d63efc2", &function_913bffb1, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_303c3d6d6bfcc25b", &function_edf25221, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_4a587832fd66b314", &function_90af2101, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_4d82b95b9c45bb53", &function_bca7d900, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_494fab5e2093d5b", &function_1cce4bb6, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_506b5e12327f16f4", &function_f192ef84, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_67ba42774c6db6a6", &function_7a576970, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_6b51afb697e53d12", &function_53600d78, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_4c584e62f0069dfa", &function_7a9a7a24, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_3eb5ac2692fce4e7", &function_b032f16b, undefined, undefined, undefined);
  plannerutility::registerplanneraction(#"hash_60a8773a51426c27", &function_9c7e3773, undefined, undefined, undefined);
  plannerutility::registerplannerapi(#"hash_3df2466d38b695da", &function_39cd5957);
  plannerutility::registerplannerapi(#"hash_2d8246b9d8badd2e", &function_97659d05);
  plannerutility::registerplannerapi(#"hash_10cfd447c35656ef", &function_9e016913);
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

private function_c0e398c4(bots, var_26b45a5e, bbkey, claimed = undefined) {
  assert(isarray(bots));
  assert(isarray(var_26b45a5e));
  var_f8d389a2 = [];

  if(bots.size <= 0 || var_26b45a5e.size <= 0) {
    return var_f8d389a2;
  }

  for(i = 0; i < var_26b45a5e.size; i++) {
    var_deb9ffcf = var_26b45a5e[i][#"__unsafe__"][bbkey];

    if(!isDefined(var_deb9ffcf)) {
      continue;
    }

    if(isDefined(claimed) && var_26b45a5e[i][#"claimed"] != claimed) {
      continue;
    }

    navpos = getclosestpointonnavmesh(var_deb9ffcf.origin, 200);

    if(isDefined(navpos)) {
      pathable = 1;
      distance = 0;

      for(botindex = 0; botindex < bots.size; botindex++) {
        bot = bots[botindex][#"__unsafe__"][#"bot"];

        if(!strategiccommandutility::isvalidbot(bot)) {
          continue;
        }

        position = getclosestpointonnavmesh(bot.origin, 120, 1.2 * bot getpathfindingradius());

        if(!isDefined(position)) {
          pathable = 0;
          continue;
        }

        queryresult = positionquery_source_navigation(navpos, 0, 120, 60, 16, bot, 16);

        if(queryresult.data.size > 0) {
          path = _calculatepositionquerypath(queryresult, position, bot);

          if(!isDefined(path)) {
            pathable = 0;
            break;
          }

          if(path.pathdistance > distance) {
            distance = path.pathdistance;
          }
        }
      }

      if(pathable) {
        path = [];
        path[bbkey] = var_26b45a5e[i];
        path[#"distance"] = distance;

        if(!isDefined(var_f8d389a2)) {
          var_f8d389a2 = [];
        } else if(!isarray(var_f8d389a2)) {
          var_f8d389a2 = array(var_f8d389a2);
        }

        var_f8d389a2[var_f8d389a2.size] = path;
      }
    }
  }

  return var_f8d389a2;
}

private function_3ea6bf0b(gameobject, defending_team) {
  teamkeys = getarraykeys(gameobject.numtouching);

  for(i = 0; i < gameobject.numtouching.size; i++) {
    team = teamkeys[i];

    if(team == defending_team) {
      continue;
    }

    if(gameobject.numtouching[team] > 0) {
      return true;
    }
  }

  return false;
}

private function_c5bf12a5(commander) {
  if(!isDefined(level.zones)) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  controlzones = [];
  var_c4c8bf3f = arraycopy(level.zones);

  foreach(zone in var_c4c8bf3f) {
    if(!isDefined(zone) || !isDefined(zone.trigger) || !zone.trigger istriggerenabled()) {
      continue;
    }

    var_72812cde = [];
    var_72812cde[#"origin"] = zone.origin;

    if(!isDefined(var_72812cde[#"__unsafe__"])) {
      var_72812cde[#"__unsafe__"] = array();
    }

    var_72812cde[#"__unsafe__"][#"controlzone"] = zone;

    if(!isDefined(controlzones)) {
      controlzones = [];
    } else if(!isarray(controlzones)) {
      controlzones = array(controlzones);
    }

    controlzones[controlzones.size] = var_72812cde;

    if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
      aiprofile_endentry();
      pixendevent();
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(commander);
      commander.var_22765a25 = getrealtime();
      pixbeginevent("daemonControlZones");
      aiprofile_beginentry("daemonControlZones");
    }
  }

  blackboard::setstructblackboardattribute(commander, "mp_controlZones", controlzones);
}

private function_88ab5a6e(commander) {
  if(!isDefined(level.domflags)) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  domflags = [];
  var_42c3a790 = arraycopy(level.domflags);

  foreach(domflag in var_42c3a790) {
    if(!isDefined(domflag) || !isDefined(domflag.trigger)) {
      continue;
    }

    if(!domflag.trigger istriggerenabled()) {
      continue;
    }

    var_2435544a = [];
    var_2435544a[#"origin"] = domflag.origin;
    var_2435544a[#"radius"] = domflag.levelflag.radius;
    var_2435544a[#"claimed"] = commanderteam == domflag gameobjects::get_owner_team();

    if(!isDefined(var_2435544a[#"__unsafe__"])) {
      var_2435544a[#"__unsafe__"] = array();
    }

    var_2435544a[#"__unsafe__"][#"domflag"] = domflag;

    if(!isDefined(domflags)) {
      domflags = [];
    } else if(!isarray(domflags)) {
      domflags = array(domflags);
    }

    domflags[domflags.size] = var_2435544a;

    if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
      aiprofile_endentry();
      pixendevent();
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(commander);
      commander.var_22765a25 = getrealtime();
      pixbeginevent("daemonDomFlags");
      aiprofile_beginentry("daemonDomFlags");
    }
  }

  blackboard::setstructblackboardattribute(commander, "mp_domFlags", domflags);
}

private function_337c2c5d(commander) {
  if(!isDefined(level.zone)) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  zone = [];
  cachedzone = [];
  cachedzone[#"origin"] = level.zone.origin;

  if(!isDefined(cachedzone[#"__unsafe__"])) {
    cachedzone[#"__unsafe__"] = array();
  }

  cachedzone[#"__unsafe__"][#"kothzone"] = level.zone;

  if(!isDefined(zone)) {
    zone = [];
  } else if(!isarray(zone)) {
    zone = array(zone);
  }

  zone[zone.size] = cachedzone;
  blackboard::setstructblackboardattribute(commander, "mp_kothZone", zone);
}

private function_4364713f(commander) {
  if(!isDefined(level.sdbomb)) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  bomb = [];
  var_b0fd50a8 = [];
  var_b0fd50a8[#"origin"] = level.sdbomb.origin;

  if(!isDefined(var_b0fd50a8[#"__unsafe__"])) {
    var_b0fd50a8[#"__unsafe__"] = array();
  }

  var_b0fd50a8[#"__unsafe__"][#"sdbomb"] = level.sdbomb;

  if(!isDefined(bomb)) {
    bomb = [];
  } else if(!isarray(bomb)) {
    bomb = array(bomb);
  }

  bomb[bomb.size] = var_b0fd50a8;
  blackboard::setstructblackboardattribute(commander, "mp_sdBomb", bomb);
}

private function_c111c0aa(commander) {
  if(!isDefined(level.bombzones) || !isarray(level.bombzones) || level.bombzones.size <= 0) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  bombzones = [];
  var_99cb62dc = arraycopy(level.bombzones);

  foreach(bombzone in var_99cb62dc) {
    if(!isDefined(bombzone) || !isDefined(bombzone.trigger)) {
      continue;
    }

    if(!bombzone.trigger istriggerenabled()) {
      continue;
    }

    var_fa640b48 = [];
    var_fa640b48[#"origin"] = bombzone.origin;
    var_fa640b48[#"planted"] = bombzone gameobjects::get_flags(1);

    if(!isDefined(var_fa640b48[#"__unsafe__"])) {
      var_fa640b48[#"__unsafe__"] = array();
    }

    var_fa640b48[#"__unsafe__"][#"sdbombzone"] = bombzone;

    if(!isDefined(bombzones)) {
      bombzones = [];
    } else if(!isarray(bombzones)) {
      bombzones = array(bombzones);
    }

    bombzones[bombzones.size] = var_fa640b48;

    if(getrealtime() - commander.var_22765a25 > commander.var_b9dd2f) {
      aiprofile_endentry();
      pixendevent();
      [
        [level.strategic_command_throttle]
      ] - > waitinqueue(commander);
      commander.var_22765a25 = getrealtime();
      pixbeginevent("daemonSdBombZones");
      aiprofile_beginentry("daemonSdBombZones");
    }
  }

  blackboard::setstructblackboardattribute(commander, "mp_sdBombZones", bombzones);
}

private function_7e03c94a(commander) {
  if(!isDefined(level.defuseobject)) {
    return;
  }

  commanderteam = blackboard::getstructblackboardattribute(commander, #"team");
  defuseobj = [];
  var_30b29fd3 = [];
  var_30b29fd3[#"origin"] = level.defuseobject.origin;

  if(!isDefined(var_30b29fd3[#"__unsafe__"])) {
    var_30b29fd3[#"__unsafe__"] = array();
  }

  var_30b29fd3[#"__unsafe__"][#"sddefuseobj"] = level.defuseobject;

  if(!isDefined(defuseobj)) {
    defuseobj = [];
  } else if(!isarray(defuseobj)) {
    defuseobj = array(defuseobj);
  }

  defuseobj[defuseobj.size] = var_30b29fd3;
  blackboard::setstructblackboardattribute(commander, "mp_sdDefuseObj", defuseobj);
}

private function_cb29a211(commander, squad, constants) {
  assert(isDefined(constants[#"maxage"]), "<dev string:x38>" + "<dev string:x46>" + "<dev string:x73>");

  if(gettime() > squad.createtime + constants[#"maxage"]) {
    return false;
  }

  return true;
}

private function_e319475e(commander, squad, constants) {
  bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");

  if(!isDefined(bots)) {
    return false;
  }

  for(botindex = 0; botindex < bots.size; botindex++) {
    bot = bots[botindex][#"__unsafe__"][#"bot"];

    if(!isDefined(bot)) {
      return false;
    }

    if(!isalive(bot)) {
      return false;
    }
  }

  return true;
}

private function_f478ac94(commander, squad, constants) {
  controlzones = plannersquadutility::getblackboardattribute(squad, "mp_controlZones");

  if(isDefined(controlzones) && controlzones.size > 0) {
    for(i = 0; i < controlzones.size; i++) {
      zone = controlzones[i][#"__unsafe__"][#"controlzone"];

      if(!zone.gameobject.trigger istriggerenabled()) {
        return false;
      }
    }

    return true;
  }

  return false;
}

private function_78126acd(commander, squad, constants) {
  domflags = plannersquadutility::getblackboardattribute(squad, "mp_domFlags");
  squadteam = plannersquadutility::getblackboardattribute(squad, "team");

  if(isDefined(domflags) && domflags.size > 0) {
    foreach(domflag in domflags) {
      object = domflag[#"__unsafe__"][#"domflag"];

      if(hash(squadteam) !== object gameobjects::get_owner_team()) {
        return true;
      }
    }

    return false;
  }

  return true;
}

private function_8ee25278(commander, squad, constants) {
  order = plannersquadutility::getblackboardattribute(squad, "order");

  if(order === "order_wander") {
    bots = plannersquadutility::getblackboardattribute(squad, "doppelbots");
    domflags = planner::getblackboardattribute(commander.planner, "mp_domFlags");

    if(isDefined(domflags)) {
      pathabledomflags = function_c0e398c4(bots, domflags, "domFlag");

      if(pathabledomflags.size > 0) {
        return false;
      }
    }
  }

  return true;
}

private function_eb0a4e86(commander, squad, constants) {
  kothzone = plannersquadutility::getblackboardattribute(squad, "mp_kothZone");

  if(isDefined(kothzone) && kothzone.size > 0) {
    zone = kothzone[0][#"__unsafe__"][#"kothzone"];

    if(zone.gameobject.trigger istriggerenabled()) {
      return true;
    }

    return false;
  }

  return false;
}

private raw\italian\sound\vox\scripted\zmb_tomb\vox_plr_1_exert_death_high_d_0.SN40.xenon.snd(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  commanderteam = planner::getblackboardattribute(planner, #"team");
  assert(squadindex >= 0, "<dev string:xa4>");
  controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);

  foreach(controlzone in controlzones) {
    zone = controlzone[#"controlzone"][#"__unsafe__"][#"controlzone"];

    if(!isDefined(zone) || !isDefined(zone.gameobject)) {
      continue;
    }

    if(function_3ea6bf0b(zone.gameobject, commanderteam)) {
      return true;
    }
  }

  return false;
}

private function_34c0ebaf(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  controlzones = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);
  return controlzones.size > 0;
}

private function_68a32d83(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  domflags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);
  return domflags.size > 0;
}

private function_380f4233(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  kothzone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);
  return kothzone.size > 0;
}

private function_4792217e(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  bomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);
  return isDefined(bomb) && bomb.size > 0;
}

private function_97e7d0d8(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  zones = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);
  return isDefined(zones) && zones.size > 0;
}

private function_493ead90(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);

  for(i = 0; i < bots.size; i++) {
    bot = bots[0][#"__unsafe__"][#"bot"];

    if(isDefined(bot.isbombcarrier) && bot.isbombcarrier || isDefined(level.multibomb) && level.multibomb) {
      return true;
    }
  }

  return false;
}

private function_cd5b7cc9(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  var_a13843cf = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);
  return isDefined(var_a13843cf) && var_a13843cf.size > 0;
}

private function_efa74ce4(planner, constants) {
  return region_utility::function_9fe18733() > 0;
}

private function_b35625c2(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  controlzones = planner::getblackboardattribute(planner, "mp_controlZones");
  var_72d5b8ac = function_c0e398c4(bots, controlzones, "controlZone");
  planner::setblackboardattribute(planner, "mp_pathable_controlZones", var_72d5b8ac, squadindex);
  return spawnStruct();
}

private function_a207b2e4(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  commanderteam = planner::getblackboardattribute(planner, #"team");
  assert(squadindex >= 0, "<dev string:xf6>");
  var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);

  if(!isarray(var_72d5b8ac) || var_72d5b8ac.size <= 0) {
    return spawnStruct();
  }

  var_82711a20 = [];

  foreach(var_2b511b1a in var_72d5b8ac) {
    zone = var_2b511b1a[#"controlzone"][#"__unsafe__"][#"controlzone"];

    if(!isDefined(zone) || !isDefined(zone.gameobject)) {
      continue;
    }

    if(function_3ea6bf0b(zone.gameobject, commanderteam)) {
      if(!isDefined(var_82711a20)) {
        var_82711a20 = [];
      } else if(!isarray(var_82711a20)) {
        var_82711a20 = array(var_82711a20);
      }

      var_82711a20[var_82711a20.size] = var_2b511b1a;
    }
  }

  if(var_82711a20.size < 1) {
    if(!isDefined(var_82711a20)) {
      var_82711a20 = [];
    } else if(!isarray(var_82711a20)) {
      var_82711a20 = array(var_82711a20);
    }

    var_82711a20[var_82711a20.size] = var_72d5b8ac[0];
  }

  shortestpath = var_82711a20[0][#"distance"];
  controlzone = var_82711a20[0][#"controlzone"];

  for(i = 1; i < var_82711a20.size; i++) {
    if(var_82711a20[i][#"distance"] < shortestpath) {
      shortestpath = var_82711a20[i][#"distance"];
      controlzone = var_82711a20[i][#"controlzone"];
    }
  }

  planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
  return spawnStruct();
}

private function_9d8a9994(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones", squadindex);

  if(!isarray(var_72d5b8ac) || var_72d5b8ac.size <= 0) {
    return spawnStruct();
  }

  controlzones = [];

  for(i = 0; i < var_72d5b8ac.size; i++) {
    zone = var_72d5b8ac[i][#"controlzone"];

    if(!isDefined(controlzones)) {
      controlzones = [];
    } else if(!isarray(controlzones)) {
      controlzones = array(controlzones);
    }

    controlzones[controlzones.size] = zone;
  }

  controlzone = undefined;
  bot = undefined;
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);

  if(isDefined(bots) && bots.size > 0) {
    bot = bots[0][#"__unsafe__"][#"bot"];
  }

  if(isDefined(bot) && isalive(bot)) {
    if(!isDefined(controlzone) && getdvarint(#"bot_difficulty", 1) >= 1) {
      if(function_97659d05(planner, constants)) {
        foreach(var_e8450bcf in controlzones) {
          var_f7b61e5e = var_e8450bcf[#"__unsafe__"][#"controlzone"];

          if(var_f7b61e5e.gameobject.trigger istriggerenabled() && bot istouching(var_f7b61e5e.gameobject.trigger) && var_f7b61e5e.gameobject.curprogress > 0) {
            controlzone = var_e8450bcf;
            break;
          }
        }
      }
    }

    if(!isDefined(controlzone) && getdvarint(#"bot_difficulty", 1) >= 2) {
      if(function_39cd5957(planner, constants)) {
        foreach(var_e8450bcf in controlzones) {
          var_f7b61e5e = var_e8450bcf[#"__unsafe__"][#"controlzone"];

          if(var_f7b61e5e.gameobject.trigger istriggerenabled() && bot istouching(var_f7b61e5e.gameobject.trigger)) {
            controlzone = var_e8450bcf;
            break;
          }
        }
      }
    }
  }

  if(!isDefined(controlzone)) {
    controlzone = array::random(controlzones);
  }

  planner::setblackboardattribute(planner, "mp_controlZones", array(controlzone), squadindex);
  return spawnStruct();
}

private function_913bffb1(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  domflags = planner::getblackboardattribute(planner, "mp_domFlags");
  pathabledomflags = function_c0e398c4(bots, domflags, "domFlag");
  planner::setblackboardattribute(planner, "mp_pathable_domFlags", pathabledomflags, squadindex);
  return spawnStruct();
}

private function_edf25221(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  pathabledomflags = planner::getblackboardattribute(planner, "mp_pathable_domFlags", squadindex);

  if(!isarray(pathabledomflags) || pathabledomflags.size <= 0) {
    return spawnStruct();
  }

  domflags = [];
  shortestpath = pathabledomflags[0][#"distance"];
  longestpath = pathabledomflags[0][#"distance"];
  var_fa2c1b88 = 0;
  var_67f36fed = 0;

  for(i = 1; i < pathabledomflags.size; i++) {
    pathabledomflag = pathabledomflags[i];

    if(pathabledomflag[#"distance"] < shortestpath) {
      shortestpath = pathabledomflags[i][#"distance"];
      var_fa2c1b88 = i;
      continue;
    }

    if(pathabledomflag[#"distance"] > longestpath) {
      longestpath = pathabledomflags[i][#"distance"];
      var_67f36fed = i;
    }
  }

  if(!isDefined(domflags)) {
    domflags = [];
  } else if(!isarray(domflags)) {
    domflags = array(domflags);
  }

  domflags[domflags.size] = pathabledomflags[var_fa2c1b88][#"domflag"];

  for(i = 0; i < pathabledomflags.size; i++) {
    if(i == var_fa2c1b88 || i == var_67f36fed) {
      continue;
    }

    if(!isDefined(domflags)) {
      domflags = [];
    } else if(!isarray(domflags)) {
      domflags = array(domflags);
    }

    domflags[domflags.size] = pathabledomflags[i][#"domflag"];
  }

  if(!isDefined(domflags)) {
    domflags = [];
  } else if(!isarray(domflags)) {
    domflags = array(domflags);
  }

  domflags[domflags.size] = pathabledomflags[var_67f36fed][#"domflag"];
  planner::setblackboardattribute(planner, "mp_domFlags", domflags, squadindex);
  return spawnStruct();
}

private function_90af2101(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xa4>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
  pathablekothzone = function_c0e398c4(bots, kothzone, "kothZone");
  planner::setblackboardattribute(planner, "mp_pathable_kothZone", pathablekothzone, squadindex);
  return spawnStruct();
}

private function_bca7d900(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  pathablekothzone = planner::getblackboardattribute(planner, "mp_pathable_kothZone", squadindex);

  if(!isarray(pathablekothzone) || pathablekothzone.size <= 0) {
    return spawnStruct();
  }

  planner::setblackboardattribute(planner, "mp_kothZone", array(pathablekothzone[0][#"kothzone"]), squadindex);
  return spawnStruct();
}

private function_1cce4bb6(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");

  if(!isDefined(sdbomb)) {
    return spawnStruct();
  }

  bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];

  if(isDefined(bomb) && isDefined(bomb.carrier)) {
    var_494de2dd = [];
  } else {
    var_494de2dd = function_c0e398c4(bots, sdbomb, "sdBomb");
  }

  planner::setblackboardattribute(planner, "mp_pathable_sdBomb", var_494de2dd, squadindex);
  return spawnStruct();
}

private function_f192ef84(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  pathablesdbomb = planner::getblackboardattribute(planner, "mp_pathable_sdBomb", squadindex);

  if(!isarray(pathablesdbomb) || pathablesdbomb.size <= 0) {
    return spawnStruct();
  }

  planner::setblackboardattribute(planner, "mp_sdBomb", array(pathablesdbomb[0][#"sdbomb"]), squadindex);
  return spawnStruct();
}

private function_7a576970(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");

  if(isDefined(bots) && isDefined(bombzones)) {
    var_154e2210 = function_c0e398c4(bots, bombzones, "sdBombZone");
    planner::setblackboardattribute(planner, "mp_pathable_sdBombZones", var_154e2210, squadindex);
  }

  return spawnStruct();
}

private function_53600d78(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  var_154e2210 = planner::getblackboardattribute(planner, "mp_pathable_sdBombZones", squadindex);

  if(!isarray(var_154e2210) || var_154e2210.size <= 0) {
    return spawnStruct();
  }

  zoneindex = undefined;

  if(isDefined(bots)) {
    bot = bots[0][#"__unsafe__"][#"bot"];

    if(isDefined(bot) && isalive(bot)) {
      if(!isDefined(bot.bot.var_16fb46e7)) {
        bot.bot.var_16fb46e7 = randomint(var_154e2210.size);
      }

      zoneindex = bot.bot.var_16fb46e7;
    }
  }

  if(!isDefined(zoneindex) || zoneindex >= var_154e2210.size) {
    zoneindex = randomint(var_154e2210.size);
  }

  planner::setblackboardattribute(planner, "mp_sdBombZones", array(var_154e2210[zoneindex][#"sdbombzone"]), squadindex);
  return spawnStruct();
}

private function_7a9a7a24(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");

  if(!isDefined(defuseobj)) {
    return spawnStruct();
  }

  var_a9e623b5 = function_c0e398c4(bots, defuseobj, "sdDefuseObj");
  planner::setblackboardattribute(planner, "mp_pathable_sdDefuseObj", var_a9e623b5, squadindex);
  return spawnStruct();
}

private function_b032f16b(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  bots = planner::getblackboardattribute(planner, "doppelbots", squadindex);
  var_a9e623b5 = planner::getblackboardattribute(planner, "mp_pathable_sdDefuseObj", squadindex);

  if(!isarray(var_a9e623b5) || var_a9e623b5.size <= 0) {
    return spawnStruct();
  }

  planner::setblackboardattribute(planner, "mp_sdDefuseObj", array(var_a9e623b5[0][#"sddefuseobj"]), squadindex);
  return spawnStruct();
}

private function_9c7e3773(planner, constants) {
  squadindex = planner::getblackboardattribute(planner, #"current_squad");
  assert(squadindex >= 0, "<dev string:xf6>");
  numlanes = region_utility::function_9fe18733();
  lanenum = squadindex % numlanes;
  planner::setblackboardattribute(planner, "mp_laneNum", array(lanenum), squadindex);
  return spawnStruct();
}

private function_39cd5957(planner, constants) {
  commanderteam = planner::getblackboardattribute(planner, #"team");
  return commanderteam == game.attackers;
}

private function_97659d05(planner, constants) {
  commanderteam = planner::getblackboardattribute(planner, #"team");
  return commanderteam == game.defenders;
}

private function_9e016913(planner, constants) {
  return isDefined(level.bombplanted) && level.bombplanted;
}