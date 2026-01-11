/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2784.gsc
***************************************/

portalgeneratorinit() {
  level._effect["portal_open"] = loadfx("vfx\iw7\_requests\mp\vfx_portal_generator");
}

portalgeneratorused(var_00) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  var_00 waittill("missile_stuck", var_01);
  var_02 = self canplayerplacesentry(1, 12);
  var_03 = spawn("script_model", var_0.origin);
  var_03 setModel("prop_mp_speed_strip_temp");
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_03 thread func_D684(self);
  var_03 thread func_D68C();
  var_03 thread func_D685(self);
  var_03 thread func_D68A(self);
  var_03 thread func_D688(5);
  var_03 thread func_D683(self);
  var_03 thread scripts\mp\weapons::func_66B4();
  var_03 setotherent(self);
  var_03 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_03 scripts\mp\weapons::explosivehandlemovers(var_2["entity"], 1);
  scripts\mp\weapons::ontacticalequipmentplanted(var_03, "power_portalGenerator");
  scripts\engine\utility::waitframe();

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_D684(var_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_D686, ::func_D689, 0);
}

func_D686(var_00, var_01, var_02, var_03) {
  if(isDefined(self.owner) && var_00 != self.owner) {
    var_00 scripts\mp\killstreaks\killstreaks::_meth_83A0();
    var_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_D689(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

func_D68C() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  scripts\mp\weapons::equipmentdeathvfx(1);
  self notify("death");
  var_00 = self.origin;
  wait 3;

  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
  }
}

func_D685(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_D68A(var_00) {
  self endon("disconnect");
  self endon("death");
  var_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_D688(var_00) {
  self endon("death");
  wait(var_00);
  self notify("detonateExplosive");
}

func_D683(var_00) {
  var_01 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_1.angles = self.angles;
  var_01 thread func_13B15(var_00);
  var_01 thread func_13B14(self, 5);
  var_02 = 50;
  var_03 = anglestoup(self.angles);
  var_03 = var_02 * var_03;
  var_04 = self.origin + var_03;
  var_1.func_D682 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_04, anglestoup(self.angles), anglesToForward(self.angles));
  triggerfx(var_1.func_D682);
  var_1.objid = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_1.objid != -1) {
    return;
  }
  scripts\mp\objidpoolmanager::minimap_objective_add(var_1.objid, "active", var_1.origin, "weapon_portal_generator_sm");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_1.objid, "weapon_portal_generator_sm");
}

func_13B15(var_00) {
  self endon("death");
  var_01 = 2.5;
  var_02 = 1.5;

  for(;;) {
    self waittill("trigger", var_03);

    if(isDefined(var_3.func_DDCA) && var_3.func_DDCA) {
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

func_10DDD(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\mp\equipment\phase_shift::func_6626(1);
  wait(var_00);
  thread func_6979();
}

func_10DDE(var_00) {
  self endon("death");
  self endon("disconnect");
  self.func_DDCA = 1;
  wait(var_00);
  self.func_DDCA = undefined;
}

func_6979() {
  level endon("game_ended");
  scripts\mp\equipment\phase_shift::exitphaseshift(1);
  var_00 = self gettagorigin("j_mainroot") + (0, 0, 10);
  var_01 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_00);
  triggerfx(var_01);
  wait 0.3;
  var_01 delete();
}

func_13B14(var_00, var_01) {
  var_00 scripts\engine\utility::waittill_any_timeout(var_01, "death");
  scripts\mp\objidpoolmanager::returnminimapid(self.objid);
  self.func_D682 delete();
  self delete();
}