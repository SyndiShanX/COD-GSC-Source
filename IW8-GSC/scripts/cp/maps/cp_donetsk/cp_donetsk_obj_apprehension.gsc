/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_apprehension.gsc
**********************************************************************/

function apprehension_init() {
  level.apprehension_interaction = &register_interactions;
  scripts\cp\cp_pickup_hostage::init_anims();
  level.suicide_bomber_combat_func = &suicide_bomber_combat_func;
  thread anim_init_trafficking();
}

function register_apprehension_objective() {
  level endon("game_ended");
  thread apprehension_init();
  scripts\engine\utility::flag_wait("objectives_registered");
  var_0 = &scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("obj_tug_of_war", &obj_maj_intro_init, &obj_maj_intro_start, &obj_maj_intro_end, &debugbeatobjective, &debug_start_apprehension);
  [[var_0]]("obj_apprehension", &obj_maj_approach_init, &obj_maj_approach_start, &obj_maj_approach_end, &debugbeatobjective);
  [[var_0]]("obj_grab_informant", &obj_maj_grab_init, &obj_maj_grab_start, &obj_maj_grab_end, &debugbeatobjective);
  [[var_0]]("obj_rescue_informant", &obj_maj_rescue_init, &obj_maj_rescue_start, &obj_maj_rescue_end, &debugbeatobjective);
  [[var_0]]("obj_defend_informant", &obj_maj_defend_init, &obj_maj_defend_start, &obj_maj_defend_end, &debugbeatobjective);
  [[var_0]]("obj_extract_informant", &obj_maj_extract_init, &obj_maj_extract_start, &obj_maj_extract_end, &debugbeatobjective);
  [[var_0]]("obj_extract_players", &obj_maj_exit_init, &obj_maj_exit_start, &obj_maj_exit_end, &debugbeatobjective);
  [[var_0]]("obj_informant_bledout");
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_intro_init(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_tugofwar_north_create_script_completed") || !scripts\engine\utility::flag("cp_tugofwar_north_create_script_completed")) {
    scripts\engine\utility::flag_set("cp_tugofwar_north_create_script");
    scripts\engine\utility::flag_wait("cp_tugofwar_north_create_script_completed");
    return;
  }
}

function obj_maj_intro_start(var_0) {
  foreach(var_2 in getaiarray("axis")) {
    var_2.dont_kill_off = 0;
    var_2.never_kill_off = 0;
  }

  wait 1;
  level.initlocationcircle = "obj_apprehension_1";
  level.initlethalmaxoffsetmap = "obj_apprehension_1";
  level.ref_139B5 = 1;
  thread ref_131F0();
}

function minigun_shots_per_round() {
  level endon("game_ended");
  wait 5;
  scripts\cp\crate_drops\cp_crate_drops::ref_12C40("cache_2b", ["deployable_cover", "ammo_crate"]);
}

function obj_maj_intro_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_apprehension", "primary", "allies");
}

function obj_maj_approach_init(var_0) {
  scripts\engine\utility::flag_init("tugofwar_hvt_spawned");
  scripts\engine\utility::flag_init("allow_convoy_roaming");
  thread spawn_intro_soldiers();
  thread spawn_hvt_in_building();
  thread spawn_atvs();
  thread ref_135E1(level);
  thread first_bleedout();
  thread ref_131E9();
  scripts\cp\cp_objectives::reset_objective_timers();
  level notify("players_looking_for_informant");

  if(!isDefined(level.hostage_pickup)) {
    level waittill("hostage_spawned");
    return;
  }
}

function obj_maj_approach_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_APPREHENSION");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_sethot(var_0.objectiveindex, 0);
  level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
  level thread scripts\cp\cp_objectives::ref_1317E(var_0, level.hostage_pickup.origin);
  wait_player_near(level, level.hostage_pickup.origin, 6500, 0);
  scripts\engine\utility::flag_wait("tugofwar_hvt_spawned");
  objective_unsetlocation(var_0.objectiveindex, 0);
  thread convoy_start();
  thread ref_1240B();
  thread allow_player_mantles();
}

function obj_maj_approach_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_grab_informant", "primary", "allies");
}

function obj_maj_grab_init(var_0) {}

function obj_maj_grab_start(var_0) {
  level endon("stop_grab_obj");
  var_1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_INFORMANT_ATTEMPT_WORLD");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_sethot(var_0.objectiveindex, 0);
  objective_addalltomask(var_0.objectiveindex);
  objective_showtoplayersinmask(var_0.objectiveindex);
  thread hvt_wait_for_pickup();
  thread play_waitfor_ai_drop_vo(level);
  thread player_grabs_hostage(level);
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "smugg_p2_intro");
  var_2 = 30;
  wait var_2;
}

function obj_maj_grab_end(var_0) {
  if(!istrue(level.hostage_pickup.pickedupbyplayer)) {
    level thread scripts\cp\cp_objectives::run_objective("obj_rescue_informant", "primary", "allies");
    return;
  }

  if(isDefined(level.hostage_pickup.carrier) && !isPlayer(level.hostage_pickup.carrier)) {
    level thread scripts\cp\cp_objectives::run_objective("obj_rescue_informant", "primary", "allies");
    return;
  }

  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    level thread scripts\cp\cp_objectives::run_objective("obj_defend_informant", "primary", "allies");
    return;
  }

  level thread scripts\cp\cp_objectives::run_objective("obj_rescue_informant", "primary", "allies");
}

function obj_maj_rescue_init(var_0) {
  scripts\cp\utility::ref_123FE("mus_cp_smuggler_rescue_hostage");
}

function obj_maj_rescue_start(var_0) {
  level.hostage_pickup scripts\engine\utility::ref_143A5("player_picked_up_hostage", "dropped");
}

function obj_maj_rescue_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_defend_informant", "primary", "allies");
}

function obj_maj_defend_init(var_0) {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("escalation_juggs_01");
  level thread scripts\cp\cp_convoy_manager::compromise_center_truck();
}

function obj_maj_defend_start(var_0) {
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_EXTRACT");
  objective_addalltomask(var_0.objectiveindex);
  objective_hidefromplayersinmask(var_0.objectiveindex);
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_LABEL");
  scripts\cp\utility::ref_123FE("");
  thread kill_rate_watcher();
  thread location_objective_remover();
  thread allow_hvt_stealing_by_ai();
  thread ref_12411();
  thread first_convoy_lmgs();
  var_1 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");
  var_2 = getvehicleplayerhorn(var_1);
  var_3 = [];

  for(var_4 = 0;; var_4++) {
    jumpiffalse(var_4 < var_2.size) LOC_00000138;
    var_5 = "obj_tugofwar_hvt_exfil_" + var_2[var_4].script_noteworthy;
    var_6 = scripts\cp\cp_objectives::requestworldid(var_5, 15);
    onexplode(var_6);
    objective_position(var_6, var_2[var_4].origin);
    thread wait_for_hvt_near_exfil(level, var_2[var_4]);
    var_2[var_4].ref_11F64 = var_6;
    var_3 = var_6;
  }

  level waittill("hvt_near_exfil", var_7, var_8);
  thread ref_1354D(level);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_2[var_4].script_noteworthy != var_7) {
      objective_state(var_2[var_4].ref_11F64, "done");
      scripts\cp\cp_objectives::freeworldidbyobjid(var_2[var_4].ref_11F64);
      var_2[var_4].ref_11F64 = undefined;
      continue;
    }

    level.tugofwar_exfil_location = var_2[var_4];
  }

  thread getthirdpersonrangeforsize(level, level.tugofwar_exfil_location.origin);
  level thread scripts\cp\cp_objectives::ref_1317E(var_0, level.tugofwar_exfil_location.origin);
  thread wait_for_hvt_near_exfil(level, level.tugofwar_exfil_location);
  level waittill("hvt_near_exfil", var_7, var_8);
  scripts\cp\utility::ref_123FE("");

  if(isDefined(level.hostage_pickup) && isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier)) {
    level.hostage_pickup notify("watchNewDrop");
    level.hostage_pickup.carrier thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SMUGGLER/OBJ_INFORMANT_DROP", 4);
  }

  foreach(var_10 in var_2) {
    if(isDefined(var_10.ref_11F64)) {
      objective_state(var_10.ref_11F64, "done");
      scripts\cp\cp_objectives::freeworldidbyobjid(var_10.ref_11F64);
    }
  }
}

function onexplode(var_0) {
  objective_setplayintro(var_0, 1);
  objective_setplayoutro(var_0, 1);
  objective_state(var_0, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0);
  objective_icon(var_0, "icon_waypoint_objective_general");
  objective_sethot(var_0, 0);
  objective_setlabel(var_0, &"CP_SMUGGLER/OBJ_EXTRACT");
  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

function getvehicleplayerhorn(var_0) {
  var_1 = [];
  var_2 = "c";
  var_0 = sortbydistance(var_0, level.hostage_pickup.origin);

  if(var_0[0].script_noteworthy != var_2) {
    var_0 = scripts\engine\utility::array_remove(var_0, var_0[0]);
    var_1 = var_0[0];
    var_1 = var_0[1];
    thread ref_12DF1();
    return var_1;
  }

  var_0 = scripts\engine\utility::array_remove(var_0, var_0[1]);
  var_1 = var_0[0];
  var_1 = var_0[1];
  return var_1;
}

function ref_12DF1() {
  if(!isDefined(level.ref_11F78)) {
    level thread scripts\cp\cp_wave_spawning::killstreaks(8, "smugg_p2_openexfil");
    level.ref_11F78 = 1;
    return;
  }
}

function ref_1354D(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "a":
      var_1 = "techo_phys_tow6";
      var_2 = "techo_phys_tow13";
      break;
    case "b":
      var_1 = "techo_phys_tow3";
      var_2 = "techo_phys_tow10";
      break;
    case "c":
      var_1 = "techo_phys_tow2";
      var_2 = "techo_phys_tow9";
      break;
    case "d":
      var_1 = "techo_phys_tow4";
      var_2 = "techo_phys_tow11";
      break;
    case "e":
      var_1 = "techo_phys_tow1";
      var_2 = "techo_phys_tow8";
      break;
    case "f":
      var_1 = "techo_phys_tow5";
      var_2 = "techo_phys_tow12";
      break;
    case "g":
      var_1 = "techo_phys_tow7";
      var_2 = "techo_phys_tow14";
      break;
  }

  thread ref_12DD5(level);

  if(isDefined(var_2)) {
    thread ref_12DD5(level);
    return;
  }
}

function ref_12DD5(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);

  if(isDefined(var_1.module_vehicles[0]) && isent(var_1.module_vehicles[0])) {
    var_2 = var_1.module_vehicles[0];
    thread ref_14350();
    return;
  }
}

function ref_14350() {
  self endon("death");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

function getthirdpersonrangeforsize(var_0, var_1) {
  if(var_1 == "c") {
    return;
  }

  var_2 = scripts\engine\utility::getStructArray("exfil_spot_tank", "targetname");
  var_2 = sortbydistance(var_2, var_0);
  var_3 = [var_2[0], var_2[1], var_2[2]];
  var_4 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var_3);
  thread playerhandlesandboxmenu();
  thread ref_135ED(level);
  thread ref_12DF1();
}

function ref_135ED(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = 450;
  }

  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "GAME_MODE";
  var_2.owner = undefined;
  var_2.team = "axis";
  var_2.faceawayfromowner = 0;
  var_2.cancapture = 0;
  var_2.cancaptureimmediately = 0;
  var_2.activateimmediately = 1;
  var_2.cantimeout = 0;
  var_2.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_2);
  var_2.spawnmethod = "airdrop_at_position_unsafe";
  var_4 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_2, var_3);

  if(!isDefined(var_4)) {
    return;
  }

  level.ref_13E36 = var_4;
  wait 6.5;
  thread tank_waittill_death();
  var_4 endon("death");
  var_4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var_4.headicon, 8000);
  var_5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_4, "tur_bradley_mp");
  var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_4, "tur_gun_lighttank_mp");
  var_5 notsolid();
  var_6 notsolid();
  wait 5;

  for(;;) {
    var_7 = var_4 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_7)) {
      wait 1;
      continue;
    }

    if(istrue(var_7.binvehicle) && isDefined(var_7.vehicle)) {
      if(var_5 turretcantarget(var_7.vehicle.origin + (0, 0, 50))) {
        var_5 settargetentity(var_7.vehicle);
      }

      if(var_6 turretcantarget(var_7.vehicle.origin + (0, 0, 50))) {
        var_6 settargetentity(var_7.vehicle);
      }
    } else {
      ref_130F2(var_5, var_7, 9, var_1);
      var_6 settargetentity(var_7);
    }

    thread tank_shoot_at_target(var_4, var_6);
    thread tank_shoot_at_target(var_4);
    wait randomfloatrange(0.5, 1.5);
  }
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  if(isDefined(level.ref_13E36)) {
    level.ref_13E36 = undefined;
    return;
  }
}

function tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_3 = 0.1;
  var_4 = 1;
  var_5 = 0;

  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  if(istrue(var_1)) {
    var_4 = randomintrange(15, 25);
    var_5 = 1;
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var_5;
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_130F2(var_0, var_1, var_2) {
  if(isPlayer(var_0) && isDefined(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == var_0) {
    self settargetentity(var_0);
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 20;
  }

  var_3 = randomfloatrange(var_2 * -1, var_2);
  var_4 = randomfloatrange(var_2 * -1, var_2);
  var_5 = randomfloatrange(var_2 * -1, var_2);
  self settargetentity(var_0, (var_3, var_4, var_5));
}

function first_convoy_lmgs() {
  var_0 = getEntArray("building_roof_trig", "targetname");

  foreach(var_2 in var_0) {
    thread first_interaction();
  }

  level waittill("building_roof_chopper_reenforce_spawn");
  var_4 = 10;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(level.spawn_module_intro)) {
    var_5 = level.spawn_module_intro.max_size;
    var_6 = level.spawn_module_intro.min_size;
    level.spawn_module_intro.max_size = var_4;
    level.spawn_module_intro.min_size = var_4;
  }

  ref_143A0(18);
  level.ref_13593 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_building1");
  level waittill("building_roof_chopper_reenforce_spawn");
  ref_143A0(18);
  level.ref_13594 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_building2");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  if(isDefined(level.spawn_module_intro) && isDefined(var_6) && isDefined(var_5)) {
    level.spawn_module_intro.max_size = var_5;
    level.spawn_module_intro.min_size = var_6;
    return;
  }
}

function ref_143A0(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = 0;
    var_2 = 0;

    if(!isDefined(level.agentarray)) {
      break;
    }

    foreach(var_4 in level.agentarray) {
      if(isDefined(var_4.isactive) && var_4.isactive) {
        var_1++;
      }

      if(isDefined(var_4.never_kill_off) && var_4.never_kill_off) {
        var_2++;
      }
    }

    if(var_1 < var_0) {
      break;
    }

    wait 1;
  }
}

function first_interaction() {
  self endon("death");

  for(;;) {
    for(;;) {
      self waittill("trigger", var_0);

      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      break;
    }

    level notify("building_roof_chopper_reenforce_spawn");
    wait 1;
  }
}

function kill_rate_watcher() {
  wait 10;
  scripts\cp\utility::ref_123FE("mus_cp_smuggler_reinforcements");
}

function obj_maj_defend_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_extract_informant", "primary", "allies");
  level notify("obj_extract_informant_started");
}

function obj_maj_extract_init(var_0) {
  thread allow_hvt_stealing_by_ai();
}

function obj_maj_extract_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlocation(var_0.objectiveindex, 0, level.tugofwar_exfil_location.origin);
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/DROPINFORMANT");
  objective_addalltomask(var_0.objectiveindex);
  objective_showtoplayersinmask(var_0.objectiveindex);
  thread handle_hvt_go_outside(level);
  ref_1240F(level);

  for(;;) {
    jumpiffalse(istrue(level.hostage_pickup.can_fulton)) LOC_000000f9;

    if(isDefined(level.hostage_pickup.carrier) || istrue(level.hostage_pickup.carried)) {
      level.hostage_pickup waittill("dropped");
    }

    wait 0.1;
  }

  LOC_00000102:
    level.hostage_pickup.interaction_handle setuseholdduration("duration_long");

  if(isDefined(level.hostage_pickup.sethotfunc)) {
    level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](0);
  }

  level notify("tugofwar_hvt_placed");
  level.ref_13E34 = 1;
  thread ref_12401();
  objective_setlabel(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/ATTACH_FULTON_WORLD");
  objective_setlocation(var_0.objectiveindex, 0, level.hostage_pickup.origin + (0, 0, 96));
  level notify("hvt_ready_to_fulton");
  level.hostage_pickup.body hudoutlinedisable();
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(0);
  level thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  level thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  level thread scripts\cp\cp_convoy_manager::set_despawn_distance(4000);
  level.hostage_pickup_pos = level.hostage_pickup.origin;
  thread ref_1356D();
  wait 1;
  little_bird_mg_deletenextframe();
  thread thread_hostage_fulton_anims(level);
  wait 0.1;
  little_bird_mg_deletenextframe();
  wait 0.1;
  little_bird_mg_deletenextframe();
  level waittill("fulton_hostage", var_2, var_3);
  objective_unsetlocation(var_0.objectiveindex, 0);
  objective_addteamtomask(var_0.objectiveindex, "spectator");
  ref_123E0(level);
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(6);
  wait 6;
  scripts\cp\cp_objectives::screenent_c("major_objective");
}

function ref_1356D() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");
  var_1 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var_0);
  var_2 = spawn("script_model", var_1.origin - (0, 0, 256));
  var_2 setModel("military_skyhook_parachute");
  var_2 notsolid();
  level waittill("players_go_to_safehouse");

  if(isent(var_2)) {
    var_2 delete();
    return;
  }
}

function obj_maj_extract_end(var_0) {
  if(isDefined(level.ref_13E36)) {
    level.ref_13E36 dodamage(level.ref_13E36.health + 100, level.ref_13E36.origin);
  }

  thread nag_player_remind_lore_vo();
  thread ref_12DEC();
  scripts\cp\cp_objectives::overridenextstep(var_0, "safehouse_return");
}

function obj_maj_exit_init(var_0) {
  level notify("end_wave_tugofwar_spawners");
}

function obj_maj_exit_start(var_0) {
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_extract_struct_apprehend");
  waitframe();
  level notify("call_exfil", level.hostage_pickup_pos);
  level waittill("ready_to_exfil");
  wait 4;
}

function obj_maj_exit_end(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1].ability_invulnerable = 1;
  }

  wait 3;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function allow_player_mantles() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].disable_hvt_nomantle = 1;
  }
}

function location_objective_remover() {
  level endon("game_ended");
  level endon("obj_tugofwar_delete_hostage");
  level.hostage_pickup endon("tugofwar_hvt_death");
  var_0 = 250000;
  var_1 = level.hostage_pickup.origin;

  while(distance2dsquared(level.hostage_pickup.origin, var_1) < var_0) {
    wait 1;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(istrue(level.players[var_2].disable_hvt_nomantle)) {
      level.players[var_2].disable_hvt_nomantle = undefined;

      if(isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == level.players[var_2]) {
        level.players[var_2] scripts\common\utility::allow_jump(0);
      }
    }
  }
}

function allow_hvt_stealing_by_ai() {
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  level thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1, 1);
  level thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
}

function delay_allow_pickup() {
  var_0 = 10;
  wait var_0;
  level notify("convoy_pickup_go_hvt");
}

function player_grabs_hostage(var_0) {
  level endon("stop_grab_obj");
  level waittill("player_picked_up_hostage");
  level.hostage_pickup.pickedupbyplayer = 1;
  level notify("stop_intro_vo");
  thread players_pickedup_hvt(level);
}

function players_pickedup_hvt(var_0) {
  level notify("stop_grab_obj");
  level notify("stop_intro_vo");
  scripts\engine\utility::flag_set("allow_convoy_roaming");
  binoculars_onstatemarkedenter(1.3);

  if(!istrue(level.all_convoys["the_convoy"].exiting)) {
    spawn_hvt_waypoint(level);
  }

  if(isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier) || !istrue(level.hostage_pickup.convoy_pickedup)) {
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_LABEL");
    return;
  }
}

function binoculars_onstatemarkedenter(var_0) {
  level.ref_11F7A = var_0;
}

function spawn_hvt_waypoint() {
  if(!isDefined(level.hostage_pickup.waypoint)) {
    var_0 = &scripts\cp\cp_pickup_hostage::create_objective;
    level.hostage_pickup.nowaypoint = undefined;
    level.hostage_pickup.waypoint = level.hostage_pickup[[var_0]](level.hostage_pickup.origin + (0, 0, 30), "icon_waypoint_marker");
    objective_onentity(level.hostage_pickup.waypoint, level.hostage_pickup);
    objective_setzoffset(level.hostage_pickup.waypoint, 32);
    level.hostage_pickup.attach_entity = level.hostage_pickup;
    return;
  }
}

function spawn_hvt_in_building() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = scripts\engine\utility::getStructArray("hvt_spawner_tugofwar", "script_noteworthy");
  var_1 = scripts\engine\utility::random(var_0);
  var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  level.obj_hvt_spawn_struct = var_1;
  thread inithvtmodel(level);
  scripts\engine\utility::flag_set("tugofwar_hvt_spawned");
}

function inithvtmodel(var_0) {
  var_1 = "smuggler_informant_fullbody";
  var_2 = &scripts\cp\cp_pickup_hostage::initdefaulthvtmodel;
  level.hostage_pickup = [[var_2]](var_0, var_1, undefined, &"CP_SMUGGLER/PICKUP_INFORMANT", "drop_informant", 0, "hostage_mage");
  level.hostage_pickup.nowaypoint = 1;
  level.hostage_pickup.label = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";

  if(!isDefined(level.hostage_pickup.interaction_handle)) {
    level.hostage_pickup waittill("hvt_interaction_updated");
  }

  level.hostage_pickup.sethotfunc = &hvtent_sethotfunc;
  thread players_holding_hvt_handler();
  level notify("hostage_spawned");
}

function wait_player_near(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = cos(65);
  var_4 = 230;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = var_4 * var_4;

  for(;;) {
    wait 0.25;

    if(istrue(var_2)) {
      var_6 = scripts\cp\utility::any_player_nearby(var_0, var_5);

      if(!var_6) {
        continue;
      }

      for(var_7 = 0; var_7 < level.players.size; var_7++) {
        var_8 = sighttracepassed(var_0, level.players[var_7] getEye(), 0, level.players[var_7]);

        if(var_8) {
          var_9 = scripts\engine\utility::within_fov(level.players[var_7].origin, level.players[var_7].angles, var_0 + (0, 0, 40), var_3);

          if(var_9) {
            return;
          }
        }
      }

      continue;
    }

    if(scripts\cp\utility::any_player_nearby(var_0, var_5)) {
      return;
    }
  }
}

function healthdraining_ui_set() {
  level endon("game_ended");

  for(;;) {
    self waittill("decreased_life");
    var_0 = int(self.life_left * 100);
    level thread scripts\cp\utility::objective_update("obj_informant_ui", undefined, undefined, undefined, 1, var_0, 2);
  }
}

function hvtent_sethotfunc(var_0, var_1) {
  self notify("sethotfunc");
  self endon("sethotfunc");
  self endon("freedobjective");
  level endon("tugofwar_hvt_placed");

  while(!isDefined(self.waypoint)) {
    wait 1;
  }

  var_2 = 90000;
  objective_setshowprogress(self.waypoint, 1);

  if(!isDefined(self.life_left)) {
    thread healthdraining_ui_set();
    self.life_left = 1;
    objective_setprogress(self.waypoint, 1);
    level.ref_11F7A = 2.5;
  }

  if(self.life_left <= 0.01) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(istrue(var_0)) {
    objective_sethot(self.waypoint, 1);

    for(;;) {
      if(isDefined(self.carrier) && isPlayer(self.carrier)) {
        break;
      }

      if(!isDefined(self) || !isDefined(self.life_left)) {
        break;
      }

      if(spawnglobalscriptabledelayed(var_2)) {
        self.life_left -= 0.01 * var_1;
        self notify("decreased_life");

        if(self.life_left <= 0.01) {
          thread hvt_death();
          return;
        } else {
          objective_setprogress(self.waypoint, self.life_left);
        }

        if(self.life_left % 0.05 == 0 && self.life_left > 0) {
          var_3 = int(self.life_left * 100);
          thread set_hvt_label_life(level);
        }
      }

      wait level.ref_11F7A;
    }

    return;
  }

  objective_sethot(self.waypoint, 0);
}

function spawnglobalscriptabledelayed(var_0) {
  if(isDefined(level.tugofwar_exfil_location)) {
    if(distancesquared(self.origin, level.tugofwar_exfil_location.origin) > var_0) {
      return 1;
    }

    self setuseholdduration("duration_long");
    return 0;
  }

  return 1;
}

function wait_for_hvt_near_exfil(var_0, var_1) {
  level endon("game_ended");
  level endon("hvt_near_exfil");
  var_2 = 300;
  var_3 = var_0.script_noteworthy;

  if(var_1 == "far") {
    var_4 = distance(level.hostage_pickup.origin, var_0.origin);
    var_5 = var_4 * 0.75;

    if(var_2 < var_5) {
      var_2 = var_5;
    }
  }

  var_6 = var_2 * var_2;

  for(;;) {
    wait 0.25;

    if(distancesquared(level.hostage_pickup.origin, var_0.origin) < var_6) {
      break;
    }
  }

  level notify("hvt_near_exfil", var_3, var_1);
}

function set_hvt_label_life(var_0) {
  var_1 = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";

  switch (var_0) {
    case 100:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_100";
      break;
    case 95:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_95";
      break;
    case 90:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_90";
      break;
    case 85:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_85";
      break;
    case 80:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_80";
      break;
    case 75:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_75";
      break;
    case 70:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_70";
      break;
    case 65:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_65";
      break;
    case 60:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_60";
      break;
    case 55:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_55";
      break;
    case 50:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_50";
      thread play_lost_health_vo();
      break;
    case 45:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_45";
      break;
    case 40:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_40";
      break;
    case 35:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_35";
      break;
    case 30:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_30";
      break;
    case 25:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_25";
      break;
    case 20:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_20";
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SMUGGLER/OBJ_RESCUE_INFORMANT", "allies", 4);
      break;
    case 15:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_15";
      break;
    case 10:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_10";
      break;
    case 5:
      var_1 = &"CP_SMUGGLER/INFORMANT_HP_05";
      break;
    case 0:
      var_1 = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";
      break;
  }

  if(isDefined(var_1)) {
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(var_1, 1);
    return;
  }
}

function hvt_death() {
  level notify("tugofwar_hvt_death");
  level.ref_11F62 = 1;
  thread set_hvt_label_life(level);
  play_hostage_dead_vo(level);
  scripts\cp\cp_objectives::ref_12868("obj_informant_bledout");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function handle_hvt_go_outside(var_0) {
  level endon("game_ended");
  var_0 endon("delete");
  level endon("fulton_hostage");

  if(!isDefined(var_0.hostage_drop_override_data)) {
    var_0.hostage_drop_override_data = spawnStruct();
  }

  var_1 = "";

  for(;;) {
    wait 0.1;

    if(istrue(var_0.carried_by_vehicle)) {
      if(var_1 == "fail") {
        continue;
      }

      var_1 = "fail";
      var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_EXTRACT_WORLD");
      var_0.can_fulton = 0;

      if(!isDefined(var_0.hostage_drop_override_data)) {
        var_0.hostage_drop_override_data = spawnStruct();
      }

      var_0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(!passed_all_sky_traces(var_0)) {
      if(var_1 == "fail") {
        continue;
      }

      var_1 = "fail";
      var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_OUTSIDE");
      var_0.can_fulton = 0;

      if(!isDefined(var_0.hostage_drop_override_data)) {
        var_0.hostage_drop_override_data = spawnStruct();
      }

      var_0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(var_1 == "pass") {
      continue;
    }

    var_1 = "pass";
    var_0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_EXTRACT_WORLD");
    var_0.can_fulton = 1;

    if(!isDefined(var_0.hostage_drop_override_data)) {
      var_0.hostage_drop_override_data = spawnStruct();
    }

    var_0.hostage_drop_override_data.preventuse = 1;
    var_0.hostage_drop_override_data.waittime = 3;
  }
}

function passed_all_sky_traces(var_0) {
  var_1 = 0;
  var_1 = pos_passes_sky_trace(var_0.origin);

  if(var_1 == 0) {
    return 0;
  }

  var_1 = pos_passes_sky_trace(var_0.origin, (500, 0, 3000));

  if(var_1 == 0) {
    return 0;
  }

  var_1 = pos_passes_sky_trace(var_0.origin, (-500, 0, 3000));

  if(var_1 == 0) {
    return 0;
  }

  var_1 = pos_passes_sky_trace(var_0.origin, (0, 500, 3000));

  if(var_1 == 0) {
    return 0;
  }

  var_1 = pos_passes_sky_trace(var_0.origin, (0, -500, 3000));
  return var_1;
}

function pos_passes_sky_trace(var_0, var_1) {
  var_2 = (0, 0, 3000);

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = var_0;
  var_4 = var_0 + var_2;

  if(var_4[2] <= var_3[2]) {
    return 0;
  }

  var_5 = scripts\engine\trace::_bullet_trace_passed(var_3, var_4, 0, undefined);
  return var_5;
}

function convoy_start() {
  if(!isDefined(level.hostage_pickup)) {
    level waittill("hostage_spawned");
  }

  level.convoy_speed_override = 30;
  var_0 = scripts\engine\utility::getStruct("convoy_start_north1", "targetname");
  var_1 = "small-roaming-stealing";
  var_2 = "the_convoy";
  var_3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_2, var_1, var_0, undefined, undefined, undefined);

  if(!isDefined(var_4)) {
    return;
  }

  thread convoy_init_settings(level);
  wait 0.1;
  thread convoy_think_handler(level);
  wait 3;
  level notify("allow_convoy_soldiers_target");
}

function convoy_init_settings(var_0) {
  var_0 thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  var_0 thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_hide_icon_on_pickup_target(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_targeted_hvt(level.hostage_pickup);
  var_0 thread scripts\cp\cp_convoy_manager::ref_130ED(1);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_pickup(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_convoy_death(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_nearby_convoy(0);
  var_0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_rescued(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1);
  var_0 thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_amount(8);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_btwn(3);
  var_0 thread scripts\cp\cp_convoy_manager::set_soldier_backup_deposit_names("hvi_runto_locations");
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_can_compromise_before_1st_target(0);
  var_0 thread scripts\cp\cp_convoy_manager::ref_130FE("backseats");
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_vehicles(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_support_vehicles(0);
  var_0 thread scripts\cp\cp_convoy_manager::allow_routing_to_any_vehicles(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(0);
  var_0 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  thread play_truck_anim(var_0);
  var_0.convoy_paths_override = "smuggler_convoy_paths";
}

function convoy_think_handler(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_target(level.hostage_pickup, undefined, undefined);
  var_0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_stop_all_cars(0);

  if(!istrue(var_1)) {
    wait 10;
  }

  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_distance(4000);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(12);
  var_0 thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(1000);
  var_0 thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(0);

  if(getdvarint("scr_disable_vehiclehack", 0) == 0) {
    foreach(var_3 in var_0.spawned_vehicles) {
      thread temp_vehicle_manuallysetspeed();
    }
  }

  if(!istrue(var_0.allowed_to_exit)) {
    var_0 waittill("convoy_exiting_after_pickup");
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_0 scripts\cp\cp_convoy_manager::set_convoy_durations_modifier(425);
  level notify("obj_set_roaming");
  var_0 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-1000);
  var_0 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  thread play_convoy_hostage_save_vo();
  thread hudnumconsumed(var_0);
  var_0.main_truck vehicleshowonminimap(1);
  var_0.main_truck aiupdatecoverexposetype(1);
  thread setup_waves_truck_section();
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var_0 thread scripts\cp\cp_convoy_manager::set_compromise_megahealth(1);
  thread convoy_damaged_tires(level);
  var_5 = scripts\cp\utility::getvehiclearray();
  var_6 = [];

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(isDefined(var_5[var_7].team) && var_5[var_7].team == "allies") {
      var_6 = var_5[var_7];
    }
  }

  var_0 waittill("convoy_compromised");
  level thread scripts\cp\cp_convoy_manager::toggle_convoy_wheel_outlines(0);
  thread play_convoy_hostage_vo();
}

function temp_vehicle_manuallysetspeed() {
  self endon("death");

  for(;;) {
    self waittill("startpathnodes");
    self vehicle_setspeed(level.convoy_speed_override, 10, 10);
  }
}

function hudnumconsumed(var_0) {
  var_0 endon("convoy_compromised");
  var_0 endon("convoy_center_death");
  var_1 = var_0.main_truck;

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = 22500;

  while(isalive(var_1)) {
    var_3 = var_1.origin;
    wait 5;
    var_4 = var_1.origin;

    if(distancesquared(var_4, var_3) < var_2) {
      var_0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
    }
  }
}

function hvt_wait_for_pickup() {
  level.hostage_pickup scripts\engine\utility::ref_143A5("convoy_pickedup_hvt", "player_picked_up_hostage");
  spawn_hvt_waypoint(level);
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_LABEL");
}

function convoy_damaged_tires(var_0) {
  var_1 = 0;

  for(;;) {
    if(var_1 >= 3) {
      break;
    }

    var_0 waittill("vehicle_lost_wheel");
    var_1 += 1;
  }

  wait 1.5;
  var_0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
}

function playerhandlesandboxmenu() {
  level.blueprintextract_trygetreward = 0;
  level.bmoendgameot = "power_thermite";
  level.blueprintextract_shouldgivereward = "offhand_wm_grenade_thermite";
  level.blueprintextractchance = 400;
}

function spawn_intro_soldiers() {
  level.spawn_module_intro2 = scripts\cp\cp_modular_spawning::run_spawn_module("building_guards_important");
  level.ref_13595 = scripts\cp\cp_modular_spawning::run_spawn_module("building_guards_important_jugg");
  wait 0.1;
  level.spawn_module_intro = scripts\cp\cp_modular_spawning::run_spawn_module("building_guards");
  level.ref_13596 = scripts\cp\cp_modular_spawning::run_spawn_module("building_snipers");
  level.ref_13597 = scripts\cp\cp_modular_spawning::run_spawn_module("building_rpg");
}

function first_bleedout() {
  var_0 = getEntArray("building_magic_grenade", "targetname");

  foreach(var_2 in var_0) {
    thread firing_start_locs();
  }
}

function firing_start_locs() {
  self endon("death");
  var_0 = getEnt(self.target, "targetname");
  jumpiffalse(isDefined(var_0)) LOC_00000023;
  thread firestation_jugg_test(var_0);

  for(;;) {
    self waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_3 = "frag";

  if(isDefined(var_2.script_noteworthy)) {
    var_3 = var_2.script_noteworthy;
  }

  var_4 = 1000;

  if(isDefined(var_2.script_grenadespeed)) {
    var_4 = int(var_2.script_grenadespeed);
  }

  var_5 = vectorNormalize(anglesToForward(var_2.angles));
  var_6 = var_5 * var_4;

  if(isDefined(var_2.script_timer)) {
    var_7 = float(var_2.script_timer);
    var_8 = magicgrenademanual("frag_grenade_mp", var_2.origin, var_6, var_7);
  } else {
    var_8 = magicgrenademanual("frag_grenade_mp", var_3.origin, var_8, 2.25);
  }

  if(isDefined(var_8)) {
    thread firestation_jugg_spawn(var_8);
    return;
  }
}

function firestation_jugg_spawn(var_0) {
  var_0 endon("trigger");
  var_0 waittill("explode", var_1);
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(var_2.size > 0) {
    var_3 = scripts\engine\utility::getclosest(var_1, var_2);
    var_3 radiusdamage(var_1, 256, 140, 70, var_3, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
    return;
  }

  radiusdamage(var_1, 256, 140, 70, undefined, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
}

function firestation_jugg_test(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    wait 0.05;
    var_0 delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function ref_131E9() {
  var_0 = scripts\engine\utility::getStructArray("enemy_sentry", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    thread ref_131EA(var_2);
  }
}

function ref_131EA(var_0) {
  var_1 = "sentry_turret";
  var_2 = level.sentrysettings[var_1];
  var_3 = spawnturret("misc_turret", var_0.origin, level.sentrysettings[var_1].weaponinfo);
  var_3.team = "axis";

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_3.angles = var_0.angles;
  var_3.health = var_2.maxhealth;
  var_3.maxhealth = var_2.maxhealth;
  var_3.sentrytype = var_1;
  var_3.momentum = 0;
  var_3.heatlevel = 0;
  var_3.overheated = 0;
  var_3.cooldownwaittime = 2;
  var_3.turrettype = "sentry_turret";
  var_3 setModel("weapon_wm_mg_sentry_turret");
  var_3 setturretteam("axis");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 setautorotationdelay(0.2);
  var_3 maketurretinoperable();
  var_3 setleftarc(80);
  var_3 setrightarc(80);
  var_3 setbottomarc(50);
  var_3 settoparc(60);
  var_3 setconvergencetime(0.6, "pitch");
  var_3 setconvergencetime(0.6, "yaw");
  var_3 setconvergenceheightpercent(0.65);
  var_3 setdefaultdroppitch(-89);
  var_3 setturretmodechangewait(1);
  var_3 solid();
  var_3 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var_3 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  var_3 scripts\cp_mp\emp_debuff::allow_emp(0);
  wait 1;
  var_3 setmode("auto_nonai");
  var_3 scripts\cp_mp\emp_debuff::allow_emp(1);
  sentryturret_empupdate(var_3);
  var_3 thread scripts\mp\carriable::is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  var_3 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var_3;
}

function sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }

  sentryturret_empupdate();
}

function sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
    return;
  }

  self turretfireenable();
  self setmode("auto_nonai");
}

function node_fields_after_goal_skit() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  var_0 = self.origin;
  var_1 = 0.05;
  var_2 = int(var_1 * 20);

  for(;;) {
    wait var_1;
  }
}

function sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var_0;
      wait var_0;
    }

    wait randomfloatrange(var_3, var_4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function sentry_heatmonitor() {
  self endon("death");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1) {
      wait var_0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}

function sentry_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self)) {
    thread sentry_deleteturret();
    return;
  }
}

function sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");
  wait 0.1;
  self notify("deleting");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function spawn_escalation_soldiers() {
  thread handle_escalation_increases();
}

#using_animtree("");

function anim_init_trafficking() {
  level.scr_animtree["tugofwar_soldier"] = #animtree;
  level.scr_anim["tugofwar_soldier"]["place_hvt_into_truck"] = $sdr_cp_hostage_dropoff_mkilo23_carry_smuggler;
  level.scr_animname["tugofwar_soldier"]["place_hvt_into_truck"] = "sdr_cp_hostage_dropoff_mkilo23_carry_smuggler";
  level.scr_eventanim["tugofwar_soldier"]["place_hvt_into_truck"] = "sdr_cp_hostage_dropoff_mkilo23_carry_smuggler";
  level.scr_animtree["tugofwar_informant"] = #animtree;
  level.scr_anim["tugofwar_informant"]["place_hvt_into_truck"] = % sdr_cp_hostage_dropoff_mkilo23_hostage;
  level.scr_animname["tugofwar_informant"]["place_hvt_into_truck"] = "sdr_cp_hostage_dropoff_mkilo23_hostage";
  level.scr_eventanim["tugofwar_informant"]["place_hvt_into_truck"] = "sdr_cp_hostage_dropoff_mkilo23_hostage";
  anim_init_truck();
}

function anim_init_truck() {
  level.scr_animtree["tugofwar_truck"] = #animtree;
  level.scr_anim["tugofwar_truck"]["truck_hatchopen"] = $htf_pop_020_trafficking_truck_01_load_cp;
  level.scr_anim["tugofwar_truck"]["truck_clear"] = % htf_pop_020_trafficking_truck_01_load;
}

function play_truck_anim(var_0) {
  while(!isDefined(var_0.main_truck)) {
    wait 0.1;
  }

  wait 0.1;
  var_1 = var_0.main_truck;
  thread truck_waittill_death();
  var_2 = (-80, 0, 82);
  var_3 = &scripts\cp\cp_vehicles::spawn_ai_in_truck;
  level thread[[var_3]](var_1, 1, undefined, 0, undefined, "juggernaut", var_2, 1, &ref_144AA);
  var_1 endon("death");
  var_4 = level.scr_anim["tugofwar_truck"]["truck_hatchopen"];
  var_5 = level.scr_anim["tugofwar_truck"]["truck_clear"];

  while(isent(var_1)) {
    var_1 vehicleplayanim(var_5);
    waitframe();
    var_1 vehicleplayanim(var_4);
    wait 20;
  }
}

function truck_waittill_death() {
  level endon("game_ended");
  self waittill("death");
  var_0 = scripts\cp\utility::get_closest_living_player();
  wait 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "flavor_positive", undefined, 1);
}

function setup_trafficking_soldier_anims(var_0, var_1) {
  level endon("convoy_exiting_after_pickup");
  self waittill("tugofwar_playanim");
  thread anim_trafficking_soldier_play();
}

function anim_trafficking_soldier_play() {
  self endon("death");
  var_0 = level.all_convoys["the_convoy"].main_truck;
  var_1 = (0, 0, 0);
  var_2 = (-185, 18, -64);
  var_3 = rotatevector(var_2, var_0.angles);
  var_4 = var_0 gettagorigin("tag_accessory_01") + var_3;
  var_5 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim["tugofwar_soldier"]["place_hvt_into_truck"]);

  if(isent(var_0)) {
    var_1 = var_0.angles;
  }

  level.hostage_pickup.body hide();
  self hide();
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self.og_health = self.health;
  self.og_maxhealth = self.maxhealth;
  self.maxhealth = 99999;
  self.health = 99999;
  var_6 = spawn("script_model", self.origin);
  var_6 setModel(self.model);
  var_6.angles = self.angles;
  var_6.animname = "place_hvt_into_truck";
  var_6 useanimtree(level.scr_animtree["tugofwar_soldier"]);
  var_6.head = spawn("script_model", self.origin);
  var_6.head setModel(self.headmodel);

  if(var_6.model == "body_spetsnaz_cqc") {
    var_6.head linkTo(var_6, "j_neck", (-8, 1, 0), (0, 0, 0));
  } else {
    var_6.head linkTo(var_6, "j_neck", (-21, 1, 0), (0, 0, 0));
  }

  var_7 = spawn("script_model", level.hostage_pickup.origin);
  var_7 setModel(level.hostage_pickup.bodymodel);
  var_7.angles = level.hostage_pickup.angles;
  var_7.animname = "place_hvt_into_truck";
  var_7 useanimtree(level.scr_animtree["tugofwar_informant"]);
  var_8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "tugofwar_soldier");
  var_8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_7, "tugofwar_informant");
  var_9 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_10 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  thread scripts\cp\utility::drawsphere(var_10.origin, 5, 9999, (0, 1, 1));
  thread buildweapon_blueprint();
  thread bunker_initinteraction(level, var_10, var_8);
  wait 11;
  level.hostage_pickup.body show();
  var_10 scripts\cp_mp\anim_scene::anim_scene_stop(1);
  var_6.head delete();
  reset_guy(self, var_5, var_1);
  wait 1;
  var_6 delete();
  var_7 delete();
}

function buildweapon_blueprint() {
  self endon("death");
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
  wait 0.5;
  self hide();
}

function anim_trafficking_play_scene_soldier(var_0, var_1) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function anim_trafficking_play_scene_informant(var_0, var_1) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function bunker_initinteraction(var_0, var_1, var_2) {
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_1, var_2], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function reset_guy(var_0, var_1, var_2) {
  var_0 allowedstances("prone", "stand", "crouch");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0 setCanDamage(1);
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.origin = getclosestpointonnavmesh(var_1);
  var_0.angles = var_2;
  var_0.health = int(min(var_0.og_health, 400));
  var_0.maxhealth = int(min(var_0.og_maxhealth, 400));
  var_0 show();

  if(istrue(var_0.never_kill_off)) {
    var_0.never_kill_off = 0;
    return;
  }
}

function register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("cp_tugofwar_north_create_script_completed") || !scripts\engine\utility::flag("cp_tugofwar_north_create_script_completed")) {
    scripts\engine\utility::flag_set("cp_tugofwar_north_create_script");
    scripts\engine\utility::flag_wait("cp_tugofwar_north_create_script_completed");
  }

  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  var_1 = 18;
  [[var_0]]("building_guards", var_1, var_1, var_1, 0.1, 0, "building_guards", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards", undefined, 10000, 20000);
  [[var_0]]("building_guards_important", 1, 1, 1, 0.1, 0, "building_guards_important", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards_important", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards_important", undefined, 20000, 30000);
  [[var_0]]("building_guards_important_jugg", 1, 1, 1, 0.1, 0, "building_guards_important_jugg", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards_important", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards_important", undefined, 20000, 30000);
  [[var_0]]("building_snipers", 2, 2, 2, 8, 0, "building_snipers", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_snipers", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_snipers", undefined, 20000, 30000);
  [[var_0]]("building_rpg", 2, 2, 2, 12, 0, "building_rpg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_rpg", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_rpg", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_building1", 4, 4, 4, 0.1, 0, "lbravo_spawner_building1", undefined, undefined, undefined);
  [[var_0]]("lbravo_spawner_building2", 4, 4, 4, 0.1, 0, "lbravo_spawner_building2", undefined, undefined, undefined);
  [[var_0]]("escalation_juggs_01", 0, 1, 250, 20, 0, "escalation_juggs_01", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", &watchforstopwaves, undefined, undefined);
  [[var_0]]("tugofwar_exfil_hvt", 1, 1, 1, 0.1, 0, "tugofwar_exfil_hvt", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tugofwar_exfil_hvt", &setup_hostage_fulton_anims);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("tugofwar_exfil_hvt", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_safehouse1", 4, 4, 4, 0.1, 0, "lbravo_spawner_safehouse1", undefined, undefined, undefined);
  [[var_0]]("lbravo_spawner_safehouse2", 4, 4, 4, 0.1, 0, "lbravo_spawner_safehouse2", undefined, undefined, undefined);
  [[var_0]]("techo_phys_tow1", 6, 6, 6, 0.1, 0, "techo_phys_tow1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow1", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow2", 6, 6, 6, 0.1, 0, "techo_phys_tow2", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow2", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow3", 6, 6, 6, 0.1, 0, "techo_phys_tow3", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow3", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow4", 6, 6, 6, 0.1, 0, "techo_phys_tow4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow4", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow5", 6, 6, 6, 0.1, 0, "techo_phys_tow5", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow5", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow6", 6, 6, 6, 0.1, 0, "techo_phys_tow6", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow6", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow7", 6, 6, 6, 0.1, 0, "techo_phys_tow7", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow7", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow8", 6, 6, 6, 0.1, 0, "techo_phys_tow8", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow8", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow9", 6, 6, 6, 0.1, 0, "techo_phys_tow9", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow9", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow10", 6, 6, 6, 0.1, 0, "techo_phys_tow10", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow10", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow11", 6, 6, 6, 0.1, 0, "techo_phys_tow11", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow11", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow12", 6, 6, 6, 0.1, 0, "techo_phys_tow12", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow12", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow13", 6, 6, 6, 0.1, 0, "techo_phys_tow13", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow13", &playerhumanconcusspush);
  [[var_0]]("techo_phys_tow14", 6, 6, 6, 0.1, 0, "techo_phys_tow14", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow14", &playerhumanconcusspush);
  targets_killed();
}

function targets_killed(var_0) {
  var_1 = getEntArray("spawn_trigger", "targetname");

  foreach(var_3 in var_1) {
    thread targetoverride(var_3);
  }
}

function targetoverride(var_0) {
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_2 = var_1.size;
  scripts\cp\cp_modular_spawning::registerambientgroup(self.target, var_2, var_2, var_2, 0.1, undefined, self.target);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(self.target, 200, 20000, 30000);

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "building_roof_jugg":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, &first_move);
        break;
      case "building_ambusher":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, &broadcast_carry_items);
        break;
      case "chopper_roof_lander":
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, &ref_12D86);
        break;
    }
  }

  thread trigger_spawn(var_0);
  thread ref_13DB0();
}

function ref_13DB0() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.classname) && issubstr(var_2.classname, "trigger")) {
      thread ref_13DB1(var_2);
    }
  }
}

function ref_13DB1(var_0) {
  level endon("game_ended");
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var_0 scripts\engine\utility::delaycall(0.1, &delete);
  self delete();
}

function trigger_spawn(var_0) {
  level endon("game_ended");
  self endon("stop_spawning");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var_1 isparachuting() || var_1 isskydiving()) {
      continue;
    }

    break;
  }

  var_2 = self.target;
  var_3 = scripts\cp\cp_modular_spawning::run_spawn_module(var_2);
  self delete();
}

function first_move(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_2 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var_2)) {
      var_3 = 600;

      if(isDefined(var_2.radius)) {
        var_3 = var_2.radius;
      }

      thread first_pressure_switch_triggered(var_2, var_3);
      return;
    }

    return;
  }
}

function watch_for_player_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isPlayer(var_1)) {
      self.ref_132B8 = 1;
      return;
    }
  }
}

function first_pressure_switch_triggered(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self.combat_func_active = 1;
  var_2 = 5;
  var_3 = var_2;
  thread watch_for_player_damage();

  while(isDefined(var_0)) {
    if(var_3 <= 0) {
      scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
      var_3 = var_2;
    }

    var_4 = 300;

    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_4 * var_4)) {
      break;
    }

    var_5 = 500;

    if(buystationtrig(self.origin, var_5 * var_5, 128)) {
      break;
    }

    var_6 = scripts\engine\utility::getStruct("building_roof_jugg_zone", "targetname");
    var_7 = 1100;
    var_8 = 500;

    if(!buystationtrig(var_6.origin, var_7 * var_7, var_8)) {
      break;
    }

    if(istrue(self.ref_132B8)) {
      break;
    }

    var_3--;
    wait 1;
  }

  self.combat_func_active = undefined;

  for(;;) {
    var_9 = randomintrange(4, 7);
    var_10 = int(var_9 * 20);
    var_11 = scripts\cp\utility::get_closest_living_player(16000000);

    if(isDefined(var_11)) {
      scripts\cp\cp_modular_spawning::set_goal_radius(500);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_11.origin);
    }

    wait var_9;
  }
}

function buystationtrig(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 64;
  }

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0) < var_1) {
      if(abs(var_4.origin[2] - var_0[2]) < var_2) {
        return true;
      }
    }
  }

  return false;
}

function broadcast_carry_items(var_0, var_1) {
  self endon("death");
  wait 0.5;
  var_2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2)) {
    self getenemyinfo(var_2);
    self setgoalpos(var_2.origin);
    return;
  }
}

function ref_12D86(var_0, var_1) {
  self endon("death");
  wait 0.5;
  var_2 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var_2);
}

function playergetspectatingplayer(var_0, var_1) {
  self endon("death");
  self.sightmaxdistance = 2200;
  self.is_on_platform = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var_2 = 500;
  var_3 = 500;

  for(;;) {
    jumpiftrue(istrue(self.entered_combat)) LOC_00000043;
    waitframe();
  }

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distancesquared(var_6.origin, self.origin) < var_2 * var_2) {
        var_4 = 1;
      }

      wait 0.5;
    }

    if(var_4) {
      break;
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var_3);
  self.goalheight = 64;

  for(;;) {
    self.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);

    if(istrue(self.entered_combat)) {
      wait 15;
      continue;
    }

    wait 5;
  }
}

function setup_manual_goalpos(var_0, var_1) {
  thread setup_trafficking_soldier_anims(var_0, var_1);
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "building_guards":
      self notify("basic_combat");
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
    case "building_guards_important":
      self.dontkilloff = 1;
      self.never_kill_off = 1;
      self.maxhealth = 600;
      self.health = 600;
      self.ignoreall = 1;
      thread ref_144AA();
      self.script_origin_other = self.origin;
      break;
    case "building_guards_important_jugg":
      self.dontkilloff = 1;
      self.never_kill_off = 1;
      self.ignoreall = 1;
      thread ref_144AA(600);
      break;
    default:
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
  }
}

function playerhumanconcusspush(var_0, var_1) {
  self.grenadeweapon = getcompleteweaponname("iw8_thermite_mp");
  self.grenadeammo = 2;
}

function ref_144AA(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = 810000;

  if(isDefined(var_0)) {
    var_1 = var_0 * var_0;
  }

  for(;;) {
    wait 0.3;

    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      break;
    }

    if(self.health < self.maxhealth - 1) {
      break;
    }
  }

  if(istrue(self.ignoreall)) {
    self.ignoreall = 0;
    return;
  }
}

function setup_waves_truck_section() {
  level notify("end_wave_tugofwar_spawners");
  wait 1;
  level thread scripts\cp\cp_wave_spawning::killstreaks(10, "smugg_p2_truck");
  wait 10;
  level notify("weapons_free");
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("end_wave_tugofwar_spawners");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function stopwaveandstartthisone(var_0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var_0]]();
}

function players_holding_hvt_handler() {
  level endon("game_ended");
  level endon("hvt_ready_to_fulton");

  for(;;) {
    level.hostage_pickup waittill("player_picked_up_hostage", var_0);

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addclienttomask(level.hostage_pickup.waypoint, var_0);
      objective_hidefromplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc)) {
        level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](0);
      }
    }

    if(isDefined(level.hostage_pickup.body)) {
      level.hostage_pickup.body hudoutlineenable("outline_nodepth_green");
    }

    var_1 = level.hostage_pickup scripts\engine\utility::ref_143AD("dropped", "placed_into_player_vehicle");

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addalltomask(level.hostage_pickup.waypoint);
      objective_showtoplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc)) {
        if(isDefined(var_1) && var_1 == "dropped") {
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1);
          thread allow_hvt_stealing_by_ai();
          level.hostage_pickup.interaction_handle sethintdisplayfov(120);
          level.hostage_pickup.interaction_handle sethintdisplayrange(220);
          level.hostage_pickup.interaction_handle setuserange(120);
        } else if(isDefined(var_1) && var_1 == "placed_into_player_vehicle") {
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1, 0.5);
        }
      }
    }

    if(isDefined(level.hostage_pickup.body)) {
      level.hostage_pickup.body hudoutlinedisable();
    }
  }
}

function setup_hostage_fulton_anims(var_0, var_1) {
  self.maxhealth = 99999;
  self.health = 99999;
  level.obj_tugofwar_civ_hvt = self;
}

function ref_13B34() {
  level endon("game_ended");
  level endon("hvt_stop_idle");
  var_0 = 4;

  for(;;) {
    self stopuseanimtree();
    self scriptmodelclearanim();
    self scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
    wait var_0;
  }
}

function thread_hostage_fulton_anims(var_0) {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level.hostage_pickup.interaction_handle makeunusable();
  little_bird_mg_deletenextframe();
  level notify("obj_tugofwar_delete_hostage");
  level.playertimedinvunerable = spawn("script_model", level.hostage_pickup_pos);
  level.playertimedinvunerable.angles = var_0.angles;
  level.playertimedinvunerable setModel("smuggler_informant_fullbody");
  level.playertimedinvunerable.animname = "fulton_hostage";
  level.playertimedinvunerable useanimtree(level.scr_animtree["fulton_hostage"]);
  level.playertimedinvunerable dontinterpolate();
  level.playertimedinvunerable hide();
  little_bird_mg_deletenextframe();
  level.hostage_pickup.interaction_handle makeunusable();
  level.playerthrowsmokesignal = spawn("script_model", level.playertimedinvunerable.origin);
  level.playerthrowsmokesignal setModel("tag_origin");
  level.hostage_pickup.body delete();
  level.hostage_pickup thread scripts\cp\cp_pickup_hostage::deletepickuphostage();
  level.playertimedinvunerable show();
  little_bird_mg_deletenextframe();
  thread ref_13B34();
  level thread scripts\cp\cp_hostage::create_vip_fulton_trigger(level.playertimedinvunerable, (0, 180, 0));
  level thread scripts\cp\cp_hostage::anim_fulton_hostage_player_scene(level.playertimedinvunerable, level.playerthrowsmokesignal, 11.2);
}

function little_bird_mg_deletenextframe() {
  if(isDefined(level.hostage_pickup) && isDefined(level.hostage_pickup.interaction_handle)) {
    level.hostage_pickup.interaction_handle makeunusable();
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label("");
    level.hostage_pickup scripts\cp\cp_pickup_hostage::togglehvtusable(0);
    level.hostage_pickup.interaction_handle makeunusable();
    return;
  }
}

function handle_escalation_increases() {
  level endon("game_ended");
  var_0 = level.hostage_pickup.origin;
  var_1 = 0;
  var_2 = 1000;
  var_3 = 1700;
  var_4 = 4;
  var_5 = undefined;

  for(;;) {
    if(!isDefined(level.hostage_pickup)) {
      return;
    }

    var_5 = var_4;
    var_1 = distance2d(level.hostage_pickup.origin, var_0);

    if(var_1 > var_2) {
      var_6 = var_1 / var_2;
      var_5 *= var_6;
    }

    if(var_1 < var_3) {
      level thread scripts\cp\cp_escalation::increase_escalation_counter();
    }

    wait var_5;
  }
}

function suicide_bomber_combat_func() {
  self endon("death");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on)) {
        self.bombertarget = self.enemy.vehicle_riding_on;
      } else {
        self.bombertarget = undefined;
      }
    }

    wait 0.25;
  }
}

function get_closet_alive_player(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

function spawn_atvs() {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var_0 = scripts\engine\utility::getStructArray("tugofwar_atv_spawn", "targetname");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

function ref_135E1(var_0) {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.tacrovers)) {
    level.tacrovers = [];
  }

  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  level thread scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_createfromstructs(var_1, 1);
}

function ref_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("tugofwar");
}

function play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4)) {
    wait var_4;
  }

  if(isDefined(var_0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "allies", var_3, var_5, var_6);
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(isDefined(var_2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
    return;
  }
}

function vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 /= 1000;
  return var_1;
}

function ref_12DEC() {
  level endon("game_ended");
  level.watchremoveminigunrestrictions = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_safehouse1");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_safehouse1");
  wait 10;
  level.watchsnowballpickup = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_safehouse2");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_safehouse2");
}

function nag_player_remind_lore_vo() {
  level endon("game_ended");
  wait 2;
  level scripts\engine\utility::delaythread(3, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_10", "allies");
  level scripts\engine\utility::delaythread(16, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_20", "allies");
  level.ref_12E5C = scripts\engine\utility::getStruct("safehouse_struct", "targetname");
  var_0 = scripts\engine\utility::getStructArray("ending_mortar_launcher", "targetname");
  var_1 = spawn("script_model", scripts\engine\utility::random(var_0).origin);
  var_1 setModel("misc_wm_mortar");
  var_2 = 1;
  var_3 = 4;
  var_4 = 7;
  var_5 = 0.5;
  var_6 = 1;
  var_7 = 1000;
  var_8 = 300;
  var_9 = 6;

  while(var_7 > 0) {
    var_10 = quarry_intro1_chopper(var_9, var_2, var_8);

    foreach(var_12 in var_10) {
      var_13 = scripts\engine\utility::random(var_0).origin;
      var_14 = 2600;
      var_1 thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::launch_mortar(var_13, var_12, undefined, var_14);
      wait randomfloatrange(var_5, var_6);
    }

    if(var_2 > 0 || trial_turrets_killed()) {
      wait var_3;
    } else {
      wait randomfloatrange(var_3, var_4);
    }

    var_7--;
    var_2--;
  }
}

function trial_turrets_killed() {
  var_0 = getEnt("smuggler_safehouse_2_volume", "targetname");
  var_1 = scripts\mp\vehicles\vehicle_damage_mp::ref_11F27(var_0);
  return var_1 > 0;
}

function quarry_intro1_chopper(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_1) && var_1 > 0) {
    var_2 *= 4;
  }

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && isalive(var_5) && !scripts\cp\cp_laststand::player_in_laststand(var_5) && !var_5 isspectatingplayer()) {
      if(istrue(var_5.bspawningviaac130)) {
        continue;
      }

      if(scripts\engine\utility::distance_2d_squared(var_5.origin, level.ref_12E5C.origin) < int(level.ref_12E5C.radius) * int(level.ref_12E5C.radius)) {
        continue;
      }

      var_6 = 1;

      if(scripts\engine\utility::cointoss()) {
        var_6++;
      }

      for(var_7 = 0; var_7 < var_6; var_7++) {
        var_3 = race_ui_critical_message_timer(var_5.origin, var_2);
      }
    }
  }

  if(var_3.size < var_0) {
    var_9 = var_0 - var_3.size;
    var_10 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");

    for(var_7 = 0; var_7 < var_9; var_7++) {
      var_11 = scripts\engine\utility::random(var_10);
      var_12 = var_11.origin;

      if(isDefined(level.hostage_pickup_pos)) {
        var_12 = level.hostage_pickup_pos;
      }

      var_3 = race_ui_critical_message_update(var_12, level.ref_12E5C.origin);
    }
  }

  return var_3;
}

function race_ui_critical_message_update(var_0, var_1) {
  var_2 = randomfloatrange(0.5, 0.85);
  var_3 = vectorlerp(var_0, var_1, var_2);
  var_4 = scripts\engine\utility::drop_to_ground(var_3, 500, -1000);

  if(!isDefined(var_4)) {
    var_4 = var_3;
  }

  if(var_0[2] > var_1[2]) {
    var_5 = var_1[2];
    var_6 = var_0[2];
  } else {
    var_5 = var_2[2];
    var_6 = var_3[2];
  }

  var_6 = (var_6[0], var_6[1], clamp(var_6[2], var_5, var_6));
  return var_6;
}

function race_ui_critical_message_timer(var_0, var_1) {
  var_2 = randomfloatrange(var_1 / -2, var_1 / 2);
  var_3 = randomfloatrange(var_1 / -2, var_1 / 2);
  var_4 = (var_2, var_3, 0);
  var_5 = scripts\engine\utility::drop_to_ground(var_0 + var_4, 500, -1000);

  if(!isDefined(var_5)) {
    var_5 = var_0 + var_4;
  }

  return var_5;
}

function debug_start_apprehension(var_0) {
  thread threaded_start_tugofwar();
}

function threaded_start_tugofwar() {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "apprehension_debug_start_loc", 1);
  level waittill("spawned_player_car");
  var_0 = scripts\engine\utility::getStruct("apprehension_humvee_start", "targetname");
  scripts\cp\maps\cp_br_syrk\vehicle_travel::teleport_humvee_to_struct(var_0);
}

function ref_1240B() {
  var_0 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  play_vo_delay(level, "dx_cps_lass_tug_of_war_brief_10");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "ping_response_affirm");
  thread ref_12410();

  if(!isDefined(level.all_convoys["the_convoy"].main_truck)) {
    level waittill("new_convoy_spawned");
  }

  thread ref_123C0();
}

function ref_12410() {
  level.hostage_pickup endon("convoy_pickedup_hvt");
  var_0 = 40000;

  while(!scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var_0)) {
    wait 0.2;
  }

  level notify("tugofwar_vo_saw_hvt");
  thread spawn_module_intro3(level);
  var_1 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_1, "obj_visual");
  play_vo_delay(level, "dx_cps_lass_tug_of_war_found_informant_hotel_20");
}

function ref_123C0() {
  var_0 = level.all_convoys["the_convoy"].main_truck;

  if(!isDefined(var_0)) {
    return;
  }

  level.all_convoys["the_convoy"] endon("convoy_compromised");
  level.all_convoys["the_convoy"] endon("convoy_center_death");
  var_1 = 90000;

  while(distance2dsquared(level.hostage_pickup.origin, var_0.origin) > var_1) {
    wait 0.2;
  }

  thread play_vo_delay(level);
}

function ref_12411() {
  if(istrue(level.ref_13E35)) {
    return;
  }

  level.ref_13E35 = 1;
  thread spawn_module_intro3(level);
  thread play_vo_delay(level);
  wait 15;
  level.ref_139B5 = 0;
}

function play_convoy_hostage_save_vo() {
  scripts\engine\utility::flag_init("tugofwar_vo_playing_disabled");
  var_0 = 1;
  wait var_0;
  thread play_player_follow_truck();
  wait 6 - var_0;

  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    return;
  }

  if(!istrue(level.hostage_pickup.convoy_pickedup)) {
    return;
  }

  thread play_vo_delay(level, "dx_cps_lass_tug_of_war_convoy_leaving_10", undefined);
  thread ref_123FA();
}

function ref_123FA() {
  level.hostage_pickup endon("player_picked_up_hostage");
  level.hostage_pickup endon("tugofwar_hvt_death");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_cps_lass_tug_of_war_nag_convoy_10");
}

function ref_12400() {
  var_0 = 4000000;
  var_1 = 10;

  if(scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var_0)) {
    if(isDefined(level.spawn_ml_p2_sentries) && gettime() > level.spawn_ml_p2_sentries + var_1 || !isDefined(level.spawn_ml_p2_sentries)) {
      var_2 = [];
      GscBinSkip0(0x2e, var_2.size, "dx_cps_infr_tug_of_war_informant_pickup_10");
    }

    return;
  }
}

function play_player_follow_truck() {
  self endon("death");
  var_0 = scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_target_moving");
  wait 11;

  if(isDefined(self)) {
    var_0 = scripts\cp\utility::get_closest_living_player();
  }

  if(isDefined(var_0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "flavor_hurryup");
    return;
  }
}

function play_lost_health_vo() {}

function play_waitfor_ai_drop_vo(var_0) {
  level endon("game_ended");
  level endon("hvt_ready_to_fulton");

  if(istrue(level.vo_played_waitforaidrop)) {
    return;
  }

  level.vo_played_waitforaidrop = 1;
  var_0 waittill("convoy_pickedup_hvt");
  var_0 waittill("player_picked_up_hostage");
  wait 2;
  thread ref_12411();

  for(;;) {
    var_0 waittill("convoy_pickedup_hvt");
    var_1 = ["dx_cps_infr_tug_of_war_informant_grabbed_10", "dx_cps_infr_tug_of_war_informant_grabbed_20", "dx_cps_infr_tug_of_war_informant_grabbed_30"];
    var_2 = scripts\engine\utility::random(var_1);
    thread spawn_module_intro3(level);
    wait randomfloatrange(1, 2);
    var_3 = ["dx_cps_lass_tug_of_war_informant_grabbed_overlord_10", "dx_cps_kama_tug_of_war_informant_grabbed_overlord_20", "dx_cps_kama_tug_of_war_informant_grabbed_overlord_30"];
    var_4 = scripts\engine\utility::random(var_3);
    play_vo_delay(level, var_4);
  }
}

function play_convoy_hostage_vo() {
  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    return;
  }

  if(!istrue(level.hostage_pickup.convoy_pickedup)) {
    return;
  }

  scripts\engine\utility::flag_set("tugofwar_vo_playing_disabled");
  play_vo_delay(level, "dx_cps_lass_tug_of_war_convoy_disabled_10");
  wait 3;
  scripts\engine\utility::flag_clear("tugofwar_vo_playing_disabled");
}

function ref_1240F() {
  var_0 = level.hostage_pickup.carrier;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "obj_package");
  play_vo_delay(level, "dx_cps_lass_tug_of_war_informant_extraction_10");
  wait 1;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "ping_response_affirm");
  thread ref_12402();
}

function ref_12402() {
  level endon("game_ended");
  level endon("tugofwar_hvt_placed");
  wait 3;

  if(istrue(level.ref_13E34)) {
    return;
  }

  var_0 = 20;
  var_1 = ["dx_cps_lass_tug_of_war_nag_extraction_10", "dx_cps_lass_tug_of_war_nag_extraction_20"];

  for(;;) {
    play_vo_delay(level, scripts\engine\utility::random(var_1));
    wait randomfloatrange(10, var_0);

    if(var_0 < 50) {
      var_0 += 2;
    }
  }
}

function ref_12401() {
  level endon("game_ended");
  level endon("fulton_hostage");
  var_0 = 20;
  var_1 = ["dx_cps_kama_tug_of_war_nag_fulton_prep_10", "dx_cps_kama_tug_of_war_nag_fulton_prep_20"];

  for(;;) {
    play_vo_delay(level, scripts\engine\utility::random(var_1));
    wait randomfloatrange(10, var_0);

    if(var_0 < 50) {
      var_0 += 2;
    }
  }
}

function play_mission_complete_vo() {
  play_vo_delay(level, "dx_cps_kama_tug_of_war_mission_complete_10");
  wait 4;
  thread ref_123EF();
  level waittill("player_entered_safehouse_vol");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tug_of_war_complete_debrief_10", "allies");
}

function ref_123EF() {
  level endon("game_ended");
  level endon("smuggler_regrouped");
  level notify("players_go_to_safehouse");
  var_0 = scripts\engine\utility::getStruct("smuggler_safehouse_2_regroup_pos", "targetname");
  var_1 = 1000000;

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby(var_0.origin, var_1)) {
      play_vo_delay(level, "dx_cps_kama_safehouse_return_safehouse_20");
    }

    wait 30;
  }
}

function play_hostage_dead_vo() {
  play_vo_delay(level, "dx_cps_kama_tug_of_war_mission_failure_10");
  wait 1;
}

function ref_123E0() {
  wait 2;
  wait 3.1;
  thread spawn_module_intro3(level);
  wait 7.5;
  thread play_vo_delay(level);
  wait 1.6;
  thread spawn_module_intro3(level);
  wait 14;
  thread play_mission_complete_vo();
}

function spawn_module_intro3(var_0) {
  if(!isDefined(level.hostage_pickup) || !isent(level.hostage_pickup)) {
    if(isDefined(level.playerthrowsmokesignal)) {
      level.playerthrowsmokesignal playsoundonmovingent(var_0);
      return;
    }

    if(isDefined(level.playertimedinvunerable)) {
      level.playertimedinvunerable playsoundonmovingent(var_0);
      return;
    } else {
      return;
    }
  }

  if(!soundexists(var_0)) {
    return;
  }

  level.hostage_pickup playsoundonmovingent(var_0);
}