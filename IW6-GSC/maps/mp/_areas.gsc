/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_areas.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.softLandingTriggers = getEntArray("trigger_multiple_softlanding", "classname");

  destructibles = getEntArray("destructible_vehicle", "targetname");

  foreach(trigger in level.softLandingTriggers) {
    if(trigger.script_type != "car") {
      continue;
    }
    foreach(destructible in destructibles) {
      if(distance(trigger.origin, destructible.origin) > 64.0) {
        continue;
      }
      assert(!isDefined(trigger.destructible));

      trigger.destructible = destructible;
    }
  }

  thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player.softLanding = undefined;

    player thread softLandingWaiter();
  }
}

playerEnterSoftLanding(trigger) {
  self.softLanding = trigger;
}

playerLeaveSoftLanding(trigger) {
  self.softLanding = undefined;
}

softLandingWaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", trigger, damage);

    if(!isDefined(trigger.destructible)) {
      continue;
    }
  }
}