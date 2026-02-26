/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\player_decision.gsc
***********************************************/

#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\gametypes\save;
#namespace player_decision;

function private autoexec __init__system__() {
  system::register("player_decision", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.var_cc2922d)) {
    level.var_cc2922d = [];
  }

  util::init_dvar("<dev string:x38>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x57>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x76>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x9a>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xba>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xdb>", -1, &function_db698ba5);
  util::init_dvar("<dev string:xfb>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x11c>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x144>", -1, &function_db698ba5);
  util::init_dvar("<dev string:x168>", -1, &function_db698ba5);
}

function private function_db698ba5(dvar) {
  level.var_cc2922d[dvar.name] = int(dvar.value);
}

function private function_4f0f89(var_6176a8ab, var_de282b38) {
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(!isDefined(var_6c8b1954.var_6e64bcd)) {
    var_6c8b1954.var_6e64bcd = [];
  } else if(!isarray(var_6c8b1954.var_6e64bcd)) {
    var_6c8b1954.var_6e64bcd = array(var_6c8b1954.var_6e64bcd);
  }

  var_6c8b1954.var_6e64bcd[var_6176a8ab] = var_de282b38;
}

function private function_9240114e(var_6176a8ab, default_value) {
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(isDefined(var_6c8b1954.var_6e64bcd[var_6176a8ab])) {
    return var_6c8b1954.var_6e64bcd[var_6176a8ab];
  }

  return savegame::function_2ee66e93(var_6176a8ab, default_value);
}

function function_d04c220e() {
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(!isDefined(var_6c8b1954.var_6e64bcd)) {
    return;
  }

  foreach(var_6176a8ab, var_de282b38 in var_6c8b1954.var_6e64bcd) {
    savegame::set_player_data(var_6176a8ab, var_de282b38);
  }
}

function function_ff7e19cb(var_6aeabb95) {
  var_2c1ecd1d = [0, 1, 2];

  if(!isinarray(var_2c1ecd1d, var_6aeabb95)) {
    assertmsg("<dev string:x188>" + var_6aeabb95);
  }

  function_4f0f89(#"living_ally", var_6aeabb95);

  if(var_6aeabb95 == 2) {
    getplayers()[0] stats::function_dad108fa(#"hash_2fe1208e904dc380", 1);
  }
}

function function_1c4fb6d4() {
  var_313a5853 = int(function_9240114e(#"living_ally", 0));

  if(level.var_cc2922d[#"hash_3c471eb0b4890d28"] >= 0) {
    var_313a5853 = level.var_cc2922d[#"hash_3c471eb0b4890d28"];
  }

  var_2c1ecd1d = [0, 1, 2];

  if(!isinarray(var_2c1ecd1d, var_313a5853)) {
    assertmsg("<dev string:x1d3>" + var_313a5853);
  }

  return var_313a5853;
}

function function_cde4f4e9(var_fda79bf3) {
  var_2c1ecd1d = [0, 1];

  if(!isinarray(var_2c1ecd1d, var_fda79bf3)) {
    assertmsg("<dev string:x21e>" + var_fda79bf3);
  }

  function_4f0f89(#"duga_ambush", var_fda79bf3);
}

function function_d9f060cc() {
  var_fda79bf3 = int(function_9240114e(#"duga_ambush", 0));

  if(level.var_cc2922d[#"hash_1d0ba9436c1b8160"] >= 0) {
    var_fda79bf3 = level.var_cc2922d[#"hash_1d0ba9436c1b8160"];
  }

  var_2c1ecd1d = [0, 1];

  if(!isinarray(var_2c1ecd1d, var_fda79bf3)) {
    assertmsg("<dev string:x1d3>" + var_fda79bf3);
  }

  return var_fda79bf3;
}

function function_83bb4d9c(iskilled) {
  function_4f0f89(#"informant_killed", iskilled);
}

function function_2da4c32c() {
  if(level.var_cc2922d[#"hash_4ba5f5e5135a166e"] >= 0) {
    return level.var_cc2922d[#"hash_4ba5f5e5135a166e"];
  }

  return function_9240114e(#"informant_killed", 0);
}

function function_a029a114(iskilled) {
  function_4f0f89(#"hash_2209b7d4d5e867da", iskilled);

  if(!iskilled) {
    getplayers()[0] stats::function_dad108fa(#"hash_397cbd8ba6842423", 1);
  }
}

function function_251a57bb() {
  if(level.var_cc2922d[#"hash_3ac48e6f15883c17"] >= 0) {
    return level.var_cc2922d[#"hash_3ac48e6f15883c17"];
  }

  return function_9240114e(#"hash_2209b7d4d5e867da", 0);
}

function function_5d2eb7fa(iskilled) {
  function_4f0f89(#"volkov_killed", iskilled);

  if(!iskilled) {
    getplayers()[0] stats::function_dad108fa(#"hash_a8df4bf1b167949", 1);
    return;
  }

  getplayers()[0] stats::function_dad108fa(#"hash_3449b16b901d6430", 1);
}

function function_5584c739() {
  if(level.var_cc2922d[#"hash_653b4358e2685205"] >= 0) {
    return level.var_cc2922d[#"hash_653b4358e2685205"];
  }

  return function_9240114e(#"volkov_killed", 0);
}

function function_b95efbcd(iskilled) {
  function_4f0f89(#"hash_2c88ea06da308fcc", iskilled);
}

function function_733a5c27() {
  if(level.var_cc2922d[#"hash_5050d4ae63037c35"] >= 0) {
    return level.var_cc2922d[#"hash_5050d4ae63037c35"];
  }

  return function_9240114e(#"hash_2c88ea06da308fcc", 0);
}

function function_fc8e281d() {
  if(level.var_cc2922d[#"hash_709460f14c72da1d"] >= 0) {
    return level.var_cc2922d[#"hash_709460f14c72da1d"];
  }

  return savegame::function_ac15668a(#"cp_sidemission_tundra");
}

function function_e0bd7f7a(var_b8291d8f) {
  assert(var_b8291d8f <= 3);
  savegame::set_player_data(#"hash_ce196830d20c798", var_b8291d8f);
}

function function_e40c7d56() {
  if(level.var_cc2922d[#"hash_395dca7924a7661c"] >= 0) {
    return level.var_cc2922d[#"hash_395dca7924a7661c"];
  }

  if(!function_fc8e281d()) {
    return 0;
  }

  return savegame::function_2ee66e93(#"hash_ce196830d20c798", 0);
}

function function_557c31b1() {
  savegame::set_player_data(#"hash_1353a738ffed49d7", 1);
  getplayers()[0] stats::function_dad108fa(#"hash_40fb0ec1661625f4", 1);
}

function function_ee124ba3() {
  if(level.var_cc2922d[#"hash_9b807de107e21ef"] >= 0) {
    return level.var_cc2922d[#"hash_9b807de107e21ef"];
  }

  return savegame::function_2ee66e93(#"hash_1353a738ffed49d7", 0);
}

function function_c8718964() {
  if(level.var_cc2922d[#"hash_2576aa389eb6fa86"] >= 0) {
    return level.var_cc2922d[#"hash_2576aa389eb6fa86"];
  }

  return savegame::function_ac15668a(#"cp_sidemission_takedown");
}

function function_8c0836dd(var_2b7725a) {
  assert(var_2b7725a >= 0 && var_2b7725a < 10);
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(!isDefined(var_6c8b1954.var_f4d7790b)) {
    var_6c8b1954.var_f4d7790b = [];
  } else if(!isarray(var_6c8b1954.var_f4d7790b)) {
    var_6c8b1954.var_f4d7790b = array(var_6c8b1954.var_f4d7790b);
  }

  if(!isDefined(var_6c8b1954.var_f4d7790b)) {
    var_6c8b1954.var_f4d7790b = [];
  } else if(!isarray(var_6c8b1954.var_f4d7790b)) {
    var_6c8b1954.var_f4d7790b = array(var_6c8b1954.var_f4d7790b);
  }

  if(!isinarray(var_6c8b1954.var_f4d7790b, var_2b7725a)) {
    var_6c8b1954.var_f4d7790b[var_6c8b1954.var_f4d7790b.size] = var_2b7725a;
  }
}

function function_430ebd4b(var_2b7725a, var_2a51713) {
  if(is_true(collectibles::function_ab921f3d(var_2a51713))) {
    function_8c0836dd(var_2b7725a);
  }
}

function function_6efc0ff8(var_3740aa91, var_2b7725a) {
  assert(var_2b7725a >= 0 && var_2b7725a < 10);
  current_mission = savegame::function_8136eb5a();

  if(var_3740aa91 == current_mission) {
    var_6c8b1954 = savegame::function_6440b06b(#"transient");

    if(isDefined(var_6c8b1954.var_f4d7790b) && isinarray(var_6c8b1954.var_f4d7790b, var_2b7725a)) {
      return 1;
    }
  }

  player = getplayers()[0];
  return player stats::get_stat(#"mapdata", var_3740aa91, #"hash_43a738b893199779", var_2b7725a);
}

function function_ef22e409() {
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(!isDefined(var_6c8b1954.var_f4d7790b)) {
    return;
  }

  player = getplayers()[0];
  current_mission = savegame::function_8136eb5a();

  for(var_2b7725a = 0; var_2b7725a < 10; var_2b7725a++) {
    if(isinarray(var_6c8b1954.var_f4d7790b, var_2b7725a)) {
      player stats::set_stat(#"mapdata", current_mission, #"hash_43a738b893199779", var_2b7725a, 1);
      continue;
    }

    player stats::set_stat(#"mapdata", current_mission, #"hash_43a738b893199779", var_2b7725a, 0);
  }

  player function_d0c3d0ce();
  uploadstats(player);
}

function private function_d0c3d0ce() {
  player = self;
  current_mission = savegame::function_8136eb5a();
  var_6c8b1954 = savegame::function_6440b06b(#"transient");

  if(current_mission == # "cp_ger_stakeout") {
    if(!isinarray(var_6c8b1954.var_f4d7790b, 4)) {
      player stats::set_stat(#"mapdata", #"cp_rus_kgb", #"hash_43a738b893199779", 2, 0);
    }

    return;
  }

  if(current_mission == # "cp_ger_hub8") {
    if(isinarray(var_6c8b1954.var_f4d7790b, 0)) {
      player stats::set_stat(#"mapdata", #"cp_rus_duga", #"hash_43a738b893199779", 0, 0);
      player stats::set_stat(#"mapdata", #"cp_rus_duga", #"hash_43a738b893199779", 1, 0);
    }

    if(isinarray(var_6c8b1954.var_f4d7790b, 1)) {
      player stats::set_stat(#"mapdata", #"cp_rus_siege", #"hash_43a738b893199779", 0, 0);
    }

    return;
  }

  if(current_mission == # "cp_rus_siege") {
    if(isinarray(var_6c8b1954.var_f4d7790b, 0)) {
      player stats::set_stat(#"mapdata", #"cp_rus_duga", #"hash_43a738b893199779", 0, 0);
      player stats::set_stat(#"mapdata", #"cp_rus_duga", #"hash_43a738b893199779", 1, 0);
      player stats::set_stat(#"mapdata", #"cp_ger_hub8", #"hash_43a738b893199779", 0, 1);
      player stats::set_stat(#"mapdata", #"cp_ger_hub8", #"hash_43a738b893199779", 1, 0);
      player stats::set_stat(#"mapdata", #"cp_ger_hub8", #"hash_43a738b893199779", 2, 0);
    }

    return;
  }

  if(current_mission == # "cp_rus_duga") {
    if(isinarray(var_6c8b1954.var_f4d7790b, 0)) {
      player stats::set_stat(#"mapdata", #"cp_rus_siege", #"hash_43a738b893199779", 0, 0);
      player stats::set_stat(#"mapdata", #"cp_ger_hub8", #"hash_43a738b893199779", 0, 0);
      player stats::set_stat(#"mapdata", #"cp_ger_hub8", #"hash_43a738b893199779", 1, 1);
    }
  }
}