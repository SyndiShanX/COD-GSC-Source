/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_648c19eb554a0dd9.gsc
***********************************************/

init() {
  if(!getdvarint("dvar_E98ECA6EDA18788A", 1)) {
    return;
  }
  thread _id_387228C079399606();
}

_id_387228C079399606() {
  level endon("game_ended");
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_fade_done");
  wait 1;
  triggers = _func_F159C10D5CF8F0B4("movementalarm", "script_noteworthy");

  foreach(trigger in triggers) {
    trigger._id_54391427B2D54068 = getentitylessscriptablearray(trigger.target, "targetname");

    if(isDefined(trigger._id_54391427B2D54068))
      trigger thread _id_776E0185DF41FB73();
  }
}

_id_776E0185DF41FB73() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\mp\utility\perk::_hasperk("specialty_coldblooded"))
      _id_856C46361EC2AE20();
  }
}

_id_856C46361EC2AE20() {
  level endon("game_ended");

  if(!isDefined(self._id_54391427B2D54068)) {
    return;
  }
  foreach(_id_F7806D4CF24AACD3 in self._id_54391427B2D54068)
  _id_F7806D4CF24AACD3 setscriptablepartstate("onoff", "on", 1);

  wait 20;

  while(scripts\engine\utility::waittill_notify_or_timeout_return("trigger", 1) == "trigger")
    wait 20;

  foreach(_id_F7806D4CF24AACD3 in self._id_54391427B2D54068)
  _id_F7806D4CF24AACD3 setscriptablepartstate("onoff", "off", 1);
}