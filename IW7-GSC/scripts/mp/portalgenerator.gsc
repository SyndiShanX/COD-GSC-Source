/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\portalgenerator.gsc
******************************************/

portalgeneratorinit() {
  level._effect["portal_open"] = loadfx("vfx\iw7\_requests\mp\vfx_portal_generator");
}

portalgeneratorused(param_00) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  param_00 waittill("missile_stuck", var_01);
  var_02 = self canplayerplacesentry(1, 12);
  var_03 = spawn("script_model", param_00.origin);
  var_03 setModel("prop_mp_speed_strip_temp");
  var_03.angles = param_00.angles;
  var_03.team = self.team;
  var_03.triggerportableradarping = self;
  var_03 thread func_D684(self);
  var_03 thread func_D68C();
  var_03 thread func_D685(self);
  var_03 thread func_D68A(self);
  var_03 thread func_D688(5);
  var_03 thread func_D683(self);
  var_03 thread scripts\mp\weapons::func_66B4();
  var_03 setotherent(self);
  var_03 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_03 scripts\mp\weapons::explosivehandlemovers(var_02["entity"], 1);
  scripts\mp\weapons::ontacticalequipmentplanted(var_03, "power_portalGenerator");
  scripts\engine\utility::waitframe();
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_D684(param_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_D686, ::func_D689, 0);
}

func_D686(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    param_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_D689(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_D68C() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  scripts\mp\weapons::equipmentdeathvfx(1);
  self notify("death");
  var_00 = self.origin;
  wait(3);
  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
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
  var_01 thread func_13B15(param_00);
  var_01 thread func_13B14(self, 5);
  var_02 = 50;
  var_03 = anglestoup(self.angles);
  var_03 = var_02 * var_03;
  var_04 = self.origin + var_03;
  var_01.var_D682 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_04, anglestoup(self.angles), anglesToForward(self.angles));
  triggerfx(var_01.var_D682);
  var_01.objid = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_01.objid != -1) {
    return;
  }

  scripts\mp\objidpoolmanager::minimap_objective_add(var_01.objid, "active", var_01.origin, "weapon_portal_generator_sm");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_01.objid, "weapon_portal_generator_sm");
}

func_13B15(param_00) {
  self endon("death");
  var_01 = 2.5;
  var_02 = 1.5;
  for(;;) {
    self waittill("trigger", var_03);
    if(isDefined(var_03.var_DDCA) && var_03.var_DDCA) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_03)) {
      var_03 thread func_10DDD(var_01);
    } else {
      var_03 scripts\mp\equipment\phase_shift::exitphaseshift(1);
    }

    var_03 thread func_10DDE(var_02);
  }
}

func_10DDD(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\mp\equipment\phase_shift::func_6626(1);
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
  scripts\mp\equipment\phase_shift::exitphaseshift(1);
  var_00 = self gettagorigin("j_mainroot") + (0, 0, 10);
  var_01 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_00);
  triggerfx(var_01);
  wait(0.3);
  var_01 delete();
}

func_13B14(param_00, param_01) {
  param_00 scripts\engine\utility::waittill_any_timeout_1(param_01, "death");
  scripts\mp\objidpoolmanager::returnminimapid(self.objid);
  self.var_D682 delete();
  self delete();
}