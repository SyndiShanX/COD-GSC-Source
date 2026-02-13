/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1966.gsc
*************************************************/

init() {
  level._id_DFEB = getEntArray("trigger_multiple_softlanding", "classname");
  var_0 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_2 in level._id_DFEB) {
    if(var_2._id_CEA3 != "car") {
      continue;
    }
    foreach(var_4 in var_0) {
      if(distance(var_2.origin, var_4.origin) > 64.0) {
        continue;
      }
      var_2._id_486C = var_4;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_DFEA = undefined;
    var_0 thread _id_DFEC();
  }
}

_id_B6A2(var_0) {
  self._id_DFEA = var_0;
}

_id_B70A(var_0) {
  self._id_DFEA = undefined;
}

_id_DFEC() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", var_0, var_1);

    if(!isDefined(var_0._id_486C)) {
      continue;
    }
  }
}