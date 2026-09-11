/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\lmg.gsc
***********************************************/

function playcovercrouchlmg(var0, var1, var2) {
  self._blackboard.droppedlmg = 0;
  thread scripts\asm\asm::asm_loopanimstate(var0, var1, 1, 0);
  self.asm.track.prev_time = 0;
  self.rightaimlimit = -80;
  self.leftaimlimit = 80;
}

function coverturretterminate(var0, var1, var2) {
  self setdefaultaimlimits();
  var3 = self getturret();

  if(!isDefined(var3) || isDefined(self.asm.turret) && var3 == self.asm.turret) {
    self stopuseturret();
  }

  if(isDefined(self.asm.turret)) {
    self.asm.turret.origin = self.asm.turretorigin;
    self.asm.turret.angles = self.asm.turretangles;
  }

  self.asm.turret = undefined;
  self.asm.turretorigin = undefined;
  self.asm.turretangles = undefined;
}

function coverlmgterminate(var0, var1, var2) {
  self setdefaultaimlimits();
}

function playanim_droplmg(var0, var1, var2) {
  scripts\anim\shared::dropaiweapon();

  if(!nullweapon(self.sidearm)) {
    self.weapon = self.sidearm;
    self.bulletsinclip = weaponclipsize(self.weapon);
    scripts\anim\shared::updateweaponarchetype(weaponclass(self.weapon));
  } else {
    scripts\anim\shared::updateweaponarchetype("null");
  }

  self._blackboard.inlmgstate = undefined;
  self._blackboard.deployedlmgnode = undefined;
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function turretrequested(var0, var1, var2, var3) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

function chooseanim_deploylmg(var0, var1, var2) {
  if(istrue(self._blackboard.droppedlmg)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "remount");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, "default");
}

function playanim_deployturret(var0, var1, var2) {
  self.asm.usingaturret = 1;
  var3 = scripts\asm\asm_bb::bb_getrequestedturret();
  scripts\asm\asm::asm_playanimstatenotransition(var0, var1, var2);
  self.asm.turretorigin = var3.origin;
  self.asm.turretangles = var3.angles;
  self.asm.turret = var3;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

function noanim_deployturret(var0, var1, var2) {
  self.asm.usingaturret = 1;
  var3 = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm.turretorigin = var3.origin;
  self.asm.turretangles = var3.angles;
  self.asm.turret = var3;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

function playanim_dismountturret(var0, var1, var2) {
  self.asm.usingaturret = undefined;
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function shoulddismountlmg(var0, var1, var2, var3) {
  var4 = isDefined(self.asm.usingaturret) && self.asm.usingaturret;

  if(var4) {
    var5 = self getturret();
    var6 = scripts\asm\asm_bb::bb_getrequestedturret();
    var7 = isDefined(var5) && var5 getturretowner() == self;
    var8 = var7 && isDefined(var6) && var6 == var5;
    return !var8;
  }

  var9 = scripts\asm\asm_bb::bb_moverequested();
  var10 = scripts\asm\shared\utility::isatcovernode();
  return var9 || !var10;
}

function playanim_deploylmg(var0, var1, var2) {
  if(isDefined(self.node)) {
    self._blackboard.deployedlmgnode = self.node;
    self.keepclaimednodeifvalid = 1;
  }

  self.customnotetrackhandler = &notehandler_deploylmg;
  self._blackboard.inlmgstate = 1;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);

  if(isDefined(self.node)) {
    if(istrue(self._blackboard.droppedlmg)) {
      self forceteleport(self.node.origin, self.angles);
      self orientmode("face angle", self.node.angles[1]);
    } else {
      var5 = getangledelta(var4);
      var6 = self.node.angles[1] - var5;
      self orientmode("face angle", var6);
    }
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  self endon(var1 + "_finished");
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function terminate_deploylmg(var0, var1, var2) {
  self.customnotetrackhandler = undefined;
}

function playanim_dismountlmg(var0, var1, var2) {
  self._blackboard.deployedlmgnode = undefined;
  self._blackboard.inlmgstate = undefined;
  scripts\asm\asm::asm_playanimstate(var0, var1);
}

function notehandler_deploylmg(var0, var1, var2, var3) {
  switch (var0) {
    case "pistol_holster":
      scripts\anim\shared::placeweaponon(self.weapon, "none");
      break;
    case "lmg_pickup":
      self._blackboard.leftweaponent delete();
      self._blackboard.leftweaponent = undefined;
      scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

function lowestcoverstanddeployposeis(var0, var1, var2, var3) {
  if(isDefined(self.node)) {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      return (var3 == "high");
    }

    return (var3 == "stand");
  }

  return false;
}

function desiredturretposeis(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.requestedturretpose)) {
    return (self._blackboard.requestedturretpose == var3);
  }

  return false;
}