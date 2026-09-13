/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_callouts.gsc
************************************************/

init() {
  level.calloutglobals.namelocations = [];

  if(!tableexists(level.calloutglobals.callouttable)) {
    return;
  }
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_4CB56D024C774848 = _id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409;
  _id_3C590C0EE220B1D6 = level.mapcorners[0].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[1].origin[1];
  _id_4CB56E024C774A7B = _id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6;
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_C13986ECA25DD35E = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 5);

    if(!isDefined(_id_C13986ECA25DD35E) || _id_C13986ECA25DD35E == "") {
      break;
    }

    if(_id_C13986ECA25DD35E != "1") {} else {
      x = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 6);
      x = float(x);
      x = x * _id_4CB56D024C774848 + _id_3C590D0EE220B409;
      y = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 7);
      y = float(y);
      y = y * _id_4CB56E024C774A7B + _id_3C590C0EE220B1D6;
      radius = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 8);
      radius = float(radius);
      ref = tablelookupbyrow(level.calloutglobals.callouttable, _id_CB89110314447B2F, 1);
      _id_72865918609FF919 = spawnStruct();
      _id_72865918609FF919.origin = (x, y, 0);
      _id_72865918609FF919.radius = radius;
      level.calloutglobals.namelocations[ref] = _id_72865918609FF919;
    }

    _id_CB89110314447B2F++;
  }
}

getlocationnameforpoint(point) {
  locname = "";

  foreach(name, info in level.calloutglobals.namelocations) {
    if(distance2dsquared(point, info.origin) <= info.radius * info.radius) {
      locname = name;
      break;
    }
  }

  return locname;
}