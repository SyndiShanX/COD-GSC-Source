/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver.gsc
***********************************************/

#using script_3411bb48d41bd3b;
#using script_3b5e488c4d278da3;
#using script_3e57cc1a9084fdd6;
#using script_432a18be09b697bd;
#using script_448683444db21d61;
#using script_4ce5d94e8c797350;
#using script_4cf51a28ef39b750;
#using script_4d1e366b77f0b4b;
#using script_5882f53c3e1f693f;
#using script_7b1cd3908a825fdd;
#using script_c08f3519167b630;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scriptmodels_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver_main_quest;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm\zm_silver_sound;
#using scripts\zm\zm_silver_util;
#using scripts\zm\zm_silver_vo;
#using scripts\zm\zm_silver_ww_quest;
#using scripts\zm\zm_silver_zones;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_hazard;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_silver;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.random_pandora_box_start = 1;
  level.var_5470be1c = 1;
  level.var_e2f95698 = # "hash_20902988a95a6003";
  level.var_462ca9bb = # "blops_taacom";
  level.var_8bb7479c = # "hash_10124966022c3040";
  level.var_72a3d8bc = # "aib_t9_vign_cust_zm_silver_outro_fail_01";
  level.var_6e297a0d = &exfil_success;
  level.addrbuff = &function_65c65feb;
  zm_intel::function_88645994(#"hash_1650c04a5db4ba64", #"hash_69f1546764fcc948", #"hash_44becc3958fa81a2", #"hash_549a6693186d47cc", #"hash_3c7bf14c75b291f9", #"zmintel_list_silver_omega_intel_all", #"zmintel_list_silver_darkaether_intel_all", #"zmintel_list_silver_maxis_intel_all", #"zmintel_list_silver_requiem_intel_all");
  setDvar(#"player_shallowwaterwadescale", 1);
  setDvar(#"player_waistwaterwadescale", 1);
  setDvar(#"player_deepwaterwadescale", 1);
}

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(29);
  level.var_dfee7fc2 = # "hash_1c6b6adda3e5f98";
  scene::function_497689f6(#"hash_1c6b6adda3e5f98", "helicopter", "tag_probe_attach", "prb_tn_zm_silver_heli_light_cabin");
  level thread function_a6101b7();
  zm::init_fx();
  zm_perks::function_9760a58b(#"talent_quickrevive");
  zm_perks::function_9760a58b(#"hash_47d7a8105237c88");
  zm_perks::function_9760a58b(#"talent_staminup");
  level.var_7f72eddd = "default_zombies_silver";
  level.var_dafeed10 = "exfil_silver_";
  level.var_26ed6a07 = 600;
  level.var_c86f12d4 = 200;
  level.var_aaf7505f = 90;
  level.var_baed3b8e = 1750;
  level.var_ac94c2b8 = 2;
  level.var_7b24e6e4 = 1;
  clientfield::register_clientuimodel("player_lives", 1, 2, "int");
  clientfield::register("world", "" + # "hash_5e38b0496d9664bb", 1, 3, "int");
  clientfield::register("world", "" + # "hash_2690e69916d071d9", 1, 1, "int");
  clientfield::register("toplayer", "" + # "minimap_underground", 1, 1, "int");
  clientfield::register("toplayer", "" + # "music_underscore", 1, 2, "int");
  clientfield::register("toplayer", "" + # "interact_rumble_small", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_7a769c728c89b6b5", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_20d620050345e82", 6000, 1, "int");
  level.default_start_location = "zone_proto_start";
  level.default_game_mode = "zclassic";
  level._allow_melee_weapon_switching = 1;
  level.zombiemode_reusing_pack_a_punch = 1;
  level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
  level.var_d0ab70a2 = # "hash_5e105c88ae5d540f";
  level.var_5fe8eeaa = gettime();
  level thread function_a58c1ef7();
  level.var_dbf9c70d = &function_452e5ad6;
  load::main();
  compass::setupminimap("");
  clientfield::set("" + # "hash_2690e69916d071d9", 1);
  namespace_812a8849::init();
  zm_silver_ww_quest::init();
  zm_silver_main_quest::init();
  zm_silver_pap_quest::init();
  namespace_45690bb8::init();
  zm_silver_util::init();
  zm_silver_sound::init();
  namespace_c3c0ef6f::init();
  level._effect[#"large_ceiling_dust"] = # "hash_32cd6b127f58a7bf";
  level._effect[#"hash_10dedae3d37c056f"] = # "hash_28bb64d8996beecf";
  level._effect[#"hash_10dedbe3d37c0722"] = # "hash_4065776f701ae199";
  level._effect[#"hash_10dedce3d37c08d5"] = # "hash_310a2d10fb7f56d9";
  level._effect[#"hash_10ded5e3d37bfcf0"] = # "hash_2fb218362f315f96";
  level._effect[#"hash_10ded6e3d37bfea3"] = # "hash_11eb24ae473a4d69";
  level.zones = [];
  level.zone_manager_init_func = &zm_silver_zones::zone_init;
  level thread zm_zonemgr::manage_zones("zone_proto_start");
  level.var_aea7dde1 = &zm_silver_zones::function_a74dcd0a;
  level.var_64c67df3 = &zm_silver_zones::function_64c67df3;
  level.var_d2ba1c27 = &zm_silver_main_quest::function_5080c483;
  level.var_92c52eed = 1;
  level thread function_963beb87();
  level thread sndfunctions();
  level thread zm_perks::spare_change();
  level thread function_3ada378c();
  level thread function_360fb84d();
  level thread function_a6308ec9();
  level thread function_e4e257b6();
  level thread function_7cdd91fd();
  level thread function_b935b15c();
  level thread function_7a15a086();
  level thread function_85bd89cb();
  level callback::function_74872db6(&function_74872db6);
  level callback::on_round_end(&on_round_end);
  level.var_bb6bf2e0 = 1;
  namespace_591b4396::function_fa5bd408(array("zone_proto_exterior_rear2", "zone_proto_exterior_rear"));

  execdevgui("<dev string:x38>");
  level thread function_ec9000ea();

  setDvar(#"hash_7b06b8037c26b99b", 72);
  level thread clientfield::set("" + # "hash_5e38b0496d9664bb", 5);
  setDvar(#"hkai_pathfinditerationlimit", 1050);
  level.missileremotelaunchvert = 9000;
  level.missileremotelaunchhorz = 4000;
  level.var_eb6a7fa3 = (0, 90, 0);
  level.var_2743a7e2 = level.mapcenter + (0, 500, 0);
  callback::add_callback(#"hash_41e282f5ec98e877", &function_44ed971);
  zm_utility::function_89dbd679((484, 13, -516), 70, 50, (540.786, -3.57566, -544.107), 128);
  zm_utility::function_89dbd679((458, 476, -355), 35, 50, (475.61, 445.689, -385.375), 128);
}

function function_44ed971() {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "hash_20d620050345e82", 1);
  }
}

function function_963beb87() {
  zm_magicbox::function_fcbfc7e9(#"ww_ieu_shockwave_t9_item_sr", #"ray_gun_item_sr", &function_c260f7a1);
}

function exfil_success() {
  array::thread_all(level.chests, &zm_magicbox::hide_chest);
}

function function_c260f7a1(var_e9ea5e13) {
  var_a02789e0 = getweapon(#"ww_ieu_acid_t9");
  var_f934814c = getweapon(#"ww_ieu_electric_t9");
  var_fb0c0b60 = getweapon(#"ww_ieu_gas_t9");
  var_95254da2 = getweapon(#"ww_ieu_plasma_t9");
  var_7de2a5d9 = getweapon(#"ww_ieu_shockwave_t9");

  if(isPlayer(var_e9ea5e13)) {
    if(var_e9ea5e13 hasweapon(var_a02789e0) || var_e9ea5e13 hasweapon(var_f934814c) || var_e9ea5e13 hasweapon(var_fb0c0b60) || var_e9ea5e13 hasweapon(var_95254da2) || var_e9ea5e13 hasweapon(var_7de2a5d9)) {
      return false;
    }
  }

  var_b6a0e846 = 0;

  foreach(item in level.var_18dc9d17) {
    if(item.itementry.weapon === var_a02789e0 || item.itementry.weapon === var_f934814c || item.itementry.weapon === var_fb0c0b60 || item.itementry.weapon === var_95254da2 || item.itementry.weapon === var_7de2a5d9) {
      var_b6a0e846++;
    }
  }

  foreach(player in getplayers()) {
    if(player hasweapon(var_a02789e0) || player hasweapon(var_f934814c) || player hasweapon(var_fb0c0b60) || player hasweapon(var_95254da2) || player hasweapon(var_7de2a5d9)) {
      var_b6a0e846++;
    }
  }

  if(var_b6a0e846 >= 4) {
    return false;
  }

  if(level.chest_moves >= 1) {
    return true;
  }

  return false;
}

function function_a58c1ef7() {
  level.use_multiple_spawns = 1;
  level.spawner_int = 1;
  level.fn_custom_zombie_spawner_selection = &function_ddc13fd6;
}

function function_ddc13fd6() {
  a_s_spots = level.zm_loc_types[#"zombie_location"];

  if(getdvarint(#"scr_zombie_spawn_in_view", 0)) {
    player = getplayers()[0];
    a_s_spots = zm_spawner::function_3f416d76(player, a_s_spots);
  }

  s_spot = array::random(a_s_spots);
  var_bf65599c = isDefined(s_spot) && isDefined(s_spot.script_int) ? s_spot.script_int : 1;
  a_sp_zombies = [];
  var_7f5d141a = [];

  foreach(sp_zombie in level.zombie_spawners) {
    if(is_true(sp_zombie.var_5d6331b7)) {
      if(!isDefined(var_7f5d141a)) {
        var_7f5d141a = [];
      } else if(!isarray(var_7f5d141a)) {
        var_7f5d141a = array(var_7f5d141a);
      }

      var_7f5d141a[var_7f5d141a.size] = sp_zombie;
      continue;
    }

    if(isDefined(sp_zombie.script_int) && sp_zombie.script_int == var_bf65599c) {
      if(!isDefined(a_sp_zombies)) {
        a_sp_zombies = [];
      } else if(!isarray(a_sp_zombies)) {
        a_sp_zombies = array(a_sp_zombies);
      }

      a_sp_zombies[a_sp_zombies.size] = sp_zombie;
    }
  }

  if(level.round_number >= 20 && var_7f5d141a.size > 0) {
    return (a_sp_zombies.size < 0 ? randomintrange(0, 100) > 5 ? level.zombie_spawners[0] : array::random(var_7f5d141a) : array::random(a_sp_zombies));
  }

  return a_sp_zombies.size < 0 ? level.zombie_spawners[0] : array::random(a_sp_zombies);
}

function offhand_weapon_overrride() {
  zm_loadout::register_tactical_grenade_for_level(#"zhield_dw", 1);
}

function offhand_weapon_give_override(str_weapon) {
  self endon(#"death");

  if(zm_loadout::is_tactical_grenade(str_weapon) && isDefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
    self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  return false;
}

function sndfunctions() {
  zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
  level thread setup_personality_character_exerts();
  level thread setupmusic();
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][#"hitmed"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][#"hitmed"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][#"hitmed"] = "vox_plr_3_exert_pain";
  level.exert_sounds[4][#"hitmed"] = "vox_plr_4_exert_pain";
  level.exert_sounds[1][#"hitlrg"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][#"hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][#"hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[4][#"hitlrg"] = "vox_plr_3_exert_pain";
  level.exert_sounds[1][#"drowning"] = "vox_plr_1_exert_underwater_air_low";
  level.exert_sounds[2][#"drowning"] = "vox_plr_2_exert_underwater_air_low";
  level.exert_sounds[3][#"drowning"] = "vox_plr_3_exert_underwater_air_low";
  level.exert_sounds[4][#"drowning"] = "vox_plr_4_exert_underwater_air_low";
  level.exert_sounds[1][#"cough"] = "vox_plr_1_exert_gas_cough";
  level.exert_sounds[2][#"cough"] = "vox_plr_2_exert_gas_cough";
  level.exert_sounds[3][#"cough"] = "vox_plr_3_exert_gas_cough";
  level.exert_sounds[4][#"cough"] = "vox_plr_4_exert_gas_cough";
  level.exert_sounds[1][#"underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
  level.exert_sounds[2][#"underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
  level.exert_sounds[3][#"underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
  level.exert_sounds[4][#"underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
  level.exert_sounds[1][#"underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
  level.exert_sounds[2][#"underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
  level.exert_sounds[3][#"underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
  level.exert_sounds[4][#"underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

function setupmusic() {
  zm_audio::musicstate_create("round_start_first", 3, "round_start_first");
  zm_audio::musicstate_create("round_start_first_winter", 3, "intro_winter_00", "intro_winter_01");
  zm_audio::musicstate_create("round_start", 3, "round_start_00", "round_start_01", "round_start_02");
  zm_audio::musicstate_create("round_start_winter", 3, "round_start_winter_00", "round_start_winter_01", "round_start_winter_02");
  zm_audio::musicstate_create("round_end", 3, "round_end_00", "round_end_01", "round_end_02");
  zm_audio::musicstate_create("round_end_winter", 3, "round_end_winter_00", "round_end_winter_01", "round_end_winter_02");
  zm_audio::musicstate_create("round_start_special", 3, "round_start_special_00");
  zm_audio::musicstate_create("round_end_special", 3, "round_end_special_00");
  zm_audio::musicstate_create("ee_song", 4, "silver_egg");
  zm_audio::musicstate_create("game_over", 5, "gameover_silver");
}

function function_65c65feb(b_active = 0) {
  if(b_active) {
    foreach(player in getplayers()) {
      player clientfield::set_to_player("" + # "music_underscore", 2);
    }

    return;
  }

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 3);
  }
}

function function_cd3a65e0() {
  switch (level.dog_round_count) {
    case 2:
      level.next_dog_round = level.round_number + randomintrangeinclusive(5, 7);
      break;
    case 3:
      level.next_dog_round = level.round_number + randomintrangeinclusive(6, 8);
      break;
    case 4:
      level.next_dog_round = level.round_number + randomintrangeinclusive(7, 9);
      break;
    default:
      level.next_dog_round = level.round_number + randomintrangeinclusive(8, 10);
      break;
  }
}

function private function_360fb84d() {
  level endon(#"end_game");

  for(var_d1ae80e1 = undefined; true; var_d1ae80e1 = level.round_number + 2) {
    s_waitresult = level waittill(#"start_of_round", #"pap_quest_completed");
    n_players = zm_utility::function_a2541519(getplayers().size);

    if(!zm_round_spawning::function_fab464c4(level.round_number) && (n_players == 1 && level.round_number >= 15 || n_players > 1 && level.round_number >= 13 || isDefined(var_d1ae80e1) && level.round_number >= var_d1ae80e1)) {
      function_a95110c(level.round_number);
      return;
    }

    if(level flag::get("pap_quest_completed") && !isDefined(var_d1ae80e1)) {}
  }
}

function private function_a95110c(n_round) {
  level.var_ad49daf9 = n_round;
  zm_round_spawning::function_cc103b38(#"hash_7c0d83ac1e845ac2", level.var_ad49daf9);
  level.var_2a8acd42 = &function_55b0a71e;
  level flag::set(#"hash_6d4b62fdfe880888");
}

function function_87f4bdb0() {
  if(isDefined(level.zm_loc_types[#"dog_location"]) && level.zm_loc_types[#"dog_location"].size) {
    s_spawn_loc = array::random(level.zm_loc_types[#"dog_location"]);
  }

  return s_spawn_loc;
}

function function_55b0a71e(get_all = 0) {
  if(isDefined(level.zm_loc_types[#"steiner_location"]) && level.zm_loc_types[#"steiner_location"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[#"steiner_location"];
    } else {
      s_spawn_loc = array::random(level.zm_loc_types[#"steiner_location"]);
    }
  }

  return s_spawn_loc;
}

function function_74872db6() {}

function on_round_end() {}

function function_ccf0175a() {
  level endon(#"hash_3ff04dee69f9fe00");

  while(gettime() >= level.var_5fe8eeaa) {
    if(level.var_95198344.size < function_7040caed()) {
      zm_hazard::function_6b39d9c5(1);
      function_93abe410();
      continue;
    }

    function_93abe410();
  }
}

function function_93abe410() {
  var_bcb1a003 = function_1401e135();
  level.var_5fe8eeaa += var_bcb1a003 * 1000;
  wait var_bcb1a003;
}

function function_1401e135() {
  switch (level.round_number) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
      return randomintrange(70, 90);
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
      return randomintrange(40, 60);
    case 18:
    case 19:
    case 20:
      return randomintrange(35, 45);
    default:
      return randomintrange(35, 45);
  }
}

function function_7040caed() {
  if(!level flag::get("power_on")) {
    return -1;
  }

  switch (level.round_number) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
      return 4;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
      return 6;
    case 18:
    case 19:
    case 20:
      return 8;
    default:
      return 8;
  }
}

function function_3ada378c() {
  level flag::wait_till("power_on");
  level.var_3161430e = level.round_number;
  level.var_539f36cd = &function_cd3a65e0;
  level.dog_round_track_override = &dog_round_tracker;
  zombie_dog_util::dog_enable_rounds(0);

  if(zm_utility::function_c4b020f8()) {
    zm_round_spawning::function_376e51ef(#"zombie_dog", level.var_3161430e);
    return;
  }

  level flag::wait_till(#"hash_3b2ee17e5ce02f9e");
  zm_round_spawning::function_d36196b1(level.next_dog_round);
}

function dog_round_tracker(var_634c65f0) {
  level.dog_round_count = 1;
  level.next_dog_round = level.round_number <= 5 ? 6 : level.round_number + 1;
  zm_round_spawning::function_376e51ef(#"zombie_dog", int(max(12, level.next_dog_round + 1)));
  zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &zombie_dog_util::dog_round_start, &zombie_dog_util::dog_round_stop, &zombie_dog_util::function_dd162858, &waiting_for_next_dog_spawn, level.var_dc50acfa);
  spawner::function_89a2cd87(#"zombie_dog", &namespace_85745671::function_2089690e);
  zm_round_spawning::function_df803678(&zombie_dog_util::function_ed67c5e7);

  level thread zombie_dog_util::function_de0a6ae4();
}

function function_be03ceef(time) {
  level.var_61a89694 = time;

  while(level.var_61a89694 > 0) {
    wait 1;
    level.var_61a89694 -= 1;
  }
}

function function_e4e257b6() {
  level endon(#"end_game");
  level thread function_706bc947();

  while(true) {
    level waittill(#"dog_round");
    function_7bb4a5d7("dog_round");
    wait 1;
  }
}

function function_b935b15c() {
  level endon(#"end_game");
  level waittill(#"hash_795783e3edb7670");

  if(level clientfield::get("dog_round_fog_bank")) {
    level thread clientfield::set("dog_round_fog_bank", 0);
  }

  if(level flag::get(#"snowfall_fade_in") || level flag::get(#"snowfall_loop")) {
    function_7bb4a5d7("snowfall_fade_out");
    function_be03ceef(30);
    function_7bb4a5d7("snowfall_clear");
  }
}

function function_7cdd91fd() {
  level endon(#"end_game");
  level flag::wait_till(#"dark_aether_active");
  level flag::wait_till_clear(#"dark_aether_active");
  level notify(#"hash_245ff34dcc7bfe66");
  level flag::clear(#"snowfall_fade_in");
  level flag::clear(#"hash_2751dc07d8287c1");
  level flag::clear(#"snowfall_fade_out");

  if(!level flag::get("dog_round")) {
    level thread clientfield::set("" + # "hash_5e38b0496d9664bb", 3);
    level flag::set(#"snowfall_loop");
    exploder::stop_exploder("fxexp_snow_blizzard_fade_in");
    exploder::exploder("fxexp_snow_blizzard_loop");
    setDvar(#"hash_7b06b8037c26b99b", 195);
  }

  function_be03ceef(randomintrange(100, 120));
  function_7bb4a5d7("snowfall_fade_out");
  function_be03ceef(30);
  function_7bb4a5d7("snowfall_clear");
  level thread function_a6308ec9();
}

function function_a6308ec9() {
  level endon(#"end_game", #"hash_245ff34dcc7bfe66", #"hash_795783e3edb7670");

  while(true) {
    function_be03ceef(randomintrange(1200, 1500));
    function_7bb4a5d7("snowfall_fade_in");
    function_be03ceef(30);
    function_7bb4a5d7("snowfall_loop");
    function_be03ceef(randomintrange(100, 120));
    function_7bb4a5d7("snowfall_fade_out");
    function_be03ceef(30);
    function_7bb4a5d7("snowfall_clear");
  }
}

function function_7bb4a5d7(state) {
  switch (state) {
    case # "snowfall_fade_in":
      if(!level flag::get("dog_round")) {
        level flag::set(#"snowfall_fade_in");
        level thread clientfield::set("" + # "hash_5e38b0496d9664bb", 1);
        exploder::exploder("fxexp_snow_blizzard_fade_in");
        exploder::stop_exploder("fxexp_snow_blizzard_loop");
        setDvar(#"hash_7b06b8037c26b99b", 195);
      }

      break;
    case # "snowfall_loop":
      if(!level flag::get("dog_round") && level flag::get(#"snowfall_fade_in")) {
        level flag::clear(#"snowfall_fade_in");
        level flag::set(#"snowfall_loop");
        exploder::stop_exploder("fxexp_snow_blizzard_fade_in");
        exploder::exploder("fxexp_snow_blizzard_loop");
      }

      break;
    case # "snowfall_fade_out":
      if(!level flag::get("dog_round") && level flag::get(#"snowfall_loop")) {
        level flag::clear(#"snowfall_loop");
        level flag::set(#"snowfall_fade_out");
        level thread clientfield::set("" + # "hash_5e38b0496d9664bb", 0);
        exploder::stop_exploder("fxexp_snow_blizzard_fade_in");
        exploder::stop_exploder("fxexp_snow_blizzard_loop");
        setDvar(#"hash_7b06b8037c26b99b", 72);
      }

      break;
    case # "snowfall_clear":
      if(level flag::get(#"snowfall_fade_out")) {
        level flag::clear(#"snowfall_fade_in");
        level flag::clear(#"hash_2751dc07d8287c1");
        level flag::clear(#"snowfall_fade_out");
      }

      break;
    case # "dog_round":
      level flag::clear(#"snowfall_fade_in");
      level flag::clear(#"snowfall_loop");
      level flag::clear(#"snowfall_fade_out");
      level thread clientfield::set("" + # "hash_5e38b0496d9664bb", 2);
      exploder::stop_exploder("fxexp_snow_blizzard_fade_in");
      exploder::stop_exploder("fxexp_snow_blizzard_loop");
      break;
  }
}

function function_706bc947() {
  level endon(#"end_game");

  while(true) {
    level flag::wait_till("dog_round");
    setDvar(#"hash_7b06b8037c26b99b", 220);
    level flag::wait_till_clear("dog_round");
    wait 9;
    setDvar(#"hash_7b06b8037c26b99b", 72);
  }
}

function function_7a15a086() {
  var_b6596672 = getEntArray("earthquake_area", "tag");

  while(true) {
    if(level flag::get("power_on")) {
      a_players = getplayers();

      foreach(player in a_players) {
        foreach(vol in var_b6596672) {
          if(isalive(player) && player istouching(vol)) {
            player function_bc82f900(#"hash_385053c55d081e0d");
            break;
          }
        }
      }
    }

    waitframe(1);
  }
}

function function_85bd89cb() {
  level endon(#"end_game");
  level flag::wait_till("start_zombie_round_logic");
  toy_horse_trigger = getent("toy_horse_trigger", "targetname");
  level thread scene::init(#"hash_4054de8e8701c4d");
  toy_horse_trigger waittill(#"trigger");
  level thread scene::play(#"hash_4054de8e8701c4d");
  toy_horse_trigger delete();
}

function waiting_for_next_dog_spawn(count, max) {
  default_wait = 2.75;

  if(level.dog_round_count == 1) {
    default_wait = 4;
  } else if(level.dog_round_count == 2) {
    default_wait = 3.5;
  } else if(level.dog_round_count == 3) {
    default_wait = 3;
  }

  if(isDefined(count) && isDefined(max)) {
    wait max(default_wait - count / max, 0.05);
    return;
  }

  wait max(default_wait - 0.5, 0.05);
}

function function_a6101b7() {
  if(util::get_game_type() == # "zclassic" || !is_true(getgametypesetting(#"hash_7e8e34cc69a77e0b")) && getdvarint(#"hash_40bd34b35079cf2e", 0) === 0) {
    hidemiscmodels("xmas_decorations");
    array::delete_all(getEntArray("xmas_decorations", "targetname"));
  }
}

function function_452e5ad6() {
  self endon(#"disconnect");

  if(level flag::get(#"hash_3b2ee17e5ce02f9e") && !level flag::get(#"hash_12a655d1c62ddb76")) {
    var_1a672bba = struct::get_array("zone_trans_north");
    s_player_spawn = array::random(var_1a672bba);
    return s_player_spawn;
  }

  spawn_points = zm_gametype::get_player_spawns_for_gametype();
  var_48f27f46 = array("zone_center_lower", "zone_center_upper_north", "zone_center_upper_west", "zone_center_upper");
  var_d117c934 = [];

  foreach(point in spawn_points) {
    if(is_true(level.var_ccf1f0ee) && !isinarray(var_48f27f46, point.script_noteworthy)) {
      continue;
    }

    if(zm_zonemgr::zone_is_enabled(point.script_noteworthy)) {
      if(!isDefined(var_d117c934)) {
        var_d117c934 = [];
      } else if(!isarray(var_d117c934)) {
        var_d117c934 = array(var_d117c934);
      }

      var_d117c934[var_d117c934.size] = point;
    }
  }

  var_7fc5b7c3 = arraysortclosest(var_d117c934, self.origin, 20, 0, 2000);
  var_5d59bb63 = arraysortclosest(var_d117c934, self.origin, 20, 1000, 2000);
  var_1a672bba = var_5d59bb63.size ? var_5d59bb63 : var_7fc5b7c3;
  s_player_spawn = array::random(var_1a672bba);
  return s_player_spawn;
}

function private function_ec9000ea() {
  level flag::wait_till("<dev string:x5c>");
  zm_devgui::add_custom_devgui_callback(&function_3ab942cb);
}

function private function_3ab942cb(cmd) {
  switch (cmd) {
    case # "hash_fc3b784a3c0b31d":
      level.var_61a89694 = 1;
      break;
    default:
      break;
  }
}