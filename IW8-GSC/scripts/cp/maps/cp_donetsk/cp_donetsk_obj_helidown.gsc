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

function emptyfunc(var0) {}

function helidown_start_func_debug(var0) {
  setDvar("helidown_event", "harness");
}

function helidown_start_func(var0) {
  level notify("event_started");
  setDvar("helidown_event", "harness");
  wait 5;
  thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("objective_heli_down_start", "scripts/cp/maps/cp_donetsk/cp_donetsk_objectives_events.csv", 1);
}

function helidown_escort_start_func(var0) {
  setDvar("helidown_event", "escort");
  setDvar("helidown_exfil_loc", "1");
  wait 5;
  thread begin_wave_spawning();
  scripts\cp\cp_objectives_events::try_start_event("objective_heli_down_start", "scripts/cp/maps/cp_donetsk/cp_donetsk_objectives_events.csv", 1);
}

function heli_down_init(var0) {
  if(!scripts\engine\utility::flag_exist("event_heli_downed_completed")) {
    scripts\engine\utility::flag_init("event_heli_downed_completed");
  }

  scripts\engine\utility::flag_clear("event_heli_downed_completed");
  thread main(level);
}

function objective_heli_down_start(var0) {
  level endon("game_ended");
  var1 = 0;
  var2 = var0.showobjprogress * -1;

  if(getdvarint("scr_event_helidown_short", 0) == 1) {
    var0.showobjprogress = 30;
    var2 = 30;
  }

  objective_setownerteam(var0.objectiveindex, "allies");

  while(var1 <= var2) {
    wait 0.25;
    var1 += 0.25;
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

function main(var0) {
  if(getdvarint("enable_pvpe") == 1) {
    thread exfil_players_on_rescue_fail();
  }

  level endon("objective_heli_down_kill_hvt");
  setdvarifuninitialized("helidown_harness_loc", "3");
  setdvarifuninitialized("helidown_escort_loc", "3");
  setdvarifuninitialized("helidown_exfil_loc", "1");
  setdvarifuninitialized("helidown_event", "harness");
  var1 = ["harness", "escort"];
  var2 = scripts\engine\utility::random(var1);

  if(getDvar("helidown_event") != "") {
    var2 = getDvar("helidown_event");
  }

  if(var2 == "escort") {
    scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");
  }

  level.event_heli_type = var2;
  var3 = spawn_helidown_heli(var0);
  shoot_down_heli(var3, var0);
  var3.death_fx_on_self = 1;
  var4 = undefined;

  if(var2 == "escort") {
    var4 = scripts\cp\cp_vip::vip_spawn(var3, 0, "vip_spawn");
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
    var4.script_noteworthy = "event_heli_downed_pilot";
    var4.nodamage = 1;
    thread vip_parachute(var4, var3, var0);
  }

  var5 = var3.vehicle_spawner.script_noteworthy;
  var6 = heli_crash(var3, var0, var2);
  var6.location = var5;
  init_cutout_anims();

  switch (var2) {
    case "harness":
      thread heli_corpse_burn();
      rescue_type_harness(var6, var0);
      break;
    case "escort":
      rescue_type_escort(var6, var0, var4);
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

function rescue_type_harness(var0, var1) {
  var1.label = &"CP_BR_SYRK_OBJECTIVES/OBJ_RESCUE_PILOT";
  var2 = spawn_downed_pilot(var0, var1);
  var2 endon("death");
  var2 endon("bleedout");
  level.helidown_downed_pilot = var2;
  thread downed_pilot_dialogue();
  pilot_wait_for_rescue(var1, var2, var0);
  create_long_cut_interactions(var0, var2, var1);
  wait_for_door_cut_long(var1, var2);
  remove_pilot_from_cockpit(var0, var1, var2);
  enable_pilot_carry(var2);
  exfil_pilot(var2, var1, var0);
}

function rescue_type_escort(var0, var1, var2) {
  var2 waittill("hidden");
  thread remove_heli_corpse_after_timeout(var0, 0);
  thread escort_vip_to_chopper(var2, var2, var0);
  var3 = var2 scripts\engine\utility::ref_143b4("death", "exfil");

  if(var3 == "death") {
    var1 notify("vip_died");
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_fail_10", "allies");
    return;
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_exfil_10", "allies");
}

function vip_parachute(var0, var1, var2) {
  vip_spawn_parachute(var1, var0);
  vip_parachute_nearby(var1, var0);
  vip_update_objective_on_landed(var0, var1, var2);
  var0 setCanDamage(0);
  var0.ignoreme = 1;
  var0.ignoreall = 1;
  vip_go_and_hide(var0, var2);
}

function vip_spawn_parachute(var0, var1) {
  var1.chute = spawn("script_model", var0.origin);
  var1.chute.angles = var0.angles;
  var1.chute setModel("ctl_parachute_player");
  var1 allowedstances("stand");
  var1 linkTo(var1.chute, "tag_player", (0, 0, 0), (0, 0, 0));
  var1.chute scriptmodelplayanim("sdr_mp_parachute_idle");
  var2 = var1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "parachute_idle");
  var3 = var1 scripts\asm\asm::asm_getxanim("animscripted", var2);
}

function vip_parachute_nearby(var0, var1) {
  var2 = scripts\engine\utility::get_array_of_closest(var0.origin, scripts\engine\utility::getStructArray("vip_land", "targetname"), undefined, 2, 10000);
  var3 = scripts\engine\utility::random(var2);

  if(getDvar("helidown_escort_loc", "") != "") {
    var4 = getDvar("helidown_escort_loc");

    foreach(var6 in var2) {
      if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "escort_loc_" + var4) {
        var3 = var6;
        break;
      }
    }
  }

  var1.landing_spot = var3;
  thread proximity_spawn(level, var1.landing_spot);
  var1.chute moveTo(var3.origin + (0, 0, 350), 12, 1, 1);
  var1.chute waittill("movedone");
  var1 unlink();
  var1 forceteleport(var3.origin, var3.angles);
  var1.chute delete();
  return var3;
}

function vip_update_objective_on_landed(var0, var1, var2) {
  var3 = spawnStruct();
  var2.objicon = "hud_icon_warning";
  var2.label = &"CP_BR_SYRK_OBJECTIVES/LOCATE_PILOT";
  var3.targetname = "downed_pilot_chosen";
  var4 = scripts\engine\utility::getStructArray(var0.landing_spot.target, "targetname");

  foreach(var6 in var4) {
    if(!isDefined(var6.script_noteworthy)) {
      continue;
    }

    if(var6.script_noteworthy == "obj_loc") {
      var3.origin = var6.origin + (0, 0, 65);
    }
  }

  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_update_10", "allies");
  scripts\cp\utility::addtostructarray("targetname", "downed_pilot_chosen", var3);
  thread complete_killer(var0, undefined);
  scripts\engine\utility::flag_set("event_heli_downed_completed");
}

function vip_go_and_hide(var0, var1) {
  scripts\cp\cp_vip::create_vip_trigger(var0);
  var2 = [];
  var3 = scripts\engine\utility::getStructArray(var0.landing_spot.target, "targetname");

  foreach(var5 in var3) {
    if(!isDefined(var5.script_noteworthy) || var5.script_noteworthy != "obj_loc") {
      var2 = var5;
    }
  }

  var7 = scripts\engine\utility::random(var2);

  if(getdvarint("scr_helidown_hidingspot", -1) > -1) {
    foreach(var9 in var2) {
      if(isDefined(var9.location) && int(var9.location) == getdvarint("scr_helidown_hidingspot")) {
        var7 = var9;
        break;
      }
    }
  }

  if(getdvarint("show_helidown_hidingspots") > 0) {
    thread debug_hiding_spots(var0, var2);
  }

  thread show_vip_waypoints(var0);
  var11 = getclosestpointonnavmesh(var7.origin);
  var0.goalradius = 32;
  var0 setgoalpos(var7.origin);
  var0 waittill("goal");
  wait 1;

  if(!isDefined(var7.angles)) {
    var7.angles = (0, 0, 0);
  }

  var12 = anglesToForward(var7.angles) * 15;
  var13 = spawn_pilot_attacker(var11, var7.angles);
  var13 scripts\cp\cp_skits::setup_fight_guy();
  var0 scripts\cp\cp_skits::setup_fight_guy();
  var0 forceteleport(var11 + var12, var7.angles);
  var0.anchor = spawn("script_origin", var11 + var12);
  var0.anchor.angles = var7.angles;
  var0 linkTo(var0.anchor);
  var13.anchor = spawn("script_origin", var11);
  var13.anchor.angles = var7.angles;
  var13 linkTo(var13.anchor);
  var0.attacker = var13;
  thread scripts\cp\cp_skits::hostage_rescue_meatshield(undefined, undefined, undefined, undefined, var13, var0, 300);
  var0 notify("hidden");
}

function spawn_pilot_attacker(var0, var1) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "vip_spawn");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, "badguy")) {
      var2 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_cp_rus_desert_shotgun", var0, var1);

      if(isDefined(var2)) {
        var2 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var2 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "vip_spawn");
  var2.scripted_mode = 1;
  var2.ignoreall = 1;
  var2.dontkilloff = 1;
  var2.health = 25;
  var2.maxhealth = 25;
  var2.suppressionthreshold = 0;
  return var2;
}

function debug_hiding_spots(var0, var1) {
  self endon("death");
  self endon("vip_used");

  for(;;) {
    foreach(var3 in var0) {
      if(var3 == var1) {}
    }

    wait 0.5;
  }
}

function spawn_helidown_heli(var0) {
  var1 = get_heli_spawn_struct();
  var2 = spawn_objective_heli(var1);
  var2 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(scripts\engine\utility::getclosest(var2.origin, scripts\engine\utility::getStructArray("heli_down_path", "targetname")));
  var2 playLoopSound("cp_br_syrk_chopper_engine_donut_dist");
  level thread scripts\common\vehicle_paths::gopath(var2);
  return var2;
}

function get_heli_spawn_struct() {
  jumpiftrue(isDefined(level.heli_down_structs)) LOC_0000001e;
  level.heli_down_structs = scripts\engine\utility::getStructArray("helidown_heli", "targetname");

  for(;;) {
    var0 = scripts\engine\utility::random(level.heli_down_structs);

    if(!isDefined(level.last_helidown_loc) || var0 != level.last_helidown_loc) {
      break;
    }

    wait 0.05;
  }

  level.heli_down_structs = scripts\engine\utility::array_remove(level.heli_down_structs, var0);

  if(level.heli_down_structs.size == 0) {
    level.heli_down_structs = scripts\engine\utility::getStructArray("helidown_heli", "targetname");
  }

  if(getdvarint("helidown_harness_loc") > 0) {
    var1 = getdvarint("helidown_harness_loc");
    var2 = scripts\engine\utility::getStructArray("helidown_heli", "targetname");

    foreach(var4 in var2) {
      if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == "loc_" + var1) {
        return var4;
      }
    }
  }

  level.last_helidown_loc = var0;
  return var0;
}

function spawn_objective_heli(var0) {
  var1 = scripts\common\vehicle::vehicle_spawn(var0);
  var1.vehicle_skipdeathmodel = 1;
  var1.death_fx_on_self = 1;
  return var1;
}

function shoot_down_heli(var0, var1) {
  self waittill("noteworthy");
  var2 = anglestoleft(self.angles);
  var3 = getgroundposition(self.origin, 16);
  var4 = magicbullet("attack_drone_missile_cp", var3, self.origin);
  var4 missile_settargetEnt(self);
  var4 missile_setflightmodedirect();
  target_hit_monitor(var4, self);
}

function target_hit_monitor(var0, var1, var2, var3, var4) {
  var0 endon("death");
  var5 = var1.origin - var0.origin;

  for(;;) {
    if(missile_hit_target(var0, var1, var5)) {
      break;
    }

    waitframe();
  }

  playFX(level._effect["helidown_rpghit"], var0.origin);
  playFX(level._effect["helidown_sparks"], var1.origin);
  var0 detonate();
}

function missile_hit_target(var0, var1, var2) {
  if(distancesquared(var0.origin, var1.origin) <= 90000) {
    return true;
  }

  var3 = var1.origin - var0.origin;

  if(vectordot(var2, var3) < 0) {
    return true;
  }

  return false;
}

#using_animtree("script_model");

function heli_crash(var0, var1, var2) {
  var3 = scripts\engine\utility::getclosest(var0.origin, level.vehicle.helicopter_crash_locations);

  if(isDefined(var0.perferred_crash_location)) {
    var3 = var0.perferred_crash_location;
  }

  if(isDefined(var2) && var2 == "harness") {
    thread proximity_spawn(level, var3.origin);
  }

  var4 = undefined;

  if(isDefined(var2)) {
    var4 = scripts\cp\cp_objectives::requestworldid("helicopter_spawn", 10);
    objective_icon(var4, "hud_icon_warning");
    objective_setminimapiconsize(var4, "icon_regular");
    objective_setshowdistance(var4, 1);
    objective_onentity(var4, var0);
    objective_setbackground(var4, 1);
    objective_setlabel(var4, &"CP_BR_SYRK_OBJECTIVES/HELI_DISTRESS");
    objective_state(var4, "current");
    objective_setplayintro(var4, 0);
    objective_setownerteam(var4, "allies");
  }

  if(!isDefined(var3.angles)) {
    var3.angles = (0, 0, 0);
  }

  level.vehicle.templates.vehicle_death_fx["script_vehicle_iw8_lbravo"][0].effect = level._effect["helidown_tailfire"];
  var0 playSound("cp_br_syrk_chopper_rocket_explode");
  var0 stoploopsound("cp_br_syrk_chopper_engine_donut_dist");
  var0 notify("death", level.players[0], "MOD_EXPLOSIVE", undefined, var0.origin);
  level notify("heli_crashing", var0);
  var0 playLoopSound("cp_br_syrk_chopper_dying_loop");
  var0 waittill("vehicle_deathComplete", var5, var6);
  var0 delete();
  var7 = spawn("script_model", var3.origin);
  var7.angles = var3.angles;
  var7 setModel("prop_veh8_mil_air_air_blima_dst");
  var8 = anglesToForward(var3.angles);
  var9 = anglestoleft(var3.angles);
  var7.navobs = createnavobstaclebybounds(var7.origin + var8 * -175 + var9 * 25, (375, 50, 150), var7.angles);
  var7.navobs2 = createnavobstaclebybounds(var7.origin + var8 * -425 + var9 * 150, (150, 50, 150), var7.angles);
  var7.clipmodel = spawn("script_model", var7.origin);
  var7.clipmodel clonebrushmodeltoscriptmodel(getEnt("helidown_clip", "targetname"));
  var7.clipmodel.angles = var7.angles;
  var7 useanimtree(#animtree);
  var7 scriptmodelplayanim("sdr_cp_hostage_pickup_blimadestroyed_idle_blimadst");

  if(isDefined(var3.script_noteworthy)) {
    var7.script_noteworthy = var3.script_noteworthy;
  }

  if(isDefined(var4)) {
    objective_delete(var4);
    scripts\cp\cp_objectives::freeworldid("helicopter_spawn");
  }

  var7 setscriptablepartstate("impact", "on");
  radiusdamage(var7.origin + (0, 0, 50), 750, 1000, 50);
  return var7;
}

function spawn_downed_pilot(var0, var1) {
  var2 = spawn("script_model", var0.origin);
  var2.body = spawn("script_model", var2.origin);
  var2.body setModel("british_pilot_fullbody");
  var2.bodymodel = "british_pilot_fullbody";
  var2.body.animname = "hvt";
  var2.body useanimtree(level.scr_animtree["hvt"]);
  var2.script_noteworthy = "event_heli_downed_pilot";
  thread idle_pilot_loop(var0);
  var3 = spawnStruct();
  var3.targetname = "downed_pilot_chosen";
  var3.origin = var2.origin + (0, 0, 25);
  scripts\cp\utility::addtostructarray("targetname", "downed_pilot_chosen", var3);
  thread complete_killer(var2, var0);
  scripts\engine\utility::flag_set("event_heli_downed_completed");
  return var2;
}

function exfil_pilot(var0, var1, var2) {
  var0 endon("death");
  var0 endon("bleedout");
  var3 = get_pilot_exfil(var2);
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_move_10", "allies");

  if(isDefined(var3.target)) {
    var4 = scripts\engine\utility::getStructArray(var3.target, "targetname");

    foreach(var6 in var4) {
      thread proximity_spawn(var6);
    }
  }

  wait 1;
  objective_setlabel(var1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  objective_setshowprogress(var1.objectiveindex, 0);
  objective_icon(var1.objectiveindex, "icon_waypoint_timed");
  objective_position(var1.objectiveindex, var3.origin + (0, 0, -100));
  var8 = spawn_evac_chopper(var3);
  var8.godmode = 1;
  var8.health = 10000;
  var8.maxhealth = 10000;
  vehicle_anims();
  script_model_anims(var8);
  scripts\cp\cp_pickup_hostage::init_anims();
  spawnhelihvtexfilactors(var8);
  thread leave_if_vip_dies(var8, var0);
  var9 = 0;
  level notify("helidown_exfil_struct_loc", var8.exfil_struct.origin);

  while(!var9) {
    if(distancesquared(var0.origin, var8.exfil_struct.origin) < get_vip_close_to_exfil_dist_sq()) {
      var9 = 1;
    }

    wait 1;
  }

  level notify("vip_close_to_exfil_location", var8);
  thread defend_while_chopper_arrives(var1);
  var1 waittill("defend_done");
  level notify("helidown_done");
  var8 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var8.exfil_struct, 1);
  var10 = anglesToForward(var8.angles);
  var11 = anglestoleft(var8.angles);
  var12 = var8.origin;
  var13 = var12 + var10 * 10 + var11 * 64 + (0, 0, -110);
  objective_position(var1.objectiveindex, var13);
  objective_setlabel(var1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  var14 = spawn("trigger_radius", var13 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var14 waittill("trigger", var15);
    var16 = var15.hostagecarried;
    var16 notify("stop_bleedout_timer");
    scripts\cp\cp_pickup_hostage::load_hvt(var15, var8);
    wait 1;
    break;
  }

  level notify("vip_loaded_to_exfil_chopper");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_injury_exfil_10", "allies");
  thread evac_pilot(level);

  foreach(var15 in level.players) {
    var15 setsoundsubmix("cp_matchend_music", 5);
    var15 setplayermusicstate("mus_west_victory");
  }
}

function get_vip_close_to_exfil_dist_sq() {
  if(isDefined(level.helidown_vip_close_to_exfil_dist_sq)) {
    return level.helidown_vip_close_to_exfil_dist_sq;
  }

  return 12250000;
}

function idle_exfilally_loop(var0) {
  self endon("death");
  var0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, "blima_drop_l_idle_in", "tag_origin");
  }
}

function spawnhelihvtexfilactors(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var1)) {
    var1 = "head_sas_urban_ar_rain";
  }

  var2 = self;
  var3 = spawn("script_model", var2.origin);
  var3 setModel("allied_pilot_fullbody_3");
  var3 useanimtree(level.scr_animtree["exfil_ally"]);
  var3.animname = "exfil_ally";
  var4 = getstartorigin(var2.origin, var2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var5 = getstartangles(var2.origin, var2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var3.origin = var4;
  var3.angles = var5;
  var3 linkTo(var2);
  var2.wmexfilally = var3;
  thread idle_exfilally_loop(var2);
}

function get_pilot_exfil(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.location + "_hvt_exfil", "targetname");
  var2 = scripts\engine\utility::random(var1);

  if(getdvarint("helidown_exfil_loc") > 0) {
    var3 = getdvarint("helidown_exfil_loc");

    foreach(var5 in var1) {
      if(var5.script_noteworthy == var0.location + "_exfil_" + var3) {
        return var5;
      }
    }
  }

  return var2;
}

function remove_pilot_from_cockpit(var0, var1, var2) {
  level notify("helidown_done");
  objective_setlabel(var1.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/REMOVE_PILOT");
  wait_for_pilot_pickup(var0, var2);
  var1 notify("stop_timer");

  if(isDefined(var1)) {
    foreach(var4 in level.players) {
      objective_unpinforclient(var1.objectiveindex, var4);
    }
  }

  thread kill_pilot_on_bleedout();
  level notify("pilot_rescued");
}

function enable_pilot_carry(var0) {
  var0.bodymodel = "british_pilot_fullbody";
  var0.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  var0.drophintstring = "drop_pilot_hostage";
  var0.nowaypoint = 1;
}

function pilot_wait_for_rescue(var0, var1, var2) {
  var1 setHintString(&"CP_BR_SYRK_OBJECTIVES/CUT_PILOT");
  var1 sethintdisplayrange(148);
  var1 sethintdisplayfov(120);
  var1 sethintonobstruction("show");
  var1 sethintrequiresholding(1);
  var1 setuseholdduration("duration_none");

  while(!scripts\cp\utility::any_player_nearby(var1.origin, 40000)) {
    wait 0.25;
  }

  level.helidown_event_active = 1;
  objective_setlabel(var0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ");
  objective_setplayintro(var0.objectiveindex, 0);
  objective_position(var0.objectiveindex, var2 gettagorigin("j_door") + anglesToForward(var2.angles) * -10);
}

function evac_pilot(var0, var1) {
  var0 vehicle_setspeed(5, 10);
  var0 cleartargetyaw();
  var0 setvehgoalpos(var0.origin + (0, 0, 800), 1);
  wait 8;
  var0 vehicle_setspeed(90, 10);
  var0 setvehgoalpos(var0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var1) && isalive(var1)) {
    var1.nocorpse = 1;
    var1 dodamage(var1.health + 100, var1.origin);
  }

  var0 delete();
}

function complete_killer(var0, var1) {
  level endon("objective_heli_down_kill_hvt");
  var1 endon("stop_timer");
  level endon("pilot_rescued");
  level scripts\engine\utility::ref_143a5("debug_beat_objective_heli_down_start_objective", "helidown_timer_expired");

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

  if(isDefined(var0) && isent(var0)) {
    thread remove_heli_corpse_after_timeout(var0);
  }

  level notify("helidown_done");
  level.helidown_event_active = 0;
  wait 0.5;

  if(isDefined(var0)) {
    var0 notify("delete_corpse");
  }

  level notify("objective_heli_down_kill_hvt");
}

function remove_heli_corpse_after_timeout(var0, var1) {
  self endon("death");
  level.helidown_corpse_present = 1;

  if(isDefined(var1)) {
    wait var1;
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
    foreach(var3 in level.cut_interactions) {
      if(isDefined(var3)) {
        var3 delete();
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

function wait_for_door_cut(var0, var1) {
  var1 endon("death");
  var2 = 0;

  for(;;) {
    level scripts\engine\utility::ref_143a7("cut_1", "cut_2", "cut_3", "cut_4");
    var2++;

    if(var2 >= 4) {
      break;
    }
  }

  var1 notify("harness_cut");

  if(isDefined(var0)) {
    foreach(var4 in level.players) {
      objective_unpinforclient(var0.objectiveindex, var4);
    }

    return;
  }
}

function wait_for_door_cut_long(var0, var1) {
  var1 endon("death");
  level scripts\engine\utility::ref_143a7("cut_1", "cut_2", "cut_3", "cut_4");
  var1 notify("harness_cut");

  if(isDefined(var0)) {
    foreach(var3 in level.players) {
      objective_unpinforclient(var0.objectiveindex, var3);
    }

    return;
  }
}

function pilot_rescue_objective_think(var0, var1) {
  var1 endon("cutout");
  var1 endon("bleedout");
  var1 endon("death");

  for(;;) {
    foreach(var3 in level.players) {
      if(!var3 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var3.inhackring)) {
          objective_unpinforclient(var0.objectiveindex, var3);
          var3.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var3.origin, var1.origin + (0, 0, -20)) > 16900) {
        if(isDefined(var3.inhackring)) {
          objective_unpinforclient(var0.objectiveindex, var3);
          var3.inhackring = undefined;
        }

        continue;
      }

      if(!istrue(var3.inhackring)) {
        objective_pinforclient(var0.objectiveindex, var3);
        var3.inhackring = 1;
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

function ref_11fc3(var0, var1) {
  var1 notify("handoff_hvt");
  var0 notify("loading_hvt_onto_heli");
  var2 = var1.wmexfilally;
  var3 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var3, undefined, undefined, 1);
  var4 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var3, 0);
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var0 resetcarryobject();
  var0 setstance("stand");
  var5 = var0.hostagecarried;
  var5.onchopper = 1;
  var0 unlink();
  var5 unlink();
  var5.body unlink();
  var0 allowcrouch(0);
  var5.body useanimtree(level.scr_animtree["hvt"]);
  var5.body.animname = "hvt";
  var0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var0, "player_vip_blima");
  var1 scripts\common\anim::anim_first_frame_solo(var0.player_rig, "blima_drop_l");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var0, 0.4);
  var6 = spawn("script_model", var1.origin);
  var6 setModel("allied_pilot_fullbody_3");
  var6 useanimtree(level.scr_animtree["exfil_ally"]);
  var6.animname = "exfil_ally";
  var7 = spawn("script_model", var1.origin);
  var7 setModel(var5.bodymodel);
  var7 useanimtree(level.scr_animtree["hvt_vm"]);
  var7.animname = "hvt_vm";

  if(isDefined(var5.head)) {
    var7.head = spawn("script_model", var1.origin);
    var7.head setModel(var5.headmodel);
    var7.head linkTo(var7, "j_neck", (-9, 1, 0), (0, 0, 0));
    var7.head.animname = "hvt_vm";
    var7.head useanimtree(level.scr_animtree["hvt_vm"]);
    var7.head showonlytoplayer(var0);
  }

  var7 showonlytoplayer(var0);
  var6 showonlytoplayer(var0);
  var2 show();
  var2 hidefromplayer(var0);
  var5.body show();
  var5.body hidefromplayer(var0);

  if(isDefined(var5.head)) {
    var5.head hidefromplayer(var0);
  }

  var8 = getstartorigin(var1.origin, var1.angles, level.scr_anim["exfil_ally"]["blima_drop_l"]);
  var9 = getstartangles(var1.origin, var1.angles, level.scr_anim["exfil_ally"]["blima_drop_l"]);
  var10 = getstartorigin(var1.origin, var1.angles, level.scr_anim["exfil_ally_vm"]["blima_drop_l"]);
  var11 = getstartangles(var1.origin, var1.angles, level.scr_anim["exfil_ally_vm"]["blima_drop_l"]);
  var12 = getstartorigin(var1.origin, var1.angles, level.scr_anim["hvt_vm"]["blima_drop_l"]);
  var13 = getstartangles(var1.origin, var1.angles, level.scr_anim["hvt_vm"]["blima_drop_l"]);
  var2.origin = var8;
  var2.angles = var9;
  var6.origin = var10;
  var6.angles = var11;
  var7.origin = var12;
  var7.angles = var13;
  var5.origin = var12;
  var5.angles = var13;
  var6 linkTo(var1);
  var7 linkTo(var1);
  var5 linkTo(var1);
  var1.vmexfilally = var6;
  var1.vmhvt = var7;
  var14 = getstartorigin(var1.origin, var1.angles, level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var15 = getstartangles(var1.origin, var1.angles, level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var0 allowcrouch(0);
  var0 setstance("stand");
  var2 notify("stop_idle_anim");
  var1 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "blima_drop_l", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var6, "blima_drop_l", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var2, "blima_drop_l", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var7, "blima_drop_l", "tag_origin");
  var1 thread scripts\common\anim::anim_single_solo(var5.body, "blima_drop_l", "tag_origin");
  var16 = getanimlength(level.scr_anim["player_vip_blima"]["blima_drop_l"]);
  var17 = getanimlength(level.scr_anim["hvt"]["blima_drop_l"]);
  wait var16;
  var0 setstance("stand");
  var0 notify("remove_rig");
  var0 scripts\cp\cp_weapons::_takeweapon(var3);
  var0 switchtoweapon(var0.restoreweapon);
  var0 allowcrouch(1);
  scripts\cp\cp_pickup_hostage::hostagedrop(var0, var0.hostagecarried, var0.hostagecarried.origin, 0, 0.5, 1, 1);
  wait var17 - var16;
  var5.body linkTo(var5);

  if(isDefined(var5.head)) {
    var5.head linkTo(var5.body);
  }

  var5 linkTo(var1);

  if(isDefined(var7.head)) {
    var7.head delete();
  }

  var7 delete();
  var6 delete();
  var5.body show();

  if(isDefined(var5.head)) {
    var5.head show();
  }

  var2 show();
  var5.body scriptmodelplayanim("sdr_cp_hostage_dropoff_blima_L_idle_outro_pilot");
  var2 scriptmodelplayanim("sdr_cp_hostage_dropoff_blima_L_idle_outro_ally");
}

function hostage_price_idle(var0) {
  var0 endon("death");
  self endon("death");

  for(;;) {
    var0 scriptmodelplayanim(level.scr_anim[var0.animname]["helidown_exfil_idle"]);

    if(isDefined(var0.head)) {
      var0.head scriptmodelplayanim(level.scr_anim[var0.head.animname]["helidown_exfil_idle"]);
    }

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    var1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    wait var1;
  }
}

function spawnactors() {
  if(!isDefined(self.exfil_helpers)) {
    self.exfil_helpers = [];
  }

  self.exfil_helpers[self.exfil_helpers.size] = spawn_anim_model("exfil_guy", "body_animate_jnt", "fullbody_hero_price_urban");
}

function spawn_anim_model(var0, var1, var2, var3) {
  var4 = spawn("script_model", (0, 0, 0));
  var4 setModel(var2);

  if(isDefined(var3)) {
    var5 = spawn("script_model", (0, 0, 0));
    var5 setModel(var3);
    var5 linkTo(var4, "j_spine4", (0, 0, 0), (0, 0, 0));
    var4.head = var5;
    var4 thread scripts\engine\utility::delete_on_death(var5);
  }

  var4.animname = var0;
  var4 useanimtree(level.scr_animtree[var4.animname]);

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var4);
    var4 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var4;
}

function actor_animloop(var0, var1, var2, var3) {
  self endon(var2);
  self endon("death");

  for(;;) {
    scripts\common\anim::anim_single(var0, var1, var3);
    var4 = getanimlength(level.scr_anim[var0[0].animname][var1]);
    wait var4;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function escort_vip_to_chopper(var0, var1, var2) {
  var0 endon("death");
  thread complete_killer(var0, var1);
  thread play_escort_pain_vo();
  var0 waittill("saved");
  var0.trigger makeusable();
  var0 waittill("vip_used");
  var0 playSound("dx_cps_plt_rescue_pilot_eject_found_30");
  create_escort_health_objective(var0);
  var0 thread scripts\cp\cp_vip::vip_damage_monitor();
  var0.ignoreme = 1;
  level notify("helidown_done");
  level.helidown_event_active = 1;
  var2 notify("stop_timer");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_pilot_eject_found_10", "allies");
  var3 = spawn_vip_escort_chopper(var1, var2);
  wait 3;

  if(isDefined(var3.exfil_struct.target)) {
    var4 = scripts\engine\utility::getStructArray(var3.exfil_struct.target, "targetname");

    foreach(var6 in var4) {
      thread proximity_spawn(var6);
    }
  }

  wait_for_vip_near_heli(var0, var3, var2);
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

function wait_for_vip_near_heli(var0, var1) {
  self endon("death");

  for(;;) {
    if(distancesquared(self.origin, var0.exfil_struct.origin) < 9000000) {
      break;
    }

    wait 1;
  }

  thread leave_if_vip_dies(var0, self);
  thread defend_while_chopper_arrives(var1);
  var1 waittill("defend_done");
  level notify("helidown_done");
  var0 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var0.exfil_struct, 1);
  var2 = anglesToForward(var0.angles);
  var3 = anglestoleft(var0.angles);
  var4 = var0.origin;
  var5 = var4 + var2 * 10 + var3 * 64 + (0, 0, -110);
  objective_position(var1.objectiveindex, var5);

  for(;;) {
    wait 1;
  }

  LOC_000000d5:
    board_chopper(var0, self);
  self notify("exfil");
  wait 2;
  thread evac_pilot(level, var0);
}

function leave_if_vip_dies(var0, var1) {
  var0 endon("exfil");
  self endon("death");
  scripts\engine\utility::waittill_any_ents_return(var1, "vip_died", var0, "bleedout");
  self notify("stop_marker");

  if(self vehicle_getspeed() > 1) {
    self waittill("goal");
  }

  if(istrue(self.going_to_exfil)) {
    thread evac_pilot(self);
    return;
  }

  if(isDefined(var0) && isalive(var0)) {
    var0.nocorpse = 1;
    var0 dodamage(var0.health + 100, var0.origin);
  }

  self delete();
}

function defend_while_chopper_arrives(var0) {
  objective_setlabel(var0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var0.objectiveindex, 1);
  objective_setprogress(var0.objectiveindex, 0);
  var1 = 60;
  var2 = 60;

  for(;;) {
    wait 1;
    var2--;
    objective_setprogress(var0.objectiveindex, var2 / var1);

    if(var2 <= 15) {
      var0 notify("defend_done");
    }

    if(var2 <= 0) {
      return;
    }
  }
}

function spawn_vip_escort_chopper(var0, var1) {
  objective_setlabel(var1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_PILOT");
  objective_setshowprogress(var1.objectiveindex, 0);
  objective_icon(var1.objectiveindex, "icon_waypoint_timed");
  var2 = get_pilot_exfil(var0);
  var3 = spawn_evac_chopper(var2);
  var3.godmode = 1;
  var3.health = 10000;
  var3.maxhealth = 10000;
  objective_position(var1.objectiveindex, var2.origin + (0, 0, -100));
  return var3;
}

#using_animtree("");

function spawn_evac_chopper(var0) {
  var1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("pilot_evac_chopper", "targetname"));
  var1.vehicle_skipdeathmodel = 1;
  var1.godmode = 1;
  var1.health = 10000;
  var1.maxhealth = 10000;
  var1.script_disconnectpaths = 0;
  var1.death_fx_on_self = 1;
  var1.exfil_struct = var0;
  var1 vehicleplayanim(%est_blima_doors_open);
  var0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var1);
  var1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var1;
}

function board_chopper(var0, var1) {
  var1 notify("stop_vip_follow");
  var1.trigger makeunusable();
  var1.trigger delete();
  var1 hudoutlinedisable();
  var1 notify("remove_headicon");
  var1 setCanDamage(0);
  var1.ignoreme = 1;
  var1.ignoreall = 1;
  var1.playing_skit = 1;
  var2 = get_closest_heli_entrance(var1, var0);
  var1.goalradius = 8;
  var1 setgoalpos(var2.origin);
  var1 scripts\engine\utility::ref_143a5("goal", "goal_reached");
  var1.old_weapon = var1.weapon;
  var1.fists_weapon = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var1 giveweapon(var1.fists_weapon);
  var1 takeweapon(var1.old_weapon);
  var1 setspawnweapon(var1.fists_weapon);
  var1 setplayerangles(var2.angles);
  var1 forceteleport(var2.origin, var2.angles);
  var1 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var1 aisetanim("animscripted", var2.animindex);
  var3 = getanimlength(var2.xanim);
  wait var3;
  var1 linkTo(var0);
  var1 playerlinkedoffsetenable();
  var1.nodamage = 1;
  thread vip_idle_loop();
  var1 notify("stop_bleedout_timer");
}

function get_closest_heli_entrance(var0, var1) {
  var2 = get_entrance_pos(var0, var1, "vip_blima_exfil_r");
  var3 = get_entrance_pos(var0, var1, "vip_blima_exfil_l");
  return scripts\engine\utility::getclosest(var0.origin, [var2, var3]);
}

function get_entrance_pos(var0, var1, var2) {
  var3 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var2);
  var4 = var0 scripts\asm\asm::asm_getxanim("animscripted", var3);
  var5 = var1 gettagorigin("body_animate_jnt");
  var6 = var1 gettagangles("body_animate_jnt");
  var7 = spawnStruct();
  var7.origin = getstartorigin(var5, var6, var4);
  var7.angles = getstartangles(var5, var6, var4);
  var7.animindex = var3;
  var7.xanim = var4;
  return var7;
}

function vip_idle_loop() {
  self endon("death");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads("vip_blima_exfil_idle");
}

function create_escort_health_objective(var0) {
  var0 endon("death");
  var0 endon("stop_bleedout_timer");
  var1 = 75;
  var2 = scripts\cp\cp_objectives::requestworldid("pilot_down", 15);
  objective_state(var2, "current");
  objective_icon(var2, "hud_icon_death_spawn");
  objective_onentity(var2, var0);
  objective_setbackground(var2, 0);
  objective_setprogressteam(var2, "allies");
  objective_setshowprogress(var2, 1);
  objective_setprogress(var2, 1);
  objective_setplayintro(var2, 0);
  objective_setlabel(var2, &"CP_BR_SYRK_OBJECTIVES/INJURED_PILOT");
  objective_setzoffset(var2, var1);
  var0.objnum = var2;
  thread destroy_bleedout_timer();
}

function destroy_bleedout_timer() {
  var0 = self.objnum;
  scripts\engine\utility::ref_143a5("death", "stop_bleedout_timer");
  objective_delete(var0);
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

function proximity_spawn(var0, var1) {
  if(isstruct(var0)) {
    var2 = var0.origin;
    var3 = 128;

    if(isDefined(var0.height)) {
      var3 = int(var0.height);
    }

    var4 = 4096;

    if(isDefined(var0.radius)) {
      var4 = int(var0.radius);
    }
  } else {
    var2 = var3;
    var3 = 128;
    var4 = 4096;
  }

  var5 = spawn("trigger_radius", var2, 0, var4, var3);
  var6 = scripts\engine\utility::waittill_any_ents_return(level, "helidown_done", level, "objective_heli_down_kill_hvt", var5, "trigger");

  if(var6 == "trigger") {
    if(isDefined(var4)) {
      scripts\cp\cp_modular_spawning::run_spawn_module(var4);
    } else {
      scripts\cp\cp_modular_spawning::run_spawn_module(var3.target);
    }
  }

  var5 delete();
}

function register_spawn_groups() {
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;

  if(scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    var1 = [ &scripts\cp\cp_modular_spawning::waittill_spawn_notify_after_count, "PvPE_enemy_AI_start_spawning"];
    var2 = [ &scripts\cp\cp_modular_spawning::override_spawner_aitypes, "ar", "smg"];
    var3 = [var2, &end_spawn_group];
    [[var0]]("harness_loc_3", 0, 0, 0, var1, undefined, "harness_loc_3", var2, "harness_loc_3_reinforce", 8);
    [[var0]]("harness_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce", var3, undefined, undefined);
    [[var0]]("harness_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_snipers", var3, undefined, undefined);
    [[var0]]("harness_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_snipers_2", var3, undefined, undefined);
    [[var0]]("harness_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_rpg", var3, undefined, undefined);
    [[var0]]("harness_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_2", var3, undefined, undefined);
    [[var0]]("escort_loc_3", 0, 0, 0, 0.1, undefined, "harness_loc_3", var2, "escort_loc_3_reinforce", 8);
    [[var0]]("escort_loc_3_reinforce", 0, 0, 0, var1, 0, "escort_loc_3_reinforce", var3, undefined, undefined);
    [[var0]]("escort_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_snipers", var3, undefined, undefined);
    [[var0]]("escort_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_snipers_2", var3, undefined, undefined);
    [[var0]]("escort_loc_3_reinforce", 0, 0, 0, var1, 0, "harness_loc_3_reinforce_rpg", var3, undefined, undefined);
    [[var0]]("loc_3_exfil_1_a", 0, 0, 0, var1, undefined, "loc_3_exfil_1_a", var3, undefined, undefined);
    [[var0]]("loc_3_exfil_1_b", 0, 0, 0, var1, undefined, "loc_3_exfil_1_b", var3, undefined, undefined);
    [[var0]]("loc_3_exfil_1_c", 0, 0, 0, var1, undefined, "loc_3_exfil_1_c", var3, "loc_3_exfil_1_c_reinforce", undefined);
    [[var0]]("loc_3_exfil_1_c_reinforce", 0, 0, 0, var1, undefined, "loc_3_exfil_1_c_reinforce", var3, undefined, undefined);
    [[var0]]("loc_3_exfil_2", 0, 0, 0, var1, undefined, "loc_3_exfil_2", var2, "loc_3_exfil_2_reinforce", 10);
    [[var0]]("loc_3_exfil_2_reinforce", 0, 0, undefined, var1, 0, "loc_3_exfil_2_reinforce", var3, undefined, undefined);
    [[var0]]("loc_3_exfil_2_reinforce", 0, 0, undefined, var1, 0, "loc_3_exfil_2_reinforce_sniper", var3, undefined, undefined);
    return;
  }

  [[var0]]("harness_loc_3", 4, 4, 4, 0.1, undefined, "harness_loc_3", undefined, "harness_loc_3_reinforce", 8);
  [[var0]]("harness_loc_3_reinforce", 5, 6, 100, [ &wave_reinforce, 3, 10], 0, "harness_loc_3_reinforce", &end_spawn_group, undefined, undefined);
  [[var0]]("harness_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 3, 25], 0, "harness_loc_3_reinforce_snipers", &end_spawn_group, undefined, undefined);
  [[var0]]("harness_loc_3_reinforce", 1, 1, 100, [ &wave_reinforce, 20, 25], 0, "harness_loc_3_reinforce_snipers_2", &end_spawn_group, undefined, undefined);
  [[var0]]("harness_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 20, 25], 0, "harness_loc_3_reinforce_rpg", &end_spawn_group, undefined, undefined);
  [[var0]]("harness_loc_3_reinforce", 2, 5, 100, [ &wave_reinforce, 1, 10, &reinforce_after_door_section], 0, "harness_loc_3_reinforce_2", &end_spawn_group, undefined, undefined);
  [[var0]]("escort_loc_3", 4, 4, 4, 0.1, undefined, "harness_loc_3", undefined, "escort_loc_3_reinforce", 8);
  [[var0]]("escort_loc_3_reinforce", 5, 8, 100, [ &wave_reinforce, 1, 10], 0, "escort_loc_3_reinforce", &end_spawn_group, undefined, undefined);
  [[var0]]("escort_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 1, 30], 0, "harness_loc_3_reinforce_snipers", &end_spawn_group, undefined, undefined);
  [[var0]]("escort_loc_3_reinforce", 1, 1, 100, [ &wave_reinforce, 1, 30], 0, "harness_loc_3_reinforce_snipers_2", &end_spawn_group, undefined, undefined);
  [[var0]]("escort_loc_3_reinforce", 1, 2, 100, [ &wave_reinforce, 1, 25], 0, "harness_loc_3_reinforce_rpg", &end_spawn_group, undefined, undefined);
  [[var0]]("loc_3_exfil_1_a", 5, 5, 5, 0.1, undefined, "loc_3_exfil_1_a", &end_spawn_group, undefined, undefined);
  [[var0]]("loc_3_exfil_1_b", 6, 6, 6, 0.1, undefined, "loc_3_exfil_1_b", &end_spawn_group, undefined, undefined);
  [[var0]]("loc_3_exfil_1_c", 5, 5, 5, 0.1, undefined, "loc_3_exfil_1_c", &end_spawn_group, "loc_3_exfil_1_c_reinforce", undefined);
  [[var0]]("loc_3_exfil_1_c_reinforce", 6, 11, 0, 1, undefined, "loc_3_exfil_1_c_reinforce", &end_spawn_group, undefined, undefined);
  [[var0]]("loc_3_exfil_2", 1, 1, 1, 0.1, undefined, "loc_3_exfil_2", undefined, "loc_3_exfil_2_reinforce", 10);
  [[var0]]("loc_3_exfil_2_reinforce", 12, 16, undefined, [ &wave_reinforce, 1, 10], 0, "loc_3_exfil_2_reinforce", &end_spawn_group, undefined, undefined);
  [[var0]]("loc_3_exfil_2_reinforce", 1, 2, undefined, [ &wave_reinforce, 1, 10], 0, "loc_3_exfil_2_reinforce_sniper", &end_spawn_group, undefined, undefined);
}

function wave_reinforce(var0, var1, var2, var3) {
  level endon("game_ended");

  if(isDefined(var3) && !isDefined(var0.custom_var_done)) {
    if(isbuiltinfunction(var3)) {
      [[var3]](var0);
    } else if(isint(var3) || isfloat(var3)) {
      wait var3;
    }

    var0.custom_var_done = 1;
  }

  if(var0.activecount <= var0.min_size) {
    return var1;
  }

  if(var0.activecount >= var0.max_size) {
    while(var0.activecount >= var0.min_size) {
      wait 0.25;
    }

    return var2;
  }

  return 15;
}

function reinforce_after_door_section(var0) {
  level scripts\engine\utility::ref_143a8("cut_1", "cut_2", "cut_3", "cut_4", "started_cutting");
}

function end_spawn_group(var0) {
  thread _end_spawn_group(level);
}

function _end_spawn_group(var0) {
  level endon("game_ended");
  level scripts\engine\utility::ref_143a5("helidown_done", "objective_heli_down_kill_hvt");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function show_vip_waypoints(var0) {
  level endon("game_ended");
  level.escort_vip = self;
  var1 = scripts\cp\cp_objectives::requestworldid("vip", 10);
  objective_icon(var1, "hud_icon_jackal_alert");
  objective_setshowdistance(var1, 1);
  objective_setbackground(var1, 1);
  objective_state(var1, "current");
  objective_setplayintro(var1, 0);
  level.escort_vip.waypointobjnum = var1;

  foreach(var4, var3 in var0) {
    objective_setlocation(var1, var4, var3.origin + (0, 0, 40));
    thread cleanup_waypoint_when_near(var3, self);
  }

  scripts\engine\utility::ref_143a6("death", "vip_used", "cleanup_vip_waypoints");

  foreach(var3 in var0) {
    objective_unsetlocation(var1, var4);
  }
}

function cleanup_waypoint_when_near(var0, var1) {
  var0 endon("death");
  var0 endon("vip_used");
  var2 = squared(750);

  for(;;) {
    var3 = 0;

    foreach(var5 in level.players) {
      if(distancesquared(var5.origin, self.origin) > var2) {
        continue;
      }

      if(sighttracepassed(var5 getEye(), self.origin + (0, 0, 10), 0, var5, 1)) {
        var3 = 1;
      }

      if(var3 && sighttracepassed(var5 getEye(), var0.origin + (0, 0, 50), 0, var0.attacker, 1)) {
        if(isDefined(self.attacker) && isalive(self.attacker)) {
          thread vip_dies_soon();
        }
      }
    }

    if(var3) {
      if(distancesquared(var0.origin, self.origin) < 10000) {
        var0 playSound("dx_cps_plt_rescue_pilot_eject_found_10");
      }

      break;
    }

    wait 0.1;
  }

  objective_unsetlocation(var0.waypointobjnum, var1);
}

function vip_dies_soon() {
  if(isDefined(self.dying_soon)) {
    return;
  }

  self endon("death");
  self endon("saved");
  self.dying_soon = 1;
  var0 = gettime() + 25000;

  if(getdvarint("timetodie") > 0) {
    var0 = gettime() + getdvarint("timetodie") * 1000;
  }

  var1 = squared(128);
  iprintlnbold("Player got close - threatening to shoot pilot");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT");
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT2");

  for(var2 = gettime() + 4000; gettime() < var0 && isDefined(self.attacker) && isalive(self.attacker); var2 = gettime() + 4000) {
    wait 0.05;

    foreach(var4 in level.players) {
      if(abs(self.origin[2] - var4.origin[2]) > 100) {
        continue;
      }

      if(distancesquared(self.origin, var4.origin) < var1) {
        level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_OBJECTIVES/SHOOT_THREAT3");
        wait 2;
        self.attacker notify("scene_interrupt");
        self.attacker thread scripts\cp\cp_skits::death_fight2(self);
        return;
      }
    }

    if(gettime() >= var2) {
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

function idle_pilot_loop(var0) {
  var0 endon("cutout");
  var0 endon("death");

  for(;;) {
    scripts\common\anim::anim_single_solo(var0.body, "cockpit_idle", "tag_origin");
  }
}

function cut_objective_progress(var0, var1) {
  var0 endon("last_stand");
  var0 endon("disconnect");

  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  while(self.cut_progress <= var1 && var0 useButtonPressed()) {
    objective_setprogress(self.cut_progress, var1);
    wait 0.05;
    self.cut_progress += 0.05;
  }

  return self.cut_progress >= var1;
}

function wait_for_pilot_pickup(var0) {
  if(!isDefined(var0.interaction_handle)) {
    var0.interaction_handle = spawn("script_model", var0.body gettagorigin("j_helmet"));
    var0.interaction_handle linkTo(var0);
  }

  var0.pickup_disabled = 0;
  var0.interaction_handle makeusable();
  var0.interaction_handle setHintString(&"CP_BR_SYRK_OBJECTIVES/CUT_PILOT");
  var0.interaction_handle sethintonobstruction("show");
  var0.interaction_handle setCursorHint("HINT_BUTTON");
  var0.interaction_handle sethintdisplayrange(160);
  var0.interaction_handle sethintdisplayfov(80);
  var0.carryobjectasset = "hostage_pilot";
  var0.idleanim = "sdr_cp_hostage_dropoff_ground_idle_pilot";
  level.hostage_onusefunc = &pilot_pickup_from_cockpit;
  var0.interaction_handle waittill("trigger", var1);
  var0 scripts\cp\cp_pickup_hostage::hostage_onuse(var1, "heli", self);
  var0.interaction_handle delete();
  var0.interaction_handle = undefined;
}

function pilot_pickup_from_cockpit(var0, var1) {
  var1 notify("cutout");
  var1.drophintstring = "drop_pilot_hostage";
  var1.pickuphintstring = &"CP_BR_SYRK_OBJECTIVES/HVT_PICKUP";
  var1.interaction_handle makeunusable();
  var0.restoreweapon = var0 getcurrentweapon();
  var2 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var2, undefined, undefined, 1);
  var3 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var2, 0);
  var0.gunlessweapon = var2;
  var0 scripts\common\utility::allow_weapon_switch(0);
  var4 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"]["hvt_cockpit_pickup"]);
  var5 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"]["hvt_cockpit_pickup"]);
  var0 freezecontrols(1);
  var0 setstance("stand");
  var0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  var0 thread scripts\cp\cp_pickup_hostage::create_player_rig(var0, "cutter_player");
  scripts\common\anim::anim_first_frame_solo(var0.player_rig, "hvt_cockpit_pickup");
  scripts\cp\cp_pickup_hostage::link_player_to_rig(var0, 0.5);
  var0.vmvip = spawn("script_model", var1.origin);
  var0.vmvip.angles = var1.angles;
  var0.vmvip setModel(var1.body.model);
  var0.vmvip.animname = "hvt_vm";
  var0.vmvip useanimtree(level.scr_animtree["hvt_vm"]);
  var0.vmvip hide();
  var0.vmvip showtoplayer(var0);
  var1 hidefromplayer(var0);

  if(isDefined(var1.head)) {
    var1.head hidefromplayer(var0);
  }

  thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "hvt_cockpit_pickup");
  thread scripts\common\anim::anim_single_solo(var1.body, "cockpit_pickup");
  thread scripts\common\anim::anim_single_solo(var0.vmvip, "cockpit_pickup_vm");
  self scriptmodelplayanim("vm_hostage_pickup_blimadestroyed_blimadst");
  self scriptmodelplayanim("sdr_cp_hostage_pickup_blimadestroyed_blimadst");
  var6 = getanimlength(%vm_hostage_pickup_blimadestroyed_player);
  wait var6 + 0.1;
  var1 linkTo(var0);
  var1.body hide();
  var0.vmvip delete();
  var7 = scripts\cp\cp_pickup_hostage::run_stealth_funcs(var0);
  var0 setOrigin(var7);
  waitframe();
  var0 notify("remove_rig");
  var0 freezecontrols(0);
}

function create_long_cut_interactions(var0, var1, var2) {
  var3 = anglesToForward((0, var0.angles[1], 0));
  var4 = anglestoleft((0, var0.angles[1], 0));
  var5 = var0.origin;
  var6 = var5 + var3 * 125 + var4 * 72 + (0, 0, 50);
  var7 = create_long_cut_interaction(var6, &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ", ["cut_3", "cut_4"], var1, var0, var2);
  level.cut_interactions = [var7];

  foreach(var9 in level.cut_interactions) {
    if(isDefined(var9)) {
      var9 makeusable();
    }
  }
}

function create_long_cut_interaction(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_model", var0);
  var6 setModel("tag_origin");
  waitframe();
  var6 setHintString(var1);
  var6 setCursorHint("HINT_BUTTON");
  var6 sethintdisplayrange(200);
  var6 sethintdisplayfov(65);
  var6 setuserange(72);
  var6 setusefov(65);
  var6 sethintonobstruction("show");
  var6 setuseholdduration("duration_none");
  var6.targetname = "harness_interaction";

  foreach(var8 in var2) {
    if(!scripts\engine\utility::flag_exist(var8)) {
      scripts\engine\utility::flag_init(var8);
    }
  }

  thread use_think_long_cut(var6, var2, var3, var4);
  return var6;
}

function use_think_long_cut(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(isDefined(level.cut_interactions)) {
      foreach(var5 in level.cut_interactions) {
        if(isDefined(var5)) {
          var5 makeusable();
        }
      }
    }

    self waittill("trigger", var7);
    level notify("started_cutting");

    if(isDefined(var7)) {
      if(!var7 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      foreach(var5 in level.cut_interactions) {
        if(isDefined(var5)) {
          var5 makeunusable();
        }
      }

      if(!cutout_pilot_long(var2, var1, var7, var0, var3)) {
        wait 1;
        continue;
      }
    }

    foreach(var11 in var0) {
      if(scripts\engine\utility::flag_exist(var11)) {
        scripts\engine\utility::flag_set(var11);
      }
    }

    if(isDefined(level.cut_interactions)) {
      foreach(var5 in level.cut_interactions) {
        if(isDefined(var5)) {
          var5 makeusable();
        }
      }
    }

    self delete();
  }
}

function cutout_pilot_long(var0, var1, var2, var3) {
  var0 makeunusable();
  var4 = getcompleteweaponname("iw8_gunless_infil");
  var1 scripts\cp\utility::_giveweapon(var4, undefined, undefined, 1);
  var5 = var1 scripts\cp\cp_weapons::switchtoweaponreliable(var4, 0);
  var1 scripts\common\utility::allow_weapon_switch(0);
  var1.ref_140ae = 1;
  var6 = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"][var2[0]]);
  var7 = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"][var2[0]]);
  var1 setOrigin(var6, 1);
  var1 setplayerangles(var7);
  var1 setstance("stand");
  var8 = spawn("script_model", self.origin);
  var8 setModel("tool_portable_gas_cutter_01_cp");
  var8.angles = self.angles;
  var8.animname = "saw";
  var8 hide();
  var1 forceusehinton(&"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  var8 useanimtree(level.scr_animtree["saw"]);
  var1 thread scripts\cp\cp_destruction::create_player_rig(var1, "cutter_player");
  var1 cameraset("camera_custom_orbit_2_cp");
  objective_addclienttomask(var3.objectiveindex, var1);
  objective_hidefromplayersinmask(var3.objectiveindex);
  var5 = wait_for_section_cut_long(var1, var8, var2);

  if(!istrue(var5)) {
    var1 notify("cut_failed");
  }

  var1 cameradefault();
  objective_removeclientfrommask(var3.objectiveindex, var1);
  var1 forceusehintoff();
  var8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var1);
  var1 scripts\common\utility::allow_weapon_switch(1);
  var1 scripts\cp\cp_weapons::_takeweapon(var4);
  var1 scripts\cp\cp_weapons::forcevalidweapon();
  var1 setstance("stand");
  var1.ref_140ae = undefined;

  if(istrue(var5)) {
    level notify("cutout_pilot_long_success");
    return true;
  }

  return false;
}

function wait_for_section_cut_long(var0, var1, var2) {
  if(!isDefined(self.cut_progress)) {
    self.cut_progress = 0;
  }

  var3 = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
  var4 = getanimlength(level.scr_anim["cutter_player"][var2[0]]);
  var5 = getanimlength(level.scr_anim["cutter_player"][var2[1]]);
  var6 = getanimlength(level.scr_anim["cutter_player"]["putaway"]);
  thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "pullout");
  thread scripts\common\anim::anim_single_solo(var1, "pullout");
  wait 0.25;
  var1 show();
  wait 0.25;
  var1 playLoopSound("saw_spinup");
  wait var3 - 0.25;
  var7 = var4 + var5;

  if(isDefined(level.helidown_long_cut_len)) {
    var7 = level.helidown_long_cut_len;
  }

  thread do_cut_anims_long(var0, var1, var2);
  cut_progress_think(var0, var7);
  var0 notify("cut_done");
  var0 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_securing", 0);
  var1 stoploopsound();
  playsoundatpos(var1.origin, "saw_spinup_stop");
  wait 0.5;

  if(!scripts\cp\cp_laststand::player_in_laststand(var0)) {
    thread scripts\common\anim::anim_single_solo(var1, "putaway");
    scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "putaway");
  }

  var1 hide();
  return self.cut_progress >= var7;
}

function do_cut_anims_long(var0, var1, var2) {
  var0 endon("cut_failed");
  var0 endon("cut_done");
  var3 = getanimlength(level.scr_anim["cutter_player"][var2[0]]);
  var4 = getanimlength(level.scr_anim["cutter_player"][var2[1]]);
  thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var2[0]);
  thread scripts\common\anim::anim_single_solo(var1, var2[0]);
  wait 0.5;
  var1 setscriptablepartstate("sparks", "on");
  wait var3;
  thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var2[1]);
  thread scripts\common\anim::anim_single_solo(var1, var2[1]);
  wait var4;
}

function cut_progress_think(var0, var1) {
  var0 endon("disconnect");
  var0 setclientomnvar("ui_securing", 11);
  var0.hasprogressbar = 1;

  while(var0 scripts\cp_mp\utility\player_utility::_isalive() && var0 scripts\cp\utility::is_valid_player() && var0 useButtonPressed() && self.cut_progress < var1) {
    level notify("cutout_pilot_progress_fraction", self.cut_progress / var1);
    var0 setclientomnvar("ui_securing_progress", self.cut_progress / var1);
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