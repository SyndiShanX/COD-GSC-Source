/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_portal_generator.gsc
*******************************************************/

portalgeneratorinit() {
  level._effect["portal_open"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_portal_generator.vfx");
}

portalgeneratorused(param_00) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  param_00 waittill("missile_stuck", var_01);
  if(scripts\engine\utility::istrue(self.is_off_grid)) {
    thread placementfailed(param_00);
    return;
  }

  if(isDefined(var_01) && isDefined(var_01.triggerportableradarping)) {
    thread placementfailed(param_00);
    return;
  }

  if(scripts\engine\utility::flag("disable_portals")) {
    thread placementfailed(param_00);
    return;
  }

  foreach(var_03 in level.players) {
    if(var_03 == self) {
      continue;
    }

    if(distance(var_03.origin, param_00.origin) < 50) {
      thread placementfailed(param_00);
      return;
    }
  }

  if(scripts\cp\cp_weapon::isinvalidzone(param_00.origin, level.invalid_spawn_volume_array, self, undefined, 1, var_01)) {
    var_05 = self canplayerplacesentry(1, 12);
    var_06 = spawn("script_model", param_00.origin);
    var_06 setModel("black_hole_projector_wm");
    var_06.angles = param_00.angles;
    var_06.team = self.team;
    var_06.triggerportableradarping = self;
    var_06 thread func_D68C();
    var_06 thread func_D685(self);
    var_06 thread func_D688(10);
    var_06 thread func_D683(self);
    var_06 setotherent(self);
    var_06 scripts\cp\cp_weapon::explosivehandlemovers(var_05["entity"], 1);
    scripts\cp\cp_weapon::ontacticalequipmentplanted(var_06);
    self notify("powers_portalGenerator_used", 1);
  } else {
    thread placementfailed(var_02);
    return;
  }

  scripts\engine\utility::waitframe();
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

placementfailed(param_00) {
  self notify("powers_portalGenerator_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(param_00.weapon_name, 1, param_00.origin);
  param_00 delete();
}

func_D684(param_00) {
  scripts\cp\cp_weapon::monitordamage(100, "trophy", ::func_D686, ::func_D689, 0);
}

func_D686(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_D689(param_00, param_01, param_02, param_03) {
  var_04 = param_03;
  return var_04;
}

func_D68C() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  self stoploopsound();
  self playSound("phase_portal_end");
  var_00 = self.origin;
  self notify("death");
  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\cp\cp_weapon::equipmentdeletevfx();
    scripts\cp\cp_weapon::deleteexplosive();
  }
}

func_D685(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_D68A(param_00) {
  self endon("disconnect");
  self endon("death");
  param_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_D688(param_00) {
  self endon("death");
  wait(param_00);
  self notify("detonateExplosive");
}

func_D683(param_00) {
  var_01 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_01.angles = self.angles;
  var_01.team = param_00.team;
  var_01 thread func_13B15(param_00);
  var_01 thread func_13B14(self, 10);
  var_02 = 50;
  var_03 = anglestoup(self.angles);
  var_03 = var_02 * self.angles;
  var_04 = self.origin + var_03;
  var_01.var_D682 = spawnfx(scripts\engine\utility::getfx("portal_open"), self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
  triggerfx(var_01.var_D682);
  scripts\cp\utility::playsoundinspace("phase_portal_start", var_04);
  scripts\engine\utility::delaycall(1, ::playloopsound, "phase_portal_energy_lp");
}

func_13B15(param_00) {
  self endon("death");
  var_01 = 10;
  var_02 = 1;
  for(;;) {
    self waittill("trigger", var_03);
    if(!isplayer(var_03)) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.isrewinding)) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.playing_game)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\utility::coop_mode_has("portal")) {
      if(isDefined(level.var_5592)) {
        var_03 thread[[level.var_5592]](var_03, 0.5, "fast_travel_complete");
      }

      if(isDefined(level.var_6B8D)) {
        var_03 thread[[level.var_6B8D]](var_03, 1);
      }

      continue;
    }

    if(isDefined(var_03.var_DDCA) && var_03.var_DDCA) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::isentityphaseshifted(var_03)) {
      var_03 thread func_10DDD(var_01);
    } else {
      var_03 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    }

    var_03 thread func_10DDE(var_02);
  }
}

func_10DDD(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\cp\powers\coop_phaseshift::func_6626(1, param_00);
  wait(param_00);
  thread func_6979();
}

func_10DDE(param_00) {
  self endon("death");
  self endon("disconnect");
  self.var_DDCA = 1;
  wait(param_00);
  self.var_DDCA = undefined;
}

func_6979() {
  level endon("game_ended");
  scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
  var_00 = self gettagorigin("j_mainroot") + (0, 0, 10);
  var_01 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_00);
  triggerfx(var_01);
  wait(0.3);
  var_01 delete();
}

func_13B14(param_00, param_01) {
  param_00 scripts\engine\utility::waittill_any_timeout_1(param_01, "death");
  if(isDefined(self.objid)) {
    objective_delete(self.objid);
  }

  if(isDefined(self.var_D682)) {
    self.var_D682 delete();
  }

  self delete();
}