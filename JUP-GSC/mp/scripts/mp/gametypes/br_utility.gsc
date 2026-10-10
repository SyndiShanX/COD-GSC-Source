/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_utility.gsc
**************************************************/

#using script_40e63dd222434655;
#using script_64acb6ce534155b7;
#using script_72af5a878a9d3397;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\team_assimilation;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#namespace br_utility;

function rankedquittimer(var_3c0c203df6f6b6c5) {
  player = self;
  level endon("game_ended");
  level endon("all_players_dead");
  player endon("br_player_revived");
  player endon("disconnect");
  player notify("rankedQuitTimer_started");
  player endon("rankedQuitTimer_started");

  if(scripts\mp\teams::getactiveteamcount() > 1) {
    remainingtime = ter_op(istrue(var_3c0c203df6f6b6c5), 3000, 180000);
    var_b87edaf5a7d50525 = istrue(var_3c0c203df6f6b6c5);
    timestart = gettime();
    timeend = timestart + remainingtime;

    while(remainingtime > 0) {
      player setclientomnvar("ui_league_play_br_leave_penalty_timer", remainingtime);
      remainingtime = timeend - gettime();

      if(!istrue(var_b87edaf5a7d50525) && scripts\mp\gametypes\br::isbrteameliminated(player.team)) {
        var_b87edaf5a7d50525 = 1;
        timeend = min(timeend, timestart + 3000);
      }

      wait 1;
    }
  }

  player setclientomnvar("ui_league_play_br_leave_penalty_timer", 0);
  player setclientomnvar("ui_league_play_br_can_leave_with_party", istrue(var_3c0c203df6f6b6c5));
}

function function_b5b049c4b47cf929() {
  return 3000;
}

function markplayeraseliminated(player, context) {
  if(istrue(player.br_iseliminated)) {
    return;
  }

  player function_b6371a65209a055f(1, context);
  player.br_iseliminated = 1;
  player.var_14110ad8d5069e7 = gettime();
  level notify("br_player_eliminated");

  if(istrue(level.var_77907d733abe8b63)) {
    player setclientomnvar("ui_leagueplay_allow_quit", 0);
    player setclientomnvar("ui_league_play_br_leave_penalty_timer", 180000);
    player thread rankedquittimer(scripts\mp\gametypes\br::isbrteameliminated(player.team));
  }

  namespace_92443376a63aa4bd::onmarkplayeraseliminated(player, 1);
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onMarkPlayerAsEliminated", player);

  if(getdvarint(@ "hash_82bde055b11e6698", 0) == 0) {
    thread namespace_1eb3c4e0e28fac71::function_74e0aae435a09a51(self);
  }

  if(scripts\cp_mp\utility\game_utility::function_6910a4c65560c44b() && isai(player)) {
    player thread namespace_bc2665cbe6cf4e1f::function_f6e88d354cb8d3cd();
  }

  player scripts\mp\gametypes\br_utility::updateplayereliminatedomnvar(context);
  player scripts\mp\gamelogic::updateplayerleaderboardstats();
}

function unmarkplayeraseliminated(player, context) {
  player function_b6371a65209a055f(0, context);
  player.br_iseliminated = 0;
  player.var_14110ad8d5069e7 = -1;
  namespace_92443376a63aa4bd::onmarkplayeraseliminated(player, 0);
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onUnmarkPlayerAsEliminated", player);
  player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  player notify("br_player_revived");
  player setclientomnvar("ui_leagueplay_allow_quit", 3);
  player setclientomnvar("ui_league_play_br_leave_penalty_timer", -1);
  player updateplayereliminatedomnvar(context);
}

function updateplayereliminatedomnvar(context) {
  player = self;
  packedvalue = 0;
  var_95bfd92292381a4c = 0;

  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    teammates = scripts\mp\utility\teams::getsquadmates(player.team, player.sessionsquadid, 0);
    var_bf873008edc8415f = level.maxsquadsize;
  } else {
    teammates = scripts\mp\utility\teams::getteamdata(player.team, "players");

    if(scripts\mp\team_assimilation::function_6934349b7823d888()) {
      var_bf873008edc8415f = scripts\mp\team_assimilation::getmaxassimilationteamsize();
    } else {
      var_bf873008edc8415f = level.maxteamsize;
    }
  }

  foreach(member in teammates) {
    if(getdvarint(@ "hash_f817c06d779ec53c", 0)) {
      if(!isDefined(context)) {
        context = "?";
      }

      logstring("updatePlayerEliminatedOmnvar - time = " + gettime() + ", player = " + member.name + ", team = " + member.team + ", marked player = " + (member == self) + ", br_isEliminated = " + istrue(member.br_iseliminated) + ", context = " + context + ", sessionuimemberindex = " + member.sessionuimemberindex);
    }

    assert(member.sessionuimemberindex <= var_bf873008edc8415f);

    if(istrue(member.br_iseliminated)) {
      packedvalue |= 1 << member.sessionuimemberindex;
    }

    if(istrue(member.extracted)) {
      var_95bfd92292381a4c |= 1 << member.sessionuimemberindex;
    }
  }

  foreach(member in teammates) {
    member setclientomnvar("ui_br_eliminated", packedvalue);
    member setclientomnvar("ui_br_extracted", var_95bfd92292381a4c);
  }

  validgametype = !(isDefined(level.brgametype) && (istrue(level.brgametype.var_b43745b85f249e68) || level.brgametype.name == "resurgence")) && level.gametype != "ob" && level.gametype != "ob_rift_run";

  if(istrue(level.matchmakingmatch) && validgametype) {
    if(getdvarint(@ "hash_4c7f9021e6dc110d", 1) == 1) {
      if(isDefined(teammates) && teammates.size > 0) {
        omnvarvalue = 2;

        foreach(member in teammates) {
          if(isDefined(member) && !istrue(member.br_iseliminated)) {
            omnvarvalue = 0;
            break;
          }
        }

        foreach(member in teammates) {
          if(istrue(member.extracted)) {
            continue;
          }

          member setclientomnvar("ui_br_squad_eliminated_active", omnvarvalue);
        }
      }

      return;
    }

    fireteammembers = player getfireteammembers();

    if(isDefined(fireteammembers) && fireteammembers.size > 0) {
      omnvarvalue = 2;

      foreach(member in fireteammembers) {
        if(isDefined(member) && !istrue(member.br_iseliminated)) {
          omnvarvalue = 0;
          break;
        }
      }

      if(getdvarint(@ "hash_f817c06d779ec53c", 0) && omnvarvalue > 0) {
        if(!isDefined(context)) {
          context = "?";
        }

        logstring("updatePlayerEliminatedOmnvar - time = " + gettime() + ", context = " + context + ", set ui_br_squad_eliminated_active to " + omnvarvalue);
      }

      player setclientomnvar("ui_br_squad_eliminated_active", omnvarvalue);

      foreach(member in fireteammembers) {
        member setclientomnvar("ui_br_squad_eliminated_active", omnvarvalue);
      }
    }
  }
}

function function_8311407ea8b66f9a(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(getdvarint(@ "hash_11fa4c3ab4c1653d", 1) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    victimnum = "e?";
    meansofdeath = "m?";
    attackernum = "a?";
    inflictornum = "i?";
    attackerloc = "l?";

    if(isDefined(self)) {
      victimnum = self getentitynumber();
    }

    if(isDefined(smeansofdeath)) {
      meansofdeath = smeansofdeath;
    }

    if(isDefined(attacker) && !isstruct(attacker)) {
      attackernum = attacker getentitynumber();
      attackerloc = "( " + attacker.origin[0] + "," + attacker.origin[1] + "," + attacker.origin[2] + " )";
    }

    if(isDefined(einflictor)) {
      inflictornum = einflictor getentitynumber();
    }

    stringref = "*-- Kill: " + gettime() + ", ";
    stringref += victimnum + ", ";
    stringref += meansofdeath + ", ";
    stringref += attackernum + ", ";
    stringref += inflictornum + ", ";
    stringref += attackerloc;
    logstring(stringref);
  }
}

function function_b6371a65209a055f(waseliminated, context) {
  if(getdvarint(@ "hash_11fa4c3ab4c1653d", 1) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    stringref = ter_op(istrue(waseliminated), "*-- Mark: ", "*-- Unmark: ") + gettime() + ", ";
    stringref += ter_op(isDefined(self), self getentitynumber(), "?") + ", ";
    stringref += ter_op(isDefined(context), context, "?");
    logstring(stringref);
  }
}

function function_b5483af58ee9f2c3(var_ad8aec47e1a86534, team, context) {
  if(getdvarint(@ "hash_11fa4c3ab4c1653d", 1) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    stringref = ter_op(istrue(var_ad8aec47e1a86534), "*-- Add: ", "*-- Remove: ") + gettime() + ", ";
    stringref += ter_op(isDefined(self), self getentitynumber(), "?") + ", " + team + ", ";
    stringref += ter_op(isDefined(context), context, "none");
    logstring(stringref);
  }
}

function printteameliminated(team) {
  if(getdvarint(@ "hash_11fa4c3ab4c1653d", 1) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    stringref = "*-- Team Elim: " + gettime() + ", " + team;
    logstring(stringref);
  }
}

function function_22a0e95dd4174c81() {
  index = 0;
  var_54b25677aaa042bd = [];

  foreach(player in level.players) {
    if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }

    var_54b25677aaa042bd[index] = player;
    index++;
  }

  return var_54b25677aaa042bd;
}

function function_fd357ca89e5e29d9() {
  if(self function_9cc921a57ff4deb5() || isDefined(self.var_33cb9daa5bf01ec1)) {
    self function_61195b9ee307ad14();
    self notify("ascender_cancel");
    self notify("ascender_solo_cancel");
  }
}

function function_6fefb971fa5338b8() {
  if(scripts\mp\utility\game::getsubgametype() == "zonecontrol") {
    return;
  }

  var_1852da5050d81f13 = getentitylessscriptablearray("zc_cluster", "targetname");

  foreach(cluster in var_1852da5050d81f13) {
    ents = getEntArray(cluster.target, "targetname");

    foreach(ent in ents) {
      ent delete();
    }

    ents = function_f159c10d5cf8f0b4(cluster.target, "targetname");

    foreach(ent in ents) {
      ent delete();
    }
  }
}