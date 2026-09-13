/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_electric_discharge.gsc
**********************************************************/

_id_9E8A4373C9755F3D() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("electricFire", ["usability", "mantle", "armor", "supers", "killstreaks", "ladder", "melee", "execution_attack", "execution_victim"]);
}

_id_C0327B881B392647() {
  scripts\mp\utility\perk::giveperk("specialty_blastshield");
  result = _id_4468FD6516623B9F();

  if(!istrue(result))
    scripts\mp\utility\perk::removeperk("specialty_blastshield");

  return result;
}

_id_4468FD6516623B9F() {
  if(self isinexecutionattack() || self isinexecutionvictim())
    return 0;

  thread scripts\mp\hud_message::showsplash("super_electric_discharge_activate", undefined, self, undefined, undefined, undefined, 1);
  self setscriptablepartstate("superpowers", "electric_charge", 0);
  self setclientomnvar("ui_field_upgrade_use", 0);
  return _id_B275E1F539394AE1();
}

_id_1B73127B2849CC95() {
  self endon("disconnect");
  level endon("game_ended");

  if(self isinexecutionattack() || self isinexecutionvictim())
    return 0;

  objweapon = makeweapon("electric_discharge_mp");
  _id_F24845EEAEEDC946 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

  if(isDefined(_id_F24845EEAEEDC946) && !isnullweapon(_id_F24845EEAEEDC946) && _id_F24845EEAEEDC946 != objweapon)
    self._id_F3BC490293D6AFD5 = gettime();

  if(isDefined(self._id_F3BC490293D6AFD5)) {
    lastfiretime = self._id_F3BC490293D6AFD5;

    if((gettime() - lastfiretime) / 1000 <= 1.5)
      return 0;
  }

  if(!_id_DA1CC53C13568565())
    return 0;

  self giveandfireoffhand(objweapon);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("electricFire", 0);
  result = _id_9ABE408951F8CC02();
  _id_3B64EB40368C1450::_id_588F2307A3040610("electricFire");

  if(isDefined(result) && result == "offhand_fired" || result == "timeout")
    return _id_B275E1F539394AE1();
  else if(!isDefined(result) || result == "death")
    self._id_F3BC490293D6AFD5 = undefined;

  return 0;
}

_id_E721C06D0E8502BF() {
  thread _id_1B73127B2849CC95();
  return 1;
}

_id_B275E1F539394AE1() {
  self notify("electric_blast_succeed");
  self._id_F3BC490293D6AFD5 = gettime();
  self.super.isactive = 1;
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_electric_discharge", 0);
  thread _id_B07326AFBB0334D3();
  return 1;
}

_id_DA1CC53C13568565() {
  return scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isinlaststand(self) && !self _meth_9CC921A57FF4DEB5() && !self isonladder() && !self ismantling() && !self _meth_415FE9EECA7B2E2B() && !self isinfreefall() && !self isparachuting() && !self _meth_E5BF22923D0004BC() && !self ismeleeing() && !self isswitchingweapon() && !scripts\mp\utility\player::isusingremote();
}

_id_9ABE408951F8CC02() {
  self endon("disconnect");
  level endon("game_ended");
  thread _id_127EF8142005081A();
  result = scripts\engine\utility::waittill_any_timeout_4(0.9, "offhand_fired", "electric_blast_fail");
  return result;
}

_id_127EF8142005081A() {
  self endon("disconnect");
  self endon("electric_blast_succeed");
  _id_2F58778B47EDF515 = 0;

  for(;;) {
    if(!_id_DA1CC53C13568565()) {
      _id_2F58778B47EDF515 = 1;
      break;
    }

    waitframe();
  }

  if(istrue(_id_2F58778B47EDF515))
    self notify("electric_blast_fail");
}

_id_B07326AFBB0334D3() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread _id_3CE4B28ED71F750A();
  _id_5DA234812450B0D7 = self.origin;
  _id_170B85C668CF4B59 = self.angles;
  _id_D0DE0DB1760B9C5B = 100;
  maxdist = 400;
  waittime = 0.1;
  _id_556B31282ABCB132 = _id_D0DE0DB1760B9C5B;
  _id_F3EA705A2E523BAD = _id_1FD889C40C7941B8();
  _id_AFC2F18CDAA6C9CC = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, maxdist);
  _id_009BA81BE3CE3691 = _id_2C9F694B8B0758E1(_id_AFC2F18CDAA6C9CC, _id_5DA234812450B0D7, _id_F3EA705A2E523BAD);
  _id_6F0350C82FC94C38 = scripts\cp_mp\emp_debuff::get_emp_ents();
  _id_82636D311009A1EB = _id_8B664D9DFE6F4A7E(_id_6F0350C82FC94C38, _id_5DA234812450B0D7);

  while(_id_556B31282ABCB132 <= maxdist) {
    _id_0186931B5967C0E6 = _id_556B31282ABCB132 * _id_556B31282ABCB132;
    _id_FE93D078A44D7866 = [];

    foreach(_id_AD63323B4B7FDE00 in _id_009BA81BE3CE3691) {
      victim = _id_AD63323B4B7FDE00["player"];
      _id_88B443EE2963B2A0 = _id_AD63323B4B7FDE00["distanceSQ"];

      if(_id_88B443EE2963B2A0 <= _id_0186931B5967C0E6) {
        _id_EF718870091EBBD9(victim, _id_F3EA705A2E523BAD);
        continue;
      }

      _id_FE93D078A44D7866[_id_FE93D078A44D7866.size] = _id_AD63323B4B7FDE00;
    }

    _id_009BA81BE3CE3691 = _id_FE93D078A44D7866;
    _id_6BB2D94137551DBC = [];

    foreach(_id_BC910FD8949150F6 in _id_82636D311009A1EB) {
      ent = _id_BC910FD8949150F6["entity"];
      _id_88B443EE2963B2A0 = _id_BC910FD8949150F6["distanceSQ"];

      if(_id_88B443EE2963B2A0 <= _id_0186931B5967C0E6) {
        _id_822A7FD2E23B8FB6(ent);
        continue;
      }

      _id_6BB2D94137551DBC[_id_6BB2D94137551DBC.size] = _id_BC910FD8949150F6;
    }

    _id_82636D311009A1EB = _id_6BB2D94137551DBC;
    _id_556B31282ABCB132 = _id_556B31282ABCB132 + _id_D0DE0DB1760B9C5B;
    wait(waittime);
  }

  self.super.isactive = 0;
  wait 1;
  self notify("finished_electric_blast");
}

_id_2C9F694B8B0758E1(_id_55C733BB252489E1, _id_2C3A1BF3BFD80420, _id_F3EA705A2E523BAD) {
  _id_67E54DC8917A5918 = [];

  foreach(player in _id_55C733BB252489E1) {
    if(!isDefined(player)) {
      continue;
    }
    if(player == self) {
      continue;
    }
    if(!istrue(player _id_0A35012B9B75A996::_id_13EFD74A5091DC42(_id_F3EA705A2E523BAD, 1))) {
      continue;
    }
    index = _id_67E54DC8917A5918.size;
    _id_67E54DC8917A5918[index]["player"] = player;
    _id_67E54DC8917A5918[index]["distanceSQ"] = distancesquared(player.origin, _id_2C3A1BF3BFD80420);
  }

  return _id_67E54DC8917A5918;
}

_id_8B664D9DFE6F4A7E(_id_55C733BB252489E1, _id_2C3A1BF3BFD80420) {
  _id_B5C65D27DFC53F84 = [];

  foreach(ent in _id_55C733BB252489E1) {
    if(!isDefined(ent) || istrue(ent.isdestroyed)) {
      continue;
    }
    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(!scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(ent, self) && !scripts\cp_mp\vehicles\vehicle::vehicle_isneutraltoplayer(ent, self))
        continue;
    } else {
      _id_FD38E227901F5BF8 = undefined;
      _id_1513504DB97A5BE7 = undefined;

      if(isDefined(ent.owner)) {
        _id_FD38E227901F5BF8 = ent.owner.team;
        _id_1513504DB97A5BE7 = ent.owner;
      } else if(isDefined(ent.team))
        _id_FD38E227901F5BF8 = ent.team;

      if(isDefined(_id_FD38E227901F5BF8) && _id_FD38E227901F5BF8 == self.team && _id_1513504DB97A5BE7 != self)
        continue;
    }

    index = _id_B5C65D27DFC53F84.size;
    _id_B5C65D27DFC53F84[index]["entity"] = ent;
    _id_B5C65D27DFC53F84[index]["distanceSQ"] = distancesquared(ent.origin, _id_2C3A1BF3BFD80420);
  }

  return _id_B5C65D27DFC53F84;
}

_id_3CE4B28ED71F750A() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_56F0277B0ED98101 = 0.75;
  _id_FF85637831346339 = 0.25;
  _id_FF624F78310DEF85 = 0.15;
  _id_FF625578310DFCB7 = 0.08;
  _id_31BFD6CEFEC15DC7 = 200;
  _id_31E2EACEFEE7D17B = 400;
  _id_31E2E4CEFEE7C449 = 600;
  scripts\mp\shellshock::artillery_earthquake(self.origin, _id_56F0277B0ED98101, _id_FF85637831346339, _id_FF624F78310DEF85, _id_FF625578310DFCB7, _id_31BFD6CEFEC15DC7, _id_31E2EACEFEE7D17B, _id_31E2E4CEFEE7C449, undefined, 1, 1);
  self setscriptablepartstate("superpowers", "electric_blast", 0);
  self waittill("finished_electric_blast");
  self setscriptablepartstate("superpowers", "off", 0);
}

_id_EF718870091EBBD9(victim, _id_F3EA705A2E523BAD) {
  thread _id_55D0DB940F81E2E6(victim, _id_F3EA705A2E523BAD.weapon, _id_F3EA705A2E523BAD);
}

_id_55D0DB940F81E2E6(victim, weaponobj, _id_F3EA705A2E523BAD) {
  self endon("disconnect");
  victim endon("death_or_disconnect");
  victim endon("haywire_cleared");
  level endon("game_ended");
  _id_D51F1D877F3B9E9E = _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_ABA76142349AF9C0;
  _id_1B50EA388B19171C = _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_95602B4D7262C11F;

  if(!isDefined(victim._id_99E82FCC9B77EC71))
    victim._id_99E82FCC9B77EC71 = 0;

  victim._id_99E82FCC9B77EC71++;

  if(isDefined(victim._id_FE74F3F4D5AFE567)) {
    if((gettime() - victim._id_FE74F3F4D5AFE567) / 1000 <= _id_1B50EA388B19171C) {
      _id_DAB7D922F4D7BE0C = victim._id_99E82FCC9B77EC71;
      _id_1B50EA388B19171C = int(_id_1B50EA388B19171C / _id_DAB7D922F4D7BE0C);
    }
  }

  _id_2B383A10CEB375F3 = gettime() + _id_1B50EA388B19171C * 1000;
  victim._id_FE74F3F4D5AFE567 = gettime();
  thread _id_83A614BD6A1F69F0(victim, _id_1B50EA388B19171C);

  while(gettime() < _id_2B383A10CEB375F3) {
    _id_F3EA705A2E523BAD thread _id_0A35012B9B75A996::_id_CF4FF41F0AE2047F(victim, _id_F3EA705A2E523BAD.weapon, 0);
    damage = scripts\engine\utility::ter_op(isPlayer(victim), 3, 5);

    if(victim _meth_E40102956C887F7C())
      damage = damage * 2;

    victim dodamage(damage, victim.origin, self, self, "MOD_EXPLOSIVE", weaponobj, "torso_upper");
    wait(_id_D51F1D877F3B9E9E);
  }
}

_id_83A614BD6A1F69F0(victim, _id_1B50EA388B19171C) {
  victim endon("disconnect");
  victim notify("electricDischarge_haywire");
  victim endon("electricDischarge_haywire");
  level endon("game_ended");
  victim scripts\engine\utility::waittill_any_timeout_2(_id_1B50EA388B19171C, "death", "last_stand_start");
  victim._id_99E82FCC9B77EC71 = 0;
}

_id_822A7FD2E23B8FB6(ent) {
  _id_A688C2446D2D3BBA = makeweapon("electric_discharge_mp");

  if(isDefined(ent)) {
    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(istrue(ent._id_A2BA7043631B3392))
        return;
      else if(isDefined(ent._id_47BDE44B1ACEC603)) {
        _id_ED76DB33212E6A92 = 200;

        if(isDefined(ent.maxhealth))
          _id_ED76DB33212E6A92 = ent.maxhealth / 6;

        ent dodamage(_id_ED76DB33212E6A92, ent.origin, self, self, "MOD_EXPLOSIVE", _id_A688C2446D2D3BBA);
      } else if(ent scripts\cp_mp\vehicles\vehicle::_id_2A503318E000E11D())
        ent dodamage(9999, ent.origin, self, self, "MOD_EXPLOSIVE", _id_A688C2446D2D3BBA);
      else {
        ent._id_A8F4BB03B366AA80 = 1;
        damagedata = spawnStruct();
        damagedata.attacker = self;
        damagedata.inflictor = ent;
        damagedata.objweapon = ent.objweapon;
        damagedata.meansofdeath = "MOD_EXPLOSIVE";
        ent scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9(damagedata);
      }
    } else
      ent dodamage(9999, ent.origin, self, self, "MOD_EXPLOSIVE", _id_A688C2446D2D3BBA);
  }
}

_id_456170EF7257430B(_id_FCEF8D217A441961) {
  self endon("disconnect");
  level endon("game_ended");
  _id_EB3AA4092C07D861 = 0;
  _id_DC9CDB0DDE14C2E3 = 0;

  if(!istrue(_id_FCEF8D217A441961))
    self waittill("finished_electric_blast");

  if(isDefined(self.super))
    self.super.isactive = 0;

  scripts\mp\utility\perk::removeperk("specialty_blastshield");
  thread _id_104E3370B024F998::_id_269B97F3D86EB172(_id_EB3AA4092C07D861, _id_DC9CDB0DDE14C2E3, "super_use_finished");
  return 1;
}

_id_1FD889C40C7941B8() {
  _id_F3EA705A2E523BAD = spawnStruct();
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo("equip_shockstick");
  _id_F3EA705A2E523BAD.owner = self;
  _id_F3EA705A2E523BAD.team = self.team;
  _id_F3EA705A2E523BAD.origin = self.origin;
  _id_F3EA705A2E523BAD.weapon = makeweapon("electric_discharge_mp");
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_B79E08E886B92D46 = 0;
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_05DD66EBDA239D1B = 1;
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_33BCE1558051CEB5 = 0.3;
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_7C742AF3D434B807 = 5;
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_95602B4D7262C11F = 5;
  _id_F3EA705A2E523BAD._id_8BF83D28BE4C2D4F._id_D442547D75DFFD09._id_ABA76142349AF9C0 = 0.2;
  return _id_F3EA705A2E523BAD;
}