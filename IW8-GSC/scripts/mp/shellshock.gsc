/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\shellshock.gsc
***********************************************/

function init() {
  level._effect["hit_left"] = loadfx("vfx/core/screen/vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx/core/screen/vfx_blood_hit_right");
  level._effect["melee_spray"] = loadfx("vfx/core/screen/vfx_melee_blood_spray");
  level._effect["force_dismemberment"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_dismember_melee_weapon");
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", &scripts\mp\equipment\flash_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", &scripts\mp\equipment\concussion_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", &scripts\mp\equipment\gas_grenade::gas_getblurinterruptdelayms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", &scripts\mp\laststand::getshellshockinterruptdelayms);
}

function shellshockondamage(var_0, var_1) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }

  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        scripts\cp_mp\utility\shellshock_utility::_shellshock("light_damage_mp", "damage", self.shellshockreduction);
        return;
      }

      scripts\cp_mp\utility\shellshock_utility::_shellshock("light_damage_mp", "damage", 0.5);
      return;
    }

    return;
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function grenade_earthquake(var_0, var_1) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_2 = undefined;

  if(!isDefined(var_1) || var_1) {
    self waittill("explode", var_2);
  } else {
    var_2 = self.origin;
  }

  grenade_earthquakeatposition_internal(var_2, var_0);
}

function grenade_earthquakeatposition(var_0, var_1) {
  grenade_earthquakeatposition_internal(var_0, var_1);
}

function grenade_earthquakeatposition_internal(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  playrumbleonposition("grenade_rumble", var_0);
  var_2 = 0.45 * var_1;
  var_3 = 0.7;
  var_4 = 800;
  earthquake(var_2, var_3, var_0, var_4);
  _screenshakeonposition(var_0, 600);
}

function bloodeffect(var_0) {
  self endon("disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
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
    thread play_fx_with_entity(var_6, var_7, 7);
    return;
  }
}

function bloodmeleeeffect(var_0, var_1) {
  self endon("disconnect");
  var_2 = ref_14096(var_0);

  if(isDefined(var_2)) {
    thread attraction_sr_range_hud(var_2);
    return;
  }

  var_3 = ["death"];
  thread play_fx_with_entity(level._effect["melee_spray"], var_3, 1.5);

  if(var_0.basename == "iw8_me_t9loadout_mpv") {
    var_4 = var_1 getcorpseentity();

    if(isDefined(var_4)) {
      var_5 = ["j_wrist_ri", "j_wrist_le", "j_head"];
      var_6 = ["j_knee_ri", "j_knee_le"];
      var_7 = self getEye();
      var_8 = var_4 gettagorigin("j_head");
      var_9 = var_4 gettagorigin("j_knee_ri");

      if(distancesquared(var_8, var_7) < distancesquared(var_9, var_7)) {
        playFXOnTag(level._effect["force_dismemberment"], var_4, var_5[randomintrange(0, var_5.size)]);
        return;
      }

      playFXOnTag(level._effect["force_dismemberment"], var_4, var_6[randomintrange(0, var_6.size)]);
      return;
    }

    return;
  }
}

function ref_14096(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.receiver)) {
    return undefined;
  }

  if(var_0 hasattachment("bloodfx_fire")) {
    return "bloodFXFire";
  }

  if(var_0 hasattachment("bloodfx") || scripts\engine\utility::string_starts_with(var_0.receiver, "me_sword")) {
    return "bloodFX";
  }

  if(var_0 hasattachment("bloodfx_blunt") || scripts\engine\utility::string_starts_with(var_0.receiver, "me_kali")) {
    return "bloodFXBlunt";
  }

  if(var_0 hasattachment("bloodfx_stab")) {
    return "bloodFXStab";
  }

  return undefined;
}

function attraction_sr_range_hud(var_0) {
  self endon("disconnect");
  self setscriptablepartstate("meleeBlood", var_0);
  wait 0.05;
  self setscriptablepartstate("meleeBlood", "neutral");
}

function play_fx_with_entity(var_0, var_1, var_2) {
  self endon("disconnect");
  var_3 = spawnfxforclient(var_0, self getEye(), self);
  triggerfx(var_3);
  var_3 setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(var_1, var_2);
  var_3 delete();
}

function c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);
  var_1 = scripts\common\utility::playersinsphere(var_0, 512);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

function artillery_earthquake(var_0, var_1, var_2, var_3, var_4) {
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
  _screenshakeonposition(var_0, var_3, var_4);
}

function stealthairstrike_earthquake(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(1, 0.6, var_0, 2000);
  var_1 = scripts\common\utility::playersinsphere(var_0, 1000);

  foreach(var_3 in var_1) {
    if(var_3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

function airstrike_earthquake(var_0) {
  playrumbleonposition("artillery_rumble", var_0);
  earthquake(0.5, 0.65, var_0, 1000);
  _screenshakeonposition(var_0, 900);
}

function pulsegrenade_earthquake(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::playersinsphere(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_4 setclientomnvar("ui_hud_shake", 1);
  }
}

function engineerdrone_earthquake(var_0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.3, 0.35, var_1, 800);
  var_2 = scripts\common\utility::playersinsphere(var_1, 300);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_4 setclientomnvar("ui_hud_shake", 1);
  }
}

function _screenshakeonposition(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersinsphere(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_2)) {
      if(isarray(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5)) {
          continue;
        }
      } else if(var_5 == var_2) {
        continue;
      }
    }

    if(var_5 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_5 setclientomnvar("ui_hud_shake", 1);
  }
}