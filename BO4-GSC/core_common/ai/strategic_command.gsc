/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\strategic_command.gsc
************************************************/

#include scripts\core_common\ai\planner_squad;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_chain;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;

#namespace strategic_command;

autoexec __init__system__() {
  system::register(#"strategic_command", &strategiccommandutility::__init__, undefined, undefined);
}

#namespace strategiccommandutility;

private __init__() {
  level thread _debuggameobjects();
  level thread function_f0be958();
  level thread function_1e535a11();
  level thread function_35fd8254();
  level thread function_75df771f();

  if(!isDefined(level.strategic_command_throttle)) {
    level.strategic_command_throttle = new throttle();
    [[level.strategic_command_throttle]] - > initialize(1, float(function_60d95f53()) / 1000);
  }
}

private function_ee3d20f5(entity, points) {
  path = undefined;
  shortestpath = undefined;
  start = entity getclosestpointonnavvolume(entity.origin, 200);
  index = 0;

  while(index < points.size) {
    goalpoints = [];

    for(goalindex = index; goalindex - index < 16 && goalindex < points.size; goalindex++) {
      goalpoints[goalpoints.size] = entity getclosestpointonnavvolume(points[goalindex].origin, 200);
    }

    possiblepath = function_ae7a8634(start, goalpoints, entity);

    if(isDefined(possiblepath) && possiblepath.status === "succeeded") {
      if(!isDefined(shortestpath) || possiblepath.pathdistance < shortestpath) {
        path = possiblepath;
        shortestpath = possiblepath.pathdistance;
        return path;
      }
    }

    index += 16;
  }

  return path;
}

private _calculatepathtopoints(entity, points) {
  path = undefined;
  shortestpath = undefined;
  entradius = entity getpathfindingradius();
  entposition = getclosestpointonnavmesh(entity.origin, 200, entradius);
  index = 0;

  while(index < points.size) {
    goalpoints = [];

    for(goalindex = index; goalindex - index < 16 && goalindex < points.size; goalindex++) {
      if(ispointonnavmesh(points[goalindex].origin, entradius)) {
        goalpoints[goalpoints.size] = points[goalindex].origin;
      }
    }

    if(isbot(entity)) {
      possiblepath = generatenavmeshpath(entposition, goalpoints, entity, undefined, undefined, 5000);
    } else {
      possiblepath = generatenavmeshpath(entposition, goalpoints, undefined, undefined, undefined, 5000);
    }

    if(isDefined(possiblepath) && possiblepath.status === "succeeded") {
      if(!isDefined(shortestpath) || possiblepath.pathdistance < shortestpath) {
        path = possiblepath;
        shortestpath = possiblepath.pathdistance;
      }
    }

    index += 16;
  }

  return path;
}

private function_45857dbe(members) {
  var_48fb9acf = 0;
  working = array();

  foreach(member in members) {
    entnum = member getentitynumber();
    working[entnum] = member;

    if(entnum > var_48fb9acf) {
      var_48fb9acf = entnum;
    }
  }

  sorted = array();

  for(index = 0; index <= var_48fb9acf; index++) {
    if(isDefined(working[index])) {
      sorted[sorted.size] = working[index];
    }
  }

  return sorted;
}

private function_65b80a10(commander, member, vehicle = undefined) {
  if(isDefined(vehicle)) {
    occupant = vehicle getseatoccupant(0);

    if(isplayer(occupant) && !isbot(occupant)) {
      return "<dev string:x38>";
    }

    if(isDefined(vehicle.attachedpath)) {
      return "<dev string:x41>";
    }

    if(member bot_chain::function_58b429fb()) {
      return "<dev string:x4a>";
    }

    if(isDefined(commander) && !commander.pause && function_4732f860(member)) {
      return "<dev string:x56>";
    }

    if(vehicle.goalforced) {
      return "<dev string:x62>";
    }
  } else {
    autonomous = ai::getaiattribute(member, "<dev string:x6d>") == "<dev string:x77>";

    if(function_778568e2(member) || function_e1b87d35(member)) {
      return "<dev string:x84>";
    }

    if(autonomous) {
      if(member bot_chain::function_58b429fb()) {
        return "<dev string:x4a>";
      }

      return "<dev string:x62>";
    }

    if(isDefined(commander) && !commander.pause && isvalidbot(member)) {
      return "<dev string:x56>";
    }
  }

  return "<dev string:x8e>";
}

private function_41c81572(var_78caba27) {
  switch (var_78caba27) {
    case #"bot chain":
    case #"spline":
      return (0, 1, 0);
    case #"scripted":
      return (1, 0, 0);
    case #"commander":
    case #"player":
    case #"vehicle":
      return (1, 0.5, 0);
  }

  return (1, 0, 0);
}

private function_741d9796(member, vehicle, commander, var_78caba27) {
  switch (var_78caba27) {
    case #"bot chain":
      if(isDefined(member.bot.var_53ffa4c4.startstruct)) {
        return ("<dev string:x98>" + member.bot.var_53ffa4c4.startstruct.targetname + "<dev string:xa2>");
      }
    case #"commander":
      foreach(squad in commander.squads) {
        bots = plannersquadutility::getblackboardattribute(squad, "<dev string:xa6>");

        if(bots.size > 0 && bots[0][#"entnum"] == member getentitynumber()) {
          target = plannersquadutility::getblackboardattribute(squad, "<dev string:xb3>");

          if(isDefined(target)) {
            bundle = target[#"__unsafe__"][#"bundle"];
            missioncomponent = target[#"__unsafe__"][#"mission_component"];

            if(isDefined(missioncomponent)) {
              return missioncomponent.scriptbundlename;
            }

            object = target[#"__unsafe__"][#"object"];

            if(isDefined(object) && isDefined(object.e_object) && isDefined(object.e_object.scriptbundlename)) {
              return object.e_object.scriptbundlename;
            }
          }

          order = plannersquadutility::getblackboardattribute(squad, "<dev string:xbc>");
          return order;
        }
      }

      break;
  }

  if(isDefined(vehicle)) {
    switch (var_78caba27) {
      case #"spline":
        return vehicle.attachedpath.targetname;
    }

    return;
  }

  switch (var_78caba27) {
    case #"vehicle":
      vehicle = member getvehicleoccupied();

      if(isDefined(vehicle)) {
        return vehicle.vehicleclass;
      }

      break;
  }
}

private function_7c3d768e(var_1b2a0645, var_d695a79f, commander) {
  if(!isDefined(commander)) {
    return var_d695a79f;
  }

  var_6e868cb7 = 0;
  yspacing = 27;
  textcolor = (1, 1, 1);
  textalpha = 1;
  backgroundcolor = (0, 0, 0);
  backgroundalpha = 0.8;
  textsize = 1.25;
  team = blackboard::getstructblackboardattribute(commander, #"team");
  paused = isDefined(commander.pause) && commander.pause;
  squadcount = commander.squads.size;
  debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:xc4>" + function_9e72a96(team) + "<dev string:xa2>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
  var_1b2a0645 += var_6e868cb7;
  var_d695a79f += yspacing;
  var_1b2a0645 += 25;
  debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:xd2>" + squadcount, !paused && squadcount > 0 || paused && squadcount == 0 ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
  var_1b2a0645 += var_6e868cb7;
  var_d695a79f += yspacing;
  debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:xdd>" + (paused ? "<dev string:xe8>" : "<dev string:xf1>"), paused ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
  var_1b2a0645 += var_6e868cb7;
  var_d695a79f += yspacing;

  return var_d695a79f;
}

private function_df74a8f3(var_1b2a0645, var_d695a79f, members, commander) {
  var_6e868cb7 = 0;
  yspacing = 27;
  textcolor = (1, 1, 1);
  textalpha = 1;
  backgroundcolor = (0, 0, 0);
  backgroundalpha = 0.8;
  textsize = 1.25;
  var_4fe31551 = 350;
  var_96e1d277 = 25;

  foreach(member in members) {
    yoffset = var_d695a79f;
    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:xfb>" + member getentitynumber() + "<dev string:x100>" + member.name + "<dev string:x104>" + function_9e72a96(member.team) + "<dev string:xa2>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    var_1b2a0645 += var_96e1d277;
    var_78caba27 = function_65b80a10(commander, member);
    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x109>" + (member isplayinganimscripted() ? "<dev string:x11a>" : "<dev string:x11f>"), member isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x125>" + var_78caba27, function_41c81572(var_78caba27), textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    var_52cace54 = function_741d9796(member, undefined, commander, var_78caba27);

    if(isDefined(var_52cace54)) {
      var_1b2a0645 += var_96e1d277;
      debug2dtext((var_1b2a0645, var_d695a79f, 0), var_52cace54, function_41c81572(var_78caba27), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      var_1b2a0645 -= var_96e1d277;
    }

    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x136>" + (member.ignoreme ? "<dev string:x11a>" : "<dev string:x11f>"), member.ignoreme ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x143>" + (member.ignoreall ? "<dev string:x11a>" : "<dev string:x11f>"), member.ignoreall ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x151>" + (member.takedamage ? "<dev string:x11a>" : "<dev string:x11f>"), member.takedamage ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
    var_1b2a0645 += var_6e868cb7;
    var_d695a79f += yspacing;
    newyoffset = var_d695a79f;

    if(member isinvehicle()) {
      vehicle = member getvehicleoccupied();
      seatnum = vehicle getoccupantseat(member);
      var_d695a79f = yoffset;
      var_1b2a0645 += var_4fe31551;
      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:xfb>" + vehicle getentitynumber() + "<dev string:x100>" + vehicle.scriptvehicletype + "<dev string:x104>" + function_9e72a96(vehicle.team) + "<dev string:xa2>", textcolor, textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      var_1b2a0645 += var_96e1d277;
      var_78caba27 = function_65b80a10(commander, member, vehicle);
      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x109>" + (vehicle isplayinganimscripted() ? "<dev string:x11a>" : "<dev string:x11f>"), vehicle isplayinganimscripted() ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x125>" + var_78caba27, function_41c81572(var_78caba27), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      var_52cace54 = function_741d9796(member, vehicle, commander, var_78caba27);

      if(isDefined(var_52cace54)) {
        var_1b2a0645 += var_96e1d277;
        debug2dtext((var_1b2a0645, var_d695a79f, 0), var_52cace54, function_41c81572(var_78caba27), textalpha, backgroundcolor, backgroundalpha, textsize);
        var_1b2a0645 += var_6e868cb7;
        var_d695a79f += yspacing;
        var_1b2a0645 -= var_96e1d277;
      }

      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x136>" + (vehicle.ignoreme ? "<dev string:x11a>" : "<dev string:x11f>"), vehicle.ignoreme ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x143>" + (vehicle.ignoreall ? "<dev string:x11a>" : "<dev string:x11f>"), vehicle.ignoreall ? (1, 0.5, 0) : (0, 1, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      debug2dtext((var_1b2a0645, var_d695a79f, 0), "<dev string:x151>" + (vehicle.takedamage ? "<dev string:x11a>" : "<dev string:x11f>"), vehicle.takedamage ? (0, 1, 0) : (1, 0.5, 0), textalpha, backgroundcolor, backgroundalpha, textsize);
      var_1b2a0645 += var_6e868cb7;
      var_d695a79f += yspacing;
      var_d695a79f = newyoffset;
      var_1b2a0645 -= var_4fe31551;
      var_1b2a0645 -= var_96e1d277;
    }

    var_1b2a0645 -= var_96e1d277;
    var_d695a79f += 10;
  }

  return var_d695a79f;
}

private function_75df771f() {
  xoffset = 150;
  yoffset = 100;
  var_2f7868e6 = 850;
  var_608ee9cd = 50;

  for(debugmode = getdvarint(#"hash_2010e59417406d5f", 0); true; debugmode = getdvarint(#"hash_2010e59417406d5f", 0)) {
    waitframe(1);
    var_f3ac248f = getdvarint(#"hash_2010e59417406d5f", 0);

    if(var_f3ac248f != 0) {
      if(!debugmode) {
        iprintlnbold("<dev string:x160>");

      }

      var_1b2a0645 = xoffset;
      var_d695a79f = yoffset;
      var_6854a979 = 0;

      if(var_f3ac248f != 3) {
        var_6854a979 = function_7c3d768e(var_1b2a0645, var_d695a79f, level.alliescommander);
        var_1b2a0645 += var_2f7868e6;
      }

      if(var_f3ac248f != 2) {
        var_6854a979 = function_7c3d768e(var_1b2a0645, var_d695a79f, level.axiscommander);
      }

      var_1b2a0645 = xoffset;
      var_d695a79f = var_6854a979 + var_608ee9cd;

      if(var_f3ac248f != 3) {
        allies = function_45857dbe(util::get_bot_players(#"allies"));
        function_df74a8f3(var_1b2a0645, var_d695a79f, allies, level.alliescommander);
        var_1b2a0645 += var_2f7868e6;
        var_d695a79f = var_6854a979 + var_608ee9cd;
      }

      if(var_f3ac248f != 2) {
        axis = function_45857dbe(util::get_bot_players(#"axis"));
        function_df74a8f3(var_1b2a0645, var_d695a79f, axis, level.axiscommander);
      }

      continue;
    }

    if(debugmode) {
      iprintlnbold("<dev string:x178>");

    }
  }
}

private _debuggameobjects() {
  while(true) {
    waitframe(1);

    if(!getdvarint(#"ai_debuggameobjects", 0) || !isDefined(level.a_gameobjects)) {
      continue;
    }

    foreach(gameobject in level.a_gameobjects) {
      function_3ed19fa3(gameobject);
    }

  }
}

private function_f0be958() {
  while(true) {
    waitframe(1);

    if(!getdvarint(#"hash_1e47802a0e8997e3", 0) || !isDefined(level.var_8239a46c)) {
      continue;
    }

    for(i = 0; i < level.var_8239a46c.size; i++) {
      function_31badd5d(level.var_8239a46c[i], i);
    }
  }
}

private function_1e535a11() {
  while(true) {
    waitframe(1);

    if(!getdvarint(#"hash_2e02207d5878b8eb", 0) || !isDefined(level.a_s_breadcrumbs)) {
      continue;
    }

    for(i = 0; i < level.a_s_breadcrumbs.size; i++) {
      function_adb62fbb(level.a_s_breadcrumbs[i], i);
    }
  }
}

private function_31badd5d(missioncomponent, index) {
  if(!isDefined(index)) {
    index = "<dev string:x191>";
  }

  origin = missioncomponent.origin;
  identifiertext = missioncomponent.scriptbundlename + "<dev string:x104>" + index + "<dev string:xa2>";
  origintext = "<dev string:x195>" + int(origin[0]) + "<dev string:x19f>" + int(origin[1]) + "<dev string:x19f>" + int(origin[2]) + "<dev string:x1a4>";
  var_4fea471b = "<dev string:x1a9>" + missioncomponent.script_team + "<dev string:xa2>";
  var_fabc86d6 = "<dev string:x1b1>" + (isDefined(missioncomponent.var_3093fd62) ? "<dev string:x1c4>" : "<dev string:x1cc>");
  var_f3fe7e2c = "<dev string:x1d5>" + (isDefined(missioncomponent.var_4702e184) ? missioncomponent.var_4702e184 : "<dev string:x1df>") + "<dev string:xa2>";
  var_2aac6b87 = "<dev string:x1e2>" + (isDefined(missioncomponent.var_eba32ac6) ? missioncomponent.var_eba32ac6 : "<dev string:x1df>") + "<dev string:xa2>";
  statustext = "<dev string:x1ec>";
  statuscolor = (1, 1, 1);
  tacpointtext = "<dev string:x1fa>";
  errortext = undefined;
  component = missioncomponent.var_36f0c06d;

  if(isDefined(component) && missioncomponent flag::get("<dev string:x20a>")) {
    statustext = "<dev string:x214>";
    statuscolor = (0, 1, 0);
    gameobject = component.e_objective;
    var_41dd65b0 = undefined;

    if(isDefined(gameobject)) {
      var_41dd65b0 = gameobject.mdl_gameobject.trigger;
      function_3ed19fa3(gameobject.mdl_gameobject);
      recordline(origin, gameobject.mdl_gameobject.origin, statuscolor, "<dev string:x21e>");
    } else {
      if(isDefined(component.var_2956bff4)) {
        var_41dd65b0 = component.var_2956bff4;
        function_20610c3(component.var_2956bff4, statuscolor, "<dev string:x21e>");
        recordline(origin, component.var_2956bff4.origin, statuscolor, "<dev string:x21e>");
        record3dtext("<dev string:x22b>", component.var_2956bff4.origin + (0, 0, -5), statuscolor, "<dev string:x21e>");
      }

      if(isDefined(component.var_6bc907c4)) {
        function_20610c3(component.var_6bc907c4, statuscolor, "<dev string:x21e>");
        recordline(origin, component.var_6bc907c4.origin, statuscolor, "<dev string:x21e>");
        record3dtext("<dev string:x23d>", component.var_6bc907c4.origin + (0, 0, 5), statuscolor, "<dev string:x21e>");
      }
    }

    if(isDefined(var_41dd65b0)) {
      points = tacticalquery(#"stratcom_tacquery_trigger", var_41dd65b0);
      tacpointtext = "<dev string:x253>" + points.size + "<dev string:xa2>";

      if(points.size == 0) {
        errortext = "<dev string:x261>";
      }
    } else if(!isDefined(component.var_6bc907c4)) {
      errortext = "<dev string:x27b>";
    }
  } else if(missioncomponent flag::get("<dev string:x28d>")) {
    statustext = "<dev string:x28d>";
    statuscolor = (0.1, 0.1, 0.1);
  }

  textcolor = isDefined(errortext) ? (1, 0, 0) : (1, 1, 1);
  function_15462dcd(origin, textcolor, "<dev string:x21e>", identifiertext, statustext, origintext, var_4fea471b, var_fabc86d6, var_f3fe7e2c, var_2aac6b87, tacpointtext, errortext);
  recordsphere(origin, 20, statuscolor);
}

private function_3ed19fa3(gameobject, position) {
  entnum = gameobject getentitynumber();
  origin = gameobject.origin;
  identifiertext = (isDefined(gameobject gameobjects::get_identifier()) ? gameobject gameobjects::get_identifier() : "<dev string:x298>") + "<dev string:x2a5>" + entnum + "<dev string:xa2>";
  var_5f5e2bd5 = "<dev string:x2ab>" + gameobject.type + "<dev string:xa2>";
  origintext = "<dev string:x195>" + int(origin[0]) + "<dev string:x19f>" + int(origin[1]) + "<dev string:x19f>" + int(origin[2]) + "<dev string:x1a4>";
  var_7358fe8e = "<dev string:x2b3>";
  var_8de0589e = "<dev string:x2c2>";
  var_4fea471b = "<dev string:x1a9>" + function_9e72a96(gameobject.team) + "<dev string:xa2>";
  var_8dbcaed7 = "<dev string:x2d3>" + (isDefined(gameobject.absolute_visible_and_interact_team) ? function_9e72a96(gameobject.absolute_visible_and_interact_team) : "<dev string:x1df>") + "<dev string:xa2>";
  tacpointtext = "<dev string:x1fa>";
  errortext = undefined;
  var_7ddeb599 = "<dev string:x1df>";
  var_bd3388e8 = "<dev string:x1df>";
  var_d8e00365 = "<dev string:x2e4>";

  if(isDefined(gameobject.identifier)) {
    var_d8e00365 += gameobject.identifier;
  }

  var_d8e00365 += "<dev string:xa2>";
  var_ea15be8 = undefined;
  var_da71cc36 = undefined;

  if(isDefined(gameobject.e_object)) {
    var_7358fe8e = "<dev string:x2f1>" + (isDefined(gameobject.e_object.targetname) ? gameobject.e_object.targetname : "<dev string:x1df>") + "<dev string:xa2>";

    if(isDefined(gameobject.e_object.scriptbundlename)) {
      var_8de0589e = "<dev string:x2ff>" + gameobject.e_object.scriptbundlename + "<dev string:xa2>";
      gameobjectbundle = getscriptbundle(gameobject.e_object.scriptbundlename);

      if(isDefined(gameobjectbundle)) {
        var_ea15be8 = gameobjectbundle.var_4702e184;
        var_da71cc36 = gameobjectbundle.var_eba32ac6;
      }
    }
  }

  if(isDefined(gameobject.s_minigame) && isDefined(gameobject.s_minigame.var_ff3c99c5) && isDefined(gameobject.s_minigame.var_ff3c99c5.var_63e8057)) {
    foreach(location in gameobject.s_minigame.var_ff3c99c5.var_63e8057) {
      if(location.mdl_gameobject === gameobject) {
        if(isDefined(gameobject.s_minigame.var_4702e184)) {
          var_ea15be8 = gameobject.s_minigame.var_4702e184;
          var_7ddeb599 = "<dev string:x30f>";
        }

        if(isDefined(gameobject.s_minigame.var_eba32ac6)) {
          var_da71cc36 = gameobject.s_minigame.var_eba32ac6;
          var_bd3388e8 = "<dev string:x30f>";
        }

        break;
      }
    }
  }

  var_f3fe7e2c = "<dev string:x1d5>" + (isDefined(var_ea15be8) ? var_ea15be8 : "<dev string:x1df>") + "<dev string:xa2>" + var_7ddeb599;
  var_2aac6b87 = "<dev string:x1e2>" + (isDefined(var_da71cc36) ? var_da71cc36 : "<dev string:x1df>") + "<dev string:xa2>" + var_bd3388e8;
  statuscolor = gameobject.type !== "<dev string:x31d>" ? (1, 1, 1) : (0.1, 0.1, 0.1);

  if(isDefined(gameobject.trigger) && gameobject.trigger istriggerenabled()) {
    points = tacticalquery(#"stratcom_tacquery_trigger", gameobject.trigger);
    tacpointtext = "<dev string:x253>" + points.size + "<dev string:xa2>";

    if(points.size == 0) {
      errortext = "<dev string:x261>";
    }

    statuscolor = (0, 1, 1);
    function_20610c3(gameobject.trigger, statuscolor, "<dev string:x21e>");
    recordline(origin, gameobject.trigger.origin, statuscolor, "<dev string:x21e>");
    record3dtext("<dev string:x32d>", gameobject.trigger.origin + (0, 0, 5), statuscolor, "<dev string:x21e>");
  }

  textcolor = isDefined(errortext) ? (1, 0, 0) : (1, 1, 1);
  function_15462dcd(origin, textcolor, "<dev string:x21e>", identifiertext, var_5f5e2bd5, var_8de0589e, origintext, var_7358fe8e, var_4fea471b, var_8dbcaed7, var_f3fe7e2c, var_2aac6b87, tacpointtext, var_d8e00365, errortext);
  recordsphere(origin, 17, statuscolor, "<dev string:x21e>");
}

private function_adb62fbb(breadcrumb, index) {
  if(!isDefined(index)) {
    index = "<dev string:x191>";
  }

  origin = breadcrumb.origin;
  identifiertext = "<dev string:x342>" + index + "<dev string:xa2>";
  origintext = "<dev string:x195>" + int(origin[0]) + "<dev string:x19f>" + int(origin[1]) + "<dev string:x19f>" + int(origin[2]) + "<dev string:x1a4>";
  var_4fea471b = "<dev string:x1a9>" + breadcrumb.script_team + "<dev string:xa2>";
  statuscolor = (1, 1, 1);
  tacpointtext = "<dev string:x1fa>";
  errortext = undefined;

  if(isDefined(breadcrumb.trigger)) {
    statuscolor = (1, 1, 0);
    function_20610c3(breadcrumb.trigger, (1, 1, 0), "<dev string:x21e>");
    recordline(origin, breadcrumb.trigger.origin, (1, 1, 0), "<dev string:x21e>");
    record3dtext("<dev string:x350>", breadcrumb.trigger.origin, (1, 1, 0), "<dev string:x21e>");
    points = tacticalquery(#"stratcom_tacquery_trigger", breadcrumb.trigger);
    tacpointtext = "<dev string:x253>" + points.size + "<dev string:xa2>";

    if(points.size == 0) {
      errortext = "<dev string:x261>";
    }
  }

  recordsphere(origin, 14, statuscolor);
  textcolor = isDefined(errortext) ? (1, 0, 0) : (1, 1, 1);
  function_15462dcd(origin, textcolor, "<dev string:x21e>", identifiertext, origintext, var_4fea471b, tacpointtext, errortext);
}

private function_15462dcd(pos, color, channel, ...) {
  recordstr = "<dev string:x1df>";

  foreach(str in vararg) {
    if(!isDefined(str)) {
      continue;
    }

    recordstr += str + "<dev string:x364>";
  }

  record3dtext(recordstr, pos, color, channel);
}

private function_20610c3(volume, color, channel) {
  maxs = volume getmaxs();
  mins = volume getmins();

  if(issubstr(volume.classname, "<dev string:x36a>")) {
    radius = max(maxs[0], maxs[1]);
    top = volume.origin + (0, 0, maxs[2]);
    bottom = volume.origin + (0, 0, mins[2]);
    recordcircle(bottom, radius, color, channel);
    recordcircle(top, radius, color, channel);
    recordline(bottom, top, color, channel);
    return;
  }

  recordbox(volume.origin, mins, maxs, volume.angles[0], color, channel);
}

private function_35fd8254() {
  while(true) {
    if(getdvarint(#"hash_53bff1e7234da64b", 0)) {
      offset = 30;
      position = (0, 0, 0);
      xoffset = 0;
      yoffset = 10;
      textscale = 0.7;
      var_69548289 = 0;

      if(isDefined(level.var_b3d6ba87)) {
        var_69548289 = level.var_b3d6ba87.size;
      }

      recordtext("<dev string:x373>" + var_69548289, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      assaultobjects = 0;
      defendobjects = 0;
      botcount = 0;
      objectivecount = 0;
      targetcount = 0;

      for(index = 0; index < var_69548289; index++) {
        commander = level.var_b3d6ba87[index];
        assaultobjects += blackboard::getstructblackboardattribute(commander, #"gameobjects_assault").size;
        defendobjects += blackboard::getstructblackboardattribute(commander, #"gameobjects_defend").size;
        botcount += blackboard::getstructblackboardattribute(commander, #"doppelbots").size;
        objectivecount += blackboard::getstructblackboardattribute(commander, #"objectives").size;
        targetcount += commander.var_6365d720;
      }

      xoffset += 15;
      recordtext("<dev string:x387>" + botcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      recordtext("<dev string:x3a5>" + objectivecount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      recordtext("<dev string:x3b9>" + assaultobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      recordtext("<dev string:x3d6>" + defendobjects, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      recordtext("<dev string:x3f2>" + targetcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
      yoffset += 13;
      yoffset += 13;
      xoffset -= 15;
      squadcount = 0;

      for(index = 0; index < var_69548289; index++) {
        commander = level.var_b3d6ba87[index];
        squadcount += commander.squads.size;
      }

      recordtext("<dev string:x404>" + squadcount, position + (xoffset, yoffset, 0), (1, 1, 1), "<dev string:x21e>", textscale);
    }

    waitframe(1);
  }
}

private function_7712a8e4(strategy, var_a5bd84a3, var_48ce643a, doppelbots = 1, companions = 1) {
  assert(isDefined(strategy));
  var_c4c7d0bc = strategy.(var_a5bd84a3) === 1;
  var_3b9048 = var_c4c7d0bc;

  if(strategy.("customizecompanions") === 1) {
    var_3b9048 = strategy.(var_48ce643a) === 1;
  }

  if(doppelbots && companions) {
    return (var_c4c7d0bc && var_3b9048);
  } else if(doppelbots) {
    return var_c4c7d0bc;
  } else if(companions) {
    return var_3b9048;
  }

  return 0;
}

function_700c578d(bundle) {
  assert(isDefined(bundle));
  var_389ef689 = spawnStruct();

  var_389ef689.name = bundle.name;

  var_6da809dc = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
  var_e3e0ebe5 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");

  foreach(kvp in var_6da809dc) {
    if(!isDefined(bundle.(kvp))) {
      var_389ef689.(kvp) = 0;
      continue;
    }

    var_389ef689.(kvp) = bundle.(kvp);
  }

  if(bundle.("customizecompanions") === 1) {
    for(index = 0; index < var_e3e0ebe5.size; index++) {
      kvp = var_e3e0ebe5[index];

      if(!isDefined(bundle.(kvp))) {
        var_389ef689.(kvp) = 0;
        continue;
      }

      if(bundle.(kvp) === "inherit from doppelbot") {
        var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
        continue;
      }

      var_389ef689.(kvp) = bundle.(kvp);
    }
  } else {
    for(index = 0; index < var_e3e0ebe5.size; index++) {
      kvp = var_e3e0ebe5[index];
      var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
    }
  }

  return var_389ef689;
}

function_2cce6a82(entity, bundle) {
  assert(isDefined(bundle));

  if(!function_9ab82e4f(entity)) {
    return;
  }

  if(bundle.m_str_type == "escortbiped") {
    if(!isDefined(bundle.var_27726d51)) {
      return;
    }

    if(entity === bundle.var_27726d51) {
      return calculatepathtoposition(entity, entity.goalpos);
    }

    return calculatepathtoposition(entity, bundle.var_27726d51.origin);
  }
}

function_704d5fbd(bot, component) {
  assert(isDefined(component));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  switch (component.m_str_type) {
    case #"goto":
      break;
    case #"destroy":
    case #"defend":
      if(function_778568e2(bot)) {
        return calculatepathtotrigger(bot, component.var_6bc907c4);
      } else {
        return calculatepathtotrigger(bot, component.var_2956bff4);
      }

      break;
    case #"capturearea":
      return calculatepathtotrigger(bot, component.var_cc67d976);
  }
}

calculatepathtogameobject(bot, gameobject) {
  assert(isDefined(gameobject));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  if(function_778568e2(bot)) {
    return calculatepathtotrigger(bot, gameobject.trigger);
  }

  var_e61f062b = bot getpathfindingradius();
  botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);

  if(!isDefined(botposition)) {
    return;
  }

  points = querypointsaroundgameobject(bot, gameobject);

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  return _calculatepathtopoints(bot, points);
}

function_71866d71(bot, breadcrumb) {
  assert(isDefined(breadcrumb));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  var_e61f062b = bot getpathfindingradius();
  botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);

  if(!isDefined(botposition)) {
    return;
  }

  return calculatepathtotrigger(bot, breadcrumb.trigger);
}

calculatepathtoobjective(bot, objective) {
  assert(isDefined(objective));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  inair = function_778568e2(bot);
  vehicle = undefined;

  if(inair) {
    vehicle = bot getvehicleoccupied();
    botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
  } else {
    var_e61f062b = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
  }

  if(!isDefined(botposition)) {
    return;
  }

  points = querypointsinsideobjective(bot, objective);

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  if(inair) {
    return function_ee3d20f5(vehicle, points);
  }

  return _calculatepathtopoints(bot, points);
}

calculatepathtopoints(bot, points) {
  assert(isDefined(points));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  var_e61f062b = bot getpathfindingradius();
  botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);

  if(!isDefined(botposition)) {
    return;
  }

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  return _calculatepathtopoints(bot, points);
}

calculatepathtoposition(entity, position, radius = 200, halfheight = 100) {
  assert(isDefined(position));

  if(!function_9ab82e4f(entity)) {
    return;
  }

  var_e61f062b = entity getpathfindingradius();
  botposition = getclosestpointonnavmesh(entity.origin, 200, var_e61f062b);

  if(!isDefined(botposition)) {
    return;
  }

  points = querypointsinsideposition(entity, position, radius, halfheight);

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  return _calculatepathtopoints(entity, points);
}

calculatepathtotrigger(bot, trigger) {
  if(!isDefined(trigger)) {
    return;
  }

  if(!function_9ab82e4f(bot)) {
    return;
  }

  inair = function_778568e2(bot);
  vehicle = undefined;

  if(inair) {
    vehicle = bot getvehicleoccupied();
    botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
  } else {
    var_e61f062b = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
  }

  if(!isDefined(botposition)) {
    return;
  }

  points = querypointsinsidetrigger(bot, trigger);

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  if(inair) {
    return function_ee3d20f5(vehicle, points);
  }

  return _calculatepathtopoints(bot, points);
}

function_e696ce55(bot, trigger) {
  if(!isDefined(trigger)) {
    return;
  }

  if(!function_9ab82e4f(bot)) {
    return;
  }

  inair = function_778568e2(bot);
  vehicle = undefined;

  if(inair) {
    vehicle = bot getvehicleoccupied();
    botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
  } else {
    var_e61f062b = bot getpathfindingradius();
    botposition = getclosestpointonnavmesh(bot.origin, 200, var_e61f062b);
  }

  if(!isDefined(botposition)) {
    return;
  }

  points = function_210f00bf(bot, trigger);

  if(!isDefined(points) || points.size <= 0) {
    return;
  }

  if(inair) {
    return function_ee3d20f5(vehicle, points);
  }

  return _calculatepathtopoints(bot, points);
}

calculateprogressrushing(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects) {
  if(enemytotalobjects <= 0) {
    return false;
  }

  if(totalobjects <= 0) {
    return false;
  }

  gameobjectcost = 1 / totalobjects;
  enemygameobjectcost = 1 / enemytotalobjects;
  currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
  currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
  return max(min(lowerboundpercentile + currentenemygameobjectcost, 1), 0) > max(min(gameobjectcost + currentgameobjectcost, 1), 0);
}

calculateprogressthrottling(lowerboundpercentile, upperboundpercentile, destroyedobjects, totalobjects, enemydestroyedobjects, enemytotalobjects) {
  if(enemytotalobjects <= 0) {
    return true;
  }

  if(totalobjects <= 0) {
    return false;
  }

  gameobjectcost = 1 / totalobjects;
  enemygameobjectcost = 1 / enemytotalobjects;
  currentgameobjectcost = min(gameobjectcost * destroyedobjects, 1);
  currentenemygameobjectcost = min(enemygameobjectcost * enemydestroyedobjects, 1);
  return max(min(upperboundpercentile + currentenemygameobjectcost, 1), 0) < max(min(gameobjectcost + currentgameobjectcost, 1), 0);
}

function_1e3c1b91(var_b7f15515, var_5e513205) {
  assert(isDefined(var_b7f15515));
  assert(isDefined(var_5e513205));
  var_389ef689 = spawnStruct();
  var_6da809dc = array("doppelbotsignore", "doppelbotsallowair", "doppelbotsallowground", "doppelbotspriority", "doppelbotstactics", "doppelbotsfocus", "doppelbotsinteractions", "doppelbotsdistribution");
  var_e3e0ebe5 = array("companionsignore", "companionsallowair", "companionsallowground", "companionspriority", "companionstactics", "companionsfocus", "companionsinteractions", "companionsdistribution");
  assert(var_6da809dc.size == var_e3e0ebe5.size);

  foreach(kvp in var_6da809dc) {
    if(!isDefined(var_5e513205.(kvp)) || var_5e513205.(kvp) === #"hash_13275474a58f1175") {
      if(!isDefined(var_b7f15515.(kvp))) {
        var_389ef689.(kvp) = 0;
      } else {
        var_389ef689.(kvp) = var_b7f15515.(kvp);
      }

      continue;
    }

    var_389ef689.(kvp) = var_5e513205.(kvp);
  }

  if(var_5e513205.("customizecompanions") === 1) {
    for(index = 0; index < var_e3e0ebe5.size; index++) {
      kvp = var_e3e0ebe5[index];

      if(!isDefined(var_5e513205.(kvp))) {
        var_389ef689.(kvp) = 0;
        continue;
      }

      if(var_5e513205.(kvp) === "inherit from doppelbot") {
        var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
        continue;
      }

      var_389ef689.(kvp) = var_5e513205.(kvp);
    }
  } else {
    for(index = 0; index < var_e3e0ebe5.size; index++) {
      kvp = var_e3e0ebe5[index];
      var_389ef689.(kvp) = var_389ef689.(var_6da809dc[index]);
    }
  }

  return var_389ef689;
}

function_423cfbc1(side, var_ebfc3fac = undefined, missioncomponent = undefined, gameobject = undefined) {
  assert(isstring(side));
  strategy = function_d077c2b6(side);

  if(!isDefined(strategy)) {
    function_1852d313(#"default_strategicbundle", side);
    strategy = function_d077c2b6(side);
  }

  sdebug = ["<dev string:x414>" + strategy.name];

  strategy = function_1e3c1b91(strategy, strategy);

  if(isDefined(var_ebfc3fac)) {
    var_f57f0f3f = var_ebfc3fac.("scriptbundle_strategy_" + side);

    if(isDefined(var_f57f0f3f)) {
      strategy = function_1e3c1b91(strategy, getscriptbundle(var_f57f0f3f));
    }

    sdebug[sdebug.size] = var_ebfc3fac.type + "<dev string:x104>" + var_ebfc3fac.name + "<dev string:x420>" + (isDefined(var_f57f0f3f) ? var_f57f0f3f : "<dev string:x1df>");

  }

  if(isDefined(missioncomponent)) {
    var_e763ef0b = missioncomponent.("scriptbundle_strategy_" + side);

    if(isDefined(var_e763ef0b)) {
      strategy = function_1e3c1b91(strategy, getscriptbundle(var_e763ef0b));
    }

    sdebug[sdebug.size] = missioncomponent.scriptbundlename + "<dev string:x426>" + (isDefined(var_e763ef0b) ? var_e763ef0b : "<dev string:x1df>");

  }

  if(isDefined(gameobject)) {
    var_3bb544aa = 0;

    if(isDefined(gameobject.s_minigame) && isDefined(gameobject.s_minigame.var_ff3c99c5) && isDefined(gameobject.s_minigame.var_ff3c99c5.var_63e8057)) {
      foreach(location in gameobject.s_minigame.var_ff3c99c5.var_63e8057) {
        if(location.mdl_gameobject === gameobject) {
          var_3bb544aa = 1;
          var_1c9cd543 = gameobject.s_minigame.("scriptbundle_strategy_" + side);

          if(isDefined(var_1c9cd543)) {
            strategy = function_1e3c1b91(strategy, getscriptbundle(var_1c9cd543));
          }
        }

        sdebug[sdebug.size] = "<dev string:x42b>" + gameobject getentitynumber() + "<dev string:x420>" + (isDefined(var_1c9cd543) ? var_1c9cd543 : "<dev string:x1df>") + "<dev string:x30f>";

        break;
      }
    }

    if(!var_3bb544aa && isDefined(gameobject.e_object) && isDefined(gameobject.e_object.scriptbundlename)) {
      gameobjectbundle = getscriptbundle(gameobject.e_object.scriptbundlename);

      if(isDefined(gameobjectbundle)) {
        var_1c9cd543 = gameobjectbundle.("scriptbundle_strategy_" + side);

        if(isDefined(var_1c9cd543)) {
          strategy = function_1e3c1b91(strategy, getscriptbundle(var_1c9cd543));
        }
      }

      sdebug[sdebug.size] = "<dev string:x42b>" + gameobject getentitynumber() + "<dev string:x420>" + (isDefined(var_1c9cd543) ? var_1c9cd543 : "<dev string:x1df>");

    }
  }

  strategy.sdebug = sdebug;

  return strategy;
}

function_4b0c469d(vehicle) {
  assert(isDefined(vehicle) && isvehicle(vehicle));

  switch (vehicle.vehicleclass) {
    case #"helicopter":
      return "air";
    case #"4 wheel":
      return "ground";
  }

  return "ground";
}

canattackgameobject(team, gameobject) {
  return gameobject.team == team && gameobject.interactteam == #"friendly" || gameobject.team != team && gameobject.interactteam == #"enemy" || gameobject.absolute_visible_and_interact_team === team;
}

candefendgameobject(team, gameobject) {
  return gameobject.team == team && gameobject.interactteam == #"enemy" || gameobject.team != team && gameobject.interactteam == #"friendly";
}

function_a1edb007(team) {
  var_832340f2 = "sideA";

  if(util::get_team_mapping("sidea") !== team) {
    var_832340f2 = "sideB";
  }

  return var_832340f2;
}

function_5c2c9542(entity, component) {
  assert(isDefined(entity));
  assert(isDefined(component));

  switch (component.m_str_type) {
    case #"destroy":
    case #"defend":
      if(function_778568e2(entity)) {
        return component.var_6bc907c4;
      }

      return component.var_2956bff4;
    case #"capturearea":
      return component.var_cc67d976;
  }
}

function_45c5edc6(side) {
  assert(isDefined(side));

  if(!isDefined(level.var_2731863e)) {
    level.var_2731863e = [];
  } else if(!isarray(level.var_2731863e)) {
    level.var_2731863e = array(level.var_2731863e);
  }

  return level.var_2731863e[side];
}

function_d077c2b6(side) {
  assert(isDefined(side));

  if(!isDefined(level.var_aca184cd)) {
    level.var_aca184cd = [];
  } else if(!isarray(level.var_aca184cd)) {
    level.var_aca184cd = array(level.var_aca184cd);
  }

  return level.var_aca184cd[side];
}

function_a0f88aca(gpbundle, team) {
  var_832340f2 = function_a1edb007(team);
  return gpbundle.var_96f00c9f == var_832340f2 || gpbundle.var_96f00c9f == team;
}

function_778568e2(entity) {
  if(entity isinvehicle()) {
    vehicle = entity getvehicleoccupied();
    return (function_4b0c469d(vehicle) == "air");
  }

  return false;
}

function_e1b87d35(entity) {
  if(entity isinvehicle()) {
    vehicle = entity getvehicleoccupied();
    return (function_4b0c469d(vehicle) == "ground");
  }

  return false;
}

function_9ab82e4f(entity) {
  if(isactor(entity)) {
    return isalive(entity);
  }

  return isvalidbotorplayer(entity);
}

isvalidbotorplayer(client) {
  return isvalidbot(client) || isvalidplayer(client);
}

isvalidbot(bot) {
  return isDefined(bot) && isbot(bot) && bot bot::initialized() && !bot isplayinganimscripted() && ai::getaiattribute(bot, "control") === "commander" && bot bot::function_343d7ef4();
}

function_4732f860(bot) {
  if(bot isinvehicle()) {
    vehicle = bot getvehicleoccupied();
    seatnum = vehicle getoccupantseat(bot);
    return (seatnum == 0 && !isDefined(vehicle.attachedpath));
  }

  return false;
}

function_208c970d(gpbundle, var_832340f2) {
  team = util::get_team_mapping(var_832340f2);
  bundle = gpbundle.o_gpbundle;

  if(!isDefined(bundle)) {
    return false;
  }

  if(!(bundle.var_96f00c9f === var_832340f2 || bundle.var_96f00c9f === team || bundle.var_eb371c04 === var_832340f2 || bundle.var_eb371c04 === team)) {
    return false;
  }

  if(!bundle flag::get("bundle_initialized")) {
    return false;
  }

  type = gpbundle.classname;

  switch (type) {
    case #"hash_1c67b29f3576b10d":
      if(!isDefined(bundle.var_27726d51)) {
        return false;
      }

      if(!isDefined(bundle.var_27726d51.mdl_gameobject)) {
        return false;
      }

      break;
    default:
      return false;
  }

  return true;
}

isvalidplayer(client) {
  return isDefined(client) && !isbot(client) && isplayer(client) && !client isinmovemode("ufo", "noclip");
}

function_f867cce0(missioncomponent, commanderteam) {
  component = missioncomponent.var_36f0c06d;
  assert(commanderteam == #"any" || commanderteam == #"allies" || commanderteam == #"axis", "<dev string:x43c>" + commanderteam + "<dev string:x44f>");

  if(!isDefined(component)) {
    return false;
  }

  if(!missioncomponent flag::get("enabled")) {
    return false;
  }

  if(missioncomponent flag::get("complete")) {
    return false;
  }

  if(component.m_str_team !== commanderteam && component.m_str_team != #"any") {
    if(!isDefined(missioncomponent.var_3093fd62) || missioncomponent.var_3093fd62 == 0) {
      return false;
    }
  }

  type = missioncomponent.scriptbundlename;

  switch (type) {
    case #"hash_6e9081699001bcd9":
      break;
    case #"hash_3bf68fbcb5c53b6c":
      break;
    case #"hash_4984fd4b0ba666a2":
      break;
    default:
      return false;
  }

  return true;
}

querypointsaroundgameobject(bot, gameobject) {
  assert(isDefined(gameobject));

  if(!function_9ab82e4f(bot)) {
    return;
  }

  points = array();

  if(isDefined(gameobject) && isDefined(gameobject.trigger)) {
    points = tacticalquery(#"stratcom_tacquery_gameobject", gameobject.trigger);
  }

  if(getdvarint(#"ai_debugsquadpointquery", 0)) {
    foreach(point in points) {
      recordstar(point.origin, (1, 0.5, 0), "<dev string:x21e>");
    }
  }

  return points;
}

querypointsinsideobjective(bot, trigger) {
  assert(isDefined(trigger));

  if(!function_9ab82e4f(bot)) {
    return [];
  }

  points = [];

  if(function_778568e2(bot)) {
    vehicle = bot getvehicleoccupied();
    botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
    radius = distance2d(trigger.maxs, (0, 0, 0));
    query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);

    if(isDefined(query) && isDefined(query.data)) {
      points = query.data;
    }
  } else {
    points = tacticalquery(#"stratcom_tacquery_objective", trigger);

    if(getdvarint(#"ai_debugsquadpointquery", 0)) {
      foreach(point in points) {
        recordstar(point.origin, (1, 0.5, 0), "<dev string:x21e>");
      }
    }

  }

  return points;
}

querypointsinsideposition(bot, position, radius, halfheight) {
  assert(isDefined(position));

  if(!function_9ab82e4f(bot)) {
    return [];
  }

  cylinder = ai::t_cylinder(position, radius, halfheight);
  points = tacticalquery(#"stratcom_tacquery_position", cylinder);

  if(getdvarint(#"ai_debugsquadpointquery", 0)) {
    foreach(point in points) {
      recordstar(point.origin, (1, 0.5, 0), "<dev string:x21e>");
    }
  }

  return points;
}

private function_1891d0d2(points, obb) {
  var_2586092e = 50;
  var_c2a08848 = 0;

  while(var_c2a08848 < var_2586092e) {
    if(getdvarint(#"ai_debugsquadpointquery", 0)) {
      recordbox(obb.center, obb.halfsize * -1, obb.halfsize, obb.angles[1], (0, 1, 0), "<dev string:x21e>");

      foreach(point in points) {
        recordstar(point.origin, (1, 0.5, 0), "<dev string:x21e>");
      }
    }

    var_c2a08848++;
    waitframe(1);
  }
}

querypointsinsidetrigger(bot, trigger) {
  assert(isDefined(trigger));

  if(!function_9ab82e4f(bot)) {
    return [];
  }

  points = [];

  if(function_778568e2(bot)) {
    vehicle = bot getvehicleoccupied();
    botposition = vehicle getclosestpointonnavvolume(vehicle.origin, 200);
    radius = distance2d(trigger.maxs, (0, 0, 0));
    query = positionquery_source_navigation(trigger.origin, 0, radius, trigger.maxs[2], 100, vehicle);

    if(isDefined(query) && isDefined(query.data)) {
      points = query.data;
    }
  } else {
    obb = bot bot::function_f0c35734(trigger);
    points = tacticalquery(#"stratcom_tacquery_trigger", obb);

    level thread function_1891d0d2(points, obb);

  }

  return points;
}

function_210f00bf(bot, trigger) {
  assert(isDefined(trigger));

  if(!function_9ab82e4f(bot)) {
    return [];
  }

  points = [];

  if(function_778568e2(bot)) {
    assert(0, "<dev string:x46d>");
  } else {
    obb = bot bot::function_52947b70(trigger);
    points = tacticalquery(#"stratcom_tacquery_trigger", obb);

    level thread function_1891d0d2(points, obb);

  }

  return points;
}

function_ba05bd2(strategicbundle, side) {
  assert(isDefined(side));

  if(!isDefined(level.var_2731863e)) {
    level.var_2731863e = [];
  } else if(!isarray(level.var_2731863e)) {
    level.var_2731863e = array(level.var_2731863e);
  }

  strategy = getscriptbundle(strategicbundle);

  if(isDefined(strategy) && isDefined(side)) {
    level.var_2731863e[side] = strategicbundle;
    function_1852d313(strategicbundle, side);
  }
}

function_3837a75d(side) {
  assert(isDefined(side));

  if(isDefined(level.var_2731863e) && isDefined(level.var_2731863e[side])) {
    function_1852d313(level.var_2731863e[side], side);
  }
}

function_1852d313(strategicbundle, side) {
  assert(isDefined(side));

  if(!isDefined(level.var_aca184cd)) {
    level.var_aca184cd = [];
  } else if(!isarray(level.var_aca184cd)) {
    level.var_aca184cd = array(level.var_aca184cd);
  }

  strategy = getscriptbundle(strategicbundle);

  if(isDefined(strategy) && isDefined(side)) {
    level.var_aca184cd[side] = function_700c578d(strategy);
  }
}

function_f4921cb3(var_6d1ae0e2) {
  focuses = array();

  switch (var_6d1ae0e2) {
    case #"hash_617966a33a6bad2b":
      focuses[focuses.size] = #"hash_617966a33a6bad2b";
      break;
    case #"follow player":
      focuses[focuses.size] = #"follow player";
      break;
    case #"hash_a465dbf9320e821":
      focuses[focuses.size] = #"hash_617966a33a6bad2b";
      focuses[focuses.size] = #"follow player";
      break;
    case #"hash_964e75ec7937916":
      focuses[focuses.size] = #"hash_964e75ec7937916";
      break;
    case #"hash_64a01d6e814c8dc":
      focuses[focuses.size] = #"hash_64a01d6e814c8dc";
      break;
    case #"hash_584bf5a5b6fe57ca":
      focuses[focuses.size] = #"hash_964e75ec7937916";
      focuses[focuses.size] = #"hash_64a01d6e814c8dc";
      break;
    case #"hash_833af17ffa224fe":
      focuses[focuses.size] = #"hash_617966a33a6bad2b";
      focuses[focuses.size] = #"hash_964e75ec7937916";
      break;
    case #"hash_692e498c8008c994":
      focuses[focuses.size] = #"follow player";
      focuses[focuses.size] = #"hash_64a01d6e814c8dc";
      break;
    case #"objective":
      focuses[focuses.size] = #"objective";
      break;
  }

  return focuses;
}

function_f59ca353(strategy, doppelbots = 1, companions = 1) {
  return function_7712a8e4(strategy, "doppelbotsignore", "companionsignore", doppelbots, companions);
}

function_698a5382(strategy, doppelbots = 1, companions = 1) {
  return function_7712a8e4(strategy, "doppelbotsallowair", "companionsallowair", doppelbots, companions);
}

function_54032f13(strategy, doppelbots = 1, companions = 1) {
  return function_7712a8e4(strategy, "doppelbotsallowground", "companionsallowground", doppelbots, companions);
}