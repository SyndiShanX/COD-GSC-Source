/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\exfil.gsc
*************************************************/

_id_5724() {
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

_id_AAD8(var_0, var_1, var_2, var_3) {
  level._id_6A1C = var_1;
  level._id_AAD5 = var_2;
  level._id_AAD7 = var_3;
  level._id_5722 = getent(var_0 + "_exfil_trigger", "targetname");
  level._id_572B = 1;

  if(isDefined(level._id_AAD9)) {
    [[level._id_AAD9]]();
  }

  if(isDefined(level._id_A8E8) && level._id_A8E8.size > 0) {
    thread _id_C471();
  }

  level.ignorescoring = 1;
  scripts\mp\gamelogic::resumetimer();
  level._id_E72D = gettime();
  level._id_4B0D = 0;
  level._id_F25E = 0;
  var_4 = level._id_5719 + level._id_5720;
  var_5 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
  level._id_10AD4[var_5]._id_04CB = var_4;
  level._id_AD6A[var_5] = var_4;
  _id_CA35(var_0, var_3);
}

_id_C471() {
  foreach(var_1 in level._id_A8E8) {
    if(isDefined(var_1._id_A908)) {
      var_1 _id_07D6::_id_C300();
    }

    if(isDefined(var_1.trigger) && isDefined(var_1.trigger._id_A908)) {
      var_1.trigger _id_07D6::_id_C300();
    }
  }
}

_id_CA35(var_0, var_1) {
  level thread scripts\mp\hud_message::_id_A6B6("callout_exfil_winners", "callout_exfil_losers", var_0);
  level thread _id_E2E2(var_0);
  level thread _id_E2E1(var_0);
  _id_0A8D::_id_9136("enemy_exfil", scripts\mp\utility\game::_id_6BE2(var_0)[0], "status");
  _id_0A8D::_id_9136("friendly_exfil", var_0, "status");
  level._id_F21A = 0;
  wait 1;
  level._id_ABC0 = ::_id_AADB;
}

_id_E2E1(var_0) {
  var_1 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_numlives");
  level._id_10AD4[var_1]._id_04CB = 1;
  level._id_AD6A[var_1] = 1;
  level notify("extract_players_spawned");
  level thread scripts\mp\hud_message::_id_FCBF(var_0, 8, 7);
}

_id_DDB0() {
  self notify("abort_killcam");
  self._id_315D = 1;
  waitframe();
  thread scripts\mp\playerlogic::_id_E337(0, 1);

  if(scripts\mp\utility\game::_id_8A95() && isDefined(level._id_C7F4[self.guid])) {
    level._id_C7F4[self.guid]._id_103C2 thread _id_081F::_id_C536(level._id_C7F4[self.guid]._id_103C2.guid);
  }
}

_id_E2E2(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(!isDefined(level._id_5722)) {
    var_2 = getEntArray("flag_primary", "targetname");
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3[var_3.size] = var_2[var_4];
    }

    foreach(var_6 in var_3) {
      if(var_6._id_CD99 == "_b") {
        var_6._id_CD99 = "_b";
        level._id_5722 = var_6;

        if(!isDefined(level._id_5722)) {
          level notify("exfil_continue_game_end");
          return;
        }
      }
    }
  }

  level._id_5721 = spawn("script_model", level._id_5722.origin);
  level._id_5721.angles = (0, 270, 0);
  level._id_5721.team = var_1;
  level._id_5721._id_1041A = "any";
  level._id_5721._id_ADAE = var_1;
  level._id_5721.type = "";
  var_8 = level._id_5722.origin;
  var_9 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(level._id_5721.origin + (0, 0, 20), level._id_5721.origin - (0, 0, 4000), var_10, var_9, 0);

  if(isPlayer(var_11["entity"])) {
    var_11["entity"] = undefined;
  }

  if(isDefined(var_11)) {
    var_12 = randomfloat(360);
    var_13 = var_11["position"];

    if(isDefined(self._id_1042D)) {
      var_13 = var_13 + self._id_1042D;
    }

    var_14 = (cos(var_12), sin(var_12), 0);
    var_14 = vectornormalize(var_14 - var_11["normal"] * vectordot(var_14, var_11["normal"]));
    var_15 = vectortoangles(var_14);
    level._id_5721.origin = var_13;
    level._id_5721 setModel("cop_marker_scriptable");
    level._id_5721 setscriptablepartstate("marker", "red");
    level._id_5721 playLoopSound("mp_flare_burn_lp");
  }

  level._id_5722 thread _id_708F(self);
  level._id_5728 = _id_07F9::_id_C57D(99);

  if(level._id_5728 != -1) {
    var_16 = "current";
    _id_07F9::_id_A867(level._id_5728, var_16, level._id_5722.origin + (0, 0, 60));
    _id_07F9::_id_A8B1(level._id_5728, 1);
    _id_07F9::_id_A8B2(level._id_5728, 1);
    _id_07F9::_id_A8A2(level._id_5728);
    self._id_DCFF = 1;
  }

  level._id_5721 _id_07D6::_id_D61B("icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil", level._id_5728);
  _func_0174(level._id_5728, 1);
  level thread _id_10B10(var_0);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level._id_5721, "tag_origin");
}

_id_708F(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  level waittill("extract_trigger_active");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0.team == level._id_5721.team && !istrue(var_0._id_5817)) {
      level thread _id_AADA(var_0);
    }
  }
}

_id_10B10(var_0) {
  level endon("game_ended");
  level thread _id_CA36(var_0);
  level thread _id_CA37(var_0);
  var_1 = level._id_5719;
  wait(var_1);
  level._id_5727 = 0;
  level notify("extract_trigger_active");
  level._id_5721 _id_07D6::_id_D61B("icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level._id_5728);
}

_id_CA36(var_0) {
  level endon("game_ended");
  level._id_5727 = 1;
  var_1 = level._id_5F3A;
  var_2 = var_1 * 1000;
  var_3 = level._id_5719;
  var_3 = var_3 * 1000;
  var_4 = var_2;

  while(level._id_5727) {
    if(var_4 != 0) {
      var_5 = min(var_4 / var_3, 1);
      _id_07F9::_id_A8B6(self._id_5728, undefined);
      _id_07F9::_id_A8C4(self._id_5728, 1);
      _id_07F9::_id_A8B4(self._id_5728, var_5);
      var_4 = min(var_4 + var_2, var_3);
    }

    waitframe();
  }

  _id_0A8D::_id_9136("exfilarrive_enemy", scripts\mp\utility\game::_id_6BE2(var_0)[0], "status");
  _id_0A8D::_id_9136("exfilarrive_friendly", var_0, "status");
}

_id_CA37(var_0) {
  level endon("game_ended");
  level waittill("extract_trigger_active");
  level._id_5718 = 1;
  var_1 = level._id_5F3A;
  var_2 = var_1 * 1000;
  var_3 = level._id_5720;
  var_3 = var_3 * 1000;
  var_4 = var_3 - var_2;

  while(level._id_5718) {
    var_5 = var_4 / var_3;
    _id_07F9::_id_A8B6(self._id_5728, scripts\mp\utility\game::_id_6BE2(var_0)[0]);
    _id_07F9::_id_A8C4(self._id_5728, 1);
    _id_07F9::_id_A8B4(self._id_5728, var_5);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  _id_0A8D::_id_9136("exfilend_enemy", scripts\mp\utility\game::_id_6BE2(var_0)[0], "status");
  _id_0A8D::_id_9136("exfilend_friendly", var_0, "status");
}

_id_EC39(var_0, var_1) {
  level waittill("extract_players_spawned");
  var_2 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(var_2 != "tie") {
    foreach(var_4 in level.players) {
      if(var_4.team == var_2) {
        var_4 takeallweapons();
        var_4 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
        var_4 thread _id_EC38(var_1);
        var_4 scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
      }
    }
  }
}

_id_EC38(var_0) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0) {
    waitframe();
  }
}

_id_AADB() {
  level._id_5718 = 0;

  if(level._id_5718) {
    level notify("exfil_continue_game_end");
  }
}

_id_AADA(var_0) {
  level endon("game_ended");
  var_0._id_5817 = 1;
  var_0._id_E355 = 1;
  var_0 _id_07EA::_id_D5E2(var_0, 1000, undefined, 0);
  var_0 scripts\mp\playeractions::_id_C23B("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
  var_0 scripts\mp\playeractions::_id_1596("exfil_success", 0);
  var_0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_1 = spawn("script_origin", var_0.origin);
  var_1 setModel("tag_origin");
  var_0 playerlinkto(var_1);
  var_1 moveto(var_1.origin + (0, 0, 10000), 5, 2, 2);
}

_id_E947(var_0) {
  wait(var_0);
  self._id_5718 = 0;
}

_id_1D1C(var_0, var_1, var_2) {
  wait(var_1 + randomint(10));
  var_3 = level.players[0] scripts\mp\gametypes\br_extract_chopper::_id_E2E3(self, self.origin, var_0, 10 + var_1);
  var_3 playLoopSound("br_exfil_lbravo_engine_temp");
  var_4 = getent("clip64x64x256", "targetname");
  var_5 = spawn("script_model", var_3 gettagorigin("tag_origin"));
  var_5 dontinterpolate();
  var_5.angles = (-90, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = anglesToForward(var_3.angles * (1, 0, 0));
  var_7 = vectornormalize(var_6) * 85;
  var_5 linkto(var_3, "tag_origin", var_7 + (0, 0, -60), var_5.angles);
  var_3._id_3A68 = var_5;
  var_3 sethoverparams(5, 10, 5);
  self._id_36B0[self._id_36B0.size] = var_3;
  var_3._id_5849 = self;

  if(!isDefined(var_2)) {
    var_2 = self.team;
  }

  var_3.team = var_2;
  var_3._id_572A = 6;
  var_3._id_AE9D[0] = self;
  var_3._id_AE9D[1] = self;
  var_3._id_AE9D[2] = self;
  var_3._id_AE9D[3] = self;
  var_3._id_AE9D[4] = self;
  var_3._id_AE9D[5] = self;
  self._id_4140 = self.origin;
  self._id_A97E = (0, 0, 30);
  var_3 _id_80EF();
  thread _id_2CA8(var_3);
  var_3._id_CBC0 = undefined;
  var_8 = undefined;
  var_3 thread _id_5729(var_2, var_3._id_CBC0, var_8);
}

_id_3FCC() {
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), self._id_103BE, "tag_origin");
}

_id_5729(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self._id_0F7F = thread _id_E2E0(var_0, var_2, var_3);
  _id_06C6::_id_17BF(self._id_0F7F, "lbravo_exfil", "origin_animate_jnt");
  _id_0A94::_id_78E2();
  _id_0A94::_id_DC7E();

  if(isDefined(self._id_AEC7)) {
    _id_571D(var_0, var_1, var_2, var_3);
  } else {
    _id_571C(var_0, var_1, var_2, var_3);
  }
}

_id_571D(var_0, var_1, var_2, var_3) {
  thread _id_571B(self._id_0F7F[0]);
  thread _id_571B(self._id_0F7F[1]);
}

_id_571B(var_0) {
  _id_571A(var_0);
  _id_06C6::_id_1845(var_0, "lbravo_exfil_loop_exit", "origin_animate_jnt");
}

_id_571A(var_0) {
  self endon("unload");

  for(;;) {
    _id_06C6::_id_1845(var_0, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

_id_571C(var_0, var_1, var_2, var_3) {
  thread _id_06C6::_id_183B(self._id_0F7F, "lbravo_exfil", "origin_animate_jnt");
  var_4 = _func_0079(level._id_CC31["pilot"]["lbravo_exfil"]);
  wait(var_4);

  foreach(var_6 in self._id_0F7F) {
    var_6 delete();
  }

  self._id_0F7F = undefined;
}

_id_E2E0(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = _id_5714("pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a");
  var_3[var_3.size] = _id_5714("copilot", "origin_animate_jnt", "fullbody_ppilot_crew_a");

  foreach(var_5 in var_3) {
    var_5._id_7E24 = self;
  }

  return var_3;
}

_id_5714(var_0, var_1, var_2, var_3, var_4) {
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

_id_2CA8(var_0) {
  level scripts\engine\utility::_id_108B4("exfil_continue_game_end", "exfil_on_nuke_arrival");
  _id_07F9::_id_C799(self._id_5721._id_5728);
  thread _id_5EB0(var_0);
  var_0 thread _id_5725(var_0.origin);
}

_id_5EB0(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1.team == self._id_5721.team && !istrue(var_1._id_5817)) {
      var_1 thread _id_B659(var_0);
      var_0._id_572A--;

      if(var_0._id_572A <= 0) {
        break;
      }
    }
  }
}

_id_572E(var_0, var_1, var_2) {
  if(!isDefined(self._id_572A)) {
    self._id_572A = 6;
  }

  if(self._id_572A > 0) {
    _id_B70F(var_0, self, self._id_572A);
    thread _id_4AD7(var_0, var_1, var_2);
    self._id_572A--;
  } else {
    thread _id_5725();
    _id_07F9::_id_C799(self._id_5849._id_5721._id_5728);
  }
}

_id_1082B(var_0) {
  var_1 = level._id_EF6A[var_0.team]["players"];

  foreach(var_3 in var_1) {
    if(var_3 != var_0) {
      var_3 thread scripts\mp\utility\print::_id_F8D0("MP_INGAME_ONLY/GET_ON_CHOPPER", 10);
      continue;
    }

    var_3 thread scripts\mp\utility\print::_id_F8D0("MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10);
  }

  wait 10;
  thread _id_5725(undefined, 1);
}

_id_4AD7(var_0, var_1, var_2) {
  foreach(var_4 in self._id_8396) {
    var_4 disableplayeruse(var_0);
  }

  if(isDefined(var_2)) {
    var_0 thread _id_5252(var_1, self, var_2);
  }
}

_id_5252(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("tag_origin");
  var_3 linkto(self);
  var_3 sethintstring(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var_3 setcursorhint("HINT_NOICON");
  var_3 _meth_84D4(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 _meth_84D9("hide");
  var_3 setuseholdduration("duration_short");
  var_3 thread _id_570C(var_1, self, var_0, var_2);
  var_1._id_5786 = var_3;
}

_id_570C(var_0, var_1, var_2, var_3) {
  _id_99E0(var_1);

  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1 _meth_8655();
    var_0 _id_07AA::_id_17FD(var_1, var_1._id_B5A4, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var_1._id_B5A4 unlink();
    var_1 unlink();
    var_3 _id_99E1(var_0.team);

    foreach(var_5 in var_0._id_8396) {
      var_5 _meth_80E0(var_1);
    }

    var_0 notify("unloaded");
    self delete();
  }
}

_id_B70F(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0._id_5817 = 1;
  var_0._id_E355 = 1;
  var_0 _id_07EA::_id_D5E2(var_0, 1000, undefined, 0);
  var_0 thread scripts\mp\hud_message::showsplash("callout_exfil_success");

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_0 playerlinkto(var_1, "tag_passenger" + var_2, 1.0, 180, -180, 180, 180, 0);
}

_id_B659(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0._id_AE9D.size; var_2++) {
      if(var_0._id_AE9D[var_2] == var_0._id_5849) {
        var_0._id_AE9D[var_2] = self;
        var_1 = var_2;
      }
    }

    var_0 thread _id_4AD7(self);
  }

  thread _id_0A21::_id_7E51("slot_" + var_1, "viewhands_base_iw8");
  self._id_B5A4 linkto(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
    case 0:
      self _meth_820B(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self _meth_820B(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self _meth_820B(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self _meth_820B(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self _meth_820B(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("game_ended");
  self._id_5817 = 1;
  self._id_E355 = 1;
  _id_07EA::_id_D5E2(self, 1000, undefined, 0);
  _id_C82F(var_0);
}

_id_C82F(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0 endon("unload");

  while(isDefined(var_0)) {
    var_0 _id_07AA::_id_17FD(self, self._id_B5A4, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

_id_5725(var_0, var_1) {
  if(isDefined(self._id_5786)) {
    self._id_5786 makeunusable();
  }

  thread scripts\mp\gametypes\br_extract_chopper::_id_9592();
  _id_B35D(self.team, "extract_littlebird_leaving_a_friendly", 10);
  thread _id_4C82();

  if(isDefined(level._id_AAD5)) {
    self[[level._id_AAD5]](var_0);
  }

  if(isDefined(var_1)) {
    _id_10868(self.team);
  }
}

_id_10868(var_0) {
  wait 5;
  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["objective_completed"]);
}

_id_4C82() {
  wait 1;

  for(var_0 = 0; var_0 < self._id_AE9D.size; var_0++) {
    if(self._id_AE9D[var_0] != self._id_5849) {
      self._id_AE9D[var_0] thread scripts\mp\hud_message::showsplash("callout_exfil_success");
    }
  }
}

_id_80EF(var_0) {
  self._id_8396 = [];
  var_1 = self gettagorigin("tag_passenger1");
  var_2 = self gettagorigin("tag_passenger2");
  var_3 = self gettagorigin("tag_passenger3");
  var_4 = self gettagorigin("tag_passenger4");
  var_5 = self gettagorigin("tag_passenger5");
  var_6 = self gettagorigin("tag_passenger6");
  _id_3F09(var_1, &"MP/HOLD_TO_GET_ON_CHOPPER", 0, var_0);
  _id_3F09(var_2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var_0);
  _id_3F09(var_3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var_0);
  _id_3F09(var_4, &"MP/HOLD_TO_GET_ON_CHOPPER", 1, var_0);
  _id_3F09(var_5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var_0);
  _id_3F09(var_6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var_0);
}

_id_3F09(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 linkto(self);
  var_4 sethintstring(var_1);
  var_4 setcursorhint("HINT_BUTTON");
  var_4 _meth_84D4(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 _meth_84D9("hide");
  var_4 setuseholdduration("duration_short");
  var_4 thread _id_5717(self, var_2, var_3);
  self._id_8396[self._id_8396.size] = var_4;
}

_id_5717(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    _id_99E0(var_2);
  } else {
    _id_99E1(var_0.team);
  }

  for(;;) {
    self waittill("trigger", var_2);
    self makeunusable();
    var_0 _id_572E(var_2, var_1, self);
  }
}

_id_99E1(var_0) {
  self makeuseable();
  thread _id_0DA7(var_0);
}

_id_99E0(var_0) {
  self makeuseable();
  thread _id_0DA6(var_0);
}

_id_0DA7(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self _meth_80E0(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

_id_0DA6(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self _meth_80E0(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

_id_B35D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = "ustl";
  var_4 = "dx_mpa_" + var_3 + "_" + var_1 + "_" + var_2;

  if(_func_0205(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0) {
        var_6 _meth_8287(var_4, var_1, 2);
      }
    }
  }
}

_id_106B3() {
  level endon("game_ended");
  level waittill("match_ending_very_soon");
  _id_B35D(game["attackers"], "extract_littlebird_leaving_soon_a_friendly", 10);
}

_id_3ADB(var_0, var_1, var_2) {
  foreach(var_4 in self._id_7E24.players) {
    self playsoundtoplayer(var_0, var_4);
  }
}

_id_CDBF() {}