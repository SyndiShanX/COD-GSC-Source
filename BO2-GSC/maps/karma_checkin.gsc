/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_checkin.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_music;
#include maps\karma_util;
#include maps\karma_arrival;
#include maps\createart\karma_art;
#include maps\karma_anim;
#include maps\_audio;
#include maps\karma_outer_solar;
#include maps\karma;
#include maps\karma_civilians;
#include maps\_drones;
#include maps\_fxanim;

init_flags() {
  flag_init("glasses_activated");
  flag_init("scanner_on");
  flag_init("scanner_off");
  flag_init("team_at_tower");
  flag_init("alarm_on");
  flag_init("security_alert");
  flag_init("flag_left_alert_trigger");
  flag_init("clean_up_tower");
  flag_init("elevator_reached_construction");
  flag_init("sliding_door_open");
  flag_init("sliding_door_opening");
  flag_init("harper_exit_close");
  flag_init("intro_dialogue_finished");
  flag_init("scanner_alert_start");
  flag_init("reception_scan_fx");
  flag_init("guar_stay_where_you_are_0");
  flag_init("guar_the_scanner_detected_0");
  flag_init("work_it_s_a_misunderstand_0");
  flag_init("work_we_re_working_on_the_0");
  flag_init("pa_welcome_salazar_mas_0");
  flag_init("guar_please_remain_where_0");
  flag_init("guar_peters_can_you_come_0");
  flag_init("pa_why_not_show_us_your_0");
  flag_init("pa_visit_our_exclusive_0");
  flag_init("pa_or_maybe_just_take_t_0 ");
}

init_spawn_funcs() {
}

skipto_checkin() {
  arrival_anims();
  maps\karma_arrival::deconstruct_fxanims();
  setmusicstate("KARMA_1_CHECKIN");
  level.ai_harper = init_hero("harper");
  level.ai_salazar = init_hero("salazar_pistol");
  skipto_teleport("skipto_checkin");
  flag_set("fxanim_checkin_start");
  exploder(101);
  level thread maps\karma_arrival::set_water_dvars();
  level maps\karma_arrival::setup_vtol("player_vtol");
  level thread run_scene_and_delete("final_approach_plane_idle");
  level thread maps\karma_arrival::setup_vtol("takeoff_vtol", "start_vtol_takeoff");
  playsoundatposition("veh_vtol_1", (6062, -11630, 1175));
  playsoundatposition("veh_vtol_2", (6542, -11186, 1191));
  level.m_duffle_bag = spawn_model("p6_anim_duffle_bag_karma");
  level.m_duffle_bag set_blend_in_out_times(0.5);
  level.m_harper_briefcase = spawn_model("p6_anim_metal_briefcase");
  level.m_harper_briefcase set_blend_in_out_times(0.5);
  level thread sliding_door_init();
  thread maps\karma_arrival::tarmac_worker_scenes();
  thread maps\karma_arrival::forklift_worker_scenes();
  thread maps\karma_arrival::metalstorm_worker_scenes();
  thread security_left();
  thread scanner_scenes();
  thread scanner_backdrop();
  wait 0.2;
  t_obj = getent("clip_scanner_blocker_2", "targetname");
  set_objective(level.obj_security, t_obj);
  level thread maps\karma_arrival::pa_announcement_dialog();
}

skipto_dropdown() {
  maps\karma_arrival::deconstruct_fxanims();
  level.ai_harper = init_hero("harper");
  level.ai_salazar = init_hero("salazar_pistol");
  level.m_duffle_bag = spawn_model("p6_anim_duffle_bag_karma");
  level.m_duffle_bag.animname = "duffle_bag";
  level.m_duffle_bag set_blend_in_out_times(0.5);
  level.m_harper_briefcase = spawn_model("p6_anim_metal_briefcase");
  level.m_harper_briefcase.animname = "harper_briefcase";
  level.m_harper_briefcase set_blend_in_out_times(0.5);
  flag_set("fxanim_checkin_start");
  skipto_teleport("skipto_tower_lift");
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_elevators");
  run_thread_on_targetname("dynamic_ad", ::dynamic_ad_swap);
  maps\karma_anim::checkin_anims();
  level thread hotel_civ();
  level thread player_railing();
  delay_thread(3.0, ::flag_set, "elevator_wait_end");
}

checkin() {
  iprintln("Check-in");

  checkin_anims();
  setsaveddvar("g_speed", 110);
  level thread intro_worker_pa_dialog();
  level thread checkin_squad_scenes();
  wait 0.05;
  level thread walking_lady();
  level thread sliding_door_close_sound();
  level thread checkin_reception_scanner_fx();
  level thread tarmac_nag_lines();
  flag_wait("t_proceed_scanner");
  level thread checkin_civ_scenes();
  level thread hotel_front_civ();
  flag_wait("gate_open");
  level thread maps\_audio::switch_music_wait("KARMA_1_POST_ALARM", 1);
  level clientnotify("clr_sec");
  set_objective(level.obj_security, undefined, "delete");
  t_obj = getent("trig_tower_lift", "targetname");
  set_objective(level.obj_find_crc, t_obj);
  flag_wait("hotel_back_civs");
  run_thread_on_targetname("dynamic_ad", ::dynamic_ad_swap);
  level thread hotel_back_civ_scenes();
  flag_wait("trig_player_blocker_2");
  level thread hotel_back_civ();
  flag_wait("t_proceed_tower");
  flag_wait("start_vtol_flyby");
  exploder(330);
  exploder(331);
  level thread maps\karma_arrival::setup_vtol("hip_top_deck_flyby");
  level thread hotel_civ();
  level thread player_railing();
  flag_wait("team_at_tower");
}

checkin_armraise(ent) {
  trigger_wait("checkin_armraise_trigger");
  level thread maps\karma_outer_solar::player_show_wristband();
  wait 1.5;
  flag_set("reception_scan_fx");
}

checkin_reception_scanner_fx() {
  getent("checkin_scanner2", "targetname") thread play_fx("checkin_scanner_red", undefined, undefined, "stop_checkin_scanner_fx2", 1, "tag_fx", 1);
  e_scanner = getent("checkin_scanner1", "targetname");

  while(!flag("reset_player_speed")) {
    e_scanner thread play_fx("checkin_scanner_red", undefined, undefined, "stop_checkin_scanner_fx", 1, "tag_fx", 1);
    flag_wait("reception_scan_fx");
    flag_clear("reception_scan_fx");
    e_scanner notify("stop_checkin_scanner_fx");
    wait 0.1;
    e_scanner thread play_fx("checkin_scanner_green", undefined, undefined, "stop_checkin_scanner_fx", 1, "tag_fx", 1);
    playsoundatposition("evt_checkin_tone", (4555, -8163, 956));
    wait 0.5;
    e_scanner notify("stop_checkin_scanner_fx");
    wait 0.1;
  }
}

sliding_door_init() {
  level endon("kill_sliding_doors");
  e_door = getent("sliding_door_left", "targetname");
  getent(e_door.target, "targetname") linkto(e_door);
  e_door = getent("sliding_door_right", "targetname");
  getent(e_door.target, "targetname") linkto(e_door);
  getent("sliding_door_proximity_trigger", "targetname") thread sliding_door_think();
}

sliding_door_think() {
  level endon("kill_sliding_doors");
  level endon("sliding_door_reset");
  self waittill("trigger");
  self thread trigger_thread(level.player, ::sliding_door_open, ::sliding_door_close);
}

sliding_door_close(ent, endon_string) {
  level endon("kill_sliding_doors");
  level endon("sliding_door_stop_close");
  e_trigger = getent("sliding_door_proximity_trigger", "targetname");
  e_left_door = getent("sliding_door_left", "targetname");
  e_right_door = getent("sliding_door_right", "targetname");
  s_left_door_closed = getstruct("sliding_door_left_closed", "targetname");
  s_right_door_closed = getstruct("sliding_door_right_closed", "targetname");
  flag_wait("sliding_door_open");

  while(true) {
    if(!level.ai_harper istouching(e_trigger) && !level.ai_salazar istouching(e_trigger) && !level.player istouching(e_trigger)) {
      level notify("cls_dr");
      wait 0.5;
      e_left_door moveto(s_left_door_closed.origin, 1.0);
      e_right_door moveto(s_right_door_closed.origin, 1.0);
      flag_clear("sliding_door_open");
      break;
    }

    wait 0.05;
  }

  level notify("sliding_door_reset");
  getent("sliding_door_proximity_trigger", "targetname") thread sliding_door_think();
}

sliding_door_close_sound() {
  level endon("kill_sliding_doors");

  while(true) {
    level waittill("cls_dr");
    wait 0.5;
    playsoundatposition("amb_sliding_door_close", (4665, -9823, 991));
    wait 2;
  }
}

sliding_door_open(ent) {
  level endon("kill_sliding_doors");
  level notify("sliding_door_stop_close");

  if(!flag("sliding_door_open")) {
    playsoundatposition("amb_sliding_door_open", (4665, -9823, 991));
    e_left_door = getent("sliding_door_left", "targetname");
    e_right_door = getent("sliding_door_right", "targetname");
    s_left_door_open = getstruct("sliding_door_left_open", "targetname");
    s_right_door_open = getstruct("sliding_door_right_open", "targetname");
    n_max_distance = distance2dsquared(s_left_door_open.origin, getstruct("sliding_door_left_closed", "targetname").origin);
    n_current_distance = distance2dsquared(e_left_door.origin, s_left_door_open.origin);
    n_max_time = 1.0;
    n_current_time = n_max_time * (n_current_distance / n_max_distance);
    n_current_time = max(n_current_time, 0.05);
    e_left_door moveto(s_left_door_open.origin, n_current_time);
    e_right_door moveto(s_right_door_open.origin, n_current_time);
    waittill_multiple_ents(e_left_door, "movedone", e_right_door, "movedone");
    flag_set("sliding_door_open");
  }
}

tower_lift() {
  iprintln("Tower Lift");

  level.sound_elevator_ent_1 = spawn("script_origin", level.player.origin);
  level.sound_elevator_ent_2 = spawn("script_origin", level.player.origin);
  level thread player_group_think();
  trigger_wait("trig_tower_lift");
  objective_set3d(level.obj_find_crc, 0);
  trigger_wait("t_ship_interior");
  tower_cleanup();
  load_gump("karma_gump_construction");
  flag_wait("elevator_reached_construction");
}

checkin_civ_scenes() {
  level thread receptionist_left();
  wait 1;
  level thread hotel_front_civ_scenes();
  wait 1;
  level thread civ_girl_goto_railing();
}

walking_lady() {
  run_scene_first_frame("hotel_ladywalking");
  flag_wait("gate_open");
  wait 3;
  run_scene_and_delete("hotel_ladywalking");
  thread run_scene_and_delete("hotel_ladywalking_idle");
  flag_wait("clean_up_tower");
}

civ_goto_railing() {
  level endon("cleanup_checkin");
  run_scene_first_frame("hotel_goto_railing");
  flag_wait("t_proceed_tower");
  wait 3;
  run_scene_and_delete("hotel_goto_railing");
  thread run_scene_and_delete("hotel_goto_railing_idle");
  flag_wait("clean_up_tower");
}

civ_girl_goto_railing() {
  level endon("cleanup_checkin");
  thread run_scene_and_delete("hotel_goto_girl_idle1");
  flag_wait("hotel_goto_girl_idle1_started");
  ai_girl = get_ais_from_scene("hotel_goto_girl_idle1", "hotel_goto_girl");
  m_phone = spawn("script_model", ai_girl gettagorigin("tag_weapon_right"));
  m_phone.angles = ai_girl gettagangles("tag_weapon_right");
  m_phone.script_noteworthy = "cleanup_tower";
  m_phone setmodel("p6_anim_cell_phone");
  m_phone linkto(ai_girl, "tag_weapon_right");
  flag_wait("t_proceed_tower");
  wait 3;
  run_scene_and_delete("hotel_goto_girl_walk");
  thread run_scene_and_delete("hotel_goto_girl_idle2");
}

checkin_squad_scenes() {
  run_scene_and_delete("team_walk_intro");
  level thread run_scene_and_delete("team_intro_idle");
  level.ai_harper set_blend_in_out_times(0.5);
  level.ai_salazar set_blend_in_out_times(0.5);
  level.m_duffle_bag set_blend_in_out_times(0.5);
  level.m_harper_briefcase set_blend_in_out_times(0.5);
  flag_wait("alert");
  run_scene_and_delete("section_walk_2_1", 1);
  level thread run_scene_and_delete("tower_lift_wait");
  flag_set("team_at_tower");
}

receptionist_left() {
  flag_wait("alert");
  run_scene_and_delete("receptionist_left");
  level thread run_scene_and_delete("receptionist_left_idle");
  flag_wait("clean_up_tower");
  end_scene("receptionist_left_idle");
}

glasses_scene() {
  glasses = getent("glasses", "targetname");
  glasses setviewmodelrenderflag(1);
  run_scene_and_delete("player_put_on_glasses");
}

hudsupdisplay(guy) {
  maps\_glasses::play_bootup();
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_introglasseson");
  wait 1.0;
  flag_set("glasses_activated");
  level.player show_hud();
  level thread maps\karma::add_argus_info();
}

hotel_front_civ_scenes() {
  thread run_scene_and_delete("checkin_bellhop_a");
  thread run_scene_and_delete("checkin_bellhop_b");
  thread run_scene_and_delete("hotel_security_front");
  wait 1;
  thread run_scene_and_delete("hotel_reception_civs");
}

hotel_back_civ_scenes() {
  thread run_scene_and_delete("elevator_civs");
  wait 1;
  thread run_scene_and_delete("lobby_guy8");
  wait 1;
  thread run_scene_and_delete("lobby_guy14");
  wait 1;
  thread run_scene_and_delete("lobby_guy15");
  wait 1;
  flag_wait("clean_up_tower");
  end_scene("elevator_civs");
  end_scene("lobby_guy8");
  end_scene("lobby_guy14");
  end_scene("lobby_guy15");
}

scanner_prep() {
  assert(isDefined(self.script_animname), "Add an animname to the guy at " + self.origin);
  self add_cleanup_ent("checkin");

  if(isDefined(self.script_string) && self.script_string == "scanner")
    self thread scanner_model_swap();
}

scanner_model_swap() {
  self endon("death");
  level endon("inside_tower_lift");
  self.model_original = self.model;
  self ent_flag_init("in_scanner");
  self ent_flag_wait("in_scanner");

  while(true) {
    flag_wait("scanner_on");

    if(self.targetname == "checkin_security_ai")
      self setmodel("c_mul_jinan_guard_bscatter_fb");
    else
      self setmodel("c_mul_jinan_demoworker_bscatter_fb");

    flag_wait("scanner_off");
    self setmodel(self.model_original);
  }
}

inside_scanner(guy) {
  guy ent_flag_set("in_scanner");
  flag_set("alarm_on");
  clientnotify("alarm_on");
}

scanner_backdrop() {
  level endon("inside_tower_lift");
  flag_wait("start_tarmac");
  bm_backdrop = getent("scanner_backdrop", "targetname");
  e_vol_backdrop = getent("vol_scanner", "targetname");

  while(true) {
    bm_backdrop trigger_off();
    flag_clear("scanner_on");
    flag_set("scanner_off");

    while(!level.player istouching(e_vol_backdrop))
      wait 0.1;

    bm_backdrop trigger_on();
    flag_clear("scanner_off");
    flag_set("scanner_on");

    while(level.player istouching(e_vol_backdrop))
      wait 0.1;
  }
}

scanner_scenes(a_ai_explosives_workers, a_ai_security) {
  flag_wait("start_tarmac");
  bm_clip = getent("clip_scanner_blocker", "targetname");
  bm_clip trigger_off();
  a_ai_security = simple_spawn("checkin_security", ::scanner_prep);
  a_ai_explosives_workers = simple_spawn("explosives_workers", ::scanner_prep);
  level thread security_left_gate();
  level thread security_middle_alert();
  level thread securityr_and_workers_alert();
  getent("scanner_gun_trigger", "targetname") thread security_scanner_gun_think();
  trigger_wait("trig_workers_alert");
  level notify("stop_scanner_gun_show");
  level notify("stop_scanner_gun_hide");

  foreach(ai_worker in a_ai_explosives_workers) {
    ai_worker thread scanner_ping_fx("J_Ankle_LE", (0, 0, 0));
    ai_worker thread scanner_ping_fx("J_Ankle_RI", (0, 0, 0));
  }

  foreach(gun in getentarray("scanner_gun", "targetname"))
  gun thread cleanup_red_guns();

  foreach(ping in getentarray("scanner_gun_ping", "targetname"))
  ping thread cleanup_gun_pings();

  trigger_wait("trig_enter_scanner");
  level thread lobby_naglines();
  security_gate();
  bm_clip trigger_on();
  level thread maps\_audio::switch_music_wait("KARMA_1_ALARM", 6);
  exploder(104);
  delete_exploder(105);
}

security_scanner_gun_think() {
  level endon("kill_scanner_gun_logic");
  self waittill("trigger");
  self thread trigger_thread(level.player, ::show_scanner_gun, ::hide_scanner_gun);
}

show_scanner_gun() {
  level endon("kill_scanner_gun_logic");
  level endon("stop_scanner_gun_show");
  level notify("stop_scanner_gun_hide");

  foreach(ai_security in getentarray("checkin_security_ai", "targetname")) {
    if(isDefined(ai_security.script_string) && ai_security.script_string == "scanner") {
      m_gun_tag_origin = spawn("script_model", ai_security.origin);
      m_gun_tag_origin setmodel("t6_wpn_pistol_fiveseven_world_detect");
      m_gun_tag_origin linkto(ai_security, "TAG_WEAPON_RIGHT", (0, 0, 0));
      m_gun_tag_origin.targetname = "scanner_gun";
      fxorg = spawn("script_model", (0, 0, 0));
      fxorg setmodel("tag_origin");
      fxorg.targetname = "scanner_gun_ping";
      fxorg.origin = ai_security gettagorigin("tag_weapon_right");
      fxorg.angles = ai_security gettagangles("tag_weapon_right");
      fxorg linkto(ai_security, "tag_weapon_right", vectorscale((-1, 0, 0), 10.0));
      playfxontag(level._effect["scanner_ping"], fxorg, "tag_origin");
    }
  }
}

hide_scanner_gun() {
  level endon("kill_scanner_gun_logic");
  level endon("stop_scanner_gun_hide");
  level notify("stop_scanner_gun_show");

  if(!flag("scanner_alert_start")) {
    foreach(gun in getentarray("scanner_gun", "targetname")) {
      gun unlink();
      gun delete();
    }

    foreach(ping in getentarray("scanner_gun_ping", "targetname"))
    ping delete();

    getent("scanner_gun_trigger", "targetname") thread security_scanner_gun_think();
  }
}

scanner_ping_fx(e_tag, e_fx_offset) {
  fxorg = spawn("script_model", (0, 0, 0));
  fxorg setmodel("tag_origin");
  fxorg.origin = self gettagorigin(e_tag);
  fxorg.angles = self gettagangles(e_tag);
  fxorg linkto(self, e_tag, e_fx_offset);
  fxorg thread ping_fx_sounds();
  playfxontag(level._effect["scanner_ping"], fxorg, "tag_origin");
  flag_wait("trig_player_blocker_2");
  fxorg delete();
}

ping_fx_sounds() {
  wait 4;
  self playsound("evt_scanner_alarm");

  while(isDefined(self)) {
    self playsound("evt_scanner_ping");
    wait 2.3;
  }
}

security_left_gate() {
  sec_gate_left_player = getent("sec_gate_left_player", "targetname");
  sec_gate_right_player = getent("sec_gate_right_player", "targetname");
  bm_clip_2 = getent("clip_scanner_blocker_2", "targetname");
  flag_wait("gate_alert");
  sec_gate_left_player rotateyaw(-90, 0.7, 0.5, 0.2);
  sec_gate_left_player playsound("evt_scanner_gate_close");
  sec_gate_right_player rotateyaw(90, 0.7, 0.5, 0.2);
  bm_clip_2 trigger_on();
  flag_wait("gate_open");
  sec_gate_left_player rotateyaw(90, 0.7, 0.5, 0.2);
  sec_gate_left_player playsound("evt_scanner_gate_open");
  sec_gate_right_player rotateyaw(-90, 0.7, 0.5, 0.2);
  bm_clip_2 trigger_off();
  flag_wait("trig_player_blocker_2");
  level notify("kill_scanner_gun_logic");
  level notify("kill_sliding_doors");
  sec_gate_left_player rotateyaw(-90, 0.7, 0.5, 0.2);
  sec_gate_left_player playsound("evt_scanner_gate_close");
  sec_gate_right_player rotateyaw(90, 0.7, 0.5, 0.2);
  bm_clip_2 trigger_on();
}

security_gate() {
  sec_gate_left = getent("sec_gate_left", "targetname");
  sec_gate_left playsound("evt_scanner_gate_close");
  sec_gate_left rotateyaw(-90, 0.7, 0.5, 0.2);
  sec_gate_right = getent("sec_gate_right", "targetname");
  sec_gate_right rotateyaw(90, 0.7, 0.5, 0.2);
  sec_gate_left_anim = getent("sec_gate_left_anim", "targetname");
  sec_gate_left_anim rotateyaw(-90, 0.7, 0.5, 0.2);
  sec_gate_right_anim = getent("sec_gate_right_anim", "targetname");
  sec_gate_right_anim rotateyaw(90, 0.7, 0.5, 0.2);
  sec_gate_left_player_anim = getent("sec_gate_left_player_anim", "targetname");
  sec_gate_left_player_anim rotateyaw(-90, 0.7, 0.5, 0.2);
  sec_gate_right_player_anim = getent("sec_gate_right_player_anim", "targetname");
  sec_gate_right_player_anim rotateyaw(90, 0.7, 0.5, 0.2);
}

security_left() {
  flag_wait("start_tarmac");
  run_scene_and_delete("security_left");
  level thread run_scene_and_delete("security_left_idle");
  ai_guard = getent("security1_ai", "targetname");
  ai_guard set_blend_in_out_times(0.2);
  flag_wait("alert");
  level clientnotify("start");
  run_scene_and_delete("security_left_alert", 1);
  level thread run_scene_and_delete("security_left_alert_idle");
  ai_guard set_blend_in_out_times(0);
}

security_middle_alert() {
  level thread run_scene_and_delete("security_middle_idle");
  veh_metalstorm = get_model_or_models_from_scene("security_middle_idle", "scanner_metalstorm");
  veh_metalstorm play_fx("eye_light_friendly", undefined, undefined, "metalstorm_off", 1, "tag_scanner");
  flag_wait("alert");
  veh_metalstorm notify("metalstorm_off");
  veh_metalstorm play_fx("eye_light_enemy", undefined, undefined, "metalstorm_off", 1, "tag_scanner");
  run_scene_and_delete("security_middle_alert", 1);
  level thread run_scene_and_delete("security_middle_alert_idle");
}

securityr_and_workers_alert() {
  level thread alert_trigger_check();
  level thread run_scene_and_delete("security_right_idle");
  flag_wait("left_alert_trigger");
  flag_wait("flag_left_alert_trigger");
  run_scene_and_delete("securityR_and_workers_alert");
  level thread run_scene_and_delete("securityR_and_workers_alert_idle");
}

alert_trigger_check() {
  trig = getent("trig_workers_alert", "targetname");

  while(!level.player istouching(trig))
    wait 0.05;

  flag_set("flag_left_alert_trigger");
}

cleanup_red_guns() {
  flag_wait("trig_player_blocker_2");
  self unlink();
  self delete();
}

cleanup_gun_pings() {
  flag_wait("trig_player_blocker_2");
  self delete();
}

dynamic_ad_swap() {
  level endon("inside_tower_lift");
  self ignorecheapentityflag(1);
  ai_check_other = undefined;

  if(isDefined(self.script_string) && self.script_string == "harper")
    ai_check_other = level.ai_harper;

  if(isDefined(self.script_string) && self.script_string == "salazar")
    ai_check_other = level.ai_salazar;

  self setclientflag(8);
  b_other_in_range = 0;
  b_player_in_range = 0;
  wait 1;

  while(true) {
    n_dist = 1000000;

    if(isDefined(ai_check_other)) {
      n_dist_other = distancesquared(self.origin, ai_check_other.origin);

      if(!b_other_in_range && n_dist_other < 22500) {
        b_other_in_range = 1;
        self setclientflag(3);
      } else if(b_other_in_range && n_dist_other > 22500) {
        b_other_in_range = 0;
        self clearclientflag(3);
      }
    }

    if(!b_other_in_range) {
      n_dist_player = distancesquared(self.origin, level.player.origin);

      if(!b_player_in_range && n_dist_player < 22500) {
        b_player_in_range = 1;
        self setclientflag(5);
        continue;
      } else if(b_player_in_range && n_dist_player > 22500) {
        b_player_in_range = 0;
        self clearclientflag(5);
      }
    }

    wait 0.1;
  }
}

start_atrium_walkers() {
  maps\karma_civilians::assign_civ_drone_spawners("atrium_walkers", "atrium_drones1");
  maps\_drones::drones_setup_unique_anims("atrium_drones1", level.drones.anims["civ_walk"]);
  maps\karma_civilians::assign_civ_drone_spawners("atrium_walkers", "atrium_drones2");
  maps\_drones::drones_setup_unique_anims("atrium_drones2", level.drones.anims["civ_walk"]);
  maps\karma_civilians::assign_civ_drone_spawners("atrium_walkers", "atrium_drones3");
  maps\_drones::drones_setup_unique_anims("atrium_drones3", level.drones.anims["civ_walk"]);
  maps\karma_civilians::assign_civ_drone_spawners("atrium_walkers", "atrium_drones4");
  maps\_drones::drones_setup_unique_anims("atrium_drones4", level.drones.anims["civ_walk"]);
  level thread maps\_drones::drones_start("atrium_drones1");
  level thread maps\_drones::drones_start("atrium_drones2");
  level thread maps\_drones::drones_start("atrium_drones3");
  level thread maps\_drones::drones_start("atrium_drones4");
}

delete_atrium_walkers() {
  level thread maps\_drones::drones_delete("atrium_drones1");
  level thread maps\_drones::drones_delete("atrium_drones2");
  level thread maps\_drones::drones_delete("atrium_drones3");
  level thread maps\_drones::drones_delete("atrium_drones4");
}

player_group_think() {
  delete_exploder(99);
  wait 0.25;
  bm_lift_left = setup_elevator("tower_lift_left", "tower_elevator_1", "cleanup_dropdown");
  playsoundatposition("amb_elevator_open_fast", (4505, -7218, 962));
  e_align = getent("align_player", "targetname");
  e_align linkto(bm_lift_left);
  m_tag_origin = spawn("script_model", e_align.origin);
  m_tag_origin setmodel("tag_origin");
  m_tag_origin.angles = e_align.angles;
  m_tag_origin linkto(e_align);
  level.ai_harper set_blend_in_out_times(0);
  level.m_harper_briefcase set_blend_in_out_times(0);
  level.ai_salazar set_blend_in_out_times(0);
  level.m_duffle_bag set_blend_in_out_times(0);
  flag_wait("near_tower_lift");
  level thread autosave_by_name("karma_checkin_end");
  bm_player_clip = getent("clip_tower_lift_top", "targetname");
  bm_player_clip trigger_off();
  bm_lift_left thread elevator_move_doors(1, 1.0, 0.2, 0.5);
  thread run_scene("tower_elevator_open");
  m_outer_left = getent("door_outer_elevator_1left", "targetname");
  m_outer_right = getent("door_outer_elevator_1right", "targetname");
  m_outer_left movex(-58, 1.0, 0.2, 0.5);
  m_outer_right movex(58, 1.0, 0.2, 0.5);
  wait 1.0;
  flag_clear("elevator_wait_end");
  flag_wait("elevator_wait_end");
  run_scene_and_delete("tower_lift_enter");
  level thread run_scene_and_delete("tower_lift_enter_wait");
  level.ai_salazar linkto(m_tag_origin);
  level.ai_harper linkto(m_tag_origin);
  level.m_duffle_bag linkto(m_tag_origin);
  level.m_harper_briefcase linkto(m_tag_origin);
  trigger_wait("trig_tower_lift");
  set_objective(level.obj_find_crc, undefined, "remove");
  bm_player_clip trigger_on();
  bm_player_clip linkto(bm_lift_left);
  bm_player_clip setmovingplatformenabled(1);
  level thread run_scene_and_delete("tower_lift_workers_run");
  wait 3.0;
  playsoundatposition("amb_elevator_close", (4504, -7112, 962));
  start_atrium_walkers();
  bm_lift_left thread elevator_move_doors(0, 1.0, 0.2, 0.5);
  m_outer_left movex(58, 1.0, 0.2, 0.5);
  m_outer_right movex(-58, 1.0, 0.2, 0.5);
  run_scene("tower_elevator_close");
  level thread checkin_cleanup();
  level notify("inside_tower_lift");

  foreach(metalstorm in getentarray("arrival_metalstorm", "targetname"))
  metalstorm delete();

  clientnotify("sbpv");
  level.player playsound("amb_elevator_start");
  level.sound_elevator_ent_1 playloopsound("amb_elevator_loop", 1);
  level thread elevator_stop_delay_1();
  s_destination = getstruct("tower_lift_left_middle", "targetname");
  bm_lift_left setmovingplatformenabled(1);
  bm_lift_left moveto(s_destination.origin, 24, 3.0, 2.0);
  bm_lift_left waittill("movedone");
  wait 2.0;
  level thread run_scene("tower_elevator_open");
  playsoundatposition("amb_elevator_open", (4506, -6091, -2844));
  level clientnotify("edo");
  scene_wait("tower_lift_workers_run");
  level.ai_harper unlink();
  level.m_harper_briefcase unlink();
  level thread run_scene_and_delete("tower_lift_harper_exit");
  level thread run_scene_and_delete("tower_lift_karma_exit");
  level thread run_scene_and_delete("tower_lift_salazar_exit");
  flag_wait("harper_exit_close");
  playsoundatposition("amb_elevator_close_2", (4506, -6091, -2844));
  run_scene("tower_elevator_close");
  delete_atrium_walkers();
  level clientnotify("edc");
  wait 1.0;
  level thread maps\_audio::switch_music_wait("KARMA_1_CONSTRUCTION", 9);
  level.player playsound("amb_elevator_start_2");
  level.sound_elevator_ent_1 playloopsound("amb_elevator_loop", 1);
  level thread elevator_stop_delay_2();
  wait 1.0;
  s_destination = getstruct("tower_lift_left_bottom", "targetname");
  bm_lift_left setmovingplatformenabled(1);
  bm_lift_left moveto(s_destination.origin, 5, 1.0, 1.0);
  bm_lift_left waittill("movedone");
  level.ai_salazar unlink();
  level.m_duffle_bag unlink();
  m_tag_origin delete();
  flag_set("elevator_reached_construction");
  level thread maps\_fxanim::fxanim_delete("fxanim_checkin");
}

karma_remove_name(ent) {
  ent.airank = "";
  ent.name = "";
  ent notify("set name and rank");
}

elevator_stop_delay_1() {
  wait 18;
  level.sound_elevator_ent_1 stoploopsound(1);
  level.player playsound("amb_elevator_stop");
}

elevator_stop_delay_2() {
  wait 4.5;
  level.sound_elevator_ent_1 stoploopsound(1);
  level.player playsound("amb_elevator_stop");
  wait 2.8;
  playsoundatposition("amb_elevator_open_final", (4480, -5945, -3508));

  if(isDefined(level.sound_elevator_ent_1))
    level.sound_elevator_ent_1 delete();

  if(isDefined(level.sound_elevator_ent_2))
    level.sound_elevator_ent_2 delete();
}

checkin_cleanup() {
  cleanup_ents("cleanup_checkin");
  delete_exploder(101);
  delete_exploder(102);
  delete_exploder(104);

  if(level.skipto_point == "dropdown") {
    return;
  }
  end_scene("security_left_alert_idle");
  end_scene("checkin_bellhop_a");
  end_scene("checkin_bellhop_b");
  end_scene("hotel_security_front");
  end_scene("hotel_reception_civs");
}

tower_cleanup() {
  cleanup_ents("cleanup_tower");
  delete_exploder(330);
  delete_exploder(331);
  flag_set("clean_up_tower");
  level thread maps\_drones::drones_delete_spawned();
  level thread maps\_drones::drones_delete("hotel_drones");
  level maps\karma_civilians::delete_civs("hotel_girl");
}

pa_dialog() {
  flag_wait("sndStartPAVox");
  ent = spawn("script_origin", (4667, -10267, 1150));
  ent playpavox("vox_kar_1_01_001a_pa");
  ent playpavox("vox_kar_1_01_002a_pa");
  ent playpavox("vox_kar_1_01_003a_pa");
  ent playpavox("vox_kar_1_01_004a_pa");
  ent playpavox("vox_kar_1_01_005a_pa");
  ent delete();
  flag_wait("t_proceed_scanner");
  ent = spawn("script_origin", (4670, -9695, 1042));
  ent playpavox("vox_kar_2_02_001a_pa");
  ent delete();
  flag_wait("sndPlayPAWelcome");
  ent = spawn("script_origin", (4564, -9287, 1038));
  ent playpavox("vox_kar_2_02_004a_pa");
  ent playpavox("vox_kar_2_02_005a_pa");
  ent delete();
}

playpavox(alias) {
  self playsound(alias, "sounddone");
  self waittill("sounddone");
}

septic_dialog() {
  wait 42;
  level.player say_dialog("al_jinans_the_wea_002");
  level.player say_dialog("proceed_as_planned_003");
}

hotel_civ() {
  maps\karma_civilians::assign_civ_spawners("civ_hotel_light_female");
  level maps\karma_civilians::spawn_static_civs("hotel_girl");
  maps\karma_civilians::assign_civ_drone_spawners("civ_hotel_light", "hotel_drones");
  maps\_drones::drones_setup_unique_anims("hotel_drones", level.drones.anims["civ_walk"]);
  maps\_drones::drones_speed_modifier("hotel_drones", -0.1, 0.1);
  maps\_drones::drones_set_max(75);
  level thread maps\_drones::drones_start("hotel_drones");
}

hotel_front_civ() {
  maps\karma_civilians::assign_civ_spawners("hotel_female_dress");
  maps\karma_civilians::assign_civ_spawners("hotel_female_rich3");
  wait 0.05;
  maps\karma_civilians::assign_civ_spawners("hotel_female_rich4");
  maps\karma_civilians::assign_civ_spawners("hotel_male_rich4");
  wait 0.05;
  maps\karma_civilians::assign_civ_spawners("hotel_male_rich6");
  maps\karma_civilians::assign_civ_spawners("checkin_worker_new");
  level maps\karma_civilians::spawn_static_civs("hotel_front_girl");
  level maps\karma_civilians::spawn_static_civs("hotel_front_guy");
  level maps\karma_civilians::spawn_static_civs("hotel_front_worker");
  flag_wait("clean_up_tower");
  level maps\karma_civilians::delete_civs("hotel_front_girl");
  level maps\karma_civilians::delete_civs("hotel_front_guy");
  level maps\karma_civilians::delete_civs("hotel_front_worker");
}

hotel_back_civ() {
  level maps\karma_civilians::spawn_static_civs("hotel_back_girl_first");
  level maps\karma_civilians::spawn_static_civs("hotel_back_guy_first");
  wait 0.1;
  level maps\karma_civilians::spawn_static_civs("hotel_back_girl_second");
  level maps\karma_civilians::spawn_static_civs("hotel_back_guy_second");
  flag_wait("clean_up_tower");
  level maps\karma_civilians::delete_civs("hotel_back_girl_first");
  level maps\karma_civilians::delete_civs("hotel_back_guy_first");
  level maps\karma_civilians::delete_civs("hotel_back_girl_second");
  level maps\karma_civilians::delete_civs("hotel_back_guy_second");
}

player_railing() {
  trigger_wait("t_player_railing");
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_vista");
  run_scene_and_delete("player_railing");
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_elevators");
}

intro_worker_pa_dialog() {
  flag_wait("securityR_and_workers_alert_started");
  ai_guard = get_ais_from_scene("securityR_and_workers_alert", "security_03");
  ai_worker1 = get_ais_from_scene("securityR_and_workers_alert", "explosives_worker1");
  ai_worker2 = get_ais_from_scene("securityR_and_workers_alert", "explosives_worker2");
  flag_wait("guar_stay_where_you_are_0");
  ai_guard say_dialog("guar_stay_where_you_are_0");
  flag_wait("guar_the_scanner_detected_0");
  ai_guard say_dialog("guar_the_scanner_detected_0");
  flag_wait("work_it_s_a_misunderstand_0");
  ai_worker1 say_dialog("work_it_s_a_misunderstand_0");
  flag_wait("work_we_re_working_on_the_0");
  ai_worker2 say_dialog("work_we_re_working_on_the_0");
  flag_wait("pa_welcome_salazar_mas_0");
  flag_wait("guar_please_remain_where_0");
  ai_guard say_dialog("guar_please_remain_where_0");
  flag_wait("guar_peters_can_you_come_0");
  ai_guard say_dialog("guar_peters_can_you_come_0");
  flag_wait("pa_why_not_show_us_your_0");
  s_pos = getstruct("pa_node_club", "targetname");
  e_pa_pos = spawn("script_origin", s_pos.origin);
  e_pa_pos say_dialog("pa_why_not_show_us_your_0", undefined, 1);
  flag_wait("pa_visit_our_exclusive_0");
  e_pa_pos delete();
  s_pos = getstruct("pa_node_shops", "targetname");
  e_pa_pos = spawn("script_origin", s_pos.origin);
  e_pa_pos say_dialog("pa_visit_our_exclusive_0", undefined, 1);
  flag_wait("pa_or_maybe_just_take_t_0 ");
  e_pa_pos delete();
  s_pos = getstruct("pa_node_pool", "targetname");
  e_pa_pos = spawn("script_origin", s_pos.origin);
  e_pa_pos say_dialog("pa_or_maybe_just_take_t_0", undefined, 1);
  wait 5.0;
  e_pa_pos delete();
}

tarmac_nag_lines() {
  a_lines = [];
  a_lines[0][0] = "harp_come_on_man_0";
  a_lines[0][1] = "harper";
  a_lines[1][0] = "sala_something_wrong_sec_0";
  a_lines[1][1] = "salazar";
  a_lines[2][0] = "harp_we_re_on_a_schedule_0";
  a_lines[2][1] = "harper";
  n_current_line = 0;
  flag_wait("intro_dialogue_finished");
  wait 15.0;

  while(!flag("scanner_alert_start") && n_current_line < 3) {
    if(distance2dsquared(level.ai_harper.origin, level.player.origin) > 262144) {
      if(a_lines[n_current_line][1] == "harper")
        level.ai_harper say_dialog(a_lines[n_current_line][0]);
      else
        level.ai_salazar say_dialog(a_lines[n_current_line][0]);

      n_current_line++;
      wait 10.0;
    }

    wait 0.05;
  }
}

lobby_naglines() {
  a_lines = [];
  a_lines[0][0] = "sala_what_are_you_waiting_0";
  a_lines[0][1] = "salazar";
  a_lines[1][0] = "harp_hey_quit_eyeballin_0";
  a_lines[1][1] = "harper";
  n_current_line = 0;
  flag_wait("tower_lift_wait_started");
  wait 10.0;

  while(!flag("near_tower_lift")) {
    if(n_current_line < 2 && a_lines[n_current_line][1] == "harper") {
      level.ai_harper say_dialog(a_lines[n_current_line][0]);
      wait 10.0;
    } else if(n_current_line < 2) {
      level.ai_salazar say_dialog(a_lines[n_current_line][0]);
      wait 10.0;
    }

    n_current_line++;
    wait 0.05;
  }
}

receptionist1_attach_head(e_receptionist) {
  if(e_receptionist.headmodel != "c_mul_civ_club_female_head1") {
    e_receptionist detach(e_receptionist.headmodel, "");
    e_receptionist.headmodel = "c_mul_civ_club_female_head1";
    e_receptionist attach(e_receptionist.headmodel, "", 1);
  }
}

receptionist2_attach_head(e_receptionist) {
  if(e_receptionist.headmodel != "c_mul_civ_club_female_head2") {
    e_receptionist detach(e_receptionist.headmodel, "");
    e_receptionist.headmodel = "c_mul_civ_club_female_head2";
    e_receptionist attach(e_receptionist.headmodel, "", 1);
  }
}