/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_hill.gsc
************************************************************/

_id_C9DF() {
  setDvar("ent_count_debug", 0);
  setdvarifuninitialized("debug_print_anims", 0);
  precacheitem("generic_mg_turret_nodamage");
  precacheitem("generic_mg_turret_nosound");
  precacheitem("sdf_mg_turret_phhill");
  precachemodel("container_lag_cardboard_box_03");
  precachemodel("com_office_book_red_flat");
  precachemodel("p7_pot_metal_stock");
  precachemodel("p7_bottle_plastic_16oz_water");
  precachemodel("cup_paper_open_iw6");
  precachemodel("misc_bottle_wine_01");
  precachemodel("robot_c6_red");
  precachemodel("veh_mil_air_un_dropship_hero_cockpit_dmg");
  precachemodel("decor_aatis_tower_globe_01");
  precachemodel("veh_mil_air_ca_dropship_severed_front");
  precachemodel("veh_mil_air_ca_dropship_severed_rear");
  precachemodel("veh_mil_lnd_un_apc_earth_dmg");
  scripts\engine\utility::flag_init("hill_street_dialogue_done");
  scripts\engine\utility::flag_init("hill_street_salter_path_complete");
  scripts\engine\utility::flag_init("hill_player_in_bddy_door");
  scripts\engine\utility::flag_init("hill_player_bddy_door_done");
  scripts\engine\utility::flag_init("hill_player_in_basement");
  scripts\engine\utility::flag_init("hill_player_basement_dialogue_done");
  scripts\engine\utility::flag_init("hill_basement_dialogue_done");
  scripts\engine\utility::flag_init("hill_admiral_scene");
  scripts\engine\utility::flag_init("hill_charge_trench_allies");
  scripts\engine\utility::flag_init("hill_admiral_at_trench");
  scripts\engine\utility::flag_init("hill_trench_admiral_speach");
  scripts\engine\utility::flag_init("hill_charge_start");
  scripts\engine\utility::flag_init("hill_run_salter_start");
  scripts\engine\utility::flag_init("hill_admiral_ready_for_roll");
  scripts\engine\utility::flag_init("hill_failure_ready_for_roll");
  scripts\engine\utility::flag_init("hill_redshirt1_ready_for_roll");
  scripts\engine\utility::flag_init("hill_redshirt2_ready_for_roll");
  scripts\engine\utility::flag_init("hill_redshirt1_continue_path");
  scripts\engine\utility::flag_init("hill_redshirt2_continue_path");
  scripts\engine\utility::flag_init("hill_dropship_cockpit_roll");
  scripts\engine\utility::flag_init("hill_dropship_cockpit_roll_done");
  scripts\engine\utility::flag_init("hill_run_crater_01");
  scripts\engine\utility::flag_init("hill_run_crater_02");
  scripts\engine\utility::flag_init("hill_runner_past_ethan");
  scripts\engine\utility::flag_init("hill_right_mortar_guy_run");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_spawn");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_spawned");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_fire");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_first_goal");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_continue");
  scripts\engine\utility::flag_init("hill_friendly_destroyer_leaving");
  scripts\engine\utility::flag_init("pause_player_hotbox_tracers");
  scripts\engine\utility::flag_init("hill_mg_dropship_unloaded");
  scripts\engine\utility::flag_init("hill_enemy_mg_dropship_guy_dead");
  scripts\engine\utility::flag_init("hill_robot_kick_scene_done");
  scripts\engine\utility::flag_init("hill_combat_balcony_grab_start");
  scripts\engine\utility::flag_init("hill_combat_dropship_necksnap_done");
  scripts\engine\utility::flag_init("hill_combat_color_movement_start");
  scripts\engine\utility::flag_init("hill_combat_right_droppod_landed");
  scripts\engine\utility::flag_init("hill_combat_center_dropship_unloading");
  scripts\engine\utility::flag_init("hill_combat_left_top_dropship_unloading");
  scripts\sp\utility::_id_22C9("hill_streets_civ_runner", ::_id_8FCF);
  getspawner("hill_basement_fireman_carry", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_8F14);
  scripts\sp\utility::_id_22C9("hill_basement_stumbler", ::_id_8F19);
  scripts\sp\utility::_id_22CA("hill_trench_allies", ::_id_8FD4);
  getEnt("hill_friendly_destroyer", "targetname") scripts\sp\utility::_id_1747(::_id_8F72);
  getEnt("hill_streets_enemy_destroyer", "targetname") scripts\sp\utility::_id_1747(::_id_8FD0);
  getEnt("hill_enemy_destroyer", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_8F5F);
  scripts\sp\utility::_id_22C9("hill_enemy_dist_destroyer", ::_id_8F60);
  scripts\sp\utility::_id_22C9("hill_run_chase_jackals", ::_id_8FA9);
  scripts\sp\utility::_id_22CA("hill_run_jackal_strafe_01", ::_id_8F96, "hill_run_strafe01", 3.4, 1.5);
  scripts\sp\utility::_id_22CA("hill_run_jackal_strafe_02", ::_id_8F96, "hill_run_strafe02", 0.5, 5.5);
  getEnt("hill_enemy_mg_dropship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_8F62);
  getspawner("hill_robot_kick_right_robot", "targetname") scripts\sp\utility::_id_1747(::_id_8FA4);
  getspawner("hill_robot_kick_left_robot", "targetname") scripts\sp\utility::_id_1747(::_id_8FA3);
  getspawner("hill_combat_balcony_grab_robot", "targetname") scripts\sp\utility::_id_1747(::_id_8F40);
  getEnt("hill_combat_droppod_right", "targetname") scripts\sp\utility::_id_1747(::_id_8F44);
  scripts\sp\utility::_id_22C9("hill_downed_dropship_jumpers", ::_id_8F53);
  scripts\sp\utility::_id_22C9("hill_tower_fake_dropships", ::hill_tower_fake_dropships);
  scripts\sp\utility::_id_22C9("hill_ally_runner", ::_id_8F04);
  scripts\sp\utility::_id_22CA("hill_combat_wall_reinforcement", ::_id_8F51);
  scripts\sp\utility::_id_22C9("hill_combat_redshirt", ::_id_8F4C);
  scripts\sp\utility::_id_22CA("hill_vista_capitalships", ::_id_8FDC);
  scripts\sp\maps\pearlharbor\pearlharbor_hill_dropship::_id_8F57();
  scripts\engine\utility::array_thread(getEntArray("hill_run_enemy_turrets", "script_noteworthy"), ::_id_8FB0);
  scripts\engine\utility::array_thread(getEntArray("mortar_group_trig", "script_noteworthy"), ::_id_BB56);
  scripts\engine\utility::array_thread(getEntArray("bullet_impact_trigger", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_323A);
  scripts\engine\utility::array_thread(getEntArray("hill_reinforcement_trigs", "targetname"), ::_id_8FA2);
  scripts\engine\utility::array_thread(getEntArray("hill_mortar_trigs", "targetname"), ::_id_8F9A);
  scripts\engine\utility::array_thread(getEntArray("post_dropship_boss_trigs", "targetname"), scripts\engine\utility::trigger_off);
  scripts\engine\utility::array_thread(getEntArray("post_dropship_boss_trigs", "script_noteworthy"), scripts\engine\utility::trigger_off);
  thread _id_8F50();
  thread _id_8FAB();
  thread _id_8FDB();
  thread _id_4327();
  _id_0B0F::_id_10282("hill_vista_skyambient", "hill_skyambient_droppods", 15);
  _id_0B0F::_id_10282("hill_vista_skyambient", "hill_left_dropships", 9);
  level._id_BB65 = 128;
  level._id_BB5A = 500;
  level._id_BB59 = 5000;
  level._id_C06F = 1;
  level._id_BBA0 = cos(40);
  level._id_BB69 = [level.player];
  level._id_BB6B = 1;
  level._id_93D3 = 0.8;
  level._id_BB57 = "hill_mortar_incoming";
  scripts\sp\utility::_id_16CC("mortar", 0.3, 1, 2000);
  scripts\sp\utility::_id_16CC("hill_street_explosions", 0.2, 2, 25000);
  self._id_AFED = 800;
  self._id_B04E = 2;
  level._id_B81B = 30;
  level._id_28A6 = [];
  level._id_19C4 = [];
  level._id_19C4["mortar"] = ::_id_8FBB;
  level._id_19C4["blood_impact"] = ::scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C3;
  level.scr_sound["mortar"]["incomming"] = "phstreets_hill_mortar_incoming";
  level.scr_sound["mortar"]["hill_mortar_impact_instant"] = "phstreets_hill_mortar_explo";
  level.scr_sound["mortar"]["hill_mortar_impact"] = "phstreets_hill_mortar_explo";
  thread scripts\sp\mortar::_id_2C1A();
}

_id_8FCE() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_allies");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_allies", var_0);
  scripts\engine\utility::flag_set("hill_allies_start");
  scripts\engine\utility::flag_set("hill_basement_start");
  scripts\sp\utility::_id_15F5("hill_allies_colortrig");
  scripts\sp\vehicle::_id_1080F("hill_vista_capitalships");
  thread _id_0B0F::_id_10D23("hill_vista_skyambient");
  level.player scripts\engine\utility::delaythread(1, _id_0B0A::_id_1121E, "phstreets_bus_sun", 0);
  thread _id_8F16();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_8FC9();
  _id_0B0F::_id_19FF("hill_street_aiambient_trig");

  if(getdvarint("e3", 0) == 1) {
    var_1 = getEntArray("cafe_hack_pristine_damage_door", "targetname");

    foreach(var_3 in var_1) {
      var_3 hide();
    }

    var_5 = getEntArray("cafe_hack_door_clip", "targetname");

    foreach(var_7 in var_5) {
      var_7 hide();
    }

    scripts\engine\utility::delaythread(0.05, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_10197, "dmg2");
    var_9 = getEnt("hack_window_clip", "targetname");

    if(isDefined(var_9)) {
      var_9 connectpaths();
      var_9 delete();
    }

    var_10 = getEnt("cafe_table", "targetname");
    var_11 = var_10 scripts\engine\utility::get_target_ent();
    var_10 delete();
    var_11 delete();
    scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_8E73();
  }
}

_id_8FCD() {
  if(!level.console) {
    waitforalltransients();
  }

  level._id_B460 = 20;

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::_id_F305();

    if(scripts\sp\utility::_id_9BEE()) {
      if(level._id_DADC) {
        setsaveddvar("r_postaa", 1);
      }
    }
  }

  thread _id_8F52();
  thread _id_8FCA();
  scripts\engine\utility::exploder("dogleg_periph_smoke");
  setmusicstate("mx_070_approach_bunker");
  scripts\engine\utility::delaythread(1.2, ::_id_57C9);
  level._id_39B6 = 1;
  scripts\engine\utility::flag_wait("hill_allies_start");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("c");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_5564();
    var_1 scripts\sp\utility::_id_550C();
    var_1 scripts\sp\utility::_id_54F7();
    var_1 thread scripts\sp\utility::_id_61F0(250);
    var_2 = scripts\engine\utility::getStruct("hill_street_path_" + var_1._id_1FBB, "targetname");
    var_1 thread scripts\sp\utility::_id_7226(var_2);
  }
}

_id_8FCC() {
  level endon("hill_street_salter_path_complete");
  thread _id_8FCB();

  for(;;) {
    wait 0.05;
    var_0 = distance2d(level.player.origin, self.origin);

    if(var_0 > 1024) {
      self.moveplaybackrate = 1.3;
      continue;
    }

    if(var_0 < 128 || level.player scripts\sp\utility::_id_3849(self.origin + (0, 0, 62), 0)) {
      self.moveplaybackrate = 1.0;
      continue;
    }

    self.moveplaybackrate = 1.2;
  }
}

_id_8FCB() {
  level waittill("hill_street_salter_path_complete");
  self.moveplaybackrate = 1.0;
}

_id_8FCA() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("cafe_vo_done");
  scripts\sp\utility::_id_10350("dps_unms_allstationsbe");
  level.allies["admiral"] scripts\sp\utility::_id_10347("dps_adm_eclipsethisistopca");
  scripts\sp\utility::_id_10350("dps_ecp_5x5admiralsendtraffic");
  level.allies["admiral"] scripts\sp\utility::_id_10347("dps_adm_ineedyourairshipto");
  scripts\sp\utility::_id_10350("dps_ecp_clearsirinboundhot");
  scripts\engine\utility::flag_set("hill_street_dialogue_done");
}

_id_8F52() {
  var_0 = spawn("script_origin", (71877, 47409, -33579));
  var_0 _meth_8278(0, 0.05);
  wait 0.1;
  var_0 playLoopSound("emt_phstreets_dist_battle_01_lp");
  var_0 _meth_8278(1, 2);
  scripts\engine\utility::flag_wait("hill_player_bddy_door_done");
  var_0 _meth_8278(0, 3);
  wait 3.1;
  var_0 stoploopsound();
  wait 0.5;
  var_0 delete();
}

_id_8FC7() {
  var_0 = scripts\engine\utility::getStruct("hill_streets_mortar_struct", "targetname");

  while(!scripts\engine\utility::flag("hill_player_in_bddy_door")) {
    wait(randomfloatrange(4, 8));

    if(scripts\engine\utility::flag("hill_player_in_bddy_door")) {
      break;
    }

    _id_57C9();
  }
}

_id_8FCF() {
  self._id_55ED = 1;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC();
}

_id_57C9() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E((68431, 42822, -34147), 10);
  scripts\engine\utility::do_earthquake("hill_street_explosions", var_0);
  scripts\engine\utility::play_sound_in_space("emt_street_dist_explosion", var_0);
}

_id_8FD0() {
  scripts\engine\utility::flag_wait("hill_player_in_basement");
  self delete();
}

_id_8FC8() {
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("c");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  scripts\engine\utility::flag_set("hill_allies_start");
  scripts\engine\utility::flag_set("hill_basement_start");
  scripts\engine\utility::flag_set("hill_player_approaching_basement");
  scripts\engine\utility::flag_set("hill_street_dialogue_done");
  scripts\engine\utility::flag_set("hill_street_salter_path_complete");
  scripts\sp\vehicle::_id_1080F("hill_vista_capitalships");
  level._id_B460 = 20;
}

_id_8F18() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_basement");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_basement", var_0);
  scripts\sp\utility::_id_15F5("hill_basement_color_trig");
  level.player scripts\engine\utility::delaythread(1, _id_0B0A::_id_1121E, "phstreets_bus_sun", 0);
  thread _id_0B0F::_id_10D23("hill_vista_skyambient");

  if(getdvarint("e3", 0) == 1) {
    var_1 = getEntArray("cafe_hack_pristine_damage_door", "targetname");

    foreach(var_3 in var_1) {
      var_3 hide();
    }

    var_5 = getEntArray("cafe_hack_door_clip", "targetname");

    foreach(var_7 in var_5) {
      var_7 hide();
    }

    scripts\engine\utility::delaythread(0.05, scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_10197, "dmg2");
    var_9 = getEnt("hack_window_clip", "targetname");

    if(isDefined(var_9)) {
      var_9 connectpaths();
      var_9 delete();
    }

    var_10 = getEnt("cafe_table", "targetname");
    var_11 = var_10 scripts\engine\utility::get_target_ent();
    var_10 delete();
    var_11 delete();
    scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_8E73();
  }
}

_id_8F15() {
  scripts\engine\utility::flag_wait("hill_basement_start");
  thread basement_transient_slowload_wait();
  thread _id_8F08();
  thread _id_8FD1();

  if(!isDefined(level._id_28A7)) {
    _id_8F16();
  }

  thread _id_8F17();
  thread _id_8F0D();
  thread _id_8F12();
  var_0 = level.doors["hill_basement_door"];
  var_0._id_C633 = 0.75;
  var_0._id_10247 = 1;
  var_1 = var_0 _id_8F0E();
  var_0._id_9027 = "tag_ui";
  var_0._id_901E = (45, 0, 5);
  var_0._id_28B6 = "tag_ui";
  var_2 = [level.allies["admiral"], level.allies["salter"], level.allies["eth3n"]];
  var_2 = scripts\engine\utility::array_combine(var_2, var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, level._id_28A7);
  scripts\engine\utility::array_thread(var_2, ::_id_D8E6);
  var_0 _id_0B1F::_id_5982(scripts\sp\maps\phstreets\phstreets_anim::_id_8F2C, scripts\sp\maps\phstreets\phstreets_anim::_id_8F2D, scripts\sp\maps\phstreets\phstreets_anim::_id_8F2B);
  var_0 _id_0B1F::_id_59EB("scn_phstreets_beam_grab", "scn_phstreets_beam_lift", undefined, "scn_phstreets_beam_fall_fail", "scn_phstreets_beam_fall_complete");
  var_0._id_D83B = getstartorigin(var_0.origin, var_0.angles, level.allies["salter"] scripts\sp\utility::_id_7DC1(var_0 _id_0B1F::_id_5997("intro")));
  var_0 thread _id_0B1F::_id_168A(var_2);
  thread _id_8F07();
  level.allies["salter"] thread _id_8F09();
  level.allies["eth3n"] thread _id_8F06();
  level thread _id_2A21();
  var_0 scripts\sp\utility::_id_65E1("allow_hill_basement_door");
  var_0 scripts\sp\utility::_id_65E3("player_used_door");
  thread _id_3C41();
  thread _id_2A20();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_5522);
  thread _id_0B0F::_id_1103F("hill_vista_skyambient", 1);
  clearallcorpses();
  setsaveddvar("r_dof_hq", 1);

  if(isDefined(level.allies["salter"]._id_13C4D)) {
    level.allies["salter"]._id_13C4D hide();
  }

  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE49);
  var_0 scripts\sp\utility::_id_65E3("player_at_door");
  thread scripts\sp\utility::_id_12641("phstreets_fountain_tr");
  scripts\engine\utility::array_call(var_1, ::show);
  _id_0B0F::_id_19FE("hill_street_aiambient_trig");
  level.player._id_59E1 hide();
  thread _id_8F0A();
  thread _id_8F13();
  scripts\engine\utility::flag_set("hill_player_in_bddy_door");
  var_0 scripts\sp\utility::_id_65E3("door_sequence_complete");

  if(isDefined(level.old_reactive_setting)) {
    setsaveddvar("r_reactiveMotionEffectorStrengthScale", level.old_reactive_setting);
    level.old_reactive_setting = undefined;
  }

  if(isDefined(level.allies["salter"]._id_13C4D)) {
    level.allies["salter"]._id_13C4D show();
  }

  setsaveddvar("r_dof_hq", 0);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE4A);
  level.player scripts\sp\utility::_id_F526("safe");
  scripts\engine\utility::flag_set("hill_player_in_basement");
  setmusicstate("mx_071_inside_bunker");
  scripts\engine\utility::flag_set("hill_player_bddy_door_done");
  thread _id_F8C8();
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 10);
  thread scripts\sp\utility::_id_266F();
  scripts\sp\utility::_id_10FEC("dogleg_periph_smoke");
  scripts\sp\utility::_id_10FEC("street_sparks");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13D53();
  thread _id_4328();
  level.player scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_D090, "ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.6, ::playsound, "ges_plr_radio_on");
  level.player scripts\sp\utility::_id_D2CD(40, 0.05);
  scripts\engine\utility::flag_wait("hill_player_basement_dialogue_done");

  if(getdvarint("e3", 0)) {
    scripts\sp\utility::_id_12643(["phstreets_fountain_tr", "geneva_periph_lake_tr"]);
  }

  level.player thread scripts\sp\utility::_id_D2CA(1);
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio_safe");

  foreach(var_4 in level.allies) {
    var_4 scripts\sp\utility::_id_61C7();
  }

  scripts\sp\utility::_id_15F5("hill_trench_color_trig");
  _id_0E40::_id_5542();
  _id_82DE();
  scripts\engine\utility::flag_wait_either("hill_basement_dialogue_done", "player_approaching_hill_trench");
  level._id_10257 = 1;
  level._id_BB67 = 5000;
  scripts\sp\mortar::_id_2C20(0);
  level.player scripts\sp\utility::_id_F526("relaxed");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_4145);
}

basement_transient_slowload_wait() {
  if(level.console) {
    return;
  }
  scripts\engine\utility::flag_wait("player_approaching_hill_trench");
  waitforalltransients();
}

_id_2A20() {}

_id_8FD1() {
  scripts\engine\utility::flag_wait("hill_basement_start");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_1120D = (-31, 0, 0);
  var_0._id_75AC = (0, 0, 0);
  var_1 = (150000, 0, 0);
  var_1 = rotatevector(var_1, var_0._id_1120D + var_0._id_75AC);
  var_2 = level.player.origin;
  var_0.origin = var_2 + var_1;
}

_id_8F0D() {
  level.player endon("death");
  scripts\engine\utility::flag_wait_all("hill_player_approaching_basement");
  scripts\engine\utility::flag_wait("hill_player_in_bddy_door");
  level.doors["hill_basement_door"] scripts\sp\utility::_id_65E3("door_opened");
  level.allies["salter"] thread scripts\sp\utility::_id_10347("dps_slt_satoforcesblueblue");
  wait 1.3;
  level._id_28A9["ally02"] scripts\engine\utility::delaythread(5.5, scripts\sp\utility::_id_10347, "dps_um3_docmedic");
  scripts\engine\utility::flag_wait("hill_player_bddy_door_done");
  wait 0.2;
  level.player playSound("ges_plr_radio_on");
  thread _id_CAE5();
  wait 0.24;
  thread scripts\sp\utility::_id_10350("dps_plr_retributionthis11");
  wait 0.55;
  thread scripts\sp\utility::_id_10350("dps_nav_goforret11");
  wait 0.75;
  scripts\sp\utility::_id_10350("phstreets_plr_gatorineedscar3");
  scripts\sp\utility::_id_10350("dps_gtr_copylttimetotarget1mike");
  scripts\engine\utility::flag_set("hill_player_basement_dialogue_done");
  level.allies["admiral"] scripts\sp\utility::_id_10347("dps_adm_topcattogoldsatobird");
  thread scripts\sp\utility::_id_10350("dps_unms_rogertopcatgold");
  scripts\engine\utility::flag_set("hill_basement_dialogue_done");
}

_id_CAE5() {
  level._id_8F92 = spawn("script_origin", (71753, 46590, -34259));
  level._id_8F92 playLoopSound("phstreets_hill_intro_lr");
  scripts\engine\utility::flag_wait("hill_run_player_through_gate");
  wait 6;

  if(isDefined(level._id_8F92)) {
    level._id_8F92 _meth_8278(0, 8);
    wait 8.2;
    level._id_8F92 stoploopsound();
    wait 0.5;
    level._id_8F92 delete();
  }
}

_id_8F12() {
  level.doors["hill_basement_door"] scripts\sp\utility::_id_65E3("door_opened");
  scripts\engine\utility::flag_wait("hill_player_in_basement");
  thread _id_8F11(1.9, "close");
  thread _id_8F11(8.15, "close");
  scripts\engine\utility::flag_wait("hill_basement_dialogue_done");
  var_0 = getEnt("hill_player_in_basement_trig", "targetname");

  while(!scripts\engine\utility::flag("hill_charge_start")) {
    wait 0.1;

    if(!level.player istouching(var_0)) {
      continue;
    }
    scripts\engine\utility::exploder("123");
    level notify("code_damageradius", undefined, 256, level.player.origin);
    wait(randomfloatrange(2, 4));
  }
}

_id_8F1A() {
  level.player notifyonplayercommand("use_button_pressed", "+usereload");
  var_0 = gettime();

  for(;;) {
    level.player waittill("use_button_pressed");
  }
}

_id_8F11(var_0, var_1) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  var_2 = "emt_basement_dist_explosion";
  var_3 = randomfloatrange(0.12, 0.15);

  if(isDefined(var_1) && var_1 == "close") {
    var_2 = "emt_basement_close_explosion";
    var_3 = randomfloatrange(0.2, 0.3);
  }

  level.player playRumbleOnEntity("heavy_1s");
  physicsjolt(level.player.origin, 120, 60, (0, 0, 0.13));
  var_4 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(level.player.origin, 500);
  playworldsound(var_2, var_4);
  level notify("code_damageradius", undefined, 256, level.player.origin);
  earthquake(var_3, 2, var_4, 9999);
  scripts\engine\utility::exploder("123");
}

_id_8F06() {
  var_0 = level.doors["hill_basement_door"];
  var_0 scripts\sp\utility::_id_65E3("player_used_door");
  wait 1;
  var_0 thread _id_0B1F::_id_59DE(self, var_0 _id_0B1F::_id_5997("idle"), 1);
}

_id_8F09() {
  var_0 = level.doors["hill_basement_door"];
  var_0 scripts\sp\utility::_id_65E3("salter_at_door");

  if(!var_0 scripts\sp\utility::_id_65DB("player_used_door")) {
    var_1 = spawn("trigger_radius", self.origin, 0, 250, 56);
    var_1 waittill("trigger");
    var_1 delete();
    var_0 notify("stop_loop_salter");

    if(scripts\engine\utility::flag("hill_street_dialogue_done")) {
      var_0 scripts\sp\anim::_id_1F35(self, "basement_debris_nag");
    }

    var_0 thread _id_0B1F::_id_59DE(self, var_0 _id_0B1F::_id_5997("idle"), 1);
  }

  var_0 scripts\sp\utility::_id_65E3("player_at_door");
  var_0 notify("stop_loop_salter");
  var_0 scripts\sp\anim::_id_1F35(self, "basement_debris_lift");
  var_0 thread _id_0B1F::_id_59DE(self, var_0 _id_0B1F::_id_5997("idle"), 1);
  var_2 = getEnt("basement_weapon_clip", "targetname");
  var_2 delete();
}

_id_2A21() {
  level endon("buddydoor_player_intro");
  scripts\engine\utility::flag_wait("hill_street_dialogue_done");
  wait 5;
  var_0 = "dps_adm_letsgetthroughlt";
  var_1 = "phstreets_adm_letsadvance";
  var_2 = var_0;

  for(;;) {
    while(distance2d(level.allies["admiral"].origin, level.player.origin) < 300) {
      wait 0.05;
    }

    level.allies["admiral"] scripts\sp\utility::_id_10346(var_2);
    var_2 = scripts\engine\utility::ter_op(var_2 == var_0, var_1, var_0);
    wait(randomintrange(10, 15));
  }
}

_id_3C41() {
  wait 2.5;
  level.player _meth_81DE(45, 0.5);
  thread _id_0B0A::_id_583F(0, 0, 3.9, 0, 245, 5, 0);
  wait 10;
  level.player _meth_81DE(65, 1.5);
  thread _id_0B0A::_id_583D(1);
}

_id_8F07() {
  var_0 = level.doors["hill_basement_door"];
  var_0 scripts\sp\utility::_id_65E3("player_at_door");

  while(!var_0 scripts\sp\utility::_id_65DB("door_sequence_complete")) {
    var_0 scripts\sp\utility::_id_65E3("player_prying_open_door");
    scripts\engine\utility::exploder("beam_lift_dust");
    var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_65E3, "door_sequence_complete");
    var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_65E8, "player_prying_open_door");
    scripts\sp\utility::_id_57D6();
    scripts\sp\utility::_id_10FEC("beam_lift_dust");
  }
}

_id_8F08() {
  var_0 = getEnt("street_bddy_door_hero_light", "targetname");
  var_1 = var_0 _meth_8134();
  var_0 setlightintensity(0);
  var_2 = level.doors["hill_basement_door"];
  var_2 scripts\sp\utility::_id_65E3("actor_at_door");
  var_0 scripts\sp\lights::_id_AB83(var_1, 2);
}

_id_8F16() {
  level._id_28A7 = [];
  var_0 = [];
  var_1 = ["box", "book", "pot", "btl", "cup", "wine", "wall"];

  foreach(var_3 in var_1) {
    var_4 = scripts\sp\utility::_id_10639("basement_" + var_3);
    var_0[var_0.size] = var_4;
    level._id_28A7[level._id_28A7.size] = var_4;
  }

  level.doors["hill_basement_door"] thread scripts\sp\anim::_id_1EC3(level.doors["hill_basement_door"], "basement_lift_idle");
  level.doors["hill_basement_door"] thread scripts\sp\anim::_id_1EC1(var_0, "basement_debris_lift_exit");
}

#using_animtree("generic_human");

_id_8F10(var_0) {
  var_1 = level.allies["admiral"];
  var_1 detach(var_1.headmodel);
  var_1 _meth_82A2(%mayhem_ph_hill400_building_debris_lift_adm_exit, 1.0, 0.0, 1.0);
  level waittill("beam_lift_mayhem_end");
  var_1 _meth_82A2(%mayhem_ph_hill400_building_debris_lift_adm_exit, 0.0, 0.0, 1.0);
  var_1 attach(var_1.headmodel);
}

_id_8F0E() {
  var_0 = [];
  level._id_28A9 = [];
  var_1 = getspawnerarray("hill_basement_walk_marines");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_4._id_1FBB = var_3.script_noteworthy;
    var_4 hide();

    if(isai(var_4)) {
      var_4 scripts\sp\utility::_id_B14F(1);
    } else {
      var_4._id_6B14 = 1;
      var_4 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_2C16();
      var_4 _id_0B0F::_id_19FC();
    }

    if(var_4._id_1FBB == "ally01") {
      var_4 scripts\sp\utility::_id_72EC("iw7_m4+reflex", "primary");
    } else if(var_4._id_1FBB == "ally02") {
      var_4 detach(var_4.hatmodel);
      var_4 detach(var_4._id_A489);
    }

    level._id_28A9[var_3.script_noteworthy] = var_4;
    scripts\sp\anim::_id_1EC3(var_4, "basement_debris_lift_exit");
    var_4 _meth_82A2(%hm_grnd_org_helmet_raise_marines);
    thread _id_8F0F(var_4);
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

_id_8F0F(var_0) {
  scripts\sp\utility::_id_65E3("door_sequence_complete");
  scripts\sp\utility::_id_65E3(var_0._id_1FBB + "_door_sequence_complete");

  if(var_0 scripts\sp\utility::_id_8BC9("basement_debris_lift_exit_idle")) {
    thread scripts\sp\anim::_id_1EEA(var_0, "basement_debris_lift_exit_idle");
  }

  scripts\engine\utility::flag_wait("player_at_hill_trench");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_8F17() {
  var_0 = getspawner("hill_basement_scene_spawner", "targetname");
  level._id_28A6 = [];
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray("hill_basement_scene_struct", "script_noteworthy");

  foreach(var_4 in var_2) {
    var_5 = var_4.animation;
    var_0.count = 1;
    var_6 = var_0 scripts\sp\utility::_id_10619();
    var_6._id_6B14 = 1;
    var_6 scripts\sp\utility::_id_86E4();

    if(issubstr(var_5, "dead")) {} else {
      var_6 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_2C16();
      var_6 _id_0B0F::_id_19FC();
    }

    var_4 thread scripts\sp\anim::_id_1ECC(var_6, var_5);
    var_6 _meth_82A2(%hm_grnd_org_helmet_raise_marines, 1, 0, 1.0);
    level._id_28A6 = scripts\engine\utility::array_add(level._id_28A6, var_6);

    if(var_5 == "shipcribmoon_elevator_injured_loop_05") {
      var_6 thread _id_8F0C("dps_um3_coughingupblood");
    } else if(var_5 == "shipcrib_moon_injured_table_01_A") {
      var_6 detach(var_6.hatmodel);
    } else if(var_5 == "hc_wounded_d") {
      var_6 detach(var_6._id_A489);
    }

    if(getdvarint("debug_print_anims")) {}

    var_1[var_1.size] = var_6;
  }

  scripts\engine\utility::flag_wait("hill_run_player_through_gate");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_1);
  level._id_28A6 = undefined;
}

_id_F8C8() {
  level endon("stop_basement_radio_sounds");
  var_0 = ["icantseeyounomad", "okayiamvisualthes", "copyclearedhot", "understandyouremovi", "confirmyouremovings"];
  var_1 = ["takingfirefromthen", "lookforthesmokere", "rogeryourecleared", "ineedyouinheretwo", "hitemtwohitemnow", "goodgunsgoodguns", "okaywereonfoothead", "weneedyouonthewe", "afirmthatsafirmstrobe"];
  var_2 = ["kilofourthisisrome", "lineonecharliealpha", "linetwosinglechann", "linethreefivealphao", "linefoursixbravobre", "linefivesixlimabrea", "linesixxrayirepeat", "linesevensmokeb", "lineeighttwoalpha", "lineninenonebreak", "injurytypemultipleg"];
  var_3 = getaiarray("allies");
  var_3 = scripts\engine\utility::array_remove_array(var_3, level.allies);
  var_3 = scripts\engine\utility::array_remove_array(var_3, level._id_F10A._id_1633);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5._id_D4AF)) {
      var_5._id_D4AF = 0;
    }
  }

  for(;;) {
    var_7 = undefined;
    var_8 = randomint(30);

    if(var_8 <= 10 && var_0.size > 0) {
      var_7 = scripts\engine\utility::random(var_0);
      var_0 = scripts\engine\utility::array_remove(var_0, var_7);
      var_7 = "phstreets_sp1_" + var_7;
    } else if(var_8 <= 20 && var_1.size > 0) {
      var_7 = scripts\engine\utility::random(var_1);
      var_1 = scripts\engine\utility::array_remove(var_1, var_7);
      var_7 = "phstreets_un1_" + var_7;
    } else if(var_2.size > 0) {
      var_7 = scripts\engine\utility::random(var_2);
      var_2 = scripts\engine\utility::array_remove(var_2, var_7);
      var_7 = "phstreets_un2_" + var_7;
    }

    if(!isDefined(var_7)) {
      thread _id_F8C8();
      return;
    }

    var_3 = sortbydistance(var_3, level.player.origin);

    foreach(var_5 in var_3) {
      if(!var_5._id_D4AF) {
        var_5 thread _id_CDD4(var_7);
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
        break;
      }
    }

    wait(randomfloatrange(0.15, 0.35));
  }
}

_id_CDD4(var_0) {
  self._id_D4AF = 1;
  self playSound(var_0, "randomSoundDone");
  self waittill("randomSoundDone");
  self._id_D4AF = 0;
}

_id_8F0C(var_0) {
  var_1 = spawn("trigger_radius", self.origin, 0, 256, 56);
  var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "entitydeleted");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();
  var_1 delete();

  if(isDefined(self)) {
    thread scripts\sp\utility::play_sound_on_entity(var_0);
  }
}

_id_28AA() {
  self endon("death");
  self endon("entitydeleted");
  self endon("player_at_hill_trench");
  wait 0.1;

  for(;;) {
    if(scripts\sp\utility::_id_13D92(self.origin, 0.8) && distance(self.origin, level.player.origin) < 150) {
      self _meth_8278(1.75, 0.1);
    } else {
      self _meth_8278(1.0, 0.1);
    }

    wait 0.1;
  }
}

_id_8F0A() {
  scripts\engine\utility::flag_wait("hill_basement_carry_scene");
  var_0 = getspawner("hill_basement_carry_spawner", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = var_0 scripts\sp\utility::_id_10619();
  var_2._id_1FBB = "injured";
  var_2 detach(var_2.hatmodel);
  var_2 detach(var_2._id_A489);
  var_2._id_EDB8 = "Pfc. Dunford";
  var_3 = var_0 scripts\sp\utility::_id_10619();
  var_3._id_1FBB = "helper";
  var_4 = [var_2, var_3];

  foreach(var_6 in var_4) {
    var_6._id_6B14 = 1;
  }

  scripts\engine\utility::array_thread(var_4, ::_id_D8E6);
  scripts\engine\utility::array_thread(var_4, scripts\sp\maps\pearlharbor\pearlharbor_util::_id_2C16);
  scripts\engine\utility::array_thread(var_4, _id_0B0F::_id_19FC);
  var_1 scripts\sp\anim::_id_1F2C(var_4, "basement_carry_intro");
  var_1 thread scripts\sp\anim::_id_1EE7(var_4, "basement_carry_idle");
  scripts\engine\utility::flag_wait("player_at_hill_trench");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_4);
}

_id_8F14() {
  var_0 = scripts\engine\utility::getStruct("hill_basement_fireman_struct", "targetname");
  var_1 = self.spawner;
  var_1.count = 1;
  var_1 scripts\sp\utility::_id_E08B(::_id_8F14);
  scripts\engine\utility::waitframe();
  var_2 = var_1 scripts\sp\utility::_id_10619(1);
  var_2 scripts\sp\utility::_id_86E4();
  var_2 motionblurhqenable();
  var_2 detach(var_2.hatmodel);
  scripts\sp\utility::_id_86E4();
  self motionblurhqenable();
  self._id_EDB8 = "Lt. Gavrin";
  self._id_1FBB = "helper";
  var_2._id_1FBB = "wounded";
  var_3 = [self, var_2];

  foreach(var_5 in var_3) {
    var_5._id_6B14 = 1;
  }

  scripts\engine\utility::array_thread(var_3, scripts\sp\maps\pearlharbor\pearlharbor_util::_id_2C16);
  scripts\engine\utility::array_thread(var_3, _id_0B0F::_id_19FC);
  scripts\engine\utility::array_thread(var_3, ::_id_D8E6);
  var_0 scripts\sp\anim::_id_1EC1(var_3, "basement_fireman_carry");
  scripts\sp\utility::_id_127B3("hill_basement_fireman_carry_animate");
  var_0 scripts\sp\anim::_id_1F2C(var_3, "basement_fireman_carry");
  var_0 thread scripts\sp\anim::_id_1EE7(var_3, "basement_fireman_carry_idle");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_1");

  if(isDefined(var_2)) {
    var_2 delete();
  }

  self delete();
}

_id_8F19() {
  var_0 = self.spawner;
  self._id_1FBB = self.script_parameters;
  self._id_6B14 = 1;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_2C16();
  _id_0B0F::_id_19FC();
  scripts\sp\utility::_id_86E4();

  if(self._id_1FBB == "stumbler02") {
    self detach(self.hatmodel);
  }

  thread _id_D8E6();
  var_0 scripts\sp\anim::_id_1F35(self, "hill_basement_stumble");
  thread scripts\sp\anim::_id_1EEA(self, "hill_basement_stumble_idle");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_1");

  if(isDefined(self)) {
    self delete();
  }
}

_id_8F13() {
  scripts\engine\utility::trigger_on("hill_basement_ai_spawn_stumbler", "targetname");
  var_0 = getEnt("hill_basement_ai_spawn_stumbler", "targetname");

  while(!scripts\engine\utility::flag("hill_basement_player_in_second_room")) {
    var_0 waittill("trigger");
  }

  scripts\sp\utility::_id_107EA("hill_basement_exit_stumbler");
}

_id_D8E6() {
  if(!getdvarint("debug_print_anims")) {
    return;
  }
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_8F0B() {
  level.player scripts\engine\utility::delaythread(1, _id_0B0A::_id_1121E, "phstreets_hill_sun", 0);
  thread _id_8FD1();
  scripts\engine\utility::flag_set("hill_basement_start");
  scripts\engine\utility::flag_set("hill_player_in_basement");
  scripts\engine\utility::flag_set("hill_player_in_bddy_door");
  scripts\engine\utility::flag_set("hill_basement_player_in_second_room");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13D53();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_65D5("cafe");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_311B("start_hill_basement");
}

_id_8FDA() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_trench");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_trench", var_0);
  _id_0E40::_id_5542();
  _id_82DE();
  thread _id_4328();
  scripts\engine\utility::flag_set("player_approaching_hill_trench");
  thread _id_0B0F::_id_10D23("hill_vista_skyambient");
  scripts\sp\utility::_id_15F5("hill_trench_color_trig");
  scripts\sp\utility::_id_22CD("hill_trench_allies", 1);
}

_id_8FD7() {
  thread _id_8FD6();
  level.allies["admiral"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["admiral"] thread _id_8FD2();
  scripts\engine\utility::flag_wait("player_approaching_hill_trench");
  thread hill_prerun_dropships();

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  level.player scripts\sp\utility::_id_F526("normal");
  level._id_10257 = undefined;
  level._id_BB67 = 1000;
  scripts\sp\mortar::_id_2C20(0);
  scripts\engine\utility::array_thread(scripts\engine\utility::getStructArray("hill_trench_mouth_impacts", "targetname"), ::_id_8FD8);
  scripts\engine\utility::flag_wait("player_at_hill_trench");
  level._id_28A9 = undefined;
  level notify("stop_basement_radio_sounds");
  scripts\engine\utility::flag_set("hill_friendly_destroyer_spawn");
  _id_0B0F::_id_5582("skyambient_trench_flyby");
  scripts\sp\vehicle::_id_1080D("hill_friendly_destroyer");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_DD5A(1, 4700, 20);
  scripts\engine\utility::delaythread(7, scripts\sp\maps\pearlharbor\pearlharbor_util::_id_DD59);
  scripts\engine\utility::delaythread(3, scripts\sp\mortar::_id_2C1F, 0);
  thread scripts\sp\mortar::_id_2C20(4);
  scripts\engine\utility::flag_wait("hill_charge_start");
}

_id_8FD6() {
  scripts\engine\utility::flag_wait("player_at_hill_trench");
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_spawn");
  scripts\engine\utility::flag_set("hill_trench_admiral_speach");
  level.allies["admiral"] scripts\sp\utility::_id_10346("dps_adm_eclipseyouarefree");
  scripts\engine\utility::flag_set("hill_charge_trench_allies");
  scripts\engine\utility::flag_set("hill_charge_start");
}

_id_8FD3() {
  var_0 = scripts\engine\utility::getStruct("hill_trench_allies_struct", "targetname");
  var_0 scripts\sp\anim::_id_1F17(self, "hill_trench_speech_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "hill_trench_speech_intro");
  thread scripts\sp\anim::_id_1EEA(self, "hill_trench_speech_idle");
  scripts\engine\utility::flag_set("hill_admiral_at_trench");
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_spawned");
  scripts\engine\utility::flag_wait("hill_charge_start");
  self notify("stop_loop");
}

_id_8FD2() {
  scripts\sp\utility::_id_54F7();
  var_0 = scripts\engine\utility::getStruct("hill_trench_admiral_enter_path", "targetname");
  scripts\sp\utility::_id_7226(var_0);
  scripts\sp\utility::_id_61C7();
}

_id_8FD4() {
  if(self.script_noteworthy == "ally04") {
    wait 0.05;
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    return;
  }

  scripts\sp\utility::_id_B14F(1);
  self._id_1FBB = self.script_noteworthy;
  scripts\sp\utility::_id_51E1("frantic");
  scripts\sp\utility::_id_5564();
  scripts\sp\utility::_id_550C();
  scripts\sp\utility::_id_C972();

  if(isDefined(self._id_ED46)) {
    self._id_4E2A = scripts\sp\utility::_id_7DC3(self._id_ED46);
  }

  var_0 = scripts\engine\utility::getStruct("hill_trench_allies_struct", "targetname");

  if(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("reach")) {
    var_0 scripts\sp\anim::_id_1F17(self, "hill_trench_ally_intro");
  }

  var_1 = getanimlength(scripts\sp\utility::_id_7DC1("hill_trench_ally_intro"));
  var_0 thread scripts\sp\anim::_id_1F35(self, "hill_trench_ally_intro");
  scripts\sp\utility::_id_178D(scripts\engine\utility::_timeout, var_1);
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "hill_charge_trench_allies");
  scripts\sp\utility::_id_57D6();
  var_0 thread scripts\sp\anim::_id_1EEA(self, "hill_trench_ally_idle", self._id_1FBB + "_stop_loop");
  scripts\engine\utility::flag_wait("hill_charge_trench_allies");

  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
  }

  var_0 notify(self._id_1FBB + "_stop_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "hill_trench_ally_exit");
  var_0 notify(self._id_1FBB + "_stop_loop");
  var_2 = scripts\sp\utility::_id_7A96();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_2);
}

hill_prerun_dropships() {
  var_0 = getEntArray("trigger_multiple_spawn", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target) && issubstr(var_2.target, "auto2440")) {
      var_2 notify("trigger");
    }
  }
}

_id_8FD9() {
  self endon("death");
  var_0 = self.spawner;
  self.grenadeammo = 0;
  scripts\asm\asm::asm_setdemeanoranimoverride("combat", "move", scripts\sp\utility::_id_7DC3("c6_red_walk"));
  self.attackeraccuracy = 5000000;
  self.dontmelee = 1;

  if(isDefined(var_0.script_animation)) {
    scripts\sp\utility::_id_B14F();
    self._id_1FBB = "c6";
    self.ignoreall = 1;
    scripts\engine\utility::waitframe();
    var_1 = var_0.script_animation;
    var_2 = scripts\sp\utility::_id_7A8E();
    var_3 = var_2 scripts\sp\utility::_id_7A96();
    var_4 = var_2 scripts\sp\utility::_id_10619(1, 1);
    var_4.dontmelee = 1;
    var_4.ignoreme = 1;
    var_4._id_1FBB = "soldier";
    var_5 = [self, var_4];
    var_3 scripts\sp\anim::_id_1F2C(var_5, var_1);
    self.ignoreall = 0;
  }
}

_id_8FD8() {
  while(!scripts\engine\utility::flag("hill_run_player_through_gate")) {
    wait(randomfloatrange(0.35, 0.55));
    var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(self.origin, self.radius);
    var_0 = var_0 + (0, 0, 500);
    var_0 = scripts\sp\utility::_id_864C(var_0);
    playworldsound("phstreets_hill_dirt_bullet_impact", var_0);
    playFX(scripts\engine\utility::getfx("hill_bullet_impact"), var_0, (0, 0, 1));
  }
}

_id_D277() {
  level endon("hill_charge_start");
  var_0 = getEnt("entering_hill_early_trig", "targetname");

  for(;;) {
    var_0 waittill("trigger");

    while(level.player istouching(var_0)) {
      wait(randomfloatrange(0.5, 2));

      if(!level.player istouching(var_0)) {
        break;
      }

      var_1 = anglesToForward(level.player.angles);
      var_2 = anglestoright(level.player.angles);
      var_3 = level.player getEye();
      var_3 = var_3 + var_1 * randomfloatrange(100, 300);

      if(scripts\engine\utility::cointoss()) {
        var_2 = var_2 * -1;
      }

      var_3 = var_3 + var_2 * randomfloatrange(0, 50);
      var_3 = scripts\sp\utility::_id_864C(var_3);
      playFX(scripts\engine\utility::getfx("hill_mortar_impact"), var_3);
      thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_explo", var_3);
      var_4 = 50;

      if(scripts\engine\utility::flag("hill_charge_start")) {
        var_4 = 50000;
      }

      radiusdamage(var_3, 300, var_4, var_4 / 2);
    }
  }
}

_id_8F72() {
  level._id_8F72 = self;
  self._id_12FB8 = 1;
  self._id_12FBA = 1;
  self._id_55A4 = 0;
  scripts\sp\vehicle::_id_8441();
  self castdistantshadows();
  thread _id_0BB8::_id_39CD("heavy");
  _id_0B0F::_id_1D84();
  scripts\engine\utility::flag_set("hill_friendly_destroyer_spawned");
  thread _id_8F75();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self, "tag_origin", (0, 0, 500), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_ship_damage_un_destroyer_01"), var_0, "tag_origin");
  scripts\engine\utility::exploder("bgmissile");
  thread _id_7594();
  thread _id_8F74();
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_fire");
  thread _id_0BB6::_id_3983(level._id_8F5F);
  wait 3;
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_first_goal");
  thread _id_0BB6::_id_3966(1, 1, level._id_8F5F);
  self notify("kill_rumble_forever");
  var_1 = getvehiclenode("hill_friendly_destroyer_continue_path", "targetname");
  scripts\sp\vehicle::_id_2471(var_1);
  var_2 = 45;
  var_3 = 30;
  scripts\engine\utility::delaythread(var_2, _id_0BB6::_id_3967);

  foreach(var_5 in self.turrets["cap_turret_cannon_large_un"]) {
    var_5 scripts\engine\utility::delaycall(var_3, ::delete);
  }

  self notsolid();
  self waittill("reached_end_node");
  var_0 delete();
  _id_0BA9::_id_397B();
}

_id_8F75() {
  wait 0.25;
  self playSound("scn_phstreets_hill_eclipse_flyin");
  level.player setsoundsubmix("capital_passby_heavy", 1.0);
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phstreets_hill_eclipse_flyin_debris_lr");
}

_id_7594() {
  wait 1.5;
}

_id_8F74() {
  while(!scripts\engine\utility::flag("hill_friendly_destroyer_first_goal")) {
    foreach(var_1 in self.turrets) {
      foreach(var_3 in var_1) {
        var_3._id_FEAD = 0;
      }
    }

    _id_0BB6::_id_3984(level._id_8F5F);
    wait(randomfloatrange(0.5, 1));
  }
}

_id_8F73() {
  if(!isDefined(level._id_8F5F._id_B8B2)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  var_1 = var_0 * -1;
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_4 = 500;
  var_5 = 0;

  for(var_6 = 0; var_6 < 15; var_6++) {
    var_7 = self.origin;
    var_7 = var_7 + var_2 * 1500;
    var_7 = var_7 + var_3 * 500;
    var_7 = var_7 + var_1 * 6000;
    var_7 = var_7 + var_0 * var_5;
    var_8 = scripts\engine\utility::spawn_tag_origin();
    var_8.origin = level._id_8F5F gettagorigin(scripts\engine\utility::random(level._id_8F5F._id_B8B2["r"]));
    var_9 = scripts\engine\utility::spawn_tag_origin();
    var_9.origin = var_7;
    var_9 thread _id_B7EB(var_8);
    var_9 thread _id_0B76::_id_A332(var_8, 1, self, undefined, var_4, undefined, undefined, undefined, var_4);
    wait(randomfloatrange(0.2, 0.4));
    var_5 = var_5 + 1000;
  }
}

_id_B7EB(var_0) {
  self waittill("death");
  var_0 delete();
}

_id_8FDC() {
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_first_goal");
  self._id_12FB8 = 1;
  self._id_12FBA = 1;
}

_id_8FDB() {
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_first_goal");
  var_0 = spawnStruct();
  var_0._id_6D20 = 0.05;
  var_0._id_13535 = [3, 5];
  var_0._id_B46E = 12;
  var_0._id_6CF8 = _id_0BB6::_id_6D0C;
  level._id_39DD["missile_tube_ca"]._id_10241 = var_0;
}

_id_8F5F() {
  level._id_39B6 = 0;
  level._id_8F5F = self;
  self notify("kill_rumble_forever");
  self castdistantshadows();
  self._id_12FB8 = 1;
  self._id_12FBA = 1;
  _id_0B0F::_id_1D84();

  foreach(var_1 in self._id_B8B4["r"]) {
    var_1._id_FF3E = 1;
  }

  thread _id_0B0F::_id_3987(self._id_B8B4["r"], [1, 2], [0.15, 3], "stop_ambient_missiles", "hill_capship_missile_trails", "vfx_ph_hill_capship_missile_impact", "phstreets_hill_mortar_explo");
  scripts\engine\utility::flag_wait("hill_allies_start");
  level._id_39B6 = 1;
  scripts\engine\utility::flag_wait("hill_player_in_bddy_door");

  foreach(var_4 in level._id_28A6) {
    var_4 thread _id_28AA();
  }

  self notify("stop_ambient_missiles");
  scripts\engine\utility::flag_wait("hill_basement_player_in_second_room");
  level._id_39B6 = 0;
  thread _id_0B0F::_id_3987(self._id_B8B4["l"], [1, 3], [0.5, 4], "stop_ambient_missiles", "hill_capship_missile_trails", "vfx_ph_hill_capship_missile_impact", "phstreets_hill_mortar_explo");
  thread _id_0B0F::_id_3987(self._id_B8B4["ps"], 1, [1, 2], "stop_playspace_missiles", "hill_capship_missile_trails", "vfx_ph_hill_capship_missile_impact", "phstreets_hill_mortar_explo");
  scripts\engine\utility::flag_wait("player_approaching_hill_trench");
  level._id_39B6 = 1;
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_spawn");
  self notify("stop_ambient_missiles");
  self notify("stop_playspace_missiles");
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_fire");
  wait 2;
  thread _id_0BB6::_id_3966(1, 1, level._id_8F72);
  scripts\engine\utility::flag_wait("hill_friendly_destroyer_first_goal");
  var_6 = 45;
  var_7 = 30;
  scripts\engine\utility::delaythread(var_6, _id_0BB6::_id_3967);

  foreach(var_9 in self.turrets["cap_turret_cannon_large_ca"]) {
    var_9 scripts\engine\utility::delaycall(var_7, ::delete);
  }

  self waittill("reached_end_node");
  _id_0BA9::_id_397B();
  level._id_8F5F = undefined;
}

_id_8F60() {
  self notsolid();
  self._id_12FB8 = 1;
  self._id_12FBA = 1;
  _id_0BB6::_id_39E9(1);
}

_id_8FD5() {
  _id_0B0F::_id_5582("skyambient_trench_flyby");
  scripts\engine\utility::flag_set("hill_friendly_destroyer_spawn");
  scripts\engine\utility::flag_set("player_approaching_hill_trench");
  scripts\engine\utility::flag_set("player_at_hill_trench");
  scripts\engine\utility::flag_set("hill_charge_trench_allies");
}

_id_8FBE() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_run");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_run", var_0);
  thread _id_4328();
  thread scripts\sp\mortar::_id_2C20(4);
  scripts\sp\utility::_id_22CD("hill_trench_allies", 1);
  var_1 = scripts\sp\vehicle::_id_1080D("hill_friendly_destroyer");
  var_2 = getvehiclenode("hill_friendly_destroyer_run_start_node", "script_noteworthy");
  var_1 thread scripts\sp\vehicle::_id_2471(var_2);
  scripts\engine\utility::array_thread(scripts\engine\utility::getStructArray("hill_trench_mouth_impacts", "targetname"), ::_id_8FD8);
  level.allies["admiral"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["salter"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["eth3n"] scripts\sp\utility::_id_51E1("sprint");
}

_id_8FBA() {
  setsaveddvar("player_sprintUnlimited", 1);
  thread scripts\sp\utility::_id_2670();
  setmusicstate("mx_072_exit_bunker");
  thread _id_8FAD();
  thread _id_8FA5();
  thread _id_11672();
  thread _id_8FAA();
  thread _id_3E7C();
  thread _id_8F05();
  thread _id_8FBD();
  thread _id_8FB5();
  scripts\engine\utility::flag_set("hill_charge_start");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_54F7);
  level.allies["admiral"] scripts\engine\utility::delaythread(1, ::_id_8FB9);
  level.allies["eth3n"] scripts\engine\utility::delaythread(0.15, ::_id_8FB9);
  level.allies["salter"] scripts\engine\utility::delaythread(2, ::_id_8FB9);
  level._id_BB59 = 50000;
  scripts\engine\utility::flag_wait("hill_run_player_through_gate");
  level._id_B460 = 0;
  scripts\engine\utility::exploder("hill_xplode_01");
  scripts\engine\utility::delaythread(3, ::_id_8F99);
  thread _id_8FAC();
  scripts\engine\utility::array_thread(scripts\engine\utility::getStructArray("hill_run_fake_tracers", "targetname"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_6B06, "hill_run_checkpoint_4");
  scripts\engine\utility::flag_set("hill_friendly_destroyer_continue");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_1");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_2");
  scripts\engine\utility::delaythread(4, scripts\sp\vehicle::_id_1080D, "hill_run_jackal_strafe_02");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_3");
  scripts\sp\utility::_id_127B3("hill_run_droppods_spawn");
  thread scripts\sp\vehicle::_id_1080E("hill_run_droppods");
  scripts\engine\utility::flag_wait("hill_run_complete");
}

_id_8FAD() {
  level.player endon("death");
  thread _id_8FAE();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = (75359, 51976, -31600);
  level.player thread scripts\sp\utility::_id_D090("ges_ph_tower", var_0);
  thread scripts\sp\utility::_id_10350("dps_plr_letsmovegogogo");
  level.allies["salter"] scripts\engine\utility::delaythread(3.5, scripts\sp\utility::_id_10346, "phstreets_slt_tearout");
  level.allies["admiral"] scripts\engine\utility::delaythread(4.5, scripts\sp\utility::_id_10346, "phstreets_adm_movehustle");
  scripts\engine\utility::flag_wait("hill_run_checkpoint_1");
  playworldsound("phstreets_unm2_dontstop", level.player.origin);
  var_1 = scripts\sp\utility::_id_7EB4(level.player.origin, getaiarray("allies"), 500);

  if(isDefined(var_1)) {
    scripts\engine\utility::noself_delaycall(1.5, ::playworldsound, "phstreets_unm2_gogogo", var_1.origin);
  }

  scripts\engine\utility::flag_wait("hill_dropship_cockpit_roll");
  wait 3.75;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_admiralwatchit");
  scripts\engine\utility::flag_wait("hill_dropship_cockpit_roll_done");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_goodeyeethan");
  wait 5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_onyoulieutenant");
}

_id_8FA5() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_0 scripts\sp\utility::_id_E7C9(0.15, 3);
  scripts\engine\utility::flag_wait("hill_run_complete");
  wait 2;
  var_0 scripts\sp\utility::_id_E7C9(0, 4);
  var_0 delete();
}

_id_8FAE() {
  scripts\engine\utility::flag_wait("hill_run_checkpoint_2");
  var_0 = (70646, 46892, -34338);
  thread scripts\engine\utility::play_sound_in_space("phstreets_un1_theyreholdintheline", var_0);
  wait 2;
  scripts\engine\utility::play_sound_in_space("phstreets_un1_keepmoving", (72520, 45964, -34401.1));
}

_id_11672() {
  wait 2;
  var_0 = [];
  var_0[0] = "phstreets_unm3_getupthathill";
  var_0[1] = "phstreets_unm_moveit";
  var_0[2] = "un_" + randomintrange(1, 5) + "_inform_incoming_mg";

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = getaiarray("allies");
    var_2 = scripts\engine\utility::array_remove_array(var_2, level.allies);
    var_3 = scripts\engine\utility::getclosest(level.player.origin, var_2);
    var_3 thread scripts\sp\utility::play_sound_on_entity(var_0[var_1]);
    wait(randomfloatrange(1.0, 1.5));
  }
}

_id_8FBD() {
  scripts\engine\utility::flag_wait("hill_run_player_through_gate");
  wait 2;
  thread _id_8FBC(6, 4, "hill_run_checkpoint_1");
  _id_8FBF(550, 25, 8, "hill_run_checkpoint_1");
  thread _id_8FBC(6, 4, "hill_run_checkpoint_2");
  _id_8FBF(550, 25, 6, "hill_run_checkpoint_2");
  thread _id_8FBC(6, 4, "hill_run_checkpoint_3");
  _id_8FBF(300, 25, 3, "hill_run_checkpoint_3");
  _id_8FBF(600, 25, 5, "hill_run_complete");
}

_id_8FBF(var_0, var_1, var_2, var_3) {
  var_4 = var_2 / 0.05;
  var_5 = var_0 - var_1;
  var_6 = var_5 / var_4;
  var_7 = (72536, 47696, -33992);
  var_8 = getEntArray("hill_run_player_progress_reset", "targetname");
  var_9 = 0;
  var_10 = var_0;
  var_11 = level.player.origin;
  var_12 = 1000;
  var_13 = gettime();

  while(!scripts\engine\utility::flag(var_3)) {
    foreach(var_15 in var_8) {
      if(level.player istouching(var_15)) {
        var_10 = var_0;
        var_9 = 0;
        break;
      }
    }

    var_17 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_7, 512);

    if(gettime() - var_13 > var_12) {
      var_18 = scripts\common\trace::ray_trace(var_17, level.player.origin);
      var_11 = var_18["position"];
      var_13 = gettime();
    }

    var_11 = var_11 + (0, 0, 500);
    var_11 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_11, var_10);
    var_19 = scripts\sp\utility::_id_864C(var_11) + (0, 0, randomintrange(0, 64));
    magicbullet("sdf_mg_turret_phhill", var_7, var_19);

    if(!scripts\engine\utility::flag("pause_player_hotbox_tracers")) {
      bullettracer(var_17, var_19, "sdf_mg_turret_phhill");
    }

    var_20 = randomintrange(1, 8);

    for(var_21 = 0; var_21 < var_20; var_21++) {
      wait 0.05;

      if(var_9 < var_4) {
        var_10 = var_10 - var_6;

        if(var_10 < var_1) {
          var_10 = var_1;
        }

        var_9++;
      }
    }
  }
}

_id_8FBC(var_0, var_1, var_2) {
  level endon(var_2);
  wait(var_0);
  var_1 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    wait(randomfloatrange(0.5, 3));
    var_4 = level.player getEye();

    if(!scripts\common\trace::ray_trace_passed(var_4, var_4 + (0, 0, 300), level.player)) {
      break;
    }

    var_5 = anglesToForward(level.player.angles);
    var_6 = anglestoright(level.player.angles);
    var_4 = var_4 + var_5 * randomfloatrange(100, 300);

    if(scripts\engine\utility::cointoss()) {
      var_6 = var_6 * -1;
    }

    var_4 = var_4 + var_6 * randomfloatrange(0, 50);
    var_4 = scripts\sp\utility::_id_864C(var_4);
    playFX(scripts\engine\utility::getfx("hill_mortar_impact"), var_4);
    playFX(scripts\engine\utility::getfx("vfx_hillcharge_camcentric_debris_grenhit_01"), level.player.origin);
    thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_explo", var_4);

    if(distance2dsquared(var_4, level.player.origin) < squared(1000)) {
      level.player playRumbleOnEntity("artillery_rumble");
      earthquake(0.2, 0.5, var_4, 1000);
    }

    var_7 = 50;

    if(gettime() - var_3 >= var_1) {
      var_7 = 50000;
    }

    radiusdamage(var_4, 300, var_7, var_7 / 2);
  }
}

_id_8F99() {
  var_0 = anglesToForward(level.player.angles);
  var_1 = anglestoright(level.player.angles);
  var_2 = level.player getEye();
  var_3 = randomfloatrange(400, 450);

  if(level.player issprinting()) {
    var_3 = randomfloatrange(450, 500);
  }

  var_2 = var_2 + var_0 * var_3;

  if(scripts\engine\utility::cointoss()) {
    var_1 = var_1 * -1;
  }

  var_2 = var_2 + var_1 * randomfloatrange(0, 35);
  var_2 = scripts\sp\utility::_id_864C(var_2);
  playFX(scripts\engine\utility::getfx("hill_mortar_incoming"), var_2);
  thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_incoming", var_2);
  wait 0.8;

  if(!scripts\common\trace::ray_trace_passed(var_2, var_2 + (0, 0, 300), level.player)) {
    return;
  }
  playFX(scripts\engine\utility::getfx("hill_mortar_impact"), var_2);
  playFXOnTag(scripts\engine\utility::getfx("vfx_hillcharge_camcentric_debris_grenhit_01"), level.player, "tag_eye");
  thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_explo", var_2);
  thread scripts\sp\utility::_id_54EF(var_2);
  playrumbleonposition("heavy_1s", var_2);
  level.player viewkick(25, var_2);
  level.player thread scripts\sp\utility::_id_D090("ges_frag_block");
  var_4 = 2;
  level.player shellshock("default_nosound", var_4);
  wait(var_4);
  level.player stopshellshock();
}

_id_8F05() {
  level endon("hill_run_complete");
  var_0 = (71056, 45264, -34400);
  var_1 = (71248, 45536, -34400);
  var_2 = spawn("trigger_radius", var_1, 0, 500, 56);
  var_2 waittill("trigger");
  var_2 delete();
  playworldsound("scn_phstreets_bullet_spray_apc", var_0);
}

_id_8FB9() {
  scripts\sp\utility::_id_51E1("sprint");
  scripts\sp\utility::_id_54F7();
  self.ignoreall = 1;
  self.ignoreme = 1;
  scripts\sp\utility::_id_550C();
  scripts\sp\utility::_id_C972();
  scripts\sp\utility::_id_5564();
  var_0 = self.grenadeammo;
  self.grenadeammo = 0;

  if(self == level.allies["salter"]) {
    scripts\engine\utility::flag_wait("hill_run_salter_start");
  }

  var_1 = scripts\engine\utility::getStruct("hero_run_path_" + self._id_1FBB, "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_1);
  self.ignoreall = 0;
  self.ignoreme = 0;
  scripts\sp\utility::_id_4145();
  scripts\sp\utility::_id_6224();
  scripts\sp\utility::_id_61DF();
  scripts\sp\utility::_id_C970();
  self _meth_8250(0);
  self.grenadeammo = var_0;
  scripts\engine\utility::flag_wait("hill_combat_color_movement_start");
  scripts\sp\utility::_id_61C7();
}

_id_8F04() {
  var_0 = self.spawner;
  self endon("death");
  self endon("stop_hill_ally_run_logic");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_B14F(1);

  if(isDefined(var_0._id_ED46)) {
    self._id_4E2A = scripts\sp\utility::_id_7DC3(var_0._id_ED46);
  }

  level._id_BB69 = scripts\engine\utility::array_add(level._id_BB69, self);
  self setCanDamage(0);
  scripts\sp\utility::_id_5564();
  scripts\sp\utility::_id_550C();
  scripts\sp\utility::_id_C972();
  var_1 = self.grenadeammo;
  self.grenadeammo = 0;
  var_2 = 1;

  if(var_0 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("hill_cockpit_redshirt1")) {
    self._id_1FBB = "redshirt1";
    level._id_8F3D = self;
  } else if(var_0 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("hill_cockpit_redshirt2")) {
    self._id_1FBB = "redshirt2";
    level._id_8F3E = self;
  } else if(var_0 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("hill_cockpit_failure")) {
    level._id_8F3C = self;
    self._id_1FBB = "failure";
  } else
    var_2 = 0;

  var_3 = var_0 scripts\sp\utility::_id_7A96();

  if(isDefined(var_3)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_3);
  }

  level._id_BB69 = scripts\engine\utility::array_remove(level._id_BB69, self);
  scripts\sp\utility::_id_51E1("frantic");

  if(isDefined(self._id_B14F) && !var_2) {
    scripts\sp\utility::_id_1101B();
  }

  self setCanDamage(1);
  scripts\sp\utility::_id_6224();
  scripts\sp\utility::_id_61DF();
  scripts\sp\utility::_id_C970();
  self.providecoveringfire = 0;
  self.grenadeammo = var_1;

  if(!isDefined(self._id_EDAD) && !isDefined(self._id_C3BE)) {
    return;
  }
  thread _id_8F4C();
  scripts\engine\utility::flag_wait("hill_combat_color_movement_start");
  scripts\sp\utility::_id_61C7();
}

_id_8FB5() {
  level._id_8FB5 = [];
  _id_8F6A("hill_combat_right_wall_fakeactors", "right");
  _id_8F6A("hill_combat_left_wall_fakeactors", "left");
  _id_8F6A("hill_combat_center_fakeactors", "center");
  scripts\engine\utility::flag_wait("hill_run_player_through_gate");
  scripts\engine\utility::delaythread(0, ::_id_8FB4, "right", "squad1");
  scripts\engine\utility::delaythread(0, ::_id_8FB4, "left", "squad1");
  wait 1;
  thread _id_8FB3("right", ["squad0", "squad1"]);
  thread _id_8FB3("left", ["squad1", "squad2"]);
  scripts\engine\utility::flag_wait("hill_run_checkpoint_1");
  thread _id_8FB3("center", ["squad0"]);
  scripts\engine\utility::flag_wait("hill_run_checkpoint_2");
  thread _id_8FB3("left", ["squad1", "squad2", "squad3"]);
  scripts\engine\utility::flag_wait("hill_run_checkpoint_3");
  thread _id_8FB3("right", ["squad0", "squad1", "squad2", "squad3", "squad4"]);
  scripts\engine\utility::flag_wait("hill_run_complete");
  scripts\engine\utility::flag_wait("hill_combat_downed_dropship_enemies_retreat");
  level notify("stop_all_fakeactors");
}

_id_8FB3(var_0, var_1) {
  level notify("stop_fakeactors_" + var_0);
  level endon("stop_fakeactors_" + var_0);
  level endon("stop_all_fakeactors");
  var_2 = undefined;
  var_3 = scripts\engine\utility::array_randomize(var_1);

  for(;;) {
    foreach(var_5 in var_3) {
      thread _id_8FB4(var_0, var_5);

      if(scripts\engine\utility::cointoss()) {
        wait(randomintrange(2, 4));
      } else {
        wait(randomintrange(4, 8));
      }

      var_2 = var_5;
    }

    var_3 = undefined;
    var_3 = scripts\engine\utility::array_randomize(var_1);
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);
    var_3 = scripts\engine\utility::array_add(var_3, var_2);
  }
}

_id_8FB4(var_0, var_1) {
  level endon("stop_fakeactors_" + var_0);
  var_2 = level._id_8FB5[var_0][var_1];
  var_3 = scripts\engine\utility::array_randomize(var_2);
  var_4 = 0;
  var_5 = randomintrange(1, var_2.size);

  foreach(var_9, var_7 in var_3) {
    if(var_9 > var_5) {
      break;
    }

    if(var_0 == "center" && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_7.origin, 0)) {
      continue;
    }
    var_8 = var_7 scripts\sp\utility::_id_10619();

    if(!isDefined(var_8)) {
      continue;
    }
    var_8._id_E812 = 0.9;
    var_8._id_E811 = 1.25;

    if(!var_4 && randomint(100) <= 25) {
      var_4 = 1;
    }

    var_8 thread _id_8FB1(var_4);
    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_8FB1(var_0) {
  self endon("mortar_death");
  self setCanDamage(0);
  scripts\sp\utility::_id_F2A8(0);
  wait 3;
  self setCanDamage(1);
  scripts\sp\utility::_id_F2A8(1);

  if(var_0) {
    scripts\engine\utility::delaythread(randomfloatrange(0.25, 3), ::_id_8FB2);
  } else {
    scripts\engine\utility::delaycall(randomfloatrange(0.25, 3), ::_meth_81D0);
  }

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C3();
}

_id_8FB2() {
  self endon("death");
  self notify("mortar_death");
  self.noragdoll = undefined;
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.script_fxid = "hill_mortar_impact_instant";
  var_0 scripts\sp\mortar::_id_2C1E();
  scripts\sp\utility::_id_54C6();
}

_id_8F6A(var_0, var_1) {
  var_2 = [];
  var_3 = getspawnerarray(var_0);

  foreach(var_5 in var_3) {
    var_6 = var_5.script_parameters;

    if(!isDefined(var_2[var_6])) {
      var_2[var_6] = [];
    }

    var_2[var_6] = ::scripts\engine\utility::array_add(var_2[var_6], var_5);
  }

  level._id_8FB5[var_1] = var_2;
}

_id_8F6B() {
  level._id_8F6D = [];
  var_0 = scripts\engine\utility::getStructArray("hill_run_fakeactor_strafes", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_110D6 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_2.spawners = getspawnerarray(var_2.target);
    level._id_8F6D[var_2.script_noteworthy] = var_2;
  }
}

_id_8F6C(var_0) {
  var_1 = level._id_8F6D[var_0];
  var_2 = var_1._id_110D6;
  var_3 = scripts\sp\utility::_id_22C6(var_1.spawners, undefined, 0);

  if(var_3.size == 1) {
    return;
  }
  var_4 = distance(var_1.origin, var_2.origin);
  var_5 = 20;
  var_6 = int(var_4 / var_5);
  var_7 = var_1.origin;
  var_8 = vectorNormalize(var_2.origin - var_1.origin);
  var_9 = var_1.radius;

  for(var_10 = 0; var_10 < var_6; var_10++) {
    var_11 = randomintrange(1, 3);

    for(var_12 = 0; var_12 < var_11; var_12++) {
      var_13 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_7, var_9);
      var_13 = scripts\sp\utility::_id_864C(var_13, (0, 0, 1));
      playworldsound("phstreets_hill_dirt_bullet_impact_jackal", var_13);
      playFX(scripts\engine\utility::getfx("hill_jackal_bullet_impact"), var_13, (0, 0, 1));
      wait 0.05;
    }

    radiusdamage(var_7, var_9, 9999, 9999);
    var_7 = var_7 + var_8 * var_5;
  }
}

_id_8FC3() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(0.15, 0.25));
    var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(self.origin, 5, 50);
    var_0 = var_0 + (0, 0, 500);
    var_0 = scripts\sp\utility::_id_864C(var_0);
    playworldsound("phstreets_hill_dirt_bullet_impact", var_0);
    playFX(scripts\engine\utility::getfx("hill_bullet_impact"), var_0, (0, 0, 1));
  }
}

_id_8FAC() {
  var_0 = getEntArray("hill_run_mg_trigs", "targetname");

  while(!scripts\engine\utility::flag("hill_run_complete")) {
    wait(randomfloatrange(0.65, 1.5));
    var_1 = 230;

    foreach(var_3 in var_0) {
      if(level.player istouching(var_3)) {
        var_1 = int(var_3.script_angles[1]);
        break;
      }
    }

    thread _id_CD48(var_1);
  }
}

_id_CD48(var_0) {
  var_1 = anglesToForward(level.player.angles);
  var_2 = anglestoright(level.player.angles);

  if(scripts\engine\utility::cointoss()) {
    var_2 = var_2 * -1;
  }

  var_3 = level.player.origin;
  var_3 = var_3 + var_1 * randomintrange(250, 400);
  var_3 = var_3 + var_2 * randomintrange(0, 150);
  var_0 = randomintrange(var_0 - 25, var_0 + 25);
  var_4 = anglesToForward((0, var_0, 0));
  var_5 = randomintrange(175, 275);
  var_6 = var_3 + var_4 * var_5;
  var_7 = randomintrange(50, 100);
  var_8 = int(var_5 / var_7);
  var_9 = var_3;

  for(var_10 = 0; var_10 < var_8; var_10++) {
    var_9 = var_9 + (0, 0, 500);
    var_9 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_9, 18);
    var_9 = scripts\sp\utility::_id_864C(var_9);
    magicbullet("generic_mg_turret_nosound", var_9 + (0, 0, 1), var_9);
    var_9 = var_9 + var_4 * var_7;
    wait(randomfloatrange(0.05, 0.15));
  }
}

_id_8F58() {
  var_0 = getEnt("hill_dropship_dead_guys_spawner", "targetname");
  var_1 = scripts\engine\utility::getStructArray("hill_comat_dropship_seats", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\utility::_id_10639("dropship_seat");

    if(isDefined(var_3.target)) {
      var_5 = scripts\engine\utility::getStruct(var_3.target, "targetname");
      var_6 = var_0 scripts\sp\utility::_id_10619(1);
      var_6 dontcastshadows();
      var_5 thread scripts\sp\anim::_id_1ECC(var_6, var_5.animation);
    }

    var_3 thread scripts\sp\anim::_id_1EEA(var_4, var_3.animation);
    var_4 dontcastshadows();
    scripts\engine\utility::waitframe();
  }
}

_id_8F96(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  scripts\engine\utility::flag_set("pause_player_hotbox_tracers");
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_5 = distance(var_3.origin, var_4.origin);
  var_6 = 20;
  var_7 = int(var_5 / var_6);
  var_8 = var_3.origin;
  var_9 = vectorNormalize(var_4.origin - var_3.origin);
  var_10 = var_3.radius;
  var_11 = scripts\engine\utility::spawn_tag_origin();

  if(var_0 == "hill_run_strafe01") {
    scripts\engine\utility::delaycall(2.3, ::playsound, "phstreets_hill_jackal_sdf_strafe_01");
    level.player scripts\engine\utility::delaycall(2.3, ::setsoundsubmix, "jackal_strafe");
    level.player scripts\engine\utility::delaycall(2.9, ::clearsoundsubmix);
  } else
    scripts\engine\utility::delaycall(1, ::playsound, "phstreets_hill_jackal_sdf_strafe_02");

  for(var_12 = 0; var_12 < var_7; var_12++) {
    var_13 = randomintrange(1, 3);

    for(var_14 = 0; var_14 < var_13; var_14++) {
      var_15 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_8, var_10);
      var_15 = scripts\sp\utility::_id_864C(var_15, (0, 0, 1));
      var_16 = self gettagorigin(self._id_284C[self._id_284B]);
      var_17 = vectorNormalize(var_15 - var_16);
      var_18 = scripts\common\trace::ray_trace(var_16, var_15, self);

      if(isDefined(var_18["entity"]) && var_18["entity"] == level._id_E67E) {
        playFX(scripts\engine\utility::getfx("hill_c6_bullet_impact"), var_18["position"], var_18["normal"]);
      }

      if(var_14 == 0) {
        var_19 = distance(var_16, var_15) / var_2;
        var_20 = var_16 + var_17 * var_19;
        bullettracer(var_20, var_15, "sdf_mg_turret_phhill");
      }

      var_11.origin = var_15;
      _id_0C1B::_id_6D30(var_11);
      playworldsound("phstreets_hill_dirt_bullet_impact_jackal", var_15);
      playFX(scripts\engine\utility::getfx("hill_jackal_bullet_impact"), var_15, (0, 0, 1));

      if(distance(var_8, level.allies["eth3n"].origin) < var_10 * 2) {
        var_18 = scripts\common\trace::ray_trace(var_16, level.allies["eth3n"].origin + (0, 0, randomintrange(5, 50)));

        if(isDefined(var_18["entity"]) && var_18["entity"] == level.allies["eth3n"]) {
          playFX(scripts\engine\utility::getfx("hill_c6_bullet_impact"), var_18["position"], var_18["normal"]);
        }
      }

      wait 0.05;
    }

    if(distance(level.player.origin, var_8) < var_10) {
      level.player dodamage(randomintrange(2, 5), var_8);
    }

    var_8 = var_8 + var_9 * var_6;
  }

  var_11 delete();
  scripts\engine\utility::flag_clear("pause_player_hotbox_tracers");
}

_id_8F98(var_0, var_1) {
  level endon(var_0._id_EDA0);

  for(;;) {
    var_2 = var_0.origin;
    var_3 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_1.origin, var_1.radius, var_1.height);
    var_4 = gettime();
    var_5 = randomfloatrange(1, 2);
    var_5 = var_5 * 1000;

    while(gettime() - var_4 < var_5) {
      var_6 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_3, 300);
      var_7 = vectorNormalize(var_6 - var_2);
      playFX(scripts\engine\utility::getfx("hill_run_tracer"), var_2, var_7);
      wait(randomfloatrange(0.05, 0.1));
    }
  }
}

_id_8FA9() {
  var_0 = self.spawner;
  var_1 = var_0 scripts\sp\utility::_id_7A8E();
  wait 1.5;
  var_2 = var_1 scripts\sp\vehicle::_id_1080B();
  self waittill("hill_chase_jackal_explode");

  if(isDefined(var_0._id_ED46)) {
    self._id_72B1 = scripts\sp\utility::_id_7DC3(var_0._id_ED46);
  }

  self notify("death");
}

_id_8F62() {
  scripts\sp\vehicle::_id_8441();
  self notsolid();
  thread _id_8F64();
  scripts\engine\utility::array_thread(self._id_E4FB, ::_id_8F63);
  var_0 = getEnt("hill_mg_dropship_lmg_spawner", "targetname");
  var_1 = scripts\engine\utility::getStruct("hill_mg_dropship_lmg_spot", "targetname");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(self);
  var_3 = var_0 scripts\sp\utility::_id_10619(1);

  if(isDefined(var_3)) {
    var_3.noragdoll = 1;
    var_3.nocorpsedelete = 1;
    var_3.ignoreme = 1;
    var_3.ignoreall = 1;
    var_3 linkTo(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_4 = scripts\engine\utility::getStruct("hill_enemy_mg_dropship_doors_open", "script_noteworthy");
  var_4 waittill("trigger");
  _id_0BBD::_id_5DB9("left");

  if(isDefined(var_3) && isalive(var_3)) {
    var_3.health = int(var_3.health / 2);
    var_3.ignoreme = 0;
    var_3.ignoreall = 0;
    var_3 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_135F1, "death", 14);
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "hill_combat_steep_hill_enemies_retreat");
    scripts\sp\utility::_id_57D6();

    if(isDefined(var_3) && isalive(var_3)) {
      var_3 scripts\sp\utility::_id_54C6();
    }
  }

  if(!scripts\engine\utility::flag("hill_combat_steep_hill_enemies_retreat")) {
    wait 2;
  }

  if(self._id_E4FB.size) {
    scripts\sp\utility::_id_65E3("unloaded");
  }

  scripts\engine\utility::flag_set("hill_enemy_mg_dropship_guy_dead");
  self waittill("entitydeleted");

  if(isDefined(var_3)) {
    var_3 delete();
  }

  var_2 delete();
}

_id_8F64() {
  scripts\engine\utility::waitframe();

  if(self._id_E4FB.size) {
    scripts\sp\utility::_id_65E3("unloaded");
  }

  scripts\engine\utility::flag_set("hill_mg_dropship_unloaded");
}

_id_8F5B() {}

_id_8F63() {
  var_0 = scripts\sp\utility::_id_7A8E();
  self waittill("death");

  if(isDefined(var_0)) {
    thread scripts\sp\utility::_id_6F54([var_0]);
  }
}

_id_8FB0() {
  if(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("center_turret")) {
    level._id_8FA8 = self;
  }

  self setdefaultdroppitch(-15);
  self makeunusable();
  scripts\engine\utility::flag_wait("player_approaching_hill_trench");

  if(!isDefined(self)) {
    return;
  }
  var_0 = scripts\sp\utility::_id_7A96();
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  self setmode("manual");
  self settargetentity(var_1);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_035A(undefined, var_0.origin, var_0.radius);
  thread _id_8F67();
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "hill_run_complete");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();

  if(isDefined(self)) {
    self notify("stop_fire");
    self cleartargetentity();
    self setmode("auto_ai");
    self._id_ED26 = 0.5;
    self._id_ED25 = 1.25;
  }

  var_1 delete();

  if(isDefined(self)) {
    self delete();
  }
}

_id_8F67() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getspawner(self.target, "targetname");
  var_1 = scripts\sp\utility::_id_2C17(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  self.gunner = var_1;
  var_1 setCanDamage(1);
  var_2 = spawnStruct();
  var_3 = anglesToForward(scripts\engine\utility::flat_angle(self.angles));
  var_4 = var_3 * -1;
  var_2.origin = self.origin + var_4 * 12;
  var_2.angles = self.angles;
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, "turret_aim_idle");
  var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();

  if(isDefined(var_1)) {
    var_1 startragdoll();
    var_1 scripts\engine\utility::delaycall(1.5, ::delete);
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_8F68(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0.origin, 2, 256, 56);
  var_2 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");
  var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();
  var_2 delete();
  var_0 notify("stop_loop");
  var_1 unlink();
  var_1 _meth_83A1();
  var_0 delete();
  self notify("stop_fire");
  self cleartargetentity();
  self setmode("manual");
}

_id_129F6(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_1 = scripts\engine\utility::flat_angle(var_0 gettagangles("tag_butt"));
    self.angles = var_1;
    wait 0.05;
  }
}

_id_8EFD() {
  var_0 = getEnt(self.script_noteworthy, "targetname");
  scripts\engine\utility::flag_wait(self._id_EDA0);
  wait 0.8;
  var_0 show();
  var_0 solid();
  self delete();
}

_id_8FBB(var_0) {
  var_1 = var_0;
  var_2 = var_0 scripts\sp\utility::_id_7A97();

  foreach(var_4 in var_2) {
    if(var_4 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C8ED("mortar_loc")) {
      var_1 = var_4;
    }
  }

  playFX(scripts\engine\utility::getfx("hill_mortar_incoming"), var_1.origin);
  thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_incoming", var_1.origin);
  wait 0.8;

  if(isDefined(var_0.script_prefab_exploder)) {
    var_6 = var_0.script_prefab_exploder;
    var_7 = getEntArray(var_6, "targetname");
    var_8 = getEntArray(var_6 + "_dmg", "targetname");
    scripts\engine\utility::array_call(var_8, ::show);
    scripts\engine\utility::array_call(var_8, ::solid);
    scripts\engine\utility::array_call(var_7, ::delete);
  }

  var_9 = "hill_mortar_impact";

  if(isDefined(var_1.script_fxid)) {
    var_9 = var_1.script_fxid;
  }

  playFX(scripts\engine\utility::getfx("hill_mortar_impact"), var_1.origin);
  thread scripts\engine\utility::play_sound_in_space("phstreets_hill_mortar_explo", var_1.origin);
  thread scripts\engine\utility::do_earthquake("mortar", var_1.origin);
  thread scripts\sp\utility::_id_54EF(var_1.origin);
  playrumbleonposition("grenade_rumble", var_1.origin);

  if(isai(self)) {
    playworldsound("phstreets_hill_npc_mortar_death", self.origin);

    if(isDefined(self._id_B14F)) {
      scripts\sp\utility::_id_1101B();
    }

    scripts\sp\utility::_id_54C6();
  }

  radiusdamage(var_0.origin, var_1.script_radius, 15, 30);
}

_id_A7B4(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_flesh_hit_body_large"), var_0, "j_shoulder_ri");
  playworldsound("phstreets_hill_npc_bullet_impact", var_0 gettagorigin("j_shoulder_ri"));
  level waittill("lamp_death_bullet_impact");
  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_flesh_hit_body_large"), var_0, "j_shoulder_le");
  playworldsound("phstreets_hill_npc_bullet_death", var_0 gettagorigin("j_shoulder_le"));
}

_id_8F9A() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
}

#using_animtree("script_model");

_id_8FAB() {
  scripts\engine\utility::flag_wait("hill_player_approaching_basement");
  var_0 = getEnt("hill_combat_roller_cockpit", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 _meth_83D0(#animtree);
  var_0._id_1FBB = "cockpit";
  var_0 setModel("veh_mil_air_un_dropship_hero_cockpit_dmg");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_4 linkTo(var_0);

    if(var_4 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("clip")) {
      var_2 = var_4;
    }
  }

  var_0.clip = var_2;
  level._id_E682 = var_0;
  var_6 = getEnt("hill_cockpit_roll_apc", "targetname");
  var_6 setModel("veh_mil_lnd_un_apc_earth_dmg");
  var_6 _meth_83D0(#animtree);
  var_6._id_1FBB = "apc";
  var_7 = getEnt(var_6.target, "targetname");
  var_7 linkTo(var_6);
  var_6.clip = var_7;
  level._id_E67E = var_6;
  var_8 = [var_0, var_6];
  var_9 = scripts\engine\utility::getStruct("hill_cockpit_roll_struct", "targetname");
  var_9 scripts\sp\anim::_id_1EC1(var_8, "hill_cockpit_roll");
}

_id_8FAA() {
  scripts\sp\utility::_id_127B3("hill_combat_roller_droppod_trig");
  var_0 = level._id_E682;
  var_1 = level._id_E682.clip;
  var_2 = level._id_E67E;
  var_3 = level._id_E67E.clip;
  scripts\engine\utility::flag_wait_all("hill_failure_ready_for_roll", "hill_redshirt1_ready_for_roll", "hill_redshirt2_ready_for_roll");
  var_4 = scripts\engine\utility::getStruct("hill_cockpit_roll_struct", "targetname");
  level.allies["admiral"] thread scripts\sp\utility::_id_10346("phstreets_eth_enemydroppods");
  thread _id_8FC6();
  wait 0.5;
  var_5 = scripts\sp\vehicle::_id_1080C("hill_combat_roller_droppod");
  var_5._id_1FBE = var_4;
  var_5 thread _id_4318();
  scripts\engine\utility::flag_set("hill_dropship_cockpit_roll");
  var_0 thread _id_4316();
  var_0 thread _id_4319();
  var_1 connectpaths();
  var_1 notsolid();
  var_0 motionblurhqenable();
  scripts\engine\utility::flag_set("hill_redshirt2_continue_path");
  var_6 = [level._id_8F3D, level._id_8F3E, level._id_8F3C, var_2];

  foreach(var_8 in var_6) {
    var_8 thread _id_4315(var_4);
  }

  var_0 _id_4315(var_4);
  var_0 notify("stop_earthquake_loop");
  earthquake(0.25, 0.25, var_0.origin, 1000);
  var_0 motionblurhqdisable();
  var_3 connectpaths();
  var_3 disconnectPaths();
  var_0 notify("stopped_rolling");
  scripts\engine\utility::flag_set("hill_dropship_cockpit_roll_done");
  var_1 solid();
  var_1 disconnectPaths();
}

_id_8FC6() {
  level._id_1B19 = spawn("script_origin", (74548, 50591, -33359));
  level._id_1B19 playLoopSound("scn_phstreets_courtyard_alarm_lp");
}

_id_4315(var_0) {
  if(self._id_1FBB != "redshirt2") {
    level waittill(self._id_1FBB + "_cockpit_roll");
  }

  if(self == level._id_E682) {
    thread scripts\sp\utility::play_sound_on_entity("scn_ph_hill_cockpit_roll_close");
  }

  var_0 scripts\sp\anim::_id_1F35(self, "hill_cockpit_roll");

  if(self._id_1FBB == "redshirt2") {
    self _meth_83A1();
    self clearanim(_id_0A1E::_id_2342(), 0);
    var_1 = _func_2EE("soldier", "exposed_idle", "rifle_aim_5", 0);
    self _meth_82A8(var_1.anims, _id_0A1E::_id_2342(), 1, 0);
  }

  var_2 = "hill_" + self._id_1FBB + "_continue_path";

  if(scripts\engine\utility::flag_exist(var_2)) {
    scripts\engine\utility::flag_set(var_2);
  }
}

_id_4318() {
  level waittill("droppod_cockpit_roll");
  thread scripts\sp\utility::play_sound_on_entity("scn_phstreets_hill_droppod_incoming_cockpit");
  level.allies["admiral"] scripts\engine\utility::delaythread(1, scripts\sp\utility::play_sound_on_entity, "phstreets_unm3_gettocover");
  self waittill("landed");
  self disconnectPaths();
  var_0 = level._id_8FA8;

  if(isDefined(var_0.gunner)) {
    var_0.gunner delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  level._id_8FA8 = undefined;
  playworldsound("scn_ph_hill_cockpit_roll_explo_start_lr", self.origin);
  playFX(scripts\engine\utility::getfx("vfx_ph_hill_droppod_cockpit_impact"), self.origin);
  earthquake(0.25, 1, self.origin, 10000);
}

_id_4316() {
  thread _id_430B();
  level waittill("staircase_01_vase_impact");
  _id_4308("cockpit_roll_staircase_01");
  level waittill("staircase_01_impact");
  scripts\engine\utility::exploder("cockpit_post_dust_1");
  scripts\engine\utility::exploder("cockpit_post_dust_2");
  _id_4309("cockpit_roll_staircase_01");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  level waittill("staircase_02_vase_impact");
  _id_4308("cockpit_roll_staircase_02");
  level waittill("staircase_02_impact");
  scripts\engine\utility::exploder("cockpit_post_dust_3");
  scripts\engine\utility::exploder("cockpit_post_dust_4");
  _id_4309("cockpit_roll_staircase_02");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  level waittill("staircase_03_vase_impact");
  _id_4308("cockpit_roll_staircase_03");
  level waittill("staircase_03_impact");
  scripts\engine\utility::exploder("cockpit_post_dust_5");
  scripts\engine\utility::exploder("cockpit_post_dust_6");
  _id_4309("cockpit_roll_staircase_03");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  var_0 = getEnt("cockpit_roll_nav_clip", "targetname");
  var_0 scripts\sp\utility::_id_100D7();
  level waittill("staircase_04_impact");
  scripts\engine\utility::exploder("cockpit_post_dust_7");
  _id_4309("cockpit_roll_staircase_04");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  level._id_8FC5 = undefined;
}

_id_4328() {
  var_0 = ["cockpit_roll_staircase_01", "cockpit_roll_staircase_02", "cockpit_roll_staircase_03", "cockpit_roll_staircase_04"];

  foreach(var_2 in var_0) {
    _id_4329(var_2, "prestine", 0.1);
  }
}

_id_4329(var_0, var_1, var_2) {
  level._id_8FC5[var_0][var_1]["models"] = [];
  var_3 = level._id_8FC5[var_0][var_1];

  for(var_4 = 0; var_4 < var_3["size"]; var_4++) {
    var_5 = var_3["model"][var_4];
    var_6 = var_3["origin"][var_4];
    var_7 = var_3["angles"][var_4];
    var_8 = spawn("script_model", var_6);
    var_8.angles = var_7;
    var_8 setModel(var_5);
    level._id_8FC5[var_0][var_1]["models"][var_4] = var_8;

    if(isDefined(var_2)) {
      wait(var_2);
    }
  }
}

_id_4327() {
  level._id_8FC5 = [];
  var_0 = ["cockpit_roll_staircase_01", "cockpit_roll_staircase_02", "cockpit_roll_staircase_03", "cockpit_roll_staircase_04"];

  foreach(var_2 in var_0) {
    level._id_8FC5[var_2] = [];
    var_3 = getEntArray(var_2, "targetname");

    foreach(var_5 in var_3) {
      var_5 _id_4326(var_2, "prestine");
    }

    var_7 = getEntArray(var_2 + "_dmg", "targetname");

    foreach(var_5 in var_7) {
      var_5 _id_4326(var_2, "destroyed");
    }
  }
}

_id_4326(var_0, var_1) {
  if(!isDefined(self.model)) {
    return;
  }
  if(!isDefined(level._id_8FC5[var_0][var_1])) {
    level._id_8FC5[var_0][var_1] = [];
    level._id_8FC5[var_0][var_1]["brushmodels"] = [];
    level._id_8FC5[var_0][var_1]["model"] = [];
    level._id_8FC5[var_0][var_1]["origin"] = [];
    level._id_8FC5[var_0][var_1]["angles"] = [];
    level._id_8FC5[var_0][var_1]["size"] = 0;
  }

  if(isDefined(self.classname) && self.classname == "script_brushmodel") {
    var_2 = level._id_8FC5[var_0][var_1]["brushmodels"];
    var_2[var_2.size] = self;
    level._id_8FC5[var_0][var_1]["brushmodels"] = var_2;
    return;
  }

  var_3 = level._id_8FC5[var_0][var_1]["model"].size;
  level._id_8FC5[var_0][var_1]["model"][var_3] = self.model;
  level._id_8FC5[var_0][var_1]["origin"][var_3] = self.origin;

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  level._id_8FC5[var_0][var_1]["angles"][var_3] = self.angles;
  level._id_8FC5[var_0][var_1]["size"]++;
  self delete();
}

_id_4317() {
  for(var_0 = 1; var_0 < 5; var_0++) {
    _id_4309("cockpit_roll_staircase_0" + var_0);
  }
}

_id_4309(var_0) {
  var_1 = level._id_8FC5[var_0]["prestine"]["brushmodels"];
  var_2 = level._id_8FC5[var_0]["prestine"]["models"];
  var_3 = level._id_8FC5[var_0]["destroyed"]["brushmodels"];
  scripts\engine\utility::array_call(var_3, ::show);
  scripts\engine\utility::array_call(var_3, ::solid);

  if(isDefined(var_2)) {
    scripts\engine\utility::array_call(var_2, ::delete);
  }

  _id_4329(var_0, "destroyed");
  scripts\engine\utility::array_call(var_1, ::delete);
}

_id_4308(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0 + "_vase", "targetname");

  foreach(var_3 in var_1) {
    radiusdamage(var_3.origin, 24, 9999, 9999);
  }
}

_id_430A(var_0) {
  var_0 notify("stop_earthquake_loop");
  thread scripts\sp\utility::_id_54EF(var_0.origin);
  playrumbleonposition("heavy_1s", var_0.origin);
  var_1 = 0.5;
  earthquake(0.35, var_1, var_0.origin, 5000);
  var_0 scripts\engine\utility::delaythread(var_1 / 2, ::_id_430B);
}

_id_430B() {
  self endon("stop_earthquake_loop");

  for(;;) {
    earthquake(0.26, 0.1, self.origin, 1000);
    wait 0.05;
  }
}

_id_4319() {
  if(getdvarint("exec_review")) {
    return;
  }
  self endon("stopped_rolling");
  var_0 = getEntArray("hill_run_player_progress_reset", "targetname");

  for(;;) {
    wait 0.05;

    if(distance(self.origin, level.player.origin) < 250) {
      var_1 = 1;

      foreach(var_3 in var_0) {
        if(level.player istouching(var_3)) {
          var_1 = 0;
        }
      }

      if(var_1) {
        level.player scripts\sp\utility::_id_54C6();
      }
    }
  }
}

_id_4307() {
  var_0 = getEnt("hill_combat_roller_cockpit", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("clip")) {
      var_3 connectpaths();
    }

    var_3 delete();
  }

  var_0 delete();
}

_id_8FA7() {
  scripts\engine\utility::flag_set("hill_run_complete");
  scripts\engine\utility::array_thread(getEntArray("hill_running_triggers", "script_noteworthy"), scripts\engine\utility::trigger_on);
  thread _id_4317();
  var_0 = level._id_8FA8;

  if(isDefined(var_0.gunner)) {
    var_0.gunner delete();
  }

  var_0 delete();
}

_id_8F4F() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_hill_combat");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_hill_combat", var_0);
  thread _id_4307();
  thread _id_8FC6();
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_15F5, "hill_first_enemy_spawn_trig");
  scripts\sp\utility::_id_15F5("hill_combat_start_color_trig");
  scripts\sp\utility::_id_22CD("hill_combat_start_allies");
  var_1 = scripts\engine\utility::getStruct("hill_cockpit_roll_struct", "targetname");
  var_2 = scripts\sp\vehicle::_id_1080C("hill_combat_roller_droppod");
  var_2._id_1FBE = var_1;
  thread _id_82DE();
}

_id_8F49() {
  level._id_B460 = 25;
  thread _id_8F42();
  thread _id_8F58();
  thread _id_8F3B();
  thread _id_8F97();
  thread hill_transient_slowload_wait();
  _id_0E40::_id_6209();
  _id_0E40::_id_F42A("hill_fly_volume");
  setsaveddvar("player_sprintUnlimited", 0);
  level._id_BB5A = 500;
  scripts\sp\mortar::_id_2C20(5);
  level._id_BB69 = scripts\sp\utility::_id_22B9(level._id_BB69);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_6224();
    var_1 scripts\sp\utility::_id_61DF();
    var_1.providecoveringfire = 0;
  }

  scripts\engine\utility::flag_wait_either("hill_combat_steep_hill_enemies_retreat", "hill_dropship_boss_spawn");
  scripts\sp\vehicle::_id_1080C("hill_dropship_boss");
  scripts\sp\utility::_id_15F5("dropship_boss_allies_right_colortrig");
  scripts\engine\utility::flag_wait("hill_dropship_boss_dead");
  scripts\sp\utility::_id_2669("dropship killed");
  _id_0B77::_id_A67F(411);
  scripts\engine\utility::delaythread(8, scripts\sp\vehicle::_id_1080C, "hill_combat_droppod_center");

  if(isDefined(getEnt("post_dropship_boss_colortrig", "targetname"))) {
    scripts\sp\utility::_id_15F5("post_dropship_boss_colortrig");
  }

  scripts\engine\utility::array_thread(getEntArray("post_dropship_boss_spawn_trigs", "script_noteworthy"), scripts\sp\utility::_id_15F1);
  scripts\engine\utility::array_thread(getEntArray("post_dropship_boss_trigs", "targetname"), scripts\engine\utility::trigger_on);
  scripts\engine\utility::array_thread(getEntArray("post_dropship_boss_trigs", "script_noteworthy"), scripts\engine\utility::trigger_on);
  thread scripts\sp\maps\pearlharbor\pearlharbor_tower::tower_doors_spawn();
  scripts\engine\utility::flag_wait("hill_combat_tier_2");
  level notify("stop_mortars_4");
  scripts\engine\utility::flag_wait("hill_combat_player_reached_top");
  scripts\sp\utility::_id_228A(getEntArray("hill_combat_color_trigs", "script_noteworthy"));
}

_id_8F42() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("hill_combat_steep_hill_enemies_retreat");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_takethehill");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_weremovinguprey");
  scripts\engine\utility::flag_wait("hill_dropship_boss_intro_done");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_enemytransportin");
  scripts\engine\utility::flag_wait("hill_dropship_boss_dialogue_start");

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_pinningusdown");
  }

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    scripts\sp\utility::_id_10350("phstreets_plr_cantadvance");
  }

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_wegottatakeitout");
  }

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_airshipsgotbots");
  }

  thread _id_5D86();
  scripts\engine\utility::flag_wait("hill_dropship_boss_dead");
  _id_5D88();
  wait 2;
  scripts\sp\utility::_id_10350("phstreets_plr_gold24ineedyouon");
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_tower::_id_53C2();

  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_10347("phstreets_un1_copymovinleft");
  }

  scripts\engine\utility::flag_wait("hill_combat_tier_2");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_gettingclosesta");
  wait 2;
  scripts\sp\utility::_id_10350("phstreets_plr_goldteamreport");
  scripts\sp\utility::_id_10350("phstreets_un1_24inpositionleftside");
  scripts\sp\utility::_id_10350("phstreets_un2_thisis26werein");
  scripts\sp\utility::_id_10350("phstreets_plr_okayletstakeit");
}

_id_5D88() {
  wait 11;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_goodkilltargetdestroyed");

  if(scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_solidhackreyes");
  }

  scripts\sp\utility::_id_10350("phstreets_plr_forceuptowersatthe");
}

_id_5D86() {
  wait 8;

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_therearebotsaboard");
  }

  wait 8;

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_cmonreyeshackin");
  }

  wait 3;

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_callforanairstrike");
  }

  wait 8;

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_hackinyoucan");
  }

  wait 4;

  if(!scripts\engine\utility::flag("hill_dropship_boss_dead") && !scripts\engine\utility::flag("hill_player_hacked_dropship")) {
    level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_transportsengines");
  }
}

hill_transient_slowload_wait() {
  if(level.console) {
    return;
  }
  scripts\engine\utility::flag_wait("player_in_security_room");
  waitforalltransients();
}

_id_82DE() {
  wait 1;
  level._id_A29E["cooldown"] = 30;
  level._id_A29E["FOV"] = undefined;
  level._id_A29E["max_enemies"] = 6;
  level._id_A29E["accuracy"] = 0.05;
  level._id_A29E["max_time_up"] = undefined;
  level._id_A29E["max_target_dist"] = undefined;
  level._id_A29E["min_target_dist"] = undefined;
  level._id_A29E["bDontFindMore"] = undefined;
  level.player scripts\sp\utility::_id_8294("iw7_jackal_support_designator");
}

_id_8F50() {
  createthreatbiasgroup("hill_center_allies");
  createthreatbiasgroup("hill_center_enemies");
  createthreatbiasgroup("hill_left_side_allies");
  createthreatbiasgroup("hill_left_side_enemies");
  createthreatbiasgroup("hill_right_allies");
  createthreatbiasgroup("hill_right_enemies");
  setignoremegroup("hill_center_enemies", "hill_left_side_allies");
  setignoremegroup("hill_left_side_allies", "hill_center_enemies");
  setthreatbias("hill_center_allies", "hill_center_enemies", 100);
  setthreatbias("hill_center_enemies", "hill_center_allies", 100);
  setthreatbias("hill_left_side_allies", "hill_left_side_enemies", 100);
  setthreatbias("hill_left_side_enemies", "hill_left_side_allies", 100);
  setthreatbias("hill_right_allies", "hill_right_enemies", 100);
  setthreatbias("hill_right_enemies", "hill_right_allies", 100);
}

_id_8F3F() {
  var_0 = getEnt("hill_combat_2_right_colortrig", "script_noteworthy");
  var_0 endon("entitydeleted");
  scripts\sp\utility::_id_5599("hill_combat_2_center_right_trig");
  var_0 waittill("trigger");
  scripts\sp\utility::_id_624C("hill_combat_2_center_right_trig");
}

_id_8F53() {
  var_0 = self.spawner;
  self.health = int(self.health / 2);
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1 scripts\sp\anim::_id_1ECE(self, var_1.animation);

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  scripts\sp\utility::_id_5564();
  self._id_4E50 = var_1;
  self._id_4E46 = ::_id_8F54;
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "hill_combat_steep_hill_enemies_retreat");
  scripts\sp\utility::_id_57D6();

  if(!isDefined(self) || isalive(self)) {
    var_2 delete();
    return;
  }

  self endon("death");
  wait(randomfloatrange(0.5, 2.5));
  self unlink();
  scripts\sp\utility::_id_6224();
  self._id_4E46 = undefined;
}

_id_8F54() {
  var_0 = self._id_4E50;

  if(distance2d(self.origin, var_0.origin) > 64) {
    return 0;
  }

  self unlink();
  self _meth_80F1(var_0.origin, var_0.angles);
  self animmode("gravity");
  self orientmode("face angle", self._id_4E50.angles[1]);
  self _meth_82EA("hillDeathAnim", scripts\sp\utility::_id_7DC3(var_0.animation), 1, 0.2, 1);
  _id_0A1E::_id_231F(self.asmname, "hillDeathAnim");
}

_id_8F3B() {
  level endon("hill_combat_tier_2");
  scripts\engine\utility::flag_wait("hill_clown_car_flag");
  var_0 = getEnt("hill_clown_car_volume", "script_noteworthy");
  var_1 = getaiunittypearray("axis", "all");

  if(var_1.size < 10) {
    return;
  }
  foreach(var_3 in var_1) {
    if(var_1.size <= 10) {
      return;
    }
    if(isDefined(var_3) && !scripts\sp\utility::_id_CFAC(var_3)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      var_3 delete();
    }
  }
}

_id_8F97() {
  level endon("hill_combat_player_reached_top");
  var_0 = getEnt("hill_left_railing_trig", "targetname");
  var_1 = getEnt(var_0.target, "targetname");

  for(;;) {
    var_0 waittill("trigger");
    var_1 notsolid();

    while(level.player istouching(var_0)) {
      wait 0.05;
    }

    var_1 solid();
  }
}

_id_8F4C() {
  level endon("ok_to_delete_hill_AI");
  var_0 = self._id_EDAD;

  if(!isDefined(var_0)) {
    var_0 = self._id_C3BE;
  }

  scripts\sp\maps\pearlharbor\pearlharbor_hill_dropship::_id_B347(var_0);

  if(!isDefined(var_0)) {}

  scripts\engine\utility::waittill_either("death", "entitydeleted");
  thread _id_8F4D(var_0);
}

_id_8F4D(var_0) {
  var_1 = self._id_4BEF;
  wait(randomfloatrange(3, 6));
  var_2 = undefined;

  while(!isDefined(var_2)) {
    wait 0.25;
    var_3 = level._id_8F4E[var_0];
    var_4 = undefined;

    foreach(var_6 in var_3) {
      if(!isDefined(var_6.disabled)) {
        var_4 = var_6;
        break;
      }
    }

    if(!isDefined(var_4)) {
      continue;
    }
    var_8 = 1;
    var_4.count = 1;
    var_2 = var_4 scripts\sp\utility::_id_10619();
    scripts\engine\utility::waitframe();
    var_4.disabled = undefined;
  }

  var_2 endon("death");
  var_2 scripts\sp\utility::_id_51E1("frantic");
  var_2.providecoveringfire = 0;

  if(!scripts\engine\utility::flag("hill_combat_color_movement_start")) {
    var_2 scripts\sp\utility::_id_54F7();

    if(isDefined(var_1)) {
      var_2 _meth_82EE(var_1);
    }

    scripts\engine\utility::flag_wait("hill_combat_color_movement_start");
    var_2 scripts\sp\utility::_id_61C7();
  }

  scripts\engine\utility::flag_wait("hill_towerbase_allies_moveup");

  if(var_2._id_EDAD == "p") {
    var_2 scripts\sp\utility::_id_F3B5("o");
  } else if(var_2._id_EDAD != "o") {
    var_2 scripts\sp\utility::_id_F3B5("p");
  }

  scripts\engine\utility::flag_wait("ok_to_delete_hill_AI");

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_8FA2() {
  var_0 = getspawnerarray(self.target);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3._id_EDAD;

    if(!isDefined(var_1[var_4])) {
      var_1[var_4] = [];
    }

    var_1[var_4] = ::scripts\engine\utility::array_add(var_1[var_4], var_3);
  }

  if(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("start")) {
    level._id_8F4E = var_1;
  }

  for(;;) {
    self waittill("trigger");
    level._id_8F4E = var_1;

    while(level.player istouching(self)) {
      wait 0.25;
    }
  }
}

_id_8F51() {
  self endon("death");
  var_0 = self.spawner;
  var_1 = var_0 scripts\sp\utility::_id_7A96();
  scripts\sp\utility::_id_B14F(1);
  var_1 scripts\sp\anim::_id_1EC7(self, "ph_hill400_ally_jump_down_from_wall");
  scripts\sp\utility::_id_1101B();
}

hill_tower_fake_dropships() {
  self endon("death");
  self waittill("unloading");

  if(!scripts\engine\utility::flag("improved_towerbase_spawning_flag")) {
    scripts\engine\utility::flag_wait("improved_towerbase_spawning_flag");
  }

  if(scripts\sp\utility::_id_65DB("unloaded")) {
    return;
  }
  foreach(var_1 in self._id_E4FB) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_8F69() {
  var_0 = getEntArray("hill_enemy_turrets", "script_noteworthy");

  if(getdvarint("e3")) {
    scripts\sp\utility::_id_228A(var_0);
    return;
  }

  scripts\engine\utility::flag_wait("hill_run_checkpoint_4");
  level._id_8F69 = [];

  foreach(var_2 in var_0) {
    var_3 = getspawner(var_2.target, "targetname");
    var_2 thread _id_8F67(var_3);

    if(isDefined(var_2.script_parameters)) {
      level._id_8F69[var_2.script_parameters] = var_2;
    }

    var_2 cleartargetentity();
    var_2 setturretteam("axis");
    var_2 setmode("auto_nonai");
    var_2 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_035A();
  }
}

_id_8F44() {
  self waittill("landed");
  scripts\engine\utility::flag_set("hill_combat_right_droppod_landed");
}

_id_3E7C() {
  level.player waittill("choke_scene_music");
}

_id_8F45() {
  scripts\sp\utility::_id_B14F(1);
  self._id_1FBB = "c6";
  var_0 = getspawner(self.script_linkto, "script_linkname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1, 1);
  var_1._id_1FBB = "soldier";

  if(!isDefined(var_1)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    return;
  }

  var_2 = gettime();
  var_3 = 3000;

  while(isDefined(self) && !scripts\sp\utility::_id_CFAC(self)) {
    if(gettime() - var_2 >= var_3) {
      break;
    }

    wait 0.05;
  }

  var_4 = [self, var_1];
  var_5 = scripts\engine\utility::getStruct("hill_combat_dropship_necksnap_struct", "targetname");
  var_5.angles = (0, 0, 0);
  var_5 scripts\sp\anim::_id_1F2C(var_4, "hill_combat_robot_necksnap");
  scripts\engine\utility::flag_set("hill_combat_dropship_necksnap_done");
}

_id_8FA4() {
  var_0 = self.spawner;
  var_1 = scripts\engine\utility::getStruct("hill_robot_kick_soldier_struct", "targetname");
  scripts\sp\utility::_id_B14F(1);
  self._id_1FBB = "c6";
  self.ignoreall = 1;
  _id_0E29::_id_877F(self);
  var_2 = getspawner(var_0.script_linkto, "script_linkname");
  var_3 = var_2 scripts\sp\utility::_id_10619(1, 1);

  if(!isDefined(var_3)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    return;
  }

  var_3._id_1FBB = "soldier";
  var_3.ignoreall = 1;
  var_3.ignoreme = 1;
  var_4 = 0.35;
  var_5 = [self, var_3];
  var_1 thread scripts\sp\anim::_id_1F2C(var_5, "hill_robot_kick");
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\anim::_id_1F2A(var_5, "hill_robot_kick", var_4);
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\anim::_id_1F27(var_5, "hill_robot_kick", 0);
  var_6 = gettime();
  var_7 = 3000;

  while(!scripts\sp\utility::_id_CFAC(self)) {
    if(gettime() - var_6 >= var_7) {
      break;
    }

    if(scripts\engine\utility::flag("hill_combat_player_near_top")) {
      break;
    }

    wait 0.05;
  }

  if(scripts\engine\utility::flag("hill_combat_player_near_top")) {
    var_3 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    return;
  }

  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_22CD, "hill_combat_kick_robot_backup", undefined, 1);
  var_1 scripts\sp\anim::_id_1F27(var_5, "hill_robot_kick", 1);
  _id_0E29::_id_87D0(self);
  level waittill("kick_c6_allow_death");
  self.ignoreall = 0;
  scripts\engine\utility::flag_set("hill_robot_kick_scene_done");
}

_id_8FA3() {
  var_0 = scripts\sp\utility::_id_107EA("hill_robot_kick_left_soldier");

  if(!isDefined(var_0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01();
    return;
  }

  self._id_1FBB = "c6";
  scripts\sp\utility::_id_B14F(1);
  self.ignoreall = 1;
  scripts\sp\utility::_id_5564();
  var_0._id_1FBB = "soldier";
  var_0.ignoreme = 1;
  var_0 scripts\sp\utility::_id_B14F(1);
  var_0 scripts\sp\utility::_id_5564();
  var_0.favoriteenemy = self;
  var_1 = [self, var_0];
  var_2 = getnode("hill_robot_kick_left_node", "targetname");
  var_2 scripts\sp\anim::_id_1F0A(var_1, "hill_robot_kick");
  var_2 thread scripts\sp\anim::_id_1F2C(var_1, "hill_robot_kick");
  wait 3.5;
  scripts\sp\maps\phstreets\phstreets_anim::_id_C0C3(self);
  self _meth_83A1();
  self.ignoreall = 0;
}

_id_8F48(var_0) {
  scripts\engine\utility::exploder("c6_kick_impact");
  var_1 = getEntArray("hill_combat_c6_kick_wall_prestine", "targetname");
  var_2 = getEntArray("hill_combat_c6_kick_wall_damaged", "targetname");

  foreach(var_4 in var_1) {
    var_4 delete();
  }

  foreach(var_4 in var_2) {
    var_4 show();
  }
}

_id_8F40() {
  self setgoalentity(level.player);
  self._id_1FBB = "generic";
  var_0 = getaiarray("axis");
  var_1 = getEnt("hill_robot_balcony_grab_volume", "targetname");
  var_2 = 1;

  foreach(var_4 in var_0) {
    if(var_4 istouching(var_1)) {
      var_2 = 0;
      break;
    }
  }

  var_6 = undefined;

  if(var_2) {
    var_7 = getspawner(self.script_linkto, "script_linkname");
    var_6 = var_7 scripts\sp\utility::_id_10619(1, 1);
    var_6 scripts\sp\utility::_id_51E1("frantic");
    var_6._id_1FBB = "soldier";
  }

  var_8 = scripts\engine\utility::getStruct("hill_combat_robot_climb_struct", "targetname");
  var_9 = "ph_c6_intro_hop_over_railing_c6";
  var_10 = [self];

  if(isDefined(var_6)) {
    var_8 = scripts\engine\utility::getStruct("hill_combat_robot_balcony_grab_struct", "targetname");
    var_9 = "hill_robot_pulldown";
    var_10 = [self, var_6];
    scripts\sp\utility::_id_B14F(1);
    self setCanDamage(0);
    self._id_1FBB = "c6";
  }

  var_8 thread scripts\sp\anim::_id_1F2C(var_10, var_9);
  scripts\engine\utility::waitframe();
  var_8 scripts\sp\anim::_id_1F2A(var_10, var_9, 0.25);
  scripts\engine\utility::waitframe();
  var_8 scripts\sp\anim::_id_1F27(var_10, var_9, 0);
  var_11 = gettime();
  var_12 = 3000;

  while(isDefined(var_6) && !scripts\sp\utility::_id_CFAC(var_6)) {
    if(gettime() - var_11 >= var_12) {
      break;
    }

    wait 0.05;
  }

  var_8 scripts\sp\anim::_id_1F27(var_10, var_9, 1);
}

_id_8F41() {
  level._id_B460 = 15;
  thread scripts\sp\maps\pearlharbor\pearlharbor_tower::tower_doors_spawn();
}

_id_BB56() {
  self endon("death");

  if(isDefined(self.script_ender)) {
    self endon(self.script_ender);
  }

  for(;;) {
    self waittill("trigger");
    scripts\sp\mortar::_id_2C20(self._id_EE26);

    while(level.player istouching(self)) {
      wait 0.15;
    }

    scripts\sp\mortar::_id_2C1F(self._id_EE26);
  }
}