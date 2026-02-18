/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten.gsc
***********************************************/

#using script_18077945bb84ede7;
#using script_1bb327fbdb3a211b;
#using script_1cd534c7e79b126f;
#using script_270a16f0a470f2a6;
#using script_2a30ac7aa0ee8988;
#using script_2ddf7d76494fb52;
#using script_2f560596a9a134ab;
#using script_340a2e805e35f7a2;
#using script_3411bb48d41bd3b;
#using script_3a704cbcf4081bfb;
#using script_3e57cc1a9084fdd6;
#using script_448683444db21d61;
#using script_4ccfb58a9443a60b;
#using script_4ce5d94e8c797350;
#using script_58860a35d0555f74;
#using script_72d96920f15049b8;
#using script_744259b349d834c7;
#using script_76a8f964e4309959;
#using script_7b1cd3908a825fdd;
#using script_7d5c9b91cf8d272b;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_avogadro;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world_fixup;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scriptmodels_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\ai\zm_ai_avogadro;
#using scripts\zm\ai\zm_ai_mechz;
#using scripts\zm\ai\zm_ai_mimic;
#using scripts\zm\ai\zm_ai_soa;
#using scripts\zm\zm_ai_raz;
#using scripts\zm\zm_tungsten_audio;
#using scripts\zm\zm_tungsten_end_fight;
#using scripts\zm\zm_tungsten_fasttravel;
#using scripts\zm\zm_tungsten_gamemodes;
#using scripts\zm\zm_tungsten_hind_trap;
#using scripts\zm\zm_tungsten_main_quest;
#using scripts\zm\zm_tungsten_pap_quest;
#using scripts\zm\zm_tungsten_side_quest;
#using scripts\zm\zm_tungsten_side_quest_arcade_token;
#using scripts\zm\zm_tungsten_side_quest_shooting_gallery;
#using scripts\zm\zm_tungsten_vo;
#using scripts\zm\zm_tungsten_zones;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_tungsten;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_machine_count = 2;
  level.random_pandora_box_start = 1;
  level.var_e2f95698 = # "hash_30d01dde2ca22cfc";
  level.var_1d1a6e08 = 1;
  level.var_6b3764b5 = 15;
  setgametypesetting("zmEnableScoreStreakNapalmStrike", 0);
  namespace_1c7b37c6::item_remover(&item_world_fixup::remove_item, #"item_survival_scorestreak_napalm_strike");
}

function event_handler[level_init] main(eventstruct) {
  level.var_dfee7fc2 = # "hash_72c14048a8615869";
  level.var_f937a06e = 1;
  zm_intel::function_88645994(#"hash_2315f92412308649", undefined, undefined, undefined, undefined, #"zmintel_list_zm_tungsten_omega_intel_all", #"zmintel_list_zm_tungsten_darkaether_intel_all", #"zmintel_list_zm_tungsten_maxis_intel_all", #"zmintel_list_zm_tungsten_requiem_intel_all");
  callback::on_start_gametype(&zm_tungsten_fasttravel::start_fasttravel);
  callback::on_spawned(&on_player_spawned);
  zm::init_fx();
  namespace_297ae820::init();
  zm_tungsten_audio::init();
  zm_tungsten_fasttravel::init();
  zm_tungsten_pap_quest::init();
  zm_tungsten_main_quest::init();
  zm_tungsten_end_fight::init();
  namespace_8a08914c::init();
  zm_tungsten_side_quest::init();
  zm_tungsten_vo::init();
  namespace_edb23975::init();
  namespace_60bf0cf2::init();
  zm_tungsten_side_quest_shooting_gallery::init();
  register_clientfields = 1;

  if(register_clientfields) {
    clientfield::register_clientuimodel("player_lives", 1, 2, "int");
    clientfield::register("toplayer", "" + # "minimap_underground", 1, 1, "int");
    clientfield::register("scriptmover", "" + # "hash_16e5e4d2ea0716b7", 1, 2, "int");
    clientfield::register("scriptmover", "" + # "hash_575d68a64ff032b2", 1, 1, "counter");
    clientfield::register("toplayer", "" + # "hash_69dc133e22a2769f", 28000, 1, "int");
    clientfield::register("toplayer", "" + # "hash_4cb4c776a64a6cca", 28000, getminbitcountfornum(5), "int");
    clientfield::register("scriptmover", "" + # "hash_27556b053ce9a6a2", 1, 1, "counter");
    clientfield::register("toplayer", "" + # "hash_d4826b65faa9efb", 28000, 1, "int");
    clientfield::register("toplayer", "" + # "hash_4c2c37e44f9d6cf4", 28000, 2, "int");
    clientfield::register("toplayer", "" + # "music_underscore", 1, getminbitcountfornum(4), "int");
    clientfield::register("toplayer", "" + # "pstfx_sprite_rain_loop", 28000, getminbitcountfornum(2), "int");
    clientfield::register("world", "" + # "hash_763dd8035e80f7c", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_7b3ada6e5b1cf81e", 1, 1, "int");
    clientfield::register("toplayer", "" + # "hash_56c7e620d1de163a", 1, 1, "counter");
    clientfield::register("toplayer", "" + # "hash_4f232c4c4c5f7816", 1, 1, "int");
    clientfield::register("world", "" + # "hash_14197af7df70a497", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_6ecd61d493349ec0", 28000, getminbitcountfornum(2), "int");
    clientfield::register("scriptmover", "" + # "hash_431b27e4b133e650", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_1fb207d10fbe27ce", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_5a36f05cbdf2580", 28000, getminbitcountfornum(12), "int");
    clientfield::register("allplayers", "" + # "hash_3198b85c253e79d4", 28000, 1, "int");
    clientfield::register("actor", "" + # "hash_3e4641a9ea00d061", 28000, 1, "int");
    clientfield::register("world", "" + # "SetPBGExposureBank", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_7fd166b952515da7", 28000, 1, "int");
    clientfield::register("world", "" + # "hash_3e71bd47ea1a6144", 28000, 1, "int");
    clientfield::register("allplayers", "" + # "hash_73227fdae7d9bc0e", 28000, 2, "int");
    clientfield::register("vehicle", "" + # "hash_66006a74a4ab8b8e", 28000, 1, "int");
    clientfield::register("allplayers", "" + # "hash_1a529bb0de6717d5", 1, 1, "int");
  }

  clientfield::register("world", "" + # "hash_2a35f1483d5f5467", 1, 1, "int");
  clientfield::register("world", "" + # "hash_deec7a5e441c482", 1, 1, "int");
  level.default_start_location = "zone_helipads";
  level.default_game_mode = "zclassic";
  level._allow_melee_weapon_switching = 1;
  level.zombiemode_reusing_pack_a_punch = 1;
  level.var_88672174 = 119;
  level.var_5b8c6c9b = 120;
  level.var_f1662fe9 = 121;
  level.custom_spawner_entry[# "crawl"] = &zm_spawner::function_45bb11e4;
  level.var_d0ab70a2 = # "hash_415d2f1314ea548a";
  level.player_out_of_playable_area_monitor = 1;
  level.var_6f6cc58 = &function_6f6cc58;
  level.local_doors_stay_open = 1;
  level.var_1b57c9ca = 1;
  level.var_76e8fb05 = 1;
  level.var_dfe80386 = 1;
  level.var_24a62388 = &function_9bd5841;
  callback::on_rappel(&function_a648d1a6);
  callback::function_c16ce2bc(&function_dc9b097c);
  load::main();
  compass::setupminimap("");
  setDvar(#"hash_384191a42356d34", 1);
  setDvar(#"hash_64d8f355a9e6daa5", 1);
  setDvar(#"hash_2d56e13848a82d14", 0);
  setDvar(#"hash_b3395a8d3abf84a", 1);
  setDvar(#"hash_7b06b8037c26b99b", 100);
  level.var_f30c7ef1 = 1;
  level.var_e714f814 = 1;
  function_78e3584f((4850, 1778.25, -230), "zone_drinks_bar");
  function_78e3584f((4750, 1778.25, -230), "zone_drinks_bar");
  function_78e3584f((4850, 1778.25, -230), "zone_drinks_bar");
  function_78e3584f((4650, 1778.25, -230), "zone_drinks_bar");
  level.zones = [];
  level.zone_manager_init_func = &zm_tungsten_zones::zone_init;
  level thread zm_zonemgr::manage_zones("zone_helipads");
  level thread sndfunctions();
  level.addrbuff = &function_65c65feb;
  level.var_fc439a95 = # "ww_axe_gun_melee_t9";
  level flag::set(#"power_on");
  level flag::set("pause_round_timeout");
  level thread function_9a17632d();
  level.var_7f72eddd = "default_zombies_tungsten";
  level.var_dafeed10 = "exfil_tungsten_";
  level.var_8bb7479c = # "hash_477b4126fbff1de1";
  level.var_72a3d8bc = # "hash_4f5da795ab0a5fc";
  level.var_26ed6a07 = 600;
  level.var_c86f12d4 = 200;
  level.var_aaf7505f = 120;
  level.var_baed3b8e = 1750;
  level.var_ac94c2b8 = 2;
  level.var_495b36fa = &function_495b36fa;
  callback::add_callback(#"hash_594217387367ebb4", &function_d81240c3);
  namespace_591b4396::function_fa5bd408(array("zone_helipads", "zone_helipads_2", "zone_helipads_3", "zone_helipads_4"));
  level thread zm_perks::spare_change();
  namespace_471b2690::init();
  level thread function_24e89a46();
  level thread function_ae72b4d0(8);
  level thread function_9aa4197b(30);
  level thread function_7ee69673(12);
  level thread function_6227dac2(14, 16);
  level thread function_289c7852(15);
  level thread function_32401229(20);
  level thread function_9e6f187d(25);
  level thread function_df4859f();
  level thread function_43b0a4e2();
  level thread function_88a42ff9();

  level thread function_96aabf2f();

  level thread function_37597f29();

  level thread function_f2763418();
  level thread function_cee737a4();
  level thread function_4f3af205();
  level thread function_5e6cac2d();
  level thread function_2420f30f();
  level thread function_d4738f46();
  level.var_68e3cf24 = 1;
  level.var_fd959dcf = "chopper_gunner_vol_amerika";
  namespace_e8c18978::function_d887d24d("chopper_gunner_vol_helipads");
  level.var_33833303 = &function_33833303;
  level.var_19441a5a = &function_19441a5a;
  level.var_caddca10 = &function_6095b902;
  hidemiscmodels("ts_dark_aether_grass");
  namespace_1fd59e39::function_1376ec37((5531, 4217, 574), 300);
  namespace_1fd59e39::function_1376ec37((5544, 5747, 574), 300);
  player::function_31b5c778((2324, 1386, -275), 300);

  level thread function_5a3997b4();
}

function function_495b36fa(v_spawn) {
  if(isDefined(v_spawn) && zm_utility::check_point_in_playable_area(v_spawn) && !zm_zonemgr::function_74a82172(v_spawn, "zone_observation")) {
    return true;
  }

  return false;
}

function function_78e3584f(v_position, str_zone_name) {
  var_88dc621c = spawn("info_volume", v_position);

  if(isDefined(var_88dc621c)) {
    var_88dc621c.targetname = str_zone_name;
    var_88dc621c.script_noteworthy = "player_volume";
    var_88dc621c.var_5ac5060b = 1;
  }
}

function function_9a17632d() {
  level endon(#"end_game");

  while(true) {
    level waittill(#"start_of_round", #"power_on1");

    if(level.round_number >= 6 || level flag::get("power_on1")) {
      if(!level flag::get(#"hash_820c83920af16b7")) {
        level flag::clear("pause_round_timeout");
        break;
      }
    }
  }
}

function function_88a42ff9() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = level waittill(#"hash_e39eca74fa250b4");
    s_magic_box = s_waitresult.s_magic_box;

    if(!isDefined(s_magic_box.script_noteworthy)) {
      waitframe(1);
      continue;
    }

    switch (s_magic_box.script_noteworthy) {
      case # "hash_56d1c62d9d855079":
        s_magic_box function_b4abc0a1("map_box_loc_staging_area");
        break;
      case # "hash_4df315302311fca6":
        s_magic_box function_b4abc0a1("map_box_loc_storage_5");
        break;
      case # "hash_491b1052ddf51113":
        s_magic_box function_b4abc0a1("map_box_loc_storage_10");
        break;
      case # "hash_63575e63c86bf1be":
        s_magic_box function_b4abc0a1("map_box_loc_anytown_east");
        break;
      case # "hash_38c125278e00d34b":
        s_magic_box function_b4abc0a1("map_box_loc_anytown_west");
        break;
      case # "hash_367f50ca7e5de64e":
        s_magic_box function_b4abc0a1("map_box_loc_amplifier");
        break;
      case # "hash_6a534c1571dbef87":
        s_magic_box function_b4abc0a1("map_box_loc_tower");
        break;
      default:
        break;
    }
  }
}

function function_b4abc0a1(var_19eadb8b) {
  if(is_true(self.hidden)) {
    hidemiscmodels(var_19eadb8b);
    return;
  }

  showmiscmodels(var_19eadb8b);
}

function function_43b0a4e2() {
  level endon(#"end_game");
  level flag::wait_till_all(["start_zombie_round_logic", "connect_pizza_parlor"]);
  level clientfield::set("" + # "hash_3e71bd47ea1a6144", 1);
}

function function_963beb87() {
  level.random_pandora_box_start = 0;
  level.start_chest_name = "test_chest";
  level.open_chest_location = [];
  level.open_chest_location[0] = "test_chest";
  level.open_chest_location[1] = "test2_chest";
  level.open_chest_location[2] = "test3_chest";
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

function on_player_spawned() {
  self thread function_bf14bffe();
  self thread function_5e8470e6();
  self thread function_bce9fcbe();

  if(!is_true(self.is_hotjoining) && !self util::is_spectating()) {
    self thread function_a7ba2448();
    self thread function_daaf54cb();
    self.var_3487fff6 = undefined;
    self.var_1bfa91a = undefined;
    self.var_6dfeb5ef = &function_6eba65ea;
  }
}

function function_bce9fcbe() {
  self notify("70cd8db5742c01bf");
  self endon("70cd8db5742c01bf");
  level endon(#"end_game");
  self endon(#"disconnect", #"death");

  while(true) {
    var_e8178f0 = self zm_zonemgr::is_player_in_zone(level.var_707f916f);
    self clientfield::set_to_player("" + # "hash_69dc133e22a2769f", var_e8178f0);
    var_733eb37d = 0;
    str_player_zone = self zm_zonemgr::get_player_zone();

    if(isDefined(str_player_zone)) {
      switch (str_player_zone) {
        case # "zone_helipads_portal_room":
        case # "zone_helipads_3":
        case # "zone_helipads":
          var_733eb37d = 1;
          break;
        case # "zone_main_street_bridge":
        case # "zone_main_street_backlot":
          var_733eb37d = 2;
          break;
        case # "zone_video_store_roof":
        case # "zone_anytown_usa_backlot":
          var_733eb37d = 3;
          break;
        case # "zone_bunker_entrance_01":
        case # "zone_service_tunnels_03":
          var_733eb37d = 4;
          break;
        case # "zone_observation":
          var_733eb37d = 5;
          break;
      }
    }

    self clientfield::set_to_player("" + # "hash_4cb4c776a64a6cca", var_733eb37d);
    self waittill(#"zone_change");
  }
}

function sndfunctions() {
  zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
  level thread setup_personality_character_exerts();
  level thread setupmusic();
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][# "hitmed"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][# "hitmed"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][# "hitmed"] = "vox_plr_3_exert_pain";
  level.exert_sounds[4][# "hitmed"] = "vox_plr_4_exert_pain";
  level.exert_sounds[1][# "hitlrg"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][# "hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][# "hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[4][# "hitlrg"] = "vox_plr_3_exert_pain";
  level.exert_sounds[1][# "drowning"] = "vox_plr_1_exert_underwater_air_low";
  level.exert_sounds[2][# "drowning"] = "vox_plr_2_exert_underwater_air_low";
  level.exert_sounds[3][# "drowning"] = "vox_plr_3_exert_underwater_air_low";
  level.exert_sounds[4][# "drowning"] = "vox_plr_4_exert_underwater_air_low";
  level.exert_sounds[1][# "cough"] = "vox_plr_1_exert_gas_cough";
  level.exert_sounds[2][# "cough"] = "vox_plr_2_exert_gas_cough";
  level.exert_sounds[3][# "cough"] = "vox_plr_3_exert_gas_cough";
  level.exert_sounds[4][# "cough"] = "vox_plr_4_exert_gas_cough";
  level.exert_sounds[1][# "underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
  level.exert_sounds[2][# "underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
  level.exert_sounds[3][# "underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
  level.exert_sounds[4][# "underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
  level.exert_sounds[1][# "underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
  level.exert_sounds[2][# "underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
  level.exert_sounds[3][# "underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
  level.exert_sounds[4][# "underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

function setupmusic() {
  zm_audio::musicstate_create("round_start_first", 3, "round_start_first");
  zm_audio::musicstate_create("round_start", 3, "round_start_00", "round_start_01", "round_start_02");
  zm_audio::musicstate_create("round_end", 3, "round_end_00");
  zm_audio::musicstate_create("round_start_special", 3, "round_start_special_00");
  zm_audio::musicstate_create("round_end_special", 3, "round_end_special_00");
  zm_audio::musicstate_create("game_over", 5, "gameover_tungsten");
  zm_audio::musicstate_create("ee_song", 4, "egg");
  zm_audio::musicstate_create("flood_spawning", 3, "flood_spawning");
  zm_audio::function_e441162b("flood_spawning");
}

function function_65c65feb(b_active = 0) {
  if(b_active) {
    level thread zm_tungsten_audio::function_e2901362();
    return;
  }

  level thread zm_tungsten_audio::function_26113358();
}

function function_6f6cc58(e_player) {
  if(level flag::get(#"hash_2145c074d359b87d")) {
    return true;
  }

  if(isDefined(self) && isDefined(e_player)) {
    if(!isDefined(level.var_dff48402)) {
      level.var_dff48402 = [];
    }

    if(!isDefined(level.var_dff48402[e_player getentitynumber()]) || e_player.origin !== level.var_dff48402[e_player getentitynumber()].origin) {
      level.var_dff48402[e_player getentitynumber()] = {
        #zone: e_player zm_utility::get_current_zone(), #origin: e_player.origin
      };
    }

    zone_name = level.var_dff48402[e_player getentitynumber()].zone;

    if(zone_name === "zone_observation" || function_2fab3106(e_player)) {
      return false;
    }

    if(level flag::get(#"hash_3e765c26047c9f54")) {
      if(isinarray(level.var_ad5e81fe, zone_name)) {
        if(distance2dsquared(self.origin, e_player.origin) < 4000000) {
          return true;
        }
      }
    }

    if(isDefined(self.archetype) && isinarray([# "zombie", #"tormentor", #"raz", #"mimic", #"avogadro", #"abom", #"zombie_dog"], self.archetype)) {
      if(isPlayer(e_player)) {
        if(isDefined(self.v_zombie_custom_goal_pos) && isDefined(self.var_29656770)) {
          return true;
        }

        zone_path = zm_zonemgr::function_54fc7938(e_player, isDefined(self.cached_zone_name) ? self.cached_zone_name : self);

        if(isDefined(zone_path)) {
          return true;
        }
      }
    } else if(isPlayer(e_player) && self.archetype === # "soa") {
      zone_path = zm_zonemgr::function_54fc7938(e_player, isDefined(self.cached_zone_name) ? self.cached_zone_name : self);

      if(isDefined(zone_path)) {
        return true;
      }

      if(distance2dsquared(self.origin, e_player.origin) < sqr(500)) {
        return true;
      }

      return false;
    } else if(isPlayer(e_player) && self.archetype === # "mechz") {
      if(!is_true(self.var_7c4488fd)) {
        zone_name = isDefined(self.cached_zone_name) ? self.cached_zone_name : self zm_utility::get_current_zone();

        if(!isDefined(zone_name)) {
          zone_name = self.var_5e54763a;
        }

        zone_path = zm_zonemgr::function_54fc7938(e_player, zone_name);
        return isDefined(zone_path);
      }

      return true;
    } else {
      return true;
    }
  }

  return false;
}

function function_2fab3106(e_player) {
  if(isalive(e_player) && e_player isziplining()) {
    return true;
  }

  return false;
}

function private function_24e89a46() {
  level.fn_custom_zombie_spawner_selection = &function_ddc13fd6;
  level.zombie_spawners = array::sort_by_script_int(level.zombie_spawners, 1);
}

function function_ddc13fd6() {
  s_loc = array::random(level.zm_loc_types[# "zombie_location"]);
  var_87e4f82c = randomintrange(0, 100);
  var_b62ee10a = [0, 1];

  if(level.round_number >= 13 || level flag::get(#"hash_5fff608f0c23a53f")) {
    if(var_87e4f82c <= 5) {
      if(level.round_number < 30 && !level flag::get(#"hash_14ac8b5a5e403984")) {
        return level.zombie_spawners[2];
      } else if(math::cointoss()) {
        return level.zombie_spawners[3];
      } else {
        return level.zombie_spawners[2];
      }
    }
  }

  return level.zombie_spawners[array::random(var_b62ee10a)];
}

function private function_ae72b4d0(n_round) {
  zm_round_spawning::function_2876740e(#"tormentor", &function_d3687911);
  zm_cleanup::function_cdf5a512(#"tormentor", &function_d8461453);
  zm_round_spawning::function_306ce518(#"tormentor", &function_42885f70);
  level.var_97100fcf = n_round;
  zm_round_spawning::function_cc103b38(#"tormentor", n_round);
}

function private function_9aa4197b(n_round) {
  zm_round_spawning::function_2876740e(#"avogadro", &function_68ae7023);
  zm_cleanup::function_cdf5a512(#"avogadro", &function_1d78bd02);
  level.var_69f2520a = n_round;
  zm_round_spawning::function_cc103b38(#"avogadro", n_round);
  level.var_4e1942d2 = &function_d9f5ec34;
  level.var_c8827250 = &function_dc04aa1a;
}

function function_dc04aa1a(v_end_pos) {
  if(zm_utility::check_point_in_playable_area(v_end_pos) && !zm_zonemgr::function_74a82172(v_end_pos, "zone_observation")) {
    return true;
  }

  return false;
}

function private function_6227dac2(var_5ef83799, var_43416dd5) {
  if(is_true(level.is_forever_solo_game)) {
    n_round = var_43416dd5;
  } else {
    n_round = var_5ef83799;
  }

  zm_round_spawning::function_2876740e(#"abom", &function_48924a80);
  zm_cleanup::function_cdf5a512(#"abom", &function_1d787beb);
  level.var_9135c56e = n_round;
  zm_round_spawning::function_cc103b38(#"abom", n_round);
  level.var_eb59a95c = &function_30815e9d;
}

function private function_289c7852(n_round) {
  spawner::add_archetype_spawn_function(#"mimic", &function_64ed78df);
  zm_cleanup::function_cdf5a512(#"mimic", &function_5394f283);
  level.var_9583b85c = 15;
  level thread function_53555fd2();
}

function private function_7ee69673(n_round) {
  zm_round_spawning::function_2876740e(#"zombie_dog", &function_eaf01ea9);
  zm_round_spawning::function_cc103b38(#"zombie_dog", n_round);
  level.var_952c8793 = n_round;
  zm_round_spawning::function_306ce518(#"zombie_dog", &function_1ec597c3);
  spawner::function_89a2cd87(#"zombie_dog", &namespace_85745671::function_2089690e);
}

function private function_32401229(n_round) {
  zm_round_spawning::function_2876740e(#"soa", &function_76a7a9ef);
  zm_cleanup::function_cdf5a512(#"soa", &function_817bfebd);
  zm_round_spawning::function_306ce518(#"soa", &function_2927859c);
  level.var_a1c6ba48 = n_round;
  zm_round_spawning::function_cc103b38(#"soa", n_round);
  level.var_194823e7 = &function_41a4961d;
  level.var_f9bb6f24 = &function_f9bb6f24;
}

function function_f9bb6f24() {
  return undefined;
}

function private function_9e6f187d(n_round) {
  zm_round_spawning::function_2876740e(#"raz", &function_d4f11e3c);
  zm_cleanup::function_cdf5a512(#"raz", &function_54993e2);
  zm_round_spawning::function_306ce518(#"raz", &function_f1355240);
  level.var_36678664 = n_round;
  zm_round_spawning::function_cc103b38(#"raz", n_round);
  level.var_2e33420c = &function_218424b3;
}

function function_218424b3(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "raz_location"]) && level.zm_loc_types[# "raz_location"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "raz_location"];
    } else {
      s_spawn_loc = array::random(level.zm_loc_types[# "raz_location"]);
    }
  }

  return s_spawn_loc;
}

function function_30815e9d(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "hash_b7c88561b5e9b2c"]) && level.zm_loc_types[# "hash_b7c88561b5e9b2c"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "hash_b7c88561b5e9b2c"];
    } else {
      s_spawn_loc = array::random(level.zm_loc_types[# "hash_b7c88561b5e9b2c"]);
    }
  }

  return s_spawn_loc;
}

function function_d9f5ec34(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "hash_2fe3f22c14b70850"]) && level.zm_loc_types[# "hash_2fe3f22c14b70850"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "hash_2fe3f22c14b70850"];
    } else {
      s_spawn_loc = array::random(level.zm_loc_types[# "hash_2fe3f22c14b70850"]);
    }
  }

  return s_spawn_loc;
}

function function_41a4961d(get_all = 0) {
  if(isDefined(level.zm_loc_types[# "hash_2fe3f22c14b70850"]) && level.zm_loc_types[# "hash_2fe3f22c14b70850"].size) {
    if(get_all) {
      s_spawn_loc = level.zm_loc_types[# "hash_2fe3f22c14b70850"];
    } else {
      locs = level.zm_loc_types[# "hash_2fe3f22c14b70850"];

      if(getplayers().size > 1) {
        var_a6c95035 = [];
        var_b0becd1e = namespace_19c99142::function_a64f7068();

        if(!isDefined(var_b0becd1e)) {
          return array::random(locs);
        }

        str_target_zone = var_b0becd1e zm_zonemgr::get_player_zone();

        if(!isDefined(str_target_zone)) {
          return array::random(locs);
        }

        target_zone = level.zones[str_target_zone];
        var_24f5d9f8 = array(target_zone.name);
        a_str_adj_zones = getarraykeys(target_zone.adjacent_zones);

        foreach(str_zone in a_str_adj_zones) {
          if(target_zone.adjacent_zones[str_zone].is_connected) {
            if(!isDefined(var_24f5d9f8)) {
              var_24f5d9f8 = [];
            } else if(!isarray(var_24f5d9f8)) {
              var_24f5d9f8 = array(var_24f5d9f8);
            }

            var_24f5d9f8[var_24f5d9f8.size] = str_zone;
          }
        }

        foreach(loc in locs) {
          if(array::contains(var_24f5d9f8, loc.zone_name)) {
            if(!isDefined(var_a6c95035)) {
              var_a6c95035 = [];
            } else if(!isarray(var_a6c95035)) {
              var_a6c95035 = array(var_a6c95035);
            }

            var_a6c95035[var_a6c95035.size] = loc;
          }
        }

        if(var_a6c95035.size === 0) {
          var_a6c95035 = locs;
        }

        s_spawn_loc = array::random(var_a6c95035);
      } else {
        s_spawn_loc = array::random(locs);
      }
    }
  }

  return s_spawn_loc;
}

function function_48924a80(var_148cc603) {
  if(isDefined(level.var_9135c56e) && level.round_number < level.var_9135c56e) {
    return 0;
  }

  if(function_b05cfca9()) {
    return function_1bbe93bc(level.var_59adf71, var_148cc603);
  }

  level.var_9135c56e = level.round_number + 1;
  return 0;
}

function function_68ae7023(var_148cc603) {
  if(isDefined(level.var_69f2520a) && level.round_number < level.var_69f2520a) {
    return 0;
  }

  if(function_b05cfca9()) {
    return function_cf877849(var_148cc603);
  }

  level.var_69f2520a = level.round_number + 1;
  return 0;
}

function function_76a7a9ef(var_148cc603) {
  if(isDefined(level.var_a1c6ba48) && level.round_number < level.var_a1c6ba48) {
    return 0;
  }

  if(function_b05cfca9()) {
    return function_cf877849(var_148cc603);
  }

  level.var_a1c6ba48 = level.round_number + 1;
  return 0;
}

function function_a613c599(var_148cc603) {
  if(isDefined(level.var_8c1fa240) && level.round_number < level.var_8c1fa240) {
    return 0;
  }

  if(function_b05cfca9()) {
    return function_cf877849(var_148cc603);
  }

  level.var_8c1fa240 = level.round_number + 1;
  return 0;
}

function function_d4f11e3c(var_148cc603) {
  if(isDefined(level.var_36678664) && level.round_number < level.var_36678664) {
    return 0;
  }

  if(function_b05cfca9()) {
    return function_cf877849(var_148cc603);
  }

  level.var_36678664 = level.round_number + 1;
  return 0;
}

function function_d3687911(var_148cc603) {
  if(isDefined(level.var_97100fcf) && level.round_number < level.var_97100fcf) {
    return 0;
  }

  return function_cf877849(var_148cc603);
}

function function_eaf01ea9(var_148cc603) {
  if(isDefined(level.var_952c8793) && level.round_number < level.var_952c8793) {
    return 0;
  }

  return function_cf877849(var_148cc603);
}

function function_822214be(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_9c55e25a)) {
    level.var_9c55e25a = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"mimic")) {
      level.var_9c55e25a++;

      if(level.round_number <= 20) {
        level.var_8c1fa240 = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_8c1fa240 = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_42885f70(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_3bb8de45)) {
    level.var_3bb8de45 = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"tormentor")) {
      level.var_3bb8de45++;
      level.var_97100fcf = level.round_number + randomintrangeinclusive(1, 2);
    }
  }
}

function function_1ec597c3(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_b0e7164b)) {
    level.var_b0e7164b = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"zombie_dog")) {
      level.var_b0e7164b++;

      if(level.round_number <= 20) {
        level.var_952c8793 = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_952c8793 = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_2927859c(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_d8db349d)) {
    level.var_d8db349d = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"soa")) {
      level.var_d8db349d++;

      if(level.round_number <= 20) {
        level.var_a1c6ba48 = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_a1c6ba48 = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_f1355240(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_2f45d799)) {
    level.var_2f45d799 = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"raz")) {
      level.var_2f45d799++;
      n_player_count = zm_utility::function_a2541519(getplayers().size);

      if(n_player_count == 1) {
        level.var_36678664 = level.round_number + randomintrangeinclusive(2, 4);
        continue;
      }

      level.var_36678664 = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function function_cf877849(var_148cc603) {
  var_e5f0889c = 0.02;
  n_max = ceil(level.zombie_total * var_e5f0889c);
  return int(min(var_148cc603, n_max));
}

function function_1bbe93bc(var_64501ea4, var_148cc603) {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  if(n_player_count == 1) {
    switch (var_64501ea4) {
      case 0:
      case 1:
      case 2:
        var_2506688 = 1;
        var_1797c23a = 1;
        break;
      default:
        var_2506688 = 1;
        var_1797c23a = 2;
        break;
    }
  } else {
    switch (var_64501ea4) {
      case 0:
      case 1:
        var_2506688 = 1;
        var_1797c23a = 1;
        break;
      case 2:
      case 3:
        var_2506688 = 2;
        var_1797c23a = 2;
        break;
      default:
        var_2506688 = 3;
        var_1797c23a = 3;
        break;
    }
  }

  if(isDefined(var_148cc603)) {
    var_1797c23a = int(min(var_148cc603, var_1797c23a));
  }

  return randomintrangeinclusive(var_2506688, var_1797c23a);
}

function function_b05cfca9() {
  if(!isDefined(level.var_97be4fcf)) {
    level.var_97be4fcf = 0;
  }

  if(isinarray([8, 30, 12, 14, 16, 15, 20, 25], level.round_number)) {
    return false;
  }

  if(level.round_number < 20 && level.var_97be4fcf >= 1) {
    return false;
  }

  if(level.round_number < 30 && level.var_97be4fcf >= 2) {
    return false;
  }

  if(level.round_number < 50 && level.var_97be4fcf >= 3) {
    return false;
  }

  if(level.var_97be4fcf >= 4) {
    return false;
  }

  level.var_97be4fcf++;
  return true;
}

function function_df4859f() {
  level endon(#"end_game");

  while(true) {
    level waittill(#"end_of_round");
    level.var_97be4fcf = 0;
  }
}

function function_1d78bd02() {
  self endon(#"death");

  while(true) {
    var_31f7011a = arraysortclosest(getplayers(), self.origin);

    foreach(player in var_31f7011a) {
      if(zm_utility::is_player_valid(player)) {
        closest_player = player;
        break;
      }
    }

    if(isDefined(closest_player)) {
      break;
    }

    util::wait_network_frame();
  }

  s_spawn_locs = [];

  if(isDefined(level.var_4e1942d2)) {
    spawn_locs = [[level.var_4e1942d2]](1);

    if(isarray(spawn_locs)) {
      s_spawn_locs = spawn_locs;
    } else {
      array::add(s_spawn_locs, spawn_locs);
    }
  } else {
    spawn_locs = function_d9f5ec34(1);

    if(isarray(spawn_locs)) {
      s_spawn_locs = spawn_locs;
    }
  }

  var_69681a59 = [];

  if(isDefined(level.active_zone_names) && isarray(s_spawn_locs) && s_spawn_locs.size > 0) {
    foreach(spawn_loc in s_spawn_locs) {
      if(isDefined(spawn_loc.zone_name) && array::contains(level.active_zone_names, spawn_loc.zone_name)) {
        if(!isDefined(var_69681a59)) {
          var_69681a59 = [];
        } else if(!isarray(var_69681a59)) {
          var_69681a59 = array(var_69681a59);
        }

        var_69681a59[var_69681a59.size] = spawn_loc;
      }
    }
  }

  if(var_69681a59.size < 1) {
    return true;
  }

  spawn_points = arraysortclosest(var_69681a59, closest_player.origin, undefined, 500);

  if(spawn_points.size > 0) {
    var_b2aa54a9 = spawn_points[0];
  } else {
    var_b2aa54a9 = arraygetfarthest(closest_player.origin, var_69681a59);
  }

  if(isDefined(var_b2aa54a9)) {
    self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
  }

  return true;
}

function function_1d787beb() {
  if(isDefined(level.var_eb59a95c)) {
    var_d7eff26a = [[level.var_eb59a95c]]();
  } else {
    var_91562d8c = level.zm_loc_types[# "hash_b7c88561b5e9b2c"];

    if(isDefined(var_91562d8c.size)) {
      var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
    }
  }

  if(isentity(self) && isDefined(var_d7eff26a)) {
    self zm_ai_utility::function_a8dc3363(var_d7eff26a);
    self thread namespace_361e505d::function_940cd1d8();
  }

  return true;
}

function function_817bfebd() {
  self endon(#"death");
  closest_player = function_7d9eec0c(self);

  if(isDefined(closest_player)) {
    if(closest_player zm_utility::get_current_zone() === "zone_observation") {
      return true;
    }

    var_debfdbf5 = 10;

    while(var_debfdbf5 > 0 && isalive(closest_player)) {
      if(closest_player zm_utility::get_current_zone() === "zone_observation") {
        return true;
      }

      if(!function_6095b902(closest_player)) {
        return true;
      }

      point = getrandomnavpoint(closest_player.origin, 350);

      if(isDefined(point) && zm_utility::check_point_in_playable_area(point)) {
        angles = (0, vectortoyaw(closest_player.origin - point), 0);
        self forceteleport(self.origin, angles);
        self thread namespace_19c99142::function_940cd1d8();
        waitframe(1);
        zm_ai_utility::function_a8dc3363({
          #origin: point
        });
        self.completed_emerging_into_playable_area = 1;
        self.var_9817f19a = 0;
        break;
      }

      var_debfdbf5--;
      waitframe(1);
    }
  }

  return true;
}

function function_7d9eec0c(entity) {
  a_e_players = array::get_all_closest(entity.origin, function_a1ef346b());

  foreach(e_player in a_e_players) {
    if(!is_true(e_player.ignoreme) && !e_player isnotarget() && !e_player util::is_spectating() && function_6095b902(e_player)) {
      return e_player;
    }
  }

  return undefined;
}

function function_54993e2() {
  if(isDefined(level.var_2e33420c)) {
    var_d7eff26a = [[level.var_2e33420c]]();
  } else {
    var_91562d8c = level.zm_loc_types[# "raz_location"];

    if(var_91562d8c.size) {
      var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
    }
  }

  if(isentity(self) && isDefined(var_d7eff26a)) {
    self zm_ai_utility::function_a8dc3363(var_d7eff26a);
    self thread zm_ai_raz::function_1f9940b8();
  }

  return true;
}

function function_d8461453() {
  s_spawn_loc = namespace_abfee9ba::function_a58fe5b7();

  if(isDefined(self) && isentity(self) && isDefined(s_spawn_loc)) {
    self endon(#"death");
    level thread namespace_abfee9ba::function_55413772(s_spawn_loc);
    wait 1;
    self zm_ai_utility::function_a8dc3363(s_spawn_loc);
    earthquake(0.5, 0.75, self.origin, 1000);
    self.no_powerups = 1;

    if(isDefined(s_spawn_loc.script_string)) {
      self.script_string = s_spawn_loc.script_string;
      self.find_flesh_struct_string = s_spawn_loc.script_string;
    }
  }

  return true;
}

function function_53555fd2() {
  level endon(#"end_game");

  while(true) {
    level waittill(#"start_of_round");

    if(level.round_number >= 15) {
      break;
    }

    wait 1;
  }

  iprintlnbold("<dev string:x38>");

  level.var_3db96efc = struct::get_array("mimic_item_spawn_point");
  level.var_4096945a = level.round_number;
  var_4b2b783e = spawnStruct();
  var_4b2b783e.origin = (6272, 4981, 576);
  var_4b2b783e.radius = 900;
  var_4b2b783e.halfheight = 200;
  str_key = "targetname";
  str_value = "zone_observation_no_mimic_prop_node";
  var_4b2b783e.(str_key) = str_value;

  if(!isDefined(level.var_657bb3b3[str_key][str_value])) {
    level.var_657bb3b3[str_key][str_value] = [];
  } else if(!isarray(level.var_657bb3b3[str_key][str_value])) {
    level.var_657bb3b3[str_key][str_value] = array(level.var_657bb3b3[str_key][str_value]);
  }

  if(!isinarray(level.var_657bb3b3[str_key][str_value], var_4b2b783e)) {
    level.var_657bb3b3[str_key][str_value][level.var_657bb3b3[str_key][str_value].size] = var_4b2b783e;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(level.round_number < level.var_4096945a) {
      continue;
    }

    b_skipped = undefined;

    if(function_b05cfca9() || level.round_number === 15) {
      level thread function_9f46dbde();
    } else {
      b_skipped = 1;
      level.var_4096945a += 1;
    }

    level waittill(#"end_of_round");
    mimic_prop_spawn::function_fd24f982();

    if(!is_true(b_skipped)) {
      level.var_4096945a += randomintrange(2, 6);
    }
  }
}

function function_9f46dbde() {
  level endon(#"game_ended", #"end_of_round", #"hash_263cb0e9d84b0fa6");
  a_players = getplayers();

  switch (a_players.size) {
    case 1:
      var_fdb8ea91 = 1;
      var_99963ba3 = 3;
      break;
    case 2:
      var_fdb8ea91 = 1;
      var_99963ba3 = 3;
      break;
    case 3:
      var_fdb8ea91 = 2;
      var_99963ba3 = 4;
      break;
    default:
      var_fdb8ea91 = 2;
      var_99963ba3 = 4;
      break;
  }

  if(level.round_number < 30) {
    switch (a_players.size) {
      case 1:
        var_99963ba3 = 2;
        break;
      case 2:
        var_99963ba3 = 2;
        break;
      case 3:
        var_99963ba3 = 3;
        break;
      default:
        var_99963ba3 = 3;
        break;
    }
  }

  if(level.round_number < 15) {
    var_fdb8ea91 = 1;
    var_99963ba3 = 1;
  }

  level.var_a4642f0a = 0;
  function_6b214340(8);
  level thread function_ecf00b5(var_fdb8ea91, var_99963ba3);

  while(level.var_a4642f0a < var_99963ba3) {
    s_waitresult = level waittill(#"hash_6d7ff9f9ff07619c");
    level.var_a4642f0a += 1;
    var_93bd7be9 = s_waitresult.ai_mimic;
    var_322f4e77 = getaiarchetypearray(#"mimic");
    var_2c062b3e = mimic_prop_spawn::function_e82cee4e();
    var_68c93a8d = var_322f4e77.size + var_2c062b3e.size;

    if(var_322f4e77.size < var_fdb8ea91) {
      var_d3329483 = 8 - var_2c062b3e.size;

      if(var_d3329483 > 0) {
        function_6b214340(var_d3329483);
      }

      continue;
    }

    while(isDefined(var_93bd7be9.prop_array) && isDefined(var_93bd7be9.prop_array[0]) && isDefined(var_93bd7be9.prop_array[0].hidden_entities)) {
      waitframe(1);
    }

    mimic_prop_spawn::function_fd24f982();
  }
}

function function_6b214340(var_d3329483) {
  if(var_d3329483 < 1) {
    return;
  }

  var_a2134c4e = [];

  foreach(zone_key in level.zone_keys) {
    if(!isDefined(var_a2134c4e)) {
      var_a2134c4e = [];
    } else if(!isarray(var_a2134c4e)) {
      var_a2134c4e = array(var_a2134c4e);
    }

    if(!isinarray(var_a2134c4e, zone_key)) {
      var_a2134c4e[var_a2134c4e.size] = zone_key;
    }
  }

  var_71fc1453 = [];
  var_6dcebc54 = function_7b8e26b3(level.var_3db96efc, 0, "inClaimedLocation");

  foreach(s_spawn_point in level.var_3db96efc) {
    var_1d4c3ee8 = hash(s_spawn_point.script_noteworthy);

    if(isinarray(var_a2134c4e, var_1d4c3ee8) && !is_true(s_spawn_point.claimed)) {
      var_bbde0cda = 0;
      a_players = getplayers();
      var_100cd7d = function_72d3bca6(a_players, s_spawn_point.origin, undefined, undefined, 750);

      if(var_100cd7d.size < 1) {
        var_95ca13d1 = function_72d3bca6(a_players, s_spawn_point.origin, undefined, 750, 10000);

        if(var_95ca13d1.size > 0) {
          var_bbde0cda = 1;

          if(var_6dcebc54.size > 0) {
            var_1072e0bb = 0;
            var_e240bc30 = [];

            foreach(point in var_6dcebc54) {
              if(!isDefined(var_e240bc30)) {
                var_e240bc30 = [];
              } else if(!isarray(var_e240bc30)) {
                var_e240bc30 = array(var_e240bc30);
              }

              if(!isinarray(var_e240bc30, point.script_noteworthy)) {
                var_e240bc30[var_e240bc30.size] = point.script_noteworthy;
              }
            }

            if(!isinarray(var_e240bc30, s_spawn_point.script_noteworthy)) {
              var_f5682dc1 = arraygetclosest(s_spawn_point.origin, var_6dcebc54, 1200);

              if(isDefined(var_f5682dc1)) {
                var_1072e0bb = 1;
              }
            }
          } else {
            var_1072e0bb = 1;
          }

          if(var_bbde0cda && var_1072e0bb) {
            if(!isDefined(var_71fc1453)) {
              var_71fc1453 = [];
            } else if(!isarray(var_71fc1453)) {
              var_71fc1453 = array(var_71fc1453);
            }

            if(!isinarray(var_71fc1453, s_spawn_point)) {
              var_71fc1453[var_71fc1453.size] = s_spawn_point;
            }
          }
        }
      }
    }
  }

  for(i = 1; i <= var_d3329483; i++) {
    if(var_71fc1453.size > 0) {
      var_e933f1de = 0;

      if(var_71fc1453.size > 1) {
        var_e933f1de = randomint(var_71fc1453.size);
      }

      var_ed94ce04 = [];

      if(!isDefined(var_ed94ce04)) {
        var_ed94ce04 = [];
      } else if(!isarray(var_ed94ce04)) {
        var_ed94ce04 = array(var_ed94ce04);
      }

      if(!isinarray(var_ed94ce04, var_71fc1453[var_e933f1de])) {
        var_ed94ce04[var_ed94ce04.size] = var_71fc1453[var_e933f1de];
      }

      mimic_prop_spawn::function_b309db61(var_ed94ce04, undefined, var_ed94ce04[0]);
      var_e969bf8e = array::get_all_closest(var_ed94ce04[0].origin, var_71fc1453, undefined, undefined, 1200);

      if(is_true(1)) {
        foreach(spawn_point in var_71fc1453) {
          if(spawn_point.script_noteworthy === var_ed94ce04[0].script_noteworthy) {
            arrayremovevalue(var_71fc1453, spawn_point);
          }
        }
      }

      if(var_e969bf8e.size > 0) {
        foreach(loc in var_e969bf8e) {
          arrayremovevalue(var_71fc1453, loc);
        }
      }

      wait 0.5;
      continue;
    }

    println("<dev string:x4e>");
  }
}

function function_ecf00b5(var_fdb8ea91, var_99963ba3) {
  level endon(#"game_ended", #"end_of_round", #"hash_263cb0e9d84b0fa6");

  while(true) {
    a_players = function_a1ef346b();
    var_b568a31a = 0;
    var_1c4ca328 = 0;
    var_6dbe2ba3 = 0;
    var_64b8549e = 0;
    var_ce5c1431 = 0;
    var_a214bc86 = 0;
    var_84efce87 = 0;
    var_329d5499 = 0;
    var_55bdf746 = 0;

    foreach(player in a_players) {
      if(player zm_zonemgr::is_player_in_zone(level.var_dc2ca204, 0)) {
        var_1c4ca328 += 1;
      }

      if(player zm_zonemgr::is_player_in_zone(level.var_65c43c31, 0)) {
        var_b568a31a += 1;
      }

      if(player zm_zonemgr::is_player_in_zone(level.var_6097ff89, 0)) {
        var_6dbe2ba3 += 1;
      }

      if(player zm_zonemgr::is_player_in_zone(level.var_2f941a56, 0)) {
        var_64b8549e += 1;
      }
    }

    if(var_1c4ca328 <= 0) {
      var_a214bc86 = function_8937f221(level.var_dc2ca204);
    }

    if(var_b568a31a <= 0) {
      var_84efce87 = function_8937f221(level.var_65c43c31);
    }

    if(var_6dbe2ba3 <= 0) {
      var_329d5499 = function_8937f221(level.var_6097ff89);
    }

    if(var_64b8549e <= 0) {
      var_55bdf746 = function_8937f221(level.var_2f941a56);
    }

    var_ce5c1431 = var_a214bc86 + var_84efce87 + var_329d5499 + var_55bdf746;
    var_322f4e77 = getaiarchetypearray(#"mimic");
    var_2c062b3e = mimic_prop_spawn::function_e82cee4e();
    var_68c93a8d = var_322f4e77.size + var_2c062b3e.size;

    if(var_322f4e77.size < var_fdb8ea91 && level.var_a4642f0a < var_99963ba3) {
      var_d3329483 = 8 - var_2c062b3e.size;

      if(var_d3329483 > 0) {
        function_6b214340(var_d3329483);
      }
    }

    wait 1;
  }
}

function function_8937f221(a_str_zone_names) {
  arrayremovevalue(level.var_5fafe5ac, undefined);
  var_656150d9 = 0;

  foreach(prop in level.var_5fafe5ac) {
    zone = zm_zonemgr::get_zone_from_position(prop.origin, 1, 1);

    if(!isDefined(zone) || isinarray(a_str_zone_names, zone)) {
      level thread mimic_prop_spawn::clean_up_prop(prop);
      var_656150d9 += 1;
    }
  }

  return var_656150d9;
}

function function_64ed78df() {
  self callback::function_d8abfc3d(#"hash_29cb63a7ebb5d699", &function_b7bf6e96);
  self callback::function_d8abfc3d(#"hash_484127e0cbd8f8cb", &function_64515cbe);
}

function function_b7bf6e96(prop) {
  self.var_126d7bef = 1;
  self.ignore_enemy_count = 1;
}

function function_64515cbe(params) {
  self.var_126d7bef = 0;
  self.ignore_enemy_count = 0;
  level notify(#"hash_6d7ff9f9ff07619c", {
    #ai_mimic: self
  });
}

function function_5394f283() {
  if(is_true(self.never_hide)) {
    b_result = self zm_ai_mimic::mimic_cleanup_teleport();
  } else {
    b_result = self function_ce42b67b();
  }

  if(is_true(b_result)) {
    self.completed_emerging_into_playable_area = 1;
  }

  return is_true(b_result);
}

function function_ce42b67b() {
  level endon(#"end_game");
  self endon(#"death");
  spawn_points = zm_ai_mimic::function_64aa9d51();

  if(!isarray(spawn_points) || !spawn_points.size) {
    self.b_ignore_cleanup = 0;
    return false;
  }

  var_b2aa54a9 = spawn_points[randomint(spawn_points.size)];
  self zm_ai_utility::function_a8dc3363(var_b2aa54a9);

  if(isDefined(self.prop_array)) {
    foreach(prop in self.prop_array) {
      level thread mimic_prop_spawn::clean_up_prop(prop);
    }

    arrayremovevalue(self.prop_array, undefined);
  }

  self.should_hide = 1;
  return true;
}

function function_cee737a4() {
  level flag::wait_till(#"hash_79bb6bfeda6a5c");
  s_zone = struct::get("s_radiation_zone");
  level.var_73f7a821 = spawn("trigger_radius", s_zone.origin, 0, s_zone.radius, s_zone.height);
  callback::on_spawned(&function_642c3b7a);
  level thread function_15a94953();
}

function function_642c3b7a() {
  self notify("56dd1da47b66f4a0");
  self endon("56dd1da47b66f4a0");
  level endon(#"end_game", #"hash_cee0ebf9c123cb9");
  self endon(#"death", #"disconnect");

  if(!isDefined(level.var_73f7a821)) {
    return;
  }

  level.var_73f7a821 endon(#"death");
  self.var_9493a52c = 0;
  level thread function_7dc5b077(self);
  level thread function_1d123acd();

  while(isDefined(self)) {
    while(isDefined(self) && isDefined(level.var_73f7a821) && !self istouching(level.var_73f7a821)) {
      waitframe(1);
    }

    function_5f6a508b(self);
    self function_70eca8d3();

    if(isDefined(self)) {
      self.var_9493a52c = 0;
    }

    function_882a2c43(self);
  }
}

function function_1d123acd() {
  level endon(#"end_game");
  level.var_d58a6548 = 45;
  level clientfield::set("" + # "hash_6ecd61d493349ec0", 1);
  level flag::wait_till(#"hash_3814c5c6793e2b2d");
  level.var_d58a6548 = 30;
  level clientfield::set("" + # "hash_6ecd61d493349ec0", 2);
}

function function_70eca8d3() {
  self notify("79ab7e9faf9a29cf");
  self endon("79ab7e9faf9a29cf");
  level endon(#"end_game", #"hash_cee0ebf9c123cb9");

  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"disconnect");
  timer = gettime() + int(level.var_d58a6548 * 1000);

  while(isDefined(self) && isDefined(level.var_73f7a821) && self istouching(level.var_73f7a821)) {
    if(is_true(self.laststand)) {
      timer = gettime() + int(level.var_d58a6548 * 1000);
    }

    if(gettime() > timer) {
      if(self clientfield::get_to_player("" + # "hash_4c2c37e44f9d6cf4") != 2) {
        self clientfield::set_to_player("" + # "hash_4c2c37e44f9d6cf4", 2);
      }

      function_46932caa(self);
    }

    waitframe(1);
  }
}

function function_7dc5b077(e_player) {
  self notify("569296e552bdc1cf");
  self endon("569296e552bdc1cf");
  level endon(#"end_game", #"hash_cee0ebf9c123cb9");

  if(!isDefined(e_player)) {
    return;
  }

  e_player waittill(#"death");
  function_882a2c43(e_player, 0);
}

function function_5f6a508b(e_player) {
  if(!isDefined(e_player) || e_player flag::get(#"hash_d4826b65faa9efb")) {
    return;
  }

  e_player flag::set(#"hash_d4826b65faa9efb");
  e_player clientfield::set_to_player("" + # "hash_d4826b65faa9efb", 1);
  e_player clientfield::set_to_player("" + # "hash_4c2c37e44f9d6cf4", 1);
}

function function_882a2c43(e_player, var_468fde99 = 1) {
  if(!isDefined(e_player) || var_468fde99 && !e_player flag::get(#"hash_d4826b65faa9efb")) {
    return;
  }

  e_player flag::clear(#"hash_d4826b65faa9efb");
  e_player clientfield::set_to_player("" + # "hash_d4826b65faa9efb", 0);
  e_player clientfield::set_to_player("" + # "hash_4c2c37e44f9d6cf4", 0);
}

function function_aa863ff1() {
  level notify(#"hash_cee0ebf9c123cb9");

  foreach(player in function_a1ef346b()) {
    level thread function_882a2c43(player, 0);
  }
}

function function_15a94953() {
  foreach(player in function_a1ef346b()) {
    player thread function_642c3b7a();
  }
}

function function_46932caa(e_player, var_98696959) {
  if(is_true(level.var_4da195fc)) {
    return;
  }

  if(!zm_utility::is_player_valid(e_player) || e_player flag::get(#"hash_5ff5159adfca3ce8")) {
    return;
  }

  e_player flag::set(#"hash_5ff5159adfca3ce8");
  level thread function_9bd73066(e_player);

  if(is_true(var_98696959)) {
    var_9493a52c = min(e_player.var_9493a52c + 1, 15);
    e_player.var_9493a52c = var_9493a52c;
    n_damage = 30;

    if(var_9493a52c <= 10) {
      n_damage = 15;

      if(var_9493a52c <= 5) {
        n_damage = 5;
      }
    }
  } else {
    n_damage = 10;
  }

  e_player dodamage(n_damage, e_player.origin);
  damageeffect = getstatuseffect(#"dot_dome_gas");
  e_player thread status_effect::status_effect_apply(damageeffect, undefined, e_player);
}

function function_9bd73066(e_player) {
  if(!isDefined(e_player)) {
    return;
  }

  wait 1;

  if(isDefined(e_player)) {
    e_player flag::clear(#"hash_5ff5159adfca3ce8");
  }
}

function function_4f3af205() {
  level endon(#"game_ended");
  level flag::wait_till("all_players_spawned");
  zombie_utility::set_zombie_var(#"below_world_check", -4000);
}

function function_5e6cac2d() {
  var_e102fb58 = getEntArray("local_electric_door", "script_noteworthy");

  foreach(var_76538601 in var_e102fb58) {
    var_76538601 sethintstring(#"hash_793db3dc20917334");
  }

  level flag::wait_till("power_on1");
  wait 5;

  foreach(var_76538601 in var_e102fb58) {
    if(isDefined(var_76538601)) {
      var_76538601 delete();
    }
  }
}

function function_bf14bffe() {
  self notify("63eba66124d8c2e");
  self endon("63eba66124d8c2e");
  level endon(#"end_game");
  self endon(#"death", #"disconnect", #"hash_7f3f3b496fcd3707");
  level flag::wait_till_all([# "load_main_complete", #"intro_scene_done"]);

  while(true) {
    var_1e8cb595 = undefined;

    if(self zm_zonemgr::is_player_in_zone(level.var_dc2ca204, 1)) {
      var_1e8cb595 = bullettracepassed(self.origin, self.origin + (0, 0, 10000), 0, self);
    }

    if(is_true(var_1e8cb595) && !self flag::get(#"hash_1561f2d74277f5a1") && !is_true(self.var_16735873)) {
      self flag::set(#"hash_1561f2d74277f5a1");
      self clientfield::set_to_player("" + # "pstfx_sprite_rain_loop", 1);
    } else if(!is_true(var_1e8cb595) && self flag::get(#"hash_1561f2d74277f5a1")) {
      if(is_true(self.var_16735873)) {
        n_value = 2;
      } else {
        n_value = 0;
      }

      self flag::clear(#"hash_1561f2d74277f5a1");
      self clientfield::set_to_player("" + # "pstfx_sprite_rain_loop", n_value);
    }

    wait 1;
  }
}

function function_5e8470e6() {
  self notify("62f6d5fc71f19287");
  self endon("62f6d5fc71f19287");
  level endon(#"end_game");
  self endon(#"disconnect", #"death");
  var_1cf127f4 = 0;

  while(true) {
    if(var_1cf127f4) {
      if(!self zm_zonemgr::is_player_in_zone(level.var_dc2ca204)) {
        exploder::exploder_stop("fxexp_sky_lightning");
        var_1cf127f4 = 0;
      }
    } else if(self zm_zonemgr::is_player_in_zone(level.var_dc2ca204)) {
      exploder::exploder("fxexp_sky_lightning");
      var_1cf127f4 = 1;
    }

    wait 1;
  }
}

function function_4af68b() {
  foreach(player in getplayers()) {
    player notify(#"hash_7f3f3b496fcd3707");
    player flag::clear(#"hash_1561f2d74277f5a1");
    player clientfield::set_to_player("" + # "pstfx_sprite_rain_loop", 0);
  }
}

function function_4cc5fca6() {
  level endon(#"end_game");
  level clientfield::set("" + # "hash_7b3ada6e5b1cf81e", 1);
  array::wait_till(function_a1ef346b(), "fasttravel_over", 15);
  level clientfield::set("" + # "hash_7b3ada6e5b1cf81e", 0);
}

function function_a648d1a6() {
  self val::set(#"hash_29bdcb17a4141af3", "freezecontrols", 1);
}

function function_dc9b097c() {
  self val::reset(#"hash_29bdcb17a4141af3", "freezecontrols");
  self notify(#"rappel_end");
}

function private function_6eba65ea() {
  gender = self getplayergendertype();

  if(gender === "female") {
    self clientfield::set("" + # "hash_73227fdae7d9bc0e", 2);
  } else {
    self clientfield::set("" + # "hash_73227fdae7d9bc0e", 1);
  }

  self thread function_7015204c();
}

function private function_7015204c(timeout = 5) {
  level endon(#"end_game");
  self endon(#"disconnect");
  self notify("7a74d15d9a11019f");
  self endon("7a74d15d9a11019f");
  self waittilltimeout(timeout, #"death", #"rappel_end");
  self clientfield::set("" + # "hash_73227fdae7d9bc0e", 0);
}

function function_2420f30f() {
  var_f45b8196 = getEntArray("amp_rotate", "targetname");

  foreach(var_34f6451 in var_f45b8196) {
    if(isDefined(var_34f6451.script_int)) {
      n_rotate = var_34f6451.script_int;
      var_34f6451 rotate((0, 0, n_rotate));
    }
  }
}

function function_2a73b31d() {
  self val::set(#"hash_4360dc823467440d", "takedamage", 0);
  self val::set(#"hash_4360dc823467440d", "freezecontrols", 1);
  self val::set(#"hash_4360dc823467440d", "show_crosshair", 0);
  self val::set(#"hash_4360dc823467440d", "show_weapon_hud", 0);
}

function function_202a6698() {
  self val::reset(#"hash_4360dc823467440d", "takedamage");
  self val::reset(#"hash_4360dc823467440d", "freezecontrols");
  self val::reset(#"hash_4360dc823467440d", "show_crosshair");
  self val::reset(#"hash_4360dc823467440d", "show_weapon_hud");
}

function function_d81240c3() {
  level endon(#"game_ended");

  while(!isDefined(level.var_117d5f10)) {
    waitframe(1);
  }

  level.var_117d5f10 clientfield::set("" + # "hash_66006a74a4ab8b8e", 1);
  level waittill(#"exfil_complete");
  level.var_117d5f10 clientfield::set("" + # "hash_66006a74a4ab8b8e", 0);
}

function function_96aabf2f() {
  if(!zm_utility::is_ee_enabled()) {
    return;
  }

  util::waittill_can_add_debug_command();
  util::add_devgui("<dev string:x97>", "<dev string:xba>");
  util::add_devgui("<dev string:xe0>", "<dev string:x102>");
  util::add_devgui("<dev string:x127>", "<dev string:x149>");
  util::add_devgui("<dev string:x171>", "<dev string:x197>");
  level flag::wait_till_all([# "intro_scene_done", "<dev string:x1c3>", "<dev string:x1da>"]);
  wait 2;
  level thread function_9b92c023();
}

function function_9b92c023() {
  while(true) {
    if(getdvarint(#"hash_3e6a88037f209b4d", 0) > 0) {
      if(!is_true(level.var_2c5f3bcc)) {
        level function_dd3953d3();
        level.var_2c5f3bcc = 1;
      }

      setDvar(#"hash_3e6a88037f209b4d", 0);
    }

    if(getdvarint(#"hash_67ec344c88ecfcb", 0)) {
      if(!is_true(level.var_a522b20f)) {
        foreach(player in function_a1ef346b()) {
          player function_e6b581e7(1);
        }

        level.var_a522b20f = 1;
      }

      setDvar(#"hash_67ec344c88ecfcb", 0);
    }

    if(getdvarint(#"hash_53838e0bdbb2e257", 0)) {
      if(!is_true(level.var_4935bf9d)) {
        foreach(player in function_a1ef346b()) {
          player function_e6b581e7(0);
        }

        level.var_4935bf9d = 1;
      }

      setDvar(#"hash_53838e0bdbb2e257", 0);
    }

    if(getdvarint(#"hash_651f2f99447aa462", 0)) {
      if(!is_true(level.var_c3788074)) {
        level function_e4146082();
        level.var_c3788074 = 1;
      }

      setDvar(#"hash_651f2f99447aa462", 0);
    }

    if(getdvarint(#"hash_fac5f738960a49a", 0)) {
      if(!is_true(level.var_438ef12b)) {
        level function_f2a98fbe();
        level.var_438ef12b = 1;
      }

      setDvar(#"hash_fac5f738960a49a", 0);
    }

    if(getdvarint(#"hash_3a77e7ad0025555d", 0) > 0) {
      if(!is_true(level.var_d8315268)) {
        n_round = getdvarint(#"hash_3a77e7ad0025555d", 0);
        level thread zombie_devgui_goto_round(n_round);
        level.var_d8315268 = 1;
      }

      setDvar(#"hash_3a77e7ad0025555d", 0);
    }

    waitframe(3);
  }
}

function function_dd3953d3() {
  level function_58f27026();
  level thread function_42f2b8ac();
  level thread function_81acf2cf();

  switch (getdvarint(#"hash_3e6a88037f209b4d", 0)) {
    case 1:
    default:
      step_name = # "hash_2cec5bd1113224f4";
      break;
    case 2:
      step_name = # "collect_parts";
      break;
    case 3:
      step_name = # "hash_434b5ee7bea53369";
      break;
    case 4:
      step_name = # "hash_31740aafc81f583a";
      break;
    case 5:
      step_name = # "escort";
      break;
    case 6:
      step_name = # "end_fight";
      break;
    case 7:
      step_name = # "outro";
      break;
  }

  level function_284985a5(#"tungsten_main_quest", step_name);
}

function zombie_devgui_goto_round(target_round) {
  player = getplayers()[0];

  if(target_round < 1) {
    target_round = 1;
  }

  level.devcheater = 1;
  level.zombie_total = 0;
  level.zombie_health = isDefined(level.var_41dd92fd[# "zombie"].health) ? level.var_41dd92fd[# "zombie"].health : 100;
  zm_round_logic::set_round_number(target_round - 1);

  if(isDefined(level.var_e63636af)) {
    [[level.var_e63636af]](target_round - 1);
  }

  level notify(#"kill_round");
  wait 1;
  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(is_true(zombies[i].ignore_devgui_death)) {
        continue;
      }

      zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
    }
  }
}

function function_58f27026() {
  setDvar(#"zombie_unlock_all", 1);
  level flag::set("<dev string:x1f6>");
  level clientfield::set("<dev string:x202>", 1);
  power_trigs = getEntArray("<dev string:x215>", "<dev string:x228>");

  foreach(trig in power_trigs) {
    if(isDefined(trig.script_int)) {
      level flag::set("<dev string:x1f6>" + trig.script_int);
      level clientfield::set("<dev string:x202>", trig.script_int + 1);
    }
  }

  players = getplayers();

  foreach(player in players) {
    player zm_score::add_to_player_score(100000);
    player namespace_2a9f256a::function_afab250a(100000);
    player namespace_2a9f256a::function_a6d4221f(100000);
  }

  zombie_doors = getEntArray("<dev string:x236>", "<dev string:x228>");

  for(i = 0; i < zombie_doors.size; i++) {
    if(!is_true(zombie_doors[i].has_been_opened)) {
      zombie_doors[i] notify(#"trigger", {
        #activator: players[0]
      });
    }

    if(is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
      zombie_doors[i] notify(#"power_on");
    }

    waitframe(1);
  }

  zombie_airlock_doors = getEntArray("<dev string:x245>", "<dev string:x228>");

  for(i = 0; i < zombie_airlock_doors.size; i++) {
    zombie_airlock_doors[i] notify(#"trigger", {
      #activator: players[0]
    });
    waitframe(1);
  }

  zombie_debris = getEntArray("<dev string:x25b>", "<dev string:x228>");

  for(i = 0; i < zombie_debris.size; i++) {
    if(isDefined(zombie_debris[i])) {
      zombie_debris[i] notify(#"trigger", {
        #activator: players[0]
      });
    }

    waitframe(1);
  }

  level notify(#"open_sesame");
  wait 1;
  setDvar(#"zombie_unlock_all", 0);
}

function function_42f2b8ac() {
  level flag::set("<dev string:x1f6>");
  zm_power::turn_power_on_and_open_doors(1, 0);
}

function function_81acf2cf() {
  level flag::wait_till("<dev string:x1da>");
  ee = level._ee[# "pap_quest"];

  while(!is_true(ee.started)) {
    waitframe(1);
  }

  level thread function_abae9b3f(#"pap_quest");
  level flag::set("<dev string:x26c>");
  zm_tungsten_zones::function_2d12df62();
}

function function_abae9b3f(ee_name) {
  self endon(ee_name + "<dev string:x287>");
  ee = self._ee[ee_name];

  if(ee.started) {
    for(i = 0; i <= ee.steps.size; i++) {
      while(ee.current_step <= i) {
        ee.steps[ee.current_step] notify(#"end_early");
        wait 0.5;
      }
    }

    return;
  }

  iprintlnbold("<dev string:x295>");
}

function function_e6b581e7(var_9ff20235) {
  level flag::wait_till("<dev string:x1f6>");
  start_weapon = self getcurrentweapon();
  self thread function_40985978(start_weapon);

  if(is_true(var_9ff20235)) {
    var_7625b6cc = "<dev string:x2b0>";
    var_27751b99 = 3;
  } else {
    var_7625b6cc = "<dev string:x2c8>";
    var_27751b99 = 1;
  }

  if(isDefined(start_weapon) && isDefined(start_weapon.name)) {
    str_weapon_name = start_weapon.name;
  } else {
    str_weapon_name = array::random(["<dev string:x2e0>", "<dev string:x2f2>", "<dev string:x302>", "<dev string:x314>", "<dev string:x326>", "<dev string:x33a>"]);
  }

  self function_749d2cfc(hash(str_weapon_name + var_7625b6cc), var_27751b99);
  self waittill(#"hash_69358718466f2118");
}

function function_40985978(start_weapon) {
  self waittill(#"aat_acquired");

  if(getdvarint(#"hash_651f2f99447aa462", 0) || getdvarint(#"hash_fac5f738960a49a", 0)) {
    weapon_list = self getweaponslistprimaries();

    foreach(weapon in weapon_list) {
      if(weapon == start_weapon) {
        self switchtoweaponimmediate(weapon);
        self waittill(#"weapon_change_complete");
      }
    }
  }

  self thread zm_perks::function_29387491(#"hash_47d7a8105237c88");
  self thread zm_perks::function_29387491(#"hash_38c08136902fd553");
  self thread zm_perks::function_29387491(#"talent_deadshot");
  self thread zm_perks::function_29387491(#"talent_quickrevive");

  if(is_true(getgametypesetting(#"hash_4b8929fb898a9e80"))) {
    self thread zm_perks::function_29387491(#"talent_phdslider");
  }

  str_item_name = namespace_f999c142::function_ff28876a(3);
  self namespace_f999c142::function_923efc48(str_item_name, 3);
  self namespace_1cc7b406::give_item(#"armor_item_lv3_t9_sr");
  self notify(#"hash_69358718466f2118");
}

function function_749d2cfc(str_item_name, var_27751b99) {
  self endon(#"disconnect");

  if(!isDefined(str_item_name)) {
    return;
  }

  point = function_4ba8fde(str_item_name);

  if(isDefined(point) && isDefined(var_27751b99) && isDefined(level.var_fee1eaaf)) {
    new_item = [[level.var_fee1eaaf]](point);

    if(isDefined(new_item)) {
      point = new_item;
      point.paplv = var_27751b99;
    }
  }

  if(isDefined(point.itementry.random_attachments)) {
    weapon = namespace_65181344::function_67456242(point.itementry);
    dropitem = item_drop::drop_item(0, weapon, 1, weapon.maxammo, point.id, self.origin, self.angles, 1);
    dropitem.var_519e776c = 1;
    dropitem.hidetime = 1;
    dropitem hide();
    self zm_weapons::function_98776900(dropitem, 0, 0, 1);
  } else {
    self zm_weapons::function_98776900(point, 0, 0, 1);
  }

  if(isDefined(var_27751b99)) {
    self item_inventory::function_d92c6b5b(self.currentweapon, 0);
    maxammo = self.currentweapon.maxammo;
    maxclip = self getclipsize(self.currentweapon);
    self setweaponammoclip(self.currentweapon, maxclip);
    self setweaponammostock(self.currentweapon, maxammo);
    self notify(#"hash_75ec9942d2d5fd0f");
  }

  self waittill(#"weapon_change_complete");
  self function_fc6ae19f();
}

function function_fc6ae19f() {
  var_36cb1235 = array::random(["<dev string:x34a>", "<dev string:x356>", "<dev string:x364>", "<dev string:x370>", "<dev string:x380>"]);
  aat_name = "<dev string:x38f>" + var_36cb1235 + "<dev string:x39b>";
  currentweapon = self item_inventory::get_current_weapon();
  var_4657c1e0 = self item_inventory::function_230ceec4(currentweapon);
  self zm_weapons::function_37e9e0cb(var_4657c1e0, currentweapon, aat_name);
}

function function_e4146082() {
  foreach(player in function_a1ef346b()) {
    player function_86af79f6();
  }
}

function function_86af79f6() {
  self endon(#"disconnect", #"death");

  while(self zm_utility::is_drinking()) {
    wait 0.1;
  }

  self zm_weapons::weapon_give(getweapon("<dev string:x3a1>"), 1);
}

function function_f2a98fbe() {
  foreach(player in function_a1ef346b()) {
    player thread function_e4462dce();
  }
}

function function_e4462dce() {
  self endon(#"disconnect", #"death");

  while(self zm_utility::is_drinking()) {
    wait 0.1;
  }

  self zm_weapons::weapon_give(getweapon(#"ww_axe_gun_melee_t9"), 1);
}

function function_284985a5(ee_name, step_name) {
  ee = self._ee[ee_name];
  step_index = zm_sq::function_9212ff4d(ee_name, step_name);

  if(ee.started && step_index <= ee.current_step) {
    return 0;
  }

  ee.skip_to_step = step_index;

  if(ee.started) {
    function_905781df(ee_name);
  } else {
    level zm_sq::start(ee.name);
  }

  return 1;
}

function function_905781df(ee_name) {
  ee = self._ee[ee_name];

  if(ee.started) {
    while(ee.current_step <= ee.skip_to_step - 1) {
      ee.steps[ee.current_step] notify(#"end_early");
      wait 0.5;
    }

    return;
  }

  iprintlnbold("<dev string:x295>");
}

function run_step(ee, step, var_5ea5c94d) {
  var_4ef8d79b = isentity(self);

  if(var_4ef8d79b) {
    self endon(#"death");
    self endon(#"disconnect");
  }

  self endon(#"game_ended");
  ee.started = 1;
  step.started = 1;
  self thread function_3f795dc3(ee, step, var_5ea5c94d);

  if(!step.completed) {
    waitresult = self waittill(step.var_e788cdd7 + "<dev string:x3ac>", step.var_e788cdd7 + "<dev string:x3c0>");
  }

  if(game.state === # "postgame") {
    return;
  }

  ended_early = isDefined(waitresult) && waitresult._notify == step.var_e788cdd7 + "<dev string:x3c0>";
  [[step.cleanup_func]](var_5ea5c94d, ended_early);
  step.cleaned_up = 1;

  if(game.state === # "postgame") {
    return;
  }

  self flag::set(step.var_e788cdd7 + "<dev string:x287>");

  if(isDefined(step.next_step)) {
    var_5ea5c94d = 0;
    ee.current_step++;
    self thread run_step(ee, step.next_step, var_5ea5c94d);
    return;
  }

  ee.completed = 1;
  self flag::set(ee.name + "<dev string:x287>");
}

function private function_3f795dc3(ee, step, var_5ea5c94d) {
  if(isentity(self)) {
    self endon(#"death");
    self endon(#"disconnect");
  }

  self endon(#"game_ended");
  step endoncallback(&function_df365859, #"end_early");
  self notify(step.var_e788cdd7 + "<dev string:x3d0>");

  if(isDefined(step.var_6cc77d4e)) {
    level zm_sq::objective_set(step.var_6cc77d4e, step.a_targets, undefined, step.var_441061cd);
  }

  [[step.setup_func]](var_5ea5c94d);
  step.completed = 1;

  if(isDefined(step.var_6cc77d4e)) {
    level zm_sq::objective_complete(step.var_6cc77d4e, step.a_targets);
  }

  self notify(step.var_e788cdd7 + "<dev string:x3ac>");
}

function private function_df365859(notifyhash) {
  self.completed = 1;

  if(isDefined(self.var_6cc77d4e)) {
    level zm_sq::objective_complete(self.var_6cc77d4e, self.a_targets);
  }

  waittillframeend();
  self.ee.owner notify(self.var_e788cdd7 + "<dev string:x3c0>");
  self.ee.owner notify(self.var_e788cdd7 + "<dev string:x3ac>");
}

function function_23031ae8(ee_name, var_f2c264bb) {
  if(isentity(self)) {
    self endon(#"death");
    self endon(#"disconnect");
  }

  self endon(#"game_ended");
  ee = self._ee[ee_name];
  step = ee.steps[var_f2c264bb];

  if(function_284985a5(ee_name, step.name)) {
    if(!step.started) {
      wait_time = 10 * ee.steps.size;
      waitresult = self waittilltimeout(wait_time, step.var_e788cdd7 + "<dev string:x3d0>");

      if(waitresult._notify == # "timeout") {
        iprintlnbold("<dev string:x3dc>" + function_9e72a96(ee_name) + "<dev string:x407>" + function_9e72a96(ee.steps[ee.current_step].name));

        return;
      }
    }

    wait 1;
  }

  iprintlnbold("<dev string:x40c>" + function_9e72a96(ee.name) + "<dev string:x407>" + function_9e72a96(ee.steps[ee.current_step].name) + "<dev string:x41b>");

  function_905781df(ee_name);
}

function function_33833303() {}

function function_a7ba2448() {
  self notify("4f7b72ae6859de44");
  self endon("4f7b72ae6859de44");
  level endon(#"end_game");
  self endon(#"death", #"disconnect");

  while(true) {
    util::waittill_any_ents(self, "zone_change", level, "end_of_round");

    if(self.cached_zone_name === "zone_burger_town") {
      var_b7f7d612 = level.round_number;

      while(self.cached_zone_name === "zone_burger_town") {
        util::waittill_any_ents(self, "zone_change", level, "end_of_round");

        if(level.round_number - var_b7f7d612 >= 5) {
          self zm_stats::increment_challenge_stat(#"hash_78e5512f079af452");
          return;
        }
      }
    }
  }
}

function function_daaf54cb() {
  self notify("1bc26dd6b1de740d");
  self endon("1bc26dd6b1de740d");
  level endon(#"end_game");
  self endon(#"death", #"disconnect");

  while(true) {
    util::waittill_any_ents(self, "zone_change", level, "end_of_round");

    if(self.cached_zone_name === "zone_helipads" || self.cached_zone_name === "zone_helipads_2" || self.cached_zone_name === "zone_helipads_3" || self.cached_zone_name === "zone_helipads_4" || self.cached_zone_name === "zone_helipads_portal_room") {
      var_b7f7d612 = level.round_number;

      while(self.cached_zone_name === "zone_helipads" || self.cached_zone_name === "zone_helipads_2" || self.cached_zone_name === "zone_helipads_3" || self.cached_zone_name === "zone_helipads_4" || self.cached_zone_name === "zone_helipads_portal_room") {
        util::waittill_any_ents(self, "zone_change", level, "end_of_round");

        if(level.round_number - var_b7f7d612 >= 10) {
          self zm_stats::increment_challenge_stat(#"hash_268fa1d97a2fab27");
          return;
        }
      }
    }
  }
}

function function_9bd5841() {
  self zm_stats::function_7ec42fbf(#"hash_7157c967c371c77c");
}

function function_f2763418() {
  level endon(#"end_game");
  level flag::wait_till("start_zombie_round_logic");
  level thread function_d164bea5();
  level thread function_2c6be4e1();
}

function function_d164bea5() {
  level endon(#"end_game");
  var_fd50ba9e = getnodearray("traversal_node_burger_town", "targetname");

  foreach(var_881969c in var_fd50ba9e) {
    unlinktraversal(var_881969c);
  }

  level flag::wait_till("connect_burger_town");

  foreach(var_881969c in var_fd50ba9e) {
    linktraversal(var_881969c);
  }
}

function function_2c6be4e1() {
  level endon(#"end_game");
  var_ed68b18b = getnodearray("traversal_node_pizza_parlor", "targetname");

  foreach(var_97ac2838 in var_ed68b18b) {
    unlinktraversal(var_97ac2838);
  }

  level flag::wait_till("connect_pizza_parlor");

  foreach(var_97ac2838 in var_ed68b18b) {
    linktraversal(var_97ac2838);
  }
}

function function_994637d8(str_flag) {
  if(!isDefined(level.var_776c1ce1)) {
    level.var_776c1ce1 = array(#"hash_3e765c26047c9f54", "rbz_exfil_beacon_active");
  }

  if(!isDefined(level.var_776c1ce1)) {
    level.var_776c1ce1 = [];
  } else if(!isarray(level.var_776c1ce1)) {
    level.var_776c1ce1 = array(level.var_776c1ce1);
  }

  if(!isinarray(level.var_776c1ce1, str_flag)) {
    level.var_776c1ce1[level.var_776c1ce1.size] = str_flag;
  }
}

function function_835bb4a7() {
  if(level flag::get(#"hash_709701a349515bd7") || level flag::get(#"hash_561302e48877300e") || level flag::get(#"hash_1695615ee9fcfe29") || level flag::get(#"hash_6de3a0458517d4ad") || level flag::get(#"hash_4be36d666c75b752") || is_true(function_89950a23())) {
    return true;
  }

  return false;
}

function function_1fd1da2b(var_92310804 = 1) {
  if(var_92310804 && function_89950a23()) {
    return true;
  }

  if(isDefined(level.var_776c1ce1.size) && level.var_776c1ce1.size != 0) {
    foreach(str_flag in level.var_776c1ce1) {
      if(level flag::get(str_flag)) {
        return true;
      }
    }

    return false;
  }

  return false;
}

function function_89950a23() {
  foreach(e_player in getplayers()) {
    if(e_player flag::get(#"hash_467e4279ccacfd8a")) {
      return true;
    }
  }

  return false;
}

function private function_4c324227(var_5e1c5c6d) {
  a_s_locs = [];

  for(i = 0; i < 4; i++) {
    a_s_locs[i] = struct::get(var_5e1c5c6d + "_" + i, "targetname");
  }

  return a_s_locs;
}

function function_d4738f46() {
  level endon(#"end_game");
  var_18e0dde5 = [];
  array::add(var_18e0dde5, getent("vol_player_in_intermission_space", "targetname"));
  array::add(var_18e0dde5, getent("vol_player_on_ground", "targetname"));
  array::add(var_18e0dde5, getent("vol_player_in_bunker", "targetname"));
  var_1d1bbd52[# "main_street_to_helipads"] = function_4c324227("main_street_to_helipads_end");
  var_1d1bbd52[# "anytown_usa_to_main_street"] = function_4c324227("anytown_usa_to_main_street_end");
  var_1d1bbd52[# "main_street_to_anytown_usa"] = function_4c324227("main_street_to_anytown_usa_end");
  var_1d1bbd52[# "anytown_usa_to_bunker"] = function_4c324227("anytown_usa_to_bunker_end");
  var_1d1bbd52[# "helipads_to_main_street"] = function_4c324227("helipads_to_main_street_end");
  var_1d1bbd52[# "bunker_to_observation"] = function_4c324227("bunker_to_observation_end");
  var_1d1bbd52[# "helipads_to_observation"] = function_4c324227("helipads_to_observation_end");
  var_1d1bbd52[# "observation_to_helipads"] = function_4c324227("observation_to_helipads_end");

  while(true) {
    players = getplayers();

    foreach(player in players) {
      util::wait_network_frame();

      if(!isDefined(player)) {
        continue;
      }

      if(player isinmovemode("ufo", "noclip") || is_true(level.disable_kill_thread) || getdvarint(#"zombie_cheat", 0) > 0) {
        continue;
      }

      if(player.sessionstate == "spectator") {
        continue;
      }

      if(is_true(player.hostmigrationcontrolsfrozen)) {
        continue;
      }

      if(is_true(player.var_f22c83f5)) {
        continue;
      }

      if(!player zm_player::in_life_brush() && (player zm_player::in_kill_brush() || !player zm_player::in_enabled_playable_area() || isDefined(level.player_out_of_playable_area_override) && is_true(player[[level.player_out_of_playable_area_override]]())) && !is_true(player.var_2c27f919) && !player scene::is_igc_active()) {
        var_96110541 = 0;

        foreach(var_ef325671 in var_18e0dde5) {
          if(istouching(player.origin, var_ef325671)) {
            var_96110541 = 1;
            break;
          }
        }

        if(var_96110541) {
          continue;
        }

        if(!isDefined(player.var_42b83e3e)) {
          player.var_42b83e3e = 1;
        } else {
          if(player.var_42b83e3e >= 3) {
            continue;
          }

          player.var_42b83e3e++;
        }

        n_closest_dist = 999999999;

        foreach(a_s_loc in var_1d1bbd52) {
          n_dist = distance2d(player.origin, a_s_loc[0].origin);

          if(n_dist < n_closest_dist) {
            n_closest_dist = n_dist;
            var_2ed46675 = a_s_loc;
          }
        }

        var_29be4020 = getplayers();

        for(i = 0; i < 4; i++) {
          b_safe = 1;
          s_loc = var_2ed46675[i];

          foreach(var_56901085 in var_29be4020) {
            if(var_56901085 == player) {
              continue;
            }

            var_91d1913b = distancesquared(s_loc.origin, var_56901085.origin);

            if(var_91d1913b < 1024) {
              b_safe = 0;
              break;
            }
          }

          if(b_safe) {
            player setorigin(s_loc.origin + (0, 0, 32));
            player setvelocity((0, 0, 0));
            break;
          }
        }
      }
    }

    wait 0.4;
  }
}

function function_19441a5a(players) {
  potential_targets = [];

  foreach(player in players) {
    if(function_6095b902(player)) {
      array::add(potential_targets, player);
    }
  }

  return array::random(potential_targets);
}

function function_6095b902(player) {
  if(!isDefined(player)) {
    return false;
  }

  var_2942900 = player flag::get(#"hash_5b86982b4c9c8c5") || player flag::get(#"in_waw");
  return !var_2942900;
}

function function_37597f29() {
  util::add_debug_command("<dev string:x422>");
  util::add_debug_command("<dev string:x477>");
  util::add_debug_command("<dev string:x4f0>");
  util::add_debug_command("<dev string:x557>");
  util::add_debug_command("<dev string:x5bc>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_50d92ca3c6c7c2a8":
      function_71a6c3ea();
      break;
    case # "hash_41ed3803afaf6e4a":
      zm_tungsten_pap_quest::function_1d310878();
      break;
    case # "hash_1f1d6a652126f2f":
      level.var_4da195fc = 1;
      break;
    case # "hash_11cc5cc057abb4a0":
      level.var_4da195fc = 0;
      break;
    case # "hash_57b9473a38039ff0":
      function_71a6c3ea();
      level thread zm_tungsten_main_quest::function_2f0a2ce2();
      break;
    default:
      break;
  }
}

function function_71a6c3ea() {
  level notify(#"hash_50d92ca3c6c7c2a8");
  level.var_f925c697 = 1;
  zm_devgui::zombie_devgui_open_sesame();
  level thread zm_sq::function_f2dd8601(#"pap_quest", zm_sq::function_9212ff4d(#"pap_quest", #"release_lockdown"));
  level flag::set("<dev string:x26c>");
  zm_tungsten_zones::function_2d12df62();
}

function function_5a3997b4() {
  level endon(#"end_game", #"hash_50d92ca3c6c7c2a8");
  level waittill(#"open_sesame");
  zm_tungsten_pap_quest::function_8ac7a154();
  zm_power::turn_power_on_and_open_doors(1, 0);
  level flag::clear(#"disable_weapon_machine");
}