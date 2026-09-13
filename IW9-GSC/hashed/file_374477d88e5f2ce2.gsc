/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_374477d88e5f2ce2.gsc
***********************************************/

playanim_exit(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2F0280465BBD411E = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  self.asm.customdata.exitstate = undefined;

  if(!isDefined(_id_2F0280465BBD411E)) {
    scripts\asm\asm::asm_fireevent(asmname, "code_move", undefined);
    return;
  }

  playstartanim(asmname, statename, _id_2F0280465BBD411E);
  scripts\asm\asm::asm_fireevent(asmname, "code_move", undefined);
}

chooseanim_exit(asmname, statename, params) {
  if(!checktransitionpreconditions())
    return undefined;

  _id_457A0F528BFF306C = determinestartanim(statename);
  return _id_457A0F528BFF306C;
}

_id_6660E8E1CD72C88D(statename) {
  _id_59D32804591E899B = [];

  if(scripts\asm\asm::asm_hasalias(statename, "1"))
    _id_59D32804591E899B[7] = scripts\asm\asm::asm_lookupanimfromalias(statename, "1");

  if(scripts\asm\asm::asm_hasalias(statename, "2")) {
    _id_59D32804591E899B[0] = scripts\asm\asm::asm_lookupanimfromalias(statename, "2");
    _id_59D32804591E899B[8] = _id_59D32804591E899B[0];
  }

  if(scripts\asm\asm::asm_hasalias(statename, "3"))
    _id_59D32804591E899B[1] = scripts\asm\asm::asm_lookupanimfromalias(statename, "3");

  if(scripts\asm\asm::asm_hasalias(statename, "4"))
    _id_59D32804591E899B[6] = scripts\asm\asm::asm_lookupanimfromalias(statename, "4");

  if(scripts\asm\asm::asm_hasalias(statename, "6"))
    _id_59D32804591E899B[2] = scripts\asm\asm::asm_lookupanimfromalias(statename, "6");

  if(scripts\asm\asm::asm_hasalias(statename, "7"))
    _id_59D32804591E899B[5] = scripts\asm\asm::asm_lookupanimfromalias(statename, "7");

  if(scripts\asm\asm::asm_hasalias(statename, "8"))
    _id_59D32804591E899B[4] = scripts\asm\asm::asm_lookupanimfromalias(statename, "8");

  if(scripts\asm\asm::asm_hasalias(statename, "9"))
    _id_59D32804591E899B[3] = scripts\asm\asm::asm_lookupanimfromalias(statename, "9");

  return _id_59D32804591E899B;
}

getexitnode() {
  _id_0DE315B064BB20D9 = undefined;

  if(!isDefined(self.heat))
    limit = 400;
  else
    limit = 4096;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < limit)
    _id_0DE315B064BB20D9 = self.node;
  else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < limit)
    _id_0DE315B064BB20D9 = self.prevnode;

  if(isDefined(_id_0DE315B064BB20D9) && isDefined(self.heat) && absangleclamp180(self.angles[1] - _id_0DE315B064BB20D9.angles[1]) > 30)
    return undefined;

  return _id_0DE315B064BB20D9;
}

determinestartanim(statename) {
  _id_33AEC6B87B156757 = self getnegotiationstartnode();

  if(isDefined(_id_33AEC6B87B156757))
    goalpos = _id_33AEC6B87B156757.origin;
  else
    goalpos = self.pathgoalpos;

  _id_0DE315B064BB20D9 = getexitnode();
  lookaheaddir = self.lookaheaddir;
  _id_69ED96EADF2D45CF = vectortoangles(lookaheaddir);

  if(isDefined(_id_0DE315B064BB20D9))
    _id_9DBC893FB4BE54F2 = _id_0DE315B064BB20D9.angles;
  else
    _id_9DBC893FB4BE54F2 = self.angles;

  _id_077B9E4B599269EB = angleclamp180(_id_69ED96EADF2D45CF[1] - self.angles[1]);
  velocity = self getvelocity();

  if(length2dsquared(velocity) > 16) {
    _id_DA6D2EBF4C7F03E4 = vectortoangles(velocity);

    if(abs(angleclamp180(_id_DA6D2EBF4C7F03E4[1] - _id_69ED96EADF2D45CF[1])) < 45)
      return;
  }

  if(distancesquared(goalpos, self.origin) < 22500) {
    return;
  }
  if(isDefined(self.asm.customdata) && isDefined(self.asm.customdata.exitstate))
    _id_59D32804591E899B = _id_6660E8E1CD72C88D(self.asm.customdata.exitstate);
  else
    _id_59D32804591E899B = _id_6660E8E1CD72C88D(statename);

  _id_26565B4B4F2F0779 = getangleindices(_id_077B9E4B599269EB);
  _id_637FB00E1A88028A = undefined;
  _id_98FE6FAB0A0515CD = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_26565B4B4F2F0779.size; _id_AC0E594AC96AA3A8++) {
    _id_FE8F7703F6313ED4 = _id_26565B4B4F2F0779[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_59D32804591E899B[_id_FE8F7703F6313ED4])) {
      continue;
    }
    _id_637FB00E1A88028A = self getanimentry(statename, _id_59D32804591E899B[_id_FE8F7703F6313ED4]);
    _id_0FDFF2D82F052CB5 = getmovedelta(_id_637FB00E1A88028A);
    endpos = rotatevector(_id_0FDFF2D82F052CB5, self.angles) + self.origin;

    if(!navtrace(self.origin, endpos, self)) {
      _id_98FE6FAB0A0515CD = _id_59D32804591E899B[_id_FE8F7703F6313ED4];
      break;
    }
  }

  return _id_98FE6FAB0A0515CD;
}

playstartanim(asmname, statename, _id_2F0280465BBD411E) {
  self endon(statename + "_finished");
  _id_69ED96EADF2D45CF = vectortoangles(self.lookaheaddir);
  _id_077B9E4B599269EB = angleclamp180(_id_69ED96EADF2D45CF[1] - self.angles[1]);
  _id_637FB00E1A88028A = self getanimentry(statename, _id_2F0280465BBD411E);
  _id_370A8C08BE55A7A5 = getnotetracktimes(_id_637FB00E1A88028A, "code_move");
  _id_FB9376B06ABA09D7 = 1;

  if(_id_370A8C08BE55A7A5.size > 0)
    _id_FB9376B06ABA09D7 = _id_370A8C08BE55A7A5[0];

  _id_F49F40EB39DA8B4E = getangledelta3d(_id_637FB00E1A88028A, 0, _id_FB9376B06ABA09D7);
  self animmode("zonly_physics");
  _id_53F1402EF4A26673 = angleclamp180(_id_69ED96EADF2D45CF[1] - _id_F49F40EB39DA8B4E[1]);
  _id_179A55CD72DDBAD8 = (0, _id_53F1402EF4A26673, 0);
  self orientmode("face angle", _id_179A55CD72DDBAD8[1]);
  animlength = getanimlength(_id_637FB00E1A88028A) * _id_FB9376B06ABA09D7;
  turnrate = 0.01 + abs(angleclamp180(_id_077B9E4B599269EB - _id_F49F40EB39DA8B4E[1])) / animlength / 1000;

  if(turnrate < 0.01)
    turnrate = 0.01;

  self._id_49EA55BBD7BD4209 = self.turnrate;
  self.turnrate = turnrate;
  thread _id_D112DDE629F4A817(statename + "_finished");
  scripts\asm\asm_mp::_id_4895EAFF78A2FC42(asmname, statename, _id_2F0280465BBD411E, self.moveplaybackrate, "code_move");
  self notify("FinishStartAnim");
}

_id_D112DDE629F4A817(_id_830905E5C2645826) {
  self endon("death");
  scripts\engine\utility::waittill_any_two(_id_830905E5C2645826, "FinishStartAnim");
  self.turnrate = self._id_49EA55BBD7BD4209;
  self._id_49EA55BBD7BD4209 = undefined;
  self animmode("normal");
  self orientmode("face motion");
}

checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!self.facemotion)
    return 0;

  if(isDefined(self.enemy) && scripts\asm\asm_bb::bb_wantstostrafe())
    return 0;

  if(isDefined(self.disableexits) && self.disableexits)
    return 0;

  if(distancesquared(self.origin, self.pathgoalpos) < 10000)
    return 0;

  return 1;
}

casualshoulddosharpturn(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(params[2]) || !scripts\asm\asm_bb::bb_movetyperequested(params[2]))
    return 0;

  return shoulddosharpturn(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shoulddosharpturn(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.noturnanims) && self.noturnanims)
    return 0;

  if(isDefined(self._id_CCF87DA54568E550) && self._id_CCF87DA54568E550)
    return 0;

  current_state = scripts\asm\asm::asm_getcurrentstatename(asmname);
  _id_77E7DEBAB7FD1A02 = scripts\asm\asm::asm_geteventtime(asmname, "sharp_turn");

  if(!isDefined(_id_77E7DEBAB7FD1A02))
    return 0;

  _id_C8BD9A39CE9013BF = 100;
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_6B7BEE46F2C6DA28 - _id_77E7DEBAB7FD1A02 > _id_C8BD9A39CE9013BF)
    return 0;

  _id_EC6A81EAC0E4DC61 = scripts\asm\asm::asm_geteventdata(asmname, "sharp_turn");

  if(!isDefined(_id_EC6A81EAC0E4DC61) || !isDefined(_id_EC6A81EAC0E4DC61[1]) || !isDefined(_id_EC6A81EAC0E4DC61[2]) || !isDefined(_id_EC6A81EAC0E4DC61[3]))
    return 0;

  _id_2920E731907BA823 = _id_EC6A81EAC0E4DC61[1];
  _id_39BBA0FF86C266C6 = _id_EC6A81EAC0E4DC61[2];
  _id_4E6D9BE609009734 = _id_EC6A81EAC0E4DC61[3];
  _id_1B5EBB5A562AC4AC = _id_2920E731907BA823 - _id_4E6D9BE609009734;

  if(isarray(params))
    _id_FF1BF1607A653C83 = params[0];
  else
    _id_FF1BF1607A653C83 = params;

  animindex = calculatesharpturnanim(current_state, _id_F2B19B25D457C2A6, _id_1B5EBB5A562AC4AC, _id_39BBA0FF86C266C6);

  if(!isDefined(animindex))
    return 0;

  self.sharpturnindex = animindex;
  return 1;
}

calculatesharpturnanim(statename, _id_FF1BF1607A653C83, _id_1B5EBB5A562AC4AC, _id_39BBA0FF86C266C6) {
  threshold = 10;

  if(_id_39BBA0FF86C266C6)
    threshold = 30;

  _id_69ED96EADF2D45CF = vectortoangles(_id_1B5EBB5A562AC4AC);
  _id_077B9E4B599269EB = angleclamp180(_id_69ED96EADF2D45CF[1] - self.angles[1]);

  if(_id_39BBA0FF86C266C6) {
    if(abs(_id_077B9E4B599269EB) < 30)
      return undefined;
  }

  _id_26565B4B4F2F0779 = getangleindices(_id_077B9E4B599269EB, threshold);

  if(istrue(self._id_91A2982967965547))
    _id_E9BC81D4BD891D5C = _id_5DFC55A02BD5A39C(_id_FF1BF1607A653C83, 0);
  else
    _id_E9BC81D4BD891D5C = _id_5DFC55A02BD5A39C(_id_FF1BF1607A653C83, 1);

  foreach(angleindex in _id_26565B4B4F2F0779) {
    if(angleindex > 2 && angleindex < 6) {
      continue;
    }
    if(angleindex < 0 || angleindex > 8) {
      continue;
    }
    turnanim = self getanimentry(_id_FF1BF1607A653C83, _id_E9BC81D4BD891D5C[angleindex]);
    _id_F73BEA4534A3831F = getangledelta(turnanim);
    _id_F1A4D9D10FD4B365 = (0, angleclamp180(_id_69ED96EADF2D45CF[1] - _id_F73BEA4534A3831F), 0);

    if(_id_731FC138CD5A7BC6(turnanim, _id_F1A4D9D10FD4B365, angleindex == 3 || angleindex == 5))
      return _id_E9BC81D4BD891D5C[angleindex];
  }

  return undefined;
}

choosesharpturnanim(asmname, statename, params) {
  return self.sharpturnindex;
}

playsharpturnanim(asmname, statename, params) {
  self endon(statename + "_finished");
  sharpturnindex = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);
  self.sharpturnindex = undefined;
  scripts\asm\asm::asm_settransitionanimmode("anim deltas");
  scripts\asm\asm::asm_settransitionorientmode("face current");
  scripts\asm\asm_mp::_id_4895EAFF78A2FC42(asmname, statename, sharpturnindex, self.moveplaybackrate, "code_move");
  scripts\asm\asm::asm_settransitionanimmode("code_move");
  scripts\asm\asm::asm_settransitionorientmode("face motion");
}

_id_731FC138CD5A7BC6(turnanim, _id_F1A4D9D10FD4B365, _id_A9F9C2B0D5B4E555) {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(scripts\asm\asm_bb::bb_wantstostrafe())
    return 0;

  _id_1CF3CC2BFBD90835 = getnotetracktimes(turnanim, "code_move");

  if(_id_1CF3CC2BFBD90835.size == 0)
    _id_1CF3CC2BFBD90835[0] = 1.0;

  _id_DEF9680D43BE7384 = _id_1CF3CC2BFBD90835[0];
  movedelta = getmovedelta(turnanim, 0, _id_DEF9680D43BE7384);
  _id_A8BE774229D916B1 = self localtoworldcoords(movedelta);
  _id_E47C3B1D093DB997 = self.pathgoalpos;
  _id_A37ACED4069C7AEE = self getnegotiationstartnode();

  if(isDefined(_id_A37ACED4069C7AEE))
    _id_E47C3B1D093DB997 = _id_A37ACED4069C7AEE.origin;

  if(isDefined(self._id_7BF0BB61834CF2FA)) {
    if(squared(self._id_7BF0BB61834CF2FA) > distancesquared(_id_E47C3B1D093DB997, _id_A8BE774229D916B1))
      return 0;
  } else if(distancesquared(_id_E47C3B1D093DB997, _id_A8BE774229D916B1) < 7056)
    return 0;

  movedelta = getmovedelta(turnanim, 0, 1);
  endpoint = self localtoworldcoords(movedelta);
  endpoint = _id_A8BE774229D916B1 + vectorNormalize(endpoint - _id_A8BE774229D916B1) * 20;
  _id_A2174F4B764086B3 = navtrace(_id_A8BE774229D916B1, endpoint, self);

  if(_id_A2174F4B764086B3)
    return 0;

  if(isDefined(self._id_8D2F044239555096))
    return self[[self._id_8D2F044239555096]](turnanim, _id_F1A4D9D10FD4B365, _id_A9F9C2B0D5B4E555);

  return 1;
}

_id_6FE5646A62D6C8C1(statename, _id_5217DF91F13C7C48) {
  _id_E9BC81D4BD891D5C = [];
  _id_DEC9BCCE93873125 = "";

  if(isDefined(_id_5217DF91F13C7C48) && _id_5217DF91F13C7C48 && self.asm.footsteps.foot == "right")
    _id_DEC9BCCE93873125 = "right";
  else
    _id_DEC9BCCE93873125 = "left";

  _id_E9BC81D4BD891D5C[0] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "2");
  _id_E9BC81D4BD891D5C[1] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "3");
  _id_E9BC81D4BD891D5C[2] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "6");
  _id_E9BC81D4BD891D5C[3] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "9");
  _id_E9BC81D4BD891D5C[5] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "7");
  _id_E9BC81D4BD891D5C[6] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "4");
  _id_E9BC81D4BD891D5C[7] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "1");
  _id_E9BC81D4BD891D5C[8] = scripts\asm\asm::asm_lookupanimfromalias(statename, _id_DEC9BCCE93873125 + "2");
  return _id_E9BC81D4BD891D5C;
}

_id_5DFC55A02BD5A39C(statename, _id_5217DF91F13C7C48) {
  if(isDefined(self._id_B72F5C2D8C1555AE))
    return [[self._id_B72F5C2D8C1555AE]](statename, _id_5217DF91F13C7C48);

  return _id_6FE5646A62D6C8C1(statename, _id_5217DF91F13C7C48);
}

sharpturn_terminate(asmname, statename, params) {
  self motionwarpcancel();
  self.useanimgoalweight = 0;
}

_id_051D568F7CB26529(asmname, statename, params) {
  _id_0421AE001C3CE6D1(asmname, statename, params);
  _id_E775E9F34981594F(asmname, statename);
}

_id_0421AE001C3CE6D1(asmname, statename, params) {}

_id_E775E9F34981594F(asmname, statename) {
  self endon(statename + "_finished");
  _id_716305D827F02E47 = scripts\asm\asm::asm_lookupanimfromalias(statename, "f");
  _id_0233122D71B43D5D = scripts\asm\asm::asm_lookupanimfromalias(statename, "l");
  _id_C27A909E04161CCB = scripts\asm\asm::asm_lookupanimfromalias(statename, "r");
  _id_B5DE2F493F49BDFB = scripts\asm\asm::asm_lookupanimfromalias(statename, "b");
  self animmode("normal");
  lastanim = -1;
  _id_3B56F1EFA6CF1BB8 = -1;

  for(;;) {
    _id_37EE045145512FBD = _id_2B79931B08683E0A::quadrantanimweights(self getmotionangle());

    if(_id_37EE045145512FBD["back"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_B5DE2F493F49BDFB;
    else if(_id_37EE045145512FBD["left"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_0233122D71B43D5D;
    else if(_id_37EE045145512FBD["right"] == 1.0)
      _id_3B56F1EFA6CF1BB8 = _id_C27A909E04161CCB;
    else
      _id_3B56F1EFA6CF1BB8 = _id_716305D827F02E47;

    if(_id_3B56F1EFA6CF1BB8 != lastanim)
      self setanimstate(statename, _id_3B56F1EFA6CF1BB8);

    lastanim = _id_3B56F1EFA6CF1BB8;
    wait 0.25;
  }
}