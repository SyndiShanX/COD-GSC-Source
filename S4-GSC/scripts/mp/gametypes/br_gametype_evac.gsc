/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_evac.gsc
*****************************************************/

init() {
  scripts\mp\gametypes\br_gametypes::_id_5254("circleSnapToNavMesh");
  scripts\mp\gametypes\br_gametypes::_id_C243("circleTimer", ::_id_3734);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerWelcomeSplashes", ::_id_B821);
  level._id_2BB5._id_5BDE = "tie";
  thread _id_8274();
}

_id_8274() {
  waittillframeend;
  thread _id_D88D();
}

_id_B821(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");

  if(!istrue(level._id_2A60)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else
    level waittill("prematch_done");

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_evac_welcome");
}

_id_D88D() {
  _id_07D1::_id_60C2("prematch_done");
  level._id_2BB5._id_7769 = getdvarint("#x370dd5d36151a3f51", 5);
  level._id_2BB5._id_77B5 = getdvarint("#x3e745d45d6a1f5068", 120);
  level._id_2BB5._id_77B8 = getdvarint("#x35d561c57e4af4dc2", 120);
  level._id_2BB5._id_F264 = _id_3FF3(&"MP_BR_INGAME/EVAC_START", level._id_2BB5._id_7769, "CENTER", "CENTER", 0, -180);
  thread _id_D87C();
}

_id_D87C(var_0) {
  var_1 = 20;
  var_2 = 300;
  var_3 = 1;
  var_4 = 3;
  var_5 = 0;
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = level._id_2A73._id_2A1F[level._id_2BB5._id_7769];
  var_8 = level._id_2A73._id_2A25[level._id_2BB5._id_7769];
  var_9 = var_7;
  var_10 = var_8 * var_8;
  var_11 = var_8 - 150;
  var_12 = var_11 * var_11;
  var_13 = -1;
  var_14 = -1;
  var_15 = -1;
  var_16 = var_7;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;
  var_21 = (0, 0, 0);
  var_22 = 0;

  while(var_18 < var_11) {
    var_9 = var_9 + var_21;
    var_23 = (var_9[0], var_9[1], var_6.origin[2]);
    var_24 = distance2dsquared(var_23, var_7);

    if(var_24 < var_12) {
      var_22++;
      var_25 = _id_F3CB(var_23, 150);
      var_26 = _func_02AB(var_25);
      var_27 = abs(var_25[2] - var_26[2]);
      var_28 = distance2dsquared(var_25, var_26);

      if(var_28 < var_3 && var_27 <= var_1 && !var_5) {
        level._id_2BB5._id_77C1 = var_25;
        return;
      } else {
        var_29 = var_28 * var_27;

        if(var_13 == -1 || var_13 > 0 && var_29 < var_13 || var_13 == 0 && var_27 < var_15) {
          var_13 = var_29;
          var_16 = var_25;
          var_14 = var_28;
          var_15 = var_27;
        }
      }
    }

    if(var_17 == 0) {
      var_17++;
      var_19++;
    } else if(var_20 == var_17) {
      var_17++;
      var_19 = 1;
      var_20 = 1;
      var_30 = scripts\engine\utility::ter_op(var_17 % 2, -1, 1);
      var_21 = (var_30 * var_2, 0, 0);
    } else if(var_19 == var_17) {
      var_20++;
      var_30 = scripts\engine\utility::ter_op(var_17 % 2, -1, 1);
      var_21 = (0, var_30 * var_2, 0);
    } else
      var_19++;

    if(var_17 % 2 == 1) {
      var_18 = (var_17 + 1) / 2 * var_2;
    }

    if(var_22 >= var_4) {
      var_22 = 0;
      waitframe();
    }
  }

  level._id_2BB5._id_77C1 = var_16;
}

_id_3734(var_0) {
  if(var_0 < level._id_2BB5._id_7769) {
    return 0;
  }

  if(var_0 == level._id_2BB5._id_7769) {
    _id_CA41(var_0);
  }

  return 1;
}

_id_D88E() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_6CA6("gt_evac");

  foreach(var_2 in level.players) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_D68B(var_0);
  }
}

_id_EF6F(var_0, var_1) {
  level endon("game_ended");
  level._id_2BB5._id_5BDE = var_0;
  _id_D70E(var_0);
  var_1 notify("missionComplete");
  scripts\mp\outofbounds::enableoobimmunity(self);
  scripts\mp\gametypes\br_public::_id_2BDE("team_victory", var_0);
  [var_3, var_4, var_5] = ::scripts\mp\gametypes\br::_id_2EDF(1);
  var_6 = level._id_EF6A[var_0]["players"];

  foreach(var_8 in var_6) {
    var_8 scripts\mp\gametypes\br_quest_util::_id_F91E();
    var_8 setclientomnvar("post_game_state", 9);
    var_8 setclientomnvar("ui_br_end_game_splash_type", 1);
    scripts\mp\outofbounds::enableoobimmunity(var_8);
    var_8._id_E355 = 1;
  }
}

_id_2BAA() {
  wait 1.5;
  _id_7440();
  scripts\mp\gamelogic::_id_52FD(level._id_2BB5._id_5BDE, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_7440() {
  foreach(var_1 in level.players) {
    if(!_id_8A92(var_1.team)) {
      var_1 setclientomnvar("post_game_state", 2);
    }
  }
}

_id_D70E(var_0) {
  level._id_EF6A[var_0]["extracted"] = 1;
}

_id_8A92(var_0) {
  return istrue(level._id_EF6A[var_0]["extracted"]);
}

_id_CA41(var_0) {
  if(isDefined(var_0)) {
    scripts\mp\gametypes\br_gulag::_id_DD0F("circle_index", var_0);
  }

  level thread scripts\mp\gametypes\br_public::_id_2B3F("br_gametype_evac_incoming");
  scripts\mp\gametypes\br_quest_util::_id_3157();
  scripts\mp\gametypes\br_quest_util::_id_4A7C();
  thread _id_D88E();
  _id_99F0();
  var_1 = _id_3FCC(level._id_2BB5._id_77C1);
  var_2 = _id_6A97();
  var_3 = (level._id_2BB5._id_77C1[0], level._id_2BB5._id_77C1[1], var_2);
  var_4 = _id_F3C9(var_3);
  var_5 = var_3[2] - var_4;
  var_6 = _id_2EE9(var_5);
  var_7 = level._id_2BB5._id_77B5 + var_6;
  var_8 = var_7 + level._id_2BB5._id_77B8;
  level._id_2A1B._id_4340.origin = scripts\mp\gametypes\br_circle::_id_69C5() + (0, 0, scripts\mp\gametypes\br_circle::_id_69C6());
  scripts\mp\gametypes\br_circle::_id_D6ED(var_8, level._id_2A1B._id_CACB, level._id_2A1B._id_4340, 0);
  setomnvar("ui_hardpoint_timer", gettime() + int(var_8 * 1000));
  thread _id_D87E(var_7, level._id_2BB5._id_77B8);
  wait(level._id_2BB5._id_77B5);
  var_9 = _id_E2E3(level._id_2BB5._id_77C1);
  var_9._id_103BE = var_1;
  var_9._id_5D49 = var_6;
  var_9._id_71F3 = var_4;
  thread _id_5845(var_9);
}

_id_D87E(var_0, var_1) {
  level endon("game_ended");
  level._id_2BB5._id_F264 destroy();
  level._id_2BB5._id_F264 = _id_3FF3(&"MP_BR_INGAME/EVAC_ARRIVE", undefined, "CENTER", "CENTER", 0, -180);
  var_2 = scripts\mp\hud_util::_id_404A("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -162);
  var_2 _meth_8391(var_0);
  wait(var_0);
  level._id_2BB5._id_F264.label = &"MP_BR_INGAME/EVAC_WAIT";
  var_2 _meth_8391(var_1);
  wait(var_1);
  level._id_2BB5._id_F264 destroy();
  var_2 destroy();
}

_id_3FF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1.5;

  if(isDefined(var_7)) {
    var_9 = newteamhudelem(var_7);
  } else {
    var_9 = newhudelem();
  }

  var_9.elemtype = "font";
  var_9.font = "default";
  var_9.fontscale = var_8;
  var_9._id_22B8 = var_8;
  var_9.x = 0;
  var_9.y = 0;
  var_9.width = 0;
  var_9.height = int(level.fontheight * var_8);
  var_9.xoffset = 0;
  var_9.yoffset = 0;
  var_9.children = [];
  var_9 scripts\mp\hud_util::setparent(level.uiparent);
  var_9.hidden = 0;
  var_9.alpha = 1;
  var_9 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0)) {
    var_9.label = var_0;
  }

  if(isDefined(var_1)) {
    var_9 _meth_83A3(var_1);
  }

  if(isDefined(var_6)) {
    var_9.color = var_6;
  }

  return var_9;
}

_id_99F0() {
  var_0 = _id_07F9::_id_C57D(1);
  level._id_2BB5._id_A8DA = var_0;

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "active", level._id_2BB5._id_77C1, "ui_mp_br_mapmenu_icon_helipad");
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A8A2(var_0);
  }

  var_0 = _id_07F9::_id_C57D(1);
  level._id_2BB5._id_A8DA = var_0;

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "current", level._id_2BB5._id_77C1 + (0, 0, 30), "ui_mp_br_mapmenu_legend_littlebird");
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A8A2(var_0);
  }
}

_id_5845(var_0) {
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 _meth_838A(var_0._id_7092);
  var_0 waittill("goal");
  var_0 thread _id_77A0();
  var_0 _id_779A(var_0._id_533D, var_0._id_71F3);
  _id_07F9::_id_FB98(level._id_2BB5._id_A8DA, 4);
  level thread scripts\mp\gametypes\br_public::_id_2B3F("br_gametype_evac_arrived");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_arrive", var_0.team, 1);
  var_0 _id_776C(0);
  var_0 _id_77B8();
  var_0 _id_77E8();
  var_0 thread _id_77C2();
  _id_2BAA();
}

_id_6A97() {
  var_0 = getent("airstrikeheight", "targetname");
  var_1 = var_0.origin[2] - 300;
  return var_1;
}

_id_E2E3(var_0) {
  var_1 = var_0;
  var_2 = _id_6A97();
  var_3 = (var_1[0], var_1[1], var_2);
  var_4 = (0, randomfloat(360), 0);
  var_5 = var_3 + -1 * anglesToForward(var_4) * 30000;
  var_6 = var_3 + anglesToForward(var_4) * 30000;
  var_7 = level.players[randomint(level.players.size)];
  var_8 = var_7 _id_E2FA(var_7, var_5, var_3, var_6);
  return var_8;
}

_id_2EEA(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + _func_0218(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

_id_2EE9(var_0) {
  var_1 = _id_2EEA(30000, 100, 125);
  var_2 = _id_2EEA(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

_id_77E3(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level._id_EF6A[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 setclientomnvar("ui_br_plunder_extract_state", var_0);
    var_5 setclientomnvar("ui_br_plunder_extract_end_time", var_2);
  }
}

_id_77B8() {
  var_0 = spawn("script_model", level._id_2BB5._id_77C1 + (0, 0, 20));
  var_0 setModel("tag_origin");
  var_0 makeuseable();
  var_0 setcursorhint("HINT_NOICON");
  var_0 setuseholdduration("duration_short");
  var_0 sethintrequiresholding(1);
  var_0 setuserange(230);
  var_0 sethintstring(&"MP_BR_INGAME/EXTRACT");
  self._id_FDB2 = var_0;
  thread _id_77E5(var_0);
  wait(level._id_2BB5._id_77B8);
}

_id_77E5(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 playlocalsound("br_plunder_atm_deposit_gtr");
    _id_77E8();
    _id_EF6F(var_1.team, self);
    _id_2BAA();
    return;
  }
}

_id_77E8() {
  if(isDefined(self._id_FDB2)) {
    self._id_FDB2 _id_47F5();
    self._id_FDB2 = undefined;
  }
}

_id_47F5() {
  self makeunusable();

  if(isDefined(level._id_2BB5._id_A8DA)) {
    _id_07F9::_id_A89F(level._id_2BB5._id_A8DA);
    _id_07F9::_id_C799(level._id_2BB5._id_A8DA);
  }
}

_id_3FCC(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("scr_smoke_grenade");
  var_1.angles = (0, 90, 90);
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  var_1 setscriptablepartstate("smoke", "on");
  return var_1;
}

_id_776C(var_0) {
  if(isDefined(self._id_103BE)) {
    self._id_103BE stoploopsound();
    self._id_103BE delete();
  }

  if(istrue(var_0) && isDefined(self._id_DD67)) {
    self._id_DD67 setscriptablepartstate(self._id_DD67.type, self._id_DD67._id_0F60);
  }
}

_id_77A0() {
  self endon("death");

  if(!isDefined(self._id_103BE)) {
    return;
  }
  wait 5;
  self._id_103BE endon("death");
  self._id_103BE setscriptablepartstate("smoke", "dissipate");
  self._id_103BE playSound("smoke_canister_tail_dissipate");
  wait 1;
  self._id_103BE stoploopsound();
  wait 4.5;
  self._id_103BE delete();
}

_id_E2FA(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 1;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_1, var_4, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable");

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_2 * (1, 1, 0);
  var_6._id_42E9 = ::_id_2F40;
  var_6.speed = 100;
  var_6.accel = 125;
  var_6.health = 9999;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6._id_461E = var_2;
  var_6._id_936C = 0;
  var_6._id_5C8A = var_5;
  var_6._id_AEDC = var_2;
  var_6._id_AEDB = var_3;
  var_6._id_533D = var_7;
  var_6._id_7092 = var_4[1];
  var_6._id_1031E = "magma_plunder_chopper";
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  var_6 thread _id_0A44::_id_5C7F(undefined, undefined);
  return var_6;
}

_id_776A() {
  if(isDefined(self._id_C918)) {
    self._id_C918 delete();
  }

  if(isDefined(self._id_3E6D)) {
    self._id_3E6D delete();
  }
}

_id_7798() {
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {}

_id_77C2() {
  self endon("death");
  self notify("leaving");
  self._id_916C = 1;
  self setvehgoalpos(self._id_AEDC, 1);
  self _meth_838A(self._id_7092);
  _id_77E3(3, self._id_5D49);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_AEDB, 1);
  self _meth_838A(self._id_7092);
  self waittill("goal");
  self stoploopsound();
  _id_77E3(0, 0);
  self notify("heli_gone");
  _id_7798();
}

_id_779A(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self _meth_838A(self._id_7092);
  self vehicle_setspeed(25.0, 31.25);
  thread _id_779C();
  thread _id_779D();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

_id_54EE() {
  return isalive(self) && (scripts\common\vehicle::_id_8AF5() || isDefined(self.classname) && self.classname == "script_vehicle");
}

_id_779C() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && var_0 _id_54EE()) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

_id_779D() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = _func_0098("script_vehicle", "classname", self.origin, getdvarfloat("#x34b8346a089ba183b", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::_id_3F87();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7036459ed3de1", var_2) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc6f86459ed25b0", var_3) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7076459ed46ad", var_4) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

_id_F3C9(var_0) {
  var_1 = 190;
  var_2 = _id_F3CB(var_0, 150);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

_id_F3CB(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = physics_createcontents(["physicscontents_playerclip", "physicscontents_missileclip", "physicscontents_vehicleclip"]);
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::_id_E409(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

_id_77EA() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_77C2();
}

_id_7B61() {
  self endon("death");

  if(istrue(self._id_BE2A)) {
    return;
  }
  var_0 = 0.5;
  var_1 = 4;
  self._id_BE2A = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait(var_0);
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self._id_BE2A = undefined;
}