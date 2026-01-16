/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\so_rts_mp_socotra_s1.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_audio;
#include maps\_music;
#include maps\_anim;
#include maps\_statemachine;
#include maps\_quadrotor;
#include maps\_so_rts_support;
#include maps\_so_rts_rules;
#include maps\_so_rts_catalog;
#include maps\_so_rts_enemy;
#include maps\_so_rts_event;
#include maps\_so_rts_squad;
#include maps\createart\so_rts_mp_socotra_art;
#include maps\_objectives;
#include maps\_so_rts_ai;
#include maps\_so_rts_poi;
#include maps\_vehicle_aianim;
#include maps\_turret;
#include maps\_osprey;
#include maps\_utility_code;
#include maps\_so_rts_main;
#include maps\_so_rts_challenges;
#include maps\_challenges_sp;

precache() {
  precachestring(&"rts_karma_squad");
  precachestring(&"SO_RTS_OBJ3D_RESCUE");
  precachestring(&"SO_RTS_MP_SOCOTRA_HVT_RESCUE");
  precachestring(&"SO_RTS_MP_SOCOTRA_KARMA_HINT");
  precacheshader("hud_compass_vtol");
  precacheitem("m1911_sp");
  precacheitem("stinger_rts_sp");
  precacheitem("knife_karma_sp");
  precachemodel("p6_anim_karma_rope");
  precachemodel("veh_t6_air_v78_vtol_killstreak");
  level._effect["sniper_glint"] = loadfx("misc/fx_misc_sniper_scope_glint");
  level._effect["signal_smoke"] = loadfx("smoke/fx_pak_smk_signal_dist");
  level._effect["nanoglove_impact"] = loadfx("dirt/fx_mon_dust_nano_glove");
  level._effect["gas_canister_trail"] = loadfx("trail/fx_war_trail_gas_canister");
  level._effect["fx_vtol_explo"] = loadfx("explosions/fx_exp_bomb_huge");
  level._effect["fx_vtol_smoke"] = loadfx("explosions/fx_exp_bomb_huge");
  level._effect["fx_dead_mortar"] = loadfx("explosions/fx_mortarexp_sand");
  level._effect["fx_mortar_explode"] = loadfx("explosions/fx_mortarexp_sand");
  level._effect["fx_mortar_launch"] = loadfx("weapon/mortar/fx_mortar_rts_launch");
  level._effect["outro_fail_sniper_hit"] = loadfx("blood/fx_rts_socotra_blood_fail");
  precacherumble("monsoon_gloves_impact");
  precachemodel("c_usa_seal6_monsoon_armlaunch_viewbody_on");
  precachemodel("projectile_hellfire_missile");
  precachemodel("p6_sf_socotra_bldg_08");
  precachemodel("p6_sf_socotra_bldg_10");
  precachemodel("p6_sf_socotra_bldg_11");
  precachemodel("p6_sf_socotra_bldg_13");
  precachemodel("p6_sf_socotra_bldg_15");
  precachemodel("p6_socotra_evac_objective");
  precachemodel("c_usa_chloe_lynch_viewhands");
  precachemodel("t6_wpn_mortar");
  precachemodel("t6_wpn_tablet_prop_world");
  precachemodel("weapon_us_smoke_grenade_burnt");
  precachemodel("p6_anim_small_merchant_chair");
  precachemodel("t6_wpn_knife_base_prop");
  setsaveddvar("cg_viewVehicleInfluenceGunner", (0, 0, 0));
  setsaveddvar("vehicle_selfCollision", "0");
  maps\_quadrotor::init();
}

socotra_level_scenario_one() {
  level.custom_introscreen = maps\_so_rts_support::custom_introscreen;
  flag_init("intro_done");
  flag_init("karma_died");
  flag_init("karma_at_outro");
  flag_init("vtol_start_anim");
  flag_init("vtol_at_outro");
  flag_init("vtol_is_ready_for_player");
  flag_init("found_hvt");
  flag_set("block_input");
  maps\_so_rts_rules::set_gamemode("socotra1");
  setup_scenes();
  setsaveddvar("sm_sunshadowsmall", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  socotra_geo_changes();
  flag_wait("all_players_connected");
  maps\_so_rts_support::hide_player_hud();
  flag_wait("start_rts");
  socotra_level_scenario_one_registerevents();

  socotra_setup_devgui();

  maps\_so_rts_catalog::spawn_package("infantry_ally_reg_pkg", "allies", 1, ::socotra_level_player_startfps);
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", 0);
  maps\_so_rts_catalog::setpkgdelivery("infantry_ally_reg_pkg", "CODE");
  maps\_so_rts_catalog::setpkgdelivery("infantry_enemy_elite_pkg", "CODE");
  maps\_so_rts_catalog::setpkgdelivery("infantry_enemy_reg_pkg", "CODE");
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", 0);

  switch (getdifficulty()) {
    case "easy":
    case "medium":
      maps\_so_rts_catalog::setpkgqty("quadrotor_pkg", "axis", 6);
      maps\_so_rts_catalog::setpkgqty("infantry_enemy_rpg_pkg", "axis", 2);
      break;
    case "hard":
      maps\_so_rts_catalog::setpkgqty("infantry_enemy_rpg_pkg", "axis", 2);
      maps\_so_rts_catalog::setpkgqty("quadrotor_pkg", "axis", 10);
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("quadrotor_pkg");
      pkg_ref.min_axis = 3;
      pkg_ref.max_axis = 8;
      break;
    case "fu":
      maps\_so_rts_catalog::setpkgqty("infantry_enemy_rpg_pkg", "axis", 12);
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_rpg_pkg");
      pkg_ref.min_axis = 2;
      pkg_ref.max_axis = 2;
      maps\_so_rts_catalog::setpkgqty("quadrotor_pkg", "axis", -1);
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("quadrotor_pkg");
      pkg_ref.min_axis = 3;
      pkg_ref.max_axis = 8;
      break;
  }

  level.rts.codespawncb = ::socotracodespawner;
  level.rts.customvoxlist = ::socotravoxlist;
  level.rts.customvoxallocid = ::socotravoxalloc;
  level.rts.player_nextavailunitcb = ::socotra_nextavailunit;
  level.rts.game_rules.num_nag_squads = 5;
  level.rts.player thread setup_challenges();
  level thread socotraairsuperiorityspawn();
  level thread setup_objectives();
  level thread socotra_pick_safehouses();
  level thread enemyspawninit();
  flag_wait("intro_done");
  setsaveddvar("sm_sunshadowsmall", 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  flag_set("rts_start_clock");
  level thread socotra_clockwatch();
  level thread maps\_so_rts_support::flag_set_innseconds("start_rts_enemy", 12);
  level.rts.outroloc = getstruct("outro_loc", "targetname");
  level thread socotra_ai_takeover_on();
  level thread socotra_ai_takeover_off();
  level thread socotra_player_oobwatch();
  level thread maps\_so_rts_support::player_oobwatch();
  level thread socotra_karama_spawnwatch();
  level thread socotrasafehousehighlightwatch();
  level thread socotra_floorwatch();
  flag_wait("vtol_is_ready_for_player");
  wait 4;
  maps\_so_rts_catalog::setpkgdelivery("infantry_ally_reg2_pkg", "CODE");
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", -1);
  level waittill("socotra_karma_rescued");
  level thread socotra_orangeobjectivewatch();
  level thread maps\_so_rts_support::show_player_hud();
  level thread maps\_so_rts_enemy::create_units_from_allsquads();
}

socotra_clockwatch() {
  if(level.rts.game_rules.time > 2) {
    wait((level.rts.game_rules.time - 2) * 60);
    maps\_so_rts_event::trigger_event("dlg_time_low");
  }

  wait 60;
  maps\_so_rts_event::trigger_event("dlg_raptor_dam_nag");
  wait 48;
  maps\_so_rts_event::trigger_event("dlg_raptor_10sec");
}

socotra_orangeobjectivewatch() {
  level endon("socotra_mission_complete");
  spot = getstruct("outro_obj", "targetname");

  if(!isDefined(spot)) {
    return;
  }
  level.orange_outro_obj = spawn("script_model", spot.origin);
  level.orange_outro_obj.angles = isDefined(spot.angles) ? spot.angles : (0, 0, 0);
  level.orange_outro_obj setmodel("p6_socotra_evac_objective");
  level.orange_outro_obj ignorecheapentityflag(1);
  level.orange_outro_obj maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 0);

  if(flag("rts_mode"))
    level.orange_outro_obj show();
  else
    level.orange_outro_obj hide();

  while(true) {
    level waittill("rts_ON");
    level.orange_outro_obj show();
    level waittill("rts_OFF");
    level.orange_outro_obj hide();
  }
}

socotra_floorwatch() {
  level.rts_floors = getentarray("overwatch_floor", "targetname");
  level.rts.trace_ents = level.rts_floors;

  while(true) {
    foreach(floor in level.rts_floors)
    floor hide();

    level waittill("rts_ON");

    foreach(floor in level.rts_floors)
    floor show();

    level waittill("rts_OFF");
  }
}

socotrasafehousehighlightwatch() {
  level endon("socotra_karma_rescued");

  while(true) {
    level waittill("rts_ON");

    if(level.rts.safehouses.size == 1) {
      spot = level.rts.safehouses[0];
      spot.bldg = spawn("script_model", spot.site.origin);
      spot.bldg.angles = isDefined(spot.site.angles) ? spot.site.angles : (0, 0, 0);
      spot.bldg setmodel(spot.modelname);
      spot.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 1);
      spot.bldg ignorecheapentityflag(1);
    } else if(isDefined(level.rts.karma_poi) && (isDefined(level.rts.karma_poi.discovered) && level.rts.karma_poi.discovered)) {
      level.rts.karma_poi.bldg = spawn("script_model", level.rts.karma_poi.site.origin);
      level.rts.karma_poi.bldg.angles = isDefined(level.rts.karma_poi.site.angles) ? level.rts.karma_poi.site.angles : (0, 0, 0);
      level.rts.karma_poi.bldg setmodel(level.rts.karma_poi.modelname);
      level.rts.karma_poi.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 1);
      level.rts.karma_poi.bldg ignorecheapentityflag(1);
    } else {
      foreach(spot in level.rts.safehouses) {
        spot.bldg = spawn("script_model", spot.site.origin);
        spot.bldg.angles = isDefined(spot.site.angles) ? spot.site.angles : (0, 0, 0);
        spot.bldg setmodel(spot.modelname);
        spot.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 0);
        spot.bldg ignorecheapentityflag(1);
      }
    }

    level waittill("rts_OFF");

    foreach(spot in level.rts.safehouses) {
      if(isDefined(spot.bldg))
        spot.bldg delete();
    }

    if(isDefined(level.rts.karma_poi) && isDefined(level.rts.karma_poi.bldg)) {
      level.rts.karma_poi.bldg delete();
      level.rts.karma_poi.bldg = undefined;
    }
  }
}

socotra_player_oobwatch() {
  level endon("karma_outro_begin");
  level endon("socotra_mission_complete");
  kill_trigs = getentarray("kill_me", "targetname");

  while(true) {
    foreach(trig in kill_trigs) {
      if(level.rts.player istouching(trig))
        level.rts.player dodamage(level.rts.player.health + 9999, level.rts.player.origin, level.rts.player, 1, "suicide");
    }

    wait 0.15;
  }
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

setup_scenes() {
  male_spawner = getent("male_civ_spawner", "targetname");
  male_spawner.nofakeai = 1;
  female_spawner = getent("female_civ_spawner", "targetname");
  female_spawner.nofakeai = 1;
  level.player_interactive_model = "c_usa_seal6_monsoon_armlaunch_viewbody_on";
  add_scene("intro_climbup_player", "intro_loc");
  add_player_anim("player_body", % p_sacotra_intro_player, 1, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "start_fade_in", ::level_fade_in);
  add_notetrack_custom_function("player_body", "start_civs_choking", ::intro_start_civ_anims);
  add_notetrack_custom_function("player_body", "left_hand_plant", ::nanoglove_left_hand_plant);
  add_notetrack_custom_function("player_body", "right_hand_plant", ::nanoglove_right_hand_plant);
  add_notetrack_custom_function("player_body", "left_hand_plant_off", ::nano_glove_left_off);
  add_notetrack_custom_function("player_body", "right_hand_plant_off", ::nano_glove_right_off);
  add_notetrack_custom_function("player_body", "sndExplo1", ::intro_explosion_1);
  add_notetrack_custom_function("player_body", "sndExplo2", ::intro_explosion_2);
  add_notetrack_custom_function("player_body", "sndExplo3", ::intro_explosion_3);
  add_scene("intro_climbup_squad_1", "intro_loc");
  add_actor_anim("guy0", % ch_sacotra_intro_sqd1, 0, 0, 0, 1);
  add_scene("intro_climbup_squad_2", "intro_loc");
  add_actor_anim("guy1", % ch_sacotra_intro_sqd2, 0, 0, 0, 1);
  add_scene("intro_climbup_civs", "intro_loc");
  add_actor_model_anim("intro_climbup_civ1", % ch_sacotra_intro_chk_civ1, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ2", % ch_sacotra_intro_chk_civ2, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ3", % ch_sacotra_intro_chk_civ3, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ4", % ch_sacotra_intro_chk_civ4, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ5", % ch_sacotra_intro_chk_civ5, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ6", % ch_sacotra_intro_chk_civ6, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_actor_model_anim("intro_climbup_civ7", % ch_sacotra_intro_chk_civ7, undefined, 0, undefined, undefined, "male_civ_spawner", 0);
  add_scene("intro_zodiac_seals", "intro_loc");
  add_actor_model_anim("intro_zodiac_seal1", % ch_sacotra_intro_seal1, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal2", % ch_sacotra_intro_seal2, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal3", % ch_sacotra_intro_seal3, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal4", % ch_sacotra_intro_seal4, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal5", % ch_sacotra_intro_seal5, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal6", % ch_sacotra_intro_seal6, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal7", % ch_sacotra_intro_seal7, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal8", % ch_sacotra_intro_seal8, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal9", % ch_sacotra_intro_seal9, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal10", % ch_sacotra_intro_seal10, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_actor_model_anim("intro_zodiac_seal11", % ch_sacotra_intro_seal11, undefined, 1, undefined, undefined, "ai_spawner_ally_assault");
  add_scene("intro_canisters", "intro_loc");
  add_prop_anim("bomb1", % w_sacotra_intro_bomb1);
  add_prop_anim("bomb2", % w_sacotra_intro_bomb2);
  add_prop_anim("bomb3", % w_sacotra_intro_bomb3);
  add_notetrack_custom_function("bomb1", "fog_town", ::intro_fog_town);
  add_notetrack_custom_function("bomb1", "bomb_launch1", ::gas_canister_attach_trail);
  add_notetrack_custom_function("bomb1", "bomb_launch2", ::gas_canister_attach_trail);
  add_notetrack_custom_function("bomb1", "bomb_launch3", ::gas_canister_attach_trail);
  add_scene("intro_zodiacs", "intro_loc");
  add_prop_anim("zodiac1", % v_sacotra_intro_zodiac, "veh_iw_zodiac");
  add_prop_anim("zodiac2", % v_sacotra_intro_zodiac1, "veh_iw_zodiac");
  add_prop_anim("zodiac3", % v_sacotra_intro_zodiac2, "veh_iw_zodiac");
  add_prop_anim("zodiac4", % v_sacotra_intro_zodiac4, "veh_iw_zodiac");
  add_prop_anim("zodiac5", % v_sacotra_intro_zodiac5, "veh_iw_zodiac");
  add_prop_anim("zodiac6", % v_sacotra_intro_zodiac6, "veh_iw_zodiac");
  add_scene("outro_fail", "intro_loc");
  add_player_anim("player_body", % p_sacotra_fail_player, 1, 0, undefined, 0, 1, 15, 15, 15, 15);
  add_notetrack_flag("player_body", "fade_out", "socotra_fail_fadeout");
  add_actor_anim("outro_fail_guy0", % ch_sacotra_fail_sqd1, 0, 0, 0, 1);
  add_actor_anim("outro_fail_sniper", % ch_sacotra_fail_sniper, 0, 0, 0, 1);
  add_notetrack_fx_on_tag("outro_fail_sniper", "hit", "outro_fail_sniper_hit", "J_SpineUpper");
  add_vehicle_anim("outro_fail_heli1", % v_sacotra_fail_enemy_vtol, 0, undefined, undefined, 1, "heli_v78_rts", "veh_t6_air_v78_vtol_killstreak");
  add_vehicle_anim("outro_fail_heli2", % v_sacotra_fail_vtol, 0, undefined, undefined, 1, "heli_osprey_rts");
  add_scene("outro_success_player", "intro_loc");
  add_player_anim("player_body", % p_sacotra_outro_player, 1, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "start_static", ::static_transition);
  add_notetrack_flag("player_body", "fade_out", "socotra_success_fadeout");
  add_scene("outro_success_actors", "intro_loc");
  add_actor_model_anim("karma", % ch_sacotra_outro_karma, undefined, 1, undefined, undefined, "ai_spawner_karma");
  add_actor_anim("sniper_guy", % ch_sacotra_outro_sniper, 0, 0, 0, 1);
  add_actor_anim("outro_guy0", % ch_sacotra_outro_sqd1, 0, 0, 0, 1);
  add_actor_anim("outro_guy1", % ch_sacotra_outro_sqd2, 0, 0, 0, 1);
  add_vehicle_anim("outro_heli", % v_sacotra_outro_vtol_flyin_outro, 0, undefined, undefined, 1);
  add_scene("karma_rescue_karma_idle", "karma_loc", 0, 0, 1);
  add_actor_anim("karma", % ch_sacotra_karma_rescue_karma_idle, 0, 1, 0, 1);
  add_prop_anim("karma_chair", % o_sacotra_karma_rescue_chair, "p6_anim_small_merchant_chair", 0);
  add_prop_anim("karma_rope", % o_sacotra_karma_rescue_rope_idle, "p6_anim_karma_rope", 0);
  add_scene("karma_rescue_player", "karma_loc");
  add_player_anim("player_body", % p_sacotra_karma_rescue_player, 1, 0, undefined, 1, 1, 15, 15, 15, 15);
  add_scene("karma_rescue_karma", "karma_loc");
  add_actor_anim("karma", % ch_sacotra_karma_rescue_karma, 0, 1, 0, 1);
  add_prop_anim("karma_rope", % o_sacotra_karma_rescue_rope, "p6_anim_karma_rope", 0);
  add_prop_anim("karma_chair", % o_sacotra_karma_rescue_chair, "p6_anim_small_merchant_chair", 0);
  add_prop_anim("karma_knife", % w_sacotra_karma_rescue_knife, "t6_wpn_knife_base_prop", 1);
  add_scene("infantry_reg_pkg_intro_0", "intro_loc");
  add_actor_anim("ally_intro_0", % ch_sacotra_intro_cavalry1);
  add_scene("infantry_reg_pkg_intro_1", "intro_loc");
  add_actor_anim("ally_intro_1", % ch_sacotra_intro_cavalry2);
  add_scene("infantry_reg_pkg_intro_2", "intro_loc");
  add_actor_anim("ally_intro_2", % ch_sacotra_intro_cavalry3);
  add_scene("infantry_ally_reg2_pkg_0", "rts_support_loc");
  add_actor_anim("ally_heavy_intro_0", % ch_sacotra_intro_cavalry1);
  add_scene("infantry_ally_reg2_pkg_1", "rts_support_loc");
  add_actor_anim("ally_heavy_intro_1", % ch_sacotra_intro_cavalry2);
  add_scene("infantry_ally_reg2_pkg_2", "rts_support_loc");
  add_actor_anim("ally_heavy_intro_2", % ch_sacotra_intro_cavalry3);
  add_scene("karma_bodyguard_1", "rts_support_loc");
  add_actor_anim("karma_bodyguard_1", % ch_sacotra_intro_cavalry2);
  add_scene("karma_bodyguard_2", "rts_support_loc");
  add_actor_anim("karma_bodyguard_2", % ch_sacotra_intro_cavalry3);
  precache_assets();
}

level_fade_in(player) {
  wait 1;
  screen_fade_in(0.5);
}

intro_explosion_1(player) {
  playsoundatposition("evt_missile_explosion", (2370, 567, 273));
  level.player playrumbleonentity("grenade_rumble");
}

intro_explosion_2(player) {
  playsoundatposition("evt_missile_explosion", (339, -155, 416));
  level.player playrumbleonentity("grenade_rumble");
}

intro_explosion_3(player) {
  playsoundatposition("evt_missile_explosion", (-1099, -2102, 224));
  level.player playrumbleonentity("grenade_rumble");
}

nanoglove_left_hand_plant(player) {
  level.player playrumbleonentity("monsoon_gloves_impact");
  player play_fx("nanoglove_impact", player.origin, player.angles, 1, 1, "j_index_le_1");
  player ignorecheapentityflag(1);
  player setclientflag(2);
}

nanoglove_right_hand_plant(player) {
  level.player playrumbleonentity("monsoon_gloves_impact");
  player play_fx("nanoglove_impact", player.origin, player.angles, 1, 1, "j_index_ri_1");
  player ignorecheapentityflag(1);
  player setclientflag(1);
}

nano_glove_left_off(m_player_body) {
  m_player_body ignorecheapentityflag(1);
  m_player_body clearclientflag(2);
}

nano_glove_right_off(m_player_body) {
  m_player_body ignorecheapentityflag(1);
  m_player_body clearclientflag(1);
}

intro_fog_town(bomb) {
  exploder(44);
  delay_thread(30, ::stop_exploder, 44);
}

gas_canister_attach_trail(bomb) {
  canister = level.rts.canisters[level.rts.canisterindex];
  canister setforcenocull();
  playfxontag(level._effect["gas_canister_trail"], canister, "tag_fx");
  level.rts.canisterindex++;
}

socotra_climbup_intro() {
  maps\_so_rts_squad::removedeadfromsquad(0);
  assert(level.rts.squads[0].members.size >= 2, "Not enough guys around");

  for(i = 0; i < level.rts.squads[0].members.size; i++) {
    guy = level.rts.squads[0].members[i];
    guy.animname = "guy" + i;
    guy.rts_unloaded = 0;
    guy.ignoreme = 1;
    covernodename = guy.animname;
    covernode = getnode(covernodename, "targetname");

    if(isDefined(covernode)) {
      guy.fixednode = 1;
      guy notify("new_squad_orders");
      guy.selectable = 0;
      guy setgoalnode(covernode);
    }
  }

  level.rts.player.ignoreme = 1;
  level.rts.player.takedamage = 0;
  level.rts.player enableinvulnerability();
  level.rts.canisterindex = 0;
  level.rts.canisters = [];

  for(i = 0; i < 3; i++) {
    c = spawn("script_model", (0, 0, 0));
    c setmodel("projectile_hellfire_missile");
    c.animname = "bomb" + (i + 1);
    level.rts.canisters[i] = c;
  }

  rpc("clientscripts/so_rts_mp_socotra", "hide_rock_model", 2358.58, 652.29, 64.6);
  flag_set("rts_event_ready");
  maps\_so_rts_event::trigger_event("main_music_state");
  maps\_so_rts_event::trigger_event("dlg_intro_potus");
  level thread maps\createart\so_rts_mp_socotra_art::intro_igc();
  level thread run_scene("intro_climbup_player");
  level thread run_scene("intro_climbup_squad_1");
  level thread run_scene("intro_climbup_squad_2");
  level thread run_scene("intro_canisters");
  level thread run_scene("intro_zodiacs");
  level thread run_scene("intro_zodiac_seals");
  level thread intro_delete_canisters(level.rts.canisters);
  scene_wait("intro_climbup_player");
  level clientnotify("intro_rock_show");
  level.rts.player.ignoreme = 0;
  level.rts.player.takedamage = 1;
  level.rts.player disableinvulnerability();

  for(i = 0; i < level.rts.squads[0].members.size; i++) {
    if(level.rts.squads[0].members[i].animname == "guy1") {
      level.rts.squads[0].members[i].a.pose = "stand";
      level.rts.squads[0].members[i].a.movement = "stop";
    } else if(level.rts.squads[0].members[i].animname == "guy0") {
      level.rts.squads[0].members[i].a.pose = "crouch";
      level.rts.squads[0].members[i].a.movement = "stop";
    }

    level.rts.squads[0].members[i].animname = undefined;
    level.rts.squads[0].members[i].rts_unloaded = 1;
    level.rts.squads[0].members[i].ignoreme = 0;
  }

  wait 2;
  thread resume_normal_ai(level.rts.squads[0].members);
}

intro_start_civ_anims(player) {
  level thread run_scene("intro_climbup_civs");
}

intro_delete_canisters(canisters) {
  scene_wait("intro_canisters");

  foreach(c in canisters)
  c delete();
}

resume_normal_ai(introsquad) {
  wait 5;

  foreach(guy in introsquad) {
    if(isalive(guy) && guy.fixednode) {
      guy.fixednode = 0;
      guy thread maps\_so_rts_squad::movewithplayer();
    }
  }
}

setup_objectives() {
  level thread maps\_objectives::init();
  level.obj_secure = register_objective(&"SO_RTS_MP_SOCOTRA_OBJ_SECURE");
  level.obj_search = register_objective(&"SO_RTS_MP_SOCOTRA_OBJ_SEARCH");
  level.obj_rescue = register_objective(&"SO_RTS_MP_SOCOTRA_OBJ_RESCUE");
  level.obj_escort = register_objective(&"SO_RTS_MP_SOCOTRA_OBJ_ESCORT");
  level thread socotra_objective_karma_watch();
}

socotra_objective_karma_watch() {
  level endon("socotra_mission_complete");
  set_objective(level.obj_secure);
  level waittill("socotra_karma_rescued");
  set_objective(level.obj_escort, level.rts.outroloc.origin);
  objective_icon(level.obj_escort, "waypoint_extract");
}

enemyspawninit() {
  maps\_so_rts_catalog::spawn_package("quadrotor_pkg", "axis", 1, ::socotra_quad_spawn);
  maps\_so_rts_catalog::spawn_package("quadrotor_pkg", "axis", 1, ::socotra_quad_spawn);
  maps\_so_rts_catalog::spawn_package("quadrotor_pkg", "axis", 1, ::socotra_quad_spawn);
  maps\_so_rts_catalog::spawn_package("quadrotor_pkg", "axis", 1, ::socotra_quad_spawn);
  maps\_so_rts_catalog::spawn_package("quadrotor_pkg", "axis", 1, ::socotra_quad_spawn);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", level.rts.safehouses.size);
  pkg = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_reg_pkg");

  foreach(loc in level.rts.safehouses) {
    maps\_so_rts_ai::spawn_ai_package_standard(pkg, "axis", ::socotra_poi_inf_spawn, loc.origin);
    squad = getsquadbypkg("infantry_enemy_reg_pkg", "axis");
    unit = maps\_so_rts_enemy::create_units_from_squad(squad.id);
    level thread maps\_so_rts_enemy::unitthink(unit, maps\_so_rts_poi::getpoibyref(loc.poi_ref));

    foreach(guy in unit.members) {
      nodes = guy findbestcovernodes(384, loc.origin);

      if(nodes.size > 0) {
        node = nodes[randomint(nodes.size)];
        guy setgoalnode(node);
      }
    }
  }

  level.rts.enemyspawnlocs = getentarray("enemy_spawn_loc", "targetname");

  foreach(loc in level.rts.enemyspawnlocs)
  loc.timestamp = 0;

  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", -1);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", -1);
  pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_reg_pkg");
  pkg_ref.min_axis = 2;
  pkg_ref.max_axis = 4;
  pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_elite_pkg");
  pkg_ref.min_axis = 2;
  pkg_ref.max_axis = 4;
}

socotraairsuperioritytakeoverwatch() {
  self endon("death");
  level endon("rts_terminated");
  level endon("socotra_karma_rescued");
  level endon("socotra_mission_complete");

  while(true) {
    self waittill("taken_control_over");
    rpc("clientscripts/_so_rts", "holdSwitchStatic", 1);

    if(isDefined(self.gunner))
      self.gunner delete();

    self waittill("enter_vehicle");
    level.rts.player.vtol = self;
    wait 0.1;
    rpc("clientscripts/_so_rts", "holdSwitchStatic", 0);
    self thread socotraairsuperiorityplayermove();
    self notify("turretRegulateTime");
    self waittill("player_exited");
    level.rts.player.vtol = undefined;

    if(!isDefined(self.gunner) && !flag("rts_gameover")) {
      self.gunner = simple_spawn_single("ai_spawner_ally_assault");

      if(isDefined(self.gunner)) {
        self.gunner.ignoreme = 1;
        self.gunner magic_bullet_shield();
        self.gunner maps\_vehicle_aianim::vehicle_enter(self, "tag_gunner1");
      }

      self thread turretregulatetime(3, 5, 5, 10);
    }
  }
}

socotraairheightclamp(squadid) {
  origin = getent("air_support_start", "targetname").origin;
  squad = maps\_so_rts_squad::getsquad(squadid);
  squad.centerpoint = (squad.centerpoint[0], squad.centerpoint[1], origin[2]);
  ret = 1;

  switch (squad.nextstate) {
    case 2:
    case 4:
      level.rts.vtol thread turretontargetfortime(squad, 30);
    case 3:
    case 5:
    case 7:
      ret = 0;
  }

  if(ret == 0)
    maps\_so_rts_squad::reissuesquadlastorders(squad.id);

  return ret;
}

socotraairnada(squadid) {
  return false;
}

force_fire_turret_on_target_when_possible_with_vo(squad) {
  if(!isDefined(squad.target)) {
    friendlies = getaiarray("axis");

    foreach(friend in friendlies) {
      if(distance2dsquared(squad.centerpoint, friend.origin) < 40000) {
        maps\_so_rts_event::trigger_event("dlg_vtol_not_engaging_friendlies");
        return;
      }
    }
  }

  if(isDefined(squad.target)) {
    v_target = squad.target.origin;
    self setgunnertargetent(squad.target, vectorscale((0, 0, 1), 5.0), 1);
  } else {
    v_target = squad.centerpoint;
    self setgunnertargetvec(v_target, 1);
  }

  wait 1;

  if(!maps\_turret::is_target_in_turret_view(v_target, 1)) {
    wait 1;

    while(!maps\_turret::is_target_in_turret_view(v_target, 1)) {
      if(isDefined(squad.target))
        v_target = squad.target.origin;
      else
        v_target = squad.centerpoint;

      wait 0.2;
    }
  }

  maps\_so_rts_event::trigger_event("dlg_vtol_engaging");
  self thread fire_turret_for_time(5.0, 1);
}

circletarget(squad) {
  self notify("circleTarget");
  self endon("circleTarget");
  self endon("death");
  level endon("socotra_karma_rescued");
  level endon("socotra_mission_complete");

  if(isDefined(squad.target))
    vec_from_target = self.origin - squad.target.origin;
  else
    vec_from_target = self.origin - squad.centerpoint;

  yaw = vectortoangles(vec_from_target)[1];

  if(lengthsquared(vec_from_target) < 490000)
    yaw = yaw + 180;

  while(isDefined(self)) {
    driver = self getseatoccupant(1);

    if(isDefined(driver)) {
      wait 1;
      continue;
    }

    offset = anglestoforward((0, yaw, 0));

    if(isDefined(squad.target)) {
      goal = squad.target.origin;
      yaw = yaw + 1.0;
    } else {
      goal = squad.centerpoint;
      yaw = yaw + 0.5;
    }

    goal = goal + offset * 2000;
    ret = maps\_so_rts_support::clamporigintomapboundary(goal);
    self setvehgoalpos((ret.origin[0], ret.origin[1], self.origin[2]), 1);
    self settargetyaw(yaw + 90);
    wait 0.1;
  }
}

turretontargetfortime(squad, time) {
  self notify("turretOnTargetforTime");
  self endon("turretOnTargetforTime");
  level endon("socotra_karma_rescued");
  level endon("socotra_mission_complete");
  self endon("death");
  self maps\_turret::set_turret_burst_parameters(5, 10, 1, 4, 1);
  target_array = [];
  enemies = arraycombine(getaiarray("axis"), getvehiclearray("axis"), 0, 0);

  if(isDefined(squad.target))
    center_pt = squad.target.origin;
  else
    center_pt = squad.centerpoint;

  target_array = sortarraybyclosest(center_pt, enemies, 65536);
  self maps\_turret::set_turret_target_ent_array(target_array, 1);
  self maps\_turret::set_turret_ignore_line_of_sight(1, 1);
  self thread maps\_turret::enable_turret(1, 0);
  self maps\_turret::unpause_turret(1);
  driver = self getseatoccupant(1);

  if(!isDefined(driver)) {
    self thread force_fire_turret_on_target_when_possible_with_vo(squad);
    self thread circletarget(squad);
  }

  while(time > 0 && isDefined(squad.target) && isalive(squad.target)) {
    time = time - 0.1;
    wait 0.1;
  }

  self maps\_turret::clear_turret_target_ent_array(1);
  self thread turretregulatetime(3, 5, 5, 10);
}

turretregulatetime(min, max, minwait, maxwait) {
  self endon("death");
  self notify("turretRegulateTime");
  self endon("turretRegulateTime");
  level endon("socotra_mission_complete");
  level endon("socotra_karma_rescued");
  self thread maps\_turret::enable_turret(1, 1);

  while(true) {
    time = randomintrange(minwait, maxwait);
    self maps\_turret::pause_turret(time, 1);
    wait(time);
    self maps\_turret::unpause_turret(1);
    wait(randomintrange(min, max));
  }
}

socotraairsuperioritythink(squadid) {
  level endon("rts_terminated");
  level endon("socotra_karma_rescued");
  level endon("socotra_mission_complete");
  luinotifyevent(&"rts_remove_squad", 1, squadid);
  squad = maps\_so_rts_squad::getsquad(squadid);
  squad.no_nag = 1;
  level.rts.vtol = squad.members[0];
  vtol = level.rts.vtol;
  assert(isDefined(vtol));
  vtol thread maps\_osprey::close_hatch();
  vtol endon("death");
  vtol setneargoalnotifydist(300);
  vtol setspeed(60, 25, 5);
  vtol thread socotraairsuperioritytakeoverwatch();
  vtol.squadid = squadid;
  vtol.gunner = simple_spawn_single("ai_spawner_ally_assault");
  vtol.gunner.ignoreme = 1;
  vtol.gunner magic_bullet_shield();
  vtol.gunner maps\_vehicle_aianim::vehicle_enter(vtol, "tag_gunner1");
  vtol.no_takeover = 1;
  squad.squad_execute_cb = ::socotraairheightclamp;
  flag_wait("intro_done");
  maps\_so_rts_event::trigger_event("dlg_raptor1_inc");
  squad.selectable = 1;
  maps\_so_rts_squad::ordersquaddefend(getstruct("vtol_initial_dest", "targetname").origin + vectorscale((0, 0, 1), 1000.0), squad.id, 1);
  wait 1;
  squad.selectable = 0;
  squad.squad_execute_cb = ::socotraairnada;
  vtol waittill_any("goal", "near_goal");
  vtol thread turretregulatetime(3, 5, 5, 10);
  vtol.no_takeover = undefined;
  squad.selectable = 1;
  vtol setspeed(20, 15, 5);
  squad.squad_execute_cb = ::socotraairheightclamp;
  vtol thread circletarget(squad);
  luinotifyevent(&"rts_add_squad", 3, squadid, squad.pkg_ref.idx, 0);
  luinotifyevent(&"rts_add_friendly_ai", 4, vtol getentitynumber(), squadid, 0, squad.pkg_ref.idx);
  flag_set("vtol_is_ready_for_player");

  while(isDefined(vtol))
    level waittill("new_squad_orders" + squadid);
}

socotraairsuperiorityplayermove() {
  self endon("death");
  self endon("player_exited");
  level endon("socotra_karma_rescued");
  level endon("rts_terminated");
  squad = maps\_so_rts_squad::getsquad(self.squadid);

  while(true) {
    controller = level.player getnormalizedmovement();
    angles = self gettagangles("tag_gunner_turret1");
    angles = (0, angles[1], angles[2]);
    angles = (angles[0], angleclamp180(angles[1]), angles[2]);
    angles = (angles[0], angles[1], 0);
    forward = anglestoforward(angles);
    right = anglestoright(angles);

    if(length(controller) > 0.1) {
      point = self.origin + forward * (controller[0] * 250);
      point = point + right * (controller[1] * 250);
      result = maps\_so_rts_support::clamporigintomapboundary(point);
      maps\_so_rts_squad::ordersquaddefend(result.origin, self.squadid, 1);
      self setvehgoalpos(result.origin, 1);
    } else {
      result = maps\_so_rts_support::clamporigintomapboundary(self.origin);
      maps\_so_rts_squad::ordersquaddefend(result.origin, self.squadid, 1);
    }

    self settargetyaw(angles[1] - 90);
    wait 0.05;
  }
}

socotraairsuperiorityhandlegunnertarget() {
  self notify("handle_target");
  self endon("handle_target");
  level endon("socotra_karma_rescued");

  if(!isDefined(self)) {
    return;
  }
  target_set(self, vectorscale((0, 0, 1), 32.0));
  self waittill("death");
  targets = target_getarray();

  if(isDefined(self))
    target_remove(self);
}

socotraairsuperiorityspawn() {
  maps\_so_rts_catalog::setpkgqty("airsuperiority_pkg", "allies", 1);
  maps\_so_rts_catalog::spawn_package("airsuperiority_pkg", "allies", 0, ::socotraairsuperioritythink);
}

largestcomparefunc(e1, e2, val) {
  return e1.score > e2.score;
}

infantry_init(squadid) {
  foreach(guy in level.rts.squads[squadid].members)
  guy.goalradius = 256;
}

socotragopath(delay) {
  wait(delay);
  self thread go_path(getvehiclenode("quad_start", "targetname"));
}

gas_attach_head(guy) {
  if(guy.headmodel != "c_usa_seal6_head1") {
    guy detach(guy.headmodel, "");
    guy.headmodel = "c_usa_seal6_head1";
    guy attach(guy.headmodel, "", 1);
  }
}

socotracodespawner(pkg_ref, team, callback, squadid) {
  allies = getaiarray("allies");

  if(team == "axis") {
    if(pkg_ref.ref == "quadrotor_pkg") {
      squadid = maps\_so_rts_squad::createsquad(level.rts.enemy_center.origin, team, pkg_ref);
      squad = level.rts.squads[squadid];

      if(squad.members.size >= pkg_ref.max_axis)
        return -1;

      ai_ref = level.rts.ai["ai_spawner_quadrotor"];
      maps\_so_rts_squad::removedeadfromsquad(squadid);
      loc = getstruct("quadrotor_spawn", "targetname");
      ai = maps\_so_rts_support::placevehicle(ai_ref.ref, loc.origin, team);
      ai.ai_ref = ai_ref;
      ai maps\_so_rts_squad::addaitosquad(squadid);
      maps\_so_rts_catalog::units_delivered(team, squadid);
      ai thread socotragopath(squad.members.size * 0.4);
      return squadid;
    }

    time = gettime();
    acceptable = [];
    locs = sortarraybyfurthest(level.rts.player.origin, level.rts.enemyspawnlocs, 490000);

    for(i = 0; i < locs.size; i++) {
      if(time > locs[i].timestamp)
        acceptable[acceptable.size] = locs[i];
    }

    if(acceptable.size == 0)
      return -1;

    valid = [];

    foreach(loc in acceptable) {
      loc.distscore = loc.lastdistcalc / 1048576 * 2;
      loc.timescore = (time - loc.timestamp) / 6000;
      loc.allyscore = 0;
      loc.poiscore = 0;

      foreach(poi in level.rts.poi) {
        if(!isDefined(poi.entity)) {
          continue;
        }
        distsq = distancesquared(loc.origin, poi.entity.origin);

        if(distsq < 262144)
          loc.poiscore = -1;
      }

      foreach(guy in allies) {
        distsq = distancesquared(loc.origin, guy.origin);

        if(distsq < 360000)
          loc.allyscore = loc.allyscore - 1;
      }

      if(isDefined(level.rts.player.ally)) {
        distsq = distancesquared(loc.origin, level.rts.player.origin);

        if(distsq < 360000)
          continue;
      }

      loc.score = loc.poiscore == -1 ? 0 : loc.distscore + loc.timescore + loc.allyscore;
      valid[valid.size] = loc;
    }

    spots = maps\_utility_code::mergesort(valid, ::largestcomparefunc);
    spot = spots[0];
    spot.timestamp = time + 6000;
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin);

    foreach(guy in level.rts.squads[squadid].members) {
      if(isDefined(guy)) {
        guy thread socotraairsuperiorityhandlegunnertarget();
        guy.dofiringdeath = 0;
      }
    }
  } else if(pkg_ref.ref == "airsuperiority_pkg") {
    origin = getent("air_support_start", "targetname").origin;
    ai_ref = level.rts.ai["vtol_air_support_spawner"];
    squadid = maps\_so_rts_squad::createsquad(origin, team, pkg_ref);

    if(team == "allies" && isDefined(pkg_ref.hot_key_takeover))
      luinotifyevent(&"rts_add_squad", 3, squadid, pkg_ref.idx, 0);

    ai = maps\_so_rts_support::placevehicle(ai_ref.ref, origin, team);
    ai.ai_ref = ai_ref;
    ai.allow_oob = 1;
    ai maps\_so_rts_squad::addaitosquad(squadid);
    maps\_so_rts_catalog::units_delivered(team, squadid);
  } else if(pkg_ref.ref == "infantry_ally_reg_pkg") {
    squad = issquadalreadycreated("allies", pkg_ref);

    if(isDefined(squad)) {
      if(isDefined(squad.incodespawn) && squad.incodespawn)
        return -1;

      foreach(guy in squad.members) {
        if(isDefined(guy))
          guy.alreadyinsquad = 1;
      }
    }

    origin = getstruct("rts_ally_squad_reg_spawnLoc", "targetname").origin;
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, ::infantry_init, origin);
    level.rts.squads[squadid].incodespawn = 1;
    newguys = [];

    if(isDefined(squad)) {
      foreach(guy in squad.members) {
        if(isDefined(guy)) {
          if(!(isDefined(guy.alreadyinsquad) && guy.alreadyinsquad)) {
            newguys[newguys.size] = guy;
            guy.allow_oob = 1;
          }
        }
      }
    }

    for(i = 0; i < newguys.size; i++) {
      newguys[i].animname = "ally_intro_" + i;
      level thread run_scene("infantry_reg_pkg_intro_" + i);
      newguys[i] thread intro_wait("infantry_reg_pkg_intro_" + i);
    }

    maps\_so_rts_squad::reissuesquadlastorders(squadid);
    pkg_ref.incodespawn = undefined;
  } else if(pkg_ref.ref == "infantry_ally_reg2_pkg") {
    squad = issquadalreadycreated("allies", pkg_ref);

    if(isDefined(squad)) {
      if(isDefined(squad.incodespawn) && squad.incodespawn)
        return -1;

      foreach(guy in squad.members) {
        if(isDefined(guy))
          guy.alreadyinsquad = 1;
      }
    }

    origin = getstruct("rts_ally_squad_heavy_spawnLoc", "targetname").origin;
    squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, ::infantry_init, origin);
    level.rts.squads[squadid].incodespawn = 1;
    newguys = [];

    if(isDefined(squad)) {
      foreach(guy in squad.members) {
        if(isDefined(guy)) {
          if(!(isDefined(guy.alreadyinsquad) && guy.alreadyinsquad)) {
            newguys[newguys.size] = guy;
            guy.allow_oob = 1;
          }
        }
      }
    }

    for(i = 0; i < newguys.size; i++) {
      newguys[i].animname = "ally_heavy_intro_" + i;
      level thread run_scene("infantry_ally_reg2_pkg_" + i);
      newguys[i] thread intro_wait("infantry_ally_reg2_pkg_" + i);
    }

    maps\_so_rts_squad::reissuesquadlastorders(squadid);
  } else if(pkg_ref.ref == "quadrotor_pkg") {
    if(!isDefined(level.rts.vtol))
      return -1;

    squad = maps\_so_rts_squad::getsquadbypkg("quadrotor_pkg", "allies");
    maps\_so_rts_squad::removedeadfromsquad(squad.id);

    if(squad.members.size >= pkg_ref.max_friendly)
      return -1;

    squadid = squad.id;
    level.rts.vtol thread maps\_so_rts_ai::chopper_unload_cargo_quad(pkg_ref, team, squadid, maps\_so_rts_squad::squad_unloaded);
  }

  if(isDefined(callback))
    thread[[callback]](squadid);

  return squadid;
}

intro_wait(flag) {
  self.rts_unloaded = 0;
  scene_wait(flag);
  self.animname = undefined;
  self.rts_unloaded = 1;
  self.allow_oob = 0;
  everybodydone = 1;

  foreach(guy in level.rts.squads[self.squadid].members) {
    if(!(isDefined(guy.rts_unloaded) && guy.rts_unloaded)) {
      everybodydone = 0;
      break;
    }
  }

  if(everybodydone == 1)
    level.rts.squads[self.squadid].incodespawn = undefined;
}

socoatra_ai_takeover_trigger(oob) {
  while(isDefined(self)) {
    self waittill("trigger", who);

    if(isDefined(oob) && oob) {
      who.no_takeover = 1;
      who.ignoreme = 1;
    } else {
      who.no_takeover = undefined;
      who.ignoreme = 0;
    }
  }
}

socotra_ai_takeover_off() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_OFF", "targetname");
  array_thread(triggers, ::socoatra_ai_takeover_trigger, 1);
}

socotra_ai_takeover_on() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_ON", "targetname");
  array_thread(triggers, ::socoatra_ai_takeover_trigger, 0);
}

socotra_heavy_guy_unload(point, radius) {
  self.rts_unloaded = 0;
  oldradius = self.goalradius;
  self.goalradius = radius;
  self setgoalpos(point);
  self waittill("goal");
  self.rts_unloaded = 1;
  self.goalradius = oldradius;
}

socotra_heavy_squad_spawned(squadid) {
  origin = getstruct("rts_ally_squad_heavy", "targetname").origin;
  done = 0;
  array_thread(level.rts.squads[squadid].members, ::socotra_heavy_guy_unload, origin, 128);

  while(!done) {
    wait 0.5;
    done = 1;

    foreach(guy in level.rts.squads[squadid].members) {
      if(!(isDefined(guy.rts_unloaded) && guy.rts_unloaded))
        done = 0;
    }
  }
}

socotra_vtol_watch() {
  level endon("socotra_mission_complete");
}

socotra_karma_slice(percent, interval) {
  self endon("death");
  self notify("socotra_karma_shield");
  self endon("socotra_karma_shield");

  while(true) {
    self.health_slice = percent * self.health_max;
    wait(interval);
  }
}

socotra_karma_damagepulse(interval) {
  self notify("socotra_karma_damagePulse");
  self endon("socotra_karma_damagePulse");
  self endon("death");
  luinotifyevent(&"rts_pulse_poi", 2, self getentitynumber(), 1);
  wait(interval);
  luinotifyevent(&"rts_pulse_poi", 2, self getentitynumber(), 0);
}

socotra_karma_damagewatch() {
  level notify("socotra_karma_damageWatch");
  level endon("socotra_mission_complete");
  level endon("socotra_karma_damageWatch");
  val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + 255;
  level.rts.karma thread maps\_so_rts_support::set_gpr(val);
  level.rts.karma thread socotra_karma_slice(0.05, 2);

  while(isDefined(level.rts.karma)) {
    level.rts.karma waittill("damage", amount, attacker, vec, p, type);
    level.rts.karma thread socotra_karma_damagepulse(2);
    maps\_so_rts_event::trigger_event("dlg_hvt_so_damaged");

    println("(" + gettime() + ")###$ KARMA Health:" + level.rts.karma.health + " Damage:" + amount);

    if(level.rts.karma.health_slice > amount)
      level.rts.karma.health_slice = level.rts.karma.health_slice - amount;
    else {
      rebatehp = int(amount - level.rts.karma.health_slice);
      amount = level.rts.karma.health_slice;
      level.rts.karma.health_slice = 0;
      level.rts.karma.health = level.rts.karma.health + rebatehp;

      println("(" + gettime() + ")###$ KARMA taking more damage than interval allows.Adding back Health:" + rebatehp);

    }

    health = level.rts.karma.health - amount;

    if(health < 0)
      health = 0;
    else
      health = int(health / level.rts.karma.health_max * 255);

    val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + health;
    level.rts.karma thread maps\_so_rts_support::set_gpr(val);

    if(amount > level.rts.karma.health) {
      flag_set("karma_died");
      maps\_so_rts_event::trigger_event("dlg_hvt_so_died");
      luinotifyevent(&"rts_del_poi", 1, level.rts.karma getentitynumber());
      delay_thread(1, ::socotra_karma_died);
      return;
    }
  }
}

socotra_karma_died() {
  maps\_so_rts_rules::mission_complete(0);
}

socotra_karma_playedasplayerwatch() {
  level endon("karma_restore");
  outro_spot = getent("karma_outro_spot", "targetname");
  flag_wait("vtol_at_outro");

  while(!flag("karma_at_outro")) {
    if(level.rts.player istouching(outro_spot)) {
      if(isDefined(level.rts.switch_trans)) {
        wait 0.1;
        continue;
      }

      screen_fade_out(0.5);
      thread player_eyeinthesky(1, 0);
      flag_wait("rts_mode");
      flag_set("karma_at_outro");
      return;
    }

    wait 0.1;
  }
}

socotra_karama_spawnwatch() {
  level endon("socotra_mission_complete");
  level waittill("safehouse_clear");
  level waittill("safehouse_clear");
  level waittill("safehouse_clear");
  level thread socotra_karma_spawn();

  while(true) {
    level waittill("taken_control_over", entity);

    if(isDefined(level.rts.karma) && entity == level.rts.karma) {
      luinotifyevent(&"rts_del_poi", 1, level.rts.karma getentitynumber());
      level thread socotra_karma_playedasplayerwatch();
      level.rts.player.failondeath = 1;
      karmahealth = level.rts.karma.health;
      level.rts.karma = undefined;
      level waittill("karma_takeover");
      level.rts.disabledelayeddeathbodydelete = 1;
      level.rts.player takeweapon("tazer_knuckles_sp");
      level.rts.player giveweapon("knife_karma_sp");

      if(level.rts.player hasweapon("frag_grenade_future_sp"))
        level.rts.player takeweapon("frag_grenade_future_sp");

      level waittill("karma_restore", karma);
      level.rts.disabledelayeddeathbodydelete = undefined;
      level.rts.player takeweapon("knife_karma_sp");
      level.rts.player giveweapon("tazer_knuckles_sp");
      level.rts.player.failondeath = undefined;
      level.rts.karma = karma;
      level.rts.karma.health = karmahealth;
      level.rts.karma.restorenote = "karma_restore";
      level.rts.karma.takeovernote = "karma_takeover";
      level.rts.karma.animname = "karma";
      level.rts.karma.name = "Chloe";
      luinotifyevent(&"rts_add_poi", 1, level.rts.karma getentitynumber());
      luinotifyevent(&"rts_guard_poi", 1, level.rts.karma getentitynumber());
      level thread socotra_karma_damagewatch();
    }
  }
}

socotra_karma_roomspawninit(karma) {
  squad = getsquadbypkg("infantry_ally_reg_pkg", "allies");
  maps\_so_rts_squad::ordersquaddefend(level.rts.karma.origin, squad.id);
  i = 0;
  nodes = getnodesinradiussorted(level.rts.karma.origin, 512, 0, 128, "cover");

  foreach(guy in squad.members) {
    if(!isDefined(guy)) {
      continue;
    }
    guy forceteleport(nodes[i].origin);
    guy setgoalnode(nodes[i]);
    i++;

    if(i >= nodes.size)
      i = 0;
  }
}

socotra_karma_magic_circle() {
  self endon("death");
  trigger = spawn("trigger_radius", self.origin, 0, 200, 64);

  while(isDefined(self)) {
    if(self istouching(trigger) == 0) {
      break;
    }

    self.takedamage = 0;
    wait 0.05;
  }

  self.takedamage = 1;
  trigger delete();
}

karama_friendly_freewatch() {
  level endon("socotra_karma_rescued");
  heavysquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg2_pkg", "allies");
  regsquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg_pkg", "allies");

  while(true) {
    if(flag("rts_mode") && isDefined(level.rts.karma_poi.karma_trigger)) {
      foreach(guy in heavysquad.members) {
        if(guy istouching(level.rts.karma_poi.karma_trigger)) {
          level notify("socotra_karma_rescued");
          return;
        }
      }

      foreach(guy in regsquad.members) {
        if(guy istouching(level.rts.karma_poi.karma_trigger)) {
          level notify("socotra_karma_rescued");
          return;
        }
      }
    }

    wait 0.25;
  }
}

socotra_karama_bodyguardspawn(squadid) {
  guy1 = simple_spawn_single("ai_spawner_ally_assault", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  guy2 = simple_spawn_single("ai_spawner_ally_assault", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  guy1.ai_ref = level.rts.ai["ai_spawner_ally_assault"];
  guy2.ai_ref = level.rts.ai["ai_spawner_ally_assault"];
  guy1 maps\_so_rts_squad::addaitosquad(squadid);
  guy2 maps\_so_rts_squad::addaitosquad(squadid);
  wait 0.05;
  level notify("guards_spawned");

  if(flag("fps_mode")) {
    nodes = getnodesinradiussorted(level.rts.karma.origin, 512, 256);

    if(nodes.size) {
      guy1node = undefined;
      guy2node = undefined;
      forward = anglestoforward(level.rts.player.angles);

      foreach(node in nodes) {
        dir = vectornormalize(node.origin - level.rts.player.origin);
        dot = vectordot(forward, dir);

        if(dot < 0) {
          thread maps\_so_rts_support::debug_sphere(node.origin, 24, (0, 1, 0), 0.6, 180);

          if(!isDefined(guy1node)) {
            guy1node = node;
            continue;
          }

          if(!isDefined(guy2node)) {
            guy2node = node;
            break;
          }
        }
      }
    }

    if(isDefined(guy1node) && isDefined(guy1))
      guy1 forceteleport(guy1node.origin, guy1.angles);

    if(isDefined(guy2node) && isDefined(guy2))
      guy2 forceteleport(guy2node.origin, guy2.angles);
  } else {
    origin = getstruct("rts_ally_squad_heavy_spawnLoc", "targetname").origin;

    if(isDefined(guy1)) {
      guy1 forceteleport(origin, guy1.angles);
      guy1.animname = "karma_bodyguard_1";
      thread run_scene("karma_bodyguard_1");
    }

    if(isDefined(guy2)) {
      guy2 forceteleport(origin, guy2.angles);
      guy2.animname = "karma_bodyguard_2";
      thread run_scene("karma_bodyguard_2");
    }
  }

  maps\_so_rts_squad::ordersquadfollowai(squadid, level.rts.karma, 0);
}

karma_located(origin) {
  while(true) {
    if(distance2dsquared(level.rts.player.origin, origin) < 122500) {
      break;
    }

    wait 0.2;
  }

  level.rts.player waittill_player_looking_at(origin);

  if(!flag("karma_rescue_player_started"))
    maps\_so_rts_event::trigger_event("dlg_room_hvt_located");
}

karma_sayswhoareyou() {
  maps\_so_rts_event::trigger_event("dlg_hvt_whoareyou");
}

socotra_karma_spawn() {
  println(gettime() + " karma_spawn");

  pkg_ref = package_getpackagebytype("karma_pkg");
  level.rts.karma = simple_spawn_single(pkg_ref.units[0], undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level.rts.karma.animname = "karma";
  level.rts.karma.name = "Chloe";
  level.rts.karma_poi = level.rts.safehouses[randomint(level.rts.safehouses.size)];
  level.rts.karma_poi.karma = 1;
  level thread karama_friendly_freewatch();
  level thread socotra_rooftopinit();
  level.rts.karma.ai_ref = level.rts.ai[pkg_ref.units[0]];
  level.rts.karma.team = "neutral";
  level.rts.karma.ignoreme = 1;
  level.rts.karma.ignoreall = 1;
  level.rts.karma.goalradius = 4;
  level.rts.karma.takedamage = 0;
  level.rts.karma.selectable = 0;
  level.rts.karma.rts_unloaded = 0;
  level.rts.karma.no_takeover = 1;
  level.rts.karma.health_max = level.rts.karma.health;
  level.rts.karma disableaimassist();
  oldgrenadeawareness = level.rts.karma.grenadeawareness;
  level.rts.karma.grenadeawareness = 0;
  level.rts.karma.viewhands = "c_usa_chloe_lynch_viewhands";
  level.rts.karma forceteleport(level.rts.karma_poi.origin, level.rts.karma_poi.angles);
  level.rts.karma_poi.karma_trigger = spawn("trigger_radius", level.rts.karma_poi.origin, 0, 48, 64);
  level.rts.karma allowedstances("crouch");
  level.rts.karma thread socotra_karma_magic_circle();
  animalignnode = spawn("script_origin", level.rts.karma.origin);
  animalignnode.angles = level.rts.karma.angles + (0, 0, 0);
  animalignnode.targetname = "karma_loc";
  level thread run_scene("karma_rescue_karma_idle");
  level.rts.karma thread karma_helpme(level.rts.karma.origin, 200);
  level thread maps\_so_rts_support::trigger_use(level.rts.karma_poi.karma_trigger, & "SO_RTS_MP_SOCOTRA_FREE_KARMA", "socotra_karma_rescued");
  level waittill("socotra_karma_rescued");
  level thread karma_sayswhoareyou();
  level.rts.karma_poi.karma_trigger delete();
  flag_set("found_hvt");
  set_objective(level.obj_search, undefined, "done");
  enemydefensespots = getentarray("enemy_rally_loc", "targetname");

  while(level.rts.enemy_units.size) {
    if(randomint(100) < 30)
      unitdisperse(level.rts.enemy_units[0], enemydefensespots[randomint(enemydefensespots.size)].origin);
  }

  foreach(unit in level.rts.enemy_units)
  unitdefend(unit, enemydefensespots[randomint(enemydefensespots.size)].origin);

  level.rts.vtol.rts_unloaded = 0;
  maps\_so_rts_squad::removesquadmarker(level.rts.vtol.squadid, 0);
  level.rts.squads[level.rts.vtol.squadid].selectable = 0;
  level.rts.squads[level.rts.vtol.squadid].squad_execute_cb = undefined;
  level thread vtol_move_away();

  if(isDefined(level.rts.ally) && level.rts.ally.squadid == level.rts.vtol.squadid) {
    level.rts.lastfpspoint = level.rts.player.origin;
    level thread player_eyeinthesky();
  }

  val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + 255;
  level.rts.karma thread maps\_so_rts_support::set_gpr(val);
  squadid = maps\_so_rts_squad::createsquad(level.rts.karma_poi.origin, "allies", pkg_ref);
  karmasquad = maps\_so_rts_squad::getsquadbypkg("karma_pkg", "allies");
  assert(karmasquad.id == squadid);
  level.rts.karma maps\_so_rts_squad::addaitosquad(squadid);
  level.rts.karma.no_takeover = 1;
  level thread socotra_karama_bodyguardspawn(squadid);
  level waittill("guards_spawned");
  maps\_so_rts_squad::squad_unloaded(squadid);
  level.rts.karma.name = "Chloe";
  level.rts.squads[squadid].selectable = 0;
  level.rts.squads[squadid].no_nag = 1;
  end_scene("karma_rescue_karma_idle");

  if(flag("fps_mode")) {
    level.rts.player freezecontrols(1);
    maps\_so_rts_support::hide_player_hud();
    flag_set("block_input");
    luinotifyevent(&"rts_toggle_minimap", 1, 0);
    badplace_cylinder("karma_spot", 30, level.rts.karma.origin, 1024, 512, "axis");
    level.rts.player enableinvulnerability();
    level.rts.player.ignoreme = 1;
    level thread run_scene("karma_rescue_player");
    level thread run_scene("karma_rescue_karma");
    level.rts.player setstance("stand");
    killzone = maps\_so_rts_support::createkillzone(level.rts.karma.origin, 200, 64, "axis");
    heavysquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg2_pkg", "allies");
    regsquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg_pkg", "allies");
    maps\_so_rts_squad::removesquadmarker(regsquad.id, 0);
    maps\_so_rts_squad::removesquadmarker(heavysquad.id, 0);
    maps\_so_rts_squad::removesquadmarker(karmasquad.id, 0);
    wait 0.1;
    luinotifyevent(&"rts_add_squad", 3, regsquad.id, regsquad.pkg_ref.idx, 0);

    foreach(guy in regsquad.members)
    luinotifyevent(&"rts_add_friendly_human", 5, guy getentitynumber(), regsquad.id, 35, 0, regsquad.pkg_ref.idx);

    luinotifyevent(&"rts_add_squad", 3, karmasquad.id, karmasquad.pkg_ref.idx, 0);
    luinotifyevent(&"rts_add_friendly_human", 5, level.rts.karma getentitynumber(), karmasquad.id, 35, 0, karmasquad.pkg_ref.idx);
    luinotifyevent(&"rts_add_squad", 3, heavysquad.id, heavysquad.pkg_ref.idx, 0);

    foreach(guy in heavysquad.members)
    luinotifyevent(&"rts_add_friendly_human", 5, guy getentitynumber(), heavysquad.id, 35, 0, heavysquad.pkg_ref.idx);

    scene_wait("karma_rescue_player");

    if(flag("fps_mode")) {
      maps\_so_rts_support::show_player_hud();
      level.rts.player disableinvulnerability();
      luinotifyevent(&"rts_toggle_minimap", 1, 1);
      level.rts.player.ignoreme = 0;
      level.rts.player freezecontrols(0);
      flag_clear("block_input");
      scene_wait("karma_rescue_karma");
      killzone delete();
    }
  } else {
    heavysquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg2_pkg", "allies");
    regsquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg_pkg", "allies");
    luinotifyevent(&"rts_remove_squad", 1, regsquad.id);
    luinotifyevent(&"rts_remove_squad", 1, heavysquad.id);
    luinotifyevent(&"rts_remove_squad", 1, karmasquad.id);
    level notify("removeSquadMarker" + regsquad.id);
    level notify("removeSquadMarker" + heavysquad.id);
    wait 0.1;
    luinotifyevent(&"rts_add_squad", 3, regsquad.id, regsquad.pkg_ref.idx, 0);

    foreach(guy in regsquad.members)
    luinotifyevent(&"rts_add_friendly_human", 5, guy getentitynumber(), regsquad.id, 35, 0, regsquad.pkg_ref.idx);

    luinotifyevent(&"rts_add_squad", 3, karmasquad.id, karmasquad.pkg_ref.idx, 0);
    luinotifyevent(&"rts_add_friendly_human", 5, level.rts.karma getentitynumber(), karmasquad.id, 35, 0, karmasquad.pkg_ref.idx);
    luinotifyevent(&"rts_add_squad", 3, heavysquad.id, heavysquad.pkg_ref.idx, 0);

    foreach(guy in heavysquad.members)
    luinotifyevent(&"rts_add_friendly_human", 5, guy getentitynumber(), heavysquad.id, 35, 0, heavysquad.pkg_ref.idx);
  }

  maps\_so_rts_event::trigger_event("dlg_hvt_secure");
  luinotifyevent(&"rts_update_hint_text", 2, istring("SO_RTS_MP_SOCOTRA_KARMA_HINT"), 10);
  animalignnode delete();
  level.rts.karma allowedstances("crouch", "stand");
  level.rts.squads[squadid].no_nag = undefined;
  level.rts.karma.fixednode = 0;
  level.rts.karma.grenadeawareness = oldgrenadeawareness;
  level.rts.karma.health = level.rts.karma.health_max;
  level.rts.karma.canflank = 0;
  level.rts.karma.aggressivemode = 0;
  level.rts.karma.pathenemyfightdist = 0;
  level.rts.karma.dontmelee = 1;
  level.rts.karma.dontmeleeme = 1;
  level.rts.karma.a.coveridleonly = 1;
  level.rts.karma.maxsightdistsqrd = 490000;
  level.rts.karma.ignoresuppression = 1;
  level.rts.karma.rescued = 1;
  level.rts.karma.no_takeover = undefined;
  level.rts.karma.restorenote = "karma_restore";
  level.rts.karma.takeovernote = "karma_takeover";
  level thread socotra_karma_damagewatch();
  maps\_so_rts_support::remapkeybindingparam(pkg_ref.hot_key_command, pkg_ref);
  maps\_so_rts_support::remapkeybindingparam(pkg_ref.hot_key_takeover, pkg_ref);
  level.rts.squads[squadid].primary_ai_switchtarget = level.rts.karma;
  maps\_so_rts_squad::squad_unloaded(squadid);

  foreach(dude in level.rts.squads[squadid].members)
  dude.goalradius = 128;

  if(isDefined(level.rts.player.ally))
    maps\_so_rts_squad::ordersquadfollowai(squadid, level.rts.player);
  else
    maps\_so_rts_squad::ordersquadfollowai(squadid, level.rts.karma);

  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg_pkg", "allies", 0);
  allies = heavysquad.members.size + regsquad.members.size;

  if(allies < 3)
    maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", 1);

  outro_spot = getent("karma_outro_spot", "targetname");
  flag_wait("vtol_at_outro");

  while(!flag("karma_at_outro")) {
    if(isDefined(level.rts.karma) && level.rts.karma istouching(outro_spot)) {
      flag_set("karma_at_outro");
      break;
    }

    wait 0.1;
  }
}

vtol_move_away() {
  level.rts.vtol maps\_so_rts_squad::removeaifromsquad();
  level.rts.vtol setneargoalnotifydist(1800);
  smoke_pos = get_struct("smoke_spot", "targetname");
  smoke_model = spawn_model("weapon_us_smoke_grenade_burnt", smoke_pos.origin, smoke_pos.angles);
  maps\_so_rts_event::trigger_event("fx_signal_smoke", smoke_model.origin);

  if(isDefined(level.rts.vtol.gunner))
    level.rts.vtol.gunner delete();

  level.rts.vtol setspeed(60, 25, 5);
  gotopoint = getent("vtol_outro_goto_loc", "targetname").origin;
  level.rts.vtol setvehgoalpos(gotopoint, 1);
  level.rts.vtol waittill_any("goal", "near_goal");
  level.rts.vtol setspeed(20, 15, 5);
  gotopoint = getent("vtol_outro_moveto_loc", "targetname").origin;
  maps\_so_rts_event::trigger_event("dlg_vtol_getting_in_position");
  level.rts.vtol setvehgoalpos(gotopoint, 1);
  note = level.rts.vtol waittill_any_return("goal", "near_goal");

  if(note == "near_goal") {
    maps\_so_rts_event::trigger_event("dlg_vtol_close_to_position");
    level.rts.vtol waittill_any_return("goal");
  }

  maps\_so_rts_event::trigger_event("dlg_vtol_in_position");
  level.rts.vtol setlookatent(getent("vtol_outro_lookat", "targetname"));
  flag_set("vtol_at_outro");
  flag_wait("karma_at_outro");
  maps\_so_rts_rules::mission_complete(1, 0);
}

karma_helpme(origin, radius) {
  trigger = spawn("trigger_radius", origin, 2, radius, 64);
  trigger waittill("trigger", who);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", -1);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", -1);
  level.rts.game_rules.num_nag_squads = 99;

  if(who == level.rts.player)
    squadid = level.rts.player.ally.squadid;
  else
    squadid = who.squadid;

  maps\_so_rts_event::trigger_event("dlg_room_hvt_located");
  set_objective(level.obj_search, undefined, "done");
  set_objective(level.obj_rescue);
  objective_icon(level.obj_rescue, "waypoint_secure");
  entnum = self getentitynumber();
  luinotifyevent(&"rts_add_poi", 1, entnum);
  luinotifyevent(&"rts_rescue_poi", 1, entnum);
  luinotifyevent(&"rts_update_pos_poi", 4, entnum, 0, 0, 58);
  level.rts.karma_poi.discovered = 1;
  arrayremovevalue(level.rts.safehouses, level.rts.karma_poi);
  luinotifyevent(&"rts_del_poi", 1, level.rts.karma_poi getentitynumber());

  while(level.rts.safehouses.size)
    safehouse_delete(level.rts.safehouses[0]);

  if(flag("rts_mode")) {
    if(!isDefined(level.rts.karma_poi.bldg)) {
      spot = level.rts.karma_poi;
      spot.bldg = spawn("script_model", spot.site.origin);
      spot.bldg.angles = isDefined(spot.site.angles) ? spot.site.angles : (0, 0, 0);
      spot.bldg setmodel(spot.modelname);
      spot.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 1);
      spot.bldg ignorecheapentityflag(1);
    } else
      level.rts.karma_poi.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 1);
  }

  level waittill("socotra_karma_rescued");
  luinotifyevent(&"rts_del_poi", 1, entnum);
  luinotifyevent(&"rts_add_poi", 1, entnum);
  luinotifyevent(&"rts_guard_poi", 1, entnum);
  luinotifyevent(&"rts_update_pos_poi", 4, entnum, 0, 0, 48);
  set_objective(level.obj_rescue, undefined, "done");
  safehouse_delete(level.rts.karma_poi);
  level.rts.safehouses = [];
}

vehicle_set_team(team) {
  self.team = team;
  self setteam(team);

  if(issubstr(self.vehicletype, "quadrotor"))
    self thread maps\_quadrotor::quadrotor_set_team(team);
  else
    self.vteam = team;
}

socotra_rooftopcleanup() {
  self endon("death");
  level waittill("karmaAtSmoke");
  self thread maps\_so_rts_support::delay_kill(randomint(8));
}

socotra_rooftopdeath() {
  forward = anglestoforward(self.angles);
  self startragdoll();
  self launchragdoll(vectorscale(forward, randomintrange(25, 35)), "tag_eye");
  self ragdoll_death();
}

socotra_rooftopinit() {
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", -1);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", -1);
  pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_reg_pkg");
  pkg_ref.min_axis = 4;
  pkg_ref.max_axis = 7;
  pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_elite_pkg");
  pkg_ref.min_axis = 3;
  pkg_ref.max_axis = 5;

  while(flag("rts_mode"))
    wait 0.05;

  rallypoints = getentarray("enemy_rally_loc", "targetname");
  rooftoplocs = array_randomize(getentarray("roofTopLoc", "targetname"));
  enemycount = getaiarray("axis");
  tospawn = 0;
  locs = [];

  foreach(spot in rallypoints) {
    potentials = sortarraybyclosest(spot.origin, rooftoplocs, 1048576);

    if(potentials.size > 0) {
      locs[locs.size] = potentials[0];
      tospawn++;
    }

    if(potentials.size > 1) {
      locs[locs.size] = potentials[1];
      tospawn++;
    }

    if(potentials.size > 2) {
      locs[locs.size] = potentials[2];
      tospawn++;
    }
  }

  ref = "infantry_enemy_rpg_pkg";
  spawner = "ai_spawner_enemy_rpg";
  pkg_ref = package_getpackagebytype(ref);
  squad = getsquadbypkg("infantry_enemy_rpg_pkg", "axis");
  squadid = maps\_so_rts_squad::createsquad(level.rts.player_startpos, "axis", pkg_ref);

  switch (getdifficulty()) {
    case "fu":
      break;
    case "hard":
      break;
    case "medium":
      if(tospawn > 3)
        tospawn = 3;

      break;
    case "easy":
      if(tospawn > 1)
        tospawn = 1;

      break;
  }

  for(i = 0; i < tospawn; i++) {
    loc = locs[i];
    ai = simple_spawn_single(spawner, undefined, undefined, undefined, undefined, undefined, undefined, 1);

    if(isDefined(ai)) {
      ai.ai_ref = level.rts.ai[pkg_ref.units[0]];
      ai maps\_so_rts_squad::addaitosquad(squadid);
      ai maps\_so_rts_ai::ai_preinitialize(level.rts.ai[spawner], package_getpackagebytype(ref), ai.team, undefined);
      ai maps\_so_rts_ai::ai_initialize(level.rts.ai[spawner], ai.team, ai.origin, undefined, ai.angles, package_getpackagebytype(ref), ai.health);
      ai maps\_so_rts_ai::ai_postinitialize();
      ai forceteleport(loc.origin + vectorscale((0, 0, 1), 12.0), loc.angles);
      ai.goalradius = 64;
      ai.rts_unloaded = 1;
      ai.deathfunction = ::socotra_rooftopdeath;
      ai thread socotra_rooftopcleanup();
      ai.secondaryweapon = "none";
      ai.secondaryweaponclass = "none";

      println("#### Rooftop guy (" + ai.classname + ") spawned in at " + loc.origin);

    }
  }
}

socotra_quad_spawn(squadid) {
  i = 0;
  spawnloc = arraycombine(getstructarray("quad_spawn_loc", "targetname"), getstructarray("asd_spawn_loc", "targetname"), 0, 0);
  squad = level.rts.squads[squadid];

  foreach(quad in squad.members) {
    if(isDefined(quad)) {
      quad.origin = spawnloc[i].origin + vectorscale((0, 0, 1), 12.0);
      quad maps\_vehicle::defend(quad.origin, 128);
      i++;

      if(i >= spawnloc.size)
        i = 0;
    }
  }
}

socotra_level_player_startfps() {
  playerstart = getent("rts_player_start", "targetname");
  assert(isDefined(playerstart));
  nextsquad = maps\_so_rts_squad::getnextvalidsquad(undefined);
  assert(nextsquad != -1, "should not be -1, player squad should be created");

  foreach(guy in level.rts.squads[nextsquad].members) {
    if(isDefined(guy)) {
      guy.allow_oob = 1;
      guy.goalradius = 350;
      gas_attach_head(guy);
    }
  }

  level.rts.activesquad = nextsquad;
  level.rts.targetteammate = level.rts.squads[nextsquad].members[0];
  level.rts.targetteammate forceteleport(playerstart.origin, playerstart.angles);
  level thread maps\_so_rts_main::player_in_control();
  level waittill("switch_complete");
  level.rts.player setorigin(playerstart.origin);
  level.rts.player setplayerangles(playerstart.angles);
  flag_set("block_input");
  level.rts.player freezecontrols(1);
  maps\_so_rts_support::hide_player_hud();
  socotra_startintro();
  flag_wait("intro_done");

  foreach(guy in level.rts.squads[nextsquad].members) {
    if(isDefined(guy))
      guy.allow_oob = undefined;
  }

  level.rts.player.ignoreme = 0;
  level.rts.player disableinvulnerability();
  level.rts.player freezecontrols(0);
  flag_clear("block_input");
}

socotra_startintro() {
  level thread socotra_climbup_intro();
  scene_wait("intro_climbup_player");
  flag_set("intro_done");
  flag_set("rts_hud_on");
  maps\_so_rts_support::show_player_hud();
}

socotra_mission_complete_s1(success, param) {
  if(isDefined(level.rts.game_success)) {
    return;
  }
  level notify("mission_complete", success);
  flag_set("block_input");
  level.rts.player freezecontrols(1);
  level.rts.game_success = success;
  level notify("socotra_mission_complete");

  while(isDefined(level.rts.switch_trans))
    wait 0.05;

  screen_fade_out(0.5);
  wait 0.5;
  maps\_so_rts_support::time_countdown_delete();

  if(isDefined(level.orange_outro_obj)) {
    level.orange_outro_obj delete();
    level.rts.orange_outro_obj = undefined;
  }

  foreach(spot in level.rts.safehouses) {
    if(isDefined(spot.bldg))
      spot.bldg delete();
  }

  maps\_so_rts_poi::deleteallpoi();
  level.rts.safehouses = [];

  if(isDefined(level.rts.karma_poi) && isDefined(level.rts.karma_poi.bldg)) {
    level.rts.karma_poi.bldg delete();
    level.rts.karma_poi.bldg = undefined;
  }

  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg_pkg", "allies", 0);
  allies = getaiarray("allies");

  foreach(ally in allies) {
    if(isDefined(ally.ai_ref))
      ally kill();
  }

  objective_state(level.obj_secure, success ? "done" : "failed");
  objective_state(level.obj_escort, success ? "done" : "failed");
  level.rts.player freezecontrols(1);
  level.rts.player disableweapons();
  level.rts.player set_ignoreme(1);
  flag_clear("rts_hud_on");
  maps\_so_rts_support::hide_player_hud();
  level.rts.player enableinvulnerability();
  flag_set("rts_mode_locked_out");
  flag_clear("rts_mode");
  flag_set("fps_mode");
  level clientnotify("rts_OFF");
  flag_set("rts_game_over");
  luinotifyevent(&"rts_hud_visibility", 1, 0);
  level.rts.player clearclientflag(3);
  maps\_so_rts_event::event_clearall(0);
  level.rts.player maps\_so_rts_ai::restorereplacement();

  if(isDefined(success) && success) {
    socotra_outro_success(level.rts.outroloc);
    flag_clear("rts_event_ready");
    level.player set_story_stat("SO_WAR_SOCOTRA_SUCCESS", 1);
    level.player giveachievement_wrapper("SP_RTS_SOCOTRA");
    maps\_so_rts_support::missionsuccessmenu();
  } else {
    if(isDefined(level.rts.vtol))
      level.rts.vtol delete();

    maps\_so_rts_event::trigger_event("dlg_mission_fail");
    flag_clear("rts_event_ready");
    socotra_outro_fail(level.rts.outroloc);
    maps\_so_rts_support::missionfailuremenu();
  }

  level clientnotify("rts_fd");
  maps\_so_rts_support::show_player_hud();
  maps\_so_rts_support::toggle_damage_indicators(1);
  nextmission();
}

socotra_geo_changes() {
  level thread populate_dying_bodies();
  level thread populate_dead_bodies();
}

populate_dying_bodies() {
  dead_body_locs = getstructarray("dying_body", "targetname");
  wait_for_first_player();
  male_spawner = getent("male_civ_spawner", "targetname");
  assert(isDefined(male_spawner));
  male_spawner.nofakeai = 1;
  level.scr_anim["male"]["death_anim"] = array( % ai_gas_death_a, % ai_gas_death_c, % ai_gas_death_g, % ai_gas_death_h);
  level.rts.dying_civs = [];

  for(i = 0; i < dead_body_locs.size; i++) {
    loc = dead_body_locs[i];
    dead_civ = male_spawner spawn_drone();
    assert(isDefined(dead_civ));
    dead_civ.animname = "male";
    dead_civ.origin = loc.origin;
    dead_civ.angles = loc.angles;
    dead_civ.takedamage = 0;
    dead_civ.nofriendlyfire = 1;

    recordent(dead_civ);
    recordline(loc.origin, level.player.origin, (0, 1, 0), "Script");

    dead_civ thread play_anim_on_civ("death_anim");
    level.rts.dying_civs[level.rts.dying_civs.size] = dead_civ;
  }
}

play_anim_on_civ(animname) {
  death_anim = self get_anim(animname, self.animname);
  self animscripted("anim_is_over", self.origin, self.angles, death_anim, "normal", % root, 1.0);
  animlength = getanimlength(death_anim);
  wait(animlength * 0.9);
}

populate_dead_bodies() {
  dead_body_locs = getstructarray("dead_body", "targetname");
  male_spawner = getent("male_civ_spawner", "targetname");
  assert(isDefined(male_spawner));
  female_spawner = getent("female_civ_spawner", "targetname");
  assert(isDefined(female_spawner));
  level.scr_anim["male"]["death_pose"] = array( % ch_gen_m_floor_armdown_legspread_onback_deathpose, % ch_gen_m_floor_armdown_onback_deathpose, % ch_gen_m_floor_armdown_onfront_deathpose, % ch_gen_m_floor_armrelaxed_onleftside_deathpose, % ch_gen_m_floor_armsopen_onback_deathpose, % ch_gen_m_floor_armspread_legaskew_onback_deathpose, % ch_gen_m_floor_armspread_legspread_onback_deathpose, % ch_gen_m_floor_armspreadwide_legspread_onback_deathpose, % ch_gen_m_floor_armstomach_onback_deathpose, % ch_gen_m_floor_armstomach_onrightside_deathpose, % ch_gen_m_floor_armstretched_onleftside_deathpose, % ch_gen_m_floor_armstretched_onrightside_deathpose, % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose, % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose, % ch_gen_m_floor_armup_onfront_deathpose);
  level.scr_anim["female"]["death_pose"] = array( % ch_gen_f_floor_onback_armstomach_legcurled_deathpose, % ch_gen_f_floor_onback_armup_legcurled_deathpose, % ch_gen_f_floor_onfront_armdown_legstraight_deathpose, % ch_gen_f_floor_onfront_armup_legcurled_deathpose, % ch_gen_f_floor_onfront_armup_legstraight_deathpose, % ch_gen_f_floor_onleftside_armcurled_legcurled_deathpose, % ch_gen_f_floor_onleftside_armstretched_legcurled_deathpose, % ch_gen_f_floor_onrightside_armstomach_legcurled_deathpose, % ch_gen_f_floor_onrightside_armstretched_legcurled_deathpose);
  level.rts.dead_civs = [];

  for(i = 0; i < dead_body_locs.size && i < 20; i++) {
    loc = dead_body_locs[i];
    dead_civ = undefined;
    male = randomfloat(1) > 0.5;

    if(male) {
      dead_civ = male_spawner spawn_drone();
      assert(isDefined(dead_civ));
      dead_civ.animname = "male";
    } else {
      dead_civ = female_spawner spawn_drone();
      assert(isDefined(dead_civ));
      dead_civ.animname = "female";
    }

    dead_civ.origin = loc.origin;
    dead_civ.angles = loc.angles;
    dead_civ.takedamage = 0;
    dead_civ.nofriendlyfire = 1;
    dead_civ thread play_anim_on_civ("death_pose");
    level.rts.dead_civs[level.rts.dead_civs.size] = dead_civ;
  }
}

socotra_level_scenario_one_registerevents() {
}

socotra_pick_safehouses() {
  level.rts.max_poi_infantry = 3;
  safehouses = array_randomize(arraycombine(getentarray("safe_house_a", "targetname"), getentarray("safe_house_b", "targetname"), 0, 0));
  poinames = array_randomize(array("rts_poi_search1", "rts_poi_search2", "rts_poi_search3", "rts_poi_search4", "rts_poi_search5"));
  safeloc1 = safehouses[0];
  safeloc2 = safehouses[1];
  safeloc3 = safehouses[2];
  safeloc4 = safehouses[3];
  safeloc5 = safehouses[4];
  safehouse1 = spawn("script_model", safeloc1.origin, 1);
  safehouse1.angles = safeloc1.angles;
  safehouse1.targetname = safeloc1.targetname;
  safehouse1.poi_ref = poinames[0];
  safehouse1.bldgid = safeloc1.script_parameters;
  safehouse1.trig = getent(safeloc1.target, "targetname");
  safehouse2 = spawn("script_model", safeloc2.origin, 1);
  safehouse2.angles = safeloc2.angles;
  safehouse2.targetname = safeloc2.targetname;
  safehouse2.poi_ref = poinames[1];
  safehouse2.bldgid = safeloc2.script_parameters;
  safehouse2.trig = getent(safeloc2.target, "targetname");
  safehouse3 = spawn("script_model", safeloc3.origin, 1);
  safehouse3.angles = safeloc3.angles;
  safehouse3.targetname = safeloc3.targetname;
  safehouse3.poi_ref = poinames[2];
  safehouse3.bldgid = safeloc3.script_parameters;
  safehouse3.trig = getent(safeloc3.target, "targetname");
  safehouse4 = spawn("script_model", safeloc4.origin, 1);
  safehouse4.angles = safeloc4.angles;
  safehouse4.targetname = safeloc4.targetname;
  safehouse4.poi_ref = poinames[3];
  safehouse4.bldgid = safeloc4.script_parameters;
  safehouse4.trig = getent(safeloc4.target, "targetname");
  safehouse5 = spawn("script_model", safeloc5.origin, 1);
  safehouse5.angles = safeloc5.angles;
  safehouse5.targetname = safeloc5.targetname;
  safehouse5.poi_ref = poinames[4];
  safehouse5.bldgid = safeloc5.script_parameters;
  safehouse5.trig = getent(safeloc5.target, "targetname");
  level.rts.safehouses = array(safehouse1, safehouse2, safehouse3, safehouse4, safehouse5);
  maps\_so_rts_poi::add_poi(poinames[0], safehouse1, "axis", 1, 1, 0, & "rts_search_poi");
  maps\_so_rts_poi::add_poi(poinames[1], safehouse2, "axis", 1, 1, 0, & "rts_search_poi");
  maps\_so_rts_poi::add_poi(poinames[2], safehouse3, "axis", 1, 1, 0, & "rts_search_poi");
  maps\_so_rts_poi::add_poi(poinames[3], safehouse4, "axis", 1, 1, 0, & "rts_search_poi");
  maps\_so_rts_poi::add_poi(poinames[4], safehouse5, "axis", 1, 1, 0, & "rts_search_poi");

  foreach(spot in level.rts.safehouses) {
    target = "mp_socotra_bldg_0" + spot.bldgid;
    spot.site = getstruct(target, "targetname");
    spot.modelname = "p6_sf_socotra_bldg_" + spot.bldgid;
  }

  level.rts.safehouses_cleared = 0;
  set_objective(level.obj_search, undefined, "*", level.rts.safehouses_cleared);

  foreach(house in level.rts.safehouses)
  house thread safehouse_capturewatch();
}

safehouse_delete(house, cleared) {
  if(!isDefined(cleared))
    cleared = 0;

  if(isDefined(house.bldg)) {
    house.bldg delete();
    house.bldg = undefined;
  }

  if(isDefined(house.trig)) {
    set_objective(level.obj_search, house.trig, "remove");
    house.trig delete();
  }

  maps\_so_rts_poi::poicaptured(house);
  luinotifyevent(&"rts_del_poi", 1, house getentitynumber());
  arrayremovevalue(level.rts.safehouses, house);

  if(flag("rts_mode") && level.rts.safehouses.size == 1) {
    spot = level.rts.safehouses[0];
    spot.bldg maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(3) + 1);
  }
}

safehouse_capturewatch() {
  self.trig waittill("trigger", who);
  level.rts.safehouses_cleared++;
  set_objective(level.obj_search, self.trig, "remove");
  set_objective(level.obj_search, undefined, undefined, level.rts.safehouses_cleared);

  if(!isDefined(level.rts.karma_poi) || self != level.rts.karma_poi) {
    safehouse_delete(self, 1);
    maps\_so_rts_event::trigger_event("dlg_room_no_hvt");
  }

  if(isDefined(level.rts.karma_poi) && self == level.rts.karma_poi && who != level.rts.player) {
    maps\_so_rts_squad::ordersquaddefend(level.rts.karma.origin, who.squadid);

    foreach(guy in level.rts.squads[who.squadid].members)
    guy.goalradius = 128;
  }

  level notify("safehouse_clear");
}

socotra_poi_inf_spawn(squadid) {
  foreach(guy in level.rts.squads[squadid].members)
  guy.goalradius = 256;
}

static_transition(player) {
  level.player setclientflag(1);
}

socotra_outro_dialog() {
  maps\_so_rts_event::trigger_event("dlg_mission_success_comeon");
  wait 3;
  maps\_so_rts_event::trigger_event("dlg_mission_success_onboard");
}

socotra_outro_success(alignnode) {
  level thread maps\createart\so_rts_mp_socotra_art::success_igc();
  level.rts.vtol.targetname = "outro_heli";
  level.rts.vtol.takedamage = 0;
  level notify("karma_outro_begin");
  flag_set("block_input");
  maps\_so_rts_support::hide_player_hud();

  if(!flag("screen_fade_out_end"))
    thread screen_fade_out(0.2);

  if(flag("fps_mode"))
    level.rts.player maps\_so_rts_ai::restorereplacement();
  else
    level.rts.player clearclientflag(3);

  wait 0.2;

  if(isDefined(level.rts.karma)) {
    level.rts.karma delete();
    level.rts.karma = undefined;
  }

  if(isDefined(level.orange_outro_obj))
    level.orange_outro_obj delete();

  exploder(955);
  level.rts.player enableinvulnerability();
  outro_guy0 = simple_spawn_single("outro_guys", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  outro_guy0.animname = "outro_guy0";
  outro_guy1 = simple_spawn_single("outro_guys", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  outro_guy1.animname = "outro_guy1";
  sniper_guy = simple_spawn_single("outro_guys", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  sniper_guy.animname = "sniper_guy";
  level thread run_scene("outro_success_actors");
  level thread run_scene("outro_success_player");
  wait 0.5;
  thread screen_fade_in(0.5);
  thread socotra_outro_dialog();
  player_body = get_model_or_models_from_scene("outro_success_player", "player_body");
  player_body attach("t6_wpn_ar_xm8_world", "tag_weapon");
  flag_wait("socotra_success_fadeout");
  thread screen_fade_out(0.5);
}

socotra_outro_fail(alignnode) {
  level thread maps\createart\so_rts_mp_socotra_art::fail_igc();
  outro_guy0 = simple_spawn_single("outro_guys", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  outro_guy0.animname = "outro_fail_guy0";
  outro_guy1 = simple_spawn_single("outro_guys", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  outro_guy1.animname = "outro_fail_sniper";
  level thread run_scene("outro_fail");
  flag_wait("outro_fail" + "_started");
  wait 0.5;
  thread screen_fade_in(0.5);
  exploder(950);
  flag_wait("socotra_fail_fadeout");
  screen_fade_out(0.5);
  wait 0.05;
  ent = getent("outro_fail_heli1", "targetname");

  if(isDefined(ent))
    ent delete();

  ent = getent("outro_fail_heli2", "targetname");

  if(isDefined(ent))
    ent delete();

  stop_exploder(950);
}

create_anim_model(pos, model_name, animname) {
  model = spawn("script_model", pos);
  model setmodel(model_name);
  model.animname = animname;
  model hide();
  return model;
}

#using_animtree("player");

create_player_model(pos, model_name, animname) {
  model = create_anim_model(pos, model_name, animname);
  model useanimtree(#animtree);
  return model;
}

#using_animtree("animated_props");

create_prop_model(pos, model_name, animname) {
  model = create_anim_model(pos, model_name, animname);
  model useanimtree(#animtree);
  return model;
}

#using_animtree("vehicles");

create_veh_model(pos, model_name, animname) {
  model = create_anim_model(pos, model_name, animname);
  model useanimtree(#animtree);
  return model;
}

socotra_setup_devgui() {
  setdvar("cmd_skipto", "");
  adddebugcommand("devgui_cmd \"|RTS|/Socotra:10/Skipto:1/Rescue Karma:1\" \"cmd_skipto defend\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Socotra:10/Skipto:1/Mission Win:2\" \"cmd_skipto win\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Socotra:10/Skipto:1/MissionLose:3\" \"cmd_skipto fail\"\n");
  level thread socotra_watch_devgui();
}

socotra_watch_devgui() {
  while(true) {
    cmd_skipto = getdvar(#"_id_4D60CDD2");

    if(cmd_skipto == "defend") {
      flag_set("vtol_is_ready_for_player");
      level notify("rts_player_damaged");
      wait 0.05;
      level notify("safehouse_clear");
      wait 0.05;
      level notify("safehouse_clear");
      wait 0.05;
      level notify("safehouse_clear");
      wait 0.05;
      level notify("socotra_karma_rescued");
      setdvar("cmd_skipto", "");
    } else if(cmd_skipto == "win") {
      level thread maps\_so_rts_rules::mission_complete(1);
      setdvar("cmd_skipto", "");
    } else if(cmd_skipto == "fail") {
      level thread maps\_so_rts_rules::mission_complete(0);
      setdvar("cmd_skipto", "");
    }

    wait 0.05;
  }

}

socotravoxlist(team, unit) {
  if(!isDefined(unit))
    unit = "";

  guys = [];

  if(unit == "alpha") {
    min = 0;
    max = 2;
  } else if(unit == "kilo") {
    min = 3;
    max = 5;
  } else {
    min = 0;
    max = 2;
  }

  for(i = min; i <= max; i++) {
    voxid = "so" + i;

    if(isDefined(level.rts.voxids["allies"][voxid]))
      guys[guys.size] = level.rts.voxids["allies"][voxid];
  }

  return guys;
}

socotravoxalloc(entity) {
  pkg_ref = level.rts.squads[entity.squadid].pkg_ref.ref;

  if(pkg_ref == "infantry_ally_reg_pkg")
    unit = "alpha";
  else if(pkg_ref == "infantry_ally_reg2_pkg")
    unit = "kilo";
  else
    return;

  if(unit == "alpha") {
    min = 0;
    max = 2;
  } else if(unit == "kilo") {
    min = 3;
    max = 5;
  } else
    return;

  for(i = min; i <= max; i++) {
    voxid = "so" + i;

    if(!isDefined(level.rts.voxids["allies"][voxid])) {
      level.rts.voxids["allies"][voxid] = self;
      self.voxid = voxid;
      self thread maps\_so_rts_event::voxdeallocatewatch();
      return;
    }
  }
}

socotra_nextavailunit(nextsquad, playerdied) {
  possibles = [];
  allysquads = getteamsquads(level.rts.player.team);

  for(i = 0; i < allysquads.size; i++) {
    if(allysquads[i].members.size == 0) {
      continue;
    }
    if(!(isDefined(allysquads[i].selectable) && allysquads[i].selectable)) {
      continue;
    }
    if(allysquads[i].pkg_ref.squad_type != "infantry") {
      continue;
    }
    foreach(guy in allysquads[i].members) {
      if(maps\_so_rts_ai::ai_istakeoverpossible(guy))
        possibles[possibles.size] = guy;
    }
  }

  if(possibles.size > 0 && isDefined(level.rts.karma) && (isDefined(level.rts.karma.rescued) && level.rts.karma.rescued)) {
    best = getclosestinarray(level.rts.karma.origin, possibles);
    level thread squadselectnextaiandtakeover(best.squadid, playerdied, best);
  } else {
    if(!isDefined(nextsquad))
      nextsquad = maps\_so_rts_squad::getnextvalidsquad();
    else {
      maps\_so_rts_squad::removedeadfromsquad(nextsquad);

      if(!(isDefined(level.rts.squads[nextsquad].selectable) && level.rts.squads[nextsquad].selectable))
        nextsquad = maps\_so_rts_squad::getnextvalidsquad();
    }

    if(nextsquad != -1)
      level thread squadselectnextaiandtakeover(nextsquad, playerdied);
    else {
      maps\_so_rts_event::trigger_event("died_all_pkgs");
      level.rts.lastfpspoint = level.rts.player.origin;
      level thread player_eyeinthesky();
      self.ally = undefined;
    }
  }
}

watch_quad_death() {
  self waittill("death", attacker, param2, weapon, v_loc, v_dir, dmg_type, param7, param8, param9);

  if(isplayer(attacker))
    level notify("player_killed_quad", level.player maps\_so_rts_support::get_player_rts_mode(), dmg_type);
  else if(self.team == "axis")
    level notify("ally_killed_quad", self, attacker);
}

setup_challenges() {
  self thread maps\_so_rts_support::track_unit_type_usage();
  add_spawn_function_veh_by_type("heli_quadrotor_rts", ::watch_quad_death);
  level.callbackactorkilled = maps\_so_rts_challenges::global_actor_killed_challenges_callback;
  level.rts.kill_stats = spawnstruct();
  level.rts.kill_stats.total_kills = 0;
  level.rts.kill_stats.explosive_kills = 0;
  level.rts.kill_stats.headshot_kills = 0;
  level.rts.kill_stats.melee_kills = 0;
  level.rts.kill_stats.chloe_kills = 0;
  level.rts.kill_stats.explosive_car_kills = 0;
  level.rts.kill_stats.vtol_kills = 0;
  level.rts.kill_stats.explosive_kills_total = 15;
  level.rts.kill_stats.headshot_kills_total = 15;
  level.rts.kill_stats.melee_kills_total = 10;
  level.rts.kill_stats.chloe_kills_total = 10;
  level.rts.kill_stats.explosive_car_kills_total = 5;
  level.rts.kill_stats.vtol_kills_total = 10;
  self maps\_challenges_sp::register_challenge("EXPLOSIVE_KILLS");
  self maps\_challenges_sp::register_challenge("HEADSHOTS");
  self maps\_challenges_sp::register_challenge("MELEE_KILLS");
  self maps\_challenges_sp::register_challenge("CHLOE_KILLS");
  self maps\_challenges_sp::register_challenge("EXPLOSIVE_CAR_KILLS");
  self maps\_challenges_sp::register_challenge("VTOL_KILLS");
  self maps\_challenges_sp::register_challenge("KILL_QUADS", ::challenge_quads_killed);
  self maps\_challenges_sp::register_challenge("TIME", ::challenge_time_limit);
  self maps\_challenges_sp::register_challenge("EXTRACT_TIME", ::challenge_extract_time_limit);
  self maps\_challenges_sp::register_challenge("TACTICAL", maps\_so_rts_support::challenge_tactical);
}

challenge_quads_killed(str_notify) {
  while(true) {
    level waittill("player_killed_quad");
    self notify(str_notify);
  }
}

challenge_time_limit(str_notify) {
  flag_wait("rts_start_clock");
  start_time = gettime();
  flag_wait("found_hvt");
  play_time = gettime() - start_time;
  seconds_played = play_time / 1000;

  if(seconds_played < 90)
    self notify(str_notify);
}

challenge_extract_time_limit(str_notify) {
  flag_wait("found_hvt");
  start_time = gettime();
  level waittill("mission_complete", success);

  if(!success) {
    return;
  }
  play_time = gettime() - start_time;
  seconds_played = play_time / 1000;

  if(seconds_played < 60)
    self notify(str_notify);
}