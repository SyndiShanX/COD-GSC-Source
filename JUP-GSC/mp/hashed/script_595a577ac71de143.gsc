/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_595a577ac71de143.gsc
*************************************************/

#using script_5438ebe20b6ec614;
#using script_638d701d263ee1ed;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\utility;
#namespace ob_visionset;

function function_b17698b01ef99a95() {
  callback::add("player_region_difficulty_change", &function_f83939ddb2573de8);
  init_internal();
}

function function_da135ec070e2e6e8(str_vision, var_7433545f29b128f7, var_25ec1993359bcfdf) {
  root = function_53f47ae03d865dab();

  if(isDefined(str_vision)) {
    root.override_vision = str_vision;
  }

  if(isDefined(var_7433545f29b128f7)) {
    root.var_e190a9f1018c081a = var_7433545f29b128f7;
  }

  if(isDefined(var_25ec1993359bcfdf)) {
    root.var_25ec1993359bcfdf = var_25ec1993359bcfdf;
  }

  init_internal();
}

function private init_internal() {
  init_vfx();
  root = function_53f47ae03d865dab();
  level callback::add("player_spawned", &on_player_spawn);

  level function_5cf9263cdde7f142();
}

function private on_player_spawn(params) {
  check_start();
  root = function_53f47ae03d865dab();
  thread scripts\cp_mp\utility\vision_utility::function_cb1caaf18300a508();

  if(isDefined(root.var_e190a9f1018c081a)) {
    function_dd25c590d4badd78(root.var_e190a9f1018c081a);
  }

  if(isDefined(root.override_vision)) {
    waitframe();
    scripts\cp_mp\utility\vision_utility::function_27a921508cb04613(root.override_vision, 0.25);
  }
}

function private function_f83939ddb2573de8(params) {
  player = params.player;
  newdifficulty = params.new_difficulty;
  olddifficulty = params.old_difficulty;
  player function_dd25c590d4badd78(function_a981dfc82d83237(newdifficulty));
  player function_e6965cda6f8ff5d(function_d8ad2691db50eb0(newdifficulty));
  player thread function_bd72e98353976267(newdifficulty);
}

function private function_bd72e98353976267(zone_difficulty) {
  vision = function_a99354442cd0039f(zone_difficulty);
  last_vision = self.var_d68047cbd7bc9d3b;

  if(isDefined(last_vision) && last_vision == vision) {
    return false;
  }

  if(istrue(scripts\cp_mp\utility\vision_utility::function_8e888e08a6ab22d3(vision))) {
    return false;
  }

  if(isDefined(last_vision) && last_vision != vision) {
    scripts\cp_mp\utility\vision_utility::function_9a92ae402e209ecc(last_vision, 0.25);
    waitframe();
  }

  scripts\cp_mp\utility\vision_utility::function_27a921508cb04613(vision, 0.25);
  self.var_d68047cbd7bc9d3b = vision;
  return true;
}

function private function_a99354442cd0039f(zone_difficulty) {
  vision_name = "mp_jup_bigmap_green";

  if(isDefined(zone_difficulty)) {
    switch (zone_difficulty) {
      case #"hash_5343b465e56ec9a4":
      case #"hash_651f76c0ad6741ec":
        vision_name = "mp_jup_bigmap_red";
        break;
      case #"hash_af83e47edfa8900a":
        vision_name = "mp_jup_bigmap_yellow";
        break;
      default:
        break;
    }
  }

  return vision_name;
}

function private function_5cf9263cdde7f142() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x32>", "<dev string:x45>" + "<dev string:x32>", &debug_visionset);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x59>", "<dev string:x45>" + "<dev string:x59>", &debug_visionset);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x6e>", "<dev string:x45>" + "<dev string:x6e>", &debug_visionset);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x87>", "<dev string:x93>", &function_97ec04fd36f9b911);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xaf>", "<dev string:xbf>", &function_46a1a0c6592edc27);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xdf>", "<dev string:xfa>", &function_34ec067faab1f472);
  scripts\common\devgui::function_fe953f000498048f();
}

function private debug_visionset(params) {
  if(!isDefined(params[0]) || is_equal(params[0], "<dev string:x117>")) {
    return;
  }

  level.player function_dd25c590d4badd78(function_a981dfc82d83237(params[0]));
  level.player function_e6965cda6f8ff5d(function_d8ad2691db50eb0(params[0]));
  level.player thread function_bd72e98353976267(params[0]);
  iprintlnbold("<dev string:x11b>" + function_a99354442cd0039f(params[0]));
}

function private function_34ec067faab1f472(params) {
  foreach(player in level.players) {
    if(isalive(player) && isPlayer(player)) {
      player scripts\cp_mp\utility\vision_utility::function_cb1caaf18300a508();
    }
  }

  iprintlnbold("<dev string:x137>");
}

function private function_97ec04fd36f9b911(params) {
  level.player function_dd25c590d4badd78("<dev string:x14f>");
  level.player function_e6965cda6f8ff5d("<dev string:x165>");
  level.player function_e6965cda6f8ff5d("<dev string:x165>");
  level.player scripts\cp_mp\utility\vision_utility::function_27a921508cb04613("<dev string:x17e>", 0.25);
}

function private function_46a1a0c6592edc27(params) {
  foreach(player in level.players) {
    if(isalive(player)) {
      player function_dd25c590d4badd78("<dev string:x191>");
      player function_e6965cda6f8ff5d("<dev string:x165>");
      player scripts\cp_mp\utility\vision_utility::function_27a921508cb04613("<dev string:x1ab>", 0.5);
    }
  }
}

function function_29b46d591982c45a() {
  init_vfx();
  moodlist = function_5244353dfc2d15ff();
  level thread namespace_ced1636a962433d2::init(moodlist);
  level callback::add("player_connect", &on_connect);
  level callback::add("player_region_difficulty_change", &function_3388294e62fdd0bc);

  level function_1ad29958b0c16235();

  utility::flag_wait("aether_storm_initialized");
  level.aether_storm.radiation callback::add("player_entered_radiation", &function_cecaf5099ed3aa41);
  level.aether_storm.radiation callback::add("player_exited_radiation", &function_78983343268efcab);
}

function function_e466816b861caf8b() {
  init_vfx();
  moodlist = function_5244353dfc2d15ff();
  level thread namespace_ced1636a962433d2::init(moodlist);
  level callback::add("player_connect", &on_connect);
  level callback::add("player_spawned", &function_a3ffb5ca860e0fcb);

  level function_1ad29958b0c16235();

  utility::flag_wait("aether_storm_initialized");
  level.aether_storm.radiation callback::add("player_entered_radiation", &function_cecaf5099ed3aa41);
  level.aether_storm.radiation callback::add("player_exited_radiation", &function_a3ffb5ca860e0fcb);
}

function private on_connect(params) {
  check_start();
}

function private check_start() {
  root = function_53f47ae03d865dab();

  if(!isDefined(root.inited)) {
    root.inited = 1;

    if(istrue(root.var_25ec1993359bcfdf)) {}
  }
}

function private function_5244353dfc2d15ff() {
  return "jup_ob_moodlist_default";
}

function private function_3388294e62fdd0bc(params) {
  player = params.player;
  newdifficulty = params.new_difficulty;
  olddifficulty = params.old_difficulty;

  if(!isDefined(newdifficulty)) {
    return;
  }

  if(isDefined(player.var_56b758046d7fc64f) && player.var_56b758046d7fc64f == newdifficulty) {
    return;
  }

  player endon("death");
  level endon("game_ended");

  mood = function_a659642818f62c93(newdifficulty);

  if(isDefined(mood)) {
    iprintlnbold(mood.state.visionsetsuffix + "<dev string:x1c2>" + newdifficulty);
  }

  if(!isDefined(player.currentmood) && !istrue(player.var_5872a7af669d9983)) {
    player.var_5872a7af669d9983 = 1;
  }

  player function_dd25c590d4badd78(function_a981dfc82d83237(newdifficulty));
  player function_e6965cda6f8ff5d(function_d8ad2691db50eb0(newdifficulty));
  player function_37ff5d03f010f57e(function_a659642818f62c93(newdifficulty));

  if(istrue(player.var_5872a7af669d9983)) {
    waitframe();
    player.var_5872a7af669d9983 = 0;
  }
}

function private function_cecaf5099ed3aa41(params) {
  player = params.player;

  if(isDefined(player)) {
    player function_dd25c590d4badd78("jup_ob_aether_storm_fx");
    player function_e6965cda6f8ff5d("mp_jup_ob_red_zone_fx");
  }
}

function private function_78983343268efcab(params) {
  player = params.player;

  if(isDefined(player) && isDefined(player.origin)) {
    difficulty = namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(player.origin);
    player function_dd25c590d4badd78(function_a981dfc82d83237(difficulty));
    player function_e6965cda6f8ff5d(function_d8ad2691db50eb0(difficulty));

    if(istrue(player.var_5872a7af669d9983)) {
      waitframe();
      player.var_5872a7af669d9983 = 0;
    }
  }
}

function private function_a3ffb5ca860e0fcb(params) {
  function_dd25c590d4badd78("jup_ob_rift_run_fx");
  function_e6965cda6f8ff5d("mp_jup_ob_red_zone_fx");
  function_37ff5d03f010f57e(namespace_ced1636a962433d2::get_mood(3));
}

function private function_a659642818f62c93(region_difficulty) {
  mood_index = 0;

  if(isDefined(region_difficulty)) {
    switch (region_difficulty) {
      case #"hash_5343b465e56ec9a4":
      case #"hash_651f76c0ad6741ec":
        mood_index = 2;
        break;
      case #"hash_af83e47edfa8900a":
        mood_index = 1;
        break;
      default:
        break;
    }
  }

  return namespace_ced1636a962433d2::get_mood(mood_index);
}

function private function_53f47ae03d865dab() {
  if(!isDefined(level.ob_visionset)) {
    level.ob_visionset = spawnStruct();
  }

  return level.ob_visionset;
}

function private function_1ad29958b0c16235() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1db>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1f7>", "<dev string:x20e>", &function_37d964772b906469);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x224>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x32>", "<dev string:x248>" + "<dev string:x32>" + "<dev string:x257>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x59>", "<dev string:x248>" + "<dev string:x59>" + "<dev string:x257>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x263>", "<dev string:x248>" + "<dev string:x263>" + "<dev string:x257>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x87>", "<dev string:x276>" + "<dev string:x257>", &function_8d0e7f7fe911132a);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xaf>", "<dev string:x28d>" + "<dev string:x257>", &function_943833c459d1100);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x2a8>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x32>", "<dev string:x248>" + "<dev string:x32>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x59>", "<dev string:x248>" + "<dev string:x59>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x263>", "<dev string:x248>" + "<dev string:x263>", &debug_mood);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x87>", "<dev string:x276>", &function_8d0e7f7fe911132a);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xaf>", "<dev string:x28d>", &function_943833c459d1100);
  scripts\common\devgui::function_fe953f000498048f();
}

function private debug_mood(params) {
  if(!isDefined(params[0]) || is_equal(params[0], "<dev string:x117>")) {
    return;
  }

  level.player function_dd25c590d4badd78(function_a981dfc82d83237(params[0]));
  level.player function_e6965cda6f8ff5d(function_d8ad2691db50eb0(params[0]));

  if(isDefined(params[1]) && params[1] == "<dev string:x2d6>") {
    level.var_5872a7af669d9983 = 1;
    level.debugtransition = 1;
    level.player function_37ff5d03f010f57e(function_a659642818f62c93(params[0]));
    level.var_5872a7af669d9983 = 0;
    level.debugtransition = 0;
  } else {
    level.player function_37ff5d03f010f57e(function_a659642818f62c93(params[0]));
  }

  iprintln("<dev string:x2e1>" + params[0]);
}

function private function_8d0e7f7fe911132a(params) {
  if(isDefined(params[0]) && params[0] == "<dev string:x2d6>") {
    level.var_5872a7af669d9983 = 1;
    level.debugtransition = 1;
  }

  foreach(player in level.players) {
    if(isalive(player)) {
      player function_a3ffb5ca860e0fcb();
    }
  }

  level.var_5872a7af669d9983 = 0;
  level.debugtransition = 0;
}

function private function_943833c459d1100(params) {
  if(isDefined(params[0]) && params[0] == "<dev string:x2d6>") {
    level.var_5872a7af669d9983 = 1;
    level.debugtransition = 1;
  }

  foreach(player in level.players) {
    function_cecaf5099ed3aa41({
      #player: player
    });
  }

  level.var_5872a7af669d9983 = 0;
  level.debugtransition = 0;
}

function private function_37d964772b906469(params) {
  level.player function_dd25c590d4badd78("<dev string:x2fe>");
  level.player function_e6965cda6f8ff5d(undefined);
  level.player function_eb0326e0c8803f41(0);
}

function private init_vfx() {}

function private function_dd25c590d4badd78(var_7433545f29b128f7) {
  utility::function_3677f2be30fdd581("jup_ob_fx", var_7433545f29b128f7);
}

function private function_a981dfc82d83237(zone_difficulty) {
  fx_name = "jup_ob_fx_off";

  if(isDefined(zone_difficulty)) {
    switch (zone_difficulty) {
      case #"hash_5343b465e56ec9a4":
      case #"hash_651f76c0ad6741ec":
        fx_name = "jup_ob_red_zone_fx";
        break;
      case #"hash_af83e47edfa8900a":
        fx_name = "jup_ob_yellow_zone_fx";
        break;
      default:
        break;
    }
  }

  return fx_name;
}

function private function_e6965cda6f8ff5d(var_8acbdb03885a9d78) {
  if(isDefined(self.var_1a56b3933b0e630c) && isDefined(var_8acbdb03885a9d78) && self.var_1a56b3933b0e630c == var_8acbdb03885a9d78) {
    return;
  }

  if(isDefined(self.var_1a56b3933b0e630c)) {
    deactivateworldevent(self.var_1a56b3933b0e630c, 1, self);
    self.var_1a56b3933b0e630c = undefined;
  }

  if(!isDefined(var_8acbdb03885a9d78)) {
    return;
  }

  activateworldevent(var_8acbdb03885a9d78, 1, self);
  self.var_1a56b3933b0e630c = var_8acbdb03885a9d78;
}

function private function_d8ad2691db50eb0(zone_difficulty) {
  world_event = undefined;

  if(isDefined(zone_difficulty)) {
    switch (zone_difficulty) {
      case #"hash_5343b465e56ec9a4":
      case #"hash_651f76c0ad6741ec":
        world_event = "mp_jup_ob_red_zone_fx";
        break;
      case #"hash_af83e47edfa8900a":
        world_event = "mp_jup_ob_yellow_zone_fx";
        break;
      default:
        break;
    }
  }

  return world_event;
}