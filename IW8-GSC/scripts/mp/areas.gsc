/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\areas.gsc
***********************************************/

function init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  var0 = getEntArray("destructible_vehicle", "targetname");

  foreach(var2 in level.softlandingtriggers) {
    if(var2.script_type != "car") {
      continue;
    }

    foreach(var4 in var0) {
      if(distance(var2.origin, var4.origin) > 64) {
        continue;
      }

      var2.destructible = var4;
    }
  }

  thread onplayerconnect();
}

function onplayerconnect() {
  jumpiffalse(scripts\mp\utility\game::runleanthreadmode()) LOC_00000009;
  return;
}

function playerentersoftlanding(var0) {
  self.softlanding = var0;
}

function playerleavesoftlanding(var0) {
  self.softlanding = undefined;
}

function softlandingwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", var0, var1);

    if(!isDefined(var0.destructible)) {}
  }
}