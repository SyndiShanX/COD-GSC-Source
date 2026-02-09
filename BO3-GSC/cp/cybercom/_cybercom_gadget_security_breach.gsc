/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_security_breach.gsc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace cybercom_gadget_security_breach;

function init() {
  clientfield::register("toplayer", "hijack_vehicle_transition", 1, 2, "int");
  clientfield::register("toplayer", "hijack_static_effect", 1, 7, "float");
  clientfield::register("toplayer", "sndInDrivableVehicle", 1, 1, "int");
  clientfield::register("vehicle", "vehicle_hijacked", 1, 1, "int");
  clientfield::register("toplayer", "hijack_spectate", 1, 1, "int");
  clientfield::register("toplayer", "hijack_static_ramp_up", 1, 1, "int");
  clientfield::register("toplayer", "vehicle_hijacked", 1, 1, "int");
  visionset_mgr::register_info("visionset", "hijack_vehicle", 1, 5, 1, 1);
  visionset_mgr::register_info("visionset", "hijack_vehicle_blur", 1, 6, 1, 1);
  callback::on_spawned(&on_player_spawned);
}

function main() {
  cybercom_gadget::registerability(0, 32);
  level.cybercom.security_breach = spawnStruct();
  level.cybercom.security_breach._is_flickering = &_is_flickering;
  level.cybercom.security_breach._on_flicker = &_on_flicker;
  level.cybercom.security_breach._on_give = &_on_give;
  level.cybercom.security_breach._on_take = &_on_take;
  level.cybercom.security_breach._on_connect = &_on_connect;
  level.cybercom.security_breach._on = &_on;
  level.cybercom.security_breach._off = &_off;
  level.cybercom.security_breach._is_primed = &_is_primed;
}

function on_player_spawned() {
  self clientfield::set_to_player("hijack_static_effect", 0);
  self clientfield::set_to_player("hijack_spectate", 0);
  self clientfield::set_to_player("hijack_static_ramp_up", 0);
  self util::freeze_player_controls(0);
  self cameraactivate(0);
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = 1;
  self.cybercom.security_breach_lifetime = getdvarint("scr_security_breach_lifetime", 30);
  if(self hascybercomability("cybercom_securitybreach") == 2) {
    self.cybercom.security_breach_lifetime = getdvarint("scr_security_breach_upgraded_lifetime", 60);
  }
  self.cybercom.targetlockcb = &_get_valid_targets;
  self.cybercom.targetlockrequirementcb = &_lock_requirement;
  self.cybercom.var_73d069a7 = &function_17342509;
  self.cybercom.var_46483c8f = 63;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
  self.cybercom.var_46483c8f = undefined;
  self.cybercom.var_73d069a7 = undefined;
}

function _on_connect() {}

function function_17342509(slot, weapon) {
  self gadgetactivate(slot, weapon);
  _on(slot, weapon);
}

function _on(slot, weapon) {
  self thread _activate_security_breach(slot, weapon);
  self _off(slot, weapon);
}

function _off(slot, weapon) {
  self thread cybercom::weaponendlockwatcher(weapon);
  self.cybercom.is_primed = undefined;
  self notify("hash_8216024");
}

function _is_primed(slot, weapon) {
  if(!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed)) {
    assert(self.cybercom.activecybercomweapon == weapon);
    self notify("hash_50db7e6");
    self thread cybercom::weaponlockwatcher(slot, weapon, self.cybercom.var_110c156a);
    self.cybercom.is_primed = 1;
    self playsoundtoplayer("gdt_securitybreach_target", self);
  }
}

function private _lock_requirement(target) {
  if(target cybercom::cybercom_aicheckoptout("cybercom_hijack")) {
    if(isDefined(target.rogue_controlled) && target.rogue_controlled) {
      self cybercom::function_29bf9dee(target, 4);
    } else {
      self cybercom::function_29bf9dee(target, 2);
    }
    return false;
  }
  if(isDefined(target.lockon_owner) && target.lockon_owner != self) {
    self cybercom::function_29bf9dee(target, 7);
    return false;
  }
  if(isDefined(target.hijacked) && target.hijacked) {
    self cybercom::function_29bf9dee(target, 4);
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  if(isDefined(target.var_d3f57f67) && target.var_d3f57f67) {
    return false;
  }
  if(!isvehicle(target)) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  return true;
}

function private _get_valid_targets(weapon) {
  enemy = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
  ally = getaiteamarray("allies");
  return arraycombine(enemy, ally, 0, 0);
}

function private _activate_security_breach(slot, weapon) {
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        self thread challenges::function_96ed590f("cybercom_uses_control");
        item.target thread _security_breach(self, weapon);
        fired++;
        continue;
      }
      if(item.inrange == 2) {
        aborted++;
      }
    }
  }
  if(aborted && !fired) {
    self.cybercom.lock_targets = [];
    self cybercom::function_29bf9dee(undefined, 1, 0);
  }
  if(!aborted && fired) {
    upgraded = weapon.name == "gadget_remote_hijack_upgraded";
    self playSound("gdt_cybercore_activate" + (isDefined(upgraded) && (upgraded ? "_upgraded" : "")));
  }
  cybercom::function_adc40f11(weapon, fired);
  if(fired && isPlayer(self)) {
    itemindex = getitemindexfromref("cybercom_hijack");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function private _security_breach_ramp_visionset(player, setname, delay, direction, duration) {
  wait(delay);
  if(direction > 0) {
    visionset_mgr::activate("visionset", setname, player, duration, 0, 0);
    visionset_mgr::deactivate("visionset", setname, player);
  } else {
    visionset_mgr::activate("visionset", setname, player, 0, 0, duration);
    visionset_mgr::deactivate("visionset", setname, player);
  }
}

function private function_637db461(player, weapon) {
  if(isDefined(self.hijacked) && self.hijacked) {
    player cybercom::function_29bf9dee(self, 4);
    return false;
  }
  if(isDefined(self.is_disabled) && self.is_disabled) {
    player cybercom::function_29bf9dee(self, 6);
    return false;
  }
  return false;
}

function private _security_breach(player, weapon) {
  wait(getdvarfloat("scr_security_breach_activate_delay", 0.5));
  if(!isDefined(self)) {
    return;
  }
  if(!isvehicle(self)) {
    return;
  }
  if(player laststand::player_is_in_laststand()) {
    return;
  }
  if(isDefined(player.cybercom.emergency_reserve) && player.cybercom.emergency_reserve) {
    return;
  }
  if(isDefined(self.playerdrivenversion)) {
    self setvehicletype(self.playerdrivenversion);
  }
  vehentnum = self getentitynumber();
  self notify("hash_f8c5dd60", weapon, player);
  self notify("cloneandremoveentity", vehentnum);
  level notify("cloneandremoveentity", vehentnum);
  player gadgetpowerset(0, 0);
  player gadgetpowerset(1, 0);
  player gadgetpowerset(2, 0);
  player cybercom::disablecybercom(1);
  if(isai(self) && self.archetype == "quadtank") {
    player notify("give_achievement", "CP_CONTROL_QUAD");
  }
  player notify("security_breach", self);
  waittillframeend();
  self notsolid();
  var_66ff806d = self.var_66ff806d;
  clone = cloneandremoveentity(self);
  if(!isDefined(clone)) {
    return;
  }
  clone solid();
  level notify("clonedentity", clone, vehentnum);
  player notify("clonedentity", clone, vehentnum);
  clone.takedamage = 0;
  clone.hijacked = 1;
  clone.var_a076880e = undefined;
  clone.is_disabled = 1;
  clone.owner = player;
  clone.var_66ff806d = var_66ff806d;
  clone setteam(player.team);
  clone.health = clone.healthdefault;
  clone.var_fb7ce72a = &function_637db461;
  if(isDefined(self.var_72f54197)) {
    clone.var_72f54197 = self.var_72f54197;
  }
  if(isDefined(self.var_b0ac175a)) {
    clone.var_b0ac175a = self.var_b0ac175a;
  }
  playerstate = spawnStruct();
  player function_dc86efaa(playerstate, "begin");
  if(!isDefined(clone)) {
    player disableinvulnerability();
    player cybercom::enablecybercom();
    return;
  }
  player.hijacked_vehicle_entity = clone;
  player function_dc86efaa(playerstate, "cloak");
  clone thread _invulnerableforatime(getdvarint("scr_security_breach_no_damage_time", 8), player);
  if(isDefined(clone.vehicletype) && clone.vehicletype != "turret_sentry") {
    clone thread _anchor_to_location(player, player.origin);
  }
  clone.blocktween = 1;
  clone makevehicleusable();
  clone usevehicle(player, 0);
  clone makevehicleunusable();
  player function_dc86efaa(playerstate, "cloak_wait");
  clone clientfield::set("vehicle_hijacked", 1);
  clone.blocktween = undefined;
  clone makevehicleusable();
  clone thread _wait_for_return(player);
  player function_dc86efaa(playerstate, "return_wait");
  visionset_mgr::deactivate("visionset", "hijack_vehicle_blur", player);
  player function_dc86efaa(playerstate, "finish");
}

function function_dc86efaa(var_b6c35df6, str_state) {
  assert(isPlayer(self));
  player = self;
  switch (str_state) {
    case "begin": {
      player setcontrolleruimodelvalue("vehicle.outOfRange", 0);
      player enableinvulnerability();
      player cybercom::disablecybercom(1);
      wait(0.1);
      return;
    }
    case "cloak": {
      var_b6c35df6.oldstance = player getstance();
      var_b6c35df6.oldignoreme = player.ignoreme;
      var_b6c35df6.var_d40d5a7d = player.b_tactical_mode_enabled;
      player.b_tactical_mode_enabled = 0;
      player.ignoreme = 1;
      player setclientuivisibilityflag("weapon_hud_visible", 0);
      player setstance("crouch");
      player clientfield::set("camo_shader", 2);
      player thread _start_transition(2);
      player thread _security_breach_ramp_visionset(player, "hijack_vehicle", 0.1, 1, 0.1);
      player waittill("transition_in_do_switch");
      player setlowready(1);
      visionset_mgr::activate("visionset", "hijack_vehicle_blur", player);
      player hide();
      player notsolid();
      player setplayercollision(0);
      player clientfield::set("camo_shader", 1);
      player clientfield::set_to_player("sndInDrivableVehicle", 1);
      player player::take_weapons();
      return;
    }
    case "cloak_wait": {
      player waittill("transition_done");
      player clientfield::set_to_player("vehicle_hijacked", 1);
      return "return_wait";
    }
    case "return_wait": {
      player waittill("return_to_body");
      player player::give_back_weapons(1);
      player seteverhadweaponall(1);
      player thread _security_breach_ramp_visionset(player, "hijack_vehicle", 0, -1, 0.1);
      return;
    }
    case "finish": {
      player show();
      player solid();
      player setplayercollision(1);
      player setstance(var_b6c35df6.oldstance);
      player setlowready(0);
      player.b_tactical_mode_enabled = var_b6c35df6.var_d40d5a7d;
      player waittill("transition_done");
      player seteverhadweaponall(0);
      player clientfield::set_to_player("vehicle_hijacked", 0);
      player clientfield::set_to_player("sndInDrivableVehicle", 0);
      player.hijacked_vehicle_entity = undefined;
      player disableinvulnerability();
      player.ignoreme = 0;
      player setclientuivisibilityflag("weapon_hud_visible", 1);
      player cybercom::enablecybercom();
      wait(1);
      player clientfield::set("camo_shader", 0);
      player notify("stop_camo_sound");
      return;
    }
  }
}

function _start_transition(direction) {
  self endon("death");
  self notify("_start_transition");
  self endon("_start_transition");
  self clientfield::set_to_player("hijack_vehicle_transition", direction);
  util::wait_network_frame();
  self notify("transition_in_do_switch");
  wait(0.2);
  wait(0.2);
  self notify("transition_done");
  self clientfield::set_to_player("hijack_vehicle_transition", 1);
}

function setanchorvolume(ent) {
  clearanchorvolume();
  if(isDefined(ent) && isPlayer(self)) {
    self.cybercom.secbreachanchorent = ent;
    if(isDefined(ent.script_parameters)) {
      data = strtok(ent.script_parameters, " ");
      assert(data.size == 2);
      self.cybercom.secbreachanchorminsq = int(data[0]) * int(data[0]);
      self.cybercom.secbreachanchormaxsq = int(data[1]) * int(data[1]);
    }
  }
}

function clearanchorvolume() {
  self.cybercom.secbreachanchorent = undefined;
  self.cybercom.secbreachanchorminsq = undefined;
  self.cybercom.secbreachanchormaxsq = undefined;
}

function private _anchor_to_location(player, anchor) {
  self endon("death");
  player endon("return_to_body");
  player endon("kill_static_achor");
  player endon("disconnect");
  player waittill("transition_done");
  wait(0.1);
  maxstatic = 0.95;
  lastoutofrangewarningvalue = undefined;
  while(true) {
    distcheck = 1;
    losecontactdistsq = getdvarint("scr_security_breach_lose_contact_distanceSQ", getdvarint("scr_security_breach_lose_contact_distance", 1200) * getdvarint("scr_security_breach_lose_contact_distance", 1200));
    lostcontactdistsq = getdvarint("scr_security_breach_lost_contact_distanceSQ", getdvarint("scr_security_breach_lost_contact_distance", 2400) * getdvarint("scr_security_breach_lost_contact_distance", 2400));
    if(isDefined(player.cybercom.secbreachanchorent)) {
      if(isDefined(player.cybercom.secbreachanchorminsq)) {
        losecontactdistsq = player.cybercom.secbreachanchorminsq;
        lostcontactdistsq = player.cybercom.secbreachanchormaxsq;
      }
      if(self istouching(player.cybercom.secbreachanchorent)) {
        val = 0;
        distancesq = 0;
        distcheck = 0;
      }
    }
    if(self.archetype === "turret") {
      val = 0;
      distancesq = 0;
      distcheck = 0;
    }
    if(distcheck) {
      distancesq = distancesquared(self.origin, anchor);
      if(distancesq < losecontactdistsq) {
        val = 0;
      } else {
        if(distancesq >= lostcontactdistsq) {
          val = maxstatic;
        } else {
          range = lostcontactdistsq - losecontactdistsq;
          val = math::clamp((distancesq - losecontactdistsq) / range, 0, maxstatic);
        }
      }
      outofrangewarningvalue = distancesq >= (getdvarfloat("scr_security_breach_lost_contact_warning_distance_percent", 0.6) * lostcontactdistsq);
      if(outofrangewarningvalue !== lastoutofrangewarningvalue) {
        player setcontrolleruimodelvalue("vehicle.outOfRange", outofrangewarningvalue);
        lastoutofrangewarningvalue = outofrangewarningvalue;
      }
    }
    player clientfield::set_to_player("hijack_static_effect", val);
    if(distancesq > lostcontactdistsq) {
      self setteam("axis");
      self.takedamage = 1;
      self.owner = undefined;
      self.skipfriendlyfirecheck = 1;
      if(isDefined(player)) {
        self kill(self.origin, player);
      } else {
        self kill();
      }
    }
    wait(0.05);
  }
}

function private _invulnerableforatime(time, player) {
  self endon("death");
  self.takedamage = 0;
  player util::waittill_any_timeout(time, "return_to_body");
  self.takedamage = !isgodmode(player);
}

function private _playerspectate(vehicle) {
  self endon("spawned");
  self util::freeze_player_controls(1);
  self clientfield::set_to_player("hijack_static_ramp_up", 1);
  if(isDefined(vehicle.archetype) && vehicle.archetype == "wasp" && (!(isDefined(vehicle.var_66ff806d) && vehicle.var_66ff806d))) {
    self thread _playerspectatechase(vehicle);
  } else {
    self clientfield::set_to_player("hijack_spectate", 1);
  }
  self cameraactivate(1);
  self waittill("transition_in_do_switch");
  self clientfield::set_to_player("hijack_static_ramp_up", 0);
  self cameraactivate(0);
  self clientfield::set_to_player("hijack_spectate", 0);
  self clientfield::set_to_player("hijack_static_effect", 0);
  self util::freeze_player_controls(0);
}

function private _playerspectatechase(vehicle) {
  forward = anglesToForward(vehicle.angles);
  moveamount = vectorscale(forward, -200);
  moveamount = (moveamount[0], moveamount[1], vehicle.origin[2] + 72);
  cam = spawn("script_model", vehicle.origin + moveamount);
  cam setModel("tag_origin");
  if(!(isDefined(vehicle.crash_style) && vehicle.crash_style)) {
    cam linkto(vehicle, "tag_origin");
  }
  self startcameratween(1);
  origin = vehicle.origin;
  wait(0.05);
  self camerasetposition(cam);
  if(isDefined(vehicle)) {
    self camerasetlookat(vehicle);
  } else {
    self camerasetlookat(origin + vectorscale((0, 0, 1), 50));
  }
  self util::waittill_any("transition_in_do_switch", "spawned", "disconnect", "death", "return_to_body");
  cam delete();
}

function private _wait_for_death(player) {
  player endon("return_to_body");
  self waittill("death");
  player thread _playerspectate(self);
  wait(3);
  player notify("kill_static_achor");
  player thread _start_transition(3);
  player waittill("transition_in_do_switch");
  waittillframeend();
  player unlink();
  player notify("return_to_body", 1);
}

function private _wait_for_player_exit(player) {
  self endon("death");
  player endon("return_to_body");
  self util::waittill_any("unlink", "exit_vehicle");
  if(game["state"] == "postgame" || (isDefined(level.gameended) && level.gameended)) {
    return;
  }
  self setteam("axis");
  self.takedamage = 1;
  self.owner = undefined;
  if(isDefined(player)) {
    self kill(self.origin, player, player, getweapon("gadget_remote_hijack"));
  } else {
    self kill();
  }
}

function private _wait_for_return(player) {
  self thread _wait_for_death(player);
  self thread _wait_for_player_exit(player);
  original_location = player.origin;
  original_angles = player.angles;
  player.cybercom.tacrigs_disabled = 1;
  self.vehdontejectoccupantsondeath = 1;
  player waittill("return_to_body", reason);
  wait(0.05);
  player setorigin(original_location);
  player setplayerangles(original_angles);
  wait(0.05);
  if(isDefined(self)) {
    self setteam("axis");
    self.takedamage = 1;
    self.owner = undefined;
    if(isDefined(player)) {
      self kill(self.origin, player);
    } else {
      self kill();
    }
  }
  player.cybercom.tacrigs_disabled = undefined;
}

function clearusingremote() {
  self enableoffhandweapons();
  if(isDefined(self.lastweapon)) {
    self switchtoweapon(self.lastweapon);
    wait(1);
  }
  self takeweapon(self.remoteweapon);
}

function setusingremote(remotename) {
  self.lastweapon = self getcurrentweapon();
  self.remoteweapon = getweapon(remotename);
  self giveweapon(self.remoteweapon);
  self switchtoweapon(self.remoteweapon);
  self disableoffhandweapons();
}

function function_43b801ea(onoff, entnum) {
  while(true) {
    level waittill("clonedentity", clone, vehentnum);
    if(vehentnum == entnum) {
      clone.var_66ff806d = onoff;
      return;
    }
  }
}

function function_f002d0f9() {
  self endon("death");
  self waittill("cloneandremoveentity", var_3c0fc0de);
  level thread function_43b801ea(0, var_3c0fc0de);
}

function function_664c9cd6() {
  self setteam("axis");
  self.takedamage = 1;
  self.owner = undefined;
  self dodamage(self.health, self.origin);
}