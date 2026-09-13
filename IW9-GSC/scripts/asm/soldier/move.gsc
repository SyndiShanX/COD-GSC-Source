/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\move.gsc
***********************************************/

playanim_exit(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_637FB00E1A88028A = scripts\asm\asm::asm_getanim(asmname, statename);
  self._id_57E1B0C4AD45DB70 = undefined;

  if(isDefined(self.battlechatterallowed) && self.battlechatterallowed) {
    _id_02E5E380655D9414 = issubstr(statename, "cover");
    thread movebattlechatter_helper(_id_02E5E380655D9414);
  }

  if(!isDefined(_id_637FB00E1A88028A)) {
    _id_9743A24AC8368484 = self aigetdesiredspeed();
    _id_543020482C67892F = 50.0;

    if(_id_543020482C67892F > _id_9743A24AC8368484)
      _id_543020482C67892F = 0.5 * _id_9743A24AC8368484;

    self aisettargetspeed(_id_543020482C67892F);
    scripts\asm\asm::asm_fireevent(asmname, "abort");
    scripts\asm\asm::asm_fireevent(asmname, "code_move");
    scripts\asm\asm::asm_fireevent(asmname, "end");
    scripts\asm\asm::asm_fireevent(asmname, "finish");
    return;
  }

  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 1;
  _id_BEF3B4B769E8ABE4 = 0;

  if(isDefined(params))
    _id_BEF3B4B769E8ABE4 = params;

  playstartanim(asmname, statename, _id_637FB00E1A88028A, _id_BEF3B4B769E8ABE4);

  if(isDefined(self.exitspeedtarget))
    self aisettargetspeed(float(self.exitspeedtarget));
}

chooseanim_exit(asmname, statename, params) {
  _id_EE2A14CC5B990A1B = 0;

  if(isDefined(params)) {
    if(isarray(params))
      _id_EE2A14CC5B990A1B = istrue(params[0]);
    else
      _id_EE2A14CC5B990A1B = istrue(params);
  }

  if(_id_EE2A14CC5B990A1B)
    return chooseanim_exitsoldier(asmname, statename, params);

  if(!checktransitionpreconditions())
    return undefined;

  _id_457A0F528BFF306C = undefined;
  _id_8A1B6D26FBF96EA9 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1]))
    _id_8A1B6D26FBF96EA9 = params[1];

  _id_457A0F528BFF306C = determinestartanim(statename, _id_8A1B6D26FBF96EA9);
  return _id_457A0F528BFF306C;
}

determinedesiredexitspeed() {
  _id_A7D951A8F516DC41 = 70.0;
  _id_9743A24AC8368484 = self getdesiredscaledspeedforposalongpath(_id_A7D951A8F516DC41);

  if(self.cautiousnavigation)
    _id_9743A24AC8368484 = 90;

  return _id_9743A24AC8368484;
}

chooseanim_exitsoldier(asmname, statename, params) {
  _id_0E4731409BD255E0 = "";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    _id_9743A24AC8368484 = determinedesiredexitspeed();
    archetype = self getbasearchetype();
    _id_0E4731409BD255E0 = getnextlowestspeedthresholdstring(archetype, _id_9743A24AC8368484);
    self.exitspeedtarget = getanimspeedthreshold(archetype, _id_0E4731409BD255E0);
  } else
    self.exitspeedtarget = undefined;

  if(!checktransitionpreconditions())
    return undefined;

  _id_457A0F528BFF306C = undefined;
  _id_8A1B6D26FBF96EA9 = 0;

  if(isDefined(params) && isarray(params) && isDefined(params[1]))
    _id_8A1B6D26FBF96EA9 = params[1];

  _id_457A0F528BFF306C = determinestartanim(statename, _id_8A1B6D26FBF96EA9, _id_0E4731409BD255E0);
  return _id_457A0F528BFF306C;
}

getstartanim(statename, _id_B63E3AA50397F874, _id_FE8F7703F6313ED4, _id_72C986BD4A45A6C1) {
  if(!isDefined(_id_B63E3AA50397F874))
    _id_B63E3AA50397F874 = "";

  _id_F9129A56A004CDB7 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  _id_993274082D629F60 = _id_F9129A56A004CDB7[_id_FE8F7703F6313ED4];

  if(_id_993274082D629F60 == 8) {
    if(_id_72C986BD4A45A6C1 < 0)
      aliasname = _id_993274082D629F60 + "r" + _id_B63E3AA50397F874;
    else
      aliasname = _id_993274082D629F60 + "l" + _id_B63E3AA50397F874;
  } else
    aliasname = _id_993274082D629F60 + _id_B63E3AA50397F874;

  return scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, aliasname);
}

getstartmindist() {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(_id_F7EE87DC76B45E62 == "casual" || _id_F7EE87DC76B45E62 == "casual_gun" || self aigetdesiredspeed() <= 60)
    return 75.0;

  return 100.0;
}

getexitnode() {
  _id_0DE315B064BB20D9 = undefined;
  limit = 400;

  if(scripts\engine\utility::actor_is3d())
    limit = 1024;
  else if(isDefined(self.heat))
    limit = 4096;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < limit)
    _id_0DE315B064BB20D9 = self.node;
  else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < limit)
    _id_0DE315B064BB20D9 = self.prevnode;

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(_id_0DE315B064BB20D9) && absangleclamp180(self.angles[1] - _id_0DE315B064BB20D9.angles[1]) > 30)
      return undefined;
  }

  return _id_0DE315B064BB20D9;
}

determinestartanim(statename, _id_8A1B6D26FBF96EA9, _id_B63E3AA50397F874) {
  _id_33AEC6B87B156757 = self getnegotiationstartnode();

  if(isDefined(_id_33AEC6B87B156757))
    goalpos = _id_33AEC6B87B156757.origin;
  else
    goalpos = self.pathgoalpos;

  _id_0DE315B064BB20D9 = getexitnode();

  if(_id_8A1B6D26FBF96EA9) {
    _id_634E3D3B8E9B952F = self.origin + self.lookaheaddir * self.lookaheaddist;
    _id_5DCE5380D64570B5 = _id_634E3D3B8E9B952F;
  } else {
    _id_634E3D3B8E9B952F = self getposonpath(128);
    _id_5DCE5380D64570B5 = self getposonpath(32);
  }

  _id_69ED96EADF2D45CF = vectortoangles(_id_634E3D3B8E9B952F - self.origin);
  _id_78744F455B1D78CD = vectortoangles(_id_5DCE5380D64570B5 - self.origin);

  if(scripts\asm\shared\utility::nodeshouldfaceangles(_id_0DE315B064BB20D9) && !_id_8A1B6D26FBF96EA9)
    _id_9DBC893FB4BE54F2 = _id_0DE315B064BB20D9.angles;
  else
    _id_9DBC893FB4BE54F2 = self.angles;

  _id_077B9E4B599269EB = angleclamp180(_id_69ED96EADF2D45CF[1] - _id_9DBC893FB4BE54F2[1]);
  _id_72C986BD4A45A6C1 = angleclamp180(_id_78744F455B1D78CD[1] - _id_9DBC893FB4BE54F2[1]);
  _id_28F7BF20C229AEDB = vectortoangles(self.lookaheaddir);
  _id_8EBC075F7302487D = angleclamp180(_id_28F7BF20C229AEDB[1] - _id_9DBC893FB4BE54F2[1]);

  if(abs(_id_8EBC075F7302487D) > 135 && abs(_id_077B9E4B599269EB) < 90)
    return undefined;

  if(length2dsquared(self.velocity) > 64) {
    _id_DA6D2EBF4C7F03E4 = vectortoangles(self.velocity);

    if(abs(angleclamp180(_id_DA6D2EBF4C7F03E4[1] - _id_69ED96EADF2D45CF[1])) < 45)
      return;
  }

  _id_636C8575D7A7768B = getstartmindist();

  if(self pathdisttogoal(1) < _id_636C8575D7A7768B) {
    return;
  }
  _id_26565B4B4F2F0779 = getangleindices(_id_077B9E4B599269EB);
  _id_DCF8F9E44BFA1D96 = self getnavposition();
  _id_FE8F7703F6313ED4 = _id_26565B4B4F2F0779[0];
  _id_637FB00E1A88028A = undefined;

  if(isDefined(self._id_57E1B0C4AD45DB70))
    _id_637FB00E1A88028A = getstartanim(self._id_57E1B0C4AD45DB70, _id_B63E3AA50397F874, _id_FE8F7703F6313ED4, _id_72C986BD4A45A6C1);
  else
    _id_637FB00E1A88028A = getstartanim(statename, _id_B63E3AA50397F874, _id_FE8F7703F6313ED4, _id_72C986BD4A45A6C1);

  if(!isDefined(self._id_57E1B0C4AD45DB70)) {
    _id_63218147D1BEACAC = issubstr(statename, "cover");
    _id_8C94765CA587F86C = _id_9DBC893FB4BE54F2;

    if(_id_63218147D1BEACAC && isDefined(_id_0DE315B064BB20D9)) {
      _id_0950FDAF84EE5363 = [-180, -135, -90, -90, -90, 90, 90, 135, -180];
      _id_A626CCAD8052F1BF = _id_0950FDAF84EE5363[_id_FE8F7703F6313ED4];

      if(issubstr(statename, "left") && _id_FE8F7703F6313ED4 == 4)
        _id_A626CCAD8052F1BF = _id_A626CCAD8052F1BF * -1;

      _id_8C94765CA587F86C = (0, angleclamp(_id_0DE315B064BB20D9.angles[1] + _id_A626CCAD8052F1BF), 0);
    } else {
      _id_00FD659656FF546E = [180, -135, -90, -45, 0, 45, 90, 135, 180];
      _id_A626CCAD8052F1BF = _id_00FD659656FF546E[_id_FE8F7703F6313ED4];
      _id_8C94765CA587F86C = (0, angleclamp(self.angles[1] + _id_A626CCAD8052F1BF), 0);
    }

    _id_28C922FDE27E0717 = 20.0;
    _id_76C97D8FA34A0AED = anglesToForward(_id_8C94765CA587F86C);
    velocity = _id_76C97D8FA34A0AED * self aigettargetspeed();
    movedelta = vectorNormalize(_id_76C97D8FA34A0AED) * 5.0;
    _id_29187EC6E45D7481 = self getadjustedexitdirection(_id_28C922FDE27E0717, velocity, movedelta);

    switch (_id_29187EC6E45D7481[0]) {
      case 1:
        _id_29187EC6E45D7481[1] = vectorNormalize(_id_29187EC6E45D7481[1]);
        _id_3FFC07559E34CBF3 = vectortoangles(_id_29187EC6E45D7481[1]);
        _id_CBFA26D1FE952710 = scripts\engine\math::wrap(-179, 179, angleclamp180(_id_3FFC07559E34CBF3[1] - _id_9DBC893FB4BE54F2[1]));
        _id_926EDF5CCD852690 = getangleindices(_id_CBFA26D1FE952710, 45);
        _id_4B4B8FB40B0A2DB2 = angleclamp180(_id_8C94765CA587F86C[1] - _id_9DBC893FB4BE54F2[1]);
        _id_B56298300777EE7A = getangleindices(_id_4B4B8FB40B0A2DB2);
        _id_DC6CBFDA5CAFD043 = _id_926EDF5CCD852690[0];

        for(_id_AC0E594AC96AA3A8 = _id_926EDF5CCD852690.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
          angleindex = _id_926EDF5CCD852690[_id_AC0E594AC96AA3A8];

          if(angleindex == _id_B56298300777EE7A[0])
            continue;
          else if((_id_FE8F7703F6313ED4 == 8 || _id_FE8F7703F6313ED4 == 0) && (angleindex == 8 || angleindex == 0))
            continue;
          else if(angleindex == _id_FE8F7703F6313ED4) {
            continue;
          }
          _id_DC6CBFDA5CAFD043 = angleindex;
          break;
        }

        _id_FE8F7703F6313ED4 = _id_DC6CBFDA5CAFD043;
        self.asm.customdata.ignoreexitwarp = 1;
        _id_637FB00E1A88028A = getstartanim(statename, _id_B63E3AA50397F874, _id_FE8F7703F6313ED4, _id_72C986BD4A45A6C1);
        break;
      case 2:
        _id_637FB00E1A88028A = undefined;
        break;
      default:
        break;
    }
  }

  return _id_637FB00E1A88028A;
}

movebattlechatter_helper(_id_02E5E380655D9414) {
  self endon("death");
  waitframe();
  movestartbattlechatter(_id_02E5E380655D9414);
}

playstartanim(asmname, statename, _id_637FB00E1A88028A, _id_BEF3B4B769E8ABE4) {
  self endon(statename + "_finished");
  _id_634E3D3B8E9B952F = self getposonpath(128);
  _id_69ED96EADF2D45CF = vectortoangles(_id_634E3D3B8E9B952F - self.origin);
  _id_077B9E4B599269EB = angleclamp180(_id_69ED96EADF2D45CF[1] - self.angles[1]);
  _id_DF150DDE45538E3C = scripts\asm\asm::asm_getxanim(statename, _id_637FB00E1A88028A);
  _id_370A8C08BE55A7A5 = getnotetracktimes(_id_DF150DDE45538E3C, "code_move");
  _id_6955B58947031CD2 = getnotetracktimes(_id_DF150DDE45538E3C, "corner");
  _id_BF4FA70506CA66C1 = getnotetracktimes(_id_DF150DDE45538E3C, "warp_exit_start");
  _id_D9A20F501851B31E = getnotetracktimes(_id_DF150DDE45538E3C, "warp_exit_end");
  _id_FB9376B06ABA09D7 = 1;

  if(_id_370A8C08BE55A7A5.size > 0) {
    self.requestarrivalnotify = 1;
    _id_FB9376B06ABA09D7 = _id_370A8C08BE55A7A5[0];
  }

  _id_F49F40EB39DA8B4E = getangledelta3d(_id_DF150DDE45538E3C, 0, _id_FB9376B06ABA09D7);
  self animmode("zonly_physics", 0);
  self setuseanimgoalweight(0.2);
  _id_EF7EA12479918983 = self.moveplaybackrate;

  if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentasoldier())
    _id_EF7EA12479918983 = 1;

  _id_DA09F2E04DA7570E = getmovedelta(_id_DF150DDE45538E3C, 0.0, _id_FB9376B06ABA09D7);
  _id_C4EC2D674BC02EB4 = length(_id_DA09F2E04DA7570E);
  _id_9C52E37B49E97A0B = self getposonpath(_id_C4EC2D674BC02EB4);

  if(_id_C4EC2D674BC02EB4 > 1)
    _id_B46ED9E10E2B2DA0 = _id_9C52E37B49E97A0B - self getnavposition();
  else
    _id_B46ED9E10E2B2DA0 = self getposonpath(12) - self getnavposition();

  _id_2C820822533FFAFC = vectortoyaw(_id_B46ED9E10E2B2DA0);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_DF150DDE45538E3C);
  self aisetanim(statename, _id_637FB00E1A88028A, _id_EF7EA12479918983);
  _id_5C0D1CBFC351F2E1 = 1;
  _id_5EC185BB9E766D14 = spawnStruct();
  _id_5EC185BB9E766D14.xanim = _id_DF150DDE45538E3C;

  if(isDefined(self.asm.customdata.ignoreexitwarp)) {} else if(_id_6955B58947031CD2.size > 0) {
    _id_E6621FA4CF24A23F = getmovedelta(_id_DF150DDE45538E3C, 0, _id_6955B58947031CD2[0]);
    _id_8E8CB6F743122604 = length(_id_E6621FA4CF24A23F);
    _id_583B1C0039D7EBA0 = self getposonpath(_id_8E8CB6F743122604);
    _id_5076FB03FB7166E3 = _id_9C52E37B49E97A0B;

    if(_id_C4EC2D674BC02EB4 - _id_8E8CB6F743122604 < 2)
      _id_5076FB03FB7166E3 = self getposonpath(_id_C4EC2D674BC02EB4 + 6);

    _id_F41896ED9D57F898 = _id_5076FB03FB7166E3 - _id_583B1C0039D7EBA0;
    _id_364F8DEA82C92744 = vectortoyaw(_id_F41896ED9D57F898);

    if(_id_BF4FA70506CA66C1.size > 0 && _id_BF4FA70506CA66C1[0] > 0 && _id_BF4FA70506CA66C1[0] < _id_6955B58947031CD2[0]) {
      _id_5EC185BB9E766D14.posalongpath = _id_583B1C0039D7EBA0;
      _id_5EC185BB9E766D14.anglealongpath = _id_364F8DEA82C92744;
      _id_5EC185BB9E766D14.endnote = "corner";

      if(_id_D9A20F501851B31E.size > 0 && _id_D9A20F501851B31E[0] < _id_6955B58947031CD2[0])
        _id_5EC185BB9E766D14.duration = int((_id_D9A20F501851B31E[0] - _id_BF4FA70506CA66C1[0]) * getanimlength(_id_DF150DDE45538E3C) * 1000 / _id_EF7EA12479918983);
    } else
      scripts\engine\utility::motionwarpwithnotetracks(_id_DF150DDE45538E3C, _id_583B1C0039D7EBA0, (0, _id_364F8DEA82C92744, 0), undefined, "corner", undefined, 0);
  } else if(_id_BF4FA70506CA66C1.size == 0 || _id_BF4FA70506CA66C1[0] == 0) {
    duration = undefined;

    if(_id_BF4FA70506CA66C1.size > 0 && _id_D9A20F501851B31E.size > 0 && _id_D9A20F501851B31E[0] < _id_370A8C08BE55A7A5[0])
      duration = int((_id_D9A20F501851B31E[0] - _id_BF4FA70506CA66C1[0]) * getanimlength(_id_DF150DDE45538E3C) * 1000);

    scripts\engine\utility::motionwarpwithnotetracks(_id_DF150DDE45538E3C, _id_9C52E37B49E97A0B, (0, _id_2C820822533FFAFC, 0), undefined, "code_move", duration, 0);
  }

  if(!isDefined(_id_5EC185BB9E766D14.posalongpath)) {
    _id_5EC185BB9E766D14.posalongpath = _id_9C52E37B49E97A0B;
    _id_5EC185BB9E766D14.anglealongpath = _id_2C820822533FFAFC;
    _id_5EC185BB9E766D14.endnote = "code_move";

    if(_id_BF4FA70506CA66C1.size > 0 && _id_D9A20F501851B31E.size > 0)
      _id_5EC185BB9E766D14.duration = int((_id_D9A20F501851B31E[0] - _id_BF4FA70506CA66C1[0]) * getanimlength(_id_DF150DDE45538E3C) * 1000 / _id_EF7EA12479918983);
  }

  groundent = self getgroundentity();

  if(isDefined(groundent))
    _id_5EC185BB9E766D14 = motionwarp_localizedata(_id_5EC185BB9E766D14, groundent);

  scripts\asm\asm::asm_donotetracks(asmname, statename, ::handlewarpexitstart, _id_5EC185BB9E766D14, undefined, !_id_BEF3B4B769E8ABE4);
  self motionwarpcancel();

  if(_id_BEF3B4B769E8ABE4) {
    self animmode("normal", 0);
    self orientmode("face motion");
    scripts\asm\asm::asm_donotetracks(asmname, statename);
  }
}

motionwarp_localizedata(_id_5EC185BB9E766D14, groundent) {
  _id_D352089B1AD84C9F = invertangles(groundent.angles);
  _id_AE6B4DE373BB5886 = _id_5EC185BB9E766D14.posalongpath - groundent.origin;
  _id_175BB7A3F0EA3191 = rotatevector(_id_AE6B4DE373BB5886, _id_D352089B1AD84C9F);
  _id_5EC185BB9E766D14.posalongpath = _id_175BB7A3F0EA3191;
  _id_5EC185BB9E766D14.anglealongpath = combineangles((0, _id_5EC185BB9E766D14.anglealongpath, 0), _id_D352089B1AD84C9F);
  _id_5EC185BB9E766D14.groundent = groundent;
  return _id_5EC185BB9E766D14;
}

motionwarp_getworldifydata(_id_5EC185BB9E766D14) {
  posalongpath = undefined;
  anglealongpath = undefined;
  groundent = _id_5EC185BB9E766D14.groundent;

  if(isDefined(groundent)) {
    _id_175BB7A3F0EA3191 = _id_5EC185BB9E766D14.posalongpath;
    _id_AE6B4DE373BB5886 = rotatevector(_id_175BB7A3F0EA3191, groundent.angles);
    posalongpath = _id_AE6B4DE373BB5886 + groundent.origin;
    angles = combineangles(_id_5EC185BB9E766D14.anglealongpath, groundent.angles);
    anglealongpath = angles[1];
    return [posalongpath, anglealongpath];
  } else
    return [_id_5EC185BB9E766D14.posalongpath, _id_5EC185BB9E766D14.anglealongpath];
}

handlewarpexitstart(_id_A234A65C378F3289, params) {
  posalongpath = undefined;
  anglealongpath = undefined;

  if(_id_A234A65C378F3289 == "warp_exit_start" && !isDefined(self.asm.customdata.ignoreexitwarp)) {
    endnote = params.endnote;

    if(!isDefined(endnote))
      endnote = "warp_exit_end";

    duration = undefined;

    if(isDefined(params.duration))
      duration = params.duration - params.duration % 50;

    [posalongpath, anglealongpath] = motionwarp_getworldifydata(params);
    scripts\engine\utility::motionwarpwithnotetracks(params.xanim, posalongpath, (0, anglealongpath, 0), "warp_exit_start", endnote, duration, 0);
  }
}

checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!self.facemotion)
    return 0;

  if(isDefined(self.disableexits) && self.disableexits)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  _id_636C8575D7A7768B = 100;
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_getdemeanor() == "casual" || scripts\asm\asm::asm_getdemeanor() == "casual_gun" || self aigetdesiredspeed() <= 60) {
    _id_636C8575D7A7768B = 50;

    if(istrue(self.disablearrivals))
      _id_636C8575D7A7768B = 25;
  } else if(istrue(self.disablearrivals))
    _id_636C8575D7A7768B = 50;

  if(self pathdisttogoal() < _id_636C8575D7A7768B)
    return 0;

  return 1;
}

_id_B2FCE9F29BD45CC3(asmname, statename, params) {
  self.runngun = 1;
  _id_63A5B32B096323BE = self getshootfrompos();
  _id_CFF075B05A95577B = self getshootpos(_id_63A5B32B096323BE);

  if(isDefined(_id_CFF075B05A95577B))
    targetpos = _id_CFF075B05A95577B.shootpos;
  else
    targetpos = self lastknownpos(self.enemy);

  _id_84DBA057067C3C3E = targetpos - self getposonpath(14);
  _id_51DA48562495C03A = vectortoyaw(_id_84DBA057067C3C3E);
  _id_C25F85E3D458191D = vectortoyaw(self.lookaheaddir);
  _id_43810D21F771F553 = angleclamp180(_id_51DA48562495C03A - _id_C25F85E3D458191D);
  _id_9BED543F317C7601 = -1;

  if(_id_43810D21F771F553 > 100)
    _id_9BED543F317C7601 = scripts\asm\asm::asm_lookupanimfromalias(statename, "run_n_gun_hard_left");
  else if(_id_43810D21F771F553 < -100)
    _id_9BED543F317C7601 = scripts\asm\asm::asm_lookupanimfromalias(statename, "run_n_gun_hard_right");
  else if(_id_43810D21F771F553 > 0)
    _id_9BED543F317C7601 = scripts\asm\asm::asm_lookupanimfromalias(statename, "run_n_gun_soft_left");
  else
    _id_9BED543F317C7601 = scripts\asm\asm::asm_lookupanimfromalias(statename, "run_n_gun_soft_right");

  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 0;
  self _meth_952292D70C3BD39C();
  return _id_9BED543F317C7601;
}

stoprunngun(asmname, statename, params) {
  self.runngun = 0;
  self.runngundisableaim = 0;
  self.baimedataimtarget = 0;
}

shouldstrafeaimchange(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_C7662529DA3A7F64 = 1;

  if(_id_C7662529DA3A7F64)
    return 0;

  if(!isDefined(self.asm.strafe_foot))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(self getreacquirestate() == "enabled")
    return 0;

  if(isonanystairs())
    return 0;

  _id_F290D7530D6ABA37 = self getstairsenterdist();
  _id_50CFD72556C53EE8 = self getstairsstateatdist(_id_F290D7530D6ABA37);

  if(_id_50CFD72556C53EE8 != "none")
    return 0;

  _id_543020482C67892F = self aigettargetspeed();

  if(self.lookaheaddist < 90)
    return 0;

  _id_C25F85E3D458191D = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9)
    return 0;

  _id_8C3AB01D2F494A38 = self asmeventfiredwithin(asmname, "sharp_turn", 50);

  if(_id_8C3AB01D2F494A38) {
    _id_185171D0A16D0416 = angleclamp180(_id_C25F85E3D458191D - self.angles[1]);
    _id_C1350E6CDA2F627A = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(_id_C1350E6CDA2F627A - _id_185171D0A16D0416)) > 45)
      return 0;
  } else
    _id_C1350E6CDA2F627A = angleclamp180(_id_C25F85E3D458191D - self.angles[1]);

  _id_63A5B32B096323BE = self getshootfrompos();
  _id_CFF075B05A95577B = self getshootpos(_id_63A5B32B096323BE);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe())
    _id_43810D21F771F553 = 0;
  else if(isDefined(_id_CFF075B05A95577B) || self iscurrentenemyvalid()) {
    if(isDefined(_id_CFF075B05A95577B))
      targetpos = _id_CFF075B05A95577B.shootpos;
    else {
      if(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000)
        return 0;

      targetpos = self lastknownpos(self.enemy);
    }

    if(distance2dsquared(targetpos, self.origin) < 22500)
      return 0;

    _id_84DBA057067C3C3E = targetpos - self getposonpath(32);
    _id_51DA48562495C03A = vectortoyaw(_id_84DBA057067C3C3E);

    if(abs(angleclamp180(_id_51DA48562495C03A - self.angles[1])) < 45)
      return 0;

    _id_43810D21F771F553 = angleclamp180(_id_C25F85E3D458191D - _id_51DA48562495C03A);
  } else if(istrue(self._blackboard.forcestrafe))
    return 0;
  else {
    if(_id_8C3AB01D2F494A38 || self pathdisttogoal() < 64)
      return 0;

    _id_43810D21F771F553 = angleclamp180(_id_C25F85E3D458191D - self.desiredangle);
  }

  if(abs(angleclamp180(_id_C1350E6CDA2F627A - _id_43810D21F771F553)) < 45)
    return 0;

  _id_A6EC3A05CD51B860 = scripts\asm\asm::yawdiffto2468(_id_C1350E6CDA2F627A);
  _id_D4C7B1E5457A2668 = scripts\asm\asm::yawdiffto2468(_id_43810D21F771F553);

  if(_id_A6EC3A05CD51B860 == _id_D4C7B1E5457A2668)
    return 0;

  _id_C7EEABFB94518B4D = "fast";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    archetype = self getbasearchetype();
    _id_C7EEABFB94518B4D = getnearestspeedthresholdname(archetype, _id_543020482C67892F);

    if(_id_C7EEABFB94518B4D == "shuffle" || _id_C7EEABFB94518B4D == "walk")
      _id_C7EEABFB94518B4D = "walk";
    else if(_id_C7EEABFB94518B4D != "fast")
      _id_C7EEABFB94518B4D = "fast";

    self.strafepoispeedtarget = getanimspeedthreshold(archetype, _id_C7EEABFB94518B4D);
  } else
    self.strafepoispeedtarget = undefined;

  alias = _id_C7EEABFB94518B4D + "_" + self.asm.strafe_foot + "_" + _id_A6EC3A05CD51B860 + "_to_" + _id_D4C7B1E5457A2668;

  if(!scripts\asm\asm::asm_hasalias(_id_F2B19B25D457C2A6, alias)) {
    if(_id_A6EC3A05CD51B860 == "4" || _id_A6EC3A05CD51B860 == "6")
      alias = _id_C7EEABFB94518B4D + "_feet_together_" + _id_A6EC3A05CD51B860 + "_to_" + _id_D4C7B1E5457A2668;
    else
      alias = _id_C7EEABFB94518B4D + "_foot_l_forward_" + _id_A6EC3A05CD51B860 + "_to_" + _id_D4C7B1E5457A2668;

    if(!scripts\asm\asm::asm_hasalias(_id_F2B19B25D457C2A6, alias))
      return 0;
  }

  self.asm.strafeaimchangealias = alias;
  return 1;
}

shouldrestartaimchange(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm::asm_eventfired(asmname, "code_move") && shouldstrafeaimchange(asmname, statename, _id_F2B19B25D457C2A6, params))
    return 1;

  return 0;
}

aimchangeorientation(_id_19B744B1CDEE4BCB, rate, endtime, _id_DA53C72859D22ED6, _id_F5704B6AF9B1E950) {
  self endon("end_aim_change_orient");
  self.aimchange_oldturnrate = self.turnrate;
  _id_C6741E13D5C04D5A = getangledelta(_id_19B744B1CDEE4BCB, 0.0, endtime);
  _id_935CE979BB3EF270 = _id_DA53C72859D22ED6 - self.angles[1];
  _id_935CE979BB3EF270 = angleclamp180(_id_935CE979BB3EF270);
  _id_573CD9DF7B140B5A = angleclamp180(_id_935CE979BB3EF270 - _id_C6741E13D5C04D5A);
  _id_74FB9D076076AA21 = _id_C6741E13D5C04D5A;

  while(isDefined(self) && isalive(self)) {
    _id_03572E193DBCA166 = self aigetanimtime(_id_19B744B1CDEE4BCB);
    _id_28F83227B5DBDEA8 = min(_id_03572E193DBCA166 + level.frameduration / 1000.0 / _id_F5704B6AF9B1E950 * rate, 1.0);
    _id_8CCBB038D1A5D254 = getangledelta(_id_19B744B1CDEE4BCB, _id_03572E193DBCA166, _id_28F83227B5DBDEA8);

    if((_id_74FB9D076076AA21 - _id_8CCBB038D1A5D254) * _id_74FB9D076076AA21 > 0)
      _id_74FB9D076076AA21 = _id_74FB9D076076AA21 - _id_8CCBB038D1A5D254;
    else {
      _id_8CCBB038D1A5D254 = _id_74FB9D076076AA21;
      _id_74FB9D076076AA21 = 0;
    }

    _id_6BDB8335862F56EE = _id_8CCBB038D1A5D254 / _id_C6741E13D5C04D5A;
    _id_BAC2C21AF365572B = _id_573CD9DF7B140B5A * _id_6BDB8335862F56EE;
    _id_D5655124CC692C6F = _id_8CCBB038D1A5D254 + _id_BAC2C21AF365572B;
    _id_7F55545F660EF1BB = angleclamp(self.angles[1] + _id_D5655124CC692C6F);
    _id_06B38B069B1D09AD = angleclamp(self.angles[1] + clamp(_id_D5655124CC692C6F * 3, -179.0, 179.9));
    self orientmode("face angle", _id_06B38B069B1D09AD);

    if(_id_D5655124CC692C6F != 0.0) {
      turnrate = abs(angleclamp180(self.angles[1] - _id_7F55545F660EF1BB)) / level.frameduration;

      if(turnrate > 0)
        self.turnrate = turnrate;
    }

    waitframe();
  }
}

playanim_strafeaimchange(asmname, statename, params) {
  self endon(statename + "_finished");
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_19B744B1CDEE4BCB = scripts\asm\asm::asm_getxanim(statename, animindex);
  self.asm.strafeaimchangealias = undefined;
  self.sharpturnforceusevelocity = 1;
  rate = 1;
  _id_8BA91CC72B54AF6C = undefined;

  if(isDefined(self.strafepoispeedtarget) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    _id_543020482C67892F = self aigettargetspeed();
    rate = _id_543020482C67892F / self.strafepoispeedtarget;
    _id_8BA91CC72B54AF6C = _id_543020482C67892F;
    rate = clamp(rate, 0.6, 1.4);
  }

  self aisetanim(statename, animindex, rate);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_19B744B1CDEE4BCB);
  _id_1CF3CC2BFBD90835 = getnotetracktimes(_id_19B744B1CDEE4BCB, "code_move");
  _id_268F83E1BA7FB62B = getnotetracktimes(_id_19B744B1CDEE4BCB, "finish");
  endtime = 1;

  if(_id_1CF3CC2BFBD90835.size > 0)
    endtime = _id_1CF3CC2BFBD90835[0];
  else if(_id_268F83E1BA7FB62B.size > 0)
    endtime = _id_268F83E1BA7FB62B[0];

  _id_F5704B6AF9B1E950 = getanimlength(_id_19B744B1CDEE4BCB);
  animlength = _id_F5704B6AF9B1E950 * endtime;
  _id_DA53C72859D22ED6 = vectortoyaw(self.lookaheaddir);
  _id_7B953DF46FFA1995 = undefined;

  if(!istrue(self.facemotion) && !istrue(self.predictedfacemotion) && !self shouldcautiousstrafe()) {
    _id_76C97D8FA34A0AED = getmovedelta(_id_19B744B1CDEE4BCB, 0, endtime);
    _id_4C9C5E3A46583337 = self getposonpath(length(_id_76C97D8FA34A0AED));
    _id_63A5B32B096323BE = self getshootfrompos();
    _id_CFF075B05A95577B = self getshootpos(_id_63A5B32B096323BE);
    _id_D59ED0E8C57E2DEF = undefined;

    if(isDefined(_id_CFF075B05A95577B))
      _id_D59ED0E8C57E2DEF = _id_CFF075B05A95577B.shootpos;
    else if(isDefined(self.enemy))
      _id_D59ED0E8C57E2DEF = self lastknownpos(self.enemy);

    if(isDefined(_id_D59ED0E8C57E2DEF)) {
      _id_84DBA057067C3C3E = vectorNormalize(_id_D59ED0E8C57E2DEF - _id_4C9C5E3A46583337);
      _id_DA53C72859D22ED6 = vectortoyaw(_id_84DBA057067C3C3E);
      _id_7B953DF46FFA1995 = _id_D59ED0E8C57E2DEF;
    }
  }

  thread aimchangeorientation(_id_19B744B1CDEE4BCB, rate, endtime, _id_DA53C72859D22ED6, _id_F5704B6AF9B1E950);
  _id_A234A65C378F3289 = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    if(self.aimchange_oldturnrate > 0)
      self.turnrate = self.aimchange_oldturnrate;

    self.aimchange_oldturnrate = undefined;
  }

  if(_id_A234A65C378F3289 == "code_move") {
    if(isDefined(_id_7B953DF46FFA1995))
      self orientmode("face point", _id_7B953DF46FFA1995);
    else
      self orientmode("face angle", _id_DA53C72859D22ED6);

    self animmode("normal");
    scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  }

  if(isDefined(_id_8BA91CC72B54AF6C))
    self aisettargetspeed(_id_8BA91CC72B54AF6C);
}

chooseanim_strafeaimchange(asmname, statename, params) {
  return scripts\asm\asm::asm_lookupanimfromalias(statename, self.asm.strafeaimchangealias);
}

strafeaimchange_cleanup(asmname, statename, params) {
  self notify("end_aim_change_orient");

  if(isDefined(self.aimchange_oldturnrate)) {
    self.turnrate = self.aimchange_oldturnrate;
    self.aimchange_oldturnrate = undefined;
  }

  self.sharpturnforceusevelocity = 0;
}

handlestrafenotetracks(_id_A234A65C378F3289) {
  switch (_id_A234A65C378F3289) {
    case "anim_pose = feet_together":
      self.asm.strafe_foot = "feet_together";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = feet_apart":
      self.asm.strafe_foot = "feet_apart";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = foot_l_forward":
      self.asm.strafe_foot = "foot_l_forward";
      self.asm.strafe_foot_time = gettime();
      break;
    case "anim_pose = foot_r_forward":
      self.asm.strafe_foot = "foot_r_forward";
      self.asm.strafe_foot_time = gettime();
      break;
  }
}

playanim_strafereverse(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_49705E6AD03A9802 = 0.4;
  _id_878ED8F396ED59BD = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, _id_878ED8F396ED59BD);
  self orientmode("face enemy or motion");
  self setstrafereverse(1);
  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);

  if(endnote == "code_move") {
    self animmode("normal");
    endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(asmname, "end");
}

strafereverse_cleanup(asmname, statename, params) {
  self setstrafereverse(0);
}

chooseanim_strafearrive(asmname, statename, params) {
  return self.asm.strafearrival_animindex;
}

choosewalkandtalkanims(asmname, statename, params) {
  animstruct = spawnStruct();
  _id_D3EBB1FD79CBE1D2 = [];
  _id_D3EBB1FD79CBE1D2[0] = scripts\asm\asm::asm_lookupanimfromalias(statename, "0");
  _id_D3EBB1FD79CBE1D2[1] = scripts\asm\asm::asm_lookupanimfromalias(statename, "1");
  _id_D3EBB1FD79CBE1D2[2] = scripts\asm\asm::asm_lookupanimfromalias(statename, "2");
  animstruct.anims = _id_D3EBB1FD79CBE1D2;
  animstruct.forwardanim = scripts\asm\asm::asm_lookupanimfromalias(statename, "forward");
  return animstruct;
}

shouldwalkandtalk() {
  return scripts\asm\asm_bb::bb_moverequested() && isDefined(self._blackboard.walk_and_talk_requested) && self._blackboard.walk_and_talk_requested;
}

walkandtalkdonotetracks(asmname, statename) {
  self endon(statename + "_finished");

  for(;;)
    scripts\asm\asm::asm_donotetracks(asmname, statename);
}

movewalkandtalk(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  rate = scripts\asm\asm::asm_getmoveplaybackrate();
  scripts\asm\asm::asm_updatefrantic();
  self codemoveanimrate(rate);
  scripts\asm\asm::asm_updatefrantic();
  animstruct = scripts\asm\asm::asm_getanim(asmname, statename);
  anims = animstruct.anims;
  forwardanim = animstruct.forwardanim;
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanim(statename, forwardanim, 1.0, 0.2, 1.0);
  thread walkandtalkdonotetracks(asmname, statename);
  _id_3D7914E94E554E38 = 0;
  _id_4CB53F922F32382E = 20;

  for(;;) {
    _id_62ED904F1FCE7586 = scripts\asm\asm::asm_eventfired(asmname, "cover_approach");
    _id_29074E84B454250F = self pathdisttogoal();

    if(_id_62ED904F1FCE7586 && _id_29074E84B454250F < 150) {
      _id_077B9E4B599269EB = anglediffwalkandtalk();
      index = 1;

      while(index <= _id_4CB53F922F32382E) {
        _id_AC0E594AC96AA3A8 = index / _id_4CB53F922F32382E;
        result = _id_AC0E594AC96AA3A8 * _id_AC0E594AC96AA3A8 * (3 - 2 * _id_AC0E594AC96AA3A8);
        _id_F378F750B9379926 = _id_077B9E4B599269EB;
        _id_EC53900B925694AA = _id_F378F750B9379926 * result;
        _id_1B374815FB658B4B = _id_F378F750B9379926 - _id_EC53900B925694AA;
        _id_37EE045145512FBD = getwalkandtalkanimweights(_id_1B374815FB658B4B);

        for(animindex = 0; animindex < _id_37EE045145512FBD.size; animindex++)
          self setanim(anims[animindex], _id_37EE045145512FBD[animindex], 0.2, 1.0, 1);

        index++;
        wait 0.05;
        waittillframeend;
      }

      while(_id_62ED904F1FCE7586) {
        _id_37EE045145512FBD = getwalkandtalkanimweights(0);

        for(index = 0; index < _id_37EE045145512FBD.size; index++) {
          if(isDefined(anims[index]))
            self setanim(anims[index], _id_37EE045145512FBD[index], 0.2, 1.0, 1);
        }

        wait 0.05;
        waittillframeend;
      }

      continue;
    }

    _id_077B9E4B599269EB = anglediffwalkandtalk();
    _id_3CC8FBA2E49545A3 = _id_3D7914E94E554E38 - _id_077B9E4B599269EB;

    if(_id_3CC8FBA2E49545A3 < 0)
      _id_3CC8FBA2E49545A3 = _id_3CC8FBA2E49545A3 * -1;

    if(_id_3CC8FBA2E49545A3 >= 60) {
      _id_7B7E39CB9A3FC1D3 = _id_3D7914E94E554E38;
      _id_71EA1EF57B26F1B9 = _id_3D7914E94E554E38;
      index = 1;

      while(index <= _id_4CB53F922F32382E) {
        _id_077B9E4B599269EB = anglediffwalkandtalk();
        _id_14D30308B9F18E3F = _id_7B7E39CB9A3FC1D3 - _id_077B9E4B599269EB;

        if(_id_14D30308B9F18E3F < 0)
          _id_14D30308B9F18E3F = _id_14D30308B9F18E3F * -1;

        if(_id_14D30308B9F18E3F >= 60) {
          if(index == 1)
            index = 1;
          else
            index = index - 1;

          _id_68EB110BEAFC9600 = _id_7B7E39CB9A3FC1D3 - _id_3D7914E94E554E38;
          _id_AC0E594AC96AA3A8 = index / _id_4CB53F922F32382E;
          result = _id_AC0E594AC96AA3A8 * _id_AC0E594AC96AA3A8 * (3 - 2 * _id_AC0E594AC96AA3A8);
          _id_5AA9C8971AE96B16 = _id_68EB110BEAFC9600 * result;
          _id_71EA1EF57B26F1B9 = _id_5AA9C8971AE96B16 + _id_3D7914E94E554E38;
          index = 1;
          _id_3D7914E94E554E38 = _id_71EA1EF57B26F1B9;
        }

        _id_AC0E594AC96AA3A8 = index / _id_4CB53F922F32382E;
        result = _id_AC0E594AC96AA3A8 * _id_AC0E594AC96AA3A8 * (3 - 2 * _id_AC0E594AC96AA3A8);
        _id_F378F750B9379926 = _id_077B9E4B599269EB - _id_71EA1EF57B26F1B9;
        _id_EC53900B925694AA = _id_F378F750B9379926 * result;
        _id_1B374815FB658B4B = _id_EC53900B925694AA + _id_3D7914E94E554E38;
        _id_37EE045145512FBD = getwalkandtalkanimweights(_id_1B374815FB658B4B);

        for(animindex = 0; animindex < _id_37EE045145512FBD.size; animindex++)
          self setanim(anims[animindex], _id_37EE045145512FBD[animindex], 0.2, 1.0, 1);

        index++;
        _id_7B7E39CB9A3FC1D3 = _id_077B9E4B599269EB;
        wait 0.05;
        waittillframeend;
      }
    } else {
      _id_37EE045145512FBD = getwalkandtalkanimweights(_id_077B9E4B599269EB);

      for(index = 0; index < _id_37EE045145512FBD.size; index++) {
        if(isDefined(anims[index]))
          self setanim(anims[index], _id_37EE045145512FBD[index], 0.2, 1.0, 1);
      }

      wait 0.05;
      waittillframeend;
    }

    _id_3D7914E94E554E38 = _id_077B9E4B599269EB;
  }
}

anglediffwalkandtalk() {
  targetpos = self.walk_and_talk_target.origin;
  _id_3B4D8AB7E1947F44 = self.origin;
  _id_2B58E9F9E67DE0A5 = targetpos - _id_3B4D8AB7E1947F44;
  _id_E54272533AB42FD2 = anglesToForward(self.angles);
  _id_775361D05A790917 = vectorcross(_id_E54272533AB42FD2, _id_2B58E9F9E67DE0A5);
  _id_8C4DF4C0C2ED1C92 = vectorNormalize(_id_775361D05A790917);
  _id_F99C61AA3BB21BF0 = vectorNormalize(_id_2B58E9F9E67DE0A5);
  _id_14F0BA9B842953A9 = vectorNormalize(_id_E54272533AB42FD2);
  dot = vectordot(_id_F99C61AA3BB21BF0, _id_14F0BA9B842953A9);

  if(isDefined(self.walk_and_talk_hemisphere)) {
    _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(_id_2B58E9F9E67DE0A5, _id_E54272533AB42FD2);

    if(self.walk_and_talk_hemisphere == "right") {
      if(dot <= -1)
        return -180;

      return _id_077B9E4B599269EB * -1;
      return;
    }

    if(dot >= 1)
      return 180;

    return _id_077B9E4B599269EB;
    return;
  } else {
    if(dot >= 1)
      return 180;

    if(dot <= -1)
      return -180;
    else {
      _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(_id_2B58E9F9E67DE0A5, _id_E54272533AB42FD2);

      if(_id_8C4DF4C0C2ED1C92[2] == -1)
        _id_077B9E4B599269EB = _id_077B9E4B599269EB * -1;

      return _id_077B9E4B599269EB;
    }
  }
}

getwalkandtalkanimweights(yaw) {
  _id_37EE045145512FBD = [];

  for(index = 0; index < 3; index++)
    _id_37EE045145512FBD[index] = 0;

  _id_2D702DDB2A9C3231 = [-180, 0, 180];

  for(index = 0; yaw >= _id_2D702DDB2A9C3231[index]; index++) {}

  _id_D1EEA60321B43092 = index - 1;
  next_index = index;
  _id_E0C8607002F43670 = (yaw - _id_2D702DDB2A9C3231[_id_D1EEA60321B43092]) / (_id_2D702DDB2A9C3231[next_index] - _id_2D702DDB2A9C3231[_id_D1EEA60321B43092]);
  _id_538BF88F24008653 = 1 - _id_E0C8607002F43670;
  _id_37EE045145512FBD[_id_D1EEA60321B43092] = _id_538BF88F24008653;
  _id_37EE045145512FBD[next_index] = _id_E0C8607002F43670;
  _id_37EE045145512FBD[1] = max(0.01, _id_37EE045145512FBD[1]);
  return _id_37EE045145512FBD;
}

movestartbattlechatter(_id_02E5E380655D9414) {
  movetype = scripts\asm\asm::asm_getdemeanor();

  if(movetype == "frantic" || movetype == "combat" || movetype == "sprint")
    _id_50EEB9595C6D6E1B::_id_42C77C7F13A1BEB8(_id_02E5E380655D9414);
}

shouldreloadwhilemoving(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!scripts\asm\asm_bb::bb_reloadrequested())
    return 0;

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed()))
    _id_636C8575D7A7768B = 500;
  else
    _id_636C8575D7A7768B = 600;

  _id_29074E84B454250F = self pathdisttogoal();
  return _id_636C8575D7A7768B < _id_29074E84B454250F;
}

choosereloadwhilemoving(asmname, statename, params) {
  alias = "reload";
  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed()))
    alias = "cqbreload";

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

playreloadwhilemoving(asmname, statename, params) {
  self endon(statename + "_finished");
  self.requestarrivalnotify = 1;
  _id_B1220E4C669F952D = scripts\asm\asm::asm_getanim(asmname, statename);
  self aisetanim(statename, _id_B1220E4C669F952D);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, scripts\asm\asm::asm_getxanim(statename, _id_B1220E4C669F952D));
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

terminatereloadwhilemoving(asmname, statename, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "reload done"))
    _id_76FF4BA096A6F8AA::refillclip();

  scripts\asm\soldier\script_funcs::reload_cleanup(asmname, statename, params);
}

isonanystairs() {
  return isDefined(self.pathgoalpos) && self.stairsstate != "none";
}

getgroundangle() {
  _id_13F52C8DB665C5A4 = self actorgetgroundslope();

  if(abs(_id_13F52C8DB665C5A4) > 0.99)
    return 0;

  _id_55E93CD84D333D71 = acos(_id_13F52C8DB665C5A4);
  return _id_55E93CD84D333D71;
}

chooseanim_stairs(asmname, statename, params) {
  if(self.asm.footsteps.foot == "left")
    alias = "right";
  else
    alias = "left";

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    _id_7E147D94763036AC = "cqb" + alias;

    if(scripts\asm\asm::asm_hasalias(statename, _id_7E147D94763036AC))
      alias = _id_7E147D94763036AC;
  }

  _id_B2D44E59BDD5197A = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return _id_B2D44E59BDD5197A;
}

chooseanim_stairs_rise_run(asmname, statename, params) {
  alias = "8x10";
  angle = getgroundangle();

  if(angle < 27.75)
    alias = "8x20";

  if(angle >= 27.75 && angle < 36.2)
    alias = "8x12";

  if(angle >= 36.2 && angle < 41.85)
    alias = "8x10";

  if(angle >= 41.85)
    alias = "8x8";

  archetype = self getbasearchetype();

  if(isspeedwithincqbrange(archetype, self aigetdesiredspeed())) {
    _id_7E147D94763036AC = "cqb" + alias;

    if(scripts\asm\asm::asm_hasalias(statename, _id_7E147D94763036AC))
      alias = _id_7E147D94763036AC;
  }

  _id_B2D44E59BDD5197A = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return _id_B2D44E59BDD5197A;
}

slopeupdate(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self.useslopes) && self.useslopes == 1) {
    _id_873556140EA95085 = 0;
    _id_D3EE4B860B00683F = 0;
    _id_8C6D33F889F4EA11 = (0, 0, 1);
    self endon(statename + "_finished");
    _id_4ADA6B5C09CF4A64 = scripts\asm\asm::asm_lookupanimfromalias(statename, statename + "_knob");
    _id_15E042E2E6F020DD = scripts\asm\asm::asm_getxanim(statename, _id_4ADA6B5C09CF4A64);
    _id_3E9FFF4931014EB8 = scripts\asm\asm::asm_lookupanimfromalias(statename, statename + "_scrub_anim");
    _id_B19BFC7A5CA49C01 = scripts\asm\asm::asm_getxanim(statename, _id_3E9FFF4931014EB8);
    self setanim(_id_15E042E2E6F020DD, 1.0, 0.1, 0);
    self setanim(_id_B19BFC7A5CA49C01, 1.0, 0.1, 0);

    for(;;) {
      _id_42DF814509C079B7 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 12), self.origin - (0, 0, 999));
      _id_0F8B6736D170EA6C = _id_42DF814509C079B7["normal"];
      _id_0F8B6736D170EA6C = vectorlerp(_id_8C6D33F889F4EA11, _id_0F8B6736D170EA6C, 0.25);
      _id_8C6D33F889F4EA11 = _id_0F8B6736D170EA6C;
      _id_753CC7857ED5A9ED = anglestoup(self.angles);
      _id_7553FEAF32873060 = scripts\engine\math::vector_project_onto_plane(_id_0F8B6736D170EA6C, _id_753CC7857ED5A9ED);
      _id_0A2A227242F2C364 = self.angles;
      _id_379097055795A272 = anglesToForward(_id_0A2A227242F2C364);
      _id_4E75D9CB5398F7ED = scripts\engine\math::anglebetweenvectorssigned(_id_379097055795A272, _id_7553FEAF32873060, _id_753CC7857ED5A9ED);
      _id_873556140EA95085 = _id_4E75D9CB5398F7ED + 180;
      _id_0E08B4AB11320959 = _id_0F8B6736D170EA6C[2];
      _id_D3EE4B860B00683F = scripts\engine\math::normalize_value(1, 0.707, _id_0E08B4AB11320959);
      _id_D3EE4B860B00683F = 1 - _id_D3EE4B860B00683F;
      self setanim(_id_15E042E2E6F020DD, _id_D3EE4B860B00683F, 0.2, 0);
      self setcustomnodegameparameter("slopes_scrub_direction", _id_873556140EA95085);
      waitframe();
    }
  }
}

slopecleanup(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }
  _id_B9ED8FE7204C646D = scripts\asm\asm::asm_lookupanimfromalias(statename, statename + "_knob");
  self clearanim(scripts\asm\asm::asm_getxanim(statename, _id_B9ED8FE7204C646D), 0.1, "ease_inout_quad");
}

stumblechooseanim(asmname, statename, params) {
  archetype = self getbasearchetype();
  _id_856EC761433007A9 = getanimspeedthreshold(archetype, "run");
  _id_81A5DDC08A0B28D4 = getanimspeedthreshold(archetype, "sprint");
  speed = length(self.velocity);
  alias = "stumble_jog";

  if(isDefined(_id_81A5DDC08A0B28D4) && speed > _id_81A5DDC08A0B28D4)
    alias = "stumble_sprint";

  if(isDefined(_id_856EC761433007A9) && speed > _id_856EC761433007A9)
    alias = "stumble_run";

  return scripts\asm\asm::asm_chooseanim(asmname, statename, alias);
}

playanim_stumble(asmname, statename, params) {
  self.requestarrivalnotify = 1;
  self._id_5185ACCFC2476D43 = 1;
  self._id_001F91D3DA0786A2 = 0;
  scripts\asm\asm::asm_playanimstate(asmname, statename, params);
}