/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\cp_dwntwn_rooftop.gsc
************************************************************/

function main() {
  level.rooftop_obj_func = &register_objectives;
}

function register_objectives() {
  scripts\cp\cp_objectives::registerobjective("rooftop_raid", &add_module_ai_spawn_func_to_module, &analytics_lui_mission_end_dlog, &add_module_ai_spawn_func_to_module, &add_module_ai_spawn_func_to_module, &adjustmatchtimerpausedstatefromscore);
  scripts\cp\cp_objectives::registerobjective("rooftop_raid_heli", &add_module_ai_spawn_func_to_module, &angle_molotov_mortar, &add_module_ai_spawn_func_to_module, &add_module_ai_spawn_func_to_module, &adjustlootleadermarkcount);
  scripts\cp\cp_objectives::registerobjective("rooftop_raid_activatesats", &add_module_ai_spawn_func_to_module, &anglesoffset, &add_module_ai_spawn_func_to_module, &add_module_ai_spawn_func_to_module, &adjusteventdistributionpadding);
  scripts\cp\cp_objectives::registerobjective("rooftop_raid_exfil", &add_module_ai_spawn_func_to_module, &anchoredwidgetid, &add_module_ai_spawn_func_to_module, &add_module_ai_spawn_func_to_module, &adjustmatchtimerpausedstatefromleadchange);
  level.ref_1404B = 1;
}

function add_module_ai_spawn_func_to_module(var_0, var_1) {}

function adjustmatchtimerpausedstatefromscore(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "player_rooftop_spawn");
}

function adjustlootleadermarkcount(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "rooftop_raid_player_starts");
}

function adjusteventdistributionpadding(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "rooftop_raid_player_starts");
  setup_flags();
  level.sats_connected = 0;
  setDvar("scr_sat_debug", 1);
  ref_12E95();
  trigger_spawn_init();
  register_spawn_groups();
  thread playtutsound();
  level.rooftop1_sat = sat_setup(1);
  level.rooftop2_sat = sat_setup(2);
  level.rooftop3_sat = sat_setup(3);
  level.rooftop1_sat.power_switch.alarm_box notify("trigger", level.players[0]);
  wait 1;
  level.rooftop2_sat.power_switch.alarm_box notify("trigger", level.players[0]);
  wait 1;
  level.rooftop3_sat.power_switch.alarm_box notify("trigger", level.players[0]);
  wait 7;
}

function adjustmatchtimerpausedstatefromleadchange(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "player_rooftop_spawn");
}

function anchoredwidgetid(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  objective_state(level.rooftop1_sat.objective_id, "done");
  objective_state(level.rooftop2_sat.objective_id, "done");
  objective_state(level.rooftop3_sat.objective_id, "done");
  objective_position(var_0.objectiveindex, scripts\engine\utility::getStruct("elevator_obj", "targetname").origin);
  level.rooftop1_sat.computer makeunusable();
  level.rooftop2_sat.computer makeunusable();
  level.rooftop3_sat.computer makeunusable();
  minigun_should_keep_firing();
  var_1 = fixupsupersandtacticalsforgunfightmaps();
  flag_bot_attacker_limit_for_team(var_1);
  var_1 setModel("ee_door_wood_stained_int_01_keypad_unlocked");
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function anglesoffset(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  setomnvar("ui_signal_strength1", level.rooftop1_sat.ref_13393);
  setomnvar("ui_signal_strength2", level.rooftop2_sat.ref_13393);
  setomnvar("ui_signal_strength3", level.rooftop3_sat.ref_13393);
  var_1 = (level.rooftop1_sat.ref_13393 + level.rooftop2_sat.ref_13393 + level.rooftop3_sat.ref_13393) / 3;
  var_1 = int(max(1, var_1));
  setomnvar("ui_signal_strength_total", var_1);
  ref_12EA3();

  foreach(var_3 in level.players) {
    var_3 sethudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/ROOFTOP_TRANS_COMPLETE");
  }

  wait 5;

  foreach(var_3 in level.players) {
    var_3 clearhudtutorialmessage();
  }
}

function angle_molotov_mortar(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  level.teamnamelist = ["axis", "allies"];
  level.get_mortar_impact_pos = &ref_11D2D;
  level.sixthsenselastvotime = &sixthsense_shouldwarnaboutotherplayer;
  var_1 = scripts\engine\utility::getStruct("rooftop_raid_player_heli", "targetname");
  level.player_lb = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  level.player_lb thread scripts\cp\cp_vehicles::waiting_for_disable();
  level.player_lb scripts\cp\utility::make_entity_sentient_cp("allies", 0);
  level.player_lb.maxhealth = 5000;
  level.player_lb.health = 5000;
  analytics_lui_mission_end_dlog(var_0);
}

function analytics_lui_mission_end_dlog(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  level.ref_12D8B = 1;
  level.dogtag_revive = 0;
  setDvar("scr_sat_debug", 0);
  scripts\cp\cp_spawning_util::ref_13BBD(1);
  thread playtutsound();
  setup_flags();
  trigger_spawn_init();
  register_spawn_groups();
  thread ref_11D2F();
  level.rooftop1_sat = sat_setup(1);
  level.rooftop2_sat = sat_setup(2);
  level.rooftop3_sat = sat_setup(3);
  ref_12E95();
  thread wait_for_any_sat_death(level);
  level.sats_connected = 0;
  scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);

  foreach(var_2 in level.players) {
    var_2 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
  }

  level waittill("sats_connected");
  wait 1;
}

function sat_setup(var_0) {
  var_1 = getEnt("rooftop_" + var_0 + "_satellite", "targetname");
  var_1.ref_13393 = 1;
  var_1.ref_13394 = 0;
  var_1.computer = getEnt("rooftop_" + var_0 + "_sat_com", "targetname");
  var_1.computer setModel("military_hq_crate_01_proxy_cp_noantenna");
  var_1.computer.ref_12A45 = scripts\engine\utility::getclosest(var_1.computer.origin, getEntArray("reader", "targetname"));

  switch (var_0) {
    case 1:
      var_1.computer.ref_12A45.ref_1281E = "military_keycard_reader_green";
      init_freight_lift("green", var_1.computer.ref_12A45);
      var_1.computer.ref_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "green_keycard_carry";
      break;
    case 2:
      var_1.computer.ref_12A45.ref_1281E = "military_keycard_reader_red";
      init_freight_lift("red", var_1.computer.ref_12A45);
      var_1.computer.ref_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "red_keycard_carry";
      break;
    case 3:
      var_1.computer.ref_12A45.ref_1281E = "military_keycard_reader_blue";
      init_freight_lift("blue", var_1.computer.ref_12A45);
      var_1.computer.ref_12A45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "blue_keycard_carry";
      break;
  }

  var_1.radar = ref_12E8B("satellite_piece_" + var_0, "military_deployable_satellite_radar_rig_skeleton");
  var_1.radio = ref_12E8B("satellite_piece_" + var_0, "military_deployable_satellite_radio_rig_skeleton");
  var_1.buy_point_loop = ref_12E8B("satellite_piece_" + var_0, "military_deployable_satellite_antenna_rig_skeleton");
  var_1.buy_point_loop.get_total_successful_vehicle_spawns_from_module = "satellite_radar_carry";
  var_1.radio.get_total_successful_vehicle_spawns_from_module = "satellite_controller_carry";
  var_1.radar.get_total_successful_vehicle_spawns_from_module = "satellite_antenna_carry";
  var_1.flagname = "r" + var_0 + "_connected";
  var_1.computer.flagname = var_1.flagname;
  var_1.power_switch = scripts\engine\utility::getStruct("rooftop" + var_0 + "_power", "targetname");
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::initialize_alarm_box(var_1.power_switch, 0);
  thread sat_damage_monitor(var_1);
  sat_computer_init(var_1, var_0);
  thread ref_12E96(var_1, var_0);
  return var_1;
}

function init_freight_lift(var_0, var_1) {
  var_1.get_destinations_in_current_circle = var_1.origin + (0, 0, 9.5) + anglestoleft(var_1.angles) * 1.5;
  var_1.get_destination_in_current_circle = var_1.angles + (90, 0, 90);
  var_1.onsoccerballreset = previous_bullet_weapon(var_1);
  var_2 = ref_12FF8(var_1.onsoccerballreset);

  if(isDefined(var_2)) {
    var_1.onsoccerballreset.origin = var_2.origin;
    var_1.onsoccerballreset.angles = var_2.angles;
    return;
  }
}

function update_computer_hint(var_0, var_1, var_2) {
  var_0 setHintString(var_1);
  var_0 sethinttag(var_2);
}

function sat_wait_for_all_connected() {
  scripts\engine\utility::flag_wait_all("r1_connected", "r2_connected", "r3_connected");

  while(!istrue(level.rooftop1_sat.activated) || !istrue(level.rooftop2_sat.activated) || !istrue(level.rooftop3_sat.activated)) {
    wait 1;
  }

  level notify("sats_connected");
  wait 2;
}

function wait_for_any_sat_death(var_0) {
  level endon("game_ended");
  level waittill("sat_death");
  logevent_servermatchstart(18);
  level thread[[level.endgame]]("ally", level.end_game_string_index["kia"]);
}

function sat_damage_monitor(var_0) {
  get_sat_objective(self, var_0);
  objective_state(self.objective_id, "current");
  objective_setprogress(self.objective_id, 0);
  objective_setshowprogress(self.objective_id, 1);
  var_1 = scripts\engine\utility::getclosest(self.origin, level.rooftop_triggers);
  var_1 scripts\engine\utility::trigger_on();
  scripts\engine\utility::flag_wait("transmission_started");
  thread bomb_plant_think();
}

function get_sat_objective(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("vehicle_icon", 20);
  objective_setplayintro(var_2, 1);
  objective_onentity(var_2, var_0);
  objective_setzoffset(var_2, 75);
  var_0.objective_id = var_2;
  objective_icon(var_2, self.script_noteworthy);
}

function bomb_plant_think() {
  self.bombplantent = spawn("script_model", scripts\engine\utility::getStruct(self.target, "targetname").origin);
  self.bombplantent setModel("tag_origin");
  self.bombplantent.angles = scripts\engine\utility::getStruct(self.target, "targetname").angles;
  level.cpoperationcratecapturecallback = 1;

  for(;;) {
    if(!istrue(level.cpoperationcratecapturecallback)) {
      wait 1;
      continue;
    }

    if(!isDefined(self.ref_11E6E) || gettime() > self.ref_11E6E) {
      level.cpoperationcratecapturecallback = 0;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_bomb_plant(self.bombplantent);
    }

    if(istrue(self.bombplantent.planted)) {
      self.bombplantent notify("stop_attracting");
      thread cprooftopcratecapturecallback();

      while(istrue(self.bombplantent.planted)) {
        wait 1;
      }

      footprint_mask_clipheight();
      self.ref_11E6E = gettime() + randomintrange(30000, 45000);
    }

    level.cpoperationcratecapturecallback = 1;
    wait 1;
  }
}

function cprooftopcratecapturecallback() {
  var_0 = self.objective_id;
  var_1 = self.bombplantent.charge;
  level endon("game_ended");
  var_1.leave_pool_behind_after_deactivation = 30;
  follow_players_when_close(var_1, var_0);
  thread focus_fire_icon_objective_id(var_1);
  var_2 = &"CP_STRIKE/DEFUSE";
  var_1 setHintString(var_2);
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(128);
  var_1 sethintdisplayfov(65);
  var_1 setuserange(64);
  var_1 setusefov(65);
  var_1 sethintonobstruction("show");
  var_1 setuseholdduration("duration_medium");
  var_1 makeusable();
  var_1 endon("detonated");
  var_1 endon("death");
  thread keypad_confirm_code_correct(var_1);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/DEFUSE_BOMB", "allies", 5);
  var_1 hudoutlineenable("outline_depth_red");

  for(;;) {
    var_1 waittill("trigger", var_3);
  }

  LOC_000000d4:
    var_1 notify("defused");

  if(isDefined(self.bombplantent.planted)) {
    self.bombplantent.planted = undefined;
  }

  var_1 hudoutlinedisable();
  var_1 delete();
}

function keypad_confirm_code_correct(var_0) {
  var_0 endon("deeath");
  var_0 endon("detonated");

  for(;;) {
    objective_setpulsate(self.objective_id, 1);
    wait 3;
    objective_setpulsate(self.objective_id, 0);
    wait 3;
  }
}

function follow_players_when_close(var_0) {
  scripts\cp\cp_objectives::objective_set_play_intro(var_0, 1);
  objective_setlabel(var_0, &"CP_STRIKE/DEFUSE");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 1);
  objective_setownerteam(var_0, "axis");
  objective_setpulsate(var_0, 1);
}

function footprint_mask_clipheight() {
  objective_setpulsate(self.objective_id, 0);
  objective_setprogress(self.objective_id, 0);
  objective_setlabel(self.objective_id, "");
  objective_setownerteam(self.objective_id, "allies");
}

function focus_fire_icon_objective_id(var_0) {
  self endon("death");
  self endon("defused");
  level endon("game_ended");
  var_1 = self.leave_pool_behind_after_deactivation;
  var_2 = var_1;
  var_3 = var_1;

  if(soundexists("dx_mpa_wctl_bomb_enemyplanted")) {
    foreach(var_5 in level.players) {
      var_5 playlocalsound("dx_mpa_wctl_bomb_enemyplanted");
    }
  }

  wait 3;

  while(var_3 > 0) {
    var_3--;
    objective_setprogress(var_0, var_3 / var_2);

    if(soundexists("breach_warning_beep_05")) {
      foreach(var_5 in level.players) {
        var_5 playlocalsound("breach_warning_beep_05");
      }
    }

    wait 1;
  }

  var_9 = "frag";
  var_10 = 0.1;
  var_11 = magicgrenademanual(var_9, self.origin + (0, 0, 6), (0, 0, 0), var_10);
  var_11.angles = self.angles;
  self notify("detonated");

  if(isDefined(self.planted)) {
    self.planted = undefined;
  }

  if(isDefined(self.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
  }

  playFX(level._effect["rocket_exp"], self.origin);
  self playSound("rocket_explode");
  earthquake(0.45, 3, self.origin, 1024);
  self hide();
  level notify("sat_death");
}

function setup_flags() {
  scripts\engine\utility::flag_init("transmission_started");
  scripts\engine\utility::flag_init("transmission_complete");
  scripts\engine\utility::flag_init("r1_connected");
  scripts\engine\utility::flag_init("r2_connected");
  scripts\engine\utility::flag_init("r3_connected");
}

function register_spawn_groups() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  scripts\cp\cp_modular_spawning::registerambientgroup("r1_ascender_reinforcements", 3, 3, 3, 0.1, undefined, "r1_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_ascender_reinforcements_2", 3, 3, 3, 0.1, undefined, "r1_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_paratrooper_reinforcements", 3, 3, 3, 0.1, undefined, "r1_paratrooper_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_paratrooper_reinforcements_2", 3, 3, 3, 0.1, undefined, "r1_paratrooper_reinforcements_2");
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_paratrooper_reinforcements_3", 3, 3, 3, 0.1, undefined, "r1_paratrooper_reinforcements_3");
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_heli_reinforce", 4, 4, 5, 0.1, undefined, "r1_heli_reinforce", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("r1_heli_reinforce_2", 4, 4, 5, 0.1, undefined, "r1_heli_reinforce_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_ascender_reinforcements", 3, 3, 3, 0.1, undefined, "r2_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_ascender_reinforcements_2", 3, 3, 3, 0.1, undefined, "r2_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_paratrooper_reinforcements", 3, 3, 3, 0.1, undefined, "r2_paratrooper_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_paratrooper_reinforcements_2", 3, 3, 3, 0.1, undefined, "r2_paratrooper_reinforcements_2");
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_paratrooper_reinforcements_3", 3, 3, 3, 0.1, undefined, "r2_paratrooper_reinforcements_3");
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_heli_reinforce_2", 4, 4, 4, 0.1, undefined, "r2_heli_reinforce_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("r2_heli_reinforce", 4, 4, 4, 0.1, undefined, "r2_heli_reinforce", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_ascender_reinforcements", 3, 3, 3, 0.1, undefined, "r3_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_ascender_reinforcements_2", 3, 3, 3, 0.1, undefined, "r3_ascender_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_paratrooper_reinforcements", 3, 3, 3, 0.1, undefined, "r3_paratrooper_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_paratrooper_reinforcements_2", 3, 3, 3, 0.1, undefined, "r3_paratrooper_reinforcements_2");
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_paratrooper_reinforcements_3", 3, 3, 3, 0.1, undefined, "r3_paratrooper_reinforcements_3");
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_heli_reinforce", 4, 4, 4, 0.1, undefined, "r3_heli_reinforce", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("r3_heli_reinforce_2", 4, 4, 4, 0.1, undefined, "r3_heli_reinforce_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r1_ascender_reinforcements", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r1_ascender_reinforcements_2", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r2_ascender_reinforcements", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r2_ascender_reinforcements_2", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r3_ascender_reinforcements", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("r3_ascender_reinforcements_2", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::registerambientgroup("mortar_ai_reinforce", 3, 3, undefined, [ &wave_reinforce, 0.5, 25, 3], undefined, "mortar_ai_reinforce");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mortar_ai_reinforce", &canprogressingunrank);
  scripts\cp\cp_modular_spawning::registerambientgroup("paratrooper_snipers", 3, 3, 3, 0.5, 0, "paratrooper_snipers");
  scripts\cp\cp_modular_spawning::registerambientgroup("ascender_rpg", 3, 3, 3, 0.5, undefined, "ascender_rpg");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ascender_rpg", &canplaykillstreakdialog);
  scripts\cp\cp_modular_spawning::registerambientgroup("ai_heli_reinforce", 4, 4, 4, 0.1, undefined, "ai_heli_reinforce", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("ai_heli_reinforce_2", 4, 4, 4, 0.1, undefined, "ai_heli_reinforce_2", undefined, undefined, 15);
  var_0 = getEnt("ai_rooftop_trig", "targetname");
  thread ref_12B4B(var_0, ["paratrooper_snipers", "ai_heli_reinforce", "ai_heli_reinforce_2", "ascender_rpg"]);
}

function wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_0.groupspawned)) {
    var_0.groupspawned = 0;
  }

  if(!isDefined(var_0.num_waves)) {
    var_0.num_waves = 1;
  }

  if(var_0.currentmodulekills >= var_3 * var_0.num_waves) {
    var_0.num_waves++;
    return var_2;
  }

  if(var_0.activecount <= var_0.min_size) {
    var_0.groupspawned++;

    if(var_0.groupspawned < 3) {
      return var_1;
    } else {
      var_0.groupspawned = 0;
      return 4;
    }
  }

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount >= var_0.min_size) {
      wait 0.25;
    }

    var_0.num_waves++;
    return var_2;
  }

  var_0.groupspawned++;

  if(var_0.groupspawned < 3) {
    return var_1;
  }

  var_0.groupspawned = 0;
  return 4;
}

function ref_11D2D(var_0) {
  if(!isDefined(var_0.targets)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["position"];
}

function ref_11D2F() {
  ref_11D2E("rooftop_1_mortar", 1);
  ref_11D2E("rooftop_2_mortar", 2);
  ref_11D2E("rooftop_3_mortar", 3);
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("mortar_ai_reinforce");
}

function ref_11D2E(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 hidepart("j_mortar_shell", "misc_wm_mortar");
  thread mortar_think(var_2);
}

function mortar_think(var_0) {
  self.targets = undefined;

  for(;;) {
    var_1 = get_players_on_rooftop(var_0);

    if(var_1.size) {
      self.targets = var_1;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self);
      self.targets = undefined;
      wait randomintrange(15, 25);
      continue;
    }

    wait 1;
  }
}

function get_players_on_rooftop(var_0) {
  var_1 = getEnt("rooftop_" + var_0 + "_trig", "targetname");
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || !var_4 isonground() || var_4 isonladder()) {
      continue;
    }

    if(var_4 istouching(var_1)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function ref_12E95() {
  scripts\engine\utility::array_thread(getEntArray("usb_drive", "targetname"), &ref_12E94);
}

function ref_12E94() {
  self setHintString(&"CP_DWN_TWN_OBJECTIVES/RED_KEYCARD");
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(128);
  self sethintdisplayfov(65);
  self setuserange(96);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_0.armorweapon)) {
      if(getdvarint("allow_card_swap") > 0) {
        ref_139C0(var_0, self);
      } else {
        var_0 scripts\cp\utility::setlowermessage("alreadyhave", &"CP_DWN_TWN_OBJECTIVES/ALREADY_HAVE_USB", 5);
        var_0 playlocalsound("cp_pickup_deny");
        continue;
      }
    }

    var_0 playlocalsound("cp_generic_placement");
    self.get_track_location_index = scripts\cp\utility::ref_13070(var_0, self.get_total_successful_vehicle_spawns_from_module);
    var_0.armorweapon = self;
    thread ref_12C37();
    self makeunusable();
    self hide();
    return;
  }
}

function ref_139C0(var_0) {
  var_1 = self.armorweapon;
  var_2 = var_1.get_track_location_index;

  if(isDefined(self)) {
    scripts\cp\utility::ref_12BC6(self, var_2.slot);
  }

  var_0 hide();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.get_track_location_index = undefined;
  var_1 show();
  var_1 scripts\engine\utility::delaythread(1, &ref_12E94);
}

function ref_12C37() {
  self endon("placed_card");
  var_0 = self.armorweapon;
  var_1 = var_0.get_track_location_index;
  scripts\engine\utility::ref_143A5("death", "disconnect");

  if(isDefined(self)) {
    scripts\cp\utility::ref_12BC6(self, var_1.slot);
  }

  var_0 show();
  thread ref_12E94();
}

function ref_12C38(var_0, var_1, var_2, var_3) {
  self endon("placed_sat_piece");
  var_4 = self.ref_12E91;
  var_5 = var_4.get_track_location_index;
  scripts\engine\utility::ref_143A5("death", "disconnect");

  if(isDefined(self)) {
    scripts\cp\utility::ref_12BC6(self, var_5.slot);
  }

  thread ref_12E92(var_0, var_1, var_2, var_3);
  var_4 show();
}

function trigger_spawn_init() {
  level.rooftop_triggers = [];
  var_0 = scripts\engine\utility::getStructArray("rooftop_group1_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2.origin, 0, int(var_2.radius), int(var_2.height));
    var_3.target = var_2.target;
    var_3.script_noteworthy = var_2.script_noteworthy;

    if(var_3.script_noteworthy == "icon_waypoint_dom_a") {
      var_3.rooftopid = 1;
    } else if(var_3.script_noteworthy == "icon_waypoint_dom_c") {
      var_3.rooftopid = 2;
    } else {
      var_3.rooftopid = 3;
    }

    var_3.targetname = "rooftop_" + var_3.rooftopid + "_trig";
    level.rooftop_triggers[level.rooftop_triggers.size] = var_3;
    canplaygasmaskgesturebr("ascender", var_3.origin);
    canplaygasmaskgesturebr("descender", var_3.origin);
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname").size;
    scripts\cp\cp_modular_spawning::registerambientgroup(var_3.target, var_4, var_4, var_4, 0.5, undefined, var_3.target);
    thread trigger_spawn();
    var_3 scripts\engine\utility::trigger_off();
  }
}

function trigger_spawn() {
  self endon("stop_spawning");
  self endon("death");
  self waittill("trigger", var_0);
  var_1 = self.target;
  var_2 = scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  wait 60;
  ref_12B4B(["r" + self.rooftopid + "_ascender_reinforcements", "r" + self.rooftopid + "_ascender_reinforcements_2", "r" + self.rooftopid + "_paratrooper_reinforcements", "r" + self.rooftopid + "_paratrooper_reinforcements_2", "r" + self.rooftopid + "_paratrooper_reinforcements_3", "r" + self.rooftopid + "_heli_reinforce", "r" + self.rooftopid + "_heli_reinforce_2"], 1, 1);
}

function kill_rate_too_slow() {
  wait 2;
  self makeusable();
}

function ref_12E8C(var_0) {
  var_1 = int(100 - anglesdelta((0, var_0.buy_point_loop.angles[1], 0), (0, var_0.ref_13394, 0)));

  if(var_1 > 100) {
    var_1 = 100;
  }

  if(var_1 < 1) {
    var_1 = 1;
  }

  return var_1;
}

function ref_12EA3() {
  level endon("game_ended");
  level.hack_duration = 120;
  thread ref_12E98();
  thread ref_12EA4();
  var_0 = 0;

  while(var_0 < level.hack_duration) {
    var_1 = ref_12E8C(level.rooftop1_sat);
    var_2 = ref_12E8C(level.rooftop2_sat);
    var_3 = ref_12E8C(level.rooftop3_sat);
    var_4 = (var_1 + var_2 + var_3) / 3;
    var_4 = int(max(1, var_4));

    if(var_4 < 80) {
      thread ref_12E97();
      level.hacking_paused = 1;
    } else {
      if(!scripts\engine\utility::flag("transmission_started")) {
        scripts\engine\utility::flag_set("transmission_started");
      }

      level notify("hacking_resumed");
      level.hacking_paused = 0;
    }

    setomnvar("ui_signal_strength_total", var_4);
    wait 0.25;

    if(!level.hacking_paused) {
      var_0 += 0.25;
    }
  }

  level notify("transfer_complete");
  scripts\engine\utility::flag_set("transmission_complete");
}

function ref_12EA4() {
  scripts\engine\utility::flag_wait("transmission_started");
  level scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  thread ref_12E8D();
  scripts\cp\utility::objective_update("rooftop_raid_activatesats_start");
}

function ref_12E97() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag("transmission_started")) {
    return;
  }

  if(istrue(level.ref_13392)) {
    return;
  }

  level.ref_13392 = 1;

  while(level.hacking_paused) {
    foreach(var_1 in level.players) {
      var_1 sethudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/TUTORIAL_REALIGN_SATELLITES");
    }

    wait 5;

    foreach(var_1 in level.players) {
      var_1 clearhudtutorialmessage();
    }

    wait 15;

    if(!level.hacking_paused) {
      scripts\cp\cp_objectives::reset_objective_timers();
      thread scripts\cp\utility::objective_update("rooftop_raid_activatesats_start");
      level.ref_13392 = 0;
      return;
    }
  }

  scripts\cp\cp_objectives::reset_objective_timers();
  thread scripts\cp\utility::objective_update("rooftop_raid_activatesats_start");
  level.ref_13392 = 0;
}

function ref_12E87(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 forceusehinton(&"CP_DWN_TWN_OBJECTIVES/HINT_ADJUST_SAT");
  var_0 playerlinkTo(self);
  var_0 playerlinkedoffsetenable();

  while(!istrue(var_0.ref_140AE)) {
    wait 0.05;
  }

  for(;;) {
    if(!istrue(var_0.ref_140AE) || istrue(var_0.inlaststand)) {
      var_0 forceusehintoff();
      var_0 unlink();
      var_0 notify("stop_adjusting");
      thread kill_rate_too_slow();
      var_1.ref_12746 = undefined;
      var_1.buy_point_loop stoploopsound();
      var_1 notify("stop_sounds");
      return;
    }

    if(var_0 scripts\engine\utility::is_player_gamepad_enabled() && var_0 fragButtonPressed() || !var_0 scripts\engine\utility::is_player_gamepad_enabled() && var_0 meleeButtonPressed()) {
      var_1.buy_point_loop rotateYaw(-1.25, 0.05);

      if(!isDefined(var_1.ref_12746)) {
        thread ref_12E99();
      }
    } else if(var_0 secondaryoffhandbuttonPressed()) {
      var_1.buy_point_loop rotateYaw(1.25, 0.05);

      if(!isDefined(var_1.ref_12746)) {
        thread ref_12E99();
      }
    } else if(isDefined(var_1.ref_12746)) {
      var_1 notify("stop_sounds");
      var_1.buy_point_loop stopsounds();
      waitframe();
      var_1.buy_point_loop stoploopsound();
      var_1.buy_point_loop playSound("scn_cp_satellite_in_use_stop");
      var_1.ref_12746 = undefined;
    }

    wait 0.05;
    var_1.ref_13393 = ref_12E8C(var_1);
    setomnvar(var_3, var_1.ref_13393);
    LOC_00000174:
  }
}

function ref_12E99() {
  self endon("stop_sounds");
  self.ref_12746 = 1;
  self.buy_point_loop stopsounds();
  waitframe();
  self.buy_point_loop playSound("scn_cp_satellite_in_use_start");
  wait 0.5;
  self.buy_point_loop playLoopSound("scn_cp_satellite_in_use_lp");
}

function ref_12E8E(var_0) {
  var_0 endon("stop_adjusting");
  var_0 waittill("disconnect");
  thread kill_rate_too_slow();
}

function ref_12E98() {
  level endon("game_ended");
  level endon("transfer_complete");

  if(level.hack_duration < 10) {
    return;
  }

  var_0 = [level.rooftop1_sat, level.rooftop2_sat, level.rooftop3_sat];
  var_1 = [125, 285, 75, 185, 300];
  var_2 = 0;
  var_3 = level.hack_duration;
  var_4 = 0;
  var_5 = randomintrange(int(level.hack_duration * 0.4), int(level.hack_duration * 0.7));

  for(;;) {
    while(istrue(level.hacking_paused)) {
      wait 0.05;
    }

    wait 1;
    var_2 += 1;

    if(var_2 == var_5) {
      var_6 = scripts\engine\utility::random(var_0);
      var_6.ref_13394 = scripts\engine\utility::random(var_1);
      var_6.ref_13393 = ref_12E8C(var_6);
      setomnvar(var_6.ref_13395, var_6.ref_13393);
      var_4++;

      if(var_4 == 1) {
        return;
      }
    }
  }
}

function ref_12E8D() {
  level endon("game_ended");
  level endon("transfer_complete");

  for(;;) {
    if(istrue(level.hacking_paused)) {
      thread scripts\cp\utility::objective_update("rooftop_raid_activatesats_error", 60, 20, 10);
      thread path_data_ordered(60);

      while(istrue(level.hacking_paused)) {
        wait 0.05;
      }

      scripts\cp\cp_objectives::reset_objective_timers();
      thread scripts\cp\utility::objective_update("rooftop_raid_activatesats_start");
    }

    wait 0.05;
  }
}

function path_data_ordered(var_0) {
  level endon("game_ended");
  level endon("hacking_resumed");
  wait 60;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/MISSION_FAILED_TRANSMISSION", "allies", 5);
  wait 3;
  logevent_servermatchstart(17);
  level thread[[level.endgame]]("ally", level.end_game_string_index["kia"]);
}

function playtutsound() {
  for(var_0 = 5; var_0 > 0; var_0--) {
    wait 1;
  }

  thread plundercountdownplayers();
  var_1 = scripts\engine\utility::getStruct("rooftop_raid_player_heli", "targetname");
  var_2 = var_1.origin + (-2000, 0, 0);
  var_3 = var_1.angles[1];
  thread playvointernal(level, var_2);
  wait randomintrange(3, 6);
  var_2 = var_1.origin + (2000, 0, 0);
  thread playvointernal(level, var_2);
}

function plundercountdownplayers() {
  level waittill("gas_attack_deployed");
  wait 5;
  var_0 = getEnt("gas_trigger", "targetname");
  thread plunder_value_picked_up(level, var_0);
  var_1 = scripts\engine\utility::getStructArray("wp_spots", "targetname");

  foreach(var_3 in var_1) {
    var_3.plunder_playercanuserepository = spawnfx(level._effect["city_gas"], var_3.origin);
    waitframe();
    triggerfx(var_3.plunder_playercanuserepository);
    waitframe();
  }

  var_5 = (15390, 18406, 1200);
  var_6 = 3250;
  var_7 = 5;
  var_8 = [];
  var_9 = var_5 - (0, 0, 800);
  thread ref_13EB3(level, var_9, var_6, 800);
  var_10 = 0;
  var_11 = (var_6, 0, 0);

  for(var_12 = 0; var_12 < var_7 + 1; var_12++) {
    var_13 = var_5 + rotatevector(var_11, (0, var_10, 0));
    var_13 = getgroundposition(var_13, 8, 12000, 12000);
    var_14 = spawnfx(level._effect["city_gas"], var_13);
    waitframe();
    triggerfx(var_14);
    waitframe();
    var_8 = var_14;
    var_10 += 360 / var_7;
  }
}

function ref_13EB3(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - (0, 0, 1000);
  var_5 = spawn("trigger_radius", var_4, 0, 7000, 1000);

  if(istrue(1)) {
    var_5.is_cp_raid = 25;
    thread plunder_value_picked_up(level, var_5);
  }

  var_6 = 0.1;
  var_7 = 5;
  var_8 = var_7;
  var_9 = var_2 / var_3 / var_6;
  var_10 = spawnfx(level._effect["city_gas"], var_0);
  waitframe();
  triggerfx(var_10);
  waitframe();

  while(var_3 > 0) {
    var_5.origin += (0, 0, var_9);
    var_0 += (0, 0, var_9);
    var_3 -= var_6;
    var_8 -= var_6;

    if(var_8 <= 0) {
      var_10 delete();
      waitframe();
      var_10 = spawnfx(level._effect["city_gas"], var_0);
      waitframe();
      triggerfx(var_10);
      var_8 = var_7;
    }

    wait var_6;
  }
}

function plunder_value_picked_up(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    if(isDefined(var_2.plunder_seventyfivepercent_music)) {
      continue;
    }

    var_2.plunder_seventyfivepercent_music = 1;

    if(!scripts\engine\utility::flag("transmission_complete")) {
      var_2.shouldskiplaststand = 1;
    }

    thread plunder_value_dropped(var_2, var_0);
  }
}

function plunder_value_dropped(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  var_2 = 0.2;
  var_3 = 50;
  self visionsetnakedforplayer(var_1, 3);

  if(!istrue(self.gasmaskequipped) && var_1 != "") {
    self notify("toggle_gasmask");
    wait 0.6;
  }

  for(;;) {
    if(isDefined(var_0.is_cp_raid)) {
      var_3 = var_0.is_cp_raid;
    }

    if(self istouching(var_0)) {
      if(!istrue(self.gasmaskequipped)) {
        self dodamage(int(var_2 * var_3), self.origin, self, undefined, "MOD_TRIGGER_HURT");
        plundercountdownmessagedata();
        scripts\cp_mp\utility\shellshock_utility::_shellshock("gas_grenade_heavy_mp", "gas", 0.2, 0);
      }

      wait var_2;
      continue;
    }

    break;
  }

  self.plunder_seventyfivepercent_music = undefined;
  wait 0.5;

  if(isDefined(self.plunder_seventyfivepercent_music)) {
    return;
  }

  if(istrue(self.gasmaskequipped) && var_1 != "") {
    self notify("toggle_gasmask");
  }

  self visionsetnakedforplayer("", 1);

  if(!scripts\engine\utility::flag("transmission_complete")) {
    self.shouldskiplaststand = undefined;
    return;
  }
}

function plundercountdownmessagedata() {
  var_0 = self;

  if(!isalive(var_0)) {
    return;
  }

  if(isDefined(var_0.did_ads_hint) && gettime() < var_0.did_ads_hint) {
    return;
  }

  var_0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var_0)) {
    var_0 playsoundtoplayer("gas_player_cough", var_0, var_0);
  }

  var_1 = "allies_male_cough";
  var_2 = var_0.defaultoperatorteam;
  var_3 = var_0.operatorcustomization.gender;

  if(var_2 == "axis") {
    if(isDefined(var_3) && var_3 == "female") {
      var_1 = "axis_female_cough";
    } else {
      var_1 = "axis_male_cough";
    }
  } else if(isDefined(var_3) && var_3 == "female") {
    var_1 = "allies_female_cough";
  } else {
    var_1 = "allies_male_cough";
  }

  var_4 = randomint(game["dialogue"][var_1].size);
  var_5 = game["dialogue"][var_1][var_4];
  var_0 playsoundonmovingent(var_5);
}

function sat_computer_init(var_0, var_1) {
  var_0.computer makeusable();
  var_0.computer setCursorHint("HINT_BUTTON");
  var_0.computer sethintdisplayrange(256);
  var_0.computer sethintdisplayfov(90);
  var_0.computer setuserange(72);
  var_0.computer setusefov(90);
  var_0.computer sethinttag("antenna_rot_base_joint");
  var_0.computer sethintonobstruction("hide");
  var_0.computer setuseholdduration("duration_short");
  var_0.computer setusepriority(-10);
  var_0.computer.has_antennae = 1;
  var_0.computer.has_dongle = 0;

  if(getdvarint("scr_sat_debug") > 0) {
    var_0.computer.has_dongle = 1;
  }

  var_0.computer.ref_11E3B = 1;
  thread ref_12E89(var_0.computer, var_1);
}

function ref_12E89(var_0, var_1) {
  var_1.ref_13395 = "ui_signal_strength" + var_0;

  if(istrue(self.has_antennae)) {
    if(istrue(self.ref_11E3B)) {
      ref_12EA0(var_1);
    } else {
      var_1.computer.ref_12A45 setModel(var_1.computer.ref_12A45.ref_1281E);
    }

    if(!istrue(self.has_dongle)) {
      ref_12E9A(var_1, var_0);
    } else {
      self setscriptablepartstate("main", "on_noidle");
      scripts\engine\utility::flag_set(self.flagname);
      level.sats_connected++;

      if(!istrue(var_1.activated) && (!istrue(var_1.radio.connected) || !istrue(var_1.buy_point_loop.connected) || !istrue(var_1.radar.connected))) {
        thread ref_12E9B();
      } else {
        var_1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
      }

      while(!istrue(var_1.activated)) {
        wait 1;
      }

      scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);
      objective_setownerteam(var_1.objective_id, "allies");
    }
  }

  var_1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
  wait 6;
  self makeusable();
  var_1.ref_13393 = ref_12E8C(var_1);
  setomnvar("ui_signal_strength" + var_0, var_1.ref_13393);
  var_1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
  thread ref_12E9D();
  sat_wait_for_all_connected();
  var_1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/ADJUST_DISH");

  for(;;) {
    self waittill("trigger", var_2);
    self makeunusable();
    thread ref_12E87(var_2, var_1, undefined, "ui_signal_strength" + var_0);
    thread ref_12E8E(var_2);
    scripts\cp\cp_computerscreen::hit_by_emp_monitor(var_2);
    LOC_000001cd:
  }
}

function ref_12E8B(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.model == var_1) {
      return var_4;
    }
  }
}

function ref_12EA0(var_0) {
  update_computer_hint(self, &"CP_DWN_TWN_OBJECTIVES/REQUIRES_POWER", "screen_joint");
  thread ref_12EA1(var_0.power_switch.alarm_box);
  var_0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("switch_on");
  var_0.power_switch.alarm_box makeunusable();
  var_0.powered_on = 1;
  var_0.computer.ref_12A45 setModel(var_0.computer.ref_12A45.ref_1281E);
}

function ref_12EA1(var_0) {
  self endon("switch_on");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_0 makeunusable();
    thread kill_rate_too_slow();
    var_1 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/REQUIRES_POWER", 5);
    var_1 playlocalsound("cp_pickup_deny");
  }
}

function ref_12E9B() {
  self endon("sat_activated");
  update_computer_hint(self, &"CP_DWN_TWN_OBJECTIVES/SAT_LINK_FAILED", "screen_joint");

  for(;;) {
    self waittill("trigger", var_0);
    self makeunusable();
    thread kill_rate_too_slow();
    var_0 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/SAT_LINK_FAILED", 5);
    var_0 playlocalsound("cp_pickup_deny");
  }
}

function ref_12E9D() {
  level endon("sats_connected");

  for(;;) {
    self waittill("trigger", var_0);
    self makeunusable();
    thread kill_rate_too_slow();
    var_0 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/SAT_WAITING", 5);
    var_0 playlocalsound("cp_pickup_deny");
  }
}

function ref_12E9A(var_0, var_1) {
  self makeunusable();
  var_0.computer.ref_12A45 setHintString(&"CP_DWN_TWN_OBJECTIVES/MISSING_DONGLE");
  var_0.computer.ref_12A45 setCursorHint("HINT_BUTTON");
  var_0.computer.ref_12A45 sethintdisplayrange(96);
  var_0.computer.ref_12A45 sethintdisplayfov(65);
  var_0.computer.ref_12A45 setuserange(96);
  var_0.computer.ref_12A45 setusefov(65);
  var_0.computer.ref_12A45 sethintonobstruction("show");
  var_0.computer.ref_12A45 setuseholdduration("duration_short");
  var_0.computer.ref_12A45 makeusable();
  var_0.computer.ref_12A45 setusepriority(-10);

  for(;;) {
    var_0.computer.ref_12A45 waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_0.computer.ref_12A45 makeunusable();

    if(!isDefined(var_2.armorweapon) && !istrue(getdvarint("scr_sat_haveall") > 0)) {
      var_2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/NO_ITEM", 5);
      var_2 playlocalsound("cp_pickup_deny");
      wait 1;
      var_0.computer.ref_12A45 makeusable();
      continue;
    }

    if(!istrue(getdvarint("scr_sat_haveall") > 0) && var_2.armorweapon != var_0.computer.ref_12A45.onsoccerballreset) {
      var_2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/WRONG_DONGLE", 5);
      var_2 playlocalsound("cp_pickup_deny");
      wait 1;
      var_0.computer.ref_12A45 makeusable();
      continue;
    }

    if(istrue(getdvarint("scr_sat_haveall") > 0)) {
      var_2.armorweapon = var_0.computer.ref_12A45.onsoccerballreset;
    }

    var_2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/CORRECT_DONGLE", 5);
    var_2 notify("placed_card");
    var_2 playlocalsound("cp_computer_success");
    scripts\engine\utility::flag_set(self.flagname);
    level.sats_connected++;
    var_2.armorweapon.origin = var_0.computer.ref_12A45.get_destinations_in_current_circle;
    var_2.armorweapon.angles = var_0.computer.ref_12A45.get_destination_in_current_circle;
    var_2.armorweapon show();
    var_2.armorweapon makeunusable();
    var_3 = var_2.armorweapon.get_track_location_index;
    var_2.armorweapon = undefined;
    wait 1;
    self setscriptablepartstate("main", "on_noidle");
    self makeusable();
    var_0.setupzombiepowers = 1;

    if(!istrue(getdvarint("scr_sat_haveall") > 0)) {
      scripts\cp\utility::ref_12BC6(var_2, var_3.slot);
    }

    if(!istrue(var_0.activated) && (!istrue(var_0.radio.connected) || !istrue(var_0.buy_point_loop.connected) || !istrue(var_0.radar.connected))) {
      thread ref_12E9B();
    } else {
      var_0.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
    }

    while(!istrue(var_0.activated)) {
      wait 1;
    }

    var_0.computer notify("sat_activated");
    scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);
    objective_setownerteam(var_0.objective_id, "allies");
    return;
  }
}

function ref_12E96(var_0, var_1) {
  var_2 = ref_12E88();

  switch (var_2) {
    case "controller":
      var_0.ref_11E3A = 1;
      var_0.ref_11E39 = 0;
      var_0.ref_11E3C = 0;
      break;
    case "radar":
      var_0.ref_11E3A = 0;
      var_0.ref_11E39 = 0;
      var_0.ref_11E3C = 1;
      break;
    case "antenna":
      var_0.ref_11E3A = 0;
      var_0.ref_11E39 = 1;
      var_0.ref_11E3C = 0;
      break;
    case "debug":
      var_0.ref_11E3A = 0;
      var_0.ref_11E39 = 0;
      var_0.ref_11E3C = 0;
      break;
  }

  if(istrue(var_0.ref_11E39)) {
    thread ref_12E9C(var_0);
  } else if(!istrue(var_0.ref_11E39)) {
    var_0.buy_point_loop linkTo(var_0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
    var_0.buy_point_loop show();
    var_0.buy_point_loop.connected = 1;
  }

  if(istrue(var_0.ref_11E3A)) {
    thread ref_12E9E(var_0);
  } else {
    var_0.radio.origin = var_0 gettagorigin("j_frame_pivot");
    var_0.radio.angles = var_0 gettagangles("j_frame_pivot");
    var_0.radio linkTo(var_0);
    var_0.radio scriptmodelplayanim("cp_satellite_apparatus_folded");
    var_0.radio show();
    var_0.radio.connected = 1;
  }

  if(istrue(var_0.ref_11E3C)) {
    thread ref_12EA2(var_0);
  } else if(!istrue(var_0.ref_11E39)) {
    var_0.radar linkTo(var_0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
    var_0.radar show();
    var_0.radar.connected = 1;
  }

  while(!istrue(var_0.radio.connected) || !istrue(var_0.buy_point_loop.connected) || !istrue(var_0.radar.connected) || !istrue(var_0.powered_on) || !istrue(var_0.setupzombiepowers)) {
    wait 1;
  }

  wait 1;
  var_0.activated = 1;
  ref_12E86(var_0);
  ref_12E8F(var_0);
}

function ref_12E92(var_0, var_1, var_2, var_3) {
  self setHintString(var_0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(96);
  self sethintdisplayfov(65);
  self setuserange(96);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  self makeusable();
  self setusepriority(-10);
  jumpiffalse(isDefined(var_3)) LOC_0000005d;
  self sethinttag(var_3);

  for(;;) {
    self waittill("trigger", var_4);

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_4.ref_12E91)) {
      var_4 scripts\cp\utility::setlowermessage("haveant", &"CP_DWN_TWN_OBJECTIVES/HAVE_SAT_PIECE", 5);
      var_4 playlocalsound("cp_pickup_deny");
      continue;
    }

    var_4 playlocalsound("cp_generic_placement");
    var_4.ref_12E91 = self;
    thread ref_12C38(var_4, var_0, var_1, var_2);
    self.get_track_location_index = scripts\cp\utility::ref_13070(var_4, self.get_total_successful_vehicle_spawns_from_module);
    break;
  }

  self makeunusable();
  self hide();

  if(isDefined(var_2)) {
    foreach(var_6 in var_2) {
      var_6 hide();
    }

    return;
  }
}

function ref_12E9C(var_0, var_1) {
  var_0.radar linkTo(var_0.buy_point_loop, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var_0.radar.connected = 1;
  thread ref_12E92(var_0.buy_point_loop, &"CP_DWN_TWN_OBJECTIVES/PICKUP_RADAR", var_0);
  var_2 = anglestoleft(var_0.angles);
  var_2 = var_0.origin + var_2 * 35 + (0, 0, 25);
  var_3 = ref_12E8A(var_2);
  var_3 setHintString(&"CP_DWN_TWN_OBJECTIVES/PLACE_RADAR");
  ref_12E9F(var_3, var_0.buy_point_loop);
  var_3 delete();
  var_0.buy_point_loop linkTo(var_0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
  var_0.buy_point_loop show();
  var_0.buy_point_loop.connected = 1;
  var_0.radar linkTo(var_0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var_0.radar show();
}

function ref_12E9E(var_0) {
  thread ref_12E92(var_0.radio, &"CP_DWN_TWN_OBJECTIVES/PICKUP_CONTROLLER", var_0, undefined);
  var_1 = anglestoleft(var_0.angles);
  var_1 = var_0.origin + var_1 * 14 + (0, 0, 25);
  var_2 = ref_12E8A(var_1);
  var_2 setHintString(&"CP_DWN_TWN_OBJECTIVES/PLACE_CONTROLLER");
  ref_12E9F(var_2, var_0.radio);
  var_0.radio.origin = var_0 gettagorigin("j_frame_pivot");
  var_0.radio.angles = var_0 gettagangles("j_frame_pivot");
  var_0.radio linkTo(var_0);
  var_0.radio scriptmodelplayanim("cp_satellite_apparatus_folded");
  var_0.radio show();
  var_0.radio.connected = 1;
  var_2 delete();
}

function ref_12EA2(var_0) {
  var_0.buy_point_loop linkTo(var_0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
  var_0.buy_point_loop.connected = 1;
  thread ref_12E92(var_0.radar, &"CP_DWN_TWN_OBJECTIVES/PICKUP_ANT");
  var_1 = anglestoleft(var_0.angles);
  var_1 = var_0.origin + var_1 * 45 + (0, 0, 15);
  var_2 = ref_12E8A(var_1);
  var_2 setHintString(&"CP_DWN_TWN_OBJECTIVES/MISSING_ANT");
  ref_12E9F(var_2, var_0.radar);
  var_2 delete();
  var_0.radar linkTo(var_0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var_0.radar show();
  var_0.radar.connected = 1;
}

function ref_12E9F(var_0, var_1) {
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_2.ref_12E91) && var_2.ref_12E91 == var_1 || istrue(getdvarint("scr_sat_haveall") > 0)) {
      var_2 playlocalsound("cp_generic_placement");
      var_2 notify("placed_sat_piece");

      if(!istrue(getdvarint("scr_sat_haveall") > 0)) {
        scripts\cp\utility::ref_12BC6(var_2, var_2.ref_12E91.get_track_location_index.slot);
      } else {
        var_1 makeunusable();
      }

      var_2.ref_12E91 = undefined;
      break;
    }

    var_2 scripts\cp\utility::setlowermessage("haveant", &"CP_DWN_TWN_OBJECTIVES/NO_ITEM", 5);
    var_2 playlocalsound("cp_pickup_deny");
  }
}

function ref_12E8A(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(256);
  var_1 sethintdisplayfov(180);
  var_1 setuserange(96);
  var_1 setusefov(180);
  var_1 sethintonobstruction("show");
  var_1 setuseholdduration("duration_short");
  var_1 makeusable();
  var_1 setusepriority(-10);
  return var_1;
}

function ref_12E86(var_0) {
  var_0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("switch_on");
  thread ref_12E93(var_0);
  var_0.radio scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var_0.buy_point_loop scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var_0.radar scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var_0 setscriptablepartstate("base", "unfold");
  wait 6.65;
}

function ref_12E93(var_0) {
  var_0 playSound("scn_cp_satellite_unfold_start");
  wait 0.25;
  var_0 playLoopSound("scn_cp_satellite_unfold_lp");
  wait 4;
  var_0 stoploopsound();
  var_0 playSound("scn_cp_satellite_unfold_stop");
  wait 0.5;
  var_0.radar playLoopSound("scn_cp_satellite_idle");
}

function ref_12E8F(var_0) {
  var_0.buy_point_loop scriptmodelplayanim("cp_satellite_apparatus_loop");
  var_0.radar linkTo(var_0.buy_point_loop, "j_radar_rot_01");
  var_0.buy_point_loop.angles = var_0.angles + (0, 45, -15);
  var_0.buy_point_loop unlink();
}

function ref_12E88() {
  if(getdvarint("scr_sat_debug") > 0) {
    return "debug";
  }

  if(!isDefined(level.ref_12E90)) {
    level.ref_12E90 = ["controller", "radar", "antenna"];
  }

  var_0 = scripts\engine\utility::random(level.ref_12E90);
  level.ref_12E90 = scripts\engine\utility::array_remove(level.ref_12E90, var_0);
  return var_0;
}

function previous_bullet_weapon(var_0) {
  var_1 = getEntArray("usb_drive", "targetname");

  foreach(var_3 in var_1) {
    switch (var_0.ref_1281E) {
      case "military_keycard_reader_green":
        if(var_3.model == "electronics_keycard_office_01_green") {
          return var_3;
        }

        break;
      case "military_keycard_reader_red":
        if(var_3.model == "electronics_keycard_office_01_red") {
          return var_3;
        }

        break;
      case "military_keycard_reader_blue":
        if(var_3.model == "electronics_keycard_office_01") {
          return var_3;
        }

        break;
    }
  }
}

function ref_12FF8() {
  var_0 = undefined;

  switch (self.model) {
    case "electronics_keycard_office_01_green":
      var_0 = "green";
      break;
    case "electronics_keycard_office_01_red":
      var_0 = "red";
      break;
    case "electronics_keycard_office_01":
      var_0 = "blue";
      break;
  }

  var_1 = scripts\engine\utility::getStructArray("keycard_loc_" + var_0, "targetname");

  if(var_1.size > 0) {
    return scripts\engine\utility::random(var_1);
  }

  return undefined;
}

function canplaykillstreakdialog(var_0, var_1) {
  self.fnmeleecharge_init = &bisthread;
  var_2 = undefined;

  switch (var_0.group_name) {
    case "r1_ascender_reinforcements_2":
    case "r1_ascender_reinforcements":
      var_2 = "r1_reinforce_positions";
      break;
    case "r2_ascender_reinforcements_2":
    case "r2_ascender_reinforcements":
      var_2 = "r2_reinforce_positions";
      break;
    case "r3_ascender_reinforcements_2":
    case "r3_ascender_reinforcements":
      var_2 = "r3_reinforce_positions";
      break;
  }

  thread lootcontentsadjustkillchain(var_2);
}

function canprogressingunrank(var_0) {
  self.fnmeleecharge_init = &bisthread;
  var_1 = scripts\engine\utility::random(["mortar_positions_2", "mortar_positions_1"]);
  thread lootcontentsadjustkillchain(var_1);
}

function lootcontentsadjustkillchain(var_0) {
  self endon("death");
  var_1 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(self.origin);
  scripts\mp\vehicles\little_bird_mg_mp::blockade_gate_explode_sequence("up", var_1);

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var_0, "script_noteworthy"));
    self setgoalpos(var_2.origin);
    return;
  }
}

function bisthread(var_0) {
  self.meleechargedistvsplayer = 2000;
  self.melee.bignoretimeout = 1;
  self.melee.bignoretargetflee = 1;
}

function logevent_servermatchstart(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_cp_mission_fail_index", var_0);
  }
}

function canplaygasmaskgesturebr(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 256;
  }

  if(var_0 == "ascender") {
    var_3 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(var_1);
  } else {
    var_3 = scripts\mp\vehicles\little_bird_mg_mp::blockachievementstimestamp(var_2);
  }

  var_4 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_" + var_1, "classname", var_3.origin, var_3);
  var_5 = var_4[0];
  var_5 setscriptablepartstate("ascender", "noprompt");
}

function minigun_should_keep_firing() {
  level.ref_12D8C = &init_ai_spawns;
  var_0 = scripts\engine\utility::getStructArray("crate_drop", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\crate_drops\cp_crate_drops::dropcarepackage(var_2, undefined, "cp_rooftop_crate");
  }
}

function init_ai_spawns(var_0) {
  ref_1234D(var_0);
}

function ref_1234D() {
  self playlocalsound("weap_ammo_pickup");
  scripts\cp_mp\gasmask::init();
  thread headequiptoggleloop();
  self.plundermusicsecond = scripts\cp\utility::ref_13070(self, "gasmask");
}

function headequiptoggleloop() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("toggle_gasmask");

    if(!istrue(self.gasmaskequipped)) {
      thread scripts\cp_mp\gasmask::equipgasmask();
      continue;
    }

    thread scripts\cp_mp\gasmask::removegasmask();
  }
}

function fixupsupersandtacticalsforgunfightmaps() {
  var_0 = getEnt("elevator_interact", "targetname");
  var_0 setHintString(&"CP_DWN_TWN_OBJECTIVES/ELEVATOR_BASEMENT");
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(128);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(96);
  var_0 setusefov(65);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");
  var_0 makeusable();
  return var_0;
}

function flag_bot_attacker_limit_for_team() {
  self waittill("trigger", var_0);
  self makeunusable();
}

function ref_12B4B(var_0, var_1, var_2) {
  level endon("transfer_complete");

  foreach(var_4 in var_0) {
    if(isDefined(level.ambientgroups[var_4])) {
      continue;
    }

    var_0 = scripts\engine\utility::array_remove(var_0, var_4);
  }

  var_6 = 30;
  var_7 = 40;
  var_8 = 10;
  var_9 = 15;

  for(;;) {
    var_4 = ref_135BE(var_0);
    var_10 = [];

    if(issubstr(var_4, "heli")) {
      var_10 = scripts\engine\utility::array_remove(var_0, var_4);

      foreach(var_12 in var_0) {
        if(issubstr(var_12, "heli")) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
        }
      }
    } else {
      var_10 = scripts\engine\utility::array_remove(var_0, var_4);
    }

    wait randomintrange(var_8, var_9);
    var_4 = ref_135BE(var_10);
    ref_14328();
    ref_14327(var_1);
    wait randomintrange(var_6, var_7);
  }
}

function ref_135BE(var_0) {
  var_1 = ref_13E01(var_0);

  if(!isDefined(var_1)) {
    foreach(var_1 in var_0) {
      if(issubstr(var_1, "heli")) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      }
    }

    var_1 = scripts\engine\utility::random(var_0);
  }

  if(issubstr(var_1, "para")) {
    scripts\cp\cp_aiparachute::request_paratroopers(var_1, undefined, (-13512, 66432, 5904));
  } else {
    if(issubstr(var_1, "ai_heli")) {
      level.skipburndown[var_1] = gettime() + 180000;
    } else if(issubstr(var_1, "heli")) {
      level.skipburndown[var_1] = gettime() + 30000;
    }

    scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  }

  return var_1;
}

function gcd(var_0) {
  if(!isDefined(level.skipequippedstreakcheck)) {
    level.skipequippedstreakcheck = getEntArray("heli_landing_volumes", "targetname");
  }

  if(!isDefined(level.ref_124B2)) {
    level.ref_124B2 = [];
  }

  if(!isDefined(level.skipburndown)) {
    level.skipburndown = [];
  }

  if(!isDefined(level.skipburndown[var_0])) {
    level.skipburndown[var_0] = 0;
  }

  if(gettime() < level.skipburndown[var_0]) {
    return 0;
  }

  var_1 = 1;
  var_2 = getEnt(var_0, "script_noteworthy");

  foreach(var_4 in level.ref_124B2) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4 istouching(var_2)) {
      var_1 = 0;
    }
  }

  return var_1;
}

function ref_14327(var_0) {
  jumpiftrue(isDefined(var_0)) LOC_0000000a;
  var_0 = 0;

  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(var_4 istouching(self)) {
        var_2++;
      }
    }

    if(var_2 > var_0) {
      wait 1;
      continue;
    }

    return;
  }
}

function ref_14328() {
  for(;;) {
    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3 istouching(self)) {
        var_1++;
      }
    }

    if(var_1 < 1) {
      wait 1;
      continue;
    }

    wait 10;
    return;
  }
}

function sixthsense_shouldwarnaboutotherplayer(var_0) {
  var_1 = spawnStruct();
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  var_2 thread scripts\cp\cp_vehicles::waiting_for_disable();
  var_2.invulnerable = 1;
  var_2.maxhealth = 5000;
  var_2.health = 5000;
  var_2.vehicle_specific_onentervehicle = &ref_14209;
  thread ref_12BD6(var_2);
  level.ref_124B2[level.ref_124B2.size] = var_2;
  var_0 scripts\cp\cp_vehicles::delete_nav_obstacle();
  var_0 delete();
}

function ref_12BD6(var_0) {
  self notify("removeinvulnerable");
  self endon("removeinvulnerable");
  self endon("death");
  self.health = self.maxhealth;

  if(var_0 > 0) {
    scripts\engine\utility::ref_143B9(var_0, "landing_collision_damage");
  }

  self.invulnerable = undefined;
  self notify("removeinvulnerable");
}

function ref_14209(var_0, var_1, var_2, var_3) {
  var_0 notify("removeinvulnerable");
  var_0.health = var_0.maxhealth;
  var_0.invulnerable = undefined;
}

function ref_13E01(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3, "heli")) {
      if(!gcd(var_3)) {
        continue;
      }

      var_1 = var_3;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  return scripts\engine\utility::random(var_1);
}

function playvointernal(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.team = "allies";
  var_2.angles = (0, 0, 0);
  var_2 setModel("tag_origin");
  var_3 = plunder_overtime_music(var_2, var_0, var_1);

  if(!isDefined(var_3)) {
    return 0;
  }

  thread plunder_repositoryenableuserestrictions();
}

function plunder_overtime_music(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = 20000;
  var_4 = 5000;
  var_5 = 1500;
  var_6 = 1500;
  var_7 = (0, var_1, 0);

  if(!isDefined(var_2)) {
    var_5 += 1800;
  } else {
    var_5 = var_2.origin[2] + 1800;
    var_6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_5);
  }

  var_8 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0, var_7, var_3, var_2, var_5, var_4, var_6);
  var_9 = spawn("script_model", var_8["startPoint"]);
  var_9.angles = var_7;
  var_9.flightpath = var_8;
  var_9.speed = var_4;
  var_9.owner = self;
  var_9.team = self.team;
  var_9 setModel("veh8_mil_air_suniform25_west");
  return var_9;
}

function plunder_repositoryenableuserestrictions() {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_0 = self.flightpath["startPoint"];
  var_1 = self.flightpath["endPoint"];
  var_2 = self.flightpath["flyTime"];
  var_3 = var_0 + anglesToForward(self.angles) * 10000;
  var_4 = var_1 - anglesToForward(self.angles) * 10000;
  var_5 = length(var_3 - var_4);
  var_6 = 30;
  self moveTo(var_1, var_2);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var_1, var_2);
  var_7 = 3;
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(&wp_fireairburst, var_0, var_3, var_5, var_6, 4000, var_7, 1);
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(&wp_firesmoke, var_0, var_3, var_5, var_6, 4000, 3, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  self delete();
}

function wp_enterpayloadaudio() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
  self playsoundonmovingent("iw8_mp_white_phos_su25_flyby");
}

function wp_exitpayloadaudio(var_0, var_1) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0, "iw8_mp_white_phos_su25_exit");
}

function wp_fireairburst(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(level._effect["gas_inair_exp"], var_3, var_1);
  playsoundatpos(var_4, "iw8_mp_white_phos_midair_explo");
}

function wp_firesmoke(var_0, var_1, var_2, var_3) {
  wait var_2;
  level notify("gas_attack_deployed");
}