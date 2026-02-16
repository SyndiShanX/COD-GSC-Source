/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cosmodrome\.csc
***********************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

main() {
  level thread clientscripts\zombie_cosmodrome_ffotd::main_start();
  level._uses_crossbow = true;
  level._power_on = false;
  level.rocket_num = 0;
  level._visionset_map_nopower = "zombie_cosmodrome_nopower";
  level._visionset_priority_map_nopower = 1;
  level._visionset_map_sudden_power = "zombie_cosmodrome_powerUP";
  level._visionset_priority_map_sudden_power = 2;
  level._visionset_map_poweron = "zombie_cosmodrome_powerON";
  level._visionset_priority_map_poweron = 3;
  level._visionset_map_monkey = "zombie_cosmodrome_monkey";
  level._visionset_priority_map_monkey = 4;
  level._visionset_map_begin = "zombie_cosmodrome_begin";
  level._visionset_priority_map_begin = 5;
  level._visionset_map_monkeylandon = "flare";
  level._visionset_priority_map_monkeylandon = 6;
  level._visionset_monkey_transition_time_on = 0.5;
  level._visionset_monkey_transition_time_off = 3.0;
  level._visionset_zombie_sudden_power_transition_time = 0.1;
  level._visionset_zombie_transition_time = 2.5;
  level._fog_settings_monkey = "monkey";
  level._fog_settings_monkey_priority = 3;
  level._fog_settings_lander = "lander";
  level._fog_settings_lander_priority = 2;
  level._fog_settings_default = "normal";
  level._fog_settings_default_priority = 1;
  include_weapons();
  PreCacheRumble("damage_heavy");
  PrecacheRumble("explosion_generic");
  clientscripts\_zombiemode::main();
  register_clientflag_callback("actor", 0, ::actor_flag_soulpull_handler);
  register_clientflag_callback("scriptmover", 0, ::rocket_fx);
  register_clientflag_callback("scriptmover", 1, ::lander_engine_fx);
  register_clientflag_callback("scriptmover", 2, ::lander_status_light);
  register_clientflag_callback("scriptmover", 3, ::launch_panel_centrifuge_status);
  register_clientflag_callback("scriptmover", 4, ::launch_panel_baseentry_status);
  register_clientflag_callback("scriptmover", 5, ::launch_panel_storage_status);
  register_clientflag_callback("scriptmover", 6, ::launch_panel_catwalk_status);
  register_clientflag_callback("scriptmover", 7, ::lander_rumble_and_quake);
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_RUMBLE = 8;
  register_clientflag_callback("scriptmover", level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_RUMBLE, ::centrifuge_rumble_control);
  register_clientflag_callback("scriptmover", 9, ::lander_move_fx);
  register_clientflag_callback("player", 0, ::player_lander_fog);
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS = 11;
  register_clientflag_callback("scriptmover", level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_CENTRIFUGE_LIGHTS, ::centrifuge_warning_lights_init);
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_MONKEY_LANDER_FX = 12;
  register_clientflag_callback("scriptmover", level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_MONKEY_LANDER_FX, ::monkey_lander_fx);
  level thread catwalk_lander_doors();
  level thread base_entry_lander_doors();
  level thread storage_lander_doors();
  level thread centrifuge_lander_doors();
  level thread lander_station_think();
  level thread setup_fog();
  level thread init_rocket_debris();
  clientscripts\_zombiemode_weap_black_hole_bomb::init();
  clientscripts\zombie_cosmodrome_fx::main();
  thread clientscripts\zombie_cosmodrome_amb::main();
  clientscripts\_zombiemode_deathcard::init();
  level init_cosmodrome_box_screens();
  OnPlayerConnect_Callback(::cosmo_on_player_connect);
  OnPlayerSpawned_Callback(::cosmo_on_player_spawned);
  waitforclient(0);
  level thread cosmodrome_ZPO_listener();
  level thread cosmodrome_monkey_round_start_listener();
  register_zombie_types();
  level thread radar_dish_init();
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    level thread nml_fx_monitor(i);
  }
  level.nml_spark_pull = GetStruct("nml_spark_pull", "targetname");
  level thread monkey_start_monitor();
  level thread monkey_stop_monitor();
  level thread monkey_land_on();
  level thread monkey_land_off();
  level thread cosmodrome_power_vision_set_swap();
  level thread clientscripts\zombie_cosmodrome_ffotd::main_end();
}
cosmodrome_monkey_round_start_listener() {
  while(1) {
    level waittill("MRS");
    players = getlocalplayers();
    for(i = 0; i < players.size; i++) {
      players[i] Earthquake(0.2, 5.0, players[i].origin, 20000);
    }
    playSound(0, "zmb_ape_intro_sonicboom_fnt", (0, 0, 0));
  }
}
cosmodrome_ZPO_listener() {
  while(1) {
    level waittill("ZPO");
    level._power_on = true;
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      level thread setup_lander_screens(i);
    }
  }
}
register_zombie_types() {
  character\clientscripts\c_zom_cosmo_scientist::register_gibs();
  character\clientscripts\c_zom_cosmo_spetznaz::register_gibs();
  character\clientscripts\c_zom_cosmo_cosmonaut::register_gibs();
}
#include_weapons() {
  include_weapon("frag_grenade_zm", false);
  include_weapon("claymore_zm", false);
  include_weapon("m1911_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_zm");
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_zm");
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("m14_zm", false);
  include_weapon("m14_upgraded_zm", false);
  include_weapon("m16_zm", false);
  include_weapon("m16_gl_upgraded_zm", false);
  include_weapon("g11_lps_zm");
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_zm");
  include_weapon("famas_upgraded_zm", false);
  include_weapon("ak74u_zm", false);
  include_weapon("ak74u_upgraded_zm", false);
  include_weapon("mp5k_zm", false);
  include_weapon("mp5k_upgraded_zm", false);
  include_weapon("mp40_zm", false);
  include_weapon("mp40_upgraded_zm", false);
  include_weapon("mpl_zm", false);
  include_weapon("mpl_upgraded_zm", false);
  include_weapon("pm63_zm", false);
  include_weapon("pm63_upgraded_zm", false);
  include_weapon("spectre_zm");
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("cz75dw_zm");
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("ithaca_zm", false);
  include_weapon("ithaca_upgraded_zm", false);
  include_weapon("rottweil72_zm", false);
  include_weapon("rottweil72_upgraded_zm", false);
  include_weapon("spas_zm");
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_zm");
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_zm");
  include_weapon("aug_acog_mk_upgraded_zm", false);
  include_weapon("galil_zm");
  include_weapon("galil_upgraded_zm", false);
  include_weapon("commando_zm");
  include_weapon("commando_upgraded_zm", false);
  include_weapon("fnfal_zm");
  include_weapon("fnfal_upgraded_zm", false);
  include_weapon("dragunov_zm");
  include_weapon("dragunov_upgraded_zm", false);
  include_weapon("l96a1_zm");
  include_weapon("l96a1_upgraded_zm", false);
  include_weapon("rpk_zm");
  include_weapon("rpk_upgraded_zm", false);
  include_weapon("hk21_zm");
  include_weapon("hk21_upgraded_zm", false);
  include_weapon("m72_law_zm");
  include_weapon("m72_law_upgraded_zm", false);
  include_weapon("china_lake_zm");
  include_weapon("china_lake_upgraded_zm", false);
  include_weapon("zombie_black_hole_bomb");
  include_weapon("zombie_nesting_dolls");
  include_weapon("ray_gun_zm");
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("thundergun_zm");
  include_weapon("thundergun_upgraded_zm", false);
  include_weapon("crossbow_explosive_zm");
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("knife_ballistic_zm", true);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_bowie_zm", false);
  include_weapon("knife_ballistic_bowie_upgraded_zm", false);
}
vista_rockets() {
  all_rockets = getEntArray(0, "vista_rocket", "targetname");
  rockets = array_randomize(all_rockets);
  for(i = 0; i < rockets.size; i++) {
    level thread rocket_launch(rockets[i]);
    wait(randomintrange(60, 300));
  }
}
rocket_launch(rocket) {
  wait(.1);
  rocket moveto(rocket.origin + (0, 0, 50000), 50, 45);
  rocket waittill("movedone");
  rocket delete();
}
closest_point_on_line_to_point(Point, LineStart, LineEnd) {
  LineMagSqrd = lengthsquared(LineEnd - LineStart);
  t = (((Point[0] - LineStart[0]) * (LineEnd[0] - LineStart[0])) + ((Point[1] - LineStart[1]) * (LineEnd[1] - LineStart[1])) + ((Point[2] - LineStart[2]) * (LineEnd[2] - LineStart[2]))) /
    (LineMagSqrd);
  if(t < 0.0) {
    return LineStart;
  } else if(t > 1.0) {
    return LineEnd;
  } else {
    start_x = LineStart[0] + t * (LineEnd[0] - LineStart[0]);
    start_y = LineStart[1] + t * (LineEnd[1] - LineStart[1]);
    start_z = LineStart[2] + t * (LineEnd[2] - LineStart[2]);
    return (start_x, start_y, start_z);
  }
}
plane_position_updater(fake_ent, plane) {
  apex = 5000;
  soundid = -1;
  dx = undefined;
  last_time = undefined;
  last_pos = undefined;
  start_time = 0;
  while(isDefined(plane)) {
    setfakeentorg(0, fake_ent, plane.origin);
    if((soundid < 0) && isDefined(last_pos)) {
      dx = plane.origin - last_pos;
      if(length(dx) > .01) {
        velocity = dx / (getrealtime() - last_time);
        assert(isDefined(velocity));
        players = getlocalplayers();
        assert(isDefined(players));
        other_point = plane.origin + (velocity * 100000);
        player_origin = players[0] GetOrigin();
        if(!isDefined(player_origin)) {
          continue;
        }
        point = closest_point_on_line_to_point(player_origin, plane.origin, other_point);
        assert(isDefined(point));
        dist = Distance(point, plane.origin);
        assert(isDefined(dist));
        time = dist / length(velocity);
        assert(isDefined(time));
        if(time < apex) {
          soundid = playLoopSound(0, fake_ent, "veh_mig_flyby", 0);
          playSound(0, "veh_mig_flyby_lfe", (0, 0, 0));
          start_time = getRealTime();
        }
      }
    }
    last_pos = plane.origin;
    last_time = GetRealTime();
    if(start_time != 0) {}
    wait(0.1);
  }
  deletefakeent(0, fake_ent);
}
migs_fly_by() {
  points = getStructArray("spawn_flyby", "targetname");
  while(1) {
    point = random(points);
    planes = [];
    fake_ent_planes = [];
    planes[0] = spawn(0, point.origin, "script_origin");
    planes[0] setModel("t5_veh_jet_mig17");
    planes[0].angles = point.angles;
    fake_ent_planes[0] = spawnfakeent(0);
    wait(.1);
    if(randomint(100) > 50) {
      planes[1] = spawn(0, point.origin + (-1100, 0, 0), "script_origin");
      planes[1].angles = point.angles;
      planes[1] setModel("t5_veh_jet_mig17");
      fake_ent_planes[1] = spawnfakeent(0);
      wait(.1);
      if(randomint(100) > 50) {
        planes[2] = spawn(0, point.origin + (1100, 0, 0), "script_origin");
        planes[2].angles = point.angles;
        planes[2] setModel("t5_veh_jet_mig17");
        fake_ent_planes[2] = spawnfakeent(0);
        wait(.1);
      }
    }
    for(i = 0; i < planes.size; i++) {
      playFXOnTag(0, level._effect["mig_trail"], planes[i], "tag_engine");
      planes[i] rotateto(point.angles, .05);
      forward = anglesToForward(point.angles);
      moveto_spot = vector_scale_2d(forward, 50000);
      planes[i] moveto(moveto_spot, 20);
      if(planes.size > 2 && i == 0) {
        wait(.35);
      }
    }
    playSound(0, "veh_mig_flyby_2d", (0, 0, 0));
    for(i = 0; i < fake_ent_planes.size; i++) {
      thread plane_position_updater(fake_ent_planes[i], planes[i]);
    }
    planes[0] waittill("movedone");
    for(i = 0; i < planes.size; i++) {
      planes[i] delete();
    }
    wait(randomintrange(60, 180));
  }
}
vector_scale_2d(vec, scale) {
  vec = (vec[0] * scale, vec[1] * scale, vec[2]);
  return vec;
}
radar_dish_init() {
  radar_dish = getEntArray(0, "zombie_cosmodrome_radar_dish", "targetname");
  if(isDefined(radar_dish)) {
    for(i = 0; i < radar_dish.size; i++) {
      radar_dish[i] thread radar_dish_rotate();
    }
  }
}
radar_dish_rotate() {
  wait(0.1);
  while(true) {
    self rotateyaw(360, 10);
    self waittill("rotatedone");
  }
}
nml_electric_barriers(client_num) {
  level endon("nm0");
  while(1) {
    buildup_spots = getStructArray("nml_build_sparks", "targetname");
    for(i = 0; i < buildup_spots.size; i++) {
      level waittill("eb+");
      angles = (0, 0, 0);
      if(isDefined(buildup_spots[i].angles)) {
        angles = buildup_spots[i].angles;
      }
      buildup_spots[i].fx = SpawnFx(client_num, level._effect["zombie_power_switch"], buildup_spots[i].origin, 0, anglesToForward(angles), AnglesToUp(angles));
      triggerfx(buildup_spots[i].fx);
    }
    level waittill("eb1");
    for(i = 0; i < buildup_spots.size; i++) {
      if(isDefined(buildup_spots[i].target)) {
        buildup_spots[i] thread perk_wire_fx_client(client_num, "wire_fx_done");
      }
    }
    wait(0.5);
    for(i = 0; i < buildup_spots.size; i++) {
      if(isDefined(buildup_spots[i].target)) {
        buildup_spots[i] thread perk_wire_fx_client(client_num, "wire_fx_done");
      }
    }
    wait(0.5);
    for(i = 0; i < buildup_spots.size; i++) {
      if(isDefined(buildup_spots[i].fx)) {
        buildup_spots[i].fx Delete();
        if(isDefined(buildup_spots[i].target)) {
          buildup_spots[i] thread perk_wire_fx_client(client_num, "wire_fx_done");
        }
      }
    }
    trap_spots = getStructArray("nml_trap_sparks", "targetname");
    for(i = 0; i < trap_spots.size; i++) {
      angles = (0, 0, 0);
      if(isDefined(trap_spots[i].angles)) {
        angles = trap_spots[i].angles;
      }
      trap_spots[i].fx = SpawnFx(client_num, level._effect["elec_terminal"], trap_spots[i].origin, 0, anglesToForward(angles), AnglesToUp(angles));
      triggerfx(trap_spots[i].fx);
    }
    level waittill("eb0");
    for(i = 0; i < trap_spots.size; i++) {
      if(isDefined(trap_spots[i].fx)) {
        trap_spots[i].fx Delete();
      }
    }
  }
}
nml_fx_monitor(client_num) {
  while(1) {
    level thread nml_electric_barriers(client_num);
    level waittill("nm0");
    buildup_spots = getStructArray("nml_build_sparks", "targetname");
    for(i = 0; i < buildup_spots.size; i++) {
      if(isDefined(buildup_spots[i].fx)) {
        buildup_spots[i].fx Delete();
      }
    }
    trap_spots = getStructArray("nml_trap_sparks", "targetname");
    for(i = 0; i < trap_spots.size; i++) {
      if(isDefined(trap_spots[i].fx)) {
        trap_spots[i].fx Delete();
      }
    }
  }
}
perk_wire_fx_client(client_num, done_notify) {
  println("perk_wire_fx_client for client #" + client_num);
  targ = GetStruct(self.target, "targetname");
  if(!isDefined(targ)) {
    return;
  }
  mover = spawn(client_num, targ.origin, "script_model");
  mover setModel("tag_origin");
  fx = playFXOnTag(client_num, level._effect["wire_spark"], mover, "tag_origin");
  while(isDefined(targ)) {
    if(isDefined(targ.target)) {
      println("perk_wire_fx_client#" + client_num + " next target: " + targ.target);
      target = getstruct(targ.target, "targetname");
      mover MoveTo(target.origin, 0.5);
      wait(0.5);
      targ = target;
    } else {
      break;
    }
  }
  level notify("spark_done");
  mover Delete();
  level notify(done_notify);
}
tele_spark_audio_mover(fake_ent) {
  level endon("spark_done");
  while(1) {
    realwait(0.05);
    setfakeentorg(0, fake_ent, self.origin);
  }
}
actor_flag_soulpull_handler(client_num, set, newEnt) {
  if(set) {
    self thread soul_pull(client_num);
  }
}
soul_pull(client_num) {
  println("*** ACTOR soul_pull .pos=" + self.origin + " ;to " + level.nml_spark_pull.origin);
  mover = spawn(client_num, self.origin, "script_model");
  mover setModel("tag_origin");
  fx = playFXOnTag(client_num, level._effect["soul_spark"], mover, "tag_origin");
  wait(1.0);
  mover MoveTo(level.nml_spark_pull.origin, 3.0);
  wait(3.0);
  mover Delete();
}
init_cosmodrome_box_screens() {
  level._cosmodrome_fire_sale = array("p_zom_monitor_csm_screen_fsale1", "p_zom_monitor_csm_screen_fsale2");
  level.magic_box_tv_off = array("p_zom_monitor_csm_screen_off");
  level.magic_box_tv_on = array("p_zom_monitor_csm_screen_on");
  level.magic_box_tv_start_1 = array("p_zom_monitor_csm_screen_obsdeck");
  level.magic_box_tv_roof_connector = array("p_zom_monitor_csm_screen_labs");
  level.magic_box_tv_centrifuge = array("p_zom_monitor_csm_screen_centrifuge");
  level.magic_box_tv_base_entry = array("p_zom_monitor_csm_screen_enter");
  level.magic_box_tv_storage = array("p_zom_monitor_csm_screen_storage");
  level.magic_box_tv_catwalks = array("p_zom_monitor_csm_screen_catwalk");
  level.magic_box_tv_north_pass = array("p_zom_monitor_csm_screen_topack");
  level.magic_box_tv_warehouse = array("p_zom_monitor_csm_screen_warehouse");
  level.magic_box_tv_random = array("p_zom_monitor_csm_screen_logo");
  level._box_locations = array(level.magic_box_tv_start_1, level.magic_box_tv_roof_connector, level.magic_box_tv_centrifuge, level.magic_box_tv_base_entry, level.magic_box_tv_storage, level.magic_box_tv_catwalks, level.magic_box_tv_north_pass, level.magic_box_tv_warehouse);
  level._custom_box_monitor = ::cosmodrome_screen_switch;
}
cosmodrome_screen_switch(client_num, state, oldState) {
  cosmodrome_tv_init(client_num);
  if(state == "n") {
    if(level._power_on == false) {
      screen_to_display = level.magic_box_tv_off;
    } else {
      screen_to_display = level.magic_box_tv_on;
    }
  } else if(state == "f") {
    screen_to_display = level._cosmodrome_fire_sale;
  } else {
    array_number = Int(state);
    screen_to_display = level._box_locations[array_number];
  }
  stop_notify = "stop_tv_swap";
  for(i = 0; i < level.cosmodrome_tvs[client_num].size; i++) {
    tele = level.cosmodrome_tvs[client_num][i];
    tele notify(stop_notify);
    wait(0.2);
    tele thread magic_box_screen_swap(screen_to_display, "stop_tv_swap");
    tele thread play_magic_box_tv_audio(state);
  }
}
cosmodrome_tv_init(client_num) {
  if(!isDefined(level.cosmodrome_tvs)) {
    level.cosmodrome_tvs = [];
  }
  if(isDefined(level.cosmodrome_tvs[client_num])) {
    return;
  }
  level.cosmodrome_tvs[client_num] = getEntArray(client_num, "model_cosmodrome_box_screens", "targetname");
  for(i = 0; i < level.cosmodrome_tvs[client_num].size; i++) {
    tele = level.cosmodrome_tvs[client_num][i];
    tele setModel(level.magic_box_tv_off[0]);
    wait(0.1);
  }
}
magic_box_screen_swap(model_array, endon_notify) {
  self endon(endon_notify);
  while(true) {
    for(i = 0; i < model_array.size; i++) {
      self setModel(model_array[i]);
      wait(3.0);
    }
    if(3 > RandomInt(100) && isDefined(level.magic_box_tv_random)) {
      self setModel(level.magic_box_tv_random[RandomInt(level.magic_box_tv_random.size)]);
      wait(2.0);
    }
    wait(1.0);
  }
}
play_magic_box_tv_audio(state) {
  alias = "amb_tv_static";
  if(state == "n") {
    if(level._power_on == false) {
      alias = undefined;
    } else {
      alias = "amb_tv_static";
    }
  } else if(state == "f") {
    alias = "mus_fire_sale";
  } else {
    alias = "amb_tv_static";
  }
  if(!isDefined(alias)) {
    self stoploopsound(.5);
  } else {
    self playLoopSound(alias, .5);
  }
}
monkey_start_monitor() {
  while(1) {
    level waittill("monkey_start");
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_monkey, level._visionset_priority_map_monkey);
      players[i] fog_apply("monkey", level._fog_settings_monkey_priority);
    }
    level._effect["eye_glow"] = level._effect["monkey_eye_glow"];
  }
}
monkey_stop_monitor() {
  while(1) {
    level waittill("monkey_stop");
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] clientscripts\_zombiemode::zombie_vision_set_remove(level._visionset_map_monkey);
      players[i] fog_remove("monkey");
    }
    level._effect["eye_glow"] = level._effect["zombie_eye_glow"];
  }
}
monkey_land_on() {
  while(1) {
    level waittill("MLO");
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_monkeylandon, level._visionset_priority_map_monkeylandon, level._visionset_monkey_transition_time_on);
    }
    wait(0.05);
  }
}
monkey_land_off() {
  while(1) {
    level waittill("MLF");
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] clientscripts\_zombiemode::zombie_vision_set_remove(level._visionset_map_monkeylandon, level._visionset_monkey_transition_time_off);
    }
    wait(0.05);
  }
}
cosmo_on_player_connect(int_local_client_num) {
  self endon("disconnect");
  while(!ClientHasSnapshot(int_local_client_num)) {
    wait(0.05);
  }
  if(int_local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread cosmodrome_first_vision_set(i);
  }
}
cosmo_on_player_spawned(int_local_client_num) {
  self endon("disconnect");
  while(!self hasdobj(int_local_client_num)) {
    wait(0.05);
  }
  if(int_local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] cosmodrome_vision_set(i);
    players[i] fog_apply("normal", level._fog_settings_default_priority);
  }
}
cosmodrome_first_vision_set(int_client_num) {
  self endon("disconnect");
  self clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_begin, level._visionset_priority_map_begin, 0.1, int_client_num);
  self clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_nopower, level._visionset_priority_map_nopower, 0.1, int_client_num);
  level waittill("ZID");
  self clientscripts\_zombiemode::zombie_vision_set_remove(level._visionset_map_begin, 8.5, int_client_num);
}
cosmodrome_vision_set(int_client_num) {
  self endon("disconnect");
  if(level._power_on == true) {
    self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_poweron, level._visionset_priority_map_poweron, level._visionset_zombie_transition_time, int_client_num);
  } else {
    self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_nopower, level._visionset_priority_map_nopower, 0, int_client_num);
  }
}
cosmodrome_power_vision_set_swap() {
  level waittill("ZPO");
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_sudden_power, level._visionset_priority_map_sudden_power, level._visionset_zombie_sudden_power_transition_time, i);
  }
  wait(1.0);
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] clientscripts\_zombiemode::zombie_vision_set_apply(level._visionset_map_poweron, level._visionset_priority_map_poweron, level._visionset_zombie_transition_time, i);
  }
}
catwalk_lander_doors() {
  level thread catwalk_lander_doors_only();
  while(1) {
    level waittill("CW_O");
    level thread open_lander_bay_doors("catwalk_zip_door");
    level waittill("CW_C");
    level thread close_lander_bay_doors("catwalk_zip_door");
  }
}
catwalk_lander_doors_only() {
  while(1) {
    level waittill("CWD");
    level thread open_lander_bay_doors_only("catwalk_zip_door");
  }
}
base_entry_lander_doors() {
  level thread base_entry_lander_doors_only();
  while(1) {
    level waittill("BE_O");
    level thread open_lander_bay_doors("base_entry_zip_door");
    level waittill("BE_C");
    level thread close_lander_bay_doors("base_entry_zip_door");
  }
}
base_entry_lander_doors_only() {
  while(1) {
    level waittill("BED");
    level thread open_lander_bay_doors_only("base_entry_zip_door");
  }
}
storage_lander_doors() {
  level thread storage_lander_doors_only();
  while(1) {
    level waittill("S_O");
    level thread open_lander_bay_doors("storage_zip_door");
    level waittill("S_C");
    level thread close_lander_bay_doors("storage_zip_door");
  }
}
storage_lander_doors_only() {
  while(1) {
    level waittill("SOD");
    level thread open_lander_bay_doors_only("storage_zip_door");
  }
}
centrifuge_lander_doors() {
  level thread centrifuge_lander_doors_only();
  while(1) {
    level waittill("CF_O");
    level thread open_lander_bay_doors("centrifuge_zip_door");
    level waittill("CF_C");
    level thread close_lander_bay_doors("centrifuge_zip_door");
  }
}
centrifuge_lander_doors_only() {
  while(1) {
    level waittill("CFD");
    level thread open_lander_bay_doors_only("centrifuge_zip_door");
  }
}
open_lander_bay_doors(door_name) {
  println("***** -- Opening door");
  players = GetLocalPlayers();
  sound_count = 0;
  for(x = 0; x < players.size; x++) {
    doors = getEntArray(x, door_name, "targetname");
    for(i = 0; i < doors.size; i++) {
      open_pos = getstruct(doors[i].target, "targetname");
      start_pos = getstruct(open_pos.target, "targetname");
      if(!isDefined(doors[i].script_noteworthy)) {
        doors[i] moveto(start_pos.origin, 1.0);
        if(sound_count == 0) {
          playSound(0, "zmb_lander_door", doors[i].origin);
          sound_count++;
        }
      }
    }
  }
  level waittill("LL");
  println("raising_shaft_cap");
  players = GetLocalPlayers();
  sound_count = 0;
  for(x = 0; x < players.size; x++) {
    doors = getEntArray(x, door_name, "targetname");
    for(i = 0; i < doors.size; i++) {
      open_pos = getstruct(doors[i].target, "targetname");
      start_pos = getstruct(open_pos.target, "targetname");
      if(isDefined(doors[i].script_noteworthy)) {
        doors[i] moveto(open_pos.origin, 1.0);
        if(sound_count == 0) {
          playSound(0, "zmb_lander_door", doors[i].origin);
          sound_count++;
        }
      }
    }
  }
}
open_lander_bay_doors_only(door_name) {
  players = GetLocalPlayers();
  sound_count = 0;
  for(x = 0; x < players.size; x++) {
    doors = getEntArray(x, door_name, "targetname");
    for(i = 0; i < doors.size; i++) {
      open_pos = getstruct(doors[i].target, "targetname");
      if(!isDefined(doors[i].script_noteworthy)) {
        doors[i] moveto(open_pos.origin, 1.0);
        if(sound_count == 0) {
          playSound(0, "zmb_lander_door", doors[i].origin);
          sound_count++;
        }
      }
    }
  }
}
close_lander_bay_doors(door_name) {
  println("***** -- closing door");
  players = GetLocalPlayers();
  sound_count = 0;
  for(x = 0; x < players.size; x++) {
    doors = getEntArray(x, door_name, "targetname");
    for(i = 0; i < doors.size; i++) {
      open_pos = getstruct(doors[i].target, "targetname");
      start_pos = getstruct(open_pos.target, "targetname");
      if(isDefined(doors[i].script_noteworthy)) {
        doors[i] moveto(start_pos.origin, 1.0);
        if(sound_count == 0) {
          playSound(0, "zmb_lander_door", doors[i].origin);
          sound_count++;
        }
      }
    }
  }
  level waittill("LG");
  players = GetLocalPlayers();
  sound_count = 0;
  for(x = 0; x < players.size; x++) {
    doors = getEntArray(x, door_name, "targetname");
    for(i = 0; i < doors.size; i++) {
      open_pos = getstruct(doors[i].target, "targetname");
      start_pos = getstruct(open_pos.target, "targetname");
      if(!isDefined(doors[i].script_noteworthy)) {
        doors[i] moveto(start_pos.origin, 1.0);
        if(sound_count == 0) {
          playSound(0, "zmb_lander_door", doors[i].origin);
          sound_count++;
        }
      }
    }
  }
}
rocket_fx(localClientNum, set, newEnt) {
  if(!set) {
    return;
  }
  playFXOnTag(localClientNum, level._effect["rocket_blast_trail"], self, "tag_engine");
}
lander_engine_fx(localClientNum, set, newEnt) {
  player = getlocalplayers()[localClientNum];
  if(set) {
    if(isDefined(player.lander_fx)) {
      StopFX(localClientNum, player.lander_fx);
      StopFX(localClientNum, player.lander_fx1);
      StopFX(localClientNum, player.lander_fx2);
      StopFX(localClientNum, player.lander_fx3);
      StopFX(localClientNum, player.lander_fx4);
    }
    player.lander_fx = playFXOnTag(localClientNum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine01");
    player.lander_fx1 = playFXOnTag(localClientNum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine02");
    player.lander_fx2 = playFXOnTag(localClientNum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine03");
    player.lander_fx3 = playFXOnTag(localClientNum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine04");
    player.lander_fx4 = playFXOnTag(localClientNum, level._effect["lunar_lander_thruster_bellow"], self, "tag_bellow");
    self thread start_ground_sounds();
  } else {
    if(isDefined(player.lander_fx)) {
      StopFX(localClientNum, player.lander_fx);
      StopFX(localClientNum, player.lander_fx1);
      StopFX(localClientNum, player.lander_fx2);
      StopFX(localClientNum, player.lander_fx3);
      StopFX(localClientNum, player.lander_fx4);
    }
  }
}
start_ground_sounds() {
  self endon("entityshutdown");
  level endon("save_restore");
  self notify("start_ground_sounds");
  self.stop_ground_sounds = false;
  trace = undefined;
  self.ground_sound_ent = spawn(0, (0, 0, 0), "script_origin");
  pre_origin = (100000, 100000, 100000);
  while(isDefined(self)) {
    wait(.15);
    if(isDefined(self.stop_ground_sounds) && self.stop_ground_sounds) {
      if(isDefined(self.ground_sound_ent)) {
        self.ground_sound_ent StopLoopSound(2);
      }
      return;
    }
    if(DistanceSquared(pre_origin, self gettagorigin("tag_bellow")) < 144) {
      continue;
    }
    pre_origin = self gettagorigin("tag_bellow");
    trace = bulletTrace(self gettagorigin("tag_bellow"), self gettagorigin("tag_bellow") - (0, 0, 100000), false, undefined);
    if(!isDefined(trace)) {
      continue;
    }
    if(!isDefined(trace["position"])) {
      self.ground_sound_ent StopLoopSound(2);
      continue;
    }
    self.ground_sound_ent.origin = trace["position"] + (0, 0, 30);
    self.ground_sound_ent playLoopSound("zmb_lander_ground_sounds", 3);
  }
}
end_ground_sounds() {
  self endon("start_ground_sounds");
  self.stop_ground_sounds = true;
  wait(3);
  self.ground_sound_ent Delete();
}
lander_status_light(localClientNum, set, newEnt) {
  if(isDefined(self.status_light)) {
    StopFX(localclientNum, self.status_light);
  }
  if(set) {
    self.status_light = playFXOnTag(localClientNum, level._effect["lander_red"], self, "tag_origin");
  } else {
    self.status_light = playFXOnTag(localClientNum, level._effect["lander_green"], self, "tag_origin");
  }
}
init_rocket_debris() {
  players = GetLocalPlayers();
  for(x = 0; x < players.size; x++) {
    rocket_debris = getEntArray(x, "rocket_explode_debris", "targetname");
    for(i = 0; i < rocket_debris.size; i++) {
      rocket_debris[i] hide();
    }
  }
  level waittill("RX");
  players = GetLocalPlayers();
  for(x = 0; x < players.size; x++) {
    players[x] thread rain_debris(x);
  }
}
get_random_spot_in_player_view(fwd_min, fwd_max, side_min, side_max) {
  fwd = anglesToForward(self.angles);
  fwd = vector_scale(fwd, RandomIntRange(fwd_min, fwd_max));
  if(randomint(100) > 50) {
    side = AnglesToRight(self.angles);
  } else {
    side = AnglesToRight(self.angles) * -1;
  }
  side = vector_scale(side, RandomIntRange(side_min, side_max));
  point = self.origin + fwd + side;
  trace = bulletTrace(point, point + (0, 0, -10000), false, undefined);
  return trace["position"];
}
rain_debris(clientnum) {
  rocket_debris = getEntArray(clientnum, "rocket_explode_debris", "targetname");
  for(i = 0; i < 10; i++) {
    spot = self get_random_spot_in_player_view(1000, 3500, 50, 1000);
    debris = spawn(clientnum, spot + (0, 0, 10000), "script_model");
    debris.angles = (randomint(360), randomint(360), randomint(360));;
    debris setModel(random(rocket_debris).model);
    debris thread debris_crash_and_burn(spot, clientnum, self);
    wait(randomfloatrange(.5, 1.5));
  }
}
debris_crash_and_burn(spot, client, player) {
  playFXOnTag(client, level._effect["debris_trail"], self, "tag_origin");
  self moveto(spot, 3.1);
  for(i = 0; i < 10; i++) {
    self rotateto((randomint(360), randomint(360), randomint(360)), .3);
    wait(.3);
  }
  wait(3.1);
  player earthquake(0.4, 0.5, self.origin, 1200);
  playFX(client, level._effect["debris_hit"], self.origin);
  wait(1);
  self delete();
}
setup_lander_screens(clientnum) {
  screens = getEntArray(clientnum, "lander_screens", "targetname");
  for(i = 0; i < screens.size; i++) {
    if(isDefined(screens[i].model)) {
      screens[i] setModel("p_zom_cosmo_lunar_control_panel_dlc_on");
    }
  }
}
lander_at_station(station, clientnum) {
  if(isDefined(self.panel_fx)) {
    StopFX(clientnum, self.panel_fx);
  }
  if(isDefined(self.lander_fx)) {
    StopFX(clientnum, self.lander_fx);
  }
  switch (station) {
    case "baseentry":
      self.panel_fx = playFXOnTag(clientnum, level._effect["panel_green"], self, "tag_location_3");
      self.lander_location = self gettagorigin("tag_location_3");
      self.lander_location_angles = self gettagangles("tag_location_3");
      break;
    case "storage":
      self.panel_fx = playFXOnTag(clientnum, level._effect["panel_green"], self, "tag_location_1");
      self.lander_location = self gettagorigin("tag_location_1");
      self.lander_location_angles = self gettagangles("tag_location_1");
      break;
    case "catwalk":
      self.panel_fx = playFXOnTag(clientnum, level._effect["panel_green"], self, "tag_location_2");
      self.lander_location = self gettagorigin("tag_location_2");
      self.lander_location_angles = self gettagangles("tag_location_2");
      break;
    case "centrifuge":
      self.panel_fx = playFXOnTag(clientnum, level._effect["panel_green"], self, "tag_home");
      self.lander_location = self gettagorigin("tag_home");
      self.lander_location_angles = self gettagangles("tag_home");
      break;
  }
}
lander_move_fx(localClientNum, set, newEnt) {
  player = getlocalplayers()[localClientNum];
  if(set) {
    player thread lander_station_move_lander_marker(localClientNum);
  } else {}
}
lander_station_move_lander_marker(localClientNum) {
  dest = undefined;
  x = localClientNum;
  screens = getEntArray(x, "lander_screens", "targetname");
  for(i = 0; i < screens.size; i++) {
    screen = screens[i];
    if(isDefined(screen.lander_fx)) {
      StopFX(x, screen.lander_fx);
    }
    if(isDefined(screen.panel_fx)) {
      StopFX(x, screen.panel_fx);
    }
    if(!isDefined(screen.lander_fx_ent)) {
      screen.lander_fx_ent = spawn(x, screen.lander_location, "script_origin");
      screen.lander_fx_ent setModel("tag_origin");
      screen.lander_fx_ent.angles = screen.lander_location_angles;
    }
    screen.lander_fx = playFXOnTag(x, level._effect["panel_green"], screen.lander_fx_ent, "tag_origin");
    switch (level.lander_dest_station) {
      case "base":
        dest = screen gettagorigin("tag_location_3");
        break;
      case "storage":
        dest = screen gettagorigin("tag_location_1");
        break;
      case "centrifuge":
        dest = screen gettagorigin("tag_home");
        break;
      case "catwalk":
        dest = screen gettagorigin("tag_location_2");
        break;
    }
    screen.lander_fx_ent moveto(dest, 10);
  }
}
lander_station_think() {
  level thread lander_station_centrifuge_mon();
  level thread lander_station_baseentry_mon();
  level thread lander_station_storage_mon();
  level thread lander_station_catwalk_mon();
  level thread lander_station_centrifuge();
  level thread lander_station_baseentry();
  level thread lander_station_storage();
  level thread lander_station_catwalk();
}
lander_station_centrifuge_mon() {
  while(1) {
    level waittill("LLCF");
    level.lander_dest_station = "centrifuge";
  }
}
lander_station_baseentry_mon() {
  while(1) {
    level waittill("LLBE");
    level.lander_dest_station = "base";
  }
}
lander_station_storage_mon() {
  while(1) {
    level waittill("LLSS");
    level.lander_dest_station = "storage";
  }
}
lander_station_catwalk_mon() {
  while(1) {
    level waittill("LLCW");
    level.lander_dest_station = "catwalk";
  }
}
lander_station_centrifuge() {
  while(1) {
    level waittill("LACF");
    players = GetLocalPlayers();
    for(x = 0; x < players.size; x++) {
      screens = getEntArray(x, "lander_screens", "targetname");
      for(i = 0; i < screens.size; i++) {
        screens[i] lander_at_station("centrifuge", x);
      }
    }
  }
}
lander_station_baseentry() {
  while(1) {
    level waittill("LABE");
    players = GetLocalPlayers();
    for(x = 0; x < players.size; x++) {
      screens = getEntArray(x, "lander_screens", "targetname");
      for(i = 0; i < screens.size; i++) {
        screens[i] lander_at_station("baseentry", x);;
      }
    }
  }
}
lander_station_storage() {
  while(1) {
    level waittill("LASS");
    players = GetLocalPlayers();
    for(x = 0; x < players.size; x++) {
      screens = getEntArray(x, "lander_screens", "targetname");
      for(i = 0; i < screens.size; i++) {
        screens[i] lander_at_station("storage", x);
      }
    }
  }
}
lander_station_catwalk() {
  while(1) {
    level waittill("LACW");
    players = GetLocalPlayers();
    for(x = 0; x < players.size; x++) {
      screens = getEntArray(x, "lander_screens", "targetname");
      for(i = 0; i < screens.size; i++) {
        screens[i] lander_at_station("catwalk", x);
      }
    }
  }
}
launch_panel_centrifuge_status(localClientNum, set, newEnt) {
  if(set) {
    if(isDefined(self.centrifuge_status)) {
      StopFX(localClientNum, self.centrifuge_status);
    }
    self.centrifuge_status = playFXOnTag(localClientNum, level._effect["panel_red"], self, "tag_home");
  } else {
    if(isDefined(self.centrifuge_status)) {
      StopFX(localClientNum, self.centrifuge_status);
    }
    self.centrifuge_status = playFXOnTag(localClientNum, level._effect["panel_green"], self, "tag_home");
  }
}
launch_panel_storage_status(localClientNum, set, newEnt) {
  if(set) {
    if(localClientNum == 0) {
      level.rocket_num++;
    }
    level thread rocket_launch_display(localClientNum);
  } else {}
}
launch_panel_baseentry_status(localClientNum, set, newEnt) {
  if(set) {
    if(localClientNum == 0) {
      level.rocket_num++;
    }
    level thread rocket_launch_display(localClientNum);
  } else {}
}
launch_panel_catwalk_status(localClientNum, set, newEnt) {
  if(set) {
    if(localClientNum == 0) {
      level.rocket_num++;
    }
    level thread rocket_launch_display(localClientNum);
  } else {}
}
rocket_launch_display(localClientNum) {
  level waittill("LG");
  wait(2);
  rocket_screens = getEntArray(localClientNum, "rocket_launch_sign", "targetname");
  model = rocket_screens[0].model;
  switch (level.rocket_num) {
    case 1:
      model = "p_zom_rocket_sign_02";
      break;
    case 2:
      model = "p_zom_rocket_sign_03";
      break;
    case 3:
      model = "p_zom_rocket_sign_04";
      break;
  }
  array_thread(rocket_screens, ::update_rocket_display, model);
}
update_rocket_display(on_model) {
  old_model = self.model;
  for(i = 0; i < 3; i++) {
    self setModel(on_model);
    wait(.35);
    self setModel(old_model);
    wait(.35);
  }
  self setModel(on_model);
}
lander_rumble_and_quake(localClientNum, set, newEnt) {
  player = getlocalplayers()[localClientNum];
  player endon("death");
  player endon("disconnect");
  if(player IsSpectating()) {
    return;
  }
  if(set) {
    player Earthquake(RandomFloatRange(0.2, 0.3), RandomFloatRange(2, 2.5), player.origin, 150);
    player PlayRumbleOnEntity(localClientNum, "artillery_rumble");
    self thread do_lander_rumble_quake(localClientNum);
  } else {
    self thread end_ground_sounds();
    player Earthquake(RandomFloatRange(0.3, 0.4), RandomFloatRange(0.5, 0.6), self.origin, 150);
    wait(0.6);
    if(isDefined(player) && isDefined(self)) {
      player EarthQuake(RandomFloatRange(0.1, 0.2), RandomFloatRange(0.2, 0.3), self.origin, 150);
    }
    level notify("stop_lander_rumble");
  }
}
do_lander_rumble_quake(localClientNum) {
  level endon("stop_lander_rumble");
  player = getlocalplayers()[localClientNum];
  player endon("death");
  player endon("disconnect");
  while(1) {
    if(!isDefined(self.origin) || !isDefined(player.origin)) {
      wait(.05);
      continue;
    }
    if(distancesquared(player.origin, self.origin) > (1500 * 1500)) {
      wait(.1);
      continue;
    }
    dist = distancesquared(player.origin, self.origin);
    if(dist > 750 * 750) {
      player Earthquake(RandomFloatRange(0.1, 0.15), RandomFloatRange(0.15, 0.16), self.origin, 1000);
      rumble = "slide_rumble";
    } else {
      player Earthquake(RandomFloatRange(0.15, 0.2), RandomFloatRange(0.15, 0.16), self.origin, 750);
      rumble = "damage_light";
    }
    player PlayRumbleOnEntity(localClientNum, rumble);
    wait(.1);
  }
}
centrifuge_rumble_control(local_client_num, set, newEnt) {
  if(local_client_num != 0) {
    return;
  }
  if(set) {
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i] thread centrifuge_rumble_when_close(self, i);
    }
  } else {
    level notify("centrifuge_rumble_done");
  }
}
centrifuge_rumble_when_close(ent_centrifuge, int_client_num) {
  self endon("death");
  self endon("disconnect");
  level endon("centrifuge_rumble_done");
  rumble_range = 600 * 600;
  centrifuge_rumble = "damage_heavy";
  client_num = undefined;
  while(isDefined(self)) {
    distance_to_centrifuge = DistanceSquared(self.origin, ent_centrifuge.origin);
    if((distance_to_centrifuge < rumble_range) && isDefined(self)) {
      if(isDefined(int_client_num)) {
        self PlayRumbleOnEntity(int_client_num, centrifuge_rumble);
      }
    }
    if((distance_to_centrifuge > rumble_range)) {
      if(isDefined(int_client_num) && isDefined(self)) {
        self StopRumble(int_client_num, centrifuge_rumble);
      }
    }
    wait(0.1);
  }
}
centrifuge_clean_rumble(int_client_num) {
  self endon("death");
  self endon("disconnect");
  self StopRumble(int_client_num, "damage_heavy");
}
centrifuge_warning_lights_init(local_client_num, set, newEnt) {
  while(!self hasdobj(local_client_num)) {
    wait(0.1);
  }
  if(local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    self centrifuge_warning_lights_off(i);
  }
  if(set) {
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      self centrifuge_fx_spot_init(i);
      self centrifuge_warning_lights_on(i);
    }
  }
}
monkey_lander_fx_on() {
  self endon("switch_off_monkey_lander_fx");
  playSound(0, "zmb_ape_intro_whoosh", self.origin);
  realWait(2.5);
  self.fx = [];
  players = getlocalplayers();
  ent_num = self GetEntityNumber();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!isDefined(player._monkey_lander_fx)) {
      player._monkey_lander_fx = [];
    }
    if(isDefined(player._monkey_lander_fx[ent_num])) {
      DeleteFX(i, player._monkey_lander_fx[ent_num]);
      player._monkey_lander_fx[ent_num] = undefined;
    }
    player._monkey_lander_fx[ent_num] = playFXOnTag(i, level._effect["monkey_trail"], self, "tag_origin");
  }
}
monkey_lander_delay_fx_off() {
  realWait(5);
  self notify("switch_off_monkey_lander_fx");
  players = getlocalplayers();
  ent_num = self GetEntityNumber();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player._monkey_lander_fx[ent_num])) {
      DeleteFX(i, player._monkey_lander_fx[ent_num]);
      player._monkey_lander_fx[ent_num] = undefined;
    }
  }
}
monkey_lander_fx_off() {
  self thread monkey_lander_delay_fx_off();
  players = getlocalplayers();
  ent_num = self GetEntityNumber();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    playFX(i, level._effect["monkey_spawn"], self.origin);
    PlayRumbleOnPosition(i, "explosion_generic", self.origin);
    player Earthquake(0.5, 0.5, player.origin, 1000);
  }
  playSound(0, "zmb_ape_intro_land", self.origin);
  level notify("MLO");
  wait(0.5);
  level notify("MLF");
}
monkey_lander_fx(local_client_num, set, newEnt) {
  if(local_client_num != 0) {
    return;
  }
  while(!self hasdobj(local_client_num)) {
    wait(0.1);
  }
  if(set) {
    self thread monkey_lander_fx_on();
  } else {
    self thread monkey_lander_fx_off();
  }
}
centrifuge_fx_spot_init(int_client_num) {
  self._centrifuge_lights_[int_client_num] = [];
  self._centrifuge_lights_[int_client_num] = add_to_array(self._centrifuge_lights_[int_client_num], "tag_light_bk_top", false);
  self._centrifuge_lights_[int_client_num] = add_to_array(self._centrifuge_lights_[int_client_num], "tag_light_fnt_top", false);
  self._centrifuge_sparks_[int_client_num] = [];
  self._centrifuge_sparks_[int_client_num] = add_to_array(self._centrifuge_sparks_[int_client_num], "tag_light_bk_bttm", false);
  self._centrifuge_sparks_[int_client_num] = add_to_array(self._centrifuge_sparks_[int_client_num], "tag_light_fnt_bttm", false);
  self._centrifuge_steams_[int_client_num] = [];
  self._centrifuge_steams_[int_client_num] = add_to_array(self._centrifuge_steams_[int_client_num], "tag_vent_bk_btm", false);
  self._centrifuge_steams_[int_client_num] = add_to_array(self._centrifuge_steams_[int_client_num], "tag_vent_top_btm", false);
  self._centrifuge_light_mdls_[int_client_num] = [];
  self._centrifuge_fx_setup = true;
}
centrifuge_warning_lights_on(client_num) {
  for(i = 0; i < self._centrifuge_lights_[client_num].size; i++) {
    temp_mdl = spawn(client_num, self GetTagOrigin(self._centrifuge_lights_[client_num][i]), "script_model");
    temp_mdl.angles = self GetTagAngles(self._centrifuge_lights_[client_num][i]);
    temp_mdl setModel("tag_origin");
    temp_mdl LinkTo(self, self._centrifuge_lights_[client_num][i]);
    playFXOnTag(client_num, level._effect["centrifuge_warning_light"], temp_mdl, "tag_origin");
    self._centrifuge_light_mdls_[client_num] = add_to_array(self._centrifuge_light_mdls_[client_num], temp_mdl, false);
  }
  for(i = 0; i < self._centrifuge_sparks_[client_num].size; i++) {
    temp_mdl = spawn(client_num, self GetTagOrigin(self._centrifuge_sparks_[client_num][i]), "script_model");
    temp_mdl.angles = self GetTagAngles(self._centrifuge_sparks_[client_num][i]);
    temp_mdl setModel("tag_origin");
    temp_mdl LinkTo(self, self._centrifuge_sparks_[client_num][i]);
    playFXOnTag(client_num, level._effect["centrifuge_light_spark"], temp_mdl, "tag_origin");
    self._centrifuge_light_mdls_[client_num] = add_to_array(self._centrifuge_light_mdls_[client_num], temp_mdl, false);
  }
  self thread centrifuge_steam_warning(client_num);
}
centrifuge_steam_warning(client_num) {
  wait(1.0);
  for(i = 0; i < self._centrifuge_steams_[client_num].size; i++) {
    playFXOnTag(client_num, level._effect["centrifuge_start_steam"], self, self._centrifuge_steams_[client_num][i]);
  }
}
centrifuge_warning_lights_off(client_num) {
  if(!isDefined(self._centrifuge_fx_setup)) {
    return;
  }
  wait(0.2);
  for(i = 0; i < self._centrifuge_light_mdls_[client_num].size; i++) {
    if(isDefined(self._centrifuge_light_mdls_[client_num][i])) {
      self._centrifuge_light_mdls_[client_num][i] Unlink();
    }
  }
  array_delete(self._centrifuge_light_mdls_[client_num]);
  self._centrifuge_light_mdls_[client_num] = [];
}
fog_apply(str_fog, int_priority) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self._zombie_fog_list)) {
    self._zombie_fog_list = [];
  }
  if(!isDefined(str_fog) || !isDefined(int_priority)) {
    return;
  }
  already_in_array = false;
  if(self._zombie_fog_list.size != 0) {
    for(i = 0; i < self._zombie_fog_list.size; i++) {
      if(isDefined(self._zombie_fog_list[i].fog_setting) && self._zombie_fog_list[i].fog_setting == str_fog) {
        already_in_array = true;
        if(self._zombie_fog_list[i].priority != int_priority) {
          self._zombie_fog_list[i].priority = int_priority;
        }
        break;
      }
    }
  }
  if(!already_in_array) {
    temp_struct = spawnStruct();
    temp_struct.fog_setting = str_fog;
    temp_struct.priority = int_priority;
    self._zombie_fog_list = add_to_array(self._zombie_fog_list, temp_struct, false);
  }
  fog_to_set = get_fog_by_priority();
  set_fog(fog_to_set);
}
fog_remove(str_fog) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(str_fog)) {
    return;
  }
  if(!isDefined(self._zombie_fog_list)) {
    self._zombie_fog_list = [];
  }
  temp_struct = undefined;
  for(i = 0; i < self._zombie_fog_list.size; i++) {
    if(isDefined(self._zombie_fog_list[i].fog_setting) && self._zombie_fog_list[i].fog_setting == str_fog) {
      temp_struct = self._zombie_fog_list[i];
    }
  }
  if(isDefined(temp_struct)) {
    self._zombie_fog_list = array_remove(self._zombie_fog_list, temp_struct);
  }
  fog_to_set = get_fog_by_priority();
  set_fog(fog_to_set);
}
get_fog_by_priority() {
  if(!isDefined(self._zombie_fog_list)) {
    return;
  }
  highest_score = 0;
  highest_score_fog = undefined;
  for(i = 0; i < self._zombie_fog_list.size; i++) {
    if(isDefined(self._zombie_fog_list[i].priority) && self._zombie_fog_list[i].priority > highest_score) {
      highest_score = self._zombie_fog_list[i].priority;
      highest_score_fog = self._zombie_fog_list[i].fog_setting;
    }
  }
  return highest_score_fog;
}
setup_fog() {
  waitforclient(0);
  wait(1);
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    players[i] fog_apply("normal", level._fog_settings_default_priority);
  }
}
set_fog(fog_type) {
  if(!isDefined(fog_type)) {
    return;
  }
  switch (fog_type) {
    case "normal":
      start_dist = 2013.52;
      half_dist = 2400.04;
      half_height = 640.408;
      base_height = 805;
      fog_r = 0.055;
      fog_g = 0.0862;
      fog_b = 0.0862;
      fog_scale = 3.29585;
      sun_col_r = 0.341176;
      sun_col_g = 0.368627;
      sun_col_b = 0.388235;
      sun_dir_x = -0.492497;
      sun_dir_y = 0.584479;
      sun_dir_z = 0.64485;
      sun_start_ang = 14.832;
      sun_stop_ang = 113.6;
      time = 5;
      max_fog_opacity = 1;
      setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
      break;
    case "monkey":
      start_dist = 335.113;
      half_dist = 512.821;
      half_height = 913.4;
      base_height = 539.71;
      fog_r = 0.231373;
      fog_g = 0.176471;
      fog_b = 0.254902;
      fog_scale = 3.57142;
      sun_col_r = 0.431373;
      sun_col_g = 0;
      sun_col_b = 0;
      sun_dir_x = 0;
      sun_dir_y = 0;
      sun_dir_z = -1;
      sun_start_ang = 0;
      sun_stop_ang = 118.502;
      time = 3;
      max_fog_opacity = 0.999887;
      setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
      break;
    case "lander":
      start_dist = 767.866;
      half_dist = 512.821;
      half_height = 913.4;
      base_height = 539.71;
      fog_r = 0.054902;
      fog_g = 0.0823529;
      fog_b = 0.0901961;
      fog_scale = 3.29585;
      sun_col_r = 0.439216;
      sun_col_g = 0.466667;
      sun_col_b = 0.486275;
      sun_dir_x = -0.290644;
      sun_dir_y = 0.728615;
      sun_dir_z = 0.620199;
      sun_start_ang = 0;
      sun_stop_ang = 62.865;
      time = 3;
      max_fog_opacity = 1;
      setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
      break;
  }
}
player_lander_fog(local_client_num, set, newEnt) {
  player = getlocalplayers()[local_client_num];
  if(set) {
    player thread fog_apply("lander", level._fog_settings_lander_priority);
  } else {
    player thread fog_remove("lander");
  }
}