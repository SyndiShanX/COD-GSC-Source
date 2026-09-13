/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\shellshock.gsc
***********************************************/

init() {
  level._effect["slide_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = loadfx("vfx/core/screen/vfx_blood_hit_left");
  level._effect["hit_right"] = loadfx("vfx/core/screen/vfx_blood_hit_right");
  level._effect["melee_spray"] = loadfx("vfx/core/screen/vfx_melee_blood_spray");
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", scripts\mp\equipment\flash_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", scripts\mp\equipment\concussion_grenade::calculateinterruptdelay);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "gasInterruptDelayFunc", scripts\mp\equipment\gas_grenade::gas_getblurinterruptdelayms);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", scripts\mp\laststand::getshellshockinterruptdelayms);
}

shellshockondamage(cause, damage) {
  if(isDefined(self.flashendtime) && gettime() < self.flashendtime) {
    return;
  }
  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction)
        scripts\cp_mp\utility\shellshock_utility::_shellshock("light_damage_mp", "damage", self.shellshockreduction);
      else
        scripts\cp_mp\utility\shellshock_utility::_shellshock("light_damage_mp", "damage", 0.5);
    }
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthquake(scale, _id_7BB0EAC0599AA23D) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(_id_7BB0EAC0599AA23D) || _id_7BB0EAC0599AA23D)
    self waittill("explode", position);
  else
    position = self.origin;

  grenade_earthquakeatposition_internal(position, scale);
}

grenade_earthquakeatposition(position, scale) {
  grenade_earthquakeatposition_internal(position, scale);
}

grenade_earthquakeatposition_internal(position, scale) {
  if(!isDefined(scale))
    scale = 1;

  playrumbleonposition("grenade_rumble", position);
  _id_BE290E030AE1165A = 0.45 * scale;
  _id_D4400603D79F0CF4 = 0.7;
  _id_CB920E03144E9344 = 800;
  earthquake(_id_BE290E030AE1165A, _id_D4400603D79F0CF4, position, _id_CB920E03144E9344);
  _screenshakeonposition(position, 600);
}

bloodmeleeeffect(objweapon) {
  self endon("disconnect");

  if(!isdismembermentenabled()) {
    return;
  }
  scriptablestate = usescriptablemeleeblood(objweapon);

  if(isDefined(scriptablestate))
    self setscriptablepartstate("meleeBlood", scriptablestate);
  else {
    _id_AB9868B0589A6052 = ["death"];
    thread play_fx_with_entity(level._effect["melee_spray"], _id_AB9868B0589A6052, 1.5);
  }
}

usescriptablemeleeblood(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.receiver))
    return undefined;

  if(_id_0CBB0697DE4C5728::_id_BB839BB513295F10(objweapon))
    return "bloodFXNova";

  if(_id_0CBB0697DE4C5728::_id_55D5C766B382551E(objweapon))
    return "bloodFXDoom";

  if(objweapon.basename == "iw9_me_sword01_mp")
    return "bloodFX";
  else
    return undefined;
}

play_fx_with_entity(fx, _id_AB9868B0589A6052, timeout) {
  self endon("disconnect");
  _id_22F48FD7DF6C56FB = spawnfxforclient(fx, self getEye(), self);
  triggerfx(_id_22F48FD7DF6C56FB);
  _id_22F48FD7DF6C56FB setfxkilldefondelete();
  scripts\engine\utility::waittill_any_in_array_or_timeout(_id_AB9868B0589A6052, timeout);
  _id_22F48FD7DF6C56FB delete();
}

c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", position);
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.4, 0.75, position, 512);
  _id_99AFF74B8EA85298 = scripts\common\utility::playersinsphere(position, 512);

  foreach(player in _id_99AFF74B8EA85298) {
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}

artillery_earthquake(position, duration, _id_ED404DB23F89E299, _id_ED1D39B23F636EE5, _id_ED1D3FB23F637C17, radiusmax, _id_809F6A04440A9DBB, _id_809F6404440A9089, _id_078CE85A35312119, _id_3090DD77B542DB96, _id_A03583ED539BDB39) {
  if(!isDefined(duration))
    duration = 1.0;

  if(!isDefined(_id_ED404DB23F89E299))
    _id_ED404DB23F89E299 = 0.35;

  if(!isDefined(_id_ED1D39B23F636EE5))
    _id_ED1D39B23F636EE5 = 0.15;

  if(!isDefined(_id_ED1D3FB23F637C17))
    _id_ED1D3FB23F637C17 = 0.05;

  if(!isDefined(radiusmax))
    radiusmax = 800;

  if(!isDefined(_id_809F6A04440A9DBB))
    _id_809F6A04440A9DBB = 2500;

  if(!isDefined(_id_809F6404440A9089))
    _id_809F6404440A9089 = 10000;

  if(!isDefined(_id_3090DD77B542DB96))
    _id_3090DD77B542DB96 = 1;

  if(!isDefined(_id_A03583ED539BDB39))
    _id_A03583ED539BDB39 = 1;

  _func_E45E5FD94EC4AF36(_id_ED404DB23F89E299, _id_ED1D39B23F636EE5, _id_ED1D3FB23F637C17, duration, position, radiusmax, _id_809F6A04440A9DBB, _id_809F6404440A9089);

  if(istrue(_id_3090DD77B542DB96))
    playrumbleonposition("artillery_rumble", position);

  if(istrue(_id_A03583ED539BDB39))
    _screenshakeonposition(position, radiusmax, _id_078CE85A35312119);
}

stealthairstrike_earthquake(position) {
  playrumbleonposition("grenade_rumble", position);
  earthquake(1.0, 0.6, position, 2000);
  _id_99AFF74B8EA85298 = scripts\common\utility::playersinsphere(position, 1000);

  foreach(player in _id_99AFF74B8EA85298) {
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}

airstrike_earthquake(position) {
  playrumbleonposition("artillery_rumble", position);
  earthquake(0.5, 0.65, position, 1000);
  _screenshakeonposition(position, 900);
}

pulsegrenade_earthquake(_id_7BB0EAC0599AA23D) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(_id_7BB0EAC0599AA23D) || _id_7BB0EAC0599AA23D)
    self waittill("explode", position);
  else
    position = self.origin;

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.35, position, 800);
  _id_99AFF74B8EA85298 = scripts\common\utility::playersinsphere(position, 300);

  foreach(player in _id_99AFF74B8EA85298) {
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}

engineerdrone_earthquake(_id_7BB0EAC0599AA23D) {
  self notify("pulseGrenade_earthQuake");
  self endon("pulseGrenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(_id_7BB0EAC0599AA23D) || _id_7BB0EAC0599AA23D)
    self waittill("explode", position);
  else
    position = self.origin;

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.35, position, 800);
  _id_99AFF74B8EA85298 = scripts\common\utility::playersinsphere(position, 300);

  foreach(player in _id_99AFF74B8EA85298) {
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}

_screenshakeonposition(position, radius, _id_078CE85A35312119) {
  _id_762DF206B07E49DD = scripts\common\utility::playersinsphere(position, radius);

  foreach(player in _id_762DF206B07E49DD) {
    if(isDefined(_id_078CE85A35312119)) {
      if(isarray(_id_078CE85A35312119)) {
        if(scripts\engine\utility::array_contains(_id_078CE85A35312119, player))
          continue;
      } else if(player == _id_078CE85A35312119)
        continue;
    }

    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}