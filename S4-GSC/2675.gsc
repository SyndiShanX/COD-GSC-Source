/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2675.gsc
*************************************************/

_id_7AA0() {
  level._id_0F45 = 0;
  level._id_7A96 = [];
  level._id_7D84 = [];
  level._id_0F3F = [];
  level._id_0F40 = [];
  level._id_7A92 = scripts\engine\utility::getstructarray("hostage", "targetname");
  level._id_7A90 = scripts\engine\utility::getstructarray("hostage_exit", "targetname");

  foreach(var_1 in level._id_7A90) {
    level._id_A863[level._id_A863.size] = spawn("trigger_radius", var_1.origin, 0, 90, 128);
  }

  level._id_BFD4 = scripts\engine\utility::array_randomize(level._id_7A92);
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  thread _id_7A9E();
}

_id_A780() {
  return level._id_7D84.size;
}

_id_7817(var_0) {
  var_1 = _id_0A61::_id_6DBE(var_0);

  if(!isDefined(var_1._id_96CF)) {
    return 0;
  }

  if(_id_A780() == 0) {
    iprintlnbold("COPTERS ALREADY ON THE WAY");

    if(isDefined(var_1._id_04ED)) {
      var_1._id_04ED delete();
    }

    return 0;
  }

  scripts\mp\gametypes\to_hstg::_id_F73C(var_1._id_96CF, var_1);
  var_2 = scripts\mp\gametypes\tac_ops::_id_6DAF();

  if(var_2 < scripts\mp\gametypes\to_hstg::_id_6A2A() * 1000) {
    _id_E6DF();
  }

  return 1;
}

_id_E2FE(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "vip") {
    var_1 = game["attackers"];
    var_3 = "body_opforce_london_terrorist_1_2";
    var_4 = "head_male_bc_03";
  } else {
    var_1 = "neutral";
    var_3 = "body_mp_western_fireteam_west_ar_1_1_lod1";
    var_4 = "head_mp_western_fireteam_west_ar_1_1";
  }

  var_5 = spawn("script_model", var_0);
  var_6 = spawn("script_model", var_0);
  var_7 = spawn("script_model", var_0);
  var_6 setModel(var_3);
  var_7 setModel(var_4);
  var_7 linkto(var_6, "j_neck", (-9, 1, 0), (0, 0, 0));
  var_6 linkto(var_5, "", (0, 0, -48), (0, 0, 0));
  var_8 = spawn("script_model", var_0);
  var_8.team = var_1;
  var_8._id_4823 = var_0;
  var_5.trigger = var_8;
  var_8 linkto(var_5);
  var_5.trigger makeuseable();
  var_5._id_25CA = var_6;
  var_5._id_75DA = var_7;
  var_5 = _id_5032(undefined, var_5, var_0, 1);
  var_5._id_EFA4["allies"] = 0;
  var_5._id_EFA4["axis"] = 0;
  var_5._id_10A13 = 0;
  var_5._id_C589 = 1;
  var_5._id_D537 = ::_id_5032;
  var_5.team = var_1;
  var_5._id_FE80 = 1;
  var_5._id_ADAE = var_1;
  var_5._id_83B6 = scripts\engine\utility::ter_op(var_1 == "neutral", "any", "friendly");
  var_5._id_56E2 = 0;
  var_5._id_4143 = 0;
  var_5._id_FEE7 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "cmd", 500, 0);
  var_5._id_FEB1 = 1;
  var_5._id_7C8C = "care_package";
  var_5._id_DDC9 = 1;
  var_5._id_ABCB = ::_id_7A94;
  var_5 thread _id_07D6::_id_FE97();
  var_9 = "icon_minimap_tac_ops_hostage_unknown";
  var_10 = spawn("script_model", var_0);
  var_10 linkto(var_5);
  var_5._id_1DBA = var_10;

  if(var_1 == "neutral") {
    var_11 = "any";
    var_12 = "any";
  } else {
    var_11 = "friendly";
    var_12 = "friendly";
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && var_2) {
    var_5._id_F3FE = var_5 _id_07D6::_id_4069(var_10, (0, 0, 0));
    var_5._id_F3FE._id_A90C = 0;
    var_5._id_F3FE._id_A90B = 1;
    var_5._id_F3FE._id_A912 = 2.0;
    var_5._id_F3FE _id_07D6::_id_159C(var_11);
    var_5._id_F3FE _id_07D6::_id_D639(var_5._id_ADAE);
    var_5._id_F3FE _id_07D6::_id_D61B(level._id_7C80, level._id_7C80);
    var_5._id_F3FE._id_316A = 1;
    var_5._id_F3FE._id_E57B = 0;
    var_5._id_F3FE._id_10A20 = 1;
    var_5._id_F3FE _id_07D6::_id_D8E0(var_12);
  }

  if(isDefined(var_5._id_F3FE)) {
    var_5._id_F3FE _id_07D6::_id_159C(var_1);
    var_5._id_F3FE _id_07D6::_id_D639(var_1);
    var_5._id_F3FE _id_07D6::_id_D61B(level._id_7C80, level._id_7C80);

    if(scripts\mp\utility\game::getgametype() == "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var_5._id_F3FE._id_316A = 1;
      var_5._id_F3FE._id_E57B = 0;
      var_5._id_F3FE._id_10A20 = 1;
    }

    var_5._id_F3FE _id_07D6::_id_D8E0(var_12);
  }

  return var_5;
}

_id_E262(var_0) {
  for(var_1 = 0; var_1 < level._id_7A92.size; var_1++) {
    level._id_7A96[var_1] = _id_E2FE(level._id_7A92[var_1].origin, var_0);
  }
}

_id_E359(var_0, var_1) {
  var_2 = int(min(5 - level._id_0F45, min(level._id_BFD4.size - level._id_E2B9, var_0)));

  if(var_2 == 0) {
    return;
  }
  for(var_3 = 0; var_3 < var_2; var_3++) {
    level._id_7A96[level._id_E2B9 + var_3] = _id_E2FE(level._id_BFD4[level._id_E2B9 + var_3].origin, var_1);
  }

  level._id_E2B9 = level._id_E2B9 + var_2;
  level._id_0F45 = level._id_0F45 + var_2;
}

_id_E3AB() {
  var_0 = spawn("script_model", self.origin);
  var_1 = spawn("script_model", self.origin);
  var_0 setModel("body_opforce_london_terrorist_1_2");
  var_1 setModel("head_male_bc_03");
  var_1 linkto(var_0, "j_neck", (-9, 1, 0), (0, 0, 0));

  if(0) {
    var_0 _meth_82CC("wm_firemancarry_loop_mp_stand");
    var_0 linkto(self, "j_shoulder_le");
  } else {
    var_0 _meth_82CC("hm_grnd_civ_react02_idle04");
    var_0 linkto(self, "j_shoulder_le", (-12, -8, -8), (0, 0, 30));
    var_1 hidefromplayer(self);
    var_0 hidefromplayer(self);
  }

  var_0._id_75DA = var_1;
  self._id_7A89._id_10E84 = var_0;
  return var_0;
}

_id_7A94(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("dropped");
  var_0 endon("death");

  if(istrue(self.inlaststand)) {
    return;
  }
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_0._id_F913 = undefined;
  thread _id_07D6::_id_FC43();
  level._id_7A8A = var_0;
  self.trigger makeunusable();
  var_0._id_7A89 = self;

  if(scripts\mp\utility\game::getgametype() == "vip" || scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::_id_FCBF(self.team, 11, 12, level._id_7A8A, 13);
  }

  var_0 _id_32E5();
  thread _id_B8FF();
  wait 0.4;
  var_0 _id_E3AB();
  var_0._id_7A89._id_25CA hide(1);
  var_0._id_7A89._id_75DA hide(1);
  self linkto(var_0, "tag_eye", (0, 0, 0), (0, 0, 0));

  if(isDefined(self._id_F3FE)) {
    self._id_F3FE._id_ADAE = var_0.team;
    self._id_F3FE._id_32D5 = var_0;
    self._id_F3FE _id_07D6::_id_D61B(level._id_7C55, level._id_7C6A);
  }

  if(scripts\mp\utility\game::getgametype() != "btm" && isDefined(level._id_7A91)) {
    level._id_7A91._id_ADAE = var_0.team;
    level._id_7A91 _id_07D6::_id_C579(1, 1);
    level._id_7A91 _id_07D6::_id_D8E0("any");
    level._id_7A91 _id_07D6::_id_D61B(level._id_7C58, level._id_7C7D);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_0 scripts\mp\gametypes\btm::_id_EAF8(level._id_1040B[var_0.team]);
    level._id_1040B[var_0.team]._id_7087 _id_07D6::_id_D8E0("any");
  }

  if(isDefined(self._id_ACE5)) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self);
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
    if(var_0.team == "axis") {
      var_0._id_7A95 = scripts\mp\utility\outline::_id_ACD2(var_0, "axis", "outline_nodepth_orange", "killstreak_personal");
    } else {
      var_0._id_7A95 = scripts\mp\utility\outline::_id_ACD2(var_0, "allies", "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(!isDefined(self._id_FE90)) {
    self._id_FE90 = spawn("script_model", var_0.origin);
  }

  self._id_FE90 linkto(var_0, "tag_eye");
  self._id_FE90 makeuseable();
  self._id_FE90 setcursorhint("HINT_NOICON");
  self._id_FE90 _meth_84D9("show");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self._id_FE90 sethintstring(&"MP/HOLD_TO_DROP_VIP");
  } else {
    self._id_FE90 sethintstring(&"MP/HOLD_TO_DROP_HOSTAGE");
  }

  self._id_FE90 sethintdisplayfov(360);
  self._id_FE90 setusefov(360);
  self._id_FE90 _meth_84D4(100);
  self._id_FE90 setuserange(100);
  self._id_FE90 _meth_83A1(-300);
  var_0 _meth_852A("temp_hostage_carry_mp");
  var_0._id_32EC = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      self._id_FE90 _meth_80E0(var_2);
      continue;
    }

    self._id_FE90 disableplayeruse(var_2);
  }

  foreach(var_5 in level._id_7A96) {
    if(var_5 != self) {
      var_5 disableplayeruse(var_0);
    }
  }

  thread _id_10B7F(var_0, self, self._id_FE90);

  if(isDefined(level._id_ED22)) {
    thread _id_3571();
  }

  thread _id_907B(var_0);

  if(!self._id_10A13) {}

  self._id_10A13 = 1;
  level notify("hostage_status_update", 1);
}

_id_B8FF() {
  wait 4;
  self playSound("dx_mpb_us3_hvt_thank");
}

_id_E288() {
  level endon("game_ended");
  self endon("death");
  self endon("dropped_hostage");
  var_0 = (-1970, -1692, 5);
  level._id_7A91 = spawn("script_model", var_0);
  level._id_7A91.angles = (0, 270, 0);
  level._id_7A91.team = "allies";
  level._id_7A91 setModel("cop_marker_scriptable");
  level._id_7A91 setscriptablepartstate("marker", "red");
  level._id_7A91 playLoopSound("mp_flare_burn_lp");
  level._id_7A91 thread _id_078F::_id_D594(0, 60);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level._id_7A91, "tag_origin");
  var_1 = spawn("trigger_radius", var_0, 0, 120, 128);
  var_1 thread _id_708F(self);
}

_id_708F(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  self waittill("trigger", var_0);

  if(isDefined(var_0._id_7A89)) {
    _id_5032(var_0, level._id_7A96[0], var_0.origin);
    level._id_7A96[0].trigger makeunusable();
    level._id_7A96[0] makeunusable();
    level._id_7A96[0]._id_FE90 unlink();
    level._id_7A96[0]._id_FE90 makeunusable();

    if(isDefined(level._id_7A96[0]._id_ACE5)) {
      scripts\mp\utility\outline::outlinedisable(level._id_7A96[0]._id_ACE5, level._id_7A96[0]._id_25CA);
    }

    thread _id_E382(var_0);
  }

  self delete();
}

_id_E382(var_0) {
  while(!isDefined(level._id_2AD5)) {
    waitframe();
  }

  var_1 = (-2139, -1977, 64);
  var_2 = (0, 270, 0);
  var_3 = var_0.team;
  var_4 = [];

  foreach(var_6 in scripts\mp\utility\teams::_id_6DCA("allies", "players")) {
    if(distancesquared(var_6.origin, var_1) < 360000) {
      var_6 _meth_8287("dx_mpp_usp1_hostage_extraction", "cop_hostage_extraction", 2);
    }
  }

  wait 3;
  _id_0A8D::_id_9136("cop_killstreak_bradley", var_3, "killstreak_used", var_4);
  _id_0A8D::_id_9136("cop_enemy_bradley", scripts\mp\utility\game::_id_6BE2(var_3)[0], "killstreak_used", var_4);
  scripts\mp\gametypes\bradley_spawner::_id_E26E(var_1, var_2, "allies");
}

_id_696C(var_0) {
  var_1 = level._id_5837.origin;
  var_2 = var_1 - level._id_7A8C[0][0].origin;
  var_3 = undefined;

  for(var_4 = 0; var_4 < level._id_7A8C.size; var_4++) {
    var_5 = level._id_7A8C[var_4][0].origin;
    var_6 = var_5 - var_0;

    if(vectordot(var_2, var_6) < 0) {
      var_3 = var_5;
    }
  }

  if(!isDefined(var_3)) {
    var_3 = level._id_7A8C[0][0].origin;
  }

  return var_3;
}

_id_696F(var_0) {
  var_1 = level._id_7A90[0].origin;
  var_2 = distancesquared(var_0, var_1);

  for(var_3 = 1; var_3 < level._id_7A90.size; var_3++) {
    var_4 = level._id_7A90[var_3].origin;
    var_5 = distancesquared(var_4, var_0);

    if(var_2 > var_5) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

_id_7AA1() {
  level endon("game_ended");
  self endon("hostage_scored");
  level endon("hostage_phase_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distancesquared(var_1 getEye(), self.origin);

      if(var_1.team == "allies" && isalive(var_1)) {
        if(var_2 < 57600) {
          _id_7A9F();
          return;
        }
      }
    }

    wait 0.5;
  }
}

_id_7A9F() {
  self notify("hostage_stopped");
  self._id_8A0C = 0;
  _id_5032(undefined, self, self.origin);
}

_id_7A93() {
  level endon("game_ended");
  level endon("hostage_phase_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1.team != "axis") {
        continue;
      }
      var_2 = var_1 _id_7562();
      var_3 = 0;
      var_4 = 0;

      foreach(var_6 in level._id_0F40) {
        if(var_1 == var_6) {
          var_4 = 1;
        }
      }

      foreach(var_9 in level._id_7A96) {
        var_10 = distancesquared(var_1 getEye(), var_9.origin);

        if(!istrue(var_9._id_8A0C)) {
          if(var_10 < 14400 && var_9 _id_BDC8(var_1)) {
            var_3 = 1;
            break;
          }
        }
      }

      if(istrue(level._id_8FD0) || var_2 && !var_3) {
        var_1 _id_C49A();
        var_1 notify("equip_deploy_end");
        var_1 scripts\mp\killstreaks\killstreaks::_id_FC9C();
        var_1 scripts\mp\killstreaks\killstreaks::_id_FC9A();

        if(!var_4 && istrue(level._id_8FD0)) {
          var_1 _id_46D5("The last evac copter is already en route!");
        }

        break;
      } else if(!var_4 && !var_2 && var_3) {
        var_1 _meth_849E();
        var_1 scripts\mp\killstreaks\killstreaks::_id_1FC8("tacops_beacon_mp");
        var_1 iprintlnbold("DPAD-Right to call an evac copter");
        break;
      }
    }

    wait 0.5;
  }
}

_id_BDC8(var_0) {
  if(!isDefined(self._id_C589)) {
    return 1;
  }

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];
  var_4 = self.origin + (0, 0, 32);
  var_5 = 1;
  var_3[0] = self._id_10430;
  var_3[1] = var_0;
  var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);

  if(var_6["fraction"] != 1 && var_5) {
    var_4 = self.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["fraction"] != 1) {
    var_4 = self.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["fraction"] == 1;
}

_id_46D5(var_0) {
  if(!isDefined(self._id_900D)) {
    self iprintlnbold(var_0);
    self._id_900D = 1;
    wait 10;
    self._id_900D = undefined;
  }
}

_id_E6DF() {
  level._id_8FD0 = 1;
  scripts\mp\gametypes\tac_ops::_id_57FA(60000);
}

_id_7562() {
  var_0 = scripts\mp\killstreaks\killstreaks::_id_6A6C();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "tacops_beacon_mp") {
      return 1;
    }
  }

  return 0;
}

_id_C49A() {
  var_0 = scripts\mp\killstreaks\killstreaks::_id_6A6C();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "tacops_beacon_mp") {
      scripts\mp\killstreaks\killstreaks::_id_C4DC(0);
    }
  }
}

_id_9A1D(var_0) {
  self._id_ADB0 = _id_07F9::_id_C57D(99);
  _func_0160(self._id_ADB0, self);
  _func_0187(self._id_ADB0, var_0.team);
  self._id_EF79 = thread _id_078F::_id_D59B(var_0.team, "waypoint_blitz_defend", 36);
}

_id_A242(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("hostage_scored");
  self endon("hostage_stopped");
  var_1 = 100;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = _id_6C2A(var_3);
    var_5 = distance(self.origin, var_4);

    if(var_5 == 0) {
      continue;
    }
    var_6 = var_5 / var_1;
    self.angles = vectortoangles(var_4 - self.origin);
    self moveto(var_4, var_6, 0, 0);
    wait(var_6);
  }

  thread _id_7A9F();
}

_id_CC06(var_0, var_1) {
  level._id_7A96 = scripts\engine\utility::array_remove(level._id_7A96, self);
  _id_07D6::_id_4799();
  level._id_0F45--;

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self._id_25CA delete();
  self._id_75DA delete();
  self delete();
  level scripts\mp\gamescore::_id_7001(var_0, var_1, 0);
  self notify("hostage_scored");
}

_id_C4EB() {
  _id_07F9::_id_C799(self._id_413F);

  if(isDefined(self._id_FE90)) {
    _id_07F9::_id_C799(self._id_FE90._id_ADB0);
  }

  if(isDefined(self._id_FE90) && isDefined(self._id_FE90._id_EF79)) {
    self._id_FE90._id_EF79 destroy();

    foreach(var_2, var_1 in self._id_FE90._id_5504) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_1 destroy();
    }
  }
}

_id_6C2A(var_0) {
  var_1 = scripts\engine\trace::_id_3EE5(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = _func_02C1(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "physicsquery_closest");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["position"];
    return var_4;
  }

  return var_0;
}

_id_5032(var_0, var_1, var_2, var_3, var_4) {
  self notify("gameobject_deleted");

  if(!isDefined(var_0)) {
    var_0 = self._id_32D5;
  }

  if(!isDefined(var_2)) {
    var_2 = self._id_4140;
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_1 notify("dropped");

  if(isDefined(var_1._id_F3FE)) {
    var_1._id_F3FE._id_32D5 = var_1._id_1DBA;
    var_1._id_F3FE _id_07D6::_id_D61B(level._id_7C80, level._id_7C80);

    if(isDefined(var_0) && isDefined(var_0._id_7A95)) {
      scripts\mp\utility\outline::outlinedisable(var_0._id_7A95, var_0);
    }

    if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var_1._id_ACE5 = scripts\mp\utility\outline::_id_ACCF(var_1._id_25CA, "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(isDefined(level._id_7A91)) {
    level._id_7A91 _id_07D6::_id_D8E0("none");
    level._id_7A91 _id_07D6::_id_C300();
  }

  if(scripts\mp\utility\game::getgametype() == "btm" && isDefined(level._id_1040B)) {
    level._id_1040B[var_0.team]._id_7087 _id_07D6::_id_D8E0("none");
  }

  var_1._id_32B9 = 0;
  var_5 = var_2;
  var_1 unlink();
  var_5 = _func_02AB(var_2);
  var_1.origin = _id_6C2A(var_5) + (0, 0, 2);
  var_1.angles = (0, var_1.angles[1], 0);

  if(!isDefined(var_3) && isDefined(var_1._id_FE90)) {
    var_1._id_FE90.origin = var_1.origin;
  }

  if(isDefined(var_0)) {
    var_0._id_32EC = undefined;
    var_6 = var_0.team;

    foreach(var_8 in level._id_7A96) {
      if(var_8 != var_1) {
        var_8 _meth_80E0(var_0);
      }
    }

    var_0 _id_C482(!isDefined(var_4));
  }

  if(isDefined(var_1._id_10E84)) {
    var_1._id_10E84 unlink();
    var_1._id_10E84._id_75DA delete();
    var_1._id_10E84 delete();
    var_1._id_10E84 = undefined;
  }

  if(isDefined(var_4)) {
    wait(var_4);
  }

  if(isDefined(var_0) && isDefined(var_0._id_7A89)) {
    var_0._id_7A89._id_25CA show();
    var_0._id_7A89._id_75DA show();
    var_0._id_7A89 = undefined;
  } else {
    var_1._id_25CA show();
    var_1._id_75DA show();
  }

  var_1.trigger makeuseable();

  if(isDefined(var_4)) {
    var_0 _id_C715();
  }

  level._id_7A8A = undefined;

  if(scripts\mp\utility\game::getgametype() == "vip") {
    foreach(var_0 in level.players) {
      if(var_0.team != var_1.trigger.team) {
        var_1.trigger disableplayeruse(var_0);
        var_1.trigger hidefromplayer(var_0);
      }
    }

    var_1.trigger sethintstring(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::_id_FCBF(var_1.team, 10, 12);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_1.trigger sethintstring(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::_id_FCBF(var_1.team, 10, 12);
  } else
    var_1.trigger sethintstring(&"MP/HOLD_TO_PICKUP_HOSTAGE");

  var_1 _meth_83A1(-300);

  if(isDefined(var_1._id_413F)) {
    _func_0182(var_1._id_413F, "neutral");
  }

  if(isDefined(var_1._id_25CA)) {
    var_1._id_25CA linkto(var_1, "", (0, 0, 0), (0, 0, 0));
    var_1._id_25CA _meth_82CC("hm_grnd_civ_react02_idle07");
  }

  return var_1;
}

_id_C715() {
  self takeallweapons();

  foreach(var_1 in self._id_C714) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);

    if(var_1.basename == "s4_knifestab_mp") {
      self _meth_8514(var_1);
    }
  }

  var_3 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_3)) {
    thread scripts\mp\supers::_id_6FFB(var_3);
  }

  var_4 = self._id_9676;

  if(isDefined(var_4)) {
    _id_0793::_id_3941();
    _id_0793::_id_6F9C(var_4);
  }

  var_5 = "primary";
  var_6 = scripts\mp\equipment::_id_69A4(var_5);

  if(isDefined(var_6)) {
    scripts\mp\equipment::giveequipment(var_6, var_5);
  }

  var_5 = "secondary";
  var_6 = scripts\mp\equipment::_id_69A4(var_5);

  if(isDefined(var_6)) {
    scripts\mp\equipment::giveequipment(var_6, var_5);
  }

  foreach(var_1 in self._id_C714) {
    if(var_1.basename != "s4_knifestab_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
      break;
    }
  }
}

_id_32E5() {
  if(istrue(level._id_7A8B[self.guid])) {
    return;
  }
  scripts\common\utility::_id_1570(0);
  scripts\common\utility::_id_1553(0);
  scripts\mp\utility\player::_id_0CF0("iw8_hvtcarry_mp");
  scripts\mp\utility\perk::_id_6FC2("specialty_sprintfire");
  self._id_AD6C = 0.75;
  scripts\mp\weapons::_id_FCCC();
  var_0 = "s4_pi_mike1911";
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = [];
  var_2[var_2.size] = "mod_hvt";
  var_3 = scripts\mp\class::buildweapon(var_1, ["mod_hvt"], "none", "none");
  self._id_C53F = var_3;
  self._id_C714 = self.weaponlist;
  self takeallweapons();
  scripts\common\utility::_id_1593(0);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
  thread _id_C196();
  thread _id_C193();
  level._id_7A8B[self.guid] = 1;
}

_id_C196() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death_or_disconnect");
  self endon("dropped_hostage");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self._id_8FC2) && self getcurrentweaponclipammo() == 0) {
      wait 1;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

_id_C193() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death_or_disconnect");
  self endon("dropped_hostage");

  for(;;) {
    self waittill("reload");
    self _meth_819C(self._id_0132);
  }
}

_id_C482(var_0) {
  if(!istrue(level._id_7A8B[self.guid])) {
    return;
  }
  scripts\common\utility::_id_1570(1);
  scripts\common\utility::_id_1553(1);
  scripts\mp\utility\player::_id_0CF0("iw8_defaultsuit_mp");
  scripts\mp\utility\perk::removeperk("specialty_sprintfire");
  self._id_AD6C = undefined;
  scripts\mp\weapons::_id_FCCC();
  scripts\cp_mp\utility\inventory_utility::_id_6CF7("temp_hostage_carry_mp");
  scripts\common\utility::_id_1593(1);

  if(var_0) {
    _id_C715();
  }

  level._id_7A8B[self.guid] = 0;
  self notify("dropped_hostage");
}

_id_3571() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  level endon("dropped_hostage");

  for(;;) {
    wait(5.0 + randomfloatrange(3.0, 10.0));
    playsoundatpos(self.origin, "dx_mpb_chem_phase2_chemreact");
    wait(5.0 + randomfloatrange(3.0, 10.0));
  }
}

_id_907B(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
}

_id_10B7F(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  self._id_32B9 = 1;
  var_3 = 0;
  self._id_32D5 = var_0;
  var_4 = level._id_5F3A;

  while(self._id_32B9) {
    if(!var_0 usebuttonpressed()) {
      var_3 = 1;
    }

    var_5 = 0;

    while(var_3 && var_0 usebuttonpressed()) {
      var_5 = var_5 + var_4;

      if(var_5 > 0.3) {
        var_2 unlink();
        var_2 disableplayeruse(var_0);
        var_2 makeunusable();
        var_6 = var_0.origin + anglesToForward(var_0.angles) * 72.0 + (0, 0, 24);
        _id_5032(var_0, var_1, var_6, undefined, 1.4);
        return;
      }

      wait(var_4);
    }

    waitframe();
  }
}

_id_A7C7() {
  self endon("death");
  var_0 = 512.0;
  var_1 = var_0 / 2.0;

  for(;;) {
    var_2 = randomfloatrange(var_1 / 3.0, var_1);

    if(randomint(2) == 0) {
      var_2 = var_2 * -1;
    }

    var_3 = randomfloatrange(var_1 / 3.0, var_1);

    if(randomint(2) == 0) {
      var_3 = var_3 * -1;
    }

    var_4 = (var_2, var_3, 0);
    _id_07F9::_id_FB97(self._id_413F, self.origin + (var_2, var_3, 0));
    wait(randomfloatrange(8, 13));
  }
}

_id_4022(var_0) {
  var_1 = _id_07F9::_id_C57D(10);

  if(var_1 == -1) {
    return -1;
  }

  _id_07F9::_id_A867(var_1, "invisible", (0, 0, 0), var_0);
  _id_07F9::_id_FB93(var_1, self);
  _id_07F9::_id_FB9E(var_1, "active");
  _id_07F9::_id_FB8F(var_1, var_0);
  _id_07F9::_id_A8A2(var_1);

  if(isDefined(level._id_A91D)) {
    [[level._id_A91D]](var_1);
  }

  return var_1;
}

_id_7A9E() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  level endon("hostage_holdout_phase_begun");
  level childthread _id_7A86();
  level childthread _id_7A87();
  level childthread _id_7A84();
  level childthread _id_7A85();
  level childthread _id_7A88();
  level childthread _id_7A9B();

  for(;;) {
    level waittill("hostage_status_update", var_0);

    switch (var_0) {
      case 1:
        level notify("hostage_ally_grabbed");
        break;
      case 2:
        level notify("hostage_axis_grabbed");
        break;
      case 3:
        level notify("hostage_ally_dropped");
        break;
      default:
        break;
    }
  }
}

_id_7A86() {
  for(;;) {
    level waittill("hostage_ally_grabbed");
    wait 1;
    _id_0A75::_id_BEC1("dx_mpb_chem_phase2_chemreact", "allies");
    wait 10;
  }
}

_id_7A84() {
  for(;;) {
    level waittill("hostage_ally_dropped");
    wait 1;
    _id_0A75::_id_BEC1("dx_mpb_chem_phase2_chemreact", "allies");
    wait 10;
  }
}

_id_7A87() {
  for(;;) {
    level waittill("hostage_ally_grabbed");
    _id_0A75::_id_BEC1("dx_mpb_us1_phase1_hvtgraba", "allies");
    _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_enemyhvtgrabb", "axis");
    wait 30;
  }
}

_id_7A85() {
  for(;;) {
    level waittill("hostage_ally_dropped");
    _id_0A75::_id_BEC1("dx_mpb_us1_phase1_hvtdropa", "allies");
    _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_enemyhvtdropb", "axis");
    wait 30;
  }
}

_id_7A88() {
  for(;;) {
    level waittill("hostage_axis_grabbed");
    _id_0A75::_id_BEC1("dx_mpb_us1_phase1_enemyhvtgraba", "allies");
    _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_hvtgrabb", "axis");
    wait 30;
  }
}

_id_7A9B() {
  for(;;) {
    level waittill("hostage_spawns_pushed");
    _id_0A75::_id_BEC1("dx_mpb_us1_phase1_spawnpusha", "allies");
    _id_0A75::_id_BEC1("dx_mpb_aqcm_phase2_spawnpushb", "axis");
    wait 30;
  }
}

_id_BDC7() {
  level endon("death");
  var_0 = spawn("trigger_radius", level._id_7A96[0].origin, 0, 120, 128);
  var_0 waittill("trigger", var_1);

  foreach(var_3 in scripts\mp\utility\teams::_id_6DCA("allies", "players")) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000) {
      var_3 _meth_8287("dx_mpp_usp1_hostage_located", "cop_hostage_located", 2);
    }
  }

  var_0 delete();
}