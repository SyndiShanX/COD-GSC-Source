/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_claw.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\pakistan_util;
#include maps\_turret;
#include maps\_vehicle;
#include maps\_objectives;
#include maps\_scene;
#include maps\_dialog;
#include maps\_music;
#include maps\_osprey;
#include maps\_vehicle_aianim;
#include maps\pakistan_anthem;
#include maps\_glasses;
#include maps\createart\pakistan_2_art;
#include maps\_dynamic_nodes;

skipto_claw() {
  iprintln("CLAW");

  claw_skipto_logic();
  level.b_flamethrower_unlocked = 1;
  level thread maps\pakistan_anthem::anthem_objectives();
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
  flag_set("trainyard_drone_meeting_harper_exit_done");
  flag_set("railyard_player_millibar_start");
  flag_set("trainyard_millibar_grenades_warp_done");
  level.player enableweapons();
}

skipto_claw_no_flamethrower() {
  iprintln("CLAW****NO FLAMETHROWER****");

  claw_skipto_logic();
  level.b_flamethrower_unlocked = 0;
  level thread maps\pakistan_anthem::anthem_objectives();
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
  flag_set("trainyard_drone_meeting_harper_exit_done");
  flag_set("railyard_player_millibar_start");
  flag_set("trainyard_millibar_grenades_warp_done");
  level.player enableweapons();
}

claw_skipto_logic() {
  level.harper = init_hero("harper");
  maps\pakistan_anthem::setup_doors();
  level.player enableweaponcycling();
  level.player enableweaponfire();
  level.player enableoffhandweapons();
  skipto_teleport("skipto_claw", array(level.harper));
}

dev_skipto_ending() {
  iprintln("DEV ENDING");

  level.harper = init_hero("harper");
  s_start = getstruct("street_claw_end_goal_pos", "targetname");
  skipto_teleport("street_claw_end_goal_pos", array(level.harper));
  level.harper forceteleport(s_start.origin, s_start.angles);
}

main() {
  level.player ent_flag_init("player_claw");
  setup_garage_doors();
  claw_event_spawn_funcs();
  courtyard_main();
  claw_setup();
  claw_startup();
  claw_ending();
  claw_cleanup();
}

#using_animtree("vehicles");

setup_garage_doors() {
  trigger_off("soct_mount_trigger", "targetname");
  run_scene_first_frame("claw_garage_defend_door_start");
  m_garage_back_door = getent("garage_back_door", "targetname");
  m_garage_back_door ignorecheapentityflag(1);
  m_garage_back_door connectpaths();
  m_garage_back_door hide();
  m_garage_back_door notsolid();
  m_garage_back_door_2 = getent("garage_back_door_2", "targetname");
  m_garage_back_door_2 ignorecheapentityflag(1);
  m_garage_back_door_2 connectpaths();
  m_garage_back_door_2 hide();
  m_garage_back_door_2 notsolid();
  m_garage_back_door_player_clip = getent("garage_back_door_player_clip", "targetname");
  m_garage_back_door_player_clip connectpaths();
  m_garage_back_door_player_clip hide();
  m_garage_back_door_player_clip notsolid();
  e_garage_entrance = getent("garage_entrance", "targetname");
  e_garage_entrance ignorecheapentityflag(1);
  m_soct_01 = getent("soct_01", "targetname");
  m_soct_01 hidepart("tag_seat_rb");
  m_soct_01 hidepart("tag_gunner_barrel1");
  m_soct_01 hidepart("tag_flash_gunner1");
  m_soct_02 = getent("soct_02", "targetname");
  m_soct_02 hidepart("tag_gunner_barrel1");
  m_soct_02 hidepart("tag_flash_gunner1");
  m_soct_02 hidepart("tag_steeringwheel");
  a_jiffy_window_after = getentarray("jiffy_window_after", "targetname");

  foreach(destroyed_piece in a_jiffy_window_after)
  destroyed_piece hide();

  m_right_path_train_car = getent("right_path_train_car", "targetname");
  m_right_path_train_car useanimtree(#animtree);
  m_right_path_train_car setanim( % veh_anim_pak_train_boxcar_doors_open, 1, 0, 1);
  m_train_door = getent("train_door", "targetname");
  m_train_door useanimtree(#animtree);
  m_train_door setanim( % veh_anim_pak_train_boxcar_doors_open, 1, 0, 1);
}

claw_event_spawn_funcs() {
  a_garage_door_guys = getentarray("garage_door_guys", "targetname");
  array_thread(a_garage_door_guys, ::add_spawn_function, ::init_garage_door_guys);
  a_right_path_runners = getentarray("right_path_runners", "targetname");
  array_thread(a_right_path_runners, ::add_spawn_function, ::init_runner_delete);
  a_ai_courtyard_guys = getentarray("courtyard_guys", "targetname");
  array_thread(a_ai_courtyard_guys, ::add_spawn_function, ::setup_courtyard_guys);
  a_sp_isi = getspawnerteamarray("axis");
  array_thread(a_sp_isi, ::add_spawn_function, ::set_isi_color);
  add_spawn_function_ai_group("garage_breachers", ::setup_garage_breachers);
  add_spawn_function_veh_by_type("heli_osprey_pakistan", ::setup_courtyard_vtols);
}

setup_soct_riders() {
  self endon("death");
  self magic_bullet_shield();
  self gun_remove();
  self set_goalradius(16);
}

setup_courtyard_vtols() {
  self.health = get_difficulty_scaled_health(5000);
}

setup_courtyard_guys() {
  self endon("death");

  if(!flag("claw_start_player_done")) {
    self set_ignoreall(1);
    flag_wait("claw_start_player_done");
    self set_ignoreall(0);
  }
}

setup_garage_breachers() {
  self endon("death");
  self magic_bullet_shield();
  self set_ignoreall(1);
  flag_wait("garage_breacher_done");
  wait 0.5;
  self set_ignoreall(0);
  self stop_magic_bullet_shield();
}

init_runner_delete() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  nd_goal = getnode(self.target, "targetname");
  self thread force_goal(nd_goal, 32, 0);
  self waittill("goal");
  self.ignoreme = 0;
  self.ignoreall = 0;
  self die();
}

init_garage_door_guys() {
  self endon("death");
  self.goalradius = 32;
  self set_ignoreall(1);
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  nd_goal = getnode(self.target, "targetname");
  self setgoalnode(nd_goal);
  self waittill("goal");
  self set_ignoreall(0);
  self.ignoreme = 0;
  self.ignoresuppression = 0;
}

set_isi_color() {
  self set_force_color("r");
}

courtyard_main() {
  if(!isDefined(level.b_flamethrower_unlocked))
    level.b_flamethrower_unlocked = 1;

  level.player setlowready(0);
  level.player allowmelee(1);
  level.harper thread harper_claw_defend_logic();
  intro_courtyard_defend();
}

harper_claw_defend_logic() {
  self set_ignoreme(0);
  self set_ignoreall(0);
  self.oldgrenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  self disable_react();
  self disable_careful();
  self.goalradius = 32;
  self.dontmelee = 1;
  trigger_wait("spawn_pre_garage_guys");
  simple_spawn("pre_garage_guys");
  nd_harper_pre_garage = getnode("harper_pre_garage", "targetname");
  self setgoalnode(nd_harper_pre_garage);
  waittill_ai_group_count("pre_garage_guys", 1);
  array_func(get_ai_group_ai("pre_garage_guys"), ::weaken_ai);
  nd_harper_pre_defend = getnode("harper_pre_defend", "targetname");
  self setgoalnode(nd_harper_pre_defend);
  flag_wait("spawn_spotlight_drone");
  waittill_ai_group_count("garage_guys", 1);
  array_func(get_ai_group_ai("garage_guys"), ::weaken_ai);
  level.player enabledeathshield(1);
  flag_set("start_defend_convoy");
  clientnotify("blur_over");
  autosave_by_name("player_at_garage");
  harper_defend_scene();
  level.player enabledeathshield(0);
}

harper_defend_scene() {
  level thread run_scene("claw_garage_defend_harper_start");
  flag_wait("claw_garage_defend_harper_start_started");
  wait 2.1;
  a_ai_isi = getaiarray("axis");
  ai_isi = get_closest_living(level.harper gettagorigin("tag_flash"), a_ai_isi, 256);

  if(isDefined(ai_isi))
    ai_isi bloody_death();

  flag_wait("claw_garage_defend_harper_start_done");
  nd_harper_defend_cover_node = getnode("harper_defend_cover_node", "targetname");
  self setgoalnode(nd_harper_defend_cover_node);
}

weaken_ai() {
  self endon("death");
  self.health = 1;
  self.attackeraccuracy = 10;
}

monitor_drone_death() {
  self waittill("death");
  flag_set("drone_is_dead");
  level.harper queue_dialog("harp_good_he_was_really_0", 1);
  level waittill("crash_done");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

intro_courtyard_defend() {
  level thread intro_courtyard_gate_control();
  level.vh_intro_courtyard_drone = spawn_drone_at_struct("courtyard_drone_start_spot", 0, "courtyard_drone", 1, "axis");
  level.vh_intro_courtyard_drone thread monitor_drone_death();
  flag_wait("start_defend_convoy");
  level thread close_door_to_water();
  a_intro_courtyard_convoy = spawn_vehicles_from_targetname_and_drive("intro_courtyard_convoy");

  foreach(veh in a_intro_courtyard_convoy) {
    veh veh_magic_bullet_shield(1);
    veh veh_toggle_tread_fx(0);
  }

  simple_spawn("street_courtyard_squad");
  level thread courtyard_heli_waves();
  spawn_manager_enable("trig_courtyard_main_sm");
  level thread vo_claw_enemy();

  foreach(veh in a_intro_courtyard_convoy)
  veh veh_magic_bullet_shield(0);

  flag_wait("claw_garage_defend_harper_start_done");
  level thread claw_switch_timeout();
  level.player thread monitor_first_claw_switch();
  screen_message_create(&"PAKISTAN_SHARED_STREET_CLAW_SWITCH");
  level thread play_bink_on_hud("pakistan2_trainyard_claw", 0, 1);
  flag_wait("player_switched_to_claw");
  level.player cleardamageindicator();
  clientnotify("aS_off");
  screen_message_delete();
  save_player_first_position();
  setsaveddvar("flame_system_enabled", 1);
  s_intro_align = getstruct("claw_intro_align", "targetname");
  spawn_vehicle_ground_claw();
  level.claw[0].origin = s_intro_align.origin;
  level.claw[0].angles = s_intro_align.angles;
  level thread claw_enemies_intro();
  level.player player_datapad_claw_anim();
  level.player enableinvulnerability();
  flag_set("claw_start_player_done");
  level.claw[0].overridevehicledamage = ::claw_vehicle_damage_override;
  level.claw[0] thread idle_threat_timeout();
}

intro_courtyard_gate_control() {
  m_inner_exit_gate = getent("pak2_outro_gate", "targetname");
  v_move_z = vectorscale((0, 0, 1), 768.0);
  m_inner_exit_gate moveto(m_inner_exit_gate.origin - v_move_z, 0.05);
  level waittill("intro_courtyard_convoy_done");
  waittill_safe_place_to_raise_gate(m_inner_exit_gate);
  m_inner_exit_gate moveto(m_inner_exit_gate.origin + v_move_z, 0.05);
}

waittill_safe_place_to_raise_gate(m_inner_exit_gate) {
  t_garage_trig = getent("garage_player_touching_trig", "targetname");

  while(true) {
    if(level.player istouching(t_garage_trig)) {
      if(!level.player islookingat(m_inner_exit_gate)) {
        break;
      }
    }

    wait 0.2;
  }
}

save_player_first_position() {
  save_player_position();
  save_player_safe_position();
}

save_player_position() {
  t_garage_trig = getent("garage_player_touching_trig", "targetname");

  if(level.player istouching(t_garage_trig)) {
    level.v_player_last_position = level.player.origin;
    level.v_player_last_angles = level.player.angles;
  }
}

save_player_safe_position() {
  t_garage_trig = getent("garage_player_touching_trig", "targetname");
  s_garage_spot = getstruct("player_garage_struct", "targetname");

  if(!level.player istouching(t_garage_trig)) {
    level.v_player_last_position = s_garage_spot.origin;
    level.v_player_last_angles = s_garage_spot.angles;
  }
}

teleport_player_to_last_position() {
  self setorigin(level.v_player_last_position);
  self setplayerangles(level.v_player_last_angles);
  rpc("clientscripts/_vehicle", "damage_filter_disable");
}

monitor_first_claw_switch() {
  level endon("player_switched_to_claw");

  while(true) {
    if(self actionslotthreebuttonpressed())
      flag_set("player_switched_to_claw");

    wait 0.05;
  }
}

claw_switch_timeout() {
  level endon("player_switched_to_claw");
  level thread vo_no_claw_switch();
  wait 10;
  screen_message_delete();
  flag_set("player_switched_to_claw");
}

courtyard_heli_waves() {
  vh_courtyard_heli_1 = spawn_vehicle_from_targetname_and_drive("courtyard_heli_1");
  vh_courtyard_heli_1 veh_magic_bullet_shield(1);
  level.vh_intro_courtyard_drone thread courtyard_drone_behaviour();
  flag_wait("start_switch_ability");
  ai_rooftop_claw = getent("rooftop_claw", "script_noteworthy");
  a_rooftop_rpg_squad = simple_spawn("rooftop_rpg_squad");

  foreach(guy in a_rooftop_rpg_squad)
  guy thread shoot_at_target_untill_dead(ai_rooftop_claw, undefined, 3);

  level.harper thread queue_dialog("harp_watch_out_got_rpgs_0", 1);
  wait 5;
  spawn_vehicle_from_targetname_and_drive("intro_courtyard_convoy_2");
  level notify("intro_courtyard_convoy_done");
  level.harper thread queue_dialog("harp_clear_the_streets_0", 3);
}

courtyard_drone_behaviour() {
  self endon("death");
  self thread drone_window_target();
  s_intro_drone_spotlight_pos = getstruct("intro_drone_spotlight_pos", "targetname");
  self setvehgoalpos(s_intro_drone_spotlight_pos.origin, 1);
  self waittill_any("goal", "near_goal");
  flag_wait("intro_drone_shooting_done");
  e_courtyard_drone_light_target = getent("courtyard_drone_light_target", "targetname");
  self setlookatent(e_courtyard_drone_light_target);
  self set_turret_target(e_courtyard_drone_light_target, (0, 0, 0), 0);
  wait 3;
  level thread watch_window_damage();

  if(isDefined(e_courtyard_drone_light_target))
    self shoot_turret_at_target(e_courtyard_drone_light_target, 3, get_random_vector_range(34, 96), 0);

  wait 3;
  self maps\_turret::set_turret_burst_parameters(1, 3, 2, 5, 0);
  self enable_turret(0);
  self sethoverparams(64);
  self threaten_roof_claw_for_time(7);
  self setlookatent(e_courtyard_drone_light_target);
  flag_wait("start_courtyard_event");

  if(isDefined(level.claw[0]))
    self thread street_claw_exposed_watcher(level.claw[0]);

  self clear_turret_target(0);
  self cleartargetentity();
  self stop_turret(0);
  self disable_turret(0);
  self clearlookatent();

  if(isDefined(level.claw[0])) {
    self setlookatent(level.claw[0]);
    self set_turret_target(level.claw[0], (0, 0, 0), 0);
  }

  s_drone_archway_pos = getstruct("drone_archway_pos", "targetname");
  self setvehgoalpos(s_drone_archway_pos.origin, 1);
  self waittill_any("near_goar", "goal");
  e_archway_drone_target = getent("archway_drone_target", "targetname");

  if(isDefined(level.claw[0]))
    self shoot_turret_at_target(level.claw[0], 3, (0, 0, 0), 0);

  if(isDefined(level.claw[0]))
    self shoot_turret_at_target(level.claw[0], 5, (0, 0, 0), 1);

  self clear_turret_target(0);
  self cleartargetentity();
  self stop_turret(0);
  self disable_turret(0);
  self clearlookatent();

  if(isDefined(level.claw[1])) {
    self setlookatent(level.claw[1]);
    self set_turret_target(level.claw[1], (0, 0, 0), 0);
  }

  s_drone_rooftop_pos = getstruct("drone_rooftop_pos", "targetname");
  self setvehgoalpos(s_drone_rooftop_pos.origin, 1);

  if(!flag("rooftop_claw_dead") || !flag("street_claw_dead"))
    level.harper thread queue_dialog("harp_come_on_man_shoot_0");

  self waittill_any("goal", "near_goal");

  if(isDefined(level.claw[1])) {
    self shoot_turret_at_target(level.claw[1], 3, (0, 0, 0), 0);

    if(isDefined(level.claw[1]))
      self shoot_turret_at_target(level.claw[1], 5, (0, 0, 0), 1);
  }

  if(isDefined(e_courtyard_drone_light_target)) {
    self setlookatent(e_courtyard_drone_light_target);
    self set_turret_target(e_courtyard_drone_light_target, (0, 0, 0), 0);
  }

  self setvehgoalpos(s_intro_drone_spotlight_pos.origin, 1);
  self waittill_any("goal", "near_goal");
  self enable_turret(0);
}

drone_setup(b_expensive_fx) {
  if(!isDefined(b_expensive_fx))
    b_expensive_fx = 1;

  self.drivepath = 1;
  self.script_lights_on = 1;
  self.health = get_difficulty_scaled_health(5000);
  self sethoverparams(128);
  self setneargoalnotifydist(200);

  if(b_expensive_fx == 1) {
    self play_fx("drone_spotlight", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "drone_is_dead", 1, "tag_spotlight");
    self play_fx("spotlight_lens_flare", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), undefined, 1, "tag_spotlight");
  } else
    self play_fx("drone_spotlight_cheap", self gettagorigin("tag_spotlight"), self gettagangles("tag_spotlight"), "death", 1, "tag_spotlight");
}

get_difficulty_scaled_health(n_health) {
  str_difficulty = getdifficulty();

  switch (str_difficulty) {
    case "easy":
      n_health = int(n_health / 1.3);
      break;
    case "difficult":
      n_health = int(n_health * 1.3);
      break;
    case "fu":
      n_health = int(n_health * 1.6);
      break;
  }

  return n_health;
}

drone_ai_shoot(t_garage_trig) {
  self enable_turret(0);

  while(level.player istouching(t_garage_trig))
    wait 0.1;

  self stop_turret(0);
}

threaten_roof_claw_for_time(n_time) {
  level endon("stop_threatening_roof_claw");
  self endon("death");
  ai_rooftop_claw = getent("rooftop_claw", "script_noteworthy");
  self setlookatent(ai_rooftop_claw);
  self set_turret_target(ai_rooftop_claw, (0, 0, 0), 0);
  level thread timeout_then_notify(n_time, "stop_threatening_roof_claw");
  ai_rooftop_claw = return_when_defined(ai_rooftop_claw, "rooftop_claw", "script_noteworthy");

  while(isDefined(ai_rooftop_claw))
    self shoot_turret_at_target(ai_rooftop_claw, 1, get_random_vector_range(-128, 164), randomintrange(1, 3));
}

return_when_defined(e_defined, str_value, str_key) {
  while(!isDefined(e_defined)) {
    e_defined = getent(str_value, str_key);

    if(isDefined(e_defined)) {
      break;
    }

    wait 0.05;
  }

  return e_defined;
}

timeout_then_notify(n_time, str_notify) {
  wait(n_time);
  level notify(str_notify);
}

street_claw_exposed_watcher(e_target) {
  self endon("death");
  e_target endon("death");
  t_courtryard_trig = getent("claw_courtyard_explosed_trig", "targetname");
  t_arch_trig = getent("claw_courtyard_arch_trig", "targetname");
  b_do_switch_nag = 1;

  while(!flag("street_claw_dead")) {
    if(isDefined(self) && isDefined(e_target))
      self drone_suppress_archway_think(e_target, t_courtryard_trig, t_arch_trig, b_do_switch_nag);

    wait 0.15;
  }
}

drone_suppress_archway_think(vh_claw, t_courtryard_trig, t_arch_trig, b_do_switch_nag) {
  b_is_claw_exposed = isDefined(vh_claw) && (vh_claw istouching(t_courtryard_trig) || vh_claw istouching(t_arch_trig));

  if(b_is_claw_exposed) {
    flag_set("street_claw_exposed");

    if(b_do_switch_nag && !flag("street_claw_dead")) {
      level.harper thread queue_dialog("harp_drone_s_hammering_th_0");
      level.harper thread queue_dialog("harp_use_the_claw_on_the_0", 1);
      b_do_switch_nag = 0;
    }

    while(b_is_claw_exposed)
      self shoot_turret_at_target(vh_claw, 1, (randomintrange(-200, 200), randomintrange(-200, 200), 0), randomintrange(1, 3));

    flag_clear("street_claw_exposed");
  }
}

watch_window_damage() {
  trigger_wait("trig_window_damage", "targetname", level.vh_intro_courtyard_drone);
  a_jiffy_window_before = getentarray("jiffy_window_before", "targetname");

  foreach(prestine_piece in a_jiffy_window_before)
  prestine_piece hide();

  a_jiffy_window_after = getentarray("jiffy_window_after", "targetname");

  foreach(destroyed_piece in a_jiffy_window_after)
  destroyed_piece show();
}

drone_window_target() {
  self endon("death");
  e_courtyard_drone_light_target = getent("courtyard_drone_light_target", "targetname");
  e_garage_window_target = getent("garage_window_target", "targetname");

  if(isDefined(e_courtyard_drone_light_target)) {
    self setlookatent(e_courtyard_drone_light_target);
    self set_turret_target(e_courtyard_drone_light_target, (0, 0, 0), 0);
  }

  level waittill("intro_drone_shooting_started");

  if(isDefined(e_garage_window_target))
    self thread shoot_turret_at_target(e_garage_window_target, 4, (0, 0, 0), 0);

  s_garage_window_target_end = getstruct("garage_window_target_end", "targetname");
  e_garage_window_target moveto(s_garage_window_target_end.origin, 3);
  e_garage_window_target waittill("movedone");
  wait 1;

  if(isDefined(e_garage_window_target))
    self thread shoot_turret_at_target(e_garage_window_target, 4, (0, 0, 0), 0);

  s_garage_window_target_end_2 = getstruct("garage_window_target_end_2", "targetname");
  e_garage_window_target moveto(s_garage_window_target_end_2.origin, 3);
  e_garage_window_target waittill("movedone");
  flag_set("intro_drone_shooting_done");
}

claw_turn_on_extracam() {
  e_extra_cam = maps\_glasses::get_extracam();
  e_extra_cam.origin = self gettagorigin("tag_turret");
  e_extra_cam.angles = self gettagangles("tag_turret");
  e_extra_cam linkto(self, "tag_eye", (2, 0, 3));
  maps\_glasses::turn_on_extra_cam();
}

monitor_train_depot_guys() {
  level thread train_left_path();
  level thread train_right_path();
  level thread claw_fail_condition();
  flag_wait("trig_fallback_1");
  vh_train_depot_gaz = spawn_vehicle_from_targetname_and_drive("train_depot_gaz");
  vh_train_depot_gaz veh_magic_bullet_shield(1);
  vh_train_depot_gaz play_fx("fx_vlight_headlight_default", vh_train_depot_gaz.origin, vh_train_depot_gaz.angles, "death", 1, "tag_headlight_left", 1);
  vh_train_depot_gaz play_fx("fx_vlight_headlight_default", vh_train_depot_gaz.origin, vh_train_depot_gaz.angles, "death", 1, "tag_headlight_right", 1);
  vh_train_depot_gaz play_fx("fx_vlight_brakelight_default", vh_train_depot_gaz.origin, vh_train_depot_gaz.angles, "death", 1, "tag_tail_light_left", 1);
  vh_train_depot_gaz play_fx("fx_vlight_brakelight_default", vh_train_depot_gaz.origin, vh_train_depot_gaz.angles, "death", 1, "tag_tail_light_right", 1);
  vh_train_depot_gaz waittill("reached_end_node");
  vh_train_depot_gaz veh_magic_bullet_shield(0);
  flag_wait("trig_fallback_archway");
  simple_spawn("archway_guys");
  waittill_ai_group_ai_count("archway_guys", 2);
  a_str_ai_group = get_ai_group_ai("archway_guys");

  foreach(guy_alive in a_str_ai_group)
  guy_alive thread ai_fallback_reengage("archway_fallback");

  trigger_use("archway_axis_color_trig");
}

claw_fail_condition() {
  level endon("courtyard_event_done");
  trigger_wait("claw_street_warning");
  screen_message_create(&"PAKISTAN_SHARED_COURTYARD_WARNING");
  level thread warning_message_timeout();
  trigger_wait("claw_street_fail");
  a_tunnel_claw_rpgs = getstructarray("tunnel_claw_rpgs", "targetname");

  foreach(s_rpg_start_pos in a_tunnel_claw_rpgs) {
    s_rpg_end_pos = getstruct(s_rpg_start_pos.target, "targetname");
    wait(randomfloat(0.5));
    magicbullet("usrpg_magic_bullet_sp", s_rpg_start_pos.origin, s_rpg_end_pos.origin);
  }

  screen_message_delete();
}

warning_message_timeout() {
  wait 5;
  screen_message_delete();
}

train_left_path() {
  level endon("trig_fallback_archway");
  flag_wait("trig_spawn_left_path_guys");
  simple_spawn("left_path_guys");
  level thread set_flag_retreat_on_group_count("trig_fallback_1", "left_path_guys", 2, "left_guys_fallback_1");
  flag_wait("trig_fallback_1");
  simple_spawn("left_path_guys_backup");
  level thread set_flag_retreat_on_group_count("trig_fallback_archway", "left_path_guys_backup", 2, "archway_fallback");
}

train_right_path() {
  simple_spawn("right_path_guys");
  level thread set_flag_retreat_on_group_count("trig_fallback_1", "right_path_guys", 2, "right_path_fallback_1");
  flag_wait("trig_fallback_1");
  simple_spawn("right_path_guys_backup");
  level thread set_flag_retreat_on_group_count("trig_fallback_archway", "right_path_guys_backup", 2, "archway_fallback");
  wait 2;
  simple_spawn("right_path_runners");
}

set_flag_on_group_cleared(str_flag, str_ai_group) {
  level endon(str_flag);
  waittill_ai_group_cleared(str_ai_group);

  if(!flag(str_flag))
    flag_set(str_flag);
}

set_flag_retreat_on_group_count(str_flag, str_ai_group, n_count, str_spawner_targets) {
  waittill_ai_group_ai_count(str_ai_group, n_count);
  a_str_ai_group = get_ai_group_ai(str_ai_group);

  foreach(guy_alive in a_str_ai_group) {
    guy_alive.pathenemyfightdist = 192;
    guy_alive thread ai_fallback_reengage(str_spawner_targets);
  }

  if(!flag(str_flag))
    flag_set(str_flag);
}

claw_setup() {
  level.claw1_damage_total = 0;
  level.claw1_ai_damage_total = 0;
  level.claw2_damage_total = 0;
  level.claw2_ai_damage_total = 0;
}

claw_enemies_intro() {
  level thread run_scene("dormant_claw_1");
  level thread run_scene("dormant_claw_2");
  level thread run_scene("dormant_claw_3");
  level thread run_scene("dormant_claw_4");
  wait 0.1;
  ai_claw_enemy_1 = getent("claw_enemy_1_ai", "targetname");
  ai_claw_enemy_2 = getent("claw_enemy_2_ai", "targetname");
  ai_claw_enemy_3 = getent("claw_enemy_3_ai", "targetname");
  ai_claw_enemy_4 = getent("claw_enemy_4_ai", "targetname");
  ai_claw_enemy_1 thread scene_wait_and_run("dormant_claw_1", 0);
  ai_claw_enemy_2 thread scene_wait_and_run("dormant_claw_2", 0);
  ai_claw_enemy_3 thread scene_wait_and_run("dormant_claw_3", 0);
  ai_claw_enemy_4 thread scene_wait_and_run("dormant_claw_4", 0);
  scene_wait("dormant_claw_1");
  level thread claw_run_over_destructibles();
  flag_wait_any("trig_fallback_1", "trig_spawn_left_path_guys");
  trigger_use("claw_start_axis_color_trig");
  a_intro_claw_guys = get_ai_group_ai("intro_claw_guys");

  foreach(guy in a_intro_claw_guys)
  guy thread ai_fallback_reengage("archway_fallback");

  autosave_by_name("player_in_claw");
}

scene_wait_and_run(str_scene, b_shoot_retreat) {
  self endon("death");
  self set_ignoreall(1);
  self change_movemode("run");
  scene_wait(str_scene);
  nd_goal = getnode(self.target, "targetname");
  self force_goal(nd_goal, 32, b_shoot_retreat, undefined, 1);
  self set_ignoreall(0);
}

claw_pip_on(ai_pov_claw) {
  update_claw_pip(ai_pov_claw);
  flag_set("claw_pip_on");
}

update_claw_pip(ai_pov_claw) {
  if(isalive(ai_pov_claw))
    ai_pov_claw claw_turn_on_extracam();
}

claw_pip_off() {
  maps\_glasses::turn_off_extra_cam();
  flag_clear("claw_pip_on");
}

claw_startup() {
  flag_init("street_claw_exposed");
  playsoundatposition("sce_transition", (0, 0, 0));
  screen_fade_out(0.25, "compass_static");
  level notify("claw1_startup_screen_faded");
  s_rooftop_claw_goal = getstruct("rooftop_claw_start_spot", "targetname");
  claw_ai_origin = s_rooftop_claw_goal.origin;
  claw_ai_angles = s_rooftop_claw_goal.angles;
  level.claw[1] = simple_spawn_single("claw_ai");
  level.claw[1].script_noteworthy = "rooftop_claw";
  level.claw[1] set_ignoreall(1);
  level.claw[1].overrideactordamage = ::claw_ai_damage_override;
  level.claw[1] forceteleport(claw_ai_origin, claw_ai_angles);
  level.claw[1].b_player_controlled = 0;
  level.claw[1].goalradius = 64;
  level.claw[1] setgoalpos(s_rooftop_claw_goal.origin);
  level.player freezecontrols(1);
  level.player.current_claw = 1;
  level.claw[0] usevehicle(level.player, 0);
  level.claw[0].b_player_controlled = 1;
  level.claw[0] veh_magic_bullet_shield(1);
  level.player.overrideplayerdamage = ::claw_player_damage_override;
  level.player cleardamageindicator();
  maps\createart\pakistan_2_art::turn_on_claw_vision();
  cleanup_intro_defend();
  screen_fade_in(0.25, "compass_static");
  level thread garage_doors_control();
  luinotifyevent(&"hud_pak_claw_controller");
  luinotifyevent(&"hud_pak_highlight_claw", 1, 1);
  level.claw[0] thread rooftop_claw_death_watch(2);
  level.claw[1] thread street_claw_death_watch(1);
  wait 2;
  flag_set("claw_start_ready");
  setmusicstate("PAK_CLAWS");
  level.player freezecontrols(0);
  level.player disableinvulnerability();
  level.player thread claw_grenade_turret_think(level.claw[0]);
  level thread vo_claw_grenade_enemy();
  flag_set("protect_objective_set");
  level thread claw_tutorial();
  level thread monitor_train_depot_guys();
  flag_wait("trig_fallback_archway");
  flag_set("start_switch_ability");
  level thread ending_timeout();
  level.claw[1] set_goalradius(64);
  level.claw[1] set_ignoreall(0);
  level.player thread claw_switch_think();
  level thread harper_switch_claw_nag();
  flag_wait("start_courtyard_event");
}

harper_switch_claw_nag() {
  level endon("start_courtyard_event");
  level endon("player_switched_to_claw");
  wait 5;
  level.harper thread queue_dialog("harp_keep_an_eye_on_the_v_1", 0, undefined, "player_switched_to_claw");
  wait 3;
  level.harper thread queue_dialog("harp_switch_section_0", 0, undefined, "player_switched_to_claw");
}

claw_player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  level.player cleardamageindicator();
  return false;
}

cleanup_intro_defend() {
  a_heli_1_drop_guys = get_ai_group_ai("heli_1_drop_guys");

  foreach(guy in a_heli_1_drop_guys)
  guy delete();

  a_garage_door_guys = get_ai_group_ai("garage_door_guys");

  foreach(guy in a_garage_door_guys)
  guy delete();

  a_gaz_tigr_guys = get_ai_group_ai("gaz_tigr_guys");

  foreach(guy in a_gaz_tigr_guys)
  guy delete();

  a_street_courtyard_squad = get_ai_group_ai("street_courtyard_squad");

  foreach(guy in a_street_courtyard_squad)
  guy delete();

  a_garage_nodes = getnodearray("garage_nodes", "targetname");

  foreach(node in a_garage_nodes)
  node maps\_dynamic_nodes::node_disconnect_from_path();
}

ending_timeout() {
  flag_wait("start_switch_ability");
  wait 25;
  level thread ending_dialog();
  wait 30;

  if(!flag("drone_is_dead")) {
    e_courtyard_drone_light_target = getent("courtyard_drone_light_target", "targetname");
    level.vh_intro_courtyard_drone disable_turret(0);
    level.vh_intro_courtyard_drone setlookatent(e_courtyard_drone_light_target);
    level.vh_intro_courtyard_drone set_turret_target(e_courtyard_drone_light_target, (0, 0, 0), 0);
  }

  spawn_manager_disable("trig_courtyard_main_sm");
  flag_set("courtyard_event_done");
  flag_set("spawn_garage_breachers");
  wait 5;

  if(!flag("drone_is_dead")) {
    level.vh_intro_courtyard_drone enable_turret(0);
    s_drone_fallback_pos = getstruct("drone_fallback_pos", "targetname");
    level.vh_intro_courtyard_drone setvehgoalpos(s_drone_fallback_pos.origin, 1);
  }
}

make_claw_ai() {
  new_claw_ai_origin = self.origin;
  new_claw_ai_angles = self.angles;
  level.player notify("stop_claw_grenade_turret");
  self notify("stop_death_think");
  self usevehicle(level.player, 0);
  wait 0.05;

  if(self == level.claw[0]) {
    level.claw[0] = simple_spawn_single("claw_ai");
    level.claw[0].script_noteworthy = "street_claw";
    ai_claw = level.claw[0];
    level.claw[0].b_player_controlled = 0;
    s_street_claw_archway_goal = getstruct("street_claw_archway_goal", "targetname");
    vec_self_goal_pos = s_street_claw_archway_goal.origin;
  } else if(self == level.claw[1]) {
    level.claw[1] = simple_spawn_single("claw_ai");
    level.claw[1].script_noteworthy = "rooftop_claw";
    ai_claw = level.claw[1];
    level.claw[1].b_player_controlled = 0;
    s_rooftop_claw_goal = getstruct("rooftop_claw_start_spot", "targetname");
    vec_self_goal_pos = s_rooftop_claw_goal.origin;
  }

  wait 0.05;
  self delete();
  ai_claw.overrideactordamage = ::claw_ai_damage_override;
  ai_claw forceteleport(new_claw_ai_origin, new_claw_ai_angles);
  ai_claw set_goalradius(64);
  ai_claw setgoalpos(vec_self_goal_pos);
}

switch_to_player() {
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  level notify("exit_vehicle");
  playsoundatposition("sce_transition_short", (0, 0, 0));
  screen_message_delete();
  screen_fade_out(0.1, "compass_static");
  clientnotify("end_damage_filter");

  if(flag("protect_objective_set"))
    flag_clear("protect_objective_set");

  maps\createart\pakistan_2_art::turn_off_claw_vision();
  rpc("clientscripts/_vehicle", "damage_filter_disable");
  rpc("clientscripts/_vehicle", "damage_filter_off");
  level.player teleport_player_to_last_position();
  level thread screen_fade_in(0.25, "compass_static");
  level.player thread player_claw_idle_death_timeout();
  level.player.overrideplayerdamage = undefined;
  level.player freezecontrols(0);
  level.player disableinvulnerability();
}

player_claw_idle_death_timeout() {
  self endon("player_swtiched_to_claw");
  level endon("courtyard_event_done");

  while(true) {
    wait 10;

    if(!flag("street_claw_dead"))
      kill_ai_street_claw();
    else if(!flag("rooftop_claw_dead")) {
      kill_ai_roof_claw();

      if(!flag("start_courtyard_event"))
        flag_set("start_courtyard_event");
    }

    wait 0.2;
  }
}

kill_ai_street_claw() {
  kill_ai_claw("street_claw_dead", "street_claw");
  level.harper queue_dialog("harp_our_claw_just_got_fu_0");
  luinotifyevent(&"hud_pak_remove_claw_controller", 1, 1);
}

kill_ai_roof_claw() {
  kill_ai_claw("rooftop_claw_dead", "rooftop_claw");
  level.harper queue_dialog("harp_that_claw_s_in_fucki_0");
  luinotifyevent(&"hud_pak_remove_claw_controller", 1, 2);
}

kill_ai_claw(str_flag, str_noteworthy) {
  ai_claw = getent(str_noteworthy, "script_noteworthy");

  if(isDefined(ai_claw)) {
    ai_claw notify("death");
    ai_claw die();
  }

  if(!flag(str_flag))
    flag_set(str_flag);
}

make_player_controlled_claw() {
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  new_claw_vehicle_origin = self.origin;
  new_claw_vehicle_angles = self.angles;
  new_claw_ai_origin = self.origin;
  new_claw_ai_angles = self.angles;
  playsoundatposition("sce_transition_short", (0, 0, 0));
  screen_message_delete();
  screen_fade_out(0.1, "compass_static");

  if(!flag("protect_objective_set"))
    flag_set("protect_objective_set");

  vh_player_claw = self spawn_vehicle_claw(new_claw_vehicle_origin, new_claw_vehicle_angles);
  wait 0.05;

  if(isDefined(self))
    self delete();

  save_player_position();
  vh_player_claw usevehicle(level.player, 0);
  vh_player_claw.overridevehicledamage = ::claw_vehicle_damage_override;
  vh_player_claw thread idle_threat_timeout();
  vh_player_claw veh_magic_bullet_shield(1);
  maps\createart\pakistan_2_art::turn_on_claw_vision();
  level.player thread claw_grenade_turret_think(vh_player_claw);
  screen_fade_in(0.5, "compass_static");
  level.player freezecontrols(0);
}

spawn_vehicle_claw(v_origin, v_angles) {
  if(self == level.claw[0]) {
    spawn_vehicle_ground_claw();
    vh_player_claw = level.claw[0];
    level.claw[0].b_player_controlled = 1;
    level.claw[0] thread claw_run_over_enemy_watcher();
    vh_player_claw.origin = v_origin;
    vh_player_claw.angles = v_angles;
  } else if(self == level.claw[1]) {
    level.claw[1] = spawn_vehicle_from_targetname("starting_claw_no_flamethrower");
    vh_player_claw = level.claw[1];
    level.claw[1].b_player_controlled = 1;
    s_rooftop_claw_goal = getstruct("rooftop_claw_start_spot", "targetname");
    vh_player_claw.origin = s_rooftop_claw_goal.origin;
    vh_player_claw.angles = s_rooftop_claw_goal.angles;

    if(isDefined(level.vh_intro_courtyard_drone)) {
      level.claw[1] setlookatent(level.vh_intro_courtyard_drone);
      level.player look_at(level.vh_intro_courtyard_drone);
    }
  }

  return vh_player_claw;
}

spawn_vehicle_ground_claw() {
  if(level.b_flamethrower_unlocked)
    level.claw[0] = spawn_vehicle_from_targetname("starting_claw_with_flamethrower");
  else
    level.claw[0] = spawn_vehicle_from_targetname("starting_claw_no_flamethrower");

  level.claw[0] thread claw_run_over_enemy_watcher();
}

claw_run_over_destructibles() {
  a_t_dustructible_area = getentarray("destructible_area_trig", "targetname");
  array_thread(a_t_dustructible_area, ::claw_run_over_destructible_think);
}

claw_run_over_destructible_think() {
  level endon("courtyard_event_done");
  self trigger_wait();
  self maps\pakistan_util::radial_damage_from_spot();
}

claw_switch_think() {
  flag_clear("stop_claw_switch_think");
  flag_set("claw_switch_done");

  while(!flag("stop_claw_switch_think")) {
    if(self actionslottwobuttonpressed() && level.player.current_claw != 0) {
      flag_clear("claw_switch_done");
      level.player.current_claw = 0;
      level.player ent_flag_clear("player_claw");

      if(!flag("street_claw_dead")) {
        if(level.claw[0].b_player_controlled)
          level.claw[0] make_claw_ai();
      }

      if(!flag("rooftop_claw_dead")) {
        if(level.claw[1].b_player_controlled)
          level.claw[1] make_claw_ai();
      }

      if(!isDefined(level.claw[0]) || !level.claw[0].b_player_controlled || !level.claw[1].b_player_controlled) {
        switch_to_player();
        luinotifyevent(&"hud_pak_highlight_claw", 1, 3);
      }

      flag_set("claw_switch_done");
    }

    if(self actionslotthreebuttonpressed() && level.player.current_claw != 1 && !flag("street_claw_dead")) {
      flag_clear("claw_switch_done");
      level.player.current_claw = 1;
      level.player ent_flag_set("player_claw");
      level.player notify("player_swtiched_to_claw");

      if(!flag("rooftop_claw_dead")) {
        if(level.claw[1].b_player_controlled)
          level.claw[1] make_claw_ai();
      }

      if(!level.claw[0].b_player_controlled) {
        if(flag("rooftop_claw_dead"))
          level.player player_datapad_claw_anim();

        level.claw[0] make_player_controlled_claw();
        luinotifyevent(&"hud_pak_highlight_claw", 1, 1);
      }

      flag_set("claw_switch_done");
    }

    if(self actionslotfourbuttonpressed() && level.player.current_claw != 2 && !flag("rooftop_claw_dead")) {
      flag_clear("claw_switch_done");
      level.player.current_claw = 2;
      level.player ent_flag_set("player_claw");
      level.player notify("player_swtiched_to_claw");

      if(!flag("street_claw_dead")) {
        if(level.claw[0].b_player_controlled)
          level.claw[0] make_claw_ai();
      }

      if(!level.claw[1].b_player_controlled) {
        if(flag("street_claw_dead"))
          level.player player_datapad_claw_anim();

        level.claw[1] make_player_controlled_claw();
        luinotifyevent(&"hud_pak_highlight_claw", 1, 2);
      }

      flag_set("claw_switch_done");
    }

    wait 0.05;
  }
}

player_datapad_claw_anim() {
  self enableinvulnerability();
  str_current_weapon = self getcurrentweapon();
  self giveweapon("data_glove_claw_sp");
  self switchtoweapon("data_glove_claw_sp");
  self waittill("weapon_change_complete");
  self disableweaponcycling();
  self disableweaponfire();
  self disableoffhandweapons();
  level thread maps\pakistan_util::datapad_rumble();
  self switchtoweapon(str_current_weapon);
  wait 0.2;
  self takeweapon("data_glove_claw_sp");
  self enableweaponcycling();
  self enableweaponfire();
  self enableoffhandweapons();
  self disableinvulnerability();
}

claw_grenade_turret_think(veh_claw) {
  veh_claw endon("death");
  level endon("courtyard_event_done");
  self endon("stop_claw_grenade_turret");
  delay_time = 1.5;

  while(true) {
    waittill_frag_button_pressed(self);
    veh_claw claw_fire_grenade(delay_time);
    wait(delay_time);
  }
}

waittill_frag_button_pressed(e_player) {
  level endon("courtyard_event_done");

  while(!e_player fragbuttonpressed())
    wait 0.05;
}

claw_fire_grenade(delay_time) {
  level endon("courtyard_event_done");
  self endon("death");
  n_grenade_speed_scale = 3000;
  n_grenade_timer = 1.25;
  n_grenade_max_range = 4096;
  v_start_pos = self gettagorigin("tag_barrel");

  if(level.wiiu)
    v_end_pos = v_start_pos + anglestoforward(level.player getgunangles()) * n_grenade_max_range;
  else
    v_end_pos = v_start_pos + anglestoforward(self gettagangles("tag_barrel")) * n_grenade_max_range;

  v_grenade_velocity = vectornormalize(v_end_pos - v_start_pos) * n_grenade_speed_scale;
  driver = self getseatoccupant(0);

  if(!isDefined(driver))
    driver = self;

  driver magicgrenadetype("claw_grenade_impact_explode_sp", v_start_pos, v_grenade_velocity, delay_time);
  self playsound("wpn_claw_gren_fire_plr");
  level thread grenade_launch_rumble();
  luinotifyevent(&"hud_claw_grenade_fire", 1, int(n_grenade_timer * 1000));
}

grenade_launch_rumble() {
  level.player playrumbleonentity("damage_light");
  wait 0.1;
  earthquake(0.07, 1, level.player.origin, 1000, level.player);
  level.player playrumbleonentity("damage_heavy");
}

claw_ai_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(einflictor.script_noteworthy) && einflictor.script_noteworthy == "courtyard_drone" && !flag("street_claw_dead")) {
    if(!level.claw[0].b_player_controlled && !flag("street_claw_dead")) {
      level.claw1_damage_total = level.claw1_damage_total + idamage;

      iprintln(level.claw1_damage_total);

      if(level.claw1_ai_damage_total > 10000) {
        if(!flag("street_claw_dead")) {
          self notify("death");
          flag_set("street_claw_dead");
        }
      }
    } else if(isDefined(einflictor.script_noteworthy) && einflictor.script_noteworthy == "courtyard_drone" && !flag("rooftop_claw_dead")) {
      if(level.claw[1].b_player_controlled && !flag("rooftop_claw_dead")) {
        level.claw2_damage_total = level.claw2_damage_total + idamage;

        iprintln(level.claw1_damage_total);

        if(level.claw2_ai_damage_total > 10000) {
          if(!flag("rooftop_claw_dead")) {
            self notify("death");
            flag_set("rooftop_claw_dead");
          }
        }
      }
    }
  }

  return idamage;
}

claw_vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(level.player.current_claw == 1) {
    if(einflictor.classname == "actor_Enemy_ISI_Pakistan_Launcher_Base" || sweapon == "usrpg_magic_bullet_sp")
      level.claw1_damage_total = level.claw1_damage_total + idamage;

    level.claw1_damage_total = level.claw1_damage_total + idamage;

    if(flag("street_claw_exposed"))
      level.claw1_damage_total = level.claw1_damage_total + idamage * 2;

    iprintln(level.claw1_damage_total);

    if(level.claw1_damage_total > 10000) {
      if(!flag("street_claw_dead")) {
        flag_set("street_claw_dead");
        self thread player_street_claw_death_think();
        set_brutus_dependent_flags();
      }
    }
  } else if(level.player.current_claw == 2) {
    if(einflictor.classname == "actor_Enemy_ISI_Pakistan_Launcher_Base" || sweapon == "usrpg_magic_bullet_sp")
      level.claw1_damage_total = level.claw1_damage_total + idamage;

    level.claw2_damage_total = level.claw2_damage_total + idamage;

    if(einflictor.classname == "actor_Enemy_ISI_Pakistan_Launcher_Base")
      level.claw1_damage_total = level.claw1_damage_total + idamage * 3;

    if(level.claw2_damage_total > 10000) {
      if(!flag("rooftop_claw_dead")) {
        flag_set("rooftop_claw_dead");
        self thread player_rooftop_claw_death_think();
      }
    }
  }

  return idamage;
}

set_brutus_dependent_flags() {
  set_flag_if_not_set("trig_fallback_1");
  set_flag_if_not_set("trig_fallback_archway");
  set_flag_if_not_set("start_courtyard_event");
}

set_flag_if_not_set(str_flag) {
  if(!flag(str_flag))
    flag_set(str_flag);
}

idle_threat_timeout() {
  self endon("delete");
  self endon("death");
  wait 8;

  while(true) {
    while(self getspeed() > 0)
      wait 0.5;

    wait 5;

    if(self getspeed() < 0.5)
      self thread magic_rpg_shoot();
  }
}

rpg_magnet() {
  self endon("delete");
  self endon("death");
  a_ai_array = getaiarray("axis");

  for(i = 0; i <= a_ai_array.size; i++) {
    if(isalive(a_ai_array[i]) && a_ai_array[i].classname == "actor_Enemy_ISI_Pakistan_Launcher_Base")
      a_ai_array[i] shoot_at_target_untill_dead(self);

    wait 0.05;
  }
}

magic_rpg_shoot() {
  self endon("delete");
  self endon("death");
  t_archway = getent("claw_courtyard_arch_trig", "targetname");

  for(i = 0; i <= 3; i++) {
    if(distance2d(t_archway.origin, self.origin) > 256 || level.player get_dot_from_eye(t_archway.origin, 0) < 0.5) {
      magicbullet("usrpg_magic_bullet_sp", t_archway.origin, self.origin, self, self);
      randomfloatrange(0.5, 0.75);
    }
  }
}

player_rooftop_claw_death_think() {
  flag_set("stop_claw_switch_think");
  flag_wait("claw_switch_done");
  self.overrideactordamage = undefined;
  screen_fade_out(0.1, "compass_static");
  self useby(level.player);
  self.b_player_controlled = 0;
  wait 0.05;
  level.player teleport_player_to_last_position();
  level.player ent_flag_clear("player_claw");
  maps\createart\pakistan_2_art::turn_off_claw_vision();
  level notify("exit_vehicle");
  level.harper queue_dialog("harp_that_claw_s_in_fucki_0");
  level.player.current_claw = 0;
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  playsoundatposition("sce_transition_short", (0, 0, 0));
  screen_message_delete();
  luinotifyevent(&"hud_pak_highlight_claw", 1, 3);

  if(flag("protect_objective_set"))
    flag_clear("protect_objective_set");

  screen_fade_in(0.25, "compass_static");
  rpc("clientscripts/_vehicle", "damage_filter_disable");
  rpc("clientscripts/_vehicle", "damage_filter_off");

  if(!flag("street_claw_dead")) {
    screen_message_create(&"PAKISTAN_SHARED_STREET_CLAW_SWITCH");
    level thread screen_message_delete_timeout();
  }

  level.player freezecontrols(0);
  level.player disableinvulnerability();
  self veh_magic_bullet_shield(0);
  level.player thread claw_switch_think();
  self notify("death");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

player_street_claw_death_think() {
  flag_set("stop_claw_switch_think");
  flag_wait("claw_switch_done");
  self.overrideactordamage = undefined;
  level notify("claw_destroyed");
  clientnotify("claw_damage_filter_enable");
  wait 2;
  screen_fade_out(0.1, "compass_static");
  self useby(level.player);
  self.b_player_controlled = 0;
  wait 0.05;
  level.player teleport_player_to_last_position();
  level.player ent_flag_clear("player_claw");
  maps\createart\pakistan_2_art::turn_off_claw_vision();
  level notify("exit_vehicle");
  level.harper thread say_dialog("harp_our_claw_just_got_fu_0");
  level.player.current_claw = 0;
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  playsoundatposition("sce_transition_short", (0, 0, 0));
  screen_message_delete();
  luinotifyevent(&"hud_pak_highlight_claw", 1, 3);

  if(flag("protect_objective_set"))
    flag_clear("protect_objective_set");

  screen_fade_in(0.25, "compass_static");
  rpc("clientscripts/_vehicle", "damage_filter_disable");
  rpc("clientscripts/_vehicle", "damage_filter_off");

  if(!flag("rooftop_claw_dead")) {
    level.harper thread say_dialog("harp_take_control_of_maxi_0", 0);
    screen_message_create(&"PAKISTAN_SHARED_ROOFTOP_CLAW_SWITCH");
    level thread screen_message_delete_timeout();
  }

  level.player freezecontrols(0);
  level.player disableinvulnerability();

  if(isDefined(self))
    self veh_magic_bullet_shield(0);

  level.player thread claw_switch_think();
  self notify("death");

  if(isDefined(self)) {
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  }
}

rooftop_claw_death_watch(claw_number) {
  level endon("courtyard_event_done");
  flag_wait("rooftop_claw_dead");
  luinotifyevent(&"hud_pak_remove_claw_controller", 1, claw_number);
}

street_claw_death_watch(claw_number) {
  level endon("courtyard_event_done");
  flag_wait("street_claw_dead");
  luinotifyevent(&"hud_pak_remove_claw_controller", 1, claw_number);
}

ai_fallback_reengage(str_spawner_target) {
  self endon("death");
  self change_movemode("sprint");
  self set_ignoreall(1);
  self set_spawner_targets(str_spawner_target);
  self waittill("goal");
  self change_movemode("run");
  self set_ignoreall(0);
}

claw_ending() {
  flag_wait("courtyard_event_done");
  luinotifyevent(&"hud_pak_claw_controller_close");
  flag_set("pakistan_is_raining");
  level thread courtyard_rain();
  a_heli_3_drop_guys = get_ai_group_ai("heli_3_drop_guys");

  foreach(guy in a_heli_3_drop_guys)
  guy die();

  flag_set("stop_claw_switch_think");
  autosave_by_name("claw_clear");
  ending_switch_to_player();
  clientnotify("end_damage_filter_watcher");
  cleanup_ai_claws();
  level notify("exit_garage");
  level thread garage_cleanup_ai();
  level.player disableinvulnerability();
  courtyard_drone_cleanup();
  level thread friendly_convoy();
  level thread harper_ending();
  level thread courtyard_cleanup_timeout();
  setmusicstate("PAK_POST_CLAW");
  flag_wait("mount_soct_player_started");
}

ending_switch_to_player() {
  if(isDefined(level.claw[0]) && level.claw[0].b_player_controlled && !flag("street_claw_dead"))
    level.claw[0] remove_player_from_claw();
  else if(isDefined(level.claw[1]) && level.claw[1].b_player_controlled && !flag("rooftop_claw_dead"))
    level.claw[1] remove_player_from_claw();
}

remove_player_from_claw() {
  level notify("claw_event_over");
  level.player notify("stop_claw_grenade_turret");
  playsoundatposition("sce_transition", (0, 0, 0));
  screen_fade_out(0.25, "compass_static");
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  self useby(level.player);
  self notify("stop_death_think");
  wait 0.05;
  rpc("clientscripts/_vehicle", "damage_filter_disable");
  rpc("clientscripts/_vehicle", "damage_filter_off");
  level.player teleport_player_to_last_position();

  if(isDefined(self)) {
    self.delete_on_death = 1;
    self notify("death");

    if(!isalive(self))
      self delete();
  }

  maps\createart\pakistan_2_art::turn_off_claw_vision();
  level.player.overrideplayerdamage = undefined;
  level thread screen_fade_in(0.5, "compass_static");
  level.player freezecontrols(0);
  level thread maps\pakistan_util::disable_player_weapon_fire_for_time(1);
}

cleanup_ai_claws() {
  a_ai_claws = get_ai_array("claw_ai_ai", "targetname");
  array_delete(a_ai_claws);
}

courtyard_drone_cleanup() {
  if(isDefined(level.vh_intro_courtyard_drone))
    level.vh_intro_courtyard_drone notify("death");

  wait 0.1;
}

level_notify_claws_survival_status() {
  if(!flag("rooftop_claw_dead") && !flag("street_claw_dead"))
    level notify("claws_survived");
  else
    level notify("claws_destroyed");
}

hostile_drones_timeout() {
  wait 7;
  a_vh_drones = get_vehicle_array("hostile_drone", "script_noteworthy");

  foreach(vh_drone in a_vh_drones) {
    if(isDefined(vh_drone)) {
      radiusdamage(vh_drone.origin, 128, 8000, 10000);
      wait 1;
    }
  }
}

garage_cleanup_ai() {
  wait 3;
  a_ai_isi = getaiarray("axis");

  foreach(ai_isi in a_ai_isi)
  ai_isi die();
}

courtyard_cleanup_timeout() {
  trigger_wait("claw_courtyard_explosed_trig");
  wait 6;
  a_ai_enemies = getaiarray("axis");

  foreach(ai_enemy in a_ai_enemies)
  ai_enemy die();
}

start_ending_claws() {
  wait 1;
  try_to_start_ending_claw("street_claw_dead", "claw_1_ending_pos", "ending_street_claw", "street_claw_end_goal_pos", 1);
  try_to_start_ending_claw("rooftop_claw_dead", "rooftop_claw_goal", "ending_rooftop_claw", "claw_2_ending_pos");
}

try_to_start_ending_claw(str_flag, str_start_struct, str_noteworthy, str_goal_struct, b_do_rumble) {
  if(!isDefined(b_do_rumble))
    b_do_rumble = 0;

  if(!flag(str_flag)) {
    ai_claw = spawn_ending_claw_at_struct(str_start_struct);
    ai_claw.script_noteworthy = str_noteworthy;
    ai_claw thread ending_claw_behaviour(str_goal_struct);

    if(isDefined(b_do_rumble) && b_do_rumble == 1)
      ai_claw thread ai_claw_walk_rumble();
  }
}

garage_doors_control() {
  level endon("mount_soct_harper_started");
  t_trig = getent("trigger_garage_jiffylube", "targetname");

  while(!level.player istouching(t_trig))
    wait 0.05;

  m_garage_door_back = getent("garage_door_back", "targetname");
  m_garage_door_back delete();
  m_garage_door_back_2 = getent("garage_door_back_2", "targetname");
  m_garage_door_back_2 delete();
  m_garage_back_door = getent("garage_back_door", "targetname");
  m_garage_back_door show();
  m_garage_back_door solid();
  m_garage_back_door_2 = getent("garage_back_door_2", "targetname");
  m_garage_back_door_2 show();
  m_garage_back_door_2 solid();
  m_garage_back_door_2 disconnectpaths();
  m_garage_back_door_player_clip = getent("garage_back_door_player_clip", "targetname");
  m_garage_back_door_player_clip show();
  m_garage_back_door_player_clip solid();
  m_garage_back_door_player_clip disconnectpaths();
  level waittill("claws_destroyed");
  waittill_player_in_good_spot_to_breach();
  level thread garage_breachers();
  m_garage_back_door_player_clip connectpaths();
  m_garage_back_door_player_clip delete();
  m_garage_back_door rotateyaw(-145, 1);
  m_garage_back_door_2 rotateyaw(145, 1);
  s_garage_back_door_fx = getstruct("garage_back_door_fx", "targetname");
  playfx(getfx("door_breach"), s_garage_back_door_fx.origin);
  m_garage_door_back waittill("movedone");
  m_garage_door_back rotateyaw(15, 0.5);
  m_garage_back_door_2 rotateyaw(-20, 0.5);
  wait 5;
  level notify("exit_garage");
  waittill_ai_group_ai_count("garage_breachers", 1);
  array_func(get_ai_group_ai("garage_breachers"), ::weaken_ai);
}

waittill_player_in_good_spot_to_breach() {
  t_breach_trig = getent("garage_breach_zone_trig", "targetname");
  level.player waittill_player_clear_of_breach_zone(t_breach_trig);
  level.player waittill_player_looking_at(t_breach_trig.origin);
  t_breach_trig thread delay_delete();
}

delay_delete() {
  wait_network_frame();
  self delete();
}

waittill_player_clear_of_breach_zone(t_touching) {
  while(self istouching(t_touching))
    wait 0.1;
}

garage_breachers() {
  a_ai_breachers = simple_spawn("garage_breachers");
  level thread garage_breach_rumble();
  level thread run_scene("garage_breacher");
  flag_wait("garage_breacher_started");
  level.player set_ignoreme(1);
  wait 2;
  level.player set_ignoreme(0);
}

friendly_convoy() {
  flag_init("ending_hostile_drones_dead");
  flag_wait("drone_is_dead");
  vh_claw_player_soct = spawn_vehicle_from_targetname("claw_player_soct");
  start_ending_drones(vh_claw_player_soct);
  start_ending_claws();
  level thread hostile_drones_timeout();
  vh_claw_player_soct attach("veh_t6_mil_soc_t_steeringwheel", "tag_steeringwheel");
  vh_claw_player_soct veh_magic_bullet_shield(1);
  vh_claw_player_soct thread notify_end_position();
  vh_claw_player_soct playsound("evt_driveup_1");
  vh_claw_player_soct.dontunloadonend = 1;
  vh_claw_player_soct thread go_path(getnode("soct_start", "targetname"));
  wait 1.5;
  vh_claw_salazar_soct = spawn_vehicle_from_targetname_and_drive("claw_salazar_soct");
  vh_claw_salazar_soct attach("veh_t6_mil_soc_t_steeringwheel", "tag_steeringwheel");
  vh_claw_salazar_soct veh_magic_bullet_shield(1);
  vh_claw_salazar_soct playsound("evt_driveup_2");
  vh_claw_salazar_soct.dontunloadonend = 1;
  a_ai_soct_riders = get_ai_array("soct_riders", "script_noteworthy");
  array_func(a_ai_soct_riders, ::setup_soct_riders);
  a_intro_courtyard_convoy = getentarray("intro_courtyard_convoy", "targetname");

  foreach(veh in a_intro_courtyard_convoy) {
    if(isDefined(veh))
      veh notify("death");
  }

  vh_claw_player_soct waittill("reached_end_node");
  flag_wait("ending_hostile_drones_dead");
  wait 3;
  level_notify_claws_survival_status();
  trigger_on("soct_mount_trigger", "targetname");
  trigger_wait("soct_mount_trigger");
  set_objective(level.obj_escape, getstruct("soct_mount_objective_marker", "targetname"), "remove");
  vh_claw_player_soct thread crosby_unload_from_soct();
  run_scene("mount_soct_player");
  set_objective(level.obj_escape, undefined, "done");
}

crosby_unload_from_soct() {
  flag_wait("mount_soct_player_started");
  self notify("unload");
  ai_driver = getent("crosby_ai", "targetname");
  ai_driver thread crosby_enter_salazar_soct(self);
}

start_ending_drones(e_drone_light_target) {
  vh_allied_drone = spawn_drone_at_struct("ending_drone_start_spot", 1, "allied_drone", 1, "allies");
  vh_allied_drone thread allied_drone_behaviour(e_drone_light_target);
}

spawn_drone_at_struct(str_start_struct, b_invulnerable, str_noteworthy, b_expensive_fx, str_team) {
  if(!isDefined(str_start_struct))
    str_start_struct = undefined;

  if(!isDefined(b_invulnerable))
    b_invulnerable = undefined;

  if(!isDefined(b_expensive_fx))
    b_expensive_fx = 0;

  if(!isDefined(str_team))
    str_team = "axis";

  vh_drone = spawn_vehicle_from_targetname("intro_courtyard_drone");

  if(isDefined(str_start_struct)) {
    s_start_spot = getstruct(str_start_struct, "targetname");
    vh_drone.origin = s_start_spot.origin;
    vh_drone.angles = s_start_spot.angles;
  }

  if(isDefined(b_invulnerable) && b_invulnerable == 1)
    vh_drone veh_magic_bullet_shield(1);

  vh_drone drone_setup(b_expensive_fx);
  vh_drone.script_noteworthy = str_noteworthy;
  vh_drone.script_team = str_team;
  return vh_drone;
}

allied_drone_behaviour(e_final_look_target) {
  s_street_spot = getstruct("ending_drone_street_goal", "targetname");
  s_courtyard_goal = getstruct("ending_drone_courtyard_goal", "targetname");
  e_courtyard_drone_light_target = getent("courtyard_drone_light_target", "targetname");
  self setlookatent(e_courtyard_drone_light_target);
  self setspeed(40);
  self setvehgoalpos(s_street_spot.origin + vectorscale((0, 0, 1), 64.0), 1);
  s_street2_spot = getstruct("ending_drone_street2_goal", "targetname");
  self setlookatent(e_courtyard_drone_light_target);
  self setspeed(22);
  self setvehgoalpos(s_street2_spot.origin, 1);
  self _fire_turret_at_targets_untill_dead("hostile_drone", "script_noteworthy");
  flag_set("ending_hostile_drones_dead");
  wait 1.2;

  if(isDefined(e_final_look_target)) {
    self clearturrettarget();
    self set_turret_target(e_final_look_target, vectorscale((-1, 0, 0), 64.0), 0);
    self thread drone_set_turret_target_idle_cycle(e_final_look_target);
  }

  s_end_goal = getstruct("ending_drone_ending_goal", "targetname");
  e_lookat = spawn("script_origin", s_end_goal.origin);
  self setlookatent(e_lookat);
  self setvehgoalpos(s_courtyard_goal.origin, 1);
  self setspeed(8);
}

drone_set_turret_target_idle_cycle(e_target_ent) {
  while(true) {
    wait(randomfloatrange(0.75, 1.5));
    v_rand_offset = (randomfloatrange(-154, -64), randomfloatrange(-26, 12), 0);
    self set_turret_target(e_target_ent, v_rand_offset, 0);
  }
}

ending_hostile_drone_behaviour() {
  self endon("death");
  s_drone_archway_pos = getstruct("drone_archway_pos", "targetname");
  self setvehgoalpos(s_drone_archway_pos.origin, 1);
  self waittill("goal");
  self drone_random_targets();
}

ending_hostile_drone_2_behaviour() {
  self endon("death");
  s_spotlight_pos = getstruct("intro_drone_spotlight_pos", "targetname");
  self setvehgoalpos(s_spotlight_pos.origin, 1);
  self waittill("goal");
  self drone_random_targets();
}

window_target_move_loop() {
  level endon("ending_hostile_drones_dead");
  s_garage_window_target_end = getstruct("garage_window_target_end", "targetname");
  s_garage_window_target_end_2 = getstruct("garage_window_target_end_2", "targetname");
  e_garage_window_target = getent("garage_window_target", "targetname");

  while(true) {
    e_garage_window_target moveto(s_garage_window_target_end.origin, 3);
    e_garage_window_target waittill("movedone");
    e_garage_window_target moveto(s_garage_window_target_end_2.origin, 3);
    e_garage_window_target waittill("movedone");
  }
}

drone_random_targets() {
  self endon("death");
  self endon("delete");
  e_courtyard_drone_light_target = getent("courtyard_drone_light_target", "targetname");
  e_garage_window_target = getent("garage_window_target", "targetname");
  a_e_targets = array(e_courtyard_drone_light_target, e_garage_window_target);

  while(true) {
    e_target = random(a_e_targets);
    self setlookatent(e_target);
    self shoot_turret_at_target(e_target, randomfloatrange(1, 5), (randomfloatrange(32, 65), randomfloatrange(32, 65), randomfloatrange(128, 256)), 0);
  }
}

gunner_exit_soct() {
  nd_gunner_exit_node = getnode("gunner_exit_node", "targetname");
  ai_gunner = getent("salazar_soct_redshirt_ai", "targetname");
  scene_wait("exit_soct_gunner");
  self gun_recall();
  self set_ignoreall(0);
  self change_movemode("cqb_walk");
  self set_goalradius(8);
  self setgoalnode(nd_gunner_exit_node);
}

crosby_enter_salazar_soct(vh_claw_salazar_soct) {
  nd_driver_exit_node = getnode("crosby_mount_soct_node", "targetname");
  wait 1;
  self gun_recall();
  self change_movemode("cqb_walk");
  self set_goalradius(8);
  self setgoalnode(nd_driver_exit_node);
  self waittill("goal");
  level thread run_scene("mount_soct_redshirt");
  flag_wait("mount_soct_redshirt_started");
  ai_crosby = get_ais_from_scene("mount_soct_redshirt", "crosby");
  scene_wait("mount_soct_redshirt");
  ai_crosby enter_vehicle(vh_claw_salazar_soct, "tag_gunner1");
}

notify_end_position() {
  self waittill("reached_end_node");
  flag_set("player_soct_in_position");
}

_fire_turret_at_targets_untill_dead(str_target, str_key, str_team) {
  if(!isDefined(str_team))
    str_team = undefined;

  self endon("stop_firing_turret");
  b_is_drone = isDefined(self.targetname) && self.targetname == "intro_courtyard_drone";
  n_fire_time = 0.22;

  while(true) {
    a_e_targets = get_targets(str_target, str_key, str_team);

    if(!isDefined(a_e_targets) || a_e_targets.size == 0) {
      break;
    }

    foreach(e_target in a_e_targets) {
      if(b_is_drone) {
        self _fire_turret(e_target, 0);

        if(randomintrange(1, 12) > 10)
          self _fire_turret(e_target, 1);

        if(randomintrange(1, 12) > 10)
          self _fire_turret(e_target, 2);

        continue;
      }

      self _fire_turret(e_target, 1);
    }

    wait(n_fire_time);
  }
}

get_targets(str_target, str_key, str_ai_team) {
  if(!isDefined(str_ai_team))
    str_ai_team = undefined;

  a_e_targets = undefined;

  if(isDefined(str_ai_team))
    a_e_targets = getaiarray(str_ai_team);
  else {
    a_e_targets = get_vehicle_array(str_target, str_key);

    if(!isDefined(a_e_targets))
      a_e_targets = getentarray(str_target, str_key);
  }

  return a_e_targets;
}

_fire_turret(e_target, n_index) {
  if(isDefined(e_target) && self can_turret_hit_target(e_target, n_index)) {
    self set_turret_target(e_target, (0, 0, 0), n_index);
    self fire_turret(n_index);
  }
}

spawn_ending_claw_at_struct(str_end_pos) {
  ai_claw = simple_spawn_single("claw_ai");
  a_s_start_spots = getstructarray(str_end_pos, "targetname");
  a_v_start_spots = a_s_start_spots objects_to_vectors();
  v_start_spot = get_closest_point(ai_claw.origin, a_v_start_spots);
  ai_claw magic_bullet_shield();
  ai_claw.turret setturretspinning(0);
  ai_claw set_goalradius(8);
  ai_claw forceteleport(v_start_spot, ai_claw.angles);
  return ai_claw;
}

ending_claw_behaviour(str_goal_struct) {
  s_goal = getstruct(str_goal_struct, "targetname");
  self setgoalpos(s_goal.origin);
}

ending_dialog() {
  level.player queue_dialog("sect_salazar_where_s_ou_0", 0.5);
  level.player queue_dialog("sala_30_seconds_out_0", 1);
  flag_wait("courtyard_event_done");
  level.harper queue_dialog("harp_it_s_now_or_never_m_0", 0.5);
  flag_wait("player_soct_in_position");
  level.player queue_dialog("sect_salazar_1");
  level.harper queue_dialog("harp_ain_t_you_a_sight_fo_0", 0.5);
  level.harper queue_dialog("harp_ain_t_you_a_sight_fo_0", 0.5);
  flag_wait("mount_soct_harper_started");
  level.harper queue_dialog("harp_alright_1", 1);
  level.harper queue_dialog("harp_we_got_the_hacked_dr_0", 0.5);
}

harper_ending() {
  m_garage_front_door_clip = getent("garage_front_door_clip", "targetname");
  m_garage_front_door_clip delete();
  e_garage_entrance = getent("garage_entrance", "targetname");
  e_garage_entrance notsolid();
  run_scene("garage_exit_harper");
  level.harper.goalradius = 32;
  nd_harper_exit = getnode("nd_harper_exit", "targetname");
  level.harper setgoalnode(nd_harper_exit);
  flag_wait("drone_is_dead");
  flag_wait("player_soct_in_position");
  run_scene("mount_soct_harper");
  level thread run_scene("mount_soct_harper_idle");
}

waittill_zero_breachers() {
  while(true) {
    a_ai_breachers = get_ai_group_ai("garage_breachers");

    if(a_ai_breachers.size < 1) {
      break;
    }

    wait 0.1;
  }
}

#using_animtree("player");

claw_cleanup() {
  setsaveddvar("player_waterSpeedScale", 1.3);
  flag_wait("mount_soct_player_started");
  anim_length = getanimlength( % p_pakistan_6_11_mount_soct_player);
  wait(anim_length - 1);
  screen_fade_out(0.5);
  wait 0.6;
  nextmission();
}

soct_proximity_fail_think() {
  n_fail_time_start = undefined;

  while(true) {
    if(!level.player istouching(self) && !isDefined(n_fail_time_start)) {
      n_fail_time_start = gettime();
      screen_message_create(&"PAKISTAN_SHARED_SOCT_ABANDON_WARNING");
    } else if(!level.player istouching(self) && gettime() - n_fail_time_start > 3000) {
      screen_message_delete();
      mission_fail(&"PAKISTAN_SHARED_SOCT_ABANDON_FAIL");
    } else if(level.player istouching(self) && isDefined(n_fail_time_start)) {
      n_fail_time_start = undefined;
      screen_message_delete();
    }

    wait 0.05;
  }
}

claw_tutorial() {
  level endon("street_claw_dead");
  level endon("rooftop_claw_dead");

  if(level.b_flamethrower_unlocked) {
    level.harper thread queue_dialog("harp_turn_the_flamethrowe_0");
    screen_message_create(&"PAKISTAN_SHARED_CLAW_HINT_FLAMETHROWER");
    level thread screen_message_delete_timeout();
    level thread vo_claw_flamethrower_enemy();
    level waittill("next_tutorial_message");
    level notify("new_tutorial_message");
    screen_message_delete();
  }

  level.harper thread queue_dialog("harp_open_up_that_mini_gu_0");
  screen_message_create(&"PAKISTAN_SHARED_CLAW_HINT_MINIGUN");
  level thread screen_message_delete_timeout();
  level waittill("next_tutorial_message");
  level notify("new_tutorial_message");
  screen_message_delete();
  level.harper thread queue_dialog("harp_hit_em_with_some_gr_0");
  level.harper queue_dialog("harp_hit_em_with_some_gr_0", 1);
  level thread screen_message_delete_timeout();
  level waittill("next_tutorial_message");
  level notify("new_tutorial_message");
  flag_wait("trig_fallback_archway");
  level.harper thread queue_dialog("harp_keep_an_eye_on_the_v_0", 0, undefined, "drone_is_dead");
  level.harper thread queue_dialog("harp_you_may_wanna_switch_0", 1, undefined, "drone_is_dead");
  level.harper thread say_dialog("harp_take_control_of_maxi_0", 0);
  level thread spawn_rooftop_vtol();
  screen_message_create(&"PAKISTAN_SHARED_ROOFTOP_CLAW_SWITCH");
  level thread screen_message_delete_timeout();

  if(!flag("drone_is_dead"))
    level thread play_bink_on_hud("pakistan2_rooftop_claw", 0, 1);

  level thread vo_claw_rooftop_enemy();
  level waittill("next_tutorial_message");
  level notify("new_tutorial_message");
}

spawn_rooftop_vtol() {
  wait 1.5;
  vh_courtyard_heli_3 = spawn_vehicle_from_targetname_and_drive("courtyard_heli_3");
}

screen_message_delete_timeout() {
  level endon("new_tutorial_message");
  wait 4;
  screen_message_delete();
  level notify("next_tutorial_message");
}

courtyard_rain() {
  trig_player_rain_drops = getent("player_rain_drops", "targetname");

  while(true) {
    if(!level.player istouching(trig_player_rain_drops)) {
      flag_clear("pakistan_is_raining");
      level notify("_rain_thread");
      level notify("_rain_drops");
      level.player clearclientflag(8);
    } else {
      level.player setclientflag(8);
      flag_set("pakistan_is_raining");
    }

    wait 0.05;
  }
}

dev_ending() {
  iprintlnbold("Press Use to Start");

  while(true) {
    if(level.player usebuttonpressed()) {
      break;
    }

    wait 0.05;
  }

  flag_set("drone_is_dead");
  level thread ending_dialog();
  level thread friendly_convoy();
  wait 2;
  vh_claw_player_soct = getent("claw_player_soct", "targetname");
  vh_claw_player_soct waittill("reached_end_node");
  wait 4;
  run_scene("mount_soct_harper");
  level thread run_scene("mount_soct_harper_idle");
}

garage_breach_rumble() {
  wait 0.1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.07, 1, level.player.origin, 1000, level.player);
}

mount_soct_player_rumble(m_player_body) {
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.05, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.1, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_light");
  earthquake(0.1, 1, level.player.origin, 1000, level.player);
  wait 1;
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.15, 1, level.player.origin, 1000, level.player);
  wait 0.25;
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.07, 1, level.player.origin, 1000, level.player);
}

vo_no_claw_switch() {
  level endon("player_switched_to_claw");
  wait 5;
  level.harper queue_dialog("harp_fuck_man_we_re_su_0");
  wait 1;
  level.harper queue_dialog("harp_we_got_more_comin_t_0");
  wait 1;
  level.harper queue_dialog("harp_drone_s_turned_the_s_0");
  wait 1;
  level.harper queue_dialog("harp_we_ll_be_torn_to_shr_1");
}

vo_claw_enemy() {
  level endon("courtyard_event_done");
  queue_dialog_enemy("isi1_we_have_them_pinned_1", 2);
  level thread vo_claw_defend_enemy();
  flag_wait("player_switched_to_claw");
  queue_dialog_enemy("isi2_they_have_claw_units_1", 1);
}

vo_claw_grenade_enemy() {
  level endon("courtyard_event_done");
  waittill_frag_button_pressed(level.player);
  queue_dialog_enemy("isi3_get_back_it_s_firi_1", 1);
}

vo_claw_flamethrower_enemy() {
  level endon("courtyard_event_done");

  while(!level.player adsbuttonpressed())
    wait 0.1;

  queue_dialog_enemy("isi4_flamethrower_look_1", 1);
}

vo_claw_rooftop_enemy() {
  level endon("courtyard_event_done");

  while(!level.player actionslotfourbuttonpressed())
    wait 0.1;

  queue_dialog_enemy("isi1_above_us_they_have_1", 1);
}

vo_claw_defend_enemy() {
  level endon("courtyard_event_done");
  queue_dialog_enemy("isi2_we_need_more_firepow_1", randomintrange(2, 4));
  queue_dialog_enemy("isi3_get_rpg_fire_on_that_1", randomintrange(3, 5));
  queue_dialog_enemy("isi4_flank_around_1", randomintrange(2, 4));
}

close_door_to_water() {
  m_exit_door = getent("exit_door", "targetname");
  m_exit_door show();
  m_exit_door trigger_on();
  m_exit_clip = getent("door_closed_clip", "targetname");
  m_exit_clip trigger_on();
  m_clip = getent("underground_exit_door_clip", "targetname");
  m_clip delete();
  m_door = getent("underground_exit_door", "targetname");
  m_door delete();
  setsaveddvar("phys_buoyancy", 0);
}