/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3104.gsc
**************************************/

func_7598(var_0) {
  if(!isDefined(self.fx)) {
    self.fx = spawnStruct();
  }

  scripts\sp\utility::func_75CE();

  if(isDefined(var_0) && var_0) {
    thread func_13D7D();
  }
}

func_13D7D() {
  self endon("entitydeleted");
  wait 0.05;
  func_0BDC::func_A19F();
}

func_A3B4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.spaceship_mode;
  }

  func_A3B7(var_0);
}

func_A3B7(var_0, var_1) {
  if(!level.var_241D) {
    if(var_0 == "hover") {
      var_0 = "hover_space";
    } else if(var_0 == "fly") {
      var_0 = "fly_space";
    }
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.var_615D) && self.var_615D.var_619D) {
    return;
  }
  if(isDefined(self.fx.state) && self.fx.state == var_0) {
    return;
  }
  self notify("notify_change_fx_state");
  self endon("notify_change_fx_state");
  self endon("entitydeleted");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(isDefined(self.fx.var_552E)) {
    self thread[[self.fx.var_552E]]();
  }

  self.fx.var_552E = undefined;

  switch (var_0) {
    case "hover":
      func_2399();
      break;
    case "hover_space":
      func_23A9();
      break;
    case "fly":
      func_11132();
      break;
    case "fly_space":
      func_11143();
      break;
    case "fly_glide":
      func_11136();
      break;
    case "hover_glide":
      func_239F();
      break;
    case "reentry":
      func_239F();
      break;
    case "launch_mode":
      func_AA78();
      break;
    case "boost_mode":
      func_2CAF();
      break;
    case "landed_mode":
      func_A7CC();
      break;
    case "none":
      break;
  }

  self.fx.state = var_0;
}

func_23A9() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle_space", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_23A8;
}

func_23A8() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle_space", var_1);
  }
}

func_2399() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle", var_1, 0, "notify_change_fx_state");
  }

  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustCenter", "tag_vtol_center", 0, "notify_change_fx_state");
  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustSide", "tag_vtol_left", 0, "notify_change_fx_state");
  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustSide", "tag_vtol_right", 0, "notify_change_fx_state");
  func_13913();
  self.fx.var_552E = ::func_2398;
}

func_2398() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle", var_1);
  }

  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustCenter", "tag_vtol_center");
  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustSide", "tag_vtol_left");
  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustSide", "tag_vtol_right");
  func_13912();
}

func_5B7D() {
  self endon("entitydeleted");
  var_0 = 3;

  while(var_0 > 0) {
    var_0 = var_0 - 0.05;
    wait 0.05;
  }
}

func_13913() {
  thread scripts\sp\vehicle_code::func_1A93();
}

func_13912() {
  self notify("stop_kicking_up_dust");
}

func_11132() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustMax", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_11131;
}

func_11131() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustMax", var_1);
  }
}

func_11143() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustMax_space", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_11142;
}

func_11142() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustMax_space", var_1);
  }
}

func_11136() {
  self.fx.var_552E = ::func_11135;
}

func_11135() {}

func_239F() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_239E;
}

func_239E() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle", var_1);
  }
}

func_AA78() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_med", var_1, 0, "notify_change_fx_state");
  }

  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_lrg", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_AA77;
}

func_AA77() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_med", var_1);
  }

  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_lrg", var_1);
  }
}

func_AA79() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_med", var_1, 0, "notify_change_fx_state");
  }

  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_lrg", var_1, 0, "notify_change_fx_state");
  }
}

func_2CAF() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustBoost", var_1, 0, "notify_change_fx_state");
  }

  self.fx.var_552E = ::func_2CAE;
}

func_2CAE() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustBoost", var_1);
  }
}

func_A7CC() {
  self.fx.var_552E = ::func_A7CB;
}

func_A7CB() {}

func_AA92() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
    playFX(scripts\engine\utility::getfx(self.script_team + "_rearThrustLaunch_panels_blow_med"), self gettagorigin(var_1), anglesToForward(self gettagangles(var_1)), anglestoup(self gettagangles(var_1)));
  }
}

func_AA91() {
  foreach(var_1 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    playFX(scripts\engine\utility::getfx(self.script_team + "_rearThrustLaunch_panels_blow_med"), self gettagorigin(var_1), anglesToForward(self gettagangles(var_1)), anglestoup(self gettagangles(var_1)));
  }
}

func_AA67(var_0) {
  var_1 = "stop_launch_charge_med";
  self notify(var_1);

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    foreach(var_3 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
      scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_charge_lrg", var_3, 0, var_1);
    }
  } else {
    foreach(var_3 in level.var_A1E3[self.script_team + "_launch_boosters_med"]) {
      scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_charge_lrg", var_3);
    }
  }
}

func_AA66(var_0) {
  var_1 = "stop_launch_charge_lrg";
  self notify(var_1);

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    foreach(var_3 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
      scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_charge_lrg", var_3, 0, var_1);
    }
  } else {
    foreach(var_3 in level.var_A1E3[self.script_team + "_launch_boosters_lrg"]) {
      scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_charge_lrg", var_3);
    }
  }
}