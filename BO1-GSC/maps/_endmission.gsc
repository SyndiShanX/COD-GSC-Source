/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_endmission.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_laststand;

main() {
  missionSettings = [];
  missionIndex = 0;
  missionSettings = create_mission();
  missionSettings add_level("cuba", false, "", true, "SP_VWIN_FLASHPOINT", "SP_WIN_CUBA", false);
  missionSettings add_level("so_narrative1_frontend", false, "", true, undefined, undefined, false);
  missionSettings add_level("vorkuta", false, "", true, "SP_VWIN_FLASHPOINT", "SP_WIN_VORKUTA", false);
  missionSettings add_level("pentagon", false, "", true, undefined, "SP_WIN_PENTAGON", false);
  missionSettings add_level("flashpoint", false, "", true, "SP_VWIN_FLASHPOINT", "SP_WIN_FLASHPOINT", false);
  missionSettings add_level("so_narrative2_frontend", false, "", true, undefined, undefined, false);
  missionSettings add_level("khe_sanh", false, "", true, "SP_VWIN_HUE_CITY", "SP_WIN_KHE_SANH", false);
  missionSettings add_level("hue_city", false, "", true, "SP_VWIN_HUE_CITY", "SP_WIN_HUE_CITY", false);
  missionSettings add_level("kowloon", false, "", true, "SP_VWIN_FULLAHEAD", "SP_WIN_KOWLOON", false);
  missionSettings add_level("so_narrative3_frontend", false, "", true, undefined, undefined, false);
  missionSettings add_level("fullahead", false, "", true, "SP_VWIN_FULLAHEAD", "SP_WIN_FULLAHEAD", false);
  missionSettings add_level("creek_1", false, "", true, "SP_VWIN_FULLAHEAD", undefined, false);
  missionSettings add_level("so_narrative4_frontend", false, "", true, undefined, undefined, false);
  missionSettings add_level("river", false, "", true, "SP_VWIN_RIVER", "SP_WIN_RIVER", false);
  missionSettings add_level("wmd_sr71", false, "", true, "SP_VWIN_RIVER", undefined, false);
  missionSettings add_level("wmd", false, "", true, "SP_VWIN_RIVER", undefined, false);
  missionSettings add_level("pow", false, "", true, "SP_VWIN_RIVER", undefined, false);
  missionSettings add_level("so_narrative5_frontend", false, "", true, undefined, undefined, false);
  missionSettings add_level("rebirth", false, "", true, "SP_VWIN_UNDERWATERBASE", undefined, false);
  missionSettings add_level("int_escape", false, "", true, undefined, "SP_WIN_INTERROGATION_ESCAPE", false);
  missionSettings add_level("underwaterbase", false, "", true, "SP_VWIN_UNDERWATERBASE", undefined, false);
  missionSettings add_level("outro", false, "", true, undefined, undefined, false);
  level.missionSettings = missionSettings;
}

_nextmission() {
  level.nextmission = true;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] player_is_in_laststand()) {
      players[i] notify("player_revived");
      setClientSysState("lsm", "0", players[i]);
    }
    players[i] EnableInvulnerability();
  }
  level_index = level.missionSettings get_level_index(level.script);
  if(arcadeMode()) {
    level.arcadeMode_success = true;
    flag_wait("arcademode_ending_complete");
  } else {
    maps\_hud_message::waitTillNotifiesDone();
  }
  SetSavedDvar("ui_nextMission", "1");
  SetDvar("ui_showPopup", "0");
  SetDvar("ui_popupString", "");
  if(!isDefined(level_index)) {
    return;
  }
  if(!coopGame()) {
    level.missionSettings set_level_completed(level_index);
    if(GetDvarInt(#"mis_01") < level_index + 1) {
      set_mission_dvar("mis_01", level_index + 1);
    }
    if(GetDvarInt(#"mis_01") == GetDvarInt(#"mis_01_unlock") && (getDvar(#"language") != "german" || getDvar(#"allow_zombies_german") == "1")) {
      set_mission_dvar("mis_01", (GetDvarInt(#"mis_01_unlock") + 1));
    }
    UpdateGamerProfile();
    if(level.missionSettings has_achievement(level_index)) {
      players[0] giveachievement_wrapper(level.missionSettings get_achievement(level_index));
    }
    if(level.missionSettings has_level_veteran_award(level_index) && get_level_completed(level_index) == 4 && level.missionSettings check_other_hasLevelVeteranAchievement(level_index)) {
      players[0] giveachievement_wrapper(level.missionSettings get_level_veteran_award(level_index));
    }
    if(level.missionSettings has_campaign(level_index) && level.missionSettings is_campaign_complete(level_index)) {
      players[0] giveachievement_wrapper(level.missionSettings get_campaign(level_index));
    }
  }
  nextlevel_index = level.missionSettings.levels.size;
  nextlevel_index = level_index + 1;
  if(coopGame()) {
    found = false;
    for(; nextlevel_index < level.missionSettings.levels.size; nextlevel_index++) {
      if(level.missionSettings get_coop(nextlevel_index)) {
        found = true;
        break;
      }
    }
    if(!found) {
      nextlevel_index = level.missionSettings get_first_coop_index();
      assert(nextlevel_index >= 0);
      assert(nextlevel_index < level.missionSettings.levels.size);
      if(IsSplitScreen()) {
        if(!arcadeMode()) {
          maps\_cooplogic::endGame();
        } else {
          exitLevel(false);
        }
        SetUINextLevel(level.missionSettings get_level_name(nextlevel_index));
        wait 1;
        return;
      }
    }
  }
  if(coopGame() && !IsSplitScreen()) {
    if(!arcadeMode()) {
      maps\_cooplogic::endGame();
    } else {
      exitLevel(false);
    }
    assert(nextlevel_index >= 0);
    assert(nextlevel_index < level.missionSettings.levels.size);
    SetUINextLevel(level.missionSettings get_level_name(nextlevel_index));
    return;
  }
  if(!coopGame() || IsSplitScreen()) {
    if(level.missionSettings skip_success(level_index)) {
      ChangeLevel(level.missionSettings get_level_name(nextlevel_index), level.missionSettings get_keep_weapons(level_index));
    } else {
      if(level.script == "credits") {
        MissionSuccess("credits", false);
      } else if(level.script == "outro") {
        MissionSuccess("outro", false);
      } else {
        MissionSuccess(level.missionSettings get_level_name(nextlevel_index), level.missionSettings get_keep_weapons(level_index));
      }
    }
  }
  if(!coopGame() && !IsSplitScreen()) {
    award = true;
    hardcore_award = true;
    for(i = 0; i < level.missionSettings.levels.size; i++) {
      if(level.missionSettings get_level_name(i) == "credits") {
        continue;
      }
      if(level.missionSettings get_level_name(i) == "outro") {
        continue;
      }
      if(level.missionSettings get_level_name(i) == "nazi_zombie_prototype") {
        continue;
      }
      difficulty = get_level_completed(i);
      if(difficulty == 0) {
        award = false;
        hardcore_award = false;
        break;
      }
      if(difficulty < 3) {
        hardcore_award = false;
      }
    }
    if(award) {
      players[0] giveachievement_wrapper("SP_WIN_UNDERWATERBASE");
    }
    if(hardcore_award) {
      players[0] giveachievement_wrapper("SP_GEN_MASTER");
    }
  }
}

prefetch_next() {
  level_index = level.missionSettings get_level_index(level.script);
  if(isDefined(level_index)) {
    nextlevel_index = level_index + 1;
    if(nextlevel_index < level.missionSettings.levels.size) {
      nextlevel_name = level.missionSettings get_level_name(nextlevel_index);
      if(issubstr(nextlevel_name, "so_narrative")) {
        nextlevel_index++;
        if(nextlevel_index < level.missionSettings.levels.size) {
          prefetchLevel(level.missionSettings get_level_name(nextlevel_index));
        }
      } else {
        prefetchLevel(nextlevel_name);
      }
    }
  }
}

get_level_completed(level_index) {
  return Int(getDvar(#"mis_difficulty")[level_index]);
}

set_level_completed(level_index) {
  levelOffset = level_index;
  missionString = getDvar(#"mis_difficulty");
  if(Int(missionString[levelOffset]) > level.gameskill) {
    return;
  }
  gameskill = level.gameskill;
  newString = "";
  for(index = 0; index < missionString.size; index++) {
    if(index != levelOffset) {
      newString += missionString[index];
    } else {
      newString += gameskill + 1;
    }
  }
  set_mission_dvar("mis_difficulty", newString);
}

set_mission_dvar(dvar, string) {
  if(maps\_cheat::is_cheating() || flag("has_cheated")) {
    return;
  }
  if(getDvar(#"mis_cheat") == "1") {
    return;
  }
  SetMissionDvar(dvar, string);
}

get_lowest_skill() {
  missionString = getDvar(#"mis_difficulty");
  lowestSkill = 4;
  for(index = 0; index < self.levels.size; index++) {
    if(Int(missionString[index]) < lowestSkill) {
      lowestSkill = Int(missionString[index]);
    }
  }
  return (lowestSkill);
}

create_mission() {
  mission = spawnStruct();
  mission.levels = [];
  return (mission);
}

add_level(levelName, keepWeapons, achievement, skip_success, veteran_achievement, campaign, coop) {
  assert(isDefined(keepweapons));
  level_index = self.levels.size;
  self.levels[level_index] = spawnStruct();
  self.levels[level_index].name = levelName;
  self.levels[level_index].keepWeapons = keepWeapons;
  self.levels[level_index].achievement = achievement;
  self.levels[level_index].skip_success = skip_success;
  self.levels[level_index].veteran_achievement = veteran_achievement;
  self.levels[level_index].campaign = campaign;
  self.levels[level_index].coop = coop;
}

get_level_index(levelName) {
  for(i = 0; i < self.levels.size; i++) {
    if(self.levels[i].name != levelName) {
      continue;
    }
    return (i);
  }
  return (undefined);
}

get_level_name(level_index) {
  return (self.levels[level_index].name);
}

get_keep_weapons(level_index) {
  return (self.levels[level_index].keepWeapons);
}

get_achievement(level_index) {
  return (self.levels[level_index].achievement);
}

get_level_veteran_award(level_index) {
  return (self.levels[level_index].veteran_achievement);
}

has_level_veteran_award(level_index) {
  if(isDefined(self.levels[level_index].veteran_achievement)) {
    return (true);
  } else {
    return (false);
  }
}

has_achievement(level_index) {
  if(isDefined(self.levels[level_index].achievement)) {
    return (true);
  } else {
    return (false);
  }
}

is_campaign_complete(level_index) {
  campaign = self.levels[level_index].campaign;
  count = 0;
  complete_count = 0;
  for(i = 0; i < self.levels.size; i++) {
    if(i == level_index) {
      continue;
    }
    if(isDefined(self.levels[i].campaign) && isDefined(campaign) && self.levels[i].campaign == campaign) {
      count++;
      if(self get_level_completed(i) > 0) {
        complete_count++;
      }
    }
  }
  if(count == complete_count) {
    return true;
  } else {
    return false;
  }
}

get_campaign(level_index) {
  return (self.levels[level_index].campaign);
}

get_coop(level_index) {
  if(self get_level_name(level_index) == "credits") {
    return false;
  }
  if(self get_level_name(level_index) == "outro") {
    return false;
  }
  return self.levels[level_index].coop;
}

get_first_coop_index() {
  for(i = 0; i < level.missionSettings.levels.size; i++) {
    if(self get_coop(i)) {
      return i;
    }
  }
  return -1;
}

has_campaign(level_index) {
  if(isDefined(self.levels[level_index].campaign)) {
    return (true);
  } else {
    return (false);
  }
}

check_other_hasLevelVeteranAchievement(level_index) {
  for(i = 0; i < self.levels.size; i++) {
    if(i == level_index) {
      continue;
    }
    if(!has_level_veteran_award(i)) {
      continue;
    }
    if(self.levels[i].veteran_achievement == self.levels[level_index].veteran_achievement) {
      if(get_level_completed(i) < 4) {
        return false;
      }
    }
  }
  return true;
}

skip_success(level_index) {
  if(!isDefined(self.levels[level_index].skip_success)) {
    return false;
  }
  return true;
}

force_all_complete() {
  println("tada!");
  missionString = getDvar(#"mis_difficulty");
  for(index = 0; index < missionString.size; index++) {
    set_level_completed(index);
  }
}

clearall() {
  SetMissionDvar("mis_difficulty", "00000000000000000000000000000000000000000000000000");
  SetMissionDvar("mis_01", 1);
}

credits_end() {
  ChangeLevel("");
}