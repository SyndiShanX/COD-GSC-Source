/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2645.gsc
*************************************************/

init() {
  level._effect["mortar_initial_flare"] = loadfx("vfx/iw8_mp/killstreak/vfx_white_phosphorus_expl_inair.vfx");
  level._effect["mortar_impact"] = loadfx("vfx/s4/killstreaks/vfx_bombingrun_exp_imp_lrg_01.vfx");
  level._id_8DE5["mortar_barrage"] = spawnStruct();
  level._id_8DE5["mortar_barrage"]._id_47EE = makeweapon("s4_binoculars_mp", ["spotterscope"]);
  scripts\mp\killstreaks\killstreaks::_id_C26A("mortar_barrage", ::_id_F793);
}

_id_F793(var_0) {
  if(getdvarint("#x3e053f1648b775d4d", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  self._id_BC6B = self getcurrentweapon();
  var_1 = makeweapon("s4_ks_flare_canister_mp");
  self._id_47EE = var_1;
  var_2 = _id_09B9::_id_EA03(var_0, var_1, "grenade_fire", ::_id_10D93, ::_id_10DE0, ::_id_10D81);

  if(isDefined(var_2) && !var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_mortar_fail");
    }

    return 0;
  }

  var_3 = self._id_5C57 scripts\engine\utility::_id_108A7(5, "missile_stuck");

  if(!isDefined(var_3) || var_3 == "timeout") {
    return 0;
  }

  var_4 = self._id_5C57.origin;

  if(!isDefined(var_4)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_mortar_fail");
    }

    return 0;
  }

  if(_id_3362(var_4, var_4 + (0, 0, 10000))) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_mortar_fail");
    }

    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/MORTAR_BARRAGE_INVALID_PLACEMENT");
    return 0;
  }

  var_5 = _id_68AE(var_4, 300.0);
  thread _id_90FC(var_4, var_5, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_mortar_barrage", self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  return 1;
}

_id_68AE(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < 13; var_3++) {
    var_4 = randomint(360);
    var_5 = randomfloat(var_1);
    var_2[var_3] = var_0 + rotatevector((1, 0, 0), (0, var_4, 0)) * var_5;
  }

  return var_2;
}

burnatorigin(var_0) {
  self endon("end_flare_burn");

  while(!isDefined(self.mortarflare)) {
    waitframe();
  }

  var_1 = self.mortarflare;

  for(;;) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, var_0) < 60) {
        var_3 dodamage(8, var_0, self, var_1, "MOD_FIRE", "s4_ks_flare_canister_mp");
      }
    }

    wait 0.2;
  }
}

_id_90FC(var_0, var_1, var_2) {
  thread burnatorigin(var_0);
  wait 8.0;
  self notify("end_flare_burn");
  var_3 = (0, 0, -750);

  foreach(var_5 in var_1) {
    var_6 = var_5 + (0, 0, 1500);
    thread _id_503E(var_6, var_3, var_2);
    var_7 = randomfloatrange(1.66, 2.17);
    wait(var_7);
  }

  self notify("mortar_barrage_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_2);
}

_id_503E(var_0, var_1, var_2) {
  var_3 = magicgrenademanual("s4_ks_mortar_mp", var_0, var_1, 10, self);
  var_3.angles = vectortoangles((0, 0, -1));
  var_3 setmissileminimapvisible(1);
  var_3 setentityowner(self);
  var_3 setotherent(self);
  var_3._id_57B8 = spawn("script_model", var_3.origin);
  var_3._id_57B8 linkto(var_3);
  var_3._id_57B8 dontinterpolate();
  var_3._id_57B8 setentityowner(self);
  var_3.owner = self;
  var_3.streakinfo = var_2;
  thread _id_084C::_id_A16E(var_3);
  var_3 thread _id_A1A9(vectortoangles(var_1), gettime(), var_1);
}

_id_A1A9(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var_3);
  self setmissileminimapvisible(0);
  self hide();
  wait 0.05;
  var_4 = -1 * getdvarint("#x33c01342f08fa6256", 800);
  var_5 = (gettime() - var_1) / 1000;
  var_6 = var_2 + (0, 0, var_4 * var_5);
  thread _id_A192(self.origin);
}

_id_A192(var_0) {
  self endon("death");
  self._id_57CE = 1;
  self._id_57B8 unlink();
  self._id_57B8.origin = var_0;
  playFX(level._effect["mortar_impact"], var_0);
  self radiusdamage(var_0, 550.0, 125, 40, self.owner, "MOD_EXPLOSIVE", self.weapon_name);
  thread _id_084C::_id_A16D(var_0);
  thread _id_0814::_id_7144(var_0, 1.25);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(isDefined(self._id_57B8)) {
    self._id_57B8 delete();
  }

  self delete();
}

_id_10D93(var_0) {
  return 1;
}

_id_10DE0(var_0, var_1) {
  var_0 endon("killstreak_finished_with_deploy_weapon");
  self allowfire(0);
  self notifyonplayercommand("flare_cannister_use", "+frag");
  self notifyonplayercommand("flare_cannister_use", "+attack");
  self notifyonplayercommand("flare_cannister_use", "+speed_throw");

  if(istrue(var_1)) {
    thread _id_10BE9(var_0);

    for(;;) {
      self waittill("flare_cannister_use");
      var_2 = self _meth_887B(self._id_47EE);

      if(isDefined(var_2) && _id_3362(var_2, var_2 + (0, 0, 10000))) {
        scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/MORTAR_BARRAGE_INVALID_PLACEMENT");
        waitframe();
        continue;
      }

      self allowfire(1);
      self notify("flare_cannister_used");
      var_3 = self getcurrentweapon();
      self switchtoweaponimmediate(var_3);
      return;
    }
  }
}

getprojectilepositionattime(var_0, var_1, var_2) {
  return var_0 + var_1 * var_2 + (0, 0, 1 - getdvarfloat("bg_gravity")) * var_2 * var_2 * 0.5;
}

_id_10BE9(var_0) {
  self endon("flare_cannister_used");
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  var_1 = scripts\engine\utility::_id_10897("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  self allowfire(1);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  self notify("cancel_all_killstreak_deployments");
}

_id_10AED(var_0) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("ks_airstrike_marker_mp");
  var_1._id_A908 = _id_07F9::_id_C57D(99);
  var_1 setotherent(self);
  var_1 dontinterpolate();
  var_1 hide();
  var_2 = "hud_icon_killstreak_tomastrike";
  var_1 _id_D5F2(var_1._id_A908, var_2, self, 50);
  var_1 thread _id_10BC4(self);
  var_1 thread _id_10AC5(self);
  var_1 thread _id_10AC7(self);
  var_1._id_FCB9 = 0;
  scripts\common\utility::_id_153E(0);

  for(;;) {
    if(_id_078D::_id_85B3() && istrue(var_1._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_1 hide();
      self notify("stop_update_marker");
      var_1._id_FCB9 = 0;
    }

    var_3 = self playerads();

    if(var_3 == 1 && !istrue(var_1._id_FCB9)) {
      if(!_id_078D::_id_85B3()) {
        scripts\common\utility::_id_153E(1);
        var_1 show();
        var_1 thread _id_FCBA(self);
        var_1._id_FCB9 = 1;
      }
    } else if(var_3 < 1 && istrue(var_1._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_1 hide();
      self notify("stop_update_marker");
      var_1._id_FCB9 = 0;
    }

    waitframe();
  }
}

_id_D5F2(var_0, var_1, var_2, var_3) {
  _func_015D(var_0, var_1);
  _func_018C(var_0);
  _func_0185(var_0, var_2);
  _func_0160(var_0, self);
  _func_0161(var_0, var_3);
  _func_0172(var_0, 0);
  _func_0173(var_0, 0);
  _func_017A(var_0, 1);

  if(level.teambased) {
    _func_0182(var_0, var_2.team);
  } else {
    _func_0181(var_0, var_2);
  }

  _func_016B(var_0, "done");
}

_id_10BC4(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 waittill("death_or_disconnect");
  _id_C4E4();
}

_id_C4E4(var_0) {
  if(isDefined(var_0)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(isDefined(self._id_A908)) {
    _id_07F9::_id_C799(self._id_A908);
  }

  self delete();
}

_id_10AC5(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 scripts\engine\utility::_id_10897("cancel_fire", "successful_fire");

  if(isDefined(var_1) && var_1 == "successful_fire") {
    var_0 notify("deploy_fired");
    var_2 = anglesToForward(var_0 getplayerangles());
    var_3 = self.origin - var_2 * 500;
    var_4 = self.origin + var_2 * 20;
    var_5 = scripts\engine\trace::ray_trace(var_3, var_4, self);
    var_6 = var_5["normal"];
    self.angles = _func_0316(var_6, self.angles);
    _func_016B(self._id_A908, "current");
    thread _id_C4E4(28.21);
  } else {
    var_0 notify("deploy_cancelled");

    if(!var_0 scripts\mp\utility\player::_id_8989()) {
      var_0 scripts\common\utility::_id_153E(1);
    }

    _id_C4E4();
  }
}

_id_10AC7(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 getcurrentweapon();

  for(;;) {
    if(var_0 getcurrentweapon() != var_1) {
      break;
    }

    waitframe();
  }

  var_0 notify("cancel_fire");
}

_id_10D81(var_0, var_1, var_2) {
  self._id_5C57 = var_2;
  thread _id_1D49(var_2, var_0);
  return "success";
}

_id_FCBA(var_0) {
  self endon("death");
  var_0 endon("deploy_cancelled");
  var_0 endon("deploy_fired");
  var_0 endon("stop_update_marker");
  var_0 endon("death_or_disconnect");
  var_1 = 0;
  var_0 setclientomnvar("ui_spotter_scope_danger", 0);

  for(;;) {
    var_2 = _id_6C01(var_0);
    var_3 = -1;
    var_4 = -1;
    var_5 = -1;

    if(isDefined(var_2)) {
      self.origin = var_2;
      var_3 = int(self.origin[0]);
      var_4 = int(self.origin[1]);
      var_5 = int(self.origin[2]);
    }

    var_0 setclientomnvar("ui_ac130_coord3_posx", var_3);
    var_0 setclientomnvar("ui_ac130_coord3_posy", var_4);
    var_0 setclientomnvar("ui_ac130_coord3_posz", var_5);

    if(isDefined(var_2)) {
      if(!istrue(var_1) && distance2dsquared(var_0.origin, var_2) <= 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 1);
        var_1 = 1;
      } else if(istrue(var_1) && distance2dsquared(var_0.origin, var_2) > 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 0);
        var_1 = 0;
      }
    }

    waitframe();
  }
}

_id_6C01(var_0) {
  var_1 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  var_2 = physics_createcontents(var_1);
  var_3 = var_0 getvieworigin();
  var_4 = var_3 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_5 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_B702();
  var_6 = scripts\engine\trace::ray_trace(var_3, var_4, var_5, var_2);
  var_7 = var_6["position"];

  if(var_6["hittype"] == "hittype_none") {
    var_7 = undefined;
  }

  return var_7;
}

_id_D06F(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = "used_" + var_0.streakname;
  var_1 = _id_6C01(self);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");
  thread scripts\mp\hud_util::_id_EF8D(var_5, self);
  _id_07EE::_id_97A4(var_0.streakname, var_1);
  return var_1;
}

_id_1D49(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 _id_078E::_id_C2B5(2, ::_id_4774);
  thread scripts\mp\weapons::_id_A106(self, var_0);
  var_0 waittill("missile_stuck", var_2);

  if(isDefined(var_2)) {
    var_0 linkto(var_2);
  }

  thread _id_1D44(var_0);
  var_0.streakinfo = var_1;
  self.mortarflare = var_0;
  return 1;
}

_id_1D44(var_0) {
  var_0 endon("mine_destroyed");
  var_0 endon("death");
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0 _meth_85B9();
  var_0 _meth_85BA();
  var_0 setnodeploy(1);
  thread scripts\mp\weapons::_id_ACD8(var_0);
  wait 1;

  if(isDefined(var_0.origin) && !_id_3362(var_0.origin, var_0.origin + (0, 0, 10000))) {
    var_0._id_5C52 = spawn("script_model", var_0.origin);
    var_0._id_5C52 setModel("ks_mortar_barrage_mp");
    var_0._id_5C52.angles = var_0.angles;
    var_0._id_5C52 setscriptablepartstate("flare", "on", 0);
    wait 8.0;
    var_0._id_5C52 setscriptablepartstate("flare", "off", 0);
    var_0._id_5C52 setscriptablepartstate("flare_death", "on", 0);
    var_0.streakinfo = undefined;
    self.mortarflare = undefined;
    self waittill("mortar_barrage_ended");
  }

  wait 3;
  var_0 _id_4774();
}

_id_4774() {
  self._id_5C57 = undefined;
  self delete();
}

_id_3362(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = var_2["position"];
    var_4 = var_2["normal"];
    return var_3 != var_1;
  }

  return 1;
}