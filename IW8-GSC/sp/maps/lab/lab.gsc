/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab.gsc
***********************************************/

main() {
  level.littlebird_bulletdamage = 1;
  level.is_dark = 0;
  preload();
  scripts\sp\maps\lab\gen\lab_art.gsc::main();
  scripts\sp\maps\lab\lab_fx.gsc::main();
  scripts\sp\maps\lab\lab_lighting.gsc::main();
  scripts\sp\maps\lab\lab_precache.gsc::main();
  scripts\sp\maps\lab\lab_anim.gsc::main();
  init_introscreen();
  setsaveddvar("MKNNNONLSK", 4);
  setsaveddvar("NOSQLKNSQO", 45);
  setsaveddvar("MMLNNQSTTL", 5);
  setDvar("ballistics_muzzleSpeed", 16000);
  scripts\common\basic_wind::load_all_wind();
  lab_starts();
  scripts\sp\load::main();
  scripts\sp\player\ballistics::init_ballistics();
  thread scripts\sp\maps\lab\lab_util.gsc::wind_setdirection("east", (150, -80, 0), 0);
  createthreatbiasgroup("player");
  postload();
  player_loadout();
  thread lab_objectives();
  thread scripts\sp\maps\lab\lab_vo_util.gsc::track_player_combat_time();
  thread oscar_hack();
  scripts\sp\credits::initcredits();
}

oscar_hack() {
  waitframe();
  var_0 = getEnt("weapon_iw8_sh_oscar12+ironsdefault_oscar12+gripside_oscar12+drums_oscar12+back_oscar12+front_oscar12+rec_oscar12", "code_classname");
  var_1 = spawn("weapon_iw8_sh_oscar12+ironsdefault_oscar12+gripside_oscar12+drums_oscar12_sp+back_oscar12+front_oscar12+rec_oscar12", var_0.origin, var_0.spawnflags);
  var_1.angles = var_0.angles;
  var_1.targetname = var_0.targetname;
  var_1 scripts\anim\shared.gsc::setscriptammo("iw8_sh_oscar12", var_0, undefined);
  var_0 delete();
}

init_introscreen() {
  scripts\engine\sp\utility::intro_screen_custom_func(::introscreen_delayed);
}

introscreen_delayed() {
  scripts\sp\introscreen::introscreen(1);
}

screens_think() {
  if(istrue(level.screens_off_test)) {
    return;
  }
  self endon("death");
  scripts\common\screens::screens_create();
  var_0 = scripts\common\screens::get_state();

  if(isDefined(var_0))
    scripts\common\screens::do_state(var_0);
  else {
    childthread scripts\common\screens::screens_fixed();

    if(randomint(3) == 0)
      childthread scripts\common\screens::screens_bink();
    else if(randomint(8) == 0)
      childthread scripts\common\screens::screens_red();
  }
}

preload() {
  flag_setup();
  scripts\sp\maps\lab\lab_hill.gsc::hill_preload();
  scripts\sp\maps\lab\lab_turbines.gsc::turbines_preload();
  scripts\sp\maps\lab\lab_offices.gsc::offices_preload();
  scripts\sp\maps\lab\lab_pipes.gsc::pipes_outdoor_preload();
  scripts\sp\maps\lab\lab_finale.gsc::finale_preload();
  scripts\engine\sp\utility::add_hint_string("lab_melee", &"LAB/COSTOM_MELEE");
  setsaveddvar("MQLRQNRRPR", 0);
}

postload() {
  thread scripts\sp\maps\lab\lab_util.gsc::dragonsbreathpainfxhackspawnfunc();
  getspawner("hero_price", "targetname") scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\lab\lab_util.gsc::price_spawn_func);
  level.cos10 = cos(10);
  level.cos15 = cos(15);
  level.cos30 = cos(30);
  level.cos60 = cos(60);
  scripts\sp\maps\lab\lab_turbines.gsc::turbines_postload();
  scripts\sp\maps\lab\lab_offices.gsc::offices_postload();
  scripts\sp\maps\lab\lab_hill.gsc::hill_postload();
  scripts\sp\maps\lab\lab_pipes.gsc::pipes_outdoor_postload();
  scripts\sp\maps\lab\lab_finale.gsc::finale_postload();
  scripts\engine\utility::flag_set("respawn_friendlies");
  scripts\sp\maps\lab\lab_util.gsc::sun_flare_on();
  thread scripts\engine\sp\utility::add_global_spawn_function("axis", ::corpse_weapon_pos);
  thread scripts\engine\sp\utility::add_global_spawn_function("allies", ::corpse_weapon_pos);
  thread corpse_world_pos();
}

corpse_world_pos() {
  for(;;) {
    wait 2;
    var_0 = getcorpsearray();

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isDefined(var_2.origin) && (var_2.origin[2] < -1500 || var_2.origin[2] > 3000))
          var_2 delete();
      }
    }
  }
}

corpse_weapon_pos() {
  self waittill("weapon_dropped", var_0);
  wait 2;

  if(isDefined(var_0) && isDefined(var_0.origin) && (var_0.origin[2] < -1500 || var_0.origin[2] > 3000))
    var_0 delete();
}

player_loadout() {
  var_0 = ["frag", "flash", "molotov"];
  scripts\engine\sp\utility::offhandprecache(var_0);

  if(scripts\sp\starts::is_after_start("bridge"))
    scripts\sp\utility::allow_weapon_first_raise_anims(0);

  if(level.start_point == "kyle_player") {
    return;
  }
  if(scripts\sp\starts::is_after_start("gas_chambers")) {
    scripts\sp\maps\lab\lab_pipes.gsc::kyle_loadout();
    return;
  }

  scripts\sp\maps\lab\lab_util.gsc::setplayerviewmodel("viewmodel_arms_alex_woodland", "viewhands_base_legs_iw8", "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_alex_woodland");
  var_1 = undefined;

  if(level.start_point == "bridge") {
    return;
  }
  if(level.start_point == "juggernaut") {
    var_2[0] = scripts\sp\maps\lab\lab_util.gsc::make_incendiary_shottie();
    var_2[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["ub_mike203_sp", "acog_west01_irons"]);
    var_1 = var_2[0];
    level.player giveweapon(var_2[0]);
    level.player giveweapon(var_2[1]);
    level.player givemaxammo(var_2[0]);
    level.player givemaxammo(var_2[1]);
  } else if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    var_2[0] = scripts\sp\maps\lab\lab_util.gsc::make_bulletdrop_weapon();
    var_2[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["ub_mike203_sp", "acog_west01_irons"]);
    var_1 = var_2[0];
    level.player giveweapon(var_2[0]);
    level.player giveweapon(var_2[1]);
    level.player setweaponammostock(var_2[0], 20);
    level.player givemaxammo(var_2[1]);
  } else {
    var_2[0] = scripts\sp\maps\lab\lab_util.gsc::make_bulletdrop_weapon();
    var_2[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["ub_mike203_sp", "acog_west01_irons"]);
    var_1 = var_2[0];
    level.player giveweapon(var_2[0]);
    level.player giveweapon(var_2[1]);
    level.player setweaponammostock(var_2[0], 10);
    level.player givemaxammo(var_2[1]);
  }

  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player givemaxammo("flash");
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player givemaxammo("frag");
  level.player switchtoweapon(var_1);
  level.player.offhands_list = ["frag", "flash"];
}

lab_starts() {
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
  scripts\engine\sp\utility::add_start("drone", scripts\sp\maps\lab\lab_hill.gsc::drone_start, "drone", scripts\sp\maps\lab\lab_hill.gsc::drone_main, "hill_start", scripts\sp\maps\lab\lab_hill.gsc::drone_catchup);
  scripts\engine\sp\utility::add_start("bridge", scripts\sp\maps\lab\lab_hill.gsc::bridge_start, "bridge", scripts\sp\maps\lab\lab_hill.gsc::bridge_main, "hill_all", scripts\sp\maps\lab\lab_hill.gsc::bridge_catchup);
  scripts\engine\sp\utility::add_start("drone_tutorial", scripts\sp\maps\lab\lab_hill.gsc::tunnel_start, "drone_tutorial", scripts\sp\maps\lab\lab_hill.gsc::tunnel_main, "hill_all", scripts\sp\maps\lab\lab_hill.gsc::tunnel_catchup);
  scripts\engine\sp\utility::add_start("hill_bottom", scripts\sp\maps\lab\lab_hill.gsc::hill_bottom_start, "hill_bottom", scripts\sp\maps\lab\lab_hill.gsc::hill_bottom_main, "hill_all", scripts\sp\maps\lab\lab_hill.gsc::hill_bottom_catchup);
  scripts\engine\sp\utility::add_start("hill_mid", scripts\sp\maps\lab\lab_hill.gsc::hill_mid_start, "hill_mid", scripts\sp\maps\lab\lab_hill.gsc::hill_mid_main, "hill_all", scripts\sp\maps\lab\lab_hill.gsc::hill_mid_catchup);
  scripts\engine\sp\utility::add_start("hill_top", scripts\sp\maps\lab\lab_hill.gsc::hill_top_start, "hill_top", scripts\sp\maps\lab\lab_hill.gsc::hill_top_main, "hill_all", scripts\sp\maps\lab\lab_hill.gsc::hill_top_catchup);
  scripts\engine\sp\utility::add_start("lab_entrance", scripts\sp\maps\lab\lab_turbines.gsc::lab_entrance_start, "lab_entrance", scripts\sp\maps\lab\lab_turbines.gsc::lab_entrance_main, "hill_turbines_and_van", scripts\sp\maps\lab\lab_turbines.gsc::lab_entrance_catchup);
  scripts\engine\sp\utility::add_start("lab_ambush", scripts\sp\maps\lab\lab_turbines.gsc::lab_ambush_start, "lab_ambush", scripts\sp\maps\lab\lab_turbines.gsc::lab_ambush_main, "turbines_all", scripts\sp\maps\lab\lab_turbines.gsc::lab_ambush_catchup);
  scripts\engine\sp\utility::add_start("lab_jumpdown", scripts\sp\maps\lab\lab_turbines.gsc::lab_jumpdown_start, "lab_jumpdown", scripts\sp\maps\lab\lab_turbines.gsc::lab_jumpdown_main, "turbines_all", scripts\sp\maps\lab\lab_turbines.gsc::lab_jumpdown_catchup);
  scripts\engine\sp\utility::add_start("dragons_breath", scripts\sp\maps\lab\lab_turbines.gsc::dragons_breath_start, "dragons_breath", scripts\sp\maps\lab\lab_turbines.gsc::dragons_breath_main, "turbines_all", scripts\sp\maps\lab\lab_turbines.gsc::dragons_breath_catchup);
  scripts\engine\sp\utility::add_start("juggernaut", scripts\sp\maps\lab\lab_turbines.gsc::juggernaut_start, "juggernaut", scripts\sp\maps\lab\lab_turbines.gsc::juggernaut_main, "turbines_all", scripts\sp\maps\lab\lab_turbines.gsc::juggernaut_catchup);
  scripts\engine\sp\utility::add_start("offices", scripts\sp\maps\lab\lab_offices.gsc::offices_start, "offices", scripts\sp\maps\lab\lab_offices.gsc::offices_main, "indoor_all", scripts\sp\maps\lab\lab_offices.gsc::offices_catchup);
  scripts\engine\sp\utility::add_start("gas_chambers", scripts\sp\maps\lab\lab_offices.gsc::gas_chambers_start, "gas_chambers", scripts\sp\maps\lab\lab_offices.gsc::gas_chambers_main, "pipes_all", scripts\sp\maps\lab\lab_offices.gsc::gas_chambers_catchup);
  scripts\engine\sp\utility::add_start("pipes_jumpdown", scripts\sp\maps\lab\lab_pipes.gsc::pipes_jumpdown_start, "pipes_jump_down", scripts\sp\maps\lab\lab_pipes.gsc::pipes_jumpdown_main, "pipes_all", scripts\sp\maps\lab\lab_pipes.gsc::pipes_jumpdown_catchup);
  scripts\engine\sp\utility::add_start("pipes_outdoor", scripts\sp\maps\lab\lab_pipes.gsc::pipes_outdoor_start, "pipes_outdoor", scripts\sp\maps\lab\lab_pipes.gsc::pipes_outdoor_main, "finale_scene", scripts\sp\maps\lab\lab_pipes.gsc::pipes_outdoor_catchup);
  scripts\engine\sp\utility::add_start("moveto_parking_hallway", scripts\sp\maps\lab\lab_pipes.gsc::pipes_hallway_start, "moveto_parking_hallway", scripts\sp\maps\lab\lab_pipes.gsc::pipes_hallway_main, "finale_scene", scripts\sp\maps\lab\lab_pipes.gsc::pipes_hallway_catchup);
  scripts\engine\sp\utility::add_start("final_pipes", scripts\sp\maps\lab\lab_pipes.gsc::final_pipes_start, "final_pipes", scripts\sp\maps\lab\lab_pipes.gsc::final_pipes_main, "finale_scene", scripts\sp\maps\lab\lab_pipes.gsc::final_pipes_catchup);
  scripts\engine\sp\utility::add_start("perspective_swap", scripts\sp\maps\lab\lab_finale.gsc::finale_perspective_start, "perspective_swap", scripts\sp\maps\lab\lab_finale.gsc::finale_perspective_main, "finale_scene", scripts\sp\maps\lab\lab_finale.gsc::finale_perspective_catchup);
  scripts\engine\sp\utility::add_start("finale_heli", scripts\sp\maps\lab\lab_finale.gsc::finale_heli_start, "finale_heli", scripts\sp\maps\lab\lab_finale.gsc::finale_heli_main, "finale_scene", scripts\sp\maps\lab\lab_finale.gsc::finale_heli_catchup);
  scripts\engine\sp\utility::add_start("finale_kickoff", scripts\sp\maps\lab\lab_finale.gsc::finale_kickoff_start, "finale_kickoff", scripts\sp\maps\lab\lab_finale.gsc::finale_kickoff_main, "finale_scene", scripts\sp\maps\lab\lab_finale.gsc::finale_kickoff_catchup);
}

flag_setup() {
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

lab_objectives() {
  switch (level.start_point) {
    case "drone":
    case "bridge":
      while(!isDefined(level.tank2))
        waitframe();

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

      while(!isDefined(level.hilltop_heli))
        waitframe();

      lab_obj_remove("lab_entrance_obj");
      scripts\engine\sp\objectives::objective_add("hilltop_heli", "current", undefined, &"LAB/OBJ_DESTROY_CHOPPER");
      scripts\engine\sp\objectives::objective_set_on_entity("hilltop_heli", "heli_location", level.hilltop_heli);
      scripts\engine\utility::flag_wait("hilltop_heli_dead");
      wait 3;
      lab_obj_remove("hilltop_heli");
      scripts\engine\sp\objectives::objective_add("lab_entrance_obj", "current", var_0.origin, &"LAB/OBJ_PUSH_ENTRANCE");

      if(!scripts\engine\utility::flag("inside_waiting_flag"))
        scripts\engine\utility::flag_wait("inside_waiting_flag");

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

      while(!isDefined(level.juggernaut_1))
        waitframe();

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

      while(!isDefined(level.barkov))
        waitframe();

      lab_obj_remove("lot_c_end_obj");
      scripts\engine\sp\objectives::objective_add("barkov_fight_obj", "current", undefined, &"LAB/OBJ_KILL_BARKOV");
      scripts\engine\sp\objectives::objective_set_on_entity("barkov_fight_obj", "barkov_location", level.barkov);
      scripts\engine\utility::flag_wait("barkov_dead");
      scripts\engine\sp\objectives::objective_complete("barkov_fight_obj");
      scripts\engine\sp\objectives::objective_set_state("barkov_fight_obj", "done");
  }
}

lab_obj_remove(var_0) {
  if(scripts\engine\sp\objectives::objective_exists(var_0))
    scripts\engine\sp\objectives::objective_remove(var_0);
}