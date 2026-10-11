/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_26ccbfe3954cacf4.gsc
*************************************************/

#using script_26ccbfe3954cacf4;
#using script_2e6a95dfe7dfc5f8;
#using script_40e63dd222434655;
#using script_44f4640b93ab1b47;
#using script_4c9bd9a3bf3f8cf7;
#using script_59ff79d681bb860c;
#using script_5bab271917698dc4;
#using script_72af5a878a9d3397;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace manager;

function initialize(var_9f4a3632d9f75d32) {
  if(!isenabled()) {
    return;
  }

  assert(isDefined(var_9f4a3632d9f75d32));
  level.var_7b37b2193f163b9b = spawnStruct();
  level.var_7b37b2193f163b9b.dormantbots = [];
  level.var_7b37b2193f163b9b.uibots = [];
  level.var_7b37b2193f163b9b.var_9f4a3632d9f75d32 = var_9f4a3632d9f75d32;
  thread function_9d31b1338e2f80e8();
  thread function_821a6fdd1d60d2af();
  thread function_c9b0122de1017d85();
  thread function_494150569261c828();
  thread function_9f9e27bf69291e6d();

  if(istrue(level.usegulag) && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("gulag")) {
    thread function_5b2b7905d2d6b349();
  }

  if(getdvarint(@ "hash_79500dabf3e1a102", 1) && function_a0e0c0e1e94630f6()) {
    thread function_c596173d88d8446e();
  }

  namespace_4ad0bd66eaa05ae7::function_360128ec8c9d243();

  if(getdvarint(@ "hash_429176496a1b2fd8", 0)) {
    thread function_a93242f2e58447b3();
  }

  thread function_f19131452f7b839a();
}

function isenabled() {
  if(getDvar(@ "hash_12e53040d5281856", "") == "scripted") {
    return false;
  }

  return getdvarint(@ "hash_b7fcb658021d7931", 1) == 1;
}

function onplayerconnect(player) {
  assert(isenabled());

  if(isDefined(player.var_5876cd9fc14af731) && isDefined(player.var_5876cd9fc14af731.clientmatchdataid)) {
    player.clientmatchdataid = player.var_5876cd9fc14af731.clientmatchdataid;
  }
}

function onplayerdisconnect(player) {
  assert(isenabled());

  if(isDefined(player.var_b8e75e4315698cd)) {
    player.var_b8e75e4315698cd.clientmatchdataid = player.clientmatchdataid;
    player.var_b8e75e4315698cd = undefined;
  }
}

function isteameliminated(team) {
  alivecount = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(alivecount > 0) {
    return 0;
  }

  return scripts\mp\gametypes\br::function_227ca42a35b0398b(team);
}

function function_a93242f2e58447b3() {
  level endon("game_ended");

  if(level.br_infils_disabled) {
    level waittill("spawned_bots");
  } else {
    level waittill("br_circle_set");
  }

  while(true) {
    logstring("[DumpBots] start");
    uibotcount = level.var_7b37b2193f163b9b.uibots.size;
    alivebots = 0;
    alivehuman = 0;
    activeteams = [];
    curtime = gettime();

    foreach(player in level.players) {
      if(!isDefined(player) || player iseliminated()) {
        continue;
      }

      if(player isuibot()) {
        continue;
      }

      activeteams[player.team] = 1;

      if(isbot(player)) {
        alivebots++;
        continue;
      }

      alivehuman++;
    }

    alivecount = alivebots + alivehuman;
    logstring("Time:" + curtime + ", TotalPlayers:" + alivecount + uibotcount + ", AliveHumans:" + alivehuman + ", AliveBots:" + alivebots + uibotcount + ", UIBots:" + uibotcount);

    if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
      logstring("Circle:" + level.br_circle.circleindex + " origin:" + level.br_circle.dangercircleent.origin);
    }

    logstring("IsGulagShutDown:" + scripts\mp\gametypes\br::isgulagshutdown());

    if(level.var_7b37b2193f163b9b.uibots.size > 0) {
      logstring("[DumpUIBots] start");

      foreach(bot in level.var_7b37b2193f163b9b.uibots) {
        logstring("[Dump UIBot] name:" + bot.name + " locked:" + bot.locked + " team:" + bot.team);
        namespace_c50b30148766aa59::function_b3bb8f282b894dad(bot.team);
      }

      logstring("[DumpUIBots] end");
    }

    logstring("[DumpActiveTeams] start");

    foreach(team, v in activeteams) {
      logstring("team:" + team);
      players = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");

      foreach(player in players) {
        speed = length(player getvelocity());
        status = ter_op(isbot(player) && isDefined(player.status), player.status, "");
        logstring("[Dump player] name:" + player.name + " origin:" + player.origin + " health:" + player.health + " speed:" + speed + " status:" + status);

        if(isbot(player)) {
          if(!isDefined(player.lastposition) || distancesquared(player.origin, player.lastposition) > 10) {
            player.var_b012001b3448e7c7 = curtime;
          }

          player.lastposition = player.origin;

          if(isDefined(player.var_b012001b3448e7c7) && curtime - player.var_b012001b3448e7c7 > 10000) {
            logstring("[Dump player] STUCKED!!! lastTimeHaveMove:" + player.var_b012001b3448e7c7 - level.starttime + " stuck time:" + curtime - player.var_b012001b3448e7c7);

            line(player.origin - (0, 0, 3000), player.origin + (0, 0, 5000), (1, 0, 0), 1, 0, 50);
            print3d(player.origin + (0, 0, 3000), "<dev string:x1c>", (1, 0, 0), 1, 20, 50, 1);
          }
        }
      }
    }

    logstring("[DumpActiveTeams] end");
    level waittill_any_in_array_or_timeout(["ui_bot_counter_updated", "updatePlayerAndTeamCountUI"], 1);
  }
}

function function_5b2b7905d2d6b349() {
  level endon("game_ended");

  if(level.br_infils_disabled) {
    level waittill("spawned_bots");
  } else {
    level waittill("br_circle_set");
  }

  timeout = getdvarint(@ "hash_5d346678d4fb1795", 30000);

  while(!scripts\mp\gametypes\br::isgulagshutdown()) {
    if(level.var_7b37b2193f163b9b.uibots.size == 0) {
      wait 1;
      continue;
    }

    player = function_baaa373e746b0672();

    if(isDefined(player)) {
      if(gettime() - player.jailtime > timeout) {
        arenaindex = player function_7c6f438b4f3922cb();
        namespace_c50b30148766aa59::killsome(1, 1, "DeployUIBotIntoGulag", arenaindex);
      }
    }

    wait 1;
  }
}

function private function_baaa373e746b0672() {
  targetplayer = undefined;
  var_1001a564e09ea44a = undefined;

  foreach(arena in level.gulag.arenas) {
    foreach(match in arena.matches) {
      if(match.size != 1) {
        continue;
      }

      player = match[0];

      if(!isDefined(player) || isbot(player)) {
        continue;
      }

      if(!isDefined(var_1001a564e09ea44a) || player.jailtime < var_1001a564e09ea44a) {
        var_1001a564e09ea44a = player.jailtime;
        targetplayer = player;
      }
    }
  }

  return targetplayer;
}

function private function_7c6f438b4f3922cb() {
  if(!isDefined(self.arena)) {
    return undefined;
  }

  for(i = 0; i < level.gulag.arenas.size; i++) {
    if(level.gulag.arenas[i] == self.arena) {
      return i;
    }
  }

  return undefined;
}

function tryrecycle(recycletype, shouldgiveweapon) {
  if(!isinitialized()) {
    return 0;
  }

  assert(isDefined(recycletype));
  var_cc9d656efb786a8b = undefined;
  recyclereason = undefined;

  switch (recycletype) {
    case 0:
      dist2d = getdvarint(@ "hash_81156fddeb6b5508", 5900);
      dist2dsq = dist2d * dist2d;
      height = getdvarint(@ "hash_b51792a54d2cc6df", 5900);

      if(namespace_c4ef709c036dc4a8::function_b2502f3345564abf(dist2dsq, height, 0) && !hasspectator()) {
        var_cc9d656efb786a8b = 0;
        recyclereason = "landing position meets the range [2D dist = " + dist2d + ", height = " + height + "] and not witnessed";
        namespace_c4ef709c036dc4a8::function_89b861aa78808ed8();
      }

      break;
    case 1:
      if(function_5cb1c8ec264fbdbd(self) == 0) {
        var_cc9d656efb786a8b = 1;
        recyclereason = "prematch active player count limit";
      }

      break;
    case 2:
      if(function_dc1089b7b817790e() < 0) {
        var_cc9d656efb786a8b = 1;
        recyclereason = "infil active bot count limit";
      }

      break;
    case 3:
      if(!function_16a5388d4963e316() && !hasspectator()) {
        if(!namespace_c50b30148766aa59::function_b2502f3345564abf()) {
          self dodamage(self.health + 10000, self.origin, self);
          return 0;
        } else {
          var_cc9d656efb786a8b = 1;
          recyclereason = "parachute stuck at " + self.origin;
        }
      }

      break;
    case 4:
      if(!function_16a5388d4963e316() && !hasspectator()) {
        if(!namespace_c50b30148766aa59::function_b2502f3345564abf()) {
          self dodamage(self.health + 10000, self.origin, self);
          return 0;
        } else {
          var_cc9d656efb786a8b = 1;
          recyclereason = "off_navmesh and not witnessed.";
        }
      }

      break;
    default:
      break;
  }

  if(isDefined(var_cc9d656efb786a8b) && !function_5f352fb76c54705c()) {
    if(shouldgiveweapon) {
      function_532c9aa14c794ff(function_3032314d524a3487());
    }

    if(var_cc9d656efb786a8b) {
      return namespace_c50b30148766aa59::recycle(recyclereason);
    } else {
      return namespace_c4ef709c036dc4a8::recycle(recyclereason);
    }

    return;
  }

  return 0;
}

function isinitialized() {
  return isDefined(level.var_7b37b2193f163b9b);
}

function function_d012729eac1e7053() {
  return isDefined(self.uibot) && istrue(self.uibot.var_d012729eac1e7053);
}

function isuibot() {
  return isDefined(self.uibot) && (istrue(self.uibot.isuibot) || istrue(self.uibot.var_7dbb8165d792b06c));
}

function function_3ae9c05025cbac2d() {
  return isDefined(self.uibot) && istrue(self.uibot.var_7dbb8165d792b06c);
}

function hasspectator() {
  spectators = scripts\mp\gametypes\br_spectate::getspectatorsofplayer(self);
  return spectators.size > 0;
}

function function_749723c2a45a0233() {
  if(isinitialized()) {
    return level.var_7b37b2193f163b9b.uibots;
  }

  return [];
}

function function_1bbd21d289ba8a92() {
  if(isinitialized()) {
    return level.var_7b37b2193f163b9b.uibots.size;
  }

  return 0;
}

function private function_9d31b1338e2f80e8() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    if(isDefined(player)) {
      if(isbot(player)) {
        if(!isDefined(player.uibot)) {
          player.uibot = spawnStruct();
        }

        player thread namespace_c4ef709c036dc4a8::thinkthread();
        continue;
      }

      player.engageinfo = spawnStruct();
    }
  }
}

function private function_821a6fdd1d60d2af() {
  level endon("game_ended");
  level childthread function_bcef157dfcf2c5f3();
  level childthread function_1e0804e806447a25();
}

function private function_bcef157dfcf2c5f3() {
  if(istrue(level.skipprematch)) {
    return;
  }

  level waittill("player_spawned");

  while(scripts\mp\gamelogic::inprematch()) {
    remainingslots = function_5cb1c8ec264fbdbd();
    namespace_c50b30148766aa59::activatesome(remainingslots, "Skydive", "SpawnInPrematch");
    wait 1;
  }

  var_e88f02ac1f526a32 = function_dc1089b7b817790e();

  if(var_e88f02ac1f526a32 < 0) {
    foreach(player in level.players) {
      if(isbot(player) && !player isuibot()) {
        success = player namespace_c50b30148766aa59::recycle("infil active bot count limit");

        if(success) {
          var_e88f02ac1f526a32++;

          if(var_e88f02ac1f526a32 == 0) {
            break;
          }
        }
      }
    }

    return;
  }

  if(var_e88f02ac1f526a32 > 0) {
    level waittill("br_c130_in_bounds");
    namespace_c50b30148766aa59::function_33227166f85d1aea(var_e88f02ac1f526a32, "Skydive", "ActivateUIBotsAfterPrematch");
  }
}

function private function_5cb1c8ec264fbdbd(excludeplayer) {
  assert(scripts\mp\gamelogic::inprematch());
  activeplayercount = 0;

  foreach(player in level.players) {
    if(isDefined(player) && (!isDefined(excludeplayer) || excludeplayer != player)) {
      if(!isbot(player) || !player isuibot()) {
        activeplayercount++;
      }
    }
  }

  remainingslots = function_d6d3f0e8a701880f() - activeplayercount;

  if(remainingslots < 0) {
    remainingslots = 0;
  }

  return remainingslots;
}

function private function_d6d3f0e8a701880f() {
  return getdvarint(@ "hash_e82992eec48cf830", 20);
}

function private function_dc1089b7b817790e() {
  var_1e9700821627ab11 = function_1b34e035241a60e7();
  var_1745f9ff57437be9 = int(var_1e9700821627ab11 * clamp(getdvarfloat(@ "hash_a9691c347e9bb21c", 1), 0, 1));
  return var_1745f9ff57437be9 - var_1e9700821627ab11 - level.var_7b37b2193f163b9b.uibots.size;
}

function private function_1b34e035241a60e7() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return getdvarint(@ "hash_116700c9b39c1eba", 0);
  }

  botcount = 0;
  partymembers = getpartyinfo();

  foreach(memberinfo in partymembers) {
    if(memberinfo.isai) {
      botcount++;
    }
  }

  return botcount;
}

function private function_1e0804e806447a25() {
  if(istrue(level.br_infils_disabled)) {
    level waittill("player_spawned");
  } else {
    level waittill("br_c130_left_bounds");
  }

  var_865c2dbd684c82cd = getdvarint(@ "hash_e7e9bb130c1ca431", 0);

  if(var_865c2dbd684c82cd) {
    thread function_e89eaa436ffad5a4();
  }

  updateinterval = 1;

  while(true) {
    hashuman = 0;
    var_afdc93e504789c3d = 0;
    validhumanplayers = [];

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player)) {
        continue;
      }

      hashuman = 1;

      if(player iseliminated()) {
        continue;
      }

      var_afdc93e504789c3d = 1;
      var_8dfb4c8e7302515e = player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || !isaliveplayer(player) || player isskydiving() || player isparachuting();

      if(var_8dfb4c8e7302515e) {
        continue;
      }

      validhumanplayers[validhumanplayers.size] = player;
    }

    nohumanalivebutspectating = hashuman && !var_afdc93e504789c3d;

    if(nohumanalivebutspectating) {
      level.var_7b37b2193f163b9b.var_b871280cbdc11caf = 1;
      thread function_e79f454a81696e11("noHumanAliveButSpectating");
      level notify("no_human_alive");
      break;
    }

    if(validhumanplayers.size > 0) {
      var_6f45c47a2030379d = "ui_bots_deployed";
      level thread function_5982992426cf092(validhumanplayers, updateinterval, var_6f45c47a2030379d);
      level waittill(var_6f45c47a2030379d);
    }

    wait updateinterval;
  }
}

function private function_5982992426cf092(humanplayers, updateinterval, var_dfc67eaaf62bc0) {
  if(getdvarint(@ "hash_25920b075500f084", 0)) {
    level function_c73ffcc4d5a2bc9c(var_dfc67eaaf62bc0);
    return;
  }

  foreach(player in humanplayers) {
    engageinfo = player.engageinfo;

    if(function_a420e0f6eca5f1c6()) {
      shoulddeploy = 1;
    } else {
      var_5bc7cbbcf589f547 = player function_a0fbe39135ab0d35();
      var_ae5632495dfca986 = gettime() - var_5bc7cbbcf589f547;

      if(!isDefined(engageinfo.var_96be2fbd0ac6a848)) {
        engageinfo.var_96be2fbd0ac6a848 = 0;
      }

      if(!isDefined(engageinfo.var_5bc7cbbcf589f547)) {
        engageinfo.var_5bc7cbbcf589f547 = 0;
      }

      if(engageinfo.var_5bc7cbbcf589f547 != var_5bc7cbbcf589f547) {
        engageinfo.var_96be2fbd0ac6a848 = 0;
        engageinfo.var_5bc7cbbcf589f547 = var_5bc7cbbcf589f547;
      }

      velocity = player getvelocity();
      speed = length(velocity);

      if(speed < getdvarint(@ "hash_3d8ce2c99aa4db2b", 1) && var_ae5632495dfca986 > 0) {
        penalty = getdvarint(@ "hash_9be4e2fbbfe8d9c5", 500);
        assert(penalty >= 0 && penalty < 1000);
        engageinfo.var_96be2fbd0ac6a848 += penalty * updateinterval;
      }

      var_b8bba9ccd960781 = getdvarint(@ "hash_e32340e297efbbdd", 45000);
      shoulddeploy = var_ae5632495dfca986 >= var_b8bba9ccd960781 + engageinfo.var_96be2fbd0ac6a848;
    }

    if(shoulddeploy) {
      engageinfo.var_96be2fbd0ac6a848 = 0;
      player thread namespace_c50b30148766aa59::function_947b37d99674b59c();
    }
  }

  level function_c73ffcc4d5a2bc9c(var_dfc67eaaf62bc0);
}

function private respawndisabled() {
  return isDefined(level.brgametype.respawnenable) && !level.brgametype.respawnenable;
}

function private function_a420e0f6eca5f1c6() {
  return scripts\mp\gametypes\br::isgulagshutdown() || respawndisabled();
}

function private function_e79f454a81696e11(reason) {
  level endon("game_ended");
  logstring("[Super Bots] DeployAllUIBotsThread start");
  namespace_92443376a63aa4bd::function_8303a56b1ee268b2("begin", reason, level.var_7b37b2193f163b9b.uibots.size);

  while(level.var_7b37b2193f163b9b.uibots.size > 0) {
    count = level.var_7b37b2193f163b9b.uibots.size;

    for(i = 0; i < count; i++) {
      botprofile = namespace_c50b30148766aa59::function_32ec26ab4915f882();

      if(!isDefined(botprofile)) {
        break;
      }

      bot = botprofile namespace_c50b30148766aa59::activate("Combat", reason);

      if(isDefined(bot)) {
        streamtimeout = getdvarint(@ "hash_a022906be1321bb1", 2);
        deployedpos = bot namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(0, streamtimeout).origin;
        namespace_92443376a63aa4bd::onplayerteleport(bot, bot.origin, deployedpos, reason);
        bot setOrigin(deployedpos, 1);
      }
    }

    wait 1;
  }

  namespace_92443376a63aa4bd::function_8303a56b1ee268b2("end", reason);
  logstring("[Super Bots] DeployAllUIBotsThread end");
}

function private function_c9b0122de1017d85() {
  level endon("game_ended");

  while(true) {
    msg = level waittill_any_in_array_return(["ui_bot_counter_updated", "updatePlayerAndTeamCountUI"]);

    if(msg == "updatePlayerAndTeamCountUI") {
      level.var_7b37b2193f163b9b.dormantbots = array_removeundefined(level.var_7b37b2193f163b9b.dormantbots);
      level.var_7b37b2193f163b9b.uibots = array_removeundefined(level.var_7b37b2193f163b9b.uibots);
    }

    function_a892d044d30522da();
  }
}

function private function_a892d044d30522da() {
  if(getdvarint(@ "hash_a2d26b607a32e157", 0) == 1) {
    dormantbotnum = level.var_7b37b2193f163b9b.dormantbots.size;
    uibotnum = level.var_7b37b2193f163b9b.uibots.size;
    totalalivebotnum = 0;
    var_28424573cf3f8f98 = 0;
    var_ba0722e02a3acdf1 = 0;

    foreach(player in level.players) {
      if(isbot(player)) {
        if(!player iseliminated() && !player isuibot()) {
          if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
            var_28424573cf3f8f98++;
          } else {
            totalalivebotnum++;
          }
        }

        continue;
      }

      if(function_40034c2faf09a87b()) {
        var_ba0722e02a3acdf1++;
      }
    }

    activebotnum = totalalivebotnum - dormantbotnum;
    var_47bf15e70ee220a = (uibotnum << 24) + (dormantbotnum << 16) + (activebotnum << 8) + var_ba0722e02a3acdf1;
    setomnvar("ui_br_matchinfo_bot_stats", var_47bf15e70ee220a);
    setomnvar("ui_br_matchinfo_bot_gulag_stats", var_28424573cf3f8f98);
    return;
  }

  setomnvar("ui_br_matchinfo_bot_stats", 0);
  setomnvar("ui_br_matchinfo_bot_gulag_stats", 0);
}

function private function_494150569261c828() {
  level endon("game_ended");

  if(istrue(level.br_infils_disabled)) {
    level waittill("player_spawned");
  } else {
    level waittill("br_c130_left_bounds");
  }

  const_m = 1.15;
  const_n = 1.2;

  while(true) {
    interval = getdvarint(@ "hash_e0ec70c334cf532a", 30);
    point = function_f7d87293d8dda36();

    if(isDefined(point) && point[1] > 0) {
      var_8b49e0c7718e511c = function_49ed1adad9307ce5();
      aliveratio = var_8b49e0c7718e511c / point[1];

      if(aliveratio > const_m) {
        interval = clamp(pow(1 / (aliveratio - const_m), const_n), 1, interval);
      }
    }

    msg = level waittill_any_in_array_or_timeout(["player_killed"], interval);

    if(msg == "player_killed") {
      continue;
    }

    if(getdvarint(@ "hash_dd9f8b3596ac0b3d", 0) > 0) {
      iprintln("<dev string:x2e>");
      continue;
    }

    dormantbotcount = level.var_7b37b2193f163b9b.dormantbots.size;

    if(dormantbotcount != 0) {
      var_629c48f843740b97 = undefined;

      for(index = 0; index < dormantbotcount; index++) {
        dormantbot = level.var_7b37b2193f163b9b.dormantbots[index];

        if(!dormantbot function_16a5388d4963e316()) {
          var_629c48f843740b97 = dormantbot;
          break;
        }
      }

      if(isDefined(var_629c48f843740b97)) {
        var_629c48f843740b97 namespace_c4ef709c036dc4a8::activate();
        var_629c48f843740b97 dodamage(var_629c48f843740b97.health + 10000, var_629c48f843740b97.origin, var_629c48f843740b97);
      }
    }
  }
}

function function_9f9e27bf69291e6d() {
  function_315d33bcb2364d51();

  while(true) {
    hashuman = 0;

    foreach(player in level.players) {
      if(isDefined(player) && !isbot(player)) {
        hashuman = 1;
        break;
      }
    }

    if(hashuman) {
      wait 1;
      continue;
    }

    forceendgame();
    return;
  }
}

function private function_315d33bcb2364d51() {
  level endon("game_ended");
  assert(!isDefined(level.players));

  while(true) {
    level waittill("player_spawned", player);

    if(!isai(player)) {
      return;
    }
  }
}

function private function_49ed1adad9307ce5(var_b12d06a2613ef1a1) {
  count = 0;

  foreach(player in level.players) {
    if(isPlayer(player) && !player iseliminated() && !player isuibot()) {
      count++;
    }
  }

  if(!istrue(var_b12d06a2613ef1a1)) {
    count += function_1bbd21d289ba8a92();
  }

  return count;
}

function private function_a0e0c0e1e94630f6() {
  tablename = "mp/br_bot_survival_curve.csv";
  partymaxplayers = getdvarint(@ "party_maxplayers", 150);
  var_cb2737353ad087da = tableexists(tablename);
  assert(var_cb2737353ad087da, "<dev string:x85>");
  level.var_de1b021064d0f5bb = spawnStruct();
  level.var_de1b021064d0f5bb.points = [];

  if(var_cb2737353ad087da && isDefined(level.br_level) && isDefined(level.br_level.br_circledelaytimes)) {
    var_67ba7c3c6b03a843 = 0;

    for(circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount; circleindex++) {
      var_67ba7c3c6b03a843 += level.br_level.br_circleclosetimes[circleindex];
      var_67ba7c3c6b03a843 += level.br_level.br_circledelaytimes[circleindex];
    }

    points = [];
    mapname = getDvar(@ "g_mapname");
    foundmap = 0;
    rownum = tablelookupgetnumrows(tablename);

    for(row = 0; row < rownum; row++) {
      name = tablelookupbyrow(tablename, row, 0);
      gametype = tablelookupbyrow(tablename, row, 1);

      if(name == mapname && scripts\mp\utility\game::getsubgametype() == gametype) {
        foundmap = 1;
        progress = int(tablelookupbyrow(tablename, row, 2));
        assert(progress >= 0 && progress <= 100);
        aliveratio = int(tablelookupbyrow(tablename, row, 3)) / 100;
        var_71ea6e5e5cc30c2f = int(tablelookupbyrow(tablename, row, 4)) / 100;
        threshold = int(tablelookupbyrow(tablename, row, 5));
        points[points.size] = (int(float(var_67ba7c3c6b03a843) * progress / 100), int(aliveratio * partymaxplayers), int(var_71ea6e5e5cc30c2f * partymaxplayers) * 100 + threshold);
        continue;
      }

      if(foundmap) {
        break;
      }
    }

    if(points.size > 0) {
      level.var_de1b021064d0f5bb.points = points;
      return true;
    }
  }

  return false;
}

function function_e3b7c7a52e05ac10(point) {
  if(isDefined(point)) {
    return int(int(point[2]) / 100);
  }

  return undefined;
}

function private function_94f7fcf9188a0a81(point) {
  if(isDefined(point)) {
    return int(int(point[2]) % 100);
  }

  return undefined;
}

function function_f7d87293d8dda36() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleinittime) || !isDefined(level.var_de1b021064d0f5bb) || !isDefined(level.var_de1b021064d0f5bb.points) || level.var_de1b021064d0f5bb.points.size <= 0) {
    return undefined;
  }

  curtimesec = (gettime() - level.br_circle.circleinittime) / 1000;
  point = undefined;

  for(i = level.var_de1b021064d0f5bb.curindex; i < level.var_de1b021064d0f5bb.points.size; i++) {
    if(curtimesec < level.var_de1b021064d0f5bb.points[i][0]) {
      point = level.var_de1b021064d0f5bb.points[i];
      level.var_de1b021064d0f5bb.curindex = i;
      break;
    }
  }

  if(!isDefined(point)) {
    level.var_de1b021064d0f5bb.curindex = level.var_de1b021064d0f5bb.points.size;
  }

  return point;
}

function private function_c596173d88d8446e() {
  level endon("game_ended");
  level.var_de1b021064d0f5bb.curindex = 0;

  if(level.br_infils_disabled) {
    level waittill("spawned_bots");
  } else {
    level waittill("br_c130_left_bounds");
  }

  level.var_de1b021064d0f5bb.debugcountdown = 0;
  level thread function_3732de24f5682219();

  while(true) {
    curtimesec = (gettime() - level.br_circle.circleinittime) / 1000;
    point = function_f7d87293d8dda36();

    if(!isDefined(point)) {
      break;
    }

    timeleftsec = point[0] - curtimesec;
    var_8b49e0c7718e511c = function_49ed1adad9307ce5();
    alivedelta = var_8b49e0c7718e511c - point[1];

    if(alivedelta < 1) {
      wait timeleftsec;
      continue;
    }

    avgsec = timeleftsec / alivedelta;

    level.var_de1b021064d0f5bb.debugcountdown = gettime() + avgsec * 1000;

    wait avgsec;
    logstring("[Super Bots] SurvivalCurve: to many survivors, kill a bot");
    namespace_c50b30148766aa59::killsome(1, 0, "SurvivalCurve");
    wait 1;
  }

  cleanupleftuibots();
}

function private cleanupleftuibots() {
  level.var_7b37b2193f163b9b.var_b871280cbdc11caf = 1;
  reason = "CleanUpLeftUIBots";
  namespace_92443376a63aa4bd::function_8303a56b1ee268b2("begin", reason, function_1bbd21d289ba8a92());

  while(function_1bbd21d289ba8a92() > 0) {
    namespace_c50b30148766aa59::killsome(1, 0, reason);
    wait 1;
  }

  namespace_92443376a63aa4bd::function_8303a56b1ee268b2("end", reason);
}

function private function_fb4771e79218146b(bot) {
  if(!isbot(bot)) {
    return undefined;
  }

  if(getdvarint(@ "hash_aefbe1721e059470", 0)) {
    return undefined;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.circleinittime)) {
    return undefined;
  }

  if(istrue(bot.var_82bd86e99f1dd1e4)) {
    bot.var_82bd86e99f1dd1e4 = undefined;
    return undefined;
  }

  if(istrue(bot.inlaststand)) {
    return undefined;
  }

  if(!isDefined(level.var_de1b021064d0f5bb) || !isDefined(level.var_de1b021064d0f5bb.points) || level.var_de1b021064d0f5bb.points.size <= 0) {
    return undefined;
  }

  point = function_f7d87293d8dda36();

  if(!isDefined(point)) {
    return undefined;
  }

  threshold = function_94f7fcf9188a0a81(point) / 100;
  var_8b49e0c7718e511c = function_49ed1adad9307ce5();

  if(var_8b49e0c7718e511c > point[1] * (1 + threshold)) {
    scripts\mp\gametypes\br_utility::markplayeraseliminated(bot);
    logstring("[Super Bots] SurvivalCurve: mark bot as eliminated:" + bot.name);
    return 1;
  } else if(var_8b49e0c7718e511c < point[1] * (1 - threshold)) {
    if(!bot namespace_c50b30148766aa59::function_b2502f3345564abf()) {
      return undefined;
    }

    bot.respawningfromtoken = 1;
    bot thread function_6e4f25ce6aafc2a8();
    return 0;
  }

  return undefined;
}

function private function_6e4f25ce6aafc2a8() {
  level endon("game_ended");
  assert(isDefined(self));
  name = self.name;
  entityid = self getentitynumber();
  bba_id = default_to(self.bba_id, "");
  var_6fd1e5714453e3f9 = 2;
  timeuntilspawn = scripts\mp\playerlogic::timeuntilspawn(1) + var_6fd1e5714453e3f9;
  wait timeuntilspawn;

  if(!isDefined(self)) {
    logstring("WARNING: SurvivalCurveWaitRecycleThread() bot is undefined! Skip recycle. name=" + name + " entityID=" + entityid + " BBA_Id=" + bba_id);
    return;
  }

  logstring("[Super Bots] SurvivalCurve: recycle bot after killed:" + self.name);
  result = namespace_c50b30148766aa59::recycle("SurvivalCurve recycle after killed");

  if(!result) {
    kickplayer();
  }
}

function private function_a5786099ca387b00() {
  point = namespace_95d8d8ec67e3e074::function_f7d87293d8dda36();

  if(isDefined(point)) {
    threshold = namespace_95d8d8ec67e3e074::function_94f7fcf9188a0a81(point) / 100;
    var_8b49e0c7718e511c = namespace_95d8d8ec67e3e074::function_49ed1adad9307ce5();

    if(var_8b49e0c7718e511c > point[1] * (1 + threshold)) {
      return false;
    }
  }

  return true;
}

function function_e89eaa436ffad5a4() {
  level endon("game_ended");
  duration = getdvarint(@ "hash_6f2bcb1f13830539", 90000);
  circleendtime = function_719a071e30a49f1();
  var_e254f66879e0132d = gettime();

  while(true) {
    if(circleendtime > 0 && gettime() >= circleendtime) {
      break;
    }

    if(function_6f0140d48aee879()) {
      if(gettime() - var_e254f66879e0132d >= duration) {
        break;
      }
    } else {
      var_e254f66879e0132d = gettime();
    }

    wait 1;
  }

  forceendgame();
}

function function_719a071e30a49f1() {
  if(istrue(level.br_circle_disabled)) {
    return 0;
  }

  if(!isDefined(level.br_circle.circleinittime)) {
    level waittill("br_circle_set");
  }

  circleduration = 0;

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(i = 0; i < level.br_level.br_circledelaytimes.size; i++) {
      prewaittime = level.br_level.br_circledelaytimes[i];
      circleduration += prewaittime;
    }
  }

  if(isDefined(level.br_level.br_circleclosetimes)) {
    for(i = 0; i < level.br_level.br_circleclosetimes.size; i++) {
      closetime = level.br_level.br_circleclosetimes[i];
      circleduration += closetime;
    }
  }

  return level.br_circle.circleinittime + circleduration * 1000 + getdvarint(@ "hash_b601ee95f4a4ba2e", 0);
}

function function_6f0140d48aee879() {
  aliveteamcount = 0;
  onlyhumanteam = function_a0f36ff3eae203ae();

  foreach(entry in level.teamnamelist) {
    if(function_947d35b32cf46531(entry, onlyhumanteam)) {
      aliveteamcount++;

      if(aliveteamcount > 1) {
        return false;
      }
    }
  }

  return true;
}

function function_a0f36ff3eae203ae() {
  if(istrue(level.br_circle_disabled)) {
    return false;
  }

  if(level.br_level.br_movingcirclecount <= 0) {
    return false;
  }

  return level.br_circle.circleindex + 1 >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount;
}

function function_947d35b32cf46531(team, onlyhumanteam) {
  alivecount = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(alivecount <= 0) {
    return 0;
  }

  if(istrue(onlyhumanteam)) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(teammate in players) {
      if(!isai(teammate)) {
        return 1;
      }
    }

    return 0;
  }

  return 1;
}

function forceendgame() {
  level.var_7b37b2193f163b9b.var_b871280cbdc11caf = 1;
  endgamemethod = getdvarint(@ "hash_14a1f07fa4c28b94", 0);
  logstring("ForceEndGame. endGameMethod=" + endgamemethod);
  namespace_92443376a63aa4bd::debuglogforceendgame(endgamemethod);

  if(endgamemethod == 0) {
    thread scripts\mp\gamelogic::forceend();
    return;
  }

  winner = function_5b81a287d0eff6ad();
  assert(isDefined(winner));

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    playerendmatch();
  }

  if(!scripts\mp\gametypes\br::function_a587b0b0998c6d13()) {
    thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["enemies_eliminated"], game["end_reason"]["br_eliminated"]);
  }
}

function function_5b81a287d0eff6ad() {
  onlyhumanteam = 1;

  foreach(entry in level.teamnamelist) {
    if(function_947d35b32cf46531(entry, onlyhumanteam)) {
      return entry;
    }
  }

  onlyhumanteam = 0;

  foreach(entry in level.teamnamelist) {
    if(function_947d35b32cf46531(entry, onlyhumanteam)) {
      return entry;
    }
  }

  if(level.var_7b37b2193f163b9b.uibots.size > 0) {
    return level.var_7b37b2193f163b9b.uibots[0].team;
  }

  return undefined;
}

function function_f19131452f7b839a() {
  level waittill("<dev string:xb1>");
  cmd = "<dev string:xc3>";
  adddevguicmd(cmd);
  cmd = "<dev string:x12d>";
  adddevguicmd(cmd);
  cmd = "<dev string:x191>";
  adddevguicmd(cmd);
  cmd = "<dev string:x1f9>";
  adddevguicmd(cmd);
  cmd = "<dev string:x271>";
  adddevguicmd(cmd);
  cmd = "<dev string:x2f7>";
  adddevguicmd(cmd);
  cmd = "<dev string:x36b>";
  adddevguicmd(cmd);
  namespace_c50b30148766aa59::function_2fd7dbe9fce56a4b();
  level thread function_3e27a1f84d84fc6a();
  level thread function_a0ee40c011c7dbf0();
  level thread function_da1172b593a41342();
}

function function_3e27a1f84d84fc6a() {
  level endon("<dev string:x401>");

  while(!isDefined(level.players)) {
    wait 1;
  }

  setdvarifuninitialized(@ "hash_a2d26b607a32e157", 0);

  while(true) {
    if(getdvarint(@ "hash_a2d26b607a32e157", 0) == 1) {
      totalalivebotnum = 0;
      var_defe7b118dc3891d = 0;

      foreach(player in level.players) {
        if(isbot(player) && !player iseliminated()) {
          if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
            var_defe7b118dc3891d++;
            continue;
          }

          if(!player isuibot()) {
            totalalivebotnum++;

            if(player function_d012729eac1e7053()) {
              debugmsg = "<dev string:x40f>";

              if(player namespace_c4ef709c036dc4a8::issuspended()) {
                debugmsg += "<dev string:x41a>";
              }

              if(isDefined(player.recyclereason)) {
                debugmsg += "<dev string:x429>" + player.recyclereason;
              }
            } else {
              debugmsg = "<dev string:x430>";
            }

            print3d(player.origin + (0, 0, 100), debugmsg, (1, 0, 0), 1, 1, 70, 1);
          }
        }
      }

      dormantbotnum = level.var_7b37b2193f163b9b.dormantbots.size;
      uibotnum = level.var_7b37b2193f163b9b.uibots.size;
      var_3ce65cfec5ad6979 = dormantbotnum + uibotnum;
      var_89e85c0815c992d6 = gettime() + 1000;

      while(gettime() < var_89e85c0815c992d6) {
        printtoscreen2d(500, 100, "<dev string:x43a>" + var_3ce65cfec5ad6979 + "<dev string:x45b>" + dormantbotnum + "<dev string:x460>" + uibotnum + "<dev string:x465>" + var_defe7b118dc3891d + "<dev string:x47b>" + totalalivebotnum - dormantbotnum, (1, 0, 0), 2);
        waitframe();
      }

      continue;
    }

    wait 1;
  }
}

function function_a0ee40c011c7dbf0() {
  level endon("<dev string:x401>");

  while(!isDefined(level.players)) {
    wait 1;
  }

  setdvarifuninitialized(@ "hash_e7a0fc54a24bf343", 0);

  while(true) {
    if(getdvarint(@ "hash_e7a0fc54a24bf343", 0) == 1) {
      setDvar(@ "hash_e7a0fc54a24bf343", 0);

      foreach(player in level.players) {
        if(isvalidbot(player)) {
          if(!scripts\mp\gamelogic::inprematch()) {
            player namespace_c4ef709c036dc4a8::recycle("<dev string:x48e>");
            continue;
          }

          player namespace_c50b30148766aa59::recycle("<dev string:x48e>");
        }
      }
    }

    wait 1;
  }
}

function function_da1172b593a41342() {
  level endon("<dev string:x401>");
  setdvarifuninitialized(@ "hash_d95f6cfac74fa872", 0);
  setdvarifuninitialized(@ "hash_25920b075500f084", 0);
  setdvarifuninitialized(@ "hash_70561094fa4e91b5", 0);
  setdvarifuninitialized(@ "hash_dd9f8b3596ac0b3d", 0);
  setdvarifuninitialized(@ "hash_aefbe1721e059470", 0);
  pauserecycle = getdvarint(@ "hash_d95f6cfac74fa872", 0);
  var_29080d691bb72834 = getdvarint(@ "hash_25920b075500f084", 0);
  var_24b5eeca7a6109ed = getdvarint(@ "hash_70561094fa4e91b5", 0);
  var_7c4e466930c5330e = getdvarint(@ "hash_dd9f8b3596ac0b3d", 0);
  var_889f45625d6bc05c = getdvarint(@ "hash_aefbe1721e059470", 0);

  while(true) {
    function_dc925a47fd3404ba(pauserecycle, @ "hash_d95f6cfac74fa872", "<dev string:x4a5>");
    pauserecycle = getdvarint(@ "hash_d95f6cfac74fa872", 0);
    function_dc925a47fd3404ba(var_29080d691bb72834, @ "hash_25920b075500f084", "<dev string:x4b5>");
    var_29080d691bb72834 = getdvarint(@ "hash_25920b075500f084", 0);
    function_dc925a47fd3404ba(var_24b5eeca7a6109ed, @ "hash_70561094fa4e91b5", "<dev string:x4c7>");
    var_24b5eeca7a6109ed = getdvarint(@ "hash_70561094fa4e91b5", 0);
    function_dc925a47fd3404ba(var_7c4e466930c5330e, @ "hash_dd9f8b3596ac0b3d", "<dev string:x4e0>");
    var_7c4e466930c5330e = getdvarint(@ "hash_dd9f8b3596ac0b3d", 0);
    function_dc925a47fd3404ba(var_889f45625d6bc05c, @ "hash_aefbe1721e059470", "<dev string:x4f8>");
    var_889f45625d6bc05c = getdvarint(@ "hash_aefbe1721e059470", 0);
    wait 1;
  }
}

function function_dc925a47fd3404ba(dvarvalue, dvarname, hintstring) {
  if(dvarvalue != getdvarint(dvarname, 0)) {
    if(getdvarint(dvarname, 0)) {
      iprintln(hintstring + "<dev string:x51f>");
      return;
    }

    iprintln(hintstring + "<dev string:x527>");
  }
}

function function_3732de24f5682219() {
  debugpoints = [];

  for(i = 0; i < level.var_de1b021064d0f5bb.points.size; i++) {
    debugpoints[debugpoints.size] = 0;
  }

  circlestarttime = [];
  time = 0;

  for(circleindex = 0; circleindex < level.br_level.br_circledelaytimes.size; circleindex++) {
    timedelay = level.br_level.br_circledelaytimes[circleindex];
    time += timedelay;
    circlestarttime[circlestarttime.size] = time;
    timeclose = level.br_level.br_circleclosetimes[circleindex];
    time += timeclose;
  }

  while(true) {
    if(getdvarint(@ "hash_52f1eee4900df5a4", 0) > 0) {
      curtimesec = (gettime() - level.br_circle.circleinittime) / 1000;
      var_8b49e0c7718e511c = function_49ed1adad9307ce5();
      point = undefined;

      for(i = level.var_de1b021064d0f5bb.curindex; i < level.var_de1b021064d0f5bb.points.size; i++) {
        if(curtimesec < level.var_de1b021064d0f5bb.points[i][0]) {
          point = level.var_de1b021064d0f5bb.points[i];
          debugpoints[i] = var_8b49e0c7718e511c;
          break;
        }
      }

      if(!isDefined(point)) {
        point = level.var_de1b021064d0f5bb.points[level.var_de1b021064d0f5bb.points.size - 1];
      }

      timeleftsec = point[0] - curtimesec;
      msg = "<dev string:x52e>";

      if(gettime() < level.var_de1b021064d0f5bb.debugcountdown) {
        msg = "<dev string:x532>" + (level.var_de1b021064d0f5bb.debugcountdown - gettime()) / 1000;
      }

      x = 600;
      y = 900;
      printtoscreen2d(x, 600, "<dev string:x546>" + getdvarint(@ "party_maxplayers", 0) + "<dev string:x574>" + timeleftsec, (1, 0, 0), 1.5);
      printtoscreen2d(x, 650, "<dev string:x58a>" + point[1] + "<dev string:x593>" + var_8b49e0c7718e511c + "<dev string:x59c>" + msg, (1, 0, 0), 1.5);
      printtoscreen2d(x, 700, "<dev string:x5a2>" + function_e3b7c7a52e05ac10(point) + "<dev string:x5b0>" + function_94f7fcf9188a0a81(point), (1, 0, 0), 1.5);
      printtoscreen2d(x, y, "<dev string:x5bf>", (1, 1, 1), 1);
      var_ee5ab934f482b124 = scripts\mp\gametypes\br_gulag::gettimetogulagclosed();
      printtoscreen2d(x + var_ee5ab934f482b124 / 2, y, "<dev string:x601>", (1, 1, 1), 1);
      printtoscreen2d(x + curtimesec / 2, y, "<dev string:x606>", (1, 1, 1), 1);

      for(i = 0; i < 10; i++) {
        printtoscreen2d(x, y - i * 15, "<dev string:x60b>", (1, 1, 1), 1);
      }

      printtoscreen2d(x, y - 150, "<dev string:x610>", (1, 1, 1), 1);

      for(i = 0; i < level.var_de1b021064d0f5bb.points.size; i++) {
        point = level.var_de1b021064d0f5bb.points[i];

        if(i == level.var_de1b021064d0f5bb.curindex) {
          printtoscreen2d(x + point[0] / 2, y - point[1] * 2, "<dev string:x619>", (1, 1, 0), 1);
        } else {
          printtoscreen2d(x + point[0] / 2, y - point[1] * 2, "<dev string:x619>", (1, 0, 0), 1);
        }

        if(debugpoints[i] > 0) {
          printtoscreen2d(x + point[0] / 2, y - debugpoints[i] * 2, "<dev string:x619>", (0, 1, 0), 1);
        }
      }

      for(i = 0; i < circlestarttime.size; i++) {
        printtoscreen2d(x + circlestarttime[i] / 2, y - 5, "<dev string:x60b>", (1, 1, 1), 1);
      }

      waitframe();
      continue;
    }

    wait 1;
  }
}

# /