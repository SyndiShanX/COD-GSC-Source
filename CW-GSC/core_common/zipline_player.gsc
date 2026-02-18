/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\zipline_player.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace zipline_player;

function private autoexec __init__system__() {
  system::register(#"zipline_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_e02fab68 = struct::get_array("zipline_start", "script_noteworthy");

  level thread function_be9add5();

  level.var_8e1ba65f = [];
  level.var_58e84ce5 = getweapon(#"hash_3089757a990e0f6c");

  foreach(a in level.var_e02fab68) {
    function_2a1bd467(a);
  }

  level.var_e02fab68 = undefined;

  if(sessionmodeiszombiesgame()) {
    callback::on_zipline(&function_7205ee5e);
    callback::function_46609b1(&function_96a812e6);
    callback::on_bleedout(&function_9066dc16);
    callback::on_disconnect(&function_9066dc16);
    callback::add_callback(#"on_vehicle_enter", &function_8307577f);
  }
}

function private function_733c3cbb(b_hide = 1) {
  if(!is_true(level.var_f30c7ef1)) {
    return;
  }

  if(b_hide) {
    self notsolid();

    if(isentity(self.var_5da09c55.clip)) {
      self.var_5da09c55.clip hidefromplayer(self);

      if(!isDefined(self.var_6d2b99d1)) {
        self.var_6d2b99d1 = [];
      } else if(!isarray(self.var_6d2b99d1)) {
        self.var_6d2b99d1 = array(self.var_6d2b99d1);
      }

      if(!isinarray(self.var_6d2b99d1, self.var_5da09c55.clip)) {
        self.var_6d2b99d1[self.var_6d2b99d1.size] = self.var_5da09c55.clip;
      }
    }

    if(isentity(self.var_7bc01517.clip)) {
      self.var_7bc01517.clip hidefromplayer(self);

      if(!isDefined(self.var_6d2b99d1)) {
        self.var_6d2b99d1 = [];
      } else if(!isarray(self.var_6d2b99d1)) {
        self.var_6d2b99d1 = array(self.var_6d2b99d1);
      }

      if(!isinarray(self.var_6d2b99d1, self.var_7bc01517.clip)) {
        self.var_6d2b99d1[self.var_6d2b99d1.size] = self.var_7bc01517.clip;
      }
    }

    return;
  }

  self solid();

  if(isarray(self.var_6d2b99d1)) {
    foreach(clip in self.var_6d2b99d1) {
      if(isentity(clip)) {
        clip showtoplayer(self);
      }
    }

    self.var_6d2b99d1 = undefined;
  }
}

function function_7205ee5e() {
  if(isDefined(self.var_5da09c55.trigger) && !isDefined(self.var_c09c6e0a)) {
    self.var_c09c6e0a = self.var_5da09c55.trigger;
    self.var_c09c6e0a setinvisibletoplayer(self);
  }

  if(isDefined(self.var_7bc01517.trigger) && !isDefined(self.var_30b41973)) {
    self.var_30b41973 = self.var_7bc01517.trigger;
    self.var_30b41973 setinvisibletoplayer(self);
  }

  self function_733c3cbb(1);
  self val::set(#"zipline_protect", "takedamage", 0);
  self val::set(#"zipline_protect", "ignoreme", 1);
  self flag::set(#"hash_686d5709e1566aa6");

  if(isDefined(self.var_5da09c55)) {
    self thread function_c54ca80d(self.var_5da09c55);
  }

  self thread function_f7f636b8();
  self thread function_39e551d4();
}

function private function_9194becb(n_delay = undefined) {
  self endon(#"disconnect");
  trigger_start = self.var_c09c6e0a;
  var_487cfa48 = self.var_30b41973;
  self.var_c09c6e0a = undefined;
  self.var_30b41973 = undefined;

  if(isDefined(n_delay)) {
    wait n_delay;
  }

  if(isDefined(trigger_start)) {
    trigger_start setvisibletoplayer(self);
  }

  if(isDefined(var_487cfa48)) {
    var_487cfa48 setvisibletoplayer(self);
  }
}

function function_96a812e6() {
  self function_d8f0d6ea();
  self function_9194becb(1);
}

function function_8307577f(params) {
  self val::reset(#"zipline_protect", "takedamage");
  self val::reset(#"zipline_protect", "ignoreme");
}

function private function_25fbe208() {
  if(isDefined(self.var_5da09c55)) {
    self.var_5da09c55 function_33111d8d(0);
    self.var_5da09c55 = undefined;
  }
}

function private function_802dd110() {
  if(isDefined(self.var_7bc01517)) {
    self.var_7bc01517 function_33111d8d(0);
    self.var_7bc01517 = undefined;
  }
}

function function_9066dc16() {
  self function_d8f0d6ea();
  self function_9194becb();
}

function private function_d8f0d6ea() {
  self notify(#"zipline_cleanup");
  self function_25fbe208();
  self function_802dd110();

  if(self flag::get(#"hash_686d5709e1566aa6")) {
    self flag::clear(#"hash_686d5709e1566aa6");
    self val::reset_all(#"zipline_protect");
    self function_733c3cbb(0);
  }
}

function function_e415c864(var_5da09c55) {
  if(!isDefined(var_5da09c55.radius)) {
    var_5da09c55.radius = 96;
  }

  if(!isDefined(var_5da09c55.height)) {
    var_5da09c55.height = 128;
  }

  var_912fa366 = spawn("trigger_radius_use", var_5da09c55.origin + (0, 0, 16), 0, var_5da09c55.radius, var_5da09c55.height);
  var_912fa366.var_5da09c55 = var_5da09c55;
  var_912fa366 triggerignoreteam();
  var_912fa366 setvisibletoall();
  var_912fa366 setteamfortrigger(#"none");
  var_912fa366 setcursorhint("HINT_NOICON");
  hint = # "hash_5ca3696cb6c3bea9";
  var_912fa366 sethintstring(hint);
  var_912fa366 callback::on_trigger(&zipline_use);
  var_912fa366 function_2e7a1fba();

  if(sessionmodeiszombiesgame()) {
    if(!isDefined(level.var_f2db450a)) {
      level.var_f2db450a = [];
    } else if(!isarray(level.var_f2db450a)) {
      level.var_f2db450a = array(level.var_f2db450a);
    }

    if(!isinarray(level.var_f2db450a, var_912fa366)) {
      level.var_f2db450a[level.var_f2db450a.size] = var_912fa366;
    }
  }

  return var_912fa366;
}

function function_77fde59c(var_5da09c55) {
  var_912fa366 = spawn("trigger_radius", var_5da09c55.origin + (0, 0, 16), 0, 96, 128);
  var_912fa366.var_5da09c55 = var_5da09c55;
  var_912fa366 triggerignoreteam();
  var_912fa366 setvisibletoall();
  var_912fa366 setteamfortrigger(#"none");
  var_912fa366 callback::on_trigger(&function_5abc3f1f);

  if(sessionmodeiszombiesgame()) {
    if(!isDefined(level.var_f2db450a)) {
      level.var_f2db450a = [];
    } else if(!isarray(level.var_f2db450a)) {
      level.var_f2db450a = array(level.var_f2db450a);
    }

    if(!isinarray(level.var_f2db450a, var_912fa366)) {
      level.var_f2db450a[level.var_f2db450a.size] = var_912fa366;
    }
  }

  return var_912fa366;
}

function function_5abc3f1f(trigger_info) {
  player = trigger_info.activator;

  if(!isPlayer(player)) {
    return;
  }

  if(player isziplining()) {
    return;
  }

  if(!player isinair()) {
    return;
  }

  velocity = player getvelocity();
  var_aba19503 = self.var_5da09c55.endstruct.origin - self.var_5da09c55.origin;
  var_aba19503 = vectornormalize(var_aba19503);
  velocitymag = vectordot(var_aba19503, velocity);

  if(velocitymag < getdvarfloat(#"hash_22b8f78d9b451771", 170)) {
    return;
  }

  angles = player getangles();
  forward = anglesToForward(angles);

  if(vectordot(var_aba19503, forward) < getdvarfloat(#"hash_1d72909e619429dc", -1)) {
    return;
  }

  player function_827228db(self.var_5da09c55.endstruct.origin, self.var_5da09c55.origin, 1, self.var_5da09c55);
}

function function_2a1bd467(struct) {
  endstruct = struct::get(struct.target, "targetname");

  if(!isDefined(endstruct)) {
    return;
  }

  level.var_8e1ba65f[struct.target] = struct;

  if(sessionmodeiszombiesgame()) {
    struct.inuse = 0;
    struct.cooldown = [];

    if(isDefined(struct.script_string)) {
      struct.clip = getent(struct.script_string, "targetname");
    }
  }

  struct.endstruct = endstruct;
  struct.trigger = function_e415c864(struct);
}

function function_f8e9f7d7(player, var_5da09c55) {
  if(player laststand::player_is_in_laststand() && !is_true(player.var_b895a3ff)) {
    return false;
  }

  if(player getstance() == "prone") {
    return false;
  }

  if(!player function_b59f3ecd()) {
    return false;
  }

  if(sessionmodeiszombiesgame()) {
    if(var_5da09c55.inuse > 0) {
      return false;
    }

    entnum = player getentitynumber();

    if(is_true(var_5da09c55.cooldown[entnum]) || is_true(var_5da09c55.endstruct.cooldown[entnum])) {
      return false;
    }
  }

  weapon = player getcurrentweapon();

  if(killstreaks::is_killstreak_weapon(weapon) && weapon.iscarriedkillstreak !== 1 || weapon === level.weaponnone) {
    return false;
  }

  return true;
}

function zipline_use(trigger_info) {
  player = trigger_info.activator;
  var_5da09c55 = self.var_5da09c55;

  if(!function_f8e9f7d7(player, var_5da09c55)) {
    return;
  }

  if(sessionmodeiszombiesgame()) {
    var_5da09c55 function_33111d8d(1);
    player.var_5da09c55 = var_5da09c55;
    var_7bc01517 = var_5da09c55.endstruct;

    if(isDefined(var_7bc01517.trigger)) {
      var_7bc01517 function_33111d8d(1);
      player.var_7bc01517 = var_7bc01517;
    }

    if(isDefined(var_5da09c55.trigger)) {
      player.var_c09c6e0a = var_5da09c55.trigger;
      player.var_c09c6e0a setinvisibletoplayer(player);
    }

    if(isDefined(var_7bc01517.trigger)) {
      player.var_30b41973 = var_7bc01517.trigger;
      player.var_30b41973 setinvisibletoplayer(player);
    }
  }

  player function_827228db(var_5da09c55.endstruct.origin, var_5da09c55.origin, 0, var_5da09c55);
}

function function_827228db(target, start, inair, var_5da09c55) {
  var_b527f10 = spawn("script_model", self.origin);
  var_b527f10 setModel("tag_origin");
  var_b527f10 setowner(self);
  var_b527f10 setweapon(level.var_58e84ce5);
  self function_ac5595ff(start, inair, var_5da09c55, var_b527f10);
  self.var_b527f10 = var_b527f10;
}

function private function_c4035adb(zipline) {
  entnum = self getentitynumber();

  if(is_true(zipline.cooldown[entnum])) {
    hint = # "hash_55e4459830283bc7";
  } else if(zipline.inuse > 0) {
    hint = # "hash_d51ffb83d896d2d";
  } else {
    hint = # "hash_5ca3696cb6c3bea9";
  }

  zipline.trigger sethintstringforplayer(self, hint);
}

function private function_33111d8d(inuse) {
  self.inuse += inuse ? 1 : -1;
  assert(self.inuse >= 0 && self.inuse <= 4);
  array::thread_all(getplayers(), &function_c4035adb, self);
}

function private function_f7f636b8() {
  self endon(#"death", #"disconnect", #"zipline_cleanup");
  wait 0.8;
  self function_25fbe208();
}

function private function_39e551d4() {
  self endon(#"death", #"disconnect", #"zipline_cleanup");
  wait 5;
  self function_802dd110();
}

function function_c54ca80d(var_5da09c55) {
  if(sessionmodeiszombiesgame()) {
    entnum = self getentitynumber();
    var_7bc01517 = var_5da09c55.endstruct;
    var_5da09c55.cooldown[entnum] = 1;
    self function_c4035adb(var_5da09c55);

    if(isDefined(var_7bc01517.trigger)) {
      var_7bc01517.cooldown[entnum] = 1;
      self function_c4035adb(var_7bc01517);
    }

    if(isDefined(level.var_aff839f3)) {
      level waittilltimeout(10, level.var_aff839f3);
    } else {
      wait 10;
    }

    var_5da09c55.cooldown[entnum] = undefined;

    if(isDefined(self)) {
      self function_c4035adb(var_5da09c55);
    }

    if(isDefined(var_7bc01517.trigger)) {
      var_7bc01517.cooldown[entnum] = undefined;

      if(isDefined(self)) {
        self function_c4035adb(var_7bc01517);
      }
    }
  }
}

function function_be9add5() {
  if(!getdvarint(#"hash_13a9fb4be8e86e13", 0)) {
    return;
  }

  ziplines = level.var_e02fab68;
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");

  while(getdvarint(#"hash_13a9fb4be8e86e13", 0)) {
    waitframe(1);

    foreach(zipline in ziplines) {
      var_86660d95 = zipline.origin;
      print3d(var_86660d95 + (0, 0, 16), zipline.targetname, (0, 1, 0));
      sphere(var_86660d95, 4, (0, 1, 0));
      circle(var_86660d95, zipline.radius, (0, 1, 0), 1, 1);
      circle(var_86660d95 + (0, 0, zipline.height), zipline.radius, (0, 1, 0), 1, 1);
      line(var_86660d95, zipline.endstruct.origin, (0, 1, 0));

      if(isDefined(level.var_94f4ca81)) {
        foreach(dataset in level.var_94f4ca81.dataset) {
          foreach(spawn in dataset.spawns) {
            spawn_origin = spawn.origin;

            if(distance2dsquared(spawn_origin, var_86660d95) <= 4096) {
              cylinder(spawn_origin, spawn_origin + (0, 0, 72), 15, (1, 0, 0));
              sphere(spawn_origin, 4, (1, 0, 0));
            }
          }
        }
      }
    }
  }
}