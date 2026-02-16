/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_dev.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;

init() {
  /$
  thread devChangeTimeLimit();

  SetDevDvarIfUninitialized("scr_devchangetimelimit", "-1");
  $ /

    SetDevDvarIfUninitialized("scr_showspawns", "0");

  precacheItem("defaultweapon_mp");
  precacheModel("test_sphere_silver");
  precacheModel("test_sphere_redchrome");

  level.devSpawnFXid = loadfx(maps\mp\gametypes\_teams::getTeamFlagFX("axis"));

  thread addTestClients();
  thread haveTestClientKillPlayer();
  thread haveTestClientCallKillstreak();
  thread haveTestClientPlantExplosive();
  thread haveTestClientFireRocket();
  thread addTestClientJuggernaut();
  thread addTestClientSpawnPoint();
  thread warpEnemies();
  thread warpFriendlies();
  thread giveEquipment();
  thread giveSpecialGrenade();
  thread watchNoClip();
  thread watchUFO();
  thread printPerks();
  thread devGivePerks();
  thread devClearPerks();
  thread devHurtPlayer();
  thread devHurtPlayerReset();
  thread devHurtPlayerDirectional();
  thread devHurtEnt();
  thread devPlayerXP();
  thread devScriptMoversDebugDraw();
  thread devHeliPathDebugDraw();
  thread devLBGuardPathDebugDraw();
  thread devPredatorMissileDebugDraw();
  thread devPrintDailyWeeklyChallenges();
  thread devUpdateHordeSettings();
  thread devShowSpawnUpdate();

  SetDevDvarIfUninitialized("scr_testclients_type", "0");
  SetDevDvarIfUninitialized("scr_testclients", "0");
  SetDevDvarIfUninitialized("scr_testclients_killplayer", "0");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak", "");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak_onlyspectated", "0");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak_onlyhumanteam", "0");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak_toggleall", "0");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak_forceuse", "0");
  SetDevDvarIfUninitialized("scr_testclients_givekillstreak_toggleall_sametime", "0");
  SetDevDvarIfUninitialized("scr_testclients_plantexplosive", "");
  SetDevDvarIfUninitialized("scr_testclients_firerocket", "");
  SetDevDvarIfUninitialized("scr_testclients_jugg", "");
  SetDevDvarIfUninitialized("scr_testclients_spawnpoint", "0");
  SetDevDvarIfUninitialized("scr_botsForceSpawnTeam", "autoassign");
  SetDevDvarIfUninitialized("scr_botsDisableLoadout", "0");
  SetDevDvarIfUninitialized("scr_warpenemies", "0");
  SetDevDvarIfUninitialized("scr_warpfriendlies", "0");
  SetDevDvarIfUninitialized("scr_debuguav", "0");
  SetDevDvarIfUninitialized("scr_debugairstrike", "0");
  SetDevDvarIfUninitialized("scr_printperks", "0");
  SetDevDvarIfUninitialized("scr_devnoclip", "0");
  SetDevDvarIfUninitialized("scr_devufo", "0");
  SetDevDvarIfUninitialized("scr_devgiveperk", "");
  SetDevDvarIfUninitialized("scr_devclearperks", "0");
  SetDevDvarIfUninitialized("scr_devhurtplayer", "0");
  SetDevDvarIfUninitialized("scr_devhurtplayerreset", "0");
  SetDevDvarIfUninitialized("scr_devhurtplayerdirectional", "");
  SetDevDvarIfUninitialized("scr_devhurtent", "");
  SetDevDvarIfUninitialized("scr_dir_blood", "0");
  SetDevDvarIfUninitialized("scr_devplayerxp", "0");
  SetDevDvarIfUninitialized("scr_devScriptMoversDebugDraw", "0");
  SetDevDvarIfUninitialized("scr_devHeliPathsDebugDraw", "0");
  SetDevDvarIfUninitialized("scr_devLBGuardPathDebugDraw", "0");
  SetDevDvarIfUninitialized("scr_devPredatorMissileDebugDraw", "0");
  SetDevDvarIfUninitialized("scr_devPrintDailyWeeklyChallenges", "");
  SetDevDvarIfUninitialized("scr_devClearTeamScores", "0");
  SetDevDvarIfUninitialized("scr_devClearDomFlags", "0");
  SetDevDvarIfUninitialized("scr_devSetFriendlyScore", "");
  SetDevDvarIfUninitialized("scr_devSetEnemyScore", "");
  SetDevDvarIfUninitialized("scr_devIntel", "0");
  SetDevDvarIfUninitialized("scr_debugdog", "0");
  SetDevDvarIfUninitialized("scr_devKillDog", "0");
  SetDevDvarIfUninitialized("scr_devKillAgents", "0");
  SetDevDvarIfUninitialized("scr_devGiveFemaleHead", "0");
  SetDevDvarIfUninitialized("scr_devGiveMaleHead", "0");
  SetDevDvarIfUninitialized("scr_devGiveKillstreakModule", "");
  SetDevDvarIfUninitialized("scr_devGiveBotsKillstreakModule", "");
  SetDevDvarIfUninitialized("scr_devGiveScore", "");
  SetDevDvarIfUninitialized("scr_devGiveScoreToAll", "");
  SetDevDvarIfUninitialized("scr_ammoRegen", "0");

  SetDevDvar("scr_givspecialgrenade", "");
  SetDevDvar("scr_giveequipment", "");
  SetDevDvar("scr_list_weapons", "");
  SetDevDvar("scr_givekillstreak", "");
  SetDevDvar("scr_devgivecarepackage", "");
  SetDevDvar("scr_devgivecarepackagetype", "");
  SetDevDvar("scr_showcard", "");
  SetDevDvar("scr_showoutcome", "");
  SetDevDvar("scr_enemykillhost", "");
  SetDevDvar("scr_giveperk", "");
  SetDevDvar("scr_takeperk", "");
  SetDevDvar("scr_sre", "");
  SetDevDvar("scr_testmigration", "");
  SetDevDvar("scr_show_splash", "");
  SetDevDvar("scr_spam_splashes", "");
  SetDevDvar("scr_spam_usedsplash", "");
  SetDevDvar("scr_spam_eventsplash", "");
  SetDevDvar("scr_spam_boteventsplash", "");
  SetDevDvar("scr_spam_ranksplash", "");
  SetDevDvar("scr_spam_obit", "");
  SetDevDvar("scr_spam_player_promoted", "");
  SetDevDvar("scr_show_endgameupdate", "");
  SetDevDvar("scr_goto_spawn", "");
  SetDevDvar("scr_goto_start_spawn", "");
  SetDevDvar("scr_showOrigin", "");

  if(level.currentgen || (isDefined(level.isZombieGame) && level.isZombieGame)) {
    level.baseWeaponList = [];
  } else {
    level.baseWeaponList = maps\mp\gametypes\_weapons::buildWeaponData(true);
  }

  SetDevDvarIfUninitialized("debug_reflection", "0");

  level thread onPlayerConnect();

  for(;;) {
    wait .05;
    updateDevSettings();
  }
}

devShowSpawnUpdate() {
  while(true) {
    if(getdvarInt("scr_showspawns")) {
      showSpawnpoints();
    }
    waitframe();
  }
}

updateDevSettings() {
  updateMinimapSetting();

  dvar_scr_test_weapon = getDvar("scr_test_weapon");
  if(dvar_scr_test_weapon != "") {
    foreach(player in level.players) {
      if(isPlayer(player) && !IsBot(player)) {
        player thread initForWeaponTests();
        player setTestWeapon(dvar_scr_test_weapon);
      }
    }

    SetDevDvar("scr_test_weapon", "");
  }

  if(getDvar("scr_dump_ranks") != "") {
    SetDevDvar("scr_dump_ranks", "");

    for(rId = 0; rId <= level.maxRank; rId++) {
      rankName = tableLookupIString("mp/rankTable.csv", 0, rId, 5);
      iprintln("REFERENCE UNLOCKED_AT_LV" + (rId + 1));
      iprintln("LANG_ENGLISHUnlocked at ", rankName, " (Lv" + (rId + 1) + ")");

      wait(0.05);
    }
  }

  if(getDvar("scr_list_weapons") != "") {
    foreach(baseWeapon, _ in level.baseWeaponList) {
      iPrintLn(baseWeapon);
    }

    SetDevDvar("scr_list_weapons", "");
  }

  if(getdvarfloat("scr_complete_all_challenges") != 0) {
    foreach(player in level.players) {
      player thread maps\mp\gametypes\_missions::completeAllChallenges(getdvarfloat("scr_complete_all_challenges"));
    }

    SetDevDvar("scr_complete_all_challenges", "");
  }

  dvar_scr_givekillstreak = getDvar("scr_givekillstreak");
  if(dvar_scr_givekillstreak != "") {
    streakName = dvar_scr_givekillstreak;

    resetEMPDvar = false;
    EMPTime = undefined;
    if(streakName == "emp_quick") {
      resetEMPDvar = true;
      EMPTime = GetDvarFloat("scr_emp_timeout");
      streakName = "emp";
      SetDevDvar("scr_emp_timeout", 1.0);
    }

    if(streakName == "juggernaut_exosuit") {
      if(level.players[0] isJuggernaut()) {
        level.players[0] notify("lost_juggernaut");
        wait(0.05);
      }

      modules = ["heavy_exosuit_radar", "heavy_exosuit_punch", "heavy_exosuit_trophy", "heavy_exosuit_rockets"];
      slotIndex = level.players[0] maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex("heavy_exosuit");
      level.players[0] thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("heavy_exosuit", undefined, undefined, modules, slotIndex);
      level.players[0] thread maps\mp\killstreaks\_killstreaks::giveKillstreak("heavy_exosuit", undefined, undefined, level.players[0], modules);
    } else if(streakName == "juggernaut_exosuit_all") {
      if(level.players[0] isJuggernaut()) {
        level.players[0] notify("lost_juggernaut");
        wait(0.05);
      }

      level.players[0] thread maps\mp\killstreaks\_juggernaut::giveJuggernaut("juggernaut_exosuit");
    } else if(IsSubStr(streakName, "remote_mg_sentry_turret_")) {
      if(streakName == "remote_mg_sentry_turret_laser") {
        level.players[0] thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadenergy_mp");
      } else if(streakName == "remote_mg_sentry_turret_rocket") {
        level.players[0] thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadrocket_mp");
      } else {
        level.players[0] thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadmg_mp");
      }
    } else if(isDefined(level.killstreakFuncs[streakName]) && tableLookup("mp/killstreakTable.csv", 1, streakName, 0) != "") {
      foreach(player in level.players) {
        if(IsBot(player) || IsTestClient(player)) {
          continue;
        }

        if(player.team != "spectator" && player.sessionstate != "spectator") {
          streakVal = player maps\mp\killstreaks\_killstreaks::getStreakCost(streakName);
          modules = player maps\mp\killstreaks\_killstreaks::getKillStreakModules(player, streakName);

          slotIndex = player maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex(streakName);
          player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal, undefined, modules, slotIndex);
          player maps\mp\killstreaks\_killstreaks::giveKillstreak(streakName);
        }
      }
    } else {
      println("\"" + dvar_scr_givekillstreak + "\" is not a valid value for scr_givekillstreak. Try:");
      foreach(killstreak, value in level.killstreakFuncs) {
        if(tableLookup("mp/killstreakTable.csv", 1, killstreak, 0) != "") {
          println("" + killstreak);
        }
      }
      println("");
    }

    if(resetEMPDvar) {
      level thread waitResetDvar(5.0, "scr_emp_timeout", EMPTime);
    }

    SetDevDvar("scr_givekillstreak", "");
  }

  streakName = undefined;
  streakType = undefined;
  giving_to_bots = false;
  dvar_scr_devgivecarepackage = getDvar("scr_devgivecarepackage");
  dvar_scr_testclients_givecarepackage = getDvar("scr_testclients_givecarepackage");
  if(dvar_scr_devgivecarepackage != "") {
    streakName = dvar_scr_devgivecarepackage;
    streakType = getDvar("scr_devgivecarepackagetype");
  } else if(dvar_scr_testclients_givecarepackage != "") {
    streakName = dvar_scr_testclients_givecarepackage;
    streakType = getDvar("scr_testclients_givecarepackagetype");
    giving_to_bots = true;
  }

  if(isDefined(streakName)) {
    if((isDefined(level.killstreakFuncs[streakName]) && tableLookup("mp/killstreakTable.csv", 1, streakName, 0) != "") || streakName == "random") {
      foreach(player in level.players) {
        if(IsBot(player) || IsTestClient(player)) {
          if(!giving_to_bots) {
            continue;
          }
        } else {
          if(giving_to_bots) {
            continue;
          }
        }

        if(player.team != "spectator") {
          player maps\mp\killstreaks\_killstreaks::giveKillstreak("airdrop_assault");
        }

        if(streakName != "random") {
          SetDevDvar("scr_crateOverride", streakName);
          SetDevDvar("scr_crateTypeOverride", streakType);
        } else {
          SetDevDvar("scr_crateOverride", "");
          SetDevDvar("scr_crateTypeOverride", "");
        }
      }
    } else {
      println("\"" + dvar_scr_devgivecarepackage + "\" is not a valid value for scr_devgivecarepackage. Try:");
      foreach(killstreak, value in level.killstreakFuncs) {
        if(tableLookup("mp/killstreakTable.csv", 1, killstreak, 0) != "") {
          println("" + killstreak);
        }
      }
      println("");
    }

    if(dvar_scr_devgivecarepackage != "") {
      SetDevDvar("scr_devgivecarepackage", "");
      SetDevDvar("scr_devgivecarepackagetype", "");
    } else if(dvar_scr_testclients_givecarepackage != "") {
      SetDevDvar("scr_testclients_givecarepackage", "");
      SetDevDvar("scr_testclients_givecarepackagetype", "");
    }
  }

  if(getDvar("scr_showcard") != "") {
    tokens = strTok(getDvar("scr_showcard"), " ");

    if(tokens.size) {
      playerName = tokens[0];

      if(isDefined(tokens[1])) {
        slotId = int(tokens[1]);
      } else {
        slotId = 0;
      }

      owner = undefined;
      foreach(player in level.players) {
        if(player.name == playerName) {
          owner = player;
          break;
        }
      }

      if(!isDefined(owner)) {
        printLn("Player " + playerName + "not found!");
      }
    }

    SetDevDvar("scr_showcard", "");
  }

  dvar_scr_usekillstreak = getDvar("scr_usekillstreak");
  if(dvar_scr_usekillstreak != "") {
    tokens = strTok(dvar_scr_usekillstreak, " ");

    if(tokens.size > 1) {
      playerName = tokens[0];
      streakName = tokens[1];

      if(!isDefined(level.killstreakFuncs[streakName])) {
        printLn("Killstreak " + streakName + "not found!");
      }

      owner = undefined;
      foreach(player in level.players) {
        if(player.name == playerName) {
          owner = player;

          player maps\mp\killstreaks\_killstreaks::giveKillstreak(streakName);

          if(isDefined(tokens[2])) {
            player thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
          } else {
            player thread[[level.killstreakFuncs[streakName]]]();
          }

          if(isSubStr(streakName, "airstrike")) {
            wait .05;
            player notify("confirm_location", level.mapCenter, 0);
          }

          break;
        }
      }

      if(!isDefined(owner)) {
        printLn("Player " + playerName + "not found!");
      }
    }
    SetDevDvar("scr_usekillstreak", "");
  }

  if(getDvar("scr_playertoorigin") != "") {
    tokens = strTok(getDvar("scr_playertoorigin"), " ");

    newOrigin = (int(tokens[0]), int(tokens[1]), int(tokens[2]));

    playerName = tokens[3];
    foreach(player in level.players) {
      if(player.name == playerName) {
        player setOrigin(newOrigin);
        break;
      }
    }

    SetDevDvar("scr_playertoorigin", "");
  }

  if(getDvar("scr_playerposangles") != "") {
    tokens = strTok(getDvar("scr_playerposangles"), " ");

    newOrigin = (int(tokens[0]), int(tokens[1]), int(tokens[2]));
    newAngles = (int(tokens[3]), int(tokens[4]), int(tokens[5]));

    foreach(player in level.players) {
      player setOrigin(newOrigin);
      player SetPlayerAngles(newAngles);
    }

    SetDevDvar("scr_playerposangles", "");
  }

  if(getDvar("scr_levelnotify") != "") {
    level notify(getDvar("scr_levelnotify"));
    SetDevDvar("scr_levelnotify", "");
  }

  if(getDvar("scr_giveperk") != "") {
    perk = getDvar("scr_giveperk");

    for(i = 0; i < level.players.size; i++) {
      level.players[i] thread givePerk(perk, false);
    }

    SetDevDvar("scr_giveperk", "");
  }
  if(getDvar("scr_takeperk") != "") {
    perk = getDvar("scr_takeperk");
    for(i = 0; i < level.players.size; i++) {
      level.players[i] unsetPerk(perk, true);
      level.players[i].extraPerks[perk] = undefined;
    }
    SetDevDvar("scr_takeperk", "");
  }

  if(getDvar("scr_x_kills_y") != "") {
    nameTokens = strTok(getDvar("scr_x_kills_y"), " ");
    if(nameTokens.size > 1) {
      thread xKillsY(nameTokens[0], nameTokens[1]);
    }

    SetDevDvar("scr_x_kills_y", "");
  }

  if(getDvar("scr_enemykillhost") != "") {
    hostPlayer = undefined;
    enemyPlayer = undefined;
    foreach(player in level.players) {
      if(!player isHost()) {
        continue;
      }

      hostPlayer = player;
      break;
    }

    foreach(player in level.players) {
      if(level.teamBased) {
        if(player.team == hostPlayer.team) {
          continue;
        }

        enemyPlayer = player;
        break;
      } else {
        if(player isHost()) {
          continue;
        }

        enemyPlayer = player;
        break;
      }
    }

    if(isDefined(enemyPlayer)) {
      thread xKillsY(enemyPlayer.name, hostPlayer.name);
    }

    SetDevDvar("scr_enemykillhost", "");
  }

  if(getDvar("scr_drop_weapon") != "") {
    weapon = spawn("weapon_" + getDvar("scr_drop_weapon"), level.players[0].origin);
    SetDevDvar("scr_drop_weapon", "");
  }

  if(getDvar("scr_set_rank") != "") {
    level.players[0].pers["rank"] = 0;
    level.players[0].pers["rankxp"] = 0;

    newRank = min(GetDvarInt("scr_set_rank"), 54);
    newRank = max(newRank, 1);

    SetDevDvar("scr_set_rank", "");

    if(level.teamBased && (!level.teamCount["allies"] || !level.teamCount["axis"])) {
      println("scr_set_rank may not work because there are not players on both teams");
    } else if(!level.teamBased && (level.teamCount["allies"] + level.teamCount["axis"] < 2)) {
      println("scr_set_rank may not work because there are not at least two players");
    }

    lastXp = 0;
    for(index = 0; index <= newRank; index++) {
      newXp = maps\mp\gametypes\_rank::getRankInfoMinXP(index);
      level.players[0] thread maps\mp\gametypes\_rank::giveRankXP("kill", newXp - lastXp);
      lastXp = newXp;
      wait(0.25);
      self notify("cancel_notify");
    }
  }

  if(getDvar("scr_givexp") != "") {
    level.players[0] thread maps\mp\gametypes\_rank::giveRankXP("challenge", GetDvarInt("scr_givexp"));

    SetDevDvar("scr_givexp", "");
  }

  if(getDvar("scr_do_notify") != "") {
    for(i = 0; i < level.players.size; i++) {
      level.players[i] maps\mp\gametypes\_hud_message::oldNotifyMessage(getDvar("scr_do_notify"), getDvar("scr_do_notify"), game["icons"]["allies"]);
    }

    announcement(getDvar("scr_do_notify"));
    SetDevDvar("scr_do_notify", "");
  }

  if(getDvar("scr_spam_splashes") != "") {
    foreach(player in level.players) {
      player thread maps\mp\gametypes\_hud_message::splashNotifyDelayed("longshot");
      player thread maps\mp\gametypes\_hud_message::splashNotifyDelayed("headshot");
      player thread maps\mp\gametypes\_hud_message::challengeSplashNotify("ch_marksman_iw5_m4", 0, 1);
      player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify("uav", 3);
      level thread teamPlayerCardSplash("used_emp", player, player.team);
      player thread maps\mp\gametypes\_rank::updateRankAnnounceHUD();

      player SetCardDisplaySlot(player, 8);
      player openMenu("youkilled_card_display");
      wait(2.0);
      player SetCardDisplaySlot(player, 7);
      player openMenu("killedby_card_display");
    }

    SetDevDvar("scr_spam_splashes", "");
  }

  if(getDvar("scr_spam_usedsplash") != "") {
    foreach(player in level.players) {
      level thread teamPlayerCardSplash("used_emp", player, player.team);
      level thread teamPlayerCardSplash("used_sentry", player, player.team);
      level thread teamPlayerCardSplash("used_remote_mg_turret", player, player.team);
    }

    SetDevDvar("scr_spam_usedsplash", "");
  }

  if(getDvar("scr_spam_eventsplash") != "") {
    foreach(player in level.players) {
      level thread teamPlayerCardSplash("callout_firstblood", player);
      level thread teamPlayerCardSplash("callout_flagpickup", player);
      level thread teamPlayerCardSplash("callout_lastenemyalive", player);
      level thread teamPlayerCardSplash("callout_lastteammemberalive", player);
      level thread teamPlayerCardSplash("callout_eliminated", player);
      level thread teamPlayerCardSplash("callout_destroyed_helicopter_flares", player);
      level thread teamPlayerCardSplash("callout_destroyed_little_bird", player);
      level thread teamPlayerCardSplash("callout_bombdefused", player);
      level thread teamPlayerCardSplash("callout_3xpluskill", player);
    }

    SetDevDvar("scr_spam_eventsplash", "");
  }

  if(getDvar("scr_spam_boteventsplash") != "") {
    notBot = getNotBot();
    bot = getBot(notBot);

    level thread teamPlayerCardSplash("callout_firstblood", bot);
    level thread teamPlayerCardSplash("callout_flagpickup", bot);
    level thread teamPlayerCardSplash("callout_lastenemyalive", bot);
    level thread teamPlayerCardSplash("callout_lastteammemberalive", bot);
    level thread teamPlayerCardSplash("callout_eliminated", bot);
    level thread teamPlayerCardSplash("callout_destroyed_helicopter_flares", bot);
    level thread teamPlayerCardSplash("callout_destroyed_little_bird", bot);
    level thread teamPlayerCardSplash("callout_bombdefused", bot);
    level thread teamPlayerCardSplash("callout_3xpluskill", bot);

    SetDevDvar("scr_spam_boteventsplash", "");
  }

  if(getDvar("scr_spam_ranksplash") != "") {
    foreach(player in level.players) {
      player thread rankSplash(5, 2.0);
    }

    SetDevDvar("scr_spam_ranksplash", "");
  }

  if(getDvar("scr_show_splash") != "") {
    splashName = getDvar("scr_show_splash");
    splashValue = 1;
    splashType = tableLookup("mp/splashTable.csv", 0, splashName, 11);

    if(splashType == "" || splashType == "none") {
      println("splash not found in splash table");
    } else {
      switch (splashType) {
        case "urgent_splash":
          foreach(player in level.players) {
            player thread maps\mp\gametypes\_hud_message::splashNotifyUrgent(splashName, splashValue);
          }
          break;
        case "playercard_splash":
          foreach(player in level.players) {
            player thread maps\mp\gametypes\_hud_message::playerCardSplashNotify(splashName, player, splashValue);
          }
          break;

        case "splash":
          foreach(player in level.players) {
            player thread maps\mp\gametypes\_hud_message::splashNotify(splashName, splashValue);
          }
          break;
        case "killstreak_splash":
          foreach(player in level.players) {
            player thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(splashName, splashValue);
          }
          break;
        case "challenge_splash":

        case "daily_challenge":
        case "weekly_challenge":
          foreach(player in level.players) {
            player ch_setState(splashName, 2);
            player.challengeData[splashName] = 2;
            player thread maps\mp\gametypes\_hud_message::challengeSplashNotify(splashName, 1, 2);
          }
          break;

        default:
          break;
      }
    }
    SetDevDvar("scr_show_splash", "");
  }

  if(getDvar("scr_spam_obit") != "") {
    for(i = 0; i < 10; i++) {
      IPrintLn("hateURFace killed testURFace");
      wait(1.0);
    }

    SetDevDvar("scr_spam_obit", "");
  }

  if(getDvar("scr_spam_player_promoted") != "") {
    for(i = 0; i < 10; i++) {
      foreach(player in level.players) {
        newRankName = player maps\mp\gametypes\_rank::getRankInfoFull(i + 2);
        player IPrintLn(&"RANK_PLAYER_WAS_PROMOTED", player, newRankName);
        wait(1.0);
      }
    }

    SetDevDvar("scr_spam_player_promoted", "");
  }

  if(getDvar("scr_addlower") != "") {
    foreach(player in level.players) {
      player thread testLowerMessage();
    }

    SetDevDvar("scr_addlower", "");
  }

  if(getDvar("scr_entdebug") != "") {
    ents = getEntArray();
    level.entArray = [];
    level.entCounts = [];
    level.entGroups = [];
    for(index = 0; index < ents.size; index++) {
      classname = ents[index].classname;
      if(!isSubStr(classname, "_spawn")) {
        curEnt = ents[index];

        level.entArray[level.entArray.size] = curEnt;

        if(!isDefined(level.entCounts[classname])) {
          level.entCounts[classname] = 0;
        }

        level.entCounts[classname]++;

        if(!isDefined(level.entGroups[classname])) {
          level.entGroups[classname] = [];
        }

        level.entGroups[classname][level.entGroups[classname].size] = curEnt;
      }
    }
  }

  if(getDvar("scr_sre") != "") {
    assertmsg("Testing script runtime error");
    SetDevDvar("scr_sre", "");
  }

  if(getDvar("scr_testmigration") != "") {
    SetDevDvar("scr_testmigration", "");
    thread maps\mp\gametypes\_hostmigration::Callback_HostMigration();
    thread hostMigrationEndTimer_dev();
  }

  if(getDvar("scr_show_endgameupdate") != "") {
    promotion = (getDvar("scr_show_endgameupdate") == "2");

    foreach(player in level.players) {
      player thread testEndGameUpdate(promotion);
    }

    SetDevDvar("scr_show_endgameupdate", "");
  }

  if(getDvar("scr_goto_spawn") != "") {
    if(getDvar("scr_goto_spawn") == "next") {
      gotoNextspawn();
    } else if(getDvar("scr_goto_spawn") == "prev") {
      gotoPrevspawn();
    }

    SetDevDvar("scr_goto_spawn", "");
  }

  if(getDvar("scr_goto_start_spawn") != "") {
    if(getDvar("scr_goto_start_spawn") == "next") {
      gotoNextStartspawn();
    } else if(getDvar("scr_goto_start_spawn") == "prev") {
      gotoPrevStartspawn();
    }

    SetDevDvar("scr_goto_start_spawn", "");
  }

  if(getDvar("scr_showOrigin") != "") {
    ent = undefined;

    if(isDefined(level.player)) {
      ent = level.player;
    } else if(isDefined(level.players[0])) {
      ent = level.players[0];
    }

    if(isDefined(ent)) {
      println("Player origin - X: " + ent.origin[0] + ", Y: " + ent.origin[1] + ", Z: " + ent.origin[2]);
    } else {
      println("NO PLAYER");
    }

    SetDevDvar("scr_showOrigin", "");
  }

  foreach(player in level.players) {
    if(!IsBot(player) && !IsTestClient(player)) {
      if(!isDefined(player.dev_init)) {
        player.dev_init = true;
        player thread monitorTagNoteworthyEvent();
      }
    }
  }

  if(GetDvarInt("scr_devKillDog") > 0) {
    all_dogs = getActiveAgentsOfType("dog");
    foreach(dog in all_dogs) {
      dog maps\mp\agents\_agent_utility::killDog();
    }

    SetDevDvar("scr_devKillDog", 0);
  }

  if(GetDvarInt("scr_devKillAgents") > 0) {
    active_agents = getActiveAgentsOfType("all");
    foreach(agent in active_agents) {
      killAgent(agent);
    }

    SetDevDvar("scr_devKillAgents", 0);
  }

  if(GetDvarInt("scr_devGiveFemaleHead") > 0) {
    notBot = level.players[0];

    notBot Detach(notBot.headModel);
    notBot Attach("head_mp_test_military_head_r", "", true);
    notBot.headModel = "head_mp_test_military_head_r";

    SetDevDvar("scr_devGiveFemaleHead", 0);
  }

  if(GetDvarInt("scr_devGiveMaleHead") > 0) {
    notBot = level.players[0];

    notBot Detach(notBot.headModel);
    notBot Attach("head_mp_test_military_head_a", "", true);
    notBot.headModel = "head_mp_test_military_head_a";

    SetDevDvar("scr_devGiveMaleHead", 0);
  }

  if(getDvar("scr_devGiveKillstreakModule") != "") {
    player = level.players[0];
    module = getDvar("scr_devGiveKillstreakModule");
    if(!isDefined(player.killStreakModules[module])) {
      cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
      player.killStreakModules[module] = cost;
    } else {
      player.killStreakModules[module] = undefined;
    }
    SetDevDvar("scr_devGiveKillstreakModule", "");
  }

  if(getDvar("scr_devGiveBotsKillstreakModule") != "") {
    module = getDvar("scr_devGiveBotsKillstreakModule");
    foreach(player in level.players) {
      if(!IsBot(player) && !IsTestClient(player)) {
        continue;
      }

      if(!isDefined(player.killStreakModules[module])) {
        cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
        player.killStreakModules[module] = cost;
      } else {
        player.killStreakModules[module] = undefined;
      }
    }
    SetDevDvar("scr_devGiveBotsKillstreakModule", "");
  }

  if(getDvar("scr_devGiveScore") != "") {
    player = level.players[0];
    scoreType = getDvar("scr_devGiveScore");
    level thread maps\mp\gametypes\_rank::awardGameEvent(scoreType, player);
    SetDevDvar("scr_devGiveScore", "");
  }

  if(getDvar("scr_devGiveScoreToAll") != "") {
    scoreType = getDvar("scr_devGiveScoreToAll");
    foreach(player in level.players) {
      level thread maps\mp\gametypes\_rank::awardGameEvent(scoreType, player);
    }
    SetDevDvar("scr_devGiveScoreToAll", "");
  }

  if(GetDvarInt("scr_ammoRegen") != 0) {
    foreach(player in level.players) {
      if(!isDefined(player.ammoRegen) || (player.ammoRegen == false)) {
        player thread devPlayerAmmoRegen();
      }
    }
  }
}

devPlayerAmmoRegen() {
  selfendon("disconnect");
  level endon("game_ended");

  regen_interval = 0.12;
  self.ammoRegen = true;

  while(true) {
    if(GetDvarInt("scr_ammoRegen") == 0) {
      self.ammoRegen = false;
      break;
    }

    currentWeapon = self GetCurrentPrimaryWeapon();

    if(maps\mp\gametypes\_weapons::isPrimaryWeapon(currentWeapon)) {
      ammoStock = self GetWeaponAmmoStock(currentWeapon);
      self SetWeaponAmmoStock(currentWeapon, ammoStock + 1);
    }

    wait(regen_interval);
  }
}

devUpdateHordeSettings() {
  if(isDefined(level.hordeLocalUpdate)) {
    level thread[[level.hordeLocalUpdate]]();
  }
}

rankSplash(increments, delay) {
  for(i = 0; i < increments; i++) {
    self thread maps\mp\gametypes\_rank::updateRankAnnounceHUD();
    wait(delay);
  }
}

testEndGameUpdate(promotion) {
  self setClientDvars("ui_challenge_1_ref", "ch_nosecrets", "ui_challenge_2_ref", "ch_nosecrets_daily", "ui_challenge_3_ref", "ch_nosecrets_weekly", "ui_challenge_4_ref", "ch_uav", "ui_challenge_6_ref", "ch_grenadekill", "ui_challenge_7_ref", "ch_noboomforyou");

  if(isDefined(promotion) && promotion) {
    self setClientDvar("ui_promotion", 1);
  } else {
    self setClientDvar("ui_promotion", 0);
  }

  self closepopupMenu();
  self closeInGameMenu();

  self openMenu(game["menu_endgameupdate"]);

  waitTime = 4.0 + min(7, 3);
  while(waitTime) {
    wait(0.25);
    waitTime -= 0.25;

    self openMenu(game["menu_endgameupdate"]);
  }

  self closeMenu(game["menu_endgameupdate"]);
}

hostMigrationEndTimer_dev() {
  level endon("host_migration_begin");
  wait randomfloat(20);
  level notify("hostmigration_enoughplayers");
}

testLowerMessage() {
  self setLowerMessage("spawn_info", game["strings"]["waiting_to_spawn"], 10);
  wait(3.0);

  self setLowerMessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, 50);
  wait(3.0);

  self clearLowerMessage("last_stand");
  wait(10.0);

  self clearLowerMessage("spawn_info");
}

giveExtraPerks() {
  if(!isDefined(self.extraPerks)) {
    return;
  }

  perks = getArrayKeys(self.extraPerks);

  for(i = 0; i < perks.size; i++) {
    self givePerk(perks[i], false);
  }
}

xKillsY(attackerName, victimName) {
  attacker = undefined;
  victim = undefined;

  for(index = 0; index < level.players.size; index++) {
    if(level.players[index].name == attackerName) {
      attacker = level.players[index];
    } else if(level.players[index].name == victimName) {
      victim = level.players[index];
    }
  }

  if(!isAlive(attacker) || !isAlive(victim)) {
    return;
  }

  victim thread[[level.callbackPlayerDamage]](
    attacker, attacker, 500, 0, "MOD_RIFLE_BULLET", "scar_mp", (0, 0, 0), (0, 0, 0), "none", 0
  );
}

updateMinimapSetting() {
  requiredMapAspectRatio = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level.minimapheight)) {
    SetDevDvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }
  minimapheight = getdvarfloat("scr_minimap_height");
  if(minimapheight != level.minimapheight) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }

    if(minimapheight > 0) {
      level.minimapheight = minimapheight;

      players = getEntArray("player", "classname");
      if(players.size > 0) {
        player = players[0];

        corners = getEntArray("minimap_corner", "targetname");
        if(corners.size == 2) {
          viewpos = (corners[0].origin + corners[1].origin);
          viewpos = (viewpos[0] * .5, viewpos[1] * .5, viewpos[2] * .5);

          maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
          mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
          if(corners[1].origin[0] > corners[0].origin[0]) {
            maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
          } else {
            mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
          }
          if(corners[1].origin[1] > corners[0].origin[1]) {
            maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
          } else {
            mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
          }

          viewpostocorner = maxcorner - viewpos;
          viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);

          origin = spawn("script_origin", player.origin);

          northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
          eastvector = (northvector[1], 0 - northvector[0], 0);
          disttotop = vectordot(northvector, viewpostocorner);
          if(disttotop < 0) {
            disttotop = 0 - disttotop;
          }
          disttoside = vectordot(eastvector, viewpostocorner);
          if(disttoside < 0) {
            disttoside = 0 - disttoside;
          }

          if(requiredMapAspectRatio > 0) {
            mapAspectRatio = disttoside / disttotop;
            if(mapAspectRatio < requiredMapAspectRatio) {
              incr = requiredMapAspectRatio / mapAspectRatio;
              disttoside *= incr;
              addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
              mincorner -= addvec;
              maxcorner += addvec;
            } else {
              incr = mapAspectRatio / requiredMapAspectRatio;
              disttotop *= incr;
              addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
              mincorner -= addvec;
              maxcorner += addvec;
            }
          }

          if(level.console) {
            aspectratioguess = 16.0 / 9.0;

            angleside = 2 * atan(disttoside * .8 / minimapheight);
            angletop = 2 * atan(disttotop * aspectratioguess * .8 / minimapheight);
          } else {
            aspectratioguess = 4.0 / 3.0;
            angleside = 2 * atan(disttoside / minimapheight);
            angletop = 2 * atan(disttotop * aspectratioguess / minimapheight);
          }
          if(angleside > angletop) {
            angle = angleside;
          } else {
            angle = angletop;
          }

          znear = minimapheight - 1000;
          if(znear < 16) znear = 16;
          if(znear > 10000) znear = 10000;

          player playerlinkto(origin);
          origin.origin = viewpos + (0, 0, -62);
          origin.angles = (90, getnorthyaw(), 0);

          player TakeAllWeapons();
          player _giveWeapon("defaultweapon_mp");
          DevSetMinimapDvarSettings(znear, angle);

          if(isDefined(level.objPoints)) {
            for(i = 0; i < level.objPointNames.size; i++) {
              if(isDefined(level.objPoints[level.objPointNames[i]])) {
                level.objPoints[level.objPointNames[i]] destroy();
              }
            }
            level.objPoints = [];
            level.objPointNames = [];
          }

          level.minimapplayer = player;
          level.minimaporigin = origin;

          thread drawMiniMapBounds(viewpos, mincorner, maxcorner);

          wait .05;

          player setplayerangles(origin.angles);
        } else {
          println("^1Error: There are not exactly 2 \"minimap_corner\" entities in the level.");
        }
      } else {
        SetDevDvar("scr_minimap_height", "0");
      }
    }
  }
}

vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

drawMiniMapBounds(viewpos, mincorner, maxcorner) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");

  viewheight = (viewpos[2] - maxcorner[2]);

  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);

  diaglen = length(mincorner - maxcorner);

  mincorneroffset = (mincorner - viewpos);
  mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
  mincorner = mincorner + vecscale(mincorneroffset, diaglen * 1 / 800);
  maxcorneroffset = (maxcorner - viewpos);
  maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
  maxcorner = maxcorner + vecscale(maxcorneroffset, diaglen * 1 / 800);

  diagonal = maxcorner - mincorner;
  side = vecscale(north, vectordot(diagonal, north));
  sidenorth = vecscale(north, abs(vectordot(diagonal, north)));

  corner0 = mincorner;
  corner1 = mincorner + side;
  corner2 = maxcorner;
  corner3 = maxcorner - side;

  toppos = vecscale(mincorner + maxcorner, .5) + vecscale(sidenorth, .51);
  textscale = diaglen * .003;

  while(1) {
    line(corner0, corner1, (0, 1, 0));
    line(corner1, corner2, (0, 1, 0));
    line(corner2, corner3, (0, 1, 0));
    line(corner3, corner0, (0, 1, 0));

    print3d(toppos, "This Side Up", (1, 1, 1), 1, textscale);

    wait .05;
  }
}

initTestClientLatent(team, connecting) {
  while(!self CanSpawnTestClient()) {
    wait(0.05);

    if(!isDefined(self)) {
      if(isDefined(connecting)) {
        connecting.abort = true;
      }
      return;
    }
  }

  self SpawnTestClient();

  self maps\mp\gametypes\_playerlogic::spawnSpectator();

  while(!isDefined(self.pers["team"])) {
    wait(0.05);

    if(!isDefined(self)) {
      if(isDefined(connecting)) {
        connecting.abort = true;
      }
      return;
    }
  }

  self[[level.autoassign]]();

  if(allowClassChoice()) {
    class = "class" + randomInt(5);
    self notify("luinotifyserver", "class_select", class);
  }

  self waittill_notify_or_timeout("spawned_player", 0.5);
  wait(0.10);

  if(isDefined(connecting)) {
    connecting.ready = true;
  }
}

bot_player_class_spawn_callback() {
  self.override_class_function = ::bot_setup_callback_player_class;
}

bot_setup_callback_player_class() {
  self.classCallback = ::bot_loadout_player_class_callback;
  return "callback";
}

get_loadout_weapon_attachments(fullWeaponName, baseWeaponName) {
  attachments = [];

  weapAttachments = GetWeaponAttachments(fullWeaponName);
  if(isDefined(weapAttachments)) {
    foreach(attachment in weapAttachments) {
      attachments[attachments.size] = attachment;
    }
  }

  for(i = attachments.size; i < 3; i++) {
    attachments[i] = "none";
  }

  return attachments;
}

bot_loadout_player_class_callback() {
  if(isDefined(self.botLastLoadout)) {
    return self.botLastLoadout;
  }

  assert(isDefined(level.player));

  primaryWeapon = "none";
  primaryWeaponBaseName = "none";
  secondaryWeapon = "none";
  secondaryWeaponBaseName = "none";

  currentPrimaryWeapon = level.player GetCurrentPrimaryWeapon();
  currentPrimaryWeaponBase = GetWeaponBaseName(currentPrimaryWeapon);
  currentPrimaryWeaponBase = maps\mp\_utility::strip_suffix(currentPrimaryWeaponBase, "_mp");

  primaryWeapons = level.player GetWeaponsListPrimaries();
  foreach(playerWeapon in primaryWeapons) {
    baseName = GetWeaponBaseName(playerWeapon);
    baseName = maps\mp\_utility::strip_suffix(baseName, "_mp");

    if(baseName == currentPrimaryWeaponBase) {
      primaryWeapon = playerWeapon;
      primaryWeaponBaseName = baseName;
    } else {
      secondaryWeapon = playerWeapon;
      secondaryWeaponBaseName = baseName;
    }
  }

  attachments = get_loadout_weapon_attachments(primaryWeapon, primaryWeaponBaseName);

  loadoutValueArray["loadoutPrimary"] = primaryWeaponBaseName;
  loadoutValueArray["loadoutPrimaryAttachment"] = attachments[0];
  loadoutValueArray["loadoutPrimaryAttachment2"] = attachments[1];
  loadoutValueArray["loadoutPrimaryAttachment3"] = attachments[2];
  loadoutValueArray["loadoutPrimaryCamo"] = tableLookup("mp/camoTable.csv", 0, level.player.loadoutPrimaryCamo, 1);
  loadoutValueArray["loadoutPrimaryReticle"] = tableLookup("mp/reticleTable.csv", 0, level.player.loadoutPrimaryReticle, 1);

  attachments = get_loadout_weapon_attachments(secondaryWeapon, secondaryWeaponBaseName);

  loadoutValueArray["loadoutSecondary"] = secondaryWeaponBaseName;
  loadoutValueArray["loadoutSecondaryAttachment"] = attachments[0];
  loadoutValueArray["loadoutSecondaryAttachment2"] = attachments[1];
  loadoutValueArray["loadoutSecondaryAttachment3"] = attachments[2];
  loadoutValueArray["loadoutSecondaryCamo"] = tableLookup("mp/camoTable.csv", 0, level.player.loadoutSecondaryCamo, 1);
  loadoutValueArray["loadoutSecondaryReticle"] = tableLookup("mp/reticleTable.csv", 0, level.player.loadoutSecondaryReticle, 1);

  loadoutValueArray["loadoutEquipment"] = level.player.loadoutEquipment;
  loadoutValueArray["loadoutOffhand"] = level.player.loadoutOffhand;

  perkIdx = 1;
  foreach(perk in level.player.loadoutPerks) {
    loadoutValueArray["loadoutPerk" + perkIdx] = perk;
    perkIdx++;
  }

  wildcardIdx = 1;
  foreach(wildcard in level.player.loadoutWildcards) {
    loadoutValueArray["loadoutWildcard" + wildcardIdx] = wildcard;
    wildcardIdx++;
  }

  killstreakIdx = 1;
  foreach(killstreak in level.player.killstreaks) {
    loadoutValueArray["loadoutStreak" + killstreakIdx] = killstreak;
    killstreakIdx++;
  }

  self.botLastLoadout = loadoutValueArray;

  return loadoutValueArray;
}

addTestClients() {
  wait 5;

  for(;;) {
    if(getdvarInt("scr_testclients") > 0) {
      break;
    }
    wait 1;
  }

  testclients = getdvarInt("scr_testclients");
  println("[BOTS] Attempting to spawn " + testclients + " test clients");
  SetDevDvar("scr_testclients", 0);

  fullBots = testClients_SpawnFullBots();
  println("[BOTS] Test clients are full bots: " + fullBots);

  botCallback = undefined;
  usePlayerLoadout = getdvarInt("scr_testclients_class") == 1;
  if(usePlayerLoadout) {
    println("[BOTS] Test clients use player loadout");
    if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_spawn"])) {
      botCallback = ::bot_player_class_spawn_callback;
    }
  }
  SetDevDvar("scr_testclients_class", 0);

  if(testclients) {
    setDvar("bot_DisableAutoConnect", "1");
  }

  if(fullBots) {
    team = getDvar("scr_botsForceSpawnTeam");
    println("[BOTS] Spawning bots on team: " + team);
    level thread[[level.bot_funcs["bots_spawn"]]](testclients, team, botCallback);
  } else {
    level spawn_test_clients(testclients);
  }

  if(matchMakingGame()) {
    setMatchData("hasBots", true);
  }

  thread addTestClients();
}

spawn_test_clients(testclients) {
  connectingArray = [];

  while((connectingArray.size < testclients)) {
    wait 0.05;

    tc = AddTestClient(1);

    if(!isDefined(tc)) {
      println("Could not add test client");
      wait 1;
      continue;
    } else {
      connecting = spawnStruct();
      connecting.tc = tc;
      connecting.ready = false;
      connecting.abort = false;

      connectingArray[connectingArray.size] = connecting;

      connecting.tc thread initTestClientLatent("autoassign", connecting);
    }
  }

  connectedComplete = 0;
  while((connectedComplete < connectingArray.size)) {
    connectedComplete = 0;

    foreach(connecting in connectingArray) {
      if(connecting.ready || connecting.abort) {
        connectedComplete++;
      }
    }

    wait 0.05;
  }
}

testClients_SpawnFullBots() {
  fullBots = getdvarInt("scr_testclients_type") == 0;
  if(fullBots) {
    if(!isDefined(level.bot_funcs) || !isDefined(level.bot_funcs["bots_spawn"])) {
      fullBots = false;
    }
  }

  return fullBots;
}

haveTestClientKillPlayer() {
  for(;;) {
    if(getdvarInt("scr_testclients_killplayer") > 0) {
      break;
    }
    wait 1;
  }

  SetDevDvar("scr_testclients_killplayer", 0);

  notBot = getNotBot();
  bot = getBot(notBot, true);

  if(isDefined(bot)) {
    notBot thread[[level.callbackPlayerDamage]](
      bot, bot, 500, 0, "MOD_RIFLE_BULLET", bot.primaryweapon, bot.origin, (0, 0, 0), "none", 0
    );
  }

  wait(1);
  thread haveTestClientKillPlayer();
}

haveTestClientCallKillstreak() {
  for(;;) {
    if(getDvar("scr_testclients_givekillstreak") != "") {
      break;
    }
    wait 1;
  }

  killstreak = getDvar("scr_testclients_givekillstreak");
  SetDevDvar("scr_testclients_givekillstreak", "");

  notBot = getNotBot();
  bot = getBot(notBot, true);

  if(isDefined(level.killstreak_botcanuse[killstreak]) && level.killstreak_botcanuse[killstreak] == maps\mp\bots\_bots_ks::bot_killstreak_do_not_use) {
    level.killstreak_botcanuse[killstreak] = undefined;
    level.killstreak_botfunc[killstreak] = maps\mp\bots\_bots_ks::bot_killstreak_simple_use;
  } else if(killstreak == "assault_ugv") {
    level.killstreak_botcanuse[killstreak] = maps\mp\bots\_bots_ks::bot_can_use_assault_ugv;
  } else if(killstreak == "warbird") {
    level.killstreak_botcanuse[killstreak] = maps\mp\bots\_bots_ks::bot_can_use_warbird;
  } else if(killstreak == "remote_mg_sentry_turret") {
    level.killstreak_botcanuse[killstreak] = undefined;
  }

  if(GetDvarInt("scr_testclients_givekillstreak_onlyspectated")) {
    spectator = undefined;
    foreach(player in level.players) {
      if(player.team == "spectator" || player.sessionstate == "spectator") {
        spectatingPlayer = player GetSpectatingPlayer();
        if(isDefined(spectatingPlayer) && IsBot(spectatingPlayer)) {
          spectatingPlayer botUseKillstreak(killstreak);
        }
      }
    }
  } else if(GetDvarInt("scr_testclients_givekillstreak_onlyhumanteam")) {
    human_team = undefined;
    foreach(player in level.players) {
      if(!IsAI(player)) {
        human_team = player.team;
      }
    }

    if(isDefined(human_team)) {
      foreach(player in level.players) {
        if(player.team == human_team) {
          if(IsBot(player) || IsTestClient(player)) {
            player botUseKillstreak(killstreak);
          }
        }
      }
    }
  } else if(GetDvarInt("scr_testclients_givekillstreak_toggleall")) {
    foreach(player in level.players) {
      if(IsBot(player) || IsTestClient(player)) {
        player botUseKillstreak(killstreak);
      }
    }
  } else if(GetDvarInt("scr_testclients_givekillstreak_toggleall_sametime")) {
    foreach(player in level.players) {
      if(IsBot(player) || IsTestClient(player)) {
        player botUseKillstreak(killstreak);
      }
    }
  } else {
    if(isDefined(bot)) {
      bot botUseKillstreak(killstreak);
    }
  }

  thread haveTestClientCallKillstreak();
}

botUseKillstreak(killstreak) {
  resetEMPDvar = false;
  EMPTime = undefined;
  if(killstreak == "emp_quick") {
    resetEMPDvar = true;
    EMPTime = GetDvarFloat("scr_emp_timeout");
    killstreak = "emp";
    SetDevDvar("scr_emp_timeout", 1.0);
  }

  if(killstreak == "ballistic_vest_on") {
    self maps\mp\perks\_perkfunctions::setLightArmor();
    return;
  }

  if(killstreak == "juggernaut_exosuit") {
    self thread maps\mp\killstreaks\_juggernaut::giveJuggernaut("juggernaut_exosuit", ["heavy_exosuit_radar", "heavy_exosuit_punch", "heavy_exosuit_trophy", "heavy_exosuit_rockets", "heavy_exosuit_ammo"]);
    return;
  }

  if(killstreak == "juggernaut_exosuit_all") {
    self thread maps\mp\killstreaks\_juggernaut::giveJuggernaut("juggernaut_exosuit");
    return;
  }

  if(IsSubStr(killstreak, "remote_mg_sentry_turret_")) {
    if(killstreak == "remote_mg_sentry_turret_laser") {
      self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadenergy_mp");
    } else if(killstreak == "remote_mg_sentry_turret_rocket") {
      self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadrocket_mp");
    } else {
      self thread maps\mp\killstreaks\_rippedturret::playerGiveTurretHead("turretheadmg_mp");
    }
    return;
  }

  self maps\mp\killstreaks\_killstreaks::giveKillstreak(killstreak);

  if(!level.console) {
    self.killstreakIndexWeapon = 0;
  }

  wait(0.1);
  if(!isDefined(self)) {
    return;
  }

  if(IsAI(self)) {
    return;
  }

  switch (killstreak) {
    case "sentry":
      self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
      wait(1.0);
      self notify("place_sentry");
      break;
    case "remote_mg_sentry_turret":
    case "remote_mg_turret":
      self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
      wait(1.0);
      self notify("place_turret");
      break;
    case "orbital_laser":
      self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
      wait(1.0);
      self notify("confirm_location", level.mapCenter - (600, 0, 0), 0);
      wait(0.05);
      self notify("confirm_location", level.mapCenter, 0);
      wait(0.05);
      self notify("confirm_location", level.mapCenter + (600, 0, 0), 0);
      break;
    default:
      self thread maps\mp\killstreaks\_killstreaks::killstreakUsePressed();
      break;
  }

  if(resetEMPDvar) {
    level thread waitResetDvar(1.0, "scr_emp_timeout", EMPTime);
  }
}

waitResetDvar(waitTime, dvarName, dvarValue) {
  wait(waitTime);
  SetDevDvar(dvarName, dvarValue);
}

haveTestClientPlantExplosive() {
  for(;;) {
    if(getDvar("scr_testclients_plantexplosive") != "") {
      break;
    }
    wait 1;
  }

  explosive = getDvar("scr_testclients_plantexplosive");
  SetDevDvar("scr_testclients_plantexplosive", "");

  notBot = getNotBot();
  bot = getBot(notBot);

  if(isDefined(bot)) {
    trace = bulletTrace(bot.origin + (0, 0, 4), bot.origin - (0, 0, 4), false, bot);
    normal = vectornormalize(trace["normal"]);
    plantAngles = vectortoangles(normal);
    plantAngles += (90, 0, 0);

    switch (explosive) {
      case "bouncing_betty":
        mine = bot maps\mp\gametypes\_weapons::spawnMine(bot.origin, bot, plantAngles);
        mine.trigger = spawn("script_origin", mine.origin + (0, 0, 25));
        mine thread maps\mp\gametypes\_weapons::equipmentWatchUse(bot);
        mine.killCamEnt = spawn("script_model", mine.origin + (0, 0, 5));
        mine.killCamEnt SetScriptMoverKillCam("explosive");
        break;

      case "claymore":
        break;

      case "tracking_drone":
        bot maps\mp\_tracking_drone::tryUseTrackingDrone("tracking_drone_mp");
        break;
    }
  }

  thread haveTestClientPlantExplosive();
}

haveTestClientFireRocket() {
  for(;;) {
    if(getDvar("scr_testclients_firerocket") != "") {
      break;
    }
    wait 1;
  }

  notBot = getNotBot();
  bot = getBot(notBot);

  if(isDefined(bot)) {
    direction = anglesToForward(bot.angles);
    eye = bot getEye();

    newRocket = MagicBullet("rpg_mp", eye + direction * 20, eye + direction * 100, bot);
  }

  wait 3;

  thread haveTestClientFireRocket();
}

addTestClientJuggernaut() {
  for(;;) {
    if(getDvar("scr_testclients_jugg") != "") {
      break;
    }
    wait 1;
  }

  juggType = getDvar("scr_testclients_jugg");
  SetDevDvar("scr_testclients_jugg", "");

  notBot = level.players[0];
  foreach(player in level.players) {
    if(!IsAI(player)) {
      notBot = player;
      break;
    }
  }

  bot = getBot(notBot);

  if(isDefined(bot)) {
    bot thread maps\mp\killstreaks\_juggernaut::giveJuggernaut(juggType);
  }

  thread addTestClientJuggernaut();
}

addTestClientSpawnPoint() {
  for(;;) {
    if(GetDvarInt("scr_testclients_spawnpoint") > 0) {
      break;
    }
    wait 1;
  }

  notBot = getNotBot();

  if(!isDefined(notBot)) {
    SetDevDvar("scr_testclients_spawnpoint", 0);
    thread addTestClientSpawnPoint();
    return;
  }
  if(!IsAlive(notBot)) {
    SetDevDvar("scr_testclients_spawnpoint", 0);
    thread addTestClientSpawnPoint();
    return;
  }

  markerPos = bulletTrace(notBot getEye(), notBot.origin + (anglesToForward(notBot GetPlayerAngles()) * 10000), false, notBot);
  marker = spawn("script_model", markerPos["position"]);

  marker setModel("projectile_bouncing_betty_grenade");

  trace = bulletTrace(marker.origin + (0, 0, 50), marker.origin + (0, 0, -100), false, marker);
  marker.origin = trace["position"];

  marker thread showFX();

  while(GetDvarInt("scr_testclients_spawnpoint") > 0) {
    markerPos = bulletTrace(notBot getEye(), notBot.origin + (anglesToForward(notBot GetPlayerAngles()) * 10000), false, marker);
    marker.origin = markerPos["position"];

    trace = bulletTrace(marker.origin + (0, 0, 50), marker.origin + (0, 0, -100), false, marker);
    marker.origin = trace["position"];

    if(notBot useButtonPressed()) {
      ent = addtestclient(1);

      if(!isDefined(ent)) {
        PrintLn("Could not add test client");
        wait 1;
        continue;
      }

      ent initTestClientLatent(getOtherTeam(notBot.team));

      ent setOrigin(marker.origin);
      ent.forceSpawnOrigin = marker.origin;

      if(matchMakingGame()) {
        setMatchData("hasBots", true);
      }

      break;
    }

    wait(0.05);
  }

  marker delete();
  SetDevDvar("scr_testclients_spawnpoint", 0);
  thread addTestClientSpawnPoint();
}

showFX() {
  self endon("death");
  wait(1.0);
  playFXOnTag(level.devSpawnFXid, self, "tag_fx");
}

warpEnemies() {
  for(;;) {
    if(getdvarInt("scr_warpenemies") > 0) {
      break;
    }
    wait 1;
  }

  SetDevDvar("scr_warpenemies", 0);

  notBot = undefined;
  foreach(character in level.characters) {
    if(isPlayer(character) && !IsBot(character)) {
      notBot = character;
      break;
    }
  }

  if(!isDefined(notBot)) {
    return;
  }

  foreach(character in level.characters) {
    if(level.teambased) {
      if(character.team != notBot.team) {
        character setOrigin(notBot.origin);
      }
    } else {
      character setOrigin(notBot.origin);
    }
  }

  thread warpEnemies();
}

warpFriendlies() {
  for(;;) {
    if(getdvarInt("scr_warpfriendlies") > 0) {
      break;
    }
    wait 1;
  }

  SetDevDvar("scr_warpfriendlies", 0);

  notBot = undefined;
  foreach(character in level.characters) {
    if(isPlayer(character) && !IsBot(character)) {
      notBot = character;
      break;
    }
  }

  if(!isDefined(notBot)) {
    return;
  }

  foreach(character in level.characters) {
    if(level.teambased) {
      if(character.team == notBot.team) {
        character setOrigin(notBot.origin);
      }
    }
  }

  thread warpFriendlies();
}

giveEquipment() {
  for(;;) {
    if(getDvar("scr_giveequipment") != "") {
      break;
    }
    wait 1;
  }

  equipment = getDvar("scr_giveequipment");

  if(isDefined(equipment)) {
    foreach(player in level.players) {
      weaponList = player GetWeaponsListOffhands();
      foreach(weapon in weaponList) {
        player maps\mp\gametypes\_class::takeOffhand(weapon);
      }

      if(player _hasPerk("specialty_wildcard_duallethals")) {
        equipment = equipment + "_lefthand";
        player SetTacticalWeapon(equipment);
      } else {
        player SetLethalWeapon(equipment);
      }

      player maps\mp\gametypes\_class::giveOffhand(equipment);
    }
  }

  SetDevDvar("scr_giveequipment", "");

  thread giveEquipment();
}

giveSpecialGrenade() {
  for(;;) {
    if(getDvar("scr_givespecialgrenade") != "") {
      break;
    }
    wait 1;
  }

  equipment = getDvar("scr_givespecialgrenade");

  if(isDefined(equipment)) {
    foreach(player in level.players) {
      weaponList = player GetWeaponsListOffhands();
      foreach(weapon in weaponList) {
        player maps\mp\gametypes\_class::takeOffhand(weapon);
      }

      if(player _hasPerk("specialty_wildcard_dualtacticals")) {
        player SetLethalWeapon(equipment);
      } else {
        player SetTacticalWeapon(equipment);
      }
      player maps\mp\gametypes\_class::giveOffhand(equipment);
    }
  }

  SetDevDvar("scr_givespecialgrenade", "");

  thread giveSpecialGrenade();
}

initForWeaponTests() {
  if(isDefined(self.initForWeaponTests)) {
    return;
  }

  self.initForWeaponTests = true;

  self thread changeCamoListener();
  self thread thirdPersonToggle();

  self waittill_any("death", "quit_weapon_test");
  self.initForWeaponTests = undefined;
}

setTestWeapon(weaponName) {
  if(weaponName == "quit") {
    self notify("quit_weapon_test");
    return;
  }

  if(weaponName == "combatknife") {
    self takeAllWeapons();
    wait(0.05);
    self giveWeapon("iw5_combatknife_mp", -1, false);
    self switchToWeapon("iw5_combatknife_mp");

    self notify("quit_weapon_test");
    return;
  }

  if(!isDefined(level.baseWeaponList[weaponName])) {
    self iPrintLnBold("Unknown weapon: " + weaponName);
    return;
  }

  self notify("new_test_weapon");
  self.baseWeapon = weaponName;
  self thread weaponChangeListener();

  self updateTestWeapon();
}

thirdPersonToggle() {
  self endon("death");
  self endon("quit_weapon_test");
  self notifyOnPlayerCommand("dpad_down", "+actionslot 2");

  thirdPersonElem = self createFontString("default", 1.5);
  thirdPersonElem setPoint("TOPRIGHT", "TOPRIGHT", 0, 72 + 260);
  thirdPersonElem SetDevText("3rd Person: " + GetDvarInt("camera_thirdPerson") + "[{+actionslot 2}]");
  self thread destroyOnDeath(thirdPersonElem);

  for(;;) {
    self waittill("dpad_down");

    setDvar("camera_thirdPerson", !GetDvarInt("camera_thirdPerson"));

    thirdPersonElem SetDevText("3rd Person: " + GetDvarInt("camera_thirdPerson") + "[{+actionslot 2}]");
  }
}

changeCamoListener() {
  self endon("death");
  self endon("quit_weapon_test");
  self notifyOnPlayerCommand("dpad_up", "+actionslot 1");

  camoList = [];

  for(rowIndex = 0; tableLookupByRow("mp/camoTable.csv", rowIndex, 1) != ""; rowIndex++) {
    camoList[camoList.size] = tableLookupByRow("mp/camoTable.csv", rowIndex, 1);
  }

  self.camoIndex = 0;

  camoElem = self createFontString("default", 1.5);
  camoElem setPoint("TOPRIGHT", "TOPRIGHT", 0, 52 + 260);
  camoElem SetDevText("Camo: " + tableLookup("mp/camoTable.csv", 0, self.camoIndex, 1) + "[{+actionslot 1}]");
  self thread destroyOnDeath(camoElem);

  for(;;) {
    self waittill("dpad_up");

    self.camoIndex++;
    if(self.camoIndex > (camoList.size - 1)) {
      self.camoIndex = 0;
    }

    camoElem SetDevText("Camo: " + tableLookup("mp/camoTable.csv", 0, self.camoIndex, 1) + "[{+actionslot 1}]");
    self updateTestWeapon();
  }
}

weaponChangeListener() {
  self endon("death");
  self endon("new_test_weapon");
  self endon("quit_weapon_test");

  self notifyOnPlayerCommand("next_weapon", "weapnext");

  if(!isDefined(self.weaponElem)) {
    self.buttonElem = self createFontString("default", 1.5);
    self.buttonElem setPoint("TOPRIGHT", "TOPRIGHT", 0, -8 + 260);
    self thread destroyOnDeathAndClear(self.buttonElem);

    self.weaponElem = self createFontString("default", 1.5);
    self.weaponElem setPoint("TOPRIGHT", "TOPRIGHT", -20, -8 + 260);
    self thread destroyOnDeath(self.weaponElem);

    self.attachmentElem = self createFontString("default", 1.5);
    self.attachmentElem setPoint("TOPRIGHT", "TOPRIGHT", -20, 12 + 260);
    self thread destroyOnDeath(self.attachmentElem);

    self.attachmentElem2 = self createFontString("default", 1.5);
    self.attachmentElem2 setPoint("TOPRIGHT", "TOPRIGHT", -20, 32 + 260);
    self thread destroyOnDeath(self.attachmentElem2);
  }
  self.variantIndex = 0;

  self.buttonElem SetDevText("[{weapnext}]");
  self.weaponElem SetDevText(self.baseWeapon);
  self.attachmentElem SetDevText("");
  self.attachmentElem2 SetDevText("");

  for(;;) {
    self waittill("next_weapon");

    self.variantIndex++;
    if(self.variantIndex > (level.baseWeaponList[self.baseWeapon].variants.size - 1)) {
      self.variantIndex = 0;
    }

    self.weaponElem SetDevText(self.baseWeapon);
    self updateTestWeapon();
    wait 0.05;
    attachmentNames = GetWeaponAttachments(level.baseWeaponList[self.baseWeapon].variants[self.variantIndex]);
    attachmentDisplayNames = GetWeaponAttachmentDisplayNames(level.baseWeaponList[self.baseWeapon].variants[self.variantIndex]);

    assert(attachmentNames.size == attachmentDisplayNames.size);

    i = 0;
    while(i < attachmentNames.size) {
      if(isDefined(attachmentNames[i + 1]) && is_later_in_alphabet(attachmentNames[i], attachmentNames[i + 1])) {
        tmpAtch = attachmentNames[i];
        tmpAtchDisplayName = attachmentDisplayNames[i];

        attachmentNames[i] = attachmentNames[i + 1];
        attachmentDisplayNames[i] = attachmentDisplayNames[i + 1];

        attachmentNames[i + 1] = tmpAtch;
        attachmentDisplayNames[i + 1] = tmpAtchDisplayName;

        i = 0;
        continue;
      }
      i++;
    }

    if(isDefined(attachmentNames)) {
      if(isDefined(attachmentNames[0])) {
        self.attachmentElem SetDevText(attachmentDisplayNames[0]);
      } else {
        self.attachmentElem SetDevText("");
      }

      if(isDefined(attachmentNames[1])) {
        self.attachmentElem2 SetDevText(attachmentDisplayNames[1]);
      } else {
        self.attachmentElem2 SetDevText("");
      }
    } else {
      self.attachmentElem SetDevText("");
      self.attachmentElem2 SetDevText("");
    }
  }
}

destroyOnDeath(hudElem) {
  self waittill_any("death", "quit_weapon_test");
  hudElem destroy();
}

destroyOnDeathAndClear(hudElem) {
  self waittill_any("death", "quit_weapon_test");
  hudElem ClearAllTextAfterHudelem();
  wait 0.05;
  hudElem destroy();
}

updateTestWeapon() {
  self takeAllWeapons();

  wait(0.05);

  weaponName = level.baseWeaponList[self.baseWeapon].variants[self.variantIndex];

  use_underscores = false;
  baseName = getBaseWeaponName(weaponName);
  if(IsSubStr(baseName, "iw5_") || IsSubStr(baseName, "iw6_")) {
    endIndex = baseName.size;
    baseName = GetSubStr(baseName, 4, endIndex);
    use_underscores = true;
  }

  baseName = maps\mp\_utility::strip_suffix(baseName, "_mp");
  attachments = GetWeaponAttachments(weaponName);

  autoAttachments = maps\mp\gametypes\_class::addAutomaticAttachments(weaponName, attachments);
  if(autoAttachments.size > 0) {
    attachments = array_combine(attachments, autoAttachments);
    attachments = alphabetize(attachments);

    weaponName = GetWeaponBaseName(weaponName);
    foreach(attachment in attachments) {
      if(use_underscores) {
        weaponName = weaponName + "_" + attachment;
      } else {
        weaponName = weaponName + "+" + attachment;
      }
    }
  }

  if(self.camoIndex > 0) {
    if(use_underscores) {
      weaponName = weaponName + "_camo";
    } else {
      weaponName = weaponName + "+camo";
    }

    if(self.camoIndex < 10) {
      weaponName = weaponName + "0";
    }

    weaponName = weaponName + self.camoIndex;
  }

  self _giveWeapon(weaponName);
  self switchToWeapon(weaponName);
  self giveMaxAmmo(weaponName);
}

watchNoClip() {
  level waittill("player_spawned", player);
  if(!IsAI(player) && !IsTestClient(player)) {
    player NotifyOnPlayerCommand("ls_down_noclip", "+breath_sprint");
    player NotifyOnPlayerCommand("dpad_down_noclip", "+actionslot 2");
    player thread playerNoClip();
  }
  level thread watchNoClip();
}

playerNoClip() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  self.devNoClipLS = false;
  self.devNoClipDpad = false;
  self thread watchNoClipLS();
  self thread watchNoClipDpad();

  while(true) {
    if(GetDvarInt("scr_devnoclip") > 0) {
      if(self.devNoClipLS && self.devNoClipDpad) {
        self noclip();
      }
    }

    wait(0.2);
  }
}

watchNoClipLS() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  while(true) {
    self waittill("ls_down_noclip");

    self.devNoClipLS = true;

    wait(0.2);

    self.devNoClipLS = false;
  }
}

watchNoClipDpad() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  while(true) {
    self waittill("dpad_down_noclip");

    self.devNoClipDpad = true;

    wait(0.2);

    self.devNoClipDpad = false;
  }
}

watchUFO() {
  level waittill("player_spawned", player);
  if(!IsAI(player) && !IsTestClient(player)) {
    player NotifyOnPlayerCommand("ls_down_ufo", "+breath_sprint");
    player NotifyOnPlayerCommand("dpad_up_ufo", "+actionslot 1");
    player thread playerUFO();
  }
  level thread watchUFO();
}

playerUFO() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  self.devUFOLS = false;
  self.devUFODpad = false;
  self thread watchUFOLS();
  self thread watchUFODpad();

  while(true) {
    if(GetDvarInt("scr_devufo") > 0) {
      if(self.devUFOLS && self.devUFODpad) {
        self ufo();
      }
    }

    wait(0.2);
  }
}

watchUFOLS() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  while(true) {
    self waittill("ls_down_ufo");

    self.devUFOLS = true;

    wait(0.2);

    self.devUFOLS = false;
  }
}

watchUFODpad() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  while(true) {
    self waittill("dpad_up_ufo");

    self.devUFODpad = true;

    wait(0.2);

    self.devUFODpad = false;
  }
}

printPerks() {
  while(true) {
    if(GetDvarInt("scr_printperks") > 0) {
      break;
    }
    wait 1;
  }

  foreach(player in level.players) {
    if(GetDvarInt("scr_printperks") == 1 && (!IsBot(player) && !IsTestClient(player))) {
      PrintLn(player.name);
      foreach(perk, value in player.perks) {
        PrintLn(perk);
      }
    } else if(GetDvarInt("scr_printperks") == 2 && IsBot(player)) {
      PrintLn(player.name);
      foreach(perk, value in player.perks) {
        PrintLn(perk);
      }
    }
  }

  SetDevDvar("scr_printperks", 0);
  thread printPerks();
}

devGivePerks() {
  while(true) {
    if(getDvar("scr_devgiveperk") != "") {
      break;
    }
    wait 1;
  }

  perk = getDvar("scr_devgiveperk");
  foreach(player in level.players) {
    player thread givePerk(perk, false);
  }

  SetDevDvar("scr_devgiveperk", "");

  thread devGivePerks();
}

devClearPerks() {
  while(true) {
    if(GetDvarInt("scr_devclearperks") > 0) {
      break;
    }
    wait 1;
  }

  SetDevDvar("scr_devclearperks", 0);

  foreach(player in level.players) {
    player thread _clearPerks();
  }

  thread devClearPerks();
}

devHurtPlayer() {
  while(true) {
    if(GetDvarInt("scr_devhurtplayer") > 0) {
      break;
    }
    wait 1;
  }

  damageVal = GetDvarInt("scr_devhurtplayer");

  notBot = getNotBot();

  if(damageVal >= 100) {
    damageVal = notBot.health - 1;
  }

  bot = getBot(notBot);

  if(isDefined(bot)) {
    weapon = bot.primaryweapon;
    if(!isDefined(weapon)) {
      weapon = "";
    }
    notBot thread[[level.callbackPlayerDamage]](
      bot, bot, damageVal, 0, "MOD_RIFLE_BULLET", weapon, bot.origin, (0, 0, 0), "none", 0
    );
  }

  SetDevDvar("scr_devhurtplayer", 0);

  thread devHurtPlayer();
}

devHurtPlayerReset() {
  while(true) {
    if(GetDvarInt("scr_devhurtplayerreset") > 0) {
      break;
    }
    wait 1;
  }

  notBot = getNotBot();
  notBot.health = 100;

  SetDevDvar("scr_devhurtplayerreset", 0);

  thread devHurtPlayerReset();
}

devHurtPlayerDirectional() {
  while(true) {
    if(getDvar("scr_devhurtplayerdirectional") != "") {
      break;
    }
    wait 1;
  }

  notBot = getNotBot();
  bot = getBot(notBot);

  if(isDefined(bot)) {
    switch (getDvar("scr_devhurtplayerdirectional")) {
      case "right100":
        bot SetOrigin(notbot.origin + (0, 0, 5) + (AnglesToRight(notbot.angles) * 100));
        break;
      case "left100":
        bot SetOrigin(notbot.origin + (0, 0, 5) + ((AnglesToRight(notbot.angles) * 100) * -1));
        break;
      case "center100":
        bot SetOrigin(notbot.origin + (0, 0, 5) + (anglesToForward(notbot.angles) * 100));
        break;
      case "right600":
        bot SetOrigin(notbot.origin + (0, 0, 5) + (AnglesToRight(notbot.angles) * 600));
        break;
      case "left600":
        bot SetOrigin(notbot.origin + (0, 0, 5) + ((AnglesToRight(notbot.angles) * 600) * -1));
        break;
      case "center600":
        bot SetOrigin(notbot.origin + (0, 0, 5) + (anglesToForward(notbot.angles) * 600));
        break;
    }

    wait(0.1);
    MagicBullet("iw6_p226_mp", bot.origin + (0, 0, 35), notbot.origin + (0, 0, 35), bot);
  }

  SetDevDvar("scr_devhurtplayerdirectional", "");

  thread devHurtPlayerDirectional();
}

devHurtEnt() {
  while(true) {
    if(getDvar("scr_devhurtent") == "") {
      wait 1;
      continue;
    }

    notBot = getNotBot();
    bot = getBot(notBot);

    entNum = GetDvarInt("scr_devhurtent");
    ent = GetEntByNum(entNum);

    if(isDefined(bot)) {
      wait(0.1);
      weapon = bot GetCurrentPrimaryWeapon();
      MagicBullet(weapon, ent.origin + (0, 0, 80), ent.origin, bot);
    }

    SetDevDvar("scr_devhurtent", "");

    wait 1;
  }
}

getBot(notBot, spawn_ai_bots_normally) {
  bot = undefined;
  foreach(player in level.players) {
    if(IsBot(player) || IsTestClient(player)) {
      bot = player;
    }

    if(isDefined(bot) && isDefined(notBot)) {
      if(level.teambased) {
        if(bot.team != notBot.team) {
          break;
        }
      } else {
        break;
      }
    }
  }

  if(!isDefined(bot)) {
    if(isDefined(spawn_ai_bots_normally) && spawn_ai_bots_normally && BotAutoConnectEnabled() != 0 && testClients_SpawnFullBots()) {
      if(GetDvarInt("bot_MaxNumAllyBots") == 0) {
        setDvar("bot_MaxNumAllyBots", 1);
      } else if(GetDvarInt("bot_MaxNumEnemyBots") == 0) {
        setDvar("bot_MaxNumAllyBots", 1);
      } else {
        Assert("unreachable");
      }
    } else {
      SetDevDvar("scr_testclients", 1);
    }
    wait(3.0);

    foreach(player in level.players) {
      if(IsBot(player) || IsTestClient(player)) {
        bot = player;
      }

      if(isDefined(bot)) {
        if(level.teambased) {
          if(bot.team != notBot.team) {
            break;
          }
        } else {
          break;
        }
      }
    }
  }

  return bot;
}

getNotBot() {
  notBot = level.players[0];
  foreach(player in level.players) {
    if(!IsBot(player) && !IsTestClient(player)) {
      return player;
    }
  }
}

devChangeTimeLimit() {
  while(true) {
    SetDevDvar("scr_devchangetimelimit", -1);
    while(true) {
      if(GetDvarFloat("scr_devchangetimelimit") > -1.0) {
        break;
      }
      wait 1;
    }

    timelimit = GetDvarFloat("scr_devchangetimelimit") / 60;
    level.startTime = getTime();
    gameMode = "scr_" + level.gametype + "_timelimit";
    level.watchDvars[gameMode].value = timelimit;
    SetDevDvar(gameMode, timelimit);
  }
}

devPlayerXP() {
  prev = GetDvarInt("scr_devplayerxp");
  while(true) {
    if(GetDvarInt("scr_devplayerxp") != prev) {
      break;
    }
    wait 1;
  }

  notBot = getNotBot();

  switch (GetDvarInt("scr_devplayerxp")) {
    case 0:
      notBot notify("devStopPlayerXP");
      if(isDefined(notBot.devPlayerXPBar)) {
        notBot.devPlayerXPBar destroyElem();
      }
      if(isDefined(notBot.devPlayerXPBarText)) {
        notBot.devPlayerXPBarText destroyElem();
      }
      break;
    case 1:
      notBot.devPlayerXPBar = notBot createPrimaryProgressBar(200, 200);
      notBot.devPlayerXPBarText = notBot createPrimaryProgressBarText(200, 200);
      notBot.devPlayerXPBarText SetText("player xp");
      notBot thread devWatchPlayerXP();
      break;
  }

  thread devPlayerXP();
}

devWatchPlayerXP() {
  level endon("game_ended");
  self endon("devStopPlayerXP");

  prevXP = self maps\mp\gametypes\_rank::getRankXP();

  while(true) {
    currXP = self maps\mp\gametypes\_rank::getRankXP();

    if(prevXP != currXP) {
      rank = maps\mp\gametypes\_rank::getRankForXp(currXP);
      minXP = maps\mp\gametypes\_rank::getRankInfoMinXP(rank);
      nextXP = maps\mp\gametypes\_rank::getRankInfoXPAmt(rank);
      if(nextXP == 0) {
        if(currXP - minXP == 0) {
          nextXP = 1;
        } else {
          nextXP = currXP - minXP;
        }
      }
      barFrac = (currXP - minXP) / nextXP;
      if(barFrac > 1.0) {
        barFrac = 1.0;
      }
      self.devPlayerXPBar updateBar(barFrac, 0);
      prevXP = currXP;

      self.devPlayerXPBarText SetText("player xp:" + currXP + " xp to next:" + nextXP + " rank:" + (rank + 1));
    }

    wait(0.05);
  }
}

devScriptMoversDebugDraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  while(true) {
    if(GetDvarInt("scr_devScriptMoversDebugDraw") > 0) {
      script_models = getEntArray("script_model", "classname");
      script_origins = getEntArray("script_origin", "classname");

      foreach(ent in script_models) {
        Line(ent.origin, ent.origin + (anglesToForward(ent.angles) * 10), red);
        Line(ent.origin, ent.origin + (AnglesToRight(ent.angles) * 10), green);
        Line(ent.origin, ent.origin + (AnglesToUp(ent.angles) * 10), blue);

        if(isDefined(ent.targetname)) {
          color = white;
          alpha = 1;
          scale = 1;
          Print3d(ent.origin, ent.targetname, color, alpha, scale);
          originString = "(" + ent.origin[0] + ", " + ent.origin[1] + ", " + ent.origin[2] + ")";
          Print3d(ent.origin + (0, 0, -20), originString, color, alpha, scale);
        }
      }

      foreach(ent in script_origins) {
        Line(ent.origin, ent.origin + (anglesToForward(ent.angles) * 10), red);
        Line(ent.origin, ent.origin + (AnglesToRight(ent.angles) * 10), green);
        Line(ent.origin, ent.origin + (AnglesToUp(ent.angles) * 10), blue);

        if(isDefined(ent.targetname)) {
          color = white;
          alpha = 1;
          scale = 1;
          switch (ent.targetname) {
            case "airstrikeheight":
              color = red;
              scale = 3;
              break;
            case "heli_start":
            case "heli_leave":
              color = green;
              scale = 3;
              break;
          }

          Print3d(ent.origin, ent.targetname, color, alpha, scale);
          originString = "(" + ent.origin[0] + ", " + ent.origin[1] + ", " + ent.origin[2] + ")";
          Print3d(ent.origin + (0, 0, -20), originString, color, alpha, scale);
        }
      }
    }
    wait 0.05;
  }
}

devHeliPathDebugDraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  textColor = white;
  textAlpha = 1;
  textScale = 1;

  maxDrawTime = 10;
  drawTime = maxDrawTime;

  originTextOffset = (0, 0, -30);

  endonMsg = "devStopHeliPathsDebugDraw";

  while(true) {
    if(GetDvarInt("scr_devHeliPathsDebugDraw") > 0) {
      script_origins = getEntArray("script_origin", "classname");

      foreach(ent in script_origins) {
        if(isDefined(ent.targetname)) {
          switch (ent.targetname) {
            case "heli_start":
              textColor = blue;
              textAlpha = 1;
              textScale = 3;
              break;
            case "heli_loop_start":
              textColor = green;
              textAlpha = 1;
              textScale = 3;
              break;
            case "heli_attack_area":
              textColor = red;
              textAlpha = 1;
              textScale = 3;
              break;
            case "heli_leave":
              textColor = white;
              textAlpha = 1;
              textScale = 3;
              break;
          }

          switch (ent.targetname) {
            case "heli_start":
            case "heli_loop_start":
            case "heli_attack_area":
            case "heli_leave":

              if(drawTime == maxDrawTime) {
                ent thread drawPath(textColor, white, textAlpha, textScale, originTextOffset, drawTime, endonMsg);
              }

              ent drawOriginLines();
              ent drawTargetNameText(textColor, textAlpha, textScale);
              ent drawOriginText(textColor, textAlpha, textScale, originTextOffset);
              break;
          }
        }
      }

      drawTime -= 0.05;
      if(drawTime < 0) {
        drawTime = maxDrawTime;
      }
    }

    if(GetDvarInt("scr_devHeliPathsDebugDraw") == 0) {
      level notify(endonMsg);
      drawTime = maxDrawTime;
    }

    wait 0.05;
  }
}

devLBGuardPathDebugDraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  textColor = white;
  textAlpha = 1;
  textScale = 1;

  maxDrawTime = 10;
  drawTime = maxDrawTime;

  originTextOffset = (0, 0, -30);

  endonMsg = "devStopLBGuardPathDebugDraw";

  while(true) {
    if(GetDvarInt("scr_devLBGuardPathDebugDraw") > 0) {
      script_structs = getStructArray("so_chopper_boss_path_struct", "script_noteworthy");

      foreach(ent in script_structs) {
        Line(ent.origin, ent.origin + (10, 0, 0), red);
        Line(ent.origin, ent.origin + (0, 10, 0), green);
        Line(ent.origin, ent.origin + (0, 0, 10), blue);

        Print3d(ent.origin, ent.origin);
        if(isDefined(ent.script_noteworthy)) {
          Print3d(ent.origin + originTextOffset, ent.script_noteworthy);
        }
        if(isDefined(ent.radius)) {
          Print3d(ent.origin + (originTextOffset * 2), "radius: " + ent.radius);
        }
      }
    }

    wait 0.05;
  }
}

drawOriginLines() {
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  Line(self.origin, self.origin + (anglesToForward(self.angles) * 10), red);
  Line(self.origin, self.origin + (AnglesToRight(self.angles) * 10), green);
  Line(self.origin, self.origin + (AnglesToUp(self.angles) * 10), blue);
}

drawTargetNameText(textColor, textAlpha, textScale, textOffset) {
  if(!isDefined(textOffset)) {
    textOffset = (0, 0, 0);
  }
  Print3d(self.origin + textOffset, self.targetname, textColor, textAlpha, textScale);
}

drawOriginText(textColor, textAlpha, textScale, textOffset) {
  if(!isDefined(textOffset)) {
    textOffset = (0, 0, 0);
  }
  originString = "(" + self.origin[0] + ", " + self.origin[1] + ", " + self.origin[2] + ")";
  Print3d(self.origin + textOffset, originString, textColor, textAlpha, textScale);
}

drawSpeedAccelText(textColor, textAlpha, textScale, textOffset) {
  if(isDefined(self.script_airspeed)) {
    Print3d(self.origin + (0, 0, textOffset[2] * 2), "script_airspeed:" + self.script_airspeed, textColor, textAlpha, textScale);
  }
  if(isDefined(self.script_accel)) {
    Print3d(self.origin + (0, 0, textOffset[2] * 3), "script_accel:" + self.script_accel, textColor, textAlpha, textScale);
  }
}

drawPath(lineColor, textColor, textAlpha, textScale, textOffset, drawTime, endonMsg) {
  level endon(endonMsg);

  ent = self;
  entFirstTarget = ent.targetname;

  while(isDefined(ent.target)) {
    entTarget = GetEnt(ent.target, "targetname");
    ent thread drawPathSegment(entTarget, lineColor, textColor, textAlpha, textScale, textOffset, drawTime, endonMsg);

    if(ent.targetname == "heli_loop_start") {
      entFirstTarget = ent.target;
    } else if(ent.target == entFirstTarget) {
      break;
    }

    ent = entTarget;
    wait(0.05);
  }
}

drawPathSegment(entTarget, lineColor, textColor, textAlpha, textScale, textOffset, drawTime, endonMsg) {
  level endon(endonMsg);

  while(drawTime > 0) {
    Line(self.origin, entTarget.origin, lineColor);
    self drawSpeedAccelText(textColor, textAlpha, textScale, textOffset);
    drawTime -= 0.05;
    wait(0.05);
  }
}

devPredatorMissileDebugDraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);

  textColor = white;
  textAlpha = 1;
  textScale = 1;

  maxDrawTime = 10;
  drawTime = maxDrawTime;

  originTextOffset = (0, 0, -30);

  endonMsg = "devStopPredatorMissileDebugDraw";

  while(true) {
    if(GetDvarInt("scr_devPredatorMissileDebugDraw") > 0) {
      script_origins = getEntArray("remoteMissileSpawn", "targetname");

      foreach(ent in script_origins) {
        textColor = red;
        textAlpha = 1;
        textScale = 1;

        if(drawTime == maxDrawTime) {
          ent thread drawPath(textColor, white, textAlpha, textScale, originTextOffset, drawTime, endonMsg);
        }

        ent drawOriginLines();
        ent drawTargetNameText(textColor, textAlpha, textScale);
        ent drawOriginText(textColor, textAlpha, textScale, originTextOffset);
      }

      drawTime -= 0.05;
      if(drawTime < 0) {
        drawTime = maxDrawTime;
      }
    }

    if(GetDvarInt("scr_devPredatorMissileDebugDraw") == 0) {
      level notify(endonMsg);
      drawTime = maxDrawTime;
    }

    wait 0.05;
  }
}

devPrintDailyWeeklyChallenges() {
  while(true) {
    if(getDvar("scr_devPrintDailyWeeklyChallenges") != "") {
      break;
    }
    wait 1;
  }

  foreach(player in level.players) {
    if(IsBot(player) || IsTestClient(player)) {
      continue;
    }

    if(getDvar("scr_devPrintDailyWeeklyChallenges") == "daily") {
      PrintLn(player.name);
      foreach(challenge, value in player.challengedata) {
        if(IsSubStr(challenge, "_daily") && value) {
          PrintLn("Daily: " + challenge);
        }
      }
    } else if(getDvar("scr_devPrintDailyWeeklyChallenges") == "weekly") {
      PrintLn(player.name);
      foreach(challenge, value in player.challengedata) {
        if(IsSubStr(challenge, "_weekly") && value) {
          PrintLn("Weekly: " + challenge);
        }
      }
    }
  }

  SetDevDvar("scr_devPrintDailyWeeklyChallenges", "");
  thread devPrintDailyWeeklyChallenges();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread updateReflectionProbe();
  }
}

showSpawnpoint(spawnpoint, classname, color) {
  center = spawnpoint.origin;
  forward = anglesToForward(spawnpoint.angles);
  right = anglestoright(spawnpoint.angles);

  forward *= 16;
  right *= 16;

  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;

  line(a, b, color, 0);
  line(b, c, color, 0);
  line(c, d, color, 0);
  line(d, a, color, 0);

  line(a, a + (0, 0, 72), color, 0);
  line(b, b + (0, 0, 72), color, 0);
  line(c, c + (0, 0, 72), color, 0);
  line(d, d + (0, 0, 72), color, 0);

  a = a + (0, 0, 72);
  b = b + (0, 0, 72);
  c = c + (0, 0, 72);
  d = d + (0, 0, 72);

  line(a, b, color, 0);
  line(b, c, color, 0);
  line(c, d, color, 0);
  line(d, a, color, 0);

  center = center + (0, 0, 36);
  arrow_forward = anglesToForward(spawnpoint.angles);
  arrowhead_forward = anglesToForward(spawnpoint.angles);
  arrowhead_right = anglestoright(spawnpoint.angles);

  arrow_forward *= 32;
  arrowhead_forward *= 24;
  arrowhead_right *= 8;
  a = center + arrow_forward;
  b = center + arrowhead_forward - arrowhead_right;
  c = center + arrowhead_forward + arrowhead_right;

  line(center, a, (1, 1, 1), 0);
  line(a, b, (1, 1, 1), 0);
  line(a, c, (1, 1, 1), 0);

  foreach(alternate in spawnpoint.alternates) {
    line(spawnpoint.origin, alternate, color, 0);
  }

  if(isDefined(spawnpoint.teambase)) {
    print3D(spawnpoint.origin + (0, 0, 72), spawnpoint.index + ": " + classname + " " + spawnpoint.teambase, color, 1, 1);
  } else {
    print3D(spawnpoint.origin + (0, 0, 72), spawnpoint.index + ": " + classname, color, 1, 1);
  }
}

showSpawnpoints() {
  hostTeam = "all";

  foreach(player in level.players) {
    if(player IsHost()) {
      hostTeam = maps\mp\gametypes\_spawnlogic::getSpawnTeam(player);
      break;
    }
  }

  if(isDefined(level.spawnpoints)) {
    foreach(spawnpoint in level.spawnpoints) {
      color = (1, 0, 0);

      if(isDefined(spawnpoint.fullSights[hostTeam]) && spawnpoint.fullSights[hostTeam] != 0) {
        color = (0, 1, 0);
      }

      if(isDefined(spawnpoint.cornerSights[hostTeam]) && spawnpoint.cornerSights[hostTeam] != 0) {
        color = (0, 1, 0);
      }

      showSpawnpoint(spawnpoint, spawnpoint.classname, color);
    }
  }

  if(isDefined(level.startSpawnPoints)) {
    foreach(spawnpoint in level.startSpawnPoints) {
      color = (0, 0, 1);

      if(spawnpoint.inFront) {
        color = (1, 1, 1);
      }

      showSpawnpoint(spawnpoint, spawnpoint.classname, color);
    }
  }

}

updateReflectionProbe() {
  for(;;) {
    if(GetDvarInt("debug_reflection") == 1) {
      if(!isDefined(self.debug_reflectionobject)) {
        self.debug_reflectionobject = spawn("script_model", self getEye() + ((anglesToForward(self.angles) * 100)));
        self.debug_reflectionobject setModel("test_sphere_silver");
        self.debug_reflectionobject.origin = self getEye() + ((anglesToForward(self getplayerangles()) * 100));
        self thread reflectionProbeButtons();
      }
    } else if(GetDvarInt("debug_reflection") == 0) {
      if(isDefined(self.debug_reflectionobject)) {
        self.debug_reflectionobject delete();
      }
    }

    wait(0.05);
  }
}

reflectionProbeButtons() {
  offset = 100;
  offsetinc = 50;

  while(GetDvarInt("debug_reflection") == 1) {
    if(self buttonPressed("BUTTON_X")) {
      offset += offsetinc;
    }
    if(self buttonPressed("BUTTON_Y")) {
      offset -= offsetinc;
    }
    if(offset > 1000) {
      offset = 1000;
    }
    if(offset < 64) {
      offset = 64;
    }

    self.debug_reflectionobject.origin = self getEye() + ((anglesToForward(self GetPlayerAngles()) * offset));

    wait .05;
  }
}

gotoNextspawn() {
  if(isDefined(level.spawnpoints)) {
    foreach(player in level.players) {
      if(!isDefined(player.debug_next_spawnpoint)) {
        player.debug_next_spawnpoint = 0;
      }

      player.spawnPos = level.spawnpoints[player.debug_next_spawnpoint].origin;
      player spawn(level.spawnpoints[player.debug_next_spawnpoint].origin, level.spawnpoints[player.debug_next_spawnpoint].angles);

      player.debug_prev_spawnpoint = player.debug_next_spawnpoint - 1;
      if(player.debug_prev_spawnpoint < 0) {
        player.debug_prev_spawnpoint = level.spawnpoints.size - 1;
      }
      player.debug_next_spawnpoint++;
      if(player.debug_next_spawnpoint == level.spawnpoints.size) {
        player.debug_next_spawnpoint = 0;
      }
    }
  }
}

gotoPrevspawn() {
  if(isDefined(level.spawnpoints)) {
    foreach(player in level.players) {
      if(!isDefined(player.debug_prev_spawnpoint)) {
        player.debug_prev_spawnpoint = level.spawnpoints.size - 1;
      }

      player.spawnPos = level.spawnpoints[player.debug_prev_spawnpoint].origin;
      player spawn(level.spawnpoints[player.debug_prev_spawnpoint].origin, level.spawnpoints[player.debug_prev_spawnpoint].angles);

      player.debug_next_spawnpoint = player.debug_prev_spawnpoint + 1;
      if(player.debug_next_spawnpoint == level.spawnpoints.size) {
        player.debug_next_spawnpoint = 0;
      }
      player.debug_prev_spawnpoint--;
      if(player.debug_prev_spawnpoint < 0) {
        player.debug_prev_spawnpoint = level.spawnpoints.size - 1;
      }
    }
  }
}

gotoNextStartspawn() {
  spawnPointTeams = [];
  foreach(spawnteam in ["allies", "axis"]) {
    spawnPointTeams[spawnteam] = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_tdm_spawn_" + spawnteam + "_start");
  }
  spawnpoints = array_combine(spawnPointTeams["allies"], spawnPointTeams["axis"]);

  if(isDefined(spawnpoints)) {
    foreach(player in level.players) {
      if(!isDefined(player.debug_next_startspawnpoint)) {
        player.debug_next_startspawnpoint = 0;
      }

      player.spawnPos = spawnpoints[player.debug_next_startspawnpoint].origin;
      player spawn(spawnpoints[player.debug_next_startspawnpoint].origin, spawnpoints[player.debug_next_startspawnpoint].angles);

      player.debug_prev_startspawnpoint = player.debug_next_startspawnpoint - 1;
      if(player.debug_prev_startspawnpoint < 0) {
        player.debug_prev_startspawnpoint = spawnpoints.size - 1;
      }
      player.debug_next_startspawnpoint++;
      if(player.debug_next_startspawnpoint == spawnpoints.size) {
        player.debug_next_startspawnpoint = 0;
      }
    }
  }
}

gotoPrevStartspawn() {
  spawnPointTeams = [];
  foreach(spawnteam in ["allies", "axis"]) {
    spawnPointTeams[spawnteam] = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_tdm_spawn_" + spawnteam + "_start");
  }
  spawnpoints = array_combine(spawnPointTeams["allies"], spawnPointTeams["axis"]);

  if(isDefined(spawnpoints)) {
    foreach(player in level.players) {
      if(!isDefined(player.debug_prev_startspawnpoint)) {
        player.debug_prev_startspawnpoint = spawnpoints.size - 1;
      }

      player.spawnPos = spawnpoints[player.debug_prev_startspawnpoint].origin;
      player spawn(spawnpoints[player.debug_prev_startspawnpoint].origin, spawnpoints[player.debug_prev_startspawnpoint].angles);

      player.debug_next_startspawnpoint = player.debug_prev_startspawnpoint + 1;
      if(player.debug_next_startspawnpoint == spawnpoints.size) {
        player.debug_next_startspawnpoint = 0;
      }
      player.debug_prev_startspawnpoint--;
      if(player.debug_prev_startspawnpoint < 0) {
        player.debug_prev_startspawnpoint = spawnpoints.size - 1;
      }
    }
  }
}

monitorTagNoteworthyEvent() {
  self endon("disconnect");
  self notifyOnPlayerCommand("dpad_down", "+actionslot 2");

  for(;;) {
    self waittill("dpad_down");

    print("script_tag_noteworthy recon message triggered\n");
    if(isDefined(level.lastspawnedplayer)) {
      ReconSpatialEvent(self.origin, "script_tag_noteworthy: player %s, angles %v, lastspawnpoint %v, lastspawntime %d, lastspawnedplayer %s, gametime %d", self.name, self GetPlayerAngles(), level.lastspawnedplayer.lastspawnpoint.origin, level.lastspawnedplayer.lastspawntime, level.lastspawnedplayer.name, gettime());
    } else {
      ReconSpatialEvent(self.origin, "script_tag_noteworthy: player %s, angles %v, lastspawnpoint %v, lastspawntime %d, lastspawnedplayer %s, gametime %d", self.name, self GetPlayerAngles(), (0, 0, 0), 0, "none", gettime());
    }
  }

}