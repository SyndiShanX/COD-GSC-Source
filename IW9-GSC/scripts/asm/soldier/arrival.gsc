/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\arrival.gsc
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

  node = scripts\asm\shared\utility::getarrivalnode();

  if(!scripts\asm\asm::asm_eventfired(asmname, "cover_approach"))
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

  _id_6B923AD9DA57B2CF = distance(self.origin, self.pathgoalpos);
  _id_1047326B5402E964 = getmaxarrivaldistfornodetype(nodetype);

  if(_id_6B923AD9DA57B2CF > _id_1047326B5402E964)
    return 0;

  _id_5217DF91F13C7C48 = 0;

  if(isDefined(params) && params.size > 1)
    _id_5217DF91F13C7C48 = int(params[1]);

  _id_457FEB6671ADD6F0 = undefined;
  _id_E5AEFC352A22ACA2 = undefined;
  _id_D2FD6E73FE47FD81 = undefined;

  if(nodetype == "Exposed Moving")
    _id_D2FD6E73FE47FD81 = "code_move";

  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(_id_F7EE87DC76B45E62 == "casual" || _id_F7EE87DC76B45E62 == "casual_gun" || _id_F7EE87DC76B45E62 == "patrol") {
    _id_AE21C8641E5E4F38 = 0.053;

    if(self pathdisttogoal() < 25.0)
      _id_AE21C8641E5E4F38 = 2.0;

    self.asm.stopdata = calculatestopdata(asmname, statename, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48, undefined, _id_457FEB6671ADD6F0, _id_AE21C8641E5E4F38, undefined, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81);
  } else
    self.asm.stopdata = calculatestopdata(asmname, statename, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48, undefined, _id_457FEB6671ADD6F0, undefined, undefined, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81);

  if(!isDefined(self.asm.stopdata))
    return 0;

  return 1;
}

shouldstartcasualarrivalaftercodemove(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "code_move"))
    return 0;

  return shouldstartcasualarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shouldstartcasualarrival(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(params) || _id_F7EE87DC76B45E62 != params[2])
    return 0;

  return shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shouldstartcasualarrivalwithgunaftercodemove(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!scripts\asm\asm::asm_eventfired(asmname, "code_move"))
    return 0;

  return shouldstartcasualarrivalwithgun(asmname, statename, _id_F2B19B25D457C2A6, params);
}

shouldstartcasualarrivalwithgun(asmname, statename, _id_F2B19B25D457C2A6, params) {
  _id_F7EE87DC76B45E62 = scripts\asm\asm::asm_getdemeanor();

  if(!isDefined(params) || _id_F7EE87DC76B45E62 != params[2])
    return 0;

  return shouldstartarrival(asmname, statename, _id_F2B19B25D457C2A6, params);
}

chooseanim_arrival(asmname, statename, params) {
  return self.asm.stopdata;
}

_id_CF21D79464E005D2(node) {
  _id_A004A3812E5B3CAD = node.origin;

  if(scripts\asm\shared\utility::shouldinitiallyattackfromexposed() && self._blackboard._id_4F2C03980416A4A9 != "none" && isDefined(node.type)) {
    switch (node.type) {
      case "Cover Right Crouch":
      case "Cover Right":
        if(self._blackboard._id_4F2C03980416A4A9 == "full_exposed") {
          offset = (-15, -44, 0);
          _id_A004A3812E5B3CAD = _id_A004A3812E5B3CAD + rotatevector(offset, node.angles);
        } else if(self._blackboard._id_4F2C03980416A4A9 == "lean") {
          offset = (-6, -10, 0);
          _id_A004A3812E5B3CAD = _id_A004A3812E5B3CAD + rotatevector(offset, node.angles);
        }

        break;
      case "Cover Left Crouch":
      case "Cover Left":
        if(self._blackboard._id_4F2C03980416A4A9 == "full_exposed") {
          offset = (-15, 44, 0);
          _id_A004A3812E5B3CAD = _id_A004A3812E5B3CAD + rotatevector(offset, node.angles);
        } else if(self._blackboard._id_4F2C03980416A4A9 == "lean") {
          offset = (-6, 10, 0);
          _id_A004A3812E5B3CAD = _id_A004A3812E5B3CAD + rotatevector(offset, node.angles);
        }

        break;
      case "Cover Stand":
      case "Cover Crouch":
        offset = (-8, 0, 0);
        _id_A004A3812E5B3CAD = _id_A004A3812E5B3CAD + rotatevector(offset, node.angles);
        break;
      case "struct":
        break;
      default:
        break;
    }
  }

  return _id_A004A3812E5B3CAD;
}

calculatestopdata(asmname, statename, _id_F2B19B25D457C2A6, nodetype, _id_5217DF91F13C7C48, _id_6164202739D4A0FB, _id_07B0F2A3348AB051, _id_A9D2A260C9698FF4, _id_4795FAF7DAE203D5, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81, _id_C7EEABFB94518B4D) {
  node = scripts\asm\shared\utility::getarrivalnode();
  _id_CD19C4C27C506F73 = undefined;

  if(isDefined(node) && !self btgoalvalid() && isDefined(self.scriptedarrivalent) && self.scriptedarrivalent == node) {
    if(distance2dsquared(self.scriptedarrivalent.origin, self.pathgoalpos) > 4096) {
      if(!isDefined(self.scriptedarrivalent.calculatestopdatawarningtime) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration)
        self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
      else {
        self.scriptedarrivalent delete();
        self.scriptedarrivalent = undefined;
        node = scripts\asm\shared\utility::getarrivalnode();
      }
    }
  }

  goalpos = undefined;

  if(isDefined(node))
    goalpos = _id_CF21D79464E005D2(node);
  else
    goalpos = self.pathgoalpos;

  _id_EC1D2C386A790585 = goalpos - self.origin;
  _id_EC1D2C386A790585 = vectorNormalize((_id_EC1D2C386A790585[0], _id_EC1D2C386A790585[1], 0));

  if(vectordot(_id_EC1D2C386A790585, anglesToForward(self.angles)) < 0.707)
    return undefined;

  if(nodetype == "Custom") {
    _id_F2B19B25D457C2A6 = self._id_A57082FDF62BC898;

    if(isDefined(self._id_33B4C07D1F388776))
      _id_CD19C4C27C506F73 = self._id_33B4C07D1F388776;

    _id_5217DF91F13C7C48 = self._id_171120E99DF3E286;
  }

  if(!isDefined(_id_07B0F2A3348AB051))
    _id_07B0F2A3348AB051 = "";

  _id_33CDE98BEE4C1299 = "";

  if(_id_5217DF91F13C7C48) {
    foot = "left";

    if(scripts\asm\asm::asm_eventfiredrecently(asmname, "pass_left"))
      foot = "left";
    else if(scripts\asm\asm::asm_eventfiredrecently(asmname, "pass_right"))
      foot = "right";
    else if(self.asm.footsteps.foot == "right")
      foot = "right";

    if(isDefined(_id_07B0F2A3348AB051))
      _id_33CDE98BEE4C1299 = _id_07B0F2A3348AB051 + foot;
    else
      _id_33CDE98BEE4C1299 = foot;
  } else
    _id_33CDE98BEE4C1299 = _id_07B0F2A3348AB051;

  _id_EACF2FCF316960A0 = scripts\asm\shared\utility::nodeshouldfaceangles(node);
  yaw = undefined;
  angles = undefined;

  if((nodetype == "Exposed" || nodetype == "Exposed Crouch") && (_id_2B79931B08683E0A::recentlysawenemy() || scripts\asm\shared\utility::shouldinitiallyattackfromexposed())) {
    if(!self bb_shootparamsvalid() && !isDefined(self.smartfacingpos)) {
      if(isDefined(node) && isDefined(node.angles)) {
        yaw = node.angles[1];
        angles = node.angles;
        _id_EACF2FCF316960A0 = 1;
      } else
        _id_EACF2FCF316960A0 = 0;
    } else {
      _id_AD3204B3CAF1CCEA = scripts\asm\soldier\script_funcs::getturndesiredyaw();
      angles = (0, self.angles[1] + _id_AD3204B3CAF1CCEA, 0);
      yaw = angles[1];
      _id_EACF2FCF316960A0 = 1;
    }
  } else if(_id_EACF2FCF316960A0) {
    yaw = scripts\asm\shared\utility::getnodeforwardyaw(node, undefined, 0);
    angles = node.angles;
  }

  result = self actorcalcstopdata(goalpos, angles, getcustomarrivalangles(), _id_6164202739D4A0FB, _id_EACF2FCF316960A0, _id_F2B19B25D457C2A6, yaw, _id_33CDE98BEE4C1299, _id_07B0F2A3348AB051, _id_A9D2A260C9698FF4, _id_4795FAF7DAE203D5, nodetype, _id_E5AEFC352A22ACA2, _id_D2FD6E73FE47FD81, _id_C7EEABFB94518B4D, _id_CD19C4C27C506F73);

  if(isDefined(result) && isDefined(node))
    result._id_E411F4722CF5136A = self._blackboard._id_4F2C03980416A4A9 != "none";

  return result;
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

arrivalterminatewait(statename) {
  self endon("death");
  self.asm.arriving = statename;
  self waittill(statename + "_finished");
  self.asm.arriving = undefined;
}

playanim_arrival_handlestandevent(asmname, statename, xanim, _id_1A08CC6EA0B47949) {
  self endon(statename + "_finished");
  self.asm.arrivalstopfired = 0;
  movedelta = getmovedelta(xanim, 0.0, 1.0);
  _id_EB5B1F36E255152D = getanimlength(xanim);
  _id_E42943E0E63A881E = 0.05 / _id_EB5B1F36E255152D;

  for(currenttime = 1.0 - _id_E42943E0E63A881E; currenttime > 0.0; currenttime = currenttime - _id_E42943E0E63A881E) {
    _id_1665F9F1779462BB = getmovedelta(xanim, 0.0, currenttime);

    if(lengthsquared(movedelta - _id_1665F9F1779462BB) >= 64) {
      break;
    }
  }

  waittime = currenttime * _id_EB5B1F36E255152D / _id_1A08CC6EA0B47949;

  if(waittime > 0)
    wait(waittime);

  self.asm.arrivalstopfired = 1;
}

returnoncorner(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "corner")
    return 1;
}

returnonwarpstart(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "warp_arrival_start")
    return 1;
}

calculateadjustedspeedforshortpath(_id_9743A24AC8368484, pathdist) {
  _id_87E7A006522A7FA3 = 64;
  _id_A0BBB0351FA8EC9D = 110;

  if(pathdist >= _id_87E7A006522A7FA3 && pathdist <= _id_A0BBB0351FA8EC9D) {
    t = (pathdist - _id_87E7A006522A7FA3) / (_id_A0BBB0351FA8EC9D - _id_87E7A006522A7FA3);
    _id_543020482C67892F = self aigettargetspeed();
    return (1 - t) * _id_543020482C67892F + t * _id_9743A24AC8368484;
  }

  return _id_9743A24AC8368484;
}

playanim_arrival(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_C95EA2EC0593AC01 = 1.0;

  if(isDefined(params))
    _id_C95EA2EC0593AC01 = params;

  self.asm.arrivalasmstatename = statename;
  self.a.arrivalasmstatename = statename;
  thread arrivalterminatewait(statename);
  stopdata = scripts\asm\asm::asm_getanim(asmname, statename);

  if(!isDefined(stopdata)) {
    self orientmode("face motion");
    scripts\asm\asm::asm_fireevent(asmname, "abort", undefined);
    return;
  }

  self orientmode("face angle", self.angles[1]);
  _id_B84971510AAF7CD3 = stopdata.finalangles;
  angleindex = stopdata.angleindex;
  _id_29A16A52B186224E = (0, _id_B84971510AAF7CD3[1] - stopdata.angledelta, 0);
  _id_55644D08241B1A7B = stopdata.startpos;
  _id_F78BC5CDE11694FC = _id_29A16A52B186224E[1];

  if(isDefined(stopdata.parentpos) && isDefined(stopdata.parentangles)) {
    _id_28A7E625F06DF292 = stopdata.startpos - stopdata.parentpos;
    _id_28A7E625F06DF292 = rotatevectorinverted(_id_28A7E625F06DF292, stopdata.parentangles);
    _id_057C35D8B31B4FEC = invertangles(stopdata.parentangles);
    localangles = combineangles(_id_29A16A52B186224E, _id_057C35D8B31B4FEC);
    _id_539C2DCC0A467746 = self getnavspaceent();
    _id_28A7E625F06DF292 = rotatevector(_id_28A7E625F06DF292, _id_539C2DCC0A467746.angles);
    _id_55644D08241B1A7B = _id_28A7E625F06DF292 + _id_539C2DCC0A467746.origin;
    _id_B98CF035C97EDEE9 = combineangles(localangles, _id_539C2DCC0A467746.angles);
    _id_F78BC5CDE11694FC = _id_B98CF035C97EDEE9[1];
  }

  _id_55D057B8B7B5CD20 = statename;

  if(isDefined(self._id_A57082FDF62BC898))
    _id_55D057B8B7B5CD20 = self._id_A57082FDF62BC898;

  stopanim = stopdata.stopanim;

  if(isDefined(self.asm.customdata) && isDefined(self._id_33B4C07D1F388776))
    self setoverridearchetype("animscript", self._id_33B4C07D1F388776, 1);

  _id_757FE3A9E3297942 = scripts\asm\asm::asm_getxanim(_id_55D057B8B7B5CD20, stopanim);
  _id_AC1089FC2C260DCB = scripts\asm\shared\utility::getarrivalnode();

  if(isDefined(stopdata.customtargetpos))
    goalpos = stopdata.customtargetpos;
  else {
    if(isDefined(_id_AC1089FC2C260DCB))
      goalpos = _id_CF21D79464E005D2(_id_AC1089FC2C260DCB);
    else
      goalpos = self.pathgoalpos;

    self._blackboard._id_9F2E830204CCE981 = istrue(stopdata._id_E411F4722CF5136A);
  }

  if(!istrue(stopdata.bskipstartcoverarrival))
    self startcoverarrival();

  if(animhasnotetrack(_id_757FE3A9E3297942, "code_move")) {
    self animmode("zonly_physics", 0);
    _id_07B60BC0EAB3FD1E = scripts\engine\utility::motionwarpwithnotetracks(_id_757FE3A9E3297942, goalpos, stopdata.finalangles, undefined, "corner", undefined);
    self aisetanim(_id_55D057B8B7B5CD20, stopanim, _id_07B60BC0EAB3FD1E);
    scripts\asm\asm::asm_donotetracks(asmname, statename, ::returnoncorner, undefined, _id_55D057B8B7B5CD20);
    self aisetanim(_id_55D057B8B7B5CD20, stopanim, 1);
    scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, _id_55D057B8B7B5CD20);
    return;
  }

  if(isDefined(self._id_18EB79D0DEEB3B75)) {
    _id_D060059807A71FA6 = self._id_18EB79D0DEEB3B75;
    self animmode(_id_D060059807A71FA6);
  } else
    self animmode("zonly_physics", 0);

  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_757FE3A9E3297942);
  _id_246FBEE6AB76BBC3 = 1.0;

  if(isDefined(goalpos)) {
    _id_EB1C18BB49D8770C = length(stopdata.movedelta);
    _id_29074E84B454250F = length(self.origin - goalpos);

    if(_id_29074E84B454250F > 1.0)
      _id_246FBEE6AB76BBC3 = _id_EB1C18BB49D8770C / length(self.origin - goalpos);

    _id_246FBEE6AB76BBC3 = clamp(_id_246FBEE6AB76BBC3, 0.8, 1.3);
  }

  _id_1A08CC6EA0B47949 = _id_C95EA2EC0593AC01 * _id_246FBEE6AB76BBC3;

  if(isDefined(self.asm.arrivalspeed))
    _id_1A08CC6EA0B47949 = _id_1A08CC6EA0B47949 * self.asm.arrivalspeed;

  if(isDefined(self.arrivalspeedtarget) && isDefined(self.arrivaldesiredspeed) && scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    _id_1A08CC6EA0B47949 = self.arrivaldesiredspeed / self.arrivalspeedtarget;
    self.arrivaldesiredspeed = undefined;
    _id_42D8CE9773183805 = 0.8;
    _id_1A08CC6EA0B47949 = max(_id_42D8CE9773183805, _id_1A08CC6EA0B47949);
  }

  thread playanim_arrival_handlestandevent(asmname, statename, _id_757FE3A9E3297942, _id_1A08CC6EA0B47949);
  self aisetanim(_id_55D057B8B7B5CD20, stopanim, _id_1A08CC6EA0B47949);
  end_time = 1.0;

  if(animhasnotetrack(_id_757FE3A9E3297942, "warp_arrival_start")) {
    _id_B9460E0CB9B449A3 = getnotetracktimes(_id_757FE3A9E3297942, "warp_arrival_start");
    endnote = getnotetracktimes(_id_757FE3A9E3297942, "warp_arrival_end");

    if(_id_B9460E0CB9B449A3[0] > 0.0)
      scripts\asm\asm::asm_donotetracks(asmname, statename, ::returnonwarpstart, undefined, _id_55D057B8B7B5CD20, 0);

    animlength = getanimlength(_id_757FE3A9E3297942);
    _id_219923344CDB8748 = _id_B9460E0CB9B449A3[0];

    if(_id_219923344CDB8748 > 0) {
      _id_219923344CDB8748 = _id_B9460E0CB9B449A3[0] * animlength * 1000;
      _id_219923344CDB8748 = _id_219923344CDB8748 - scripts\engine\utility::mod(int(_id_219923344CDB8748), level.frameduration);
      _id_219923344CDB8748 = _id_219923344CDB8748 / animlength / 1000;
    }

    end_time = endnote[0];
    duration = int((end_time - _id_219923344CDB8748) * animlength / _id_1A08CC6EA0B47949 * 1000.0);
    duration = duration + (level.frameduration - scripts\engine\utility::mod(duration, level.frameduration));
    scripts\engine\utility::motionwarpwithtimes(_id_757FE3A9E3297942, goalpos, stopdata.finalangles, _id_219923344CDB8748, 1.0, duration, 0);
  } else {
    _id_6040E7EBA5E09557 = 500;

    if(animhasnotetrack(_id_757FE3A9E3297942, "start_aim")) {
      end_time = getnotetracktimes(_id_757FE3A9E3297942, "start_aim")[0];
      _id_228C1F2F3A2D92F1 = getanimlength(_id_757FE3A9E3297942);
      _id_6040E7EBA5E09557 = int(end_time * _id_228C1F2F3A2D92F1 / _id_1A08CC6EA0B47949 * 1000);

      if(_id_6040E7EBA5E09557 < 300 && _id_228C1F2F3A2D92F1 / _id_1A08CC6EA0B47949 >= 0.15)
        _id_6040E7EBA5E09557 = 300;
    }

    self motionwarpwithanim(_id_55644D08241B1A7B, _id_29A16A52B186224E, goalpos, stopdata.finalangles, _id_6040E7EBA5E09557);
  }

  if(!isagent(self)) {
    anime = scripts\asm\asm::asm_lookupanimfromaliasifexists(statename, "conceal_add");

    if(isDefined(anime) && isDefined(_id_AC1089FC2C260DCB) && isDefined(_id_AC1089FC2C260DCB.type) && (_id_AC1089FC2C260DCB.type == "Conceal Crouch" || _id_AC1089FC2C260DCB.type == "Conceal Stand")) {
      _id_7774FA3B6C5D179C = scripts\asm\asm::asm_getxanim(statename, anime);
      animlength = getanimlength(_id_757FE3A9E3297942);
      _id_5EA036AF2C7394CB = animlength * end_time * 0.3;
      thread scripts\asm\soldier\cover::start_conceal_add(statename, _id_7774FA3B6C5D179C, _id_5EA036AF2C7394CB);
    }
  }

  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename), undefined, _id_55D057B8B7B5CD20);
  self.a.movement = "stop";
}

getcustomarrivalangles() {
  if(isDefined(self._id_0A41EDF45BB0FF97))
    return self._id_0A41EDF45BB0FF97;

  return undefined;
}

getstopanims(asmname, statename, _id_79E52A1E39731895, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051) {
  _id_9B9C0392FA49456D = [];
  _id_9B9C0392FA49456D[5] = scripts\asm\asm::asm_lookupdirectionalfootanim(1, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[4] = scripts\asm\asm::asm_lookupdirectionalfootanim(2, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[3] = scripts\asm\asm::asm_lookupdirectionalfootanim(3, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[6] = scripts\asm\asm::asm_lookupdirectionalfootanim(4, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[2] = scripts\asm\asm::asm_lookupdirectionalfootanim(6, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[7] = scripts\asm\asm::asm_lookupdirectionalfootanim(7, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[0] = scripts\asm\asm::asm_lookupdirectionalfootanim(8, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[1] = scripts\asm\asm::asm_lookupdirectionalfootanim(9, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051);
  _id_9B9C0392FA49456D[8] = _id_9B9C0392FA49456D[0];
  return _id_9B9C0392FA49456D;
}

shouldstartarrivalpassthrough(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 0;
}