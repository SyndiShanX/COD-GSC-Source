/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab.gsc
***********************************************/

function main() {
  level.littlebird_bulletdamage = 1;
  level.is_dark = 0;
  preload();
  scripts\sp\maps\lab\gen\lab_art::main();
  scripts\sp\maps\lab\lab_fx::main();
  scripts\sp\maps\lab\lab_lighting::main();
  scripts\sp\maps\lab\lab_precache::main();
  scripts\sp\maps\lab\lab_anim::main();
  init_introscreen();
  setsaveddvar("fx_lightmap_max_level", 4);
  setsaveddvar("r_tessellationFactor", 45);
  setsaveddvar("fx_alphaThreshold", 5);
  setDvar("ballistics_muzzleSpeed", 16000);
  scripts\common\basic_wind::load_all_wind();
  lab_starts();
  scripts\sp\load::main();
  scripts\sp\player\ballistics::init_ballistics();
  thread scripts\sp\maps\lab\lab_util::wind_setdirection("east", (150, -80, 0), 0);
  createthreatbiasgroup("player");
  postload();
  player_loadout();
  thread lab_objectives();
  thread scripts\sp\maps\lab\lab_vo_util::track_player_combat_time();
  thread oscar_hack();
  scripts\sp\credits::initcredits();
}

function oscar_hack() {
  waitframe();
  var_0 = getEnt("weapon_iw8_sh_oscar12+ironsdefault_oscar12+gripside_oscar12+drums_oscar12+back_oscar12+front_oscar12+rec_oscar12", "code_classname");
  var_1 = spawn("weapon_iw8_sh_oscar12+ironsdefault_oscar12+gripside_oscar12+drums_oscar12_sp+back_oscar12+front_oscar12+rec_oscar12", var_0.origin, var_0.spawnflags);
  var_1.angles = var_0.angles;
  var_1.targetname = var_0.targetname;
  var_1 scripts\anim\shared::setscriptammo("iw8_sh_oscar12", var_0, undefined);
  var_0 delete();
}

function init_introscreen() {
  scripts\engine\sp\utility::intro_screen_custom_func(&introscreen_delayed);
}

function introscreen_delayed() {
  scripts\sp\introscreen::introscreen(1);
}

function screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }

  self endon("death");
  scripts\common\screens::screens_create();
  var_0 = scripts\common\screens::get_state();

  if(isDefined(var_0)) {
    scripts\common\screens::do_state(var_0);
    return;
  }

  childthread scripts\common\screens::screens_fixed();

  if(randomint(3) == 0) {
    childthread scripts\common\screens::screens_bink();
    return;
  }

  if(randomint(8) == 0) {
    childthread scripts\common\screens::screens_red();
    return;
  }
}

function preload() {
  flag_setup();
  scripts\sp\maps\lab\lab_hill::hill_preload();
  scripts\sp\maps\lab\lab_turbines::turbines_preload();
  scripts\sp\maps\lab\lab_offices::offices_preload();
  scripts\sp\maps\lab\lab_pipes::pipes_outdoor_preload();
  scripts\sp\maps\lab\lab_finale::finale_preload();
  scripts\engine\sp\utility::add_hint_string("lab_melee", &"LAB/COSTOM_MELEE");
  setsaveddvar("sm_sunStageBounds", 0);
}

function postload() {
  thread scripts\sp\maps\lab\lab_util::dragonsbreathpainfxhackspawnfunc();
  getspawner("hero_price", "targetname") scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\lab\lab_util::price_spawn_func);
  level.cos10 = cos(10);
  level.cos15 = cos(15);
  level.cos30 = cos(30);
  level.cos60 = cos(60);
  scripts\sp\maps\lab\lab_turbines::turbines_postload();
  scripts\sp\maps\lab\lab_offices::offices_postload();
  scripts\sp\maps\lab\lab_hill::hill_postload();
  scripts\sp\maps\lab\lab_pipes::pipes_outdoor_postload();
  scripts\sp\maps\lab\lab_finale::finale_postload();
  scripts\engine\utility::flag_set("respawn_friendlies");
  scripts\sp\maps\lab\lab_util::sun_flare_on();
  thread scripts\engine\sp\utility::add_global_spawn_function("axis", &corpse_weapon_pos);
  thread scripts\engine\sp\utility::add_global_spawn_function("allies", &corpse_weapon_pos);
  thread corpse_world_pos();
}

function corpse_world_pos() {
  for(;;) {
    wait 2;
    var_0 = getcorpsearray();

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isDefined(var_2.origin) && (var_2.origin[2] < -1500 || var_2.origin[2] > 3000)) {
          var_2 delete();
        }
      }
    }
  }
}

function corpse_weapon_pos() {
  self waittill("weapon_dropped", var_0);
  wait 2;

  if(isDefined(var_0) && isDefined(var_0.origin) && (var_0.origin[2] < -1500 || var_0.origin[2] > 3000)) {
    var_0 delete();
    return;
  }
}

function player_loadout() {
  var_0 = ["frag", "flash", "molotov"];
  scripts\engine\sp\utility::offhandprecache(var_0);

  if(scripts\sp\starts::is_after_start("bridge")) {
    scripts\sp\utility::allow_weapon_first_raise_anims(0);
  }

  if(level.start_point == "kyle_player") {
    return;
  }

  if(scripts\sp\starts::is_after_start("gas_chambers")) {
    scripts\sp\maps\lab\lab_pipes::kyle_loadout();
    return;
  }

  scripts\sp\maps\lab\lab_util::setplayerviewmodel("viewmodel_arms_alex_woodland", "viewhands_base_legs_iw8", "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_alex_woodland");
  var_1 = undefined;

  if(level.start_point == "bridge") {
    return;
  }

  if(level.start_point == "juggernaut") {
    GscBinSkip1(0x45, 0, scripts\sp\maps\lab\lab_util::make_incendiary_shottie());
  }

  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    GscBinSkip1(0x45, 0, scripts\sp\maps\lab\lab_util::make_bulletdrop_weapon());
  }

  GscBinSkip1(0x45, 0, scripts\sp\maps\lab\lab_util::make_bulletdrop_weapon());
}

function lab_starts() {
  scripts\engine\sp\utility::transient_init("lab_drone_tr");
  scripts\engine\sp\utility::transient_init("lab_hill_bottom_tr");
  scripts\engine\sp\utility::transient_init("lab_hill_main_tr");
  scripts\engine\sp\utility::transient_init("lab_turbine1_tr");
  scripts\engine\sp\utility::transient_init("lab_turbine2_tr");
  scripts\engine\sp\utility::transient_init("lab_van_tr");
  scripts\engine\sp\utility::transient_init("lab_office_tr");
  scripts\engine\sp\utility::transient_init("lab_pipes_tr");
  scripts\engine\sp\utility::transient_init("lab_finale_tr");
  scripts\engine\sp\utility::set_default_start("drone");
  scripts\engine\sp\utility::add_start("drone", &scripts\sp\maps\lab\lab_hill::drone_start, "drone", &scripts\sp\maps\lab\lab_hill::drone_main, "hill_start", &scripts\sp\maps\lab\lab_hill::drone_catchup);
  scripts\engine\sp\utility::add_start("bridge", &scripts\sp\maps\lab\lab_hill::bridge_start, "bridge", &scripts\sp\maps\lab\lab_hill::bridge_main, "hill_all", &scripts\sp\maps\lab\lab_hill::bridge_catchup);
  scripts\engine\sp\utility::add_start("drone_tutorial", &scripts\sp\maps\lab\lab_hill::tunnel_start, "drone_tutorial", &scripts\sp\maps\lab\lab_hill::tunnel_main, "hill_all", &scripts\sp\maps\lab\lab_hill::tunnel_catchup);
  scripts\engine\sp\utility::add_start("hill_bottom", &scripts\sp\maps\lab\lab_hill::hill_bottom_start, "hill_bottom", &scripts\sp\maps\lab\lab_hill::hill_bottom_main, "hill_all", &scripts\sp\maps\lab\lab_hill::hill_bottom_catchup);
  scripts\engine\sp\utility::add_start("hill_mid", &scripts\sp\maps\lab\lab_hill::hill_mid_start, "hill_mid", &scripts\sp\maps\lab\lab_hill::hill_mid_main, "hill_all", &scripts\sp\maps\lab\lab_hill::hill_mid_catchup);
  scripts\engine\sp\utility::add_start("hill_top", &scripts\sp\maps\lab\lab_hill::hill_top_start, "hill_top", &scripts\sp\maps\lab\lab_hill::hill_top_main, "hill_all", &scripts\sp\maps\lab\lab_hill::hill_top_catchup);
  scripts\engine\sp\utility::add_start("lab_entrance", &scripts\sp\maps\lab\lab_turbines::lab_entrance_start, "lab_entrance", &scripts\sp\maps\lab\lab_turbines::lab_entrance_main, "hill_turbines_and_van", &scripts\sp\maps\lab\lab_turbines::lab_entrance_catchup);
  scripts\engine\sp\utility::add_start("lab_ambush", &scripts\sp\maps\lab\lab_turbines::lab_ambush_start, "lab_ambush", &scripts\sp\maps\lab\lab_turbines::lab_ambush_main, "turbines_all", &scripts\sp\maps\lab\lab_turbines::lab_ambush_catchup);
  scripts\engine\sp\utility::add_start("lab_jumpdown", &scripts\sp\maps\lab\lab_turbines::lab_jumpdown_start, "lab_jumpdown", &scripts\sp\maps\lab\lab_turbines::lab_jumpdown_main, "turbines_all", &scripts\sp\maps\lab\lab_turbines::lab_jumpdown_catchup);
  scripts\engine\sp\utility::add_start("dragons_breath", &scripts\sp\maps\lab\lab_turbines::dragons_breath_start, "dragons_breath", &scripts\sp\maps\lab\lab_turbines::dragons_breath_main, "turbines_all", &scripts\sp\maps\lab\lab_turbines::dragons_breath_catchup);
  scripts\engine\sp\utility::add_start("juggernaut", &scripts\sp\maps\lab\lab_turbines::juggernaut_start, "juggernaut", &scripts\sp\maps\lab\lab_turbines::juggernaut_main, "turbines_all", &scripts\sp\maps\lab\lab_turbines::juggernaut_catchup);
  scripts\engine\sp\utility::add_start("offices", &scripts\sp\maps\lab\lab_offices::offices_start, "offices", &scripts\sp\maps\lab\lab_offices::offices_main, "indoor_all", &scripts\sp\maps\lab\lab_offices::offices_catchup);
  scripts\engine\sp\utility::add_start("gas_chambers", &scripts\sp\maps\lab\lab_offices::gas_chambers_start, "gas_chambers", &scripts\sp\maps\lab\lab_offices::gas_chambers_main, "pipes_all", &scripts\sp\maps\lab\lab_offices::gas_chambers_catchup);
  scripts\engine\sp\utility::add_start("pipes_jumpdown", &scripts\sp\maps\lab\lab_pipes::pipes_jumpdown_start, "pipes_jump_down", &scripts\sp\maps\lab\lab_pipes::pipes_jumpdown_main, "pipes_all", &scripts\sp\maps\lab\lab_pipes::pipes_jumpdown_catchup);
  scripts\engine\sp\utility::add_start("pipes_outdoor", &scripts\sp\maps\lab\lab_pipes::pipes_outdoor_start, "pipes_outdoor", &scripts\sp\maps\lab\lab_pipes::pipes_outdoor_main, "finale_scene", &scripts\sp\maps\lab\lab_pipes::pipes_outdoor_catchup);
  scripts\engine\sp\utility::add_start("moveto_parking_hallway", &scripts\sp\maps\lab\lab_pipes::pipes_hallway_start, "moveto_parking_hallway", &scripts\sp\maps\lab\lab_pipes::pipes_hallway_main, "finale_scene", &scripts\sp\maps\lab\lab_pipes::pipes_hallway_catchup);
  scripts\engine\sp\utility::add_start("final_pipes", &scripts\sp\maps\lab\lab_pipes::final_pipes_start, "final_pipes", &scripts\sp\maps\lab\lab_pipes::final_pipes_main, "finale_scene", &scripts\sp\maps\lab\lab_pipes::final_pipes_catchup);
  scripts\engine\sp\utility::add_start("perspective_swap", &scripts\sp\maps\lab\lab_finale::finale_perspective_start, "perspective_swap", &scripts\sp\maps\lab\lab_finale::finale_perspective_main, "finale_scene", &scripts\sp\maps\lab\lab_finale::finale_perspective_catchup);
  scripts\engine\sp\utility::add_start("finale_heli", &scripts\sp\maps\lab\lab_finale::finale_heli_start, "finale_heli", &scripts\sp\maps\lab\lab_finale::finale_heli_main, "finale_scene", &scripts\sp\maps\lab\lab_finale::finale_heli_catchup);
  scripts\engine\sp\utility::add_start("finale_kickoff", &scripts\sp\maps\lab\lab_finale::finale_kickoff_start, "finale_kickoff", &scripts\sp\maps\lab\lab_finale::finale_kickoff_main, "finale_scene", &scripts\sp\maps\lab\lab_finale::finale_kickoff_catchup);
}

function flag_setup() {
  scripts\engine\utility::flag_init("introscreen_start_wait");
  scripts\engine\utility::flag_init("convoy_spotted");
  scripts\engine\utility::flag_init("almost_there");
  scripts\engine\utility::flag_init("left_turn_stop_1");
  scripts\engine\utility::flag_init("hill_charge_started");
  scripts\engine\utility::flag_init("intro_drop_down_trig");
  scripts\engine\utility::flag_init("turbines_clear");
  scripts\engine\utility::flag_init("offices_started_trig");
  scripts\engine\utility::flag_init("lab_finished");
  scripts\engine\utility::flag_init("reached_lot_c_trig");
  scripts\engine\utility::flag_init("db_enemy_dead");
  scripts\engine\utility::flag_init("price_containment_wait");
  scripts\engine\utility::flag_init("screens_offices");
  scripts\engine\utility::flag_init("pause_rebel_respawning");
}

function lab_objectives() {
  switch (level.start_point) {
    case "drone":
    case "bridge":
      while(!isDefined(level.tank2)) {
        waitframe();
      }

      var_0 = scripts\engine\utility::getStruct("lab_entrance_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("bridge_intro_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FACILITY");
    case "hill_top":
    case "hill_mid":
    case "hill_bottom":
    case "drone_tutorial":
      scripts\engine\utility::flag_wait("hill_fallback_1");
      lab_obj_remove("bridge_intro_obj");
      var_0 = scripts\engine\utility::getStruct("lab_entrance_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("lab_entrance_obj", "current", var_0.origin, &"LAB/OBJ_PUSH_ENTRANCE");
      scripts\engine\utility::flag_wait("hilltop_heli_spawned");

      while(!isDefined(level.hilltop_heli)) {
        waitframe();
      }

      lab_obj_remove("lab_entrance_obj");
      scripts\engine\sp\objectives::objective_add("hilltop_heli", "current", undefined, &"LAB/OBJ_DESTROY_CHOPPER");
      scripts\engine\sp\objectives::objective_set_on_entity("hilltop_heli", "heli_location", level.hilltop_heli);
      scripts\engine\utility::flag_wait("hilltop_heli_dead");
      wait 3;
      lab_obj_remove("hilltop_heli");
      scripts\engine\sp\objectives::objective_add("lab_entrance_obj", "current", var_0.origin, &"LAB/OBJ_PUSH_ENTRANCE");

      if(!scripts\engine\utility::flag("inside_waiting_flag")) {
        scripts\engine\utility::flag_wait("inside_waiting_flag");
      }

      lab_obj_remove("lab_entrance_obj");
    case "lab_ambush":
    case "lab_entrance":
      var_0 = scripts\engine\utility::getStruct("van_scene_start", "targetname");
      scripts\engine\sp\objectives::objective_add("van_scene_obj", "current", var_0.origin, &"LAB/OBJ_NIKOLAI_VAN");
    case "lab_jumpdown":
      scripts\engine\utility::flag_wait("van_scene_start");
      lab_obj_remove("van_scene_obj");
      var_0 = getEnt("van_bomb", "targetname");
      scripts\engine\sp\objectives::objective_add("van_scene_obj", "current", var_0.origin, &"LAB/OBJ_NIKOLAI_DETONATOR");
    case "dragons_breath":
      scripts\engine\utility::flag_wait("grab_charges");
      lab_obj_remove("van_scene_obj");
      var_0 = scripts\engine\utility::getStruct("turbine_door_scene", "targetname");
      scripts\engine\sp\objectives::objective_add("db_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
    case "juggernaut":
      scripts\engine\utility::flag_wait("ambush2_entrance_go");
      lab_obj_remove("db_obj");
      var_0 = scripts\engine\utility::getStruct("t2_end_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("t2_end_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
      scripts\engine\utility::flag_wait("cp_5_juggernaut_start");

      while(!isDefined(level.juggernaut_1)) {
        waitframe();
      }

      lab_obj_remove("t2_end_obj");
      scripts\engine\sp\objectives::objective_add("juggernaut", "current", undefined, &"LAB/OBJ_JUGGERNAUT");
      scripts\engine\utility::flag_wait("juggernaut_dead");
      lab_obj_remove("juggernaut");
      var_0 = scripts\engine\utility::getStruct("pre_office_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("pre_office_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
      scripts\engine\utility::flag_wait("pre_office_door_flag");
      wait 0.5;
      lab_obj_remove("pre_office_obj");
    case "offices":
      var_0 = scripts\engine\utility::getStruct("office_start_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("office_start_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
      scripts\engine\utility::flag_wait("offices_started_trig");
      lab_obj_remove("office_start_obj");
      var_0 = scripts\engine\utility::getStruct("office_end_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("office_start_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
      scripts\engine\utility::flag_wait("reached_final_room");
      lab_obj_remove("office_start_obj");
    case "gas_chambers":
    case "kyle_player":
      var_0 = scripts\engine\utility::getStruct("lab_entrance_interact", "targetname");
      scripts\engine\sp\objectives::objective_add("office_end_obj", "current", var_0.origin, &"LAB/OBJ_REACH_FURNACE");
      scripts\engine\utility::flag_wait("transition_bink_done");
      lab_obj_remove("office_end_obj");
    case "pipes_outdoor":
    case "pipes_jumpdown":
      var_0 = scripts\engine\utility::getStruct("lot_A_start_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("pipe_building_obj", "current", var_0.origin, &"LAB/OBJ_REACH_PIPELINE", &"LAB/OBJ_CLEAR_LOT");
      scripts\engine\utility::flag_wait("parking_lot_clear");
      lab_obj_remove("pipe_building_obj");
    case "moveto_parking_hallway":
      var_0 = scripts\engine\utility::getStruct("lot_A_start_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("lot_A_start_obj", "current", var_0.origin, &"LAB/OBJ_REACH_PIPELINE");
      scripts\engine\utility::flag_wait("player_inside_hall");
      lab_obj_remove("lot_A_start_obj");
    case "final_pipes":
      var_0 = scripts\engine\utility::getStruct("lot_C_finished_obj_struct", "targetname");
      scripts\engine\sp\objectives::objective_add("lot_c_end_obj", "current", var_0.origin, &"LAB/OBJ_REACH_PIPELINE", &"LAB/OBJ_PLANT_CHARGES");
    case "finale_heli":
      scripts\engine\utility::flag_wait("finale_scene");

      while(!isDefined(level.barkov)) {
        waitframe();
      }

      lab_obj_remove("lot_c_end_obj");
      scripts\engine\sp\objectives::objective_add("barkov_fight_obj", "current", undefined, &"LAB/OBJ_KILL_BARKOV");
      scripts\engine\sp\objectives::objective_set_on_entity("barkov_fight_obj", "barkov_location", level.barkov);
      scripts\engine\utility::flag_wait("barkov_dead");
      scripts\engine\sp\objectives::objective_complete("barkov_fight_obj");
      scripts\engine\sp\objectives::objective_set_state("barkov_fight_obj", "done");
      break;
  }
}

function lab_obj_remove(var_0) {
  if(scripts\engine\sp\objectives::objective_exists(var_0)) {
    scripts\engine\sp\objectives::objective_remove(var_0);
    return;
  }
}