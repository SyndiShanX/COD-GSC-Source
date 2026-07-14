/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\lockpick.gsc
******************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\player\cursor_hint;
#namespace lockpick;

function private autoexec __init__system__() {
  system::register(#"lockpick", undefined, &lockpick_init, undefined);
}

function private lockpick_init() {
  ui::lui_registercallback("^Y=\xe7\x96\xa4\xedh\xd1\xf7g@\xfb\vxV\xaf", &lockpick_unlocked);
  ui::lui_registercallback("A\xf7N\xc8\xb7/\xb2\x10\x9eZ\xd3\xe0\xd0gT", &lockpick_closed);
  level.lockpicking = spawnStruct();
  level.lockpicking.var_9dc2904a19139318 = &function_dfe3a435727b7712;
  level.lockpicking.control_type = 1;

  setdevdvarifuninitialized(@ "hash_bd06b6a7b8fb118f", -1);
}

function private function_9b9a292a9abc3104(allow_exit = 1) {
  helper_prompts = [];
  helper_prompts["\xe3\xfc\xa3)}\t\x8e\xa2\xb1\xb5G\x85U\x9a"] = &"hash_61d0fac8c8bbdd5e";

  if(allow_exit) {
    helper_prompts["\x9f\xda\x17\xadQ\xabI\xe8\bB\xc3"] = &"scripted_widget_common/cancel_activate_prompt";
  }

  return helper_prompts;
}

function function_dfe3a435727b7712(params) {
  params = strtok(params, "\xda");
  self.lockpick = spawnStruct();
  self.lockpick.pins = 3;
  self.lockpick.difficulty = 1;
  self.lockpick.allow_close = 1;
  self.lockpick.enable_callback = &lockpick_door_enable;
  self.lockpick.disable_callback = &function_c8156bbb49a307ba;

  foreach(param in params) {
    if(isstartstr(param, "\rx !GO@\xc2")) {
      kvp = strtok(param, "\xb0");

      if(kvp.size == 2) {
        switch (kvp[0]) {
          case #"hash_d37c9212baf19360":
            self.lockpick.pins = int(kvp[1]);
            break;
          case #"hash_77ab53744e1b8275":
            if(kvp[1] == "2\x9fR\xb1") {
              self.lockpick.difficulty = 0;
            } else if(kvp[1] == "w=&\x15\xbd\xae") {
              self.lockpick.difficulty = 1;
            } else if(kvp[1] == "\xec\xacV\a") {
              self.lockpick.difficulty = 2;
            } else if(kvp[1] == "~\xfa\x9c;m5K\x83") {
              self.lockpick.difficulty = 3;
            }

            break;
          case #"hash_f492ed4acdf8da83":
            self.lockpick.allow_close = kvp[1] != "\xfe";
            break;
          case #"hash_a8e1f0acdeca55a5":
            self.lockpick.param = kvp[1];
            break;
        }
      }
    }
  }
}

function lockpick_door_enable() {
  self notify("\xb9\x11\xa0\xb1\xad\xf6\x05\xae\xe7D\xbf\xf3\x9c|\x16\xac\xc2\xe2\x80I");
  self endon("\xb9\x11\xa0\xb1\xad\xf6\x05\xae\xe7D\xbf\xf3\x9c|\x16\xac\xc2\xe2\x80I");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\xdc\xd3\xbb\x9f\xf7\xf8\xd1\xb8\xfd\xc9\x8c\xf2\xab\xba\xcd\xf1\xd1");
  self.lockpick.var_db9985bc4a3ecd4 = &function_7891eaede3b7dc64;
  self.open_struct.var_e703a981d06a1192 = 1;
  self.open_struct door_sp::remove_open_interact_hint();
  self notify("M\xa2\xf9\xb2\xbc\xf5\xcc@\x817\x1c\xb4\x80^<\xb5c");
  door_internal::setup_open_struct(self.open_struct);

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>");

    if(!istrue(self.isbashing) && istrue(self.locked) && isDefined(self.lockpick)) {
      level.player thread lockpick_open(self.lockpick.pins, self.lockpick.difficulty, self.lockpick.allow_close, self, &function_fc5bd8cd3360f1d4);
    }
  }
}

function function_fc5bd8cd3360f1d4(lock_target) {
  lock_target door_sp::unlock_door(undefined, self);
  lock_target.lockpick = undefined;
}

function function_c8156bbb49a307ba() {
  self notify("\xdc\xd3\xbb\x9f\xf7\xf8\xd1\xb8\xfd\xc9\x8c\xf2\xab\xba\xcd\xf1\xd1");
  self.lockpick.var_db9985bc4a3ecd4 = undefined;
}

function function_7891eaede3b7dc64() {
  var_2bda2854ef11fb0c = self.door.lockpick.hint_string;
  var_871826aff8b90880 = self.door.lockpick.hint_icon;

  if(door_internal::function_e0e17b36200bbd2(self.door)) {
    self.door.lockpick.hint_string = &"lockpick/cursor_hint";
    self.door.lockpick.hint_icon = "\xe9\x99\xac2\xea\x9f\x94pA\x94\x1a\xda\x91\xb0\xf9\xa8\xb7\xbd@\x01\x8a\x1e\x95";
    self.cursor_hint_ent setusewhenhandsoccupied(0);
  } else {
    self.cursor_hint_ent setusewhenhandsoccupied(1);

    if(self.door door_internal::door_bashable_by_player(1)) {
      self.door.lockpick.hint_string = &"script/door_hint_use";
    } else {
      self.door.lockpick.hint_string = &"script/door_hint_use_no_bash";
    }

    self.door.lockpick.hint_icon = "\xb1\x06\x1c\xe7&\x82X\x1a(\xf1@$\xe3H\xed<a\xd5\xa8g\x06";
  }

  if(var_2bda2854ef11fb0c != self.door.lockpick.hint_string) {
    self.cursor_hint_ent setHintString(self.door.lockpick.hint_string);
  }

  if(var_871826aff8b90880 != self.door.lockpick.hint_icon) {
    self.cursor_hint_ent sethinticon(self.door.lockpick.hint_icon);
  }
}

function function_73a1f6ddc5600c8a(func) {
  level.lockpicking.var_e343e82ec9d83e72 = func;
}

function function_aec9f6f58fc9494c() {
  level.lockpicking.var_e343e82ec9d83e72 = undefined;
}

function lockpick_create(pins, difficulty, allow_close, link_tag, unlocked_callback, close_callback, display_dist, use_dist) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");

  if(isDefined(self.cursor_hint_ent)) {
    return;
  }

  self.var_e703a981d06a1192 = 1;
  cursor_hint::create_cursor_hint(link_tag, undefined, &"lockpick/cursor_hint", undefined, display_dist, use_dist, 0, 0, 0, "\xe9\x99\xac2\xea\x9f\x94pA\x94\x1a\xda\x91\xb0\xf9\xa8\xb7\xbd@\x01\x8a\x1e\x95");
  self.var_ac8301aa5eafe707 = 1;
  hint_ent = self;

  if(isDefined(self.cursor_hint_ent)) {
    hint_ent = self.cursor_hint_ent;
  }

  while(isDefined(hint_ent)) {
    hint_ent waittill("\x91`\xb1\xe7T\x97>", player);
    player thread lockpick_open(pins, difficulty, allow_close, self, unlocked_callback, close_callback);
  }
}

function lockpick_remove() {
  cursor_hint::remove_cursor_hint();
  self.var_ac8301aa5eafe707 = undefined;
}

function function_b297356c1ac11833(var_9119ce95e848981b = 1) {
  var_e77dcd3d6ceeebe0 = "\x18b\xc2y";

  if(!var_9119ce95e848981b) {
    var_e77dcd3d6ceeebe0 = "\xf0\xba\x8f\x9d";
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_state")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_state", var_e77dcd3d6ceeebe0);
  }
}

function lockpick_open(pins, difficulty, allow_close, lock_target, unlocked_callback, close_callback, hide_controls, no_dof) {
  assert(pins > 0 && pins <= 5);
  assert(difficulty >= 0 && difficulty <= 3);

  if(!val::get("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X")) {
    return;
  }

  if(isDefined(level.lockpicking.var_e343e82ec9d83e72) && !self[[level.lockpicking.var_e343e82ec9d83e72]](lock_target)) {
    return;
  }

  utility::callsharedfunc(#"hint", #"add_wait", "\xa7C^l\xab)(\xa6\xc55l\xc8w", undefined, undefined, "\f\xc6\xa0\xc4P\x97\x90\xca\xb7<\xd7+\xc8P\xb6, \xf4\xb2", undefined, undefined, 0);
  val::set_array("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", ["\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe2,^\xd6p\xea\xde\xb7X+\x19\xe8\x9f\xa7VG\x1d\xb01\xbd\xf2", "\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\vz4-S\xd4H\xd4\xe8\x93\xed\b\x9a8gss^\xad", "e\xac\xb6 \x8e\x02\v\xd1Knl\xe6\x19\xb6\a*^\xd3+f\x96\xff", "a\xd8c\xb7\xdd\xd7\xc6-8\xa1\xb2\x93\xbe\x83W\xa7\xe9\x1bV"], 0);
  val::set("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\xe5\x06\xb0\bE\x16", 0);
  hud_management::function_35924dfcb78711f4("\rx !GO@\xc2", "\x90\x93\x89\xbbXS\xbc\x94\x7f\\\x8b\x1c\xdcr\bX8\xa1\xf6\xf5\xb9\x0e!k");
  hud_management::function_85d8a0ba2e35b6f2("\rx !GO@\xc2", 0, 0, 1, 1);
  level.player setsoundsubmix("kt\xeb\xedM\xb6|\xc39\xe8\xc2\xd7\"\xeb\v\x10E\x1eIo\x96\x8a\x8d\xd8", 1);

  if(!isDefined(hide_controls)) {
    hide_controls = 0;
  }

  function_b297356c1ac11833(hide_controls);

  if(!isDefined(self.lockpick)) {
    self.lockpick = spawnStruct();
  }

  if(isDefined(lock_target.lockpick.param)) {
    level.player function_80ac0bc08c91abaf(lock_target.lockpick.param);
  }

  self.lockpick.lock_target = lock_target;
  self.lockpick.unlocked_callback = unlocked_callback;
  self.lockpick.close_callback = close_callback;
  self.lockpick.no_dof = no_dof;
  control_type = level.lockpicking.control_type;

  var_1b9cce0b669afe72 = getdvarint(@ "hash_bd06b6a7b8fb118f");

  if(var_1b9cce0b669afe72 > 0 && var_1b9cce0b669afe72 < 2) {
    control_type = var_1b9cce0b669afe72;
  }

  fields = [];
  fields["\x17\xe8y\bl\xe4?\x04\xd8\xb1"] = difficulty;
  fields["\x80\xf5'p"] = pins;
  fields["\xb7\xdb\x04\xbaXU\xfe\xfa\xcax"] = allow_close;
  fields["\xf3U\xfaU\xfd\x8dy\xe0\x80o\xb0X"] = control_type;

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\rx !GO@\xc2", function_9b9a292a9abc3104(allow_close), 1);
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", -333, -200);
  }

  hud_management::function_41ff479ac45608d6("\rx !GO@\xc2", fields, 1);
  hud_management::function_170c03b36bf19328("\rx !GO@\xc2", "\xa5H\x8c@\xd0\xe4\xc5\xc2\xec\x95\xab", 1, 1);
  val::set("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\xd56a\x9b\xba$Do]uE\xb6\x9b1", 0);
  val::set("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
  val::set("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  val::set("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X", "`\x16\xae\xa2\xe4t\x187\xe7", 0);

  if(!istrue(no_dof)) {
    self enablephysicaldepthoffieldscripting(3);
    self setphysicaldepthoffield(1, 0, 10);
  }

  thread function_4dbd266953401120();
}

function function_80ac0bc08c91abaf(param) {
  if(isDefined(param)) {
    hud_management::function_b683400f784cb7dc("\rx !GO@\xc2", param);
  }
}

function lockpick_close(delay) {
  hud_management::scripted_widget_destroy("\rx !GO@\xc2");

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\rx !GO@\xc2");
  }

  if(isDefined(delay)) {
    wait delay;
  }

  level.player clearsoundsubmix("kt\xeb\xedM\xb6|\xc39\xe8\xc2\xd7\"\xeb\v\x10E\x1eIo\x96\x8a\x8d\xd8", 1);
  hud_management::function_a4b07de99918f624("\rx !GO@\xc2");
  val::reset_all("\xdeu\xb6Qb\xdd\xa6c\x8a\xc9\x04\x80\xb5X");

  if(!istrue(self.lockpick.no_dof)) {
    self disablephysicaldepthoffieldscripting();
  }
}

function lockpick_reset(delay = 0.2, jostle = 0) {
  if(hud_management::function_48c98ea9a4f0da89("\rx !GO@\xc2")) {
    if(jostle) {
      hud_management::function_d8d634ceece460("\rx !GO@\xc2", "f\xf5\xac\xa4]\r\xf6'\xac\xc8\xa1");
    } else {
      hud_management::function_d8d634ceece460("\rx !GO@\xc2", "\x0fHC\xa9\xed");
    }

    wait max(delay, 0.2);
    hud_management::function_d8d634ceece460("\rx !GO@\xc2", "\x11\xca\xcc\v\xab\xd8:");
  }
}

function is_lockpicking() {
  return level utility::flag("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9") && hud_management::function_48c98ea9a4f0da89("\rx !GO@\xc2");
}

function function_d3ead1862e265a92(control_type) {
  assert(control_type >= 0 && control_type < 2);
  level.lockpicking.control_type = control_type;
}

function private function_4dbd266953401120() {
  self endon("\x15\xbcX\x19vI\x7f\\\xf7\xeb}l\x168vP\xe7:@\x04fg\xe8D\\\x91" + "\rx !GO@\xc2");
  self waittill("\x1e\xfd\xd1\xa2\a");
  thread lockpick_close();
}

function private lockpick_unlocked(val) {
  self notify("v\xc4\xcf\x83\xd8K\x14B");

  if(isDefined(self.lockpick.lock_target)) {
    self.lockpick.lock_target notify("v\xc4\xcf\x83\xd8K\x14B");
  }

  if(isDefined(self.lockpick.unlocked_callback)) {
    self thread[[self.lockpick.unlocked_callback]](self.lockpick.lock_target);
  }

  if(isDefined(self.lockpick) && isDefined(self.lockpick.lock_target) && istrue(self.lockpick.lock_target.var_ac8301aa5eafe707)) {
    self.lockpick.lock_target lockpick_remove();
  }

  lockpick_close(0.5);
}

function private lockpick_closed(val) {
  self notify("A\xf7N\xc8\xb7/\xb2\x10\x9eZ\xd3\xe0\xd0gT");

  if(isDefined(self.lockpick.lock_target)) {
    self.lockpick.lock_target notify("A\xf7N\xc8\xb7/\xb2\x10\x9eZ\xd3\xe0\xd0gT");
  }

  if(isDefined(self.lockpick.close_callback)) {
    self thread[[self.lockpick.close_callback]](self.lockpick.lock_target);
  }

  lockpick_close();
}