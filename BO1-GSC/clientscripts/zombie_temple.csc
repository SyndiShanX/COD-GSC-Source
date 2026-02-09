/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_temple\.csc
*******************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

main() {
  level thread clientscripts\zombie_temple_ffotd::main_start();
  level._uses_crossbow = true;
  level._temple_vision_set = "zombie_temple";
  level._temple_vision_set_priority = 1;
  level._temple_caves_vision_set = "zombie_temple_caves";
  level._temple_caves_vision_set_priority = 2;
  level._temple_water_vision_set = "zombie_temple";
  level._temple_eclipse_vision_set = "zombie_temple_eclipse";
  level._temple_eclipse_vision_set_priority = 3;
  level._temple_caves_eclipse_vision_set = "zombie_temple_eclipseCave";
  level._temple_caves_eclipse_vision_set_priority = 3;
  init_client_flags();
  level.riser_fx_on_client = 1;
  level.use_new_riser_water = 1;
  level.use_clientside_rock_tearin_fx = 1;
  level.use_clientside_board_fx = 1;
  include_weapons();
  clientscripts\_zombiemode::main();
  clientscripts\_zombiemode_spikemore::init();
  thread clientscripts\zombie_temple_fx::main();
  thread clientscripts\zombie_temple_amb::main();
  clientscripts\_zombiemode_ai_napalm::init_napalm_zombie();
  clientscripts\_zombiemode_ai_sonic::init_sonic_zombie();
  clientscripts\zombie_temple_geyser::main();
  clientscripts\_sticky_grenade::main();
  level thread power_watch();
  level thread waterfall_triggers_init();
  watch_power_water();
  register_zombie_types();
  OnPlayerConnect_Callback(::temple_player_connect);
  OnPlayerSpawned_Callback(::temple_player_spawned);
  _init_pap_indicators();
  register_flag_handlers();
  registerSystem("pap_indicator_spinners", ::temple_pap_monitor_spinners);
  level thread cave_vision_trigger_init();
  level thread temple_light_model_swap_init();
  level thread clientscripts\zombie_temple_ffotd::main_end();
  level thread sq_std_watcher();
  level thread waterfall_watcher();
  level thread timetravel_watcher();
  level thread crystal_sauce_monitor();
  level thread time_travel_vision();
  thread waitforclient(0);
  println("*** Client : zombie_temple running...");
}
init_client_flags() {
  level._CF_ACTOR_IS_NAPALM_ZOMBIE = 0;
  level._CF_ACTOR_DO_NOT_USE = 1;
  level._CF_ACTOR_NAPALM_ZOMBIE_EXPLODE = 2;
  level._CF_ACTOR_IS_SONIC_ZOMBIE = 3;
  level._CF_ACTOR_NAPALM_ZOMBIE_WET = 4;
  level._CF_ACTOR_CLIENT_FLAG_SPIKEMORE = 5;
  level._CF_ACTOR_RAGDOLL_IMPACT_GIB = 6;
  level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_PRONE = 0;
  level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_STAND = 1;
  level._CF_PLAYER_MAZE_FLOOR_RUMBLE = 3;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKES = 3;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_MAZE_WALL = 4;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKEMORE = 5;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_WEAKSAUCE_START = 6;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_HOTSAUCE_START = 7;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_SAUCE_END = 8;
  level._CF_SCRIPTMOVER_CLIENT_FLAG_WATER_TRAIL = 9;
}
register_flag_handlers() {
  register_clientflag_callback("actor", level._CF_ACTOR_RAGDOLL_IMPACT_GIB, ::ragdoll_impact_watch_start);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_SPIKES, ::spike_trap_move);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_MAZE_WALL, ::maze_wall_move);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_WEAKSAUCE_START, ::crystal_weaksauce_start);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_HOTSAUCE_START, ::crystal_hotsauce_start);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_SAUCE_END, ::crystal_sauce_end);
  register_clientflag_callback("scriptmover", level._CF_SCRIPTMOVER_CLIENT_FLAG_WATER_TRAIL, ::water_trail_monitor);
  register_clientflag_callback("player", level._CF_PLAYER_MAZE_FLOOR_RUMBLE, ::maze_floor_controller_rumble);
}
spike_trap_move(localClientNum, set, newEnt) {
  spike_trap_move_spikes(localClientNum, set);
}
maze_wall_move(localClientNum, set, newEnt) {
  clientscripts\zombie_temple_maze::maze_trap_move_wall(localClientNum, set);
}
delete_water_trail() {
  realWait(1.2);
  for(i = 0; i < self.fx_ents.size; i++) {
    self.fx_ents[i] Delete();
  }
  self.fx_ents = undefined;
}
water_trail_monitor(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(set) {
    players = getlocalplayers();
    self.fx_ents = [];
    for(i = 0; i < players.size; i++) {
      self.fx_ents[i] = spawn(i, (0, 0, 0), "script_model");
      self.fx_ents[i] setModel("tag_origin");
      self.fx_ents[i] LinkTo(self, "tag_origin");
      playFXOnTag(i, level._effect["fx_crystal_water_trail"], self.fx_ents[i], "tag_origin");
    }
  } else {
    if(isDefined(self.fx_ents)) {
      self thread delete_water_trail();
    }
  }
}
crystal_weaksauce_start(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  s = spawnStruct();
  s.fx = "fx_weak_sauce_trail";
  s.origin = self.origin + (0, 0, 134);
  level._crystal_sauce_start = s;
}
crystal_hotsauce_start(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  s = spawnStruct();
  s.fx = "fx_hot_sauce_trail";
  s.origin = self.origin + (0, 0, 134);
  level._crystal_sauce_start = s;
}
crystal_sauce_end(localClientNum, set, newEnt) {
  if(localClientNum != 0) {
    return;
  }
  if(!set) {
    return;
  }
  level._crystal_sauce_end = self.origin;
  if(self.model == "p_ztem_crystal_and_holder") {
    level._crystal_sauce_end += (0, 0, 134);
  }
}
crystal_trail_runner(localClientNum, fx_name, dest) {
  PrintLn("Running " + fx_name + " from " + self.origin + " to " + dest);
  playFXOnTag(localClientNum, level._effect[fx_name], self, "tag_origin");
  self playLoopSound("evt_sq_bag_crystal_bounce_loop", .05);
  self MoveTo(dest, 0.5);
  self waittill("movedone");
  self Delete();
}
crystal_sauce_monitor() {
  waitforallclients();
  num_players = getlocalplayers().size;
  while(1) {
    realWait(0.016);
    if(!isDefined(level._crystal_sauce_start) || !isDefined(level._crystal_sauce_end)) {
      continue;
    }
    for(i = 0; i < num_players; i++) {
      e = spawn(i, level._crystal_sauce_start.origin, "script_model");
      e setModel("tag_origin");
      e thread crystal_trail_runner(i, level._crystal_sauce_start.fx, level._crystal_sauce_end);
    }
    level._crystal_sauce_start = undefined;
    level._crystal_sauce_end = undefined;
  }
}
power_watch() {
  level.power = false;
  level waittill("ZPO");
  level.power = true;
  level thread start_generator_movement();
}
timetravel_watcher() {
  level._in_eclipse = false;
  level thread eclipse_watcher();
  level thread daybreak_watcher();
}
time_travel_vision() {
  level waittill("time_travel");
  while(1) {
    level waittill("time_travel");
    setdvarfloat("r_poisonFX_debug_amount", 0);
    setDvar("r_poisonFX_debug_enable", 1);
    setdvarfloat("r_poisonFX_pulse", 2);
    setdvarfloat("r_poisonFX_warpX", -.3);
    setdvarfloat("r_poisonFX_warpY", .15);
    setdvarfloat("r_poisonFX_dvisionA", 0);
    setdvarfloat("r_poisonFX_dvisionX", 0);
    setdvarfloat("r_poisonFX_dvisionY", 0);
    setdvarfloat("r_poisonFX_blurMin", 0);
    setdvarfloat("r_poisonFX_blurMax", 3);
    delta = 0.064;
    amount = 1;
    setdvarfloat("r_poisonFX_debug_amount", amount);
    realWait(1.75);
    while(amount > 0) {
      amount = Max(amount - delta, 0);
      setdvarfloat("r_poisonFX_debug_amount", amount);
      wait(0.016);
    }
    setdvarfloat("r_poisonFX_debug_amount", 0);
    setDvar("r_poisonFX_debug_enable", 0);
  }
}
eclipse_watcher() {
  while(1) {
    level waittill("ec", lcn);
    if(isDefined(lcn) && lcn != 0) {
      continue;
    }
    level._in_eclipse = true;
    level notify("time_travel", level._in_eclipse);
    clientscripts\_fx::activate_exploder(402);
    clientscripts\_fx::deactivate_exploder(401);
    players = getlocalplayers();
    clientscripts\zombie_temple_fx::eclipse_fog_on();
    for(i = 0; i < players.size; i++) {
      players[i] thread temple_set_eclipse_visionset(i);
      if(isDefined(players[i]._in_cave) && players[i]._in_cave) {
        players[i] thread temple_set_visionset_caves(i);
      }
    }
    SetSunlight(0.5426, 0.6538, 0.7657);
    setsaveddvar("r_lightTweakSunLight", 11);
    level thread strobe_sky_and_transition(1.0);
    clientscripts\zombie_temple_fx::eclipse_fog_on();
  }
}
strobe_sky_and_transition(end_val) {
  val = end_val;
  delay = 0.016;
  for(i = 0; i < 10; i++) {
    SetSavedDvar("r_skyTransition", val);
    val = 1.0 - val;
    realWait(delay);
    delay = delay * 1.1;
  }
  step = 1 / 120;
  val = 1 - end_val;
  if(val == 0) {
    step *= -1;
  }
  for(i = 0; i < 120; i++) {
    SetSavedDvar("r_skyTransition", val);
    val -= step;
    wait(0.016);
  }
  SetSavedDvar("r_skyTransition", end_val);
}
daybreak_watcher() {
  while(1) {
    level waittill("db", lcn);
    if(isDefined(lcn) && lcn != 0) {
      continue;
    }
    level._in_eclipse = false;
    level notify("time_travel", level._in_eclipse);
    clientscripts\_fx::activate_exploder(401);
    clientscripts\_fx::deactivate_exploder(402);
    players = getlocalplayers();
    for(i = 0; i < players.size; i++) {
      players[i] thread clientscripts\_zombiemode::zombie_vision_set_remove(level._temple_eclipse_vision_set, 2.0, i);
      players[i] thread clientscripts\_zombiemode::zombie_vision_set_remove(level._temple_caves_eclipse_vision_set, 2.0, i);
    }
    if(isDefined(players[0]._in_cave) && players[0]._in_cave) {
      clientscripts\zombie_temple_fx::cave_fog_on();
    } else {
      clientscripts\zombie_temple_fx::cave_fog_off();
    }
    setsaveddvar("r_lightTweakSunLight", 13);
    if(!isDefined(level.first_sky_trans)) {
      level.first_sky_trans = false;
      SetSavedDvar("r_skyTransition", 0.0);
    } else {
      level thread strobe_sky_and_transition(0.0);
    }
    ResetSunlight();
  }
}
start_generator_movement() {
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    ent = GetEnt(i, "power_generator", "targetname");
    ent thread generator_move();
  }
}
generator_move() {
  offsetAngle = 0.25;
  rotTime = 0.1;
  total = 0;
  self RotateRoll(0 - offsetAngle, rotTime);
  while(true) {
    self waittill("rotatedone");
    self RotateRoll(offsetAngle * 2, rotTime);
    self waittill("rotatedone");
    self RotateRoll(0 - offsetAngle * 2, rotTime);
  }
}
watch_power_water() {
  level thread water_wheel_watch("wwr", "water_wheel_right", 120, 2.2);
  level thread water_wheel_watch("wwl", "water_wheel_left", 120, 1.8);
}
water_wheel_watch(waitFor, entName, rotate, time) {
  level waittill(waitFor);
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    wheel = GetEnt(i, entName, "targetname");
    wheel thread rotateWheel(rotate, time);
  }
}
rotateWheel(rotate, time) {
  spinUpTime = time - 0.5;
  self RotatePitch(rotate, time, spinUpTime, 0.1);
  self waittill("rotatedone");
  while(true) {
    self RotatePitch(rotate, time, 0, 0);
    self waittill("rotatedone");
  }
}
disable_deadshot(i_local_client_num) {
  while(!self hasdobj(i_local_client_num)) {
    wait(0.05);
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(self == players[i]) {
      self clearalternateaimparams();
    }
  }
}
water_gush_debug() {
  scale = 0.1;
  offset = (0, 0, 0);
  dir = anglesToForward(self.angles);
  for(i = 0; i < 5; i++) {
    Print3d(self.origin + offset, "+", (60, 60, 255), 1, scale, 10);
    scale *= 1.7;
    offset += dir * 6;
  }
}
waterfall_watcher() {
  targets = getstructarray("sq_sad", "targetname");
  while(1) {
    level waittill("WF");
    for(i = 0; i < 4; i++) {
      if(!isDefined(level._sq_std_status) || !isDefined(level._sq_std_status[i])) {
        continue;
      }
      if(level._sq_std_status[i] == 0) {
        clientscripts\_fx::activate_exploder(120 + i);
      }
      wait(0.25);
    }
  }
}
sq_std_watcher() {
  PrintLn("watcher : start");
  waitforallclients();
  PrintLn("watcher : post wfac");
  players = getlocalplayers();
  level waittill("SR");
  PrintLn("watcher : post SR");
  targets = getstructarray("sq_sad", "targetname");
  PrintLn("Client : Threading sq_std_struct_watcher on " + targets.size + " structs.");
  for(i = 0; i < targets.size; i++) {
    targets[i] thread sq_std_struct_watcher(players.size);
  }
}
sq_std_watch_for_restart(num_local_players) {
  level waittill("SR");
  if(isDefined(level._sq_std_array[self.script_int - 1])) {
    for(i = 0; i < level._sq_std_array[self.script_int - 1].size; i++) {
      if(isDefined(level._sq_std_array[self.script_int - 1][i])) {
        level._sq_std_array[self.script_int - 1][i] Delete();
      }
    }
    level._sq_std_array[self.script_int - 1] = undefined;
  }
  level._sq_std_status[self.script_int - 1] = 0;
  self thread sq_std_struct_watcher(num_local_players);
}
sq_struct_debug() {
  level endon("SR");
  level endon("ksd");
  while(1) {
    Print3D(self.origin, "+", (255, 0, 0), 1);
    wait(0.1);
  }
}
sq_std_struct_watcher(num_local_players) {
  if(!isDefined(level._sq_std_array)) {
    level._sq_std_array = [];
    level._sq_std_status = [];
    for(i = 0; i < 4; i++) {
      level._sq_std_status[i] = 0;
    }
  }
  level endon("SR");
  self thread sq_std_watch_for_restart(num_local_players);
  while(1) {
    level waittill("S" + self.script_int);
    PrintLn("*** Client : Got S " + self.script_int);
    self thread sq_struct_debug();
    level._sq_std_status[self.script_int - 1] = 1;
    level._sq_std_array[self.script_int - 1] = [];
    for(i = 0; i < num_local_players; i++) {
      e = spawn(i, self.origin, "script_model");
      e.angles = self.angles;
      e setModel("p_ztem_spikemore_spike");
      level._sq_std_array[self.script_int - 1][level._sq_std_array[self.script_int - 1].size] = e;
    }
  }
}
temple_player_connect(i_local_client_num) {
  self endon("disconnect");
  while(!ClientHasSnapshot(i_local_client_num)) {
    wait(0.05);
  }
  while(!self hasdobj(i_local_client_num)) {
    wait(0.05);
  }
  self thread clientscripts\_swimming::set_swimming_vision_set(level._temple_water_vision_set);
  if(GetLocalPlayers().size == 1) {
    self thread clientscripts\_zombiemode_ai_napalm::player_napalm_radius_overlay_fade();
  }
  self thread init_arms();
  if(i_local_client_num != 0) {
    return;
  }
  thread floating_boards_init();
  self thread disable_deadshot(i_local_client_num);
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread temple_set_visionset(i);
  }
}
temple_player_spawned(i_local_client_num) {
  self endon("disconnect");
  while(!self hasdobj(i_local_client_num)) {
    wait(0.05);
  }
  if(i_local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread temple_set_visionset(i);
    players[i] thread temple_remove_visionset_caves(i);
  }
}
init_arms() {
  wait 5;
  switch (self.model) {
    case "c_usa_dempsey_body":
      self.viewmodel = "viewmodel_usa_pow_arms";
      break;
    case "c_rus_nikolai_body":
      self.viewmodel = "viewmodel_rus_prisoner_arms";
      break;
    case "c_jap_takeo_body":
      self.viewmodel = "viewmodel_vtn_nva_standard_arms";
      break;
    case "c_ger_richtofen_body":
      self.viewmodel = "viewmodel_usa_hazmat_arms";
      break;
    default:
      println("Model " + self.model + "does not have matching view model");
      break;
  }
}
cave_vision_trigger_init() {
  caveTrigger = getent(0, "cave_vision_trig", "targetname");
  if(isDefined(caveTrigger)) {
    caveTrigger thread cave_vision_trigger_watch();
  }
}
cave_vision_trigger_watch() {
  while(1) {
    self waittill("trigger", who);
    if(who IsLocalPlayer()) {
      who = GetLocalPlayers()[who GetLocalClientNumber()];
      self thread trigger_thread(who, ::cave_vision_on, ::cave_vision_off);
    }
  }
}
cave_vision_on(player) {
  if(!player isPlayer()) {
    return;
  }
  i_local_client_num = player GetLocalClientNumber();
  player._in_cave = true;
  player temple_set_visionset_caves(i_local_client_num);
  if(level._in_eclipse) {
    clientscripts\zombie_temple_fx::eclipse_fog_on();
  } else {
    clientscripts\zombie_temple_fx::cave_fog_on();
  }
}
cave_vision_off(player) {
  if(!isDefined(player)) {
    return;
  }
  player._in_cave = false;
  if(!player isPlayer()) {
    return;
  }
  i_local_client_num = player GetLocalClientNumber();
  player temple_remove_visionset_caves(i_local_client_num);
  if(level._in_eclipse) {
    clientscripts\zombie_temple_fx::eclipse_fog_on();
  } else {
    clientscripts\zombie_temple_fx::cave_fog_off();
  }
}
temple_set_visionset(i_local_client_num) {
  self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._temple_vision_set, level._temple_vision_set_priority, 0.1, i_local_client_num);
}
temple_set_eclipse_visionset(i_local_client_num) {
  self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._temple_eclipse_vision_set, level._temple_eclipse_vision_set_priority, 0.1, i_local_client_num);
}
temple_set_visionset_caves(i_local_client_num) {
  println("***** Vision: Set Caves*****");
  self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._temple_caves_vision_set, level._temple_caves_vision_set_priority, 2.0, i_local_client_num);
  if(level._in_eclipse) {
    self thread clientscripts\_zombiemode::zombie_vision_set_apply(level._temple_caves_eclipse_vision_set, level._temple_caves_eclipse_vision_set_priority, 2.0, i_local_client_num);
  }
}
temple_remove_visionset_caves(i_local_client_num) {
  println("***** Vision: Remove Caves*****");
  self thread clientscripts\_zombiemode::zombie_vision_set_remove(level._temple_caves_vision_set, 2.0, i_local_client_num);
  if(level._in_eclipse) {
    self thread clientscripts\_zombiemode::zombie_vision_set_remove(level._temple_caves_eclipse_vision_set, 2.0, i_local_client_num);
  }
}
include_weapons() {
  include_weapon("frag_grenade_zm", false);
  include_weapon("claymore_zm", false);
  include_weapon("m1911_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_zm");
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_zm");
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("m14_zm", false);
  include_weapon("m14_upgraded_zm", false);
  include_weapon("m16_zm", false);
  include_weapon("m16_gl_upgraded_zm", false);
  include_weapon("g11_lps_zm");
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_zm");
  include_weapon("famas_upgraded_zm", false);
  include_weapon("ak74u_zm", false);
  include_weapon("ak74u_upgraded_zm", false);
  include_weapon("mp5k_zm", false);
  include_weapon("mp5k_upgraded_zm", false);
  include_weapon("mpl_zm", false);
  include_weapon("mpl_upgraded_zm", false);
  include_weapon("pm63_zm", false);
  include_weapon("pm63_upgraded_zm", false);
  include_weapon("spectre_zm");
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("cz75dw_zm");
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("ithaca_zm", false);
  include_weapon("ithaca_upgraded_zm", false);
  include_weapon("rottweil72_zm", false);
  include_weapon("rottweil72_upgraded_zm", false);
  include_weapon("spas_zm");
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_zm");
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_zm", true);
  include_weapon("aug_acog_mk_upgraded_zm", false);
  include_weapon("galil_zm");
  include_weapon("galil_upgraded_zm", false);
  include_weapon("commando_zm");
  include_weapon("commando_upgraded_zm", false);
  include_weapon("fnfal_zm");
  include_weapon("fnfal_upgraded_zm", false);
  include_weapon("dragunov_zm");
  include_weapon("dragunov_upgraded_zm", false);
  include_weapon("l96a1_zm");
  include_weapon("l96a1_upgraded_zm", false);
  include_weapon("rpk_zm");
  include_weapon("rpk_upgraded_zm", false);
  include_weapon("hk21_zm");
  include_weapon("hk21_upgraded_zm", false);
  include_weapon("m72_law_zm");
  include_weapon("m72_law_upgraded_zm", false);
  include_weapon("china_lake_zm");
  include_weapon("china_lake_upgraded_zm", false);
  include_weapon("zombie_cymbal_monkey");
  include_weapon("ray_gun_zm");
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("crossbow_explosive_zm");
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("knife_ballistic_zm", true);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_bowie_zm", false);
  include_weapon("knife_ballistic_bowie_upgraded_zm", false);
}
register_zombie_types() {
  character\clientscripts\c_viet_zombie_female_body::register_gibs();
  character\clientscripts\c_viet_zombie_female_body_alt::register_gibs();
  character\clientscripts\c_viet_zombie_nva1::register_gibs();
  character\clientscripts\c_viet_zombie_nva1_alt::register_gibs();
  character\clientscripts\c_viet_zombie_sonic::register_gibs();
  character\clientscripts\c_viet_zombie_vc::register_gibs();
}
_init_magic_box() {
  level._custom_box_monitor = ::temple_box_monitor;
  level._box_locations = array("waterfall_upper_chest", "blender_chest", "pressure_chest", "bridge_chest", "caves_water_chest", "power_chest", "caves1_chest", "caves2_chest", "caves3_chest");
  OnPlayerConnect_Callback(::_init_indicators);
  level.cachedInfo = [];
  level.initialized = [];
}
_init_indicators(clientNum) {
  structs = GetStructArray("magic_box_indicator", "targetname");
  for(i = 0; i < structs.size; i++) {
    s = structs[i];
    if(!isDefined(s.viewModels)) {
      s.viewModels = [];
    }
    s.viewModels[clientNum] = undefined;
  }
  level.initialized[clientNum] = true;
  keys = GetArrayKeys(level.cachedInfo);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    state = level.cachedInfo[key];
    temple_box_monitor(i, state, "");
  }
}
temple_box_monitor(clientNum, state, oldState) {
  if(!isDefined(level.initialized[clientNum])) {
    level.cachedInfo[clientNum] = state;
    return;
  }
  switch (state) {
    case "fire_sale":
      _all_locations(clientNum);
      break;
    case "moving":
      level thread _random_location(clientNum);
      break;
    default:
      level notify("location_set" + clientNum);
      _setup_location(clientNum, state);
      break;
  }
}
_delete_location(clientNum, location) {
  structs = GetStructArray(location, "script_noteworthy");
  array_thread(structs, ::_setup_view_model, clientNum, undefined);
}
_delete_all_locations(clientNum) {
  for(i = 0; i < level._box_locations.size; i++) {
    location = level._box_locations[i];
    _delete_location(clientNum, location);
  }
}
_show_location(clientNum, location) {
  structs = GetStructArray(location, "script_noteworthy");
  array_thread(structs, ::_setup_view_model, clientNum, "zt_map_knife");
}
_setup_location(clientNum, location) {
  _delete_all_locations(clientNum);
  _show_location(clientNum, location);
}
_setup_view_model(clientNum, viewModel) {
  if(isDefined(self.viewModels[clientNum])) {
    self.viewModels[clientNum] Delete();
    self.viewModels[clientNum] = undefined;
  }
  if(isDefined(viewModel)) {
    self.viewModels[clientNum] = spawn(clientNum, self.origin, "script_model");
    self.viewModels[clientNum].angles = self.angles;
    self.viewModels[clientNum] setModel(viewModel);
  }
}
_random_location(clientNum) {
  level endon("location_set" + clientNum);
  index = 0;
  while(true) {
    location = level._box_locations[index];
    _setup_location(clientNum, location);
    index++;
    if(index >= level._box_locations.size) {
      index = 0;
    }
    wait(0.25);
  }
}
_all_locations(clientNum) {
  for(i = 0; i < level._box_locations.size; i++) {
    location = level._box_locations[i];
    _show_location(clientNum, location);
  }
}
_init_pap_indicators() {
  waitforallclients();
  local_players = getlocalplayers();
  for(index = 0; index < local_players.size; index++) {
    level thread _init_pap_spinners(index);
    level thread _set_num_visible_spinners(index, 0);
  }
}
temple_pap_monitor_spinners(clientNum, state, oldState) {
  getlocalplayers()[clientNum] _set_num_visible_spinners(clientNum, int(state));
}
power(base, exp) {
  assert(exp >= 0);
  if(exp == 0) {
    return 1;
  }
  return base * power(base, exp - 1);
}
_set_num_visible_spinners(clientNum, num) {
  for(i = 3; i >= 0; i--) {
    pow = power(2, i);
    if(num >= pow) {
      num -= pow;
      array_thread(level.spinners[clientNum][i], ::spin_to_start);
    } else {
      array_thread(level.spinners[clientNum][i], ::spin_forever);
    }
  }
}
spike_trap_move_spikes(localClientNum, active) {
  if(!isDefined(self.spears)) {
    self set_trap_spears(localClientNum);
  }
  spears = self.spears;
  if(isDefined(spears)) {
    for(i = 0; i < spears.size; i++) {
      playSound = i == 0;
      spears[i] thread spear_init(localClientNum);
      spears[i] thread spear_move(localClientNum, active, playSound);
    }
  }
}
set_trap_spears(localClientNum) {
  allSpears = getEntArray(localClientNum, "spear_trap_spear", "targetname");
  self.spears = [];
  for(i = 0; i < allSpears.size; i++) {
    spear = allSpears[i];
    if(isDefined(spear.assigned) && spear.assigned) {
      continue;
    }
    delta = abs(self.origin[0] - spear.origin[0]);
    if(abs(self.origin[0] - spear.origin[0]) < 21) {
      spear.assigned = true;
      self.spears[self.spears.size] = spear;
    }
  }
}
spear_init(localClientNum) {
  if(!isDefined(self.init) || !self.init) {
    self.moveDistMin = 90;
    self.moveDistMax = 120;
    self.start = self.origin;
    self.moveDir = -1 * AnglesToRight(self.angles);
    self.init = true;
  }
}
spear_move(localClientNum, active, playSound) {
  if(active) {
    if(playSound) {
      play_sound_in_space(0, "evt_spiketrap_warn", self.origin);
    }
    moveDist = RandomFloatRange(self.moveDistMin, self.moveDistMax);
    endPos = self.start + (self.moveDir * moveDist);
    playFX(localClientNum, level._effect["punji_dust"], endPos);
    playSound(0, "evt_spiketrap", self.origin);
    moveTime = randomFloatRange(.08, .22);
    self MoveTo(endPos, moveTime);
  } else {
    if(playSound) {
      playSound(0, "evt_spiketrap_retract", self.origin);
    }
    moveTime = randomFloatRange(.1, .2);
    self MoveTo(self.start, moveTime);
  }
}
floating_boards_init() {
  boards = [];
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    boards = array_combine(boards, getEntArray(i, "plank_water", "targetname"));
  }
  array_thread(boards, ::float_board);
}
float_board() {
  wait(RandomFloat(1.0));
  self.start_origin = self.origin;
  self.start_angles = self.angles;
  self.moment_move = self.origin;
  self thread board_bob();
  self thread board_rotate();
}
board_bob() {
  dist = RandomFloatRange(2.5, 3.0);
  moveTime = RandomFloatRange(3.5, 4.5);
  minZ = self.start_origin[2] - dist;
  maxZ = self.start_origin[2] + dist;
  while(true) {
    toZ = minZ - self.origin[2];
    self MoveZ(toZ, moveTime);
    self waittill("movedone");
    toZ = maxZ - self.origin[2];
    self MoveZ(toZ, moveTime);
    self waittill("movedone");
  }
}
board_rotate() {
  while(true) {
    yaw = RandomFloatRange(-360.0, 360.0);
    self RotateYaw(yaw, RandomFloatRange(60.0, 90.0));
    self waittill("rotatedone");
  }
}
board_move() {
  dist = RandomFloatRange(20.0, 30.0);
  moveTime = RandomFloatRange(5.0, 10.0);
  while(true) {
    yaw = RandomFloatRange(0, 360.0);
    toVector = anglesToForward((0, yaw, 0));
    newLoc = self.start_origin + toVector * dist;
    toX = newLoc[0] - self.origin[0];
    self MoveX(toX, moveTime);
    toY = newLoc[1] - self.origin[1];
    self MoveY(toY, moveTime);
  }
}
_init_pap_spinners(cNum) {
  if(!isDefined(level.spinners)) {
    level.spinners = [];
  }
  if(level.spinners.size <= cNUm) {
    level.spinners[level.spinners.size] = array([], [], [], []);
  }
  println("***Client " + cNum + " Init Spinners");
  for(i = 0; i < level.spinners[cNum].size; i++) {
    spinners = getEntArray(cNum, "pap_spinner" + (i + 1), "targetname");
    array_thread(spinners, ::init_spinner, i + 1);
    level.spinners[cNum][i] = spinners;
  }
}
init_spinner(listNum) {
  self.spinner = listNum;
  self.startAngles = self.angles;
  self.spin_sound = "evt_pap_spinner0" + listNum;
  self.spin_stop_sound = "evt_pap_timer_stop";
  self.angles = (0, 90 * (listNum - 1) + randomFloatRange(10, 80), 0);
}
spin_forever() {
  if(!level.power) {
    return;
  }
  if(isDefined(self.spin_forever) && self.spin_forever) {
    return;
  }
  self.spin_forever = true;
  self.spin_to_start = false;
  self notify("stop_spinning");
  self endon("death");
  self endon("stop_spinning");
  spinTime = self spinner_get_spin_time();
  self start_spinner_sound();
  self rotateYaw(360, spinTime, .25);
  self waittill("rotatedone");
  while(1) {
    self rotateYaw(360, spinTime);
    self waittill("rotatedone");
  }
}
spinner_get_spin_time() {
  spinTime = 1.7;
  if(self.spinner == 2) {
    spinTime = 1.5;
  } else if(self.spinner == 3) {
    spinTime = 1.2;
  } else if(self.spinner == 4) {
    spinTime = 0.8;
  }
  return spinTime;
}
spin_to_start() {
  if(!level.power) {
    return;
  }
  if(isDefined(self.spin_to_start) && self.spin_to_start) {
    return;
  }
  self.spin_forever = false;
  self.spin_to_start = true;
  self notify("stop_spinning");
  self endon("death");
  self endon("stop_spinning");
  endYaw = self.startAngles[1];
  currentYaw = self.angles[1];
  deltaYaw = endYaw - currentYaw;
  while(deltaYaw < 0) {
    deltaYaw += 360;
  }
  spinTime = self spinner_get_spin_time();
  spinTime *= (deltaYaw / 360);
  if(spinTime > 0) {
    self rotateYaw(deltaYaw, spinTime, 0.0);
    self waittill("rotatedone");
  }
  self stop_spinner_sound();
  self.angles = self.startAngles;
}
start_spinner_sound() {
  self playLoopSound(self.spin_sound);
}
stop_spinner_sound() {
  self stoploopsound();
  self playSound(0, self.spin_stop_sound);
}
temple_light_model_swap_init() {
  level waittill("ZPO");
  realwait(4.5);
  level notify("pl1");
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    light_models = getEntArray(i, "model_lights_on", "targetname");
    for(x = 0; x < light_models.size; x++) {
      light = light_models[x];
      if(isDefined(light.script_string)) {
        light setModel(light.script_string);
      } else if(light.model == "p_ztem_power_hanging_light_off") {
        light setModel("p_ztem_power_hanging_light");
      } else if(light.model == "p_lights_cagelight02_off") {
        light setModel("p_lights_cagelight02_on");
      }
    }
  }
}
ragdoll_impact_watch_start(localClientNum, set, newEnt) {
  if(set) {
    self thread ragdoll_impact_watch(localClientNum);
  }
}
ragdoll_impact_watch(localClientNum) {
  self endon("entityshutdown");
  waitTime = .016;
  gibSpeed = 500;
  prevOrigin = self.origin;
  realwait(waitTime);
  prevVel = self.origin - prevOrigin;
  prevSpeed = length(prevVel);
  prevOrigin = self.origin;
  realwait(waitTime);
  firstloop = true;
  while(1) {
    vel = self.origin - prevOrigin;
    speed = length(vel);
    if(speed < prevSpeed * .5 && prevSpeed > gibSpeed * waitTime) {
      dir = VectorNormalize(prevVel);
      self gib_ragdoll(localClientNum, dir);
      break;
    }
    if(prevSpeed < gibSpeed * waitTime && !firstloop) {
      break;
    }
    prevOrigin = self.origin;
    prevVel = vel;
    prevSpeed = speed;
    firstloop = false;
    realwait(waitTime);
  }
}
gib_ragdoll(localClientNum, hitDir) {
  if(is_mature()) {
    waterHeight = GetWaterHeight(self.origin);
    if((waterHeight + 10) < self.origin[2]) {
      playFX(localClientNum, level._effect["rag_doll_gib_mini"], self.origin, hitDir * -1);
    } else {}
  }
}
maze_floor_controller_rumble(localClientNum, set, newEnt) {
  player = getlocalplayers()[localClientNum];
  if(player GetEntityNumber() != self GetEntityNumber()) {
    return;
  }
  if(set) {
    self thread maze_rumble_while_floor_shakes(localClientNum);
  } else {
    self notify("stop_maze_rumble");
    self StopRumble(localClientNum, "slide_rumble");
  }
}
maze_rumble_while_floor_shakes(int_client_num) {
  self endon("stop_maze_rumble");
  while(isDefined(self)) {
    self PlayRumbleOnEntity(int_client_num, "slide_rumble");
    wait(0.05);
  }
}
waterfall_triggers_init() {
  waitforallclients();
  trigs = getEntArray(0, "waterfall_fog_change", "targetname");
  if(!isDefined(trigs)) {
    return;
  }
  for(i = 0; i < trigs.size; i++) {
    trigs[i] thread waterfall_fog_trigger();
  }
}
waterfall_fog_trigger() {
  while(1) {
    self waittill("trigger", who);
    if(who IsLocalPlayer()) {
      start_dist = 257.581;
      half_dist = 3581.88;
      half_height = 461.457;
      base_height = -652.425;
      fog_r = 0.0784314;
      fog_g = 0.129412;
      fog_b = 0.105882;
      fog_scale = 5.97369;
      sun_col_r = 1;
      sun_col_g = 0.380392;
      sun_col_b = 0.109804;
      sun_dir_x = -0.893398;
      sun_dir_y = -0.219239;
      sun_dir_z = 0.392141;
      sun_start_ang = 11.4807;
      sun_stop_ang = 91.2748;
      time = 2;
      max_fog_opacity = 0.590773;
      println("*** Client : changing to waterfall fog");
      setVolFogForClient(who GetLocalClientNumber(), start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale, sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang, sun_stop_ang, time, max_fog_opacity);
    }
  }
}