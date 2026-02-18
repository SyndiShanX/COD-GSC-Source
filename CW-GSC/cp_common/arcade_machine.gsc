/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\arcade_machine.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\ui\prompts;
#namespace arcade_machine;

function private autoexec __init__system__() {
  system::register(#"arcade_machine", undefined, undefined, undefined, undefined);
}

function private function_7718419d(var_c93cfecf = "") {
  if(!namespace_61e6d095::exists(#"hash_541706109c2cadca")) {
    namespace_61e6d095::create(#"hash_541706109c2cadca", #"hash_6db62876e543d679");
  }

  function_62443495(var_c93cfecf);
}

function private function_62443495(var_c93cfecf = "") {
  if(var_c93cfecf == # "game_select") {
    namespace_61e6d095::function_73c9a490(#"hash_541706109c2cadca", 1);
    namespace_61e6d095::function_9ade1d9b(#"hash_541706109c2cadca", "useGameSelect", 1);
    namespace_61e6d095::function_9ade1d9b(#"hash_541706109c2cadca", "gameRef", "");
    return;
  }

  function_633f25cf(var_c93cfecf);
  namespace_61e6d095::function_9ade1d9b(#"hash_541706109c2cadca", "useGameSelect", 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_541706109c2cadca", "gameRef", var_c93cfecf);
}

function function_633f25cf(var_c93cfecf) {
  if(!isDefined(var_c93cfecf) || var_c93cfecf == "") {
    return;
  }

  player = getplayers()[0];

  if(!player stats::function_e3eb9a8b(#"hash_4bc6f04ed9a574bc", var_c93cfecf)) {
    if(player stats::function_505387a6(#"hash_4bc6f04ed9a574bc", var_c93cfecf, 1)) {
      level thread function_5058f233(var_c93cfecf);
    }
  }

  var_98196ab3 = 0;

  for(i = 0; i < 10; i++) {
    if(player stats::function_e3eb9a8b(#"hash_4bc6f04ed9a574bc", i)) {
      var_98196ab3++;
    }
  }

  if(var_98196ab3 >= 10) {
    player stats::function_dad108fa(#"hash_2ab499ed268510cc", 1);
  }

  uploadstats(player);
}

function private function_b2669077() {
  namespace_61e6d095::function_9ade1d9b(#"hash_541706109c2cadca", "gameRef", "");

  if(namespace_61e6d095::exists(#"hash_541706109c2cadca")) {
    namespace_61e6d095::remove(#"hash_541706109c2cadca");
    namespace_61e6d095::function_29703592(#"hash_541706109c2cadca", 0);
  }
}

function function_5058f233(var_c93cfecf, var_c18a5a8b = 5) {
  if(namespace_61e6d095::exists(#"hash_1f8eeac8bf3b0e9b")) {
    namespace_61e6d095::remove(#"hash_1f8eeac8bf3b0e9b");
  }

  var_ae865aeb = getscriptbundle(var_c93cfecf);
  previewimage = # "";

  if(isDefined(var_ae865aeb) && isDefined(var_ae865aeb.previewimage)) {
    previewimage = var_ae865aeb.previewimage;
  }

  namespace_61e6d095::create(#"hash_1f8eeac8bf3b0e9b", #"hash_11f17c2c3c32912d");
  namespace_61e6d095::function_46df0bc7(#"hash_1f8eeac8bf3b0e9b", 5);
  namespace_61e6d095::function_9ade1d9b(#"hash_1f8eeac8bf3b0e9b", "image", previewimage);

  if(var_c18a5a8b >= float(function_60d95f53()) / 1000) {
    wait var_c18a5a8b;
  }

  if(namespace_61e6d095::exists(#"hash_1f8eeac8bf3b0e9b")) {
    namespace_61e6d095::remove(#"hash_1f8eeac8bf3b0e9b");
  }
}

function function_bafc791c() {
  self prompts::set_text(#"hash_13887dbed82d18b3");
  self prompts::function_309bf7c2(#"hash_3f3936e8e8c3de2b");
}

function private function_8de07df8(var_cffbeaae, var_f35de83) {
  var_cffbeaae.origin = var_f35de83.origin;
  var_cffbeaae.angles = var_f35de83.angles;
  vec_right = anglestoright(self.angles);
  vec_to_player = vectornormalize(level.player getplayercamerapos() - self.origin);
  n_dot = vectordot(vec_right, vec_to_player);

  if(abs(n_dot) < 0.3) {
    var_a16bf7b3 = "player_center_enter";
  } else {
    var_a16bf7b3 = vectordot(vec_right, vec_to_player) > 0 ? "player_left_enter" : "player_right_enter";
  }

  level.player function_44d63ecd(0, 0.8);
  var_cffbeaae scene::play(var_a16bf7b3);
  var_cffbeaae thread scene::play("player_loop");
}

function private function_9062877b(var_cffbeaae) {
  var_cffbeaae scene::play("player_exit");
}

function private function_eee069b6(b_enable) {
  if(is_true(b_enable)) {
    level.player val::set(#"arcade_machine", "show_weapon_hud", 0);
    level.player val::set(#"arcade_machine", "show_crosshair", 0);
    level.player val::set(#"arcade_machine", "disable_weapons", 1);
    level.player val::set(#"arcade_machine", "freezecontrols_allowlook", 1);
    namespace_82bfe441::fade(1, "FadeImmediate");
    return;
  }

  level.player val::reset_all(#"arcade_machine");
  namespace_82bfe441::fade(0, "FadeMedium");
}

function play() {
  if(!isDefined(level.player)) {
    level.player = getplayers()[0];
  }

  level.player flag::set(#"playing_arcade_game");
  function_eee069b6(1);
  var_cffbeaae = struct::get(#"hash_23c049910e1e4a97");
  assert(isDefined(var_cffbeaae));
  assert(isDefined(self.target));
  var_f35de83 = struct::get(self.target);
  self function_8de07df8(var_cffbeaae, var_f35de83);

  if(isDefined(self.script_noteworthy)) {
    function_7718419d(self.script_noteworthy);

    if(isDefined(var_f35de83.target)) {
      var_ca4dc1d1 = getdynentarray(var_f35de83.target, 1);
      assert(var_ca4dc1d1.size == 1);
      level.player thread function_939f5cad(var_ca4dc1d1[0]);
    }
  }
}

function private function_939f5cad(machine) {
  self notify("77bacd1333d8cd85");
  self endon("77bacd1333d8cd85");
  self endon(#"death", #"hash_763ad9ddb7081df4");

  do {
    waitresult = self waittill(#"menuresponse");
    menu = waitresult.menu;
    response = waitresult.response;
    value = waitresult.intpayload;

    if(response == "arcade_state") {
      setdynentstate(machine, value);
    }
  }
  while(self flag::get(#"playing_arcade_game"));
}

function exit() {
  if(!isDefined(level.player)) {
    level.player = getplayers()[0];
  }

  var_cffbeaae = struct::get(#"hash_23c049910e1e4a97");
  assert(isDefined(var_cffbeaae));
  assert(isDefined(self.target));
  var_f35de83 = struct::get(self.target);
  function_b2669077();

  if(isDefined(var_f35de83.target)) {
    var_ca4dc1d1 = getdynentarray(struct::get(self.target).target, 1);
    assert(var_ca4dc1d1.size == 1);
    setdynentstate(var_ca4dc1d1[0], 0);
  }

  level.player function_44d63ecd(1, 0.6);
  self function_9062877b(var_cffbeaae);
  function_eee069b6(0);
  level.player flag::clear(#"playing_arcade_game");
  level.player notify(#"hash_763ad9ddb7081df4");
}

function function_71510186() {
  if(!isDefined(level.player)) {
    level.player = getplayers()[0];
  }

  level.player function_d6faeb2b();
}

function private function_d6faeb2b() {
  self endon(#"death");

  while(!self gamepadusedlast() && self useButtonPressed()) {
    waitframe(1);
  }

  while(true) {
    isusinggamepad = self gamepadusedlast();

    if(isusinggamepad && self namespace_61e6d095::function_70217795() || !isusinggamepad && self useButtonPressed()) {
      self notify(#"request_menu_exit");
      break;
    }

    waitframe(1);
  }
}