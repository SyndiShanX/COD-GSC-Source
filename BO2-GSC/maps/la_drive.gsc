/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_drive.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_dialog;
#include maps\_turret;
#include maps\_music;
#include maps\_anim;
#include maps\_audio;
#include maps\_objectives;

skipto_drive() {
  spawn_vehicles_from_targetname("low_road_vehicles");
}

skipto_skyline() {
  s_skipto = get_struct("skipto_skyline");
  level.veh_player_cougar = get_player_cougar();
  level.veh_player_cougar.origin = s_skipto.origin;
  level.veh_player_cougar.angles = s_skipto.angles;
  flag_set("drive_under_first_overpass");
  flag_set("drive_under_big_overpass");
}

autoexec init_drive() {
  add_spawn_function_group("g20_attackers", "targetname", ::dodge_player);
  add_trigger_function("skyline_start", ::skyline_start);
  add_trigger_function("trig_collapse", ::trigger_collapse);
  add_flag_function("skyline_crash_take_control", ::skyline_crash_take_control);
  add_flag_function("skyline_crash_start", ::skyline_crash_start);
  add_trigger_function("trigger_offramp", ::offramp);
  add_trigger_function("trigger_lastturn", ::lastturn);
  add_trigger_function("hero_drone_trigger", ::delete_drive_vehicles);
  add_trigger_function("hero_drone_trigger", ::hero_drone);
  array_thread(getentarray("fail_trigger", "targetname"), ::fail_trigger);
  add_spawn_function_veh("mini_hero_drone", ::mini_hero_drone);
  add_spawn_function_veh("tanker_drone", ::tanker_drone);
  add_spawn_function_veh("cougar_crash_big_rig", ::cougar_crash_big_rig);
}

main() {
  level thread debug_vehicle_count();

  use_player_cougar();
  level thread peel_out_sound();
  level thread fail_gate_watcher();
  clientnotify("drive_time");
  level thread create_freeway_collapse();
  level thread ambient_drones();
  exploder(56);
  exploder(57);
  exploder(58);
  exploder(59);
  level thread cougar_damage_states();
  level thread push_vehicles();
  level thread collision_sounds();
  delay_thread(10, ::fail_watcher);

  if(level.skipto_point != "skyline")
    level thread drive_vo();

  flag_wait("player_driving");
  clientnotify("cougar_chatter");
  array_thread(getaiarray("axis"), ::bloody_death);
}

fail_gate_watcher() {
  flag_wait("player_in_cougar");
  flag_wait_or_timeout("player_driving", 10);

  if(!flag("player_driving"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_1", "targetname"));

  flag_wait_or_timeout("drive_under_first_overpass", 8);

  if(!flag("drive_under_first_overpass"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_2", "targetname"));

  flag_wait_or_timeout("freeway_drive_1", 8);

  if(!flag("freeway_drive_1"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_3", "targetname"));

  flag_wait_or_timeout("first_curve", 10);

  if(!flag("first_curve"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_4", "targetname"));

  flag_wait_or_timeout("freeway_collapse", 12);

  if(!flag("freeway_collapse"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_5", "targetname"));

  flag_wait_or_timeout("drive_under_big_overpass", 20);

  if(!flag("drive_under_big_overpass"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_6", "targetname"));

  flag_wait_or_timeout("f38_trigger", 12);

  if(!flag("f38_trigger"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_7", "targetname"));

  flag_wait_or_timeout("la_1_vista_swap", 24);

  if(!flag("la_1_vista_swap"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_8", "targetname"));

  flag_wait_or_timeout("skyline", 16);

  if(!flag("skyline"))
    level thread kill_player_driver();
  else
    level thread monitor_backtrack_fail(getent("backtrack_fail_9", "targetname"));
}

monitor_backtrack_fail(t_trigger) {
  t_trigger waittill("trigger");
  level thread kill_player_driver();
}

kill_player_driver() {
  wait 1;
  earthquake(0.5, 1.0, level.player.origin, 100);
  level.player playrumbleonentity("artillery_rumble");
  level.veh_player_cougar showpart("tag_windshield_d2");
  level.veh_player_cougar showpart("tag_windshield_d1");
  wait 0.5;
  mission_fail(&"SCRIPT_COMPROMISE_FAIL");
}

peel_out_sound() {
  while(true) {
    if(level.player buttonpressed("BUTTON_RTRIG")) {
      level.player playsound("veh_cougar_peel_f", "sounddone");
      level waittill("sounddone");
      return;
    } else
      wait 0.05;

    wait 0.05;
  }
}

dodge_player() {
  self endon("death");
  flag_wait("player_driving");

  while(distance2dsquared(level.player.origin, self.origin) > 9000000)
    wait 0.05;

  if(cointoss())
    self anim_generic(self, "dodge1");
  else
    self anim_generic(self, "dodge2");
}

drive_vo() {
  if(!flag("harper_dead")) {
    level.player queue_dialog("harp_punch_it_section_0");
    level.player queue_dialog("faster__ram_them_012", 3);
  } else
    wait 2;

  level.player queue_dialog("sect_they_re_trying_to_bl_0", 1.5, undefined, "first_drone_strike");
  level.player queue_dialog("sect_push_through_em_0", 0, undefined, "first_drone_strike");
  level.player queue_dialog("sect_ram_anything_in_your_0", 0, undefined, "first_drone_strike");
  level.player queue_dialog("ande_section_you_ve_got_0", 0, "drive_under_first_overpass");

  if(!flag("harper_dead")) {
    level.player priority_dialog("left_left_015", 0, "first_drone_strike", "freeway_drone_started");
    level.player queue_dialog("ande_i_have_lock_firin_0", 0, "freeway_drone_started");
  } else
    level.player queue_dialog("ande_i_have_lock_firin_0", 0, "freeway_drone_started");

  if(!flag("harper_dead")) {
    level.player queue_dialog("hard_right_hard_r_017");
    level.player queue_dialog("the_whole_freeway_005", 0);
  } else
    level.player queue_dialog("ande_right_section_the_0", 0);

  level.player queue_dialog("holy_shit_006");
}

fa38_missle_fire(veh_fa38) {
  wait 0.1;
  struct = get_struct("freeway_fa38_missile_struct");
  veh_drone = getent("hero_drone", "targetname");
  e_missile = magicbullet("fa38_missile_turret_hero", struct.origin, veh_drone.origin, veh_fa38, veh_drone);
  e_missile endon("death");
  wait 1;
  e_missile resetmissiledetonationtime(0);
}

offramp_vo() {
  setmusicstate("LA_1_HOPELESS");
  clientnotify("cougar_vol");
  level.player queue_dialog("sect_anderson_beat_how_0");
  level.player queue_dialog("ande_it_s_bad_section_0");
  level.player queue_dialog("ande_i_don_t_know_how_you_0");

  if(!flag("harper_dead"))
    level.player queue_dialog("harp_how_do_we_come_back_0");

  level.player queue_dialog("i_dont_know_yet_003");
  flag_wait("final_dialog_start");

  if(!flag("harper_dead")) {
    level.player queue_dialog("menendez_knew_exac_003");
    flag_wait("skyline_crash_take_control");
  } else
    level.player queue_dialog("ande_section_i_m_seeing_0");
}

hide_freeway_collapse() {
  a_fxanim_ents = getentarray("fxanim", "script_noteworthy");

  foreach(ent in a_fxanim_ents) {
    if(!isDefined(ent.model) && !isDefined("fxanim_la_freeway_cars_01_mod") || isDefined(ent.model) && isDefined("fxanim_la_freeway_cars_01_mod") && ent.model == "fxanim_la_freeway_cars_01_mod") {
      m_freeway1 = ent;
      continue;
    }

    if(!isDefined(ent.model) && !isDefined("fxanim_la_freeway_cars_02_mod") || isDefined(ent.model) && isDefined("fxanim_la_freeway_cars_02_mod") && ent.model == "fxanim_la_freeway_cars_02_mod") {
      m_freeway2 = ent;
      continue;
    }
  }

  level.a_freeway_collapse = [];
  create_freeway_collapse_struct(m_freeway1, "car_01", "car_01_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_02", "car_02_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_03", "car_03_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_04", "car_04_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_05", "car_05_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_06", "car_06_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_07", "car_07_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_08", "car_08_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_09", "car_09_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_10", "car_10_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_11", "car_11_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_12", "car_12_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_13", "car_13_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_14", "car_14_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_15", "car_15_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_16", "car_16_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_17", "car_17_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_18", "car_18_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_19", "car_19_jnt");
  create_freeway_collapse_struct(m_freeway1, "car_20", "car_20_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_21", "car_01_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_22", "car_02_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_23", "car_03_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_24", "car_04_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_25", "car_05_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_26", "car_06_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_27", "car_07_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_28", "car_08_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_29", "car_09_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_30", "car_10_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_31", "car_11_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_32", "car_12_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_33", "car_13_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_34", "car_14_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_35", "car_15_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_36", "car_16_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_37", "car_17_jnt");
  create_freeway_collapse_struct(m_freeway2, "car_38", "car_18_jnt");
  create_freeway_collapse_struct(m_freeway2, "light_pole_01", "light_pole_01_jnt");
  create_freeway_collapse_struct(m_freeway2, "light_pole_02", "light_pole_02_jnt");
  create_freeway_collapse_struct(m_freeway2, "light_pole_03", "light_pole_03_jnt");
  create_freeway_collapse_struct(m_freeway2, "light_pole_04", "light_pole_04_jnt");
  create_freeway_collapse_struct(m_freeway2, "light_pole_05", "light_pole_05_jnt");
}

create_freeway_collapse_struct(m_parent, str_child, str_tag) {
  m_child = getent(str_child, "targetname");
  s_freeway = spawnstruct();
  s_freeway.m_parent = m_parent;
  s_freeway.str_model = m_child.model;
  s_freeway.str_tag = str_tag;
  m_child delete();
  level.a_freeway_collapse[level.a_freeway_collapse.size] = s_freeway;
}

create_freeway_collapse() {
  flag_wait("la_1_gump_1d");

  foreach(struct in level.a_freeway_collapse) {
    model = spawn_model(struct.str_model, struct.m_parent gettagorigin(struct.str_tag), struct.m_parent gettagangles(struct.str_tag));
    model linkto(struct.m_parent, struct.str_tag);
  }

  level.a_freeway_collapse = undefined;
}

collision_fail() {
  level endon("end_drive");

  while(true)
    level.veh_player_cougar waittill("veh_collision", v_hit_loc, v_normal, n_intensity, str_type, e_hit_ent);
}

push_vehicles() {
  level endon("end_drive");

  while(true) {
    level.veh_player_cougar waittill("veh_collision", v_hit_loc, v_normal, n_intensity, str_type, e_hit_ent);

    if(isDefined(e_hit_ent) && level.veh_player_cougar getspeedmph() > 20) {
      e_hit_ent play_fx("vehicle_launch_trail", e_hit_ent.origin, e_hit_ent.angles, 4, 1);
      v_world_force = vectorscale((0, 0, 1), 20.0);

      if(e_hit_ent.classname == "script_vehicle") {
        e_hit_ent setbrake(1);
        e_hit_ent launchvehicle(v_world_force, v_hit_loc, 0, 1);
      } else if(e_hit_ent.classname == "script_model" || isai(e_hit_ent))
        e_hit_ent physicslaunch(e_hit_ent.origin, v_world_force);

      e_hit_ent dodamage(10, e_hit_ent.origin);

      if(n_intensity > 30) {
        play_fx("vehicle_impact_lg", v_hit_loc, vectortoangles(v_normal), 2);
        e_hit_ent delay_thread(2, ::push_vehicles_damage);

        if(isDefined(e_hit_ent.classname) && e_hit_ent.classname == "script_vehicle") {
          e_hit_ent play_fx("vehicle_impact_front", e_hit_ent.origin, e_hit_ent.angles, -1, 1, "body_animate_jnt");
          e_hit_ent play_fx("vehicle_impact_rear", e_hit_ent.origin, e_hit_ent.angles, -1, 1, "body_animate_jnt");
        }
      } else
        play_fx("vehicle_impact_sm", v_hit_loc, vectortoangles(v_normal), 2);
    }
  }
}

collision_sounds() {
  level endon("end_drive");
  level.disablegenericdialog = 1;

  while(true) {
    level.veh_player_cougar waittill("veh_collision", v_hit_loc, v_normal, n_intensity, str_type, e_hit_ent);

    if(isDefined(e_hit_ent)) {
      if(n_intensity > 20)
        level.veh_player_cougar playsound("evt_auto_impact_heavy");
      else
        level.veh_player_cougar playsound("evt_auto_impact_light");
    } else
      level.veh_player_cougar playsound("evt_auto_impact_heavy");
  }
}

push_vehicles_damage() {
  self dodamage(randomintrange(20, 200), self.origin);
}

cougar_damage_states() {
  flag_wait("drive_under_first_overpass");
  level.veh_player_cougar showpart("tag_windshield_d1");
  level.veh_player_cougar hidepart("tag_windshield");
  flag_wait("drive_under_big_overpass");
  level.veh_player_cougar showpart("tag_windshield_d2");
  level.veh_player_cougar hidepart("tag_windshield_d1");
}

mini_hero_drone() {
  self endon("death");
  e_target = getent("first_overpass_target", "targetname");
  self thread maps\_turret::shoot_turret_at_target_once(e_target, undefined, 1);
  clientnotify("fssn1");
  level.player playsound("evt_flyby1_flyby_front");
  wait 0.3;
  self thread maps\_turret::shoot_turret_at_target_once(e_target, undefined, 2);
  flag_set("first_drone_strike");
  level.player playsound("evt_billboard_flyby_fnt");
}

tanker_drone() {
  self thread maps\_turret::fire_turret_for_time(-1, 0);
  level.player playsound("evt_flyby2_flyby_front");
  e_target = getent("tanker_drone_target", "targetname");

  if(isDefined(e_target))
    self maps\_turret::shoot_turret_at_target_once(e_target, vectorscale((-1, 0, 0), 100.0), 1);

  e_target playsound("evt_tanker_flyby_explosion");
}

fail_trigger() {
  self endon("death");

  while(true) {
    self waittill("trigger", e_who);

    if(isplayer(e_who)) {
      level.veh_player_cougar showpart("tag_windshield_d2");
      level.veh_player_cougar showpart("tag_windshield_d1");
      e_who suicide();
    }
  }
}

hero_drone() {
  level thread freeway_set_turret_targets();
  delay_thread(3, ::run_scene_and_delete, "freeway_f35");
  run_scene_and_delete("freeway_drone");
  level trigger_wait("f38_goto_trigger");
  veh_f38 = getent("f35_vtol", "targetname");

  for(i = 1; i < 3; i++) {
    f38_goto_struct = get_struct("f38_drive_" + i + "_goto", "targetname");
    veh_f38 setvehgoalpos(f38_goto_struct.origin, 0);
    veh_f38 waittill("goal");
  }
}

freeway_set_turret_targets() {
  e_target1 = getent("overpass_target_1", "targetname");
  e_target2 = getent("overpass_target_2", "targetname");
  flag_wait("freeway_drone_started");
  veh_drone = getent("hero_drone", "targetname");
  veh_drone set_turret_target(e_target1, (0, 0, 0), 1);
  veh_drone set_turret_target(e_target2, (0, 0, 0), 2);
  flag_wait("freeway_f35_started");
  veh_f35 = getent("f35_vtol", "targetname");
  veh_f35 notsolid();
  veh_f35 set_turret_target(veh_drone, (0, 0, 0), 0);
}

trigger_collapse() {
  wait 1.0;
  clientnotify("fssn2");
  level notify("fxanim_freeway_collapse_start");
}

offramp() {
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast");
  clientnotify("bbvi0");
  flag_set("la_1_sky_transition");
  level thread lerp_cougar_speed(65, 40, 5, 1);
  level thread offramp_vo();
  level thread offramp_lapd();
}

offramp_lapd() {
  wait 1;
  a_veh_lapd_offramp = getentarray("lapd_offramp_veh", "targetname");

  for(i = 0; i < a_veh_lapd_offramp.size; i++) {
    sound_ent[i] = spawn("script_origin", a_veh_lapd_offramp[i].origin);
    sound_ent[i] linkto(a_veh_lapd_offramp[i], "tag_origin");
    sound_ent[i] thread differing_starts();
  }

  trigger_wait("trigger_lastturn");
  wait 1;
  trigger_use("trigger_lapd_bikes");
}

differing_starts() {
  wait(randomfloatrange(0.1, 2));
  self playloopsound("amb_drive_final_siren", 1);
}

lerp_cougar_speed(n_current_speed, n_goal_speed, n_time, b_set_max_speed) {
  level.veh_player_cougar endon("death");
  s_timer = new_timer();
  n_speed = n_current_speed;

  do {
    wait 0.05;
    n_current_time = s_timer get_time_in_seconds();
    n_speed = lerpfloat(n_current_speed, n_goal_speed, n_current_time / n_time);

    if(isDefined(b_set_max_speed) && b_set_max_speed) {
      level.veh_player_cougar setvehmaxspeed(n_speed);
      continue;
    }

    level.veh_player_cougar setspeed(n_speed, 1000);
  }
  while(n_speed > n_goal_speed);
}

lastturn() {
  delete_offramp_vehicles();
  clientnotify("bbvi1");
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast");
}

delete_drive_vehicles() {
  a_vehicles = get_vehicle_array("drive_vehicles", "script_string");
  array_thread(a_vehicles, ::delete_when_not_looking_at);
}

delete_offramp_vehicles() {
  a_vehicles = get_vehicle_array("offramp_vehicles", "script_string");
  array_thread(a_vehicles, ::delete_when_not_looking_at);
}

skyline_start() {
  level thread run_scene_and_delete("skyline");
  level.player playsound("evt_dronebattle_front");
  clientnotify("bbvi2");
}

skyline_crash_take_control(ent) {
  level notify("end_drive");
  level.player freezecontrols(1);
  level thread maps\_audio::switch_music_wait("LA_1_SEMI", 1.5);
  s_goal = get_struct("cougar_crash_goal");
  level.veh_player_cougar setvehgoalpos(s_goal.origin, 0, 1);
  level thread lerp_cougar_speed(40, 40, 4, 0);
}

#using_animtree("vehicles");

skyline_crash_start(ent) {
  n_speed = level.veh_player_cougar getspeedmph();
  n_anim_delay = linear_map(n_speed, 40, 20, 0.1, 0.6);
  delay_thread(n_anim_delay + 0.8, ::spawn_vehicle_from_targetname_and_drive, "cougar_crash_big_rig");
  wait(n_anim_delay);
  clientnotify("sccs");

  if(!flag("harper_dead")) {
    level.veh_player_cougar setanim( % v_la_04_04_crash_cougar_tag_player, 1, 0, 1);
    level.player thread priority_dialog("shit_009", 1.5);
    kill_all_pending_dialog();
    run_scene_and_delete("cougar_crash");
  } else {
    level.player queue_dialog("ande_on_your_right_0");
    wait 1;
    level.veh_player_cougar setanim( % v_la_04_04_crash_cougar_tag_player, 1, 0, 1);
    level.player thread priority_dialog("shit_009", 0.5);
    kill_all_pending_dialog();
    wait 1.3;
    crash();
  }
}

crash(ent) {
  level.player playrumbleonentity("artillery_rumble");
  playfxontag(getfx("cougar_crash"), level.veh_player_cougar, "tag_origin");
  screen_fade_out(0);
  maps\_objectives::set_objective(level.obj_drive, undefined, "done");
  maps\_objectives::set_objective(level.obj_drive, undefined, "delete");
  level.crash_bigrig delete();

  if(isDefined(ent))
    ent delete();

  wait 2;
  level clientnotify("fade_out");
  wait 1;
  nextmission();
}

cougar_crash_big_rig() {
  level.crash_bigrig = self;
}

fail_watcher() {
  level endon("end_drive");

  if(isgodmode(level.player)) {
    return;
  }
  veh_player = get_player_cougar();

  while(true) {
    n_speed = veh_player getspeedmph();

    if(n_speed < 30) {
      flag_set("drive_failing");
      fail_warning();
      n_speed = veh_player getspeedmph();

      if(n_speed < 40)
        level thread missile_fail();
    } else {
      flag_clear("drive_failing");
      level.player enableinvulnerability();
      level.player enablehealthshield(1);
    }

    wait 0.05;
  }
}

missile_fail() {
  level.player disableinvulnerability();
  level.player enablehealthshield(0);
  level.player thread missile_fail_blackout();
  v_player_forward = level.player get_forward(1);
  v_spawn_org = level.player.origin + vectorscale((0, 0, 1), 2000.0) + v_player_forward * -500;
  veh_drone = spawnvehicle("veh_t6_drone_avenger", "death_drone", "drone_avenger", v_spawn_org, level.player.angles);
  veh_drone.health = 10000;
  veh_drone setvehgoalpos(v_spawn_org + v_player_forward * 100000);
  veh_drone setspeed(400, 300, 300);
  veh_drone maps\_turret::set_turret_target(level.player, undefined, 1);
  veh_drone maps\_turret::set_turret_target(level.player, undefined, 2);
  wait 2;

  if(flag("drive_failing")) {
    veh_drone thread turret_rapid_fire(1);
    veh_drone thread turret_rapid_fire(2);
  }

  veh_drone waittill("drone");
}

missile_fail_blackout() {
  self waittill("death");
  screen_fade_out(0);
}

turret_rapid_fire(n_index) {
  self endon("death");
  self endon("turret_rapid_fire_stop");
  self delay_notify("turret_rapid_fire_stop", 4);

  while(true) {
    self thread maps\_turret::fire_turret(n_index);
    wait 0.5;
  }
}

fail_warning() {
  for(i = 0; i < 100; i++) {
    v_player_forward = level.player get_forward(1);
    v_target_offset = random_vector(300);
    v_start = level.player.origin + vectorscale((0, 0, 1), 500.0);
    v_end = level.player.origin + v_player_forward + v_target_offset;
    magicbullet("avenger_side_minigun", v_start, v_end);
    wait 0.05;
  }
}

show_drive_hands(m_player_body) {
  clientnotify("enter_cougar");
}

ambient_drones() {
  level thread spawn_ambient_drones("trigger_bob", undefined, "avenger_street_flyby_1", "f38_street_flyby_1", "start_street_flyby_1", 4, 1, 3, 4, 500, 3);
  level thread spawn_ambient_drones("trigger_bob", undefined, "avenger_street_flyby_2", "f38_street_flyby_2", "start_street_flyby_2", 5, 1, 4, 5, 500, 2);
  level thread spawn_ambient_drones("trigger_bob", undefined, "avenger_street_flyby_3", "f38_street_flyby_3", "start_street_flyby_3", 5, 1, 3, 4, 500);
  level thread spawn_ambient_drones("trigger_bob", undefined, "avenger_street_flyby_4", "f38_street_flyby_4", "start_street_flyby_4", 5, 1, 4, 5, 500);
}

debug_vehicle_count() {
  hudelem = newhudelem();
  hudelem.alignx = "left";
  hudelem.aligny = "bottom";
  hudelem.horzalign = "left";
  hudelem.vertalign = "bottom";
  hudelem.x = 0;
  hudelem.y = 0;
  hudelem.fontscale = 1.0;
  hudelem.color = (0.8, 1.0, 0.8);
  hudelem.font = "objective";
  hudelem.glowcolor = (0.3, 0.6, 0.3);
  hudelem.glowalpha = 1;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;

  while(true) {
    n_count = getvehiclearray().size;
    hudelem setvalue(n_count);
    wait 0.05;
  }

}