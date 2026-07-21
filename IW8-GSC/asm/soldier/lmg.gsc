/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\lmg.gsc
***********************************************/

playcovercrouchlmg(var_0, var_1, var_2) {
  self._blackboard.droppedlmg = 0;
  thread scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1.0, 0);
  self.asm.track.prev_time = 0;
  self.rightaimlimit = -80;
  self.leftaimlimit = 80;
}

coverturretterminate(var_0, var_1, var_2) {
  self setdefaultaimlimits();
  var_3 = self getturret();

  if(!isDefined(var_3) || isDefined(self.asm.turret) && var_3 == self.asm.turret)
    self stopuseturret();

  if(isDefined(self.asm.turret)) {
    self.asm.turret.origin = self.asm.turretorigin;
    self.asm.turret.angles = self.asm.turretangles;
  }

  self.asm.turret = undefined;
  self.asm.turretorigin = undefined;
  self.asm.turretangles = undefined;
}

coverlmgterminate(var_0, var_1, var_2) {
  self setdefaultaimlimits();
}

playanim_droplmg(var_0, var_1, var_2) {
  scripts\anim\shared.gsc::dropaiweapon();

  if(!nullweapon(self.sidearm)) {
    self.weapon = self.sidearm;
    self.bulletsinclip = weaponclipsize(self.weapon);
    scripts\anim\shared.gsc::updateweaponarchetype(weaponclass(self.weapon));
  } else
    scripts\anim\shared.gsc::updateweaponarchetype("null");

  self._blackboard.inlmgstate = undefined;
  self._blackboard.deployedlmgnode = undefined;
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

turretrequested(var_0, var_1, var_2, var_3) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

chooseanim_deploylmg(var_0, var_1, var_2) {
  if(istrue(self._blackboard.droppedlmg))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "remount");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

playanim_deployturret(var_0, var_1, var_2) {
  self.asm.usingaturret = 1;
  var_3 = scripts\asm\asm_bb::bb_getrequestedturret();
  scripts\asm\asm::asm_playanimstatenotransition(var_0, var_1, var_2);
  self.asm.turretorigin = var_3.origin;
  self.asm.turretangles = var_3.angles;
  self.asm.turret = var_3;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

noanim_deployturret(var_0, var_1, var_2) {
  self.asm.usingaturret = 1;
  var_3 = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm.turretorigin = var_3.origin;
  self.asm.turretangles = var_3.angles;
  self.asm.turret = var_3;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

playanim_dismountturret(var_0, var_1, var_2) {
  self.asm.usingaturret = undefined;
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

shoulddismountlmg(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self.asm.usingaturret) && self.asm.usingaturret;

  if(var_4) {
    var_5 = self getturret();
    var_6 = scripts\asm\asm_bb::bb_getrequestedturret();
    var_7 = isDefined(var_5) && var_5 getturretowner() == self;
    var_8 = var_7 && isDefined(var_6) && var_6 == var_5;
    return !var_8;
  } else {
    var_9 = scripts\asm\asm_bb::bb_moverequested();
    var_10 = scripts\asm\shared\utility::isatcovernode();
    return var_9 || !var_10;
  }
}

playanim_deploylmg(var_0, var_1, var_2) {
  if(isDefined(self.node)) {
    self._blackboard.deployedlmgnode = self.node;
    self.keepclaimednodeifvalid = 1;
  }

  self.customnotetrackhandler = ::notehandler_deploylmg;
  self._blackboard.inlmgstate = 1;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);

  if(isDefined(self.node)) {
    if(istrue(self._blackboard.droppedlmg)) {
      self forceteleport(self.node.origin, self.angles);
      self orientmode("face angle", self.node.angles[1]);
    } else {
      var_5 = getangledelta(var_4);
      var_6 = self.node.angles[1] - var_5;
      self orientmode("face angle", var_6);
    }
  } else
    self orientmode("face angle", self.angles[1]);

  self endon(var_1 + "_finished");
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

terminate_deploylmg(var_0, var_1, var_2) {
  self.customnotetrackhandler = undefined;
}

playanim_dismountlmg(var_0, var_1, var_2) {
  self._blackboard.deployedlmgnode = undefined;
  self._blackboard.inlmgstate = undefined;
  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

notehandler_deploylmg(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "pistol_holster":
      scripts\anim\shared.gsc::placeweaponon(self.weapon, "none");
      break;
    case "lmg_pickup":
      self._blackboard.leftweaponent delete();
      self._blackboard.leftweaponent = undefined;
      scripts\anim\shared.gsc::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

lowestcoverstanddeployposeis(var_0, var_1, var_2, var_3) {
  if(isDefined(self.node)) {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over"))
      return var_3 == "high";

    return var_3 == "stand";
  }

  return 0;
}

desiredturretposeis(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.requestedturretpose))
    return self._blackboard.requestedturretpose == var_3;

  return 0;
}