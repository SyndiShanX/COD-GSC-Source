/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\rappel.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#namespace rappel;

function private autoexec __init__system__() {
  system::register(#"rappel", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.ascendstarts = struct::get_array("ascend_begin", "script_noteworthy");
  level.descendstarts = struct::get_array("descend_begin", "script_noteworthy");
  level.ascendstructs = [];

  foreach(a in level.ascendstarts) {
    function_731b9325(a, 1);
  }

  foreach(a in level.descendstarts) {
    function_731b9325(a, 0);
  }

  callback::on_rappel(&function_1858cdf2);
  callback::function_c16ce2bc(&function_7e99ed03);

  if(sessionmodeiszombiesgame()) {
    callback::on_bleedout(&function_1fd398d8);
  } else {
    callback::on_player_killed(&on_player_killed);
  }

  callback::on_disconnect(&function_1fd398d8);
  callback::add_callback(#"on_vehicle_enter", &function_8307577f);

  level thread function_efab52ae();
}

function private function_7cbd94d5(b_hide = 1) {
  if(!is_true(level.var_e714f814)) {
    return;
  }

  if(b_hide) {
    self notsolid();

    if(isentity(self.ascenderstart.clip)) {
      self.ascenderstart.clip hidefromplayer(self);

      if(!isDefined(self.var_6c49a5bb)) {
        self.var_6c49a5bb = [];
      } else if(!isarray(self.var_6c49a5bb)) {
        self.var_6c49a5bb = array(self.var_6c49a5bb);
      }

      if(!isinarray(self.var_6c49a5bb, self.ascenderstart.clip)) {
        self.var_6c49a5bb[self.var_6c49a5bb.size] = self.ascenderstart.clip;
      }
    }

    if(isentity(self.var_3eb5bddd.clip)) {
      self.var_3eb5bddd.clip hidefromplayer(self);

      if(!isDefined(self.var_6c49a5bb)) {
        self.var_6c49a5bb = [];
      } else if(!isarray(self.var_6c49a5bb)) {
        self.var_6c49a5bb = array(self.var_6c49a5bb);
      }

      if(!isinarray(self.var_6c49a5bb, self.var_3eb5bddd.clip)) {
        self.var_6c49a5bb[self.var_6c49a5bb.size] = self.var_3eb5bddd.clip;
      }
    }

    return;
  }

  self solid();

  if(isarray(self.var_6c49a5bb)) {
    foreach(clip in self.var_6c49a5bb) {
      if(isentity(clip)) {
        clip showtoplayer(self);
      }
    }

    self.var_6c49a5bb = undefined;
  }
}

function function_1858cdf2() {
  if(sessionmodeiszombiesgame()) {
    self val::set(#"rappel_protect", "takedamage", 0);
    self val::set(#"rappel_protect", "ignoreme", 1);
    self function_7cbd94d5(1);
    self flag::set(#"hash_1b361b950317ecb5");

    if(isDefined(self.ascenderstart)) {
      self thread function_7984d635(self.ascenderstart);
    }

    self thread function_3e38fdfe();
    self thread function_1e1b99b6();
  }
}

function function_5c3294de() {
  if(!isPlayer(self)) {
    return;
  }

  if(!self flag::get(#"hash_1b361b950317ecb5")) {
    return;
  }

  foreach(player in function_a1ef346b(undefined, self.origin, 16)) {
    if(player == self) {
      continue;
    }

    if(player istouching(self) && player getvelocity() == 0) {
      v_dir = anglesToForward(self.angles);
      player setvelocity(v_dir * 500);

      iprintln("<dev string:x38>" + self getentnum() + "<dev string:x4c>" + player getentnum());
    }
  }
}

function function_7e99ed03() {
  self endon(#"disconnect");

  if(sessionmodeiszombiesgame()) {
    waitframe(1);
    self function_5c3294de();
    waitframe(1);
    self val::reset(#"rappel_protect", "disable_weapons");
  }

  self function_1fd398d8();
}

function function_8307577f() {
  if(sessionmodeiszombiesgame()) {
    self val::reset(#"rappel_protect", "takedamage");
    self val::reset(#"rappel_protect", "ignoreme");
  }
}

function on_player_killed(params) {
  self function_1fd398d8();
}

function function_1fd398d8() {
  if(sessionmodeiszombiesgame()) {
    self function_2e714695();
    return;
  }

  function_752582be(self.ascender);
  self.ascender = undefined;
}

function function_752582be(ascender) {
  if(isDefined(ascender)) {
    ascender.inuse = 0;
    hint = # "hash_4079b1df1f035718";
    ascender.trigger sethintstring(hint);

    if(isDefined(ascender.ascendstructend) && isDefined(ascender.ascendstructend.trigger)) {
      ascender.ascendstructend.trigger sethintstring(hint);
      ascender.ascendstructend.inuse = 0;
    }
  }
}

function private function_142825fc() {
  if(isDefined(self.ascenderstart)) {
    self.ascenderstart function_28a2f589(0);
    self.ascenderstart = undefined;
  }
}

function private function_547d97a1() {
  if(isDefined(self.var_3eb5bddd)) {
    self.var_3eb5bddd function_28a2f589(0);
    self.var_3eb5bddd = undefined;
  }
}

function function_2e714695() {
  self notify(#"hash_49fcf7bb78321ac");
  self function_142825fc();
  self function_547d97a1();

  if(self flag::get(#"hash_1b361b950317ecb5")) {
    self flag::clear(#"hash_1b361b950317ecb5");
    self val::reset_all(#"rappel_protect");
    self function_7cbd94d5(0);
  }
}

function function_c487f6c0(ascendstart) {
  if(!isDefined(ascendstart.radius)) {
    ascendstart.radius = 128;
  }

  var_3d783ef7 = spawn("trigger_radius_use", ascendstart.origin + (0, 0, 16), 0, ascendstart.radius, 128);
  var_3d783ef7.ascendstart = ascendstart;
  var_3d783ef7 triggerignoreteam();
  var_3d783ef7 setvisibletoall();
  var_3d783ef7 setteamfortrigger(#"none");
  var_3d783ef7 setcursorhint("HINT_NOICON");
  var_3d783ef7 function_95c6df5a();
  hint = # "hash_4079b1df1f035718";
  var_3d783ef7 sethintstring(hint);
  var_3d783ef7 callback::on_trigger(&function_4945d10b);

  if(sessionmodeiszombiesgame()) {
    if(!isDefined(level.var_f2db450a)) {
      level.var_f2db450a = [];
    } else if(!isarray(level.var_f2db450a)) {
      level.var_f2db450a = array(level.var_f2db450a);
    }

    if(!isinarray(level.var_f2db450a, var_3d783ef7)) {
      level.var_f2db450a[level.var_f2db450a.size] = var_3d783ef7;
    }
  }

  return var_3d783ef7;
}

function function_731b9325(struct, dir) {
  endstruct = struct::get(struct.target, "targetname");
  var_1802b8ab = struct::get(endstruct.target, "targetname");
  level.ascendstructs[struct.target] = struct;
  struct.ascendstructend = endstruct;
  struct.ascendstructout = var_1802b8ab;
  struct.inuse = 0;

  if(sessionmodeiszombiesgame()) {
    struct.cooldown = [];

    if(isDefined(struct.script_string)) {
      struct.clip = getent(struct.script_string, "targetname");
    }
  }

  struct.exitangle = struct.angles + (0, 180, 0);
  struct.startangle = struct.angles;
  struct.dir = dir;
  struct.trigger = function_c487f6c0(struct);
}

function function_8b08f357(player, ascendstart) {
  if(is_true(ascendstart.inuse)) {
    return false;
  }

  if(is_true(player.laststand) && !is_true(player.var_b895a3ff)) {
    return false;
  }

  if(player getstance() == "prone") {
    return false;
  }

  if(!player function_c73c0ee6()) {
    return false;
  }

  if(sessionmodeiszombiesgame()) {
    if(ascendstart.inuse > 0) {
      return false;
    }

    entnum = player getentitynumber();

    if(is_true(ascendstart.cooldown[entnum]) || is_true(ascendstart.ascendstructend.cooldown[entnum])) {
      return false;
    }
  }

  return true;
}

function private function_2f037a69(ascender) {
  self endon(#"death", #"disconnect");

  if(!isDefined(self)) {
    return;
  }

  wait 0.2;
  entnum = self getentitynumber();

  if(is_true(ascender.cooldown[entnum])) {
    hint = # "hash_7030ee296306731c";
  } else if(ascender.inuse > 0) {
    hint = # "hash_607b12b5d5733b3e";
  } else {
    hint = # "hash_4079b1df1f035718";
  }

  ascender.trigger sethintstringforplayer(self, hint);
}

function private function_28a2f589(inuse) {
  self.inuse += inuse ? 1 : -1;
  assert(self.inuse >= 0 && self.inuse <= 4);
  array::thread_all(getplayers(), &function_2f037a69, self);
}

function function_4945d10b(trigger_info) {
  player = trigger_info.activator;
  level endon(#"game_ended");
  player endon(#"death");
  player endon(#"disconnect");
  player endon(#"hash_210eae4f25120927");
  ascendstart = self.ascendstart;

  if(!function_8b08f357(player, ascendstart)) {
    return;
  }

  ascendend = ascendstart.ascendstructend;
  var_81d2b10b = distance(ascendend.origin, ascendstart.origin);

  if(ascendstart.origin[2] > ascendend.origin[2]) {
    var_81d2b10b *= -1;
  }

  if(sessionmodeiszombiesgame()) {
    ascendstart function_28a2f589(1);
    player.ascenderstart = ascendstart;

    if(isDefined(ascendend.trigger)) {
      ascendend function_28a2f589(1);
      player.var_3eb5bddd = ascendend;
    }

    player val::set(#"rappel_protect", "disable_weapons", 2);

    if(isDefined(player.var_6dfeb5ef)) {
      player thread[[player.var_6dfeb5ef]]();
    }

    player waittilltimeout(3, #"weapon_change");
  } else {
    player.ascender = ascendstart;
    thread function_8c46de17(ascendstart, ascendend);
    ascendstart thread function_cf4e25e5();
    ascendstart.inuse = 1;
    ascendend.inuse = 1;
  }

  player function_256406a6(ascendstart.origin, ascendstart.angles[1], var_81d2b10b);
}

function function_8c46de17(ascendstart, ascendend) {
  wait 0.2;
  hint = # "hash_607b12b5d5733b3e";
  ascendstart.trigger sethintstring(hint);

  if(isDefined(ascendend) && isDefined(ascendend.trigger)) {
    ascendend.trigger sethintstring(hint);
  }
}

function private function_cf4e25e5() {
  self notify("2100ea0c1a2c851b");
  self endon("2100ea0c1a2c851b");
  wait 5;
  function_752582be(self);
}

function private function_3e38fdfe() {
  self endon(#"death", #"disconnect", #"rappel_cleanup");
  wait 0.8;
  self function_142825fc();
}

function private function_1e1b99b6() {
  self endon(#"death", #"disconnect", #"rappel_cleanup");
  wait 5;
  self function_547d97a1();
}

function function_7984d635(ascendstart) {
  if(sessionmodeiszombiesgame()) {
    entnum = self getentitynumber();
    ascendend = ascendstart.ascendstructend;
    ascendstart.cooldown[entnum] = 1;
    self thread function_2f037a69(ascendstart);

    if(isDefined(ascendend.trigger)) {
      ascendend.cooldown[entnum] = 1;
      self thread function_2f037a69(ascendend);
    }

    if(isDefined(level.var_fe888e9e)) {
      level waittilltimeout(10, level.var_fe888e9e);
    } else {
      wait 10;
    }

    ascendstart.cooldown[entnum] = undefined;

    if(isDefined(self)) {
      self thread function_2f037a69(ascendstart);
    }

    if(isDefined(ascendend.trigger)) {
      ascendend.cooldown[entnum] = undefined;

      if(isDefined(self)) {
        self thread function_2f037a69(ascendend);
      }
    }
  }
}

function function_efab52ae() {
  while(getdvarint(#"hash_7cfb013f9bd630b6", 0)) {
    waitframe(1);

    foreach(rappel in level.ascendstarts) {
      var_86660d95 = rappel.origin;
      print3d(var_86660d95 + (0, 0, 16), rappel.targetname, (0, 1, 0));
      sphere(var_86660d95, 4, (0, 1, 0));
      circle(var_86660d95, 24, (0, 1, 0), 1, 1);
      line(var_86660d95, rappel.ascendstructend.origin, (0, 1, 0));
    }
  }
}