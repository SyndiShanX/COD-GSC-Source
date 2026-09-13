/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\battlerage.gsc
***********************************************/

_id_905B7BADA6FD91CB(_id_56538FB149CC23BA) {
  self endon("disconnect");
  _id_C98B181B50B131B2();
  thread _id_B1CD853639E4AC23(_id_56538FB149CC23BA);
  _id_2E7548A311865111(1);

  if(istrue(_id_56538FB149CC23BA))
    thread _id_F53FAB1C650C0081();

  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "self_apply");
  return 1;
}

_id_2E7548A311865111(_id_DE0C04C7F580D2F7) {
  if(_id_DE0C04C7F580D2F7) {
    self._id_EAA417C82FC6F913 = ::_id_6722A2088302142B;
    self._id_71C054A8DF6F6E2B = ::_id_532D00CDA484CDF3;
    self._id_50FBC0F48CCFE94E = ::_id_CBCBDC79DB5A1426;
  } else {
    self._id_EAA417C82FC6F913 = undefined;
    self._id_71C054A8DF6F6E2B = undefined;
    self._id_50FBC0F48CCFE94E = undefined;
  }
}

_id_C98B181B50B131B2() {
  self._id_059317C0CD98C577 = undefined;
  self._id_808D06DDFC93A4E4 = undefined;
  self._id_2AD94435DA5CC11B = undefined;
}

_id_B1CD853639E4AC23(_id_56538FB149CC23BA) {
  self endon("disconnect");

  if(!istrue(_id_56538FB149CC23BA)) {
    _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
    _id_19163E14365D9264.usepercent = 0.0;
  }

  self notify("battleRageStart");
  self._id_808D06DDFC93A4E4 = 1;
  self._id_2F53B677680890B1 = 0;
  _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "battleRageUsed");
  self notify("force_regeneration");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  self._id_5CD1342D8FD3DD61 = 1;
  thread _id_DCD48BB3E1CEC589();

  if(getdvarint("dvar_8EDD6DD73C1D8AE4", 1))
    thread _id_F0DD3D086C2D739D();

  childthread _id_70AF5B7AAF9FC4F8(0.5, 0.2);
  _id_C9D3262A60835C51 = getdvarfloat("dvar_F7EC6896361F0E48", 0.8);
  _id_0372301AF73968CB::_id_5457F0107A845374("battleRage_beginSuper", _id_C9D3262A60835C51);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_battlerage", 0);
  _id_6458A8552104DC8B();
}

_id_F009283993C81AFD() {
  self notify("battleRage_visionSetsPainSurge");
  self setscriptablepartstate("battleRageVfx", "off", 0);
  self visionsetnakedforplayer("", 0.5);
}

_id_7FA9C564C245F4E3() {
  _id_8C34F6AD9A062CC8 = getdvarint("dvar_25F7326C9FB11C5B", 120);
  return _id_8C34F6AD9A062CC8;
}

_id_FE088CDEA420C6D6() {
  _id_C01286A01FDF16C1();
  self._id_2F53B677680890B1++;

  if(istrue(self._id_808D06DDFC93A4E4))
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2EA2E76452C29F97");
}

_id_3F783A5ACA22152D() {
  _id_C01286A01FDF16C1();
}

_id_C01286A01FDF16C1() {
  if(!isDefined(self._id_059317C0CD98C577))
    self._id_059317C0CD98C577 = 0;

  _id_66BF0BAD2A84CD3C = getdvarfloat("dvar_7E8C0274F6A1D8AC", 1.5);
  _id_C213330088C02D7C = getdvarfloat("dvar_B9C50A6287359EB0", 0);

  if(_id_66BF0BAD2A84CD3C <= 0) {
    return;
  }
  _id_1CF4C56D1A6F42A7 = self._id_059317C0CD98C577 + _id_66BF0BAD2A84CD3C;
  _id_F1E8A376D1B8A918 = _id_C213330088C02D7C <= 0;
  _id_8D21991EA863707D = _id_1CF4C56D1A6F42A7 < _id_C213330088C02D7C;

  if(_id_F1E8A376D1B8A918 || _id_8D21991EA863707D) {
    self._id_059317C0CD98C577 = self._id_059317C0CD98C577 + _id_66BF0BAD2A84CD3C;
    scripts\mp\supers::_id_7C67C8E12DB38300(_id_66BF0BAD2A84CD3C);
  } else {
    _id_F3AD0A5016CB1AAE = _id_C213330088C02D7C - self._id_059317C0CD98C577;
    _id_F3AD0A5016CB1AAE = max(_id_F3AD0A5016CB1AAE, 0);

    if(_id_F3AD0A5016CB1AAE <= 0) {
      return;
    }
    self._id_059317C0CD98C577 = self._id_059317C0CD98C577 + _id_F3AD0A5016CB1AAE;
    scripts\mp\supers::_id_7C67C8E12DB38300(_id_F3AD0A5016CB1AAE);
  }
}

_id_5C3DADA836D495EF() {
  _id_D154CDDD30B04ED9 = getdvarint("dvar_E2B1912F2DA8B4B5", 0.2);
  _id_C892D16DB21D47DE = _id_D154CDDD30B04ED9 > 0;
  _id_72623D06007724BA = getdvarint("dvar_A5DD59D7C6441104", 0);

  if(_id_72623D06007724BA <= 0) {
    return;
  }
  if(_id_C892D16DB21D47DE)
    _id_2BB6D8CD4A2EEE43(_id_72623D06007724BA);
  else
    _id_E434212C54AFD8E4(_id_72623D06007724BA);
}

_id_2BB6D8CD4A2EEE43(_id_C41A94D2C602F763) {
  _id_41B22745125AB990 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  _id_2EFB8E4E26A9A29D = getdvarfloat("dvar_E2B1912F2DA8B4B5", 0.2);
  _id_79D8CBCA2AA1639E = _id_41B22745125AB990 + _id_41B22745125AB990 * _id_2EFB8E4E26A9A29D;

  if(self.health + _id_C41A94D2C602F763 > _id_41B22745125AB990)
    self.maxhealth = _id_79D8CBCA2AA1639E;

  _id_E434212C54AFD8E4(_id_C41A94D2C602F763);

  if(_id_49D89D9D6340AE00())
    thread _id_CDBDD02ACD470863();
}

_id_E434212C54AFD8E4(_id_C41A94D2C602F763) {
  self.health = int(min(self.maxhealth, self.health + _id_C41A94D2C602F763));
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_49D89D9D6340AE00() {
  _id_41B22745125AB990 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  return self.maxhealth > _id_41B22745125AB990;
}

_id_CDBDD02ACD470863() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("battleRageEnd");
  self notify("battleRage_monitorOverheal");
  self endon("battleRage_monitorOverheal");

  while(_id_49D89D9D6340AE00())
    waitframe();

  _id_FEB90BB1CCDC8A59();
}

_id_739A5F064C7DEBDF() {
  self notify("battleRageEnd");
  _id_F009283993C81AFD();
  self._id_808D06DDFC93A4E4 = undefined;
  self._id_2F53B677680890B1 = undefined;
  _id_FEB90BB1CCDC8A59();
  _id_26A8A7973EA6DE8B = getdvarint("dvar_055316648A7BE13D", 0);
  _id_F40BAF4E34BE03B9 = getdvarint("dvar_CF91C5D3C93671AD", 0);

  if(isDefined(self._id_059317C0CD98C577))
    scripts\cp_mp\challenges::_id_D997435895422ECC("super_battlerage", 3, int(_func_C5CF558181E12D1F(self._id_059317C0CD98C577)));

  _id_A47DB0CCE0BD80F4(_id_26A8A7973EA6DE8B, _id_F40BAF4E34BE03B9);
  _id_C98B181B50B131B2();
  _id_564391EAB6880A70();
  _id_2E7548A311865111(0);
  _id_0372301AF73968CB::_id_4F8B5EFD1816F6C3("battleRage_beginSuper");
}

_id_A47DB0CCE0BD80F4(_id_3B080DDA61799F72, _id_6D7F1BCB37532496) {
  if(_id_3B080DDA61799F72) {
    _id_430870F09B5449E4 = self.maxhealth * 0.2;

    if(self.health > _id_430870F09B5449E4) {
      _id_45DFEAD668CC412A = self.health - _id_430870F09B5449E4;
      self dodamage(_id_45DFEAD668CC412A, self.origin, self, self, "MOD_TRIGGER_HURT", undefined, "torso_upper");
    }
  }

  if(scripts\mp\utility\player::isreallyalive(self) && _id_6D7F1BCB37532496)
    thread _id_1BE90FA9FC4F75D4();
}

_id_1BE90FA9FC4F75D4() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_3B64EB40368C1450::set("battleRage", "sprint", 0);
  _id_3B64EB40368C1450::set("battleRage", "supersprint", 0);
  wait 5;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("battleRage");
}

_id_DCD48BB3E1CEC589() {
  self endon("death_or_disconnect");
  self endon("battleRageEnd");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  _id_739A5F064C7DEBDF();
}

_id_79E60A54C8ED1CE8() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("undyingEnd");
  _id_DFD57A70A834560B = 0;

  for(;;) {
    _id_559A0810819CF4F0 = clamp(self.health / self.maxhealth, 0.22, 1.0);
    self setmovespeedscale(_id_559A0810819CF4F0);

    if(_id_559A0810819CF4F0 <= 0.3 && !istrue(_id_DFD57A70A834560B)) {
      self notify("battleRage_lowHealth");
      _id_DFD57A70A834560B = 1;
    }

    waitframe();
  }
}

_id_D4F1267E22F50847(deployweaponname) {
  self endon("death_or_disconnect");

  if(!isDefined(deployweaponname))
    return 0;

  objweapon = makeweapon(deployweaponname);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(objweapon);
}

_id_222AEBCC1D1C9FE1(deployweaponname) {
  self endon("death_or_disconnect");
  objweapon = makeweapon(deployweaponname);
  result = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon);
  return result;
}

_id_FEB90BB1CCDC8A59() {
  _id_D704CA6C9899B649 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  if(self.maxhealth != _id_D704CA6C9899B649) {
    self.maxhealth = _id_D704CA6C9899B649;
    _id_ED279F6B5EBA9FD4();
    return 1;
  }

  return 0;
}

_id_ED279F6B5EBA9FD4() {
  self.health = int(clamp(self.health, 0, self.maxhealth));
}

_id_6458A8552104DC8B() {
  scripts\mp\utility\perk::giveperk("specialty_blastshield");
  scripts\mp\utility\perk::giveperk("specialty_tac_resist");
}

_id_564391EAB6880A70() {
  scripts\mp\utility\perk::removeperk("specialty_blastshield");
  scripts\mp\utility\perk::removeperk("specialty_tac_resist");
}

_id_F0DD3D086C2D739D() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("battleRageEnd");

  for(;;) {
    wait 0.1;

    if(isDefined(self))
      self refreshsprinttime();
  }
}

_id_170FA6465D8F157A(_id_4776E6542F71C13E, _id_B70102123FFBDD14) {
  if(!isDefined(_id_4776E6542F71C13E))
    return 0;

  if(_id_B70102123FFBDD14) {
    if(!_id_4776E6542F71C13E)
      _id_F009283993C81AFD();
    else
      _id_CBA32179EB094EC9(0.5, 0.5);
  }

  self._id_5CD1342D8FD3DD61 = _id_4776E6542F71C13E;
}

_id_67A8DD7E70C037CC() {
  _id_170FA6465D8F157A(1, 1);
}

_id_B2CBB30462CC3A75() {
  _id_170FA6465D8F157A(0, 1);
}

_id_70AF5B7AAF9FC4F8(_id_A274FF78F6BE5BE1, _id_3BCD7E754EE4931D) {
  self notify("battleRage_visionSetsPainSurge");
  self endon("battleRage_visionSetsPainSurge");
  self endon("death_or_disconnect");
  self endon("killed_player");
  self._id_5CD1342D8FD3DD61 = 1;
  self earthquakeforplayer(0.3, _id_A274FF78F6BE5BE1, self.origin, 50);
  self visionsetnakedforplayer("battlerage-low-health", _id_A274FF78F6BE5BE1);

  if(!scripts\mp\utility\player::isinlaststand(self))
    self playlocalsound("plr_breath_pain_init");

  wait(_id_3BCD7E754EE4931D);
  self._id_5CD1342D8FD3DD61 = 0;
  self setscriptablepartstate("battleRageVfx", "vfx_start", 0);
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_CBA32179EB094EC9(_id_D64FCAAA5C3DDA68, _id_E477D587907EACB9) {
  if(self._id_5CD1342D8FD3DD61)
    return 0;

  if(self.health <= 0) {
    return;
  }
  _id_99E1809851C25F06 = self.health / self.maxhealth;

  if(_id_99E1809851C25F06 < 0.9)
    self visionsetnakedforplayer("battlerage-low-health", _id_D64FCAAA5C3DDA68);

  if(_id_99E1809851C25F06 >= 0.9)
    self visionsetnakedforplayer("battlerage-full-health", _id_E477D587907EACB9);
}

_id_6722A2088302142B() {
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_CBCBDC79DB5A1426() {
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_532D00CDA484CDF3() {
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_903A8ABDE1F77240() {
  _id_CBA32179EB094EC9(0.5, 0.5);
}

_id_F53FAB1C650C0081() {
  self endon("death_or_disconnect");
  self endon("killed_player");
  self endon("stopped_self_revive");
  level endon("game_ended");
  _id_26CCDA53555ECEB2 = level.superglobals.staticsuperdata["super_battlerage"];
  _id_176D1BC49EA13A43 = _id_26CCDA53555ECEB2.usetime;
  _id_0AD30B91C3FA33FE = 0;
  self waittill("last_stand_revived");
  self playlocalsound("plr_breath_pain_init");

  while(_id_0AD30B91C3FA33FE < _id_176D1BC49EA13A43) {
    if(_id_0AD30B91C3FA33FE >= _id_176D1BC49EA13A43) {
      break;
    }

    if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self) && _id_0AD30B91C3FA33FE > 0) {
      break;
    }

    waitframe();
    _id_0AD30B91C3FA33FE = _id_0AD30B91C3FA33FE + level.framedurationseconds;
  }

  _id_739A5F064C7DEBDF();
}

_id_41E3A67050D645D6() {
  self endon("disconnect");
  self endon("last_stand_revived");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("killed_player", "death");
  self._id_5CD1342D8FD3DD61 = 0;
  _id_F009283993C81AFD();
}

_id_CC4ED2DDD1A0C88D() {
  thread _id_70AF5B7AAF9FC4F8(0.5, 0.2);
  thread _id_41E3A67050D645D6();
}