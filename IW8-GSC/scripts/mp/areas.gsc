/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\areas.gsc
***********************************************/

function init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  var_0 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_2 in level.softlandingtriggers) {
    if(var_2.script_type != "car") {
      continue;
    }

    foreach(var_4 in var_0) {
      if(distance(var_2.origin, var_4.origin) > 64) {
        continue;
      }

      var_2.destructible = var_4;
    }
  }

  thread onplayerconnect();
}

function onplayerconnect() {
  jumpiffalse(scripts\mp\utility\game::runleanthreadmode()) LOC_00000009;
  return;
}

function playerentersoftlanding(var_0) {
  self.softlanding = var_0;
}

function playerleavesoftlanding(var_0) {
  self.softlanding = undefined;
}

function softlandingwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", var_0, var_1);

    if(!isDefined(var_0.destructible)) {}
  }
}