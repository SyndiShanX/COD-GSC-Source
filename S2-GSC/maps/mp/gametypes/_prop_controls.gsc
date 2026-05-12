/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_prop_controls.gsc
************************************************/

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

safedestroy(param_00) {
  if(isDefined(param_00)) {
    param_00 destroy();
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
  if(level.var_258F) {
    return;
  }

  waittillframeend;
  var_00 = common_scripts\utility::func_55E0();
  for(;;) {
    var_01 = common_scripts\utility::func_55E0();
    if(var_01 != var_00) {
      var_00 = var_01;
      if(var_01) {
        if(!common_scripts\utility::func_562E(self.slopelocked)) {
          self.matchslopekey.var_00E5 = &"MP_PH_SLOPE";
        } else {
          self.matchslopekey.var_00E5 = &"MP_PH_SLOPED";
        }
      } else if(!common_scripts\utility::func_562E(self.slopelocked)) {
        self.matchslopekey.var_00E5 = &"MP_PH_SLOPE_PC";
      } else {
        self.matchslopekey.var_00E5 = &"MP_PH_SLOPED_PC";
      }
    }

    wait 0.05;
  }
}

propinputwatch() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isbot(self)) {
    return;
  }

  self.var_5E61 = 0;
  self.slopelocked = 0;
  self setclientomnvar("ui_ph_is_locked", 0);
  self setclientomnvar("ui_ph_matching_slope", 0);
  maps\mp\_utility::func_3FA5("prematch_done");
  childthread propmoveunlock();
  childthread propcamerazoom();
  childthread proprotate();
  self.propspectating = 0;
  self.endingpropspecate = 0;
  self.debugnextpropindex = 1;
  for(;;) {
    var_00 = common_scripts\utility::func_A715("lock", "changeProp", "setToSlope", "propAbility", "cloneProp");
    if(!isDefined(var_00)) {
      continue;
    }

    if(self.propspectating) {
      continue;
    }

    if(self.endingpropspecate) {
      continue;
    }

    if(var_00 == "lock") {
      proplockunlock();
      continue;
    }

    if(var_00 == "changeProp") {
      propchange();
      continue;
    }

    if(var_00 == "setToSlope") {
      propmatchslope();
      continue;
    }

    if(var_00 == "propAbility") {
      propability();
      continue;
    }

    if(var_00 == "cloneProp") {
      propclonepower();
    }
  }
}

proplockunlock() {
  if(self method_82E4()) {
    return;
  }

  if(self.var_5E61) {
    unlockprop();
    return;
  }

  lockprop();
}

registerpreviousprop(param_00) {
  var_01 = 3;
  if(!isDefined(param_00.usedpropsindex)) {
    param_00.usedpropsindex = 0;
  }

  param_00.usedprops[param_00.usedpropsindex] = param_00.var_777D.var_5135;
  param_00.usedpropsindex++;
  if(param_00.usedpropsindex >= var_01) {
    param_00.usedpropsindex = 0;
  }
}

propchange() {
  if(!prophaschangesleft()) {
    return;
  }

  if(common_scripts\utility::func_562E(level.var_0122)) {
    var_00 = 300;
    if(isDefined(self.lastpropchangetime) && gettime() - self.lastpropchangetime < var_00) {
      return;
    }

    self.lastpropchangetime = gettime();
  }

  self notify("changed_prop");
  registerpreviousprop(self);
  self.var_777D.var_5135 = maps\mp\gametypes\prop::getnextprop(self);
  propchangeto(self.var_777D.var_5135);
  self.var_00FB = int(maps\mp\gametypes\prop::getprophealth(self.var_777D.var_5135));
  self setnormalhealth(1);
  setnewabilitycount(self.currentability);
  setnewabilitycount("CLONE");
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.abilitykey.var_0018 = 1;
    self.clonekey.var_0018 = 1;
  }

  propdeductchange();
}

prophaschangesleft() {
  return self.changesleft > 0;
}

propdeductchange() {
  propsetchangesleft(self.changesleft - 1);
}

propsetchangesleft(param_00) {
  self.changesleft = param_00;
  self setclientomnvar("ui_ph_num_changes_left", self.changesleft);
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.changepropkey setvalue(self.changesleft);
    if(self.changesleft <= 0) {
      self.changepropkey.var_0018 = 0.5;
    }
  }
}

propchangeto(param_00) {
  self.var_777D setModel(param_00.modelname);
  self.var_777D.xyzoffset = param_00.xyzoffset;
  self.var_777D.anglesoffset = param_00.anglesoffset;
  self.var_777D unlink();
  self.propent unlink();
  self.propent.var_0116 = self.propanchor.var_0116;
  self.var_777D.var_0116 = self.propent.var_0116;
  self.propent.var_001D = (self.var_001D[0], self.propent.var_001D[1], self.var_001D[2]);
  self.var_777D.var_001D = self.propent.var_001D;
  if(common_scripts\utility::func_562E(self.isangleoffset)) {
    self.var_777D.var_001D = self.var_001D;
    self.isangleoffset = 0;
  }

  maps\mp\gametypes\prop::applyxyzoffset();
  maps\mp\gametypes\prop::applyanglesoffset();
  self.var_777D method_8449(self.propent, "J_prop_1");
  if(self.slopelocked && common_scripts\utility::func_562E(self.var_5E61)) {
    self.propent set_pitch_roll_for_ground_normal(self.var_777D);
  }

  self.propent method_8449(self.propanchor);
  self.thirdpersonrange = maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(param_00);
  self.thirdpersonheightoffset = maps\mp\gametypes\prop::getthirdpersonheightoffsetforpropinfo(param_00);
  self method_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
}

propmatchslope() {
  if(!common_scripts\utility::func_562E(self.slopelocked)) {
    self.slopelocked = 1;
    self setclientomnvar("ui_ph_matching_slope", 1);
    if(common_scripts\utility::func_562E(self.var_5E61)) {
      self.propent unlink();
      self.propent set_pitch_roll_for_ground_normal(self.var_777D);
      self.propent method_8449(self.propanchor);
    }

    if(maps\mp\gametypes\prop::useprophudserver()) {
      if(common_scripts\utility::func_55E0()) {
        self.matchslopekey.var_00E5 = &"MP_PH_SLOPED";
        return;
      }

      self.matchslopekey.var_00E5 = &"MP_PH_SLOPED_PC";
      return;
    }

    return;
  }

  self.slopelocked = 0;
  self setclientomnvar("ui_ph_matching_slope", 0);
  if(common_scripts\utility::func_562E(self.var_5E61)) {
    self.propent unlink();
    self.propent.var_001D = (self.var_001D[0], self.propent.var_001D[1], self.var_001D[2]);
    self.propent.var_0116 = self.propanchor.var_0116;
    self.propent method_8449(self.propanchor);
  }

  if(maps\mp\gametypes\prop::useprophudserver()) {
    if(common_scripts\utility::func_55E0()) {
      self.matchslopekey.var_00E5 = &"MP_PH_SLOPE";
      return;
    }

    self.matchslopekey.var_00E5 = &"MP_PH_SLOPE_PC";
    return;
  }
}

propability() {
  if(!maps\mp\_utility::func_3FA0("props_hide_over")) {
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

propsetclonesleft(param_00) {
  self.clonesleft = param_00;
  self setclientomnvar("ui_ph_num_clones_left", self.clonesleft);
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.clonekey setvalue(self.clonesleft);
    if(self.clonesleft <= 0) {
      self.clonekey.var_0018 = 0.5;
    }
  }
}

prophasflashesleft() {
  return self.abilityleft > 0;
}

propdeductflash() {
  propsetflashesleft(self.abilityleft - 1);
}

propsetflashesleft(param_00) {
  self.abilityleft = param_00;
  self setclientomnvar("ui_ph_num_flashes_left", self.abilityleft);
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.abilitykey setvalue(self.abilityleft);
    if(self.abilityleft <= 0) {
      self.abilitykey.var_0018 = 0.5;
    }
  }
}

set_pitch_roll_for_ground_normal(param_00) {
  var_01 = get_ground_normal(param_00, 0);
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = anglesToForward(self.var_001D);
  var_03 = anglestoright(self.var_001D);
  var_04 = vectortoangles(var_01);
  var_05 = angleclamp180(var_04[0] + 90);
  var_04 = (0, var_04[1], 0);
  var_06 = anglesToForward(var_04);
  var_07 = vectordot(var_06, var_03);
  if(var_07 < 0) {
    var_07 = -1;
  } else {
    var_07 = 1;
  }

  var_08 = vectordot(var_06, var_02);
  var_09 = var_08 * var_05;
  var_0A = 1 - abs(var_08) * var_05 * var_07;
  self.var_001D = (var_09, self.var_001D[1], var_0A);
}

get_ground_normal(param_00, param_01) {
  if(!isDefined(param_00)) {
    var_02 = self;
  } else {
    var_02 = param_01;
  }

  var_03 = [self.var_0116];
  if(getdvarint("scr_ph_useBoundsForGroundNormal", 1)) {
    for(var_04 = -1; var_04 <= 1; var_04 = var_04 + 2) {
      for(var_05 = -1; var_05 <= 1; var_05 = var_05 + 2) {
        var_06 = var_02 method_8549(var_04, var_05, 0);
        var_06 = (var_06[0], var_06[1], self.var_0116[2]);
        var_03[var_03.size] = var_06;
      }
    }
  }

  var_07 = (0, 0, 0);
  var_08 = 0;
  foreach(var_0A in var_03) {
    var_0B = bulletTrace(var_0A + (0, 0, 4), var_0A + (0, 0, -16), 0, var_02, 1, 0, 0, 0, 0, 0, 0);
    var_0C = var_0B["fraction"] > 0 && var_0B["fraction"] < 1;
    if(var_0C) {
      var_07 = var_07 + var_0B["normal"];
      var_08++;
    }
  }

  if(var_08 > 0) {
    var_07 = var_07 / var_08;
    return var_07;
  }

  return undefined;
}

propmoveunlock() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  for(;;) {
    wait 0.05;
    var_03 = self getnormalizedmovement();
    if(!isDefined(var_03)) {
      continue;
    }

    if(self.propspectating) {
      continue;
    }

    var_04 = var_03[0] != 0 || var_03[1] != 0;
    if(self.var_5E61 && var_02 && !var_04) {
      var_02 = 0;
    } else if(self.var_5E61 && !var_00 && var_04) {
      var_02 = 1;
    } else if(self.var_5E61 && var_04 && !var_02) {
      unlockprop();
    }

    var_00 = self.var_5E61;
    var_01 = var_04;
  }
}

unlockprop() {
  self unlink();
  if(self.slopelocked) {
    self.propent unlink();
    self.propent.var_001D = (self.var_001D[0], self.propent.var_001D[1], self.var_001D[2]);
    self.propent.var_0116 = self.propanchor.var_0116;
    self.propent method_8449(self.propanchor);
  }

  self.propanchor method_8449(self);
  self.var_5E61 = 0;
  self setclientomnvar("ui_ph_is_locked", 0);
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.lockpropkey.var_00E5 = &"MP_PH_LOCK";
  }
}

lockprop() {
  if(!canlock()) {
    return;
  }

  self.propanchor unlink();
  self.propanchor.var_0116 = self.var_0116;
  self playerlinkto(self.propanchor);
  if(self.slopelocked) {
    self.propent unlink();
    self.propent set_pitch_roll_for_ground_normal(self.var_777D);
    self.propent method_8449(self.propanchor);
  }

  self.var_5E61 = 1;
  self notify("locked");
  self setclientomnvar("ui_ph_is_locked", 1);
  if(maps\mp\gametypes\prop::useprophudserver()) {
    self.lockpropkey.var_00E5 = &"MP_PH_LOCKED";
  }
}

canlock() {
  if(!self isonground()) {
    var_00 = getgroundposition(self.var_0116, 15, 30000, 0);
    var_01 = getEntArray("trigger_hurt", "classname");
    foreach(var_03 in var_01) {
      if(ispointinvolume(var_00, var_03)) {
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
    var_00 = common_scripts\utility::func_A715("spectate");
    if(self.endingpropspecate) {
      continue;
    }

    if(var_00 == "spectate") {
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
    var_00 = common_scripts\utility::func_A715("zoomin", "zoomout");
    if(self.endingpropspecate) {
      continue;
    }

    if(var_00 == "zoomin") {
      findvalidspectateprop(1);
      checkifvalidpropspectate();
      movetonewprop();
    }

    if(var_00 == "zoomout") {
      findvalidspectateprop(0);
      checkifvalidpropspectate();
      movetonewprop();
    }
  }
}

checkifvalidpropspectate() {
  var_00 = self.spectatableprops[self.spectatenumber];
  if(!isDefined(var_00)) {
    return 0;
  }

  if(var_00 == self) {
    return 0;
  }

  if(maps\mp\_utility::func_57A0(var_00)) {
    return 1;
  }

  return 0;
}

findvalidspectateprop(param_00) {
  var_01 = self.spectatenumber;
  for(;;) {
    if(common_scripts\utility::func_562E(param_00)) {
      self.spectatenumber++;
    } else {
      self.spectatenumber--;
    }

    if(param_00 && self.spectatableprops.size <= self.spectatenumber) {
      self.spectatenumber = 0;
    } else if(self.spectatenumber < 0) {
      self.spectatenumber = self.spectatableprops.size - 1;
    }

    if(self.spectatenumber == var_01) {
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
  common_scripts\utility::func_A70C(self, "endPropSpectate", level, "noPropsToSpectate");
  if(common_scripts\utility::func_562E(self.endingpropspecate)) {
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
  self.spectatecommands = maps\mp\gametypes\_hud_util::func_27ED("default", 1);
  self.spectatecommands.var_00E5 = &"MP_PH_SPECCOMMANDS";
  self.spectatecommands.var_01D3 = 20;
  self.spectatecommands.var_01D7 = -80;
  self.spectatecommands.var_0010 = "center";
  self.spectatecommands.var_0011 = "middle";
  self.spectatecommands.var_00C6 = "center_adjustable";
  self.spectatecommands.var_01CA = "bottom_adjustable";
  self.spectatecommands.var_001F = 1;
  self.spectatecommands.var_009B = 1;
  self.spectatecommands.var_0018 = 1;
  self.spectatecommands.var_00AA = 0.5;
  self.spectatecommands.var_00C2 = 0;
}

destroypropspecatehud() {
  if(isDefined(self.spectatecommands)) {
    self.spectatecommands destroy();
  }
}

spectateprop() {
  var_00 = self.spectatableprops[self.spectatenumber];
  self.spectatingthisplayer = var_00;
  self.propanchor unlink();
  self.propanchor.var_0116 = self.var_0116;
  self setorigin(var_00.var_0116);
  self.var_001D = var_00.var_001D;
  self playerlinkto(var_00.propanchor);
}

movetonewprop() {
  var_00 = self.spectatableprops[self.spectatenumber];
  self unlink();
  self.var_0116 = var_00.var_0116;
  self.var_001D = var_00.var_001D;
  self playerlinkto(var_00.propanchor);
}

returntoprop() {
  self unlink();
  self setorigin(self.propanchor.var_0116);
  if(self.var_5E61) {
    self playerlinkto(self.propanchor);
    return;
  }

  self.propanchor method_8449(self);
  self.propanchor.var_0116 = self.var_0116;
}

nospectatablepropswatch() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");
  safedestroy(self.spectatekey);
}

propcamerazoom() {
  self.thirdpersonrange = maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(self.var_777D.var_5135);
  for(;;) {
    var_00 = common_scripts\utility::func_A715("zoomin", "zoomout");
    if(common_scripts\utility::func_562E(self.endingpropspecate)) {
      continue;
    }

    if(!isDefined(var_00)) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.propspectating)) {
      continue;
    }

    if(var_00 == "zoomin") {
      if(self.thirdpersonrange <= 60) {
        continue;
      }

      self.thirdpersonrange = self.thirdpersonrange - 10;
      self method_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
      continue;
    }

    if(var_00 == "zoomout") {
      if(self.thirdpersonrange >= max(maps\mp\gametypes\prop::getthirdpersonrangeforpropinfo(self.var_777D.var_5135), 240)) {
        continue;
      }

      self.thirdpersonrange = self.thirdpersonrange + 10;
      self method_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    }
  }
}

proprotate() {
  for(;;) {
    if(self adsButtonPressed(1) && !common_scripts\utility::func_562E(self.propent.spinning)) {
      self.propent scriptmodelpauseanim(0);
      self.propent.spinning = 1;
    } else if(!self adsButtonPressed(1) && common_scripts\utility::func_562E(self.propent.spinning)) {
      self.propent scriptmodelpauseanim(1);
      self.propent.spinning = 0;
    }

    wait 0.05;
  }
}

setnewabilityhud() {
  switch (self.currentability) {
    case "FLASH":
      self.abilitykey.var_00E5 = &"MP_PH_FLASH";
      break;

    default:
      break;
  }
}

setnewabilitycount(param_00) {
  switch (param_00) {
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

flashtheprops(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  thread maps\mp\gametypes\_shellshock::func_36DC();
  self endon("end_explode");
  self waittill("explode", var_01);
  if(!isDefined(param_00)) {
    return;
  }

  flashenemies(param_00, var_01);
}

flashenemies(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  if(!isDefined(param_01)) {
    param_01 = self.var_0116;
  }

  playFX(common_scripts\utility::func_44F5("propFlash"), param_01 + (0, 0, 4));
  playsoundatpos(param_01, "prop_flashbang");
  foreach(var_0C, var_03 in level.var_744A) {
    if(var_03 == param_00) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_03.flashimmune)) {
      continue;
    }

    if(!isDefined(var_03) || !isalive(var_03) || !isDefined(var_03.var_01A7) || var_03.var_01A7 != game["attackers"]) {
      continue;
    }

    var_04 = param_01 + (0, 0, 4) - var_03 getEye();
    var_05 = length(var_04);
    var_06 = 500;
    var_07 = 150;
    if(var_05 <= var_06) {
      if(var_05 <= var_07) {
        var_08 = 1;
      } else {
        var_08 = 1 - var_06 - var_0C / var_07 - var_0C;
      }

      var_09 = vectornormalize(var_04);
      var_0A = anglesToForward(var_03 getangles());
      var_0B = vectordot(var_0A, var_09);
      var_03 notify("flashbang", param_01 + (0, 0, 4), var_08, var_0B, param_00, param_00.var_01A7, 2);
      param_00 thread maps\mp\gametypes\_damagefeedback::func_A102("standard", param_00);
    }
  }
}

deletepropsifatmax() {
  var_00 = 9;
  if(self.propclones.size + 1 <= var_00) {
    return;
  }

  var_01 = 0;
  foreach(var_03 in self.propclones) {
    if(isDefined(var_03)) {
      var_01++;
    }
  }

  if(var_01 + 1 <= var_00) {
    return;
  }

  var_05 = [];
  var_06 = undefined;
  for(var_07 = 0; var_07 < self.propclones.size; var_07++) {
    var_03 = self.propclones[var_07];
    if(!isDefined(var_03)) {
      continue;
    }

    if(!isDefined(var_06)) {
      var_06 = var_03;
      continue;
    }

    var_05[var_05.size] = var_03;
  }

  var_06 notify("maxDelete");
  var_06 delete();
  self.propclones = var_05;
}

cloneprop() {
  if(!isDefined(self.propclones)) {
    self.propclones = [];
  } else {
    deletepropsifatmax();
  }

  var_00 = spawn("script_model", self.var_777D.var_0116);
  var_00.var_01A5 = "propClone";
  var_00 setModel(self.var_777D.var_0106);
  var_00.var_001D = self.var_777D.var_001D;
  var_00.var_00BC = 50;
  var_00.var_7433 = self;
  var_00 setCanDamage(1);
  var_00 setdamagecallbackon(1);
  var_00.var_29B5 = ::damageclonewatch;
  var_00 thread deleteclone(self);
  var_00 thread maps\mp\gametypes\prop::highlighttoteam(game["defenders"], 0, self);
  var_00 common_scripts\utility::func_5FA9(self.var_01A7);
  self.propclones[self.propclones.size] = var_00;
}

damageclonewatch(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01)) {
    return;
  }

  if(isPlayer(param_01)) {
    if(common_scripts\utility::func_562E(self.isdying)) {
      return;
    }

    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("raid_buildable", self);
    self.var_00E6 = param_00;
    self finishentitydamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }
}

deleteclone(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  self endon("maxDelete");
  var_01 = 0.25;
  param_00 common_scripts\utility::func_A70C(self, "death");
  if(isDefined(self.var_00E6)) {
    level thread maps\mp\gametypes\_rank::func_1457("clone_destroyed", self.var_00E6);
    if(isDefined(self.var_7433)) {
      level thread maps\mp\gametypes\_rank::func_1457("clone_was_destroyed", self.var_7433);
    }
  }

  if(!isDefined(self.isdying)) {
    self.isdying = 1;
  }

  var_02 = "prop_death";
  var_03 = "propDeathFX";
  playsoundatpos(self.var_0116 + (0, 0, 4), var_02);
  playFX(common_scripts\utility::func_44F5(var_03), self.var_0116 + (0, 0, 4));
  if(isDefined(self)) {
    self delete();
  }
}

fadetoblackforxsec(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(param_00)) {
    param_00 = 5;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = newclienthudelem(self);
  var_03.var_00A0 = 0;
  var_03.var_01D3 = 0;
  var_03.var_01D7 = 0;
  var_03 setshader("black", 640, 480);
  var_03.var_0010 = "left";
  var_03.var_0011 = "top";
  var_03.var_00C6 = "fullscreen";
  var_03.var_01CA = "fullscreen";
  var_03.var_0018 = 0;
  wait 0.05;
  if(param_01 > 0) {
    var_03 fadeovertime(param_01);
  }

  var_03.var_0018 = 1;
  maps\mp\gametypes\_hostmigration::func_A6F5(param_00 - param_02);
  if(param_02 > 0) {
    var_03 fadeovertime(param_02);
  }

  var_03.var_0018 = 0;
  maps\mp\gametypes\_hostmigration::func_A6F5(param_02);
  wait 0.05;
  safedestroy(var_03);
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
    level.elim_hud.var_0018 = 0;
    level.phwhistletimer.var_0018 = 0;
    level.whistling.var_0018 = 0;
  }

  foreach(var_01 in level.var_744A) {
    var_01 propabilitykeysvisible(0);
  }
}

safesetalpha(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00.var_0018 = param_01;
  }
}

propabilitykeysvisible(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_00)) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  if(maps\mp\gametypes\prop::useprophudserver() || common_scripts\utility::func_562E(param_01)) {
    safesetalpha(self.changepropkey, var_02);
    safesetalpha(self.spinpropkey, var_02);
    safesetalpha(self.lockpropkey, var_02);
    safesetalpha(self.matchslopekey, var_02);
    safesetalpha(self.abilitykey, var_02);
    safesetalpha(self.clonekey, var_02);
    safesetalpha(self.zoomkey, var_02);
    if(!common_scripts\utility::func_562E(level.nopropsspectate)) {
      safesetalpha(self.spectatekey, var_02);
    }
  }
}