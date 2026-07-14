/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_hud.gsc
**************************************/

#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace vehicle_hud;

function private autoexec __init__system__() {
  system::register(#"vehicle_hud", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_8bea04ba4cf8906c();
}

function private function_8bea04ba4cf8906c() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!isDefined(level.vehicle_hud)) {
    level.vehicle_hud = spawnStruct();
  }

  level.vehicle_hud.widget = hud_management::function_a1a13273e72bfe46("\xe7i\x0f!t\xbc\x02o\xd8\x9e\xe8o/Q-evlq\xc1`\xbdJ\xd8\xa7\x06\xfd");
  callback::add(#"hash_bdcfe99d5271a18d", &function_d27ef9437df3e779);
  callback::add(#"hash_a698d2f22002248c", &function_7d9df497e1ca1734);
  level utility::flag_set("\xa1\xe1\xa3\x14\xb7\xa2\xa4\xae\xea\xe3\x1d\x12\x1e\xccqYk8\x15\x81\xa3\x8a\xe8");
}

function private function_9b9a292a9abc3104(var_da3f316a2a678ed) {
  helper_count = 1;
  helper_prompts = [];

  while(helper_count <= 6) {
    prompt = hud_management::function_f7788e5b5434e49e(level.vehicle_hud.widget, var_da3f316a2a678ed, "\xe7\xbd8\x87\xd7\xa5\x7f2E\xfeXoB" + helper_count);

    if(!isDefined(prompt)) {
      break;
    }

    prompt_ref = "\x05\x94=SAE_R\x8ad\xbe" + helper_count;
    helper_prompts[prompt_ref] = prompt;
    helper_count += 1;
  }

  return helper_prompts;
}

function private function_79344f01758e3fe9(params) {
  if(!isDefined(params)) {
    return;
  }

  prompts = function_9b9a292a9abc3104(params.vehicle_model);

  if(isDefined(params) && istrue(params.var_bd4206898a9ed9b4)) {
    prompts["\x9f\xda\x17\xadQ\xabI\xe8\bB\xc3"] = &"script/exit_vehicle";
  }

  if(prompts.size > 0 && utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18", prompts);
  }

  if(prompts.size > 0 && utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", 0, -50);
  }
}

function function_d27ef9437df3e779(params) {
  if(!(isDefined(params.vehicle_model) && isDefined(level.vehicle_hud.widget) && isDefined(hud_management::function_b584f43317b07b57(level.vehicle_hud.widget, params.vehicle_model)))) {
    return;
  }

  if(hud_management::function_48c98ea9a4f0da89("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18")) {
    return;
  }

  if(!isDefined(params.var_bd4206898a9ed9b4)) {
    params.var_bd4206898a9ed9b4 = 1;
  }

  function_79344f01758e3fe9(params);
  self.var_8831abc0b77b3be9 = params;
  hud_management::function_35924dfcb78711f4("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18", level.vehicle_hud.widget);
  hud_management::function_85d8a0ba2e35b6f2("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18", 0, 0, 3, 3);
  hud_management::function_b683400f784cb7dc("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18", params.vehicle_model);
  hud_management::function_170c03b36bf19328("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18", ["\xfc\xef\x1a\x14\xcf+\x13\xb7\xf4"], 1);
  thread function_316f1f587cdd736f();
}

function private function_316f1f587cdd736f() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("-eA^\xce\xb3\xacH\x05G)\xfa\x9b\b_\xc2\xd0\xa7\x02\x1f\x91");

  while(true) {
    player waittill("\xd8\x90)\xb8\x8a\x19)52\xed\x16\xc1\xbbL\x17i]\aM{oZ");

    if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
      utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18");
    }

    player waittill("\x11|\xa0'\xf1\xadkdVq\xbc'KY\x0f\x19%a\x0eVa");
    function_79344f01758e3fe9(player.var_8831abc0b77b3be9);
  }
}

function function_b088fa824adb467c(max_health_threshold) {
  level.player setclientomnvar("\xf5k\xb0G\xc0~+8\x03\x97\xb3\xd4\xc3\x05g\xb04M+\xc6", max_health_threshold);
}

function function_7d9df497e1ca1734(params) {
  self notify("-eA^\xce\xb3\xacH\x05G)\xfa\x9b\b_\xc2\xd0\xa7\x02\x1f\x91");
  self.var_8831abc0b77b3be9 = undefined;

  if(hud_management::function_48c98ea9a4f0da89("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18")) {
    hud_management::scripted_widget_destroy("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18");
    hud_management::function_a4b07de99918f624("\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18");
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\xbc\x80\xe6\xe2\xe66\x85\xcb\xe23\x18");
  }
}