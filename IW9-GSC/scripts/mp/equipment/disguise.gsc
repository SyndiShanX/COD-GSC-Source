/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\disguise.gsc
***********************************************/

_id_83599506981C29CD() {
  level._id_8C0F3022529BE75E = spawnStruct();
  _id_38CF81CF267278DC();

  if(level.mapname == "mp_br_mechanics" && getdvarint("dvar_8FA9D384348CB11B", 0)) {
    _id_2779ED8BC9C5F43C = getEnt("player_conceal", "targetname");
    _id_C37D0500F8C1C938 = spawn("script_model", (0, 0, 0));
    _id_C37D0500F8C1C938.angles = (0, 0, 0);
    _id_C37D0500F8C1C938 clonebrushmodeltoscriptmodel(_id_2779ED8BC9C5F43C);
    _id_C37D0500F8C1C938 dontinterpolate();
    level._id_8C0F3022529BE75E._id_C37D0500F8C1C938 = _id_C37D0500F8C1C938;
  }
}

_id_38CF81CF267278DC() {
  if(!isDefined(level._id_8C0F3022529BE75E)) {
    return;
  }
  level._id_8C0F3022529BE75E._id_53BE2821DA633FD7 = [];
  _id_4981209C2C509828("alqatala", "body_dmz_disguised_al_qatala_iw9_1_1", "head_dmz_disguised_al_qatala_iw9_1_1", "mp_vm_opforce_al_qatala_elite_ar_1_1", "vestlight", "milhvygr");
  _id_4981209C2C509828("shadowcompany", "body_dmz_disguised_shadow_company_iw9_1_1", "head_dmz_disguised_shadow_company_iw9_1_1", "mp_vm_opforce_shadow_company_elite_1_1", "nylon", "millghtgr");
  _id_4981209C2C509828("konnig", "body_dmz_disguised_unidentified_iw9_1_1", "head_dmz_disguised_unidentified_iw9_1_1", "mp_vm_dmz_disguised_unidentified_iw9_1_1", "nylon", "millghtgr");
}

_id_EB1FE3A0083B03DF(_id_B05BC1A86DFC27CC) {
  return level._id_8C0F3022529BE75E._id_53BE2821DA633FD7[_id_B05BC1A86DFC27CC];
}

_id_291A4B6E765BFCC6(_id_B05BC1A86DFC27CC) {
  return level._id_8C0F3022529BE75E._id_53BE2821DA633FD7[_id_B05BC1A86DFC27CC].head;
}

_id_4D2AD5E5595384F0(_id_B05BC1A86DFC27CC) {
  return level._id_8C0F3022529BE75E._id_53BE2821DA633FD7[_id_B05BC1A86DFC27CC].body;
}

_id_ABA28CC8C36EEAF7(_id_B05BC1A86DFC27CC) {
  return level._id_8C0F3022529BE75E._id_53BE2821DA633FD7[_id_B05BC1A86DFC27CC]._id_437409FD34EB2546;
}

_id_4981209C2C509828(key, body, head, _id_5B10CEF5F2960853, cloth, _id_5B3CB08505A1F23A) {
  _id_4DA14BA3163B540F = spawnStruct();
  _id_4DA14BA3163B540F.body = body;
  _id_4DA14BA3163B540F.head = head;
  _id_4DA14BA3163B540F._id_437409FD34EB2546 = _id_5B10CEF5F2960853;
  _id_4DA14BA3163B540F.cloth = cloth;
  _id_4DA14BA3163B540F._id_5B3CB08505A1F23A = _id_5B3CB08505A1F23A;
  level._id_8C0F3022529BE75E._id_53BE2821DA633FD7[key] = _id_4DA14BA3163B540F;
}

_id_310843B56A04E24C() {
  _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(self.origin);
  _id_8E5A9B658FA525ED = _id_48814951E916AF89::_id_F851A2F41CFFA860();

  if(isDefined(_id_D1CF55B36FACF5A8._id_A42C3E0E1B2DC645))
    _id_8E5A9B658FA525ED = _id_D1CF55B36FACF5A8._id_A42C3E0E1B2DC645;

  return _id_EB1FE3A0083B03DF(_id_466E5AD92C500882(_id_8E5A9B658FA525ED));
}

_id_466E5AD92C500882(_id_8E5A9B658FA525ED) {
  switch (_id_8E5A9B658FA525ED) {
    case "bio_lab":
    case "merc":
      return "shadowcompany";
    case "aq":
      return "alqatala";
    case "ru":
      return "konnig";
    default:
      return "alqatala";
  }
}

_id_67D03E329E13F612(itemslotindex, quantity) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.operatorcustomization)) {
    return;
  }
  _id_7E30D4841D0ABE41(1);
  self.disguised = 1;
  _id_A1650EF824A7BE56(1);
  _id_A8CB3B8E739C633E(itemslotindex, quantity);
  self playSound("fly_dmz_disguise_on");
  _id_6A8EC730B2BFA844::_id_2D3C14FAA38E2146(self);

  if(!istrue(self._id_859654E0445A36D9))
    self forceplaygestureviewmodel("iw9_vm_ges_disguise_on");

  _id_A78681B284F9AE0A = getdvarfloat("dvar_62171A84E10129AB", 0.35);
  childthread _id_9292CBE2DEC7D826(_id_A78681B284F9AE0A, 1);
  childthread _id_B02057AAA6D29BA1(1, _id_A78681B284F9AE0A);
  thread _id_0D8D7A08A9FD9A9F();
  scripts\engine\utility::delaythread(_id_A78681B284F9AE0A, ::_id_7E30D4841D0ABE41, 0);
}

_id_A8CB3B8E739C633E(itemslotindex, quantity) {
  _id_62FFF9B22E767D8E = spawnStruct();
  _id_62FFF9B22E767D8E.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(self);
  _id_62FFF9B22E767D8E.head = self.operatorcustomization.head;
  _id_62FFF9B22E767D8E.body = self.operatorcustomization.body;
  _id_62FFF9B22E767D8E.health = quantity;
  _id_62FFF9B22E767D8E.maxhealth = 108;
  _id_62FFF9B22E767D8E._id_EBBCB5A184F5C67B = itemslotindex;
  self._id_454034054E53BD79 = _id_62FFF9B22E767D8E;
}

_id_9EE717001ACD63A0(_id_DC6CBFDA5CAFD043) {
  _id_8C0F3022529BE75E = _id_3275D6441A8E838A();

  if(!isDefined(_id_8C0F3022529BE75E))
    return 0;

  _id_8C0F3022529BE75E._id_EBBCB5A184F5C67B = _id_DC6CBFDA5CAFD043;
}

_id_8E1F9B3B6C83372D(index) {
  if(!istrue(self.disguised))
    return 0;

  _id_8C0F3022529BE75E = _id_3275D6441A8E838A();

  if(!isDefined(_id_8C0F3022529BE75E))
    return 0;

  if(_id_8C0F3022529BE75E._id_EBBCB5A184F5C67B == index)
    return 1;

  return 0;
}

_id_81475BB5A5A5C48F() {
  self._id_454034054E53BD79 = undefined;
}

_id_3275D6441A8E838A() {
  return self._id_454034054E53BD79;
}

_id_7E30D4841D0ABE41(_id_027C777AE907B9FA) {
  self._id_74642C7F377A42C5 = _id_027C777AE907B9FA;

  if(_id_027C777AE907B9FA) {
    array = ["offhand_weapons"];
    _id_3B64EB40368C1450::_id_59C053B89257BC95("disguise", array, 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("disguise");
}

_id_65A78266EAD29817() {
  return istrue(self._id_74642C7F377A42C5);
}

_id_C2AFDDB38BD47F6F(itemslotindex, quantity) {
  if(istrue(self._id_EF8C89617046F3B7) || !_id_67015C88C47EC4F8::_id_43207FFC5E843003())
    scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
  else if(_id_65A78266EAD29817())
    return;
  else
    _id_67D03E329E13F612(itemslotindex, quantity);
}

_id_9292CBE2DEC7D826(delay, _id_E036BEB70DA584EC) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(delay);

  if(_id_E036BEB70DA584EC) {
    _id_8DD1C5E3042447B8(1);
    _id_890834271F0A6FC5();
    _id_D2F434DF04EB7EDE = _id_310843B56A04E24C();
    self setcustomization(_id_D2F434DF04EB7EDE.body, _id_D2F434DF04EB7EDE.head);
    self setclothtype(_id_D2F434DF04EB7EDE.cloth);
    self _meth_8ABE5A968CC3C220(_id_D2F434DF04EB7EDE._id_5B3CB08505A1F23A);
    thread _id_67015C88C47EC4F8::_id_8BFEA85875208730();
    scripts\engine\utility::delaythread(1.0, ::_id_8DD1C5E3042447B8, 0);
  } else {
    scripts\cp_mp\execution::_giveexecution(self._id_454034054E53BD79.executionref);
    self setscriptablepartstate("disguise", "off", 0);
    self setcustomization(self.operatorcustomization.body, self.operatorcustomization.head);
    _id_81475BB5A5A5C48F();
  }
}

_id_8DD1C5E3042447B8(_id_E036BEB70DA584EC) {
  state = scripts\engine\utility::ter_op(_id_E036BEB70DA584EC, "on", "off");
  self setscriptablepartstate("disguise", state, 0);
}

_id_D3B190EE881C5CA7() {
  if(!istrue(self.disguised))
    return 0;
  else
    return 1;
}

_id_3EDE6B66136C0F93(_id_8A127DE2EC4F8B49) {
  if(!istrue(self.disguised) || _id_65A78266EAD29817() || !_id_67015C88C47EC4F8::_id_25E7A6883C64324C())
    return;
  else
    _id_DA46BE98FF60908D(_id_8A127DE2EC4F8B49);
}

_id_DA46BE98FF60908D(_id_575BCCB498ED7F9E) {
  if(!istrue(self.disguised)) {
    return;
  }
  _id_7E30D4841D0ABE41(1);
  _id_A1650EF824A7BE56(0);
  self playSound("fly_dmz_disguise_off");
  currentweapon = self getcurrentweapon();

  if(!istrue(self._id_859654E0445A36D9) && isDefined(currentweapon) && !isnullweapon(currentweapon))
    self forceplaygestureviewmodel("iw9_vm_ges_disguise_off");

  _id_BA9ECA80DD516CAE = getdvarfloat("dvar_307D1884BCAEF28F", 0.45);
  childthread _id_9292CBE2DEC7D826(_id_BA9ECA80DD516CAE, 0);
  childthread _id_B02057AAA6D29BA1(0, _id_BA9ECA80DD516CAE);
  self.disguised = undefined;

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "")
    self setclothtype(self.operatorcustomization.clothtype);
  else
    self setclothtype("vestlight");

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization._id_400EF51562606E7A) && self.operatorcustomization._id_400EF51562606E7A != "")
    self _meth_8ABE5A968CC3C220(self.operatorcustomization._id_400EF51562606E7A);
  else
    self _meth_8ABE5A968CC3C220("millghtgr");

  self setclientomnvar("ui_dmz_disguise_sixth_sense_glow", 0);
  scripts\engine\utility::delaythread(_id_BA9ECA80DD516CAE, ::_id_7E30D4841D0ABE41, 0);
  self notify("disguise_ended");
}

_id_B02057AAA6D29BA1(_id_E036BEB70DA584EC, delay) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(delay);
  self setclientomnvar("ui_dmz_disguise_state", _id_E036BEB70DA584EC);
}

_id_A1650EF824A7BE56(_id_74FA01BD3626F0B7) {
  if(isDefined(level._id_8C0F3022529BE75E._id_C37D0500F8C1C938)) {
    if(_id_74FA01BD3626F0B7) {
      _id_54A491B5DD59F575 = level._id_8C0F3022529BE75E._id_C37D0500F8C1C938;
      _id_54A491B5DD59F575.origin = self.origin;
      _id_54A491B5DD59F575.angles = self.angles;
      _id_54A491B5DD59F575.owner = self;
      _id_54A491B5DD59F575 linkTo(self);
      self._id_C8395B9BAE721F6B._id_C37D0500F8C1C938 = _id_54A491B5DD59F575;
    } else {
      self._id_C8395B9BAE721F6B._id_C37D0500F8C1C938 unlink();
      self._id_C8395B9BAE721F6B._id_C37D0500F8C1C938.origin = (0, 0, 0);
      self._id_C8395B9BAE721F6B._id_C37D0500F8C1C938.owner = undefined;
      self._id_C8395B9BAE721F6B._id_C37D0500F8C1C938 = undefined;
    }
  } else
    _func_ED9B1DDD2EC82DAB(self, _id_74FA01BD3626F0B7);
}

_id_0D8D7A08A9FD9A9F() {
  self endon("death_or_disconnect");
  self endon("disguise_ended");

  if(getdvarint("dvar_8303972C0CFBECE0", 1) != 1) {
    return;
  }
  for(;;) {
    _id_D293A200FE5D81C1();
    waitframe();
  }
}

_id_BC96CF8A43C99435() {
  origin = self.origin;
  radius = getdvarfloat("dvar_1EF2C1FAD9DAD02F", 1000);
  _id_674DAAFFFC0AACF3 = undefined;

  if(_func_A794FCF9545F2062())
    _id_674DAAFFFC0AACF3 = _func_B1EEF70090B5B7B5(origin, radius, _func_869CCB4E3451B8C6(["etype_ai"]), undefined, undefined);
  else
    _id_674DAAFFFC0AACF3 = getaiarrayinradius(origin, radius);

  return _id_674DAAFFFC0AACF3;
}

_id_D293A200FE5D81C1() {
  contents = scripts\engine\trace::create_default_contents(1);
  debug = getdvarint("dvar_C6B2B86FD34E0636", 0) == 1;
  _id_FA89613ACD0EB87E = 0;
  _id_75ABBF0830C5D3FA = 0;
  _id_7A25DDB41E7358DB = undefined;
  _id_0746071AB06F38FD = undefined;
  time = getsystemtimeinmicroseconds();

  if(!isDefined(self))
    return 0;

  if(!istrue(self.disguised))
    return 0;

  _id_674DAAFFFC0AACF3 = _id_BC96CF8A43C99435();
  _id_24F9B94A171CCA52 = scripts\mp\utility\player::getstancecenter();

  foreach(agent in _id_674DAAFFFC0AACF3) {
    if(_id_FA89613ACD0EB87E >= 25) {
      _id_FA89613ACD0EB87E = 0;
      waitframe();
    }

    if(!_id_7E44E1AADD3DDF3A(agent)) {
      continue;
    }
    _id_FA89613ACD0EB87E++;
    _id_C903A259216D97E0 = agent.origin;
    threatlevel = agent getthreatsight(self);

    if(threatlevel < 0.25) {
      continue;
    }
    _id_75ABBF0830C5D3FA = _id_75ABBF0830C5D3FA | _id_8CD5129459F5CD9C(agent);
  }

  _id_443ABC2E017F4E40(_id_75ABBF0830C5D3FA);

  if(_id_75ABBF0830C5D3FA != 0) {
    if(!isDefined(self._id_DB46AC7F2E05D19D) || (gettime() - self._id_DB46AC7F2E05D19D) / 1000 >= 4) {
      self playlocalsound("iw9_mp_disguise_alert");
      self._id_DB46AC7F2E05D19D = gettime();
    }
  }
}

_id_7E44E1AADD3DDF3A(agent) {
  if(!isDefined(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!isDefined(agent))
    return 0;

  if(!isalive(agent))
    return 0;

  if(scripts\mp\utility\player::isusingremote())
    return 0;

  return 1;
}

_id_8CD5129459F5CD9C(agent) {
  forward = vectorNormalize(anglesToForward(self getplayerangles()));
  _id_9001DA663C7CDFEC = vectorNormalize(agent.origin - self.origin);
  dot = vectordot(forward, _id_9001DA663C7CDFEC);

  if(dot >= 0.92388)
    return 2;
  else if(dot >= 0.707107)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, forward, agent.origin), 4, 1);
  else if(dot >= 0.5)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, forward, agent.origin), 128, 64);
  else if(dot >= -0.707107)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, forward, agent.origin), 32, 8);
  else
    return 16;
}

_id_443ABC2E017F4E40(_id_75ABBF0830C5D3FA) {
  self setclientomnvar("ui_dmz_disguise_sixth_sense_glow", _id_75ABBF0830C5D3FA);
}

_id_890834271F0A6FC5() {
  _id_CB11F01BF67D6E03 = ["000", "001", "022", "023"];
  _id_7BE710153F5D3671 = _id_CB11F01BF67D6E03[randomint(_id_CB11F01BF67D6E03.size)];
  _id_EF173B498A2DB825 = "execution_" + _id_7BE710153F5D3671;
  scripts\cp_mp\execution::_giveexecution(_id_EF173B498A2DB825);
}