/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_anthem_approach.gsc
*********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_dialog;
#include maps\pakistan_util;
#include maps\_music;
#include maps\_turret;
#include maps\pakistan_street;
#include maps\createart\pakistan_art;
#include maps\pakistan;
#include maps\_audio;
#include maps\_ammo_refill;
#include maps\_vehicle;
#include maps\_introscreen;
#include maps\pakistan_anim;
#include maps\_scene;
#include maps\_anim;

skipto_anthem_approach() {
  skipto_teleport("skipto_anthem_approach", _get_friendly_array_anthem_approach());
  level.player setlowready(1);
  flag_set("intro_anim_done");
  flag_set("frogger_started");
  flag_set("frogger_done");
  flag_set("bus_dam_runners_started");
  flag_set("bus_dam_gate_push_test_done");
  trigger_use("trig_colors_to_sandbags");
  level thread watch_player_rain_water_sheeting();
  level.player allow_prone(0);
  level thread maps\pakistan_street::harper_lookat_player();
  maps\createart\pakistan_art::drone_stealth();
  level thread maps\pakistan_util::skipto_stealth_deconstruct_ents();
}

skipto_sewer_exterior() {
  skipto_teleport("skipto_sewer_exterior", _get_friendly_array_anthem_approach());
  maps\createart\pakistan_art::bank();
  level.player allow_prone(1);
  level.harper setgoalpos(level.harper.origin);
  level.harper pakistan_move_mode("cqb");
  level.harper thread follow_path(getnode("harper_node_enter_bank", "targetname"));
  level thread bank_collapse_shake();
  level thread watch_player_rain_water_sheeting();
  level clientnotify("aS_on");
  flag_set("intro_anim_done");
  flag_set("frogger_started");
  flag_set("frogger_done");
  flag_set("bus_dam_runners_started");
  flag_set("bus_dam_gate_push_test_done");
  flag_set("drone1_start");
  flag_set("corpse_alley_harper_done");
  flag_set("drones_gone");
  level thread skipto_sewer_exterior_bodies();
  level thread maps\pakistan_util::skipto_stealth_deconstruct_ents();
  level thread maps\pakistan::pakistan_objectives();
  level thread monitor_drone_stealth_section();
}

skipto_sewer_interior() {
  skipto_teleport("skipto_sewer_interior", _get_friendly_array_anthem_approach());
  trigger_use("sewer_exterior_start");
  level.player set_temp_stat(3, 0);
  level.b_flamethrower_unlocked = maps\pakistan_util::is_claw_flamethrower_unlocked();
  maps\createart\pakistan_art::sewer();
  level thread watch_player_rain_water_sheeting();
  level.player thread dont_prone_while_touching("no_prone_trigger");
  flag_set("intro_anim_done");
  flag_set("frogger_started");
  flag_set("frogger_done");
  flag_set("bus_dam_runners_started");
  flag_set("bus_dam_gate_push_test_done");
  flag_set("drone1_start");
  flag_set("corpse_alley_harper_done");
  flag_set("player_entered_bank");
  level thread maps\pakistan::pakistan_objectives();
  level thread sewer_interior_skipto();
}

sewer_interior_skipto() {
  if(level.player hasperk("specialty_intruder")) {
    flag_wait("conversation_overheard");
    level thread vo_fake_guards();
    level.harper say_dialog("harp_you_hear_that_0", 1);
  }
}

skipto_sewer_interior_perk() {
  level.player setperk("specialty_intruder");
  skipto_sewer_interior();
}

skipto_sewer_interior_no_perk() {
  level.player unsetperk("specialty_intruder");
  skipto_sewer_interior();
}

_get_friendly_array_anthem_approach() {
  a_friendlies = [];
  a_friendlies[a_friendlies.size] = init_hero("harper");
  return a_friendlies;
}

anthem_approach() {
  setsaveddvar("vehicle_selfCollision", 0);
  flag_init("drone_at_bank");
  dead_bodies();
  flag_wait("start_anthem_approach");
  level thread anthem_approach_saves();
  level thread spawn_drones();
  add_flag_function("player_entered_bank", maps\createart\pakistan_art::bank);
  init_hero("harper", ::init_harper);
  level thread vo_intro_drone();
  level thread vo_avoid_spotlight();
  level thread alley_player_jump();
  level thread player_jump_water_anim();
  level thread start_spotlight_detection();
  flag_wait_either("corpse_alley_player_started", "drone_intro_done");
  level thread monitor_drone_stealth_section();
  level thread harper_movement();
  level thread bank_collapse_shake();
  level thread spawn_drone_searcher();
  maps\pakistan_street::alley_clean_up_civilians();
  setmusicstate("PAK_BODIES");
  level thread maps\_audio::switch_music_wait("PAK_STEALTH_CHOPPER", 6);
  flag_set("pakistan_introscreen_show");
  level thread alley_cleanup();
}

dead_bodies() {
  clientnotify("start_stealth_dynents");
  level thread static_bodies();
  level thread floating_bodies();
}

alley_cleanup() {
  t_alley = getent("bus_dam_fxanim_cleanup_trig", "targetname");
  a_script_models = getentarray("script_model", "classname");

  foreach(script_model in a_script_models) {
    if(script_model istouching(t_alley)) {
      if(isDefined(script_model.destructibledef)) {
        script_model delete();
        wait 0.05;
      }

      if(isDefined(script_model.targetname)) {
        if(script_model.model == "_prefabs/library/ammo_refill/ammo_crate_future.map") {
          script_model maps\_ammo_refill::cleanup_cache();
          wait 0.05;
        }
      }
    }
  }

  level thread maps\pakistan_util::delete_ents_inside_trigger("bus_dam_fxanim_cleanup_trig");
  flag_wait("corpse_alley_player_done");
  delete_scene_all("slum_alley_initial", 1, 0, 1);
  delete_scene_all("slum_alley_corner", 1, 0, 1);
  delete_scene_all("slum_alley_dog_rummage", 1, 0, 1);
  delete_scene_all("slum_alley_dog_transition", 1, 0, 1);
  delete_scene_all("slum_alley_dog_growl", 1, 0, 1);
  delete_scene_all("slum_alley_dog_exit", 1, 0, 1);
  delete_scene_all("alley_civilian_1", 1, 0, 1);
  delete_scene_all("alley_civilian_2", 1, 0, 1);
  delete_scene_all("alley_civilian_1_react", 1, 0, 1);
  delete_scene_all("alley_civilian_2_react", 1, 0, 1);
  delete_scene_all("alley_civilian_3", 1, 0, 1);
  delete_scene_all("alley_civilian_door_react", 1, 0, 1);
}

monitor_drone_stealth_section() {
  flag_wait("tandem_kill_vo");

  if(!flag("drone_intro_attack") && !flag("drone_searcher_attack") && !flag("drone_bank_attack"))
    flag_set("drones_gone");
  else {
    while(isalive(getent("drone_helicopter", "targetname")) || isalive(getent("drone_searcher", "targetname")) || isalive(getent("drone_bank", "targetname")))
      wait 1;

    flag_set("drones_gone");
  }

  wait 2;
  flag_set("sewer_move_up");
}

floating_bodies() {
  a_m_bodies = getentarray("stealth_corpse", "targetname");
  a_m_persistent_bodies = getentarray("persistent_corpse", "targetname");
  a_m_bodies = arraycombine(a_m_bodies, a_m_persistent_bodies, 1, 1);
  clearallcorpses();

  if(is_mature()) {
    foreach(m_body in a_m_bodies)
    m_body startragdoll();

    level.harper thread corpse_push_think();
    maps\pakistan_util::ragdoll_corpse_control();
    level thread floating_bodies_backtrack_cleanup();
    flag_wait("sewer_gate_open");
    delete_ragdoll_corpses("anthem_stealth_intro_right_corpse_spot_model");
    delete_ragdoll_corpses("anthem_stealth_middle_left_corpse_spot_model");
  }

  array_delete(a_m_bodies);
}

corpse_push_think() {
  level endon("player_entered_bank");

  while(true) {
    physicsexplosioncylinder(self.origin, 16, 4, 0.5);
    wait 0.1;
  }
}

floating_bodies_backtrack_cleanup() {
  level endon("player_entered_bank");
  level waittill("anthem_stealth_middle_left_corpse_spot_spawned");
  delete_ragdoll_corpses("anthem_stealth_intro_right_corpse_spot_model");
}

static_bodies() {
  if(is_mature()) {
    maps\pakistan_util::static_bodies_enable("death_pose_", 1, 17);
    flag_wait("static_corpse_swap_trig");
    maps\pakistan_util::static_bodies_disable("death_pose_", 1, 4);
    maps\pakistan_util::static_bodies_enable("death_pose_", 18, 20);
    flag_wait("sewer_gate_open");
    maps\pakistan_util::static_bodies_disable("death_pose_", 5, 20);
  }

  a_s_align_spots = getstructarray("death_pose_align", "script_noteworthy");

  foreach(s_align in a_s_align_spots)
  s_align structdelete();
}

spawn_drones() {
  flag_wait("pakistan_gump_alley");
  trigger_use("trig_anthem_drones_spawn");
}

init_harper() {
  self.ignoreall = 1;
}

on_stealth_spotted() {
  level.harper.ignoreall = 0;
  flag_set("harper_ai_dont_stop");
}

#using_animtree("generic_human");

harper_movement() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("player_entered_bank");
  level thread harper_attack_drone();
  level thread harper_enter_bank();
  level thread harper_beeline_to_bank();
  level.harper thread harper_movement_bank();
  level.harper notify("stop_scale_speed_in_water");
  level.harper change_movemode("cqb_run");
  level.harper.moveplaybackrate = 1;
  level.harper set_cqb_run_anim( % ch_pakistan_3_3_hand_signals_run_harper, % ch_pakistan_3_3_hand_signals_run_harper, % ch_pakistan_3_3_hand_signals_run_harper);
  level thread run_scene("corpse_alley_runner");
  run_scene("corpse_alley_harper");
  level thread run_scene("corpse_alley_exit_harper");
  flag_wait("move1");
  wait 2;
  scene_wait("corpse_alley_exit_harper");
  level.player setlowready(0);
  run_scene("hand_signals_a");
  level.harper thread follow_path(getnode("harper_stealth_node_1", "targetname"));
}

harper_movement_bank() {
  flag_wait("harper_entered_bank");
  self clear_cqb_run_anim();
  self change_movemode("cqb_walk");
  flag_wait("sewer_move_up");
  self change_movemode("cqb_run");
}

bank_collapse_shake() {
  flag_wait("player_entered_bank");
  maps\_vehicle::spawn_vehicles_from_targetname("sewer_guard_spotlight");
  level.player allow_prone(1);
  level.player thread dont_prone_while_touching("no_prone_trigger");
  clientnotify("cleanup_stealth_dynents");
  maps\createart\pakistan_art::bank();
  maps\pakistan_util::kill_ragdoll_corpse_control();
  wait 1;
  level thread drone_bank_search();
  level.player thread bank_collapse_rumble();
  earthquake(0.3, 6, level.player.origin, 1000);
  flag_wait("sewer_entered");
  maps\createart\pakistan_art::sewer();
}

bank_collapse_rumble() {
  self playrumblelooponentity("artillery_rumble");
  wait 4;
  stopallrumbles();
}

spawn_drone_searcher() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  flag_wait("spawn_drone_searcher");
  s_spawnpt = getstruct("drone_searcher_spawnpt", "targetname");
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  vh_drone.targetname = "drone_searcher";
  vh_drone thread drone_searcher_logic();
  vh_drone thread drone_attack_player();
  vh_drone thread drone_crash_when_sewer_entered();
  vh_drone thread drone_proximity_check();
  vh_drone thread drone_stop_gunfire_check();
  flag_clear("drones_gone");
}

drone_searcher_logic() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  self endon("death");
  self endon("stop_drone_searcher_logic");
  self endon("stop_logic");
  self.spotlight_target = getent("drone_searcher_target", "targetname");
  s_goal1 = getstruct("drone_searcher_goal1", "targetname");
  s_goal2 = getstruct("drone_searcher_goal2", "targetname");
  s_goal3 = getstruct("drone_searcher_goal3", "targetname");
  s_goal4 = getstruct("drone_searcher_goal4", "targetname");
  s_goal5 = getstruct("drone_flyaway1", "targetname");
  s_goal6 = getstruct("drone_flyaway2", "targetname");
  s_goal7 = getstruct("drone_flyaway3", "targetname");
  target_set(self);
  self setspeed(30, 15, 12);
  self thread drone_searcher_deathwatch();
  self set_turret_target(self.spotlight_target, (0, 0, 0), 0);
  self thread drone_searcher_searchlight_on();
  self thread drone_searcher_searchlight_off();
  self setvehgoalpos(s_goal1.origin, 0);
  self waittill("goal");

  if(!flag("dept_store_entered"))
    self.spotlight_target thread drone_searcher_target_movement();

  self setspeed(20, 15, 12);
  self setvehgoalpos(s_goal2.origin, 1);
  self waittill("goal");
  self thread player_detection_logic();

  if(!flag("dept_store_entered")) {
    flag_wait("pickup_hide");
    self setspeed(8, 5, 2);
    flag_set("drone_searcher_low");
    self setvehgoalpos(s_goal3.origin, 1);
    self waittill("goal");
    flag_wait("drone_fly_off");
    self setspeed(2);
    wait 1;
    flag_wait("drone_searcher_flyoff");
    wait 2;
    self clear_turret_target(0);
    self setspeed(10, 5, 2);
    self setvehgoalpos(s_goal4.origin, 0);
    self waittill("goal");
    self setvehgoalpos(s_goal5.origin, 0);
    self waittill("goal");
    self setvehgoalpos(s_goal6.origin, 0);
    self waittill("goal");
    self setvehgoalpos(s_goal7.origin, 0);
    self waittill("goal");
    self.spotlight_target delete();
    self veh_toggle_tread_fx(0);
    self veh_toggle_exhaust_fx(0);
    self vehicle_toggle_sounds(0);
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  } else {
    self thread drone_searcher_alt_logic();
    self.spotlight_target thread drone_searcher_spotlight_alt_movement();
  }
}

drone_searcher_deathwatch() {
  self waittill("death");
  flag_set("drone_searcher_done");
}

drone_searcher_searchlight_on() {
  self endon("death");
  flag_wait("drone_spotlight_off");
  wait 0.5;
  self play_fx("helicopter_drone_spotlight_targeting", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
  self play_fx("drone_lens_flare", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
  flag_wait("drone_searcher_flyoff");
  wait 8;
  self notify("spotlight_off");
}

drone_searcher_searchlight_off() {
  self endon("death");
  flag_wait("player_entered_bank");
  self notify("spotlight_off");
}

drone_searcher_target_movement() {
  level endon("dept_store_entered");
  s_goal1 = getstruct("drone_searcher_target_goal1", "targetname");
  s_goal2 = getstruct("drone_searcher_target_goal2", "targetname");
  s_goal3 = getstruct("drone_searcher_target_goal3", "targetname");
  s_goal4 = getstruct("drone_searcher_target_goal4", "targetname");
  s_goal5 = getstruct("drone_searcher_target_goal5", "targetname");
  s_goal6 = getstruct("drone_searcher_target_goal6", "targetname");
  wait 1;
  self moveto(s_goal1.origin, 3);
  self waittill("movedone");
  flag_set("drone_searcher_look_left");
  self moveto(s_goal2.origin, 3);
  self waittill("movedone");
  wait 2;
  self moveto(s_goal3.origin, 4);
  self waittill("movedone");
  flag_set("drone_searcher_look_away");
  self moveto(s_goal4.origin, 6);
  self waittill("movedone");
  wait 2;
  self moveto(s_goal5.origin, 6);
  self waittill("movedone");
  wait 2;
  flag_set("drone_searcher_done");
  self moveto(s_goal6.origin, 4);
  self waittill("movedone");
  flag_wait("drone_fly_off");
  flag_set("drone_searcher_flyoff");
}

drone_searcher_alt_logic() {
  self endon("death");
  self endon("stop_logic");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  s_goal_3 = getstruct("drone_searcher_altgoal3", "targetname");
  s_goal_4 = getstruct("drone_searcher_altgoal4", "targetname");
  s_goal_5 = getstruct("drone_searcher_altgoal5", "targetname");
  self setspeed(5, 3, 1);
  self setvehgoalpos(s_goal_3.origin, 1);
  self waittill("goal");
  self setlookatent(self.spotlight_target);
  wait 5;
  level notify("start_dept_store_search");
  self setvehgoalpos(s_goal_4.origin, 1);
  self waittill("goal");
  wait 5;
  self setvehgoalpos(s_goal_5.origin, 1);
  self waittill("goal");
  wait 3;
  self thread drone_flyaway_logic();
}

drone_searcher_spotlight_alt_movement() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("player_entered_bank");
  s_goal1 = getstruct("drone_searcher_alttarget_goal1", "targetname");
  s_goal2 = getstruct("drone_searcher_alttarget_goal2", "targetname");
  s_goal3 = getstruct("drone_searcher_alttarget_goal3", "targetname");
  self moveto(s_goal1.origin, 1);
  self waittill("movedone");
  level waittill("start_dept_store_search");
  self moveto(s_goal2.origin, 5);
  self waittill("movedone");
  level.harper notify("stop_follow_path");
  wait 0.2;
  level.harper thread harper_end_hand_signals();
  wait 0.2;
  level.harper thread follow_path(getnode("harper_node_alt", "targetname"));
  self moveto(s_goal3.origin, 5);
  self waittill("movedone");
  wait 3;
  self moveto(s_goal2.origin, 5);
  self waittill("movedone");
  flag_set("drone_searcher_flyoff");
}

drone_bank_search() {
  s_spawnpt = getstruct("bank_drone_goal1", "targetname");
  vh_drone = spawn_vehicle_from_targetname("isi_drone");
  vh_drone.origin = s_spawnpt.origin;
  vh_drone.angles = s_spawnpt.angles;
  vh_drone.targetname = "drone_bank";
  vh_drone thread drone_bank_search_logic();
  vh_drone thread player_detection_logic();
  vh_drone thread drone_attack_player();
  vh_drone thread drone_crash_when_sewer_entered();
  vh_drone thread drone_stop_gunfire_check();
  flag_clear("drones_gone");

  if(level.skipto_point == "sewer_exterior") {
    vh_drone waittill("death");
    flag_set("drones_gone");
  }

  wait 0.1;
  vh_drone notify("stop_drone_spotlight_detection");
}

drone_stop_gunfire_check() {
  self endon("death");
  flag_wait("sewer_guards_go");
  self notify("stop_behavior_check");
}

drone_bank_search_logic() {
  self endon("death");
  self endon("stop_logic");
  level endon("drone_detected_player");
  self thread bank_drone_death_watch();
  self thread drone_bank_searchlight_on();
  s_goal2 = getstruct("bank_drone_goal2", "targetname");
  s_goal3 = getstruct("bank_drone_goal3", "targetname");
  s_goal4 = getstruct("bank_drone_goal4", "targetname");
  s_goal5 = getstruct("bank_drone_goal5", "targetname");
  e_target = getent("bank_drone_target", "targetname");
  e_target thread move_drone_bank_target();
  target_set(self);
  self set_turret_target(e_target, (0, 0, 0), 0);
  self setspeed(10, 5, 2);
  self setvehgoalpos(s_goal2.origin);
  self waittill("goal");
  self setvehgoalpos(s_goal3.origin);
  self waittill("goal");
  self notify("spotlight_off");
  self setspeed(25, 15, 5);
  self setvehgoalpos(s_goal4.origin);
  self waittill("goal");
  self setvehgoalpos(s_goal5.origin);
  self waittill("goal");
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

drone_bank_searchlight_on() {
  wait 0.5;
  self play_fx("helicopter_drone_spotlight_targeting", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
  self play_fx("drone_lens_flare", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
}

bank_drone_death_watch() {
  self waittill("death");
  flag_set("bank_drone_dead");
}

move_drone_bank_target() {
  s_goal1 = getstruct("bank_target_goal1", "targetname");
  s_goal2 = getstruct("bank_target_goal2", "targetname");
  s_goal3 = getstruct("bank_target_goal3", "targetname");
  self moveto(s_goal1.origin, 3);
  self waittill("movedone");
  self moveto(s_goal2.origin, 5);
  self waittill("movedone");
  self moveto(s_goal3.origin, 7);
  self waittill("movedone");
  self delete();
}

alley_player_jump() {
  level endon("start_player_jump_water");
  t_anim = get_ent("transition_to_anthem_approach", "targetname", 1);
  level thread mantle_disabler();

  while(true) {
    trigger_wait("transition_to_anthem_approach");

    while(level.player istouching(t_anim)) {
      if(level.player jumpbuttonpressed()) {
        setsaveddvar("mantle_enable", 0);
        level thread player_jump_into_water();
        flag_set("start_player_jump_water");
      }

      wait 0.05;
    }
  }
}

player_jump_water_anim() {
  flag_wait("start_player_jump_water");
  level thread run_scene("corpse_alley_player");
  wait 3.5;
  physicsexplosionsphere(level.player.origin, 800, 300, 0.1);
}

player_jump_into_water() {
  maps\createart\pakistan_art::drone_stealth();
  scene_wait("corpse_alley_player");
  level.player thread player_water_visor();
  level.player allowjump(1);
  setsaveddvar("mantle_enable", 1);
  wait 0.05;
  level.player setlowready(1);
}

mantle_disabler() {
  level endon("corpse_alley_player_done");
  t_anim = get_ent("transition_to_anthem_approach", "targetname", 1);

  while(true) {
    trigger_wait("transition_to_anthem_approach");
    level.player allowjump(0);

    while(level.player istouching(t_anim))
      wait 0.05;

    level.player allowjump(1);
  }
}

civ_get_detected(ai_civ) {
  flag_set("civ_targeted");
}

start_spotlight_detection() {
  scene_wait("corpse_alley_runner");

  if(isalive(level.stealth_drone1)) {
    level.stealth_drone1 thread player_detection_logic();
    level.stealth_drone1 thread drone_proximity_check();
    level.stealth_drone1 thread drone_crash_when_sewer_entered();
  }
}

drone_spotlight_control() {
  self endon("death");
  self endon("stop_spotlight_control");
  self ent_flag_init("spotlight_paused");

  while(true) {
    self waittill("new_follow_node", nd_path);

    if(isDefined(nd_path.target)) {
      s_target = getstruct(nd_path.target, "targetname");

      if(isDefined(s_target))
        self thread follow_spotlight_path(s_target);
    }
  }
}

follow_spotlight_path(s_target) {
  self endon("death");
  self endon("stop_spotlight_path");
  self notify("__follow_spotlight_path__");
  self endon("__follow_spotlight_path__");
  a_spotlight_path = [];

  while(isDefined(s_target)) {
    a_spotlight_path[a_spotlight_path.size] = s_target;

    if(isDefined(s_target.target))
      s_target = getstruct(s_target.target, "targetname");
    else
      s_target = undefined;
  }

  s_current_spot = undefined;
  self.spotlight_path_reverse = 0;

  while(true) {
    self ent_flag_waitopen("spotlight_paused");

    for(i = 0; i < a_spotlight_path.size; i++) {
      s_target = a_spotlight_path[i];

      if(!isDefined(s_current_spot) || s_current_spot != s_target) {
        if(isDefined(s_current_spot) && isDefined(s_current_spot.script_notify)) {
          if(self.spotlight_path_reverse)
            level notify(s_current_spot.script_notify + "_reverse");
          else
            level notify(s_current_spot.script_notify);
        }

        s_current_spot = s_target;
        _aim_spotlight(s_target, s_current_spot.script_float);

        if(isDefined(s_current_spot.script_wait))
          s_current_spot script_wait();
      }
    }

    self.spotlight_path_reverse = self.spotlight_path_reverse ? 0 : 1;
    a_spotlight_path = array_reverse(a_spotlight_path);
  }
}

aim_spotlight(target, n_speed_scale, b_face, n_time) {
  self endon("death");
  self ent_flag_set("spotlight_paused");
  _aim_spotlight(target, n_speed_scale, b_face);
  wait(n_time);
  self ent_flag_clear("spotlight_paused");
}

_aim_spotlight(target, n_speed_scale, b_face) {
  if(!isDefined(n_speed_scale))
    n_speed_scale = 1;

  if(!isDefined(b_face))
    b_face = 0;

  self endon("death");
  self.spotlight_target unlink();
  self.turretrotscale = n_speed_scale;
  self.spotlight_target.origin = target.origin;

  if(!isvec(target) && isDefined(target.classname))
    self.spotlight_target linkto(target);

  if(b_face)
    self setlookatent(self.spotlight_target);
  else
    self clearlookatent();

  self waittill("turret_on_target");
  self.turretrotscale = 1;
}

vo_intro_drone() {
  level endon("corpse_alley_player_started");
  flag_wait("drone1_start");
  level.harper say_dialog("harp_fucking_drones_0", 0);
}

vo_avoid_spotlight() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  n_distance = 250;
  flag_wait("hand_signals_a_started");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_stay_left_brother_0", 1);
  else
    level.harper say_dialog("harp_careful_man_stick_1", 1);

  flag_wait("move3");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_move_section_1", 3);
  else
    level.harper say_dialog("harp_move_before_it_sees_0", 3);

  flag_wait("moveto_cafe_side");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_it_s_comin_around_0", 2);
  else if(!flag("spawn_drone_searcher"))
    level.harper say_dialog("harp_get_down_fucking_d_0", 2);

  flag_wait("drone_turned_around");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_that_s_right_you_dum_0", 1);
  else if(!flag("spawn_drone_searcher"))
    level.harper say_dialog("harp_spotlight_s_getting_1", 0);
  else
    level.harper say_dialog("harp_that_s_right_you_du_0", 1);

  flag_wait("spawn_drone_searcher");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_we_got_another_drone_0", 1);
  else
    level.harper say_dialog("harp_we_got_another_drone_1", 1);

  flag_wait("drone_searcher_look_left");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_go_0", 2);
  else if(!flag("spawn_drone_searcher"))
    level.harper say_dialog("harp_move_before_it_see_0", 3);

  flag_wait("pickup_hide");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_entry_point_s_beyond_0", 0);
  else
    level.harper say_dialog("harp_entry_point_s_beyond_1", 0);

  level.player say_dialog("sect_ready_when_you_are_0", 0.5);
  level.harper say_dialog("harp_move_before_it_see_0", 1);
  flag_wait("drone_searcher_done");

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper say_dialog("harp_fuck_it_we_gotta_go_0", 0.5);
  else
    level.harper say_dialog("harp_fuck_it_we_gotta_go_1", 0.5);

  flag_wait("drone_searcher_look_away");

  if(!flag("spawn_drone_searcher")) {
    flag_wait("drone_searcher_done");
    level.harper say_dialog("harp_i_think_we_lost_him_0", 1);
  }
}

_can_spotlight_see_position(v_target_position, n_dot_tolerance) {
  v_spotlight_origin = self gettagorigin("tag_spotlight");
  v_to_harper_from_spotlight = vectornormalize(v_target_position - v_spotlight_origin);
  v_drone_forward = anglestoforward(self gettagangles("tag_spotlight"));
  n_dot = vectordot(v_to_harper_from_spotlight, v_drone_forward);

  str_dvar = getdvar(#"_id_D8E6D53A");

  if(str_dvar != "")
    self thread draw_line_for_time(v_target_position, v_spotlight_origin, 0, 0, 1, 0.25);

  b_within_dot = n_dot > n_dot_tolerance;
  return b_within_dot;
}

pakistan_title_screen(level_prefix, number_of_lines, totaltime, text_color) {
  level.introstring = [];
  flag_wait("pakistan_introscreen_show");
  luinotifyevent(&"hud_add_title_line", 4, level_prefix, number_of_lines, totaltime, text_color);
  waittill_textures_loaded();
  wait 2.5;
  level notify("introscreen_done");
  maps\_introscreen::introscreen_fadeouttext();
}

transition_to_section_2() {
  b_claw_has_flamethrower = level.player get_temp_stat(3);
  b_soct_has_boost = level.player get_temp_stat(1);
  rpc("clientscripts/_audio", "cmnLevelFadeout");
  screen_fade_out(2);
  wait 2.1;
  nextmission();
}

drone_helicopter_setup() {
  self endon("death");
  self.health = 2500;
  flag_wait("start_anthem_approach");

  if(self.targetname == "isi_drone") {
    return;
  }
  target_set(self);
  self ent_flag_init("focus_spotlight");

  if(!isDefined(self.targetname) && !isDefined("drone_helicopter") || isDefined(self.targetname) && isDefined("drone_helicopter") && self.targetname == "drone_helicopter") {
    self play_fx("helicopter_drone_spotlight_targeting", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
    self play_fx("drone_lens_flare", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
    self.spotlight_target = getent("intro_target", "targetname");
  } else {
    self.spotlight_target = spawn("script_origin", self.origin + anglestoforward(self.angles) * 5000 + vectorscale((0, 0, -1), 500.0));
    self play_fx("helicopter_drone_spotlight_cheap", undefined, undefined, "death", 1, "tag_spotlight");
    self thread ambient_drone_target_delete(self.spotlight_target);
  }

  self maps\_turret::set_turret_target(self.spotlight_target, (0, 0, 0), 0);
  self thread set_flag_on_notify("death", "helicopter_dead");

  while(is_alive(self)) {
    self thread draw_debug_line(self gettagorigin("tag_turret"), self.spotlight_target.origin, 0.05);
    wait 0.05;
  }

}

ambient_drone_target_delete(e_spotlight_target) {
  self waittill("death");
  e_spotlight_target delete();
}

spawn_funch_stealth_drone1() {
  self endon("death");
  level endon("dept_store_entered");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  self thread drone_attack_player();
  self thread player_entered_dept();
  self thread drone_flyaway();
  level.stealth_drone1 = self;
  self ent_flag_init("spotlight_paused");
  s_goal1 = getstruct("drone_intro_goal1", "targetname");
  s_goal2 = getstruct("drone_intro_goal2", "targetname");
  s_goal3 = getstruct("drone_intro_goal3", "targetname");
  s_goal4 = getstruct("drone_intro_goal4", "targetname");
  s_goal5 = getstruct("drone_intro_goal5", "targetname");
  s_goal6 = getstruct("drone_intro_goal6", "targetname");
  self setspeed(25, 15, 10);
  flag_wait("start_anthem_approach");
  wait 0.3;
  self.spotlight_target thread drone_spotlight_movement();
  self setvehgoalpos(s_goal1.origin, 1);
  self waittill("goal");
  wait 2;
  self setspeed(5, 3, 1);
  self setvehgoalpos(s_goal2.origin, 1);
  self waittill("goal");
  flag_wait("civ_targeted");
  ai_civ = get_ais_from_scene("corpse_alley_runner", "corpse_alley_runner");
  self maps\_turret::clear_turret_target(0);
  self maps\_turret::set_turret_target(ai_civ, undefined, 0);
  self setlookatent(ai_civ);
  wait 1.5;
  level thread rumble_drone_turret();
  self maps\_turret::fire_turret_for_time(2, 0);
  self maps\_turret::clear_turret_target(0);
  self maps\_turret::set_turret_target(self.spotlight_target, undefined, 0);
  self setlookatent(self.spotlight_target);
  self waittill("turret_on_target");
  flag_set("looking_at_target");
  flag_wait("moveto_cafe");
  self clearlookatent();
  self setspeed(10, 5, 3);
  self setvehgoalpos(s_goal3.origin, 0);
  self waittill("goal");
  self setvehgoalpos(s_goal4.origin, 1);
  self waittill("goal");
  self setlookatent(self.spotlight_target);
  flag_set("looking_at_target");
  flag_wait("moveto_cafe_side");
  self clearlookatent();
  self setspeed(5, 3, 1);
  self setvehgoalpos(s_goal5.origin, 1);
  self waittill("goal");
  self setlookatent(self.spotlight_target);
  self setspeed(8, 5, 3);
  self setvehgoalpos(s_goal6.origin, 1);
  self waittill("goal");
  self clearlookatent();
  wait 5;
  self notify("spotlight_off");
}

rumble_drone_turret() {
  level.player playrumbleonentity("artillery_rumble");
  wait 1;
  level.player playrumbleonentity("artillery_rumble");
}

drone_spotlight_movement() {
  self endon("death");
  self endon("delete");
  level endon("dept_store_entered");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  self moveto(self.origin + vectorscale((1, 0, 0), 200.0), 2);
  self waittill("movedone");
  s_goal_0 = getstruct("drone_intro_light_0", "targetname");
  s_goal_1 = getstruct("drone_intro_light_1", "targetname");
  s_goal_2 = getstruct("drone_intro_light_2", "targetname");
  s_goal_3 = getstruct("drone_intro_light_3", "targetname");
  s_goal_4 = getstruct("drone_intro_light_4", "targetname");
  s_goal_5 = getstruct("drone_intro_light_5", "targetname");
  s_goal_6 = getstruct("drone_intro_light_6", "targetname");
  s_goal_7 = getstruct("drone_intro_light_7", "targetname");
  s_goal_8 = getstruct("drone_intro_light_8", "targetname");
  self moveto(s_goal_0.origin, 2);
  self waittill("movedone");
  self moveto(s_goal_1.origin, 5);
  self waittill("movedone");
  flag_wait("civ_targeted");
  self moveto(s_goal_3.origin, 1);
  self waittill("movedone");
  flag_wait("looking_at_target");
  wait 2;
  self moveto(s_goal_2.origin, 4);
  self waittill("movedone");
  wait 2;
  flag_set("move1");
  self moveto(s_goal_3.origin, 4);
  self waittill("movedone");
  flag_clear("looking_at_target");
  flag_set("moveto_cafe");
  self moveto(s_goal_4.origin, 3);
  self waittill("movedone");
  self moveto(s_goal_5.origin, 3);
  self waittill("movedone");
  flag_wait("looking_at_target");
  wait 1;

  if(!flag("player_across_street")) {
    self moveto(s_goal_8.origin, 4);
    self waittill("movedone");
    wait 1;
    flag_set("move3");
    wait 1;
  } else {
    self moveto(s_goal_7.origin, 2);
    self waittill("movedone");
    self moveto(s_goal_4.origin, 2);
    self waittill("movedone");
    flag_set("move3");
  }

  flag_clear("looking_at_target");

  if(!flag("player_across_street")) {
    self moveto(s_goal_4.origin, 4);
    self waittill("movedone");
  } else {
    self moveto(s_goal_6.origin, 4);
    self waittill("movedone");
  }

  wait 2;

  if(!flag("player_across_street")) {
    self moveto(s_goal_6.origin, 6);
    self waittill("movedone");
  } else {
    self moveto(s_goal_4.origin, 4);
    self waittill("movedone");
  }

  wait 2;
  flag_set("moveto_cafe_side");
  self moveto(s_goal_2.origin, 4);
  self waittill("movedone");
  self moveto(s_goal_1.origin, 5);
  self waittill("movedone");
  wait 2;
  self moveto(s_goal_5.origin, 3);
  self waittill("movedone");
  wait 2;
  flag_set("drone_turned_around");
  self moveto(s_goal_7.origin, 3);
  wait 2;
  flag_set("spawn_drone_searcher");
  self waittill("movedone");
  self moveto(s_goal_4.origin, 3);
  self waittill("movedone");
}

player_entered_dept() {
  level endon("spawn_drone_searcher");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  flag_wait("dept_store_entered");
  self.spotlight_target = getent("dept_target", "targetname");
  self clearlookatent();
  self setlookatent(self.spotlight_target);
  self maps\_turret::set_turret_target(self.spotlight_target, undefined, 0);
  s_goal_0 = getstruct("dept_goal_0", "targetname");
  s_goal_1 = getstruct("dept_goal_1", "targetname");
  s_goal_2 = getstruct("dept_goal_2", "targetname");
  self setspeed(5, 3, 1);
  self setvehgoalpos(s_goal_0.origin, 1);
  self waittill("goal");
  self.spotlight_target thread dept_target_movement();
  self setvehgoalpos(s_goal_1.origin, 0);
  self waittill("goal");
  self setvehgoalpos(s_goal_2.origin, 1);
  self waittill("goal");
  wait 2;
  self clearlookatent();
  flag_set("spawn_drone_searcher");
}

dept_target_movement() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  s_goal_0 = getstruct("dept_target_0", "targetname");
  s_goal_1 = getstruct("dept_target_1", "targetname");
  wait 3;
  self moveto(s_goal_0.origin, 4);
  self waittill("movedone");
  self moveto(s_goal_1.origin, 4);
  self waittill("movedone");
}

drone_flyaway() {
  self endon("death");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  flag_wait("spawn_drone_searcher");
  self notify("spotlight_off");
  flag_set("drone_spotlight_off");
  self play_fx("helicopter_drone_spotlight_cheap", undefined, undefined, "spotlight_off", 1, "tag_spotlight");
  self thread drone_flyaway_logic();
}

drone_flyaway_logic() {
  self endon("death");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  s_goal1 = getstruct("drone_flyaway1", "targetname");
  s_goal2 = getstruct("drone_flyaway2", "targetname");
  s_goal3 = getstruct("drone_flyaway3", "targetname");
  e_lookat = spawn("script_origin", s_goal1.origin);
  self setlookatent(e_lookat);
  self clear_turret_target(0);
  self set_turret_target(e_lookat, (0, 0, 0), 0);
  self setspeed(10, 5, 3);
  self setvehgoalpos(s_goal1.origin);
  self waittill("goal");
  self setspeed(20, 15, 10);
  e_lookat.origin = s_goal2.origin;
  self setvehgoalpos(s_goal2.origin);
  self waittill("goal");
  e_lookat.origin = s_goal3.origin;
  self setvehgoalpos(s_goal3.origin);
  self waittill("goal");
  e_lookat delete();
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

player_detection_logic() {
  self thread drone_spotlight_detection();
  self thread player_detected_logic();
  self thread player_behaviors_to_alert_drone();
  self thread drone_detects_damage_for_alert();
  self thread drone_crash();
}

drone_proximity_check() {
  self endon("death");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("drones_gone");
  level endon("sewer_move_up");

  while(true) {
    if(distance2dsquared(self.origin, level.player.origin) <= 62500)
      level.player notify("too_close");

    wait 0.5;
  }
}

player_behaviors_to_alert_drone() {
  self endon("death");
  self endon("stop_behavior_check");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("drones_gone");
  level endon("sewer_move_up");
  level.player waittill_any("weapon_fired", "grenade_fire", "grenade_launcher_fire", "too_close");
  wait 0.5;
  level notify("drone_detects_player", & "PAKISTAN_SHARED_DRONE_FAIL_SOUND");
}

drone_detects_damage_for_alert() {
  self endon("death");
  self endon("player_shotme");
  n_distance = 250;
  self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

  if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
    level.harper thread say_dialog("harp_what_are_you_doing_1", 1);
  else
    level.harper thread say_dialog("harp_what_are_you_doing_2", 1);

  level notify("drone_detects_player", & "PAKISTAN_SHARED_DRONE_FAIL_SOUND");
  self notify("player_shotme");
}

drone_spotlight_detection() {
  self endon("death");
  self endon("stop_drone_spotlight_detection");
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("drones_gone");
  n_frames_detected = 0;

  while(true) {
    v_spotlight_origin = self gettagorigin("tag_flash");
    v_spotlight_angles = self gettagangles("tag_flash");
    v_player_trace_origin = level.player get_eye();
    v_to_player = vectornormalize(v_player_trace_origin - v_spotlight_origin);
    v_forward = anglestoforward(v_spotlight_angles);
    n_dot = vectordot(v_forward, v_to_player);
    str_difficulty = getdifficulty();
    n_frames_before_detection = get_drone_spotlight_frames_before_detection(str_difficulty);
    n_sight_trace = level.player sightconetrace(v_spotlight_origin, self, v_forward, 6);
    b_can_see = n_sight_trace > 0.667;

    if(b_can_see && n_dot > 0.95) {
      n_frames_detected++;
      debug_print_line("spotlight can see player " + n_frames_detected);
    } else
      n_frames_detected = 0;

    if(!isgodmode(level.player)) {
      if(n_frames_detected > n_frames_before_detection) {
        n_distance = 250;

        if(distance2dsquared(level.player.origin, level.harper.origin) <= n_distance * n_distance)
          level.harper say_dialog("harp_dammit_its_seen_you_0", 1);
        else
          level.harper say_dialog("harp_dammit_it_s_seen_y_0", 1);

        level notify("drone_detects_player", & "PAKISTAN_SHARED_DRONE_FAIL_SIGHT");
      }
    }

    wait 0.05;
  }
}

drone_lens_flare() {
  self endon("death");
  self endon("stop_spotlight_flare");
  level.b_flare = 0;

  while(true) {
    v_spotlight_origin = self gettagorigin("tag_flash");
    v_spotlight_angles = self gettagangles("tag_flash");
    v_player_trace_origin = level.player get_eye();
    v_to_player = vectornormalize(v_player_trace_origin - v_spotlight_origin);
    v_forward = anglestoforward(v_spotlight_angles);
    n_dot = vectordot(v_forward, v_to_player);
    n_sight_trace = level.player sightconetrace(v_spotlight_origin, self, v_forward, 10);
    b_can_see = n_sight_trace > 0.667;

    if(n_dot > 0.95 && !level.b_flare) {
      self play_fx("drone_lens_flare", undefined, undefined, "lens_flare_off", 1, "tag_flash");
      level.b_flare = 1;
    } else if(n_dot < 0.95 && level.b_flare) {
      self notify("lens_flare_off");
      level.b_flare = 0;
    }

    wait 0.05;
  }
}

get_drone_spotlight_frames_before_detection(str_difficulty) {
  if(!isDefined(self.drone_spotlight_detection_parameters))
    self _init_drone_spotlight_detection_parameters();

  n_frames_to_detection = self.drone_spotlight_detection_parameters[str_difficulty]["time_to_detect"] * 20;
  return n_frames_to_detection;
}

get_drone_spotlight_detection_dot_tolerance(str_difficulty) {
  str_stance = self getstance();
  b_player_is_sprinting = self issprinting();
  b_player_is_jumping = !self isonground();

  if(!isDefined(self.drone_spotlight_detection_parameters))
    self _init_drone_spotlight_detection_parameters();

  n_dot = self.drone_spotlight_detection_parameters[str_difficulty]["dot_crouch"];

  if(str_stance == "stand" || b_player_is_sprinting || b_player_is_jumping)
    n_dot = self.drone_spotlight_detection_parameters[str_difficulty]["dot_exposed"];
  else if(str_stance == "prone")
    n_dot = self.drone_spotlight_detection_parameters[str_difficulty]["dot_prone"];

  return n_dot;
}

_init_drone_spotlight_detection_parameters() {
  self.drone_spotlight_detection_parameters = [];
  self.drone_spotlight_detection_parameters["easy"]["dot_prone"] = 0.9;
  self.drone_spotlight_detection_parameters["easy"]["dot_crouch"] = 0.8;
  self.drone_spotlight_detection_parameters["easy"]["dot_exposed"] = 0.7;
  self.drone_spotlight_detection_parameters["easy"]["time_to_detect"] = 1.0;
  self.drone_spotlight_detection_parameters["medium"]["dot_prone"] = 0.85;
  self.drone_spotlight_detection_parameters["medium"]["dot_crouch"] = 0.7;
  self.drone_spotlight_detection_parameters["medium"]["dot_exposed"] = 0.5;
  self.drone_spotlight_detection_parameters["medium"]["time_to_detect"] = 0.2;
  self.drone_spotlight_detection_parameters["hard"]["dot_prone"] = 0.8;
  self.drone_spotlight_detection_parameters["hard"]["dot_crouch"] = 0.7;
  self.drone_spotlight_detection_parameters["hard"]["dot_exposed"] = 0.5;
  self.drone_spotlight_detection_parameters["hard"]["time_to_detect"] = 0.1;
  self.drone_spotlight_detection_parameters["fu"]["dot_prone"] = 0.75;
  self.drone_spotlight_detection_parameters["fu"]["dot_crouch"] = 0.7;
  self.drone_spotlight_detection_parameters["fu"]["dot_exposed"] = 0.4;
  self.drone_spotlight_detection_parameters["fu"]["time_to_detect"] = 0.1;
}

player_detected_logic() {
  self endon("death");
  level endon("sewer_move_up");
  b_has_fired = 0;
  level waittill("drone_detects_player", str_deadquote);
  flag_set("drone_detected_player");
  level.cansave = 0;
  flag_set("sewer_guards_alerted");
  level.player setlowready(0);
  level.player notify("scripted_stealth_break");
  b_has_fired = 1;
  screen_message_delete();
  self thread maps\_turret::set_turret_target(level.player, undefined, 0);
  setdvar("ui_deadquote", str_deadquote);
  level thread drone_death_hud(level.player);
  wait 2;
  flag_set("drone_attacks_player");
}

drone_attack_player() {
  self endon("death");
  flag_wait("drone_attacks_player");
  level.harper thread queue_dialog("harp_take_down_that_drone_0", 1);

  if(self.targetname == "drone_searcher") {
    flag_set("drone_searcher_attack");
    self thread clear_flag_on_death("drone_searcher_attack", "drone_attacks_player");
  } else if(self.targetname == "drone_bank") {
    flag_set("drone_bank_attack");
    self thread clear_flag_on_death("drone_bank_attack", "drone_attacks_player");
  } else {
    flag_set("drone_intro_attack");
    self thread clear_flag_on_death("drone_intro_attack", "drone_attacks_player");
  }

  self setvehicleavoidance(1, 400);
  self setneargoalnotifydist(800);
  target_set(self);
  self notify("spotlight_off");
  self play_fx("helicopter_drone_spotlight_cheap", undefined, undefined, "death", 1, "tag_spotlight");

  if(self.targetname == "drone_bank") {
    self clearvehgoalpos();
    wait 0.5;
    self setvehgoalpos(self.origin + vectorscale((0, 0, 1), 600.0), 1);
    self waittill("goal");
    self maps\_turret::set_turret_target(level.player, (0, 0, 0), 0);
    nd_guard = getvehiclenode("drone_bank_node", "targetname");
    self setvehgoalpos(nd_guard.origin, 1);
    self waittill("goal");

    while(isalive(level.player)) {
      self setlookatent(level.player);
      self maps\_turret::set_turret_target(level.player, (0, 0, 0), 0);
      self thread drone_fireat_player();
      wait(randomfloatrange(3.0, 4.0));
    }
  } else {
    while(isalive(level.player)) {
      self setlookatent(level.player);
      self maps\_turret::set_turret_target(level.player, (0, 0, 0), 0);
      a_nodes = getvehiclenodearray("drone_attack_node", "script_noteworthy");
      a_sorted = sort_by_distance(a_nodes, level.player.origin);
      self setvehgoalpos(a_sorted[a_sorted.size - 2].origin, 1, 1);
      self thread drone_fireat_player();
      wait(randomfloatrange(3.0, 4.0));
    }
  }
}

clear_flag_on_death(str_flag1, str_flag2) {
  self waittill("death");
  flag_clear(str_flag1);
  flag_clear(str_flag2);
}

drone_fireat_player() {
  self endon("death");
  self thread maps\_turret::fire_turret_for_time(randomfloatrange(2.0, 4.0), 0);
  wait 5;

  for(i = 0; i < randomintrange(1, 3); i++) {
    self thread maps\_turret::fire_turret(1);
    wait 1;
  }

  wait 2;
}

harper_enter_bank() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("player_entered_bank");
  flag_wait("dept_store_entered");
  level.player setlowready(0);
  flag_wait("hand_signals_a_done");
  level.harper clear_cqb_run_anim();

  if(!flag("corpse_alley_exit_harper_started"))
    run_scene("corpse_alley_exit_harper");

  wait 0.5;
  flag_set("move3");
  flag_set("moveto_cafe_side");
  flag_set("spawn_drone_searcher");
  flag_set("drone_searcher_look_left");
  flag_set("drone_searcher_look_away");

  if(flag("drone_attacks_player"))
    flag_set("drone_searcher_done");

  level.harper notify("stop_follow_path");
  wait 0.3;
  level.harper thread harper_end_hand_signals();
  wait 0.2;
  level.harper thread follow_path(getnode("harper_stealth_node_6", "targetname"));
}

harper_attack_drone() {
  level endon("sewer_guards_cleared");
  flag_wait_any("drone_attacks_player", "drone_detected_player");
  wait 1;
  level.harper notify("stop_follow_path");
  level.harper thread harper_shoot_at_drone();
  level thread monitor_drone_attack();
  flag_wait_any("player_entered_bank", "drones_gone");
  level.harper notify("stop_shootat_drone");
  wait 1;
  level.harper thread follow_path(getnode("harper_node_enter_bank", "targetname"));
  flag_wait("tandem_kill_vo");

  if(!flag("drones_gone"))
    level.harper thread harper_shoot_at_drone();
}

harper_beeline_to_bank() {
  level endon("drone_attacks_player");
  level endon("drone_detected_player");
  level endon("drone_searcher_done");
  level endon("drone_searcher_flyoff");
  flag_wait("player_entered_bank");
  flag_set("drone_searcher_done");
  wait 1;
  level.harper notify("stop_follow_path");
  wait 0.2;
  level.harper thread harper_end_hand_signals();
  wait 0.2;
  level.harper thread follow_path(getnode("harper_node_enter_bank", "targetname"));
}

monitor_drone_attack() {
  while(isalive(getent("drone_helicopter", "targetname")) || isalive(getent("drone_searcher", "targetname")) || isalive(getent("drone_bank", "targetname")))
    wait 1;

  flag_set("drones_gone");
}

harper_shoot_at_drone() {
  self endon("stop_shootat_drone");
  level endon("drones_gone");

  while(true) {
    vh_drone1 = getent("drone_helicopter", "targetname");

    if(isDefined(vh_drone1) && flag("drone_intro_attack")) {
      self thread shoot_at_target(vh_drone1, undefined, undefined, randomintrange(4, 6));
      self thread harper_monitor_drone(vh_drone1, "drone_intro_attack");
      wait 6;
      self notify("stop_shoot");
    } else
      self stop_shoot_at_target();

    vh_drone2 = getent("drone_searcher", "targetname");

    if(isDefined(vh_drone2) && flag("drone_searcher_attack")) {
      self thread shoot_at_target(vh_drone2, undefined, undefined, randomintrange(4, 6));
      self thread harper_monitor_drone(vh_drone2, "drone_searcher_attack");
      wait 6;
      self notify("stop_shoot");
    } else
      self stop_shoot_at_target();

    vh_drone3 = getent("drone_bank", "targetname");

    if(isDefined(vh_drone3) && flag("drone_bank_attack")) {
      self thread shoot_at_target(vh_drone3, undefined, undefined, randomintrange(4, 6));
      self thread harper_monitor_drone(vh_drone3, "drone_bank_attack");
      wait 6;
      self notify("stop_shoot");
    } else
      self stop_shoot_at_target();

    wait 1;
  }
}

harper_monitor_drone(vh_drone, str_flag) {
  self endon("stop_shoot");

  while(true) {
    if(!isDefined(vh_drone) || !flag(str_flag)) {
      self stop_shoot_at_target();
      self notify("stop_shoot");
    }

    wait 0.1;
  }
}

sewer_exterior() {
  level.harper_kill = 0;
  level.harper set_ignoreall(1);
  add_flag_function("player_entered_sewer", maps\createart\pakistan_art::sewer);
  add_spawn_function_group("sewer_exterior_guard", "targetname", ::sewer_guard_logic);
  add_spawn_function_veh("sewer_guard_spotlight", ::sewer_guard_spotlight_logic);
  flag_wait("player_entered_bank");
  level.player allowsprint(0);
  level thread maps\pakistan_anim::vo_sewer_exterior();
  trigger_wait("spawn_sewer_guards");
  simple_spawn("sewer_exterior_guard");
  waittill_ai_group_cleared("sewer_guards");
  flag_set("sewer_guards_cleared");

  if(level.harper_kill > 1)
    flag_set("harper_kills_two");

  setmusicstate("PAK_POST_CHOPPER");
  flag_wait("drones_gone");
  flag_wait("sewer_move_up");
  level.cansave = 1;
  level thread harper_anim_blend();
  level thread sewer_entry_fx();
  maps\_scene::run_scene("sewer_entry");
  level.harper setgoalnode(getnode("sewer_interior_harper_cover_initial", "targetname"));
}

sewer_entry_fx() {
  flag_wait("sewer_entry_started");
  m_cutter = get_model_or_models_from_scene("sewer_entry", "sewer_entry_device");
  wait 5.7;
  m_cutter play_fx("cutter_on", m_cutter.origin, undefined, 1.5, 1, "tag_fx");
  wait 0.4;
  m_cutter play_fx("cutter_spark", m_cutter.origin, undefined, 0.89, 1, "tag_fx");
}

harper_anim_blend() {
  flag_wait("sewer_entry_started");
  level.harper maps\_anim::anim_set_blend_out_time(0.2);
}

harper_awareness() {
  flag_wait_or_timeout("sewer_guards_alerted", 8);

  if(!flag("sewer_guards_alerted")) {
    flag_set("sewer_guards_alerted");
    self set_ignoreall(0);
  }

  self.perfectaim = 1;
  self set_ignoresuppression(1);
  flag_wait("sewer_guards_cleared");
  self set_ignoresuppression(0);
  self set_ignoreall(1);
}

_kill_guard_stealth_vo() {
  ai_guard = get_ent("sewer_overwatch_ai", "targetname");

  if(isDefined(ai_guard)) {
    ai_guard waittill("death");
    self say_dialog("harp_smart_move_i_see_mo_0");
  }
}

sewer_exterior_ai_setup() {
  level.harper thread sewer_exterior_harper_movement();
  add_spawn_function_veh("sewer_guard_spotlight", ::sewer_guard_spotlight_logic);
  maps\_vehicle::spawn_vehicles_from_targetname("sewer_guard_spotlight");
}

sewer_guard_spotlight_logic() {
  self endon("death");
  searchlight_turret_tag = "tag_flash";
  s_right = getent("sewer_guard_spotlight_target", "targetname");
  s_left = getstruct(s_right.target, "targetname");
  self play_fx("helicopter_drone_spotlight_cheap", self gettagorigin(searchlight_turret_tag), self gettagangles(searchlight_turret_tag), "sewer_light_off", 1, searchlight_turret_tag);
  self maps\_turret::set_turret_target(s_right, (0, 0, 0), 0);
  s_right thread sewer_searchlight_target_movement(s_left.origin);
}

sewer_searchlight_target_movement(v_pos) {
  level endon("sewer_entered");
  v_org = self.origin;

  while(true) {
    self moveto(v_pos, 8);
    self waittill("movedone");
    self moveto(v_org, 8);
    self waittill("movedone");
  }
}

sewer_guard_logic() {
  self endon("death");
  self disable_long_death();
  self set_ignoreme(1);
  self set_ignoreall(1);
  self thread death_function_sewer_guard();
  self thread sewer_guard_shotat();
  flag_wait("sewer_guards_alerted");
  wait 0.5;
  self set_ignoreme(0);
  self set_ignoreall(0);
  self pakistan_move_mode("cqb");
  self set_goalradius(1024);
}

death_function_sewer_guard() {
  self waittill("death", attacker);
  flag_set("sewer_guards_alerted");

  if(attacker == level.harper)
    level.harper_kill++;
}

sewer_guard_shotat() {
  self endon("death");
  self waittill_any("damage", "gunshot", "grenade_fire");
  flag_set("sewer_guards_alerted");
}

sewer_exterior_harper_movement() {
  self notify("stop_scale_speed_in_water");
  self pakistan_move_mode("cqb");
  self.moveplaybackrate = 1;
  self thread sewer_exterior_harper_movement_complete();
  nd_cover_patrol = getnode("harper_bank_cover_patrol", "targetname");
  self set_goal_node(nd_cover_patrol);
  nd_cover_patrol_passed = getnode("harper_bank_cover_patrol_moveup", "targetname");
  self set_goal_node(nd_cover_patrol_passed);
  flag_wait("player_leaving_bank");
  nd_cover_sewer_dropdown = getnode("harper_bank_cover_water", "targetname");
  self set_goal_node(nd_cover_sewer_dropdown);
}

sewer_exterior_harper_movement_complete() {
  self disable_ai_color();
  flag_wait("sewer_entry_done");
  self enable_ai_color();
}

sewer_interior() {
  walk_anims();
  add_spawn_function_group("intruder_guy1", "targetname", ::intruder_guy_logic);
  add_spawn_function_group("intruder_guy2", "targetname", ::intruder_guy_logic);
  level.harper pakistan_move_mode("cqb");
  set_water_dvars_sewer();
  level thread maps\pakistan_anim::vo_change_level();
  level thread perk_intruder_setup();
  level.harper thread harper_at_ladder();
  level.player notify("mission_finished");
}

turn_off_waterfx() {
  flag_wait("sewer_slide_done");
}

intruder_guy_logic() {
  self endon("death");
  self set_run_anim("patrol_walk");
  self set_ignoreall(1);
  self.goalradius = 4;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.disableturns = 1;
}

walk_anims() {
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
}

harper_at_ladder() {
  flag_wait("harper_at_ladder");
  self thread aim_at_target(getent("sewer_aim_entity", "targetname"));
  wait 3;
  self lookatentity(level.player);
  wait 2;
  self lookatentity();

  while(true) {
    self thread aim_at_target(getent("sewer_aim_entity", "targetname"));
    wait(randomfloatrange(3.0, 6.0));
    self lookatentity(level.player);
    wait(randomfloatrange(3.0, 6.0));
    self lookatentity();
  }
}

perk_intruder_setup() {
  t_perk_use = get_ent("perk_intruder_trigger", "targetname", 1);
  t_perk_use trigger_off();
  t_perk_use setcursorhint("HINT_NOICON");
  t_perk_use sethintstring(&"PAKISTAN_SHARED_PERK_INTRUDER_SOCT");
  level.player waittill_player_has_intruder_perk();
  t_perk_use trigger_on();
  trigger_wait("perk_intruder_logic_trigger");
  set_objective(level.obj_interact_intruder, t_perk_use, "interact");
  t_perk_use waittill("trigger");
  t_perk_use delete();
  set_objective(level.obj_interact_intruder, undefined, "done", undefined, 0);
  bm_door_clip = get_ent("sewer_intruder_perk_door", "targetname", 1);
  m_door = get_ent("intruder_perk_door", "targetname", 1);
  bm_door_clip linkto(m_door, "hinge");
  simple_spawn_single("intruder_guy1");
  simple_spawn_single("intruder_guy2");
  level thread intruder_rumble();
  maps\_scene::run_scene("perk_intruder_unlock");
  flag_set("intruder_perk_used");
  level.player set_temp_stat(1, 1);
  wait 0.1;
  level.player setlowready(1);
  maps\pakistan_anim::vo_sewer_perk_dialog_exchange();
  level.player setlowready(0);
}

intruder_perk_guy_spawn_func() {
  self endon("death");
  self thread intruder_guard_shotat();
  self thread monitor_guard_death();
  self setgoalpos(self.origin);
  flag_wait("intruder_guards_alerted");
  self stopanimscripted(1);
}

intruder_guard_shotat() {
  self endon("death");
  self waittill_any("grenade_fire", "damage", "gunshot", "bulletwhizby", "pain");
  flag_set("intruder_guards_alerted");
}

monitor_guard_death() {
  self waittill("death");
  flag_set("intruder_guards_alerted");
}

corpse_alley_player_jump_rumble(m_player_body) {
  wait 1;
  level.player playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.1, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.06, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.07, 1, level.player.origin, 1000, level.player);
  wait 0.25;
  level.player playrumbleonentity("reload_clipout");
  earthquake(0.05, 1, level.player.origin, 1000, level.player);
}

intruder_rumble() {
  level.player rumble_loop(2, 1, "reload_clipout");
  level.player playrumbleonentity("damage_light");
  earthquake(0.08, 1, level.player.origin, 1000, level.player);
}

anthem_approach_saves() {
  flag_wait("corpse_alley_player_done");
  autosave_by_name("pakistan_anthem_approach");
  flag_wait_any("player_at_cafe", "dept_store_entered");

  if(flag("player_at_cafe")) {
    if(!flag("drone_detected_player"))
      autosave_now("drone_stealth_midpoint");
  } else if(flag("dept_store_entered")) {
    if(!flag("drone_detected_player"))
      autosave_now("drone_stealth_midpoint");
  }

  flag_wait("sewer_entry_done");
  autosave_by_name("pakistan_sewer_interior");
}

player_water_visor() {
  self setwaterdrops(25);
  flag_wait("player_entered_bank");
  self setwaterdrops(0);
  self setwaterdrops(10);
}

skipto_sewer_exterior_bodies() {
  if(is_mature()) {
    maps\pakistan_util::static_bodies_enable("death_pose_", 18, 20);
    flag_wait("sewer_gate_open");
    maps\pakistan_util::static_bodies_disable("death_pose_", 5, 20);
  }

  a_s_align_spots = getstructarray("death_pose_align", "script_noteworthy");

  foreach(s_align in a_s_align_spots)
  s_align structdelete();
}

drone_crash_when_sewer_entered() {
  self endon("death");
  flag_wait("sewer_move_up");
  self notify("stop_logic");
  self setspeed(0);
  wait 1;
  self setspeed(35, 20, 15);
  self setvehgoalpos(self.origin + vectorscale((0, 0, 1), 800.0), 0);
  self waittill("goal");
  self setvehgoalpos(self.origin + (-5000, 2000, 500), 1);
  self waittill("goal");
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

drone_death_hud(player) {
  player waittill("death");
  overlay = newclienthudelem(player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("hud_pak_drone", 90, 60);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
}

harper_end_hand_signals() {
  end_scene("hand_signals_b");
  end_scene("hand_signals_c");
  end_scene("hand_signals_d");
  end_scene("hand_signals_e");
  self setgoalpos(self.origin);
  self waittill("goal");
  end_scene("hand_signals_b");
  end_scene("hand_signals_c");
  end_scene("hand_signals_d");
  end_scene("hand_signals_e");
}

drone_crash() {
  self waittill("crash_move_done");
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
  earthquake(0.5, 1.5, self.origin, 1000);
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}