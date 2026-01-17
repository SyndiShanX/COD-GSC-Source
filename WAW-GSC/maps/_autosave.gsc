/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_autosave.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  level.lastAutoSaveTime = 0;
  flag_init("game_saving");
  flag_init("can_save");
  flag_set("can_save");
}

autosave_description() {
  return (&"AUTOSAVE_AUTOSAVE");
}

autosave_names(num) {
  if(num == 0) {
    savedescription = &"AUTOSAVE_GAME";
  } else {
    savedescription = &"AUTOSAVE_NOGAME";
  }
  return savedescription;
}

start_level_save() {
  flag_wait("all_players_connected");
  flag_wait("starting final intro screen fadeout");
  wait(0.5);
  players = get_players();
  players[0] player_flag_wait("loadout_given");
  if(level.createFX_enabled) {
    return;
  }
  if(level.missionfailed) {
    return;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return;
  }
  if(flag("game_saving")) {
    return;
  }
  flag_set("game_saving");
  imagename = "levelshots/autosave/autosave_" + level.script + "start";
  for(i = 0; i < players.size; i++) {
    players[i].savedVisionSet = players[i] GetVisionSetNaked();
  }
  auto_save_print("start_level_save: Start of level save");
  SaveGame("levelstart", &"AUTOSAVE_LEVELSTART", imagename, true);
  setDvar("ui_grenade_death", "0");
  println("Saving level start saved game");
  flag_clear("game_saving");
  level thread maps\_arcademode::arcadeMode_checkpoint_save();
}

trigger_autosave(trigger) {
  if(!isDefined(trigger.script_autosave)) {
    trigger.script_autosave = 0;
  }
  autosave_think(trigger);
}

autosave_think(trigger) {
  savedescription = autosave_names(trigger.script_autosave);
  if(!(isDefined(savedescription))) {
    println("autosave", self.script_autosave, " with no save description in _autosave.gsc!");
    return;
  }
  trigger waittill("trigger", ent);
  num = trigger.script_autosave;
  imagename = "levelshots/autosave/autosave_" + level.script + num;
  try_auto_save(num, savedescription, imagename, undefined, ent);
  if(isDefined(trigger)) {
    trigger delete();
  }
}

autosave_name_think(trigger) {
  trigger waittill("trigger", ent);
  if(isDefined(level.customautosavecheck)) {
    if(![
        [level.customautosavecheck]
      ]()) {
      return;
    }
  }
  name = trigger.script_autosavename;
  level._save_pos = trigger.origin;
  level._save_trig_ent = ent getentitynumber();
  maps\_utility::set_breadcrumbs_player_positions();
  maps\_utility::autosave_by_name(name);
  if(isDefined(trigger)) {
    trigger delete();
  }
}

trigger_autosave_immediate(trigger) {
  trigger waittill("trigger");
}

auto_save_print(msg, msg2) {
  msg = " AUTOSAVE: " + msg;
  if(getdvar("scr_autosave_debug") == "") {
    setdvar("scr_autosave_debug", "0");
  }
  if(getdebugdvarint("scr_autosave_debug") == 1) {
    if(isDefined(msg2)) {
      println(msg + "[localized description]");
    } else {
      println(msg);
    }
    return;
  }
  if(isDefined(msg2)) {
    println(msg, msg2);
  } else {
    println(msg);
  }
}

autosave_game_now(suppress_print) {
  if(flag("game_saving")) {
    return false;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return false;
  }
  if(!IsAlive(get_host())) {
    return false;
  }
  filename = "save_now";
  descriptionString = autosave_description();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].savedVisionSet = players[i] GetVisionSetNaked();
  }
  if(isDefined(suppress_print)) {
    saveId = saveGameNoCommit(filename, descriptionString, "$default", true);
  } else {
    saveId = saveGameNoCommit(filename, descriptionString);
  }
  level thread maps\_arcademode::arcadeMode_checkpoint_save();
  wait(0.05);
  if(isSaveRecentlyLoaded()) {
    auto_save_print("autosave_game_now: FAILED!!! -> save error - recently loaded.");
    level.lastAutoSaveTime = GetTime();
    return false;
  }
  auto_save_print("autosave_game_now: Saving game " + filename + " with desc ", descriptionString);
  if(saveId < 0) {
    auto_save_print("autosave_game_now: FAILED!!! -> save error.: " + filename + " with desc ", descriptionString);
    return false;
  }
  if(!try_to_autosave_now()) {
    return false;
  }
  flag_set("game_saving");
  wait 2;
  if(try_to_autosave_now()) {
    level notify("save_success");
    commitSave(saveId);
    setDvar("ui_grenade_death", "0");
  }
  flag_clear("game_saving");
  return true;
}

autosave_now_trigger(trigger) {
  trigger waittill("trigger");
  autosave_now();
}

try_to_autosave_now() {
  if(!issavesuccessful()) {
    return false;
  }
  if(!autosave_health_check()) {
    return false;
  }
  if(!flag("can_save")) {
    auto_save_print("try_to_autosave_now: Can_save flag was clear");
    return false;
  }
  return true;
}

autosave_check_simple() {
  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    return false;
  }
  if(level.missionfailed) {
    return false;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return false;
  }
  if(maps\_laststand::player_any_player_in_laststand()) {
    return false;
  }
  if(isDefined(level.savehere) && !level.savehere) {
    return false;
  }
  if(isDefined(level.canSave) && !level.canSave) {
    return false;
  }
  if(!flag("can_save")) {
    return false;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] animscripts\banzai::in_banzai_attack()) {
      return false;
    }
    axis = GetAiArray("axis");
    for(j = 0; j < axis.size; j++) {
      if(isDefined(axis[j].banzai) && axis[j].banzai) {
        if(isDefined(axis[j].enemy) && axis[j].enemy == players[i]) {
          auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai chase.");
          return false;
        }
        if(isDefined(axis[j].favoriteEnemy) && axis[j].favoriteEnemy == players[i]) {
          auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai chase.");
          return false;
        }
      }
    }
  }
  if(maps\_collectibles::has_collectible("collectible_berserker")) {
    for(i = 0; i < players.size; i++) {
      if(players[i].collectibles_berserker_mode_on) {
        return false;
      }
    }
  }
  return true;
}

try_auto_save(filename, description, image, timeout, ent) {
  if(!flag("all_players_connected")) {
    flag_wait("all_players_connected");
    wait(3);
  }
  level endon("save_success");
  flag_waitopen("game_saving");
  flag_set("game_saving");
  descriptionString = autosave_description();
  start_save_time = GetTime();
  if(!isDefined(ent)) {
    ent = get_players()[0];
  }
  level._save_pos = ent.origin;
  level._save_trig_ent = ent getentitynumber();
  maps\_utility::set_breadcrumbs_player_positions();
  wait(0.05);
  while(1) {
    if(isSaveRecentlyLoaded()) {
      level.lastAutoSaveTime = GetTime();
      break;
    }
    if(autosave_check() && !isSaveRecentlyLoaded()) {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i].savedVisionSet = players[i] GetVisionSetNaked();
      }
      saveId = saveGameNoCommit(filename, descriptionString, image, coopGame());
      level thread maps\_arcademode::arcadeMode_checkpoint_save();
      if(!isDefined(saveId) || saveId < 0) {
        flag_clear("game_saving");
        return false;
      }
      wait(6);
      retries = 0;
      while(retries < 8) {
        if(autosave_check_simple()) {
          commitSave(saveId);
          level.lastSaveTime = GetTime();
          setDvar("ui_grenade_death", "0");
          flag_clear("game_saving");
          return true;
        }
        retries++;
        wait(2);
      }
      flag_clear("game_saving");
      return false;
    }
    wait(1);
  }
  flag_clear("game_saving");
  return false;
}

autosave_check_not_picky() {
  return autosave_check(false);
}

autosave_check(doPickyChecks) {
  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    return false;
  }
  if(level.missionfailed) {
    return false;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return false;
  }
  if(maps\_laststand::player_any_player_in_laststand()) {
    return false;
  }
  if(!isDefined(doPickyChecks)) {
    doPickyChecks = true;
  }
  if(!autosave_health_check()) {
    return false;
  }
  if(!autosave_threat_check(doPickyChecks)) {
    return false;
  }
  if(!autosave_player_check()) {
    return false;
  }
  if(isDefined(level.dont_save_now) && level.dont_save_now) {
    return false;
  }
  if(!IsSaveSuccessful()) {
    auto_save_print("autosave_check: FAILED!!! -> save call was unsuccessful");
    return false;
  }
  return true;
}

autosave_player_check() {
  host = get_host();
  if(host IsMeleeing()) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is meleeing");
    return false;
  }
  if(host IsThrowingGrenade() && host GetCurrentOffHand() != "molotov") {
    auto_save_print("autosave_player_check: FAILED!!! -> host is throwing a grenade");
    return false;
  }
  if(host IsFiring()) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is firing");
    return false;
  }
  if(isDefined(host.shellshocked) && host.shellshocked) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is in shellshock");
    return false;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] animscripts\banzai::in_banzai_attack()) {
      auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai attack.");
      return false;
    }
    axis = GetAiArray("axis");
    for(j = 0; j < axis.size; j++) {
      if(isDefined(axis[j].banzai) && axis[j].banzai) {
        if(isDefined(axis[j].enemy) && axis[j].enemy == players[i]) {
          auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai chase.");
          return false;
        }
        if(isDefined(axis[j].favoriteEnemy) && axis[j].favoriteEnemy == players[i]) {
          auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in banzai chase.");
          return false;
        }
      }
    }
  }
  if(maps\_collectibles::has_collectible("collectible_berserker")) {
    for(i = 0; i < players.size; i++) {
      if(players[i].collectibles_berserker_mode_on) {
        auto_save_print("autosave_player_check: FAILED!!! -> player " + i + " is in berserker mode.");
        return false;
      }
    }
  }
  return true;
}

autosave_ammo_check() {
  players = get_players();
  if(players.size == 0) {
    return (false);
  }
  if(level.script == "pby_fly") {
    return true;
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    weapons = players[i] GetWeaponsListPrimaries();
    for(idx = 0; idx < weapons.size; idx++) {
      if(WeaponClass(weapons[idx]) == "gas") {
        continue;
      }
      fraction = players[i] GetFractionMaxAmmo(weapons[idx]);
      if(fraction < 0.1) {
        auto_save_print("autosave_ammo_check: FAILED!!! -> ammo too low");
        return (false);
      }
    }
  }
  return (true);
}

autosave_health_check() {
  players = get_players();
  if(players.size > 1) {
    for(i = 1; i < players.size; i++) {
      if(players[i] player_flag("player_has_red_flashing_overlay")) {
        auto_save_print("autosave_health_check: FAILED!!! -> player " + i + " has red flashing overlay");
        return false;
      }
    }
  }
  host = get_host();
  healthFraction = host.health / host.maxhealth;
  if(healthFraction < 0.5) {
    auto_save_print("autosave_health_check: FAILED!!! -> host health too low");
    return false;
  }
  if(host player_flag("player_has_red_flashing_overlay")) {
    auto_save_print("autosave_health_check: FAILED!!! -> host has red flashing overlay");
    return false;
  }
  return true;
}

autosave_threat_check(doPickyChecks) {
  if(level.script == "see2") {
    return true;
  }
  host = get_host();
  enemies = GetAISpeciesArray("axis", "all");
  for(i = 0; i < enemies.size; i++) {
    if(!isDefined(enemies[i].enemy)) {
      continue;
    }
    if(enemies[i].enemy != host) {
      continue;
    }
    if(enemies[i].type == "dog") {
      if(DistanceSquared(enemies[i].origin, host.origin) < (384 * 384)) {
        auto_save_print("autosave_threat_check: FAILED!!! -> dog near player");
        return (false);
      }
      continue;
    }
    if(enemies[i].a.lastShootTime > GetTime() - 500) {
      if(doPickyChecks || enemies[i] animscripts\utility::canShootEnemy()) {
        auto_save_print("autosave_threat_check: FAILED!!! -> AI firing on player");
        return (false);
      }
    }
    if(enemies[i].a.alertness == "aiming" && enemies[i] animscripts\utility::canShootEnemy()) {
      auto_save_print("autosave_threat_check: FAILED!!! -> AI aiming at player");
      return (false);
    }
    if(isDefined(enemies[i].a.personImMeleeing) && enemies[i].a.personImMeleeing == host) {
      auto_save_print("autosave_threat_check: FAILED!!! -> AI meleeing player");
      return (false);
    }
  }
  if(player_is_near_live_grenade()) {
    return false;
  }
  return (true);
}