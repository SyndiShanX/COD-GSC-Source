/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_respawn.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x33ffff6281189e71e", 0);
  level._id_2AAB = getdvarint("#x33ffff6281189e71e", 0) != 0;

  if(!istrue(level._id_2AAB)) {
    _id_C473();
    return;
  }

  level._effect["ambulance_light"] = loadfx("vfx/iw8/level/stpetersburg/vfx_stpburg_police_lights.vfx");
  level._id_2AAD = [];
  thread _id_D880();
}

_id_C473() {
  var_0 = scripts\engine\utility::getstructarray("br_respawn_station", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getent(var_0[var_1].target, "targetname");

    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_E264(var_0) {
  if(!istrue(level._id_2AAB)) {
    return undefined;
  }

  var_1 = spawn("script_model", var_0.origin);

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  } else {
    var_1.angles = (0, 0, 0);
  }

  var_1 setModel("veh8_civ_lnd_palfa_ambulance_ukraine");
  var_1._id_EA6A = var_0;
  var_1 _id_168A(var_0);
  var_1 thread _id_168C();
  level._id_2AAD[level._id_2AAD.size] = var_1;
  return var_1;
}

_id_168A(var_0) {
  thread _id_1685();
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  if(!isDefined(self._id_462B)) {
    var_2 = spawn("script_model", var_1.origin);

    if(isDefined(var_1.angles)) {
      var_2.angles = var_1.angles;
    }

    var_2 setModel("medical_defibrillator_wall_01");
    var_2 makeuseable();
    var_2 setcursorhint("HINT_NOICON");
    var_2 setuseholdduration("duration_medium");
    var_2 sethintdisplayfov(120);
    var_2 setusefov(120);
    var_2 setuserange(80);
    var_2 sethintstring(&"MP/BR_RESPAWN_TAKE");
    var_2 _meth_81B0("outline_depth_red");
    var_2 _meth_83A1(-1);
    var_2 setasgametypeobjective();
    self._id_462B = var_2;
  }

  var_3 = _id_07F9::_id_C57D(1);
  self._id_A8DA = var_3;

  if(var_3 != -1) {
    _id_07F9::_id_A867(var_3, "invisible", (0, 0, 0));
    _id_07F9::_id_FB93(var_3, self);
    _id_07F9::_id_FB9E(var_3, "active");
    _id_07F9::_id_FB8F(var_3, "hud_icon_respawn");
    _id_07F9::_id_FB98(var_3, 1);
  }
}

_id_1685() {
  wait 1;
  var_0 = anglesToForward(self.angles);
  self._id_605B = spawnfx(scripts\engine\utility::getfx("ambulance_light"), self.origin + (0, 0, 75), var_0, (0, 0, 1));
  triggerfx(self._id_605B);
}

_id_168C() {
  self endon("death");

  for(;;) {
    self._id_462B waittill("trigger", var_0);
    _id_167E(var_0);
  }
}

_id_D880() {
  level._id_2A33 = [];
}

_id_825B() {
  if(!istrue(level._id_2AAB)) {
    return;
  }
  _id_78E3(self);
  _id_4A79(self);
}

_id_78E4(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = _id_6CEE(var_0);

    if(var_2.size > 0) {
      return;
    }
  }

  foreach(var_4 in level._id_EF6A[var_0]["players"]) {
    if(isDefined(var_4)) {
      _id_78E3(var_4);
    }
  }
}

_id_78E3(var_0) {
  for(var_1 = 0; var_1 < level._id_2AAD.size; var_1++) {
    var_2 = level._id_2AAD[var_1];

    if(isDefined(var_2) && !istrue(var_2._id_4A88)) {
      var_2 _id_1684(var_0);
    }
  }
}

_id_1684(var_0) {
  if(isDefined(self._id_462B)) {
    self._id_462B _meth_81AE(var_0);
  }

  _id_07F9::_id_A89E(self._id_A8DA, var_0);
}

_id_4A79(var_0) {
  for(var_1 = 0; var_1 < level._id_2AAD.size; var_1++) {
    var_2 = level._id_2AAD[var_1];

    if(isDefined(var_2) && !istrue(var_2._id_4A88)) {
      var_2 _id_1687(var_0);
    }
  }
}

_id_1687(var_0) {
  if(isDefined(self._id_462B)) {
    self._id_462B disableplayeruse(var_0);
  }
}

_id_DC80(var_0) {
  foreach(var_2 in level._id_EF6A[var_0]["players"]) {
    if(isDefined(var_2)) {
      _id_DC7F(var_2);
    }
  }
}

_id_DC7F(var_0) {
  for(var_1 = 0; var_1 < level._id_2AAD.size; var_1++) {
    var_2 = level._id_2AAD[var_1];

    if(isDefined(var_2) && !istrue(var_2._id_4A88)) {
      var_2 _id_168B(var_0);
    }
  }
}

_id_168B(var_0) {
  self._id_462B _meth_81B1(var_0, "outline_depth_red");
  _id_07F9::_id_A89D(self._id_A8DA, var_0);
}

_id_1683(var_0) {
  foreach(var_2 in level._id_EF6A[var_0]["players"]) {
    if(isDefined(var_2)) {
      _id_1689(var_2);
    }
  }
}

_id_1681(var_0) {
  foreach(var_2 in level._id_EF6A[var_0]["players"]) {
    if(isDefined(var_2)) {
      _id_1687(var_2);
    }
  }
}

_id_1689(var_0) {
  self._id_462B _meth_80E0(var_0);
}

_id_1680() {
  self notify("disabled");
  self._id_4A88 = 1;
  self._id_462B makeunusable();
  self._id_462B _meth_81AD();
  _id_07F9::_id_A89F(self._id_A8DA);
  _id_07F9::_id_C799(self._id_A8DA);

  if(isDefined(self._id_605B)) {
    self._id_605B delete();
  }
}

_id_1686() {
  self._id_462B sethintstring(&"MP/BR_RESPAWN_CHARGING");
  self._id_462B setuseholdduration("duration_none");
}

_id_1688() {
  self._id_462B sethintstring(&"MP/BR_RESPAWN_TAKE");
  self._id_462B setuseholdduration("duration_medium");
  var_0 = _id_68AB();

  foreach(var_2 in var_0) {
    var_2._id_C6A0 _id_FE66(var_2.team);
  }
}

_id_1910() {
  for(var_0 = 0; var_0 < level._id_2AAD.size; var_0++) {
    var_1 = level._id_2AAD[var_0];

    if(isDefined(var_1) && !istrue(var_1._id_4A88)) {
      return 1;
    }
  }

  return 0;
}

_id_433F(var_0, var_1) {
  if(!istrue(level._id_2AAB)) {
    return;
  }
  for(var_2 = 0; var_2 < level._id_2AAD.size; var_2++) {
    var_3 = level._id_2AAD[var_2];

    if(isDefined(var_3) && !istrue(var_3._id_4A88) && distance2dsquared(var_0, var_3.origin) > var_1 * var_1) {
      var_3 _id_1680();
      _id_4AE2(var_3);
    }
  }
}

_id_4AE2(var_0) {
  var_1 = !_id_1910();

  if(!var_1 && !isDefined(var_0)) {
    return;
  }
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3._id_C6A0) && var_1) {
      var_3._id_C6A0 notify("respawnComplete", 0);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_3._id_FE42) && var_3._id_FE42 == var_0) {
      var_3 notify("defibrillator_done");
      var_3 notify("portable_defibrillator_done");
    }
  }
}

_id_B7AF() {
  return istrue(level._id_2AAB) && _id_1910() && (istrue(self._id_2C4C) || isDefined(self._id_C6A0));
}

_id_B7A1() {
  self._id_2C4C = 1;
  scripts\mp\gametypes\br_public::_id_D65F(1);
}

_id_B693(var_0, var_1) {
  if(!istrue(level._id_2AAB)) {
    return;
  }
  if(isDefined(var_0)) {
    var_0 _id_B805(var_1);
  }

  if(!_id_1910()) {
    if(istrue(self._id_59E0)) {
      thread scripts\mp\playerlogic::_id_E37D(self.origin, self.angles);
    }

    return;
  }

  self._id_2C4C = undefined;
  var_2 = self.team;

  if(level._id_EF6A[var_2]["alivePlayers"].size == 0) {
    foreach(var_5 in level._id_EF6A[var_2]["players"]) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(isDefined(var_5._id_C6A0)) {
        var_5._id_C6A0 notify("respawnComplete", 0);
      }
    }

    return;
  }

  if(isDefined(self._id_25CA)) {
    self._id_25CA delete();
  } else {
    self._id_A546 = 1;
  }

  self playerhide();
  self.health = 1;
  thread _id_B6EF();
  var_7 = _id_402D(self.origin, var_2);
  var_7._id_F258 = _id_4030(var_2, 180);
  _id_FC3F(var_7._id_F258);
  var_7._id_5033 = _id_3FC0(var_2);
  var_7 thread _id_FE65(180, self, var_2);
  var_7 thread _id_FE64(self, var_2);
  var_7 thread _id_FE63(self, var_2);
  var_7 _id_FE66(var_2);
  self._id_C6A0 = var_7;
  _id_B6A8(1);
}

_id_FC3F(var_0) {
  var_1 = -50;
  var_2 = -100;
  var_3 = -15;

  if(isDefined(var_0)) {
    level._id_2A33[level._id_2A33.size] = var_0;
  }

  for(var_4 = 1; var_4 < level._id_2A33.size; var_4++) {
    var_5 = level._id_2A33[var_4];

    for(var_6 = var_4 - 1; var_6 >= 0 && _id_6D3A(var_5, level._id_2A33[var_6]) == var_5; var_6--) {
      level._id_2A33[var_6 + 1] = level._id_2A33[var_6];
    }

    level._id_2A33[var_6 + 1] = var_5;
  }

  for(var_4 = 0; var_4 < level._id_2A33.size; var_4++) {
    var_5 = level._id_2A33[var_4];

    if(isDefined(var_5)) {
      var_5 scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var_1, var_2 + var_3 * var_4);
    }
  }
}

_id_6D3A(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(var_0._id_E72D <= var_1._id_E72D) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_B6A8(var_0) {
  var_1 = !var_0;
  self allowmelee(var_1);
  self allowads(var_1);
  self allowfire(var_1);
  self allowcrouch(var_1);
  self allowprone(var_1);
  self allowreload(var_1);
  self setCanDamage(var_1);

  if(var_1) {
    self enableusability();
    self enableoffhandweapons();
    self unlink();
    self setcamerathirdperson(0);
    self notify("stopFakeSpectate");
    self setclientomnvar("ui_show_spectateHud", -1);
  } else {
    self disableusability();
    self disableoffhandweapons();
    thread _id_B6A9();
    self setcamerathirdperson(1);
  }
}

_id_B6A9() {
  self endon("death_or_disconnect");
  self endon("stopFakeSpectate");
  var_0 = undefined;

  for(;;) {
    var_1 = self fragbuttonpressed();
    var_2 = self secondaryoffhandbuttonpressed();

    if(var_1 || var_2 || !isDefined(var_0) || !isalive(var_0) || isDefined(var_0._id_C6A0) || istrue(var_0._id_59E0)) {
      var_3 = _id_6C6B(self.team, var_0, var_1 || !isDefined(var_0));

      if(!isDefined(var_0) || var_0 != var_3) {
        var_0 = var_3;
        self playerlinktodelta(var_0, "tag_eye");
        self setclientomnvar("ui_show_spectateHud", var_0 getentitynumber());
        self playerhide();
      }

      if(var_1) {
        while(self fragbuttonpressed()) {
          waitframe();
        }
      } else if(var_2) {
        while(self secondaryoffhandbuttonpressed()) {
          waitframe();
        }
      }
    }

    waitframe();
  }
}

_id_6C6B(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1)) {
    for(var_4 = 0; var_4 < level._id_EF6A[var_0]["alivePlayers"].size; var_4++) {
      var_5 = level._id_EF6A[var_0]["alivePlayers"][var_4];

      if(var_5 == var_1) {
        var_3 = var_4;
        break;
      }
    }
  }

  if(var_2) {
    var_3 = (var_3 + 1) % level._id_EF6A[var_0]["alivePlayers"].size;
  } else {
    var_3--;

    if(var_3 < 0) {
      var_3 = level._id_EF6A[var_0]["alivePlayers"].size - 1;
    }
  }

  return level._id_EF6A[var_0]["alivePlayers"][var_3];
}

_id_B6EF() {
  self endon("disconnect");
  self waittill("spawned");
  self endon("spawned");

  for(;;) {
    var_0 = scripts\mp\class::_id_BB98(self.class, 1);
    var_1 = scripts\mp\playerlogic::_id_6C42(var_0);

    while(!scripts\mp\playerlogic::_id_15E9(var_1)) {
      wait 0.1;
    }

    while(scripts\mp\playerlogic::_id_15E9(var_1)) {
      wait 1.0;
    }
  }
}

_id_B805(var_0) {
  if(isalive(self) && isDefined(var_0) && isDefined(var_0.basename) && var_0.basename == "iw8_defibrillator_mp" && self hasweapon("iw8_defibrillator_mp")) {
    self takeweapon("iw8_defibrillator_mp");
    var_1 = self getweaponslistprimaries();

    if(var_1.size > 0 && !scripts\mp\utility\weapon::_id_8927(var_1[0])) {
      self switchtoweapon(var_1[0]);
    } else if(var_1.size > 1 && !scripts\mp\utility\weapon::_id_8927(var_1[1])) {
      self switchtoweapon(var_1[1]);
    } else if(self hasweapon("s4_me_fists_mp")) {
      self switchtoweapon("s4_me_fists_mp");
    } else {
      self giveweapon("s4_me_fists_mp");
      self switchtoweapon("s4_me_fists_mp");
    }

    self notify("defibrillator_done");
    self notify("portable_defibrillator_done");
  }
}

_id_FE65(var_0, var_1, var_2) {
  self endon("respawnComplete");
  var_1 scripts\engine\utility::_id_108AE(var_0, "disconnect");
  self notify("timeout");
  waittillframeend;

  foreach(var_4 in level._id_EF6A[var_2]["players"]) {
    if(isDefined(var_4) && isDefined(var_4._id_FE42) && isDefined(self._id_167D) && var_4._id_FE42 == self._id_167D) {
      var_4 notify("defibrillator_done");
    }
  }

  if(isDefined(var_1)) {
    var_1 _id_B6A8(0);
    var_1 thread scripts\mp\playerlogic::_id_E37D(var_1._id_C6A0.origin, var_1._id_C6A0.angles);
  }

  _id_3875(self, var_2);
}

_id_FE64(var_0, var_1) {
  self endon("timeout");
  var_0 endon("disconnect");
  self waittill("respawnComplete", var_2);

  if(istrue(var_2)) {
    if(isDefined(var_0._id_25CA)) {
      var_0._id_25CA delete();
    }

    var_0 _id_B768(self.origin, self.angles);
  } else if(isDefined(var_0)) {
    var_0 _id_B6A8(0);
    var_0 thread scripts\mp\playerlogic::_id_E37D(var_0._id_C6A0.origin, var_0._id_C6A0.angles);
  }

  waittillframeend;
  _id_3875(self, var_1);
}

_id_B768(var_0, var_1) {
  _id_B6A8(0);
  self._id_5EC7 = var_0;
  self._id_5EC2 = var_1;
  self._id_8A01 = 1;
  self._id_1643 = 1;
  scripts\mp\playerlogic::_id_E337(0, 0);
}

_id_FE63(var_0, var_1) {
  self endon("respawnComplete");
  self endon("timeout");
  var_0 endon("disconnect");

  for(;;) {
    self waittill("trigger", var_2);

    if(isDefined(var_0._id_25CA)) {
      var_0._id_25CA delete();
    }

    if(var_2.team != var_1) {
      continue;
    }
    _id_FE61(var_1);
    var_2 _id_B73D(self, var_1);
    _id_FE67(var_1);
  }
}

_id_FE61(var_0) {
  self makeunusable();
  _id_07F9::_id_A89F(self._id_A8DA);
}

_id_FE67(var_0) {
  self makeuseable();
  _id_07F9::_id_A8CA(self._id_A8DA, var_0);
  _func_0172(self._id_A8DA, 0);
}

_id_B73D(var_0, var_1) {
  self endon("droppedBody");
  var_2 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var_2.label = &"MP/BR_RESPAWN_BODY";
  self._id_79CE = var_2;

  if(isDefined(var_0._id_167D)) {
    var_0._id_167D _id_1681(var_1);
    var_0._id_167D = undefined;
  }

  var_0 _meth_82CB("sdr_cp_hostage_walk_hostage");
  var_0 linkto(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  var_0 thread _id_FE5F(self, var_2, var_1);
  var_0 thread _id_FE60(self, var_2, var_1);
  var_0 thread _id_FE62(var_1);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  _id_B79F(1);
  _id_DC80(var_1);

  foreach(var_4 in level._id_EF6A[var_1]["players"]) {
    if(isDefined(var_4)) {
      var_4 notify("defibrillator_done");
      var_4 thread scripts\mp\hud_message::showsplash("br_respawn_start");
    }
  }

  while(!self stancebuttonpressed() || !self isonground()) {
    waitframe();
  }

  _id_5010(var_0, self, var_2, var_1);
}

_id_B79F(var_0) {
  self._id_32E8 = var_0;
  var_1 = level._id_EF6A[self.team]["players"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_C6A0)) {
      if(!var_0) {
        var_3._id_C6A0 _meth_80E0(self);
        continue;
      }

      var_3._id_C6A0 disableplayeruse(self);
    }
  }
}

_id_FE5F(var_0, var_1, var_2) {
  self endon("droppedBody");
  var_0 scripts\engine\utility::waittill_any_3("disconnect", "death", "last_stand_start");
  _id_5010(self, var_0, var_1, var_2);
}

_id_FE60(var_0, var_1, var_2) {
  self endon("droppedBody");
  scripts\engine\utility::waittill_any_2("timeout", "respawnComplete");
  _id_5010(self, var_0, var_1, var_2);
}

_id_5010(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    var_1 _id_B79F(0);
  }

  if(isDefined(var_2)) {
    var_2 destroy();
  }

  if(var_0 _meth_81CC()) {
    var_0 unlink();
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0._id_5033.alpha = 0.0;
  var_0 _id_FE66(var_3);
  var_0 _meth_82CB("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_0 _meth_8642(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 notify("droppedBody");
}

_id_FE66(var_0) {
  var_1 = _id_6967(self.origin);

  if(isDefined(var_1)) {
    self._id_167D = var_1;
    var_1 _id_1683(var_0);
  }
}

_id_402D(var_0, var_1) {
  var_2 = spawn("script_model", var_0 + (0, 0, 1));
  var_2 setModel("fullbody_usmc_ar_scriptmover");
  var_2 _meth_82CB("sdr_cp_hostage_dropoff_ground_idle_pilot");
  var_2 _meth_8642(1);
  var_2 makeuseable();
  var_2 setcursorhint("HINT_NOICON");
  var_2 setuseholdduration("duration_medium");
  var_2 setuserange(120);
  var_2 sethintstring(&"MP/BR_PICKUP_PLAYER");
  var_2 _meth_83A1(0);
  var_2 _meth_81B0("outlinefill_nodepth_red");

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4.team == var_1) {
      var_2 _meth_81B1(var_4, "outlinefill_nodepth_red");

      if(!istrue(var_4._id_32E8)) {
        var_2 _meth_80E0(var_4);
      }

      continue;
    }

    var_2 disableplayeruse(var_4);
    var_2 _meth_81AE(var_4);
  }

  var_6 = _id_07F9::_id_C57D(1);
  var_2._id_A8DA = var_6;

  if(var_6 != -1) {
    _id_07F9::_id_A867(var_6, "invisible", (0, 0, 0));
    _id_07F9::_id_FB93(var_6, var_2);
    _id_07F9::_id_FB9D(var_6, 40);
    _id_07F9::_id_FB9E(var_6, "current");
    _id_07F9::_id_FB8F(var_6, "passive_icon_health_on_kill");
    _id_07F9::_id_FB98(var_6, 1);
    _id_07F9::_id_A8CA(var_6, var_1);
  }

  return var_2;
}

_id_4030(var_0, var_1) {
  var_2 = scripts\mp\hud_util::_id_404A("objective", 1.4, var_0);
  var_2.label = &"MP/BR_RESPAWN_DEATH_COUNTDOWN";
  var_2 _meth_8391(var_1);
  var_2._id_E72D = gettime();
  thread _id_3D9B(var_2);
  return var_2;
}

_id_3D9B(var_0) {
  var_1 = 0.5;
  var_2 = 2;
  var_3 = var_0.fontscale;
  var_0 changefontscaleovertime(var_1);
  var_0.fontscale = var_2;
  wait(var_1);

  if(isDefined(var_0)) {
    var_0 changefontscaleovertime(var_1);
    var_0.fontscale = var_3;
  }
}

_id_3875(var_0, var_1) {
  if(isDefined(var_0._id_F258)) {
    var_0._id_F258 destroy();
  }

  _id_FC3F();

  if(isDefined(var_0._id_5033)) {
    var_0._id_5033 destroy();
  }

  if(isDefined(var_0._id_167D)) {
    var_0._id_167D _id_1681(var_1);
    var_0._id_167D = undefined;
  }

  _id_07F9::_id_A89F(self._id_A8DA);
  _id_07F9::_id_C799(self._id_A8DA);
  var_0 delete();
  _id_78E4(var_1, 1);
}

_id_FE62(var_0) {
  self endon("droppedBody");
  var_1 = 0;

  for(;;) {
    var_2 = 0;

    for(var_3 = 0; var_3 < level._id_2AAD.size; var_3++) {
      var_4 = level._id_2AAD[var_3];

      if(!isDefined(var_4) || istrue(var_4._id_4A88)) {
        continue;
      }
      var_5 = var_4.origin;

      foreach(var_7 in level._id_EF6A[var_0]["players"]) {
        if(!isDefined(var_7)) {
          continue;
        }
        var_8 = distancesquared(var_5, var_7.origin);

        if(var_8 < 65536) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        break;
      }
    }

    if(!var_1 && var_2) {
      self._id_5033.alpha = 1.0;
    } else if(var_1 && !var_2) {
      self._id_5033.alpha = 0.0;
    }

    var_1 = var_2;
    wait 0.1;
  }
}

_id_3FC0(var_0) {
  var_1 = 1.3;
  var_2 = newteamhudelem(var_0);
  var_2.elemtype = "font";
  var_2.font = "default";
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.alpha = 0;
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 100);
  var_2.label = &"MP/BR_RESPAWN_DROP_BODY";
  return var_2;
}

_id_6CEE(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_C6A0)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_68AB() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_C6A0)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_6967(var_0) {
  for(var_1 = 0; var_1 < level._id_2AAD.size; var_1++) {
    var_2 = level._id_2AAD[var_1];

    if(!isDefined(var_2) || istrue(var_2._id_4A88)) {
      continue;
    }
    var_3 = distancesquared(var_2.origin, var_0);

    if(var_3 < 65536) {
      return var_2;
    }
  }
}

_id_167E(var_0) {
  if(var_0 hasweapon("iw8_defibrillator_mp")) {
    var_0 switchtoweapon("iw8_defibrillator_mp");
    return;
  }

  thread _id_1682();
  var_0._id_FE42 = self;
  self._id_462B hide();
  var_1 = var_0 _id_B6BD(self);

  if(isDefined(var_0)) {
    var_0 notify("defibrillator_done");
    var_0._id_FE42 = undefined;
  }

  self._id_462B show();

  if(isDefined(var_1)) {
    var_1._id_C6A0 notify("respawnComplete", 1);
    _id_167F();
  }
}

_id_167F() {
  self endon("disabled");
  _id_1686();
  wait 30;
  _id_1688();
}

_id_1682() {
  self notify("ambulanceDoSiren");
  self endon("ambulanceDoSiren");
  self playLoopSound("siren_ambulance_lp");
  wait 30;
  self stoploopsound();
}

_id_B6BD(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");
  var_1 = _id_6CEE(self.team);

  if(var_1.size == 0) {
    self iprintlnbold("No dead teammates");
  } else {
    self._id_90CD = self getcurrentprimaryweapon();
    var_2 = makeweapon("iw8_defibrillator_mp");
    self giveweapon(var_2);
    self switchtoweapon(var_2);
    thread _id_B720(var_2);
    thread _id_B7F0(var_2);
    thread _id_B71E(var_0);
  }
}

_id_B697(var_0) {
  for(;;) {
    self waittill("melee_fired", var_1);
    var_2 = 0;

    if(var_1.basename != "iw8_defibrillator_mp") {
      if(!self hasweapon("iw8_defibrillator_mp")) {
        return;
      }
    } else {
      var_3 = self getEye();
      var_4 = anglesToForward(self getplayerangles());
      var_5 = _id_6CEE(self.team);
      var_6 = 0;

      for(var_7 = 0; var_7 < var_5.size; var_7++) {
        var_8 = var_5[var_7];

        if(!isDefined(var_8) || !isDefined(var_8._id_C6A0)) {
          continue;
        }
        var_6 = 1;
        var_9 = var_8._id_C6A0.origin + (0, 0, 40);
        var_10 = vectornormalize(var_9 - var_3);
        var_11 = vectordot(var_10, var_4);

        if(var_11 < 0.5) {
          continue;
        }
        var_12 = distancesquared(self.origin, var_9);

        if(var_12 > 10000) {
          continue;
        }
        return var_8;
      }

      if(!var_6 && istrue(var_0)) {
        self iprintlnbold("No teammates to revive");
        return;
      }
    }
  }
}

_id_B720(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    self waittill("weapon_change", var_1);

    if(!issameweapon(var_0, var_1)) {
      self notify("defibrillator_done");
      return;
    }
  }
}

_id_B7F0(var_0) {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "last_stand_start", "defibrillator_done");

  if(isDefined(self) && self hasweapon(var_0)) {
    self takeweapon(var_0);
    self switchtoweapon(self._id_90CD);
  }
}

_id_B71E(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    var_1 = distancesquared(var_0.origin, self.origin);

    if(var_1 > 65536) {
      self notify("defibrillator_done");
      return;
    }

    wait 0.1;
  }
}

_id_7008(var_0) {
  self endon("death");
  self endon("disconnect");

  if(!istrue(level._id_2AAB)) {
    return;
  }
  if(var_0 != "iw8_defibrillator_mp") {
    return;
  }
  var_1 = _id_B699();

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_25CA)) {
      var_1._id_25CA delete();
    }

    var_1._id_C6A0 notify("respawnComplete", 1);
  }

  var_2 = makeweapon("iw8_defibrillator_mp");
  _id_B805(var_2);
}

_id_B699() {
  self endon("portable_defibrillator_done");
  return _id_B697();
}