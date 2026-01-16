/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_speech.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_vehicle;
#include maps\yemen_utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\_drones;
#include maps\_objectives;
#include maps\_music;
#include maps\_skipto;
#include maps\yemen_anim;
#include maps\createart\yemen_art;
#include maps\_audio;
#include maps\yemen_market;

init_flags() {
  flag_init("player_at_door");
  flag_init("speech_start");
  flag_init("speech_fadein_starting");
  flag_init("speech_start_vtol");
  flag_init("player_turn");
  flag_init("menendez_grabs_player");
  flag_init("player_turns_back");
  flag_init("speech_end");
  flag_init("menendez_exited");
}

init_spawn_funcs() {
  add_spawn_function_group("menendez_speech", "targetname", ::spawn_func_menendez);
}

spawn_func_menendez() {
  level.menendez = self;
}

init_doors() {
  e_exit_door = getent("menendez_exit_door", "targetname");
  e_exit_door_collision = getent(e_exit_door.target, "targetname");
  e_exit_door_collision linkto(e_exit_door);
}

skipto_intro() {
  dead_stat = level.player get_story_stat("DEFALCO_DEAD_IN_KARMA");

  if(dead_stat == 0)
    level.is_defalco_alive = 1;
  else
    level.is_defalco_alive = 0;
}

skipto_intro_defalco_alive() {
  level.is_defalco_alive = 0;
}

skipto_speech() {
  skipto_teleport("skipto_speech");
  maps\yemen_anim::speech_anims();
  load_gump("yemen_gump_speech");
  level.is_defalco_alive = 1;
  level thread menendez_at_door();
}

intro_main() {
  iprintln("Intro");

  maps\yemen_anim::speech_anims();
  flag_wait("yemen_gump_speech");
  yemen_speech_setup();
  menendez_intro();
}

speech_main() {
  iprintln("Speech");

  flag_set("speech_start");
  menendez_speech();
  level thread speech_vtols_arrive();
  level thread speech_menendez_quad_targets();
  level thread speech_clean_up();
}

speech_fade_in() {
  screen_fade_out(0, undefined, 1);
  flag_wait("speech_fadein_starting");
  level thread screen_fade_in(1);
}

yemen_speech_setup() {
  run_scene_first_frame("speech_player_intro");
  run_scene_first_frame("speech_opendoors_doors");
  exploder(1000);
  exploder(1010);
  exploder(10);
  maps\createart\yemen_art::menendez_intro();
}

speech_clean_up() {
  trigger_wait("speech_clean_up");
  a_drone_structs = getstructarray("speech_drone_struct", "script_noteworthy");
  array_delete(a_drone_structs, 1);

  if(!is_after_skipto("speech")) {
    delete_models_from_scene("vtols_arrive_stage_guards");
    delete_models_from_scene("stage_backup_guards");
    delete_scene("vtols_arrive_stage_guards", 1);
    delete_scene("stage_backup_guards", 1);
  }
}

snapshot_start() {
  flag_wait("all_players_connected");
  wait 0.1;
  level clientnotify("yem_start");
}

menendez_intro() {
  level thread vo_menendez_intro();
  setmusicstate("YEMEN_INTRO");
  level thread snapshot_start();
  run_scene_first_frame("speech_menendez_intro");
  level.menendez = get_ai("menendez_speech_ai", "targetname");
  level.menendez.team = "allies";
  level.menendez.name = "";
  level waittill("start_hallway_actors");
  level thread menendez_intro_hallway();
  level thread run_player_intro();
  run_scene_and_delete("speech_menendez_intro");

  if(level.is_defalco_alive == 1) {
    level thread menendez_greeters_defalco_animate("speech_defalco_greeter_intro_1");
    run_scene_and_delete("speech_menendez_walk_hallway_defalco");
  } else
    run_scene_and_delete("speech_menendez_walk_hallway");

  level notify("menendez_at_door");
  level thread menendez_at_door();
}

menendez_at_door() {
  level endon("cleanup_hallway");
  n_idle = 0;
  n_nag = 0;
  run_scene("speech_menendez_hallway_nag_1");
  scene_wait("speech_menendez_hallway_nag_1");
  level thread run_scene("speech_menendez_hallway_endidle");
  wait 6;
  run_scene_and_delete("speech_menendez_hallway_nag_2");
  level thread run_scene("speech_menendez_hallway_endidle");
  wait 4;
  run_scene_and_delete("speech_menendez_hallway_nag_3");
  level thread run_scene("speech_menendez_hallway_endidle");
}

run_player_intro() {
  menendez_intro_player_setup();
  level thread run_scene_and_delete("speech_player_intro");
  flag_wait("speech_player_intro_started");
  m_player_body = get_model_or_models_from_scene("speech_player_intro", "player_body");
  m_player_body attach("c_mul_cordis_head1_1", "", 1);
  scene_wait("speech_player_intro");
  waittillframeend;
  level.player thread player_walk_speed_adjustment(level.menendez, "cleanup_hallway", 128, 256, 0.25, 0.5);
}

menendez_intro_hallway() {
  if(level.is_defalco_alive == 1) {
  } else
    level thread menendez_greeters_animate("speech_greeter_intro_1");

  level thread menendez_greeters_animate("speech_greeter_intro_2");
  level thread menendez_intro_hallway_animate_group("menendez_intro_crates");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_a");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_b");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_c");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_d");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_e");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_f");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_g");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_h");
  level thread menendez_intro_hallway_animate_group("speech_intro_salute_i");
}

menendez_intro_hallway_animate_group(str_scene) {
  run_scene_first_frame(str_scene);
  level waittill("start_hallway_guards");
  level thread run_scene_and_delete(str_scene);

  if(str_scene != "speech_intro_salute_c" && str_scene != "speech_intro_salute_g" && str_scene != "speech_intro_salute_h" && str_scene != "speech_intro_salute_i")
    maps\yemen_utility::give_scene_models_guns(str_scene);

  scene_wait(str_scene);
  level thread run_scene_and_delete(str_scene + "_endloop");
  level waittill("cleanup_hallway");
  wait 0.5;
  end_scene(str_scene + "_endloop");
}

menendez_greeters_animate(str_scene) {
  level thread run_scene_and_delete(str_scene);
  scene_wait(str_scene);
  level thread run_scene_and_delete(str_scene + "_endloop");
  level waittill("cleanup_hallway");
  wait 0.5;
  end_scene(str_scene + "_endloop");
}

menendez_greeters_defalco_animate(str_scene) {
  level endon("cleanup_hallway");
  level thread run_scene(str_scene);
  scene_wait(str_scene);
  level thread run_scene(str_scene + "_endloop");
}

menendez_intro_cleanup() {
  delete_models_from_scene("menendez_intro_doors");
  run_scene_first_frame("speech_opendoors_doors");
  wait_network_frame();
  end_scene("speech_opendoors_doors");
  delete_scene("speech_opendoors_doors", 1);
  a_fans = getentarray("hallway_fan", "script_noteworthy");

  foreach(fan in a_fans)
  fan delete();
}

menendez_intro_opendoors(guy) {
  level thread maps\_audio::switch_music_wait("YEMEN_FIRST_DOOR", 2.5);
  run_scene_and_delete("menendez_intro_doors");
}

menendez_speech_opendoors(guy) {
  run_scene("speech_opendoors_doors");
}

menendez_exit_opendoors(guy) {
  if(level.is_defalco_alive == 1)
    run_scene_and_delete("menendez_exit_doors_defalco");
  else
    run_scene_and_delete("menendez_exit_doors");
}

menendez_intro_unlink_player(guy) {
  if(!flag("speech_player_intro_done"))
    end_scene("speech_player_intro");

  set_objective(level.obj_speech, level.menendez, "follow");
  level waittill("menendez_at_door");
  set_objective(level.obj_speech, level.menendez, "");
}

menendez_speech() {
  trigger_wait("stage_door_open");
  flag_set("player_at_door");
  level notify("fxanim_seagull01_delete");
  level thread maps\_audio::switch_music_wait("YEMEN_DOOR_OPENED", 1);
  level notify("cleanup_hallway");
  level.player clientnotify("speech_spawn_crowd");
  level clientnotify("snd_swell_start");
  level thread speech_stage_guards();

  if(level.is_defalco_alive == 1) {
    end_scene("speech_defalco_greeter_intro_1");
    end_scene("speech_defalco_greeter_intro_1_endloop");
    level thread run_scene_and_delete("speech_walk_with_defalco_defalco");
    level thread run_scene_and_delete("speech_walk_no_defalco", 1);
  } else
    level thread run_scene_and_delete("speech_walk_no_defalco", 1);

  level thread menendez_speech_player();
  set_objective(level.obj_speech, undefined, "done");
  wait_network_frame();
  maps\createart\yemen_art::hallway_exposure();
  a_speech_structs = getstructarray("speech_crowd_center", "targetname");
  array_delete(a_speech_structs, 1);
  a_speech_structs = getstructarray("speech_crowd_close", "targetname");
  array_delete(a_speech_structs, 1);
  a_speech_structs = getstructarray("speech_court_ai_spot", "targetname");
  array_delete(a_speech_structs, 1);
  level.menendez custom_ai_weapon_loadout("judge_sp");
  maps\createart\yemen_art::large_crowd();
  flag_wait("speech_start_vtol");
  level thread menendez_intro_cleanup();
}

menendez_speech_player() {
  level.player enableinvulnerability();

  if(level.is_defalco_alive)
    level thread run_scene_and_delete("speech_walk_no_defalco_player");
  else
    level thread run_scene_and_delete("speech_walk_no_defalco_player");

  m_player_body = get_model_or_models_from_scene("speech_walk_no_defalco_player", "player_body");
  m_player_body attach("c_mul_cordis_head1_1", "", 1);
  scene_wait("speech_walk_no_defalco_player");
  level.player disableinvulnerability();
  menendez_speech_done_player_setup();
  flag_set("speech_end");
  autosave_by_name("speech_end");
  level.menendez.name = "Menendez";
  level.menendez.team = "allies";
  level.menendez.health = 1000;
  level.menendez thread maps\yemen_market::market_heroes_shot();

  if(level.is_defalco_alive == 1) {
    ai_defalco = get_ais_from_scene("speech_walk_with_defalco_defalco", "defalco_speech");
    ai_defalco.name = "Defalco";
    ai_defalco.team = "allies";
    ai_defalco.health = 1000;
    ai_defalco thread maps\yemen_market::market_heroes_shot();
  }

  level clientnotify("sle");
}

menendez_intro_player_setup() {
  level.player player_disable_weapons();
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
}

menendez_speech_done_player_setup() {
  level.player player_enable_weapons();
  level.player setmovespeedscale(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
}

speech_stage_guards() {
  level thread run_scene_and_delete("speech_walk_stage_guards");
  maps\yemen_utility::give_scene_models_guns("speech_walk_stage_guards");
  level waittill("speech_backup_spawn");

  if(level.is_defalco_alive == 1) {
    level thread run_scene("stage_backup_guards_defalco");
    maps\yemen_utility::give_scene_models_guns("stage_backup_guards_defalco");
  } else {
    level thread run_scene("stage_backup_guards");
    maps\yemen_utility::give_scene_models_guns("stage_backup_guards");
  }

  wait_network_frame();
  level waittill("vtols_arrived");
  level thread run_scene("vtols_arrive_stage_guards");
  level clientnotify("mbs");
}

speech_menendez_quad_kill_counter() {
  level endon("menendez_exited");
  level.m_quads_killed_by_mz = 0;

  while(true) {
    level waittill("menendez_fire");
    wait 0.2;
    level.m_quads_killed_by_mz++;
  }
}

speech_menendez_quad_run(quad_num) {
  self endon("death");
  self veh_magic_bullet_shield(1);

  do
    level waittill("menendez_fire");
  while(level.m_quads_killed_by_mz != quad_num);

  self veh_magic_bullet_shield(0);
  self dodamage(self.health * 2, self.origin);
}

speech_menendez_quad_targets() {
  level thread speech_menendez_quad_kill_counter();
  drone_names = array("menendez_kill_drone_01", "menendez_kill_drone_02", "menendez_kill_drone_03");
  drone_delays = array(12.0, 4.0, 1.0);
  assert(drone_names.size == drone_delays.size);

  for(i = 0; i < drone_names.size; i++) {
    wait(drone_delays[i]);
    v_rotor = spawn_vehicle_from_targetname_and_drive(drone_names[i]);
    v_rotor thread speech_menendez_quad_run(i);
  }
}

speech_vtols_arrive() {
  level notify("vtols_arrived");
  level thread speech_vtol();
  wait 3;

  if(level.is_defalco_alive)
    scene_wait("speech_walk_no_defalco");
  else
    scene_wait("speech_walk_no_defalco");

  flag_set("menendez_exited");
}

speech_vtol() {
  wait 1.8;
  nd_vtol_stop_spot = getstruct("speech_vtol_stop", "script_noteworthy");
  exploder(27);
  level clientnotify("speech_done");
  rpc("clientscripts/yemen", "speech_crowd_delete");
  level delay_thread(2.5, maps\yemen_market::speech_quads);
  veh_vtol = spawn_vehicle_from_targetname("speech_vtol");
  veh_vtol.takedamage = 0;
  veh_vtol setforcenocull();
  veh_vtol setvehgoalpos(nd_vtol_stop_spot.origin, 1);
  veh_vtol setdefaultpitch(10);
  level.veh_crashed_vtol = veh_vtol;
  level thread run_scene("vtol_pilot");
  veh_vtol waittill("goal");
  wait 0.5;
  magicbullet("usrpg_magic_bullet_sp", getstruct("speech_rpg_start").origin, veh_vtol.origin - vectorscale((0, 0, 1), 32.0));
  wait 0.2;
  magicbullet("usrpg_magic_bullet_sp", getstruct("speech_rpg_start").origin, veh_vtol.origin - (0, 50, -50));
  wait 2.6;
  stop_exploder(27);
  playfxontag(getfx("speech_vtol_exp"), veh_vtol, "tag_origin");
  veh_vtol playsound("evt_vtol_rocket_hit");
  veh_vtol playsound("evt_vtol_down");
  playrumbleonposition("artillery_rumble", level.player.origin);
  earthquake(0.35, 4, veh_vtol.origin, 2000);
  run_scene_and_delete("speech_vtol_crash");
  delete_scene("vtol_pilot", 1, 1);
}

player_turn(m_player) {
  wait_network_frame();
  flag_set("player_turn");
}

menendez_grabs_player(m_player) {
  flag_set("menendez_grabs_player");
}

player_turns_back(m_player) {
  flag_set("player_turns_back");
}

drone_remove_collision(drone) {
  drone notify("death");
  drone detach("t6_wpn_ar_an94_world", "tag_weapon_right");
}

vo_menendez_intro() {
  wait 1;
  level.player say_dialog("harp_egghead_you_copy_0");
  level.player say_dialog("fari_i_copy_harper_0");
  wait 1.5;
  level notify("start_hallway_actors");
}