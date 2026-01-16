/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_intro.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include maps\_scene;
#include maps\_turret;
#include maps\_dialog;
#include maps\haiti_anim;
#include maps\haiti_util;
#include maps\haiti_jetwing;
#include maps\_music;
#include maps\_jetwing;
#include maps\createart\haiti_art;
#include maps\_audio;
#include maps\haiti;
#include maps\haiti_front_door;
#include maps\_anim;

init_flags() {
  flag_init("avoid_vtols");
  flag_init("avoid_missiles");
  flag_init("landed");
  flag_init("jetwing_speedup");
  flag_init("jetwing_done");
}

init_spawn_funcs() {
}

skipto_intro_harper_dead() {
  level.is_harper_alive = 0;
  skipto_intro();
}

skipto_intro() {
  setup_harper();
  skipto_teleport("skipto_intro");
  maps\_jetwing::init();
  level.jetwing_ai_offsets = [];
  level.jetwing_ai_offsets[0] = (250, -75, 0);
  level.jetwing_ai_offsets[1] = (250, -150, 75);
  level.jetwing_ai_offsets[2] = (350, -170, -75);
  level.jetwing_ai_offsets[3] = (400, -150, 0);
  level.jetwing_ai_offsets[4] = (250, 525, 0);
  level.jetwing_ai_offsets[5] = (250, 450, 75);
  level.jetwing_ai_offsets[6] = (350, 430, -75);
  level.jetwing_ai_offsets[7] = (400, 450, 0);
  level.jetwing_ai_offsets[8] = (250, 425, -150);
  level.jetwing_ai_offsets[9] = (250, 350, -75);
  level.jetwing_ai_offsets[10] = (350, 330, -225);
  level.jetwing_ai_offsets[11] = (400, 350, -150);
  level.jetwing_ai_offsets[12] = (250, -350, 125);
  level.jetwing_ai_offsets[13] = (250, -425, 200);
  level.jetwing_ai_offsets[14] = (350, -445, 50);
  level.jetwing_ai_offsets[15] = (400, -425, 125);
  level.jetwing_ai_offsets[16] = (250, -200, -100);
  level.jetwing_ai_offsets[17] = (250, -275, -25);
  level.jetwing_ai_offsets[18] = (350, -295, -175);
  level.jetwing_ai_offsets[19] = (400, -275, -100);
  level.jetwing_ai_offsets[20] = (250, -50, 300);
  level.jetwing_ai_offsets[21] = (250, 50, 225);
  level.jetwing_ai_offsets[22] = (350, -100, 375);
  level.jetwing_ai_offsets[23] = (400, 100, 300);
  level.jetwing_ai_offsets[24] = vectorscale((1, 0, 0), 800.0);
  level.jetwing_ai_offsets[25] = vectorscale((1, 0, 0), 400.0);
  level.jetwing_ai_offsets[26] = (350, -100, 375);
  level.jetwing_ai_offsets[27] = (400, 100, 300);
  level.plane_flyby_offsets = [];
  level.plane_flyby_offsets[0] = (350, 500, 250);
  level.plane_flyby_offsets[1] = (350, -500, 350);
  level.plane_flyby_offsets[2] = (-350, 500, 0);
  level.plane_flyby_offsets[3] = (-350, -500, 0);
  level.avoid_drone_spawn_offsets = [];
  level.avoid_drone_spawn_offsets[0] = (0, 0, 0);
  level.avoid_drone_spawn_offsets[1] = vectorscale((0, 1, 0), 900.0);
  level.avoid_drone_spawn_offsets[2] = vectorscale((0, -1, 0), 900.0);
  level.avoid_drone_spawn_offsets[3] = vectorscale((0, 0, 1), 900.0);
  level.avoid_drone_spawn_offsets[4] = (550, -1100, -1000);
  level.avoid_drone_spawn_offsets[5] = (550, 1575, -1500);
  level.avoid_drone_spawn_offsets[6] = (-550, -1575, 1600);
  level.avoid_drone_spawn_offsets[7] = (-550, 1575, 0);
  level.avoid_drone_spawn_offsets[8] = (550, -1575, -800);
  level.avoid_drone_spawn_offsets[9] = (550, 1575, 800);
  level.avoid_drone_spawn_offsets[10] = (-550, -1575, 800);
  level.avoid_drone_spawn_offsets[11] = (-550, 1575, -800);
  level.jetwing_harper_offset = (200, 100, 50);
  level.missile_list = [];
  intro_anims();
  setsaveddvar("phys_piecesSpawnDistanceCutoff", "25000");
  setsaveddvar("cg_objectiveIndicatorFarFadeDist", "50000");
  rpc("clientscripts/haiti", "put_on_oxygen_mask");
  rpc("clientscripts/haiti", "set_intro_fog");
  level.drop_vista_1 = getent("drop_vista", "targetname");
  level.drop_vista_1 setforcenocull();
  level.drop_vista_1 ignorecheapentityflag(1);
  level.drop_vista_2 = getent("drop_vista_2", "targetname");
  level.drop_vista_2 setforcenocull();
  level.drop_vista_2 hide();
  level.drop_vista_2 ignorecheapentityflag(1);
}

skipto_landing() {
  setup_harper();
  skipto_teleport("skipto_front_door");
  maps\_jetwing::init();
  intro_anims();
  rpc("clientscripts/haiti", "put_on_oxygen_mask");
  flag_set("jetwing_speedup");
  level thread setup_landing();
  jetwing_audio(level.player);
}

intro_main() {
  onsaverestored_callback(::intro_save_restore);
  run_scene_first_frame("intro");

  if(isDefined(level.is_harper_alive) && level.is_harper_alive == 0)
    run_scene_first_frame("intro_player_harperdead");
  else
    run_scene_first_frame("intro_player");

  add_spawn_function_veh("ai_jetwing", ::ai_jetwing_think, 80);
  add_spawn_function_veh("ai_jetwing_chinese", ::ai_jetwing_think, 135, 3.5);
  add_spawn_function_veh("ai_jetwing_usa", ::ai_jetwing_think, 130, 2.5);
  add_spawn_function_veh("ai_jetwing_usa_right", ::ai_jetwing_think, 105, 2.75);
  add_spawn_function_veh("ai_jetwing_usa_left", ::ai_jetwing_think, 105, 2.8);
  add_spawn_function_veh("ai_jetwing_usa_top", ::ai_jetwing_think, 135, 3.5);
  add_spawn_function_veh("avoid_vtol_cockpit", ::avoid_vtol_piece_think, "tag_cockpit_link_jnt", vectorscale((0, 0, 1), 400.0), 25, vectorscale((0, 0, 1), 90.0));
  add_spawn_function_veh("avoid_vtol_wing", ::avoid_vtol_piece_think, "tag_engine_l_link_jnt", vectorscale((0, -1, 0), 300.0), 20, vectorscale((1, 0, 0), 10.0));
  add_spawn_function_veh("avoid_vtol_tail", ::avoid_vtol_piece_think, "tag_fuselage_link_jnt", (0, 600, 175), 20, vectorscale((0, 0, 1), 45.0));
  add_spawn_function_veh("jetwing_landing_guys", ::ai_landing_jetwing_think2);
  setmusicstate("HAITI_INTRO");
  level clientnotify("intro_snapshot");
  flag_wait("starting final intro screen fadeout");
  level.player thread take_and_giveback_weapons("intro_giveback_weapon");
  luinotifyevent(&"hud_shrink_ammo");
  intro();
  player_enter_jetwing();
  player_avoid_vtols();
  player_avoid_drones();
  player_avoid_missiles();
  level.player notify("intro_giveback_weapon");
}

landing_main() {
  player_jetwing_land();
}

intro() {
  if(isDefined(level.is_harper_alive) && level.is_harper_alive == 0)
    level thread run_scene("intro_player_harperdead");
  else
    level thread run_scene("intro_player");

  level thread run_scene("intro");
  exploder(101);
  exploder(102);
  exploder(103);
  flag_wait("intro_started");
  level thread intro_flak(undefined);
  level thread pregameplay_fx();
  level thread assemble_vtol_explode2();
  level clientnotify("hmt");
  player_body = getent("player_body", "targetname");
  player_body attach("c_usa_cia_haiti_viewbody_vson", "J_WristTwist_LE");
  level thread maps\createart\haiti_art::vtol_interior();
  vtol_exterior = getent("intro_v78_exterior", "targetname");
  vtol_exterior hide();
  vtol_exterior thread intro_vtol_sound();
  level thread vtol_hatch_open();
  level thread vtol_explode2();
  level thread intro_fxanims();
  luinotifyevent(&"hud_update_vehicle_custom", 2, 1, & "plane_jetwing_haiti");
  luinotifyevent(&"hud_jetwing_alpha", 1, 50);
  level thread maps\_audio::switch_music_wait("HAITI_FLIGHT", 56);
  level waittill("first_objective");
  set_objective(level.obj_stop_transmission);
  scene_wait("intro");
}

intro_vtol_sound() {
  vtol_snd_ent = spawn("script_origin", (0, 0, 0));
  vtol_snd_ent linkto(self);
  vtol_snd_ent playloopsound("veh_plr_vtol_interior", 2);
  wait 43;
  vtol_snd_ent stoploopsound(1);
  wait 4;
  vtol_snd_ent delete();
}

player_enter_jetwing() {
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
  setsaveddvar("vehPlaneConventionalFlight", "1");
  path = getvehiclenode("path_jetwing", "targetname");
  level.jetwing = spawn_vehicle_from_targetname("jetwing_player");
  level.jetwing.origin = level.player.origin;
  level.jetwing setphysangles((67, -96, 0));
  level.jetwing usevehicle(level.player, 0);
  level.jetwing jetwing_init(80);
  level.jetwing thread jetwing_strafe_controls();
  level.jetwing thread jetwing_fx(path.origin);
  level.jetwing thread jetwing_rumble();
  level.jetwing thread jetwing_collision();
  level.jetwing thread jetwing_deathwatcher();
  level.jetwing setdefaultpitch(-5);
  level notify("jetpack_go");
  rpc("clientscripts/haiti", "set_intro_fog");
}

harper_enter_jetwing() {
  level.jetwing_harper = spawn_vehicle_from_targetname("jetwing_harper");
  level.harper = simple_spawn_single("harper");
  level.harper vehicle_enter(level.jetwing_harper);
  path = getvehiclenode("path_jetwing", "targetname");
  level.jetwing_harper setspeed(80, 100, 100);
  level.jetwing_harper setpathtransitiontime(2);
  level.jetwing_harper pathfixedoffset(level.jetwing_harper_offset);
  level.jetwing_harper pathvariableoffset((75, 75, 50), randomfloatrange(1.5, 2));
  level.jetwing_harper setdefaultpitch(-25);
  level.jetwing_harper thread go_path(path);
  level.jetwing_harper thread harper_jetwing_think();
}

harper_jetwing_think() {
  self endon("death");

  while(true) {
    if(isDefined(level.jetwing) && isDefined(level.jetwing.rolling) && !level.jetwing.rolling) {
      current_offset = self getpathfixedoffset();
      new_offset_x = difftrack(level.jetwing_harper_offset[0] + level.jetwing.jetwing_offset[0], current_offset[0], 3, 0.05);
      new_offset_y = difftrack(level.jetwing_harper_offset[1] + level.jetwing.jetwing_offset[1], current_offset[1], 3, 0.05);
      new_offset_z = difftrack(level.jetwing_harper_offset[2] + level.jetwing.jetwing_offset[2], current_offset[2], 3, 0.05);
      self pathfixedoffset((new_offset_x, new_offset_y, new_offset_z));
    }

    wait 0.05;
  }
}

player_avoid_vtols() {
  flag_set("avoid_vtols");
  autosave_by_name("avoid_vtols");
  spawn_avoid_vtols();
  spawn_clouds("section_1_cloud_struct", "avoid_drones", getvehiclenode("path_jetwing", "targetname").angles);
  spawn_clouds("section_1_locked_cloud_struct", "swap_vista", getvehiclenode("path_jetwing", "targetname").angles);
  level thread plane_flyby_group("trig_f38_drop_group_2", "start_drop_group_2", "f38_drop_group_2", 4);
  level thread plane_flyby_group("trig_f38_drop_group_3", "start_drop_group_3", "f38_drop_group_3", 4);
  level thread aerial_explosion_manager("vtols", 1, 2, (5000, -2500, -2000), (10000, 2500, 2000));
  level thread aa_fire_manager();
  level thread vtol_flock_manager();
  level thread air_battle_manager();
  level thread jetwing_ai_groups();
  level thread jetwing_fx_anims();
  level thread avoid_vtols_vo();
  set_objective(level.obj_stop_transmission, undefined, "done");
  set_objective(level.obj_avoid_collisions);
  harper_enter_jetwing();
  path = getvehiclenode("path_jetwing", "targetname");
  level notify("avoid_vtols");
  level notify("end_expl_manager_intro");
  level notify("end_expl_manager_pregameplay");
  level.jetwing thread go_path(path);
  wait 2;
  stop_exploder(125);
  trigger_wait("trig_avoid_drones", "targetname");
}

player_avoid_missiles() {
  flag_set("avoid_missiles");
  autosave_by_name("avoid_missiles");
  level notify("avoid_missiles");
  vtols = getentarray("avoid_vtol", "script_noteworthy");
  array_delete(vtols);
  level thread missile_fire_manager();
  level thread avoid_missiles_vo();
  level thread avoid_pieces();
  trigger_wait("trig_final_cloud_transition");
}

player_avoid_drones() {
  level thread set_cloud_fog();
  level notify("avoid_drones");
  stop_exploder(101);
  trigger_use("trig_jetwing_ai_chinese");
  trigger_use("trig_jetwing_ai_usa_top");
  level thread spawn_ambient_drones(undefined, undefined, "pegasus_drop_group_3", "f38_drop_group_3", "start_drop_group_9", 4, 2, 2, 3, 850, 3, 2);
  level thread spawn_ambient_drones(undefined, undefined, "pegasus_drop_group_5", "f38_drop_group_5", "start_drop_group_5", 4, 2, 2, 3, 850, 5, 2);
  level thread spawn_ambient_drones(undefined, undefined, "pegasus_drop_group_6", "f38_drop_group_6", "pegasus_avoid_start_4", 4, 2, 2, 3, 850, 3, 2);
  level thread setup_landing();
  level notify("end_expl_manager_vtols");
  level thread aerial_explosion_manager("drones", 1.5, 2.5, (5000, 1500, -3000), (10000, 5500, 3000));
  level thread aerial_explosion_manager("drones", 1.5, 2.5, (5000, -5500, -3000), (10000, -1500, 3000));
  wait 2;
  level.aa_fire_min_delay = 0.25;
  level.aa_fire_max_delay = 0.5;
  level.drop_vista_1 hide();
  level notify("swap_vista");
  level.drop_vista_2 show();
  spawn_clouds("section_2_cloud_struct", "jetwing_land_start", level.jetwing.angles);
  spawn_clouds("section_2_locked_cloud_struct", "jetwing_land_start", getvehiclenode("path_jetwing", "targetname").angles);
  level.jetwing setspeed(90, 100, 100);
  vehicles = getvehiclearray("allies");

  foreach(vehicle in vehicles) {
    if(isalive(vehicle)) {
      if(vehicle.vehicletype == "plane_jetwing_haiti_ai" || vehicle.vehicletype == "plane_jetwing_haiti_ai_hero")
        vehicle setspeed(90, 100, 100);
    }
  }

  flag_set("jetwing_speedup");
  level thread set_intro_fog();
}

landing_lods() {
  scale_model_lods(1.5, 1.0);
  wait 12.5;
  scale_model_lods(1.0, 1.0);
}

player_jetwing_land() {
  if(isDefined(level.jetwing_harper))
    level.jetwing_harper delete();

  if(isDefined(level.drop_vista_1))
    level.drop_vista_1 delete();

  if(isDefined(level.drop_vista_1))
    level.drop_vista_2 delete();

  level notify("approach_facility");

  if(isDefined(level.jetwing))
    level.jetwing notify("approach_facility");

  rpc("clientscripts/haiti", "set_cloud_fog");
  level.player thread jetwing_landing_rumble();
  delay_thread(0.5, ::cloud_exposure, 4, 0.25, 0.25);
  wait 2;
  level thread start_landing_fx();
  set_objective(level.obj_avoid_collisions, undefined, "delete");
  cleanup_ents("cleanup_intro");
  maps\haiti::fxanim_delete_intro();
  level thread model_restore_area("convert_front_door");
  load_gump("haiti_gump_front_door");
  level.player resetfov();
  level thread delay_intro_fog(0.5);
  level thread maps\haiti::fxanim_construct_front_door();
  level thread maps\haiti_front_door::start_ground_events();
  level notify("jetwing_land_start");
  level notify("end_expl_manager_drones");
  level thread add_fake_jetwing_hud();

  if(isDefined(level.jetwing)) {
    level.jetwing useby(level.player);
    level.jetwing delete();
  }

  level notify("jetwing_done");
  flag_set("jetwing_done");
  level notify("end_ambient_drones_start_drop_group_3");
  level notify("end_ambient_drones_start_drop_group_4");
  level notify("end_ambient_drones_start_drop_group_5");
  clientnotify("stop_jetpack");

  if(level.is_harper_alive)
    level.ai_harper = init_hero("harper", ::harper_think);

  level thread start_jetwing_land_exhaust();
  level thread run_scene("jetwing_land_crash");

  if(isDefined(level.is_harper_alive) && level.is_harper_alive == 1) {
    level thread run_scene("jetwing_land_alt");
    level thread run_scene("jetwing_land_player");
  } else
    level thread run_scene("jetwing_land_player_alt");

  level thread landing_lods();
  run_scene("jetwing_land");
  level.player show_hud();
  setsaveddvar("Cg_aggressivecullradius", 100);
  onsaverestored_callback(undefined);
  level thread delay_give_challenge(3);
  level notify("end_expl_manager_landing");
  level notify("end_flock_manager_start_landing_vtols_2");
  level notify("jetwing_landed");
  flag_set("landed");
  level thread autosave_by_name("haiti_landed");
}

delay_give_challenge(delay) {
  wait(delay);

  if(isDefined(level.player_burned) && !level.player_burned)
    level notify("player_avoid_missiles");
}

start_jetwing_land_exhaust() {
  flag_wait("jetwing_land_started");

  for(i = 1; i < 18; i++) {
    jetwing = getent("intro_jetwing" + i + "_landing", "targetname");
    playfxontag(level._effect["jetwing_hero_exhaust"], jetwing, "tag_engine_left");
  }
}

delay_intro_fog(time) {
  wait(time);
  rpc("clientscripts/haiti", "set_intro_fog");
}

add_fake_jetwing_hud() {
  level.player waittill("exit_vehicle");
  wait 0.05;
  luinotifyevent(&"hud_update_vehicle_custom", 2, 1, & "plane_jetwing_haiti");
}

#using_animtree("vehicles");

spawn_avoid_vtols() {
  if(!isDefined(level.vtols))
    level.vtols = [];
  else
    array_delete(level.vtols);

  vtol_structs = getstructarray("avoid_vtol", "targetname");

  foreach(struct in vtol_structs) {
    vtol = spawn("script_model", struct.origin);
    vtol.angles = struct.angles;
    vtol setmodel("veh_t6_air_v78_vtol");
    vtol useanimtree(#animtree);
    vtol setanim( % v_vtol_flight_idle, 1, 0.1, 1);
    vtol playloopsound("veh_amb_vtol_engine_low");
    vtol.targetname = struct.targetname;
    vtol.script_noteworthy = struct.script_noteworthy;
    vtol.script_float = struct.script_float;
    vtol thread avoid_vtol_think(0);
    vtol thread avoid_vtol_death();
  }
}

avoid_vtol_think(b_wait, b_fake_flight, b_exhaust) {
  if(!isDefined(b_wait))
    b_wait = 1;

  if(!isDefined(b_fake_flight))
    b_fake_flight = 1;

  if(!isDefined(b_exhaust))
    b_exhaust = 1;

  self endon("death");
  self endon("stop_think");
  level endon("jetwing_done");

  if(b_wait)
    level waittill("jetpack_go");

  fwd = anglestoforward(self.angles);
  self.speed = 0;
  amplitude = randomintrange(25, 35);
  frequency = randomfloatrange(0.025, 0.05);
  maxroll = randomintrange(10, 25);

  if(b_exhaust)
    playfxontag(level._effect["vtol_exhaust_cheap"], self, "tag_engine_left");

  while(!flag("jetwing_done")) {
    fwd = anglestoforward(self.angles);
    self.origin = self.origin + fwd * (self.speed * 17.6) * 0.05;

    if(b_fake_flight) {
      sin = sin(frequency * gettime());
      p = sin * amplitude;
      a = sin * maxroll;
      self.origin = (self.origin[0], self.origin[1], self.origin[2] + p);
      self.angles = (self.angles[0], self.angles[1], a);
    }

    wait 0.05;
  }

  self delete();
}

avoid_vtol_think2(leader, offset) {
  self endon("death");

  while(true) {
    angles = leader.angles;
    angles = (angles[0], angles[1], 0);
    forward = anglestoforward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    origin = leader.origin + forward * offset[0] + right * offset[1] + up * offset[2];
    x = difftrack(origin[0], self.origin[0], 1, 0.05);
    y = difftrack(origin[1], self.origin[1], 1, 0.05);
    z = difftrack(origin[2], self.origin[2], 1, 0.05);
    pitch = difftrack(leader.angles[0], self.angles[0], 1, 0.05);
    yaw = difftrack(leader.angles[1], self.angles[1], 1, 0.05);
    roll = difftrack(leader.angles[2], self.angles[2], 1, 0.05);
    self.origin = (x, y, z);
    self.angles = (pitch, yaw, roll);
    wait 0.05;
  }
}

avoid_vtol_death() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(self.origin[2] > level.player.origin[2]) {
    return;
  }
  self dodamage(self.health + 1000, self.origin);
  dir = vectornormalize(level.jetwing.origin - self.origin);
  self movegravity(dir * 100, 5);
  aerial_explosion(self.origin, self.angles, "vtol_explode");
  playsoundatposition("exp_air_vtol", self.origin);
  playfxontag(level._effect["vtol_trail_cheap"], self, "tag_origin");
  torque = (0, 0, randomintrange(25, 45));

  if(randomint(100) < 50)
    torque = (torque[0], torque[1], torque[2] * -1);

  ang_vel = (0, 0, 0);
  life = 5;

  while(life > 0) {
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[2] < 45 * -1)
      ang_vel = (ang_vel[0], ang_vel[1], 45 * -1);
    else if(ang_vel[2] > 45)
      ang_vel = (ang_vel[0], ang_vel[1], 45);

    self rotatevelocity(ang_vel, 0.05);
    life = life - 0.05;
    wait 0.05;
  }

  self delete();
}

vtol_death_piece(origin, offset, model, fwd, right, up) {
  self endon("death");
  offset = (offset[0], offset[1], offset[2] + randomintrange(-100, 100));
  new_origin = origin + (fwd * offset[0] + right * offset[1] + up * offset[2]);
  dir = vectornormalize(new_origin - origin);
  dir_to_player = vectornormalize(level.player.origin - new_origin);
  dir = vectornormalize(dir + dir_to_player);
  self setmodel(model);
  playfxontag(level._effect["vtol_piece_trail"], self, "tag_origin");
  self thread vtol_death_piece_delete();
  force = randomintrange(500, 1000);
  self movegravity(dir * force, 5);
  torque = (randomintrange(-90, 90), randomintrange(-90, 90), 0);

  if(randomint(100) < 50)
    torque = (torque[0], torque[1], torque[2] * -1);

  ang_vel = (0, 0, 0);

  while(isDefined(self) && self.origin[2] < level.player.origin[2]) {
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[2] < 90 * -1)
      ang_vel = (ang_vel[0], ang_vel[1], 90 * -1);
    else if(ang_vel[2] > 90)
      ang_vel = (ang_vel[0], ang_vel[1], 90);

    self rotatevelocity(ang_vel, 0.05);
    wait 0.05;
  }
}

vtol_death_piece_delete() {
  self endon("death");
  wait 5;
  self delete();
}

aerial_explosion(origin, angles, fx_name, b_quake) {
  if(!isDefined(b_quake))
    b_quake = 1;

  if(fx_name != "none")
    playfx(level._effect[fx_name], origin, (0, 0, 1), anglestoforward(angles));

  n_dist = distance2d(origin, level.player.origin);
  n_quake_scale = clamp(1.0 - n_dist / 10000, 0.25, 1.0);
  n_quake_time = clamp(1.0 - n_dist / 10000, 0.5, 1.5);

  if(b_quake) {
    earthquake(n_quake_scale, n_quake_time, level.player.origin, 1024, level.player);
    level.player thread rumble_loop(3, 0.1);
  }
}

aerial_explosion_manager(name, min_delay, max_delay, min_offset, max_offset) {
  level endon("end_expl_manager_" + name);

  while(true) {
    origin = level.player.origin;
    angles = isDefined(level.jetwing) ? level.jetwing.angles : level.player.angles;
    fwd = anglestoforward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    origin = origin + fwd * randomfloatrange(min_offset[0], max_offset[0]);
    origin = origin + right * randomfloatrange(min_offset[1], max_offset[1]);
    origin = origin + up * randomfloatrange(min_offset[2], max_offset[2]);
    aerial_explosion(origin, (0, 0, 0), "sam_explode_cheap", 0);
    wait(randomfloatrange(min_delay, max_delay));
  }
}

aa_fire_manager() {
  level endon("jetwing_done");
  level endon("approach_facility");
  target_set(level.jetwing, vectorscale((0, 0, -1), 30.0));

  if(!isDefined(level.aa_fire_min_delay))
    level.aa_fire_min_delay = 0.5;

  if(!isDefined(level.aa_fire_max_delay))
    level.aa_fire_max_delay = 1.0;

  while(true) {
    origin = level.jetwing.origin + anglestoforward(level.jetwing.angles) * 5000;
    origin = origin + anglestoright(level.jetwing.angles) * randomintrange(-1500, 1500);
    angles = level.jetwing.angles;
    angles = (angles[0], angles[1] * randomfloatrange(-2, 2), angles[2]);
    dir = anglestoforward(angles) * -1;
    playfx(level._effect["aa_fire"], origin, dir);
    wait(randomfloatrange(level.aa_fire_min_delay, level.aa_fire_max_delay));
  }
}

vtol_flock_manager() {
  level endon("jetwing_done");
  level endon("approach_facility");
  fwd = anglestoforward(vectorscale((0, 1, 0), 131.0));

  while(true) {
    angles = level.jetwing.angles;
    angles = (angles[0], angles[1], 0);
    origin = level.jetwing.origin + anglestoforward(angles) * randomintrange(25000, 50000);
    origin = origin + anglestoright(angles) * randomintrange(-3500, -1500);
    playfx(level._effect["vtol_flock"], origin, fwd);
    wait(randomfloatrange(7, 9));
  }
}

missile_fire_manager() {
  level endon("final_cloud_fog");
  level endon("jetwing_land_start");
  level endon("jetwing_done");
  target_set(level.jetwing, vectorscale((0, 0, -1), 15.0));

  while(true) {
    angles = level.jetwing.angles;
    angles = (angles[0], angles[1], angles[2]);
    angles = (angles[0], angles[1], 0);
    origin = level.jetwing.origin + anglestoforward(angles) * 16000;
    origin = origin + anglestoright(angles) * randomintrange(-1500, 1500);
    origin = origin + anglestoup(angles) * randomintrange(-500, -250);
    missile = magicbullet("haiti_missile_turret_alt_sp", origin, level.jetwing.origin, undefined, level.jetwing, vectorscale((0, 0, -1), 30.0));
    missile thread missile_think2();
    wait(randomfloatrange(2, 3));
  }
}

plane_flyby_group(trig_start, path_start, spawner, count) {
  trigger_wait(trig_start);
  path = getvehiclenode(path_start, "targetname");

  for(i = 0; i < count; i++) {
    plane = spawn_vehicle_from_targetname(spawner);
    plane pathfixedoffset(level.plane_flyby_offsets[i]);
    plane thread go_path(path);
    plane thread flyby_plane_think();
    wait 0.25;
  }
}

flyby_plane_think() {
  self waittill("reached_end_node");
  self delete();
}

spawn_avoid_drone_group(spawner_name, path_name, count) {
  path = getvehiclenode(path_name, "targetname");

  for(i = 0; i < count; i++) {
    drone = spawn_vehicle_from_targetname(spawner_name);
    drone setforcenocull();
    drone pathfixedoffset(level.avoid_drone_spawn_offsets[i]);
    drone setspeed(400);
    drone thread go_path(path);
    drone thread avoid_drone_think2();
    wait 0.05;
  }
}

avoid_drone_think2() {
  self endon("death");

  if(self.vteam == "axis")
    self thread avoid_drone_fire();

  self waittill("reached_end_node");
  self delete();
}

avoid_drone_fire() {
  self endon("death");
  wait 0.15;
  self set_turret_target(level.jetwing, vectorscale((0, 0, -1), 60.0), 0);
  self set_turret_target(level.jetwing, (0, 0, 0), 1);
  self thread fire_turret_for_time(6, 0);
  wait 2;
}

spawn_avoid_f38_group(spawner_name, path_name, count) {
  level endon("jetwing_done");
  path = getvehiclenode(path_name, "targetname");

  while(true) {
    for(i = 0; i < count; i++) {
      plane = spawn_vehicle_from_targetname(spawner_name);
      plane setforcenocull();
      plane pathfixedoffset(level.avoid_drone_spawn_offsets[i]);
      plane thread go_path(path);
      plane thread avoid_f38_think();
      wait 0.05;
    }

    wait(randomfloatrange(2, 3));
  }
}

avoid_f38_think() {
  self endon("death");
  self thread avoid_f38_fire();
  self waittill("reached_end_node");
  self delete();
}

avoid_f38_fire() {
  self endon("death");
  wait 0.15;
  self fire_turret_for_time(6, 1);
  self fire_turret_for_time(6, 2);
}

vtol_halo_jumps() {
  level endon("jetwing_done");
  wait 2;
  vtols = getentarray("halo_vtol_2", "script_noteworthy");

  foreach(vtol in vtols) {
    vtol thread do_vtol_halo_jump();
    vtol waittill("halo_jump_go");
    wait 0.05;
  }

  wait 4;
  vtols = getentarray("halo_vtol", "script_noteworthy");

  foreach(vtol in vtols) {
    vtol thread do_vtol_halo_jump();
    vtol waittill("halo_jump_go");
    wait 0.05;
  }
}

do_vtol_halo_jump(b_think) {
  if(!isDefined(b_think))
    b_think = 0;

  self endon("death");
  guys = simple_spawn("halo_guys");
  goto = getent("halo_jump_goto", "targetname");
  jetwings = [];

  for(i = 0; i < guys.size; i++) {
    jetwings[i] = spawn_vehicle_from_targetname("halo_jetwing");
    jetwings[i].supportsanimscripted = 1;
    jetwings[i].animname = "halo_jetwing_" + (i + 1);
    jetwings[i] setforcenocull();
    guys[i] linkto(self, "tag_detach");
    jetwings[i] linkto(self, "tag_detach");
    guys[i] setforcenocull();
  }

  if(guys.size == 0 && jetwings.size == 0) {
    return;
  }
  self notify("halo_jump_go");
  ents = arraycombine(guys, jetwings, 0, 0);
  self maps\_anim::anim_single_aligned(ents, "halo_jump", "tag_detach");

  if(b_think) {
    for(i = 0; i < guys.size; i++) {
      guys[i] unlink();
      jetwings[i] unlink();
      guys[i] vehicle_enter(jetwings[i]);
      jetwings[i] thread halo_jump_think(goto.origin);
      jetwings[i] thread halo_jump_speed_match();
    }
  } else
    array_delete(ents);
}

halo_jump_think(origin) {
  self endon("death");
  self setneargoalnotifydist(350);
  goal = level.jetwing.origin + anglestoforward(level.jetwing.angles) * 30000;
  self setvehgoalpos(goal + (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-100, 100)), 0);
  self waittill("near_goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

halo_jump_speed_match() {
  self endon("death");

  while(isDefined(self)) {
    delta = self.origin - level.jetwing.origin;
    fwd = anglestoforward(level.jetwing.angles);
    dot = vectordot(fwd, delta);

    if(dot < 0)
      self setspeed(400, 1000, 1000);
    else
      break;

    wait 0.25;
  }

  self setspeed(80);
}

get_best_vtol() {
  vtols = getentarray("avoid_vtol", "script_noteworthy");
  fwd = anglestoforward(level.jetwing.angles);
  right = anglestoright(level.jetwing.angles);
  up = anglestoup(level.jetwing.angles);
  best_score = -99999;
  best_vtol = undefined;

  foreach(vtol in vtols) {
    if(!isDefined(vtol.claimed)) {
      delta = vtol.origin - level.jetwing.origin;
      dist = vectordot(delta, fwd);

      if(dist > 1000) {
        dist = 1.0;
        dist = dist / 50000;
        dist = 1.0 - dist;
        dir = vectornormalize(delta);
        dot = vectordot(dir, fwd);

        if(dot < 0) {
          continue;
        }
        score = dot + dist;

        if(score > best_score) {
          best_score = score;
          best_vtol = vtol;
        }
      }
    }
  }

  if(isDefined(best_vtol)) {
    circle(best_vtol.origin, 256, (1, 0, 1), 0, 1000);

    best_vtol.claimed = 1;
  }

  return best_vtol;
}

halo_jumpers_fx() {
  vtols = getentarray("avoid_vtol", "targetname");

  foreach(vtol in vtols) {
    if(vtol.health > 0)
      playfxontag(level._effect["halo_jumpers"], vtol, "tag_origin");
  }
}

explode_vtol_manager() {
  level endon("jetwing_done");

  while(true) {
    origin = level.jetwing.origin + anglestoforward(level.jetwing.angles) * 5000;
    origin = origin + anglestoright(level.jetwing.angles) * randomintrange(-10000, 10000);
    vtol = get_best_vtol();
    target = isDefined(vtol) ? vtol : undefined;
    target_offset = isDefined(vtol) ? vectorscale((0, 0, -1), 10.0) : (0, 0, 0);

    if(isDefined(target)) {
      missile = magicbullet("haiti_missile_turret_sp", origin, origin + vectorscale((0, 0, 1), 10000.0), undefined, target, target_offset);
      missile.targetent = target;
      missile thread missile_think();
    }

    wait 2;
  }
}

missile_think() {
  self endon("death");
  self endon("explode");

  while(true) {
    dist = distance(self.origin, self.targetent.origin);

    if(dist < 200)
      self resetmissiledetonationtime(0);

    wait 0.1;
  }
}

missile_think2(missile_follow_ent) {
  level endon("jetwing_land_start");
  self waittill("explode", origin);
  aerial_explosion(origin, (0, 0, 0), "none");
  rpc("clientscripts/haiti", "oxygen_mask_crack");
  level thread missile_radius_damage(origin);
}

missile_radius_damage(origin) {
  level endon("final_cloud_fog");
  level endon("jetwing_land_start");
  time = 3;
  max_time = 3;
  min_radius = 300;
  max_radius = 450;
  origin = (origin[0], origin[1], origin[2] + 100);
  missile = spawn("script_origin", origin);
  missile.alive = 1;
  missile.radius = min_radius;
  level.missile_list[level.missile_list.size] = missile;

  while(time > 0) {
    t = 1.0 - time / max_time;
    missile.radius = lerpfloat(min_radius, max_radius, t);
    radiusdamage(origin, missile.radius, 15, 10, undefined, "MOD_BURNED");
    time = time - 0.05;

    wait 0.05;
  }

  missile delete();
}

spline_vtol_think() {
  self endon("death");
  self delete();

  for(i = 0; i < 8; i++) {
    vtol = spawn("script_model", self.origin, 0, undefined, undefined, "veh_t6_v78_vtol_destructible");
    vtol.angles = self.angles;
    vtol setmodel("veh_t6_air_v78_vtol");
    vtol.targetname = self.targetname;
    vtol.script_noteworthy = self.script_noteworthy;
    vtol thread avoid_vtol_think2(self, level.avoid_drone_spawn_offsets[i]);
    vtol thread avoid_vtol_death();
  }
}

setup_landing() {
  trigger_wait("trig_start_landing");
  level thread set_cloud_fog();
  exploder(191);
  move_path();
  level notify("final_cloud_fog");
  stop_exploder(102);
  level thread set_intro_fog();
  level clientnotify("hmtx");
}

move_path() {
  wait 2;
  path_node = getvehiclenode("path_jetwing", "targetname");
  angles = vectorscale((0, -1, 0), 59.0);
  fwd = anglestoforward(angles);
  right = anglestoright(angles);
  angles = (path_node.angles[0], -59, path_node.angles[2]);
  origin = path_node.origin - fwd * 55000;
  level.jetwing pathmove(path_node, origin, angles);
  vehicles = getvehiclearray();

  foreach(vehicle in vehicles) {
    if(isalive(vehicle) && (vehicle.vehicletype == "plane_jetwing_haiti_ai" || vehicle.vehicletype == "plane_jetwing_haiti_ai_hero"))
      vehicle pathmove(path_node, origin, angles);
  }

  wait 0.25;
  spawn_clouds("section_3_cloud_struct", "jetwing_landed", level.jetwing.angles);
  spawn_clouds("section_3_locked_cloud_struct", "jetwing_landed", (63, -85, 0));
  wait 1;
}

drop_vista_think(v) {
  self endon("swap_vista");

  while(true) {
    new_pos = self.origin + v * 0.05;
    self moveto(new_pos, 0.05);
    self waittill("movedone");
  }
}

show_time() {
  time = 0;

  while(true) {
    iprintln(time);
    time = time + 0.05;
    wait 0.05;
  }
}

vtol_hatch_open() {
  level waittill("fxanim_vtol_int_open_start");
  level thread maps\createart\haiti_art::vtol_interior_door_open();
  level waittill("swap_vtol");
  level thread maps\createart\haiti_art::skydive_pre_gameplay();
  level waittill("avoid_vtols");
  level thread maps\createart\haiti_art::skydive_section_01();
  level waittill("avoid_drones");
  level thread maps\createart\haiti_art::skydive_section_02();
  level waittill("approach_facility");
  level thread maps\createart\haiti_art::skydive_landing();
}

vtol_explode2() {
  level waittill("vtol_explode2");
  wait 0.5;
  level.player thread rumble_loop(5, 0.1);
  rpc("clientscripts/haiti", "oxygen_mask_smoke");
  rpc("clientscripts/haiti", "oxygen_mask_smoke_clear");
}

player_intro_rumble() {
  level endon("avoid_vtols");

  while(true) {
    time = randomfloatrange(0.1, 0.15);
    earthquake(0.2, time, level.player.origin, 200);
    level.player playsound("exp_flak_on_plane");
    level.player playrumbleonentity("pullout_small");
    wait(time);
  }
}

player_override_damage(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(self.health - n_damage < 0)
    self.health = self.healthmax;

  return n_damage;
}

jetwing_guys_explode() {
  wait 4;
  jetwings = getentarray("ai_jetwing_usa", "targetname");
  average_pos = (0, 0, 0);
  average_pitch = 0;

  for(i = 0; i < jetwings.size; i++) {
    average_pos = average_pos + jetwings[i].origin;
    average_pitch = average_pitch + jetwings[i].angles[0];
  }

  average_pos = average_pos / jetwings.size;
  average_pitch = average_pitch / jetwings.size;
  dir = vectornormalize(jetwings[0].pathlookpos - jetwings[0].pathpos);
  pos = average_pos + dir * 1000;
  aerial_explosion(pos, (0, 0, 0), "sam_explode_cheap", 1);

  for(i = 0; i < jetwings.size; i++)
    jetwings[i] dodamage(jetwings[i].health + 1, pos);

  while(true) {
    circle(average_pos, 400, (0, 1, 1), 0, 1);
    circle(pos, 400, (1, 1, 1), 0, 1);
    line(average_pos, pos, (1, 1, 1), 0, 1);
    wait 0.05;
  }

}

#using_animtree("animated_props");

jetwing_fx_anims() {
  fx_vtol_1 = getent("fxanim_deck_vtol_4", "targetname");
  fx_vtol_debris_1 = getent("fxanim_deck_vtol_4_debris", "targetname");
  fx_vtol_debris_1 linkto(fx_vtol_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  fx_vtol_debris_1 playloopsound("evt_drone_piece_trail");
  fx_vtol_1 thread avoid_vtol_think(0, 0, 0);
  fx_vtol_2 = getent("fxanim_deck_vtol_5", "targetname");
  fx_vtol_2 setforcenocull();
  fx_vtol_2_parts = getentarray("fxanim_vtol_5_piece", "targetname");

  foreach(part in fx_vtol_2_parts) {
    part linkto(fx_vtol_2, part.fxanim_tag, (0, 0, 0), (0, 0, 0));
    part playloopsound("evt_drone_piece_trail_lt");
    part setforcenocull();
  }

  fx_vtol_2 thread avoid_vtol_think(0, 0, 0);
  fx_vtol_3 = getent("fxanim_deck_vtol_7", "targetname");
  fx_vtol_3 setforcenocull();
  fx_vtol_debris_2 = getent("fxanim_deck_vtol_7_debris", "targetname");
  fx_vtol_debris_2 hide();
  fx_vtol_debris_2 linkto(fx_vtol_3, "tag_fuselage_link_jnt", (0, 0, 0), (0, 0, 0));
  fx_vtol_debris_2 playloopsound("evt_drone_piece_trail");
  fx_vtol_debris_2 setforcenocull();
  fx_vtol_3_parts = getentarray("fxanim_vtol_7_piece", "targetname");

  foreach(part in fx_vtol_3_parts) {
    part linkto(fx_vtol_3, part.fxanim_tag, (0, 0, 0), (0, 0, 0));
    part playloopsound("evt_drone_piece_trail_lt");
    part setforcenocull();
  }

  fx_vtol_3.animname = "fxanim_props";
  fx_vtol_3 useanimtree(#animtree);
  fx_vtol_3 maps\_anim::anim_first_frame(fx_vtol_3, "jetpack_vtol_explode_4");
  fx_vtol_4 = getent("fxanim_deck_vtol_6", "targetname");
  fx_vtol_debris_3 = getent("fxanim_deck_vtol_6_debris", "targetname");
  fx_vtol_debris_3 linkto(fx_vtol_4);
  fx_vtol_debris_3 playloopsound("evt_drone_piece_trail");
  trigger_wait("trig_vtols_start_move", "targetname");
  wait 0.5;
  playfx(level._effect["vtol_explode_fxanim1"], fx_vtol_1.origin);
  playfxontag(level._effect["vtol_trail_cheap_nosmoke"], fx_vtol_1, "tag_cockpit_link_jnt");
  fx_vtol_1 notify("stop_think");
  fx_vtol_debris_1 unlink();
  level notify("fxanim_jetpack_vtol_explode_1_start");
  wait 1.5;
  fx_vtol_2 notify("stop_think");
  fx_vtol_3 notify("stop_think");
  fx_vtol_debris_2 unlink();
  playfxontag(level._effect["vtol_trail_cheap"], fx_vtol_2, "tag_engine_r_link_jnt");
  level notify("fxanim_jetpack_vtol_explode_2_start");
  wait 5;
  fx_vtol_debris_3 unlink();
  playfxontag(level._effect["vtol_trail_local"], fx_vtol_4, "tag_origin");
  fx_vtol_4 playloopsound("evt_drone_piece_trail");
  level notify("fxanim_jetpack_vtol_explode_3_start");
  wait 7;
  fx_vtol_1 delete();
  fx_vtol_debris_1 delete();
  fx_vtol_2 delete();
  fx_vtol_debris_2 delete();
  fx_vtol_3 delete();
  fx_vtol_debris_3 unlink();
  fx_vtol_4 delete();
}

explode_vtol(targetname) {
  target = getent(targetname, "targetname");

  if(isDefined(target)) {
    origin = level.jetwing.origin + anglestoforward(level.jetwing.angles) * 5000;
    origin = origin + anglestoright(level.jetwing.angles) * randomintrange(-2500, 2500);
    missile = magicbullet("haiti_missile_turret_sp", origin, origin + vectorscale((0, 0, 1), 10000.0), undefined, target, vectorscale((0, 0, 1), 15.0));
    missile.targetent = target;
    missile missile_think();
  }
}

intro_fxanims() {
  vtol_interior = getent("intro_v78_player", "targetname");
  fxanim_vtol_door = getent("fxanim_vtol_door", "targetname");
  origin = vtol_interior gettagorigin("tag_body_back");
  fxanim_vtol_door.origin = origin;
  fxanim_vtol_door linkto(vtol_interior, "tag_body_back");
  level waittill("swap_vtol");
  fxanim_vtol_door unlink();
  fxanim_vtol_door delete();
  fxanim_vtol_interior = getent("fxanim_vtol_interior", "targetname");
  fxanim_vtol_int_debris = getent("fxanim_vtol_int_debris", "targetname");
  fxanim_vtol_interior delete();
  fxanim_vtol_int_debris delete();
}

jetwing_ai_groups() {
  trigger_use("trig_jetwing_ai");
  wait 3;
  trigger_use("trig_jetwing_ai_usa_left");
  wait 3;
  trigger_use("trig_jetwing_ai_usa_right");
}

start_landing_fx() {
  level thread aerial_explosion_manager("landing", 0.5, 0.75, (2000, -2500, -1000), (7500, 2500, 1000));
  exploder(190);
  level thread landing_vtol_flock_manager("start_landing_vtols", (0, -15000, -1000), (0, 15000, 9000));
  level thread landing_vtol_flock_manager("start_landing_vtols_2", (0, -5000, -2500), (0, 5000, 2500));
  level thread landing_air_battle_manager("start_landing_vtols", (0, -15000, -1000), (0, 15000, 9000));
  level waittill("cleanup_front_door");
  stop_exploder(190);
  level notify("end_flock_manager_start_landing_vtols");
  level notify("end_air_battle_manager_start_landing_vtols");
}

landing_aa_fire() {
  level endon("end_expl_manager_landing");

  while(true) {
    origin = level.player.origin + anglestoforward(level.player.angles) * randomintrange(2000, 7500);
    origin = origin + anglestoright(level.player.angles) * randomintrange(-2500, 2500);
    origin = origin - (0, 0, randomintrange(3000, 7500));
    playfx(level._effect["aa_fire"], origin, anglestoforward((-90, randomfloatrange(-2, 2), 0)));
    wait(randomfloatrange(0.15, 0.25));
  }
}

landing_vtol_flock_manager(struct_name, min, max) {
  level endon("end_flock_manager_" + struct_name);
  vtol_spawn_struct = getstruct(struct_name, "targetname");
  fwd = anglestoforward(vtol_spawn_struct.angles);
  right = anglestoright(vtol_spawn_struct.angles);
  up = anglestoup(vtol_spawn_struct.angles);

  while(true) {
    origin = vtol_spawn_struct.origin;
    origin = origin + right * randomfloatrange(min[1], max[1]);
    origin = origin + up * randomfloatrange(min[2], max[2]);
    playfx(level._effect["vtol_flock"], origin, fwd);
    wait(randomfloatrange(5, 7));
  }
}

air_battle_manager() {
  level endon("jetwing_done");
  level endon("approach_facility");

  while(true) {
    angles = level.jetwing.angles;
    angles = (angles[0], angles[1], 0);
    origin = level.jetwing.origin + anglestoforward(angles) * randomintrange(15000, 25000);
    origin = origin + anglestoright(angles) * randomintrange(-5000, 5000);
    playfx(level._effect["air_battle_1"], origin, anglestoforward((0, randomintrange(-90, 90), 0)));
    wait(randomfloatrange(2, 4));
  }
}

landing_air_battle_manager(struct_name, min, max) {
  level endon("end_air_battle_manager_" + struct_name);
  vtol_spawn_struct = getstruct(struct_name, "targetname");
  angles = vtol_spawn_struct.angles;
  angles = (angles[0], randomfloatrange(-180, 180), angles[2]);
  fwd = anglestoforward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  while(true) {
    origin = vtol_spawn_struct.origin;
    origin = origin + right * randomfloatrange(min[1], max[1]);
    origin = origin + up * randomfloatrange(min[2], max[2]);
    playfx(level._effect["air_battle_1"], origin, fwd);
    wait(randomfloatrange(2, 3));
  }
}

spawn_clouds(struct_name, str_endon, angles) {
  structs = getstructarray(struct_name, "targetname");

  foreach(struct in structs) {
    name = "cloud_spawner";
    name = isDefined(struct.script_string) && struct.script_string == "left" ? "cloud_spawner_left" : name;
    name = isDefined(struct.script_string) && struct.script_string == "right" ? "cloud_spawner_right" : name;
    name = isDefined(struct.script_string) && struct.script_string == "locked" ? "cloud_locked" : name;
    name = isDefined(struct_name) && struct_name == "section_4_locked_cloud_struct" ? "cloud_spawner" : name;
    delta = vectornormalize(struct.origin - level.player.origin);
    yaw = vectoangles(delta);
    xy_delta = (delta[0], delta[1], 0);
    xy = length(delta);
    delta = (xy, delta[2], 0);
    pitch = vectoangles(delta);
    angles = name != "cloud_locked" ? (0, 0, 0) : struct.angles;
    ent = thread play_fx(name, struct.origin, angles, str_endon);
    ent thread cloud_ent_delete(str_endon);
  }
}

cloud_ent_delete(str_endon) {
  level waittill(str_endon);
  self delete();
}

spawn_moving_cloud(struct_name, str_endon, side) {
  level endon(str_endon);
  start = getstruct(struct_name + "_start", "targetname");
  end = getstruct(struct_name + "_end", "targetname");

  while(true) {
    mover = spawn_model("tag_origin", start.origin + (randomintrange(-150, 150), randomintrange(-150, 150), randomintrange(-400, -100)), (0, 0, 0));
    mover.script_noteworthy = "cleanup_intro";
    mover thread moving_cloud_delete(str_endon);
    name = side == "left" ? "cloud_locked_left" : "cloud_locked_right";
    playfxontag(level._effect[name], mover, "tag_origin");
    mover moveto(end.origin, randomfloatrange(8, 9), 0.05);
    wait 5;
  }
}

moving_cloud_delete(str_wait) {
  level waittill(str_wait);
  self delete();
}

#using_animtree("vehicles");

intro_jump_vtol_think() {
  self endon("death");
  self setanim( % v_vtol_flight_idle, 1, 0.1, 1);
}

pregameplay_fx() {
  level endon("avoid_vtols");
  level thread pregameplay_exposure();
  level waittill("swap_vtol");
  struct = getstruct("pregameplay_fx_struct", "targetname");
  level thread pregameplay_missiles();
  level thread aerial_explosion_manager("pregameplay", 0.5, 0.75, (2000, -2500, -1000), (7500, 2500, 1000));

  while(true) {
    origin = level.player.origin + anglestoforward(level.player.angles) * randomintrange(2000, 7500);
    origin = origin + anglestoright(level.player.angles) * randomintrange(-2500, 2500);
    origin = origin - (0, 0, randomintrange(3000, 7500));
    playfx(level._effect["aa_fire"], origin, (0, 0, 1));
    wait(randomfloatrange(0.15, 0.25));
  }
}

pregameplay_missiles() {
  level endon("avoid_vtols");

  while(true) {
    origin = level.player.origin + anglestoforward(level.player.angles) * randomintrange(2000, 7500);
    origin = origin + anglestoright(level.player.angles) * randomintrange(-2500, 2500);
    origin = origin - (0, 0, randomintrange(5000, 6000));
    magicbullet("haiti_missile_turret_intro_sp", origin, origin + (0, 0, randomintrange(5000, 7000)));
    wait(randomfloatrange(1, 2));
  }
}

pregameplay_exposure() {
  level.exposure = getdvarfloat(#"r_exposureValue");
  blend_exposure_over_time(2.25, 0.1);
  level waittill("fxanim_vtol_int_open_start");
  blend_exposure_over_time(3.5, 1.0);
  level waittill("fxanim_vtol_int_hit_start");
  blend_exposure_over_time(2.75, 1.0);
  level waittill("swap_vtol");
  blend_exposure_over_time(1.0, 1.0);
  level waittill("vtol_exterior_explosion");
  blend_exposure_over_time(level.exposure, 1.0);
  setdvar("r_exposureTweak", 0);
}

cloud_exposure(time, time_high, time_low) {
  str_prev_vision = level.player getvisionsetnaked();

  while(time > 0) {
    t_vision_1 = time_high + randomfloatrange(0, 0.2);
    level.player visionsetnaked("sp_haiti_clouds_01", t_vision_1);
    wait(t_vision_1);
    t_vision_2 = time_low + randomfloatrange(0, 0.2);
    level.player visionsetnaked("sp_haiti_clouds_02", t_vision_2);
    wait(t_vision_2);
    time = time - (t_vision_1 + t_vision_2);
  }

  level.player visionsetnaked(str_prev_vision, 0.25);
}

assemble_vtol_explode2() {
  parent = getent("vtol_explode2", "targetname");
  pieces = getentarray("vtol_explode2_piece", "targetname");

  foreach(piece in pieces)
  piece linkto(parent, piece.fxanim_tag, (0, 0, 0), (0, 0, 0));
}

set_cloud_fog() {
  if(isDefined(level.drop_vista_1))
    level.drop_vista_1 setclientflag(6);

  if(isDefined(level.drop_vista_2))
    level.drop_vista_2 setclientflag(6);

  rpc("clientscripts/haiti", "set_cloud_fog");
}

set_intro_fog() {
  rpc("clientscripts/haiti", "set_intro_fog");
  wait 0.05;

  if(isDefined(level.drop_vista_1))
    level.drop_vista_1 clearclientflag(6);

  if(isDefined(level.drop_vista_2))
    level.drop_vista_2 clearclientflag(6);
}

avoid_pieces() {
  wait 3;
  tail = spawn_vehicle_from_targetname("avoid_vtol_tail");
}

avoid_vtol_piece_think(fx_tag, offset, speed, angular_velocity) {
  self endon("death");
  self notify("nodeath_thread");
  self godon();
  self.overridedamage = ::vtol_piece_override_damage;
  angles = level.jetwing.angles;
  angles = (angles[0], angles[1], 0);
  fwd = anglestoforward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  self.origin = level.jetwing.origin + fwd * offset[0] + right * offset[1] + up * offset[2];
  path_angles = getvehiclenode("path_jetwing", "targetname").angles;
  path_dir = anglestoforward(path_angles);
  self setphysangles(path_angles);
  playfxontag(level._effect["vtol_trail_cheap"], self, fx_tag);
  self setvehvelocity(path_dir * (80 + speed) * 17.6);
  self setangularvelocity(angular_velocity);
  level waittill("jetwing_done");
  self delete();
}

vtol_piece_override_damage(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  n_damage = 0;
  return n_damage;
}

intro_save_restore() {
  if(flag("avoid_vtols") && !flag("avoid_missiles")) {
    spawn_clouds("section_1_cloud_struct", "avoid_drones", getvehiclenode("path_jetwing", "targetname").angles);
    spawn_clouds("section_1_locked_cloud_struct", "swap_vista", getvehiclenode("path_jetwing", "targetname").angles);
  } else if(flag("avoid_missiles") && !flag("landed")) {
    spawn_clouds("section_2_cloud_struct", "jetwing_land_start", level.jetwing.angles);
    spawn_clouds("section_2_locked_cloud_struct", "jetwing_land_start", getvehiclenode("path_jetwing", "targetname").angles);
  }
}

intro_vo() {
}

avoid_vtols_vo() {
  wait 2;
  level.player say_dialog("sect_control_your_descent_0");
  wait 3;

  if(level.is_harper_alive)
    level.harper say_dialog("harp_stay_out_of_their_fu_0");
}

avoid_missiles_vo() {
  lines = [];
  lines = array("sect_avoid_the_missiles_0", "usr0_missiles_are_still_c_0");
  wait 2;

  foreach(line in lines) {
    level.player say_dialog(line);
    wait 7;
  }

  trigger_wait("trig_start_landing");
  wait 4;
  level.player say_dialog("sect_taking_fire_from_gro_0");
}