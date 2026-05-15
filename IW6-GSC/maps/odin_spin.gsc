/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_spin.gsc
*****************************************************/

spin_start() {
  maps\odin_util::move_player_to_start_point("start_odin_spin");
  level.player thread maps\odin::give_weapons();
  thread maps\odin_util::create_sliding_space_door("spin_door_blocker", 0.75, 0, 0, 0, "lock_spin_door_blocker", "unlock_spin_door_blocker");
  common_scripts\utility::flag_set("unlock_spin_door_blocker");
  thread prespawn_decomp_crates();
  wait 0.1;
  maps\odin_util::actor_teleport(level.ally, "odin_spin_ally_tp");
  thread maps\odin_intro::tweak_off_axis_player();
  thread maps\odin_escape::manage_earth("delete");
  thread maps\odin_fx::satellite_rcs_thrusters();
  level.decomp_door = thread maps\odin_util::create_sliding_space_door("spin_decomp_door", 0.3, 0.1, 0, 0, "lock_decomp_room", "open_decomp_room_door");
}

section_precache() {
  precacherumble("heavy_3s");
}

section_flag_init() {
  common_scripts\utility::flag_init("EarthSetupComplete");
  common_scripts\utility::flag_init("odin_start_spin_decomp_real");
  common_scripts\utility::flag_init("start_near_explosion_sequence");
  common_scripts\utility::flag_init("spin_start_exterior_dialogue");
  common_scripts\utility::flag_init("player_in_outside_spin");
  common_scripts\utility::flag_init("spin_approaching_enemies");
  common_scripts\utility::flag_init("spin_clear");
  common_scripts\utility::flag_init("stop_spinning_room");
  common_scripts\utility::flag_init("delete_spinning_room");
  common_scripts\utility::flag_init("open_decomp_room_door");
  common_scripts\utility::flag_init("lgt_flag_spin_over");
  common_scripts\utility::flag_init("player_is_decompressing");
  common_scripts\utility::flag_init("decomp_done");
  common_scripts\utility::flag_init("trigger_spacejump");
  common_scripts\utility::flag_init("stop_moving_sun");
  common_scripts\utility::flag_init("landed_on_satellite");
  common_scripts\utility::flag_init("spacejump_clear");
  common_scripts\utility::flag_init("player_linked_with_legs");
  common_scripts\utility::flag_init("spin_room_start_corpses");
  common_scripts\utility::flag_init("decomp_anim_VO_complete");
  common_scripts\utility::flag_init("hold_satellite_back_thrusters");
  common_scripts\utility::flag_init("cue_crates_decomp");
  common_scripts\utility::flag_init("playsound");
  common_scripts\utility::flag_init("lgt_spin_setup");
  common_scripts\utility::flag_init("player_spin_decomp_anim_done");
}

section_hint_string

spin_main() {
  spin_setup();
  thread spin_ally_logic();
  safe_hide_spin(1);
  thread spinning_room_geo_simple("stunnel_grp03_big_int_01", "simple_spin_aligned_rotator_org_1", -60, 18, (0, 0, 50));
  thread spinning_room_geo_simple("stunnel_grp04_big_int_01", "simple_spin_aligned_rotator_org_2", -40, 25, (0, 0, 50));
  thread spin_dialogue();
  odin_spin_room_logic();
  maps\_utility::delaythread(10, maps\odin_fx::fx_spin_fire_rods);
  thread spin_push_to_spacejump();
  common_scripts\utility::flag_wait("spin_clear");
  common_scripts\utility::flag_set("hold_satellite_back_thrusters");
  maps\_utility::stop_exploder("post_decomp_01");
  thread spin_cleanup();
  thread maps\_utility::autosave_by_name("spacejump_begin");
  common_scripts\utility::flag_wait("player_in_smash_range");
  common_scripts\utility::flag_set("spacejump_clear");
  common_scripts\utility::flag_set("objective_destroy_sat");
}

spin_setup() {
  common_scripts\utility::flag_set("lgt_spin_setup");
  thread spin_sat_and_earth_mover();
  thread spin_busted_module();
  thread spin_do_moving_debris("decomp_moving_debris", "odin_start_spin_decomp_real", 15);
  thread spin_do_moving_debris("spin_moving_debris", "odin_start_spin_decomp_real", 25, 14);
  thread spin_do_moving_prefab_debris("spin_moving_debris", "odin_start_spin_decomp_real", 25, 14);
  thread do_spacejump_debris("spacejump_debris_small");
  thread do_spacejump_debris("spacejump_debris_large");
  thread do_unique_debris();
  setsaveddvar("ragdoll_max_life", 90000);
}

spin_dialogue() {
  common_scripts\utility::flag_wait("odin_pre_decomp_dialog");
  maps\_utility::radio_dialogue_stop();
  common_scripts\utility::flag_wait("odin_start_spin_decomp");
  common_scripts\utility::flag_set("lock_spin_door_blocker");
  common_scripts\utility::flag_set("odin_start_spin_decomp_real");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("odin_kyr_argh_2");
  maps\_utility::smart_radio_dialogue("odin_kyr_lookout");
  wait 7.2;
  maps\_utility::smart_radio_dialogue("odin_shq_odincontrol");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("odin_kyr_ugh");
  maps\_utility::smart_radio_dialogue("odin_shq_odincontrolareyou");
  common_scripts\utility::flag_wait("decomp_anim_VO_complete");
  maps\_utility::smart_radio_dialogue("odin_kyr_mygod");
  maps\_utility::smart_radio_dialogue("odin_shq_targetingonpayloads3");
  common_scripts\utility::flag_wait("spin_start_exterior_dialogue");
  common_scripts\utility::flag_set("mus_odin_end");
  maps\_utility::smart_radio_dialogue("odin_shq_butpayload2is");
  maps\_utility::smart_radio_dialogue("odin_shq_odinpayload2targeting");
  maps\_utility::smart_radio_dialogue("odin_kyr_werenotdonebud");
  maps\_utility::smart_radio_dialogue("odin_kyr_letsmovetoodin");
  common_scripts\utility::flag_set("objective_destroy_sat");
  wait 0.7;
  maps\_utility::smart_radio_dialogue("odin_ast1_idontthinkwere");
}

odin_spin_room_logic() {
  common_scripts\utility::flag_wait("odin_start_spin_decomp_real");

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbFastEnable", 1);
    setsaveddvar("r_mbFastPreset", 0);
    setsaveddvar("r_mbCameraRotationInfluence", 0.6);
    setsaveddvar("r_mbCameraTranslationInfluence", 2.0);
    setsaveddvar("r_mbViewmodelVelocityScalar", 0.04);
    setsaveddvar("r_mbStaticVelocityScalar", 0.56);
    setsaveddvar("r_mbViewmodelEnable", 1);
  }

  thread hide_spent_rog_mag();

  if(isDefined(level.decomp_door)) {
    common_scripts\utility::flag_set("open_decomp_room_door");
  }

  var_0 = [];
  var_1 = [];
  var_0 = prespawn_decomp_enemies();
  var_2 = prespawn_decomp_legs();
  var_3 = [];
  wait 0.1;
  thread maps\odin_anim::spin_deadguys();
  common_scripts\utility::flag_set("start_near_explosion_sequence");
  var_4 = common_scripts\utility::getstruct("kyra_move_node02", "targetname");
  var_4 notify("stop_loop");
  maps\_utility::delaythread(1, maps\odin_escape::manage_earth, "hide");
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
  level notify("player_exited_escape_hallway");
  thread spin_colliders_go();
  common_scripts\utility::flag_set("cue_crates_decomp");
  thread maps\odin_anim::decomp_explosion_anim_ally();
  thread maps\odin_anim::decomp_explosion_anim_enemies(var_0);
  thread maps\odin_anim::decomp_explosion_anim_player_legs(var_2);
  thread maps\odin_fx::fx_spin_create_rog_plumes();
  wait 1.8;
  earthquake(0.3, 3, level.player.origin, 500);
  level.player playrumbleonentity("heavy_3s");
  maps\_utility::stop_exploder("escape_destruction");
  maps\_utility::stop_exploder("escape_destruction_ng");
  common_scripts\utility::exploder("spin_implosion");
  thread maps\odin_audio::sfx_odin_decompress_explode();

  if(isDefined(level.decomp_door)) {
    thread maps\odin_util::safe_delete_array(level.decomp_door.parts);
  }

  maps\_utility::vision_set_fog_changes("odin_implosion", 0.5);
  level thread maps\odin_fx::fx_spin_player_debris();
  wait 2.0;
  common_scripts\utility::exploder("spin_decompression");
  maps\_utility::vision_set_fog_changes("", 0.5);
  wait 4.4;
  maps\_utility::stop_exploder("spin_implosion");
  common_scripts\utility::flag_set("spin_room_start_corpses");
  wait 5.5;
  thread maps\odin_audio::sfx_spin_outside_zone();
  wait 0.5;
  thread maps\odin_audio::sfx_spin_emt();
  level waittill("decomp_player_anim_done");
  common_scripts\utility::flag_set("decomp_done");
  wait 0.1;
  level.play_shake_sound = 3;
  thread maps\odin_audio::sfx_play_weapon_up();
  thread maps\_utility::autosave_by_name("spin_outside");
  common_scripts\utility::flag_set("player_in_outside_spin");
  setsaveddvar("player_swimFriction", 1);
  setsaveddvar("player_swimWaterCurrent", (-500, 0, 0));
  thread maps\_utility::autosave_by_name("spin_begin");
  wait 2.4;
  common_scripts\utility::flag_set("spin_start_exterior_dialogue");
}

spin_colliders_go() {
  var_0 = getent("colliding_debris_node", "targetname");
  var_1 = [];
  var_1["space_crate_01_burned"] = maps\_utility::spawn_anim_model("space_crate_01_burned");
  var_1["space_debris_01"] = maps\_utility::spawn_anim_model("space_debris_01");
  var_1["space_debris_02"] = maps\_utility::spawn_anim_model("space_debris_02");
  var_1["airplane_debris_destroyed_03_iw6a"] = maps\_utility::spawn_anim_model("airplane_debris_destroyed_03_iw6a");
  var_1["airplane_debris_destroyed_03_iw6b"] = maps\_utility::spawn_anim_model("airplane_debris_destroyed_03_iw6b");
  var_0 maps\_anim::anim_first_frame(var_1, "sat_colliders_go");
  common_scripts\utility::flag_wait("player_spin_decomp_anim_done");
  var_0 maps\_anim::anim_single(var_1, "sat_colliders_go");

  foreach(var_3 in var_1) {
    var_4 = randomfloatrange(300, 800);
    var_5 = randomfloatrange(100, 300);
    var_6 = randomfloatrange(-360, 360);
    var_7 = common_scripts\utility::spawn_tag_origin();
    var_7.origin = var_3.origin;
    var_3 linkto(var_7);
    var_7 moveto((var_7.origin[0] + 0, var_7.origin[1] + var_4, var_7.origin[2] + var_5), 10, 0, 10);
    var_7 rotateby((var_6, var_6, var_6), 10, 0, 10);
    level.sat_ent_del[level.sat_ent_del.size] = var_7;
    level.sat_ent_del[level.sat_ent_del.size] = var_3;
  }

  var_0 delete();
}

hide_spent_rog_mag() {
  var_0 = getEntArray("sat_ROGS", "script_noteworthy");
  var_0[1] hide();
}

spin_ally_logic() {
  level.ally.script_accuracy = 0.001;
  level.ally.ignoreme = 1;
  level.ally.ignoreall = 1;
  common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
  maps\odin_util::safe_trigger_by_targetname("start_ally_spin_pathing");
  level.ally maps\_utility::enable_ai_color();
  common_scripts\utility::flag_wait("disable_kyra_leader");
  level.ally maps\_utility::disable_ai_color();
  var_0 = getnode("spacejump_final_goal", "targetname");
  level.ally setgoalnode(var_0);
}

prespawn_decomp_enemies() {
  var_0 = maps\odin_util::spawn_odin_actor_array("decomp_enemy", 1);

  foreach(var_2 in var_0) {
    var_2.animname = "generic";
    var_2.goalradius = 0;
    var_2.allowdeath = 1;
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.dontevershoot = 1;
    var_2.diequietly = 1;
    var_2.health = 1000;
  }

  return var_0;
}

prespawn_decomp_legs() {
  var_0 = maps\_utility::spawn_anim_model("decomp_legs");
  var_0 hide();
  var_0.animname = "decomp_legs";
  var_0 maps\_utility::assign_animtree("decomp_legs");
  return var_0;
}

prespawn_decomp_crates() {
  var_0 = getent("odin_decomp_anim", "targetname");
  var_1 = getent("spin_decomp_container_01", "targetname");
  prepare_crates_for_anim(var_1, "decomp_crate_01");
  var_2 = getent("spin_decomp_container_02", "targetname");
  prepare_crates_for_anim(var_2, "decomp_crate_02");
  var_3 = getent("spin_decomp_container_03", "targetname");
  prepare_crates_for_anim(var_3, "decomp_crate_03");
  var_4 = [];
  var_4["space_storage_container_01"] = maps\_utility::spawn_anim_model("space_storage_container_01");
  var_4["space_ata_box"] = maps\_utility::spawn_anim_model("space_ata_box");
  var_4["decomp_crate_01"] = var_1;
  var_4["decomp_crate_02"] = var_2;
  var_4["decomp_crate_03"] = var_3;
  link_bags_to_spin_crates("spin_decomp_bags_1", var_4["decomp_crate_01"]);
  link_bags_to_spin_crates("spin_decomp_bags_2", var_4["decomp_crate_02"]);
  link_bags_to_spin_crates("spin_decomp_bags_3", var_4["decomp_crate_03"]);

  foreach(var_6 in var_4) {
    level.sat_ent_del[level.sat_ent_del.size] = var_6;
  }

  var_0 maps\_anim::anim_first_frame(var_4, "decompression_props");
  common_scripts\utility::flag_wait("cue_crates_decomp");
  thread maps\odin_anim::decomp_explosion_anim_props(var_4);
}

prepare_crates_for_anim(var_0, var_1) {
  var_0 maps\_utility::assign_animtree(var_1);
  var_0.animname = var_1;
}

link_bags_to_spin_crates(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    level.sat_ent_del[level.sat_ent_del.size] = var_4;
    var_4 linkto(var_1);
  }
}

prespawn_decomp_panels() {
  var_0 = [];
  var_0[0] = getent("decomp_anim_panel_01", "targetname");
  var_0[1] = getent("decomp_anim_panel_02", "targetname");
  var_0[2] = getent("decomp_anim_panel_03", "targetname");
  var_0[3] = getent("decomp_anim_panel_04", "targetname");
  var_0[4] = getent("decomp_anim_panel_05", "targetname");
  var_0[5] = getent("decomp_anim_panel_06", "targetname");
  var_1 = [];
  var_1[0] = maps\_utility::spawn_anim_model("decomp_pannel_01", var_0[0].origin);
  var_1[1] = maps\_utility::spawn_anim_model("decomp_pannel_02", var_0[1].origin);
  var_1[2] = maps\_utility::spawn_anim_model("decomp_pannel_03", var_0[2].origin);
  var_1[3] = maps\_utility::spawn_anim_model("decomp_pannel_04", var_0[3].origin);
  var_1[4] = maps\_utility::spawn_anim_model("decomp_pannel_05", var_0[4].origin);
  var_1[5] = maps\_utility::spawn_anim_model("decomp_pannel_06", var_0[5].origin);
  var_1[0].angles = var_0[0].angles;
  var_1[1].angles = var_0[1].angles;
  var_1[2].angles = var_0[2].angles;
  var_1[3].angles = var_0[3].angles;
  var_1[4].angles = var_0[4].angles;
  var_1[5].angles = var_0[5].angles;

  foreach(var_8, var_3 in var_0) {
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      var_6 linkto(var_1[var_8]);
    }

    var_3 linkto(var_1[var_8]);
  }

  return var_1;
}

spin_cleanup(var_0) {
  if(!isDefined(var_0)) {
    common_scripts\utility::flag_wait("kickoff_player_finale");
    wait 3.0;
  }

  wait 0.2;
  common_scripts\utility::flag_set("stop_spinning_room");
  level notify("stop_weapon_drop_scripts");
  level notify("stop_spinning_debris");
  maps\odin_util::safe_delete_noteworthy("spin_trigger");
  maps\odin_util::safe_delete_noteworthy("spin_spawner");
  maps\odin_util::safe_delete_noteworthy("spin_ents");
  maps\odin_util::safe_delete_noteworthy("spin_parts");
  maps\odin_util::safe_delete_noteworthy("flying_debris_sparks");
  maps\odin_util::safe_delete_noteworthy("flying_debris_fire");
  maps\odin_util::safe_delete_noteworthy("flying_debris_sparks_metal");
  maps\odin_util::safe_delete_noteworthy("flying_debris_sparks_fire_metal");
  maps\odin_util::safe_delete_noteworthy("spacejump_ent");
  maps\odin_util::safe_delete_targetname("spacejump_debris_small");
  maps\odin_util::safe_delete_targetname("spacejump_debris_large");
}

spinning_room_geo_simple(var_0, var_1, var_2, var_3, var_4) {
  level.spinning_room_parts = [];
  var_5 = getent(var_1, "targetname");
  var_6 = getEntArray(var_0, "targetname");

  foreach(var_8 in var_6) {
    var_8 linkto(var_5);
  }

  var_10 = getent("spin_geo_final_pos", "targetname");
  var_5 moveto(var_10.origin, 0.1);
  var_5 waittill("movedone");
  common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
  common_scripts\utility::exploder("spin02_airlock_breach_steam01");
  level endon("stop_spinning_room");
  var_5.angles = var_5.angles + var_4;

  for(;;) {
    var_5 rotateroll(var_2 * 6, var_3 * 6);
    var_5 waittill("rotatedone");
  }
}

spin_busted_module() {
  level endon("spin_clear");
  var_0 = getEntArray("spin_busted_module", "targetname");
  var_1 = getent("busted_module_path1", "targetname");
  var_2 = getent("busted_module_path2", "targetname");

  foreach(var_4 in var_0) {
    var_4 linkto(var_1);
  }

  common_scripts\utility::flag_wait("playsound");
  common_scripts\utility::flag_wait("spin_approaching_enemies");
  var_1 moveto(var_2.origin, 95, 3, 0.1);
  var_1 rotatevelocity((1.75, 0, 0.8), 90, 0.1, 0.1);

  while(!common_scripts\utility::flag("spin_clear")) {
    thread maps\odin_audio::sfx_distant_explo(level.player);
    playFX(level._effect["spc_explosion_240"], var_1.origin);
    wait(randomfloatrange(2.0, 8.0));
  }
}

spin_push_to_spacejump() {
  level.forwardpush = -1600;
  thread adjust_forward_push();
  var_0 = 10;
  var_1 = getent("spin_push_desired_pos", "targetname");
  var_2 = var_1.origin[1];
  var_3 = var_1.origin[2];
  level.spin_allowance_y = 40;
  level.spin_allowance_z = 40;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 80;
  var_9 = level.ally.moveplaybackrate;
  level.ally.moveplaybackrate = 2;
  var_10 = getent("spin_skybox_rotator", "targetname");
  var_11 = 5;
  var_12 = getent("box_animNode", "script_noteworthy");
  var_13 = getent("spin_deadguy_static_node_05", "targetname");

  for(;;) {
    if(level.player.origin[1] < var_2 - level.spin_allowance_y) {
      var_4 = 0 - (level.player.origin[1] - var_2 + level.spin_allowance_y) * var_0;
    } else if(level.player.origin[1] > var_2 + level.spin_allowance_y) {
      var_4 = 0 - (level.player.origin[1] - var_2 - level.spin_allowance_y) * var_0;
    } else {
      var_4 = 0;
    }

    if(level.player.origin[2] < var_3 - level.spin_allowance_z) {
      var_5 = 0 - (level.player.origin[2] - var_3 + level.spin_allowance_z) * var_0;
    } else if(level.player.origin[2] > var_3 + level.spin_allowance_z) {
      var_5 = 0 - (level.player.origin[2] - var_3 - level.spin_allowance_z) * var_0;
    } else {
      var_5 = 0;
    }

    if(var_4 > 20000) {
      var_4 = 20000;
    }

    if(var_4 < -20000) {
      var_4 = -20000;
    }

    if(var_5 > 20000) {
      var_5 = 20000;
    }

    if(var_5 < -20000) {
      var_5 = -20000;
    }

    if(var_4 == 0 && (var_6 < 200 || var_6 > -200)) {
      var_6 = 0;
    } else if(var_6 > var_4) {
      var_6 = var_6 - 100;
    } else {
      var_6 = var_6 + 100;
    }

    if(var_5 == 0 && (var_7 < 200 || var_7 > -200)) {
      var_7 = 0;
    } else if(var_7 > var_5) {
      var_7 = var_7 - 100;
    } else {
      var_7 = var_7 + 100;
    }

    setsaveddvar("player_swimWaterCurrent", (level.forwardpush, var_6, var_7));

    if(common_scripts\utility::flag("spin_clear")) {
      var_2 = var_12.origin[1];
      var_3 = var_12.origin[2];

      if(level.player.origin[0] > var_12.origin[0] + 1500) {
        if(var_11 < 10) {
          var_11 = var_11 + 0.03;
        }

        var_10 movex(var_11, 0.05, 0, 0);
      } else
        common_scripts\utility::flag_set("spacejump_clear");
    }

    if(common_scripts\utility::flag("landed_on_satellite") || common_scripts\utility::flag("disable_push_current")) {
      break;
    }

    var_14 = distance(var_12.origin, level.player.origin);

    if(level.player.origin[0] <= var_13.origin[0]) {
      if(!common_scripts\utility::flag("disable_kyra_leader")) {
        level.ally.moveplaybackrate = 3;
      } else {
        level.ally.moveplaybackrate = 1;
      }

      if(var_14 >= 1000) {
        var_8 = 80;
        level.forwardpush = level.forwardpush - 300;

        if(level.forwardpush <= -9000) {
          level.forwardpush = -9000;
        }
      }

      if(var_14 >= 750 && var_14 < 1000) {
        var_8 = 75;
        level.forwardpush = level.forwardpush - 300;

        if(level.forwardpush <= -6500) {
          level.forwardpush = -6500;
        }
      }

      if(var_14 >= 500 && var_14 < 750) {
        level.forwardpush = level.forwardpush - 300;

        if(level.forwardpush <= -5000) {
          level.forwardpush = -5000;
        }
      }

      if(var_14 >= 250 && var_14 < 500) {
        var_8 = 70;
        level.forwardpush = level.forwardpush - 300;

        if(level.forwardpush <= -2800) {
          level.forwardpush = -2800;
        }
      }

      if(var_14 >= 0 && var_14 < 250) {
        level.forwardpush = level.forwardpush - 300;

        if(level.forwardpush <= -2000) {
          level.forwardpush = -2000;
        }
      }
    }

    setsaveddvar("player_swimSpeed", var_8);

    if(var_14 <= 128 || level.player.origin[0] < -9850) {
      var_15 = 1;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("landed_on_satellite");
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
}

adjust_forward_push() {
  var_0 = getent("ally_shooting_target", "script_noteworthy");
  common_scripts\utility::flag_wait("spin_approaching_enemies");
  level.forwardpush = -1900;
  wait 2;
  level.forwardpush = -2200;
  common_scripts\utility::flag_wait("spin_clear");
  level.forwardpush = -4000;
  level.spin_allowance_y = 1820;
  level.spin_allowance_z = 1520;

  while(level.player.origin[0] > var_0.origin[0] + 5500) {
    wait 0.05;
  }

  level.spin_allowance_y = 1200;
  level.spin_allowance_z = 1000;

  while(level.player.origin[0] > var_0.origin[0] + 3000) {
    wait 0.05;
  }

  level.spin_allowance_y = 600;
  level.spin_allowance_z = 400;

  while(level.player.origin[0] > var_0.origin[0] + 2200) {
    wait 0.05;
  }

  level.spin_allowance_y = 155;
  level.spin_allowance_z = 100;

  while(level.player.origin[0] > var_0.origin[0] + 1500) {
    wait 0.05;
  }

  common_scripts\utility::flag_set("spacejump_clear");
  level.forwardpush = 0;
}

spin_sat_and_earth_mover(var_0) {
  var_1 = maps\odin_util::satellite_get_script_mover();
  var_1 unlink();
  var_2 = maps\odin_util::earth_get_script_mover();
  var_3 = getent("spin_skybox_rotator", "targetname");
  var_4 = getent("sunflare_origin", "targetname");
  var_5 = getent("space_mover", "targetname");
  var_6 = getent("initial_sat_orientation", "targetname");
  var_7 = getent("spin_earth_front_pos", "targetname");
  var_8 = 20;

  if(!isDefined(var_3) || !isDefined(var_5) || !isDefined(var_2)) {
    return;
  }
  var_1 moveto(var_6.origin, 0.1);
  var_1 rotateto(var_6.angles, 0.1);
  wait 0.2;

  if(!isDefined(var_0)) {
    common_scripts\utility::flag_wait("start_near_explosion_sequence");
  }

  var_1 unlink();
  wait 0.05;
  var_9 = getent("spin_aligned_rotator_org", "targetname");
  var_5 linkto(var_9);
  var_1 linkto(var_9);
  var_2 linkto(var_9);
  var_10 = 400;
  var_9 rotateroll(var_10 * -1, 0.1);
  var_9 waittill("rotatedone");
  var_11 = 25;

  if(isDefined(var_0)) {
    var_11 = 1;
  }

  if(!isDefined(var_0)) {
    wait 3.5;
  }

  var_9 rotateroll(var_10, var_11, 0.1, var_11 * 0.8);
  var_9 waittill("rotatedone");
  var_9 unlink();
  var_9 delete();
  var_5 unlink();
  var_11 = 17;

  if(isDefined(var_0)) {
    var_11 = 1;
  }

  var_12 = var_11 * 0.1;
  var_13 = var_11 * 0.5;
  var_5 linkto(var_2);
  var_2 moveto(var_7.origin, var_11, var_12, var_13);
  var_2 rotateto(var_7.angles, var_11, var_12, var_13);
  var_14 = getent("final_sat_orientation", "targetname");
  var_1 moveto(var_14.origin, var_11, var_12, var_13);
  var_1 rotateto(var_14.angles, var_11, var_12, var_13);
  var_1 waittill("rotatedone");
  common_scripts\utility::flag_set("lgt_flag_spin_over");
}

safe_hide_spin(var_0) {
  var_1 = [];
  var_2 = getEntArray("spin_parts", "script_noteworthy");
  var_3 = getEntArray("flying_debris_sparks", "script_noteworthy");
  var_4 = getEntArray("flying_debris_sparks_metal", "script_noteworthy");
  var_5 = getEntArray("flying_debris_fire", "script_noteworthy");
  var_6 = getEntArray("flying_debris_sparks_fire_metal", "script_noteworthy");
  var_7 = common_scripts\utility::array_combine(var_1, var_2);
  var_8 = common_scripts\utility::array_combine(var_3, var_4);
  var_9 = common_scripts\utility::array_combine(var_5, var_6);
  var_10 = common_scripts\utility::array_combine(var_7, var_8);
  var_11 = common_scripts\utility::array_combine(var_9, var_10);
  var_12 = common_scripts\utility::array_combine(var_10, var_11);

  foreach(var_14 in var_12) {
    if(isDefined(var_14)) {
      if(isDefined(var_0)) {
        var_14 show();
        continue;
      }

      var_14 hide();
    }
  }
}

spin_do_moving_debris(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "targetname");
  var_5 = var_2;
  var_6 = 0;
  var_7 = 25;
  var_8 = 75;
  common_scripts\utility::flag_wait(var_1);

  if(isDefined(var_3)) {
    wait(var_3);
  }

  foreach(var_10 in var_4) {
    if(isDefined(var_10.target)) {
      var_11 = getent(var_10.target, "targetname");

      if(isDefined(var_11)) {
        var_12 = var_5;
        var_13 = randomfloatrange(15.0, 45.0);
        var_14 = randomfloatrange(6.0, 18.0);
        var_15 = randomfloatrange(0.2, 0.55);

        if(common_scripts\utility::cointoss()) {
          var_13 = var_13 * -1;
        }

        if(common_scripts\utility::cointoss()) {
          var_14 = var_14 * -1;
        }

        if(common_scripts\utility::cointoss()) {
          var_15 = var_15 * -1;
        }

        var_10 thread spin_do_moving_debris_fx(var_10.origin, var_11.origin, var_12);
        var_10 moveto(var_11.origin, var_12);
        var_16 = randomint(3);

        if(var_16 == 0) {
          var_10 thread spin_debris_rotation(var_13, var_15, var_14);
        } else if(var_16 == 1) {
          var_10 thread spin_debris_rotation(var_14, var_13, var_15);
        } else if(var_16 == 2) {
          var_10 thread spin_debris_rotation(var_15, var_14, var_13);
        }
      }
    }
  }
}

spin_do_moving_prefab_debris(var_0, var_1, var_2, var_3) {
  var_4 = 15;
  var_5 = var_2;
  var_6 = 0;
  var_7 = [];

  for(var_8 = 1; var_8 <= var_4; var_8++) {
    if(var_8 < 10) {
      var_9 = "0" + var_8;
    } else {
      var_9 = "" + var_8;
    }

    var_10 = var_0 + "_" + var_9;
    var_11 = getEntArray(var_10, "targetname");

    if(!isDefined(var_11) || var_11.size == 0) {
      continue;
    }
    var_12 = var_11[0];
    var_12.target = var_10 + "_node";

    foreach(var_14 in var_11) {
      if(var_14 != var_12) {
        var_14 linkto(var_12);
      }
    }

    var_7[var_7.size] = var_12;
    wait 0.1;
  }

  if(var_7.size == 0) {
    return;
  }
  common_scripts\utility::flag_wait(var_1);

  if(isDefined(var_3)) {
    wait(var_3);
  }

  foreach(var_17 in var_7) {
    if(isDefined(var_17.target)) {
      var_18 = getent(var_17.target, "targetname");

      if(!isDefined(var_18)) {
        continue;
      }
      var_19 = var_5;
      var_20 = randomfloatrange(15.0, 45.0);
      var_21 = randomfloatrange(6.0, 18.0);
      var_22 = randomfloatrange(0.2, 0.55);

      if(common_scripts\utility::cointoss()) {
        var_20 = var_20 * -1;
      }

      if(common_scripts\utility::cointoss()) {
        var_21 = var_21 * -1;
      }

      if(common_scripts\utility::cointoss()) {
        var_22 = var_22 * -1;
      }

      var_17 moveto(var_18.origin, var_19);
      var_23 = randomint(3);

      if(var_23 == 0) {
        var_17 thread spin_debris_rotation(var_20, var_22, var_21);
      } else if(var_23 == 1) {
        var_17 thread spin_debris_rotation(var_21, var_20, var_22);
      } else if(var_23 == 2) {
        var_17 thread spin_debris_rotation(var_22, var_21, var_20);
      }
    }
  }
}

spin_do_moving_debris_fx(var_0, var_1, var_2) {
  wait 4.0;

  if(self.script_noteworthy != "spin_parts") {
    var_3 = common_scripts\utility::getfx("spc_fire_puff_bigger_light");

    if(self.script_noteworthy == "flying_debris_sparks") {
      thread spin_piece_sparks();
    }

    if(self.script_noteworthy == "flying_debris_fire") {
      thread spin_piece_fire(var_0, var_1);
    }

    if(self.script_noteworthy == "flying_debris_sparks_metal") {
      thread spin_piece_pieces();
      thread spin_piece_sparks();
    }

    if(self.script_noteworthy == "flying_debris_sparks_fire_metal") {
      thread spin_piece_sparks();
      thread spin_piece_fire(var_0, var_1);
      thread spin_piece_pieces();
      return;
    }
  } else {
    wait(var_2 * randomfloatrange(0.2, 0.5));
    var_4 = common_scripts\utility::spawn_tag_origin();
    var_4.origin = self.origin;
    var_5 = var_0 - var_1;
    var_4.angles = vectortoangles(var_5);
    var_4 linkto(self);
    wait(var_2 * randomfloatrange(0.2, 0.4));
    playFXOnTag(level._effect["odin_spin_piece_debris_runner"], var_4, "tag_origin");
    wait 3;
    stopFXOnTag(level._effect["odin_spin_piece_debris_runner"], var_4, "tag_origin");
    var_4 delete();
  }
}

spin_piece_fire(var_0, var_1) {
  self endon("death");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_3 = var_0 - var_1;
  var_2.angles = vectortoangles(var_3);
  playFXOnTag(common_scripts\utility::getfx("spc_fire_big_light"), var_2, "tag_origin");

  for(var_4 = 0; var_4 < 300; var_4++) {
    var_2.origin = self.origin;
    common_scripts\utility::waitframe();
  }

  stopFXOnTag(common_scripts\utility::getfx("spc_fire_big_light"), var_2, "tag_origin");
  var_2 delete();
}

spin_piece_sparks() {
  self endon("death");

  for(var_0 = 0; var_0 < 70; var_0++) {
    playFX(common_scripts\utility::getfx("zg_electrical_sparks_big_single_runner"), self.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20)));
    wait(randomfloatrange(0.1, 0.4));
  }
}

spin_piece_pieces() {
  self endon("death");

  for(var_0 = 0; var_0 < 128; var_0++) {
    playFX(level._effect["odin_spin_piece_debris"], self.origin);
    wait(randomfloatrange(0.05, 0.2));
  }
}

do_unique_debris() {
  var_0 = 400;
  var_1 = getent("spin_unique_debris_reaching_guy", "targetname");
  var_2 = getEntArray(var_1.target, "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_1)) {
      var_4 linkto(var_1);
      var_1 rotatevelocity((0, 0, 12), var_0);
    }
  }

  var_1 = getent("spin_unique_debris_rotating_01", "targetname");

  if(isDefined(var_1)) {
    var_1 rotatevelocity((10, 0, 0), var_0);
  }

  var_1 = getent("spin_unique_debris_rotating_02", "targetname");

  if(isDefined(var_1)) {
    var_1 rotatevelocity((0, 24, 0), var_0);
  }

  var_1 = getent("spin_unique_debris_rotating_03", "targetname");

  if(isDefined(var_1)) {
    var_1 rotatevelocity((0, 0, 14), var_0);
  }

  var_1 = getent("spin_unique_debris_rotating_05", "targetname");

  if(isDefined(var_1)) {
    var_1 rotatevelocity((6, 0, 0), var_0);
  }
}

do_spacejump_debris(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "script_origin") {
      var_4 = getEntArray(var_3.script_linkto, "script_linkname");

      foreach(var_6 in var_4) {
        var_6 linkto(var_3);
      }

      var_8 = randomfloatrange(15.0, 45.0);
      var_9 = randomfloatrange(6.0, 18.0);
      var_10 = randomfloatrange(0.2, 0.55);

      if(common_scripts\utility::cointoss()) {
        var_8 = var_8 * -1;
      }

      if(common_scripts\utility::cointoss()) {
        var_9 = var_9 * -1;
      }

      if(common_scripts\utility::cointoss()) {
        var_10 = var_10 * -1;
      }

      var_11 = randomint(3);

      if(var_11 == 0) {
        var_3 thread spin_debris_rotation(var_8, var_10, var_9);
      } else if(var_11 == 1) {
        var_3 thread spin_debris_rotation(var_9, var_8, var_10);
      } else if(var_11 == 2) {
        var_3 thread spin_debris_rotation(var_10, var_9, var_8);
      }
    }
  }
}

decomp_anim_line_1(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_kyr_houston");
}

decomp_anim_line_2(var_0) {
  maps\_utility::radio_dialogue_stop();
  maps\_utility::smart_radio_dialogue("odin_kyr_houstonbudandi");
  common_scripts\utility::flag_set("decomp_anim_VO_complete");
}

spin_debris_rotation(var_0, var_1, var_2) {
  self endon("death");
  level endon("stop_spinning_debris");
  var_3 = var_0 / 10.0;
  var_4 = var_1 / 10.0;
  var_5 = var_2 / 10.0;

  for(;;) {
    var_6 = combineangles(self.angles, (var_3, var_4, var_5));
    self rotateto(var_6, 0.1);
    wait 0.05;
  }
}