/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\areas.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace areas;

function init() {
  level.softlandingtriggers = getEntArray("trigger_multiple_softlanding", "classname");
  destructibles = getEntArray("destructible_vehicle", "targetname");

  foreach(trigger in level.softlandingtriggers) {
    if(trigger.script_type != "car") {
      continue;
    }

    foreach(destructible in destructibles) {
      if(distance(trigger.origin, destructible.origin) > 64) {
        continue;
      }

      assert(!isDefined(trigger.destructible));
      trigger.destructible = destructible;
    }
  }

  thread onplayerconnect();
}

function onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  for(;;) {
    level waittill("connected", player);
    player.softlanding = undefined;
    player thread softlandingwaiter();
  }
}

function playerentersoftlanding(trigger) {
  self.softlanding = trigger;
}

function playerleavesoftlanding(trigger) {
  self.softlanding = undefined;
}

function softlandingwaiter() {
  self endon("disconnect");

  for(;;) {
    self waittill("soft_landing", trigger, damage);

    if(!isDefined(trigger.destructible)) {}
  }
}