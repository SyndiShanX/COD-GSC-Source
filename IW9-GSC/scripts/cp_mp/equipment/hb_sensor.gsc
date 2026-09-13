/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\hb_sensor.gsc
*************************************************/

hb_sensor_used(grenade) {
  self._id_D07D8ACB673CB5C7 = undefined;

  if(isDefined(self._id_7653BD4BE7DD5FDB)) {
    self._id_7653BD4BE7DD5FDB = self._id_7653BD4BE7DD5FDB - 0.1;

    if(scripts\common\utility::iscp())
      _id_721EB48C0DEEB426 = getdvarint("dvar_952C250389735FD7", 127);
    else if(_id_91481B77C4164A5B("specialty_extra_tactical"))
      _id_721EB48C0DEEB426 = getdvarint("dvar_952C250389735FD7", 60);
    else
      _id_721EB48C0DEEB426 = getdvarint("dvar_3D0928EEC520C586", 60);

    _id_41286CE8E01FF0FF = int(ceil((_id_721EB48C0DEEB426 - self._id_7653BD4BE7DD5FDB) * 100 / _id_721EB48C0DEEB426));
    self setclientomnvar("ui_hb_sensor_battery_percentage", _id_41286CE8E01FF0FF);
  }

  waitframe();
  self _meth_3AC2D6250A4C3F42(0);

  if(isDefined(grenade))
    grenade delete();

  if(istrue(_id_91481B77C4164A5B("specialty_recharge_equipment")))
    thread _id_83ED70DE721AEE0F();

  self notify("hb_sensor_put_away");
}

_id_78CE4BFDA3E762B3(equipmentref, slot, variantid) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("hb_sensor_take");
  self notify("hb_sensor_end_recharge");
  thread _id_323286BF3AA11FBB();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    self._id_7653BD4BE7DD5FDB = 0;
    self._id_3DD6D94C7B926688 = _id_DB61876ACA4E4CD3();
  }

  for(;;) {
    self waittill("grenade_pullback", objweapon);

    if(!issubstr(objweapon.basename, "hb_sensor")) {
      continue;
    }
    self _meth_95F24FBB015EE513(0);
    wait 0.533;
    _id_FC7E5D7D7F99703A();
  }
}

_id_7F948B7F43448EA9(equipmentref, slot) {
  self notify("hb_sensor_take");
  _id_3F703ABC99C1BB80();
}

_id_323286BF3AA11FBB() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  _id_3F703ABC99C1BB80();
}

_id_DB61876ACA4E4CD3() {
  _id_721EB48C0DEEB426 = getdvarint("dvar_3D0928EEC520C586", 60);
  _id_1720642308A86FA7 = self._id_7653BD4BE7DD5FDB;

  if(!isDefined(_id_1720642308A86FA7))
    _id_1720642308A86FA7 = 0;

  return int(ceil((_id_721EB48C0DEEB426 - _id_1720642308A86FA7) * 100 / _id_721EB48C0DEEB426));
}

_id_30CD943D877DC29F(quantity) {
  self._id_3DD6D94C7B926688 = quantity;
  _id_721EB48C0DEEB426 = getdvarint("dvar_3D0928EEC520C586", 60);
  self._id_7653BD4BE7DD5FDB = quantity * -1 * _id_721EB48C0DEEB426 / 100 + _id_721EB48C0DEEB426;
  return 1;
}

_id_3F703ABC99C1BB80() {
  self._id_D07D8ACB673CB5C7 = undefined;
  self._id_7653BD4BE7DD5FDB = undefined;
  self._id_3DD6D94C7B926688 = undefined;

  if(scripts\common\utility::iscp())
    self setclientomnvar("ui_hb_sensor_battery_percentage", 127);
  else
    self setclientomnvar("ui_hb_sensor_battery_percentage", 100);

  self _meth_3AC2D6250A4C3F42(0);
}

_id_FC7E5D7D7F99703A() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self._id_D07D8ACB673CB5C7 = 1;

  if(!isDefined(self._id_7653BD4BE7DD5FDB))
    self._id_7653BD4BE7DD5FDB = 0;

  counter = 0;

  if(scripts\common\utility::iscp())
    return;
  else if(_id_91481B77C4164A5B("specialty_extra_tactical"))
    _id_721EB48C0DEEB426 = getdvarint("dvar_952C250389735FD7", 60);
  else
    _id_721EB48C0DEEB426 = getdvarint("dvar_3D0928EEC520C586", 60);

  _id_3C41D0B684E437F5 = _id_721EB48C0DEEB426 / 100;

  while(istrue(self._id_D07D8ACB673CB5C7)) {
    self._id_3DD6D94C7B926688 = _id_DB61876ACA4E4CD3();

    if(self._id_3DD6D94C7B926688 < 0)
      self._id_3DD6D94C7B926688 = 0;

    self setclientomnvar("ui_hb_sensor_battery_percentage", self._id_3DD6D94C7B926688);

    if(counter >= _id_3C41D0B684E437F5) {
      self._id_7653BD4BE7DD5FDB = self._id_7653BD4BE7DD5FDB + counter;
      counter = 0;
    }

    if(self._id_3DD6D94C7B926688 <= 0.0) {
      thread _id_83EF0926B5392999();
      break;
    }

    counter = counter + 0.05;
    wait 0.05;
  }
}

_id_83EF0926B5392999() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_4B39E4E78B233F51 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

  if(isDefined(_id_4B39E4E78B233F51)) {
    result = scripts\engine\utility::waittill_notify_or_timeout_return("hb_sensor_put_away", 1.0);

    if(result == "timeout")
      self _meth_720152D5D95E2D86();

    if(!istrue(_id_91481B77C4164A5B("specialty_recharge_equipment"))) {
      ammo = _id_7EF95BBA57DC4B82::getequipmentammo("equip_hb_sensor");
      _id_7EF95BBA57DC4B82::setequipmentammo("equip_hb_sensor", ammo - 1);
    }
  }

  if(!istrue(_id_91481B77C4164A5B("specialty_recharge_equipment")))
    _id_3F703ABC99C1BB80();
}

_id_83ED70DE721AEE0F() {
  if(!isDefined(level._id_AEBBD8276F721D86)) {
    return;
  }
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("hb_sensor_end_recharge");

  while(!istrue(self._id_D07D8ACB673CB5C7) && isDefined(self._id_7653BD4BE7DD5FDB)) {
    self._id_7653BD4BE7DD5FDB = self._id_7653BD4BE7DD5FDB - level._id_AEBBD8276F721D86 * level.framedurationseconds;

    if(_id_91481B77C4164A5B("specialty_extra_tactical"))
      _id_721EB48C0DEEB426 = getdvarint("dvar_952C250389735FD7", 60);
    else
      _id_721EB48C0DEEB426 = getdvarint("dvar_3D0928EEC520C586", 60);

    _id_41286CE8E01FF0FF = int(clamp(ceil((_id_721EB48C0DEEB426 - self._id_7653BD4BE7DD5FDB) * 100 / _id_721EB48C0DEEB426), 0, 100));
    self setclientomnvar("ui_hb_sensor_battery_percentage", _id_41286CE8E01FF0FF);

    if(self._id_7653BD4BE7DD5FDB <= 0) {
      self._id_7653BD4BE7DD5FDB = 0;
      self notify("hb_sensor_end_recharge");
      break;
    }

    waitframe();
  }
}

_id_E27C4D2340D9D56B() {
  if(!istrue(self._id_D07D8ACB673CB5C7)) {
    self notify("hb_sensor_end_recharge");
    thread _id_83ED70DE721AEE0F();
  }
}

_id_91481B77C4164A5B(perk) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](perk);

  return undefined;
}

_id_3EFD622905908041(ref, _id_3DBC3B058135CBFB) {
  if(scripts\common\utility::iscp()) {
    _id_30CD943D877DC29F(127);
    return;
  }

  _id_30CD943D877DC29F(100);
}