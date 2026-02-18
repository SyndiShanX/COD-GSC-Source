/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_15a7051a4ff0cf46.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3890e6e179f6ed13;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace namespace_9c42e5f3;

function starting(var_d3440450) {
  level thread scene::init_streamer("scene_tkd_hit1_intro_fly_in", getplayers());
  level thread scene::init_streamer("scene_tkd_hit1_intro_fly_in_trucks", getplayers());
  level.var_aece851d = [];
  flag::set("heli_door_opening");
  namespace_42da7c51::function_ed760ecb("woods");
}

function main(var_d3440450, var_50cc0d4f) {
  level flag::set("flag_convoy_assault_started");
  level.var_33621ea7 = 0;
  thread function_a7dc18f3();
  level flag::wait_till("heli_convoy_aslt_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {
  if(player) {
    level flag::set("heli_convoy_aslt_complete");
  }
}

function function_46693791() {
  driver = getent("driver_woods_kills", "script_parameters", 1);
  level flag::wait_till("heli_intro_path_ally");
  level flag::set("truck_middle_unload");
  level.woods colors::enable();
  level.woods.ignoreall = 1;
  level.woods.ignoreme = 1;
  level.var_aece851d[level.var_aece851d.size] = level.woods;

  if(isDefined(driver)) {
    driver ai::bloody_death(0.2);
  }

  wait 1.2;
  level.woods.ignoreall = 0;
  wait 1;
  objectives::follow("woods_hit1", level.woods);
  level.var_95a74232 = 1;
  aiarray = getaiarray("intro_enemy_truck_guys", "script_noteworthy");
  level thread namespace_42da7c51::function_d6fedf97(aiarray, int(ceil(aiarray.size * 0.75)), "convoy_retreat");
  level thread function_67924661(aiarray);
  level flag::wait_till("convoy_retreat");
  level thread savegame::checkpoint_save();

  foreach(ai in aiarray) {
    if(isDefined(ai) && isalive(ai)) {
      ai thread namespace_42da7c51::function_603d935("vol_gas_station_all");
      ai thread ai::bloody_death(randomintrange(8, 12));
    }
  }
}

function function_67924661(aiarray) {
  driver = getent("driver_woods_kills", "script_parameters", 1);

  foreach(guy in aiarray) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;

    if(!isDefined(driver)) {
      if(isDefined(guy.script_parameters) && guy.script_parameters == "intro_driver_assassinate") {
        driver = guy;
      }
    }
  }

  wait 0.2;

  foreach(guy in aiarray) {
    if(isDefined(guy)) {
      guy.ignoreme = 0;
    }
  }

  level.woods.ignoreall = 0;
  level.woods.ignoreme = 0;

  foreach(guy in aiarray) {
    if(isDefined(guy)) {
      if(!(isDefined(guy.script_parameters) && guy.script_parameters == "squirter")) {
        guy.ignoreall = 0;
      }
    }
  }
}

function function_a7dc18f3() {
  aiarray = array();
  level flag::set("intro_heli_lights_on");
  thread function_46693791();
  level flag::wait_till("fly_in_scene_finished");
  level.var_9a3944f4 thread namespace_42da7c51::function_76075c60();
  level thread function_f4ac4681();
  level battlechatter::function_2ab9360b(1);
  level.var_9a3944f4 vehicle_ai::set_state("combat");
}

function function_f4ac4681() {
  level endon(#"hash_4f6dc93101e62ff5");

  while(true) {
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_tdwn_01100_wood_gogomoveup_ab");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_tdwn_01200_wood_keepmovingletsg_20");
    wait randomintrange(5, 7);
    level.woods dialogue::queue("vox_cp_chao_03100_wood_masonfollowme_f0");
  }
}