/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_648c19eb554a0dd9.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\utility\perk;
#namespace namespace_707f4e559a586342;

function init() {
  if(!getdvarint(@ "hash_e98eca6eda18788a", 1)) {
    return;
  }

  thread movementinit();
}

function movementinit() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_fade_done");
  wait 1;
  triggers = getnoentvolumearray("movementalarm", "script_noteworthy");

  foreach(trigger in triggers) {
    trigger.detectors = getentitylessscriptablearray(trigger.target, "targetname");

    if(isDefined(trigger.detectors)) {
      trigger thread function_776e0185df41fb73();
    }
  }
}

function function_776e0185df41fb73() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);

    if(!player scripts\mp\utility\perk::_hasperk("specialty_coldblooded")) {
      startalarm();
    }
  }
}

function startalarm() {
  level endon("game_ended");

  if(!isDefined(self.detectors)) {
    return;
  }

  var_d1415110270ff152 = getdvarint(@ "hash_5c27f1538b104979", 20);

  foreach(element in self.detectors) {
    element setscriptablepartstate("onoff", "on", 1);
  }

  wait var_d1415110270ff152;

  while(waittill_notify_or_timeout_return("trigger", 1) == "trigger") {
    wait var_d1415110270ff152;
  }

  foreach(element in self.detectors) {
    element setscriptablepartstate("onoff", "off", 1);
  }
}