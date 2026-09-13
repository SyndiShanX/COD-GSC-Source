/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\_prop_controls.gsc
***************************************************/

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
  self notifyonplayercommandremove("cloneProp", "+actionslot 2");
  self notifyonplayercommandremove("zoomin", "+actionslot 3");
  self notifyonplayercommandremove("zoomout", "+actionslot 4");
}

addupperrighthudelem(label, value, text, labelpc) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 0.9);
  _id_94480E1669B7FF0D.x = 15;
  _id_94480E1669B7FF0D.y = self.currenthudy;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "left_adjustable";
  _id_94480E1669B7FF0D.vertalign = "top_adjustable";
  _id_94480E1669B7FF0D.fontscale = 1;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 0;
  _id_94480E1669B7FF0D.startfontscale = _id_94480E1669B7FF0D.fontscale;

  if(isDefined(labelpc) && !scripts\engine\utility::is_player_gamepad_enabled())
    _id_94480E1669B7FF0D.label = labelpc;
  else if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;
  else if(isDefined(text)) {}

  if(isDefined(value))
    _id_94480E1669B7FF0D setvalue(value);

  self.currenthudy = self.currenthudy + 18;
  return _id_94480E1669B7FF0D;
}

propcontrolshud() {
  self.currenthudy = 152;
  self.changepropkey = addupperrighthudelem(&"MP_PH/CHANGE", 0);
  self.spinpropkey = addupperrighthudelem(&"MP_PH/SPIN", undefined, undefined, &"MP_PH/SPIN_PC");
  self.lockpropkey = addupperrighthudelem(&"MP_PH/LOCK");
  self.matchslopekey = addupperrighthudelem(&"MP_PH/SLOPE", undefined, undefined, &"MP_PH/SLOPE_PC");
  self.abilitykey = addupperrighthudelem();
  self.clonekey = addupperrighthudelem(&"MP_PH/CLONE");
  setnewabilityhud();
  self.zoomkey = addupperrighthudelem(&"MP_PH/ZOOM");
  thread updatetextongamepadchange();
}

cleanuppropcontrolshudondeath() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread cleanupkeybindings();
  thread cleanuppropcontrolshud();
}

safedestroy(_id_94480E1669B7FF0D) {
  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D destroy();
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
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  _id_FD0EFA5C23BE8228 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    _id_890736E866204B96 = scripts\engine\utility::is_player_gamepad_enabled();

    if(_id_890736E866204B96 != _id_FD0EFA5C23BE8228) {
      _id_FD0EFA5C23BE8228 = _id_890736E866204B96;

      if(_id_890736E866204B96) {
        if(!istrue(self.slopelocked))
          self.matchslopekey.label = &"MP_PH/SLOPE";
        else
          self.matchslopekey.label = &"MP_PH/SLOPED";
      } else if(!istrue(self.slopelocked))
        self.matchslopekey.label = &"MP_PH/SLOPE_PC";
      else
        self.matchslopekey.label = &"MP_PH/SLOPED_PC";
    }

    waitframe();
  }
}

propinputwatch() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.lock = 0;
  self.slopelocked = 0;

  if(isbot(self)) {
    return;
  }
  if(!_id_733CE9BDDE8C500B::useprophudserver()) {
    self setclientomnvar("ui_ph_is_locked", 0);
    self setclientomnvar("ui_ph_matching_slope", 0);
  }

  thread propmoveunlock();
  thread propcamerazoom();
  thread proprotate();
  self.propspectating = 0;
  self.endingpropspecate = 0;
  self.debugnextpropindex = 1;

  for(;;) {
    msg = scripts\engine\utility::waittill_any_return_5("lock", "changeProp", "setToSlope", "propAbility", "cloneProp");

    if(!isDefined(msg)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    if(self.endingpropspecate) {
      continue;
    }
    waittillframeend;

    if(msg == "lock") {
      proplockunlock();
      continue;
    }

    if(msg == "changeProp") {
      propchange();
      continue;
    }

    if(msg == "setToSlope") {
      propmatchslope();
      continue;
    }

    if(msg == "propAbility") {
      propability();
      continue;
    }

    if(msg == "cloneProp")
      propclonepower();
  }
}

proplockunlock() {
  if(self ismantling()) {
    return;
  }
  if(self.lock)
    unlockprop();
  else
    lockprop();
}

registerpreviousprop(_id_810A4815A999110B) {
  _id_86C8BDEEFC98CCF5 = 3;

  if(!isDefined(_id_810A4815A999110B.usedpropsindex))
    _id_810A4815A999110B.usedpropsindex = 0;

  _id_810A4815A999110B.usedprops[_id_810A4815A999110B.usedpropsindex] = _id_810A4815A999110B.prop.info;
  _id_810A4815A999110B.usedpropsindex++;

  if(_id_810A4815A999110B.usedpropsindex >= _id_86C8BDEEFC98CCF5)
    _id_810A4815A999110B.usedpropsindex = 0;
}

propchange(_id_F8048727716242B0) {
  if(!prophaschangesleft() && !istrue(_id_F8048727716242B0)) {
    return;
  }
  if(istrue(level.pc) && !istrue(_id_F8048727716242B0)) {
    _id_1704DB566A448C2E = 300;

    if(isDefined(self.lastpropchangetime) && gettime() - self.lastpropchangetime < _id_1704DB566A448C2E) {
      return;
    }
    self.lastpropchangetime = gettime();
  }

  self notify("changed_prop");
  registerpreviousprop(self);
  self.prop.info = _id_733CE9BDDE8C500B::getnextprop(self);
  propchangeto(self.prop.info);
  self.maxhealth = int(_id_733CE9BDDE8C500B::getprophealth(self.prop.info));
  self setnormalhealth(1.0);
  setnewabilitycount(self.currentability);
  setnewabilitycount("CLONE");

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.abilitykey.alpha = 1;
    self.clonekey.alpha = 1;
  }

  if(!istrue(_id_F8048727716242B0))
    propdeductchange();
}

prophaschangesleft() {
  return self.changesleft > 0;
}

propdeductchange() {
  propsetchangesleft(self.changesleft - 1);
}

propsetchangesleft(_id_8F617FFD000EB682) {
  self.changesleft = _id_8F617FFD000EB682;

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.changepropkey setvalue(self.changesleft);

    if(self.changesleft <= 0)
      self.changepropkey.alpha = 0.5;
    else if(self.changesleft > 0 && self.changepropkey.alpha < 1)
      self.changepropkey.alpha = 1.0;
  } else
    self setclientomnvar("ui_ph_num_changes_left", self.changesleft);
}

propchangeto(info) {
  self.prop.info = info;
  self.propinfo = info;
  self.prop setModel(info.modelname);
  self.prop.xyzoffset = info.xyzoffset;
  self.prop.anglesoffset = info.anglesoffset;
  self.prop unlink();
  self.propent unlink();
  self.propent.origin = self.propanchor.origin;
  self.prop.origin = self.propent.origin;
  self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
  self.prop.angles = self.propent.angles;

  if(istrue(self.isangleoffset)) {
    self.prop.angles = self.angles;
    self.isangleoffset = 0;
  }

  _id_733CE9BDDE8C500B::applyxyzoffset();
  _id_733CE9BDDE8C500B::applyanglesoffset();
  self.prop linkTo(self.propent, "J_prop_1");

  if(self.slopelocked && istrue(self.lock))
    self.propent set_pitch_roll_for_ground_normal(self.prop);

  self.propent linkTo(self.propanchor);
  self.thirdpersonrange = info.proprange;
  self.thirdpersonheightoffset = info.propheight;
  self setcamerathirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
}

propmatchslope() {
  if(!istrue(self.slopelocked)) {
    self.slopelocked = 1;

    if(istrue(self.lock)) {
      self.propent unlink();
      self.propent set_pitch_roll_for_ground_normal(self.prop);
      self.propent linkTo(self.propanchor);
    }

    if(_id_733CE9BDDE8C500B::useprophudserver()) {
      if(scripts\engine\utility::is_player_gamepad_enabled())
        self.matchslopekey.label = &"MP_PH/SLOPED";
      else
        self.matchslopekey.label = &"MP_PH/SLOPED_PC";
    } else
      self setclientomnvar("ui_ph_matching_slope", 1);
  } else {
    self.slopelocked = 0;

    if(istrue(self.lock)) {
      self.propent unlink();
      self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
      self.propent.origin = self.propanchor.origin;
      self.propent linkTo(self.propanchor);
    }

    if(_id_733CE9BDDE8C500B::useprophudserver()) {
      if(scripts\engine\utility::is_player_gamepad_enabled())
        self.matchslopekey.label = &"MP_PH/SLOPE";
      else
        self.matchslopekey.label = &"MP_PH/SLOPE_PC";
    } else
      self setclientomnvar("ui_ph_matching_slope", 0);
  }
}

propability() {
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

propsetclonesleft(_id_8F617FFD000EB682) {
  self.clonesleft = _id_8F617FFD000EB682;

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.clonekey setvalue(self.clonesleft);

    if(self.clonesleft <= 0)
      self.clonekey.alpha = 0.5;
    else if(self.clonesleft > 0 && self.clonekey.alpha < 1)
      self.clonekey.alpha = 1.0;
  } else
    self setclientomnvar("ui_ph_num_clones_left", self.clonesleft);
}

prophasflashesleft() {
  return self.abilityleft > 0;
}

propdeductflash() {
  propsetflashesleft(self.abilityleft - 1);
}

propsetflashesleft(_id_8F617FFD000EB682) {
  self.abilityleft = _id_8F617FFD000EB682;

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.abilitykey setvalue(self.abilityleft);

    if(self.abilityleft <= 0)
      self.abilitykey.alpha = 0.5;
    else if(self.abilityleft > 0 && self.abilitykey.alpha < 1)
      self.abilitykey.alpha = 1.0;
  } else
    self setclientomnvar("ui_ph_num_flashes_left", self.abilityleft);
}

set_pitch_roll_for_ground_normal(_id_31CAEF840B7AC074) {
  _id_4F8BAD3CFC982AF1 = get_ground_normal(_id_31CAEF840B7AC074, 0);

  if(!isDefined(_id_4F8BAD3CFC982AF1)) {
    return;
  }
  _id_543553043475C8C6 = anglesToForward(self.angles);
  _id_543567043475F4C2 = anglestoright(self.angles);
  new_angles = vectortoangles(_id_4F8BAD3CFC982AF1);
  pitch = angleclamp180(new_angles[0] + 90);
  new_angles = (0, new_angles[1], 0);
  _id_65667E04420C7105 = anglesToForward(new_angles);
  mod = vectordot(_id_65667E04420C7105, _id_543567043475F4C2);

  if(mod < 0)
    mod = -1;
  else
    mod = 1;

  dot = vectordot(_id_65667E04420C7105, _id_543553043475C8C6);
  _id_555A507160626B39 = dot * pitch;
  _id_C8101CC17ECDF486 = (1 - abs(dot)) * pitch * mod;
  self.angles = (_id_555A507160626B39, self.angles[1], _id_C8101CC17ECDF486);
}

getignoreprops(_id_4B429C7665289F7D, _id_D0E05ADBDE4D0A59) {
  _id_A0FE5A5639AF4736 = 128;
  _id_3E397ABBF061BFDD = game["defenders"];
  _id_B63F20923B0F8856 = level.teamdata[_id_3E397ABBF061BFDD]["alivePlayers"];

  if(_id_B63F20923B0F8856.size > _id_A0FE5A5639AF4736) {
    _id_B63F20923B0F8856 = scripts\mp\utility\player::getplayersinradius(_id_4B429C7665289F7D, 500, _id_3E397ABBF061BFDD);

    if(_id_B63F20923B0F8856.size > _id_A0FE5A5639AF4736) {
      _id_B63F20923B0F8856 = scripts\mp\utility\player::getplayersinradius(_id_4B429C7665289F7D, 50, _id_3E397ABBF061BFDD);

      if(_id_B63F20923B0F8856.size > _id_A0FE5A5639AF4736)
        return _id_D0E05ADBDE4D0A59;
    }
  }

  ignorelist = [];

  foreach(player in _id_B63F20923B0F8856)
  ignorelist[ignorelist.size] = player.prop;
}

get_ground_normal(_id_31CAEF840B7AC074, debug) {
  if(!isDefined(_id_31CAEF840B7AC074))
    ignore = self;
  else
    ignore = _id_31CAEF840B7AC074;

  ignorelist = getignoreprops(self.origin, ignore);
  _id_D895C679F6A927E5 = [self.origin];

  for(_id_AC0E594AC96AA3A8 = -1.0; _id_AC0E594AC96AA3A8 <= 1.0; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2.0) {
    for(_id_AC0E5C4AC96AAA41 = -1.0; _id_AC0E5C4AC96AAA41 <= 1.0; _id_AC0E5C4AC96AAA41 = _id_AC0E5C4AC96AAA41 + 2.0) {
      _id_4E6D9BE609009734 = ignore getpointinbounds(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, 0.0);
      _id_4E6D9BE609009734 = (_id_4E6D9BE609009734[0], _id_4E6D9BE609009734[1], self.origin[2]);
      _id_D895C679F6A927E5[_id_D895C679F6A927E5.size] = _id_4E6D9BE609009734;
    }
  }

  _id_F863280C4EB41018 = (0, 0, 0);
  _id_97D8F5A9EB04C1F2 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    _id_B68850986D4C6C13 = trace["fraction"] > 0.0 && trace["fraction"] < 1;

    if(_id_B68850986D4C6C13) {
      _id_F863280C4EB41018 = _id_F863280C4EB41018 + trace["normal"];
      _id_97D8F5A9EB04C1F2++;
    }
  }

  if(_id_97D8F5A9EB04C1F2 > 0) {
    _id_F863280C4EB41018 = _id_F863280C4EB41018 / _id_97D8F5A9EB04C1F2;
    return _id_F863280C4EB41018;
  } else
    return undefined;
}

propmoveunlock() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_8329E15BF048A9A0 = 0;
  _id_CDA122E577B095DC = 0;
  _id_2815694CC3640D45 = 0;

  for(;;) {
    waitframe();
    movement = self getnormalizedmovement();
    jumping = self jumpbuttonPressed();

    if(!isDefined(movement)) {
      continue;
    }
    if(self.propspectating) {
      continue;
    }
    ismoving = movement[0] != 0 || movement[1] != 0 || jumping;

    if(self.lock && _id_2815694CC3640D45 && !ismoving)
      _id_2815694CC3640D45 = 0;
    else if(self.lock && !_id_8329E15BF048A9A0 && ismoving)
      _id_2815694CC3640D45 = 1;
    else if(self.lock && ismoving && !_id_2815694CC3640D45)
      unlockprop();

    _id_8329E15BF048A9A0 = self.lock;
    _id_CDA122E577B095DC = ismoving;
  }
}

unlockprop() {
  self unlink();

  if(self.slopelocked) {
    self.propent unlink();
    self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
    self.propent.origin = self.propanchor.origin;
    self.propent linkTo(self.propanchor);
  }

  self.propanchor linkTo(self);
  self.lock = 0;

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH/LOCK";
    thread flashlockpropkey();
  } else
    self setclientomnvar("ui_ph_is_locked", 0);
}

lockprop() {
  if(!canlock()) {
    return;
  }
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  groundentity = self getgroundentity();

  if(isDefined(groundentity) && groundentity entisalivevehicle())
    self.propanchor linkTo(groundentity);

  self playerlinkTo(self.propanchor);

  if(self.slopelocked) {
    self.propent unlink();
    self.propent set_pitch_roll_for_ground_normal(self.prop);
    self.propent.origin = self.origin;
    self.propent linkTo(self.propanchor);
  }

  self.lock = 1;
  self notify("locked");

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH/LOCKED";
    thread flashlockpropkey();
  } else
    self setclientomnvar("ui_ph_is_locked", 1);
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

flashlockpropkey() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("flashLockPropKey");
  self endon("flashLockPropKey");
  _id_1DA12FD8225B01E9 = self.lockpropkey.startfontscale + 0.75;
  self.lockpropkey changefontscaleovertime(0.1);
  self.lockpropkey.fontscale = _id_1DA12FD8225B01E9;
  wait 0.1;

  if(isDefined(self.lockpropkey)) {
    self.lockpropkey changefontscaleovertime(0.1);
    self.lockpropkey.fontscale = self.lockpropkey.startfontscale;
  }
}

canlock() {
  if(!self isonground()) {
    org = getgroundposition(self.origin, 15, 30000, 0);
    _id_62A9E105632784D0 = getEntArray("trigger_hurt", "classname");

    foreach(trigger in _id_62A9E105632784D0) {
      if(ispointinvolume(org, trigger))
        return 0;
    }
  }

  return 1;
}

propspectate() {
  level endon("noPropsToSpectate");
  self.propspectating = 0;
  self.endingpropspecate = 0;

  if(!isDefined(self.spectatenumber))
    self.spectatenumber = 0;

  for(;;) {
    _id_3A1C460252616FA7 = scripts\engine\utility::waittill_any_return_1("spectate");

    if(self.endingpropspecate) {
      continue;
    }
    if(_id_3A1C460252616FA7 == "spectate") {
      if(self.propspectating) {
        self notify("endPropSpectate");
        continue;
      }

      _id_733CE9BDDE8C500B::createpropspeclist();

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

  if(checkifvalidpropspectate())
    spectateprop();
  else {
    findvalidspectateprop(1);
    spectateprop();
  }

  for(;;) {
    _id_3A1C460252616FA7 = scripts\engine\utility::waittill_any_return_2("zoomin", "zoomout");

    if(self.endingpropspecate) {
      continue;
    }
    if(_id_3A1C460252616FA7 == "zoomin") {
      findvalidspectateprop(1);
      checkifvalidpropspectate();
      movetonewprop();
    }

    if(_id_3A1C460252616FA7 == "zoomout") {
      findvalidspectateprop(0);
      checkifvalidpropspectate();
      movetonewprop();
    }
  }
}

checkifvalidpropspectate() {
  _id_74C90BCCF8258CA1 = self.spectatableprops[self.spectatenumber];

  if(!isDefined(_id_74C90BCCF8258CA1))
    return 0;

  if(_id_74C90BCCF8258CA1 == self)
    return 0;

  if(scripts\mp\utility\player::isreallyalive(_id_74C90BCCF8258CA1))
    return 1;

  return 0;
}

findvalidspectateprop(_id_7ED05FD0C6B9DF64) {
  _id_CC153EAB6B0A25F0 = self.spectatenumber;

  for(;;) {
    if(istrue(_id_7ED05FD0C6B9DF64))
      self.spectatenumber++;
    else
      self.spectatenumber--;

    if(_id_7ED05FD0C6B9DF64 && self.spectatableprops.size <= self.spectatenumber)
      self.spectatenumber = 0;
    else if(self.spectatenumber < 0)
      self.spectatenumber = self.spectatableprops.size - 1;

    if(self.spectatenumber == _id_CC153EAB6B0A25F0) {
      break;
    }

    if(checkifvalidpropspectate()) {
      break;
    }
  }
}

propspectateendwatch() {
  self endon("death_or_disconnect");
  createpropspecatehud();
  scripts\engine\utility::waittill_any_ents(self, "endPropSpectate", level, "noPropsToSpectate");

  if(istrue(self.endingpropspecate)) {
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
  self.spectatecommands = scripts\mp\hud_util::createfontstring("default", 1);
  self.spectatecommands.label = &"MP_PH/SPECCOMMANDS";
  self.spectatecommands.x = 20;
  self.spectatecommands.y = -80;
  self.spectatecommands.alignx = "center";
  self.spectatecommands.aligny = "middle";
  self.spectatecommands.horzalign = "center_adjustable";
  self.spectatecommands.vertalign = "bottom_adjustable";
  self.spectatecommands.archived = 1;
  self.spectatecommands.fontscale = 1;
  self.spectatecommands.alpha = 1;
  self.spectatecommands.glowalpha = 0.5;
  self.spectatecommands.hidewheninmenu = 0;
}

destroypropspecatehud() {
  if(isDefined(self.spectatecommands))
    self.spectatecommands destroy();
}

spectateprop() {
  targetplayer = self.spectatableprops[self.spectatenumber];
  self.spectatingthisplayer = targetplayer;
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self setOrigin(targetplayer.origin);
  self.angles = targetplayer.angles;
  self playerlinkTo(targetplayer.propanchor);
}

movetonewprop() {
  targetplayer = self.spectatableprops[self.spectatenumber];
  self unlink();
  self.origin = targetplayer.origin;
  self.angles = targetplayer.angles;
  self playerlinkTo(targetplayer.propanchor);
}

returntoprop() {
  self unlink();
  self setOrigin(self.propanchor.origin);

  if(self.lock)
    self playerlinkTo(self.propanchor);
  else {
    self.propanchor linkTo(self);
    self.propanchor.origin = self.origin;
  }
}

nospectatablepropswatch() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");
  safedestroy(self.spectatekey);
}

propcamerazoom() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_3FF2D9758A1953D4 = 10;
  self.thirdpersonrange = self.prop.info.proprange;

  for(;;) {
    _id_0F57AC895DB887C6 = scripts\engine\utility::waittill_any_return_2("zoomin", "zoomout");

    if(istrue(self.endingpropspecate)) {
      continue;
    }
    if(!isDefined(_id_0F57AC895DB887C6)) {
      continue;
    }
    if(istrue(self.propspectating)) {
      continue;
    }
    if(_id_0F57AC895DB887C6 == "zoomin") {
      if(self.thirdpersonrange - _id_3FF2D9758A1953D4 < 50) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange - _id_3FF2D9758A1953D4;
      self setcamerathirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
      continue;
    }

    if(_id_0F57AC895DB887C6 == "zoomout") {
      _id_F38197C23C00A4C3 = clamp(self.prop.info.proprange + 50, 50, 360);

      if(self.thirdpersonrange + _id_3FF2D9758A1953D4 > _id_F38197C23C00A4C3) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange + _id_3FF2D9758A1953D4;
      self setcamerathirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    }
  }
}

proprotate() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(self adsButtonPressed(1) && !istrue(self.propent.spinning)) {
      self.propent scriptmodelpauseanim(0);
      self.propent.spinning = 1;
    } else if(!self adsButtonPressed(1) && istrue(self.propent.spinning)) {
      self.propent scriptmodelpauseanim(1);
      self.propent.spinning = 0;
    }

    wait 0.05;
  }
}

setnewabilityhud() {
  switch (self.currentability) {
    case "FLASH":
      self.abilitykey.label = &"MP_PH/FLASH";
      break;
    default:
      break;
  }
}

setnewabilitycount(_id_C2830A9405BFDD15, count) {
  switch (_id_C2830A9405BFDD15) {
    case "FLASH":
      if(!isDefined(count))
        count = level.ph.settings.propnumflashes;

      propsetflashesleft(count);
      break;
    case "CLONE":
      if(!isDefined(count))
        count = level.ph.settings.propnumclones;

      propsetclonesleft(count);
      break;
    default:
      break;
  }
}

flashtheprops(_id_908360EA9DF2BFBA) {
  level endon("game_ended");
  _id_908360EA9DF2BFBA endon("disconnect");
  thread scripts\mp\shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", position);

  if(!isDefined(_id_908360EA9DF2BFBA)) {
    return;
  }
  flashenemies(_id_908360EA9DF2BFBA, position);
}

flashenemies(_id_908360EA9DF2BFBA, position) {
  if(!isDefined(_id_908360EA9DF2BFBA))
    _id_908360EA9DF2BFBA = self;

  if(!isDefined(position))
    position = self.origin;

  playFX(scripts\engine\utility::getfx("propFlash"), position + (0, 0, 4));
  playsoundatpos(position, "prop_flashbang");

  foreach(_id_6EE5484560EC747C in level.players) {
    if(_id_6EE5484560EC747C == _id_908360EA9DF2BFBA) {
      continue;
    }
    if(istrue(_id_6EE5484560EC747C.flashimmune)) {
      continue;
    }
    if(!isDefined(_id_6EE5484560EC747C) || !isalive(_id_6EE5484560EC747C) || !isDefined(_id_6EE5484560EC747C.team) || _id_6EE5484560EC747C _id_733CE9BDDE8C500B::playerisprop()) {
      continue;
    }
    _id_06A3A1033FFC2699 = position + (0, 0, 4) - _id_6EE5484560EC747C getEye();
    dist = length(_id_06A3A1033FFC2699);
    _id_A7EAC493316DBBFE = 500.0;
    _id_A80EB693319617EC = 150.0;

    if(dist <= _id_A7EAC493316DBBFE) {
      if(dist <= _id_A80EB693319617EC)
        _id_DCFF7A77602A328C = 1;
      else
        _id_DCFF7A77602A328C = 1 - (dist - _id_A80EB693319617EC) / (_id_A7EAC493316DBBFE - _id_A80EB693319617EC);

      dir = vectorNormalize(_id_06A3A1033FFC2699);
      fwd = anglesToForward(_id_6EE5484560EC747C getplayerangles());
      _id_E7A479BBFAEB37F5 = vectordot(fwd, dir);
      _id_6EE5484560EC747C applyflash(position + (0, 0, 4), _id_DCFF7A77602A328C, _id_E7A479BBFAEB37F5, _id_908360EA9DF2BFBA, _id_908360EA9DF2BFBA.team, 2.0);
    }
  }
}

applyflash(origin, _id_F628FCD76C2AB40C, _id_1D63E53FC521E992, attacker, _id_FABF84450735DD93, _id_114766F678DC1055) {
  _id_2E87F85C47E4FDB2 = 2.5;

  if(!isDefined(_id_114766F678DC1055))
    _id_114766F678DC1055 = 0;

  if(_id_1D63E53FC521E992 < 0.25)
    _id_1D63E53FC521E992 = 0.25;
  else if(_id_1D63E53FC521E992 > 0.8)
    _id_1D63E53FC521E992 = 1;

  duration = _id_F628FCD76C2AB40C * _id_1D63E53FC521E992 * _id_2E87F85C47E4FDB2;
  duration = duration + _id_114766F678DC1055;

  if(duration < 0.25) {
    return;
  }
  attacker thread _id_5762AC2F22202BA2::updatedamagefeedback("standard");
  thread scripts\mp\equipment\flash_grenade::applyflash(attacker, duration);
}

deletepropsifatmax() {
  _id_4E6BFA885D9A9AAC = 9;

  if(self.propclones.size + 1 <= _id_4E6BFA885D9A9AAC) {
    return;
  }
  _id_62F0B6EAAD8B7109 = 0;

  foreach(clone in self.propclones) {
    if(isDefined(clone))
      _id_62F0B6EAAD8B7109++;
  }

  if(_id_62F0B6EAAD8B7109 + 1 <= _id_4E6BFA885D9A9AAC) {
    return;
  }
  _id_7CDC7D7D1C7EB20F = [];
  _id_679767995C3460A8 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.propclones.size; _id_AC0E594AC96AA3A8++) {
    clone = self.propclones[_id_AC0E594AC96AA3A8];

    if(!isDefined(clone)) {
      continue;
    }
    if(!isDefined(_id_679767995C3460A8)) {
      _id_679767995C3460A8 = clone;
      continue;
    }

    _id_7CDC7D7D1C7EB20F[_id_7CDC7D7D1C7EB20F.size] = clone;
  }

  _id_679767995C3460A8 notify("maxDelete");
  _id_679767995C3460A8 delete();
  self.propclones = _id_7CDC7D7D1C7EB20F;
}

cloneprop() {
  if(!isDefined(self.propclones))
    self.propclones = [];
  else
    deletepropsifatmax();

  _id_9C268ADCE4A40FDA = spawn("script_model", self.prop.origin);
  _id_9C268ADCE4A40FDA.targetname = "propClone";
  _id_9C268ADCE4A40FDA setModel(self.prop.model);
  _id_9C268ADCE4A40FDA.angles = self.prop.angles;
  _id_9C268ADCE4A40FDA.health = 50;
  _id_9C268ADCE4A40FDA.playerowner = self;
  _id_9C268ADCE4A40FDA setCanDamage(1);
  _id_9C268ADCE4A40FDA thread scripts\mp\damage::monitordamage(_id_9C268ADCE4A40FDA.health, "hitequip", ::clonedeath, ::damageclonewatch);
  _id_9C268ADCE4A40FDA thread _id_733CE9BDDE8C500B::highlighttoteam(game["defenders"], "outline_nodepth_orange");
  _id_9C268ADCE4A40FDA scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self.team);
  self.propclones[self.propclones.size] = _id_9C268ADCE4A40FDA;
}

damageclonewatch(damagedata) {
  if(!isDefined(damagedata.attacker))
    return 0;

  if(isPlayer(damagedata.attacker)) {
    if(istrue(self.isdying))
      return 0;

    damagedata.attacker thread _id_5762AC2F22202BA2::updatedamagefeedback("hitequip");
    self.lastattacker = damagedata.inflictor;
  }

  return damagedata.damage;
}

clonedeath(damagedata) {
  if(!isDefined(self.isdying))
    self.isdying = 1;

  if(isDefined(self.lastattacker)) {
    self.lastattacker thread _id_733CE9BDDE8C500B::giveawardfake("stat_A75C210D54170EC6");

    if(isDefined(self.playerowner))
      self.playerowner thread _id_733CE9BDDE8C500B::giveawardfake("stat_2F326C8FBA1662F4");
  }

  deathnoise = "prop_death";
  propdeathfx = "propDeathFX";
  playsoundatpos(self.origin + (0, 0, 4), deathnoise);
  playFX(scripts\engine\utility::getfx(propdeathfx), self.origin + (0, 0, 4));

  if(isDefined(self))
    self delete();
}

fadetoblackforxsec(_id_94536D71F187ABA1, fade_in_time, fade_out_time) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_94536D71F187ABA1))
    _id_94536D71F187ABA1 = 5;

  if(!isDefined(fade_in_time))
    fade_in_time = 1;

  if(!isDefined(fade_out_time))
    fade_out_time = 1;

  overlay = newclienthudelem(self);
  overlay.foreground = 0;
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  waitframe();

  if(fade_in_time > 0)
    overlay fadeovertime(fade_in_time);

  overlay.alpha = 1;
  wait(_id_94536D71F187ABA1 - fade_out_time);

  if(fade_out_time > 0)
    overlay fadeovertime(fade_out_time);

  overlay.alpha = 0;
  wait(fade_out_time);
  waitframe();
  safedestroy(overlay);
}

watchspecialgrenadethrow() {
  self endon("death_or_disconnect");
  self notifyonplayercommand("specialGrenade", "+smoke");

  for(;;) {
    self waittill("specialGrenade");
    self.thrownspecialcount = self.thrownspecialcount + 1;
  }
}

hidehudintermission() {
  level waittill("game_ended");

  if(_id_733CE9BDDE8C500B::useprophudserver()) {
    level.elim_hud.alpha = 0;
    level.ph.whistletimer.alpha = 0;
    level.whistling.alpha = 0;
  }

  foreach(player in level.players)
  player propabilitykeysvisible(0);
}

safesetalpha(_id_94480E1669B7FF0D, _id_05DA285551F5EED0) {
  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D.alpha = _id_05DA285551F5EED0;
}

propabilitykeysvisible(visible, override) {
  if(istrue(visible))
    _id_E7B8E2A5586F580C = 1;
  else
    _id_E7B8E2A5586F580C = 0;

  if(_id_733CE9BDDE8C500B::useprophudserver() || istrue(override)) {
    safesetalpha(self.changepropkey, _id_E7B8E2A5586F580C);
    safesetalpha(self.spinpropkey, _id_E7B8E2A5586F580C);
    safesetalpha(self.lockpropkey, _id_E7B8E2A5586F580C);
    safesetalpha(self.matchslopekey, _id_E7B8E2A5586F580C);
    safesetalpha(self.abilitykey, _id_E7B8E2A5586F580C);
    safesetalpha(self.clonekey, _id_E7B8E2A5586F580C);
    safesetalpha(self.zoomkey, _id_E7B8E2A5586F580C);

    if(!istrue(level.nopropsspectate))
      safesetalpha(self.spectatekey, _id_E7B8E2A5586F580C);
  }
}