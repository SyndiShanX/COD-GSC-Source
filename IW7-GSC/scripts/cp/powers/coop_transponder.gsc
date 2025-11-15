/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_transponder.gsc
**************************************************/

init() {
  level._effect["transponder_activate"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_activate.vfx");
  level._effect["direction_indicator_close"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_close.vfx");
  level._effect["direction_indicator_mid"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_mid.vfx");
  level._effect["direction_indicator_far"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_far.vfx");
}

removetransponder() {
  self notify("remove_transponder");
}

transponder_place(param_00) {
  if(checkvalidplacementstate(param_00)) {
    transponder_throw(param_00);
    return;
  }

  thread placementfailed(param_00);
}

transponder_use(param_00) {
  scripts\cp\powers\coop_powers::activatepower("power_transponder");
  transponder_place(param_00);
}

transponder_throw(param_00) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("remove_transponder");
  var_01 = "power_transponder";
  if(!scripts\cp\utility::isreallyalive(self)) {
    param_00 delete();
    return;
  }

  param_00 thread scripts\cp\cp_weapon::ondetonateexplosive("powers_transponder_used");
  param_00 thread waitfordetonateexplosive(self);
  thread watchtransponderdetonation(param_00);
  param_00 setotherent(self);
  param_00.activated = 0;
  param_00.script_noteworthy = "placed_transponder";
  ontacticalequipmentplanted(param_00);
  param_00 thread watchforpowerremoved(self);
  param_00 thread transponderactivate();
  level thread scripts\cp\cp_weapon::monitordisownedequipment(self, param_00);
}

waitfordetonateexplosive(param_00) {
  self endon("alt_detonate");
  self endon("detonated");
  self waittill("detonateExplosive");
  param_00 transponderdetonateallcharges();
}

watchforpowerremoved(param_00) {
  param_00 endon("clear_previous_tombstone");
  param_00 endon("lost_and_found_time_out");
  param_00 endon("disconnect");
  self endon("alt_detonate");
  self endon("detonated");
  param_00 waittill("detonate_transponder");
  self notify("detonate");
  param_00 transponderdetonateallcharges();
}

ontacticalequipmentplanted(param_00) {
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
    if(self.plantedtacticalequip.size >= level.maxperplayerexplosives) {
      self.plantedtacticalequip[0] notify("detonateExplosive");
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = param_00;
  var_01 = param_00 getentitynumber();
  level.mines[var_01] = param_00;
  level notify("mine_planted");
}

watchtransponderdetonation(param_00) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("alt_detonate");
  self endon("detonated");
  param_00 waittill("activated");
  for(;;) {
    self waittillmatch("ztransponder_mp", "detonate");
    if(scripts\cp\utility::isteleportenabled()) {
      if(isDefined(param_00) && param_00.activated) {
        transponder_teleportplayer(param_00);
        transponderdetonateallcharges();
      }

      continue;
    }

    continue;
  }
}

killenemiesinfov() {
  var_00 = cos(75);
  var_01 = 2000;
  var_02 = 300;
  var_03 = var_02 / 2;
  var_04 = vectornormalize(anglesToForward(self.angles));
  var_05 = var_04 * var_03;
  var_06 = self.origin + var_05;
  physicsexplosionsphere(var_06, var_03, 1, 2.5);
  var_07 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_08 = scripts\engine\utility::get_array_of_closest(self.origin, var_07, undefined, var_02);
  foreach(var_0A in var_08) {
    var_0B = 0;
    var_0C = var_0A.origin;
    var_0D = scripts\engine\utility::within_fov(self getEye(), self.angles, var_0C + (0, 0, 30), var_00);
    if(var_0D) {
      var_0E = distance2d(self.origin, var_0C);
      if(var_0E < var_02) {
        var_0B = 1;
      }
    }

    if(var_0B) {
      var_04 = anglesToForward(self.angles);
      var_0F = vectornormalize(var_04) * -100;
      var_0A setvelocity(vectornormalize(var_0A.origin - self.origin + var_0F) * 800 + (0, 0, 300));
      var_01 = var_0A.maxhealth;
      var_0A killtranspondervictim(self, var_01, var_0C, self.origin);
    }
  }
}

killtranspondervictim(param_00, param_01, param_02, param_03) {
  self.do_immediate_ragdoll = 1;
  if(param_01 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(param_01, param_02, param_00, param_00, "MOD_IMPACT", "ztransponder_mp");
}

transponderdamage() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  var_00 waittill("transponder_update");
}

transponderdetonateallcharges() {
  foreach(var_01 in self.plantedtacticalequip) {
    if(isDefined(var_01)) {
      if(isDefined(var_01.weapon_name) && var_01.weapon_name == "ztransponder_mp") {
        var_01 scripts\cp\cp_weapon::deleteexplosive(0);
        scripts\engine\utility::array_remove(self.plantedtacticalequip, var_01);
      }
    }
  }

  scripts\cp\powers\coop_powers::deactivatepower("power_transponder");
  self notify("transponder_update", 0);
  waittillframeend;
  self notify("detonated");
  self notify("alt_detonate");
}

watchtransponderaltdetonation(param_00) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("detonated");
  param_00 waittill("activated");
  for(;;) {
    self waittill("alt_detonate");
    var_01 = self getcurrentweapon();
    if(var_01 != "ztransponder_mp") {
      if(isDefined(param_00) && param_00.activated) {
        transponder_teleportplayer(param_00);
        transponderdetonateallcharges();
        continue;
      }

      continue;
    }
  }
}

watchtransponderaltdetonate(param_00) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  param_00 waittill("activated");
  var_01 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_01 = 0;
      while(self usebuttonpressed()) {
        var_01 = var_01 + 0.05;
        wait(0.05);
      }

      if(var_01 >= 0.5) {
        continue;
      }

      var_01 = 0;
      while(!self usebuttonpressed() && var_01 < 0.5) {
        var_01 = var_01 + 0.05;
        wait(0.05);
      }

      if(var_01 >= 0.5) {
        continue;
      }

      if(!self.plantedtacticalequip.size) {
        return;
      }

      if(self ismantling()) {
        self cancelmantle();
      }

      self notify("alt_detonate");
    }

    wait(0.05);
  }
}

transponderactivate() {
  self.triggerportableradarping thread timeouttransponder(self);
  var_00 = self.triggerportableradarping;
  var_01 = undefined;
  var_02 = undefined;
  self waittill("missile_stuck", var_03);
  if(isDefined(self.weapon_name)) {
    var_01 = self.weapon_name;
  }

  if(isDefined(self.origin)) {
    var_02 = self.origin;
  }

  wait(0.05);
  if(!checkvalidposition(var_00, var_03)) {
    var_00 placementfailed(self, var_02, var_01);
    return;
  }

  self.triggerportableradarping notify("powers_transponder_used", 1);
  self notify("activated");
  self.activated = 1;
  scripts\cp\cp_weapon::explosivehandlemovers(var_03);
}

timeouttransponder(param_00) {
  param_00 endon("missile_stuck");
  param_00 scripts\engine\utility::waittill_any_timeout_1(5, "death");
  self notify("powers_transponder_used", 0);
  placementfailed(param_00);
}

transponder_teleportplayer(param_00) {
  var_01 = undefined;
  var_02 = getclosestpointonnavmesh(param_00.origin);
  self notify("left_hidden_room_early");
  if(isDefined(var_02)) {
    thread activationeffects(self.origin, param_00.origin);
    self playlocalsound("ghost_use_transponder");
    self setorigin(var_02 + (0, 0, 20));
    return;
  }

  iprintlnbold("Transponder lost connection");
  self.triggerportableradarping transponderdetonateallcharges();
}

activationeffects(param_00, param_01) {
  var_02 = spawnfx(scripts\engine\utility::getfx("transponder_activate"), param_01);
  wait(0.1);
  triggerfx(var_02);
  var_02 thread scripts\cp\utility::delayentdelete(0.75);
  var_03 = "direction_indicator_far";
  var_04 = length2d(param_00 - param_01);
  if(var_04 < 1024) {
    var_03 = "direction_indicator_close";
  } else if(var_04 < 2048) {
    var_03 = "direction_indicator_mid";
  }

  playFX(scripts\engine\utility::getfx(var_03), param_00, (0, 0, 1), anglesToForward(vectortoangles(param_01 - param_00)));
}

runtranspondersickness() {
  self shellshock("flashbang_mp", 1.2);
  wait(1.2);
}

transponderrangefinder(param_00) {
  param_00 endon("death");
  self endon("disconnect");
  thread transponderwatchfordisuse(param_00);
  while(isDefined(param_00)) {
    var_01 = distance2d(self.origin, param_00.origin);
    wait(0.1);
  }
}

transponderwatchfordisuse(param_00) {
  param_00 waittill("deleted_equipment");
}

checkvalidposition(param_00, param_01) {
  if(!isDefined(self)) {
    return 0;
  }

  var_02 = param_00 findpath(param_00.origin, self.origin);
  if(var_02.size < 1) {
    return 0;
  } else if(distance2d(var_02[var_02.size - 1], self.origin) >= 12) {
    return 0;
  }

  var_03 = getclosestpointonnavmesh(self.origin);
  if(!isDefined(var_03)) {
    return 0;
  }

  if(distance2d(self.origin, var_03) > 18) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](var_03)) {
      return 0;
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(self.origin, level.invalid_spawn_volume_array, param_00, undefined, 1, param_01)) {
    return 0;
  }

  if(isDefined(level.invalidtranspondervolumes)) {
    if(isDefined(level.is_in_box_func)) {
      foreach(var_05 in level.invalidtranspondervolumes) {
        if([
            [level.is_in_box_func]
          ](var_05[0], var_05[1], var_05[2], var_05[3], self.origin)) {
          return 0;
        }
      }
    }
  }

  if(positionwouldtelefrag(self.origin)) {
    return 0;
  }

  return 1;
}

checkvalidplacementstate(param_00) {
  return !self iswallrunning() && !self isonladder() && self isonground();
}

placementfailed(param_00, param_01, param_02) {
  self notify("powers_transponder_used", 0);
  self.activated = 0;
  transponderdetonateallcharges();
  self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
  var_03 = undefined;
  var_04 = undefined;
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  if(isDefined(param_02)) {
    var_04 = param_02;
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00.origin)) {
      var_03 = param_00.origin;
    }

    if(isDefined(param_00.weapon_name)) {
      var_04 = param_00.weapon_name;
    }
  }

  if(isDefined(var_03) && isDefined(var_04)) {
    scripts\cp\cp_weapon::placeequipmentfailed(var_04, 1, var_03);
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }
}