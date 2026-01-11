/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_fireteam.gsc
*******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\bots\_bots;
#include maps\mp\bots\_bots_ks;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;

bot_fireteam_init() {
  level.bots_fireteam_num_classes_loaded = [];

  level thread bot_fireteam_connect_monitor();
}

bot_fireteam_connect_monitor() {
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");

  level.bots_fireteam_humans = [];
  while(1) {
    foreach(player in level.players) {
      if(!IsBot(player) && !isDefined(player.processed_for_fireteam)) {
        if(isDefined(player.team) && (player.team == "allies" || player.team == "axis")) {
          player.processed_for_fireteam = true;

          level.bots_fireteam_humans[player.team] = player;
          level.bots_fireteam_num_classes_loaded[player.team] = 0;

          team_limit = bot_get_team_limit();

          if(level.bots_fireteam_humans.size == 2) {
            drop_bots(team_limit - 1, player.team);
          }

          spawn_bots(team_limit - 1, player.team, ::bot_fireteam_spawn_callback);

          if(level.bots_fireteam_humans.size == 1) {
            num_human_players = 0;
            foreach(client in level.players) {
              if(isDefined(client) && !IsBot(client)) {
                num_human_players++;
              }
            }
            if(num_human_players == 1) {
              spawn_bots(team_limit - 1, get_enemy_team(player.team));
            }
          }
        }
      }
    }

    wait(0.25);
  }
}

bot_fireteam_spawn_callback() {
  self.override_class_function = ::bot_fireteam_setup_callback_class;

  self.fireteam_commander = level.bots_fireteam_humans[self.bot_team];

  self thread bot_fireteam_monitor_killstreak_earned();
}

bot_fireteam_setup_callback_class() {
  self.classCallback = ::bot_fireteam_loadout_class_callback;
  return "callback";
}

bot_fireteam_loadout_class_callback() {
  if(isDefined(self.botLastLoadout)) {
    return self.botLastLoadout;
  }

  self.class_num = level.bots_fireteam_num_classes_loaded[self.team];
  level.bots_fireteam_num_classes_loaded[self.team] += 1;

  if(self.class_num == 5) {
    self.class_num = 0;
  }

  loadoutValueArray["loadoutPrimary"] = self.fireteam_commander bot_fireteam_cac_getWeapon(self.class_num, 0);
  loadoutValueArray["loadoutPrimaryAttachment"] = self.fireteam_commander bot_fireteam_cac_getWeaponAttachment(self.class_num, 0);
  loadoutValueArray["loadoutPrimaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getWeaponAttachmentTwo(self.class_num, 0);
  loadoutValueArray["loadoutPrimaryBuff"] = self.fireteam_commander bot_fireteam_cac_getWeaponBuff(self.class_num, 0);
  loadoutValueArray["loadoutPrimaryCamo"] = self.fireteam_commander bot_fireteam_cac_getWeaponCamo(self.class_num, 0);
  loadoutValueArray["loadoutPrimaryReticle"] = self.fireteam_commander bot_fireteam_cac_getWeaponReticle(self.class_num, 0);
  loadoutValueArray["loadoutSecondary"] = self.fireteam_commander bot_fireteam_cac_getWeapon(self.class_num, 1);
  loadoutValueArray["loadoutSecondaryAttachment"] = self.fireteam_commander bot_fireteam_cac_getWeaponAttachment(self.class_num, 1);
  loadoutValueArray["loadoutSecondaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getWeaponAttachmentTwo(self.class_num, 1);
  loadoutValueArray["loadoutSecondaryBuff"] = self.fireteam_commander bot_fireteam_cac_getWeaponBuff(self.class_num, 1);
  loadoutValueArray["loadoutSecondaryCamo"] = self.fireteam_commander bot_fireteam_cac_getWeaponCamo(self.class_num, 1);
  loadoutValueArray["loadoutSecondaryReticle"] = self.fireteam_commander bot_fireteam_cac_getWeaponReticle(self.class_num, 1);
  loadoutValueArray["loadoutEquipment"] = self.fireteam_commander bot_fireteam_cac_getPrimaryGrenade(self.class_num);
  loadoutValueArray["loadoutOffhand"] = self.fireteam_commander bot_fireteam_cac_getSecondaryGrenade(self.class_num);
  loadoutValueArray["loadoutPerk1"] = self.fireteam_commander bot_fireteam_cac_getPerk(self.class_num, 2);
  loadoutValueArray["loadoutPerk2"] = self.fireteam_commander bot_fireteam_cac_getPerk(self.class_num, 3);
  loadoutValueArray["loadoutPerk3"] = self.fireteam_commander bot_fireteam_cac_getPerk(self.class_num, 4);
  loadoutValueArray["loadoutStreakType"] = self.fireteam_commander bot_fireteam_cac_getPerk(self.class_num, 5);
  if(loadoutValueArray["loadoutStreakType"] != "specialty_null") {
    playerData = GetSubStr(loadoutValueArray["loadoutStreakType"], 11) + "Streaks";

    loadoutValueArray["loadoutStreak1"] = self.fireteam_commander bot_fireteam_cac_getStreak(self.class_num, playerData, 0);
    if(loadoutValueArray["loadoutStreak1"] == "none") {
      loadoutValueArray["loadoutStreak1"] = undefined;
    }

    loadoutValueArray["loadoutStreak2"] = self.fireteam_commander bot_fireteam_cac_getStreak(self.class_num, playerData, 1);
    if(loadoutValueArray["loadoutStreak2"] == "none") {
      loadoutValueArray["loadoutStreak2"] = undefined;
    }

    loadoutValueArray["loadoutStreak3"] = self.fireteam_commander bot_fireteam_cac_getStreak(self.class_num, playerData, 2);
    if(loadoutValueArray["loadoutStreak3"] == "none") {
      loadoutValueArray["loadoutStreak3"] = undefined;
    }

    bot_fireteam_test_killstreaks(loadoutValueArray, self);

  }

  self.botLastLoadout = loadoutValueArray;

  return loadoutValueArray;
}

bot_fireteam_test_killstreaks(loadoutValueArray, bot) {
  if(isDefined(loadoutValueArray["loadoutStreak1"])) {
    bot_killstreak_valid_for_specific_streakType(loadoutValueArray["loadoutStreak1"], loadoutValueArray["loadoutStreakType"], true);
  }
  if(isDefined(loadoutValueArray["loadoutStreak2"])) {
    bot_killstreak_valid_for_specific_streakType(loadoutValueArray["loadoutStreak2"], loadoutValueArray["loadoutStreakType"], true);
  }
  if(isDefined(loadoutValueArray["loadoutStreak3"])) {
    bot_killstreak_valid_for_specific_streakType(loadoutValueArray["loadoutStreak3"], loadoutValueArray["loadoutStreakType"], true);
  }
}

bot_fireteam_cac_getWeapon(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "weapon");
}

bot_fireteam_cac_getWeaponAttachment(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "attachment", 0);
}

bot_fireteam_cac_getWeaponAttachmentTwo(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "attachment", 1);
}

bot_fireteam_cac_getWeaponBuff(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "buff");
}

bot_fireteam_cac_getWeaponCamo(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "camo");
}

bot_fireteam_cac_getWeaponReticle(classIndex, weaponIndex) {
  return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "reticle");
}

bot_fireteam_cac_getPrimaryGrenade(classIndex) {
  return self getCaCPlayerData(classIndex, "perks", 0);
}

bot_fireteam_cac_getSecondaryGrenade(classIndex) {
  return self getCaCPlayerData(classIndex, "perks", 1);
}

bot_fireteam_cac_getPerk(classIndex, perkIndex) {
  return self getCaCPlayerData(classIndex, "perks", perkIndex);
}

bot_fireteam_cac_getStreak(classIndex, playerData, streakIndex) {
  return self getCaCPlayerData(classIndex, playerData, streakIndex);
}

bot_fireteam_buddy_think() {
  buddy_range = 250;
  buddy_range_sq = (buddy_range * buddy_range);
  if(!self bot_is_guarding_player(self.owner)) {
    self bot_guard_player(self.owner, buddy_range);
  }

  if(DistanceSquared(self.origin, self.owner.origin) > buddy_range_sq) {
    self BotSetFlag("force_sprint", true);
  } else if(self.owner IsSprinting()) {
    self BotSetFlag("force_sprint", true);
  } else {
    self BotSetFlag("force_sprint", false);
  }
}

bot_fireteam_buddy_search() {
  self endon("buddy_cancel");
  self endon("disconnect");

  self notify("buddy_search_start");
  self endon("buddy_search_start");

  while(1) {
    if(IsAlive(self) && !isDefined(self.bot_fireteam_follower)) {
      if(isDefined(self.owner)) {
        if(self.sessionstate == "playing") {
          if(!self.owner.connected) {
            self.owner.bot_fireteam_follower = undefined;
            self.owner = undefined;
          } else if(isDefined(level.fireteam_commander[self.team])) {
            if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self) {
              self.owner.bot_fireteam_follower = undefined;

              self.owner.owner = level.fireteam_commander[self.team];
              self.owner.personality_update_function = ::bot_fireteam_buddy_think;

              self.owner = undefined;
            } else if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self.owner) {
              self.owner.bot_fireteam_follower = undefined;
              self.owner = level.fireteam_commander[self.team];
              self.owner.bot_fireteam_follower = self;
            } else if(self.owner == level.fireteam_commander[self.team] && !isDefined(self.owner.commanding_bot)) {
              self.owner.bot_fireteam_follower = undefined;
              if(isDefined(self.owner.last_commanded_bot)) {
                self.owner = self.owner.last_commanded_bot;
                self.owner.bot_fireteam_follower = self;
              } else {
                self.owner = undefined;
              }
            }
          }
        } else {
          if(isDefined(level.fireteam_commander[self.team])) {
            if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self) {
              self.owner.bot_fireteam_follower = undefined;

              self.owner.owner = level.fireteam_commander[self.team];
              self.owner.personality_update_function = ::bot_fireteam_buddy_think;

              self.owner = undefined;
            }
          }
        }
      }

      if(self.sessionstate == "playing") {
        if(!isDefined(self.owner)) {
          myAvailableTeam = [];
          foreach(player in level.players) {
            if(player != self && player.team == self.team) {
              if(IsAlive(player) && player.sessionstate == "playing" && !isDefined(player.bot_fireteam_follower) && !isDefined(player.owner)) {
                myAvailableTeam[myAvailableTeam.size] = player;
              }
            }
          }

          if(myAvailableTeam.size > 0) {
            closestBot = getClosest(self.origin, myAvailableTeam);
            if(isDefined(closestBot)) {
              self.owner = closestBot;
              self.owner.bot_fireteam_follower = self;
            }
          }
        }
      }

      if(isDefined(self.owner)) {
        self.personality_update_function = ::bot_fireteam_buddy_think;
      } else {
        self bot_assign_personality_functions();
      }
    }
    wait(0.5);
  }
}

fireteam_tdm_set_hunt_leader(whichTeam) {
  botsOnTeam = [];
  foreach(player in level.players) {
    if(player.team == whichTeam) {
      if(player.connected && IsAlive(player) && player.sessionstate == "playing") {
        if(!IsBot(player)) {
          level.fireteam_hunt_leader[whichTeam] = player;
          return true;
        } else {
          botsOnTeam[botsOnTeam.size] = player;
        }
      }
    }
  }

  if(!isDefined(level.fireteam_hunt_leader[whichTeam])) {
    if(botsOnTeam.size > 0) {
      if(botsOnTeam.size == 1) {
        level.fireteam_hunt_leader[whichTeam] = botsOnTeam[0];
      } else {
        level.fireteam_hunt_leader[whichTeam] = botsOnTeam[RandomInt(botsOnTeam.size)];
      }
      return true;
    }
  }
  return false;
}

fireteam_tdm_hunt_end(whichTeam) {
  level notify("hunting_party_end_" + whichTeam);
  level.fireteam_hunt_leader[whichTeam] = undefined;
  level.fireteam_hunt_target_zone[whichTeam] = undefined;
  level.bot_random_path_function[whichTeam] = ::bot_random_path_default;
}

fireteam_tdm_hunt_most_dangerous_zone(leaderZone, whichTeam) {
  bestZoneEnemyCount = 0;
  bestZone = undefined;
  bestZonePathSize = -1;

  if(level.zoneCount > 0) {
    for(testZone = 0; testZone < level.zoneCount; testZone++) {
      zoneEnemyCount = BotZoneGetCount(testZone, whichTeam, "enemy_predict");
      if(zoneEnemyCount < bestZoneEnemyCount) {
        continue;
      }
      zonePath = undefined;
      if(zoneEnemyCount == bestZoneEnemyCount) {
        zonePath = GetZonePath(leaderZone, testZone);
        if(!isDefined(zonePath)) {
          continue;
        }
        if(bestZonePathSize >= 0 && zonePath.size > bestZonePathSize) {
          continue;
        }
      }
      bestZoneEnemyCount = zoneEnemyCount;
      bestZone = testZone;
      if(isDefined(zonePath)) {
        bestZonePathSize = zonePath.size;
      } else {
        bestZonePathSize = -1;
      }
    }
  }
  return bestZone;
}

fireteam_tdm_find_hunt_zone(whichTeam) {
  level endon("hunting_party_end_" + whichTeam);
  self endon("disconnect");
  level endon("game_ended");

  if(level.zoneCount <= 0) {
    return;
  }
  level.bot_random_path_function[whichTeam] = ::bot_fireteam_hunt_zone_find_node;

  while(1) {
    wait_time = 3;
    if(!isDefined(level.fireteam_hunt_leader[whichTeam]) || IsBot(level.fireteam_hunt_leader[whichTeam]) || isDefined(level.fireteam_hunt_leader[whichTeam].commanding_bot)) {
      fireteam_tdm_set_hunt_leader(whichTeam);
    }

    if(isDefined(level.fireteam_hunt_leader[whichTeam])) {
      leaderZone = GetZoneNearest(level.fireteam_hunt_leader[whichTeam].origin);
      if(!isDefined(leaderZone)) {
        wait(wait_time);
        continue;
      }

      if(!IsBot(level.fireteam_hunt_leader[whichTeam])) {
        if(IsAlive(level.fireteam_hunt_leader[whichTeam]) && level.fireteam_hunt_leader[whichTeam].sessionstate == "playing" && (!isDefined(level.fireteam_hunt_leader[whichTeam].deathTime) || level.fireteam_hunt_leader[whichTeam].deathTime + 5000 < GetTime())) {
          level.fireteam_hunt_target_zone[whichTeam] = leaderZone;
          level.fireteam_hunt_next_zone_search_time[whichTeam] = GetTime() + 1000;
          wait_time = 0.5;
        } else {
          wait_time = 1;
        }
      } else {
        first_search = false;
        changeZones = false;
        curZone = undefined;
        if(isDefined(level.fireteam_hunt_target_zone[whichTeam])) {
          curZone = level.fireteam_hunt_target_zone[whichTeam];
        }
        else {
          first_search = true;
          changeZones = true;
          curZone = leaderZone;
        }
        newZone = undefined;

        if(isDefined(curZone)) {
          newZone = fireteam_tdm_hunt_most_dangerous_zone(leaderZone, whichTeam);

          if(!first_search) {
            if(!isDefined(newZone) || newZone != curZone) {
              if(curZone == leaderZone) {
                changeZones = true;
              } else if(GetTime() > level.fireteam_hunt_next_zone_search_time[whichTeam]) {
                changeZones = true;
              }
            }
          }

          if(changeZones) {
            if(!isDefined(newZone)) {
              furthestDist = 0;
              furthestZone = -1;
              for(z = 0; z < level.zoneCount; z++) {
                dist = Distance2D(GetZoneOrigin(z), level.fireteam_hunt_leader[whichTeam].origin);
                if(dist > furthestDist) {
                  furthestDist = dist;
                  furthestZone = z;
                }
              }
              newZone = furthestZone;
            }

            if(isDefined(newZone)) {
              if(!isDefined(level.fireteam_hunt_target_zone[whichTeam]) || level.fireteam_hunt_target_zone[whichTeam] != newZone) {
                foreach(player in level.players) {
                  if(IsBot(player) && player.team == whichTeam) {
                    player BotClearScriptGoal();
                    player.fireteam_hunt_goalpos = undefined;
                    player thread bot_fireteam_hunt_zone_find_node();
                  }
                }
              }
              level.fireteam_hunt_target_zone[whichTeam] = newZone;
              level.fireteam_hunt_next_zone_search_time[whichTeam] = GetTime() + 12000;
            }
          }
        }
      }
    }

    wait(wait_time);
  }
}

bot_debug_script_goal() {
  self notify("bot_debug_script_goal");

  level endon("hunting_party_end_" + self.team);
  self endon("bot_debug_script_goal");

  lineHeight = 48;
  while(1) {
    if(self BotHasScriptGoal()) {
      goalPos = self BotGetScriptGoal();
      if(!isDefined(self.fireteam_hunt_goalpos)) {
        Line(self.origin + (0, 0, lineHeight), goalPos + (0, 0, lineHeight), (0, 1, 1), 1.0, false, 1);
      } else if(self.fireteam_hunt_goalpos != goalPos) {
        Line(self.origin + (0, 0, lineHeight), goalPos + (0, 0, lineHeight), (1, 1, 1), 1.0, false, 1);
        Line(self.origin + (0, 0, lineHeight), self.fireteam_hunt_goalpos + (0, 0, lineHeight), (1, 1, 0), 1.0, false, 1);
      } else {
        Line(self.origin + (0, 0, lineHeight), self.fireteam_hunt_goalpos + (0, 0, lineHeight), (0, 1, 0), 1.0, false, 1);
      }
    } else if(isDefined(self.fireteam_hunt_goalpos)) {
      Line(self.origin + (0, 0, lineHeight), self.fireteam_hunt_goalpos + (0, 0, lineHeight), (1, 0, 0), 1.0, false, 1);
    }

    wait(0.05);
  }
}

bot_fireteam_hunt_zone_find_node() {
  result = false;
  node_to_guard = undefined;

  if(isDefined(level.fireteam_hunt_target_zone[self.team])) {
    nodes_to_select_from = GetZoneNodes(level.fireteam_hunt_target_zone[self.team], 0);

    if(nodes_to_select_from.size <= 18) {
      nodes_to_select_from = GetZoneNodes(level.fireteam_hunt_target_zone[self.team], 1);
      if(nodes_to_select_from.size <= 18) {
        nodes_to_select_from = GetZoneNodes(level.fireteam_hunt_target_zone[self.team], 2);
        if(nodes_to_select_from.size <= 18) {
          nodes_to_select_from = GetZoneNodes(level.fireteam_hunt_target_zone[self.team], 3);
        }
      }
    }
    if(nodes_to_select_from.size <= 0) {
      return bot_random_path_default();
    }

    node_to_guard = self BotNodePick(nodes_to_select_from, nodes_to_select_from.size, "node_hide");

    tries = 0;
    while(!isDefined(node_to_guard) || !self BotNodeAvailable(node_to_guard)) {
      tries++;
      if(tries >= 10) {
        return bot_random_path_default();
      }

      node_to_guard = nodes_to_select_from[RandomInt(nodes_to_select_from.size)];
    }

    goalPos = node_to_guard.origin;
    if(isDefined(goalPos)) {
      node_type = "guard";

      myZone = GetZoneNearest(self.origin);
      if(isDefined(myZone) && myZone == level.fireteam_hunt_target_zone[self.team]) {
        self BotSetFlag("force_sprint", false);
      } else {
        self BotSetFlag("force_sprint", true);
      }

      result = self BotSetScriptGoal(goalPos, 128, node_type);
      self.fireteam_hunt_goalpos = goalPos;

    }
  }

  if(!result) {
    return bot_random_path_default();
  }

  return result;
}

bot_fireteam_monitor_killstreak_earned() {
  level endon("game_ended");
  self endon("disconnect");

  self notify("bot_fireteam_monitor_killstreak_earned");
  self endon("bot_fireteam_monitor_killstreak_earned");

  while(1) {
    self waittill("bot_killstreak_earned", splashString, streakVal);

    if(bot_is_fireteam_mode()) {
      if(isDefined(self) && IsBot(self)) {
        if(isDefined(self.fireteam_commander)) {
          commandersBot = undefined;
          if(isDefined(self.fireteam_commander.commanding_bot)) {
            commandersBot = self.fireteam_commander.commanding_bot;
          } else {
            commandersBot = self.fireteam_commander GetSpectatingPlayer();
          }

          if(!isDefined(commandersBot) || commandersBot != self) {
            self.fireteam_commander thread maps\mp\gametypes\_hud_message::playerCardSplashNotify(splashString, self, streakVal);
          }
        }
      }
    }
  }
}