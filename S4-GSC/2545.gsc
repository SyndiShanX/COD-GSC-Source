/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2545.gsc
*************************************************/

init() {
  level._id_1A3D = [];
  level._id_1A39 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/battleRigTable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/battleRigTable.csv", var_0, 1);
    level._id_1A3D[var_1] = var_2;
    level._id_1A39[var_2] = var_1;
    var_0++;
  }
}

_id_C474(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;

  switch (var_0) {
    case "archetype_assault":
      var_1 = _id_09F0::_id_C474;
      break;
    default:
      return;
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }
}

_id_0B26(var_0) {
  if(var_0) {
    scripts\mp\utility\perk::_id_6FC2("specialty_battleslide");
  } else {
    self notify("battleslide_unset");
  }
}

_id_6CF8(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  for(var_1 = 0; var_1 < level._id_1A3D.size; var_1++) {
    if(level._id_1A3D[var_1] == var_0) {
      return var_1;
    }
  }

  return 0;
}