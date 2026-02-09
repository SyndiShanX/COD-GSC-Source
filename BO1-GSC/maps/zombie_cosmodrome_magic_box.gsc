/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_magic_box.gsc
************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

magic_box_init() {
  level._cosmodrome_no_power = "n";
  level._cosmodrome_fire_sale = "f";
  level._box_locations = array("start_chest", "chest1", "chest2", "base_entry_chest", "storage_area_chest", "chest5", "chest6", "warehouse_lander_chest");
  level thread magic_box_update();
  level thread cosmodrome_collision_fix();
  level thread cosmodrome_maintenance_respawn_fix();
  SetSavedDvar("zombiemode_path_minz_bias", 31);
}
get_location_from_chest_index(chest_index) {
  if(isDefined(level.chests[chest_index])) {
    chest_loc = level.chests[chest_index].script_noteworthy;
    for(i = 0; i < level._box_locations.size; i++) {
      if(level._box_locations[i] == chest_loc) {
        return i;
      }
    }
  }
}
magic_box_update() {
  wait(2);
  setclientsysstate("box_indicator", level._cosmodrome_no_power);
  box_mode = "no_power";
  while(1) {
    if((!flag("power_on") || flag("moving_chest_now")) &&
      level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
      box_mode = "no_power";
    } else if(isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) &&
      level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) {
      box_mode = "fire_sale";
    } else {
      box_mode = "box_available";
    }
    switch (box_mode) {
      case "no_power":
        setclientsysstate("box_indicator", level._cosmodrome_no_power);
        while(!flag("power_on") &&
          level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
          wait(0.1);
        }
        break;
      case "fire_sale":
        setclientsysstate("box_indicator", level._cosmodrome_fire_sale);
        while(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) {
          wait(0.1);
        }
        break;
      case "box_available":
        setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
        while(!flag("moving_chest_now") &&
          level.zombie_vars["zombie_powerup_fire_sale_on"] == 0 &&
          !flag("launch_activated")) {
          wait(0.1);
        }
        break;
      default:
        setclientsysstate("box_indicator", level._cosmodrome_no_power);
        break;
    }
    wait(1.0);
  }
}
cosmodrome_collision_fix() {
  PreCacheModel("collision_geo_256x256x256");
  collision = spawn("script_model", (-1692, 2116, -48));
  collision setModel("collision_geo_256x256x256");
  collision.angles = (0, 0, 0);
  collision Hide();
}
cosmodrome_maintenance_respawn_fix() {
  respawn_points = GetStructArray("player_respawn_point", "targetname");
  for(i = 0; i < respawn_points.size; i++) {
    if(respawn_points[i].script_noteworthy == "storage_lander_zone") {
      respawn_positions = GetStructArray(respawn_points[i].target, "targetname");
      for(j = 0; j < respawn_positions.size; j++) {
        if(isDefined(respawn_positions[j].script_int) && respawn_positions[j].script_int == 1 && respawn_positions[j].origin[0] == -159.5) {
          respawn_positions[j].origin = (-159.5, -1292.7, -119);
        }
      }
    }
  }
}