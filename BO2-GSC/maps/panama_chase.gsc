/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_chase.gsc
**************************************/

#include common_scripts\utility;
#include maps\panama_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_turret;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_gameskill;
#include maps\_music;
#include maps\createart\panama3_art;
#include maps\_audio;

skipto_chase() {
  level.mason = init_hero("mason");
  level.noriega = init_hero("noriega");
  level.noriega thread check_for_friendly_fire_noriega();
  a_heroes = array(level.mason, level.noriega);
  hurt_trigger = getent("fight_room_hurt_trigger", "targetname");
  hurt_trigger trigger_off();
  skipto_teleport("player_skipto_chase", a_heroes);
}

skipto_checkpoint() {
  level.mason = init_hero("mason");
  level.noriega = init_hero("noriega");
  level.noriega thread check_for_friendly_fire_noriega();
  a_heroes = array(level.mason, level.noriega);
  trigger_off("checkpoint_end_trigger", "targetname");
  skipto_teleport("player_skipto_checkpoint", a_heroes);
  level.player setlowready(1);
  level.noriega change_movemode("sprint");
  level.noriega setgoalnode(getnode("noriega_checkpoint_cover", "targetname"));
  level.mason change_movemode("sprint");
  level.mason setgoalnode(getnode("mason_checkpoint_cover", "targetname"));
  flag_set("movie_done");
}

main() {
  level thread chase_dialog();
  chase_setup();
  noriega_rescue_event();
  apache_jump_event();
}

chase_setup() {
  trigger_off("noriega_rescue_trigger", "targetname");
  trigger_off("checkpoint_end_trigger", "targetname");
  level thread maps\createart\panama3_art::chase();
  m_clinic_stairs_blocker = getent("clinic_stairs_blocker", "targetname");
  m_clinic_stairs_blocker notsolid();
  m_noriega_bookshelf_door = getent("noriega_bookshelf_door", "targetname");
  m_noriega_bookshelf_door trigger_off();
  m_noriega_door_close = getent("noriega_door_closed", "targetname");
  m_noriega_door_close trigger_off();
  level thread chase_vo();
}

init_flags() {
  flag_init("jump_start");
  flag_init("chase_player_jumped");
  flag_init("clinic_wall_contact");
  flag_init("clinic_break_window");
  flag_init("chase_rescue_noriega");
  flag_init("checkpoint_approach_one");
  flag_init("checkpoint_approach_two");
  flag_init("checkpoint_reached");
  flag_init("checkpoint_cleared");
  flag_init("checkpoint_finished");
  flag_init("checkpoint_fade_now");
  flag_init("start_mason_run");
}

noriega_rescue_event() {
  level.mason setgoalnode(getnode("chase_mason_stairwell_cover", "targetname"));
  run_scene_first_frame("noriega_fight");
  guard_1 = get_ais_from_scene("noriega_fight", "marine_struggler1");
  guard_1 thread check_for_friendly_fire();
  guard_2 = get_ais_from_scene("noriega_fight", "marine_struggler2");
  guard_2 thread check_for_friendly_fire();
  trigger_wait("chase_door_trigger");
  setsaveddvar("r_enableFlashlight", "0");
  level thread clinic_break_wall_think();
  level thread clinic_break_window_think();
  level.player allowsprint(0);
  level thread maps\_audio::switch_music_wait("PANAMA_BAD_NORIEGA", 2);
  run_scene("noriega_fight");
  flag_set("chase_rescue_noriega");
  level thread run_scene("dead_soldier_fell_2");
  level thread noriega_rescue_timer();
  level thread marine_search_party();
  wait 0.05;
  playfxontag(level._effect["flashlight"], getent("marine_searcher1_ai", "targetname"), "tag_flash");
  playfxontag(level._effect["flashlight"], getent("marine_searcher2_ai", "targetname"), "tag_flash");
  stop_exploder(106);
  level.player allowsprint(1);
  wait 0.15;
  wait 4;
  trigger_on("noriega_rescue_trigger", "targetname");
  trigger_wait("noriega_rescue_trigger");
  m_clinic_stairs_blocker = getent("clinic_stairs_blocker", "targetname");
  m_clinic_stairs_blocker show();
  m_clinic_stairs_blocker solid();
  m_noriega_door_open = getent("noriega_door_open", "targetname");
  m_noriega_door_open hide();
  m_noriega_door_close = getent("noriega_door_closed", "targetname");
  m_noriega_door_close trigger_on();
  m_noriega_bookshelf_floor = getent("noriega_bookshelf_floor", "targetname");
  m_noriega_bookshelf_floor hide();
  m_noriega_bookshelf_door = getent("noriega_bookshelf_door", "targetname");
  m_noriega_bookshelf_door trigger_on();
  level notify("noriega_rescued");
  end_scene("noriega_falls");
  level thread heli_missile_damage_event_manager();
  level thread jump_fall_fail_think();
  exploder(720);
  level thread run_scene("noriega_saved_irstrobe");
  strobe_model = get_model_or_models_from_scene("noriega_saved_irstrobe", "ir_strobe");
  playfxontag(level._effect["irstrobe_ac130"], strobe_model, "tag_origin");
  delay_thread(22, ::autosave_now);
  level thread run_scene("noriega_saved_noriega");
  level thread run_scene("noriega_saved_mason");
  run_scene("noriega_saved_player");
  level thread start_ac130_shooting();
}

marine_search_party() {
  level thread run_scene("marine_search_party");
  guard = get_ais_from_scene("marine_search_party", "marine_searcher1");
  guard thread check_for_friendly_fire();
  guard = get_ais_from_scene("marine_search_party", "marine_searcher2");
  guard thread check_for_friendly_fire();
  scene_wait("marine_search_party");
  run_scene("noriega_saved_marine");
}

start_ac130_shooting() {
  level.player playsound("evt_panama_chase_gunfire");
  level thread turn_fight_room_unsafe();
  exploder(730);
  level notify("fxanim_ceiling_01_start");
  initial_target = getent("apache_reveal_target", "targetname");
  level thread ac130_shoot(initial_target.origin, 1);
  level thread ac130_target_player();
  trigger_wait("apache_strafe_start_trigger");
  second_target = getent("apache_jump_attack_target", "targetname");
  level thread ac130_shoot(second_target.origin, 1);
  level notify("fxanim_ceiling_02_start");
  level thread ac130_target_player();
  trigger_wait("chase_go_for_it_trigger");
  level notify("fxanim_ceiling_03_start");
  third_target = getent("apache_missile_target2", "targetname");
  level thread ac130_shoot(third_target.origin, 1);
  level thread ac130_target_player();
  trigger_wait("apache_chase_jump_trigger");
  level.player thread magic_bullet_shield();
  water_tower_target = getent("apache_missile_target1", "targetname");
  level thread ac130_shoot(water_tower_target.origin, 1);
  level notify("player_moved");
}

turn_fight_room_unsafe() {
  hurt_trigger = getent("fight_room_hurt_trigger", "targetname");
  wait 5;
  hurt_trigger trigger_on();
}

ac130_target_player() {
  level notify("player_moved");
  level endon("player_moved");
  wait 5;

  while(true)
    ac130_shoot(level.player.origin, 1);
}

check_for_friendly_fire() {
  level endon("noriega_rescued");
  self thread magic_bullet_shield();
  self waittill("damage");
  missionfailedwrapper(&"PANAMA_FRIENDLY_FIRE_FAILURE");
}

temp_run_anim_to_idle(str_start_scene, str_idle_scene) {
  level endon("player_jumped_first");
  run_scene(str_start_scene);
  level thread run_scene(str_idle_scene);
}

apache_jump_event() {
  flag_set("jump_start");
  level thread mason_jump();
  level thread noriega_jump();
  level thread prevent_player_damage_if_the_player_is_sprinting();
  level thread alleyway_to_checkpoint_vo();
  trigger_wait("player_jump_landing_trigger");
  level notify("player_jumped_first");
  end_scene("dead_soldier_fell");
  end_scene("marine_search_party");
  level thread run_scene("player_jump_landing");
  level notify("chase_jump_cleared");
  level.player setlowready(1);
  level.player.overrideplayerdamage = undefined;
  level.player thread stop_magic_bullet_shield();
  end_scene("mason_waits_for_jump");
  run_scene("mason_balcony_jump");
  level thread run_scene("mason_noreiga_wall_hug");
  level thread loop_after_wall_hug();
  wait 1;
  little_bird = spawn_vehicle_from_targetname("little_bird_patroller");
  little_bird thread check_for_friendly_fire_noriega();
  little_bird_pilot = simple_spawn_single("little_bird_pilots");
  little_bird_pilot thread enter_vehicle(little_bird, "tag_driver");
  little_bird setdefaultpitch(25);
  little_bird setspeed(15);
  level.temp_flash_light = spawn("script_model", little_bird gettagorigin("tag_flash"));
  level.temp_flash_light.angles = little_bird gettagangles("tag_flash");
  level.temp_flash_light setmodel("tag_origin");
  level.temp_flash_light linkto(little_bird);
  playfxontag(level._effect["apache_spotlight_cheap"], level.temp_flash_light, "tag_origin");
  water_tower_origin = getent("litte_bird_water_tower_origin", "targetname");
  little_bird setvehgoalpos(water_tower_origin.origin, 1);
  little_bird thread look_at_water_tower();
  little_bird_checkpoint = spawn_vehicle_from_targetname("little_bird_patroller_checkpoint");
  little_bird_checkpoint thread check_for_friendly_fire_noriega();
  little_bird_checkpoint setdefaultpitch(25);
  little_bird_checkpoint setspeed(15);
  little_bird_checkpoint thread little_bird_checkpoint_hovering();
}

heli_check_for_spotlight() {
  spotlight_trigger = getent("flash_light_trigger", "targetname");
  spotlight_linkto = getent("flash_light_trigger_linkto", "targetname");
  spotlight_trigger enablelinkto();
  spotlight_trigger linkto(spotlight_linkto);
  spot_dest = getstruct("spot_light_destination", "targetname");
  wait 3;
  spotlight_linkto movey(-1550, 10);
  spotlight_trigger waittill("trigger");
  level notify("player_detected");
  self clearvehgoalpos();
  self setlookatent(level.player);
  self thread set_turret_target(level.player, vectorscale((0, 0, 1), 40.0), 1);
  self thread set_turret_target(level.player, vectorscale((0, 0, 1), 40.0), 2);

  while(true) {
    self thread shoot_turret_at_target(level.player, 5, vectorscale((0, 0, 1), 40.0), 1);
    self thread shoot_turret_at_target(level.player, 5, vectorscale((0, 0, 1), 40.0), 2);
    wait 5;
  }
}

loop_after_wall_hug() {
  level endon("player_not_looking");
  level endon("player_trigger_checkpoint");
  scene_wait("mason_noreiga_wall_hug");
  run_scene("mason_noreiga_wall_hug_loop");
}

prevent_player_damage_if_the_player_is_sprinting() {
  level endon("chase_jump_cleared");

  while(true) {
    if(level.player sprintbuttonpressed())
      level.player.overrideplayerdamage = ::player_damage_override_for_apache;
    else
      level.player.overrideplayerdamage = undefined;

    wait 0.05;
  }
}

player_damage_override_for_apache(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name) {
  return false;
}

look_at_water_tower() {
  level endon("player_detected");
  self little_bird_investigate_water_tower();
}

little_bird_checkpoint_hovering() {
  lb_checkpoint_destination = getent("litte_bird_checkpoint_origin", "targetname");
  lb_checkpoint_flyto = getent("litte_bird_checkpoint_destination", "targetname");
  lb_lookat = getent("apache_checkpoint_target", "targetname");
  self setturrettargetent(level.player);
  self clearvehgoalpos();
  self setvehgoalpos(lb_checkpoint_flyto.origin, 1);
  self sethoverparams(30, 120, 80);
  trigger_wait("checkpoint_reached_trigger");
  self setturrettargetent(level.player);
  flag_wait("checkpoint_reached");
  level.temp_flash_light unlink();
  level.temp_flash_light.origin = self gettagorigin("tag_flash");
  level.temp_flash_light.angles = self gettagangles("tag_flash");
  level.temp_flash_light linkto(self);
  wait 2;
  self setturrettargetent(level.noriega);
  wait 7;
  lb_checkpoit_goal = getent("litte_bird_checkpoint_goal", "targetname");
  self setvehgoalpos(lb_checkpoit_goal.origin, 1);
  flag_wait("checkpoint_cleared");
  self delete();
  level.temp_flash_light delete();
}

little_bird_investigate_water_tower() {
  level endon("player_detected");
  self waittill("goal");
  self sethoverparams(30, 0, 10);
  target1 = getent("apache_spotlight_search_target1", "targetname");
  target2 = getent("apache_spotlight_search_target3", "targetname");
  lookat = spawn("script_model", target1.origin);
  lookat setmodel("tag_origin");
  self setturrettargetent(lookat);
  lookat moveto(target2.origin, 2);
  lookat waittill("movedone");
  lookat moveto(target1.origin, 2);
  lookat waittill("movedone");
  lookat moveto(target2.origin, 2);
  lookat waittill("movedone");
  lookat moveto(target1.origin, 2);
  lookat waittill("movedone");
  self clearturrettarget();
  lb_destination = getent("litte_bird_checkpoint_goal", "targetname");
  self setvehgoalpos(lb_destination.origin);
  self waittill("goal");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

move_little_bird_to_checkpoint() {
  trigger_wait("move_little_bird_in_place_trigger");
  self notify("move_little_bird_in_position");
}

noriega_jump() {
  level endon("chase_jump_cleared");
  scene_wait("noriega_saved_noriega");
  run_scene("noriega_balcony_idle");
}

mason_jump() {
  level endon("chase_jump_cleared");
  scene_wait("noriega_saved_mason");
  run_scene("mason_waits_for_jump");
}

clinic_break_wall_think() {
  flag_wait("clinic_wall_contact");
  level notify("fxanim_wall_fall_start");
  activate_exploder(710);
}

clinic_break_window_think() {
  s_chase_window_impulse_position = getstruct("chase_window_impulse_position", "targetname");
  ai_firing_soldier = getent("marine_struggler1_ai", "targetname");
  wait 0.75;
  playfxontag(level._effect["soldier_impact_blood"], ai_firing_soldier, "j_clavicle_le");
  wait 0.25;
  physicsexplosionsphere(s_chase_window_impulse_position.origin, 100, 1, 100);
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
  magicbullet("ak47_sp", s_chase_window_impulse_position.origin, s_chase_window_impulse_position.origin + vectorscale((0, -1, 0), 100.0));
}

noriega_rescue_timer() {
  level endon("noriega_rescued");
  level.noriega stop_magic_bullet_shield();
  level thread run_scene("noriega_falls");
  wait 9.0;
  level notify("mission failed");
  maps\_utility::missionfailedwrapper("PANAMA_ABANDON_MISSION");
}

jump_fall_fail_think() {
  level endon("chase_jump_cleared");
  trigger_wait("apache_jump_fall_trigger");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
  wait 1.0;
  level.player freezecontrols(1);
}

apache_player_kill_timer(n_time, v_offset, do_target_player) {
  level endon("stop_kill_timer");
  wait(n_time);

  if(do_target_player) {
    self setlookatent(level.player);
    wait 1.0;
  }

  self thread shoot_turret_at_target(level.player, 120, v_offset, 0);
}

apache_player_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  e_apache = getent("attack_apache", "targetname");

  if((!isDefined(level.player.n_previous_damage_time) || level.player issprinting() && gettime() - level.player.n_previous_damage_time > 500) && eattacker == e_apache) {
    level.player.n_previous_damage_time = gettime();
    idamage = 0;
    showdamage = 1;
  } else if(level.player issprinting() && eattacker == e_apache) {
    idamage = 0;
    showdamage = 0;
  } else if(eattacker == e_apache) {
    idamage = 80;
    showdamage = 1;
  } else {
    idamage = 0;
    showdamage = 1;
  }

  if(showdamage == 0)
    self cleardamageindicator();

  return idamage;
}

chase_vo() {
  trigger_wait("chase_go_for_it_trigger");
  trigger_wait("chase_jump_vo_trigger");
}

checkpoint_approach_vo() {
  trigger_wait("checkpoint_vo_trigger");
  level.player say_dialog("huds_mason_0");
  level.mason say_dialog("maso_hudson_where_the_h_0", 0.5);
  level.player say_dialog("huds_are_you_at_the_check_0", 1.0);
}

checkpoint_event() {
  flag_set("checkpoint_approach_one");
  level thread run_scene("checkpoint_start_idle_guards");
  level thread run_scene("gate2_guards");
  level thread run_scene("checkpoint_triage");
  level thread run_scene("checkpoint_sitgroup");
  level thread run_scene("checkpoint_soldiers_resting");
  trigger_wait("checkpoint_approach_trigger");
  level.player disableoffhandweapons();
  level.player setlowready(1);
  flag_set("checkpoint_approach_two");
  level thread run_scene("checkpoint_patrol1");
  level thread run_scene("checkpoint_patrol2");
  level thread run_anim_to_idle("checkpoint_patrol3", "checkpoint_patrol3_idle");
  level thread run_scene("checkpoint_tieup");
  level thread run_scene("checkpoint_tieup_soldier3");
  trigger_wait("checkpoint_reached_trigger");
  level thread maps\createart\panama3_art::checkpoint();
  trigger_wait("slow_down_player");
  level.player allowsprint(0);
  level thread player_look_check();
  level waittill_either("player_not_looking", "player_trigger_checkpoint");
  flag_set("checkpoint_reached");
  end_scene("mason_noreiga_wall_hug");

  if(flag("player_not_looking"))
    level thread run_scene("checkpoint_ally_walkout_noreach");
  else
    level thread run_scene("checkpoint_ally_walkout", 1);

  level.mason attach("p6_anim_military_id_card", "tag_weapon_left");
  flag_wait("checkpoint_fade_now");
  level thread blackscreen(1, 3, 0);
  wait 1;
  level thread old_man_woods("panama_int_2");
  wait 0.5;
  flag_set("checkpoint_cleared");
  flag_set("checkpoint_finished");
  level notify("stop_speed_think");
  level.player setmovespeedscale(1);
  level.player setlowready(0);
  level.player allowsprint(1);
  end_scene("gate2_guards");
  end_scene("checkpoint_triage");
  end_scene("checkpoint_sitgroup");
  end_scene("checkpoint_soldiers_resting");
  end_scene("checkpoint_patrol3_idle");
  end_scene("checkpoint_tieup");
  end_scene("checkpoint_advance_guard2");
  clearallcorpses();
}

player_look_check() {
  lookat = getent("apache_checkpoint_target", "targetname");

  while(true) {
    if(level.player is_player_looking_at(lookat.origin, 0.1, 1)) {
      flag_set("player_not_looking");
      break;
    }

    wait 0.05;
  }
}

checkpoint_passthrough() {
  run_anim_to_idle("checkpoint_advance_guard2", "checkpoint_stop_idle_guard2");
  trigger_wait("checkpoint_passthrough_trigger");
  run_anim_to_idle("checkpoint_cleared_guard2", "checkpoint_end_idle_guard2");
}

heli_path_manager() {
  e_apache = spawn_vehicle_from_targetname("attack_apache");
  playfxontag(getfx("apache_exterior_lights"), e_apache, "tag_origin");
  s_apache_strafe_start = getstruct("apache_strafe_start", "targetname");
  e_apache godon();
  e_apache setspeed(20.0);
  e_apache thread heli_go_struct_path(getstruct("apache_attack_start", "targetname"));
  e_target = getent("apache_reveal_target", "targetname");
  e_apache setlookatent(e_target);
  e_apache set_turret_target(e_target, undefined, 0);
  e_apache thread set_pitch(0, 20, 1);
  e_apache waittill("path_finished");
  wait 2.0;
  e_apache_barrel = spawn_model("tag_origin", e_apache gettagorigin("tag_barrel"), e_apache gettagangles("tag_barrel"));
  e_apache_barrel linkto(e_apache, "tag_barrel");
  playfxontag(getfx("apache_spotlight"), e_apache_barrel, "tag_origin");
  e_apache thread heli_go_struct_path(s_apache_strafe_start);
  e_apache waittill("path_finished");
  setdvar("ui_deadquote", & "PANAMA_APACHE_ESCAPE_FAIL");
  level.player.overrideplayerdamage = ::apache_player_damage_callback;
  e_apache setlookatent(level.player);
  e_apache set_turret_target(level.player, undefined, 0);
  e_apache setspeed(20.0);
  e_apache thread apache_player_kill_timer(15.0, undefined, 0);
  trigger_wait("apache_strafe_start_trigger");
  level notify("helicopter_hallway_start");
  level notify("stop_kill_timer");
  e_apache thread shoot_turret_at_target(level.player, 2000.0, (0, 0, 0), 0);
  e_apache thread heli_strafe_follow_player(s_apache_strafe_start, 512.0);
  trigger_wait("apache_chase_jump_trigger");
  flag_set("chase_player_jumped");
  e_apache stop_turret(0);
  e_apache clearlookatent();
  e_apache clear_turret_target(0);
  wait 0.05;
  e_apache setlookatent(getent("apache_jump_attack_target", "targetname"));
  e_apache setspeed(60.0, 60.0, 60.0);
  e_apache thread heli_go_struct_path(getstruct("jump_missile_fire_position_start", "targetname"));
  e_apache waittill("path_finished");
  e_apache setspeed(30.0);
  e_apache shoot_turret_at_target_once(getent("apache_missile_target1", "targetname"), undefined, 1);
  e_apache shoot_turret_at_target_once(getent("apache_missile_target2", "targetname"), undefined, 2);
  e_apache clear_turret_target(1);
  e_apache clear_turret_target(2);
  e_spotlight_search_target1 = getent("apache_spotlight_search_target1", "targetname");
  e_spotlight_search_target2 = getent("apache_spotlight_search_target2", "targetname");
  e_spotlight_search_target3 = getent("apache_spotlight_search_target3", "targetname");
  e_apache setspeed(60.0);
  e_apache thread heli_go_struct_path(getstruct("apache_spotlight_search_start", "targetname"));
  e_apache setlookatent(e_spotlight_search_target1);
  e_apache set_turret_target(e_spotlight_search_target1, undefined, 0);
  e_apache waittill("path_finished");
  wait 3.0;
  e_apache setlookatent(e_spotlight_search_target2);
  e_apache set_turret_target(e_spotlight_search_target2, undefined, 0);
  wait 1.0;
  e_apache set_turret_target(e_spotlight_search_target3, undefined, 0);
  wait 2.0;
  e_apache_checkpoint_target = getent("apache_checkpoint_target", "targetname");
  e_apache_barrel delete();
  e_apache clearlookatent();
  e_apache clear_turret_target(0);
  e_apache thread heli_go_struct_path(getstruct("apache_checkpoint_wait_position", "targetname"));
  wait 2.0;
  e_apache setlookatent(e_apache_checkpoint_target);
  e_apache set_turret_target(e_apache_checkpoint_target, undefined, 0);
  e_apache_barrel = spawn_model("tag_origin", e_apache gettagorigin("tag_barrel"), e_apache gettagangles("tag_barrel"));
  e_apache_barrel linkto(e_apache, "tag_barrel");
  trigger_wait("checkpoint_reached_trigger");
  playfxontag(getfx("apache_spotlight"), e_apache_barrel, "tag_origin");
  wait 4.0;
  e_apache_barrel delete();
  e_apache clearlookatent();
  e_apache clear_turret_target(0);
  e_apache thread heli_go_struct_path(getstruct("apache_delete_position", "targetname"));
  e_apache waittill("path_finished");
  e_apache delete();
}

heli_strafe_follow_player(s_start_position, n_distance) {
  while(!flag("chase_player_jumped")) {
    wait 0.05;
    self setvehgoalpos((s_start_position.origin[0], level.player.origin[1] - n_distance, s_start_position.origin[2]), 0, 0);
  }
}

heli_missile_damage_event_manager() {
  water_tower = getent("ac130_water_tower", "targetname");
  trigger_wait("apache_chase_jump_trigger");
  level notify("fxanim_water_tower_start");
  wait 0.05;
  water_tower = getent("ac130_water_tower", "targetname");
  playfxontag(level._effect["fx_pan_water_tower_collapse"], water_tower, "base_jnt");
  activate_exploder(700);
}

heli_go_struct_path(s_start) {
  s_current = s_start;
  self.is_pathing = 1;
  self sethoverparams(10);

  while(self.is_pathing) {
    if(isDefined(s_current.target))
      self setvehgoalpos(s_current.origin, 0, 0);
    else
      self setvehgoalpos(s_current.origin, 1, 0);

    if(isDefined(s_current.radius))
      self setneargoalnotifydist(s_current.radius);

    self waittill("near_goal");

    if(isDefined(s_current.speed))
      self setspeed(s_current.speed);

    self waittill("goal");

    if(isDefined(s_current.target)) {
      s_current = getstruct(s_current.target, "targetname");
      assert(isDefined(s_current), "Target entity is not a struct or is undefined: " + s_current.targetname);
    } else
      self.is_pathing = 0;
  }

  self notify("path_finished");
}

set_pitch(n_start_pitch, n_end_pitch, n_time) {
  n_step_time = 0.05;
  n_steps = n_time / n_step_time;
  n_pitch_range = n_end_pitch - n_start_pitch;
  n_pitch_step = 0;

  if(n_steps > 0)
    n_pitch_step = abs(n_pitch_range) / n_steps;

  n_current_pitch = n_start_pitch;

  while(n_current_pitch != n_end_pitch) {
    wait(n_step_time);

    if(n_pitch_range > 0)
      n_current_pitch = min(n_current_pitch + n_pitch_step, n_end_pitch);
    else if(n_pitch_range < 0)
      n_current_pitch = max(n_current_pitch - n_pitch_step, n_end_pitch);

    self setdefaultpitch(n_current_pitch);
  }
}

chase_dialog() {
  trigger_wait("chase_stair_VO");
  level thread vo_before_struggle_room();
  scene_wait("noriega_fight");
  fakeredshirt = spawn("script_origin", (24485, 34936, 639));
  fakeredshirt say_dialog("reds_shit_we_got_a_man_0", 0, 1);
  fakeredshirt thread say_dialog("reds_holy_shit_0", 0, 1);
  fakeredshirt say_dialog("reds_where_d_he_come_from_0", 0, 1);
  fakeredshirt say_dialog("reds_up_there_on_the_led_0", 0, 1);
  trigger_wait("noriega_rescue_trigger");
  wait 2;
  fakeredshirt say_dialog("reds_fuck_they_went_back_0", 0, 1);
  fakeredshirt say_dialog("reds_spooky_1_2_immediate_0", 0, 1);
  fakeredshirt say_dialog("reds_everyone_clear_out_0", 0, 1);
  wait 5;
  fakeredshirt delete();
}

vo_before_struggle_room() {
  trigger = getent("chase_door_trigger", "targetname");
  trigger endon("trigger");
  solider = getent("marine_struggler1_ai", "targetname");
  solider say_dialog("usr3_woah_woah_hold_fi_0");
  solider say_dialog("usr2_hold_it_okay_0");
  solider say_dialog("usr3_hey_what_d_he_tell_0");
  solider say_dialog("sold_do_not_fucking_move_0");
  level.mason say_dialog("maso_awww_shit_0", 0.5);
}

alleyway_to_checkpoint_vo() {
  trigger_wait("jump_door_ai_trigger");
  level.mason say_dialog("maso_okay_checkpoint_s_0");
  level.player say_dialog("wood_good_beat_i_can_0", 1);
  level.mason say_dialog("maso_yes_0", 0.5);
}