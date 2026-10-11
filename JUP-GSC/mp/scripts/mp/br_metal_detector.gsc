/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\br_metal_detector.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#namespace br_metal_detector;

function init() {
  if(!getdvarint(@ "hash_4dd644182bf6c698", 1)) {
    return;
  }

  thread metalinit();
}

function metalinit() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_fade_done");
  wait 1;
  triggers = getnoentvolumearray("metalalarm", "script_noteworthy");

  foreach(trigger in triggers) {
    trigger.detector = function_ab3653d48df5ed28(trigger.target);

    if(isDefined(trigger.detector)) {
      trigger thread function_776e0185df41fb73();
    }
  }
}

function function_776e0185df41fb73() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger");
    dlog_recordevent("dlog_event_br_metal_detector", ["detector_x", self.origin[0], "detector_y", self.origin[1], "detector_z", self.origin[2]]);
    startalarm();
  }
}

function function_ab3653d48df5ed28(targetname) {
  [ent] = getentitylessscriptablearray(targetname, "targetname");
  return ent;
}

function startalarm() {
  level endon("game_ended");

  if(!isDefined(self.detector)) {
    return;
  }

  self.detector setscriptablepartstate("root", "on", 1);
  wait 5;
  self.detector setscriptablepartstate("root", "off", 1);
}