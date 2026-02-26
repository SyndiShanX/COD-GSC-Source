/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_701a2fd66507646f.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_5513c8efed5ff300;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\util;
#namespace namespace_2b049a09;

function private autoexec __init__system__() {
  system::register(#"hash_635ff968b6476f85", &preload, undefined, undefined, #"collectibles");
}

function private preload() {
  clientfield::register("toplayer", "get_anagram_solution", 1, 1, "int");
  serverfield::register("anagram_solution_index", 1, int(ceil(log2(60))), "int", &function_5ecf5ec2);
  callback::on_spawned(&on_player_spawned);
  collectibles::add_callback("chaos_newspaper", &newspaper);
  collectibles::add_callback("chaos_radio_broadcast", &radio_broadcast);
  collectibles::add_callback("chaos_coded_message", &coded_message);
  collectibles::add_callback("chaos_floppy_disk", &function_af235cd2);

  if(!isDefined(level.var_455ccc8b)) {
    level.var_455ccc8b = [];
  }

  util::init_dvar("<dev string:x38>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x56>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x6e>", 0, &function_db698ba5);
  util::init_dvar("<dev string:x8c>", 0, &function_db698ba5);
  util::init_dvar("<dev string:xa8>", 0, &function_db698ba5);
  util::init_dvar("<dev string:xbb>", 0, &function_db698ba5);
}

function private function_db698ba5(dvar) {
  level.var_455ccc8b[dvar.name] = dvar.value;

  if(dvar.name == "<dev string:x56>" && is_true(level.var_455ccc8b[#"hash_2db6dee0f1729341"])) {
    thread newspaper();
    setDvar(#"hash_2db6dee0f1729341", 0);
  }

  if(dvar.name == "<dev string:x6e>" && is_true(level.var_455ccc8b[#"hash_24e6120d6a8d655d"])) {
    num_entries = max(4, level.var_455ccc8b[#"hash_24e6120d6a8d655d"]);
    thread radio_broadcast(num_entries);
    setDvar(#"hash_24e6120d6a8d655d", 0);
  }

  if(dvar.name == "<dev string:x8c>" && is_true(level.var_455ccc8b[#"hash_1412afe4a2259541"])) {
    thread coded_message();
    setDvar(#"hash_1412afe4a2259541", 0);
  }

  if(dvar.name == "<dev string:x38>" && is_true(level.var_455ccc8b[#"hash_743976f5cb9fa81c"])) {
    thread function_d444c39c(1);
    setDvar(#"hash_743976f5cb9fa81c", 0);

    if(namespace_61e6d095::exists(#"anagrams")) {
      player = getplayers()[0];

      if(isDefined(player)) {
        player endon(#"death");
        player notify(#"hash_66c52f852ccf249f");
        player flag::wait_till("<dev string:xd3>");
        thread newspaper();
      }
    }

    if(namespace_61e6d095::exists(#"coded_message")) {
      player = getplayers()[0];

      if(isDefined(player)) {
        player endon(#"death");
        player notify(#"hash_4d971fa74eb99bb7");
        player flag::wait_till("<dev string:xd3>");
        thread coded_message();
      }
    }
  }

  if(dvar.name == "<dev string:xa8>" && is_true(level.var_455ccc8b[#"hash_4c83d232b1ef9d7d"])) {
    savegame::set_player_data(#"hash_4c19b5801ce1bc5d");
    savegame::set_player_data(#"hash_af0385a1ce3480a");
    savegame::set_player_data(#"hash_7cb97d07f8fd21fc");
    savegame::set_player_data(#"hash_1a4a28d720563dea");
    savegame::set_player_data(#"hash_74dace636845482f");
    savegame::set_player_data(#"hash_84cb867109a043e");
    setDvar(#"hash_4c83d232b1ef9d7d", 0);
  }

  if(dvar.name == "<dev string:xbb>") {
    savegame::set_player_data(#"hash_84cb867109a043e", is_true(level.var_455ccc8b[#"hash_7349c63ed39bb9c"]));
  }
}

function private on_player_spawned() {
  function_9eb15176();
}

function private function_9eb15176() {
  level flag::wait_till(#"gameplay_started");
  function_d444c39c(0);
}

function private function_d444c39c(reset) {
  player = getplayers()[0];
  player endon(#"death");
  language = getdvarint(#"loc_language");

  if(!reset && language !== savegame::function_2ee66e93(#"hash_182064942fb1b0ac")) {
    reset = 1;
  }

  if(is_true(reset)) {
    savegame::set_player_data(#"hash_5dd320f3ff491aed");
    savegame::set_player_data(#"hash_6ac9f93e38b74633");
    player flag::clear("anagram_solution_set");
  }

  if(!isDefined(savegame::function_2ee66e93(#"hash_5dd320f3ff491aed")) || !isDefined(savegame::function_2ee66e93(#"hash_6ac9f93e38b74633")) || !isDefined(savegame::function_2ee66e93(#"hash_1cec68d3f5bf55f8")) || !isDefined(savegame::function_2ee66e93(#"hash_35b29e7e753dc631")) || !isDefined(savegame::function_2ee66e93(#"hash_100ec76505ac8673"))) {
    player clientfield::set_to_player("get_anagram_solution", 1);
    player flag::wait_till("anagram_solution_set");
    player clientfield::set_to_player("get_anagram_solution", 0);
    return;
  }

  player globallogic_ui::function_9ed5232e("OperationChaos.passphraseIndex", savegame::function_2ee66e93(#"hash_5dd320f3ff491aed"));
  player globallogic_ui::function_9ed5232e("OperationChaos.code", savegame::function_2ee66e93(#"hash_6ac9f93e38b74633"));
  player globallogic_ui::function_9ed5232e("OperationChaos.anagramIndex", savegame::function_2ee66e93(#"hash_1cec68d3f5bf55f8"));
  player globallogic_ui::function_9ed5232e("OperationChaos.number_sequence", savegame::function_2ee66e93(#"hash_35b29e7e753dc631"));
  player globallogic_ui::function_9ed5232e("OperationChaos.seed", savegame::function_2ee66e93(#"hash_100ec76505ac8673"));
  player globallogic_ui::function_9ed5232e("OperationChaos.passphraseRequiresList", 0);
  player globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.selectedPassphraseIndex", -1);
}

function private function_5ecf5ec2(oldval, newval) {
  if(newval > 0) {
    var_9487875 = getscriptbundle("operation_chaos_anagrams");
    seed = int((function_b6db3f71() + randomint(2147483647)) % 2147483647);
    code = randomint(10000);

    for(var_2d96435a = randomint(10000); function_7655bab6(code, var_2d96435a); var_2d96435a = randomint(10000)) {}

    player = getplayers()[0];

    if(!isPlayer(player)) {
      return;
    }

    player endon(#"death");

    if(newval > 60) {
      newval = randomint(var_9487875.anagrams.size) * -1;
    } else {
      newval--;
    }

    for(var_e9ef7dab = randomint(var_9487875.anagrams.size); var_e9ef7dab == newval; var_e9ef7dab = randomint(var_9487875.anagrams.size)) {}

    savegame::set_player_data(#"hash_182064942fb1b0ac", getdvarint(#"loc_language"));
    savegame::set_player_data(#"hash_5dd320f3ff491aed", var_e9ef7dab);
    savegame::set_player_data(#"hash_6ac9f93e38b74633", code);
    savegame::set_player_data(#"hash_1cec68d3f5bf55f8", newval);
    savegame::set_player_data(#"hash_35b29e7e753dc631", var_2d96435a);
    savegame::set_player_data(#"hash_100ec76505ac8673", seed);
    player globallogic_ui::function_9ed5232e("OperationChaos.passphraseIndex", var_e9ef7dab);
    player globallogic_ui::function_9ed5232e("OperationChaos.code", code);
    player globallogic_ui::function_9ed5232e("OperationChaos.anagramIndex", newval);
    player globallogic_ui::function_9ed5232e("OperationChaos.number_sequence", var_2d96435a);
    player globallogic_ui::function_9ed5232e("OperationChaos.seed", seed);
    player globallogic_ui::function_9ed5232e("OperationChaos.passphraseRequiresList", 0);
    player globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.selectedPassphraseIndex", -1);
    player flag::set("anagram_solution_set");
  }
}

function private function_8b02e139(vox, var_577c1b53) {
  player = self;

  if(is_true(savegame::function_2ee66e93(var_577c1b53))) {
    return;
  }

  player endoncallback(&function_b9938441, #"death", #"hash_56811b455b9b0e25");
  player dialogue::radio(vox);
  savegame::set_player_data(var_577c1b53, 1);
}

function private function_b9938441(str_notify) {
  player = self;
  player dialogue::function_9e580f95();
}

function newspaper() {
  player = getplayers()[0];
  player endon(#"death");
  var_43381ccf = savegame::function_2ee66e93(#"hash_1cec68d3f5bf55f8");
  seed = savegame::function_2ee66e93(#"hash_100ec76505ac8673");
  player globallogic_ui::function_9ed5232e("OperationChaos.anagramIndex", var_43381ccf);
  player globallogic_ui::function_9ed5232e("OperationChaos.seed", seed);
  uid = # "newspaper";
  namespace_61e6d095::create(uid, #"hash_2f387cc5510b5100");
  namespace_61e6d095::function_d3c3e5c3(uid, #"interactive_map");
  namespace_61e6d095::set_state(uid, #"defaultstate");
  var_bc8da67d = player namespace_70eba6e6::function_b6a02677();
  vox = "vox_cp_chao_01200_sims_sometimesthered_c7";

  switch (var_bc8da67d) {
    case 1:
      vox = "vox_cp_chao_01200_sims_sometimesthered_8a";
      break;
    case 2:
      vox = "vox_cp_chao_01200_sims_sometimesthered_aa";
      break;
    case 3:
      vox = "vox_cp_chao_01200_sims_sometimesthered_d6";
      break;
  }

  player thread function_8b02e139(vox, #"hash_af0385a1ce3480a");
  wait 0.5;
  namespace_61e6d095::set_state(uid, #"highlight");

  if(is_true(level.var_455ccc8b[#"hash_2db6dee0f1729341"])) {
    namespace_61e6d095::function_29703592(uid);
  }

  player namespace_61e6d095::function_b0bad5ff(#"hash_66c52f852ccf249f");
  player notify(#"hash_56811b455b9b0e25");
  player dialogue::function_9e580f95();
  namespace_61e6d095::remove(uid);
}

function radio_broadcast(params, num_entries = 10) {
  player = getplayers()[0];
  player endon(#"death");
  player thread function_8b02e139("vox_cp_chao_01300_sims_youdidgoodfindi_15", #"hash_1a4a28d720563dea");
  var_9487875 = getscriptbundle("operation_chaos_anagrams");
  var_e9ef7dab = savegame::function_2ee66e93(#"hash_5dd320f3ff491aed");
  code = savegame::function_2ee66e93(#"hash_6ac9f93e38b74633");
  var_bf871b87 = int(abs(savegame::function_2ee66e93(#"hash_1cec68d3f5bf55f8")));
  var_2d96435a = savegame::function_2ee66e93(#"hash_35b29e7e753dc631");
  seed = savegame::function_2ee66e93(#"hash_100ec76505ac8673");
  var_721f874b = getarraykeys(var_9487875.anagrams);
  arrayremovevalue(var_721f874b, var_e9ef7dab);
  arrayremovevalue(var_721f874b, var_bf871b87);
  var_28ddca2c = [];
  var_28ddca2c[var_28ddca2c.size] = {
    #var_a34b4160: var_9487875.anagrams[var_e9ef7dab].var_d0354c50, #code: var_2d96435a, #vox: var_9487875.anagrams[var_e9ef7dab].var_21d92d5d
  };
  var_28ddca2c[var_28ddca2c.size] = {
    #var_a34b4160: var_9487875.anagrams[var_bf871b87].var_d0354c50, #code: code, #vox: var_9487875.anagrams[var_bf871b87].var_21d92d5d
  };

  for(i = 3; i <= num_entries; i++) {
    var_c5973dea = 10000;

    if(i <= 4) {
      var_c5973dea /= 100;
      var_c5973dea = int(var_c5973dea);
    }

    do {
      rand = function_c9e9e505(seed, var_c5973dea);
      seed = rand.seed;
      code = rand.rand;

      if(i <= 4) {
        rand = function_c9e9e505(seed, 2);
        seed = rand.seed;
        var_fd52eb0e = var_2d96435a / 100;

        if(i == 3) {
          var_fd52eb0e = var_2d96435a - floor(var_fd52eb0e) * 100;
        }

        var_fd52eb0e = int(var_fd52eb0e);

        if(rand.rand) {
          code += var_fd52eb0e * 100;
          continue;
        }

        code = code * 100 + var_fd52eb0e;
      }
    }
    while(function_7655bab6(var_28ddca2c, code));

    rand = function_c9e9e505(seed, var_721f874b.size);
    seed = rand.seed;
    var_a34b4160 = var_9487875.anagrams[var_721f874b[rand.rand]].var_d0354c50;
    vox = var_9487875.anagrams[var_721f874b[rand.rand]].var_21d92d5d;
    arrayremoveindex(var_721f874b, rand.rand);
    var_28ddca2c[var_28ddca2c.size] = {
      #var_a34b4160: var_a34b4160, #code: code, #vox: vox
    };
  }

  for(i = 0; i < var_28ddca2c.size; i++) {
    rand = function_c9e9e505(seed, var_28ddca2c.size);
    seed = rand.seed;
    temp = var_28ddca2c[i];
    var_28ddca2c[i] = var_28ddca2c[rand.rand];
    var_28ddca2c[rand.rand] = temp;
  }

  uid = # "radio_broadcast";
  namespace_61e6d095::create(uid, #"hash_7c7836c3804a86a6");
  namespace_61e6d095::function_d3c3e5c3(uid, #"interactive_map");
  namespace_61e6d095::function_46df0bc7(uid, 50);

  if(is_true(level.var_455ccc8b[#"hash_24e6120d6a8d655d"])) {
    namespace_61e6d095::function_29703592(uid);
  }

  namespace_61e6d095::function_9ade1d9b(uid, "title", params.title);
  namespace_61e6d095::function_9ade1d9b(uid, "layout", 1);

  for(i = 0; i < var_28ddca2c.size; i++) {
    namespace_61e6d095::function_f2a9266(uid, i, "name", var_28ddca2c[i].var_a34b4160);
    var_d03b4642 = string(var_28ddca2c[i].code, 4);
    namespace_61e6d095::function_f2a9266(uid, i, "subtitle", var_d03b4642[0] + "," + var_d03b4642[1] + "," + var_d03b4642[2] + "," + var_d03b4642[3]);
  }

  player childthread function_a3fafde(uid, var_28ddca2c);
  player namespace_61e6d095::function_b0bad5ff();
  player notify(#"hash_56811b455b9b0e25");
  player dialogue::function_9e580f95();
  namespace_61e6d095::remove(uid);
  snd::stop(level.var_fe8836d6);
  snd::stop(level.var_f0aaf5b5);
  snd::stop(level.var_751ee7b2);

  if(player flag::get(#"hash_44be91b15efaf83d")) {
    snd::play("uin_evidence_broadcast_end");
    wait 0.3;
    player flag::clear(#"hash_44be91b15efaf83d");
  }
}

function private function_a3fafde(uid, var_28ddca2c) {
  self endon(#"death", #"hash_56811b455b9b0e25");

  for(var_57431990 = 0; true; var_57431990 = 1) {
    var_674fe008 = ["vox_cp_sh0_02000_fbro_zero_a0", "vox_cp_chao_02000_fbro_one_22", "vox_cp_chao_02000_fbro_two_3a", "vox_cp_chao_02000_fbro_three_f8", "vox_cp_chao_02000_fbro_four_9c", "vox_cp_chao_02000_fbro_five_8a", "vox_cp_chao_02000_fbro_six_34", "vox_cp_chao_02000_fbro_seven_01", "vox_cp_chao_02000_fbro_eight_f1", "vox_cp_chao_02000_fbro_nine_8a"];
    snd::play("uin_evidence_broadcast_start");
    level.var_751ee7b2 = snd::play("uin_evidence_broadcast_static_loop");
    self flag::set(#"hash_44be91b15efaf83d");

    if(!var_57431990 && isDefined(self.player_radio_emitter)) {
      self.player_radio_emitter waittill(#"hash_655372c132a19d0a");
      level.var_fe8836d6 = snd::play("uin_evidence_broadcast_static_melody");
      wait 4;
    }

    for(i = 0; i < var_28ddca2c.size; i++) {
      wait randomfloatrange(0.5, 0.7);
      level.var_f0aaf5b5 = snd::play("uin_evidence_broadcast_beeps_between_lines");
      namespace_61e6d095::function_9ade1d9b(uid, "audioWave", randomintrange(1, 4));
      wait randomfloatrange(0.9, 1.1);
      self dialogue::radio(var_28ddca2c[i].vox);
      namespace_61e6d095::function_9ade1d9b(uid, "audioWave", randomintrange(1, 4));
      wait randomfloatrange(0.3, 0.5);
      var_a70a37a2 = string(var_28ddca2c[i].code, 4);

      for(str_index = 0; str_index < 4; str_index++) {
        namespace_61e6d095::function_9ade1d9b(uid, "audioWave", randomintrange(1, 4));
        self dialogue::radio(var_674fe008[int(getsubstr(var_a70a37a2, str_index, str_index + 1))]);
        wait randomfloatrange(0.15, 0.3);
      }
    }

    self flag::clear(#"hash_44be91b15efaf83d");
    snd::play("uin_evidence_broadcast_end");
    wait 0.3;
    snd::stop(level.var_751ee7b2);
    namespace_61e6d095::function_9ade1d9b(uid, "audioWave", 0);
    wait 1;
    namespace_c8e236da::removelist();
    namespace_c8e236da::function_ebf737f8(#"hash_3893375dc8d4a2a2");
    namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
    self waittill(#"ui_alt1");
    namespace_c8e236da::removelist();
    namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
  }
}

function coded_message() {
  player = getplayers()[0];
  player endon(#"death");
  code = savegame::function_2ee66e93(#"hash_35b29e7e753dc631");
  seed = savegame::function_2ee66e93(#"hash_100ec76505ac8673");
  player globallogic_ui::function_9ed5232e("OperationChaos.number_sequence", code);
  player globallogic_ui::function_9ed5232e("OperationChaos.seed", seed);
  uid = # "coded_message";
  namespace_61e6d095::create(uid, #"hash_29246bd6b5d544d2");
  namespace_61e6d095::function_d3c3e5c3(uid, #"interactive_map");
  namespace_61e6d095::function_f942c3ed(uid, "DefaultClip");

  if(is_true(level.var_455ccc8b[#"hash_1412afe4a2259541"])) {
    namespace_61e6d095::function_29703592(uid);
  }

  player thread function_8b02e139("vox_cp_chao_01400_sims_aftermasonbroug_51", #"hash_7cb97d07f8fd21fc");
  waitframe(1);
  namespace_61e6d095::function_f942c3ed(uid, "Reveal");
  player namespace_61e6d095::function_b0bad5ff(#"hash_4d971fa74eb99bb7");
  player notify(#"hash_56811b455b9b0e25");
  player dialogue::function_9e580f95();
  namespace_61e6d095::remove(uid);
}

function function_af235cd2() {
  player = getplayers()[0];
  player endon(#"death");
  var_239b86f4 = player_decision::function_ee124ba3();

  if(!player gamepadusedlast()) {
    namespace_c8e236da::removelist();
    namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
  }

  thread util::screen_fade_out(0.15);
  namespace_6f1d35e1::function_b2911127(0);
  var_2f8f8378 = clientfield::get_to_player("set_hub_dof");
  var_5a0a6894 = clientfield::get_to_player("set_hub_fov");
  var_1464e28f = player clientfield::get_to_player("pstfx_t9_cp_hub_eboard_vignette");
  overview = player clientfield::get_to_player("pstfx_t9_cp_hub_eboard_overview");
  link_ent = player getlinkedent();
  playerpos = player getplayercamerapos();
  playerangles = player getplayerangles();
  wait 0.25;

  if(!var_239b86f4) {
    player thread function_8b02e139("vox_cp_chao_01500_sims_ifwedecryptthep_4d", #"hash_74dace636845482f");
  }

  player clientfield::set_to_player("set_hub_dof", 1);
  player clientfield::set_to_player("set_hub_fov", 2);
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 0);
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", 0);
  shot = undefined;
  scenes = level scene::get_active_scenes("scene_hub_eboard_handler");

  foreach(scene in scenes) {
    if(isDefined(scene.last_scene_state_instance[#"scene_hub_eboard_handler"])) {
      shot = scene.last_scene_state_instance[#"scene_hub_eboard_handler"];
      break;
    }
  }

  level scene::stop("scene_hub_eboard_handler");
  player unlink();
  var_7ab1a25c = struct::get("computer_camera_position");
  player camerasetposition(var_7ab1a25c.origin, var_7ab1a25c.angles);
  thread util::screen_fade_in(0.25);
  namespace_61e6d095::function_4279fd02(#"interactive_map");

  if(var_239b86f4) {
    namespace_6f1d35e1::function_eea42dd9(#"hash_53e6026705a8bb51", 1);
    namespace_6f1d35e1::function_487b4340(#"hash_678fbc89038dae9a", 0);
    namespace_6f1d35e1::function_5d2e6f6a(1);
    namespace_6f1d35e1::function_314087bb(1);
    namespace_6f1d35e1::function_314087bb(2);
    namespace_6f1d35e1::function_314087bb(3);
    waitframe(1);
    namespace_6f1d35e1::function_487b4340(#"hash_40e0008de7869982");
    namespace_6f1d35e1::function_d599de13(2);
    player playSound(#"hash_630b57e974ec901a");
    namespace_6f1d35e1::function_4951a2c8(1, 2);
    namespace_61e6d095::function_b0bad5ff();
  } else {
    var_795ae76c = 1;

    while(var_795ae76c) {
      namespace_6f1d35e1::function_eea42dd9(#"hash_53e6026705a8bb51", 1);
      namespace_6f1d35e1::function_487b4340(#"hash_678fbc89038dae9a", 0);
      namespace_6f1d35e1::function_5d2e6f6a(1);
      namespace_6f1d35e1::function_314087bb(1);
      namespace_6f1d35e1::function_4951a2c8(1, 1);
      namespace_6f1d35e1::ShowNewLineMarker(1, 1);
      namespace_6f1d35e1::function_635c370c(1, ispc());
      player playSound(#"hash_38485c0454d594f4");
      namespace_6f1d35e1::function_8a58b10c(1, 2);
      namespace_6f1d35e1::function_29438cc(1, 4);
      namespace_6f1d35e1::function_28321961(1, 1);
      namespace_6f1d35e1::function_7bfd800c(1, 0);
      namespace_6f1d35e1::function_be760dc8(1, 9999);
      namespace_6f1d35e1::function_9806766(1, "");
      namespace_6f1d35e1::function_6ed8776d(1, 1);
      var_3d79eff5 = 0;

      while(true) {
        response = player function_7cfb600();

        if(is_true(response)) {
          entry = namespace_6f1d35e1::function_f887fdff(1);

          if(entry.size == 4) {
            player globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.code", entry);
            var_3d79eff5 = 1;
            break;
          }

          if(!ispc()) {
            ret = player waittill(#"ui_confirm", #"ui_cancel");

            if(ret._notify === # "ui_confirm") {
              namespace_6f1d35e1::function_6ed8776d(1, 1, 1);
            } else {
              break;
            }

            continue;
          }

          break;
        }
      }

      if(is_true(var_3d79eff5)) {
        var_1618bd5b = player globallogic_ui::function_f053dcd4("OperationChaos.passphraseRequiresList");
        namespace_6f1d35e1::function_6ed8776d(1, 0);
        namespace_6f1d35e1::function_635c370c(1, 1);
        namespace_6f1d35e1::function_314087bb(2);
        namespace_6f1d35e1::function_4951a2c8(2, 1);
        namespace_6f1d35e1::function_8a58b10c(2, 0);
        namespace_6f1d35e1::function_29438cc(2, 30);
        namespace_6f1d35e1::function_9806766(2, "");
        namespace_6f1d35e1::ShowNewLineMarker(2, 1);
        namespace_6f1d35e1::function_635c370c(2, ispc());
        authenticate = 0;

        if(var_1618bd5b) {
          player function_5b15c4b3();
          authenticate = 1;
        } else {
          namespace_6f1d35e1::function_6ed8776d(2, 1);
          wait 0.1;

          while(true) {
            response = player function_7cfb600();

            if(is_true(response)) {
              entry = namespace_6f1d35e1::function_f887fdff(2);

              if(entry.size > 0) {
                player globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.passphrase", entry);
                authenticate = 1;
                break;
              }

              if(!ispc()) {
                ret = player waittill(#"ui_confirm", #"ui_cancel");

                if(ret._notify === # "ui_confirm") {
                  namespace_6f1d35e1::function_6ed8776d(2, 1, 1);
                } else {
                  break;
                }

                continue;
              }

              break;
            }
          }
        }

        player flag::wait_till_clear_all([#"ui_confirm", #"ui_cancel"]);

        if(is_true(authenticate)) {
          namespace_6f1d35e1::function_635c370c(2, 1);
          namespace_6f1d35e1::function_314087bb(3);
          namespace_6f1d35e1::function_4951a2c8(3, 1);
          namespace_6f1d35e1::ShowNewLineMarker(3, 1);
          namespace_6f1d35e1::function_635c370c(3, 0);
          namespace_c8e236da::function_abdf062(0, #"hash_1e1dd49ffc599897");
          ret = player waittill(#"ui_confirm", #"ui_cancel");
          player playSound(#"hash_4bf3fb6e8fee5573");
          namespace_c8e236da::function_bf642b41(0);

          if(ret._notify == # "ui_confirm") {
            namespace_6f1d35e1::function_6f9dba44(3, #"hash_3e2eeb47e243c784");
            namespace_6f1d35e1::function_635c370c(3, 1);
            wait 0.1;
            player globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.authenticate", 1, undefined, 1, undefined, undefined, 1);
            result = player waittillmatch({
              #menu: # "ScriptedHudWidgetMenu", #response: # "authentication"}, #"menuresponse");

            if(result.intpayload == 0) {
              player playSound(#"hash_3582a6ca8d3b7d86");
              namespace_6f1d35e1::function_d599de13(0);
              wait 2;
            } else {
              namespace_6f1d35e1::function_d599de13(1);
              var_795ae76c = 0;

              if(!is_true(savegame::function_2ee66e93(#"hash_84cb867109a043e"))) {
                player dialogue::function_9e580f95();
                player util::delay(1, undefined, &dialogue::radio, "vox_cp_chao_01600_sims_hellyeahthatsit_51");
              }
            }

            wait 2;
          } else {
            namespace_6f1d35e1::function_6f9dba44(3, #"hash_7459144792eda2c6");
            namespace_6f1d35e1::function_635c370c(3, 1);
            wait 0.1;
            player flag::wait_till_clear_all([#"ui_confirm", #"ui_cancel"]);
          }
        }

        continue;
      }

      break;
    }

    if(!var_795ae76c) {
      wait 2;
      player playSound(#"hash_630b57e974ec901a");
      namespace_6f1d35e1::function_487b4340(#"hash_40e0008de7869982");
      namespace_6f1d35e1::function_d599de13(2);
      namespace_6f1d35e1::function_4951a2c8(1, 2);
      wait 6;
      player_decision::function_557c31b1();

      if(is_true(savegame::function_2ee66e93(#"hash_84cb867109a043e"))) {
        savegame::set_player_data(#"hash_84cb867109a043e", 1);
      }

      savegame::save();
    }
  }

  player flag::wait_till_clear_all([#"ui_confirm", #"ui_cancel"]);
  thread util::screen_fade_out(0.15);
  wait 0.15;
  player clientfield::set_to_player("set_hub_dof", var_2f8f8378);
  player clientfield::set_to_player("set_hub_fov", var_5a0a6894);
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", var_1464e28f);
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", overview);
  player unlink();
  player playerlinkto(link_ent, "tag_origin");
  waitframe(1);
  player camerasetposition(playerpos, playerangles);

  if(isDefined(shot)) {
    level thread scene::play("scene_hub_eboard_handler", shot);
  }

  wait 0.1;
  namespace_6f1d35e1::function_b2911127(0);
  thread util::screen_fade_in(0.15);
  wait 0.15;
  namespace_61e6d095::function_28027c42(#"interactive_map");
}

function private function_5b15c4b3() {
  var_9487875 = getscriptbundle("operation_chaos_anagrams");
  namespace_61e6d095::create(#"dialog_tree", #"hash_5ee7619b9b614d34");
  namespace_61e6d095::function_d3c3e5c3(#"dialog_tree", [#"interactive_map", #"computer", #"dialog_tree"]);
  namespace_61e6d095::set_x(#"dialog_tree", 590);
  namespace_61e6d095::set_y(#"dialog_tree", 500);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "index", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "timeOut", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "stateIndex", 1);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "optionSelected", 0);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "kbmIndexSelected", -1);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "isActive", 1);
  namespace_61e6d095::function_9ade1d9b(#"dialog_tree", "listVcount", 6);

  foreach(index, var_d0354c50 in var_9487875.anagrams) {
    namespace_61e6d095::function_f2a9266(#"dialog_tree", index, "dialogString", var_d0354c50.var_d0354c50);
  }

  namespace_61e6d095::function_73c9a490(#"dialog_tree", 1);
  namespace_6f1d35e1::function_f6fbe41(2, #"");
  selected = level waittill(#"dialog_tree_option_selected");
  self globallogic_ui::function_9ed5232e("OperationChaos.floppyEntry.selectedPassphraseIndex", selected.optindex);
  namespace_6f1d35e1::function_f6fbe41(2, var_9487875.anagrams[selected.optindex].var_d0354c50);
  namespace_61e6d095::remove(#"dialog_tree");
}

function private function_7cfb600() {
  self endon(#"death", #"ui_cancel");
  self waittillmatch({
    #menu: # "ScriptedHudWidgetMenu", #response: # "hash_260e4568c570b4ba"}, #"menuresponse");
  self playSound(#"hash_4bf3fb6e8fee5573");
  return true;
}

function private function_7655bab6(var_df3d8ccf, var_947f605b) {
  var_be3496f3 = floor(var_947f605b / 100);
  var_2f18ad1 = var_947f605b - var_be3496f3 * 100;

  if(!isDefined(var_df3d8ccf)) {
    var_df3d8ccf = [];
  } else if(!isarray(var_df3d8ccf)) {
    var_df3d8ccf = array(var_df3d8ccf);
  }

  foreach(code in var_df3d8ccf) {
    if(isstruct(code)) {
      code = code.code;
    }

    var_34a354e2 = floor(code / 100);
    var_7535d84c = code - var_34a354e2 * 100;

    if(code == var_947f605b || var_34a354e2 == var_2f18ad1 && var_7535d84c == var_be3496f3) {
      return true;
    }
  }

  return false;
}