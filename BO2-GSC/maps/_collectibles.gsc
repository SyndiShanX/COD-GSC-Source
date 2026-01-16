/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_collectibles.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_challenges_sp;

main() {
  flag_wait("level.player");
  init_intel_map();
  a_collectibles = getentarray("collectible", "targetname");

  if(!isDefined(level.intel_map[level.script])) {
    assert(a_collectibles.size == 0);
    return;
  }

  n_intel_index = level.intel_map[level.script]["start_index"];
  n_num_intel = level.intel_map[level.script]["num_intel"];
  assert(a_collectibles.size == n_num_intel);

  if(a_collectibles.size > 0) {
    level.player thread maps\_challenges_sp::register_challenge("locateintel", ::collectibles_level_challenge);
    level.player notify("check_challenge");
  }

  level.collectibles = collectible_init(a_collectibles, n_intel_index);

  for(i = 0; i < level.collectibles.size; i++)
    level.collectibles[i] thread collectible_wait_for_pickup();

  onsaverestored_callback(::collectibles_level_restore);
}

set_intel_map(map, start_index, num_intel) {
  if(!isDefined(level.intel_map[map]))
    level.intel_map[map] = [];

  level.intel_map[map]["start_index"] = start_index;
  level.intel_map[map]["num_intel"] = num_intel;
}

init_intel_map() {
  if(!isDefined(level.intel_map))
    level.intel_map = [];

  set_intel_map("angola", 1, 1);
  set_intel_map("angola_2", 2, 2);
  set_intel_map("monsoon", 1, 3);
  set_intel_map("so_cmp_afghanistan", 1, 3);
  set_intel_map("nicaragua", 1, 3);
  set_intel_map("pakistan", 1, 3);
  set_intel_map("pakistan_2", 0, 0);
  set_intel_map("pakistan_3", 0, 0);
  set_intel_map("karma", 1, 1);
  set_intel_map("karma_2", 2, 2);
  set_intel_map("panama", 1, 1);
  set_intel_map("panama_2", 2, 1);
  set_intel_map("panama_3", 3, 1);
  set_intel_map("yemen", 1, 3);
  set_intel_map("blackout", 1, 3);
  set_intel_map("la_1", 1, 1);
  set_intel_map("la_1b", 2, 2);
  set_intel_map("la_2", 0, 0);
  set_intel_map("haiti", 1, 3);
}

collectibles_level_challenge(str_notify) {
  while(true) {
    self waittill("check_challenge");

    if(is_true(collected_all())) {
      self notify(str_notify);
      return;
    }
  }
}

collectibles_level_restore() {
  map_collectibles = getentarray("collectible", "targetname");

  for(i = 0; i < map_collectibles.size; i++) {
    if(hascollectible(int(map_collectibles[i].script_parameters))) {
      collectible_remove_found(map_collectibles[i]);
      continue;
    }
  }
}

collectible_init(map_collectibles, n_intel_index) {
  collectibles = [];
  items = 0;
  start_num = n_intel_index;

  for(i = 0; i < map_collectibles.size; i++) {
    map_collectibles[i].script_parameters = start_num + i;

    if(hascollectible(int(map_collectibles[i].script_parameters))) {
      collectible_remove_found(map_collectibles[i]);
      continue;
    }

    map_collectibles[i].trigger = spawn("trigger_radius", map_collectibles[i].origin, 0, 64, 64);
    map_collectibles[i].trigger sethintstring("");
    map_collectibles[i].trigger setcursorhint("HINT_NOICON");
    assert(isDefined(map_collectibles[i].trigger), "ERROR: _collectibles: Unable to create collectible trigger");
    collectibles[items] = map_collectibles[i];
    items++;
  }

  return collectibles;
}

collectible_remove_found(collectible_item) {
  if(isDefined(collectible_item.trigger))
    collectible_item.trigger delete();

  if(isDefined(collectible_item.target)) {
    m_stand = getent(collectible_item.target, "targetname");
    m_stand delete();
  }

  collectible_item delete();
}

collectible_wait_for_pickup() {
  level endon("collectible_save_restored");

  while(true) {
    self.trigger waittill("trigger", player);
    player_is_looking_at = player is_player_looking_at(self.origin, 0.8, 0);

    if(player_is_looking_at)
      self.trigger sethintstring(&"SCRIPT_COLLECTIBLE_PICKUP");
    else
      self.trigger sethintstring("");

    if(isalive(player) && player_is_looking_at && player use_button_held()) {
      playsoundatposition("uin_aar_unlock_loud", (0, 0, 0));
      break;
    }

    wait 0.05;

    if(!player istouching(self.trigger))
      self.trigger sethintstring("");
  }

  setcollectible(int(self.script_parameters));
  player thread collectiblenotify(self.unlock);
  player notify("check_challenge");
  collectible_remove_found(self);
}

collectiblenotify(unlock, num_found) {
  dointelacquiredui();
}