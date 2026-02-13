/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2304.gsc
*************************************************/

_id_E002(var_0, var_1, var_2) {
  self._id_1C30._id_5E3A = spawnStruct();
  self._id_1C30._id_5E3A._id_5E36 = "invalid";
  self._id_1C30._id_5E3A._id_F1E8 = 0;
  self._id_1C30._id_426A = spawnStruct();
  self._id_1C30._id_5F3F = 0;
  self._id_1C0C = 1.0;
  self._id_45CB = 59;
  scripts\common\utility::_id_38ED();
  self._id_1C30._id_62EE = spawnStruct();

  if(isDefined(self._id_5D5F)) {
    self thread[[self._id_5D5F]]();
  }

  self._id_5D94 = _id_08F6::_id_780D;
  _id_823B(self._id_1C30._id_1A35);
  _id_812D(var_0);

  if(self._id_1C30._id_1A35 == "juggernaut" || self._id_1C30._id_1A35 == "juggernaut_cp" || self._id_1C30._id_1A35 == "juggernaut_lw") {
    _id_08EF::_id_8133(self._id_1C30._id_1A35);
  } else {
    _id_81A3();
    _id_8134(self._id_1C30._id_1A35);
  }

  if(self _meth_87CE() == "soldier_lw") {
    self._id_0168 = 1;
    self._id_4AC3 = 1;
    self._id_0DDF._id_4AC4 = 1;
  }

  _func_03DB();
  _id_81A1();

  if(self _meth_86EE()) {
    thread _id_8283();
  }

  _id_08F1::_id_D13B();
  var_3 = weaponclass(self._id_04F6);

  if(var_3 == "mg") {
    self._id_010D = "cover_lmg";
  }

  scripts\anim\shared::_id_FD87(var_3);
  var_4 = 200;
  self._id_12AC = spawnStruct();
  self._id_12AC._id_3AAB = var_4 + self getentitynumber() % 100;
  scripts\common\utility::_id_D248(1);
}

_id_8283() {
  self endon("death");
  scripts\engine\utility::_id_5C24("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
  self.has_scriptable_notetrack_handler = 1;
}

_id_823B(var_0) {
  if(!isDefined(anim._id_A57D)) {
    anim._id_A57D = [];
  }

  if(isDefined(anim._id_A57D[var_0])) {
    return;
  }
  _id_823E(var_0);
}

_id_823E(var_0) {
  _id_08F1::_id_823F(var_0);
}

_id_823C(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 90;
  var_1["Cover Right"] = -90;
  var_1["Cover Crouch"] = -90;
  var_1["Cover Stand"] = -90;
  var_1["Cover Stand 3D"] = -90;
  anim._id_A57D[var_0] = var_1;
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim._id_5F44[var_0] = var_1;
  var_2 = [];
  anim._id_A56A[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Right Crouch"] = 90;
  var_1["Cover Left"] = -90;
  anim._id_A575[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim._id_A574[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim._id_5F43[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim._id_5F42[var_0] = var_1;
}

_id_823D(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim._id_A57D[var_0] = var_1;
  var_2 = [];
  var_2["Aim Down"] = 45;
  anim._id_A56A[var_0] = var_2;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim._id_A574[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim._id_A575[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim._id_A56B[var_0] = var_1;
}

_id_812D(var_0) {
  if(!isDefined(level._id_3AAC)) {
    level._id_3AAC = [];
    level._id_5F40 = [];
    level._id_134F = [];
  }

  if(!isDefined(level._id_3AAC[var_0])) {
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_1["exposed_idle"] = var_3;
    var_3 = [];
    var_2["exposed_idle"] = var_3;
    var_3 = [];
    var_3["down"] = 15;
    var_1["cover_crouch_lean"] = var_3;
    var_3 = [];
    var_3["down"] = 15;
    var_2["cover_crouch_lean"] = var_3;
    var_3 = [];
    var_2["cover_crouch_aim"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_1["cover_left_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_2["cover_left_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_1["cover_left_crouch_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_2["cover_left_crouch_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 15;
    var_1["cover_right_lean"] = var_3;
    var_3 = [];
    var_3["down"] = 37;
    var_3["left"] = 24;
    var_2["cover_right_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 25;
    var_1["cover_right_crouch_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 15;
    var_2["cover_right_crouch_lean"] = var_3;
    level._id_3AAC[var_0] = var_1;
    level._id_5F40[var_0] = var_2;
  }

  if(!isDefined(level._id_134F[var_0])) {
    var_4 = [];
    var_4["cover_stand_exposed"] = "cover_stand_exposed";
    var_4["cover_stand_hide_to_exposed"] = "cover_stand_exposed";
    var_4["cover_stand_full_exposed"] = "exposed_idle";
    var_4["cover_stand_hide_to_full_exposed"] = "exposed_idle";
    var_4["cover_stand_to_exposed_idle"] = "exposed_idle";
    var_4["wall_run_exit"] = "exposed_idle";
    var_4["wall_run_continue"] = "exposed_idle";
    var_4["wall_run_left_shoot"] = "exposed_idle";
    var_4["wall_run_right_shoot"] = "exposed_idle";
    var_4["wall_run_attach_left_shoot"] = "exposed_idle";
    var_4["wall_run_attach_right_shoot"] = "exposed_idle";
    var_4["cover_crouch_hide_to_stand"] = "exposed_idle";
    var_4["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_right"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_left"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
    var_4["cover_crouch_aim"] = "cover_crouch_aim";
    var_4["cover_crouch_lean"] = "cover_crouch_lean";
    var_4["cover_crouch_exposed_left"] = "cover_crouch_aim";
    var_4["cover_crouch_exposed_right"] = "cover_crouch_aim";
    var_4["cover_crouch_stand"] = "exposed_idle";
    var_4["cover_crouch_to_exposed_idle"] = "exposed_idle";
    var_4["cover_right_exposed_a"] = "exposed_idle";
    var_4["cover_right_hide_to_a"] = "exposed_idle";
    var_4["cover_right_exposed_b"] = "exposed_idle";
    var_4["cover_right_hide_to_b"] = "exposed_idle";
    var_4["cover_right_a_to_b"] = "exposed_idle";
    var_4["cover_right_b_to_a"] = "exposed_idle";
    var_4["cover_right_crouch_exposed_a"] = "exposed_idle";
    var_4["cover_right_crouch_exposed_b"] = "exposed_idle";
    var_4["cover_right_crouch_hide_to_a"] = "exposed_idle";
    var_4["cover_right_crouch_hide_to_b"] = "exposed_idle";
    var_4["cover_right_crouch_a_to_b"] = "exposed_idle";
    var_4["cover_right_crouch_b_to_a"] = "exposed_idle";
    var_4["cover_right_lean"] = "cover_right_lean";
    var_4["cover_right_hide_to_lean"] = "cover_right_lean";
    var_4["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
    var_4["cover_right_crouch_lean"] = "cover_right_crouch_lean";
    var_4["cover_right_to_exposed_idle"] = "exposed_idle";
    var_4["cover_left_exposed_a"] = "exposed_idle";
    var_4["cover_left_exposed_b"] = "exposed_idle";
    var_4["cover_left_hide_to_a"] = "exposed_idle";
    var_4["cover_left_hide_to_b"] = "exposed_idle";
    var_4["cover_left_a_to_b"] = "exposed_idle";
    var_4["cover_left_b_to_a"] = "exposed_idle";
    var_4["cover_left_hide_to_lean"] = "cover_left_lean";
    var_4["cover_left_lean"] = "cover_left_lean";
    var_4["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
    var_4["cover_left_crouch_lean"] = "cover_left_crouch_lean";
    var_4["cover_left_to_exposed_idle"] = "exposed_idle";
    var_4["cqb_idle"] = "exposed_idle";
    var_4["cqb_stand_loop"] = "exposed_idle";
    var_4["cqb_stand_strafe_loop"] = "exposed_idle";
    var_4["stand_run_strafe_loop"] = "exposed_idle";
    var_4["exposed_reload"] = "exposed_idle";
    var_4["exposed_weaponswitch"] = "exposed_idle";
    var_4["exposed_stand_turn"] = "exposed_idle";
    var_4["exposed_idle"] = "exposed_idle";
    var_4["exposed_prone"] = "exposed_idle";
    var_4["exposed_stand_infantry_reaction"] = "exposed_idle";
    level._id_134F[var_0] = var_4;
  }
}

_id_8134(var_0) {
  if(_func_03A3(var_0)) {
    return;
  }
  if(var_0 == "boss" || var_0 == "boss2") {
    _func_03A2(var_0, "shuffle", 30);
  } else {
    _func_03A2(var_0, "shuffle", 23);
  }

  _func_03A2(var_0, "walk", 56);
  _func_03A2(var_0, "fast", 120);
  _func_03A2(var_0, "jog", 170);
  _func_03A2(var_0, "run", 220);
  _func_03A2(var_0, "sprint", 250);
}

_id_81A1() {
  if(isDefined(anim._id_62EE)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "point_casual";
  var_0[var_0.size] = "point_military";
  var_0[var_0.size] = "yes";
  var_0[var_0.size] = "no";
  var_0[var_0.size] = "hold";
  var_0[var_0.size] = "talk";
  var_0[var_0.size] = "shrug";
  var_0[var_0.size] = "getdown";
  var_0[var_0.size] = "nvg_on";
  var_0[var_0.size] = "nvg_off";
  var_0[var_0.size] = "beckon";
  anim._id_62EE = var_0;
}

_id_81A3() {
  if(!isDefined(anim._id_717F)) {
    anim._id_717F = [];
  }

  if(!isDefined(anim._id_7182)) {
    anim._id_7182 = [];
  }

  var_0 = self._id_1C30._id_1A35 == "soldier_lw";
  var_1 = !var_0;

  if(isDefined(anim._id_717F["soldier"]) && isDefined(anim._id_7182["soldier"])) {
    return;
  }
  anim._id_890D = var_0;
  anim._id_8875 = var_1;
  anim._id_717F["soldier"] = [];
  anim._id_7182["soldier"] = [];
  anim._id_717F["soldier"]["grenade_return_throw"]["throw_short"] = _id_0009::_id_1C57("grenade_return_throw", "throw_short");
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_short"] = [];
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_short"][0] = (82.8191, 11.6735, 28.1425);
  anim._id_717F["soldier"]["grenade_return_throw"]["throw_long"] = _id_0009::_id_1C57("grenade_return_throw", "throw_long");
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_long"] = [];
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_long"][0] = (82.8191, 11.6735, 28.1425);
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_long"][1] = (108.037, 19.9333, 58.7747);
  anim._id_717F["soldier"]["grenade_return_throw"]["throw_default"] = _id_0009::_id_1C57("grenade_return_throw", "throw_default");
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_default"] = [];
  anim._id_7182["soldier"]["grenade_return_throw"]["throw_default"][0] = (108.037, 19.9333, 58.7747);
  anim._id_717F["soldier"]["cover_stand_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_stand_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_exposed"][0] = (12.4289, 10.4494, 63.257);
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_exposed"][1] = (19.6744, -0.861649, 55.6794);
  anim._id_717F["soldier"]["cover_stand_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_stand_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_safe"][0] = (12.4289, 10.4494, 63.257);
  anim._id_7182["soldier"]["cover_stand_grenade"]["grenade_safe"][1] = (19.6744, -0.861649, 55.6794);
  anim._id_717F["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_crouch_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_crouch_grenade"]["grenade_exposed"][0] = (14.4711, 19.9796, 60.7207);
  anim._id_717F["soldier"]["cover_crouch_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_crouch_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_crouch_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_crouch_grenade"]["grenade_safe"][0] = (16.2644, 3.3802, 58.673);
  anim._id_717F["soldier"]["cover_right_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_right_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_right_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_right_grenade"]["grenade_exposed"][0] = (52.7985, -16.1898, 71.2437);
  anim._id_717F["soldier"]["cover_right_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_right_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_right_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_right_grenade"]["grenade_safe"][0] = (23.61, 1.79103, 73.2797);
  anim._id_717F["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_right_crouch_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (52.6922, -11.2103, 74.5468);
  anim._id_717F["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_right_crouch_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (29.3343, -4.89863, 47.8837);
  anim._id_717F["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = _id_0009::_id_1C57("cover_right_crouch_grenade_throw", "grenade_throw");
  anim._id_7182["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = [];
  anim._id_7182["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][0] = (15.5324, 4.86811, 50.6292);
  anim._id_7182["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][1] = (1.17014, -1.57043, 60.0271);
  anim._id_717F["soldier"]["cover_left_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_left_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_left_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_left_grenade"]["grenade_exposed"][0] = (52.9483, -8.80599, 69.6026);
  anim._id_717F["soldier"]["cover_left_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_left_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_left_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_left_grenade"]["grenade_safe"][0] = (29.9023, 0.265982, 33.1921);
  anim._id_717F["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = _id_0009::_id_1C57("cover_left_crouch_grenade", "grenade_exposed");
  anim._id_7182["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
  anim._id_7182["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (70.3568, 6.78523, 61.5581);
  anim._id_717F["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = _id_0009::_id_1C57("cover_left_crouch_grenade", "grenade_safe");
  anim._id_7182["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
  anim._id_7182["soldier"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (24.2908, -7.09458, 21.4564);
  anim._id_717F["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = _id_0009::_id_1C57("cover_left_crouch_grenade_throw", "grenade_throw");
  anim._id_7182["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = [];
  anim._id_7182["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][0] = (0.306949, -4.18872, 12.3224);
  anim._id_7182["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][1] = (-7.34781, 1.87832, 25.0602);
  anim._id_717F["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = _id_0009::_id_1C57("exposed_throw_grenade", "exposed_grenade");
  anim._id_7182["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  anim._id_7182["soldier"]["exposed_throw_grenade"]["exposed_grenade"][0] = (30.5741, 1.97765, 73.9287);
  anim._id_717F["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = _id_0009::_id_1C57("exposed_prone_throw_grenade", "exposed_grenade");
  anim._id_7182["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = [];
  anim._id_7182["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"][0] = (28.3429, 6.4308, 40.3279);
  anim._id_717F["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = _id_0009::_id_1C57("exposed_crouch_throw_grenade", "exposed_grenade");
  anim._id_7182["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = [];
  anim._id_7182["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"][0] = (15.7078, 1.95027, 36.0834);
  anim._id_717F["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = _id_0009::_id_1C57("exposed_crouch_throw_grenade", "exposed_crouch_grenade");
  anim._id_7182["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = [];
  anim._id_7182["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"][0] = (15.7078, 1.95027, 36.0834);
}

_id_A41C(var_0, var_1, var_2, var_3) {
  if(!istrue(self._id_0B67._id_02A9)) {
    return 0;
  }

  var_4 = _id_06BD::_id_23BE();

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = var_4.origin - self.origin;
  var_6 = length(var_5);

  if(var_6 > 80) {
    return 0;
  }

  var_7 = _func_0261(var_5);

  if(_func_043F(var_7 - self.angles[1]) < 90) {
    return 0;
  }

  self._id_481D = var_7;
  return 1;
}

_id_A41D(var_0, var_1, var_2, var_3) {
  if(!_id_0009::_id_1C50(var_0, "abort")) {
    return 0;
  }

  if(!self._id_01B7) {
    return 0;
  }

  var_4 = _func_0261(self._id_027F);
  var_5 = _func_000B(var_4 - self.angles[1]);

  if(abs(var_5) < 50) {
    return 0;
  }

  self._id_481D = var_5;
  return 1;
}

_id_4F46(var_0) {
  self notify("kill_draw_need_to_turn");
  self endon("kill_draw_need_to_turn");

  for(;;) {
    var_1 = self.origin + anglesToForward(self.angles) * 100;
    waitframe();
  }
}

_id_A419(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(_id_06BD::_id_240F()) {
    if(isDefined(self._id_0B67._id_03C8)) {
      var_4 = self._id_0B67._id_03C8;
    } else if(isDefined(self._id_0B67._id_03C3)) {
      var_4 = self._id_0B67._id_03C3.origin;
    }
  }

  if(!isDefined(var_4)) {
    if(isDefined(self._id_03DC)) {
      var_4 = self._id_03DC;
    }
  }

  if(!isDefined(var_4) && !istrue(self._id_0063) && isDefined(self._id_02ED) && self._id_02ED.type == "Exposed" && self._id_010D != "no_cover" && !isDefined(self._id_0192)) {
    var_5 = distancesquared(self._id_02ED.origin, self.origin);

    if(var_5 < 36 || !isDefined(self._id_0323) && var_5 < 225) {
      var_4 = self._id_02ED.origin + anglesToForward(self._id_02ED.angles) * 384;
    }
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_6 = self.angles[1] - _func_0261(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);

  if(var_7 < 65536) {
    var_8 = _func_0218(var_7);

    if(var_8 > 3) {
      var_6 = var_6 + _func_0013(-3 / var_8);
    }
  }

  return abs(_func_000B(var_6)) > self._id_04A9;
}

_id_A41A(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_9BC5) && isDefined(self._id_02ED)) {
    return 0;
  }

  var_4 = _id_6E0C();

  if(abs(var_4) > self._id_04A9) {
    return 1;
  }

  var_5 = _id_6E0A();

  if(abs(var_5) > self._id_B143) {
    return 1;
  }

  return 0;
}

_id_6E0B() {
  if(isDefined(self._id_481D)) {
    return self._id_481D;
  }

  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(_id_06BD::_id_240F()) {
    if(isDefined(self._id_0B67._id_03C8)) {
      var_2 = self._id_0B67._id_03C8;
    } else if(isDefined(self._id_0B67._id_03C3)) {
      var_1 = self._id_0B67._id_03C3;
    }
  } else if(isDefined(self._id_03DC))
    var_2 = self._id_03DC;

  if(!isDefined(var_2) && isDefined(self._id_02ED) && self._id_02ED.type == "Exposed" && distancesquared(self._id_02ED.origin, self.origin) < 36) {
    return _func_000B(self._id_02ED.angles[1] - self.angles[1]);
  }

  if(isDefined(var_1) && !_func_011D(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::_id_6C82(var_0, var_1, var_2);
  return var_3;
}

_id_6E0C() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(_id_06BD::_id_240F()) {
    if(isDefined(self._id_0B67._id_03C3)) {
      var_1 = self._id_0B67._id_03C3;
    } else if(isDefined(self._id_0B67._id_03C8)) {
      var_2 = self._id_0B67._id_03C8;
    }
  } else if(isDefined(self._id_0192))
    var_1 = self._id_0192;

  if(isDefined(var_1) && !_func_011D(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::_id_6C83(var_0, var_1, var_2);
  return var_3;
}

_id_6E0A() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(_id_06BD::_id_240F()) {
    if(isDefined(self._id_0B67._id_03C3)) {
      var_1 = self._id_0B67._id_03C3;
    } else if(isDefined(self._id_0B67._id_03C8)) {
      var_2 = self._id_0B67._id_03C8;
    }
  } else if(isDefined(self._id_0192))
    var_1 = self._id_0192;

  if(isDefined(var_1) && !_func_011D(var_1)) {
    var_0 = 1.5;
  }

  var_3 = scripts\engine\utility::_id_6C81(var_0, var_1, var_2);
  return var_3;
}

_id_3639(var_0, var_1, var_2) {
  var_3 = _id_6E0B();

  if(var_3 < 0) {
    var_4 = "right";
  } else {
    var_4 = "left";
  }

  var_3 = abs(var_3);
  var_5 = 0;

  if(var_3 > 157.5) {
    var_5 = 180;
  } else if(var_3 > 112.5) {
    var_5 = 135;
  } else if(var_3 > 67.5 || !istrue(self._id_15DD)) {
    var_5 = 90;
  } else {
    var_5 = 45;
  }

  var_6 = var_4 + "_" + var_5;
  var_7 = _id_0009::_id_1C7D(var_1, var_6);
  return var_7;
}

_id_363A(var_0, var_1, var_2) {
  var_3 = _id_6E0C();
  var_4 = _id_6E0A();

  if(abs(var_3) > self._id_04A9 && abs(var_3) > abs(var_4)) {
    if(var_3 < 0) {
      var_5 = "right";
    } else {
      var_5 = "left";
    }

    var_3 = abs(var_3);
    var_6 = 0;

    if(var_3 > 157.5) {
      var_6 = 180;
    } else if(var_3 > 112.5) {
      var_6 = 135;
    } else if(var_3 > 67.5) {
      var_6 = 90;
    } else {
      var_6 = 45;
    }

    var_7 = var_5 + "_" + var_6;
    var_8 = _id_0009::_id_1C7D(var_1, var_7);
    return var_8;
  } else {
    if(var_4 < 0) {
      var_5 = "up";
    } else {
      var_5 = "down";
    }

    var_4 = abs(var_4);
    var_6 = 0;

    if(var_4 > 157.5) {
      var_6 = 180;
    } else if(var_4 > 112.5) {
      var_6 = 135;
    } else if(var_4 > 67.5) {
      var_6 = 90;
    } else {
      var_6 = 45;
    }

    var_7 = var_5 + "_" + var_6;
    var_8 = _id_0009::_id_1C7D(var_1, var_7);
    return var_8;
  }
}

_id_35E2(var_0, var_1, var_2) {
  var_3 = _id_6E0B();

  if(var_3 < -135) {
    var_4 = "2r";
  } else if(var_3 > 135) {
    var_4 = "2l";
  } else if(var_3 < 0) {
    var_4 = "6";
  } else {
    var_4 = "4";
  }

  var_5 = _id_0009::_id_1C7D(var_1, var_4);
  return var_5;
}

_id_C30F(var_0, var_1, var_2) {
  var_3 = self._id_1C30._id_C31C;
  self._id_1C30._id_C31C = undefined;

  if(!isDefined(self.weaponinfo)) {
    return;
  }
  var_4 = isDefined(var_3) && isDefined(self._id_04F6) && var_3 == self._id_04F6;

  if(!isDefined(var_3)) {
    var_3 = self._id_04F6;
  }

  var_5 = getcompleteweaponname(var_3);

  if(!isDefined(self.weaponinfo[var_5])) {
    return;
  }
  if(!_id_0009::_id_1C50(var_0, "drop clip")) {
    return;
  }
  if(self.weaponinfo[var_5]._id_FE32) {
    var_6 = _func_00EE(var_3);

    if(isDefined(var_6)) {
      var_7 = _id_0009::_id_1C50(var_0, "attach clip left") || _id_0009::_id_1C50(var_0, "attach clip right");
      var_8 = _id_0009::_id_1C50(var_0, "detach clip left") || _id_0009::_id_1C50(var_0, "detach clip right") || _id_0009::_id_1C50(var_0, "detach clip nohand");

      if(!var_7) {
        self notify("abort_reload");
      } else if(var_7 && !var_8) {
        if(_id_0009::_id_1C50(var_0, "attach clip left")) {
          self.weaponinfo[var_5].clipattachedleft = undefined;
          var_9 = "tag_accessory_left";
        } else {
          self.weaponinfo[var_5].clipattachedright = undefined;
          var_9 = "tag_accessory_right";
        }

        self detach(var_6, var_9);
        self notify("clip_detached");

        if(var_4) {
          scripts\anim\shared::_id_DCFE(var_5);
        }
      }
    }
  }
}

_id_F095(var_0, var_1, var_2) {
  self._id_0355 = 1;
  var_3 = _id_06BD::_id_23C7();

  if(isDefined(var_3) && var_3 != "prone") {
    self _meth_80E9(0.5);
  }
}

_id_B831(var_0, var_1, var_2) {
  self._id_0355 = 0;
  _id_B830(var_0, var_1, var_2);
}

_id_B830(var_0, var_1, var_2) {
  _id_08F1::_id_D13B();
  var_3 = self _meth_85CE(var_0);

  if(isDefined(var_3) && (var_3 == "stand_run_loop" || var_3 == "move_walk_loop" || var_3 == "patrol_move" || var_3 == "cqb_stand_loop")) {
    childthread _id_08F1::_id_D8CE(var_1, 0.2);
  }

  if(isDefined(self._id_02ED)) {
    self._id_0B67._id_90B5 = self._id_02ED;
  }

  if(self.team != "allies") {
    thread _id_5880(var_1);
  }

  _id_0009::_id_1C81(var_0, var_1, 1.0);
}

_id_B82E(var_0, var_1, var_2) {
  _id_B830(var_0, var_1, var_2);
}

_id_B82F(var_0, var_1, var_2) {
  self._id_134E = 1;
  _id_B830(var_0, var_1, var_2);
}

_id_B82D(var_0, var_1, var_2) {
  self._id_134E = 1;
  _id_B82E(var_0, var_1, var_2);
}

_id_F094(var_0, var_1, var_2) {
  self._id_134E = 0;
}

_id_F093(var_0, var_1, var_2) {
  self._id_134E = 0;
}

_id_5880(var_0) {
  self endon(var_0 + "_finished");
  var_1 = _id_06C5::_id_6597();
  var_2 = var_1 * var_1;

  for(;;) {
    waitframe();
    var_3 = undefined;

    if(isDefined(self._id_6A2E)) {
      var_3 = [[self._id_6A2E]]();
    } else {
      var_3 = _id_6A2D();
    }

    if(isDefined(var_3)) {
      var_4 = distancesquared(self.origin, var_3.origin);

      if(var_4 < var_2) {
        self _meth_8251("face enemy");
      } else {
        self _meth_8251("face current");
      }

      continue;
    }

    self _meth_8251("face current");
  }
}

_id_F092(var_0, var_1, var_2) {}

_id_DB57() {
  return isDefined(_id_6A2D());
}

_id_6A2D() {
  if(isDefined(self._id_0323)) {
    return undefined;
  }

  if(isDefined(self._id_0192) && isPlayer(self._id_0192) && self _meth_8067(self._id_0192)) {
    return self._id_0192;
  }

  return undefined;
}

_id_B34A(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_06BD::_id_23C9();
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = scripts\anim\combat_utility::_id_59BD();
  self _meth_85ED(var_1, var_4, var_5);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_1, var_4));
  _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  self notify("switched_to_sidearm");
  _id_06D7::_id_4979();
}

_id_F08A(var_0, var_1, var_2) {
  var_3 = weaponclass(self._id_04F6);
  scripts\anim\shared::_id_FD87(var_3);
}

_id_B912(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_BE4F();
  _id_06D7::_id_4979();
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);

  if(scripts\engine\utility::_id_0F78() && isDefined(self._id_0192)) {
    self _meth_8251("face enemy");
  } else {
    self _meth_8251("face angle 3d", self.angles);
  }

  if(isDefined(self._id_02ED)) {
    self _meth_8019("angle deltas");
  } else {
    self _meth_8019("zonly_physics");
  }

  _id_0009::_id_1C8E(var_0, var_1, var_4);
  self._id_E83A = _func_000B(_func_0077(var_4, 0, 1) + self.angles[1]);
  self._id_04C2 = 1;
  var_5 = 1;
  self _meth_85ED(var_1, var_3, var_5);

  if(_id_DB57()) {
    thread _id_B914(var_4, var_1);
  }

  _id_0009::_id_1C45(var_0, var_1);
}

_id_B914(var_0, var_1) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_2 = self._id_0192;
  var_2 endon("death");
  var_3 = _func_0079(var_0);

  if(_func_0011(var_0, "start_aim")) {
    var_4 = _func_00BB(var_0, "start_aim");
    var_3 = var_3 * var_4[0];
  } else if(_func_0011(var_0, "finish")) {
    var_4 = _func_00BB(var_0, "finish");
    var_3 = var_3 * var_4[0];
  }

  var_5 = int(var_3 * 20);
  var_6 = var_5;

  while(var_6 > 0) {
    var_7 = 1 / var_6;
    var_8 = scripts\engine\utility::_id_6EA0(var_2.origin);
    self._id_E83A = _func_000B(self.angles[1] + var_8);
    var_9 = self _meth_85F7(var_0);
    var_10 = _func_0077(var_0, var_9, 1.0);
    var_11 = _func_000B(var_8 - var_10);
    self _meth_8251("face angle", _func_000A(self.angles[1] + var_11 * var_7));
    var_6--;
    wait 0.05;
  }
}

_id_B913(var_0, var_1, var_2) {
  self._id_04C2 = 0;
  self._id_E83A = undefined;
  self._id_481D = undefined;
  _id_B9E1();

  if(istrue(self._id_0272)) {
    _id_F083(var_0, var_1, var_2);
  }
}

_id_DBDD(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23E5()) {
    return 0;
  }

  if(!_id_08F1::_id_876A()) {
    return 0;
  }

  if(!isDefined(self._id_02ED)) {
    return 0;
  }

  if(isDefined(self._id_034C) && scripts\anim\utility_common::_id_8AD4() && weaponclass(self._id_034C) != "mg") {
    return 0;
  }

  return _id_08F1::_id_8764(var_0, var_1, var_2, var_3);
}

_id_41F1(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(!isDefined(self._id_02ED)) {
    return var_4 == "Exposed Crouch";
  }

  if(distance2dsquared(self.origin, self._id_02ED.origin) > 225) {
    if(_id_06BD::_id_23C7() == "stand") {
      return var_4 == "Exposed";
    } else {
      return var_4 == "Exposed Crouch";
    }
  }

  if(isDefined(self._id_0B67._id_0382)) {
    return self._id_0B67._id_0382 == var_3;
  } else {
    return _id_08F1::_id_8764(var_0, var_1, var_2, var_3);
  }
}

_id_C317(var_0) {
  scripts\anim\notetracks::_id_A604(var_0);
  return undefined;
}

_id_0368(var_0, var_1, var_2) {
  self endon("reload_terminate");
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);

  if(weaponclass(self._id_04F6) == "pistol") {
    self _meth_8251("face enemy");
  }

  self _meth_85ED(var_1, var_3);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self._id_1C30._id_C31C = self._id_04F6;
  _id_0009::_id_1C8E(var_0, var_1, var_4);
  _id_0009::_id_1C45(var_0, var_1, ::_id_C317);
}

_id_D9FA(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_1 + "_timeout";
  var_5 = var_1 + "_timeout_end";
  childthread _id_08F2::_id_DA1A(var_4, var_5, var_3);
  self endon(var_4);
  var_6 = _func_0011(var_2, "fire");
  var_7 = weaponclass(self._id_04F6) == "rocketlauncher";
  var_8 = _func_0079(var_2);
  var_9 = [];

  if(var_6) {
    var_10 = _func_00BB(var_2, "fire");

    if(var_10.size == 1 && var_10[0] == 0) {
      var_6 = 0;
    } else {
      var_9[0] = var_8 * var_10[0];

      for(var_11 = 1; var_11 < var_10.size; var_11++) {
        var_12 = var_8 * var_10[var_11];
        var_12 = var_12 - var_9[var_11 - 1];
        var_9[var_11] = var_12;
      }
    }
  }

  var_13 = 0;
  var_14 = self._id_0B67._id_03CA;
  var_15 = var_14 == 1 || self._id_0B67._id_03CC == "semi";
  var_16 = isPlayer(self._id_0192) && self._id_0192 _meth_854E();
  var_17 = scripts\anim\utility_common::_id_10D12();
  var_15 = 1;
  var_18 = 0;

  while(var_13 < var_14 && var_14 > 0) {
    if(var_6) {
      if(var_9[var_18] > 0) {
        wait(var_9[var_18]);
      }

      var_18 = (var_18 + 1) % var_9.size;
    }

    if(!self._id_00CC) {
      break;
    }

    _id_08F2::_id_DA22(var_15);

    if(var_16) {
      if(randomint(3) == 0) {
        self._id_00CC--;
      }
    } else
      self._id_00CC--;

    if(var_7) {
      self._id_037B--;

      if(weaponclass(self._id_04F6) == "rocketlauncher" && self tagexists("tag_rocket")) {
        self hidepart("tag_rocket");
      }
    }

    var_13++;

    if(var_17) {
      childthread _id_08F2::_id_DA16(var_1);
    }

    if(self._id_0B67._id_03C4 && var_13 == var_14) {
      break;
    }

    if(!var_6 || var_14 == 1 && self._id_0B67._id_03CC == "single") {
      self waittillmatch(var_1, "end");
    }
  }

  self notify(var_5);
}

_id_DA14() {
  var_0 = self._id_0B67._id_03CA;
  var_1 = 2;

  if(self._id_0B67._id_03CC == "single" || var_0 == 1 && self._id_0B67._id_03CC != "rack") {
    var_0 = 1;
    var_1 = 2;
  } else if(self._id_0B67._id_03CC == "semi") {
    var_1 = 3;

    if(var_0 == 1) {
      var_1 = 2;
    } else if(var_0 > 5) {
      var_0 = 5;
    }
  } else if(self._id_0B67._id_03CC == "mg") {
    var_1 = 2;
    var_0 = 1;
  } else if(self._id_0B67._id_03CC == "rack" && self._id_0131 != "prone")
    var_1 = 5;
  else if(istrue(self._id_4E6C)) {
    var_1 = 4;
    var_0 = 7;
  } else {
    var_1 = 4;

    if(var_0 > 6) {
      var_0 = 6;
    }
  }

  self _meth_86EF(var_1, var_0);
}

_id_D9F9() {
  self _meth_86EF(0, 0);
}

_id_DA01(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0B67._id_03BF = 0;
  self._id_0B67._id_D9FF = 1;
  self._id_0B67._id_D9F7 = undefined;
  var_3 = self._id_04F6.classname;

  if(isDefined(self._id_10D1F) && isDefined(self._id_10D1F[var_3])) {
    var_4 = self._id_04F6._id_00EB;
    var_5 = self._id_10D1F[var_3].minpercentcliptofire;
    var_6 = self._id_10D1F[var_3].maxpercentcliptofire;

    if(var_5 > var_6) {}

    var_7 = randomfloatrange(var_5, var_6);
    self._id_0B67._id_03D0 = int(var_4 * var_7);
  }

  if(var_3 == "beam") {
    self _meth_8546();
  }

  if(scripts\anim\utility_common::_id_8766(1)) {
    _id_06C1::_id_AB9D();
  }

  self _meth_841C();
  var_8 = _id_0009::_id_1C5C(var_0, var_1);
  var_9 = _id_0009::_id_1C6E(var_1, var_8);
  var_10 = scripts\engine\utility::ter_op(scripts\anim\utility_common::_id_10D12(), 3, 2);

  if(self _meth_8646(var_0)) {
    _id_DA14();
    _id_08F2::_id_D9FB(var_0, var_1, var_9, var_10, "shoot_additive_fire");
  } else {
    _id_D9F9();

    if(isagent(self)) {
      _id_D9FA(var_0, var_1, var_9, var_10);
    } else {
      var_11 = _id_08F2::_id_DA02();
      self _meth_831D(var_1, var_9, 1, 0.2, var_11);
      _id_08F2::_id_D9FB(var_0, var_1, var_9, 2);
    }
  }

  self._id_0B67._id_03C6--;

  if(!_id_08F2::_id_DA3B()) {
    _id_08F2::_id_DA17(0.05);
  }

  _id_0009::_id_1C53(var_0, "shoot_finished");

  if(scripts\anim\utility_common::_id_8766(1)) {
    _id_06C1::_id_AB9E();
  }

  if(_func_0278(self._id_04F6)) {
    var_12 = self _meth_85CC(self._id_1C30._id_1A35);

    if(_id_0009::_id_1C72(var_12 + "_rechamber", self._id_04F6.basename)) {
      self._id_0B67._id_0364 = 1;
    }
  }
}

_id_DA12(var_0, var_1, var_2) {
  thread _id_08F2::_id_7425(var_0, var_1);

  if(_id_06BD::_id_23E5()) {
    return;
  }
  self._id_2C4F = 1;
  _id_0009::_id_1C83(var_0, var_1, var_2);
}

_id_35B7(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_04F6.basename);
}

_id_0364(var_0, var_1, var_2, var_3) {
  return istrue(self._id_0B67._id_0364);
}

_id_B8C6(var_0, var_1, var_2) {
  self._id_0B67._id_0364 = 0;
  self endon(var_1 + "_finished");
  var_3 = _id_0009::_id_1C5C(var_0, var_1);
  self _meth_85ED(var_1, var_3, 1.5);
  _id_0009::_id_1C8E(var_0, var_1, _id_0009::_id_1C6E(var_1, var_3));
  var_4 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));

  if(var_4 == "code_move") {
    var_4 = _id_0009::_id_1C45(var_0, var_1, _id_0009::_id_1C6A(var_0, var_1));
  }
}

_id_DB4E(var_0, var_1, var_2, var_3) {
  if(!_id_DBDF(var_0, var_1, var_2, var_3)) {
    return 1;
  }

  return 0;
}

_id_DBDF(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common::_id_8766()) {
    return 0;
  }

  if(_id_06C1::_id_8A42()) {
    return 0;
  }

  return 1;
}

_id_DBDE(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common::_id_8766()) {
    return _id_08F2::_id_DB09(var_0, var_1, var_2, var_3);
  }

  if(_id_06C1::_id_8A42()) {
    return 0;
  }

  if(!_id_08F2::_id_DB09(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  return 1;
}

_id_DBC1(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_0408)) {
    self._id_02E2 = 0;
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(isDefined(self._id_0192._id_04B9) && self._id_0192._id_04B9 == "civilian") {
    return 0;
  }

  if(!istrue(self._id_02E2) && !istrue(self._id_5EB4)) {
    return 0;
  }

  if(isDefined(self._id_02E4) && gettime() - self._id_02E4 > 1000) {
    self._id_5EB4 = undefined;
    return 0;
  }

  if(istrue(self._id_00DA)) {
    if(isDefined(level._id_3322) && gettime() < level._id_3322) {
      return 0;
    }

    level._id_3322 = gettime() + 5000;
  }

  return 1;
}

_id_DB0F(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_00DA) && istrue(self._id_0272)) {
    var_4 = _id_DBC1(var_0, var_1, var_2, var_3);

    if(istrue(var_4)) {
      self _meth_84C0(2);
      return 1;
    }
  }

  return 0;
}

_id_F088(var_0, var_1, var_2) {
  self._id_02E2 = 0;
  self._id_5EB4 = undefined;
  self._id_E83A = undefined;
  _id_B9E1();

  if(istrue(self._id_0272)) {
    _id_F083(var_0, var_1, var_2);
  }
}

_id_F089(var_0, var_1, var_2) {
  _id_F088(var_0, var_1, var_2);
  _id_08F4::_id_3931(var_0, var_1, var_2);
}

_id_6B76(var_0) {
  var_0 = _func_000B(var_0);

  if(var_0 > 135 || var_0 < -135) {
    var_1 = 2;
  } else if(var_0 < -45) {
    var_1 = 4;
  } else if(var_0 > 45) {
    var_1 = 6;
  } else {
    var_1 = 8;
  }

  return var_1;
}

_id_6B77() {
  var_0 = 0;
  var_1 = self _meth_8204(self._id_0192);
  var_2 = var_1 - self.origin;

  if(_func_0134(var_2) < 36) {
    var_0 = 0;
  } else {
    var_3 = _func_0261(var_2);
    var_0 = self.angles[1] - var_3;
  }

  return _id_6B76(var_0);
}

_id_6B75() {
  var_0 = _id_6B77();
  var_1 = "" + var_0;
  return var_1;
}

_id_35B0(var_0, var_1, var_2) {
  var_3 = _id_6B75();
  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_5882(var_0, var_1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_2 = 0.25;
    var_3 = _func_000B(var_1 - self.angles[1]);
    self _meth_8251("face angle", self.angles[1] + var_3 * var_2);
    waitframe();
  }
}

_id_7448(var_0, var_1, var_2) {
  if(var_1 == "face_goal") {
    var_3 = var_2 - self.origin;
    var_4 = _func_0261(var_3);
    thread _id_5882(var_0, var_4);
    return 1;
  }

  return 0;
}

_id_B334(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_BE4F();
  var_3 = self _meth_85C8(var_0, var_1);
  var_4 = _id_0009::_id_1C6E(var_1, var_3);
  self _meth_85ED(var_1, var_3);
  var_5 = self _meth_8204(self._id_0192);
  thread _id_B914(var_4, var_1);
  _id_0009::_id_1C4A(var_0, var_1, ::_id_7448, var_5);

  if(isDefined(self._id_0192) && self _meth_8067(self._id_0192)) {
    self._id_036A = gettime() + 2000;
  }
}

_id_35C9(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C61();

  if(_id_0009::_id_1C73(var_3, "idle")) {
    var_4 = _id_0009::_id_1C62(var_3, "idle");

    if(_func_0107(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(isDefined(self._id_02ED) && self._id_02ED.type == "Cover Stand") {
    if(!self._id_02ED scripts\engine\utility::_id_8AE7("over")) {
      var_2 = var_2 + "_high";
    }
  }

  if(istrue(self._id_FDA8)) {
    var_2 = var_2 + "_interior";

    if(!istrue(self._id_0B67._id_7595)) {
      var_2 = var_2 + "_intro";
      self._id_0B67._id_7595 = 1;
    }
  }

  return _id_08F1::_id_35C2(var_0, var_1, var_2);
}

_id_35B6(var_0, var_1, var_2) {
  var_3 = _id_0009::_id_1C63("player_pushed", "player_pushed");
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = _func_000B(var_5[1] - self.angles[1]);
  var_7 = _id_08FC::_id_10FE8(var_6);
  var_8 = "pushed_" + var_7;
  var_9 = _id_0009::_id_1C7D(var_1, var_8);
  return var_9;
}

_id_F098(var_0, var_1, var_2) {
  self._id_0B67._id_7595 = undefined;
}

_id_DB7E(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_0272)) {
    if(_id_A419(var_0, var_1, var_2, var_3)) {
      return 0;
    }

    if(isDefined(self._id_0192)) {
      var_4 = self.angles[1] - _func_0261(self._id_0192.origin - self.origin);

      if(abs(_func_000B(var_4)) > 75) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_DB7F(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_0272)) {
    _id_F083(var_0, var_1, var_3);
    return 1;
  }

  return 0;
}

_id_F083(var_0, var_1, var_2) {
  self _meth_87CF(self _meth_87CD("default"));
  self _meth_87CC("casual_killer", 0, 1);
  self._id_02E2 = 0;
  self._id_5EB4 = undefined;
  self notify("leaveCasualKiller");
  self._id_0272 = 0;
  self._id_00DA = 0;
  self _meth_8309();
}

_id_DB2C(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_4AA4)) {
    return 0;
  }

  if(isDefined(self._id_4C5E) && gettime() < self._id_4C5E) {
    return 0;
  }

  if(istrue(self._id_01C2)) {
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(!_func_011D(self._id_0192)) {
    return 0;
  }

  if(!self _meth_81E9() && self _meth_8069()) {
    return 0;
  }

  if(!self _meth_8067(self._id_0192)) {
    return 0;
  }

  self._id_4C5E = gettime() + randomintrange(4000, 7000);
  self._id_4C5B = "4";
  var_4 = _id_0009::_id_1C5C(var_0, var_2);
  var_5 = _id_0009::_id_1C6E(var_2, var_4);
  var_6 = _func_00B0(var_5, 0, 1);
  self._id_4C5B = "6";
  var_4 = _id_0009::_id_1C5C(var_0, var_2);
  var_5 = _id_0009::_id_1C6E(var_2, var_4);
  var_7 = _func_00B0(var_5, 0, 1);
  var_6 = rotatevector(var_6, self.angles);
  var_7 = rotatevector(var_7, self.angles);
  var_8 = self.origin - self._id_0192.origin;
  var_9 = _func_030A(var_8, self._id_0192.angles);
  var_10 = _func_000B(var_9[1] - self._id_0192.angles[1]);

  if(abs(var_10) > 4) {
    return 0;
  }

  if(var_10 > 0) {
    if(_id_34F4(var_7)) {
      self._id_4C5B = "6";
      return 1;
    }
  } else if(_id_34F4(var_6)) {
    self._id_4C5B = "4";
    return 1;
  }

  return 0;
}

_id_34F4(var_0) {
  var_1 = self.origin + var_0;

  if(!self _meth_81C6(var_1)) {
    return 0;
  }

  if(!_func_02A8(self.origin, var_1, self)) {
    return 0;
  }

  var_2 = self _meth_86A9();
  var_3 = var_2 + var_0;

  if(!_func_0202(var_2, var_3, 1, self)) {
    return 0;
  }

  if(isai(self._id_0192) && !isbot(self._id_0192)) {
    var_4 = self._id_0192 _meth_86A9();
  } else {
    var_4 = self._id_0192 getEye();
  }

  if(!_func_0202(var_3, var_4, 0, undefined)) {
    return 0;
  }

  return 1;
}

_id_35AA(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_4C5B);
}

_id_BE4F() {
  if(isDefined(self._id_0212)) {
    self._id_E740 = self._id_0212;
  }

  self._id_0212 = "disable";
}

_id_B9E1() {
  if(isDefined(self._id_E740)) {
    self._id_0212 = self._id_E740;
    self._id_E740 = undefined;
  } else
    self._id_0212 = undefined;
}