/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown.gsc
******************************************************************/

function heli_down_precache() {
  level._effect["saw_sparks"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_cp_saw_sparks.vfx");
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level._effect["helidown_sparks"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_sparks_drop.vfx");
  level._effect["helidown_groundexp"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx");
  level._effect["helidown_plume"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_plume.vfx");
  level.ref_13661 = &spawnhelihvtexfilactors;
  thread update_crash_locations();
}

function update_crash_locations() {
  wait 5;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  register_spawn_groups();
}

function register_helidown_objective() {
  scripts\cp\cp_objectives::registerobjective("obj_helidown", &emptyfunc, &helidown_start_func, &emptyfunc, undefined, &helidown_start_func_debug);
  scripts\cp\cp_objectives::registerobjective("obj_helidown_escort_mnu", &emptyfunc, &helidown_escort_start_func, &emptyfunc, undefined, &helidown_start_func_debug);
  thread wait_for_players_near_obj();
  thread wait_for_escort_start();
}

function begin_wave_spawning() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
}

function wait_for_escort_start() {
  while(!isDefined(level.mission_select)) {
    wait 1;
  }

  scripts\engine\utility::flag_init("start_helidown_escort");
  scripts\engine\utility::flag_wait("start_helidown_escort");
  level.event_active = 1;
  thread helidown_escort_start_func();
  scripts\engine\utility::flag_wait("event_objective_heli_down_start_completed");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  level.event_active = 0;
}

function wait_for_players_near_obj() {
  while(!isDefined(level.mission_select)) {
    wait 1;
  }

  scripts\engine\utility::flag_init("start_helidown");
  scripts\engine\utility::flag_wait("start_helidown");

  for(;;) {
    if(istrue(level.event_active)) {
      wait 1;
      continue;
    }

    level.event_active = 1;
    thread helidown_start_func();
    scripts\engine\utility::flag_wait("event_objective_heli_down_start_completed");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
    level.event_active = 0;
    return;
  }
}

function emptyfunc(var_0) {}

function helidown_start_func_debug(var_0) {
  setDvar("helidown_event", "harness");
}

function helidown_start_func(var_0) {
  level notify("event_started");
  setDvar("helidown_event", "harness");
  wait 5;
  thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("objective_heli_down_start", "scripts/cp/maps/cp_donetsk/cp_donetsk_objectives_events.csv", 1);
}

function helidown_escort_start_func(var_0) {
  setDvar("helidown_event", "escort");
  setDvar("helidown_exfil_loc", "1");
  wait 5;
  thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("objective_heli_down_start", "scripts/cp/maps/cp_donetsk/cp_donetsk_objectives_events.csv", 1);
}

function heli_down_init(var_0) {
  if(!scripts\engine\utility::flag_exist("event_heli_downed_completed")) {
    scripts\engine\utility::flag_init("event_heli_downed_completed");
  }

  scripts\engine\utility::flag_clear("event_heli_downed_completed");
  thread main(level);
}

function objective_heli_down_start(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_2 = var_0.showobjprogress * -1;

  if(getdvarint("scr_event_helidown_short", 0) == 1) {
    var_0.showobjprogress = 30;
    var_2 = 30;
  }

  objective_setownerteam(var_0.objectiveindex, "allies");

  while(var_1 <= var_2) {
    wait 0.25;
    var_1 += 0.25;
  }

  level notify("helidown_timer_expired");

  while(istrue(level.helidown_event_active)) {
    wait 0.1;
  }

  wait 0.5;
  scripts\cp\cp_objectives_events::mark_event_completed("objective_heli_down_start");
  scripts\cp\cp_objectives_events::delete_old_objective_location("downed_pilot_chosen");
  scripts\cp\cp_objectives_events::stop_event("objective_heli_down_start");
  scripts\cp\cp_objectives_events::disable_repeating_event("objective_heli_down_start");
}

function main(var_0) {
  if(getdvarint("enable_pvpe") == 1) {
    thread exfil_players_on_rescue_fail();
  }

  level endon("objective_heli_down_kill_hvt");
  setdvarifuninitialized("helidown_harness_loc", "3");
  setdvarifuninitialized("helidown_escort_loc", "3");
  setdvarifuninitialized("helidown_exfil_loc", "1");
  setdvarifuninitialized("helidown_event", "harness");
  var_1 = ["harness", "escort"];
  var_2 = scripts\engine\utility::random(var_1);

  if(getDvar("helidown_event") != "") {
    var_2 = getDvar("helidown_event");
  }

  if(var_2 == "escort") {
    scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");
  }

  level.event_heli_type = var_2;
  var_3 = spawn_helidown_heli(var_0);
  shoot_down_heli(var_3, var_0);
  var_3.death_fx_on_self = 1;
  var_4 = undefined;

  if(var_2 == "escort") {
    var_4 = scripts\cp\cp_vip::vip_spawn(var_3, 0, "vip_spawn");
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
    var_4.script_noteworthy = "event_heli_downed_pilot";
    var_4.nodamage = 1;
    thread vip_parachute(var_4, var_3, var_0);
  }

  var_5 = var_3.vehicle_spawner.script_noteworthy;
  var_6 = heli_crash(var_3, var_0, var_2);
  var_6.location = var_5;
  init_cutout_anims();

  switch (var_2) {
    case "harness":
      thread heli_corpse_burn();
      rescue_type_harness(var_6, var_0);
      break;
    case "escort":
      rescue_type_escort(var_6, var_0, var_4);
      break;
  }

  level.helidown_event_active = 0;
  scripts\cp\cp_objectives_events::mark_event_completed("objective_heli_down_start");
  scripts\cp\cp_objectives_events::stop_event("objective_heli_down_start");
  scripts\cp\cp_objectives_events::disable_repeating_event("objective_heli_down_start");
  scripts\cp\cp_objectives_events::delete_old_objective_location("downed_pilot_chosen");
  level notify("helidown_done");
}

function heli_corpse_burn() {
  self setscriptablepartstate("stage1", "on");
  wait 100;
  self setscriptablepartstate("stage1", "off");
  self setscriptablepartstate("stage2", "on");
  wait 100;
  self setscriptablepartstate("stage2", "off");
  self setscriptablepartstate("stage3", "on");
  wait 100;
  remove_heli_corpse_after_timeout(1);
}

function rescue_type_harness(var_0, var_1) {
  var_1.label = &"CP_BR_SYRK_OBJECTIVES/OBJ_RESCUE_PILOT";
  var_2 = spawn_downed_pilot(var_0, var_1);
  var_2 endon("death");
  var_2 endon("bleedout");
  level.helidown_downed_pilot = var_2;
  thread downed_pilot_dialogue();
  pilot_wait_for_rescue(var_1, var_2, var_0);
  create_long_cut_interactions(var_0, var_2, var_1);
  wait_for_door_cut_long(var_1, var_2);
  remove_pilot_from_cockpit(var_0, var_1, var_2);
  enable_pilot_carry(var_2);
  exfil_pilot(var_2, var_1, var_0);
}

function rescue_type_escort(var_0, var_1, var_2) {
  var_2 waittill("hidden");
  thread remove_heli_corpse_after_timeout(var_0, 0);
  thread escort_vip_to_chopper(var_2, var_2, var_0);
  var_3 = var_2 scripts\engine\utility::ref_143B4("death", "exfil");

  if(var_3 == "death") {
    var_1 notify("vip_died");
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_fail_10", "allies");
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_exfil_10", "allies");
}

function vip_parachute(var_0, var_1, var_2) {
  vip_spawn_parachute(var_1, var_0);
  vip_parachute_nearby(var_1, var_0);
  vip_update_objective_on_landed(var_0, var_1, var_2);
  var_0 setCanDamage(0);
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  vip_go_and_hide(var_0, var_2);
}

function vip_spawn_parachute(var_0, var_1) {
  var_1.chute = spawn("script_model", var_0.origin);
  var_1.chute.angles = var_0.angles;
  var_1.chute setModel("ctl_parachute_player");
  var_1 allowedstances("stand");
  var_1 linkTo(var_1.chute, "tag_player", (0, 0, 0), (0, 0, 0));
  var_1.chute scriptmodelplayanim("sdr_mp_parachute_idle");
  var_2 = var_1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "parachute_idle");
  var_3 = var_1 scripts\asm\asm::asm_getxanim("animscripted", var_2);
}

function vip_parachute_nearby(var_0, var_1) {
  var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray("vip_land", "targetname"), undefined, 2, 10000);
  var_3 = scripts\engine\utility::random(var_2);

  if(getDvar("helidown_escort_loc", "") != "") {
    var_4 = getDvar("helidown_escort_loc");

    foreach(var_6 in var_2) {
      if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "escort_loc_" + var_4) {
        var_3 = var_6;
        break;
      }
    }
  }

  var_1.landing_spot = var_3;
  thread proximity_spawn(level, var_1.landing_spot);
  var_1.chute moveTo(var_3.origin + (0, 0, 350), 12, 1, 1);
  var_1.chute waittill("movedone");
  var_1 unlink();
  var_1 forceteleport(var_3.origin, var_3.angles);
  var_1.chute delete();
  return var_3;
}

function vip_update_objective_on_landed(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_2.objicon = "hud_icon_warning";
  var_2.label = &"CP_BR_SYRK_OBJECTIVES/LOCATE_PILOT";
  var_3.targetname = "downed_pilot_chosen";
  var_4 = scripts\engine\utility::getStructArray(var_0.landing_spot.target, "targetname");

  foreach(var_6 in var_4) {
    if(!isDefined(var_6.script_noteworthy)) {
      continue;
    }

    if(var_6.script_noteworthy == "obj_loc") {
      var_3.origin = var_6.origin + (0, 0, 65);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_update_10", "allies");
  scripts\cp\utility::addtostructarray("targetname", "downed_pilot_chosen", var_3);
  thread complete_killer(var_0, undefined);
  scripts\engine\utility::flag_set("event_heli_downed_completed");
}

function vip_go_and_hide(var_0, var_1) {
  scripts\cp\cp_vip::create_vip_trigger(var_0);
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray(var_0.landing_spot.target, "targetname");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy != "obj_loc") {
      var_2 = var_5;
    }
  }

  var_7 = scripts\engine\utility::random(var_2);

  if(getdvarint("scr_helidown_hidingspot", -1) > -1) {
    foreach(var_9 in var_2) {
      if(isDefined(var_9.location) && int(var_9.location) == getdvarint("scr_helidown_hidingspot")) {
        var_7 = var_9;
        break;
      }
    }
  }

  if(getdvarint("show_helidown_hidingspots") > 0) {
    thread debug_hiding_spots(var_0, var_2);
  }

  thread show_vip_waypoints(var_0);
  var_11 = getclosestpointonnavmesh(var_7.origin);
  var_0.goalradius = 32;
  var_0 setgoalpos(var_7.origin);
  var_0 waittill("goal");
  wait 1;

  if(!isDefined(var_7.angles)) {
    var_7.angles = (0, 0, 0);
  }

  var_12 = anglesToForward(var_7.angles) * 15;
  var_13 = spawn_pilot_attacker(var_11, var_7.angles);
  var_13 scripts\cp\cp_skits::setup_fight_guy();
  var_0 scripts\cp\cp_skits::setup_fight_guy();
  var_0 forceteleport(var_11 + var_12, var_7.angles);
  var_0.anchor = spawn("script_origin", var_11 + var_12);
  var_0.anchor.angles = var_7.angles;
  var_0 linkTo(var_0.anchor);
  var_13.anchor = spawn("script_origin", var_11);
  var_13.anchor.angles = var_7.angles;
  var_13 linkTo(var_13.anchor);
  var_0.attacker = var_13;
  thread scripts\cp\cp_skits::hostage_rescue_meatshield(undefined, undefined, undefined, undefined, var_13, var_0, 300);
  var_0 notify("hidden");
}

function spawn_pilot_attacker(var_0, var_1) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, "badguy")) {
      var_2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_rus_desert_shotgun", var_0, var_1);

      if(isDefined(var_2)) {
        var_2 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var_2 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_2.dontkilloff = 1;
  var_2.health = 25;
  var_2.maxhealth = 25;
  var_2.suppressionthreshold = 0;
  return var_2;
}

function debug_hiding_spots(var_0, var_1) {
  self endon("death");
  self endon("vip_used");

  for(;;) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1) {}
    }

    wait 0.5;
  }
}

function spawn_helidown_heli(var_0) {
  var_1 = get_heli_spawn_struct();
  var_2 = spawn_objective_heli(var_1);
  var_2 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(scripts\engine\utility::getclosest(var_2.origin, scripts\engine\utility::getStructArray("heli_down_path", "targetname")));
  var_2 playLoopSound("cp_br_syrk_chopper_engine_donut_dist");
  level thread scripts\common\vehicle_paths::gopath(var_2);
  return var_2;
}

function get_heli_spawn_struct() {
  jumpiftrue(isDefined(level.heli_down_structs)) LOC_0000001e;
  level.heli_down_structs = scripts\engine\utility::getStructArray("helidown_heli", "targetname");

  for(;;) {
    var_0 = scripts\engine\utility::random(level.heli_down_structs);

    if(!isDefined(level.last_helidown_loc) || var_0 != level.last_helidown_loc) {
      break;
    }

    wait 0.05;
  }

  level.heli_down_structs = scripts\engine\utility::array_remove(level.heli_down_structs, var_0);

  if(level.heli_down_structs.size == 0) {
    level.heli_down_structs = scripts\engine\utility::getStructArray("helidown_heli", "targetname");
  }

  if(getdvarint("helidown_harness_loc") > 0) {
    var_1 = getdvarint("helidown_harness_loc");
    var_2 = scripts\engine\utility::getStructArray("helidown_heli", "targetname");

    foreach(var_4 in var_2) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "loc_" + var_1) {
        return var_4;
      }
    }
  }

  level.last_helidown_loc = var_0;
  return var_0;
}

function spawn_objective_heli(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_1.vehicle_skipdeathmodel = 1;
  var_1.death_fx_on_self = 1;
  return var_1;
}

function shoot_down_heli(var_0, var_1) {
  self waittill("noteworthy");
  var_2 = anglestoleft(self.angles);
  var_3 = getgroundposition(self.origin, 16);
  var_4 = magicbullet("attack_drone_missile_cp", var_3, self.origin);
  var_4 missile_settargetEnt(self);
  var_4 missile_setflightmodedirect();
  target_hit_monitor(var_4, self);
}

function target_hit_monitor(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_5 = var_1.origin - var_0.origin;

  for(;;) {
    if(missile_hit_target(var_0, var_1, var_5)) {
      break;
    }

    waitframe();
  }

  playFX(level._effect["helidown_rpghit"], var_0.origin);
  playFX(level._effect["helidown_sparks"], var_1.origin);
  var_0 detonate();
}

function missile_hit_target(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, var_1.origin) <= 90000) {
    return true;
  }

  var_3 = var_1.origin - var_0.origin;

  if(vectordot(var_2, var_3) < 0) {
    return true;
  }

  return false;
}

#using_animtree("script_model");

function heli_crash(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getclosest(var_0.origin, level.vehicle.helicopter_crash_locations);

  if(isDefined(var_0.perferred_crash_location)) {
    var_3 = var_0.perferred_crash_location;
  }

  if(isDefined(var_2) && var_2 == "harness") {
    thread proximity_spawn(level, var_3.origin);
  }

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = scripts\cp\cp_objectives::requestworldid("helicopter_spawn", 10);
    objective_icon(var_4, "hud_icon_warning");
    objective_setminimapiconsize(var_4, "icon_regular");
    objective_setshowdistance(var_4, 1);
    objective_onentity(var_4, var_0);
    objective_setbackground(var_4, 1);
    objective_setlabel(var_4, &"CP_BR_SYRK_OBJECTIVES/HELI_DISTRESS");
    objective_state(var_4, "current");
    objective_setplayintro(var_4, 0);
    objective_setownerteam(var_4, "allies");
  }

  if(!isDefined(var_3.angles)) {
    var_3.angles = (0, 0, 0);
  }

  level.vehicle.templates.vehicle_death_fx["script_vehicle_iw8_lbravo"][0].effect = level._effect["helidown_tailfire"];
  var_0 playSound("cp_br_syrk_chopper_rocket_explode");
  var_0 stoploopsound("cp_br_syrk_chopper_engine_donut_dist");
  var_0 notify("death", level.players[0], "MOD_EXPLOSIVE", undefined, var_0.origin);
  level notify("heli_crashing", var_0);
  var_0 playLoopSound("cp_br_syrk_chopper_dying_loop");
  var_0 waittill("vehicle_deathComplete", var_5, var_6);
  var_0 delete();
  var_7 = spawn("script_model", var_3.origin);
  var_7.angles = var_3.angles;
  var_7 setModel("prop_veh8_mil_air_air_blima_dst");
  var_8 = anglesToForward(var_3.angles);
  var_9 = anglestoleft(var_3.angles);
  var_7.navobs = createnavobstaclebybounds(var_7.origin + var_8 * -175 + var_9 * 25, (375, 50, 150), var_7.angles);
  var_7.navobs2 = createnavobstaclebybounds(var_7.origin + var_8 * -425 + var_9 * 150, (150, 50, 150), var_7.angles);
  var_7.clipmodel = spawn("script_model", var_7.origin);
  var_7.clipmodel clonebrushmodeltoscriptmodel(getEnt("helidown_clip", "targetname"));
  var_7.clipmodel.angles = var_7.angles;
  var_7 useanimtree(#animtree);
  var_7 scriptmodelplayanim("sdr_cp_hostage_pickup_blimadestroyed_idle_blimadst");

  if(isDefined(var_3.script_noteworthy)) {
    var_7.script_noteworthy = var_3.script_noteworthy;
  }

  if(isDefined(var_4)) {
    objective_delete(var_4);
    scripts\cp\cp_objectives::freeworldid("helicopter_spawn");
  }

  var_7 setscriptablepartstate("impact", "on");
  radiusdamage(var_7.origin + (0, 0, 50), 750, 1000, 50);
  return var_7;
}

function spawn_downed_pilot(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.body = spawn("script_model", var_2.origin);
  var_2.body setModel("british_pilot_fullbody");
  var_2.bodymodel = "british_pilot_fullbody";
  var_2.body.animname = "hvt";
  var_2.body useanimtree(level.scr_animtree["hvt"]);
  var_2.script_noteworthy = "event_heli_downed_pilot";
  thread idle_pilot_loop(var_0);
  var_3 = spawnStruct();
  var_3.targetname = "downed_pilot_chosen";
  var_3.origin = var_2.origin + (0, 0, 25);
  scripts\cp\utility::addtostructarray("targetname", "downed_pilot_chosen", var_3);
  thread complete_killer(var_2, var_0);
  scripts\engine\utility::flag_set("event_heli_downed_completed");
  return var_2;
}

function exfil_pilot(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("bleedout");
  var_3 = get_pilot_exfil(var_2);
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_move_10", "allies");

  if(isDefined(var_3.target)) {
    var_4 = scripts\engine\utility::getStructArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      thread proximity_spawn(var_6);
    }
  }

  wait 1;
  objective_setlabel(var_1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "icon_waypoint_timed");
  objective_position(var_1.objectiveindex, var_3.origin + (0, 0, -100));
  var_8 = spawn_evac_chopper(var_3);
  var_8.godmode = 1;
  var_8.health = 10000;
  var_8.maxhealth = 10000;
  vehicle_anims();
  script_model_anims(var_8);
  scripts\cp\cp_pickup_hostage::init_anims();
  spawnhelihvtexfilactors(var_8);
  thread leave_if_vip_dies(var_8, var_0);
  var_9 = 0;
  level notify("helidown_exfil_struct_loc", var_8.exfil_struct.origin);

  while(!var_9) {
    if(distancesquared(var_0.origin, var_8.exfil_struct.origin) < get_vip_close_to_exfil_dist_sq()) {
      var_9 = 1;
    }

    wait 1;
  }

  level notify("vip_close_to_exfil_location", var_8);
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("defend_done");
  level notify("helidown_done");
  var_8 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_8.exfil_struct, 1);
  var_10 = anglesToForward(var_8.angles);
  var_11 = anglestoleft(var_8.angles);
  var_12 = var_8.origin;
  var_13 = var_12 + var_10 * 10 + var_11 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_13);
  objective_setlabel(var_1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  var_14 = spawn("trigger_radius", var_13 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var_14 waittill("trigger", var_15);
    var_16 = var_15.hostagecarried;
    var_16 notify("stop_bleedout_timer");
    scripts\cp\cp_pickup_hostage::load_hvt(var_15, var_8);
    wait 1;
    break;
  }

  level notify("vip_loaded_to_exfil_chopper");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_exfil_10", "allies");
  thread evac_pilot(level);

  foreach(var_15 in level.players) {
    var_15 setsoundsubmix("cp_matchend_music", 5);
    var_15 setplayermusicstate("mus_west_victory");
  }
}

function get_vip_close_to_exfil_dist_sq() {
  if(isDefined(level.helidown_vip_close_to_exfil_dist_sq)) {
    return level.helidown_vip_close_to_exfil_dist_sq;
  }

  return 12250000;
}

function idle_exfilally_loop(var_0) {
  self endon("death");
  var_0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, "blima_drop_l_idle_in", "tag_origin");
  }
}

function spawnhelihvtexfilactors(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var_1)) {
    var_1 = "head_sas_urban_ar_rain";
  }

  var_2 = self;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("allied_pilot_fullbody_3");
  var_3 useanimtree(level.scr_animtree["exfil_ally"]);
  var_3.animname = "exfil_ally";
  var_4 = getstartorigin(var_2.origin, var_2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var_5 = getstartangles(var_2.origin, var_2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkTo(var_2);
  var_2.wmexfilally = var_3;
  thread idle_exfilally_loop(var_2);
}

function get_pilot_exfil(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.location + "_hvt_exfil", "targetname");
  var_2 = scripts\engine\utility::random(var_1);

  if(getdvarint("helidown_exfil_loc") > 0) {
    var_3 = getdvarint("helidown_exfil_loc");

    foreach(var_5 in var_1) {
      if(var_5.script_noteworthy == var_0.location + "_exfil_" + var_3) {
        return var_5;
      }
    }
  }

  return var_2;
}

function remove_pilot_from_cockpit(var_0, var_1, var_2) {
  level notify("helidown_done");
  objective_setlabel(var_1.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/REMOVE_PILOT");
  wait_for_pilot_pickup(var_0, var_2);
  var_1 notify("stop_timer");

  if(isDefined(var_1)) {
    foreach(var_4 in level.players) {
      objective_unpinforclient(var_1.objectiveindex, var_4);
    }
  }

  thread kill_pilot_on_bleedout();
  level notify("pilot_rescued");
}

function enable_pilot_carry(var_0) {
  var_0.bodymodel = "british_pilot_fullbody";
  var_0.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  var_0.drophintstring = "drop_pilot_hostage";
  var_0.nowaypoint = 1;
}

function pilot_wait_for_rescue(var_0, var_1, var_2) {
  var_1 setHintString(&"CP_BR_SYRK_OBJECTIVES/CUT_PILOT");
  var_1 sethintdisplayrange(148);
  var_1 sethintdisplayfov(120);
  var_1 sethintonobstruction("show");
  var_1 sethintrequiresholding(1);
  var_1 setuseholdduration("duration_none");

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, 40000)) {
    wait 0.25;
  }

  level.helidown_event_active = 1;
  objective_setlabel(var_0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ");
  objective_setplayintro(var_0.objectiveindex, 0);
  objective_position(var_0.objectiveindex, var_2 gettagorigin("j_door") + anglesToForward(var_2.angles) * -10);
}

function evac_pilot(var_0, var_1) {
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 800), 1);
  wait 8;
  var_0 vehicle_setspeed(90, 10);
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var_1) && isalive(var_1)) {
    var_1.nocorpse = 1;
    var_1 dodamage(var_1.health + 100, var_1.origin);
  }

  var_0 delete();
}

function complete_killer(var_0, var_1) {
  level endon("objective_heli_down_kill_hvt");
  var_1 endon("stop_timer");
  level endon("pilot_rescued");
  level scripts\engine\utility::ref_143A5("debug_beat_objective_heli_down_start_objective", "helidown_timer_expired");

  if(isagent(self) && !istrue(self.onchopper)) {
    self dodamage(self.health + 100, self.origin);
  } else if(isent(self) && !istrue(self.onchopper)) {
    if(isDefined(self.head)) {
      self.head delete();
    }

    if(isDefined(self.body)) {
      self.body delete();
    }

    self delete();
  }

  if(isDefined(var_0) && isent(var_0)) {
    thread remove_heli_corpse_after_timeout(var_0);
  }

  level notify("helidown_done");
  level.helidown_event_active = 0;
  wait 0.5;

  if(isDefined(var_0)) {
    var_0 notify("delete_corpse");
  }

  level notify("objective_heli_down_kill_hvt");
}

function remove_heli_corpse_after_timeout(var_0, var_1) {
  self endon("death");
  level.helidown_corpse_present = 1;

  if(isDefined(var_1)) {
    wait var_1;
  }

  playsoundatpos(self.origin, "cp_br_syrk_chopper_crash");
  playFX(level._effect["helidown_groundexp"], self.origin);
  playrumbleonposition("heavy_3s", self.origin);
  earthquake(0.35, 4, self.origin, 1000);
  radiusdamage(self.origin + (0, 0, 50), 750, 1000, 50);

  if(isDefined(self.clipmodel)) {
    self.clipmodel delete();
  }

  if(isDefined(level.cut_interactions)) {
    foreach(var_3 in level.cut_interactions) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }

    level.cut_interactions = undefined;
  }

  destroynavobstacle(self.navobs);
  destroynavobstacle(self.navobs2);
  self hide();
  self waittill("delete_corpse");
  level.helidown_corpse_present = 0;
  self delete();
}

function wait_for_door_cut(var_0, var_1) {
  var_1 endon("death");
  var_2 = 0;

  for(;;) {
    level scripts\engine\utility::ref_143A7("cut_1", "cut_2", "cut_3", "cut_4");
    var_2++;

    if(var_2 >= 4) {
      break;
    }
  }

  var_1 notify("harness_cut");

  if(isDefined(var_0)) {
    foreach(var_4 in level.players) {
      objective_unpinforclient(var_0.objectiveindex, var_4);
    }

    return;
  }
}

function wait_for_door_cut_long(var_0, var_1) {
  var_1 endon("death");
  level scripts\engine\utility::ref_143A7("cut_1", "cut_2", "cut_3", "cut_4");
  var_1 notify("harness_cut");

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      objective_unpinforclient(var_0.objectiveindex, var_3);
    }

    return;
  }
}

function pilot_rescue_objective_think(var_0, var_1) {
  var_1 endon("cutout");
  var_1 endon("bleedout");
  var_1 endon("death");

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_3.inhackring)) {
          objective_unpinforclient(var_0.objectiveindex, var_3);
          var_3.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var_3.origin, var_1.origin + (0, 0, -20)) > 16900) {
        if(isDefined(var_3.inhackring)) {
          objective_unpinforclient(var_0.objectiveindex, var_3);
          var_3.inhackring = undefined;
        }

        continue;
      }

      if(!istrue(var_3.inhackring)) {
        objective_pinforclient(var_0.objectiveindex, var_3);
        var_3.inhackring = 1;
      }
    }

    wait 0.25;
  }
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["exfil_guy"] = #animtree;
  level.scr_anim["exfil_guy"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_price;
  level.scr_animname["exfil_guy"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_price";
  level.scr_anim["exfil_guy"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_price_idle;
  level.scr_animname["exfil_guy"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_price_idle";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_hvt;
  level.scr_animname["hvt"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_hvt";
  level.scr_anim["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level.scr_animname["hvt"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_hvt_idle";
  level.scr_animtree["exfil_chopper"] = #animtree;
  level.scr_anim["exfil_chopper"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_blima";
  level.scr_anim["exfil_chopper"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_blima";
}

function ref_11FC3(var_0, var_1) {
  var_1 notify("handoff_hvt");
  var_0 notify("loading_hvt_onto_heli");
  var_2 = var_1.wmexfilally;
  var_3 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0 scripts\engine\utility::ref_143B9(1, "weapon_change");
  var_0 resetcarryobject();
  var_0 setstance("stand");
  var_5 = var_0.hostagecarried;
  var_5.onchopper = 1;
  var_0 unlink();
  var_5 unlink();
  var_5.body unlink();
  var_0 allowcrouch(0);
  var_5.body useanimtree(level.scr_animtree["hvt"]);
  var_5.body.animname = "hvt";
  var_0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var_0, "player_vip_blima");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "blima_drop_l");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var_0, 0.4);
  var_6 = spawn("script_model", var_1.origin);
  var_6 setModel("allied_pilot_fullbody_3");
  var_6 useanimtree(level.scr_animtree["exfil_ally"]);
  var_6.animname = "exfil_ally";
  var_7 = spawn("script_model", var_1.origin);
  var_7 setModel(var_5.bodymodel);
  var_7 useanimtree(level.scr_animtree["hvt_vm"]);
  var_7.animname = "hvt_vm";

  if(isDefined(var_5.head)) {
    var_7.head = spawn("script_model", var_1.origin);
    var_7.head setModel(var_5.headmodel);
    var_7.head linkTo(var_7, "j_neck", (-9, 1, 0), (0, 0, 0));
    var_7.head.animname = "hvt_vm";
    var_7.head useanimtree(level.scr_animtree["hvt_vm"]);
    var_7.head showonlytoplayer(var_0);
  }

  var_7 showonlytoplayer(var_0);
  var_6 showonlytoplayer(var_0);
  var_2 show();
  var_2 hidefromplayer(var_0);
  var_5.body show();
  var_5.body hidefromplayer(var_0);

  if(isDefined(var_5.head)) {
    var_5.head hidefromplayer(var_0);
  }

  var_8 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["exfil_ally"]["blima_drop_l"]);
  var_9 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["exfil_ally"]["blima_drop_l"]);
  var_10 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["exfil_ally_vm"]["blima_drop_l"]);
  var_11 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["exfil_ally_vm"]["blima_drop_l"]);
  var_12 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["hvt_vm"]["blima_drop_l"]);
  var_13 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["hvt_vm"]["blima_drop_l"]);
  var_2.origin = var_8;
  var_2.angles = var_9;
  var_6.origin = var_10;
  var_6.angles = var_11;
  var_7.origin = var_12;
  var_7.angles = var_13;
  var_5.origin = var_12;
  var_5.angles = var_13;
  var_6 linkTo(var_1);
  var_7 linkTo(var_1);
  var_5 linkTo(var_1);
  var_1.vmexfilally = var_6;
  var_1.vmhvt = var_7;
  var_14 = getstartorigin(var_1.origin, var_1.angles, level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var_15 = getstartangles(var_1.origin, var_1.angles, level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var_0 allowcrouch(0);
  var_0 setstance("stand");
  var_2 notify("stop_idle_anim");
  var_1 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "blima_drop_l", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_6, "blima_drop_l", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "blima_drop_l", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_7, "blima_drop_l", "tag_origin");
  var_1 thread scripts\common\anim::anim_single_solo(var_5.body, "blima_drop_l", "tag_origin");
  var_16 = getanimlength(level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var_17 = getanimlength(level.scr_anim["hvt"]["blima_drop_l"]);
  wait var_16;
  var_0 setstance("stand");
  var_0 notify("remove_rig");
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  var_0 switchtoweapon(var_0.restoreweapon);
  var_0 allowcrouch(1);
  scripts\cp\cp_pickup_hostage::hostagedrop(var_0, var_0.hostagecarried, var_0.hostagecarried.origin, 0, 0.5, 1, 1);
  wait var_17 - var_16;
  var_5.body linkTo(var_5);

  if(isDefined(var_5.head)) {
    var_5.head linkTo(var_5.body);
  }

  var_5 linkTo(var_1);

  if(isDefined(var_7.head)) {
    var_7.head delete();
  }

  var_7 delete();
  var_6 delete();
  var_5.body show();

  if(isDefined(var_5.head)) {
    var_5.head show();
  }

  var_2 show();
  var_5.body scriptmodelplayanim("sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot");
  var_2 scriptmodelplayanim("sdr_cp_hostage_dropoff_blima_L_idle_outro_ally");
}

function hostage_price_idle(var_0) {
  var_0 endon("death");
  self endon("death");

  for(;;) {
    var_0 scriptmodelplayanim(level.scr_anim[var_0.animname]["helidown_exfil_idle"]);

    if(isDefined(var_0.head)) {
      var_0.head scriptmodelplayanim(level.scr_anim[var_0.head.animname]["helidown_exfil_idle"]);
    }

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    var_1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    wait var_1;
  }
}

function spawnactors() {
  if(!isDefined(self.exfil_helpers)) {
    self.exfil_helpers = [];
  }

  self.exfil_helpers[self.exfil_helpers.size] = spawn_anim_model("exfil_guy", "body_animate_jnt", "fullbody_hero_price_urban");
}

function spawn_anim_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_2);

  if(isDefined(var_3)) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel(var_3);
    var_5 linkTo(var_4, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_4.head = var_5;
    var_4 thread scripts\engine\utility::delete_on_death(var_5);
  }

  var_4.animname = var_0;
  var_4 useanimtree(level.scr_animtree[var_4.animname]);

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_4);
    var_4 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_4;
}

function actor_animloop(var_0, var_1, var_2, var_3) {
  self endon(var_2);
  self endon("death");

  for(;;) {
    scripts\common\anim::anim_single(var_0, var_1, var_3);
    var_4 = getanimlength(level.scr_anim[var_0[0].animname][var_1]);
    wait var_4;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function escort_vip_to_chopper(var_0, var_1, var_2) {
  var_0 endon("death");
  thread complete_killer(var_0, var_1);
  thread play_escort_pain_vo();
  var_0 waittill("saved");
  var_0.trigger makeusable();
  var_0 waittill("vip_used");
  var_0 playSound("dx_cps_plt_rescue_pilot_eject_found_30");
  create_escort_health_objective(var_0);
  var_0 thread scripts\cp\cp_vip::vip_damage_monitor();
  var_0.ignoreme = 1;
  level notify("helidown_done");
  level.helidown_event_active = 1;
  var_2 notify("stop_timer");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_found_10", "allies");
  var_3 = spawn_vip_escort_chopper(var_1, var_2);
  wait 3;

  if(isDefined(var_3.exfil_struct.target)) {
    var_4 = scripts\engine\utility::getStructArray(var_3.exfil_struct.target, "targetname");

    foreach(var_6 in var_4) {
      thread proximity_spawn(var_6);
    }
  }

  wait_for_vip_near_heli(var_0, var_3, var_2);
}

function play_escort_pain_vo() {
  self endon("death");
  self endon("vip_used");
  self endon("saved");

  for(;;) {
    wait randomintrange(15, 30);
    self playSound("dx_cps_plt_rescue_pilot_eject_found_20");
  }
}

function wait_for_vip_near_heli(var_0, var_1) {
  self endon("death");

  for(;;) {
    if(distancesquared(self.origin, var_0.exfil_struct.origin) < 9000000) {
      break;
    }

    wait 1;
  }

  thread leave_if_vip_dies(var_0, self);
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("defend_done");
  level notify("helidown_done");
  var_0 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_0.exfil_struct, 1);
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoleft(var_0.angles);
  var_4 = var_0.origin;
  var_5 = var_4 + var_2 * 10 + var_3 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_5);

  for(;;) {
    wait 1;
  }

  LOC_000000d5:
    board_chopper(var_0, self);
  self notify("exfil");
  wait 2;
  thread evac_pilot(level, var_0);
}

function leave_if_vip_dies(var_0, var_1) {
  var_0 endon("exfil");
  self endon("death");
  scripts\engine\utility::waittill_any_ents_return(var_1, "vip_died", var_0, "bleedout");
  self notify("stop_marker");

  if(self vehicle_getspeed() > 1) {
    self waittill("goal");
  }

  if(istrue(self.going_to_exfil)) {
    thread evac_pilot(self);
    return;
  }

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.nocorpse = 1;
    var_0 dodamage(var_0.health + 100, var_0.origin);
  }

  self delete();
}

function defend_while_chopper_arrives(var_0) {
  objective_setlabel(var_0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setprogress(var_0.objectiveindex, 0);
  var_1 = 60;
  var_2 = 60;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0.objectiveindex, var_2 / var_1);

    if(var_2 <= 15) {
      var_0 notify("defend_done");
    }

    if(var_2 <= 0) {
      return;
    }
  }
}

function spawn_vip_escort_chopper(var_0, var_1) {
  objective_setlabel(var_1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "icon_waypoint_timed");
  var_2 = get_pilot_exfil(var_0);
  var_3 = spawn_evac_chopper(var_2);
  var_3.godmode = 1;
  var_3.health = 10000;
  var_3.maxhealth = 10000;
  objective_position(var_1.objectiveindex, var_2.origin + (0, 0, -100));
  return var_3;
}

#using_animtree("");

function spawn_evac_chopper(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("pilot_evac_chopper", "targetname"));
  var_1.vehicle_skipdeathmodel = 1;
  var_1.godmode = 1;
  var_1.health = 10000;
  var_1.maxhealth = 10000;
  var_1.script_disconnectpaths = 0;
  var_1.death_fx_on_self = 1;
  var_1.exfil_struct = var_0;
  var_1 vehicleplayanim(%est_blima_doors_open);
  var_0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_1);
  var_1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var_1;
}

function board_chopper(var_0, var_1) {
  var_1 notify("stop_vip_follow");
  var_1.trigger makeunusable();
  var_1.trigger delete();
  var_1 hudoutlinedisable();
  var_1 notify("remove_headicon");
  var_1 setCanDamage(0);
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_1.playing_skit = 1;
  var_2 = get_closest_heli_entrance(var_1, var_0);
  var_1.goalradius = 8;
  var_1 setgoalpos(var_2.origin);
  var_1 scripts\engine\utility::ref_143A5("goal", "goal_reached");
  var_1.old_weapon = var_1.weapon;
  var_1.fists_weapon = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var_1 giveweapon(var_1.fists_weapon);
  var_1 takeweapon(var_1.old_weapon);
  var_1 setspawnweapon(var_1.fists_weapon);
  var_1 setplayerangles(var_2.angles);
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_1 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_1 aisetanim("animscripted", var_2.animindex);
  var_3 = getanimlength(var_2.xanim);
  wait var_3;
  var_1 linkTo(var_0);
  var_1 playerlinkedoffsetenable();
  var_1.nodamage = 1;
  thread vip_idle_loop();
  var_1 notify("stop_bleedout_timer");
}

function get_closest_heli_entrance(var_0, var_1) {
  var_2 = get_entrance_pos(var_0, var_1, "vip_blima_exfil_r");
  var_3 = get_entrance_pos(var_0, var_1, "vip_blima_exfil_l");
  return scripts\engine\utility::getclosest(var_0.origin, [var_2, var_3]);
}

function get_entrance_pos(var_0, var_1, var_2) {
  var_3 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_2);
  var_4 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_3);
  var_5 = var_1 gettagorigin("body_animate_jnt");
  var_6 = var_1 gettagangles("body_animate_jnt");
  var_7 = spawnStruct();
  var_7.origin = getstartorigin(var_5, var_6, var_4);
  var_7.angles = getstartangles(var_5, var_6, var_4);
  var_7.animindex = var_3;
  var_7.xanim = var_4;
  return var_7;
}

function vip_idle_loop() {
  self endon("death");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads("vip_blima_exfil_idle");
}

function create_escort_health_objective(var_0) {
  var_0 endon("death");
  var_0 endon("stop_bleedout_timer");
  var_1 = 75;
  var_2 = scripts\cp\cp_objectives::requestworldid("pilot_down", 15);
  objective_state(var_2, "current");
  objective_icon(var_2, "hud_icon_death_spawn");
  objective_onentity(var_2, var_0);
  objective_setbackground(var_2, 0);
  objective_setprogressteam(var_2, "allies");
  objective_setshowprogress(var_2, 1);
  objective_setprogress(var_2, 1);
  objective_setplayintro(var_2, 0);
  objective_setlabel(var_2, &"CP_BR_SYRK_OBJECTIVES/INJURED_PILOT");
  objective_setzoffset(var_2, var_1);
  var_0.objnum = var_2;
  thread destroy_bleedout_timer();
}

function destroy_bleedout_timer() {
  var_0 = self.objnum;
  scripts\engine\utility::ref_143A5("death", "stop_bleedout_timer");
  objective_delete(var_0);
}

function kill_pilot_on_bleedout() {
  self endon("rescued");
  self endon("death");
  self waittill("bleedout");

  if(isDefined(self.carrier)) {
    scripts\cp\cp_pickup_hostage::hostagedrop(undefined, undefined, self.origin, undefined, 0.5, 0, 1);
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_fail_10", "allies");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_BR_SYRK_GL_DIALOGUE/PILOT_KILLED", "allies", 5);

  if(isDefined(self.head)) {
    self.head delete();
  }

  self delete();
}

function proximity_spawn(var_0, var_1) {
  if(isstruct(var_0)) {
    var_2 = var_0.origin;
    var_3 = 128;

    if(isDefined(var_0.height)) {
      var_3 = int(var_0.height);
    }

    var_4 = 4096;

    if(isDefined(var_0.radius)) {
      var_4 = int(var_0.radius);
    }
  } else {
    var_2 = var_3;
    var_3 = 128;
    var_4 = 4096;
  }

  var_5 = spawn("trigger_radius", var_2, 0, var_4, var_3);
  var_6 = scripts\engine\utility::waittill_any_ents_return(level, "helidown_done", level, "objective_heli_down_kill_hvt", var_5, "trigger");

  if(var_6 == "trigger") {
    if(isDefined(var_4)) {
      scripts\cp\cp_modular_spawning::run_spawn_module(var_4);
    } else {
      scripts\cp\cp_modular_spawning::run_spawn_module(var_3.target);
    }
  }

  var_5 delete();
}

function register_spawn_groups() {
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    var_1 = [ &scripts\cp\cp_modular_spawning::waittill_spawn_notify_after_count, "PvPE_enemy_AI_start_spawning"];
    var_2 = [ &scripts\cp\cp_modular_spawning::override_spawner_aitypes, "ar", "smg"];
    var_3 = [var_2, &end_spawn_group];
    [[var_0]]("harness_loc_3", 0, 0, 0, var_1, undefined, "harness_loc_3", var_2, "harness_loc_3_reinforce", 8);
    [[var_0]]("harness_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce", var_3, undefined, undefined);
    [[var_0]]("harness_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_snipers", var_3, undefined, undefined);
    [[var_0]]("harness_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_snipers_2", var_3, undefined, undefined);
    [[var_0]]("harness_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_rpg", var_3, undefined, undefined);
    [[var_0]]("harness_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_2", var_3, undefined, undefined);
    [[var_0]]("escort_loc_3", 0, 0, 0, 0.1, undefined, "harness_loc_3", var_2, "escort_loc_3_reinforce", 8);
    [[var_0]]("escort_loc_3_reinforce", 0, 0, 0, var_1, 0, "escort_loc_3_reinforce", var_3, undefined, undefined);
    [[var_0]]("escort_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_snipers", var_3, undefined, undefined);
    [[var_0]]("escort_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_snipers_2", var_3, undefined, undefined);
    [[var_0]]("escort_loc_3_reinforce", 0, 0, 0, var_1, 0, "harness_loc_3_reinforce_rpg", var_3, undefined, undefined);
    [[var_0]]("loc_3_exfil_1_a", 0, 0, 0, var_1, undefined, "loc_3_exfil_1_a", var_3, undefined, undefined);
    [[var_0]]("loc_3_exfil_1_b", 0, 0, 0, var_1, undefined, "loc_3_exfil_1_b", var_3, undefined, undefined);
    [[var_0]]("loc_3_exfil_1_c", 0, 0, 0, var_1, undefined, "loc_3_exfil_1_c", var_3, "loc_3_exfil_1_c_reinforce", undefined);
    [[var_0]]("loc_3_exfil_1_c_reinforce", 0, 0, 0, var_1, undefined, "loc_3_exfil_1_c_reinforce", var_3, undefined, undefined);
    [[var_0]]("loc_3_exfil_2", 0, 0, 0, var_1, undefined, "loc_3_exfil_2", var_2, "loc_3_exfil_2_reinforce", 10);
    [[var_0]]("loc_3_exfil_2_reinforce", 0, 0, undefined, var_1, 0, "loc_3_exfil_2_reinforce", var_3, undefined, undefined);
    [[var_0]]("loc_3_exfil_2_reinforce", 0, 0, undefined, var_1, 0, "loc_3_exfil_2_reinforce_sniper", var_3, undefined, undefined);
    return;
  }

  [[var_0]]("harness_loc_3", 4, 4, 4, 0.1, undefined, "harness_loc_3", undefined, "harness_loc_3_reinforce", 8);
  [[var_0]]("harness_loc_3_reinforce", 5, 6, 100, [ &wave_reinforce, 3, 10], 0, "harness_loc_3_reinforce", &end_spawn_group, undefined, undefined);
  [[var_0]]("harness_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 3, 25], 0, "harness_loc_3_reinforce_snipers", &end_spawn_group, undefined, undefined);
  [[var_0]]("harness_loc_3_reinforce", 1, 1, 100, [ &wave_reinforce, 20, 25], 0, "harness_loc_3_reinforce_snipers_2", &end_spawn_group, undefined, undefined);
  [[var_0]]("harness_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 20, 25], 0, "harness_loc_3_reinforce_rpg", &end_spawn_group, undefined, undefined);
  [[var_0]]("harness_loc_3_reinforce", 2, 5, 100, [ &wave_reinforce, 1, 10, &reinforce_after_door_section], 0, "harness_loc_3_reinforce_2", &end_spawn_group, undefined, undefined);
  [[var_0]]("escort_loc_3", 4, 4, 4, 0.1, undefined, "harness_loc_3", undefined, "escort_loc_3_reinforce", 8);
  [[var_0]]("escort_loc_3_reinforce", 5, 8, 100, [ &wave_reinforce, 1, 10], 0, "escort_loc_3_reinforce", &end_spawn_group, undefined, undefined);
  [[var_0]]("escort_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 1, 30], 0, "harness_loc_3_reinforce_snipers", &end_spawn_group, undefined, undefined);
  [[var_0]]("escort_loc_3_reinforce", 1, 1, 100, [ &wave_reinforce, 1, 30], 0, "harness_loc_3_reinforce_snipers_2", &end_spawn_group, undefined, undefined);
  [[var_0]]("escort_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 1, 25], 0, "harness_loc_3_reinforce_rpg", &end_spawn_group, undefined, undefined);
  [[var_0]]("loc_3_exfil_1_a", 5, 5, 5, 0.1, undefined, "loc_3_exfil_1_a", &end_spawn_group, undefined, undefined);
  [[var_0]]("loc_3_exfil_1_b", 6, 6, 6, 0.1, undefined, "loc_3_exfil_1_b", &end_spawn_group, undefined, undefined);
  [[var_0]]("loc_3_exfil_1_c", 5, 5, 5, 0.1, undefined, "loc_3_exfil_1_c", &end_spawn_group, "loc_3_exfil_1_c_reinforce", undefined);
  [[var_0]]("loc_3_exfil_1_c_reinforce", 6, 11, 0, 1, undefined, "loc_3_exfil_1_c_reinforce", &end_spawn_group, undefined, undefined);
  [[var_0]]("loc_3_exfil_2", 1, 1, 1, 0.1, undefined, "loc_3_exfil_2", undefined, "loc_3_exfil_2_reinforce", 10);
  [[var_0]]("loc_3_exfil_2_reinforce", 12, 16, undefined, [ &wave_reinforce, 1, 10], 0, "loc_3_exfil_2_reinforce", &end_spawn_group, undefined, undefined);
  [[var_0]]("loc_3_exfil_2_reinforce", 1, 2, undefined, [ &wave_reinforce, 1, 10], 0, "loc_3_exfil_2_reinforce_sniper", &end_spawn_group, undefined, undefined);
}

function wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(isDefined(var_3) && !isDefined(var_0.custom_var_done)) {
    if(isbuiltinfunction(var_3)) {
      [[var_3]](var_0);
    } else if(isint(var_3) || isfloat(var_3)) {
      wait var_3;
    }

    var_0.custom_var_done = 1;
  }

  if(var_0.activecount <= var_0.min_size) {
    return var_1;
  }

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount >= var_0.min_size) {
      wait 0.25;
    }

    return var_2;
  }

  return 15;
}

function reinforce_after_door_section(var_0) {
  level scripts\engine\utility::ref_143A8("cut_1", "cut_2", "cut_3", "cut_4", "started_cutting");
}

function end_spawn_group(var_0) {
  thread _end_spawn_group(level);
}

function _end_spawn_group(var_0) {
  level endon("game_ended");
  level scripts\engine\utility::ref_143A5("helidown_done", "objective_heli_down_kill_hvt");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function show_vip_waypoints(var_0) {
  level endon("game_ended");
  level.escort_vip = self;
  var_1 = scripts\cp\cp_objectives::requestworldid("vip", 10);
  objective_icon(var_1, "hud_icon_jackal_alert");
  objective_setshowdistance(var_1, 1);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "current");
  objective_setplayintro(var_1, 0);
  level.escort_vip.waypointobjnum = var_1;

  foreach(var_4, var_3 in var_0) {
    objective_setlocation(var_1, var_4, var_3.origin + (0, 0, 40));
    thread cleanup_waypoint_when_near(var_3, self);
  }

  scripts\engine\utility::ref_143A6("death", "vip_used", "cleanup_vip_waypoints");

  foreach(var_3 in var_0) {
    objective_unsetlocation(var_1, var_4);
  }
}

function cleanup_waypoint_when_near(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("vip_used");
  var_2 = squared(750);

  for(;;) {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) > var_2) {
        continue;
      }

      if(sighttracepassed(var_5 getEye(), self.origin + (0, 0, 10), 0, var_5, 1)) {
        var_3 = 1;
      }

      if(var_3 && sighttracepassed(var_5 getEye(), var_0.origin + (0, 0, 50), 0, var_0.attacker, 1)) {
        if(isDefined(self.attacker) && isalive(self.attacker)) {
          thread vip_dies_soon();
        }
      }
    }

    if(var_3) {
      if(distancesquared(var_0.origin, self.origin) < 10000) {
        var_0 playSound("dx_cps_plt_rescue_pilot_eject_found_10");
      }

      break;
    }

    wait 0.1;
  }

  objective_unsetlocation(var_0.waypointobjnum, var_1);
}

function vip_dies_soon() {
  if(isDefined(self.dying_soon)) {
    return;
  }

  self endon("death");
  self endon("saved");
  self.dying_soon = 1;
  var_0 = gettime() + 25000;

  if(getdvarint("timetodie") > 0) {
    var_0 = gettime() + getdvarint("timetodie") * 1000;
  }

  var_1 = squared(128);
  iprintlnbold("Player got close - threatening to shoot pilot");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT2");

  for(var_2 = gettime() + 4000; gettime() < var_0 && isDefined(self.attacker) && isalive(self.attacker); var_2 = gettime() + 4000) {
    wait 0.05;

    foreach(var_4 in level.players) {
      if(abs(self.origin[2] - var_4.origin[2]) > 100) {
        continue;
      }

      if(distancesquared(self.origin, var_4.origin) < var_1) {
        level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT3");
        wait 2;
        self.attacker notify("scene_interrupt");
        self.attacker thread scripts\cp\cp_skits::death_fight2(self);
        return;
      }
    }

    if(gettime() >= var_2) {
      level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT");
      level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT2");
    }
  }

  self.attacker notify("scene_interrupt");
  self.attacker thread scripts\cp\cp_skits::death_fight2(self);
}

function downed_pilot_dialogue() {
  self endon("death");

  while(!scripts\cp\utility::any_player_nearby(self.origin, 160000)) {
    wait 0.1;
  }

  self playSound("dx_cps_plt_rescue_pilot_injury_found_10");
  thread downed_pilot_nag();
}

function downed_pilot_nag() {
  self endon("death");
  self endon("convoy_pickedup_hvt");
  self endon("harness_cut");

  for(;;) {
    wait randomintrange(30, 45);
    self playSound("dx_cps_plt_rescue_pilot_injury_found_20");
  }
}

function init_cutout_anims() {
  level.scr_animtree["cutter_player"] = #animtree;
  level.scr_anim["cutter_player"]["pullout"] = $sdr_cp_hostage_cutout_blima_dst_pullout_player;
  level.scr_animname["cutter_player"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_player";
  level.scr_eventanim["cutter_player"]["pullout"] = "pullout_saw";
  level.scr_anim["cutter_player"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_player;
  level.scr_animname["cutter_player"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_player";
  level.scr_eventanim["cutter_player"]["putaway"] = "putaway_saw";
  level.scr_anim["cutter_player"]["cut_1"] = % sdr_cp_hostage_cutout_blima_dst_1_player;
  level.scr_animname["cutter_player"]["cut_1"] = "sdr_cp_hostage_cutout_blima_dst_1_player";
  level.scr_eventanim["cutter_player"]["cut_1"] = "player_cut_1";
  level.scr_anim["cutter_player"]["cut_2"] = % sdr_cp_hostage_cutout_blima_dst_2_player;
  level.scr_animname["cutter_player"]["cut_2"] = "sdr_cp_hostage_cutout_blima_dst_2_player";
  level.scr_eventanim["cutter_player"]["cut_2"] = "player_cut_2";
  level.scr_anim["cutter_player"]["cut_3"] = % sdr_cp_hostage_cutout_blima_dst_3_player;
  level.scr_animname["cutter_player"]["cut_3"] = "sdr_cp_hostage_cutout_blima_dst_3_player";
  level.scr_eventanim["cutter_player"]["cut_3"] = "player_cut_3";
  level.scr_anim["cutter_player"]["cut_4"] = % sdr_cp_hostage_cutout_blima_dst_4_player;
  level.scr_animname["cutter_player"]["cut_4"] = "sdr_cp_hostage_cutout_blima_dst_4_player";
  level.scr_eventanim["cutter_player"]["cut_4"] = "player_cut_4";
  level.scr_anim["cutter_player"]["hvt_cockpit_pickup"] = % vm_hostage_pickup_blimadestroyed_player;
  level.scr_animname["cutter_player"]["hvt_cockpit_pickup"] = "vm_hostage_pickup_blimadestroyed_player";
  level.scr_eventanim["cutter_player"]["hvt_cockpit_pickup"] = "hvt_cockpit_pickup";
  level.scr_animtree["saw"] = #animtree;
  level.scr_anim["saw"]["pullout"] = % sdr_cp_hostage_cutout_blima_dst_pullout_saw;
  level.scr_animname["saw"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_saw";
  level.scr_anim["saw"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_saw;
  level.scr_animname["saw"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_saw";
  level.scr_anim["saw"]["cut_1"] = % sdr_cp_hostage_cutout_blima_dst_1_saw;
  level.scr_animname["saw"]["cut_1"] = "sdr_cp_hostage_cutout_blima_dst_1_saw";
  level.scr_anim["saw"]["cut_2"] = % sdr_cp_hostage_cutout_blima_dst_2_saw;
  level.scr_animname["saw"]["cut_2"] = "sdr_cp_hostage_cutout_blima_dst_2_saw";
  level.scr_anim["saw"]["cut_3"] = % sdr_cp_hostage_cutout_blima_dst_3_saw;
  level.scr_animname["saw"]["cut_3"] = "sdr_cp_hostage_cutout_blima_dst_3_saw";
  level.scr_anim["saw"]["cut_4"] = % sdr_cp_hostage_cutout_blima_dst_4_saw;
  level.scr_animname["saw"]["cut_4"] = "sdr_cp_hostage_cutout_blima_dst_4_saw";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["cockpit_idle"] = % sdr_cp_hostage_pickup_blimadestroyed_idle_pilot;
  level.scr_animname["hvt"]["cockpit_idle"] = "sdr_cp_hostage_pickup_blimadestroyed_idle_pilot";
  level.scr_animname["hvt"]["cockpit_pickup"] = "sdr_cp_hostage_pickup_blimadestroyed_pilot";
  level.scr_anim["hvt"]["cockpit_pickup"] = % sdr_cp_hostage_pickup_blimadestroyed_pilot;
  level.scr_animtree["hvt_vm"] = #animtree;
  level.scr_anim["hvt_vm"]["cockpit_pickup_vm"] = % vm_hostage_pickup_blimadestroyed_pilot;
  level.scr_animname["hvt_vm"]["cockpit_pickup_vm"] = "vm_hostage_pickup_blimadestroyed_pilot";
}

function init_exfil_anims() {
  level.scr_animtree["player_vip_blima"] = #animtree;
  level.scr_anim["player_vip_blima"]["blima_drop_l"] = % vm_hostage_dropoff_blima_l_player;
  level.scr_animname["player_vip_blima"]["blima_drop_l"] = "vm_hostage_dropoff_blima_L_player";
  level.scr_eventanim["player_vip_blima"]["blima_drop_l"] = "plyr_vip_blima_drop_l";
  level.scr_anim["player_vip_blima"]["blima_drop_r"] = % vm_hostage_dropoff_blima_r_player;
  level.scr_animname["player_vip_blima"]["blima_drop_r"] = "vm_hostage_dropoff_blima_R_player";
  level.scr_eventanim["player_vip_blima"]["blima_drop_r"] = "plyr_vip_blima_drop_r";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_pilot;
  level.scr_animname["hvt"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_pilot";
  level.scr_anim["hvt"]["blima_drop_r_idle"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_r_idle"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_pilot";
  level.scr_anim["hvt"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_pilot;
  level.scr_animname["hvt"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_pilot";
  level.scr_anim["hvt"]["blima_drop_l_idle"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_pilot;
  level.scr_animname["hvt"]["blima_drop_l_idle"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot";
  level.scr_animtree["exfil_chopper"] = #animtree;
  level.scr_anim["exfil_chopper"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_blima";
  level.scr_anim["exfil_chopper"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_blima";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_in"] = "sdr_cp_hostage_dropoff_blima_L_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_out"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_in"] = % sdr_cp_hostage_dropoff_blima_r_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_in"] = "sdr_cp_hostage_dropoff_blima_R_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_r_idle_out"] = % sdr_cp_hostage_dropoff_blima_r_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_r_idle_out"] = "sdr_cp_hostage_dropoff_blima_R_idle_outro_ally";
}

function idle_pilot_loop(var_0) {
  var_0 endon("cutout");
  var_0 endon("death");

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0.body, "cockpit_idle", "tag_origin");
  }
}

function cut_objective_progress(var_0, var_1) {
  var_0 endon("last_stand");
  var_0 endon("disconnect");

  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  while(self.cut_progress <= var_1 && var_0 useButtonPressed()) {
    objective_setprogress(self.cut_progress, var_1);
    wait 0.05;
    self.cut_progress += 0.05;
  }

  return self.cut_progress >= var_1;
}

function wait_for_pilot_pickup(var_0) {
  if(!isDefined(var_0.interaction_handle)) {
    var_0.interaction_handle = spawn("script_model", var_0.body gettagorigin("j_helmet"));
    var_0.interaction_handle linkTo(var_0);
  }

  var_0.pickup_disabled = 0;
  var_0.interaction_handle makeusable();
  var_0.interaction_handle setHintString(&"CP_BR_SYRK_OBJECTIVES/CUT_PILOT");
  var_0.interaction_handle sethintonobstruction("show");
  var_0.interaction_handle setCursorHint("HINT_BUTTON");
  var_0.interaction_handle sethintdisplayrange(160);
  var_0.interaction_handle sethintdisplayfov(80);
  var_0.carryobjectasset = "hostage_pilot";
  var_0.idleanim = "sdr_cp_hostage_dropoff_ground_idle_pilot";
  level.hostage_onusefunc = &pilot_pickup_from_cockpit;
  var_0.interaction_handle waittill("trigger", var_1);
  var_0 scripts\cp\cp_pickup_hostage::hostage_onuse(var_1, "heli", self);
  var_0.interaction_handle delete();
  var_0.interaction_handle = undefined;
}

function pilot_pickup_from_cockpit(var_0, var_1) {
  var_1 notify("cutout");
  var_1.drophintstring = "drop_pilot_hostage";
  var_1.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  var_1.interaction_handle makeunusable();
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_2 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_2, 0);
  var_0.gunlessweapon = var_2;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_4 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"]["hvt_cockpit_pickup"]);
  var_5 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"]["hvt_cockpit_pickup"]);
  var_0 freezecontrols(1);
  var_0 setstance("stand");
  var_0 scripts\engine\utility::ref_143B9(1, "weapon_change");
  var_0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var_0, "cutter_player");
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "hvt_cockpit_pickup");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var_0, 0.5);
  var_0.vmvip = spawn("script_model", var_1.origin);
  var_0.vmvip.angles = var_1.angles;
  var_0.vmvip setModel(var_1.body.model);
  var_0.vmvip.animname = "hvt_vm";
  var_0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var_0.vmvip hide();
  var_0.vmvip showtoplayer(var_0);
  var_1 hidefromplayer(var_0);

  if(isDefined(var_1.head)) {
    var_1.head hidefromplayer(var_0);
  }

  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "hvt_cockpit_pickup");
  thread scripts\common\anim::anim_single_solo(var_1.body, "cockpit_pickup");
  thread scripts\common\anim::anim_single_solo(var_0.vmvip, "cockpit_pickup_vm");
  self scriptmodelplayanim("vm_hostage_pickup_blimadestroyed_blimadst");
  self scriptmodelplayanim("sdr_cp_hostage_pickup_blimadestroyed_blimadst");
  var_6 = getanimlength(%vm_hostage_pickup_blimadestroyed_player);
  wait var_6 + 0.1;
  var_1 linkTo(var_0);
  var_1.body hide();
  var_0.vmvip delete();
  var_7 = scripts\cp\cp_pickup_hostage::run_stealth_funcs(var_0);
  var_0 setOrigin(var_7);
  waitframe();
  var_0 notify("remove_rig");
  var_0 freezecontrols(0);
}

function create_long_cut_interactions(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_0.angles[1], 0));
  var_4 = anglestoleft((0, var_0.angles[1], 0));
  var_5 = var_0.origin;
  var_6 = var_5 + var_3 * 125 + var_4 * 72 + (0, 0, 50);
  var_7 = create_long_cut_interaction(var_6, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ", ["cut_3", "cut_4"], var_1, var_0, var_2);
  level.cut_interactions = [var_7];

  foreach(var_9 in level.cut_interactions) {
    if(isDefined(var_9)) {
      var_9 makeusable();
    }
  }
}

function create_long_cut_interaction(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_0);
  var_6 setModel("tag_origin");
  waitframe();
  var_6 setHintString(var_1);
  var_6 setCursorHint("HINT_BUTTON");
  var_6 sethintdisplayrange(200);
  var_6 sethintdisplayfov(65);
  var_6 setuserange(72);
  var_6 setusefov(65);
  var_6 sethintonobstruction("show");
  var_6 setuseholdduration("duration_none");
  var_6.targetname = "harness_interaction";

  foreach(var_8 in var_2) {
    if(!scripts\engine\utility::flag_exist(var_8)) {
      scripts\engine\utility::flag_init(var_8);
    }
  }

  thread use_think_long_cut(var_6, var_2, var_3, var_4);
  return var_6;
}

function use_think_long_cut(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(isDefined(level.cut_interactions)) {
      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5)) {
          var_5 makeusable();
        }
      }
    }

    self waittill("trigger", var_7);
    level notify("started_cutting");

    if(isDefined(var_7)) {
      if(!var_7 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5)) {
          var_5 makeunusable();
        }
      }

      if(!cutout_pilot_long(var_2, var_1, var_7, var_0, var_3)) {
        wait 1;
        continue;
      }
    }

    foreach(var_11 in var_0) {
      if(scripts\engine\utility::flag_exist(var_11)) {
        scripts\engine\utility::flag_set(var_11);
      }
    }

    if(isDefined(level.cut_interactions)) {
      foreach(var_5 in level.cut_interactions) {
        if(isDefined(var_5)) {
          var_5 makeusable();
        }
      }
    }

    self delete();
  }
}

function cutout_pilot_long(var_0, var_1, var_2, var_3) {
  var_0 makeunusable();
  var_4 = getcompleteweaponname("iw8_gunless_infil");
  var_1 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);
  var_5 = var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_4, 0);
  var_1 scripts\common\utility::allow_weapon_switch(0);
  var_1.ref_140AE = 1;
  var_6 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"][var_2[0]]);
  var_7 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"][var_2[0]]);
  var_1 setOrigin(var_6, 1);
  var_1 setplayerangles(var_7);
  var_1 setstance("stand");
  var_8 = spawn("script_model", self.origin);
  var_8 setModel("tool_portable_gas_cutter_01_cp");
  var_8.angles = self.angles;
  var_8.animname = "saw";
  var_8 hide();
  var_1 forceusehinton(&"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  var_8 useanimtree(level.scr_animtree["saw"]);
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "cutter_player");
  var_1 cameraset("camera_custom_orbit_2_cp");
  objective_addclienttomask(var_3.objectiveindex, var_1);
  objective_hidefromplayersinmask(var_3.objectiveindex);
  var_5 = wait_for_section_cut_long(var_1, var_8, var_2);

  if(!istrue(var_5)) {
    var_1 notify("cut_failed");
  }

  var_1 cameradefault();
  objective_removeclientfrommask(var_3.objectiveindex, var_1);
  var_1 forceusehintoff();
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 scripts\common\utility::allow_weapon_switch(1);
  var_1 scripts\cp\cp_weapons::_takeweapon(var_4);
  var_1 scripts\cp\cp_weapons::forcevalidweapon();
  var_1 setstance("stand");
  var_1.ref_140AE = undefined;

  if(istrue(var_5)) {
    level notify("cutout_pilot_long_success");
    return true;
  }

  return false;
}

function wait_for_section_cut_long(var_0, var_1, var_2) {
  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  var_3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
  var_4 = getanimlength(level.scr_anim["cutter_player"][var_2[0]]);
  var_5 = getanimlength(level.scr_anim["cutter_player"][var_2[1]]);
  var_6 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "pullout");
  thread scripts\common\anim::anim_single_solo(var_1, "pullout");
  wait 0.25;
  var_1 show();
  wait 0.25;
  var_1 playLoopSound("saw_spinup");
  wait var_3 - 0.25;
  var_7 = var_4 + var_5;

  if(isDefined(level.helidown_long_cut_len)) {
    var_7 = level.helidown_long_cut_len;
  }

  thread do_cut_anims_long(var_0, var_1, var_2);
  cut_progress_think(var_0, var_7);
  var_0 notify("cut_done");
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing", 0);
  var_1 stoploopsound();
  playsoundatpos(var_1.origin, "saw_spinup_stop");
  wait 0.5;

  if(!scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    thread scripts\common\anim::anim_single_solo(var_1, "putaway");
    scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "putaway");
  }

  var_1 hide();
  return self.cut_progress >= var_7;
}

function do_cut_anims_long(var_0, var_1, var_2) {
  var_0 endon("cut_failed");
  var_0 endon("cut_done");
  var_3 = getanimlength(level.scr_anim["cutter_player"][var_2[0]]);
  var_4 = getanimlength(level.scr_anim["cutter_player"][var_2[1]]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2[0]);
  thread scripts\common\anim::anim_single_solo(var_1, var_2[0]);
  wait 0.5;
  var_1 setscriptablepartstate("sparks", "on");
  wait var_3;
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2[1]);
  thread scripts\common\anim::anim_single_solo(var_1, var_2[1]);
  wait var_4;
}

function cut_progress_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 setclientomnvar("ui_securing", 11);
  var_0.hasprogressbar = 1;

  while(var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 scripts\cp\utility::is_valid_player() && var_0 useButtonPressed() && self.cut_progress < var_1) {
    level notify("cutout_pilot_progress_fraction", self.cut_progress / var_1);
    var_0 setclientomnvar("ui_securing_progress", self.cut_progress / var_1);
    wait 0.05;
    self.cut_progress += 0.05;
  }
}

function exfil_players_on_rescue_fail() {
  level endon("game_ended");
  level endon("pilot_rescued");
  level waittill("objective_heli_down_kill_hvt");
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();
  level notify("call_exfil", (0, 0, 0));
}