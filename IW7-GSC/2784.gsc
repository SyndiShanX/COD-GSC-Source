/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2784.gsc
**************************************/

portalgeneratorinit() {
  level._effect["portal_open"] = loadfx("vfx\iw7\_requests\mp\vfx_portal_generator");
}

portalgeneratorused(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_1);
  var_2 = self canplayerplacesentry(1, 12);
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("prop_mp_speed_strip_temp");
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_3 thread func_D684(self);
  var_3 thread func_D68C();
  var_3 thread func_D685(self);
  var_3 thread func_D68A(self);
  var_3 thread func_D688(5);
  var_3 thread func_D683(self);
  var_3 thread scripts\mp\weapons::func_66B4();
  var_3 setotherent(self);
  var_3 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_3 scripts\mp\weapons::explosivehandlemovers(var_2["entity"], 1);
  scripts\mp\weapons::ontacticalequipmentplanted(var_3, "power_portalGenerator");
  scripts\engine\utility::waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_D684(var_0) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_D686, ::func_D689, 0);
}

func_D686(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 scripts\mp\killstreaks\killstreaks::func_83A0();
    var_0 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_D689(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_D68C() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  scripts\mp\weapons::equipmentdeathvfx(1);
  self notify("death");
  var_0 = self.origin;
  wait 3;

  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
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
  var_1 thread func_13B15(var_0);
  var_1 thread func_13B14(self, 5);
  var_2 = 50;
  var_3 = anglestoup(self.angles);
  var_3 = var_2 * var_3;
  var_4 = self.origin + var_3;
  var_1.var_D682 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_4, anglestoup(self.angles), anglesToForward(self.angles));
  triggerfx(var_1.var_D682);
  var_1.objid = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_1.objid != -1) {
    return;
  }
  scripts\mp\objidpoolmanager::minimap_objective_add(var_1.objid, "active", var_1.origin, "weapon_portal_generator_sm");
  scripts\mp\objidpoolmanager::minimap_objective_icon(var_1.objid, "weapon_portal_generator_sm");
}

func_13B15(var_0) {
  self endon("death");
  var_1 = 2.5;
  var_2 = 1.5;

  for(;;) {
    self waittill("trigger", var_3);

    if(isDefined(var_3.var_DDCA) && var_3.var_DDCA) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_3)) {
      var_3 thread func_10DDD(var_1);
    } else {
      var_3 scripts\mp\equipment\phase_shift::exitphaseshift(1);
    }

    var_3 thread func_10DDE(var_2);
  }
}

func_10DDD(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\mp\equipment\phase_shift::func_6626(1);
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
  scripts\mp\equipment\phase_shift::exitphaseshift(1);
  var_0 = self gettagorigin("j_mainroot") + (0, 0, 10);
  var_1 = spawnfx(scripts\engine\utility::getfx("portal_open"), var_0);
  triggerfx(var_1);
  wait 0.3;
  var_1 delete();
}

func_13B14(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_timeout(var_1, "death");
  scripts\mp\objidpoolmanager::returnminimapid(self.objid);
  self.var_D682 delete();
  self delete();
}