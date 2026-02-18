/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5882f53c3e1f693f.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_812a8849;

function init() {
  clientfield::register("world", "dark_aether_active", 1, 1, "int");
  clientfield::register("world", "terminal_on", 1, 1, "int");
  clientfield::register("world", "center_zone_lights_off", 1, 1, "int");
  clientfield::register("world", "gold_container_receptacle", 1, 2, "int");
  clientfield::register("world", "exfil_begin", 1, 1, "int");
  clientfield::register("world", "exfil_aether_trigger", 1, 1, "int");
  level thread function_d88ded8(#"dark_aether_active", "dark_aether_active");
  level thread function_d88ded8(array("terminal_1_is_on", "terminal_2_is_on"), "terminal_on");
  level thread function_d88ded8(#"hash_94bda7ad49639f5", "center_zone_lights_off");
  level thread function_d88ded8(#"hash_6dae739b31c68d72", "exfil_begin");
  level thread function_d88ded8(#"exfil_aether_trigger", "exfil_aether_trigger");
  level thread function_b5bdf435();
  clientfield::register("world", "helping_hand_room_light", 1, 3, "int");
  clientfield::register("world", "dance_party_light", 1, 1, "int");
  clientfield::register("world", "eye_corpse_light", 1, 3, "int");
  level thread function_387ae4cb();
}

function function_d88ded8(flag, clientfield) {
  level endon(#"end_game");

  while(true) {
    level waittill(flag);

    if(isarray(flag)) {
      level clientfield::set(clientfield, level flag::get_all(flag));
      continue;
    }

    level clientfield::set(clientfield, level flag::get(flag));
  }
}

function function_b5bdf435() {
  level endon(#"end_game");
  level waittill(#"gold_container_receptacle_off");
  level clientfield::set("gold_container_receptacle", 1);
  level waittill(#"gold_container_receptacle_on");
  level clientfield::set("gold_container_receptacle", 2);
}

function function_bd7cde02(state) {
  level endon(#"hash_2d0433bbc2675311");

  if(isDefined(state)) {
    switch (state) {
      case # "turn_all_lights_off":
        level clientfield::set("helping_hand_room_light", 0);
        break;
      case # "turn_room_1_light_on":
        level clientfield::set("helping_hand_room_light", 1);
        break;
      case # "turn_room_2_light_on":
        level clientfield::set("helping_hand_room_light", 2);
        break;
      case # "turn_room_3_light_on":
        level clientfield::set("helping_hand_room_light", 3);
        break;
      case # "turn_room_4_light_on":
        level clientfield::set("helping_hand_room_light", 4);
        break;
      case # "turn_room_5_light_on":
        level clientfield::set("helping_hand_room_light", 5);
        break;
      case # "turn_room_5_light_off":
        level clientfield::set("helping_hand_room_light", 6);
        break;
    }
  }
}

function function_387ae4cb() {
  level endon(#"end_game");
  level waittill(#"dance_party_light_on");
  level clientfield::set("dance_party_light", 1);
  level waittill(#"dance_party_light_off");
  level clientfield::set("dance_party_light", 0);
}

function function_32ba2029(state) {
  level endon(#"hash_2d0433bbc2675311");

  if(isDefined(state)) {
    switch (state) {
      case # "eye_corpse_all_lights_off":
        level clientfield::set("eye_corpse_light", 0);
        break;
      case # "hash_4f392103c121e5e8":
        level clientfield::set("eye_corpse_light", 1);
        break;
      case # "hash_2cff279013344d8f":
        level clientfield::set("eye_corpse_light", 2);
        break;
      case # "hash_3e957b81e3c5716e":
        level clientfield::set("eye_corpse_light", 3);
        break;
      case # "hash_5d0f09f0cbf01d75":
        level clientfield::set("eye_corpse_light", 4);
        break;
      case # "hash_10b3c9031d24f9c4":
        level clientfield::set("eye_corpse_light", 5);
        break;
      case # "eye_corpse_final_light_on":
        level clientfield::set("eye_corpse_light", 6);
        break;
    }
  }
}