/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_bb;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_astro;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_ai_quad;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_equip_gasmask;
#using scripts\zm\_zm_equip_hacker;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hackables_boards;
#using scripts\zm\_zm_hackables_box;
#using scripts\zm\_zm_hackables_doors;
#using scripts\zm\_zm_hackables_packapunch;
#using scripts\zm\_zm_hackables_perks;
#using scripts\zm\_zm_hackables_powerups;
#using scripts\zm\_zm_hackables_wallbuys;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_timer;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_annihilator;
#using scripts\zm\_zm_weap_black_hole_bomb;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_bowie;
#using scripts\zm\_zm_weap_microwavegun;
#using scripts\zm\_zm_weap_quantum_bomb;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#using scripts\zm\zm_moon;
#using scripts\zm\zm_moon_achievement;
#using scripts\zm\zm_moon_ai_quad;
#using scripts\zm\zm_moon_amb;
#using scripts\zm\zm_moon_digger;
#using scripts\zm\zm_moon_ffotd;
#using scripts\zm\zm_moon_fx;
#using scripts\zm\zm_moon_gravity;
#using scripts\zm\zm_moon_jump_pad;
#using scripts\zm\zm_moon_sq;
#using scripts\zm\zm_moon_teleporter;
#using scripts\zm\zm_moon_utility;
#using scripts\zm\zm_moon_wasteland;
#using scripts\zm\zm_moon_zombie;
#using scripts\zm\zm_zmhd_cleanup_mgr;
#namespace zm_moon;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
  level.pack_a_punch_camo_index = 132;
}

function main() {
  level thread zm_moon_ffotd::main_start();
  level.default_game_mode = "zclassic";
  level.default_start_location = "default";
  level.use_multiple_spawns = 1;
  level.use_low_gravity_risers = 1;
  level.sndzhdaudio = 1;
  level.var_bbd4901d = getweapon("equip_hacker");
  level._num_overriden_models = 0;
  level._use_choke_weapon_hints = 1;
  level._use_choke_blockers = 1;
  level._special_blackhole_bomb_structs = &blackhole_bomb_area_check;
  level._limited_equipment = [];
  level._limited_equipment[level._limited_equipment.size] = level.var_bbd4901d;
  level._override_blackhole_destination_logic = &get_blackholebomb_destination_point;
  level._blackhole_bomb_valid_area_check = &blackhole_bomb_in_invalid_area;
  level.quantum_bomb_prevent_player_getting_teleported = &quantum_bomb_prevent_player_getting_teleported_override;
  level.func_magicbox_update_prompt_use_override = &func_magicbox_update_prompt_use_override;
  level.func_jump_pad_pulse_override = &zm_moon_jump_pad::function_d4f0f4fe;
  level.dont_unset_perk_when_machine_paused = 1;
  level._no_water_risers = 1;
  level.use_clientside_board_fx = 1;
  level.riser_fx_on_client = 1;
  level.risers_use_low_gravity_fx = 1;
  level.debug_astro = 1;
  level._round_start_func = &zm::round_start;
  callback::on_connect(&function_35a61719);
  callback::on_spawned(&on_player_spawned);
  zm_moon_fx::main();
  zm::init_fx();
  level.zombiemode = 1;
  zm_moon_amb::main();
  level thread setupmusic();
  init_sounds();
  if(getdvarint("artist") > 0) {
    return;
  }
  level.var_6225e4bb = tablelookuprowcount("gamedata/tables/zm/zm_astro_names.csv");
  register_clientfields();
  zm_moon_sq::init_clientfields();
  level.player_out_of_playable_area_monitor = 1;
  level.player_out_of_playable_area_monitor_callback = &zombie_moon_player_out_of_playable_area_monitor_callback;
  level thread moon_create_life_trigs();
  level.traps = [];
  level.round_think_func = &moon_round_think_func;
  level.random_pandora_box_start = 1;
  level.door_dialog_function = &zm::play_door_dialog;
  level.quad_move_speed = 35;
  level.quad_explode = 1;
  level.dogs_enabled = 1;
  level.custom_ai_type = [];
  if(!isDefined(level.custom_ai_type)) {
    level.custom_ai_type = [];
  } else if(!isarray(level.custom_ai_type)) {
    level.custom_ai_type = array(level.custom_ai_type);
  }
  level.custom_ai_type[level.custom_ai_type.size] = &zm_ai_dogs::init;
  spawner::add_archetype_spawn_function("zombie_dog", &function_6db62803);
  spawner::add_archetype_spawn_function("astronaut", &function_ff7d3b7);
  level thread zm_moon_utility::hacker_location_random_init();
  level._zombie_custom_add_weapons = &custom_add_weapons;
  level.zombiemode_gasmask_reset_player_model = &gasmask_reset_player_model;
  level.zombiemode_gasmask_reset_player_viewmodel = &gasmask_reset_player_set_viewmodel;
  level.zombiemode_gasmask_change_player_headmodel = &gasmask_change_player_headmodel;
  level.zombiemode_gasmask_set_player_model = &gasmask_set_player_model;
  level.zombiemode_gasmask_set_player_viewmodel = &gasmask_set_player_viewmodel;
  level.register_offhand_weapons_for_level_defaults_override = &moon_offhand_weapon_overrride;
  level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
  level._allow_melee_weapon_switching = 1;
  level._hack_perks_override = &function_9f47ebff;
  level.givecustomcharacters = &givecustomcharacters;
  initcharacterstartindex();
  level.use_zombie_heroes = 1;
  level.moon_startmap = 1;
  level._zm_blocker_trigger_think_return_override = &function_d70e1ddb;
  level._zm_build_trigger_from_unitrigger_stub_override = &function_89f86341;
  load::main();
  level.default_laststandpistol = getweapon("pistol_m1911");
  level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
  level.laststandpistol = level.default_laststandpistol;
  level.start_weapon = level.default_laststandpistol;
  level thread zm::last_stand_pistol_rank_init();
  zm_ai_quad::function_5af423f4();
  level thread zm_moon_sq::start_moon_sidequest();
  level thread function_54bf648f();
  level.var_9aaae7ae = &function_869d6f66;
  level.var_2d4e3645 = &function_d9e1ec4d;
  level.var_35efa94c = &function_f97e7fed;
  level.var_9f5c2c50 = &function_e36dbcf4;
  level.var_4824bb2d = &function_69e4bd99;
  level thread zm::register_sidequest("EOA", "ZOMBIE_TEMPLE_SIDEQUEST");
  level thread zm::register_sidequest("MOON", "ZOMBIE_MOON_SIDEQUEST_TOTAL");
  _zm_weap_bowie::init();
  level.zone_manager_init_func = &moon_zone_init;
  init_zones[0] = "bridge_zone";
  init_zones[1] = "nml_zone";
  level thread zm_zonemgr::manage_zones(init_zones);
  level.zombie_ai_limit = 24;
  level zm_moon_digger::digger_init_flags();
  level thread zm_moon_achievement::init();
  level thread electric_switch();
  zm_moon_wasteland::init_no_mans_land();
  level thread zm_moon_teleporter::teleporter_check_for_endgame();
  level thread zm_moon_teleporter::teleporter_function("generator_teleporter");
  level thread zm_moon_teleporter::teleporter_function("nml_teleporter");
  level thread zm_moon_utility::init_zombie_airlocks();
  level thread setup_water_physics();
  zombie_utility::set_zombie_var("zombie_intermission_time", 15);
  zombie_utility::set_zombie_var("zombie_between_round_time", 10);
  level thread zm_moon_digger::digger_init();
  zm_moon_gravity::init();
  zm_moon_jump_pad::init();
  level thread zm_moon_gravity::zombie_moon_update_player_gravity();
  level thread zm_moon_gravity::zombie_moon_update_player_float();
  level thread init_hackables();
  execdevgui("");
  level.custom_devgui = &moon_devgui;
  level.custom_intermission = &zm_moon_utility::moon_intermission;
  level thread no_mans_land_power();
  level thread cliff_fall_death();
  level thread setup_fields();
  level.tunnel_6_destroyed = getent("tunnel_6_destroyed", "targetname");
  level.tunnel_6_destroyed hide();
  level.tunnel_11_destroyed = getent("tunnel_11_destroyed", "targetname");
  level.tunnel_11_destroyed hide();
  level.perk_lost_func = &moon_perk_lost;
  level._black_hole_bomb_poi_override = &moon_black_hole_bomb_poi;
  level.check_valid_spawn_override = &moon_respawn_override;
  level._zombiemode_post_respawn_callback = &moon_post_respawn_callback;
  level._poi_override = &moon_bhb_poi_control;
  level._override_quad_explosion = &override_quad_explosion;
  level.zombie_speed_up = &moon_speed_up;
  level.ai_astro_explode = &moon_push_zombies_when_astro_explodes;
  level thread spare_change();
  setdvar("dlc5_get_client_weapon_from_entitystate", 1);
  setdvar("hkai_pathfindIterationLimit", 900);
  scene::add_scene_func("cin_zmhd_sizzle_moon_cam", &cin_zmhd_sizzle_moon_cam, "play");
  level thread zm_moon_ffotd::main_end();
}

function function_ff7d3b7() {
  do {
    var_1acd84fb = randomint(level.var_6225e4bb);
    var_1acd84fb = var_1acd84fb + 1;
  }
  while(level.var_2c6ea600 === var_1acd84fb);
  level.var_2c6ea600 = var_1acd84fb;
  self clientfield::set("astro_name_index", var_1acd84fb);
  foreach(player in level.players) {
    if(zombie_utility::is_player_valid(player)) {
      owner = player;
      break;
    }
  }
  if(!isDefined(owner)) {
    owner = level.players[0];
  }
  self setentityowner(owner);
  self setclone();
}

function cin_zmhd_sizzle_moon_cam(a_ents) {
  level.disable_print3d_ent = 1;
  var_3aa9d35a = getEntArray("airlock_bridge_zone", "script_parameters");
  foreach(var_1cec30db in var_3aa9d35a) {
    var_7be3ca60 = getEntArray(var_1cec30db.target, "targetname");
    foreach(mdl_door in var_7be3ca60) {
      mdl_door hide();
    }
  }
  foreach(var_6cae1ad0 in a_ents) {
    if(issubstr(var_6cae1ad0.model, "body")) {
      var_6cae1ad0 clientfield::set("zombie_has_eyes", 1);
    }
  }
}

function function_6db62803() {
  self.ignorevortices = 1;
}

function moon_push_zombies_when_astro_explodes(position) {
  level.quantum_bomb_cached_closest_zombies = undefined;
  self thread zm_weap_quantum_bomb::quantum_bomb_zombie_fling_result(position);
}

function function_869d6f66() {
  if(!isDefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
    return false;
  }
  if(self.zone_name === "nml_zone") {
    return false;
  }
  return true;
}

function function_f97e7fed() {
  if(self.zone_name === "nml_zone") {
    return false;
  }
  return true;
}

function function_e36dbcf4() {
  if(isDefined(level.var_d8417111) && level.var_d8417111) {
    return false;
  }
  return true;
}

function function_69e4bd99() {
  if(level flag::get("enter_nml")) {
    return false;
  }
  return true;
}

function function_d9e1ec4d(var_bbf77908) {
  var_7de051f = struct::get("nml_zone", "script_noteworthy");
  arrayremovevalue(var_bbf77908, var_7de051f);
  return var_bbf77908;
}

function moon_post_respawn_callback() {
  if(level flag::get("enter_nml")) {
    self clientfield::set_to_player("player_sky_transition", 1);
  } else {
    self clientfield::set_to_player("player_sky_transition", 0);
  }
  if(!zm_equipment::limited_in_use(level.var_bbd4901d)) {
    self zm_equipment::set_equipment_invisibility_to_player(level.var_bbd4901d, 0);
  }
}

function setup_fields() {
  level flag::wait_till("power_on");
  exploder::exploder("fxexp_140");
  exploder::exploder("fxexp_1100");
  exploder::exploder("lgt_power_on");
  exploder::exploder("lgtexp_exc_powerOn");
  level.var_2f9ab492 = [];
  level.var_2f9ab492["enter_forest_east_zone"] = "fxexp_1010";
  level.var_2f9ab492["generator_exit_east_zone"] = "fxexp_1011";
  level.var_2f9ab492["cata_left_middle_zone"] = "fxexp_1012";
  level.var_2f9ab492["cata_right_middle_zone"] = "fxexp_1013";
  level.var_2f9ab492["bridge_zone"] = "fxexp_1014";
  foreach(str_zone, str_exploder in level.var_2f9ab492) {
    if(!isDefined(level.zones[str_zone].volumes[0].script_string) || level.zones[str_zone].volumes[0].script_string != "lowgravity") {
      exploder::exploder(level.var_2f9ab492[str_zone]);
    }
  }
  level clientfield::set("zombie_power_on", 1);
}

function no_mans_land_power() {
  level thread turn_area51_perks_on();
  level notify("pack_a_punch_on");
}

function turn_area51_perks_on() {
  wait(0.2);
  machine = getEntArray("vending_sleight", "targetname");
  for(i = 0; i < machine.size; i++) {
    machine[i] setModel("p7_zm_vending_sleight");
  }
  level notify("specialty_fastreload_power_on");
  machine2 = getEntArray("vending_jugg", "targetname");
  for(i = 0; i < machine2.size; i++) {
    machine2[i] setModel("p7_zm_vending_jugg");
    machine2[i] playSound("zmb_perks_power_on");
  }
  level notify("specialty_armorvest_power_on");
}

function init_hackables() {
  level thread zm_hackables_wallbuys::hack_wallbuys();
  level thread zm_hackables_perks::hack_perks();
  level thread zm_hackables_packapunch::hack_packapunch();
  level thread zm_hackables_boards::hack_boards();
  level thread zm_hackables_doors::hack_doors("zombie_airlock_buy", &zm_moon_utility::moon_door_opened);
  level thread zm_hackables_doors::hack_doors();
  level thread zm_hackables_powerups::hack_powerups();
  level thread zm_hackables_box::box_hacks();
  level thread packapunch_hack_think();
  level thread pack_gate_poi_init();
}

function function_d70e1ddb(player) {
  if(player zm_equipment::is_active(level.var_bbd4901d)) {
    if(isDefined(self.unitrigger_stub.playertrigger)) {
      zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    }
    return true;
  }
  return false;
}

function function_89f86341(player) {
  if(player zm_equipment::is_active(level.var_bbd4901d)) {
    if(isDefined(self.trigger_target)) {
      if(self.trigger_target.targetname == "exterior_goal") {
        return true;
      }
    }
  }
  return false;
}

function zombie_moon_player_out_of_playable_area_monitor_callback() {
  if(isDefined(self._padded) && self._padded) {
    return false;
  }
  if(isDefined(self.insta_killed) && self.insta_killed) {
    return false;
  }
  return true;
}

function moon_create_life_trigs() {}

function packapunch_hack_think() {
  level flag::init("packapunch_hacked");
  time = 30;
  pack_gates = getEntArray("zombieland_gate", "targetname");
  for(i = 0; i < pack_gates.size; i++) {
    pack_gates[i].startpos = pack_gates[i].origin;
  }
  while(true) {
    level waittill("packapunch_hacked");
    level flag::clear("packapunch_hacked");
    array::thread_all(pack_gates, &pack_gate_activate);
    level thread pack_gate_poi_activate(time);
    wait(time);
    level flag::set("packapunch_hacked");
    zm_equip_hacker::register_pooled_hackable_struct(level._pack_hack_struct, &zm_hackables_packapunch::packapunch_hack);
  }
}

function pack_gate_poi_init() {
  pack_zombieland_poi = getEntArray("zombieland_poi", "targetname");
  for(i = 0; i < pack_zombieland_poi.size; i++) {
    pack_zombieland_poi[i] zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
    pack_zombieland_poi[i] thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
  }
}

function pack_gate_poi_activate(time) {
  pack_enclosure = getent("pack_enclosure", "targetname");
  pack_zombieland_poi = getEntArray("zombieland_poi", "targetname");
  players = getplayers();
  num_players_inside = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] istouching(pack_enclosure)) {
      num_players_inside++;
    }
  }
  if(num_players_inside != players.size) {
    return;
  }
  level thread activate_zombieland_poi_positions(time);
  level thread watch_for_exit(pack_zombieland_poi);
  while(!level flag::get("packapunch_hacked")) {
    zombies = getaiarray();
    for(i = 0; i < zombies.size; i++) {
      if(zombies[i] istouching(pack_enclosure)) {
        zombies[i].in_pack_enclosure = 1;
        zombies[i] thread moon_zombieland_ignore_poi();
        continue;
      }
      if(!(isDefined(zombies[i]._poi_pack_set) && zombies[i]._poi_pack_set)) {
        zombies[i] thread switch_between_zland_poi();
        zombies[i] thread moon_nml_bhb_present();
        zombies[i]._poi_pack_set = 1;
      }
    }
    wait(1);
  }
  level flag::wait_till("packapunch_hacked");
  level notify("stop_pack_poi");
  zombies = getaiarray();
  for(i = 0; i < zombies.size; i++) {
    zombies[i]._poi_pack_set = 0;
  }
  for(i = 0; i < pack_zombieland_poi.size; i++) {
    pack_zombieland_poi[i] function_47f0ea80();
  }
}

function switch_between_zland_poi() {
  self endon("death");
  level endon("packapunch_hacked");
  self endon("nml_bhb");
  poi_array = getEntArray("zombieland_poi", "targetname");
  for(x = 0; x < poi_array.size; x++) {
    if(isDefined(poi_array[x].poi_active) && poi_array[x].poi_active) {
      self zm_utility::add_poi_to_ignore_list(poi_array[x]);
    }
  }
  poi_array = array::randomize(poi_array);
  while(!level flag::get("packapunch_hacked")) {
    for(i = 0; i < poi_array.size; i++) {
      self zm_utility::remove_poi_from_ignore_list(poi_array[i]);
      self util::waittill_any_ex(randomintrange(2, 5), "goal", "bad_path", "death", "nml_bhb", level, "packapunch_hacked");
      self zm_utility::add_poi_to_ignore_list(poi_array[i]);
    }
    poi_array = array::randomize(poi_array);
    self zm_utility::remove_poi_from_ignore_list(poi_array[0]);
    wait(0.05);
  }
}

function remove_ignore_on_poi(poi_array) {
  self endon("death");
  level waittill("stop_pack_poi");
  for(i = 0; i < poi_array.size; i++) {
    self zm_utility::remove_poi_from_ignore_list(poi_array[i]);
  }
  self._poi_pack_set = 0;
}

function activate_zombieland_poi_positions(time) {
  level endon("stop_pack_poi");
  pack_zombieland_poi = getEntArray("zombieland_poi", "targetname");
  for(i = 0; i < pack_zombieland_poi.size; i++) {
    poi = pack_zombieland_poi[i];
    poi zm_utility::activate_zombie_point_of_interest();
  }
}

function function_47f0ea80() {
  if(self.script_noteworthy != "zombie_poi") {
    return;
  }
  for(i = 0; i < self.attractor_array.size; i++) {
    self.attractor_array[i] notify("kill_poi");
  }
  self.attractor_array = [];
  self.claimed_attractor_positions = [];
  self.poi_active = 0;
}

function watch_for_exit(poi_array) {
  while(players_in_zombieland() && !level flag::get("packapunch_hacked")) {
    wait(0.1);
  }
  level notify("stop_pack_poi");
  for(i = 0; i < poi_array.size; i++) {
    poi_array[i] function_47f0ea80();
  }
}

function players_in_zombieland() {
  pack_enclosure = getent("pack_enclosure", "targetname");
  players = getplayers();
  num_players_inside = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] istouching(pack_enclosure)) {
      num_players_inside++;
    }
  }
  if(num_players_inside != players.size) {
    return false;
  }
  return true;
}

function check_for_avoid_poi() {
  if(isDefined(self.in_pack_enclosure) && self.in_pack_enclosure) {
    return true;
  }
  return false;
}

function pack_gate_activate() {
  time = 1;
  self notsolid();
  if(isDefined(self.script_vector)) {
    self playSound("amb_teleporter_gate_start");
    self moveto(self.startpos + self.script_vector, time);
    self thread pack_gate_closed();
    level flag::wait_till("packapunch_hacked");
    self notsolid();
    if(self.classname == "script_brushmodel") {
      self connectpaths();
    }
    self playSound("amb_teleporter_gate_start");
    self moveto(self.startpos, time);
    self thread zm_blockers::door_solid_thread();
  }
}

function pack_gate_closed() {
  self waittill("movedone");
  self.door_moving = undefined;
  while(true) {
    players = getplayers();
    player_touching = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        player_touching = 1;
        break;
      }
    }
    if(!player_touching) {
      self solid();
      self disconnectpaths();
      return;
    }
    wait(1);
  }
}

function moon_nml_bhb_present() {
  self endon("death");
  nml_bhb = undefined;
  pack_zombieland_poi = getEntArray("zombieland_poi", "targetname");
  pack_enclosure = getent("pack_enclosure", "targetname");
  while(!level flag::get("packapunch_hacked")) {
    zombie_pois = getEntArray("zombie_poi", "script_noteworthy");
    for(i = 0; i < zombie_pois.size; i++) {
      if(isDefined(zombie_pois[i].targetname) && zombie_pois[i].targetname == "zm_bhb") {
        if(moon_zmb_and_bhb_touching_trig(zombie_pois[i])) {
          nml_bhb = zombie_pois[i];
          self zm_utility::remove_poi_from_ignore_list(nml_bhb);
          continue;
        }
        self zm_utility::add_poi_to_ignore_list(zombie_pois[i]);
      }
    }
    if(isDefined(nml_bhb)) {
      self notify("nml_bhb");
      for(j = 0; j < pack_zombieland_poi.size; j++) {
        self zm_utility::add_poi_to_ignore_list(pack_zombieland_poi[j]);
      }
    } else {
      wait(0.1);
      continue;
    }
    while(isDefined(nml_bhb)) {
      wait(0.1);
    }
    self thread switch_between_zland_poi();
    wait(0.1);
  }
  return false;
}

function moon_zmb_and_bhb_touching_trig(ent_bhb) {
  self endon("death");
  if(!isDefined(ent_bhb)) {
    return false;
  }
  pack_trig = getent("pack_enclosure", "targetname");
  if(self istouching(pack_trig) && isDefined(ent_bhb) && ent_bhb istouching(pack_trig)) {
    return true;
  }
  if(!self istouching(pack_trig) && isDefined(ent_bhb) && !ent_bhb istouching(pack_trig)) {
    return true;
  }
  return false;
}

function moon_zombieland_ignore_poi() {
  self endon("death");
  nml_poi_array = getEntArray("zombieland_poi", "targetname");
  if(isDefined(self._zmbl_ignore) && self._zmbl_ignore) {
    return;
  }
  self._zmbl_ignore = 1;
  for(i = 0; i < nml_poi_array.size; i++) {
    self zm_utility::add_poi_to_ignore_list(nml_poi_array[i]);
  }
  while(!level flag::get("packapunch_hacked")) {
    bhb_bomb = getEntArray("zm_bhb", "targetname");
    if(isDefined(bhb_bomb)) {
      for(w = 0; w < bhb_bomb.size; w++) {
        if(!moon_zmb_and_bhb_touching_trig(bhb_bomb[w])) {
          self zm_utility::add_poi_to_ignore_list(bhb_bomb[w]);
        }
      }
    }
    wait(0.1);
  }
  for(x = 0; x < nml_poi_array.size; x++) {
    self zm_utility::remove_poi_from_ignore_list(nml_poi_array[x]);
  }
}

function zombie_moon_gravity_init() {}

function zombie_earth_gravity_init() {}

function register_clientfields() {
  clientfield::register("scriptmover", "digger_moving", 21000, 1, "int");
  clientfield::register("scriptmover", "digger_digging", 21000, 1, "int");
  clientfield::register("scriptmover", "digger_arm_fx", 21000, 1, "int");
  clientfield::register("scriptmover", "dome_malfunction_pad", 21000, 1, "int");
  clientfield::register("toplayer", "player_sky_transition", 21000, 1, "int");
  clientfield::register("toplayer", "soul_swap", 21000, 1, "int");
  clientfield::register("toplayer", "gasp_rumble", 21000, 1, "int");
  clientfield::register("toplayer", "biodome_exploder", 21000, 1, "int");
  clientfield::register("toplayer", "snd_lowgravity", 21000, 1, "int");
  clientfield::register("actor", "low_gravity", 21000, 1, "int");
  clientfield::register("actor", "ctt", 21000, 1, "int");
  clientfield::register("actor", "sd", 21000, 1, "int");
  clientfield::register("world", "jump_pad_pulse", 21000, 3, "counter");
  clientfield::register("toplayer", "gas_mask_buy", 21000, 1, "counter");
  clientfield::register("toplayer", "gas_mask_on", 21000, 1, "counter");
  clientfield::register("world", "show_earth", 21000, 1, "counter");
  clientfield::register("world", "show_destroyed_earth", 21000, 1, "counter");
  clientfield::register("world", "hide_earth", 21000, 1, "counter");
  if(isDefined(level.var_6225e4bb) && level.var_6225e4bb > 0) {
    clientfield::register("actor", "astro_name_index", 21000, getminbitcountfornum(level.var_6225e4bb + 1), "int");
  }
  clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
  clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int");
  clientfield::register("clientuimodel", "hudItems.showDpadDown_HackTool", 21000, 1, "int");
  for(i = 0; i < 4; i++) {
    clientfield::register("world", ("player" + i) + "wearableItem", 21000, 1, "int");
  }
  clientfield::register("world", "BIO", 21000, 1, "int");
  clientfield::register("world", "DH", 21000, 1, "int");
  clientfield::register("world", "TCA", 21000, 1, "int");
  clientfield::register("world", "HCA", 21000, 1, "int");
  clientfield::register("world", "BCA", 21000, 1, "int");
  clientfield::register("world", "Az1", 21000, 1, "counter");
  clientfield::register("world", "Az2a", 21000, 1, "counter");
  clientfield::register("world", "Az2b", 21000, 1, "counter");
  clientfield::register("world", "Az3a", 21000, 1, "counter");
  clientfield::register("world", "Az3b", 21000, 1, "counter");
  clientfield::register("world", "Az3c", 21000, 1, "counter");
  clientfield::register("world", "Az4a", 21000, 1, "counter");
  clientfield::register("world", "Az4b", 21000, 1, "counter");
  clientfield::register("world", "Az5", 21000, 1, "counter");
}

function moon_round_think_func(restart = 0) {
  println("");
  level endon("end_round_think");
  if(!(isDefined(restart) && restart)) {
    if(isDefined(level.initial_round_wait_func)) {
      [
        [level.initial_round_wait_func]
      ]();
    }
    if(!(isDefined(level.host_ended_game) && level.host_ended_game)) {
      players = getplayers();
      foreach(player in players) {
        if(!(isDefined(player.hostmigrationcontrolsfrozen) && player.hostmigrationcontrolsfrozen)) {
          player freezecontrols(0);
          println("");
        }
        player zm_stats::set_global_stat("rounds", level.round_number);
      }
    }
  }
  setroundsplayed(level.round_number);
  for(;;) {
    maxreward = 50 * level.round_number;
    if(maxreward > 500) {
      maxreward = 500;
    }
    level.zombie_vars["rebuild_barrier_cap_per_round"] = maxreward;
    level.pro_tips_start_time = gettime();
    level.zombie_last_run_time = gettime();
    if(level.moon_startmap == 1) {
      level.moon_startmap = 0;
      level thread zm::play_level_start_vox_delayed();
      wait(3);
    } else {
      if(!(isDefined(level.var_d2b6176f) && level.var_d2b6176f)) {
        level.var_d2b6176f = 1;
      } else if(isDefined(level.on_the_moon) && level.on_the_moon) {
        if(level.round_number <= 5) {
          level thread zm_audio::sndmusicsystem_playstate("round_start");
        } else {
          level thread zm_audio::sndmusicsystem_playstate("round_start_short");
        }
      }
    }
    zm::round_one_up();
    players = getplayers();
    array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
    if(!(isDefined(level.headshots_only) && level.headshots_only) && (!(isDefined(restart) && restart))) {
      if(!level flag::get("teleporter_used") || level.first_round == 1) {
        level thread zm::award_grenades_for_survivors();
      }
    }
    println((("" + level.round_number) + "") + players.size);
    level.round_start_time = gettime();
    while(level.zm_loc_types["zombie_location"].size <= 0) {
      wait(0.1);
    }
    zkeys = getarraykeys(level.zones);
    for(i = 0; i < zkeys.size; i++) {
      zonename = zkeys[i];
      level.zones[zonename].round_spawn_count = 0;
    }
    level thread[[level.round_spawn_func]]();
    level notify("start_of_round");
    recordzombieroundstart();
    bb::logroundevent("start_of_round");
    players = getplayers();
    for(index = 0; index < players.size; index++) {
      players[index] zm::recordroundstartstats();
    }
    if(isDefined(level.round_start_custom_func)) {
      [
        [level.round_start_custom_func]
      ]();
    }
    if(level flag::get("teleporter_used")) {
      level flag::clear("teleporter_used");
      if(level.prev_round_zombies != 0) {
        level.zombie_total = level.prev_round_zombies;
      }
    }
    [[level.round_wait_func]]();
    if(level.on_the_moon && (!(isDefined(level._from_nml) && level._from_nml) || level.first_round)) {
      zm_powerups::powerup_round_start();
    }
    level.first_round = 0;
    level notify("end_of_round");
    level flag::set("between_rounds");
    bb::logroundevent("end_of_round");
    uploadstats();
    players = getplayers();
    if(!level flag::get("teleporter_used")) {
      if(isDefined(level.on_the_moon) && level.on_the_moon) {
        level thread zm_audio::sndmusicsystem_playstate("round_end");
      }
      if(isDefined(level.no_end_game_check) && level.no_end_game_check) {
        level thread zm::last_stand_revive();
        level thread zm::spectators_respawn();
      } else if(1 != players.size) {
        level thread zm::spectators_respawn();
      }
    }
    if(isDefined(level.round_end_custom_logic)) {
      [
        [level.round_end_custom_logic]
      ]();
    }
    if(level flag::get("teleporter_used")) {
      if(level.prev_round_zombies != 0 && !level flag::get("enter_nml")) {
        zm::set_round_number(level.nml_last_round);
      }
    }
    players = getplayers();
    array::thread_all(players, &zm_pers_upgrades_system::round_end);
    if(((int(level.round_number / 5)) * 5) == level.round_number) {
      level clientfield::set("round_complete_time", int(((level.time - level.n_gameplay_start_time) + 500) / 1000));
      level clientfield::set("round_complete_num", level.round_number);
    }
    if(level.gamedifficulty == 0) {
      level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
    } else {
      level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
    }
    if(!level flag::get("teleporter_used")) {
      zm::set_round_number(1 + zm::get_round_number());
      setroundsplayed(zm::get_round_number());
    }
    level.round_number = zm::get_round_number();
    timer = level.zombie_vars["zombie_spawn_delay"];
    if(timer > 0.08) {
      level.zombie_vars["zombie_spawn_delay"] = timer * 0.95;
    } else if(timer < 0.08) {
      level.zombie_vars["zombie_spawn_delay"] = 0.08;
    }
    matchutctime = getutc();
    players = getplayers();
    foreach(player in players) {
      if(level.curr_gametype_affects_rank && zm::get_round_number() > (3 + level.start_round)) {
        player zm_stats::add_client_stat("weighted_rounds_played", zm::get_round_number());
      }
      player zm_stats::set_global_stat("rounds", zm::get_round_number());
      player zm_stats::update_playing_utc_time(matchutctime);
      player zm_perks::perk_set_max_health_if_jugg("health_reboot", 1, 1);
      for(i = 0; i < 4; i++) {
        player.number_revives_per_round[i] = 0;
      }
      if(isalive(player) && player.sessionstate != "spectator" && (!(isDefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp))) {
        player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
        score_number = zm::get_round_number() - 1;
        if(score_number < 1) {
          score_number = 1;
        } else if(score_number > 20) {
          score_number = 20;
        }
        scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
      }
    }
    if(isDefined(level.check_quickrevive_hotjoin)) {
      [
        [level.check_quickrevive_hotjoin]
      ]();
    }
    level zm::round_over();
    level notify("between_round_over");
    level flag::clear("between_rounds");
    level.skip_alive_at_round_end_xp = 0;
    restart = 0;
  }
}

function moon_zone_init() {
  level flag::init("always_on");
  level flag::set("always_on");
  zm_zonemgr::add_adjacent_zone("airlock_bridge_zone", "bridge_zone", "receiving_exit");
  zm_zonemgr::add_adjacent_zone("airlock_bridge_zone", "water_zone", "receiving_exit");
  zm_zonemgr::add_adjacent_zone("bridge_zone", "water_zone", "receiving_exit");
  zm_zonemgr::add_adjacent_zone("airlock_west_zone", "water_zone", "catacombs_west");
  zm_zonemgr::add_adjacent_zone("airlock_west_zone", "cata_left_start_zone", "catacombs_west");
  zm_zonemgr::add_adjacent_zone("water_zone", "cata_left_start_zone", "catacombs_west");
  zm_zonemgr::add_adjacent_zone("cata_left_start_zone", "cata_left_middle_zone", "tunnel_6_door1");
  zm_zonemgr::add_adjacent_zone("airlock_east_zone", "water_zone", "catacombs_east");
  zm_zonemgr::add_adjacent_zone("airlock_east_zone", "cata_right_start_zone", "catacombs_east");
  zm_zonemgr::add_adjacent_zone("cata_right_start_zone", "water_zone", "catacombs_east");
  zm_zonemgr::add_adjacent_zone("airlock_east2_zone", "generator_zone", "catacombs_east4");
  zm_zonemgr::add_adjacent_zone("airlock_east2_zone", "cata_right_end_zone", "catacombs_east4");
  zm_zonemgr::add_adjacent_zone("airlock_west2_zone", "cata_left_middle_zone", "catacombs_west4");
  zm_zonemgr::add_adjacent_zone("airlock_west2_zone", "generator_zone", "catacombs_west4");
  zm_zonemgr::add_adjacent_zone("cata_right_start_zone", "cata_right_middle_zone", "tunnel_11_door1");
  zm_zonemgr::add_adjacent_zone("cata_right_middle_zone", "cata_right_end_zone", "tunnel_11_door2");
  zm_zonemgr::add_adjacent_zone("airlock_generator_zone", "generator_zone", "generator_exit_east");
  zm_zonemgr::add_adjacent_zone("airlock_generator_zone", "generator_exit_east_zone", "generator_exit_east");
  zm_zonemgr::add_adjacent_zone("airlock_digsite_zone", "enter_forest_east_zone", "exit_dig_east");
  zm_zonemgr::add_adjacent_zone("airlock_digsite_zone", "tower_zone_east", "exit_dig_east");
  zm_zonemgr::add_zone_flags("exit_dig_east", "digsite_group");
  zm_zonemgr::add_adjacent_zone("airlock_biodome_zone", "forest_zone", "forest_enter_digsite");
  zm_zonemgr::add_adjacent_zone("airlock_biodome_zone", "tower_zone_east2", "forest_enter_digsite");
  zm_zonemgr::add_adjacent_zone("forest_zone", "tower_zone_east2", "forest_enter_digsite");
  zm_zonemgr::add_zone_flags("forest_enter_digsite", "digsite_group");
  zm_zonemgr::add_adjacent_zone("tower_zone_east", "tower_zone_east2", "digsite_group");
  zm_zonemgr::add_adjacent_zone("airlock_labs_2_biodome", "enter_forest_east_zone", "enter_forest_east");
  zm_zonemgr::add_adjacent_zone("airlock_labs_2_biodome", "forest_zone", "enter_forest_east");
  zm_zonemgr::add_adjacent_zone("enter_forest_east_zone", "generator_exit_east_zone", "dig_enter_east");
}

function initcharacterstartindex() {
  level.characterstartindex = randomint(4);
}

function selectcharacterindextouse() {
  if(level.characterstartindex >= 4) {
    level.characterstartindex = 0;
  }
  self.characterindex = level.characterstartindex;
  level.characterstartindex++;
  return self.characterindex;
}

function givecustomcharacters() {
  if(isDefined(level.hotjoin_player_setup) && [[level.hotjoin_player_setup]]("c_zom_farmgirl_viewhands")) {
    return;
  }
  self detachall();
  if(!isDefined(self.characterindex)) {
    self.characterindex = assign_lowest_unused_character_index();
  }
  self.favorite_wall_weapons_list = [];
  self.talks_in_danger = 0;
  if(getdvarstring("") != "") {
    self.characterindex = getdvarint("");
  }
  self setcharacterbodytype(self.characterindex);
  self setcharacterbodystyle(0);
  self setcharacterhelmetstyle(0);
  switch (self.characterindex) {
    case 1: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
      break;
    }
    case 0: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
      break;
    }
    case 3: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
      break;
    }
    case 2: {
      self.talks_in_danger = 1;
      level.rich_sq_player = self;
      level.sndradioa = self;
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
      break;
    }
  }
  self setmovespeedscale(1);
  self setsprintduration(4);
  self setsprintcooldown(0);
  self thread set_exert_id();
}

function set_exert_id() {
  self endon("disconnect");
  util::wait_network_frame();
  util::wait_network_frame();
  self zm_audio::setexertvoice(self.characterindex + 1);
}

function assign_lowest_unused_character_index() {
  charindexarray = [];
  charindexarray[0] = 0;
  charindexarray[1] = 1;
  charindexarray[2] = 2;
  charindexarray[3] = 3;
  players = getplayers();
  if(players.size == 1) {
    return charindexarray[2];
  }
  if(!function_5c35365f(players)) {
    return charindexarray[2];
  }
  n_characters_defined = 0;
  foreach(player in players) {
    if(isDefined(player.characterindex)) {
      arrayremovevalue(charindexarray, player.characterindex, 0);
      n_characters_defined++;
    }
  }
  if(charindexarray.size > 0) {
    return charindexarray[0];
  }
  return 0;
}

function function_5c35365f(players) {
  foreach(player in players) {
    if(isDefined(player.characterindex) && player.characterindex == 2) {
      return true;
    }
  }
  return false;
}

function gasmask_get_head_model(entity_num, gasmask_active) {
  if(gasmask_active) {
    return "c_zom_moon_pressure_suit_helm";
  }
  switch (entity_num) {
    case 0: {
      return "c_usa_dempsey_dlc5_head";
    }
    case 1: {
      return "c_rus_nikolai_dlc5_head_psuit";
    }
    case 2: {
      return "c_jap_takeo_dlc5_head";
    }
    case 3: {
      return "c_ger_richtofen_dlc5_head";
    }
  }
}

function gasmask_change_player_headmodel(entity_num, gasmask_active) {
  if(gasmask_active) {
    self setcharacterhelmetstyle(1);
    self setcharacterbodystyle(2);
  } else {
    self setcharacterbodystyle(1);
    self setcharacterhelmetstyle(0);
  }
}

function gasmask_set_player_model(entity_num) {
  self setcharacterbodystyle(1);
}

function gasmask_set_player_viewmodel(entity_num) {
  self clientfield::increment_to_player("gas_mask_buy");
}

function gasmask_reset_player_model(entity_num) {
  self setcharacterbodystyle(0);
}

function gasmask_reset_player_set_viewmodel(entity_num) {
  gasmask_change_player_headmodel(entity_num, 0);
  self setcharacterbodystyle(0);
  level clientfield::set(("player" + self getentitynumber()) + "wearableItem", 0);
}

function on_player_spawned() {
  self notify("hash_2436f867");
  self endon("hash_2436f867");
  entnum = self getentitynumber();
  self util::waittill_any("disconnect", "bled_out", "death");
  level clientfield::set(("player" + entnum) + "wearableItem", 0);
}

function moon_offhand_weapon_overrride() {
  zm_utility::register_lethal_grenade_for_level("frag_grenade");
  level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
  zm_utility::register_tactical_grenade_for_level("black_hole_bomb");
  zm_utility::register_tactical_grenade_for_level("quantum_bomb");
  zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
  zm_utility::register_melee_weapon_for_level("bowie_knife");
  level.zombie_melee_weapon_player_init = level.weaponbasemelee;
  level.zombie_equipment_player_init = undefined;
}

function offhand_weapon_give_override(str_weapon) {
  self endon("death");
  if(zm_utility::is_tactical_grenade(str_weapon) && isDefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(str_weapon)) {
    self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
    self takeweapon(self zm_utility::get_player_tactical_grenade());
  }
  if(str_weapon == level.w_black_hole_bomb) {
    self zm_weap_black_hole_bomb::player_give_black_hole_bomb();
    self zm_weapons::play_weapon_vo(str_weapon);
    return true;
  }
  if(str_weapon == level.w_quantum_bomb) {
    self zm_weap_quantum_bomb::player_give_quantum_bomb();
    self zm_weapons::play_weapon_vo(str_weapon);
    return true;
  }
  return false;
}

function init_sounds() {
  level thread custom_add_vox();
  level thread init_level_specific_audio();
  level.vox_response_override = 1;
}

function electric_switch() {
  var_aa84840c = getent("use_elec_switch", "targetname");
  var_aa84840c sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
  var_aa84840c setcursorhint("HINT_NOICON");
  level thread wait_for_power();
  var_aa84840c waittill("trigger", user);
  user thread delayed_poweron_vox();
}

function delayed_poweron_vox() {
  self endon("death");
  self endon("disconnect");
  wait(4);
  if(isDefined(self)) {
    self thread zm_audio::create_and_play_dialog("general", "poweron");
  }
}

function wait_for_power() {
  var_cf413835 = struct::get("power_switch", "targetname");
  level flag::wait_till("power_on");
  playsoundatposition("zmb_switch_flip", var_cf413835.origin);
  level notify("electric_door");
  level scene::play("power_switch", "targetname");
  playFX(level._effect["switch_sparks"], struct::get("elec_switch_fx", "targetname").origin);
}

function moon_devgui(cmd) {
  cmd_strings = strtok(cmd, "");
  switch (cmd_strings[0]) {
    case "": {
      players = getplayers();
      for(i = 0; i < players.size; i++) {
        entnum = players[i].characterindex;
        if(isDefined(players[i].zm_random_char)) {
          entnum = players[i].zm_random_char;
        }
        if(entnum == 2) {
          players[i] zm_sidequests::add_sidequest_icon("", "");
          level._all_previous_done = 1;
        }
      }
      break;
    }
    case "": {
      players = getplayers();
      foreach(player in players) {
        if(player hasweapon(level.w_quantum_bomb)) {
          player takeweapon(level.w_quantum_bomb);
          player zm_utility::set_player_tactical_grenade("");
          player notify("starting_quantum_bomb");
        }
      }
      array::thread_all(getplayers(), &zm_weap_black_hole_bomb::player_give_black_hole_bomb);
      break;
    }
    case "": {
      players = getplayers();
      foreach(player in players) {
        if(player hasweapon(level.w_black_hole_bomb)) {
          player takeweapon(level.w_black_hole_bomb);
          player zm_utility::set_player_tactical_grenade("");
          player notify("starting_black_hole_bomb");
        }
      }
      array::thread_all(getplayers(), &zm_weap_quantum_bomb::player_give_quantum_bomb);
      break;
    }
    case "": {
      trigger = getent("", "");
      if(!isDefined(trigger)) {
        return;
      }
      iprintln("");
      trigger notify("trigger", getplayers()[0]);
      break;
    }
    case "": {
      players = getplayers();
      teleporter = getent("", "");
      for(i = 0; i < players.size; i++) {
        players[i] setorigin(teleporter.origin);
      }
      break;
    }
    case "": {
      zm_moon_digger::digger_activate("");
      break;
    }
    case "": {
      zm_moon_digger::digger_activate("");
      break;
    }
    case "": {
      zm_moon_digger::digger_activate("");
      break;
    }
    case "": {
      level.digger_speed_multiplier = getdvarfloat("");
      iprintlnbold(level.digger_speed_multiplier);
      break;
    }
    case "": {
      player = getplayers()[0];
      spawnername = undefined;
      spawnername = "";
      direction = player getplayerangles();
      direction_vec = anglesToForward(direction);
      eye = player getEye();
      scale = 8000;
      direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
      trace = bulletTrace(eye, eye + direction_vec, 0, undefined);
      guy = undefined;
      spawners = getEntArray(spawnername, "");
      spawner = spawners[0];
      if(isDefined(level.astro_zombie_spawners)) {
        spawner = level.astro_zombie_spawners[0];
      }
      guy = zombie_utility::spawn_zombie(spawner);
      if(isDefined(guy)) {
        guy.script_string = "";
        wait(0.5);
        guy forceteleport(trace[""], player.angles + vectorscale((0, 1, 0), 180));
      }
      break;
    }
  }
}

function custom_add_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_moon_weapons.csv", 1);
}

function custom_add_vox() {
  zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_moon_vox.csv");
}

function moon_zombie_death_response() {
  self startragdoll();
  rag_x = randomintrange(-50, 50);
  rag_y = randomintrange(-50, 50);
  rag_z = randomintrange(25, 45);
  force_min = 75;
  force_max = 100;
  if(self.damagemod == "MOD_MELEE") {
    force_min = 40;
    force_max = 50;
    rag_z = 15;
  } else {
    if(self.damageweapon == "m1911_zm") {
      force_min = 60;
      force_max = 75;
      rag_z = 20;
    } else if(self.damageweapon == "870mcs_zm" || self.damageweapon == "870mcs_upgraded_zm" || self.damageweapon == "ithaca_zm" || self.damageweapon == "ithaca_upgraded_zm" || self.damageweapon == "rottweil72_zm" || self.damageweapon == "rottweil72_upgraded_zm" || self.damageweapon == "srm1216_zm" || self.damageweapon == "srm1216_upgraded_zm" || self.damageweapon == "spas_zm" || self.damageweapon == "spas_upgraded_zm" || self.damageweapon == "hs10_zm" || self.damageweapon == "hs10_upgraded_zm" || self.damageweapon == "saiga12_zm" || self.damageweapon == "saiga12_upgraded_zm") {
      force_min = 100;
      force_max = 150;
    }
  }
  scale = randomintrange(force_min, force_max);
  rag_x = self.damagedir[0] * scale;
  rag_y = self.damagedir[1] * scale;
  dir = (rag_x, rag_y, rag_z);
  self launchragdoll(dir);
  return false;
}

function setup_water_physics() {
  level flag::wait_till("start_zombie_round_logic");
  setdvar("phys_buoyancy", 1);
}

function cliff_fall_death() {
  trig = getent("cliff_fall_death", "targetname");
  if(isDefined(trig)) {
    while(true) {
      trig waittill("trigger", who);
      if(!(isDefined(who.insta_killed) && who.insta_killed)) {
        who thread insta_kill_player();
      }
    }
  }
}

function insta_kill_player() {
  self endon("disconnect");
  if(isDefined(self.insta_killed) && self.insta_killed) {
    return;
  }
  if(is_player_killable(self)) {
    self.insta_killed = 1;
    in_last_stand = 0;
    if(self laststand::player_is_in_laststand()) {
      in_last_stand = 1;
    }
    if(level flag::get("solo_game")) {
      if(isDefined(self.lives) && self.lives > 0) {
        self.waiting_to_revive = 1;
        if(level flag::get("both_tunnels_breached")) {
          point = moon_digger_respawn(self);
          if(!isDefined(point)) {
            points = struct::get("bridge_zone", "script_noteworthy");
            spawn_points = struct::get_array(points.target, "targetname");
            num = self.characterindex;
            point = spawn_points[num];
          }
        } else {
          points = struct::get("bridge_zone", "script_noteworthy");
          spawn_points = struct::get_array(points.target, "targetname");
          num = self.characterindex;
          point = spawn_points[num];
        }
        self dodamage(self.health + 1000, (0, 0, 0));
        wait(1.5);
        self setorigin(point.origin + vectorscale((0, 0, 1), 20));
        self setplayerangles(point.angles);
        if(in_last_stand) {
          level flag::set("instant_revive");
          util::wait_network_frame();
          level flag::clear("instant_revive");
        } else {
          self thread zm_laststand::auto_revive(self);
          self.waiting_to_revive = 0;
          level.wait_and_revive = 0;
          self.solo_respawn = 0;
          self.lives = 0;
        }
      } else {
        self dodamage(self.health + 1000, (0, 0, 0));
      }
    } else {
      self dodamage(self.health + 1000, (0, 0, 0));
      util::wait_network_frame();
      self.bleedout_time = 0;
    }
    self.insta_killed = 0;
  }
}

function moon_respawn_override(player) {
  if(level flag::get("both_tunnels_breached")) {
    point = moon_digger_respawn(player);
    if(isDefined(point)) {
      self notify("one_giant_leap");
      return point;
    }
  } else {
    return undefined;
  }
  return undefined;
}

function is_player_killable(player, checkignoremeflag) {
  if(!isDefined(player)) {
    return false;
  }
  if(!isalive(player)) {
    return false;
  }
  if(!isplayer(player)) {
    return false;
  }
  if(player.sessionstate == "spectator") {
    return false;
  }
  if(player.sessionstate == "intermission") {
    return false;
  }
  if(player isnotarget()) {
    return false;
  }
  if(isDefined(checkignoremeflag) && player.ignoreme) {
    return false;
  }
  return true;
}

function moon_digger_respawn(revivee) {
  spawn_points = struct::get_array("player_respawn_point", "targetname");
  if(level.zones["airlock_west2_zone"].is_enabled) {
    for(i = 0; i < spawn_points.size; i++) {
      if(spawn_points[i].script_noteworthy == "airlock_west2_zone") {
        spawn_array = struct::get_array(spawn_points[i].target, "targetname");
        for(j = 0; j < spawn_array.size; j++) {
          if(spawn_array[j].script_int == (revivee.entity_num + 1)) {
            return spawn_array[j];
          }
        }
        return spawn_array[0];
      }
    }
  } else if(level.zones["airlock_east2_zone"].is_enabled) {
    for(i = 0; i < spawn_points.size; i++) {
      if(spawn_points[i].script_noteworthy == "airlock_east2_zone") {
        spawn_array = struct::get_array(spawn_points[i].target, "targetname");
        for(j = 0; j < spawn_array.size; j++) {
          if(spawn_array[j].script_int == (revivee.entity_num + 1)) {
            return spawn_array[j];
          }
        }
        return spawn_array[0];
      }
    }
  }
  return undefined;
}

function moon_reset_respawn_overide() {
  level waittill("between_round_over");
  level.check_valid_spawn_override = undefined;
}

function blackhole_bomb_area_check() {
  black_hole_teleport_structs = undefined;
  org = spawn("script_origin", (0, 0, 0));
  if(level flag::get("enter_nml")) {
    black_hole_teleport_structs = struct::get_array("struct_black_hole_teleport_nml", "targetname");
  } else {
    if(level flag::get("both_tunnels_blocked")) {
      black_hole_teleport_structs = struct::get_array("struct_black_hole_teleport", "targetname");
      all_players_trapped = 0;
      final_structs = black_hole_teleport_structs;
      discarded_zones = [];
      all_players = getplayers();
      all_zones = getEntArray("player_volume", "script_noteworthy");
      players_touching = 0;
      for(x = 0; x < all_zones.size; x++) {
        switch (all_zones[x].targetname) {
          case "airlock_bridge_zone":
          case "airlock_east_zone":
          case "airlock_west_zone":
          case "bridge_zone":
          case "cata_left_middle_zone":
          case "cata_left_start_zone":
          case "cata_right_start_zone":
          case "water_zone": {
            discarded_zones[discarded_zones.size] = all_zones[x];
            for(i = 0; i < all_players.size; i++) {
              player = all_players[i];
              equipment = player zm_equipment::get_player_equipment();
              if(isDefined(equipment) && equipment == "equip_hacker_zm") {
                org delete();
                return black_hole_teleport_structs;
                continue;
              }
              if(player istouching(all_zones[x])) {
                players_touching++;
              }
            }
            break;
          }
          default: {
            break;
          }
        }
      }
      if(players_touching == all_players.size) {
        all_players_trapped = 1;
      }
      if(all_players_trapped) {
        for(i = 0; i < black_hole_teleport_structs.size; i++) {
          for(x = 0; x < discarded_zones.size; x++) {
            org.origin = black_hole_teleport_structs[i].origin;
            if(org istouching(discarded_zones[x])) {
              arrayremovevalue(final_structs, black_hole_teleport_structs[i]);
            }
          }
        }
        black_hole_teleport_structs = final_structs;
      } else {
        black_hole_teleport_structs = struct::get_array("struct_black_hole_teleport", "targetname");
      }
    } else {
      black_hole_teleport_structs = struct::get_array("struct_black_hole_teleport", "targetname");
    }
  }
  org delete();
  return black_hole_teleport_structs;
}

function get_blackholebomb_destination_point(black_hole_teleport_structs, ent_player) {
  player_zones = getEntArray("player_volume", "script_noteworthy");
  valid_struct = undefined;
  scr_org = undefined;
  for(x = 0; x < black_hole_teleport_structs.size; x++) {
    if(!isDefined(scr_org)) {
      scr_org = spawn("script_origin", black_hole_teleport_structs[x].origin + vectorscale((0, 0, 1), 40));
    } else {
      scr_org.origin = black_hole_teleport_structs[x].origin + vectorscale((0, 0, 1), 40);
    }
    for(i = 0; i < player_zones.size; i++) {
      if(scr_org istouching(player_zones[i])) {
        if(isDefined(level.zones[player_zones[i].targetname]) && (isDefined(level.zones[player_zones[i].targetname].is_enabled) && level.zones[player_zones[i].targetname].is_enabled)) {
          if(level flag::get("enter_nml")) {
            valid_struct = black_hole_teleport_structs[x];
            scr_org delete();
            return valid_struct;
          }
          if(ent_player zm_utility::get_current_zone() != player_zones[i].targetname) {
            valid_struct = black_hole_teleport_structs[x];
            scr_org delete();
            return valid_struct;
          }
        }
      }
    }
  }
}

function blackhole_bomb_in_invalid_area(grenade, model, player) {
  invalid_area = getent("bhb_invalid_area", "targetname");
  if(model istouching(invalid_area)) {
    level thread zm_weap_black_hole_bomb::black_hole_bomb_stolen_by_sam(player, model);
    return true;
  }
  return false;
}

function quantum_bomb_prevent_player_getting_teleported_override(position) {
  if(isDefined(self._padded) && self._padded) {
    return true;
  }
  return false;
}

function moon_perk_lost(perk) {
  self zm_perks::update_perk_hud();
}

function moon_black_hole_bomb_poi() {
  astro = getent("astronaut_zombie_ai", "targetname");
  if(isDefined(astro)) {
    astro zm_utility::add_poi_to_ignore_list(self);
  }
}

function moon_bhb_poi_control() {
  self endon("death");
  moon_pois = getEntArray("zombie_poi", "script_noteworthy");
  pack_enclosure = getent("pack_enclosure", "targetname");
  if(!isDefined(moon_pois) || moon_pois.size == 0) {
    return undefined;
  }
  for(i = 0; i < moon_pois.size; i++) {
    if(isDefined(moon_pois[i].targetname) && moon_pois[i].targetname == "zm_bhb") {
      if(!level flag::get("packapunch_hacked")) {
        return undefined;
      }
      self._bhb_pull = 1;
      bhb_position = self moon_bhb_choice(moon_pois[i]);
      return bhb_position;
    }
  }
  self._bhb_pull = 0;
  return undefined;
}

function moon_bhb_choice(ent_poi) {
  bhb_position = [];
  bhb_position[0] = zm_utility::groundpos(ent_poi.origin + vectorscale((0, 0, 1), 100));
  bhb_position[1] = self;
  if(isDefined(ent_poi.initial_attract_func)) {
    self thread[[ent_poi.initial_attract_func]](ent_poi);
  }
  if(isDefined(ent_poi.arrival_attract_func)) {
    self thread[[ent_poi.arrival_attract_func]](ent_poi);
  }
  return bhb_position;
}

function override_quad_explosion(quad) {
  if(isDefined(quad.in_low_gravity) && quad.in_low_gravity == 1) {
    quad.can_explode = 0;
  }
}

function moon_speed_up() {
  self zombie_utility::set_zombie_run_cycle("sprint");
}

function init_level_specific_audio() {
  level.vox zm_audio::zmbvoxadd("general", "start", "start", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "door_deny", "nomoney", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "perk_deny", "nomoney", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "no_money_weapon", "nomoney", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "astro_spawn", "spawn_astro", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "biodome", "location_biodome", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "jumppad", "jumppad", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "teleporter", "teleporter", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "hack_plr", "hack_plr", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "hack_vox", "hack_vox", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "airless", "location_airless", 100, 0);
  level.vox zm_audio::zmbvoxadd("general", "moonjump", "moonjump", 100, 0);
  level.vox zm_audio::zmbvoxadd("eggs", "meteors", "egg_pedastool", 100, 0);
  level.vox zm_audio::zmbvoxadd("eggs", "music_activate", "secret", 100, 0);
  level.vox zm_audio::zmbvoxadd("weapon_pickup", "microwave", "wpck_microwave", 100, 0);
  level.vox zm_audio::zmbvoxadd("weapon_pickup", "quantum", "wpck_quantum", 100, 0);
  level.vox zm_audio::zmbvoxadd("weapon_pickup", "gasmask", "wpck_gasmask", 100, 0);
  level.vox zm_audio::zmbvoxadd("weapon_pickup", "hacker", "wpck_hacker", 100, 0);
  level.vox zm_audio::zmbvoxadd("weapon_pickup", "grenade", "wpck_launcher", 100, 0);
  level.vox zm_audio::zmbvoxadd("kill", "micro_dual", "kill_micro_dual", 100, 0, 120);
  level.vox zm_audio::zmbvoxadd("kill", "micro_single", "kill_micro_single", 100, 0);
  level.vox zm_audio::zmbvoxadd("kill", "quant_good", "kill_quant_good", 10, 0);
  level.vox zm_audio::zmbvoxadd("kill", "quant_bad", "kill_quant_bad", 10, 0);
  level.vox zm_audio::zmbvoxadd("kill", "astro", "kill_astro", 100, 0);
  level.vox zm_audio::zmbvoxadd("digger", "incoming", "digger_incoming", 100, 0);
  level.vox zm_audio::zmbvoxadd("digger", "breach", "digger_breach", 100, 0);
  level.vox zm_audio::zmbvoxadd("digger", "hacked", "digger_hacked", 100, 0);
  level.vox zm_audio::zmbvoxadd("perk", "specialty_additionalprimaryweapon", "perk_arsenal", 100, 0);
  level.vox zm_audio::zmbvoxadd("player", "powerup", "bonus_points_solo", "powerup_pts_solo", 100, 0);
  level.vox zm_audio::zmbvoxadd("player", "powerup", "bonus_points_team", "powerup_pts_team", 100, 0);
  level.vox zm_audio::zmbvoxadd("player", "powerup", "lose_points", "powerup_antipts_zmb", 100, 0);
}

function function_9f47ebff() {
  if(self.perk.script_noteworthy == "specialty_rof") {
    self.no_bullet_trace = 1;
  }
  return self;
}

function func_magicbox_update_prompt_use_override() {
  if(level flag::get("override_magicbox_trigger_use")) {
    return true;
  }
  return false;
}

function setupmusic() {
  zm_audio::musicstate_create("round_start", 3, "round_start_moon_1", "round_start_moon_2", "round_start_moon_3", "round_start_moon_4");
  zm_audio::musicstate_create("round_start_short", 3, "round_start_moon_1", "round_start_moon_2", "round_start_moon_3", "round_start_moon_4");
  zm_audio::musicstate_create("round_start_first", 3, "round_start_moon_first");
  zm_audio::musicstate_create("round_end", 3, "round_end_moon_1", "round_end_moon_2", "round_end_moon_3");
  zm_audio::musicstate_create("game_over", 5, "game_over_zhd_moon");
  zm_audio::musicstate_create("nightmare", 4, "nightmare");
  zm_audio::musicstate_create("cominghome", 4, "cominghome");
  zm_audio::musicstate_create("8bit_cominghome", 4, "8bit_cominghome");
  zm_audio::musicstate_create("8bit_pareidolia", 4, "8bit_pareidolia");
  zm_audio::musicstate_create("8bit_redamned", 4, "8bit_redamned");
  zm_audio::musicstate_create("none", 4, "none");
  zm_audio::musicstate_create("sam", 4, "sam");
  zm_audio::musicstate_create("end_is_near", 4, "end_is_near");
  zm_audio::musicstate_create("samantha_reveal", 4, "samantha_reveal");
}

function function_35a61719() {
  var_93997cd = getEntArray("airlock_biodome_zone", "script_parameters");
  var_66cca975 = getEntArray("airlock_labs_2_biodome", "script_parameters");
  var_93997cd = arraycombine(var_93997cd, var_66cca975, 0, 0);
  foreach(var_1cec30db in var_93997cd) {
    switch (var_1cec30db.script_int) {
      case 1: {
        var_1cec30db thread function_cc87f235(self);
        break;
      }
      case 0: {
        var_1cec30db thread function_ff7d5f3b(self);
        break;
      }
    }
  }
}

function function_cc87f235(player) {
  self endon("death");
  while(true) {
    self waittill("trigger", e_who);
    if(e_who == player) {
      player clientfield::set_to_player("biodome_exploder", 1);
    }
    wait(0.2);
  }
}

function function_ff7d5f3b(player) {
  self endon("death");
  while(true) {
    self waittill("trigger", e_who);
    if(e_who == player) {
      player clientfield::set_to_player("biodome_exploder", 0);
    }
    wait(0.2);
  }
}

function function_54bf648f() {
  level.use_multiple_spawns = 1;
  level.spawner_int = 1;
  level.fn_custom_zombie_spawner_selection = &function_54da140a;
}

function function_54da140a() {
  var_6af221a2 = [];
  a_s_spots = level.zm_loc_types["zombie_location"];
  if(isDefined(level.zm_loc_types["quad_location"])) {
    a_s_spots = arraycombine(a_s_spots, level.zm_loc_types["quad_location"], 0, 0);
  }
  a_s_spots = array::randomize(a_s_spots);
  for(i = 0; i < a_s_spots.size; i++) {
    if(!isDefined(a_s_spots[i].script_int)) {
      var_343b1937 = 1;
    } else {
      var_343b1937 = a_s_spots[i].script_int;
    }
    var_c15b2128 = [];
    foreach(sp_zombie in level.zombie_spawners) {
      if(sp_zombie.script_int == var_343b1937) {
        if(!isDefined(var_c15b2128)) {
          var_c15b2128 = [];
        } else if(!isarray(var_c15b2128)) {
          var_c15b2128 = array(var_c15b2128);
        }
        var_c15b2128[var_c15b2128.size] = sp_zombie;
      }
    }
    if(var_c15b2128.size) {
      sp_zombie = array::random(var_c15b2128);
      return sp_zombie;
    }
  }
  assert(isDefined(sp_zombie), "" + var_343b1937);
}

function spare_change() {
  a_t_audio = getEntArray("audio_bump_trigger", "targetname");
  foreach(t_audio_bump in a_t_audio) {
    if(t_audio_bump.script_sound === "zmb_perks_bump_bottle" && t_audio_bump.script_string != "speedcola_perk") {
      t_audio_bump thread zm_perks::check_for_change();
    }
  }
}