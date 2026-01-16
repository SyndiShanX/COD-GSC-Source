/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\mugger.gsc
****************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\killstreaks\_airdrop;

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [
      [level.initializeMatchRules]
    ]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 7);
    registerScoreLimitDvar(level.gameType, 2500);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;

    level.mugger_bank_limit = GetDvarInt("scr_mugger_bank_limit", 10);
  }

  SetTeamMode("ffa");

  level.onPrecacheGameType = ::onPrecacheGameType;
  level.onStartGameType = ::onStartGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onPlayerScore = ::onPlayerScore;
  level.onTimeLimit = ::onTimeLimit;
  level.onXPEvent = ::onXPEvent;
  level.customCrateFunc = ::createMuggerCrates;

  level.assists_disabled = true;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  level.mugger_fx["vanish"] = loadFx("impacts/small_snowhit");

  level.mugger_fx["smoke"] = loadFx("smoke/airdrop_flare_mp_effect_now");
  level.mugger_targetFXID = loadfx("misc/ui_flagbase_red");

  level thread onPlayerConnect();
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_mugger_roundswitch", 0);
  registerRoundSwitchDvar("mugger", 0, 0, 9);
  SetDynamicDvar("scr_mugger_roundlimit", 1);
  registerRoundLimitDvar("mugger", 1);
  SetDynamicDvar("scr_mugger_winlimit", 1);
  registerWinLimitDvar("mugger", 1);
  SetDynamicDvar("scr_mugger_halftime", 0);
  registerHalfTimeDvar("mugger", 0);

  SetDynamicDvar("scr_mugger_promode", 0);

  level.mugger_bank_limit = GetMatchRulesData("muggerData", "bankLimit");
  SetDynamicDvar("scr_mugger_bank_limit", level.mugger_bank_limit);

  level.mugger_jackpot_limit = GetMatchRulesData("muggerData", "jackpotLimit");
  SetDynamicDvar("scr_mugger_jackpot_limit", level.mugger_jackpot_limit);

  level.mugger_throwing_knife_mug_frac = GetMatchRulesData("muggerData", "throwKnifeFrac");
  SetDynamicDvar("scr_mugger_throwing_knife_mug_frac", level.mugger_throwing_knife_mug_frac);
}

onPrecacheGameType() {
  precachemodel("prop_dogtags_foe_iw6");
  precacheModel("weapon_us_smoke_grenade_burnt2");

  precacheMpAnim("mp_dogtag_spin");

  precacheshader("waypoint_dogtags2");
  precacheshader("waypoint_dogtag_pile");
  precacheshader("waypoint_jackpot");
  precacheshader("hud_tagcount");

  PrecacheSound("mugger_mugging");
  PrecacheSound("mugger_mega_mugging");
  PrecacheSound("mugger_you_mugged");
  PrecacheSound("mugger_got_mugged");
  PrecacheSound("mugger_mega_drop");
  PrecacheSound("mugger_muggernaut");
  PrecacheSound("mugger_tags_banked");

  PreCacheString(&"MPUI_MUGGER_JACKPOT");
}

onStartGameType() {
  setClientNameMode("auto_change");

  setObjectiveText("allies", & "OBJECTIVES_MUGGER");
  setObjectiveText("axis", & "OBJECTIVES_MUGGER");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", & "OBJECTIVES_MUGGER");
    setObjectiveScoreText("axis", & "OBJECTIVES_MUGGER");
  } else {
    setObjectiveScoreText("allies", & "OBJECTIVES_MUGGER_SCORE");
    setObjectiveScoreText("axis", & "OBJECTIVES_MUGGER_SCORE");
  }
  setObjectiveHintText("allies", & "OBJECTIVES_MUGGER_HINT");
  setObjectiveHintText("axis", & "OBJECTIVES_MUGGER_HINT");

  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);

  level.dogtags = [];

  allowed[0] = level.gameType;
  allowed[1] = "dm";

  maps\mp\gametypes\_gameobjects::main(allowed);

  level.mugger_timelimit = GetDvarInt("scr_mugger_timelimit", 7);
  SetDynamicDvar("scr_mugger_timeLimit", level.mugger_timelimit);
  registerTimeLimitDvar("mugger", level.mugger_timelimit);

  level.mugger_scorelimit = GetDvarInt("scr_mugger_scorelimit", 2500);
  if(level.mugger_scorelimit == 0) {
    level.mugger_scorelimit = 2500;
  }
  SetDynamicDvar("scr_mugger_scoreLimit", level.mugger_scorelimit);
  registerScoreLimitDvar("mugger", level.mugger_scorelimit);

  level.mugger_bank_limit = GetDvarInt("scr_mugger_bank_limit", 10);
  level.mugger_muggernaut_window = GetDvarInt("scr_mugger_muggernaut_window", 3000);
  level.mugger_muggernaut_muggings_needed = GetDvarInt("scr_mugger_muggernaut_muggings_needed", 3);
  level.mugger_min_spawn_dist_sq = squared(GetDvarFloat("mugger_min_spawn_dist", 350));
  level.mugger_jackpot_limit = GetDvarInt("scr_mugger_jackpot_limit", 0);
  level.mugger_jackpot_wait_sec = GetDvarFloat("scr_mugger_jackpot_wait_sec", 10);
  level.mugger_throwing_knife_mug_frac = GetDvarFloat("scr_mugger_throwing_knife_mug_frac", 1.0);

  level mugger_init_tags();

  level thread mugger_monitor_tank_pickups();
  level thread mugger_monitor_remote_uav_pickups();

  createDropZones();

  level.jackpot_zone = spawn("script_model", (0, 0, 0));
  level.jackpot_zone.origin = (0, 0, 0);
  level.jackpot_zone.angles = (90, 0, 0);
  level.jackpot_zone setModel("weapon_us_smoke_grenade_burnt2");
  level.jackpot_zone hide();
  level.jackpot_zone.mugger_fx_playing = false;

  level thread mugger_jackpot_watch();
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);
    player.tags_carried = 0;
    player.total_tags_banked = 0;
    player.assists = player.total_tags_banked;
    player.pers["assists"] = player.total_tags_banked;
    player.game_extrainfo = player.tags_carried;
    player.muggings = [];

    if(IsPlayer(player) && !IsBot(player)) {
      player.dogtagsIcon = player createIcon("hud_tagcount", 48, 48);
      player.dogtagsIcon setPoint("TOP LEFT", "TOP LEFT", 200, 0);
      player.dogtagsIcon.alpha = 1;
      player.dogtagsIcon.hideWhenInMenu = true;
      player.dogtagsIcon.archived = true;
      level thread hideHudElementOnGameEnd(player.dogtagsIcon);

      player.dogtagsText = player createFontString("bigfixed", 1.0);
      player.dogtagsText setParent(player.dogtagsIcon);
      player.dogtagsText setPoint("CENTER", "CENTER", -24);
      player.dogtagsText setValue(player.tags_carried);
      player.dogtagsText.alpha = 1;
      player.dogtagsText.color = (1, 1, 0.5);
      player.dogtagsText.glowAlpha = 1;
      player.dogtagsText.sort = 1;
      player.dogtagsText.hideWhenInMenu = true;
      player.dogtagsText.archived = true;
      player.dogtagsText maps\mp\gametypes\_hud::fontPulseInit(3.0);
      level thread hideHudElementOnGameEnd(player.dogtagsText);
    }
  }
}

onSpawnPlayer() {
  self.muggings = [];
  if(!IsAgent(self)) {
    self thread waitReplaySmokeFxForNewPlayer();
  }
}

hideHudElementOnGameEnd(hudElement) {
  level waittill("game_ended");

  if(isDefined(hudElement))
    hudElement.alpha = 0;
}

getSpawnPoint() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
  spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);

  return spawnPoint;
  return spawnPoint;
}

onXPEvent(event) {
  if(isDefined(event) && event == "suicide") {
    level thread spawnDogTags(self, self);
  }
  self maps\mp\gametypes\_globallogic::onXPEvent(event);
}

onNormalDeath(victim, attacker, lifeId) {
  level thread spawnDogTags(victim, attacker);

  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
    attacker.finalKill = true;
}

mugger_init_tags() {
  level.mugger_max_extra_tags = GetDvarInt("scr_mugger_max_extra_tags", 50);

  level.mugger_extra_tags = [];
}

spawnDogTags(victim, attacker) {
  if(IsAgent(attacker)) {
    attacker = attacker.owner;
  }

  num_extra_tags = 0;
  was_a_stabbing = false;
  if(isDefined(attacker)) {
    if(victim == attacker) {
      if(victim.tags_carried > 0) {
        num_extra_tags = victim.tags_carried;
        victim.tags_carried = 0;
        victim.game_extrainfo = 0;
        if(IsPlayer(victim) && !IsBot(victim)) {
          victim.dogtagsText setValue(victim.tags_carried);
          victim.dogtagsText thread maps\mp\gametypes\_hud::fontPulse(victim);
          victim thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("mugger_suicide", num_extra_tags);
        }
      }
    } else if(isDefined(victim.attackerData) && victim.attackerData.size > 0) {
      if(IsPlayer(attacker) && isDefined(victim.attackerData) && isDefined(attacker.guid) && isDefined(victim.attackerData[attacker.guid])) {
        attData = victim.attackerData[attacker.guid];
        if(isDefined(attData) && isDefined(attData.attackerEnt) && attData.attackerEnt == attacker) {
          if(isDefined(attData.sMeansOfDeath) && (attData.sMeansOfDeath == "MOD_MELEE" || ((attData.weapon == "throwingknife_mp" || attData.weapon == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac > 0.0))) {
            was_a_stabbing = true;
            if(victim.tags_carried > 0) {
              num_extra_tags = victim.tags_carried;
              if((attData.weapon == "throwingknife_mp" || attData.weapon == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac < 1.0) {
                num_extra_tags = int(ceil(victim.tags_carried * level.mugger_throwing_knife_mug_frac));
              }
              victim.tags_carried -= num_extra_tags;
              victim.game_extrainfo = victim.tags_carried;
              if(IsPlayer(victim) && !IsBot(victim)) {
                victim.dogtagsText setValue(victim.tags_carried);
                victim.dogtagsText thread maps\mp\gametypes\_hud::fontPulse(victim);
                victim thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("callout_mugged", num_extra_tags);
                victim PlayLocalSound("mugger_got_mugged");
              }
              playSoundAtPos(victim.origin, "mugger_mugging");

              attacker thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("callout_mugger", num_extra_tags);
              if(attData.weapon == "throwingknife_mp" || attData.weapon == "throwingknifejugg_mp")
                attacker PlayLocalSound("mugger_you_mugged");
            }

            attacker.muggings[attacker.muggings.size] = GetTime();
            attacker thread mugger_check_muggernaut();
          }
        }
      }
    }
  }

  if(IsAgent(victim)) {
    pos = victim.origin + (0, 0, 14);
    playSoundAtPos(pos, "mp_killconfirm_tags_drop");

    level notify("mugger_jackpot_increment");

    dropped_dogtag = mugger_tag_temp_spawn(victim.origin, 40, 160);

    dropped_dogtag.victim = victim.owner;

    if(isDefined(attacker) && victim != attacker) {
      dropped_dogtag.attacker = attacker;
    } else {
      dropped_dogtag.attacker = undefined;
    }
    return;
  } else if(isDefined(level.dogtags[victim.guid])) {
    playFX(level.mugger_fx["vanish"], level.dogtags[victim.guid].curOrigin);
    level.dogtags[victim.guid] notify("reset");
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel("prop_dogtags_foe_iw6");

    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    trigger.targetname = "trigger_dogtag";
    trigger hide();

    level.dogtags[victim.guid] = maps\mp\gametypes\_gameobjects::createUseObject("any", trigger, visuals, (0, 0, 16));

    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["axis"]);

    level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::setUseTime(0);
    level.dogtags[victim.guid].onUse = ::onUse;
    trigger.dogtag = level.dogtags[victim.guid];
    level.dogtags[victim.guid].victim = victim;

    level.dogtags[victim.guid].objId = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(level.dogtags[victim.guid].objId, "invisible", (0, 0, 0));
    objective_icon(level.dogtags[victim.guid].objId, "waypoint_dogtags2");

    level.dogtags[victim.guid].visuals[0] ScriptModelPlayAnim("mp_dogtag_spin");

    level thread clearOnVictimDisconnect(victim);
  }

  pos = victim.origin + (0, 0, 14);
  level.dogtags[victim.guid].curOrigin = pos;
  level.dogtags[victim.guid].trigger.origin = pos;
  level.dogtags[victim.guid].visuals[0].origin = pos;
  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::initializeTagPathVariables();

  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::allowUse("any");

  level.dogtags[victim.guid].visuals[0] show();

  if(isDefined(attacker) && victim != attacker) {
    level.dogtags[victim.guid].attacker = attacker;
  } else {
    level.dogtags[victim.guid].attacker = undefined;
  }
  level.dogtags[victim.guid] thread timeOut();

  if(num_extra_tags < 5) {
    objective_position(level.dogtags[victim.guid].objId, pos);
    objective_state(level.dogtags[victim.guid].objId, "active");

  } else {
    mugger_tag_pile_notify(pos, "mugger_megadrop", num_extra_tags, victim, attacker);
  }

  playSoundAtPos(pos, "mp_killconfirm_tags_drop");

  level.dogtags[victim.guid].temp_tag = false;

  if(num_extra_tags == 0)
    level notify("mugger_jackpot_increment");

  for(i = 0; i < num_extra_tags; i++) {
    dropped_dogtag = mugger_tag_temp_spawn(victim.origin, 40, 160);

    dropped_dogtag.victim = victim;

    if(isDefined(attacker) && victim != attacker) {
      dropped_dogtag.attacker = attacker;
    } else {
      dropped_dogtag.attacker = undefined;
    }
  }
}

mugger_tag_pickup_wait() {
  level endon("game_ended");
  self endon("reset");
  self endon("reused");
  self endon("deleted");

  while(true) {
    self.trigger waittill("trigger", player);
    if(!isReallyAlive(player)) {
      continue;
    }
    if(player isUsingRemote() || isDefined(player.spawningAfterRemoteDeath)) {
      continue;
    }
    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }
    self thread onUse(player);
    return;
  }
}

mugger_add_extra_tag(index) {
  visuals[0] = spawn("script_model", (0, 0, 0));
  visuals[0] setModel("prop_dogtags_foe_iw6");

  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  trigger.targetname = "trigger_dogtag";
  trigger hide();

  level.mugger_extra_tags[index] = spawnStruct();
  new_extra_tag = level.mugger_extra_tags[index];

  new_extra_tag.type = "useObject";
  new_extra_tag.curOrigin = trigger.origin;
  new_extra_tag.entNum = trigger getEntityNumber();

  new_extra_tag.trigger = trigger;
  new_extra_tag.triggerType = "proximity";
  new_extra_tag maps\mp\gametypes\_gameobjects::allowUse("any");

  visuals[0].baseOrigin = visuals[0].origin;
  new_extra_tag.visuals = visuals;
  new_extra_tag.offset3d = (0, 0, 16);

  new_extra_tag.temp_tag = true;
  new_extra_tag.last_used_time = 0;

  new_extra_tag.visuals[0] ScriptModelPlayAnim("mp_dogtag_spin");

  new_extra_tag thread mugger_tag_pickup_wait();

  return new_extra_tag;
}

mugger_first_unused_or_oldest_extra_tag() {
  oldest_tag = undefined;
  oldest_time = -1;
  foreach(extra_tag in level.mugger_extra_tags) {
    if(extra_tag.interactTeam == "none") {
      extra_tag.last_used_time = GetTime();
      extra_tag.visuals[0] show();
      return extra_tag;
    }
    if(!isDefined(oldest_tag) || extra_tag.last_used_time < oldest_time) {
      oldest_time = extra_tag.last_used_time;
      oldest_tag = extra_tag;
    }
  }

  if(level.mugger_extra_tags.size < level.mugger_max_extra_tags) {
    new_tag = mugger_add_extra_tag(level.mugger_extra_tags.size);
    if(isDefined(new_tag)) {
      new_tag.last_used_time = GetTime();
      return new_tag;
    }
  }

  LogPrint("Warning: mugger mode ran out of tags, recycling oldest\n");

  oldest_tag.last_used_time = GetTime();
  oldest_tag notify("reused");
  playFX(level.mugger_fx["vanish"], oldest_tag.curOrigin);
  return oldest_tag;
}

mugger_tag_temp_spawn(org, distMin, distMax) {
  dropped_dogtag = mugger_first_unused_or_oldest_extra_tag();

  startpos = org + (0, 0, 14);
  random_angle = (0, RandomFloat(360), 0);
  random_dir = anglesToForward(random_angle);

  random_dist = RandomFloatRange(40, 160);
  testpos = startpos + (random_dist * random_dir);

  testpos = testpos + (0, 0, 40);
  pos = PlayerPhysicsTrace(startpos, testpos);

  startpos = pos;
  testpos = startpos + (0, 0, -100);
  pos = PlayerPhysicsTrace(startpos, testpos);

  if(pos[2] != testpos[2]) {
    pos = pos + (0, 0, 14);
  }

  dropped_dogtag.curOrigin = pos;
  dropped_dogtag.trigger.origin = pos;
  dropped_dogtag.visuals[0].origin = pos;
  dropped_dogtag maps\mp\gametypes\_gameobjects::initializeTagPathVariables();

  dropped_dogtag maps\mp\gametypes\_gameobjects::allowUse("any");

  dropped_dogtag thread mugger_tag_pickup_wait();
  dropped_dogtag thread timeOut();

  return dropped_dogtag;
}

mugger_tag_pile_notify(pos, event, num_tags, victim, attacker) {
  level notify("mugger_tag_pile", pos);

  dogtagPileObjId = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(dogtagPileObjId, "active", pos);
  objective_icon(dogtagPileObjId, "waypoint_dogtag_pile");

  level delayThread(5, ::mugger_pile_icon_remove, dogtagPileObjId);
  if(num_tags >= 10) {
    level.mugger_last_mega_drop = GetTime();
    level.mugger_jackpot_num_tags = 0;

    foreach(player in level.players) {
      player PlaySoundToPlayer("mp_defcon_one", player);

      if(isDefined(victim) && player == victim) {
        continue;
      }
      if(isDefined(attacker) && player == attacker) {
        continue;
      }
      player thread maps\mp\gametypes\_hud_message::SplashNotify(event, num_tags);
    }

    dogtagPileIcon = newHudElem();
    dogtagPileIcon setShader("waypoint_dogtag_pile", 10, 10);
    dogtagPileIcon SetWayPoint(false, true, false, false);
    dogtagPileIcon.x = pos[0];
    dogtagPileIcon.y = pos[1];
    dogtagPileIcon.z = pos[2] + 32;
    dogtagPileIcon.alpha = 1;
    dogtagPileIcon FadeOverTime(5);
    dogtagPileIcon.alpha = 0;
    dogtagPileIcon delayThread(5, ::hudElemDestroy);
  }
}

hudElemDestroy() {
  if(isDefined(self)) {
    self destroy();
  }
}

mugger_monitor_tank_pickups() {
  level endon("game_ended");
  while(1) {
    remote_tanks = getEntArray("remote_tank", "targetname");
    dogtag_triggers = getEntArray("trigger_dogtag", "targetname");
    foreach(player in level.players) {
      if(isDefined(player.using_remote_tank) && player.using_remote_tank == true) {
        foreach(rtank in remote_tanks) {
          if(isDefined(rtank) && isDefined(rtank.owner) && rtank.owner == player) {
            foreach(trig in dogtag_triggers) {
              if(isDefined(trig) && isDefined(trig.dogtag)) {
                if(isDefined(trig.dogtag.interactTeam) && trig.dogtag.interactTeam != "none") {
                  if(rtank IsTouching(trig)) {
                    trig.dogtag onUse(rtank.owner);
                  }
                }
              }
            }
          }
        }
      }
    }
    wait(0.2);
  }
}

mugger_monitor_remote_uav_pickups() {
  level endon("game_ended");
  while(1) {
    dogtag_triggers = getEntArray("trigger_dogtag", "targetname");
    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.remoteUAV)) {
        foreach(trig in dogtag_triggers) {
          if(isDefined(trig) && isDefined(trig.dogtag)) {
            if(isDefined(trig.dogtag.interactTeam) && trig.dogtag.interactTeam != "none") {
              if(player.remoteUAV IsTouching(trig)) {
                trig.dogtag onUse(player);
              }
            }
          }
        }
      }
    }
    wait(0.2);
  }
}

mugger_check_muggernaut() {
  level endon("game_ended");
  selfendon("disconnect");

  selfnotify("checking_muggernaut");
  selfendon("checking_muggernaut");

  wait(2);

  if(self.muggings.size < level.mugger_muggernaut_muggings_needed) {
    return;
  }
  last_mug_time = self.muggings[self.muggings.size - 1];
  mug_time_threshhold = last_mug_time - level.mugger_muggernaut_window;
  muggings_in_threshhold = [];
  foreach(mug_time in self.muggings) {
    if(mug_time >= mug_time_threshhold) {
      muggings_in_threshhold[muggings_in_threshhold.size] = mug_time;
    }
  }

  if(muggings_in_threshhold.size >= level.mugger_muggernaut_muggings_needed) {
    self thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("muggernaut", self.tags_carried);
    self thread maps\mp\gametypes\_rank::giveRankXP("muggernaut");

    self mugger_bank_tags(true, true);

    self.muggings = [];
  } else {
    self.muggings = muggings_in_threshhold;
  }
}

mugger_pile_icon_remove(dogtagPileObjId) {
  objective_delete(dogtagPileObjId);
}

HideFromPlayer(pPlayer) {
  self hide();

  foreach(player in level.players) {
    if(player != pPlayer)
      self ShowToPlayer(player);
  }
}

onUse(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  if(self.temp_tag) {
    self.trigger playSound("mp_killconfirm_tags_deny");
  } else if(isDefined(self.attacker) && player == self.attacker) {
    self.trigger playSound("mp_killconfirm_tags_pickup");

    player incPlayerStat("killsconfirmed", 1);
    player incPersStat("confirmed", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "confirmed", player.pers["confirmed"]);
  } else {
    self.trigger playSound("mp_killconfirm_tags_deny");

    player incPlayerStat("killsdenied", 1);
    player incPersStat("denied", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "denied", player.pers["denied"]);
  }

  player thread onPickup();

  self resetTags(true);
}

onPickup() {
  level endon("game_ended");
  selfendon("disconnect");

  while(!isDefined(self.pers))
    wait(0.05);

  self thread mugger_delayed_banking();
}

mugger_delayed_banking() {
  self notify("banking");
  self endon("banking");
  level endon("banking_all");

  self.tags_carried++;
  self.game_extrainfo = self.tags_carried;
  if(IsPlayer(self) && !IsBot(self)) {
    self.dogtagsText setValue(self.tags_carried);
    self.dogtagsText thread maps\mp\gametypes\_hud::fontPulse(self);
  }

  wait(1.5);
  tags_left = level.mugger_bank_limit - self.tags_carried;
  if(tags_left > 0 && tags_left <= 5) {
    progress_sound = undefined;
    switch (tags_left) {
      case 1:
        progress_sound = "mugger_1more";
        break;
      case 2:
        progress_sound = "mugger_2more";
        break;
      case 3:
        progress_sound = "mugger_3more";
        break;
      case 4:
        progress_sound = "mugger_4more";
        break;
      case 5:
        progress_sound = "mugger_5more";
        break;
    }
    if(isDefined(progress_sound)) {
      self PlaySoundToPlayer(progress_sound, self);
    }
  }

  wait(0.5);

  mugger_bank_tags(false);
}

mugger_bank_tags(bank_all, noSplash) {
  tags_to_bank = 0;
  if(bank_all == true) {
    tags_to_bank = self.tags_carried;
  } else {
    tags_remainder = self.tags_carried % level.mugger_bank_limit;
    tags_to_bank = self.tags_carried - tags_remainder;
  }

  if(tags_to_bank > 0) {
    self.tags_to_bank = tags_to_bank;
    if(!isDefined(noSplash)) {
      self thread maps\mp\gametypes\_hud_message::SplashNotifyUrgent("callout_tags_banked", tags_to_bank);
    }
    self thread maps\mp\gametypes\_rank::giveRankXP("tags_banked", self.tags_to_bank * maps\mp\gametypes\_rank::getScoreInfoValue("kill_confirmed"));
    level thread maps\mp\gametypes\_gamescore::givePlayerScore("tags_banked", self, undefined, true);
    self.total_tags_banked += tags_to_bank;
    self.tags_carried -= tags_to_bank;
    self.game_extrainfo = self.tags_carried;
    if(IsPlayer(self) && !IsBot(self)) {
      self.dogtagsText setValue(self.tags_carried);
      self.dogtagsText thread maps\mp\gametypes\_hud::fontPulse(self);
    }

    self.assists = self.total_tags_banked;
    self.pers["assists"] = self.total_tags_banked;

    self UpdateScores();
  }
}

onPlayerScore(event, player, victim) {
  if(event == "tags_banked" && isDefined(player) && isDefined(player.tags_to_bank) && player.tags_to_bank > 0) {
    banking_score = player.tags_to_bank * maps\mp\gametypes\_rank::getScoreInfoValue("kill_confirmed");
    player.tags_to_bank = 0;
    return banking_score;
  }
  return 0;
}

resetTags(picked_up) {
  if(!picked_up) {
    level notify("mugger_jackpot_increment");
  }
  self.attacker = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.curOrigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self maps\mp\gametypes\_gameobjects::allowUse("none");
  if(isDefined(self.jackpot_tag) && self.jackpot_tag == true) {
    level.mugger_jackpot_tags_spawned--;
  }
  if(!self.temp_tag) {
    objective_state(self.objId, "invisible");
  }
}

timeOut() {
  levelendon("game_ended");
  self endon("death");
  self endon("deleted");
  self endon("reset");
  self endon("reused");

  self notify("timeout_start");
  self endon("timeout_start");

  level maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(27.0);

  time_left = 3.0;
  while(time_left > 0.0) {
    self.visuals[0] Hide();
    wait(0.25);
    self.visuals[0] Show();
    wait(0.25);
    time_left -= 0.5;
  }
  playFX(level.mugger_fx["vanish"], self.curOrigin);
  self thread resetTags(false);
}

clearOnVictimDisconnect(victim) {
  level endon("game_ended");

  guid = victim.guid;
  victim waittill("disconnect");

  if(isDefined(level.dogtags[guid])) {
    level.dogtags[guid] maps\mp\gametypes\_gameobjects::allowUse("none");

    playFX(level.mugger_fx["vanish"], level.dogtags[guid].curOrigin);
    level.dogtags[guid] notify("reset");
    wait(0.05);

    if(isDefined(level.dogtags[guid])) {
      objective_delete(level.dogtags[guid].objId);
      level.dogtags[guid].trigger delete();
      for(i = 0; i < level.dogtags[guid].visuals.size; i++)
        level.dogtags[guid].visuals[i] delete();
      level.dogtags[guid] notify("deleted");

      level.dogtags[guid] = undefined;
    }
  }
}

onTimeLimit() {
  level notify("banking_all");

  foreach(player in level.players) {
    player mugger_bank_tags(true);
  }
  wait(0.1);
  maps\mp\gametypes\_gamelogic::default_onTimeLimit();
}

MUGGER_ZONE_DROP_RADIUS = 50;
mugger_jackpot_watch() {
  level endon("game_ended");
  level endon("jackpot_stop");

  if(level.mugger_jackpot_limit <= 0) {
    return;
  }
  level.mugger_jackpot_num_tags = 0;
  level.mugger_jackpot_tags_unspawned = 0;
  level.mugger_jackpot_num_tags = 0;

  level thread mugger_jackpot_timer();

  while(1) {
    level waittill("mugger_jackpot_increment");
    do_increment = true;
    if(do_increment) {
      level.mugger_jackpot_num_tags++;
      bar_frac = clamp(float(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit), 0.0, 1.0);
      if(level.mugger_jackpot_num_tags >= level.mugger_jackpot_limit) {
        if(isDefined(level.mugger_jackpot_text))
          level.mugger_jackpot_text thread maps\mp\gametypes\_hud::fontPulse(level.players[0]);

        level.mugger_jackpot_num_tags = 15 + RandomIntRange(0, 3) * 5;
        level thread mugger_jackpot_drop();
        break;
      }
    }
  }
}

mugger_jackpot_timer() {
  level endon("game_ended");
  level endon("jackpot_stop");

  gameFlagWait("prematch_done");

  while(1) {
    wait(level.mugger_jackpot_wait_sec);
    level notify("mugger_jackpot_increment");
  }
}

mugger_jackpot_drop() {
  level endon("game_ended");
  level notify("reset_airdrop");
  level endon("reset_airdrop");

  position = level.mugger_dropZones[level.script][RandomInt(level.mugger_dropZones[level.script].size)];
  position = position + (randomIntRange((-1 * MUGGER_ZONE_DROP_RADIUS), MUGGER_ZONE_DROP_RADIUS), randomIntRange((-1 * MUGGER_ZONE_DROP_RADIUS), MUGGER_ZONE_DROP_RADIUS), 0);

  while(true) {
    owner = level.players[0];
    numIncomingVehicles = 1;
    if(isDefined(owner) &&
      currentActiveVehicleCount() < maxVehiclesAllowed() &&
      level.fauxVehicleCount + numIncomingVehicles < maxVehiclesAllowed() &&
      level.numDropCrates < 8) {
      foreach(player in level.players) {
        player thread maps\mp\gametypes\_hud_message::SplashNotify("mugger_jackpot_incoming");
      }

      incrementFauxVehicleCount();
      level thread maps\mp\killstreaks\_airdrop::doFlyBy(owner, position, randomFloat(360), "airdrop_mugger", 0, "airdrop_jackpot");
      break;
    } else {
      wait(0.5);
      continue;
    }
  }

  level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
  level thread mugger_jackpot_run(position);
}

mugger_jackpot_pile_notify(pos, event, num_tags) {
  if(!isDefined(level.jackpotPileObjId)) {
    level.jackpotPileObjId = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(level.jackpotPileObjId, "active", pos);
    objective_icon(level.jackpotPileObjId, "waypoint_jackpot");
  } else {
    Objective_Position(level.jackpotPileObjId, pos);
  }

  if(num_tags >= 10) {
    foreach(player in level.players) {
      player playLocalSound(game["music"]["victory_" + player.pers["team"]]);
    }

    if(!isDefined(level.jackpotPileIcon)) {
      level.jackpotPileIcon = newHudElem();
      level.jackpotPileIcon setShader("waypoint_jackpot", 64, 64);
      level.jackpotPileIcon SetWayPoint(false, true, false, false);
    }
    level.jackpotPileIcon.x = pos[0];
    level.jackpotPileIcon.y = pos[1];
    level.jackpotPileIcon.z = pos[2] + 12;
    level.jackpotPileIcon.alpha = 0.75;
  }
}

mugger_jackpot_pile_notify_cleanup() {
  Objective_State(level.jackpotPileObjId, "invisible");
  level.jackpotPileIcon FadeOverTime(2);
  level.jackpotPileIcon.alpha = 0;
  level.jackpotPileIcon delayThread(2, ::hudElemDestroy);
}

mugger_jackpot_fx(jackpot_origin) {
  mugger_jackpot_fx_cleanup();

  traceStart = jackpot_origin + (0, 0, 30);
  traceEnd = jackpot_origin + (0, 0, -1000);
  trace = bulletTrace(traceStart, traceEnd, false, undefined);
  level.jackpot_zone.origin = trace["position"] + (0, 0, 1);
  level.jackpot_zone show();

  upangles = vectorToAngles(trace["normal"]);
  forward = anglesToForward(upangles);
  right = anglesToRight(upangles);
  thread spawnFxDelay(trace["position"], forward, right, 0.5);

  wait(0.1);
  playFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
  foreach(player in level.players)
  player.mugger_fx_playing = true;
  level.jackpot_zone.mugger_fx_playing = true;
}

mugger_jackpot_fx_cleanup() {
  stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
  level.jackpot_zone hide();
  if(isDefined(level.jackpot_targetFX))
    level.jackpot_targetFX delete();
  if(level.jackpot_zone.mugger_fx_playing) {
    level.jackpot_zone.mugger_fx_playing = false;
    stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
    wait(0.05);
  }
}

spawnFxDelay(pos, forward, right, delay) {
  if(isDefined(level.jackpot_targetFX))
    level.jackpot_targetFX delete();
  wait delay;
  level.jackpot_targetFX = spawnFx(level.mugger_targetFXID, pos, forward, right);
  triggerFx(level.jackpot_targetFX);
}

waitReplaySmokeFxForNewPlayer() {
  level endon("game_ended");
  selfendon("disconnect");

  gameFlagWait("prematch_done");

  wait(0.5);

  if(level.jackpot_zone.mugger_fx_playing == true && !isDefined(self.mugger_fx_playing)) {
    PlayFxOnTagForClients(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx", self);
    self.mugger_fx_playing = true;
  }
}

mugger_jackpot_run(jackpot_origin) {
  level endon("game_ended");
  level endon("jackpot_timeout");

  level notify("jackpot_stop");

  mugger_jackpot_pile_notify(jackpot_origin, "mugger_jackpot", level.mugger_jackpot_tags_unspawned);

  level thread mugger_jackpot_fx(jackpot_origin);

  level thread mugger_jackpot_abort_after_time(30);

  level waittill("airdrop_jackpot_landed", jackpot_origin);
  Objective_Position(level.jackpotPileObjId, jackpot_origin);
  level.jackpotPileIcon.x = jackpot_origin[0];
  level.jackpotPileIcon.y = jackpot_origin[1];
  level.jackpotPileIcon.z = jackpot_origin[2] + 32;

  foreach(player in level.players) {
    player PlaySoundToPlayer("mp_defcon_one", player);
    player thread maps\mp\gametypes\_hud_message::SplashNotify("mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  }

  level.mugger_jackpot_tags_spawned = 0;
  while(level.mugger_jackpot_tags_unspawned > 0) {
    if(level.mugger_jackpot_tags_spawned < 10) {
      level.mugger_jackpot_tags_unspawned--;
      spawned_tag = mugger_tag_temp_spawn(jackpot_origin, 0, 400);
      spawned_tag.jackpot_tag = true;
      level.mugger_jackpot_tags_spawned++;

      level thread mugger_jackpot_abort_after_time(90);
      wait(0.1);
    } else {
      wait(0.5);
    }
  }

  level.mugger_jackpot_num_tags = 0;

  while(level.mugger_jackpot_tags_spawned > 0) {
    wait(1);
  }

  mugger_jackpot_cleanup();
}

mugger_jackpot_cleanup() {
  level notify("jackpot_cleanup");
  mugger_jackpot_pile_notify_cleanup();
  mugger_jackpot_fx_cleanup();

  level thread mugger_jackpot_watch();
}

mugger_jackpot_abort_after_time(time) {
  level endon("jackpot_cleanup");

  level notify("jackpot_abort_after_time");
  level endon("jackpot_abort_after_time");

  wait(time);

  level notify("jackpot_timeout");
}

createMuggerCrates(friendly_crate_model, enemy_crate_model) {
  addCrateType("airdrop_mugger", "airdrop_jackpot", 1, ::muggerCrateThink);
}

muggerCrateThink(dropType) {
  self endon("death");

  level notify("airdrop_jackpot_landed", self.origin);

  wait(0.5);
  self deleteCrate();
}

createDropZones() {
  level.mugger_dropZones = [];

  dropZones = getstructarray("horde_drop", "targetname");
  if(isDefined(dropZones) && dropZones.size) {
    i = 0;
    foreach(dropZone in dropZones) {
      level.mugger_dropZones[level.script][i] = dropZone.origin;
      i++;
    }
  } else {
    level.mugger_dropZones["mp_seatown"][0] = (-665, -209, 226);
    level.mugger_dropZones["mp_seatown"][1] = (-2225, 1573, 260);
    level.mugger_dropZones["mp_seatown"][2] = (1275, -747, 292);
    level.mugger_dropZones["mp_seatown"][3] = (1210, 963, 225);
    level.mugger_dropZones["mp_seatown"][4] = (-2343, -811, 226);
    level.mugger_dropZones["mp_seatown"][5] = (-1125, -1610, 184);

    level.mugger_dropZones["mp_dome"][0] = (649, 1096, -250);
    level.mugger_dropZones["mp_dome"][1] = (953, -501, -328);
    level.mugger_dropZones["mp_dome"][2] = (-37, 2099, -231);
    level.mugger_dropZones["mp_dome"][3] = (-716, 1100, -296);
    level.mugger_dropZones["mp_dome"][4] = (-683, -51, -352);

    level.mugger_dropZones["mp_plaza2"][0] = (266, -212, 708);
    level.mugger_dropZones["mp_plaza2"][1] = (295, 1842, 668);
    level.mugger_dropZones["mp_plaza2"][2] = (-1449, 1833, 692);
    level.mugger_dropZones["mp_plaza2"][3] = (835, -1815, 668);
    level.mugger_dropZones["mp_plaza2"][4] = (-1116, 76, 729);
    level.mugger_dropZones["mp_plaza2"][5] = (-399, 951, 676);

    level.mugger_dropZones["mp_mogadishu"][0] = (552, 1315, 8);
    level.mugger_dropZones["mp_mogadishu"][1] = (990, 3248, 144);
    level.mugger_dropZones["mp_mogadishu"][2] = (-879, 2643, 135);
    level.mugger_dropZones["mp_mogadishu"][3] = (-68, -995, 16);
    level.mugger_dropZones["mp_mogadishu"][4] = (1499, -1206, 15);
    level.mugger_dropZones["mp_mogadishu"][5] = (2387, 1786, 61);

    level.mugger_dropZones["mp_paris"][0] = (-150, -80, 63);
    level.mugger_dropZones["mp_paris"][1] = (-947, -1088, 107);
    level.mugger_dropZones["mp_paris"][2] = (1052, -614, 50);
    level.mugger_dropZones["mp_paris"][3] = (1886, 648, 24);
    level.mugger_dropZones["mp_paris"][4] = (628, 2096, 30);
    level.mugger_dropZones["mp_paris"][5] = (-2033, 1082, 308);
    level.mugger_dropZones["mp_paris"][6] = (-1230, 1836, 295);

    level.mugger_dropZones["mp_exchange"][0] = (904, 441, -77);
    level.mugger_dropZones["mp_exchange"][1] = (-1056, 1435, 141);
    level.mugger_dropZones["mp_exchange"][2] = (800, 1543, 148);
    level.mugger_dropZones["mp_exchange"][3] = (2423, 1368, 141);
    level.mugger_dropZones["mp_exchange"][4] = (596, -1870, 89);
    level.mugger_dropZones["mp_exchange"][5] = (-1241, -821, 30);

    level.mugger_dropZones["mp_bootleg"][0] = (-444, -114, -8);
    level.mugger_dropZones["mp_bootleg"][1] = (1053, -1051, -13);
    level.mugger_dropZones["mp_bootleg"][2] = (889, 1184, -28);
    level.mugger_dropZones["mp_bootleg"][3] = (-994, 1877, -41);
    level.mugger_dropZones["mp_bootleg"][4] = (-1707, -1333, 63);
    level.mugger_dropZones["mp_bootleg"][5] = (-334, -2155, 61);

    level.mugger_dropZones["mp_carbon"][0] = (-1791, -3892, 3813);
    level.mugger_dropZones["mp_carbon"][1] = (-338, -4978, 3964);
    level.mugger_dropZones["mp_carbon"][2] = (-82, -2941, 3990);
    level.mugger_dropZones["mp_carbon"][3] = (-3198, -2829, 3809);
    level.mugger_dropZones["mp_carbon"][4] = (-3673, -3893, 3610);
    level.mugger_dropZones["mp_carbon"][5] = (-2986, -4863, 3648);

    level.mugger_dropZones["mp_hardhat"][0] = (1187, -322, 238);
    level.mugger_dropZones["mp_hardhat"][1] = (2010, -1379, 357);
    level.mugger_dropZones["mp_hardhat"][2] = (1615, 1245, 366);
    level.mugger_dropZones["mp_hardhat"][3] = (-371, 825, 436);
    level.mugger_dropZones["mp_hardhat"][4] = (-820, -927, 348);

    level.mugger_dropZones["mp_alpha"][0] = (-239, 1315, 52);
    level.mugger_dropZones["mp_alpha"][1] = (-1678, -219, 55);
    level.mugger_dropZones["mp_alpha"][2] = (235, -369, 60);
    level.mugger_dropZones["mp_alpha"][3] = (-201, 2138, 60);
    level.mugger_dropZones["mp_alpha"][4] = (-1903, 2433, 198);

    level.mugger_dropZones["mp_village"][0] = (990, -821, 331);
    level.mugger_dropZones["mp_village"][1] = (658, 2155, 337);
    level.mugger_dropZones["mp_village"][2] = (-559, 1882, 310);
    level.mugger_dropZones["mp_village"][3] = (-1999, 1184, 343);
    level.mugger_dropZones["mp_village"][4] = (215, -2875, 384);
    level.mugger_dropZones["mp_village"][5] = (1731, -483, 290);

    level.mugger_dropZones["mp_lambeth"][0] = (712, 217, -196);
    level.mugger_dropZones["mp_lambeth"][1] = (1719, -1095, -196);
    level.mugger_dropZones["mp_lambeth"][2] = (2843, 1034, -269);
    level.mugger_dropZones["mp_lambeth"][3] = (1251, 2645, -213);
    level.mugger_dropZones["mp_lambeth"][4] = (-1114, 1301, -200);
    level.mugger_dropZones["mp_lambeth"][5] = (-693, -823, -132);

    level.mugger_dropZones["mp_radar"][0] = (-5052, 2371, 1223);
    level.mugger_dropZones["mp_radar"][1] = (-4550, 4199, 1268);
    level.mugger_dropZones["mp_radar"][2] = (-7149, 4449, 1376);
    level.mugger_dropZones["mp_radar"][3] = (-6350, 1528, 1302);
    level.mugger_dropZones["mp_radar"][4] = (-3333, 992, 1222);
    level.mugger_dropZones["mp_radar"][5] = (-4040, -361, 1222);

    level.mugger_dropZones["mp_interchange"][0] = (662, -513, 142);
    level.mugger_dropZones["mp_interchange"][1] = (674, 1724, 112);
    level.mugger_dropZones["mp_interchange"][2] = (-1003, 1103, 30);
    level.mugger_dropZones["mp_interchange"][3] = (385, -2910, 209);
    level.mugger_dropZones["mp_interchange"][4] = (2004, -1760, 144);
    level.mugger_dropZones["mp_interchange"][5] = (2458, -300, 147);

    level.mugger_dropZones["mp_underground"][0] = (31, 1319, -196);
    level.mugger_dropZones["mp_underground"][1] = (165, -940, 60);
    level.mugger_dropZones["mp_underground"][2] = (-747, 143, 4);
    level.mugger_dropZones["mp_underground"][3] = (-1671, 1666, -216);
    level.mugger_dropZones["mp_underground"][4] = (-631, 3158, -68);
    level.mugger_dropZones["mp_underground"][5] = (500, 2865, -89);

    level.mugger_dropZones["mp_bravo"][0] = (-39, -119, 1280);
    level.mugger_dropZones["mp_bravo"][1] = (1861, -563, 1229);
    level.mugger_dropZones["mp_bravo"][2] = (-1548, -366, 1007);
    level.mugger_dropZones["mp_bravo"][3] = (-678, 1272, 1273);
    level.mugger_dropZones["mp_bravo"][4] = (1438, 842, 1272);
  }
}