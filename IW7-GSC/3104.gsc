/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3104.gsc
***************************************/

func_7598(var_00) {
  if(!isDefined(self.fx)) {
    self.fx = spawnStruct();
  }

  scripts\sp\utility::func_75CE();

  if(isDefined(var_00) && var_00) {
    thread func_13D7D();
  }
}

func_13D7D() {
  self endon("entitydeleted");
  wait 0.05;
  func_0BDC::func_A19F();
}

func_A3B4(var_00) {
  if(!isDefined(var_00)) {
    var_00 = self.spaceship_mode;
  }

  func_A3B7(var_00);
}

func_A3B7(var_00, var_01) {
  if(!level.func_241D) {
    if(var_00 == "hover") {
      var_00 = "hover_space";
    } else if(var_00 == "fly") {
      var_00 = "fly_space";
    }
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.func_615D) && self.func_615D.func_619D) {
    return;
  }
  if(isDefined(self.fx.state) && self.fx.state == var_00) {
    return;
  }
  self notify("notify_change_fx_state");
  self endon("notify_change_fx_state");
  self endon("entitydeleted");

  if(isDefined(var_01)) {
    wait(var_01);
  }

  if(isDefined(self.fx.func_552E)) {
    self thread[[self.fx.func_552E]]();
  }

  self.fx.func_552E = undefined;

  switch (var_00) {
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

  self.fx.state = var_00;
}

func_23A9() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle_space", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_23A8;
}

func_23A8() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle_space", var_01);
  }
}

func_2399() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle", var_01, 0, "notify_change_fx_state");
  }

  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustCenter", "tag_vtol_center", 0, "notify_change_fx_state");
  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustSide", "tag_vtol_left", 0, "notify_change_fx_state");
  scripts\sp\utility::func_75C4(self.script_team + "_vtolThrustSide", "tag_vtol_right", 0, "notify_change_fx_state");
  func_13913();
  self.fx.func_552E = ::func_2398;
}

func_2398() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle", var_01);
  }

  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustCenter", "tag_vtol_center");
  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustSide", "tag_vtol_left");
  scripts\sp\utility::func_75F8(self.script_team + "_vtolThrustSide", "tag_vtol_right");
  func_13912();
}

func_5B7D() {
  self endon("entitydeleted");
  var_00 = 3;

  while(var_00 > 0) {
    var_00 = var_00 - 0.05;
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
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustMax", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_11131;
}

func_11131() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustMax", var_01);
  }
}

func_11143() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustMax_space", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_11142;
}

func_11142() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustMax_space", var_01);
  }
}

func_11136() {
  self.fx.func_552E = ::func_11135;
}

func_11135() {}

func_239F() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustIdle", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_239E;
}

func_239E() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustIdle", var_01);
  }
}

func_AA78() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_med", var_01, 0, "notify_change_fx_state");
  }

  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_lrg", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_AA77;
}

func_AA77() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_med", var_01);
  }

  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_lrg", var_01);
  }
}

func_AA79() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_med", var_01, 0, "notify_change_fx_state");
  }

  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_lrg", var_01, 0, "notify_change_fx_state");
  }
}

func_2CAF() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75C4(self.script_team + "_rearThrustBoost", var_01, 0, "notify_change_fx_state");
  }

  self.fx.func_552E = ::func_2CAE;
}

func_2CAE() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_rear_thrusters"]) {
    scripts\sp\utility::func_75F8(self.script_team + "_rearThrustBoost", var_01);
  }
}

func_A7CC() {
  self.fx.func_552E = ::func_A7CB;
}

func_A7CB() {}

func_AA92() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
    playFX(scripts\engine\utility::getfx(self.script_team + "_rearThrustLaunch_panels_blow_med"), self gettagorigin(var_01), anglesToForward(self gettagangles(var_01)), anglestoup(self gettagangles(var_01)));
  }
}

func_AA91() {
  foreach(var_01 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
    playFX(scripts\engine\utility::getfx(self.script_team + "_rearThrustLaunch_panels_blow_med"), self gettagorigin(var_01), anglesToForward(self gettagangles(var_01)), anglestoup(self gettagangles(var_01)));
  }
}

func_AA67(var_00) {
  var_01 = "stop_launch_charge_med";
  self notify(var_01);

  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(var_00) {
    foreach(var_03 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
      scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_charge_lrg", var_03, 0, var_01);
    }
  } else {
    foreach(var_03 in level.func_A1E3[self.script_team + "_launch_boosters_med"]) {
      scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_charge_lrg", var_03);
    }
  }
}

func_AA66(var_00) {
  var_01 = "stop_launch_charge_lrg";
  self notify(var_01);

  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(var_00) {
    foreach(var_03 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
      scripts\sp\utility::func_75C4(self.script_team + "_rearThrustLaunch_charge_lrg", var_03, 0, var_01);
    }
  } else {
    foreach(var_03 in level.func_A1E3[self.script_team + "_launch_boosters_lrg"]) {
      scripts\sp\utility::func_75A0(self.script_team + "_rearThrustLaunch_charge_lrg", var_03);
    }
  }
}