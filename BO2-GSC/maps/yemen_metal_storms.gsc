/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_metal_storms.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\yemen_utility;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_music;
#include maps\yemen_speech;
#include maps\yemen_market;
#include maps\yemen_amb;
#include maps\_colors;
#include maps\yemen_anim;
#include maps\_metal_storm;
#include maps\_vehicle;
#include maps\_cic_turret;

init_flags() {
  flag_init("metal_storms_start");
  flag_init("metal_storms_fire_building_rocket");
  flag_init("metal_storms_entered_street");
  flag_init("player_engaged_street_terrorists");
  flag_init("player_on_street_turret");
  flag_init("street_player_off_balcony");
  flag_init("street_entrance_cleared");
  flag_init("street_bridge_cleared");
  flag_init("street_right_cleared");
  flag_init("street_back_cleared");
}

init_spawn_funcs() {
  add_spawn_function_group("terrorist", "script_noteworthy", maps\yemen_utility::terrorist_teamswitch_spawnfunc);
  add_spawn_function_group("yemeni", "script_noteworthy", maps\yemen_utility::yemeni_teamswitch_spawnfunc);
  add_spawn_function_group("street_yemeni", "script_noteworthy", maps\yemen_utility::yemeni_teamswitch_spawnfunc);
  add_spawn_function_group("street_terrorist", "script_noteworthy", ::street_terrorist_spawnfunc);
  add_spawn_function_group("courtyard_asd_target", "script_noteworthy", ::courtyard_asd_target_spawnfunc);
  add_spawn_function_veh("courtyard_right_metalstorm", ::courtyard_right_metalstorm_think);
  add_spawn_function_veh("street_metalstorm_1", ::street_metalstorm_think, 1);
  add_spawn_function_veh("street_metalstorm_2", ::street_metalstorm_think, 2);
  add_spawn_function_veh("courtyard_vtol", ::courtyard_vtol_think);
}

skipto_metal_storms() {
  level thread maps\yemen_speech::speech_clean_up();
  trigger_use("speech_clean_up");
  level thread maps\yemen_market::yemen_market_clean_up();
  level notify("flushing_yemen_gump_speech");
  skipto_teleport("skipto_metal_storms_player");
  setmusicstate("YEMEN_DOOR_OPENED");
  level.friendlyfiredisabled = 1;
  s_metal_storms_meet = getstruct("obj_metalstorm_meet_manendez", "targetname");
  set_objective(level.obj_market_meet_menendez, s_metal_storms_meet, "breadcrumb");
}

main() {
  iprintln("Metal Storms");

  flag_set("metal_storms_start");
  init_spawn_funcs();
  metal_storms_setup();
  level thread streets_set_flags_on_aigroup_clear();
  level thread maps\yemen_amb::yemen_drone_control_tones(1);
  level thread street_balcony_runners();
  level thread intruder_turret();
  level thread metal_storms_intruder();
  level thread street_safety();
  level thread street_end();
  level thread street_end_watcher();
  trigger_wait("street_end_alley");
  autosave_by_name("street_end_alley");
  trigger_wait("pre_morals");
}

metal_storms_setup() {
  sp_left_guys = getent("left_courtyard_terrorists", "targetname");
  sp_right_guys = getent("right_courtyard_terrorists", "targetname");
  sp_center_guys = getent("right_courtyard_terrorists", "targetname");
  sp_center_enemy = getent("street_entrance_guy", "targetname");
  sp_left_guys thread streets_spawn_full_count(1);
  sp_right_guys thread streets_spawn_full_count(1);
  sp_center_guys thread streets_spawn_full_count(1);
  sp_center_enemy thread streets_spawn_full_count(1);
  trigger_use("metal_storm_courtyard_color", "targetname");
  level thread run_scene_first_frame("morals_mene_door");
  level thread street_bridge_spawner_think();
}

streets_spawn_full_count(b_force) {
  n_count = self.count;

  for(i = 0; i < n_count; i++) {
    self spawn_ai(b_force);
    wait 0.1;
  }
}

metal_storms_cleanup() {
  maps\_colors::kill_color_replacements();
  spawn_manager_kill("sm_street_right", 1);
  spawn_manager_kill("sm_street_back", 1);
  spawn_manager_kill("sm_street_bridge", 1);
  spawn_manager_kill("sm_tererorist_balcony", 1);
  spawn_manager_kill("sm_terrorist_alley", 1);
  cleanup("street_terrorist", "script_noteworthy");
  cleanup("street_yemeni", "script_noteworthy");
  cleanup("street_drone", "script_noteworthy");
  cleanup("street_metalstorm", "script_noteworthy");
  a_fans = getentarray("morals_fan", "script_noteworthy");

  foreach(fan in a_fans)
  fan delete();
}

street_bridge_spawner_think() {
  spawn_manager_enable("sm_street_bridge");
  flag_wait("metal_storms_entered_street");
}

streets_set_flags_on_aigroup_clear() {
  level thread set_flag_on_group_clear("street_entrance", "street_entrance_cleared");
  level thread set_flag_on_group_clear("street_bridge", "street_bridge_cleared");
  level thread set_flag_on_group_clear("street_back", "street_back_cleared");
  level thread set_flag_on_group_clear("street_right", "street_right_cleared");
  level thread streets_advance_bridge();
  level thread streets_advance_right();
}

set_flag_on_group_clear(str_aigroup, str_flag) {
  level endon("morals_start");
  waittill_ai_group_cleared(str_aigroup);
  flag_set(str_flag);
}

streets_advance_bridge() {
  level endon("morals_start");
  flag_wait("street_bridge_cleared");
  trigger_use("street_bridge_color");
  flag_wait("street_back_cleared");
  trigger_use("street_back_color");
}

streets_advance_right() {
  level endon("morals_start");
  flag_wait("street_entrance_cleared");
  trigger_use("street_entrance_color");
  flag_wait("street_right_cleared");
  trigger_use("street_right_color");
}

courtyard_floor2_spawnfunc() {
  self endon("death");
  self thread maps\yemen_utility::terrorist_teamswitch_spawnfunc();
  wait 0.1;
  self notify("detected_farid");
  level waittill("courtyard_asd_spawned");
}

courtyard_asd_target_spawnfunc() {
  self endon("death");
  self set_pacifist(1);
}

courtyard_fire_fake_rocket() {
  level thread maps\yemen_anim::metal_storms_anims();
  v_start_point = self gettagorigin("tag_flash");
  e_target = get_ent("metalstorm_courtyard_balcony_target");
  magicbullet("usrpg_magic_bullet_sp", v_start_point, e_target.origin);
  wait 0.5;
  level thread courtyard_explosion_fx();
  playrumbleonposition("artillery_rumble", level.player.origin);
  level notify("fxanim_balcony_courtyard_start");
  playsoundatposition("fxa_balcony_courtyard", (-2544, -5521, 327));
  earthquake(0.3, 3, e_target.origin, 2000);
  level.player rumble_loop(3, 1, "crash_heli_rumble");
  level run_scene("courtyard_balcony_deaths");
  a_scene_ai = get_ais_from_scene("courtyard_balcony_deaths");
  a_balcony_ai = getentarray("courtyard_floor2_guys_ai", "targetname");
  a_scene_and_balcony_ai = arraycombine(a_scene_ai, a_balcony_ai, 1, 0);

  foreach(ai_guy in a_scene_and_balcony_ai) {
    ai_guy startragdoll();
    ai_guy dodamage(ai_guy.health + 10, (0, 0, 0));
  }

  spawn_vehicles_from_targetname("asd_courtyard_quadrotor");
  queue_dialog_ally("cd1_look_out_0");
  queue_dialog_ally("cd0_take_out_the_sentry_0");
}

courtyard_explosion_fx() {
  s_explosion_point = getstruct("courtyard_building_fx", "targetname");
  s_drama_struct = getstruct("courtyard_fx_at_player", "targetname");
  exploder(410);
  v_eye_pos = level.player geteye();
  v_player_eye = level.player getplayerangles();
  v_player_eye = vectornormalize(anglestoforward(v_player_eye));
  v_trace_to_point = v_eye_pos + v_player_eye * 256;
  a_trace = bullettrace(v_eye_pos, v_trace_to_point, 0, level.player);
  v_drama_fx = vectornormalize(a_trace["position"] - s_drama_struct.origin);
  v_drama_fx = vectortoangles(v_drama_fx);
  m_drama_spot = spawn_model("tag_origin", s_drama_struct.origin, v_drama_fx);
}

street_balcony_runners() {
  trigger_wait("street_balcony_runner_start");
  sp_runners = getent("street_balcony_runner", "targetname");
  s_run_spot = getstruct("street_balcony_runner_goal", "targetname");
  level thread street_balcony_take_position();

  for(i = 0; i < sp_runners.count; i++) {
    ai_guy = sp_runners spawn_ai(1);
    ai_guy thread street_balcony_run(s_run_spot.origin);
    wait 0.5;
  }
}

street_balcony_run(v_runto_spot) {
  level endon("balcony_runner_alerted");
  wait 0.1;
  self.goalradius = 128;
  self set_ignoreall(1);
  self setgoalpos(v_runto_spot);
  self thread street_balcony_damage_listener();
  self waittill("goal");
  wait 0.5;
  self delete();
}

street_balcony_damage_listener() {
  self waittill_any("damage", "pain", "bulletwhizby", "balcony_alert");
  level notify("balcony_runner_alerted");
}

street_balcony_take_position() {
  level waittill("balcony_runner_alerted");
  a_balcony_runners = getentarray("street_balcony_runner_ai", "targetname");
  a_balcony_nodes = array_randomize(getnodearray("street_balcony_covernode", "targetname"));

  for(i = 0; i < a_balcony_runners.size; i++) {
    a_balcony_runners[i] set_ignoreall(0);
    a_balcony_runners[i] setgoalnode(a_balcony_nodes[i]);
  }
}

street_yemeni_enter_building() {
  self endon("death");
  s_runto_spot = getstruct("street_yemeni_runto_bldg_spot", "targetname");
  wait(randomfloatrange(0.05, 2));
  self set_goalradius(256);
  self setgoalpos(s_runto_spot.origin);
  self waittill("goal");
  self delete();
}

street_safety() {
  trigger_wait("vtol_crash_foreshadow_vo");
  spawn_manager_kill("sm_street_bridge", 1);
  spawn_manager_kill("sm_street_back", 1);

  if(isDefined(level.courtyard_asd))
    level.courtyard_asd dodamage(level.courtyard_asd.health, level.courtyard_asd.origin);

  behind_guys = get_ai_group_ai("street_bridge");

  foreach(guy in behind_guys) {
    if(isDefined(guy))
      guy bloody_death();
  }

  behind_guys = get_ai_group_ai("street_entrance");

  foreach(guy in behind_guys) {
    if(isDefined(guy))
      guy bloody_death();
  }
}

street_end() {
  trigger_wait("street_end");
  level thread vo_pre_morals();
  door_l = getent("end_door_left", "targetname");
  door_r = getent("end_door_right", "targetname");
  door_l rotateyaw(-100, 0.3);
  door_r rotateyaw(100, 0.3);
  door_l connectpaths();
  door_r connectpaths();
  wait 0.2;

  for(i = 0; i < 3; i++) {
    simple_spawn("street_end_terrorist", ::street_end_guys_think);
    wait 0.2;
  }

  end_guys = get_ai_group_ai("street_end_alley");

  foreach(guy in end_guys) {
    if(isDefined(guy))
      guy.health = 10;
  }

  drones = getentarray("street_drone", "script_noteworthy");

  foreach(drone in drones) {
    if(isDefined(drone))
      drone.health = 10;
  }

  trigger_wait("morals_at_menendez");
  cleanup("end_terrorist", "script_noteworthy");
}

street_end_guys_think() {
  self.ignoreme = 1;
  self.health = 200;
  self.goalradius = 64;
  self queue_dialog("cd3_cordis_die_0");
}

street_end_watcher() {
  waittill_ai_group_cleared("street_end_alley");
  trigger_use("street_end");
}

street_terrorist_spawnfunc() {
  self endon("death");
  self thread maps\yemen_utility::terrorist_teamswitch_spawnfunc();

  while(!flag("player_engaged_street_terrorists")) {
    self waittill("damage", damage, ai_guy);

    if(ai_guy == level.player)
      flag_set("player_engaged_street_terrorists");
  }
}

courtyard_right_metalstorm_think() {
  level.courtyard_asd = self;
  level notify("courtyard_asd_spawned");
  self maps\_metal_storm::metalstorm_stop_ai();
  self.attackeraccuracy = 0;
  self.takedamage = 0;
  e_start = get_ent("courtyard_right_mb_startpoint", "targetname");
  e_end = get_ent("courtyard_right_mb_endpoint", "targetname");
  magicbullet("usrpg_magic_bullet_sp", e_start.origin, e_end.origin);
  self courtyard_metalstorm_think();
}

courtyard_metalstorm_think() {
  self waittill("reached_end_node");
  flag_wait("yemen_gump_morals");
  flag_wait_or_timeout("metal_storms_fire_building_rocket", 6);
  e_target = getent("metalstorm_courtyard_balcony_target", "targetname");
  self notify("change_state");
  self setturrettargetent(e_target);
  self waittill("turret_on_target");
  self thread courtyard_fire_fake_rocket();
  self vehclearentitytarget(e_target);
  self maps\_metal_storm::metalstorm_start_ai();
  self.takedamage = 1;
  s_courtyard_defend = getstruct("courtyard_metalstorm_defend", "targetname");
  self thread maps\_vehicle::defend(s_courtyard_defend.origin, s_courtyard_defend.radius);
}

street_metalstorm_think(id) {
  self endon("death");
  self thread maps\_metal_storm::metalstorm_weapon_think();
  self waittill("reached_end_node");
  self notify("scripted_done");
  wait 0.05;
  s_defend_area = getstruct("street_metalstorm_" + id + "_defend", "targetname");
  self thread maps\_vehicle::defend(s_defend_area.origin, s_defend_area.radius);
}

courtyard_vtol_think() {
  self endon("death");
  self setforcenocull();
  self waittill("reached_end_node");
  self delete();
}

metal_storms_intruder() {
  trigger_off("trig_intruder", "targetname");
  level.player waittill_player_has_intruder_perk();
  trigger_on("trig_intruder", "targetname");
  s_intruder_pos = getent("trig_intruder", "targetname");
  set_objective_perk(level.obj_interact, s_intruder_pos.origin);
  trigger_wait("trig_intruder");
  remove_objective_perk(level.obj_interact);
  m_clip = getent("intruder_gate_clip", "targetname");
  m_clip delete();
  run_scene("intruder");
}

intruder_turret() {
  flag_wait("yemen_gump_morals");
  e_turret = spawn_vehicle_from_targetname("intruder_turret");
  e_turret thread intruder_turret_move_qrdrones();
  trigger_wait("balcony_terrorist");
  e_turret thread maps\_cic_turret::cic_turret_on();
  e_turret makevehicleusable();
  e_turret thread intruder_turret_player_watcher();
  queue_dialog_enemy("ye2_mg_on_the_balcony_0");
  queue_dialog_enemy("ye3_target_the_balcony_0");
  flag_wait("morals_start");
  wait 0.1;
  e_turret delete();
}

intruder_turret_player_watcher() {
  level endon("morals_start");
  self.takedamage = 0;
  self waittill("enter_vehicle", player);
  self.takedamage = 1;
  player thread magic_bullet_shield();

  while(true) {
    self waittill("exit_vehicle");
    player thread stop_magic_bullet_shield();
    self waittill("enter_vehicle", player);
    player thread magic_bullet_shield();
  }
}

intruder_turret_move_qrdrones() {
  level endon("morals_start");
  flag_wait("street_player_on_balcony");
  autosave_by_name("yemen_balcony");
  queue_dialog_ally("cd3_fire_on_the_drones_0");
  a_qrs = getentarray("street_drone", "script_noteworthy");
  s_goal = getstruct("streets_qr_moveto", "targetname");
  s_goalfar = getstruct("streets_qr_moveto_far", "targetname");

  foreach(vh_qr in a_qrs) {
    vh_qr.goalpos = s_goal.origin;
    vh_qr.goalradius = 600;
  }

  extra_qrs = 0;
  s_spots = getstructarray("streets_qr_spawn_far", "targetname");

  while(extra_qrs < 8) {
    a_qrs = getentarray("street_drone", "script_noteworthy");

    if(a_qrs.size > 3)
      wait 1;
    else {
      vh_qrotor = spawn_vehicle_from_targetname("yemen_quadrotor_spawner");
      vh_qrotor.origin = s_spots[randomint(s_spots.size)].origin;
      vh_qrotor.goalpos = s_goal.origin;
      vh_qrotor.goalradius = 600;
      vh_qrotor.script_noteworthy = "street_drone";
      arrayinsert(a_qrs, vh_qrotor, a_qrs.size);
      extra_qrs++;
    }
  }
}

vo_pre_morals() {
  level.player queue_dialog("harp_farid_i_m_seeing_0");
}

vo_courtyard() {
  level.player queue_dialog("yeme_watchtower_we_are_m_0");
  level.player queue_dialog("yeme_watchtower_confirmi_0");
  level.player queue_dialog("yeme_we_are_encountering_0");
  level.player queue_dialog("yeme_taking_fire_from_the_0");
}

turretqrkills_death_listener(str_notify) {
  level endon("morals_start");

  if(!flag("morals_start")) {
    self.script_noteworthy = "street_drone";
    self waittill("death", attacker, type, weapon);

    if(attacker == level.player && weapon == "auto_gun_turret_sp_minigun")
      level.player notify(str_notify);
  }
}

watch_asd_death() {
  level endon("morals_start");
  self waittill("death", attacker);
  queue_dialog_ally("cd2_the_drone_is_down_0");

  if(attacker == level.player) {
    if(isDefined(self.emped) && self.emped == 1)
      level notify("player_killed_asd");
  }
}