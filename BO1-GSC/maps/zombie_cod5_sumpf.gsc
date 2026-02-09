/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cod5_sumpf.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;
#include maps\zombie_cod5_sumpf_perks;
#include maps\zombie_cod5_sumpf_magic_box;
#include maps\zombie_cod5_sumpf_trap_pendulum;
#include maps\zombie_cod5_sumpf_zipline;
#include maps\zombie_cod5_sumpf_trap_perk_electric;
#include maps\_zombiemode_utility;

main() {
  maps\zombie_cod5_sumpf_fx::main();
  PreCacheModel("viewmodel_usa_pow_arms");
  PreCacheModel("viewmodel_rus_prisoner_arms");
  PreCacheModel("viewmodel_vtn_nva_standard_arms");
  PreCacheModel("viewmodel_usa_hazmat_arms");
  level thread maps\_callbacksetup::SetupCallbacks();
  level.randomize_perks = false;
  level.pulls_since_last_ray_gun = 0;
  level.pulls_since_last_tesla_gun = 0;
  level.player_drops_tesla_gun = false;
  level.dogs_enabled = true;
  level.zombie_rise_spawners = [];
  level.burning_zombies = [];
  level.use_zombie_heroes = true;
  level.kzmb_name = "sumpf_kzmb";
  precachemodel("zombie_zapper_cagelight_red");
  precachemodel("zombie_zapper_cagelight_green");
  precacheshellshock("electrocution");
  precacheshellshock("death");
  precachestring(&"WAW_ZOMBIE_BETTY_ALREADY_PURCHASED");
  precachestring(&"WAW_ZOMBIE_BETTY_HOWTO");
  level.dog_spawn_func = maps\_zombiemode_ai_dogs::dog_spawn_factory_logic;
  level.custom_ai_type = [];
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_waw_zombiemode_ai_japanese::init);
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_dogs::init);
  maps\_zombiemode_ai_dogs::enable_dog_rounds();
  include_weapons();
  include_powerups();
  level._effect["zombie_grain"] = LoadFx("misc/fx_zombie_grain_cloud");
  maps\_waw_zombiemode_radio::init();
  level.zombiemode_precache_player_model_override = ::precache_player_model_override;
  level.zombiemode_give_player_model_override = ::give_player_model_override;
  level.zombiemode_player_set_viewmodel_override = ::player_set_viewmodel_override;
  level.register_offhand_weapons_for_level_defaults_override = ::register_offhand_weapons_for_level_defaults_override;
  level.use_zombie_heroes = true;
  level.Player_Spawn_func = ::sumpf_player_spawn_placement;
  maps\_zombiemode::main();
  level.zone_manager_init_func = ::sumpf_zone_init;
  init_zones[0] = "center_building_upstairs";
  level thread maps\_zombiemode_zone_manager::manage_zones(init_zones);
  level thread setup_water_physics();
  level thread water_burst_overwrite();
  init_zombie_sumpf();
  init_sounds();
  maps\_zombiemode_betty::init();
  level.zombie_visionset = "zombie_sumpf";
  maps\createart\zombie_cod5_sumpf_art::main();
  level notify("setup_rope");
  level.has_pack_a_punch = false;
  SetSavedDvar("sv_maxPhysExplosionSpheres", 15);
  SetCullDist(2400);
  SetSavedDvar("r_lightGridEnableTweaks", 1);
  SetSavedDvar("r_lightGridIntensity", 1.25);
  SetSavedDvar("r_lightGridContrast", .1);
  VisionSetNaked("zombie_sumpf", 0);
}
setup_water_physics() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvars("phys_buoyancy", 1);
  }
}
sumpf_zone_init() {
  flag_init("always_on");
  flag_set("always_on");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_upstairs", "center_building_upstairs_buy", "unlock_hospital_upstairs");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_upstairs", "center_building_combined", "unlock_hospital_downstairs");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_upstairs_buy", "center_building_combined", "unlock_hospital_upstairs");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_upstairs_buy", "center_building_combined", "unlock_hospital_downstairs");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_combined", "northeast_outside", "ne_magic_box");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_combined", "northwest_outside", "nw_magic_box");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_combined", "southeast_outside", "se_magic_box");
  maps\_zombiemode_zone_manager::add_adjacent_zone("center_building_combined", "southwest_outside", "sw_magic_box");
  maps\_zombiemode_zone_manager::add_adjacent_zone("northeast_outside", "northeast_building", "northeast_building_unlocked");
  maps\_zombiemode_zone_manager::add_adjacent_zone("northwest_outside", "northwest_building", "northwest_building_unlocked");
  maps\_zombiemode_zone_manager::add_adjacent_zone("southeast_outside", "southeast_building", "southeast_building_unlocked");
  maps\_zombiemode_zone_manager::add_adjacent_zone("southwest_outside", "southwest_building", "southwest_building_unlocked");
}
init_sounds() {
  maps\_zombiemode_utility::add_sound("wooden_door", "zmb_door_wood_open");
  iprintlnbold("init_audio");
  level thread toilet_useage();
  level thread radio_one();
  level thread radio_two();
  level thread radio_three();
  level thread radio_eggs();
  level thread battle_radio();
  level thread whisper_radio();
  level thread meteor_trigger();
  level thread book_useage();
  level thread setup_custom_vox();
  level thread superegg_one();
  level thread superegg_two();
  level thread superegg_three();
  level thread super_egg();
}
precache_player_model_override() {
  mptype\player_t5_zm_theater::precache();
}
give_player_model_override(entity_num) {
  if(isDefined(self.zm_random_char)) {
    entity_num = self.zm_random_char;
  }
  switch (entity_num) {
    case 0:
      character\c_usa_dempsey_zt::main();
      break;
    case 1:
      character\c_rus_nikolai_zt::main();
      break;
    case 2:
      character\c_jap_takeo_zt::main();
      break;
    case 3:
      character\c_ger_richtofen_zt::main();
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
register_offhand_weapons_for_level_defaults_override() {
  register_lethal_grenade_for_level("stielhandgranate");
  level.zombie_lethal_grenade_player_init = "stielhandgranate";
  register_tactical_grenade_for_level("zombie_cymbal_monkey");
  level.zombie_tactical_grenade_player_init = undefined;
  register_placeable_mine_for_level("mine_bouncing_betty");
  level.zombie_placeable_mine_player_init = undefined;
  register_melee_weapon_for_level("knife_zm");
  level.zombie_melee_weapon_player_init = "knife_zm";
}
include_weapons() {
  include_weapon("python_zm");
  include_weapon("cz75_zm");
  include_weapon("g11_lps_zm");
  include_weapon("famas_zm");
  include_weapon("spectre_zm");
  include_weapon("cz75dw_zm");
  include_weapon("spas_zm");
  include_weapon("hs10_zm");
  include_weapon("aug_acog_zm");
  include_weapon("galil_zm");
  include_weapon("commando_zm");
  include_weapon("fnfal_zm");
  include_weapon("dragunov_zm");
  include_weapon("l96a1_zm");
  include_weapon("rpk_zm");
  include_weapon("hk21_zm");
  include_weapon("m72_law_zm");
  include_weapon("china_lake_zm");
  include_weapon("zombie_cymbal_monkey");
  include_weapon("ray_gun_zm");
  include_weapon("crossbow_explosive_zm");
  include_weapon("knife_ballistic_zm");
  include_weapon("zombie_type99_rifle", false, true);
  include_weapon("zombie_m1carbine", false, true);
  include_weapon("zombie_m1garand", false, true);
  include_weapon("zombie_gewehr43", false, true);
  include_weapon("zombie_stg44", false, true);
  include_weapon("zombie_thompson", false, true);
  include_weapon("mp40_zm", false, true);
  include_weapon("zombie_type100_smg", false, true);
  include_weapon("stielhandgranate", false, true);
  include_weapon("zombie_shotgun", false, true);
  include_weapon("zombie_bar", false, true);
  include_weapon("tesla_gun_zm");
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("mine_bouncing_betty", false, true);
  include_weapon("zombie_cymbal_monkey");
  level._uses_retrievable_ballisitic_knives = true;
  maps\_zombiemode_weapons::add_limited_weapon("m1911_zm", 0);
  maps\_zombiemode_weapons::add_limited_weapon("tesla_gun_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("crossbow_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("knife_ballistic_zm", 1);
  precacheItem("explosive_bolt_zm");
  precacheItem("explosive_bolt_upgraded_zm");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_kar98k", "zombie_kar98k_upgraded", &"WAW_ZOMBIE_WEAPON_KAR98K_200", 200, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_type99_rifle", "", &"WAW_ZOMBIE_WEAPON_TYPE99_200", 200, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_gewehr43", "zombie_gewehr43_upgraded", &"WAW_ZOMBIE_WEAPON_GEWEHR43_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_m1carbine", "zombie_m1carbine_upgraded", &"WAW_ZOMBIE_WEAPON_M1CARBINE_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_m1garand", "zombie_m1garand_upgraded", &"WAW_ZOMBIE_WEAPON_M1GARAND_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("stielhandgranate", "", &"WAW_ZOMBIE_WEAPON_STIELHANDGRANATE_250", 250, "grenade", "", 250);
  maps\_zombiemode_weapons::add_zombie_weapon("mine_bouncing_betty", "", &"WAW_ZOMBIE_WEAPON_SATCHEL_2000", 2000);
  maps\_zombiemode_weapons::add_zombie_weapon("kar98k_scoped_zombie", "", &"WAW_ZOMBIE_WEAPON_KAR98K_S_750", 750, "sniper");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_stg44", "zombie_stg44_upgraded", &"WAW_ZOMBIE_WEAPON_STG44_1200", 1200, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_thompson", "zombie_thompson_upgraded", &"WAW_ZOMBIE_WEAPON_THOMPSON_1200", 1200, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_type100_smg", "zombie_type100_smg_upgraded", &"WAW_ZOMBIE_WEAPON_TYPE100_1000", 1000, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_fg42", "zombie_fg42_upgraded", &"WAW_ZOMBIE_WEAPON_FG42_1500", 1500, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_doublebarrel", "zombie_doublebarrel_upgraded", &"WAW_ZOMBIE_WEAPON_DOUBLEBARREL_1200", 1200, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_doublebarrel_sawed", "", &"WAW_ZOMBIE_WEAPON_DOUBLEBARREL_SAWED_1200", 1200, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_shotgun", "zombie_shotgun_upgraded", &"WAW_ZOMBIE_WEAPON_SHOTGUN_1500", 1500, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_bar", "zombie_bar_upgraded", &"WAW_ZOMBIE_WEAPON_BAR_1800", 1800, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_bar_bipod", "", &"WAW_ZOMBIE_WEAPON_BAR_BIPOD_2500", 2500, "mg");
}
include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
}
init_zombie_sumpf() {
  thread maps\zombie_cod5_sumpf_magic_box::magic_box_init();
  level thread maps\zombie_cod5_sumpf_trap_perk_electric::init_elec_trap_trigs();
  zipHintDeactivated = getent("zipline_deactivated_hint_trigger", "targetname");
  zipHintDeactivated sethintstring(&"WAW_ZOMBIE_ZIPLINE_DEACTIVATED");
  zipHintDeactivated SetCursorHint("HINT_NOICON");
  penBuyTrigger = getEntArray("pendulum_buy_trigger", "targetname");
  if(!level.mutators["mutator_noTraps"]) {
    for(i = 0; i < penBuyTrigger.size; i++) {
      penBuyTrigger[i] sethintstring(&"WAW_ZOMBIE_CLEAR_DEBRIS");
      penBuyTrigger[i] setCursorHint("HINT_NOICON");
    }
    level thread maps\zombie_cod5_sumpf::turnLightRed("pendulum_light");
  }
}
turnLightGreen(name) {
  zapper_lights = getEntArray(name, "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_green");
    if(isDefined(zapper_lights[i].target)) {
      old_light_effect = getent(zapper_lights[i].target, "targetname");
      light_effect = spawn("script_model", zapper_lights[i].origin + (0, 0, 10));
      light_effect setModel("tag_origin");
      light_effect.angles = (0, 270, 0);
      light_effect.targetname = "effect_" + name + i;
      old_light_effect delete();
      zapper_lights[i].target = light_effect.targetname;
      playFXOnTag(level._effect["zapper_light_ready"], light_effect, "tag_origin");
    }
  }
}
turnLightRed(name) {
  zapper_lights = getEntArray(name, "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_red");
    if(isDefined(zapper_lights[i].target)) {
      old_light_effect = getent(zapper_lights[i].target, "targetname");
      light_effect = spawn("script_model", zapper_lights[i].origin + (0, 0, 10));
      light_effect setModel("tag_origin");
      light_effect.angles = (0, 270, 0);
      light_effect.targetname = "effect_" + name + i;
      old_light_effect delete();
      zapper_lights[i].target = light_effect.targetname;
      playFXOnTag(level._effect["zapper_light_notready"], light_effect, "tag_origin");
    }
  }
}
book_useage() {
  book_counter = 0;
  book_trig = getent("book_trig", "targetname");
  book_trig SetCursorHint("HINT_NOICON");
  book_trig UseTriggerRequireLookAt();
  if(isDefined(book_trig)) {
    maniac_l = getent("maniac_l", "targetname");
    maniac_r = getent("maniac_r", "targetname");
    book_trig waittill("trigger", player);
    if(isDefined(maniac_l)) {
      maniac_l playSound("maniac_l");
    }
    if(isDefined(maniac_r)) {
      maniac_r playSound("maniac_r");
    }
  }
}
toilet_useage() {
  toilet_counter = 0;
  toilet_trig = getent("toilet", "targetname");
  toilet_trig SetCursorHint("HINT_NOICON");
  toilet_trig UseTriggerRequireLookAt();
  toilet_trig playLoopSound("phone_hook");
  if(!isDefined(level.music_override)) {
    level.music_override = false;
  }
  toilet_trig waittill("trigger", player);
  toilet_trig stoploopsound(0.5);
  toilet_trig playLoopSound("phone_dialtone");
  wait(0.5);
  toilet_trig waittill("trigger", player);
  toilet_trig stoploopsound(0.5);
  toilet_trig playSound("dial_9", "sound_done");
  toilet_trig waittill("sound_done");
  toilet_trig waittill("trigger", player);
  toilet_trig playSound("dial_1", "sound_done");
  toilet_trig waittill("sound_done");
  toilet_trig waittill("trigger", player);
  toilet_trig playSound("dial_1");
  wait(0.5);
  toilet_trig playSound("riiing");
  wait(1);
  toilet_trig playSound("riiing");
  wait(1);
  toilet_trig playSound("toilet_flush", "sound_done");
  toilet_trig waittill("sound_done");
  playsoundatposition("zmb_cha_ching", toilet_trig.origin);
  level thread play_music_easter_egg(player);
}
play_music_easter_egg(player) {
  level.music_override = true;
  level thread maps\_zombiemode_audio::change_zombie_music("egg");
  wait(4);
  if(isDefined(player)) {
    player maps\_zombiemode_audio::create_and_play_dialog("eggs", "music_activate");
  }
  wait(236);
  level.music_override = false;
  level thread maps\_zombiemode_audio::change_zombie_music("wave_loop");
}
play_radio_sounds() {
  radio_one = getent("radio_one_origin", "targetname");
  radio_two = getent("radio_two_origin", "targetname");
  radio_three = getent("radio_three_origin", "targetname");
  pa_system = getent("speaker_in_attic", "targetname");
  radio_one stoploopsound(2);
  radio_two stoploopsound(2);
  radio_three stoploopsound(2);
  wait(0.05);
  pa_system playSound("secret_message", "message_complete");
  pa_system waittill("message_complete");
  radio_one playSound("static");
  radio_two playSound("static");
  radio_three playSound("static");
}
radio_eggs() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  while(level.radio_counter < 3) {
    wait(2);
  }
  level thread play_radio_sounds();
}
superegg_one() {
  if(!isDefined(level.superegg_counter)) {
    level.superegg_counter = 0;
  }
  superegg_one_trig = getent("superegg_radio_trigger_1", "targetname");
  superegg_one_trig UseTriggerRequireLookAt();
  superegg_one_trig SetCursorHint("HINT_NOICON");
  superegg_radio_one = getent("superegg_radio_origin_1", "targetname");
  superegg_one_trig waittill("trigger");
  level.superegg_counter = level.superegg_counter + 1;
  superegg_radio_one playLoopSound("static_loop");
}
superegg_two() {
  if(!isDefined(level.superegg_counter)) {
    level.superegg_counter = 0;
  }
  superegg_two_trig = getent("superegg_radio_trigger_2", "targetname");
  superegg_two_trig UseTriggerRequireLookAt();
  superegg_two_trig SetCursorHint("HINT_NOICON");
  superegg_radio_two = getent("superegg_radio_origin_2", "targetname");
  superegg_two_trig waittill("trigger");
  level.superegg_counter = level.superegg_counter + 1;
  superegg_radio_two playLoopSound("static_loop");
}
superegg_three() {
  if(!isDefined(level.superegg_counter)) {
    level.superegg_counter = 0;
  }
  superegg_three_trig = getent("superegg_radio_trigger_3", "targetname");
  superegg_three_trig UseTriggerRequireLookAt();
  superegg_three_trig SetCursorHint("HINT_NOICON");
  superegg_radio_three = getent("superegg_radio_origin_3", "targetname");
  superegg_three_trig waittill("trigger");
  level.superegg_counter = level.superegg_counter + 1;
  superegg_radio_three playLoopSound("static_loop");
}
play_super_egg_radio_pa_sounds() {
  superegg_radio_one = getent("radio_one_origin", "targetname");
  superegg_radio_two = getent("radio_two_origin", "targetname");
  superegg_radio_three = getent("radio_three_origin", "targetname");
  pa_system = getent("speaker_in_attic", "targetname");
  superegg_radio_one stoploopsound(2);
  superegg_radio_two stoploopsound(2);
  superegg_radio_three stoploopsound(2);
  wait(0.05);
  pa_system playSound("superegg_secret_message", "message_complete");
  pa_system waittill("message_complete");
  superegg_radio_one playSound("static");
  superegg_radio_two playSound("static");
  superegg_radio_three playSound("static");
}
super_egg() {
  if(!isDefined(level.superegg_counter)) {
    level.superegg_counter = 0;
  }
  while(level.superegg_counter < 3) {
    wait(2);
  }
  level thread play_super_egg_radio_pa_sounds();
}
battle_radio() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  battle_radio_trig = getent("battle_radio_trigger", "targetname");
  battle_radio_trig UseTriggerRequireLookAt();
  battle_radio_trig SetCursorHint("HINT_NOICON");
  battle_radio_origin = getent("battle_radio_origin", "targetname");
  battle_radio_trig waittill("trigger", player);
  battle_radio_origin playSound("battle_message");
}
whisper_radio() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  whisper_radio_trig = getent("whisper_radio_trigger", "targetname");
  whisper_radio_trig UseTriggerRequireLookAt();
  whisper_radio_trig SetCursorHint("HINT_NOICON");
  whisper_radio_origin = getent("whisper_radio_origin", "targetname");
  whisper_radio_trig waittill("trigger");
  whisper_radio_origin playSound("whisper_message");
}
radio_one() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  radio_one_trig = getent("radio_one", "targetname");
  radio_one_trig UseTriggerRequireLookAt();
  radio_one_trig SetCursorHint("HINT_NOICON");
  radio_one = getent("radio_one_origin", "targetname");
  radio_one_trig waittill("trigger");
  level.radio_counter = level.radio_counter + 1;
  radio_one playLoopSound("static_loop");
}
radio_two() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  radio_two_trig = getent("radio_two", "targetname");
  radio_two_trig UseTriggerRequireLookAt();
  radio_two_trig SetCursorHint("HINT_NOICON");
  radio_two = getent("radio_two_origin", "targetname");
  radio_two_trig waittill("trigger", players);
  level.radio_counter = level.radio_counter + 1;
  radio_two playLoopSound("static_loop");
}
radio_three() {
  if(!isDefined(level.radio_counter)) {
    level.radio_counter = 0;
  }
  radio_three_trig = getent("radio_three_trigger", "targetname");
  radio_three_trig UseTriggerRequireLookAt();
  radio_three_trig SetCursorHint("HINT_NOICON");
  radio_three = getent("radio_three_origin", "targetname");
  radio_three_trig waittill("trigger", players);
  level.radio_counter = level.radio_counter + 1;
  radio_three playLoopSound("static_loop");
}
meteor_trigger() {
  level endon("meteor_triggered");
  dmgtrig = GetEnt("meteor", "targetname");
  while(1) {
    dmgtrig waittill("trigger", player);
    if(distancesquared(player.origin, dmgtrig.origin) < 1096 * 1096) {
      player thread maps\_zombiemode_audio::create_and_play_dialog("level", "meteor");
      level notify("meteor_triggered");
    } else {
      wait(0.1);
    }
  }
}
setup_custom_vox() {
  wait(1);
  level.plr_vox["level"]["jugga"] = "gen_perk_jugga";
  level.plr_vox["level"]["doubletap"] = "gen_perk_dbltap";
  level.plr_vox["level"]["speed"] = "gen_perk_speed";
  level.plr_vox["level"]["revive"] = "gen_perk_revive";
  level.plr_vox["level"]["zipline"] = "zipline";
  level.plr_vox["level"]["trap_log"] = "trap_log";
  level.plr_vox["level"]["trap_barrel"] = "trap_barrel";
  level.plr_vox["level"]["meteor"] = "meteor";
}
sumpf_exit_level() {
  zombies = GetAiArray("axis");
  for(i = 0; i < zombies.size; i++) {
    zombies[i] thread sumpf_find_exit_point();
  }
}
sumpf_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = VectorNormalize(self.origin - player.origin);
  endPos = self.origin + vector_scale(away, 600);
  locs = array_randomize(level.enemy_dog_locations);
  for(i = 0; i < locs.size; i++) {
    dist_zombie = DistanceSquared(locs[i].origin, endPos);
    dist_player = DistanceSquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self setgoalpos(locs[dest].origin);
  while(1) {
    if(!flag("wait_and_revive")) {
      break;
    }
    wait_network_frame();
  }
  self thread maps\_zombiemode_spawner::find_flesh();
}
sumpf_player_spawn_placement() {
  structs = getstructarray("initial_spawn_points", "targetname");
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] setorigin(structs[i].origin);
    players[i] setplayerangles(structs[i].angles);
    players[i].spectator_respawn = structs[i];
  }
}
water_burst_overwrite() {
  level waittill("between_round_over");
  level._effect["rise_burst_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_burst_smpf");
  level._effect["rise_billow_water"] = LoadFX("maps/zombie/fx_zombie_body_wtr_billow_smpf");
}