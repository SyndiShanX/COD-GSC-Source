/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_zone_manager;

main() {
  level thread maps\zombie_cosmodrome_ffotd::main_start();
  PreCacheModel("viewmodel_usa_pow_arms");
  PreCacheModel("viewmodel_rus_prisoner_arms");
  PreCacheModel("viewmodel_vtn_nva_standard_arms");
  PreCacheModel("viewmodel_usa_hazmat_arms");
  PreCacheModel("p_rus_rb_lab_warning_light_01");
  PreCacheModel("p_rus_rb_lab_warning_light_01_off");
  PreCacheModel("p_rus_rb_lab_light_core_on");
  PreCacheModel("p_rus_rb_lab_light_core_off");
  maps\zombie_cosmodrome_fx::main();
  maps\zombie_cosmodrome_amb::main();
  PreCacheModel("zombie_lander_crashed");
  cosmodrome_precache();
  PreCacheModel("p_zom_cosmo_lunar_control_panel_dlc_on");
  if(GetDvarInt(#"artist") > 0) {
    return;
  }
  precachemodel("tag_origin");
  level.player_out_of_playable_area_monitor = true;
  level.player_out_of_playable_area_monitor_callback = ::zombie_cosmodrome_player_out_of_playable_area_monitor_callback;
  maps\zombie_cosmodrome_ai_monkey::init();
  maps\zombie_cosmodrome_traps::init_funcs();
  level.pay_turret_cost = 1000;
  level.lander_cost = 250;
  level.random_pandora_box_start = false;
  level thread maps\_callbacksetup::SetupCallbacks();
  level.quad_move_speed = 35;
  level.dog_spawn_func = maps\_zombiemode_ai_dogs::dog_spawn_factory_logic;
  level.custom_ai_type = [];
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_monkey::init);
  level.door_dialog_function = maps\_zombiemode::play_door_dialog;
  include_weapons();
  include_powerups();
  level.use_zombie_heroes = true;
  level.zombiemode_using_marathon_perk = true;
  level.zombiemode_using_divetonuke_perk = true;
  level.round_prestart_func = maps\zombie_cosmodrome_lander::new_lander_intro;
  level.zombiemode_precache_player_model_override = ::precache_player_model_override;
  level.zombiemode_give_player_model_override = ::give_player_model_override;
  level.zombiemode_player_set_viewmodel_override = ::player_set_viewmodel_override;
  level.register_offhand_weapons_for_level_defaults_override = ::cosmodrome_offhand_weapon_overrride;
  level.zombiemode_offhand_weapon_give_override = ::offhand_weapon_give_override;
  level.monkey_prespawn = maps\zombie_cosmodrome_ai_monkey::monkey_cosmodrome_prespawn;
  level.monkey_zombie_failsafe = maps\zombie_cosmodrome_ai_monkey::monkey_cosmodrome_failsafe;
  level.max_perks = 5;
  level.max_solo_lives = 3;
  level thread cosmodrome_fade_in_notify();
  maps\_zombiemode::main();
  maps\_zombiemode_weap_sickle::init();
  maps\_zombiemode_weap_black_hole_bomb::init();
  maps\_zombiemode_weap_nesting_dolls::init();
  battlechatter_off("allies");
  battlechatter_off("axis");
  level._SCRIPTMOVER_COSMODROME_CLIENT_FLAG_MONKEY_LANDER_FX = 12;
  level maps\zombie_cosmodrome_magic_box::magic_box_init();
  level.zone_manager_init_func = ::cosmodrome_zone_init;
  init_zones[0] = "centrifuge_zone";
  init_zones[1] = "centrifuge_zone2";
  level thread maps\_zombiemode_zone_manager::manage_zones(init_zones);
  level thread electric_switch();
  level thread maps\_zombiemode_auto_turret::init();
  level thread maps\zombie_cosmodrome_lander::init();
  level thread maps\zombie_cosmodrome_traps::init_traps();
  level thread setup_water_physics();
  level thread centrifuge_jumpup_fix();
  level thread centrifuge_jumpdown_fix();
  level thread centrifuge_init();
  level thread maps\zombie_cosmodrome_pack_a_punch::pack_a_punch_main();
  level thread maps\zombie_cosmodrome_achievement::init();
  level thread maps\zombie_cosmodrome_eggs::init();
  level.zombie_visionset = "zombie_cosmodrome_nopower";
  level thread fx_for_power_path();
  level thread spawn_life_brushes();
  level thread spawn_kill_brushes();
  init_sounds();
  level thread maps\zombie_cosmodrome_ffotd::main_end();
}
spawn_life_brushes() {
  maps\_zombiemode::spawn_life_brush((-1415, 1540, 0), 180, 100);
}
spawn_kill_brushes() {
  maps\_zombiemode::spawn_kill_brush((-1800, 2116, -60), 15, 100);
  maps\_zombiemode::spawn_kill_brush((-1872, 2156, -20), 15, 100);
  maps\_zombiemode::spawn_kill_brush((-672, -152, -552), 110, 55);
  maps\_zombiemode::spawn_kill_brush((-2272, 1768, -136), 110, 55);
  maps\_zombiemode::spawn_kill_brush((160, -2320, -136), 110, 55);
  maps\_zombiemode::spawn_kill_brush((1760, 1256, 280), 110, 55);
  maps\_zombiemode::spawn_kill_brush((-672, -152, 0), 200, 1000);
  maps\_zombiemode::spawn_kill_brush((-2272, 1768, 130), 200, 1000);
  maps\_zombiemode::spawn_kill_brush((160, -2320, 50), 400, 1000);
  maps\_zombiemode::spawn_kill_brush((1760, 1256, 490), 400, 1000);
}
zombie_cosmodrome_player_out_of_playable_area_monitor_callback() {
  if(is_true(self.lander) || is_true(self.on_lander_last_stand)) {
    return false;
  }
  return true;
}
setup_water_physics() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvars("phys_buoyancy", 1);
  }
}
fx_for_power_path() {
  self endon("power_on");
  while(1) {
    playFX(level._effect["dangling_wire"], (-1066, 1024, -72), (0, 0, 1));
    wait(0.3 + RandomFloat(0.5));
    playFX(level._effect["dangling_wire"], (-900, 1446, -96), (0, 0, 1));
    wait(0.3 + RandomFloat(0.5));
    playFX(level._effect["dangling_wire"], (-895, 1442, -52), (0, 0, 1));
    wait(0.3 + RandomFloat(0.5));
  }
}
centrifuge_jumpup_fix() {
  jumpblocker = GetEnt("centrifuge_jumpup", "targetname");
  if(!isDefined(jumpblocker))
    return;
  jump_pos = jumpblocker.origin;
  centrifuge_occupied = false;
  while(true) {
    if(level.zones["centrifuge_zone"].is_occupied && centrifuge_occupied == false) {
      jumpblocker MoveX(jump_pos[0] + 64, 0.1);
      jumpblocker DisconnectPaths();
      centrifuge_occupied = true;
    } else if(!level.zones["centrifuge_zone"].is_occupied && centrifuge_occupied == true) {
      jumpblocker MoveTo(jump_pos, 0.1);
      jumpblocker ConnectPaths();
      centrifuge_occupied = false;
    }
    wait(1);
  }
}
centrifuge_jumpdown_fix() {
  jumpblocker = GetEnt("centrifuge_jumpdown", "targetname");
  if(!isDefined(jumpblocker))
    return;
  jump_pos = jumpblocker.origin;
  centrifuge2_occupied = true;
  while(true) {
    if(level.zones["centrifuge_zone2"].is_occupied && centrifuge2_occupied == false) {
      jumpblocker MoveX(jump_pos[0] + 64, 0.1);
      jumpblocker DisconnectPaths();
      centrifuge2_occupied = true;
    } else if(!level.zones["centrifuge_zone2"].is_occupied && centrifuge2_occupied == true) {
      jumpblocker MoveTo(jump_pos, 0.1);
      jumpblocker ConnectPaths();
      centrifuge2_occupied = false;
    }
    wait(1);
  }
}
include_weapons() {
  include_weapon("frag_grenade_zm", false, true);
  include_weapon("claymore_zm", false, true);
  include_weapon("m1911_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_zm");
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_zm");
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("m14_zm", false, true);
  include_weapon("m14_upgraded_zm", false);
  include_weapon("m16_zm", false, true);
  include_weapon("m16_gl_upgraded_zm", false);
  include_weapon("g11_lps_zm");
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_zm");
  include_weapon("famas_upgraded_zm", false);
  include_weapon("ak74u_zm", false, true);
  include_weapon("ak74u_upgraded_zm", false);
  include_weapon("mp5k_zm", false, true);
  include_weapon("mp5k_upgraded_zm", false);
  include_weapon("mpl_zm", false, true);
  include_weapon("mpl_upgraded_zm", false);
  include_weapon("pm63_zm", false, true);
  include_weapon("pm63_upgraded_zm", false);
  include_weapon("spectre_zm");
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("cz75dw_zm");
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("ithaca_zm", false, true);
  include_weapon("ithaca_upgraded_zm", false);
  include_weapon("rottweil72_zm", false, true);
  include_weapon("rottweil72_upgraded_zm", false);
  include_weapon("spas_zm");
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_zm");
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_zm");
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
  include_weapon("zombie_black_hole_bomb", true, false);
  include_weapon("zombie_nesting_dolls", true, false);
  include_weapon("ray_gun_zm");
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("thundergun_zm");
  include_weapon("thundergun_upgraded_zm", false);
  include_weapon("crossbow_explosive_zm");
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("knife_ballistic_zm", true);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_sickle_zm", false);
  include_weapon("knife_ballistic_sickle_upgraded_zm", false);
  level._uses_retrievable_ballisitic_knives = true;
  maps\_zombiemode_weapons::add_limited_weapon("m1911_zm", 0);
  maps\_zombiemode_weapons::add_limited_weapon("thundergun_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("crossbow_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("knife_ballistic_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("zombie_nesting_dolls", 1);
  precacheItem("explosive_bolt_zm");
  precacheItem("explosive_bolt_upgraded_zm");
  level.collector_achievement_weapons = array_add(level.collector_achievement_weapons, "sickle_knife_zm");
}
include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
  include_powerup("fire_sale");
  PreCacheItem("minigun_zm");
  include_powerup("minigun");
  include_powerup("free_perk");
}
magic_box_override() {
  flag_wait("all_players_connected");
  players = get_players();
  level.chest_min_move_usage = players.size;
  chest = level.chests[level.chest_index];
  while(level.chest_accessed < level.chest_min_move_usage) {
    chest waittill("chest_accessed");
  }
  chest disable_trigger();
  chest.chest_lid maps\_zombiemode_weapons::treasure_chest_lid_open();
  chest thread maps\_zombiemode_weapons::treasure_chest_move();
  wait 0.5;
  level notify("weapon_fly_away_start");
  wait 2;
  chest notify("box_moving");
  level notify("weapon_fly_away_end");
  level.chest_min_move_usage = undefined;
}
cosmodrome_zone_init() {
  flag_init("centrifuge");
  flag_set("centrifuge");
  add_adjacent_zone("access_tunnel_zone", "base_entry_zone", "base_entry_group");
  add_adjacent_zone("storage_zone", "storage_zone2", "storage_group");
  add_adjacent_zone("power_building", "base_entry_zone2", "power_group");
  add_adjacent_zone("north_path_zone", "roof_connector_zone", "roof_connector_dropoff");
  add_adjacent_zone("north_path_zone", "under_rocket_zone", "rocket_group");
  add_adjacent_zone("control_room_zone", "under_rocket_zone", "rocket_group");
  add_adjacent_zone("centrifuge_zone", "centrifuge_zone2", "centrifuge");
  add_adjacent_zone("centrifuge_zone", "centrifuge2power_zone", "centrifuge2power");
  add_adjacent_zone("base_entry_zone2", "centrifuge2power_zone", "power2centrifuge");
  add_zone_flags("power2centrifuge", "power_group");
  add_adjacent_zone("access_tunnel_zone", "centrifuge_zone", "tunnel_centrifuge_entry");
  add_zone_flags("tunnel_centrifuge_entry", "base_entry_group");
  add_adjacent_zone("base_entry_zone", "base_entry_zone2", "base_entry_2_power");
  add_zone_flags("base_entry_2_power", "base_entry_group");
  add_zone_flags("base_entry_2_power", "power_group");
  add_adjacent_zone("power_building", "power_building_roof", "power_interior_2_roof");
  add_zone_flags("power_interior_2_roof", "power_group");
  add_adjacent_zone("north_catwalk_zone3", "roof_connector_zone", "catwalks_2_shed");
  add_zone_flags("catwalks_2_shed", "roof_connector_dropoff");
  add_adjacent_zone("access_tunnel_zone", "storage_zone", "base_entry_2_storage");
  add_adjacent_zone("access_tunnel_zone", "storage_zone2", "base_entry_2_storage");
  add_zone_flags("base_entry_2_storage", "storage_group");
  add_zone_flags("base_entry_2_storage", "base_entry_group");
  add_adjacent_zone("storage_lander_zone", "storage_zone", "storage_lander_area");
  add_adjacent_zone("storage_lander_zone", "storage_zone2", "storage_lander_area");
  add_adjacent_zone("north_path_zone", "base_entry_zone2", "base_entry_2_north_path");
  add_zone_flags("base_entry_2_north_path", "power_group");
  add_zone_flags("base_entry_2_north_path", "roof_connector_dropoff");
  add_adjacent_zone("power_building_roof", "roof_connector_zone", "power_catwalk_access");
  add_zone_flags("power_catwalk_access", "roof_connector_dropoff");
}
powercell_dropoff() {
  level.packBattery++;
  battery = GetEnt("pack_battery_0" + level.packBattery, "targetname");
  battery show();
  battery.fx = spawn("script_model", battery.origin);
  battery.fx.angles = battery.angles;
  battery.fx setModel("tag_origin");
  playFXOnTag(level._effect["powercell"], battery.fx, "tag_origin");
}
electric_switch() {
  trig = getent("use_elec_switch", "targetname");
  trig sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
  trig setcursorhint("HINT_NOICON");
  level thread wait_for_power();
  trig waittill("trigger", user);
  trig delete();
  flag_set("power_on");
  Objective_State(8, "done");
  playsoundatposition("zmb_poweron_front", (0, 0, 0));
}
wait_for_power() {
  master_switch = getent("elec_switch", "targetname");
  master_switch notsolid();
  flag_wait("power_on");
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_power_switch");
  master_switch rotateroll(-90, .3);
  master_switch playSound("zmb_switch_flip");
  flag_set("lander_power");
  level notify("revive_on");
  level notify("juggernog_on");
  level notify("sleight_on");
  level notify("divetonuke_on");
  level notify("marathon_on");
  level notify("Pack_A_Punch_on");
  clientnotify("ZPO");
  exploder(5401);
  master_switch waittill("rotatedone");
  playFX(level._effect["switch_sparks"], getstruct("elec_switch_fx", "targetname").origin);
  master_switch playSound("zmb_turn_on");
  thread maps\zombie_cosmodrome_amb::power_clangs();
}
custom_pandora_show_func(anchor, anchorTarget, pieces) {
  level.pandora_light.angles = (-90, anchorTarget.angles[1] + 180, 0);
  level.pandora_light moveto(anchorTarget.origin, 0.05);
  wait(1);
  playFX(level._effect["lght_marker_flare"], level.pandora_light.origin);
}
custom_pandora_fx_func() {
  start_chest = GetEnt("start_chest", "script_noteworthy");
  anchor = GetEnt(start_chest.target, "targetname");
  anchorTarget = GetEnt(anchor.target, "targetname");
  level.pandora_light = spawn("script_model", anchorTarget.origin);
  level.pandora_light.angles = anchorTarget.angles + (-90, 0, 0);
  level.pandora_light setModel("tag_origin");
  playFXOnTag(level._effect["lght_marker"], level.pandora_light, "tag_origin");
}
centrifuge_init() {
  centrifuge = GetEnt("centrifuge", "targetname");
  if(isDefined(centrifuge)) {
    centrifuge centrifuge_rotate();
  }
}
link_centrifuge_pieces() {
  pieces = getEntArray(self.target, "targetname");
  if(isDefined(pieces)) {
    for(i = 0; i < pieces.size; i++) {
      pieces[i] linkto(self);
    }
  }
  self thread centrifuge_rotate();
}
centrifuge_rotate() {
  while(true) {
    self rotateyaw(360, 20);
    self waittill("rotatedone");
  }
}
cosmodrome_precache() {
  PreCacheModel("zombie_zapper_cagelight_red");
  precachemodel("zombie_zapper_cagelight_green");
  PreCacheModel("p_zom_monitor_csm");
  PreCacheModel("p_zom_monitor_csm_screen_catwalk");
  PreCacheModel("p_zom_monitor_csm_screen_centrifuge");
  PreCacheModel("p_zom_monitor_csm_screen_enter");
  PreCacheModel("p_zom_monitor_csm_screen_fsale1");
  PreCacheModel("p_zom_monitor_csm_screen_fsale2");
  PreCacheModel("p_zom_monitor_csm_screen_labs");
  PreCacheModel("p_zom_monitor_csm_screen_logo");
  PreCacheModel("p_zom_monitor_csm_screen_obsdeck");
  PreCacheModel("p_zom_monitor_csm_screen_off");
  PreCacheModel("p_zom_monitor_csm_screen_on");
  PreCacheModel("p_zom_monitor_csm_screen_warehouse");
  PreCacheModel("p_zom_monitor_csm_screen_storage");
  PreCacheModel("p_zom_monitor_csm_screen_topack");
  PreCacheModel("p_zom_key_console_01");
  PreCacheModel("p_zom_rocket_sign_02");
  PreCacheModel("p_zom_rocket_sign_03");
  PreCacheModel("p_zom_rocket_sign_04");
  PreCacheRumble("damage_heavy");
}
precache_player_model_override() {
  mptype\player_t5_zm_cosmodrome::precache();
}
give_player_model_override(entity_num) {
  if(isDefined(self.zm_random_char)) {
    entity_num = self.zm_random_char;
  }
  switch (entity_num) {
    case 0:
      character\c_usa_dempsey_dlc2::main();
      break;
    case 1:
      character\c_rus_nikolai_dlc2::main();
      break;
    case 2:
      character\c_jap_takeo_dlc2::main();
      break;
    case 3:
      character\c_ger_richtofen_dlc2::main();
      break;
  }
}
player_set_viewmodel_override(entity_num) {
  switch (self.entity_num) {
    case 0:
      self SetViewModel("viewmodel_usa_pow_arms");
      break;
    case 1:
      self SetViewModel("viewmodel_rus_prisoner_arms");
      break;
    case 2:
      self SetViewModel("viewmodel_vtn_nva_standard_arms");
      break;
    case 3:
      self SetViewModel("viewmodel_usa_hazmat_arms");
      break;
  }
}
cosmodrome_offhand_weapon_overrride() {
  register_lethal_grenade_for_level("frag_grenade_zm");
  level.zombie_lethal_grenade_player_init = "frag_grenade_zm";
  register_tactical_grenade_for_level("zombie_black_hole_bomb");
  register_tactical_grenade_for_level("zombie_nesting_dolls");
  level.zombie_tactical_grenade_player_init = undefined;
  register_placeable_mine_for_level("claymore_zm");
  level.zombie_placeable_mine_player_init = undefined;
  register_melee_weapon_for_level("knife_zm");
  register_melee_weapon_for_level("sickle_knife_zm");
  level.zombie_melee_weapon_player_init = "knife_zm";
}
offhand_weapon_give_override(str_weapon) {
  self endon("death");
  if(is_tactical_grenade(str_weapon) && isDefined(self get_player_tactical_grenade()) && !self is_player_tactical_grenade(str_weapon)) {
    self SetWeaponAmmoClip(self get_player_tactical_grenade(), 0);
    self TakeWeapon(self get_player_tactical_grenade());
  }
  if(str_weapon == "zombie_black_hole_bomb") {
    self maps\_zombiemode_weap_black_hole_bomb::player_give_black_hole_bomb();
    return true;
  }
  if(str_weapon == "zombie_nesting_dolls") {
    self maps\_zombiemode_weap_nesting_dolls::player_give_nesting_dolls();
    return true;
  }
  return false;
}
init_sounds() {
  maps\_zombiemode_utility::add_sound("electric_metal_big", "zmb_heavy_door_open");
  maps\_zombiemode_utility::add_sound("gate_swing", "zmb_door_fence_open");
  maps\_zombiemode_utility::add_sound("electric_metal_small", "zmb_lab_door_slide");
  maps\_zombiemode_utility::add_sound("gate_slide", "zmb_cosmo_gate_slide");
  maps\_zombiemode_utility::add_sound("door_swing", "zmb_cosmo_door_swing");
}
cosmodrome_fade_in_notify() {
  level waittill("fade_in_complete");
  level ClientNotify("ZID");
  wait_network_frame();
}