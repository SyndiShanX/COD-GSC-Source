/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\scriptable_door_utility.gsc
*************************************************************/

scriptable_door_get_in_radius(position, radius, _id_088E380F714003A9) {
  doors = getentitylessscriptablearray(undefined, undefined, position, radius, "door");
  _id_E4850E5EF9D70A37 = [];

  foreach(door in doors) {
    if(!door scriptableisdoor()) {
      continue;
    }
    if(isDefined(_id_088E380F714003A9)) {
      _id_5357ACDB76B0BD75 = door.origin[2] - position[2];

      if(_id_5357ACDB76B0BD75 <= _id_088E380F714003A9)
        _id_E4850E5EF9D70A37[_id_E4850E5EF9D70A37.size] = door;

      continue;
    }

    _id_E4850E5EF9D70A37[_id_E4850E5EF9D70A37.size] = door;
  }

  return _id_E4850E5EF9D70A37;
}

scriptable_door_freeze_open(_id_DA2D1A382C620732) {
  self notify("scriptable_door_freeze_open");
  self endon("scriptable_door_freeze_open");
  _id_E470D9AF31C8E97C = undefined;
  targetangles = undefined;

  if(istrue(_id_DA2D1A382C620732)) {
    _id_E470D9AF31C8E97C = "bash_left_90";
    targetangles = self _meth_BACD2D0ACDF8559E() + (0, 90, 0);
  } else {
    _id_E470D9AF31C8E97C = "bash_right_90";
    targetangles = self _meth_BACD2D0ACDF8559E() + (0, -90, 0);
  }

  while(anglesdelta(self.angles, targetangles) > 1) {
    currentstate = self getscriptablepartstate("door");

    if(currentstate != _id_E470D9AF31C8E97C)
      self setscriptablepartstate("door", _id_E470D9AF31C8E97C, 0);

    wait 0.05;
  }

  self setscriptablepartstate("door", "ajar", 0);
  self scriptabledoorfreeze(1);
}

scriptable_door_is_double_door_pair(otherdoor) {
  if(self == otherdoor)
    return 0;

  _id_149444556D8AA5F3 = self _meth_D90515F5E17DBC6F();
  _id_149445556D8AA826 = otherdoor _meth_D90515F5E17DBC6F();
  distsqrd = distancesquared(_id_149444556D8AA5F3, _id_149445556D8AA826);

  if(distsqrd > 961.0 || distsqrd < 441.0)
    return 0;

  return 1;
}

_id_8A84BF34F556872D(otherdoor) {
  if(self == otherdoor)
    return 0;

  _id_149444556D8AA5F3 = self _meth_D90515F5E17DBC6F();
  _id_149445556D8AA826 = otherdoor _meth_D90515F5E17DBC6F();
  _id_14A59DEC86FBCC4E = distancesquared(_id_149444556D8AA5F3, _id_149445556D8AA826);
  _id_4573A8725DD3748E = _id_14A59DEC86FBCC4E - 52;

  if(_id_14A59DEC86FBCC4E > 3249 || _id_14A59DEC86FBCC4E < 2209)
    return 0;

  _id_53C5ED210180380B = self.origin;
  _id_53C5EE2101803A3E = otherdoor.origin;
  _id_40852A54559976C6 = distancesquared(_id_53C5ED210180380B, _id_53C5EE2101803A3E);

  if(_id_40852A54559976C6 > 11881 || _id_40852A54559976C6 < 9801)
    return 0;

  return 1;
}