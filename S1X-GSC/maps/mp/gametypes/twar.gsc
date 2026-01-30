/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\twar.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_audio;

COLOR_BLUE = (0.157, 0.392, 0.784);
COLOR_ORANGE = (0.784, 0.490, 0.157);

MIN_CAPTURE_PLAYERS = 1;
MOMENTUM_BAR_VISIBLE = 1;
main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 10);
    registerScoreLimitDvar(level.gameType, 75);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  setOverTimeLimitDvar(3);

  level.teamBased = true;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onTimeLimit = ::onTimeLimit;
  level.onPlayerKilled = ::onPlayerKilled;
  level.allowBoostingAboveTriggerRadius = true;

  level.ai_game_mode = true;
  level.modifyPlayerDamage = ::minion_damage;
  level.on_agent_player_killed = ::on_minion_killed;

  level.spawn_version = 3;

  level.flagFXid = LoadFX("vfx/unique/vfx_flag_project_neutral");
  level.boarderFXid = LoadFx("vfx/unique/vfx_marker_dom_white");

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  game["dialog"]["gametype"] = "mom_intro";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getDvarInt("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getDvarInt("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "mtm_alert";
  game["dialog"]["offense_obj"] = "mtm_alert";

  game["dialog"]["mtm_taking"] = "mtm_taking";
  game["dialog"]["mtm_etaking"] = "mtm_etaking";
  game["dialog"]["mtm_lastflg"] = "mtm_lastflg";
  game["dialog"]["mtm_elastflg"] = "mtm_elastflg";
  game["dialog"]["mtm_secured"] = "mtm_secured";
  game["dialog"]["mtm_captured"] = "mtm_captured";
  game["dialog"]["mtm_max"] = "mtm_max";
  game["dialog"]["mtm_gain"] = "mtm_gain";
  game["dialog"]["mtm_reset"] = "mtm_reset";
  game["dialog"]["mtm_clrd"] = "mtm_clrd";
  game["dialog"]["mtm_lost"] = "mtm_lost";

  if(!isDefined(game["shut_out"])) {
    game["shut_out"]["axis"] = true;
    game["shut_out"]["allies"] = true;
    game["max_meter"]["axis"] = false;
    game["max_meter"]["allies"] = false;
  }

  SetDevDvar("bot_DrawSeeThrough", 0);
  SetDevDvar("bot_DrawBrokenTraversals", 0);
  SetDvar("r_hudOutlineWidth", 1);
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_twar_roundswitch", 0);
  registerRoundSwitchDvar("twar", 0, 0, 9);
  SetDynamicDvar("scr_twar_roundlimit", 1);
  registerRoundLimitDvar("twar", 1);
  SetDynamicDvar("scr_twar_winlimit", 1);
  registerWinLimitDvar("twar", 1);
  SetDynamicDvar("scr_twar_halftime", 0);
  registerHalfTimeDvar("twar", 0);
  SetDynamicDvar("scr_twar_halftime", 0);

  SetDynamicDvar("scr_twar_minionsmax", GetMatchRulesData("twarData", "numMinions"));
  SetDynamicDvar("scr_twar_capture_time", GetMatchRulesData("twarData", "captureTime"));
  SetDynamicDvar("scr_twar_zone_count", GetMatchRulesData("twarData", "numFlags"));
  SetDynamicDvar("scr_twar_ot_zone_count", GetMatchRulesData("twarData", "numOTFlags"));
  SetDynamicDvar("scr_twar_min_capture_players", MIN_CAPTURE_PLAYERS);
  SetDynamicDvar("scr_twar_hud_momentum_bar", !GetMatchRulesData("twarData", "hideMomentumBar"));
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = false;
  }

  if(game["switchedsides"]) {
    oldAttackers = game["attackers"];
    oldDefenders = game["defenders"];
    game["attackers"] = oldDefenders;
    game["defenders"] = oldAttackers;
  }

  setObjectiveText("allies", &"OBJECTIVES_TWAR");
  setObjectiveText("axis", &"OBJECTIVES_TWAR");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_TWAR");
    setObjectiveScoreText("axis", &"OBJECTIVES_TWAR");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_TWAR_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_TWAR_SCORE");
  }

  setObjectiveHintText("allies", &"OBJECTIVES_TWAR_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_TWAR_HINT");

  game["dialog"]["lockouts"]["mtm_taking"] = 5;
  game["dialog"]["lockouts"]["mtm_etaking"] = 5;

  initSpawns();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);

  level.zone_radius = GetDvarInt("scr_twar_zone_radius", 150);
  level.zone_height = 60;
  level.momentum_multiplier_max = 3;

  find_zones();
  assign_spawns();

  create_active_zone();

  init_momentum("allies");
  init_momentum("axis");

  thread watch_for_joined_team();
  thread updateMinions();
  thread update_lua_hud();

  thread twarDebug();
}

watch_for_joined_team() {
  while(1) {
    level waittill("joined_team");
    level notify("update_flag_outline");

    update_minion_hud_outlines();
  }
}

onTimeLimit() {
  level.finalKillCam_winner = "none";
  if(game["status"] == "overtime") {
    winner = "tie";
  } else if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
    winner = "overtime";

    game["owned_flags"] = [];
    game["owned_flags"]["allies"] = 0;
    game["owned_flags"]["axis"] = 0;
    foreach(zone in level.twar_zones) {
      if(zone.owner == "allies") {
        game["owned_flags"]["allies"]++;
      } else if(zone.owner == "axis") {
        game["owned_flags"]["axis"]++;
      }
    }
  } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
    level.finalKillCam_winner = "axis";
    winner = "axis";
  } else {
    level.finalKillCam_winner = "allies";
    winner = "allies";
  }

  if(practiceRoundGame()) {
    winner = "none";
  }

  thread maps\mp\gametypes\_gamelogic::endGame(winner, game["end_reason"]["time_limit_reached"]);
}

spawn_flag_projector(origin) {
  projector = spawn("script_model", origin);
  projector setModel("flag_holo_base_ground");

  return projector;
}

create_active_zone() {
  visuals[0] = spawn_flag_projector((0, 0, 0));

  trigger = spawn("trigger_radius", (0, 0, 0), 0, level.zone_radius, level.zone_height);
  trigger.radius = level.zone_radius;

  capture_time = GetDvarFloat("scr_twar_capture_time", 20.0);

  useObj = maps\mp\gametypes\_gameobjects::createUseObject("neutral", trigger, visuals);
  useObj maps\mp\gametypes\_gameobjects::allowUse("any");
  useObj maps\mp\gametypes\_gameobjects::setUseTime(capture_time);
  useObj maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
  useObj.keepProgress = true;
  useObj.noUseBar = true;
  useObj.id = "twarZone";

  useObj.onBeginUse = ::onBeginUse;
  useObj.onUse = ::onUse;
  useObj.onEndUse = ::onEndUse;
  useObj.onUpdateUseRate = ::onUpdateUseRate;

  level.twar_use_obj = useObj;

  reset_zone_owners();
}

zone_set_waiting() {
  self maps\mp\gametypes\_gameobjects::setOwnerTeam("neutral");

  self maps\mp\gametypes\_gameobjects::allowUse("none");

  icon = "waypoint_waitfor_flag_neutral";
  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", icon);
  self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", icon);
  self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", icon);
  self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", icon);
  SetMLGIcons(self, icon);
  self.waiting = true;
  SetOmnvar("ui_twar_capture_team", 3);
}

update_icons(friendlyCount, enemyCount) {
  if(isDefined(self.waiting)) {
    return;
  }

  if(friendlyCount > 0 && enemyCount > 0) {
    icon = "waypoint_contested";
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", icon);
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", icon);
    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", icon);
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", icon);
    SetMLGIcons(self, icon);
  } else if(friendlyCount == 0 && enemyCount == 0) {
    icon = "waypoint_captureneutral";
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", icon);
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", icon);
    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", icon);
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", icon);
    SetMLGIcons(self, icon);
  } else {
    self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_losing");
    self maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_losing");
    self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_taking");
    self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_taking");

    if(self.claimteam == "allies") {
      SetMLGIcons(self, "waypoint_esports_taking_blue");
    } else {
      SetMLGIcons(self, "waypoint_esports_taking_red");
    }
  }
}

zone_set_neutral() {
  self maps\mp\gametypes\_gameobjects::setOwnerTeam("neutral");
  self maps\mp\gametypes\_gameobjects::allowUse("any");

  self.waiting = undefined;
  SetOmnvar("ui_twar_capture_team", 0);
  update_icons(0, 0);
}

zone_flag_effect() {
  zone_flag_effect_stop();

  flagModel = level.twar_use_obj.visuals[0];
  self.flagFX = SpawnLinkedFX(level.flagFXid, flagModel, "tag_fx_flag");
  SetFXKillOnDelete(self.flagFX, true);
  TriggerFX(self.flagFX);
}

zone_flag_effect_stop() {
  if(isDefined(self.flagFX)) {
    self.flagFX Delete();
  }
}

zone_boarder_effect() {
  zone_boarder_effect_stop();

  flagModel = level.twar_use_obj.visuals[0];
  self.boarderFX = SpawnFX(level.boarderFXid, flagModel.origin, AnglesToUp(flagModel.angles));
  SetFXKillOnDelete(self.boarderFX, true);
  TriggerFX(self.boarderFX);
}

zone_boarder_effect_stop() {
  if(isDefined(self.boarderFX)) {
    self.boarderFX Delete();
  }
}

zone_set_team(team) {
  self maps\mp\gametypes\_gameobjects::setOwnerTeam(team);
  self maps\mp\gametypes\_gameobjects::allowUse("any");
}

update_flag_outline() {
  while(1) {
    level waittill("update_flag_outline");

    outline_friendly = GetDvarInt("scr_twar_flag_outline_color_friendly", -1);
    outline_enemy = GetDvarInt("scr_twar_flag_outline_color_enemy", -1);
    outline_neutral = GetDvarInt("scr_twar_flag_outline_color_neutral", -1);

    outline_depth = GetDvarInt("scr_twar_flag_outline_depth", 0);
    self HudOutlineDisableForClients(level.players);

    claim_team = level.twar_use_obj maps\mp\gametypes\_gameobjects::getClaimTeam();

    friendly = [];
    enemy = [];
    neutral = [];
    foreach(player in level.players) {
      if((claim_team == "allies" || claim_team == "axis") && (player.team == "allies" || player.team == "axis")) {
        if(claim_team == player.team) {
          friendly[friendly.size] = player;
        } else {
          enemy[enemy.size] = player;
        }
      } else {
        neutral[neutral.size] = player;
      }
    }

    if(friendly.size && outline_friendly >= 0) {
      self HudOutlineEnableForClients(friendly, outline_friendly, outline_depth);
    }

    if(enemy.size && outline_enemy >= 0) {
      self HudOutlineEnableForClients(enemy, outline_enemy, outline_depth);
    }

    if(neutral.size && outline_neutral >= 0) {
      self HudOutlineEnableForClients(neutral, outline_neutral, outline_depth);
    }

  }
}

reset_zone_owners() {
  middle = int(level.twar_zones.size / 2);
  foreach(i, zone in level.twar_zones) {
    if(i < middle) {
      zone.owner = "allies";
    } else if(i > middle) {
      zone.owner = "axis";
    } else {
      zone.owner = "none";
    }
  }

  set_contested_zone(level.twar_zones[middle]);
}

onBeginUse(player) {
  team = player.team;
  otherTeam = getOtherTeam(team);

  self zone_set_team(team);

  leaderDialog("mtm_taking", team);
  leaderDialog("mtm_etaking", otherTeam);

  level notify("update_flag_outline");
}

onUse(player) {
  team = player.team;
  otherTeam = getOtherTeam(team);

  zone = self.zone;

  zone.owner = team;

  next_index = zone.index;
  if(team == "allies") {
    next_index++;
  } else if(team == "axis") {
    next_index--;
  }

  game["shut_out"][otherTeam] = false;

  if(GetDvarInt("scr_twar_momentum_clear_friendly_on_capture", 0)) {
    clear_momentum(team);
  } else {
    add_capture_friendly_momentum(team);
  }

  if(GetDvarInt("scr_twar_momentum_clear_enemy_on_capture", 0)) {
    clear_momentum(otherTeam);
  } else {
    add_capture_enemy_momentum(otherTeam);
  }

  player thread snd_play_team_splash("mp_obj_notify_pos_lrg", "mp_obj_notify_neg_lrg");
  self thread giveZoneCaptureXP(self.touchList[team]);

  if(next_index < 0 || next_index >= level.num_zones) {
    self zone_flag_effect_stop();
    self zone_boarder_effect_stop();
    level maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(team, 1);

    leaderDialog("mtm_secured", team);
    if(level.gameEnded) {
      self maps\mp\gametypes\_gameobjects::disableObject();
    } else {
      reset_zone_owners();
    }
  } else {
    set_contested_zone(level.twar_zones[next_index]);

    if(next_index == 0 || next_index == (level.num_zones - 1)) {
      leaderDialogwait("mtm_lastflg", otherTeam);
      leaderDialogwait("mtm_elastflg", team);
    } else {
      leaderDialogwait("mtm_secured", team);
    }

  }

  self.nextUseTime = GetTime() + 50;
}

leaderDialogwait(dialog, team) {
  thread _leaderDialogwait(dialog, team);
}

_leaderDialogwait(dialog, team) {
  waitframe();
  leaderDialog(dialog, team);
}

giveZoneCaptureXP(touchList) {
  level endon("game_ended");

  player = self maps\mp\gametypes\_gameobjects::getEarliestClaimPlayer();
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  if(IsPlayer(player)) {
    level thread teamPlayerCardSplash("callout_securedposition", player);
  }

  players = getArrayKeys(touchList);
  for(index = 0; index < players.size; index++) {
    player = touchList[players[index]].player;
    if(isDefined(player.owner)) {
      player = player.owner;
    }

    if(!IsPlayer(player)) {
      continue;
    }

    player thread maps\mp\_events::domCaptureEvent(false);

    wait(0.05);
  }
}

onEndUse(team, player, success) {
  self zone_set_neutral();

  level notify("update_flag_outline");
}

onUpdateUseRate() {
  old_useRate = self.useRate;

  numClaimants = 0;
  numOther = 0;

  otherTeam = getOtherTeam(self.claimteam);
  foreach(struct in self.touchList[otherTeam]) {
    player = struct.player;
    if(!isDefined(player)) {
      continue;
    }

    if(player.pers["team"] != otherTeam) {
      continue;
    }

    numOther++;
  }

  maxUsePlayers = GetDvarInt("scr_twar_capture_players_max", 3);
  foreach(struct in self.touchList[self.claimteam]) {
    player = struct.player;
    if(!isDefined(player)) {
      continue;
    }

    if(player.pers["team"] != self.claimteam) {
      continue;
    }

    numClaimants++;
    if(numClaimants >= maxUsePlayers) {
      break;
    }
  }

  self.useRate = 0;
  self.staleMate = numClaimants && numOther;

  minCapturePlayers = GetDvarInt("scr_twar_min_capture_players", MIN_CAPTURE_PLAYERS);
  if(numClaimants && !numOther && numClaimants >= minCapturePlayers) {
    momentum_use_scale = level.twar_team_multiplier[self.claimTeam];
    self.useRate = numClaimants * momentum_use_scale;
  }

  useRateMax = GetDvarInt("scr_twar_capture_rate_max", 9.0);
  self.useRate = min(self.useRate, useRateMax);

  if(self.keepProgress && self.lastclaimteam != self.claimTeam) {
    self.useRate *= -1;
  }

  update_icons(numClaimants, numOther);
}

set_contested_zone(zone) {
  zone.owner = "none";

  level.twar_use_obj.zone = zone;
  level.twar_use_obj maps\mp\gametypes\_gameobjects::move_use_object(zone.origin, (0, 0, 100));

  foreach(otherZone in level.twar_zones) {
    if(otherZone != zone) {
      otherZone.projector Show();
    } else {
      otherZone.projector Hide();
    }
  }

  if(level.twar_use_obj.keepProgress) {
    level.twar_use_obj.lastclaimteam = "none";
  }

  level thread set_contested_zone_wait(5);
}

set_contested_zone_wait(waitTime) {
  waittillframeend;

  level.twar_use_obj zone_flag_effect_stop();
  level.twar_use_obj zone_boarder_effect();
  level.twar_use_obj zone_set_waiting();

  wait waitTime;

  level.twar_use_obj zone_flag_effect();
  level.twar_use_obj zone_set_neutral();
}

update_lua_hud() {
  while(1) {
    waittillframeend;

    ally_count = 0;
    foreach(zone in level.twar_zones) {
      if(zone.owner == "allies") {
        ally_count++;
      }
    }
    SetOmnvar("ui_twar_ally_flag_count", ally_count);

    team = 0;
    team_str = "";
    if(level.twar_use_obj.keepProgress) {
      team_str = level.twar_use_obj.lastclaimteam;
    } else {
      team_str = level.twar_use_obj.claimteam;
    }

    if(team_str == "axis") {
      team = 1;
    } else if(team_str == "allies") {
      team = 2;
    }

    bar_visible = GetDvarInt("scr_twar_hud_momentum_bar", MOMENTUM_BAR_VISIBLE);
    SetOmnvar("ui_twar_momentum_bar_visible", bar_visible);

    if(GetOmnvar("ui_twar_capture_team") != 3) {
      SetOmnvar("ui_twar_capture_team", team);
    }
    progress = 0.0;
    if(team_str != "none") {
      progress = level.twar_use_obj.curprogress / level.twar_use_obj.usetime;
    }
    SetOmnvar("ui_twar_capture_progress", progress);

    foreach(team in level.teamnamelist) {
      touchingCount = 0;
      if(level.twar_use_obj.interactTeam == "any") {
        touchingCount = level.twar_use_obj.numTouching[team];
      }
      SetOmnvar("ui_twar_touching_" + team, touchingCount);
    }

    waitframe();
  }
}

is_maxed_momentum(team) {
  return level.twar_team_multiplier[team] == level.momentum_multiplier_max;
}

set_maxed_momentum(team, time) {
  thread clear_max_momentum_delayed(team, time);
  set_momentum(team, 0.0);

  SetOmnvar("ui_twar_momentum_maxed_time", time);
  SetOmnvar("ui_twar_momentum_end_time_" + team, GetTime() + int(1000 * time));
}

clear_max_momentum_delayed(team, time) {
  level endon("clear_max_momentum_" + team);
  wait time;
  thread clear_maxed_momentum(team);
}

clear_maxed_momentum(team) {
  level notify("clear_max_momentum_" + team);
  if(!is_maxed_momentum(team)) {
    return;
  }

  set_momentum(team, 0.0);
  set_momentum_multiplier(team, level.momentum_multiplier_max - 1);

  SetOmnvar("ui_twar_momentum_end_time_" + team, 0);
}

clear_momentum(team) {
  if(level.twar_team_multiplier[team] == 1) {
    leaderDialog("mtm_clrd", team, "momentum_down");
  } else {
    leaderDialog("mtm_reset", team, "momentum_down");
  }

  clear_maxed_momentum(team);

  current = level.twar_team_momentum[team] + level.twar_team_multiplier[team] - 1;
  add_momentum(team, -1 * current);
}

add_momentum(team, ammount, ignore_maxed) {
  if(ammount == 0) {
    return;
  }

  if(level.momentum_multiplier_max <= 1) {
    return;
  }

  if(!isDefined(ignore_maxed)) {
    ignore_maxed = false;
  }

  if(!ignore_maxed && is_maxed_momentum(team)) {
    return;
  }

  current_momentum = level.twar_team_momentum[team];
  current_multiplier = level.twar_team_multiplier[team];

  rateChange = false;
  current_momentum += ammount;

  while(current_momentum <= 0.0 && current_multiplier > 1) {
    current_momentum += 1.0;
    current_multiplier--;
    rateChange = true;
  }

  if(!rateChange) {
    while(current_momentum >= 1.0 && current_multiplier < level.momentum_multiplier_max) {
      current_momentum -= 1.0;
      current_multiplier++;
      rateChange = true;
    }
  }

  set_momentum(team, current_momentum);

  if(rateChange) {
    set_momentum_multiplier(team, current_multiplier);
  }

  if(is_maxed_momentum(team)) {
    maxed_time = GetDvarFloat("scr_twar_maxed_time", 20.0);
    set_maxed_momentum(team, maxed_time);
  } else {
    SetOmnvar("ui_twar_momentum_" + team, level.twar_team_momentum[team]);
  }
}

set_momentum(team, newValue) {
  newValue = clamp(newValue, 0.0, 1.0);
  level.twar_team_momentum[team] = newValue;
  SetOmnvar("ui_twar_momentum_" + team, level.twar_team_momentum[team]);
}

set_momentum_multiplier(team, new_multiplier) {
  previous_multiplier = level.twar_team_multiplier[team];
  level.twar_team_multiplier[team] = new_multiplier;

  if(previous_multiplier != new_multiplier) {
    SetOmnvar("ui_twar_momentum_scale_" + team, new_multiplier);
    level.twar_use_obj maps\mp\gametypes\_gameobjects::updateUseRate();

    if(previous_multiplier > new_multiplier) {
      if(previous_multiplier != level.momentum_multiplier_max) {
        leaderDialog("mtm_lost", team, "momentum_down");
      }
    } else {
      if(is_maxed_momentum(team)) {
        leaderDialog("mtm_max", team);

        if(!game["max_meter"][team]) {
          game["max_meter"][team] = true;

          foreach(player in level.players) {
            if(player.team != team) {
              continue;
            }

            player maps\mp\gametypes\_missions::processChallenge("ch_twar_blitzkrieg");
          }
        }

      } else {
        leaderDialog("mtm_gain", team);
      }
    }

  }
}

add_kill_enemy_momentum(team) {
  kill_momentum = GetDvarFloat("scr_twar_momentum_kill_enemy", 0.1);
  add_momentum(team, kill_momentum);
}

add_kill_friendly_momentum(team) {
  kill_momentum = GetDvarFloat("scr_twar_momentum_kill_friendly", -0.1);
  add_momentum(team, kill_momentum);
}

add_capture_friendly_momentum(team) {
  capture_momentum = GetDvarFloat("scr_twar_momentum_capture_friendly", 0.2);
  add_momentum(team, capture_momentum);
}

add_capture_enemy_momentum(team) {
  capture_momentum = GetDvarFloat("scr_twar_momentum_capture_enemy", -0.2);
  add_momentum(team, capture_momentum);
}

init_momentum(team) {
  level.twar_team_multiplier[team] = 1;
  level.twar_team_momentum[team] = 0;

  SetOmnvar("ui_twar_momentum_end_time_" + team, 0);
  SetOmnvar("ui_twar_momentum_" + team, level.twar_team_momentum[team]);
  SetOmnvar("ui_twar_momentum_scale_" + team, level.twar_team_multiplier[team]);

  if(level.momentum_multiplier_max <= 1) {
    return;
  }

  level thread init_overtime_momentum(team);
}

init_overtime_momentum(team) {
  gameFlagWait("prematch_done");

  if(game["status"] == "overtime") {
    overtime_momentum = 0;

    owned = game["owned_flags"][team];
    if(owned == 4) {
      overtime_momentum = 2.0;
    } else if(owned == 3) {
      overtime_momentum = 1.0;
    }

    add_momentum(team, overtime_momentum);
  }
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  level.start_spawn_prefix = "mp_twar_spawn_";
  level.start_spawn_allies = "mp_twar_spawn_allies_start";
  level.start_spawn_axis = "mp_twar_spawn_axis_start";

  if(!getSpawnArray(level.start_spawn_allies).size) {
    level.start_spawn_prefix = "mp_tdm_spawn_";
    level.start_spawn_allies = "mp_tdm_spawn_allies_start";
    level.start_spawn_axis = "mp_tdm_spawn_axis_start";
  }

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints(level.start_spawn_allies);
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints(level.start_spawn_axis);

  level.spawn_name = "mp_twar_spawn";
  if(!getSpawnArray(level.spawn_name).size) {
    level.spawn_name = "mp_tdm_spawn";
  }

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", level.spawn_name);
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", level.spawn_name);

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnteam = self.pers["team"];
  if(game["switchedsides"]) {
    spawnteam = getOtherTeam(spawnteam);
  }

  if(level.useStartSpawns && level.inGracePeriod) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(level.start_spawn_prefix + spawnteam + "_start");
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
  } else {
    spawnPoints = [];
    spawnPoints_none = [];

    if(level.twar_zones.size == 1 && level.spawn_version != 3) {
      spawnPoints = level.single_zone_spawns[spawnteam];
    } else if(level.spawn_version == 1) {
      all_spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
      foreach(spawnPoint in all_spawnPoints) {
        if(spawnPoint.nearestZone.owner == spawnteam) {
          spawnPoints[spawnPoints.size] = spawnPoint;
        } else if(spawnPoint.nearestZone.owner == "none") {
          spawnPoints_none[spawnPoints_none.size] = spawnPoint;
        }
      }
    } else if(level.spawn_version == 2) {
      for(i = 0; i < level.twar_zones.size; i++) {
        zone_index = i;

        if(spawnteam == "allies") {
          zone_index = level.twar_zones.size - 1 - i;
        }

        zone = level.twar_zones[zone_index];
        if(zone.owner == spawnteam) {
          spawnPoints = zone.nearSpawns;
          break;
        } else if(zone.owner == "none") {
          spawnPoints_none = zone.nearSpawns;
        }
      }
    } else if(level.spawn_version == 3) {
      currentZone = level.twar_use_obj.zone;
      spawnPoints = currentZone.nearSpawns[spawnteam];
    }

    if(spawnPoints.size == 0) {
      spawnPoints = spawnPoints_none;
    }

    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_twar(spawnPoints, level.twar_use_obj.zone);
  }

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnPoint;
}

onNormalDeath(victim, attacker, lifeId) {
  if(isDefined(attacker)) {
    add_kill_enemy_momentum(attacker.team);
  }

  if(isDefined(victim.team)) {
    add_kill_friendly_momentum(victim.team);
  }
}

get_start_spawn_centers(pathFindValid) {
  team_spawn_center = [];

  teams = ["allies", "axis"];

  spawnPoints = [];
  foreach(team in teams) {
    spawnPoints[team] = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(level.start_spawn_prefix + team + "_start");
  }

  foreach(team in teams) {
    center = (0, 0, 0);

    foreach(spawnPoint in spawnPoints[team]) {
      center += spawnPoint.origin;
    }

    center /= spawnPoints[team].size;
    team_spawn_center[team] = center;
  }

  if(pathFindValid) {
    all_nodes = GetAllNodes();

    foreach(team, center in team_spawn_center) {
      path_found = false;
      for(i = 0; i < 10 && i < all_nodes.size; i++) {
        dist = GetPathDist(center, all_nodes[i].origin, 99999, true);
        if(dist > 0) {
          path_found = true;
          break;
        }
      }

      if(!path_found) {
        team_spawn_center[team] = spawnPoints[team][0].origin;
      }
    }
  }

  return team_spawn_center;
}

find_zones() {
  if(!isDefined(game["zone_origins"])) {
    game["zone_origins"] = get_zone_origins();
  }

  if(!game["zone_origins"].size) {
    game["zone_origins"] = get_zone_origins_auto();
  }

  default_flag_count = 5;
  level.num_zones = GetDvarInt("scr_twar_zone_count", default_flag_count);
  if(level.num_zones <= 0) {
    level.num_zones = default_flag_count;
  }

  if(game["status"] == "overtime") {
    level.num_zones = GetDvarInt("scr_twar_ot_zone_count", 3);
  }

  if(game["zone_origins"].size > level.num_zones) {
    delta = int((game["zone_origins"].size - level.num_zones) / 2);
    middle_zones = [];
    for(i = delta; i <= game["zone_origins"].size - 1 - delta; i++) {
      middle_zones[middle_zones.size] = game["zone_origins"][i];
    }
    game["zone_origins"] = middle_zones;
  }
  Assert(level.num_zones == game["zone_origins"].size);

  SetOmnvar("ui_twar_flag_count", level.num_zones);

  level.twar_zones = [];
  foreach(i, origin_struct in game["zone_origins"]) {
    new_zone = twar_zone(i, origin_struct.origin, origin_struct.angles, color_from_index(i));
    level.twar_zones[i] = new_zone;
  }
}

get_zone_origins() {
  origins = [];

  flags = GetStructArray("twar_zone", "targetname");
  foreach(flag in flags) {
    if(!isDefined(flag.script_index)) {
      return origins;
    }
  }

  if(isAugmentedGameMode()) {
    flags_augmented = GetStructArray("twar_zone_augmented", "targetname");
    foreach(flag_a in flags_augmented) {
      if(!isDefined(flag_a.script_index)) {
        continue;
      }

      foreach(i, flag in flags) {
        if(flag.script_index == flag_a.script_index) {
          flags[i] = flag_a;
        }
      }
    }
  }

  if(flags.size < 3 || flags.size > 7) {
    return origins;
  }

  flags = quickSort(flags, ::quicksort_flag_compare);

  foreach(flag in flags) {
    override_angles = twarZoneAngleOverride(flag);

    origin_struct = spawnStruct();
    origin_struct.origin = flag.origin;

    if(isDefined(override_angles)) {
      origin_struct.angles = override_angles;
    } else {
      origin_struct.angles = flag.script_angles;
    }

    origins[origins.size] = origin_struct;
  }

  level.num_zones = origins.size;

  return origins;
}

twarZoneAngleOverride(flag) {
  map = getMapName();
  override_angles = undefined;

  switch (map) {
    case "mp_detroit":
      if(flag.script_index == 5) {
        override_angles = (0, 215, 0);
      }
      if(flag.script_index == 1) {
        override_angles = (0, 245, 0);
      }
      break;

    default:
      break;
  }

  return override_angles;
}

quicksort_flag_compare(left, right) {
  return left.script_index <= right.script_index;
}

get_zone_origins_auto() {
  level.num_zones = GetDvarInt("scr_twar_zone_count", 5);

  team_spawn_center = get_start_spawn_centers(true);

  teams = ["allies", "axis"];

  allNodes = GetAllNodes();

  frac_spacing = level.num_zones;

  range_scale = GetDvarFloat("scr_twar_auto_zone_spacing", 0.15);
  zig_zag_scale = GetDvarFloat("scr_twar_auto_zone_zig_zag", 0.1);
  allow_traversals = GetDvarInt("scr_twar_auto_zone_allow_traversals", 0);
  sky_only = GetDvarInt("scr_twar_auto_zone_sky_only", 1);

  ranges = [];
  for(i = 0; i < level.num_zones; i++) {
    perfect = (i + 1) / ((level.num_zones + 1) - (i + 1));
    minimum = ((2 * (i + 1)) - 1) / (2 * ((level.num_zones + 1) - (i + 1)) + 1);
    maximum = ((2 * (i + 1)) + 1) / (2 * ((level.num_zones + 1) - (i + 1)) - 1);

    ranges[i]["min"] = perfect - range_scale * (perfect - minimum);
    ranges[i]["max"] = perfect + range_scale * (maximum - perfect);
  }

  range_nodes = [];
  for(i = 0; i < ranges.size; i++) {
    range_nodes[i] = [];
  }

  foreach(node in allNodes) {
    if(sky_only && !NodeExposedToSky(node, true)) {
      continue;
    }

    dist = [];
    foreach(team in teams) {
      dist[team] = GetPathDist(team_spawn_center[team], node.origin, 99999, allow_traversals);
    }

    if(dist["allies"] <= 0 || dist["axis"] <= 0) {
      continue;
    }

    frac = dist["allies"] / dist["axis"];

    for(i = 0; i < ranges.size; i++) {
      if(frac > ranges[i]["min"] && frac < ranges[i]["max"]) {
        range_nodes[i][range_nodes[i].size] = node;
      }
    }
  }

  zone_origins = [];

  from = team_spawn_center["allies"];
  foreach(i, node_set in range_nodes) {
    node_set = SortByDistance(node_set, from);

    min = int(clamp(2 * node_set.size * zig_zag_scale - node_set.size, 0, node_set.size));
    max = int(clamp(2 * node_set.size * zig_zag_scale, 0, node_set.size));

    if(min < max) {
      node_index = RandomIntRange(min, max);
    } else {
      node_index = int(clamp(min, 0, node_set.size - 1));
    }

    origin_struct = spawnStruct();
    origin_struct.origin = node_set[node_index].origin;
    zone_origins[i] = origin_struct;

    from = node_set[node_index].origin;
  }

  return zone_origins;
}

color_from_index(index) {
  return (index &(1 << 2), index &(1 << 1), index &(1 << 0));
}

twar_zone(index, origin, angles, debug_color) {
  s = spawnStruct();

  traceStart = origin + (0, 0, 32);
  traceEnd = origin + (0, 0, -64);
  trace = bulletTrace(traceStart, traceEnd, false, undefined);
  s.origin = trace["position"];

  s.owner = "none";
  s.index = index;
  s.angles = angles;
  s.debug_color = debug_color;
  s.projector = spawn_flag_projector(s.origin);

  return s;
}

draw_spawn_until_notify(spawn, color, notifyString) {
  level endon(notifyString);

  dir = anglesToForward(spawn.angles);
  level thread draw_line_until_notify(spawn.origin, spawn.origin + dir * 50, color, notifyString);

  spawn.debug_draw = true;
  while(1) {
    OrientedBox(spawn.origin + (0, 0, 30), (30, 30, 60), spawn.angles, color, false, 1);
    wait .05;
  }
}

draw_line_until_notify(start, end, color, notifyString) {
  level endon(notifyString);

  while(1) {
    line(start, end, color, 1, false, 1);
    wait .05;
  }
}

draw_circle_until_notify(center, radius, color, notifyString, optionalSides) {
  if(isDefined(optionalSides)) {
    circle_sides = optionalSides;
  } else {
    circle_sides = 16;
  }

  angleFrac = 360 / circle_sides;

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];
    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread draw_line_until_notify(start, end, color, notifyString);
  }
}

assign_spawns() {
  if(level.spawn_version == 2) {
    assign_spawns_version_2();
  } else if(level.spawn_version == 3) {
    assign_spawns_version_3();
  }
}

assign_spawns_version_2() {
  if(level.twar_zones.size == 1) {
    level.single_zone_spawns = [];
    level.single_zone_spawns["allies"] = [];
    level.single_zone_spawns["axis"] = [];

    nearSpawns = getNearestSpawns(level.twar_zones[0], 12);

    foreach(nearSpawn in nearSpawns) {
      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(level.start_spawn_prefix + "allies_start")[0];
      allies_dist = twar_dist(nearSpawn.origin, spawnPoint.origin);

      spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(level.start_spawn_prefix + "axis_start")[0];
      axis_dist = twar_dist(nearSpawn.origin, spawnPoint.origin);

      closest_team = ter_op(allies_dist < axis_dist, "allies", "axis");

      count = level.single_zone_spawns[closest_team].size;
      level.single_zone_spawns[closest_team][count] = nearSpawn;
    }
  } else {
    foreach(zone in level.twar_zones) {
      zone.nearSpawns = getNearestSpawns(zone, 6);
    }

    twar_spawns = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");
    foreach(twar_spawn in twar_spawns) {
      twar_spawn.nearestZone = getNearestZonePoint(twar_spawn);

      if(!array_contains(twar_spawn.nearestZone.nearSpawns, twar_spawn)) {
        count = twar_spawn.nearestZone.nearSpawns.size;
        twar_spawn.nearestZone.nearSpawns[count] = twar_spawn;
      }
    }
  }
}

get_zone_dir(zone_index) {
  dvar = "scr_twar_zone_dir_" + (zone_index + 1);
  SetDvarIfUninitialized(dvar, -1);
  yaw = GetDvarFloat(dvar, -1);
  if(yaw >= 0) {
    return anglesToForward((0, yaw, 0));
  }

  if(isDefined(level.twar_zones[zone_index].angles)) {
    return anglesToForward(level.twar_zones[zone_index].angles);
  } else {
    team_spawn_center = get_start_spawn_centers(false);
    dir = team_spawn_center["axis"] - team_spawn_center["allies"];
    dir = (dir[0], dir[1], 0);
    return VectorNormalize(dir);
  }
}

assign_spawns_version_3() {
  all_spawns = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");
  total_spawns = all_spawns.size;
  foreach(i, zone in level.twar_zones) {
    minPerSide = 6;
    zone.nearSpawns["all"] = getNearestSpawns(zone, 24, level.zone_radius * 3, 0.0);

    zone.dir = get_zone_dir(i);
    foreach(spawnPoint in zone.nearSpawns["all"]) {
      spawn_dir = VectorNormalize(zone.origin - spawnPoint.origin);
      spawnPoint.dot = VectorDot(spawn_dir, zone.dir);
    }

    zone.nearSpawns["all"] = quickSort(zone.nearSpawns["all"], ::twar_spawn_dot);

    zone.nearSpawns["allies"] = [];
    zone.nearSpawns["axis"] = [];

    for(j = 0; j < zone.nearSpawns["all"].size; j++) {
      spawnIndex = int(j / 2);
      spawnTeam = "axis";
      if(j % 2 == 1) {
        spawnIndex = zone.nearSpawns["all"].size - int((j + 1) / 2);
        spawnTeam = "allies";
      }

      addToTeam = undefined;
      spawnPoint = zone.nearSpawns["all"][spawnIndex];

      if(zone.nearSpawns[spawnTeam].size < minPerSide) {
        addToTeam = spawnTeam;
      } else {
        if(spawnPoint.dot > 0) {
          addToTeam = "allies";
        } else {
          addToTeam = "axis";
        }
      }

      if(isDefined(addToTeam)) {
        count = zone.nearSpawns[addToTeam].size;
        zone.nearSpawns[addToTeam][count] = spawnPoint;
      }
    }
  }
}

twar_dist(a, b) {
  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();

  dist = -1;

  if(isPathDataAvailable) {
    dist = GetPathDist(a, b, 999999);
  }

  if(dist == -1) {
    dist = distance(a, b);
  }

  return dist;
}

getNearestSpawns(zone, max_spawns, min_dist, min_dot) {
  if(!isDefined(min_dist)) {
    min_dist = 0;
  }

  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();

  twar_spawns = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");
  foreach(twar_spawn in twar_spawns) {
    twar_spawn.dist = -1;

    if(isPathDataAvailable) {
      twar_spawn.dist = GetPathDist(twar_spawn.origin, zone.origin, 999999);
    }

    if(twar_spawn.dist == -1) {
      twar_spawn.dist = distance(zone.origin, twar_spawn.origin);
    }
  }

  twar_spawns = quickSort(twar_spawns, ::twar_spawn_dist);

  nearest_spawns = [];
  for(i = 0; i < twar_spawns.size && nearest_spawns.size < max_spawns; i++) {
    twar_spawn = twar_spawns[i];
    if(twar_spawn.dist < min_dist) {
      continue;
    }

    if(isDefined(min_dot)) {
      spawn_dir = anglesToForward(twar_spawn.angles);
      twar_dir = VectorNormalize(zone.origin - twar_spawn.origin);

      dot = VectorDot(spawn_dir, twar_dir);
      if(dot < min_dot) {
        continue;
      }
    }

    nearest_spawns[nearest_spawns.size] = twar_spawn;
  }

  return nearest_spawns;
}

twar_spawn_dot(left, right) {
  return left.dot <= right.dot;
}

twar_spawn_dist(left, right) {
  return left.dist <= right.dist;
}

getNearestZonePoint(spawnPoint) {
  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();
  nearestZone = undefined;
  nearestDist = undefined;

  foreach(zone in level.twar_zones) {
    dist = undefined;

    if(isPathDataAvailable) {
      dist = GetPathDist(spawnPoint.origin, zone.origin, 999999);
    }

    if(!isDefined(dist) || (dist == -1)) {
      dist = distance(zone.origin, spawnPoint.origin);
    }

    if(!isDefined(nearestZone) || dist < nearestDist) {
      nearestZone = zone;
      nearestDist = dist;
    }
  }

  return nearestZone;
}

twarDebug() {
  baseOffset = 12;

  SetDevDvar("scr_twar_debug", "0");

  while(true) {
    while(!GetDvarInt("scr_twar_debug", 0)) {
      waitframe();
    }

    current = GetDvarInt("scr_twar_debug", 0);

    if(level.spawn_version == 3) {
      if(current > level.twar_zones.size || current <= 0) {
        SetDvar("scr_twar_debug", 0);
        continue;
      }
    } else {
      SetDevDvar("scr_showspawns", "1");
    }

    all_spawns = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");
    foreach(spawnPoint in all_spawns) {
      spawnPoint.debug_draw = false;
    }

    if(level.twar_zones.size == 1 && level.spawn_version != 3) {
      count = 0;
      team_colors["allies"] = (1, 0, 0);
      team_colors["axis"] = (0, 1, 0);

      foreach(team, color in team_colors) {
        start = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(level.start_spawn_prefix + team + "_start")[0].origin;
        spawnPoints = level.single_zone_spawns[team];
        foreach(spawnPoint in spawnPoints) {
          end = spawnPoint.origin;
          draw_path(start, end, color, baseOffset + count);
          count++;
        }
      }

    } else {
      spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints("axis");

      from = level.twar_zones[0].origin;
      for(i = 1; i < level.twar_zones.size; i++) {
        to = level.twar_zones[i].origin;
        level thread draw_line_until_notify(from, to, color_from_index(level.num_zones), "end_debug");
        from = to;
      }

      count = 0;
      foreach(i, zone in level.twar_zones) {
        draw_zone(zone);
        if(level.spawn_version == 2) {
          foreach(spawnPoint in zone.nearspawns) {
            draw_path(spawnPoint.origin, zone.origin, zone.debug_color, baseOffset + count);
            count++;
          }
        } else if(level.spawn_version == 3) {
          if((i + 1) == GetDvarInt("scr_twar_debug", 0)) {
            foreach(spawnPoint in zone.nearspawns["allies"]) {
              level thread draw_spawn_until_notify(spawnPoint, (0, 0, 1), "end_debug");
              draw_path(spawnPoint.origin, zone.origin, (0, 0, 1), baseOffset + count);
              count++;
            }

            foreach(spawnPoint in zone.nearspawns["axis"]) {
              level thread draw_spawn_until_notify(spawnPoint, (1, 0, 0), "end_debug");
              draw_path(spawnPoint.origin, zone.origin, (1, 0, 0), baseOffset + count);
              count++;
            }
          }
        }
      }

      if(level.spawn_version == 3) {
        foreach(spawnPoint in all_spawns) {
          if(!spawnPoint.debug_draw) {
            level thread draw_spawn_until_notify(spawnPoint, (1, 1, 0), "end_debug");
          }
        }
      }

      if(level.spawn_version == 1) {
        foreach(count, spawnPoint in spawnPoints) {
          draw_path(spawnPoint.origin, spawnPoint.nearestZone.origin, spawnPoint.nearestZone.debug_color, baseOffset + count);
        }
      }
    }

    while(current == GetDvarInt("scr_twar_debug", 1)) {
      waitframe();
    }

    level notify("end_debug");

    SetDevDvar("scr_showspawns", "0");
  }
}

draw_zone(zone) {
  if(level.spawn_version == 3) {
    thread draw_line_until_notify(zone.origin, zone.origin + zone.dir * level.zone_radius * 1.1, zone.debug_color, "end_debug");
  }

  thread draw_circle_until_notify(zone.origin, level.zone_radius, zone.debug_color, "end_debug");
  thread draw_line_until_notify(zone.origin, zone.origin + (0, 0, 50), zone.debug_color, "end_debug");
}

draw_path(start, end, color, z_offset) {
  isPathDataAvailable = maps\mp\gametypes\_spawnlogic::isPathDataAvailable();
  offset = (0, 0, z_offset);

  last_node_origin = start;
  if(isPathDataAvailable) {
    nodeArray = GetNodesOnPath(start, end);

    if(isDefined(nodeArray)) {
      thread draw_line_until_notify(start + offset, nodeArray[0].origin + offset, color, "end_debug");

      for(i = 0; i < nodeArray.size - 1; i++) {
        thread draw_line_until_notify(nodeArray[i].origin + offset, nodeArray[i + 1].origin + offset, color, "end_debug");
        last_node_origin = nodeArray[i + 1].origin;
      }
    }

  }

  thread draw_line_until_notify(last_node_origin + offset, end + offset, color, "end_debug");
}

onSpawnPlayer() {
  self.minionStreak = 0;
}

updateMinions() {
  level endon("game_ended");

  while(!isDefined(level.agentArray)) {
    waitframe();
  }

  gameFlagWait("prematch_done");

  max_minions = GetDvarInt("scr_twar_minionsmax", 18);
  if(max_minions <= 0) {
    return;
  }

  update_minion_hud_outlines();

  teams = ["allies", "axis"];
  spawnDelay = GetDvarFloat("scr_twar_minionspawndelay", 10.0);

  minion_count_huds = [];
  timer_hud = undefined;
  max_minoins_hud = undefined;

  hud_version = GetDvarInt("scr_twar_minionspawnhud", 0);
  if(hud_version > 0) {
    timer_hud = minion_spawn_timer_hud();
    timer_hud hud_set_visible();

    if(hud_version > 1) {
      max_minoins_hud = minion_max_hud();
      foreach(vis_team in teams) {
        foreach(about_team in teams)
      }
      minion_count_huds[vis_team][about_team] = minion_count_hud(vis_team, about_team);
    }
  }

  while(!level.gameEnded) {
    if(isDefined(timer_hud)) {
      timer_hud SetTimer(spawnDelay);
    }

    wait spawnDelay;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    current_minions = getMinionCount();
    requested_minions = level.num_zones - 1;

    if(current_minions + requested_minions < max_minions) {
      team_spawn_count = [];
      foreach(team in teams) {
        team_spawn_count[team] = 0;
      }

      foreach(zone in level.twar_zones) {
        team = zone.owner;
        if(team != "allies" && team != "axis") {
          continue;
        }

        spawn_origin = undefined;
        spawn_angles = undefined;

        agent = maps\mp\agents\_agents::add_humanoid_agent("player", team, "minion", spawn_origin, spawn_angles, undefined, false, false, "recruit");

        if(isDefined(agent)) {
          agent TakeAllWeapons();

          weapon_index = GetDvarInt("scr_twar_minionweapon", 0);
          weapon_name = "";
          switch (weapon_index) {
            case 2:
              weapon_name = "iw5_kf5_mp";
              break;
            case 1:
              weapon_name = "iw5_hbra3_mp";
              break;
            case 0:
            default:
              weapon_name = "iw5_titan45_mp";
              break;
          }

          agent GiveWeapon(weapon_name);
          agent SwitchToWeaponImmediate(weapon_name);

          agent GivePerk("specialty_minion", false);
          agent.moveSpeedScaler = GetDvarFloat("scr_twar_minionmovespeedscale", 0.85);
          agent.damage_scale = GetDvarFloat("scr_twar_miniondamagescale", 0.5);
          agent.agentname = &"MP_MINION";
          agent.nonKillstreakAgent = true;
          agent thread minion_ai();
          update_minion_hud_outlines();

          agent DetachAll();
          agent setModel("kva_hazmat_body_infected_mp");
          agent Attach("kva_hazmat_head_infected");
          agent SetClothType("cloth");

          health_scale = GetDvarFloat("scr_twar_minionhealthscale", 0.75);
          agent maps\mp\agents\_agent_common::set_agent_health(int(agent.health * health_scale));

          team_spawn_count[team]++;
        }
      }

      foreach(vis_team, huds in minion_count_huds) {
        foreach(about_team, hud in huds) {
          hud hud_set_visible();
          hud SetValue(team_spawn_count[about_team]);
          hud delayThread(3.0, ::hud_set_invisible);
        }
      }
    } else {
      if(isDefined(max_minoins_hud)) {
        max_minoins_hud hud_set_visible();
        max_minoins_hud delayThread(3.0, ::hud_set_invisible);
      }
    }
  }
}

is_minion() {
  return self HasPerk("specialty_minion", true);
}

hud_set_visible() {
  self.alpha = 1.0;
}

hud_set_invisible() {
  self.alpha = 0.0;
}

minion_max_hud() {
  hud = self createServerFontString("hudbig", 1.0);
  hud maps\mp\gametypes\_hud_util::setPoint("BOTTOM", undefined, 0, -20);
  hud.label = &"MP_DOMAI_MINIONS_SPAWNED_MAX";
  hud.color = (1, 0, 0);
  hud.archived = true;
  hud.showInKillcam = true;
  hud.alpha = 0.0;

  return hud;
}

minion_count_hud(vis_team, about_team) {
  hud = self createServerFontString("hudbig", 1.0, vis_team);
  hud maps\mp\gametypes\_hud_util::setPoint("BOTTOM", undefined, 0, ter_op(vis_team == about_team, -40, -20));
  hud.label = ter_op(vis_team == about_team, &"MP_DOMAI_MINIONS_SPAWNED_FRIENDLY", &"MP_DOMAI_MINIONS_SPAWNED_ENEMY");
  hud.color = ter_op(vis_team == about_team, COLOR_BLUE, COLOR_ORANGE);
  hud.archived = true;
  hud.showInKillcam = true;
  hud.alpha = 0.0;

  return hud;
}

minion_spawn_timer_hud() {
  timer = maps\mp\gametypes\_hud_util::createServerTimer("hudbig", 1.0);
  timer maps\mp\gametypes\_hud_util::setPoint("BOTTOM", undefined, 0, -60);
  timer.label = &"MP_DOMAI_MINIONS_SPAWN_TIMER";
  timer.color = (1, 1, 1);
  timer.archived = true;
  timer.showInKillcam = true;

  return timer;
}

update_minion_hud_outlines() {
  allies = [];
  axis = [];

  outline_enabled = GetDvarInt("scr_twar_minionoutline", 0);

  foreach(player in level.players) {
    if(player.team == "allies") {
      allies[allies.size] = player;
    } else {
      axis[axis.size] = player;
    }
  }

  foreach(agent in level.agentarray) {
    if(agent is_minion()) {
      if(level.players.size > 0) {
        agent HudOutlineDisableForClients(level.players);
      }

      if(outline_enabled) {
        if(allies.size > 0) {
          agent HudOutlineEnableForClients(allies, ter_op(agent.team == "allies", 2, 3), true);
        }
        if(axis.size > 0) {
          agent HudOutlineEnableForClients(axis, ter_op(agent.team == "axis", 2, 3), true);
        }
      }
    }
  }
}

minion_ai() {
  self endon("death");

  while(1) {
    if(isDefined(level.twar_use_obj)) {
      desired_goal = level.twar_use_obj.trigger.origin;
      self BotSetScriptGoal(desired_goal, level.zone_radius * 0.9, "objective");
    }

    wait .1;
  }
}

getMinionCount() {
  count = 0;
  foreach(agent in level.agentArray) {
    if(isDefined(agent.isActive) && agent.isActive && agent.agent_type == "player" && agent is_minion()) {
      count++;
    }
  }

  return count;
}

minion_damage(victim, eAttacker, iDamage, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc) {
  if(isDefined(eAttacker) && isDefined(eAttacker.damage_scale)) {
    iDamage = int(iDamage * eAttacker.damage_scale);
  }

  return iDamage;
}

on_minion_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  if(isPlayer(eAttacker) && self is_minion() && (eAttacker.team != self.team)) {
    score_multiple = GetDvarFloat("scr_twar_score_kill_minion_multipler", 0);
    if(score_multiple > 0) {
      base = GetDvarFloat("scr_twar_score_kill_minion_base", 10);

      score = int(eAttacker.minionStreak * score_multiple + base);
      score = min(score, GetDvarInt("scr_twar_score_kill_minion_max", 150));
      SetDvar("scr_twar_score_kill_minion", score);
    }

    eAttacker.minionStreak++;

    level thread maps\mp\gametypes\_rank::awardGameEvent("kill_minion", eAttacker, sWeapon, self, sMeansOfDeath);

    if(isDefined(eAttacker)) {
      add_kill_enemy_minion_momentum(eAttacker.team);
    }

    if(isDefined(self.team)) {
      add_kill_friendly_minion_momentum(self.team);
    }
  }
}

add_kill_enemy_minion_momentum(team) {
  kill_momentum = GetDvarFloat("scr_twar_momentum_kill_enemy_minion", 0.1);
  add_momentum(team, kill_momentum);
}

add_kill_friendly_minion_momentum(team) {
  kill_momentum = GetDvarFloat("scr_twar_momentum_kill_friendly_minion", -0.1);
  add_momentum(team, kill_momentum);
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(!isPlayer(attacker)) {
    return;
  }

  if(maps\mp\gametypes\_damage::isFriendlyFire(self, attacker)) {
    return;
  }

  if(attacker == self) {
    return;
  }

  if(isDefined(sWeapon) && isKillstreakWeapon(sWeapon)) {
    return;
  }

  awardedkillWhileCapture = false;
  victim = self;

  foreach(trigger in attacker.touchTriggers) {
    if(trigger != level.twar_use_obj.trigger) {
      continue;
    }

    attacker thread maps\mp\_events::killWhileCapture(victim, killId);
    awardedkillWhileCapture = true;
    break;
  }

  if(!awardedkillWhileCapture) {
    foreach(trigger in victim.touchTriggers) {
      if(trigger != level.twar_use_obj.trigger) {
        continue;
      }

      attacker thread maps\mp\_events::assaultObjectiveEvent(self, killId);
    }
  }
}