/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_menendez_start.gsc
********************************************/

#include animscripts\utility;
#include common_scripts\utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\blackout_anim;
#include maps\_music;
#include maps\blackout_util;
#include maps\blackout_shield;
#include maps\blackout_security;
#include maps\_dds;
#include maps\_fxanim;
#include maps\_audio;
#include maps\createart\blackout_art;

init_flags() {
  flag_init("meat_shield_start");
  flag_init("meat_shield_done");
  flag_init("meat_shield_complete");
}

skipto_menendez_start() {
  skipto_teleport_players("player_skipto_menendez_start");
  maps\blackout_security::spawn_briggs();
  level.player menendez_weapons();
}

spawn_salazar_serverroom() {
  level.salazar = init_hero_startstruct("salazar", "skipto_menendez_combat_salazar");
  level.salazar gun_switchto(level.salazar.sidearm, "right");
  level.salazar.name = "Salazar";
}

skipto_menendez_meat_shield() {
  init_doors();
  menendez_animations();
  skipto_teleport_players("player_skipto_meat_shield");
  level.player menendez_weapons();
  maps\blackout_security::spawn_briggs();
  spawn_defalco_or_standin("defalco_shield_start_node");
  spawn_salazar_serverroom();
  exploder(769);
}

skipto_menendez_betrayal() {
  init_doors();
  menendez_animations();
  skipto_teleport_players("player_skipto_menendez_betrayal");
  level thread notetrack_start_virus_bink();
  maps\blackout_security::spawn_briggs();
  spawn_defalco_or_standin("defalco_combat_start_node");
  spawn_salazar_serverroom();
  level.player menendez_weapons();
  level thread run_scene_and_delete("meat_shield_end_loop");
  level.betrayal_scene_label = get_branching_scene_label();
  exploder(769);
}

skipto_menendez_betrayal_alive_a() {
  setdvar("defalco_alive", 1);
  setdvar("farid_alive", 1);
  setdvar("karma_alive", 1);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_alive_b() {
  setdvar("defalco_alive", 1);
  setdvar("farid_alive", 1);
  setdvar("karma_alive", 0);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_alive_c() {
  setdvar("defalco_alive", 1);
  setdvar("farid_alive", 0);
  setdvar("karma_alive", 1);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_dead_a() {
  setdvar("defalco_alive", 0);
  setdvar("farid_alive", 1);
  setdvar("karma_alive", 1);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_dead_b() {
  setdvar("defalco_alive", 0);
  setdvar("farid_alive", 1);
  setdvar("karma_alive", 0);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_dead_c() {
  setdvar("defalco_alive", 0);
  setdvar("farid_alive", 0);
  setdvar("karma_alive", 1);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

skipto_menendez_betrayal_dead_d() {
  setdvar("defalco_alive", 1);
  setdvar("farid_alive", 0);
  setdvar("karma_alive", 0);
  flag_set("dev_skipto_ready");
  skipto_menendez_betrayal();
}

precache_super_kill_models() {
  precachemodel("viewmodel_knife");
  precachemodel("viewmodel_knife_blood");
  precachemodel("c_mul_yemen_defalco_head_shot");
  precachemodel("c_mul_yemen_defalco_bloody_body");
  precachemodel("c_usa_chloe_cc_head_cut_cin");
  precachemodel("c_usa_chloe_cc_head_bruised_cin");
  precachemodel("c_usa_chloe_cc_head_bleed_cin");
  precachemodel("c_mul_farid_cc_shirt_shot");
}

run_menendez_start() {
  maps\_dds::dds_disable();
  init_doors();
  exploder(769);
  load_gump("blackout_gump_messiah");
  spawn_defalco_or_standin();
  e_streamer = createstreamerhint(level.defalco.origin, 1);
  e_streamer linkto(level.defalco);
  menendez_animations();
  maps\_fxanim::fxanim_delete("bridge_fxanims");
  set_light_flicker_fx_area(70900);
  run_scene_first_frame("panel_knockdown");
  run_scene_first_frame("console_chair_karma_sit_loop");
  flag_set("distant_explosions_on");
  setup_lock_lights();
  mason_objectives_hide();
  trigger_off("computer_server_use", "targetname");
  set_player_menendez();
  spawn_salazar_serverroom();
  waittill_asset_loaded("xmodel", "c_mul_menendez_captured_viewhands");
  waittill_asset_loaded("xmodel", "c_mul_menendez_captured_viewbody");
  level thread run_scene_and_delete("cctv_first_person_defalco");
  wait 1;
  delay_thread(3.8, ::lock_light_switch);
  level clientnotify("loud_alarm_off");
  level.player playsound("evt_cctv_transition_out");
  rpc("clientscripts/blackout_amb", "setSnapDefault");
  wait 0.3;
  screen_fade_in(1.0);
  level thread maps\_audio::switch_music_wait("BLACKOUT_MENENDEZ_WALK", 13);
  level.disablegenericdialog = 1;
  scene_wait("cctv_first_person_defalco");
  e_streamer delete();
  autosave_by_name("menendez_start");
}

run_menendez_meat_shield() {
  level.player setlowready(1);
  delay_thread(3, ::notetrack_start_virus_bink);
  meat_shield_start_idles();
  level thread scene_observers_variable();
  set_objective(level.obj_grab_briggs, level.briggs, "breadcrumb");
  trigger_wait("meat_shield_start_trigger");
  setmusicstate("BLACKOUT_MENENDEZ_HOLDUP");
  flag_clear("distant_explosions_on");
  set_objective(level.obj_grab_briggs, undefined, "delete");
  delay_thread(0.5, ::run_scene_and_delete, "meat_shield_take_briggs_hostage_chair");
  delay_thread(0.5, ::run_scene_and_delete, "meat_shield_defalco_holds_up_server_worker");
  run_scene_and_delete("meat_shield_take_briggs_hostage");
  level thread run_scene_and_delete("meat_shield_end_loop");

  if(isDefined(level.betrayal_scene_label))
    flag_wait("super_kill_" + level.betrayal_scene_label + "_wait_started");

  flag_wait("meat_shield_end_loop_started");
}

meat_shield_start_idles() {
  level thread run_scene_and_delete("meat_shield_guard_1_start_idle");
  level thread run_scene_and_delete("meat_shield_guard_2_start_idle");
  level thread run_scene_and_delete("meat_shield_briggs_start_idle");
  level thread run_scene_and_delete("meat_shield_worker_start_idle");
  level thread run_scene_and_delete("meat_shield_salazar_start_idle");
  level thread run_scene_first_frame("meat_shield_take_briggs_hostage_chair");
  level thread run_scene_then_loop("meat_shield_defalco_setup");
}

notetrack_meat_shield_start_reactions(m_player_body) {
  flag_set("meat_shield_start");
  level thread set_blend_times_for_scene("meat_shield_guards_react_to_briggs_taken_hostage", "super_kill_done");
  level thread run_scene_then_loop("meat_shield_guards_react_to_briggs_taken_hostage", undefined, "super_kill_started");
  level thread set_blend_times_for_scene("meat_shield_salazar_react_to_briggs_taken_hostage", "super_kill_done");
  level thread run_scene_then_loop("meat_shield_salazar_react_to_briggs_taken_hostage");
}

notetrack_attach_chip(m_player_body) {
  m_player_body attach("p6_celerium_chip", "tag_weapon");
}

notetrack_defalco_drops_gun(ai_defalco) {
  ai_defalco.temp_weapon unlink();
  ai_defalco.temp_weapon = undefined;
}

notetrack_defalco_uses_pistol(ai_defalco) {
  ai_defalco gun_switchto(ai_defalco.sidearm, "right");
}

notetrack_defalco_drops_gun_setup(ai_defalco) {
  ai_defalco gun_switchto(ai_defalco.primaryweapon, "right");
  ai_defalco.temp_weapon = spawn("weapon_" + ai_defalco.primaryweapon, ai_defalco gettagorigin("tag_weapon_right"));
  ai_defalco.temp_weapon.angles = ai_defalco gettagangles("tag_weapon_right");
  ai_defalco.temp_weapon linkto(ai_defalco, "tag_weapon_right");
  ai_defalco gun_switchto(ai_defalco.primaryweapon, "none");
}

notetrack_super_kill_player_loop_think(m_first_person) {
  ai_third_person = get_ent("menendez_ai", "targetname", 1);
  ai_third_person hide();
  level waittill("super_kill_started");
  ai_third_person show();
  m_first_person hide();
  level waittill("super_kill_done");

  if(isDefined(ai_third_person))
    ai_third_person delete();
}

run_menendez_betrayal() {
  level thread dialog_during_super_kill();
  str_visionset = level.player getvisionsetnaked();
  maps\createart\blackout_art::vision_superkill();
  scene_salazar_kill();
  level.player visionsetnaked(str_visionset);
  level.player thread depth_of_field_off(0.25);
  level thread run_kneepcap_scene_main_animations();
  defalco_was_alive = level.is_defalco_alive;
  scene_kneecap();
  computer_trig = getent("computer_server_use", "targetname");
  computer_trig trigger_on();
  computer_trig setcursorhint("HINT_NOICON");
  s_objective = get_struct("server_room_objective_struct", "targetname");
  trigger_use("computer_server_use");
  computer_trig trigger_off();

  if(defalco_was_alive && !level.is_defalco_alive)
    spawn_defalco_or_standin("defalco_combat_start_node");

  menendez_turret_end();
  n_znear_old = getdvar(#"r_znear");
  setdvar("r_znear", 1);
  level thread run_scene_and_delete("menendez_hack");
  level.player startcameratween(2);
  level thread run_scene_and_delete("menendez_hack_player", 1);
  server_room_exit_door_open();
  setsaveddvar("player_standingViewHeight", 64);
  scene_wait("menendez_hack_player");
  level.player setlowready(0);
  level.player enableclientlinkto();
  setdvar("r_znear", n_znear_old);
  server_room_exit_door_close();
  clientnotify("_gasmask_off");
  toggle_messiah_mode(0);
  clean_up_all_ai();
  clearallcorpses();
  super_kill_exploder_stop_all();
  wait 0.25;
}

dialog_pre_super_kill() {
  level.briggs say_dialog("brig_salazar_1");
  level.briggs say_dialog("brig_shoot_through_me_k_0");
}

dialog_during_super_kill() {
  level.briggs say_dialog("brig_no_1", 3);
}

salazar_hit_briggs(briggs) {
  briggs endon("damage");
  briggs endon("death");
  wait 12.0;
  briggs.knocked_out = 1;
  briggs notify("knockout");
}

briggs_wound_watch() {
  self endon("death");
  level endon("menendez_enter_plane");

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

    if(isstring(type) && type == "MOD_PISTOL_BULLET") {
      break;
    }
  }

  set_briggs_killed();
  playsoundatposition("evt_briggs_dead_stinger", (0, 0, 0));
  kill_all_pending_dialog(level.briggs);

  if(!level.briggs.knocked_out) {
    run_scene_and_delete("briggs_shot_again");
    level thread run_scene_and_delete("briggs_shot_again_loop");
  } else {
    level.briggs stop_magic_bullet_shield();
    level.briggs ragdoll_death();
  }
}

briggs_wound_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!isDefined(self.blood_exploder_active))
    self.blood_exploder_active = 0;

  if(is_mature()) {
    playfx(level._effect["briggs_blood"], vpoint, vdir);

    if(!self.blood_exploder_active) {
      super_kill_exploder_add(770);
      self.blood_exploder_active = 1;
    }
  }

  return idamage;
}

briggs_delete_watch() {
  level waittill("menendez_enter_plane");
  self delete();
}

briggs_wound_talk() {
  self endon("damage");
  self endon("death");
  self endon("knockout");
}

briggs_wound() {
  level.salazar thread salazar_hit_briggs(self);
  level.briggs.knocked_out = 0;
  self.overrideactordamage = ::briggs_wound_callback;
  self waittill_any("damage", "death", "knockout");
  playsoundatposition("evt_briggs_shot_stinger", (0, 0, 0));

  if(damagelocationisany("torso_upper", "neck", "head", "helmet")) {
    set_briggs_killed();
    playsoundatposition("evt_briggs_dead_stinger", (0, 0, 0));
    kill_all_pending_dialog(level.briggs);
  }

  if(!level.briggs.knocked_out && !damagelocationisany("head", "helmet")) {
  }

  level.player setlowready(1);

  if(level.is_defalco_alive)
    level thread run_scene_then_loop("briggs_shot_defalco_reacts");

  if(level.briggs.knocked_out) {
    run_scene_and_delete("briggs_knockout");
    level thread run_scene_and_delete("briggs_knockout_loop");
    level thread salazar_reacts_to_briggs_knocked_out();
  } else if(!level.is_briggs_alive) {
    level thread salazar_reacts_to_briggs_killed();
    run_scene_and_delete("briggs_shot_fatal");
    level thread run_scene_and_delete("briggs_shot_fatal_loop");
  } else {
    level thread salazar_reacts_to_briggs_wounded();
    run_scene_and_delete("briggs_shot_nonfatal");
    level thread run_scene_and_delete("briggs_shot_nonfatal_loop");
  }

  self thread briggs_delete_watch();

  if(level.is_briggs_alive)
    self thread briggs_wound_watch();
}

salazar_reacts_to_briggs_knocked_out() {
  level thread run_scene_and_delete("salazar_chair_wait");
  flag_wait("menendez_hack_started");
  wait 3;
  level.player delay_thread(1.5, ::say_dialog, "mene_if_we_truly_succeed_0");
  run_scene_then_loop("briggs_alive_salazar_reacts", "salazar_waits_behind_server_terminal");
}

salazar_reacts_to_briggs_killed() {
  wait 2;
  level thread run_scene_and_delete("briggs_killed_salazar_reacts");
  level.salazar say_dialog("sala_you_said_no_unnecess_0", 2.0);
  level.player say_dialog("mene_i_decide_what_is_nec_0", 0.5);
  scene_wait("briggs_killed_salazar_reacts");
  run_scene_and_delete("salazar_waits_behind_server_terminal");
}

salazar_reacts_to_briggs_wounded() {
  wait 2;
  level thread run_scene_and_delete("briggs_alive_salazar_reacts");
  level.salazar say_dialog("sala_he_s_alive_thank_y_0", 1.5);
  level.player say_dialog("mene_if_we_truly_succeed_0");
  scene_wait("briggs_alive_salazar_reacts");
  run_scene_and_delete("salazar_waits_behind_server_terminal");
}

scene_observers_variable() {
  level.betrayal_scene_label = get_branching_scene_label();
  branching_scene_debug();

  if(isDefined(level.betrayal_scene_label)) {
    level thread run_scene_and_delete("super_kill_" + level.betrayal_scene_label + "_idle");
    flag_wait("meat_shield_start");
    run_scene_and_delete("super_kill_" + level.betrayal_scene_label + "_react");
    level thread run_scene_and_delete("super_kill_" + level.betrayal_scene_label + "_wait");
  }
}

scene_salazar_kill_victims() {
  run_scene_and_delete("salazar_kill_victims");
  run_scene_and_delete("salazar_kill_victims_dead");
}

scene_salazar_kill() {
  if(isDefined(level.defalco))
    level.defalco gun_switchto(level.defalco.sidearm, "right");

  if(isDefined(level.salazar))
    level.salazar gun_switchto(level.salazar.sidearm, "right");

  if(isDefined(level.betrayal_scene_label))
    level thread remove_blend_times_for_scene("super_kill_" + level.betrayal_scene_label + "_wait", "super_kill_done");

  run_scene_and_delete("super_kill");
  clearallcorpses();
  stop_exploder(769);
  flag_set("distant_explosions_on");
  set_post_branching_scene_stats();
  delete_gumped_deadpose_characters(0);
  level thread set_guard_dead_poses();
  setmusicstate("BLACKOUT_POST_SUPERKILL");
}

set_guard_dead_poses() {
  ai_guard_1 = get_ent("meat_shield_target_01_ai", "targetname");

  if(isDefined(ai_guard_1))
    ai_guard_1 delete();

  ai_guard_2 = get_ent("meat_shield_target_02_ai", "targetname");

  if(isDefined(ai_guard_2))
    ai_guard_2 delete();

  level thread run_scene("salazar_kill_victims_dead");
}

scene_kneecap() {
  autosave_by_name("shoot_briggs");
  level.briggs thread briggs_wound_talk();

  if(level.is_defalco_alive)
    level thread run_scene_and_delete("kneecap_start_defalco");

  scene_wait("kneecap_start_main");

  if(level.is_defalco_alive)
    level thread run_scene_and_delete("kneecap_loop_defalco");

  level.player setlowready(0);
  level.briggs briggs_wound();

  if(level.is_defalco_alive)
    flag_wait("briggs_shot_defalco_reacts_loop_started");

  set_objective(level.obj_shoot_briggs, undefined, "delete");
  level thread maps\_audio::switch_music_wait("BLACKOUT_EYEBALL", 0.5);
}

run_kneepcap_scene_main_animations() {
  run_scene_and_delete("kneecap_start_main", 0.2);
  set_objective(level.obj_shoot_briggs);
  menendez_turret_start();
  level thread run_scene_and_delete("kneecap_loop_main");
}

menendez_turret_start() {
  s_anim = get_struct("server_anim_node", "targetname");
  v_spawn = getstartorigin(s_anim.origin, s_anim.angles, level.scr_anim["player_body"]["menendez_hack_player"]);
  level.player.e_menendez_turret = spawn("script_model", v_spawn);
  level.player.e_menendez_turret setmodel("tag_origin_animate");
  level.player.e_menendez_turret.angles = level.player.angles;
  level.player disableclientlinkto();
  level.player playerlinktodelta(level.player.e_menendez_turret, "tag_origin", 1, 25, 25, 20, 40);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowprone(0);
  level.player allowjump(0);
}

menendez_turret_end() {
  level.player unlink();
  level.player.e_menendez_turret delete();
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowjump(1);
}

notetrack_blink_start(e_player_body) {
  level thread screen_fade_out(0.05);
  level waittill_notify_or_timeout("menendez_blink_end", 2);
  level thread screen_fade_in(0.05);
}

notetrack_fade_to_mason_section(m_player_body) {
  screen_fade_out(0.1);
}

notetrack_blink_end(e_player_body) {
  level notify("menendez_blink_end");
}

notetrack_eyeball_smash(playa) {
  eyeball = get_model_or_models_from_scene("menendez_hack", "eyeball");
  eyeball hide();
}

notetrack_menenedez_mask_on(playa) {
  level.disablegenericdialog = 0;
  clientnotify("_gasmask_on_pristine");
  toggle_messiah_mode(1);
}

notetrack_menendez_mask_off(bro) {
  clientnotify("_gasmask_off");
  toggle_messiah_mode(0);
}

notetrack_start_virus_bink(m_player_body) {
  if(!level_has_callback("on_save_restored", ::save_restored_menendez_console_bink))
    onsaverestored_callback(::save_restored_menendez_console_bink);

  m_console_dark = get_ent("server_room_console_dark", "targetname", 1);
  m_console_bink = get_ent("server_room_console_bink", "targetname", 1);
  m_console_dark hide();
  m_console_bink show();
  m_console_bink.n_bink_id_virus_1 = play_movie_on_surface_async("blackout_virus", 1, 0, undefined, undefined, undefined, 1);
  m_console_bink.n_bink_id_virus_2 = play_movie_on_surface_async("blackout_virus_2", 0, 0, undefined, undefined, undefined, 1);
  level waittill("start_virus_2_bink");
  playsoundatposition("evt_blackout_virus_2_movie", (2573, 260, -264));
  stop3dcinematic(m_console_bink.n_bink_id_virus_1);
  scene_wait("menendez_hack_player");
  stop3dcinematic(m_console_bink.n_bink_id_virus_2);
  onsaverestored_callbackremove(::save_restored_menendez_console_bink);
}

save_restored_menendez_console_bink() {
  m_console_dark = get_ent("server_room_console_dark", "targetname", 1);
  m_console_bink = get_ent("server_room_console_bink", "targetname", 1);
  m_console_dark hide();
  m_console_bink show();

  if(!isDefined(level.streaming_binks_restored))
    level.streaming_binks_restored = 0;

  if(!level.streaming_binks_restored) {
    level.streaming_binks_restored = 1;

    if(isDefined(m_console_bink.n_bink_id_virus_1)) {
      stop3dcinematic(m_console_bink.n_bink_id_virus_1);
      wait 0.1;
      m_console_bink.n_bink_id_virus_1 = play_movie_on_surface_async("blackout_virus", 1, 0, undefined, undefined, undefined, 1);
    }

    if(isDefined(m_console_bink.n_bink_id_virus_2)) {
      stop3dcinematic(m_console_bink.n_bink_id_virus_2);
      wait 0.1;
      m_console_bink.n_bink_id_virus_2 = play_movie_on_surface_async("blackout_virus_2", 0, 0, undefined, undefined, undefined, 1);
    }

    wait 2;
    level.streaming_binks_restored = undefined;
  }
}

notetrack_start_virus_2_bink(m_player_body) {
  level notify("start_virus_2_bink");
}

notetrack_super_kill_duel_achievement(ai_defalco) {
  wait 9.5;
  level.player giveachievement_wrapper("SP_STORY_FARID_DUEL");
}

init_doors() {
}

lock_light_run() {
  level waittill("door_light_switch");
  play_fx("door_light_unlocked", self.origin, self.angles);
}

lock_light_switch() {
  level notify("door_light_switch");
}

setup_lock_lights() {
  lock_light = getstruct("lock_light_position", "targetname");
  play_fx("door_light_locked", lock_light.origin, lock_light.angles, "door_light_switch");
  lock_light thread lock_light_run();
}

notetrack_super_kill_ground_impact(ai_guy) {
  playfxontag(level._effect["super_kill_ground_hit"], ai_guy, "J_neck");
}

notetrack_super_kill_flash_on_camera_cut(m_player_body) {
  playsoundatposition("evt_smashcut_flash", (0, 0, 0));
  screen_fade_out(0.05, "white");
  wait 0.2;
  screen_fade_in(0.05, "white");
}

super_kill_slow_start(player_body) {
  settimescale(0.1);
}

super_kill_slow_end(player_body) {
  settimescale(1);
}

notetrack_super_kill_gun_fx(ai_guy) {
  playfxontag(level._effect["super_kill_muzzle_flash"], ai_guy, "tag_flash");
}

notetrack_super_kill_guard_1_react(ai_guard) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_2"], ai_guard, "J_Head");
    super_kill_exploder_add(771);
  }
}

notetrack_super_kill_guard_2_react(ai_guard) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_3"], ai_guard, "J_Neck");
    super_kill_exploder_add(772);
  }
}

notetrack_super_kill_alive_a_defalco_react(ai_defalco) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_defalco"], ai_defalco, "J_Head");
    super_kill_exploder_add(773);
    ai_defalco defalco_shot_head();
  }
}

notetrack_super_kill_alive_a_karma_react(ai_karma) {
  if(is_mature())
    playfxontag(level._effect["karma_slap"], ai_karma, "J_Head");

  ai_farid = get_ent("farid_ai", "targetname");
  e_farid_hint = createstreamerhint(ai_farid.origin, 1.0);
  wait 10;
  e_farid_hint delete();
}

notetrack_super_kill_alive_a_farid_react(ai_farid) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood"], ai_farid, "J_Head");
    super_kill_exploder_add(774);
  }
}

notetrack_super_kill_alive_b_farid_cough_blood(ai_farid) {
  if(is_mature())
    playfxontag(level._effect["farid_cough_blood"], ai_farid, "J_Head");
}

notetrack_super_kill_alive_b_defalco_react(ai_defalco) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_defalco_2"], ai_defalco, "j_mainroot");
    super_kill_exploder_add(775);
  }
}

notetrack_super_kill_alive_b_farid_react(ai_farid) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood"], ai_farid, "J_Shoulder_LE");
    super_kill_exploder_add(774);
    ai_farid farid_body_shot();
  }
}

notetrack_super_kill_alive_c_karma_react(ai_karma) {
  ai_karma.dropweapon = 0;

  if(is_mature()) {
    playfxontag(level._effect["karma_neck_blood"], ai_karma, "J_Neck");
    super_kill_exploder_add(776);
    ai_karma karma_cut_throat();
    level.defalco defalco_body_bloody();
    level.defalco defalco_knife_bloody();
  }
}

notetrack_super_kill_alive_c_defalco_knife(ai_defalco) {
  ai_defalco gun_switchto(ai_defalco.primaryweapon, "none");
  ai_defalco attach("viewmodel_knife", "tag_weapon_left");
  ai_defalco.super_kill_knife = "viewmodel_knife";
  scene_wait("super_kill");
  ai_defalco detach(ai_defalco.super_kill_knife, "tag_weapon_left");
}

notetrack_super_kill_dead_a_farid_react(ai_farid) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_farid"], ai_farid, "J_Head");
    super_kill_exploder_add(777);
    ai_farid farid_body_shot();
  }
}

notetrack_super_kill_dead_a_farid_cough_blood(ai_farid) {
  if(is_mature())
    playfxontag(level._effect["farid_cough_blood"], ai_farid, "J_Head");
}

notetrack_super_kill_dead_a_karma_react(ai_karma) {
}

notetrack_super_kill_dead_b_farid_react(ai_farid) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood"], ai_farid, "J_Shoulder_LE");
    super_kill_exploder_add(778);
    ai_farid farid_body_shot();
  }
}

notetrack_super_kill_dead_b_farid_cough_blood(ai_farid) {
  if(is_mature())
    playfxontag(level._effect["farid_cough_blood"], ai_farid, "J_Head");
}

notetrack_super_kill_dead_c_karma_react(ai_karma) {
  if(is_mature()) {
    playfxontag(level._effect["super_kill_blood_karma"], ai_karma, "J_Head");
    super_kill_exploder_add(779);
    ai_karma karma_head_shot();
  }
}