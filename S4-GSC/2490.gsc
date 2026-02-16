/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2490.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "init")]]();
  }

  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("manual_turret", "on", 10);
}

_id_10D6D(var_0, var_1, var_2) {
  if(!istrue(var_1)) {
    _id_09B9::_id_6CF6(var_2);
  }
}

_id_F791(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F792(var_1);
}

_id_F792(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA04(var_0, makeweapon("deploy_manual_turret_mp"), 1, undefined, undefined, ::_id_10D6D);

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  _id_9A90(0);
  var_2 = _id_9A6F("manual_turret", var_0);

  if(!isDefined(var_2)) {
    _id_9A90(1);
    return 0;
  }

  var_3 = _id_9A99(var_2, var_0, 0, 1.25);

  if(!isDefined(var_3)) {
    _id_9A90(1);
    var_2 delete();
    return 0;
  }

  _id_9A90(1);
  _id_9A8D(var_2, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "munitionUsed")]]();
  }

  return 1;
}

_id_9A99(var_0, var_1, var_2, var_3) {
  thread _id_9A71(var_3);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "watchForPlayerEnteringLastStand")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getTargetMarker")) {
    var_4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getTargetMarker")]](var_1, var_2);
  }

  self notify("turret_placement_finished");

  if(!isDefined(var_4) || !isDefined(var_4._id_96CF)) {
    if(istrue(self.inlaststand)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("deploy_manual_turret_mp");
    } else if(scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_9A8F("deploy_manual_turret_mp");
    }

    return undefined;
  }

  var_0 thread _id_9A75(self, 1, 1);

  if(self hasweapon("deploy_manual_turret_mp")) {
    thread _id_9A8F("deploy_manual_turret_mp", 1, 1);
  }

  var_5 = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  return var_4;
}

_id_9A71(var_0) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setclientomnvar("ui_turret_placement", 1);
  thread _id_9A6E("death");
  thread _id_9A6E("turret_placement_finished");
}

_id_9A6E(var_0) {
  self endon("cleared_placement");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var_0);
  self setclientomnvar("ui_turret_placement", 0);
  self notify("cleared_placement");
}

_id_9A6F(var_0, var_1) {
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
  var_3._id_C735 = "reticle_on";
  var_3._id_F224 = var_2._id_F224;
  var_3._id_32CA = self;
  var_3 _id_9A8E("placed");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_3 hide();
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
  var_3._id_3A67._id_A257 = 1;
  var_3._id_3A67._id_F88F = var_3;
  return var_3;
}

_id_9A8D(var_0, var_1) {
  var_2 = level._id_D0FA[var_0._id_F89C];
  var_0 _id_9A8E("placed");

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

  if(isDefined(self._id_78E8)) {
    for(var_4 = self._id_78E8; var_4 >= 1; var_4--) {
      var_0 setscriptablepartstate("hide_ammo_" + var_4, "on", 0);
    }
  }

  var_5 = "off";

  if(var_0._id_C735 == "reticle_off") {
    var_5 = "on";
  }

  var_0 setscriptablepartstate("hide_reticle", var_5, 0);
  var_0.origin = var_1._id_96CF;
  var_0._id_3A67 show();
  var_0._id_3A67.angles = var_0.angles;
  var_0._id_3A67.origin = var_0.origin;
  var_0._id_3A67 linkto(var_0, "tag_aim_pivot");
  var_6 = "icon_minimap_mobileturret";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_0._id_9F26 = var_0._id_3A67[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_6, var_0.team, undefined, 1, 1);
  }

  var_7 = self._id_B161[var_0._id_F89C].size;
  self._id_B161[var_0._id_F89C][var_7] = var_0;

  if(var_7 + 1 > 1) {
    self._id_B161[var_0._id_F89C][0] notify("kill_turret", 0, 0);
  }

  var_8 = 70;

  if(var_0.model == level._id_D0FA[var_0._id_F89C]._id_9FD2) {
    var_8 = 35;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0._id_F89C, "Killstreak_Ground", self, 0, 1, var_8, "carried_turret");
  }

  var_0 setmode(level._id_D0FA[var_0._id_F89C]._id_D0F8);
  var_9 = "j_trigger";

  if(!isDefined(var_0.useownerobj)) {
    var_10 = var_0 gettagorigin(var_9);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_10, "HINT_BUTTON", undefined, var_2._id_ADB2, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var_10 = var_0 gettagorigin(var_9);
    var_0.useownerobj makeuseable();
    var_0.useownerobj dontinterpolate();
    var_0.useownerobj.origin = var_10;
  }

  var_0.useownerobj linkto(var_0, var_9);

  if(!isDefined(var_0.useotherobj)) {
    var_10 = var_0 gettagorigin(var_9);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "createHintObject")) {
      var_0.useotherobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "createHintObject")]](var_10, "HINT_BUTTON", undefined, var_2._id_AC9E, -1, "duration_none", undefined, 17, undefined, 17);
    }
  } else {
    var_10 = var_0 gettagorigin(var_9);
    var_0.useotherobj makeuseable();
    var_0.useotherobj dontinterpolate();
    var_0.useotherobj.origin = var_10;
  }

  var_0.useotherobj linkto(var_0, var_9);
  var_0 _id_078D::_id_1538(1);
  var_0 _id_0812::_id_C2B2("Killstreak_Static", self);
  var_0 thread _id_9A70(self, var_1);
  var_0 thread _id_9A9D(self, var_0.useownerobj);
  var_0 thread _id_9A9D(self, var_0.useotherobj);
  var_0 thread _id_9A98(self);
  var_0 thread _id_9A92(self);
  var_0 thread _id_9A93(self);
  var_0 thread _id_9A94();
  var_0 thread _id_9A9B(self);
  var_0 thread _id_9A97(self);
}

_id_9A8B(var_0) {
  self endon("kill_turret");
  var_0 endon("death_or_disconnect");
  var_0 endon("start_turret_use");
  level endon("game_ended");

  if(istrue(self._id_84EF)) {
    self._id_84EF = undefined;
    var_0 scripts\common\utility::_id_1587(1);
    var_0 scripts\common\utility::_id_1559(1);
  }

  _id_078D::_id_1538(0);
  _id_0812::_id_F9A3(self._id_D0CA, self._id_D0CB);
  var_1 = self _meth_8150();

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 unlink();
    }
  }

  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }

    self._id_9F26 = undefined;
  }

  self._id_3A67 hide();
  var_0 _id_9A8C(self);
  self hide();
  self._id_32CA = var_0;
  self notify("carried_turret");
  self playSound("sentry_pickup");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("deploy_manual_turret_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweapon("deploy_manual_turret_mp");
  var_0 _id_9A90(0);
  var_5 = var_0 _id_9A99(self, self.streakinfo, 1, 2);

  if(!isDefined(var_5)) {
    var_0 _id_9A90(1);
    return 0;
  }

  var_0 _id_9A90(1);
  var_0 _id_9A8D(self, var_5);
}

_id_9A8F(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 > 0) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  }

  if(istrue(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(self._id_8FC2);
  } else {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_8FC2);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
}

_id_9A8C(var_0) {
  var_0 setmode(level._id_D0FA[var_0._id_F89C]._id_D0F7);
  var_0 _meth_839C(0);
  var_0 _id_9A85(0);
  var_0.useownerobj unlink();
  var_0.useotherobj unlink();
}

_id_9A70(var_0, var_1) {
  self endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(var_1._id_04ED)) {
    var_1._id_04ED delete();
  }
}

_id_9A9D(var_0, var_1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  foreach(var_3 in level.players) {
    var_1 _meth_80E0(var_3);

    if(var_1 == self.useownerobj) {
      if(var_3 == var_0) {
        continue;
      }
    } else if(level.teambased && var_3.team == var_0.team && var_3 != var_0) {
      continue;
    }
    var_1 disableplayeruse(var_3);
  }

  thread _id_9A78(var_0, var_1);

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(istrue(self._id_84EF)) {
      continue;
    }
    if(istrue(self._id_E911)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(var_3 isonladder() || !var_3 isonground() || var_3 _meth_81CE()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }

      continue;
    }

    if(istrue(var_3._id_88DF)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    self._id_84EF = 1;
    var_3 scripts\common\utility::_id_1587(0);
    var_3 scripts\common\utility::_id_1559(0);
    var_3 _meth_80AF();

    if(var_3 == var_0) {
      for(var_5 = 0; var_3 useButtonPressed() && var_5 < 0.25; var_5 = var_5 + level._id_5F3A) {
        waitframe();
      }

      if(var_5 >= 0.25) {
        var_3 _meth_80E2();
        continue;
      }
    }

    var_3 notify("start_turret_use");
    self._id_B80F = var_3;
    _id_9A85(0);
    var_3.useweapon = level._id_D0FA[self._id_F89C]._id_B820;
    var_3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3.useweapon, undefined, undefined, 1);
    var_6 = gettime();
    var_7 = undefined;

    while(gettime() - var_6 < 1000.0) {
      var_7 = _id_9A7A(var_3, var_3.useweapon);

      if(!isDefined(var_7) || istrue(var_7)) {
        break;
      }

      waitframe();
    }

    if(!istrue(var_7)) {
      self._id_84EF = undefined;
      self._id_B80F = undefined;
      _id_9A85(1);

      if(isDefined(var_3)) {
        if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 scripts\common\utility::_id_1587(1);
          var_3 scripts\common\utility::_id_1559(1);
          var_3 switchtoweaponimmediate(var_3._id_8FC2);
        }

        var_3 _meth_858D(var_3.useweapon);
        var_3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3.useweapon);
      }

      continue;
    }

    var_3._id_4205 = self;
    var_3 controlturreton(self);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      var_3 scripts\common\utility::_id_155D(0);
    }

    _id_9A6D(var_3);
    thread _id_9A75(var_3, 0.5, 1);
    thread _id_9A91(var_3);
    thread _id_9A80(var_3);
    thread _id_9A82(var_3);
    thread _id_9A83(var_3);
    thread _id_9A7F(var_3);
    thread _id_9A9A(var_3);
  }
}

_id_9A7A(var_0, var_1) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_timeout");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  thread _id_9A9C(1.0);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  self notify("turret_switch_weapon_ended");
  return var_2;
}

_id_9A9C(var_0) {
  self endon("kill_turret");
  self endon("turret_switch_weapon_ended");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self notify("turret_switch_weapon_timeout");
}

_id_9A96(var_0, var_1) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  foreach(var_3 in level.players) {
    var_1 _meth_80E0(var_3);

    if(level.teambased && var_3.team != var_0.team) {
      continue;
    } else if(!level.teambased) {
      if(var_3 != var_0) {
        continue;
      }
    }

    var_1 disableplayeruse(var_3);
  }

  thread _id_9A76(var_0);

  for(;;) {
    var_1 waittill("trigger", var_3);
    self notify("kill_turret", 0, 1);
    break;
  }
}

_id_9A6D(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "on");
  var_0 setclientomnvar("ui_mobile_turret_controls", 1);
  var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

_id_9A89(var_0) {
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_mobile_turret_controls", 0);
}

_id_9A75(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_0 endon("death_or_disconnect");
    level endon("game_ended");
  }

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 freezecontrols(1);
  } else {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 freezecontrols(0);
  } else {
    return;
  }
}

_id_9A7C(var_0) {
  if(!isDefined(self._id_5425)) {
    self._id_5425 = [];
  }

  thread _id_9A7D(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "getEnemyPlayers")) {
    foreach(var_2 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "getEnemyPlayers")]](var_0.team)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
            thread _id_9A7B(var_0, var_2, 1);
          } else if(isDefined(var_2._id_1FAF) && var_2._id_1FAF > 0) {
            thread _id_9A7B(var_0, var_2);
          }

          continue;
        }
      }

      _id_9A6C(var_0, var_2);
    }
  }
}

_id_9A7D(var_0) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");

  for(;;) {
    level waittill("connected", var_1);
    thread _id_9A7B(var_0, var_1, 1);
  }
}

_id_9A88(var_0, var_1, var_2) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_1 waittill("death_or_disconnect");
  _id_9A87(var_1, var_2);

  if(isDefined(var_1)) {
    thread _id_9A8A(var_0, var_1);
  }
}

_id_9A8A(var_0, var_1) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_1 endon("disconnect");

  for(;;) {
    level waittill("player_spawned", var_2);

    if(var_2 != var_1) {
      continue;
    }
    thread _id_9A7B(var_0, var_2);
  }
}

_id_9A7B(var_0, var_1, var_2) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");

  if(istrue(var_2)) {
    var_1 waittill("spawned_player");
  }

  if(isDefined(var_1._id_1FAF) && var_1._id_1FAF > 0) {
    var_1 waittill("removed_spawn_perks");
  }

  if(level.teambased && var_1.team == var_0.team) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
      return;
    }
  }

  _id_9A6C(var_0, var_1);
}

_id_9A6C(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_5469 = var_1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
    var_2._id_5515 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_1, var_0, "outline_nodepth_orange", "level_script");
  }

  self._id_5425[self._id_5425.size] = var_2;
  thread _id_9A88(var_0, var_1, var_2._id_5515);
  return var_2;
}

_id_9A87(var_0, var_1) {
  if(!isDefined(self._id_5425)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_1, var_0);
  }

  var_2 = [];

  foreach(var_4 in self._id_5425) {
    if(var_4._id_5469 == var_0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  self._id_5425 = var_2;
}

_id_9A74(var_0) {
  if(!isDefined(self._id_5425)) {
    return;
  }
  foreach(var_2 in self._id_5425) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_2._id_5515, var_2._id_5469);
    }
  }

  self._id_5425 = undefined;
}

_id_9A7E(var_0) {
  if(isDefined(var_0)) {
    var_0._id_84EF = undefined;
    var_0._id_B80F = undefined;
    var_0 _id_9A85(1);
  }

  if(isDefined(self)) {
    if(!self usinggamepad()) {
      self _meth_80E2();
    }

    if(isDefined(var_0)) {
      if(isDefined(self._id_4205) && self._id_4205 != var_0) {
        return;
      }
      self _meth_8292(var_0);
      var_0 _id_9A89(self);

      if(!istrue(var_0._id_8A32)) {
        var_0 thread _id_9A98(var_0.owner);
      }
    }

    self._id_4205 = undefined;
    scripts\common\utility::_id_1587(1);
    scripts\common\utility::_id_1559(1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      scripts\common\utility::_id_155D(1);
    }

    if(level.gametype != "br" || level.gametype == "br" && !istrue(self.inlaststand)) {
      self switchtoweaponimmediate(self._id_8FC2);
    }

    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.useweapon);
    thread _id_9A73();

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self setorigin(var_0._id_90BD, 1);
      self setplayerangles(var_0._id_90BC);
    }

    self notify("end_turret_use");
  }
}

_id_9A73() {
  self endon("death_or_disconnect");
  scripts\common\utility::_id_1530(0);
  scripts\common\utility::_id_1570(0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  scripts\common\utility::_id_1530(1);
  scripts\common\utility::_id_1570(1);
}

_id_9A78(var_0, var_1) {
  if(isDefined(self)) {
    self endon("kill_turret");
    self endon("carried_turret");
  }

  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_2);
    var_1 disableplayeruse(var_2);
  }
}

_id_9A80(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(var_0 _meth_86C9()) {
      var_0 _id_9A7E(self);
      break;
    }

    waitframe();
  }
}

_id_9A82(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(distancesquared(self.origin, var_0.origin) >= 2500) {
      var_0 _id_9A7E(self);
      break;
    }

    waitframe();
  }
}

_id_9A83(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      var_0 _id_9A7E(self);
      break;
    }

    waitframe();
  }
}

_id_9A7F(var_0) {
  var_0 endon("end_turret_use");
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");
  var_0 _id_9A7E(self);
}

_id_9A9A(var_0) {
  self endon("kill_turret");
  var_0 endon("end_turret_use");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self._id_90BD = var_0.origin;
    self._id_90BC = var_0 getplayerangles();
    waitframe();
  }
}

_id_9A98(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  var_0 endon("start_turret_use");
  level endon("game_ended");

  while(isDefined(self) && isDefined(self.useownerobj)) {
    self.useownerobj waittill("trigger_progress", var_1);

    for(var_2 = 0; var_0 useButtonPressed() && var_2 < 0.25; var_2 = var_2 + level._id_5F3A) {
      waitframe();
    }

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_2 < 0.25) {
      continue;
    }
    if(istrue(self._id_E911)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TURRET_DYING");
      }

      continue;
    }

    if(istrue(var_1._id_88DF)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "allowPickupOfTurret")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    _id_9A85(0);
    self setmode(level._id_D0FA[self._id_F89C]._id_D0F7);
    var_0._id_B161[self._id_F89C] = ::scripts\engine\utility::array_remove(var_0._id_B161[self._id_F89C], self);
    thread _id_9A8B(var_0);
  }
}

_id_9A95(var_0) {
  self endon("kill_turret");
  var_0 endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  thread _id_9A98(var_0);
}

_id_9A77(var_0) {
  var_0 endon("kill_turret");
  var_0 endon("carried_turret");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_0.useownerobj disableplayeruse(var_1);
  }
}

_id_9A92(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("manual_turret", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("manual_turret", "monitorDamage")]](self.maxhealth, "hitequip", ::_id_9A84, ::_id_9A86, 1);
  }
}

_id_9A84(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = level._id_D0FA[self._id_F89C];
  var_7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_6.streakname, var_1, var_2, var_3, var_4, var_6._id_CC16, var_6._id_1068F, var_6._id_484B);
  }

  if(var_7) {
    var_1 notify("destroyed_equipment");
  }

  var_8 = 0;

  if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_GRENADE_SPLASH") {
    var_8 = 1;
  }

  self notify("kill_turret", var_8, 1);
}

_id_9A86(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 2, 7);
  }

  return var_6;
}

_id_9A76(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    var_1 waittill("spawned_player");

    if(level.teambased) {
      if(var_1.team != var_0.team) {
        continue;
      }
    }

    self._id_4B3C disableplayeruse(var_1);
  }
}

_id_9A93(var_0) {
  self endon("carried_turret");
  self waittill("kill_turret", var_1, var_2);
  self._id_8A32 = 1;

  if(isDefined(var_0)) {
    var_0._id_B161[self._id_F89C] = ::scripts\engine\utility::array_remove(var_0._id_B161[self._id_F89C], self);
    var_0 _id_9A8C(self);
    _id_9A74(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", var_0);
    }

    self.streakinfo._id_57A7 = istrue(var_2);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  if(isDefined(self._id_B80F)) {
    self._id_B80F _id_9A7E(self);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.useotherobj)) {
    self.useotherobj delete();
  }

  if(!istrue(var_1)) {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else
    self setscriptablepartstate("explode", "violent");

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self._id_3A67)) {
    self._id_3A67 delete();
  }

  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }

    self._id_9F26 = undefined;
  }

  wait 0.2;
  self delete();
}

_id_9A94() {
  self endon("kill_turret");
  self endon("carried_turret");
  level waittill("game_ended");
  self notify("kill_turret", 0, 0);
}

_id_9A72() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self delete();
}

_id_9A9B(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = self._id_F224;

  if(!isDefined(self._id_F20D)) {
    self._id_F20D = 0;
  }

  while(self._id_F20D < var_1) {
    var_2 = (var_1 - self._id_F20D) / var_1;
    var_2 = int(_func_0037(clamp(var_2, 0, 1) * 100));

    if(isDefined(self._id_B80F)) {
      self._id_B80F setclientomnvar("ui_killstreak_countdown", int(var_2));
    }

    self._id_F20D = self._id_F20D + level._id_5F3A;

    if(self._id_F20D >= var_1 - 1.5 && !istrue(self._id_E911)) {
      self._id_E911 = 1;
    }

    waitframe();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_" + self.streakinfo.streakname, 1);
  self notify("kill_turret", 0, 0);
}

_id_9A91(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 endon("end_turret_use");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = level._id_D0FA[self._id_F89C];
  var_2 = weaponfiretime(var_1.weaponinfo);

  if(!isDefined(self._id_78E8)) {
    self._id_78E8 = 1;
  }

  while(var_0 _meth_81F4()) {
    while(var_0 attackButtonPressed()) {
      self.streakinfo._id_DA63++;
      self.ammocount--;
      var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self._id_78E8, "on", 0);
        self._id_78E8++;
      }

      if(self.ammocount == 100) {
        var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F(self.streakinfo.streakname + "_low_ammo");
      } else if(self.ammocount <= 0) {
        var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F(self.streakinfo.streakname + "_no_ammo");
        self notify("kill_turret", 0, 0);
        break;
      }

      wait(var_2);
    }

    waitframe();
  }
}

_id_9A97(var_0) {
  self endon("kill_turret");
  self endon("carried_turret");
  var_0 thread _id_9A79(self, "disconnect");
  var_0 thread _id_9A79(self, "joined_team");
  var_0 thread _id_9A79(self, "joined_spectators");
}

_id_9A79(var_0, var_1) {
  var_0 endon("kill_turret");
  self endon("carried_turret");
  self endon("disowned_turret");
  level endon("game_ended");
  self waittill(var_1);
  var_0 notify("kill_turret", 0, 0);
  self notify("disowned_turret");
}

_id_9A8E(var_0) {
  var_1 = undefined;

  if(var_0 == "placed") {
    var_1 = level._id_D0FA[self._id_F89C]._id_9FD3;
  } else {
    var_1 = level._id_D0FA[self._id_F89C]._id_9FD7;
  }

  self setModel(var_1);
}

_id_9A85(var_0) {
  if(!istrue(var_0)) {
    self.useownerobj makeunusable();
    self.useotherobj makeunusable();
  } else {
    self.useownerobj makeuseable();
    self.useotherobj makeuseable();
  }
}

_id_9A90(var_0) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::_id_1581(var_0);
    scripts\common\utility::_id_1593(var_0);
    scripts\common\utility::_id_1562(var_0);
    scripts\common\utility::_id_1554(var_0);
    scripts\common\utility::_id_153C(var_0);
    scripts\common\utility::_id_1550(var_0);
  }
}