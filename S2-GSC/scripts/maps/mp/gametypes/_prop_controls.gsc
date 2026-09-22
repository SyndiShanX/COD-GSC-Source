/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_prop_controls.gsc
********************************************************/

setupkeybindings() {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommand("lock", "+attack");
  self notifyonplayercommand("lock", "+attack_akimbo_accessible");
  self notifyonplayercommand("changeProp", "+weapnext");
  self notifyonplayercommand("setToSlope", "+usereload");
  self notifyonplayercommand("setToSlope", "+activate");
  self notifyonplayercommand("propAbility", "+smoke");
  self notifyonplayercommand("cloneProp", "+actionslot 2");
  self notifyonplayercommand("zoomin", "+actionslot 3");
  self notifyonplayercommand("zoomout", "+actionslot 4");
  thread cleanupkeybindingsondeath();
}

cleanupkeybindingsondeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cleanupKeyBindings");
  self waittill("death");
  thread cleanupkeybindings();
}

cleanupkeybindings() {
  self notify("cleanupKeyBindings");

  if(isbot(self)) {
    return;
  }
  self notifyonplayercommandremove("lock", "+attack");
  self notifyonplayercommandremove("lock", "+attack_akimbo_accessible");
  self notifyonplayercommandremove("changeProp", "+weapnext");
  self notifyonplayercommandremove("setToSlope", "+usereload");
  self notifyonplayercommandremove("setToSlope", "+activate");
  self notifyonplayercommandremove("propAbility", "+smoke");
  self notifyonplayercommandremove("cloneProp", "+frag");
  self notifyonplayercommandremove("zoomin", "+actionslot 3");
  self notifyonplayercommandremove("zoomout", "+actionslot 4");
}

propcontrolshud() {
  self.currenthudy = 26;
  self.changepropkey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_CHANGE", 0);
  self.spinpropkey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_SPIN", undefined, undefined, &"MP_PH_SPIN_PC");
  self.lockpropkey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_LOCK");
  self.matchslopekey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_SLOPE", undefined, undefined, &"MP_PH_SLOPE_PC");
  self.abilitykey = maps\mp\gametypes\prop::addupperrighthudelem();
  self.clonekey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_CLONE");
  setnewabilityhud();
  self.zoomkey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_ZOOM");
  self.spectatekey = maps\mp\gametypes\prop::addupperrighthudelem(&"MP_PH_SPECKEY");
  thread updatetextongamepadchange();
}

cleanuppropcontrolshudondeath() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread cleanupkeybindings();
  thread cleanuppropcontrolshud();
}

safedestroy(var_0) {
  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

cleanuppropcontrolshud() {
  self notify("cleanupPropControlsHUD");
  safedestroy(self.changepropkey);
  safedestroy(self.spinpropkey);
  safedestroy(self.lockpropkey);
  safedestroy(self.matchslopekey);
  safedestroy(self.abilitykey);
  safedestroy(self.zoomkey);
  safedestroy(self.spectatekey);
  safedestroy(self.clonekey);
}

updatetextongamepadchange() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(level._id_258F) {
    return;
  }
  waittillframeend;
  var_0 = common_scripts\utility::_id_55E0();

  for(;;) {
    var_1 = common_scripts\utility::_id_55E0();

    if(var_1 != var_0) {
      var_0 = var_1;

      if(var_1) {
        if(!common_scripts\utility::_id_562E(self.slopelocked)) {
          self.matchslopekey.label = &"MP_PH_SLOPE";
        } else {
          self.matchslopekey.label = &"MP_PH_SLOPED";
        }
      } else if(!common_scripts\utility::_id_562E(self.slopelocked))
        self.matchslopekey.label = &"MP_PH_SLOPE_PC";
      else {
        self.matchslopekey.label = &"MP_PH_SLOPED_PC";
      }
    }

    waitframe();
  }
}

propinputwatch() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  self._id_5E61 = 0;
  self.slopelocked = 0;
  self setclientomnvar("ui_ph_is_locked", 0);
  self setclientomnvar("ui_ph_matching_slope", 0);
  maps\mp\_utility::gameflagwait("prematch_done");
  childthread propmoveunlock();
  childthread propcamerazoom();
  childthread proprotate();
  self.propspectating = 0;
  self.endingpropspecate = 0;
  self.debugnextpropindex = 1;

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("lock", "changeProp", "setToSlope", "propAbility", "cloneProp");

    if(!isDefined(var_0)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    if(self.endingpropspecate) {
      continue;
    }
    if(var_0 == "lock") {
      proplockunlock();
      continue;
    }

    if(var_0 == "changeProp") {
      propchange();
      continue;
    }

    if(var_0 == "setToSlope") {
      propmatchslope();
      continue;
    }

    if(var_0 == "propAbility") {
      propability();
      continue;
    }

    if(var_0 == "cloneProp") {
      propclonepower();
    }
  }
}

proplockunlock() {
  if(self ismantling()) {
    return;
  }
  if(self._id_5E61) {
    unlockprop();
  } else {
    lockprop();
  }
}

registerpreviousprop(var_0) {
  var_1 = 3;

  if(!isDefined(var_0.usedpropsindex)) {
    var_0.usedpropsindex = 0;
  }

  var_0.usedprops[var_0.usedpropsindex] = var_0._id_777D._id_5135;
  var_0.usedpropsindex++;

  if(var_0.usedpropsindex >= var_1) {
    var_0.usedpropsindex = 0;
  }
}

propchange() {
  if(!prophaschangesleft()) {
    return;
  }
  if(common_scripts\utility::_id_562E(level._id_0122)) {
    var_0 = 300;

    if(isDefined(self.lastpropchangetime) && gettime() - self.lastpropchangetime < var_0) {
      return;
    }
    self.lastpropchangetime = gettime();
  }

  self notify("changed_prop");
  registerpreviousprop(self);
  self._id_777D._id_5135 = maps\mp\gametypes\prop::getnextprop(self);
  propchangeto(self._id_777D._id_5135);
  self.maxhealth = int(maps\mp\gametypes\prop::getprophealth(self._id_777D._id_5135));
  self setnormalhealth(1.0);
  setnewabilitycount(self.currentability);
  setnewabilitycount("CLONE");

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.abilitykey.alpha = 1;
    self.clonekey.alpha = 1;
  }

  propdeductchange();
}

prophaschangesleft() {
  return self.changesleft > 0;
}

propdeductchange() {
  propsetchangesleft(self.changesleft - 1);
}

propsetchangesleft(var_0) {
  self.changesleft = var_0;
  self setclientomnvar("ui_ph_num_changes_left", self.changesleft);

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.changepropkey setvalue(self.changesleft);

    if(self.changesleft <= 0) {
      self.changepropkey.alpha = 0.5;
    }
  }
}

propchangeto(var_0) {
  self._id_777D setModel(var_0.modelname);
  self._id_777D.xyzoffset = var_0.xyzoffset;
  self._id_777D.anglesoffset = var_0.anglesoffset;
  self._id_777D unlink();
  self.propent unlink();
  self.propent.origin = self.propanchor.origin;
  self._id_777D.origin = self.propent.origin;
  self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
  self._id_777D.angles = self.propent.angles;

  if(common_scripts\utility::_id_562E(self.isangleoffset)) {
    self._id_777D.angles = self.angles;
    self.isangleoffset = 0;
  }

  maps\mp\gametypes\prop::applyxyzoffset();
  maps\mp\gametypes\prop::applyanglesoffset();
  self._id_777D linktosynchronizedparent(self.propent, "J_prop_1");

  if(self.slopelocked && common_scripts\utility::_id_562E(self._id_5E61)) {
    self.propent set_pitch_roll_for_ground_normal(self._id_777D);
  }

  self.propent linktosynchronizedparent(self.propanchor);
  self.thirdpersonrange = maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(var_0);
  self.thirdpersonheightoffset = maps\mp\gametypes\prop::getthirdpersonheightoffsetforpropinfo(var_0);
  self _meth_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
}

propmatchslope() {
  if(!common_scripts\utility::_id_562E(self.slopelocked)) {
    self.slopelocked = 1;
    self setclientomnvar("ui_ph_matching_slope", 1);

    if(common_scripts\utility::_id_562E(self._id_5E61)) {
      self.propent unlink();
      self.propent set_pitch_roll_for_ground_normal(self._id_777D);
      self.propent linktosynchronizedparent(self.propanchor);
    }

    if(maps\mp\gametypes\prop::useprophudserver()) {
      if(common_scripts\utility::_id_55E0()) {
        self.matchslopekey.label = &"MP_PH_SLOPED";
      } else {
        self.matchslopekey.label = &"MP_PH_SLOPED_PC";
      }
    }
  } else {
    self.slopelocked = 0;
    self setclientomnvar("ui_ph_matching_slope", 0);

    if(common_scripts\utility::_id_562E(self._id_5E61)) {
      self.propent unlink();
      self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
      self.propent.origin = self.propanchor.origin;
      self.propent linktosynchronizedparent(self.propanchor);
    }

    if(maps\mp\gametypes\prop::useprophudserver()) {
      if(common_scripts\utility::_id_55E0()) {
        self.matchslopekey.label = &"MP_PH_SLOPE";
      } else {
        self.matchslopekey.label = &"MP_PH_SLOPE_PC";
      }
    }
  }
}

propability() {
  if(!maps\mp\_utility::gameflag("props_hide_over")) {
    return;
  }
  if(prophasflashesleft()) {
    thread flashenemies();
    propdeductflash();
  }
}

propclonepower() {
  if(prophasclonesleft()) {
    thread cloneprop();
    thread propdeductclonechange();
  }
}

prophasclonesleft() {
  return self.clonesleft > 0;
}

propdeductclonechange() {
  propsetclonesleft(self.clonesleft - 1);
}

propsetclonesleft(var_0) {
  self.clonesleft = var_0;
  self setclientomnvar("ui_ph_num_clones_left", self.clonesleft);

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.clonekey setvalue(self.clonesleft);

    if(self.clonesleft <= 0) {
      self.clonekey.alpha = 0.5;
    }
  }
}

prophasflashesleft() {
  return self.abilityleft > 0;
}

propdeductflash() {
  propsetflashesleft(self.abilityleft - 1);
}

propsetflashesleft(var_0) {
  self.abilityleft = var_0;
  self setclientomnvar("ui_ph_num_flashes_left", self.abilityleft);

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.abilitykey setvalue(self.abilityleft);

    if(self.abilityleft <= 0) {
      self.abilitykey.alpha = 0.5;
    }
  }
}

set_pitch_roll_for_ground_normal(var_0) {
  var_1 = get_ground_normal(var_0, 0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = vectortoangles(var_1);
  var_5 = _angleclamp180(var_4[0] + 90);
  var_4 = (0, var_4[1], 0);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_3);

  if(var_7 < 0) {
    var_7 = -1;
  } else {
    var_7 = 1;
  }

  var_8 = vectordot(var_6, var_2);
  var_9 = var_8 * var_5;
  var_10 = (1 - _abs(var_8)) * var_5 * var_7;
  self.angles = (var_9, self.angles[1], var_10);
}

get_ground_normal(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = self;
  } else {
    var_2 = var_0;
  }

  var_3 = [self.origin];

  if(getdvarint("scr_ph_useBoundsForGroundNormal", 1)) {
    for(var_4 = -1.0; var_4 <= 1.0; var_4 = var_4 + 2.0) {
      for(var_5 = -1.0; var_5 <= 1.0; var_5 = var_5 + 2.0) {
        var_6 = var_2 getpointinmodelbounds(var_4, var_5, 0.0);
        var_6 = (var_6[0], var_6[1], self.origin[2]);
        var_3[var_3.size] = var_6;
      }
    }
  }

  var_7 = (0, 0, 0);
  var_8 = 0;

  foreach(var_10 in var_3) {
    var_11 = bulletTrace(var_10 + (0, 0, 4), var_10 + (0, 0, -16), 0, var_2, 1, 0, 0, 0, 0, 0, 0);
    var_12 = var_11["fraction"] > 0.0 && var_11["fraction"] < 1;

    if(var_12) {
      var_7 = var_7 + var_11["normal"];
      var_8++;
    }
  }

  if(var_8 > 0) {
    var_7 = var_7 / var_8;
    return var_7;
  } else
    return undefined;
}

propmoveunlock() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    waitframe();
    var_3 = self getnormalizedmovement();

    if(!isDefined(var_3)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    var_4 = var_3[0] != 0 || var_3[1] != 0;

    if(self._id_5E61 && var_2 && !var_4) {
      var_2 = 0;
    } else if(self._id_5E61 && !var_0 && var_4) {
      var_2 = 1;
    } else if(self._id_5E61 && var_4 && !var_2) {
      unlockprop();
    }

    var_0 = self._id_5E61;
    var_1 = var_4;
  }
}

unlockprop() {
  self unlink();

  if(self.slopelocked) {
    self.propent unlink();
    self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
    self.propent.origin = self.propanchor.origin;
    self.propent linktosynchronizedparent(self.propanchor);
  }

  self.propanchor linktosynchronizedparent(self);
  self._id_5E61 = 0;
  self setclientomnvar("ui_ph_is_locked", 0);

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH_LOCK";
  }
}

lockprop() {
  if(!canlock()) {
    return;
  }
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self playerlinkTo(self.propanchor);

  if(self.slopelocked) {
    self.propent unlink();
    self.propent set_pitch_roll_for_ground_normal(self._id_777D);
    self.propent linktosynchronizedparent(self.propanchor);
  }

  self._id_5E61 = 1;
  self notify("locked");
  self setclientomnvar("ui_ph_is_locked", 1);

  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH_LOCKED";
  }
}

canlock() {
  if(!self isonground()) {
    var_0 = _getgroundposition(self.origin, 15, 30000, 0);
    var_1 = getEntArray("trigger_hurt", "classname");

    foreach(var_3 in var_1) {
      if(_ispointinvolume(var_0, var_3)) {
        return 0;
      }
    }
  }

  return 1;
}

propspectate() {
  level endon("noPropsToSpectate");
  self.propspectating = 0;
  self.endingpropspecate = 0;

  if(!isDefined(self.spectatenumber)) {
    self.spectatenumber = 0;
  }

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("spectate");

    if(self.endingpropspecate) {
      continue;
    }
    if(var_0 == "spectate") {
      if(self.propspectating) {
        self notify("endPropSpectate");
        continue;
      }

      maps\mp\gametypes\prop::createpropspeclist();

      if(self.spectatableprops.size <= 1) {
        continue;
      }
      self.propspectating = 1;
      propabilitykeysvisible(0);
      thread propspectateendwatch();
      childthread propspectatekeys();
    }
  }
}

propspectatekeys() {
  self endon("endPropSpectate");

  if(checkifvalidpropspectate()) {
    spectateprop();
  } else {
    findvalidspectateprop(1);
    spectateprop();
  }

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("zoomin", "zoomout");

    if(self.endingpropspecate) {
      continue;
    }
    if(var_0 == "zoomin") {
      findvalidspectateprop(1);
      checkifvalidpropspectate();
      movetonewprop();
    }

    if(var_0 == "zoomout") {
      findvalidspectateprop(0);
      checkifvalidpropspectate();
      movetonewprop();
    }
  }
}

checkifvalidpropspectate() {
  var_0 = self.spectatableprops[self.spectatenumber];

  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == self) {
    return 0;
  }

  if(maps\mp\_utility::isreallyalive(var_0)) {
    return 1;
  }

  return 0;
}

findvalidspectateprop(var_0) {
  var_1 = self.spectatenumber;

  for(;;) {
    if(common_scripts\utility::_id_562E(var_0)) {
      self.spectatenumber++;
    } else {
      self.spectatenumber--;
    }

    if(var_0 && self.spectatableprops.size <= self.spectatenumber) {
      self.spectatenumber = 0;
    } else if(self.spectatenumber < 0) {
      self.spectatenumber = self.spectatableprops.size - 1;
    }

    if(self.spectatenumber == var_1) {
      break;
    }

    if(checkifvalidpropspectate()) {
      break;
    }
  }
}

propspectateendwatch() {
  self endon("disconnect");
  self endon("death");
  createpropspecatehud();
  common_scripts\utility::_id_A70C(self, "endPropSpectate", level, "noPropsToSpectate");

  if(common_scripts\utility::_id_562E(self.endingpropspecate)) {
    return;
  }
  self.endingpropspecate = 1;
  destroypropspecatehud();
  returntoprop();
  waittillframeend;
  propabilitykeysvisible(1);
  self.propspectating = 0;
  self.endingpropspecate = 0;
}

createpropspecatehud() {
  self.spectatecommands = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
  self.spectatecommands.label = &"MP_PH_SPECCOMMANDS";
  self.spectatecommands.x = 20;
  self.spectatecommands.y = -80;
  self.spectatecommands.alignx = "center";
  self.spectatecommands.aligny = "middle";
  self.spectatecommands._id_00C6 = "center_adjustable";
  self.spectatecommands._id_01CA = "bottom_adjustable";
  self.spectatecommands.archived = 1;
  self.spectatecommands.fontscale = 1;
  self.spectatecommands.alpha = 1;
  self.spectatecommands.glowalpha = 0.5;
  self.spectatecommands.hidewheninmenu = 0;
}

destroypropspecatehud() {
  if(isDefined(self.spectatecommands)) {
    self.spectatecommands destroy();
  }
}

spectateprop() {
  var_0 = self.spectatableprops[self.spectatenumber];
  self.spectatingthisplayer = var_0;
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self setOrigin(var_0.origin);
  self.angles = var_0.angles;
  self playerlinkTo(var_0.propanchor);
}

movetonewprop() {
  var_0 = self.spectatableprops[self.spectatenumber];
  self unlink();
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self playerlinkTo(var_0.propanchor);
}

returntoprop() {
  self unlink();
  self setOrigin(self.propanchor.origin);

  if(self._id_5E61) {
    self playerlinkTo(self.propanchor);
  } else {
    self.propanchor linktosynchronizedparent(self);
    self.propanchor.origin = self.origin;
  }
}

nospectatablepropswatch() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");
  safedestroy(self.spectatekey);
}

propcamerazoom() {
  self.thirdpersonrange = maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(self._id_777D._id_5135);

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("zoomin", "zoomout");

    if(common_scripts\utility::_id_562E(self.endingpropspecate)) {
      continue;
    }
    if(!isDefined(var_0)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.propspectating)) {
      continue;
    }
    if(var_0 == "zoomin") {
      if(self.thirdpersonrange <= 60) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange - 10;
      self _meth_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
      continue;
    }

    if(var_0 == "zoomout") {
      if(self.thirdpersonrange >= max(maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(self._id_777D._id_5135), 240)) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange + 10;
      self _meth_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    }
  }
}

proprotate() {
  for(;;) {
    if(self adsButtonPressed(1) && !common_scripts\utility::_id_562E(self.propent.spinning)) {
      self.propent setshadowrendering(0);
      self.propent.spinning = 1;
    } else if(!self adsButtonPressed(1) && common_scripts\utility::_id_562E(self.propent.spinning)) {
      self.propent setshadowrendering(1);
      self.propent.spinning = 0;
    }

    waitframe();
  }
}

setnewabilityhud() {
  switch (self.currentability) {
    case "FLASH":
      self.abilitykey.label = &"MP_PH_FLASH";
      break;
    default:
      break;
  }
}

setnewabilitycount(var_0) {
  switch (var_0) {
    case "FLASH":
      propsetflashesleft(level.phsettings.propnumflashes);
      break;
    case "CLONE":
      propsetclonesleft(level.phsettings.propnumclones);
      break;
    default:
      break;
  }
}

flashtheprops(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  thread _id_050A::_id_36DC();
  self endon("end_explode");
  self waittill("explode", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  flashenemies(var_0, var_1);
}

flashenemies(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  playFX(common_scripts\utility::_id_44F5("propFlash"), var_1 + (0, 0, 4));
  playsoundatpos(var_1, "prop_flashbang");

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_3.flashimmune)) {
      continue;
    }
    if(!isDefined(var_3) || !isalive(var_3) || !isDefined(var_3.team) || var_3.team != game["attackers"]) {
      continue;
    }
    var_4 = var_1 + (0, 0, 4) - var_3 getEye();
    var_5 = length(var_4);
    var_6 = 500.0;
    var_7 = 150.0;

    if(var_5 <= var_6) {
      if(var_5 <= var_7) {
        var_8 = 1;
      } else {
        var_8 = 1 - (var_5 - var_7) / (var_6 - var_7);
      }

      var_9 = vectorNormalize(var_4);
      var_10 = anglesToForward(var_3 getplayerangles());
      var_11 = vectordot(var_10, var_9);
      var_3 notify("flashbang", var_1 + (0, 0, 4), var_8, var_11, var_0, var_0.team, 2.0);
      var_0 thread _id_04C7::_id_A102("standard", var_0);
    }
  }
}

deletepropsifatmax() {
  var_0 = 9;

  if(self.propclones.size + 1 <= var_0) {
    return;
  }
  var_1 = 0;

  foreach(var_3 in self.propclones) {
    if(isDefined(var_3)) {
      var_1++;
    }
  }

  if(var_1 + 1 <= var_0) {
    return;
  }
  var_5 = [];
  var_6 = undefined;

  for(var_7 = 0; var_7 < self.propclones.size; var_7++) {
    var_3 = self.propclones[var_7];

    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_6)) {
      var_6 = var_3;
      continue;
    }

    var_5[var_5.size] = var_3;
  }

  var_6 notify("maxDelete");
  var_6 delete();
  self.propclones = var_5;
}

cloneprop() {
  if(!isDefined(self.propclones)) {
    self.propclones = [];
  } else {
    deletepropsifatmax();
  }

  var_0 = spawn("script_model", self._id_777D.origin);
  var_0.targetname = "propClone";
  var_0 setModel(self._id_777D.model);
  var_0.angles = self._id_777D.angles;
  var_0.health = 50;
  var_0._id_7433 = self;
  var_0 setCanDamage(1);
  var_0 setdamagecallbackon(1);
  var_0.damagecallback = ::damageclonewatch;
  var_0 thread deleteclone(self);
  var_0 thread maps\mp\gametypes\prop::highlighttoteam(game["defenders"], 0, self);
  var_0 common_scripts\utility::_id_5FA9(self.team);
  self.propclones[self.propclones.size] = var_0;
}

damageclonewatch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isPlayer(var_1)) {
    if(common_scripts\utility::_id_562E(self.isdying)) {
      return;
    }
    var_1 thread _id_04C7::_id_A102("raid_buildable", self);
    self._id_00E6 = var_0;
    self finishentitydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

deleteclone(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self endon("maxDelete");
  var_1 = 0.25;
  var_0 common_scripts\utility::_id_A70C(self, "death");

  if(isDefined(self._id_00E6)) {
    level thread maps\mp\gametypes\_rank::_id_1457("clone_destroyed", self._id_00E6);

    if(isDefined(self._id_7433)) {
      level thread maps\mp\gametypes\_rank::_id_1457("clone_was_destroyed", self._id_7433);
    }
  }

  if(!isDefined(self.isdying)) {
    self.isdying = 1;
  }

  var_2 = "prop_death";
  var_3 = "propDeathFX";
  playsoundatpos(self.origin + (0, 0, 4), var_2);
  playFX(common_scripts\utility::_id_44F5(var_3), self.origin + (0, 0, 4));

  if(isDefined(self)) {
    self delete();
  }
}

fadetoblackforxsec(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _newclienthudelem(self);
  var_3.foreground = 0;
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("black", 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3._id_00C6 = "fullscreen";
  var_3._id_01CA = "fullscreen";
  var_3.alpha = 0;
  waitframe();

  if(var_1 > 0) {
    var_3 fadeovertime(var_1);
  }

  var_3.alpha = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_2);

  if(var_2 > 0) {
    var_3 fadeovertime(var_2);
  }

  var_3.alpha = 0;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  waitframe();
  safedestroy(var_3);
}

watchspecialgrenadethrow() {
  self endon("death");
  self endon("disconnect");
  self notifyonplayercommand("specialGrenade", "+smoke");

  for(;;) {
    self waittill("specialGrenade");
    self.thrownspecialcount = self.thrownspecialcount + 1;
  }
}

hidehudintermission() {
  level waittill("game_ended");

  if(maps\mp\gametypes\prop::useprophudserver()) {
    level.elim_hud.alpha = 0;
    level.phwhistletimer.alpha = 0;
    level.whistling.alpha = 0;
  }

  foreach(var_1 in level.players) {
    var_1 propabilitykeysvisible(0);
  }
}

safesetalpha(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0.alpha = var_1;
  }
}

propabilitykeysvisible(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0)) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  if(maps\mp\gametypes\prop::useprophudserver() || common_scripts\utility::_id_562E(var_1)) {
    safesetalpha(self.changepropkey, var_2);
    safesetalpha(self.spinpropkey, var_2);
    safesetalpha(self.lockpropkey, var_2);
    safesetalpha(self.matchslopekey, var_2);
    safesetalpha(self.abilitykey, var_2);
    safesetalpha(self.clonekey, var_2);
    safesetalpha(self.zoomkey, var_2);

    if(!common_scripts\utility::_id_562E(level.nopropsspectate)) {
      safesetalpha(self.spectatekey, var_2);
    }
  }
}