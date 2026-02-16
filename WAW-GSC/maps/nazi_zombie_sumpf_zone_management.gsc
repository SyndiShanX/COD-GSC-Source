/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nazi_zombie_sumpf_zone_management.gsc
******************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

manage_building_zone() {
  self endon("deactivate_zone");

  spawners = undefined;
  dog_spawners = [];

  if(isDefined(self.target)) {
    spawners = getEntArray(self.target, "targetname");

    for(i = 0; i < spawners.size; i++) {
      if(issubstr(spawners[i].classname, "dog")) {
        dog_spawners = array_add(dog_spawners, spawners[i]);
      }
    }

    if(dog_spawners.size > 0) {
      for(i = 0; i < dog_spawners.size; i++) {
        spawners = array_remove(spawners, dog_spawners[i]);
      }
    }

    if(self.targetname == "center_building_combined") {
      level.southwest = getEntArray("southwest_center_building_spawners", "targetname");
      level.southeast = getEntArray("southeast_center_building_spawners", "targetname");
      level.northeast = getEntArray("northeast_center_building_spawners", "targetname");
      level.northwest = getEntArray("northwest_center_building_spawners", "targetname");
    }
  }

  while(getdvarint("noclip") == 0 || getdvarint("notarget") != 0) {
    zone_active = false;
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        zone_active = true;
      }
    }

    if(zone_active) {
      if(isDefined(spawners)) {
        if(self.targetname == "center_building_combined" && !level.all_blockers) {
          if(!level.got_southwest && flag("sw_magic_box")) {
            for(i = 0; i < (level.southwest).size; i++) {
              spawners = array_add(spawners, level.southwest[i]);
            }
            level.got_southwest = true;
          }

          if(!level.got_southeast && flag("se_magic_box")) {
            for(i = 0; i < (level.southeast).size; i++) {
              spawners = array_add(spawners, level.southeast[i]);
            }
            level.got_southeast = true;
          }

          if(!level.got_northeast && flag("ne_magic_box")) {
            for(i = 0; i < (level.northeast).size; i++) {
              spawners = array_add(spawners, level.northeast[i]);
            }
            level.got_northeast = true;
          }

          if(!level.got_northwest && flag("nw_magic_box")) {
            for(i = 0; i < (level.northwest).size; i++) {
              spawners = array_add(spawners, level.northwest[i]);
            }
            level.got_northwest = true;
          }

          if(level.got_southwest && level.got_southeast && level.got_northeast && level.got_northwest) {
            level.all_blockers = true;
          }
        }
        for(x = 0; x < spawners.size; x++) {
          no_dupes = array_check_for_dupes(level.enemy_spawns, spawners[x]);
          if(no_dupes) {
            spawners[x].locked_spawner = false;
            level.enemy_spawns = add_to_array(level.enemy_spawns, spawners[x]);
          }
        }
      }
    } else {
      if(isDefined(spawners)) {
        for(x = 0; x < spawners.size; x++) {
          spawners[x].locked_spawner = true;
          level.enemy_spawns = array_remove_nokeys(level.enemy_spawns, spawners[x]);
        }
      }

    }

    wait(1);
  }
}

manage_outside_zone(zone_area, key, building) {
  outside_zones = [];
  dog_spawners = [];

  if(!building) {
    outside_zones = getEntArray(zone_area + "_outside", key);
  } else {
    outside_zones = getEntArray(zone_area + "_building", key);
  }
  zone = outside_zones[0];

  spawners = undefined;

  if(isDefined(zone.target)) {
    spawners = getEntArray(zone.target, "targetname");

    for(i = 0; i < spawners.size; i++) {
      if(issubstr(spawners[i].classname, "dog")) {
        dog_spawners = array_add(dog_spawners, spawners[i]);
      }
    }

    if(dog_spawners.size > 0) {
      for(i = 0; i < dog_spawners.size; i++) {
        spawners = array_remove(spawners, dog_spawners[i]);
      }
    }
  }

  check_ent = undefined;
  while(1) {
    zone_active = false;
    players = get_players();

    if(isDefined(check_ent)) {
      for(i = 0; i < check_ent.size; i++) {
        for(j = 0; j < players.size; j++) {
          if(players[j] istouching(check_ent[i])) {
            zone_active = true;
          }
        }
      }
    }

    for(j = 0; j < outside_zones.size; j++) {
      for(i = 0; i < players.size; i++) {
        if(players[i] istouching(outside_zones[j])) {
          zone_active = true;
        }
      }
    }

    zombie_rise_locations = [];
    zombie_rise_locations = getStructArray(zone.targetname + "_zombie_rise", "targetname");

    if(zone_active) {
      if(isDefined(spawners)) {
        for(x = 0; x < spawners.size; x++) {
          no_dupes = array_check_for_dupes(level.enemy_spawns, spawners[x]);
          if(no_dupes) {
            spawners[x].locked_spawner = false;
            level.enemy_spawns = add_to_array(level.enemy_spawns, spawners[x]);
          }
        }
      }

      for(i = 0; i < zombie_rise_locations.size; i++) {
        no_dupes = array_check_for_dupes(level.zombie_rise_spawners, zombie_rise_locations[i]);
        if(no_dupes) {
          zombie_rise_locations[i].locked_spawner = false;
          level.zombie_rise_spawners = add_to_array(level.zombie_rise_spawners, zombie_rise_locations[i]);
        }
      }
    } else {
      if(isDefined(spawners)) {
        for(x = 0; x < spawners.size; x++) {
          spawners[x].locked_spawner = true;
          level.enemy_spawns = array_remove_nokeys(level.enemy_spawns, spawners[x]);
        }
      }

      for(i = 0; i < zombie_rise_locations.size; i++) {
        level.zombie_rise_spawners = array_remove_nokeys(level.zombie_rise_spawners, zombie_rise_locations[i]);
      }
    }

    wait(1);
  }
}

activate_building_zones(zone_name, key) {
  volume_entity = [];
  volume_entity = getEntArray(zone_name, key);
  for(i = 0; i < volume_entity.size; i++) {
    volume_entity[i] thread manage_building_zone();
  }
}

combine_center_building_zones() {
  flag_wait("unlock_hospital_downstairs");

  deactivate_building_zones("center_building_upstairs", "targetname");

  spawners = getEntArray("zombie_spawner_init", "targetname");

  for(i = 0; i < spawners.size; i++) {
    spawners[i].targetname = "center_building_combined_spawners";
  }

  level.all_blockers = false;
  level.got_southwest = false;
  level.southwest = [];
  level.got_southeast = false;
  level.southeast = [];
  level.got_northeast = false;
  level.northeast = [];
  level.got_northwest = false;
  level.northwest = [];

  activate_building_zones("center_building_combined", "targetname");
  activate_building_zones("center_building_upstairs_buy", "targetname");

  dog_array = getEntArray("center_stairs_blocker_dog_spawn", "targetname");
  for(i = 0; i < dog_array.size; i++) {
    dog_array[i].targetname = "zombie_spawner_dog_init";
    dog_array[i].script_noteworthy = "zombie_dog_spawner";
    level.enemy_dog_spawns = add_to_array(level.enemy_dog_spawns, dog_array[i]);
  }

  level thread maps\nazi_zombie_sumpf_bouncing_betties::purchase_bouncing_betties();

  level thread maps\nazi_zombie_sumpf_bouncing_betties::give_betties_after_rounds();
}

add_area_dog_spawners(area_location) {
  dog_array = getEntArray(area_location, "targetname");
  for(i = 0; i < dog_array.size; i++) {
    dog_array[i].targetname = "zombie_spawner_dog_init";
    dog_array[i].script_noteworthy = "zombie_dog_spawner";
    level.enemy_dog_spawns = add_to_array(level.enemy_dog_spawns, dog_array[i]);
  }
}

deactivate_building_zones(zone_name, key) {
  volume_entity = [];
  volume_entity = getEntArray(zone_name, key);
  for(i = 0; i < volume_entity.size; i++) {
    volume_entity[i] notify("deactivate_zone");
  }
}

activate_outdoor_zones(zone_area, key) {
  thread manage_outside_zone(zone_area, key, 0);

  self waittill(zone_area + "_building_unlocked");

  thread manage_outside_zone(zone_area, key, 1);
}