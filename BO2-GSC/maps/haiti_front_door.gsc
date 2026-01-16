/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_front_door.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_music;
#include maps\_objectives;
#include maps\_scene;
#include maps\_vehicle;
#include maps\haiti_util;
#include maps\haiti;
#include maps\_turret;
#include maps\haiti_anim;
#include maps\_jetpack_ai;
#include maps\_fxanim;
#include maps\_anim;
#include maps\_fire_direction;
#include maps\_quadrotor;

init_flags() {
  flag_init("vtol_debris_start");
  flag_init("fxanim_catwalk_collapse_delete");
  flag_init("entrance_bigdogs_dead");
  flag_init("walkway_launchers_kick");
  flag_init("walkway_sniper_kick");
}

init_spawn_funcs() {
  add_spawn_function_group("ally_player_squad", "targetname", ::ai_player_squad_think);
  add_spawn_function_group("sco_east_walkway", "targetname", ::ai_jetpack_ally_attack_think, "walkway_launchers");
  add_spawn_function_group("sco_west_walkway", "targetname", ::ai_jetpack_ally_attack_think, "walkway_snipers");
  add_spawn_function_group("sco_main_entrance", "targetname", ::ai_jetpack_ally_attack_think, "entrance_bigdogs");
  add_spawn_function_group("sco_main_entrance_launcher", "targetname", ::ai_jetpack_ally_attack_think, "entrance_bigdogs");
}

skipto_front_door_nothing() {
  level.is_obama_supporting = 0;
  level.is_sco_supporting = 0;
  skipto_front_door();
}

skipto_front_door_obama() {
  level.is_obama_supporting = 1;
  level.is_sco_supporting = 0;
  skipto_front_door();
}

skipto_front_door_sco() {
  level.is_obama_supporting = 0;
  level.is_sco_supporting = 1;
  skipto_front_door();
}

skipto_front_door_obama_sco() {
  level.is_obama_supporting = 1;
  level.is_sco_supporting = 1;
  skipto_front_door();
}

skipto_front_door() {
  model_restore_area("convert_front_door");
  maps\haiti::fxanim_construct_front_door();
  thread start_ground_events();
  setup_harper();
  skipto_teleport("skipto_front_door");
}

skipto_ramp_top() {
  setup_harper();
  skipto_teleport("skipto_ramp_top");
  level thread model_restore_area("convert_front_door");
  level thread maps\haiti::fxanim_construct_front_door();
  level thread start_ground_events();
  level thread walkway_collapse();
  flag_set("walkway_collapse");
  exploder(222);
}

skipto_main_entrance() {
  setup_harper();
  skipto_teleport("skipto_main_entrance");
  level.is_sco_supporting = 1;
  level thread model_restore_area("convert_front_door");
  level thread maps\haiti::fxanim_construct_front_door();
  level thread start_ground_events();
  level thread walkway_collapse();
  flag_set("walkway_collapse");
  level thread model_restore_area("convert_lobby");
  exploder(222);
}

front_door_main() {
  level thread intruder_perk();
  level thread bruteforce_perk();
  level thread battle_start();
  level thread front_door_dialog();
  exploder(222);
  level thread objective_breadcrumb(level.obj_assault_builidng, "obj_ramp");
  level thread lot_right_flank();
  flag_wait("entry_ramp_start");
  simple_spawn("sp_entry_ramp", ::enemy_battle_think);
  simple_spawn("sp_entry_ramp_launchers", ::enemy_battle_think, 0, 1);

  if(level.is_sco_supporting)
    level thread sco_east_walkway_support();

  flag_wait("wall_smash");
  simple_spawn("sp_ramp_shack", ::enemy_battle_think);
  level thread cougar_wall_smash();
  level thread autosave_by_name("haiti_ramp");
  flag_wait("walkway_collapse");
  level thread walkway_collapse();
}

ramp_top_main() {
  level thread top_of_ramp_dialog();
  level thread ramp_shack_interior();
  level thread garage();
  level thread storage();
  level thread west_walkway();
  flag_wait_any("west_walkway_support_east", "west_walkway_support_northeast", "west_walkway_support_north");
  level thread autosave_by_name("haiti_west_walkway");
}

main_entrance_main() {
  flag_set("vtol_debris_start");
  simple_spawn("main_entrance_bigdogs", ::main_entrance_claw_think);
  level thread watch_entrance_bigdogs();
  flag_wait("main_entrance_start");
  level thread main_entrance_dialog();
  level thread autosave_by_name("haiti_main_entrance");
  level thread kill_and_cleanup_ents("cleanup_snipers");
  level thread kill_and_cleanup_ents("cleanup_garage");

  if(level.is_sco_supporting)
    level thread sco_main_entrance_support();

  simple_spawn("main_entrance_guys", ::enemy_battle_think);
  trigger_wait("trig_foyer_start");
  level thread kill_and_cleanup_ents("cleanup_storage");
  level thread turn_on_interior_light_fx();
  level thread front_door_cleanup();
  level thread autosave_by_name("haiti_foyer");
}

sam_cougar_think() {
  self set_turret_ignore_line_of_sight(1, 2);
  self setbrake(1);
  e_target = spawn_model("veh_t6_air_fa38_low");
  e_target.origin = self.origin + vectorscale((0, 0, 1), 1000.0) + anglestoforward(self.angles) * 50000;
  e_target hide();
  self maps\_turret::set_turret_target(e_target, (0, 0, 0), 2);

  while(isDefined(self) && self.health > 0) {
    n_yaw_delta = randomfloatrange(-45, 45);
    n_pitch_delta = randomfloatrange(-35, -20);
    v_direction = self.angles + (n_pitch_delta, n_yaw_delta, 0);
    v_origin = self.origin + anglestoforward(v_direction) * randomintrange(40000, 60000);
    e_target moveto(v_origin, 4.0);

    if(randomint(100) < 25) {
      self maps\_turret::fire_turret_for_time(2, 2);
      wait(randomfloatrange(5.0, 10.0));
    }

    wait(randomfloatrange(2.0, 4.0));
  }

  e_target delete();
}

#using_animtree("animated_props");

laser_turret_think(str_cleanup) {
  level endon("cleanup_front_door");
  self endon("death");
  self add_cleanup_ent("cleanup_front_door");
  self useanimtree(#animtree);
  self thread laser_turret_fire();
  self thread laser_turret_challenge();

  while(!(isDefined(self.captured) && self.captured)) {
    self setflaggedanimknoballrestart("idle", random(level.scr_anim["laser_turret_scan"]), % root, 1, 0.2, 0.5);
    self waittillmatch("idle", "end");
  }
}

laser_turret_fire() {
  self endon("death");

  while(true) {
    playfxontag(level._effect["laser_turret_shoot"], self, "tag_flash");
    wait(randomfloatrange(4.0, 6.0));
  }
}

laser_turret_challenge() {
  level endon("cleanup_front_door");
  self waittill("death", attacker);

  if(isDefined(attacker) && attacker == level.player)
    level notify("laser_turret_killed");
}

main_entrance_shutters() {
  a_m_outermost_doors = getentarray("sec_gate_side_01", "targetname");
  a_m_middle_doors = getentarray("sec_gate_side_02", "targetname");
  m_center_door = getent("sec_gate_mid", "targetname");

  foreach(m_door in a_m_outermost_doors)
  m_door movez(400, 0.05);

  foreach(m_door in a_m_middle_doors)
  m_door movez(400, 0.05);

  m_center_door movez(253, 0.05);
  wait 0.1;
  flag_wait("main_entrance_start");

  foreach(m_door in a_m_outermost_doors)
  m_door movez(-1 * 400, 10.0);

  wait 2.0;

  foreach(m_door in a_m_middle_doors)
  m_door movez(-1 * 400, 10.0);

  wait 2.0;
  m_center_door movez(-1 * 253, 6.5);
  wait 6.6;
  flag_wait("close_outer_doors");
  m_center_door disconnectpaths();
  m_center_door movez(-147, 3.5);
}

start_ground_events() {
  maps\haiti_anim::front_door_anims();
  run_thread_on_targetname("turbine_blades", ::spin_turbine);
  run_thread_on_noteworthy("laser_turret", ::laser_turret_think);
  a_vh_cougars = spawn_vehicles_from_targetname("cougar_sam_front_door");

  foreach(vh_cougar in a_vh_cougars) {
    vh_cougar add_cleanup_ent("cleanup_front_door");
    vh_cougar.vteam = "axis";

    if(isDefined(vh_cougar.script_string) && vh_cougar.script_string == "inert") {
      continue;
    }
    vh_cougar thread sam_cougar_think();
  }

  a_vh_tigrs = spawn_vehicles_from_targetname("gaz_tigr_front_door");

  foreach(vh_tigr in a_vh_tigrs)
  vh_tigr add_cleanup_ent("cleanup_front_door");

  level thread squad_replenish_init();
  level thread ambient_jetwing_init();
  level thread main_entrance_shutters();
}

battle_start() {
  setmusicstate("HAITI_GROUND_FIGHT_1");
  simple_spawn("sp_battle_start_allies", ::ally_battle_think);
  simple_spawn("sp_battle_start_enemies", ::enemy_battle_think);
  s_defend_spot = getstruct("s_ramp_defend", "targetname");
  a_vh_qr_allies = spawn_vehicles_from_targetname("sp_battle_start_qr_allies");
  array_thread(a_vh_qr_allies, ::defend, s_defend_spot.origin, s_defend_spot.radius);
  a_vh_qr_axis = spawn_vehicles_from_targetname("sp_battle_start_qr_axis");
  array_thread(a_vh_qr_axis, ::defend, s_defend_spot.origin, s_defend_spot.radius);
  level thread save_when_dead(a_vh_qr_axis, "fron_qrs_dead", "walkway_collapse");
  level.ai_front_claw = simple_spawn_single("sp_battle_start_claw_enemies", ::battle_think_claw);
  level thread save_when_dead(level.ai_front_claw, "fron_claw_dead", "walkway_collapse");

  if(level.is_obama_supporting) {
    a_vh_claws = simple_spawn("sp_battle_start_claw_allies", ::battle_think_claw);
    level endon("walkway_collapse");

    for(a_vh_qr_axis = remove_dead_from_array(a_vh_qr_axis); a_vh_qr_axis.size > 2; a_vh_qr_axis = remove_dead_from_array(a_vh_qr_axis))
      wait 1.0;

    a_vh_qr_axis = spawn_vehicles_from_targetname("sp_battle_start_qr_axis_support");
    array_thread(a_vh_qr_axis, ::defend, s_defend_spot.origin, s_defend_spot.radius);
  }
}

lot_right_flank() {
  level endon("entry_ramp_start");
  trigger_wait("t_lot_right_flank");
  a_ai_flankers = simple_spawn("sp_lot_right_enemies");
  trigger_wait("t_kill_right_flank");
  level thread kill_array(a_ai_flankers);
}

battle_think_claw() {
  self.deathfunction = ::bigdog_override;

  if(isDefined(self.script_friendname))
    self.name = self.script_friendname;

  if(isDefined(self.target)) {
    n_dest = getnode(self.target, "targetname");
    self.goalradius = n_dest.radius;
    self setgoalnode(n_dest);
  }
}

bigdog_override() {
  if(isDefined(self.attacker.classname) && self.attacker.classname == "script_vehicle") {
    if(issubstr(self.attacker.targetname, "intruder_quadrotors"))
      level notify("quadrotors_kill_bigdog");
  }

  return false;
}

cougar_wall_smash() {
  flag_wait("wall_smash");
  level notify("fxanim_apc_wall_divider_start");
  wait 2.0;
  m_wall = getent("fxanim_apc_wall_divider", "targetname");
  earthquake(1.0, 1.0, m_wall.origin, 512);
  playrumbleonposition("anim_heavy", m_wall.origin);
}

sco_east_walkway_support_wait() {
  level endon("start_sco_east_walkway");
  s_lookat = getstruct("launcher_lookat", "targetname");
  level.player waittill_player_looking_at(s_lookat.origin, 10, 1);
}

sco_east_walkway_support() {
  sco_east_walkway_support_wait();
  s_loc = getstruct("s_sco_east_walkway_smoke", "targetname");
  level thread play_fx("sco_smoke", s_loc.origin, s_loc.angles, 30);
  level thread sco_east_walkway_support_dialog();
  a_s_jetwings = getstructarray("s_sco_east_walkway", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_east_walkway");
    wait(randomfloatrange(0.1, 1.0));
  }

  a_s_jetwings = getstructarray("s_sco_east_walkway_drones", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_assault", 1);
    wait(randomfloatrange(0.1, 1.0));
  }
}

sco_east_walkway_support_interior() {
  a_s_jetwings = getstructarray("s_sco_east_walkway2", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_east_walkway");
    wait(randomfloatrange(0.1, 1.0));
  }
}

walkway_collapse() {
  level thread kill_and_cleanup_ents("cleanup_front_door_lot");
  level notify("fxanim_catwalk_vtol_start");
  wait 0.05;
  m_vtol = getent("fxanim_catwalk_vtol", "targetname");
  playfxontag(level._effect["crash_vtol_trail"], m_vtol, "engine_l_left_flap_anim_jnt");
  wait 3.0;
  level notify("fxanim_catwalk_collapse_start");
  m_walkway = getent("fxanim_catwalk_collapse", "targetname");
  m_walkway waittillmatch("single anim", "end");
  flag_set("fxanim_catwalk_collapse_delete");
  clientnotify("unhide_debris");
}

ramp_shack_interior() {
  trigger_wait("trig_ramp_shack_wave2");
  simple_spawn("sp_ramp_shack_wave2", ::enemy_battle_think);
}

garage() {
  level endon("west_walkway_support_east");
  flag_wait("tigr_attack_start");
  level thread tigr_attack_dialog();
  wait 0.1;
  vh_tigr = getent("vn_tigr_attack1", "target");
  vh_tigr playsound("evt_pickup_drive_in");
  flag_wait("garage_start");
  level thread kill_and_cleanup_ents("cleanup_launchers");
  level thread kill_and_cleanup_ents("cleanup_ramp_shack");
  simple_spawn("sp_garage1", ::enemy_battle_think);
  level thread autosave_by_name("haiti_garage");
  trigger_wait("trig_garage2");
  simple_spawn("sp_garage2", ::enemy_battle_think);
}

storage() {
  level endon("west_walkway_support_east");
  flag_wait("ghost_storage_start");
  level thread kill_and_cleanup_ents("cleanup_launchers");
  a_ai_camo = simple_spawn("ghost_storage", ::camo_suit_think);
  level thread autosave_by_name("haiti_storage");
  level thread supply_dialog();
  flag_wait_either("west_walkway_support_northeast", "west_walkway_support_north");

  foreach(ai_camo in a_ai_camo) {
    if(isalive(ai_camo))
      ai_camo setgoalvolumeauto(level.goalvolumes["vol_west_walkway_ground"]);
  }
}

west_walkway() {
  flag_wait("snipers_start");
  level thread model_restore_area("convert_lobby");
  a_ai_snipers = simple_spawn("west_walkway_snipers", ::enemy_battle_think);

  if(level.is_sco_supporting)
    level thread sco_west_walkway_support();

  level thread sniper_dialog();
  level thread west_walkway_support_east();
  level thread west_walkway_support_northeast();
  level thread west_walkway_support_north();
  level thread walkway_support_dialog();
  a_e_kill = getentarray("cleanup_lot_vees", "script_noteworthy");
  level thread kill_array(a_e_kill);
}

west_walkway_support_east() {
  level endon("west_walkway_support_north");
  level endon("west_walkway_support_northeast");
  flag_wait("west_walkway_support_east");
  simple_spawn("west_walkway_support_east", ::enemy_battle_think);
  simple_spawn("west_walkway_support", ::enemy_battle_think);
  level thread kill_and_cleanup_ents("cleanup_ramp");
  level thread kill_and_cleanup_ents("cleanup_ramp_shack");
  level thread kill_and_cleanup_ents("cleanup_garage");
}

west_walkway_support_northeast() {
  level endon("west_walkway_support_north");
  level endon("west_walkway_support_east");
  flag_wait("west_walkway_support_northeast");
  simple_spawn("west_walkway_support_east", ::enemy_battle_think);
  simple_spawn("west_walkway_support_north", ::enemy_battle_think);
  simple_spawn("west_walkway_support", ::enemy_battle_think);
  level thread kill_and_cleanup_ents("cleanup_ramp");
  level thread kill_and_cleanup_ents("cleanup_ramp_shack");
}

west_walkway_support_north() {
  level endon("west_walkway_support_east");
  level endon("west_walkway_support_northeast");
  flag_wait("west_walkway_support_north");
  simple_spawn("west_walkway_support_north", ::enemy_battle_think);
  simple_spawn("west_walkway_support", ::enemy_battle_think);
  level thread kill_and_cleanup_ents("cleanup_ramp");
  level thread kill_and_cleanup_ents("cleanup_ramp_shack");
}

sco_west_walkway_support_wait() {
  level endon("west_walkway_support_north");
  level endon("west_walkway_support_northeast");
  level endon("west_walkway_support_east");
  s_lookat = getstruct("sniper_lookat", "targetname");
  level.player waittill_player_looking_at(s_lookat.origin, 30, 0);
}

sco_west_walkway_support() {
  sco_west_walkway_support_wait();
  s_loc = getstruct("s_sco_west_walkway_smoke", "targetname");
  level thread play_fx("sco_smoke", s_loc.origin, s_loc.angles, 30);
  a_s_jetwings = getstructarray("s_sco_west_walkway", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_west_walkway");
    wait(randomfloatrange(0.1, 1.0));
  }

  a_s_jetwings = getstructarray("s_sco_west_walkway_drones", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_assault", 1);
    wait(randomfloatrange(0.1, 1.0));
  }
}

watch_entrance_bigdogs() {
  waittill_ai_group_cleared("entrance_bigdogs");
  flag_set("entrance_bigdogs_dead");
}

main_entrance_claw_think() {
  self endon("death");
  self setthreatbiasgroup("ally_priority");
  self.deathfunction = ::bigdog_override;

  if(isDefined(self.target)) {
    n_dest = getnode(self.target, "targetname");
    self setgoalnode(n_dest);
  }
}

sco_main_entrance_support() {
  s_loc = getstruct("s_sco_main_entrance_smoke", "targetname");
  level thread play_fx("sco_smoke", s_loc.origin, s_loc.angles, 30);
  a_s_jetwings = getstructarray("s_sco_main_entrance", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_main_entrance");
    wait(randomfloatrange(0.1, 1.0));
  }

  a_s_jetwings = getstructarray("s_sco_main_entrance_launcher", "targetname");

  foreach(s_jetwing in a_s_jetwings) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_jetwing, "sco_main_entrance_launcher");
    wait(randomfloatrange(0.1, 1.0));
  }
}

spin_turbine() {
  self endon("death");
  self add_cleanup_ent("cleanup_front_door");

  if(isDefined(self.script_float)) {
    self ignorecheapentityflag(1);
    self setscale(self.script_float);
  }

  n_period = randomfloatrange(2, 15);

  while(true) {
    self rotateroll(360, n_period);
    wait(n_period);
  }
}

falling_debris() {
  m_debris = getent(self.target, "targetname");
  m_debris hide();
  v_dest_origin = m_debris.origin;
  v_dest_angles = m_debris.angles;
  m_debris.origin = self.origin;
  m_debris.angles = (randomfloatrange(-175, 175), randomfloatrange(-175, 175), randomfloatrange(-175, 175));
  flag_wait("vtol_debris_start");
  m_debris show();
  m_debris moveto(v_dest_origin, 5, 4.5, 0);
  m_debris rotateto(v_dest_angles, 5);
}

ambient_jetwing_init() {
  level.a_str_jetwing_waves["beachhead"] = array("s_jetwing_drones_n1", "s_jetwing_drones_n2", "s_jetwing_drones_n3", "s_jetwing_drones_n4", "s_jetwing_drones_n5", "s_jetwing_drones_n6", "s_jetwing_drones_n7", "s_jetwing_drones_n8", "s_jetwing_drones_n11", "s_jetwing_drones_ne1", "s_jetwing_drones_ne2", "s_jetwing_drones_nw2");
  level.a_str_jetwing_waves["rooftops"] = array("s_jetwing_drones_e1", "s_jetwing_drones_e2", "s_jetwing_drones_e3", "s_jetwing_drones_e4", "s_jetwing_drones_ne3", "s_jetwing_drones_nw1", "s_jetwing_drones_nw4", "s_jetwing_drones_nw5", "s_jetwing_drones_w1", "s_jetwing_drones_w2", "s_jetwing_drones_s1", "s_jetwing_drones_s2", "s_jetwing_drones_s3", "s_jetwing_drones_sw1");
  level.a_jetwing_groups = [];
  a_s_jetwings = getstructarray("jetwing_landing_spot", "script_noteworthy");

  foreach(s_jetwing in a_s_jetwings) {
    if(!isDefined(level.a_jetwing_groups[s_jetwing.targetname]))
      level.a_jetwing_groups[s_jetwing.targetname] = [];

    level.a_jetwing_groups[s_jetwing.targetname][level.a_jetwing_groups[s_jetwing.targetname].size] = s_jetwing;
  }

  if(!flag("wall_smash"))
    level thread jetwing_manager("beachhead", "wall_smash");

  level thread jetwing_manager("rooftops", "close_outer_doors");
}

jetwing_manager(str_location, str_end_flag) {
  n_spawn_limit = 99;
  n_delay = 1;
  n_small_spawn_size = randomintrange(4, 6);
  n_small_spawns = randomint(n_small_spawn_size);

  while(!flag(str_end_flag)) {
    level.a_str_jetwing_waves[str_location] = array_randomize(level.a_str_jetwing_waves[str_location]);

    foreach(str_group in level.a_str_jetwing_waves[str_location]) {
      if(flag(str_end_flag)) {
        return;
      }
      if(n_small_spawns < n_small_spawn_size) {
        n_spawn_limit = randomintrange(1, 3);
        n_delay = 0;
        n_small_spawns++;
      } else {
        n_spawn_limit = 99;
        n_delay = randomfloatrange(5.0, 7.0);
        n_small_spawns = 0;
      }

      level spawn_jetwing_group(level.a_jetwing_groups[str_group], n_spawn_limit, str_end_flag);
      wait(n_delay);
    }
  }
}

spawn_jetwing_group(a_s_landing_group, n_spawn_limit, str_end_flag) {
  if(!isDefined(n_spawn_limit))
    n_spawn_limit = 99;

  level endon(str_end_flag);
  n_spawned = 0;

  foreach(s_loc in a_s_landing_group) {
    if(randomint(100) < 80) {
      if(level.is_sco_supporting && randomint(100) < 25)
        level thread maps\_jetpack_ai::create_jetpack_ai(s_loc, "sco_assault", 1, ::random_death);
      else
        level thread maps\_jetpack_ai::create_jetpack_ai(s_loc, "seal_drone", 1, ::random_death);

      wait(randomfloatrange(0.5, 1.0));
      n_spawned++;

      if(n_spawned >= n_spawn_limit)
        return;
    }
  }
}

random_death() {
  self endon("death");

  if(randomint(100) < 20) {
    wait(randomfloatrange(3.0, 6.0));
    self dodamage(1, self.origin);
  }
}

front_door_cleanup() {
  flag_wait("close_outer_doors");
  cleanup_ents("cleanup_front_door");
  maps\_fxanim::fxanim_delete("fxanim_front_door");
  wait 10;
  level thread model_delete_area("convert_front_door");
}

bruteforce_perk() {
  level endon("at_foyer_entrance");
  t_perk = getent("t_bruteforce", "targetname");
  t_perk trigger_off();
  level.player waittill_player_has_brute_force_perk();
  flag_wait("fxanim_catwalk_collapse_delete");
  s_align = getstruct("align_bruteforce", "targetname");
  m_vtol = getent("fxanim_catwalk_vtol", "targetname");
  s_align thread maps\_anim::anim_first_frame(m_vtol, "bruteforce_vtol", undefined, "fxanim_props");
  t_perk trigger_on();
  set_objective_perk(level.obj_perk_brute_force, t_perk);
  t_perk waittill("trigger");
  remove_objective_perk(level.obj_perk_brute_force);
  s_align thread maps\_anim::anim_single_aligned(m_vtol, "bruteforce_vtol", undefined, "fxanim_props");
  run_scene_and_delete("bruteforce");
  level.player maps\_fire_direction::init_fire_direction("god_rod_glove_sp");
  level thread god_rod_perk_dialog();
  level thread autosave_by_name("god_rod");
}

intruder_perk() {
  level endon("at_foyer_entrance");
  t_perk = getent("t_intruder", "targetname");
  t_perk trigger_off();
  level.player waittill_player_has_intruder_perk();
  t_perk trigger_on();
  set_objective_perk(level.obj_perk_intruder, t_perk);
  t_perk waittill("trigger");
  a_vh_qr_old = getentarray("sp_battle_start_qr_allies", "targetname");
  level thread kill_array(a_vh_qr_old);
  a_vh_qr = spawn_vehicles_from_targetname("intruder_quadrotors");
  remove_objective_perk(level.obj_perk_intruder);
  run_scene_and_delete("intruder");
  level.player maps\_fire_direction::init_fire_direction("quadrotor_glove_sp");
  level.player.n_qrotors_dead = 0;

  foreach(vh_qr in a_vh_qr) {
    vh_qr thread qrotor_fire_direction_think();
    vh_qr thread qrotors_dead_think();
  }

  level thread quadrotor_perk_dialog();
  level thread autosave_by_name("quadrotor");
}

qrotors_dead_think() {
  self waittill("death");
  level.player.n_qrotors_dead++;

  if(level.player.n_qrotors_dead == 4) {
    level.player.n_qrotors_dead = undefined;
    level.player takeweapon("quadrotor_glove_sp");
  }
}

qrotor_fire_direction_think() {
  self endon("death");
  self setvehweapon("quadrotor_turret_explosive");

  if(isDefined(self.script_delay))
    wait(self.script_delay);

  self gopath();
  self waittill("reached_end_node");
  self maps\_quadrotor::quadrotor_start_ai();
  self setvehicleavoidance(1);
  maps\_fire_direction::add_fire_direction_shooter(self, "quadrotor_glove_sp");

  while(true) {
    self maps\_vehicle::defend(level.player.origin, 400);
    wait 2.0;
  }
}

front_door_dialog() {
  level thread front_door_battle_chatter();
  dialog_start_convo();
  level.player say_dialog("sect_supporting_element_1_0");
  level.player say_dialog("se1_established_containm_0", 0.5);

  if(level.is_sco_supporting)
    level.player say_dialog("se1_chinese_special_forc_0", 0.5);

  level.player say_dialog("sect_se_2_are_you_up_0", 1.0);
  level.player say_dialog("se2_affirm_in_position_0", 0.5);
  level.player say_dialog("sect_copy_all_main_effo_0");
  dialog_end_convo();
  harper_dialog("harp_they_re_making_a_hel_0", 2);

  if(!flag("ramp_turret_start")) {
    level.player say_dialog("sect_rear_units_are_being_0", 5);
    level.player queue_dialog("sect_knock_out_the_aa_las_0", undefined, undefined, undefined, 1);
  }

  if(isalive(level.ai_front_claw))
    level.ai_front_claw waittill("death");

  level.player say_dialog("sect_se_1_and_2_are_takin_0");
  level.player say_dialog("sect_don_t_get_sidetracke_0");
}

front_door_battle_chatter() {
  str_endon = "wall_smash";
  level endon(str_endon);
  flag_wait("entry_ramp_start");
  queue_dialog_ally("usr2_enemy_claw_to_our_fr_0", 2, undefined, str_endon);

  if(level.is_obama_supporting)
    harper_dialog("harp_friendly_claws_movin_0");

  if(!flag("walkway_launchers_cleared"))
    queue_dialog_ally("usr0_more_rpgs_on_the_roo_0", 8, undefined, str_endon);

  queue_dialog_ally("usr0_take_out_the_quad_ro_0", 4, undefined, str_endon);

  if(isalive(level.ai_front_claw))
    harper_dialog("harp_kill_that_damn_claw_0", 4);

  if(!flag("walkway_launchers_cleared"))
    queue_dialog_ally("usr1_rpgs_on_the_south_ca_0", 4, undefined, str_endon);

  queue_dialog_ally("usr3_guys_in_cover_behi_0", 4, undefined, str_endon);

  if(isalive(level.ai_front_claw))
    queue_dialog_ally("usr0_take_down_that_claw_0", 4, undefined, str_endon);
}

sco_east_walkway_support_dialog() {
  level.player say_dialog("usr2_chinese_supporting_e_0", 5);
}

top_of_ramp_dialog() {
  level endon("ghost_storage_start");
  level endon("garage_start");
  harper_dialog("harp_take_out_that_gunner_0", 1);
  flag_wait("ramp_turret_start");
  level endon("ghost_storage_start");
  vh_turret = getent("ramp_turret", "targetname");

  if(isDefined(vh_turret)) {
    vh_turret turret_dialog();
    vh_turret waittill("death");
  }

  level.player say_dialog("sect_\\tpush_forward_clear_0");
}

turret_dialog() {
  self endon("death");
  squadmate_dialog("usr2_mini_gun_ground_flo_0");
  squadmate_dialog("usr2_knock_out_the_mg_0", 5);
}

ramp_shack_dialog() {
  say_dialog("usr3_moving_to_2nd_deck_0");
  say_dialog("usr0_2nd_deck_clear_0");
  say_dialog("harp_let_s_clear_em_out_0");
}

tigr_attack_dialog() {
  squadmate_dialog("usr1_take_down_those_gun_0", 2);
}

supply_dialog() {
  squadmate_dialog("usr1_pushing_through_the_0");
  squadmate_dialog("usr0_enemy_s_got_optical_0", 2);
}

sniper_dialog() {
  level endon("under_snipers");
  level endon("walkway_snipers_cleared");
  squadmate_dialog("usr1_more_incoming_on_the_0", 3);

  if(level.is_sco_supporting) {
    wait 5;
    squadmate_dialog("usr2_chinese_supporting_e_0");
    return;
  }

  wait(randomfloatrange(5, 10));
  a_str_dialog[0] = "usr2_taking_sniper_fire_f_0";
  a_str_dialog[1] = "usr3_enemy_shooters_high_0";
  a_str_dialog[2] = "usr1_snipers_top_of_the_0";
  a_str_dialog = array_randomize(a_str_dialog);

  for(n_lines_played = 0; n_lines_played < a_str_dialog.size; n_lines_played++) {
    wait(randomfloatrange(5, 10));
    str_weapon = level.player getcurrentweapon();
    squadmate_dialog(a_str_dialog[n_lines_played], 0);
  }
}

walkway_support_dialog() {
  flag_wait("under_snipers");
  level.player queue_dialog("sect_keep_moving_get_up_0");
}

main_entrance_dialog() {
  level.player queue_dialog("sect_target_building_up_a_0");

  if(level.is_sco_supporting) {
    level.player queue_dialog("sect_se_1_we_have_enemy_0");
    wait 3;
    level.player queue_dialog("se1_se_1_has_visual_st_0");
  }

  level endon("at_foyer_entrance");
  waittill_ai_group_cleared("entrance_bigdogs");

  if(level.is_sco_supporting)
    level.player queue_dialog("se1_claws_are_down_you_0");

  level.player queue_dialog("sect_everyone_on_me_pus_0");
  harper_dialog("harp_you_heard_the_man_c_0");
}

quadrotor_perk_dialog() {
  level endon("_fire_direction_kill");
  level.player say_dialog("sect_quad_support_online_0", 2);
  b_dialog_played = 0;

  while(!b_dialog_played) {
    flag_wait("fire_direction_target_confirmed");
    str_weapon = level.player getcurrentweapon();

    if(str_weapon == "quadrotor_glove_sp") {
      if(isDefined(level.player.istalking) && !level.player.istalking) {
        level.player say_dialog("sect_targeting_quad_rotor_0", 0);
        b_dialog_played = 1;
      }
    }

    wait 0.05;
  }
}

god_rod_perk_dialog() {
  level endon("_fire_direction_kill");
  level.player say_dialog("sect_kinetic_strike_weapo_0");
  a_str_dialog[0] = "sect_targeting_kinetic_st_0";
  a_str_dialog[1] = "sect_hyper_velocity_packa_0";
  a_str_dialog[2] = "sect_kinetic_strike_initi_0";
  a_str_dialog = array_randomize(a_str_dialog);
  n_lines_played = 0;

  while(true) {
    flag_wait("fire_direction_target_confirmed");
    str_weapon = level.player getcurrentweapon();

    if(str_weapon == "god_rod_glove_sp") {
      if(!(isDefined(level.player.istalking) && level.player.istalking)) {
        level.player say_dialog(a_str_dialog[n_lines_played], 0);
        n_lines_played++;

        if(n_lines_played == a_str_dialog.size)
          n_lines_played = 0;
      }
    }

    wait 0.05;
  }
}