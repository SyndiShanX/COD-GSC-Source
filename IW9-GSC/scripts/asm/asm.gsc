/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm.gsc
***********************************************/

_id_C051A94F99BD65F1(asmname) {
  asmregistergenerichandler(asmname, ::asm_generichandler);
  self asminstantiate(asmname);
  self.asmasset = undefined;
  self.animationarchetype = undefined;
}

asm_getfunction(asmname, _id_CC4F2E0388379546) {
  return anim.asmfuncs[asmname][_id_CC4F2E0388379546];
}

asm_getgenerichandler() {
  return::asm_generichandler;
}

asm_getparams(asmname, _id_A2AC82F1D03FCC0A) {
  return anim.asmparams[asmname][_id_A2AC82F1D03FCC0A];
}

asm_setupaim(asmname, statename, _id_D180B535A33B044D, _id_7D7E52A729D0B9B0) {
  if(isDefined(self.fnasm_setupaim))
    self[[self.fnasm_setupaim]](asmname, statename, _id_D180B535A33B044D, _id_7D7E52A729D0B9B0);
}

asm_settransitionorientmode(_id_6C1C5F905D32F13A) {
  if(!isai(self)) {
    return;
  }
  switch (_id_6C1C5F905D32F13A) {
    case "face node":
      _id_8E1451B5845405B1 = 1024.0;

      if(scripts\engine\utility::actor_is3d()) {
        _id_5E1CF0A9046F6F99 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < _id_8E1451B5845405B1)
          _id_5E1CF0A9046F6F99 = self _meth_0F134F30C17FAEAF(self.node);

        self orientmode("face angle 3d", _id_5E1CF0A9046F6F99);
      } else {
        yaw = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < _id_8E1451B5845405B1)
          yaw = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

        self orientmode("face angle", yaw);
      }

      break;
    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;
    default:
      self orientmode(_id_6C1C5F905D32F13A);
      break;
  }
}

asm_settransitionanimmode(_id_D060059807A71FA6) {
  if(isDefined(self.fnasm_setanimmode)) {
    self[[self.fnasm_setanimmode]](_id_D060059807A71FA6);
    return;
  }

  self animmode(_id_D060059807A71FA6, 0);
}

asm_generichandler(_id_2264872EE8A7D354, asmname, param1, param2, param3) {
  switch (_id_2264872EE8A7D354) {
    case "setupaim":
      asm_setupaim(asmname, param1, 0.2, undefined);
      break;
    case "note":
      _id_8AC9186B53B0E4F2 = asm_getnotehandler(asmname, undefined);
      val = [[self.fnasm_handlenotetrack]](param2, param1, _id_8AC9186B53B0E4F2, undefined);

      if(!isDefined(val))
        val = asm_handlenewnotetracks(asmname, param2, param1);

      if(isDefined(val) && !asm_eventfired(asmname, "end"))
        asm_fireevent(asmname, "end");

      break;
    default:
      break;
  }
}

asm_setoverrideparams(asmname, params) {
  _id_C237ADAA8F06B26B = 9999;
  anim.asmparams[asmname][_id_C237ADAA8F06B26B] = params;
  return _id_C237ADAA8F06B26B;
}

asm_globalinit() {
  if(isDefined(anim.asm)) {
    return;
  }
  anim.asm = [];
}

asm_fireephemeralevent(_id_550AD7FDD85835EE, eventname, params) {
  self asmfireephemeralevent(_id_550AD7FDD85835EE, eventname, params);
}

asm_init_blackboard() {
  if(isDefined(self._blackboard)) {
    return;
  }
  self._blackboard = self getaiblackboard();
  self._blackboard.asm_events = [];
  self._blackboard.bfire = 0;
}

asm_clearevents(_id_550AD7FDD85835EE) {
  if(isDefined(self._blackboard.asm_events[_id_550AD7FDD85835EE]))
    self._blackboard.asm_events[_id_550AD7FDD85835EE] = undefined;
}

asm_terminateandreplace(_id_F48B8938602F359B, _id_0388552599BFCB74) {
  self asmterminate();
  self clearaiblackboard();
  self._blackboard = undefined;
  self notify("asm_terminated");
  self._id_A709FBD9FEA148F6 = undefined;

  if(!isDefined(_id_0388552599BFCB74))
    _id_0388552599BFCB74 = self._id_AE3EA15396B65C1F;

  _id_2A6DBA1CF4FB4026 = tolower(_id_F48B8938602F359B);
  asm_init_blackboard();
  self[[self.fnasm_init]](_id_2A6DBA1CF4FB4026, _id_0388552599BFCB74);
  self._id_A942DD31D55102C9 = _id_2A6DBA1CF4FB4026;
}

asm_getnotehandler(asmname, statename) {
  _id_70B5FD7365F6B50C = self asmgetnotehandler(asmname);

  if(_id_70B5FD7365F6B50C != -1)
    return anim.asmfuncs[asmname][_id_70B5FD7365F6B50C];

  return undefined;
}

asm_currentstatehasflag(asmname, flagname) {
  if(istrue(self._id_15B9736AE2DDE804))
    return 1;

  return self asmcurrentstatehasflag(asmname, flagname);
}

asm_fireevent_internal(asmname, eventname, params) {
  self asmfireevent(asmname, eventname, params);
}

asm_fireevent(asmname, eventname, params) {
  asm_fireevent_internal(asmname, eventname, params);

  if(eventname == "anim_will_finish" || eventname == "finish") {
    eventname = "end";
    asm_fireevent_internal(asmname, eventname);
  }
}

asm_addephemeraleventtowatchlist(_id_550AD7FDD85835EE, eventname) {}

asm_ephemeraleventfired(_id_550AD7FDD85835EE, eventname, _id_00BD6B21F67400A4) {
  _id_D6AD4E2C0E339A1B = self asmephemeraleventfired(_id_550AD7FDD85835EE, eventname);

  if(_id_D6AD4E2C0E339A1B)
    return 1;

  return 0;
}

asm_eventfiredrecently(asmname, eventname) {
  return self asmeventfiredwithin(asmname, eventname, 50);
}

asm_geteventtime(asmname, eventname) {
  return self asmgeteventtime(asmname, eventname);
}

asm_geteventdata(asmname, eventname) {
  return self asmgeteventdata(asmname, eventname);
}

asm_getephemeraleventdata(_id_550AD7FDD85835EE, eventname) {
  return self asmgetephemeraleventdata(_id_550AD7FDD85835EE, eventname);
}

asm_clearallephemeralevents() {
  self asmclearephemeralevents();
}

asm_shouldpowerdown(asmname, currentstate) {
  if(!isDefined(self.bpowerdown) || !self.bpowerdown)
    return 0;

  if(isDefined(self.asm.bpowereddown) && self.asm.bpowereddown)
    return 0;

  if(!isalive(self))
    return 0;

  if(scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  if(isDefined(self._blackboard.btraversing))
    return 0;

  if(self._id_A97AC004F00C5DF9)
    return 0;

  return 1;
}

asm_eventfired(asmname, eventname) {
  return self asmeventfired(asmname, eventname);
}

asm_checktransitions(asmname, currentstatename, _id_7BB056E0E335A770) {
  self asmtick(1);
}

asm_setstate(_id_F2B19B25D457C2A6, params) {
  if(self asmhasstate(self.asmname, _id_F2B19B25D457C2A6))
    self asmsetstate(self.asmname, _id_F2B19B25D457C2A6, params);
}

_id_AC90FA5CC0A80298(_id_53709E15B972FF84, params) {
  current = self asmgetcurrentstate(self.asmname);

  if(current != _id_53709E15B972FF84)
    self asmsetstate(self.asmname, _id_53709E15B972FF84);
}

asm_tick() {}

highestallowedstance(asmname, statename, _id_F2B19B25D457C2A6, stance) {
  highestallowedstance = scripts\asm\shared\utility::gethighestallowedstance();

  if(isDefined(highestallowedstance) && highestallowedstance != stance)
    return 0;

  return 1;
}

asm_getdemeanor() {
  return self._blackboard.movetype;
}

asm_updatefrantic() {}

asm_isfrantic() {
  return 0;
}

asm_iscrawlmelee() {
  return isDefined(self.asm.crawlmelee);
}

asm_setcrawlmelee(val) {
  self.asm.crawlmelee = val;
}

asm_setdemeanoranimoverride(_id_F7EE87DC76B45E62, override, anime) {
  self.asm.animoverrides[_id_F7EE87DC76B45E62][override] = anime;
}

asm_cleardemeanoranimoverride(_id_F7EE87DC76B45E62, override) {
  if(asm_hasdemeanoranimoverride(_id_F7EE87DC76B45E62, override))
    self.asm.animoverrides[_id_F7EE87DC76B45E62][override] = undefined;
}

asm_hasdemeanoranimoverride(_id_F7EE87DC76B45E62, override) {
  return isDefined(self.asm.animoverrides[_id_F7EE87DC76B45E62]) && isDefined(self.asm.animoverrides[_id_F7EE87DC76B45E62][override]);
}

asm_getdemeanoranimoverride(_id_F7EE87DC76B45E62, override) {
  return self.asm.animoverrides[_id_F7EE87DC76B45E62][override];
}

asm_getcurrentstate(asmname) {
  return self asmgetcurrentstate(asmname);
}

asm_hasalias(statename, alias) {
  _id_38548703EA2BDADC = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, asm_isfrantic());
  return isDefined(_id_0EABF81B5BE8DDB5);
}

asm_getanim(asmname, statename, params) {
  if(isarray(params)) {
    if(params.size == 1)
      return self asmgetanim(asmname, statename, params[0]);
    else if(params.size == 2)
      return self asmgetanim(asmname, statename, params[0], params[1]);
    else if(params.size == 3)
      return self asmgetanim(asmname, statename, params[0], params[1], params[2]);
    else {}
  } else
    return self asmgetanim(asmname, statename, params);
}

asm_getrandomanim(asmname, statename) {
  _id_0B6648A33085E43A = asm_getrandomalias(statename);
  return asm_lookupanimfromalias(statename, _id_0B6648A33085E43A);
}

asm_getrandomalias(statename) {
  aliases = archetypegetaliases(self._id_AE3EA15396B65C1F, statename);
  return aliases[randomint(aliases.size)];
}

_id_0C1BF21C5E8625EA(statename, alias) {
  _id_38548703EA2BDADC = self.basearchetype;
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias);
  return _id_0EABF81B5BE8DDB5;
}

asm_lookupanimfromaliasifexists(statename, alias) {
  _id_38548703EA2BDADC = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, asm_isfrantic());
  return _id_0EABF81B5BE8DDB5;
}

_id_62D0BB5A77D09499(statename, alias) {
  _id_38548703EA2BDADC = self.basearchetype;
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, 0);
  return _id_0EABF81B5BE8DDB5;
}

asm_lookupanimfromalias(statename, alias) {
  _id_38548703EA2BDADC = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_38548703EA2BDADC, statename, alias, asm_isfrantic());
  return _id_0EABF81B5BE8DDB5;
}

asm_getallanimsforstate(statename) {
  _id_8B461A03A1F82E9F = self._id_AE3EA15396B65C1F;
  aliases = archetypegetaliases(_id_8B461A03A1F82E9F, statename);
  anims = [];

  foreach(alias in aliases) {
    _id_5EC185BB9E766D14 = archetypegetalias(_id_8B461A03A1F82E9F, statename, alias, 0);

    if(isarray(_id_5EC185BB9E766D14.anims)) {
      anims = scripts\engine\utility::array_combine(anims, _id_5EC185BB9E766D14.anims);
      continue;
    }

    anims[anims.size] = _id_5EC185BB9E766D14.anims;
  }

  return anims;
}

asm_getallanimsforalias(archetype, statename, alias) {
  _id_3A8E690B2371C6D2 = archetypegetalias(archetype, statename, alias, 1);

  if(!isDefined(_id_3A8E690B2371C6D2))
    return undefined;

  _id_64C0E1B7D8039263 = _id_3A8E690B2371C6D2.anims;

  if(!isarray(_id_64C0E1B7D8039263))
    _id_64C0E1B7D8039263 = [_id_64C0E1B7D8039263];

  return _id_64C0E1B7D8039263;
}

asm_getallanimindicesforalias(statename, alias) {
  return animsetgetallanimindicesforalias(self._id_AE3EA15396B65C1F, statename, alias);
}

asm_playanimstate(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, _id_2C8936D08F85C5C1));
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

  if(endnote == "code_move")
    endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

_id_074A66DE812856BA(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_ABE93F4471A03711 = float(params);
  thread asm_playanimstate(asmname, statename, params);
  wait(_id_ABE93F4471A03711);
  asm_fireevent(asmname, "end");
}

asm_hasknobs() {
  if(isagent(self) && !istrue(self.bsoldier) && self.unittype != "civilian")
    return 0;

  return 1;
}

_id_FB56C9527636713F(asmname, statename, _id_C08B84490B532FB2, _id_9177DF4FA6F67675) {
  self endon(statename + "_finished");

  if(!isDefined(_id_C08B84490B532FB2))
    _id_C08B84490B532FB2 = 1;

  if(asm_hasknobs()) {
    _id_D5C987658103BFFD = asm_getbodyknob();

    if(isDefined(_id_9177DF4FA6F67675) && _id_9177DF4FA6F67675) {
      _id_97CA3D05716B420D = asm_lookupanimfromaliasifexists("knobs", "move");

      if(isDefined(_id_97CA3D05716B420D)) {
        _id_BF3DE88B0E06A07C = asm_getxanim("knobs", _id_97CA3D05716B420D);
        self setmoveanimknob(_id_BF3DE88B0E06A07C);
      }
    }
  }

  _id_3931FF7E891D898F = asm_getnotehandler(asmname, statename);
  _id_CD743003D3F4F0CA = 0.2;
  _id_51E5AF01D440606D = isDefined(_id_9177DF4FA6F67675) && _id_9177DF4FA6F67675;
  _id_CF42338E505695C0 = 1;

  for(;;) {
    loopanim = asm_getanim(asmname, statename);
    _id_76C92379ED351610 = asm_getxanim(statename, loopanim);

    if(isDefined(_id_9177DF4FA6F67675) && _id_9177DF4FA6F67675) {
      _id_C08B84490B532FB2 = asm_getmoveplaybackrate();
      self codemoveanimrate(_id_C08B84490B532FB2);
    }

    if(!_id_51E5AF01D440606D)
      _id_CF42338E505695C0 = self aigetanimweight(_id_76C92379ED351610) == 0;

    if(isnumber(loopanim))
      self aisetanim(statename, loopanim, _id_C08B84490B532FB2);
    else {
      _id_0C8AAF5BC74C22BB = asm_lookupanimfromalias(statename, "blank");
      self aisetanim(statename, _id_0C8AAF5BC74C22BB);

      if(_id_CF42338E505695C0)
        self setflaggedanimrestart(statename, loopanim, 1, 0.2, _id_C08B84490B532FB2);
      else
        self setflaggedanim(statename, loopanim, 1, 0.2, _id_C08B84490B532FB2);
    }

    if(_id_51E5AF01D440606D)
      _id_CF42338E505695C0 = 0;

    asm_playfacialanim(asmname, statename, _id_76C92379ED351610);
    _id_EB5B1F36E255152D = getanimlength(_id_76C92379ED351610);

    if(_id_EB5B1F36E255152D <= 0.05) {
      return;
    }
    _id_80B5B8A637E870DD = undefined;
    _id_136F34DAF1A3C277 = _id_C08B84490B532FB2;

    while(!isDefined(_id_80B5B8A637E870DD)) {
      _id_80B5B8A637E870DD = asm_donotetrackswithtimeout(asmname, statename, _id_CD743003D3F4F0CA, _id_3931FF7E891D898F);

      if(!isDefined(_id_80B5B8A637E870DD) && _id_51E5AF01D440606D) {
        _id_C08B84490B532FB2 = asm_getmoveplaybackrate();

        if(_id_C08B84490B532FB2 != _id_136F34DAF1A3C277) {
          self codemoveanimrate(_id_C08B84490B532FB2);

          if(isnumber(loopanim)) {
            self aisetanimrate(statename, loopanim, _id_C08B84490B532FB2);
            continue;
          }

          self setanimrate(_id_76C92379ED351610, _id_C08B84490B532FB2);
        }
      }
    }
  }
}

asm_lookupdirectionalfootanim(_id_603E405C2854EE22, asmname, statename, _id_5217DF91F13C7C48, _id_07B0F2A3348AB051) {
  _id_DEC9BCCE93873125 = "";

  if(isDefined(_id_07B0F2A3348AB051))
    _id_DEC9BCCE93873125 = _id_07B0F2A3348AB051;

  if(_id_5217DF91F13C7C48) {
    if(asm_eventfiredrecently(asmname, "pass_left"))
      _id_33CDE98BEE4C1299 = _id_DEC9BCCE93873125 + "left";
    else if(asm_eventfiredrecently(asmname, "pass_right"))
      _id_33CDE98BEE4C1299 = _id_DEC9BCCE93873125 + "right";
    else if(self.asm.footsteps.foot == "right")
      _id_33CDE98BEE4C1299 = _id_DEC9BCCE93873125 + "right";
    else
      _id_33CDE98BEE4C1299 = _id_DEC9BCCE93873125 + "left";
  } else
    _id_33CDE98BEE4C1299 = _id_DEC9BCCE93873125;

  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists(statename, _id_33CDE98BEE4C1299 + _id_603E405C2854EE22);

  if(isDefined(_id_2C8936D08F85C5C1))
    return _id_2C8936D08F85C5C1;

  if(_id_DEC9BCCE93873125 != _id_33CDE98BEE4C1299) {
    _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists(statename, _id_DEC9BCCE93873125 + _id_603E405C2854EE22);

    if(isDefined(_id_2C8936D08F85C5C1))
      return _id_2C8936D08F85C5C1;
  }

  return undefined;
}

asm_setmoveplaybackrate(rate) {
  self.moveplaybackrate = rate;
}

asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

asm_getcurrentstatename(asmname) {
  return self asmgetcurrentstate(asmname);
}

asm_dosinglenotetrack(asmname, statename, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978, _id_FA1AD2AA0B55766F) {
  flagname = statename;

  if(isDefined(_id_FA1AD2AA0B55766F))
    flagname = _id_FA1AD2AA0B55766F;

  self waittill(flagname, notes);

  if(!isDefined(notes))
    notes = ["undefined"];

  if(!isarray(notes))
    notes = [notes];

  _id_FC9A12FE1F57542A = undefined;

  foreach(_id_A234A65C378F3289 in notes) {
    asm_fireevent(asmname, _id_A234A65C378F3289);
    val = [[self.fnasm_handlenotetrack]](_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);

    if(!isDefined(val))
      val = asm_handlenewnotetracks(asmname, _id_A234A65C378F3289, statename);

    if(isDefined(val))
      _id_FC9A12FE1F57542A = val;
  }

  return _id_FC9A12FE1F57542A;
}

asm_handlenewnotetracks(asmname, _id_A234A65C378F3289, statename) {
  if(asm_tryhandledeathstatechangenotetrack(_id_A234A65C378F3289)) {
    return;
  }
  switch (_id_A234A65C378F3289) {
    case "start_aim":
      if(asm_currentstatehasflag(asmname, "notetrackAim"))
        asm_setupaim(asmname, statename, 0.2);

      break;
    case "tag_eye_on":
      self._id_5E9EF980DDC3F18E = 1;
      break;
    case "tag_eye_off":
      self._id_5E9EF980DDC3F18E = 0;
      break;
  }
}

asm_tryhandledeathstatechangenotetrack(notetrack) {
  if(!scripts\engine\utility::string_starts_with(notetrack, "ds "))
    return 0;

  _id_A2D54B92B23FA8BF = 3;
  self.asm.deathstateoverride = spawnStruct();
  _id_A2D54B92B23FA8BF = _id_A2D54B92B23FA8BF + 1;

  for(deathstate = ""; _id_A2D54B92B23FA8BF < notetrack.size && notetrack[_id_A2D54B92B23FA8BF] != "]"; _id_A2D54B92B23FA8BF = _id_A2D54B92B23FA8BF + 1)
    deathstate = deathstate + notetrack[_id_A2D54B92B23FA8BF];

  self.asm.deathstateoverride.statename = deathstate;
  _id_A2D54B92B23FA8BF = _id_A2D54B92B23FA8BF + 1;

  if(_id_A2D54B92B23FA8BF < notetrack.size) {
    _id_A2D54B92B23FA8BF = _id_A2D54B92B23FA8BF + 2;

    for(params = ""; _id_A2D54B92B23FA8BF < notetrack.size && notetrack[_id_A2D54B92B23FA8BF] != "]"; _id_A2D54B92B23FA8BF = _id_A2D54B92B23FA8BF + 1)
      params = params + notetrack[_id_A2D54B92B23FA8BF];

    self.asm.deathstateoverride.params = params;
  }

  return 1;
}

asm_donotetracksfortime(asmname, statename, time, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  _id_24A91F52DE25EB75 = statename + "_timeout";
  self endon(_id_24A91F52DE25EB75);
  childthread asm_donotetracksfortime_helper(_id_24A91F52DE25EB75, time);

  for(;;)
    asm_dosinglenotetrack(asmname, statename, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
}

asm_donotetrackswithtimeout_helper(endonstring, notifystring, timeout) {
  self endon(endonstring);
  wait(timeout);
  self notify(notifystring);
}

asm_donotetrackswithtimeout(asmname, statename, timeout, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  _id_24A91F52DE25EB75 = statename + "_timeout";
  _id_7386724C9BD1D65C = statename + "_endHelper";
  self endon(_id_24A91F52DE25EB75);
  childthread asm_donotetrackswithtimeout_helper(_id_7386724C9BD1D65C, _id_24A91F52DE25EB75, timeout);
  _id_EAABF9463637080F = asm_donotetracks(asmname, statename, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
  self notify(_id_7386724C9BD1D65C);
  return _id_EAABF9463637080F;
}

asm_donotetracks(asmname, statename, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978, _id_FA1AD2AA0B55766F, _id_5C0D1CBFC351F2E1) {
  if(!isDefined(_id_5C0D1CBFC351F2E1))
    _id_5C0D1CBFC351F2E1 = 1;

  for(;;) {
    val = asm_dosinglenotetrack(asmname, statename, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978, _id_FA1AD2AA0B55766F);

    if(isDefined(val)) {
      if(_id_5C0D1CBFC351F2E1 && !asm_eventfired(asmname, "end"))
        asm_fireevent(asmname, "end");

      return val;
    }
  }
}

asm_donotetrackswithinterceptor(asmname, statename, _id_7666CC37A119DF55, _id_314A4FBCE09143E7, _id_FA1AD2AA0B55766F) {
  flagname = statename;

  if(isDefined(_id_FA1AD2AA0B55766F))
    flagname = _id_FA1AD2AA0B55766F;

  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    _id_FC9A12FE1F57542A = undefined;

    foreach(_id_A234A65C378F3289 in notes) {
      asm_fireevent(asmname, _id_A234A65C378F3289);
      _id_B9F20576BF9231C8 = [[_id_7666CC37A119DF55]](statename, _id_A234A65C378F3289, _id_314A4FBCE09143E7);

      if(isDefined(_id_B9F20576BF9231C8) && _id_B9F20576BF9231C8) {
        continue;
      }
      val = [[self.fnasm_handlenotetrack]](_id_A234A65C378F3289, statename, undefined, undefined);

      if(!isDefined(val))
        val = asm_handlenewnotetracks(asmname, _id_A234A65C378F3289, statename);

      if(isDefined(val))
        _id_FC9A12FE1F57542A = val;
    }

    if(isDefined(_id_FC9A12FE1F57542A))
      return _id_FC9A12FE1F57542A;
  }
}

asm_donotetrackssingleloop(asmname, statename, xanim, _id_ED9FB5D37A4C823E) {
  notifyname = statename + "_note_loop_end";
  self endon(notifyname);
  length = getanimlength(xanim);
  thread asm_donotetrackssingleloop_waiter(notifyname, statename + "_finished", length);
  asm_donotetracks(asmname, statename, _id_ED9FB5D37A4C823E);
  self notify(notifyname);
}

asm_donotetrackssingleloop_waiter(notifyname, _id_CB57658B734D4B0C, time) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(notifyname);
  self endon(_id_CB57658B734D4B0C);
  wait(time);
  self notify(notifyname);
}

asm_donotetracksfortime_helper(notifystring, time) {
  wait(time);
  self notify(notifystring);
}

asm_waitforaimnotetrack(asmname, statename, _id_D180B535A33B044D) {
  self endon(statename + "_finished");
  _id_3CBA51F785093D95 = 0;

  while(!_id_3CBA51F785093D95) {
    self waittill(statename, notes);

    if(!isarray(notes))
      notes = [notes];

    foreach(_id_A234A65C378F3289 in notes) {
      if(_id_A234A65C378F3289 == "start_aim") {
        asm_setupaim(asmname, statename, _id_D180B535A33B044D);
        _id_3CBA51F785093D95 = 1;
        break;
      }
    }
  }
}

asm_lookuprandomalias(statename, _id_07B0F2A3348AB051, _id_D0D422E79C49095C) {
  archetype = self._id_AE3EA15396B65C1F;
  aliases = archetypegetaliases(archetype, statename);
  _id_9449EB175477A20E = 0.0;
  chosen = undefined;
  _id_89ADD265E84914CC = -1;

  if(isDefined(_id_07B0F2A3348AB051))
    _id_89ADD265E84914CC = _id_07B0F2A3348AB051.size;

  if(!isDefined(aliases))
    return undefined;

  foreach(aliasname in aliases) {
    if(_id_89ADD265E84914CC < 0 || getsubstr(aliasname, 0, _id_89ADD265E84914CC) == _id_07B0F2A3348AB051) {
      _id_9449EB175477A20E = _id_9449EB175477A20E + 1.0;
      _id_302E82DA1A1989AD = 1.0 / _id_9449EB175477A20E;

      if(randomfloat(1.0) <= _id_302E82DA1A1989AD)
        chosen = aliasname;
    }
  }

  return chosen;
}

asm_chooseanim(asmname, statename, params) {
  if(!isDefined(params)) {
    _id_0B6648A33085E43A = asm_lookuprandomalias(statename);
    return asm_lookupanimfromalias(statename, _id_0B6648A33085E43A);
  } else {
    result = undefined;
    _id_457FEB6671ADD6F0 = scripts\asm\asm_bb::bb_getprefixstring(params);

    if(isDefined(_id_457FEB6671ADD6F0)) {
      _id_0B6648A33085E43A = asm_lookuprandomalias(statename, _id_457FEB6671ADD6F0);
      result = asm_lookupanimfromalias(statename, _id_0B6648A33085E43A);
    } else
      result = asm_lookupanimfromalias(statename, params);

    return result;
  }
}

asm_clearfacialanim() {
  if(self.facialstate != "filler") {
    if(isai(self))
      self setfacialindex("none");
    else if(isDefined(self._id_5247D15DA29E8539)) {
      _id_7C2E7606FE2F4B3D = asm_lookupanimfromalias("knobs", "head_fakeactor");
      self clearanim(asm_getxanim("knobs", _id_7C2E7606FE2F4B3D), 0.2);
    } else
      scripts\asm\shared\utility::setfacialindexfornonai("none");
  }
}

asm_restorefacialanim() {
  asmname = self.asmname;
  statename = self asmgetcurrentstate(asmname);

  if(statename == "animscripted" || self _meth_E3DADB2823F1DA8A(asmname)) {
    return;
  }
  asm_playfacialanim(asmname, statename, undefined);
}

asm_playfacialanim(asmname, statename, animname) {
  if(isDefined(self.fnasm_playfacialanim))
    [[self.fnasm_playfacialanim]](asmname, statename, animname);
}

asm_getroot() {
  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists("knobs", "root");

  if(isDefined(_id_2C8936D08F85C5C1))
    return asm_getxanim("knobs", _id_2C8936D08F85C5C1);

  _id_2C8936D08F85C5C1 = _id_62D0BB5A77D09499("knobs", "root");
  return _id_6AA159FC2F693AF7("knobs", _id_2C8936D08F85C5C1);
}

asm_getbodyknob() {
  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists("knobs", "body");

  if(isDefined(_id_2C8936D08F85C5C1))
    return asm_getxanim("knobs", _id_2C8936D08F85C5C1);

  _id_2C8936D08F85C5C1 = _id_62D0BB5A77D09499("knobs", "body");
  return _id_6AA159FC2F693AF7("knobs", _id_2C8936D08F85C5C1);
}

asm_getinnerrootknob() {
  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists("knobs", "inner_root");

  if(isDefined(_id_2C8936D08F85C5C1))
    return asm_getxanim("knobs", _id_2C8936D08F85C5C1);

  _id_2C8936D08F85C5C1 = _id_0C1BF21C5E8625EA("knobs", "inner_root");

  if(isDefined(_id_2C8936D08F85C5C1))
    return _id_6AA159FC2F693AF7("knobs", _id_2C8936D08F85C5C1);

  return asm_getbodyknob();
}

asm_getfacialknob() {
  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists("always_on", "facial");

  if(isDefined(_id_2C8936D08F85C5C1))
    return asm_getxanim("always_on", _id_2C8936D08F85C5C1);

  _id_2C8936D08F85C5C1 = _id_0C1BF21C5E8625EA("always_on", "facial");

  if(isDefined(_id_2C8936D08F85C5C1))
    return _id_6AA159FC2F693AF7("always_on", _id_2C8936D08F85C5C1);
}

asm_getheadlookknobifexists() {
  _id_2C8936D08F85C5C1 = asm_lookupanimfromaliasifexists("knobs", "headlook");

  if(isDefined(_id_2C8936D08F85C5C1))
    return asm_getxanim("knobs", _id_2C8936D08F85C5C1);

  _id_2C8936D08F85C5C1 = _id_0C1BF21C5E8625EA("knobs", "headlook");

  if(isDefined(_id_2C8936D08F85C5C1))
    return _id_6AA159FC2F693AF7("knobs", _id_2C8936D08F85C5C1);
}

asm_isweaponoverride() {
  currentweapon = self.weapon;
  weapon = getweaponbasename(currentweapon);
  _id_2FBCADF015A28BEA = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(weapon) && scripts\engine\utility::array_contains(_id_2FBCADF015A28BEA, weapon))
    return 1;

  return 0;
}

_id_6AA159FC2F693AF7(statename, _id_2C8936D08F85C5C1) {
  if(isnumber(_id_2C8936D08F85C5C1)) {
    archetype = self.basearchetype;
    return animsetgetanimfromindex(archetype, statename, _id_2C8936D08F85C5C1);
  } else
    return _id_2C8936D08F85C5C1;
}

asm_getxanim(statename, _id_2C8936D08F85C5C1) {
  if(isnumber(_id_2C8936D08F85C5C1)) {
    archetype = scripts\asm\shared\utility::_id_2285421DFC79C4D5();
    return animsetgetanimfromindex(archetype, statename, _id_2C8936D08F85C5C1);
  } else
    return _id_2C8936D08F85C5C1;
}

asm_playanimstatewithnotetrackinterceptor(asmname, statename, _id_179213470E3D2F54, _id_49BD3392CC4CAEB2) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, _id_2C8936D08F85C5C1));
  endnote = asm_donotetrackswithinterceptor(asmname, statename, _id_179213470E3D2F54, _id_49BD3392CC4CAEB2);

  if(endnote == "end") {
    if(!asm_eventfired(asmname, "end"))
      asm_fireevent(asmname, "end");
  }
}

asm_playanimstatenotransition(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = asm_getanim(asmname, statename);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, _id_2C8936D08F85C5C1));
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

asm_playadditiveanimloopstate(asmname, statename, params) {
  [[self.fnasm_playadditiveanimloopstate]](asmname, statename, params);
}

_id_8D1655AE223D862A(rate) {
  self._id_CCBE1D3FECE5C310 = rate;
}

_id_4BB232C0FCA955F6() {
  return self._id_CCBE1D3FECE5C310;
}

yawdiffto2468(_id_4573A8725DD3748E) {
  if(_id_4573A8725DD3748E < -135)
    return "2";
  else if(_id_4573A8725DD3748E < -45)
    return "6";
  else if(_id_4573A8725DD3748E > 135)
    return "2";
  else if(_id_4573A8725DD3748E > 45)
    return "4";
  else
    return "8";
}

setup_level_ents() {
  foreach(t in getnodearray("traverse", "targetname"))
  t traversethink();

  _id_4C770A9A4AD7659C::callback("setup_all_traversals");
}

_id_35DD4CAD0CA3FAFC() {
  foreach(t in getallnodes()) {
    if(isDefined(t.type) && t.type == "Begin" && !isDefined(t.traverse_height)) {
      t _id_ECE7865EB2447554();
      waitframe();
    }
  }
}

processdoublejumpmantletraversal(target) {
  self.doublejumpmantlepos = target.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(target))
    target delete();
  else
    scripts\engine\utility::deletestruct_ref(target);
}

traversethink() {
  ent = getEnt(self.target, "targetname");

  if(!isDefined(ent))
    ent = scripts\engine\utility::getStruct(self.target, "targetname");

  end_node = getnode(self.target, "targetname");

  if(!isDefined(ent)) {
    return;
  }
  switch (self.animscript) {
    case "wall_run":
      processwallruntraversal(ent);
      return;
    case "double_jump_mantle":
    case "double_jump_vault":
      processdoublejumpmantletraversal(ent);
      return;
    case "double_jump":
      self.startnodeoriginalangles = self.angles;

      if(!isDefined(ent)) {
        return;
      }
      self.jump_over_offset = ent.origin - self.origin;
      self.jump_over_ent_origin = ent.origin;
      break;
    case "rail_hop_double_jump_down":
      self.startnodeoriginalangles = self.angles;
      break;
    default:
      break;
  }

  if(isDefined(ent.target)) {
    _id_6848CD559BA201BC = getEnt(ent.target, "targetname");

    if(!isDefined(_id_6848CD559BA201BC))
      _id_6848CD559BA201BC = scripts\engine\utility::getStruct(ent.target, "targetname");

    calculate_traverse_data(ent.origin, end_node.origin, _id_6848CD559BA201BC.origin);
  } else
    calculate_traverse_data(ent.origin, end_node.origin);

  if(isDefined(self.parentname))
    store_original_traverse_data();

  if(isent(ent))
    ent delete();
  else
    scripts\engine\utility::deletestruct_ref(ent);
}

_id_ECE7865EB2447554() {
  _id_E071EB2967F2A5B4 = undefined;
  end_node = getnode(self.target, "targetname");
  _id_E071EB2967F2A5B4 = _id_FDA6A76C32365675(self.origin, end_node.origin);

  if(isDefined(_id_E071EB2967F2A5B4))
    calculate_traverse_data(_id_E071EB2967F2A5B4, end_node.origin);
}

store_original_traverse_data() {
  self.original_data = spawnStruct();
  self.original_data.origin = self.origin;
  self.original_data.angles = self.angles;
  self.original_data.traverse_height = self.traverse_height;
  self.original_data.traverse_height_delta = self.traverse_height_delta;
  self.original_data.traverse_drop_height_delta = self.traverse_drop_height_delta;
  self.original_data.apex_delta = self.apex_delta;
  self.original_data.apex_delta_local = rotatevectorinverted(self.apex_delta, self.angles);

  if(isDefined(self.across_delta)) {
    self.original_data.across_delta = self.across_delta;
    self.original_data.across_delta_local = rotatevectorinverted(self.across_delta, self.angles);
  }

  end_node = getnode(self.target, "targetname");

  if(isDefined(end_node))
    self.original_data.endnode_pos = end_node.origin;
}

calculate_traverse_data(_id_7F55865EF7657985, endnode_pos, _id_83A69C989077FEB7) {
  self.traverse_height = _id_7F55865EF7657985[2];
  self.traverse_height_delta = _id_7F55865EF7657985[2] - self.origin[2];
  self.traverse_drop_height_delta = _id_7F55865EF7657985[2] - endnode_pos[2];
  self.apex_delta = _id_7F55865EF7657985 - self.origin;

  if(isDefined(_id_83A69C989077FEB7))
    self.across_delta = _id_83A69C989077FEB7 - _id_7F55865EF7657985;
}

re_calculate_traverse_data(_id_6A1D4524B34F5A3B, _id_7F55865EF7657985, endnode_pos, _id_83A69C989077FEB7) {
  if(!isDefined(_id_7F55865EF7657985))
    _id_7F55865EF7657985 = self.origin + rotatevector(_id_6A1D4524B34F5A3B.original_data.apex_delta_local, self.angles);

  if(!isDefined(endnode_pos))
    endnode_pos = _id_6A1D4524B34F5A3B.original_data.endnode_pos;

  if(!isDefined(_id_83A69C989077FEB7) && isDefined(_id_6A1D4524B34F5A3B.original_data.across_delta_local)) {
    _id_F671CC4A667B804F = rotatevector(_id_6A1D4524B34F5A3B.original_data.across_delta_local, self.angles);
    _id_83A69C989077FEB7 = _id_7F55865EF7657985 + _id_F671CC4A667B804F;
  }

  calculate_traverse_data(_id_7F55865EF7657985, endnode_pos, _id_83A69C989077FEB7);
}

processwallruntraversal(target) {
  _id_38A9ABAB335E383A = getEnt(target.target, "targetname");

  if(!isDefined(_id_38A9ABAB335E383A))
    _id_38A9ABAB335E383A = scripts\engine\utility::getStruct(target.target, "targetname");

  self.wall_info = spawnStruct();
  _id_70D5F712A9E22E96 = target;
  _id_76045CF7C0669684 = 0;
  self.wall_info.startnodeoriginalangles = self.angles;
  _id_51C78B431F0E5118 = undefined;

  while(isDefined(_id_70D5F712A9E22E96)) {
    self.wall_info.nodeoffsets[_id_76045CF7C0669684] = _id_70D5F712A9E22E96.origin - self.origin;
    _id_76045CF7C0669684++;
    _id_D258406ADA10EC0A = scripts\engine\utility::getStruct(_id_70D5F712A9E22E96.target, "targetname");
    scripts\engine\utility::deletestruct_ref(_id_70D5F712A9E22E96);
    _id_70D5F712A9E22E96 = _id_D258406ADA10EC0A;
    self.wall_info.nodeoffsets[_id_76045CF7C0669684] = _id_70D5F712A9E22E96.origin - self.origin;
    _id_76045CF7C0669684++;

    if(isDefined(_id_70D5F712A9E22E96.target))
      temp = scripts\engine\utility::getStruct(_id_70D5F712A9E22E96.target, "targetname");
    else
      temp = undefined;

    scripts\engine\utility::deletestruct_ref(_id_70D5F712A9E22E96);
    _id_70D5F712A9E22E96 = temp;

    if(isDefined(_id_70D5F712A9E22E96) && isDefined(_id_70D5F712A9E22E96.script_wallrun_type)) {
      if(_id_70D5F712A9E22E96.script_wallrun_type == "wallrun_mantle") {
        self.wall_info.mantleoffset = _id_70D5F712A9E22E96.origin - self.origin;

        if(isDefined(_id_70D5F712A9E22E96.angles))
          self.wall_info.mantleangles = _id_70D5F712A9E22E96.angles;

        scripts\engine\utility::deletestruct_ref(_id_70D5F712A9E22E96);
        break;
      } else if(_id_70D5F712A9E22E96.script_wallrun_type == "wallrun_vault") {
        self.wall_info.mantleoffset = _id_70D5F712A9E22E96.origin - self.origin;
        self.wall_info.bvaultover = 1;
        scripts\engine\utility::deletestruct_ref(_id_70D5F712A9E22E96);
        break;
      }
    }
  }
}

_id_FDA6A76C32365675(_id_067F1EF51BB69B5F, end_pos) {
  _id_E071EB2967F2A5B4 = undefined;
  _id_7533FF429B05D245 = _id_067F1EF51BB69B5F;
  _id_F38AF0B4E9FFF9F1 = end_pos;
  _id_A5D0297B89FC7EF4 = scripts\engine\utility::flatten_vector(end_pos - _id_067F1EF51BB69B5F);
  _id_8711DFB9E6609FDC = abs(end_pos[2] - _id_067F1EF51BB69B5F[2]);
  _id_B62F14374144C92A = min(_id_067F1EF51BB69B5F[2], end_pos[2]);
  _id_177FFB6884C84CBB = max(_id_067F1EF51BB69B5F[2], end_pos[2]) + 1;
  _id_067F1EF51BB69B5F = (_id_067F1EF51BB69B5F[0], _id_067F1EF51BB69B5F[1], _id_177FFB6884C84CBB);
  end_pos = (end_pos[0], end_pos[1], _id_177FFB6884C84CBB);
  _id_7636B8DC247C7CB4 = physicstrace(_id_067F1EF51BB69B5F, end_pos);

  if(_id_7636B8DC247C7CB4 == end_pos) {
    if(_id_7533FF429B05D245[2] < _id_F38AF0B4E9FFF9F1[2]) {
      _id_E7422A2F5F335F66 = _id_067F1EF51BB69B5F;
      _id_067F1EF51BB69B5F = end_pos;
      end_pos = _id_E7422A2F5F335F66;
    }

    _id_CCD2D697EA32BE14 = 3;
    _id_056F6AA688D4977C = _id_067F1EF51BB69B5F;
    _id_5160014CE4EC2684 = undefined;
    _id_A2D80E0C0CF75C95 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CCD2D697EA32BE14; _id_AC0E594AC96AA3A8++) {
      _id_5160014CE4EC2684 = averagepoint([_id_067F1EF51BB69B5F, end_pos]);
      _id_F67C19A5DBE2CCEC = 20;
      _id_A8DA4FD8B61D7002 = _id_5160014CE4EC2684 - (0, 0, _id_F67C19A5DBE2CCEC);
      _id_7636B8DC247C7CB4 = physicstrace(_id_5160014CE4EC2684, _id_A8DA4FD8B61D7002);

      if(_id_7636B8DC247C7CB4 == _id_A8DA4FD8B61D7002) {
        end_pos = _id_5160014CE4EC2684;
        _id_A2D80E0C0CF75C95 = _id_5160014CE4EC2684;
        continue;
      }

      _id_067F1EF51BB69B5F = _id_5160014CE4EC2684;
      _id_056F6AA688D4977C = _id_7636B8DC247C7CB4;
    }

    if(isDefined(_id_A2D80E0C0CF75C95)) {
      _id_8C522D40CE23DA01 = (_id_A2D80E0C0CF75C95[0], _id_A2D80E0C0CF75C95[1], _id_056F6AA688D4977C[2] - 1);
      _id_E071EB2967F2A5B4 = physicstrace(_id_8C522D40CE23DA01, _id_056F6AA688D4977C);
      _id_E071EB2967F2A5B4 = (_id_E071EB2967F2A5B4[0], _id_E071EB2967F2A5B4[1], max(_id_E071EB2967F2A5B4[2], _id_5160014CE4EC2684[2]));
    } else
      _id_E071EB2967F2A5B4 = (_id_056F6AA688D4977C[0], _id_056F6AA688D4977C[1], max(_id_056F6AA688D4977C[2], _id_5160014CE4EC2684[2]));
  } else {
    _id_D71F6138568BE40F = 0;
    _id_827921A3C3A33294 = _id_7636B8DC247C7CB4;
    _id_CCD2D697EA32BE14 = 10;
    _id_77DE5470517DA14B = 0;

    for(_id_BB3A6419E378030E = 15; !_id_D71F6138568BE40F && _id_77DE5470517DA14B < _id_CCD2D697EA32BE14; _id_77DE5470517DA14B++) {
      _id_177FFB6884C84CBB = _id_177FFB6884C84CBB + _id_BB3A6419E378030E;
      _id_067F1EF51BB69B5F = (_id_067F1EF51BB69B5F[0], _id_067F1EF51BB69B5F[1], _id_177FFB6884C84CBB);
      end_pos = (end_pos[0], end_pos[1], _id_177FFB6884C84CBB);
      _id_7636B8DC247C7CB4 = physicstrace(_id_067F1EF51BB69B5F, end_pos);

      if(_id_7636B8DC247C7CB4 == end_pos) {
        _id_D71F6138568BE40F = 1;
        continue;
      }

      _id_827921A3C3A33294 = _id_7636B8DC247C7CB4;
    }

    if(istrue(_id_D71F6138568BE40F)) {
      _id_587E797BE31A4462 = _id_827921A3C3A33294 + _id_A5D0297B89FC7EF4 + (0, 0, _id_BB3A6419E378030E);
      _id_E071EB2967F2A5B4 = physicstrace(_id_587E797BE31A4462, _id_587E797BE31A4462 - (0, 0, _id_BB3A6419E378030E));
    }
  }

  return _id_E071EB2967F2A5B4;
}