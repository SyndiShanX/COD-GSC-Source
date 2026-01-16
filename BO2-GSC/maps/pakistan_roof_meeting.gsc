/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_roof_meeting.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\pakistan_util;
#include maps\_glasses;
#include maps\_scene;
#include maps\_turret;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_music;
#include maps\_osprey;
#include maps\_anim;
#include maps\_patrol;
#include maps\pakistan_anthem;
#include maps\_audio;
#include maps\createart\pakistan_2_art;
#include maps\_empgrenade;

skipto_roof_meeting() {
  iprintln("Roof Meeting");

  level.harper = init_hero("harper");
  level.menendez = init_hero("menendez");
  level.defalco = init_hero("defalco");
  level thread run_scene("harper_path3_idle");
  level.player setlowready(1);
  trigger_use("trigger_vtol");
  a_courtyard_enemies = [];

  for(i = 0; i < 4; i++)
    a_courtyard_enemies[i] = simple_spawn_single("anthem_courtyard_soldiers" + i);

  maps\_patrol::patrol_init();
  level.harper set_ignoreme(1);
  level.harper set_ignoreall(1);
  level.menendez set_ignoreme(1);
  level.menendez set_ignoreall(1);
  hide_post_grenade_room();
  maps\pakistan_anthem::setup_doors();
  level thread run_scene("rooftop_meeting_idle");
  level thread run_scene("rooftop_meeting_soldiers2_idle");
  level thread run_scene("rooftop_meeting_soldiers3_idle");
  level thread run_scene("rooftop_meeting_soldiers45_idle");
  level thread run_scene("rooftop_meeting_soldiers67_idle");
  level thread run_scene("rooftop_meeting_talkers_idle");

  foreach(ai_soldier in getentarray("anthem_helipad_soldiers_ai", "targetname"))
  ai_soldier set_ignoreall(1);

  level thread courtyard_sounds();
  skipto_teleport("skipto_roof_meeting", array(level.harper));
  level thread maps\pakistan_anthem::anthem_objectives();
  level thread run_scene("harper_path3_idle");
  level.harper thread maps\pakistan_anthem::harper_anim_blends();
  flag_set("anthem_grapple_idle_body_started");
  flag_set("delete_rope_harper");
  flag_set("spawn_rooftop_guard");
  flag_set("rooftop_clear");
  flag_set("anthem_facial_recognition_complete");
  level thread skipto_handle_xcam();
  level thread skipto_surveillance();
  level thread drone_punishment();
  level.player enableweapons();
}

skipto_handle_xcam() {
  maps\pakistan_anthem::turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("meeting_over");
  wait 11;
  maps\pakistan_anthem::turn_off_xcam();
  stop_surveillance();
  flag_wait("railyard_drone_meeting_room_entered");
  wait 1;
  maps\pakistan_anthem::turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("train_arrived");
  maps\pakistan_anthem::turn_off_xcam();
  stop_surveillance();
}

skipto_surveillance() {
  flag_set("xcam_off");
  flag_set("anthem_facial_recognition_complete");
  luinotifyevent(&"hud_pak_surveillance");
}

skipto_gaz_melee() {
  level thread load_gump("pakistan_2_gump_anthem");
  level.harper = init_hero("harper");
  level.harper change_movemode("cqb_run");
  e_door_clip = getent("drone_entrance_collision", "targetname");
  e_door_clip notsolid();
  e_door = getent("drone_entrance", "targetname");
  e_door notsolid();
  skipto_teleport("skipto_gaz_melee", array(level.harper));
  level thread maps\pakistan_anthem::anthem_objectives();
  level.player enableweaponcycling();
  level.player enableweaponfire();
  level.player setlowready(1);
  flag_set("xcam_off");
  flag_set("rooftop_meeting_harper_hide");
  flag_set("anthem_grapple_idle_body_started");
  flag_set("delete_rope_harper");
  flag_set("spawn_rooftop_guard");
  flag_set("rooftop_clear");
  flag_set("anthem_facial_recognition_complete");
  flag_set("harper_path4_started");
  level.harper thread maps\pakistan_anthem::harper_anim_blends();
  flag_set("anthem_grapple_started");
  flag_set("confirm_menendez_exit_started");
  flag_set("harper_path1_started");
  flag_set("harper_path2_climb_started");
  flag_set("harper_path4_started");
  flag_set("harper_path4_hide_exit_started");
  flag_set("harper_path4_hide_exit_done");
  flag_set("trainyard_melee_harper_cross_bridge_started");
  flag_set("jump_down_attack_harper_started");
  level.player setlowready(1);
  level.player enableweapons();
  level.harper set_ignoreall(1);
  level thread gaz_melee_xcam_skipto();
}

gaz_melee_xcam_skipto() {
  flag_wait("railyard_drone_meeting_room_entered");
  wait 1;
  maps\pakistan_anthem::turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("train_arrived");
  stop_surveillance();
  maps\pakistan_anthem::turn_off_xcam();
  level.harper set_ignoreall(0);
}

skipto_underground() {
  iprintln("Underground");

  maps\_patrol::patrol_init();
  level.harper = init_hero("harper");
  level.menendez = init_hero("menendez");
  level.defalco = init_hero("defalco");
  level.harper change_movemode("cqb_run");
  level.player thread watch_water_vision();
  level.player setlowready(1);
  level.player enableweapons();
  level.harper thread underground_harper_pathing();
  maps\pakistan_anthem::setup_doors();
  hide_post_grenade_room();
  level thread trainyard_light_on();
  level thread underwater_physics_activate();
  level thread maps\pakistan_anthem::anthem_objectives();
  level thread set_water_dvars_swim_section();
  flag_set("xcam_off");
  flag_set("rooftop_meeting_harper_hide");
  flag_set("salazar_vo_claw_positioned");
  flag_set("train_arrived");
  flag_set("anthem_grapple_idle_body_started");
  flag_set("delete_rope_harper");
  flag_set("spawn_rooftop_guard");
  flag_set("rooftop_clear");
  flag_set("anthem_facial_recognition_complete");
  flag_set("harper_path4_started");
  flag_set("rooftop_meeting_convoy_start");
  flag_set("trigger_jump_down");
  flag_set("trainyard_melee_finished");
  flag_set("trainyard_melee_harper_door_idle_started");
  flag_set("trainyard_drone_meeting_started");
  flag_set("trainyard_drone_meeting_done");
  setsaveddvar("player_waterSpeedScale", 0.65);
  skipto_teleport("skipto_underground", array(level.harper));
}

skipto_underground_xcam() {
  flag_wait("railyard_drone_meeting_room_entered");
  wait 1;
  turn_on_xcam();
  level thread surveillance_think(level.menendez);
  flag_wait("train_arrived");
  stop_surveillance();
  turn_off_xcam();
}

main() {
  rooftop_meeting_event();
}

rooftop_meeting_event() {
  level.defalco = init_hero("defalco");
  level.harper set_ignoreme(1);
  level.player set_ignoreme(1);
  level thread delete_scenes();
  level thread drone_control_room();
  level thread vo_roof_meeting();
  level thread start_defalco_helipad();
  level.harper thread rooftop_meeting_harper_pathing();
  level thread maps\_audio::switch_music_wait("PAK_ANTHEM_DEFALCO", 8);
  flag_set("rooftop_meeting_defalco_vo_start");
  addargus(level.defalco, "defalco");
  clientnotify("enable_argus");
  level thread id_defalco();
  level thread run_scene("rooftop_meeting");
  level thread run_scene("rooftop_meeting_militia");
  wait 3;
  luinotifyevent(&"hud_pak_poi_visibility", 2, level.menendez getentitynumber(), 1);
  flag_wait("rooftop_meeting_talkers_done");

  if(!flag("roof_meeting_defalco_identified")) {
    level notify("stop_defalco_id");
    level notify("stop_id");
    stop_id(level.defalco);
  } else
    stop_surveillance();

  clientnotify("disable_argus");
  flag_wait("osprey_away");
  flag_set("rooftop_meeting_harper_hide");
  level thread vo_exit_control_room();
  level thread autosave_by_name("rooftop_meeting_end");
  level thread start_ambient_drones_rooftop();
  setmusicstate("PAK_ANTHEM_HOT");
  flag_wait("drone_detection_end");
  flag_set("rooftop_meeting_harper_pursue");
}

id_defalco() {
  level endon("stop_defalco_id");
  luinotifyevent(&"hud_pak_add_poi", 2, level.defalco getentitynumber(), 2);
  stop_surveillance();
  flag_clear("anthem_facial_recognition_complete");
  level thread id_think(level.defalco, 60.0, 2.5, 0);
  flag_wait("anthem_facial_recognition_complete");
  flag_set("roof_meeting_defalco_identified");
}

start_defalco_helipad() {
  flag_wait("start_defalco_helipad");
  level thread run_scene("rooftop_meeting_defalco");
  level thread run_scene("rooftop_meeting_soldier1");
}

go_helipad_guys(guys) {
  level thread run_scene("rooftop_meeting_talkers");
  flag_wait("osprey_away");
  delete_scene_all("rooftop_meeting_defalco", 1);
  delete_scene_all("rooftop_meeting_soldier1", 1);
  delete_scene_all("rooftop_meeting_soldiers2_idle", 1);
  delete_scene_all("rooftop_meeting_soldiers3_idle", 1);
  delete_scene_all("rooftop_meeting_soldiers45", 1);
  delete_scene_all("rooftop_meeting_soldiers67_idle", 1);
  delete_scene_all("rooftop_meeting_talkers", 1);
}

drone_control_room() {
  s_drone = getstruct("anthem_drone_landing_end", "targetname");
  vh_drone = spawn_vehicle_from_targetname("anthem_courtyard_drone_ground");
  vh_drone.origin = s_drone.origin;
  vh_drone.angles = s_drone.angles;
  flag_wait("rooftop_meeting_started");
  vh_drone thread detection_event_drone_pathing();
  scene_wait("harper_path4");
  vh_drone thread check_control_room();
}

rooftop_meeting_harper_pathing() {
  level thread prevent_balcony_advance();
  self change_movemode("cqb_run");
  flag_wait("rooftop_meeting_harper_hide");
  wait 1;
  level thread player_dropdown_scaffolding();
  level thread run_scene("rooftop_exit_open");
  run_scene("harper_path4");
  flag_set("anthem_harper_vo_take_cover");
  run_scene("harper_path4_hide");
  level thread run_scene("harper_path4_hide_idle");
  flag_wait("rooftop_meeting_harper_pursue");
  end_scene("harper_path4_hide_idle");
}

prevent_balcony_advance() {
  level endon("harper_path4_hide_exit_done");
  trigger_wait("rooftop_pipeslide_approach_trigger");
  flag_set("alert_drones");
}

player_dropdown_scaffolding() {
  trigger_wait("trigger_dropdown_scaffold");
  level.player enableinvulnerability();
  wait 2;
  level.player disableinvulnerability();
}

gaz_melee_main() {
  drone_meeting_event();
}

drone_meeting_event() {
  level thread harper_pathing_gaz_melee();
  level thread clip_trainyard_door();
  run_scene_first_frame("trainyard_drone_meeting");
  run_scene_first_frame("trainyard_drone_meeting_gantry");
  trigger_off("train_interference_trigger", "script_noteworthy");
  trigger_wait("rooftop_melee_approach_trigger");
  level clientnotify("train");
  level thread observation_gaz_convoy_start();
  level thread trigger_jump_down_scene();
  level thread mantle_disable_gaz();
  level thread player_jump_down_gaz_melee();
  level thread autosave_by_name("observation_done");
  flag_wait("trigger_jump_down");
  level thread attach_trigger_gaz_victim();
  flag_set("railyard_melee_start");
  trigger_off("melee_drop_hurt_trigger", "targetname");
  trigger_off("melee_drop_hurt_trigger2", "targetname");

  if(flag("trainyard_melee_harper_cross_bridge_started") && !flag("trainyard_melee_harper_cross_bridge_done"))
    end_scene("trainyard_melee_harper_cross_bridge");

  if(flag("jump_down_approach_harper_started") && !flag("jump_down_approach_harper_done"))
    end_scene("jump_down_approach_harper");

  flag_wait("jump_down_player_done");
  level thread harper_and_gaz_scene();
  setsaveddvar("player_waterSpeedScale", 0.65);
  flag_wait("trainyard_melee_finished");
  level thread train_enter();
  getent("clip_gaz_melee", "targetname") delete();
  run_scene_first_frame("jump_down_gaz_idle");
  load_gump("pakistan_2_gump_escape");
  simple_spawn_single("trainyard_soldier1", ::trainyard_soldier_logic);
  simple_spawn_single("trainyard_soldier2", ::trainyard_soldier_logic);
  ai_guy5 = simple_spawn_single("confirm_menendez_soldiers");
  ai_guy5.animname = "trainyard_worker5";
  ai_guy6 = simple_spawn_single("confirm_menendez_soldiers");
  ai_guy6.animname = "trainyard_worker6";
  level thread run_scene("trainyard_worker1");
  level thread run_scene("trainyard_worker2");
  level thread run_scene("trainyard_worker3");
  level thread run_scene("trainyard_worker4");
  level thread run_scene("trainyard_worker5");
  level thread run_scene("trainyard_worker6");
  flag_wait("railyard_drone_meeting_room_entered");
  level thread spawn_trainyard_runners();
  level clientnotify("drone_sfx");
  level.menendez = init_hero("menendez");
  level.defalco = init_hero("defalco");
  level thread autosave_by_name("drone_meeting_start");
  level notify("courtyard_cleared");
  level.harper thread underground_harper_pathing();
  level thread run_scene("trainyard_drone_meeting_gantry");
  flag_wait_or_timeout("drone_meeting_window", 6);
  level thread run_scene("trainyard_drone_meeting");
  level thread check_vo_story_stat();
  flag_wait("train_arrived");
  luinotifyevent(&"hud_pak_end_surveillance");
  flag_set("salazar_vo_claw_positioned");
  wait 0.5;
  level thread trainyard_light_on();
  level.player thread watch_water_vision();
  level thread set_water_dvars_swim_section();
}

set_water_dvars_swim_section() {
  setdvar("r_waterwavespeed", "1 1 1 1");
  setdvar("r_waterwaveamplitude", "1.09857 0 0 0");
  setdvar("r_waterwavewavelength", "367.08 300.374 329.477 258.726");
  setdvar("r_waterwaveangle", "77.1716 0 0 0");
  setdvar("r_waterwavephase", "0 0 0 0");
  setdvar("r_waterwavesteepness", "1 1 1 1");
}

underwater_blockers() {
  m_clip_cart = getent("clip_cart", "targetname");
  m_clip_tv = getent("clip_tv", "targetname");
  e_cart = getent("industrial_cart", "targetname");
  e_tv = getent("av_cart", "targetname");
  m_clip_cart linkto(e_cart, "tag_origin");
  m_clip_tv linkto(e_tv, "tag_origin");
}

spawn_trainyard_runners() {
  simple_spawn_single("trainyard_runner", ::trainyard_runner_logic);
  wait 1.5;
  simple_spawn_single("trainyard_runner", ::trainyard_runner_logic);
}

trainyard_soldier_logic() {
  self endon("death");
  self.ignoreall = 1;
  flag_wait("millibar_vo_started");
  self delete();
}

trainyard_runner_logic() {
  self endon("death");
  self.animname = "generic";
  self set_run_anim("combat_jog", 1);
  self set_ignoreall(1);
  self.goalradius = 64;
  self waittill("goal");
  self delete();
}

check_vo_story_stat() {
  flag_wait("trainyard_drone_meeting_done");
  wait 2;

  if(level.stat_vo_check_1 && level.stat_vo_check_2a && level.stat_vo_check_2b && level.stat_vo_check_3) {
    level.player set_story_stat("ALL_PAKISTAN_RECORDINGS", 1);
    set_objective(level.obj_info_complete);
    set_objective(level.obj_info_complete, undefined, "done", undefined, 0);
    set_objective(level.obj_info_complete, undefined, "delete");
  } else if(level.info_recorded == 1) {
    set_objective(level.obj_info_incomplete1);
    set_objective(level.obj_info_incomplete1, undefined, "done", undefined, 0);
    set_objective(level.obj_info_incomplete1, undefined, "delete");
  } else if(level.info_recorded == 2) {
    set_objective(level.obj_info_incomplete2);
    set_objective(level.obj_info_incomplete2, undefined, "done", undefined, 0);
    set_objective(level.obj_info_incomplete2, undefined, "delete");
  }
}

trigger_jump_down_scene() {
  level endon("jump_down_player_done");
  t_trig = getent("trigger_jump_down_scene", "targetname");

  while(true) {
    trigger_wait("trigger_jump_down_scene");

    while(level.player istouching(t_trig)) {
      mantle_pressed = level.player jumpbuttonpressed();

      if(level.wiiu) {
        controller_type = level.player getcontrollertype();

        if(controller_type == "remote")
          mantle_pressed = mantle_pressed || level.player sprintbuttonpressed();
      }

      if(mantle_pressed) {
        setsaveddvar("mantle_enable", 0);
        flag_set("trigger_jump_down");
        level thread hide_player_ropes();
      }

      wait 0.05;
    }
  }
}

mantle_disable_gaz() {
  level endon("jump_down_player_done");
  t_anim = getent("trigger_jump_down_scene", "targetname");

  while(true) {
    trigger_wait("trigger_jump_down_scene");
    level.player allowjump(0);

    while(level.player istouching(t_anim))
      wait 0.05;

    level.player allowjump(1);
  }
}

player_jump_down_gaz_melee() {
  flag_wait("trigger_jump_down");
  setmusicstate("PAK_DROP_FROM_VAN");
  level thread harper_kill_gaz_driver();
  level thread run_scene("jump_down_player");
  flag_wait("jump_down_player_done");
  setsaveddvar("mantle_enable", 1);
  level.player allowjump(1);
  wait 0.05;
  level.player setlowready(1);
}

hide_player_ropes() {
  flag_wait("jump_down_player_started");
  e_body = get_model_or_models_from_scene("jump_down_player", "player_body");

  for(i = 1; i < 9; i++)
    e_body hidepart("jnt_rope_0" + i);

  e_body hidepart("jnt_hook");
  e_body hidepart("J_Snpr_Cbnr");
  e_body hidepart("J_Snpr_CbnrOpen");
  e_body hidepart("J_Snpr_Knot");

  for(i = 1; i < 4; i++)
    e_body hidepart("J_Snpr_RopeShort_0" + i);

  for(i = 1; i < 10; i++)
    e_body hidepart("J_Snpr_Rope_0" + i);

  for(i = 0; i < 3; i++)
    e_body hidepart("J_Snpr_Rope_1" + i);
}

harper_pathing_gaz_melee() {
  vh_tiger = spawn_vehicle_from_targetname("gaz_tiger");
  ai_guy1 = getent("gaz_guy_1", "targetname") spawn_ai(1);
  ai_guy2 = getent("gaz_guy_2", "targetname") spawn_ai(1);
  ai_guy1.animname = "gaz_guy_1";
  ai_guy2.animname = "gaz_guy_2";
  level thread gaz_tiger_interior();

  if(level.skipto_point == "gaz_melee") {
    level thread run_scene("jump_down_attack_gaz_idle");
    level thread run_scene("jump_down_attack_gaz_guard_idle");
  } else {
    run_scene("harper_path4_hide_exit");
    level thread run_scene("jump_down_attack_gaz_idle");
    level thread run_scene("jump_down_attack_gaz_guard_idle");

    if(!flag("jump_down_player_started"))
      run_scene("trainyard_melee_harper_cross_bridge");

    if(!flag("jump_down_player_started")) {
      level.harper anim_set_blend_in_time(0.2);
      run_scene("jump_down_approach_harper");
      run_scene("jump_down_preidle_harper");
    }
  }

  exploder(820);
  vh_gaz = getent("gaz_tiger", "targetname");

  if(isDefined(vh_gaz))
    vh_gaz thread tiger_headlights_on();

  if(!flag("jump_down_player_started")) {
    run_scene("jump_down_preidle_harper");
    level thread run_scene("jump_down_idle_harper");
    wait 2;

    if(!flag("jump_down_player_started")) {
      run_scene("jump_down_signal_harper");

      if(!flag("jump_down_player_started")) {
        run_scene("jump_down_preidle_harper");
        level thread run_scene("jump_down_idle_harper");
      }
    }
  }

  e_door_coll = getent("lab_door_collision", "targetname");
  e_door = getent("drone_entrance", "targetname");
  e_door_coll linkto(e_door, "door_hinge_jnt");
  flag_set("railyard_melee_ready");
  flag_wait("jump_down_attack_harper_done");
  run_scene_first_frame("trainyard_drone_meeting_cart_exit");
  level thread vision_interrogation_handler();
  level thread run_scene("trainyard_melee_harper_door_open");
  flag_wait("trainyard_melee_harper_door_open_started");
  run_scene("trainyard_melee_door_door_open");
  level thread run_scene("trainyard_melee_harper_door_idle");
  flag_set("anthem_harper_vo_drone_meeting_drone");
  level thread vo_underground();
  flag_wait("railyard_drone_meeting_room_entered");
  flag_set("railyard_drone_meeting_ready");
  run_scene("trainyard_melee_harper_door_close");
  level.harper run_anim_to_idle("trainyard_drone_meeting_harper_approach", "trainyard_drone_meeting_harper_approach_idle");
  e_spotlight = getent("fake_spotlight", "targetname");
  e_spotlight delete();
  e_searchlight = getent("courtyard_spotlight", "targetname");
  e_searchlight delete();
}

clip_trainyard_door() {
  flag_wait("railyard_drone_meeting_room_entered");
  e_door_clip = getent("drone_entrance_collision", "targetname");
  e_door_clip solid();
}

gaz_tiger_interior() {
  flag_wait("jump_down_attack_gaz_idle_started");
  vh_tiger = getent("gaz_tiger", "targetname");
  vh_tiger attach("veh_iw_gaz_tigr_int_rear", "body_animate_jnt");
  flag_wait("jump_down_attack_player_done");
  wait 0.05;
  level.player setlowready(1);
  vh_tiger detach("veh_iw_gaz_tigr_int_rear", "body_animate_jnt");
}

vision_interrogation_handler() {
  trigger_wait("interrogation_vision_trigger");
  level thread maps\createart\pakistan_2_art::vision_torture_room();
}

attach_trigger_gaz_victim() {
  level endon("trainyard_melee_finished");
  level endon("gaz_melee_failed");
  wait 0.5;
  ai_victim = get_ais_from_scene("jump_down_attack_gaz_guard_idle", "gaz_guy_2");
  ai_victim thread gaz_victim_fail();
  t_melee = getent("trigger_gaz_victim", "targetname");
  t_melee enablelinkto();
  t_melee.origin = ai_victim.origin;
  t_melee linkto(ai_victim);
  scene_wait("jump_down_player");
  wait 0.05;
  level.player setlowready(1);

  while(true) {
    trigger_wait("trigger_gaz_victim");
    screen_message_create(&"PAKISTAN_SHARED_MELEE_HINT");

    while(level.player istouching(t_melee)) {
      if(level.player meleebuttonpressed()) {
        screen_message_delete();
        level thread run_scene("jump_down_attack_player");
        level thread maps\_audio::switch_music_wait("PAK_VAN_KILL", 0.25);
        level thread maps\_audio::switch_music_wait("PAK_POST_VAN", 8);
        flag_wait("jump_down_attack_player_done");
        flag_set("trainyard_melee_finished");
      }

      wait 0.05;
    }

    screen_message_delete();
  }
}

#using_animtree("player");

harper_kill_gaz_driver() {
  flag_wait("jump_down_player_started");
  end_scene("harper_path4_hide_idle");
  end_scene("harper_path4_hide_exit");
  end_scene("jump_down_approach_harper");
  end_scene("jump_down_preidle_harper");
  end_scene("jump_down_idle_harper");
  end_scene("jump_down_signal_harper");
  end_scene("trainyard_melee_harper_cross_bridge");
  end_scene("jump_down_attack_harper_idle");
  level.harper setgoalpos(level.harper.origin);
  level.harper waittill("goal");
  wait(getanimlength( % p_pakistan_5_11_jump_down_attack_player_mantle) - 2);
  end_scene("harper_path4_hide_idle");
  end_scene("harper_path4_hide_exit");
  end_scene("jump_down_approach_harper");
  end_scene("jump_down_preidle_harper");
  end_scene("jump_down_idle_harper");
  end_scene("jump_down_signal_harper");
  end_scene("trainyard_melee_harper_cross_bridge");
  end_scene("jump_down_attack_harper_idle");
  level thread run_scene("jump_down_harper");
  flag_wait("jump_down_attack_player_started");
  end_scene("harper_path4_hide_idle");
  end_scene("harper_path4_hide_exit");
  end_scene("jump_down_approach_harper");
  end_scene("jump_down_preidle_harper");
  end_scene("jump_down_idle_harper");
  end_scene("jump_down_signal_harper");
  end_scene("trainyard_melee_harper_cross_bridge");
  end_scene("jump_down_attack_harper_idle");
  level thread run_scene("jump_down_attack_harper");
}

gaz_victim_fail() {
  level endon("jump_down_attack_player_started");

  while(true) {
    if(self.origin[0] < level.player.origin[0]) {
      break;
    }

    wait 0.05;
  }

  wait 0.1;
  flag_set("gaz_melee_failed");
  screen_message_delete();
  ai_driver = get_ais_from_scene("jump_down_attack_gaz_idle", "gaz_guy_1");
  ai_driver thread driver_gaz_melee_fail();
  self stopanimscripted(1);
  self gun_recall();
  level.player setlowready(0);
  level.harper thread harper_gaz_melee_fail();
  level thread drone_gaz_melee_fail();
  wait 0.5;
  t_trig = getent("trigger_gaz_victim", "targetname");
  t_trig delete();
}

drone_gaz_melee_fail() {
  setdvar("ui_deadquote", & "PAKISTAN_SHARED_KILLED_BY_DRONE");
  level thread maps\pakistan_anthem::drone_death_hud(level.player);
  s_spawnpt = getstruct("drone_gaz_melee", "targetname");
  s_goal1 = getstruct("drone_gaz_melee_goal1", "targetname");
  s_goal2 = getstruct("drone_gaz_melee_goal2", "targetname");
  s_goal3 = getstruct("drone_gaz_melee_goal3", "targetname");
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  vh_drone veh_magic_bullet_shield(1);
  vh_drone setspeed(25, 15, 10);
  vh_drone setvehgoalpos(s_goal1.origin, 0);
  vh_drone waittill("goal");
  vh_drone play_fx("drone_spotlight_cheap", vh_drone gettagorigin("tag_spotlight"), vh_drone gettagangles("tag_spotlight"), "kill_spotlight", 1, "tag_spotlight");
  vh_drone set_turret_target(level.player, undefined, 0);
  vh_drone setvehgoalpos(s_goal2.origin, 0);
  vh_drone waittill("goal");
  vh_drone thread fire_turret_for_time(6, 0);
  vh_drone thread fire_turret(1);
  vh_drone setvehgoalpos(s_goal3.origin, 1);
  vh_drone waittill("goal");
  wait 7;
  vh_drone thread fire_turret_for_time(-1, 0);

  while(isalive(level.player)) {
    vh_drone fire_turret(1);
    level.player dodamage(100, vh_drone.origin, vh_drone);
    wait(randomfloatrange(0.5, 0.7));
  }
}

driver_gaz_melee_fail() {
  self endon("death");
  vh_gaz = getent("gaz_tiger", "targetname");
  self stopanimscripted(1);
  self gun_recall();
  self enter_vehicle(vh_gaz);
  wait 0.3;
  vh_gaz notify("unload");
}

harper_gaz_melee_fail() {
  self stopanimscripted(1);
  self.goalradius = 32;
  self setgoalnode(getnode("gaz_melee_cover", "targetname"));
}

harper_and_gaz_scene() {
  scene_wait("jump_down_harper");

  if(!flag("jump_down_attack_harper_started"))
    level thread run_scene("jump_down_attack_harper_idle");
}

detection_event_drone_pathing() {
  level endon("spotlight_detection");
  s_takeoff_start = getstruct("rooftop_meeting_drone_takeoff_point", "targetname");
  s_goal1 = getstruct("control_drone_helipad1", "targetname");
  s_goal2 = getstruct("control_drone_helipad2", "targetname");
  s_search_start = getstruct("balcony_search_start", "targetname");
  s_goal3 = getstruct("balcony_search_goal1", "targetname");
  s_goal4 = getstruct("balcony_search_goal2", "targetname");
  s_goal5 = getstruct("balcony_search_goal3", "targetname");
  e_takeoff_look_target = getent("drone_detection_search_target1", "targetname");
  e_balcony_look_target = getent("drone_detection_balcony_search_path", "targetname");
  e_control_room_target = getent("drone_detection_search_target5", "targetname");
  e_balcony_lookat = getent("balcony_lookat", "targetname");
  s_drone_spotlight_target_helipad = getstruct("drone_spotlight_target_helipad", "targetname");
  level thread detection_tarp_blocker_think();
  self setrotorspeed(1);
  wait 10.0;
  self veh_toggle_tread_fx(1);
  flag_wait("osprey_away");
  self setspeed(15, 10, 8);
  self.spotlight_target = e_takeoff_look_target;
  self set_turret_target(self.spotlight_target, undefined, 0);
  self thread control_room_drone_target();
  self setvehgoalpos(s_takeoff_start.origin, 1);
  wait 2;
  self play_fx("drone_spotlight_targeting", self gettagorigin("tag_flash"), self gettagangles("tag_flash"), undefined, 1, "tag_flash");
  self play_fx("spotlight_lens_flare", self gettagorigin("tag_flash"), self gettagangles("tag_flash"), undefined, 1, "tag_flash");
  self waittill("goal");
  self setspeed(20, 12, 10);
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill("goal");
  flag_set("drone_at_helipad");
  self setlookatent(e_control_room_target);
  self setvehgoalpos(s_goal2.origin, 1);
  flag_wait("control_room_exit");
  self clearlookatent();
  self setlookatent(e_balcony_lookat);
  self setvehgoalpos(s_search_start.origin, 1);
  self waittill("goal");
  self thread detection_spotlight_think();
  self setlookatent(getent("drone_detection_search_target3", "targetname"));
  wait 2;
  self clearlookatent();
  self setspeed(8, 6, 5);
  self setvehgoalpos(s_goal3.origin, 1);
  self waittill("goal");
  wait 1;
  level thread turn_off_spotlight_fx();
  self clear_turret_target(0);
  self setspeed(35, 20, 15);
  self setvehgoalpos(s_goal4.origin, 0);
  self waittill("goal");
  level notify("detection_complete");
  self setvehgoalpos(s_goal5.origin, 0);
  self waittill("goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

control_room_drone_target() {
  e_control_room_target = getent("drone_detection_search_target5", "targetname");
  s_drone_spotlight_target_helipad = getstruct("drone_spotlight_target_helipad", "targetname");
  s_drone_spotlight_target_balcony = getstruct("drone_spotlight_target_balcony", "targetname");
  s_drone_spotlight_target_balcony_end = getstruct("drone_spotlight_target_balcony_end", "targetname");
  self.spotlight_target moveto(s_drone_spotlight_target_helipad.origin, 8);
  self.spotlight_target waittill("movedone");
  flag_wait("drone_at_helipad");
  self.spotlight_target moveto(e_control_room_target.origin, 4);
  flag_wait("control_room_exit");
  self.spotlight_target moveto(s_drone_spotlight_target_balcony.origin, 1);
  self.spotlight_target waittill("movedone");
  wait 2;
  self.spotlight_target moveto(s_drone_spotlight_target_balcony_end.origin, 6);
  self.spotlight_target waittill("movedone");
}

turn_off_spotlight_fx() {
  wait 1;
  flag_set("drone_detection_end");
}

drone_focus_rooftop(e_target) {
  e_target_fx = spawn("script_model", e_target.origin);
  e_target_fx setmodel("tag_origin");
  e_target_fx.direction = anglestoforward(self gettagangles("tag_flash")) * -1;
  e_target_fx.angles = vectortoangles(e_target_fx.direction);
  e_target_fx play_fx("spotlight_target", e_target_fx.origin, e_target_fx.angles, undefined, 1, "tag_origin", 1);

  while(true) {
    e_target_fx.direction = anglestoforward(self gettagangles("tag_flash")) * -1;
    e_target_fx.angles = vectortoangles(e_target_fx.direction);
    e_target_fx.origin = e_target.origin;

    if(flag("drone_detection_end")) {
      e_target_fx delete();
      break;
    }

    wait 0.05;
  }
}

check_control_room() {
  level endon("control_room_exit");
  flag_wait("drone_at_helipad");
  wait 4;
  t_control = getent("trig_control_room", "targetname");

  if(level.player istouching(t_control))
    self thread drone_spotted_player();
}

detection_spotlight_think() {
  while(isDefined(self)) {
    v_drone_spotlight_trigger_origin = bullettrace(self gettagorigin("tag_flash"), anglestoforward(self gettagangles("tag_flash")) * 5096 + self gettagorigin("tag_flash"), 0, level.player)["position"];
    n_distance_from_spotlight = distancesquared(level.player.origin, v_drone_spotlight_trigger_origin);

    if(n_distance_from_spotlight < 65536 && bullettracepassed(self gettagorigin("tag_flash"), level.player geteye(), 1, self, level.harper) || flag("drone_player_detected")) {
      if(!level.b_under_tarp)
        self thread drone_spotted_player();

      break;
    }

    wait 0.05;
  }
}

drone_spotted_player() {
  level notify("spotlight_detection");
  level thread detection_blocker_cleanup();
  self setspeedimmediate(0);
  self setlookatent(level.player);
  self thread drone_punisher_fire();
  flag_set("alert_drones");
}

detection_tarp_blocker_think() {
  level endon("spotlight_detection");
  level endon("detection_complete");

  while(true) {
    if(level.player istouching(getent("drone_detection_tarp_trigger", "targetname")))
      level.b_under_tarp = 1;
    else
      level.b_under_tarp = 0;

    wait 0.05;
  }
}

detection_blocker_cleanup() {
  foreach(m_blocker in getentarray("drone_detection_blocker", "script_noteworthy"))
  m_blocker delete();
}

courtyard_cleanup() {
  a_enemies = getentarray("anthem_courtyard_soldiers_ai", "targetname");

  foreach(ai_enemy in a_enemies)
  ai_enemy delete();

  a_enemies = simple_spawn("anthem_rearguard");

  foreach(ai_enemy in a_enemies) {
  }
}

melee_attach_knife_player(e_player_body) {
  level.player.m_knife = spawn_model("t6_wpn_knife_melee", e_player_body gettagorigin("tag_weapon1"), e_player_body gettagangles("tag_weapon1"));
  level.player.m_knife linkto(e_player_body, "tag_weapon1");
}

melee_detach_knife_player(e_player_body) {
  level.player.m_knife delete();
}

melee_bloodfx_knife_player(e_player_body) {
  playfxontag(getfx("melee_knife_blood_player"), level.player.m_knife, "tag_knife_fx");
}

melee_attach_knife_harper(ai_harper) {
  level.harper.m_knife = spawn_model("t6_wpn_knife_melee", ai_harper gettagorigin("tag_weapon_right"), ai_harper gettagangles("tag_weapon_right"));
  level.harper.m_knife linkto(ai_harper, "tag_weapon_right");
}

melee_detach_knife_harper(ai_harper) {
  level.harper.m_knife delete();
}

melee_bloodfx_knife_harper(ai_harper) {
  level.player playrumbleonentity("damage_light");
  playfxontag(getfx("melee_knife_blood_harper"), level.harper.m_knife, "tag_knife_fx");
}

drone_gantry_entry() {
  m_drone_gantry = getent("drone_gantry", "targetname");
  m_dead_drone = getent("dead_drone", "targetname");
  m_dead_drone linkto(m_drone_gantry, "tag_drone_attach");
  run_scene_first_frame("trainyard_drone_meeting_gantry");
}

melee_cb_radio_audio() {
  cb_radio = getent("trainyard_melee_guard1", "targetname");
  cb_radio_sound = spawn("script_origin", cb_radio.origin);
  cb_radio_sound playloopsound("amb_cb_radio_loop", 2);
  trigger_wait("railyard_drone_meeting_trigger");
  cb_radio_sound stoploopsound(5);
  wait 1;
  cb_radio_sound delete();
}

observation_gaz_convoy_start() {
  flag_wait("rooftop_meeting_convoy_start");
  nd_gaz_start1 = getvehiclenode("gaz_convoy_start1", "targetname");

  for(i = 0; i < 3; i++) {
    veh_gaz1 = spawn_vehicle_from_targetname("observation_gaz1");
    veh_gaz1 thread go_path(nd_gaz_start1);
    veh_gaz1 playsoundontag("evt_truck_by" + i, "tag_origin");
    veh_gaz1 thread observation_gaz_convoy_delete();
    veh_gaz1 thread tiger_headlights_on();
    wait(randomfloatrange(1.5, 3.0));
  }
}

observation_gaz_convoy_delete() {
  self waittill("delete");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

train_enter() {
  m_train = getent("train_engine", "targetname");
  v_final_position = m_train.origin;
  v_start_position = m_train.origin + vectorscale((1, 0, 0), 6144.0);

  foreach(m_attachment in getentarray("train_engine", "target"))
  m_attachment linkto(m_train, "tag_origin");

  m_train moveto(v_start_position, 0.05);
  m_train playloopsound("amb_train_idle_lp");
  flag_wait("trainyard_drone_meeting_started");
  m_train thread train_rumble();
  m_train playsound("evt_train_arrive");
  m_train moveto(v_final_position, 25.0, 0, 6.0);
  wait 21;
  level thread train_exposure();
  wait 2;
  trigger_on("train_interference_trigger", "script_noteworthy");
  flag_set("train_arrived");
}

train_rumble() {
  wait 5;
  earthquake(0.05, 25, level.player.origin, 1000);
  level.player playrumblelooponentity("reload_small");
  wait 3;
  level.player playrumblelooponentity("reload_medium");
  wait 3;
  level.player playrumblelooponentity("reload_large");
  wait 3;
  level.player playrumblelooponentity("reload_medium");
  wait 3;
  level.player playrumblelooponentity("reload_small");
  flag_wait("train_arrived");
  level.player rumble_loop_stop();

  for(i = 0; i < 8; i++) {
    level.player playrumbleonentity("reload_small");
    wait 0.25;
  }

  stopallrumbles();
  level thread underwater_physics_activate();
}

train_exposure() {
  setsaveddvar("r_exposureTweak", 1);
  n_val = 3.0;

  while(n_val < 3.3) {
    n_val = n_val + 0.05;
    setsaveddvar("r_exposureValue", n_val);
    wait 0.1;
  }

  level.player waittill("underwater");

  while(n_val > 3.0) {
    n_val = n_val - 0.05;
    setsaveddvar("r_exposureValue", n_val);
    wait 0.1;
  }

  setsaveddvar("r_exposureTweak", 0);
}

underwater_physics_activate() {
  setsaveddvar("phys_ragdoll_buoyancy", 1);
  s_phys = getstruct("underwater_phys_explosion", "targetname");
  physicsexplosionsphere(s_phys.origin, 1200, 1000, 0.01);
  m_corpse1 = getent("corpse_1", "targetname");
  m_corpse1 startragdoll();
  m_corpse3 = getent("corpse_3", "targetname");
  m_corpse3 startragdoll();
  m_corpse4 = getent("corpse_4", "targetname");
  m_corpse4 startragdoll();
  trigger_wait("trigger_corpse");
  playsoundatposition("evt_creepy_corpse", (0, 0, 0));
  m_corpse2 = getent("corpse_2", "targetname");
  m_corpse2 startragdoll();
  m_corpse2 launchragdoll((-20, -10, 0));
  flag_wait("trainyard_millibar_meeting_player_approach_started");
  m_corpse1 delete();
  m_corpse2 delete();
  m_corpse3 delete();
  m_corpse4 delete();
}

trainyard_vision_think() {
  self waittill("trigger");
  level thread maps\createart\pakistan_2_art::turn_on_trainyard_vision();
}

turn_on_trainyard_vision(ent, endon_string) {
  maps\createart\pakistan_2_art::turn_on_trainyard_vision();
}

turn_off_trainyard_vision(ent) {
  maps\createart\pakistan_2_art::turn_off_trainyard_vision();
  self thread trainyard_vision_think();
}

underground_main() {
  clientnotify("aS_on");
  millibar_meeting_event();
  incendiary_grenade_event();
  wait 0.05;
}

millibar_meeting_event() {
  flag_set("railyard_harper_millibar_approach");
  flag_wait("railyard_millibar_meeting_ready");
  level thread run_scene("trainyard_millibar_meeting_enemy_idle");
  level thread run_scene("trainyard_millibar_meeting_soldiers_idle");
  run_scene_first_frame("trainyard_millibar_grenades_fire_grate");
  setmusicstate("PAK_INT_ESCAPE_REFERENCE");
  trigger_wait("railyard_millibar_meeting_trigger");
  autosave_by_name("firewater");
  flag_set("trainyard_elevator_escape_ready");
  level thread millibar_toggle_think();
  level.player startcameratween(1);
  level thread run_scene("trainyard_millibar_meeting_player_approach", 0.5);
  player_body = get_model_or_models_from_scene("trainyard_millibar_meeting_player_approach", "player_body");
  player_body attach("c_usa_cia_frnd_viewbody_vson", "J_WristTwist_LE");
  level thread vo_millibar_meeting();
  clientnotify("clean_under_phy");
}

underground_harper_pathing() {
  level endon("trainyard_elevator_escape_ready");
  flag_wait("train_arrived");
  wait 2;
  level thread remove_cart_clip();
  level thread run_scene("trainyard_drone_meeting_cart_exit");
  level.player setmovespeedscale(0.5);
  run_scene("trainyard_drone_meeting_harper_exit");
  flag_set("railyard_millibar_meeting_ready");
  level.player setmovespeedscale(1);
  clientnotify("force");
  level.harper thread harper_water_wake();
  run_scene("trainyard_millibar_meeting_harper_approach");
  level thread run_scene("trainyard_millibar_meeting_harper_idle");
}

harper_water_wake() {
  flag_wait("trainyard_millibar_meeting_harper_approach_started");
  wait 0.8;
  self.water_fx = spawn("script_model", self.origin + vectorscale((0, 0, -1), 4.0));
  self.water_fx setmodel("tag_origin");
  self.water_fx thread waterfx_follow_harper();
  self.water_fx setclientflag(9);
}

waterfx_follow_harper() {
  self endon("delete");
  self movey(-200, 4);
  self waittill("movedone");
  wait 2;
  self clearclientflag(9);
  self delete();
}

remove_cart_clip() {
  flag_wait("remove_cart_clip");
  m_clip = getent("clip_carts", "targetname");
  m_clip delete();
}

incendiary_grenade_event() {
  level thread grenade_room_swap();
  level thread attach_menendez_phone();
  level thread run_scene("trainyard_millibar_grenades_enemy_heroes");
  level thread run_scene("trainyard_millibar_grenades_enemies");
  level thread run_scene("trainyard_millibar_grenades_fire");
  level thread run_scene("trainyard_millibar_grenades_fire_grate");
  level thread player_millibar_scene();
  level thread grenade_blinking_light();
  level thread millibar_visor();
  flag_set("millibar_vo_started");
  level thread delete_scene_all("trainyard_worker1");
  level thread delete_scene_all("trainyard_worker2");
  level thread delete_scene_all("trainyard_worker3");
  level thread delete_scene_all("trainyard_worker4");
  level thread delete_scene_all("trainyard_worker5");
  level thread delete_scene_all("trainyard_worker6");
  run_scene("trainyard_harper_millibar_grenades");
  level.harper bloodimpact("none");
  level thread run_scene("trainyard_harper_millibar_grenades_warp");
  level.player enableweaponcycling();
  trainyard_light_off();
  level thread salazar_pip();
  level thread vo_salazar_pip();
  scene_wait("trainyard_millibar_grenades_warp");
  level.harper bloodimpact("hero");
}

attach_menendez_phone() {
  flag_wait("trainyard_millibar_grenades_enemy_heroes_started");
  level.menendez attach("p6_anim_cell_phone", "tag_weapon_left");
  flag_wait("trainyard_millibar_grenades_enemy_heroes_done");
  level.menendez detach("p6_anim_cell_phone", "tag_weapon_left");
}

millibar_visor() {
  flag_wait("millibar_activate");
  wait 1;
  maps\_glasses::perform_visor_wipe();
  level waittill("millibar_stop");
  level thread visor_distortion();
  maps\_glasses::perform_visor_wipe(0.5);
  flag_wait("dive");
  wait 4.5;
  level.player playrumbleonentity("damage_heavy");
}

visor_distortion() {
  rpc("clientscripts/_empgrenade", "emp_filter_over_time", 3);
  maps\_empgrenade::emphudflickeron();
  wait 3;
  maps\_empgrenade::emphudflickeroff();
}

grenade_blinking_light() {
  flag_wait("trainyard_millibar_grenades_fire_started");
  e_grenade1 = get_model_or_models_from_scene("trainyard_millibar_grenades_fire", "incendiary1");
  e_grenade2 = get_model_or_models_from_scene("trainyard_millibar_grenades_fire", "incendiary2");
  e_grenade1 thread play_grenade_light();
  e_grenade2 thread play_grenade_light();
}

play_grenade_light() {
  self endon("death");
  self endon("delete");

  while(true) {
    playfxontag(level._effect["grenade_light"], self, "tag_origin");
    wait 0.5;
  }
}

player_millibar_scene() {
  level.player player_disable_weapons();
  run_scene("trainyard_millibar_grenades");
  clientnotify("clean_gren_phy");
  run_scene("trainyard_millibar_grenades_warp");
  level.player player_enable_weapons();
}

grenade_room_swap() {
  flag_wait("firewater_surface");
  setmusicstate("PAK_ESCAPE_ANTHEM");
  clientnotify("crates_on_fire");
  wait 5;
  level thread play_bullet_hitting_water_fx();
  level thread magic_bullet_hitting_water();
  level thread fake_fire_front_player();
}

fake_fire_front_player() {
  s_fire = getstruct("fake_fire", "script_noteworthy");
  s_target = getstruct("fake_fire_player", "targetname");

  for(i = 0; i < 20; i++) {
    magicbullet("vector_sp", s_fire.origin, s_target.origin + (randomintrange(-20, 20), randomintrange(-40, -20), 0));
    wait(randomfloatrange(0.1, 0.3));
  }
}

magic_bullet_hitting_water() {
  level endon("start_defend_convoy");
  a_s_gunfire = getstructarray("underground_fake_fire_location", "targetname");

  for(i = 0; i < a_s_gunfire.size; i++)
    a_s_gunfire[i] thread pick_firing_targets();
}

pick_firing_targets() {
  level endon("start_defend_convoy");
  a_s_targets = getstructarray("underground_fake_fire_target", "targetname");

  while(true) {
    index = randomint(a_s_targets.size);
    magicbullet("vector_sp", self.origin, a_s_targets[index].origin);
    wait(randomfloatrange(0.2, 0.4));
  }
}

play_bullet_hitting_water_fx() {
  level endon("start_defend_convoy");
  level thread bullet_escape();
  e_gunfire = getent("fire_water_bullet", "targetname");

  while(true) {
    playfxontag(level._effect["underwater_bullet_fx"], e_gunfire, "tag_origin");
    wait 0.2;
  }
}

bullet_escape() {
  trigger_wait("underground_bullet_escape_trigger");
  level thread vision_jiffylube_handler();
  level notify("kill_underground_grenade_scene");
  level.player.overrideplayerdamage = undefined;
  flag_wait("start_defend_convoy");
  stop_exploder(610);
}

millibar_toggle_think() {
  flag_wait("millibar_activate");
  clientnotify("millibar_on");
  level thread underwater_explo_sounds();
  level thread millibar_fov();
  ceiling = getent("milibar_ceiling", "targetname");
  ceiling hide();
  setmusicstate("PAK_MILLIBAR");
  flag_set("anthem_harper_vo_millibar_meeting_start");
  level waittill("millibar_stop");
  level.player playsound("evt_loud_signal");
  level clientnotify("millibar_off");
  level thread maps\_audio::switch_music_wait("PAK_GRENADES_DROP", 4);
  ceiling show();
}

millibar_fov() {
  level.player thread lerp_fov_overtime(2.0, 30.0, 1);
  add_visor_text("PAKISTAN_SHARED_MILLIBAR_ZOOM_2X", 0);
  level waittill("millibar_zoom");
  remove_visor_text("PAKISTAN_SHARED_MILLIBAR_ZOOM_2X");
  level.player thread lerp_fov_overtime(2.0, 10.0, 1);
  add_visor_text("PAKISTAN_SHARED_MILLIBAR_ZOOM_6X", 0);
  level waittill("millibar_stop");
  remove_visor_text("PAKISTAN_SHARED_MILLIBAR_ZOOM_6X");
  level notify("nade_explo");
  level.player resetfov();
}

courtyard_sounds() {
  train_yard = spawn("script_origin", (-12573, 34411, 649));
  train_yard playloopsound("amb_train_yard");
  motor_pool = spawn("script_origin", (-20312, 40531, 755));
  motor_pool playloopsound("amb_motor_pool");
}

vo_roof_meeting() {
  level endon("rooftop_meeting_talkers_done");
  level.harper queue_dialog("harp_here_comes_menendez_0");
  flag_wait("rooftop_meeting_defalco_vo_start");
  level.harper queue_dialog("harp_looks_like_he_s_meet_0", 1);
  flag_wait("roof_meeting_defalco_identified");
  level.player queue_dialog("sect_defalco_0", 1);
}

vo_exit_control_room() {
  flag_wait("harper_path4_hide_started");
  level.harper say_dialog("harp_duck_in_here_0", 0.5);
  flag_wait("harper_path4_hide_exit_started");
  level.harper say_dialog("harp_move_we_have_to_kee_0", 2.0);
  level thread vo_roof_traverse();
  level thread vo_gaz_melee();
}

vo_roof_traverse() {
  level endon("rooftop_meeting_convoy_start");
  level.harper queue_dialog("harp_dammit_where_the_0", 2);
  level.player queue_dialog("sect_salazar_we_ve_lost_0", 0.5);
  level.player queue_dialog("sala_got_him_he_s_ente_0", 1.5);
  level.player queue_dialog("sect_did_you_secure_trans_0", 0.5);
  level.player queue_dialog("sala_not_yet_area_s_a_0", 0.5);
  level.player queue_dialog("sect_stay_on_it_0", 0.5);
}

vo_gaz_melee() {
  trigger_wait("trigger_jump_down_scene");
  level.harper queue_dialog("harp_these_guys_are_in_ou_0", 1);
}

vo_underground() {
  flag_wait("remove_cart_clip");
  level.harper queue_dialog("harp_looks_like_we_got_to_0", 5);
}

vo_millibar_meeting() {
  level waittill("millibar_stop");
  level.harper queue_dialog("harp_grenade_0", 7.5);
}

vo_salazar_pip() {
  trigger_wait("spawn_pre_garage_guys");
  level.player queue_dialog("sala_section_the_whole_b_0", 1);
  level.player queue_dialog("sala_section_isi_forces_0", 1);
  level.player queue_dialog("sect_secure_us_a_vehicle_0", 1);
  level.player queue_dialog("sala_working_on_it_0", 1);
  level.player queue_dialog("sect_we_are_leaving_0", 1);
}

tiger_headlights_on() {
  self play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_left", 1);
  self play_fx("fx_vlight_headlight_default", self.origin, self.angles, undefined, 1, "tag_headlight_right", 1);
  self play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_left", 1);
  self play_fx("fx_vlight_brakelight_default", self.origin, self.angles, undefined, 1, "tag_tail_light_right", 1);
}

salazar_pip() {
  trigger_wait("spawn_pre_garage_guys");
  level.harper set_ignoreme(0);
  level.player set_ignoreme(0);
  level thread play_bink_on_hud("pakistan2_salazar_pip", 0, 1);
  clientnotify("clean_fire_phy");
  setsaveddvar("phys_ragdoll_buoyancy", 0);
}

vision_jiffylube_handler() {
  level endon("player_switched_to_claw");

  while(true) {
    trigger_wait("vision_jiffylube_trigger");
    level thread maps\createart\pakistan_2_art::vision_jiffylube_room();

    while(level.player istouching(getent("vision_jiffylube_trigger", "targetname")))
      wait 0.05;

    level thread maps\createart\pakistan_2_art::turn_back_to_default();
  }
}

underwater_explo_sounds() {
  level waittill("nade_explo");
  wait 11;
  fire_uw_a = spawn("script_origin", (-18601, 33658, 270));
  fire_uw_a playloopsound("amb_fire_nade");
}

start_ambient_drones_rooftop() {
  flag_wait("drone_detection_cleared");
  s_spawn_drone1 = getstruct("drone1_spawnpt", "targetname");
  vh_drone1 = spawn_vehicle_from_targetname("isi_drone");
  vh_drone1.origin = s_spawn_drone1.origin;
  vh_drone1.angles = s_spawn_drone1.angles;
  vh_drone1 thread ambient_flight_path(getstruct(s_spawn_drone1.target, "targetname"));
  s_spawn_drone1 structdelete();
  flag_wait("rooftop_meeting_harper_slide");
  s_spawnpt = getstruct("drone2_spawnpt", "targetname");
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  vh_drone thread ambient_flight_path(getstruct(s_spawnpt.target, "targetname"));
  s_spawnpt structdelete();
}

delete_scenes() {
  flag_wait("trainyard_melee_harper_door_close_done");
  e_tower_door = getent("guard_entrance", "targetname");

  if(isDefined(e_tower_door))
    e_tower_door delete();

  e_tower_clip = getent("guard_entrance_collision", "targetname");

  if(isDefined(e_tower_clip))
    e_tower_clip delete();

  delete_scene_all("rooftop_exit_open", 1);
  delete_scene_all("jump_down_gaz_idle", 1);
  delete_scene_all("tower_chair", 1);
  delete_scene_all("id_melee_approach_guard", 1);
  flag_wait("trainyard_millibar_meeting_player_approach_started");
  delete_scene_all("trainyard_drone_meeting_cart_exit", 1);
  e_door_clip = getent("drone_entrance_collision", "targetname");
  e_door_coll = getent("lab_door_collision", "targetname");
  e_labdoor = getent("drone_entrance", "targetname");

  if(isDefined(e_door_clip))
    e_door_clip delete();

  if(isDefined(e_door_coll))
    e_door_coll delete();

  if(isDefined(e_labdoor))
    e_labdoor delete();
}