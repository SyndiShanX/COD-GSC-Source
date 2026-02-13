/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2346.gsc
*************************************************/

_id_9127(var_0) {
  _id_8131(var_0);
  var_1 = [];
  var_1[0] = [0, 1];
  var_1[1] = [4, 5];
  var_1[2] = [2];
  var_1[3] = [3];
  _id_0929::_id_7E25("infil_lbravo", var_0, 6, 4, var_1, ::_id_912A, ::_id_9124, ::_id_B535);
}

_id_912A(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstruct(var_1, "targetname");
  var_4 = spawn("script_origin", var_3.origin);
  var_4.angles = var_3.angles;
  var_4._id_CBC0 = var_3;

  if(isDefined(var_3.target)) {
    var_4._id_AEC7 = scripts\engine\utility::getstruct("lbravoAlphaAdvancedPath", "targetname");
  }

  var_4 thread _id_7E7B(var_0, var_2);
  level._id_7E5D = var_4;
  return var_4;
}

_id_9124(var_0) {
  if(isDefined(self._id_AEC7)) {
    var_1 = _id_AE74();
    var_1 = var_1 + _func_0079(level._id_CC31["slot_0"]["lbravo_infil_" + var_0 + "_loop_exit"]);
    var_1 = var_1 + _func_0079(level._id_CC31["slot_0"]["lbravo_infil_" + var_0 + "_exit"]);
    return var_1;
  } else {
    var_2 = _func_0079(level._id_CC31["slot_0"]["lbravo_infil_" + var_0]);
    var_2 = var_2 + _func_0079(level._id_CC31["slot_0"]["lbravo_infil_" + var_0 + "_exit"]);
    return var_2;
  }
}

_id_B535(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);

  if(isPlayer(self)) {
    self _meth_82FA("lbravo_infil_intro", 1);
  }

  thread _id_B4F7(var_0);
  thread _id_0736::_id_7E51("slot_" + var_1, "viewhands_base_iw8");
  self._id_B5A4._id_10D19 = _id_0736::_id_74B5;
  self._id_B5A4 linkto(var_0._id_9515, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self _meth_8282(var_0._id_9515.origin);
  self _meth_8577("80_instant");
  self _meth_84AC("safe", "iw8_ges_demeanor_safe_heli");
  thread _id_0736::_id_7E58(0.0, 0.55, "fade_up");
  thread _id_B628();
  scripts\engine\utility::_id_10888(level, "start_scene", var_0, "start_scene");

  if(isDefined(self.team) && self.team != "spectator") {
    self _meth_867F("iw8_cp_intro_outro");
    self setplayermusicstate("cp_lbravo_infil");
  }

  self._id_85A8 = 1;
  self notify("open_loadout_menu");
  self notify("fade_up");
  self _meth_8638("disabled");

  if(isDefined(var_0._id_AEC7)) {
    thread _id_B7F8(var_0, var_1);
  } else {
    thread _id_B7F7(var_0, var_1);
  }

  self _meth_8577("default");
}

_id_B7F8(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(var_1 == 0) {
    self _meth_820B(1, 0.25, 0.25, 10, 45, 45, 30);
  } else if(var_1 == 1) {
    self _meth_820B(1, 0.25, 0.25, 45, 10, 45, 30);
  } else {
    self _meth_820B(1, 0.25, 0.25, 45, 45, 45, 30);
  }

  _id_C82F(var_0);
  self _meth_820B(1, 0.25, 0.25, 0, 0, 0, 0);
  self _meth_8577("default_2seconds");
  self _meth_8209(1, 2);
  self _meth_8655();
  self _meth_8638("iw8_playermotion_mp");
  self._id_B5A4 unlink();
  self._id_85A8 = undefined;
  self notify("player_finished_infil");
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  self _meth_84AC("normal");
  self _meth_8656();
  _id_0736::_id_EDC4();
  self _meth_8680("iw8_cp_intro_outro");
  var_0 notify("prematch_over");
  level notify("prematch_over");
}

_id_C82F(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0._id_9515 endon("unload");

  for(;;) {
    var_0._id_9515 thread _id_0706::_id_17FD(self, self._id_B5A4, "lbravo_infil_" + var_0._id_EAC7 + "_loop", "origin_animate_jnt");
    wait 10;
  }
}

_id_B7F7(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  self _meth_820B(1, 0.25, 0.25, 30, 30, 30, 30);
  var_0._id_9515 _id_0706::_id_17FD(self, self._id_B5A4, "lbravo_infil_" + var_0._id_EAC7, "origin_animate_jnt");
  self _meth_820B(1, 0.25, 0.25, 0, 0, 0, 0);
  self._id_B5A4 unlink();
  self _meth_84AC("normal");
  self _meth_8656();
  _id_0736::_id_EDC4();
  self _meth_8680("iw8_cp_intro_outro");
  var_0 notify("prematch_over");
  level notify("prematch_over");
  thread _id_CF96();
  thread _id_38E2();
  self visionsetnakedforplayer("", 0.75);
  self _meth_84AC("normal");
  self _meth_8639();
}

_id_CF96() {
  waitframe();
  self notify("complete_late_infil_allows");
}

_id_38E2() {
  wait 1;
  self _meth_8078(2);
}

_id_B4F7(var_0) {
  self endon("disconnect");
  scripts\engine\utility::_id_10888(level, "prematch_over", var_0, "prematch_over");
  self notify("remove_rig");
  self _meth_8078(1.0);
  scripts\mp\utility\player::_id_D51E();
}

_id_B628() {
  level endon("prematch_over");
  scripts\engine\utility::_id_108C5("death", "disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self _meth_8078(0.0);
    self _meth_8577("default");
    self _meth_83AD(0, 0, 18);
    scripts\mp\utility\player::_id_D51E();
  }
}

_id_7E7B(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in getEntArray("infil_delete", "script_noteworthy")) {
    var_3 delete();
  }

  thread _id_10357(var_0, self._id_CBC0, var_1);
  thread _id_0F80(var_0, self._id_CBC0, var_1);
  scripts\engine\utility::_id_10888(level, "infil_started", self, "infil_started");
  setDvar("#x345d28610c3b32a7f", 1);
  level notify("start_scene");
  self notify("start_scene");
  var_5 = _id_9124(var_1);
  wait(var_5);
  scripts\engine\utility::_id_10888(level, "prematch_over", self, "prematch_over");
  setDvar("#x345d28610c3b32a7f", 0);

  while(isDefined(self._id_9515) || isDefined(self._id_0F7F)) {
    waitframe();
  }

  self delete();
}

_id_10357(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self._id_9515 = _id_E301(var_1, var_0, var_2);

  if(isDefined(self._id_AEC7)) {
    thread _id_1035A(var_0, var_1, var_2, var_3);
  } else {
    thread _id_10358(var_0, var_1, var_2, var_3);
  }
}

_id_10358(var_0, var_1, var_2, var_3) {
  _id_06C6::_id_17C2(self._id_9515, "lbravo_infil_" + var_2);
  scripts\engine\utility::_id_10888(level, "infil_started", self, "infil_started");
  thread _id_06C6::_id_1845(self._id_9515, "lbravo_infil_" + var_2);
  var_4 = _func_0079(level._id_CC31[self._id_9515._id_18AF]["lbravo_infil_" + var_2]);
  wait(var_4);
  self._id_9515 delete();
  self._id_9515 = undefined;
}

_id_E301(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;

  if(isDefined(self._id_AEC7)) {
    var_3 = self._id_AEC7.origin;
    var_4 = self._id_AEC7.angles;
  }

  var_5 = _func_0216("veh8_mil_air_lbravo_personnel_cp", var_2, "lbravo_infil_cp", var_3, var_4);
  var_5 _meth_83A6(var_1);
  var_5._id_18AF = "lbravo";
  var_5 setCanDamage(0);
  var_5 setscriptablepartstate("engine", "on", 0);
  var_5._id_7E24 = self;

  if(isDefined(level._id_E16C)) {
    level thread[[level._id_E16C]](var_5);
  }

  return var_5;
}

_id_0F80(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self._id_0F7F = thread _id_E25B(var_0, var_2, var_3);
  self._id_0F7F[0]._id_17FE = ::_id_3ADB;
  self._id_9515 _id_06C6::_id_17BF(self._id_0F7F, "lbravo_infil_" + var_2, "origin_animate_jnt");
  _id_0A94::_id_78E2();
  scripts\engine\utility::_id_10888(level, "infil_started", self, "infil_started");
  _id_0A94::_id_DC7E();

  if(isDefined(self._id_AEC7)) {
    _id_0F82(var_0, var_1, var_2, var_3);
  } else {
    _id_0F81(var_0, var_1, var_2, var_3);
  }
}

_id_0F82(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_9123)) {
    level thread[[level._id_9123]](self);
  } else {
    _id_0F83(self);
  }
}

_id_0F83(var_0) {
  var_0 thread _id_0F7D(var_0._id_0F7F[0]);
  var_0 thread _id_0F7D(var_0._id_0F7F[1]);
}

_id_0F7D(var_0) {
  _id_0F7C(var_0);
  self._id_9515 _id_06C6::_id_1845(var_0, "lbravo_infil_" + self._id_EAC7 + "_loop_exit", "origin_animate_jnt");
}

_id_0F7C(var_0) {
  self._id_9515 endon("unload");

  for(;;) {
    self._id_9515 _id_06C6::_id_1845(var_0, "lbravo_infil_" + self._id_EAC7 + "_loop", "origin_animate_jnt");
  }
}

_id_0F81(var_0, var_1, var_2, var_3) {
  self._id_9515 thread _id_06C6::_id_183B(self._id_0F7F, "lbravo_infil_" + var_2, "origin_animate_jnt");
  var_4 = _func_0079(level._id_CC31["pilot"]["lbravo_infil_" + var_2]);
  wait(var_4);

  foreach(var_6 in self._id_0F7F) {
    var_6 delete();
  }

  self._id_0F7F = undefined;
}

_id_E25B(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = self._id_9515 _id_E0CE("pilot", "origin_animate_jnt", "allied_pilot_fullbody_1");
  var_3[var_3.size] = self._id_9515 _id_E0CE("copilot", "origin_animate_jnt", "allied_pilot_fullbody_2");

  foreach(var_5 in var_3) {
    var_5._id_7E24 = self;
  }

  return var_3;
}

_id_E0CE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("script_model", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkto(var_5, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_5._id_75DA = var_6;
    var_5 thread scripts\engine\utility::_id_472E(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkto(var_5, "j_gun", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::_id_472E(var_7);
    var_5._id_04F6 = var_7;
  }

  var_5._id_18AF = var_0;
  var_5 _id_06C6::_id_D47B();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::_id_472E(var_5);
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

_id_8131(var_0) {
  _id_CDBD(var_0);
  _id_1032C(var_0);
  _id_06C6::_id_10F1("slot_0", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_1", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_2", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_3", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_4", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_5", "free_look", _id_0A94::_id_B47E, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_0", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_1", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_2", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_3", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_4", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_5", "free_look", _id_0A94::_id_B47E, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_0", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_1", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_2", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_3", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_4", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_5", "fov_80_instant", _id_0A94::_id_B479);
  _id_06C6::_id_10F1("slot_0", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_1", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_2", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_3", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_4", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_5", "fov_63_2", _id_0A94::_id_B47C);
  _id_06C6::_id_10F1("slot_0", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_1", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_2", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_3", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_4", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_5", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_alpha");
  _id_06C6::_id_10F1("slot_0", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_1", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_2", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_3", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_4", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_5", "shake_on", _id_0A94::_id_2FEC, "lbravo_infil_bravo");
  _id_06C6::_id_10F1("slot_0", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_1", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_2", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_3", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_4", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_5", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_alpha_exit");
  _id_06C6::_id_10F1("slot_0", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_1", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_2", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_3", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_4", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
  _id_06C6::_id_10F1("slot_5", "shake_off", _id_0A94::_id_2FED, "lbravo_infil_bravo_exit");
}

#using_animtree("script_model");

_id_CDBD(var_0) {
  switch (var_0) {
    case "alpha":
      level._id_CC34["pilot"] = #animtree;
      level._id_CC31["pilot"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_pilot;
      level._id_CC32["pilot"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_pilot";
      level._id_CC34["pilot"] = #animtree;
      level._id_CC31["pilot"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_pilot_loop;
      level._id_CC32["pilot"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_pilot_loop";
      level._id_CC34["pilot"] = #animtree;
      level._id_CC31["pilot"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_pilot_loop_exit;
      level._id_CC32["pilot"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_pilot_loop_exit";
      level._id_CC34["copilot"] = #animtree;
      level._id_CC31["copilot"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_copilot;
      level._id_CC32["copilot"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_copilot";
      level._id_CC34["copilot"] = #animtree;
      level._id_CC31["copilot"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_a_copilot_loop;
      level._id_CC32["copilot"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_a_copilot_loop";
      level._id_CC34["copilot"] = #animtree;
      level._id_CC31["copilot"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_copilot_loop_exit;
      level._id_CC32["copilot"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_copilot_loop_exit";
      level._id_CC34["slot_0"] = #animtree;
      level._id_CC31["slot_0"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy1_wm;
      level._id_CC32["slot_0"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy1_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_alpha"] = "infil_lbravo_a_1";
      level._id_CC31["slot_0"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy1_exit_wm;
      level._id_CC32["slot_0"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy1_exit_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_1";
      level._id_CC31["slot_0"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy1_wm;
      level._id_CC32["slot_0"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy1_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_1";
      level._id_CC31["slot_0"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
      level._id_CC32["slot_0"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_1";
      level._id_CC34["slot_1"] = #animtree;
      level._id_CC31["slot_1"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy2_wm;
      level._id_CC32["slot_1"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy2_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_alpha"] = "infil_lbravo_a_2";
      level._id_CC31["slot_1"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy2_exit_wm;
      level._id_CC32["slot_1"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy2_exit_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_2";
      level._id_CC31["slot_1"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy2_wm;
      level._id_CC32["slot_1"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy2_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_2";
      level._id_CC31["slot_1"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
      level._id_CC32["slot_1"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_2";
      level._id_CC34["slot_2"] = #animtree;
      level._id_CC31["slot_2"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy3_wm;
      level._id_CC32["slot_2"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy3_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_alpha"] = "infil_lbravo_a_3";
      level._id_CC31["slot_2"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy3_exit_wm;
      level._id_CC32["slot_2"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy3_exit_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_3";
      level._id_CC31["slot_2"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy3_wm;
      level._id_CC32["slot_2"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy3_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_3";
      level._id_CC31["slot_2"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
      level._id_CC32["slot_2"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_3";
      level._id_CC34["slot_3"] = #animtree;
      level._id_CC31["slot_3"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy4_wm;
      level._id_CC32["slot_3"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy4_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_alpha"] = "infil_lbravo_a_4";
      level._id_CC31["slot_3"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy4_exit_wm;
      level._id_CC32["slot_3"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy4_exit_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_4";
      level._id_CC31["slot_3"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy4_wm;
      level._id_CC32["slot_3"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy4_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_4";
      level._id_CC31["slot_3"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
      level._id_CC32["slot_3"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_4";
      level._id_CC34["slot_4"] = #animtree;
      level._id_CC31["slot_4"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy5_wm;
      level._id_CC32["slot_4"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy5_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_alpha"] = "infil_lbravo_a_5";
      level._id_CC31["slot_4"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy5_exit_wm;
      level._id_CC32["slot_4"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy5_exit_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_5";
      level._id_CC31["slot_4"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy5_wm;
      level._id_CC32["slot_4"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy5_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_5";
      level._id_CC31["slot_4"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
      level._id_CC32["slot_4"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_5";
      level._id_CC34["slot_5"] = #animtree;
      level._id_CC31["slot_5"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_guy6_wm;
      level._id_CC32["slot_5"]["lbravo_infil_alpha"] = "mp_infil_lbravo_a_guy6_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_alpha"] = "infil_lbravo_a_6";
      level._id_CC31["slot_5"]["lbravo_infil_alpha_exit"] = % mp_infil_lbravo_b_guy6_exit_wm;
      level._id_CC32["slot_5"]["lbravo_infil_alpha_exit"] = "mp_infil_lbravo_b_guy6_exit_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_alpha_exit"] = "infil_lbravo_b_exit_6";
      level._id_CC31["slot_5"]["lbravo_infil_alpha_loop"] = % mp_infil_lbravo_b_guy6_wm;
      level._id_CC32["slot_5"]["lbravo_infil_alpha_loop"] = "mp_infil_lbravo_b_guy6_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_alpha_loop"] = "infil_lbravo_b_6";
      level._id_CC31["slot_5"]["lbravo_infil_alpha_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
      level._id_CC32["slot_5"]["lbravo_infil_alpha_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_alpha_loop_exit"] = "infil_lbravo_a_loop_exit_6";
      break;
    case "bravo":
      level._id_CC34["pilot"] = #animtree;
      level._id_CC31["pilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_pilot;
      level._id_CC32["pilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_pilot";
      level._id_CC34["copilot"] = #animtree;
      level._id_CC31["copilot"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_copilot;
      level._id_CC32["copilot"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_copilot";
      level._id_CC34["slot_0"] = #animtree;
      level._id_CC31["slot_0"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy1_wm;
      level._id_CC32["slot_0"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy1_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_bravo"] = "infil_lbravo_b_1";
      level._id_CC31["slot_0"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy1_exit_wm;
      level._id_CC32["slot_0"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy1_exit_wm";
      level._id_CC3B["slot_0"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_1";
      level._id_CC34["slot_1"] = #animtree;
      level._id_CC31["slot_1"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy2_wm;
      level._id_CC32["slot_1"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy2_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_bravo"] = "infil_lbravo_b_2";
      level._id_CC31["slot_1"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy2_exit_wm;
      level._id_CC32["slot_1"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy2_exit_wm";
      level._id_CC3B["slot_1"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_2";
      level._id_CC34["slot_2"] = #animtree;
      level._id_CC31["slot_2"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy3_wm;
      level._id_CC32["slot_2"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy3_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_bravo"] = "infil_lbravo_b_3";
      level._id_CC31["slot_2"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy3_exit_wm;
      level._id_CC32["slot_2"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy3_exit_wm";
      level._id_CC3B["slot_2"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_3";
      level._id_CC34["slot_3"] = #animtree;
      level._id_CC31["slot_3"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy4_wm;
      level._id_CC32["slot_3"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy4_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_bravo"] = "infil_lbravo_b_4";
      level._id_CC31["slot_3"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy4_exit_wm;
      level._id_CC32["slot_3"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy4_exit_wm";
      level._id_CC3B["slot_3"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_4";
      level._id_CC34["slot_4"] = #animtree;
      level._id_CC31["slot_4"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy5_wm;
      level._id_CC32["slot_4"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy5_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_bravo"] = "infil_lbravo_b_5";
      level._id_CC31["slot_4"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy5_exit_wm;
      level._id_CC32["slot_4"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy5_exit_wm";
      level._id_CC3B["slot_4"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_5";
      level._id_CC34["slot_5"] = #animtree;
      level._id_CC31["slot_5"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_guy6_wm;
      level._id_CC32["slot_5"]["lbravo_infil_bravo"] = "mp_infil_lbravo_b_guy6_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_bravo"] = "infil_lbravo_b_6";
      level._id_CC31["slot_5"]["lbravo_infil_bravo_exit"] = % mp_infil_lbravo_b_guy6_exit_wm;
      level._id_CC32["slot_5"]["lbravo_infil_bravo_exit"] = "mp_infil_lbravo_b_guy6_exit_wm";
      level._id_CC3B["slot_5"]["lbravo_infil_bravo_exit"] = "infil_lbravo_b_exit_6";
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

_id_1032C(var_0) {
  switch (var_0) {
    case "alpha":
      level._id_CC34["lbravo"] = #animtree;
      level._id_CC31["lbravo"]["lbravo_infil_alpha"] = % mp_infil_lbravo_a_heli;
      break;
    case "bravo":
      level._id_CC34["lbravo"] = #animtree;

      switch (getDvar("#x376847958d67972ef")) {
        case "mp_runner":
          level._id_CC31["lbravo"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_heli_runner;
          break;
        default:
          level._id_CC31["lbravo"]["lbravo_infil_bravo"] = % mp_infil_lbravo_b_heli;
          break;
      }

      break;
  }
}

_id_3ADB(var_0, var_1, var_2) {
  foreach(var_4 in self._id_7E24.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

_id_1035A(var_0, var_1, var_2, var_3) {
  level waittill("infil_started");
  self._id_9515 endon("death");
  self._id_9515._id_F96E = 116;
  self._id_9515._id_F977 = 3.5;
  self._id_9515 _id_1022D(self._id_AEC7);
  thread _id_70E1(self._id_9515);
}

_id_10302(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self _meth_83DC(var_0);

  for(var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname"); isDefined(var_1); var_1 = scripts\engine\utility::getstruct(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self _meth_8438(0, 30, 30);

  for(var_2 = self _meth_842E(); var_2 > 1; var_2 = self _meth_842E()) {
    wait 0.1;
  }
}

_id_70E1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0._id_75B8)) {
    return;
  } else {
    var_0._id_75B8 = 1;
  }

  var_0 scripts\engine\utility::_id_0393();
  var_0 notify("start_vehiclepath");
  var_0 notify("start_dynamicpath");
}

_id_1022D(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self._id_1D83 = var_0;
  }

  var_3 = self._id_1D83;
  self._id_41D8 = self._id_1D83;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    _id_775D(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = _id_6645(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7._id_0399)) {
      _id_D280(var_7);
    }

    _id_775D(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self._id_41D8 = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7._id_0394)) {
      self delete();
      return;
    }

    if(isDefined(var_7._id_CD81)) {
      self _meth_83BC(var_7._id_CD81);

      if(var_7._id_CD81 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7._id_CE7D)) {
      self._id_CE7D = var_7._id_CE7D;
    }

    if(isDefined(var_7._id_CEA5)) {
      self notify("unload");
      scripts\engine\utility::_id_108F5("unloaded", self._id_F977);
      level notify("players_unloaded_from_infil");
    }

    if(self _meth_8434()) {
      if(isDefined(var_7._id_CE19)) {
        self._id_04D6 = var_7._id_CE19;
      }
    }

    if(isDefined(var_7._id_CD4B)) {
      scripts\engine\utility::_id_5C24(var_7._id_CD4B);

      if(isDefined(var_7._id_CCFF)) {
        wait(var_7._id_CCFF);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_D281)) {
      self._id_D281 = undefined;
      self _meth_807E();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_CEAE)) {
    self delete();
  }
}

_id_775D(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0._id_CEA5) || isDefined(var_0._id_CD9A)) {
    var_3 = 0;

    if(isDefined(var_0._id_CD9A)) {
      scripts\engine\utility::_id_5474("landed");

      if(isDefined(self._id_F970)) {
        var_3 = self._id_F970;
      }
    } else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96E))
      var_3 = self._id_F96E;
    else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96F)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self._id_F96F) {
        var_3 = self._id_F96F;
      } else if(isDefined(self._id_F96D) && var_3 < self._id_F96D) {
        var_3 = self._id_F96D;
      }
    }

    var_0._id_0359 = 2;

    if(isDefined(var_0._id_71A9)) {
      var_0.origin = var_0._id_71A9 + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1._id_CC8F;
    var_7 = var_1.speed;
    var_8 = var_1._id_CC89;
    var_9 = var_1._id_CCF6;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0._id_CE6F) && var_0._id_CE6F;
  var_11 = isDefined(var_0._id_CEA5);
  var_12 = isDefined(var_0._id_CD4B) && !scripts\engine\utility::_id_5C00(var_0._id_CD4B);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0._id_0393);

  if(isDefined(var_0.angles)) {
    var_15 = var_0.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2)) {
    var_16 = (var_16[0], var_16[1], var_16[2] + var_2);
  }

  if(isDefined(self._id_77BE)) {
    var_16 = (var_16[0], var_16[1], self._id_77BE);
  }

  self _meth_8433(var_16, var_7, var_8, var_9, var_0._id_CD77, var_0._id_CC9C, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0._id_0359)) {
    self setneargoalnotifydist(var_0._id_0359);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  } else
    self waittill("goal");

  if(isDefined(var_0._id_CD49)) {
    level notify(var_0._id_CD49);
  }

  if(isDefined(var_0._id_CD42)) {
    if(!isDefined(level._id_7785)) {}

    thread[[level._id_7785]](var_0);
  }

  var_0 scripts\engine\utility::_id_0393();

  if(isDefined(self._id_AEC9)) {
    scripts\engine\utility::_id_4794(var_0);
  }

  self notify("continuepath");
}

_id_6645(var_0) {
  var_1 = ::_id_64B8;

  if(isDefined(var_0.target)) {
    if(isDefined(_id_64B6(var_0.target))) {
      var_1 = ::_id_64B6;
    }

    if(isDefined(_id_64B7(var_0.target))) {
      var_1 = ::_id_64B7;
    }
  }

  return var_1;
}

_id_64B8(var_0) {
  return _func_00E5(var_0, "targetname");
}

_id_64B7(var_0) {
  return scripts\engine\utility::getstruct(var_0, "targetname");
}

_id_64B6(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

_id_D280(var_0) {
  var_1 = getent(var_0._id_0399, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self._id_D281 = 1;
}

_id_AE74() {
  if(!isDefined(self._id_AEC7)) {
    return 0.0;
  }

  if(isDefined(self._id_AEDA)) {
    return self._id_AEDA;
  }

  self._id_AEDA = 0.0;
  var_0 = self._id_AEC7;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0._id_CEA5)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed)) {
      var_1 = var_0.speed;
    }

    var_4 = 17.6;
    self._id_AEDA = self._id_AEDA + var_3 * 1.8 / (var_1 * var_4);
    var_0 = var_2;
  }

  return self._id_AEDA;
}