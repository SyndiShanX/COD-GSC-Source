/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1c5659cf71abc214.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace combination_puzzle;

function private autoexec __init__system__() {
  system::register(#"combination_puzzle", undefined, undefined, &combination_init);
}

function private combination_init() {
  ui::lui_registercallback("\x11`\x81I\xbc\xa1\xc75\xa4\xd7c\xe3\x95\x9f\xe9+1q\xf85\x18\x18\xae\x1d\xf4\\\x7f", &combination_complete);
  ui::lui_registercallback("k\x8bo\xc6\xf5GZ\x1b\xd0\x1a*\x9b\xe4\xef\xd4\xe1$\xe3\xebdb\x18C:", &combination_close);

  setdvarifuninitialized(@ "hash_c1fede1ed138c036", 0);
}

function private function_38e51c40a4ed78f2() {
  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add", "\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "0\xb0\xc0\xda", &"combination_puzzle/exit_button");
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", 0, 100, 1, 1);
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"show_backing")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"show_backing", 1);
  }
}

function combination_open(var_b00881a82fe94f3e, correct_callback, incorrect_callback, close_callback, player_linkto, disallow_completion = 0) {
  if(getdvarint(@ "hash_c1fede1ed138c036", 0)) {
    iprintlnbold("<dev string:x24>");

    if(isDefined(correct_callback)) {
      self thread[[correct_callback]]();
    }

    if(isDefined(close_callback)) {
      self thread[[close_callback]]();
    }

    return;
  }

  if(isDefined(self.combination)) {
    assertmsg("<dev string:x4a>");
    return;
  }

  self.combination = spawnStruct();

  if(isDefined(player_linkto) && isDefined(player_linkto.origin)) {
    self endon("\x1e\xfd\xd1\xa2\a");

    if(!isDefined(player_linkto.angles)) {
      player_linkto.angles = (0, 0, 0);
    }

    link_pos = utility::spawn_script_origin(player_linkto.origin, player_linkto.angles);

    if(isDefined(self.combination.link_pos)) {
      self.combination.link_pos delete();
    }

    if(isDefined(self.combination.return_pos)) {
      self.combination.return_pos delete();
    }

    self.combination.link_pos = link_pos;
    self.combination.return_pos = utility::spawn_script_origin(self.origin, self.angles);
    self setstance("\x8b\x90\xb5\xc4W");
    self startcameratween(1);
    self playerlinktoabsolute(link_pos);
    wait 1;
  }

  widget = hud_management::function_a1a13273e72bfe46("\x19\x8c\x9bLg\xff\x9e\xee\x914t^\x10UJ\x82\xbb\xd9\xb1\xae\xca\x9eg8\xd8sg`j\xd8\x1e7C\xd8");
  hud_management::function_35924dfcb78711f4("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", widget);
  function_fd26ac99d63afc2a();
  fields = [];
  fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(var_b00881a82fe94f3e);
  fields["\xbb@\xe1B\x15\xd2\x87\xc7\xcd\x1e\x04\xafPp\x9a\xf5\xf2\x1c\v"] = disallow_completion;
  hud_management::function_41ff479ac45608d6("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", fields);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\xa8Jl\x84\xb3b\x95o", 0);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", 0);
  val::set("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", "\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A", 1);
  self enablephysicaldepthoffieldscripting(3);
  self setphysicaldepthoffield(1, 0, 10);
  function_38e51c40a4ed78f2();
  self.combination.correct_callback = correct_callback;
  self.combination.incorrect_callback = incorrect_callback;
  self.combination.close_callback = close_callback;
}

function function_91def4fd8a2e0bf8(str_state) {
  if(!hud_management::function_48c98ea9a4f0da89("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V")) {
    return;
  }

  assert(isDefined(str_state), "<dev string:xd6>");
  hud_management::function_d8d634ceece460("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", str_state);
}

function function_fd26ac99d63afc2a(var_33c99c1eb8751c41 = 0, var_fddc1cc1b5c68dfa = 0, var_290f3a0c77735b7b = 3, var_a3943ea0c9191ae9 = 3, var_ff2aa94fc3efb76d = 0) {
  if(!hud_management::function_48c98ea9a4f0da89("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V")) {
    return;
  }

  hud_management::function_85d8a0ba2e35b6f2("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V", var_33c99c1eb8751c41, var_fddc1cc1b5c68dfa, var_290f3a0c77735b7b, var_a3943ea0c9191ae9, var_ff2aa94fc3efb76d);
}

function combination_close(val) {
  if(getdvarint(@ "hash_c1fede1ed138c036", 0)) {
    return;
  }

  combination = self.combination;

  if(!isDefined(combination)) {
    return;
  }

  if(isDefined(combination.close_callback)) {
    self thread[[combination.close_callback]]();
  }

  combination_destroy();

  if(isDefined(combination.return_pos)) {
    self startcameratween(1);
    self playerlinktoabsolute(combination.return_pos);
    self endon("\x1e\xfd\xd1\xa2\a");
    wait 1;
    self unlink();

    if(isDefined(combination.link_pos)) {
      combination.link_pos delete();
    }

    if(isDefined(combination.return_pos)) {
      combination.return_pos delete();
    }
  }
}

function combination_destroy() {
  hud_management::scripted_widget_destroy("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V");
  val::reset_all("\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V");
  self disablephysicaldepthoffieldscripting();

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\x1b\xde\xad1Zn\x16\xa3\xa5\xed\xcd_\xe0]z\xe9\xc6V");
  }

  self.combination = undefined;
}

function private combination_complete(val) {
  combination = self.combination;

  if(isDefined(combination)) {
    if(val == 0) {
      if(isDefined(combination.incorrect_callback)) {
        self thread[[combination.incorrect_callback]]();
      }

      return;
    }

    if(val == 1) {
      if(isDefined(combination.correct_callback)) {
        self thread[[combination.correct_callback]]();
      }

      return;
    }

    if(val == 2) {
      if(isDefined(combination.timeout_callback)) {
        self thread[[combination.timeout_callback]]();
      }

      return;
    }

    assert("<dev string:x13f>");
  }
}