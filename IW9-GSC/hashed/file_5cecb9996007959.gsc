/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5cecb9996007959.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "onUserInit":
      return::_id_3DBD361F74B442F9;
    case "onUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "onEventReceived":
      return::_id_D9A30A0827FAB997;
    case "setStationary":
      return::_id_46A6CB991C2A5D49;
    case "useArmorPlate":
      return::usearmorplate;
  }
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  self clearbtgoal(1);
  self notify("endusearmorplate");
  _id_8A46C62F0A756DD3 = "armor_plate";

  if(self isscriptable() && self getscriptablehaspart(_id_8A46C62F0A756DD3))
    self setscriptablepartstate(_id_8A46C62F0A756DD3, "default");

  if(isalive(self) && self.asmname == "cap_use_armor_plate_solo")
    _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
}

_id_D9A30A0827FAB997(receiver, info, origin) {
  if(info == "focused_on") {
    distsq = distancesquared(receiver.origin, origin);
    _id_63233BCA53EFDD98 = 150;

    if(distsq < _id_63233BCA53EFDD98 * _id_63233BCA53EFDD98) {
      self notify("endusearmorplate");
      return 1;
    }

    return 1;
  }

  return 0;
}

_id_46A6CB991C2A5D49(statename, params) {
  self _meth_E64EA2B4E79C4B74(1);
  self setbtgoalRadius(1, params[0]);
}

usearmorplate(statename, params) {
  self endon("death");
  self endon("endusearmorplate");
  _id_3E38EE41DC326FDC = "cap_use_armor_plate_solo";

  if(self.asmname != _id_3E38EE41DC326FDC)
    _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, "caps/interactions/cap_use_armor_plate_solo");

  _id_30B70873A0937989("Using Armor Plate!");
  self waittill("cap_exit_completed");
  scripts\asm\asm::asm_fireephemeralevent("use_armor_plate", "end");
}

_id_30B70873A0937989(_id_22E9090A351646E9) {
  debug = getdvarint("dvar_03E267EC6E066E2B", 0);

  if(istrue(debug))
    return;
}