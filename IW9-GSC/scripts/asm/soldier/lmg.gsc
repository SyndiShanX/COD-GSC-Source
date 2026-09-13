/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\lmg.gsc
***********************************************/

playcovercrouchlmg(asmname, statename, params) {
  self._blackboard.droppedlmg = 0;
  thread scripts\asm\asm::asm_playanimstate(asmname, statename);
  self.asm.track.prev_time = 0;
  self.rightaimlimit = -80;
  self.leftaimlimit = 80;
}

coverturretterminate(asmname, statename, params) {
  self setdefaultaimlimits();
  currentturret = self getturret();

  if(!isDefined(currentturret) || isDefined(self.asm.turret) && currentturret == self.asm.turret)
    self stopuseturret();

  if(isDefined(self.asm.turret)) {
    self.asm.turret.origin = self.asm.turretorigin;
    self.asm.turret.angles = self.asm.turretangles;
  }

  self.asm.turret = undefined;
  self.asm.turretorigin = undefined;
  self.asm.turretangles = undefined;
}

coverlmgterminate(asmname, statename, params) {
  self setdefaultaimlimits();
}

playanim_droplmg(asmname, statename, params) {
  _id_3433EE6B63C7E243::dropaiweapon();

  if(!isnullweapon(self.sidearm)) {
    self.weapon = self.sidearm;
    self.bulletsinclip = weaponclipsize(self.weapon);
    _id_3433EE6B63C7E243::updateweaponarchetype(weaponclass(self.weapon));
  } else
    _id_3433EE6B63C7E243::updateweaponarchetype("null");

  self._blackboard.inlmgstate = 0;
  self._blackboard.deployedlmgnode = undefined;
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

turretrequested(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(scripts\asm\asm_bb::bb_getrequestedturret());
}

chooseanim_deploylmg(asmname, statename, params) {
  if(istrue(self._blackboard.droppedlmg))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "remount");

  return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");
}

playanim_deployturret(asmname, statename, params) {
  self._blackboard.usingaturret = 1;
  turret = scripts\asm\asm_bb::bb_getrequestedturret();
  scripts\asm\asm::asm_playanimstatenotransition(asmname, statename, params);
  self.asm.turretorigin = turret.origin;
  self.asm.turretangles = turret.angles;
  self.asm.turret = turret;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

noanim_deployturret(asmname, statename, params) {
  self._blackboard.usingaturret = 1;
  turret = scripts\asm\asm_bb::bb_getrequestedturret();
  self.asm.turretorigin = turret.origin;
  self.asm.turretangles = turret.angles;
  self.asm.turret = turret;
  self useturret(scripts\asm\asm_bb::bb_getrequestedturret());
}

playanim_dismountturret(asmname, statename, params) {
  self._blackboard.usingaturret = 0;
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

shoulddismountlmg(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self._blackboard.usingaturret) {
    turret = self getturret();
    requestedturret = scripts\asm\asm_bb::bb_getrequestedturret();
    usingturret = isDefined(turret) && turret getturretowner() == self;
    _id_2C3448AD0DDB878F = usingturret && isDefined(requestedturret) && requestedturret == turret;
    return !_id_2C3448AD0DDB878F;
  } else {
    _id_40E1A590188133E8 = scripts\asm\asm_bb::bb_moverequested();
    _id_C2DF580857CF5D57 = scripts\asm\shared\utility::isatcovernode();
    return _id_40E1A590188133E8 || !_id_C2DF580857CF5D57;
  }
}

playanim_deploylmg(asmname, statename, params) {
  if(isDefined(self.node)) {
    self._blackboard.deployedlmgnode = self.node;
    self.keepclaimednodeifvalid = 1;
  }

  self.customnotetrackhandler = ::notehandler_deploylmg;
  self._blackboard.inlmgstate = 1;
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);

  if(isDefined(self.node)) {
    if(istrue(self._blackboard.droppedlmg)) {
      self forceteleport(self.node.origin, self.angles);
      self orientmode("face angle", self.node.angles[1]);
    } else {
      _id_244A67EEE2BCF197 = getangledelta(xanim);
      _id_2DB201E40E7AAF8C = self.node.angles[1] - _id_244A67EEE2BCF197;
      self orientmode("face angle", _id_2DB201E40E7AAF8C);
    }
  } else
    self orientmode("face angle", self.angles[1]);

  self endon(statename + "_finished");
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

terminate_deploylmg(asmname, statename, params) {
  self.customnotetrackhandler = undefined;
}

playanim_dismountlmg(asmname, statename, params) {
  self._blackboard.deployedlmgnode = undefined;
  self._blackboard.inlmgstate = 0;
  scripts\asm\asm::asm_playanimstate(asmname, statename);
}

notehandler_deploylmg(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  switch (_id_A234A65C378F3289) {
    case "pistol_holster":
      _id_3433EE6B63C7E243::placeweaponon(self.weapon, "none");
      break;
    case "lmg_pickup":
      self._blackboard.leftweaponent delete();
      self._blackboard.leftweaponent = undefined;
      _id_3433EE6B63C7E243::placeweaponon(self.primaryweapon, "right");
      break;
  }
}

lowestcoverstanddeployposeis(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.node)) {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over"))
      return params == "high";

    return params == "stand";
  }

  return 0;
}

desiredturretposeis(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self._blackboard.requestedturretpose))
    return self._blackboard.requestedturretpose == params;

  return 0;
}