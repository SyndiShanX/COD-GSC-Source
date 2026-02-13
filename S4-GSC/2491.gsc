/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2491.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "initSentrySettings")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "initSentrySettings")]]();
  }
}

_id_10D6E(var_0, var_1, var_2) {
  if(!istrue(var_1)) {
    _id_09B9::_id_6CF6(var_2);
  }
}

_id_F79D(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F79E(var_1);
}

_id_F79E(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      self._id_24F1 = 0;
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA04(var_0, makeweapon("deploy_sentry_mp"), 1, undefined, undefined, ::_id_10D6E);

  if(!istrue(var_1)) {
    self._id_24F1 = 0;
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      self._id_24F1 = 0;
      return 0;
    }
  }

  _id_09BA::_id_9A90(0);
  var_2 = _id_D0FF("sentry_turret", var_0);

  if(!isDefined(var_2)) {
    _id_09BA::_id_9A90(1);
    self._id_24F1 = 0;
    return 0;
  }

  var_3 = _id_D11D(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    _id_09BA::_id_9A90(1);
    var_2 delete();
    self._id_24F1 = 0;
    return 0;
  }

  var_2 _id_078D::_id_D3BA(::_id_D108);
  var_2 _id_078D::_id_D189(::_id_D107);
  _id_09BA::_id_9A90(1);
  _id_D114(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "munitionUsed")]]();
  }

  return 1;
}

_id_D11D(var_0, var_1, var_2, var_3) {
  self._id_24F1 = 1;
  var_0 _meth_8202();
  thread _id_D102(var_3);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "getTargetMarker")) {
    var_4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "getTargetMarker")]](var_1, var_2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var_4) || !isDefined(var_4._id_96CF)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_09BA::_id_9A8F("deploy_sentry_mp");
    }

    return undefined;
  }

  var_0 thread _id_09BA::_id_9A75(self, 1, 1);

  if(self hasweapon("deploy_sentry_mp")) {
    thread _id_09BA::_id_9A8F("deploy_sentry_mp", 1, 1);
  }

  var_5 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  return var_4;
}

_id_D102(var_0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("ui_turret_placement", 1);
  thread _id_09BA::_id_9A6E("death");
  thread _id_09BA::_id_9A6E("turret_placement_finished");
}

_id_D0FF(var_0, var_1) {
  var_2 = level._id_D0FA[var_0];
  var_3 = spawnturret("misc_turret", self.origin, level._id_D0FA[var_0].weaponinfo);
  var_3.owner = self;
  var_3.team = self.team;
  var_3.angles = self.angles;
  var_3.health = 9999;
  var_3.maxhealth = var_2.maxhealth;
  var_3.streakinfo = var_1;
  var_3._id_F89C = var_0;
  var_3._id_DBE2 = 1;
  var_3.ammocount = var_2._id_16CC;
  var_3._id_F224 = var_2._id_F224;
  var_3._id_32CA = self;
  var_3 _id_D115("placed");
  var_3 _meth_8378(var_3.owner);
  var_3 _meth_83A0(var_3.team);
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
  var_3 _meth_82ED(0.2);
  var_3._id_A0B2 = 0;
  var_3._id_7659 = 0;
  var_3._id_AD20 = 0;
  var_3._id_3D10 = 0.1;

  switch (var_0) {
    case "sentry_turret":
    default:
      var_3 _meth_8224();
      var_3 _meth_8331(80);
      var_3 _meth_8372(80);
      var_3 _meth_82F0(50);
      var_3 _meth_8395(60);
      var_3 _meth_8302(0.6, "pitch");
      var_3 _meth_8302(0.6, "yaw");
      var_3 _meth_8301(0.65);
      var_3 setdefaultdroppitch(-89.0);
      break;
  }

  var_3 _meth_839D(1);
  var_3 _id_078D::_id_1538(0);
  var_5 = anglesToForward(var_3.angles);
  var_6 = var_3 gettagorigin("tag_laser") + (0, 0, 10);
  var_6 = var_6 - var_5 * 20;
  var_7 = spawn("script_model", var_6);
  var_7 linkto(var_3);
  var_3.killcament = var_7;
  var_3._id_3A67 = spawn("script_model", var_3.origin);
  var_3._id_3A67.team = var_3.team;
  var_3._id_3A67.owner = var_3.owner;
  var_3._id_3A67 setModel("weapon_vm_mg_sentry_turret_invis_base");
  var_3._id_3A67 dontinterpolate();
  var_3._id_3A67 hide();
  return var_3;
}

_id_D114(var_0, var_1) {
  var_2 = level._id_D0FA[var_0._id_F89C];
  var_0 _id_D115("placed");

  if(!isDefined(self._id_B161)) {
    self._id_B161 = [];
  }

  if(!isDefined(self._id_B161[var_0._id_F89C])) {
    self._id_B161[var_0._id_F89C] = [];
  }

  if(istrue(var_0._id_DBE2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakinfo.streakname);
    }

    var_3 = var_2._id_EFAC;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_3, self);
    }

    var_0._id_DBE2 = 0;
  }

  var_0 show();
  var_0 dontinterpolate();
  var_0.angles = var_1.angles;
  var_0._id_32CA = undefined;
  self._id_24F1 = 0;
  var_0.origin = var_1._id_96CF;
  var_0._id_3A67 show();
  var_0._id_3A67.angles = var_0.angles;
  var_0._id_3A67.origin = var_0.origin;
  var_0._id_3A67 linkto(var_0, "tag_aim_pivot");
  var_4 = "icon_minimap_sentry";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_0._id_9F26 = var_0._id_3A67[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_4, var_0.team, undefined, 1, 1);
  }

  var_5 = self._id_B161[var_0._id_F89C].size;
  self._id_B161[var_0._id_F89C][var_5] = var_0;

  if(var_5 + 1 > 2) {
    self._id_B161[var_0._id_F89C][0] notify("kill_turret", 0, 0);
  }

  var_6 = 70;

  if(var_0.model == level._id_D0FA[var_0._id_F89C]._id_9FD2) {
    var_6 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0._id_F89C, "Killstreak_Ground", self, 0, 1, var_6, "carried");
  }

  var_0 setmode(level._id_D0FA[var_0._id_F89C]._id_D0F8);
  var_7 = "bi_base";

  if(!isDefined(var_0.useownerobj)) {
    var_8 = var_0 gettagorigin(var_7);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "createHintObject")) {
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "createHintObject")]](var_8, "HINT_BUTTON", undefined, var_2._id_ADB2);
    }
  } else {
    var_8 = var_0 gettagorigin(var_7);
    var_0.useownerobj makeuseable();
    var_0.useownerobj dontinterpolate();
    var_0.useownerobj.origin = var_8;
  }

  var_0.useownerobj linkto(var_0, var_7);

  foreach(var_10 in level.players) {
    if(var_10 != var_0.owner) {
      var_0.useownerobj disableplayeruse(var_10);
    }
  }

  var_0 _id_078D::_id_1538(1);
  var_0 _id_0812::_id_C2B2("Killstreak_Static", self);
  var_0 _id_D109();
  var_0 thread _id_D0CE();
  var_0 thread _id_D0CF();
  thread _id_D101(var_0, var_1);
  thread _id_D11C(var_0);
  thread _id_D117(var_0);
  thread _id_D118(var_0);
  thread _id_D11E(var_0);
  thread _id_D11A(var_0);
  thread _id_D11B(var_0);
  var_0 notify("turret_place_successful");
}

_id_D112(var_0) {
  var_0 endon("kill_turret");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      waitframe();
    }
  }

  var_0 _id_078D::_id_1538(0);
  var_0 _id_0812::_id_F9A3(var_0._id_D0CA, var_0._id_D0CB);
  var_1 = var_0 _meth_8150();

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 unlink();
    }
  }

  if(isDefined(var_0._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_9F26);
    }

    var_0._id_9F26 = undefined;
  }

  var_0._id_3A67 unlink();
  var_0._id_3A67 hide();
  _id_D113(var_0);
  var_0 hide();
  var_0._id_32CA = self;
  var_0 notify("carried");
  var_0 playSound("sentry_pickup");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_sentry_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_sentry_mp");
  _id_09BA::_id_9A90(0);
  var_5 = _id_D11D(var_0, var_0.streakinfo, 1, 2);

  if(!isDefined(var_5)) {
    _id_09BA::_id_9A90(1);
    return 0;
  }

  _id_09BA::_id_9A90(1);
  _id_D114(var_0, var_5);
}

_id_D116(var_0) {
  if(istrue(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self._id_8FC2);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_8FC2);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_sentry_mp");
}

_id_D113(var_0) {
  var_0 setdefaultdroppitch(30);
  var_0 setmode(level._id_D0FA[var_0._id_F89C]._id_D0F7);
  var_0.useownerobj makeunusable();
  var_0.useownerobj unlink();
}

_id_D101(var_0, var_1) {
  var_0 endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var_1._id_04ED)) {
    var_1._id_04ED delete();
  }
}

_id_D106(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 endon("kill_turret");
    var_0 endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_2);
    var_1 disableplayeruse(var_2);
  }
}

_id_D11C(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0.useownerobj waittill("trigger", var_1);

    if(var_1 != self) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    if(istrue(var_1._id_88DF)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    var_0.useownerobj makeunusable();
    var_0 setmode(level._id_D0FA[var_0._id_F89C]._id_D0F7);
    self._id_B161[var_0._id_F89C] = ::scripts\engine\utility::array_remove(self._id_B161[var_0._id_F89C], var_0);
    thread _id_D112(var_0);
  }
}

_id_D105(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");
    var_0.useownerobj disableplayeruse(var_1);
  }
}

_id_D119(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(level.teambased) {
      if(var_2.team != self.team) {
        continue;
      }
    } else if(var_2 != self)
      continue;
  }

  thread _id_D104(var_0);

  for(;;) {
    var_0._id_4B3C waittill("trigger", var_2);
    var_0 notify("kill_turret", 0, 1);
    break;
  }
}

_id_D117(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "monitorDamage")]](var_0);
  }
}

_id_D104(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");

    if(level.teambased) {
      if(var_1.team != self.team) {
        continue;
      }
    }
  }
}

_id_D108(var_0) {
  _id_D109();
}

_id_D107(var_0) {
  if(var_0) {
    return;
  }
  _id_D109();
}

_id_D109() {
  if(_id_078D::_id_85B3()) {
    self _meth_8410();
    self setmode(level._id_D0FA[self._id_F89C]._id_D0F7);
    self _meth_8202();
  } else {
    self _meth_8411();
    self setmode(level._id_D0FA[self._id_F89C]._id_D0F8);
  }
}

_id_D118(var_0) {
  var_0 endon("carried");
  var_0 waittill("kill_turret", var_1, var_2);

  if(isDefined(self)) {
    self._id_B161[var_0._id_F89C] = ::scripts\engine\utility::array_remove(self._id_B161[var_0._id_F89C], var_0);
    _id_D113(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    var_0.streakinfo._id_57A7 = istrue(var_2);
    scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0.streakinfo);
  }

  var_0 _id_D115("destroyed");
  var_0 _meth_8378(undefined);

  if(!istrue(var_1)) {
    var_0 playSound("sentry_explode_smoke");
    var_0 setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    var_0 setscriptablepartstate("explode", "regular");
  } else
    var_0 setscriptablepartstate("explode", "violent");

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0.streakinfo);
  }

  if(isDefined(var_0.killcament)) {
    var_0.killcament delete();
  }

  if(isDefined(var_0.useownerobj)) {
    var_0.useownerobj delete();
  }

  if(isDefined(var_0.useotherobj)) {
    var_0.useotherobj delete();
  }

  if(isDefined(var_0._id_3A67)) {
    var_0._id_3A67 delete();
  }

  if(isDefined(var_0._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_9F26);
    }

    var_0._id_9F26 = undefined;
  }

  wait 0.2;
  var_0 delete();
}

_id_D103() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

_id_D11E(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(var_0._id_F224 > 0) {
    var_0._id_F224 = var_0._id_F224 - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDialogOnPlayer")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDialogOnPlayer")]]("destroyed_" + var_0.streakinfo.streakname, undefined, undefined, self.origin);
  }

  var_0 notify("kill_turret", 0, 0);
}

_id_D11A(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  var_0 notify("kill_turret", 0, 0);
}

_id_D11B(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried");
  level waittill("game_ended");
  var_0 notify("kill_turret", 0, 0);
}

_id_D115(var_0) {
  var_1 = undefined;

  if(var_0 == "placed") {
    var_1 = level._id_D0FA[self._id_F89C]._id_9FD3;
  } else {
    var_1 = level._id_D0FA[self._id_F89C]._id_9FD7;
  }

  self setModel(var_1);
}

_id_D0CE() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self._id_A0B2 = 0;

  for(;;) {
    self waittill("turretstatechange");

    if(self _meth_81C1()) {
      self _meth_8203();
      thread _id_D0D0();
      continue;
    }

    self _meth_8202();
    _id_D0F0();
    thread _id_D0D1();
  }
}

_id_D0F2() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

_id_D0F1() {
  thread _id_D0F2();

  while(self._id_A0B2 < level._id_D0FA[self._id_F89C]._id_E410) {
    self._id_A0B2 = self._id_A0B2 + 0.1;
    wait 0.1;
  }
}

_id_D0F0() {
  self._id_A0B2 = 0;
}

_id_D0D0() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_D0F1();
  var_0 = weaponfiretime(level._id_D0FA[self._id_F89C].weaponinfo);
  var_1 = level._id_D0FA[self._id_F89C]._id_2DB2;
  var_2 = level._id_D0FA[self._id_F89C]._id_2DB1;
  var_3 = level._id_D0FA[self._id_F89C]._id_AF6E;
  var_4 = level._id_D0FA[self._id_F89C]._id_AF6C;
  var_5 = level._id_D0FA[self._id_F89C]._id_9708;

  for(;;) {
    var_6 = randomintrange(var_1, var_2 + 1);

    for(var_7 = 0; var_7 < var_6 && !self._id_AD20; var_7++) {
      self _meth_83C1("tag_flash", var_5);
      self.streakinfo._id_DA63++;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_D0D1() {
  self notify("stop_shooting");
}

_id_F842() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  var_0 = level._id_D0FA[self._id_F89C]._id_AD21;

  for(;;) {
    if(self._id_7659 > var_0) {
      self._id_AD20 = 1;

      while(self._id_7659) {
        wait 0.1;
      }

      self._id_AD20 = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

_id_B84E() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level._id_D0FA[self._id_F89C]._id_609D);
  }
}

_id_F826() {
  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  for(;;) {
    if(self._id_7659 > 0) {
      if(self._id_3D10 <= 0) {
        self._id_7659 = max(0, self._id_7659 - 0.05);
      } else {
        self._id_3D10 = max(0, self._id_3D10 - 0.05);
      }
    }

    wait 0.05;
  }
}

_id_D0CF() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(self _meth_81C1()) {
      waitframe();
      continue;
    }
  }
}