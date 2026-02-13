/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2068.gsc
*************************************************/

init() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = loadfx("vfx/core/screen/vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx/core/screen/vfx_blood_hit_right");
  level._effect["melee_spray"] = loadfx("vfx/core/screen/vfx_melee_blood_spray");
  level._effect["melee_spray_chrome"] = loadfx("vfx/s4/weapon/_mtx/s4/blood/vfx_melee_blood_spray_chrome");
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", _id_0A0B::_id_2EEC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", _id_0A06::_id_2EEC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", _id_0A0D::_id_616B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", _id_07E8::_id_6D28);
}

_id_D9D4(var_0, var_1) {
  if(isDefined(self._id_5CA2) && gettime() < self._id_5CA2) {
    return;
  }
  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isDefined(self._id_D9D5) && self._id_D9D5) {
        _id_09C8::_id_0CF9("light_damage_mp", "damage", self._id_D9D5);
      } else {
        _id_09C8::_id_0CF9("light_damage_mp", "damage", 0.5);
      }
    }
  }
}

_id_5334() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_7143(var_0, var_1) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread _id_5334();
  self endon("end_explode");
  var_2 = undefined;

  if(!isDefined(var_1) || var_1) {
    self waittill("explode", var_2);
  } else {
    var_2 = self.origin;
  }

  _id_7145(var_2, var_0);
}

_id_7144(var_0, var_1) {
  _id_7145(var_0, var_1);
}

_id_7145(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  playrumbleonposition("grenade_rumble", var_0);
  var_2 = 0.45 * var_1;
  var_3 = 0.7;
  var_4 = 800;
  earthquake(var_2, var_3, var_0, var_4);
  _id_0CD9(var_0, 600);
}

_id_25AF(var_0) {
  self endon("disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);

  if(var_4 > 0 && var_4 > 0.5) {
    return;
  }
  if(abs(var_4) < 0.866) {
    var_6 = level._effect["hit_left"];

    if(var_5 > 0) {
      var_6 = level._effect["hit_right"];
    }

    var_7 = ["death", "damage"];
    thread _id_B236(var_6, var_7, 7.0);
  } else {}
}

_id_25B0(var_0, var_1) {
  self endon("disconnect");
  var_2 = _id_FEC6(var_0);

  if(isDefined(var_2)) {
    thread _id_0EF8(var_2);
  } else {
    var_3 = "melee_spray";
    var_4 = isDefined(var_1) && var_1._id_EAF7 == "s4_suit_mp_doggett";

    if(var_4 && getdvarint("#x34a18b00fc99c883b")) {
      var_3 = "melee_spray_chrome";
    }

    var_5 = ["death"];
    thread _id_B236(level._effect[var_3], var_5, 1.5);
  }
}

_id_FEC6(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  switch (var_0.basename) {
    case "iw8_me_hatchet_mp":
    case "iw8_me_sword_mp":
      return "bloodAxe";
    default:
      return undefined;
  }
}

_id_0EF8(var_0) {
  self endon("disconnect");
  self setscriptablepartstate("meleeBlood", var_0);
  wait 0.05;
  self setscriptablepartstate("meleeBlood", "neutral");
}

_id_B236(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = _func_020D(var_0, self getEye(), self);
  triggerfx(var_3);
  var_3 _meth_8322();
  scripts\engine\utility::_id_10890(var_1, var_2);
  var_3 delete();
}

_id_2E51() {
  thread _id_5334();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);
  var_1 = scripts\common\utility::_id_B7BF(var_0, 512);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_1C1F(var_0, var_1, var_2, var_3, var_4) {
  playrumbleonposition("artillery_rumble", var_0);

  if(!isDefined(var_1)) {
    var_1 = 0.7;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(!isDefined(var_3)) {
    var_3 = 800;
  }

  earthquake(var_1, var_2, var_0, var_3);
  _id_0CD9(var_0, var_3, var_4);
}

_id_E7F0(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(1.0, 0.6, var_0, 2000);
  var_1 = scripts\common\utility::_id_B7BF(var_0, 1000);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_13C1(var_0) {
  playrumbleonposition("artillery_rumble", var_0);
  earthquake(0.5, 0.65, var_0, 1000);
  _id_0CD9(var_0, 900);
}

_id_BE24(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread _id_5334();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::_id_B7BF(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_4 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_5460(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread _id_5334();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::_id_B7BF(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_4 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_0CD9(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::_id_B7BF(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_2)) {
      if(_func_0107(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5)) {
          continue;
        }
      } else if(var_5 == var_2)
        continue;
    }

    if(var_5 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_5 setclientomnvar("ui_hud_shake", 1);
  }
}