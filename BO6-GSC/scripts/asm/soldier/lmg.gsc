/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\lmg.gsc
***************************************/

#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\engine\utility;
#namespace lmg;

function playcovercrouchlmg(asmname, statename, params) {
  self._blackboard.droppedlmg = 0;
  thread asm::asm_playanimstate(asmname, statename);
  self.asm.track.prev_time = 0;
  self.rightaimlimit = -80;
  self.leftaimlimit = 80;
}

function coverturretterminate(asmname, statename, params) {
  self setdefaultaimlimits();
  currentturret = self getturret();

  if(!isDefined(currentturret) || isDefined(self.asm.turret) && currentturret == self.asm.turret) {
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

function coverlmgterminate(asmname, statename, params) {
  self setdefaultaimlimits();
}

function playanim_droplmg(asmname, statename, params) {
  shared::dropaiweapon();

  if(!isnullweapon(self.sidearm)) {
    self.weapon = self.sidearm;
    self.bulletsinclip = weaponclipsize(self.weapon);
    shared::updateweaponarchetype(weaponclass(self.weapon));
  } else {
    shared::updateweaponarchetype("\xdc\x9boB");
  }

  self._blackboard.inlmgstate = 0;
  self._blackboard.deployedlmgnode = undefined;
  asm::asm_playanimstate(asmname, statename, params);
}

function turretrequested(asmname, statename, tostatename, params) {
  return isDefined(asm_bb::bb_getrequestedturret());
}

function chooseanim_deploylmg(asmname, statename, params) {
  if(istrue(self._blackboard.droppedlmg)) {
    assert(self.node == self._blackboard.deployedlmgnode);
    return asm::asm_lookupanimfromalias(statename, "9\x95k\xde\xea\xe6\xa3");
  }

  return asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
}

function playanim_deployturret(asmname, statename, params) {
  self._blackboard.usingaturret = 1;
  assert(isDefined(asm_bb::bb_getrequestedturret()));
  turret = asm_bb::bb_getrequestedturret();
  assert(distancesquared(turret.origin, self.origin) < 4096);
  assert(!isDefined(self.customnotetrackhandler));
  asm::asm_playanimstatenotransition(asmname, statename, params);
  self.asm.turretorigin = turret.origin;
  self.asm.turretangles = turret.angles;
  self.asm.turret = turret;
  self useturret(asm_bb::bb_getrequestedturret());
}

function noanim_deployturret(asmname, statename, params) {
  self._blackboard.usingaturret = 1;
  assert(isDefined(asm_bb::bb_getrequestedturret()));
  turret = asm_bb::bb_getrequestedturret();
  assert(distancesquared(turret.origin, self.origin) < 4096);
  assert(!isDefined(self.customnotetrackhandler));
  self.asm.turretorigin = turret.origin;
  self.asm.turretangles = turret.angles;
  self.asm.turret = turret;
  self useturret(asm_bb::bb_getrequestedturret());
}

function playanim_dismountturret(asmname, statename, params) {
  self._blackboard.usingaturret = 0;
  asm::asm_playanimstate(asmname, statename, params);
}

function shoulddismountlmg(asmname, statename, tostatename, params) {
  if(self._blackboard.usingaturret) {
    turret = self getturret();
    requestedturret = asm_bb::bb_getrequestedturret();
    usingturret = isDefined(turret) && turret getturretowner() == self;
    usingrequestedturret = usingturret && isDefined(requestedturret) && requestedturret == turret;
    return !usingrequestedturret;
  }

  moverequested = asm_bb::bb_moverequested();
  atcovernode = utility::isatcovernode();
  return moverequested || !atcovernode;
}

function playanim_deploylmg(asmname, statename, params) {
  if(isDefined(self.node)) {
    self._blackboard.deployedlmgnode = self.node;
    self.keepclaimednodeifvalid = 1;
  }

  assert(!isDefined(self.customnotetrackhandler));
  self.customnotetrackhandler = &notehandler_deploylmg;
  self._blackboard.inlmgstate = 1;
  animid = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animid);

  if(isDefined(self.node)) {
    if(istrue(self._blackboard.droppedlmg)) {
      self forceteleport(self.node.origin, self.angles);
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.node.angles[1]);
    } else {
      animangle = getangledelta(xanim);
      desiredyaw = self.node.angles[1] - animangle;
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", desiredyaw);
    }
  } else {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  }

  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function terminate_deploylmg(asmname, statename, params) {
  self.customnotetrackhandler = undefined;
}

function playanim_dismountlmg(asmname, statename, params) {
  self._blackboard.deployedlmgnode = undefined;
  self._blackboard.inlmgstate = 0;
  asm::asm_playanimstate(asmname, statename);
}

function notehandler_deploylmg(note, flagname, customfunction, customparams) {
  switch (note) {
    case #"hash_187a1588294dd34e":
      shared::placeweaponon(self.weapon, "\r+x5");
      break;
    case #"hash_c24ff1dd3ebd3f6c":
      assert(isDefined(self._blackboard.leftweaponent));
      self._blackboard.leftweaponent delete();
      self._blackboard.leftweaponent = undefined;
      assert(weaponclass(self.primaryweapon) == "<dev string:x24>");
      shared::placeweaponon(self.primaryweapon, "o0\xee\xc1\x8c");
      break;
  }
}

function lowestcoverstanddeployposeis(asmname, statename, tostatename, params) {
  assert(isDefined(params));

  if(isDefined(self.node)) {
    if(!self.node utility::isvalidpeekoutdir("W\x8eQ\xb7")) {
      return (params == ":\xbfa^");
    }

    return (params == "\x8b\x90\xb5\xc4W");
  }

  return false;
}

function desiredturretposeis(asmname, statename, tostatename, params) {
  assert(isDefined(params));

  if(isDefined(self._blackboard.requestedturretpose)) {
    return (self._blackboard.requestedturretpose == params);
  }

  return false;
}