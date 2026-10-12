/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bounty.gsc
***********************************************/

#using script_188008b85f8b14d4;
#using script_419eebc6f24e287;
#using script_6cb0280f7aa7d3cd;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\bounty_system;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;
#namespace dmz_bounty;

function function_5ba1bb4933edc5da() {
  level.var_7481c0699a7c035c = getdvarint(@ "hash_f996b86ac195da4e", 1);

  if(!function_217e5c3b8a4ca539() || !level.var_7481c0699a7c035c) {
    return;
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("player_bounty");
  level.lowerkillthreshold = getdvarint(@ "hash_bb981387b47d3b0a", 7);
  level.var_9918180a152a2c49 = getdvarint(@ "hash_b0d283949fa83cfe", 8);
  level.var_42413476c36f4de9 = getdvarfloat(@ "hash_d3d9b12ad067b71a", 0.1);
  level.var_ea588ca4581980e3 = getdvarfloat(@ "hash_9283db15697679a8", 3);
  level.var_66901f8a5a5028d2 = getdvarint(@ "hash_8b4fd26f8d0f1f27", 60) * 1000;
  level.var_c33be36f17c6f1c4 = getdvarint(@ "hash_de0a66da13bf686d", 60) * 1000;
  level.var_33081ad92157d89 = getdvarint(@ "hash_7e7e58269eec0c4c", 4096);
  level.var_30cb0ad9930b995b = getdvarint(@ "hash_88fbe092f035854e", 1000);
  level.var_8c5f100dfcbd8eca = getdvarint(@ "hash_17211ebb2d6e7fdc", 120);
  level.var_30dc2b175c83ce3b = getdvarfloat(@ "hash_e15493bf7aa7d925", 0.25);
  level.var_da85db0b3fd47276 = getdvarfloat(@ "hash_71ca88ed28116f2e", 1.5);
  level.var_c7b897c856840e47 = getdvarfloat(@ "hash_a75878fca2a61a60", 0.25);
  level.var_b404cefc87a66195 = getdvarfloat(@ "hash_c01362bafd123e2", 1);
  level.var_2c5b630622af3240 = getdvarint(@ "hash_9006008df935add2", 4);
  level.var_13a790a07dc25d17 = getdvarfloat(@ "hash_2547f1e25cbfa8bc", 0.5);
  level.var_b0db22c3e521dd39 = getdvarfloat(@ "hash_ffd443b9cee024f6", 1);
  level.var_a13977795d78d39c = getdvarint(@ "hash_4dc3c6509a8ba03e", 4);
  level.var_18e721fdd859ea38 = getdvarint(@ "hash_ee7f29468bcf226f", 2);
  level.var_5353dacaef431f99 = getdvarfloat(@ "hash_cebe90dac8b47fc", 0.25);
  level.var_153696eee67770d3 = getdvarint(@ "hash_43ed1d607588204e", 3);
  level.var_a767584fed5587e8 = getdvarfloat(@ "hash_96b1854ee4098c22", 1.5);
  level.var_f8a9056ab7fc0fa4 = getdvarfloat(@ "hash_1627ed73590ddd4f", 0.5);
  level.var_ea415dd712d4dc36 = getdvarint(@ "hash_7d402a6d000f55c5", 1);
  level.var_22f3f5dfaf76570c = getdvarint(@ "hash_fc41fa9f3257837a", 1);
  level.var_f50f4e9c206bacd = getdvarint(@ "hash_ff69c5cbcbfc5fc0", 1500);
  level.var_29d13063d54a343e = getdvarint(@ "hash_3a113f3a21a87f53", 5);
  level.var_c2812f877fae7f90 = getdvarint(@ "hash_774b8b91e4bcda07", 0);
  level.var_2d99c1a64eab0ce3 = getdvarfloat(@ "hash_ffc46b09301c5eb6", 5);
  level.var_1384a410983757e1 = [];
  level.var_c704d3de31dfe51f = [];
  namespace_fd8ff6a1c9b4f3c7::registerpostplayerdamagecallback(&function_c7aa23953196010a);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_9dcdfd37eeab85e);

  level thread function_49601a5b7595734c();
}

function function_47ef2434c27b063c(victim, attacker, meansofdeath, overridescore) {
  if(!scripts\mp\gametypes\br_gametypes::isfeatureenabled("player_bounty")) {
    return;
  }

  if(!function_217e5c3b8a4ca539() || !level.var_7481c0699a7c035c || !isDefined(level.var_1384a410983757e1)) {
    return;
  }

  if(!isDefined(attacker) || !isDefined(victim) || !isPlayer(attacker) || !isPlayer(victim)) {
    return;
  }

  if(!isDefined(attacker.pers) || !isDefined(victim.pers)) {
    return;
  }

  wassuicide = isDefined(meansofdeath) && (meansofdeath == "MOD_SUICIDE" || meansofdeath == "MOD_FALLING") || isDefined(attacker) && attacker == victim;

  if(wassuicide) {
    return;
  }

  if(!function_760c732463d67abd(victim, attacker)) {
    return;
  }

  attackerid = attacker scripts\mp\utility\player::getuniqueid();
  victimid = victim scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level.var_1384a410983757e1[attackerid])) {
    level.var_1384a410983757e1[attackerid] = spawnStruct();
    level.var_1384a410983757e1[attackerid].victims = [];
    level.var_1384a410983757e1[attackerid].score = 0;
    level.var_1384a410983757e1[attackerid].lastkilltime = 0;
  }

  if(function_c54f9c19d5062c2d(attackerid, victimid) && !isDefined(overridescore)) {
    return;
  }

  currenttime = gettime();
  level.var_1384a410983757e1[attackerid].victims[victimid] = currenttime + level.var_66901f8a5a5028d2;
  lastscore = function_9d1edaafd9ae1f43(attackerid);
  level.var_1384a410983757e1[attackerid].score = function_49514c83ede61c52(attackerid, attacker, victim);
  level.var_1384a410983757e1[attackerid].lastkilltime = currenttime;

  if(isDefined(overridescore)) {
    level.var_1384a410983757e1[attackerid].score = overridescore;
  }

  function_c115071fc3ad7124(attacker, lastscore);
}

function function_625d7eecad65e25f(bountysettings) {
  killingteam = bountysettings.killingteam;
  killingplayer = bountysettings.killingplayer;
  rewardplayers = [];

  if(isDefined(killingteam)) {
    rewardplayers = getteamdata(killingteam, "players");

    foreach(player in rewardplayers) {
      if(scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
        namespace_27cdbf2464b21c84::function_ed4c2d913d203bf([player], "bounty_completed", level.var_2d99c1a64eab0ce3);
      }
    }
  } else if(isDefined(killingplayer)) {
    rewardplayers[rewardplayers.size] = killingplayer;
    namespace_27cdbf2464b21c84::function_ed4c2d913d203bf([killingplayer], "bounty_completed", level.var_2d99c1a64eab0ce3);
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_plunder_cash_common_1");

  foreach(player in rewardplayers) {
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(level.var_30cb0ad9930b995b);

    if(isDefined(lootid)) {
      level thread function_8723026f5a8e1127(player, lootid, level.var_2d99c1a64eab0ce3);
    }
  }

  if(isDefined(bountysettings.player)) {
    attackerid = bountysettings.player scripts\mp\utility\player::getuniqueid();
    level.var_1384a410983757e1[attackerid] = undefined;
    bountysettings.player.var_69a9151e7de440f1 = undefined;
  }
}

function function_87e294701a141ce(bountysettings, player) {
  if(bountysettings.player.team == player.team) {
    return;
  }

  if(!isDefined(bountysettings.watcher)) {
    bountysettings.watcher = [];
  }

  currenttime = gettime();
  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(bountysettings.watcher[playerid])) {
    bountysettings.watcher[playerid] = gettime() + level.var_c33be36f17c6f1c4;
    namespace_27cdbf2464b21c84::function_ed4c2d913d203bf([player], "bounty_placed_enemy", level.var_2d99c1a64eab0ce3);
    player scripts\cp_mp\overlord::playevent("player_killed_nearby_callout", [player]);
    return;
  }

  if(bountysettings.watcher[playerid] < currenttime) {
    bountysettings.watcher[playerid] = undefined;
  }
}

function private function_8723026f5a8e1127(player, lootid, waittime) {
  player notify("bounty_reward_delay");
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("bounty_reward_delay");
  wait waittime + 1;
  view_origin = player getvieworigin();
  player scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, level.var_30cb0ad9930b995b);
}

function private function_9dcdfd37eeab85e() {
  level thread function_84703a2ee79a7bba(self);
}

function private function_c7aa23953196010a(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(!isbulletdamage(smeansofdeath)) {
    return;
  }

  if(!isDefined(eattacker) || !isDefined(victim) || !isDefined(eattacker.team) || !isDefined(victim.team) || eattacker.team == victim.team) {
    return;
  }

  if(!isDefined(level.var_c704d3de31dfe51f[victim.team])) {
    level.var_c704d3de31dfe51f[victim.team] = [];
  }

  currenttime = gettime();

  if(!isDefined(level.var_c704d3de31dfe51f[victim.team][eattacker.team])) {
    level.var_c704d3de31dfe51f[victim.team][eattacker.team] = spawnStruct();
    level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_6f635bfcc8e71408 = currenttime;
    level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_7a7953de79b5d5c0 = currenttime;
    return;
  }

  if(isDefined(level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_7a7953de79b5d5c0) && level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_7a7953de79b5d5c0 + level.var_8c5f100dfcbd8eca * 1000 < currenttime) {
    level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_6f635bfcc8e71408 = currenttime;
    level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_7a7953de79b5d5c0 = currenttime;
    return;
  }

  level.var_c704d3de31dfe51f[victim.team][eattacker.team].var_7a7953de79b5d5c0 = currenttime;
}

function private function_84703a2ee79a7bba(player) {
  player endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    player waittill("bulletwhizby", attacker, distance, position, forward);

    if(!isDefined(attacker) || !isDefined(attacker.team) || attacker.team == player.team) {
      continue;
    }

    if(!isDefined(level.var_c704d3de31dfe51f[player.team])) {
      level.var_c704d3de31dfe51f[player.team] = [];
    }

    currenttime = gettime();

    if(!isDefined(level.var_c704d3de31dfe51f[player.team][attacker.team])) {
      level.var_c704d3de31dfe51f[player.team][attacker.team] = spawnStruct();
      level.var_c704d3de31dfe51f[player.team][attacker.team].var_6f635bfcc8e71408 = currenttime;
      level.var_c704d3de31dfe51f[player.team][attacker.team].var_a6c14dfbe6016990 = currenttime;
      continue;
    }

    if(isDefined(level.var_c704d3de31dfe51f[player.team][attacker.team].var_a6c14dfbe6016990) && level.var_c704d3de31dfe51f[player.team][attacker.team].var_a6c14dfbe6016990 + level.var_8c5f100dfcbd8eca * 1000 < currenttime) {
      level.var_c704d3de31dfe51f[player.team][attacker.team].var_6f635bfcc8e71408 = currenttime;
      level.var_c704d3de31dfe51f[player.team][attacker.team].var_a6c14dfbe6016990 = currenttime;
      continue;
    }

    level.var_c704d3de31dfe51f[player.team][attacker.team].var_a6c14dfbe6016990 = currenttime;
  }
}

function private function_5d60f21784f774f4(attacker, victim) {
  if(!isDefined(attacker) || !isDefined(victim)) {
    return false;
  }

  if(!isDefined(level.var_c704d3de31dfe51f[attacker.team]) || !isDefined(level.var_c704d3de31dfe51f[attacker.team][victim.team])) {
    return false;
  }

  attackertime = level.var_c704d3de31dfe51f[attacker.team][victim.team].var_6f635bfcc8e71408;
  victimtime = 0;

  if(isDefined(level.var_c704d3de31dfe51f[victim.team]) && isDefined(level.var_c704d3de31dfe51f[victim.team][attacker.team])) {
    victimtime = level.var_c704d3de31dfe51f[victim.team][attacker.team].var_6f635bfcc8e71408;
  }

  return attackertime <= victimtime;
}

function private function_760c732463d67abd(victim, attacker) {
  victimid = victim scripts\mp\utility\player::getuniqueid();
  victimsteam = getteamdata(victim.team, "players");

  foreach(teammate in victimsteam) {
    teammateid = teammate scripts\mp\utility\player::getuniqueid();

    if(isDefined(teammateid) && isDefined(level.var_1384a410983757e1[teammateid]) && isDefined(level.var_1384a410983757e1[teammateid].bountysettings)) {
      return false;
    }
  }

  if(namespace_b11859036e02907d::function_5fac7d775590ecdd(victim.team, attacker.team)) {
    return false;
  }

  return true;
}

function private function_140a6288c05473fe(player) {
  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level.var_1384a410983757e1[playerid])) {
    level.var_1384a410983757e1[playerid] = spawnStruct();
    level.var_1384a410983757e1[playerid].victims = [];
    level.var_1384a410983757e1[playerid].score = 0;
    level.var_1384a410983757e1[playerid].lastkilltime = 0;
  }
}

function private function_c115071fc3ad7124(attacker, lastscore) {
  if(istrue(attacker.var_69a9151e7de440f1)) {
    return;
  }

  attackerid = attacker scripts\mp\utility\player::getuniqueid();
  currentscore = function_9d1edaafd9ae1f43(attackerid);
  currentthreshold = function_39c1f2930fd57db5(currentscore);
  previousthreshold = function_39c1f2930fd57db5(lastscore);

  if(currentthreshold == 3 && previousthreshold != 2) {
    currentthreshold = 2;
    level.var_1384a410983757e1[attackerid].score = level.var_9918180a152a2c49 - 0.1;
  }

  if(currentthreshold < 3) {
    function_6029f97c06c2236(attacker, currentthreshold);
    return;
  }

  function_6029f97c06c2236(attacker, currentthreshold);
  overridesettings = spawnStruct();

  if(level.var_ea415dd712d4dc36) {
    function_59d1b7f99d093e0e(overridesettings);
  } else {
    function_993eb16c9ec92291(overridesettings);
  }

  attacker.var_69a9151e7de440f1 = 1;
  overridesettings.headiconfriendly = "ui_map_icon_bounty_s5";
  overridesettings.var_9fccd0c71039eff7 = &function_87e294701a141ce;
  overridesettings.var_88c5361db8dbceac = &function_625d7eecad65e25f;
  bountysettings = function_4647cbf23f54d6f6(attacker, overridesettings);
  namespace_27cdbf2464b21c84::function_ed4c2d913d203bf([attacker], "bounty_placed_self", level.var_2d99c1a64eab0ce3);
  attackteam = getteamdata(attacker, "players");

  foreach(player in attackteam) {
    player setclientomnvar("ui_dmz_bounty_squad_index", attacker.sessionuimemberindex);

    if(player != attacker && scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
      namespace_27cdbf2464b21c84::function_ed4c2d913d203bf([player], "bounty_placed_friendly", level.var_2d99c1a64eab0ce3);
    }
  }

  level.var_1384a410983757e1[attackerid].bountysettings = bountysettings;
}

function private function_993eb16c9ec92291(overridesettings) {
  overridesettings.var_d66266e27481ace9 = ter_op(level.var_22f3f5dfaf76570c, 2, 0);
  overridesettings.var_40ca706da5962314 = 2;
  overridesettings.headiconupdatetime = level.var_c2812f877fae7f90;
}

function private function_59d1b7f99d093e0e(overridesettings) {
  overridesettings.var_d66266e27481ace9 = ter_op(level.var_22f3f5dfaf76570c, 2, 0);
  overridesettings.var_40ca706da5962314 = 1;
  overridesettings.circleradius = level.var_f50f4e9c206bacd;
  overridesettings.circleupdatetime = level.var_29d13063d54a343e;
  overridesettings.var_e6f187bcb4b1648e = "Bounty_DMZ";
  overridesettings.var_d77771d6bfb89518 = "ui_map_icon_bounty_s5";
}

function private function_c54f9c19d5062c2d(attackerid, victimid) {
  if(!isDefined(level.var_1384a410983757e1[attackerid].victims) || !isDefined(level.var_1384a410983757e1[attackerid].victims[victimid])) {
    return false;
  }

  cooldowntime = level.var_1384a410983757e1[attackerid].victims[victimid];
  currenttime = gettime();
  return cooldowntime <= currenttime;
}

function private function_49514c83ede61c52(attackerid, attacker, victim) {
  currentscore = function_9d1edaafd9ae1f43(attackerid);
  algo = getdvarint(@ "hash_9d43c91bd2b1870e", 1);
  newscore = 1;
  attackerkills = default_to(attacker.pers["kills"], 0);
  victimkills = default_to(victim.pers["kills"], 0);

  switch (algo) {
    case 1:
      newscore = ter_op(function_5d60f21784f774f4(attacker, victim), level.var_30dc2b175c83ce3b, 1);
      timeremainingpercent = scripts\mp\gamelogic::gettimeremainingpercentage();
      timeremainingweight = level.var_da85db0b3fd47276 * ter_op(timeremainingpercent < 0.75, timeremainingpercent, 1);
      newscore *= timeremainingweight;
      victimteamplayers = getteamdata(victim.team, "players");
      attackerteamplayers = getteamdata(attacker.team, "players");
      var_ec3e0c1a53056d7f = 1 + (attackerteamplayers.size - victimteamplayers.size) / scripts\mp\team_assimilation::getmaxassimilationteamsize();
      newscore *= var_ec3e0c1a53056d7f;
      var_8c7e696211fe4f37 = level.var_2c5b630622af3240 / (victimkills + 1);
      newscore *= clamp(var_8c7e696211fe4f37, level.var_c7b897c856840e47, level.var_b404cefc87a66195);
      var_97761a3c665cbcde = 1;

      foreach(attackerteammate in attackerteamplayers) {
        teammatekills = default_to(attackerteammate.pers["kills"], 0);
        var_97761a3c665cbcde += teammatekills;
      }

      if(var_97761a3c665cbcde >= level.var_153696eee67770d3) {
        foreach(attackerteammate in attackerteamplayers) {
          if(attackerteammate != attacker) {
            function_140a6288c05473fe(attackerteammate);
            var_d91669507fbfa423 = attackerteammate scripts\mp\utility\player::getuniqueid();
            var_6ff1df16b93e2a45 = ter_op(function_5d60f21784f774f4(attacker, victim), level.var_30dc2b175c83ce3b, 1);
            level.var_1384a410983757e1[var_d91669507fbfa423].score += var_6ff1df16b93e2a45;
          }
        }
      }

      alivevictimteam = getteamdata(victim.team, "aliveCount");

      if(alivevictimteam <= 0) {
        newscore *= level.var_a767584fed5587e8;
      }

      if(isDefined(victim.attackers)) {
        foreach(assister in victim.attackers) {
          if(isPlayer(assister) && assister != attacker && assister != victim) {
            function_140a6288c05473fe(assister);
            assisterid = assister scripts\mp\utility\player::getuniqueid();
            var_6ff1df16b93e2a45 = ter_op(function_5d60f21784f774f4(attacker, victim), level.var_30dc2b175c83ce3b, 1);
            level.var_1384a410983757e1[assisterid].score += level.var_f8a9056ab7fc0fa4 * var_6ff1df16b93e2a45;
          }
        }
      }

      if(isDefined(victim.pers["assists"])) {
        var_fddc8aa6f0828e47 = level.var_a13977795d78d39c / (victim.pers["assists"] + 1);
        newscore *= clamp(var_8c7e696211fe4f37, level.var_13a790a07dc25d17, level.var_b0db22c3e521dd39);
      }

      if(attackerkills + 1 <= level.var_18e721fdd859ea38) {
        newscore *= level.var_5353dacaef431f99;
      }

      break;
    default:
      break;
  }

  newscore = clamp(newscore, level.var_42413476c36f4de9, level.var_ea588ca4581980e3);
  return currentscore + newscore;
}

function private function_9d1edaafd9ae1f43(attackerid) {
  if(!isDefined(level.var_1384a410983757e1[attackerid])) {
    return 0;
  }

  return level.var_1384a410983757e1[attackerid].score;
}

function function_f59bb0593a8f98a9(player) {
  if(!isDefined(level.var_1384a410983757e1) || !isDefined(player)) {
    return 0;
  }

  playerid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level.var_1384a410983757e1[playerid])) {
    return 0;
  }

  return level.var_1384a410983757e1[playerid].score;
}

function private function_39c1f2930fd57db5(score) {
  threshold = 0;

  if(score > 0) {
    threshold++;
  }

  if(score >= level.lowerkillthreshold) {
    threshold++;
  }

  if(score >= level.var_9918180a152a2c49) {
    threshold++;
  }

  return threshold;
}

function private function_6029f97c06c2236(attacker, threshold) {
  switch (threshold) {
    case 1:
      attacker scripts\cp_mp\overlord::playevent("player_killed_marked_warning_first", [attacker]);
      break;
    case 2:
      attacker scripts\cp_mp\overlord::playevent("player_killed_marked_second", [attacker]);
      break;
    case 3:
      attacker scripts\cp_mp\overlord::playevent("player_killed_marked_final", [attacker]);
      break;
    default:
      break;
  }
}

function function_49601a5b7595734c() {
  level endon("<dev string:x1c>");
  level waittill("<dev string:x2a>");

  while(true) {
    dvarval = getdvarint(@ "hash_556d37654f88e155", 0);
    host = scripts\mp\gamelogic::gethostplayer();
    var_8850d9f771525016 = undefined;

    foreach(player in level.players) {
      if(isbot(player) && scripts\cp_mp\utility\player_utility::isreallyalive(player) && player.team != host.team) {
        var_8850d9f771525016 = player;
        break;
      }
    }

    if(isDefined(var_8850d9f771525016) && isDefined(host)) {
      switch (dvarval) {
        case 1:
          function_47ef2434c27b063c(host, var_8850d9f771525016, "<dev string:x42>", level.var_9918180a152a2c49);
          break;
        case 2:
          attackerid = var_8850d9f771525016 scripts\mp\utility\player::getuniqueid();
          scripts\mp\bounty_system::function_a10c4276271c4ad7(level.var_1384a410983757e1[attackerid].bountysettings, 1, 0);
          level.var_1384a410983757e1[attackerid] = undefined;
          break;
        case 3:
          function_47ef2434c27b063c(var_8850d9f771525016, host, "<dev string:x42>", 7);
          host.pers["<dev string:x4f>"] = host.pers["<dev string:x4f>"] + 7;
          break;
        case 4:
          attackerid = host scripts\mp\utility\player::getuniqueid();
          scripts\mp\bounty_system::function_a10c4276271c4ad7(level.var_1384a410983757e1[attackerid].bountysettings, 1, 0);
          level.var_1384a410983757e1[attackerid] = undefined;
          break;
        case 5:
          foreach(player in level.players) {
            if(isbot(player) && scripts\cp_mp\utility\player_utility::isreallyalive(player) && player.team == host.team && !function_bc09557189d65e55(player)) {
              function_47ef2434c27b063c(var_8850d9f771525016, player, "<dev string:x42>", 7);
              player.pers["<dev string:x4f>"] = player.pers["<dev string:x4f>"] + 7;
              break;
            }
          }

          break;
        case 6:
          foreach(player in level.players) {
            if(isbot(player) && scripts\cp_mp\utility\player_utility::isreallyalive(player) && player.team == host.team && function_bc09557189d65e55(player)) {
              attackerid = player scripts\mp\utility\player::getuniqueid();
              scripts\mp\bounty_system::function_a10c4276271c4ad7(level.var_1384a410983757e1[attackerid].bountysettings, 1, 0);
              level.var_1384a410983757e1[attackerid] = undefined;
              break;
            }
          }

          break;
      }
    }

    setDvar(@ "hash_556d37654f88e155", 0);
    wait 1;
  }
}

# /