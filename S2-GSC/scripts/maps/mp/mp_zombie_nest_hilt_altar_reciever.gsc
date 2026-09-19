/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_hilt_altar_reciever.gsc
******************************************************************/

#using_animtree("destructibles");

_id_84DB() {
  wait 1;
  var_0 = % zmb_hilt_altar_receiver_down;
  self setscriptablepartstate("machine_main", "closing");
  wait(_getanimlength(var_0));
  self setscriptablepartstate("machine_main", "closed");

  for(var_1 = 0; var_1 < 3; var_1++)
    _id_84D7(var_1 + 1, "idle_down");
}

_id_84DD(var_0) {
  for(var_1 = 0; var_1 < self.size; var_1++) {
    if(isDefined(self[var_1]._id_9045))
      self[var_1]._id_9045 delete();
  }

  for(var_1 = 0; var_1 < var_0; var_1++) {
    self[var_1]._id_9045 = _id_0547::_id_8FBA(self[var_1], "zmb_com_cart_full");
    _triggerfx(self[var_1]._id_9045);
  }
}

_id_84D6() {
  self._id_5CCE = _id_0547::_id_8FBA(self, "raven_upgrade_green_light");
  _triggerfx(self._id_5CCE);
}

_id_84D5() {
  if(isDefined(self._id_5CCE))
    self._id_5CCE delete();
}

_id_84DC() {
  var_0 = % zmb_hilt_altar_receiver_up;
  self setscriptablepartstate("machine_main", "opening");
  wait(_getanimlength(var_0));
  self setscriptablepartstate("machine_main", "opened");
}

vehphys_isoffground() {
  var_0 = % zmb_hilt_altar_receiver_down;
  self setscriptablepartstate("machine_main", "closing");
  wait(_getanimlength(var_0));
  self setscriptablepartstate("machine_main", "closed");
}

vehphys_getvelocity(var_0) {
  var_1 = [];
  var_1[0] = % zmb_hilt_altar_receiver_button_01_up;
  var_1[1] = % zmb_hilt_altar_receiver_button_02_up;
  var_1[2] = % zmb_hilt_altar_receiver_button_03_up;
  self setscriptablepartstate("button_" + var_0, "up");
  wait(_getanimlength(var_1[var_0 - 1]));
  self setscriptablepartstate("button_" + var_0, "idle_up");
}

_id_84D8(var_0) {
  var_1 = [];
  var_1[0] = % zmb_hilt_altar_receiver_button_01_down;
  var_1[1] = % zmb_hilt_altar_receiver_button_02_down;
  var_1[2] = % zmb_hilt_altar_receiver_button_03_down;
  self setscriptablepartstate("button_" + var_0, "down");
  wait(_getanimlength(var_1[var_0 - 1]));
  self setscriptablepartstate("button_" + var_0, "idle_down");
}

_id_84D7(var_0, var_1) {
  self setscriptablepartstate("button_" + var_0, var_1);
}