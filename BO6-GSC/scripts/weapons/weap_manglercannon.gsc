/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\weapons\weap_manglercannon.gsc
**************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\weapons\manglercannon_torpedo;
#namespace weap_manglercannon;

function private autoexec init() {
  killstreak_shared::registerkillstreakinitfunction(#"mangler_cannon", &function_d0c6e6de2a8060df);
}

function private function_d0c6e6de2a8060df() {
  weaponname = utility::function_d0cb6b33aff40a94(#"mangler_cannon");

  if(isDefined(weaponname)) {
    if(utility::issharedfuncdefined(#"killstreak", #"registerkillstreak")) {
      [[utility::getsharedfunc(#"killstreak", #"registerkillstreak")]]("mangler_cannon", &function_fc1e9bf63d0c2e66, &function_c55abc62514e7e04);
    }

    if(utility::issharedfuncdefined(#"killstreak", #"registerKillstreakStowableWeapon")) {
      [[utility::getsharedfunc(#"killstreak", #"registerKillstreakStowableWeapon")]]("mangler_cannon", weaponname);
    }

    if(!level callback::exists(#"player_weapon_change", &on_weapon_change)) {
      level callback::add(#"player_weapon_change", &on_weapon_change);
    }

    level thread register_on_kill_medal(weaponname);
  }
}

function private register_on_kill_medal(weaponname) {
  level utility::flag_wait("StartGameTypeCallbackFinished");

  if(utility::issharedfuncdefined(#"medal", #"register_on_kill_medal_callback", 0)) {
    if(isDefined(weaponname)) {
      utility::callsharedfunc(#"medal", #"register_on_kill_medal_callback", weaponname, &function_8a4be28d3ada0c69);
    }
  }
}

function function_c55abc62514e7e04(streakitem) {
  weapon_name = utility::function_d0cb6b33aff40a94(#"mangler_cannon");
  namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc("mangler_cannon", weapon_name, #"low");
}

function function_fc1e9bf63d0c2e66(streakitem) {
  level thread namespace_9d8e359c3b1041e5::trysaylocalsoundsharedfunc(self, #"bc_killstreak_action_mangler_cannon", 0.5);
  self.streakinfo = streakitem;
}

function on_weapon_change(params) {
  if(!(isDefined(params.weapon) && isDefined(level.var_363840efc0e8a5a0))) {
    return;
  }

  ismanglercannon = is_mangler_cannon(params.weapon);

  if(ismanglercannon) {
    self.isinads = 0;
    self notifyonplayercommand("charge_pressed", "+attack");
    self notifyonplayercommand("charge_released", "-attack");
    thread monitor_manglercannon_charge_pressed();
    thread function_e6651bae2db21a1b(params.weapon);
    thread function_559e750d510a7475();

    if(self getscriptableparthasstate("ManglerCannonIdleVFX", "idle")) {
      self setscriptablepartstate("ManglerCannonIdleVFX", "idle");
    }

    self.var_81f16ec9d4d6a42c = 1;
    return;
  }

  if(self.var_81f16ec9d4d6a42c) {
    self notifyonplayercommandremove("charge_pressed", "+attack");
    self notifyonplayercommandremove("charge_released", "-attack");
    self notify("monitor_manglercannon_fire_end");
    self notify("monitor_player_ads_end");
    self notify("monitor_manglercannon_charge_pressed_end");

    if(self getscriptableparthasstate("ManglerCannonIdleVFX", "off")) {
      self setscriptablepartstate("ManglerCannonIdleVFX", "off");
    }

    self.var_81f16ec9d4d6a42c = 0;
    self setclientomnvar("ui_m_c_target_num", -1);

    if(utility::issharedfuncdefined(#"killstreak", #"recordkillstreakendstats")) {
      streakinfo = self.streakinfo;
      self[[utility::getsharedfunc(#"killstreak", #"recordkillstreakendstats")]](streakinfo);
      self.streakinfo = undefined;
    }
  }
}

function private function_559e750d510a7475() {
  self endon("death_or_disconnect");
  self notify("monitor_player_ads_end");
  self endon("monitor_player_ads_end");

  while(true) {
    if(self playerads() < 0.4) {
      self.isinads = 0;
      self.torpedo_target = undefined;
      self setclientomnvar("ui_m_c_target_num", -1);
    }

    if(self playerads() > 0.9) {
      if(!self.isinads) {
        adsstarttime = gettime();
      }

      self.isinads = 1;

      if(isDefined(adsstarttime) && gettime() - adsstarttime > 750) {
        possible_target = function_a65b8b5afb6cbe2a();

        if(isDefined(possible_target)) {
          self.torpedo_target = possible_target;
          self setclientomnvar("ui_m_c_target_num", self.torpedo_target getentitynumber());
        }

        wait 1;
      }
    }

    waitframe();
  }
}

function private monitor_manglercannon_charge_pressed() {
  self endon("death_or_disconnect");
  self notify("monitor_manglercannon_charge_pressed_end");
  self endon("monitor_manglercannon_charge_pressed_end");

  while(true) {
    self waittill("charge_pressed");

    if(self.disallow_weapon_fire || self getcurrentweaponclipammo() == 0) {
      continue;
    }
  }
}

function private function_e6651bae2db21a1b(weapon) {
  self endon("death_or_disconnect");
  self notify("monitor_manglercannon_fire_end");
  self endon("monitor_manglercannon_fire_end");

  while(true) {
    self waittill("weapon_fired");

    if(self.disallow_weapon_fire) {
      continue;
    }

    angles = isPlayer(self) ? self getplayerangles() : self.angles;
    forward = anglesToForward(angles);

    if(isDefined(self.torpedo_target)) {
      target_pos = self.torpedo_target.origin;
    } else if(self getcamerathirdperson()) {
      start = self getcamerathirdpersonorigin();
      target_pos = start + 1500 * forward;
      trace = trace::ray_trace(start, target_pos, [self], undefined, 1, 1);

      if(trace["fraction"] < 0.99 && isDefined(trace["position"])) {
        if(trace["hittype"] == "hittype_world" && trace["surfacetype"] != "surftype_water") {
          target_pos = trace["position"];
        }
      }
    } else {
      target_pos = get_target_pos(1500);
    }

    if(isDefined(self.var_f5656ffa22c34a22)) {
      [torpedo_pos, launch_direction] = self[[self.var_f5656ffa22c34a22]](target_pos);
    } else if(self tagexists("tag_accessory_left")) {
      torpedo_pos = self gettagorigin("tag_accessory_left");

      if(self getcamerathirdperson()) {
        launch_direction = vectorNormalize(target_pos - torpedo_pos);

        if(vectordot(forward, launch_direction) < 0.7071) {
          launch_direction = forward;
        }
      } else {
        launch_direction = forward;
      }
    } else {
      torpedo_pos = self getEye();
      launch_direction = forward;
    }

    target = self.torpedo_target;
    detonationdist = 24;
    velocity = 700;
    moveintervaltime = 0.1;
    maxrange = 1500;
    var_f4b133aee924c98a = 20;
    torpedoradius = 60;
    blastradius = 100;
    var_57282cdbede88a80 = weapon getmindamage(0);
    var_8508644c715881bb = weapon getmaxdamage(0);
    var_563b2433865c9509 = 200;
    var_5618163386362e87 = 500;
    var_19c5437e89b71a4f = var_8508644c715881bb;
    stun_elites = 1;
    var_deed69668835b4ea = 1;
    var_77f0ce30fc0a0636 = 1;
    manglercannon_torpedo::mangler_cannon_shoot_torpedo(torpedo_pos, launch_direction, target, target_pos, detonationdist, velocity, moveintervaltime, maxrange, var_f4b133aee924c98a, torpedoradius, blastradius, var_57282cdbede88a80, var_8508644c715881bb, var_563b2433865c9509, var_5618163386362e87, var_19c5437e89b71a4f, stun_elites, var_deed69668835b4ea, var_77f0ce30fc0a0636, weapon.basename, "tag_origin_mangler_cannon_torpedo");
  }
}

function private function_a65b8b5afb6cbe2a() {
  angles = isPlayer(self) ? self getplayerangles() : self.angles;
  forward = anglesToForward(angles);
  start = self getcamerathirdperson() ? self getcamerathirdpersonorigin() : self getEye();
  end = start + 1500 * forward;
  trace_results = trace::ray_trace_get_all_results(start, end, [self], undefined, 1);

  foreach(trace_result in trace_results) {
    if(trace_result["hittype"] == "hittype_entity") {
      entity = trace_result["entity"];

      if(isai(entity) && isDefined(entity.team) && entity.team != self.team) {
        return entity;
      }
    }

    if(trace_result["hittype"] == "hittype_world" && trace_result["surfacetype"] != "surftype_water") {
      return undefined;
    }
  }

  return undefined;
}

function private get_target_pos(maxrange) {
  start = self getEye();
  dir = anglesToForward(self getplayerangles());
  end = start + maxrange * dir;
  return end;
}

function is_mangler_cannon(weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }

  mangler_cannon_name = utility::function_d0cb6b33aff40a94(#"mangler_cannon");
  mutant_injection_name = utility::function_d0cb6b33aff40a94(#"mutant_injection_cannon");
  ismanglercannon = weapon.basename == mangler_cannon_name || weapon.basename == mutant_injection_name;
  return ismanglercannon;
}

function private function_8a4be28d3ada0c69(victim, einflictor, smeansofdeath, sweapon) {
  if(utility::issharedfuncdefined(#"medal", #"track_rapid_kill", 0)) {
    utility::callsharedfunc(#"medal", #"track_rapid_kill", "mangler_cannon", sweapon);
  }

  if(isDefined(einflictor)) {
    if(!isDefined(einflictor.torpedo_kills)) {
      einflictor.torpedo_kills = 0;
    }

    einflictor.torpedo_kills++;

    if(isDefined(self.streakinfo)) {
      if(!isDefined(self.streakinfo.kills)) {
        self.streakinfo.kills = int(0);
      }

      self.streakinfo.kills++;
    }

    if(einflictor.torpedo_kills == 10) {
      namespace_9d8e359c3b1041e5::doscoreeventsharedfunc(#"medal_broadside");
    }

    if(utility::issharedfuncdefined(#"medal", #"track_scorestreak_kill", 0)) {
      utility::callsharedfunc(#"medal", #"track_scorestreak_kill", "mangler_cannon", victim);
    }
  }
}