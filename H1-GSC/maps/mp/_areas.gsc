/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_areas.gsc
********************************/

init() {
  level.softlandingtriggers = getentarray("trigger_multiple_softlanding", "classname");
  var_0 = getentarray("destructible_vehicle", "targetname");

  foreach(var_2 in level.softlandingtriggers) {
    if(var_2.script_type != "car") {
      continue;
    }
    foreach(var_4 in var_0) {
      if(distance(var_2.origin, var_4.origin) > 64.0) {
        continue;
      }
      var_2.destructible = var_4;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.softlanding = undefined;
    var_0 thread softlandingwaiter();
  }
}

playerentersoftlanding(var_0) {
  self.softlanding = var_0;
}

playerleavesoftlanding(var_0) {
  self.softlanding = undefined;
}

softlandingwaiter() {
  self endon("disconnect");

  for (;;) {
    self waittill("soft_landing", var_0, var_1);

    if(!isdefined(var_0.destructible))
      continue;
  }
}