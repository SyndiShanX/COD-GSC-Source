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
  level.ref_1404b = 1;
}

function add_module_ai_spawn_func_to_module(var0, var1) {}

function adjustmatchtimerpausedstatefromscore(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "player_rooftop_spawn");
}

function adjustlootleadermarkcount(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "rooftop_raid_player_starts");
}

function adjusteventdistributionpadding(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "rooftop_raid_player_starts");
  setup_flags();
  level.sats_connected = 0;
  setDvar("scr_sat_debug", 1);
  ref_12e95();
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

function adjustmatchtimerpausedstatefromleadchange(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "player_rooftop_spawn");
}

function anchoredwidgetid(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  objective_state(level.rooftop1_sat.objective_id, "done");
  objective_state(level.rooftop2_sat.objective_id, "done");
  objective_state(level.rooftop3_sat.objective_id, "done");
  objective_position(var0.objectiveindex, scripts\engine\utility::getStruct("elevator_obj", "targetname").origin);
  level.rooftop1_sat.computer makeunusable();
  level.rooftop2_sat.computer makeunusable();
  level.rooftop3_sat.computer makeunusable();
  minigun_should_keep_firing();
  var1 = fixupsupersandtacticalsforgunfightmaps();
  flag_bot_attacker_limit_for_team(var1);
  var1 setModel("ee_door_wood_stained_int_01_keypad_unlocked");
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function anglesoffset(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  setomnvar("ui_signal_strength1", level.rooftop1_sat.ref_13393);
  setomnvar("ui_signal_strength2", level.rooftop2_sat.ref_13393);
  setomnvar("ui_signal_strength3", level.rooftop3_sat.ref_13393);
  var1 = (level.rooftop1_sat.ref_13393 + level.rooftop2_sat.ref_13393 + level.rooftop3_sat.ref_13393) / 3;
  var1 = int(max(1, var1));
  setomnvar("ui_signal_strength_total", var1);
  ref_12ea3();

  foreach(var3 in level.players) {
    var3 sethudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/ROOFTOP_TRANS_COMPLETE");
  }

  wait 5;

  foreach(var3 in level.players) {
    var3 clearhudtutorialmessage();
  }
}

function angle_molotov_mortar(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  level.teamnamelist = ["axis", "allies"];
  level.get_mortar_impact_pos = &ref_11d2d;
  level.sixthsenselastvotime = &sixthsense_shouldwarnaboutotherplayer;
  var1 = scripts\engine\utility::getStruct("rooftop_raid_player_heli", "targetname");
  level.player_lb = scripts\cp_mp\vehicles\little_bird::little_bird_create(var1);
  level.player_lb thread scripts\cp\cp_vehicles::waiting_for_disable();
  level.player_lb scripts\cp\utility::make_entity_sentient_cp("allies", 0);
  level.player_lb.maxhealth = 5000;
  level.player_lb.health = 5000;
  analytics_lui_mission_end_dlog(var0);
}

function analytics_lui_mission_end_dlog(var0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("cp_dwntwn_rooftop_script");
  level.ref_12d8b = 1;
  level.dogtag_revive = 0;
  setDvar("scr_sat_debug", 0);
  scripts\cp\cp_spawning_util::ref_13bbd(1);
  thread playtutsound();
  setup_flags();
  trigger_spawn_init();
  register_spawn_groups();
  thread ref_11d2f();
  level.rooftop1_sat = sat_setup(1);
  level.rooftop2_sat = sat_setup(2);
  level.rooftop3_sat = sat_setup(3);
  ref_12e95();
  thread wait_for_any_sat_death(level);
  level.sats_connected = 0;
  scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);

  foreach(var2 in level.players) {
    var2 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
  }

  level waittill("sats_connected");
  wait 1;
}

function sat_setup(var0) {
  var1 = getEnt("rooftop_" + var0 + "_satellite", "targetname");
  var1.ref_13393 = 1;
  var1.ref_13394 = 0;
  var1.computer = getEnt("rooftop_" + var0 + "_sat_com", "targetname");
  var1.computer setModel("military_hq_crate_01_proxy_cp_noantenna");
  var1.computer.ref_12a45 = scripts\engine\utility::getclosest(var1.computer.origin, getEntArray("reader", "targetname"));

  switch (var0) {
    case 1:
      var1.computer.ref_12a45.ref_1281e = "military_keycard_reader_green";
      init_freight_lift("green", var1.computer.ref_12a45);
      var1.computer.ref_12a45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "green_keycard_carry";
      break;
    case 2:
      var1.computer.ref_12a45.ref_1281e = "military_keycard_reader_red";
      init_freight_lift("red", var1.computer.ref_12a45);
      var1.computer.ref_12a45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "red_keycard_carry";
      break;
    case 3:
      var1.computer.ref_12a45.ref_1281e = "military_keycard_reader_blue";
      init_freight_lift("blue", var1.computer.ref_12a45);
      var1.computer.ref_12a45.onsoccerballreset.get_total_successful_vehicle_spawns_from_module = "blue_keycard_carry";
      break;
  }

  var1.radar = ref_12e8b("satellite_piece_" + var0, "military_deployable_satellite_radar_rig_skeleton");
  var1.radio = ref_12e8b("satellite_piece_" + var0, "military_deployable_satellite_radio_rig_skeleton");
  var1.buy_point_loop = ref_12e8b("satellite_piece_" + var0, "military_deployable_satellite_antenna_rig_skeleton");
  var1.buy_point_loop.get_total_successful_vehicle_spawns_from_module = "satellite_radar_carry";
  var1.radio.get_total_successful_vehicle_spawns_from_module = "satellite_controller_carry";
  var1.radar.get_total_successful_vehicle_spawns_from_module = "satellite_antenna_carry";
  var1.flagname = "r" + var0 + "_connected";
  var1.computer.flagname = var1.flagname;
  var1.power_switch = scripts\engine\utility::getStruct("rooftop" + var0 + "_power", "targetname");
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::initialize_alarm_box(var1.power_switch, 0);
  thread sat_damage_monitor(var1);
  sat_computer_init(var1, var0);
  thread ref_12e96(var1, var0);
  return var1;
}

function init_freight_lift(var0, var1) {
  var1.get_destinations_in_current_circle = var1.origin + (0, 0, 9.5) + anglestoleft(var1.angles) * 1.5;
  var1.get_destination_in_current_circle = var1.angles + (90, 0, 90);
  var1.onsoccerballreset = previous_bullet_weapon(var1);
  var2 = ref_12ff8(var1.onsoccerballreset);

  if(isDefined(var2)) {
    var1.onsoccerballreset.origin = var2.origin;
    var1.onsoccerballreset.angles = var2.angles;
    return;
  }
}

function update_computer_hint(var0, var1, var2) {
  var0 setHintString(var1);
  var0 sethinttag(var2);
}

function sat_wait_for_all_connected() {
  scripts\engine\utility::flag_wait_all("r1_connected", "r2_connected", "r3_connected");

  while(!istrue(level.rooftop1_sat.activated) || !istrue(level.rooftop2_sat.activated) || !istrue(level.rooftop3_sat.activated)) {
    wait 1;
  }

  level notify("sats_connected");
  wait 2;
}

function wait_for_any_sat_death(var0) {
  level endon("game_ended");
  level waittill("sat_death");
  logevent_servermatchstart(18);
  level thread[[level.endgame]]("ally", level.end_game_string_index["kia"]);
}

function sat_damage_monitor(var0) {
  get_sat_objective(self, var0);
  objective_state(self.objective_id, "current");
  objective_setprogress(self.objective_id, 0);
  objective_setshowprogress(self.objective_id, 1);
  var1 = scripts\engine\utility::getclosest(self.origin, level.rooftop_triggers);
  var1 scripts\engine\utility::trigger_on();
  scripts\engine\utility::flag_wait("transmission_started");
  thread bomb_plant_think();
}

function get_sat_objective(var0, var1) {
  var2 = scripts\cp\cp_objectives::requestworldid("vehicle_icon", 20);
  objective_setplayintro(var2, 1);
  objective_onentity(var2, var0);
  objective_setzoffset(var2, 75);
  var0.objective_id = var2;
  objective_icon(var2, self.script_noteworthy);
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

    if(!isDefined(self.ref_11e6e) || gettime() > self.ref_11e6e) {
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
      self.ref_11e6e = gettime() + randomintrange(30000, 45000);
    }

    level.cpoperationcratecapturecallback = 1;
    wait 1;
  }
}

function cprooftopcratecapturecallback() {
  var0 = self.objective_id;
  var1 = self.bombplantent.charge;
  level endon("game_ended");
  var1.leave_pool_behind_after_deactivation = 30;
  follow_players_when_close(var1, var0);
  thread focus_fire_icon_objective_id(var1);
  var2 = &"CP_STRIKE/DEFUSE";
  var1 setHintString(var2);
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(128);
  var1 sethintdisplayfov(65);
  var1 setuserange(64);
  var1 setusefov(65);
  var1 sethintonobstruction("show");
  var1 setuseholdduration("duration_medium");
  var1 makeusable();
  var1 endon("detonated");
  var1 endon("death");
  thread keypad_confirm_code_correct(var1);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/DEFUSE_BOMB", "allies", 5);
  var1 hudoutlineenable("outline_depth_red");

  for(;;) {
    var1 waittill("trigger", var3);
  }

  LOC_000000d4:
    var1 notify("defused");

  if(isDefined(self.bombplantent.planted)) {
    self.bombplantent.planted = undefined;
  }

  var1 hudoutlinedisable();
  var1 delete();
}

function keypad_confirm_code_correct(var0) {
  var0 endon("deeath");
  var0 endon("detonated");

  for(;;) {
    objective_setpulsate(self.objective_id, 1);
    wait 3;
    objective_setpulsate(self.objective_id, 0);
    wait 3;
  }
}

function follow_players_when_close(var0) {
  scripts\cp\cp_objectives::objective_set_play_intro(var0, 1);
  objective_setlabel(var0, &"CP_STRIKE/DEFUSE");
  objective_setshowprogress(var0, 1);
  objective_setprogress(var0, 1);
  objective_setownerteam(var0, "axis");
  objective_setpulsate(var0, 1);
}

function footprint_mask_clipheight() {
  objective_setpulsate(self.objective_id, 0);
  objective_setprogress(self.objective_id, 0);
  objective_setlabel(self.objective_id, "");
  objective_setownerteam(self.objective_id, "allies");
}

function focus_fire_icon_objective_id(var0) {
  self endon("death");
  self endon("defused");
  level endon("game_ended");
  var1 = self.leave_pool_behind_after_deactivation;
  var2 = var1;
  var3 = var1;

  if(soundexists("dx_mpa_wctl_bomb_enemyplanted")) {
    foreach(var5 in level.players) {
      var5 playlocalsound("dx_mpa_wctl_bomb_enemyplanted");
    }
  }

  wait 3;

  while(var3 > 0) {
    var3--;
    objective_setprogress(var0, var3 / var2);

    if(soundexists("breach_warning_beep_05")) {
      foreach(var5 in level.players) {
        var5 playlocalsound("breach_warning_beep_05");
      }
    }

    wait 1;
  }

  var9 = "frag";
  var10 = 0.1;
  var11 = magicgrenademanual(var9, self.origin + (0, 0, 6), (0, 0, 0), var10);
  var11.angles = self.angles;
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
  var0 = getEnt("ai_rooftop_trig", "targetname");
  thread ref_12b4b(var0, ["paratrooper_snipers", "ai_heli_reinforce", "ai_heli_reinforce_2", "ascender_rpg"]);
}

function wave_reinforce(var0, var1, var2, var3) {
  level endon("game_ended");

  if(!isDefined(var0.groupspawned)) {
    var0.groupspawned = 0;
  }

  if(!isDefined(var0.num_waves)) {
    var0.num_waves = 1;
  }

  if(var0.currentmodulekills >= var3 * var0.num_waves) {
    var0.num_waves++;
    return var2;
  }

  if(var0.activecount <= var0.min_size) {
    var0.groupspawned++;

    if(var0.groupspawned < 3) {
      return var1;
    } else {
      var0.groupspawned = 0;
      return 4;
    }
  }

  if(var0.activecount >= var0.max_size) {
    while(var0.activecount >= var0.min_size) {
      wait 0.25;
    }

    var0.num_waves++;
    return var2;
  }

  var0.groupspawned++;

  if(var0.groupspawned < 3) {
    return var1;
  }

  var0.groupspawned = 0;
  return 4;
}

function ref_11d2d(var0) {
  if(!isDefined(var0.targets)) {
    return undefined;
  }

  var1 = scripts\engine\utility::random(var0.targets);
  var2 = var1.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var3 = scripts\engine\trace::ray_trace(var2 + (0, 0, 500), var2);
  return var3["position"];
}

function ref_11d2f() {
  ref_11d2e("rooftop_1_mortar", 1);
  ref_11d2e("rooftop_2_mortar", 2);
  ref_11d2e("rooftop_3_mortar", 3);
  var0 = scripts\cp\cp_modular_spawning::run_spawn_module("mortar_ai_reinforce");
}

function ref_11d2e(var0, var1) {
  var2 = getEnt(var0, "targetname");
  var2 hidepart("j_mortar_shell", "misc_wm_mortar");
  thread mortar_think(var2);
}

function mortar_think(var0) {
  self.targets = undefined;

  for(;;) {
    var1 = get_players_on_rooftop(var0);

    if(var1.size) {
      self.targets = var1;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self);
      self.targets = undefined;
      wait randomintrange(15, 25);
      continue;
    }

    wait 1;
  }
}

function get_players_on_rooftop(var0) {
  var1 = getEnt("rooftop_" + var0 + "_trig", "targetname");
  var2 = [];

  foreach(var4 in level.players) {
    if(!var4 scripts\cp\utility::is_valid_player() || !var4 isonground() || var4 isonladder()) {
      continue;
    }

    if(var4 istouching(var1)) {
      var2 = var4;
    }
  }

  return var2;
}

function ref_12e95() {
  scripts\engine\utility::array_thread(getEntArray("usb_drive", "targetname"), &ref_12e94);
}

function ref_12e94() {
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
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var0.armorweapon)) {
      if(getdvarint("allow_card_swap") > 0) {
        ref_139c0(var0, self);
      } else {
        var0 scripts\cp\utility::setlowermessage("alreadyhave", &"CP_DWN_TWN_OBJECTIVES/ALREADY_HAVE_USB", 5);
        var0 playlocalsound("cp_pickup_deny");
        continue;
      }
    }

    var0 playlocalsound("cp_generic_placement");
    self.get_track_location_index = scripts\cp\utility::ref_13070(var0, self.get_total_successful_vehicle_spawns_from_module);
    var0.armorweapon = self;
    thread ref_12c37();
    self makeunusable();
    self hide();
    return;
  }
}

function ref_139c0(var0) {
  var1 = self.armorweapon;
  var2 = var1.get_track_location_index;

  if(isDefined(self)) {
    scripts\cp\utility::ref_12bc6(self, var2.slot);
  }

  var0 hide();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.get_track_location_index = undefined;
  var1 show();
  var1 scripts\engine\utility::delaythread(1, &ref_12e94);
}

function ref_12c37() {
  self endon("placed_card");
  var0 = self.armorweapon;
  var1 = var0.get_track_location_index;
  scripts\engine\utility::ref_143a5("death", "disconnect");

  if(isDefined(self)) {
    scripts\cp\utility::ref_12bc6(self, var1.slot);
  }

  var0 show();
  thread ref_12e94();
}

function ref_12c38(var0, var1, var2, var3) {
  self endon("placed_sat_piece");
  var4 = self.ref_12e91;
  var5 = var4.get_track_location_index;
  scripts\engine\utility::ref_143a5("death", "disconnect");

  if(isDefined(self)) {
    scripts\cp\utility::ref_12bc6(self, var5.slot);
  }

  thread ref_12e92(var0, var1, var2, var3);
  var4 show();
}

function trigger_spawn_init() {
  level.rooftop_triggers = [];
  var0 = scripts\engine\utility::getStructArray("rooftop_group1_trigger", "targetname");

  foreach(var2 in var0) {
    var3 = spawn("trigger_radius", var2.origin, 0, int(var2.radius), int(var2.height));
    var3.target = var2.target;
    var3.script_noteworthy = var2.script_noteworthy;

    if(var3.script_noteworthy == "icon_waypoint_dom_a") {
      var3.rooftopid = 1;
    } else if(var3.script_noteworthy == "icon_waypoint_dom_c") {
      var3.rooftopid = 2;
    } else {
      var3.rooftopid = 3;
    }

    var3.targetname = "rooftop_" + var3.rooftopid + "_trig";
    level.rooftop_triggers[level.rooftop_triggers.size] = var3;
    canplaygasmaskgesturebr("ascender", var3.origin);
    canplaygasmaskgesturebr("descender", var3.origin);
    var4 = scripts\engine\utility::getStructArray(var2.target, "targetname").size;
    scripts\cp\cp_modular_spawning::registerambientgroup(var3.target, var4, var4, var4, 0.5, undefined, var3.target);
    thread trigger_spawn();
    var3 scripts\engine\utility::trigger_off();
  }
}

function trigger_spawn() {
  self endon("stop_spawning");
  self endon("death");
  self waittill("trigger", var0);
  var1 = self.target;
  var2 = scripts\cp\cp_modular_spawning::run_spawn_module(var1);
  wait 60;
  ref_12b4b(["r" + self.rooftopid + "_ascender_reinforcements", "r" + self.rooftopid + "_ascender_reinforcements_2", "r" + self.rooftopid + "_paratrooper_reinforcements", "r" + self.rooftopid + "_paratrooper_reinforcements_2", "r" + self.rooftopid + "_paratrooper_reinforcements_3", "r" + self.rooftopid + "_heli_reinforce", "r" + self.rooftopid + "_heli_reinforce_2"], 1, 1);
}

function kill_rate_too_slow() {
  wait 2;
  self makeusable();
}

function ref_12e8c(var0) {
  var1 = int(100 - anglesdelta((0, var0.buy_point_loop.angles[1], 0), (0, var0.ref_13394, 0)));

  if(var1 > 100) {
    var1 = 100;
  }

  if(var1 < 1) {
    var1 = 1;
  }

  return var1;
}

function ref_12ea3() {
  level endon("game_ended");
  level.hack_duration = 120;
  thread ref_12e98();
  thread ref_12ea4();
  var0 = 0;

  while(var0 < level.hack_duration) {
    var1 = ref_12e8c(level.rooftop1_sat);
    var2 = ref_12e8c(level.rooftop2_sat);
    var3 = ref_12e8c(level.rooftop3_sat);
    var4 = (var1 + var2 + var3) / 3;
    var4 = int(max(1, var4));

    if(var4 < 80) {
      thread ref_12e97();
      level.hacking_paused = 1;
    } else {
      if(!scripts\engine\utility::flag("transmission_started")) {
        scripts\engine\utility::flag_set("transmission_started");
      }

      level notify("hacking_resumed");
      level.hacking_paused = 0;
    }

    setomnvar("ui_signal_strength_total", var4);
    wait 0.25;

    if(!level.hacking_paused) {
      var0 += 0.25;
    }
  }

  level notify("transfer_complete");
  scripts\engine\utility::flag_set("transmission_complete");
}

function ref_12ea4() {
  scripts\engine\utility::flag_wait("transmission_started");
  level scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  thread ref_12e8d();
  scripts\cp\utility::objective_update("rooftop_raid_activatesats_start");
}

function ref_12e97() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag("transmission_started")) {
    return;
  }

  if(istrue(level.ref_13392)) {
    return;
  }

  level.ref_13392 = 1;

  while(level.hacking_paused) {
    foreach(var1 in level.players) {
      var1 sethudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/TUTORIAL_REALIGN_SATELLITES");
    }

    wait 5;

    foreach(var1 in level.players) {
      var1 clearhudtutorialmessage();
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

function ref_12e87(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 forceusehinton(&"CP_DWN_TWN_OBJECTIVES/HINT_ADJUST_SAT");
  var0 playerlinkTo(self);
  var0 playerlinkedoffsetenable();

  while(!istrue(var0.ref_140ae)) {
    wait 0.05;
  }

  for(;;) {
    if(!istrue(var0.ref_140ae) || istrue(var0.inlaststand)) {
      var0 forceusehintoff();
      var0 unlink();
      var0 notify("stop_adjusting");
      thread kill_rate_too_slow();
      var1.ref_12746 = undefined;
      var1.buy_point_loop stoploopsound();
      var1 notify("stop_sounds");
      return;
    }

    if(var0 scripts\engine\utility::is_player_gamepad_enabled() && var0 fragButtonPressed() || !var0 scripts\engine\utility::is_player_gamepad_enabled() && var0 meleeButtonPressed()) {
      var1.buy_point_loop rotateYaw(-1.25, 0.05);

      if(!isDefined(var1.ref_12746)) {
        thread ref_12e99();
      }
    } else if(var0 secondaryoffhandbuttonPressed()) {
      var1.buy_point_loop rotateYaw(1.25, 0.05);

      if(!isDefined(var1.ref_12746)) {
        thread ref_12e99();
      }
    } else if(isDefined(var1.ref_12746)) {
      var1 notify("stop_sounds");
      var1.buy_point_loop stopsounds();
      waitframe();
      var1.buy_point_loop stoploopsound();
      var1.buy_point_loop playSound("scn_cp_satellite_in_use_stop");
      var1.ref_12746 = undefined;
    }

    wait 0.05;
    var1.ref_13393 = ref_12e8c(var1);
    setomnvar(var3, var1.ref_13393);
    LOC_00000174:
  }
}

function ref_12e99() {
  self endon("stop_sounds");
  self.ref_12746 = 1;
  self.buy_point_loop stopsounds();
  waitframe();
  self.buy_point_loop playSound("scn_cp_satellite_in_use_start");
  wait 0.5;
  self.buy_point_loop playLoopSound("scn_cp_satellite_in_use_lp");
}

function ref_12e8e(var0) {
  var0 endon("stop_adjusting");
  var0 waittill("disconnect");
  thread kill_rate_too_slow();
}

function ref_12e98() {
  level endon("game_ended");
  level endon("transfer_complete");

  if(level.hack_duration < 10) {
    return;
  }

  var0 = [level.rooftop1_sat, level.rooftop2_sat, level.rooftop3_sat];
  var1 = [125, 285, 75, 185, 300];
  var2 = 0;
  var3 = level.hack_duration;
  var4 = 0;
  var5 = randomintrange(int(level.hack_duration * 0.4), int(level.hack_duration * 0.7));

  for(;;) {
    while(istrue(level.hacking_paused)) {
      wait 0.05;
    }

    wait 1;
    var2 += 1;

    if(var2 == var5) {
      var6 = scripts\engine\utility::random(var0);
      var6.ref_13394 = scripts\engine\utility::random(var1);
      var6.ref_13393 = ref_12e8c(var6);
      setomnvar(var6.ref_13395, var6.ref_13393);
      var4++;

      if(var4 == 1) {
        return;
      }
    }
  }
}

function ref_12e8d() {
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

function path_data_ordered(var0) {
  level endon("game_ended");
  level endon("hacking_resumed");
  wait 60;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/MISSION_FAILED_TRANSMISSION", "allies", 5);
  wait 3;
  logevent_servermatchstart(17);
  level thread[[level.endgame]]("ally", level.end_game_string_index["kia"]);
}

function playtutsound() {
  for(var0 = 5; var0 > 0; var0--) {
    wait 1;
  }

  thread plundercountdownplayers();
  var1 = scripts\engine\utility::getStruct("rooftop_raid_player_heli", "targetname");
  var2 = var1.origin + (-2000, 0, 0);
  var3 = var1.angles[1];
  thread playvointernal(level, var2);
  wait randomintrange(3, 6);
  var2 = var1.origin + (2000, 0, 0);
  thread playvointernal(level, var2);
}

function plundercountdownplayers() {
  level waittill("gas_attack_deployed");
  wait 5;
  var0 = getEnt("gas_trigger", "targetname");
  thread plunder_value_picked_up(level, var0);
  var1 = scripts\engine\utility::getStructArray("wp_spots", "targetname");

  foreach(var3 in var1) {
    var3.plunder_playercanuserepository = spawnfx(level._effect["city_gas"], var3.origin);
    waitframe();
    triggerfx(var3.plunder_playercanuserepository);
    waitframe();
  }

  var5 = (15390, 18406, 1200);
  var6 = 3250;
  var7 = 5;
  var8 = [];
  var9 = var5 - (0, 0, 800);
  thread ref_13eb3(level, var9, var6, 800);
  var10 = 0;
  var11 = (var6, 0, 0);

  for(var12 = 0; var12 < var7 + 1; var12++) {
    var13 = var5 + rotatevector(var11, (0, var10, 0));
    var13 = getgroundposition(var13, 8, 12000, 12000);
    var14 = spawnfx(level._effect["city_gas"], var13);
    waitframe();
    triggerfx(var14);
    waitframe();
    var8 = var14;
    var10 += 360 / var7;
  }
}

function ref_13eb3(var0, var1, var2, var3) {
  var4 = var0 - (0, 0, 1000);
  var5 = spawn("trigger_radius", var4, 0, 7000, 1000);

  if(istrue(1)) {
    var5.is_cp_raid = 25;
    thread plunder_value_picked_up(level, var5);
  }

  var6 = 0.1;
  var7 = 5;
  var8 = var7;
  var9 = var2 / var3 / var6;
  var10 = spawnfx(level._effect["city_gas"], var0);
  waitframe();
  triggerfx(var10);
  waitframe();

  while(var3 > 0) {
    var5.origin += (0, 0, var9);
    var0 += (0, 0, var9);
    var3 -= var6;
    var8 -= var6;

    if(var8 <= 0) {
      var10 delete();
      waitframe();
      var10 = spawnfx(level._effect["city_gas"], var0);
      waitframe();
      triggerfx(var10);
      var8 = var7;
    }

    wait var6;
  }
}

function plunder_value_picked_up(var0, var1) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    if(isDefined(var2.plunder_seventyfivepercent_music)) {
      continue;
    }

    var2.plunder_seventyfivepercent_music = 1;

    if(!scripts\engine\utility::flag("transmission_complete")) {
      var2.shouldskiplaststand = 1;
    }

    thread plunder_value_dropped(var2, var0);
  }
}

function plunder_value_dropped(var0, var1) {
  self endon("disconnect");
  self endon("death");
  var2 = 0.2;
  var3 = 50;
  self visionsetnakedforplayer(var1, 3);

  if(!istrue(self.gasmaskequipped) && var1 != "") {
    self notify("toggle_gasmask");
    wait 0.6;
  }

  for(;;) {
    if(isDefined(var0.is_cp_raid)) {
      var3 = var0.is_cp_raid;
    }

    if(self istouching(var0)) {
      if(!istrue(self.gasmaskequipped)) {
        self dodamage(int(var2 * var3), self.origin, self, undefined, "MOD_TRIGGER_HURT");
        plundercountdownmessagedata();
        scripts\cp_mp\utility\shellshock_utility::_shellshock("gas_grenade_heavy_mp", "gas", 0.2, 0);
      }

      wait var2;
      continue;
    }

    break;
  }

  self.plunder_seventyfivepercent_music = undefined;
  wait 0.5;

  if(isDefined(self.plunder_seventyfivepercent_music)) {
    return;
  }

  if(istrue(self.gasmaskequipped) && var1 != "") {
    self notify("toggle_gasmask");
  }

  self visionsetnakedforplayer("", 1);

  if(!scripts\engine\utility::flag("transmission_complete")) {
    self.shouldskiplaststand = undefined;
    return;
  }
}

function plundercountdownmessagedata() {
  var0 = self;

  if(!isalive(var0)) {
    return;
  }

  if(isDefined(var0.did_ads_hint) && gettime() < var0.did_ads_hint) {
    return;
  }

  var0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var0)) {
    var0 playsoundtoplayer("gas_player_cough", var0, var0);
  }

  var1 = "allies_male_cough";
  var2 = var0.defaultoperatorteam;
  var3 = var0.operatorcustomization.gender;

  if(var2 == "axis") {
    if(isDefined(var3) && var3 == "female") {
      var1 = "axis_female_cough";
    } else {
      var1 = "axis_male_cough";
    }
  } else if(isDefined(var3) && var3 == "female") {
    var1 = "allies_female_cough";
  } else {
    var1 = "allies_male_cough";
  }

  var4 = randomint(game["dialogue"][var1].size);
  var5 = game["dialogue"][var1][var4];
  var0 playsoundonmovingent(var5);
}

function sat_computer_init(var0, var1) {
  var0.computer makeusable();
  var0.computer setCursorHint("HINT_BUTTON");
  var0.computer sethintdisplayrange(256);
  var0.computer sethintdisplayfov(90);
  var0.computer setuserange(72);
  var0.computer setusefov(90);
  var0.computer sethinttag("antenna_rot_base_joint");
  var0.computer sethintonobstruction("hide");
  var0.computer setuseholdduration("duration_short");
  var0.computer setusepriority(-10);
  var0.computer.has_antennae = 1;
  var0.computer.has_dongle = 0;

  if(getdvarint("scr_sat_debug") > 0) {
    var0.computer.has_dongle = 1;
  }

  var0.computer.ref_11e3b = 1;
  thread ref_12e89(var0.computer, var1);
}

function ref_12e89(var0, var1) {
  var1.ref_13395 = "ui_signal_strength" + var0;

  if(istrue(self.has_antennae)) {
    if(istrue(self.ref_11e3b)) {
      ref_12ea0(var1);
    } else {
      var1.computer.ref_12a45 setModel(var1.computer.ref_12a45.ref_1281e);
    }

    if(!istrue(self.has_dongle)) {
      ref_12e9a(var1, var0);
    } else {
      self setscriptablepartstate("main", "on_noidle");
      scripts\engine\utility::flag_set(self.flagname);
      level.sats_connected++;

      if(!istrue(var1.activated) && (!istrue(var1.radio.connected) || !istrue(var1.buy_point_loop.connected) || !istrue(var1.radar.connected))) {
        thread ref_12e9b();
      } else {
        var1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
      }

      while(!istrue(var1.activated)) {
        wait 1;
      }

      scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);
      objective_setownerteam(var1.objective_id, "allies");
    }
  }

  var1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
  wait 6;
  self makeusable();
  var1.ref_13393 = ref_12e8c(var1);
  setomnvar("ui_signal_strength" + var0, var1.ref_13393);
  var1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
  thread ref_12e9d();
  sat_wait_for_all_connected();
  var1.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/ADJUST_DISH");

  for(;;) {
    self waittill("trigger", var2);
    self makeunusable();
    thread ref_12e87(var2, var1, undefined, "ui_signal_strength" + var0);
    thread ref_12e8e(var2);
    scripts\cp\cp_computerscreen::hit_by_emp_monitor(var2);
    LOC_000001cd:
  }
}

function ref_12e8b(var0, var1) {
  var2 = getEntArray(var0, "targetname");

  foreach(var4 in var2) {
    if(var4.model == var1) {
      return var4;
    }
  }
}

function ref_12ea0(var0) {
  update_computer_hint(self, &"CP_DWN_TWN_OBJECTIVES/REQUIRES_POWER", "screen_joint");
  thread ref_12ea1(var0.power_switch.alarm_box);
  var0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("switch_on");
  var0.power_switch.alarm_box makeunusable();
  var0.powered_on = 1;
  var0.computer.ref_12a45 setModel(var0.computer.ref_12a45.ref_1281e);
}

function ref_12ea1(var0) {
  self endon("switch_on");

  for(;;) {
    var0 waittill("trigger", var1);
    var0 makeunusable();
    thread kill_rate_too_slow();
    var1 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/REQUIRES_POWER", 5);
    var1 playlocalsound("cp_pickup_deny");
  }
}

function ref_12e9b() {
  self endon("sat_activated");
  update_computer_hint(self, &"CP_DWN_TWN_OBJECTIVES/SAT_LINK_FAILED", "screen_joint");

  for(;;) {
    self waittill("trigger", var0);
    self makeunusable();
    thread kill_rate_too_slow();
    var0 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/SAT_LINK_FAILED", 5);
    var0 playlocalsound("cp_pickup_deny");
  }
}

function ref_12e9d() {
  level endon("sats_connected");

  for(;;) {
    self waittill("trigger", var0);
    self makeunusable();
    thread kill_rate_too_slow();
    var0 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/SAT_WAITING", 5);
    var0 playlocalsound("cp_pickup_deny");
  }
}

function ref_12e9a(var0, var1) {
  self makeunusable();
  var0.computer.ref_12a45 setHintString(&"CP_DWN_TWN_OBJECTIVES/MISSING_DONGLE");
  var0.computer.ref_12a45 setCursorHint("HINT_BUTTON");
  var0.computer.ref_12a45 sethintdisplayrange(96);
  var0.computer.ref_12a45 sethintdisplayfov(65);
  var0.computer.ref_12a45 setuserange(96);
  var0.computer.ref_12a45 setusefov(65);
  var0.computer.ref_12a45 sethintonobstruction("show");
  var0.computer.ref_12a45 setuseholdduration("duration_short");
  var0.computer.ref_12a45 makeusable();
  var0.computer.ref_12a45 setusepriority(-10);

  for(;;) {
    var0.computer.ref_12a45 waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var0.computer.ref_12a45 makeunusable();

    if(!isDefined(var2.armorweapon) && !istrue(getdvarint("scr_sat_haveall") > 0)) {
      var2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/NO_ITEM", 5);
      var2 playlocalsound("cp_pickup_deny");
      wait 1;
      var0.computer.ref_12a45 makeusable();
      continue;
    }

    if(!istrue(getdvarint("scr_sat_haveall") > 0) && var2.armorweapon != var0.computer.ref_12a45.onsoccerballreset) {
      var2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/WRONG_DONGLE", 5);
      var2 playlocalsound("cp_pickup_deny");
      wait 1;
      var0.computer.ref_12a45 makeusable();
      continue;
    }

    if(istrue(getdvarint("scr_sat_haveall") > 0)) {
      var2.armorweapon = var0.computer.ref_12a45.onsoccerballreset;
    }

    var2 scripts\cp\utility::setlowermessage("missing", &"CP_DWN_TWN_OBJECTIVES/CORRECT_DONGLE", 5);
    var2 notify("placed_card");
    var2 playlocalsound("cp_computer_success");
    scripts\engine\utility::flag_set(self.flagname);
    level.sats_connected++;
    var2.armorweapon.origin = var0.computer.ref_12a45.get_destinations_in_current_circle;
    var2.armorweapon.angles = var0.computer.ref_12a45.get_destination_in_current_circle;
    var2.armorweapon show();
    var2.armorweapon makeunusable();
    var3 = var2.armorweapon.get_track_location_index;
    var2.armorweapon = undefined;
    wait 1;
    self setscriptablepartstate("main", "on_noidle");
    self makeusable();
    var0.setupzombiepowers = 1;

    if(!istrue(getdvarint("scr_sat_haveall") > 0)) {
      scripts\cp\utility::ref_12bc6(var2, var3.slot);
    }

    if(!istrue(var0.activated) && (!istrue(var0.radio.connected) || !istrue(var0.buy_point_loop.connected) || !istrue(var0.radar.connected))) {
      thread ref_12e9b();
    } else {
      var0.computer setHintString(&"CP_DWN_TWN_OBJECTIVES/SAT_WAITING");
    }

    while(!istrue(var0.activated)) {
      wait 1;
    }

    var0.computer notify("sat_activated");
    scripts\cp\utility::objective_update("rooftop_raid_heli", undefined, undefined, undefined, undefined, level.sats_connected);
    objective_setownerteam(var0.objective_id, "allies");
    return;
  }
}

function ref_12e96(var0, var1) {
  var2 = ref_12e88();

  switch (var2) {
    case "controller":
      var0.ref_11e3a = 1;
      var0.ref_11e39 = 0;
      var0.ref_11e3c = 0;
      break;
    case "radar":
      var0.ref_11e3a = 0;
      var0.ref_11e39 = 0;
      var0.ref_11e3c = 1;
      break;
    case "antenna":
      var0.ref_11e3a = 0;
      var0.ref_11e39 = 1;
      var0.ref_11e3c = 0;
      break;
    case "debug":
      var0.ref_11e3a = 0;
      var0.ref_11e39 = 0;
      var0.ref_11e3c = 0;
      break;
  }

  if(istrue(var0.ref_11e39)) {
    thread ref_12e9c(var0);
  } else if(!istrue(var0.ref_11e39)) {
    var0.buy_point_loop linkTo(var0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
    var0.buy_point_loop show();
    var0.buy_point_loop.connected = 1;
  }

  if(istrue(var0.ref_11e3a)) {
    thread ref_12e9e(var0);
  } else {
    var0.radio.origin = var0 gettagorigin("j_frame_pivot");
    var0.radio.angles = var0 gettagangles("j_frame_pivot");
    var0.radio linkTo(var0);
    var0.radio scriptmodelplayanim("cp_satellite_apparatus_folded");
    var0.radio show();
    var0.radio.connected = 1;
  }

  if(istrue(var0.ref_11e3c)) {
    thread ref_12ea2(var0);
  } else if(!istrue(var0.ref_11e39)) {
    var0.radar linkTo(var0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
    var0.radar show();
    var0.radar.connected = 1;
  }

  while(!istrue(var0.radio.connected) || !istrue(var0.buy_point_loop.connected) || !istrue(var0.radar.connected) || !istrue(var0.powered_on) || !istrue(var0.setupzombiepowers)) {
    wait 1;
  }

  wait 1;
  var0.activated = 1;
  ref_12e86(var0);
  ref_12e8f(var0);
}

function ref_12e92(var0, var1, var2, var3) {
  self setHintString(var0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(96);
  self sethintdisplayfov(65);
  self setuserange(96);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  self makeusable();
  self setusepriority(-10);
  jumpiffalse(isDefined(var3)) LOC_0000005d;
  self sethinttag(var3);

  for(;;) {
    self waittill("trigger", var4);

    if(!var4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var4.ref_12e91)) {
      var4 scripts\cp\utility::setlowermessage("haveant", &"CP_DWN_TWN_OBJECTIVES/HAVE_SAT_PIECE", 5);
      var4 playlocalsound("cp_pickup_deny");
      continue;
    }

    var4 playlocalsound("cp_generic_placement");
    var4.ref_12e91 = self;
    thread ref_12c38(var4, var0, var1, var2);
    self.get_track_location_index = scripts\cp\utility::ref_13070(var4, self.get_total_successful_vehicle_spawns_from_module);
    break;
  }

  self makeunusable();
  self hide();

  if(isDefined(var2)) {
    foreach(var6 in var2) {
      var6 hide();
    }

    return;
  }
}

function ref_12e9c(var0, var1) {
  var0.radar linkTo(var0.buy_point_loop, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var0.radar.connected = 1;
  thread ref_12e92(var0.buy_point_loop, &"CP_DWN_TWN_OBJECTIVES/PICKUP_RADAR", var0);
  var2 = anglestoleft(var0.angles);
  var2 = var0.origin + var2 * 35 + (0, 0, 25);
  var3 = ref_12e8a(var2);
  var3 setHintString(&"CP_DWN_TWN_OBJECTIVES/PLACE_RADAR");
  ref_12e9f(var3, var0.buy_point_loop);
  var3 delete();
  var0.buy_point_loop linkTo(var0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
  var0.buy_point_loop show();
  var0.buy_point_loop.connected = 1;
  var0.radar linkTo(var0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var0.radar show();
}

function ref_12e9e(var0) {
  thread ref_12e92(var0.radio, &"CP_DWN_TWN_OBJECTIVES/PICKUP_CONTROLLER", var0, undefined);
  var1 = anglestoleft(var0.angles);
  var1 = var0.origin + var1 * 14 + (0, 0, 25);
  var2 = ref_12e8a(var1);
  var2 setHintString(&"CP_DWN_TWN_OBJECTIVES/PLACE_CONTROLLER");
  ref_12e9f(var2, var0.radio);
  var0.radio.origin = var0 gettagorigin("j_frame_pivot");
  var0.radio.angles = var0 gettagangles("j_frame_pivot");
  var0.radio linkTo(var0);
  var0.radio scriptmodelplayanim("cp_satellite_apparatus_folded");
  var0.radio show();
  var0.radio.connected = 1;
  var2 delete();
}

function ref_12ea2(var0) {
  var0.buy_point_loop linkTo(var0, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
  var0.buy_point_loop.connected = 1;
  thread ref_12e92(var0.radar, &"CP_DWN_TWN_OBJECTIVES/PICKUP_ANT");
  var1 = anglestoleft(var0.angles);
  var1 = var0.origin + var1 * 45 + (0, 0, 15);
  var2 = ref_12e8a(var1);
  var2 setHintString(&"CP_DWN_TWN_OBJECTIVES/MISSING_ANT");
  ref_12e9f(var2, var0.radar);
  var2 delete();
  var0.radar linkTo(var0, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
  var0.radar show();
  var0.radar.connected = 1;
}

function ref_12e9f(var0, var1) {
  for(;;) {
    var0 waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var2.ref_12e91) && var2.ref_12e91 == var1 || istrue(getdvarint("scr_sat_haveall") > 0)) {
      var2 playlocalsound("cp_generic_placement");
      var2 notify("placed_sat_piece");

      if(!istrue(getdvarint("scr_sat_haveall") > 0)) {
        scripts\cp\utility::ref_12bc6(var2, var2.ref_12e91.get_track_location_index.slot);
      } else {
        var1 makeunusable();
      }

      var2.ref_12e91 = undefined;
      break;
    }

    var2 scripts\cp\utility::setlowermessage("haveant", &"CP_DWN_TWN_OBJECTIVES/NO_ITEM", 5);
    var2 playlocalsound("cp_pickup_deny");
  }
}

function ref_12e8a(var0) {
  var1 = spawn("script_model", var0);
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(256);
  var1 sethintdisplayfov(180);
  var1 setuserange(96);
  var1 setusefov(180);
  var1 sethintonobstruction("show");
  var1 setuseholdduration("duration_short");
  var1 makeusable();
  var1 setusepriority(-10);
  return var1;
}

function ref_12e86(var0) {
  var0.power_switch.alarm_box scripts\engine\utility::ent_flag_wait("switch_on");
  thread ref_12e93(var0);
  var0.radio scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var0.buy_point_loop scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var0.radar scriptmodelplayanim("cp_satellite_apparatus_unfold");
  var0 setscriptablepartstate("base", "unfold");
  wait 6.65;
}

function ref_12e93(var0) {
  var0 playSound("scn_cp_satellite_unfold_start");
  wait 0.25;
  var0 playLoopSound("scn_cp_satellite_unfold_lp");
  wait 4;
  var0 stoploopsound();
  var0 playSound("scn_cp_satellite_unfold_stop");
  wait 0.5;
  var0.radar playLoopSound("scn_cp_satellite_idle");
}

function ref_12e8f(var0) {
  var0.buy_point_loop scriptmodelplayanim("cp_satellite_apparatus_loop");
  var0.radar linkTo(var0.buy_point_loop, "j_radar_rot_01");
  var0.buy_point_loop.angles = var0.angles + (0, 45, -15);
  var0.buy_point_loop unlink();
}

function ref_12e88() {
  if(getdvarint("scr_sat_debug") > 0) {
    return "debug";
  }

  if(!isDefined(level.ref_12e90)) {
    level.ref_12e90 = ["controller", "radar", "antenna"];
  }

  var0 = scripts\engine\utility::random(level.ref_12e90);
  level.ref_12e90 = scripts\engine\utility::array_remove(level.ref_12e90, var0);
  return var0;
}

function previous_bullet_weapon(var0) {
  var1 = getEntArray("usb_drive", "targetname");

  foreach(var3 in var1) {
    switch (var0.ref_1281e) {
      case "military_keycard_reader_green":
        if(var3.model == "electronics_keycard_office_01_green") {
          return var3;
        }

        break;
      case "military_keycard_reader_red":
        if(var3.model == "electronics_keycard_office_01_red") {
          return var3;
        }

        break;
      case "military_keycard_reader_blue":
        if(var3.model == "electronics_keycard_office_01") {
          return var3;
        }

        break;
    }
  }
}

function ref_12ff8() {
  var0 = undefined;

  switch (self.model) {
    case "electronics_keycard_office_01_green":
      var0 = "green";
      break;
    case "electronics_keycard_office_01_red":
      var0 = "red";
      break;
    case "electronics_keycard_office_01":
      var0 = "blue";
      break;
  }

  var1 = scripts\engine\utility::getStructArray("keycard_loc_" + var0, "targetname");

  if(var1.size > 0) {
    return scripts\engine\utility::random(var1);
  }

  return undefined;
}

function canplaykillstreakdialog(var0, var1) {
  self.fnmeleecharge_init = &bisthread;
  var2 = undefined;

  switch (var0.group_name) {
    case "r1_ascender_reinforcements_2":
    case "r1_ascender_reinforcements":
      var2 = "r1_reinforce_positions";
      break;
    case "r2_ascender_reinforcements_2":
    case "r2_ascender_reinforcements":
      var2 = "r2_reinforce_positions";
      break;
    case "r3_ascender_reinforcements_2":
    case "r3_ascender_reinforcements":
      var2 = "r3_reinforce_positions";
      break;
  }

  thread lootcontentsadjustkillchain(var2);
}

function canprogressingunrank(var0) {
  self.fnmeleecharge_init = &bisthread;
  var1 = scripts\engine\utility::random(["mortar_positions_2", "mortar_positions_1"]);
  thread lootcontentsadjustkillchain(var1);
}

function lootcontentsadjustkillchain(var0) {
  self endon("death");
  var1 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(self.origin);
  scripts\mp\vehicles\little_bird_mg_mp::blockade_gate_explode_sequence("up", var1);

  if(isDefined(var0)) {
    var2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(var0, "script_noteworthy"));
    self setgoalpos(var2.origin);
    return;
  }
}

function bisthread(var0) {
  self.meleechargedistvsplayer = 2000;
  self.melee.bignoretimeout = 1;
  self.melee.bignoretargetflee = 1;
}

function logevent_servermatchstart(var0) {
  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_cp_mission_fail_index", var0);
  }
}

function canplaygasmaskgesturebr(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 256;
  }

  if(var0 == "ascender") {
    var3 = scripts\mp\vehicles\little_bird_mg_mp::bloadinghvt(var1);
  } else {
    var3 = scripts\mp\vehicles\little_bird_mg_mp::blockachievementstimestamp(var2);
  }

  var4 = getentitylessscriptablearrayinradius("scriptable_scriptable_auto_" + var1, "classname", var3.origin, var3);
  var5 = var4[0];
  var5 setscriptablepartstate("ascender", "noprompt");
}

function minigun_should_keep_firing() {
  level.ref_12d8c = &init_ai_spawns;
  var0 = scripts\engine\utility::getStructArray("crate_drop", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\cp\crate_drops\cp_crate_drops::dropcarepackage(var2, undefined, "cp_rooftop_crate");
  }
}

function init_ai_spawns(var0) {
  ref_1234d(var0);
}

function ref_1234d() {
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
  var0 = getEnt("elevator_interact", "targetname");
  var0 setHintString(&"CP_DWN_TWN_OBJECTIVES/ELEVATOR_BASEMENT");
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(128);
  var0 sethintdisplayfov(65);
  var0 setuserange(96);
  var0 setusefov(65);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_short");
  var0 makeusable();
  return var0;
}

function flag_bot_attacker_limit_for_team() {
  self waittill("trigger", var0);
  self makeunusable();
}

function ref_12b4b(var0, var1, var2) {
  level endon("transfer_complete");

  foreach(var4 in var0) {
    if(isDefined(level.ambientgroups[var4])) {
      continue;
    }

    var0 = scripts\engine\utility::array_remove(var0, var4);
  }

  var6 = 30;
  var7 = 40;
  var8 = 10;
  var9 = 15;

  for(;;) {
    var4 = ref_135be(var0);
    var10 = [];

    if(issubstr(var4, "heli")) {
      var10 = scripts\engine\utility::array_remove(var0, var4);

      foreach(var12 in var0) {
        if(issubstr(var12, "heli")) {
          var10 = scripts\engine\utility::array_remove(var10, var12);
        }
      }
    } else {
      var10 = scripts\engine\utility::array_remove(var0, var4);
    }

    wait randomintrange(var8, var9);
    var4 = ref_135be(var10);
    ref_14328();
    ref_14327(var1);
    wait randomintrange(var6, var7);
  }
}

function ref_135be(var0) {
  var1 = ref_13e01(var0);

  if(!isDefined(var1)) {
    foreach(var1 in var0) {
      if(issubstr(var1, "heli")) {
        var0 = scripts\engine\utility::array_remove(var0, var1);
      }
    }

    var1 = scripts\engine\utility::random(var0);
  }

  if(issubstr(var1, "para")) {
    scripts\cp\cp_aiparachute::request_paratroopers(var1, undefined, (-13512, 66432, 5904));
  } else {
    if(issubstr(var1, "ai_heli")) {
      level.skipburndown[var1] = gettime() + 180000;
    } else if(issubstr(var1, "heli")) {
      level.skipburndown[var1] = gettime() + 30000;
    }

    scripts\cp\cp_modular_spawning::run_spawn_module(var1);
  }

  return var1;
}

function gcd(var0) {
  if(!isDefined(level.skipequippedstreakcheck)) {
    level.skipequippedstreakcheck = getEntArray("heli_landing_volumes", "targetname");
  }

  if(!isDefined(level.ref_124b2)) {
    level.ref_124b2 = [];
  }

  if(!isDefined(level.skipburndown)) {
    level.skipburndown = [];
  }

  if(!isDefined(level.skipburndown[var0])) {
    level.skipburndown[var0] = 0;
  }

  if(gettime() < level.skipburndown[var0]) {
    return 0;
  }

  var1 = 1;
  var2 = getEnt(var0, "script_noteworthy");

  foreach(var4 in level.ref_124b2) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var4 istouching(var2)) {
      var1 = 0;
    }
  }

  return var1;
}

function ref_14327(var0) {
  jumpiftrue(isDefined(var0)) LOC_0000000a;
  var0 = 0;

  for(;;) {
    var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var2 = 0;

    foreach(var4 in var1) {
      if(var4 istouching(self)) {
        var2++;
      }
    }

    if(var2 > var0) {
      wait 1;
      continue;
    }

    return;
  }
}

function ref_14328() {
  for(;;) {
    var0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var1 = 0;

    foreach(var3 in var0) {
      if(var3 istouching(self)) {
        var1++;
      }
    }

    if(var1 < 1) {
      wait 1;
      continue;
    }

    wait 10;
    return;
  }
}

function sixthsense_shouldwarnaboutotherplayer(var0) {
  var1 = spawnStruct();
  var1.angles = var0.angles;
  var1.origin = var0.origin;
  var2 = scripts\cp_mp\vehicles\little_bird::little_bird_create(var1);
  var2 thread scripts\cp\cp_vehicles::waiting_for_disable();
  var2.invulnerable = 1;
  var2.maxhealth = 5000;
  var2.health = 5000;
  var2.vehicle_specific_onentervehicle = &ref_14209;
  thread ref_12bd6(var2);
  level.ref_124b2[level.ref_124b2.size] = var2;
  var0 scripts\cp\cp_vehicles::delete_nav_obstacle();
  var0 delete();
}

function ref_12bd6(var0) {
  self notify("removeinvulnerable");
  self endon("removeinvulnerable");
  self endon("death");
  self.health = self.maxhealth;

  if(var0 > 0) {
    scripts\engine\utility::ref_143b9(var0, "landing_collision_damage");
  }

  self.invulnerable = undefined;
  self notify("removeinvulnerable");
}

function ref_14209(var0, var1, var2, var3) {
  var0 notify("removeinvulnerable");
  var0.health = var0.maxhealth;
  var0.invulnerable = undefined;
}

function ref_13e01(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(issubstr(var3, "heli")) {
      if(!gcd(var3)) {
        continue;
      }

      var1 = var3;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  return scripts\engine\utility::random(var1);
}

function playvointernal(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.team = "allies";
  var2.angles = (0, 0, 0);
  var2 setModel("tag_origin");
  var3 = plunder_overtime_music(var2, var0, var1);

  if(!isDefined(var3)) {
    return 0;
  }

  thread plunder_repositoryenableuserestrictions();
}

function plunder_overtime_music(var0, var1) {
  var2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var3 = 20000;
  var4 = 5000;
  var5 = 1500;
  var6 = 1500;
  var7 = (0, var1, 0);

  if(!isDefined(var2)) {
    var5 += 1800;
  } else {
    var5 = var2.origin[2] + 1800;
    var6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var5);
  }

  var8 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var0, var7, var3, var2, var5, var4, var6);
  var9 = spawn("script_model", var8["startPoint"]);
  var9.angles = var7;
  var9.flightpath = var8;
  var9.speed = var4;
  var9.owner = self;
  var9.team = self.team;
  var9 setModel("veh8_mil_air_suniform25_west");
  return var9;
}

function plunder_repositoryenableuserestrictions() {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var0 = self.flightpath["startPoint"];
  var1 = self.flightpath["endPoint"];
  var2 = self.flightpath["flyTime"];
  var3 = var0 + anglesToForward(self.angles) * 10000;
  var4 = var1 - anglesToForward(self.angles) * 10000;
  var5 = length(var3 - var4);
  var6 = 30;
  self moveTo(var1, var2);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var1, var2);
  var7 = 3;
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(&wp_fireairburst, var0, var3, var5, var6, 4000, var7, 1);
  scripts\cp_mp\killstreaks\white_phosphorus::wp_handlepayloadtyperelease(&wp_firesmoke, var0, var3, var5, var6, 4000, 3, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
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

function wp_exitpayloadaudio(var0, var1) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  playsoundatpos(var0, "iw8_mp_white_phos_su25_exit");
}

function wp_fireairburst(var0, var1, var2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var3 = var0 - var1 * 3000;
  var4 = var0 - var1 * 2000;
  var5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  playFX(level._effect["gas_inair_exp"], var3, var1);
  playsoundatpos(var4, "iw8_mp_white_phos_midair_explo");
}

function wp_firesmoke(var0, var1, var2, var3) {
  wait var2;
  level notify("gas_attack_deployed");
}