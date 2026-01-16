/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\so_rts_mp_drone_s1.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_audio;
#include maps\_music;
#include maps\_anim;
#include maps\_statemachine;
#include maps\_quadrotor;
#include maps\_metal_storm;
#include maps\_claw;
#include maps\_cic_turret;
#include maps\_so_rts_support;
#include maps\_so_rts_rules;
#include maps\_so_rts_catalog;
#include maps\_so_rts_squad;
#include maps\_so_rts_event;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_so_rts_poi;
#include maps\_so_rts_main;
#include maps\_jetpack_ai;
#include maps\_so_rts_ai;
#include maps\createart\so_rts_mp_drone_art;
#include maps\_so_rts_challenges;
#include maps\_challenges_sp;

precache() {
  level._effect["network_intruder_death"] = loadfx("explosions/fx_rts_exp_hack_device");
  level._effect["network_intruder_blink"] = loadfx("misc/fx_equip_light_red");
  level._effect["jetwing_exhaust"] = loadfx("vehicle/exhaust/fx_rts_drone_exhaust_jetpack");
  level._effect["jetwing_exhaust"] = loadfx("vehicle/exhaust/fx_rts_drone_exhaust_jetpack");
  level._effect["hawk1_hit"] = loadfx("destructibles/fx_quadrotor_damagestate04");
  level._effect["hawk1_explosion"] = loadfx("destructibles/fx_quadrotor_death01");
  level._effect["hawk1_explosion_impact"] = loadfx("destructibles/fx_quadrotor_crash01");
  level._effect["hawk2_explosion"] = loadfx("destructibles/fx_quadrotor_crash01");
  level._effect["player_intro_face_fx"] = loadfx("bio/player/fx_rts_drone_speed_visual");
  level._effect["rts_suitcase_bomb_emp"] = loadfx("weapon/emp/fx_emp_rts_grenade_exp");
  level._effect["kard_fake_flash"] = loadfx("weapon/muzzleflashes/fx_heavy_flash_base");
  level._effect["outro_emp_blink"] = loadfx("light/fx_rts_light_emp_blink");
  precacheshader("compass_a10");
  level.rts.intrudermodel = "t6_wpn_emp_device_world";
  precachemodel(level.rts.intrudermodel);
  precachemodel("fxanim_gp_vtol_drop_asd_drone_mod");
  precachemodel("fxanim_gp_vtol_drop_claw_mod");
  precachemodel("fxanim_gp_parachute_jetpack_mod");
  precachestring(&"SO_RTS_MP_DRONE_SHIELD_OFFLINE");
  precachestring(&"SO_RTS_MP_DRONE_ENEMY_ARRIVE");
  precachestring(&"SO_RTS_MP_DRONE_REMAINING");
  precachestring(&"SO_RTS_MP_DRONE_ELECTRIC_DAMAGE");
  precachestring(&"SO_RTS_MP_DRONE_TANK_DAMAGE");
  precachestring(&"SO_RTS_MP_DRONE_DISH_DAMAGE");
  precachestring(&"SO_RTS_MP_DRONE_MAINFRAME_DAMAGE");
  precachestring(&"SO_RTS_MP_DRONE_DEFEND");
  precachestring(&"hud_update_vehicle_custom");
  precachestring(&"cctv_hud");
  precachemodel("t6_wpn_turret_sentry_gun_monsoon_yellow");
  precachemodel("t6_wpn_turret_sentry_gun_monsoon_red");
  precachemodel("p6_drone_gas_silo_dmg");
  precachemodel("parachute_player_animated_noshadow");
  maps\_quadrotor::init();
  maps\_metal_storm::init();
  maps\_claw::init();
  maps\_cic_turret::init();
}

drone_level_scenario_one() {
  level.custom_introscreen = maps\_so_rts_support::custom_introscreen;
  level.rts.codespawncb = ::dronecodespawner;
  level.rts.use_random_drop_path = 1;
  flag_init("intro_done");
  flag_init("outro_done");
  flag_init("factory_breached");
  maps\_so_rts_rules::set_gamemode("drone1");
  setup_scenes();
  thread drone_geo_changes();
  level thread floor_watch();
  flag_wait("all_players_connected");
  flag_wait("start_rts");
  maps\_so_rts_support::hide_player_hud();
  setupmissileboundary();
  level.rts.missile_oob_check = ::drone_missile_oob_check;
  level thread maps\_so_rts_support::player_oobwatch();

  drone_setup_devgui();

  thread setup_objectives();
  level.player thread setup_challenges();
  thread setup_poi_fx();
  dish_poi = getpoibyref("rts_poi_dish");
  e_streamer_hint = createstreamerhint(dish_poi.entity.origin, 1.0);
  maps\_so_rts_support::level_create_turrets(1);
  maps\_so_rts_catalog::spawn_package("infantry_ally_reg2_pkg", "allies", 1);
  luinotifyevent(&"rts_add_squad", 3, maps\_so_rts_squad::createsquad(level.rts.allied_center.origin, "allies", maps\_so_rts_catalog::package_getpackagebytype("turret_pkg")), maps\_so_rts_catalog::package_getpackagebytype("turret_pkg").idx, 0);
  wait 0.05;
  maps\_so_rts_catalog::spawn_package("turret_pkg", "allies", 1);
  maps\_so_rts_catalog::spawn_package("infantry_ally_reg_pkg", "allies", 1);
  maps\_so_rts_catalog::spawn_package("bigdog_pkg", "allies", 1, ::drone_level_player_startfps);
  maps\_so_rts_catalog::setpkgdelivery("infantry_ally_reg_pkg", "CODE");
  maps\_so_rts_catalog::setpkgdelivery("bigdog_pkg", "CARGO_VTOL");
  squad = getsquadbypkg("bigdog_pkg", "allies");
  level thread maps\_so_rts_squad::removesquadmarker(squad.id, 1);
  flag_set("rts_event_ready");
  maps\_so_rts_event::trigger_event("main_music_state");
  maps\_so_rts_event::trigger_event("dlg_intro_onground");
  level.rts.game_rules.num_nag_squads = 1;
  flag_wait("intro_done");
  e_streamer_hint delete();
  level thread drone_ai_takeover_on();
  level thread drone_ai_takeover_off();
  level thread drone_badplace_auto();
  level thread drone_intruderwatch();
  thread maps\_so_rts_support::time_countdown(1, level, undefined, undefined, undefined, "SO_RTS_MP_DRONE_ENEMY_ARRIVE", 0);
  wait 35;
  flag_set("start_rts_enemy");
  wait 25;
  time_countdown_delete();
  wait 1;

  switch (getdifficulty()) {
    case "easy":
    case "medium":
      time = 10;
      break;
    case "hard":
      time = 11;
      break;
    case "fu":
      time = 12;
      break;
  }

  thread maps\_so_rts_support::time_countdown(time, level, undefined, undefined, "mission_timer_expired", "SO_RTS_MP_DRONE_DEFEND", 0);
  flag_set("rts_start_clock");
  enemyspawninit();
  level waittill("mission_timer_expired");
  time_countdown_delete();
  mainframe_poi = getpoibyref("rts_poi_mainframe");
  mainframe_poi.block_intruder = 1;

  foreach(intruder in level.rts.networkintruders["axis"]) {
    if(isDefined(intruder))
      intruder dodamage(intruder.health + 999, intruder.origin);
  }

  level notify("end_enemy_player");
  level thread outofenemy_watch();
}

drone_intruderwatch() {
  while(!flag("rts_game_over")) {
    level waittill("intruder_planted", device);

    if(device.team == "axis")
      maps\_so_rts_event::trigger_event("dlg_emp_placed" + flag("fps_mode") ? "_fps" : "");
  }
}

outofally_watch() {
  while(!flag("rts_game_over")) {
    if(maps\_so_rts_catalog::package_getnumteamresources("allies") == 0) {
      level thread maps\_so_rts_rules::mission_complete(0);
      return;
    }

    wait 1;
  }
}

emp_and_die() {
  self endon("death");
  self dodamage(5, self.origin, level.rts.player, undefined, "explosive", "none", "emp_grenade_sp");
  wait(randomintrange(1, 5));
  self kill();
}

kill_transport() {
  locs = sortarraybyclosest(self.origin, getstructarray("retreat_loc", "targetname"), undefined, undefined, 1);
  self maps\_vehicle::getoffpath();
  self setvehgoalpos(locs[0].origin);
  self waittill("goal");

  if(isDefined(self.cargo))
    self.cargo delete();

  self delete();
}

kill_transports() {
  transports = getentarray("transport", "script_noteworthy");
  retreatlocs = getstructarray("retreat_loc", "targetname");

  foreach(transport in transports) {
    if(!(isDefined(transport.unloading_cargo) && transport.unloading_cargo))
      transport thread kill_transport();
  }

  while(transports.size > 0) {
    transports = getentarray("transport", "script_noteworthy");
    level waittill("unloaded");
    squad = getsquadbypkg("quadrotor_pkg", "axis");

    foreach(dude in squad.members)
    dude thread emp_and_die();

    squad = getsquadbypkg("bigdog_pkg", "axis");

    foreach(dude in squad.members) {
      dude.overrideactordamageorig = undefined;
      dude thread emp_and_die();
    }

    squad = getsquadbypkg("metalstorm_pkg", "axis");

    foreach(dude in squad.members)
    dude thread emp_and_die();
  }
}

dieinnseconds(time) {
  self endon("death");
  wait(time);
  self kill();
}

outofenemy_watch() {
  thread kill_transports();
  luinotifyevent(&"rts_update_hint_text", 2, istring("SO_RTS_MP_DRONE_REMAINING"), 60);
  maps\_so_rts_catalog::setpkgqty("bigdog_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("metalstorm_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("quadrotor_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg2_pkg", "axis", 0);
  squad = getsquadbypkg("quadrotor_pkg", "axis");

  foreach(dude in squad.members)
  dude thread emp_and_die();

  squad = getsquadbypkg("bigdog_pkg", "axis");

  if(isDefined(squad)) {
    foreach(dude in squad.members) {
      dude.overrideactordamageorig = undefined;
      dude thread emp_and_die();
    }
  }

  squad = getsquadbypkg("metalstorm_pkg", "axis");

  if(isDefined(squad)) {
    foreach(dude in squad.members)
    dude thread emp_and_die();
  }

  enemies = [];
  squad = getsquadbypkg("infantry_enemy_elite_pkg", "axis");
  enemies = arraycombine(enemies, squad.members, 0, 0);
  squad = getsquadbypkg("infantry_enemy_reg_pkg", "axis");
  enemies = arraycombine(enemies, squad.members, 0, 0);
  squad = getsquadbypkg("infantry_enemy_reg2_pkg", "axis");
  enemies = arraycombine(enemies, squad.members, 0, 0);

  foreach(guy in enemies) {
    if(isDefined(guy))
      guy thread dieinnseconds(60);
  }

  failsafetimer = gettime() + 62000;

  while(!flag("rts_game_over")) {
    if(maps\_so_rts_catalog::package_getnumteamresources("axis") == 0 || gettime() > failsafetimer) {
      level thread maps\_so_rts_rules::mission_complete(1);
      return;
    }

    wait 1;
  }
}

floor_watch() {
  level.rts_floor = getent("overwatch_floor", "targetname");
  level.rts.trace_ents[level.rts.trace_ents.size] = level.rts_floor;

  while(isDefined(level.rts_floor)) {
    level.rts_floor hide();
    level waittill("rts_ON");

    if(isDefined(level.rts_floor))
      level.rts_floor show();

    level waittill("rts_OFF");
  }
}

objective_damage_warning(poi, thresh) {
  maxhealth = poi.entity.health;

  while(poi.entity.health > 0) {
    poi.entity waittill("damage", damage, attacker, direction_vec, point, type);
    curpercent = poi.entity.health / maxhealth * 100;

    if(curpercent < thresh && !isDefined(poi.warning)) {
      poi.warning = 1;
      maps\_so_rts_event::trigger_event("dlg_" + poi.ref + "_hurt" + flag("fps_mode") ? "_fps" : "");

      switch (poi.ref) {
        case "rts_poi_eletrical_transformer":
          thread maps\_glasses::add_visor_text("SO_RTS_MP_DRONE_ELECTRIC_DAMAGE", 10, "orange", undefined, 1);
          thread play_looping_visor_text_audio();
          break;
        case "rts_obj_silo":
          thread maps\_glasses::add_visor_text("SO_RTS_MP_DRONE_TANK_DAMAGE", 10, "orange", undefined, 1);
          thread play_looping_visor_text_audio();
          break;
        case "rts_poi_dish":
          thread maps\_glasses::add_visor_text("SO_RTS_MP_DRONE_DISH_DAMAGE", 10, "orange", undefined, 1);
          thread play_looping_visor_text_audio();
          break;
        case "rts_poi_mainframe":
          thread maps\_glasses::add_visor_text("SO_RTS_MP_DRONE_MAINFRAME_DAMAGE", 10, "orange", undefined, 1);
          break;
      }
    } else
      maps\_so_rts_event::trigger_event("dlg_" + poi.ref + "_dmg" + flag("fps_mode") ? "_fps" : "");

    if(damage > poi.entity.health) {
      break;
    }
  }

  maps\_so_rts_event::trigger_event("dlg_" + poi.ref + "_died" + flag("fps_mode") ? "_fps" : "");
}

objective_damage_snd_loopers(poi, num) {
  poi.entity.snddamage = 0;

  while(poi.entity.health > 0) {
    poi.entity waittill("damage", damage, attacker, direction_vec, point, type);

    if(poi.entity.snddamage == 0) {
      poi.entity.snddamage = 1;
      rpc("clientscripts/so_rts_mp_drone_amb", "setPOIAlarms", 1, num);
    }

    poi.entity thread snddamagelooptimer(num);
  }

  rpc("clientscripts/so_rts_mp_drone_amb", "setPOIAlarms", 0, num);
}

snddamagelooptimer(num) {
  self notify("sndDamageTimer");
  self endon("sndDamageTimer");
  self endon("death");
  wait 3;
  self.snddamage = 0;
  rpc("clientscripts/so_rts_mp_drone_amb", "setPOIAlarms", 0, num);
}

play_looping_visor_text_audio() {
  ent = spawn("script_origin", (0, 0, 0));
  ent playloopsound("evt_warning_text", 0.1);
  wait 10;
  ent delete();
}

setup_objectives() {
  level.rts.player endon("expired");
  level thread maps\_objectives::init();
  level.obj_defend = register_objective(&"SO_RTS_MP_DRONE_OBJ_DEFEND");
  level.obj_defend_comm = register_objective(&"SO_RTS_MP_DRONE_DEFEND_COMM");
  level.obj_defend_power = register_objective(&"SO_RTS_MP_DRONE_DEFEND_POWER");
  level.obj_defend_tank = register_objective(&"SO_RTS_MP_DRONE_DEFEND_TANK");
  level.obj_defend_computer = register_objective(&"SO_RTS_MP_DRONE_DEFEND_COMPUTER");
  level.rts.game_rules.time_return_val = 1;
  flag_wait("intro_done");
  maps\_so_rts_poi::poi_setobjectivenumber("rts_poi_dish", level.obj_defend_comm, "waypoint_defend_a");
  maps\_so_rts_poi::poi_setobjectivenumber("rts_poi_eletrical_transformer", level.obj_defend_power, "waypoint_defend_b");
  maps\_so_rts_poi::poi_setobjectivenumber("rts_obj_silo", level.obj_defend_tank, "waypoint_defend_c");
  mainframe_poi = getpoibyref("rts_poi_mainframe");
  dish_poi = getpoibyref("rts_poi_dish");
  electric_poi = getpoibyref("rts_poi_eletrical_transformer");
  tank_poi = getpoibyref("rts_obj_silo");
  mainframe_poi.ignoreme = 1;
  level thread objective_damage_warning(mainframe_poi, 45);
  level thread objective_damage_warning(dish_poi, 45);
  level thread objective_damage_warning(electric_poi, 45);
  level thread objective_damage_warning(tank_poi, 45);
  level thread objective_damage_snd_loopers(tank_poi, 2);
  level thread objective_damage_snd_loopers(dish_poi, 1);
  level thread objective_damage_snd_loopers(electric_poi, 3);
  luinotifyevent(&"rts_del_poi", 1, mainframe_poi.entity getentitynumber());
  set_objective(level.obj_defend);
  wait 5;
  set_objective(level.obj_defend_power);
  wait 5;
  set_objective(level.obj_defend_comm);
  wait 5;
  set_objective(level.obj_defend_tank);
  wait 5;
  level.m_lost_objectives = 0;

  while(level.rts.poi.size) {
    level waittill("poi_captured_axis", ref);
    level.m_lost_objectives++;

    switch (ref) {
      case "rts_poi_eletrical_transformer":
        set_objective(level.obj_defend_power, undefined, "failed");
        break;
      case "rts_obj_silo":
        set_objective(level.obj_defend_tank, undefined, "failed");
        tank_poi.entity setmodel("p6_drone_gas_silo_dmg");
        break;
      case "rts_poi_dish":
        set_objective(level.obj_defend_comm, undefined, "failed");

        if(level.m_lost_objectives < 3) {
        }

        break;
      case "rts_poi_mainframe":
        set_objective(level.obj_defend_computer, undefined, "failed");
        set_objective(level.obj_defend, undefined, "failed");

        while(isDefined(level.rts.switch_trans))
          wait 0.05;

        maps\_so_rts_rules::mission_complete(0);
        break;
    }

    level.rts.game_rules.num_nag_squads = level.rts.game_rules.num_nag_squads + 2;
    level.rts.poi_ideal = level.rts.poi_ideal + 3;

    if(level.m_lost_objectives == 2) {
      maps\_so_rts_event::trigger_event("dlg_doors_down_fps");
      maps\_so_rts_event::trigger_event("dlg_doors_down");
      turrets = getentarray("turret_loc_friendly_inside", "targetname");

      foreach(turret in turrets)
      turret.targetname = "turret_loc_friendly";

      thread maps\_so_rts_support::level_create_turrets(1);
      pkg_ref = package_getpackagebytype("turret_pkg");
      ai_ref = level.rts.ai[pkg_ref.units[0]];
      tursquad = getsquadbypkg("turret_pkg", "allies");
      level notify("removeSquadMarker" + tursquad.id);

      for(tospawn = turrets.size; tospawn; tospawn--) {
        level waittill("turret_created", turret);
        turret.ai_ref = ai_ref;
        turret maps\_so_rts_squad::addaitosquad(tursquad.id);
      }

      wait 0.1;
      maps\_so_rts_catalog::units_delivered("allies", tursquad.id);
      level thread maps\_so_rts_squad::removesquadmarker(tursquad.id, 1);
      mainframe_poi.ignoreme = 0;

      foreach(door in level.laser_doors) {
        door connectpaths();
        door delete();
      }

      level.laser_doors = [];
      squad1 = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg_pkg", "allies");
      squad2 = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg2_pkg", "allies");
      maps\_so_rts_squad::ordersquaddefend(mainframe_poi.entity.origin, squad1.id);
      maps\_so_rts_squad::ordersquaddefend(mainframe_poi.entity.origin, squad2.id);

      foreach(poi in level.rts.poi) {
        if(poi.ref == "rts_poi_mainframe") {
          continue;
        }
        if(isDefined(poi.entity)) {
          luinotifyevent(&"rts_del_poi", 1, poi.entity getentitynumber());
          maps\_so_rts_poi::poicaptured(poi.entity, "axis");
        }
      }

      luinotifyevent(&"rts_add_poi", 2, mainframe_poi.entity getentitynumber(), mainframe_poi.poinum);
      luinotifyevent(&"rts_defend_poi", 1, mainframe_poi.entity getentitynumber());
      set_objective(level.obj_defend_computer);
      maps\_so_rts_poi::poi_setobjectivenumber("rts_poi_mainframe", level.obj_defend_computer, "waypoint_defend_d");
      flag_set("factory_breached");
      spots = getentarray("base_event_disconnect", "targetname");

      foreach(spot in spots) {
        radius = isDefined(spot.radius) ? spot.radius : spot.script_parameters;
        nodes = getnodesinradius(spot.origin, spot.radius, 0);

        foreach(node in nodes)
        deletepathnode(node);
      }

      array_thread(spots, ::spot_delete);
      thread maps\_glasses::add_visor_text("SO_RTS_MP_DRONE_SHIELD_OFFLINE", 10, "orange", undefined, 1);
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_elite_pkg");
      pkg_ref.min_axis = 6;
      pkg_ref.max_axis = 6;
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_reg_pkg");
      pkg_ref.min_axis = 6;
      pkg_ref.max_axis = 6;
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("infantry_enemy_reg2_pkg");
      pkg_ref.min_axis = 4;
      pkg_ref.max_axis = 4;
      pkg_ref = maps\_so_rts_catalog::package_getpackagebytype("quadrotor_pkg");
      pkg_ref.min_axis = 8;
      pkg_ref.max_axis = 10;
      maps\_so_rts_catalog::setpkgdelivery("infantry_ally_reg_pkg", "CODE");
      rpc("clientscripts/so_rts_mp_drone_amb", "setFinalAlarms");
    }
  }
}

spot_delete() {
  self delete();
}

setup_poi_fx() {
  level thread watch_poi_exploder("rts_poi_mainframe", 230);
  level thread watch_poi_exploder("rts_poi_dish", 205);
  level thread watch_poi_exploder("rts_poi_eletrical_transformer", 210, 0.5);
  level thread watch_poi_exploder("rts_poi_eletrical_transformer", 211, 1.0);
  level thread watch_poi_exploder("rts_obj_silo", 220, 0.5, 2.0, 221);
  level thread watch_poi_exploder("rts_obj_silo", 222, 1.0);
  level thread run_dish_fx();
}

run_dish_fx() {
  poi = getpoibyref("rts_poi_dish");

  while(poi get_poi_taken_pct() < 0.3)
    poi.entity waittill("damage");

  poi.entity play_fx("rts_poi_dish_smk_dmg", poi.entity.origin, poi.entity.angles, "kill_dish_fx");

  while(poi get_poi_taken_pct() < 1.0)
    poi.entity waittill("damage");

  poi.entity play_fx("rts_poi_dish_dmg", poi.entity.origin, poi.entity.angles, "kill_dish_fx");
}

get_poi_taken_pct(do_wait) {
  if(!isDefined(do_wait))
    do_wait = 0;

  taken_pct = 1.0;

  if(self.capture_time > 0 && isDefined(self.dominate_weight))
    taken_pct = 1.0 - self.dominate_weight / self.capture_time;
  else
    taken_pct = 1.0 - self.entity.health / self.entity.maxhealth;

  taken_pct = clamp(taken_pct, 0.0, 1.0);
  return taken_pct;
}

watch_poi_exploder(poi_name, exploder_num, fire_at_pct, chain_delay, exploder2, exploder3) {
  if(!isDefined(fire_at_pct))
    fire_at_pct = 1.0;

  if(!isDefined(chain_delay))
    chain_delay = 2.0;

  if(!isDefined(exploder2))
    exploder2 = undefined;

  if(!isDefined(exploder3))
    exploder3 = undefined;

  poi = getpoibyref(poi_name);

  while(poi get_poi_taken_pct() < fire_at_pct) {
    if(poi.capture_time > 0 && isDefined(poi.dominate_weight))
      wait 0.05;
    else
      poi.entity waittill("damage");
  }

  exploder(exploder_num);

  if(isDefined(exploder2)) {
    wait(chain_delay);
    exploder(exploder2);
  }

  if(isDefined(exploder3)) {
    wait(chain_delay);
    exploder(exploder3);
  }
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

setup_scenes() {
  level.scr_anim["generic"]["jump_over_wall_drone"] = % ai_mantle_over_96_dro;
  level.scr_anim["chute"]["chute_guy0"] = % fxanim_war_parachute_jetpack01_anim;
  level.scr_anim["chute"]["chute_guy1"] = % fxanim_war_parachute_jetpack02_anim;
  add_scene("drone_intro", "intro_loc");
  add_player_anim("player_body", % p_war_drones_intro_player_new, 1, 0, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  add_notetrack_flag("player_body", "fade_in", "drone_intro_fadein");
  add_notetrack_exploder("player_body", "land", 241);
  add_notetrack_flag("player_body", "land", "drone_player_landed");
  add_prop_anim("jetpack_player", % o_war_drones_intro_player_parachute, "parachute_player_animated_noshadow", 1);
  add_actor_anim("guy0", % ch_war_drones_intro_seal_1, 0, 0, 0, 1);
  addnotetrack_customfunction("guy0", "deploy_chute", ::jetpack_deploy_chute_guy0);
  add_actor_anim("guy1", % ch_war_drones_intro_seal_2, 0, 0, 0, 1);
  addnotetrack_customfunction("guy1", "deploy_chute", ::jetpack_deploy_chute_guy1);
  add_prop_anim("jetpack_guy0", % v_war_drones_intro_seal_1_jetpack, "veh_t6_air_jetpack", 1);
  add_prop_anim("jetpack_guy1", % v_war_drones_intro_seal_2_jetpack, "veh_t6_air_jetpack", 1);
  add_scene("drone_outro_success", "intro_loc");
  add_player_anim("player_body", % p_war_drones_outro_succeed_cameraview, 1, 0, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  addnotetrack_customfunction("player_body", "fire", ::drone_outro_player_fire);
  add_notetrack_flag("player_body", "fade_in", "drone_success_fadein");
  add_notetrack_flag("player_body", "fade_out", "drone_success_fadeout");
  add_vehicle_anim("outro_succeed_heli_1", % v_war_drones_outro_succeed_heli_1, 0, undefined, undefined, undefined, "heli_blackhawk_rts_axis");
  add_vehicle_anim("outro_succeed_heli_2", % v_war_drones_outro_succeed_heli_2, 0, undefined, undefined, undefined, "heli_blackhawk_rts_axis");
  add_vehicle_anim("outro_succeed_heli_3", % v_war_drones_outro_succeed_heli_3, 0, undefined, undefined, undefined, "heli_blackhawk_rts_axis");
  add_vehicle_anim("outro_succeed_heli_4", % v_war_drones_outro_succeed_heli_4, 0, undefined, undefined, undefined, "heli_blackhawk_rts_axis");
  add_vehicle_anim("outro_succeed_vtol_1", % v_war_drones_outro_succeed_vtol_1, 0, undefined, undefined, undefined, "heli_osprey_rts_axis");
  add_vehicle_anim("outro_succeed_vtol_2", % v_war_drones_outro_succeed_vtol_2, 0, undefined, undefined, undefined, "heli_osprey_rts_axis");
  add_vehicle_anim("outro_succeed_vtol_3", % v_war_drones_outro_succeed_vtol_3, 0, undefined, undefined, undefined, "heli_osprey_rts_axis");
  add_vehicle_anim("outro_quad_1", % v_war_drones_outro_succeed_hawk_1, 0, undefined, undefined, undefined, "heli_quadrotor_rts");
  add_notetrack_fx_on_tag("outro_quad_1", "hit", "hawk1_hit", "tag_origin");
  add_notetrack_fx_on_tag("outro_quad_1", "explosion", "hawk1_explosion", "tag_origin");
  add_notetrack_fx_on_tag("outro_quad_1", "ground_impact_explosion", "hawk1_explosion_impact", "tag_origin");
  add_vehicle_anim("outro_quad_2", % v_war_drones_outro_succeed_hawk_2, 0, undefined, undefined, undefined, "heli_quadrotor_rts");
  add_notetrack_fx_on_tag("outro_quad_2", "explosion", "hawk2_explosion", "tag_origin");
  add_vehicle_anim("outro_quad_3", % v_war_drones_outro_succeed_hawk_3, 0, undefined, undefined, undefined, "heli_quadrotor_rts");
  add_actor_anim("guy1", % ch_war_drones_outro_succeed_seal_1, undefined, 1, undefined, 1, undefined, "ai_spawner_ally_assault_scripted");
  add_actor_anim("guy2", % ch_war_drones_outro_succeed_seal_2, undefined, 1, undefined, 1, undefined, "ai_spawner_ally_assault_scripted");
  add_actor_anim("guy3", % ch_war_drones_outro_succeed_seal_3, undefined, 1, undefined, 1, undefined, "ai_spawner_ally_assault_scripted");
  add_actor_anim("guy4", % ch_war_drones_outro_succeed_seal_4, undefined, 1, undefined, 1, undefined, "ai_spawner_ally_assault_scripted");
  add_actor_anim("guy5", % ch_war_drones_outro_succeed_seal_5, undefined, 1, undefined, 1, undefined, "ai_spawner_ally_assault_scripted");
  add_actor_anim("enemy1", % ch_war_drones_outro_succeed_enemy01, undefined, 1, undefined, undefined, undefined, "ai_spawner_enemy_assault_scripted");
  add_actor_anim("enemy2", % ch_war_drones_outro_succeed_enemy02, undefined, 1, undefined, undefined, undefined, "ai_spawner_enemy_assault_scripted");
  add_actor_anim("enemy3", % ch_war_drones_outro_succeed_enemy03, undefined, 1, undefined, undefined, undefined, "ai_spawner_enemy_assault_scripted");
  add_scene("drone_outro_fail", "outro_loc");
  add_player_anim("player_body", % p_war_drones_outro_fail_cameraview, 1, 0, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  addnotetrack_customfunction("player_body", "light_countdown", ::outro_emp_lights);
  add_notetrack_flag("player_body", "detonate", "drone_fail_fadeout");
  add_notetrack_flag("player_body", "emp_explosion", "drone_emp_explosion");
  addnotetrack_customfunction("player_body", "emp_explosion", ::outro_emp_explosion);
  addnotetrack_customfunction("player_body", "camera_shutdown", ::outro_camera_shutdown);
  add_notetrack_exploder("player_body", "emp_explosion", 565);
  add_prop_anim("briefcase_bomb", % o_war_drones_outro_fail_emp, "t6_wpn_emp_device_world", 0);
  add_actor_anim("enemy1", % ch_war_drones_outro_fail_enemy_1, undefined, 1, undefined, undefined, undefined, "ai_spawner_enemy_assault_scripted");
  add_actor_anim("enemy2", % ch_war_drones_outro_fail_enemy_2, undefined, 1, undefined, undefined, undefined, "ai_spawner_enemy_assault_scripted");
  precache_assets();
}

drone_level_player_startfps() {
  playerstart = getent("rts_player_start", "targetname");
  assert(isDefined(playerstart));
  nextsquad = maps\_so_rts_squad::getnextvalidsquad(undefined);
  assert(nextsquad != -1, "should not be -1, player squad should be created");

  foreach(guy in level.rts.squads[nextsquad].members) {
    if(isDefined(guy)) {
      guy.allow_oob = 1;
      guy.goalradius = 350;
    }

    if(isDefined(guy.manual_lui_add) && guy.manual_lui_add) {
      guy.manual_lui_add = undefined;
      luinotifyevent(&"rts_add_friendly_human", 5, guy getentitynumber(), guy.squadid, 35, 0, guy.pkg_ref.idx);
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
  level thread drone_startintro();
  nextsquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg_pkg", "allies");
  poi = maps\_so_rts_poi::getpoibyref("rts_poi_dish");
  maps\_so_rts_squad::ordersquaddefend(poi.entity.origin, nextsquad.id, 1);
  nextsquad = maps\_so_rts_squad::getsquadbypkg("infantry_ally_reg2_pkg", "allies");
  poi = maps\_so_rts_poi::getpoibyref("rts_obj_silo");
  maps\_so_rts_squad::ordersquaddefend(poi.entity.origin, nextsquad.id, 1);
  nextsquad = maps\_so_rts_squad::getsquadbypkg("bigdog_pkg", "allies");
  start = getstruct("bigdog_unit_start_point", "targetname");
  spot = getstruct("bigdog_unit_defend_point", "targetname");
  bigdog = nextsquad.members[0];
  maps\_so_rts_squad::ordersquaddefend(spot.origin, nextsquad.id, 1);
  flag_wait("intro_done");
  flag_clear("block_input");
  level.rts.player freezecontrols(0);
  level.rts.order_new_allysquadcb = ::order_new_allysquad;
  maps\_so_rts_event::trigger_event("dlg_intro_1min");
  level waittill("dlg_intro_1min_done");
  maps\_so_rts_event::trigger_event("dlg_intro_onground_fps");
  level waittill("dlg_intro_onground_fps_done");
  maps\_so_rts_event::trigger_event("dlg_intro_instruct1");
  maps\_so_rts_event::trigger_event("dlg_intro_instruct2");
}

order_new_allysquad(squadid) {
  foreach(guy in level.rts.squads[squadid].members)
  guy thread friendly_ai_think();
}

friendly_ai_think() {
}

intro_jetpack_wait(stagger) {
  self.takedamage = 0;
  self.ignoreme = 1;
  self.allow_oob = 1;
  self.no_takeover = 1;
  self.rts_unloaded = 0;
  self thread magic_bullet_shield();
  s_jetpack_entries = getstructarray("rts_ally_jetpack_entry_struct", "targetname");
  s_jetpack_entry = s_jetpack_entries[randomintrange(0, s_jetpack_entries.size)];
  self forceteleport(s_jetpack_entry.origin + vectorscale((0, 0, 1), 10000.0), (0, 0, 0));
  wait(2.5 * stagger);
  level thread maps\_jetpack_ai::create_jetpack_ai(s_jetpack_entry, self, 0);
  self waittill("landed");
  self.takedamage = 1;
  self.ignoreme = 0;
  self.rts_unloaded = 1;
  self.no_takeover = undefined;
  self.allow_oob = 0;

  if(isDefined(self.manual_lui_add) && self.manual_lui_add) {
    self.manual_lui_add = undefined;
    luinotifyevent(&"rts_add_friendly_human", 5, self getentitynumber(), self.squadid, 35, 0, self.pkg_ref.idx);
  }

  self thread stop_magic_bullet_shield();
}

dronecodespawner(pkg_ref, team, callback, squadid) {
  allies = getaiarray("allies");

  if(team == "allies") {
    if(pkg_ref.ref == "infantry_ally_reg_pkg") {
      if(isDefined(pkg_ref.incodespawn) && pkg_ref.incodespawn)
        return -1;

      pkg_ref.incodespawn = 1;
      squad = issquadalreadycreated("allies", pkg_ref);

      if(isDefined(squad)) {
        foreach(guy in squad.members) {
          if(isDefined(guy))
            guy.alreadyinsquad = 1;
        }
      }

      spot = getstruct("infantry_ally_inf_pkg_spawn_loc", "targetname");
      squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin, undefined, 1);
      newguys = [];

      if(isDefined(squad)) {
        foreach(guy in squad.members) {
          if(isDefined(guy)) {
            if(!(isDefined(guy.alreadyinsquad) && guy.alreadyinsquad) && isalive(guy))
              newguys[newguys.size] = guy;
          }
        }
      }

      for(i = 0; i < newguys.size; i++)
        newguys[i] thread intro_jetpack_wait(i);

      maps\_so_rts_squad::reissuesquadlastorders(squadid);
      pkg_ref.incodespawn = undefined;
    } else if(pkg_ref.ref == "infantry_ally_reg2_pkg") {
      spot = getstruct("infantry_ally_inf2_pkg_spawn_loc", "targetname");
      squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin, undefined, 1);
      maps\_so_rts_squad::reissuesquadlastorders(squadid);

      foreach(guy in level.rts.squads[squadid].members) {
        guy.allow_oob = 1;
        guy.unselectable = undefined;
      }
    } else if(pkg_ref.ref == "bigdog_pkg") {
      squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team);
      maps\_so_rts_squad::reissuesquadlastorders(squadid);
    } else if(pkg_ref.ref == "turret_pkg") {
      ai_ref = level.rts.ai[pkg_ref.units[0]];
      squadid = maps\_so_rts_squad::createsquad(level.rts.allied_center.origin, team, pkg_ref);
      level.rts.squads[squadid].no_show_marker = 1;
      level.rts.squads[squadid].no_group_commands = 1;
      level.rts.squads[squadid].no_move_commands = 1;
      turrets = getentarray("sentry_turret_friendly", "targetname");

      foreach(turret in turrets) {
        turret.ai_ref = ai_ref;
        turret maps\_so_rts_squad::addaitosquad(squadid);
      }

      maps\_so_rts_catalog::units_delivered(team, squadid);
    }
  } else if(pkg_ref.ref == "infantry_enemy_reg_pkg" || pkg_ref.ref == "infantry_enemy_reg2_pkg") {
    if(flag("rts_mode")) {
      unit = maps\_so_rts_catalog::allocatetransport(team, "helo", pkg_ref, maps\_so_rts_ai::spawn_ai_package_helo, callback);

      if(isDefined(unit)) {
        if(pkg_ref.qty[team] > 0)
          pkg_ref.qty[team]--;

        if(team == level.rts.player.team && pkg_ref.qty[team] >= 0)
          luinotifyevent(&"rts_update_remaining_count", 2, unit.squadid, pkg_ref.qty[team] > 0 ? pkg_ref.qty[team] : -1);

        return unit.squadid;
      }

      return -1;
    } else {
      spawnlocs = getstructarray("enemy_laststand_spawn_loc", "targetname");
      valid = [];

      foreach(loc in spawnlocs) {
        distsq = distancesquared(loc.origin, level.rts.player.origin);

        if(distsq > 640000)
          valid[valid.size] = loc;
      }

      spot = valid[randomint(valid.size)];
      squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, undefined, spot.origin);
      maps\_so_rts_squad::reissuesquadlastorders(squadid);

      if(isDefined(spot.script_noteworthy) && spot.script_noteworthy == "oob_on") {
        foreach(guy in level.rts.squads[squadid].members)
        guy.allow_oob = 1;
      }
    }
  } else
    assert(0, "unhandled code spawn");

  if(isDefined(callback))
    thread[[callback]](squadid);

  return squadid;
}

drone_startintro() {
  flag_wait("introscreen_complete");
  guys = getaiarray("allies");

  for(i = 0; i < guys.size; i++) {
    guys[i].animname = "guy" + i;
    guys[i].no_takeover = undefined;
  }

  level thread maps\createart\so_rts_mp_drone_art::intro_igc();
  level thread run_scene("drone_intro");
  flag_wait("drone_intro_started");
  level.player thread drone_intro_player_face_fx();
  flag_wait("drone_intro_fadein");
  level thread screen_fade_in(3.5);
  exploder(100);
  drone_intro_ais = get_ais_from_scene("drone_intro");

  foreach(drone_intro_ai in drone_intro_ais)
  drone_intro_ai.a.pose = "crouch";

  ai_jetpacks = [];
  ai_jetpacks[0] = get_model_or_models_from_scene("drone_intro", "jetpack_guy0");
  ai_jetpacks[1] = get_model_or_models_from_scene("drone_intro", "jetpack_guy1");

  foreach(ai_jetpack in ai_jetpacks)
  playfxontag(level._effect["jetwing_exhaust"], ai_jetpack, "tag_engine_fx");

  scene_wait("drone_intro");
  flag_set("intro_done");
  flag_set("rts_hud_on");
  maps\_so_rts_support::show_player_hud();
}

drone_intro_player_face_fx() {
  level endon("drone_intro_finished");
  player_body = get_model_or_models_from_scene("drone_intro", "player_body");
  player_body endon("death");

  while(!flag("drone_player_landed")) {
    playfxontag(level._effect["player_intro_face_fx"], player_body, "tag_camera");
    wait 0.2;
  }
}

#using_animtree("animated_props");

jetpack_deploy_chute_guy0(ai_jetpack) {
  m_chute = spawn("script_model", (0, 0, 0));
  m_chute setmodel("fxanim_gp_parachute_jetpack_mod");
  m_chute useanimtree(#animtree);
  m_chute endon("death");

  recordent(m_chute);

  align_struct = getstruct("intro_loc", "targetname");
  align_struct.angles = (0, 0, 0);
  align_struct maps\_anim::anim_single_aligned(m_chute, "chute_guy0", undefined, "chute", 0.0);
  m_chute delete();
}

jetpack_deploy_chute_guy1(ai_jetpack) {
  m_chute = spawn("script_model", (0, 0, 0));
  m_chute setmodel("fxanim_gp_parachute_jetpack_mod");
  m_chute useanimtree(#animtree);
  m_chute endon("death");

  recordent(m_chute);

  align_struct = getstruct("intro_loc", "targetname");
  align_struct.angles = (0, 0, 0);
  align_struct maps\_anim::anim_single_aligned(m_chute, "chute_guy1", undefined, "chute", 0.0);
  m_chute delete();
}

drone_mission_complete_s1(success, basejustlost) {
  if(isDefined(level.rts.game_success)) {
    return;
  }
  level notify("mission_complete", success);
  flag_set("block_input");
  level.rts.player freezecontrols(1);
  level.rts.game_success = success;

  while(isDefined(level.rts.switch_trans))
    wait 0.05;

  screen_fade_out(0.5);
  level.rts_floor delete();
  maps\_so_rts_poi::deleteallpoi();
  level.rts.player set_ignoreme(1);
  flag_clear("rts_hud_on");
  maps\_so_rts_support::hide_player_hud();
  level.rts.player enableinvulnerability();
  flag_set("rts_mode_locked_out");
  flag_clear("rts_mode");
  flag_set("fps_mode");
  level clientnotify("rts_OFF");
  luinotifyevent(&"rts_hud_visibility", 1, 0);
  level.rts.player clearclientflag(3);
  level.rts.player maps\_so_rts_ai::restorereplacement();
  maps\_so_rts_event::event_clearall(0);

  if(success) {
    mission_complete_clear_entities();
    drone_outro_succeed();
  } else {
    mission_complete_clear_entities();
    drone_outro_fail();
  }

  flag_clear("rts_event_ready");
  level thread maps\_so_rts_support::missioncompletemsg(success);
  flag_set("rts_game_over");

  if(isDefined(success) && success) {
    set_objective(level.obj_defend, undefined, "done");
    level.player set_story_stat("SO_WAR_DRONE_SUCCESS", 1);
    level.player giveachievement_wrapper("SP_RTS_DRONE");
    maps\_so_rts_support::missionsuccessmenu();
  } else
    maps\_so_rts_support::missionfailuremenu();

  level clientnotify("rts_fd");
  maps\_so_rts_support::show_player_hud();
  maps\_so_rts_support::toggle_damage_indicators(1);
  nextmission();
}

drone_outro_succeed() {
  level thread maps\createart\so_rts_mp_drone_art::success_igc();
  sentry_turrets = getentarray("sentry_turret_friendly", "targetname");

  foreach(sentry_turret in sentry_turrets)
  sentry_turret.ignoreall = 1;

  array_func(getaiarray(), ::set_ignoreall, 1);
  array_func(getaiarray(), ::set_ignoreme, 1);

  foreach(door in level.laser_doors)
  door delete();

  level.laser_doors = [];
  scene = "drone_outro_success";
  level thread run_scene(scene);
  flag_wait(scene + "_started");
  player_body = get_model_or_models_from_scene("drone_outro_success", "player_body");
  player_body attach(getweaponmodel("kard_sp"), "tag_weapon");
  maps\_so_rts_event::trigger_event("dlg_mission_success_fps");
  flag_wait("drone_success_fadein");
  screen_fade_in(0.5);
  maps\_so_rts_event::trigger_event("dlg_mission_success");
  flag_wait("drone_success_fadeout");
}

drone_outro_player_fire() {
  player_body = get_model_or_models_from_scene("drone_outro_success", "player_body");
  muzzle_org = player_body gettagorigin("tag_flash");
  muzzle_ang = player_body gettagangles("tag_flash");
  playfxontag(level._effect["kard_fake_flash"], player_body, "tag_flash");
  magicbullet("kard_sp", muzzle_org, muzzle_org + vectorscale(anglestoforward(muzzle_ang), 150), level.player);
}

drone_outro_fail() {
  level thread maps\createart\so_rts_mp_drone_art::fail_igc();
  scene = "drone_outro_fail";
  level thread run_scene(scene);
  flag_wait(scene + "_started");
  luinotifyevent(&"hud_update_vehicle_custom", 2, 1, & "cctv_hud");
  maps\_so_rts_event::trigger_event("dlg_mission_fail_fps");
  screen_fade_in(2.5);
  maps\_so_rts_event::trigger_event("dlg_mission_fail");
  flag_wait("drone_fail_fadeout");
  wait 3.5;
}

outro_emp_explosion() {
  emp_bomb = get_model_or_models_from_scene("drone_outro_fail", "briefcase_bomb");
  playsoundatposition("wpn_emp_explode_rts", emp_bomb.origin);
  playfxontag(level._effect["rts_suitcase_bomb_emp"], emp_bomb, "tag_origin");
  level notify("cctv_futz_stop");
}

outro_emp_lights() {
  emp_bomb = get_model_or_models_from_scene("drone_outro_fail", "briefcase_bomb");

  while(!flag("drone_emp_explosion")) {
    playfxontag(level._effect["outro_emp_blink"], emp_bomb, "tag_origin");
    playsoundatposition("evt_outro_emp_alert", emp_bomb.origin);
    wait 0.1;
  }
}

outro_camera_shutdown(guy) {
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
}

mission_complete_clear_entities() {
  maps\_so_rts_catalog::setpkgqty("bigdog_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("metalstorm_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("quadrotor_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_elite_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_enemy_reg2_pkg", "axis", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg2_pkg", "allies", 0);
  maps\_so_rts_catalog::setpkgqty("infantry_ally_reg_pkg", "allies", 0);
  flag_clear("rts_event_ready");
  array_thread(getaiarray(), ::mission_complete_clear_entity);
  array_thread(getvehiclearray(), ::mission_complete_clear_entity);
  wait 0.05;
  flag_set("rts_event_ready");
}

mission_complete_clear_entity() {
  self delete();
}

level_fade_in(player, delay) {
  if(!isDefined(player))
    player = level.rts.player;

  if(!isDefined(delay))
    delay = 0.5;

  thread screen_fade_in(delay);
}

drone_geo_changes() {
  ents = getentarray("rts_poi_LZ", "targetname");

  foreach(ent in ents)
  ent delete();

  ents = getentarray("rts_remove", "targetname");

  foreach(ent in ents)
  ent delete();

  ents = getentarray("script_model", "classname");

  foreach(ent in ents) {
    if(isDefined(ent.script_index)) {
      if(ent.script_index == 999)
        ent delete();
    }
  }

  ents = getentarray("delivery_van", "targetname");

  foreach(ent in ents)
  ent delete();

  level.laser_doors = getentarray("laser_door", "targetname");

  foreach(ent in level.laser_doors)
  ent disconnectpaths();

  roof = getent("rts_factory_roof", "targetname");

  if(isDefined(roof)) {
    targetloc = getstruct("rts_factory_roof_pos", "targetname");

    if(isDefined(targetloc))
      roof moveto(targetloc.origin, 0.1);
  }

  flag_wait("start_rts");
}

enemyspawninit() {
}

drone_create_badplace_ontrig() {
  self endon("death");
  time = 1;

  while(isDefined(self)) {
    self waittill("trigger", who);

    while(isDefined(who) && isDefined(self) && who istouching(self) && (isDefined(who.in_traversal) && who.in_traversal)) {
      badplace_cylinder("badplace" + self getentitynumber(), time, self.origin, self.radius, 72);

      thread maps\_so_rts_support::drawcylinder(self.origin, self.radius, 72, time);

      wait(time);
    }
  }
}

drone_badplace_auto() {
  trigs = getentarray("bad_place_auto_trig", "targetname");

  foreach(trig in trigs)
  trig thread drone_create_badplace_ontrig();
}

drone_ai_takeover_trigger(oob) {
  while(isDefined(self)) {
    self waittill("trigger", who);

    if(isDefined(oob) && oob) {
      who.allow_oob = 1;
      who.no_takeover = 1;
      who.unselectable = 1;
    } else {
      who.allow_oob = undefined;
      who.no_takeover = undefined;
      who.unselectable = undefined;

      if(isDefined(who.manual_lui_add) && who.manual_lui_add) {
        who.manual_lui_add = undefined;
        luinotifyevent(&"rts_add_friendly_human", 5, who getentitynumber(), who.squadid, 35, 0, who.pkg_ref.idx);
      }
    }
  }
}

drone_ai_takeover_off() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_OFF", "targetname");
  array_thread(triggers, ::drone_ai_takeover_trigger, 1);
}

drone_ai_takeover_on() {
  level endon("rts_terminated");
  triggers = getentarray("rts_takeover_ON", "targetname");
  array_thread(triggers, ::drone_ai_takeover_trigger, 0);
}

setup_challenges() {
  self thread maps\_so_rts_support::track_unit_type_usage();
  add_spawn_function_veh_by_type("heli_quadrotor_rts", ::watch_quad_death);
  add_spawn_function_veh_by_type("drone_metalstorm_rts", ::watch_asd_death);
  add_spawn_function_veh_by_type("turret_sentry_rts", ::watch_sentry_death);
  level.m_turret_deaths = 0;
  level.callbackactorkilled = maps\_so_rts_challenges::global_actor_killed_challenges_callback;
  level.rts.kill_stats = spawnstruct();
  level.rts.kill_stats.total_kills = 0;
  level.rts.kill_stats.headshot_kills = 0;
  level.rts.kill_stats.melee_kills = 0;
  level.rts.kill_stats.kills_as_claw = 0;
  level.rts.kill_stats.sentry_kills = 0;
  level.rts.kill_stats.headshot_kills_total = 20;
  level.rts.kill_stats.melee_kills_total = 10;
  level.rts.kill_stats.kills_as_claw_total = 10;
  level.rts.kill_stats.sentry_kills_total = 20;
  self maps\_challenges_sp::register_challenge("HEADSHOTS");
  self maps\_challenges_sp::register_challenge("MELEE_KILLS");
  self maps\_challenges_sp::register_challenge("CLAW_KILLS");
  self maps\_challenges_sp::register_challenge("SENTRY_KILLS");
  self maps\_challenges_sp::register_challenge("FIELD_UP", ::challenge_field_up);
  self maps\_challenges_sp::register_challenge("SENTRY_VS_ASD", ::challenge_sentry_vs_asd);
  self maps\_challenges_sp::register_challenge("ONE_MODULE_ONLY", ::challenge_one_module);
  self maps\_challenges_sp::register_challenge("KILL_QUADS", ::challenge_kill_quads);
  self maps\_challenges_sp::register_challenge("SENTRY_LOST", ::challenge_sentry_lost);
  self maps\_challenges_sp::register_challenge("TACTICAL", maps\_so_rts_support::challenge_tactical);
}

watch_asd_death() {
  self waittill("death", attacker, param2, weapon, v_loc, v_dir, dmg_type, param7, param8, param9);

  if(isplayer(attacker))
    level notify("player_killed_asd", level.player maps\_so_rts_support::get_player_rts_mode(), dmg_type, weapon);
}

watch_quad_death() {
  self waittill("death", attacker, param2, weapon, v_loc, v_dir, dmg_type, param7, param8, param9);

  if(isplayer(attacker))
    level notify("player_killed_quad", level.player maps\_so_rts_support::get_player_rts_mode(), dmg_type, weapon);
}

watch_sentry_death() {
  self endon("mission_complete");
  self waittill("death");
  level.m_turret_deaths++;
}

setupmissileboundary() {
  ulxy = getstruct("rts_ulxy_missile", "targetname");

  if(!isDefined(ulxy))
    ulxy = getstruct("rts_ulxy", "targetname");

  lrxy = getstruct("rts_lrxy_missile", "targetname");

  if(!isDefined(lrxy))
    lrxy = getstruct("rts_lrxy", "targetname");

  ux = ulxy.origin[0] < lrxy.origin[0] ? ulxy.origin[0] : lrxy.origin[0];
  lx = ulxy.origin[0] < lrxy.origin[0] ? lrxy.origin[0] : ulxy.origin[0];
  uy = ulxy.origin[1] < lrxy.origin[1] ? ulxy.origin[1] : lrxy.origin[1];
  ly = ulxy.origin[1] < lrxy.origin[1] ? lrxy.origin[1] : ulxy.origin[1];
  level.rts.bounds.missile_ulx = ux;
  level.rts.bounds.missile_uly = uy;
  level.rts.bounds.missile_lrx = lx;
  level.rts.bounds.missile_lry = ly;
}

drone_missile_oob_check(rocketorigin) {
  x = rocketorigin[0];
  y = rocketorigin[1];
  z = rocketorigin[2];

  if(x <= level.rts.bounds.missile_ulx)
    return false;
  else if(x >= level.rts.bounds.missile_lrx)
    return false;

  if(y <= level.rts.bounds.missile_uly)
    return false;
  else if(y >= level.rts.bounds.missile_lry)
    return false;

  if(z <= level.rts.bounds.minz)
    return false;

  return true;
}

challenge_field_up(str_notify) {
  level waittill("mission_complete", success);

  if(!success) {
    return;
  }
  if(level.m_lost_objectives < 2)
    self notify(str_notify);
}

challenge_sentry_vs_asd(str_notify) {
  while(true) {
    level waittill("player_killed_asd", rts_mode, dmg_type, weapon);

    if(weapon == "auto_gun_turret_sp_minigun_rts")
      self notify(str_notify);
  }
}

watch_planted_intruders() {
  num_planted = 0;

  while(true) {
    level waittill("intruder_planted_rts_poi_mainframe");
    num_planted++;

    if(num_planted >= 2) {
      level notify("defense_field_down");
      return;
    }
  }
}

challenge_one_module(str_notify) {
  self endon("defense_field_down");
  level thread watch_planted_intruders();
  level waittill("mission_complete", success);

  if(!success) {
    return;
  }
  self notify(str_notify);
}

challenge_kill_quads(str_notify) {
  while(true) {
    level waittill("player_killed_quad", rts_mode, dmg_type, weapon);
    self notify(str_notify);
  }
}

challenge_sentry_lost(str_notify) {
  level waittill("mission_complete", success);

  if(!success) {
    return;
  }
  if(level.m_turret_deaths <= 1)
    self notify(str_notify);
}

drone_setup_devgui() {
  setdvar("cmd_skipto", "");
  adddebugcommand("devgui_cmd \"|RTS|/Drone:10/Skipto:1/Win:1\" \"cmd_skipto win\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Drone:10/Skipto:1/Lose:1\" \"cmd_skipto lose\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Drone:10/Delete POI:2/Dish:1\" \"cmd_skipto destroyDish\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Drone:10/Delete POI:2/Power:2\" \"cmd_skipto destroyPower\"\n");
  adddebugcommand("devgui_cmd \"|RTS|/Drone:10/Delete POI:2/Cooling Tower:1\" \"cmd_skipto destroyTower\"\n");
  level thread drone_watch_devgui();
}

drone_watch_devgui() {
  while(true) {
    cmd_skipto = getdvar(#"_id_4D60CDD2");

    if(cmd_skipto == "win") {
      maps\_so_rts_rules::mission_complete(1);
      setdvar("cmd_skipto", "");
    }

    if(cmd_skipto == "lose") {
      maps\_so_rts_rules::mission_complete(0);
      setdvar("cmd_skipto", "");
    }

    if(cmd_skipto == "destroyDish") {
      foreach(poi in level.rts.poi) {
        if(poi.ref == "rts_poi_dish") {
          poi.entity dodamage(poi.entity.health + 666, poi.entity.origin);
          break;
        }
      }

      setdvar("cmd_skipto", "");
    }

    if(cmd_skipto == "destroyPower") {
      foreach(poi in level.rts.poi) {
        if(poi.ref == "rts_poi_eletrical_transformer") {
          poi.entity dodamage(poi.entity.health + 666, poi.entity.origin);
          break;
        }
      }

      setdvar("cmd_skipto", "");
    }

    if(cmd_skipto == "destroyTower") {
      foreach(poi in level.rts.poi) {
        if(poi.ref == "rts_obj_silo") {
          poi.entity dodamage(poi.entity.health + 666, poi.entity.origin);
          break;
        }
      }

      setdvar("cmd_skipto", "");
    }

    wait 0.05;
  }

}