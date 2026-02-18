/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3711e526ec2a3863.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#namespace namespace_72b0499b;

function init_audio() {}

function function_4e1b7477() {
  while(level.players.size == 0) {
    wait 0.25;
  }

  level.players[0] endon(#"death");
  level endon(#"hash_629da45ba6679aae");

  while(true) {
    level flag::wait_till("dambs_armada_base_playing");
    thread function_816f9a23();
    level flag::wait_till_clear("dambs_armada_base_playing");
    level notify(#"snd_emitter_stop");
  }
}

function function_827cf084() {
  while(level.players.size == 0) {
    wait 0.25;
  }

  level.players[0] endon(#"death");
  level endon(#"hash_488f3af92d575e4d");

  while(true) {
    level flag::wait_till("dambs_armada_mortar_village_playing");
    thread function_62d67678();
    level flag::wait_till_clear("dambs_armada_mortar_village_playing");
    level notify(#"hash_629da45ba6679aae");
  }
}

function function_2cc7f62c() {
  while(level.players.size == 0) {
    wait 0.25;
  }

  level.players[0] endon(#"death");
  level endon(#"hash_6e7780f7f1e44599");

  while(true) {
    level flag::wait_till("dambs_armada_swamp_playing");
    thread function_54b26c90();
    level flag::wait_till_clear("dambs_armada_swamp_playing");
    level notify(#"snd_emitter_stop");
    level notify(#"hash_488f3af92d575e4d");
  }
}

function function_6cd6e708() {
  while(level.players.size == 0) {
    wait 0.25;
  }

  level.players[0] endon(#"death");
  level endon(#"hash_11376b46ca5b856e");

  while(true) {
    level flag::wait_till("dambs_armada_crash_playing");
    thread function_552d1d58();
    level flag::wait_till_clear("dambs_armada_crash_playing");
    level notify(#"snd_emitter_stop");
    level notify(#"hash_6e7780f7f1e44599");
  }
}

function function_816f9a23() {
  snd::emitter("emt_wind_breeze", level.players[0], [10, 15, 10, 15]);
  snd::emitter("emt_nam_base_canvas_sweetener", (-9092, -71547.3, 1071.8), [2, 4], [0, 0], [0, 0]);
  snd::emitter("emt_nam_base_canvas_wind", (-9092, -71547.5, 1071.33), [14, 15], [0, 0], [0, 0]);
  snd::emitter("emt_heli_distant_flyover", level.players[0], [11, 17, 10, 15], [500, 650], [0, 0]);
  snd::emitter("emt_heli_distant_mono_flyover", level.players[0], [10, 17, 10, 15], [500, 650], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-9910, -71384, 1050), [5, 11], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-9893, -71400, 1051), [7, 12], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-9713, -71944, 1055), [4, 8], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-9635, -71998, 1057), [5, 9], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-9725, -72024, 1057), [5, 11], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-10467, -71363, 1061), [5, 11], [0, 0], [0, 0]);
  snd::emitter("emt_walla_armada_base_calm", level.players[0], [13, 15], [350, 750], [0, 0]);
  snd::emitter("emt_walla_armada_base_yell", level.players[0], [13, 16], [350, 750], [0, 0]);
  snd::emitter("emt_walla_armada_base_yell_short", level.players[0], [10, 15], [350, 750], [0, 0]);
  snd::emitter("emt_walla_armada_base_yell", (-10090, -73241, 1065), [11, 14], [0, 0], [0, 0]);
  snd::emitter("emt_walla_armada_base_yell_short", (-8680, -71504, 1165), [10, 15], [0, 0], [0, 0]);
}

function function_62d67678() {
  snd::emitter("emt_foliage_rustle_light", (-17917, 42063, 770), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-18005, 41844, 770), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-18246, 42188, 750), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-18465, 42476, 795), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-19424, 41721, 879), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-21149, 42321, 1066), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-21497, 42116, 1066), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-21764, 40218, 1094), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-20547, 38344, 1034), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-19255, 38504, 978), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-19262, 39331, 917), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-18193, 37664, 1047), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-17582, 39754, 586), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-17537, 40100, 576), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_rustle_light", (-18454, 41111, 533), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_nam_base_canvas_wind", (-19369, 40288, 800), [14, 15], [0, 0], [0, 0]);
  snd::emitter("emt_animal_birds_forest", (-18101, 42238, 954), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_animal_birds_forest", (-19346, 41684, 1075), [5, 12], [0, 0], [0, 0]);
  snd::emitter("emt_animal_birds_forest", (-21440, 42351, 1145), [5, 9], [0, 0], [0, 0]);
  snd::emitter("emt_nam_swamp_jungle_birds", (-22326, 40112, 1145), [7, 12], [0, 0], [0, 0]);
  snd::emitter("emt_animal_birds_forest", (-21707, 37928, 1201), [5, 10], [0, 0], [0, 0]);
  snd::emitter("emt_nam_swamp_jungle_birds", (-20230, 37827, 1201), [7, 11], [0, 0], [0, 0]);
  snd::emitter("emt_nam_animals_bird_mystery", (-18775, 38029, 1125), [8, 13], [0, 0], [0, 0]);
  snd::emitter("emt_foliage_wood_creaks_large", (-17343, 40343, 543), [9, 15], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (-17282, 39821, 467), [4, 8], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (-16920, 40840, 467), [4, 8], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (-17091, 39287, 512), [4, 8], [0, 0], [0, 0]);
  snd::emitter("emt_wood_creaking_room", (-17854, 39134, 678), [5, 10], [0, 0], [0, 0]);
  snd::emitter("emt_wood_creaking_room", (-17155, 40476, 514), [5, 10], [0, 0], [0, 0]);
  snd::emitter("emt_wood_creaking_room", (-17096, 41070, 470), [5, 10], [0, 0], [0, 0]);
  snd::emitter("emt_nam_wood_forest_creak_deep", (-17854, 39134, 678), [5, 13], [0, 0], [0, 0]);
  snd::emitter("emt_nam_wood_forest_creak_deep", (-17096, 41070, 470), [5, 13], [0, 0], [0, 0]);
}

function function_54b26c90() {
  snd::emitter("emt_foliage_rustle_light", level.players[0], [6, 10, 11, 15], [300, 500], [0, 360]);
  snd::emitter("emt_animal_birds_forest", level.players[0], [15, 19, 10, 15], [500, 700], [0, 360]);
  snd::emitter("emt_wind_breeze", level.players[0], [8, 11, 10, 15], [300, 500], [0, 360]);
  snd::emitter("emt_nam_animals_howler_monkey", level.players[0], [12, 16, 11, 15], [200, 400], [0, 360]);
  snd::emitter("emt_nam_animals_gibbon_monkey", level.players[0], [7, 11, 10, 15], [200, 400], [0, 360]);
  snd::emitter("emt_nam_animals_bird_mystery", level.players[0], [8, 15, 10, 15], [400, 600], [0, 360]);
  snd::emitter("emt_nam_swamp_jungle_birds", level.players[0], [14, 21, 10, 15], [300, 500], [0, 360]);
  snd::emitter("emt_nam_wood_forest_creak_deep", level.players[0], [5, 13, 8, 15], [200, 500], [0, 360]);
  snd::emitter("emt_foliage_wood_creaks_large", level.players[0], [6, 16, 8, 15], [200, 500], [0, 360]);
  snd::emitter("emt_nam_jungle_foliage_breaks_medium_short", level.players[0], [12, 15], [100, 400], [0, 180]);
  snd::emitter("emt_nam_jungle_foliage_breaks_medium_long", level.players[0], [10, 15], [100, 400], [0, 180]);
  snd::emitter("emt_nam_jungle_foliage_breaks_medium_short", level.players[0], [9, 14], [100, 400], [0, 180]);
  snd::emitter("emt_nam_walla_viet_yell_long", level.players[0], [8, 15, 10, 15], [200, 300], [0, 180]);
  snd::emitter("emt_nam_walla_viet_yell_short", level.players[0], [8, 15, 10, 15], [200, 300], [0, 180]);
  snd::play("emt_nam_engine_hiss_high_lp", (41965, 62150, 1340));
  snd::emitter("emt_nam_engine_radiator_ones", (41965, 62150, 1340), [2, 4], [0, 0], [0, 0]);
  snd::emitter("emt_nam_engine_radiator_clinks", (41965, 62150, 1340), [3, 5], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (41829, 62242, 1304), [5, 8], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (41281, 62191, 1325), [5, 8], [0, 0], [0, 0]);
  snd::emitter("emt_nam_water_lapping_short", (42594, 62234, 1320), [5, 8], [0, 0], [0, 0]);
}

function function_552d1d58() {
  snd::emitter("emt_nam_gunfire_distant", level.players[0], [2, 4, 10, 15], [200, 800], [0, 0]);
  snd::emitter("emt_nam_exp_far", level.players[0], [3, 6, 10, 15], [400, 800], [0, 0]);
  snd::emitter("emt_nam_exp_medium", level.players[0], [2, 5, 10, 15], [400, 800], [0, 0]);
}

function function_132ea7de() {
  snd::emitter("amb_radio_oneshot", (-18790, 40029, 840), [3, 7], [0, 0], [0, 0]);
  snd::emitter("amb_radio_oneshot", (-18755, 40033, 841), [4, 8], [0, 0], [0, 0]);
  snd::play("amb_computer_lp", (-18740, 40203, 837));
  var_cfe894ed = snd::play("amb_behind_reddoor_rustling_lp", (-18859, 40343, 842));
  level waittill(#"hash_1c61fc6e80974e9");
  snd::stop(var_cfe894ed, 6);
}

function music(str_msg, n_delay = 0, var_37a6c96) {
  level thread function_7edafa59(str_msg, n_delay, var_37a6c96);
  level thread function_e80c0ccf(str_msg);
}

function function_7edafa59(str_msg, n_delay, var_37a6c96) {
  switch (str_msg) {
    case # "hash_6d6826a83750847":
    case # "hash_6d6826a83750847":
    case # "2.0_briefing":
    case # "hash_2c622a30dc731207":
    case # "hash_35d3f2d1bf79eb35":
    case # "hash_4c5ac549022188d4":
    case # "12.0_turret":
    case # "hash_572e961104184b52":
    case # "5.0_village_combat":
    case # "hash_63ee253a845cbefd":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_15d512eeb8abc51e":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate(str_msg, undefined, n_delay);
      wait 1;
      music::setmusicstate("12.0_turret");
      break;
    case # "hash_2375b08205562389":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_3c930a111db30f46":
      music::setmusicstate(str_msg, undefined, n_delay);
      wait 5;
      music::setmusicstate("5.0_village_combat");
      break;
    case # "hash_7a72528b9f2c2f90":
      music::function_edda155f(str_msg, n_delay);
      break;
    case # "hash_2193c42e21ea2e63":
      music::function_2af5f0ec(str_msg);
      break;
    case # "hash_4c4e6fe764aec250":
      music::setmusicstate("explo_stinger", undefined, n_delay);
      break;
    default:

      iprintlnbold("<dev string:x38>" + str_msg + "<dev string:x4a>");

      break;
  }
}

function function_e80c0ccf(str_msg) {
  switch (str_msg) {
    case # "2.0_briefing":
      snd::client_msg(#"musictrack_cp_armada_1");
      waitframe(1);
      snd::client_msg(#"musictrack_cp_armada_2");
      break;
    case # "hash_3c930a111db30f46":
    case # "5.0_village_combat":
      snd::client_msg(#"musictrack_cp_armada_3");
      break;
    case # "hash_6d6826a83750847":
      snd::client_msg(#"musictrack_cp_armada_4");
      break;
    case # "hash_4c5ac549022188d4":
      snd::client_msg(#"musictrack_cp_armada_5");
      break;
  }
}