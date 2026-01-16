/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_skipto;
#include maps\karma_util;
#include maps\_glasses;
#include maps\karma_fx;
#include maps\karma_anim;
#include maps\_metal_storm;
#include maps\_rusher;
#include maps\_load;
#include maps\karma_amb;
#include maps\_heatseekingmissile;
#include maps\_drones;
#include maps\karma_civilians;
#include maps\_civilians;
#include maps\createart\karma_art;
#include maps\karma_arrival;
#include maps\karma_checkin;
#include maps\karma_dropdown;
#include maps\karma_spiderbot;
#include maps\karma_crc;
#include maps\karma_construction;
#include maps\karma_outer_solar;
#include maps\karma_inner_solar;
#include maps\_challenges_sp;

main() {
  level.createfx_callback_thread = ::createfx_setup;
  maps\karma_fx::main();
  maps\karma_anim::main();
  maps\_metal_storm::init();
  maps\_rusher::init_rusher();
  level_precache();
  init_flags();
  setup_objectives();
  setup_skiptos();
  maps\_load::main();
  init_spawn_funcs();
  maps\karma_amb::main();
  maps\_heatseekingmissile::init();
  onplayerconnect_callback(::on_player_connect);
  level thread maps\_drones::init();
  level thread maps\karma_civilians::civ_init();
  maps\_civilians::init_civilians();
  level thread maps\createart\karma_art::main();
  a_m_clips = getentarray("compile_paths_clips", "targetname");

  foreach(m_clip in a_m_clips)
  m_clip delete();
}

on_player_connect() {
  self setup_challenges();
  self thread maps\createart\karma_art::vision_set_change("sp_karma_flyin_desat");
  run_thread_on_targetname("vision_trigger", ::vision_set_trigger_think);
}

level_precache() {
  precacheitem("noweapon_sp");
  precacheitem("noweapon_sp_arm_raise");
  precacheitem("kard_reflex_nofirstraise_sp");
  precacheitem("flash_grenade_sp");
  precacheitem("concussion_grenade_sp");
  precachemodel("c_usa_masonjr_karma_viewbody");
  precachemodel("c_usa_masonjr_karma_viewhands");
  precachemodel("test_p_anim_specialty_lockbreaker_device");
  precachemodel("test_p_anim_specialty_lockbreaker_padlock");
  precachemodel("test_p_anim_specialty_trespasser_card_swipe");
  precachemodel("t6_wpn_hacking_dongle_prop");
  precachemodel("t6_wpn_tablet_prop_world");
  precachemodel("p6_anim_cell_phone");
  precachemodel("p_glo_clipboard_wpaper");
  precachemodel("c_usa_unioninsp_salazar_cin_highlod_fb");
  precachemodel("p6_bar_solar_coaster_single");
  precachemodel("p6_bar_al_jinan_napkin_single");
  precacheshader("compass_static");
  precacheshellshock("concussion_grenade_mp");
  precachestring(&"eye_v5");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"retina_scanner");
  precachestring(&"begin_retina_scan");
  precachestring(&"hud_spiderbot_eyescan");
  precachestring(&"hud_spiderbot_eyescan_end");
  precachestring(&"hud_update_visor_text");
  precachestring(&"KARMA_ZAPPER_PROXIMITY_WARNING");
  precachestring(&"KARMA_TRESPASSER_DATA");
  precachestring(&"karma_pip_club");
  precachestring(&"KARMA_ACCESSING_SOURCE_DATA");
  precachestring(&"KARMA_MATCH_COMPLETE");
  precachestring(&"hud_shrink_ammo");
  precachestring(&"hud_expand_ammo");
  precachemodel("p6_spiderbot_case_anim");
  precachemodel("c_mul_jinan_guard_bscatter_fb");
  precachemodel("c_mul_jinan_demoworker_bscatter_fb");
  precachemodel("p6_anim_duffle_bag_karma");
  precachemodel("p6_anim_metal_briefcase");
  precachemodel("t6_wpn_pistol_fiveseven_world_detect");
  precachemodel("p6_3d_gizmo");
  precachemodel("t6_wpn_grenade_flash_prop_view");
  precachemodel("t6_wpn_knife_melee");
  precachemodel("hjk_vodka_glass_lrg");
  precachemodel("p6_wine_glass");
  precachemodel("p6_martini_glass");
  precachemodel("p6_bar_beer_glass");
  precachemodel("p6_bar_shaker_no_lid");
  precachemodel("p6_vodka_bottle");
  precachemodel("p_cub_ashtray_glass");
  precachemodel("c_usa_unioninsp_harper_cin_fb");
  precachemodel("c_usa_unioninsp_harper_scar_cin_fb");
  precacherumble("tank_rumble");
  precacherumble("damage_heavy");
  precacherumble("karma_landing");
  maps\karma_civilians::civ_precache();
}

init_flags() {
  flag_init("holster_weapons");
  flag_init("draw_weapons");
  flag_init("player_among_civilians");
  flag_init("player_act_normally");
  flag_init("trespasser_reward_enabled");
  maps\karma_arrival::init_flags();
  maps\karma_checkin::init_flags();
  maps\karma_dropdown::init_flags();
  maps\karma_spiderbot::init_flags();
  maps\karma_crc::init_flags();
  maps\karma_construction::init_flags();
  maps\karma_outer_solar::init_flags();
  maps\karma_inner_solar::init_flags();
}

init_spawn_funcs() {
  sp = getent("defalco", "targetname");
  sp add_spawn_function(::spawn_func_defalco);
  sp = getent("harper", "targetname");
  sp add_spawn_function(::spawn_func_harper);
  sp = getent("salazar", "targetname");
  sp add_spawn_function(::spawn_func_salazar);
  maps\karma_arrival::init_spawn_funcs();
  maps\karma_checkin::init_spawn_funcs();
  maps\karma_dropdown::init_spawn_funcs();
  maps\karma_spiderbot::init_spawn_funcs();
  maps\karma_crc::init_spawn_funcs();
  maps\karma_construction::init_spawn_funcs();
  maps\karma_outer_solar::init_spawn_funcs();
  maps\karma_inner_solar::init_spawn_funcs();
  add_global_spawn_function("axis", ::turn_on_enemy_highlight);
}

spawn_func_harper() {
  level.ai_harper = self;
  flag_wait("level.player");

  if(level.player get_story_stat("HARPER_SCARRED"))
    self setmodel("c_usa_unioninsp_harper_scar_cin_fb");
}

spawn_func_salazar() {
  level.ai_salazar = self;
}

spawn_func_defalco() {
  level.ai_defalco = self;
}

setup_skiptos() {
  add_skipto("arrival", maps\karma_arrival::skipto_arrival, "arrival", maps\karma_arrival::arrival);
  add_skipto("checkin", maps\karma_checkin::skipto_checkin, "checkin", maps\karma_checkin::checkin);
  add_skipto("dropdown", maps\karma_checkin::skipto_dropdown, "dropdown", maps\karma_checkin::tower_lift);
  add_skipto("dropdown2", maps\karma_dropdown::skipto_dropdown2, "dropdown2", maps\karma_dropdown::main);
  add_skipto("spiderbot", maps\karma_spiderbot::skipto_spiderbot, "spiderbot", maps\karma_spiderbot::vents);
  add_skipto("gulliver", maps\karma_spiderbot::skipto_gulliver, "gulliver", maps\karma_spiderbot::gulliver);
  add_skipto("crc", maps\karma_crc::skipto_crc, "crc", maps\karma_crc::main);
  add_skipto("construction", maps\karma_construction::skipto_construction, "construction", maps\karma_construction::main);
  add_skipto("club solar", maps\karma_outer_solar::skipto_club_solar, "club solar", maps\karma_outer_solar::main);
  add_skipto("inner solar", maps\karma_inner_solar::skipto_inner_solar, "inner solar", maps\karma_inner_solar::club_intro);
  add_skipto("solar fight", maps\karma_inner_solar::skipto_solar_fight, "solar fight", maps\karma_inner_solar::club_fight);
  add_skipto("club exit", ::skipto_karma_2);
  add_skipto("mall", ::skipto_karma_2);
  add_skipto("sundeck", ::skipto_karma_2);
  add_skipto("confrontation", ::skipto_karma_2);
  default_skipto("arrival");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_karma_2() {
  adddebugcommand("devmap karma_2");
}

load_gumps_karma() {
  if(is_after_skipto("construction"))
    load_gump("karma_gump_club");
  else if(is_after_skipto("dropdown"))
    load_gump("karma_gump_construction");
  else
    load_gump("karma_gump_checkin");
}

skipto_cleanup() {
  skipto = level.skipto_point;
  setsaveddvar("r_skyTransition", 0);
  load_gumps_karma();
  level.default_player_height = int(getdvar(#"player_standingViewHeight"));
  setsaveddvar("player_standingViewHeight", level.default_player_height + 6);
  level.player thread weapon_controller();
  level.player thread check_civ_status();
  flag_set("holster_weapons");
  flag_set("player_among_civilians");

  if(skipto == "arrival") {
    return;
  }
  flag_set("start_tarmac");
  flag_set("glasses_activated");
  flag_set("deplaned");

  if(skipto == "checkin") {
    return;
  }
  maps\_glasses::play_bootup();
  skip_objective(level.obj_security);
  t_obj = getent("trig_tower_lift", "targetname");
  set_objective(level.obj_find_crc, t_obj);

  if(skipto == "dropdown") {
    return;
  }
  flag_clear("player_among_civilians");

  if(skipto == "dropdown2") {
    return;
  }
  set_objective(level.obj_find_crc, undefined, "done");
  flag_set("spiderbot_bootup_done");

  if(skipto == "spiderbot") {
    return;
  }
  set_objective(level.obj_enter_crc);
  flag_clear("holster_weapons");

  if(skipto == "gulliver") {
    return;
  }
  flag_set("spiderbot_end");
  setsaveddvar("player_standingViewHeight", level.default_player_height);
  flag_set("spiderbot_transition_done");

  if(skipto == "crc") {
    return;
  }
  set_objective(level.obj_enter_crc, undefined, "done");
  flag_clear("holster_weapons");
  skip_objective(level.obj_id_karma);

  if(skipto == "construction") {
    return;
  }
  flag_set("holster_weapons");
  flag_set("player_among_civilians");

  if(skipto == "club solar") {
    return;
  }
  flag_set("club_door_closed");
  setsaveddvar("r_skyTransition", 1);

  if(skipto == "inner solar") {
    return;
  }
  flag_set("salazar_start_overwatch");
  flag_set("stop_club_fx");
  flag_set("run_to_bar");
}

check_civ_status() {
  wait 0.05;

  while(true) {
    flag_wait("player_among_civilians");
    flag_clear("player_act_normally");
    level.player allowjump(0);
    level.player allowsprint(0);
    level.player allowprone(0);
    flag_wait("player_act_normally");
    flag_clear("player_among_civilians");
    level.player allowjump(1);
    level.player allowsprint(1);
    level.player allowprone(1);
  }
}

weapon_controller() {
  wait 0.05;

  while(true) {
    flag_wait("holster_weapons");
    flag_clear("draw_weapons");
    self disableweapons();
    wait 2.0;
    self thread take_and_giveback_weapons("draw_weapons");
    self giveweapon("noweapon_sp");
    self switchtoweapon("noweapon_sp");
    self hideviewmodel();
    self allowads(0);
    setsaveddvar("cg_drawCrosshair", 0);
    luinotifyevent(&"hud_shrink_ammo");
    flag_wait("draw_weapons");
    flag_clear("holster_weapons");
    self takeweapon("noweapon_sp");
    self notify("draw_weapons");
    self showviewmodel();
    self allowads(1);
    setsaveddvar("cg_drawCrosshair", 1);
    luinotifyevent(&"hud_expand_ammo");
    self enableweapons();
  }
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("specialvisionkills", ::special_vision_kills_challenge);
  self thread maps\_challenges_sp::register_challenge("hurtciv", ::no_killing_civ);
  self thread maps\_challenges_sp::register_challenge("retrievespiderbot", ::retrieve_bot_challenge);
  self thread maps\_challenges_sp::register_challenge("fastspiderbotcomplete", ::fast_complete_spider_bot);
  self thread maps\_challenges_sp::register_challenge("clubspeedkill", ::club_speed_kill_challenge);
}

add_argus_info() {
  player = getplayers()[0];
}