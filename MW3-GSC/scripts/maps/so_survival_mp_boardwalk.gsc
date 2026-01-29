/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_boardwalk.gsc
*****************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_boardwalk_precache::main();
  maps\mp\mp_boardwalk_precache::main();
  maps\createart\mp_boardwalk_art::main();
  maps\mp\mp_boardwalk_fx::main();
  maps\createfx\mp_boardwalk_fx::main();
  maps\_so_survival::_id_3F65();
  maps\_load::main();
  ambientplay("ambient_mp_boardwalk");
  maps\_utility::set_vision_set("mp_boardwalk", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_boardwalk");
  maps\_so_survival::_id_3F67();
  level thread rotate_sign();
  level thread balloons();
  level thread carnival_games();
  level thread setup_carnival_items();
  level thread _id_0618::_id_6F52();
}

setup_carnival_items() {
  level.carnival_fx_tag_01 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_02 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_03 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_04 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_05 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_06 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_07 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_08 = common_scripts\utility::spawn_tag_origin();
  level.carnival_fx_tag_01 moveto((-169.714, 1972.79, 184.634), 0.05);
  level.carnival_fx_tag_02 moveto((-170.491, 2044.83, 184.671), 0.05);
  level.carnival_fx_tag_03 moveto((-170.427, 2108.7, 184.655), 0.05);
  level.carnival_fx_tag_04 moveto((-170.185, 2176.83, 184.662), 0.05);
  level.carnival_fx_tag_05 moveto((-170.055, 2240.88, 184.664), 0.05);
  level.carnival_fx_tag_06 moveto((132.078, 1536.49, 193), 0.05);
  level.carnival_fx_tag_07 moveto((63.9661, 1536.99, 192.946), 0.05);
  level.carnival_fx_tag_08 moveto((1.6665, 1530.19, 189.955), 0.05);
  level.carnival_fx_tag_01.angles = (270, 0, 0);
  level.carnival_fx_tag_02.angles = (270, 0, 0);
  level.carnival_fx_tag_03.angles = (270, 0, 0);
  level.carnival_fx_tag_04.angles = (270, 0, 0);
  level.carnival_fx_tag_05.angles = (270, 0, 0);
  level.carnival_fx_tag_06.angles = (270, 0, 0);
  level.carnival_fx_tag_07.angles = (270, 0, 0);
  level.carnival_fx_tag_08.angles = (270, 0, 0);
  level.carnival_fx_tag_01 show();
  level.carnival_fx_tag_02 show();
  level.carnival_fx_tag_03 show();
  level.carnival_fx_tag_04 show();
  level.carnival_fx_tag_05 show();
  level.carnival_fx_tag_06 show();
  level.carnival_fx_tag_07 show();
  level.carnival_fx_tag_08 show();
  level.carnivalgamefx = "mp_bw_clown01";
}

rotate_sign() {
  level endon("game_ended");
  var_0 = getent("bbq_sign", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 8;

  for(;;) {
    var_0 rotateyaw(360, var_1, 0, 0);
    wait(var_1 - 0.1);
  }
}

balloons() {
  level endon("game_ended");

  if(!isDefined(level.remote_uav)) {
    level.remote_uav = [];

  }
  var_0 = getEntArray("balloon_volume", "targetname");

  while(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in level.remote_uav) {
      foreach(var_4 in var_0) {
        if(!isDefined(var_2)) {
          break;
        }

        if(!isDefined(var_4)) {
          continue;
        }
        if(var_2 istouching(var_4)) {
          radiusdamage(var_4.origin, 16, 2, 2, var_2);
          break;
        }

        common_scripts\utility::waitframe();
      }
    }

    wait 0.15;
  }
}

carnival_games() {
  level thread roller_coaster();
  level thread animal_race();
  level thread baseball_pitch();
}

roller_coaster() {
  var_0 = getent("roller_coaster", "targetname");
  var_1 = getEntArray("animated_model", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(var_3.model == "generic_prop_raven") {
      var_0 linkto(var_3, "J_prop_1", (0, 0, 0), (180, 180, 180));
      break;
    }
  }
}

animal_race() {
  animial_setup();
  start_animal_race();
}

animial_setup() {
  level.animals = [];
  var_0 = getEntArray("animal_stick", "targetname");

  foreach(var_3, var_2 in var_0) {
    level.animals[var_3] = getent(var_2.target, "targetname");
    var_2 linkto(level.animals[var_3]);
    level.animals[var_3].original_pos = level.animals[var_3].origin;
  }

  level.animal_marquee_lights = getEntArray("animal_marquee_lights", "targetname");
}

start_animal_race() {
  level endon("game_ended");
  var_0 = getEntArray("accelerator", "targetname");

  foreach(var_2 in var_0) {}
  level childthread monitor_accelerator_damage(var_2);
}

monitor_accelerator_damage(var_0) {
  level endon("race_over");
  var_1 = getent(var_0.target, "targetname");
  var_1.lightent = getent(var_1.targetname + "_light", "targetname");
  var_2 = var_1.origin;
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_4 = abs(var_1.origin[1] - var_3.origin[1]) / 80;
  var_5 = 0;

  for(;;) {
    var_0 waittill("damage", var_6, var_7);
    var_5 = var_5 + var_4;
    var_8 = var_2 + (0, var_5, 0);
    var_1 moveto(var_8, 0.25);

    if(distance2d(var_8, var_3.origin) < var_4) {
      var_1 waittill("movedone");
      level thread animal_race_victory(var_1);
      break;
    }
  }
}

animal_race_victory(var_0) {
  level endon("game_ended");
  level notify("race_over");
  var_0.lightent setModel("bw_light_game_on");

  if(isDefined(var_0._id_18F5)) {
    thread create_exploder_play_fx(var_0._id_18F5);

  }
  foreach(var_2 in level.animal_marquee_lights) {}
  var_2 setModel("marquee_lights_yellow_flashing_fast");

  wait 4;

  foreach(var_5 in level.animals) {}
  var_5 moveto(var_5.original_pos, 5);

  wait 5;
  var_0.lightent setModel("bw_light_game");

  foreach(var_2 in level.animal_marquee_lights) {}
  var_2 setModel("marquee_lights_white_flashing_slow");

  level thread start_animal_race();
}

baseball_pitch() {
  level endon("game_ended");
  var_0 = getEntArray("catcher", "targetname");

  foreach(var_2 in var_0) {}
  level childthread monitor_catcher_damage(var_2);
}

monitor_catcher_damage(var_0) {
  for(;;) {
    var_0 waittill("damage");

    if(isDefined(var_0._id_18F5)) {
      thread create_exploder_play_fx(var_0._id_18F5);

    }
    wait 3;
  }
}

create_exploder_play_fx(var_0) {
  switch (var_0) {
    case 1001:
      level.carnival_fx_location = level.carnival_fx_tag_01;
      level.carnivalgamefx = "mp_bw_clown01";
      break;
    case 1002:
      level.carnival_fx_location = level.carnival_fx_tag_02;
      level.carnivalgamefx = "mp_bw_clown02";
      break;
    case 1003:
      level.carnival_fx_location = level.carnival_fx_tag_03;
      level.carnivalgamefx = "mp_bw_clown03";
      break;
    case 1004:
      level.carnival_fx_location = level.carnival_fx_tag_04;
      level.carnivalgamefx = "mp_bw_clown04";
      break;
    case 1005:
      level.carnival_fx_location = level.carnival_fx_tag_05;
      level.carnivalgamefx = "mp_bw_clown05";
      break;
    case 2001:
      level.carnival_fx_location = level.carnival_fx_tag_06;
      level.carnivalgamefx = "mp_bw_game01";
      break;
    case 2002:
      level.carnival_fx_location = level.carnival_fx_tag_07;
      level.carnivalgamefx = "mp_bw_game02";
      break;
    case 2003:
      level.carnival_fx_location = level.carnival_fx_tag_08;
      level.carnivalgamefx = "mp_bw_game03";
      break;
  }

  playfxontagforclients(level._effect[level.carnivalgamefx], level.carnival_fx_location, "tag_origin", level.players);
}