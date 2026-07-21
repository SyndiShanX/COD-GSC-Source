/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\perkpackage.gsc
***********************************************/

perkpackage_initperkpackages() {
  perkpackage_initpersdata();
  thread perkpackage_updateifchanged();
  thread perkpackage_checkifready();
}

perkpackage_checkifready() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  var_0 = 0;

  for(;;) {
    if(!self.perkpackagedata.isusing && scripts\mp\supers::issuperready()) {
      if(self.perkpackagedata.istwomode) {
        perkpackage_setstate(1);

        if(1) {
          self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
          scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

          if(isDefined(level._id_122FF))
            [[level._id_122FF]]();
        }
      }

      if(var_0 && !istrue(self._id_133E7))
        thread scripts\mp\supers::showsuperremindersplash();
    }

    self waittill("_encstr_A3F20C0B33A3EDC8812283835C70", var_0);
  }
}

perkpackage_updateifchanged() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  var_0 = perkpackage_getfirstfieldupgrade();
  var_1 = perkpackage_getsecondfieldupgrade();
  var_2 = isDefined(self.super);
  var_3 = !isDefined(self.perkpackagedata.firstupgrade) || self.perkpackagedata.firstupgrade != var_0;
  var_4 = !isDefined(self.perkpackagedata.secondupgrade) || self.perkpackagedata.secondupgrade != var_1;

  if(!var_2 || var_3 || var_4 || self.perkpackagedata.forcereset) {
    var_5 = scripts\mp\supers::getsuperid(var_0);
    self setclientomnvar("_encstr_BE551757D2BEC1B227AD7D0E2CB1B6169DCABECDBAE0B23913", var_5);
    var_6 = scripts\mp\supers::getsuperid(var_1);
    self setclientomnvar("_encstr_925517FFFB8823458878D91AD1E883CA7C0BCF6F7B473A2AD2", var_6);

    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      if(self.perkpackagedata.forcereset)
        scripts\mp\supers::setsuperbasepoints(0);
      else {
        var_7 = scripts\mp\supers::getcurrentsuperpoints();
        var_8 = var_7 - 0;
        var_8 = max(var_8, 0);
        scripts\mp\supers::setsuperbasepoints(var_8);
      }
    }

    if(var_0 == "_encstr_8BBA05185F8B99" && var_1 == "_encstr_8BBA05185F8B99") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(0);
      self.perkpackagedata.super = undefined;
      scripts\mp\supers::clearsuper();
    } else if(var_1 == "_encstr_8BBA05185F8B99") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(3);
      self.perkpackagedata.super = var_0;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else if(var_0 == "_encstr_8BBA05185F8B99") {
      self.perkpackagedata.istwomode = 0;
      perkpackage_setstate(4);
      self.perkpackagedata.super = var_1;
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    } else {
      self.perkpackagedata.istwomode = 1;
      perkpackage_setstate(0);
      self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
      scripts\mp\supers::givesuper(self.perkpackagedata.super, 1, 0);
    }

    if(scripts\mp\supers::issuperready() && !istrue(self._id_133E7))
      thread scripts\mp\supers::showsuperremindersplash();

    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.firstupgrade = var_0;
    self.perkpackagedata.secondupgrade = var_1;
  }
}

perkpackage_isreadytoupgrade() {
  if(!isDefined(self.perkpackagedata))
    return 0;

  if(self.perkpackagedata.state != 1)
    return 0;

  return 1;
}

perkpackage_setstate(var_0) {
  self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", var_0);
  self.perkpackagedata.state = var_0;
}

perkpackage_getfirstfieldupgrade() {
  var_0 = self.loadoutfieldupgrade1;

  if(isDefined(self._id_1217F))
    var_0 = self._id_1217F;

  return var_0;
}

perkpackage_getsecondfieldupgrade() {
  var_0 = self.loadoutfieldupgrade2;

  if(isDefined(self._id_12180))
    var_0 = self._id_12180;

  return var_0;
}

perkpackage_initpersdata() {
  self.perkpackagedata = self.pers["_encstr_A5D3100ECAE4D6411636B6C29D564458A30B"];

  if(!isDefined(self.perkpackagedata)) {
    self.perkpackagedata = spawnStruct();
    self.perkpackagedata.state = 0;
    self.perkpackagedata.forcereset = 0;
    self.perkpackagedata.isusing = 0;
    self.perkpackagedata.firstupgrade = undefined;
    self.perkpackagedata.secondupgrade = undefined;
    self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
    self.perkpackagedata.istwomode = 0;
    self.pers["_encstr_A5D3100ECAE4D6411636B6C29D564458A30B"] = self.perkpackagedata;

    if(!isagent(self))
      self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", self.perkpackagedata.state);
  }
}

perkpackage_getperkicon() {
  return "_encstr_ADEF1B29357C98889F68FEF15A77A010D9FE51A196A496E2849B1B5292";
}

perkpackage_openselect() {
  var_0 = perkpackagemenu_canactivatesuper();
  var_1 = perkpackage_isreadytoupgrade();

  if(!var_0)
    return 0;
  else if(!var_1)
    return 0;
  else {
    thread perkpackagemenu_openmenu();
    self notify("_encstr_8AB615B2E82A1371A18E30F65125F91ADE61E99C2ADD64");
    return 1;
  }
}

perkpackagemenu_openmenu() {
  scripts\common\utility::allow_killstreaks(0);
  scripts\common\utility::allow_offhand_weapons(0);
  self notifyonplayercommand("_encstr_99C818E0B24EB5282C6CB685B3596A959BEABEDBE03AD2DEB926", "_encstr_8E5F0795E6AD7BAD2B");
  self notifyonplayercommand("_encstr_9BC818932F08AA0966D9D0CF021D534F909F11375B9BF1D8AB63", "_encstr_9B0D065699E485D9");
  thread perkpackagemenu_closeinputthink();
  var_0 = perkpackagemenu_menuthink();
  var_0 = istrue(var_0);

  if(isDefined(self)) {
    self notify("_encstr_9313199BC25B3A09DEE3AFB30F07A9F5836AB4A11A3FFD80F4F657");

    if(isalive(self)) {
      self notifyonplayercommandremove("_encstr_99C818E0B24EB5282C6CB685B3596A959BEABEDBE03AD2DEB926", "_encstr_8E5F0795E6AD7BAD2B");
      self notifyonplayercommandremove("_encstr_9BC818932F08AA0966D9D0CF021D534F909F11375B9BF1D8AB63", "_encstr_9B0D065699E485D9");
      var_1 = !var_0;
      scripts\mp\supers::superusefinished(var_1, 1);
      scripts\common\utility::allow_killstreaks(1);
      scripts\common\utility::allow_offhand_weapons(1);
    }

    if(var_0)
      perkpackage_awardperkpackageupgrade();
    else
      self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
  }
}

perkpackagemenu_menuthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  perkpackage_setstate(2);
  wait 0.3;
  var_0 = scripts\engine\utility::_id_143AF("_encstr_99C818E0B24EB5282C6CB685B3596A959BEABEDBE03AD2DEB926", "_encstr_9BC818932F08AA0966D9D0CF021D534F909F11375B9BF1D8AB63", "_encstr_99FE162A99A05B2997E7B797C74D208DA863697610F00B32", "_encstr_AD75063D571AE108");
  var_1 = 0;

  if(var_0 == "_encstr_99C818E0B24EB5282C6CB685B3596A959BEABEDBE03AD2DEB926") {
    perkpackage_setstate(3);
    var_1 = 1;
  } else if(var_0 == "_encstr_9BC818932F08AA0966D9D0CF021D534F909F11375B9BF1D8AB63") {
    perkpackage_setstate(4);
    var_1 = 1;
  } else {
    perkpackage_setstate(1);
    var_1 = 0;
    wait 0.3;
  }

  if(!perkpackagemenu_canactivatesuper())
    var_1 = 0;

  return var_1;
}

perkpackagemenu_closeinputthink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  self endon("_encstr_9313199BC25B3A09DEE3AFB30F07A9F5836AB4A11A3FFD80F4F657");

  for(;;) {
    if(!perkpackagemenu_canactivatesuper())
      self notify("_encstr_99FE162A99A05B2997E7B797C74D208DA863697610F00B32");

    wait 0.05;
  }
}

perkpackagemenu_canactivatesuper() {
  if(self useButtonPressed() || self attackButtonPressed() || self adsButtonPressed() || self meleeButtonPressed())
    return 0;

  if(!scripts\common\utility::is_supers_allowed())
    return 0;

  if(self isonladder())
    return 0;

  return 1;
}

perkpackage_awardperkpackageupgrade() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  var_0 = undefined;

  if(self.perkpackagedata.state == 3)
    var_0 = perkpackage_getfirstfieldupgrade();
  else if(self.perkpackagedata.state == 4)
    var_0 = perkpackage_getsecondfieldupgrade();

  if(isDefined(var_0)) {
    if(isDefined(var_0)) {
      var_1 = scripts\mp\supers::getcurrentsuper();

      if(!isDefined(var_1) || var_1.staticdata.ref != var_0) {
        self.perkpackagedata.super = var_0;
        scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);

        if(1) {
          var_2 = perkpackage_forceusesuper();

          if(!istrue(var_2)) {
            self notify("_encstr_953019E0CA9CAD140B6C6D0BB3CAAF332CD2D85619BEB9D50ECAC9");
            return;
          }
        } else
          thread perkpackagemenu_disableoffhanduse(0.3);
      }
    }
  }
}

perkpackage_forceusesuper() {
  thread perkpackage_waitforsuperfinish();
  var_0 = scripts\mp\supers::getcurrentsuperref();
  var_1 = level.superglobals.staticsuperdata[var_0].weapon;
  var_2 = getcompleteweaponname(var_1);
  thread perkpackagemenu_disableoffhanduse(0.3);
  var_3 = 0;

  if("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1" != var_1) {
    self giveandfireoffhand(var_2);
    var_3 = perkpackage_waitforsupercanceled(var_2);
  }

  if(istrue(var_3))
    var_4 = 0;
  else
    var_4 = scripts\mp\supers::trysuperusebegin(var_2);

  if(!istrue(var_4)) {
    perkpackage_setstate(1);
    self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
    scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
  }

  return var_4;
}

perkpackage_waitforsuperfinish() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.perkpackagedata.isusing = 1;
  perkpackage_waitforsuperfinishinternal();
  self.perkpackagedata.isusing = 0;
}

perkpackage_waitforsuperfinishinternal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  self endon("_encstr_953019E0CA9CAD140B6C6D0BB3CAAF332CD2D85619BEB9D50ECAC9");
  self waittill("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
}

perkpackage_waitforsupercanceled(var_0) {
  self endon("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0");
  var_1 = undefined;
  var_2 = gettime();

  for(;;) {
    var_3 = self getheldoffhand();

    if(isDefined(var_3) && var_3 == var_0) {
      var_1 = var_3;
      break;
    }

    var_4 = gettime();

    if(var_4 - var_2 > 400.0)
      return 1;

    wait 0.05;
  }

  for(;;) {
    var_3 = self getheldoffhand();

    if(!isDefined(var_3) || var_3 != var_1)
      return 1;

    wait 0.05;
  }
}

perkpackagemenu_disableoffhanduse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  scripts\common\utility::allow_offhand_primary_weapons(0, "_encstr_A12812C86AA7D98977652FAC5AB7B1838163E0F8");
  scripts\common\utility::allow_offhand_secondary_weapons(0, "_encstr_A12812C86AA7D98977652FAC5AB7B1838163E0F8");
  wait(var_0);
  scripts\common\utility::allow_offhand_primary_weapons(1, "_encstr_A12812C86AA7D98977652FAC5AB7B1838163E0F8");
  scripts\common\utility::allow_offhand_secondary_weapons(1, "_encstr_A12812C86AA7D98977652FAC5AB7B1838163E0F8");
}

perkpackage_givedebug(var_0) {
  level.allowsupers = 1;
  perkpackage_giveimmediate(var_0);
}

perkpackage_giveimmediate(var_0) {
  perkpackage_initpersdata();
  self.perkpackagedata.istwomode = 0;
  self.perkpackagedata.super = var_0;
  scripts\mp\supers::givesuper(self.perkpackagedata.super, 0, 1);
}

_id_12300(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_1))
    var_1 = "_encstr_8BBA05185F8B99";

  self._id_1217F = var_0;
  self._id_12180 = var_1;
  perkpackage_updateifchanged();
}

_id_12301() {
  self._id_1217F = undefined;
  self._id_12180 = undefined;
}

perkpackage_reset() {
  self.perkpackagedata.forcereset = 1;
  perkpackage_updateifchanged();
}