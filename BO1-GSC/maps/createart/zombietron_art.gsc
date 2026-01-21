/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\zombietron_art.gsc
*********************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {}
do_single_lightning() {
  players = get_players();
  {
    players[0] SetClientFlag(level._ZT_PLAYER_CF_LIGHTNING);
  }
  wait .5;
  players = get_players();
  {
    players[0] ClearClientFlag(level._ZT_PLAYER_CF_LIGHTNING);
  }
}

do_lightning_loop() {
  level endon("end_lightning");
  while(1) {
    wait(RandomFloatRange(3, 20));
    do_single_lightning();
  }
}

setup_random_sun() {
  dir = "-45 135 0";
  color = "0.75 0.75 0.75";
  light = "8";
  exposure = "1.1";
  level.is_nighttime = undefined;
  visionSetNaked("zombietron_morning", 0);
  if(level.arena_round_number == 1) {
    dir = "-35 110 0";
    color = "0.95 0.76 0.57";
    light = "8";
    exposure = "1.1";
    visionSetNaked("zombietron_morning", 0);
  }
  if(level.arena_round_number == 2) {
    dir = "-59 113 0";
    color = "1 0.96 0.87";
    light = "12";
    exposure = "1.1";
    visionSetNaked("zombietron_day", 0);
  }
  if(level.arena_round_number == 3) {
    dir = "-15 113 0";
    color = "0.99 0.41 0";
    light = "12";
    exposure = "1.3";
    visionSetNaked("zombietron_afternoon", 0);
  }
  if(level.arena_round_number == 4) {
    dir = "-38 107 0";
    color = "0 0.4 0.9";
    light = "15";
    exposure = "1.2";
    visionSetNaked("zombietron_evening", 0);
    level.is_nighttime = true;
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("island")) {
    if(level.arena_round_number == 1) {
      dir = "-26 108 0";
      exposure = "1.57";
      light = "9";
    }
    if(level.arena_round_number == 2) {
      exposure = "0.98";
      dir = "-43.06 141.5 0";
      color = "1 1 1";
    }
    if(level.arena_round_number == 3) {
      dir = "-25.2 113.5 0";
    }
    if(level.arena_round_number == 4) {
      exposure = "1.23";
      light = "18";
      color = "0 0.2 0.95";
      dir = "-21.6 130.4 0";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("town")) {
    if(level.arena_round_number == 1) {
      light = "10";
      exposure = "1.24";
      dir = "-27.9 102.5 0";
    }
    if(level.arena_round_number == 2) {
      light = "11";
      dir = "-51.8 23.6 0";
      exposure = "0.83";
    }
    if(level.arena_round_number == 3) {
      dir = "-28 209 0";
    }
    if(level.arena_round_number == 4) {
      light = "5";
      color = "0 0.4 1";
      dir = "-40 241 0";
      exposure = "0.98";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("prison")) {
    if(level.arena_round_number == 1) {
      dir = "-26.2 -30.4 0";
      color = "1 0.87 0.63";
      exposure = "1.3";
    }
    if(level.arena_round_number == 2) {
      dir = "-49 -20 0";
      color = "1 0.97 0.86";
      light = "10";
      exposure = "0.68";
    }
    if(level.arena_round_number == 3) {
      dir = "-18.16 113 0";
    }
    if(level.arena_round_number == 4) {
      light = "10";
      dir = "-40.3 -52.3 0";
      exposure = "0.88";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("temple")) {
    if(level.arena_round_number == 1) {
      exposure = "1.2";
      color = "1 0.97 0.86";
      dir = "-38 238 0";
    }
    if(level.arena_round_number == 2) {
      light = "10";
      dir = "-61 272 0";
      exposure = "0.56";
    }
    if(level.arena_round_number == 3) {
      dir = "-31.8 137 0";
      exposure = "1.2";
    }
    if(level.arena_round_number == 4) {
      light = "8";
      exposure = "1.2";
      color = "0 0.4 0.9";
      dir = "-36 -139 0";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("factory")) {
    if(level.arena_round_number == 1) {
      dir = "-31 115.3 0";
      exposure = "1.3";
    }
    if(level.arena_round_number == 2) {
      light = "15";
      dir = "-36 144 0";
      exposure = "0.89";
      color = "1 0.96 0.75";
    }
    if(level.arena_round_number == 3) {
      light = "9";
      dir = "-28 163 0";
      exposure = "1.08";
    }
    if(level.arena_round_number == 4) {
      dir = "-22 143 0";
      color = "0 0.4 0.9";
      exposure = "0.74";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("rooftop")) {
    if(level.arena_round_number == 1) {
      dir = "-38 141 0";
    }
    if(level.arena_round_number == 2) {
      light = "10";
      dir = "-56 186 0";
      exposure = "0.79";
    }
    if(level.arena_round_number == 3) {
      dir = "-19.2 114.7 0";
      exposure = "1.1";
    }
    if(level.arena_round_number == 4) {
      light = "10";
      dir = "-14.2 85.3 0";
      color = "0.001 0.4 0.99";
      exposure = "1";
      visionSetNaked("zombietron_evening_rooftop", 0);
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("street")) {
    if(level.arena_round_number == 1) {
      dir = "-36.7 200.7 0";
      exposure = "1.12";
    }
    if(level.arena_round_number == 2) {
      light = "11";
      dir = "-36.7 200.7 0";
      exposure = "0.97";
    }
    if(level.arena_round_number == 3) {
      light = "10";
      dir = "-25.9 21.4 0";
      exposure = "0.97";
    }
    if(level.arena_round_number == 4) {
      light = "15";
      exposure = "0.64";
      color = "0.3 0.26 1";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("bunker")) {
    if(level.arena_round_number == 1) {
      exposure = "0.76";
    }
    if(level.arena_round_number == 2) {
      light = "11";
      exposure = "0.38";
    }
    if(level.arena_round_number == 3) {
      light = "9";
      dir = "-26.5 123.2 0";
      exposure = "0.67";
    }
    if(level.arena_round_number == 4) {
      exposure = "0.35";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("snow")) {
    if(level.arena_round_number == 1) {
      exposure = "0.46";
    }
    if(level.arena_round_number == 2) {
      exposure = "0.35";
      light = "9";
    }
    if(level.arena_round_number == 3) {
      light = "8";
      dir = "-20.2 112.2 0";
      exposure = "0.65";
    }
    if(level.arena_round_number == 4) {
      exposure = "0.35";
    }
  }
  if(level.current_arena == maps\_zombietron_main::arena_findIndexByName("jungle")) {
    if(level.arena_round_number == 1) {
      exposure = "1.57";
      light = "9";
      dir = "-41 197 0";
    }
    if(level.arena_round_number == 2) {
      dir = "-56.8 129.8 0";
      exposure = "1.08";
    }
    if(level.arena_round_number == 3) {
      dir = "-23.3 123.2 0";
      light = "10";
      exposure = "1.62";
    }
    if(level.arena_round_number == 4) {
      light = "12";
      dir = "-61.5 159.7 0";
      exposure = "1.1";
    }
  }
  level notify("end_lightning");
  num_total_rounds = level.zombie_vars["zombie_arena_rounds"] * level.arenas.size;
  round_number = level.round_number % num_total_rounds;
  level.raining = false;
  if(round_number == 8) {
    light = "1";
    exposure = "0.8";
    level.raining = true;
  } else if(round_number == 16) {
    light = "1";
    exposure = "1.2";
    level.raining = true;
  } else if(round_number == 40) {
    light = "1";
    exposure = "1.5";
    level.raining = true;
  }
  if(level.raining) {
    level thread do_lightning_loop();
    level thread do_2d_rain_audio();
  }
  if(level.magical_exit_taken) {
    dir = "-105 11.98 0";
    color = "0 0.4 0.9";
    light = "15";
    exposure = "0.79";
    visionSetNaked("zombietron_evening", 0);
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] setClientDvars("r_lightTweakSunLight", light, "r_lightTweakSunColor", color, "r_lightTweakSunDirection", dir, "r_exposureTweak", 1, "r_exposureValue", exposure);
  }
}

setup_flashlights() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    playFXOnTag(level._effect["flashlight"], players[i], "tag_flash");
  }
}

do_2d_rain_audio() {
  sound_ent = spawn("script_origin", (0, 0, 0));
  sound_ent playLoopSound("amb_rain_2d", 2);
  level waittill("end_lightning");
  sound_ent stopLoopSound(2);
  wait(2);
  sound_ent Delete();
}