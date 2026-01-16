/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_spiderbot.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\karma_util;
#include maps\_music;
#include maps\karma_arrival;
#include maps\_vehicle;
#include maps\_spiderbot;
#include maps\karma_anim;
#include maps\createart\karma_art;
#include maps\_audio;

init_flags() {
  flag_init("spiderbot_bootup_done");
  flag_init("near_bombs");
  flag_init("bomb_found");
  flag_init("near_bug_zapper");
  flag_init("near_power_box");
  flag_init("bug_zapper_disabled");
  flag_init("near_gulliver");
  flag_init("spiderbot_entered_crc");
  flag_init("say_taze_him");
  flag_init("it_mgr_disabled");
  flag_init("scanning_eye");
  flag_init("spiderbot_transition_done");
  flag_init("spiderbot_end");
}

init_spawn_funcs() {
}

spiderbot_teleport(str_location) {
  s_tp_spot = getstruct(str_location, "targetname");
  level.vh_spiderbot.origin = s_tp_spot.origin;
  level.vh_spiderbot.angles = s_tp_spot.angles;
  level.vh_spiderbot useby(level.player);
  level.vh_spiderbot makevehicleunusable();
}

skipto_spiderbot() {
  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  maps\karma_arrival::deconstruct_fxanims();
  skipto_teleport("skipto_spiderbot");
  level.vh_spiderbot = maps\_vehicle::spawn_vehicle_from_targetname("spiderbot");
  level.vh_spiderbot thread maps\_spiderbot::main();
  wait 0.5;
  exploder(447);
}

skipto_gulliver() {
  cleanup_ents("cleanup_checkin");
  cleanup_ents("cleanup_tower");
  cleanup_ents("cleanup_dropdown");
  maps\karma_arrival::deconstruct_fxanims();
  skipto_teleport("skipto_gulliver");
  level.vh_spiderbot = maps\_vehicle::spawn_vehicle_from_targetname("spiderbot");
  level.vh_spiderbot thread maps\_spiderbot::main();
  prep_spiderbot();
  spiderbot_teleport("skipto_gulliver_spider");
  level.vh_spiderbot thread objective_breadcrumb(level.obj_enter_crc, "breadcrumb_spiderbot");
  maps\karma_anim::spiderbot_anims();
  level.ai_gulliver = simple_spawn_single("gulliver", ::gulliver_think);
  a_m_fans = getentarray("spiderbot_fan", "targetname");
  array_thread(a_m_fans, ::spin_fan);
  level thread fan_death();
  level thread setup_proximity_scan_and_alarm(getent("trig_bug_zapper", "targetname"), "zapped", "spiderbot_end", 75);
  level thread gulliver_walkin();
  exploder(447);
}

vents() {
  iprintln("Spiderbot");

  level.player freezecontrols(1);
  level.player maps\createart\karma_art::vision_set_change("karma_spiderbot");
  maps\karma_anim::spiderbot_anims();
  prep_spiderbot();
  level thread spiderbot_patrol();
  level thread run_scene_and_delete("scene_guard_loop_comp");
  getent("destroyed_spider_bot", "targetname") hide();
  level.player setstance("stand");
  level.player setorigin(level.vh_spiderbot.origin);
  level.vh_spiderbot show();
  level.vh_spiderbot useby(level.player);
  level.vh_spiderbot makevehicleunusable();
  level.vh_spiderbot thread display_hints();
  maps\createart\karma_art::spiderbot_general_dof();
  level.vh_spiderbot play_fx("spiderbot_taser_infinite", undefined, undefined, undefined, 1, "tag_flash");
  flag_set("spiderbot_bootup_done");
  exploder(447);
  clientnotify("invnt");
  level.vh_spiderbot thread sndvoxtriggers(0);
  level.vh_spiderbot thread sndvoxtriggers(1);
  level.player freezecontrols(0);
  level.player thread spiderbot_dialog();
  level.ai_gulliver = simple_spawn_single("gulliver", ::gulliver_think);
  level.vh_spiderbot thread objective_breadcrumb(level.obj_enter_crc, "breadcrumb_spiderbot");
  a_m_fans = getentarray("spiderbot_fan", "targetname");
  array_thread(a_m_fans, ::spin_fan);
  wait 0.1;
  screen_fade_in(0.5);
  flag_wait("near_bombs");
  run_scene_first_frame("planting_bombs");
  flag_wait("bomb_found");
  level thread run_scene_and_delete("planting_bombs");
  level thread setup_proximity_scan_and_alarm(getent("trig_bug_zapper", "targetname"), "zapped", "spiderbot_end", 75);
  getent("zapper_proximity_trigger", "targetname") thread zapper_proximity_warning_think();
  level thread zapper_power_box();
  set_objective(level.obj_enter_crc, undefined, "deactivate");
  set_objective(level.obj_disable_zapper, getent("trig_zapper_power", "targetname"));
  flag_wait("bug_zapper_disabled");
  set_objective(level.obj_enter_crc, undefined, "reactivate");
  set_objective(level.obj_disable_zapper, undefined, "delete");
  trigger_wait("t_near_fans");
  level thread fan_death();
  autosave_now("karma_fans");
  flag_wait("near_gulliver");
  level notify("gulliver_reached");
  level thread gulliver_walkin();
}

spiderbot_patrol() {
  ai_patrol = simple_spawn_single("spiderbot_patrol");
  animation = level.scr_anim["civ_male"]["v1"]["walk"];
  ai_patrol set_ignoreall(1);
  ai_patrol.alwaysrunforward = 1;
  ai_patrol.a.combatrunanim = animation;
  ai_patrol.run_noncombatanim = animation;
  ai_patrol.walk_combatanim = animation;
  ai_patrol.walk_noncombatanim = animation;
  ai_patrol.precombatrunenabled = 0;
  ai_patrol.disableturns = 1;
  ai_patrol.disablearrivals = 1;
  ai_patrol.disableexits = 1;
  ai_patrol change_movemode("walk");
  trigger_wait("spiderbot_patrol_trigger");
  ai_patrol set_goalradius(4);
  ai_patrol set_goal_node(getnode("spiderbot_patrol_target", "targetname"));
  ai_patrol waittill("goal");
  ai_patrol delete();
}

gulliver() {
  trigger_wait("t_see_gulliver");
  level.player thread gulliver_dialog();
  trigger_wait("trig_zapper_lock");
  level thread autosave_now("karma_gulliver");
  set_objective(level.obj_enter_crc, undefined, "deactivate");
  set_objective(level.obj_crc_guy, level.ai_gulliver, "disable");
  delete_exploder(447);
  end_scene("scene_guard_loop_comp");
  level.vh_spiderbot ent_flag_set("playing_scripted_anim");
  level.vh_spiderbot maps\_vehicle::lights_off();
  maps\createart\karma_art::spiderbot_security_dof();
  level.player freezecontrols(1);

  if(level.vh_spiderbot istouching(getent("spiderbot_vent_touch_trigger", "targetname"))) {
    level.vh_spiderbot linkto(getent("crc_vent", "targetname"));
    level.vh_spiderbot notsolid();
  }

  run_scene_and_delete("it_mgr_vent_open");
  clientnotify("drpdn");
  level.player playsound("evt_spiderbot_jumpdown");
  level.player playsound("evt_spiderbot_land");
  level thread maps\_audio::switch_music_wait("KARMA_1_GULLIVER", 2);
  getent("it_mgr_tablet", "targetname") delete();
  level.ai_gulliver thread gulliver_viewmodel_render_flag_set();
  run_scene_and_delete("it_mgr_surprise", 0.5);

  if(flag("it_mgr_disabled"))
    level.ai_gulliver gulliver_eye_scan();
  else
    spiderbot_lost(0, & "KARMA_TAZE_FAIL_HINT");

  level.vh_spiderbot ent_flag_clear("playing_scripted_anim");
  flag_wait("spiderbot_end");
  level.player setclientdvar("cg_objectiveIndicatorNearDist", 2.0);
  level thread screen_fade_in(2);
  level thread spiderbot_cleanup();
  level thread maps\_audio::play_music_stinger_manual("mus_karma_post_spiderbot", 4);
}

gulliver_viewmodel_render_flag_set() {
  wait 2.0;
  self setviewmodelrenderflag(1);
}

gulliver_walkin() {
  run_scene_and_delete("it_mgr_walkin2");

  if(!flag("spiderbot_entered_crc"))
    level thread run_scene_and_delete("it_mgr_idle2");
}

spiderbot_light_trigger_think() {
  level.vh_spiderbot endon("scan_done");
  self waittill("trigger");
  self trigger_thread(level.vh_spiderbot, ::spider_bot_light_off, ::spider_bot_light_on);
}

spider_bot_light_off(ent, endon_string) {
  level.vh_spiderbot maps\_vehicle::lights_off();
}

spider_bot_light_on(ent) {
  level.vh_spiderbot maps\_vehicle::lights_on();
  getent("spiderbot_light_trigger", "targetname") thread spiderbot_light_trigger_think();
}

prep_spiderbot() {
  old_n_znear = getdvar(#"r_znear");
  setdvar("r_znear", 1);
  level.vh_spiderbot add_cleanup_ent("cleanup_spiderbot");
  level.cg_objectiveindicatornearfadedist = getdvarfloat(#"_id_D96CB2B0");
  level.objectiveindicatornodrawdistance = getdvarfloat(#"_id_E37C3873");
  level.player setclientdvar("cg_objectiveIndicatorNearFadeDist", 0.01);
  level.player setclientdvar("objectiveIndicatorNoDrawDistance", 0.01);
  level.player setclientdvar("vehicle_riding", 0);
}

display_hints() {
  trigger_wait("t_spiderbot_climb");
  level thread autosave_now("karma_zapper");
  screen_message(&"KARMA_HINT_SPIDERBOT_CLIMB", 3);
  trigger_wait("t_spiderbot_jump");
  screen_message(&"KARMA_HINT_SPIDERBOT_JUMP", 3);
  flag_wait("near_power_box");

  if(!flag("bug_zapper_disabled"))
    screen_message(&"KARMA_HINT_SPIDERBOT_TAZER", 3);
}

spin_fan() {
  level endon("spiderbot_end");
  self add_cleanup_ent("cleanup_spiderbot");

  if(isDefined(self.script_float)) {
    self ignorecheapentityflag(1);
    self setscale(self.script_float);
  }

  while(true) {
    self rotateyaw(3600, 10.0);
    wait 10.0;
  }
}

fan_death() {
  level endon("spiderbot_end");
  trigger_wait("trig_fan_death");
  spiderbot_lost(0, & "KARMA_FAN_DEATH_HINT");
}

suspicious_guys_leaving_pip() {
  e_camera_two = simple_spawn_single("suspicious_guys_camera", ::camera_think);
  level thread run_scene_and_delete("scene_suspicious_guys_leaving");
  turn_on_extra_cam();
  scene_wait("scene_suspicious_guys_leaving");
  turn_off_extra_cam();
  wait 1;
  level.e_extra_cam unlink();
}

zapper_power_box() {
  exploder(445);
  t_zapper_field = getent("trig_bug_zapper", "targetname");
  t_zapper_field thread zap_player();
  t_zapper_field playloopsound("amb_spiderbot_trap_looper");
  audio_player_origin = t_zapper_field.origin;
  trigger_wait("trig_zapper_power");
  level notify("kill_zapper_proximity_warning");
  screen_message_delete();
  flag_set("bug_zapper_disabled");
  exploder(444);
  t_zapper_field notify("zapped");
  t_zapper_field delete();
  clientnotify("frcx");
  playsoundatposition("amb_spiderbot_trap_off", (5754, -7475, -3334));
  delete_exploder(445);
}

zap_player() {
  level endon("bug_zapper_disabled");
  self waittill("trigger");
  spiderbot_lost(0, & "KARMA_ELECTRICAL_FIELD_DEATH_HINT", 1, "KARMA_ZAPPER_PROXIMITY_WARNING");
}

gulliver_think() {
  self endon("damage");
  self add_cleanup_ent("cleanup_crc");
  self.team = "axis";
  self.ignoreall = 1;
  self.goalradius = 16;
  self setgoalpos(self.origin);
  self gun_remove();
  self thread magic_bullet_shield();
  trigger_wait("start_itmanager");
  level thread run_scene_and_delete("it_mgr_walkin");
  level thread it_manager_dialog();
  scene_wait("it_mgr_walkin");
  thread run_scene_and_delete("it_mgr_idle");
}

spiderbot_slow_mo(vh_spiderbot) {
  flag_set("say_taze_him");
  level.ai_gulliver thread gulliver_wait_for_tazer();
  timescale_tween(1.0, 0.15, 0.1, 0.05);
  wait 0.05;
  timescale_tween(0.15, 0.5, 0.5);
  flag_wait("it_mgr_disabled");
  timescale_tween(0.5, 1.0, 0.5, 0.05);
}

gulliver_wait_for_tazer() {
  level.player freezecontrols(0);
  wait 0.225;
  thread screen_message(&"KARMA_HINT_SPIDERBOT_TAZER", 2);

  while(!level.player attackbuttonpressed())
    wait 0.05;

  flag_set("it_mgr_disabled");
  set_objective(level.obj_enter_crc, undefined, "reactivate");
  set_objective(level.obj_crc_guy, undefined, "delete");
  screen_message_delete();
}

gulliver_eye_scan() {
  level.player freezecontrols(1);
  level thread run_scene_and_delete("eye_scan", 0.5);
  scene_wait("eye_scan");
  ai_stomper = simple_spawn_single("spiderbot_smasher");
  ai_stomper notsolid();
  level.player thread rumble_loop(10, 0.05, "tank_rumble");
  level run_scene_and_delete("spiderbot_smash");
  level.player freezecontrols(0);
  ai_stomper delete();
}

play_eye_scan_fx(vh_spiderbot) {
  flag_set("scanning_eye");
  vh_spiderbot playsound("evt_spiderbot_retinal_scan");
  luinotifyevent(&"hud_spiderbot_eyescan");
  vh_spiderbot play_fx("spiderbot_scanner", vh_spiderbot gettagorigin("tag_flash"), vh_spiderbot gettagangles("tag_flash"), "scan_done");
  level thread play_bink_on_hud("eye_v5");
  scene_wait("eye_scan");
  vh_spiderbot notify("scan_done");
  luinotifyevent(&"hud_spiderbot_eyescan_end");
}

spiderbot_squashed(ai_callback) {
  wait 2.0;
  level.player thread rumble_loop(10, 0.05, "damage_heavy");
  clientnotify("otvnt");
  spiderbot_lost(1);
  flag_set("spiderbot_end");
}

spiderbot_lost(b_continue_mission, str_fail_string, do_remove_string, str_lui_string) {
  if(!isDefined(b_continue_mission))
    b_continue_mission = 0;

  if(!isDefined(do_remove_string))
    do_remove_string = 0;

  if(do_remove_string) {
    level notify("kill_zapper_proximity_warning");
    maps\_glasses::remove_visor_text(str_lui_string);
  }

  if(!b_continue_mission) {
    level.vh_spiderbot useby(level.player);
    screen_fade_out(0, "compass_static");
    missionfailedwrapper(str_fail_string);
    return;
  }

  screen_fade_out(0, "compass_static");
  level.player freezecontrols(1);
  level.vh_spiderbot useby(level.player);
}

spiderbot_cleanup() {
  wait 0.05;
  level.player setclientdvar("cg_objectiveIndicatorNearFadeDist", level.cg_objectiveindicatornearfadedist);
  level.player setclientdvar("objectiveIndicatorNoDrawDistance", level.objectiveindicatornodrawdistance);
  level.player setclientdvar("vehicle_riding", 1);
  cleanup_ents("cleanup_spiderbot");
}

setup_proximity_scan_and_alarm(danger, danger_ender, level_ender, dist) {
  danger endon("death");

  if(isDefined(danger_ender))
    danger endon(danger_ender);

  if(isDefined(level_ender))
    level endon(level_ender);

  if(!isDefined(dist))
    dist = 50;

  spiderbot = level.vh_spiderbot;
  danger._audio_alarm_active = 0;

  while(true) {
    distance_diff = distance(danger.origin, spiderbot.origin);

    if(distance_diff <= dist) {
      if(!danger._audio_alarm_active) {
        danger._audio_alarm_active = 1;
        spiderbot thread play_scan_and_alarm(danger, danger_ender, level_ender);
        spiderbot thread stop_alarms_on_ender(danger, danger_ender, level_ender);
      }
    } else if(danger._audio_alarm_active) {
      danger._audio_alarm_active = 0;
      spiderbot notify("audio_stop_alarms");
      spiderbot playsound("veh_spiderbot_safe");
    }

    wait 0.1;
  }
}

play_scan_and_alarm(danger, danger_ender, level_ender) {
  self endon("audio_stop_alarms");
  self endon("death");
  danger endon("death");

  if(isDefined(danger_ender))
    danger endon(danger_ender);

  if(isDefined(level_ender))
    level endon(level_ender);

  self playsound("veh_spiderbot_scan");
  wait 0.9;

  while(true) {
    self playsound("veh_spiderbot_alarm");
    wait 0.4;
  }
}

stop_alarms_on_ender(danger, danger_ender, level_ender) {
  self endon("audio_stop_alarms");
  self endon("death");
  danger endon("death");

  if(isDefined(level_ender))
    level endon(level_ender);

  if(isDefined(danger_ender)) {
    danger waittill(danger_ender);
    self playsound("veh_spiderbot_safe");
  }
}

spiderbot_scanning_audio() {
  self endon("tazed");
  spiderbot = level.vh_spiderbot;

  while(true) {
    if(distance(self.origin, spiderbot.origin) <= 75) {
      break;
    }

    wait 0.1;
  }

  self thread playsound_on_zapped(spiderbot);
  spiderbot playsound("veh_spiderbot_scan");
  wait 0.9;
  spiderbot playsound("veh_spiderbot_scan_human");
}

playsound_on_zapped(spiderbot) {
  self waittill("tazed");
  wait 0.5;
  spiderbot playsound("veh_spiderbot_safe");
}

spiderbot_dialog() {
  level thread bug_zapper_dialog();
  setmusicstate("KARMA_1_SPIDERBOT");
  self say_dialog("sect_harper_the_security_0");
  self say_dialog("sect_they_re_working_for_0");
  self say_dialog("harp_understood_1");
  flag_wait("near_bombs");
  self say_dialog("sala_watch_the_gap_coming_0");
  self say_dialog("sala_ziggy_can_jump_acros_0");
  flag_wait("bomb_found");
  level.bomb_planter1 = getent("bomb_planter1_ai", "targetname");
  level.bomb_planter2 = getent("bomb_planter2_ai", "targetname");
  level.bomb_planter3 = getent("bomb_planter3_ai", "targetname");
  self say_dialog("sala_wait_0");
  self say_dialog("sala_what_are_they_doing_0");
  level.bomb_planter1 say_dialog("pmc1_hurry_it_up_0");
  self say_dialog("sect_planting_explosives_0");
  level.bomb_planter1 say_dialog("pmc1_we_got_four_more_sta_0");
  level.bomb_planter2 say_dialog("pmc2_i_know_i_know_0");
  self queue_dialog("sala_they_going_to_blow_t_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
  self queue_dialog("sect_not_before_they_ve_s_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
  level thread pmc_plant_convo_end();
  self queue_dialog("sect_harper_heads_up_t_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
  self queue_dialog("harp_damn_mercs_gave_me_t_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
  self queue_dialog("sect_dammit_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
  self queue_dialog("sect_better_get_moving_z_0", 0, undefined, array("near_bug_zapper", "bug_zapper_disabled"));
}

pmc_plant_convo_end() {
  level.bomb_planter2 say_dialog("pmc2_okay_set_0");
  level.bomb_planter1 say_dialog("pmc1_ortiz_0");
  level.bomb_planter3 say_dialog("pmc3_nearly_done_just_a_0");
  level.bomb_planter3 say_dialog("pmc3_alright_we_re_good_0", 2.0);
  level.bomb_planter1 say_dialog("pmc1_okay_we_re_our_of_0");
}

bug_zapper_dialog() {
  level thread bug_zapper_done_dialog();
  level endon("bug_zapper_disabled");
  flag_wait("near_bug_zapper");
  level.player say_dialog("sala_careful_section_c_0");
  level.player say_dialog("sect_looks_like_part_of_t_0");
  level.player say_dialog("sala_should_be_a_control_0");
  flag_wait("near_power_box");
  level.player say_dialog("sala_taze_it_0");
}

zapper_proximity_warning_think() {
  level endon("kill_zapper_proximity_warning");
  self waittill("trigger");
  self thread trigger_thread(level.player, ::zapper_proximity_warning_activate, ::zapper_proximity_warning_deactivate);
}

zapper_proximity_warning_activate(ent, str_endon) {
  level endon("kill_zapper_proximity_warning");
  maps\_glasses::add_visor_text("KARMA_ZAPPER_PROXIMITY_WARNING", 0, "orange", "bright", 1, 0.25, 0.25);
}

zapper_proximity_warning_deactivate(ent, str_endon) {
  level endon("kill_zapper_proximity_warning");
  maps\_glasses::remove_visor_text("KARMA_ZAPPER_PROXIMITY_WARNING");
  getent("zapper_proximity_trigger", "targetname") thread zapper_proximity_warning_think();
}

bug_zapper_done_dialog() {
  flag_wait("bug_zapper_disabled");
  level.player say_dialog("sala_okay_0", 1.0);
}

it_manager_dialog() {
  level endon("gulliver_reached");
  ai_it_manager = get_ais_from_scene("it_mgr_walkin", "it_mgr");
  s_security = getent("spiderbot_security_speaker", "targetname");
  s_pmc = getent("spiderbot_pmc_speaker", "targetname");
  ai_it_manager say_dialog("supe_you_tell_him_0");
  s_security say_dialog("tech_i_told_him_he_sai_0", 0.5);
  ai_it_manager say_dialog("supe_dammit_smith_you_0", 0.5);
  ai_it_manager say_dialog("supe_all_you_need_to_do_i_0", 0.25);
  s_security say_dialog("tech_i_tried_sir_but_0", 0.5);
  ai_it_manager say_dialog("supe_what_dammit_0", 0.5);
  s_pmc say_dialog("pmc1_sir_i_need_you_to_0", 0.5);
  ai_it_manager say_dialog("supe_well_i_can_t_tell_y_0", 0.5);
  s_pmc say_dialog("pmc1_sir_we_have_a_secu_0", 0.5);
  s_security say_dialog("tech_what_s_he_saying_0", 0.5);
  ai_it_manager say_dialog("supe_well_i_don_t_real_0", 0.5);
  s_pmc say_dialog("pmc1_sir_your_life_is_i_0", 0.5);
  ai_it_manager say_dialog("supe_what_kind_of_danger_0", 0.5);
  s_security say_dialog("tech_danger_what_s_go_0", 0.5);
  s_pmc say_dialog("pmc1_we_have_reason_to_be_0", 0.5);
  ai_it_manager say_dialog("supe_heaven_above_0", 0.5);
}

gulliver_dialog() {
  self say_dialog("sect_there_s_our_mark_0", 1.0);
  flag_wait("say_taze_him");
  self say_dialog("sala_taze_him_section_0");
  flag_wait("scanning_eye");
  self say_dialog("sect_scanning_now_0");
  scene_wait("spiderbot_smash");
  getent("spiderbot_security_speaker", "targetname") say_dialog("pmc2_seal_the_door_0", 1.0);
  self say_dialog("sect_it_s_the_pmcs_0");
  self say_dialog("sect_harper_you_were_ri_0");
  self say_dialog("sect_let_s_go_0");
  flag_set("spiderbot_transition_done");
}

bots_alive_challenge(str_notify) {
  level endon("bots_alive_challenge_complete");
  level endon("zapped");
  flag_wait("spiderbot_end");
  self notify(str_notify);
  level notify("bots_alive_challenge_complete");
}

sndvoxtriggers(num) {
  while(true) {
    trigger_wait("sndSpdBotVox" + num);
    rpc("clientscripts/karma_amb", "sndSpdBotVox", num);
    wait 1;
  }
}