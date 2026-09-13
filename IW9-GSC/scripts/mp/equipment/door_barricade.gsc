/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\door_barricade.gsc
***************************************************/

_id_BFEEEFE1B4413EF0() {
  level._id_B73EB86D1D5A19E9 = [];
  precachestring(&"EQUIPMENT_HINTS/DOOR_BARRICADE_CAN_REMOVE");
  precachestring(&"EQUIPMENT_HINTS/DOOR_BARRICADE_CANNOT_REMOVE");
  scripts\engine\scriptable_door::_id_29BA88E5CE21F3FD(::_id_D42196552DDC1A12);
  scripts\engine\scriptable_door::_id_E37078F3D00EF312(::_id_20C4D2AD6CF2BED3);
  scripts\engine\scriptable_door::_id_87D7BE37D61CBAE3(::_id_7E1A3B2E2D74BE03);
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_FA856206E66D1ACA);
  level._id_40A4B55961592AFE = spawnStruct();
  _id_F2F0951E4A6E218C();
  thread _id_7B14C1E8B791B520();
}

_id_23C3D8F2AE91B6C3() {
  return level._id_40A4B55961592AFE;
}

_id_F2F0951E4A6E218C() {
  _id_962A30A9BB8C0F09 = _id_23C3D8F2AE91B6C3();
  _id_962A30A9BB8C0F09._id_4ACC66EA74CDC413 = getdvarint("dvar_C7E9A5F7F0D6FE87", 1) == 1;
  _id_962A30A9BB8C0F09._id_71DBB8C4005D612B = getdvarint("dvar_DE33DF60FCC33A48", 1) == 1;
  _id_962A30A9BB8C0F09.lifetime = getdvarint("dvar_E94D386176EA049C", 360);
  _id_962A30A9BB8C0F09._id_8A25A7879BECDA51 = getdvarfloat("dvar_6C0AE9B78FEA9323", 1.4);
  _id_962A30A9BB8C0F09.maxhealth = getdvarfloat("dvar_50C1B3E18786DF16", 1000);
  _id_962A30A9BB8C0F09._id_D3AB98BC63E38BD6 = getdvarfloat("dvar_012CCEB48A02504F", _id_962A30A9BB8C0F09.maxhealth / 3);
  _id_962A30A9BB8C0F09._id_A93F9D30441FFED1 = getdvarfloat("dvar_E897C5F4D99C77E2", _id_962A30A9BB8C0F09.maxhealth);
  _id_962A30A9BB8C0F09._id_89BB3F5B08E3A5F2 = getdvarfloat("dvar_F2559412D6F6E7D3", _id_962A30A9BB8C0F09.maxhealth / 5);
  _id_962A30A9BB8C0F09._id_F2F46C25F5851025 = getdvarfloat("dvar_A418D23E834A23E7", _id_962A30A9BB8C0F09.maxhealth / 12);
  _id_962A30A9BB8C0F09._id_029FDCB922844F7F = getdvarfloat("dvar_CCE29F6632D1C759", 4);
  _id_962A30A9BB8C0F09._id_6D997973F6787A9F = getdvarint("dvar_4E9D8C4AC5384A14", 1) == 1;
}

_id_7B14C1E8B791B520() {
  if(getdvarint("dvar_198B319677696C92", 0) != 1) {
    return;
  }
  for(;;) {
    wait 1;
    _id_F2F0951E4A6E218C();
  }
}

_id_2E07802AB9938047() {
  if(!_id_05D6C66032973087())
    return 0;

  _id_216E4731B97B549B = _id_4413C6DD67AF86BC();

  if(!isDefined(_id_216E4731B97B549B))
    return 0;

  _id_3BE4437913032095 = _id_0B0A452739651F90(_id_216E4731B97B549B._id_5DDC24D915057E59, 1);

  if(!_id_3BE4437913032095)
    return 0;

  if(isDefined(_id_216E4731B97B549B._id_1D80A45B74F9CF99)) {
    _id_91073AB900319264 = _id_216E4731B97B549B._id_E4197A93DC763167 == "double";
    _id_EF956E1BEEA273D5 = _id_0B0A452739651F90(_id_216E4731B97B549B._id_1D80A45B74F9CF99, _id_91073AB900319264);

    if(!_id_EF956E1BEEA273D5 && _id_91073AB900319264)
      return 0;

    _id_E2FE2DCB469B8151(_id_216E4731B97B549B._id_5DDC24D915057E59, scripts\engine\utility::ter_op(_id_EF956E1BEEA273D5, _id_216E4731B97B549B._id_1D80A45B74F9CF99, undefined));
  } else
    _id_E2FE2DCB469B8151(_id_216E4731B97B549B._id_5DDC24D915057E59, undefined);

  return 1;
}

_id_0B0A452739651F90(door, _id_CB5DA767B979CC7D) {
  if(!door scriptabledoorisclosed())
    return 0;

  if(!door _id_76345FED7F6C60CB()) {
    if(door _id_839932EE77F36E1C())
      return 0;
  } else if(_id_20C4D2AD6CF2BED3(door, self, 1))
    return 0;
  else
    return 0;

  return 1;
}

_id_E2FE2DCB469B8151(_id_67C2EF0A05674606, _id_A68916F113C5BEDA) {
  _id_9B1AB5AA4F6A9F94 = _id_C104F29141976961(_id_67C2EF0A05674606, _id_A68916F113C5BEDA);
  _id_67C2EF0A05674606 _id_A348FED54B7AD2D1(_id_9B1AB5AA4F6A9F94);
  _id_67C2EF0A05674606 _id_8D35D9EF24E364E3(1);

  if(isDefined(_id_A68916F113C5BEDA)) {
    _id_A68916F113C5BEDA _id_A348FED54B7AD2D1(_id_9B1AB5AA4F6A9F94);
    _id_A68916F113C5BEDA _id_8D35D9EF24E364E3(1);
  }

  _id_9B1AB5AA4F6A9F94 thread _id_47DE387357A169A0();
  _id_9B1AB5AA4F6A9F94 thread _id_9D44D1095C5076FC();
  _id_9B1AB5AA4F6A9F94 thread _id_49C6F1E402DEA720();
}

_id_C104F29141976961(door, _id_1D80A45B74F9CF99) {
  position = undefined;

  if(!isDefined(_id_1D80A45B74F9CF99))
    position = door _id_92093A4B887C3BDC();
  else
    position = door _id_4903B126F5910CC7();

  _id_CF6237CE3F49C883 = spawnStruct();
  _id_CF6237CE3F49C883.origin = position;
  _id_CF6237CE3F49C883.door = door;
  _id_CF6237CE3F49C883.owner = self;
  _id_CF6237CE3F49C883 _id_7F20536248AE1A5C();
  _id_9B1AB5AA4F6A9F94 = spawnStruct();
  _id_9B1AB5AA4F6A9F94.origin = position;
  _id_9B1AB5AA4F6A9F94.owner = self;
  _id_9B1AB5AA4F6A9F94.superid = level.superglobals.staticsuperdata["super_door_barricade"].id;
  _id_9B1AB5AA4F6A9F94.door = door;
  _id_9B1AB5AA4F6A9F94._id_1D80A45B74F9CF99 = _id_1D80A45B74F9CF99;
  _id_9B1AB5AA4F6A9F94.maxhealth = _id_23C3D8F2AE91B6C3().maxhealth;
  _id_9B1AB5AA4F6A9F94.damagetaken = 0;
  _id_9B1AB5AA4F6A9F94._id_CA026D0B161C5997 = 0;
  _id_9B1AB5AA4F6A9F94._id_63193E0C7CEE097E = spawnscriptable("equip_door_barricade_mp", _id_CF6237CE3F49C883._id_80BF3818B8F0EF9E.origin, _id_CF6237CE3F49C883._id_80BF3818B8F0EF9E.angles);
  _id_9B1AB5AA4F6A9F94._id_DA4F3D3B3EEAC5BE = spawnscriptable("equip_door_barricade_mp", _id_CF6237CE3F49C883._id_E72DF9BEFCD314DE.origin, _id_CF6237CE3F49C883._id_E72DF9BEFCD314DE.angles);
  _id_9B1AB5AA4F6A9F94._id_63193E0C7CEE097E._id_CA9B433C67C54628 = _id_9B1AB5AA4F6A9F94;
  _id_9B1AB5AA4F6A9F94._id_DA4F3D3B3EEAC5BE._id_CA9B433C67C54628 = _id_9B1AB5AA4F6A9F94;
  return _id_9B1AB5AA4F6A9F94;
}

_id_A6AD5685B28EC03A(_id_6C2E7E8FFB9DC2B4, _id_56BBDE692DB1E972) {
  if(self._id_CA026D0B161C5997) {
    return;
  }
  self._id_CA026D0B161C5997 = 1;
  dmg = min(self.damagetaken, self.maxhealth);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, int(dmg), istrue(_id_56BBDE692DB1E972));
  _id_4C71E3B9E9268274(self.door);

  if(isDefined(self._id_1D80A45B74F9CF99))
    _id_4C71E3B9E9268274(self._id_1D80A45B74F9CF99);

  thread _id_1591FDB99F47EB45(_id_6C2E7E8FFB9DC2B4, _id_56BBDE692DB1E972);
}

_id_4C71E3B9E9268274(_id_67C2EF0A05674606) {
  _id_67C2EF0A05674606 _id_8D35D9EF24E364E3(0);
  _id_67C2EF0A05674606 _id_81F42D756861B14A();
}

_id_1591FDB99F47EB45(_id_CBF7BE4F62A0DDB2, _id_56BBDE692DB1E972) {
  self notify("death");

  if(istrue(_id_56BBDE692DB1E972)) {
    self._id_63193E0C7CEE097E setscriptablepartstate("main_death_loop", "destroyed");
    self._id_DA4F3D3B3EEAC5BE setscriptablepartstate("main_death_loop", "destroyed");
  } else {
    self._id_63193E0C7CEE097E setscriptablepartstate("main_death_loop", "removed");
    self._id_DA4F3D3B3EEAC5BE setscriptablepartstate("main_death_loop", "removed");
  }

  if(isDefined(_id_CBF7BE4F62A0DDB2) && _id_CBF7BE4F62A0DDB2 > 0)
    wait(_id_CBF7BE4F62A0DDB2);
  else
    waitframe();

  self._id_63193E0C7CEE097E freescriptable();
  self._id_DA4F3D3B3EEAC5BE freescriptable();
}

_id_47DE387357A169A0() {
  self endon("death");
  settings = _id_23C3D8F2AE91B6C3();

  if(settings._id_71DBB8C4005D612B) {
    wait(settings.lifetime);
    _id_A6AD5685B28EC03A(settings._id_8A25A7879BECDA51, 0);
  }
}

_id_9D44D1095C5076FC() {
  self endon("death");
  level waittill("game_ended");
  _id_A6AD5685B28EC03A(undefined, 0);
}

_id_49C6F1E402DEA720() {}

_id_FA856206E66D1ACA(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !isDefined(instance.type) || !isDefined(instance._id_CA9B433C67C54628) || instance._id_CA9B433C67C54628._id_CA026D0B161C5997) {
    return;
  }
  damage = instance _id_5B121785E9363EA4(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);

  if(isDefined(eattacker) && isPlayer(eattacker))
    eattacker _id_5762AC2F22202BA2::updatedamagefeedback("hitequip");

  _id_9B1AB5AA4F6A9F94 = instance._id_CA9B433C67C54628;
  _id_9B1AB5AA4F6A9F94.damagetaken = _id_9B1AB5AA4F6A9F94.damagetaken + damage;

  if(_id_9B1AB5AA4F6A9F94.damagetaken >= _id_9B1AB5AA4F6A9F94.maxhealth)
    _id_9B1AB5AA4F6A9F94 _id_7081462A3365812B(eattacker);
}

_id_5B121785E9363EA4(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  settings = _id_23C3D8F2AE91B6C3();

  if(objweapon.basename == "thermite_av_mp")
    return settings._id_89BB3F5B08E3A5F2;

  if(scripts\mp\damage::issmallsplashdamage(objweapon))
    return 0;

  if(scripts\mp\utility\weapon::isthrowingknife(objweapon.basename) || scripts\mp\utility\weapon::_id_160A992C78BDF589(objweapon.basename))
    return 0;

  if(objweapon.basename == "iw9_dm_crossbow_mp" && smeansofdeath != "MOD_MELEE")
    return 0;

  if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_IMPACT") {
    if(smeansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade")
      return idamage;

    return settings._id_D3AB98BC63E38BD6;
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && einflictor.classname == "script_vehicle") {
    if(isDefined(eattacker) && !scripts\mp\weapons::friendlyfirecheck(instance.owner, eattacker))
      return idamage;
  }

  if(isexplosivedamagemod(smeansofdeath))
    return settings._id_A93F9D30441FFED1;

  idamage = scripts\mp\damage::handleapdamage(objweapon, smeansofdeath, idamage, eattacker);
  idamage = scripts\mp\damage::handleshotgundamage(objweapon, smeansofdeath, idamage);
  return idamage;
}

_id_7081462A3365812B(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
  }

  _id_A6AD5685B28EC03A(_id_23C3D8F2AE91B6C3()._id_8A25A7879BECDA51, 1);
}

_id_8D35D9EF24E364E3(lockdoor) {
  if(lockdoor)
    self _meth_9AF4C9B2CC1BF989();
  else
    self _meth_80902296B05BE00A();
}

_id_76345FED7F6C60CB() {
  if(!self _meth_73CC0F04C4C5001D())
    return 0;

  if(!self scriptableisdoor())
    return 0;

  return isDefined(level._id_B73EB86D1D5A19E9[self.index]);
}

_id_988C3E09726886FD() {
  return level._id_B73EB86D1D5A19E9[self.index];
}

_id_A348FED54B7AD2D1(_id_9B1AB5AA4F6A9F94) {
  level._id_B73EB86D1D5A19E9[self.index] = _id_9B1AB5AA4F6A9F94;
}

_id_81F42D756861B14A() {
  level._id_B73EB86D1D5A19E9[self.index] = undefined;
}

_id_839932EE77F36E1C() {
  return self _meth_FAC544C98A3D9EB4();
}

_id_7E1A3B2E2D74BE03(_id_67C2EF0A05674606, player) {
  if(!_id_67C2EF0A05674606 _id_76345FED7F6C60CB()) {
    return;
  }
  _id_9B1AB5AA4F6A9F94 = _id_67C2EF0A05674606 _id_988C3E09726886FD();
  _id_9B1AB5AA4F6A9F94 _id_A6AD5685B28EC03A(_id_23C3D8F2AE91B6C3()._id_8A25A7879BECDA51);
}

_id_20C4D2AD6CF2BED3(_id_67C2EF0A05674606, player, _id_85E3240D30E184E7) {
  if(!_id_67C2EF0A05674606 _id_76345FED7F6C60CB())
    return 0;

  _id_9B1AB5AA4F6A9F94 = _id_67C2EF0A05674606 _id_988C3E09726886FD();
  return _id_BBF23FBF1B086454(player, _id_9B1AB5AA4F6A9F94.owner);
}

_id_4413C6DD67AF86BC() {
  settings = _id_23C3D8F2AE91B6C3();
  _id_70222FBC47330166 = anglesToForward(self getplayerangles());
  _id_5FC01EEB8003136A = scripts\engine\trace::ray_trace(self getEye(), self getEye() + _id_70222FBC47330166 * 120, undefined, undefined, undefined, undefined, 1);

  if(!isDefined(_id_5FC01EEB8003136A["position"]) || !isDefined(_id_5FC01EEB8003136A["fraction"]) || _id_5FC01EEB8003136A["fraction"] >= 1) {
    return;
  }
  _id_F89541BFC95A3F55 = _id_5FC01EEB8003136A["scriptable"];

  if(!isDefined(_id_F89541BFC95A3F55) || !_id_F89541BFC95A3F55 scriptableisdoor()) {
    return;
  }
  _id_FC60036BA7BF253A = _id_F89541BFC95A3F55 _id_92093A4B887C3BDC();
  _id_91073AB900319264 = _id_F89541BFC95A3F55 scriptabledoorisdouble();
  result = spawnStruct();

  if(!_id_91073AB900319264 && !settings._id_4ACC66EA74CDC413) {
    result._id_E4197A93DC763167 = "single";
    result._id_5DDC24D915057E59 = _id_F89541BFC95A3F55;
    return result;
  }

  _id_68704F3AB9E70C8D = scripts\engine\utility::ter_op(settings._id_4ACC66EA74CDC413, 104, 62.4);
  _id_F89D5F2B4BB6ED36 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(_id_FC60036BA7BF253A, _id_68704F3AB9E70C8D, 20);

  foreach(door in _id_F89D5F2B4BB6ED36) {
    if(door scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_is_double_door_pair(_id_F89541BFC95A3F55)) {
      result._id_E4197A93DC763167 = "double";
      result._id_5DDC24D915057E59 = _id_F89541BFC95A3F55;
      result._id_1D80A45B74F9CF99 = door;
      return result;
    }
  }

  foreach(door in _id_F89D5F2B4BB6ED36) {
    if(door scripts\cp_mp\utility\scriptable_door_utility::_id_8A84BF34F556872D(_id_F89541BFC95A3F55)) {
      result._id_E4197A93DC763167 = "faux";
      result._id_5DDC24D915057E59 = _id_F89541BFC95A3F55;
      result._id_1D80A45B74F9CF99 = door;
      return result;
    }
  }

  result._id_E4197A93DC763167 = "single";
  result._id_5DDC24D915057E59 = _id_F89541BFC95A3F55;
  return result;
}

_id_D42196552DDC1A12(_id_67C2EF0A05674606, player) {
  if(!_id_67C2EF0A05674606 _id_76345FED7F6C60CB())
    return &"";
  else if(_id_20C4D2AD6CF2BED3(_id_67C2EF0A05674606, player, 0))
    return &"EQUIPMENT_HINTS/DOOR_BARRICADE_CAN_REMOVE";
  else
    return &"EQUIPMENT_HINTS/DOOR_BARRICADE_CANNOT_REMOVE";
}

_id_BBF23FBF1B086454(_id_17F832B5DE7083A0, _id_204DA528AA0A3464) {
  if(!isDefined(_id_17F832B5DE7083A0) || !isDefined(_id_204DA528AA0A3464))
    return 0;

  if(!isDefined(_id_17F832B5DE7083A0.team) || !isDefined(_id_204DA528AA0A3464.team))
    return 0;

  if(level.teambased)
    return _id_17F832B5DE7083A0.team == _id_204DA528AA0A3464.team;
  else
    return _id_17F832B5DE7083A0 == _id_204DA528AA0A3464;
}

_id_05D6C66032973087() {
  if(self _meth_E40102956C887F7C())
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(self isinfreefall())
    return 0;

  if(self isjumping())
    return 0;

  if(self _meth_415FE9EECA7B2E2B())
    return 0;

  if(self isthrowinggrenade())
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  return 1;
}

_id_92093A4B887C3BDC() {
  return self _meth_D90515F5E17DBC6F() + anglestoup(self.angles) * 48.0;
}

_id_4903B126F5910CC7() {
  _id_FC60036BA7BF253A = _id_92093A4B887C3BDC();
  _id_2A83DF6C49112D96 = _id_FC60036BA7BF253A - self.origin;
  return _id_FC60036BA7BF253A + (_id_2A83DF6C49112D96[0], _id_2A83DF6C49112D96[1], 0);
}

_id_7F20536248AE1A5C() {
  self.angles = self.door.angles + (0, 90, 0);
  _id_0B6ECE0FE9A2D379 = anglesToForward(self.angles);
  _id_EA409933C7278118 = self.owner.origin - self.origin;
  _id_EA409933C7278118 = (_id_EA409933C7278118[0], _id_EA409933C7278118[1], _id_0B6ECE0FE9A2D379[2]);
  _id_0B6ECE0FE9A2D379 = vectorNormalize(_id_0B6ECE0FE9A2D379);
  _id_EA409933C7278118 = vectorNormalize(_id_EA409933C7278118);
  _id_9563AB8C74BF32FB = vectordot(_id_EA409933C7278118, _id_0B6ECE0FE9A2D379);

  if(_id_9563AB8C74BF32FB < 0)
    self.angles = self.angles + (0, 180, 0);

  self.origin = self.origin + anglesToForward(self.angles) * _id_23C3D8F2AE91B6C3()._id_029FDCB922844F7F;
  self._id_80BF3818B8F0EF9E = spawnStruct();
  self._id_80BF3818B8F0EF9E.origin = self.origin;
  self._id_80BF3818B8F0EF9E.angles = self.angles;
  self.angles = self.angles + (0, 180, 0);
  self.origin = self.origin + anglesToForward(self.angles) * _id_23C3D8F2AE91B6C3()._id_029FDCB922844F7F * 2;
  self._id_E72DF9BEFCD314DE = spawnStruct();
  self._id_E72DF9BEFCD314DE.origin = self.origin;
  self._id_E72DF9BEFCD314DE.angles = self.angles;
}