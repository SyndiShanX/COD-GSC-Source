/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2cf4d0a5e1f4c42d.gsc
*************************************************/

#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\utility\teams;
#namespace laststand;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction);
}

function evaluatescore(bot) {
  if(istrue(bot.inlaststand)) {
    return 999;
  }

  return 0;
}

function createaction(squadmaster) {
  return createactionbase("laststand", undefined, "main", "", &actionprocess, self);
}

function actionprocess(bot) {
  assert(istrue(bot.inlaststand));

  while(true) {
    teammate = undefined;

    if(!scripts\mp\gametypes\br_circle_util::ispointindangercircle(bot.origin)) {
      nextpoint = bot function_c42a53b48c0a683e();
      var_e5dc471579d90471 = 0;
    } else {
      teammate = function_4f3ea8c58542178a(bot);
      nextpoint = function_a0bb005ec23fa9af(bot, teammate);
      var_e5dc471579d90471 = isDefined(teammate) && nextpoint == teammate.origin;
    }

    if(!isDefined(nextpoint)) {
      point = scripts\mp\gametypes\br_circle::getrandompointincircle(bot.origin, 200, 0.5, 1, 1, 1);
      nextpoint = bot getclosestreachablepointonnavmesh(point);
    }

    bot setscriptgoal(nextpoint, 32);
    msg = bot waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(msg == "bad_path") {
      function_f3cf203834e48c6d("<dev string:x1c>");

      continue;
    }

    if(msg == "goal" && var_e5dc471579d90471) {
      function_f3cf203834e48c6d("<dev string:x2b>");

      var_556ab897cc3c3788 = 4096;

      while(isvalidplayer(teammate)) {
        var_be8bb7e6270b5a4a = distancesquared(teammate.origin, bot.origin);

        if(var_be8bb7e6270b5a4a > var_556ab897cc3c3788) {
          break;
        }

        ret = bot waittill_any_in_array_or_timeout(["last_stand_revived"], 1);

        if(ret == "last_stand_revived") {
          return;
        }
      }

      function_f3cf203834e48c6d("<dev string:x40>");
    }
  }
}

function function_a0bb005ec23fa9af(bot, teammate) {
  attacker = undefined;

  if(isDefined(bot.laststandattacker) && isvalidplayer(bot.laststandattacker)) {
    attacker = bot.laststandattacker;
  }

  nextpoint = undefined;

  if(isDefined(teammate) && isDefined(attacker) && function_cf7b2c0abeafba37(bot, teammate, attacker)) {
    nextpoint = teammate.origin;
  } else if(isDefined(attacker)) {
    var_d043251c1c5ff583 = 200;
    point = bot.origin + vectorNormalize(bot.origin - attacker.origin) * var_d043251c1c5ff583;
    nextpoint = bot getclosestreachablepointonnavmesh(point);
  } else if(isDefined(teammate)) {
    nextpoint = teammate.origin;
  }

  return nextpoint;
}

function function_4f3ea8c58542178a(bot) {
  var_365493582892e9a2 = 2214144;
  var_2da15eee6b62525c = 0;
  teammateclosest = undefined;
  players = scripts\mp\utility\teams::getteamdata(bot.team, "alivePlayers");

  foreach(teammate in players) {
    if(teammate == bot) {
      continue;
    }

    if(!isvalidplayer(teammate)) {
      continue;
    }

    dist = distancesquared(teammate.origin, bot.origin);

    if(dist > var_365493582892e9a2) {
      continue;
    }

    if(!isDefined(teammateclosest) || dist < var_2da15eee6b62525c) {
      teammateclosest = teammate;
      var_2da15eee6b62525c = dist;
    }
  }

  return teammateclosest;
}

function function_cf7b2c0abeafba37(bot, closestteammate, attacker) {
  dirtoattacker = vectorNormalize(attacker.origin - bot.origin);
  var_16cbde366e22c3ad = vectorNormalize(closestteammate.origin - bot.origin);
  return vectordot(dirtoattacker, var_16cbde366e22c3ad) < 0;
}