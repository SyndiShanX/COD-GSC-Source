/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_collectibles.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

main() {
  level.collectibles = collectible_init();
  for(i = 0; i < level.collectibles.size; i++) {
    level.collectibles[i] thread collectible_wait_for_pickup();
  }
  OnSaveRestored_Callback(::collectibles_level_restore);
}

collectibles_level_restore() {
  map_collectibles = getEntArray("collectible", "targetname");
  for(i = 0; i < map_collectibles.size; i++) {
    if(HasCollectible(int(map_collectibles[i].script_parameters))) {
      collectible_remove_found(map_collectibles[i]);
      continue;
    }
  }
}

collectible_init() {
  collectibles = [];
  items = 0;
  radius = 64;
  map_collectibles = getEntArray("collectible", "targetname");
  start_num = 0;
  switch (level.script) {
    case "cuba":
      start_num = 1;
      break;
    case "vorkuta":
      start_num = 4;
      break;
    case "flashpoint":
      start_num = 7;
      break;
    case "khe_sanh":
      start_num = 10;
      break;
    case "hue_city":
      start_num = 13;
      break;
    case "kowloon":
      start_num = 16;
      break;
    case "creek_1":
      start_num = 19;
      break;
    case "river":
      start_num = 22;
      break;
    case "wmd_sr71":
      start_num = 25;
      break;
    case "wmd":
      start_num = 26;
      break;
    case "pow":
      start_num = 28;
      break;
    case "fullahead":
      start_num = 31;
      break;
    case "rebirth":
      start_num = 34;
      break;
    case "int_escape":
      start_num = 37;
      break;
    case "underwaterbase":
      start_num = 40;
      break;
    default:
      return collectibles;
  }
  level.collectibles_start_num = start_num;
  for(i = 0; i < map_collectibles.size; i++) {
    map_collectibles[i].script_parameters = start_num + i;
    if(HasCollectible(int(map_collectibles[i].script_parameters))) {
      collectible_remove_found(map_collectibles[i]);
      continue;
    }
    map_collectibles[i].trigger = spawn("trigger_radius", map_collectibles[i].origin, 0, radius, radius);
    map_collectibles[i].trigger setHintString("");
    map_collectibles[i].trigger setCursorHint("HINT_NOICON");
    AssertEx(isDefined(map_collectibles[i].trigger), "ERROR: _collectibles: Unable to create collectible trigger");
    collectibles[items] = map_collectibles[i];
    items++;
  }
  return collectibles;
}

collectible_remove_found(collectible_item) {
  if(isDefined(collectible_item.trigger)) {
    collectible_item.trigger delete();
  }
  collectible_item delete();
}

collectible_wait_for_pickup() {
  level endon("collectible_save_restored");
  while(1) {
    self.trigger waittill("trigger", player);
    player_is_looking_at = player is_player_looking_at(self.origin, 0.9, false);
    if(player_is_looking_at) {
      self.trigger setHintString(&"SCRIPT_COLLECTIBLE_PICKUP");
    } else {
      self.trigger setHintString("");
    }
    if(IsAlive(player) &&
      player_is_looking_at &&
      player Use_button_held()) {
      playsoundatposition("uin_aar_unlock_loud", (0, 0, 0));
      break;
    }
    wait(0.05);
    if(!player IsTouching(self.trigger)) {
      self.trigger setHintString("");
    }
  }
  SetCollectible(int(self.script_parameters));
  player thread collectibleNotify(self.Unlock);
  player thread collectible_achievement_unlock();
  collectible_remove_found(self);
}

collectible_achievement_unlock() {
  offset_start = 1;
  offset_end = 42;
  while(HasCollectible(offset_start)) {
    if(offset_start == offset_end) {
      self giveachievement_wrapper("SP_GEN_FOUNDFILMS");
    }
    offset_start++;
  }
}

collectibleNotify(Unlock, num_found) {
  notifyData = spawnStruct();
  notifyData.notifyText = &"SCRIPT_COLLECTIBLE";
  notifyData.sound = undefined;
  self maps\_hud_message::notifyMessage(notifyData);
}