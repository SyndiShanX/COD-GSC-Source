/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_395dc18818f65ef2.gsc
***********************************************/

notshouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !shouldstartarrival(asmname, statename, params);
}

getmaxarrivaldistfornodetype(nodetype) {
  return 256.0;
}

shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self shoulddoarrival())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!scripts\asm\asm::asm_eventfired(asmname, "cover_approach"))
    return 0;

  if(!isDefined(self.approachdir))
    return 0;

  if(isDefined(params)) {
    if(!isarray(params))
      nodetype = params;
    else if(params.size < 1)
      nodetype = "Exposed";
    else
      nodetype = params[0];
  } else
    nodetype = "Exposed";

  if(!scripts\asm\shared\utility::isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, nodetype))
    return 0;

  _id_5217DF91F13C7C48 = 0;

  if(isDefined(params) && isarray(params) && params.size >= 2 && params[1])
    _id_5217DF91F13C7C48 = 1;

  self.asm.stopdata = calculatestopdata(asmname, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

shouldconsiderarrival(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!self shoulddoarrival())
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!scripts\asm\asm::asm_eventfired(asmname, "cover_approach"))
    return 0;

  return 1;
}

shouldstartcasualarrival(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shouldstartcasualarrivalwithgun(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shouldstartarrivalpatrol(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(scripts\asm\asm_bb::bb_isincombat())
    return 0;

  return shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

chooseanim_arrival(asmname, statename, params) {
  return self.asm.stopdata;
}

calculatestopdata(asmname, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48) {
  node = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(node))
    goalpos = node.origin;
  else
    goalpos = self.pathgoalpos;

  _id_0A41EDF45BB0FF97 = getcustomarrivalangles();
  approachdir = self.approachdir;
  _id_098309FE48684A69 = vectortoangles(approachdir);

  if(isDefined(_id_0A41EDF45BB0FF97))
    _id_077B9E4B599269EB = angleclamp180(_id_0A41EDF45BB0FF97[1] - _id_098309FE48684A69[1]);
  else if(isDefined(node) && node.type != "Path")
    _id_077B9E4B599269EB = angleclamp180(node.angles[1] - _id_098309FE48684A69[1]);
  else {
    _id_03BB21148DC871D5 = goalpos - self.origin;
    _id_3F0B2928B3D20E77 = vectortoangles(_id_03BB21148DC871D5);
    _id_077B9E4B599269EB = angleclamp180(_id_3F0B2928B3D20E77[1] - _id_098309FE48684A69[1]);
  }

  angleindex = getangleindex(_id_077B9E4B599269EB, 22.5);
  statename = _id_F2B19B25D457C2A6;

  if(nodetype == "Custom") {
    _id_9B9C0392FA49456D = getstopanims(asmname, self._id_A57082FDF62BC898, undefined, self._id_171120E99DF3E286);
    statename = self._id_A57082FDF62BC898;
  } else
    _id_9B9C0392FA49456D = getstopanims(asmname, _id_F2B19B25D457C2A6, undefined, _id_5217DF91F13C7C48);

  stopdata = _id_4135A2CC5B6963F3();
  _id_CCA29AD02A7C9BC6 = goalpos - self.origin;
  _id_3E7CFCDE4082C05E = lengthsquared(_id_CCA29AD02A7C9BC6);
  _id_CB2DB50AF34426A8 = _id_9B9C0392FA49456D[angleindex];

  if(!isDefined(_id_CB2DB50AF34426A8))
    return undefined;

  stopanim = self getanimentry(statename, _id_CB2DB50AF34426A8);
  _id_F075350FC4BE0D85 = getmovedelta(stopanim);
  _id_FD7C686CEAD623AA = getangledelta(stopanim);
  speed = length(self getvelocity());
  _id_8B8C240A0C200744 = speed * 0.053;
  _id_C92AEBFF8AAF03BA = length(_id_CCA29AD02A7C9BC6);
  _id_8DE6AAEAC22DB149 = length(_id_F075350FC4BE0D85);

  if(abs(_id_C92AEBFF8AAF03BA - _id_8DE6AAEAC22DB149) > _id_8B8C240A0C200744)
    return undefined;

  if(_id_3E7CFCDE4082C05E < lengthsquared(_id_F075350FC4BE0D85))
    return undefined;

  _id_641C7B140664D9D3 = calcanimstartpos(stopdata.pos, stopdata.finalangles[1], _id_F075350FC4BE0D85, _id_FD7C686CEAD623AA);
  _id_6DDA435EB9FD8059 = getclosestpointonnavmesh(stopdata.pos, self);
  _id_844127D31748B6D0 = calcanimstartpos(_id_6DDA435EB9FD8059, stopdata.finalangles[1], _id_F075350FC4BE0D85, _id_FD7C686CEAD623AA);
  _id_DA0655335C41C2C2 = self getnavposition();
  _id_88CF2578F755EB28 = nodetype == "Cover Left" || nodetype == "Cover Right" || nodetype == "Cover Left Crouch" || nodetype == "Cover Right Crouch";

  if(_id_88CF2578F755EB28 && (angleindex == 0 || angleindex == 8 || angleindex == 7 || angleindex == 1)) {
    turningpoint = undefined;
    splittime = undefined;
    _id_6955B58947031CD2 = getnotetracktimes(stopanim, "corner");

    if(_id_6955B58947031CD2.size > 0) {
      turningpoint = getmovedelta(stopanim, 0, _id_6955B58947031CD2[0]);
      splittime = _id_6955B58947031CD2[0];
    } else {
      lookup = undefined;
      _id_7F64B8F511005E9D = undefined;

      if(nodetype == "Cover Left" || nodetype == "Cover Left Crouch") {
        lookup = "left";

        if(angleindex == 7)
          _id_7F64B8F511005E9D = "7";
        else if(angleindex == 0 || angleindex == 8)
          _id_7F64B8F511005E9D = "8";
      } else if(nodetype == "Cover Right" || nodetype == "Cover Right Crouch") {
        lookup = "right";

        if(angleindex == 0 || angleindex == 8)
          _id_7F64B8F511005E9D = "8";
        else if(angleindex == 1)
          _id_7F64B8F511005E9D = "9";
      }

      if(isDefined(lookup) && isDefined(_id_7F64B8F511005E9D)) {
        turningpoint = _id_56001947D28B30D6(asmname, _id_F2B19B25D457C2A6, _id_7F64B8F511005E9D, _id_5217DF91F13C7C48);
        splittime = _id_8936CD52CAA8D8F0(asmname, _id_F2B19B25D457C2A6, _id_7F64B8F511005E9D, _id_5217DF91F13C7C48);
      }
    }

    if(isDefined(turningpoint)) {
      turningpoint = rotatevector(turningpoint, (0, stopdata.finalangles[1] - _id_FD7C686CEAD623AA, 0));
      turningpoint = _id_844127D31748B6D0 + turningpoint;
      traceresults = navtrace(_id_DA0655335C41C2C2, turningpoint, self, 1);

      if(traceresults["fraction"] >= 0.9 || _func_BE87C989A3B9C6CD(_id_DA0655335C41C2C2, turningpoint, self)) {
        result = spawnStruct();
        result._id_CB2DB50AF34426A8 = _id_CB2DB50AF34426A8;
        result.angleindex = angleindex;
        result.startpos = _id_641C7B140664D9D3;
        result.angledelta = _id_FD7C686CEAD623AA;
        result.angles = stopdata.angles;
        result.finalangles = stopdata.finalangles;
        result.movedelta = _id_F075350FC4BE0D85;
        result.turningpoint = turningpoint;
        result.splittime = splittime;
        return result;
      }
    }
  } else {
    traceresults = navtrace(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059, self, 1);
    _id_58A8DB9B7B528979 = traceresults["fraction"] >= 0.9 || _func_BE87C989A3B9C6CD(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059, self);

    if(!_id_58A8DB9B7B528979) {
      pathdist = self pathdisttogoal();
      _id_58A8DB9B7B528979 = pathdist < distance(_id_DA0655335C41C2C2, _id_6DDA435EB9FD8059) + 8.0;
    }

    if(_id_58A8DB9B7B528979) {
      result = spawnStruct();
      result._id_CB2DB50AF34426A8 = _id_CB2DB50AF34426A8;
      result.angleindex = angleindex;
      result.startpos = _id_641C7B140664D9D3;
      result.angledelta = _id_FD7C686CEAD623AA;
      result.angles = stopdata.angles;
      result.finalangles = stopdata.finalangles;
      result._id_F075350FC4BE0D85 = _id_F075350FC4BE0D85;
      result._id_70B532DBD77D980C = goalpos;
      return result;
    }
  }

  return undefined;
}

playanim_waitforpathset(asmname, statename) {
  self endon("runto_arrived");
  self endon(statename + "_finished");
  self waittill("path_set");
  scripts\asm\asm::asm_fireevent(asmname, "abort");
}

playanim_waitforpathclear(asmname, statename) {
  self endon("runto_arrived");
  self endon(statename + "_finished");

  for(;;) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  scripts\asm\asm::asm_fireevent(asmname, "abort");
}

playanim_arrival(asmname, statename, params) {
  self endon(statename + "_finished");
  node = scripts\asm\shared\utility::getarrivalnode();
  stopdata = scripts\asm\asm_mp::asm_getanimindex(asmname, statename);

  if(!isDefined(stopdata)) {
    scripts\asm\asm::asm_fireevent(asmname, "abort", undefined);
    return;
  }

  _id_C08B84490B532FB2 = scripts\asm\asm::asm_getmoveplaybackrate();

  if(!isDefined(_id_C08B84490B532FB2))
    _id_C08B84490B532FB2 = 1.0;

  _id_B84971510AAF7CD3 = stopdata.finalangles;
  angleindex = stopdata.angleindex;
  _id_29A16A52B186224E = (0, _id_B84971510AAF7CD3[1] - stopdata.angledelta, 0);
  animname = self getanimentry(statename, stopdata._id_CB2DB50AF34426A8);
  animlength = getanimlength(animname);
  animlength = animlength * (1 / _id_C08B84490B532FB2);
  self startcoverarrival(stopdata.startpos, _id_29A16A52B186224E[1], animlength);
  scripts\asm\asm_mp::asm_playanimstateindex(asmname, statename, stopdata._id_CB2DB50AF34426A8, _id_C08B84490B532FB2);
}

arrivalhack_emptywait() {
  self endon("killanimscript");
  self waittill(self.arrivalasmstatename + "_finished");
}

getcustomarrivalangles() {
  if(isDefined(self._id_0A41EDF45BB0FF97))
    return self._id_0A41EDF45BB0FF97;

  return undefined;
}

_id_4135A2CC5B6963F3() {
  stopdata = spawnStruct();
  node = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(node) && node.type != "Path") {
    stopdata.pos = node.origin;
    stopdata.angles = node.angles;
    stopdata.finalangles = (0, scripts\asm\shared\utility::getnodeforwardyaw(node), 0);
  } else {
    stopdata.pos = self.pathgoalpos;
    velocity = self getvelocity();
    lookaheaddir = self.lookaheaddir;

    if(lengthsquared(velocity) > 1)
      stopdata.angles = vectortoangles(stopdata.pos - self.origin);
    else
      stopdata.angles = vectortoangles(lookaheaddir);

    stopdata.finalangles = stopdata.angles;
  }

  _id_0A41EDF45BB0FF97 = getcustomarrivalangles();

  if(isDefined(_id_0A41EDF45BB0FF97)) {
    stopdata.angles = _id_0A41EDF45BB0FF97;
    stopdata.finalangles = stopdata.angles;
  }

  return stopdata;
}

calcanimstartpos(_id_D59CE05D15358F85, _id_2CDC979364D3101C, _id_95ABCCFE668F369A, _id_F73BEA4534A3831F) {
  _id_CE5C9B08861A4466 = _id_2CDC979364D3101C - _id_F73BEA4534A3831F;
  angles = (0, _id_CE5C9B08861A4466, 0);
  _id_728D033793CEA02F = rotatevector(_id_95ABCCFE668F369A, angles);
  return _id_D59CE05D15358F85 - _id_728D033793CEA02F;
}

getstopanims(asmname, statename, _id_79E52A1E39731895, _id_5217DF91F13C7C48) {
  _id_9B9C0392FA49456D = [];
  _id_9B9C0392FA49456D[5] = scripts\asm\asm::asm_lookupdirectionalfootanim(1, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[4] = scripts\asm\asm::asm_lookupdirectionalfootanim(2, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[3] = scripts\asm\asm::asm_lookupdirectionalfootanim(3, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[6] = scripts\asm\asm::asm_lookupdirectionalfootanim(4, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[2] = scripts\asm\asm::asm_lookupdirectionalfootanim(6, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[7] = scripts\asm\asm::asm_lookupdirectionalfootanim(7, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[0] = scripts\asm\asm::asm_lookupdirectionalfootanim(8, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[1] = scripts\asm\asm::asm_lookupdirectionalfootanim(9, asmname, statename, _id_5217DF91F13C7C48);
  _id_9B9C0392FA49456D[8] = _id_9B9C0392FA49456D[0];
  return _id_9B9C0392FA49456D;
}

_id_8936CD52CAA8D8F0(asmname, statename, _id_7F64B8F511005E9D, _id_5217DF91F13C7C48) {
  _id_A85D99494E4741CC = [];
  _id_A85D99494E4741CC["cover_left_arrival"]["7"] = 0.369369;
  _id_A85D99494E4741CC["cover_left_crouch_arrival"]["7"] = 0.321321;
  _id_A85D99494E4741CC["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
  _id_A85D99494E4741CC["cqb_cover_left_arrival"]["7"] = 0.275275;
  _id_A85D99494E4741CC["cover_left_arrival"]["8"] = 0.525526;
  _id_A85D99494E4741CC["cover_left_crouch_arrival"]["8"] = 0.448448;
  _id_A85D99494E4741CC["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
  _id_A85D99494E4741CC["cqb_cover_left_arrival"]["8"] = 0.335335;
  _id_A85D99494E4741CC["cover_right_arrival"]["8"] = 0.472472;
  _id_A85D99494E4741CC["cover_right_crouch_arrival"]["8"] = 0.248248;
  _id_A85D99494E4741CC["cqb_cover_right_arrival"]["8"] = 0.345345;
  _id_A85D99494E4741CC["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
  _id_A85D99494E4741CC["cover_right_arrival"]["9"] = 0.551552;
  _id_A85D99494E4741CC["cover_right_crouch_arrival"]["9"] = 0.2002;
  _id_A85D99494E4741CC["cqb_cover_right_arrival"]["9"] = 0.3003;
  _id_A85D99494E4741CC["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
  return _id_A85D99494E4741CC[statename][_id_7F64B8F511005E9D];
}

_id_56001947D28B30D6(asmname, statename, _id_7F64B8F511005E9D, _id_5217DF91F13C7C48) {
  return undefined;
}

shouldstartarrivalpassthrough(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.approachdir))
    return 0;

  nodetype = undefined;

  if(isDefined(params)) {
    if(!isarray(params))
      nodetype = params;
    else if(params.size < 1)
      nodetype = "Exposed";
    else
      nodetype = params[0];
  } else
    nodetype = "Exposed";

  if(!scripts\asm\shared\utility::isarrivaltype(asmname, statename, _id_F2B19B25D457C2A6, nodetype))
    return 0;

  _id_6B923AD9DA57B2CF = distance(self.origin, self.pathgoalpos);
  _id_1047326B5402E964 = getmaxarrivaldistfornodetype(nodetype);

  if(_id_6B923AD9DA57B2CF > _id_1047326B5402E964)
    return 0;

  _id_5217DF91F13C7C48 = 0;

  if(isDefined(params) && params.size >= 2)
    _id_5217DF91F13C7C48 = 1;

  self.asm.stopdata = calculatestopdata(asmname, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}