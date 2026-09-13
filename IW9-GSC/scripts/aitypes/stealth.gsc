/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\stealth.gsc
***********************************************/

initstealthfunctions() {
  self.fnsetstealthstate = ::_id_20BF793DE5175709;
  self.fnisinstealthidle = ::isidle;
  self.fnisinstealthinvestigate = ::isinvestigating;
  self.fnisinstealthhunt = ::ishunting;
  self.fnisinstealthcombat = ::iscombating;
  self.fnisinstealthidlescriptedanim = ::isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = ::updatevisionforlighting;
  self.fnstealthisidlecurious = ::isidlecurious;
  self.fnclearstealthvolume = ::clearstealthvolume;
  self._id_743F5EEB386835F5 = ::_id_9C4A08F7DCD2796B;
}

isidlescriptedanim() {
  return isDefined(self.stealth) && self._id_FE5EBEFA740C7106 == 0 && self._blackboard._id_06FF150891BB0C47;
}

isidle() {
  return isDefined(self.stealth) && self._id_FE5EBEFA740C7106 == 0;
}

isinvestigating() {
  return isDefined(self.stealth) && self._id_FE5EBEFA740C7106 == 1;
}

ishunting() {
  return isDefined(self.stealth) && self._id_FE5EBEFA740C7106 == 2;
}

iscombating() {
  return isDefined(self.stealth) && self._id_FE5EBEFA740C7106 == 3;
}

stealth_initfriendly(taskid) {
  scripts\stealth\friendly::main();
  return anim.success;
}

stealth_terminatefriendly(taskid) {
  self.stealth = undefined;
  self.stealth_enabled = 0;
}

stealth_initneutral(taskid) {
  scripts\stealth\neutral::main();
  return anim.success;
}

isinlight(_id_DF000BEC2CB34458) {
  if(!isDefined(_id_DF000BEC2CB34458))
    return !istrue(level.is_dark);

  return _id_DF000BEC2CB34458 >= 0.5;
}

updatevisionforlighting() {}

forceflashlightplayercanseeifnecessary() {
  if(isDefined(self.flashlight) && self.flashlight) {
    _id_4F9B0BE341B4C88D = 0.1;

    foreach(player in level.players) {
      if(isDefined(player.nvg) && isDefined(player.nvg.lightmeter) && player.nvg.lightmeter > _id_4F9B0BE341B4C88D && isDefined(player.nvg.prevlightmeter) && player.nvg.lightmeter - player.nvg.prevlightmeter > 0.01) {
        if(self aipointinfov(player.origin) && !self cansee(player))
          self cansee(player, 0);
      }
    }
  }
}

_id_E75FF8B7F46A7761(taskid) {
  _id_CB489A1A37E61B8E = scripts\engine\utility::ent_flag_exist("react_to_dynolights") && scripts\engine\utility::ent_flag("react_to_dynolights");

  if(_id_CB489A1A37E61B8E && !isDefined(self.lightmeter)) {
    scripts\stealth\utility::update_light_meter();
    _id_CB489A1A37E61B8E = 0;
  }

  updatelightbasedflashlight(self._id_FE5EBEFA740C7106, 0.5);

  if(_id_CB489A1A37E61B8E) {
    entnum = self getentitynumber();
    _id_D51349C1F64450E3 = level.frameduration;

    if(gettime() / _id_D51349C1F64450E3 % 5 == entnum % 5)
      scripts\stealth\utility::update_light_meter();
  }

  forceflashlightplayercanseeifnecessary();
  return anim.success;
}

_id_FE4155EB92B02F4A() {
  if(!self isinscriptedstate()) {
    if(istrue(self._id_EFE2696BF37F54B9))
      self.gunposeoverride_internal = "gun_down";
    else
      self.gunposeoverride_internal = "ready";
  }
}

updatelightbasedflashlight(state, _id_45AF66A61BDB7B50) {
  if(self isinscriptedstate()) {
    return;
  }
  if(gettime() == self.starttime) {
    return;
  }
  lightmeter = self.lightmeter;

  if(isDefined(self._blackboard.bflashlight))
    _id_01A544A7E8D153EA = self._blackboard.bflashlight;
  else
    _id_01A544A7E8D153EA = 0;

  if(isDefined(self.flashlightoverride))
    self._blackboard.bflashlight = self.flashlightoverride;
  else if(istrue(self.noflashlight))
    self._blackboard.bflashlight = 0;
  else if(isDefined(lightmeter)) {
    _id_D962C2EC5A81D7A3 = 0.1;

    if(istrue(self._blackboard.bflashlight)) {
      if(lightmeter > _id_45AF66A61BDB7B50 + _id_D962C2EC5A81D7A3)
        self._blackboard.bflashlight = 0;
    } else
      self._blackboard.bflashlight = lightmeter < _id_45AF66A61BDB7B50;
  } else if(istrue(level.is_dark))
    self._blackboard.bflashlight = 1;
  else
    self._blackboard.bflashlight = 0;

  if(_id_01A544A7E8D153EA != self._blackboard.bflashlight) {
    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && (!isDefined(self._id_1BAB8712529EB3C2) || !self._id_1BAB8712529EB3C2)) {
      if(self._blackboard.bflashlight)
        self[[self.fnstealthflashlighton]]();
      else
        self[[self.fnstealthflashlightoff]]();
    }
  }
}

isidlecurious() {
  return self._id_D17737F2FB2CEA58;
}

idle_init(taskid) {
  self._id_98ADD129A7ECB962 = 0;
  scripts\stealth\event::event_escalation_clear();

  if(isDefined(self.stealth.funcs["hidden"]))
    scripts\stealth\callbacks::stealth_call_thread("hidden");

  if(isDefined(self.target)) {
    self.goalradius = 32;

    if(isDefined(self.fnstealthgotonode))
      self thread[[self.fnstealthgotonode]](undefined, undefined, undefined);
  }

  return anim.success;
}

idle_terminate(taskid) {
  self notify("stop_going_to_node");
  self _meth_ AE41FBF799BA43F(0, "bt");
  scripts\stealth\utility::save_last_goal();
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  self.moveplaybackrate = 1;
  return anim.success;
}

stealth_shouldinvestigate(taskid) {
  if(self._id_FE5EBEFA740C7106 == 1)
    return anim.success;

  return anim.failure;
}

investigate_shouldfacedecentdirectionwhenidle() {
  return !istrue(self.limitstealthturning);
}

investigate_setreaction(event) {
  _id_25A7F9B7F59CC41E = "small";

  if(event.typeorig == "bulletwhizby" || event.typeorig == "grenade danger")
    _id_25A7F9B7F59CC41E = "med";
  else if(event.typeorig == "footstep_sprint") {
    if(isDefined(event.entity) && isPlayer(event.entity) && self _meth_89931185060D4D6F(event.entity))
      _id_25A7F9B7F59CC41E = "med";
  }

  scripts\stealth\utility::set_patrol_react(event.investigate_pos, _id_25A7F9B7F59CC41E);
}

stealth_shouldhunt(taskid) {
  if(self._id_FE5EBEFA740C7106 == 2)
    return anim.success;

  return anim.failure;
}

hunt_clearroomdata() {
  self _meth_CA38A887735B9B48();
}

_id_6057074FD95D3E65() {
  _id_8B8967D098E7C16E = 147456;
  _id_7F1A348686B3A9B0 = [];
  _id_EDCA2D230A0013AA = self _meth_FDA3FD9342329F97();

  if(isDefined(_id_EDCA2D230A0013AA)) {
    if(isDefined(anim._id_463C0093DFF0F81C) && isDefined(anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA])) {
      foreach(obj in anim._id_463C0093DFF0F81C[_id_EDCA2D230A0013AA]) {
        if(distancesquared(obj.origin, self.origin) > _id_8B8967D098E7C16E) {
          continue;
        }
        if(!scripts\smartobjects\utility::canclaimsmartobject(obj)) {
          continue;
        }
        if(!scripts\smartobjects\utility::canusesmartobject(obj)) {
          continue;
        }
        _id_7F1A348686B3A9B0[_id_7F1A348686B3A9B0.size] = obj;
      }
    }
  }

  return _id_7F1A348686B3A9B0;
}

hunt_updateeveryframe(taskid) {
  return anim.success;
}

_id_2EEA6ED25456E38D(taskid) {
  scripts\stealth\utility::set_patrol_style("cqb");

  if(isDefined(self.stealth.funcs["hunt_custom_init"]))
    self thread[[self.stealth.funcs["hunt_custom_init"]]]();

  return anim.success;
}

_id_2AE6E5FA8AD77612(taskid) {
  if(!self._id_F843FBBADA4E59B2)
    return anim.failure;

  if(isDefined(self.stealth.funcs["hunt_custom_update"])) {
    _id_FD306FABA3E6DA68 = self[[self.stealth.funcs["hunt_custom_update"]]]();

    if(isDefined(_id_FD306FABA3E6DA68)) {
      if(_id_FD306FABA3E6DA68)
        return anim.running;
      else
        return anim.failure;
    }
  }

  return anim.running;
}

_id_4C41840DA22ED656(taskid) {
  if(isDefined(self.stealth.funcs["hunt_custom_terminate"]))
    self thread[[self.stealth.funcs["hunt_custom_terminate"]]]();

  return anim.success;
}

hunt_initialdelay_init(taskid) {
  self.bt.instancedata[taskid] = gettime() + randomintrange(500, 1500);
}

hunt_initialdelay(taskid) {
  if(!isDefined(self._id_7DEE6DFDB05ECAF9) || isDefined(scripts\asm\asm_bb::bb_getcovernode()) || gettime() >= self.bt.instancedata[taskid])
    return anim.success;

  return anim.running;
}

hunt_initialdelay_terminate(taskid) {
  self.bt.instancedata[taskid] = undefined;
}

hunt_cqbtargetupdate(instancedata) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);

  if(isDefined(_id_B205CC0302DA1270.target)) {
    _id_6B7BEE46F2C6DA28 = gettime();

    if(self cansee(_id_B205CC0302DA1270.target) || self getthreatsight(_id_B205CC0302DA1270.target) > 0.1) {
      self._id_0ABC30858A62A19A = _id_B205CC0302DA1270.target.origin;
      instancedata.cqbtargettime = _id_6B7BEE46F2C6DA28;
      return 1;
    } else if(issentient(_id_B205CC0302DA1270.target) && (isDefined(self.stealth.btargetlastknown) || isDefined(instancedata.cqbtargettime) && _id_6B7BEE46F2C6DA28 - instancedata.cqbtargettime < 2000)) {
      self._id_0ABC30858A62A19A = self lastknownpos(_id_B205CC0302DA1270.target);
      return 1;
    }
  }

  _id_E54272533AB42FD2 = anglesToForward(self.angles);
  self._id_0ABC30858A62A19A = self.origin + _id_E54272533AB42FD2 * 384;
  return 0;
}

hunt_shouldhunker(taskid) {
  return anim.failure;
}

hunt_hunker_init(taskid) {
  _id_6B7BEE46F2C6DA28 = gettime();
  instancedata = spawnStruct();
  instancedata.nextcoverchecktime = _id_6B7BEE46F2C6DA28 + randomintrange(4000, 6000);
  self.bt.instancedata[taskid] = instancedata;
  self.stealth.hunthunkerlastexposetime = _id_6B7BEE46F2C6DA28;
  scripts\stealth\utility::set_patrol_style("cqb");
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
  node = self findbestcovernode(undefined, 0, _id_B205CC0302DA1270.origin);

  if(isDefined(node)) {
    if(!isDefined(self.node) || self.node != node) {
      self.keepclaimednode = 0;
      self.keepclaimednodeifvalid = 0;
      self usecovernode(node);
    }
  }
}

hunt_hunker(taskid) {
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_6B7BEE46F2C6DA28 > self.bt.instancedata[taskid].nextcoverchecktime) {
    _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
    _id_DFB6755A19EE191B = randomint(3) < 1;
    node = self findbestcovernode("cover_hunt_hunker", _id_DFB6755A19EE191B, _id_B205CC0302DA1270.origin);

    if(isDefined(node)) {
      _id_559F42BCDB572D45 = 0;

      if(!isDefined(self.node) || self.node != node) {
        self.keepclaimednode = 0;
        self.keepclaimednodeifvalid = 0;
        _id_559F42BCDB572D45 = !self usecovernode(node);
      }

      if(_id_559F42BCDB572D45)
        self.bt.instancedata[taskid].nextcoverchecktime = _id_6B7BEE46F2C6DA28 + 500;
      else
        self.bt.instancedata[taskid].nextcoverchecktime = _id_6B7BEE46F2C6DA28 + randomintrange(4000, 6000);
    } else
      self.bt.instancedata[taskid].nextcoverchecktime = _id_6B7BEE46F2C6DA28 + randomintrange(2000, 4000);
  }

  hunt_cqbtargetupdate(self.bt.instancedata[taskid]);
  return anim.running;
}

hunt_hunker_terminate(taskid) {
  self.bt.instancedata[taskid] = undefined;
}

hunt_hunker_shouldexpose(taskid) {
  _id_129825F5EA14C1E4 = 5000;

  if(!isinlight(self.lightmeter))
    _id_129825F5EA14C1E4 = 3000;

  if(gettime() > self.stealth.hunthunkerlastexposetime + _id_129825F5EA14C1E4)
    return anim.success;

  return anim.failure;
}

hunt_hunker_expose_init(taskid) {
  instancedata = spawnStruct();
  instancedata.endtime = gettime() + 4000;
  instancedata.nextpostime = 0;
  instancedata.nextposidx = 0;
  self.bt.instancedata[taskid] = instancedata;
  scripts\asm\asm_bb::bb_requestcoverstate("exposed", 0);

  if(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node))
    scripts\asm\asm_bb::bb_requestcoverexposetype("B");
  else
    scripts\asm\asm_bb::bb_requestcoverexposetype("exposed");

  self.stealth.btargetlastknown = 1;
}

hunt_hunker_expose(taskid) {
  _id_6B7BEE46F2C6DA28 = gettime();
  instancedata = self.bt.instancedata[taskid];

  if(_id_6B7BEE46F2C6DA28 > instancedata.endtime)
    return anim.success;

  return anim.running;
}

hunt_hunker_expose_terminate(taskid) {
  self._id_0ABC30858A62A19A = undefined;
  self.bt.instancedata[taskid] = undefined;
  scripts\asm\asm_bb::bb_requestcoverstate("hide", 1);
  self.stealth.btargetlastknown = undefined;
  self.stealth.hunthunkerlastexposetime = gettime();
}

hunt_isincover(taskid) {
  if(!isDefined(self.node))
    return anim.failure;

  _id_6901A79FC03EA862 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > _id_6901A79FC03EA862)
      return anim.failure;
  } else if(self.keepclaimednodeifvalid)
    _id_6901A79FC03EA862 = 3600;
  else
    _id_6901A79FC03EA862 = 225;

  if(distance2dsquared(self.node.origin, self.origin) > _id_6901A79FC03EA862)
    return anim.failure;

  return anim.success;
}

hunt_active_terminate(taskid) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
  self clearbtgoal(3);
}

_id_6771D1C0ABC4DA9C(taskid) {
  return anim.failure;
}

_id_B647C0D07E4A3078(taskid) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
  _id_2924E404150FF758 = _id_B205CC0302DA1270 scripts\stealth\group::_id_75087B386454D072(self);
  goalpos = _id_2924E404150FF758._id_10098495A8E7E9E7[self getentitynumber()];
  self setbtgoalpos(3, goalpos);
  self setbtgoalRadius(3, 24);
  instancedata = spawnStruct();
  instancedata.starttime = gettime();
  instancedata._id_10098495A8E7E9E7 = goalpos;
  self.bt.instancedata[taskid] = instancedata;
  _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[0];

  if(self == _id_CC2828DA32453F24)
    _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[1];

  _id_5DE4575810C72FF0 = vectortoyaw(_id_CC2828DA32453F24.origin - self.origin);
  self._id_0A41EDF45BB0FF97 = (0, _id_5DE4575810C72FF0, 0);
}

_id_5BA0240304E46139(taskid) {
  if(self.pathpending)
    return anim.running;

  instancedata = self.bt.instancedata[taskid];
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_6B7BEE46F2C6DA28 - instancedata.starttime > 0 && !isDefined(self.pathgoalpos)) {
    if(distancesquared(self.origin, instancedata._id_10098495A8E7E9E7) < 576 && !self.arriving)
      return anim.success;
    else {}
  }

  if(_id_6B7BEE46F2C6DA28 - instancedata.starttime > 15000)
    return anim.failure;

  return anim.running;
}

_id_8F3C5DE8D0839565(taskid) {
  self._id_0A41EDF45BB0FF97 = undefined;
  self.bt.instancedata[taskid] = undefined;
}

_id_90ED2A34D9F66902(taskid) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
  _id_2924E404150FF758 = _id_B205CC0302DA1270 scripts\stealth\group::_id_75087B386454D072(self);

  if(!isDefined(_id_2924E404150FF758))
    return "ReturnSuccess";

  _id_BBAA211F594F17BA = _id_2924E404150FF758.state[self getentitynumber()];

  if(_id_BBAA211F594F17BA == "wait")
    return "Stealth_Hunt_Coordinate_Wait";
  else if(_id_BBAA211F594F17BA == "gesture")
    return "Stealth_Hunt_Coordinate_Action";
  else if(_id_BBAA211F594F17BA == "done")
    return "ReturnSuccess";
}

_id_7E3B6C64F2C2C6BE(taskid) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
  _id_2924E404150FF758 = _id_B205CC0302DA1270 scripts\stealth\group::_id_75087B386454D072(self);
  _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[0];

  if(self == _id_CC2828DA32453F24)
    _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[1];

  if(isDefined(self._id_7B492275EF047BE2)) {
    self._blackboard._id_3DBE624A18D61F13 = self._id_7B492275EF047BE2;
    _id_6C66DE307018DFE3 = spawnStruct();
    _id_6C66DE307018DFE3.origin = self.origin;
    _id_6C66DE307018DFE3.angles = self.angles;
    _id_6C66DE307018DFE3.script_smartobject = "hunt_point";
    scripts\smartobjects\utility::setsmartobject(_id_6C66DE307018DFE3);
  } else {
    _id_6C66DE307018DFE3 = spawnStruct();
    _id_6C66DE307018DFE3.origin = self.origin;
    _id_6C66DE307018DFE3.angles = self.angles;
    _id_6C66DE307018DFE3.script_smartobject = "hunt_checkin";
    scripts\smartobjects\utility::setsmartobject(_id_6C66DE307018DFE3);
  }

  return anim.success;
}

_id_9B6FD81057EDE5CE() {
  self._id_587D8840DEA10869 = 0;
  self._id_4B1FA39975A3FD58 = undefined;
  self._id_97DB6F81BA0702E3 = undefined;
}

clearstealthvolume() {
  if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup]) && iscombating() || isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]) && ishunting())
    self clearbtgoal(0);
}

_id_6BDCFA57946930C7(event) {
  self.stealth.investigateevent = event;
  self._id_BB3BAB49C9A764A4 = event.typeorig;
  self._id_CC20708455457566 = event.entity;
  self._id_BF4E91E691D898FC = event.receiver;
  self._id_F97FF24102472069 = event.type;
  self._id_1A15E562B3389B69 = 0;

  if(isDefined(event.position))
    self._id_D70F3A3817594DC6 = event.position;

  if(isDefined(event.investigate_pos))
    self._id_0B446B52DFACC181 = event.investigate_pos;

  if(isDefined(event.look_pos))
    self._id_743C0E8CFE4ADC6F = event.look_pos;
}

_id_9C4A08F7DCD2796B() {
  if(!isDefined(self._id_BB3BAB49C9A764A4) || !isDefined(self.stealth.investigateevent))
    return undefined;

  self.stealth.investigateevent.typeorig = self._id_BB3BAB49C9A764A4;
  self.stealth.investigateevent.position = self._id_D70F3A3817594DC6;
  self.stealth.investigateevent.entity = self._id_CC20708455457566;
  self.stealth.investigateevent.receiver = self._id_BF4E91E691D898FC;
  self.stealth.investigateevent.type = self._id_F97FF24102472069;
  self.stealth.investigateevent.investigate_pos = self._id_0B446B52DFACC181;
  self.stealth.investigateevent.look_pos = self._id_743C0E8CFE4ADC6F;
  return self.stealth.investigateevent;
}

_id_0DE475C37AEEAF6C() {
  self.stealth.investigateevent = undefined;
  self._id_BB3BAB49C9A764A4 = undefined;
}

_id_9499F9E2B35B85C8(event, _id_AA6726F343A56725) {
  if(isPlayer(self._id_DA668F8DE95278E9) && !isPlayer(event.entity) && event.typeorig != "saw_corpse") {
    return;
  }
  if(isDefined(self._id_F97FF24102472069)) {
    if(self._id_BB3BAB49C9A764A4 == "saw_corpse" && (event.typeorig == "found_corpse" || event.typeorig == "saw_corpse") && isDefined(self._id_DA668F8DE95278E9) && event.entity == self._id_DA668F8DE95278E9) {
      return;
    }
    _id_1B676E77B43546A0 = scripts\stealth\event::event_severity_compare(self._id_F97FF24102472069, event.type);

    if(_id_1B676E77B43546A0 >= 0) {
      self._id_B217B37A4A7C7817 = event.typeorig;
      self._id_DA668F8DE95278E9 = event.entity;
      _id_6BDCFA57946930C7(event);
    }

    _id_6B7BEE46F2C6DA28 = gettime();
    _id_CCD49D42C848E0A8 = _id_1B676E77B43546A0 > 0 || _id_6B7BEE46F2C6DA28 > self._id_F1D505E3ED5189BB || distancesquared(event.investigate_pos, self.origin) < distancesquared(self._id_0B446B52DFACC181, self.origin);

    if(_id_CCD49D42C848E0A8) {
      groupdata = scripts\stealth\group::getgroup(self.script_stealthgroup);
      _id_B205CC0302DA1270 = scripts\stealth\group::group_findpod(groupdata, self);
      _id_CD514BF5922B5A83 = scripts\stealth\group::group_trytojoinexistingpod(groupdata, _id_B205CC0302DA1270, _id_AA6726F343A56725, self, event.investigate_pos);

      if(isDefined(_id_CD514BF5922B5A83))
        _id_B205CC0302DA1270 = _id_CD514BF5922B5A83;

      _id_B205CC0302DA1270 scripts\stealth\group::pod_updateinvestigateorigin(self, event.investigate_pos);
      thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "update_investigate", undefined, event);

      if(_id_AA6726F343A56725 == 1)
        self notify("stealth_update_investigate");

      self._id_F1D505E3ED5189BB = _id_6B7BEE46F2C6DA28;
    }

    self._id_27EBF45F68998EF8 = undefined;
  }
}

_id_20BF793DE5175709(statename, e) {
  if(!scripts\engine\utility::flag("stealth_enabled") || !isDefined(self.stealth) || !istrue(self.stealth_enabled)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self setstealthstate(statename, e);
}