/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\areas.gsc
********************************/

init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  var_00 = getEntArray("destructible_vehicle", "targetname");
  foreach(var_02 in level.softlandingtriggers) {
    if(var_02.script_type != "car") {
      continue;
    }

    foreach(var_04 in var_00) {
      if(distance(var_02.origin, var_04.origin) > 64) {
        continue;
      }

      var_02.destructible = var_04;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.softlanding = undefined;
    var_00 thread softlandingwaiter();
  }
}

playerentersoftlanding(param_00) {
  self.softlanding = param_00;
}

playerleavesoftlanding(param_00) {
  self.softlanding = undefined;
}

softlandingwaiter() {
  self endon("disconnect");
  for(;;) {
    self waittill("soft_landing", var_00, var_01);
    if(!isDefined(var_00.destructible)) {
      continue;
    }
  }
}