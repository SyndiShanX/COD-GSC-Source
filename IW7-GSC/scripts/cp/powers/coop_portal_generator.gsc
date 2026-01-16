/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_portal_generator.gsc
*******************************************************/

portalgeneratorinit() {
  level._effect["portal_open"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_portal_generator.vfx");
}

portalgeneratorused(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_1);
  if(scripts\engine\utility::istrue(self.is_off_grid)) {
    thread placementfailed(var_0);
    return;
  }

  if(isDefined(var_1) && isDefined(var_1.owner)) {
    thread placementfailed(var_0);
    return;
  }

  if(scripts\engine\utility::flag("disable_portals")) {
    thread placementfailed(var_0);
    return;
  }

  foreach(var_3 in level.players) {
    if(var_3 == self) {
      continue;
    }

    if(distance(var_3.origin, var_0.origin) < 50) {
      thread placementfailed(var_0);
      return;
    }
  }

  if(scripts\cp\cp_weapon::isinvalidzone(var_0.origin, level.invalid_spawn_volume_array, self, undefined, 1, var_1)) {
    var_5 = self canplayerplacesentry(1, 12);
    var_6 = spawn("script_model", var_0.origin);
    var_6 setModel("black_hole_projector_wm");
    var_6.angles = var_0.angles;
    var_6.team = self.team;
    var_6.owner = self;
    var_6 thread func_D68C();
    var_6 thread func_D685(self);
    var_6 thread func_D688(10);
    var_6 thread func_D683(self);
    var_6 setotherent(self);
    var_6 scripts\cp\cp_weapon::explosivehandlemovers(var_5["entity"], 1);
    scripts\cp\cp_weapon::ontacticalequipmentplanted(var_6);
    self notify("powers_portalGenerator_used", 1);
  } else {
    thread placementfailed(var_2);
    return;
  }

  scripts\engine\utility::waitframe();
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

placementfailed(var_0) {
  self notify("powers_portalGenerator_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
  var_0 delete();
}

func_D684(var_0) {
  scripts\cp\cp_weapon::monitordamage(100, "trophy", ::func_D686, ::func_D689, 0);
}

func_D686(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_D689(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  return var_4;
}

func_D68C() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  self stoploopsound();
  self playSound("phase_portal_end");
  var_0 = self.origin;
  self notify("death");
  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\cp\cp_weapon::equipmentdeletevfx();
    scripts\cp\cp_weapon::deleteexplosive();
  }
}

func_D685(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self notify("detonateExplosive");
}

func_D68A(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_D688(var_0) {
  self endon("death");
  wait(var_0);
  self notify("detonateExplosive");
}

func_D683(var_0) {
  var_1 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_1.angles = self.angles;
  var_1.team = var_0.team;
  var_1 thread func_13B15(var_0);
  var_1 thread func_13B14(self, 10);
  var_2 = 50;
  var_3 = anglestoup(self.angles);
  var_3 = var_2 * self.angles;
  var_4 = self.origin + var_3;
  var_1.var_D682 = spawnfx(scripts\engine\utility::getfx("portal_open"), self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
  triggerfx(var_1.var_D682);
  scripts\cp\utility::playsoundinspace("phase_portal_start", var_4);
  scripts\engine\utility::delaycall(1, ::playloopsound, "phase_portal_energy_lp");
}

func_13B15(var_0) {
  self endon("death");
  var_1 = 10;
  var_2 = 1;
  for(;;) {
    self waittill("trigger", var_3);
    if(!isplayer(var_3)) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.isrewinding)) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.playing_game)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\utility::coop_mode_has("portal")) {
      if(isDefined(level.var_5592)) {
        var_3 thread[[level.var_5592]](var_3, 0.5, "fast_travel_complete");
      }

      if(isDefined(level.var_6B8D)) {
        var_3 thread[[level.var_6B8D]](var_3, 1);
      }

      continue;
    }

    if(isDefined(var_3.var_DDCA) && var_3.var_DDCA) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::isentityphaseshifted(var_3)) {
      var_3 thread func_10DDD(var_1);
    } else {
      var_3 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    }

    var_3 thread func_10DDE(var_2);
  }
}

func_10DDD(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\cp\powers\coop_phaseshift::func_6626(1, var_0);
  wait(var_0);
  thread func_6979();
}

func_10DDE(var_0) {
  self endon("death");
  self endon("disconnect");
  self.var_DDCA = 1;
  wait(var_0);
  self.var_DDCA = undefined;
}

func_6979() {
  level endon("game_ended");
  scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
  var_0 = self gettagorigin("j_mainroot") + (0, 0, 10);
  var_1 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_0);
  triggerfx(var_1);
  wait(0.3);
  var_1 delete();
}

func_13B14(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_timeout(var_1, "death");
  if(isDefined(self.objid)) {
    objective_delete(self.objid);
  }

  if(isDefined(self.var_D682)) {
    self.var_D682 delete();
  }

  self delete();
}