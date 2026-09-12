/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perkpackage.gsc
***********************************************/

function perkpackage_initperkpackages() {
  perkpackage_initpersdata();
  thread perkpackage_updateifchanged();
  thread perkpackage_checkifready();
}

function perkpackage_checkifready() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  var_0 = 0;

  for(;;) {
    if(!self.perkpackagedata.isusing && scripts\mp\supers::issuperready()) {
      if(self.perkpackagedata.istwomode) {
        perkpackage_setstate(1);

        if(true) {
          self.perkpackagedata.super = "super_select";
          scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

          if(isDefined(level.ref_122FF)) {
            [[level.ref_122FF]]();
          }
        }
      }

      if(var_0 && !istrue(self.ref_133E7)) {
        thread scripts\mp\supers::showsuperremindersplash();
      }
    }

    self waittill("super_ready", var_0);
  }
}

function perkpackage_updateifchanged() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  var_0 = perkpackage_getfirstfieldupgrade();
  var_1 = perkpackage_getsecondfieldupgrade();
  var_2 = isDefined(self.super);
  var_3 = !isDefined(self.perkpackagedata.firstupgrade) || self.perkpackagedata.firstupgrade != var_0;
  var_4 = !isDefined(self.perkpackagedata.secondupgrade) || self.perkpackagedata.secondupgrade != var_1;

  if(!var_2 || var_3 || var_4 || self.perkpackagedata.forcereset) {
    var_5 = scripts\mp\supers::getsuperid(var_0);
    self setclientomnvar("ui_perk_package_super1", var_5);
    var_6 = scripts\mp\supers::getsuperid(var_1);
    self setclientomnvar("ui_perk_package_super2", var_6);

    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      if(self.perkpackagedata.forcereset) {
        scripts\mp\supers::setsuperbasepoints(0);
      } else {
        var_7 = scripts\mp\supers::getcurrentsuperpoints();
        var_8 = var_7 - 0;
        var_8 = max(var_8, 0);
        scripts\mp\supers::setsuperbasepoints(var_8);
      }
    }

    if(var_0 == "none" && var_1 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(0);
      self.perkpackagedata.super = undefined;
      scripts\mp\supers::clearsuper();
    } else if(var_1 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(3);
      self.perkpackagedata.super = var_0;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else if(var_0 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(4);
      self.perkpackagedata.super = var_1;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else {
      self.perkpackagedata.istwomode = 1;
      perkpackage_setstate(0);
      self.perkpackagedata.super = "super_select";
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    }

    if(scripts\mp\supers::issuperready() && !istrue(self.ref_133E7)) {
      thread scripts\mp\supers::showsuperremindersplash();
    }

    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.firstupgrade = var_0;
    self.perkpackagedata.secondupgrade = var_1;
    return;
  }
}

function perkpackage_isreadytoupgrade() {
  if(!isDefined(self.perkpackagedata)) {
    return false;
  }

  if(self.perkpackagedata.state != 1) {
    return false;
  }

  return true;
}

function perkpackage_setstate(var_0) {
  self setclientomnvar("ui_perk_package_state", var_0);
  self.perkpackagedata.state = var_0;
}

function perkpackage_getfirstfieldupgrade() {
  var_0 = self.loadoutfieldupgrade1;

  if(isDefined(self.ref_1217F)) {
    var_0 = self.ref_1217F;
  }

  return var_0;
}

function perkpackage_getsecondfieldupgrade() {
  var_0 = self.loadoutfieldupgrade2;

  if(isDefined(self.ref_12180)) {
    var_0 = self.ref_12180;
  }

  return var_0;
}

function perkpackage_initpersdata() {
  self.perkpackagedata = self.pers["perkPackageData"];

  if(!isDefined(self.perkpackagedata)) {
    self.perkpackagedata = spawnStruct();
    self.perkpackagedata.state = 0;
    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.isusing = 0;
    self.perkpackagedata.firstupgrade = undefined;
    self.perkpackagedata.secondupgrade = undefined;
    self.perkpackagedata.super = "super_select";
    self.perkpackagedata.istwomode = 0;
    self.pers["perkPackageData"] = self.perkpackagedata;

    if(!isagent(self)) {
      self setclientomnvar("ui_perk_package_state", self.perkpackagedata.state);
      return;
    }

    return;
  }
}

function perkpackage_getperkicon() {
  return "hud_icon_perk_blast_shield";
}

function perkpackage_openselect() {
  var_0 = perkpackagemenu_canactivatesuper();
  var_1 = perkpackage_isreadytoupgrade();

  if(!var_0) {
    return 0;
  }

  if(!var_1) {
    return 0;
  }

  thread perkpackagemenu_openmenu();
  self notify("perkPackage_endThink");
  return 1;
}

function perkpackagemenu_openmenu() {
  scripts\common\utility::allow_killstreaks(0);
  scripts\common\utility::allow_offhand_weapons(0);
  self notifyonplayercommand("perkPackageMenu_option1", "+smoke");
  self notifyonplayercommand("perkPackageMenu_option2", "+frag");
  thread perkpackagemenu_closeinputthink();
  var_0 = perkpackagemenu_menuthink();
  var_0 = istrue(var_0);

  if(isDefined(self)) {
    self notify("perkPackage_endMenuThink");

    if(isalive(self)) {
      self notifyonplayercommandremove("perkPackageMenu_option1", "+smoke");
      self notifyonplayercommandremove("perkPackageMenu_option2", "+frag");
      var_1 = !var_0;
      scripts\mp\supers::superusefinished(var_1, 1);
      scripts\common\utility::allow_killstreaks(1);
      scripts\common\utility::allow_offhand_weapons(1);
    }

    if(var_0) {
      perkpackage_awardperkpackageupgrade();
      return;
    }

    self.perkpackagedata.super = "super_select";
    return;
  }
}

function perkpackagemenu_menuthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  perkpackage_setstate(2);
  wait 0.3;
  var_0 = scripts\engine\utility::ref_143AF("perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death");
  var_1 = 0;

  if(var_0 == "perkPackageMenu_option1") {
    perkpackage_setstate(3);
    var_1 = 1;
  } else if(var_0 == "perkPackageMenu_option2") {
    perkpackage_setstate(4);
    var_1 = 1;
  } else {
    perkpackage_setstate(1);
    var_1 = 0;
    wait 0.3;
  }

  if(!perkpackagemenu_canactivatesuper()) {
    var_1 = 0;
  }

  return var_1;
}

function perkpackagemenu_closeinputthink() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  self endon("perkPackage_endMenuThink");

  for(;;) {
    if(!perkpackagemenu_canactivatesuper()) {
      self notify("perkPackageMenu_close");
    }

    wait 0.05;
  }
}

function perkpackagemenu_canactivatesuper() {
  if(self useButtonPressed() || self attackButtonPressed() || self adsButtonPressed() || self meleeButtonPressed()) {
    return false;
  }

  if(!scripts\common\utility::is_supers_allowed()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  return true;
}

function perkpackage_awardperkpackageupgrade() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("giveLoadout_start");
  var_0 = undefined;

  if(self.perkpackagedata.state == 3) {
    var_0 = perkpackage_getfirstfieldupgrade();
  } else if(self.perkpackagedata.state == 4) {
    var_0 = perkpackage_getsecondfieldupgrade();
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0)) {
      var_1 = scripts\mp\supers::getcurrentsuper();

      if(!isDefined(var_1) || var_1.staticdata.ref != var_0) {
        self.perkpackagedata.super = var_0;
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

        if(true) {
          var_2 = perkpackage_forceusesuper();

          if(!istrue(var_2)) {
            self notify("perkPackage_failed_super");
            return;
          }

          return;
        }

        thread perkpackagemenu_disableoffhanduse(0.3);
        return;
      }

      return;
    }

    return;
  }
}

function perkpackage_forceusesuper() {
  thread perkpackage_waitforsuperfinish();
  var_0 = scripts\mp\supers::getcurrentsuperref();
  var_1 = level.superglobals.staticsuperdata[var_0].weapon;
  var_2 = getcompleteweaponname(var_1);
  thread perkpackagemenu_disableoffhanduse(0.3);
  var_3 = 0;

  if("super_default_mp" != var_1) {
    self giveandfireoffhand(var_2);
    var_3 = perkpackage_waitforsupercanceled(var_2);
  }

  if(istrue(var_3)) {
    var_4 = 0;
  } else {
    var_4 = scripts\mp\supers::trysuperusebegin(var_3);
  }

  if(!istrue(var_4)) {
    perkpackage_setstate(1);
    self.perkpackagedata.super = "super_select";
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
  }

  return var_4;
}

function perkpackage_waitforsuperfinish() {
  self endon("disconnect");
  self.perkpackagedata.isusing = 1;
  perkpackage_waitforsuperfinishinternal();
  self.perkpackagedata.isusing = 0;
}

function perkpackage_waitforsuperfinishinternal() {
  level endon("game_ended");
  self endon("giveLoadout_start");
  self endon("perkPackage_failed_super");
  self waittill("super_use_finished");
}

function perkpackage_waitforsupercanceled(var_0) {
  self endon("offhand_fired");
  var_1 = undefined;
  var_2 = gettime();

  for(;;) {
    var_3 = self getheldoffhand();

    if(isDefined(var_3) && var_3 == var_0) {
      var_1 = var_3;
      break;
    }

    var_4 = gettime();

    if(var_4 - var_2 > 400) {
      return 1;
    }

    wait 0.05;
  }

  for(;;) {
    var_3 = self getheldoffhand();

    if(!isDefined(var_3) || var_3 != var_1) {
      return 1;
    }

    wait 0.05;
  }
}

function perkpackagemenu_disableoffhanduse(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  scripts\common\utility::allow_offhand_primary_weapons(0, "field_upgrade_pro");
  scripts\common\utility::allow_offhand_secondary_weapons(0, "field_upgrade_pro");
  wait var_0;
  scripts\common\utility::allow_offhand_primary_weapons(1, "field_upgrade_pro");
  scripts\common\utility::allow_offhand_secondary_weapons(1, "field_upgrade_pro");
}

function perkpackage_givedebug(var_0) {
  level.allowsupers = 1;
  perkpackage_giveimmediate(var_0);
}

function perkpackage_giveimmediate(var_0) {
  perkpackage_initpersdata();
  self.perkpackagedata.istwomode = 0;
  self.perkpackagedata.super = var_0;
  scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
}

function ref_12300(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  self.ref_1217F = var_0;
  self.ref_12180 = var_1;
  perkpackage_updateifchanged();
}

function ref_12301() {
  self.ref_1217F = undefined;
  self.ref_12180 = undefined;
}

function perkpackage_reset() {
  self.perkpackagedata.forcereset = 1;
  perkpackage_updateifchanged();
}