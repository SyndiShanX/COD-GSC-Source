/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\pakistan_util;
#include maps\_vehicle;
#include maps\_glasses;
#include maps\_music;
#include maps\_dialog;
#include maps\pakistan_2_fx;
#include maps\pakistan_2_anim;
#include maps\_claw;
#include maps\_truck_gaztigr;
#include maps\_load;
#include maps\_patrol;
#include maps\pakistan_2_amb;
#include maps\createart\pakistan_2_art;
#include maps\_swimming;
#include maps\pakistan_anthem;
#include maps\pakistan_roof_meeting;
#include maps\pakistan_claw;
#include maps\_challenges_sp;

main() {
  maps\pakistan_2_fx::main();
  init_flags();
  maps\pakistan_2_anim::main();
  visionsetnaked("default");
  level_precache();
  setup_objectives();
  setup_skiptos();
  setup_level();
  level.supportsfutureflamedeaths = 1;
  level.actor_charring_client_flag = 15;
  maps\_claw::init();
  maps\_truck_gaztigr::init();
  level._vehicle_load_lights = 1;
  maps\_load::main();
  maps\_patrol::patrol_init();
  maps\pakistan_2_amb::main();
  level thread maps\createart\pakistan_2_art::main();
  setsaveddvar("phys_buoyancy", 1);
  maps\_swimming::main();
  level thread objectives();
  level thread watch_player_rain_water_sheeting();
  onplayerconnect_callback(::on_player_connect);
  level.callbackactorkilled = ::callback_actorkilled_burn_death;
  onsaverestored_callback(::on_saved_restored_surveillance);
  add_spawn_function_veh("isi_vtol", maps\pakistan_anthem::vtol_spawn_func);
  trainyard_light_off();
}

callback_actorkilled_burn_death(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker)) {
    if(isplayer(eattacker)) {
      if(smeansofdeath == "MOD_BURNED") {
        level.n_claw_fire_kills++;

        if(level.n_claw_fire_kills == 1)
          level.harper queue_dialog("harp_yeah_2", 1);

        iprintln("flame_death");
        iprintln(level.n_claw_fire_kills);

      }
    }
  }
}

on_saved_restored_surveillance() {
  if((flag("roof_meeting_defalco_identified") || flag("anthem_facial_recognition_complete")) && !flag("salazar_vo_claw_positioned")) {
    wait 2;
    luinotifyevent(&"hud_pak_surveillance");
    recorded_data = 0;

    if(isDefined(level.recorded_data)) {
      recorded_data = level.recorded_data;

      if(isDefined(level.menendez)) {
        luinotifyevent(&"hud_pak_add_poi", 4, level.menendez getentitynumber(), 1, 1, recorded_data);

        if(flag("xcam_off"))
          luinotifyevent(&"hud_pak_rec_visibility", 2, 0, 0);
        else
          luinotifyevent(&"hud_pak_rec_visibility", 1, 1);
      }
    }
  }

  rpc("clientscripts/pakistan_2", "SetGrappelTarget", 0);

  if(flag("trainyard_harper_millibar_grenades_started") && !flag("trainyard_harper_millibar_grenades_done")) {
    wait_network_frame();
    level.player player_disable_weapons();
  }
}

level_precache() {
  precacheitem("usrpg_player_sp");
  precacheitem("data_glove_sp");
  precacheitem("data_glove_surv_sp");
  precacheitem("data_glove_claw_sp");
  precacheitem("usrpg_magic_bullet_sp");
  precacheitem("grenade_grapple_pakistan_sp");
  precachemodel("t6_wpn_knife_melee");
  precachemodel("t6_wpn_grappel_hook_projectile");
  precachemodel("veh_t6_mil_soc_t_steeringwheel");
  precachemodel("t6_wpn_knife_base_prop");
  precacheitem("vector_sp");
  precacheshader("compass_static");
  precacheshader("photo_menendez");
  precacheshader("hud_pak_drone");
  precacheshellshock("default ");
  precacherumble("explosion_generic");
  precacherumble("rappel_falling");
  precachestring(&"hud_pak_surveillance");
  precachestring(&"hud_pak_add_poi");
  precachestring(&"hud_pak_stop_scan");
  precachestring(&"hud_pak_start_scan");
  precachestring(&"hud_pak_scan_complete");
  precachestring(&"hud_pak_update_recording");
  precachestring(&"hud_pak_end_surveillance");
  precachestring(&"hud_pak_rec_visibility");
  precachestring(&"hud_pak_poi_visibility");
  precachestring(&"hud_pak_toggle_zoom");
  precachestring(&"hud_pak_interference");
  precachestring(&"hud_pak_claw_controller");
  precachestring(&"hud_pak_claw_controller_close");
  precachestring(&"hud_pak_highlight_claw");
  precachestring(&"hud_pak_remove_claw_controller");
  precachestring(&"hud_claw_grenade_fire");
  precachestring(&"claw_offline_temp");
  precachestring(&"yemen_kill_pilot");
  precachestring(&"hud_update_visor_text");
  precachestring(&"PAKISTAN_SHARED_GRAPPLE_INIT");
  precachestring(&"PAKISTAN_SHARED_GRAPPLE_SEARCH_ACTIVATED");
  precachestring(&"PAKISTAN_SHARED_GRAPPLE_STANDBY");
  precachestring(&"PAKISTAN_SHARED_GRAPPLE_SCAN");
  precachestring(&"PAKISTAN_SHARED_GRAPPLE_LOCATED");
  precachestring(&"PAKISTAN_SHARED_MILLIBAR_ZOOM_2X");
  precachestring(&"PAKISTAN_SHARED_MILLIBAR_ZOOM_6X");
  precachestring(&"PAKISTAN_SHARED_SURVEILLANCE_INITIALIZE");
  precachestring(&"PAKISTAN_SHARED_SURVEILLANCE_ACTIVE");
  precachestring(&"PAKISTAN_SHARED_SURVEILLANCE_DEACTIVATE");
  precachestring(&"pakistan2_rooftop_claw");
  precachestring(&"pakistan2_trainyard_claw");
  precachestring(&"pakistan2_salazar_pip");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachemodel("c_usa_cia_claw_viewbody_vson");
  precachemodel("p_anim_pent_av_tv_cart");
  precachemodel("p_anim_rus_industrial_cart");
  precachemodel("p6_anim_cell_phone");
  precachemodel("veh_iw_gaz_tigr_int_rear");
}

setup_skiptos() {
  add_skipto("intro", ::skipto_pakistan);
  add_skipto("market", ::skipto_pakistan);
  add_skipto("dev_market_perk", ::skipto_pakistan);
  add_skipto("dev_market_no_perk", ::skipto_pakistan);
  add_skipto("car_smash", ::skipto_pakistan);
  add_skipto("market_exit", ::skipto_pakistan);
  add_skipto("dev_market_exit_perk", ::skipto_pakistan);
  add_skipto("dev_market_exit_no_perk", ::skipto_pakistan);
  add_skipto("frogger", ::skipto_pakistan);
  add_skipto("bus_street", ::skipto_pakistan);
  add_skipto("bus_dam", ::skipto_pakistan);
  add_skipto("alley", ::skipto_pakistan);
  add_skipto("anthem_approach", ::skipto_pakistan);
  add_skipto("sewer_exterior", ::skipto_pakistan);
  add_skipto("sewer_interior", ::skipto_pakistan);
  add_skipto("dev_sewer_interior_perk", ::skipto_pakistan);
  add_skipto("dev_sewer_interior_no_perk", ::skipto_pakistan);
  add_skipto("anthem", maps\pakistan_anthem::skipto_anthem, undefined, maps\pakistan_anthem::main);
  add_skipto("roof_meeting", maps\pakistan_roof_meeting::skipto_roof_meeting, undefined, maps\pakistan_roof_meeting::main);
  add_skipto("gaz_melee", maps\pakistan_roof_meeting::skipto_gaz_melee, undefined, maps\pakistan_roof_meeting::gaz_melee_main);
  add_skipto("underground", maps\pakistan_roof_meeting::skipto_underground, undefined, maps\pakistan_roof_meeting::underground_main);
  add_skipto("claw", maps\pakistan_claw::skipto_claw, undefined, maps\pakistan_claw::main);
  add_skipto("claw_no_flamethrower", maps\pakistan_claw::skipto_claw_no_flamethrower, undefined, maps\pakistan_claw::main);
  add_skipto("dev_s2_ending", maps\pakistan_claw::dev_skipto_ending, undefined, maps\pakistan_claw::dev_ending);
  add_skipto("escape_intro", ::skipto_pakistan_3);
  add_skipto("escape_battle", ::skipto_pakistan_3);
  add_skipto("escape_bosses", ::skipto_pakistan_3);
  add_skipto("warehouse", ::skipto_pakistan_3);
  add_skipto("hangar", ::skipto_pakistan_3);
  add_skipto("standoff", ::skipto_pakistan_3);
  add_skipto("dev_s3_script", ::skipto_pakistan_3);
  add_skipto("dev_s3_build", ::skipto_pakistan_3);
  default_skipto("anthem");
  set_skipto_cleanup_func(::skipto_cleanup);
}

skipto_pakistan() {
  changelevel("pakistan", 1);
}

skipto_pakistan_3() {
  changelevel("pakistan_3", 1);
}

on_player_connect() {
  level.player = get_players()[0];
  level.player disableweapons();
  level.stat_vo_check_1 = 0;
  level.stat_vo_check_2a = 0;
  level.stat_vo_check_2b = 0;
  level.stat_vo_check_3 = 0;
  level.info_recorded = 0;
  level.b_under_tarp = 0;
  level.b_flamethrower_unlocked = is_claw_flamethrower_unlocked();
  setup_challenges();
  setsaveddvar("aim_target_fixed_actor_size", 1);
}

setup_challenges() {
  level.n_claw_fire_kills = 0;
  level.recorded_data = 0;
  self thread maps\_challenges_sp::register_challenge("download", ::challenge_download);
  self thread maps\_challenges_sp::register_challenge("clawsalive", ::challenge_claws_alive);
  self thread maps\_challenges_sp::register_challenge("burnwithclaw", ::challenge_claw_burn);
}

challenge_download(str_notify) {
  flag_wait("salazar_vo_claw_positioned");

  if(level.recorded_data >= 400) {
    wait 1;
    self notify(str_notify);
  }
}

challenge_claws_alive(str_notify) {
  level waittill("claws_survived");
  flag_wait("pakistan_is_raining");
  wait 5;
  self notify(str_notify);
}

challenge_claw_burn(str_notify) {
  level endon("courtyard_event_done");

  while(true) {
    if(level.n_claw_fire_kills >= 10) {
      self notify(str_notify);
      break;
    }

    wait 0.05;
  }
}

setup_level() {
  t_dmg = getent("trigger_dmg_start", "targetname");
  t_dmg trigger_off();
  add_spawn_function_ai_group("courtyard_guards", maps\pakistan_anthem::courtyard_logic);
  m_exit_door = getent("exit_door", "targetname");
  m_exit_door hide();
  m_exit_door trigger_off();
  m_exit_clip = getent("door_closed_clip", "targetname");
  m_exit_clip trigger_off();
}