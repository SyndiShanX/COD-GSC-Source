/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\playerhealth.gsc
***********************************************/

_id_A6C2D3F08399946F() {
  if(!isDefined(level._id_BE39D6B46044F344))
    level._id_BE39D6B46044F344 = 40;
}

manageplayerregen() {
  self.deathsdoor = 0;
  self.deathsdoorsfx = 0;
  self._id_632FCFDF269B9DC8 = -99999;
  self.hasdonepainbreathloopthislife = 0;
  self._id_34F355A9DA5039E1 = 0;
  self stoplocalsound("deaths_door_out");
  self stoplocalsound("deaths_door_in");
  self clearsoundsubmix("deaths_door_mp");
  thread _id_C12E5FDA7DC648CE();
  thread _id_FB3404DCA14B5916();
}

_id_C12E5FDA7DC648CE() {
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");

  for(;;) {
    self waittill("damage", idamage, eattacker, _id_FEA2A171F4CE7311, vpoint, smeansofdeath);
    thread _id_1C2DEAD2DBCAA0E9(smeansofdeath);
  }
}

_id_1C2DEAD2DBCAA0E9(smeansofdeath) {
  if(!scripts\cp_mp\utility\player_utility::isreallyalive(self)) {
    return;
  }
  if(istrue(level.healthregendisabled)) {
    return;
  }
  self._id_73B0186B9643675A = undefined;
  self.currentregendelay = undefined;
  self notify("naturalHealthRegen");
  self endon("naturalHealthRegen");
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");
  level endon("game_ended");
  self._id_34F355A9DA5039E1 = 0;

  while(istrue(level.healthregendisabled) && scripts\cp_mp\utility\player_utility::isusingremote())
    waitframe();

  _id_019B9BB9CEF6A2D3();
  waitforhealthregendelay();
  _id_8E4F69EEA1104DCC();
}

_id_FB3404DCA14B5916() {
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");

  for(;;) {
    self waittill("force_regeneration");
    thread _id_8E4F69EEA1104DCC();
  }
}

waitforhealthregendelay() {
  while(istrue(self.healthregendisabled) || !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("health_regen") || istrue(self._id_35116E057346139E))
    waitframe();

  _id_399288F08AAF56E5 = gettime();
  self._id_73B0186B9643675A = _id_399288F08AAF56E5;
  self.currentregendelay = _id_5C0987ADA94437DF();

  while(self.currentregendelay > 0) {
    self.currentregendelay = _id_5C0987ADA94437DF(self._id_73B0186B9643675A);
    wait 0.05;
  }

  self.currentregendelay = undefined;
  self._id_73B0186B9643675A = undefined;
}

_id_8E4F69EEA1104DCC() {
  _id_3998AA2FC8ABBA2C = !istrue(self.adrenalinepoweractive) && !istrue(self._id_808D06DDFC93A4E4) && !istrue(self.bandageactive) && !istrue(self.laststandhealisactive);

  if(_id_3998AA2FC8ABBA2C && istrue(self._id_34F355A9DA5039E1)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self notify("healOverTimeThink");
  self endon("healOverTimeThink");
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");
  self endon("damage");
  level endon("game_ended");
  _id_7F86CF029BEF696D = istrue(self.adrenalinepoweractive);
  _id_4A2AE12522AD9D95 = self.health;
  _id_9CAB7FB3EAA1AC48 = 0;
  _id_2A0C127782C20593 = _id_FFA24FDCB2F2F661(_id_3998AA2FC8ABBA2C);

  while(self.health / self.maxhealth < _id_2A0C127782C20593) {
    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("health_regen") || istrue(self.healthregendisabled) && _id_3998AA2FC8ABBA2C) {
      self._id_34F355A9DA5039E1 = 0;
      return;
    }

    self._id_34F355A9DA5039E1 = 1;
    _id_326DA60065B28039();
    _id_9CAB7FB3EAA1AC48 = _id_9CAB7FB3EAA1AC48 + gethealthperframe();
    self.health = int(min(self.maxhealth, _id_9CAB7FB3EAA1AC48 + self.health));
    _id_25BCB1F5ECB2C04E();
    _id_9CAB7FB3EAA1AC48 = _id_9CAB7FB3EAA1AC48 % 1;
    _id_019B9BB9CEF6A2D3();
    wait 0.05;
  }

  self._id_34F355A9DA5039E1 = 0;

  if(self.health >= self.maxhealth) {
    onfullhealth(_id_4A2AE12522AD9D95, _id_3998AA2FC8ABBA2C, _id_7F86CF029BEF696D);
    _id_019B9BB9CEF6A2D3();
  }
}

_id_79429693A2F7755D(_id_022B5B902570C2D6, _id_33A536D1DBC55784) {
  if(!isDefined(self._id_278ADEADE4A9E3A5))
    self._id_278ADEADE4A9E3A5 = [];

  if(scripts\engine\utility::array_contains_key(self._id_278ADEADE4A9E3A5, _id_022B5B902570C2D6))
    return 0;
  else {
    self._id_278ADEADE4A9E3A5[_id_022B5B902570C2D6] = _id_33A536D1DBC55784;
    return 1;
  }

  return 0;
}

_id_5457F0107A845374(_id_022B5B902570C2D6, _id_33A536D1DBC55784, _id_5B1D349F3D7879EE) {
  _id_79429693A2F7755D(_id_022B5B902570C2D6, _id_33A536D1DBC55784);

  if(isDefined(_id_5B1D349F3D7879EE))
    thread _id_C37D70B38D3ACEBA(_id_022B5B902570C2D6, _id_5B1D349F3D7879EE);
}

_id_C37D70B38D3ACEBA(_id_022B5B902570C2D6, _id_3669AC207C224E12) {
  level endon("game_ended");
  self notify("regenModifierTimeoutThread_" + _id_022B5B902570C2D6);
  self endon("regenModifierTimeoutThread_" + _id_022B5B902570C2D6);
  scripts\engine\utility::waittill_any_timeout_1(_id_3669AC207C224E12 / 1000, "death_or_disconnect");
  _id_4F8B5EFD1816F6C3(_id_022B5B902570C2D6);
}

_id_4F8B5EFD1816F6C3(_id_022B5B902570C2D6) {
  if(!isDefined(self) || !isDefined(self._id_278ADEADE4A9E3A5))
    return 0;

  if(scripts\engine\utility::array_contains_key(self._id_278ADEADE4A9E3A5, _id_022B5B902570C2D6)) {
    self._id_278ADEADE4A9E3A5 = scripts\engine\utility::array_remove_key(self._id_278ADEADE4A9E3A5, _id_022B5B902570C2D6);
    return 1;
  }

  return 0;
}

_id_7E8E4A9F891D5806() {
  if(isDefined(self._id_73B0186B9643675A))
    return _id_5C0987ADA94437DF(self._id_73B0186B9643675A);
  else
    return undefined;
}

_id_5C0987ADA94437DF(_id_136D4CB8AA835CFB) {
  _id_3D45DCB5C34B2867 = 5000;

  if(isDefined(level.healthregendelay))
    _id_3D45DCB5C34B2867 = level.healthregendelay * 1000;

  _id_F17191554CD9309E = _id_3D45DCB5C34B2867;

  if(!isDefined(self.regendelayspeed))
    self.regendelayspeed = 1.0;

  if(isDefined(level.regendelayspeedfunc))
    self.regendelayspeed = [[level.regendelayspeedfunc]](self.regendelayspeed);

  if(scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_medic")) {
    self.regendelayspeed = 1;
    _id_F17191554CD9309E = getdvarint("dvar_99EC17FD211BE305", 4) * 1000;
  }

  if(isDefined(_id_136D4CB8AA835CFB)) {
    timeoffset = gettime();
    timeoffset = timeoffset - _id_136D4CB8AA835CFB;
    _id_3D45DCB5C34B2867 = ceil(_id_F17191554CD9309E - _id_F17191554CD9309E * _id_71005B327450D873() + _id_F17191554CD9309E - _id_F17191554CD9309E * self.regendelayspeed);
    _id_3D45DCB5C34B2867 = _id_3D45DCB5C34B2867 - timeoffset;
  } else
    _id_3D45DCB5C34B2867 = ceil(_id_F17191554CD9309E - _id_F17191554CD9309E * _id_71005B327450D873() + _id_F17191554CD9309E - _id_F17191554CD9309E * self.regendelayspeed);

  return max(_id_3D45DCB5C34B2867, 0);
}

_id_71005B327450D873() {
  _id_E9E9E13B20A550AB = 0;

  if(isDefined(self._id_278ADEADE4A9E3A5)) {
    foreach(mod in self._id_278ADEADE4A9E3A5)
    _id_E9E9E13B20A550AB = _id_E9E9E13B20A550AB + mod;
  }

  return _id_E9E9E13B20A550AB;
}

_id_FFA24FDCB2F2F661(_id_3998AA2FC8ABBA2C) {
  if(_id_3998AA2FC8ABBA2C && isDefined(level._id_E148F7D0B42FE6DA))
    return level._id_E148F7D0B42FE6DA;
  else
    return 1.0;
}

_id_326DA60065B28039() {
  if(isDefined(self._id_EAA417C82FC6F913))
    self[[self._id_EAA417C82FC6F913]]();
}

gethealthperframe() {
  if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE())
    _id_881FB15F4D296741 = level.playermaxhealth / 100;
  else
    _id_881FB15F4D296741 = 1;

  _id_89E7B92573A50713 = level._id_BE39D6B46044F344 * 0.05 * _id_881FB15F4D296741;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getGametypeHealthPerFrame"))
    _id_89E7B92573A50713 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getGametypeHealthPerFrame")]]();
  else {
    if(scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_regenfaster") && isDefined(level.regenfasterhealthmod))
      _id_89E7B92573A50713 = _id_89E7B92573A50713 * level.regenfasterhealthmod;

    if(isDefined(level.regenhealthaddfunc))
      _id_89E7B92573A50713 = [[level.regenhealthaddfunc]](_id_89E7B92573A50713);
  }

  if(istrue(self._id_51FD42CCE181AED4)) {
    _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_slayer"];
    _id_3B34E55B597B82D4 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_0E509160DC46C542, 1);
    _id_89E7B92573A50713 = _id_89E7B92573A50713 * _id_3B34E55B597B82D4;
  } else if(isDefined(self._id_AEEB56D22AF8DF3E)) {
    _id_D442547D75DFFD09 = self._id_AEEB56D22AF8DF3E._id_D442547D75DFFD09;
    _id_F8712DC20A76BD5F = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_DA79CDBEA9398D17, 1.5);
    _id_89E7B92573A50713 = _id_89E7B92573A50713 * _id_F8712DC20A76BD5F;
  }

  return _id_89E7B92573A50713;
}

_id_25BCB1F5ECB2C04E() {
  if(isDefined(self._id_50FBC0F48CCFE94E))
    self[[self._id_50FBC0F48CCFE94E]]();
}

onfullhealth(_id_4A2AE12522AD9D95, _id_823CA369FAFD4A36, _id_7F86CF029BEF696D) {
  _id_E394E626CA540132 = self.health - _id_4A2AE12522AD9D95;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "onFullHealth"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "onFullHealth")]](_id_4A2AE12522AD9D95, _id_823CA369FAFD4A36, _id_7F86CF029BEF696D);

  if(_id_7F86CF029BEF696D)
    scripts\cp_mp\challenges::onstim(_id_E394E626CA540132);

  _id_9EF4F53D298067A2();
  self notify("healed");
  level notify("healed", self);
  thread _id_6A5D3BF7A5B7064A::removeoldattackersovertime();

  if(!level.gameended && !scripts\cp_mp\utility\player_utility::isusingremote())
    self playlocalsound(scripts\engine\utility::ter_op(scripts\cp_mp\utility\player_utility::isfemale(), "Fem_breathing_better", "breathing_better"));
}

_id_9EF4F53D298067A2() {
  if(isDefined(self._id_71C054A8DF6F6E2B))
    self[[self._id_71C054A8DF6F6E2B]]();
}

_id_019B9BB9CEF6A2D3() {
  healthratio = self.health / self.maxhealth;

  if(healthratio > level._id_FDD1AF3C4C6CBE86 && !istrue(self.inlaststand))
    _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);

  if((healthratio <= 0.55 || istrue(self.inlaststand)) && !scripts\cp_mp\utility\player_utility::isusingremote() && !istrue(self.ignoredeathsdoor))
    _id_6A5D3BF7A5B7064A::onenterdeathsdoor(undefined);
}