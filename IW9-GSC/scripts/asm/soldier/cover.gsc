/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cover.gsc
***********************************************/

shouldcoverexpose() {
  return scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed" && isDefined(self.enemy) && isDefined(self.node);
}

shouldcoverexposedreload(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.covernode) && self.balwayscoverexposed)
    return scripts\asm\asm_bb::bb_reloadrequested();

  return 0;
}

calcanimstartpos(_id_D59CE05D15358F85, _id_2CDC979364D3101C, _id_95ABCCFE668F369A, _id_F73BEA4534A3831F) {
  _id_CE5C9B08861A4466 = _id_2CDC979364D3101C - _id_F73BEA4534A3831F;
  angles = (0, _id_CE5C9B08861A4466, 0);
  _id_728D033793CEA02F = rotatevector(_id_95ABCCFE668F369A, angles);
  return _id_D59CE05D15358F85 - _id_728D033793CEA02F;
}

ishighnode(node) {
  if(!isDefined(node))
    return 0;

  if(node scripts\engine\utility::isvalidpeekoutdir("over"))
    return 0;

  return 1;
}

start_conceal_add(statename, anime, waittime) {
  self endon(statename + "_finished");
  waittime = max(waittime, 0.05);
  wait(waittime);
  self setanim(anime, 1.0, 0.4, 1.0, 1);
  thread conceal_add_cleanup(statename);
}

transitionedfromrun(asmname) {
  _id_71B1F73D9A1BE3A1 = self asmgetstatetransitioningfrom(asmname);

  if(isDefined(_id_71B1F73D9A1BE3A1)) {
    if(_id_71B1F73D9A1BE3A1 == "stand_run_loop")
      return 1;
    else if(scripts\engine\utility::actor_is3d() && _id_71B1F73D9A1BE3A1 == "stand_run_strafe_loop")
      return 1;
  }

  return 0;
}

playcoveranimloop3d(asmname, statename, params) {
  if(!isDefined(self.asm.lastcovernode)) {
    _id_9F34B86D9AC843F4 = [scripts\asm\asm_bb::bb_getcovernode(), self.node];

    for(_id_AC0E594AC96AA3A8 = 0; !isDefined(self.asm.lastcovernode) && _id_AC0E594AC96AA3A8 < _id_9F34B86D9AC843F4.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_9F34B86D9AC843F4[_id_AC0E594AC96AA3A8]) && distancesquared(self.origin, _id_9F34B86D9AC843F4[_id_AC0E594AC96AA3A8].origin) < 256)
        self.asm.lastcovernode = _id_9F34B86D9AC843F4[_id_AC0E594AC96AA3A8];
    }
  }

  playcoveranimloop(asmname, statename, 0.2, params);
}

playcoveranimloop(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(params)) {
    if(params == "stickToNode") {
      covernode = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(covernode)) {
        if(distancesquared(covernode.origin, self.origin) < 16)
          self safeteleport(covernode.origin);
        else
          thread lerpto(covernode, 4, statename + "_finished");
      }

      self.keepclaimednodeifvalid = 0;

      if(transitionedfromrun(asmname))
        self setuseanimgoalweight(0.2);
    }
  }

  if(!isagent(self)) {
    animindex = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, "conceal_add", 0);
    covernode = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(animindex) && isDefined(covernode) && (covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand")) {
      _id_B2C6A031D79506F7 = scripts\asm\asm::asm_getxanim(statename, animindex);
      self setanim(_id_B2C6A031D79506F7, 1.0, 0.2, 1.0, 1);
      thread conceal_add_cleanup(statename);
    }
  }

  scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1);
}

conceal_add_cleanup(statename) {
  self endon("death");
  self endon("entitydeleted");
  self notify("conceal_add_cleanup");
  self endon("conceal_add_cleanup");
  self waittill(statename + "_finished");

  if(archetypehasstate(self._id_AE3EA15396B65C1F, "knobs")) {
    anime = archetypegetalias(self._id_AE3EA15396B65C1F, "knobs", "conceal_add", 0);

    if(isDefined(anime))
      self clearanim(anime.anims, 0.4);
  }
}

lerpto(covernode, _id_2F841227A5CDDE35, _id_A86AC46EF036B2B6) {
  self endon(_id_A86AC46EF036B2B6);

  for(;;) {
    _id_EDA694106BCAFAE6 = covernode.origin - self.origin;
    _id_28660E5725A496A2 = length(_id_EDA694106BCAFAE6);

    if(_id_28660E5725A496A2 < _id_2F841227A5CDDE35) {
      self safeteleport(covernode.origin);
      break;
    }

    _id_EDA694106BCAFAE6 = _id_EDA694106BCAFAE6 / _id_28660E5725A496A2;
    _id_815D30728A6EF9D9 = self.origin + _id_EDA694106BCAFAE6 * _id_2F841227A5CDDE35;
    self safeteleport(_id_815D30728A6EF9D9);
    wait 0.05;
  }
}

terminatecoverreload(asmname, statename, params) {
  scripts\asm\asm::asm_fireephemeralevent("reload", "end");
  self _meth_4EA7891F787C6725();
  scripts\asm\soldier\script_funcs::reload_cleanup(asmname, statename, params);
}

playcoveranim_droprpg(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  _id_0D6DD63CEFB3C4EE = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_066AEBE1D33F3B18 = scripts\asm\asm::asm_getxanim(statename, _id_0D6DD63CEFB3C4EE);
  self orientmode("face current");
  self aisetanim(statename, _id_0D6DD63CEFB3C4EE);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_066AEBE1D33F3B18);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

playshuffleloop(asmname, statename, params) {
  _id_946CBAC627C6D79D = [];
  _id_946CBAC627C6D79D["crouch_shuffle_right"] = -90;
  _id_946CBAC627C6D79D["crouch_shuffle_left"] = 90;
  _id_946CBAC627C6D79D["stand_shuffle_right"] = -90;
  _id_946CBAC627C6D79D["stand_shuffle_left"] = 90;
  self endon(statename + "_finished");
  _id_6C3DAA22F3C8F9C3 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_9DEF5B8F72499C7F = scripts\asm\asm::asm_getxanim(statename, _id_6C3DAA22F3C8F9C3);
  self aisetanim(statename, _id_6C3DAA22F3C8F9C3);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_9DEF5B8F72499C7F);

  if(isDefined(self._blackboard.shufflenode))
    _id_7F55545F660EF1BB = self._blackboard.shufflenode.angles[1];
  else if(isDefined(self.node))
    _id_7F55545F660EF1BB = self.node.angles[1];
  else
    _id_7F55545F660EF1BB = self.angles[1];

  if(self.unittype != "c6" && isDefined(_id_946CBAC627C6D79D[statename]))
    _id_7F55545F660EF1BB = _id_7F55545F660EF1BB + _id_946CBAC627C6D79D[statename];

  self orientmode("face angle", _id_7F55545F660EF1BB);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

shouldplayshuffleenter(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_E7097D92847C054C = scripts\asm\asm::asm_getrandomanim(asmname, _id_F2B19B25D457C2A6);
  _id_FCA130E132110162 = scripts\asm\asm::asm_getxanim(_id_F2B19B25D457C2A6, _id_E7097D92847C054C);
  _id_0F63319923B121D0 = getmovedelta(_id_FCA130E132110162);
  _id_09E00FAC7AA4E669 = lengthsquared(_id_0F63319923B121D0);
  _id_04C0CC4FCEBFCE3F = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return _id_09E00FAC7AA4E669 <= _id_04C0CC4FCEBFCE3F + 1;
}

abortshufflecleanup(asmname, statename, params) {
  self._blackboard.shufflenode = undefined;
}

shouldbeginshuffleexit(asmname, statename, _id_F2B19B25D457C2A6, params) {
  shufflefromnode = self.prevcovernode;

  if(!isDefined(shufflefromnode))
    shufflefromnode = self.covernode;

  nodetype = self._blackboard.shufflenode.type;

  if(isDefined(nodetype) && (nodetype == "Cover Crouch" || nodetype == "Cover Crouch Window" || nodetype == "Conceal Crouch")) {
    _id_6686D1519FD59C8D = getDvar("dvar_F72DDE9792B94CC9");

    if(isDefined(self.node.covercrouchtype))
      nodetype = self.node.covercrouchtype;
    else if(_id_6686D1519FD59C8D != "")
      nodetype = _id_6686D1519FD59C8D;
  }

  if(isDefined(params) && nodetype != params)
    return 0;

  _id_457A0F528BFF306C = scripts\asm\asm::asm_getrandomanim(asmname, _id_F2B19B25D457C2A6);
  _id_315D9A31B78A7F02 = scripts\asm\asm::asm_getxanim(statename, _id_457A0F528BFF306C);
  _id_7B749C88C64B98DC = self._blackboard.shufflenode.origin - self.origin;
  _id_FDB33DE9295FE291 = vectorNormalize(_id_7B749C88C64B98DC);
  _id_D56A0B3C801F0BF6 = getmovedelta(_id_315D9A31B78A7F02, 0, 1);
  _id_B1151BC68AF15725 = length(_id_D56A0B3C801F0BF6);
  goalpos = self._blackboard.shufflenode.origin - _id_FDB33DE9295FE291 * _id_B1151BC68AF15725;
  _id_7B749C88C64B98DC = goalpos - self.origin;
  _id_97698266774F21AC = self._blackboard.shufflenode.origin - shufflefromnode.origin;
  _id_97698266774F21AC = (_id_97698266774F21AC[0], _id_97698266774F21AC[1], 0);

  if(vectordot(_id_97698266774F21AC, _id_7B749C88C64B98DC) <= 0)
    return 1;

  if(length2dsquared(self.velocity) > 1 && vectordot(_id_FDB33DE9295FE291, self.velocity) <= 0)
    return 1;

  return 0;
}

playshuffleanim_arrival(asmname, statename, params) {
  self.a.arrivalasmstatename = statename;
  _id_DFC9621BD0B654BF = scripts\asm\asm::asm_getanim(asmname, statename);
  arrivalxanim = scripts\asm\asm::asm_getxanim(statename, _id_DFC9621BD0B654BF);
  self aisetanim(statename, _id_DFC9621BD0B654BF);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, arrivalxanim);
  _id_773BBE3E674F23B7 = getmovedelta(arrivalxanim);
  _id_9E90966804914DEA = getangledelta3d(arrivalxanim);

  if(isDefined(self._blackboard.shufflenode))
    node = self._blackboard.shufflenode;
  else
    node = self.node;

  if(isDefined(node)) {
    _id_C08AAF5A9F6EF804 = node.origin;
    _id_611D21936599BC82 = (0, scripts\asm\shared\utility::getnodeforwardyaw(node), 0);
    _id_83DA498EE1B4F7FB = combineangles(_id_611D21936599BC82, invertangles(_id_9E90966804914DEA));
    _id_3DE691449164F7EB = node.origin - rotatevector(_id_773BBE3E674F23B7, _id_83DA498EE1B4F7FB);
  } else {
    _id_C08AAF5A9F6EF804 = self.origin + _id_773BBE3E674F23B7;
    _id_611D21936599BC82 = combineangles(self.angles, _id_9E90966804914DEA);
    _id_3DE691449164F7EB = self.origin;
    _id_83DA498EE1B4F7FB = self.angles;
  }

  _id_6040E7EBA5E09557 = int(1000 * getanimlength(arrivalxanim) - 200);
  self startcoverarrival();
  self motionwarpwithanim(_id_3DE691449164F7EB, _id_83DA498EE1B4F7FB, _id_C08AAF5A9F6EF804, _id_611D21936599BC82, _id_6040E7EBA5E09557);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

playshuffleanim_terminate(asmname, statename, params) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.shufflefromnode = undefined;
  self finishcoverarrival();
}

coverreloadnotetrackhandler(_id_A234A65C378F3289) {
  _id_357B9A54DFEDBD4A::notetrack_prefix_handler(_id_A234A65C378F3289);
  return undefined;
}

cover3dpickexposedir(asmname, statename, _id_F2B19B25D457C2A6, params) {
  self.bt.cover3dexposedirpicked = undefined;
  _id_A2825DE7E3791A80 = (self.enemy.origin + _id_2B79931B08683E0A::getenemyeyepos()) / 2;
  current_state = anim.asm[asmname].states[_id_F2B19B25D457C2A6];
  _id_EEB5EBBB83F5768D = scripts\engine\utility::array_randomize(current_state.transitions);
  _id_D34161275B1730C1 = undefined;

  foreach(_id_C8AFEAED872F1486 in _id_EEB5EBBB83F5768D) {
    _id_D34161275B1730C1 = _id_C8AFEAED872F1486.shouldtransitionparams;

    if(_id_D34161275B1730C1 == "up") {
      break;
    }

    _id_B3E742AC78B00246 = _id_2B79931B08683E0A::getcover3dnodeoffset(self.node, _id_D34161275B1730C1);
    _id_ECD488C76CF5E978 = self.node.origin + _id_B3E742AC78B00246;

    if(sighttracepassed(_id_ECD488C76CF5E978, _id_A2825DE7E3791A80, 0, undefined)) {
      break;
    }
  }

  self.bt.cover3dexposedirpicked = asmname + "_" + _id_F2B19B25D457C2A6 + "_" + _id_D34161275B1730C1;
  return 1;
}

cover3dcanexposedir(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_B045478FAD8648FE = asmname + "_" + statename + "_" + params;
  return _id_B045478FAD8648FE == self.bt.cover3dexposedirpicked;
}

checkcovermultichangerequest(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!scripts\asm\asm_bb::bb_iscovermultiswitchrequested())
    return 0;

  covernode = scripts\asm\asm_bb::bb_getcovernode();
  requestednodetype = scripts\asm\asm_bb::bb_getrequestedcovermultiswitchnodetype();

  if(requestednodetype != params)
    return 0;

  self.asm.covermultiswitchdata = spawnStruct();
  self.asm.covermultiswitchdata.requestednode = covernode;
  self.asm.covermultiswitchdata.requestednodetype = requestednodetype;
  return 1;
}

finishcovermultichangerequest(asmname, statename, params) {
  requestednodetype = self.asm.covermultiswitchdata.requestednodetype;
  self.asm.covermultiswitchdata.requestednode setcovermultinodetype(requestednodetype);
  self.asm.covermultiswitchdata = undefined;
  self _meth_4EA7891F787C6725();
}