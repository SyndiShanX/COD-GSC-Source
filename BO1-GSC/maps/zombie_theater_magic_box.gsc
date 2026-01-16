/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_theater_magic_box.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

magic_box_init() {
  level.dog_melee_range = 120;
  level._BOX_INDICATOR_NO_LIGHTS = -1;
  level._BOX_INDICATOR_FLASH_LIGHTS_MOVING = 99;
  level._BOX_INDICATOR_FLASH_LIGHTS_FIRE_SALE = 98;
  level._box_locations = array("start_chest",
    "foyer_chest",
    "crematorium_chest",
    "alleyway_chest",
    "control_chest",
    "stage_chest",
    "dressing_chest",
    "dining_chest",
    "theater_chest");
  level thread magic_box_update();
  level thread watch_fire_sale();
}

get_location_from_chest_index(chest_index) {
  chest_loc = level.chests[chest_index].script_noteworthy;
  for(i = 0; i < level._box_locations.size; i++) {
    if(level._box_locations[i] == chest_loc) {
      return i;
    }
  }
  AssertMsg("Unknown chest location - " + chest_loc);
}

magic_box_update() {
  wait(2);
  flag_wait("power_on");
  box_mode = "Box Available";
  setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
  while(1) {
    switch (box_mode) {
      case "Box Available":
        if(flag("moving_chest_now")) {
          setclientsysstate("box_indicator", level._BOX_INDICATOR_FLASH_LIGHTS_MOVING);
          box_mode = "Box is Moving";
        }
        break;
      case "Box is Moving":
        while(flag("moving_chest_now")) {
          wait(0.1);
        }
        setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
        box_mode = "Box Available";
        break;
    }
    wait(0.5);
  }
}

watch_fire_sale() {
  while(1) {
    level waittill("powerup fire sale");
    setclientsysstate("box_indicator", level._BOX_INDICATOR_FLASH_LIGHTS_FIRE_SALE);
    while(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
      wait(0.1);
    }
    setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
  }
}

turnLightGreen(name, playfx) {
  zapper_lights = getentarray(name, "script_noteworthy");
  for(i = 0; i < zapper_lights.size; i++) {
    if(isDefined(zapper_lights[i].fx)) {
      zapper_lights[i].fx delete();
    }
    if(isDefined(playfx) && playfx) {
      zapper_lights[i] setModel("zombie_zapper_cagelight_green");
      zapper_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_green", 2, "script_model", (zapper_lights[i].origin[0], zapper_lights[i].origin[1], zapper_lights[i].origin[2] - 10));
      zapper_lights[i].fx setModel("tag_origin");
      zapper_lights[i].fx.angles = zapper_lights[i].angles;
      playfxontag(level._effect["boxlight_light_ready"], zapper_lights[i].fx, "tag_origin");
    } else
      zapper_lights[i] setModel("zombie_zapper_cagelight");
  }
}

turnLightRed(name, playfx) {
  zapper_lights = getentarray(name, "script_noteworthy");
  for(i = 0; i < zapper_lights.size; i++) {
    if(isDefined(zapper_lights[i].fx)) {
      zapper_lights[i].fx delete();
    }
    if(isDefined(playfx) && playfx) {
      zapper_lights[i] setModel("zombie_zapper_cagelight_red");
      zapper_lights[i].fx = maps\_zombiemode_net::network_safe_spawn("trap_light_red", 2, "script_model", (zapper_lights[i].origin[0], zapper_lights[i].origin[1], zapper_lights[i].origin[2] - 10));
      zapper_lights[i].fx setModel("tag_origin");
      zapper_lights[i].fx.angles = zapper_lights[i].angles;
      playfxontag(level._effect["boxlight_light_notready"], zapper_lights[i].fx, "tag_origin");
    } else
      zapper_lights[i] setModel("zombie_zapper_cagelight");
  }
}