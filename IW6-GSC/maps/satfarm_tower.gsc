/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_tower.gsc
*****************************************************/

tower_init() {
  level.start_point = "tower";
  objective_add(maps\_utility::obj("rendesvouz"), "invisible", & "SATFARM_OBJ_RENDESVOUZ");
  objective_state_nomessage(maps\_utility::obj("rendesvouz"), "done");
  objective_add(maps\_utility::obj("reach_air_strip"), "invisible", & "SATFARM_OBJ_REACH_AIR_STRIP");
  objective_state_nomessage(maps\_utility::obj("reach_air_strip"), "done");
  objective_add(maps\_utility::obj("air_strip_defenses"), "invisible", & "SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES");
  objective_state_nomessage(maps\_utility::obj("air_strip_defenses"), "done");
  objective_add(maps\_utility::obj("launch_missile"), "current", & "SATFARM_OBJ_LAUNCH_MISSILE");
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_tower", 0);
}

post_missile_launch_init() {
  level.start_point = "post_missile_launch";
  objective_add(maps\_utility::obj("rendesvouz"), "invisible", & "SATFARM_OBJ_RENDESVOUZ");
  objective_state_nomessage(maps\_utility::obj("rendesvouz"), "done");
  objective_add(maps\_utility::obj("reach_air_strip"), "invisible", & "SATFARM_OBJ_REACH_AIR_STRIP");
  objective_state_nomessage(maps\_utility::obj("reach_air_strip"), "done");
  objective_add(maps\_utility::obj("air_strip_defenses"), "invisible", & "SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES");
  objective_state_nomessage(maps\_utility::obj("air_strip_defenses"), "done");
  objective_add(maps\_utility::obj("launch_missile"), "current", & "SATFARM_OBJ_LAUNCH_MISSILE");
  objective_state_nomessage(maps\_utility::obj("launch_missile"), "done");
  objective_add(maps\_utility::obj("train"), "current", & "SATFARM_OBJ_TRAIN");
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_tower_02", 0);
}

warehouse_init() {
  level.start_point = "warehouse";
  objective_add(maps\_utility::obj("rendesvouz"), "invisible", & "SATFARM_OBJ_RENDESVOUZ");
  objective_state_nomessage(maps\_utility::obj("rendesvouz"), "done");
  objective_add(maps\_utility::obj("reach_air_strip"), "invisible", & "SATFARM_OBJ_REACH_AIR_STRIP");
  objective_state_nomessage(maps\_utility::obj("reach_air_strip"), "done");
  objective_add(maps\_utility::obj("air_strip_defenses"), "invisible", & "SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES");
  objective_state_nomessage(maps\_utility::obj("air_strip_defenses"), "done");
  objective_add(maps\_utility::obj("launch_missile"), "current", & "SATFARM_OBJ_LAUNCH_MISSILE");
  objective_state_nomessage(maps\_utility::obj("launch_missile"), "done");
  objective_add(maps\_utility::obj("train"), "current", & "SATFARM_OBJ_TRAIN");
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_warehouse", 0);
}

tower_main() {
  if(level.start_point == "tower") {
    maps\satfarm_code::spawn_player_checkpoint("tower");
    maps\satfarm_code::spawn_allies();
    maps\_utility::battlechatter_on("axis");
    thread breach_setup();
    thread ambient_building_explosions("breach_start");
  }

  common_scripts\utility::flag_set("tower_begin");
  thread tower_begin();
  common_scripts\utility::flag_wait("tower_end");
  maps\_spawner::killspawner(200);
}

tower_begin() {
  thread breach_outside_ambience();
  thread breach();
  thread breach_combat();
  thread missile_launch_setup();
  thread hologram_table();
  level thread maps\satfarm_audio::tower_door_listen();
  level thread maps\satfarm_audio::tower_windows();
  thread allies_movement_tower();
  maps\_utility::autosave_by_name("tower");
  common_scripts\utility::flag_wait("missile_launch_start");
  common_scripts\utility::flag_set("tower_end");
}

post_missile_launch_main() {
  if(level.start_point == "post_missile_launch") {
    maps\satfarm_code::spawn_player_checkpoint("post_missile_launch");
    maps\satfarm_code::spawn_allies();
    maps\_utility::battlechatter_on("axis");
    thread ambient_building_explosions("building_hit");
  }

  level.warehouse_elevator_mantle_right = getent("warehouse_elevator_mantle_right", "script_noteworthy");
  level.warehouse_elevator_mantle_right hide();
  level.warehouse_elevator_mantle_right notsolid();
  level.warehouse_elevator_mantle_left = getent("warehouse_elevator_mantle_left", "script_noteworthy");
  level.warehouse_elevator_mantle_left hide();
  level.warehouse_elevator_mantle_left notsolid();
  var_0 = getent("elevator_top_crate", "script_noteworthy");
  var_1 = getEntArray("elevator_bottom_crates", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 retargetscriptmodellighting(var_0);

  common_scripts\utility::flag_set("post_missile_launch_begin");
  thread post_missile_launch_begin();
  common_scripts\utility::flag_wait("post_missile_launch_end");
  maps\_spawner::killspawner(201);
  maps\satfarm_code::kill_vehicle_spawners_now(201);
}

post_missile_launch_begin() {
  thread loading_bay_combat();
  thread elevator_room_combat();
  thread allies_movement_post_missile_launch();
  common_scripts\utility::flag_wait("post_missile_launch_breach_done");
  maps\_utility::autosave_by_name("post_missile_launch");
  common_scripts\utility::flag_wait("elevator_room_cleared");
  common_scripts\utility::flag_set("post_missile_launch_end");
}

warehouse_main() {
  if(level.start_point == "warehouse") {
    maps\satfarm_code::spawn_player_checkpoint("warehouse");
    maps\satfarm_code::spawn_allies();
    maps\_utility::battlechatter_on("axis");
    level.player_elevator_clip_back = getent("player_elevator_clip_back", "targetname");
    level.player_elevator_clip_back notsolid();
    thread ambient_building_explosions("warehouse_end");
    safe_activate_trigger_with_targetname("move_allies_into_elevator");
    var_0 = getent("missile_launch_missile", "targetname");
    var_0 delete();
    level.ally_elevator_clip_back = getent("ally_elevator_clip_back", "targetname");
    level.warehouse_elevator_mantle_right = getent("warehouse_elevator_mantle_right", "script_noteworthy");
    level.warehouse_elevator_mantle_right hide();
    level.warehouse_elevator_mantle_right notsolid();
    level.warehouse_elevator_mantle_left = getent("warehouse_elevator_mantle_left", "script_noteworthy");
    level.warehouse_elevator_mantle_left hide();
    level.warehouse_elevator_mantle_left notsolid();
    var_1 = getent("elevator_top_crate", "script_noteworthy");
    var_2 = getEntArray("elevator_bottom_crates", "script_noteworthy");

    foreach(var_4 in var_2)
    var_4 retargetscriptmodellighting(var_1);
  }

  maps\satfarm_code::kill_spawners_per_checkpoint("warehouse");
  thread check_trigger_flagset("advance_allies_wave_2_trigger");
  thread check_trigger_flagset("advance_allies_wave_3_trigger");
  thread check_trigger_flagset("advance_allies_wave_3a_trigger");
  thread check_trigger_flagset("advance_allies_wave_4_trigger");
  common_scripts\utility::flag_set("warehouse_begin");
  thread warehouse_begin();
  common_scripts\utility::flag_wait("warehouse_end");
  maps\_hud_util::fade_out(1);
  tower_to_bridge_deploy_bink();
}

warehouse_begin() {
  thread warehouse_elevator();
  thread warehouse_combat();
  thread exit_on_train();
  thread allies_movement_warehouse();
}

breach() {
  level.player endon("death");
  common_scripts\utility::flag_wait("ready_for_breach");
  wait 1.5;
  var_0 = getEntArray("breach_doors", "targetname");
  var_1 = undefined;
  level.saf_exit_door_right_obj show();
  common_scripts\utility::flag_wait("control_room_enemies_dead");
  var_2 = getent("breach_door_trigger", "targetname");
  var_1 = common_scripts\utility::getstruct("breach_door_lookat", "targetname");

  if(level.player common_scripts\utility::is_player_gamepad_enabled())
    var_2 sethintstring(&"SATFARM_BREACH_CONSOLE");
  else
    var_2 sethintstring(&"SATFARM_BREACH");

  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_2, var_1, cos(40));
  common_scripts\utility::flag_set("breach_start");
  level.saf_exit_door_right_obj delete();
  level.player common_scripts\utility::_disableweapon();
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  var_3 = level.player common_scripts\utility::spawn_tag_origin();
  level.player playerlinktoblend(var_3, "tag_origin", 0.2, 0.1, 0.1);
  level.player playerlinktodelta(var_3, "tag_origin", 1, 0, 0, 0, 0, 1);
  var_4 = common_scripts\utility::getstruct("breach_start_pos", "targetname");
  var_3 moveto(var_4.origin, 0.75, 0, 0);
  var_3 rotateto(var_4.angles, 0.75, 0, 0);
  level waittill("door_knockdown");
  common_scripts\utility::flag_set("start_breach_outside_ambience");
  var_5 = getent("breach_door_clip", "targetname");
  var_5 notsolid();
  var_5 connectpaths();
  level.slomobreachduration = 3.5;
  thread fire_extinguisher_breach_slowmo();
  var_6 = common_scripts\utility::getstruct("breach_door_pos", "targetname");
  var_3 moveto(var_6.origin, 0.75, 0, 0);
  var_3 rotateto(var_6.angles, 0.75, 0, 0);
  thread give_power_back();
  wait 0.75;
  level.player unlink();
  level waittill("slowmo_breach_ending");
  var_3 delete();
  level.player allowcrouch(1);
  level.player allowprone(1);
  thread ambient_building_explosions("missile_launch_start");

  if(isDefined(var_5))
    var_5 delete();
}

fire_extinguisher_breach_slowmo() {
  var_0 = 0.5;
  var_1 = 0.75;
  var_2 = 0.2;
  var_3 = level.player;
  var_3 thread maps\_utility::play_sound_on_entity("slomo_whoosh_in");
  var_3 thread player_heartbeat();
  common_scripts\utility::flag_clear("can_save");
  var_3 allowmelee(0);
  maps\_utility::slowmo_setspeed_slow(0.25);
  maps\_utility::slowmo_setlerptime_in(var_0);
  maps\_utility::slowmo_lerp_in();
  var_3 setmovespeedscale(var_2);
  var_4 = gettime();
  var_5 = var_4 + level.slomobreachduration * 1000;
  var_3 thread catch_weapon_switch();
  var_6 = 500;
  var_7 = 1000;

  for(;;) {
    if(gettime() >= var_5) {
      break;
    }

    if(level.breachenemies_active <= 0) {
      var_1 = 1.15;
      break;
    }

    if(var_3.lastreloadstarttime >= var_4 + var_6) {
      break;
    }

    if(var_3.switchedweapons && gettime() - var_4 > var_7) {
      break;
    }

    wait 0.05;
  }

  level notify("slowmo_breach_ending", var_1);
  level notify("stop_player_heartbeat");
  var_3 thread maps\_utility::play_sound_on_entity("slomo_whoosh_out");
  maps\_utility::slowmo_setlerptime_out(var_1);
  maps\_utility::slowmo_lerp_out();
  var_3 allowmelee(1);
  common_scripts\utility::flag_set("can_save");
  var_3 slowmo_player_cleanup();
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

catch_weapon_switch() {
  level endon("slowmo_breach_ending");
  self.switchedweapons = 0;
  common_scripts\utility::waittill_any("weapon_switch_started", "night_vision_on", "night_vision_off");
  self.switchedweapons = 1;
}

slowmo_player_cleanup() {
  if(isDefined(level.playerspeed))
    self setmovespeedscale(level.playerspeed);
  else
    self setmovespeedscale(1);
}

give_power_back() {
  level.player endon("death");
  wait 0.65;
  level.player lerpviewangleclamp(0.25, 0, 0, 45, 45, 90, 45);
  level.player common_scripts\utility::_enableweapon();
}

breach_combat() {
  common_scripts\utility::flag_wait("breach_start");
  level.breachenemies_active = 0;
  maps\_utility::array_spawn_function_targetname("satfarm_breach_enemies", ::breach_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("satfarm_breach_enemies", 1);
  maps\_utility::array_spawn_function_targetname("dead_guy", ::dead_guy);
  maps\_utility::spawn_targetname("dead_guy", 1);
  thread maps\satfarm_code::cleanup_enemies("player_in_loading_bay", var_0);
  maps\_utility::waittill_dead_or_dying(var_0);
  common_scripts\utility::flag_set("breach_room_enemies_dead");
}

disable_aimassist() {
  self disableaimassist();
  common_scripts\utility::flag_wait_either("player_shot_extinguisher", "ghost1_shot_extinguisher");
  self enableaimassist();
}

breach_enemy_setup() {
  thread waittill_breach_enemy_dead();
  self.animname = "generic";
  self.ignoreall = 1;
  self.health = 50;
  maps\_utility::disable_surprise();
  self.accuracy = 0.01;
  self.baseaccuracy = 0.01;
  self.struct = common_scripts\utility::getstruct(self.script_noteworthy + "_struct", "targetname");

  if(self.script_noteworthy == "breach_guy_1") {
    self.animation = "payback_breach_doorguy";
    thread fire_extinguisher_death("satfarm_tower_breach_guard_breach");
    self.struct maps\_anim::anim_first_frame_solo(self, self.animation);
  }

  if(self.script_noteworthy == "breach_guy_2") {
    self.animation = "breach_react_push_guy1";
    self.ready_for_deathanim = 1;
    thread fire_extinguisher_death("exposed_death_blowback");
    self.struct maps\_anim::anim_first_frame_solo(self, self.animation);
  }

  if(self.script_noteworthy == "breach_guy_3") {
    self.animation = "breach_react_push_guy2";
    thread fire_extinguisher_death("exposed_crouch_death_twist");
    self.struct maps\_anim::anim_first_frame_solo(self, self.animation);
  }

  if(self.script_noteworthy == "breach_guy_4") {
    self.animation = "parabolic_phoneguy_reaction";
    self.ready_for_deathanim = 1;
    thread fire_extinguisher_death("exposed_death_twist");
    self.struct maps\_anim::anim_first_frame_solo(self, self.animation);
  }

  if(self.script_noteworthy == "breach_rpg_guy")
    level.breach_rpg_guy = self;

  level waittill("door_knockdown");
  self endon("death");
  self.allowdeath = 1;

  if(self.script_noteworthy != "breach_rpg_guy")
    thread enemy_breach_anims();
  else
    breach_rpg_guy();

  self.ignoreall = 0;
  common_scripts\utility::flag_wait_either("player_shot_extinguisher", "ghost1_shot_extinguisher");
  wait 0.1;

  if(common_scripts\utility::flag("ghost1_shot_extinguisher")) {
    self.favoriteenemy = level.player;
    self.accuracy = 0.2;
    self.baseaccuracy = 2;
  }
}

breach_rpg_guy() {
  self endon("death");
  self.nodrop = 1;
  self.noragdoll = 1;
  wait 0.75;
  var_0 = getent("rpg_scripted_target", "targetname");
  self setentitytarget(var_0);
  self shoot();
  wait 1.5;
  self clearentitytarget();
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  maps\_utility::forceuseweapon(self.secondaryweapon, "secondary");
  var_1 = getnode("breach_rpg_node", "targetname");
  self setgoalnode(var_1);
}

ignored_by_friendlies() {
  self endon("death");
  self.ignoreme = 1;
  level waittill("slomo_breach_over");

  if(isDefined(self))
    self.ignoreme = 0;
}

waittill_breach_enemy_dead() {
  level.breachenemies_active++;
  self waittill("death");
  level.breachenemies_active--;
}

fire_extinguisher_death(var_0) {
  level endon("ghost1_at_table");
  common_scripts\utility::flag_wait_either("player_shot_extinguisher", "ghost1_shot_extinguisher");

  if(self.script_noteworthy == "breach_guy_3") {
    if(!isDefined(self.ready_for_deathanim))
      return;
  }

  self.deathanim = maps\_utility::getanim_generic(var_0);
}

enemy_breach_anims() {
  self endon("death");
  self.struct thread maps\_anim::anim_single_solo(self, self.animation);

  if(self.script_noteworthy == "breach_guy_1") {
    wait 2.0;
    self.ready_for_deathanim = 1;
  }

  if(self.script_noteworthy == "breach_guy_3") {
    self waittillmatch("single anim", "bodyfall small");
    self.ready_for_deathanim = 1;
  }

  self waittillmatch("single anim", "end");
}

dead_guy() {
  self.animname = "generic";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.team = "neutral";
  self setCanDamage(0);
  maps\_utility::gun_remove();
  level.breach_anim_struct thread maps\_anim::anim_loop_solo(self, "satfarm_tower_launch_dead_loop", "stop_dead_guy_loop");
  common_scripts\utility::flag_wait("missile_launched");
  level.breach_anim_struct notify("stop_dead_guy_loop");
  level.breach_anim_struct thread maps\_anim::anim_single_solo(self, "satfarm_tower_launch_dead_exit");

  while(self getanimtime(maps\_utility::getanim("satfarm_tower_launch_dead_exit")) < 0.95)
    wait 0.05;

  maps\_anim::anim_set_rate_single(self, "satfarm_tower_launch_dead_exit", 0);
  common_scripts\utility::flag_wait("player_in_loading_bay");
  self delete();
}

missile_launch_setup() {
  var_0 = maps\_utility::spawn_anim_model("player_arms");
  var_0 hide();
  var_1 = getent("missile_launch_button_panel", "targetname");
  var_1.animname = "missile_button_panel";
  var_1 maps\_anim::setanimtree();
  var_2 = getent("missile_launch_button", "targetname");
  var_2.animname = "missile_button";
  var_2 maps\_anim::setanimtree();
  var_3 = getent("missile_launch_button_lit", "targetname");
  var_3.animname = "missile_button_lit";
  var_3 maps\_anim::setanimtree();
  var_3 hide();
  var_4 = getent("missile_launch_button_panel_obj", "targetname");
  var_4.animname = "missile_button_panel_obj";
  var_4 maps\_anim::setanimtree();
  var_4 hide();
  var_5 = [];
  var_5[0] = var_0;
  var_5[1] = var_1;
  var_5[2] = var_2;
  var_5[3] = var_3;
  var_5[4] = var_4;
  level.breach_anim_struct maps\_anim::anim_first_frame(var_5, "missile_launch_button_press");
  common_scripts\utility::flag_wait("ready_to_launch");
  var_4 show();
  common_scripts\utility::exploder(6007);
  var_2 hide();
  var_3 show();
  var_6 = getent("missile_launch_trigger", "targetname");

  if(level.player common_scripts\utility::is_player_gamepad_enabled())
    var_6 sethintstring(&"SATFARM_MISSILE_LAUNCH_CONSOLE");
  else
    var_6 sethintstring(&"SATFARM_MISSILE_LAUNCH");

  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_6, var_2, cos(40));
  common_scripts\utility::flag_set("missile_launch_start");
  level thread maps\satfarm_audio::launch_button();
  level.player common_scripts\utility::_disableweapon();
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() != "stand")
    level.player setstance("stand");

  var_4 hide();
  wait 0.1;
  level.player playerlinktoblend(var_0, "tag_player", 0.5);
  level.breach_anim_struct thread maps\_anim::anim_single(var_5, "missile_launch_button_press");
  wait 0.5;
  var_0 show();
  var_0 waittillmatch("single anim", "satfarm_tower_launch_player");
  thread missile_launch();
  var_0 waittillmatch("single anim", "end");
  var_0 delete();
  level.player common_scripts\utility::_enableweapon();
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  wait 2;
  maps\_utility::stop_exploder(6007);
  var_2 show();
  var_3 delete();
  var_4 delete();
  wait 2;
  thread ambient_building_explosions("building_hit");
}

missile_launch() {
  level thread maps\satfarm_audio::end_missile_launch_alarm();
  level thread maps\satfarm_audio::end_missile_launch_hatch();
  var_0 = getEntArray("silo_doors", "targetname");
  common_scripts\utility::array_thread(var_0, ::missile_silo_doors);
  common_scripts\utility::flag_wait("silo_doors_open");
  var_1 = common_scripts\utility::getstruct("missile_launch_tube_fx_struct", "targetname");
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  playFXOnTag(level._effect["launchtube_steam"], var_2, "tag_origin");
  var_3 = getent("missile_launch_missile", "targetname");
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_3, "polysurface24", (0, 400, 55), (-180, -90, 0));
  thread common_scripts\utility::play_sound_in_space("satf_end_missile_launch", (-6199, 55839, 157));
  thread common_scripts\utility::play_sound_in_space("satf_launch_rattles", level.player.origin);
  level.player playrumbleonentity("missile_launch");
  earthquake(0.3, 15, var_3.origin, 3000);
  playFXOnTag(level._effect["smoke_geotrail_missile_large"], var_4, "tag_origin");
  common_scripts\utility::exploder(6001);
  thread missile_launch_missile(var_3, var_4);
  thread missile_launch_visionset();
  wait 4;
  common_scripts\utility::flag_set("missile_launched");
  maps\_utility::objective_complete(maps\_utility::obj("launch_missile"));
  stopFXOnTag(level._effect["launchtube_steam"], var_2, "tag_origin");
}

missile_launch_visionset() {
  wait 1;
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_missile_launch", 1);
  wait 8;
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_tower_02", 1);
}

missile_silo_doors() {
  self.animname = "silo_doors";
  maps\_anim::setanimtree();
  thread maps\_anim::anim_single_solo(self, "silo_doors_open");
  self waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("silo_doors_open"))
    common_scripts\utility::flag_set("silo_doors_open");
}

missile_launch_missile(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 400; var_2 < 3; var_3 = var_3 + 2) {
    var_0 moveto(var_0.origin + (0, 0, var_3), 1);
    wait 1;
    var_2++;
  }

  while(var_2 < 80 && !common_scripts\utility::flag("player_in_loading_bay")) {
    var_0 moveto(var_0.origin + (0, 0, var_3), 1);
    wait 1;
    var_2++;
    var_3 = var_3 + 202;
  }

  stopFXOnTag(level._effect["smoke_geotrail_missile_large"], var_1, "tag_origin");
  var_1 delete();
  var_0 delete();
}

hologram_table() {
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingameloopresident("satfarm_holo_1");
  common_scripts\utility::flag_wait("trajectory_updated");
  wait 3;
  stopcinematicingame();
  cinematicingameloopresident("satfarm_holo_2");
  common_scripts\utility::flag_wait("player_in_loading_bay");
  stopcinematicingame();
}

breach_outside_ambience() {
  common_scripts\utility::flag_wait("start_breach_outside_ambience");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("breach_ally_tank_rpg_target");
  common_scripts\utility::exploder(4001);
  thread ambient_drones();
  thread ambient_breach_tank_a10_pass();
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("breach_enemy_fight_tanks");
  common_scripts\utility::array_thread(var_1, ::breach_ally_tank_fight_logic);
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::dumb_tank_shoot);
  level.tank_targets = 0;
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("breach_ally_fight_tanks");
  common_scripts\utility::array_thread(var_2, ::breach_ally_tank_fight_logic);
  thread ambient_choppers();
  common_scripts\utility::flag_wait("tank_enemies_killed");
  wait 4;
  thread ambient_ally_tanks();
}

ambient_drones() {
  var_0 = getEntArray("breach_ally_drones_once", "targetname");
  common_scripts\utility::array_thread(var_0, ::spawn_a_drone);
  common_scripts\utility::flag_wait("show_mantis_turrets");
  var_0 = getEntArray("breach_ally_drones", "targetname");
  common_scripts\utility::array_thread(var_0, ::breach_ally_drones_drone_think, "building_hit");
}

breach_ally_drones_drone_think(var_0) {
  level endon(var_0);
  var_1 = randomintrange(1, 2);

  for(;;) {
    for(var_2 = 0; var_2 < var_1; var_2++) {
      thread spawn_a_drone();
      wait(randomfloatrange(0.4, 0.7));
    }

    wait(randomfloatrange(20, 26));
  }
}

spawn_a_drone() {
  wait(randomfloatrange(0.6, 0.8));
  var_0 = maps\_utility::dronespawn();
}

ambient_breach_tank_a10_pass() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambient_breach_enemy_tanks");
  wait 6;
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("breach_a10s");
}

ambient_choppers() {
  wait 4;
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambient_breach_ally_chopper");
  wait 20;
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambient_breach_ally_chopper_2");
  thread ambient_vehicle_spawning("building_hit", 30, "ambient_breach_ally_chopper");
  thread ambient_vehicle_spawning("building_hit", 20, "ambient_breach_ally_chopper_2");
}

ambient_ally_tanks() {
  wait 4;
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambient_breach_ally_tanks");
  common_scripts\utility::flag_wait("missile_launched");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambient_breach_ally_tanks_2");
  thread ambient_vehicle_spawning("building_hit", 20, "ambient_breach_ally_tanks_2");
}

ambient_vehicle_spawning(var_0, var_1, var_2) {
  level endon(var_0);

  for(;;) {
    wait(var_1);
    maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_2);
  }
}

breach_ally_tank_fight_logic() {
  self endon("death");
  maps\_utility::ent_flag_init("kill_target");

  if(self.script_noteworthy == "breach_enemy_tank_1") {
    level.breach_enemy_tank_1 = self;
    return;
  } else if(self.script_noteworthy == "breach_enemy_tank_2") {
    level.breach_enemy_tank_2 = self;
    return;
  }

  if(self.script_noteworthy == "breach_ally_tank_1")
    self.tank_target = level.breach_enemy_tank_1;
  else if(self.script_noteworthy == "breach_ally_tank_2")
    self.tank_target = level.breach_enemy_tank_2;

  thread maps\satfarm_code::dumb_tank_shoot("stop_shooting");
  maps\_utility::ent_flag_wait("kill_target");
  self notify("stop_shooting");
  maps\satfarm_code::shoot_anim();

  if(isalive(self.tank_target))
    self.tank_target kill();

  level.tank_targets++;

  if(level.tank_targets == 2)
    common_scripts\utility::flag_set("tank_enemies_killed");
}

entity_cleanup(var_0) {
  if(isDefined(var_0))
    common_scripts\utility::flag_wait(var_0);

  if(isDefined(self))
    self delete();
}

play_idle_anims(var_0) {
  self endon("death");
  self endon("alerted");
  self.struct maps\_anim::anim_generic_loop(self, self.idleanim, "stop_loop");
}

enemies_shot_at(var_0, var_1, var_2) {
  self endon("death");
  level endon(var_2);
  common_scripts\utility::flag_wait(var_1);
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  common_scripts\utility::waittill_any("ai_event", "flashbang");
  common_scripts\utility::flag_set(var_2);
}

alert_enemies_react() {
  self endon("death");
  wait(randomfloatrange(0.1, 0.3));
  self notify("alerted");

  if(isDefined(self.struct))
    self.struct notify("stop_loop");

  self notify("stop_loop");
  self stopanimscripted();
  self clearentitytarget();

  if(isDefined(self.gun_removed))
    maps\_utility::gun_recall();

  if(isDefined(self.attached_item))
    self detach(self.attached_item, "TAG_INHAND");

  if(isDefined(self.reactanim))
    maps\_anim::anim_single_solo(self, self.reactanim);

  self.ignoreme = 0;
  self.ignoreall = 0;
  self cleargoalvolume();
}

watch_for_death() {
  self waittill("death");

  if(isDefined(self.attached_item))
    self detach(self.attached_item, "TAG_INHAND");
}

allies_movement_tower() {
  thread allies_vo_tower();

  if(level.start_point == "tower")
    common_scripts\utility::flag_set("control_room_enemies_dead");

  common_scripts\utility::flag_wait("control_room_enemies_dead");
  maps\_utility::autosave_by_name("javelin_nest");

  if(level.start_point != "tower")
    maps\_utility::activate_trigger_with_targetname("move_allies_to_control_room_exit");

  common_scripts\utility::flag_set("turn_move_allies_to_breach_entrance_trigger_on");
  thread allies_start_cqb();
  common_scripts\utility::flag_wait("move_ghost1_to_breach");
  level thread maps\satfarm_audio::fire_ext_grab();
  var_0 = getnode("ghost1_breach_node", "targetname");
  level.allies[0] setgoalnode(var_0);
  level.allies[0] waittill("goal");
  level.allies[0] thread super_human(1);
  level.allies[0] thread breach_allies();
  common_scripts\utility::flag_wait("breach_room_enemies_dead");
  maps\_utility::autosave_by_name("post_breach");
  wait 0.5;
  level.allies[0] thread missile_launch_allies();
}

allies_vo_tower() {
  if(level.start_point != "tower") {
    common_scripts\utility::flag_wait("control_room_enemies_dead");
    maps\_utility::battlechatter_off("allies");
    maps\_utility::flavorbursts_off("allies");
    wait 1.5;
    level.allies[0] maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_wereclear");
    wait 0.5;
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_commandweveenteredthe");
    wait 0.5;
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_copyghostone");
  }

  common_scripts\utility::flag_wait("ready_for_breach");

  if(!common_scripts\utility::flag("player_in_breach_hallway"))
    common_scripts\utility::flag_wait("player_in_breach_hallway");

  level thread maps\satfarm_audio::tower_door_listen_2();
  thread breach_nag();
  level waittill("launch_room_secure_notify");
  wait 0.5;
  wait 3;
  thread common_scripts\utility::play_sound_in_space("satf_command_table_transition", (-4907, 53783, 266));
  common_scripts\utility::flag_set("trajectory_updated");
  level waittill("trajectory_updated_notify");
  common_scripts\utility::flag_set("show_mantis_turrets");
  level waittill("be_advised_notify");
  wait 3.25;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_understoodsendingbadger");
  wait 2.5;
  common_scripts\utility::flag_set("ready_to_launch");
  wait 1.0;
  var_0 = maps\_utility::make_array("satfarm_hsh_launchthewarhead", "satfarm_hsh_loganlaunchit");
  level.allies[0] thread nag_until_flag(var_0, "missile_launch_start", 10, 15, 5);
  common_scripts\utility::flag_wait("missile_launched");
  thread maps\satfarm_code::satfarm_timer(540, undefined, 180);
  level waittill("payload_is_away_notify");
  wait 3.5;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_overlordcopiesallgood_2");
  wait 1;
  thread common_scripts\utility::play_sound_in_space("satfarm_rke_ineedsquadscovering", (-4587, 54299, 241));
  wait 1.75;
  common_scripts\utility::flag_set("bad_guy_on_radio");
  level waittill("you_hear_this_notify");
  wait 5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_merrickthemissilesaway");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_mrk_negativeheshreturnto");
  level.allies[0] maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_sorrymerrickyourmission");
  wait 0.5;
  level.allies[0] thread maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_letsgetthisbastard");
  maps\_utility::delaythread(0.5, maps\_utility::music_crossfade, "mus_sfarm_battle_to_train", 1.0);
  wait 1;
  objective_add(maps\_utility::obj("train"), "current", & "SATFARM_OBJ_TRAIN");
}

breach_nag() {
  wait 8;

  if(!common_scripts\utility::flag("breach_start"))
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_inpositiononyour");
}

nag_until_flag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  for(var_5 = -1; !common_scripts\utility::flag(var_1); var_3 = var_3 + var_4) {
    var_6 = randomfloatrange(var_2, var_3);
    wait(var_6);
    var_7 = randomint(var_0.size);

    if(var_7 == var_5) {
      var_7++;

      if(var_7 >= var_0.size)
        var_7 = 0;
    }

    var_8 = var_0[var_7];

    if(common_scripts\utility::flag(var_1)) {
      break;
    }

    maps\_utility::smart_dialogue(var_8);
    var_5 = var_7;
  }
}

allies_start_cqb() {
  common_scripts\utility::flag_wait("allies_start_cqb_walk");
  level.allies[0] maps\_utility::enable_cqbwalk();
}

breach_allies() {
  var_0 = [];
  var_0[0] = self;
  var_0[1] = level.fire_extinguisher;
  level.fire_extinguisher_aim_ent notsolid();
  level.breach_anim_struct thread maps\_anim::anim_single(var_0, "breach_enter");
  wait 3;
  common_scripts\utility::flag_set("ready_for_breach");
  self waittillmatch("single anim", "end");
  level.breach_anim_struct thread maps\_anim::anim_loop(var_0, "breach_loop", "stop_breach_loop");
  common_scripts\utility::flag_wait("breach_start");
  wait 0.75;
  level.breach_anim_struct notify("stop_breach_loop");
  var_0[2] = level.breach_door_rig;
  level.breach_anim_struct thread maps\_anim::anim_single(var_0, "breach_breach");
  self waittillmatch("single anim", "door_contact");
  level thread maps\satfarm_audio::tower_door_breach();
  level notify("door_knockdown");
  common_scripts\utility::exploder(6006);
  thread breach_door_clips();
  level.fire_extinguisher setCanDamage(1);
  level.fire_extinguisher.allowdeath = 1;
  level.fire_extinguisher thread fire_extinguisher_shot();
  level.fire_extinguisher_aim_ent solid();
  level.fire_extinguisher_aim_ent enableaimassist();
  level.fire_extinguisher_aim_ent setCanDamage(1);
  level.fire_extinguisher_aim_ent thread watch_damage();
  self waittillmatch("single anim", "ex_toss");
  level.fire_extinguisher thread set_anim_rate_on_fire_extinguisher();
  self waittillmatch("single anim", "end");
  self.accuracy = 0.01;
  self.baseaccuracy = 0.01;
  var_1 = getnode("ghost1_post_breach_node", "targetname");
  level.allies[0] setgoalnode(var_1);
  level.allies[0] thread ally_shoots_fire_extinguisher();
  level waittill("slowmo_breach_ending");

  if(isalive(level.breach_rpg_guy)) {
    self.ignoreall = 1;
    var_2 = level.breach_rpg_guy gettagorigin("j_head");
    magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), var_2);
    wait 0.2;
    magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), var_2);
    level.breach_rpg_guy kill();
  }

  self.ignoreall = 0;
  self.accuracy = 0.2;
  self.baseaccuracy = 1;
}

ally_shoots_fire_extinguisher() {
  level endon("player_shot_extinguisher");

  if(isDefined(level.fire_extinguisher_aim_ent)) {
    wait 1.0;

    if(isDefined(level.fire_extinguisher_aim_ent)) {
      self.ignoreall = 1;
      magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), level.fire_extinguisher.origin);
      wait 0.2;
      magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), level.fire_extinguisher.origin);
      wait 0.1;
      magicbullet(level.allies[0].weapon, level.allies[0] gettagorigin("tag_flash"), level.fire_extinguisher.origin);
      common_scripts\utility::flag_set("ghost1_shot_extinguisher");
      self.ignoreall = 0;
    }
  }
}

breach_setup() {
  level.breach_door_rig = maps\_utility::spawn_anim_model("breach_door_rig");
  var_0 = getEntArray("breach_doors", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "right") {
      var_3 = getent("breach_door_clip_right", "targetname");
      var_3 linkto(var_2);
      var_4 = getent("breach_door_window_right", "targetname");
      var_4 linkto(var_2);
      var_2 linkto(level.breach_door_rig, "J_prop_1", (0, 0, 0), (0, 0, 0));
      continue;
    }

    var_3 = getent("breach_door_clip_left", "targetname");
    var_3 linkto(var_2);
    var_4 = getent("breach_door_window_left", "targetname");
    var_4 linkto(var_2);
    var_2 linkto(level.breach_door_rig, "J_prop_2", (0, 0, 0), (0, 0, 0));
  }

  level.breach_anim_struct = common_scripts\utility::getstruct("breach_anim_struct", "targetname");
  level.breach_anim_struct maps\_anim::anim_first_frame_solo(level.breach_door_rig, "breach_breach");
  level.saf_exit_door_right_obj = spawn("script_model", level.breach_door_rig.origin);
  level.saf_exit_door_right_obj setModel("saf_exit_door_right_obj");
  level.saf_exit_door_right_obj linkto(level.breach_door_rig, "J_prop_2", (0, 0, 0), (0, 0, 0));
  level.saf_exit_door_right_obj hide();
  level.fire_extinguisher = maps\_utility::spawn_anim_model("fire_extinguisher");
  level.fire_extinguisher_aim_ent = getent("aim_ent", "targetname");
  level.fire_extinguisher_aim_ent linkto(level.fire_extinguisher, "j_extinguisher_body", (0, 0, 0), (0, 0, 0));
  level.breach_anim_struct maps\_anim::anim_first_frame_solo(level.fire_extinguisher, "breach_enter");
}

breach_door_clips() {
  var_0 = getEntArray("breach_doors", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "right") {
      var_3 = getent("breach_door_clip_right", "targetname");
      var_4 = getent("breach_door_window_right", "targetname");
      var_4 thread connect_door_path();
      var_3 thread connect_door_path();
      continue;
    }

    var_3 = getent("breach_door_clip_left", "targetname");
    var_4 = getent("breach_door_window_left", "targetname");
    var_4 thread connect_door_path();
    var_3 thread connect_door_path();
  }
}

connect_door_path() {
  wait 0.5;
  self connectpaths();
}

fire_extinguisher_shot() {
  common_scripts\utility::flag_wait_either("player_shot_extinguisher", "ghost1_shot_extinguisher");
  level thread maps\satfarm_audio::tower_door_explosion();
  var_0 = common_scripts\utility::getstruct("fire_extinguisher_end", "targetname");

  if(common_scripts\utility::flag("player_shot_extinguisher"))
    radiusdamage(var_0.origin, 220, 200, 50);
  else {
    var_1 = common_scripts\utility::getstruct("fire_extinguisher_end_2", "targetname");
    radiusdamage(var_1.origin, 80, 200, 50);
  }

  thread fire_extinguisher_visionset();
  playFXOnTag(level._effect["fire_extinguisher_explosion"], self, "j_extinguisher_body");

  if(isDefined(self))
    self hide();

  if(isDefined(level.fire_extinguisher_aim_ent))
    level.fire_extinguisher_aim_ent delete();

  var_2 = getglassarray("breach_room_glass");

  foreach(var_4 in var_2) {
    if(!isglassdestroyed(var_4))
      destroyglass(var_4);
  }

  var_6 = common_scripts\utility::getstruct("ceiling_tiles_struct", "targetname");
  physicsexplosionsphere(var_6.origin, 100, 80, 1);
  var_7 = common_scripts\utility::getstruct("floor_struct", "targetname");
  physicsexplosionsphere(var_7.origin, 55, 55, 0.2);
  var_8 = common_scripts\utility::getstruct("paper_fx_struct", "targetname");
  var_9 = var_8 common_scripts\utility::spawn_tag_origin();
  playFXOnTag(level._effect["paper_blowing_stack_flat_cluster"], var_9, "tag_origin");
  var_10 = getent("breach_room_hanging_wire", "targetname");
  var_10 rotatepitch(-10, 1, 0, 0.5);
  wait 1;
  var_10 rotatepitch(10, 0.5, 0, 0);
  wait 0.5;
  var_10 rotatepitch(10, 0.5, 0, 0.5);
  wait 0.5;
  stopFXOnTag(level._effect["paper_blowing_stack_flat_cluster"], var_9, "tag_origin");
  var_10 rotatepitch(-10, 1, 0, 0);
  wait 1;
  var_10 rotatepitch(5, 1.5, 0, 0.5);
  wait 0.5;
  var_10 rotatepitch(-5, 1.5, 0, 0.5);
  wait 0.5;
  var_10 rotatepitch(-5, 2, 0, 0.5);
  wait 0.5;
  var_10 rotatepitch(5, 2, 0, 0.5);
  wait 0.5;
  self delete();
}

fire_extinguisher_visionset() {
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_fire_extinguisher", 0);
  wait 0.5;
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_tower", 0.5);
}

watch_damage() {
  level endon("ghost1_shot_extinguisher");
  self waittill("damage");
  common_scripts\utility::flag_set("player_shot_extinguisher");
}

set_anim_rate_on_fire_extinguisher() {
  level endon("player_shot_extinguisher");
  level endon("ghost1_shot_extinguisher");
  wait 0.2;
  maps\_anim::anim_set_rate_single(self, "breach_breach", 0.5);
  level waittill("slowmo_breach_ending");
  maps\_anim::anim_set_rate_single(self, "breach_breach", 1);
}

missile_launch_allies() {
  level.breach_anim_struct maps\_anim::anim_reach_solo(self, "satfarm_tower_launch_hesh_intro");
  level.breach_anim_struct thread maps\_anim::anim_single_solo(self, "satfarm_tower_launch_hesh_intro");
  wait 2;
  level thread maps\satfarm_audio::tower_command_table_typing();
  common_scripts\utility::flag_set("ghost1_at_table");
  self waittillmatch("single anim", "end");
  level.breach_anim_struct thread maps\_anim::anim_loop_solo(self, "satfarm_tower_launch_hesh_loop", "stop_hesh_loop");
  common_scripts\utility::flag_wait("missile_launch_start");
  level.breach_anim_struct notify("stop_hesh_loop");
  level.breach_anim_struct thread maps\_anim::anim_loop_solo(self, "satfarm_tower_launch_hesh_loop2", "stop_hesh_loop2");
  common_scripts\utility::flag_wait("missile_launched");
  level.breach_anim_struct notify("stop_hesh_loop2");
  level.breach_anim_struct maps\_anim::anim_single_solo(self, "satfarm_tower_launch_hesh_exit");
  common_scripts\utility::flag_set("go_get_bad_guy");
}

super_human(var_0) {
  if(isDefined(var_0)) {
    maps\_utility::disable_surprise();
    maps\_utility::disable_pain();
    self.ignoresuppression = 1;
    self.disablebulletwhizbyreaction = 1;
    self.disablefriendlyfirereaction = 1;
    self.disablereactionanims = 1;
  } else {
    maps\_utility::enable_surprise();
    maps\_utility::enable_pain();
    self.ignoresuppression = 0;
    self.disablebulletwhizbyreaction = 0;
    self.disablefriendlyfirereaction = 0;
    self.disablereactionanims = 0;
  }
}

loading_bay_combat() {
  if(level.start_point == "post_missile_launch")
    common_scripts\utility::flag_set("missile_launch_start");

  common_scripts\utility::flag_wait("missile_launch_start");
  level thread wall_lights();
  level thread sprinkler_fx();
  thread building_hit_moment();
  maps\_utility::array_spawn_function_targetname("loading_bay_enemies", ::loading_bay_enemy_setup);
  level.loading_bay_enemies = maps\_utility::array_spawn_targetname("loading_bay_enemies", 1);
  thread maps\satfarm_code::ai_array_killcount_flag_set(level.loading_bay_enemies, 3, "loading_bay_enemies_wave_2");
  common_scripts\utility::flag_wait_either("loading_bay_enemies_wave_2", "player_in_middle_of_loading_bay");
  maps\_utility::array_spawn_function_targetname("loading_bay_enemies_wave_2", ::loading_bay_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("loading_bay_enemies_wave_2", 1);
  level.loading_bay_enemies = common_scripts\utility::array_combine(level.loading_bay_enemies, var_0);

  while(level.loading_bay_enemies.size > 2) {
    if(common_scripts\utility::flag("loading_bay_enemies_retreat_trigger")) {
      break;
    }

    level.loading_bay_enemies = maps\_utility::array_removedead_or_dying(level.loading_bay_enemies);
    wait 0.05;
  }

  common_scripts\utility::flag_set("loading_bay_enemies_retreat");
  thread wait_for_all_enemies_to_leave_volume();
}

building_hit_moment() {
  var_0 = getEntArray("destroyed_light", "targetname");
  var_1 = getEntArray("clean_light", "targetname");

  foreach(var_3 in var_0)
  var_3 hide();

  common_scripts\utility::flag_wait("building_hit");
  level thread maps\satfarm_audio::building_hit_moment();
  earthquake(0.3, 2.5, level.player.origin, 300);
  level.player playrumbleonentity("damage_heavy");
  thread break_light();
  thread building_hit_fx();
  var_5 = getent("building_hit_light", "targetname");
  var_6 = getent("building_hit_light_02", "targetname");
  var_5 setlightintensity(0.01);

  if(isDefined(var_6))
    var_6 setlightintensity(0.01);

  wait 0.5;
  var_5 setlightintensity(0.8);
  wait 0.5;
  var_5 setlightintensity(0.01);
  thread ambient_building_explosions("warehouse_end");
}

break_light() {
  var_0 = getEntArray("destroyed_light", "targetname");
  var_1 = getEntArray("clean_light", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  foreach(var_3 in var_0)
  var_3 show();

  var_7 = common_scripts\utility::getstruct("destroyed_light_spark_fx", "targetname");
  playFX(level._effect["light_damage_runner"], var_7.origin);
  var_8 = common_scripts\utility::getstruct("destroyed_light_swing_fx", "targetname");
  playFX(level._effect["light_fluorescent_blowout_runner"], var_8.origin);

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "swing") {
      var_10 = common_scripts\utility::getstruct("light_origin_struct", "targetname");
      var_11 = var_10 common_scripts\utility::spawn_tag_origin();
      var_11.angles = var_3.angles;
      var_3 linkto(var_11, "tag_origin");
      var_11 rotateto(var_11.angles + (15, 0, 0), 0.5);
      wait 0.5;
      var_11 rotateto(var_11.angles + (-1, 0, 0), 0.25);
      wait 0.25;
      var_11 rotateto(var_11.angles + (1, 0, 0.1), 0.25);
      wait 0.25;
    }
  }
}

building_hit_fx() {
  var_0 = common_scripts\utility::getstructarray("ceiling_dust_fx_first_floor", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_fxid))
      playFX(common_scripts\utility::getfx(var_2.script_fxid), var_2.origin);
  }

  common_scripts\utility::flag_wait("elevator_landed");
}

wait_for_all_enemies_to_leave_volume() {
  var_0 = getent("loading_bay_volume", "targetname");

  for(;;) {
    var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");

    if(var_1.size > 0) {
      wait 0.05;
      continue;
    }

    common_scripts\utility::flag_set("all_enemies_out_of_loading_bay");
    break;
  }
}

loading_bay_enemy_setup() {
  self endon("death");
  var_0 = getent("loading_bay_volume", "targetname");
  thread retreat_to_elevator_room();

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "loading_bay_runner_1":
        self.ignoreall = 1;
        self.health = 50;
        level waittill("send_in_loading_bay_runner_1");
        maps\_utility::set_fixednode_false();
        self setgoalvolumeauto(var_0);
        self waittill("goal");
        self.ignoreall = 0;
        break;
      case "loading_bay_runner_2":
        self.ignoreme = 1;
        self.ignoreall = 1;
        maps\_utility::set_baseaccuracy(0.1);
        level waittill("post_breach_doors_open");
        common_scripts\utility::flag_wait("start_loading_bay_runners");
        wait 1.5;
        maps\_utility::set_baseaccuracy(0.5);
        self.ignoreme = 0;
        self.ignoreall = 0;

        if(!common_scripts\utility::flag("loading_bay_enemies_retreat")) {
          maps\_utility::set_fixednode_false();
          self setgoalvolumeauto(var_0);
        }

        break;
      case "loading_bay_runner_3":
        self.ignoreall = 1;
        maps\_utility::set_baseaccuracy(0.1);
        level waittill("post_breach_doors_open");
        self.ignoreall = 0;
        wait(randomfloatrange(3.0, 4.0));
        maps\_utility::set_baseaccuracy(0.5);

        if(!common_scripts\utility::flag("loading_bay_enemies_retreat")) {
          maps\_utility::set_fixednode_false();
          self setgoalvolumeauto(var_0);
        }

        break;
      case "loading_bay_runner_4":
        self.ignoreme = 1;
        common_scripts\utility::flag_wait("send_in_loading_bay_runner_4");
        wait(randomfloatrange(0.3, 1.0));

        if(!common_scripts\utility::flag("loading_bay_enemies_retreat")) {
          self.ignoreme = 0;
          maps\_utility::set_fixednode_false();
          self setgoalvolumeauto(var_0);
        }

        break;
    }
  }
}

retreat_to_elevator_room() {
  self endon("death");
  var_0 = getent("elevator_room_volume", "targetname");
  common_scripts\utility::flag_wait("loading_bay_enemies_retreat");
  wait(randomfloatrange(0.3, 0.8));
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(var_0);
  thread tunnel_behavior();
  self waittill("goal");
  self.ignoreall = 0;
}

tunnel_behavior() {
  self endon("death");
  var_0 = getent("tunnel_entrance_volume", "targetname");

  for(;;) {
    if(self istouching(var_0)) {
      self.ignoreall = 1;
      self.health = 1;
      break;
    }

    wait 0.05;
  }
}

run_out_behavior(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    if(self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(var_2)) {
    if(common_scripts\utility::flag(var_1) || common_scripts\utility::flag(var_2)) {
      self.ignoreall = 0;
      maps\_utility::player_seek_enable();
    } else
      self delete();
  } else if(common_scripts\utility::flag(var_1)) {
    self.ignoreall = 0;
    maps\_utility::player_seek_enable();
  } else
    self delete();
}

elevator_room_combat() {
  common_scripts\utility::flag_wait_either("loading_bay_enemies_retreat", "loading_bay_enemies_retreat_trigger");
  maps\_utility::array_spawn_function_targetname("elevator_room_enemies", ::elevator_room_enemy_setup);
  level.elevator_room_enemies = maps\_utility::array_spawn_targetname("elevator_room_enemies", 1);
  level.loading_bay_enemies = maps\_utility::array_removedead_or_dying(level.loading_bay_enemies);
  level.elevator_room_enemies = common_scripts\utility::array_combine(level.elevator_room_enemies, level.loading_bay_enemies);
  thread elevator_room_second_wave();
  thread elevator_room_left_flank();
  thread elevator_enemies();
  common_scripts\utility::flag_wait("player_in_tunnel");
  maps\_utility::autosave_by_name("tunnel");
  wait 0.5;
  maps\_utility::waittill_dead_or_dying(level.elevator_room_enemies, 2);
  common_scripts\utility::flag_set("most_ghost1_to_elevator_room");
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  maps\_utility::waittill_dead_or_dying(level.elevator_room_enemies, 1);
  common_scripts\utility::flag_set("send_in_wave_2");
  wait 1;
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  maps\_utility::waittill_dead_or_dying(level.elevator_room_enemies, 3);
  common_scripts\utility::flag_set("send_in_elevator");
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  maps\_utility::waittill_dead_or_dying(level.elevator_room_enemies);
  common_scripts\utility::flag_set("elevator_room_cleared");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");
}

elevator_room_enemy_setup() {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "elevator_room_runner_1")
    common_scripts\utility::flag_wait("send_in_elevator_room_runners_1");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "elevator_room_runner_2") {
    self.ignoreme = 1;
    common_scripts\utility::flag_wait("send_in_elevator_room_runners_3");

    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.ignoreme = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "elevator_room_enemies_left_flank") {
    if(isDefined(self.script_delay))
      wait(self.script_delay);
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "elevator_room_enemies_elevator") {
    self.ignoreall = 1;
    common_scripts\utility::flag_wait_either("send_in_elevator", "send_in_elevator_trigger");
    self.ignoreall = 0;
    common_scripts\utility::flag_wait("elevator_enemies_unload");
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy != "elevator_room_enemies_left_flank")
    wait(randomfloatrange(0.3, 0.8));

  var_0 = getent("elevator_room_volume", "targetname");
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(var_0);
}

elevator_room_second_wave() {
  common_scripts\utility::flag_wait_either("send_in_wave_2", "send_in_wave_2_trigger");
  maps\_utility::array_spawn_function_targetname("elevator_room_enemies_wave_2", ::elevator_room_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("elevator_room_enemies_wave_2", 1);
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  level.elevator_room_enemies = common_scripts\utility::array_combine(level.elevator_room_enemies, var_0);
}

elevator_room_left_flank() {
  level endon("elevator_room_cleared");
  common_scripts\utility::flag_wait("send_in_left_flank_trigger");
  maps\_utility::array_spawn_function_targetname("elevator_room_enemies_left_flank", ::elevator_room_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("elevator_room_enemies_left_flank", 1);
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  level.elevator_room_enemies = common_scripts\utility::array_combine(level.elevator_room_enemies, var_0);
}

elevator_enemies() {
  warehouse_elevator_setup();
  maps\_utility::array_spawn_function_targetname("elevator_room_enemies_elevator", ::elevator_room_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("elevator_room_enemies_elevator", 1);
  level.elevator_room_enemies = maps\_utility::array_removedead_or_dying(level.elevator_room_enemies);
  level.elevator_room_enemies = common_scripts\utility::array_combine(level.elevator_room_enemies, var_0);
  wait 0.1;
  level.warehouse_elevator_origin moveto(level.warehouse_elevator_origin.origin + (0, 0, -224), 0.5, 0, 0);
  common_scripts\utility::flag_wait_either("send_in_elevator", "send_in_elevator_trigger");
  level.warehouse_elevator_origin moveto(level.warehouse_elevator_origin.origin + (0, 0, 224), 5, 0, 1);
  thread common_scripts\utility::play_sound_in_space("satf_elevator_arrival", (-5173, 54719, -179));
  wait 5;
  thread common_scripts\utility::play_sound_in_space("satf_elevator_arrival_gate_open", (-5173, 54719, -179));
  level.player_elevator_clip_back = getent("player_elevator_clip_back", "targetname");
  level.player_elevator_clip_back notsolid();

  foreach(var_2 in level.warehouse_elevator_doors)
  var_2 unlink();

  foreach(var_2 in level.warehouse_elevator_doors) {
    if(isDefined(var_2.script_noteworthy)) {
      if(var_2.script_noteworthy == "elevator_room_side_door_right") {
        var_5 = common_scripts\utility::getstruct("elevator_room_side_door_right_open_struct", "targetname");
        var_2 moveto(var_5.origin, 2);
        var_2 connectpaths();
        continue;
      }

      if(var_2.script_noteworthy == "elevator_room_side_door_left") {
        var_6 = common_scripts\utility::getstruct("elevator_room_side_door_left_open_struct", "targetname");
        var_2 moveto(var_6.origin, 2);
        var_2 connectpaths();
      }
    }
  }

  wait 2;
  level.ally_elevator_clip_back = getent("ally_elevator_clip_back", "targetname");
  level.ally_elevator_clip_back notsolid();
  level.ally_elevator_clip_back connectpaths();
  common_scripts\utility::flag_set("elevator_enemies_unload");

  foreach(var_2 in level.warehouse_elevator_doors)
  var_2 linkto(level.warehouse_elevator_origin, "tag_origin");
}

warehouse_elevator_setup() {
  level.warehouse_elevator_struct = common_scripts\utility::getstruct("warehouse_elevator_struct", "targetname");
  level.warehouse_elevator_origin = level.warehouse_elevator_struct common_scripts\utility::spawn_tag_origin();
  level.warehouse_elevator = getent("warehouse_elevator", "targetname");
  level.warehouse_elevator linkto(level.warehouse_elevator_origin, "tag_origin");
  level.warehouse_elevator_platform = getent("warehouse_elevator_platform", "targetname");
  level.warehouse_elevator_platform linkto(level.warehouse_elevator_origin, "tag_origin");
  level.warehouse_elevator_doors = getEntArray("warehouse_elevator_doors", "targetname");

  foreach(var_1 in level.warehouse_elevator_doors)
  var_1 linkto(level.warehouse_elevator_origin, "tag_origin");

  var_3 = getEntArray("tc_elevator_models", "targetname");

  foreach(var_5 in var_3)
  var_5 linkto(level.warehouse_elevator_origin, "tag_origin");
}

allies_movement_post_missile_launch() {
  if(level.start_point == "post_missile_launch") {
    common_scripts\utility::flag_set("go_get_bad_guy");
    level.allies[0] thread super_human(1);
  }

  common_scripts\utility::flag_wait("go_get_bad_guy");
  thread allies_vo_post_missile_launch();
  level.allies[0] thread door_kick_ally();
  common_scripts\utility::flag_wait("allies_stop_cqb_walk");
  level.allies[0] maps\_utility::disable_cqbwalk();
  common_scripts\utility::flag_wait_any("loading_bay_enemies_retreat", "loading_bay_enemies_retreat_trigger");
  wait 1;

  if(!common_scripts\utility::flag("move_allies_into_tunnel_flag"))
    safe_activate_trigger_with_targetname("move_allies_to_tunnel_entrance");

  common_scripts\utility::flag_wait("most_ghost1_to_elevator_room");
  safe_activate_trigger_with_targetname("move_allies_into_elevator_room_trigger");
  common_scripts\utility::flag_wait("elevator_room_cleared");
  level.allies[0].ignoreall = 1;
  safe_activate_trigger_with_targetname("move_allies_into_elevator_room_trigger_2");
  safe_activate_trigger_with_targetname("move_allies_into_elevator");
}

allies_vo_post_missile_launch() {
  common_scripts\utility::flag_wait_any("loading_bay_enemies_retreat", "loading_bay_enemies_retreat_trigger");
  wait 1;
  level.allies[0] thread maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_wehavetoget");
  common_scripts\utility::flag_wait("most_ghost1_to_elevator_room");
  var_0 = getent("tunnel_volume", "targetname");

  if(level.player istouching(var_0))
    level.allies[0] thread maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_moveup");

  common_scripts\utility::flag_wait("send_in_elevator");
  level.allies[0] thread maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_letsmovewegotta");
  common_scripts\utility::flag_wait("elevator_room_cleared");
  wait 1.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_fireteamssuppressedin");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_mrk_rogerthat");
}

door_kick_ally() {
  var_0 = common_scripts\utility::getstruct("ally_post_breach_anim_struct", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "door_kick_in");

  if(!common_scripts\utility::flag("player_on_stairs"))
    common_scripts\utility::flag_wait("player_on_stairs");

  var_0 thread maps\_anim::anim_single_solo(self, "door_kick_in");
  self waittillmatch("single anim", "footstep_right_small");
  level notify("send_in_loading_bay_runner_1");
  self waittillmatch("single anim", "kick");
  level notify("post_breach_doors_open");
  thread post_breach_doors();
  wait 0.6;
  self stopanimscripted();
  maps\_utility::enable_ai_color();
  safe_activate_trigger_with_targetname("move_allies_into_hallway");
  common_scripts\utility::flag_set("post_missile_launch_breach_done");
  thread maps\_utility::set_team_bcvoice("allies", "taskforce");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
}

post_breach_doors() {
  var_0 = getEntArray("post_breach_doors", "targetname");
  thread common_scripts\utility::play_sound_in_space("satf_post_launch_door_kick", (-4463, 53759, 103));

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "right") {
      var_3 = getent("post_breach_door_clip_right", "targetname");
      var_3 linkto(var_2);
      var_2 rotateto((0, 100, 0), 0.5);
      var_3 thread connect_door_path();
      continue;
    }

    var_3 = getent("post_breach_door_clip_left", "targetname");
    var_3 linkto(var_2);
    var_2 rotateto((0, -60, 0), 0.5);
    var_3 thread connect_door_path();
  }
}

warehouse_elevator() {
  if(level.start_point == "warehouse")
    warehouse_elevator_setup();

  common_scripts\utility::flag_wait("allies_in_elevator");
  thread warehouse_lift();
  var_0 = getent("warehouse_elevator_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_set("player_and_allies_in_elevator");
  level thread maps\satfarm_audio::elevator();
  thread warehouse_bay_doors();
  level.player_elevator_clip_back solid();

  foreach(var_2 in level.warehouse_elevator_doors)
  var_2 unlink();

  foreach(var_2 in level.warehouse_elevator_doors) {
    if(isDefined(var_2.script_noteworthy)) {
      if(var_2.script_noteworthy == "elevator_room_side_door_right") {
        var_5 = common_scripts\utility::getstruct("elevator_room_side_door_right_struct", "targetname");
        var_2 moveto(var_5.origin, 2);
        continue;
      }

      if(var_2.script_noteworthy == "elevator_room_side_door_left") {
        var_6 = common_scripts\utility::getstruct("elevator_room_side_door_left_struct", "targetname");
        var_2 moveto(var_6.origin, 2);
      }
    }
  }

  wait 2;

  foreach(var_2 in level.warehouse_elevator_doors)
  var_2 linkto(level.warehouse_elevator_origin, "tag_origin");

  level.warehouse_elevator_origin moveto(level.warehouse_elevator_origin.origin + (0, 0, -448), 15, 1, 1);
  wait 15;

  foreach(var_2 in level.warehouse_elevator_doors)
  var_2 unlink();

  common_scripts\utility::flag_set("elevator_landed");
  maps\_utility::autosave_by_name("elevator_landed");
  var_12 = getent("player_elevator_clip_front", "targetname");
  var_12 delete();

  foreach(var_2 in level.warehouse_elevator_doors) {
    if(isDefined(var_2.script_noteworthy)) {
      if(var_2.script_noteworthy == "warehouse_side_door_right") {
        var_14 = common_scripts\utility::getstruct("warehouse_side_door_right_struct", "targetname");
        var_2 moveto(var_14.origin, 2);
        var_2 connectpaths();
        continue;
      }

      if(var_2.script_noteworthy == "warehouse_side_door_left") {
        var_15 = common_scripts\utility::getstruct("warehouse_side_door_left_struct", "targetname");
        var_2 moveto(var_15.origin, 2);
        var_2 connectpaths();
      }
    }
  }

  wait 2;
  common_scripts\utility::flag_set("unload_elevator");
  common_scripts\utility::flag_wait("warehouse_end");
  wait 5;

  foreach(var_2 in level.warehouse_elevator_doors) {
    if(isDefined(var_2))
      var_2 delete();
  }

  level.warehouse_elevator_origin delete();
}

warehouse_lift() {
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  maps\_utility::autosave_by_name("warehouse_elevator");
  var_0 = getent("warehouse_lift_brush", "targetname");
  var_1 = getEntArray("warehouse_lift_entities", "targetname");
  var_2 = common_scripts\utility::getstruct("warehouse_lift_struct", "script_noteworthy");
  level.warehouse_lift_tag_origin = var_2 common_scripts\utility::spawn_tag_origin();
  var_0 linkto(level.warehouse_lift_tag_origin, "tag_origin");

  foreach(var_4 in var_1)
  var_4 linkto(level.warehouse_lift_tag_origin, "tag_origin");

  var_6 = getent("warehouse_lift_player_clip", "targetname");
  var_6 linkto(level.warehouse_lift_tag_origin, "tag_origin");
  var_7 = getent("warehouse_lift_clip", "targetname");
  var_7 linkto(level.warehouse_lift_tag_origin, "tag_origin");
  var_8 = common_scripts\utility::getstruct("warehouse_lift_enemy_1_struct", "targetname");
  level.warehouse_lift_enemy_1_origin = var_8 common_scripts\utility::spawn_tag_origin();
  level.warehouse_lift_enemy_1_origin linkto(level.warehouse_lift_tag_origin, "tag_origin");
  var_9 = common_scripts\utility::getstruct("warehouse_lift_enemy_2_struct", "targetname");
  level.warehouse_lift_enemy_2_origin = var_9 common_scripts\utility::spawn_tag_origin();
  level.warehouse_lift_enemy_2_origin linkto(level.warehouse_lift_tag_origin, "tag_origin");
  maps\_utility::array_spawn_function_targetname("warehouse_enemies_lift", ::warehouse_enemy_lift_setup);
  var_10 = maps\_utility::array_spawn_targetname("warehouse_enemies_lift", 1);
  common_scripts\utility::flag_wait("elevator_landed");
  thread common_scripts\utility::play_sound_in_space("satf_elevator_gate_open", (-5173, 54719, -179));
  var_11 = getent("warehouse_block_cover_clip", "targetname");
  var_11 notsolid();
  var_11 connectpaths();
  var_11 delete();
  wait 1;
  thread common_scripts\utility::play_sound_in_space("satf_warehouse_lift", (-5627, 55977, -447));
  var_12 = level.warehouse_lift_tag_origin.origin + (0, 0, -144);
  level.warehouse_lift_tag_origin moveto(var_12, 12, 1, 1);
  wait 12;
  var_7 unlink();
  var_12 = var_7.origin + (0, 0, -64);
  var_7 moveto(var_12, 0.5, 0, 0);
  wait 0.5;
  var_7 connectpaths();
  common_scripts\utility::flag_set("lift_landed");
  common_scripts\utility::flag_wait("warehouse_end");
  wait 5;

  foreach(var_4 in var_1) {
    if(isDefined(var_4))
      var_4 delete();
  }

  if(isDefined(level.warehouse_lift_tag_origin))
    level.warehouse_lift_tag_origin delete();

  if(isDefined(var_6))
    var_6 delete();
}

warehouse_bay_doors() {
  var_0 = getent("warehouse_bay_doors_light", "targetname");

  if(isDefined(var_0))
    var_0 setlightintensity(1.0);

  wait 2;
  var_1 = getEntArray("warehouse_bay_doors", "targetname");

  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "right") {
      var_4 = common_scripts\utility::getstruct("warehouse_bay_doors_right", "targetname");
      var_3 moveto(var_4.origin, 1);
      continue;
    }

    var_5 = common_scripts\utility::getstruct("warehouse_bay_doors_left", "targetname");
    var_3 moveto(var_5.origin, 1);
  }
}

warehouse_combat() {
  common_scripts\utility::flag_wait("spawn_warehouse_enemies");
  maps\_utility::array_spawn_function_targetname("warehouse_enemies_ambient", ::warehouse_enemy_ambient_setup);
  var_0 = maps\_utility::array_spawn_targetname("warehouse_enemies_ambient", 1);
  maps\_utility::array_spawn_function_targetname("warehouse_enemies_wave_1", ::warehouse_enemy_setup);
  var_1 = maps\_utility::array_spawn_targetname("warehouse_enemies_wave_1", 1);
  thread maps\satfarm_code::ai_array_killcount_flag_set(var_1, 3, "advance_allies_wave_2_flag");
  thread handle_enemy_accuracy_while_player_in_elevator();
  thread warehouse_right_flank();
  common_scripts\utility::flag_wait("advance_allies_wave_2_flag");
  thread retreat_from_vol_to_vol("warehouse_front_volume", "warehouse_middle_volume", 0.3, 0.5);
  var_2 = maps\_utility::array_spawn_targetname("warehouse_enemies_wave_2", 1);
  var_1 = maps\_utility::array_removedead_or_dying(var_1);
  level.warehouse_enemies = common_scripts\utility::array_combine(var_1, var_2);
  thread maps\satfarm_code::ai_array_killcount_flag_set(level.warehouse_enemies, 3, "advance_allies_wave_3_flag");
  maps\_utility::array_spawn_function_targetname("warehouse_enemies_upper", ::warehouse_enemy_upper_setup);
  var_3 = maps\_utility::array_spawn_targetname("warehouse_enemies_upper", 1);
  safe_activate_trigger_with_targetname("advance_allies_wave_2_trigger");
  common_scripts\utility::flag_wait("advance_allies_wave_3_flag");
  var_4 = getent("warehouse_volume", "targetname");
  var_5 = maps\_utility::array_spawn_targetname("warehouse_enemies_wave_3", 1);
  level.warehouse_enemies = maps\_utility::array_removedead_or_dying(level.warehouse_enemies);
  level.warehouse_enemies = common_scripts\utility::array_combine(level.warehouse_enemies, var_5);
  thread maps\satfarm_code::ai_array_killcount_flag_set(level.warehouse_enemies, 2, "advance_allies_wave_3a_flag");
  safe_activate_trigger_with_targetname("advance_allies_wave_3_trigger");
  maps\_utility::autosave_by_name("warehouse_combat_1");
  common_scripts\utility::flag_wait("advance_allies_wave_3a_flag");
  thread retreat_from_vol_to_vol("warehouse_middle_volume", "warehouse_back_volume", 0.1, 0.3, 1);
  safe_activate_trigger_with_targetname("advance_allies_wave_3a_trigger");
  thread set_accuracy(var_4, "axis", 0.01);
  thread set_accuracy(var_4, "allies", 0.01);
  thread warehouse_last_push();
  common_scripts\utility::flag_wait_any("warehouse_last_push", "player_on_train_platform");
  var_4 = getent("underground_warehouse_volume", "targetname");
  thread set_accuracy(var_4, "axis", 0.1);

  foreach(var_7 in level.warehouse_enemies)
  var_7.health = 5;

  maps\_utility::autosave_by_name("warehouse_combat_2");
  common_scripts\utility::flag_wait_all("player_train_trigger", "send_allies_to_train");
  maps\_utility::array_spawn_function_targetname("warehouse_enemies_wave_1", ::warehouse_enemy_last_wave_setup);
  var_9 = maps\_utility::array_spawn_targetname("warehouse_enemies_last_wave", 1);
  level.warehouse_enemies = maps\_utility::array_removedead_or_dying(level.warehouse_enemies);
  level.warehouse_enemies = common_scripts\utility::array_combine(level.warehouse_enemies, var_9);
  common_scripts\utility::flag_wait("send_allies_to_train");
  thread retreat_from_vol_to_vol("warehouse_back_volume", "warehouse_train_platform_volume", 0.3, 0.5);
  common_scripts\utility::flag_wait("warehouse_end");
  wait 5;
  level.warehouse_enemies = maps\_utility::array_removedead_or_dying(level.warehouse_enemies);

  if(level.warehouse_enemies.size > 0) {
    foreach(var_11 in level.warehouse_enemies)
    var_11 delete();
  }
}

handle_enemy_accuracy_while_player_in_elevator() {
  var_0 = getent("warehouse_volume", "targetname");
  thread set_accuracy(var_0, "axis", 0.01);
  common_scripts\utility::flag_wait("player_in_warehouse");
  var_0 = getent("warehouse_volume", "targetname");
  thread set_accuracy(var_0, "axis");
}

set_accuracy(var_0, var_1, var_2) {
  var_3 = var_0 maps\_utility::get_ai_touching_volume(var_1);

  if(isDefined(var_2)) {
    foreach(var_5 in var_3) {
      var_5.accuracy = var_2;
      var_5.baseaccuracy = var_2;
    }
  } else {
    foreach(var_5 in var_3) {
      var_5.accuracy = 0.2;
      var_5.baseaccuracy = 1;
    }
  }
}

get_to_train_wait_node() {
  level endon("warehouse_last_push");
  level endon("player_on_train_platform");

  if(!common_scripts\utility::flag("ghost1_at_train_wait_node")) {
    self pushplayer(1);
    maps\_utility::disable_ai_color();
    self.ignoreall = 1;
    self.dontmelee = 1;
    self.ignorerandombulletdamage = 1;
    maps\_utility::disable_danger_react();
    maps\_utility::setflashbangimmunity(1);
    self setCanDamage(0);
    self.dontavoidplayer = 1;
    self.nododgemove = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoreexplosionevents = 1;
    self.disableplayeradsloscheck = 1;
    var_0 = getnode("ghost1_train_wait_node", "targetname");
    maps\_utility::set_goal_radius(16);
    self setgoalnode(var_0);
    self waittill("goal");
    self.ignoreall = 0;
  }
}

warehouse_right_flank() {
  common_scripts\utility::flag_wait_any("spawn_warehouse_right_flank_enemies", "disable_right_flank_scripting");

  if(common_scripts\utility::flag("disable_right_flank_scripting")) {
    var_0 = getEntArray("warehouse_right_flank_triggers", "targetname");

    foreach(var_2 in var_0)
    var_2 common_scripts\utility::trigger_off();
  } else {
    wait 0.5;
    maps\_utility::array_spawn_function_targetname("warehouse_enemies_right_flank", ::warehouse_enemies_right_flank_setup);
    var_4 = maps\_utility::array_spawn_targetname("warehouse_enemies_right_flank", 1);
    wait 0.1;
    var_5 = maps\_utility::get_ai_group_ai("warehouse_enemies_right_flank_2");
    thread warehouse_right_flank_threatbiasgroup(var_5);
    common_scripts\utility::flag_wait("advance_allies_wave_4_flag");
    var_4 = maps\_utility::array_removedead_or_dying(var_4);

    if(var_4.size > 0)
      level.warehouse_enemies = common_scripts\utility::array_combine(level.warehouse_enemies, var_4);
  }
}

warehouse_right_flank_threatbiasgroup(var_0) {
  createthreatbiasgroup("ignore_group");
  createthreatbiasgroup("right_flank_enemies");
  level.player setthreatbiasgroup("ignore_group");

  foreach(var_2 in var_0)
  var_2 setthreatbiasgroup("right_flank_enemies");

  setignoremegroup("ignore_group", "right_flank_enemies");
  common_scripts\utility::flag_wait_or_timeout("player_in_second_right_flank_room", 10);

  if(common_scripts\utility::flag("player_in_second_right_flank_room"))
    wait 0.5;

  level.player setthreatbiasgroup();
  createthreatbiasgroup("new_group");
  level.player setthreatbiasgroup("new_group");
  setthreatbias("new_group", "right_flank_enemies", 500);
}

warehouse_enemies_right_flank_setup() {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "warehouse_enemies_right_flank_2") {
    self.ignoreall = 1;
    common_scripts\utility::flag_wait_or_timeout("send_in_warehouse_right_flank_enemies_2", 2);

    if(!common_scripts\utility::flag("send_in_warehouse_right_flank_enemies_2"))
      common_scripts\utility::flag_set("send_in_warehouse_right_flank_enemies_2");

    self.ignoreall = 0;
    common_scripts\utility::flag_wait_or_timeout("player_in_second_right_flank_room", 10);

    if(common_scripts\utility::flag("player_in_second_right_flank_room"))
      wait 0.5;

    self.favoriteenemy = level.player;
  }
}

warehouse_last_push() {
  level endon("player_on_train_platform");
  level.warehouse_enemies = maps\_utility::array_removedead_or_dying(level.warehouse_enemies);

  while(level.warehouse_enemies.size > 3) {
    level.warehouse_enemies = maps\_utility::remove_dead_from_array(level.warehouse_enemies);
    wait 0.05;
  }

  common_scripts\utility::flag_set("warehouse_last_push");
}

warehouse_enemy_ambient_setup() {
  self endon("death");

  if(isDefined(self.script_noteworthy)) {
    self.struct = common_scripts\utility::getstruct(self.script_noteworthy + "_struct", "targetname");

    switch (self.script_noteworthy) {
      case "warehouse_ambient_enemy_animated_1":
        self.ignoreall = 1;
        self.animname = "generic";
        self.allowdeath = 1;
        self.animation = "clockwork_chaos_wave_guard";
        self.volume = getent("warehouse_enemies_ambient_runners_lower_volume", "targetname");
        self.struct maps\_anim::anim_first_frame_solo(self, self.animation);
        thread warehouse_ambient_animated_enemies();
        break;
      case "warehouse_ambient_enemy_animated_2":
        self.ignoreall = 1;
        self.animname = "generic";
        self.allowdeath = 1;
        self.animation = "payback_escape_forward_wave_left_soap";
        self.volume = getent("warehouse_ambient_enemy_animated_2_volume", "targetname");
        thread warehouse_ambient_animated_enemies(1);
        break;
      case "warehouse_enemies_ambient_runners_lower":
        common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
        thread warehouse_enemy_ambient_runners_setup();
        break;
      case "warehouse_enemies_ambient_runners_right_upper":
        common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
        thread warehouse_enemy_ambient_runners_setup();
        break;
    }
  }
}

warehouse_enemy_lift_setup() {
  self endon("death");
  self.accuracy = 0.01;
  self.ignoreall = 1;
  self.animname = "generic";
  thread enemies_shot_at("warehouse_enemies_alerted", "start_ambient_warehouse_scenarios", "player_shot_at_enemies_in_warehouse");

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "warehouse_lift_enemy_1":
        self.struct = level.warehouse_lift_enemy_1_origin;
        self linkto(self.struct, "tag_origin");
        self.idleanim = "warehouse_lift_enemy_1_loop";
        thread play_idle_anims();
        break;
      case "warehouse_lift_enemy_2":
        self.struct = level.warehouse_lift_enemy_2_origin;
        self linkto(self.struct, "tag_origin");
        self.idleanim = "warehouse_lift_enemy_2_loop";
        thread warehouse_lift_enemy_2();
        break;
    }
  }

  common_scripts\utility::flag_wait_any("elevator_landed", "player_shot_at_enemies_in_warehouse");

  if(!common_scripts\utility::flag("warehouse_enemies_alerted"))
    common_scripts\utility::flag_set("warehouse_enemies_alerted");

  alert_enemies_react();
  self unlink();

  if(!common_scripts\utility::flag("lift_landed")) {
    common_scripts\utility::flag_wait("lift_landed");
    wait 1;
    self unlink();
    self.health = 5;
  }

  maps\_utility::set_fixednode_false();
  var_0 = getent("warehouse_middle_volume", "targetname");
  self setgoalvolumeauto(var_0);
  level.warehouse_enemies = common_scripts\utility::add_to_array(level.warehouse_enemies, self);
}

warehouse_lift_enemy_2() {
  self endon("death");
  self endon("alerted");
  self.struct maps\_anim::anim_single_solo(self, "warehouse_lift_enemy_2");
  thread play_idle_anims();
}

warehouse_enemy_setup() {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "generic";

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "warehouse_enemy_animated_1":
        self.struct = common_scripts\utility::getstruct("warehouse_enemy_animated_1_struct", "targetname");
        self.animation = "roadkill_shepherd_shout_sequence";
        thread animated_warehouse_guys();
        break;
      case "warehouse_enemies_run_in_1":
        warehouse_enemies_run_in_1();
        alert_enemies_react();
        var_0 = getent("warehouse_front_volume", "targetname");
        maps\_utility::set_fixednode_false();
        self setgoalvolumeauto(var_0);
        self.ignoreall = 1;
        self waittill("goal");
        self.ignoreall = 0;
        break;
      case "warehouse_enemies_run_in_2":
        self.ignoreme = 1;
        common_scripts\utility::flag_wait("elevator_landed");
        self.ignoreme = 0;
        wait 1;
        maps\_utility::set_goal_radius(32);
        self waittill("goal");
        self.ignoreall = 0;
        break;
    }
  }
}

animated_warehouse_guys() {
  self.struct thread maps\_anim::anim_first_frame_solo(self, self.animation);
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  self.struct thread maps\_anim::anim_single_solo(self, self.animation);
  common_scripts\utility::flag_wait_any("elevator_landed", "player_shot_at_enemies_in_warehouse");

  if(!common_scripts\utility::flag("warehouse_enemies_alerted"))
    common_scripts\utility::flag_set("warehouse_enemies_alerted");

  alert_enemies_react();
  var_0 = getent("warehouse_front_volume", "targetname");
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(var_0);
}

warehouse_enemies_run_in_1() {
  level endon("warehouse_enemies_alerted");
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  var_0 = getent("warehouse_ambient_enemy_animated_2_volume", "targetname");
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(var_0);
  self waittill("goal");
  common_scripts\utility::flag_wait_any("elevator_landed", "player_shot_at_enemies_in_warehouse");

  if(!common_scripts\utility::flag("warehouse_enemies_alerted"))
    common_scripts\utility::flag_set("warehouse_enemies_alerted");
}

warehouse_ambient_animated_enemies(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");

  if(isDefined(var_0))
    self.struct maps\_anim::anim_reach_solo(self, self.animation);

  self.struct maps\_anim::anim_single_solo(self, self.animation);
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(self.volume);
  run_out_behavior(self.volume, "player_on_train_platform");
}

warehouse_enemy_ambient_runners_setup() {
  self endon("death");
  self endon("alerted");
  self.ignoreall = 1;

  if(isDefined(self.script_delay))
    wait(self.script_delay);

  maps\_utility::set_fixednode_false();
  var_0 = getent(self.script_noteworthy + "_volume", "targetname");
  self setgoalvolumeauto(var_0);

  if(self.script_noteworthy != "warehouse_enemies_ambient_runners_upper")
    run_out_behavior(var_0, "player_on_train_platform");
}

warehouse_enemy_upper_setup() {
  self endon("death");
  self.accuracy = 0.01;
  self.base_accuracy = 0.01;
  self.health = 50;
  self.favoriteenemy = level.allies[0];
  common_scripts\utility::flag_wait_any("warehouse_last_push", "player_on_train_platform");
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("ghost1_at_train_node");
  level.warehouse_enemies = maps\_utility::array_removedead_or_dying(level.warehouse_enemies);

  if(level.warehouse_enemies.size == 0)
    self.ignoreme = 0;

  common_scripts\utility::flag_wait("ghost1_on_train");
  self.ignoreme = 0;
  common_scripts\utility::flag_wait("warehouse_end");
  wait 5;
  self delete();
}

warehouse_enemy_last_wave_setup() {
  self.accuracy = 0.01;
  self.base_accuracy = 0.01;
  self.favoriteenemy = level.allies[0];
}

safe_activate_trigger_with_targetname(var_0) {
  var_1 = 64;
  var_2 = getent(var_0, "targetname");

  if(isDefined(var_2) && !isDefined(var_2.trigger_off)) {
    var_2 maps\_utility::activate_trigger();

    if(isDefined(var_2.spawnflags) && var_2.spawnflags & var_1)
      var_2 common_scripts\utility::trigger_off();
  }
}

retreat_from_vol_to_vol(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getent(var_0, "targetname");
  var_6 = var_5 maps\_utility::get_ai_touching_volume("axis");
  var_7 = getent(var_1, "targetname");
  var_8 = getnode(var_7.target, "targetname");

  foreach(var_10 in var_6) {
    if(isDefined(var_10) && isalive(var_10)) {
      if(isDefined(var_4))
        var_10.ignoreall = 1;

      var_10.forcegoal = 0;
      var_10.fixednode = 0;
      var_10.pathrandompercent = randomintrange(75, 100);
      var_10 setgoalnode(var_8);
      var_10 setgoalvolumeauto(var_7);

      if(isDefined(var_4)) {
        var_10 waittill("goal");

        if(isalive(var_10))
          var_10.ignoreall = 0;
      }
    }
  }
}

check_trigger_flagset(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isDefined(var_1.script_flag_set))
    common_scripts\utility::flag_set(var_1.script_flag_set);
}

exit_on_train() {
  thread train_car();
  common_scripts\utility::flag_wait("player_train_trigger");
  level.player.ignoreme = 1;
  level.player enabledeathshield(1);
  maps\_utility::objective_complete(maps\_utility::obj("train"));
  thread maps\satfarm_code::delete_all_vehicles();
  common_scripts\utility::flag_wait("warehouse_end");
  level.player.ignoreme = 0;
  level.player enabledeathshield(0);
  wait 5;
  maps\_spawner::killspawner(202);
  var_0 = getEntArray("cleanup_ghost_section", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::entity_cleanup);
}

train_car() {
  var_0 = common_scripts\utility::getstructarray("model_to_spawn_in", "script_noteworthy");

  foreach(var_2 in var_0)
  spawn_model_from_struct(var_2);

  var_4 = getEntArray("train_car", "targetname");
  var_2 = common_scripts\utility::getstruct("train_car_struct", "targetname");
  level.train_car_tag_origin = var_2 common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::getstruct("ghost1_train_struct", "targetname");
  var_6 = var_5 common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_6.origin + (-30, 0, 0);

  foreach(var_8 in var_4) {
    var_8 linkto(level.train_car_tag_origin, "tag_origin");
    var_8 retargetscriptmodellighting(var_6);
  }

  var_10 = getent("train_car_player_clip", "targetname");
  var_10 notsolid();
  var_10 linkto(level.train_car_tag_origin, "tag_origin");
  var_11 = getent("train_car_player_inner_clip", "targetname");
  var_11 notsolid();
  var_11 linkto(level.train_car_tag_origin, "tag_origin");
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  var_12 = common_scripts\utility::getstruct("train_car_struct_2", "targetname");
  level.train_car_tag_origin moveto(var_12.origin, 20, 0, 8);
  wait 20;
  common_scripts\utility::flag_wait_any("warehouse_last_push", "player_on_train_platform");
  level thread maps\satfarm_audio::train_leaving();
  objective_onentity(maps\_utility::obj("train"), level.train_car_tag_origin, (-210, -240, 180));
  thread watch_for_player_on_train(var_10, var_11);
  thread player_falls_on_tracks();
  var_13 = common_scripts\utility::getstruct("train_car_allies_load_struct", "targetname");
  level.train_car_tag_origin moveto(var_13.origin, 3, 0, 0);
  wait 3;
  common_scripts\utility::flag_set("send_allies_to_train");
  var_14 = common_scripts\utility::getstruct("train_car_player_fail_struct", "targetname");
  level.train_car_tag_origin moveto(var_14.origin, 22, 0, 0);
  wait 22;

  if(!common_scripts\utility::flag("player_train_trigger")) {
    if(isalive(level.player)) {
      setdvar("ui_deadquote", & "SATFARM_FAIL_TRAIN");
      maps\_utility::missionfailedwrapper();
    }
  }

  if(!common_scripts\utility::flag("warehouse_end")) {
    var_15 = common_scripts\utility::getstruct("train_car_end_struct", "targetname");
    level.train_car_tag_origin moveto(var_15.origin, 15, 0, 0);
    wait 15;
  }

  foreach(var_17 in var_4)
  var_17 delete();

  level.train_car_tag_origin delete();
}

spawn_model_from_struct(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0.script_parameters);
  var_1.targetname = var_0.targetname;
}

watch_for_player_on_train(var_0, var_1) {
  var_2 = getent("train_car_volume", "targetname");
  var_2 enablelinkto();
  var_2 linkto(level.train_car_tag_origin, "tag_origin");
  level.player_touching_volume = undefined;
  thread watch_player_push_volume();

  for(;;) {
    if(level.player istouching(var_2)) {
      if(!isDefined(level.player_touching_volume))
        level.player_touching_volume = 1;

      if(level.player istouching(var_0)) {} else {
        var_0 solid();
        common_scripts\utility::flag_set("player_train_trigger");
        break;
      }
    } else if(isDefined(level.player_touching_volume))
      level.player_touching_volume = undefined;

    wait 0.05;
  }

  level.player forcemovingplatformentity(level.train_car_tag_origin);

  for(;;) {
    if(level.player istouching(var_2)) {
      if(level.player istouching(var_1)) {} else {
        var_1 solid();
        break;
      }
    }

    wait 0.05;
  }
}

watch_player_push_volume() {
  var_0 = getent("push_player_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      if(isDefined(level.player_touching_volume)) {
        level.player pushplayervector((0, 20, 0));
        wait 0.5;
        break;
      }
    }

    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

player_falls_on_tracks() {
  level endon("warehouse_end");
  var_0 = getent("warehouse_train_track_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      if(isalive(level.player)) {
        setdvar("ui_deadquote", & "SATFARM_FAIL_TRAIN");
        maps\_utility::missionfailedwrapper();
      }
    }

    wait 0.05;
  }
}

allies_movement_warehouse() {
  if(level.start_point == "warehouse")
    level.allies[0] thread super_human(1);

  thread allies_vo_warehouse();
  var_0 = getent("warehouse_elevator_volume", "targetname");

  for(;;) {
    var_1 = 1;

    foreach(var_3 in level.allies) {
      if(!var_3 istouching(var_0))
        var_1 = 0;
    }

    if(var_1) {
      common_scripts\utility::flag_set("allies_in_elevator");
      break;
    }

    wait 0.05;
  }

  level.ally_elevator_clip_back solid();
  level.ally_elevator_clip_back disconnectpaths();
  level.allies[0].ignoreall = 1;
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  wait 0.5;
  safe_activate_trigger_with_targetname("move_allies_into_elevator_position");
  common_scripts\utility::flag_wait("warehouse_enemies_alerted");
  wait 0.5;
  level.allies[0].ignoreall = 0;
  level.allies[0].dontmelee = 1;
  level.allies[0].accuracy = 5.0;
  level.allies[0].baseaccuracy = 5.0;
  common_scripts\utility::flag_wait("unload_elevator");
  safe_activate_trigger_with_targetname("move_allies_into_warehouse");
  common_scripts\utility::flag_wait("advance_allies_wave_3a_flag");
  level.allies[0] thread get_to_train_wait_node();
  common_scripts\utility::flag_wait_any("warehouse_last_push", "player_on_train_platform");
  wait 0.1;
  level.allies[0].accuracy = 10.0;
  level.allies[0].baseaccuracy = 10.0;
  var_5 = getent("ghost1_path_to_train_volume", "targetname");
  var_6 = var_5 maps\_utility::get_ai_touching_volume("axis");

  foreach(var_8 in var_6) {
    if(isalive(var_8))
      var_8 kill();
  }

  level.allies[0] thread animate_allies_to_train();
  common_scripts\utility::flag_wait("warehouse_end");
  wait 5;

  foreach(var_3 in level.allies) {
    if(isDefined(var_3.magic_bullet_shield)) {
      var_3 maps\_utility::stop_magic_bullet_shield();
      var_3 delete();
    }
  }
}

allies_vo_warehouse() {
  common_scripts\utility::flag_wait("start_ambient_warehouse_scenarios");
  wait 0.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_theresthetrainstraight");
  common_scripts\utility::flag_wait("warehouse_enemies_alerted");
  thread maps\_utility::set_team_bcvoice("allies", "taskforce");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  common_scripts\utility::flag_wait("advance_allies_wave_3_flag");
  level.allies[0] thread maps\satfarm_code::char_dialog_add_and_go("satfarm_hsh_rorkesgonnabeon");
  common_scripts\utility::flag_wait_any("warehouse_last_push", "player_on_train_platform");
  wait 2.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_trainsleavingletsgo");
  thread train_nag();
  common_scripts\utility::flag_wait_all("player_train_trigger", "ghost1_on_train");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_merrickwereonthe");
  wait 0.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_mrk_solidcopy");
  common_scripts\utility::flag_set("warehouse_end");
}

train_nag() {
  wait 6;

  if(!common_scripts\utility::flag("player_train_trigger"))
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_getonthetrain");

  wait 6;
  common_scripts\utility::flag_wait("ghost1_on_train");

  if(!common_scripts\utility::flag("player_train_trigger"))
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_getonthetrain");
}

animate_allies_to_train() {
  level endon("warehouse_end");
  var_0 = getdvar("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  self pushplayer(1);
  maps\_utility::disable_ai_color();
  self.ignoreall = 1;
  self.dontmelee = 1;
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_danger_react();
  maps\_utility::setflashbangimmunity(1);
  self setCanDamage(0);
  self.dontavoidplayer = 1;
  self.nododgemove = 1;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreexplosionevents = 1;
  self.disableplayeradsloscheck = 1;
  common_scripts\utility::flag_set("ghost1_at_train_node");

  if(!common_scripts\utility::flag("send_allies_to_train"))
    common_scripts\utility::flag_wait("send_allies_to_train");

  var_1 = common_scripts\utility::getstruct("ghost1_train_struct", "targetname");
  var_1 maps\_anim::anim_reach_solo(self, "satfarm_train_jump_straight_run");
  var_1 thread maps\_anim::anim_single_solo(self, "satfarm_train_jump_straight_run");
  wait 0.5;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 linkto(level.train_car_tag_origin, "tag_origin");
  self linkto(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  self waittillmatch("single anim", "end");
  self.ignoreall = 0;
  common_scripts\utility::flag_set("ghost1_on_train");
  setsaveddvar("ai_friendlyFireBlockDuration", var_0);
  common_scripts\utility::flag_wait("ghost1_stop_shooting");
  self.ignoreall = 1;
}

ambient_building_explosions(var_0) {
  level endon(var_0);
  wait 8;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getent("control_tower_building_second_floor_volume", "targetname");
  var_4 = getent("control_tower_building_first_floor_volume", "targetname");
  level.last_ceiling_light_spark_fx_struct = undefined;
  level.ceiling_light_spark_fx_count = 0;

  while(!common_scripts\utility::flag("start_ambient_warehouse_scenarios")) {
    if(common_scripts\utility::flag("building_hit")) {
      var_5 = common_scripts\utility::getstructarray("ceiling_light_spark_fx", "targetname");
      var_6 = common_scripts\utility::getclosest(level.player.origin, var_5);

      if(isDefined(level.last_ceiling_light_spark_fx_struct)) {
        if(level.last_ceiling_light_spark_fx_struct == var_6) {
          var_5 = common_scripts\utility::array_remove(var_5, var_6);
          var_6 = common_scripts\utility::getclosest(level.player.origin, var_5);
        }
      }

      if(level.ceiling_light_spark_fx_count < 2) {
        if(isDefined(var_6.script_fxid))
          playFX(common_scripts\utility::getfx(var_6.script_fxid), var_6.origin);

        level.last_ceiling_light_spark_fx_struct = var_6;
        level.ceiling_light_spark_fx_count++;
      } else
        level.ceiling_light_spark_fx_count = 0;
    }

    if(level.player istouching(var_4))
      var_2 = common_scripts\utility::getstructarray("ceiling_dust_fx_first_floor", "script_noteworthy");
    else if(level.player istouching(var_3))
      var_2 = common_scripts\utility::getstructarray("ceiling_dust_fx_second_floor", "script_noteworthy");

    foreach(var_8 in var_2) {
      if(isDefined(var_8.script_fxid))
        playFX(common_scripts\utility::getfx(var_8.script_fxid), var_8.origin);
    }

    var_10 = randomfloatrange(0.1, 0.4);
    earthquake(var_10, 1, level.player.origin, 512);
    var_11 = common_scripts\utility::getstructarray("mortar_explosion_sound_struct", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_11);
    level thread maps\satfarm_audio::tower_ambient_explosions(var_1.origin);
    wait(randomfloatrange(8, 12));
  }

  for(;;) {
    var_2 = common_scripts\utility::getstructarray("ceiling_dust_fx_warehouse", "script_noteworthy");

    foreach(var_8 in var_2) {
      if(isDefined(var_8.script_fxid))
        playFX(common_scripts\utility::getfx(var_8.script_fxid), var_8.origin);
    }

    var_10 = randomfloatrange(0.1, 0.4);
    earthquake(var_10, 1, level.player.origin, 512);
    var_11 = common_scripts\utility::getstructarray("mortar_explosion_sound_struct", "targetname");
    var_1 = common_scripts\utility::getclosest(level.player.origin, var_11);
    level.player playSound("satf_building_shake_ly2");
    wait(randomfloatrange(0.4, 0.7));
    thread common_scripts\utility::play_sound_in_space("satf_building_shake", var_1.origin);
    wait(randomfloatrange(8, 12));
  }
}

wall_lights() {
  var_0 = getEntArray("wall_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::wall_lights_think);
  var_1 = getent("spinning_light_object", "targetname");
  var_1 thread wall_lights_think(1);
  common_scripts\utility::flag_wait("warehouse_end");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3 delete();
  }
}

wall_lights_think(var_0) {
  level endon("warehouse_end");
  var_1 = 5000;
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.angles = (0, 90, 0);
    self.angles = (0, 0, 0);
    self linkto(var_2, "tag_origin");
  }

  for(;;) {
    if(isDefined(var_0))
      var_2 rotatevelocity((0, 0, 360), var_1);
    else
      self rotatevelocity((360, 0, 0), var_1);

    wait(var_1);
  }
}

sprinkler_fx() {
  var_0 = common_scripts\utility::getstructarray("fire_sprinkler_fx", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_fxid)) {
      var_3.sprinkler_fx_tag = var_3 common_scripts\utility::spawn_tag_origin();
      playFXOnTag(common_scripts\utility::getfx(var_3.script_fxid), var_3.sprinkler_fx_tag, "tag_origin");
    }
  }

  common_scripts\utility::flag_wait("elevator_landed");

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_fxid)) {
      stopFXOnTag(common_scripts\utility::getfx(var_3.script_fxid), var_3.sprinkler_fx_tag, "tag_origin");

      if(isDefined(var_3.sprinkler_fx_tag))
        var_3.sprinkler_fx_tag delete();
    }
  }
}

temp_dialogue(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2))
    var_2 = 4;

  if(isDefined(level.tmp_subtitle)) {
    level.tmp_subtitle destroy();
    level.tmp_subtitle = undefined;
  }

  level.tmp_subtitle = newhudelem();
  level.tmp_subtitle.x = -60;
  level.tmp_subtitle.y = -62;
  level.tmp_subtitle settext("^2" + var_0 + ": ^7" + var_1);
  level.tmp_subtitle.fontscale = 1.46;
  level.tmp_subtitle.alignx = "center";
  level.tmp_subtitle.aligny = "middle";
  level.tmp_subtitle.horzalign = "center";
  level.tmp_subtitle.vertalign = "bottom";
  level.tmp_subtitle.sort = 1;
  wait(var_2);
  thread temp_dialogue_fade();
}

temp_dialogue_fade() {
  level endon("temp_dialogue");

  for(var_0 = 1.0; var_0 > 0.0; var_0 = var_0 - 0.1) {
    level.tmp_subtitle.alpha = var_0;
    wait 0.05;
  }

  level.tmp_subtitle destroy();
}

tower_to_bridge_deploy_bink() {
  common_scripts\utility::waitframe();
  thread maps\satfarm_audio::overlord_trans2();
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player.ignoreme = 1;
  setsaveddvar("compass", 0);
  common_scripts\utility::waitframe();
  setdvar("paris_transition_movie", "1");
  setsaveddvar("ui_nextMission", "1");
  maps\_utility::nextmission();
}