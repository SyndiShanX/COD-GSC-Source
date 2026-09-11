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

function shellshockondamage(var0, var1) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }

  if(var0 == "MOD_EXPLOSIVE" || var0 == "MOD_GRENADE" || var0 == "MOD_GRENADE_SPLASH" || var0 == "MOD_PROJECTILE" || var0 == "MOD_PROJECTILE_SPLASH") {
    if(var1 > 10) {
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

function grenade_earthquake(var0, var1) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var2 = undefined;

  if(!isDefined(var1) || var1) {
    self waittill("explode", var2);
  } else {
    var2 = self.origin;
  }

  grenade_earthquakeatposition_internal(var2, var0);
}

function grenade_earthquakeatposition(var0, var1) {
  grenade_earthquakeatposition_internal(var0, var1);
}

function grenade_earthquakeatposition_internal(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  playrumbleonposition("grenade_rumble", var0);
  var2 = 0.45 * var1;
  var3 = 0.7;
  var4 = 800;
  earthquake(var2, var3, var0, var4);
  _screenshakeonposition(var0, 600);
}

function bloodeffect(var0) {
  self endon("disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  var1 = vectorNormalize(anglesToForward(self.angles));
  var2 = vectorNormalize(anglestoright(self.angles));
  var3 = vectorNormalize(var0 - self.origin);
  var4 = vectordot(var3, var1);
  var5 = vectordot(var3, var2);

  if(var4 > 0 && var4 > 0.5) {
    return;
  }

  if(abs(var4) < 0.866) {
    var6 = level._effect["hit_left"];

    if(var5 > 0) {
      var6 = level._effect["hit_right"];
    }

    var7 = ["death", "damage"];
    thread play_fx_with_entity(var6, var7, 7);
    return;
  }
}

function bloodmeleeeffect(var0, var1) {
  self endon("disconnect");
  var2 = ref_14096(var0);

  if(isDefined(var2)) {
    thread attraction_sr_range_hud(var2);
    return;
  }

  var3 = ["death"];
  thread play_fx_with_entity(level._effect["melee_spray"], var3, 1.5);

  if(var0.basename == "iw8_me_t9loadout_mpv") {
    var4 = var1 getcorpseentity();

    if(isDefined(var4)) {
      var5 = ["j_wrist_ri", "j_wrist_le", "j_head"];
      var6 = ["j_knee_ri", "j_knee_le"];
      var7 = self getEye();
      var8 = var4 gettagorigin("j_head");
      var9 = var4 gettagorigin("j_knee_ri");

      if(distancesquared(var8, var7) < distancesquared(var9, var7)) {
        playFXOnTag(level._effect["force_dismemberment"], var4, var5[randomintrange(0, var5.size)]);
        return;
      }

      playFXOnTag(level._effect["force_dismemberment"], var4, var6[randomintrange(0, var6.size)]);
      return;
    }

    return;
  }
}

function ref_14096(var0) {
  if(!isDefined(var0) || !isDefined(var0.receiver)) {
    return undefined;
  }

  if(var0 hasattachment("bloodfx_fire")) {
    return "bloodFXFire";
  }

  if(var0 hasattachment("bloodfx") || scripts\engine\utility::string_starts_with(var0.receiver, "me_sword")) {
    return "bloodFX";
  }

  if(var0 hasattachment("bloodfx_blunt") || scripts\engine\utility::string_starts_with(var0.receiver, "me_kali")) {
    return "bloodFXBlunt";
  }

  if(var0 hasattachment("bloodfx_stab")) {
    return "bloodFXStab";
  }

  return undefined;
}

function attraction_sr_range_hud(var0) {
  self endon("disconnect");
  self setscriptablepartstate("meleeBlood", var0);
  wait 0.05;
  self setscriptablepartstate("meleeBlood", "neutral");
}

function play_fx_with_entity(var0, var1, var2) {
  self endon("disconnect");
  var3 = spawnfxforclient(var0, self getEye(), self);
  triggerfx(var3);
  var3 setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(var1, var2);
  var3 delete();
}

function c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var0);
  playrumbleonposition("grenade_rumble", var0);
  earthquake(0.4, 0.75, var0, 512);
  var1 = scripts\common\utility::playersinsphere(var0, 512);

  foreach(var3 in var1) {
    if(var3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var3 setclientomnvar("ui_hud_shake", 1);
  }
}

function artillery_earthquake(var0, var1, var2, var3, var4) {
  playrumbleonposition("artillery_rumble", var0);

  if(!isDefined(var1)) {
    var1 = 0.7;
  }

  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  if(!isDefined(var3)) {
    var3 = 800;
  }

  earthquake(var1, var2, var0, var3);
  _screenshakeonposition(var0, var3, var4);
}

function stealthairstrike_earthquake(var0) {
  playrumbleonposition("grenade_rumble", var0);
  earthquake(1, 0.6, var0, 2000);
  var1 = scripts\common\utility::playersinsphere(var0, 1000);

  foreach(var3 in var1) {
    if(var3 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var3 setclientomnvar("ui_hud_shake", 1);
  }
}

function airstrike_earthquake(var0) {
  playrumbleonposition("artillery_rumble", var0);
  earthquake(0.5, 0.65, var0, 1000);
  _screenshakeonposition(var0, 900);
}

function pulsegrenade_earthquake(var0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var1 = undefined;

  if(!isDefined(var0) || var0) {
    self waittill("explode", var1);
  } else {
    var1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var1);
  earthquake(0.3, 0.35, var1, 800);
  var2 = scripts\common\utility::playersinsphere(var1, 300);

  foreach(var4 in var2) {
    if(var4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var4 setclientomnvar("ui_hud_shake", 1);
  }
}

function engineerdrone_earthquake(var0) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var1 = undefined;

  if(!isDefined(var0) || var0) {
    self waittill("explode", var1);
  } else {
    var1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var1);
  earthquake(0.3, 0.35, var1, 800);
  var2 = scripts\common\utility::playersinsphere(var1, 300);

  foreach(var4 in var2) {
    if(var4 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var4 setclientomnvar("ui_hud_shake", 1);
  }
}

function _screenshakeonposition(var0, var1, var2) {
  var3 = scripts\common\utility::playersinsphere(var0, var1);

  foreach(var5 in var3) {
    if(isDefined(var2)) {
      if(isarray(var2)) {
        if(scripts\engine\utility::array_contains(var2, var5)) {
          continue;
        }
      } else if(var5 == var2) {
        continue;
      }
    }

    if(var5 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var5 setclientomnvar("ui_hud_shake", 1);
  }
}