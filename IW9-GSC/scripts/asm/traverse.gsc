/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\traverse.gsc
***********************************************/

playtraversearrivalanim(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  traverseanim = scripts\asm\asm::asm_getanim(asmname, statename);
  traversexanim = scripts\asm\asm::asm_getxanim(statename, traverseanim);
  scripts\asm\asm_bb::bb_requeststance("stand");

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    if(isDefined(self._id_64B933AF90EDC53C.traverse_height_delta))
      self._id_64B933AF90EDC53C.traverse_height = self._id_64B933AF90EDC53C.origin[2] + self._id_64B933AF90EDC53C.traverse_height_delta;
  } else {
    startnode = self getnegotiationstartnode();

    if(!isDefined(startnode) && isDefined(self.traversal_start_node))
      startnode = self.traversal_start_node;

    if(isDefined(startnode.traverse_height_delta))
      startnode.traverse_height = startnode.origin[2] + startnode.traverse_height_delta;

    endnode = self getnegotiationendnode();

    if(!isDefined(endnode) && isDefined(self.traversal_end_node))
      endnode = self.traversal_end_node;

    if(!isDefined(endnode)) {}

    self.traversestartnode = startnode;
    self.traverseendnode = endnode;
  }

  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, traversexanim);
  self.traversexanim = traversexanim;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();

  if(isanimation(traverseanim)) {
    self aisetanim(statename, 0);
    self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
    self setflaggedanim(statename, traverseanim);
  } else
    self aisetanim(statename, traverseanim);

  if(self._id_32A34987EE1B3095 == "linkless")
    self starttraversearrival(120, self._id_E2B4FC394EEF5C0F, self._id_64B933AF90EDC53C.origin, self._id_64B933AF90EDC53C.endpos);
  else if(self._id_32A34987EE1B3095 == "nodeless")
    self starttraversearrival(120, self._id_E2B4FC394EEF5C0F);
  else
    self starttraversearrival(120);

  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  _id_D5353AA2EFE2C188 = scripts\asm\asm::asm_donotetracks(asmname, statename, ::handletraversearrivalwarpnotetracks);
  self animmode("gravity");

  if(self.delayeddeath) {
    terminatetraverse(asmname, statename);
    return;
  }
}

_id_E9CC41DF0C7DFD7B(asmname, statename, params) {
  playtraversearrivalanim(asmname, statename, params);
}

_id_EADD4123F9B2DA38(asmname, statename, params) {
  return [[level._id_0BB5F04E5A0A5C13[self.traversal_start_node.animscript]]](asmname, statename, params);
}

playtraverseanim_scaled(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  checktraverse(statename);
  startnode = undefined;

  if(self._id_32A34987EE1B3095 == "linkless") {
    startpos = self _meth_AD3C975CB94E4736();

    if(!isDefined(startpos))
      self starttraversearrival(120, self._id_E2B4FC394EEF5C0F, self._id_64B933AF90EDC53C.origin, self._id_64B933AF90EDC53C.endpos);
  } else if(self._id_32A34987EE1B3095 == "nodeless") {
    startpos = self _meth_AD3C975CB94E4736();

    if(!isDefined(startpos))
      self starttraversearrival(120, self._id_E2B4FC394EEF5C0F);
  } else {
    startnode = self getnegotiationstartnode();

    if(!isDefined(startnode)) {
      self starttraversearrival(120);
      startnode = self getnegotiationstartnode();
    }
  }

  if(self._id_20A0E88052918576) {
    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
      if(length(self._id_A836173C912579BD - self._id_64B933AF90EDC53C.origin) > 0.001)
        self._id_20A0E88052918576 = 0;
    } else if(self._id_691B939374451D39 != startnode)
      self._id_20A0E88052918576 = 0;
  }

  traverseanim = scripts\asm\asm::asm_getanim(asmname, statename);
  traversexanim = scripts\asm\asm::asm_getxanim(statename, traverseanim);
  scripts\asm\asm_bb::bb_requeststance("stand");

  if(!animisleaf(traversexanim)) {
    endpos = undefined;

    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
      endpos = self._id_64B933AF90EDC53C.endpos;
    else {
      endnode = self getnegotiationendnode();

      if(!isDefined(endnode) && isDefined(self.traversal_end_node)) {
        endnode = self.traversal_end_node;
        endpos = endnode.origin;
      }
    }

    if(isDefined(endpos))
      self forceteleport(endpos, self.angles);

    terminatetraverse(asmname, statename);
    return;
  }

  _id_370A8C08BE55A7A5 = getnotetracktimes(traversexanim, "code_move");

  if(_id_370A8C08BE55A7A5.size > 0)
    self.requestarrivalnotify = 1;

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    if(isDefined(self._id_64B933AF90EDC53C.traverse_height_delta))
      self._id_64B933AF90EDC53C.traverse_height = self._id_64B933AF90EDC53C.origin[2] + self._id_64B933AF90EDC53C.traverse_height_delta;
  } else {
    startnode = self getnegotiationstartnode();

    if(!isDefined(startnode) && isDefined(self.traversal_start_node))
      startnode = self.traversal_start_node;

    if(isDefined(startnode.traverse_height_delta))
      startnode.traverse_height = startnode.origin[2] + startnode.traverse_height_delta;

    endnode = self getnegotiationendnode();

    if(!isDefined(endnode) && isDefined(self.traversal_end_node))
      endnode = self.traversal_end_node;

    if(!isDefined(endnode)) {}

    self.traversestartnode = startnode;
    self.traverseendnode = endnode;
  }

  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);

  if(self._id_32A34987EE1B3095 != "nodeless" && self._id_32A34987EE1B3095 != "linkless") {}

  shouldusewarpnotetracks = shouldusewarpnotetracks(traversexanim);
  shouldusewarparrival = shouldusewarparrival(traversexanim);

  if(shouldusewarpnotetracks)
    notetrackhandle = ::handletraversewarpnotetracks;
  else {
    notetrackhandle = ::handletraverselegacynotetracks;

    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
      self orientmode("face angle", self._id_64B933AF90EDC53C.angles[1]);
    else
      self orientmode("face angle", startnode.angles[1]);

    if(!animhasnotetrack(traversexanim, "traverse_align"))
      handletraversealignment();
  }

  scripts\asm\asm::asm_playfacialanim(asmname, statename, traversexanim);
  self.traversexanim = traversexanim;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();

  if(statename == "traverse_external" || statename == "traverse_warp_external") {
    self aisetanim(statename, 0);
    self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
    self setflaggedanim(statename, self.traversexanim);
  } else
    self aisetanim(statename, traverseanim);

  if(shouldusewarparrival && !isagent(self) && (!self._id_20A0E88052918576 || !self._id_C4EF68FE2A3931E5)) {
    _id_ACB3808224621C9A = getnotetracktimes(traversexanim, "warp_arrival_end")[0];
    self setanimtime(traversexanim, _id_ACB3808224621C9A);
  }

  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  _id_13A9CA0E75F2FEF4 = spawnStruct();

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    _id_13A9CA0E75F2FEF4.startpos = self._id_64B933AF90EDC53C.origin;
    _id_13A9CA0E75F2FEF4.endpos = self._id_E341EF38B14D5CD3;
    _id_13A9CA0E75F2FEF4.apex_delta = self._id_64B933AF90EDC53C.apex_delta;
    _id_13A9CA0E75F2FEF4.angles = self._id_64B933AF90EDC53C.angles;
  } else {
    _id_13A9CA0E75F2FEF4.startpos = self.traversestartnode.origin;
    _id_13A9CA0E75F2FEF4.apex_delta = self.traversestartnode.apex_delta;
    _id_13A9CA0E75F2FEF4.angles = self.traversestartnode.angles;
    _id_13A9CA0E75F2FEF4.endpos = self getnegotiationendpos();
  }

  self _meth_742E699E544869C2(_id_13A9CA0E75F2FEF4.startpos, _id_13A9CA0E75F2FEF4.endpos, _id_13A9CA0E75F2FEF4.angles, _id_13A9CA0E75F2FEF4.apex_delta);
  _id_D5353AA2EFE2C188 = scripts\asm\asm::asm_donotetracks(asmname, statename, notetrackhandle, undefined, undefined, 0);

  if(_id_D5353AA2EFE2C188 == "code_move") {
    if(isDefined(self.pathgoalpos)) {
      self motionwarpcancel();
      self animmode("normal");
      self orientmode("face motion");
    }

    if(!scripts\asm\asm::asm_eventfired(asmname, "finish") && !scripts\asm\asm::asm_eventfired(asmname, "end"))
      scripts\asm\asm::asm_donotetracks(asmname, statename, notetrackhandle);
  }

  self animmode("gravity");

  if(self.delayeddeath) {
    terminatetraverse(asmname, statename);
    return;
  }

  self.a.nodeath = 0;
  self.a.movement = "run";
  self.traverseanimroot = undefined;
  self.traversexanim = undefined;
  scripts\common\ai::clear_deathanim();
  self.traversestartnode = undefined;
  terminatetraverse(asmname, statename);
}

terminatetraverse(asmname, statename) {
  self.useanimgoalweight = 0;
  self._id_20A0E88052918576 = 0;
  self.istraversing = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  scripts\asm\asm::asm_fireevent(asmname, "traverse_end");
  self finishtraverse();
  self motionwarpcancel();
}

handletraversealignment() {
  self animmode("noclip");
  _id_256CA46D1EFFDD41 = undefined;

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
    _id_256CA46D1EFFDD41 = self._id_64B933AF90EDC53C.traverse_height;
  else
    _id_256CA46D1EFFDD41 = self.traversestartnode.traverse_height;

  if(isDefined(self.traverseheight) && isDefined(_id_256CA46D1EFFDD41)) {
    _id_C96A4BFB26396AA5 = _id_256CA46D1EFFDD41 - self.traversestartz;
    thread teleportthread(_id_C96A4BFB26396AA5 - self.traverseheight);
  }
}

handletraverselegacynotetracks(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "traverse_death")
    return handletraversedeathnotetrack();
  else if(_id_A234A65C378F3289 == "traverse_align")
    return handletraversealignment();
  else if(_id_A234A65C378F3289 == "traverse_drop")
    return handletraversedrop();
}

handletraversedrop() {
  self animmode("noclip");
  endnode = self.traverseendnode;

  if(!isDefined(endnode)) {
    endnode = spawnStruct();
    endnode.angles = self.traversestartnode.angles;
    endnode.origin = self getnegotiationendpos();
  }

  _id_4B57DB1838537B36 = getnotetracktimes(self.traversexanim, "footstep_left_large");

  if(_id_4B57DB1838537B36.size == 0)
    _id_4B57DB1838537B36 = getnotetracktimes(self.traversexanim, "footstep_right_large");

  _id_47B4BDC915CFF70D = 1.0;

  if(_id_4B57DB1838537B36.size > 0)
    _id_47B4BDC915CFF70D = _id_4B57DB1838537B36[0];

  _id_67B5A24409D655F0 = getnotetracktimes(self.traversexanim, "traverse_drop")[0];
  _id_95ABCCFE668F369A = getmovedelta(self.traversexanim, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_95ABCCFE668F369A = rotatevector(_id_95ABCCFE668F369A, endnode.angles);
  _id_2ED406669FBE4377 = 512;
  tracestart = (self.origin[0] + _id_95ABCCFE668F369A[0], self.origin[1] + _id_95ABCCFE668F369A[1], self.origin[2]);
  targetpos = getgroundposition(tracestart, 10, _id_2ED406669FBE4377, 12);
  _id_49601AB0E39BF185 = 0.05;
  _id_CC2BAF1E6D41C416 = 30;
  _id_61045D8733281EE5 = abs(targetpos[2] - self.origin[2]);

  if(_id_61045D8733281EE5 < _id_49601AB0E39BF185 * abs(_id_95ABCCFE668F369A[2]) || _id_61045D8733281EE5 > _id_CC2BAF1E6D41C416)
    targetpos = (targetpos[0], targetpos[1], endnode.origin[2]);

  _id_249C04BD818FCD81 = self getpointafternegotiation();
  targetangles = endnode.angles;

  if(!isDefined(endnode.origin))
    endnode.origin = self.traversestartnode.end_node_origin;

  if(isDefined(_id_249C04BD818FCD81)) {
    _id_623F3095ECFA11FF = vectortoyaw(_id_249C04BD818FCD81 - endnode.origin);
    _id_822DB80CE3C87A54 = clamp(angleclamp180(_id_623F3095ECFA11FF - self.angles[1]), -30.0, 30.0);
    _id_623F3095ECFA11FF = angleclamp180(self.angles[1] + _id_822DB80CE3C87A54);
    targetangles = (0, _id_623F3095ECFA11FF, 0);
  }

  scripts\engine\utility::motionwarpwithtimes(self.traversexanim, targetpos, targetangles, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  thread finishtraversedrop(targetpos[2]);
}

finishtraversedrop(_id_BA8D57C006AB035B) {
  self endon("killanimscript");
  self endon("death");
  _id_BA8D57C006AB035B = _id_BA8D57C006AB035B + 2.0;

  for(;;) {
    if(self.origin[2] < _id_BA8D57C006AB035B) {
      self motionwarpcancel();
      break;
    }

    waitframe();
  }
}

teleportthread(_id_51304DDED8F135AC) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  _id_3CACBBC5D5637F2D = 5;
  offset = (0, 0, _id_51304DDED8F135AC / _id_3CACBBC5D5637F2D);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CACBBC5D5637F2D; _id_AC0E594AC96AA3A8++) {
    self forceteleport(self.origin + offset);
    waitframe();
  }
}

teleportthreadex(_id_51304DDED8F135AC, delay, _id_1AAD8F38CB38F703, _id_07B60BC0EAB3FD1E) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(_id_51304DDED8F135AC == 0 || _id_1AAD8F38CB38F703 <= 0) {
    return;
  }
  if(delay > 0)
    wait(delay);

  offset = (0, 0, _id_51304DDED8F135AC / _id_1AAD8F38CB38F703);

  if(isDefined(_id_07B60BC0EAB3FD1E) && _id_07B60BC0EAB3FD1E < 1.0)
    self aisetanimrate(self.traversexanim, _id_07B60BC0EAB3FD1E);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1AAD8F38CB38F703; _id_AC0E594AC96AA3A8++) {
    self forceteleport(self.origin + offset);
    waitframe();
  }

  if(isDefined(_id_07B60BC0EAB3FD1E) && _id_07B60BC0EAB3FD1E < 1.0)
    self aisetanimrate(self.traversexanim, 1.0);
}

shouldusewarpnotetracks(traversexanim) {
  if(animhasnotetrack(traversexanim, "warp_up_start"))
    return 1;

  if(animhasnotetrack(traversexanim, "warp_across_start"))
    return 1;

  if(animhasnotetrack(traversexanim, "warp_down_start"))
    return 1;

  if(animhasnotetrack(traversexanim, "warp_up_start_new"))
    return 1;

  if(animhasnotetrack(traversexanim, "warp_down_start_new"))
    return 1;

  return 0;
}

shouldusewarparrival(traversexanim) {
  if(animhasnotetrack(traversexanim, "warp_arrival_start"))
    return 1;

  return 0;
}

_id_BFF8CA6CD5006152(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self._id_32A34987EE1B3095 == "not_set")
    return 0;

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
    _id_D5685B7BAEE6505E = self._id_C97CD7821467B22C;
  else
    _id_D5685B7BAEE6505E = self.traversal_start_node.origin;

  _id_0D49262AB30E7C20 = distance2d(self.origin, _id_D5685B7BAEE6505E);
  _id_FF55722C6B260D94 = 120;

  if(isDefined(params))
    _id_FF55722C6B260D94 = int(params);

  if(_id_0D49262AB30E7C20 > _id_FF55722C6B260D94)
    return 0;

  return 1;
}

shoulddotraditionaltraverse(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self._id_E2B4FC394EEF5C0F != params)
    return 0;

  return 1;
}

traverse_cleanup(asmname, statename, params) {
  self motionwarpcancel();
  self finishtraverse();
  self._id_20A0E88052918576 = 0;
}

_id_3BB347B40346528A() {
  _id_73BA1B0A68C224F5 = self._id_C97CD7821467B22C;
  _id_EF78260982B9116C = self._id_E341EF38B14D5CD3;
  _id_18BCA10706DB67D2 = spawnStruct();
  _id_DEB6D45028C3EF80 = self._id_0EB21849FD8C2F23;

  if(isDefined(_id_DEB6D45028C3EF80)) {
    _id_18BCA10706DB67D2.traverse_height = _id_DEB6D45028C3EF80[2];
    _id_18BCA10706DB67D2.traverse_height_delta = _id_DEB6D45028C3EF80[2] - _id_73BA1B0A68C224F5[2];
    _id_18BCA10706DB67D2.traverse_drop_height_delta = _id_DEB6D45028C3EF80[2] - _id_EF78260982B9116C[2];
    _id_18BCA10706DB67D2.apex_delta = _id_DEB6D45028C3EF80 - _id_73BA1B0A68C224F5;
    _id_18BCA10706DB67D2.angles = vectortoangles(scripts\engine\utility::flat_origin(_id_EF78260982B9116C - _id_73BA1B0A68C224F5));
    _id_18BCA10706DB67D2.origin = _id_73BA1B0A68C224F5;
    _id_18BCA10706DB67D2.endpos = _id_EF78260982B9116C;
    _id_18BCA10706DB67D2.traversetype = "traverse_warp_over";
  }

  return _id_18BCA10706DB67D2;
}

calctraversetype(asmname, statename, params) {
  _id_E8885693728FD806 = undefined;

  if(self._id_32A34987EE1B3095 == "linkless") {
    if(self._id_59C43504D7AABB7A == "fence")
      _id_E8885693728FD806 = ::_id_3BB347B40346528A;
  } else if(isDefined(self._id_BB9DC4A1372891C6))
    _id_E8885693728FD806 = self._id_BB9DC4A1372891C6;

  if(isDefined(_id_E8885693728FD806))
    self._id_64B933AF90EDC53C = self[[_id_E8885693728FD806]]();

  self._id_20A0E88052918576 = 1;
  self._id_E2B4FC394EEF5C0F = self._id_AD4D9F5A34656396;

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    self._id_E2B4FC394EEF5C0F = self._id_64B933AF90EDC53C.traversetype;
    self._id_AD4D9F5A34656396 = self._id_64B933AF90EDC53C.traversetype;
    self._id_A836173C912579BD = self._id_64B933AF90EDC53C.origin;
  } else
    self._id_691B939374451D39 = self.traversal_start_node;

  if(self._id_E2B4FC394EEF5C0F == "traverse_warp_external") {
    _id_FB209AA1ACD60371 = self.traversal_start_node.animscript;
    self.traversalhasarrival = 1;
    self._id_C4EF68FE2A3931E5 = 1;
    traverseanim = self[[level._id_0BB5F04E5A0A5C13[_id_FB209AA1ACD60371]]](asmname, statename, params);
    self._id_64759B639D9FB8D6 = getmovedelta(traverseanim, 0, 1);
    return;
  } else if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    _id_E9DB8FC3741A7E52 = [];
    _id_E9DB8FC3741A7E52["height"] = self._id_64B933AF90EDC53C.traverse_height_delta;
    _id_E9DB8FC3741A7E52["drop_height"] = self._id_64B933AF90EDC53C.traverse_drop_height_delta;
    _id_E9DB8FC3741A7E52["arrival_yaw"] = angleclamp180(self._id_64B933AF90EDC53C.angles[1] - self.angles[1]);
    _id_E9DB8FC3741A7E52["speed"] = self aigettargetspeed();

    if(self._id_E2B4FC394EEF5C0F == "traverse_warp_across" && isDefined(self._id_64B933AF90EDC53C.across_delta))
      _id_E9DB8FC3741A7E52["length"] = length2d(self._id_64B933AF90EDC53C.across_delta);
  } else {
    _id_E9DB8FC3741A7E52 = [];
    _id_E9DB8FC3741A7E52["height"] = self.traversal_start_node.traverse_height_delta;
    _id_E9DB8FC3741A7E52["drop_height"] = self.traversal_start_node.traverse_drop_height_delta;
    _id_E9DB8FC3741A7E52["arrival_yaw"] = angleclamp180(self.traversal_start_node.angles[1] - self.angles[1]);
    _id_E9DB8FC3741A7E52["speed"] = self aigettargetspeed();

    if(self._id_E2B4FC394EEF5C0F == "traverse_warp_across" && isDefined(self.traversal_start_node.across_delta))
      _id_E9DB8FC3741A7E52["length"] = length2d(self.traversal_start_node.across_delta);
  }

  if(isDefined(self._id_12A6A7D538790F6E))
    _id_E9DB8FC3741A7E52 = [[self._id_12A6A7D538790F6E]](_id_E9DB8FC3741A7E52, self._id_E2B4FC394EEF5C0F);

  alias = undefined;
  alias = _func_77BFC94EE479C823(self._id_AE3EA15396B65C1F, self._id_E2B4FC394EEF5C0F, _id_E9DB8FC3741A7E52);

  if(!isDefined(alias)) {
    _id_1B240BBF89180B65 = _id_469E0E48A1796CA6::gettraverserindex();
    alias = _id_469E0E48A1796CA6::selectanim(self._id_E2B4FC394EEF5C0F, _id_E9DB8FC3741A7E52, _id_1B240BBF89180B65);
  }

  traverseanim = scripts\asm\asm::asm_lookupanimfromalias(self._id_E2B4FC394EEF5C0F, alias);
  xanim = scripts\asm\asm::asm_getxanim(self._id_E2B4FC394EEF5C0F, traverseanim);
  self._id_2078D7B4461A7A13 = alias;
  arrivalstate = self._id_E2B4FC394EEF5C0F + "_arrival";
  self.traversalhasarrival = 0;
  arrivalxanim = undefined;
  _id_940BD08D958AC599 = scripts\asm\asm::asm_lookupanimfromaliasifexists(arrivalstate, alias);

  if(isDefined(_id_940BD08D958AC599)) {
    arrivalxanim = scripts\asm\asm::asm_getxanim(arrivalstate, _id_940BD08D958AC599);
    self.traversalhasarrival = 1;
    self._id_C4EF68FE2A3931E5 = 1;
  }

  _id_62ED904F1FCE7586 = xanim;

  if(isDefined(arrivalxanim))
    _id_62ED904F1FCE7586 = arrivalxanim;

  translationdelta = (0, 0, 0);
  _id_441A43306F49C4E2 = getnotetracktimes(_id_62ED904F1FCE7586, "warp_arrival_start")[0];
  _id_08407BDEAF8CE633 = getnotetracktimes(_id_62ED904F1FCE7586, "warp_arrival_end")[0];
  _id_1657049E2C02637A = getnotetracktimes(_id_62ED904F1FCE7586, "finish")[0];

  if(isDefined(_id_441A43306F49C4E2) && isDefined(_id_08407BDEAF8CE633) && isDefined(_id_1657049E2C02637A)) {
    _id_5D7268F5F03B60C3 = scripts\engine\utility::ter_op(isDefined(arrivalxanim), _id_1657049E2C02637A, _id_08407BDEAF8CE633);
    translationdelta = getmovedelta(_id_62ED904F1FCE7586, 0, _id_5D7268F5F03B60C3);
  }

  self._id_64759B639D9FB8D6 = translationdelta;
}

traversechooseanim(asmname, statename, params) {
  alias = undefined;

  if(self._id_20A0E88052918576 && isDefined(self._id_E2B4FC394EEF5C0F) && isDefined(self._id_2078D7B4461A7A13)) {
    statename = self._id_E2B4FC394EEF5C0F;
    alias = self._id_2078D7B4461A7A13;
  } else {
    _id_AFC9E281D28EDC65 = self setuptraversaltransitioncheck(120);
    calctraversetype(asmname, statename, params);

    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
      _id_FF4E69ED604767FD = distance2d(self._id_64B933AF90EDC53C.origin, self.origin);
    else
      _id_FF4E69ED604767FD = distance2d(self.traversal_start_node.origin, self.origin);

    if(_id_FF4E69ED604767FD < 4)
      self._id_C4EF68FE2A3931E5 = 0;

    statename = self._id_E2B4FC394EEF5C0F;
    alias = self._id_2078D7B4461A7A13;
  }

  return scripts\asm\asm::asm_chooseanim(asmname, statename, alias);
}

handletraversearrivalwarpnotetracks(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "warp_arrival_start")
    return handlewarparrivalnotetrack();
}

handletraversewarpnotetracks(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "traverse_death")
    return handletraversedeathnotetrack();
  else if(_id_A234A65C378F3289 == "warp_arrival_start")
    return handlewarparrivalnotetrack();
  else if(_id_A234A65C378F3289 == "warp_up_start")
    return handlewarpupnotetrack();
  else if(_id_A234A65C378F3289 == "warp_across_start")
    return handlewarpacrossnotetrack();
  else if(_id_A234A65C378F3289 == "warp_down_start")
    return handlewarpdownstartnotetrack();
  else if(_id_A234A65C378F3289 == "warp_down_end")
    return handlewarpdownendnotetrack();
}

handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    _id_D2565459C0E88749 = self.traversedeathanim[self.traversedeathindex];
    scripts\common\ai::set_deathanim(_id_D2565459C0E88749[randomint(_id_D2565459C0E88749.size)]);
    self.traversedeathindex++;
  }
}

handlewarparrivalnotetrack() {
  self animmode("noclip");

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    targetpos = self._id_64B933AF90EDC53C.origin;
    targetangles = self._id_64B933AF90EDC53C.angles;
  } else {
    targetpos = self.traversestartnode.origin;
    targetangles = self.traversestartnode.angles;
  }

  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, targetpos, targetangles, "warp_arrival_start", "warp_arrival_end");
}

handlewarpupnotetrack() {
  self animmode("noclip");

  if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
    targetpos = self._id_64B933AF90EDC53C.origin + self._id_64B933AF90EDC53C.apex_delta;
    targetangles = self._id_64B933AF90EDC53C.angles;
  } else {
    targetpos = self.traversestartnode.origin + self.traversestartnode.apex_delta;
    targetangles = self.traversestartnode.angles;
  }

  if(animhasnotetrack(self.traversexanim, "warp_up_apex")) {
    _id_67B5A24409D655F0 = getnotetracktimes(self.traversexanim, "warp_up_start")[0];
    _id_47B4BDC915CFF70D = getnotetracktimes(self.traversexanim, "warp_up_end")[0];
    animlength = getanimlength(self.traversexanim);
    duration = int((_id_47B4BDC915CFF70D - _id_67B5A24409D655F0) * animlength * 1000);
    scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, targetpos, targetangles, "warp_up_start", "warp_up_apex", duration);
  } else
    scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, targetpos, targetangles, "warp_up_start", "warp_up_end");
}

handlewarpacrossnotetrack() {
  self animmode("noclip");
  endnode = self.traverseendnode;

  if(!isDefined(endnode)) {
    endnode = spawnStruct();
    endnode.angles = self.traversestartnode.angles;
  }

  targetpos = self _meth_AD3C975CB94E4736() + self.traversestartnode.apex_delta + self.traversestartnode.across_delta;
  targetangles = endnode.angles;
  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, targetpos, targetangles, "warp_across_start", "warp_across_end");
}

handlewarpdownstartnotetrack() {
  self animmode("noclip");
  endnode = self.traverseendnode;

  if(!isDefined(endnode)) {
    endnode = spawnStruct();

    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless") {
      endnode.angles = self._id_64B933AF90EDC53C.angles;
      endnode.origin = self._id_E341EF38B14D5CD3;
    } else {
      endnode.angles = self.traversestartnode.angles;
      endnode.origin = self getnegotiationendpos();
    }
  } else if(!isDefined(endnode.origin))
    endnode.origin = self.traversestartnode.end_node_origin;

  _id_67B5A24409D655F0 = getnotetracktimes(self.traversexanim, "warp_down_start")[0];
  _id_47B4BDC915CFF70D = getnotetracktimes(self.traversexanim, "warp_down_end")[0];
  _id_95ABCCFE668F369A = getmovedelta(self.traversexanim, _id_67B5A24409D655F0, _id_47B4BDC915CFF70D);
  _id_95ABCCFE668F369A = rotatevector(_id_95ABCCFE668F369A, endnode.angles);
  _id_2ED406669FBE4377 = 512;
  tracestart = (self.origin[0] + _id_95ABCCFE668F369A[0], self.origin[1] + _id_95ABCCFE668F369A[1], self.origin[2]);
  targetpos = undefined;

  if(isDefined(self._id_70A168924ECCFF58)) {
    targetpos = self._id_70A168924ECCFF58;
    self._id_70A168924ECCFF58 = undefined;
  } else
    targetpos = getgroundposition(tracestart, 10, _id_2ED406669FBE4377, 12);

  _id_49601AB0E39BF185 = 0.05;
  _id_CC2BAF1E6D41C416 = 30;
  _id_61045D8733281EE5 = abs(targetpos[2] - self.origin[2]);

  if(_id_61045D8733281EE5 < _id_49601AB0E39BF185 * abs(_id_95ABCCFE668F369A[2]) || _id_61045D8733281EE5 > _id_CC2BAF1E6D41C416) {
    if(self._id_32A34987EE1B3095 == "nodeless" || self._id_32A34987EE1B3095 == "linkless")
      startpos = self._id_64B933AF90EDC53C.origin;
    else
      startpos = self.traversestartnode.origin;

    if(isDefined(endnode.origin))
      targetpos = endnode.origin;
  }

  _id_249C04BD818FCD81 = self getpointafternegotiation();
  targetangles = endnode.angles;

  if(isDefined(_id_249C04BD818FCD81)) {
    _id_623F3095ECFA11FF = vectortoyaw(_id_249C04BD818FCD81 - endnode.origin);
    _id_822DB80CE3C87A54 = clamp(angleclamp180(_id_623F3095ECFA11FF - self.angles[1]), -30.0, 30.0);
    _id_623F3095ECFA11FF = angleclamp180(self.angles[1] + _id_822DB80CE3C87A54);
    targetangles = (0, _id_623F3095ECFA11FF, 0);
  }

  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, targetpos, targetangles, "warp_down_start", "warp_down_end");
}

handlewarpdownendnotetrack() {
  if(!isagent(self))
    self setanimrate(self.traversexanim, 1);

  self animmode("gravity");
}

checktraverse(statename) {}