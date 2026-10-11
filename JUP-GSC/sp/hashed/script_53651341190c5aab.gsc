/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_53651341190c5aab.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace interaction_common;

function onadduser(interactionid) {
  self notify("interaction_started");
}

function ondeleteuser(interactionid) {
  self.var_7916f201efb9963f = undefined;
  self._blackboard.idlenode = undefined;
  self._blackboard.var_c71a487341c700f3 = undefined;
}

function function_efcea5d26798e5b6(funcid) {
  switch (funcid) {
    case #"hash_4d7ca12cb5ce1028":
      return &startcap;
    case #"hash_303d74db152a39b9":
      return &function_606c28b248baddfd;
    case #"hash_996b6e15533d90f1":
      return &withindisttogoal;
    case #"hash_ea4044776d5dc7d8":
      return &function_75bde4ab677d8c14;
    case #"hash_b541f16499b1633d":
      return &processevent;
    case #"hash_c0639b15cea67610":
      return &onadduser;
    case #"hash_96053be986d24f88":
      return &ondeleteuser;
    case #"hash_cec0f8624eb06844":
      return &scripts\asm\cap::function_8439b78c94685919;
    case #"hash_af8904470869cfc3":
      return &function_5b942e48767afec7;
    case #"hash_fa94bdd8e04e26b2":
      return &isincombat;
    case #"hash_ebaec88a56e0a8a5":
      return &shouldreact;
    case #"hash_a56eca06864aaf61":
      return &inplace;
    case #"hash_8cc77e3e31358f72":
      return &usecustomreact;
    case #"hash_fd9154ff75bc4e6b":
      return &function_d8786f820807c4f;
    case #"hash_e8db290ca384380d":
      return &isfrienddown;
  }

  assertmsg("Missing function pointer for " + funcid);
}

function function_606c28b248baddfd(statename, params) {
  assert(params.size == 1);
  phasename = params[0];
  self._blackboard.bseqphase = phasename;
}

function startcap(statename, params) {
  if(istrue(self.startinteractionimmediate)) {
    startcap_immediate(statename, params);
  }

  capinfo = getcapinfoforrole(self, params[0]);

  if(!isDefined(capinfo)) {
    return;
  }

  capname = capinfo.capname;
  animset = capinfo.animation;
  arrivalstateoverride = capinfo.arrivalstateoverride;
  introstatename = capinfo.initialstate;
  introaliasname = capinfo.initialalias;
  interaction = spawnStruct();
  interaction.angles = self._blackboard.var_66c82b7660f29059;
  interaction.origin = self._blackboard.var_ad5eda311c73f5d7;

  if(isDefined(self findoverridearchetype("default"))) {
    var_51fb64c4bfcd847 = self findoverridearchetype("default") + "_cap_arrival";

    if(archetypehasstate(capname, var_51fb64c4bfcd847)) {
      arrivalstateoverride = var_51fb64c4bfcd847;
    }
  }

  if(isDefined(introstatename) && isDefined(introaliasname)) {
    alias = archetypegetalias(animset, introstatename, introaliasname, 0);
    animation = alias.anims;

    if(isarray(animation)) {
      animation = animation[0];
    }

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self.interaction_angles = interaction.angles;
  self.interaction_origin = getgroundposition(interaction.origin, 1);
  scripts\common\cap::cap_reach_and_arrive(interaction, capname, animset, arrivalstateoverride);
}

function startcap_immediate(statename, params) {
  capinfo = getcapinfoforrole(self, params[0]);
  capname = capinfo.capname;
  animset = capinfo.animation;
  arrivalstateoverride = capinfo.arrivalstateoverride;
  introstatename = capinfo.initialstate;
  introaliasname = capinfo.initialalias;
  interaction = spawnStruct();
  interaction.angles = self._blackboard.var_66c82b7660f29059;
  interaction.origin = self._blackboard.var_ad5eda311c73f5d7;

  if(isDefined(self findoverridearchetype("default"))) {
    var_51fb64c4bfcd847 = self findoverridearchetype("default") + "_cap_arrival";

    if(archetypehasstate(capname, var_51fb64c4bfcd847)) {
      arrivalstateoverride = var_51fb64c4bfcd847;
    }
  }

  if(isDefined(introstatename) && isDefined(introaliasname)) {
    alias = archetypegetalias(animset, introstatename, introaliasname, 0);
    animation = alias.anims;

    if(isarray(animation)) {
      animation = animation[0];
    }

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self.interaction_angles = interaction.angles;
  self.interaction_origin = interaction.origin;
  scripts\common\cap::cap_start(capname, animset, 0);
  scripts\asm\asm::asm_fireephemeralevent("move", "end");
  self forceteleport(self.interaction_origin, self.interaction_angles, 2048);
}

function withindisttogoal(statename, params) {
  mindist = params[0];

  if(self.pathpending) {
    return false;
  }

  return self pathdisttogoal() <= mindist;
}

function processevent(receiver, info, origin) {
  if(info == "relaxed") {
    return true;
  } else if(info == "panicked" || info == "cower" || info == "scared" || info == "flee") {
    scripts\asm\cap::prop_drop();
    self._blackboard.bseqphase = "exit";
  } else if(info == "curious") {
    self._blackboard.var_c71a487341c700f3 = self._blackboard.bseqphase;
    var_2aa3f9382269a724 = self function_c0de39048eedde94();

    if(scripts\asm\cap::cap_hasalias("curious", "curious_anim")) {
      self._blackboard.bseqphase = "curious";
      return true;
    } else if(!var_2aa3f9382269a724) {
      return true;
    } else {
      scripts\asm\cap::prop_drop();
      self._blackboard.bseqphase = "exit";
      return false;
    }
  } else if(!isDefined(self._blackboard.bseqphase) || isDefined(self._blackboard.bseqphase) && self._blackboard.bseqphase != "end") {
    self._blackboard.bseqphase = "react";
    return true;
  }

  return false;
}

function function_75bde4ab677d8c14(params) {
  if(isDefined(self._blackboard.bseqphase) && isDefined(params) && params.size > 0) {
    if(self._blackboard.bseqphase == params[0]) {
      return true;
    }
  }

  return false;
}

function empty(params) {}

function function_5b942e48767afec7(param) {
  statename = "curious";
  alias = "curious_anim";
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function isincombat(statename, params) {
  return self.bisincombat;
}

function shouldreact(params) {
  return self shouldpatrolreact();
}

function inplace(statename, params) {
  self._blackboard.bseqinplace = 1;
  interactionid = self getinteractionid();
  assert(isDefined(interactionid));
  createinteractionnavrepulsor(interactionid);
}

function function_25c933655d73066a(interactionid) {
  repulsorname = function_d980c506b2f1a19b(interactionid);
  destroynavrepulsor(repulsorname);
}

function private function_d980c506b2f1a19b(interactionid) {
  return "civilian_interaction_" + interactionid;
}

function private createinteractionnavrepulsor(interactionid) {
  bsequsers = getbsequsers(interactionid);

  if(bsequsers.size == 0) {
    return;
  }

  var_97e5d2c62501499e = [];

  foreach(bsequser in bsequsers) {
    if(bsequser._blackboard.bseqinplace) {
      var_97e5d2c62501499e[var_97e5d2c62501499e.size] = bsequser;
    }
  }

  if(var_97e5d2c62501499e.size == 0) {
    return;
  }

  circleorigin = (0, 0, 0);
  circleradius = 0;

  if(var_97e5d2c62501499e.size == 1) {
    circleorigin = var_97e5d2c62501499e[0].origin;
    circleradius = 15;
  } else if(var_97e5d2c62501499e.size >= 2) {
    minx = var_97e5d2c62501499e[0].origin[0];
    maxx = var_97e5d2c62501499e[0].origin[0];
    miny = var_97e5d2c62501499e[0].origin[1];
    maxy = var_97e5d2c62501499e[0].origin[1];

    for(i = 1; i < var_97e5d2c62501499e.size; i++) {
      bsequserorigin = var_97e5d2c62501499e[i].origin;

      if(bsequserorigin[0] < minx) {
        minx = bsequserorigin[0];
      } else if(bsequserorigin[0] > maxx) {
        maxx = bsequserorigin[0];
      }

      if(bsequserorigin[1] < miny) {
        miny = bsequserorigin[1];
        continue;
      }

      if(bsequserorigin[1] > maxy) {
        maxy = bsequserorigin[1];
      }
    }

    circleorigin = ((maxx + minx) / 2, (maxy + miny) / 2, 0);
    circleradiussq = 0;
    circleoriginz = 0;

    foreach(user in var_97e5d2c62501499e) {
      circleoriginz += user.origin[2];
      distancefromcentersq = distance2dsquared(circleorigin, user.origin);

      if(distancefromcentersq > circleradiussq) {
        circleradiussq = distancefromcentersq;
      }
    }

    circleoriginz /= var_97e5d2c62501499e.size;
    circleorigin += (0, 0, circleoriginz);
    circleradius = sqrt(circleradiussq) + 24;
  }

  repulsorname = function_d980c506b2f1a19b(interactionid);
  destroynavrepulsor(repulsorname);
  createnavrepulsor(repulsorname, -1, circleorigin, circleradius, 0, "all");
}

function usecustomreact(param) {
  statename = "react";
  alias = "8";
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function function_d8786f820807c4f(statename, params) {
  newstate = "custom_patrol_lookaround_passthrough";

  if(!isDefined(params[0])) {
    newstate = "stl_react_passthrough";

    if(!isDefined(self.var_fd01ad49b4e38ae8)) {
      self.var_fd01ad49b4e38ae8 = "med";
    }
  }

  if(self asmhasstate(self.asmname, newstate)) {
    assert(self asmhasstate(self.asmname, newstate));
    self asmsetstate(self.asmname, newstate);
  }
}

function isfrienddown(param) {
  statename = "friend_down";
  alias = "friend_down_anim";

  if(!scripts\asm\cap::cap_hasalias(statename, alias)) {
    return false;
  }

  if(!isDefined(self._blackboard.bseqphase)) {
    return false;
  }

  return self._blackboard.bseqphase == "friend_down";
}