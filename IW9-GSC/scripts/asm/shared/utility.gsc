/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\utility.gsc
***********************************************/

chooseanimshoot(asmname, statename, params) {
  _id_E592890E140B7FAA = params;
  alias = self._blackboard.shootstate + "_" + _id_E592890E140B7FAA;

  if(isDefined(self._blackboard.shootstate) && scripts\asm\asm::asm_hasalias(statename, alias))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);

  return scripts\asm\asm::asm_lookupanimfromalias(statename, params);
}

choosedemeanoranimwithoverride(asmname, statename, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(_id_F7EE87DC76B45E62, params)) {
    override = scripts\asm\asm::asm_getdemeanoranimoverride(_id_F7EE87DC76B45E62, params);

    if(isarray(override))
      return override[randomint(override.size)];

    return override;
  }

  if(!scripts\asm\asm::asm_hasalias(statename, _id_F7EE87DC76B45E62))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "default");

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_F7EE87DC76B45E62);
}

choosedemeanoranimwithoverridevariants(asmname, statename, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(_id_F7EE87DC76B45E62, params)) {
    override = scripts\asm\asm::asm_getdemeanoranimoverride(_id_F7EE87DC76B45E62, params);

    if(isarray(override))
      return override[randomint(override.size)];

    return override;
  }

  if(!scripts\asm\asm::asm_hasalias(statename, _id_F7EE87DC76B45E62)) {
    _id_D3EBB1FD79CBE1D2 = [];
    _id_D3EBB1FD79CBE1D2[0] = scripts\asm\asm::asm_lookupanimfromalias(statename, "trans_to_one_hand_run");
    _id_D3EBB1FD79CBE1D2[1] = scripts\asm\asm::asm_lookupanimfromalias(statename, "one_hand_run");
    _id_D3EBB1FD79CBE1D2[2] = scripts\asm\asm::asm_lookupanimfromalias(statename, "trans_to_two_hand_run");
    _id_D3EBB1FD79CBE1D2[3] = scripts\asm\asm::asm_lookupanimfromalias(statename, "two_hand_run");
    return _id_D3EBB1FD79CBE1D2;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_F7EE87DC76B45E62);
}

overridecovercrouchnodetype(node) {
  if(node.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype))
    return self._blackboard.croucharrivaltype;

  return node.type;
}

allowlmgarrival() {
  if(istrue(self.disablelmgmount))
    return 0;

  _id_E02DB7B70D9B56D9 = weaponclass(self.weapon) == "mg";

  if(_id_E02DB7B70D9B56D9) {
    if(!isDefined(self.node) || self.node isnodelmgmountable())
      return 1;

    return 0;
  }

  if(isDefined(self._blackboard.deployedlmgnode) && isDefined(self.node) && self.node == self._blackboard.deployedlmgnode && self.node isnodelmgmountable())
    return 1;

  return 0;
}

getnodeforwardyaw(node, _id_E7D9CB9558CB8470, _id_83CA7917EE6A88E8) {
  if(!isDefined(_id_83CA7917EE6A88E8))
    _id_83CA7917EE6A88E8 = 1;

  offset = self getnodeyawoffset(node, _id_E7D9CB9558CB8470, _id_83CA7917EE6A88E8);
  return node.angles[1] + offset;
}

nodeiscoverstand3dtype(node) {
  if(node.type == "Cover Stand 3D")
    return !nodeiscoverexposed3dtype(node);

  return 0;
}

nodeiscoverexposed3dtype(node) {
  if(node.type == "Cover Stand 3D") {
    if(isDefined(node.script_parameters) && node.script_parameters == "exposed")
      return 1;
  }

  return 0;
}

getnodetypename(node) {
  if(isDefined(node)) {
    if(nodeiscoverexposed3dtype(node))
      return "Cover Exposed 3D";
    else
      return node.type;
  }

  return "undefined";
}

choosestrongdamagedeath(asmname, statename, params) {
  alias = undefined;

  if(abs(self.damageyaw) > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot"))
      alias = "legs";
    else if(self.damagelocation == "torso_lower")
      alias = "torso_lower";
    else
      alias = "default";
  } else if(self.damageyaw < 0)
    alias = "right";
  else
    alias = "left";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

shouldleaveanimScripted(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  _id_C33B7D825B24A8BB = params;

  if(_id_C33B7D825B24A8BB) {
    if(self.a.movement == "stop")
      return 0;

    if(!scripts\asm\asm_bb::bb_moverequested())
      return 0;
  } else if(scripts\asm\asm_bb::bb_moverequested() && self.a.movement != "stop")
    return 0;

  return 1;
}

animscriptedaction(asmname, statename, params) {
  self endon(statename + "_finished");
  self.a.movement = "run";
  self.gunposeoverride_internal = "disable";
  animindex = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
  self aisetanim(statename, animindex);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

randomizepassthroughchildren(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_4826B510746869C3 = anim.asm[asmname].states[_id_F2B19B25D457C2A6];

  if(isDefined(_id_4826B510746869C3.transitions)) {
    if(_id_4826B510746869C3.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        temp = _id_4826B510746869C3.transitions[0];
        _id_4826B510746869C3.transitions[0] = _id_4826B510746869C3.transitions[1];
        _id_4826B510746869C3.transitions[1] = temp;
      }
    } else
      _id_4826B510746869C3.transitions = scripts\engine\utility::array_randomize(_id_4826B510746869C3.transitions);
  }

  return 1;
}

nodeshouldfaceangles(node) {
  if(!isDefined(node))
    return 0;

  if(isDefined(node.angles))
    return 1;

  if(isstruct(node))
    return 0;

  return isDefined(node.type) && node.type != "Path" && !scripts\engine\utility::isnodeexposed3d(node);
}

choosecrouchorstand(guy, node) {
  return int(node.origin[0] + node.origin[1] + node.origin[2] + guy getentitynumber()) % 2;
}

choosecrouchorstandtac(guy, _id_8E98A1B3E95386A5) {
  return int(abs(_id_8E98A1B3E95386A5[0] + _id_8E98A1B3E95386A5[1] + _id_8E98A1B3E95386A5[2] + guy getentitynumber())) % 2;
}

getarrivalnode() {
  if(istrue(self.leavecasualkiller))
    return undefined;

  if(isDefined(self.scriptedarrivalent) && !self btgoalvalid())
    return self.scriptedarrivalent;

  if(isDefined(self.node))
    return self.node;

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36)
    return self.prevnode;

  if(isDefined(self.last_set_goalnode))
    return self.last_set_goalnode;

  return self.last_set_goalent;
}

isarrivaltypecivilian(asmname, _id_8695DC19EF4C8376) {
  if(isDefined(self._id_A57082FDF62BC898))
    return _id_8695DC19EF4C8376 == "Custom";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return _id_8695DC19EF4C8376 == "Exposed";

  node = getarrivalnode();

  if(isDefined(node) && isnode(node) && node iscovermultinode()) {
    _id_BC81741E5658C761 = scripts\engine\utility::getbestcovermultinodetype(node);

    if(isDefined(_id_BC81741E5658C761))
      node setcovermultinodetype(_id_BC81741E5658C761);
  }

  if(!isDefined(node) || !isDefined(node.type) || node.type == "struct" || self.combatmode == "no_cover")
    return _id_8695DC19EF4C8376 == "Exposed";

  if(isDefined(node) && node.type == "Cover Crouch") {
    _id_15604D8704252FC4 = getDvar("dvar_F72DDE9792B94CC9");

    if(_id_15604D8704252FC4 != "")
      return _id_8695DC19EF4C8376 == _id_15604D8704252FC4;

    if(isDefined(self._blackboard.croucharrivaltype))
      return _id_8695DC19EF4C8376 == self._blackboard.croucharrivaltype;
    else if(isDefined(node.covercrouchtype))
      return _id_8695DC19EF4C8376 == node.covercrouchtype;
  }

  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();
  _id_775BD34DFD0C192F = (!isnode(node) || node doesnodeallowstance("stand")) && self isstanceallowed("stand");
  _id_2030158F5EB8B187 = (!isnode(node) || node doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && _id_F7EE87DC76B45E62 != "casual" && _id_F7EE87DC76B45E62 != "casual_gun";

  switch (_id_8695DC19EF4C8376) {
    case "Exposed":
      if(node.type != "Path" && node.type != "Exposed")
        return 0;

      if(_id_2030158F5EB8B187 && choosecrouchorstand(self, node))
        return 0;

      return _id_775BD34DFD0C192F;
    case "Exposed Crouch":
      if(node.type != "Path" && node.type != "Exposed")
        return 0;

      if(_id_775BD34DFD0C192F && !choosecrouchorstand(self, node))
        return 0;

      return _id_2030158F5EB8B187;
    case "Cover Crouch":
      return node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window" || node.type == "Cover Stand" || node.type == "Conceal Stand" || node.type == "Cover Prone" || node.type == "Conceal Prone";
    case "Cover Left":
      return node.type == "Cover Left";
    case "Cover Right":
      return node.type == "Cover Right";
    case "Exposed Moving":
      return node.type == "Exposed Moving";
  }

  return _id_8695DC19EF4C8376 == node.type;
}

isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_8695DC19EF4C8376 = params;

  if(isDefined(self._id_A57082FDF62BC898))
    return _id_8695DC19EF4C8376 == "Custom";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return _id_8695DC19EF4C8376 == "Exposed";

  node = getarrivalnode();

  if(isDefined(node) && isnode(node) && node iscovermultinode()) {
    _id_BC81741E5658C761 = scripts\engine\utility::getbestcovermultinodetype(node);

    if(isDefined(_id_BC81741E5658C761) && node.type != _id_BC81741E5658C761 && _id_8695DC19EF4C8376 == _id_BC81741E5658C761)
      node setcovermultinodetype(_id_BC81741E5658C761);
  }

  if(!isDefined(node) || !isDefined(node.type) || node.type == "struct" || self.combatmode == "no_cover") {
    if(scripts\engine\utility::actor_is3d())
      return _id_8695DC19EF4C8376 == "Exposed 3D";
    else
      return _id_8695DC19EF4C8376 == "Exposed";
  }

  _id_47175B042B5B15BB = allowlmgarrival();

  if(isDefined(node) && node.type == "Cover Crouch" && !_id_47175B042B5B15BB) {
    _id_15604D8704252FC4 = getDvar("dvar_F72DDE9792B94CC9");

    if(_id_15604D8704252FC4 != "")
      return _id_8695DC19EF4C8376 == _id_15604D8704252FC4;

    if(isDefined(self._blackboard.croucharrivaltype))
      return _id_8695DC19EF4C8376 == self._blackboard.croucharrivaltype;
    else if(isDefined(node.covercrouchtype))
      return _id_8695DC19EF4C8376 == node.covercrouchtype;
  }

  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();
  _id_775BD34DFD0C192F = (!isnode(node) || node doesnodeallowstance("stand")) && self isstanceallowed("stand");
  _id_2030158F5EB8B187 = (!isnode(node) || node doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && _id_F7EE87DC76B45E62 != "casual" && _id_F7EE87DC76B45E62 != "casual_gun";

  if(asmname == "zero_gravity_space") {
    switch (_id_8695DC19EF4C8376) {
      case "Exposed 3D":
        return scripts\engine\utility::isnodeexposed3d(node) && _id_775BD34DFD0C192F;
      case "Cover 3D":
        return node.type == "Cover 3D";
      case "Cover Stand 3D":
        return nodeiscoverstand3dtype(node);
      case "Cover Exposed 3D":
        return nodeiscoverexposed3dtype(node);
      case "Exposed Crouch":
      case "Cover Prone":
      case "Exposed":
      case "Path":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
      case "Cover Crouch":
        break;
    }
  } else if(asmname == "zero_gravity") {
    switch (_id_8695DC19EF4C8376) {
      case "Exposed":
        return (node.type == "Path" || node.type == "Exposed") && _id_775BD34DFD0C192F;
      case "Exposed Crouch":
        return (node.type == "Path" || node.type == "Exposed") && _id_2030158F5EB8B187;
      case "Cover Crouch":
        return node.type == "Cover Crouch" || node.type == "Conceal Crouch";
      case "Cover Stand":
        return node.type == "Cover Stand" || node.type == "Conceal Stand";
      case "Cover Prone":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
        break;
    }
  } else {
    switch (_id_8695DC19EF4C8376) {
      case "Exposed":
        if(node.type != "Path" && node.type != "Exposed")
          return 0;

        if(_id_2030158F5EB8B187 && choosecrouchorstand(self, node))
          return 0;

        return _id_775BD34DFD0C192F;
      case "Exposed Crouch":
        if(node.type != "Path" && node.type != "Exposed")
          return 0;

        if(_id_775BD34DFD0C192F && !choosecrouchorstand(self, node))
          return 0;

        return _id_2030158F5EB8B187;
      case "Cover Crouch":
        return node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window";
      case "Cover Stand":
        return node.type == "Cover Stand" || node.type == "Conceal Stand";
      case "Cover Prone":
        return node.type == "Cover Prone" || node.type == "Conceal Prone";
      case "Cover Left":
        if(node.type != "Cover Left")
          return 0;

        if(_id_2030158F5EB8B187 && choosecrouchorstand(self, node))
          return 0;

        return _id_775BD34DFD0C192F;
      case "Cover Left Crouch":
        if(node.type != "Cover Left")
          return 0;

        if(_id_775BD34DFD0C192F && !choosecrouchorstand(self, node))
          return 0;

        return _id_2030158F5EB8B187;
      case "Cover Right":
        if(node.type != "Cover Right")
          return 0;

        if(_id_2030158F5EB8B187 && choosecrouchorstand(self, node))
          return 0;

        return _id_775BD34DFD0C192F;
      case "Cover Right Crouch":
        if(node.type != "Cover Right")
          return 0;

        if(_id_775BD34DFD0C192F && !choosecrouchorstand(self, node))
          return 0;

        return _id_2030158F5EB8B187;
      case "Cover Crouch LMG":
        return (node.type == "Cover Crouch" || node.type == "Cover Prone") && allowlmgarrival();
      case "Cover Stand LMG":
        return node.type == "Cover Stand" && allowlmgarrival();
      case "Exposed Moving":
        return node.type == "Exposed Moving";
    }
  }

  return _id_8695DC19EF4C8376 == node.type;
}

playmoveloop(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 0;
  rate = 1.0;
  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, rate, 1);
}

playmoveloopcasual(asmname, statename, params) {
  playmoveloop(asmname, statename, params);
}

playanimwithdooropen(asmname, statename, params) {
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 1;
  playanim(asmname, statename, params);
}

playmoveloopcasualcleanup(asmname, statename, params) {}

calcdooropenspeed() {
  if(scripts\common\utility::iscp())
    return 0.8;

  t = 0.75;
  speed = length(self.velocity);

  if(speed > 0)
    t = 24 / speed;

  if(t < 0.15)
    t = 0.15;
  else if(t > 1)
    t = 1;

  return t;
}

opendooratreasonabletime() {
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
  _id_F195BAD2134DB294 = distance2dsquared(doorcenter, self.origin);
  _id_9F24038FD2E04755 = 5476;

  if(!scripts\common\utility::issp()) {
    _id_B2C29E3FBA2E1D31 = 0.8 * length(self.velocity);
    _id_B2C29E3FBA2E1D31 = _id_B2C29E3FBA2E1D31 * 0.9;
    _id_9F24038FD2E04755 = max(_id_B2C29E3FBA2E1D31 * _id_B2C29E3FBA2E1D31, _id_9F24038FD2E04755);
  }

  while(_id_F195BAD2134DB294 > _id_9F24038FD2E04755) {
    if(isDefined(self._blackboard.doortoopen) && door != self._blackboard.doortoopen) {
      return;
    }
    waitframe();
    _id_F195BAD2134DB294 = distance2dsquared(doorcenter, self.origin);
  }

  t = calcdooropenspeed();
  self notify("opening_door");
  self thread[[fndooropen]](door, t);
  return t;
}

opendooratreasonabletime_waitforabort(statename) {
  self endon("opening_door_done");
  self waittill(statename + "_finished");

  if(!isalive(self)) {
    return;
  }
  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = 0;
  self notify("opening_door_done");
}

closedoorifnecessary(door) {
  if(self[[self.fndoorneedstoclose]](door))
    self[[self.fndoorclose]](door);
}

_id_B6A072E9E59FB82E(asmname, statename, _id_D6E02014CB6C5B06) {
  self endon(statename + "_finished");
  self endon("death");

  if(isDefined(self._blackboard.doortoopen)) {
    _id_EB8EA5FEF7306D32 = _id_7E553EA72AE6828A();

    if(_id_EB8EA5FEF7306D32)
      self._blackboard.doortoopen = undefined;
    else {
      _id_0B09E54CA84B4AF9 = 0;

      if(!self.facemotion)
        _id_0B09E54CA84B4AF9 = _id_FF35AEF6AED32425(statename);

      if(!_id_0B09E54CA84B4AF9)
        _id_4D06CCC14A583480(asmname, statename, _id_D6E02014CB6C5B06);
    }
  }
}

_id_7E553EA72AE6828A() {
  _id_EB8EA5FEF7306D32 = 0;

  if(self[[self.fndooralreadyopen]](self._blackboard.doortoopen))
    _id_EB8EA5FEF7306D32 = 1;

  if(!_id_EB8EA5FEF7306D32 && !isent(self._blackboard.doortoopen)) {
    if(!isDefined(self getmodifierlocationonpath("door", 200)))
      _id_EB8EA5FEF7306D32 = 1;
  }

  return _id_EB8EA5FEF7306D32;
}

_id_FF35AEF6AED32425(statename) {
  self endon(statename + "_finished");
  self endon("death");
  _id_0B09E54CA84B4AF9 = 0;
  lookaheaddir = self.lookaheaddir;
  lookaheaddir = vectorNormalize((lookaheaddir[0], lookaheaddir[1], 0));
  _id_E54272533AB42FD2 = anglesToForward(self.angles);

  if(vectordot(lookaheaddir, _id_E54272533AB42FD2) < 0.966) {
    self.isopeningdoor = 1;
    thread _id_4DD19BFD2EE610F1(statename);
    t = opendooratreasonabletime();

    if(isDefined(t)) {
      thread opendooratreasonabletime_waitforabort(statename);
      wait(t);
    }

    self notify("opening_door_done");
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = 0;
    _id_0B09E54CA84B4AF9 = 1;
  }

  return _id_0B09E54CA84B4AF9;
}

_id_4D06CCC14A583480(asmname, statename, _id_D6E02014CB6C5B06) {
  self endon(statename + "_finished");
  self endon("death");
  door = self._blackboard.doortoopen;
  self._blackboard.door_opened = undefined;
  _id_36EFFA6A4B76959F = 1;
  _id_E3897A292B9511DD = 160;
  _id_CCD231D7C8137213 = 2;
  _id_543020482C67892F = length2d(self.velocity);

  if(!istrue(_id_D6E02014CB6C5B06)) {
    _id_09DB8509018BBB8A = _id_20962146E1A2E0DD(statename, _id_543020482C67892F);

    if(isDefined(_id_09DB8509018BBB8A[1]))
      _id_E3897A292B9511DD = _id_E183019DCEA5B774(_id_09DB8509018BBB8A[0], _id_09DB8509018BBB8A[1], _id_543020482C67892F);
    else
      _id_D6E02014CB6C5B06 = 1;
  }

  _id_76C751E661FC569F = _id_36EFFA6A4B76959F + _id_E3897A292B9511DD + _id_CCD231D7C8137213;
  doorcenter = self[[self.fngetdoorcenter]](door);
  _id_8A2D1A3F463DFFAC = distance2d(doorcenter, self.origin);

  if(_id_8A2D1A3F463DFFAC < _id_76C751E661FC569F) {
    self.isopeningdoor = 1;
    thread closedoorifnecessary(door);
    _id_382AB682AA991089 = 5;

    if(istrue(_id_D6E02014CB6C5B06))
      _id_382AB682AA991089 = 2;

    if(istrue(_id_D6E02014CB6C5B06) || _id_8A2D1A3F463DFFAC < _id_76C751E661FC569F - _id_543020482C67892F * _id_382AB682AA991089 * level.framedurationseconds) {
      thread _id_4DD19BFD2EE610F1(statename);
      t = opendooratreasonabletime();

      if(isDefined(t)) {
        thread opendooratreasonabletime_waitforabort(statename);
        wait(t);
      }

      self notify("opening_door_done");
      self._blackboard.doortoopen = undefined;
      self.isopeningdoor = 0;
    } else {
      self setupdooropen(door, _id_76C751E661FC569F, getdooropenspeedlookup());
      thread handledooropennotetrack(asmname, statename);
      thread handledooropenterminate(asmname, statename);
      self waittill("opening_door_done");
    }
  }
}

_id_E183019DCEA5B774(doorstate, _id_60CAA01062501FDC, _id_543020482C67892F) {
  _id_9605CBCCA5366F66 = scripts\asm\asm::asm_getxanim(doorstate, _id_60CAA01062501FDC);
  _id_9F5284E7925797FD = getnotetracktimes(_id_9605CBCCA5366F66, "door_touch");
  _id_EB1C18BB49D8770C = (_id_9F5284E7925797FD[0] * getanimlength(_id_9605CBCCA5366F66) + 3 * level.framedurationseconds) * _id_543020482C67892F;
  _id_E3897A292B9511DD = _id_EB1C18BB49D8770C + 24;
  return _id_E3897A292B9511DD;
}

_id_20962146E1A2E0DD(statename, _id_543020482C67892F) {
  doorstate = statename;
  _id_7F980E69DEF745B8 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, "2");

  if(!isDefined(_id_7F980E69DEF745B8)) {
    _id_543020482C67892F = self aigettargetspeed();
    _id_8707D88B63F131D1 = getnearestspeedthresholdname(self.basearchetype, _id_543020482C67892F);

    if(isDefined(_id_8707D88B63F131D1)) {
      _id_D6CF89A3E47ADA1F = _id_8707D88B63F131D1 + "2";
      _id_7F980E69DEF745B8 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, _id_D6CF89A3E47ADA1F);

      if(!isDefined(_id_7F980E69DEF745B8)) {
        doorstate = "door_open";
        _id_7F980E69DEF745B8 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", _id_D6CF89A3E47ADA1F);
      }
    }
  }

  if(!isDefined(_id_7F980E69DEF745B8))
    _id_7F980E69DEF745B8 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", "2");

  return [doorstate, _id_7F980E69DEF745B8];
}

handledooropennotetrack(asmname, statename) {
  self endon(statename + "_finished");
  self endon("opening_door_done");

  for(;;) {
    self waittill("door_open", notes);

    if(!isarray(notes))
      notes = [notes];

    for(_id_E30613A25CEF86A4 = 0; _id_E30613A25CEF86A4 < notes.size; _id_E30613A25CEF86A4++) {
      if(notes[_id_E30613A25CEF86A4] == "door_open") {
        if(isDefined(self.fndooropen) && isDefined(self._blackboard.doortoopen)) {
          self notify("opening_door");
          t = calcdooropenspeed();
          self thread[[self.fndooropen]](self._blackboard.doortoopen, t);
          self._blackboard.door_opened = 1;
        }

        continue;
      }

      if(notes[_id_E30613A25CEF86A4] == "end") {
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = 0;
        self cleardooropen();
        self notify("opening_door_done");
      }
    }

    waitframe();
  }
}

handledooropenterminate(asmname, statename) {
  self endon("opening_door_done");
  self waittill(statename + "_finished");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!istrue(self._blackboard.door_opened))
    thread opendooratreasonabletime();

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = 0;
  self cleardooropen();
}

_id_4DD19BFD2EE610F1(statename) {
  self endon("opening_door_done");
  self endon("death");
  _id_CEAF8D53BC34C60D = statename + "_finished";
  msg = scripts\engine\utility::waittill_any_return_2(_id_CEAF8D53BC34C60D, "opening_door");

  if(msg == _id_CEAF8D53BC34C60D)
    self.isopeningdoor = 0;
}

getdooropenspeedlookup() {
  if(self._id_AE3EA15396B65C1F == "civilian_panic")
    return "civilian_panic";
  else if(self.unittype == "civilian")
    return "civilian";
  else if(self._id_AE3EA15396B65C1F == "juggernaut")
    return "soldier";
  else
    return "soldier";
}

playanim(asmname, statename, params) {
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

playanimwithsound(asmname, statename, params) {
  self playSound(params);
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}

loopanim(asmname, statename, params) {
  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1.0);
}

chooseanimidle(asmname, statename, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(_id_F7EE87DC76B45E62, "idle")) {
    override = scripts\asm\asm::asm_getdemeanoranimoverride(_id_F7EE87DC76B45E62, "idle");

    if(isarray(override))
      return override[randomint(override.size)];

    return override;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over"))
      params = params + "_high";
  }

  return chooseanim_weaponclassprepended(asmname, statename, params);
}

chooseanim_weaponclassprepended(asmname, statename, params) {
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  alias = undefined;

  if(!isDefined(params))
    return scripts\asm\asm::asm_getrandomanim(asmname, statename);
  else
    alias = params;

  if(!scripts\asm\asm::asm_hasalias(statename, _id_0DD6BF5F9DBA888C + alias))
    _id_0DD6BF5F9DBA888C = "rifle";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_0DD6BF5F9DBA888C + alias);
}

getarrivaltype() {
  if(isDefined(self._id_A57082FDF62BC898))
    return "Custom";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return "Exposed";

  node = getarrivalnode();

  if(!isDefined(node) || !isnode(node) || !isDefined(node.type) || node.type == "struct" || self.combatmode == "no_cover") {
    _id_D707FA69A5DAE9B6 = self getcovertacpoint();

    if(isDefined(_id_D707FA69A5DAE9B6)) {
      _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();
      _id_2030158F5EB8B187 = self isstanceallowed("crouch") && _id_F7EE87DC76B45E62 == "combat";

      if(_id_2030158F5EB8B187 && choosecrouchorstandtac(self, _id_D707FA69A5DAE9B6))
        return "Exposed Crouch";

      return "Exposed";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "crouch" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed("crouch"))
      return "Exposed Crouch";

    return "Exposed";
  }

  if(isDefined(self.enemy) && self iscoverinvalidagainstenemy(node) || shouldinitiallyattackfromexposed(node)) {
    if(node doesnodeallowstance("stand") && self isstanceallowed("stand"))
      return "Exposed";
    else if(node doesnodeallowstance("crouch") && self isstanceallowed("crouch"))
      return "Exposed Crouch";
    else
      return "Cover Prone";
  }

  if(isnode(node) && node iscovermultinode()) {
    _id_BC81741E5658C761 = scripts\engine\utility::getbestcovermultinodetype(node);

    if(isDefined(_id_BC81741E5658C761) && _id_BC81741E5658C761 != node.type)
      node setcovermultinodetype(_id_BC81741E5658C761);
  }

  nodetype = node.type;
  _id_47175B042B5B15BB = allowlmgarrival();

  if(_id_47175B042B5B15BB) {
    switch (nodetype) {
      case "Cover Prone":
      case "Cover Crouch":
        return "Cover Crouch LMG";
      case "Cover Stand":
        return "Cover Stand LMG";
    }
  }

  if(isDefined(self._blackboard.croucharrivaltype) && !_id_47175B042B5B15BB)
    return self._blackboard.croucharrivaltype;

  return self choosearrivaltype(node, nodetype);
}

shouldstrafe(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.facemotion && self.allowstrafe;
}

shouldabortstrafe(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!shouldstrafe(asmname, statename, _id_F2B19B25D457C2A6, params))
    return 1;

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat"))
    return 1;

  if(scripts\asm\asm_bb::bb_meleechargerequested())
    return 1;

  return 0;
}

chooseanimmovetype(asmname, statename, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(!scripts\asm\asm::asm_hasalias(statename, _id_F7EE87DC76B45E62))
    return scripts\asm\asm::asm_chooseanim(asmname, statename, params);

  return scripts\asm\asm::asm_lookupanimfromalias(statename, _id_F7EE87DC76B45E62);
}

transition_isflashed(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\engine\utility::isflashed();
}

transition_isburning(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self._blackboard.isburning) && !istrue(self.damageshield);
}

shouldreacttolight(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.lightreaction_requesttime) && self.lightreaction_requesttime >= gettime() - 1000) {
    archetype = self getbasearchetype();

    if(isspeedwithincqbrange(archetype, self aigetdesiredspeed()))
      return 1;
  }

  return 0;
}

chooselightreactionanim(asmname, statename, params) {
  direction = "center";

  if(!isDefined(self.lightreaction_lightorigin))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, direction);

  if(isDefined(self.covernode)) {
    _id_22A308B658761B73 = anglestoright(self.covernode.angles);
    _id_8D39B8AD31508804 = anglesToForward(self.covernode.angles);
    _id_4A01D3A5D7389412 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  } else {
    _id_22A308B658761B73 = anglestoright(self.angles);
    _id_8D39B8AD31508804 = anglesToForward(self.angles);
    _id_4A01D3A5D7389412 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  }

  _id_52809B82C18E7907 = vectordot(_id_22A308B658761B73, _id_4A01D3A5D7389412) >= 0;
  _id_1E3AC8AD87F9F410 = vectordot(_id_8D39B8AD31508804, _id_4A01D3A5D7389412);

  if(_id_1E3AC8AD87F9F410 >= 0.866)
    direction = "center";
  else if(_id_52809B82C18E7907)
    direction = "right";
  else
    direction = "left";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, direction);
}

isshocked(asmname, currentstate, _id_CAAE90ACCDD1699C, params) {
  if(isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT")
    return 0;

  if(scripts\common\utility::isdamageweapon(makeweapon("emp")))
    return 1;

  if(self.unittype == "c6" || self.unittype == "c8") {
    if(scripts\common\utility::isdamageweapon(makeweapon("iw7_sonic")) && scripts\common\utility::isweaponepic(self.damageweapon))
      return 1;
  }

  if(scripts\common\utility::isdamageweapon(makeweapon("iw7_atomizer")) && self.damagemod != "MOD_MELEE" && self.health <= 0)
    return 1;

  return 0;
}

getdamagedirstring() {
  damagedir = -1 * self.damagedir;
  _id_E54272533AB42FD2 = anglesToForward(self.angles);
  dot = vectordot(_id_E54272533AB42FD2, damagedir);

  if(dot > 0.707)
    return "front";
  else if(dot < -0.707)
    return "back";
  else {
    _id_775361D05A790917 = vectorcross(_id_E54272533AB42FD2, damagedir);

    if(_id_775361D05A790917[2] > 0)
      return "left";
    else
      return "right";
  }
}

gethumandamagedirstring() {
  damagedir = -1 * self.damagedir;
  _id_E54272533AB42FD2 = anglesToForward(self.angles);
  dot = vectordot(_id_E54272533AB42FD2, damagedir);

  if(dot < -0.5)
    return 1;

  return 0;
}

playanimandusegoalweight(asmname, statename, params) {
  self setuseanimgoalweight(0.2);
  scripts\asm\asm::asm_playanimstate(asmname, statename);
}

animscriptedaction_terminate(asmname, statename, params) {
  self orientmode("face angle 3d", self.angles);
  self.gunposeoverride_internal = undefined;

  if(isDefined(self.lookatatrnode)) {
    _id_AE4BD9DB62367D96 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(_id_AE4BD9DB62367D96)) {
      self clearanim(_id_AE4BD9DB62367D96, 0.2);
      self.lookatatrnode = undefined;
    }
  }
}

animsriptedactioncivilian_terminate(asmname, statename, params) {
  if(isDefined(self.lookatatrnode)) {
    _id_AE4BD9DB62367D96 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(_id_AE4BD9DB62367D96)) {
      self clearanim(_id_AE4BD9DB62367D96, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
    }
  }
}

cleanupanimscriptedheadlook() {
  self.ht_on = undefined;
  scripts\common\utility::lookatentity();
}

animscriptedstartup(asmname, statename, params) {
  self.ht_on = undefined;
  self stoplookat();
}

animscriptedcleanup(asmname, statename, params) {
  cleanupanimscriptedheadlook();
  self aisettargetspeed(self aigetdesiredspeed());
}

animscriptedaction_cleanup(asmname, statename, params) {
  cleanupanimscriptedheadlook();
}

disabledefaultfacialanims(_id_49F31E97FE6A3857) {
  if(!isDefined(self.headknob))
    self.headknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "head"));

  if(!isDefined(_id_49F31E97FE6A3857) || _id_49F31E97FE6A3857) {
    setfacialstate("animscripted");

    if(isai(self))
      self setfacialindex("none");
    else
      setfacialindexfornonai("none");
  } else
    clearfacialstate("animscripted");
}

setfacialindexfornonai(state) {
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
  self setcustomnodegameparameter("animtime", self getentitynumber());
  self setcustomnodegameparameterbyte("facialindex", states[state]);
  _id_7C2E7606FE2F4B3D = scripts\asm\asm::asm_lookupanimfromalias("knobs", "head");

  if(state == "none")
    self clearanim(scripts\asm\asm::asm_getxanim("knobs", _id_7C2E7606FE2F4B3D), 0.2);
  else
    self setanim(scripts\asm\asm::asm_getxanim("knobs", _id_7C2E7606FE2F4B3D), 1, 0.2, 1);
}

_id_EE3E5D584E317D35(state) {
  if(state == "none") {
    _id_7C2E7606FE2F4B3D = scripts\asm\asm::asm_lookupanimfromalias("knobs", "head_fakeactor");
    self clearanim(scripts\asm\asm::asm_getxanim("knobs", _id_7C2E7606FE2F4B3D), 0.2);
    return;
  }

  _id_0A8B3655415E2CD1 = scripts\asm\asm::asm_lookupanimfromalias("facial_animation_fakeactor", state);

  if(!isDefined(_id_0A8B3655415E2CD1))
    iprintln("Missing facial: " + self._id_AE3EA15396B65C1F + " " + state);

  _id_BC15003C3E2CD832 = scripts\asm\asm::asm_getxanim("facial_animation_fakeactor", _id_0A8B3655415E2CD1);
  self setanimknob(_id_BC15003C3E2CD832, 1.0, 0.2);
}

setfacialstate(state) {
  self.facialstate = state;
}

clearfacialstate(state) {
  self.facialstate = "asm";

  if(!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim)
    scripts\asm\asm::asm_restorefacialanim();
}

isfacialstateallowed(state) {
  if(!isai(self) && (!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim))
    return 0;

  if(!isDefined(self.facialstate))
    self.facialstate = "asm";

  _id_09162C9F5F3A9D89 = [];
  _id_09162C9F5F3A9D89["asm"] = 0;
  _id_09162C9F5F3A9D89["filler"] = 1;
  _id_09162C9F5F3A9D89["animscripted"] = 2;

  if(_id_09162C9F5F3A9D89[state] >= _id_09162C9F5F3A9D89[self.facialstate])
    return 1;

  return 0;
}

decrementbulletsinclip() {
  if(self.bulletsinclip)
    self.bulletsinclip--;
}

grenadelauncherfirerate() {
  return randomfloatrange(5, 8);
}

shotgunfirerate() {
  if(_id_2B79931B08683E0A::weapon_pump_action_shotgun())
    return 1.0;

  if(_id_76FF4BA096A6F8AA::usingautomaticweapon())
    return _id_76FF4BA096A6F8AA::autoshootanimrate() * 0.7;

  return 0.4;
}

melee_checktimer(unittype, checkplayer) {
  if(isDefined(self.meleeignoretimer) && self.meleeignoretimer)
    return 1;

  if(!isDefined(checkplayer))
    checkplayer = 0;

  if(checkplayer) {
    if(!isDefined(anim.meleechargeplayertimers))
      return 1;

    if(!isDefined(anim.meleechargeplayertimers[unittype]))
      return 1;

    return gettime() > anim.meleechargeplayertimers[unittype];
  } else {
    if(!isDefined(anim.meleechargetimers))
      return 1;

    if(!isDefined(anim.meleechargetimers[unittype]))
      return 1;

    return gettime() > anim.meleechargetimers[unittype];
  }
}

setupsoldierdefaults() {
  _id_6B7BEE46F2C6DA28 = gettime();
  self.a = spawnStruct();
  self._id_14070A5A0597BF51 = 0;
  self.primaryweapon = self.weapon;
  self.agentname = &"MP/HOSTILE_SOLDIER";
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.dropweapon = 1;
  self.minexposedgrenadedist = 750;
  isally = !self isbadguy();
  self.a.lastenemytime = _id_6B7BEE46F2C6DA28;
  self._id_98ADD129A7ECB962 = !isally;
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
  self.chatinitialized = 0;
  self.defaultturnthreshold = 55;
  setfacialstate("asm");
  self.speedscalemult = 0.95 + randomfloat(0.15);
  self.script_forcegrenade = 0;
  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;

  if(isally)
    self.suppressionthreshold = 0.5;
  else
    self.suppressionthreshold = 0.0;

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  self._id_20D73F2E5569B90F = 75;
}

getspeedmatchanimrate(xanim, _id_0FC5F278CD84BD79, _id_10C9A5D419C90668) {
  _id_2F10825BA72AADD1 = length(self.velocity);

  if(_id_2F10825BA72AADD1 < 1)
    return 1;

  _id_EB1C18BB49D8770C = length(getmovedelta(xanim, _id_0FC5F278CD84BD79, _id_10C9A5D419C90668));

  if(_id_EB1C18BB49D8770C < 1)
    return 1;

  _id_EB5B1F36E255152D = getanimlength(xanim) * (_id_10C9A5D419C90668 - _id_0FC5F278CD84BD79);
  _id_F9060DC3720A1B67 = _id_EB1C18BB49D8770C / _id_EB5B1F36E255152D;
  return _id_2F10825BA72AADD1 / _id_F9060DC3720A1B67;
}

isentasoldier() {
  return self.unittype == "soldier" || self.unittype == "juggernaut";
}

isentnotabomber() {
  return self.asmname != "suicidebomber" && self.asmname != "suicidebomber_cp";
}

demeanorhasblendspace() {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();
  return _id_F7EE87DC76B45E62 == "combat";
}

isfixednodeinbadplaceandshouldcrouch() {
  if(self.fixednode && !isDefined(self.node) && isDefined(self.color_node) && self isnodeinbadplace(self.color_node) && self.color_node doesnodeallowstance("crouch"))
    return 1;

  return 0;
}

gethighestallowedstance() {
  _id_6E42E802F04EE4B6 = undefined;
  _id_058B5E042653E4C9 = 1;
  _id_1462639ED10C0AA5 = 1;
  _id_FBC7D1FE7086D737 = 1;

  if(isDefined(self.node) && isatcovernode()) {
    _id_058B5E042653E4C9 = self.node doesnodeallowstance("stand");
    _id_1462639ED10C0AA5 = self.node doesnodeallowstance("crouch");
    _id_FBC7D1FE7086D737 = self.node doesnodeallowstance("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    _id_6E728F1543CFB7BF = self isstanceallowed("crouch");

    if(_id_6E728F1543CFB7BF && isfixednodeinbadplaceandshouldcrouch())
      return "crouch";

    _id_1FFC686A2062EBA7 = distancesquared(self.origin, self._blackboard.shootparams_pos);

    if(_id_1FFC686A2062EBA7 > 262144 && _id_6E728F1543CFB7BF && !scripts\engine\utility::actor_is3d() && !_id_2B79931B08683E0A::isusingsidearm()) {
      _id_6E728F1543CFB7BF = 1;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 16 && !self.node doesnodeallowstance("crouch"))
        _id_6E728F1543CFB7BF = abs(angleclamp180(self.node.angles[1] - self.angles[1])) > 90;

      if(_id_6E728F1543CFB7BF) {
        if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams_pos, 0, undefined))
          return "crouch";
      }
    }
  }

  for(;;) {
    if(self isstanceallowed("stand") && _id_058B5E042653E4C9)
      return "stand";

    if(self isstanceallowed("crouch") && _id_1462639ED10C0AA5)
      return "crouch";

    if(self isstanceallowed("prone") && _id_FBC7D1FE7086D737)
      return "prone";

    if(!_id_058B5E042653E4C9 || !_id_1462639ED10C0AA5 || !_id_FBC7D1FE7086D737) {
      _id_058B5E042653E4C9 = 1;
      _id_1462639ED10C0AA5 = 1;
      _id_FBC7D1FE7086D737 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

determinerequestedstance() {
  _id_BD986FF07780228F = gethighestallowedstance();
  _id_55372344A55A6D53 = scripts\asm\asm_bb::bb_getrequestedstance();
  _id_05730C0AA523383E = [];
  _id_05730C0AA523383E["prone"] = 0;
  _id_05730C0AA523383E["crouch"] = 1;
  _id_05730C0AA523383E["stand"] = 2;
  _id_F7EE87DC76B45E62 = self _meth_869F129F31D72088();

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 1)
    _id_55372344A55A6D53 = "stand";

  if(self._blackboard.bgrenadereturnthrow)
    _id_55372344A55A6D53 = "stand";

  if(!isDefined(_id_BD986FF07780228F))
    _id_BD986FF07780228F = _id_55372344A55A6D53;

  if(_id_F7EE87DC76B45E62 == "casual" || _id_F7EE87DC76B45E62 == "casual_gun")
    _id_55372344A55A6D53 = "stand";
  else if(_id_BD986FF07780228F == "prone" && self.unittype == "c6")
    _id_55372344A55A6D53 = "crouch";
  else if(_id_05730C0AA523383E[_id_BD986FF07780228F] < _id_05730C0AA523383E[_id_55372344A55A6D53])
    _id_55372344A55A6D53 = _id_BD986FF07780228F;
  else if(_id_55372344A55A6D53 == "prone" && _id_BD986FF07780228F != _id_55372344A55A6D53)
    _id_55372344A55A6D53 = _id_BD986FF07780228F;
  else if(_id_55372344A55A6D53 == "crouch" && _id_05730C0AA523383E[_id_BD986FF07780228F] > _id_05730C0AA523383E["crouch"]) {
    if(scripts\asm\asm_bb::bb_isinbadcrouchspot())
      _id_55372344A55A6D53 = "stand";
  }

  return _id_55372344A55A6D53;
}

mapangleindextonumpad(_id_FE8F7703F6313ED4) {
  _id_4DEB7ED1D648B9D1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return _id_4DEB7ED1D648B9D1[_id_FE8F7703F6313ED4];
}

toggle_poiauto(_id_F17895B3929D1BF5, yawmin, yawmax, pitchmin, pitchmax) {
  if(_id_F17895B3929D1BF5) {
    if(!isDefined(self.poiauto)) {
      poiauto_init(yawmin, yawmax, pitchmin, pitchmax);
      thread poiauto_think();
      scripts\common\ai::set_gunpose("disable");
    }
  } else {
    self notify("poiauto_disable");
    self.poiauto = undefined;
    self._id_7731804DD640D78D = 0;
    scripts\common\ai::set_gunpose("automatic");
    self stoplookat();
  }
}

set_poiauto_constraints(yawmax, yawmin, pitchmin, pitchmax) {
  if(!isDefined(self.poiauto.og_yawmax))
    self.poiauto.og_yawmax = self.poiauto.yawmax;

  if(!isDefined(self.poiauto.og_yawmin))
    self.poiauto.og_yawmin = self.poiauto.yawmin;

  if(!isDefined(self.poiauto.og_pitchmin))
    self.poiauto.og_pitchmin = self.poiauto.pitchmin;

  if(!isDefined(self.poiauto.og_pitchmax))
    self.poiauto.og_pitchmax = self.poiauto.pitchmax;

  self.poiauto.yawmax = yawmax;
  self.poiauto.yawmin = yawmin;
  self.poiauto.pitchmin = pitchmin;
  self.poiauto.pitchmax = pitchmax;
}

reset_poiauto_constraints() {
  self.poiauto.yawmax = self.poiauto.og_yawmax;
  self.poiauto.yawmin = self.poiauto.og_yawmin;
  self.poiauto.pitchmin = self.poiauto.og_pitchmin;
  self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

toggle_poi(_id_F17895B3929D1BF5, _id_78EDF29F47297091) {
  self.currentpoi = undefined;
  self.nextpoi = undefined;
  self.doingpoi = _id_F17895B3929D1BF5;
  self.disablelookdownpath = _id_F17895B3929D1BF5;

  if(isDefined(self.cqb_point_of_interest)) {
    self.cqb_point_of_interest = undefined;
    self _meth_F7D83C92F61DCC31(0);
  }

  if(!_id_F17895B3929D1BF5) {
    level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, self);
    self.turnrate = scripts\engine\utility::ter_op(isDefined(self.poi_oldturnrate), self.poi_oldturnrate, self.turnrate);
    self.gunadditiveoverride = undefined;
    self.disablelookdownpath = undefined;
    self._blackboard.forcestrafe = 0;
    self.gunposeoverride = undefined;
    self stoplookat();
  } else {
    _id_2F10825BA72AADD1 = self aigetdesiredspeed();
    archetype = self getbasearchetype();
    _id_1E5343D5BEAE9C26 = getanimspeedthreshold(archetype, "fast");
    self aisetdesiredspeed(min(_id_2F10825BA72AADD1, _id_1E5343D5BEAE9C26));

    if(!isDefined(level.poi_activeai))
      level.poi_activeai = [];

    level.poi_activeai[level.poi_activeai.size] = self;

    if(isDefined(level.fnfindcqbpointsofinterest) && !istrue(level.alreadyfindingpoi)) {
      level thread[[level.fnfindcqbpointsofinterest]]();
      level.alreadyfindingpoi = 1;
    }

    self.poi_oldturnrate = self.turnrate;
    self.turnrate = 0.25;
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.poi_firstpoint = _id_78EDF29F47297091;
    self.gunposeoverride = "disable";
  }
}

shouldinitiallyattackfromexposed(node) {
  return self._blackboard.shouldinitiallyattackfromexposed;
}

cover_canattackfromexposed(_id_BCD3907D1BEE5B81, node) {
  if(!isPlayer(self.enemy) && !isai(self.enemy))
    return 1;

  if(cover_canattackfromexposedcached())
    return cover_canattackfromexposedgetcache();

  if(!isDefined(node))
    node = self.covernode;

  if(!isDefined(node))
    node = self.node;

  if(!isDefined(node))
    return 0;

  _id_BD986FF07780228F = gethighestallowedstance();
  _id_639828DC8BAC6376 = 56;

  if(_id_BD986FF07780228F != "stand")
    _id_639828DC8BAC6376 = 32;

  startorigin = node.origin + (0, 0, _id_639828DC8BAC6376);

  if(!isDefined(_id_BCD3907D1BEE5B81)) {
    if(isai(self.enemy) && !isbot(self.enemy))
      _id_BCD3907D1BEE5B81 = self.enemy getapproxeyepos();
    else
      _id_BCD3907D1BEE5B81 = self.enemy getEye();
  }

  _id_D786BE37F6C3BF95 = 1000;
  self._blackboard.canattackfromexposed = sighttracepassed(startorigin, _id_BCD3907D1BEE5B81, 0, undefined);
  self._blackboard.canattackfromexposedtime = gettime() + _id_D786BE37F6C3BF95;
  return self._blackboard.canattackfromexposed;
}

cover_canattackfromexposedcached() {
  return isDefined(self._blackboard.canattackfromexposedtime) && self._blackboard.canattackfromexposedtime > gettime();
}

cover_canattackfromexposedgetcache() {
  return self._blackboard.canattackfromexposed;
}

poiauto_init(yawmin, yawmax, pitchmin, pitchmax) {
  if(!isDefined(yawmin))
    yawmin = 15;

  if(!isDefined(yawmax))
    yawmax = 35;

  if(!isDefined(pitchmin))
    pitchmin = -20;

  if(!isDefined(pitchmax))
    pitchmax = 0;

  self.poiauto = spawnStruct();
  self.poiauto.yawmax = yawmax;
  self.poiauto.yawmin = yawmin;
  self.poiauto.pitchmin = pitchmin;
  self.poiauto.pitchmax = pitchmax;
  self._id_7731804DD640D78D = 1;
}

poiauto_think() {
  self endon("poiauto_disable");
  self endon("death");
  _id_C2D5805BCD983331 = 500;
  _id_05C9AE5533ED1462 = 0;
  _id_4FC17A8EE1C0D087 = 0;
  _id_46DE370FCB18A1B0 = gettime() + 30000;

  if(!isDefined(self.poiauto))
    poiauto_init();

  for(;;) {
    _id_D74B916A1980D11A = 0;

    if(_id_46DE370FCB18A1B0 <= gettime()) {
      self.poiauto_angles = (0, 0, 0);

      if(_id_46DE370FCB18A1B0 == _id_05C9AE5533ED1462)
        _id_D74B916A1980D11A = 1;
    }

    if(_id_05C9AE5533ED1462 <= gettime()) {
      _id_46DE370FCB18A1B0 = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      _id_4FC17A8EE1C0D087 = gettime();
      poiauto_setnewaimangle(_id_D74B916A1980D11A);
      _id_3080E8000AAD4930 = _id_C2D5805BCD983331 - gettime();
      _id_37B7EC64D7B29BDB = _id_46DE370FCB18A1B0 - gettime();

      if(abs(_id_37B7EC64D7B29BDB - _id_3080E8000AAD4930) >= 550 && scripts\engine\utility::cointoss())
        _id_05C9AE5533ED1462 = _id_46DE370FCB18A1B0;
      else if(_id_3080E8000AAD4930 > 3000)
        _id_05C9AE5533ED1462 = gettime() + randomintrange(2000, 3000);
      else
        _id_05C9AE5533ED1462 = gettime() + _id_3080E8000AAD4930 + 550 + randomintrange(1000, 2000);
    }

    waitframe();
  }
}

poiauto_relativeangletopos(angles) {
  forward = anglesToForward(angles);
  _id_C568587F2F09CB94 = rotatevector(forward, self.angles);
  _id_C2F4EC03C9EC610E = self getapproxeyepos();
  pos = _id_C2F4EC03C9EC610E + _id_C568587F2F09CB94 * 128.0;
  return pos;
}

poiauto_glancerandom() {
  yaw = randomfloatrange(-45, 45);
  pitch = randomfloatrange(-20, 20);
  pos = poiauto_relativeangletopos((pitch, yaw, 0));
  self._id_8CE6D9FC1435DD86 = 1;
  thread poiauto_glanceend();
  self glanceatpos(pos);
}

poiauto_glanceend() {
  self notify("poiauto_glanceend");
  self endon("poiauto_glanceend");
  wait 0.55;
  self._id_8CE6D9FC1435DD86 = 0;
}

poiauto_isglancing() {
  return istrue(self._id_8CE6D9FC1435DD86);
}

poiauto_setnewaimangle(_id_D74B916A1980D11A) {
  if(_id_D74B916A1980D11A) {
    yaw = randomfloatrange(self.poiauto_angles[1] + 5, self.poiauto_angles[1] + 10);
    pitch = randomfloatrange(5, 10);

    if(scripts\engine\utility::cointoss())
      pitch = pitch * -1;

    pitch = self.poiauto_angles[0] + pitch;
  } else {
    poiauto = self.poiauto;
    yaw = randomfloatrange(poiauto.yawmin, poiauto.yawmax);
    pitch = randomfloatrange(poiauto.pitchmin, poiauto.pitchmax);
  }

  if(scripts\engine\utility::cointoss())
    yaw = yaw * -1;

  self.poiauto_nextangles = (pitch, yaw, 0);
  self.poiauto_nextaimtime = randomintrange(100, 300) + gettime();
}

_id_2285421DFC79C4D5() {
  _id_38548703EA2BDADC = undefined;

  if(isDefined(self.animationarchetype))
    _id_38548703EA2BDADC = self.animationarchetype;
  else
    _id_38548703EA2BDADC = self._id_AE3EA15396B65C1F;

  return _id_38548703EA2BDADC;
}

_id_75996A8DAC6970F2(range) {
  if(!isDefined(range))
    range = 1024;

  if(scripts\common\utility::issp())
    player = level.player;
  else {
    players = sortbydistance(level.players, self.origin);
    player = players[0];
  }

  if(self isnearanyplayer(range))
    _id_9BBFD0995D51760C = player.origin + (0, 0, 55);
  else
    _id_9BBFD0995D51760C = self.origin + (0, 0, 55) + anglesToForward(self.angles + (0, randomintrange(-135, 180), 0)) * 300;

  return _id_9BBFD0995D51760C;
}