/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_canyon.gsc
*****************************************************/

canyon_init() {
  level.start_point = "canyon";
  thread maps\satfarm_audio::checkpoint_canyon();
}

canyon_main() {
  common_scripts\utility::flag_init("start_sparks1");
  common_scripts\utility::flag_init("start_sparks2");

  if(!isDefined(level.playertank)) {
    maps\satfarm_code::spawn_player_checkpoint("canyon_");
    maps\satfarm_code::spawn_heroes_checkpoint("canyon_");
  } else {
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[0], "", "switch_canyon_hero0", "canyon_path_hero0");
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[1], "", "switch_canyon_hero1", "canyon_path_hero1");
  }

  thread mortar_script();
  common_scripts\utility::flag_wait("satfarm_canyon_end");
}

mortar_script() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("canyon_allytanks1");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_0);
  wait 0.05;
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("canyon_allytanks2");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_1);
  wait 0.05;
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("canyon_allytanks3");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_2);
  wait 0.05;
  common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::tank_relative_speed, "mortar_strike_move", "satfarm_canyon_end");
  var_0[0] thread maps\satfarm_code::tank_relative_speed("mortar_strike_move", "satfarm_canyon_end", 1000, 25, 10);
  var_1[0] thread maps\satfarm_code::tank_relative_speed("mortar_strike_move", "satfarm_canyon_end", 2000, 25, 20);
  var_2[0] thread maps\satfarm_code::tank_relative_speed("mortar_strike_move", "satfarm_canyon_end", 2000, 25, 20);
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_enemyaaturretsneed");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("canyon_a10_gun_dive");
  wait 3;
  common_scripts\utility::flag_set("start_sparks1");
  wait 3;
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("complex_allies1");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_3);
  wait 0.05;
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("complex_allies2");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_3);
  wait 0.05;
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("complex_allies3");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_3);
  wait 0.05;
  common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  var_4 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("apache_ally_spawner2");
}

train_car_fall(var_0) {
  common_scripts\utility::flag_wait("train_fall");
  var_1 = getent("traincar_fall", "targetname");
  var_2 = getent("traincar_fall_col", "targetname");
  var_3 = common_scripts\utility::getstruct("traincar_fall_to", "targetname");
  var_1 rotatepitch(-10, 1, 0.25, 0.5);
  var_2 rotatepitch(-10, 1, 0.25, 0.5);
  earthquake(0.4, 0.5, level.player.origin, 512);
  playrumbleonposition("damage_heavy", var_3.origin);
  wait 2;
  iprintlnbold("IT'S COMING DOWN!");
  var_1 moveto(var_3.origin, 2, 0.25, 1);
  var_2 moveto(var_3.origin, 2, 0.25, 1);
  wait 1;
  earthquake(0.4, 0.5, level.player.origin, 512);
  playrumbleonposition("damage_heavy", var_3.origin);
  var_0 dodamage(var_0.health * 3, var_0.origin);
  common_scripts\utility::flag_set("start_sparks2");
  wait 1;
  var_0 delete();
}

sparks(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  var_2 = common_scripts\utility::getstructarray(var_1, "targetname");

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_4.origin;
    var_5.angles = (-90, 0, 0);
    playFXOnTag(common_scripts\utility::getfx("spark"), var_5, "tag_origin");
  }
}

mortar_strikes() {
  while(!common_scripts\utility::flag("end_art_strikes")) {
    for(var_0 = 0; var_0 < 3; var_0++) {
      var_1 = level.player getEye();
      var_2 = level.playertank.angles;
      var_3 = anglesToForward(var_2);
      var_4 = anglestoright(var_2);
      var_5 = level.playertank vehicle_getspeed();
      var_6 = var_1 + var_3 * 2000;
      var_7 = randomfloatrange(-1000, 1000);

      if(var_7 < 500 && var_7 >= 0)
        var_7 = randomfloatrange(500, 1000);

      if(var_7 > -500 && var_7 < 0)
        var_7 = randomfloatrange(-1000, -500);

      var_8 = randomfloatrange(-1000, 1000);

      if(var_8 < 500 && var_8 >= 0)
        var_8 = randomfloatrange(500, 1000);

      if(var_8 > -500 && var_8 < 0)
        var_8 = randomfloatrange(-1000, -500);

      var_9 = (var_7, var_8, 2000);
      var_10 = common_scripts\utility::spawn_tag_origin();
      var_10.origin = common_scripts\utility::drop_to_ground(var_6 + var_9);
      var_10.angles = (-90, 0, 0);
      thread common_scripts\utility::play_sound_in_space("satf_mortar_incoming", var_10.origin);
      wait(randomfloatrange(0.25, 0.45));
      playFXOnTag(common_scripts\utility::getfx("mortar"), var_10, "tag_origin");
      earthquake(0.2, 0.5, level.player.origin, 512);
      thread common_scripts\utility::play_sound_in_space("satf_mortar_explosion_dirt", var_10.origin);
      playrumbleonposition("damage_heavy", var_10.origin);
      wait(randomfloatrange(0.25, 0.45));
      var_10 delete();
    }

    wait(randomfloatrange(0.5, 1));
  }
}

ambush_init() {
  common_scripts\utility::flag_init("ambush_reverse");
  level.start_point = "ambush";
}

ambush_main() {
  if(!isDefined(level.playertank)) {
    maps\satfarm_code::spawn_player_checkpoint("ambush_");
    maps\satfarm_code::spawn_heroes_checkpoint("ambush_");
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambush_allytanks");
    level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_0);
    common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  } else {
    foreach(var_2 in level.allytanks) {
      if(isDefined(var_2) && var_2.script_friendname == "Bryce") {
        thread maps\satfarm_code::switch_node_on_flag(var_2, "", "switch_ambush_ally2", "ambush_path_ally2");
        level.allytank2 = var_2;
        continue;
      }

      if(isDefined(var_2) && var_2.script_friendname == "Brick") {
        thread maps\satfarm_code::switch_node_on_flag(var_2, "", "switch_ambush_ally1", "ambush_path_ally1");
        level.allytank1 = var_2;
      }
    }

    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[0], "", "switch_ambush_hero0", "ambush_path_hero0");
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[1], "", "switch_ambush_hero1", "ambush_path_hero1");
  }

  level.herotanks[0] thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_checkpoint_hit", -500, 0, -15);
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_checkpoint_hit", -500, 0, -15);

  foreach(var_2 in level.allytanks) {
    if(isDefined(var_2) && var_2.script_friendname == "Bryce" || var_2.script_friendname == "Brick" || var_2.script_friendname == "Babe Ruth")
      var_2 thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_checkpoint_hit", 1500, 15, 5);
  }

  common_scripts\utility::flag_wait("satfarm_canyon_end");
}

chase_script() {
  maps\_utility::autosave_by_name("chase");
  thread maps\satfarm_code::setup_satfarm_chainlink_fence_triggers();
  var_0 = [];
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_bridge1");
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_1, var_0);
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::gaz_relative_speed, "chase_checkpoint", "chase_checkpoint_hit");
  wait 5;
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_bend1");
  common_scripts\utility::array_thread(var_2, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_2, var_0);
  common_scripts\utility::array_thread(var_2, maps\satfarm_code::gaz_relative_speed, "chase_checkpoint", "chase_checkpoint_hit");
  common_scripts\utility::flag_wait("chase_bend_hit");
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_bend2");
  common_scripts\utility::array_thread(var_3, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_2, var_0);
  common_scripts\utility::array_thread(var_3, maps\satfarm_code::gaz_relative_speed, "chase_checkpoint", "chase_checkpoint_hit");
  common_scripts\utility::flag_wait("chase_checkpoint_hit");
  level.herotanks[0] thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_checkpoint_hit", -500, 0, -15);
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_checkpoint_hit", -500, 0, -15);

  foreach(var_5 in level.allytanks) {
    if(isDefined(var_5) && var_5.script_friendname == "Bryce" || var_5.script_friendname == "Brick" || var_5.script_friendname == "Babe Ruth")
      var_5 thread maps\satfarm_code::tank_relative_speed("complex_big_sat", "chase_dunes_hit", 2500, 30, 30);
  }

  wait 1;
  var_7 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_checkpoint1");
  common_scripts\utility::array_thread(var_7, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_7, var_0);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::gaz_relative_speed, "complex_big_sat", "player_spawn_valley1");
  common_scripts\utility::flag_wait("chase_dunes_hit");
  wait 2;
  var_8 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_dunes1");
  common_scripts\utility::array_thread(var_8, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_8, var_0);
  common_scripts\utility::array_thread(var_8, maps\satfarm_code::gaz_relative_speed, "complex_big_sat", "player_spawn_valley1");
  wait 3;
  var_9 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_rabbit1");
  common_scripts\utility::array_thread(var_9, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_9, var_0);
  common_scripts\utility::array_thread(var_9, maps\satfarm_code::gaz_relative_speed, "complex_big_sat", "player_spawn_valley1");
  wait 5;
  var_10 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("chase_rabbit2");
  common_scripts\utility::array_thread(var_10, maps\satfarm_code::gaz_spawn_setup);
  var_0 = common_scripts\utility::array_combine(var_10, var_0);
  common_scripts\utility::array_thread(var_10, maps\satfarm_code::gaz_relative_speed, "complex_big_sat", "player_spawn_valley1");
}

ambush_script() {
  maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy", "heli_nav_mesh3");
  maps\_utility::autosave_by_name("ambush");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("enemytankscanyonambush");
  level.enemytanks = common_scripts\utility::array_combine(var_0, level.enemytanks);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::npc_tank_combat_init);
  wait 0.05;
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::set_override_offset, (0, 0, 128));
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("enemytankscanyona");
  level.enemytanks = common_scripts\utility::array_combine(var_1, level.enemytanks);
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::npc_tank_combat_init);
  wait 0.05;
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::set_override_offset, (0, 0, 128));
  thread ambush_kill_ally();
  wait 3;
  thread pop_smoke();
  var_2 = getvehiclenode("reverse_hero0", "targetname");
  maps\satfarm_code::switch_node_now(level.herotanks[0], var_2);
  var_3 = getvehiclenode("reverse_hero1", "targetname");
  maps\satfarm_code::switch_node_now(level.herotanks[1], var_3);
  maps\satfarm_code::waittilltanksdead(var_0, 3, 0, "player_spawn_valley2");
  iprintlnbold("Move through the smoke.");
  common_scripts\utility::flag_set("player_move_valley1");
  var_2 = getvehiclenode("ambush_hero0", "targetname");
  maps\satfarm_code::switch_node_now(level.herotanks[0], var_2);
  var_3 = getvehiclenode("ambush_hero1", "targetname");
  maps\satfarm_code::switch_node_now(level.herotanks[1], var_3);
  wait 3;
  var_4 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("enemytankscanyonb");
  level.enemytanks = common_scripts\utility::array_combine(var_4, level.enemytanks);
  common_scripts\utility::array_thread(level.enemytanks, maps\satfarm_code::npc_tank_combat_init);
  iprintlnbold("More up ahead.");
  maps\satfarm_code::waittilltanksdead(var_1, 0, 0, "flag_spawn_valley3");

  if(var_4.size == 3)
    maps\satfarm_code::waittilltanksdead(var_4, 1, 0, "flag_spawn_valley3");

  common_scripts\utility::flag_set("player_spawn_valley3");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && var_6.classname != "script_vehicle_corpse") {
      var_6.veh_pathdir = "reverse";
      var_6 vehicle_setspeed(30, 25, 25);
    }
  }

  iprintlnbold("Enemies reversing! Follow them.");
  wait 2;
  var_8 = maps\satfarm_code_heli::spawn_hind_enemies(3, "heli_nav_mesh_start3");
  wait 3;
  iprintlnbold("Helis incoming!");
  maps\satfarm_code::waittillhelisdead(var_8);
  iprintlnbold("Helis down. The sat complex is up ahead.");
  common_scripts\utility::flag_set("player_move_valley2");
  maps\_utility::autosave_by_name("endvalley");
}

ambush_kill_ally() {
  foreach(var_1 in level.allytanks) {
    if(isDefined(var_1) && (var_1.script_friendname == "Brick" || var_1.script_friendname == "Babe Ruth")) {
      common_scripts\utility::array_thread(level.enemytanks, maps\satfarm_code::set_override_target, var_1);
      var_1 thread maps\satfarm_code::set_one_hit_kill();

      if(isDefined(var_1) && var_1.classname != "script_vehicle_corpse") {
        level.enemytanks[0] maps\satfarm_code::fire_now_on_vehicle(var_1);

        if(isDefined(var_1) && var_1.classname != "script_vehicle_corpse") {
          common_scripts\utility::flag_wait("kill_ally_now");

          if(isDefined(var_1) && var_1.classname != "script_vehicle_corpse")
            var_1 kill();
        }
      }
    }
  }

  iprintlnbold("Ambush!");
}

pop_smoke() {
  wait 0.5;
  iprintlnbold("Pop the smoke!");
  wait 0.5;
  var_0 = common_scripts\utility::getstructarray("ambush_smoke_screen", "targetname");
  common_scripts\utility::flag_set("ambush_reverse");

  foreach(var_2 in var_0) {
    level.playertank maps\satfarm_code::launch_smoke(var_2.origin);
    playFX(common_scripts\utility::getfx("smokescreen"), var_2.origin);
    wait(randomfloatrange(0.05, 0.25));
  }

  iprintlnbold("Reverse!");
}

c17_drops() {}

allyc17_right_waits() {
  self waittillmatch("single anim", "end");
  wait 0.05;
  self delete();
}