/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_353f4332c07d6432.gsc
***********************************************/

#using script_1c92816b36da2771;
#using script_340a2e805e35f7a2;
#using script_34ab99a4ca1a43d;
#using script_3a704cbcf4081bfb;
#using script_58860a35d0555f74;
#using script_5b190e6124417f5a;
#using script_63b5c2449d0e2f48;
#using script_7a5293d92c61c788;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_platinum;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_audio_sq;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_958b287a;

function init() {
  init_clientfields();

  if(!zm_utility::is_ee_enabled()) {
    var_22e48c9c = getEntArray("pl_by_pt", "targetname");
    array::run_all(var_22e48c9c, &hide);
    return;
  }

  init_quests();
  namespace_1fd59e39::function_1376ec37(undefined, undefined, "vol_bc_restrict");

  level thread function_eea3cf4a();
}

function init_clientfields() {
  clientfield::register("scriptmover", "" + # "hash_7171d4768b724a65", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_5fca7cdab0e93f71", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_866e71344110f38", 24000, getminbitcountfornum(2), "int");
  clientfield::register("actor", "" + # "hash_54e2a4e02a26cc62", 24000, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_721d42a28d7461ea", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_27f831b48c21166f", 24000, 1, "int");
  clientfield::register("world", "" + # "hash_28f70ef210665b53", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_e4552abd8fb5506", 24000, 1, "int");
}

function init_quests() {
  zm_audio_sq::init();
  level zm_sq::register(#"hash_532d4747d3b67ad1", #"step_1", #"hash_48ae75f4de9892ec", &function_92105cc8, &function_1e78f5fa);
  level zm_sq::register(#"hash_532d4747d3b67ad1", #"step_2", #"hash_48ae78f4de989805", &function_3c076e85, &function_b23edced);
  level zm_sq::register(#"hash_532d4747d3b67ad1", #"step_3", #"hash_48ae77f4de989652", &function_5897cf56, &function_c50aa817);
  level zm_sq::register(#"hash_8d1695b3c81e6cd", #"step_1", #"hash_5b18caca7fbd28f0", &function_e80810b4, &function_ba11058a);
  level zm_sq::register(#"hash_8d1695b3c81e6cd", #"step_2", #"hash_5b18cdca7fbd2e09", &function_9a22f9c2, &function_1c35e44a);
  level zm_sq::register(#"hash_156c18c15a84ac22", #"step_1", #"hash_35da5c7d8af226fd", &function_af042db0, &function_6c660ed5);
  level thread function_f1e68db9();
  level thread function_aa9d9702();
  level thread function_2abef8da();
}

function private function_2abef8da() {
  level zm_sq::start(#"hash_532d4747d3b67ad1", 1);
  level zm_sq::start(#"hash_8d1695b3c81e6cd", 1);
  level zm_sq::start(#"hash_156c18c15a84ac22", 1);
}

function function_f1e68db9() {
  if(!isDefined(level.var_84644da3)) {
    level.var_84644da3 = 0;
  }

  level.var_84644da3++;
  level.var_fe700d1d = # "hash_41a84b48c5688d5e" + level.var_84644da3;
  level zm_sq::register(#"hash_7305ed0bfae697c1" + level.var_84644da3, #"step_1", #"hash_505bb72ac14a72b8" + level.var_84644da3, &function_ae1c3581, &function_6d225cba);
  level zm_sq::register(#"hash_7305ed0bfae697c1" + level.var_84644da3, #"step_2", #"hash_505eb72ac14ca88f" + level.var_84644da3, &function_1117e359, &function_b0e382eb);
  level zm_sq::register(#"hash_7305ed0bfae697c1" + level.var_84644da3, #"step_3", #"hash_5062772ac15024a6" + level.var_84644da3, &function_a04ddc18, &function_87440364);
  level zm_sq::start(#"hash_7305ed0bfae697c1" + level.var_84644da3, 1);
}

function function_aa9d9702() {
  if(!isDefined(level.var_d3450438)) {
    level.var_d3450438 = 0;
  }

  level.var_d3450438++;
  level.var_fd9dec51 = # "hash_66e2d62d9b36999b" + level.var_d3450438;
  level zm_sq::register(#"hash_7868beb4ca9e1449" + level.var_d3450438, #"step_1", #"hash_557e01adc0c8790" + level.var_d3450438, &function_d745ca5e, &function_23cef26a);
  level zm_sq::start(#"hash_7868beb4ca9e1449" + level.var_d3450438, 1);
}

function function_92105cc8(var_a276c861) {
  level endon(#"game_ended", #"hash_57e6e0188d82d9e6");
  var_22e48c9c = getEntArray("pl_by_pt", "targetname");

  foreach(e_part in var_22e48c9c) {
    e_part thread function_f108e709();
  }

  var_fc90ddf0 = 0;

  while(true) {
    level waittill(#"hash_3cfc9bc31cad5e4a");
    var_fc90ddf0 += 1;

    iprintlnbold(var_fc90ddf0 + "<dev string:x38>");

    namespace_b574e135::function_f5d0eb85(var_fc90ddf0);

    if(var_fc90ddf0 >= 6) {
      break;
    }
  }

  iprintlnbold("<dev string:x55>");
}

function function_f108e709() {
  self zm_unitrigger::function_fac87205(&function_7f55d66, 96);
  self clientfield::set("" + # "hash_5fca7cdab0e93f71", 1);
  level notify(#"hash_3cfc9bc31cad5e4a");
  self ghost();
  wait 1;

  if(isDefined(self)) {
    self delete();
  }
}

function function_7f55d66(e_player) {
  s_parent = self.stub.related_parent;

  if(!isDefined(s_parent)) {
    return false;
  }

  var_5168e40f = e_player zm_utility::is_player_looking_at(s_parent.origin, 0.9);
  var_f7675868 = !level flag::get(#"hash_434bc775e67b7233") || level flag::get(#"hash_434bc775e67b7233") && level flag::get(#"hash_20afa38b1f1c339e");
  var_77251cc8 = level flag::get(#"hash_25372b8b89ab540c");
  return is_true(var_5168e40f) && is_true(var_77251cc8) && is_true(var_f7675868);
}

function function_1e78f5fa(var_a276c861, var_19e802fa) {
  level flag::set(#"hash_7b5643f5ecc16c8f");

  if(var_a276c861 || var_19e802fa) {
    level flag::set(#"hash_57e6e0188d82d9e6");

    for(i = 1; i <= 6; i++) {
      namespace_b574e135::function_f5d0eb85(i);
      waitframe(1);
    }
  }
}

function function_ae1c3581(var_a276c861) {
  level endon(#"game_ended", level.var_fe700d1d);
  level flag::wait_till(#"hash_7cc4347161a79b86");
  var_a2b82573 = level.round_number + 15;
  level waittill(#"start_of_round");

  while(level.round_number < var_a2b82573) {
    level waittill(#"end_of_round");
  }

  var_6fed2eb5 = struct::get("bc_return");
  level.var_6cd28a87 = util::spawn_model(#"p9_zm_platinum_magic_box_bunny", var_6fed2eb5.origin, var_6fed2eb5.angles);
  level.var_6cd28a87 function_da10c3e7();
  level.var_6cd28a87 thread function_957e8ad3();
  level flag::wait_till(level.var_fe700d1d);
}

function function_da10c3e7() {
  level endon(#"game_ended", level.var_fe700d1d);
  self endon(#"death");
  self clientfield::set("" + # "hash_7171d4768b724a65", 1);
  wait 1;
  self clientfield::set("" + # "hash_7171d4768b724a65", 0);
}

function function_957e8ad3() {
  level endon(#"game_ended", level.var_fe700d1d);
  self endon(#"death");
  self.takedamage = 1;

  while(true) {
    waitresult = self waittill(#"damage");

    if(isPlayer(waitresult.attacker) && level flag::get(#"hash_25372b8b89ab540c")) {
      level flag::set(#"hash_7b5643f5ecc16c8f");
      level flag::set(level.var_fe700d1d);
    }
  }
}

function function_6d225cba(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level flag::set(level.var_fe700d1d);
    level flag::set(#"hash_7b5643f5ecc16c8f");
  }

  if(isDefined(level.var_6cd28a87)) {
    level.var_6cd28a87 clientfield::set("" + # "hash_5fca7cdab0e93f71", 1);
    level.var_6cd28a87 ghost();
    level.var_6cd28a87 util::function_f9af3d43(2);
  }
}

function function_3c076e85(var_a276c861) {
  level function_ae62fd54(var_a276c861);
}

function function_1117e359(var_a276c861) {
  level function_ae62fd54(var_a276c861);
}

function function_ae62fd54(var_a276c861) {
  level endon(#"hash_399c68f64eb1b589");
  var_3a49bb20 = struct::get("bny_club_dj_loc");
  level thread zm_platinum::function_4cc5fca6();
  level clientfield::increment("" + # "hash_56c7e620d1de163a");
  level flag::set(#"in_dark_side");
  level flag::set(#"hash_13cd183e1c6cadd2");
  wait 6.5;

  foreach(player in getplayers()) {
    player notify(#"hash_42b83a8bd6b040d3");
  }

  level thread function_6b4c16f8();
  level flag::clear("spawn_zombies");
  level zm_utility::function_9ad5aeb1(1, 1, 1, 0);
  level thread namespace_99d0d95e::function_8f85d169(1);
  level clientfield::set("" + # "hash_866e71344110f38", 1);
  zm_zonemgr::enable_zone("zone_bunny_club");
  function_b04a544a(1);
  function_51a95461(1);
  var_39aa2909 = struct::get_array("pl_by_cl_spn");
  var_9ab9f5a5 = [(1590, 10561, -952), (1626, 10367, -952), (1631, 10172, -952), (1580, 9973, -952)];

  for(i = 0; i < var_39aa2909.size; i++) {
    var_39aa2909[i].origin = var_9ab9f5a5[i];
    var_39aa2909[i].angles = (0, 360, 0);
  }

  foreach(player in function_a1ef346b()) {
    player clientfield::set_to_player("" + # "hash_721d42a28d7461ea", 1);
    n_index = zm_fasttravel::get_player_index(player);
    var_8828e30f = var_39aa2909[n_index];
    player thread function_59ebeee9(var_8828e30f);
  }

  wait 3;
  var_3a49bb20 thread function_135c5a05();
  level flag::set(#"hash_43c360bf8cccea00");

  if(var_a276c861) {
    return;
  }

  var_3a49bb20.b_reward = function_ef40fc60();
}

function function_135c5a05() {
  level endon(#"hash_51047505aeee86ad");
  wait 3;
  var_6cd28a87 = util::spawn_model(#"p9_zm_platinum_magic_box_bunny", self.origin, self.angles);
  self.var_6cd28a87 = var_6cd28a87;
  var_6cd28a87 clientfield::set("" + # "hash_7171d4768b724a65", 1);
  wait 1;
  var_6cd28a87 thread function_15741b86();
}

function function_6b4c16f8() {
  level endon(#"hash_6d16c284cbb301d1");

  if(level flag::get(#"hash_6d16c284cbb301d1")) {
    level flag::wait_till(#"hash_279a97271de2b7e1");
    level notify(#"hash_2394f251215a8fae");
    thread namespace_6fb22263::function_55bd650c();
  }
}

function function_b04a544a(b_enabled, b_cleanup = 1) {
  a_e_clip = getEntArray("bny_club_energy_barrier_clip", "targetname");

  if(b_cleanup) {
    level clientfield::set("" + # "hash_28f70ef210665b53", 1);
    array::run_all(a_e_clip, &solid);
    return;
  }

  level clientfield::set("" + # "hash_28f70ef210665b53", 0);
  array::run_all(a_e_clip, &notsolid);
}

function function_15741b86() {
  self endon(#"death");
  level endon(#"hash_51047505aeee86ad");
  self scene::play(#"hash_4380575dd04b7eeb", "entry_1", self);

  while(true) {
    if(math::cointoss()) {
      str_scene = "loop_1";
    } else {
      str_scene = "loop_2";
    }

    self scene::play(#"hash_4380575dd04b7eeb", str_scene, self);
  }
}

function function_190fd035(var_3a49bb20) {
  self endon(#"death");

  if(is_true(var_3a49bb20.b_reward)) {
    str_scene = "exit_1";
  } else {
    str_scene = "exit_2";
  }

  self scene::play(#"hash_4380575dd04b7eeb", str_scene, self);
  self clientfield::set("" + # "hash_7171d4768b724a65", 0);
  self ghost();
}

function function_ef40fc60() {
  var_cc4ef50c = struct::get_array("bny_spn_loc_regular");
  var_6efc5897 = struct::get_array("bny_spn_loc_mimic");
  var_14043e22 = struct::get_array("bny_spn_loc_raz");
  var_8aa89b6d = struct::get_array("bny_spn_loc_steiner");
  var_abe26193 = struct::get_array("bny_spn_loc_tormentor");
  n_players = zm_utility::get_number_of_valid_players();

  switch (n_players) {
    case 1:
    default:
      n_zombie_count = 30;
      var_262fa864 = 3;
      var_61453888 = 1;
      var_31fe02a0 = 1;
      var_178d3856 = 1;
      var_81c652e4 = 0;
      var_65aa30c0 = 0.5;
      break;
    case 2:
      n_zombie_count = 30;
      var_262fa864 = 4;
      var_61453888 = 2;
      var_31fe02a0 = 2;
      var_178d3856 = 1;
      var_81c652e4 = 1;
      var_65aa30c0 = 0.75;
      break;
    case 3:
      n_zombie_count = 30;
      var_262fa864 = 5;
      var_61453888 = 3;
      var_31fe02a0 = 3;
      var_178d3856 = 4;
      var_81c652e4 = 1;
      var_65aa30c0 = 1;
      break;
    case 4:
      n_zombie_count = 30;
      var_262fa864 = 6;
      var_61453888 = 4;
      var_31fe02a0 = 4;
      var_178d3856 = 4;
      var_81c652e4 = 1;
      var_65aa30c0 = 1;
      break;
  }

  music::setmusicstate("bunny_wave_1");
  level thread function_b6e1020(var_cc4ef50c, n_zombie_count, ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"]);
  function_bbc799ae("dance");
  wait 15.9;
  level notify(#"hash_5c03540b79cae9cf");
  level thread function_b6e1020(var_14043e22, var_61453888, #"hash_4f87aa2a203d37d0", 3);
  level thread function_b6e1020(var_cc4ef50c, int(n_zombie_count * var_65aa30c0), ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], 3, 0, #"hash_55bea83d2a2aeacd", 1);
  function_bbc799ae("attack");
  level util::delay_notify(35, #"hash_55bea83d2a2aeacd");
  wait 40;
  level notify(#"hash_7a134b0bf63aef2e");
  music::setmusicstate("bunny_wave_2");
  level thread function_b6e1020(var_cc4ef50c, n_zombie_count, ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], 0.2);
  function_bbc799ae("dance");
  wait 16;
  level notify(#"hash_5c03540b79cae9cf");
  level thread function_b6e1020(var_abe26193, var_262fa864, #"hash_51edd7595ecda822", 5);
  level thread function_b6e1020(var_6efc5897, var_31fe02a0, #"spawner_bo5_mimic", 3);
  level thread function_b6e1020(var_cc4ef50c, int(n_zombie_count * var_65aa30c0), ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], 3, 0, #"hash_783bf496a0ca4bae", 1);
  function_bbc799ae("attack");
  level util::delay_notify(35, #"hash_783bf496a0ca4bae");
  wait 40;
  level notify(#"hash_4380f9020039678d");
  music::setmusicstate("bunny_wave_3");
  level thread function_b6e1020(var_cc4ef50c, n_zombie_count, ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], 0.2);
  function_bbc799ae("dance");
  wait 16;
  level notify(#"hash_5c03540b79cae9cf");
  level notify(#"hash_7f556459f0655689");
  level thread function_b6e1020(var_abe26193, var_262fa864, #"hash_51edd7595ecda822", 5);
  level thread function_b6e1020(var_8aa89b6d, var_81c652e4, #"spawner_zm_steiner", 3);
  level thread function_b6e1020(var_cc4ef50c, var_178d3856, #"spawner_bo5_soa", 2);
  level thread function_b6e1020(var_cc4ef50c, int(n_zombie_count * var_65aa30c0), ["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], 3, 0, #"hash_7bbb97a6df558f88", 1);
  level thread function_38c50cf3();
  level thread function_704910e8(var_81c652e4);
  function_bbc799ae("attack");
  level flag::wait_till_all_timeout(64, [#"hash_3239b4eb1e8b1e3b", #"hash_6273dc2c0d03eec6"]);
  level notify(#"hash_7bbb97a6df558f88");

  if(level flag::get_all([#"hash_3239b4eb1e8b1e3b", #"hash_6273dc2c0d03eec6"])) {
    level zm_utility::function_9ad5aeb1(1, 1, 0, 0);
    music::setmusicstate("bunny_outro");
    function_bbc799ae("dance");
    zm_powerups::specific_powerup_drop("full_ammo", (2365, 10272, -986), undefined, undefined, undefined, 0);
    wait 10;
    function_bbc799ae("prize");
    return 1;
  }

  var_89c89228 = struct::get("bny_club_dj_loc");
  playsoundatposition(#"hash_6f7017b0648740c3", var_89c89228.origin);
  music::setmusicstate("bunny_outro_fail");
  level notify(#"hash_6ba7212a7d50425c");
  wait 3;
  function_bbc799ae("dance");
  return 0;
}

function function_38c50cf3() {
  level endon(#"hash_3239b4eb1e8b1e3b", #"hash_6ba7212a7d50425c");

  while(true) {
    a_enemies = array::filter(getaiarray("bq_ai", "targetname"), 0, &function_1043505b);

    if(a_enemies.size === 0) {
      level flag::set(#"hash_3239b4eb1e8b1e3b");
    }

    util::wait_network_frame();
  }
}

function function_1043505b(ai) {
  if(is_true(ai.aat_turned)) {
    return false;
  }

  return true;
}

function function_704910e8(var_81c652e4) {
  level endon(#"hash_6273dc2c0d03eec6", #"hash_6ba7212a7d50425c");

  if(var_81c652e4 < 1) {
    level flag::set(#"hash_6273dc2c0d03eec6");
    return;
  }

  n_kill_count = 0;

  while(true) {
    level waittill(#"hash_7e3660d8d125a63a");
    n_kill_count++;

    if(n_kill_count == var_81c652e4) {
      level flag::set(#"hash_6273dc2c0d03eec6");
    }
  }
}

function function_b6e1020(a_loc, n_spawn, var_84296e0, var_5c263237, var_67b2128e = 1, str_endon, var_4e08b638) {
  if(isDefined(str_endon)) {
    level endon(str_endon);
  }

  if(!isarray(var_84296e0)) {
    if(!isDefined(var_84296e0)) {
      var_84296e0 = [];
    } else if(!isarray(var_84296e0)) {
      var_84296e0 = array(var_84296e0);
    }
  }

  if(!isDefined(var_5c263237)) {
    for(i = 0; i < n_spawn; i++) {
      if(a_loc.size == 0) {
        return;
      }

      while(getfreeactorcount() < 1) {
        waitframe(1);
      }

      e_loc = array::random(a_loc);
      arrayremovevalue(a_loc, e_loc);
      str_type = array::random(var_84296e0);
      ai = spawnactor(str_type, e_loc.origin, e_loc.angles);

      if(isDefined(ai)) {
        ai thread function_43ea27c1(var_4e08b638);

        if(is_true(var_67b2128e) && isinarray(["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], str_type)) {
          ai thread function_e6020995();
        }
      }
    }

    return;
  }

  for(i = 0; i < n_spawn; i++) {
    if(a_loc.size == 0) {
      iprintlnbold("<dev string:x68>");

      return;
    }

    wait var_5c263237;

    while(getfreeactorcount() < 1) {
      waitframe(1);
    }

    e_loc = array::random(a_loc);
    arrayremovevalue(a_loc, e_loc);
    str_type = array::random(var_84296e0);
    ai = spawnactor(str_type, e_loc.origin, e_loc.angles);

    if(isDefined(ai)) {
      ai thread function_43ea27c1(var_4e08b638);

      if(is_true(var_67b2128e) && isinarray(["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], str_type)) {
        ai thread function_e6020995();
      }

      if(str_type !== # "spawner_bo5_soa") {
        ai clientfield::increment("" + # "hash_54e2a4e02a26cc62", 1);
      }
    }
  }
}

function function_43ea27c1(var_4e08b638) {
  self endon(#"death");

  if(!is_true(var_4e08b638) && isDefined(self.aitype) && isinarray(["spawner_bo5_zombie_zm_platinum", "spawner_bo5_zombie_zm_platinum_female"], self.aitype)) {
    self clientfield::set("" + # "hash_3e4641a9ea00d061", 1);
  }

  self.maxhealth = self zm_ai_utility::function_b5fe98(level.round_number);
  self.health = self.maxhealth;

  if(!is_true(var_4e08b638)) {
    self.targetname = "bq_ai";
  }

  self zm_score::function_acaab828();
  self.b_ignore_cleanup = 1;
  self.ignore_enemy_count = 1;
  self.no_powerups = 1;
  self pathmode("dont move");
  self.completed_emerging_into_playable_area = 1;
  self.zombie_think_done = 1;

  if(isDefined(self)) {
    if(self.archetype === # "tormentor") {
      self.zombie_move_speed = "super_sprint";
    } else {
      self.zombie_move_speed = "run";
    }

    self pathmode("move allowed");
  }
}

function function_e6020995() {
  self endon(#"death");
  self val::set(#"hash_53de14c58f4c6053", "ignoreme", 1);
  self val::set(#"hash_53de14c58f4c6053", "takedamage", 0);
  self.var_e8920729 = 1;
  n_index = randomint(17);

  if(isalive(self)) {
    switch (n_index) {
      case 0:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_01");
        break;
      case 1:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_02");
        break;
      case 2:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_03");
        break;
      case 3:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_04");
        break;
      case 4:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_05");
        break;
      case 5:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_07");
        break;
      case 6:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_08");
        break;
      case 7:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_09");
        break;
      case 8:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_10");
        break;
      case 9:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_11");
        break;
      case 10:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_12");
        break;
      case 11:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_13");
        break;
      case 12:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_14");
        break;
      case 13:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_15");
        break;
      case 14:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_16");
        break;
      case 15:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_17");
        break;
      case 16:
        self thread animation::play(#"ai_t9_zm_berlin_zombie_dance_18");
        break;
    }
  }

  level waittill(#"hash_5c03540b79cae9cf");
  self animation::stop();

  if(isDefined(self)) {
    self clientfield::set("" + # "hash_3e4641a9ea00d061", 0);
    self val::reset(#"hash_53de14c58f4c6053", "ignoreme");
    self val::reset(#"hash_53de14c58f4c6053", "takedamage");
    self.var_e8920729 = 0;
    bhtnactionstartevent(self, "sprint");
  }
}

function function_5897cf56(var_a276c861) {
  level function_17a56fb7(0);
}

function function_a04ddc18(var_a276c861) {
  level function_17a56fb7(1);
}

function function_17a56fb7(b_return) {
  var_3a49bb20 = struct::get("bny_club_dj_loc");
  level flag::set(#"hash_51047505aeee86ad");

  if(isDefined(var_3a49bb20.var_6cd28a87)) {
    var_3a49bb20.var_6cd28a87 function_190fd035(var_3a49bb20);
  }

  if(is_true(var_3a49bb20.b_reward)) {
    util::setclientsysstate("platMusUnlock", "unlockSqueak");
    array::thread_all(function_a1ef346b(), &zm_equipment::show_hint_text, #"hash_548ca4bd420c313b");

    iprintlnbold("<dev string:x8f>");

    function_b04a544a(0);
    function_f93fd05a(b_return);
  }
}

function function_f93fd05a(b_return) {
  var_f07d7204 = ["gold", "large", "medium"];
  var_854257c7 = getEntArray("pl_by_dr", "targetname");
  level clientfield::set("" + # "hash_866e71344110f38", 2);

  foreach(door in var_854257c7) {
    switch (door.script_int) {
      case 1:
        door setModel(#"p9_zm_platinum_club_round_door_01_on");
        break;
      case 2:
        door setModel(#"p9_zm_platinum_club_round_door_02_on");
        break;
      case 3:
        door setModel(#"p9_zm_platinum_club_round_door_03_on");
        break;
    }

    door clientfield::set("" + # "hash_e4552abd8fb5506", 1);
    door.var_9171844e = array::random(var_f07d7204);
    arrayremovevalue(var_f07d7204, door.var_9171844e, 0);
    door thread function_3d06cff4();
  }

  level thread function_ae615a59(15);
  waitresult = level waittilltimeout(15, #"hash_6b43aad842b32a54");
  level notify(#"hash_129e2d746ff4a406");

  if(isDefined(waitresult.var_2cdf7adf)) {
    level thread function_5ed2e797(var_854257c7, waitresult.var_2cdf7adf, waitresult.var_9171844e, b_return);
    level thread function_ae615a59(20);
    wait 20;
    return;
  }

  level thread function_ac1676db(var_854257c7, b_return);
}

function function_ac1676db(var_854257c7, b_return) {
  waitresult = level waittilltimeout(7, #"hash_6b43aad842b32a54");

  if(isDefined(waitresult.var_2cdf7adf)) {
    level thread function_5ed2e797(var_854257c7, waitresult.var_2cdf7adf, waitresult.var_9171844e, b_return);
  }
}

function function_ae615a59(n_time) {
  level endon(#"hash_129e2d746ff4a406");
  var_a35366e7 = max(n_time - 10, 0);
  wait var_a35366e7;
  level function_ea45ba4c();
}

function private function_3d06cff4() {
  self endon(#"hash_4d2eb428daff2ffc");
  self.s_door = struct::get(self.target);
  self.s_door zm_unitrigger::function_fac87205(#"hash_1cc0ecca8014ce5", 96);
  level notify(#"hash_6b43aad842b32a54", {
    #var_2cdf7adf: self.script_int, #var_9171844e: self.var_9171844e
  });
  self moveto(self.origin + (0, 0, 400), 6);
  self playSound(#"hash_15edf5c3ecb9eada");
  wait 1;
  var_cf64509e = getent(self.target, "targetname");

  if(isDefined(var_cf64509e)) {
    var_cf64509e notsolid();
  }

  level.var_31938aae = self;
}

function function_5ed2e797(var_854257c7, var_2cdf7adf, var_9171844e, b_return) {
  foreach(door in var_854257c7) {
    zm_unitrigger::unregister_unitrigger(door.s_door.s_unitrigger);
    door.s_door.s_unitrigger = undefined;
  }

  var_53313495 = struct::get("club_reward_door_" + var_2cdf7adf);
  var_5e809a1a = function_84571027();
  var_6f7eb70f = hash(var_9171844e + "_chest_level_" + var_5e809a1a);

  if(var_9171844e == "medium") {
    var_3a053962 = # "p9_fxanim_zm_gp_chest_01_med_low_xmodel";
    var_5b69f831 = # "p9_fxanim_zm_gp_chest_01_med_bundle";
    var_dae71351 = 2;
  } else {
    if(var_9171844e == "gold") {
      var_3a053962 = # "p9_fxanim_zm_gp_chest_01_lrg_gold_xmodel";
    } else {
      var_3a053962 = # "p9_fxanim_zm_gp_chest_01_lrg_low_xmodel";
    }

    var_5b69f831 = # "p9_fxanim_zm_gp_chest_01_lrg_bundle";
    var_dae71351 = 3;
  }

  wait 0.5;
  namespace_58949729::function_4ec9fc99(var_53313495, var_6f7eb70f, var_3a053962, var_5b69f831, var_dae71351);

  if(var_9171844e == "gold") {
    if(is_true(b_return)) {
      n_chance = 40;
    } else {
      n_chance = 10;
    }

    if(math::cointoss(n_chance)) {
      level thread function_e0b9a88e(var_2cdf7adf);

      foreach(player in getplayers()) {
        player zm_stats::increment_challenge_stat(#"hash_5699cbd949051396");
      }
    }
  }

  var_53313495.var_f3a3c164 = 1;
  var_53313495.scriptmodel solid();
  var_53313495 thread function_d81ba0fe();
  var_53313495 util::delay(50, undefined, &function_3076a002);
}

function function_e0b9a88e(var_2cdf7adf) {
  var_222825ae = struct::get("club_reward_ww_" + var_2cdf7adf);
  point = function_4ba8fde(#"ww_mega_barrel_fullauto_copycat_t9_item_sr");
  item_ww = item_drop::drop_item(0, getweapon(#"ww_mega_barrel_fullauto_copycat_t9"), 1, 0, point.id, var_222825ae.origin, var_222825ae.angles, 0);
  item_ww.var_dd21aec2 = 1 | 16;
  item_ww moveto(var_222825ae.origin - (0, 0, 62), 10, 0.05, 0.05);
}

function function_84571027() {
  if(level.round_number <= 5) {
    return 1;
  }

  if(level.round_number <= 10) {
    return 2;
  }

  if(level.round_number <= 15) {
    return 3;
  }

  if(level.round_number <= 20) {
    return 4;
  }

  if(level.round_number <= 25) {
    return 5;
  }

  return 6;
}

function function_d81ba0fe() {
  level endon(#"hash_40f6eac419f5f36a");
  self endon(#"death");
  self.trigger endon(#"death");
  playsoundatposition(#"hash_78ab7aaf4da20422", self.origin);
  self.var_e886e882 = util::spawn_model("tag_origin", self.origin);
  self.var_e886e882 playLoopSound(#"hash_5376822de0ce03cd");
  self.trigger waittill(#"chest_opened");
  self notify(#"chest_opened");
  self.var_e886e882 stoploopsound(1);

  if(isDefined(self.var_e886e882)) {
    self.var_e886e882 delete();
  }
}

function function_3076a002() {
  self endon(#"death");
  chest = self.scriptmodel;
  trigger = self.trigger;

  if(isDefined(chest)) {
    chest thread item_world::loop_sound("wpn_semtex_alert", 0.84);
    chest clientfield::set("supply_drop_fx", 0);
    util::wait_network_frame(1);
  }

  wait 5;

  if(isDefined(chest)) {
    chest scene::stop();
    playFX(#"hash_131031222bb89ea", chest.origin);
    playsoundatposition(#"wpn_grenade_explode", chest.origin);
    chest radiusdamage(chest.origin, 128, 50, 10, undefined, "MOD_EXPLOSIVE", getweapon(#"supplydrop"));
    chest delete();
  }

  if(isDefined(self.var_e886e882)) {
    self.var_e886e882 delete();
  }

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function function_b23edced(var_a276c861, var_19e802fa) {
  level function_a9a742f6(var_a276c861, var_19e802fa);
}

function function_b0e382eb(var_a276c861, var_19e802fa) {
  level function_a9a742f6(var_a276c861, var_19e802fa);
}

function function_a9a742f6(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level notify(#"hash_399c68f64eb1b589");
    struct::get("bny_club_dj_loc").b_reward = 1;
    function_bbc799ae("prize");
  }
}

function function_c50aa817(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    struct::get("bny_club_dj_loc").b_reward = 0;
  }

  level function_280f5788();
  level function_795e0560();
  level flag::set(#"hash_7cc4347161a79b86");
}

function function_87440364(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    struct::get("bny_club_dj_loc").b_reward = 0;
  }

  level function_280f5788();
  level function_795e0560();
  level thread function_f1e68db9();
}

function function_795e0560() {
  level thread function_b04a544a(0);

  if(isDefined(struct::get("bny_club_dj_loc").var_6cd28a87)) {
    struct::get("bny_club_dj_loc").var_6cd28a87 delete();
  }

  if(isDefined(level.var_31938aae)) {
    mdl_door = level.var_31938aae;
    mdl_door moveto(mdl_door.origin - (0, 0, 400), 0.5);
    e_clip = getent(mdl_door.target, "targetname");

    if(isDefined(e_clip)) {
      e_clip solid();
    }

    level.var_31938aae = undefined;
  }

  foreach(mdl_door in getEntArray("pl_by_dr", "targetname")) {
    mdl_door notify(#"hash_4d2eb428daff2ffc");
    mdl_door thread function_554f4e20();

    if(isDefined(mdl_door.s_door)) {
      zm_unitrigger::unregister_unitrigger(mdl_door.s_door.s_unitrigger);
      mdl_door.s_door.s_unitrigger = undefined;
    }
  }

  level flag::clear(#"hash_3239b4eb1e8b1e3b");
  level flag::clear(#"hash_6273dc2c0d03eec6");
  level flag::clear(#"hash_7b5643f5ecc16c8f");
}

function function_554f4e20() {
  if(isDefined(self.script_int)) {
    switch (self.script_int) {
      case 1:
        self setModel(#"p9_zm_platinum_club_round_door_01");
        break;
      case 2:
        self setModel(#"p9_zm_platinum_club_round_door_02");
        break;
      case 3:
        self setModel(#"p9_zm_platinum_club_round_door_03");
        break;
    }
  }

  self clientfield::set("" + # "hash_e4552abd8fb5506", 0);
}

function function_280f5788() {
  level thread zm_platinum::function_4cc5fca6();
  level clientfield::increment("" + # "hash_56c7e620d1de163a");
  wait 7;
  var_fe91f83b = struct::get_array("pl_by_ot_spn");
  var_9ab9f5a5 = [(-203, 10502, 40), (-207, 10295, 40), (10, 10488, 40), (-11, 10276, 40)];

  for(i = 0; i < var_fe91f83b.size; i++) {
    var_fe91f83b[i].origin = var_9ab9f5a5[i];
    var_fe91f83b[i].angles = (0, 180, 0);
  }

  foreach(player in function_a1ef346b()) {
    player clientfield::set_to_player("" + # "hash_721d42a28d7461ea", 0);
    n_index = zm_fasttravel::get_player_index(player);
    var_bb57932b = var_fe91f83b[n_index];
    player thread function_59ebeee9(var_bb57932b);
  }

  level zm_utility::function_9ad5aeb1(1, 1, 1, 0);
  wait 3;
  level flag::clear(#"in_dark_side");
  level flag::clear(#"hash_43c360bf8cccea00");
  level thread namespace_99d0d95e::function_8f85d169(0);
  level clientfield::set("" + # "hash_866e71344110f38", 0);
  level notify(#"hash_30ec56bfd9c6963c");
  function_bbc799ae("off");
  function_51a95461(0);
  zm_zonemgr::function_d68ef0f9("zone_bunny_club");
  level flag::set("spawn_zombies");
  level flag::clear(#"hash_13cd183e1c6cadd2");
  var_3a49bb20 = struct::get("bny_club_dj_loc");

  if(!is_true(var_3a49bb20.b_reward)) {
    var_120fe9cc = array::randomize([(-453.77, 10437, 13), (-390.77, 10331, 13), (-430, 10560, 13)]);
    zm_powerups::specific_powerup_drop("full_ammo", var_120fe9cc[0], undefined, undefined, undefined, 0);
    zm_powerups::specific_powerup_drop("carpenter", var_120fe9cc[1], undefined, undefined, undefined, 0);
    zm_powerups::specific_powerup_drop("bonus_points_team", var_120fe9cc[2], undefined, undefined, undefined, 0);
  }
}

function function_ea45ba4c(n_time_remaining = 10) {
  level endon(#"hash_129e2d746ff4a406");

  while(n_time_remaining > 0) {
    if(n_time_remaining == 1) {
      array::run_all(getplayers(), &playlocalsound, #"hash_5952b2eecab41e38");
    } else {
      array::run_all(getplayers(), &playlocalsound, #"hash_4474c2da74d7cdb9");
    }

    n_time_remaining--;
    wait 1;
  }
}

function function_bbc799ae(str_state) {
  switch (str_state) {
    case # "off":
    default:
      var_6a25fa7 = 0;
      var_d0b16504 = 0;
      break;
    case # "dance":
      var_6a25fa7 = 1;
      var_d0b16504 = 0;
      break;
    case # "attack":
      var_6a25fa7 = 2;
      var_d0b16504 = 1;
      break;
    case # "prize":
      var_6a25fa7 = 3;
      var_d0b16504 = 0;
      break;
  }

  level clientfield::set("" + # "hash_27f831b48c21166f", var_d0b16504);
  namespace_b574e135::function_471f4c0f(var_6a25fa7);
}

function function_59ebeee9(var_10fb1677) {
  level endon(#"end_game");

  if(!isalive(self)) {
    return;
  }

  self endon(#"death");

  while(self isziplining() || self function_b4813488()) {
    waitframe(1);
  }

  self thread zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, var_10fb1677, undefined, "bunny_club_teleport", 1);
}

function function_51a95461(b_rotate) {
  var_46405031 = getent("bc_disco_ball", "targetname");

  if(is_true(b_rotate)) {
    var_46405031 rotate((0, 15, 0));
    return;
  }

  var_46405031 rotate((0, 0, 0));
}

function function_eea3cf4a() {
  util::add_debug_command("<dev string:xaf>");
  util::add_debug_command("<dev string:x10d>");
  util::add_debug_command("<dev string:x16b>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  var_22e48c9c = getEntArray("<dev string:x1d7>", "<dev string:x1e3>");

  switch (cmd) {
    case # "hash_2555bbb92d1fe771":
      foreach(e_part in var_22e48c9c) {
        e_part thread function_35393ef2(1);
      }

      break;
    case # "hash_27e8451459a42bde":
      foreach(e_part in var_22e48c9c) {
        e_part thread function_35393ef2(0);
      }

      break;
    case # "hash_ee6d09286bb442d":
      level flag::set(#"hash_7cc4347161a79b86");
      break;
  }
}

function function_35393ef2(state) {
  self notify("<dev string:x1f1>");
  self endon("<dev string:x1f1>");
  self endon(#"death");

  if(state) {
    while(true) {
      circle(self.origin, 10, (0, 0, 1));
      waitframe(1);
    }
  }
}

function function_e80810b4() {
  flag::wait_till("power_on");
  flag::init("shoot_target_timeout");
  var_bc3709b9 = struct::get("s_shoot_start", "targetname");
  var_d1792325 = util::spawn_model("p9_sr_manilla_folder_01", var_bc3709b9.origin, var_bc3709b9.angles);
  var_d1792325 zm_unitrigger::function_fac87205(&function_aacafb6e);
  playsoundatposition(#"hash_38b49dbc108cca56", var_d1792325.origin);

  if(isDefined(var_d1792325)) {
    var_d1792325 delete();
  }

  wait randomfloatrange(2, 3);
  var_d8f1c196 = struct::get("shoot_target", "targetname");
  mdl_target = util::spawn_model("P9_usa_kgb_target_dummy_02", (0, 0, 0));

  while(isDefined(var_d8f1c196)) {
    var_411cc8d4 = struct::get(var_d8f1c196.target, "targetname");
    mdl_target thread function_efcfff5b();
    level function_db3d8ac(mdl_target, var_d8f1c196, var_411cc8d4);
    mdl_target rotateroll(90, 0.5);
    wait 0.5;

    if(flag::get("shoot_target_timeout")) {
      break;
    }

    if(isDefined(var_411cc8d4.target)) {
      wait randomfloatrange(1, 2);
      var_d8f1c196 = struct::get(var_411cc8d4.target, "targetname");
      continue;
    }

    break;
  }

  if(isDefined(mdl_target)) {
    mdl_target delete();
  }
}

function function_aacafb6e(e_player) {
  s_parent = self.stub.related_parent;

  if(!isDefined(s_parent)) {
    return 0;
  }

  var_5168e40f = e_player zm_utility::is_player_looking_at(s_parent.origin, 0.9, 0);
  return is_true(var_5168e40f);
}

function function_db3d8ac(mdl_target, var_d8f1c196, var_411cc8d4) {
  level endon(#"hash_7c8a1026b606ae9c");
  mdl_target ghost();
  util::wait_network_frame();
  mdl_target.origin = var_d8f1c196.origin;
  mdl_target.angles = var_d8f1c196.angles + (0, 0, 90);
  util::wait_network_frame();
  mdl_target show();
  mdl_target rotateroll(-90, 0.5);
  mdl_target playSound(#"hash_2ba42e10437f5fe9");
  wait 0.5;
  mdl_target setCanDamage(1);
  n_move_time = randomfloatrange(3, 5);
  mdl_target moveto(var_411cc8d4.origin, n_move_time);
  wait n_move_time;
  mdl_target playSound(#"hash_573eeda95b9d883a");
  mdl_target setCanDamage(0);
  flag::set("shoot_target_timeout");
  level notify(#"hash_7c8a1026b606ae9c");
}

function function_efcfff5b() {
  level endon(#"hash_7c8a1026b606ae9c");

  while(true) {
    waitresult = self waittill(#"damage");
    w_weapon = waitresult.weapon;

    if(isDefined(w_weapon) && (w_weapon.firetype == "Single Shot" || w_weapon.firetype == "Burst")) {
      self playSound(#"hash_3274951195522bc0");
      level notify(#"hash_7c8a1026b606ae9c");
    }
  }
}

function function_ba11058a(var_a276c861, var_19e802fa) {}

function function_9a22f9c2() {
  var_d8f1c196 = struct::get("shoot_target", "targetname");

  if(flag::get("shoot_target_timeout")) {
    playsoundatposition(#"hash_41f370ee19a5ddc1", var_d8f1c196.origin);
    return;
  }

  playsoundatposition(#"hash_6742a6bf8c87fa0c", var_d8f1c196.origin);
  var_bc3709b9 = struct::get("s_shoot_start", "targetname");
  level thread namespace_58949729::function_f82f361c(var_bc3709b9, #"survival_aether_tool_item_list", 2, 1);
}

function function_1c35e44a(var_a276c861, var_19e802fa) {}

function function_d745ca5e(var_a276c861) {
  if(var_a276c861) {
    return;
  }

  level thread function_f602a366();
  level flag::wait_till(level.var_fd9dec51);
}

function function_f602a366() {
  level endon(#"game_ended", level.var_fd9dec51);
  var_6de806b5 = getent("t_sq_ms", "targetname");
  var_f73afc46 = 0;
  s_struct = struct::get("s_sq_ms");

  while(true) {
    waitresult = var_6de806b5 waittill(#"damage");

    if(isPlayer(waitresult.attacker) && waitresult.mod === "MOD_GRENADE_SPLASH" && !is_true(function_7fb7c83c(waitresult.weapon.name))) {
      var_f73afc46++;

      if(var_f73afc46 == 13) {
        level flag::set(level.var_fd9dec51);
        continue;
      }

      playsoundatposition(#"hash_5c495fd106561715", s_struct.origin);
    }
  }
}

function function_7fb7c83c(weaponname) {
  if(!isDefined(weaponname)) {
    return 0;
  }

  if(isweapon(weaponname)) {
    weaponname = weaponname.name;
  }

  if(weaponname === # "hash_7e4053e6965bafa7") {
    return 1;
  }

  inarray = isinarray(level.var_1b527536, weaponname);
  return inarray;
}

function function_23cef26a(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level flag::set(level.var_fd9dec51);
  }

  s_struct = struct::get("s_sq_ms");
  playsoundatposition(#"hash_3daf67f534357c93", s_struct.origin);
  n_count = 6;
  var_98d110e6 = 2;
  dropstruct = {
    #origin: s_struct.origin, #angles: s_struct.angles, #var_738dfc81: n_count
  };
  a_items = dropstruct namespace_65181344::function_fd87c780(#"hash_57d0cc12ced6ab79", n_count, var_98d110e6);

  if(level.var_d3450438 < 3) {
    level thread function_aa9d9702();
    return;
  }

  if(isDefined(getent("t_sq_ms", "targetname"))) {
    getent("t_sq_ms", "targetname") delete();
  }
}

function function_af042db0(var_a276c861) {
  if(var_a276c861) {
    return;
  }

  var_69d81f37 = randomintrangeinclusive(17, 19);
  level waittill(#"start_of_round");

  while(level.round_number < var_69d81f37) {
    level waittill(#"end_of_round");
  }

  if(level.round_number == var_69d81f37 && !level flag::get("hvt_event_steiner_spawned")) {
    iprintlnbold("<dev string:x205>");

    level.var_15a5fa7f = # "hash_4a900af3fc47cdd5";
    level.var_3db96efc = struct::get_array("mimic_item_spawn_point");
    callback::on_ai_spawned(&function_c50aa4b2);
    level thread function_6b214340();
    level waittill(#"end_of_round", #"hvt_event_steiner_spawned");
  }
}

function function_6c660ed5(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {}

  var_2a1f535d = mimic_prop_spawn::function_2e8c33f6();

  foreach(trap_prop in var_2a1f535d) {
    level thread mimic_prop_spawn::clean_up_prop(trap_prop);
  }

  callback::remove_callback(&function_c50aa4b2);
}

function function_6b214340(var_d3329483 = 1) {
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

      mdl_prop = mimic_prop_spawn::function_b309db61(var_ed94ce04, undefined, var_ed94ce04[0], #"hash_552fe46053ee49fa");

      if(isDefined(mdl_prop)) {
        mdl_prop thread function_a1c5be67();
      }

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

    println("<dev string:x21d>");
  }
}

function function_c50aa4b2() {
  self endon(#"death");

  if(self.archetype === # "mimic") {
    wait 0.5;

    if(self.targetname === "mq_hvt_mimic") {
      return;
    }

    self.ignore_enemy_count = 1;
  }
}

function function_a1c5be67() {
  self endon(#"death", #"hash_484127e0cbd8f8cb");

  while(true) {
    sphere(self.origin, 15, (1, 0, 0), 0.75);
    waitframe(1);
  }
}