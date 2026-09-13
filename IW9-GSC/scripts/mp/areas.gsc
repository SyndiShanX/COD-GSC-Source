/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\areas.gsc
***********************************************/

init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  destructibles = getEntArray("destructible_vehicle", "targetname");

  foreach(trigger in level.softlandingtriggers) {
    if(trigger.script_type != "car") {
      continue;
    }
    foreach(destructible in destructibles) {
      if(distance(trigger.origin, destructible.origin) > 64.0) {
        continue;
      }
      trigger.destructible = destructible;
    }
  }

  thread onplayerconnect();
}

onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  for(;;) {
    level waittill("connected", player);
    player.softlanding = undefined;
    player thread softlandingwaiter();
  }
}

playerentersoftlanding(trigger) {
  self.softlanding = trigger;
}

playerleavesoftlanding(trigger) {
  self.softlanding = undefined;
}

softlandingwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", trigger, damage);

    if(!isDefined(trigger.destructible))
      continue;
  }
}