/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\iodine_pills.gsc
*************************************************/

_id_80B2D6867C192094() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("iodineUse", ["usability", "killstreaks", "supers", "gesture", "weapon_switch", "melee", "armor"]);
}

_id_43FE8CCC8B4E6146(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  if(equipmentref != "equip_iodine_pills")
    return;
}

_id_D41FE283435E26C4(equipmentref, _id_CBB2B3D05E48BD27) {
  if(equipmentref != "equip_iodine_pills")
    return;
}

_id_7430B01F931D7E4E(grenade, _id_102A3F5A4D33C2DB) {
  _id_E65A457F9EA02ADE = undefined;

  if(!isDefined(grenade))
    _id_E65A457F9EA02ADE = 0;
  else
    _id_E65A457F9EA02ADE = 1;

  thread _id_9C89631481683DD2(_id_E65A457F9EA02ADE, _id_102A3F5A4D33C2DB);
}

_id_9C89631481683DD2(_id_E65A457F9EA02ADE, _id_102A3F5A4D33C2DB) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!_id_BEF9C19CB3BE47EF()) {
    return;
  }
  if(!istrue(_id_E65A457F9EA02ADE)) {
    if(isDefined(_id_102A3F5A4D33C2DB)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_102A3F5A4D33C2DB.scriptablename);
      _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(lootid, 1);
    }

    thread _id_BBFE4EAE6D4CDB6F();
    weaponobj = makeweapon("iodine_pills_mp");
    self giveandfireoffhand(weaponobj);
    self waittill("grenade_fire", grenade, objweapon);
  }

  _id_8A7B4DC1A58FC045 = 0;

  if(_id_3ABD8504E2419FCE(self))
    _id_8A7B4DC1A58FC045 = 1;
  else
    self._id_D7F035D45152B8F5 = 1;

  thread _id_0BC28931A036B205(_id_8A7B4DC1A58FC045);
}

_id_BEF9C19CB3BE47EF() {
  if(istrue(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self)))
    return 0;

  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(istrue(self.insertingarmorplate))
    return 0;

  if(self isswitchingweapon() || scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    return 0;

  if(self isinfreefall() || self isparachuting())
    return 0;

  if(self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self isgestureplaying())
    return 0;

  if(self islinked())
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("offhand_weapons"))
    return 0;

  return 1;
}

_id_BBFE4EAE6D4CDB6F() {
  self endon("disconnect");
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("iodineUse", 0);
  scripts\engine\utility::waittill_any_4("grenade_fire", "death", "last_stand_start", "enter_live_ragdoll");
  _id_3B64EB40368C1450::_id_588F2307A3040610("iodineUse");
}

_id_7214173379DA1591(grenade) {
  if(isDefined(grenade))
    grenade delete();
}

_id_0BC28931A036B205(_id_8A7B4DC1A58FC045) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("iodinePills_duration");
  self endon("iodinePills_duration");
  _id_A801BC06B34B53D8 = 120;

  if(istrue(_id_8A7B4DC1A58FC045)) {
    if(isDefined(self._id_A92738E0C1337805)) {
      _id_489B2F6C93E7464B = self._id_A92738E0C1337805;
      _id_D9C0575CF0093A35 = _id_A801BC06B34B53D8 + _id_489B2F6C93E7464B;
      _id_A801BC06B34B53D8 = min(_id_D9C0575CF0093A35, 240);
    }
  }

  while(_id_A801BC06B34B53D8 > 0) {
    if(!isalive(self)) {
      break;
    }

    self setclientomnvar("ui_iodine_pills", int(ceil(_id_A801BC06B34B53D8)));
    self._id_A92738E0C1337805 = _id_A801BC06B34B53D8;
    _id_A801BC06B34B53D8 = _id_A801BC06B34B53D8 - 0.05;
    wait 0.05;
  }

  self setclientomnvar("ui_iodine_pills", 0);
  self._id_D7F035D45152B8F5 = undefined;
  self._id_BA4CA459C2788F09 = undefined;
}

_id_AC74FF0686D2886E(damage) {
  if(isDefined(self._id_BA4CA459C2788F09)) {
    _id_7E537DB4F2A171EF = self._id_BA4CA459C2788F09 + 2000;

    if(gettime() < _id_7E537DB4F2A171EF)
      return 0;
  }

  player = self;

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    damage = _id_29C32B7117E01180::modifybrgasdamage(damage);

  damage = max(1, int(damage * 0.5));
  self._id_BA4CA459C2788F09 = gettime();

  if(scripts\cp_mp\gasmask::hasgasmask(player))
    return damage;
  else {
    player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
    player _id_07C40FA80892A721::damagearmor(damage);
    player thread _id_2695A20D4011076D::tryplaycoughaudio(randomintrange(7000, 10000));
    return damage;
  }
}

_id_3ABD8504E2419FCE(player) {
  return istrue(player._id_D7F035D45152B8F5);
}