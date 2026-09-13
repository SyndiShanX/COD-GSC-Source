/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\traverse.gsc
***********************************************/

playtraverseanim_deprecated(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  scripts\asm\traverse::checktraverse(statename);
  traverseanim = scripts\asm\asm::asm_getanim(asmname, statename);
  traversexanim = scripts\asm\asm::asm_getxanim(statename, traverseanim);
  self.desired_anim_pose = "crouch";
  _id_7E4D332E911E1B90::updateanimpose();
  self endon("killanimscript");
  self animmode("noclip");
  startnode = self getnegotiationstartnode();
  self orientmode("face angle", startnode.angles[1]);
  startnode.traverse_height = startnode.origin[2] + startnode.traverse_height_delta;
  _id_4587095419257A6E = startnode.traverse_height - startnode.origin[2];
  thread scripts\asm\traverse::teleportthread(_id_4587095419257A6E - params);
  _id_D180B535A33B044D = 0.15;
  self aisetanim(statename, traverseanim);
  _id_22943623B8E97C62 = 0.2;
  _id_1E0F9EC2AC420034 = 0.2;
  thread traverse_donotetracks(asmname, statename);

  if(!animhasnotetrack(traversexanim, "gravity on")) {
    _id_CC694B7FBBF6503C = 1.23;
    wait(_id_CC694B7FBBF6503C - _id_22943623B8E97C62);
    self animmode("gravity");
    wait(_id_22943623B8E97C62);
  } else {
    self waittillmatch("traverse", "gravity on");
    self animmode("gravity");

    if(!animhasnotetrack(traversexanim, "blend"))
      wait(_id_22943623B8E97C62);
    else
      self waittillmatch("traverse", "blend");
  }

  scripts\asm\traverse::terminatetraverse(asmname, statename);
}

playtraverseanim(asmname, statename, params) {
  traverseanim = scripts\asm\asm::asm_getanim(asmname, statename);
  scripts\asm\traverse::checktraverse(statename);
  self animmode("noclip");
  startnode = self getnegotiationstartnode();
  self orientmode("face angle", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
  scripts\asm\traverse::terminatetraverse(asmname, statename);
}

playtraverseanim_doublejump(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  _id_3016B22139446579 = getdvarint("ai_debug_doublejump", 0);

  if(_id_3016B22139446579 != 3 && _id_3016B22139446579 != 4)
    scripts\asm\traverse::checktraverse(statename);

  self.ragdoll_immediate = 1;
  start_node = self getnegotiationstartnode();
  _id_E14AC44F6F147496 = self getnegotiationendpos();
  start_node.traverse_height = start_node.origin[2] + start_node.traverse_height_delta - 44;
  _id_559DF5F9875A294E = [];

  if(start_node.traverse_height > _id_E14AC44F6F147496[2]) {
    _id_444C050F4F499268 = (start_node.origin[0] + _id_E14AC44F6F147496[0]) * 0.5;
    _id_444C060F4F49949B = (start_node.origin[1] + _id_E14AC44F6F147496[1]) * 0.5;
    _id_559DF5F9875A294E[_id_559DF5F9875A294E.size] = (_id_444C050F4F499268, _id_444C060F4F49949B, start_node.traverse_height);
  }

  _id_559DF5F9875A294E[_id_559DF5F9875A294E.size] = _id_E14AC44F6F147496;
  _id_4C5664C0523213F2 = spawn("script_model", start_node.origin);
  _id_4C5664C0523213F2 setModel("tag_origin");
  _id_4C5664C0523213F2.angles = start_node.angles;
  thread scripts\engine\utility::delete_on_death(_id_4C5664C0523213F2);
  self orientmode("face angle", start_node.angles[1]);
  max_time = 1.63;
  self linkTo(_id_4C5664C0523213F2);
  _id_2D08B404190FFB34 = scripts\asm\asm::asm_getanim(asmname, statename);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, scripts\asm\asm::asm_getxanim(_id_2D08B404190FFB34));
  self aisetanim(statename, _id_2D08B404190FFB34);
  thread traverse_donotetracks(asmname, statename);

  foreach(org in _id_559DF5F9875A294E) {
    _id_69E534485EF2759C = max_time / _id_559DF5F9875A294E.size;
    _id_4C5664C0523213F2 moveTo(org, _id_69E534485EF2759C);
    _id_4C5664C0523213F2 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self.ragdoll_immediate = undefined;
  _id_4C5664C0523213F2 delete();
  thread scripts\asm\traverse::terminatetraverse(asmname, statename);
}

traverse_doublejump_cleanup(asmname, statename, params) {
  self unlink();
  self.ragdoll_immediate = undefined;
}

traverse_donotetracks(asmname, statename) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  self endon("double_jumped");
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

getexternaltraverseinfo(_id_57EE0A2AA16AC4D4) {
  return level.scr_traverse[_id_57EE0A2AA16AC4D4];
}

playtraverseanim_external(asmname, statename, params) {
  scripts\asm\traverse::playtraverseanim_scaled(asmname, statename);
}

choosetraverseanim_external(asmname, statename, params) {
  startnode = self getnegotiationstartnode();
  _id_57EE0A2AA16AC4D4 = startnode.animscript;

  if(isDefined(level._id_2A12779877C8C257) && isDefined(level._id_2A12779877C8C257[_id_57EE0A2AA16AC4D4])) {
    xanim = [[level._id_2A12779877C8C257[_id_57EE0A2AA16AC4D4]]](asmname, statename, params);
    return xanim;
  }

  _id_834052777BD0A810 = getexternaltraverseinfo(_id_57EE0A2AA16AC4D4);
  return _id_834052777BD0A810;
}

playdoublejumpfinishanim(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
  thread scripts\asm\traverse::terminatetraverse(asmname, statename);
}

getdoublejumpoffsetposition(asmname, _id_223EFA34C2B82DC8, endpos, endangles, _id_2EB9987D197DE143) {
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_chooseanim(asmname, _id_223EFA34C2B82DC8);
  xanim = scripts\asm\asm::asm_getxanim(_id_223EFA34C2B82DC8, _id_2C8936D08F85C5C1);
  _id_926D6D611F7FF7AB = getnotetracktimes(xanim, _id_2EB9987D197DE143);
  time = _id_926D6D611F7FF7AB[0];
  _id_95ABCCFE668F369A = getmovedelta(xanim, 0, time);
  _id_F73BEA4534A3831F = getangledelta(xanim, 0, time);
  return scripts\asm\soldier\cover::calcanimstartpos(endpos, endangles[1], _id_95ABCCFE668F369A, _id_F73BEA4534A3831F);
}

doublejumpneedsfinishanim(asmname, _id_7130B2131FEE9BDA, startnode, endpos) {
  _id_3B6BDE41CED8616D = endpos[2] - startnode.origin[2];

  if(_id_3B6BDE41CED8616D < 0)
    return 0;

  if(isDefined(startnode.jump_over_offset) && getdvarint("ai_debug_doublejump", 0) != 2) {
    jump_over_offset = startnode.jump_over_offset;
    angleoffset = startnode.angles - startnode.startnodeoriginalangles;

    if(angleoffset != (0, 0, 0))
      jump_over_offset = rotatevector(jump_over_offset, angleoffset);

    jump_over_position = startnode.origin + jump_over_offset;
    _id_E5E2B98A87142185 = jump_over_position[2];
    _id_E5E2B98A87142185 = _id_E5E2B98A87142185 - 44;

    if(endpos[2] < _id_E5E2B98A87142185)
      return 0;
  }

  _id_3777ECE6A73EADA5 = endpos - startnode.origin;
  _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  _id_4D932CFABB42EEF4 = getdoublejumpoffsetposition(asmname, _id_7130B2131FEE9BDA, endpos, _id_F1A4D9D10FD4B365, "footstep_left_small");
  _id_992DCA4693DCC459 = _id_4D932CFABB42EEF4 - startnode.origin;

  if(vectordot(_id_992DCA4693DCC459, _id_3777ECE6A73EADA5) < 0)
    return 0;

  return 1;
}

checkdoublejumpfinish(asmname, statename, _id_F2B19B25D457C2A6, params) {
  startnode = gettraversalstartnode();

  if(!isDefined(startnode)) {
    thread scripts\asm\traverse::terminatetraverse(asmname, "double_jump");
    return 0;
  }

  endpos = self getnegotiationendpos();

  if(!doublejumpneedsfinishanim(asmname, _id_F2B19B25D457C2A6, startnode, endpos)) {
    thread scripts\asm\traverse::terminatetraverse(asmname, "double_jump");
    return 0;
  }

  return 1;
}

gettraversalstartnode() {
  if(isDefined(self.traversal_start_node))
    return self.traversal_start_node;

  return self getnegotiationstartnode();
}

playdoublejumpmantleorvault(asmname, statename, zoffset) {
  self endon(statename + "_finished");
  startnode = gettraversalstartnode();
  endpos = startnode.doublejumpmantlepos;
  _id_3777ECE6A73EADA5 = endpos - startnode.origin;
  _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  _id_2D08B404190FFB34 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_7130B2131FEE9BDA = statename + "_finish";
  _id_3B137C718EA27788 = getdoublejumpoffsetposition(asmname, _id_7130B2131FEE9BDA, endpos, _id_F1A4D9D10FD4B365, "mantle_align");
  _id_3B137C718EA27788 = (_id_3B137C718EA27788[0], _id_3B137C718EA27788[1], _id_3B137C718EA27788[2] + zoffset);
  playscaledjump(asmname, statename, _id_2D08B404190FFB34, _id_3B137C718EA27788, _id_F1A4D9D10FD4B365, 1, 0, 1);
}

playdoublejumpmantle(asmname, statename, params) {
  playdoublejumpmantleorvault(asmname, statename, -8);
}

playdoublejumpvault(asmname, statename, params) {
  playdoublejumpmantleorvault(asmname, statename, -42);
}

doublejumpterminate(asmname, statename, params) {
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
}

doublejumpearlyterminate(asmname, statename, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
    doublejumpterminate(asmname, statename, params);
}

isdoublejumpanimdone(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm::asm_eventfired(asmname, "end");
}

playdoublejumptraversal(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = gettraversalstartnode();
  endpos = self getnegotiationendpos();

  if(!isDefined(startnode.startnodeoriginalangles))
    startnode.startnodeoriginalangles = startnode.angles;

  angleoffset = startnode.angles - startnode.startnodeoriginalangles;

  if(angleoffset != (0, 0, 0))
    endpos = rotatevector(endpos, angleoffset);

  jump_over_position = undefined;
  _id_3016B22139446579 = getdvarint("ai_debug_doublejump", 0);

  if(_id_3016B22139446579 != 2) {
    if(isDefined(startnode.jump_over_offset)) {
      jump_over_offset = startnode.jump_over_offset;

      if(angleoffset != (0, 0, 0))
        jump_over_offset = rotatevector(jump_over_offset, angleoffset);

      jump_over_position = startnode.origin + jump_over_offset;
      _id_E5E2B98A87142185 = jump_over_position[2];
      _id_E5E2B98A87142185 = _id_E5E2B98A87142185 - 44;

      if(_id_E5E2B98A87142185 > endpos[2]) {
        _id_444C050F4F499268 = (startnode.origin[0] + endpos[0]) * 0.5;
        _id_444C060F4F49949B = (startnode.origin[1] + endpos[1]) * 0.5;
        jump_over_position = (_id_444C050F4F499268, _id_444C060F4F49949B, jump_over_position[2]);
      } else
        jump_over_position = undefined;
    }
  }

  _id_2D08B404190FFB34 = scripts\asm\asm::asm_getanim(asmname, statename);
  self.jump_over_position = jump_over_position;
  _id_7130B2131FEE9BDA = statename + "_finish";

  if(doublejumpneedsfinishanim(asmname, _id_7130B2131FEE9BDA, startnode, endpos)) {
    _id_3777ECE6A73EADA5 = endpos - startnode.origin;
    _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
    _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
    _id_7130B2131FEE9BDA = statename + "_finish";
    _id_4D932CFABB42EEF4 = getdoublejumpoffsetposition(asmname, _id_7130B2131FEE9BDA, endpos, _id_F1A4D9D10FD4B365, "footstep_left_small");
    endpos = _id_4D932CFABB42EEF4;
  }

  _id_3777ECE6A73EADA5 = endpos - startnode.origin;
  _id_4C4C6C6D3C2B086B = 0;
  animendtime = 1.0;

  if(_id_3777ECE6A73EADA5[2] < 0) {
    _id_4C4C6C6D3C2B086B = 1;
    _id_C4D9C443202BF996 = getnotetracktimes(scripts\asm\asm::asm_getxanim(statename, _id_2D08B404190FFB34), "gravity on");

    if(isDefined(_id_C4D9C443202BF996) && _id_C4D9C443202BF996.size > 0)
      animendtime = _id_C4D9C443202BF996[0];
  }

  _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  playscaledjump(asmname, statename, _id_2D08B404190FFB34, endpos, _id_F1A4D9D10FD4B365, animendtime, _id_4C4C6C6D3C2B086B, 1);
}

choosedoublejumpanim(asmname, statename, params) {
  endpos = self getnegotiationendpos();
  alias = "double_jump_up";

  if(isDefined(params))
    alias = "double_jump_" + params;
  else if(endpos[2] < self.origin[2])
    alias = "double_jump_down";

  if(self.asm.footsteps.foot == "right")
    _id_DEC9BCCE93873125 = "right_";
  else
    _id_DEC9BCCE93873125 = "left_";

  alias = _id_DEC9BCCE93873125 + alias;
  animname = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return animname;
}

getwallnodeposition(startnode, index) {
  angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;

  if(angleoffset != (0, 0, 0)) {
    _id_728D033793CEA02F = rotatevector(startnode.wall_info.nodeoffsets[index], angleoffset);
    _id_76A8010A974FA50E = startnode.origin + _id_728D033793CEA02F;
  } else
    _id_76A8010A974FA50E = startnode.origin + startnode.wall_info.nodeoffsets[index];

  return _id_76A8010A974FA50E;
}

shouldwallrunshoot(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.enemy))
    return 0;

  _id_D59ED0E8C57E2DEF = self.enemy.origin;
  startnode = self.traversal_start_node;
  _id_032386D797E03A9B = getwallnodeposition(startnode, self.wall_run_current_node_index);
  _id_5C6241C759F06574 = getwallnodeposition(startnode, self.wall_run_current_node_index + 1);
  _id_5C6241C759F06574 = (_id_5C6241C759F06574[0], _id_5C6241C759F06574[1], _id_032386D797E03A9B[2]);
  _id_D59ED0E8C57E2DEF = (_id_D59ED0E8C57E2DEF[0], _id_D59ED0E8C57E2DEF[1], _id_032386D797E03A9B[2]);
  _id_51C78B431F0E5118 = vectorNormalize(_id_5C6241C759F06574 - _id_032386D797E03A9B);
  _id_B3BCA3E7F11A1CCE = vectorNormalize(_id_D59ED0E8C57E2DEF - _id_032386D797E03A9B);
  dot = vectordot(_id_51C78B431F0E5118, _id_B3BCA3E7F11A1CCE);

  if(dot < 0.2588)
    return 0;

  return 1;
}

choosewallrunanim(asmname, statename, params) {
  _id_2D08B404190FFB34 = scripts\asm\asm::asm_lookupanimfromalias(statename, self.wall_run_direction);
  return _id_2D08B404190FFB34;
}

getsmoothstep(_id_3777ECE6A73EADA5) {
  return _id_3777ECE6A73EADA5 * _id_3777ECE6A73EADA5 * (3 - 2 * _id_3777ECE6A73EADA5);
}

teleportdeltaovernumframes(statename, waittime, _id_3777ECE6A73EADA5, _id_7E3211AE44B15B55, animname, _id_C08B84490B532FB2) {
  self endon(statename + "_finished");

  if(waittime > 0)
    wait(waittime);

  _id_817AC15FA1ACB594 = _id_3777ECE6A73EADA5 / _id_7E3211AE44B15B55;
  startpos = self.origin[2];
  endpos = startpos + _id_3777ECE6A73EADA5[2];
  _id_D7B27CF20A29D5ED = self.origin[2];
  self setanimrate(animname, _id_C08B84490B532FB2);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7E3211AE44B15B55; _id_AC0E594AC96AA3A8++) {
    _id_3897E5E4048F4E94 = 1;

    if(_id_3897E5E4048F4E94) {
      _id_B1D0BC03029F6A2C = _id_AC0E594AC96AA3A8 / (_id_7E3211AE44B15B55 - 1);
      smoothstep = getsmoothstep(_id_B1D0BC03029F6A2C);
      _id_F7CD975C75C5D625 = endpos * smoothstep + startpos * (1 - smoothstep);
      _id_BC77FC372E8358F9 = _id_F7CD975C75C5D625 - _id_D7B27CF20A29D5ED;
      _id_817AC15FA1ACB594 = (_id_817AC15FA1ACB594[0], _id_817AC15FA1ACB594[1], _id_BC77FC372E8358F9);
      _id_D7B27CF20A29D5ED = _id_F7CD975C75C5D625;
    }

    _id_A9706ADAF7C52E27 = self.origin + _id_817AC15FA1ACB594;
    self forceteleport(_id_A9706ADAF7C52E27);

    if(_id_AC0E594AC96AA3A8 + 1 < _id_7E3211AE44B15B55)
      waitframe();
  }

  self setanimrate(animname, 1);
}

wallrunnotehandler(_id_A234A65C378F3289, params) {
  if(_id_A234A65C378F3289 == "start_jump")
    thread handlejumpteleports(params);
  else if(_id_A234A65C378F3289 == "end_mantle")
    self animmode("gravity");
}

handlejumpteleports(params, _id_EB5B1F36E255152D, _id_C08B84490B532FB2) {
  statename = params[0];
  animname = params[1];
  _id_C08AAF5A9F6EF804 = params[2];
  starttime = params[3];
  _id_8C2C7EA3BD382DF4 = params[4];
  _id_4C4C6C6D3C2B086B = params[5];
  _id_87EF9FDEB401C595 = params[6];
  self endon(statename + "_finished");
  animlength = getanimlength(animname);

  if(!isDefined(_id_EB5B1F36E255152D))
    _id_EB5B1F36E255152D = (gettime() - starttime) * 0.001;

  _id_F2B13AB0EDED36C8 = _id_EB5B1F36E255152D / animlength;
  _id_CAB4A622D5AF2E97 = getnotetracktimes(animname, "end_jump");
  _id_930CAEF7352C0F86 = getnotetracktimes(animname, "end_double_jump");

  if(_id_930CAEF7352C0F86.size > 0) {
    self.wall_run_double_jumping = 1;
    _id_CAB4A622D5AF2E97 = _id_930CAEF7352C0F86;
  } else
    self.wall_run_double_jumping = 0;

  if(isDefined(self.jump_over_position)) {
    _id_8C2C7EA3BD382DF4 = (_id_CAB4A622D5AF2E97[0] - _id_F2B13AB0EDED36C8) / 2 + _id_F2B13AB0EDED36C8;
    _id_CAB4A622D5AF2E97[0] = _id_8C2C7EA3BD382DF4;
    _id_C08AAF5A9F6EF804 = self.jump_over_position;
  }

  movedelta = getmovedelta(animname, _id_F2B13AB0EDED36C8, _id_8C2C7EA3BD382DF4);
  _id_F6DCC71C82566CD5 = self localtoworldcoords(movedelta);

  if(!isDefined(_id_C08B84490B532FB2))
    _id_C08B84490B532FB2 = 1;

  if(_id_87EF9FDEB401C595) {
    _id_044A93F09B80B3AE = distance(self.origin, _id_F6DCC71C82566CD5);
    _id_03D5C613A9500564 = distance(self.origin, _id_C08AAF5A9F6EF804);
    _id_C08B84490B532FB2 = _id_044A93F09B80B3AE / _id_03D5C613A9500564;

    if(_id_C08B84490B532FB2 < 0.7)
      _id_C08B84490B532FB2 = 0.7;
    else if(_id_C08B84490B532FB2 > 1.3)
      _id_C08B84490B532FB2 = 1.3;
  }

  _id_04F37A7756EC2161 = _id_C08AAF5A9F6EF804 - _id_F6DCC71C82566CD5;
  _id_E7F1395489E50FC7 = _id_CAB4A622D5AF2E97[0] * animlength;
  _id_1D68F4358CE9D989 = _id_E7F1395489E50FC7 - _id_F2B13AB0EDED36C8 * animlength;
  _id_1D68F4358CE9D989 = _id_1D68F4358CE9D989 * (1 / _id_C08B84490B532FB2);
  _id_7E3211AE44B15B55 = _id_1D68F4358CE9D989 * 20;
  _id_7E3211AE44B15B55 = ceil(_id_7E3211AE44B15B55);
  _id_E6E3302C3FAB30F3 = gettime();
  teleportdeltaovernumframes(statename, 0, _id_04F37A7756EC2161, _id_7E3211AE44B15B55, animname, _id_C08B84490B532FB2);

  if(isDefined(self.jump_over_position)) {
    _id_B5B8FD952B4DEB49 = (gettime() - _id_E6E3302C3FAB30F3) * _id_C08B84490B532FB2;
    _id_15D48E620B386A45 = _id_EB5B1F36E255152D + _id_B5B8FD952B4DEB49 * 0.001;
    self.jump_over_position = undefined;
    params[6] = 0;
    handlejumpteleports(params, _id_15D48E620B386A45, _id_C08B84490B532FB2);
  }
}

getwallrunyawfromstartnode(startnode) {
  _id_3777ECE6A73EADA5 = getwallnodeposition(startnode, 1) - getwallnodeposition(startnode, 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  return _id_F1A4D9D10FD4B365[1];
}

getwallrundirectionfromstartnode(startnode) {
  self.wall_run_current_node_index = 0;
  _id_3777ECE6A73EADA5 = getwallnodeposition(startnode, 1) - getwallnodeposition(startnode, 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  self.wall_run_yaw = _id_F1A4D9D10FD4B365[1];
  _id_81AA7E8BC8F8C030 = getwallnodeposition(startnode, self.wall_run_current_node_index);
  right = anglestoright(_id_F1A4D9D10FD4B365);
  dir = _id_81AA7E8BC8F8C030 - startnode.origin;
  dot = vectordot(right, dir);

  if(dot > 0)
    return "right";

  return "left";
}

setupwallrunifneeded() {
  if(isDefined(self.wall_run_direction)) {
    return;
  }
  if(!isDefined(self.traversal_start_node))
    self.traversal_start_node = self getnegotiationstartnode();

  startnode = self.traversal_start_node;
  self.wall_run_direction = getwallrundirectionfromstartnode(startnode);
}

getwallrundirection() {
  setupwallrunifneeded();
  return self.wall_run_direction;
}

wallrunterminate(asmname, statename, params) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
}

traversalorientearlyterminate(asmname, statename, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "end") && !scripts\asm\asm::asm_eventfired(asmname, "code_move")) {
    self.traversal_start_node = undefined;
    self.wall_run_direction = undefined;
  }
}

playwallrunattach(asmname, statename, params) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(params) && params == "shoot")
    setupwallrunaimlimits();

  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  _id_BF02A06228E2E48E = getnotetracktimes(xanim, "wall_contact");
  time = _id_BF02A06228E2E48E[0];
  angledelta = getangledelta(xanim, 0, time);
  _id_D4C3D11EC9988C73 = self.wall_run_yaw - angledelta;
  _id_34A46042D4886070 = (0, _id_D4C3D11EC9988C73, 0);
  self forceteleport(self.origin, _id_34A46042D4886070);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

getwallattachoffsetposition(asmname) {
  animname = choosewallattachanim(asmname, "wall_run_attach");
  _id_BF02A06228E2E48E = getnotetracktimes(animname, "wall_contact");
  time = _id_BF02A06228E2E48E[0];
  _id_95ABCCFE668F369A = getmovedelta(animname, 0, time);
  _id_F73BEA4534A3831F = getangledelta(animname, 0, time);
  return scripts\asm\soldier\cover::calcanimstartpos(getwallnodeposition(self.traversal_start_node, 0), self.wall_run_yaw, _id_95ABCCFE668F369A, _id_F73BEA4534A3831F);
}

playwallrunenter(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  startnode = self.traversal_start_node;
  self.wall_run_current_node_index = 0;
  _id_086FCA619BA5C4A5 = getwallnodeposition(startnode, 0);
  _id_3777ECE6A73EADA5 = _id_086FCA619BA5C4A5 - self.origin;
  _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
  _id_F1A4D9D10FD4B365 = vectortoangles(_id_3777ECE6A73EADA5);
  _id_FEC5C3566EC9F0E3 = getwallattachoffsetposition();
  self orientmode("face angle", _id_F1A4D9D10FD4B365[1]);
  animendtime = 1.0;
  _id_DEF9680D43BE7384 = getnotetracktimes(xanim, "code_move");

  if(isDefined(_id_DEF9680D43BE7384) && _id_DEF9680D43BE7384.size > 0)
    animendtime = _id_DEF9680D43BE7384[0];

  playscaledjump(asmname, statename, _id_2C8936D08F85C5C1, _id_FEC5C3566EC9F0E3, _id_F1A4D9D10FD4B365, animendtime, 0, 1);
  self forceteleport(_id_FEC5C3566EC9F0E3, _id_F1A4D9D10FD4B365);
}

playscaledjump(asmname, statename, _id_2C8936D08F85C5C1, _id_A41FA8F1437BAEAE, _id_F1A4D9D10FD4B365, _id_8C2C7EA3BD382DF4, _id_4C4C6C6D3C2B086B, _id_87EF9FDEB401C595) {
  self endon(statename + "_finished");

  if(!isDefined(_id_8C2C7EA3BD382DF4))
    _id_8C2C7EA3BD382DF4 = 1;

  if(!isDefined(_id_4C4C6C6D3C2B086B))
    _id_4C4C6C6D3C2B086B = 0;

  if(!isDefined(_id_87EF9FDEB401C595))
    _id_87EF9FDEB401C595 = 0;

  self forceteleport(self.origin, _id_F1A4D9D10FD4B365);
  self animmode("noclip");
  self orientmode("face angle", _id_F1A4D9D10FD4B365[1]);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  self.useanimgoalweight = 1;
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  _id_0847A224D4AAD486 = [statename, xanim, _id_A41FA8F1437BAEAE, gettime(), _id_8C2C7EA3BD382DF4, _id_4C4C6C6D3C2B086B, _id_87EF9FDEB401C595];
  scripts\asm\asm::asm_donotetracks(asmname, statename, ::wallrunnotehandler, _id_0847A224D4AAD486);
}

choosewallattachanim(asmname, statename, params) {
  if(isDefined(self.wall_run_attach_anim))
    return self.wall_run_attach_anim;

  aliasname = self.wall_run_direction;
  _id_5BABFFA7F03CE512 = angleclamp180(self.wall_run_yaw - self.angles[1]);
  _id_5BABFFA7F03CE512 = abs(_id_5BABFFA7F03CE512);

  if(_id_5BABFFA7F03CE512 >= 22.5) {
    if(_id_5BABFFA7F03CE512 > 67.5)
      aliasname = aliasname + "_90";
    else
      aliasname = aliasname + "_45";
  }

  self.wall_run_attach_anim = scripts\asm\asm::asm_lookupanimfromalias(statename, aliasname);
  return self.wall_run_attach_anim;
}

choosewallrunenteranim(asmname, statename, params) {
  setupwallrunifneeded();
  alias = self.wall_run_direction;
  startnode = self.traversal_start_node;
  _id_15E16054CAEFC232 = getwallnodeposition(startnode, 0);
  _id_61045D8733281EE5 = _id_15E16054CAEFC232[2] - self.origin[2];
  _id_B15CD98E18D1A870 = 0;

  if(_id_61045D8733281EE5 >= 0) {
    if(_id_61045D8733281EE5 > 120)
      _id_B15CD98E18D1A870 = 1;
  } else if(0 - _id_61045D8733281EE5 > 240)
    _id_B15CD98E18D1A870 = 1;

  if(_id_B15CD98E18D1A870 == 0) {
    distsq = distancesquared(self.origin, _id_15E16054CAEFC232);

    if(distsq > 40000)
      _id_B15CD98E18D1A870 = 1;
  }

  _id_DEC9BCCE93873125 = "left_";

  if(self.asm.footsteps.foot == "right")
    _id_DEC9BCCE93873125 = "right_";

  if(_id_B15CD98E18D1A870)
    alias = _id_DEC9BCCE93873125 + "double_jump";
  else
    alias = _id_DEC9BCCE93873125 + "single_jump";

  _id_2D08B404190FFB34 = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return _id_2D08B404190FFB34;
}

senddelayedevent(asmname, statename, time, event, _id_775AAA9FDD143162) {
  self endon(statename + "_finished");
  wait(time);
  scripts\asm\asm::asm_fireevent(asmname, event);

  if(_id_775AAA9FDD143162)
    self notify(event);
}

hasanotherwallrun(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.wall_run_current_node_index))
    return 0;

  startnode = self.traversal_start_node;

  if(!isDefined(startnode))
    return 0;

  _id_A3E2CF82E6F677A4 = self.wall_run_current_node_index + 2;

  if(startnode.wall_info.nodeoffsets.size <= _id_A3E2CF82E6F677A4)
    return 0;

  return 1;
}

playwallruncontinue(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  self _meth_62004D7561FD321E();
  self.wall_run_current_node_index = self.wall_run_current_node_index + 2;
  endpos = getwallnodeposition(startnode, self.wall_run_current_node_index);
  _id_F1A4D9D10FD4B365 = self.angles;

  if(self.wall_run_direction == "left")
    self.wall_run_direction = "right";
  else
    self.wall_run_direction = "left";

  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  playscaledjump(asmname, statename, _id_2C8936D08F85C5C1, endpos, _id_F1A4D9D10FD4B365);
}

getwallrunmantleposition(startnode) {
  angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;

  if(angleoffset == (0, 0, 0))
    return startnode.origin + startnode.wall_info.mantleoffset;

  _id_728D033793CEA02F = rotatevector(startnode.wall_info.mantleoffset, angleoffset);
  return startnode.origin + _id_728D033793CEA02F;
}

getwallrunmantleangles(startnode) {
  if(!isDefined(startnode.wall_info.mantleangles))
    return undefined;

  angleoffset = startnode.angles[1] - startnode.wall_info.startnodeoriginalangles[1];

  if(angleoffset == 0)
    return startnode.wall_info.mantleangles;

  return (0, angleclamp180(startnode.wall_info.mantleangles[1] + angleoffset), 0);
}

getwallruntomantletype() {
  startnode = self.traversal_start_node;

  if(!isDefined(startnode.wall_info.mantleoffset))
    return "none";

  _id_BA9D9F198FABA440 = getwallrunmantleposition(startnode);

  if(_id_BA9D9F198FABA440[2] >= self.origin[2])
    return "high";

  return "low";
}

shouldwallruntovault(asmname, statename, _id_F2B19B25D457C2A6, params) {
  startnode = self.traversal_start_node;

  if(!isDefined(startnode.wall_info.bvaultover))
    return 0;

  return startnode.wall_info.bvaultover;
}

playwallrunloop(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  setupwallrunaimlimits();
  loopanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_76C92379ED351610 = scripts\asm\asm::asm_getxanim(statename, loopanim);
  movedelta = getmovedelta(_id_76C92379ED351610);
  _id_C1C17849832B0C9D = length2d(movedelta);

  if(!isDefined(startnode.wall_info.mantleoffset) && self.wall_run_current_node_index == startnode.wall_info.nodeoffsets.size - 2) {
    _id_457A0F528BFF306C = scripts\asm\asm::asm_getanim(asmname, "wall_run_exit");
    _id_315D9A31B78A7F02 = scripts\asm\asm::asm_getxanim("wall_run_exit", _id_457A0F528BFF306C);
    _id_7A01B5ED5CA503CD = getnotetracktimes(_id_315D9A31B78A7F02, "start_jump");
    _id_6949F2BC98970EE0 = getanimlength(_id_315D9A31B78A7F02);
    _id_D56A0B3C801F0BF6 = getmovedelta(_id_315D9A31B78A7F02, 0, _id_7A01B5ED5CA503CD[0]);
    _id_D72C308D5DA52D60 = length2d(_id_D56A0B3C801F0BF6);
  } else
    _id_D72C308D5DA52D60 = 0;

  _id_3777ECE6A73EADA5 = getwallnodeposition(startnode, self.wall_run_current_node_index + 1) - self.origin;
  _id_BB633C459E7832B8 = length(_id_3777ECE6A73EADA5);
  _id_BB633C459E7832B8 = _id_BB633C459E7832B8 - _id_D72C308D5DA52D60;

  if(_id_BB633C459E7832B8 < 0)
    _id_BB633C459E7832B8 = 0;

  _id_AEB58353CBDD1E6D = _id_BB633C459E7832B8 / _id_C1C17849832B0C9D;
  animlength = getanimlength(_id_76C92379ED351610);
  _id_2166DA624F53FB6C = animlength * _id_AEB58353CBDD1E6D;
  thread senddelayedevent(asmname, statename, _id_2166DA624F53FB6C, "wall_run_loop_done", 1);
  _id_4DAC4BF2EFE97C4F = vectorNormalize(_id_3777ECE6A73EADA5);
  self orientmode("face direction", _id_4DAC4BF2EFE97C4F);
  thread playwallrunendsound(statename);
  self animmode("noclip");
  self aisetanim(statename, loopanim);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_76C92379ED351610);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

playwallrunendsound(statename) {
  self endon("death");

  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

choosewallrunexitanim(asmname, statename, params) {
  alias = self.wall_run_direction;
  endpos = self getnegotiationendpos();
  _id_61045D8733281EE5 = endpos[2] - self.origin[2];
  _id_B15CD98E18D1A870 = 0;

  if(_id_61045D8733281EE5 >= 0) {
    if(_id_61045D8733281EE5 > 120)
      _id_B15CD98E18D1A870 = 1;
  } else if(0 - _id_61045D8733281EE5 > 240)
    _id_B15CD98E18D1A870 = 1;

  if(_id_B15CD98E18D1A870 == 0) {
    distsq = distancesquared(self.origin, endpos);

    if(distsq > 46225)
      _id_B15CD98E18D1A870 = 1;
  }

  if(_id_B15CD98E18D1A870)
    alias = alias + "_double";

  endpos = self getnegotiationendpos();
  startnode = self.traversal_start_node;
  dir = self getnegotiationendpos() - getwallnodeposition(startnode, startnode.wall_info.nodeoffsets.size - 1);
  dir = (dir[0], dir[1], 0);
  dir = vectorNormalize(dir);
  _id_F1A4D9D10FD4B365 = vectortoangles(dir);
  _id_5BABFFA7F03CE512 = angleclamp180(_id_F1A4D9D10FD4B365[1] - self.angles[1]);
  _id_5BABFFA7F03CE512 = abs(_id_5BABFFA7F03CE512);

  if(_id_5BABFFA7F03CE512 >= 22.5) {
    if(_id_5BABFFA7F03CE512 > 67.5)
      alias = alias + "_90";
    else
      alias = alias + "_45";
  }

  _id_2D08B404190FFB34 = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return _id_2D08B404190FFB34;
}

playwallrunexit(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  endpos = self getnegotiationendpos();
  _id_F1A4D9D10FD4B365 = self.angles;
  _id_8C2C7EA3BD382DF4 = 1.0;
  animname = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_40AEE82E33A154C3 = getnotetracktimes(animname, "ground");
  self _meth_62004D7561FD321E();

  if(isDefined(_id_40AEE82E33A154C3) && _id_40AEE82E33A154C3.size > 0)
    _id_8C2C7EA3BD382DF4 = _id_40AEE82E33A154C3[0];
  else {
    _id_930CAEF7352C0F86 = getnotetracktimes(animname, "end_double_jump");

    if(isDefined(_id_930CAEF7352C0F86) && _id_930CAEF7352C0F86.size > 0)
      _id_8C2C7EA3BD382DF4 = _id_930CAEF7352C0F86[0];
    else {
      _id_CAB4A622D5AF2E97 = getnotetracktimes(animname, "end_jump");

      if(isDefined(_id_CAB4A622D5AF2E97) && _id_CAB4A622D5AF2E97.size > 0)
        _id_8C2C7EA3BD382DF4 = _id_CAB4A622D5AF2E97[0];
    }
  }

  if(soundexists("wallrun_end_npc"))
    self playSound("wallrun_end_npc");

  playscaledjump(asmname, statename, animname, endpos, _id_F1A4D9D10FD4B365, _id_8C2C7EA3BD382DF4, 1, 1);
  thread terminatewallruntraverse(asmname, statename);
}

isnotdoingwallruntransition(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.traversal_start_node))
    return 0;

  return 1;
}

terminatewallruntraverse(asmname, statename) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  scripts\asm\traverse::terminatetraverse(asmname, statename);
}

playwallruntomantle(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  endnodepos = self getnegotiationendpos();
  _id_4F3C80D982122657 = getwallrunmantleposition(startnode);

  if(isDefined(startnode.wall_info.bvaultover) || getwallruntomantletype() == "high") {
    mantleangles = getwallrunmantleangles(startnode);

    if(!isDefined(mantleangles)) {
      _id_3777ECE6A73EADA5 = endnodepos - _id_4F3C80D982122657;
      _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
      mantleangles = vectortoangles(_id_3777ECE6A73EADA5);
    }
  } else {
    _id_3777ECE6A73EADA5 = _id_4F3C80D982122657 - self.origin;
    _id_3777ECE6A73EADA5 = (_id_3777ECE6A73EADA5[0], _id_3777ECE6A73EADA5[1], 0);
    mantleangles = vectortoangles(_id_3777ECE6A73EADA5);
  }

  _id_691E59D933435353 = scripts\asm\asm::asm_getanim(asmname, statename);
  animlength = getanimlength(_id_691E59D933435353);
  _id_FA917664AEA6E292 = getnotetracktimes(_id_691E59D933435353, "start_mantle");
  _id_40D329CF034E4307 = _id_FA917664AEA6E292[0];
  _id_4F0CA52986969139 = getnotetracktimes(_id_691E59D933435353, "end_mantle");
  _id_45D80567424231AE = _id_4F0CA52986969139[0];
  _id_99B01BAF607ED310 = getmovedelta(_id_691E59D933435353, _id_40D329CF034E4307, _id_45D80567424231AE);
  self forceteleport(self.origin, mantleangles);
  _id_6F31E626554D6AB9 = self localtoworldcoords(_id_99B01BAF607ED310);
  _id_36166C1716B38F9B = _id_6F31E626554D6AB9 - self.origin;
  _id_3B137C718EA27788 = _id_4F3C80D982122657 - _id_36166C1716B38F9B;
  playscaledjump(asmname, statename, _id_691E59D933435353, _id_3B137C718EA27788, mantleangles, _id_40D329CF034E4307, 0, 1);
  thread terminatewallruntraverse(asmname, statename);
}

playtraversaltransition(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);

  if(!isDefined(_id_2C8936D08F85C5C1)) {
    scripts\asm\asm::asm_fireevent(asmname, "code_move");
    return;
  }

  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  animendtime = 1.0;
  _id_095ACA96EE2618FE = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1)
    _id_095ACA96EE2618FE = getnotetracktimes(xanim, "align");

  if(!isDefined(_id_095ACA96EE2618FE) || _id_095ACA96EE2618FE.size == 0)
    _id_095ACA96EE2618FE = getnotetracktimes(xanim, "code_move");

  if(isDefined(_id_095ACA96EE2618FE) && _id_095ACA96EE2618FE.size > 0)
    animendtime = _id_095ACA96EE2618FE[0];

  _id_F075350FC4BE0D85 = getmovedelta(xanim, 0, animendtime);
  _id_FD7C686CEAD623AA = getangledelta(xanim, 0, animendtime);
  _id_00D5A54D862AACC2 = self.traversal_start_node;
  _id_228C1F2F3A2D92F1 = getanimlength(xanim) * animendtime;
  _id_64366DD6EEA5221D = int(ceil(_id_228C1F2F3A2D92F1 * 20));

  if(self.traversal_start_node.animscript == "wall_run") {
    _id_7FE6F6537340DF66 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    _id_71AB5F95B941AD8D = vectortoangles(_id_7FE6F6537340DF66);
    _id_2DB201E40E7AAF8C = _id_71AB5F95B941AD8D[1];
  } else {
    _id_4E68F5990E21A5ED = self getnegotiationendpos() - self.traversal_start_node.origin;
    _id_4E68F5990E21A5ED = (_id_4E68F5990E21A5ED[0], _id_4E68F5990E21A5ED[1], 0);
    _id_F1A4D9D10FD4B365 = vectortoangles(_id_4E68F5990E21A5ED);
    _id_2DB201E40E7AAF8C = _id_F1A4D9D10FD4B365[1];
  }

  _id_641C7B140664D9D3 = scripts\asm\soldier\cover::calcanimstartpos(_id_00D5A54D862AACC2.origin, _id_2DB201E40E7AAF8C, _id_F075350FC4BE0D85, _id_FD7C686CEAD623AA);
  _id_F0E39FDC34931529 = _id_2DB201E40E7AAF8C - _id_FD7C686CEAD623AA;
  self.a.arrivalasmstatename = statename;
  self.useanimgoalweight = 1;
  self startcoverarrival(_id_641C7B140664D9D3, _id_F0E39FDC34931529, _id_64366DD6EEA5221D);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

choosetraversaltransition(asmname, statename, params) {
  approachdir = anglesToForward(self.angles);
  _id_098309FE48684A69 = vectortoangles(approachdir);

  if(self.traversal_start_node.animscript == "wall_run")
    _id_F1A4D9D10FD4B365 = vectortoangles(getwallnodeposition(self.traversal_start_node, 0) - self.origin);
  else {
    _id_4E68F5990E21A5ED = self getnegotiationendpos() - self.traversal_start_node.origin;
    _id_4E68F5990E21A5ED = (_id_4E68F5990E21A5ED[0], _id_4E68F5990E21A5ED[1], 0);
    _id_F1A4D9D10FD4B365 = vectortoangles(_id_4E68F5990E21A5ED);
  }

  _id_2DB201E40E7AAF8C = _id_F1A4D9D10FD4B365[1];
  _id_077B9E4B599269EB = angleclamp180(_id_2DB201E40E7AAF8C - _id_098309FE48684A69[1]);
  angleindex = getangleindex(_id_077B9E4B599269EB, 22.5);
  _id_9B9C0392FA49456D = scripts\asm\soldier\arrival::getstopanims(asmname, statename, undefined, 1);

  if(!isDefined(_id_9B9C0392FA49456D[angleindex]))
    return undefined;

  return _id_9B9C0392FA49456D[angleindex];
}

shouldabortwallrunattach(asmname, statename, _id_F2B19B25D457C2A6, params) {
  distsq = distance2dsquared(self.origin, getwallnodeposition(self.traversal_start_node, 1));

  if(distsq < 144)
    return 1;

  return 0;
}

shouldtraversetransitionto(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(_id_F2B19B25D457C2A6 == self.traversal_start_node.animscript)
    return 1;

  return 0;
}

istraversaltransitionsupported(animscript) {
  switch (animscript) {
    case "double_jump_mantle":
    case "double_jump_vault":
    case "rail_hop_double_jump_down":
    case "double_jump":
    case "wall_run":
      return 1;
  }

  return 0;
}

shoulddotraversaltransition(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.traversal_start_node))
    return 0;

  if(!istraversaltransitionsupported(self.traversal_start_node.animscript))
    return 0;

  if(!self.facemotion)
    return 0;

  _id_E19498E123DF4D73 = undefined;

  if(self.traversal_start_node.animscript == "wall_run") {
    _id_E19498E123DF4D73 = getwallrundirectionfromstartnode(self.traversal_start_node);
    _id_4E68F5990E21A5ED = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    _id_F1A4D9D10FD4B365 = vectortoangles(_id_4E68F5990E21A5ED);
  } else {
    _id_4E68F5990E21A5ED = self getnegotiationendpos() - self.traversal_start_node.origin;
    _id_4E68F5990E21A5ED = (_id_4E68F5990E21A5ED[0], _id_4E68F5990E21A5ED[1], 0);
    _id_E19498E123DF4D73 = vectorNormalize(_id_4E68F5990E21A5ED);
    _id_F1A4D9D10FD4B365 = vectortoangles(_id_E19498E123DF4D73);
  }

  _id_D9BFC18F40907748 = _id_F1A4D9D10FD4B365[1];
  approachdir = anglesToForward(self.angles);
  _id_098309FE48684A69 = vectortoangles(approachdir);
  _id_077B9E4B599269EB = angleclamp180(_id_D9BFC18F40907748 - _id_098309FE48684A69[1]);
  angleindex = getangleindex(_id_077B9E4B599269EB, 22.5);
  _id_9B9C0392FA49456D = scripts\asm\soldier\arrival::getstopanims(asmname, _id_F2B19B25D457C2A6, undefined, 1);
  stopanim = _id_9B9C0392FA49456D[angleindex];

  if(!isDefined(stopanim))
    return 0;

  animendtime = 1.0;
  _id_095ACA96EE2618FE = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1)
    _id_095ACA96EE2618FE = getnotetracktimes(stopanim, "align");

  if(!isDefined(_id_095ACA96EE2618FE) || _id_095ACA96EE2618FE.size == 0)
    _id_095ACA96EE2618FE = getnotetracktimes(stopanim, "code_move");

  if(isDefined(_id_095ACA96EE2618FE) && _id_095ACA96EE2618FE.size > 0)
    animendtime = _id_095ACA96EE2618FE[0];

  _id_F075350FC4BE0D85 = getmovedelta(stopanim, 0, animendtime);
  _id_FD7C686CEAD623AA = getangledelta(stopanim, 0, animendtime);
  _id_0D49262AB30E7C20 = distance2d(self.origin, self.traversal_start_node.origin);
  _id_4E851016ECEC5294 = length(_id_F075350FC4BE0D85);
  _id_3777ECE6A73EADA5 = _id_0D49262AB30E7C20 - _id_4E851016ECEC5294;

  if(_id_3777ECE6A73EADA5 < 0) {
    _id_2418C08254D8B1F6 = anglesToForward(_id_F1A4D9D10FD4B365);
    dot = vectordot(approachdir, _id_2418C08254D8B1F6);

    if(dot > 0.707) {
      if(abs(_id_3777ECE6A73EADA5) > 10)
        return 0;
    } else if(abs(_id_3777ECE6A73EADA5) > 64)
      return 0;
  } else if(_id_3777ECE6A73EADA5 > 10)
    return 0;

  if(self.traversal_start_node.animscript == "wall_run")
    self.wall_run_direction = _id_E19498E123DF4D73;

  return 1;
}

handlewallrunattachnotetrack(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "wall_contact") {
    if(soundexists("wallrun_start_npc"))
      self playSound("wallrun_start_npc");
  }
}

setupwallrunaimlimits() {
  self.upaimlimit = -89;
  self.downaimlimit = 45;
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
}

playtraverseanim_ladder(asmname, statename, params) {
  self endon(statename + "_finished");
  self _meth_148259B5EDF82F38(1);
  startnode = self getnegotiationstartnode();
  endpos = self getnegotiationendpos();
  self animmode("noclip", 0);
  self orientmode("face angle", startnode.angles[1]);
  _id_2674A2C3EE67214B = endpos - startnode.origin;
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();
  _id_451F10C8EA3F02B7 = undefined;
  _id_F3FA34446BDE31BF = undefined;
  _id_5AF16561805A75B1 = undefined;
  _id_571103A8A150FCA9 = 0;

  if(_id_2674A2C3EE67214B[2] > 0) {
    _id_91866250667C6232 = "off_" + _id_F7EE87DC76B45E62;
    _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, _id_91866250667C6232);

    if(!isDefined(_id_5AF16561805A75B1)) {
      if(!isDefined(startnode.traverse_drop_height_delta) || startnode.traverse_drop_height_delta < 6)
        _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromalias(statename, "off");
      else if(startnode.traverse_drop_height_delta < 36) {
        _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromalias(statename, "off_low");
        _id_571103A8A150FCA9 = 1;
      } else if(startnode.traverse_drop_height_delta < 60) {
        _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromalias(statename, "off_mid");
        _id_571103A8A150FCA9 = 1;
      } else {
        _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromalias(statename, "off_high");
        _id_571103A8A150FCA9 = 1;
      }
    }

    _id_451F10C8EA3F02B7 = scripts\asm\asm::asm_lookupanimfromalias(statename, "up");
  } else {
    _id_54F97B63FFA98208 = "on_" + _id_F7EE87DC76B45E62;
    _id_5AF16561805A75B1 = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, _id_54F97B63FFA98208);

    if(!isDefined(_id_5AF16561805A75B1))
      _id_F3FA34446BDE31BF = scripts\asm\asm::asm_lookupanimfromalias(statename, "on");

    _id_451F10C8EA3F02B7 = scripts\asm\asm::asm_lookupanimfromalias(statename, "down");
  }

  rate = 1;

  if(isDefined(self.moveplaybackrate))
    rate = self.moveplaybackrate;

  if(isDefined(_id_F3FA34446BDE31BF)) {
    self aisetanim(statename, _id_F3FA34446BDE31BF, rate);
    scripts\asm\asm::asm_donotetracks(asmname, statename);
  }

  _id_2A9E077675B53676 = endpos;

  if(isDefined(_id_5AF16561805A75B1)) {
    _id_BA9F413C71DC05C1 = scripts\asm\asm::asm_getxanim(statename, _id_5AF16561805A75B1);
    _id_7E1EF9266BFB4E87 = getmovedelta(_id_BA9F413C71DC05C1);

    if(_id_571103A8A150FCA9)
      _id_2A9E077675B53676 = startnode.traverse_height - (0, 0, 48);
    else
      _id_2A9E077675B53676 = endpos - _id_7E1EF9266BFB4E87 + (0, 0, 1);
  }

  _id_29DC8002CE343A5D = _id_2A9E077675B53676 - self.origin;

  if(_id_29DC8002CE343A5D[2] * _id_2674A2C3EE67214B[2] > 0) {
    _id_4E385EFF4BD3AFFB = scripts\asm\asm::asm_getxanim(statename, _id_451F10C8EA3F02B7);
    _id_4BADBA7B39F1758E = getmovedelta(_id_4E385EFF4BD3AFFB);
    _id_02F9556E4B32808E = _id_4BADBA7B39F1758E[2] * rate / getanimlength(_id_4E385EFF4BD3AFFB);
    _id_340DE6C50AEE0A47 = _id_29DC8002CE343A5D[2] / _id_02F9556E4B32808E;

    if(!isDefined(_id_4E385EFF4BD3AFFB) || !isDefined(_id_4BADBA7B39F1758E) || !isDefined(_id_02F9556E4B32808E) || !isDefined(_id_340DE6C50AEE0A47)) {
      _id_38548703EA2BDADC = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
      _id_6AF018C22F5F179F = self.basearchetype;
    }

    self aisetanim(statename, _id_451F10C8EA3F02B7, rate);
    scripts\asm\asm::asm_donotetracksfortime(asmname, statename, _id_340DE6C50AEE0A47);
  }

  if(isDefined(_id_5AF16561805A75B1)) {
    self aisetanim(statename, _id_5AF16561805A75B1, rate);
    waitframe();
    notetrackhandle = scripts\asm\traverse::handletraversewarpnotetracks;
    self.traversestartnode = startnode;
    self.traverseendnode = self getnegotiationendnode();
    self._id_70A168924ECCFF58 = endpos;
    self.traversexanim = scripts\asm\asm::asm_getxanim(statename, _id_5AF16561805A75B1);
    scripts\asm\asm::asm_donotetracks(asmname, statename, notetrackhandle);
    self._id_70A168924ECCFF58 = undefined;
  }

  scripts\asm\traverse::terminatetraverse(asmname, statename);
}

terminate_ladder(asmname, statename, params) {
  _id_B48E997E59346E83 = !isalive(self);
  self.nogravityragdoll = _id_B48E997E59346E83;
  self _meth_148259B5EDF82F38(0);
  self._id_70A168924ECCFF58 = undefined;

  if(_id_B48E997E59346E83)
    self.forceragdollimmediate = 0;
}

traverse_basic(asmname, statename, params) {
  self endon(statename + "_finished");
  traverseanim = scripts\asm\asm::asm_getanim(asmname, statename);
  self animmode("noclip", 0);
  startnode = self getnegotiationstartnode();
  self orientmode("face angle", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  scripts\asm\traverse::terminatetraverse(asmname, statename);
}