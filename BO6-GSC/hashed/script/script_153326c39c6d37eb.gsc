/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_153326c39c6d37eb.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace frequency_matching_puzzle;

function private autoexec __init__system__() {
  system::register(#"frequency_matching_puzzle", undefined, undefined, &post_main);
}

function private post_main() {
  ui::lui_registercallback("\x94\xda?\x83[\xefZ\xd8\xcb!\xc2\x03\xba\xeb|\xad\x80-\xd7\xeb\xbf\x942\xc8\xe8", &frequency_match_puzzle_matching);
  ui::lui_registercallback("\x15\xa2$\xe7w}\x7f\xf3\xf4\xac0\x7f[<C\xd9_\xaf)\x0fau^", &frequency_match_puzzle_close);

  setdvarifuninitialized(@ "hash_a4fbcc8ed46ce3cb", 0);
  setdevdvar(@ "hash_a437d6d2e885946", 5, 0, 63);
  setdevdvar(@ "hash_9113594d56b0bf35", 0.4, 0, 0.5);
  setdevdvar(@ "hash_da86cdceec41c53a", 2, 0, 31);
  setdevdvar(@ "hash_bebdf830d89c7985", 0.5, 0, 1);
}

function private function_9b9a292a9abc3104(allow_exit = 1, match_frequency = 1) {
  helper_prompts = [];
  helper_prompts["U\x99\x80\x80\xd0\f5@\xeeV.\xd0\xceF\x9d}"] = [ &"frequency_matching_puzzle/amplitude_controls", &"frequency_matching_puzzle/amplitude_controls_gamepad"];

  if(match_frequency) {
    helper_prompts["\xec\xac\xb1\xd5\xc0\f\xad\x94E\xd2(\xaa"] = [ &"frequency_matching_puzzle/frequency_controls", &"frequency_matching_puzzle/frequency_controls_gamepad"];
  } else {
    helper_prompts["\xec\xac\xb1\xd5\xc0\f\xad\x94E\xd2(\xaa"] = [ &"frequency_matching_puzzle/phase_controls", &"frequency_matching_puzzle/phase_controls_gamepad"];
  }

  if(allow_exit) {
    helper_prompts["\x9f\xda\x17\xadQ\xabI\xe8\bB\xc3"] = &"scripted_widget_common/cancel_activate_prompt";
  }

  return helper_prompts;
}

function function_64ac42fdbfcb2110(widget, freq = 5, amp = 0.4, peaks = 0, rate = 5, falloff = 0, perturbation = 0, allow_exit = 1, match_frequency = 1, difficulty = "2\x9fR\xb1", time = 1) {
  if(!val::get("e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff")) {
    return false;
  }

  val::set("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
  val::set("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
  val::set("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  val::set("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
  val::set("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\xa8Jl\x84\xb3b\x95o", 0);
  val::set_array("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", arrayremove(["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"], "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff"), 0);
  utility::callsharedfunc(#"hint", #"add_wait", "\xda \xe0U\x0e\xedn.!4\xcb\xbcX(~!\x18", undefined, undefined, "B\xfce\x01\xfb\xce\xe0\x1e\xf2#\xa7\xbcJr\x1av\xb0\"\xff\x15\xc3\x8dP", undefined, undefined, 0);
  self.frequency_match_puzzle = spawnStruct();
  self.frequency_match_puzzle.time = time;
  fields = [];
  fields["3'\x95.]Y7\xc6^"] = freq;
  fields["n\xbb9\xfcv\x88\xd7\xc2\xe0"] = amp;
  fields["\v\xbc\xe4\x9a\xb8"] = peaks;
  fields["\x84\x8a6\n"] = rate;
  fields["\"\xcfjp\xdb+~"] = falloff;
  fields["v\xd9-\x18\x11\x9cU]\x89\xb0\xba\xc4"] = perturbation + 0.5;
  fields["\xb7\xdb\x04\xbaXU\xfe\xfa\xcax"] = allow_exit;
  fields["~\xcb\xe9\x9b\xb8\xd3\x1d\xbf\xdet8e\xc8\xe0\x89"] = match_frequency;
  hud_management::function_35924dfcb78711f4("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\x0e\x1cB\t\xbf\xc0\xd4%Y\x0f\x87\xdaQ\x7f0\xbe\xb2\x1d\xbdT\xd6\xde\x80\x86\xa9-\x9b\xaf\xd1\xdbx\x91\xa1\xfaY\x1d\xfb\xbc[,\b");
  hud_management::function_85d8a0ba2e35b6f2("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", 0, 0, 1, 1);
  hud_management::function_41ff479ac45608d6("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", fields, 1);
  hud_management::function_d8d634ceece460("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", difficulty);

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", function_9b9a292a9abc3104(allow_exit, match_frequency));
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", 0, -48);
  }

  thread function_22a26a79e20d79d1();
  return true;
}

function function_ee188bf9851e3500(difficulty) {
  if(hud_management::function_48c98ea9a4f0da89("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3")) {
    hud_management::function_d8d634ceece460("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", difficulty);
  }
}

function function_696191c8d9e1d3dc() {
  if(hud_management::function_48c98ea9a4f0da89("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3")) {
    fields = hud_management::function_594f6081e9662d1a("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", ["\xb7\xdb\x04\xbaXU\xfe\xfa\xcax", "~\xcb\xe9\x9b\xb8\xd3\x1d\xbf\xdet8e\xc8\xe0\x89"]);
    fields["3'\x95.]Y7\xc6^"] = randomintrange(2, 12);
    fields["n\xbb9\xfcv\x88\xd7\xc2\xe0"] = randomfloatrange(0.2, 0.45);
    fields["\v\xbc\xe4\x9a\xb8"] = 0;
    fields["\x84\x8a6\n"] = randomintrange(2, 10);
    fields["\"\xcfjp\xdb+~"] = 0;
    fields["v\xd9-\x18\x11\x9cU]\x89\xb0\xba\xc4"] = 0.5;
    hud_management::function_41ff479ac45608d6("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", fields, 1);
  }
}

function private frequency_match_puzzle_matching(val) {
  if(val != 0) {
    self notify("T\xb8\xa5\x8c\f;\x11O\v{)\xe4\x8a\xe9\v'{6\x1b\x96\xfe%{CK57\xb6\xb4\xf3\x92");
    thread frequency_match_puzzle_timer();
    return;
  }

  self notify("t\xc4\x12x\xedls'\x82\xb9\xebyv\xfb\r\xa7Uy\x8dz4\xeb\xad\xf3\xff\x13\xe5\xf5d\x16\xc1\x14\x04\xf5\xf2");
}

function private frequency_match_puzzle_timer() {
  self notify("\x991Uc\xb5Y\xd4\x1f\x04}\xd2\xc8\xb2\xa4#\xa0z\xec\x9f\xd6\x05\xaf\xfb$\xc4x\\/");
  self endon("\x991Uc\xb5Y\xd4\x1f\x04}\xd2\xc8\xb2\xa4#\xa0z\xec\x9f\xd6\x05\xaf\xfb$\xc4x\\/");
  self endon("\x1c6\xbak\xda\xcdVY:`\xd2\x18\xcb\x1a\xf5<\xdfWy2\xb9\xcfPY\x98f\x0fY\xc1");
  self endon("t\xc4\x12x\xedls'\x82\xb9\xebyv\xfb\r\xa7Uy\x8dz4\xeb\xad\xf3\xff\x13\xe5\xf5d\x16\xc1\x14\x04\xf5\xf2");
  self endon("[.r\xb2\xcby\t\xa0\xc9Q\x19\xe0\x03:\xcc\x04\xb2\xd6s>\xcd");

  if(isDefined(self.frequency_match_puzzle) && isDefined(self.frequency_match_puzzle.time)) {
    wait self.frequency_match_puzzle.time;
  }

  self notify("\x96\xdf\n\xef\xc7\xd1\xa8vh\xf5\x80]\xe9\xd7\b\x9d\xec\xf8& 7\x9d\xb0\x1e\xbbY?\x04w\x0f\xf6");

  if(utility::issharedfuncdefined(#"signal_detected", #"hash_1ae6fdae3354a581")) {
    utility::callsharedfunc(#"signal_detected", #"hash_1ae6fdae3354a581");
  }

  hud_management::function_d3b457baa69dec73("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3", "\xe6]66\x95\xb97", 1);
  thread utility::callsharedfunc(#"frequency_puzzle", #"puzzle_complete");
}

function private function_22a26a79e20d79d1() {
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  self endon("\x1c6\xbak\xda\xcdVY:`\xd2\x18\xcb\x1a\xf5<\xdfWy2\xb9\xcfPY\x98f\x0fY\xc1");
  self waittill("\x1e\xfd\xd1\xa2\a");
  thread frequency_match_puzzle_close();
}

function frequency_match_puzzle_close(val) {
  hud_management::scripted_widget_destroy("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3");
  self notify("\x1c6\xbak\xda\xcdVY:`\xd2\x18\xcb\x1a\xf5<\xdfWy2\xb9\xcfPY\x98f\x0fY\xc1");
  self.frequency_match_puzzle = undefined;
  val::reset_all("\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3");

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\xc2d\xae\x0e\x81\xa9\xe8B\xb8\xbd\"\xbe\x05\x9cDQ3");
  }

  utility::callsharedfunc(#"frequency_puzzle", #"puzzle_closed");
}