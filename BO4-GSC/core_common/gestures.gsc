/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\gestures.gsc
***********************************************/

#include scripts\core_common\system_shared;

#namespace gestures;

autoexec __init__system__() {
  system::register(#"gestures", undefined, &main, undefined);
}

main() {
  function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_dw");
  function_a5202150(#"hash_419f11534af12a76", "sig_buckler_dw");
  function_a5202150(#"ges_blinded", "sig_buckler_dw");
  function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_dw");
  function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_dw");
  function_a5202150(#"ges_grab", "sig_buckler_dw");
  function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_dw");
  function_a5202150(#"hash_577f00f59de390db", "sig_buckler_dw");
  function_a5202150(#"ges_shocked", "sig_buckler_dw");
  function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_dw");
  function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_turret");
  function_a5202150(#"hash_419f11534af12a76", "sig_buckler_turret");
  function_a5202150(#"ges_blinded", "sig_buckler_turret");
  function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_turret");
  function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_turret");
  function_a5202150(#"ges_grab", "sig_buckler_turret");
  function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_turret");
  function_a5202150(#"hash_577f00f59de390db", "sig_buckler_turret");
  function_a5202150(#"ges_shocked", "sig_buckler_turret");
  function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_turret");
}

give_gesture(gestureweapon) {
  assert(gestureweapon != level.weaponnone, "<dev string:x38>");
  assert(!isDefined(self.gestureweapon) || self.gestureweapon == level.weaponnone, "<dev string:x67>");
  self setactionslot(3, "taunt");
  self giveweapon(gestureweapon);
  self.gestureweapon = gestureweapon;
}

clear_gesture() {
  self notify(#"cleargesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != level.weaponnone) {
    self setactionslot(3, "");
    self takeweapon(self.gestureweapon);
    self.gestureweapon = level.weaponnone;
  }
}

function_e198bde3(gesturename) {
  if(!isDefined(gesturename)) {
    return 0;
  }

  if(gesturename == "") {
    return 0;
  }

  var_45e6768d = gesturename;

  if(!ishash(var_45e6768d)) {
    var_45e6768d = hash(var_45e6768d);
  }

  return var_45e6768d;
}

function_a5202150(gesturename, weaponname) {
  if(!isDefined(level.gesturedata)) {
    level.gesturedata = [];
  }

  var_45e6768d = function_e198bde3(gesturename);

  if(!ishash(var_45e6768d)) {
    return;
  }

  weapon = getweapon(weaponname);

  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return;
  }

  if(!isDefined(level.gesturedata[var_45e6768d])) {
    level.gesturedata[var_45e6768d] = spawnStruct();
  }

  if(!isDefined(level.gesturedata[var_45e6768d].weapons)) {
    level.gesturedata[var_45e6768d].weapons = [];
  }

  if(!isDefined(level.gesturedata[var_45e6768d].weapons[weapon])) {
    level.gesturedata[var_45e6768d].weapons[weapon] = spawnStruct();
  }

  level.gesturedata[var_45e6768d].weapons[weapon].var_fa9d3758 = 1;
}

function_ba4529d4(gesturename) {
  if(!isDefined(level.gesturedata)) {
    level.gesturedata = [];
  }

  var_45e6768d = function_e198bde3(gesturename);

  if(!ishash(var_45e6768d)) {
    return;
  }

  if(!isDefined(level.gesturedata[var_45e6768d])) {
    level.gesturedata[var_45e6768d] = spawnStruct();
  }

  level.gesturedata[var_45e6768d].var_93380a93 = 1;
}

function_8cc27b6d(gesturename) {
  var_45e6768d = function_e198bde3(gesturename);

  if(!ishash(var_45e6768d)) {
    return false;
  }

  weapon = self getcurrentweapon();

  if(isDefined(self.disablegestures) && self.disablegestures) {
    return false;
  }

  if(!isDefined(weapon) || level.weaponnone == weapon) {
    return false;
  }

  if(isDefined(weapon.var_d2751f9d) && weapon.var_d2751f9d) {
    return false;
  }

  if(isDefined(weapon.var_554be9f7) && weapon.var_554be9f7 && self isfiring()) {
    return false;
  }

  if(isDefined(level.gesturedata) && isDefined(level.gesturedata[var_45e6768d]) && isDefined(level.gesturedata[var_45e6768d].weapons) && isDefined(level.gesturedata[var_45e6768d].weapons[weapon.rootweapon]) && isDefined(level.gesturedata[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758) && level.gesturedata[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758) {
    return false;
  }

  if(weapon.isdualwield && isDefined(level.gesturedata) && isDefined(level.gesturedata[var_45e6768d]) && isDefined(level.gesturedata[var_45e6768d].var_93380a93) && level.gesturedata[var_45e6768d].var_93380a93) {
    return false;
  }

  if(self function_55acff10()) {
    return false;
  }

  return true;
}

function_c77349d4(var_851342cf) {
  gesturename = undefined;

  if(isDefined(var_851342cf)) {
    weapon = self getcurrentweapon();
    stancetype = weapon.var_6566504b;
    gesturename = function_d12fe2ad(var_851342cf, stancetype);
  }

  return gesturename;
}

play_gesture(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
  if(!isDefined(self)) {
    return 0;
  }

  if(self function_8cc27b6d(gesturename)) {
    return self function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
  }

  return 0;
}

function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
  return self playgestureviewmodel(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

function_56e00fbf(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
  if(!isDefined(self)) {
    return 0;
  }

  gesturename = self function_c77349d4(var_851342cf);
  return play_gesture(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

function_e62f6dde(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall) {
  if(!isDefined(self)) {
    return 0;
  }

  gesturename = self function_c77349d4(var_851342cf);
  return function_b6cc48ed(gesturename, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

function_f3e2696f(ent, weapon, weapon_options, timeout, var_1e89628f, var_1d78d31, callbackfail) {
  self endon(#"death");
  self disableweaponcycling();

  while(self isswitchingweapons()) {
    waitframe(1);
  }

  self enableweaponcycling();
  var_f3b15ce0 = 0;

  if(!self giveandfireoffhand(weapon, weapon_options)) {
    if(isDefined(callbackfail)) {
      self[[callbackfail]](ent, var_f3b15ce0);
    }

    return;
  }

  while(true) {
    result = self waittilltimeout(timeout, #"grenade_pullback", #"offhand_fire", #"offhand_end");

    if(result._notify == #"timeout") {
      break;
    }

    if(result.weapon == weapon) {
      if(result._notify == #"offhand_end") {
        break;
      }

      if(result._notify == #"grenade_pullback") {
        var_f3b15ce0 = 1;

        if(isDefined(var_1e89628f)) {
          self[[var_1e89628f]](ent);
        }

        continue;
      }

      if(result._notify == #"offhand_fire") {
        if(isDefined(var_1d78d31)) {
          self[[var_1d78d31]](ent);
        }

        return;
      }
    }
  }

  if(isDefined(callbackfail)) {
    self[[callbackfail]](ent, var_f3b15ce0);
  }
}