/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\shared\utility.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace utility;

function chooseanimshoot(asmname, statename, params) {
  var_e592890e140b7faa = params;
  assert(isDefined(var_e592890e140b7faa));
  alias = self._blackboard.shootstate + "_" + var_e592890e140b7faa;

  if(isDefined(self._blackboard.shootstate) && asm_hasalias(statename, alias)) {
    return asm_lookupanimfromalias(statename, alias);
  }

  return asm_lookupanimfromalias(statename, params);
}

function choosedemeanoranimwithoverride(asmname, statename, params) {
  demeanor = asm_getdemeanor();

  if(asm_hasdemeanoranimoverride(demeanor, params)) {
    override = asm_getdemeanoranimoverride(demeanor, params);

    if(isarray(override)) {
      return override[randomint(override.size)];
    }

    return override;
  }

  if(!asm_hasalias(statename, demeanor)) {
    return asm_lookupanimfromalias(statename, "default");
  }

  return asm_lookupanimfromalias(statename, demeanor);
}

function choosedemeanoranimwithoverridevariants(asmname, statename, params) {
  demeanor = asm_getdemeanor();

  if(asm_hasdemeanoranimoverride(demeanor, params)) {
    override = asm_getdemeanoranimoverride(demeanor, params);

    if(isarray(override)) {
      return override[randomint(override.size)];
    }

    return override;
  }

  if(!asm_hasalias(statename, demeanor)) {
    moveanims = [];
    moveanims[0] = asm_lookupanimfromalias(statename, "trans_to_one_hand_run");
    moveanims[1] = asm_lookupanimfromalias(statename, "one_hand_run");
    moveanims[2] = asm_lookupanimfromalias(statename, "trans_to_two_hand_run");
    moveanims[3] = asm_lookupanimfromalias(statename, "two_hand_run");
    return moveanims;
  }

  return asm_lookupanimfromalias(statename, demeanor);
}

function overridecovercrouchnodetype(node) {
  if(node.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
    return self._blackboard.croucharrivaltype;
  }

  return node.type;
}

function allowlmgarrival() {
  if(istrue(self.disablelmgmount)) {
    return false;
  }

  ismg = weaponclass(self.weapon) == "mg";

  if(ismg) {
    if(!isDefined(self.node) || self.node isnodelmgmountable()) {
      return true;
    }

    return false;
  }

  if(isDefined(self._blackboard.deployedlmgnode) && isDefined(self.node) && self.node == self._blackboard.deployedlmgnode && self.node isnodelmgmountable()) {
    return true;
  }

  return false;
}

function getnodeforwardyaw(node, poseoverride, var_83ca7917ee6a88e8) {
  assert(isai(self));
  assert(!actor_is3d());

  if(!isDefined(var_83ca7917ee6a88e8)) {
    var_83ca7917ee6a88e8 = 1;
  }

  offset = self getnodeyawoffset(node, poseoverride, var_83ca7917ee6a88e8);
  return node.angles[1] + offset;
}

function nodeiscoverstand3dtype(node) {
  if(node.type == "Cover Stand 3D") {
    return !nodeiscoverexposed3dtype(node);
  }

  return false;
}

function nodeiscoverexposed3dtype(node) {
  if(node.type == "Cover Stand 3D") {
    if(isDefined(node.script_parameters) && node.script_parameters == "exposed") {
      return true;
    }
  }

  return false;
}

function getnodetypename(node) {
  if(isDefined(node)) {
    if(nodeiscoverexposed3dtype(node)) {
      return "Cover Exposed 3D";
    } else {
      return node.type;
    }
  }

  return "undefined";
}

function choosestrongdamagedeath(asmname, statename, params) {
  alias = undefined;

  if(abs(self.damageyaw) > 150) {
    if(damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      alias = "legs";
    } else if(self.damagelocation == "torso_lower") {
      alias = "torso_lower";
    } else {
      alias = "default";
    }
  } else if(self.damageyaw < 0) {
    alias = "right";
  } else {
    alias = "left";
  }

  return asm_lookupanimfromalias(statename, alias);
}

function isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

function shouldleaveanimScripted(asmname, statename, tostatename, params) {
  if(bb_isanimScripted()) {
    return false;
  }

  if(isDefined(params)) {
    assert(!isarray(params));
    var_c33b7d825b24a8bb = params;

    if(var_c33b7d825b24a8bb) {
      if(self.a.movement == "stop") {
        return false;
      }

      if(!bb_moverequested()) {
        return false;
      }
    } else if(bb_moverequested() && self.a.movement != "stop") {
      return false;
    }
  }

  return true;
}

function animscriptedaction(asmname, statename, params) {
  self endon(statename + "_finished");
  self.a.movement = "run";
  self.gunposeoverride_internal = "disable";
  animindex = asm_lookupanimfromalias(statename, "blank");
  self aisetanim(statename, animindex);
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

function randomizepassthroughchildren(asmname, statename, tostatename, params) {
  var_4826b510746869c3 = anim.asm[asmname].states[tostatename];
  assert(isDefined(var_4826b510746869c3));

  if(isDefined(var_4826b510746869c3.transitions)) {
    if(var_4826b510746869c3.transitions.size == 2) {
      if(cointoss()) {
        temp = var_4826b510746869c3.transitions[0];
        var_4826b510746869c3.transitions[0] = var_4826b510746869c3.transitions[1];
        var_4826b510746869c3.transitions[1] = temp;
      }
    } else {
      var_4826b510746869c3.transitions = scripts\engine\utility::array_randomize(var_4826b510746869c3.transitions);
    }
  }

  return true;
}

function nodeshouldfaceangles(node) {
  if(!isDefined(node)) {
    return false;
  }

  if(isDefined(node.angles)) {
    return true;
  }

  if(isstruct(node)) {
    return false;
  }

  return isDefined(node.type) && node.type != "Path" && !isnodeexposed3d(node);
}

function choosecrouchorstand(guy, node) {
  return int(node.origin[0] + node.origin[1] + node.origin[2] + guy getentitynumber()) % 2;
}

function choosecrouchorstandtac(guy, tacorigin) {
  return int(abs(tacorigin[0] + tacorigin[1] + tacorigin[2] + guy getentitynumber())) % 2;
}

function getarrivalnode() {
  if(istrue(self.leavecasualkiller)) {
    return undefined;
  }

  if(isDefined(self.scriptedarrivalent) && !self btgoalvalid()) {
    assert(isDefined(self.scriptedarrivalent.type));
    return self.scriptedarrivalent;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36) {
    return self.prevnode;
  }

  if(isDefined(self.last_set_goalnode)) {
    return self.last_set_goalnode;
  }

  return self.last_set_goalent;
}

function isarrivaltypecivilian(asmname, arrivaltype) {
  if(isDefined(self.var_a57082fdf62bc898)) {
    return (arrivaltype == "Custom");
  }

  if(bb_smartobjectrequested()) {
    return (arrivaltype == "Exposed");
  }

  node = getarrivalnode();

  if(isDefined(node) && isnode(node) && node iscovermultinode()) {
    var_bc81741e5658c761 = getbestcovermultinodetype(node);

    if(isDefined(var_bc81741e5658c761)) {
      node setcovermultinodetype(var_bc81741e5658c761);
    }
  }

  if(!isDefined(node) || !isDefined(node.type) || node.type == "struct" || !self canusecover()) {
    return (arrivaltype == "Exposed");
  }

  if(isDefined(node) && node.type == "Cover Crouch") {
    covertype = getDvar(@ "hash_f72dde9792b94cc9");

    if(covertype != "") {
      return (arrivaltype == covertype);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (arrivaltype == self._blackboard.croucharrivaltype);
    } else if(isDefined(node.covercrouchtype)) {
      return (arrivaltype == node.covercrouchtype);
    }
  }

  demeanor = asm_getdemeanor();
  canstand = (!isnode(node) || node doesnodeallowstance("stand")) && self isstanceallowed("stand");
  cancrouch = (!isnode(node) || node doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && demeanor != "casual" && demeanor != "casual_gun";

  switch (arrivaltype) {
    case #"hash_cf178f370da8b13":
      if(node.type != "Path" && node.type != "Exposed") {
        return 0;
      }

      if(cancrouch && choosecrouchorstand(self, node)) {
        return 0;
      }

      return canstand;
    case #"hash_78bfa3258dd84af":
      if(node.type != "Path" && node.type != "Exposed") {
        return 0;
      }

      if(canstand && !choosecrouchorstand(self, node)) {
        return 0;
      }

      return cancrouch;
    case #"hash_c3b74422dec48736":
      return (node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window" || node.type == "Cover Stand" || node.type == "Conceal Stand" || node.type == "Cover Prone" || node.type == "Conceal Prone");
    case #"hash_e1d8e1adebed5a61":
      return (node.type == "Cover Left");
    case #"hash_cd3ffe799551db82":
      return (node.type == "Cover Right");
    case #"hash_a85b3cf9ab13da63":
      return (node.type == "Exposed Moving");
  }

  return arrivaltype == node.type;
}

function isarrivaltype(asmname, statename, tostatename, params) {
  arrivaltype = params;

  if(isDefined(self.var_a57082fdf62bc898)) {
    return (arrivaltype == "Custom");
  }

  if(bb_smartobjectrequested()) {
    return (arrivaltype == "Exposed");
  }

  node = getarrivalnode();

  if(isDefined(node) && isnode(node) && node iscovermultinode()) {
    var_bc81741e5658c761 = getbestcovermultinodetype(node);

    if(isDefined(var_bc81741e5658c761) && node.type != var_bc81741e5658c761 && arrivaltype == var_bc81741e5658c761) {
      node setcovermultinodetype(var_bc81741e5658c761);
    }
  }

  if(!isDefined(node) || !isDefined(node.type) || node.type == "struct" || !self canusecover()) {
    if(actor_is3d()) {
      return (arrivaltype == "Exposed 3D");
    } else {
      return (arrivaltype == "Exposed");
    }
  }

  lmg = scripts\asm\shared\utility::allowlmgarrival();

  if(isDefined(node) && node.type == "Cover Crouch" && !lmg) {
    covertype = getDvar(@ "hash_f72dde9792b94cc9");

    if(covertype != "") {
      return (arrivaltype == covertype);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (arrivaltype == self._blackboard.croucharrivaltype);
    } else if(isDefined(node.covercrouchtype)) {
      return (arrivaltype == node.covercrouchtype);
    }
  }

  demeanor = asm_getdemeanor();
  canstand = (!isnode(node) || node doesnodeallowstance("stand")) && self isstanceallowed("stand");
  cancrouch = (!isnode(node) || node doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && demeanor != "casual" && demeanor != "casual_gun";

  if(asmname == "zero_gravity_space") {
    switch (arrivaltype) {
      case #"hash_4626de3588a73d7e":
        return (isnodeexposed3d(node) && canstand);
      case #"hash_b786e406d37a0dd7":
        return (node.type == "Cover 3D");
      case #"hash_bdacbb6eaaa538c7":
        return nodeiscoverstand3dtype(node);
      case #"hash_a8e3c2570a26f937":
        return nodeiscoverexposed3dtype(node);
      case #"hash_78bfa3258dd84af":
      case #"hash_cf178f370da8b13":
      case #"hash_55ed607005f12d49":
      case #"hash_667bc7e605903a6c":
      case #"hash_c051a32186a33cae":
      case #"hash_c3b74422dec48736":
      case #"hash_cd3ffe799551db82":
      case #"hash_e1d8e1adebed5a61":
      case #"hash_fd7cd04a31eca976":
        assertmsg(arrivaltype + " node type not supported in zero-gravity.");
        break;
    }
  } else if(asmname == "zero_gravity") {
    switch (arrivaltype) {
      case #"hash_cf178f370da8b13":
        return ((node.type == "Path" || node.type == "Exposed") && canstand);
      case #"hash_78bfa3258dd84af":
        return ((node.type == "Path" || node.type == "Exposed") && cancrouch);
      case #"hash_c3b74422dec48736":
        return (node.type == "Cover Crouch" || node.type == "Conceal Crouch");
      case #"hash_78b110033ccb68b0":
        return (node.type == "Cover Stand" || node.type == "Conceal Stand");
      case #"hash_55ed607005f12d49":
      case #"hash_667bc7e605903a6c":
      case #"hash_c051a32186a33cae":
      case #"hash_cd3ffe799551db82":
      case #"hash_e1d8e1adebed5a61":
        assertmsg(arrivaltype + " node type not supported in zero-gravity.");
        break;
    }
  } else {
    switch (arrivaltype) {
      case #"hash_cf178f370da8b13":
        if(node.type != "Path" && node.type != "Exposed") {
          return 0;
        }

        if(cancrouch && choosecrouchorstand(self, node)) {
          return 0;
        }

        return canstand;
      case #"hash_78bfa3258dd84af":
        if(node.type != "Path" && node.type != "Exposed") {
          return 0;
        }

        if(canstand && !choosecrouchorstand(self, node)) {
          return 0;
        }

        return cancrouch;
      case #"hash_c3b74422dec48736":
        return (node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window");
      case #"hash_78b110033ccb68b0":
        return (node.type == "Cover Stand" || node.type == "Conceal Stand");
      case #"hash_c051a32186a33cae":
        return (node.type == "Cover Prone" || node.type == "Conceal Prone");
      case #"hash_e1d8e1adebed5a61":
        if(node.type != "Cover Left") {
          return 0;
        }

        if(cancrouch && choosecrouchorstand(self, node)) {
          return 0;
        }

        return canstand;
      case #"hash_55ed607005f12d49":
        if(node.type != "Cover Left") {
          return 0;
        }

        if(canstand && !choosecrouchorstand(self, node)) {
          return 0;
        }

        return cancrouch;
      case #"hash_cd3ffe799551db82":
        if(node.type != "Cover Right") {
          return 0;
        }

        if(cancrouch && choosecrouchorstand(self, node)) {
          return 0;
        }

        return canstand;
      case #"hash_667bc7e605903a6c":
        if(node.type != "Cover Right") {
          return 0;
        }

        if(canstand && !choosecrouchorstand(self, node)) {
          return 0;
        }

        return cancrouch;
      case #"hash_5478c96ea12827c6":
        return ((node.type == "Cover Crouch" || node.type == "Cover Prone") && scripts\asm\shared\utility::allowlmgarrival());
      case #"hash_bfb9a0387a2536f4":
        return (node.type == "Cover Stand" && scripts\asm\shared\utility::allowlmgarrival());
      case #"hash_a85b3cf9ab13da63":
        return (node.type == "Exposed Moving");
    }
  }

  return arrivaltype == node.type;
}

function playmoveloop(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 0;
  rate = 1;
  function_fb56c9527636713f(asmname, statename, rate, 1);
}

function playmoveloopcasual(asmname, statename, params) {
  playmoveloop(asmname, statename, params);
}

function playanimwithdooropen(asmname, statename, params) {
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 1;
  playanim(asmname, statename, params);
}

function playmoveloopcasualcleanup(asmname, statename, params) {}

function calcdooropenspeed() {
  if(iscp()) {
    return 0.8;
  }

  t = 0.75;
  speed = length(self.velocity);

  if(speed > 0) {
    t = 24 / speed;
  }

  if(t < 0.15) {
    t = 0.15;
  } else if(t > 1) {
    t = 1;
  }

  return t;
}

function opendooratreasonabletime() {
  door = self._blackboard.doortoopen;
  fndooropen = self.fndooropen;

  if(!isDefined(door) || !isDefined(fndooropen)) {
    return;
  }

  self._blackboard.door_opened = 1;
  self endon("death");
  door endon("death");
  self endon("path_has_door");
  doorcenter = self[[self.fngetdoorcenter]](door);
  var_f195bad2134db294 = distance2dsquared(doorcenter, self.origin);
  opendistsq = 5476;

  if(!issp()) {
    opendist = 0.8 * length(self.velocity);
    opendist *= 0.9;
    opendistsq = max(opendist * opendist, opendistsq);
  }

  while(var_f195bad2134db294 > opendistsq) {
    if(isDefined(self._blackboard.doortoopen) && door != self._blackboard.doortoopen) {
      return;
    }

    waitframe();
    var_f195bad2134db294 = distance2dsquared(doorcenter, self.origin);
  }

  t = calcdooropenspeed();
  self notify("opening_door");
  self thread[[fndooropen]](door, t);
  return t;
}

function opendooratreasonabletime_waitforabort(statename) {
  self endon("opening_door_done");
  self waittill(statename + "_finished");

  if(!isalive(self)) {
    return;
  }

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = 0;
  self notify("opening_door_done");
}

function closedoorifnecessary(door) {
  assert(isDefined(self.fndoorneedstoclose));

  if(self[[self.fndoorneedstoclose]](door)) {
    self[[self.fndoorclose]](door);
  }
}

function function_b6a072e9e59fb82e(asmname, statename, var_d6e02014cb6c5b06) {
  self endon(statename + "_finished");
  self endon("death");

  if(isDefined(self._blackboard.doortoopen)) {
    var_eb8ea5fef7306d32 = isdoorclear();

    if(var_eb8ea5fef7306d32) {
      self._blackboard.doortoopen = undefined;
      return;
    }

    bdooropen = 0;

    if(!self.facemotion) {
      bdooropen = function_ff35aef6aed32425(statename);
    }

    if(!bdooropen) {
      function_4d06ccc14a583480(asmname, statename, var_d6e02014cb6c5b06);
    }
  }
}

function isdoorclear() {
  var_eb8ea5fef7306d32 = 0;

  if(self[[self.fndooralreadyopen]](self._blackboard.doortoopen)) {
    var_eb8ea5fef7306d32 = 1;
  }

  if(!var_eb8ea5fef7306d32 && !isent(self._blackboard.doortoopen)) {
    if(!isDefined(self getmodifierlocationonpath("door", 200))) {
      var_eb8ea5fef7306d32 = 1;
    }
  }

  return var_eb8ea5fef7306d32;
}

function function_ff35aef6aed32425(statename) {
  self endon(statename + "_finished");
  self endon("death");
  bdooropen = 0;
  lookaheaddir = self.lookaheaddir;
  lookaheaddir = vectorNormalize((lookaheaddir[0], lookaheaddir[1], 0));
  facingdir = anglesToForward(self.angles);

  if(vectordot(lookaheaddir, facingdir) < 0.966) {
    self.isopeningdoor = 1;
    thread function_4dd19bfd2ee610f1(statename);
    t = opendooratreasonabletime();

    if(isDefined(t)) {
      thread opendooratreasonabletime_waitforabort(statename);
      wait t;
    }

    self notify("opening_door_done");
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = 0;
    bdooropen = 1;
  }

  return bdooropen;
}

function function_4d06ccc14a583480(asmname, statename, var_d6e02014cb6c5b06) {
  self endon(statename + "_finished");
  self endon("death");
  door = self._blackboard.doortoopen;
  self._blackboard.door_opened = undefined;
  var_36effa6a4b76959f = 1;
  cdooroffset = 160;
  var_ccd231d7c8137213 = 2;
  targetspeed = length2d(self.velocity);

  if(!istrue(var_d6e02014cb6c5b06)) {
    var_9db8509018bbb8a = function_20962146e1a2e0dd(statename, targetspeed);

    if(isDefined(var_9db8509018bbb8a[1])) {
      cdooroffset = function_e183019dcea5b774(var_9db8509018bbb8a[0], var_9db8509018bbb8a[1], targetspeed);
    } else {
      var_d6e02014cb6c5b06 = 1;
    }
  }

  var_76c751e661fc569f = var_36effa6a4b76959f + cdooroffset + var_ccd231d7c8137213;
  doorcenter = self[[self.fngetdoorcenter]](door);
  var_8a2d1a3f463dffac = distance2d(doorcenter, self.origin);

  if(var_8a2d1a3f463dffac < var_76c751e661fc569f) {
    self.isopeningdoor = 1;
    thread closedoorifnecessary(door);
    var_382ab682aa991089 = 5;

    if(istrue(var_d6e02014cb6c5b06)) {
      var_382ab682aa991089 = 2;
    }

    if(istrue(var_d6e02014cb6c5b06) || var_8a2d1a3f463dffac < var_76c751e661fc569f - targetspeed * var_382ab682aa991089 * level.framedurationseconds) {
      assert(isDefined(self.fndooropen));
      thread function_4dd19bfd2ee610f1(statename);
      t = opendooratreasonabletime();

      if(isDefined(t)) {
        thread opendooratreasonabletime_waitforabort(statename);
        wait t;
      }

      self notify("opening_door_done");
      self._blackboard.doortoopen = undefined;
      self.isopeningdoor = 0;
      return;
    }

    self setupdooropen(door, var_76c751e661fc569f, getdooropenspeedlookup());
    thread handledooropennotetrack(asmname, statename);
    thread handledooropenterminate(asmname, statename);
    self waittill("opening_door_done");
  }
}

function function_e183019dcea5b774(doorstate, var_60caa01062501fdc, targetspeed) {
  doorxanim = asm_getxanim(doorstate, var_60caa01062501fdc);
  assertex(animhasnotetrack(doorxanim, "door_touch"), doorxanim + " missing door_touch notetrack");
  opentimes = getnotetracktimes(doorxanim, "door_touch");
  assert(opentimes.size > 0);
  animdist = (opentimes[0] * getanimlength(doorxanim) + 3 * level.framedurationseconds) * targetspeed;
  cdooroffset = animdist + 24;
  assertex(animhasnotetrack(doorxanim, "door_open"), doorxanim + " missing door_open notetrack");
  return cdooroffset;
}

function function_20962146e1a2e0dd(statename, targetspeed) {
  doorstate = statename;
  dooranim = asm_lookupanimfromaliasifexists(statename, "2");

  if(!isDefined(dooranim)) {
    targetspeed = self aigettargetspeed();
    speedstate = getnearestspeedthresholdname(self.basearchetype, targetspeed);

    if(isDefined(speedstate)) {
      dooralias = speedstate + "2";
      dooranim = asm_lookupanimfromaliasifexists(statename, dooralias);

      if(!isDefined(dooranim)) {
        doorstate = "door_open";
        dooranim = asm_lookupanimfromaliasifexists("door_open", dooralias);
      }
    }
  }

  if(!isDefined(dooranim)) {
    dooranim = asm_lookupanimfromaliasifexists("door_open", "2");
  }

  return [doorstate, dooranim];
}

function handledooropennotetrack(asmname, statename) {
  self endon(statename + "_finished");
  self endon("opening_door_done");

  while(true) {
    self waittill("door_open", notes);

    if(!isarray(notes)) {
      notes = [notes];
    }

    for(inote = 0; inote < notes.size; inote++) {
      if(notes[inote] == "door_open") {
        if(isDefined(self.fndooropen) && isDefined(self._blackboard.doortoopen)) {
          self notify("opening_door");
          t = calcdooropenspeed();
          self thread[[self.fndooropen]](self._blackboard.doortoopen, t);
          self._blackboard.door_opened = 1;
        }

        continue;
      }

      if(notes[inote] == "end") {
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = 0;
        self cleardooropen();
        self notify("opening_door_done");
      }
    }

    waitframe();
  }
}

function handledooropenterminate(asmname, statename) {
  self endon("opening_door_done");
  self waittill(statename + "_finished");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!istrue(self._blackboard.door_opened)) {
    thread opendooratreasonabletime();
  }

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = 0;
  self cleardooropen();
}

function function_4dd19bfd2ee610f1(statename) {
  self endon("opening_door_done");
  self endon("death");
  statefinish = statename + "_finished";
  msg = waittill_any_return_2(statefinish, "opening_door");

  if(msg == statefinish) {
    self.isopeningdoor = 0;
  }
}

function getdooropenspeedlookup() {
  if(self.animsetname == "civilian_panic") {
    return "civilian_panic";
  }

  if(self.unittype == "civilian") {
    return "civilian";
  }

  if(self.animsetname == "juggernaut") {
    return "soldier";
  }

  return "soldier";
}

function playanim(asmname, statename, params) {
  asm_playanimstate(asmname, statename, params);
}

function playanimwithsound(asmname, statename, params) {
  self playSound(params);
  asm_playanimstate(asmname, statename, params);
}

function loopanim(asmname, statename, params) {
  function_fb56c9527636713f(asmname, statename, 1);
}

function chooseanimidle(asmname, statename, params) {
  demeanor = asm_getdemeanor();

  if(asm_hasdemeanoranimoverride(demeanor, "idle")) {
    override = asm_getdemeanoranimoverride(demeanor, "idle");

    if(isarray(override)) {
      return override[randomint(override.size)];
    }

    return override;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node isvalidpeekoutdir("over")) {
      params += "_high";
    }
  }

  return chooseanim_weaponclassprepended(asmname, statename, params);
}

function chooseanim_weaponclassprepended(asmname, statename, params) {
  assert(isDefined(self.weapon));
  weapclass = weaponclass(self.weapon);
  alias = undefined;

  if(!isDefined(params)) {
    return asm_getrandomanim(asmname, statename);
  } else {
    alias = params;
  }

  if(!asm_hasalias(statename, weapclass + alias)) {
    weapclass = "rifle";
    assertex(asm_hasalias(statename, weapclass + alias), "Archetype " + self.animsetname + " State " + statename + " doesn't have " + weapclass + alias + " anims");
  }

  return asm_lookupanimfromalias(statename, weapclass + alias);
}

function getarrivaltype() {
  if(isDefined(self.var_a57082fdf62bc898)) {
    return "Custom";
  }

  if(bb_smartobjectrequested()) {
    return "Exposed";
  }

  node = getarrivalnode();

  if(!isDefined(node) || !isnode(node) || !isDefined(node.type) || node.type == "struct" || !self canusecover()) {
    tac_origin = self getcovertacpoint();

    if(isDefined(tac_origin)) {
      demeanor = asm_getdemeanor();
      cancrouch = self isstanceallowed("crouch") && demeanor == "combat";

      if(cancrouch && choosecrouchorstandtac(self, tac_origin)) {
        return "Exposed Crouch";
      }

      return "Exposed";
    }

    if(bb_getrequestedstance() == "crouch" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    }

    return "Exposed";
  }

  if(isDefined(self.enemy) && self iscoverinvalidagainstenemy(node) || shouldinitiallyattackfromexposed(node)) {
    if(node doesnodeallowstance("stand") && self isstanceallowed("stand")) {
      return "Exposed";
    } else if(node doesnodeallowstance("crouch") && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    } else {
      return "Cover Prone";
    }
  }

  if(isnode(node) && node iscovermultinode()) {
    var_bc81741e5658c761 = getbestcovermultinodetype(node);

    if(isDefined(var_bc81741e5658c761) && var_bc81741e5658c761 != node.type) {
      node setcovermultinodetype(var_bc81741e5658c761);
    }
  }

  nodetype = node.type;
  lmg = scripts\asm\shared\utility::allowlmgarrival();

  if(lmg) {
    switch (nodetype) {
      case #"hash_c051a32186a33cae":
      case #"hash_c3b74422dec48736":
        return "Cover Crouch LMG";
      case #"hash_78b110033ccb68b0":
        return "Cover Stand LMG";
    }
  }

  if(isDefined(self._blackboard.croucharrivaltype) && !lmg) {
    return self._blackboard.croucharrivaltype;
  }

  return self choosearrivaltype(node, nodetype);
}

function shouldstrafe(asmname, statename, tostatename, params) {
  return bb_moverequested() && !self.facemotion && self.allowstrafe;
}

function shouldabortstrafe(asmname, statename, tostatename, params) {
  if(!shouldstrafe(asmname, statename, tostatename, params)) {
    return true;
  }

  if(!bb_movetyperequested("combat")) {
    return true;
  }

  if(bb_meleechargerequested()) {
    return true;
  }

  return false;
}

function chooseanimmovetype(asmname, statename, params) {
  demeanor = asm_getdemeanor();

  if(!asm_hasalias(statename, demeanor)) {
    return asm_chooseanim(asmname, statename, params);
  }

  return asm_lookupanimfromalias(statename, demeanor);
}

function transition_isflashed(asmname, statename, tostatename, params) {
  return isflashed();
}

function transition_isstunned(asmname, statename, tostatename, params) {
  return isstunned();
}

function transition_isburning(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.isburning) && !istrue(self.damageshield);
}

function function_5129b58498c1a96f(asmname, statename, tostatename, params) {
  return isDefined(self._blackboard.lastpopuptime) && gettime() - self._blackboard.lastpopuptime < 100;
}

function shouldreacttolight(asmname, statename, tostatename, params) {
  if(isDefined(self.lightreaction_requesttime) && self.lightreaction_requesttime >= gettime() - 1000) {
    archetype = self getbasearchetype();

    if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
      return true;
    }
  }

  return false;
}

function chooselightreactionanim(asmname, statename, params) {
  direction = "center";

  if(!isDefined(self.lightreaction_lightorigin)) {
    return asm_lookupanimfromalias(statename, direction);
  }

  if(isDefined(self.covernode)) {
    myright = anglestoright(self.covernode.angles);
    myforward = anglesToForward(self.covernode.angles);
    var_4a01d3a5d7389412 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  } else {
    myright = anglestoright(self.angles);
    myforward = anglesToForward(self.angles);
    var_4a01d3a5d7389412 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  }

  var_52809b82c18e7907 = vectordot(myright, var_4a01d3a5d7389412) >= 0;
  var_1e3ac8ad87f9f410 = vectordot(myforward, var_4a01d3a5d7389412);

  if(var_1e3ac8ad87f9f410 >= 0.866) {
    direction = "center";
  } else if(var_52809b82c18e7907) {
    direction = "right";
  } else {
    direction = "left";
  }

  return asm_lookupanimfromalias(statename, direction);
}

function isshocked(asmname, currentstate, var_caae90accdd1699c, params) {
  if(isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    return false;
  }

  if(isdamageweapon(makeweapon("emp"))) {
    return true;
  }

  if(self.unittype == "c6" || self.unittype == "c8") {
    if(isdamageweapon(makeweapon("iw7_sonic")) && isweaponepic(self.damageweapon)) {
      return true;
    }
  }

  if(isdamageweapon(makeweapon("iw7_atomizer")) && self.damagemod != "MOD_MELEE" && self.health <= 0) {
    return true;
  }

  return false;
}

function getdamagedirstring() {
  damagedir = -1 * self.damagedir;
  facingdir = anglesToForward(self.angles);
  dot = vectordot(facingdir, damagedir);

  if(dot > 0.707) {
    return "front";
  }

  if(dot < -0.707) {
    return "back";
  }

  cross = vectorcross(facingdir, damagedir);

  if(cross[2] > 0) {
    return "left";
  }

  return "right";
}

function gethumandamagedirstring() {
  damagedir = -1 * self.damagedir;
  facingdir = anglesToForward(self.angles);
  dot = vectordot(facingdir, damagedir);

  if(dot < -0.5) {
    return true;
  }

  return false;
}

function playanimandusegoalweight(asmname, statename, params) {
  self setuseanimgoalweight(0.2);
  asm_playanimstate(asmname, statename);
}

function animscriptedaction_terminate(asmname, statename, params) {
  self orientmode("face angle 3d", self.angles);
  self.gunposeoverride_internal = undefined;

  if(isDefined(self.lookatatrnode)) {
    var_ae4bd9db62367d96 = asm_getheadlookknobifexists();

    if(isDefined(var_ae4bd9db62367d96)) {
      self clearanim(var_ae4bd9db62367d96, 0.2);
      self.lookatatrnode = undefined;
    }
  }
}

function animsriptedactioncivilian_terminate(asmname, statename, params) {
  if(isDefined(self.lookatatrnode)) {
    var_ae4bd9db62367d96 = asm_getheadlookknobifexists();

    if(isDefined(var_ae4bd9db62367d96)) {
      self clearanim(var_ae4bd9db62367d96, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
    }
  }
}

function cleanupanimscriptedheadlook() {
  self.ht_on = undefined;
  lookatentity();
}

function animscriptedstartup(asmname, statename, params) {
  self.ht_on = undefined;
  self stoplookat();
}

function animscriptedcleanup(asmname, statename, params) {
  cleanupanimscriptedheadlook();
  self aisettargetspeed(self aigetdesiredspeed());
}

function animscriptedaction_cleanup(asmname, statename, params) {
  cleanupanimscriptedheadlook();
}

function disabledefaultfacialanims(bdisable) {
  if(!isDefined(self.headknob)) {
    self.headknob = asm_getxanim("knobs", asm_lookupanimfromalias("knobs", "head"));
  }

  if(!isDefined(bdisable) || bdisable) {
    setfacialstate("animscripted");

    if(isai(self)) {
      self setfacialindex("none");
    } else {
      setfacialindexfornonai("none");
    }

    return;
  }

  clearfacialstate("animscripted");
}

function setfacialindexfornonai(state) {
  states = [];
  states["none"] = 0;
  states["idle"] = 1;
  states["aim"] = 2;
  states["run"] = 3;
  states["pain"] = 4;
  states["death"] = 5;
  states["talk_lg"] = 6;
  states["talk_md"] = 7;
  states["talk_sm"] = 8;
  states["happy"] = 9;
  states["cheer"] = 10;
  states["scared"] = 11;
  states["angry"] = 12;
  states["gas_death"] = 13;
  assertex(isDefined(states[state]), "Unsupported facial state " + state);
  assert(!isai(self));
  assert(issp());
  self setcustomnodegameparameter("animtime", self getentitynumber());
  self setcustomnodegameparameterbyte("facialindex", states[state]);
  facialknob = asm_lookupanimfromalias("knobs", "head");

  if(state == "none") {
    self clearanim(asm_getxanim("knobs", facialknob), 0.2);
    return;
  }

  self setanim(asm_getxanim("knobs", facialknob), 1, 0.2, 1);
}

function function_ee3e5d584e317d35(state) {
  if(state == "none") {
    facialknob = asm_lookupanimfromalias("knobs", "head_fakeactor");
    self clearanim(asm_getxanim("knobs", facialknob), 0.2);
    return;
  }

  facialanimid = asm_lookupanimfromalias("facial_animation_fakeactor", state);

  if(!isDefined(facialanimid)) {
    iprintln("Missing facial: " + self.animsetname + " " + state);
  }

  facialxanim = asm_getxanim("facial_animation_fakeactor", facialanimid);
  self setanimknob(facialxanim, 1, 0.2);
}

function setfacialstate(state) {
  self.facialstate = state;
}

function clearfacialstate(state) {
  self.facialstate = "asm";

  if(!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim) {
    asm_restorefacialanim();
  }
}

function isfacialstateallowed(state) {
  if(!isai(self) && (!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim)) {
    return false;
  }

  if(!isDefined(self.facialstate)) {
    self.facialstate = "asm";
  }

  priorities = [];
  priorities["asm"] = 0;
  priorities["filler"] = 1;
  priorities["animscripted"] = 2;
  assertex(isDefined(priorities[state]), "Facial anim state " + state + " is invalid");

  if(priorities[state] >= priorities[self.facialstate]) {
    return true;
  }

  return false;
}

function decrementbulletsinclip() {
  if(self.bulletsinclip) {
    self.bulletsinclip--;
  }
}

function grenadelauncherfirerate() {
  return randomfloatrange(5, 8);
}

function shotgunfirerate() {
  if(weapon_pump_action_shotgun()) {
    return 1;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return (scripts\anim\weaponlist::autoshootanimrate() * 0.7);
  }

  return 0.4;
}

function melee_checktimer(unittype, checkplayer) {
  if(getdvarint(@ "hash_a36b45ede9e79a0a", 0) == 1) {
    return 1;
  }

  if(isDefined(self.meleeignoretimer) && self.meleeignoretimer) {
    return 1;
  }

  if(!isDefined(checkplayer)) {
    checkplayer = 0;
  }

  if(checkplayer) {
    if(!isDefined(anim.meleechargeplayertimers)) {
      return 1;
    }

    if(!isDefined(anim.meleechargeplayertimers[unittype])) {
      return 1;
    }

    return (gettime() > anim.meleechargeplayertimers[unittype]);
  }

  if(!isDefined(anim.meleechargetimers)) {
    return 1;
  }

  if(!isDefined(anim.meleechargetimers[unittype])) {
    return 1;
  }

  return gettime() > anim.meleechargetimers[unittype];
}

function setupsoldierdefaults() {
  curtime = gettime();
  self.laserenabled = 0;
  self.primaryweapon = self.weapon;
  self.agentname = &"MP/HOSTILE_SOLDIER";
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.dropweapon = 1;
  self.minexposedgrenadedist = 750;
  isally = !self isbadguy();
  self.a.lastenemytime = curtime;
  self.var_98add129a7ecb962 = !isally;
  self.a.paintime = 0;
  self.reacttobulletchance = 0.8;
  self._animactive = 0;
  self._lastanimtime = 0;
  self.misstime = 0;
  self.a.nodeath = 0;
  self.misstime = 0;
  self.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.battlechatter = spawnStruct();

  if(!issp()) {
    callback::add("on_ai_killed", &scripts\anim\battlechatter::function_d6731c6d074dc7d0);
  }

  self.chatinitialized = 0;
  self.defaultturnthreshold = 55;
  scripts\asm\shared\utility::setfacialstate("asm");
  self.speedscalemult = 0.95 + randomfloat(0.15);
  self.script_forcegrenade = 0;
  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;

  if(isally) {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0;
  }

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  self.var_20d73f2e5569b90f = 75;
}

function getspeedmatchanimrate(xanim, samplestart, sampleend) {
  assert(samplestart < sampleend);
  currentspeed = length(self.velocity);

  if(currentspeed < 1) {
    return 1;
  }

  animdist = length(getmovedelta(xanim, samplestart, sampleend));

  if(animdist < 1) {
    return 1;
  }

  animtime = getanimlength(xanim) * (sampleend - samplestart);
  animspeed = animdist / animtime;
  return currentspeed / animspeed;
}

function isentasoldier() {
  return self.unittype == "soldier" || self.unittype == "juggernaut";
}

function isentnotabomber() {
  return self.asmname != "suicidebomber" && self.asmname != "suicidebomber_cp";
}

function demeanorhasblendspace() {
  demeanor = asm_getdemeanor();
  return demeanor == "combat";
}

function isfixednodeinbadplaceandshouldcrouch() {
  if(self.fixednode && !isDefined(self.node) && isDefined(self.color_node) && self isnodeinbadplace(self.color_node) && self.color_node doesnodeallowstance("crouch")) {
    return true;
  }

  return false;
}

function gethighestallowedstance() {
  var_6e42e802f04ee4b6 = undefined;
  var_58b5e042653e4c9 = 1;
  var_1462639ed10c0aa5 = 1;
  var_fbc7d1fe7086d737 = 1;

  if(isDefined(self.node) && isatcovernode()) {
    var_58b5e042653e4c9 = self.node doesnodeallowstance("stand");
    var_1462639ed10c0aa5 = self.node doesnodeallowstance("crouch");
    var_fbc7d1fe7086d737 = self.node doesnodeallowstance("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    var_6e728f1543cfb7bf = self isstanceallowed("crouch");

    if(var_6e728f1543cfb7bf && isfixednodeinbadplaceandshouldcrouch()) {
      return "crouch";
    }

    var_1ffc686a2062eba7 = distancesquared(self.origin, self._blackboard.shootparams_pos);

    if(var_1ffc686a2062eba7 > 262144 && var_6e728f1543cfb7bf && !actor_is3d() && !isusingsidearm()) {
      var_6e728f1543cfb7bf = 1;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 16 && !self.node doesnodeallowstance("crouch")) {
        var_6e728f1543cfb7bf = abs(angleclamp180(self.node.angles[1] - self.angles[1])) > 90;
      }

      if(var_6e728f1543cfb7bf) {
        if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams_pos, 0, undefined)) {
          return "crouch";
        }
      }
    }
  }

  while(true) {
    if(self isstanceallowed("stand") && var_58b5e042653e4c9) {
      return "stand";
    }

    if(self isstanceallowed("crouch") && var_1462639ed10c0aa5) {
      return "crouch";
    }

    if(self isstanceallowed("prone") && var_fbc7d1fe7086d737) {
      return "prone";
    }

    if(!var_58b5e042653e4c9 || !var_1462639ed10c0aa5 || !var_fbc7d1fe7086d737) {
      var_58b5e042653e4c9 = 1;
      var_1462639ed10c0aa5 = 1;
      var_fbc7d1fe7086d737 = 1;
      continue;
    }

    break;
  }

  assertmsg("No stances allowed on actor - at least one stance must always be allowed");
  return "crouch";
}

function determinerequestedstance() {
  higheststance = gethighestallowedstance();
  requestedstance = bb_getrequestedstance();
  stances = [];
  stances["prone"] = 0;
  stances["crouch"] = 1;
  stances["stand"] = 2;
  demeanor = self getdemeanor();

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 1) {
    requestedstance = "stand";
  }

  if(self._blackboard.bgrenadereturnthrow) {
    requestedstance = "stand";
  }

  if(!isDefined(higheststance)) {
    higheststance = requestedstance;
  }

  if(demeanor == "casual" || demeanor == "casual_gun") {
    requestedstance = "stand";
  } else if(higheststance == "prone" && self.unittype == "c6") {
    requestedstance = "crouch";
  } else if(stances[higheststance] < stances[requestedstance]) {
    requestedstance = higheststance;
  } else if(requestedstance == "prone" && higheststance != requestedstance) {
    requestedstance = higheststance;
  } else if(requestedstance == "crouch" && stances[higheststance] > stances["crouch"]) {
    if(bb_isinbadcrouchspot()) {
      requestedstance = "stand";
    }
  }

  return requestedstance;
}

function function_87d74491d0318ba3(archetype) {
  if(isagent(self)) {
    return 1;
  }

  if(!isDefined(level.var_a34e5c8668851782)) {
    level.var_a34e5c8668851782 = [];
  }

  if(!isDefined(level.var_a34e5c8668851782[archetype])) {
    level.var_a34e5c8668851782[archetype] = 1;
    return 0;
  }

  return 1;
}

function function_d6919795e4b24d3a(asmname, statename, xanim, note) {
  if(!animhasnotetrack(xanim, note)) {
    print("<dev string:x1c>" + note + "<dev string:x64>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
    level.var_e941151b3a81c996 = 0;
  }
}

function function_37064c5f2a8f68ef(asmname, statename, xanim, note) {
  if(animhasnotetrack(xanim, note)) {
    print("<dev string:x81>" + note + "<dev string:x64>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
    level.var_e941151b3a81c996 = 0;
  }
}

function function_6893c43c1838f552(asmname, statename, xanim, note1, note2) {
  if(!animhasnotetrack(xanim, note1) || !animhasnotetrack(xanim, note2)) {
    return;
  }

  if(getnotetracktimes(xanim, note1)[0] >= getnotetracktimes(xanim, note2)[0]) {
    print("<dev string:xc9>" + note1 + "<dev string:x109>" + note2 + "<dev string:x64>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
    level.var_e941151b3a81c996 = 0;
  }
}

function function_3474c2003e05a5e0(asmname, statename, xanim, min_translation) {
  movedelta = getmovedelta(xanim);
  d = length(movedelta);

  if(d < min_translation) {
    println("<dev string:x121>" + min_translation + "<dev string:x172>" + asmname + "<dev string:x186>" + statename + "<dev string:x18e>");
    level.var_e941151b3a81c996 = 0;
    println("<dev string:x190>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x192>" + d);
  }
}

function function_481385c3b908b994(asmname, statename, xanim, max_translation) {
  stop_time = 1;

  if(animhasnotetrack(xanim, "<dev string:x19e>") || animhasnotetrack(xanim, "<dev string:x1a8>")) {
    var_ad9ba4beee7c6c8e = getnotetracktimes(xanim, "<dev string:x19e>");

    foreach(note in var_ad9ba4beee7c6c8e) {
      stop_time = min(stop_time, note);
    }

    finish_notes = getnotetracktimes(xanim, "<dev string:x1a8>");

    foreach(note in finish_notes) {
      stop_time = min(stop_time, note);
    }
  }

  movedelta = getmovedelta(xanim, 0, stop_time);
  d = length(movedelta);

  if(d > max_translation) {
    println("<dev string:x1af>" + max_translation + "<dev string:x172>" + asmname + "<dev string:x186>" + statename + "<dev string:x18e>");
    level.var_e941151b3a81c996 = 0;
    println("<dev string:x190>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x192>" + d);
  }
}

function function_7329f095ddbdb229(asmname, statename, xanim, notetrack, max_translation) {
  stop_time = 1;

  if(animhasnotetrack(xanim, "<dev string:x19e>")) {
    var_ad9ba4beee7c6c8e = getnotetracktimes(xanim, "<dev string:x19e>");

    if(var_ad9ba4beee7c6c8e.size != 1) {
      println("<dev string:x1ff>" + asmname + "<dev string:x186>" + statename + "<dev string:x248>" + function_3c8848a3a11b2553(getanimname(xanim)));
    }

    stop_time = var_ad9ba4beee7c6c8e[0];
  }

  if(animhasnotetrack(xanim, "<dev string:x1a8>")) {
    finish_notes = getnotetracktimes(xanim, "<dev string:x1a8>");

    if(finish_notes.size != 1) {
      println("<dev string:x24b>" + asmname + "<dev string:x186>" + statename + "<dev string:x248>" + function_3c8848a3a11b2553(getanimname(xanim)));
    }

    stop_time = min(stop_time, finish_notes[0]);
  }

  start_time = 0;

  if(animhasnotetrack(xanim, notetrack)) {
    notes = getnotetracktimes(xanim, notetrack);

    if(notes.size != 1) {
      println("<dev string:x291>" + notetrack + "<dev string:x2c1>" + asmname + "<dev string:x186>" + statename + "<dev string:x248>" + function_3c8848a3a11b2553(getanimname(xanim)));
    }

    start_time = notes[0];
  } else {
    return;
  }

  movedelta = getmovedelta(xanim, start_time, stop_time);
  d = length(movedelta);

  if(d > max_translation) {
    println("<dev string:x2d2>" + max_translation + "<dev string:x332>" + notetrack + "<dev string:x346>" + asmname + "<dev string:x186>" + statename + "<dev string:x18e>");
    level.var_e941151b3a81c996 = 0;
    println("<dev string:x190>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x192>" + d);
  }
}

function function_96b38b91937c6971(asmname, statename, note) {
  if(isagent(self)) {
    return;
  }

  xanims = asm_getallanimsforstate(statename);

  foreach(xanim in xanims) {
    function_d6919795e4b24d3a(asmname, statename, xanim, note);
  }
}

function function_2376c1e1ca3ac68e(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  xanims = asm_getallanimsforstate(statename);

  foreach(xanim in xanims) {
    function_481385c3b908b994(asmname, statename, xanim, 0.1);
  }
}

function function_6421e5a82688da9d(asmname, statename, tolerance) {
  if(isagent(self)) {
    return;
  }

  if(!isDefined(tolerance)) {
    tolerance = 8;
  }

  xanims = asm_getallanimsforstate(statename);

  foreach(xanim in xanims) {
    function_3474c2003e05a5e0(asmname, statename, xanim, tolerance);
  }
}

function function_fb8af5455aa10890(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  tolerance = 0.1;
  samplefrac = 0.1;
  xanims = asm_getallanimsforstate(statename);

  foreach(xanim in xanims) {
    t = 0;

    while(t < 1) {
      t = min(t + samplefrac, 1);
      movedelta = getmovedelta(xanim, 0, t);
      d = length(movedelta);

      if(d > tolerance) {
        println("<dev string:x358>" + asmname + "<dev string:x186>" + statename + "<dev string:x39c>" + tolerance + "<dev string:x18e>");
        level.var_e941151b3a81c996 = 0;
        println("<dev string:x190>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x192>" + d + "<dev string:x3a8>" + t);
        break;
      }
    }
  }
}

function function_e291a61d131cb535(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  if(!isDefined(aliases)) {
    println("<dev string:x3b2>" + self.animsetname + "<dev string:x186>" + statename + "<dev string:x18e>");
    return;
  }

  foreach(alias in aliases) {
    var_a401bfc2f3617031 = undefined;

    if(issubstr(alias, "<dev string:x3ea>")) {
      var_a401bfc2f3617031 = 1;
    } else if(issubstr(alias, "<dev string:x3ec>")) {
      var_a401bfc2f3617031 = 2;
    } else if(issubstr(alias, "<dev string:x3ee>")) {
      var_a401bfc2f3617031 = 3;
    } else if(issubstr(alias, "<dev string:x3f0>")) {
      var_a401bfc2f3617031 = 4;
    } else if(issubstr(alias, "<dev string:x3f2>")) {
      var_a401bfc2f3617031 = 5;
    } else if(issubstr(alias, "<dev string:x3f4>")) {
      var_a401bfc2f3617031 = 6;
    }

    if(isDefined(var_a401bfc2f3617031)) {
      organims = archetypegetalias(arc, statename, alias, 0);
      redanims = archetypegetalias(arc, statename, alias, 1);

      if(isarray(organims.anims)) {
        anims = organims.anims;
      } else {
        anims = [organims.anims];
      }

      if(isarray(redanims.anims)) {
        redanims = redanims.anims;
      } else {
        redanims = [redanims.anims];
      }

      xanims = scripts\engine\utility::array_combine_unique(anims, redanims);

      foreach(xanim in xanims) {
        shoottimes = getnotetracktimes(xanim, "<dev string:x3f6>");

        if(shoottimes.size < var_a401bfc2f3617031) {
          println("<dev string:x3fb>" + asmname + "<dev string:x186>" + statename + "<dev string:x18e>");
          level.var_e941151b3a81c996 = 0;
          println("<dev string:x43e>" + alias + "<dev string:x445>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x447>" + shoottimes.size + "<dev string:x452>" + var_a401bfc2f3617031);
        }
      }
    }
  }
}

function function_3668c851be298257(asmname, statename, params) {}

function function_e7680ae9c1ad905c(asmname, statename, params) {}

function function_291d962b22a07e21(asmname, statename, alias, xanim) {
  if(isagent(self)) {
    return;
  }

  if(issubstr(statename, "<dev string:x473>") && (issubstr(alias, "<dev string:x478>") || issubstr(alias, "<dev string:x47a>")) || issubstr(statename, "<dev string:x47c>") && (issubstr(alias, "<dev string:x482>") || issubstr(alias, "<dev string:x47a>"))) {
    function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x484>");
    function_6893c43c1838f552(asmname, statename, xanim, "<dev string:x484>", "<dev string:x19e>");
  }
}

function function_5ac3e08bd8b8783b(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_291d962b22a07e21(asmname, statename, alias, xanim);
        function_481385c3b908b994(asmname, statename, xanim, 85);
        function_3474c2003e05a5e0(asmname, statename, xanim, 16);
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x493>");
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4a3>");
        function_7329f095ddbdb229(asmname, statename, xanim, "<dev string:x4b1>", 1);
      }
    }
  }
}

function function_498119c92072487f(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_291d962b22a07e21(asmname, statename, alias, xanim);
        function_481385c3b908b994(asmname, statename, xanim, 85);
        function_3474c2003e05a5e0(asmname, statename, xanim, 16);
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x493>");
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4a3>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x4be>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x4c8>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x4db>");
      }
    }
  }
}

function function_9a500dc0cc17d6da(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);
  pistol_pickup = "<dev string:x4ec>";
  var_9232727e455493f7 = "<dev string:x4fa>";

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        if(!animhasnotetrack(xanim, "<dev string:x50f>") && !animhasnotetrack(xanim, "<dev string:x51a>") && !animhasnotetrack(xanim, "<dev string:x526>")) {
          print("<dev string:x535>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
          level.var_e941151b3a81c996 = 0;
        }

        if(!animhasnotetrack(xanim, "<dev string:x4ec>") && !animhasnotetrack(xanim, "<dev string:x4fa>")) {
          print("<dev string:x5c9>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
          level.var_e941151b3a81c996 = 0;
        }
      }
    }
  }
}

function function_5cfc0f7a00ff16ae(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_291d962b22a07e21(asmname, statename, alias, xanim);
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x19e>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x1a8>");
        function_6893c43c1838f552(asmname, statename, xanim, "<dev string:x19e>", "<dev string:x1a8>");
        function_481385c3b908b994(asmname, statename, xanim, 65);
        function_3474c2003e05a5e0(asmname, statename, xanim, 8);
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4c8>");
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4db>");
      }
    }
  }
}

function function_d63d29d0192b914(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x65b>");

        if(animhasnotetrack(xanim, "<dev string:x65b>")) {
          var_acfa015f21c55596 = 0.05 / max(getanimlength(xanim), 0.05);
          ragdoll_times = getnotetracktimes(xanim, "<dev string:x65b>");

          foreach(note in ragdoll_times) {
            if(note > var_acfa015f21c55596) {
              print("<dev string:x669>" + asmname + "<dev string:x6d>" + statename + "<dev string:x76>" + function_3c8848a3a11b2553(getanimname(xanim)) + "<dev string:x7e>");
              level.var_e941151b3a81c996 = 0;
            }
          }
        }
      }
    }
  }
}

function function_a61779d8c4b66cda(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x48b>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x484>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x19e>");
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x1a8>");
        function_6893c43c1838f552(asmname, statename, xanim, "<dev string:x19e>", "<dev string:x1a8>");
        function_481385c3b908b994(asmname, statename, xanim, 65);
        function_3474c2003e05a5e0(asmname, statename, xanim, 8);
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4c8>");
        function_37064c5f2a8f68ef(asmname, statename, xanim, "<dev string:x4db>");
      }
    }
  }
}

function function_a92ee440c129eb3b(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    if(issubstr(alias, "<dev string:x6be>")) {
      continue;
    }

    anims = asm_getallanimsforalias(arc, statename, alias);
    var_36eebb886bbddcca = !issubstr(alias, "<dev string:x6c2>");

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        if(var_36eebb886bbddcca) {
          function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x6ca>");
        }

        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x4be>");
      }
    }
  }
}

function function_7f7e506dee7aa8c2(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  assert(isDefined(self.animsetname));
  function_6421e5a82688da9d(asmname, statename, params);
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);

  foreach(alias in aliases) {
    anims = asm_getallanimsforalias(arc, statename, alias);

    if(isDefined(anims)) {
      foreach(xanim in anims) {
        function_291d962b22a07e21(asmname, statename, alias, xanim);
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x19e>");
      }
    }
  }
}

function mapangleindextonumpad(idx) {
  mapping = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return mapping[idx];
}

function toggle_poiauto(shouldenable, yawmin, yawmax, pitchmin, pitchmax) {
  if(shouldenable) {
    if(!isDefined(self.poiauto)) {
      poiauto_init(yawmin, yawmax, pitchmin, pitchmax);
      thread poiauto_think();
      scripts\common\ai::set_gunpose("disable");
    }

    return;
  }

  self notify("poiauto_disable");
  self.poiauto = undefined;
  self.var_7731804dd640d78d = 0;
  scripts\common\ai::set_gunpose("automatic");
  self stoplookat();
}

function set_poiauto_constraints(yawmax, yawmin, pitchmin, pitchmax) {
  assert(isDefined(self.poiauto));

  if(!isDefined(self.poiauto.og_yawmax)) {
    self.poiauto.og_yawmax = self.poiauto.yawmax;
  }

  if(!isDefined(self.poiauto.og_yawmin)) {
    self.poiauto.og_yawmin = self.poiauto.yawmin;
  }

  if(!isDefined(self.poiauto.og_pitchmin)) {
    self.poiauto.og_pitchmin = self.poiauto.pitchmin;
  }

  if(!isDefined(self.poiauto.og_pitchmax)) {
    self.poiauto.og_pitchmax = self.poiauto.pitchmax;
  }

  self.poiauto.yawmax = yawmax;
  self.poiauto.yawmin = yawmin;
  self.poiauto.pitchmin = pitchmin;
  self.poiauto.pitchmax = pitchmax;
}

function reset_poiauto_constraints() {
  assert(isDefined(self.og_yawmax));
  assert(isDefined(self.og_yawmin));
  assert(isDefined(self.og_pitchmin));
  assert(isDefined(self.og_pitchmax));
  self.poiauto.yawmax = self.poiauto.og_yawmax;
  self.poiauto.yawmin = self.poiauto.og_yawmin;
  self.poiauto.pitchmin = self.poiauto.og_pitchmin;
  self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

function toggle_poi(shouldenable, firstpoint) {
  assertex(shouldenable == 1 || shouldenable == 0, "shouldEnable needs to be either true or false");
  self.currentpoi = undefined;
  self.nextpoi = undefined;
  self.doingpoi = shouldenable;
  self.disablelookdownpath = shouldenable;

  if(isDefined(self.cqb_point_of_interest)) {
    self.cqb_point_of_interest = undefined;
    self function_f7d83c92f61dcc31(0);
  }

  if(!shouldenable) {
    assertex(isDefined(level.poi_activeai), "Can't disable from POI if POIs have never been enabled!!!!");
    level.poi_activeai = array_remove(level.poi_activeai, self);
    self.turnrate = ter_op(isDefined(self.poi_oldturnrate), self.poi_oldturnrate, self.turnrate);
    self.gunadditiveoverride = undefined;
    self.disablelookdownpath = undefined;
    self._blackboard.forcestrafe = 0;
    self.gunposeoverride = undefined;
    self stoplookat();
    return;
  }

  currentspeed = self aigetdesiredspeed();
  archetype = self getbasearchetype();
  var_1e5343d5beae9c26 = getanimspeedthreshold(archetype, "fast");
  self aisetdesiredspeed(min(currentspeed, var_1e5343d5beae9c26));

  if(!isDefined(level.poi_activeai)) {
    level.poi_activeai = [];
  }

  level.poi_activeai[level.poi_activeai.size] = self;

  if(isDefined(level.fnfindcqbpointsofinterest) && !istrue(level.alreadyfindingpoi)) {
    level thread[[level.fnfindcqbpointsofinterest]]();
    level.alreadyfindingpoi = 1;
  }

  assert(!isDefined(firstpoint) || isstruct(firstpoint));
  self.poi_oldturnrate = self.turnrate;
  self.turnrate = 0.25;
  self.leftaimlimit = 90;
  self.rightaimlimit = -90;
  self.poi_firstpoint = firstpoint;
  self.gunposeoverride = "disable";
}

function shouldinitiallyattackfromexposed(node) {
  return self._blackboard.shouldinitiallyattackfromexposed;
}

function cover_canattackfromexposed(enemyorigin, node) {
  assert(isDefined(self.enemy));

  if(!isPlayer(self.enemy) && !isai(self.enemy)) {
    return 1;
  }

  if(cover_canattackfromexposedcached()) {
    return cover_canattackfromexposedgetcache();
  }

  if(!isDefined(node)) {
    node = self.covernode;
  }

  if(!isDefined(node)) {
    node = self.node;
  }

  if(!isDefined(node)) {
    return 0;
  }

  higheststance = gethighestallowedstance();
  zheight = 56;

  if(higheststance != "stand") {
    zheight = 32;
  }

  startorigin = node.origin + (0, 0, zheight);

  if(!isDefined(enemyorigin)) {
    if(isai(self.enemy) && !isbot(self.enemy)) {
      enemyorigin = self.enemy getapproxeyepos();
    } else {
      enemyorigin = self.enemy getEye();
    }
  }

  var_d786be37f6c3bf95 = 1000;
  self._blackboard.canattackfromexposed = sighttracepassed(startorigin, enemyorigin, 0, undefined);
  self._blackboard.canattackfromexposedtime = gettime() + var_d786be37f6c3bf95;

  if(getdvarint(@ "hash_12099888645f099a")) {
    color = (1, 0, 0);

    if(self._blackboard.canattackfromexposed) {
      color = (0, 1, 0);
    }

    print3d(startorigin, "<dev string:x6d6>", color, 1, 1, 15);
    line(startorigin, enemyorigin, color, 1, 1, 15);
  }

  return self._blackboard.canattackfromexposed;
}

function cover_canattackfromexposedcached() {
  return isDefined(self._blackboard.canattackfromexposedtime) && self._blackboard.canattackfromexposedtime > gettime();
}

function cover_canattackfromexposedgetcache() {
  return self._blackboard.canattackfromexposed;
}

function poiauto_init(yawmin, yawmax, pitchmin, pitchmax) {
  if(!isDefined(yawmin)) {
    yawmin = 15;
  }

  if(!isDefined(yawmax)) {
    yawmax = 35;
  }

  if(!isDefined(pitchmin)) {
    pitchmin = -20;
  }

  if(!isDefined(pitchmax)) {
    pitchmax = 0;
  }

  self.poiauto = spawnStruct();
  self.poiauto.yawmax = yawmax;
  self.poiauto.yawmin = yawmin;
  self.poiauto.pitchmin = pitchmin;
  self.poiauto.pitchmax = pitchmax;
  self.var_7731804dd640d78d = 1;
}

function poiauto_think() {
  self endon("poiauto_disable");
  self endon("death");
  var_c2d5805bcd983331 = 500;
  var_5c9ae5533ed1462 = 0;
  var_4fc17a8ee1c0d087 = 0;
  var_46de370fcb18a1b0 = gettime() + 30000;

  if(!isDefined(self.poiauto)) {
    poiauto_init();
  }

  while(true) {
    secondaim = 0;

    if(var_46de370fcb18a1b0 <= gettime()) {
      self.poiauto_angles = (0, 0, 0);

      if(var_46de370fcb18a1b0 == var_5c9ae5533ed1462) {
        secondaim = 1;
      }
    }

    if(var_5c9ae5533ed1462 <= gettime()) {
      var_46de370fcb18a1b0 = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      var_4fc17a8ee1c0d087 = gettime();
      poiauto_setnewaimangle(secondaim);
      var_3080e8000aad4930 = var_c2d5805bcd983331 - gettime();
      var_37b7ec64d7b29bdb = var_46de370fcb18a1b0 - gettime();

      if(abs(var_37b7ec64d7b29bdb - var_3080e8000aad4930) >= 550 && cointoss()) {
        var_5c9ae5533ed1462 = var_46de370fcb18a1b0;
      } else if(var_3080e8000aad4930 > 3000) {
        var_5c9ae5533ed1462 = gettime() + randomintrange(2000, 3000);
      } else {
        var_5c9ae5533ed1462 = gettime() + var_3080e8000aad4930 + 550 + randomintrange(1000, 2000);
      }
    }

    waitframe();
  }
}

function poiauto_relativeangletopos(angles) {
  forward = anglesToForward(angles);
  worldforward = rotatevector(forward, self.angles);
  eye = self getapproxeyepos();
  pos = eye + worldforward * 128;
  return pos;
}

function poiauto_glancerandom() {
  yaw = randomfloatrange(-45, 45);
  pitch = randomfloatrange(-20, 20);
  pos = poiauto_relativeangletopos((pitch, yaw, 0));
  self.var_8ce6d9fc1435dd86 = 1;
  thread poiauto_glanceend();
  self glanceatpos(pos);
}

function poiauto_glanceend() {
  self notify("poiauto_glanceend");
  self endon("poiauto_glanceend");
  wait 0.55;
  self.var_8ce6d9fc1435dd86 = 0;
}

function poiauto_isglancing() {
  return istrue(self.var_8ce6d9fc1435dd86);
}

function poiauto_setnewaimangle(secondaim) {
  if(secondaim) {
    yaw = randomfloatrange(self.poiauto_angles[1] + 5, self.poiauto_angles[1] + 10);
    pitch = randomfloatrange(5, 10);

    if(cointoss()) {
      pitch *= -1;
    }

    pitch = self.poiauto_angles[0] + pitch;
  } else {
    poiauto = self.poiauto;
    yaw = randomfloatrange(poiauto.yawmin, poiauto.yawmax);
    pitch = randomfloatrange(poiauto.pitchmin, poiauto.pitchmax);
  }

  if(cointoss()) {
    yaw *= -1;
  }

  self.poiauto_nextangles = (pitch, yaw, 0);
  self.poiauto_nextaimtime = randomintrange(100, 300) + gettime();
}

function function_2285421dfc79c4d5() {
  arcname = undefined;

  if(isDefined(self.animationarchetype)) {
    arcname = self.animationarchetype;
  } else {
    arcname = self.animsetname;
  }

  return arcname;
}

function function_75996a8dac6970f2(range) {
  if(!isDefined(range)) {
    range = 1024;
  }

  if(issp()) {
    player = level.player;
  } else {
    [player] = sortbydistance(level.players, self.origin);
  }

  if(self isnearanyplayer(range)) {
    lookpoint = player.origin + (0, 0, 55);
  } else {
    lookpoint = self.origin + (0, 0, 55) + anglesToForward(self.angles + (0, randomintrange(-135, 180), 0)) * 300;
  }

  return lookpoint;
}