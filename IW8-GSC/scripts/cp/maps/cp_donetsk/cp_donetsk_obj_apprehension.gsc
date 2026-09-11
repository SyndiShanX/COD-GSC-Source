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
  var0 = &scripts\cp\cp_objectives::registerobjective;
  [[var0]]("obj_tug_of_war", &obj_maj_intro_init, &obj_maj_intro_start, &obj_maj_intro_end, &debugbeatobjective, &debug_start_apprehension);
  [[var0]]("obj_apprehension", &obj_maj_approach_init, &obj_maj_approach_start, &obj_maj_approach_end, &debugbeatobjective);
  [[var0]]("obj_grab_informant", &obj_maj_grab_init, &obj_maj_grab_start, &obj_maj_grab_end, &debugbeatobjective);
  [[var0]]("obj_rescue_informant", &obj_maj_rescue_init, &obj_maj_rescue_start, &obj_maj_rescue_end, &debugbeatobjective);
  [[var0]]("obj_defend_informant", &obj_maj_defend_init, &obj_maj_defend_start, &obj_maj_defend_end, &debugbeatobjective);
  [[var0]]("obj_extract_informant", &obj_maj_extract_init, &obj_maj_extract_start, &obj_maj_extract_end, &debugbeatobjective);
  [[var0]]("obj_extract_players", &obj_maj_exit_init, &obj_maj_exit_start, &obj_maj_exit_end, &debugbeatobjective);
  [[var0]]("obj_informant_bledout");
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_intro_init(var0) {
  if(!scripts\engine\utility::flag_exist("cp_tugofwar_north_create_script_completed") || !scripts\engine\utility::flag("cp_tugofwar_north_create_script_completed")) {
    scripts\engine\utility::flag_set("cp_tugofwar_north_create_script");
    scripts\engine\utility::flag_wait("cp_tugofwar_north_create_script_completed");
    return;
  }
}

function obj_maj_intro_start(var0) {
  foreach(var2 in getaiarray("axis")) {
    var2.dont_kill_off = 0;
    var2.never_kill_off = 0;
  }

  wait 1;
  level.initlocationcircle = "obj_apprehension_1";
  level.initlethalmaxoffsetmap = "obj_apprehension_1";
  level.ref_139b5 = 1;
  thread ref_131f0();
}

function minigun_shots_per_round() {
  level endon("game_ended");
  wait 5;
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("cache_2b", ["deployable_cover", "ammo_crate"]);
}

function obj_maj_intro_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_apprehension", "primary", "allies");
}

function obj_maj_approach_init(var0) {
  scripts\engine\utility::flag_init("tugofwar_hvt_spawned");
  scripts\engine\utility::flag_init("allow_convoy_roaming");
  thread spawn_intro_soldiers();
  thread spawn_hvt_in_building();
  thread spawn_atvs();
  thread ref_135e1(level);
  thread first_bleedout();
  thread ref_131e9();
  scripts\cp\cp_objectives::reset_objective_timers();
  level notify("players_looking_for_informant");

  if(!isDefined(level.hostage_pickup)) {
    level waittill("hostage_spawned");
    return;
  }
}

function obj_maj_approach_start(var0) {
  var1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_APPREHENSION");
  objective_setlocation(var0.objectiveindex, 0, var1.origin);
  objective_sethot(var0.objectiveindex, 0);
  level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, level.hostage_pickup.origin);
  wait_player_near(level, level.hostage_pickup.origin, 6500, 0);
  scripts\engine\utility::flag_wait("tugofwar_hvt_spawned");
  objective_unsetlocation(var0.objectiveindex, 0);
  thread convoy_start();
  thread ref_1240b();
  thread allow_player_mantles();
}

function obj_maj_approach_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_grab_informant", "primary", "allies");
}

function obj_maj_grab_init(var0) {}

function obj_maj_grab_start(var0) {
  level endon("stop_grab_obj");
  var1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_INFORMANT_ATTEMPT_WORLD");
  objective_setlocation(var0.objectiveindex, 0, var1.origin);
  objective_sethot(var0.objectiveindex, 0);
  objective_addalltomask(var0.objectiveindex);
  objective_showtoplayersinmask(var0.objectiveindex);
  thread hvt_wait_for_pickup();
  thread play_waitfor_ai_drop_vo(level);
  thread player_grabs_hostage(level);
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "smugg_p2_intro");
  var2 = 30;
  wait var2;
}

function obj_maj_grab_end(var0) {
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

function obj_maj_rescue_init(var0) {
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_rescue_hostage");
}

function obj_maj_rescue_start(var0) {
  level.hostage_pickup scripts\engine\utility::ref_143a5("player_picked_up_hostage", "dropped");
}

function obj_maj_rescue_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_defend_informant", "primary", "allies");
}

function obj_maj_defend_init(var0) {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("escalation_juggs_01");
  level thread scripts\cp\cp_convoy_manager::compromise_center_truck();
}

function obj_maj_defend_start(var0) {
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var0.objectiveindex, 0);
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_EXTRACT");
  objective_addalltomask(var0.objectiveindex);
  objective_hidefromplayersinmask(var0.objectiveindex);
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_LABEL");
  scripts\cp\utility::ref_123fe("");
  thread kill_rate_watcher();
  thread location_objective_remover();
  thread allow_hvt_stealing_by_ai();
  thread ref_12411();
  thread first_convoy_lmgs();
  var1 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");
  var2 = getvehicleplayerhorn(var1);
  var3 = [];

  for(var4 = 0;; var4++) {
    jumpiffalse(var4 < var2.size) LOC_00000138;
    var5 = "obj_tugofwar_hvt_exfil_" + var2[var4].script_noteworthy;
    var6 = scripts\cp\cp_objectives::requestworldid(var5, 15);
    onexplode(var6);
    objective_position(var6, var2[var4].origin);
    thread wait_for_hvt_near_exfil(level, var2[var4]);
    var2[var4].ref_11f64 = var6;
    var3 = var6;
  }

  level waittill("hvt_near_exfil", var7, var8);
  thread ref_1354d(level);

  for(var4 = 0; var4 < var2.size; var4++) {
    if(var2[var4].script_noteworthy != var7) {
      objective_state(var2[var4].ref_11f64, "done");
      scripts\cp\cp_objectives::freeworldidbyobjid(var2[var4].ref_11f64);
      var2[var4].ref_11f64 = undefined;
      continue;
    }

    level.tugofwar_exfil_location = var2[var4];
  }

  thread getthirdpersonrangeforsize(level, level.tugofwar_exfil_location.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, level.tugofwar_exfil_location.origin);
  thread wait_for_hvt_near_exfil(level, level.tugofwar_exfil_location);
  level waittill("hvt_near_exfil", var7, var8);
  scripts\cp\utility::ref_123fe("");

  if(isDefined(level.hostage_pickup) && isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier)) {
    level.hostage_pickup notify("watchNewDrop");
    level.hostage_pickup.carrier thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SMUGGLER/OBJ_INFORMANT_DROP", 4);
  }

  foreach(var10 in var2) {
    if(isDefined(var10.ref_11f64)) {
      objective_state(var10.ref_11f64, "done");
      scripts\cp\cp_objectives::freeworldidbyobjid(var10.ref_11f64);
    }
  }
}

function onexplode(var0) {
  objective_setplayintro(var0, 1);
  objective_setplayoutro(var0, 1);
  objective_state(var0, "current");
  scripts\cp\cp_objectives::ref_11f80(var0);
  objective_icon(var0, "icon_waypoint_objective_general");
  objective_sethot(var0, 0);
  objective_setlabel(var0, &"CP_SMUGGLER/OBJ_EXTRACT");
  objective_addalltomask(var0);
  objective_showtoplayersinmask(var0);
}

function getvehicleplayerhorn(var0) {
  var1 = [];
  var2 = "c";
  var0 = sortbydistance(var0, level.hostage_pickup.origin);

  if(var0[0].script_noteworthy != var2) {
    var0 = scripts\engine\utility::array_remove(var0, var0[0]);
    var1 = var0[0];
    var1 = var0[1];
    thread ref_12df1();
    return var1;
  }

  var0 = scripts\engine\utility::array_remove(var0, var0[1]);
  var1 = var0[0];
  var1 = var0[1];
  return var1;
}

function ref_12df1() {
  if(!isDefined(level.ref_11f78)) {
    level thread scripts\cp\cp_wave_spawning::killstreaks(8, "smugg_p2_openexfil");
    level.ref_11f78 = 1;
    return;
  }
}

function ref_1354d(var0) {
  var1 = undefined;
  var2 = undefined;

  switch (var0) {
    case "a":
      var1 = "techo_phys_tow6";
      var2 = "techo_phys_tow13";
      break;
    case "b":
      var1 = "techo_phys_tow3";
      var2 = "techo_phys_tow10";
      break;
    case "c":
      var1 = "techo_phys_tow2";
      var2 = "techo_phys_tow9";
      break;
    case "d":
      var1 = "techo_phys_tow4";
      var2 = "techo_phys_tow11";
      break;
    case "e":
      var1 = "techo_phys_tow1";
      var2 = "techo_phys_tow8";
      break;
    case "f":
      var1 = "techo_phys_tow5";
      var2 = "techo_phys_tow12";
      break;
    case "g":
      var1 = "techo_phys_tow7";
      var2 = "techo_phys_tow14";
      break;
  }

  thread ref_12dd5(level);

  if(isDefined(var2)) {
    thread ref_12dd5(level);
    return;
  }
}

function ref_12dd5(var0) {
  var1 = scripts\cp\cp_modular_spawning::run_spawn_module(var0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var0);

  if(isDefined(var1.module_vehicles[0]) && isent(var1.module_vehicles[0])) {
    var2 = var1.module_vehicles[0];
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

function getthirdpersonrangeforsize(var0, var1) {
  if(var1 == "c") {
    return;
  }

  var2 = scripts\engine\utility::getStructArray("exfil_spot_tank", "targetname");
  var2 = sortbydistance(var2, var0);
  var3 = [var2[0], var2[1], var2[2]];
  var4 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var3);
  thread playerhandlesandboxmenu();
  thread ref_135ed(level);
  thread ref_12df1();
}

function ref_135ed(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(!isDefined(var1)) {
    var1 = 450;
  }

  var2 = spawnStruct();
  var3 = spawnStruct();
  var2.origin = var0.origin;
  var2.angles = var0.angles;
  var2.spawntype = "GAME_MODE";
  var2.owner = undefined;
  var2.team = "axis";
  var2.faceawayfromowner = 0;
  var2.cancapture = 0;
  var2.cancaptureimmediately = 0;
  var2.activateimmediately = 1;
  var2.cantimeout = 0;
  var2.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var2);
  var2.spawnmethod = "airdrop_at_position_unsafe";
  var4 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var2, var3);

  if(!isDefined(var4)) {
    return;
  }

  level.ref_13e36 = var4;
  wait 6.5;
  thread tank_waittill_death();
  var4 endon("death");
  var4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var4.headicon, 8000);
  var5 = scripts\cp_mp\vehicles\vehicle::ref_14192(var4, "tur_bradley_mp");
  var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var4, "tur_gun_lighttank_mp");
  var5 notsolid();
  var6 notsolid();
  wait 5;

  for(;;) {
    var7 = var4 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var7)) {
      wait 1;
      continue;
    }

    if(istrue(var7.binvehicle) && isDefined(var7.vehicle)) {
      if(var5 turretcantarget(var7.vehicle.origin + (0, 0, 50))) {
        var5 settargetentity(var7.vehicle);
      }

      if(var6 turretcantarget(var7.vehicle.origin + (0, 0, 50))) {
        var6 settargetentity(var7.vehicle);
      }
    } else {
      ref_130f2(var5, var7, 9, var1);
      var6 settargetentity(var7);
    }

    thread tank_shoot_at_target(var4, var6);
    thread tank_shoot_at_target(var4);
    wait randomfloatrange(0.5, 1.5);
  }
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  if(isDefined(level.ref_13e36)) {
    level.ref_13e36 = undefined;
    return;
  }
}

function tank_shoot_at_target(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("death");
  var3 = 0.1;
  var4 = 1;
  var5 = 0;

  if(!isDefined(var2)) {
    var2 = 2;
  }

  if(istrue(var1)) {
    var4 = randomintrange(15, 25);
    var5 = 1;
  }

  for(var6 = 0; var6 < var4; var6++) {
    var0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var5;
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var1) && isPlayer(var1)) {
      var1.lasthitmarkertime = undefined;
      var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_130f2(var0, var1, var2) {
  if(isPlayer(var0) && isDefined(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == var0) {
    self settargetentity(var0);
    return;
  }

  if(!isDefined(var2)) {
    var2 = 20;
  }

  var3 = randomfloatrange(var2 * -1, var2);
  var4 = randomfloatrange(var2 * -1, var2);
  var5 = randomfloatrange(var2 * -1, var2);
  self settargetentity(var0, (var3, var4, var5));
}

function first_convoy_lmgs() {
  var0 = getEntArray("building_roof_trig", "targetname");

  foreach(var2 in var0) {
    thread first_interaction();
  }

  level waittill("building_roof_chopper_reenforce_spawn");
  var4 = 10;
  var5 = undefined;
  var6 = undefined;

  if(isDefined(level.spawn_module_intro)) {
    var5 = level.spawn_module_intro.max_size;
    var6 = level.spawn_module_intro.min_size;
    level.spawn_module_intro.max_size = var4;
    level.spawn_module_intro.min_size = var4;
  }

  ref_143a0(18);
  level.ref_13593 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_building1");
  level waittill("building_roof_chopper_reenforce_spawn");
  ref_143a0(18);
  level.ref_13594 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_building2");

  foreach(var2 in var0) {
    var2 delete();
  }

  if(isDefined(level.spawn_module_intro) && isDefined(var6) && isDefined(var5)) {
    level.spawn_module_intro.max_size = var5;
    level.spawn_module_intro.min_size = var6;
    return;
  }
}

function ref_143a0(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = 0;
    var2 = 0;

    if(!isDefined(level.agentarray)) {
      break;
    }

    foreach(var4 in level.agentarray) {
      if(isDefined(var4.isactive) && var4.isactive) {
        var1++;
      }

      if(isDefined(var4.never_kill_off) && var4.never_kill_off) {
        var2++;
      }
    }

    if(var1 < var0) {
      break;
    }

    wait 1;
  }
}

function first_interaction() {
  self endon("death");

  for(;;) {
    for(;;) {
      self waittill("trigger", var0);

      if(!var0 scripts\cp\utility::is_valid_player()) {
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
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_reinforcements");
}

function obj_maj_defend_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_extract_informant", "primary", "allies");
  level notify("obj_extract_informant_started");
}

function obj_maj_extract_init(var0) {
  thread allow_hvt_stealing_by_ai();
}

function obj_maj_extract_start(var0) {
  var1 = scripts\engine\utility::getStruct("obj_apprehension_1", "targetname");
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlocation(var0.objectiveindex, 0, level.tugofwar_exfil_location.origin);
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/DROPINFORMANT");
  objective_addalltomask(var0.objectiveindex);
  objective_showtoplayersinmask(var0.objectiveindex);
  thread handle_hvt_go_outside(level);
  ref_1240f(level);

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
  level.ref_13e34 = 1;
  thread ref_12401();
  objective_setlabel(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/ATTACH_FULTON_WORLD");
  objective_setlocation(var0.objectiveindex, 0, level.hostage_pickup.origin + (0, 0, 96));
  level notify("hvt_ready_to_fulton");
  level.hostage_pickup.body hudoutlinedisable();
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(0);
  level thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  level thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  level thread scripts\cp\cp_convoy_manager::set_despawn_distance(4000);
  level.hostage_pickup_pos = level.hostage_pickup.origin;
  thread ref_1356d();
  wait 1;
  little_bird_mg_deletenextframe();
  thread thread_hostage_fulton_anims(level);
  wait 0.1;
  little_bird_mg_deletenextframe();
  wait 0.1;
  little_bird_mg_deletenextframe();
  level waittill("fulton_hostage", var2, var3);
  objective_unsetlocation(var0.objectiveindex, 0);
  objective_addteamtomask(var0.objectiveindex, "spectator");
  ref_123e0(level);
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(6);
  wait 6;
  scripts\cp\cp_objectives::screenent_c("major_objective");
}

function ref_1356d() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");
  var1 = scripts\engine\utility::getclosest(level.hostage_pickup.origin, var0);
  var2 = spawn("script_model", var1.origin - (0, 0, 256));
  var2 setModel("military_skyhook_parachute");
  var2 notsolid();
  level waittill("players_go_to_safehouse");

  if(isent(var2)) {
    var2 delete();
    return;
  }
}

function obj_maj_extract_end(var0) {
  if(isDefined(level.ref_13e36)) {
    level.ref_13e36 dodamage(level.ref_13e36.health + 100, level.ref_13e36.origin);
  }

  thread nag_player_remind_lore_vo();
  thread ref_12dec();
  scripts\cp\cp_objectives::overridenextstep(var0, "safehouse_return");
}

function obj_maj_exit_init(var0) {
  level notify("end_wave_tugofwar_spawners");
}

function obj_maj_exit_start(var0) {
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_extract_struct_apprehend");
  waitframe();
  level notify("call_exfil", level.hostage_pickup_pos);
  level waittill("ready_to_exfil");
  wait 4;
}

function obj_maj_exit_end(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    level.players[var1].ability_invulnerable = 1;
  }

  wait 3;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function allow_player_mantles() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0].disable_hvt_nomantle = 1;
  }
}

function location_objective_remover() {
  level endon("game_ended");
  level endon("obj_tugofwar_delete_hostage");
  level.hostage_pickup endon("tugofwar_hvt_death");
  var0 = 250000;
  var1 = level.hostage_pickup.origin;

  while(distance2dsquared(level.hostage_pickup.origin, var1) < var0) {
    wait 1;
  }

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(istrue(level.players[var2].disable_hvt_nomantle)) {
      level.players[var2].disable_hvt_nomantle = undefined;

      if(isDefined(level.hostage_pickup.carrier) && isPlayer(level.hostage_pickup.carrier) && level.hostage_pickup.carrier == level.players[var2]) {
        level.players[var2] scripts\common\utility::allow_jump(0);
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
  var0 = 10;
  wait var0;
  level notify("convoy_pickup_go_hvt");
}

function player_grabs_hostage(var0) {
  level endon("stop_grab_obj");
  level waittill("player_picked_up_hostage");
  level.hostage_pickup.pickedupbyplayer = 1;
  level notify("stop_intro_vo");
  thread players_pickedup_hvt(level);
}

function players_pickedup_hvt(var0) {
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

function binoculars_onstatemarkedenter(var0) {
  level.ref_11f7a = var0;
}

function spawn_hvt_waypoint() {
  if(!isDefined(level.hostage_pickup.waypoint)) {
    var0 = &scripts\cp\cp_pickup_hostage::create_objective;
    level.hostage_pickup.nowaypoint = undefined;
    level.hostage_pickup.waypoint = level.hostage_pickup[[var0]](level.hostage_pickup.origin + (0, 0, 30), "icon_waypoint_marker");
    objective_onentity(level.hostage_pickup.waypoint, level.hostage_pickup);
    objective_setzoffset(level.hostage_pickup.waypoint, 32);
    level.hostage_pickup.attach_entity = level.hostage_pickup;
    return;
  }
}

function spawn_hvt_in_building() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var0 = scripts\engine\utility::getStructArray("hvt_spawner_tugofwar", "script_noteworthy");
  var1 = scripts\engine\utility::random(var0);
  var0 = scripts\engine\utility::array_remove(var0, var1);
  level.obj_hvt_spawn_struct = var1;
  thread inithvtmodel(level);
  scripts\engine\utility::flag_set("tugofwar_hvt_spawned");
}

function inithvtmodel(var0) {
  var1 = "smuggler_informant_fullbody";
  var2 = &scripts\cp\cp_pickup_hostage::initdefaulthvtmodel;
  level.hostage_pickup = [[var2]](var0, var1, undefined, &"CP_SMUGGLER/PICKUP_INFORMANT", "drop_informant", 0, "hostage_mage");
  level.hostage_pickup.nowaypoint = 1;
  level.hostage_pickup.label = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";

  if(!isDefined(level.hostage_pickup.interaction_handle)) {
    level.hostage_pickup waittill("hvt_interaction_updated");
  }

  level.hostage_pickup.sethotfunc = &hvtent_sethotfunc;
  thread players_holding_hvt_handler();
  level notify("hostage_spawned");
}

function wait_player_near(var0, var1, var2) {
  level endon("game_ended");
  var3 = cos(65);
  var4 = 230;

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = var4 * var4;

  for(;;) {
    wait 0.25;

    if(istrue(var2)) {
      var6 = scripts\cp\utility::any_player_nearby(var0, var5);

      if(!var6) {
        continue;
      }

      for(var7 = 0; var7 < level.players.size; var7++) {
        var8 = sighttracepassed(var0, level.players[var7] getEye(), 0, level.players[var7]);

        if(var8) {
          var9 = scripts\engine\utility::within_fov(level.players[var7].origin, level.players[var7].angles, var0 + (0, 0, 40), var3);

          if(var9) {
            return;
          }
        }
      }

      continue;
    }

    if(scripts\cp\utility::any_player_nearby(var0, var5)) {
      return;
    }
  }
}

function healthdraining_ui_set() {
  level endon("game_ended");

  for(;;) {
    self waittill("decreased_life");
    var0 = int(self.life_left * 100);
    level thread scripts\cp\utility::objective_update("obj_informant_ui", undefined, undefined, undefined, 1, var0, 2);
  }
}

function hvtent_sethotfunc(var0, var1) {
  self notify("sethotfunc");
  self endon("sethotfunc");
  self endon("freedobjective");
  level endon("tugofwar_hvt_placed");

  while(!isDefined(self.waypoint)) {
    wait 1;
  }

  var2 = 90000;
  objective_setshowprogress(self.waypoint, 1);

  if(!isDefined(self.life_left)) {
    thread healthdraining_ui_set();
    self.life_left = 1;
    objective_setprogress(self.waypoint, 1);
    level.ref_11f7a = 2.5;
  }

  if(self.life_left <= 0.01) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(istrue(var0)) {
    objective_sethot(self.waypoint, 1);

    for(;;) {
      if(isDefined(self.carrier) && isPlayer(self.carrier)) {
        break;
      }

      if(!isDefined(self) || !isDefined(self.life_left)) {
        break;
      }

      if(spawnglobalscriptabledelayed(var2)) {
        self.life_left -= 0.01 * var1;
        self notify("decreased_life");

        if(self.life_left <= 0.01) {
          thread hvt_death();
          return;
        } else {
          objective_setprogress(self.waypoint, self.life_left);
        }

        if(self.life_left % 0.05 == 0 && self.life_left > 0) {
          var3 = int(self.life_left * 100);
          thread set_hvt_label_life(level);
        }
      }

      wait level.ref_11f7a;
    }

    return;
  }

  objective_sethot(self.waypoint, 0);
}

function spawnglobalscriptabledelayed(var0) {
  if(isDefined(level.tugofwar_exfil_location)) {
    if(distancesquared(self.origin, level.tugofwar_exfil_location.origin) > var0) {
      return 1;
    }

    self setuseholdduration("duration_long");
    return 0;
  }

  return 1;
}

function wait_for_hvt_near_exfil(var0, var1) {
  level endon("game_ended");
  level endon("hvt_near_exfil");
  var2 = 300;
  var3 = var0.script_noteworthy;

  if(var1 == "far") {
    var4 = distance(level.hostage_pickup.origin, var0.origin);
    var5 = var4 * 0.75;

    if(var2 < var5) {
      var2 = var5;
    }
  }

  var6 = var2 * var2;

  for(;;) {
    wait 0.25;

    if(distancesquared(level.hostage_pickup.origin, var0.origin) < var6) {
      break;
    }
  }

  level notify("hvt_near_exfil", var3, var1);
}

function set_hvt_label_life(var0) {
  var1 = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";

  switch (var0) {
    case 100:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_100";
      break;
    case 95:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_95";
      break;
    case 90:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_90";
      break;
    case 85:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_85";
      break;
    case 80:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_80";
      break;
    case 75:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_75";
      break;
    case 70:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_70";
      break;
    case 65:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_65";
      break;
    case 60:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_60";
      break;
    case 55:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_55";
      break;
    case 50:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_50";
      thread play_lost_health_vo();
      break;
    case 45:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_45";
      break;
    case 40:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_40";
      break;
    case 35:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_35";
      break;
    case 30:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_30";
      break;
    case 25:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_25";
      break;
    case 20:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_20";
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SMUGGLER/OBJ_RESCUE_INFORMANT", "allies", 4);
      break;
    case 15:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_15";
      break;
    case 10:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_10";
      break;
    case 5:
      var1 = &"CP_SMUGGLER/INFORMANT_HP_05";
      break;
    case 0:
      var1 = &"CP_SMUGGLER/OBJ_INFORMANT_LABEL";
      break;
  }

  if(isDefined(var1)) {
    level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(var1, 1);
    return;
  }
}

function hvt_death() {
  level notify("tugofwar_hvt_death");
  level.ref_11f62 = 1;
  thread set_hvt_label_life(level);
  play_hostage_dead_vo(level);
  scripts\cp\cp_objectives::ref_12868("obj_informant_bledout");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function handle_hvt_go_outside(var0) {
  level endon("game_ended");
  var0 endon("delete");
  level endon("fulton_hostage");

  if(!isDefined(var0.hostage_drop_override_data)) {
    var0.hostage_drop_override_data = spawnStruct();
  }

  var1 = "";

  for(;;) {
    wait 0.1;

    if(istrue(var0.carried_by_vehicle)) {
      if(var1 == "fail") {
        continue;
      }

      var1 = "fail";
      var0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_EXTRACT_WORLD");
      var0.can_fulton = 0;

      if(!isDefined(var0.hostage_drop_override_data)) {
        var0.hostage_drop_override_data = spawnStruct();
      }

      var0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(!passed_all_sky_traces(var0)) {
      if(var1 == "fail") {
        continue;
      }

      var1 = "fail";
      var0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_OUTSIDE");
      var0.can_fulton = 0;

      if(!isDefined(var0.hostage_drop_override_data)) {
        var0.hostage_drop_override_data = spawnStruct();
      }

      var0.hostage_drop_override_data.preventuse = 0;
      continue;
    }

    if(var1 == "pass") {
      continue;
    }

    var1 = "pass";
    var0 scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_EXTRACT_WORLD");
    var0.can_fulton = 1;

    if(!isDefined(var0.hostage_drop_override_data)) {
      var0.hostage_drop_override_data = spawnStruct();
    }

    var0.hostage_drop_override_data.preventuse = 1;
    var0.hostage_drop_override_data.waittime = 3;
  }
}

function passed_all_sky_traces(var0) {
  var1 = 0;
  var1 = pos_passes_sky_trace(var0.origin);

  if(var1 == 0) {
    return 0;
  }

  var1 = pos_passes_sky_trace(var0.origin, (500, 0, 3000));

  if(var1 == 0) {
    return 0;
  }

  var1 = pos_passes_sky_trace(var0.origin, (-500, 0, 3000));

  if(var1 == 0) {
    return 0;
  }

  var1 = pos_passes_sky_trace(var0.origin, (0, 500, 3000));

  if(var1 == 0) {
    return 0;
  }

  var1 = pos_passes_sky_trace(var0.origin, (0, -500, 3000));
  return var1;
}

function pos_passes_sky_trace(var0, var1) {
  var2 = (0, 0, 3000);

  if(isDefined(var1)) {
    var2 = var1;
  }

  var3 = var0;
  var4 = var0 + var2;

  if(var4[2] <= var3[2]) {
    return 0;
  }

  var5 = scripts\engine\trace::_bullet_trace_passed(var3, var4, 0, undefined);
  return var5;
}

function convoy_start() {
  if(!isDefined(level.hostage_pickup)) {
    level waittill("hostage_spawned");
  }

  level.convoy_speed_override = 30;
  var0 = scripts\engine\utility::getStruct("convoy_start_north1", "targetname");
  var1 = "small-roaming-stealing";
  var2 = "the_convoy";
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var2, var1, var0, undefined, undefined, undefined);

  if(!isDefined(var4)) {
    return;
  }

  thread convoy_init_settings(level);
  wait 0.1;
  thread convoy_think_handler(level);
  wait 3;
  level notify("allow_convoy_soldiers_target");
}

function convoy_init_settings(var0) {
  var0 thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  var0 thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  var0 thread scripts\cp\cp_convoy_manager::set_hide_icon_on_pickup_target(0);
  var0 thread scripts\cp\cp_convoy_manager::set_convoy_targeted_hvt(level.hostage_pickup);
  var0 thread scripts\cp\cp_convoy_manager::ref_130ed(1);
  var0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_pickup(0);
  var0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_convoy_death(0);
  var0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_nearby_convoy(0);
  var0 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_rescued(0);
  var0 thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1);
  var0 thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
  var0 thread scripts\cp\cp_convoy_manager::set_recruiting_amount(8);
  var0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_btwn(3);
  var0 thread scripts\cp\cp_convoy_manager::set_soldier_backup_deposit_names("hvi_runto_locations");
  var0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var0 thread scripts\cp\cp_convoy_manager::set_can_compromise_before_1st_target(0);
  var0 thread scripts\cp\cp_convoy_manager::ref_130fe("backseats");
  var0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_vehicles(0);
  var0 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_support_vehicles(0);
  var0 thread scripts\cp\cp_convoy_manager::allow_routing_to_any_vehicles(1);
  var0 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(0);
  var0 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  thread play_truck_anim(var0);
  var0.convoy_paths_override = "smuggler_convoy_paths";
}

function convoy_think_handler(var0) {
  level endon("game_ended");
  var1 = 0;
  var0 thread scripts\cp\cp_convoy_manager::set_convoy_target(level.hostage_pickup, undefined, undefined);
  var0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(1);
  var0 thread scripts\cp\cp_convoy_manager::set_stop_all_cars(0);

  if(!istrue(var1)) {
    wait 10;
  }

  var0 thread scripts\cp\cp_convoy_manager::set_recruiting_distance(4000);
  var0 thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(12);
  var0 thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(1000);
  var0 thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(0);

  if(getdvarint("scr_disable_vehiclehack", 0) == 0) {
    foreach(var3 in var0.spawned_vehicles) {
      thread temp_vehicle_manuallysetspeed();
    }
  }

  if(!istrue(var0.allowed_to_exit)) {
    var0 waittill("convoy_exiting_after_pickup");
  }

  if(!isDefined(var0)) {
    return;
  }

  var0 scripts\cp\cp_convoy_manager::set_convoy_durations_modifier(425);
  level notify("obj_set_roaming");
  var0 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  var0 thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-1000);
  var0 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var0 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  thread play_convoy_hostage_save_vo();
  thread hudnumconsumed(var0);
  var0.main_truck vehicleshowonminimap(1);
  var0.main_truck aiupdatecoverexposetype(1);
  thread setup_waves_truck_section();
  var0 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var0 thread scripts\cp\cp_convoy_manager::set_compromise_megahealth(1);
  thread convoy_damaged_tires(level);
  var5 = scripts\cp\utility::getvehiclearray();
  var6 = [];

  for(var7 = 0; var7 < var5.size; var7++) {
    if(isDefined(var5[var7].team) && var5[var7].team == "allies") {
      var6 = var5[var7];
    }
  }

  var0 waittill("convoy_compromised");
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

function hudnumconsumed(var0) {
  var0 endon("convoy_compromised");
  var0 endon("convoy_center_death");
  var1 = var0.main_truck;

  if(!isDefined(var1)) {
    return;
  }

  var2 = 22500;

  while(isalive(var1)) {
    var3 = var1.origin;
    wait 5;
    var4 = var1.origin;

    if(distancesquared(var4, var3) < var2) {
      var0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
    }
  }
}

function hvt_wait_for_pickup() {
  level.hostage_pickup scripts\engine\utility::ref_143a5("convoy_pickedup_hvt", "player_picked_up_hostage");
  spawn_hvt_waypoint(level);
  level.hostage_pickup scripts\cp\cp_pickup_hostage::set_hvt_label(&"CP_SMUGGLER/OBJ_INFORMANT_LABEL");
}

function convoy_damaged_tires(var0) {
  var1 = 0;

  for(;;) {
    if(var1 >= 3) {
      break;
    }

    var0 waittill("vehicle_lost_wheel");
    var1 += 1;
  }

  wait 1.5;
  var0 thread scripts\cp\cp_convoy_manager::compromise_center_truck();
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
  var0 = getEntArray("building_magic_grenade", "targetname");

  foreach(var2 in var0) {
    thread firing_start_locs();
  }
}

function firing_start_locs() {
  self endon("death");
  var0 = getEnt(self.target, "targetname");
  jumpiffalse(isDefined(var0)) LOC_00000023;
  thread firestation_jugg_test(var0);

  for(;;) {
    self waittill("trigger", var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  if(isDefined(var0)) {
    var0 delete();
  }

  var2 = scripts\engine\utility::getStruct(self.target, "targetname");
  var3 = "frag";

  if(isDefined(var2.script_noteworthy)) {
    var3 = var2.script_noteworthy;
  }

  var4 = 1000;

  if(isDefined(var2.script_grenadespeed)) {
    var4 = int(var2.script_grenadespeed);
  }

  var5 = vectorNormalize(anglesToForward(var2.angles));
  var6 = var5 * var4;

  if(isDefined(var2.script_timer)) {
    var7 = float(var2.script_timer);
    var8 = magicgrenademanual("frag_grenade_mp", var2.origin, var6, var7);
  } else {
    var8 = magicgrenademanual("frag_grenade_mp", var3.origin, var8, 2.25);
  }

  if(isDefined(var8)) {
    thread firestation_jugg_spawn(var8);
    return;
  }
}

function firestation_jugg_spawn(var0) {
  var0 endon("trigger");
  var0 waittill("explode", var1);
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  if(var2.size > 0) {
    var3 = scripts\engine\utility::getclosest(var1, var2);
    var3 radiusdamage(var1, 256, 140, 70, var3, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
    return;
  }

  radiusdamage(var1, 256, 140, 70, undefined, "MOD_GRENADE_SPLASH", getcompleteweaponname("frag_grenade_mp"));
}

function firestation_jugg_test(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  if(isDefined(var0)) {
    wait 0.05;
    var0 delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function ref_131e9() {
  var0 = scripts\engine\utility::getStructArray("enemy_sentry", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    thread ref_131ea(var2);
  }
}

function ref_131ea(var0) {
  var1 = "sentry_turret";
  var2 = level.sentrysettings[var1];
  var3 = spawnturret("misc_turret", var0.origin, level.sentrysettings[var1].weaponinfo);
  var3.team = "axis";

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var3.angles = var0.angles;
  var3.health = var2.maxhealth;
  var3.maxhealth = var2.maxhealth;
  var3.sentrytype = var1;
  var3.momentum = 0;
  var3.heatlevel = 0;
  var3.overheated = 0;
  var3.cooldownwaittime = 2;
  var3.turrettype = "sentry_turret";
  var3 setModel("weapon_wm_mg_sentry_turret");
  var3 setturretteam("axis");
  var3 makeunusable();
  var3 setnodeploy(1);
  var3 setdefaultdroppitch(0);
  var3 setautorotationdelay(0.2);
  var3 maketurretinoperable();
  var3 setleftarc(80);
  var3 setrightarc(80);
  var3 setbottomarc(50);
  var3 settoparc(60);
  var3 setconvergencetime(0.6, "pitch");
  var3 setconvergencetime(0.6, "yaw");
  var3 setconvergenceheightpercent(0.65);
  var3 setdefaultdroppitch(-89);
  var3 setturretmodechangewait(1);
  var3 solid();
  var3 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var3 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  var3 scripts\cp_mp\emp_debuff::allow_emp(0);
  wait 1;
  var3 setmode("auto_nonai");
  var3 scripts\cp_mp\emp_debuff::allow_emp(1);
  sentryturret_empupdate(var3);
  var3 thread scripts\mp\carriable::is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  var3 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var3;
}

function sentryturret_empstarted(var0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var0) {
  if(var0) {
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
  var0 = self.origin;
  var1 = 0.05;
  var2 = int(var1 * 20);

  for(;;) {
    wait var1;
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
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = level.sentrysettings[self.sentrytype].burstmin;
  var2 = level.sentrysettings[self.sentrytype].burstmax;
  var3 = level.sentrysettings[self.sentrytype].pausemin;
  var4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var5 = randomintrange(var1, var2 + 1);

    for(var6 = 0; var6 < var5 && !self.overheated; var6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var0;
      wait var0;
    }

    wait randomfloatrange(var3, var4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function sentry_heatmonitor() {
  self endon("death");
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = 0;
  var2 = 0;
  var3 = level.sentrysettings[self.sentrytype].overheattime;
  var4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var1) {
      wait var0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var1 = self.heatlevel;
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

function play_truck_anim(var0) {
  while(!isDefined(var0.main_truck)) {
    wait 0.1;
  }

  wait 0.1;
  var1 = var0.main_truck;
  thread truck_waittill_death();
  var2 = (-80, 0, 82);
  var3 = &scripts\cp\cp_vehicles::spawn_ai_in_truck;
  level thread[[var3]](var1, 1, undefined, 0, undefined, "juggernaut", var2, 1, &ref_144aa);
  var1 endon("death");
  var4 = level.scr_anim["tugofwar_truck"]["truck_hatchopen"];
  var5 = level.scr_anim["tugofwar_truck"]["truck_clear"];

  while(isent(var1)) {
    var1 vehicleplayanim(var5);
    waitframe();
    var1 vehicleplayanim(var4);
    wait 20;
  }
}

function truck_waittill_death() {
  level endon("game_ended");
  self waittill("death");
  var0 = scripts\cp\utility::get_closest_living_player();
  wait 1;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "flavor_positive", undefined, 1);
}

function setup_trafficking_soldier_anims(var0, var1) {
  level endon("convoy_exiting_after_pickup");
  self waittill("tugofwar_playanim");
  thread anim_trafficking_soldier_play();
}

function anim_trafficking_soldier_play() {
  self endon("death");
  var0 = level.all_convoys["the_convoy"].main_truck;
  var1 = (0, 0, 0);
  var2 = (-185, 18, -64);
  var3 = rotatevector(var2, var0.angles);
  var4 = var0 gettagorigin("tag_accessory_01") + var3;
  var5 = getstartorigin(var0.origin, var0.angles, level.scr_anim["tugofwar_soldier"]["place_hvt_into_truck"]);

  if(isent(var0)) {
    var1 = var0.angles;
  }

  level.hostage_pickup.body hide();
  self hide();
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self.og_health = self.health;
  self.og_maxhealth = self.maxhealth;
  self.maxhealth = 99999;
  self.health = 99999;
  var6 = spawn("script_model", self.origin);
  var6 setModel(self.model);
  var6.angles = self.angles;
  var6.animname = "place_hvt_into_truck";
  var6 useanimtree(level.scr_animtree["tugofwar_soldier"]);
  var6.head = spawn("script_model", self.origin);
  var6.head setModel(self.headmodel);

  if(var6.model == "body_spetsnaz_cqc") {
    var6.head linkTo(var6, "j_neck", (-8, 1, 0), (0, 0, 0));
  } else {
    var6.head linkTo(var6, "j_neck", (-21, 1, 0), (0, 0, 0));
  }

  var7 = spawn("script_model", level.hostage_pickup.origin);
  var7 setModel(level.hostage_pickup.bodymodel);
  var7.angles = level.hostage_pickup.angles;
  var7.animname = "place_hvt_into_truck";
  var7 useanimtree(level.scr_animtree["tugofwar_informant"]);
  var8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var6, "tugofwar_soldier");
  var8 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var9 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var7, "tugofwar_informant");
  var9 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var10 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  thread scripts\cp\utility::drawsphere(var10.origin, 5, 9999, (0, 1, 1));
  thread buildweapon_blueprint();
  thread bunker_initinteraction(level, var10, var8);
  wait 11;
  level.hostage_pickup.body show();
  var10 scripts\cp_mp\anim_scene::anim_scene_stop(1);
  var6.head delete();
  reset_guy(self, var5, var1);
  wait 1;
  var6 delete();
  var7 delete();
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

function anim_trafficking_play_scene_soldier(var0, var1) {
  var0 scripts\cp_mp\anim_scene::anim_scene([var1], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function anim_trafficking_play_scene_informant(var0, var1) {
  var0 scripts\cp_mp\anim_scene::anim_scene([var1], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function bunker_initinteraction(var0, var1, var2) {
  var0 scripts\cp_mp\anim_scene::anim_scene([var1, var2], "place_hvt_into_truck", undefined, undefined, undefined, 0, 0);
}

function reset_guy(var0, var1, var2) {
  var0 allowedstances("prone", "stand", "crouch");
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 setlookatentity();
  var0 setCanDamage(1);
  var0.headlook_enabled = 1;
  var0.disableautolookat = 0;
  var0.deathstate = undefined;
  var0.deathalias = undefined;
  var0.ignoreall = 0;
  var0.origin = getclosestpointonnavmesh(var1);
  var0.angles = var2;
  var0.health = int(min(var0.og_health, 400));
  var0.maxhealth = int(min(var0.og_maxhealth, 400));
  var0 show();

  if(istrue(var0.never_kill_off)) {
    var0.never_kill_off = 0;
    return;
  }
}

function register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("cp_tugofwar_north_create_script_completed") || !scripts\engine\utility::flag("cp_tugofwar_north_create_script_completed")) {
    scripts\engine\utility::flag_set("cp_tugofwar_north_create_script");
    scripts\engine\utility::flag_wait("cp_tugofwar_north_create_script_completed");
  }

  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  var1 = 18;
  [[var0]]("building_guards", var1, var1, var1, 0.1, 0, "building_guards", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards", undefined, 10000, 20000);
  [[var0]]("building_guards_important", 1, 1, 1, 0.1, 0, "building_guards_important", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards_important", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards_important", undefined, 20000, 30000);
  [[var0]]("building_guards_important_jugg", 1, 1, 1, 0.1, 0, "building_guards_important_jugg", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards_important", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_guards_important", undefined, 20000, 30000);
  [[var0]]("building_snipers", 2, 2, 2, 8, 0, "building_snipers", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_snipers", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_snipers", undefined, 20000, 30000);
  [[var0]]("building_rpg", 2, 2, 2, 12, 0, "building_rpg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_rpg", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("building_rpg", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_building1", 4, 4, 4, 0.1, 0, "lbravo_spawner_building1", undefined, undefined, undefined);
  [[var0]]("lbravo_spawner_building2", 4, 4, 4, 0.1, 0, "lbravo_spawner_building2", undefined, undefined, undefined);
  [[var0]]("escalation_juggs_01", 0, 1, 250, 20, 0, "escalation_juggs_01", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy_soldiers", 0, 10, 250, 20, 0, "convoy_soldiers", &watchforstopwaves, undefined, undefined);
  [[var0]]("tugofwar_exfil_hvt", 1, 1, 1, 0.1, 0, "tugofwar_exfil_hvt", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tugofwar_exfil_hvt", &setup_hostage_fulton_anims);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("tugofwar_exfil_hvt", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_safehouse1", 4, 4, 4, 0.1, 0, "lbravo_spawner_safehouse1", undefined, undefined, undefined);
  [[var0]]("lbravo_spawner_safehouse2", 4, 4, 4, 0.1, 0, "lbravo_spawner_safehouse2", undefined, undefined, undefined);
  [[var0]]("techo_phys_tow1", 6, 6, 6, 0.1, 0, "techo_phys_tow1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow1", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow2", 6, 6, 6, 0.1, 0, "techo_phys_tow2", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow2", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow3", 6, 6, 6, 0.1, 0, "techo_phys_tow3", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow3", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow4", 6, 6, 6, 0.1, 0, "techo_phys_tow4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow4", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow5", 6, 6, 6, 0.1, 0, "techo_phys_tow5", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow5", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow6", 6, 6, 6, 0.1, 0, "techo_phys_tow6", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow6", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow7", 6, 6, 6, 0.1, 0, "techo_phys_tow7", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow7", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow8", 6, 6, 6, 0.1, 0, "techo_phys_tow8", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow8", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow9", 6, 6, 6, 0.1, 0, "techo_phys_tow9", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow9", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow10", 6, 6, 6, 0.1, 0, "techo_phys_tow10", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow10", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow11", 6, 6, 6, 0.1, 0, "techo_phys_tow11", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow11", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow12", 6, 6, 6, 0.1, 0, "techo_phys_tow12", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow12", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow13", 6, 6, 6, 0.1, 0, "techo_phys_tow13", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow13", &playerhumanconcusspush);
  [[var0]]("techo_phys_tow14", 6, 6, 6, 0.1, 0, "techo_phys_tow14", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_phys_tow14", &playerhumanconcusspush);
  targets_killed();
}

function targets_killed(var0) {
  var1 = getEntArray("spawn_trigger", "targetname");

  foreach(var3 in var1) {
    thread targetoverride(var3);
  }
}

function targetoverride(var0) {
  var1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var2 = var1.size;
  scripts\cp\cp_modular_spawning::registerambientgroup(self.target, var2, var2, var2, 0.1, undefined, self.target);
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
        scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, &ref_12d86);
        break;
    }
  }

  thread trigger_spawn(var0);
  thread ref_13db0();
}

function ref_13db0() {
  var0 = getEntArray(self.target, "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2) && isDefined(var2.classname) && issubstr(var2.classname, "trigger")) {
      thread ref_13db1(var2);
    }
  }
}

function ref_13db1(var0) {
  level endon("game_ended");
  self endon("death");
  var0 endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var0 scripts\engine\utility::delaycall(0.1, &delete);
  self delete();
}

function trigger_spawn(var0) {
  level endon("game_ended");
  self endon("stop_spawning");
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var1 isparachuting() || var1 isskydiving()) {
      continue;
    }

    break;
  }

  var2 = self.target;
  var3 = scripts\cp\cp_modular_spawning::run_spawn_module(var2);
  self delete();
}

function first_move(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var2 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var2)) {
      var3 = 600;

      if(isDefined(var2.radius)) {
        var3 = var2.radius;
      }

      thread first_pressure_switch_triggered(var2, var3);
      return;
    }

    return;
  }
}

function watch_for_player_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isPlayer(var1)) {
      self.ref_132b8 = 1;
      return;
    }
  }
}

function first_pressure_switch_triggered(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self.combat_func_active = 1;
  var2 = 5;
  var3 = var2;
  thread watch_for_player_damage();

  while(isDefined(var0)) {
    if(var3 <= 0) {
      scripts\cp\cp_modular_spawning::set_goal_radius(var1);
      scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
      var3 = var2;
    }

    var4 = 300;

    if(scripts\cp\utility::any_player_nearby(var0.origin, var4 * var4)) {
      break;
    }

    var5 = 500;

    if(buystationtrig(self.origin, var5 * var5, 128)) {
      break;
    }

    var6 = scripts\engine\utility::getStruct("building_roof_jugg_zone", "targetname");
    var7 = 1100;
    var8 = 500;

    if(!buystationtrig(var6.origin, var7 * var7, var8)) {
      break;
    }

    if(istrue(self.ref_132b8)) {
      break;
    }

    var3--;
    wait 1;
  }

  self.combat_func_active = undefined;

  for(;;) {
    var9 = randomintrange(4, 7);
    var10 = int(var9 * 20);
    var11 = scripts\cp\utility::get_closest_living_player(16000000);

    if(isDefined(var11)) {
      scripts\cp\cp_modular_spawning::set_goal_radius(500);
      scripts\cp\cp_modular_spawning::set_goal_pos(var11.origin);
    }

    wait var9;
  }
}

function buystationtrig(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 64;
  }

  foreach(var4 in level.players) {
    if(distancesquared(var4.origin, var0) < var1) {
      if(abs(var4.origin[2] - var0[2]) < var2) {
        return true;
      }
    }
  }

  return false;
}

function broadcast_carry_items(var0, var1) {
  self endon("death");
  wait 0.5;
  var2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var2)) {
    self getenemyinfo(var2);
    self setgoalpos(var2.origin);
    return;
  }
}

function ref_12d86(var0, var1) {
  self endon("death");
  wait 0.5;
  var2 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var2);
}

function playergetspectatingplayer(var0, var1) {
  self endon("death");
  self.sightmaxdistance = 2200;
  self.is_on_platform = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var2 = 500;
  var3 = 500;

  for(;;) {
    jumpiftrue(istrue(self.entered_combat)) LOC_00000043;
    waitframe();
  }

  for(;;) {
    var4 = 0;

    foreach(var6 in level.players) {
      if(!var6 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distancesquared(var6.origin, self.origin) < var2 * var2) {
        var4 = 1;
      }

      wait 0.5;
    }

    if(var4) {
      break;
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var3);
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

function setup_manual_goalpos(var0, var1) {
  thread setup_trafficking_soldier_anims(var0, var1);
  var2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var2);

  switch (var0.group_name) {
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
      thread ref_144aa();
      self.script_origin_other = self.origin;
      break;
    case "building_guards_important_jugg":
      self.dontkilloff = 1;
      self.never_kill_off = 1;
      self.ignoreall = 1;
      thread ref_144aa(600);
      break;
    default:
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
  }
}

function playerhumanconcusspush(var0, var1) {
  self.grenadeweapon = getcompleteweaponname("iw8_thermite_mp");
  self.grenadeammo = 2;
}

function ref_144aa(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = 810000;

  if(isDefined(var0)) {
    var1 = var0 * var0;
  }

  for(;;) {
    wait 0.3;

    if(scripts\cp\utility::any_player_nearby(self.origin, var1)) {
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

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("end_wave_tugofwar_spawners");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function stopwaveandstartthisone(var0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var0]]();
}

function players_holding_hvt_handler() {
  level endon("game_ended");
  level endon("hvt_ready_to_fulton");

  for(;;) {
    level.hostage_pickup waittill("player_picked_up_hostage", var0);

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addclienttomask(level.hostage_pickup.waypoint, var0);
      objective_hidefromplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc)) {
        level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](0);
      }
    }

    if(isDefined(level.hostage_pickup.body)) {
      level.hostage_pickup.body hudoutlineenable("outline_nodepth_green");
    }

    var1 = level.hostage_pickup scripts\engine\utility::ref_143ad("dropped", "placed_into_player_vehicle");

    if(isDefined(level.hostage_pickup.waypoint)) {
      objective_addalltomask(level.hostage_pickup.waypoint);
      objective_showtoplayersinmask(level.hostage_pickup.waypoint);

      if(isDefined(level.hostage_pickup.sethotfunc)) {
        if(isDefined(var1) && var1 == "dropped") {
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1);
          thread allow_hvt_stealing_by_ai();
          level.hostage_pickup.interaction_handle sethintdisplayfov(120);
          level.hostage_pickup.interaction_handle sethintdisplayrange(220);
          level.hostage_pickup.interaction_handle setuserange(120);
        } else if(isDefined(var1) && var1 == "placed_into_player_vehicle") {
          level.hostage_pickup thread[[level.hostage_pickup.sethotfunc]](1, 0.5);
        }
      }
    }

    if(isDefined(level.hostage_pickup.body)) {
      level.hostage_pickup.body hudoutlinedisable();
    }
  }
}

function setup_hostage_fulton_anims(var0, var1) {
  self.maxhealth = 99999;
  self.health = 99999;
  level.obj_tugofwar_civ_hvt = self;
}

function ref_13b34() {
  level endon("game_ended");
  level endon("hvt_stop_idle");
  var0 = 4;

  for(;;) {
    self stopuseanimtree();
    self scriptmodelclearanim();
    self scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
    wait var0;
  }
}

function thread_hostage_fulton_anims(var0) {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level.hostage_pickup.interaction_handle makeunusable();
  little_bird_mg_deletenextframe();
  level notify("obj_tugofwar_delete_hostage");
  level.playertimedinvunerable = spawn("script_model", level.hostage_pickup_pos);
  level.playertimedinvunerable.angles = var0.angles;
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
  thread ref_13b34();
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
  var0 = level.hostage_pickup.origin;
  var1 = 0;
  var2 = 1000;
  var3 = 1700;
  var4 = 4;
  var5 = undefined;

  for(;;) {
    if(!isDefined(level.hostage_pickup)) {
      return;
    }

    var5 = var4;
    var1 = distance2d(level.hostage_pickup.origin, var0);

    if(var1 > var2) {
      var6 = var1 / var2;
      var5 *= var6;
    }

    if(var1 < var3) {
      level thread scripts\cp\cp_escalation::increase_escalation_counter();
    }

    wait var5;
  }
}

function suicide_bomber_combat_func() {
  self endon("death");
  var0 = get_closet_alive_player(self);
  self getenemyinfo(var0);

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

function get_closet_alive_player(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    var1 = var3;
  }

  return scripts\engine\utility::getclosest(var0.origin, var1);
}

function spawn_atvs() {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var0 = scripts\engine\utility::getStructArray("tugofwar_atv_spawn", "targetname");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var0, 1);
}

function ref_135e1(var0) {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.tacrovers)) {
    level.tacrovers = [];
  }

  var1 = scripts\engine\utility::getStructArray(var0, "targetname");
  level thread scripts\cp\vehicles\tac_rover_cp::tac_rover_cp_createfromstructs(var1, 1);
}

function ref_131f0() {
  scripts\cp\utility::skydivestreamhintdvars("tugofwar");
}

function play_vo_delay(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies", var3, var5, var6);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(isDefined(var2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var2);
    return;
  }
}

function vo_length(var0) {
  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  return var1;
}

function ref_12dec() {
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
  level.ref_12e5c = scripts\engine\utility::getStruct("safehouse_struct", "targetname");
  var0 = scripts\engine\utility::getStructArray("ending_mortar_launcher", "targetname");
  var1 = spawn("script_model", scripts\engine\utility::random(var0).origin);
  var1 setModel("misc_wm_mortar");
  var2 = 1;
  var3 = 4;
  var4 = 7;
  var5 = 0.5;
  var6 = 1;
  var7 = 1000;
  var8 = 300;
  var9 = 6;

  while(var7 > 0) {
    var10 = quarry_intro1_chopper(var9, var2, var8);

    foreach(var12 in var10) {
      var13 = scripts\engine\utility::random(var0).origin;
      var14 = 2600;
      var1 thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::launch_mortar(var13, var12, undefined, var14);
      wait randomfloatrange(var5, var6);
    }

    if(var2 > 0 || trial_turrets_killed()) {
      wait var3;
    } else {
      wait randomfloatrange(var3, var4);
    }

    var7--;
    var2--;
  }
}

function trial_turrets_killed() {
  var0 = getEnt("smuggler_safehouse_2_volume", "targetname");
  var1 = scripts\mp\vehicles\vehicle_damage_mp::ref_11f27(var0);
  return var1 > 0;
}

function quarry_intro1_chopper(var0, var1, var2) {
  var3 = [];

  if(isDefined(var1) && var1 > 0) {
    var2 *= 4;
  }

  foreach(var5 in level.players) {
    if(isDefined(var5) && isalive(var5) && !scripts\cp\cp_laststand::player_in_laststand(var5) && !var5 isspectatingplayer()) {
      if(istrue(var5.bspawningviaac130)) {
        continue;
      }

      if(scripts\engine\utility::distance_2d_squared(var5.origin, level.ref_12e5c.origin) < int(level.ref_12e5c.radius) * int(level.ref_12e5c.radius)) {
        continue;
      }

      var6 = 1;

      if(scripts\engine\utility::cointoss()) {
        var6++;
      }

      for(var7 = 0; var7 < var6; var7++) {
        var3 = race_ui_critical_message_timer(var5.origin, var2);
      }
    }
  }

  if(var3.size < var0) {
    var9 = var0 - var3.size;
    var10 = scripts\engine\utility::getStructArray("obj_tugofwar_hvt_exfil", "targetname");

    for(var7 = 0; var7 < var9; var7++) {
      var11 = scripts\engine\utility::random(var10);
      var12 = var11.origin;

      if(isDefined(level.hostage_pickup_pos)) {
        var12 = level.hostage_pickup_pos;
      }

      var3 = race_ui_critical_message_update(var12, level.ref_12e5c.origin);
    }
  }

  return var3;
}

function race_ui_critical_message_update(var0, var1) {
  var2 = randomfloatrange(0.5, 0.85);
  var3 = vectorlerp(var0, var1, var2);
  var4 = scripts\engine\utility::drop_to_ground(var3, 500, -1000);

  if(!isDefined(var4)) {
    var4 = var3;
  }

  if(var0[2] > var1[2]) {
    var5 = var1[2];
    var6 = var0[2];
  } else {
    var5 = var2[2];
    var6 = var3[2];
  }

  var6 = (var6[0], var6[1], clamp(var6[2], var5, var6));
  return var6;
}

function race_ui_critical_message_timer(var0, var1) {
  var2 = randomfloatrange(var1 / -2, var1 / 2);
  var3 = randomfloatrange(var1 / -2, var1 / 2);
  var4 = (var2, var3, 0);
  var5 = scripts\engine\utility::drop_to_ground(var0 + var4, 500, -1000);

  if(!isDefined(var5)) {
    var5 = var0 + var4;
  }

  return var5;
}

function debug_start_apprehension(var0) {
  thread threaded_start_tugofwar();
}

function threaded_start_tugofwar() {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "apprehension_debug_start_loc", 1);
  level waittill("spawned_player_car");
  var0 = scripts\engine\utility::getStruct("apprehension_humvee_start", "targetname");
  scripts\cp\maps\cp_br_syrk\vehicle_travel::teleport_humvee_to_struct(var0);
}

function ref_1240b() {
  var0 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  play_vo_delay(level, "dx_cps_lass_tug_of_war_brief_10");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "ping_response_affirm");
  thread ref_12410();

  if(!isDefined(level.all_convoys["the_convoy"].main_truck)) {
    level waittill("new_convoy_spawned");
  }

  thread ref_123c0();
}

function ref_12410() {
  level.hostage_pickup endon("convoy_pickedup_hvt");
  var0 = 40000;

  while(!scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var0)) {
    wait 0.2;
  }

  level notify("tugofwar_vo_saw_hvt");
  thread spawn_module_intro3(level);
  var1 = level.hostage_pickup scripts\cp\utility::get_closest_living_player();
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var1, "obj_visual");
  play_vo_delay(level, "dx_cps_lass_tug_of_war_found_informant_hotel_20");
}

function ref_123c0() {
  var0 = level.all_convoys["the_convoy"].main_truck;

  if(!isDefined(var0)) {
    return;
  }

  level.all_convoys["the_convoy"] endon("convoy_compromised");
  level.all_convoys["the_convoy"] endon("convoy_center_death");
  var1 = 90000;

  while(distance2dsquared(level.hostage_pickup.origin, var0.origin) > var1) {
    wait 0.2;
  }

  thread play_vo_delay(level);
}

function ref_12411() {
  if(istrue(level.ref_13e35)) {
    return;
  }

  level.ref_13e35 = 1;
  thread spawn_module_intro3(level);
  thread play_vo_delay(level);
  wait 15;
  level.ref_139b5 = 0;
}

function play_convoy_hostage_save_vo() {
  scripts\engine\utility::flag_init("tugofwar_vo_playing_disabled");
  var0 = 1;
  wait var0;
  thread play_player_follow_truck();
  wait 6 - var0;

  if(istrue(level.hostage_pickup.pickedupbyplayer)) {
    return;
  }

  if(!istrue(level.hostage_pickup.convoy_pickedup)) {
    return;
  }

  thread play_vo_delay(level, "dx_cps_lass_tug_of_war_convoy_leaving_10", undefined);
  thread ref_123fa();
}

function ref_123fa() {
  level.hostage_pickup endon("player_picked_up_hostage");
  level.hostage_pickup endon("tugofwar_hvt_death");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_cps_lass_tug_of_war_nag_convoy_10");
}

function ref_12400() {
  var0 = 4000000;
  var1 = 10;

  if(scripts\cp\utility::any_player_nearby(level.hostage_pickup.origin, var0)) {
    if(isDefined(level.spawn_ml_p2_sentries) && gettime() > level.spawn_ml_p2_sentries + var1 || !isDefined(level.spawn_ml_p2_sentries)) {
      var2 = [];
      GscBinSkip0(0x2e, var2.size, "dx_cps_infr_tug_of_war_informant_pickup_10");
    }

    return;
  }
}

function play_player_follow_truck() {
  self endon("death");
  var0 = scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_target_moving");
  wait 11;

  if(isDefined(self)) {
    var0 = scripts\cp\utility::get_closest_living_player();
  }

  if(isDefined(var0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "flavor_hurryup");
    return;
  }
}

function play_lost_health_vo() {}

function play_waitfor_ai_drop_vo(var0) {
  level endon("game_ended");
  level endon("hvt_ready_to_fulton");

  if(istrue(level.vo_played_waitforaidrop)) {
    return;
  }

  level.vo_played_waitforaidrop = 1;
  var0 waittill("convoy_pickedup_hvt");
  var0 waittill("player_picked_up_hostage");
  wait 2;
  thread ref_12411();

  for(;;) {
    var0 waittill("convoy_pickedup_hvt");
    var1 = ["dx_cps_infr_tug_of_war_informant_grabbed_10", "dx_cps_infr_tug_of_war_informant_grabbed_20", "dx_cps_infr_tug_of_war_informant_grabbed_30"];
    var2 = scripts\engine\utility::random(var1);
    thread spawn_module_intro3(level);
    wait randomfloatrange(1, 2);
    var3 = ["dx_cps_lass_tug_of_war_informant_grabbed_overlord_10", "dx_cps_kama_tug_of_war_informant_grabbed_overlord_20", "dx_cps_kama_tug_of_war_informant_grabbed_overlord_30"];
    var4 = scripts\engine\utility::random(var3);
    play_vo_delay(level, var4);
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

function ref_1240f() {
  var0 = level.hostage_pickup.carrier;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "obj_package");
  play_vo_delay(level, "dx_cps_lass_tug_of_war_informant_extraction_10");
  wait 1;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "ping_response_affirm");
  thread ref_12402();
}

function ref_12402() {
  level endon("game_ended");
  level endon("tugofwar_hvt_placed");
  wait 3;

  if(istrue(level.ref_13e34)) {
    return;
  }

  var0 = 20;
  var1 = ["dx_cps_lass_tug_of_war_nag_extraction_10", "dx_cps_lass_tug_of_war_nag_extraction_20"];

  for(;;) {
    play_vo_delay(level, scripts\engine\utility::random(var1));
    wait randomfloatrange(10, var0);

    if(var0 < 50) {
      var0 += 2;
    }
  }
}

function ref_12401() {
  level endon("game_ended");
  level endon("fulton_hostage");
  var0 = 20;
  var1 = ["dx_cps_kama_tug_of_war_nag_fulton_prep_10", "dx_cps_kama_tug_of_war_nag_fulton_prep_20"];

  for(;;) {
    play_vo_delay(level, scripts\engine\utility::random(var1));
    wait randomfloatrange(10, var0);

    if(var0 < 50) {
      var0 += 2;
    }
  }
}

function play_mission_complete_vo() {
  play_vo_delay(level, "dx_cps_kama_tug_of_war_mission_complete_10");
  wait 4;
  thread ref_123ef();
  level waittill("player_entered_safehouse_vol");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tug_of_war_complete_debrief_10", "allies");
}

function ref_123ef() {
  level endon("game_ended");
  level endon("smuggler_regrouped");
  level notify("players_go_to_safehouse");
  var0 = scripts\engine\utility::getStruct("smuggler_safehouse_2_regroup_pos", "targetname");
  var1 = 1000000;

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby(var0.origin, var1)) {
      play_vo_delay(level, "dx_cps_kama_safehouse_return_safehouse_20");
    }

    wait 30;
  }
}

function play_hostage_dead_vo() {
  play_vo_delay(level, "dx_cps_kama_tug_of_war_mission_failure_10");
  wait 1;
}

function ref_123e0() {
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

function spawn_module_intro3(var0) {
  if(!isDefined(level.hostage_pickup) || !isent(level.hostage_pickup)) {
    if(isDefined(level.playerthrowsmokesignal)) {
      level.playerthrowsmokesignal playsoundonmovingent(var0);
      return;
    }

    if(isDefined(level.playertimedinvunerable)) {
      level.playertimedinvunerable playsoundonmovingent(var0);
      return;
    } else {
      return;
    }
  }

  if(!soundexists(var0)) {
    return;
  }

  level.hostage_pickup playsoundonmovingent(var0);
}