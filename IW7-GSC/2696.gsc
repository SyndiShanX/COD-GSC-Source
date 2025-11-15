/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2696.gsc
***************************************/

init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  var_00 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_02 in level.softlandingtriggers) {
    if(var_2.script_type != "car") {
      continue;
    }
    foreach(var_04 in var_00) {
      if(distance(var_2.origin, var_4.origin) > 64.0) {
        continue;
      }
      var_2.destructible = var_04;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.softlanding = undefined;
    var_00 thread softlandingwaiter();
  }
}

playerentersoftlanding(var_00) {
  self.softlanding = var_00;
}

playerleavesoftlanding(var_00) {
  self.softlanding = undefined;
}

softlandingwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", var_00, var_01);

    if(!isDefined(var_0.destructible))
      continue;
  }
}