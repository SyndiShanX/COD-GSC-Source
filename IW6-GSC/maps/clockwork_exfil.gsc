/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_exfil.gsc
*****************************************************/

clockwork_exfil_pre_load() {
  precacheitem("rpg_straight");
  precacheitem("xm25_fast");
  precacheitem("cz805bren+reflex_sp+silencer_sp");
  precacheitem("minigun_m1a1");
  precacheitem("minigun_m1a1_fast");
  maps\clockwork_code::ice_effects_init();
  common_scripts\utility::flag_init("player_dynamic_move_speed");
  common_scripts\utility::flag_init("player_DMS_allow_sprint");
  common_scripts\utility::flag_init("exfil_finished");
  common_scripts\utility::flag_init("chaos_finished");
  common_scripts\utility::flag_init("spawn_jeeps");
  common_scripts\utility::flag_init("elevator_open");
  common_scripts\utility::flag_init("elevator_enemies_start");
  common_scripts\utility::flag_init("ele_anim_done");
  common_scripts\utility::flag_init("start_exfil_ride");
  common_scripts\utility::flag_init("exfil_fire_fail");
  common_scripts\utility::flag_init("scientist_interview");
  common_scripts\utility::flag_init("chaos_garage_move");
  common_scripts\utility::flag_init("chaos_meetupvo_start");
  common_scripts\utility::flag_init("chaos_commandervo_done");
  common_scripts\utility::flag_init("meetup_vo_done");
  common_scripts\utility::flag_init("punchit_go");
  common_scripts\utility::flag_init("punchit_exfil_hot");
  common_scripts\utility::flag_init("chase_punch_it");
  common_scripts\utility::flag_init("punchit_car_one");
  common_scripts\utility::flag_init("punchit_car_two");
  common_scripts\utility::flag_init("gate_crash_player");
  common_scripts\utility::flag_init("exfil_blockade_ram");
  common_scripts\utility::flag_init("hand_wait");
  common_scripts\utility::flag_init("baker_in_jeep");
  common_scripts\utility::flag_init("baker_ready");
  common_scripts\utility::flag_init("exfil_player_land");
  common_scripts\utility::flag_init("kill_endingjeep");
  common_scripts\utility::flag_init("allies_finished_defend_anims");
  common_scripts\utility::flag_init("guard3_die");
  common_scripts\utility::flag_init("hesh_slide");
  common_scripts\utility::flag_init("guard_slap");
  common_scripts\utility::flag_init("cagelight");
  common_scripts\utility::flag_init("tubelight_parking");
  common_scripts\utility::flag_init("in_elevator_ally_01");
  common_scripts\utility::flag_init("in_elevator_ally_02");
  common_scripts\utility::flag_init("in_elevator_ally_03");
  common_scripts\utility::flag_init("merrick_ready_jeep");
  common_scripts\utility::flag_init("keegan_ready_jeep");
  common_scripts\utility::flag_init("hesh_ready_jeep");
  common_scripts\utility::flag_init("punchit_jeep_play_anim");
  precachemodel("viewhands_player_fed_army_arctic");
  level.player_viewhand_model = "viewhands_player_fed_army_arctic";
  level.switchactive = 1;
  level.justplayed = 0;
}

setup_chaos() {
  level.start_point = "chaos";
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreall, 1);
  common_scripts\utility::flag_set("to_cqb");
  common_scripts\utility::flag_set("defend_finished");
  common_scripts\utility::flag_set("cypher_defend_close_door");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  common_scripts\utility::flag_set("allies_finished_defend_anims");
  maps\clockwork_audio::checkpoint_chaos();
  maps\clockwork_code::hide_dufflebags();
  common_scripts\utility::exploder(5);

  if(level.woof)
    level.dog thread maps\ally_attack_dog::lock_player_control_until_flag("ele_anim_done");
}

begin_chaos() {
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");

  if(level.woof)
    thread handle_dog_chaos();

  maps\_utility::array_spawn_function_noteworthy("chaos_patrollers", ::exfil_alert_handle);
  maps\_utility::array_spawn_function_noteworthy("exfil_patrollers", ::exfil_alert_handle);
  thread maps\clockwork_interior_nvg::control_nvg_staticscreens_on();
  level.drs_ahead_test = maps\_utility_code::dynamic_run_ahead_test;
  thread fire_fail_exfil_vo();
  thread elevator_movement();
  thread security_room_transition();
  maps\clockwork_code::toggle_visibility("vault_frame_destroyed_hotmetal", 0);
  common_scripts\utility::flag_wait("chaos_finished");
}

setup_exfil() {
  level.start_point = "exfil";
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  level.exfil_checkpoint = 1;
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreall, 1);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreme, 1);
  common_scripts\utility::flag_set("defend_finished");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::vision_set_changes("clockwork_indoor_security", 0);
  maps\clockwork_code::hide_dufflebags();
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\clockwork_audio::checkpoint_exfil();

  if(level.woof) {
    var_0 = getnode("dog_exfil_jeep", "targetname");
    level.dog maps\_utility::set_goal_node(var_0);
  }
}

begin_exfil() {
  if(level.woof)
    thread handle_dog_exfil();

  level.pos_lookahead_dist = 200;
  level.dodge_distance = 50;
  maps\_vehicle_spline_zodiac::init_vehicle_splines();
  level.enemy_snowmobiles_max = 0;
  level.player.offset = 525;
  level.icehole_to_move = 0;
  level.enemy_jeep_a = [];
  level.enemy_jeep_b = [];
  level.enemy_jeep_s = [];
  level.enemy_snowmobile = [];
  level.enemy_jeep_turret = [];
  level.otherallies = [];
  level.allcrashes = [];
  common_scripts\utility::flag_set("punchit_exfil_hot");

  if(!maps\_utility::is_gen4())
    setsaveddvar("r_sunsprite_size_override", "0");

  maps\_utility::array_spawn_function_noteworthy("exfil_snowmobile", maps\clockwork_code::snowmobile_sounds);

  if(!isDefined(level.jeep))
    level.jeep = maps\_vehicle::spawn_vehicle_from_targetname("chaos_level_jeep_proxy");

  if(isDefined(level.exfil_checkpoint)) {
    maps\_utility::array_spawn_function_noteworthy("exfil_patrollers", ::exfil_alert_handle);
    common_scripts\utility::flag_set("elevator_open");
    thread fire_fail_exfil_vo();
    thread maps\clockwork_code::hold_fire_unless_ads("ally_start_path_exfil");
  }

  level.crashed_trucks = getent("crashed_trucks", "targetname");
  level.crashed_truck1 = getent("crashed_truck1", "targetname");
  level.crashed_truck2 = getent("crashed_truck2", "targetname");
  level.crashed_trucks hide();
  level.crashed_truck1 hide();
  level.crashed_truck2 hide();
  level.icehole_achievement = 0;
  thread maps\clockwork_code::vehicle_hit_drift();
  thread in_to_jeep();
  thread crash_event();
  thread headon_event();
  thread canal_event();
  thread tank_event();
  thread bridge_event();
  thread new_cliff_moment();
  thread new_nxsub_breach_moment();
  thread exfil_handle_ps4_ssao();
  common_scripts\utility::flag_wait("exfil_finished");
  maps\_utility::nextmission();
}

exfil_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  var_0 = 0;
  common_scripts\utility::flag_wait("exfil_door_close_start");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0 = 1;
    maps\_art::disable_ssao_over_time(2);
  }

  common_scripts\utility::flag_wait("ally_start_path_exfil");

  if(var_0)
    maps\_art::enable_ssao_over_time(2);
}

setup_exfil_alt() {
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_gaz_tigr_turret_physics", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics_turret", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "snow", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "ice", "fx/treadfx/tread_snow_night_clk");
  maps\_treadfx::setvehiclefx("script_vehicle_warrior_physics", "slush", "fx/treadfx/tread_snow_night_clk");
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  thread maps\_utility::vision_set_changes("clockwork_outdoor_exfill_02", 1);
  maps\clockwork_code::hide_dufflebags();

  if(!maps\_utility::is_gen4())
    setsaveddvar("r_sunsprite_size_override", "0");
}

begin_exfil_tank() {
  level endon("exfil_finished");
  thread maps\clockwork_audio::checkpoint_tank();
  level.pos_lookahead_dist = 200;
  level.dodge_distance = 50;
  maps\_vehicle_spline_zodiac::init_vehicle_splines();
  level.enemy_snowmobiles_max = 0;
  level.player.offset = 525;
  level.icehole_to_move = 0;
  level.enemy_jeep_a = [];
  level.enemy_jeep_b = [];
  level.enemy_jeep_s = [];
  level.enemy_jeep_turret = [];
  level.enemy_snowmobile = [];
  level.allcrashes = [];
  level.allyjeep = 1;
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("jeep_exfil_tank_ride_player");
  level.playerjeep = var_0[0];
  wait 0.01;
  place_allies_in_jeep();
  thread enemy_zodiacs_spawn_and_attack();
  level.player.progress = level.player.progress + 14750;
  level.crashed_trucks = getent("crashed_trucks", "targetname");
  level.crashed_truck1 = getent("crashed_truck1", "targetname");
  level.crashed_truck2 = getent("crashed_truck2", "targetname");
  level.crashed_trucks hide();
  level.crashed_truck1 hide();
  level.crashed_truck2 hide();
  thread tank_event();
  thread bridge_event();
  thread new_cliff_moment();
  thread new_nxsub_breach_moment();
  dog_in_exfil_jeep();
  common_scripts\utility::flag_wait("exfil_finished");
}

begin_exfil_bridge() {
  level endon("exfil_finished");
  thread maps\clockwork_audio::checkpoint_bridge();
  level.pos_lookahead_dist = 200;
  level.dodge_distance = 50;
  maps\_vehicle_spline_zodiac::init_vehicle_splines();
  level.enemy_snowmobiles_max = 0;
  level.player.offset = 525;
  level.icehole_to_move = 0;
  level.enemy_jeep_a = [];
  level.enemy_jeep_b = [];
  level.enemy_jeep_s = [];
  level.enemy_jeep_turret = [];
  level.enemy_snowmobile = [];
  level.allcrashes = [];
  level.allyjeep = 1;
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("jeep_exfil_bridge_ride_player");
  level.playerjeep = var_0[0];
  wait 0.01;
  place_allies_in_jeep();
  thread enemy_zodiacs_spawn_and_attack();
  level.player.progress = level.player.progress + 34000;
  level.crashed_trucks = getent("crashed_trucks", "targetname");
  level.crashed_truck1 = getent("crashed_truck1", "targetname");
  level.crashed_truck2 = getent("crashed_truck2", "targetname");
  level.crashed_trucks hide();
  level.crashed_truck1 hide();
  level.crashed_truck2 hide();
  thread tank_event();
  thread bridge_event();
  thread new_cliff_moment();
  thread new_nxsub_breach_moment();
  dog_in_exfil_jeep();
  common_scripts\utility::flag_wait("exfil_finished");
}

begin_exfil_cave() {
  level endon("exfil_finished");
  thread maps\clockwork_audio::checkpoint_cave();
  level.pos_lookahead_dist = 200;
  level.dodge_distance = 50;
  maps\_vehicle_spline_zodiac::init_vehicle_splines();
  level.enemy_snowmobiles_max = 0;
  level.player.offset = 525;
  level.icehole_to_move = 0;
  level.turret_rounds = 3;
  level.enemy_jeep_a = [];
  level.enemy_jeep_b = [];
  level.enemy_jeep_s = [];
  level.enemy_jeep_turret = [];
  level.enemy_snowmobile = [];
  level.allcrashes = [];
  level.allyjeep = 1;
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("jeep_exfil_cave_ride_player");
  level.playerjeep = var_0[0];
  wait 0.01;
  place_allies_in_jeep();
  thread enemy_zodiacs_spawn_and_attack();
  level.player.progress = level.player.progress + 61000;
  level.crashed_trucks = getent("crashed_trucks", "targetname");
  level.crashed_truck1 = getent("crashed_truck1", "targetname");
  level.crashed_truck2 = getent("crashed_truck2", "targetname");
  level.crashed_trucks hide();
  level.crashed_truck1 hide();
  level.crashed_truck2 hide();
  thread new_cliff_moment();
  thread new_nxsub_breach_moment();
  dog_in_exfil_jeep();
  common_scripts\utility::flag_wait("exfil_finished");
}

place_allies_in_jeep() {
  level.passallies[0] = level.allies[0];
  level.allies[0].script_startingposition = 1;
  level.passallies[1] = level.allies[1];
  level.allies[1].script_startingposition = 0;
  level.passplayer[0] = level.allies[2];
  level.allies[2].script_startingposition = 2;
  wait 0.01;

  foreach(var_1 in level.allies)
  level.playerjeep thread maps\_vehicle_aianim::guy_enter(var_1);

  wait 0.01;
  level.player playerlinkto(level.playerjeep, "tag_guy_turret", 0.5);
  level.player setstance("stand");
  level.allies[2] notify("newanim");
  level.allies[2].desired_anim_pose = "crouch";
  level.allies[2] allowedstances("crouch");
  level.allies[2] thread animscripts\utility::updateanimpose();
  level.allies[2] allowedstances("crouch");
  level.allies[2].baseaccuracy = 0.1;
  level.allies[2].accuracystationarymod = 0.5;
  common_scripts\utility::flag_set("start_icehole_shooting");
  level.player thread maps\clockwork_code::handle_grenade_launcher();
  level.player playerlinktodelta(level.playerjeep, "tag_guy_turret", 0.1, 360, 360, 30, 5, 1);
  level.playerjeep.mgturret[0] useby(level.player);
  level.player disableturretdismount();
  level.playerjeep thread maps\clockwork_code::fire_grenade();
  thread maps\clockwork_code::player_viewhands_minigun(level.playerjeep.mgturret[0], "viewhands_player_fed_army_arctic");
  setsaveddvar("aim_aimAssistRangeScale", "0");
  setsaveddvar("aim_autoAimRangeScale", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", "0");
  thread kill_player();
  thread maps\clockwork_code::vehicle_hit_drift();
  level.playerjeep thread player_view_clamp();
  level.icehole_achievement = 0;
}

setup_chaos_collision() {
  var_0 = getent("chaos_collision", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_collision_origin", "targetname");
  var_0 moveto(var_1.origin, 1);
  wait 2;
  var_0 disconnectpaths();
  common_scripts\utility::flag_wait("go_to_jeep");
  var_0 connectpaths();
}

handle_dead_bodies() {
  level.dead_bodies = [];
  var_0 = common_scripts\utility::getStructArray("chaos_body_a", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles;
    var_3 setModel("fed_army_corpse_a");
  }

  var_0 = common_scripts\utility::getStructArray("chaos_body_b", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles;
    var_3 setModel("fed_army_corpse_b");
  }

  var_0 = common_scripts\utility::getStructArray("chaos_body_c", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles;
    var_3 setModel("fed_army_corpse_c");
  }

  var_0 = getEntArray("chaos_decals_delete", "targetname");

  foreach(var_3 in var_0)
  var_3 delete();

  common_scripts\utility::flag_wait("spawn_more_chaos1");
  var_0 = getEntArray("chaos_decals1", "targetname");

  foreach(var_3 in var_0)
  var_3 delete();

  common_scripts\utility::flag_wait("chaos_stairstop_player");
  var_0 = getEntArray("chaos_decals2", "targetname");

  foreach(var_3 in var_0)
  var_3 delete();
}

handle_aggressive_cleanup() {
  common_scripts\utility::flag_wait("chaos_upstairs_anims");
  wait 1;

  if(common_scripts\utility::flag("exfil_fire_fail")) {
    level.aggressive_cleanup = undefined;
    return;
  }

  var_0 = cos(getdvarfloat("cg_fov"));

  while(level.aggressive_cleanup.size > 0 && !common_scripts\utility::flag("chaos_cleanup_1")) {
    level.aggressive_cleanup = common_scripts\utility::array_removeundefined(level.aggressive_cleanup);

    foreach(var_2 in level.aggressive_cleanup) {
      if(isai(var_2))
        var_3 = var_2 getEye();
      else
        var_3 = var_2 gettagorigin("tag_eye");

      if(!maps\_utility::within_fov_of_players(var_3, var_0))
        var_2 delete();
    }

    common_scripts\utility::waitframe();

    if(common_scripts\utility::flag("exfil_fire_fail")) {
      level.aggressive_cleanup = undefined;
      return;
    }
  }

  foreach(var_2 in level.aggressive_cleanup)
  var_2 delete();

  level.aggressive_cleanup = undefined;
}

#using_animtree("generic_human");

elevator_movement() {
  var_0 = getent("elevator_to_exfil", "targetname");
  var_1 = getent("start_stop_exfil_elevator_rdoor", "targetname");
  var_2 = getent("start_stop_exfil_elevator_ldoor", "targetname");
  var_3 = maps\_utility::getstruct_delete("start_stop_exfil_elevator", "targetname");
  var_4 = maps\_utility::getstruct_delete("end_stop_exfil_elevator", "targetname");
  var_5 = getent("chaos_elevator_block", "targetname");
  var_6 = getEntArray("elevator_to_exfil_models", "targetname");
  var_5 notsolid();

  if(!isDefined(level.tunnel_door)) {
    level.tunnel_door = maps\_utility::spawn_anim_model("vault_door");
    level.tunnel_door_scene = getent("lights_out_scene", "targetname");
    level.tunnel_door_scene thread maps\_anim::anim_first_frame_solo(level.tunnel_door, "tunnel_vault");
    level.tunnel_door_clip = getent("entrance_door_clip", "targetname");
    level.tunnel_door_clip linkto(level.tunnel_door);
    level.tunnel_door_clip connectpaths();
  } else {
    level.tunnel_door_scene thread maps\_anim::anim_first_frame_solo(level.tunnel_door, "tunnel_vault");
    level.tunnel_door_clip connectpaths();
  }

  var_7 = getEntArray("NVG_breakroom_door_clip", "targetname");

  foreach(var_9 in var_7)
  var_9 delete();

  var_11 = "head_elite_pmc_head_b";
  var_12 = common_scripts\utility::array_combine(getEntArray("chaos_decals", "targetname"), getEntArray("chaos_decals1", "targetname"));
  var_12 = common_scripts\utility::array_combine(var_12, getEntArray("chaos_decals2", "targetname"));

  foreach(var_14 in var_12) {
    var_14 show();

    if(isDefined(var_14.animation)) {
      var_14 attach(var_11, "", 1);
      var_14.animname = "dead";
      var_14 useanimtree(#animtree);
      var_14 thread maps\_anim::anim_loop_solo(var_14, var_14.animation);
    }
  }

  thread handle_dead_bodies();
  thread handle_aggressive_cleanup();
  thread setup_chaos_collision();
  common_scripts\utility::flag_set("lights_on");

  if(level.start_point == "chaos" || level.start_point == "defend" || level.start_point == "defend_plat" || level.start_point == "defend_blowdoors1" || level.start_point == "defend_blowdoors2" || level.start_point == "defend_fire_blocker" || level.start_point == "interior_cqb" || level.start_point == "interior_combat") {
    maps\clockwork_interior::setup_vault_door();
    maps\clockwork_interior::open_vault(1);
  }

  foreach(var_17 in var_6)
  var_17 linkto(var_0);

  var_0 moveto(var_3.origin, 0.01);
  var_19 = var_1.origin - (54, 0, 0);
  var_1 moveto(var_19, 2, 0.25, 0.25);
  var_20 = var_2.origin + (54, 0, 0);
  var_2 moveto(var_20, 2, 0.25, 0.25);
  var_1 connectpaths();
  var_2 connectpaths();
  thread elevator_vo();
  common_scripts\utility::flag_wait("chaos_moving_to_elevator");
  common_scripts\utility::flag_wait("cypher_defend_close_door");
  level.player disableoffhandweapons();
  thread baker_enter(var_3);
  thread keegan_enter(var_3);
  thread cypher_enter(var_3);
  common_scripts\utility::flag_wait_all("in_elevator_ally_01", "in_elevator_ally_02", "in_elevator_ally_03");
  common_scripts\utility::flag_wait("inpos_player_elevator");
  var_21 = getent("inpos_player_elevator", "targetname");

  while(!level.player istouching(var_21) || anyone_touching_blocker(var_5))
    wait 0.05;

  var_5 solid();
  var_5 linkto(var_0);
  var_1 notsolid();
  var_2 notsolid();
  level.player allowsprint(0);
  level.player allowjump(0);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_cqbwalk);
  common_scripts\utility::array_thread(level.allies, maps\_utility::cqb_walk, "off");
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::fast_walk, 0);
  wait 0.05;
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::fast_walk, 1);
  wait 0.05;
  var_22 = getaiarray("axis");

  foreach(var_24 in var_22)
  var_24 delete();

  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_arrivals);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_exits);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreall, 1);
  common_scripts\utility::array_thread(level.allies, maps\_utility::set_ignoreme, 1);

  foreach(var_27 in level.allies)
  var_27.alertlevel = "noncombat";

  wait 0.05;
  thread elevator_anims(var_3, var_4);
  setsaveddvar("aim_aimAssistRangeScale", "0");
  setsaveddvar("aim_autoAimRangeScale", "0");
  common_scripts\utility::flag_wait("door_close");
  thread maps\clockwork_audio::elevator_door_close();
  var_19 = var_1.origin + (54, 0, 0);
  var_1 moveto(var_19, 2, 0.25, 0.25);
  var_20 = var_2.origin - (54, 0, 0);
  var_2 moveto(var_20, 2, 0.25, 0.25);
  var_1 connectpaths();
  var_2 connectpaths();
  wait 2;
  var_29[0] = level.allies[0];
  var_29[1] = level.allies[1];
  var_29[2] = level.allies[2];
  common_scripts\utility::array_call(var_29, ::linkto, var_0);
  var_1 linkto(var_0);
  var_2 linkto(var_0);
  var_0 moveto(var_4.origin, 11, 1, 1);
  thread maps\clockwork_audio::elevator();
  maps\clockwork_code::screenshakefade(0.05, 0.5);

  foreach(var_27 in level.allies)
  var_27.alertlevel = "noncombat";

  common_scripts\utility::flag_wait("elevator_enemies_start");
  maps\_utility::autosave_by_name("holdfire");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("start_chaos");
  thread maps\clockwork_code::hold_fire_unless_ads("ally_start_path_exfil");
  wait 1;
  var_1 unlink(var_0);
  var_2 unlink(var_0);
  common_scripts\utility::flag_wait("door_open");
  maps\clockwork_code::screenshakefade(0.1, 0.5);
  thread maps\clockwork_audio::elevator_door_open();
  var_19 = var_1.origin - (54, 0, 0);
  var_1 moveto(var_19, 2, 0.25, 0.25);
  var_20 = var_2.origin + (54, 0, 0);
  var_2 moveto(var_20, 2, 0.25, 0.25);
  var_1 connectpaths();
  var_2 connectpaths();
  common_scripts\utility::array_call(var_29, ::unlink, var_0);
  level.player enableweapons();
  common_scripts\utility::flag_set("elevator_open");
  thread chaos_kill_player();
  wait 0.5;
  thread handle_first_doorway_allies();
  thread handle_second_doorway_allies();
  thread handle_stairs("chaos_stairs_1");
  thread handle_stairs("chaos_stairs_2");
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_ai_color);
  var_32 = common_scripts\utility::getstruct("keeganpath", "targetname");
  var_33 = common_scripts\utility::getstruct("cypherpath", "targetname");
  var_34 = common_scripts\utility::getstruct("bakerpath", "targetname");
  level.allies[0].moveplaybackrate = 1.2;
  level.allies[1].moveplaybackrate = 1.2;
  level.allies[2].moveplaybackrate = 1.2;
  level.allies[0].idle_right = 1;
  level.allies[1].idle_right = 0;
  level.allies[2].idle_right = 0;
  level.allies[2] thread maps\_utility::follow_path(var_33, undefined, maps\clockwork_code::walkout_do_stop_transition_anim, maps\clockwork_code::walkout_do_start_transition_anim);
  level.allies[1] thread maps\_utility::follow_path(var_32, undefined, maps\clockwork_code::walkout_do_stop_transition_anim, maps\clockwork_code::walkout_do_start_transition_anim);
  level.allies[0] thread maps\_utility::follow_path(var_34, undefined, maps\clockwork_code::walkout_do_stop_transition_anim, maps\clockwork_code::walkout_do_start_transition_anim);
  wait 3.5;
  var_5 delete();
  common_scripts\utility::flag_wait("exfil_fire_fail");
  level.allies[2] notify("_utility::follow_path");
  level.allies[1] notify("_utility::follow_path");
  level.allies[0] notify("_utility::follow_path");
  level.allies[2] maps\_utility::clear_generic_idle_anim();
  level.allies[1] maps\_utility::clear_generic_idle_anim();
  level.allies[0] maps\_utility::clear_generic_idle_anim();
  level.allies[2] maps\_utility::enable_ai_color();
  level.allies[1] maps\_utility::enable_ai_color();
  level.allies[0] maps\_utility::enable_ai_color();
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::fast_walk, 0);
  thread maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  level.player allowsprint(1);
  level.player allowjump(1);
}

handle_first_doorway_allies() {
  common_scripts\utility::flag_wait("chaos_meetup_follow_spawn");
  common_scripts\utility::flag_wait_or_timeout("spawn_more_chaos1", 3);
  common_scripts\utility::flag_set("keegan_chaos_door_1");
  common_scripts\utility::flag_set("hesh_chaos_door_1");
}

handle_second_doorway_allies() {
  common_scripts\utility::flag_wait("chaos_upstairs_player");
  common_scripts\utility::flag_set("chaos_stairs_1_wait");
  common_scripts\utility::flag_set("chaos_stairs_1_wait_2");
}

handle_stairs(var_0) {
  level endon("exfil_fire_fail");
  level endon("go_to_jeep");
  var_1 = getent(var_0, "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(var_2.on_chaos_stairs)) {
      continue;
    }
    var_2.on_chaos_stairs = 1;
    var_2 thread ally_on_stairs(var_1);
  }
}

ally_on_stairs(var_0) {
  level endon("exfil_fire_fail");
  var_1 = self.run_overrideanim;
  maps\_utility::clear_generic_run_anim();

  while(self istouching(var_0))
    common_scripts\utility::waitframe();

  if(isDefined(var_1)) {
    self.alwaysrunforward = 1;
    maps\_utility::disable_turnanims();
    self.run_overrideanim = var_1;
    self.walk_overrideanim = self.run_overrideanim;
  }

  self.on_chaos_stairs = 0;
}

anyone_touching_blocker(var_0) {
  if(level.player istouching(var_0))
    return 1;

  foreach(var_2 in level.allies) {
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

kill_estimates_vo() {
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_merrickthedatawe");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_killestimates");
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_forcitiesallover");
}

elevator_vo() {
  common_scripts\utility::flag_wait("chaos_moving_to_elevator");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_werehearingchatteron");
  common_scripts\utility::flag_wait_all("in_elevator_ally_01", "in_elevator_ally_02", "in_elevator_ally_03");
  common_scripts\utility::flag_wait("inpos_player_elevator");
  thread maps\clockwork_audio::chaos_music();
  common_scripts\utility::flag_wait("elevator_weapons_down");
  level.player disableweapons();
  common_scripts\utility::flag_wait("elevator_limp");
  level.player thread limp();
}

baker_enter(var_0) {
  level.allies[0].animname = "generic";
  var_0 maps\_anim::anim_reach_solo(level.allies[0], "enter_ele_mer");
  var_0 maps\_anim::anim_single_solo(level.allies[0], "enter_ele_mer");
  common_scripts\utility::flag_set("in_elevator_ally_01");

  if(!common_scripts\utility::flag("start_chaos"))
    var_0 maps\_anim::anim_loop_solo(level.allies[0], "wait_ele_mer", "end_loop");
}

keegan_enter(var_0) {
  level.allies[1].animname = "generic";
  var_0 maps\_anim::anim_reach_solo(level.allies[1], "enter_ele_kee");
  var_0 maps\_anim::anim_single_solo(level.allies[1], "enter_ele_kee");
  common_scripts\utility::flag_set("in_elevator_ally_02");

  if(!common_scripts\utility::flag("start_chaos"))
    var_0 maps\_anim::anim_loop_solo(level.allies[1], "wait_ele_kee", "end_loop");
}

cypher_enter(var_0) {
  level.allies[2].animname = "generic";
  var_0 maps\_anim::anim_reach_solo(level.allies[2], "enter_ele_cyp");
  var_0 maps\_anim::anim_single_solo(level.allies[2], "enter_ele_cyp");
  common_scripts\utility::flag_set("in_elevator_ally_03");

  if(!common_scripts\utility::flag("start_chaos"))
    var_0 maps\_anim::anim_loop_solo(level.allies[2], "wait_ele_cyp", "end_loop");
}

elevator_anims(var_0, var_1) {
  var_0 notify("end_loop");
  var_0 thread maps\_anim::anim_single_solo(level.allies[0], "exit_ele_mer");
  var_0 thread maps\_anim::anim_single_solo(level.allies[1], "exit_ele_kee");
  var_0 thread maps\_anim::anim_single_solo(level.allies[2], "exit_ele_cyp");
  common_scripts\utility::flag_wait("elevator_enemies_start");
  var_2 = maps\_utility::spawn_targetname("chaos_ele_enemy1", 1);
  level.ele_enemy1 = var_2;
  var_2.animname = "generic";
  var_3 = maps\_utility::spawn_targetname("chaos_ele_enemy2", 1);
  level.ele_enemy2 = var_3;
  var_3.animname = "generic";
  var_4 = maps\_utility::spawn_targetname("chaos_ele_enemy3", 1);
  var_4.animname = "generic";
  var_5 = maps\_utility::spawn_targetname("chaos_wounded2");
  var_5.animname = "generic";
  var_5 maps\_utility::gun_remove();

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    if(isDefined(var_2) && isalive(var_2))
      var_1 thread maps\_anim::anim_single_solo(var_2, "exit_ele_g1");

    if(isDefined(var_3) && isalive(var_3))
      var_1 thread maps\_anim::anim_single_solo(var_3, "exit_ele_g2");

    if(isDefined(var_5) && isalive(var_5))
      var_1 thread maps\_anim::anim_loop_solo(var_5, "rev_ele_vic");

    if(isDefined(var_4) && isalive(var_4))
      var_1 maps\_anim::anim_single_solo(var_4, "exit_ele_g3");
  } else {
    level.allies[0] maps\_utility::anim_stopanimscripted();
    level.allies[1] maps\_utility::anim_stopanimscripted();
    level.allies[2] maps\_utility::anim_stopanimscripted();

    if(isDefined(var_2) && isalive(var_2))
      maps\clockwork_code::reassign_goal_volume(var_2, "chaos_lab_vol");

    if(isDefined(var_3) && isalive(var_3))
      maps\clockwork_code::reassign_goal_volume(var_3, "chaos_lab_vol");

    if(isDefined(var_4) && isalive(var_4))
      maps\clockwork_code::reassign_goal_volume(var_4, "chaos_vault_vol");
  }

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    if(isDefined(var_4) && isalive(var_4))
      var_1 thread maps\_anim::anim_loop_solo(var_4, "rev_ele_g3");
  } else {
    level.allies[0] maps\_utility::anim_stopanimscripted();
    level.allies[1] maps\_utility::anim_stopanimscripted();
    level.allies[2] maps\_utility::anim_stopanimscripted();

    if(isDefined(var_2) && isalive(var_2))
      maps\clockwork_code::reassign_goal_volume(var_2, "chaos_lab_vol");

    if(isDefined(var_3) && isalive(var_3))
      maps\clockwork_code::reassign_goal_volume(var_3, "chaos_lab_vol");

    if(isDefined(var_4) && isalive(var_4))
      maps\clockwork_code::reassign_goal_volume(var_4, "chaos_vault_vol");
  }

  common_scripts\utility::flag_set("ele_anim_done");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_6 = getnode("elevator_node_1", "targetname");
    var_7 = getnode("elevator_node_2", "targetname");
    var_8 = getnode("chaos_end_of_hall_node1", "targetname");

    if(isDefined(var_2) && isalive(var_2))
      var_2 setgoalnode(var_7);

    if(isDefined(var_3) && isalive(var_3))
      var_3 setgoalnode(var_6);

    if(isDefined(var_4) && isalive(var_4))
      var_4 setgoalnode(var_8);
  } else {
    level.allies[0] maps\_utility::anim_stopanimscripted();
    level.allies[1] maps\_utility::anim_stopanimscripted();
    level.allies[2] maps\_utility::anim_stopanimscripted();

    if(isDefined(var_2) && isalive(var_2))
      maps\clockwork_code::reassign_goal_volume(var_2, "chaos_lab_vol");

    if(isDefined(var_3) && isalive(var_3))
      maps\clockwork_code::reassign_goal_volume(var_3, "chaos_lab_vol");

    if(isDefined(var_4) && isalive(var_4))
      maps\clockwork_code::reassign_goal_volume(var_4, "chaos_vault_vol");
  }

  common_scripts\utility::flag_wait("spawn_more_chaos1");

  if(isDefined(var_2) && isalive(var_2))
    var_2 delete();

  if(isDefined(var_3) && isalive(var_3))
    var_3 delete();

  if(isDefined(var_4) && isalive(var_4))
    var_4 delete();

  if(isDefined(var_5) && isalive(var_5))
    var_5 delete();
}

limp() {
  var_0 = 0;
  var_1 = 0;
  level.baseangles = level.player.angles;
  level.player_speed = 80;
  level.ground_ref_ent = spawn("script_model", (0, 0, 0));
  level.player playersetgroundreferenceent(level.ground_ref_ent);
  wait 0.05;

  while(!common_scripts\utility::flag("chaos_keegan_move") && !common_scripts\utility::flag("exfil_fire_fail")) {
    var_2 = level.player getvelocity();
    var_3 = abs(var_2[0]) + abs(var_2[1]);

    if(var_3 < 10) {
      wait 0.05;
      continue;
    }

    var_4 = var_3 / level.player_speed;
    var_5 = randomfloatrange(0.5, 2);

    if(randomint(100) < 20)
      var_5 = var_5 * 3;

    var_6 = randomfloatrange(0.5, 2);
    var_7 = randomfloatrange(-2, 0);
    var_8 = (var_5, var_7, var_6);
    var_8 = vector_multiply(var_8, var_4);
    var_9 = randomfloatrange(0.25, 0.35);
    var_10 = randomfloatrange(0.55, 0.65);
    var_0++;

    if(var_4 > 1.3)
      var_0++;

    thread stumble(var_8, var_9, var_10);
    level waittill("recovered");
  }

  level.player playersetgroundreferenceent(undefined);

  if(!common_scripts\utility::flag("exfil_fire_fail"))
    thread maps\clockwork_code::blend_movespeedscale_custom(50, 1);
}

stumble(var_0, var_1, var_2, var_3) {
  level endon("stop_stumble");
  var_0 = adjust_angles_to_player(var_0);
  level.ground_ref_ent rotateto(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  level.ground_ref_ent waittill("rotatedone");
  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = adjust_angles_to_player(var_4);
  level.ground_ref_ent rotateto(var_4, var_2, 0, var_2 / 2);
  level.ground_ref_ent waittill("rotatedone");

  if(!isDefined(var_3))
    level notify("recovered");
}

adjust_angles_to_player(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(level.player.angles);
  var_4 = anglesToForward(level.player.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = vector_multiply(var_5, var_1);
  var_7 = var_7 + vector_multiply(var_6, var_2);
  return var_7 + (0, var_0[1], 0);
}

vector_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

chaos_kill_player() {
  level.player notify("warn_kill");
  level.player endon("warn_kill");
  common_scripts\utility::flag_clear("chaos_kill_player_warn");
  common_scripts\utility::flag_clear("chaos_kill_player");
  common_scripts\utility::flag_wait("chaos_kill_player_warn");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_gettojeep");
  common_scripts\utility::flag_wait("chaos_kill_player");
  common_scripts\utility::flag_set("exfil_fire_fail");
  wait 3;
  setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_FOLLOW");
  maps\_utility::missionfailedwrapper();
}

add_to_agressive_cleanup(var_0) {
  if(!isDefined(level.aggressive_cleanup))
    level.aggressive_cleanup = [];

  level.aggressive_cleanup[level.aggressive_cleanup.size] = var_0;
}

security_room_transition() {
  common_scripts\utility::flag_wait("start_chaos");
  thread walkout_vo();
  thread maps\clockwork_code::blend_movespeedscale_custom(50, 1);
  thread maps\clockwork_fx::turn_effects_on("tubelight_parking", "fx/lights/lights_flourescent");

  if(!common_scripts\utility::flag("lights_on"))
    thread maps\clockwork_interior_nvg::nvg_area_lights_on_fx();

  common_scripts\utility::exploder(300);
  thread maps\_utility::autosave_now();
  var_0 = common_scripts\utility::getstruct("chaos_computer_guys", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_computer_low_loc", "targetname");
  var_2 = common_scripts\utility::getstruct("chaos_drag_loc", "targetname");
  var_3 = common_scripts\utility::getstruct("chaos_balcony", "targetname");
  thread vaultguys();
  maps\_utility::battlechatter_off("allies");
  thread runnerguys();
  common_scripts\utility::flag_wait("elevator_open");
  thread tendwounded();
  common_scripts\utility::flag_wait("chaos_ally_run");
  thread drag_interrogate_scene();
  common_scripts\utility::flag_wait("chaos_meetup_follow_spawn");
  thread meetuptalkscene();
  common_scripts\utility::flag_wait("spawn_more_chaos1");
  thread computer_guys_runin();
  thread help_near_comps();
  thread bugfinders();
  thread cypher_helps_out();
  var_4 = maps\_utility::spawn_targetname("chaos_balcony");
  var_5 = maps\_utility::spawn_targetname("chaos_typer_lower");
  add_to_agressive_cleanup(var_5);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    thread reassign_typer(var_4, var_5);
    var_4.animname = "generic";
    var_3 thread maps\_anim::anim_loop_solo(var_4, "balcony_talk");
    var_5.animname = "generic";
    var_1 thread maps\_anim::anim_loop_solo(var_5, "typer_start");
  } else {
    if(isDefined(var_4))
      maps\clockwork_code::reassign_goal_volume(var_4, "chaos_security_vol");

    if(isDefined(var_5))
      maps\clockwork_code::reassign_goal_volume(var_5, "chaos_security_vol");
  }

  common_scripts\utility::flag_wait("chaos_upstairs_anims");
  common_scripts\utility::flag_set("scientist_interview");
  wait 0.01;
  thread carry_in();
  thread dieing_revival();
  thread commander_moment();
  thread chaos_walkers();
  thread waver_moment();
  common_scripts\utility::flag_wait("chaos_outside_glass_room");
  thread drag_metal_detector();
  thread direction_group();
  common_scripts\utility::flag_set("chaos_finished");
  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_5) || isDefined(var_5))
    var_5 delete();
}

reassign_typer(var_0, var_1) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(!common_scripts\utility::flag("spawn_jeeps")) {
    if(isDefined(var_0))
      maps\clockwork_code::reassign_goal_volume(var_0, "chaos_security_vol");

    if(isDefined(var_1))
      maps\clockwork_code::reassign_goal_volume(var_1, "chaos_security_vol");
  }
}

walkout_vo() {
  level endon("exfil_fire_fail");
  common_scripts\utility::flag_wait("elevator_open");
  common_scripts\utility::flag_wait("chaos_ally_run");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_hsh_theyvegotthedrill");
  common_scripts\utility::flag_wait("chaos_meetup_follow_spawn");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_theyrestartingtoround");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_mrk_wecanseethat");
  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_suggestyoustartmoving");
  common_scripts\utility::flag_wait("spawn_more_chaos1");

  if(isDefined(level.heyyouguy))
    level.heyyouguy thread maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_heyyouwhatyou");

  wait 2;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_weneedtosecure");
  common_scripts\utility::flag_wait("chaos_stairstop_player");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_justlostoureyes");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_kgn_theyhavetheplant");
  common_scripts\utility::flag_wait("chaos_outside_glass_room");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_mrk_pickupthepace");
  common_scripts\utility::flag_set("chaos_garage_move");
}

drag_metal_detector() {
  var_0 = common_scripts\utility::getstruct("chaos_drag_loc", "targetname");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_1 = maps\_utility::spawn_targetname("chaos_dragger");
    var_2 = maps\_utility::spawn_targetname("chaos_dragged");
    var_1.animname = "generic";
    var_2.animname = "generic";
    var_2 maps\_utility::gun_remove();
    var_0 thread maps\_anim::anim_loop_solo(var_1, "dragger_loop", "kill_me");
    var_0 thread maps\_anim::anim_loop_solo(var_2, "dragged_loop", "kill_me");
    wait 2;
    var_3 = maps\_utility::spawn_targetname("chaos_lost_hope");
    var_3.animname = "generic";
    var_3 thread maps\_anim::anim_single_solo(var_3, "lost_hope");
    wait 2;
    var_0 notify("kill_me");
    wait 0.05;
    var_0 thread maps\_anim::anim_single_solo(var_1, "dragger_sin");
    var_0 thread maps\_anim::anim_single_solo(var_2, "dragged_sin");
  }
}

losthope_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  common_scripts\utility::flag_wait("chaos_exit_vo");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_rerouted");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_howmany");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_sodark");
}

additionalexit_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  common_scripts\utility::flag_wait("chaos_exit_vo");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_gotthroughsecurity");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_intheoffice");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_seeanything");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_no");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs3_cutthepower");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs4_tookoutpower");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs3_kneweactly");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs4_timeditperfectly");
}

runnerguys() {
  var_0 = maps\_utility::spawn_targetname("chaos_pointer");
  var_1 = maps\_utility::spawn_targetname("chaos_runner");
  var_2 = maps\_utility::spawn_targetname("chaos_runner2");
  var_3 = maps\_utility::spawn_targetname("chaos_runner4");
  var_4 = maps\_utility::spawn_targetname("chaos_runner5");
  var_5 = maps\_utility::spawn_targetname("chaos_runner6");
  var_6 = getnode("send_guy_node_1", "targetname");
  var_7 = getnode("send_guy_node_2", "targetname");
  var_8 = getnode("send_guy_node_3", "targetname");
  var_9 = getnode("chaos_end_of_hall_node1", "targetname");
  var_10 = getnode("chaos_end_of_hall_node2", "targetname");
  thread reassign_runners(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0.animname = "generic";
    var_1.animname = "generic";
    var_2.animname = "generic";
    wait 0.75;
    var_0 thread maps\_anim::anim_single_solo(var_0, "pointer_start");
    wait 0.35;
    var_4 maps\_utility::set_goal_node(var_10);
    var_5 maps\_utility::set_goal_node(var_10);
    var_3 maps\_utility::set_goal_node(var_9);
    var_2 thread maps\_anim::anim_single_solo(var_2, "runner_start");
    thread runner_vo(var_0, var_1);
    wait 0.45;
    var_1 thread maps\_anim::anim_single_solo(var_1, "runner_start");
    wait 0.01;
    var_0 maps\_utility::set_goal_node(var_6);
    var_1 maps\_utility::set_goal_node(var_7);
    var_2 maps\_utility::set_goal_node(var_9);
    add_to_agressive_cleanup(var_0);
  }

  common_scripts\utility::flag_wait("spawn_more_chaos1");

  if(isalive(var_3))
    var_3 delete();

  if(isalive(var_4))
    var_4 delete();

  if(isalive(var_5))
    var_5 delete();

  if(isalive(var_2) || isDefined(var_2))
    var_2 delete();

  if(isalive(var_1))
    var_1 delete();

  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_0) || isDefined(var_0))
    var_0 delete();
}

reassign_runners(var_0, var_1, var_2, var_3, var_4, var_5) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(!common_scripts\utility::flag("spawn_more_chaos1")) {
    if(isalive(var_3))
      maps\clockwork_code::reassign_goal_volume(var_3, "chaos_lab_vol");

    if(isalive(var_4))
      maps\clockwork_code::reassign_goal_volume(var_4, "chaos_lab_vol");

    if(isalive(var_5))
      maps\clockwork_code::reassign_goal_volume(var_5, "chaos_lab_vol");
  }

  if(!common_scripts\utility::flag("spawn_jeeps")) {
    if(isalive(var_0))
      maps\clockwork_code::reassign_goal_volume(var_0, "chaos_vault_vol");

    if(isalive(var_1))
      maps\clockwork_code::reassign_goal_volume(var_1, "chaos_vault_vol");

    if(isalive(var_2))
      maps\clockwork_code::reassign_goal_volume(var_2, "chaos_vault_vol");
  }
}

runner_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  wait 2;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ruc_moretroops");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_withme");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_yessir");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_movetosectors");
}

vaultguys() {
  var_0 = common_scripts\utility::getstruct("vault_door_talk_guy", "targetname");
  var_1 = common_scripts\utility::getstruct("vault_door_idle_guy", "targetname");
  var_2 = common_scripts\utility::getstruct("vault_door_drill_guy", "targetname");
  var_3 = maps\_utility::spawn_targetname("chaos_direction_b1_vault");
  var_4 = maps\_utility::spawn_targetname("chaos_direction_b2_vault");
  var_5 = maps\_utility::spawn_targetname("chaos_direction_b3_vault");
  var_6 = maps\_utility::spawn_targetname("chaos_vault_door");
  var_7 = maps\_utility::spawn_anim_model("chaos_drill", var_6.origin);
  var_8 = maps\_utility::spawn_anim_model("chaos_drill_j", var_6.origin);
  var_7 linkto(var_8, "J_prop_1");
  var_9 = maps\_utility::spawn_anim_model("chaos_tablet", var_6.origin);
  var_10 = maps\_utility::spawn_anim_model("chaos_tablet_j", var_6.origin);
  var_9 linkto(var_10, "J_prop_1");
  thread reassign_vault_guys(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_3.animname = "generic";
    var_4.animname = "generic";
    var_5.animname = "generic";
    var_6.animname = "generic";
    var_3 maps\_utility::gun_remove();
    var_4 maps\_utility::gun_remove();
    var_5 maps\_utility::gun_remove();
    var_6 maps\_utility::gun_remove();
    thread vaultguys_vo(var_4, var_3);
    var_0 thread maps\_anim::anim_loop_solo(var_3, "direction_give");
    var_0 thread maps\_anim::anim_loop_solo(var_4, "direction_take");
    var_1 thread maps\_anim::anim_loop_solo(var_5, "direction_loop");
    var_2 thread maps\_anim::anim_loop_solo(var_6, "vault_door_loop");
    var_6 thread maps\_anim::anim_loop_solo(var_8, "drill", "stop_loop");
    var_1 thread maps\_anim::anim_loop_solo(var_10, "tablet", "stop_loop");
  }

  common_scripts\utility::flag_wait("chaos_upstairs_anims");

  if(isalive(var_3))
    var_3 delete();

  if(isalive(var_4))
    var_4 delete();

  if(isalive(var_5))
    var_5 delete();

  if(isalive(var_6))
    var_6 delete();

  if(!isDefined(level.physlaunchoccurred)) {
    level.physlaunchoccurred = 1;

    if(isDefined(var_7)) {
      var_8 stopanimscripted();
      var_7 unlink();
      common_scripts\utility::waitframe();
      var_7 physicslaunchclient(var_7.origin, (0, 0, 0));
    }

    if(isDefined(var_9)) {
      var_10 stopanimscripted();
      var_9 unlink();
      common_scripts\utility::waitframe();
      var_9 physicslaunchclient(var_9.origin, (0, 0, 0));
    }
  }
}

reassign_vault_guys(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(!common_scripts\utility::flag("chaos_upstairs_anims") && !isDefined(level.physlaunchoccurred)) {
    level.physlaunchoccurred = 1;

    if(isalive(var_0))
      var_0 kill();

    if(isalive(var_1))
      var_1 kill();

    if(isalive(var_2)) {
      var_2 maps\_utility::anim_stopanimscripted();
      var_2 maps\_utility::gun_recall();
      var_2 maps\_utility::enable_ai_color();
    }

    if(isalive(var_3)) {
      var_3 maps\_utility::anim_stopanimscripted();
      var_3 maps\_utility::gun_recall();
      var_3 maps\_utility::enable_ai_color();
    }

    if(isDefined(var_4)) {
      var_5 stopanimscripted();
      var_4 unlink();
      common_scripts\utility::waitframe();
      var_4 physicslaunchclient(var_4.origin, (0, 0, 0));
    }

    if(isDefined(var_6)) {
      var_7 stopanimscripted();
      var_6 unlink();
      common_scripts\utility::waitframe();
      var_6 physicslaunchclient(var_6.origin, (0, 0, 0));
    }
  }
}

vaultguys_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  common_scripts\utility::flag_wait("chaos_ally_run");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs3_whatdidtheyuse");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs4_thermite");
  common_scripts\utility::flag_set("chaos_meetupvo_start");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs3_c4camefrom");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs4_manufacturedlocally");
}

tendwounded() {
  var_0 = common_scripts\utility::getstruct("chaos_wounded_scene1", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_bug_find_scene", "targetname");
  var_2 = maps\_utility::spawn_targetname("chaos_extinguisher");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_2.animname = "generic";

    if(isalive(var_2)) {
      var_1 thread maps\_anim::anim_loop_solo(var_2, "extinguish");
      var_3 = maps\_utility::spawn_anim_model("chaos_ext");
      var_1 thread maps\_anim::anim_loop_solo(var_3, "ext");
    }

    common_scripts\utility::flag_wait_any("chaos_upstairs_anims", "exfil_fire_fail");
    var_0 notify("kill_wounded");

    if(isalive(var_2)) {
      var_2 stopanimscripted();
      var_2 maps\_utility::gun_recall();
    }
  } else
    maps\clockwork_code::reassign_goal_volume(var_2, "chaos_lab_vol");

  common_scripts\utility::flag_wait_any("chaos_upstairs_anims", "exfil_fire_fail");

  if(isalive(var_2)) {
    if(!common_scripts\utility::flag("chaos_upstairs_anims"))
      var_2 kill();
    else
      var_2 delete();
  }
}

meetuptalkscene() {
  var_0 = common_scripts\utility::getstruct("chaos_dont_look", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_meetup_location", "targetname");

  while(common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, cos(65)))
    common_scripts\utility::waitframe();

  var_2 = undefined;
  var_3 = maps\_utility::spawn_targetname("chaos_meetup_followed");
  var_4 = getnode("chaos_end_of_hall_node1", "targetname");
  thread reassign_meetup(var_2, var_3);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_2 = maps\_utility::spawn_targetname("chaos_meetup_follower");
    var_2.animname = "generic";
    var_3.animname = "generic";
    thread meetup_vo(var_2, var_3);
    var_1 thread maps\_anim::anim_reach_solo(var_2, "meetup_follower");
    var_1 maps\_anim::anim_reach_solo(var_3, "meetup_followed");
    var_1 thread maps\_anim::anim_single_solo(var_2, "meetup_follower");
    var_1 thread maps\_anim::anim_single_solo(var_3, "meetup_followed");
    var_2 maps\_utility::set_goal_node(var_4);
    var_3 maps\_utility::set_goal_node(var_4);
    common_scripts\utility::flag_wait("meetup_vo_done");
  }

  common_scripts\utility::flag_wait("chaos_upstairs_anims");

  if(isalive(var_2))
    var_2 delete();

  if(isalive(var_3))
    var_3 delete();
}

reassign_meetup(var_0, var_1) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isDefined(var_0))
    var_0 maps\_utility::enable_ai_color();

  if(isDefined(var_1))
    var_1 maps\_utility::enable_ai_color();
}

meetup_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  common_scripts\utility::flag_wait("chaos_meetupvo_start");
  wait 3;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_report");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_holdupinlabs");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_letshurry");
  common_scripts\utility::flag_set("meetup_vo_done");
}

drag_interrogate_scene() {
  var_0 = common_scripts\utility::getstruct("chaos_drag_scene", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_drag_talker", "targetname");
  var_2 = common_scripts\utility::getstruct("chaos_drag_talkee", "targetname");
  var_3 = maps\_utility::spawn_targetname("chaos_dragger_interrogate");
  var_4 = maps\_utility::spawn_targetname("chaos_drag_inter");
  var_5 = maps\_utility::spawn_targetname("chaos_drag_talker");
  level.heyyouguy = var_5;
  var_6 = maps\_utility::spawn_targetname("chaos_drag_talkee");
  thread reassign_interrogate(var_3, var_6, var_4, var_5);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_3.animname = "generic";
    var_4.animname = "generic";
    var_5.animname = "generic";
    var_6.animname = "generic";
    var_4 maps\_utility::gun_remove();
    thread drag_interrogate_vo(var_3, var_6);
    var_1 thread maps\_anim::anim_loop_solo(var_5, "drag_talker_loop");
    var_2 thread maps\_anim::anim_loop_solo(var_6, "drag_talkee_loop");
    var_0 thread maps\_anim::anim_single_solo(var_4, "drag_interrogate");
    var_0 maps\_anim::anim_single_solo(var_3, "dragger_interrogate");

    if(!common_scripts\utility::flag("exfil_fire_fail")) {
      var_0 thread maps\_anim::anim_loop_solo(var_4, "drag_interrogate_loop");
      var_0 thread maps\_anim::anim_loop_solo(var_3, "dragger_interrogate_loop");
    }
  }

  common_scripts\utility::flag_wait("chaos_upstairs_anims");

  if(isalive(var_3))
    var_3 delete();

  if(isalive(var_6))
    var_6 delete();

  if(isalive(var_4))
    var_4 delete();

  if(isalive(var_5))
    var_5 delete();
}

reassign_interrogate(var_0, var_1, var_2, var_3) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_0))
    var_0 maps\_utility::enable_ai_color();

  if(isalive(var_1))
    var_1 maps\_utility::enable_ai_color();

  if(isalive(var_2)) {
    var_2 maps\_utility::gun_recall();
    var_2 maps\_utility::enable_ai_color();
  }

  if(isalive(var_3))
    var_3 maps\_utility::enable_ai_color();
}

drag_interrogate_vo(var_0, var_1) {
  wait 4;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_seeattackers");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_rerouted");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_howmany");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_sodark");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_howmany");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ruc_lockitdown");
}

computer_guys_runin() {
  var_0 = common_scripts\utility::getstruct("chaos_computer_runin_loc", "targetname");
  var_1 = maps\_utility::spawn_targetname("chaos_computer_runin");
  add_to_agressive_cleanup(var_1);
  var_1 endon("death");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_1.animname = "generic";
    var_0 maps\_anim::anim_reach_solo(var_1, "computer_stander_runin");
    thread computer_guys_runin_vo(var_1);
    var_0 thread maps\_anim::anim_loop_solo(var_1, "computer_stander_runin", "computer_stop");
  } else
    maps\clockwork_code::reassign_goal_volume(var_1, "chaos_security_vol");

  common_scripts\utility::flag_wait_any("spawn_jeeps", "exfil_fire_fail");

  if(isalive(var_1)) {
    if(common_scripts\utility::flag("spawn_jeeps")) {
      var_0 notify("computer_stop");
      var_1 stopanimscripted();
      var_1 delete();
    } else
      maps\clockwork_code::reassign_goal_volume(var_1, "chaos_security_vol");
  }
}

computer_guys_runin_vo(var_0) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  wait 3;

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_shotmonitor");

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_password");

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_vodka");

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_blockingme");

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_seeanything");

  if(isalive(var_0))
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_toomuchsmoke");
}

help_near_comps() {
  var_0 = common_scripts\utility::getstruct("chaos_dont_look", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_bug_find_scene", "targetname");
  var_2 = common_scripts\utility::getstruct("chaos_help_near_comp_struct", "targetname");

  while(common_scripts\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, cos(65)))
    common_scripts\utility::waitframe();

  var_3 = maps\_utility::spawn_targetname("chaos_hurt_near_comp");
  var_4 = maps\_utility::spawn_targetname("chaos_help_near_comp");
  var_5 = maps\_utility::spawn_targetname("chaos_help_near_comp_walker");
  add_to_agressive_cleanup(var_3);
  add_to_agressive_cleanup(var_4);
  add_to_agressive_cleanup(var_5);
  thread reassign_comps(var_4, var_3, var_5);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_3.animname = "generic";
    var_4.animname = "generic";
    var_3 maps\_utility::gun_remove();
    var_2 thread maps\_anim::anim_loop_solo(var_3, "hurt_start_loop", "end_loop");
    var_2 maps\_anim::anim_reach_solo(var_4, "help_anim");

    if(!common_scripts\utility::flag("exfil_fire_fail") && isalive(var_4) && isalive(var_3)) {
      thread help_vo(var_3, var_4);
      var_2 notify("end_loop");
      var_2 thread maps\_anim::anim_single_solo(var_3, "hurt_anim");
      var_2 maps\_anim::anim_single_solo(var_4, "help_anim");
    }

    if(!common_scripts\utility::flag("exfil_fire_fail") && isalive(var_4) && isalive(var_3)) {
      var_2 thread maps\_anim::anim_loop_solo(var_3, "hurt_end_loop");
      var_2 thread maps\_anim::anim_loop_solo(var_4, "help_end_loop");
    }
  }

  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_4))
    var_4 delete();

  if(isalive(var_3))
    var_3 delete();
}

reassign_comps(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_1))
    var_1 kill();

  if(isalive(var_0))
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_security_vol");

  if(isalive(var_2))
    maps\clockwork_code::reassign_goal_volume(var_2, "chaos_security_vol");
}

help_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_help");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_intheknee");

  if(isalive(var_1))
    var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_seeattackers");

  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_sawflashes");
}

bugfinders() {
  var_0 = common_scripts\utility::getstruct("chaos_bug_find_scene", "targetname");
  var_1 = maps\_utility::spawn_targetname("chaos_bug_finder");
  var_2 = maps\_utility::spawn_targetname("chaos_bug_director");
  thread reassign_bug(var_1, var_2);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_1.animname = "generic";
    var_2.animname = "generic";
    var_3 = maps\_utility::spawn_anim_model("bug_device", var_1 gettagorigin("TAG_INHAND"), var_1 gettagangles("TAG_INHAND"));
    var_3 linkto(var_1, "TAG_INHAND");
    thread bug_finders_vo(var_1, var_2);
    var_0 thread maps\_anim::anim_single_solo(var_1, "bug_finder");
    var_0 maps\_anim::anim_single_solo(var_2, "bug_finder2");

    if(isalive(var_1))
      var_0 thread maps\_anim::anim_loop_solo(var_1, "bug_finder_loop");

    if(isalive(var_2))
      var_0 thread maps\_anim::anim_loop_solo(var_2, "bug_finder_loop2");
  }

  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_1) || isDefined(var_1))
    var_1 delete();

  if(isalive(var_2) || isDefined(var_2))
    var_2 delete();
}

reassign_bug(var_0, var_1) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_0))
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_security_vol");

  if(isalive(var_1))
    maps\clockwork_code::reassign_goal_volume(var_1, "chaos_security_vol");
}

bug_finders_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_1 endon("death");
  var_0 endon("death");
  common_scripts\utility::flag_wait("scientist_interview");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_sophisticated");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ss1_doneallthis");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru1_rerouted");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_ru2_takenapart");
}

cypher_helps_out() {
  var_0 = common_scripts\utility::getstruct("chaos_bug_find_scene", "targetname");
  var_1 = maps\_utility::spawn_targetname("chaos_cypher_helps");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_1.animname = "generic";
    var_0 thread maps\_anim::anim_loop_solo(var_1, "helpee_intro_loop", "helpee_intro_end");
    common_scripts\utility::flag_wait("hesh_bottom_stairs_1");
    thread cypher_helps_out_vo(var_1, var_0);
    var_0 maps\_anim::anim_reach_solo(level.allies[2], "helper_out");

    if(isalive(var_1)) {
      thread start_chaos_walkers();
      var_0 thread maps\_anim::anim_single_solo(var_1, "helpee_out");
      var_0 notify("helpee_intro_end");
      var_0 maps\_anim::anim_single_solo(level.allies[2], "helper_out");
    }

    var_0 notify("guy_helped");
    var_1.moveplaybackrate = 1;
    level.allies[2].moveplaybackrate = 1;

    if(isalive(var_1))
      var_0 thread maps\_anim::anim_loop_solo(var_1, "helpee_exit_loop");
  }

  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_1) || isDefined(var_1))
    var_1 delete();
}

cypher_helps_out_vo(var_0, var_1) {
  wait 2;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_imhelpinghim");
  var_1 waittill("helpee_intro_end");
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_comeherefriend");
  wait 10;
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_amedicwillbe");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf2_thankyou");
}

start_chaos_walkers() {
  wait 4;
  level notify("chaos_walkers_go");
  wait 5;
  common_scripts\utility::flag_set("chaos_stairs_1_wait");
  wait 0.5;
  common_scripts\utility::flag_set("chaos_stairs_1_wait_2");
}

chaos_walker_wait() {
  level endon("chaos_walkers_go");
  common_scripts\utility::flag_wait("chaos_upstairs_player");
}

chaos_walkers() {
  chaos_walker_wait();
  var_0 = maps\_utility::spawn_targetname("chaos_walkers_pointer");
  var_0.animname = "generic";

  if(!common_scripts\utility::flag("exfil_fire_fail"))
    var_0 thread maps\_anim::anim_single_solo(var_0, "pointer_start");

  wait 2;
  var_1 = getEntArray("chaos_walkers", "targetname");
  var_1[1] delete();
  var_2 = maps\_utility::array_spawn_targetname("chaos_walkers");
  level.walkers = common_scripts\utility::array_add(var_2, var_0);
  thread reassign_walkers(level.walkers);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    common_scripts\utility::array_thread(level.walkers, maps\clockwork_code::fast_walk, 1);
    common_scripts\utility::array_thread(level.walkers, maps\_utility::disable_arrivals);
    common_scripts\utility::array_thread(level.walkers, maps\_utility::disable_exits);
  }
}

reassign_walkers(var_0) {
  common_scripts\utility::flag_wait("exfil_fire_fail");
  maps\clockwork_code::reassign_goal_volume(level.walkers, "chaos_security_vol");
}

waver_moment() {
  var_0 = maps\_utility::spawn_targetname("chaos_lt", 1);
  var_1 = common_scripts\utility::getstruct("dog_talk_guy", "targetname");
  var_0 forceteleport(var_1.origin, var_0.angles, 1000);

  if(isDefined(var_0) && !common_scripts\utility::flag("exfil_fire_fail")) {
    var_0.animname = "generic";
    var_0 maps\_utility::gun_remove();
    var_0 thread maps\_anim::anim_loop_solo(var_0, "wave_guard");
  }

  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_0))
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_security_vol");
}

commander_moment() {
  var_0 = common_scripts\utility::getstruct("chaos_commander_and_lt", "targetname");
  var_1 = getnode("choas_walkers_goal", "targetname");
  var_2 = common_scripts\utility::getstruct("chaos_dog_scene", "targetname");
  var_3 = maps\_utility::spawn_targetname("chaos_commander");
  var_4 = maps\_utility::spawn_targetname("chaos_dog_handler", 1);
  thread reassign_commander(var_3, var_4);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_5 = maps\_utility::spawn_targetname("barkingdog", 1);

    if(isDefined(var_4) && isDefined(var_5) && !common_scripts\utility::flag("exfil_fire_fail")) {
      var_5.ignoreall = 1;
      var_5.team = "axis";
      var_4.animname = "generic";
      var_5.animname = "generic";
      var_5 thread barkingdog_handle_stealth_break(var_2);
      var_2 thread maps\_anim::anim_loop_solo(var_4, "cha_handler_idle", "firstloop");
      var_2 thread maps\_anim::anim_loop_solo(var_5, "cha_dog_idle", "firstloop");
    }

    if(isDefined(var_3) && !common_scripts\utility::flag("exfil_fire_fail")) {
      var_3.animname = "generic";
      var_3 maps\_utility::gun_remove();
      var_0 thread maps\_anim::anim_loop_solo(var_3, "commander_start");
    }

    common_scripts\utility::flag_wait("chaos_start_commander_vo");

    if(isDefined(var_5) && isalive(var_5) && isDefined(var_4) && isalive(var_4) && !common_scripts\utility::flag("exfil_fire_fail")) {
      var_2 notify("firstloop");
      var_2 thread maps\_anim::anim_single_solo(var_4, "cha_handler_alert");
      var_2 maps\_anim::anim_single_solo(var_5, "cha_dog_alert");
      var_6 = common_scripts\utility::spawn_tag_origin();
      var_6.origin = var_2.origin;
      var_6.angles = var_2.angles;

      if(isDefined(var_4) && isalive(var_4))
        var_2 thread maps\_anim::anim_loop_solo(var_4, "cha_handler_react", "secloop");

      if(isDefined(var_5) && isalive(var_5))
        var_2 thread maps\_anim::anim_loop_solo(var_5, "cha_dog_react", "secloop");
    }
  }

  thread commander_vo(var_3, level.walkers);
  common_scripts\utility::flag_wait("spawn_jeeps");
}

reassign_commander(var_0, var_1) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_0)) {
    var_0 maps\_utility::gun_recall();
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_exit_vol");
  }

  if(isalive(var_1))
    maps\clockwork_code::reassign_goal_volume(var_1, "chaos_exit_vol");
}

barkingdog_handle_stealth_break(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("exfil_fire_fail");
  var_0 notify("firstloop");
  var_0 notify("secloop");
}

#using_animtree("dog");

dog_bark() {
  self endon("death");
  var_0 = "anml_dog_bark";

  while(!common_scripts\utility::flag("spawn_jeeps")) {
    self setanim(%iw6_dog_attackidle_bark_add, 1, 0.1, 1);
    thread maps\_utility::play_sound_on_entity(var_0);
    wait(randomfloatrange(0.5, 1));
    self clearanim(%iw6_dog_attackidle_bark_add, 0.1);
  }
}

direction_group_dog() {
  var_0 = maps\_utility::spawn_targetname("chaos_direction_b1_dog");
  var_1 = maps\_utility::spawn_targetname("chaos_direction_b2_dog");
  var_2 = common_scripts\utility::getstruct("dog_talk_guy", "targetname");
  thread reassign_dog_group(var_0, var_1);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0.animname = "generic";
    var_1.animname = "generic";
    var_0 maps\_utility::gun_remove();
    var_1 maps\_utility::gun_remove();
    var_2 thread maps\_anim::anim_loop_solo(var_0, "direction_give");
    var_2 thread maps\_anim::anim_loop_solo(var_1, "direction_take");
  }

  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_0) || isDefined(var_0))
    var_0 delete();

  if(isalive(var_1) || isDefined(var_1))
    var_1 delete();
}

reassign_dog_group(var_0, var_1) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isDefined(var_0))
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_exit_vol");

  if(isDefined(var_0))
    maps\clockwork_code::reassign_goal_volume(var_1, "chaos_exit_vol");
}

direction_group() {
  var_0 = maps\_utility::spawn_targetname("chaos_direction_b1");
  var_1 = maps\_utility::spawn_targetname("chaos_direction_b2");
  var_2 = maps\_utility::spawn_targetname("chaos_direction1");
  var_3 = maps\_utility::spawn_targetname("chaos_direction2");
  var_4 = common_scripts\utility::getstruct("chaos_talking_a", "targetname");
  var_5 = common_scripts\utility::getstruct("chaos_talking_b", "targetname");
  thread reassign_dir_group(var_2, var_3, var_0, var_1);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0.animname = "generic";
    var_1.animname = "generic";
    var_0 maps\_utility::gun_remove();
    var_1 maps\_utility::gun_remove();
    var_5 thread maps\_anim::anim_loop_solo(var_0, "direction_give");
    var_5 thread maps\_anim::anim_loop_solo(var_1, "direction_take");
    var_2.animname = "generic";
    var_3.animname = "generic";
    var_2 maps\_utility::gun_remove();
    var_3 maps\_utility::gun_remove();
    var_4 thread maps\_anim::anim_loop_solo(var_2, "direction_give");
    var_4 thread maps\_anim::anim_loop_solo(var_3, "direction_take");
    thread losthope_vo(var_0, var_1);
    thread additionalexit_vo(var_2, var_3);
  }
}

reassign_dir_group(var_0, var_1, var_2, var_3) {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isalive(var_2)) {
    maps\clockwork_code::reassign_goal_volume(var_2, "chaos_exit_vol");
    var_2 maps\_utility::gun_recall();
  }

  if(isalive(var_3)) {
    maps\clockwork_code::reassign_goal_volume(var_3, "chaos_exit_vol");
    var_3 maps\_utility::gun_recall();
  }

  if(isalive(var_0)) {
    maps\clockwork_code::reassign_goal_volume(var_0, "chaos_exit_vol");
    var_0 maps\_utility::gun_recall();
  }

  if(isalive(var_1)) {
    maps\clockwork_code::reassign_goal_volume(var_1, "chaos_exit_vol");
    var_1 maps\_utility::gun_recall();
  }
}

commander_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  common_scripts\utility::flag_wait("chaos_start_commander_vo");
  thread pick_up_pace(var_1);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    if(isalive(var_0)) {
      var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ruc_lockitdown");
      var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_ruc_gettogarage");
    }

    allies_move_to_jeep();
  } else {
    foreach(var_3 in level.allies)
    var_3 maps\_utility::enable_ai_color();
  }
}

allies_move_to_jeep() {
  maps\clockwork_code::safe_activate_trigger_with_targetname("chaos_move_allies_to_garage");
  level.allies[0] thread ally_move_to_jeep("merrick_ready_jeep");
  level.allies[1] thread ally_move_to_jeep("keegan_ready_jeep");
  level.allies[2] thread ally_move_to_jeep("hesh_ready_jeep");
}

ally_move_to_jeep(var_0) {
  common_scripts\utility::flag_wait(var_0);
  maps\_utility::activate_trigger_with_targetname("chaos_color_allies_to_vehicle");
  waittillframeend;
  maps\_utility::enable_ai_color();
  self notify("stop_going_to_node");
}

pick_up_pace(var_0) {
  common_scripts\utility::flag_wait("chaos_garage_move");
  level.player allowsprint(1);
  level.player allowjump(1);
  thread maps\clockwork_code::blend_movespeedscale_custom(70, 1);
  level.allies[0] maps\clockwork_code::fast_walk(0);
  level.allies[0] maps\clockwork_code::fast_jog(1);
  wait 0.25;
  var_0[0] maps\clockwork_code::fast_walk(0);
  var_0[0] maps\clockwork_code::fast_jog(1);
  wait 0.5;
  var_0[1] maps\clockwork_code::fast_walk(0);
  var_0[1] maps\clockwork_code::fast_jog(1);
  level.allies[1] maps\clockwork_code::fast_walk(0);
  level.allies[1] maps\clockwork_code::fast_jog(1);
  wait 1;
  wait 0.25;
  level.allies[2] maps\clockwork_code::fast_walk(0);
  level.allies[2] maps\clockwork_code::fast_jog(1);
}

carry_in() {
  wait 2;

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0 = common_scripts\utility::getstruct("chaos_carry_loc", "targetname");
    var_1 = maps\_utility::spawn_targetname("chaos_carrier");
    var_2 = maps\_utility::spawn_targetname("chaos_carried");
    var_1.animname = "generic";
    var_2.animname = "generic";
    var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_sin");
    var_0 maps\_anim::anim_single_solo(var_2, "carried_sin");

    if(isalive(var_1) && !common_scripts\utility::flag("exfil_fire_fail"))
      var_0 thread maps\_anim::anim_loop_solo(var_1, "carrier_loop");

    if(isalive(var_2) && !common_scripts\utility::flag("exfil_fire_fail"))
      var_0 thread maps\_anim::anim_loop_solo(var_2, "carried_loop");

    common_scripts\utility::flag_wait("spawn_jeeps");

    if(isalive(var_1) || isDefined(var_1))
      var_1 delete();

    if(isalive(var_2) || isDefined(var_2))
      var_2 delete();
  }
}

dieing_revival() {
  var_0 = common_scripts\utility::getstruct("chaos_dieing_patient_loc", "targetname");
  var_1 = common_scripts\utility::getstruct("chaos_dead_patient_loc", "targetname");
  var_2 = common_scripts\utility::getstruct("chaos_doctor_loc", "targetname");
  var_3 = common_scripts\utility::getStructArray("chaos_dead_patient_mdloc", "targetname");
  var_4 = maps\_utility::spawn_targetname("chaos_dieing_doctor");
  var_5 = maps\_utility::spawn_targetname("chaos_dieing_patient");
  var_4.animname = "generic";
  var_5.animname = "generic";
  var_4 endon("death");
  var_5 maps\_utility::gun_remove();

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_4 maps\_utility::gun_remove();
    thread dieingrevival_vo(var_4);

    if(isalive(var_4))
      var_2 thread maps\_anim::anim_loop_solo(var_4, "dc_burning_cpr_medic_endidle", "doctor_wakeup");
  }

  var_0 thread maps\_anim::anim_loop_solo(var_5, "dc_burning_cpr_wounded_endidle");
  common_scripts\utility::flag_wait("spawn_jeeps");

  if(isalive(var_4) || isDefined(var_4))
    var_4 delete();

  if(isalive(var_5) || isDefined(var_5))
    var_5 delete();
}

dieingrevival_vo(var_0) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  wait 3;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_cpr");
  wait 1;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_live");
  wait 3;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_clottingagent");
  wait 2;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc1_continuingcpr");
  wait 3;
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_sc2_patientstable");
}

stumbler_upstairs() {
  var_0 = maps\_utility::spawn_targetname("chaos_stumbler");
  wait 1;

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_1 = common_scripts\utility::getstruct("chaos_stumbler_struct", "targetname");
    var_0.animname = "generic";
    var_0 maps\_utility::gun_remove();
    var_1 maps\_anim::anim_single_solo(var_0, "stumble_to_wall");
    var_1 thread maps\_anim::anim_loop_solo(var_0, "stumble_to_wall_idle");
  } else
    var_0 kill();
}

yurilast_vo(var_0, var_1) {
  level endon("exfil_fire_fail");
  var_0 endon("death");
  var_1 endon("death");

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_0.animname = "generic";
    var_1.animname = "generic";
    var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs1_killedyuri");
    var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_rs2_helpshisboys");
  }
}

in_to_jeep() {
  common_scripts\utility::flag_wait("spawn_jeeps");
  thread chaos_kill_player();
  wait 0.01;
  var_0 = getent("car_park_door_intro", "targetname");
  var_0 rotateyaw(-90, 0.2, 0.1, 0.1);
  var_0 connectpaths();
  var_1 = maps\_utility::array_spawn_targetname("car_park_base_jeep", 1);
  var_2 = maps\_utility::array_spawn_targetname("car_park_enter_jeep", 1);
  level.startjeep = maps\_vehicle::spawn_vehicle_from_targetname("enemy_jeep_start2");

  foreach(var_4 in var_2) {
    if(isalive(var_4) && isDefined(var_4.script_startingposition))
      var_4 thread waittoturnlightson(level.startjeep);
  }

  var_6 = maps\_vehicle::spawn_vehicle_from_targetname("enemy_jeep_start3");
  var_6 maps\_vehicle::vehicle_lights_on("headlights");
  var_7 = maps\_utility::spawn_targetname("sniffingdog", 1);
  var_7.team = "axis";

  if(isDefined(var_7) && !common_scripts\utility::flag("exfil_fire_fail")) {
    var_7.animname = "generic";
    var_7 thread maps\_anim::anim_loop_solo(var_7, "dog_scratch_door");
  }

  var_8 = maps\_utility::getstruct_delete("intro_jeep_end_path", "targetname");
  var_9 = maps\_utility::spawn_targetname("car_park_base_searcher", 1);

  if(isDefined(var_9) && !common_scripts\utility::flag("exfil_fire_fail")) {
    var_9.animname = "generic";
    var_8 thread maps\_anim::anim_loop_solo(var_9, "check_jeep");
  }

  level.jeep.animname = "jeep";
  var_8 thread maps\_anim::anim_loop_solo(level.jeep, "open_doors");
  wait 1;

  if(isDefined(level.start_point) && level.start_point == "exfil") {
    common_scripts\utility::flag_set("start_chaos");
    common_scripts\utility::waitframe();
  }

  maps\_utility::activate_trigger_with_targetname("chaos_color_allies_to_vehicle");
  var_10 = maps\_utility::array_spawn_targetname("car_park_stander", 1);
  level.playerjeep = maps\_vehicle::spawn_vehicle_from_targetname("jeep_exfil_ride_playerturret");
  level.playerjeep.runtovehicleoverride = maps\clockwork_code::vehicle_runtooverride;
  var_11 = spawn("script_model", level.playerjeep gettagorigin("tag_body"));
  var_11 setModel("vehicle_brave_warrior_turretring");
  var_11.angles = level.playerjeep gettagangles("tag_turret");
  var_11 linkto(level.playerjeep, "tag_body");
  level.allies[1] thread waittoturnlightson(level.playerjeep);
  thread baker_anim();
  level.gold_jeep_player_door_exfil = spawn("script_model", level.playerjeep.origin);
  level.gold_jeep_player_door_exfil setModel("chinese_brave_warrior_obj_door_back_RI");
  level.gold_jeep_player_door_exfil.angles = level.playerjeep.angles;
  level.gold_jeep_player_door_exfil linkto(level.playerjeep);
  wait 2;

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    level.startjeep.runtovehicleoverride = maps\clockwork_code::vehicle_runtooverride;
    level.startjeep maps\_vehicle::vehicle_load_ai(var_2);
    thread vehicle_stop_load_fail(var_2);
    thread vehicle_unload_fail();
    common_scripts\utility::array_thread(var_2, ::guy_loading_unload_fail);
  }

  common_scripts\utility::flag_wait("get_in_the_jeep");
  var_6 startpath();
  thread maps\clockwork_audio::garage_jeep_start_skid();
  maps\_utility::autosave_by_name("get_in_the_jeep");
  thread yurilast_vo(var_2[0], var_2[1]);
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_getinthejeep");
  thread maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  level.player allowsprint(1);
  level.player allowjump(1);
  common_scripts\utility::flag_wait("start_exfil_ride");

  if(common_scripts\utility::flag("exfil_fire_fail")) {
    var_12 = 1;
    thread wakeup_enemies(getaiarray("axis"));
  } else
    thread wait_to_wakeup_enemies(getaiarray("axis"));

  level.allies[0].script_startingposition = 1;
  level.allies[1].script_startingposition = 0;
  level.allies[2].script_startingposition = 2;
  level.secondload[0] = level.allies[0];
  level.firstload[0] = level.allies[1];
  level.firstload[1] = level.allies[2];
  level.gold_jeep_player_door_exfil delete();
  maps\_utility::disable_trigger_with_targetname("start_exfil_ride");
  level.playerjeep thread maps\clockwork_code::listen_player_collision();
  level.playerjeep thread maps\clockwork_code::listen_player_jolt();
  thread kill_player();
  var_13 = getent("car_park_door", "targetname");
  var_13 rotateyaw(90, 0.2, 0.1, 0.1);
  var_13 connectpaths();
  level.player setstance("stand");
  level.player disableweapons();
  level.player disableweapons();
  wait 0.25;
  var_14 = common_scripts\utility::getstruct("exfil_move_player_enter_jeep", "targetname");
  level.player.isanimating = 1;
  level.jeep_player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.jeep_player_arms hide();
  level.jeep_player_arms linkto(level.playerjeep, "tag_guy1", (-10, -45, -32), (0, 90, 0));
  level.playerjeep thread maps\_anim::anim_first_frame_solo(level.jeep_player_arms, "player_getin", "tag_guy1");
  level.player playerlinktoblend(level.jeep_player_arms, "tag_player", 0.25);
  wait 0.25;
  thread maps\clockwork_audio::exfil_enter_jeep();
  common_scripts\utility::exploder(750);
  level.jeep_player_arms show();
  playFXOnTag(common_scripts\utility::getfx("spotlight_dlight"), level.playerjeep, "tag_headlight_left");
  level.playerjeep.animname = "jeep";
  level.playerjeep thread maps\_anim::anim_single_solo(level.playerjeep, "player_getin");
  level.playerjeep maps\_anim::anim_single_solo(level.jeep_player_arms, "player_getin", "tag_guy1");
  level.jeep_player_arms hide();
  level.player enableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktodelta(level.jeep_player_arms, "tag_player", 0.9, 360, 360, 45, 30, 1);
  level.player setplayerangles((0, level.playerjeep.angles[1], 0));
  level.player.isanimating = undefined;
  common_scripts\utility::flag_wait("baker_in_jeep");

  for(;;) {
    if(isDefined(level.allies[1].ridingvehicle)) {
      if(isDefined(level.allies[2].ridingvehicle)) {
        break;
      }
    }

    wait 0.1;
  }

  if(!common_scripts\utility::flag("exfil_fire_fail"))
    level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_waitformysignal");

  thread maps\clockwork_audio::chase_player();

  if(isDefined(level.startjeep.driver) && isalive(level.startjeep.driver) && !common_scripts\utility::flag("exfil_fire_fail")) {
    thread maps\clockwork_audio::lead_jeep();
    level.startjeep startpath();
    level.startjeep.driver maps\_utility::magic_bullet_shield(1);
    level.startjeepmoving = 1;
    wait 1;
  }

  level notify("start_jeep_go");
  level.allies[1].animname = "generic";
  level.allies[2].animname = "generic";
  level.playerjeep.animname = "jeep";
  level.playerjeep thread vehicle_play_guy_anim("exfilstartdriver", level.allies[1], 0);
  level.playerjeep thread vehicle_play_guy_anim("exfilstartpassenger", level.allies[0], 1);
  level.playerjeep setflaggedanimrestart("vehicle_anim_flag", level.playerjeep maps\_utility::getanim("exfilstartJeep"));
  level.playerjeep startpath();
  wait 0.5;
  var_15 = getEntArray("chaos_patrollers", "script_noteworthy");

  foreach(var_4 in var_15) {
    if(isalive(var_4))
      var_4 delete();
  }

  wait 2;

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    var_18 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("enemy_jeep_start");
    var_18[0] maps\_vehicle::vehicle_lights_on("headlights");
  }

  var_19 = maps\_utility::array_spawn_targetname("exfil_warners", 1, 1);
  var_20 = maps\_utility::array_spawn_targetname("car_park_base", 1, 1);
  var_21 = maps\_utility::array_spawn_targetname("car_park_walkers", 1, 1);

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    thread handle_sneak_vo();

    foreach(var_4 in var_21)
    var_4 maps\clockwork_code::fast_walk(1);
  } else {
    thread wakeup_enemies(var_19);
    thread wakeup_enemies(var_20);
    thread wakeup_enemies(var_21);
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_exitingthebase");
    maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_meetonexfil");
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_exfilin2mins");
    thread maps\clockwork_code::clockwork_timer(95, &"CLOCKWORK_EXFIL", 1);
  }

  common_scripts\utility::flag_wait("exfil_door_close_start");

  if(isalive(var_7))
    var_7 delete();

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    thread skip_to_end(var_1, var_13, var_21, var_19, var_20);
    punchit_start(var_6);
    wait 0.5;
    punchit_end(var_6, var_13, var_21, var_19, var_20);
  }

  level.player disableoffhandweapons();
  thread wakeup_enemies(var_19);
  thread wakeup_enemies(var_20);
  thread wakeup_enemies(var_21);
  thread playfx_for_player_tread();
}

vehicle_stop_load_fail(var_0) {
  level endon("exfil_door_close_start");
  common_scripts\utility::flag_wait("exfil_fire_fail");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && !isDefined(var_2.boarding_vehicle))
      var_2 notify("stop_loading");
  }
}

vehicle_unload_fail() {
  level endon("start_jeep_go");
  common_scripts\utility::flag_wait("exfil_fire_fail");
  level.startjeep maps\_vehicle::vehicle_unload("all");
}

guy_loading_unload_fail() {
  self endon("death");
  self endon("stop_loading");
  thread guy_unset_allowdeath();
  self waittill("enteredvehicle");

  if(common_scripts\utility::flag("exfil_fire_fail")) {
    level.startjeep maps\_vehicle_aianim::guy_unload(self, self.vehicle_position);
    maps\clockwork_code::enemy_stop_stealth();
    self.ragdoll_immediate = undefined;
  }
}

guy_unset_allowdeath() {
  self endon("death");
  self waittill("boarding_vehicle");
  common_scripts\utility::waitframe();
  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
}

punchit_start(var_0) {
  thread handle_slap_slide_sound();
  var_1 = getEntArray("stop_guy", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isalive(var_3))
      level.stopguy1 = var_3;
  }

  var_5 = getEntArray("stop_guy2", "script_noteworthy");

  foreach(var_3 in var_5) {
    if(isalive(var_3))
      level.stopguy2 = var_3;
  }

  var_8 = getEntArray("stop_guy3", "script_noteworthy");

  foreach(var_3 in var_8) {
    if(isalive(var_3))
      level.stopguy3 = var_3;
  }

  var_11 = common_scripts\utility::getstruct("punchit_scene", "targetname");
  level.startjeep.animname = "cw_punchit";
  level.startjeep setflaggedanimrestart("vehicle_anim_flag", level.startjeep maps\_utility::getanim("punchit_start_enemy_jeep"));
  level.playerjeep.animname = "cw_punchit";
  level.playerjeep setflaggedanimrestart("vehicle_anim_flag", level.playerjeep maps\_utility::getanim("punchit_start_ally_jeep"));

  if(level.startjeep.riders[0].script_startingposition == 0) {
    level.startjeep.riders[0].animname = "generic";
    level.startjeep.riders[1].animname = "generic";
    level.startjeep.riders[0] thread maps\_anim::anim_single_solo(level.startjeep.riders[0], "punchit_start_edriver");
    level.startjeep.riders[1] thread maps\_anim::anim_single_solo(level.startjeep.riders[1], "punchit_start_epass");
  } else {
    level.startjeep.riders[0].animname = "generic";
    level.startjeep.riders[1].animname = "generic";
    level.startjeep.riders[1] thread maps\_anim::anim_single_solo(level.startjeep.riders[1], "punchit_start_edriver");
    level.startjeep.riders[0] thread maps\_anim::anim_single_solo(level.startjeep.riders[0], "punchit_start_epass");
  }

  level.allies[1].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_start_keegan", level.allies[1], 0);
  level.allies[0].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_start_baker", level.allies[0], 1);
  level.allies[2].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_start_cypher", level.allies[2], 2);
  level.pistol = maps\_utility::spawn_anim_model("cw_pistol", level.allies[2].origin);
  level.pistol.angles = level.allies[2].angles;
  level.pistol linkto(level.playerjeep, "tag_guy0");
  level.allies[2] thread maps\_anim::anim_single_solo(level.pistol, "start");
  level.stopguy1.animname = "generic";
  level.stopguy2.animname = "generic";
  level.stopguy3.animname = "generic";
  var_11 thread maps\_anim::anim_single_solo(level.stopguy1, "punchit_start_guard1");
  var_11 thread maps\_anim::anim_single_solo(level.stopguy2, "punchit_start_guard2");
  var_11 thread maps\_anim::anim_single_solo(level.stopguy3, "punchit_start_guard3");
  common_scripts\utility::flag_wait_or_timeout("exfil_fire_fail", 23);
}

handle_slap_slide_sound() {
  common_scripts\utility::flag_wait("guard_slap");
  thread maps\clockwork_audio::exfil_hoodsmack();
  common_scripts\utility::flag_wait("hesh_slide");
  thread maps\clockwork_audio::exfil_gun_cock(level.allies[2].origin);
}

skip_to_end(var_0, var_1, var_2, var_3, var_4) {
  level.player notifyonplayercommand("fired", "+attack");
  level.player waittill("fired");
  common_scripts\utility::flag_set("exfil_fire_fail");
  punchit_end(var_0, var_1, var_2, var_3, var_4);
  wait 3;

  if(!common_scripts\utility::flag("ally_start_path_exfil")) {
    setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_COMPROMISE");
    maps\_utility::missionfailedwrapper();
  }
}

punchit_end(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.skiptoend)) {
    return;
  }
  level.skiptoend = 1;
  var_5 = common_scripts\utility::getstruct("punchit_scene", "targetname");

  if(!common_scripts\utility::flag("exfil_fire_fail"))
    thread punchit_jeeps(var_0, var_5);

  if(level.startjeep.riders[0].script_startingposition == 0) {
    if(isDefined(level.startjeep.riders[0]) && isDefined(level.startjeep.riders[1])) {
      level.startjeep.riders[0].animname = "generic";
      level.startjeep.riders[1].animname = "generic";
      level.startjeep.riders[0] thread maps\_anim::anim_single_solo(level.startjeep.riders[0], "punchit_end_edriver");
      level.startjeep.riders[1] thread maps\_anim::anim_single_solo(level.startjeep.riders[1], "punchit_end_epass");
    }
  } else if(isDefined(level.startjeep.riders[0]) && isDefined(level.startjeep.riders[1])) {
    level.startjeep.riders[0].animname = "generic";
    level.startjeep.riders[1].animname = "generic";
    level.startjeep.riders[1] thread maps\_anim::anim_single_solo(level.startjeep.riders[1], "punchit_end_edriver");
    level.startjeep.riders[0] thread maps\_anim::anim_single_solo(level.startjeep.riders[0], "punchit_end_epass");
  }

  level.playerjeep.animname = "cw_punchit";
  level.playerjeep setflaggedanimrestart("vehicle_anim_flag", level.playerjeep maps\_utility::getanim("punchit_end_ally_jeep"));
  level.allies[1].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_end_keegan", level.allies[1], 0);
  level.allies[0].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_end_baker", level.allies[0], 1);
  level.allies[2].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("punchit_end_cypher", level.allies[2], 2);
  level.allies[2] thread maps\_anim::anim_single_solo(level.pistol, "end");

  if(isDefined(level.startjeep.riders[0]) && isDefined(level.startjeep.riders[1]) && !common_scripts\utility::flag("exfil_fire_fail")) {
    level.stopguy1.animname = "generic";
    var_5 thread maps\_anim::anim_single_solo(level.stopguy1, "punchit_end_guard1");
  } else if(isDefined(level.stopguy1)) {
    level.stopguy1 maps\_utility::anim_stopanimscripted();
    common_scripts\utility::waitframe();
    level.stopguy1 kill();
  }

  if(isDefined(level.startjeep.riders[0]) && isDefined(level.startjeep.riders[1]) && !common_scripts\utility::flag("exfil_fire_fail")) {
    level.stopguy2.animname = "generic";
    var_5 thread maps\_anim::anim_single_solo(level.stopguy2, "punchit_end_guard2");
  } else if(isDefined(level.stopguy2)) {
    level.stopguy2 maps\_utility::anim_stopanimscripted();
    common_scripts\utility::waitframe();
    level.stopguy2 kill();
  }

  thread guard3_anim_delay(var_5);
  wait 0.05;
  thread hesh_gunshots();
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_punchit");
  wait 0.2;
  common_scripts\utility::flag_set("chase_punch_it");
  common_scripts\utility::flag_set("punchit_go");
  level.player disableoffhandweapons();
  var_1 rotateyaw(-90, 12, 8, 1);

  foreach(var_7 in var_2) {
    if(isDefined(var_7))
      var_7 maps\clockwork_code::fast_walk(0);
  }

  if(isalive(var_3[0])) {
    var_9 = getnodearray("runto_exfil_1", "targetname");
    var_3[0] setgoalnode(var_9[0]);
    var_3[0] maps\_utility::set_fixednode_true();
  }

  if(isalive(var_3[1])) {
    var_10 = getnodearray("runto_exfil_2", "targetname");
    var_3[1] setgoalnode(var_10[0]);
    var_3[1] maps\_utility::set_fixednode_true();
  }

  thread wakeup_enemies(var_4);

  foreach(var_12 in level.allies) {
    var_12.ignoreall = 0;
    var_12.ignoreme = 0;
  }

  wait 1.25;
}

guard3_anim_delay(var_0) {
  common_scripts\utility::flag_wait("guard3_die");

  if(isDefined(level.startjeep.riders[0]) && isDefined(level.startjeep.riders[1]) && !common_scripts\utility::flag("exfil_fire_fail")) {
    level.stopguy3.animname = "generic";
    var_0 thread maps\_anim::anim_single_solo(level.stopguy3, "punchit_end_guard3");
  } else if(isDefined(level.stopguy3)) {
    level.stopguy3 maps\_utility::anim_stopanimscripted();
    common_scripts\utility::waitframe();
    level.stopguy3 kill();
  }
}

hesh_gunshots() {
  var_0 = anglesToForward(level.pistol gettagangles("tag_flash"));
  var_1 = level.pistol gettagorigin("tag_flash");
  magicbullet("p226", var_1, var_1 + var_0 * 32);
  wait 0.25;
  var_0 = anglesToForward(level.pistol gettagangles("tag_flash"));
  var_1 = level.pistol gettagorigin("tag_flash");
  magicbullet("p226", var_1, var_1 + var_0 * 32);
}

punchit_jeeps(var_0, var_1) {
  common_scripts\utility::flag_wait("punchit_car_two");
  wait 0.05;
  level.startjeep.animname = "cw_punchit";
  var_1 thread maps\_anim::anim_single_solo(level.startjeep, "punchit_end_enemy_jeep");
}

waittoturnlightson(var_0) {
  self waittill("enteredvehicle");
  var_0 maps\_vehicle::vehicle_lights_on("headlights");
}

baker_anim() {
  level.allies[0].animname = "generic";
  thread baker_in_to_jeep_anim();

  if(!common_scripts\utility::flag("exfil_fire_fail")) {
    if(!common_scripts\utility::flag("start_exfil_ride") && !common_scripts\utility::flag("exfil_fire_fail"))
      level.playerjeep maps\_anim::anim_reach_solo(level.allies[0], "garage_enter");

    if(!common_scripts\utility::flag("start_exfil_ride") && !common_scripts\utility::flag("exfil_fire_fail"))
      level.playerjeep maps\_anim::anim_single_solo(level.allies[0], "garage_enter");

    if(!common_scripts\utility::flag("start_exfil_ride") && !common_scripts\utility::flag("exfil_fire_fail"))
      level.playerjeep thread maps\_anim::anim_loop_solo(level.allies[0], "garage_loop", "end_loop");
  }

  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(!common_scripts\utility::flag("baker_ready")) {
    level.playerjeep notify("end_loop");
    level.allies[0] maps\_utility::anim_stopanimscripted();
  }
}

baker_in_to_jeep_anim() {
  common_scripts\utility::flag_wait("start_exfil_ride");
  wait 1;

  if(common_scripts\utility::flag("exfil_fire_fail"))
    level.allies[0] maps\_utility::anim_stopanimscripted();
  else
    level.playerjeep notify("end_loop");

  var_0 = common_scripts\utility::getstruct("get_in_keegan", "targetname");
  var_1 = common_scripts\utility::getstruct("get_in_cipher", "targetname");
  level.allies[1] forceteleport(var_0.origin, var_0.angles);
  level.allies[2] forceteleport(var_1.origin, var_1.angles);
  common_scripts\utility::waitframe();
  level.playerjeep maps\_vehicle::vehicle_load_ai(level.firstload);
  common_scripts\utility::flag_set("baker_ready");
  level.allies[0].boarding_vehicle = 1;
  level.playerjeep maps\_anim::anim_single_solo(level.allies[0], "garage_exit");
  level.allies[0] thread anim_enter_finished("baker_in_jeep");
  level.allies[0].boarding_vehicle = undefined;
}

wait_to_wakeup_enemies(var_0) {
  common_scripts\utility::flag_wait("exfil_fire_fail");
  wakeup_enemies(var_0);
}

wakeup_enemies(var_0) {
  var_0 = maps\_utility::array_removedead(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.ignoreall = 0;
      var_2.ignoreme = 0;

      if(isDefined(var_2) && !isDefined(var_2.script_drone) || var_2.script_drone == 0)
        var_2 setentitytarget(level.playerjeep);
    }

    wait 0.25;
  }
}

continous_fire() {}

handle_sneak_vo() {
  level endon("exfil_fire_fail");
  kill_estimates_vo();
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_exitingthebase");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_meetonexfil");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_exfilin2mins");
  thread maps\clockwork_code::clockwork_timer(125, &"CLOCKWORK_EXFIL", 1);
  common_scripts\utility::flag_wait("exfil_door_close_start");
  wait 2;
  thread handle_enemies_get_out_of_car();
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_theyrestoppingjeeps");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_keeptothescript");
  wait 1;
  level.allies[1] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_whatsgoingonup");
  wait 0.25;

  if(isalive(level.stopguy2))
    level.stopguy2 thread maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_wegottacheckeverybody");

  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_commandjustorderedus");

  if(isalive(level.stopguy2))
    level.stopguy2 thread maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_cmongetthemasks");

  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_wedonthavetime");

  if(isDefined(level.stopguy2) && isalive(level.stopguy2))
    level.stopguy2 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_getthemasksoff");
}

handle_enemies_get_out_of_car() {
  if(isalive(level.stopguy2))
    level.stopguy2 thread maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_outofthecar");

  wait 1;

  if(isalive(level.stopguy1))
    level.stopguy1 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf2_handsup");

  if(isalive(level.stopguy2))
    level.stopguy2 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_dontmove");

  if(isalive(level.stopguy2))
    level.stopguy2 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_youguysstopstop");

  if(isalive(level.stopguy2))
    level.stopguy2 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_heycuttheengine");

  if(isalive(level.stopguy2))
    level.stopguy2 maps\clockwork_code::char_dialog_add_and_go("clockwork_saf1_letsgocmoncut");
}

crash_event() {
  common_scripts\utility::flag_wait("ally_start_path_exfil");
  wait 0.25;
  maps\_utility::autosave_by_name("exfil_baseexit_save");
  maps\_utility::battlechatter_on("allies");
  thread getinturret();
  level.player waittill("movingToTurret");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 delete();
  }

  wait 0.1;
  var_4 = maps\_utility::array_spawn_targetname("exfil_exterior_base", 1);

  foreach(var_2 in var_4)
  var_2 set_diff_accuracy();

  waittillframeend;
  level.enemy_jeep_follower1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_follower1");
  waittillframeend;
  level.enemy_jeep_follower2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_follower2");
  waittillframeend;
  level.enemy_jeep_follower1 maps\_vehicle::vehicle_lights_on("headlights");
  level.enemy_jeep_follower2 maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 3;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_enemyjeepsonthe");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_takethemout");
  common_scripts\utility::flag_wait("gate_crash_player");
  level.enemy_jeep_follower2 maps\_vehicle::godoff();
  level.player enableinvulnerability();
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_ramit");
  wait 1;
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_holdon");
  wait 1;

  if(isalive(level.enemy_jeep_follower1)) {
    level.enemy_jeep_follower1 vehphys_enablecrashing();
    var_7 = maps\clockwork_code::rotate_vector((0, 90, 0), level.enemy_jeep_follower1.angles);
    level.enemy_jeep_follower1 vehphys_launch(var_7 * 2, 0);
  }

  wait 3;
  level.player disableinvulnerability();
  common_scripts\utility::flag_wait("rpg_spawn");
  var_8 = maps\_utility::get_living_ai_array("riders_exterior_delete", "script_noteworthy");

  foreach(var_2 in var_8) {
    if(isDefined(var_2))
      var_2 delete();
  }

  foreach(var_2 in var_4) {
    if(isDefined(var_2))
      var_2 delete();
  }

  if(isalive(level.enemy_jeep_follower1))
    level.enemy_jeep_follower1 delete();

  if(isalive(level.enemy_jeep_follower2))
    level.enemy_jeep_follower2 delete();
}

getinturret() {
  thread maps\clockwork_audio::exfil_get_on_turret();
  maps\_utility::objective_complete(maps\_utility::obj("exitfac"));
  var_0 = maps\_utility::obj("exfil");
  objective_add(var_0, "active", &"CLOCKWORK_EXTRACTION");
  objective_current(var_0);
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_bkr_getturret");
  level.allies[0] maps\_utility::clear_generic_idle_anim();
  level.allies[1] maps\_utility::clear_generic_idle_anim();
  level.allies[2] maps\_utility::clear_generic_idle_anim();
  level.player disableweapons();
  level.jeep_player_arms linkto(level.playerjeep, "tag_guy1", (50, 0, 0), (0, 0, 0));
  level.jeep_player_arms thread maps\_anim::anim_first_frame_solo(level.jeep_player_arms, "player_toturret");
  level.jeep_player_arms show();
  thread standally(0, 0.5);
  thread standally(2, 0.01);
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  level.player notify("movingToTurret");
  level.playerjeep maps\_anim::anim_single_solo(level.jeep_player_arms, "player_toturret", "tag_guy1");
  thread maps\clockwork_code::play_rumble_seconds("damage_heavy", 0.25);
  thread maps\clockwork_code::screenshakefade(0.35, 0.25);
  level.jeep_player_arms hide();
  level.player playerlinktodelta(level.playerjeep, "tag_guy_turret", 0.1, 360, 360, 30, 5, 1);
  level.jeep_player_arms delete();
  var_1 = level.playerjeep.mgturret[0];
  var_1 makeusable();
  var_1 useby(level.player);
  var_1 makeunusable();
  level.player enableweapons();
  level.player_turret = var_1;
  level.player setplayerangles((0, level.playerjeep.angles[1], 0));
  level.player disableturretdismount();
  thread maps\clockwork_code::player_viewhands_minigun(var_1, "viewhands_player_fed_army_arctic");
  level.playerjeep thread maps\clockwork_code::fire_grenade();
  level.player setstance("stand");
  setsaveddvar("aim_aimAssistRangeScale", "0");
  setsaveddvar("aim_autoAimRangeScale", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", "0");
  level.playerjeep maps\_vehicle::vehicle_ai_event("idle_alert");
  level.playerjeep thread player_view_clamp();
}

standally(var_0, var_1) {
  wait(var_1);
  level.allies[var_0] notify("newanim");
  level.allies[var_0].desired_anim_pose = "crouch";
  level.allies[var_0] maps\_utility::anim_stopanimscripted();
  level.allies[var_0] allowedstances("crouch");
  level.allies[var_0].baseaccuracy = 0.1;
  level.allies[var_0].accuracystationarymod = 0.5;
}

headon_event() {
  common_scripts\utility::flag_wait("en_headon_road");
  wait 0.25;
  level.enemy_jeep_turret[level.enemy_jeep_turret.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_tank_headon");
  thread enemy_zodiacs_spawn_and_attack();
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_intercept1");
  waittillframeend;
  level.speedjeep = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_intercept2");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_intercept4");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_intercept6");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  level.speedjeep maps\_vehicle::vehicle_lights_on("headlights");
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 3;
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_offtheroad");
  wait 1;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_jeep_intercept3");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  wait 1;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_jeep_intercept5");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  wait 2;
  level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_targetsbehindus");
}

canal_event() {
  common_scripts\utility::flag_wait("rpg_spawn");
  var_0 = maps\_utility::array_spawn_targetname("canal_rpgers", 1);
  common_scripts\utility::array_thread(var_0, maps\_utility::magic_bullet_shield);
  level.icehole_count = 0;
  level.player thread maps\clockwork_code::handle_grenade_launcher();
  common_scripts\utility::flag_wait("rpg_fire");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_rpgs");
  thread maps\clockwork_audio::chase_tower_fire();
  var_1 = missile_createrepulsorent(level.playerjeep, 750, 10000);
  var_2 = var_0[2].origin + (-60, 0, 75);
  var_3 = common_scripts\utility::getstruct("rpg_hit_enemy_jeep", "targetname");
  magicbullet("rpg_straight", var_2, var_3.origin);
  wait 1.25;
  missile_deleteattractor(var_1);
  var_2 = var_0[0].origin + (-60, 0, 75);
  var_3 = common_scripts\utility::getstruct("rpg_hit_enemy_jeep", "targetname");
  magicbullet("rpg_straight", var_2, var_3.origin);
  wait 1.25;
  thread maps\clockwork_code::add_ice_radius(50, var_3.origin);

  if(isalive(level.speedjeep))
    level.speedjeep thread maps\clockwork_code::play_long_crash();

  var_2 = var_0[1].origin + (0, -60, 75);
  var_3 = common_scripts\utility::getstruct("rpg_target_ally_jeep", "targetname");
  magicbullet("rpg_straight", var_2, var_3.origin);
  wait 1.25;
  thread maps\clockwork_code::add_ice_radius(50, var_3.origin);
  common_scripts\utility::array_thread(var_0, maps\_utility::stop_magic_bullet_shield);

  foreach(var_5 in var_0)
  var_5 kill();

  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_shoottheice");
  var_7 = maps\_utility::array_spawn_targetname("exfil_exterior_tunnel", 1);

  foreach(var_9 in var_7)
  var_9 set_diff_accuracy();

  common_scripts\utility::flag_wait("spawn_tunnel_jeep");
  thread maps\clockwork_audio::chase_tunnel_jeep();
  common_scripts\utility::flag_set("tubelight_parking");
  maps\_utility::stop_exploder(250);
  maps\_utility::stop_exploder(300);
  maps\_utility::stop_exploder(301);
  maps\_utility::stop_exploder(750);
  level.enemy_jeep_a[level.enemy_jeep_a.size] = thread maps\_vehicle::spawn_vehicle_from_targetname_and_drive("snowmobile_spawner_bend1");
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  common_scripts\utility::flag_wait("en_jeep2_jump");

  foreach(var_9 in var_7) {
    if(isDefined(var_9))
      var_9 delete();
  }
}

tank_event() {
  common_scripts\utility::flag_wait("en_jeepphys_spawn");
  maps\_utility::autosave_by_name("exfil_tank");
  wait 3;
  level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_snowmobilesbehind");
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("snowmobile_spawner_bend2");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  wait 0.2;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("snowmobile_spawner_bend3");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread wipeout_bikes();
  common_scripts\utility::flag_wait("en_jeep2_jump");
  wait 1;
  level.tank_bridge = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_tank_bridge");
  wait 0.25;
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_tankfire1");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_tankfire2");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  var_0 = level.enemy_jeep_a[level.enemy_jeep_a.size - 1];
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 1.7;
  level.tankfire_spline_jeep = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_jeep_tankfire3");
  level.enemy_jeep_s[level.enemy_jeep_s.size] = level.tankfire_spline_jeep;
  level.tankfire_spline_jeep maps\_vehicle::vehicle_lights_on("headlights");
  level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_jeepsbehind");
  thread enemy_jeep_group_fire();
  wait 4.5;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_bridgea1");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_bridgea2");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  wait 3.5;
  thread forty_five_sec_vo();

  if(isalive(level.tank_bridge)) {
    level.tank_bridge.attachedpath = undefined;
    level.tank_bridge notify("newpath");
    level.tank_bridge vehicle_setspeed(30, 4, 4);
    level.tank_bridge resumespeed(3);
    var_1 = getvehiclenode("tank_chase_path", "targetname");
    level.tank_bridge thread maps\_vehicle::vehicle_paths(var_1);
    level.tank_bridge startpath(var_1);
  }

  common_scripts\utility::flag_wait("spawn_bridge_jeeps");
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("highway_jeep1");
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  common_scripts\utility::flag_wait("exfil_car_should_crash");
  var_0 thread maps\clockwork_code::play_crash_anim(var_0.origin);
  var_0 notify("icehole_occured");
}

forty_five_sec_vo() {
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_hotexfil");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_npt_45seconds");
  wait 3;
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_shoottheice");
}

bridge_event() {
  common_scripts\utility::flag_wait("exfil_prechoke_spawn");
  thread maps\clockwork_fx::handle_jeep_launch_fx();
  maps\_utility::autosave_by_name("prechoke_save");
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_bridge1");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_bridge2");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread wipeout_bikes();
  thread maps\clockwork_audio::snowmobiles();
  common_scripts\utility::flag_wait("exfil_spawn_choke_guys");
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_prechoke1");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  var_0 = level.enemy_jeep_b[level.enemy_jeep_b.size - 1];
  thread enemy_jeep_group_fire();
  wait 1;
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_prechoke2");
  waittillframeend;
  var_1 maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;
  thread enemy_jeep_group_fire();
  thread maps\clockwork_audio::bigjump();
  wait 2;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = var_1;
  level.enemy_jeep_turret[level.enemy_jeep_turret.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_prechoke3");
  waittillframeend;
  level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 3;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_getusout");
  level.allies[1] maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_underbridge");
  common_scripts\utility::flag_wait("exfil_bridge_spawn");
  maps\_utility::autosave_by_name("bridge");
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("highway_jeep2");
  waittillframeend;
  var_2 maps\_vehicle::vehicle_lights_on("headlights");
  wait 0.25;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_bridge1");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_bridge2");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 0.25;
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_bridge3");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_vehiclesright");
  wait 2.5;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_choke1");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_choke2");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;

  if(isalive(level.tankfire_spline_jeep))
    level.tankfire_spline_jeep maps\_vehicle_spline_zodiac::wipeout("left behind!");

  wait 0.05;

  if(isalive(var_1)) {
    var_3 = var_1.maxhealth;
    var_1 dodamage(var_3 * 2, var_1.origin);
  }

  wait 0.05;

  if(isalive(var_0)) {
    var_3 = var_0.maxhealth;
    var_0 dodamage(var_3 * 2, var_0.origin);
  }

  wait 3;
  level.enemy_jeep_b[level.enemy_jeep_b.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_straight1");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_straight2");
  waittillframeend;
  level.enemy_jeep_b[level.enemy_jeep_b.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
}

new_cliff_moment() {
  common_scripts\utility::flag_wait("enemy_cave_spawn");
  maps\_utility::autosave_by_name("cliff");
  level.iceblocker = getent("sub_ice_blocker", "targetname");
  level.iceblocker hide();
  level.enemy_snowmobile = maps\_utility::array_removedead(level.enemy_snowmobile);

  foreach(var_1 in level.enemy_snowmobile)
  var_1 maps\_vehicle_spline_zodiac::wipeout("left behind!");

  level.enemy_jeep_a[level.enemy_jeep_a.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_cave1");
  waittillframeend;
  level.enemy_jeep_a[level.enemy_jeep_a.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  level.enemy_jeep_turret[level.enemy_jeep_turret.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_cave2");
  waittillframeend;
  level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  wait 1;
  level.enemy_snowmobile[level.enemy_snowmobile.size] = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_cave1");
  level.enemy_snowmobile[level.enemy_snowmobile.size - 1] maps\_vehicle::vehicle_lights_on("headlights");
  waittillframeend;
  thread enemy_jeep_group_fire();
  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_vehiclesright");

  if(isalive(level.player))
    level.player lerpviewangleclamp(1.25, 0.5, 0.25, 45, 60, 30, 5);

  wait 6;
  level.endingjeep = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_jeep_collaspe1");
  waittillframeend;
  level.endingjeep maps\_vehicle::vehicle_lights_on("headlights");
  thread enemy_jeep_group_fire();
  wait 1;
  waittillframeend;
  level.lastsnow1 = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_collaspe1");
  waittillframeend;
  level.lastsnow2 = thread maps\clockwork_code::spawn_enemy_bike_at_spawer("enemy_snowmobile_collaspe2");

  if(isalive(level.player))
    level.player lerpviewangleclamp(1.25, 0.5, 0.25, 45, 45, 30, 5);

  common_scripts\utility::flag_wait_or_timeout("kill_jeep_1", 6);

  if(isalive(level.enemy_jeep_a[level.enemy_jeep_a.size - 1]) && isalive(level.enemy_jeep_a[level.enemy_jeep_a.size - 1].driver))
    level.enemy_jeep_a[level.enemy_jeep_a.size - 1].driver kill();

  common_scripts\utility::flag_wait_or_timeout("kill_jeep_2", 3);

  if(isalive(level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1]) && isalive(level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1].driver)) {
    thread maps\clockwork_code::dynamic_icehole_crash(level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1], 0);
    level.enemy_jeep_turret[level.enemy_jeep_turret.size - 1].driver kill();
  }

  common_scripts\utility::flag_wait_or_timeout("kill_jeep_3", 1.5);

  if(isalive(level.endingjeep) && isalive(level.endingjeep.driver)) {
    common_scripts\utility::flag_set("kill_endingjeep");
    wait 0.05;
    level.endingjeep.driver kill();
    thread maps\clockwork_code::dynamic_icehole_crash(level.endingjeep, 0);
  }
}

new_nxsub_breach_moment() {
  var_0 = common_scripts\utility::getstruct("submarine_origin_height", "targetname");
  common_scripts\utility::flag_wait("exfil_exit_cave");
  level.playerjeep.dontunloadonend = 1;
  wait 1;
  wait 1.05;
  level.player enableinvulnerability();
  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_inposition");
  wait 1.5;
  thread maps\clockwork_code::killtimer();
  thread maps\clockwork_code::play_rumble_seconds("damage_heavy", 0.25);
  thread maps\clockwork_code::screenshakefade(0.45, 0.5);
  thread ending_screenshake();
  thread play_fx_for_sub();
  thread play_fx_for_sub_front();
  thread play_fx_for_sub_back();
  thread play_fx_for_sub_largeice();
  thread play_fx_for_sub_blow();
  var_1 = maps\_utility::spawn_anim_model("cw_sub_ice", var_0.origin);
  var_2 = maps\_utility::spawn_anim_model("cw_sub_sub", var_0.origin);
  var_3 = getent("sub_collision", "targetname");
  var_3.origin = var_2 gettagorigin("j_sub_anim");
  var_3.angles = var_2 gettagangles("j_sub_anim");
  var_3 linkto(var_2, "j_sub_anim");
  level.allies[1].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("nxsubdriver", level.allies[1], 0);
  level.allies[0].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("nxsubpassenger", level.allies[0], 1);
  level.allies[2].animname = "generic";
  level.playerjeep thread vehicle_play_guy_anim("nxsubbackseat", level.allies[2], 2);
  var_0 thread maps\_anim::anim_single_solo(var_1, "ice_breach");
  level.subfx = maps\_utility::spawn_anim_model("nxsubfx", var_0.origin);
  level.subfx.angles = var_0.angles;
  level.subfx thread maps\_anim::anim_single_solo(level.subfx, "subfxanim");
  thread playfx_for_sub_slide();
  thread surfacing_now_vo();
  var_0 thread maps\_anim::anim_single_solo(var_2, "sub_breach");
  wait 6.4;
  level.jeep_player_arms_sub = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  level.jeep_player_arms_sub setModel("clk_watch_viewhands");
  level.jeep_player_arms_sub hide();
  var_0 thread maps\_anim::anim_first_frame_solo(level.jeep_player_arms_sub, "nx_sub_alt");
  level.player lerpviewangleclamp(1.25, 0.5, 0.25, 0, 0, 0, 0);
  level.player disableweapons();
  level.player takeallweapons();
  level.missionend = 1;
  level.player notify("missionend");
  level.iceblocker show();
  var_4 = level.playerjeep.mgturret[0];
  var_5 = level.player getplayerviewheight();
  var_6 = level.player getEye();
  var_4 setturretdismountorg(level.jeep_player_arms_sub gettagorigin("tag_player") + (16, 16, 0));
  var_4 useby(level.player);
  level.playerjeep.animname = "cw_car_breach";
  var_0 thread maps\_anim::anim_first_frame_solo(level.playerjeep, "player_car_alt");
  level.player playerlinktodelta(level.jeep_player_arms_sub, "tag_player", 1, 20, 20, 20, 0);
  level.jeep_player_arms_sub show();
  var_0 thread maps\_anim::anim_single_solo(level.jeep_player_arms_sub, "nx_sub_alt");
  var_0 thread maps\_anim::anim_single_solo(level.playerjeep, "player_car_alt");
  thread fire_tracers();
  wait 4;
  level.crashed_trucks show();
  level.crashed_truck1 show();
  level.crashed_truck2 show();
  thread start_jeep_fire();
  wait 4;
  level.player giveweapon("cz805bren+reflex_sp+silencer_sp");
  level.player enableweapons();
  wait 1;
  level.jeep_player_arms_sub hide();
  level.player unlink();
  wait 1.25;
  maps\_utility::objective_complete(maps\_utility::obj("exfil"));
  maps\_hud_util::fade_out(3, "black");
  common_scripts\utility::flag_set("aud_fade_out");
  wait 5;
  maps\_utility::nextmission();
}

surfacing_now_vo() {
  thread maps\clockwork_audio::chase_stinger_music();
  wait 1;
  thread maps\clockwork_code::radio_dialog_add_and_go("clockwork_npt_neptuneoneison_2");
}

fire_tracers() {
  var_0 = common_scripts\utility::getstruct("exfil_ending_tracer_start", "targetname");
  bullettracer(var_0.origin, level.player.origin + (32, 0, 64), 1);
  wait 0.15;
  bullettracer(var_0.origin, level.player.origin + (32, 16, 64), 1);
  wait 0.25;
  bullettracer(var_0.origin, level.player.origin + (16, 16, 64), 1);
  wait 2;
  bullettracer(var_0.origin, level.player.origin + (16, 0, 64), 1);
  wait 0.15;
  bullettracer(var_0.origin, level.player.origin + (32, 16, 64), 1);
  wait 0.15;
  bullettracer(var_0.origin, level.player.origin + (16, 0, 64), 1);
}

playfx_for_sub_slide() {
  level endon("on_sub");
  common_scripts\utility::flag_wait("exfil_player_sub_jump");

  while(!common_scripts\utility::flag("on_sub")) {
    wait 1;
    playFXOnTag(common_scripts\utility::getfx("fx/treadfx/clk_jeep_skid_sub"), level.playerjeep, "tag_wheel_front_left");
    wait 0.5;
  }

  playFXOnTag(common_scripts\utility::getfx("fx/treadfx/clk_jeep_skid_sub"), level.playerjeep, "tag_wheel_front_left");
}

playfx_for_tread() {
  self.conttread = 1;
  thread stop_tread();

  while(isalive(self) && self.conttread) {
    playFXOnTag(common_scripts\utility::getfx("fx/treadfx/tread_snow_speed_clk"), self, "tag_wheel_back_left");
    playFXOnTag(common_scripts\utility::getfx("fx/treadfx/tread_snow_speed_clk"), self, "tag_wheel_back_right");
    wait 0.1;
  }
}

stop_tread() {
  self waittill("kill_tread");

  if(isalive(self))
    self.conttread = 0;
}

playfx_for_player_tread() {
  for(;;)
    wait 0.25;
}

play_fx_for_sub() {
  wait 1;
  common_scripts\utility::exploder(7005);
  wait 0.1;
  common_scripts\utility::exploder(7006);
  wait 0.4;
  common_scripts\utility::exploder(7007);
  wait 0.6;
  common_scripts\utility::exploder(7008);
  wait 0.1;
  common_scripts\utility::exploder(7009);
  wait 0.2;
  common_scripts\utility::exploder(7010);
  wait 0.3;
  common_scripts\utility::exploder(7011);
  wait 0.2;
  common_scripts\utility::exploder(7100);
  wait 0.1;
  common_scripts\utility::exploder(7102);
  wait 0.1;
  common_scripts\utility::exploder(7103);
}

play_fx_for_sub_front() {
  wait 3.2;
  common_scripts\utility::exploder(9000);
  wait 0.1;
  common_scripts\utility::exploder(9004);
  wait 0.2;
  common_scripts\utility::exploder(9001);
  wait 0.1;
  common_scripts\utility::exploder(9002);
  wait 0.2;
  common_scripts\utility::exploder(9003);
  wait 0.1;
  common_scripts\utility::exploder(9005);
  wait 0.2;
  common_scripts\utility::exploder(9006);
}

play_fx_for_sub_back() {
  wait 3.4;
  common_scripts\utility::exploder(9007);
  wait 0.1;
  common_scripts\utility::exploder(9010);
  wait 0.2;
  common_scripts\utility::exploder(9009);
  wait 0.1;
  common_scripts\utility::exploder(9008);
  wait 0.2;
  common_scripts\utility::exploder(9011);
  wait 0.1;
  common_scripts\utility::exploder(9012);
  wait 0.2;
  common_scripts\utility::exploder(9013);
}

play_fx_for_sub_largeice() {
  wait 6;
  common_scripts\utility::exploder(9200);
  wait 0.1;
  common_scripts\utility::exploder(9201);
  wait 0.2;
  common_scripts\utility::exploder(9202);
}

play_fx_for_sub_blow() {
  wait 7;
  common_scripts\utility::exploder(9300);
}

play_sub_fx_icerise(var_0) {
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk01");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk02");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk03");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk04");
  wait 0.05;
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk05");
  wait 0.05;
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk06");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk07");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk08");
  playFXOnTag(level._effect["fx/misc/clk_sub_rise"], level.subfx, "fx_ice_chunk09");
}

play_sub_fx_settle(var_0) {
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk01");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk02");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk03");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk04");
  wait 0.05;
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk05");
  wait 0.05;
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk06");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk07");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk08");
  playFXOnTag(level._effect["fx/weather/snow_sub_blow"], level.subfx, "fx_ice_chunk09");
}

start_jeep_fire() {
  var_0 = (34331.6, 21599.2, 244);
  var_1 = (270.001, 359.436, 17.5646);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["fx/fire/fire_gaz_clk"], var_0, var_3, var_2);
  triggerfx(var_4, -20);
  var_0 = (33577.5, 21155.1, 223);
  var_1 = (270.001, 359.501, 56.4988);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["fx/fire/fire_gaz_clk"], var_0, var_3, var_2);
  triggerfx(var_4, -20);
}

ending_screenshake() {
  wait 1;
  thread play_rumbles();
}

play_rumbles() {
  maps\clockwork_code::play_rumble_seconds("drill_normal", 5.5);
  maps\clockwork_code::play_rumble_seconds("damage_heavy", 0.25);
  maps\clockwork_code::play_rumble_seconds("drill_normal", 0.35);
  maps\clockwork_code::play_rumble_seconds("damage_heavy", 0.75);
  maps\clockwork_code::play_rumble_seconds("drill_normal", 1.25);
  maps\clockwork_code::play_rumble_seconds("damage_heavy", 0.65);
}

fire_fail_exfil_vo() {
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(!common_scripts\utility::flag("start_exfil_ride")) {
    foreach(var_1 in level.allies) {
      if(!isDefined(var_1.boarding_vehicle) || !var_1.boarding_vehicle)
        var_1 maps\_utility::anim_stopanimscripted();
    }
  }

  level.allies[2] notify("_utility::follow_path");
  level.allies[1] notify("_utility::follow_path");
  level.allies[0] notify("_utility::follow_path");
  level.allies[2] maps\_utility::enable_ai_color();
  level.allies[1] maps\_utility::enable_ai_color();
  level.allies[0] maps\_utility::enable_ai_color();
  setsaveddvar("aim_aimAssistRangeScale", "1");
  setsaveddvar("aim_autoAimRangeScale", "1");
  common_scripts\utility::array_thread(level.allies, maps\clockwork_code::fast_walk, 0);
  thread maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  level.player enableoffhandweapons();
  level.player allowsprint(1);
  level.player allowjump(1);

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 0;
    var_1 maps\_utility::set_baseaccuracy(10);
    var_1.ignoresuppression = 1;
    var_1.suppressionwait = 0;
    var_1.disablebulletwhizbyreaction = 1;
    var_1.ignorerandombulletdamage = 1;
    var_1 thread maps\_utility::disable_pain();
  }

  if(!common_scripts\utility::flag("start_exfil_ride")) {
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_gettojeep");
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_gogogo");
  }

  common_scripts\utility::flag_wait("start_exfil_ride");
  level.playerjeep maps\_utility::ent_flag_wait("loaded");
  common_scripts\utility::flag_clear("punchit_exfil_hot");
  common_scripts\utility::flag_set("punchit_go");

  if(!common_scripts\utility::flag("exfil_door_close_start")) {
    level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_punchit");
    common_scripts\utility::flag_set("chase_punch_it");
    level.playerjeep vehicle_setspeed(40, 10);
    level.startjeep vehicle_setspeed(40, 10);
  }

  common_scripts\utility::flag_wait("exfil_door_close_start");
  level.playerjeep vehicle_setspeed(30, 10);

  if(common_scripts\utility::flag("punchit_jeep_play_anim")) {
    common_scripts\utility::flag_wait("punchit_car_two");
    var_5 = vectornormalize(level.playerjeep vehicle_getvelocity()) * 5000;
    level.startjeep vehphys_launch(var_5);
  }

  common_scripts\utility::flag_wait("ally_start_path_exfil");
  level.playerjeep resumespeed(40);
}

stop_ads_moment() {
  while(!common_scripts\utility::flag("chaos_meetup_follow_spawn") && !common_scripts\utility::flag("exfil_fire_fail")) {
    level.player allowfire(0);

    if(level.player playerads() > 0.3) {
      level.player allowfire(0);
      level.player allowads(0);
      level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_weaponsdown");
      level.player allowads(1);
      return;
    }

    wait 0.05;
  }
}

exfil_alert_handle() {
  level endon("ally_start_path_exfil");
  common_scripts\utility::flag_wait("elevator_open");
  maps\_utility::set_allowdeath(1);
  self.alertlevel = "noncombat";

  if(!isDefined(self.script_drone)) {
    if(common_scripts\utility::flag("exfil_fire_fail")) {
      maps\clockwork_code::enemy_stop_stealth();
      return;
    }

    thread wakeup_on_knife();
    thread wakeup_drone_kill();
    self addaieventlistener("grenade danger");
    self addaieventlistener("projectile_impact");
    self addaieventlistener("silenced_shot");
    self addaieventlistener("bulletwhizby");
    self addaieventlistener("gunshot");
    self addaieventlistener("explode");
    self addaieventlistener("death");
    self waittill("ai_event", var_0);

    if(isDefined(self) && !isDefined(self.vehicle_position) && !isDefined(self.boarding_vehicle)) {
      maps\clockwork_code::enemy_stop_stealth();
      maps\clockwork_code::fast_walk(0);
    }

    common_scripts\utility::flag_set("exfil_fire_fail");
  } else {
    if(common_scripts\utility::flag("exfil_fire_fail")) {
      if(isDefined(self) && isalive(self))
        self kill();
    }

    thread kill_drone();
    self waittill("death");

    if(isDefined(self))
      common_scripts\utility::flag_set("exfil_fire_fail");
  }
}

wakeup_on_knife() {
  level endon("start_exfil_ride");
  level.player notifyonplayercommand("playermeleed", "+melee");
  level.player notifyonplayercommand("playermeleed", "+melee_zoom");
  level.player waittill("playermeleed");

  if(isDefined(self)) {
    if(isDefined(self) && !isDefined(self.vehicle_position) && !isDefined(self.boarding_vehicle)) {
      maps\clockwork_code::enemy_stop_stealth();
      maps\clockwork_code::fast_walk(0);
    }
  }

  common_scripts\utility::flag_set("exfil_fire_fail");
}

wakeup_drone_kill() {
  self endon("Death");
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isDefined(self) && !isDefined(self.vehicle_position) && !isDefined(self.boarding_vehicle))
    maps\clockwork_code::enemy_stop_stealth();
}

kill_drone() {
  self endon("Death");
  common_scripts\utility::flag_wait("exfil_fire_fail");

  if(isDefined(self) && isalive(self))
    self kill();
}

kill_player() {
  level endon("player_jeep_crashing");

  for(;;) {
    if(!isalive(level.playerjeep)) {
      level.player notify("playercrash");
      level.player disableinvulnerability();
      common_scripts\utility::waitframe();
      level.player kill();
      return;
    }

    common_scripts\utility::waitframe();
  }
}

enemy_zodiacs_spawn_and_attack() {
  level endon("enemy_zodiacs_wipe_out");
  level.player.progress = 0;
  var_0 = 3;
  wait 2;

  for(;;) {
    level.player.progress = level.player.progress + 450;
    thread maps\_vehicle_spline_zodiac::spawn_enemy_bike();
    wait(var_0);
    var_0 = var_0 - 0.5;

    if(var_0 < 0.5)
      var_0 = 0.5;
  }
}

enemy_jeep_group_fire() {
  foreach(var_1 in level.enemy_jeep_turret) {
    if(isDefined(var_1) && isalive(var_1) && !isDefined(var_1.setup_for_exfil) && isDefined(var_1.mgturret)) {
      foreach(var_3 in var_1.mgturret) {
        if(isalive(var_1) && isDefined(var_3)) {
          var_3 setaispread(20);
          var_3 setconvergencetime(3);
          var_3.accuracy = 0.1;
        }
      }

      var_1.setup_for_exfil = 1;
      var_1.vehicle_stays_alive = 1;
      var_1.spline = 0;
      var_1.health = 2000;
      var_1 thread crash_vehicle_on_death();
      thread maps\clockwork_code::driver_dies(var_1);
      var_1 thread maps\clockwork_code::start_ice_effects();
      var_1 thread vehicle_death_check();
      var_1 thread playfx_for_tread();
    }
  }

  foreach(var_1 in level.enemy_jeep_a) {
    if(isalive(var_1) && !isDefined(var_1.setup_for_exfil)) {
      var_1.setup_for_exfil = 1;
      var_1.vehicle_stays_alive = 1;
      var_1.spline = 0;
      var_1 thread jeeps_fire();
      var_1.health = 2000;
      var_1 thread crash_vehicle_on_death();
      thread maps\clockwork_code::driver_dies(var_1);
      var_1 thread maps\clockwork_code::start_ice_effects();
      var_1 thread vehicle_death_check();
      var_1 thread playfx_for_tread();
    }
  }

  foreach(var_1 in level.enemy_jeep_b) {
    if(isalive(var_1) && !isDefined(var_1.setup_for_exfil)) {
      var_1.setup_for_exfil = 1;
      var_1.vehicle_stays_alive = 1;
      var_1.spline = 0;
      var_1 thread jeeps_fire();
      var_1.health = 2000;
      var_1 thread crash_vehicle_on_death();
      thread maps\clockwork_code::driver_dies(var_1);
      var_1 thread maps\clockwork_code::start_ice_effects();
      var_1 thread vehicle_death_check();
      var_1 thread playfx_for_tread();
    }
  }

  foreach(var_1 in level.enemy_jeep_s) {
    if(isalive(var_1) && !isDefined(var_1.setup_for_exfil)) {
      var_1.setup_for_exfil = 1;
      var_1.vehicle_stays_alive = 1;
      var_1.spline = 1;
      var_1 thread jeeps_fire();
      thread maps\clockwork_code::driver_dies(var_1);
      var_1 thread maps\clockwork_code::start_ice_effects();
      var_1 thread vehicle_death_check();
      var_1 thread playfx_for_tread();
    }
  }
}

jeeps_fire() {
  foreach(var_1 in self.riders)
  var_1 thread jeep_ai(self);
}

jeep_ai(var_0) {
  if(!isai(self) || self == var_0.attachedguys[0]) {
    return;
  }
  self notify("newanim");
  maps\_utility::anim_stopanimscripted();
  maps\_utility::gun_recall();

  if(self == level.allies[0] || self == level.allies[1]) {
    self.desired_anim_pose = "crouch";
    self allowedstances("crouch");
  } else {
    self.desired_anim_pose = "crouch";
    self allowedstances("crouch", "stand");
  }

  set_diff_accuracy();
  self.accuracystationarymod = 1;
}

crash_vehicle_on_death() {
  self endon("icehole_occured");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(self.health > 0 && var_4 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }
    if(isDefined(self) && isalive(self)) {
      var_5 = self.origin[2];

      if(!common_scripts\utility::flag("start_icehole_shooting"))
        maps\clockwork_code::play_crash_anim(self.origin);
      else {
        var_6 = randomintrange(1, 3);

        if(var_6 == 1 && !level.justplayed) {
          maps\clockwork_code::play_long_crash();
          level.justplayed = 1;
        } else {
          maps\clockwork_code::play_crash_anim(self.origin);
          level.justplayed = 0;
        }
      }
    }

    break;
  }
}

vehicle_death_check() {
  self waittill("death");
}

wipeout_bikes() {
  level.enemy_snowmobile = maps\_utility::array_removedead(level.enemy_snowmobile);

  if(level.enemy_snowmobile.size > 3) {
    for(var_0 = 0; var_0 < level.enemy_snowmobile.size - 3; var_0++)
      level.enemy_snowmobile[var_0] maps\_vehicle_spline_zodiac::wipeout("left behind!");
  }
}

vehicle_play_guy_anim(var_0, var_1, var_2, var_3) {
  var_4 = maps\_vehicle_aianim::anim_pos(self, var_2);
  var_5 = var_1 maps\_utility::getanim(var_0);
  var_1 notify("newanim");
  var_1 endon("newanim");
  var_1 endon("death");
  maps\_anim::anim_single_solo(var_1, var_0, var_4.sittag);

  if(!isDefined(var_3) || var_3 == 1)
    maps\_vehicle_aianim::guy_idle(var_1, var_2);
}

anim_enter_finished(var_0) {
  self waittillmatch("single anim", "end");
  level.playerjeep thread maps\_vehicle_aianim::guy_enter(self);
  common_scripts\utility::flag_set(var_0);
}

handle_dog_chaos() {
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);
  thread watch_dog_hot_dog();
  common_scripts\utility::flag_wait("door_close");
  var_0 = getent("elevator_to_exfil", "targetname");
  level.dog linkto(var_0);
  common_scripts\utility::flag_wait("door_open");
  thread handle_dog_targeting_chaos();
  wait 0.1;
  level.dog unlink();
  maps\clockwork_code::dog_walk();
  level.dog maps\ally_attack_dog::set_dog_follow_owner(level.player);
  common_scripts\utility::waitframe();
  level.dog maps\ally_attack_dog::dog_disable_ai_color();
  common_scripts\utility::flag_wait("chaos_ally_run");
  level.dog.dontavoidplayer = 0;
  var_1 = getent("dog_to_jeep", "targetname");
  var_1 waittill("trigger");
  level.dog maps\ally_attack_dog::dog_enable_ai_color();
  maps\clockwork_code::dog_run();
}

handle_dog_targeting_chaos() {
  level endon("exfil_fire_fail");
  level endon("start_exfil_ride");
  level.player waittill("dog_attack_command");
  maps\clockwork_code::dog_run();
  level.dog maps\_utility::set_ignoreall(0);
  level.dog maps\_utility::set_ignoreme(0);
  wait 2;
  common_scripts\utility::flag_set("exfil_fire_fail");
}

handle_dog_exfil() {
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);
  thread watch_dog_hot_dog();
  thread handle_dog_targeting_chaos();
  maps\clockwork_code::dog_run();
  common_scripts\utility::flag_wait("get_in_the_jeep");
  bold_dog_jeep();
}

watch_dog_hot_dog() {
  level endon("start_exfil_ride");
  common_scripts\utility::flag_wait("exfil_fire_fail");
  maps\clockwork_code::dog_run();
  level.dog maps\_utility::set_ignoreall(0);
  level.dog maps\_utility::set_ignoreme(0);
  level.dog maps\ally_attack_dog::set_dog_guard_owner(level.player);
}

bold_dog_jeep() {
  thread dog_scratch_exfil();
  common_scripts\utility::flag_wait("start_exfil_ride");
  var_0 = getnode("dog_exfil_jeep", "targetname");
  var_0 notify("stop_scritchin");
  wait 3;
  dog_in_exfil_jeep();
  level.dog thread maps\_utility::play_sound_on_entity("anml_dog_bark");
}

dog_scratch_exfil() {
  level endon("start_exfil_ride");
  common_scripts\utility::flag_wait("dog_exfil_jeep");
  level.dog thread maps\ally_attack_dog::lock_player_control(0);
  level.dog maps\_utility::set_ignoreall(1);
  level.dog maps\_utility::set_ignoreme(1);
  level.dog.ignorerandombulletdamage = 1;
  var_0 = getnode("dog_exfil_jeep", "targetname");
  level.dog.goalradius = 5;

  for(;;) {
    var_1 = level.dog common_scripts\utility::waittill_notify_or_timeout_return("goal", 10);

    if(!isDefined(var_1) || var_1 != "timeout") {
      break;
    }

    wait 1;
    level.dog setgoalnode(var_0);
  }

  wait 2.5;
  var_0 thread maps\_anim::anim_loop_solo(level.dog, "dog_scratch_door", "stop_scritchin");
}

dog_in_exfil_jeep() {
  if(!level.woof) {
    return;
  }
  level.dog.oldcontents = level.dog setcontents(0);
  maps\clockwork_code::link_dog_to_jeep(level.playerjeep);
  level.dog thread maps\ally_attack_dog::lock_player_control(0);
  level.dog hudoutlinedisable();
}

player_view_clamp() {
  level.player endon("death");
  level endon("player_jeep_crashing");
  common_scripts\utility::waitframe();

  while(!common_scripts\utility::flag("enemy_cave_spawn")) {
    var_0 = vectornormalize(self.mgturret[0] gettagorigin("tag_flash") - self.origin);
    var_1 = anglesToForward(self.angles);
    var_2 = vectordot(var_1, var_0);

    if(isalive(level.player)) {
      if(var_2 <= -0.5)
        level.player lerpviewangleclamp(0, 0, 0, 180, 180, 30, 25);
      else
        level.player lerpviewangleclamp(0, 0, 0, 180, 180, 30, 5);
    }

    common_scripts\utility::waitframe();
  }
}

set_diff_accuracy() {
  if(isalive(self)) {
    if(maps\_utility::getdifficulty() == "fu")
      self.baseaccuracy = 0.4;
    else if(maps\_utility::getdifficulty() == "hard")
      self.baseaccuracy = 0.35;
    else
      self.baseaccuracy = 0.3;
  }
}