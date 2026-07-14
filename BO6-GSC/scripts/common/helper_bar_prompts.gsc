/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\helper_bar_prompts.gsc
*************************************************/

#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace helper_bar_prompts;

function private autoexec __init__system__() {
  system::register(#"helper_prompts", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_33c4fc4940ce6464();
}

function private function_33c4fc4940ce6464() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  level.var_fe66e6c26ff4e1aa = hud_management::function_a1a13273e72bfe46("\xe6\xd8'Z\x83\x1d\xca\x91\xeb\xeei2\x9d\xca\x1d\xf5\r\xcacper\xbe\x13,\xe4_8'\xbd\xd6\x1c\xa3s");
  assert(isDefined(level.var_fe66e6c26ff4e1aa), "<dev string:x24>" + "<dev string:x81>" + "<dev string:xa7>");
  level.var_c494cdf81196e675 = hud_management::function_a1a13273e72bfe46("el\x1b\xf1x\xfc\x12o\xe0\xfe\xe9e\x7fQ/g\x94l\xc8hdE\x84\x03\a\x97\xd1z\xeaw\xebV\x15e\x13=r\xfd");
  assert(isDefined(level.var_c494cdf81196e675), "<dev string:xbe>" + "<dev string:x120>" + "<dev string:xa7>");
  utility::registersharedfunc(#"helper_bar_prompts", #"add", &function_8d851a60cb1b39b6);
  utility::registersharedfunc(#"helper_bar_prompts", #"add_array", &function_e90e82d03499b570);
  utility::registersharedfunc(#"helper_bar_prompts", #"set_position", &function_ec43f0c9cd3b50db);
  utility::registersharedfunc(#"helper_bar_prompts", #"set_state", &function_4555282aca9af2c6);
  utility::registersharedfunc(#"helper_bar_prompts", #"hash_fd954ad8304a3b48", &function_98e6098013486590);
  utility::registersharedfunc(#"helper_bar_prompts", #"hash_fd3b0edd1bcf7552", &function_4409042290c9fa1c);
  utility::registersharedfunc(#"helper_bar_prompts", #"show_backing", &function_bea886f853535086);
  utility::registersharedfunc(#"helper_bar_prompts", #"remove", &function_7178bb4ff5922712);
  utility::registersharedfunc(#"helper_bar_prompts", #"remove_group", &function_113cdd154ac165de);
  utility::registersharedfunc(#"helper_bar_prompts", #"clear", &function_352ec0e6ff4c83f9);
  level utility::flag_set("e\xa7\xd0B\xfc(\xba\xa9)\xbe\xcf\xf8W\x16\x19=\xfc\x94T\x14\xfc\xb75(\xeb~");
}

function private function_7343cc3d9920b2e5() {
  self.helper_bar_prompts = {};
  self.helper_bar_prompts.var_7b464a87636bfd30 = [];
  self.helper_bar_prompts.var_35e1e741c6ce73aa = [];

  for(i = 0; i < 7; i++) {
    self.helper_bar_prompts.var_7b464a87636bfd30[i] = i;
  }
}

function private function_e0f6b82d5dfe0f6f(prompt_group, prompt_ref) {
  if(!(isDefined(self.helper_bar_prompts) && isDefined(self.helper_bar_prompts.var_7b464a87636bfd30))) {
    function_7343cc3d9920b2e5();
  }

  if(self.helper_bar_prompts.var_7b464a87636bfd30.size > 0) {
    if(!isDefined(self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group])) {
      self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group] = [];
    }

    if(!isDefined(self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref])) {
      self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref] = self.helper_bar_prompts.var_7b464a87636bfd30[0];
      self.helper_bar_prompts.var_7b464a87636bfd30 = utility::array_remove_index(self.helper_bar_prompts.var_7b464a87636bfd30, 0);
      hud_management::function_222841054993effd("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, level.var_c494cdf81196e675);
    }
  } else {
    assert(0, "<dev string:x14a>");
  }

  return self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref] ?? undefined;
}

function private function_1748d07fab172adc(prompt_group, prompt_ref) {
  if(isDefined(self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref])) {
    self.helper_bar_prompts.var_7b464a87636bfd30[self.helper_bar_prompts.var_7b464a87636bfd30.size] = self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref];
    self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref] = undefined;
  }
}

function private function_cde54ef80f6a28ea(prompt_group, prompt_ref, prompt_string, var_61f99750ab748aa1 = undefined) {
  fields = [];
  fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(prompt_string);
  fields["\x7fK\xd9fH]\xacg$\xa9C\xca~\xe9\x02[\xf8@\xb0iK\x17\xadD\xf4l\xb9Qe\xfc:\x86"] = isDefined(var_61f99750ab748aa1) ? function_30e4f86dded0873(var_61f99750ab748aa1) : undefined;
  function_e0f6b82d5dfe0f6f(prompt_group, prompt_ref);
  hud_management::function_f5104e32d4bc69f2("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, fields, 1);
}

function private function_45192decae0273f2() {
  assert(isPlayer(self), "<dev string:x176>");
  return hud_management::function_48c98ea9a4f0da89("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18");
}

function function_e90e82d03499b570(prompt_group, var_91be91996b481aa8, var_e993313042da8c34 = 1) {
  assert(isarray(var_91be91996b481aa8));
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!hud_management::function_48c98ea9a4f0da89("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18")) {
    hud_management::function_91ff36a22dc2c60e("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", level.var_fe66e6c26ff4e1aa);
    hud_management::function_aaab83e8c950f455("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", 7);
  }

  foreach(prompt_ref, prompt in var_91be91996b481aa8) {
    if(isarray(prompt)) {
      loc_string = prompt[0];
      var_61f99750ab748aa1 = prompt[1];
      function_cde54ef80f6a28ea(prompt_group, prompt_ref, loc_string, var_61f99750ab748aa1);
      continue;
    }

    function_cde54ef80f6a28ea(prompt_group, prompt_ref, prompt);
  }

  if(var_e993313042da8c34) {
    function_4555282aca9af2c6("2\xd7n\xee\x86\x03\x85\x17\xc8<\r\x83\xad*");
  }

  function_ec43f0c9cd3b50db();
}

function function_8d851a60cb1b39b6(prompt_group, prompt_ref, loc_string, var_bad3c1c54a076c42 = undefined, var_e993313042da8c34 = 1) {
  assert(isstring(prompt_group) && isstring(prompt_ref) && isDefined(loc_string), "<dev string:x1ae>");

  if(!function_45192decae0273f2()) {
    hud_management::function_91ff36a22dc2c60e("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", level.var_fe66e6c26ff4e1aa);
    hud_management::function_aaab83e8c950f455("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", 7);
    function_ec43f0c9cd3b50db();
  }

  function_cde54ef80f6a28ea(prompt_group, prompt_ref, loc_string, var_bad3c1c54a076c42);

  if(var_e993313042da8c34) {
    function_4555282aca9af2c6("2\xd7n\xee\x86\x03\x85\x17\xc8<\r\x83\xad*");
  }
}

function function_ec43f0c9cd3b50db(var_c067241ae90aaf04 = 0, var_dfe06ec3e25da0d5 = -85, var_649b2190bfa85f49 = 1, var_b536c626e94e11af = 2) {
  if(!function_45192decae0273f2()) {
    return;
  }

  hud_management::function_85d8a0ba2e35b6f2("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", var_c067241ae90aaf04, var_dfe06ec3e25da0d5, var_649b2190bfa85f49, var_b536c626e94e11af, 1);
}

function function_4555282aca9af2c6(string_state) {
  if(!function_45192decae0273f2()) {
    return;
  }

  assert(isstring(string_state), "<dev string:x21d>");
  hud_management::function_d8d634ceece460("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", string_state);
}

function function_98e6098013486590(prompt_group, prompt_ref, string_state) {
  if(!function_45192decae0273f2()) {
    return;
  }

  assert(isstring(prompt_ref) && isstring(string_state), "<dev string:x267>");
  hud_management::function_54a35c35697bfbc4("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, string_state);
}

function function_4409042290c9fa1c(prompt_group, prompt_ref, loc_string, var_bad3c1c54a076c42) {
  if(!function_45192decae0273f2()) {
    return;
  }

  fields = [];
  fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(loc_string);
  fields["\x7fK\xd9fH]\xacg$\xa9C\xca~\xe9\x02[\xf8@\xb0iK\x17\xadD\xf4l\xb9Qe\xfc:\x86"] = isDefined(var_bad3c1c54a076c42) ? function_30e4f86dded0873(var_bad3c1c54a076c42) : undefined;
  hud_management::function_f5104e32d4bc69f2("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, fields, 1);
}

function function_bea886f853535086(var_c742871d8e7b3618 = 1) {
  function_4555282aca9af2c6(var_c742871d8e7b3618 ? "2\xd7n\xee\x86\x03\x85\x17\xc8<\r\x83\xad*" : "\x11\xca\xcc\v\xab\xd8:");
}

function function_7178bb4ff5922712(prompt_group, prompt_ref, var_5c24ecb08827da46 = 1) {
  assert(isstring(prompt_group) && isstring(prompt_ref), "<dev string:x2bc>");

  if(!function_45192decae0273f2() || !isDefined(self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group][prompt_ref])) {
    return;
  }

  hud_management::function_699c996caa7bb53e("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, var_5c24ecb08827da46);
  function_1748d07fab172adc(prompt_group, prompt_ref);
}

function function_113cdd154ac165de(prompt_group, var_5c24ecb08827da46 = 1) {
  assert(isstring(prompt_group), "<dev string:x311>");

  if(!function_45192decae0273f2() || !isDefined(self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group])) {
    return;
  }

  foreach(prompt_ref, index in self.helper_bar_prompts.var_35e1e741c6ce73aa[prompt_group]) {
    hud_management::function_699c996caa7bb53e("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18", prompt_group + prompt_ref, var_5c24ecb08827da46);
    function_1748d07fab172adc(prompt_group, prompt_ref);
  }
}

function function_352ec0e6ff4c83f9() {
  if(!function_45192decae0273f2()) {
    return;
  }

  hud_management::function_908e2205a6516f5d("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18");
  self.helper_bar_prompts = undefined;
  function_4555282aca9af2c6("\x11\xca\xcc\v\xab\xd8:");
}

function function_c27a1db415506869() {
  if(!function_45192decae0273f2()) {
    return;
  }

  if(hud_management::function_48c98ea9a4f0da89("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18")) {
    hud_management::function_908e2205a6516f5d("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18");
    hud_management::function_995d1afc30296a16("|\xb7\xd6O+Od\x0e\xc3d;\xf9\xb6\xc7Z\xdd\xb2\x18");
    self.helper_bar_prompts = undefined;
  }
}