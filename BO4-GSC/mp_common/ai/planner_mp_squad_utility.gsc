/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\ai\planner_mp_squad_utility.gsc
*****************************************************/

#include scripts\core_common\ai\planner_squad;
#include scripts\core_common\ai\planner_squad_utility;
#include scripts\core_common\ai\region_utility;
#include scripts\core_common\ai\strategic_command;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\planner;
#include scripts\core_common\ai\systems\planner_blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\system_shared;

#namespace planner_mp_squad_utility;

autoexec __init__system__() {
  system::register(#"planner_mp_squad_utility", &namespace_9b3ab448::__init__, undefined, undefined);
}

#namespace namespace_9b3ab448;

private __init__() {
  plannerutility::registerplannerapi(#"hash_7cb07a568d6f4cdf", &function_984c7289);
  plannerutility::registerplannerapi(#"hash_a478e9ff1c93f25", &function_3e055926);
  plannerutility::registerplannerapi(#"hash_6d04a8beefdd8300", &function_ca867965);
  plannerutility::registerplannerapi(#"hash_4e7f3e0ab96fb7d6", &function_16b44b20);
  plannerutility::registerplannerapi(#"hash_390ec5fab1695fc5", &function_c1f972ba);
  plannerutility::registerplannerapi(#"hash_729fab3e03b8972e", &function_a5c008c);
  plannerutility::registerplannerapi(#"hash_22435468ace59f07", &function_b6cc50c3);
  plannerutility::registerplannerapi(#"hash_5a17553b6546a4c5", &function_5d508101);
  plannerutility::registerplanneraction(#"hash_238cb2b85abe80de", &function_c586e586, &function_bb0c6999, &function_e9a16daa, undefined);
  plannerutility::registerplanneraction(#"hash_3fff1f031065f09f", &function_2b5c33a8, &function_4ff28605, &function_fd3f340f, undefined);
  plannerutility::registerplanneraction(#"hash_1d498d2dc9db37d7", &function_e32ce201, &function_fb2a81d9, &function_99cd56f9, undefined);
  plannerutility::registerplanneraction(#"hash_62f0edcdb7d80d62", &function_f3fefad8, &function_3235898a, &function_94e18e0d, undefined);
  plannerutility::registerplanneraction(#"hash_44fb55c97ea86435", &function_5b04cb13, &function_bb791fc6, &function_df817333, undefined);
  plannerutility::registerplanneraction(#"hash_7390712ebfb3d2d3", &function_f08360d0, &function_e7a81528, &function_fb79f3bd, undefined);
  plannerutility::registerplanneraction(#"hash_49c4e40e3e0f7be0", &function_458e36c0, &function_4f4ef3b6, &function_53882720, undefined);
  plannerutility::registerplanneraction(#"hash_53845b799f264276", &function_8c1624c4, &function_61587057, &function_6203826a, undefined);
}

private _paramshasbots(params) {
  foreach(bot in params.bots) {
    if(isDefined(bot) && isbot(bot) && ai::getaiattribute(bot, "control") === "commander") {
      return true;
    }
  }

  return false;
}

private function_5cc53671(bot) {
  if(isDefined(bot) && isbot(bot)) {
    bot setgoal(bot.origin);
    bot.goalradius = 128;
    bot.goalheight = 128;
  }
}

private function_61be4b2c(bot, gameobject) {
  botpos = getclosestpointonnavmesh(bot.origin, 120, bot getpathfindingradius() * 1.05);
  objectpos = getclosestpointonnavmesh(gameobject.origin, 200);

  if(!isDefined(botpos) || !isDefined(objectpos)) {
    return gameobject.origin;
  }

  queryresult = positionquery_source_navigation(objectpos, 0, 200, 100, 16, bot);

  if(queryresult.data.size > 0) {
    for(i = 0; i < queryresult.data.size; i++) {
      pathsegment = generatenavmeshpath(botpos, queryresult.data[i].origin, bot);

      if(isDefined(pathsegment) && pathsegment.status === "succeeded") {
        return queryresult.data[i].origin;
      }
    }
  }
}

private function_3ecc52d9(var_d3547bb1, lanenum) {
  if(isDefined(self.bot.var_6369695a)) {
    currentpath = self.bot.var_6369695a.path;

    if(currentpath.size > 0) {
      var_3ebdf257 = currentpath[currentpath.size - 1];

      if(var_3ebdf257 === var_d3547bb1) {
        return self.bot.var_6369695a;
      }
    }
  }

  tpoint = getclosesttacpoint(self.origin);

  if(!isDefined(tpoint)) {
    navpos = getclosestpointonnavmesh(self.origin, 600);

    if(isDefined(navpos)) {
      tpoint = getclosesttacpoint(navpos);
    }
  }

  if(isDefined(tpoint)) {
    var_55e8adf1 = tpoint.region;
    var_8c8aa14d = spawnStruct();
    var_8c8aa14d.path = self region_utility::function_b0f112ca(var_55e8adf1, var_d3547bb1, lanenum);
    var_8c8aa14d.var_91fc28f4 = 0;

    if(var_8c8aa14d.path.size == 0) {
      if(!isDefined(var_8c8aa14d.path)) {
        var_8c8aa14d.path = [];
      } else if(!isarray(var_8c8aa14d.path)) {
        var_8c8aa14d.path = array(var_8c8aa14d.path);
      }

      var_8c8aa14d.path[var_8c8aa14d.path.size] = var_d3547bb1;
    }

    self.bot.var_6369695a = var_8c8aa14d;
    return var_8c8aa14d;
  }
}

private function_a702eb04(params, goal) {
  var_c19c4223 = 0;

  for(i = 0; i < params.bots.size; i++) {
    bot = params.bots[i];

    if(strategiccommandutility::isvalidbot(bot)) {
      var_6369695a = params.var_bb5fa5a7[i];

      if(!isDefined(var_6369695a) || var_6369695a.path.size == 0) {
        bot setgoal(goal);
        continue;
      }

      goalinfo = bot function_4794d6a3();
      tpoint = getclosesttacpoint(bot.origin);

      if(!isDefined(tpoint) && isDefined(goalinfo.regionid) && !goalinfo.isatgoal) {
        continue;
      }

      var_65733efe = -1;

      if(isDefined(tpoint)) {
        var_65733efe = tpoint.region;
      }

      for(var_91fc28f4 = var_6369695a.var_91fc28f4; var_91fc28f4 < var_6369695a.path.size; var_91fc28f4++) {
        if(var_65733efe === var_6369695a.path[var_91fc28f4]) {
          break;
        }
      }

      if(var_91fc28f4 < var_6369695a.path.size - 2) {
        bot.var_d494450c = undefined;
        bot setgoal(var_6369695a.path[var_91fc28f4 + 1]);

        if(var_91fc28f4 > var_6369695a.var_91fc28f4) {
          var_6369695a.var_91fc28f4 = var_91fc28f4;
        }

        continue;
      }

      bot.var_d494450c = undefined;
      bot setgoal(goal);
      var_c19c4223++;
    }
  }

  if(var_c19c4223 == params.bots.size) {
    return 1;
  }

  return 3;
}

private function_a023ae49(planner, params) {
  foreach(bot in params.bots) {
    function_5cc53671(bot);
  }
}

private function_3f15f776(params) {
  for(i = 0; i < params.bots.size; i++) {
    bot = params.bots[i];

    if(strategiccommandutility::isvalidbot(bot)) {
      goalinfo = bot function_4794d6a3();

      if(isDefined(goalinfo.regionid) && !goalinfo.isatgoal) {
        continue;
      }

      region = params.regions[randomint(params.regions.size)];
      bot.var_d494450c = undefined;
      bot setgoal(region);
    }
  }

  return 3;
}

private function_6d153384(position) {
  if(level.teambased) {
    return function_69e73bdb(position);
  }

  maxdist = 0;
  var_4764de7f = position;

  foreach(spawn in level.spawn_start[#"free"]) {
    dist = distancesquared(position, spawn.origin);

    if(dist > maxdist) {
      maxdist = dist;
      var_4764de7f = spawn.origin;
    }
  }

  return var_4764de7f;
}

private function_69e73bdb(position) {
  if(!isDefined(level.spawn_start) || !isDefined(level.spawn_start[#"allies"]) || !isDefined(level.spawn_start[#"axis"]) || level.spawn_start[#"allies"].size == 0 || level.spawn_start[#"axis"].size == 0) {
    return undefined;
  }

  var_192c21ed = level.spawn_start[#"allies"][0].origin;
  var_945e5bae = level.spawn_start[#"axis"][0].origin;
  var_eb097b41 = distancesquared(position, var_192c21ed);
  var_75b1f52d = distancesquared(position, var_945e5bae);
  return var_eb097b41 < var_75b1f52d ? var_945e5bae : var_192c21ed;
}

function_55cc58c4(planner, var_973c5ec5) {
  var_757ff5c1 = undefined;
  var_72d5b8ac = planner::getblackboardattribute(planner, "mp_pathable_controlZones");

  if(isarray(var_72d5b8ac) && var_72d5b8ac.size == 2) {
    foreach(var_2b511b1a in var_72d5b8ac) {
      zone = var_2b511b1a[#"controlzone"][#"__unsafe__"][#"controlzone"];

      if(zone.gameobject.trigger istriggerenabled() && zone != var_973c5ec5) {
        var_757ff5c1 = zone;
      }
    }
  }

  return var_757ff5c1;
}

private function_984c7289(planner, constants) {
  controlzones = planner::getblackboardattribute(planner, "mp_controlZones");

  if(!isarray(controlzones) || controlzones.size <= 0) {
    return false;
  }

  for(i = 0; i < controlzones.size; i++) {
    zone = controlzones[i][#"__unsafe__"][#"controlzone"];

    if(isDefined(zone) && isDefined(zone.gameobject)) {
      return true;
    }
  }

  return false;
}

private function_3e055926(planner, constants) {
  domflags = planner::getblackboardattribute(planner, "mp_domFlags");

  if(!isarray(domflags) || domflags.size <= 0) {
    return false;
  }

  for(i = 0; i < domflags.size; i++) {
    domflag = domflags[i][#"__unsafe__"][#"domflag"];

    if(isDefined(domflag) && domflags[i][#"claimed"] == 0) {
      return true;
    }
  }

  return false;
}

private function_ca867965(planner, constants) {
  kothzone = planner::getblackboardattribute(planner, "mp_kothZone");

  if(!isarray(kothzone) || kothzone.size <= 0) {
    return false;
  }

  zone = kothzone[0][#"__unsafe__"][#"kothzone"];

  if(isDefined(zone) && isDefined(zone.trig) && zone.trig istriggerenabled()) {
    return true;
  }

  return false;
}

private function_16b44b20(planner, constants) {
  sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");

  if(!isarray(sdbomb) || sdbomb.size <= 0) {
    return false;
  }

  bots = planner::getblackboardattribute(planner, "doppelbots");

  if(isDefined(bots)) {
    bot = bots[0][#"__unsafe__"][#"bot"];

    if(isDefined(bot) && isalive(bot)) {
      var_7fe54ea1 = bot getentitynumber();

      foreach(player in level.players) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }

        if(player == bot || !isbot(player)) {
          continue;
        }

        if(!isDefined(player.sessionstate) || player.sessionstate != "playing") {
          continue;
        }

        if(player.team != bot.team) {
          continue;
        }

        if(player getentitynumber() < var_7fe54ea1) {
          return false;
        }
      }
    }
  }

  bomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];

  if(isDefined(bomb) && bomb.trigger istriggerenabled()) {
    return true;
  }

  return false;
}

private function_c1f972ba(planner, constants) {
  bombzones = planner::getblackboardattribute(planner, "mp_sdBombZones");

  if(!isarray(bombzones) || bombzones.size <= 0) {
    return false;
  }

  for(i = 0; i < bombzones.size; i++) {
    zone = bombzones[i][#"__unsafe__"][#"sdbombzone"];

    if(isDefined(zone)) {
      return true;
    }
  }

  return false;
}

private function_a5c008c(planner, constants) {
  defuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");

  if(!isarray(defuseobj) || defuseobj.size <= 0) {
    return false;
  }

  defuse = defuseobj[0][#"__unsafe__"][#"sddefuseobj"];

  if(isDefined(defuse)) {
    return true;
  }

  return false;
}

private function_b6cc50c3(planner, constants) {
  bots = planner::getblackboardattribute(planner, "doppelbots");

  for(i = 0; i < bots.size; i++) {
    bot = bots[0][#"__unsafe__"][#"bot"];

    if(isDefined(bot.isbombcarrier) && bot.isbombcarrier || isDefined(level.multibomb) && level.multibomb) {
      return true;
    }
  }

  return false;
}

private function_5d508101(planner, constants) {
  lanenum = planner::getblackboardattribute(planner, "mp_laneNum");

  if(!isDefined(lanenum) || lanenum.size == 0) {
    return false;
  }

  return true;
}

function_f816c9b0(var_973c5ec5, var_5d4457) {
  var_803d2f2a = var_973c5ec5.gameobject.curprogress > 0;
  var_99b927c3 = var_5d4457.gameobject.curprogress > 0;

  if(!var_803d2f2a && var_99b927c3) {
    return true;
  }

  return false;
}

private function_c586e586(planner, constants) {
  params = spawnStruct();
  controlzone = planner::getblackboardattribute(planner, "mp_controlZones");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.controlzone = controlzone[0][#"__unsafe__"][#"controlzone"];
  var_a83322cd = params.controlzone.gameobject.trigger istriggerenabled();

  if(!var_a83322cd) {
    var_5d4457 = self function_55cc58c4(planner, params.controlzone);
    var_497c24d4 = isDefined(var_5d4457);

    if(var_497c24d4) {
      params.controlzone = var_5d4457;
    }
  } else if(isDefined(params.bots[0]) && params.bots[0].team == game.defenders && getdvarint(#"bot_difficulty", 1) >= 1) {
    var_5d4457 = self function_55cc58c4(planner, params.controlzone);
    var_497c24d4 = isDefined(var_5d4457);

    if(var_497c24d4 && self function_f816c9b0(params.controlzone, var_5d4457)) {
      params.controlzone = var_5d4457;
    }
  }

  params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
  params.var_46b70ee6 = getclosesttacpoint(params.controlzone.gameobject.origin).region;

  if(isDefined(params.controlzone)) {
    if(isDefined(params.var_f76f8cf6)) {
      params.var_bb5fa5a7 = [];

      for(i = 0; i < bots.size; i++) {
        if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing") {
          params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
        }
      }
    } else {
      foreach(bot in bots) {
        if(strategiccommandutility::isvalidbot(bot)) {
          params.path = strategiccommandutility::calculatepathtoposition(bot, params.controlzone.gameobject.origin);

          if(isDefined(params.path)) {
            break;
          }
        }
      }
    }
  }

  return params;
}

private function_bb0c6999(planner, params) {
  if(!isDefined(params.controlzone) || !_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private function_e9a16daa(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(!isDefined(params.controlzone)) {
    return 2;
  }

  var_a83322cd = params.controlzone.gameobject.trigger istriggerenabled();

  if(!var_a83322cd) {
    var_5d4457 = self function_55cc58c4(planner, params.controlzone);
    var_497c24d4 = isDefined(var_5d4457);

    if(var_497c24d4) {
      return 2;
    }
  } else if(isDefined(params.bots[0]) && params.bots[0].team == game.defenders && getdvarint(#"bot_difficulty", 1) >= 1) {
    var_5d4457 = self function_55cc58c4(planner, params.controlzone);
    var_497c24d4 = isDefined(var_5d4457);

    if(var_497c24d4 && self function_f816c9b0(params.controlzone, var_5d4457)) {
      return 2;
    }
  }

  if(!isDefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0) {
    foreach(bot in params.bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        bot setgoal(params.controlzone.trigger);
      }
    }

    return 3;
  }

  return function_a702eb04(params, params.controlzone.trigger);
}

private function_2b5c33a8(planner, constants) {
  params = spawnStruct();
  domflags = planner::getblackboardattribute(planner, "mp_domFlags");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  var_2bd3822d = [];

  foreach(flag in domflags) {
    var_796d54f2 = flag[#"__unsafe__"][#"domflag"];

    if(!isDefined(var_2bd3822d)) {
      var_2bd3822d = [];
    } else if(!isarray(var_2bd3822d)) {
      var_2bd3822d = array(var_2bd3822d);
    }

    var_2bd3822d[var_2bd3822d.size] = var_796d54f2;
  }

  params.bots = bots;

  foreach(bot in params.bots) {
    if(!isDefined(bot)) {
      continue;
    }

    var_d637f1b0 = [];
    var_e2b90cdd = [];
    var_44114a0e = "";

    for(i = 0; i < var_2bd3822d.size; i++) {
      flag = var_2bd3822d[i];

      if(flag gameobjects::get_owner_team() === bot.team) {
        var_44114a0e += "d";

        if(!isDefined(var_e2b90cdd)) {
          var_e2b90cdd = [];
        } else if(!isarray(var_e2b90cdd)) {
          var_e2b90cdd = array(var_e2b90cdd);
        }

        var_e2b90cdd[var_e2b90cdd.size] = flag;
        continue;
      }

      var_44114a0e += "a";

      if(!isDefined(var_d637f1b0)) {
        var_d637f1b0 = [];
      } else if(!isarray(var_d637f1b0)) {
        var_d637f1b0 = array(var_d637f1b0);
      }

      var_d637f1b0[var_d637f1b0.size] = flag;
    }

    if(!isDefined(bot.bot.var_44114a0e) || var_44114a0e != bot.bot.var_44114a0e) {
      bot.bot.var_44114a0e = var_44114a0e;
      bot.bot.currentflag = undefined;
    }

    if(!isDefined(bot.bot.currentflag)) {
      if(var_e2b90cdd.size >= 2) {
        if(getdvarint(#"bot_difficulty", 1) == 0) {
          bot.bot.currentflag = var_e2b90cdd[0];
        } else {
          bot.bot.currentflag = array::random(var_e2b90cdd);
        }
      } else if(var_d637f1b0.size >= 0) {
        bot.bot.currentflag = var_d637f1b0[0];

        if(var_d637f1b0.size > 1 && randomfloat(1) < 0.35 && distancesquared(bot.origin, var_d637f1b0[0].origin) > 360000) {
          bot.bot.currentflag = var_d637f1b0[1];

          if(var_d637f1b0.size > 2 && randomfloat(1) < 0.3) {
            bot.bot.currentflag = var_d637f1b0[2];
          }
        }
      } else if(var_2bd3822d.size > 0) {
        bot.bot.currentflag = var_2bd3822d[0];
      }
    }

    params.domflag = bot.bot.currentflag;
  }

  if(!isDefined(params.domflag)) {
    return params;
  }

  params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
  params.var_46b70ee6 = getclosesttacpoint(params.domflag.origin).region;

  if(isDefined(params.domflag)) {
    if(isDefined(params.var_f76f8cf6)) {
      params.var_bb5fa5a7 = [];

      for(i = 0; i < bots.size; i++) {
        if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i]) && game.state == "playing") {
          params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
        }
      }
    } else {
      foreach(bot in bots) {
        if(strategiccommandutility::isvalidbot(bot)) {
          params.path = strategiccommandutility::calculatepathtoposition(bot, params.domflag.origin);

          if(isDefined(params.path)) {
            break;
          }
        }
      }
    }
  }

  return params;
}

private function_4ff28605(planner, params) {
  if(!isDefined(params.domflag) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot setgoal(params.domflag.trigger);
    }
  }

  return 1;
}

private function_fd3f340f(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(!isDefined(params.domflag)) {
    return 2;
  }

  if(!isDefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0) {
    foreach(bot in params.bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        bot setgoal(params.domflag.trigger);
      }
    }

    return 3;
  }

  return function_a702eb04(params, params.domflag.trigger);
}

private function_e32ce201(planner, constants) {
  params = spawnStruct();
  kothzone = planner::getblackboardattribute(planner, "mp_kothZone");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.kothzone = kothzone[0][#"__unsafe__"][#"kothzone"];
  params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");
  params.var_46b70ee6 = getclosesttacpoint(params.kothzone.gameobject.origin).region;

  if(isDefined(params.kothzone)) {
    if(isDefined(params.lanenum)) {
      params.var_bb5fa5a7 = [];

      for(i = 0; i < bots.size; i++) {
        if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i])) {
          params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
        }
      }
    } else {
      foreach(bot in bots) {
        if(strategiccommandutility::isvalidbot(bot)) {
          params.path = strategiccommandutility::calculatepathtoposition(bot, params.kothzone.gameobject.origin);

          if(isDefined(params.path)) {
            break;
          }
        }
      }
    }
  }

  return params;
}

private function_fb2a81d9(planner, params) {
  if(!isDefined(params.kothzone) || !_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private function_99cd56f9(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(!isDefined(params.kothzone)) {
    return 2;
  }

  if(!isDefined(params.var_bb5fa5a7) || params.var_bb5fa5a7.size == 0) {
    foreach(bot in params.bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        bot setgoal(params.kothzone.trig);
      }
    }

    return 3;
  }

  return function_a702eb04(params, params.kothzone.trig);
}

private function_f3fefad8(planner, constants) {
  params = spawnStruct();
  sdbomb = planner::getblackboardattribute(planner, "mp_sdBomb");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.sdbomb = sdbomb[0][#"__unsafe__"][#"sdbomb"];

  if(isDefined(params.sdbomb)) {
    foreach(bot in bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbomb.origin);

        if(isDefined(params.path)) {
          break;
        }
      }
    }
  }

  return params;
}

private function_3235898a(planner, params) {
  if(!isDefined(params.sdbomb) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot bot::clear_interact();
      goal = params.sdbomb.origin;

      if(!ispointonnavmesh(goal, bot)) {
        var_1209f27 = getclosesttacpoint(goal);

        if(isDefined(var_1209f27)) {
          goal = var_1209f27.origin;
        }
      }

      bot setgoal(goal);
      bot.goalradius = 8;
    }
  }

  return 1;
}

private function_94e18e0d(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.sdbomb)) {
    if(isDefined(params.bots[0].isbombcarrier) && params.bots[0].isbombcarrier) {
      return 1;
    }

    if(!isDefined(params.sdbomb.trigger) || !params.sdbomb.trigger istriggerenabled()) {
      return 2;
    }

    goalinfo = params.bots[0] function_4794d6a3();

    if(isDefined(goalinfo) && goalinfo.isatgoal) {
      params.sdbomb.trigger useby(params.bots[0]);
    }

    return 3;
  }

  return 2;
}

private function_5b04cb13(planner, constants) {
  params = spawnStruct();
  sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];

  if(isDefined(params.sdbombzone)) {
    foreach(bot in bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);

        if(isDefined(params.path)) {
          break;
        }
      }
    }
  }

  return params;
}

private function_bb791fc6(planner, params) {
  if(!isDefined(params.sdbombzone) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot bot::clear_interact();
      goal = params.sdbombzone;
      bot setgoal(goal);
      bot.goalradius = 128;
      bot bot::set_interact(params.sdbombzone);
    }
  }

  return 1;
}

private function_df817333(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.sdbombzone)) {
    return 3;
  }

  return 2;
}

private function_f08360d0(planner, constants) {
  params = spawnStruct();
  sddefuseobj = planner::getblackboardattribute(planner, "mp_sdDefuseObj");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.sddefuseobj = sddefuseobj[0][#"__unsafe__"][#"sddefuseobj"];

  if(isDefined(params.sddefuseobj)) {
    foreach(bot in bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        params.path = strategiccommandutility::calculatepathtoposition(bot, params.sddefuseobj.origin);

        if(isDefined(params.path)) {
          break;
        }
      }
    }
  }

  return params;
}

private function_e7a81528(planner, params) {
  if(!isDefined(params.sddefuseobj) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot bot::clear_interact();
      bot setgoal(params.sddefuseobj);
      bot.goalradius = 128;
      bot bot::set_interact(params.sddefuseobj);
    }
  }

  return 1;
}

private function_fb79f3bd(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(isDefined(params.sddefuseobj)) {
    return 3;
  }

  return 2;
}

private function_458e36c0(planner, constants) {
  params = spawnStruct();
  sdbombzone = planner::getblackboardattribute(planner, "mp_sdBombZones");
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  params.bots = bots;
  params.sdbombzone = sdbombzone[0][#"__unsafe__"][#"sdbombzone"];

  if(isDefined(params.sdbombzone)) {
    foreach(bot in bots) {
      if(strategiccommandutility::isvalidbot(bot)) {
        params.path = strategiccommandutility::calculatepathtoposition(bot, params.sdbombzone.origin);

        if(isDefined(params.path)) {
          break;
        }
      }
    }
  }

  params.regions = [];

  if(!isDefined(params.regions)) {
    params.regions = [];
  } else if(!isarray(params.regions)) {
    params.regions = array(params.regions);
  }

  params.regions[params.regions.size] = getclosesttacpoint(params.sdbombzone.origin).region;
  var_c1db2604 = function_b507a336(params.regions[0]);

  foreach(neighbor in var_c1db2604.neighbors) {
    if(!isDefined(params.regions)) {
      params.regions = [];
    } else if(!isarray(params.regions)) {
      params.regions = array(params.regions);
    }

    params.regions[params.regions.size] = neighbor;
  }

  return params;
}

private function_4f4ef3b6(planner, params) {
  if(!isDefined(params.sdbombzone) || !_paramshasbots(params)) {
    return 2;
  }

  foreach(bot in params.bots) {
    if(strategiccommandutility::isvalidbot(bot)) {
      bot setgoal(params.regions[0]);
    }
  }

  return 1;
}

private function_53882720(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(!isDefined(params.sdbombzone)) {
    return 2;
  }

  return function_3f15f776(params);
}

private function_8c1624c4(planner, constants) {
  params = spawnStruct();
  bots = [];

  foreach(botinfo in planner::getblackboardattribute(planner, "doppelbots")) {
    if(!isDefined(bots)) {
      bots = [];
    } else if(!isarray(bots)) {
      bots = array(bots);
    }

    bots[bots.size] = botinfo[#"__unsafe__"][#"bot"];
  }

  if(!isDefined(bots[0]) || game.state != "playing") {
    return params;
  }

  params.bots = bots;
  params.var_f76f8cf6 = planner::getblackboardattribute(planner, "mp_laneNum");

  if(bots.size > 1) {
    print("<dev string:x38>");
  }

    var_79a83b2e = undefined;

  if(isDefined(bots[0].bot.var_f9954cf6)) {
    var_79a83b2e = bots[0].bot.var_f9954cf6;
    var_f6ce5982 = getclosesttacpoint(bots[0].origin);

    if(isDefined(var_f6ce5982) && isDefined(var_f6ce5982.region)) {
      var_65733efe = var_f6ce5982.region;

      if(var_65733efe === bots[0].bot.var_f9954cf6) {
        var_79a83b2e = undefined;
      }
    }
  }

  if(!isDefined(var_79a83b2e)) {
    var_ae5ed4e = function_6d153384(bots[0].origin);

    if(isDefined(var_ae5ed4e)) {
      var_79a83b2e = getclosesttacpoint(var_ae5ed4e).region;
    } else {
      var_79a83b2e = getclosesttacpoint(bots[0].origin).region;
    }

    bots[0].bot.var_f9954cf6 = var_79a83b2e;
  }

  params.var_46b70ee6 = var_79a83b2e;
  params.var_bb5fa5a7 = [];

  for(i = 0; i < bots.size; i++) {
    if(strategiccommandutility::isvalidbot(bots[i]) && isalive(bots[i])) {
      params.var_bb5fa5a7[i] = bots[i] function_3ecc52d9(params.var_46b70ee6, params.var_f76f8cf6[0]);
    }
  }

  return params;
}

private function_61587057(planner, params) {
  if(!isDefined(params.var_bb5fa5a7) || !_paramshasbots(params)) {
    return 2;
  }

  return 1;
}

private function_6203826a(planner, params) {
  if(!_paramshasbots(params)) {
    return 2;
  }

  if(!isDefined(params.var_bb5fa5a7)) {
    return 2;
  }

  var_d5fcb00b = params;

  for(i = 0; i < var_d5fcb00b.bots.size; i++) {
    bot = var_d5fcb00b.bots[i];

    if(strategiccommandutility::isvalidbot(bot) && bot bot::in_combat() && distancesquared(bot.enemy.origin, bot.origin) < 640000) {
      var_494658cd = getclosesttacpoint(bot.enemy.origin);

      if(!isDefined(var_494658cd)) {
        continue;
      }

      bot setgoal(var_494658cd.region);
      var_d5fcb00b.bots[i] = undefined;
    }
  }

  return function_a702eb04(var_d5fcb00b, params.var_46b70ee6);
}