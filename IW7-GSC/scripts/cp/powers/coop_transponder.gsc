/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

transponder_place(var_0) {
  if(checkvalidplacementstate(var_0)) {
    transponder_throw(var_0);
    return;
  }

  thread placementfailed(var_0);
}

transponder_use(var_0) {
  scripts\cp\powers\coop_powers::activatepower("power_transponder");
  transponder_place(var_0);
}

transponder_throw(var_0) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("remove_transponder");
  var_1 = "power_transponder";
  if(!scripts\cp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  var_0 thread scripts\cp\cp_weapon::ondetonateexplosive("powers_transponder_used");
  var_0 thread waitfordetonateexplosive(self);
  thread watchtransponderdetonation(var_0);
  var_0 setotherent(self);
  var_0.activated = 0;
  var_0.script_noteworthy = "placed_transponder";
  ontacticalequipmentplanted(var_0);
  var_0 thread watchforpowerremoved(self);
  var_0 thread transponderactivate();
  level thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
}

waitfordetonateexplosive(var_0) {
  self endon("alt_detonate");
  self endon("detonated");
  self waittill("detonateExplosive");
  var_0 transponderdetonateallcharges();
}

watchforpowerremoved(var_0) {
  var_0 endon("clear_previous_tombstone");
  var_0 endon("lost_and_found_time_out");
  var_0 endon("disconnect");
  self endon("alt_detonate");
  self endon("detonated");
  var_0 waittill("detonate_transponder");
  self notify("detonate");
  var_0 transponderdetonateallcharges();
}

ontacticalequipmentplanted(var_0) {
  if(self.plantedtacticalequip.size) {
    self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
    if(self.plantedtacticalequip.size >= level.maxperplayerexplosives) {
      self.plantedtacticalequip[0] notify("detonateExplosive");
    }
  }

  self.plantedtacticalequip[self.plantedtacticalequip.size] = var_0;
  var_1 = var_0 getentitynumber();
  level.mines[var_1] = var_0;
  level notify("mine_planted");
}

watchtransponderdetonation(var_0) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("alt_detonate");
  self endon("detonated");
  var_0 waittill("activated");
  for(;;) {
    self waittillmatch("ztransponder_mp", "detonate");
    if(scripts\cp\utility::isteleportenabled()) {
      if(isDefined(var_0) && var_0.activated) {
        transponder_teleportplayer(var_0);
        transponderdetonateallcharges();
      }

      continue;
    }

    continue;
  }
}

killenemiesinfov() {
  var_0 = cos(75);
  var_1 = 2000;
  var_2 = 300;
  var_3 = var_2 / 2;
  var_4 = vectornormalize(anglesToForward(self.angles));
  var_5 = var_4 * var_3;
  var_6 = self.origin + var_5;
  physicsexplosionsphere(var_6, var_3, 1, 2.5);
  var_7 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7, undefined, var_2);
  foreach(var_10 in var_8) {
    var_11 = 0;
    var_12 = var_10.origin;
    var_13 = scripts\engine\utility::within_fov(self getEye(), self.angles, var_12 + (0, 0, 30), var_0);
    if(var_13) {
      var_14 = distance2d(self.origin, var_12);
      if(var_14 < var_2) {
        var_11 = 1;
      }
    }

    if(var_11) {
      var_4 = anglesToForward(self.angles);
      var_15 = vectornormalize(var_4) * -100;
      var_10 setvelocity(vectornormalize(var_10.origin - self.origin + var_15) * 800 + (0, 0, 300));
      var_1 = var_10.maxhealth;
      var_10 killtranspondervictim(self, var_1, var_12, self.origin);
    }
  }
}

killtranspondervictim(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;
  if(var_1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "ztransponder_mp");
}

transponderdamage() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 waittill("transponder_update");
}

transponderdetonateallcharges() {
  foreach(var_1 in self.plantedtacticalequip) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.weapon_name) && var_1.weapon_name == "ztransponder_mp") {
        var_1 scripts\cp\cp_weapon::deleteexplosive(0);
        scripts\engine\utility::array_remove(self.plantedtacticalequip, var_1);
      }
    }
  }

  scripts\cp\powers\coop_powers::deactivatepower("power_transponder");
  self notify("transponder_update", 0);
  waittillframeend;
  self notify("detonated");
  self notify("alt_detonate");
}

watchtransponderaltdetonation(var_0) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("detonated");
  var_0 waittill("activated");
  for(;;) {
    self waittill("alt_detonate");
    var_1 = self getcurrentweapon();
    if(var_1 != "ztransponder_mp") {
      if(isDefined(var_0) && var_0.activated) {
        transponder_teleportplayer(var_0);
        transponderdetonateallcharges();
        continue;
      }

      continue;
    }
  }
}

watchtransponderaltdetonate(var_0) {
  self endon("clear_previous_tombstone");
  self endon("lost_and_found_time_out");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_0 waittill("activated");
  var_1 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_1 = 0;
      while(self usebuttonpressed()) {
        var_1 = var_1 + 0.05;
        wait(0.05);
      }

      if(var_1 >= 0.5) {
        continue;
      }

      var_1 = 0;
      while(!self usebuttonpressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait(0.05);
      }

      if(var_1 >= 0.5) {
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
  self.owner thread timeouttransponder(self);
  var_0 = self.owner;
  var_1 = undefined;
  var_2 = undefined;
  self waittill("missile_stuck", var_3);
  if(isDefined(self.weapon_name)) {
    var_1 = self.weapon_name;
  }

  if(isDefined(self.origin)) {
    var_2 = self.origin;
  }

  wait(0.05);
  if(!checkvalidposition(var_0, var_3)) {
    var_0 placementfailed(self, var_2, var_1);
    return;
  }

  self.owner notify("powers_transponder_used", 1);
  self notify("activated");
  self.activated = 1;
  scripts\cp\cp_weapon::explosivehandlemovers(var_3);
}

timeouttransponder(var_0) {
  var_0 endon("missile_stuck");
  var_0 scripts\engine\utility::waittill_any_timeout(5, "death");
  self notify("powers_transponder_used", 0);
  placementfailed(var_0);
}

transponder_teleportplayer(var_0) {
  var_1 = undefined;
  var_2 = getclosestpointonnavmesh(var_0.origin);
  self notify("left_hidden_room_early");
  if(isDefined(var_2)) {
    thread activationeffects(self.origin, var_0.origin);
    self playlocalsound("ghost_use_transponder");
    self setorigin(var_2 + (0, 0, 20));
    return;
  }

  iprintlnbold("Transponder lost connection");
  self.owner transponderdetonateallcharges();
}

activationeffects(var_0, var_1) {
  var_2 = spawnfx(scripts\engine\utility::getfx("transponder_activate"), var_1);
  wait(0.1);
  triggerfx(var_2);
  var_2 thread scripts\cp\utility::delayentdelete(0.75);
  var_3 = "direction_indicator_far";
  var_4 = length2d(var_0 - var_1);
  if(var_4 < 1024) {
    var_3 = "direction_indicator_close";
  } else if(var_4 < 2048) {
    var_3 = "direction_indicator_mid";
  }

  playFX(scripts\engine\utility::getfx(var_3), var_0, (0, 0, 1), anglesToForward(vectortoangles(var_1 - var_0)));
}

runtranspondersickness() {
  self shellshock("flashbang_mp", 1.2);
  wait(1.2);
}

transponderrangefinder(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  thread transponderwatchfordisuse(var_0);
  while(isDefined(var_0)) {
    var_1 = distance2d(self.origin, var_0.origin);
    wait(0.1);
  }
}

transponderwatchfordisuse(var_0) {
  var_0 waittill("deleted_equipment");
}

checkvalidposition(var_0, var_1) {
  if(!isDefined(self)) {
    return 0;
  }

  var_2 = var_0 findpath(var_0.origin, self.origin);
  if(var_2.size < 1) {
    return 0;
  } else if(distance2d(var_2[var_2.size - 1], self.origin) >= 12) {
    return 0;
  }

  var_3 = getclosestpointonnavmesh(self.origin);
  if(!isDefined(var_3)) {
    return 0;
  }

  if(distance2d(self.origin, var_3) > 18) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](var_3)) {
      return 0;
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(self.origin, level.invalid_spawn_volume_array, var_0, undefined, 1, var_1)) {
    return 0;
  }

  if(isDefined(level.invalidtranspondervolumes)) {
    if(isDefined(level.is_in_box_func)) {
      foreach(var_5 in level.invalidtranspondervolumes) {
        if([
            [level.is_in_box_func]
          ](var_5[0], var_5[1], var_5[2], var_5[3], self.origin)) {
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

checkvalidplacementstate(var_0) {
  return !self iswallrunning() && !self isonladder() && self isonground();
}

placementfailed(var_0, var_1, var_2) {
  self notify("powers_transponder_used", 0);
  self.activated = 0;
  transponderdetonateallcharges();
  self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
  var_3 = undefined;
  var_4 = undefined;
  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.origin)) {
      var_3 = var_0.origin;
    }

    if(isDefined(var_0.weapon_name)) {
      var_4 = var_0.weapon_name;
    }
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    scripts\cp\cp_weapon::placeequipmentfailed(var_4, 1, var_3);
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}