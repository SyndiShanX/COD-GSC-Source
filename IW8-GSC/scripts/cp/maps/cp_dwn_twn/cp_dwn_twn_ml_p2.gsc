/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p2.gsc
***********************************************************/

function main() {
  level.mlp2_obj_func = &register_objectives;
  level.teamnamelist = ["axis", "allies"];
  scripts\engine\utility::flag_init("station_reached");
  scripts\engine\utility::flag_init("dwn_twn_mlp2_register_spawn_modules_done");
  scripts\engine\utility::flag_init("players_at_station");
  scripts\engine\utility::flag_init("ml_p2_doors_init");
  scripts\engine\utility::flag_init("ml_p2_heli_in_air");
  scripts\engine\utility::flag_init("station_second_floor");
  scripts\engine\utility::flag_init("ml_p2_done");
  scripts\engine\utility::flag_init("truck_stopped");
  scripts\engine\utility::flag_init("convoy_destroyed");
  scripts\engine\utility::flag_init("fronttruck_stopped");
  scripts\engine\utility::flag_init("convoy_escaped");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo", "truck", "script_vehicle_iw8_truck_techo_white");
}

function obj_default_init(var_0, var_1) {
  if(isDefined(level.getoverridedvarexceptmatchrulesvalues)) {
    if(level.getoverridedvarexceptmatchrulesvalues == var_0.objname) {
      scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

      if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
        scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
      }

      scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
      scripts\engine\utility::flag_wait("dwn_twn_mlp2_register_spawn_modules_done");
      level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123FD();
      thread mlp2_sh1_trig();
      thread mlp2_sh2_trig();
      thread mlp2_sh3_trig();
      wait 5;
      var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
      wait 10;
      scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
      return;
    }

    return;
  }
}

function obj_default_end(var_0) {}

function obj_default_beat(var_0) {}

function obj_default_start(var_0) {
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123FD();
}

function register_objectives() {
  if(!istrue(level.ml_p2_objectives_registered)) {
    level.ml_p2_objectives_registered = 1;
  } else {
    return;
  }

  thread register_spawn_modules();
  thread ref_13592();
  init_anims();
  scripts\cp\cp_objectives::registerobjective("ml_p2_get_heli", &obj_default_init, &ml_p2_get_heli_start, &obj_default_end, &obj_default_beat, &mlp2_mnu_start);
  scripts\cp\cp_objectives::registerobjective("ml_p2_follow_contact", &obj_default_init, &mlp2_2_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ml_p2_secure_loc", &obj_default_init, &mlp2_3_start, &obj_default_end, &obj_default_beat, &mlp2_3_mnu_start);
  scripts\cp\cp_objectives::registerobjective("ml_p2_interrogate", &obj_default_init, &ml_p2_interrogate, &obj_default_end, &obj_default_beat, &debug_ml_p2_interrogate_start);
  scripts\cp\cp_objectives::registerobjective("ml_p2_fail_killed_convoy", undefined, &ref_11C5A, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("ml_p2_fail_lost_convoy", undefined, &ref_11C5A, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("ml_p2_observe", &obj_default_init, &mlp2_observe_start, &obj_default_end, &obj_default_beat, &mlp2_debug_start);
  scripts\cp\cp_objectives::registerobjective("ml_p2_call_contact", &obj_default_init, &mlp2_1_start, &obj_default_end, &obj_default_beat, &obj_default_start);
}

function register_spawn_modules() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_heli_spawns", 12, 12, 12, 0.1, undefined, "ml_p2_intro");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_heli_spawns", &mark_never_remove);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_vip_spawns", 3, 3, 3, 0.1, undefined, "mlp2_vip_spawns");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_vip_spawns", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_vip_spawns", &nuke_startexfilcountdown);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_vip_spawns_decoy", 4, 4, 4, 0.1, undefined, "mlp2_vip_spawns_decoy");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_vip_spawns_decoy", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_vip_spawns_decoy", &nuke_startexfilcountdown);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_passenger_group", 12, 12, 12, 0.1, undefined, "mlp2_passenger_group");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_passenger_group", &ref_1294B);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh1", 4, 4, 4, 0.1, undefined, "mlp2_sh1");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh1_2", 1, 1, 1, 0.1, undefined, "mlp2_sh1_2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_2", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_2", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_2", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh1_3", 2, 2, 2, 0.1, undefined, "mlp2_sh1_3");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_3", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_3", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh2", 5, 5, 5, 0.1, undefined, "mlp2_sh2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh2", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh2", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh2", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh3", 3, 3, 3, 0.1, undefined, "mlp2_sh3");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh3", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh3", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh3", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_roof_rpg", 13, 13, 13, 0.1, undefined, "mlp2_roof_rpg");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_roof_rpg", &shoot_at_heli);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_roof_rpg", &mark_never_remove);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_sh1_rpg", 3, 3, 3, 0.1, undefined, "mlp2_sh1_rpg");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_rpg", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_rpg", &shoot_at_heli_station);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_sh1_rpg", &converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("mlp2_interrogate_spawn", 1, 1, 1, 0.1, undefined, "mlp2_interrogate_spawn");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mlp2_interrogate_spawn", &setup_interrogate);
  scripts\engine\utility::flag_set("dwn_twn_mlp2_register_spawn_modules_done");
  thread create_stair_doors();
}

function spawn_in_cover(var_0) {
  if(istrue(self.unittype == "juggernaut")) {
    return;
  }

  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "Prone")) {
      if(issubstr(var_1.type, "Left")) {
        var_2 += (0, 90, 0);
      } else if(issubstr(var_1.type, "Right") || issubstr(var_1.type, "Cover Crouch") || issubstr(var_1.type, "Conceal") || issubstr(var_1.type, "Cover Stand")) {
        var_2 -= (0, 90, 0);
      }
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.script_origin_other = var_3;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
    return;
  }
}

function create_stair_doors() {
  wait 5;
  level.ml_p2_doors = [];
  level.ml_p2_doors_clip = [];
  var_0 = ["ml_p2_door"];

  foreach(var_2 in var_0) {
    create_door(var_2);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("ml_p2_doors_init");
}

function create_door(var_0) {
  var_1 = getEntArray("clip64x64x8", "targetname");
  var_2 = var_1[0];
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_4 = var_3[0];

  if(isDefined(var_4)) {
    var_5 = spawn("script_model", var_4.origin);
    var_5.angles = var_4.angles;
    wait 0.1;
    var_5 setModel("door_metal_double_b_l_02_grey");
    var_5.open_ang = (0, 105, 0);
    level.ml_p2_doors[var_0] = var_5;

    if(isDefined(var_2)) {
      var_6 = scripts\engine\utility::getStructArray(var_0 + "_clip", "targetname");
      var_7 = var_6[0];
      var_8 = spawn("script_model", var_7.origin);
      var_8.angles = var_7.angles;
      var_8 clonebrushmodeltoscriptmodel(var_2);
      var_8 disconnectPaths();
      level.ml_p2_doors_clip[var_0] = var_8;
      return;
    }

    return;
  }
}

function connect_ml_p2_doorway_paths() {
  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  var_0 = ["ml_p2_door_clip"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "targetname");

    if(isDefined(var_3)) {
      var_3 connectpaths();
      var_3 notsolid();
    }

    wait 0.1;
  }
}

function open_door(var_0) {
  var_1 = level.ml_p2_doors[var_0];
  var_2 = level.ml_p2_doors_clip[var_0];
  var_1 rotateTo(var_1.angles + var_1.open_ang, 0.25);

  if(isDefined(var_2)) {
    var_2 connectpaths();
    var_2 notsolid();
    return;
  }
}

function mlp2_mnu_start(var_0) {
  wait 5;
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123FD();
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");

  while(!isDefined(level.players) || level.players.size < 1) {
    wait 0.1;
  }

  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_12118();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "ml_p2_player_start");
}

function mlp2_3_mnu_start(var_0) {
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  scripts\engine\utility::flag_wait("dwn_twn_mlp2_register_spawn_modules_done");
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123FD();
  wait 5;
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
  thread mlp2_sh1_trig();
  thread mlp2_sh2_trig();
  thread mlp2_sh3_trig();
  wait 10;
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "mlp2_3_start");
}

function mlp2_observe_start(var_0) {
  var_1 = scripts\engine\utility::getStructArray("mlp2_observe", "targetname");
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, var_1[0].origin);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mlp2_heli_spawns");
  thread ref_13526();
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_call_contact_10");
  wait 1;
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_call_contact");
}

function rear_minigun_attack_min_cooldown(var_0) {
  if(var_0 != "front" && var_0 != "mid" && var_0 != "back") {
    return undefined;
  }

  foreach(var_2 in level.mlp2_vehicles) {
    if(var_2.humanpowersenabled == var_0) {
      return var_2;
    }
  }
}

function nuke_startexfilcountdown(var_0) {
  thread nuke_startmercycountdown();
}

function nuke_startmercycountdown() {
  self endon("death");
  level waittill("contact_called");
  self.group scripts\engine\utility::ent_flag_set("weapons_free");
}

function check_player_prox_in_air() {
  var_0 = scripts\engine\utility::getStructArray("mlp2_start", "targetname");
  var_1 = var_0[0];
  var_2 = 0;

  while(!var_2) {
    foreach(var_4 in level.players) {
      if(distance2d(var_4.origin, var_1.origin) < 4000) {
        var_2 = 1;
      }
    }

    wait 0.1;
  }

  level notify("ml_p2_observe_close_enough");
}

function check_player_prox_on_ground() {
  var_0 = scripts\engine\utility::getStructArray("mlp2_observe_ground", "targetname");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in level.players) {
      foreach(var_5 in var_0) {
        var_6 = var_5.radius * var_5.radius;

        if(distance2dsquared(var_3.origin, var_5.origin) < var_6) {
          var_1 = 1;
        }
      }

      wait 0.25;
    }

    wait 0.1;
  }

  level notify("ml_p2_observe_close_enough");
}

function ref_1294B(var_0) {
  var_1 = self;

  foreach(var_3 in level.mlp2_vehicles) {
    if(!isDefined(var_3)) {
      level.mlp2_vehicles = scripts\engine\utility::array_remove(level.mlp2_vehicles, var_3);
    }
  }

  var_5 = scripts\engine\utility::getclosest(var_1.origin, level.mlp2_vehicles);
  var_1.veh = var_5;
  var_6 = var_5 scripts\common\vehicle_aianim::get_availablepositions();
  var_7 = [];

  if(var_6.availablepositions.size > 1) {
    for(var_8 = 0; var_8 < var_6.availablepositions.size; var_8++) {
      if(istrue(var_6.availablepositions[var_8].canshootinvehicle)) {
        var_7 = var_6.availablepositions[var_8];
      }
    }
  } else {
    return;
  }

  if(!isDefined(var_5.driver)) {
    var_9 = var_5 scripts\common\vehicle_aianim::choose_vehicle_position(var_1, var_6, 0);
  } else if(var_8.size > 0) {
    var_9 = var_8[0];
  } else {
    var_9 = var_7 scripts\common\vehicle_aianim::choose_vehicle_position(var_3, var_8, 0);
  }

  var_3.forced_startingposition = var_9.vehicle_position;
  var_7.usedpositions[var_9.vehicle_position] = 1;
  var_3 scripts\vehicle\vehicle_common::entervehicle(var_7, 1, var_9, scripts\common\vehicle_aianim::anim_pos(var_7, var_3.forced_startingposition));
  var_7.attachedguys[var_7.attachedguys.size] = var_3;
  var_7.riders[var_7.riders.size] = var_3;
  var_3.vehicle_position = var_3.forced_startingposition;
  var_3.ref_1376B = var_3.health;
  var_3.health = 500;

  if(var_3.forced_startingposition == 0) {
    var_7.driver = var_3;
    var_3.health = 1000;
    return;
  }
}

function build_truck_path(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;
  var_1 = var_2.origin;

  for(var_3 = 0; isDefined(var_2) && isDefined(var_2.target); var_3++) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_1 = var_2.origin;

    if(var_1.size > 30) {
      self.struct_node_path_array[var_3] = var_1;
      var_1 = [];
      var_1 = var_2.origin;
    }
  }

  self.struct_node_path_array[var_3] = var_1;
}

function build_truck_duration(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;
  var_3 = 15;

  for(var_4 = 0; isDefined(var_2) && isDefined(var_2.target); var_4++) {
    var_5 = var_2;
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_6 = scripts\cp\cp_vehicles::get_duration_between_points(var_5.origin, var_2.origin, var_3, 1);
    var_1 = var_6;

    if(isDefined(var_2.speed) && var_2.speed > 0) {
      var_3 = var_2.speed;
    }

    if(var_1.size > 29) {
      var_1 = 4;
      self.struct_node_path_duration_array[var_4] = var_1;
      var_1 = [];
    }
  }

  var_1 = 4;
  self.struct_node_path_duration_array[var_4] = var_1;
}

function ml_p2_get_heli_start(var_0) {
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  scripts\engine\utility::flag_wait("dwn_twn_mlp2_register_spawn_modules_done");
  level.initlethalmaxoffsetmap = "ml_p2_get_heli";
  scripts\mp\brclientmatchdata::getprophealth("ml_p1");
  scripts\cp\crate_drops\cp_crate_drops::ref_12C40("ml_p2");

  if(!isDefined(level.player_heli)) {
    ref_13591();
  }

  var_1 = scripts\engine\utility::getStruct("ml_p2_heli", "targetname");

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  thread propwhistletime();
  thread keep_heli_in_place(level, var_1.origin);
  level.initlethalmaxoffsetmap = "vault_assault";
  level.initlocationcircle = "vault_assault";
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, var_1.origin);
  var_2 = scripts\engine\utility::getStructArray("fake_clip", "targetname");

  foreach(var_4 in var_2) {
    [var_6] = getEntArray("clip512x512x8", "targetname");

    if(isDefined(var_6)) {
      var_7 = spawn("script_model", var_4.origin);
      var_7.angles = var_4.angles;
      var_7 clonebrushmodeltoscriptmodel(var_6);
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(level.player_heli);
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_heli_spawns");

  while(level.player_heli.occupants.size == 0) {
    wait 0.1;
  }

  level.ref_124B7 = 1;
  thread stop_wave_spawning_once_heli_leaves();
  thread spawn_rpg_guys_when_in_heli();
  level.player_heli scripts\engine\utility::ref_143A5("ml_p2_heli_takeoff", "death");

  if(isDefined(level.player_heli)) {
    level.player_heli.invulnerable = undefined;
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mlp2_heli_spawns");
  thread vfx_flare(["mlp2_passenger_group", "mlp2_roof_rpg"]);
  thread lootleadermarkweakvalue();
  thread ref_13526();
  wait_for_players_to_call();
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_follow_contact");
}

function ref_13591() {
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  var_0 = scripts\engine\utility::getStruct("ml_p2_heli", "targetname");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  level.player_heli = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  level.player_heli setCanDamage(0);
  level.player_heli.invulnerable = 1;
  level.player_heli vehicle_turnengineon();
  level.player_heli.team = "allies";
  level.player_heli.health = 10000;
  level.player_heli.maxhealth = 10000;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(level.player_heli);
}

function ref_13592() {
  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  var_0 = scripts\engine\utility::getStructArray("enemy_sentry_p2", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\carriable::ref_131EA(var_2);
    thread ref_13FB0();
  }
}

function ref_13FB0() {
  wait 1;
  self.matchdata_logaward = 1;
  self setleftarc(170);
  self setrightarc(170);
}

function propwhistletime() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_brief_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_heli_nearby_10");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("ping_response_affirm");
  thread ref_11E1E();
  level.skipburndownmedium = 1;
}

function vfx_flare(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_0) && isarray(var_0) && isDefined(var_3.enemy_group)) {
      var_4 = 0;

      foreach(var_6 in var_0) {
        if(var_3.enemy_group == var_6) {
          var_4 = 1;
        }
      }

      if(!istrue(var_4)) {
        var_3 dodamage(var_3.health + 100, var_3.origin);
      }
    }
  }
}

function lootleadermarkweakvalue() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_stakeout_ambush_get_to_overwatch_10");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_rpg_warning_10");
}

function ref_11E1E() {
  level endon("game_ended");

  while(!istrue(level.ref_124B7)) {
    wait 60;

    if(!istrue(level.ref_124B7)) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_stakeout_ambush_heli_nag_10");
    }
  }
}

function stop_wave_spawning_once_heli_leaves() {
  var_0 = level.player_heli.origin;
  var_1 = 500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    if(isDefined(level.player_heli)) {
      if(distancesquared(var_0, level.player_heli.origin) > var_2) {
        var_3 = 1;
      }
    }

    wait 1;
  }

  level.player_heli notify("ml_p2_heli_takeoff");
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
}

function keep_heli_in_place(var_0, var_1) {
  level endon("player_in_heli");
  var_2 = 50;
  var_3 = var_2 * var_2;

  while(!istrue(level.ref_124B7)) {
    if(distancesquared(level.player_heli.origin, var_0) > var_3) {
      level.player_heli.origin = var_0;
      level.player_heli.angles = var_1;
    }

    wait 0.1;
  }
}

function spawn_rpg_guys_when_in_heli() {
  while(level.player_heli.occupants.size == 0) {
    wait 0.1;
  }

  thread waittill_heli_in_air();
  scripts\engine\utility::flag_wait("ml_p2_heli_in_air");
  level.mlp2_roof_group = scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_roof_rpg");
}

function shoot_at_heli(var_0) {
  thread shoot_at_player_heli(var_0);
}

function shoot_at_player_heli(var_0) {
  self endon("death");
  level.player_heli setCanDamage(1);
  level.player_heli.invulnerable = undefined;
  scripts\engine\utility::flag_wait("ml_p2_heli_in_air");
  self.health = 10;
  var_1 = 500;
  var_2 = var_1 * var_1;
  wait 2;

  for(;;) {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) < var_2) {
        self.ignoreall = 0;
        self clearentitytarget();
        var_3 = 1;
      }
    }

    if(!var_3) {
      if(isDefined(level.player_heli)) {
        if(isDefined(level.player_heli.occupants) && level.player_heli.occupants.size > 0) {
          self.ignoreall = 0;
          self setentitytarget(level.player_heli);
        } else {
          self.ignoreall = 1;
        }
      } else {
        self.ignoreall = 0;
      }
    }

    wait 0.1;
  }
}

function waittill_heli_in_air() {
  var_0 = level.player_heli.origin;
  var_1 = 500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    if(isDefined(level.player_heli)) {
      if(distancesquared(var_0, level.player_heli.origin) > var_2) {
        var_3 = 1;
      }
    }

    wait 1;
  }

  scripts\engine\utility::flag_set("ml_p2_heli_in_air");
}

function shoot_at_heli_station(var_0) {
  thread shoot_at_player_heli_station(var_0);
}

function shoot_at_player_heli_station(var_0) {
  self endon("death");
  level endon("station_second_floor");

  for(;;) {
    if(isDefined(level.player_heli)) {
      if(isDefined(level.player_heli.occupants) && level.player_heli.occupants.size > 0) {
        self.ignoreall = 0;
        self setentitytarget(level.player_heli);
      } else {
        self clearentitytarget();
      }
    } else {
      self clearentitytarget();
    }

    wait 0.1;
  }
}

function converge_on_players(var_0) {
  thread converge_after_flag(var_0);
}

function converge_after_flag(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("station_second_floor");
  self clearentitytarget();

  if(self.origin[2] > -262 || self.origin[2] < -382) {
    self.combat_func_override = "shotgun";
    thread scripts\cp\cp_modular_spawning::shotgunner_combat();
    return;
  }
}

function kill_off_when_station_reached(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait("players_at_station");
  scripts\cp\cp_modular_spawning::script_kill_ai();
}

function mlp2_1_start(var_0) {
  foreach(var_2 in level.players) {
    var_2 forceusehinton(&"CP_DWN_TWN_OBJECTIVES/OBJ_CALL");
  }

  wait_for_players_to_call();
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_follow_contact");
}

function wait_for_players_to_call() {
  var_0 = scripts\engine\utility::getStructArray("mlp2_start", "targetname");
  var_1 = var_0[0];
  var_2 = sortbydistance(level.players, var_1.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(level.player_heli.occupants["pilot"])) {
      if(level.player_heli.occupants["pilot"] == var_2[var_3]) {
        continue;
      }

      continue;
    }

    call_ai_cellphone(var_2[var_3]);
    return;
  }

  call_ai_cellphone(level.players[0]);
}

function mlp2_2_start(var_0) {
  if(isDefined(level.ref_11C63)) {
    thread ref_11CF9(level.ref_11C63);
  }

  scripts\cp\utility::skydivestreamhintdvars("ml_p2");
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_sh1_rpg");
  scripts\engine\utility::flag_set("reinforce_3_ready");
  mark_group_as_killable("mlp2_vip_spawns");
  mark_group_as_killable("mlp2_vip_spawns_decoy");
  thread ref_1444B(20, 4500, 8);
  var_1 = scripts\engine\utility::flag_wait_any_return("players_at_station", "convoy_destroyed", "fronttruck_stopped", "convoy_escaped");

  if(var_1 == "convoy_destroyed" || var_1 == "fronttruck_stopped") {
    scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_fail_killed_convoy");
    level scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_stakeout_ambush_follow_truck_destroyed_10");
    return;
  } else if(var_1 == "convoy_escaped") {
    scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_fail_lost_convoy");
    return;
  }

  scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  thread vfx_flare(["mlp2_passenger_group", "mlp2_sh1", "mlp2_sh1_2", "mlp2_sh1_3", "mlp2_sh2", "mlp2_sh3", "mlp2_sh1_rpg", "mlp2_interrogate_spawn"]);
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_follow_near_goal_10");
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_secure_loc");
  scripts\cp\cp_objectives::freeworldid("convoy_mid");
  scripts\cp\cp_objectives::freeworldid("convoy_back");
}

function ref_11C5A(var_0) {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 5;
  logevent_servermatchstart(var_0);
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function logevent_servermatchstart(var_0) {
  jumpiffalse(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[var_0.objname])) LOC_000000bc;
  var_1 = level.objectivestabledata[var_0.objname].index;
  var_2 = level.objectivestabledata[var_0.objname].pathexit;

  if(isDefined(var_2) && var_2 != "") {
    foreach(var_4 in level.players) {
      var_4 setclientomnvar("ui_cp_mission_fail_index", var_1);
    }

    return;
  }

  foreach(var_4 in level.players) {
    var_4 setclientomnvar("ui_cp_mission_fail_index", 0);
  }

  return;
}

function ref_1444B(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("players_at_station");
  var_3 = level.ref_11C63;

  if(!isDefined(var_3)) {
    return;
  }

  var_3 endon("final_path_node_reached");
  var_3 endon("death");
  level waittill("convoy_started_moving");
  wait var_0;
  var_4 = 0;
  var_5 = "NA";

  for(;;) {
    if(!truck_airdrop(var_3.origin, var_1)) {
      wait 1;
      var_4++;

      if(var_4 >= var_2) {
        scripts\engine\utility::flag_set("convoy_escaped");
        return;
      }

      if(var_5 != "far") {
        var_5 = "far";
        getbattlepassxpmultiplier("escaping");
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/LBL_ESCAPING", "allies", 2);
      }

      continue;
    }

    if(var_5 != "close") {
      var_5 = "close";
      getbattlepassxpmultiplier("nokill");
    }

    var_4 = 0;
    wait 1;
  }
}

function getbattlepassxpmultiplier(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("ml_p2_follow_contact").objectiveindex;

  switch (var_0) {
    case "nokill":
    default:
      objective_setlabel(var_1, &"CP_DWN_TWN_OBJECTIVES/LBL_DONT_KILL");
      break;
    case "escaping":
      objective_setlabel(var_1, &"CP_DWN_TWN_OBJECTIVES/LBL_ESCAPING");
      break;
  }
}

function truck_airdrop(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(distance2d(var_4.origin, var_0) <= var_1) {
      return true;
    }
  }

  return false;
}

function ref_13A21() {
  var_0 = rear_minigun_attack_min_cooldown("front");
  var_1 = rear_minigun_attack_min_cooldown("mid");
  var_2 = rear_minigun_attack_min_cooldown("back");
  level.playerspawndata = var_0;
  level.ref_11BDF = var_1;
  level.chopper_carepackage_pilot_selected = var_2;
  var_3 = scripts\cp\cp_objectives::requestworldid("convoy_mid");
  var_4 = scripts\cp\cp_objectives::requestworldid("convoy_back");
  var_5 = scripts\cp\cp_objectives::getobjectivestructfromref("ml_p2_follow_contact");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    var_5.objectiveindex = scripts\cp\cp_objectives::requestworldid("convoy_front");
  }

  if(isDefined(var_0)) {
    objective_onentity(var_5.objectiveindex, var_0);
    objective_setzoffset(var_5.objectiveindex, 120);
    objective_setplayintro(var_5.objectiveindex, 1);
    objective_setpings(var_5.objectiveindex, 1);
    objective_setlabel(var_5.objectiveindex, &"CP_DWN_TWN_OBJECTIVES/LBL_DONT_KILL");
    objective_setbackground(var_5.objectiveindex, 1);
    objective_icon(var_5.objectiveindex, "cp_tac_waypoint_dont_shoot");
    objective_sethot(var_5.objectiveindex, 1);
    objective_state(var_5.objectiveindex, "current");
  }

  if(isDefined(var_1)) {
    objective_onentity(var_3, var_1);
    objective_setzoffset(var_3, 120);
    objective_setplayintro(var_3, 0);
    objective_setpings(var_3, 1);
    objective_setlabel(var_3, &"CP_DWN_TWN_OBJECTIVES/LBL_SHOOT");
    objective_setbackground(var_3, 1);
    objective_icon(var_3, "icon_waypoint_objective_general");
    objective_state(var_3, "current");
  }

  if(isDefined(var_2)) {
    objective_onentity(var_4, var_2);
    objective_setzoffset(var_4, 120);
    objective_setplayintro(var_4, 0);
    objective_setpings(var_4, 1);
    objective_setlabel(var_4, &"CP_DWN_TWN_OBJECTIVES/LBL_SHOOT");
    objective_setbackground(var_4, 1);
    objective_icon(var_4, "icon_waypoint_objective_general");
    objective_state(var_4, "current");
    return;
  }
}

function headicon_range() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("p1_intel_museum_truck");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("p1_intel_tower_truck");

  if(isDefined(level.ref_11CA7)) {
    foreach(var_1 in level.ref_11CA7) {
      var_1 dodamage(var_1.health * 10, var_1.origin, scripts\engine\utility::random(level.players));
    }

    return;
  }
}

function ref_13526() {
  headicon_range();
  var_0 = scripts\engine\utility::getStructArray("mlp2_veh_1", "targetname");
  level.mlp2_vehicles = [];

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_2.vehicletype = "techo_phys_convoy_cp";
    var_2.script_modelname = "veh8_civ_lnd_techo_physics_mp";
    var_2.classname_mp = "script_vehicle_iw8_truck_techo_white_physics";
    var_2.script_team = "axis";
    var_3 = scripts\cp\cp_vehicles::create_ai_plr_vehicle(var_2, "techo_white");
    var_4 = level.mlp2_vehicles.size;
    level.mlp2_vehicles[var_4] = var_3;
    var_3.script_disconnectpaths = 0;
    var_3.vehicle_skipdeathmodel = 1;
    var_5 = getdvarint("scr_convoy_health", 0);
    var_3.health = scripts\engine\utility::ter_op(var_5 > 0, var_5, 25000);
    var_3.ref_13AAD = "axis";
    var_3.humanpowersenabled = var_2.script_noteworthy;
    var_6 = scripts\engine\utility::getStructArray("ml_p2_veh_start_break", "targetname");
    build_truck_path(var_3, var_6[var_4]);
    build_truck_duration(var_3, var_6[var_4]);
    var_3 vehicle_teleport(var_6[var_4].origin, var_3.angles);
    var_3.start_node = var_6[var_4];
    thread ref_14450();
    thread watch_for_death();
    thread ref_11CF7();
    thread ref_11CEA();

    if(var_3.humanpowersenabled == "front") {
      level.ref_11C63 = var_3;
    }
  }

  wait 0.5;
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_passenger_group");
  var_8 = 0;

  while(!istrue(var_8)) {
    waitframe();
    var_8 = 1;

    for(var_9 = 0; var_9 < 3; var_9++) {
      if(!isDefined(level.mlp2_vehicles[var_9].driver)) {
        var_8 = 0;
      }
    }
  }

  var_10 = level.mlp2_vehicles[0].driver;
  var_11 = level.mlp2_vehicles[1].driver;
  var_12 = level.mlp2_vehicles[2].driver;
  thread ref_11CDF();
  thread mlp2_sh1_trig();
  thread mlp2_sh2_trig();
  thread mlp2_sh3_trig();
  var_13 = level.ref_11C63.origin;

  while(!truck_airdrop(var_13, 7500)) {
    waitframe();
  }

  level notify("convoy_started_moving");
  thread lootleaderinstance();

  foreach(var_15 in [var_10, var_11, var_12]) {
    if(isDefined(var_15) && isalive(var_15)) {
      var_15.veh notify("newpath");
      thread drive_along_path(var_15);
      thread wait_until_vehicle_at_station(level);

      if(var_15.veh.humanpowersenabled != "front") {
        thread ref_138D2();
      }
    }

    wait 0.5;
  }

  level notify("delete_waypoint_on_front_truck");
  waitframe();
  thread ref_13A21();
  thread ref_12435();
  thread ref_1435B();
  scripts\engine\utility::flag_wait("players_at_station");
  mark_group_as_killable("mlp2_passenger_group");
}

function ref_11CF9(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\cp\cp_objectives::requestworldid("fronttruck_waypoint");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 120);
  objective_setplayintro(var_1, 1);
  objective_setpings(var_1, 1);
  objective_setlabel(var_1, &"CP_DWN_TWN_OBJECTIVES/SAFEHOUSE_INSPECT");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_state(var_1, "current");
  level waittill("delete_waypoint_on_front_truck");
  objective_delete(var_1);
  scripts\cp\cp_objectives::freeworldid("fronttruck_waypoint");
}

function ref_138D2() {
  self endon("death");
  var_0 = rear_minigun_attack_min_cooldown("front");
  var_0 endon("death");
  var_0 scripts\engine\utility::ref_143A6("stop_follow_path", "final_path_node_reached", "truck_stopped");
  self vehicle_setspeedimmediate(0, 300, 300);
  self stoppath(1);
}

function lootleaderinstance() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_call_contact_10");
  wait 0.5;
  var_0 = scripts\engine\utility::random(level.players);
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("obj_target_moving");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_contact_spotted_10");
}

function ref_14450() {
  self endon("death");
  self endon("truck_stopped");
  self endon("final_path_node_reached");

  while(!isDefined(self.driver)) {
    wait 1;
  }

  self.driver waittill("death");
  wait 2;
  self dodamage(self.health * 2, self.origin, scripts\engine\utility::random(level.players));
}

function watch_for_death() {
  level endon("game_ended");
  self waittill("death");
  waitframe();

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function drive_along_path(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 notify("starting_drive_path");
  var_1 = var_0.start_node;
  trial_retrieve_persistent_values(var_0, var_1);
  var_0 waittill("stop_follow_path");
  var_0 notify("final_path_node_reached");
}

function trial_retrieve_persistent_values(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(level.convoy_speed_override)) {
    var_0.speed_override = level.convoy_speed_override;
  } else {
    var_0.speed_override = 12;
  }

  var_2 = var_1;
  var_0.pathing_array = [];
  var_0.pathing_array[var_0.pathing_array.size] = var_1;
  var_2.pathing_index = var_0.pathing_array.size;

  while(isDefined(var_2) && isDefined(var_2.target)) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2.pathing_index = var_0.pathing_array.size;
    var_0.pathing_array[var_0.pathing_array.size] = var_2;
  }

  if(var_0.pathing_array.size > 27) {
    var_0 scripts\cp\cp_vehicles::split_large_pathing_array();
  }

  if(!isDefined(var_0.pathing_arrays)) {
    var_3 = var_0.pathing_array;
  } else {
    var_3 = var_1.pathing_arrays;
  }

  var_1 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_3);
}

function ref_12435() {
  level endon("players_at_station");
  wait 20;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_stakeout_ambush_follow_onthemove_10");
  wait 35;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_follow_enemy_inbound_10");
  wait 30;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_follow_near_goal_10");
}

function wait_until_vehicle_at_station(var_0) {
  var_0 endon("death");
  thread set_flag_on_death(var_0);
  var_0 waittill("final_path_node_reached");
  var_0 scripts\common\vehicle::vehicle_unload();

  foreach(var_2 in var_0.riders) {
    if(isDefined(var_0.driver) && var_0.driver == var_2) {
      var_3 = scripts\engine\utility::getStruct("ml_p2_driver_goal_pos", "targetname");
    } else {
      var_3 = scripts\engine\utility::getStruct("ml_p2_passenger_goal_pos", "targetname");
    }

    var_2 setgoalpos(var_3.origin);
  }
}

function set_flag_on_death(var_0) {
  level endon(var_0);
  self waittill("death");
  scripts\engine\utility::flag_set(var_0);
}

function ref_11CDF() {
  level endon("players_at_station");

  if(isDefined(level.ref_11C63)) {
    level.ref_11C63 endon("final_path_node_reached");
  }

  thread ref_11CDE();
}

function ref_11CF7() {
  self endon("death");
  self endon("final_path_node_reached");
  self waittill("starting_drive_path");
  wait 3;
  var_0 = 0;

  while(var_0 < 3 && !istrue(self.ref_138DF)) {
    var_1 = self vehicle_getspeed();

    if(var_1 < 5) {
      var_0 += 0.05;
    } else {
      var_0 = 0;
    }

    wait 0.05;
  }

  self vehicle_setspeedimmediate(0, 20, 20);
  scripts\common\vehicle::vehicle_unload();

  if(self == level.ref_11C63) {
    scripts\engine\utility::flag_set("fronttruck_stopped");

    if(!scripts\engine\utility::flag("players_at_station")) {
      wait 1;
      self dodamage(self.health * 10, self.origin, scripts\engine\utility::random(level.players));
      scripts\engine\utility::flag_set("convoy_destroyed");
      return;
    }

    return;
  }
}

function ref_11CDE() {
  level endon("game_ended");
  self endon("final_path_node_reached");
  self waittill("death");
  scripts\engine\utility::flag_set("convoy_destroyed");
}

function ref_11CEA() {
  level endon("game_ended");
  self endon("death");
  self endon("final_path_node_reached");
  var_0 = squared(256);
  var_1 = self.humanpowersenabled;

  for(;;) {
    wait 0.1;
    var_2 = isDefined(scripts\cp\utility::get_closest_living_player(var_0));

    if(var_2 || istrue(self.ref_138DF)) {
      break;
    }
  }

  if(var_1 == "front") {
    if(isDefined(level.ref_11BDF)) {
      level.ref_11BDF.ref_138DF = 1;
    }
  }

  if(var_1 == "mid") {
    if(isDefined(level.chopper_carepackage_pilot_selected)) {
      level.chopper_carepackage_pilot_selected.ref_138DF = 1;
    }
  }

  self vehicle_setspeedimmediate(0, 20, 20);
  scripts\common\vehicle::vehicle_unload();
  self stoppath(1);
}

function ref_1435B() {
  level.ref_11C63 waittill("final_path_node_reached");
  scripts\engine\utility::flag_set("players_at_station");
}

function mlp2_3_start(var_0) {
  scripts\mp\brclientmatchdata::getprophealth("ml_p2");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_stakeout_ambush_secure_location_10");
  level.initlethalmaxoffsetmap = "ml_p2_secure_obj";

  if(!isDefined(level.enemy_test_trig)) {
    mlp2_sh2_trig();
  }

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, level.enemy_test_trig.origin + (0, 0, 350));
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);

  while(!scripts\engine\utility::flag_exist("mlp2_sh2") || !scripts\engine\utility::flag_exist("mlp2_sh1") || !scripts\engine\utility::flag_exist("mlp2_sh3")) {
    wait 1;
  }

  while(!scripts\engine\utility::flag("mlp2_sh2") || !scripts\engine\utility::flag("mlp2_sh1")) {
    wait 1;
  }

  wait 5;
  wait 1;
  var_1 = 750;
  var_2 = var_1 * var_1;

  for(;;) {
    var_3 = 0;
    var_4 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

    foreach(var_6 in var_4) {
      if(distance2dsquared(level.enemy_test_trig.origin, var_6.origin) < var_2) {
        var_3 = 1;
      }
    }

    if(!var_3) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_interrogate");
}

function is_group_dead(var_0) {
  if(!isDefined(level.spawn_module_structs_memory[var_0])) {
    return true;
  } else {
    foreach(var_2 in level.spawn_module_structs_memory[var_0]) {
      if(var_2.ai_spawned.size > 0) {
        return false;
      }
    }
  }

  return true;
}

function mlp2_debug_start(var_0) {
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  scripts\engine\utility::flag_wait("dwn_twn_mlp2_register_spawn_modules_done");
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123FD();
  var_1 = scripts\engine\utility::getStruct("ml_p2_heli_debug", "targetname");

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  level.player_heli = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_2);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "mlp2_start");
}

function debug_ml_p2_interrogate_start(var_0) {
  scripts\engine\utility::flag_set("dwn_twn_mlp2_script");

  if(!scripts\engine\utility::flag_exist("dwn_twn_mlp2_script_completed")) {
    scripts\engine\utility::flag_init("dwn_twn_mlp2_script_completed");
  }

  scripts\engine\utility::flag_wait("dwn_twn_mlp2_script_completed");
  scripts\engine\utility::flag_wait("dwn_twn_mlp2_register_spawn_modules_done");
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
  wait 1;
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "mlp2_3_start");
}

function ml_p2_interrogate(var_0) {
  level notify("stop_rein_music");
  wait_until_interrogation(var_0);
  wait 5;
  scripts\engine\utility::flag_wait("ml_p2_done");
  mark_group_as_killable("mlp2_sh1");
  mark_group_as_killable("mlp2_sh2");
  mark_group_as_killable("mlp2_sh3");
  mark_group_as_killable("mlp2_roof_rpg");
  mark_group_as_killable("mlp2_sh1_rpg");
  mark_group_as_killable("mlp2_vip_spawns");
  mark_group_as_killable("mlp2_vip_truck_spawn");
  mark_group_as_killable("mlp2_vip_spawns_decoy");
  level.max_agents_override = undefined;
  scripts\cp\cp_modular_spawning::unpause_group_by_group_name("wave_spawning");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_stakeout_ambush_success_servers_10", "allies");
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p3_intel");
}

function setup_interrogate(var_0) {
  level.int_vips = [];
  level.int_vips[0] = self;

  if(isDefined(level.int_vips_struct)) {
    level.int_vips_struct.origin = self.origin;
  }

  self.ignoreall = 1;
  self setgoalpos(self.origin);
  thread create_usable_model();
}

function create_usable_model() {
  var_0 = spawn("script_model", self.origin + (0, 0, 50));
  var_0 setModel("tag_origin");
  waitframe();
  var_1 = &"CP_BR/INTEL_DROP";
  var_0 setHintString(var_1);
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_none");
  var_0 setHintString(&"CP_DWN_TWN_OBJECTIVES/INTERROGATE");
  var_0 makeusable();
  thread use_think(var_0);
  return var_0;
}

function use_think(var_0) {
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(istrue(var_0.being_used)) {
        continue;
      }

      if(istrue(var_1.isjuggernaut)) {
        continue;
      }

      if(istrue(var_1.super_activated)) {
        switch (var_1.super) {
          case "role_engineer":
          case "role_hunter":
            continue;
        }
      }

      thread interrogate_guy(var_1);
      return;
    }
  }
}

function interrogate_guy(var_0) {
  if(!isDefined(level.int_vips[0]) || !isalive(level.int_vips[0])) {
    return;
  }

  self.being_used = 1;
  self makeunusable();
  var_0.interrogating = 1;
  waitframe();
  thread doleaderfinalsurrender(level, var_0);
  self delete();
}

function wait_until_interrogation(var_0) {
  scripts\engine\utility::flag_init("ml_p2_interrogate_complete");
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_interrogate_spawn");

  while(!isDefined(level.int_vips)) {
    wait 0.1;
  }

  thread notify_on_vip_death();
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, level.int_vips[0].origin + (0, 0, 100));
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("ping_response_affirm");
  var_1 = 0;
  doleadersurrender(var_1);
  scripts\engine\utility::flag_wait("ml_p2_doors_init");
  var_2 = scripts\engine\utility::getStruct("ml_p2_door_clip", "targetname");
  wait_for_player_nearby(var_2.origin, 150, -50, 100);
  open_door("ml_p2_door");
  var_3 = sortbydistance(level.players, level.ml_p2_doors["ml_p2_door"].origin);
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("check_fire", var_3[0]);
  scripts\engine\utility::flag_wait("ml_p2_interrogate_complete");
}

function notify_on_vip_death() {
  self waittill("death");

  if(!scripts\engine\utility::flag("ml_p2_interrogate_complete")) {
    thread delay_vip_death_vo(1);
    thread give_death_intel();
    return;
  }
}

function delay_vip_death_vo(var_0) {
  wait var_0;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_stakeout_ambush_interrogate_fail_10", "allies");
}

function wait_for_player_nearby(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = var_0[2] + var_2;
  }

  var_6 = undefined;
  jumpiffalse(isDefined(var_3)) LOC_00000029;
  var_6 = var_0[2] + var_3;

  for(;;) {
    var_7 = 0;

    foreach(var_9 in level.players) {
      if(distance2dsquared(var_9.origin, var_0) <= var_4) {
        if(isDefined(var_5)) {
          if(var_9.origin[2] < var_5) {
            continue;
          }
        }

        if(isDefined(var_6)) {
          if(var_9.origin[2] > var_6) {
            continue;
          }
        }

        var_7 = 1;
      }
    }

    if(var_7) {
      break;
    }

    wait 0.1;
  }
}

function doleadersurrender(var_0) {
  if(isDefined(level.int_vips[var_0]) && isalive(level.int_vips[var_0])) {
    var_1 = level.int_vips[var_0];
    var_1.invulnerable = 1;
    var_1.scripted_mode = 0;
    var_1.ignoreall = 1;
    var_1.dropweapon = 1;
    var_1 scripts\asm\shared\mp\utility::burndowntime("vip_cp_surrender");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_stakeout_ambush_interrogate_lt_10", "allies");
    thread loopidlesurrenderanimation(var_1);
    return;
  }
}

#using_animtree("");

function doleaderfinalsurrender(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level.int_vips[var_1]) && isalive(level.int_vips[var_1])) {
    var_2 = level.int_vips[var_1];
  } else {
    return;
  }

  thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("obj_target_interrogate", var_0);
  var_2 endon("death");
  var_2 notify("leader_final_surrender");

  if(istrue(var_0.has_gl)) {
    var_0 scripts\common\utility::allow_weapon_switch(1);
    var_0 scripts\common\utility::allow_weapon_pickup(1);
  }

  var_2.invulnerable = 1;
  var_0.ability_invulnerable = 1;

  if(scripts\cp\cp_weapon::ref_124AD(var_0)) {
    var_0.ref_11C3D = var_0.restoreweapon;
    var_0.ref_12FB2 = var_0.secondaryweaponobj;
    scripts\cp\cp_weapon::minigamefinishcount(var_0);
    var_0 waittill("weapon_change");

    for(;;) {
      var_3 = 0;
      var_4 = ["iw8_minigunksjugg_mp", "iw8_lm_dblmg_mp", "none"];

      foreach(var_6 in var_4) {
        var_7 = var_0 getcurrentweapon();

        if(var_7.basename == var_6) {
          var_3 = 1;
        }
      }

      if(!var_3) {
        break;
      }

      waitframe();
    }
  }

  var_0.restoreweapon = var_0 getcurrentweapon();
  var_0 disableusability();
  var_9 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_9, undefined, undefined, 1);
  var_10 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_9, 0);
  var_0.gunlessweapon = var_9;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 setstance("stand");
  var_11 = var_0.angles;
  var_0 scripts\engine\utility::ref_143B9(1, "weapon_change");
  ref_12DA0(var_2, var_0);
  waitframe();
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_12 = var_2 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "vip_cp_surrender_end");
  var_13 = var_2 scripts\asm\asm::asm_getxanim("animscripted", var_12);
  thread create_player_rig(var_0, var_0);
  var_2 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "interrogate");
  link_player_to_rig(var_0);
  var_0.player_rig hide();
  var_14 = getanimlength(%cp_scripted_interrogation_grab_player);
  var_2 takeweapon(var_2.weapon);
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_15 = ref_136B9(var_2);
  var_15 useanimtree($);
  var_15.animname = "ziptie";
  var_16 = spawn("script_origin", var_2.origin);
  var_16.origin = var_2.origin;
  var_16.angles = var_2.angles;
  var_17 = getstartorigin(var_16.origin, var_16.angles, var_13);
  var_18 = getstartangles(var_16.origin, var_16.angles, var_13);
  var_2 dontinterpolate();
  var_2 forceteleport(var_17, var_18);
  var_0 setplayerangles(var_18);
  var_0 setOrigin(var_17);
  var_15.origin = var_17;
  var_15.angles = var_18;
  waitframe();
  var_0 cameraset("camera_custom_orbit_2_cp");
  thread ref_13BCB(var_0, var_0);
  var_16 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "interrogate");
  var_16 thread scripts\common\anim::anim_single_solo(var_15, "interrogate");
  var_2 aisetanim("animscripted", var_12);
  wait var_14;
  var_0 notify("remove_rig");
  var_0 cameradefault();
  var_0 setplayerangles(var_11);
  thread ref_13BCB(var_0, var_0);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_9);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.ability_invulnerable = undefined;

  if(isDefined(var_2) && isalive(var_2)) {
    thread give_surrendered_intel(level, var_0);
    var_2.angles += (0, 180, 0);
    thread loopidlesurrenderanimation(var_2, "vip_cp_surrender_end_idle");
  }

  scripts\engine\utility::flag_wait("ml_p2_done");
  var_0 switchtoweapon(var_0.restoreweapon);

  if(istrue(var_0.has_gl)) {
    var_0 scripts\common\utility::allow_weapon_switch(0);
    var_0 scripts\common\utility::allow_weapon_pickup(0);
  }

  var_16 delete();
  var_0 enableusability();
  var_0.interrogating = 0;
  scripts\cp\utility::ref_123FE("mus_cp_money_caught_lieutenant");
}

function ref_136B9(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("zip_tie_handcuffs_wm");
  var_1.angles = var_0.angles;
  var_0.ziptie = var_1;
  return var_1;
}

function ref_13BCB(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = spawn("script_model", var_0 gettagorigin("tag_accessory_right"));
    var_2 setModel("electronics_usb_thumb_drive");
    var_2 linkTo(var_0, "tag_accessory_right");
    var_0.ref_14044 = var_2;
    return;
  }

  if(isDefined(var_0.ref_14044)) {
    var_0.ref_14044 delete();
    return;
  }
}

function ref_12DA0(var_0, var_1) {
  var_2 = spawn("script_origin", var_0.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 linkTo(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectortoangles(var_3);
  var_2 rotateTo(var_4, 0.4);
  wait 0.4;
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 forceteleport(var_0.origin, var_4);
  var_2 delete();
}

function give_surrendered_intel(var_0, var_1) {
  var_0 endon("death");
  wait 1;
  scripts\engine\utility::flag_set("ml_p2_interrogate_complete");
  var_0 scripts\cp\intel\cp_intel::give_intel_weapon("intel_put_usb_in_tablet");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("obj_secured", var_0);
  scripts\engine\utility::flag_set("ml_p2_done");

  foreach(var_3 in level.players) {
    var_3 scripts\cp_mp\xmike109::scriptable_callback("downtown_1");
  }
}

function test_kill_vip(var_0) {
  wait 2;
  var_0 dodamage(var_0.health + 1000, var_0.origin);
}

function give_death_intel() {
  scripts\cp\intel\cp_intel::drop_intel_piece();
  level waittill("ml_p1_intel_found");
  scripts\engine\utility::flag_set("ml_p2_interrogate_complete");
}

function loopidlesurrenderanimation(var_0, var_1) {
  self endon("death");
  self endon("leader_returned_to_combat");
  self endon("leader_final_surrender");
  level endon("tmtyl_squad_complete");
  var_2 = self;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = var_2 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_4 = var_2 scripts\asm\asm::asm_getxanim("animscripted", var_3);
  var_5 = getanimlength(var_4);
  var_6 = spawn("script_origin", var_2.origin);
  var_6.angles = var_2.angles;
  var_7 = getstartorigin(var_6.origin, var_6.angles, var_4);
  var_8 = getstartangles(var_6.origin, var_6.angles, var_4);
  var_2.anchor.origin = var_7;
  var_2.anchor.angles = var_8;
  var_2 dontinterpolate();
  var_2 forceteleport(var_7, var_8);
  var_2 linkTo(self.anchor);
  var_2.scripted_mode = 0;
  var_2.ignoreall = 1;
  thread ref_144B5();

  for(;;) {
    if(istrue(var_1) && isDefined(var_2.ziptie)) {
      var_9 = var_7;
      var_10 = var_8;
      var_6 thread scripts\common\anim::anim_single_solo(var_2.ziptie, "idle");
    }

    var_2 aisetanim("animscripted", var_3);
    wait var_5;
  }
}

function ref_144B5() {
  level endon("game_ended");
  scripts\engine\utility::ref_143A5("leader_final_surrender", "leader_returned_to_combat");

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143A6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function link_player_to_rig(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  var_0 playerlinktoblend(var_0.player_rig, "tag_player", var_1, 0.25, 0.25);
  wait var_1;
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

function init_anims() {
  level.scr_animtree["player_interrogator"] = #animtree;
  level.scr_anim["player_interrogator"]["interrogate"] = % cp_scripted_interrogation_grab_player;
  level.scr_eventanim["player_interrogator"]["interrogate"] = "cp_player_interrogate";
  level.scr_animtree["ziptie"] = #animtree;
  level.scr_anim["ziptie"]["interrogate"] = % cp_scripted_interrogation_grab_zip_tag;
  level.scr_animname["ziptie"]["interrogate"] = "cp_scripted_interrogation_grab_zip_tag";
  level.scr_anim["ziptie"]["idle"] = % cp_scripted_interrogation_tied_idle_ziptag;
  level.scr_animname["ziptie"]["idle"] = "cp_scripted_interrogation_tied_idle_ziptag";
}

function call_ai_cellphone(var_0) {
  foreach(var_2 in level.players) {
    var_2 forceusehintoff();
  }

  thread scripts\cp\intel\cp_intel::give_intel_weapon("intel_call_phone");
  scripts\cp\utility::ref_123FE("mus_cp_money_call_contact");
  wait 3;
  level notify("contact_called");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123CB("obj_target_visual", self);
}

function mlp2_sh1_trig(var_0) {
  var_1 = scripts\engine\utility::getStruct("mlp2_sh1_trig", "targetname");
  var_2 = spawn("trigger_radius", var_1.origin, 0, int(var_1.radius), int(var_1.height));
  var_2.target = var_1.target;
  var_2.targetname = var_1.targetname;
  scripts\engine\utility::flag_init("mlp2_sh1");
  thread trigger_spawn(var_2);
  scripts\engine\utility::flag_wait("mlp2_sh1");
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_sh1_2");
  scripts\cp\cp_modular_spawning::run_spawn_module("mlp2_sh1_3");
  scripts\engine\utility::flag_set("station_reached");
  thread ref_138C6();
  thread throw_moltovs_out_windows();

  if(isDefined(var_0)) {
    foreach(var_4 in var_0) {
      if(isalive(var_4)) {
        var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
      }
    }

    return;
  }
}

function ref_138C6() {
  mark_group_as_killable("mlp2_roof_rpg");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mlp2_roof_rpg");
}

function mlp2_sh2_trig(var_0) {
  var_1 = scripts\engine\utility::getStruct("mlp2_sh2_trig", "targetname");
  var_2 = spawn("trigger_radius", var_1.origin, 0, int(var_1.radius), int(var_1.height));
  var_2.target = var_1.target;
  var_2.targetname = var_1.targetname;
  level.enemy_test_trig = var_2;
  thread trigger_spawn(var_2, "mlp2_sh2");
}

function mlp2_sh3_trig() {
  var_0 = scripts\engine\utility::getStruct("mlp2_sh3_trig", "targetname");
  var_1 = spawn("trigger_radius", var_0.origin, 0, int(var_0.radius), int(var_0.height));
  var_1.target = var_0.target;
  var_1.targetname = var_0.targetname;
  thread trigger_spawn(var_1);
}

function trigger_spawn(var_0, var_1) {
  self endon("stop_spawning");
  self endon("death");
  scripts\engine\utility::flag_init(var_0);

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set(var_0);
  var_3 = self.target;
  var_4 = scripts\cp\cp_modular_spawning::run_spawn_module(var_3);
  thread wait_for_ai_dead(var_4);
}

function aud_smoke_grenade_loop() {
  wait 1;
  playsoundatpos((22865, -2282, -438), "scn_cp_smoke_expl_smoke_tail");
}

function wait_for_ai_dead(var_0) {
  scripts\cp\cp_modular_spawning::wait_for_all_group_dead(self);
  scripts\engine\utility::flag_set(var_0);
}

function init_molotov_throw_targets() {
  level.molotov_throw_spots = scripts\engine\utility::getStructArray("molotov_throw", "targetname");
  level.molotov_throw_targets = [];

  foreach(var_1 in level.molotov_throw_spots) {
    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
      var_1.target_spot = var_2;
      var_2.throw_loc = var_1;
      var_2.cooldown = 0;
      level.molotov_throw_targets[level.molotov_throw_targets.size] = var_2;
    }
  }
}

function throw_moltovs_out_windows() {
  level endon("ml_p2_interrogate_complete");
  level endon("game_ended");
  init_molotov_throw_targets();
  thread force_molotov_throw();

  for(;;) {
    foreach(var_1 in level.molotov_throw_targets) {
      var_2 = var_1.radius * var_1.radius;

      foreach(var_4 in level.players) {
        if(distancesquared(var_4.origin, var_1.origin) < var_2) {
          if(abs(var_4.origin[2] - var_1.origin[2]) < 100) {
            var_5 = try_throw_molotov_at_spot(var_1, var_4);

            if(isDefined(var_5)) {
              var_1.cooldown = gettime() + 15000;
              wait 1;
            }
          }
        }
      }
      LOC_000000df:
    }

    wait 0.1;
  }
}

function try_throw_molotov_at_spot(var_0, var_1) {
  var_2 = var_0.throw_loc.origin;
  var_3 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var_4 = 22500;

  foreach(var_6 in var_3) {
    if(distancesquared(var_6.origin, var_2) < var_4) {
      throw_molotov(var_0.throw_loc, var_6, var_1);
      return var_6;
    }
  }

  return undefined;
}

function throw_molotov(var_0, var_1) {
  var_2 = var_0;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3) * 450;

  if(isDefined(var_1)) {
    var_5 = self.origin;
    var_6 = (var_1.origin[0], var_1.origin[1], self.origin[2]);
    var_7 = var_6 - var_5;
    var_7 = vectorNormalize(var_7);
    var_4 = var_7 * 450;
  }

  var_8 = var_2 launchgrenade("molotov_mp", self.origin, var_4);
  var_8.owner = var_2;
  var_2 thread scripts\cp\powers\coop_molotov::molotov_used(var_8);
}

function force_molotov_throw() {
  level endon("ml_p2_interrogate_complete");
  level endon("game_ended");
  trigger_hall_molotov();
  var_0 = scripts\engine\utility::getStruct("hall_molotov_throw_radius", "targetname");
  var_1 = scripts\engine\utility::getStruct("hall_molotov_throw", "targetname");
  var_2 = var_0.radius;
  var_3 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var_4 = var_2 * var_2;

  foreach(var_6 in var_3) {
    if(distancesquared(var_6.origin, var_0.origin) < var_4) {
      if(var_6.origin[2] > var_0.origin[2] - 50) {
        throw_molotov(var_1, var_6);
        scripts\engine\utility::flag_set("station_second_floor");
        return;
      }
    }
  }
}

function trigger_hall_molotov() {
  var_0 = scripts\engine\utility::getStruct("hall_molotov_target", "targetname");
  var_1 = var_0.radius * var_0.radius;

  for(;;) {
    foreach(var_3 in level.players) {
      if(distancesquared(var_3.origin, var_0.origin) < var_1) {
        if(abs(var_3.origin[2] - var_0.origin[2]) < 100) {
          return;
        }
      }
    }

    wait 0.1;
  }
}

function mark_never_remove(var_0) {
  self.never_kill_off = 1;
}

function mark_group_as_killable(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned) {
        var_5.never_kill_off = undefined;

        if(isDefined(var_5.ref_1376B)) {
          var_5.health = var_5.ref_1376B;
        }
      }
    }

    return;
  }
}

function isplayermatched(var_0) {
  wait var_0;
  self kill();
}