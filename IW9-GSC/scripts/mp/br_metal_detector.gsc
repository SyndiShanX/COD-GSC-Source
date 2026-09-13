/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\br_metal_detector.gsc
***********************************************/

init() {
  if(!getdvarint("dvar_4DD644182BF6C698", 1)) {
    return;
  }
  thread _id_F66374CA9F911F92();
}

_id_F66374CA9F911F92() {
  level endon("game_ended");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_fade_done");
  wait 1;
  triggers = _func_F159C10D5CF8F0B4("metalalarm", "script_noteworthy");

  foreach(trigger in triggers) {
    trigger._id_5C5B50FCE337658B = _id_AB3653D48DF5ED28(trigger.target);

    if(isDefined(trigger._id_5C5B50FCE337658B))
      trigger thread _id_776E0185DF41FB73();
  }
}

_id_776E0185DF41FB73() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger");
    dlog_recordevent("dlog_event_br_metal_detector", ["detector_x", self.origin[0], "detector_y", self.origin[1], "detector_z", self.origin[2]]);
    _id_856C46361EC2AE20();
  }
}

_id_AB3653D48DF5ED28(targetname) {
  _id_1D2BE7531AAF82AF = getentitylessscriptablearray(targetname, "targetname");
  ent = _id_1D2BE7531AAF82AF[0];
  return ent;
}

_id_856C46361EC2AE20() {
  level endon("game_ended");

  if(!isDefined(self._id_5C5B50FCE337658B)) {
    return;
  }
  self._id_5C5B50FCE337658B setscriptablepartstate("root", "on", 1);
  wait 5.0;
  self._id_5C5B50FCE337658B setscriptablepartstate("root", "off", 1);
}