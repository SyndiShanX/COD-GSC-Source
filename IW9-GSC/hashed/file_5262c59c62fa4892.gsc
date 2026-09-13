/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5262c59c62fa4892.gsc
***********************************************/

_id_A09401C58C128DC7(asmname, statename, params) {
  _id_47A4A726AD89E165 = absangleclamp180(self._id_6F56798704F22AD1[1] - self.angles[1]);
  _id_7F11984A4E846E14 = 45;

  if(_id_47A4A726AD89E165 > _id_7F11984A4E846E14)
    return 1;

  return 0;
}

_id_85C5A3C3C6F345C4(asmname, statename, params) {
  _id_47A4A726AD89E165 = angleclamp180(self._id_6F56798704F22AD1[1] - self.angles[1]);
  animindex = scripts\asm\asm::yawdiffto2468(_id_47A4A726AD89E165);
  turnanim = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, animindex);
  return turnanim;
}

_id_17D1A1EC59138F9A(asmname, statename, params) {
  _id_CEB886EB060AED49 = _id_FA0AAE45CE9C1727();
  self._id_3B3C2E088B48D1E2 = 6;
  self._id_44FBE4141B0CB046 = "_back";

  if(isDefined(_id_CEB886EB060AED49)) {
    self._id_3B3C2E088B48D1E2 = _id_A1E95F167C3C1107(_id_CEB886EB060AED49, self);
    self._id_44FBE4141B0CB046 = _id_CEB886EB060AED49 getdamagedirectionsuffix();
  }

  self notify("reviving_intro_starts");
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_16C469F0054F397E(asmname, statename, params) {
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_BAD4052C136A233E(asmname, statename, params) {
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_DE7E772F8F75B5E7(asmname, statename, params) {
  _id_EC2EBFC4CC6BFFC1 = _id_BC9015AD281A7A18();
  self._id_3B3C2E088B48D1E2 = 6;

  if(isDefined(_id_EC2EBFC4CC6BFFC1))
    self._id_3B3C2E088B48D1E2 = _id_A1E95F167C3C1107(self, _id_EC2EBFC4CC6BFFC1);

  self._id_44FBE4141B0CB046 = getdamagedirectionsuffix();
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_421EB5914B4E0E01(asmname, statename, params) {
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_9B9513AAE33CED31(asmname, statename, params) {
  return _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, self._id_3B3C2E088B48D1E2 + self._id_44FBE4141B0CB046);
}

_id_ABC0C090A4A71A80(_id_A234A65C378F3289, params) {
  _id_8A46C62F0A756DD3 = "revival_helper_stim";

  if(self isscriptable() && self getscriptablehaspart(_id_8A46C62F0A756DD3)) {
    statename = self asmgetcurrentstate(self.asmname);
    _id_41D5881B0952A9D5(_id_A234A65C378F3289, statename);
  }
}

_id_A1E95F167C3C1107(from, to) {
  angle = _id_0BD634A02AEBBDE2(from, to);
  index = 6;

  if(angle >= 0)
    index = 4;

  return index;
}

getdamagedirectionsuffix() {
  _id_BFA0DA841399A70D = _id_D0DDF895CA401EBA();

  if(isDefined(_id_BFA0DA841399A70D))
    return _id_BFA0DA841399A70D;

  if(self._id_10EC904BC7121440)
    return "";

  if(!isDefined(self.damageyaw))
    return "_back";

  _id_001AC69B439483DC = abs(self.damageyaw);

  if(_id_001AC69B439483DC > 135)
    return "_belly";
  else if(_id_001AC69B439483DC < 45)
    return "_back";
  else if(self.damageyaw < 0)
    return "_r";

  return "_l";
}

_id_41D5881B0952A9D5(_id_A234A65C378F3289, statename) {
  self endon("death");
  self endon(statename + "_finished");
  _id_8A46C62F0A756DD3 = "revival_helper_stim";

  if(isstartstr(_id_A234A65C378F3289, "stim_attach")) {
    if(_id_D74C84CE78CDD2B4(_id_A234A65C378F3289))
      self setscriptablepartstate(_id_8A46C62F0A756DD3, "active_right");
    else
      self setscriptablepartstate(_id_8A46C62F0A756DD3, "active_left");
  } else if(isstartstr(_id_A234A65C378F3289, "stim_detach"))
    self setscriptablepartstate(_id_8A46C62F0A756DD3, "default");
}

_id_D74C84CE78CDD2B4(_id_A234A65C378F3289) {
  _id_CBA415031462E005 = 1;
  _id_A9F996CAF54DD68C = getsubstr(_id_A234A65C378F3289, 12);

  if(isDefined(_id_A9F996CAF54DD68C) && _id_A9F996CAF54DD68C == "left")
    _id_CBA415031462E005 = 0;

  return _id_CBA415031462E005;
}

_id_BC9015AD281A7A18() {
  id = self _meth_92435C7A6AE85C3C();
  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(id, "reviving_guy");
  return _id_7E18A8A72A7ADD37[0];
}

_id_FA0AAE45CE9C1727() {
  id = self _meth_92435C7A6AE85C3C();
  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(id, "dying_guy");
  return _id_7E18A8A72A7ADD37[0];
}

_id_0BD634A02AEBBDE2(guy, _id_CC2828DA32453F24) {
  if(isDefined(guy) && isDefined(_id_CC2828DA32453F24)) {
    pos = guy.origin;
    _id_990BC5D950404EE5 = _id_CC2828DA32453F24.origin;
    _id_FD24F036BF2A8475 = vectortoyaw(_id_990BC5D950404EE5 - pos);
    return angleclamp180(_id_FD24F036BF2A8475 - guy.angles[1]);
  }

  return 0;
}

_id_D0DDF895CA401EBA() {
  if(!isDefined(self.forcelongdeath))
    return undefined;

  switch (self.forcelongdeath) {
    case 48:
    case 47:
    case 38:
    case 37:
      return "";
    case 40:
    case 39:
      return "_back";
    case 42:
    case 41:
      return "_belly";
    case 45:
    case 43:
      return "_l";
    case 46:
    case 44:
      return "_r";
  }

  return undefined;
}