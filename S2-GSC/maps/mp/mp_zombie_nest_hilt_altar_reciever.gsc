/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_hilt_altar_reciever.gsc
**********************************************************/

func_84DB() {
  wait(1);
  var_00 = % zmb_hilt_altar_receiver_down;
  self setscriptablepartstate("machine_main", "closing");
  wait(getanimlength(var_00));
  self setscriptablepartstate("machine_main", "closed");
  for(var_01 = 0; var_01 < 3; var_01++) {
    func_84D7(var_01 + 1, "idle_down");
  }
}

func_84DD(param_00) {
  for(var_01 = 0; var_01 < self.size; var_01++) {
    if(isDefined(self[var_01].var_9045)) {
      self[var_01].var_9045 delete();
    }
  }

  for(var_01 = 0; var_01 < param_00; var_01++) {
    self[var_01].var_9045 = lib_0547::func_8FBA(self[var_01], "zmb_com_cart_full");
    triggerfx(self[var_01].var_9045);
  }
}

func_84D6() {
  self.var_5CCE = lib_0547::func_8FBA(self, "raven_upgrade_green_light");
  triggerfx(self.var_5CCE);
}

func_84D5() {
  if(isDefined(self.var_5CCE)) {
    self.var_5CCE delete();
  }
}

func_84DC() {
  var_00 = % zmb_hilt_altar_receiver_up;
  self setscriptablepartstate("machine_main", "opening");
  wait(getanimlength(var_00));
  self setscriptablepartstate("machine_main", "opened");
}

func_84DA() {
  var_00 = % zmb_hilt_altar_receiver_down;
  self setscriptablepartstate("machine_main", "closing");
  wait(getanimlength(var_00));
  self setscriptablepartstate("machine_main", "closed");
}

func_84D9(param_00) {
  var_01 = [];
  var_01[0] = % zmb_hilt_altar_receiver_button_01_up;
  var_01[1] = % zmb_hilt_altar_receiver_button_02_up;
  var_01[2] = % zmb_hilt_altar_receiver_button_03_up;
  self setscriptablepartstate("button_" + param_00, "up");
  wait(getanimlength(var_01[param_00 - 1]));
  self setscriptablepartstate("button_" + param_00, "idle_up");
}

func_84D8(param_00) {
  var_01 = [];
  var_01[0] = % zmb_hilt_altar_receiver_button_01_down;
  var_01[1] = % zmb_hilt_altar_receiver_button_02_down;
  var_01[2] = % zmb_hilt_altar_receiver_button_03_down;
  self setscriptablepartstate("button_" + param_00, "down");
  wait(getanimlength(var_01[param_00 - 1]));
  self setscriptablepartstate("button_" + param_00, "idle_down");
}

func_84D7(param_00, param_01) {
  self setscriptablepartstate("button_" + param_00, param_01);
}