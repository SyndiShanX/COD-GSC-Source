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
  var0 = 0;

  for(;;) {
    if(!self.perkpackagedata.isusing && scripts\mp\supers::issuperready()) {
      if(self.perkpackagedata.istwomode) {
        perkpackage_setstate(1);

        if(true) {
          self.perkpackagedata.super = "super_select";
          scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

          if(isDefined(level.ref_122ff)) {
            [[level.ref_122ff]]();
          }
        }
      }

      if(var0 && !istrue(self.ref_133e7)) {
        thread scripts\mp\supers::showsuperremindersplash();
      }
    }

    self waittill("super_ready", var0);
  }
}

function perkpackage_updateifchanged() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  var0 = perkpackage_getfirstfieldupgrade();
  var1 = perkpackage_getsecondfieldupgrade();
  var2 = isDefined(self.super);
  var3 = !isDefined(self.perkpackagedata.firstupgrade) || self.perkpackagedata.firstupgrade != var0;
  var4 = !isDefined(self.perkpackagedata.secondupgrade) || self.perkpackagedata.secondupgrade != var1;

  if(!var2 || var3 || var4 || self.perkpackagedata.forcereset) {
    var5 = scripts\mp\supers::getsuperid(var0);
    self setclientomnvar("ui_perk_package_super1", var5);
    var6 = scripts\mp\supers::getsuperid(var1);
    self setclientomnvar("ui_perk_package_super2", var6);

    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      if(self.perkpackagedata.forcereset) {
        scripts\mp\supers::setsuperbasepoints(0);
      } else {
        var7 = scripts\mp\supers::getcurrentsuperpoints();
        var8 = var7 - 0;
        var8 = max(var8, 0);
        scripts\mp\supers::setsuperbasepoints(var8);
      }
    }

    if(var0 == "none" && var1 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(0);
      self.perkpackagedata.super = undefined;
      scripts\mp\supers::clearsuper();
    } else if(var1 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(3);
      self.perkpackagedata.super = var0;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else if(var0 == "none") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(4);
      self.perkpackagedata.super = var1;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else {
      self.perkpackagedata.istwomode = 1;
      perkpackage_setstate(0);
      self.perkpackagedata.super = "super_select";
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    }

    if(scripts\mp\supers::issuperready() && !istrue(self.ref_133e7)) {
      thread scripts\mp\supers::showsuperremindersplash();
    }

    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.firstupgrade = var0;
    self.perkpackagedata.secondupgrade = var1;
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

function perkpackage_setstate(var0) {
  self setclientomnvar("ui_perk_package_state", var0);
  self.perkpackagedata.state = var0;
}

function perkpackage_getfirstfieldupgrade() {
  var0 = self.loadoutfieldupgrade1;

  if(isDefined(self.ref_1217f)) {
    var0 = self.ref_1217f;
  }

  return var0;
}

function perkpackage_getsecondfieldupgrade() {
  var0 = self.loadoutfieldupgrade2;

  if(isDefined(self.ref_12180)) {
    var0 = self.ref_12180;
  }

  return var0;
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
  var0 = perkpackagemenu_canactivatesuper();
  var1 = perkpackage_isreadytoupgrade();

  if(!var0) {
    return 0;
  }

  if(!var1) {
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
  var0 = perkpackagemenu_menuthink();
  var0 = istrue(var0);

  if(isDefined(self)) {
    self notify("perkPackage_endMenuThink");

    if(isalive(self)) {
      self notifyonplayercommandremove("perkPackageMenu_option1", "+smoke");
      self notifyonplayercommandremove("perkPackageMenu_option2", "+frag");
      var1 = !var0;
      scripts\mp\supers::superusefinished(var1, 1);
      scripts\common\utility::allow_killstreaks(1);
      scripts\common\utility::allow_offhand_weapons(1);
    }

    if(var0) {
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
  var0 = scripts\engine\utility::ref_143af("perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death");
  var1 = 0;

  if(var0 == "perkPackageMenu_option1") {
    perkpackage_setstate(3);
    var1 = 1;
  } else if(var0 == "perkPackageMenu_option2") {
    perkpackage_setstate(4);
    var1 = 1;
  } else {
    perkpackage_setstate(1);
    var1 = 0;
    wait 0.3;
  }

  if(!perkpackagemenu_canactivatesuper()) {
    var1 = 0;
  }

  return var1;
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
  var0 = undefined;

  if(self.perkpackagedata.state == 3) {
    var0 = perkpackage_getfirstfieldupgrade();
  } else if(self.perkpackagedata.state == 4) {
    var0 = perkpackage_getsecondfieldupgrade();
  }

  if(isDefined(var0)) {
    if(isDefined(var0)) {
      var1 = scripts\mp\supers::getcurrentsuper();

      if(!isDefined(var1) || var1.staticdata.ref != var0) {
        self.perkpackagedata.super = var0;
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

        if(true) {
          var2 = perkpackage_forceusesuper();

          if(!istrue(var2)) {
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
  var0 = scripts\mp\supers::getcurrentsuperref();
  var1 = level.superglobals.staticsuperdata[var0].weapon;
  var2 = getcompleteweaponname(var1);
  thread perkpackagemenu_disableoffhanduse(0.3);
  var3 = 0;

  if("super_default_mp" != var1) {
    self giveandfireoffhand(var2);
    var3 = perkpackage_waitforsupercanceled(var2);
  }

  if(istrue(var3)) {
    var4 = 0;
  } else {
    var4 = scripts\mp\supers::trysuperusebegin(var3);
  }

  if(!istrue(var4)) {
    perkpackage_setstate(1);
    self.perkpackagedata.super = "super_select";
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
  }

  return var4;
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

function perkpackage_waitforsupercanceled(var0) {
  self endon("offhand_fired");
  var1 = undefined;
  var2 = gettime();

  for(;;) {
    var3 = self getheldoffhand();

    if(isDefined(var3) && var3 == var0) {
      var1 = var3;
      break;
    }

    var4 = gettime();

    if(var4 - var2 > 400) {
      return 1;
    }

    wait 0.05;
  }

  for(;;) {
    var3 = self getheldoffhand();

    if(!isDefined(var3) || var3 != var1) {
      return 1;
    }

    wait 0.05;
  }
}

function perkpackagemenu_disableoffhanduse(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("giveLoadout_start");
  scripts\common\utility::allow_offhand_primary_weapons(0, "field_upgrade_pro");
  scripts\common\utility::allow_offhand_secondary_weapons(0, "field_upgrade_pro");
  wait var0;
  scripts\common\utility::allow_offhand_primary_weapons(1, "field_upgrade_pro");
  scripts\common\utility::allow_offhand_secondary_weapons(1, "field_upgrade_pro");
}

function perkpackage_givedebug(var0) {
  level.allowsupers = 1;
  perkpackage_giveimmediate(var0);
}

function perkpackage_giveimmediate(var0) {
  perkpackage_initpersdata();
  self.perkpackagedata.istwomode = 0;
  self.perkpackagedata.super = var0;
  scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
}

function ref_12300(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "none";
  }

  if(!isDefined(var1)) {
    var1 = "none";
  }

  self.ref_1217f = var0;
  self.ref_12180 = var1;
  perkpackage_updateifchanged();
}

function ref_12301() {
  self.ref_1217f = undefined;
  self.ref_12180 = undefined;
}

function perkpackage_reset() {
  self.perkpackagedata.forcereset = 1;
  perkpackage_updateifchanged();
}