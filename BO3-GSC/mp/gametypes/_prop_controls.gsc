/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_prop_controls.gsc
*************************************************/

#using scripts\mp\_teamops;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_dogtags;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_spawn;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_prop_dev;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\prop;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#namespace namespace_4c773ed3;

function notifyonplayercommand(command, key) {
  assert(isplayer(self));
  self thread function_e17a8f06(command, key);
}

function notifyonplayercommandremove(command, key) {
  self notify((command + "_") + key);
}

function function_e17a8f06(command, key) {
  self endon("disconnect");
  level endon("game_ended");
  self notify((command + "_") + key);
  self endon((command + "_") + key);
  switch (key) {
    case "+attack": {
      function_c6639fc9(&attackbuttonpressed, command);
      break;
    }
    case "+toggleads_throw": {
      function_c6639fc9(&adsbuttonpressed, command);
      break;
    }
    case "weapnext": {
      function_c6639fc9(&weaponswitchbuttonpressed, command);
      break;
    }
    case "+usereload": {
      function_c6639fc9(&usebuttonpressed, command);
      break;
    }
    case "+smoke": {
      function_c6639fc9(&secondaryoffhandbuttonpressed, command);
      break;
    }
    case "+frag": {
      function_c6639fc9(&fragbuttonpressed, command);
      break;
    }
    case "+actionslot 1": {
      function_c6639fc9(&actionslotonebuttonpressed, command);
      break;
    }
    case "+actionslot 2": {
      function_c6639fc9(&actionslottwobuttonpressed, command);
      break;
    }
    case "+actionslot 3": {
      function_c6639fc9(&actionslotthreebuttonpressed, command);
      break;
    }
    case "+actionslot 4": {
      function_c6639fc9(&actionslotfourbuttonpressed, command);
      break;
    }
    case "-actionslot 1": {
      function_b01c4bcb(&actionslotonebuttonpressed, command);
      break;
    }
    case "-actionslot 2": {
      function_b01c4bcb(&actionslottwobuttonpressed, command);
      break;
    }
    case "-actionslot 3": {
      function_b01c4bcb(&actionslotthreebuttonpressed, command);
      break;
    }
    case "-actionslot 4": {
      function_b01c4bcb(&actionslotfourbuttonpressed, command);
      break;
    }
    case "+stance": {
      function_b01c4bcb(&stancebuttonpressed, command);
      break;
    }
    case "+breath_sprint": {
      function_b01c4bcb(&sprintbuttonpressed, command);
      break;
    }
    case "+melee": {
      function_b01c4bcb(&meleebuttonpressed, command);
      break;
    }
  }
}

function function_c6639fc9(var_33b64687, command) {
  while(true) {
    while(!self[[var_33b64687]]()) {
      wait(0.05);
    }
    self notify(command);
    while(self[[var_33b64687]]()) {
      wait(0.05);
    }
  }
}

function function_b01c4bcb(var_33b64687, command) {
  while(true) {
    while(!self[[var_33b64687]]()) {
      wait(0.05);
    }
    while(self[[var_33b64687]]()) {
      wait(0.05);
    }
    self notify(command);
  }
}

function setupkeybindings() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("lock", "+attack");
  self notifyonplayercommand("spin", "+toggleads_throw");
  self notifyonplayercommand("changeProp", "weapnext");
  self notifyonplayercommand("setToSlope", "+usereload");
  self notifyonplayercommand("propAbility", "+smoke");
  self notifyonplayercommand("cloneProp", "+actionslot 2");
  self notifyonplayercommand("zoomin", "+actionslot 3");
  self notifyonplayercommand("zoomout", "+actionslot 4");
  self notifyonplayercommand("hide", "+melee");
}

function function_3122ae57() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommandremove("lock", "+attack");
  self notifyonplayercommandremove("spin", "+toggleads_throw");
  self notifyonplayercommandremove("changeProp", "+weapnext");
  self notifyonplayercommandremove("setToSlope", "+usereload");
  self notifyonplayercommandremove("propAbility", "+smoke");
  self notifyonplayercommandremove("cloneProp", "+actionslot 2");
  self notifyonplayercommandremove("zoomin", "+actionslot 3");
  self notifyonplayercommandremove("zoomout", "+actionslot 4");
  self notifyonplayercommandremove("hide", "+melee");
}

function is_player_gamepad_enabled() {
  return self gamepadusedlast();
}

function addupperrighthudelem(label, value, text, labelpc) {
  hudelem = hud::createfontstring("default", 1.2);
  hudelem.x = -15;
  hudelem.y = self.currenthudy;
  hudelem.alignx = "right";
  hudelem.aligny = "bottom";
  hudelem.horzalign = "right";
  hudelem.vertalign = "bottom";
  hudelem.archived = 1;
  hudelem.alpha = 1;
  hudelem.glowalpha = 0;
  hudelem.hidewheninmenu = 1;
  hudelem.hidewheninkillcam = 1;
  hudelem.startfontscale = hudelem.fontscale;
  if(isDefined(label) && isDefined(labelpc)) {
    if(self is_player_gamepad_enabled()) {
      hudelem.label = label;
    } else {
      hudelem.label = labelpc;
    }
  } else {
    if(isDefined(label)) {
      hudelem.label = label;
    } else if(isDefined(text)) {
      hudelem settext(text);
    }
  }
  if(isDefined(value)) {
    hudelem setvalue(value);
  }
  self.currenthudy = self.currenthudy - 20;
  return hudelem;
}

function propcontrolshud() {
  assert(!isDefined(self.changepropkey));
  if(self issplitscreen()) {
    self.currenthudy = -10;
  } else {
    self.currenthudy = -80;
  }
  self.abilitykey = addupperrighthudelem();
  self.clonekey = addupperrighthudelem(&"MP_PH_CLONE");
  self.changepropkey = addupperrighthudelem(&"MP_PH_CHANGE", 0);
  self.currenthudy = self.currenthudy - 20;
  self.var_6f16621b = addupperrighthudelem(&"MP_PH_HIDEPROP");
  self.matchslopekey = addupperrighthudelem(&"MP_PH_SLOPE", undefined, undefined, &"MP_PH_SLOPE_PC");
  self.lockpropkey = addupperrighthudelem(&"MP_PH_LOCK");
  self.spinpropkey = addupperrighthudelem(&"MP_PH_SPIN", undefined, undefined, &"MP_PH_SPIN_PC");
  self setnewabilityhud();
  self.zoomkey = addupperrighthudelem(&"MP_PH_ZOOM");
  self thread updatetextongamepadchange();
}

function cleanuppropcontrolshudondeath() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  self thread function_3122ae57();
  self thread cleanuppropcontrolshud();
}

function safedestroy(hudelem) {
  if(isDefined(hudelem)) {
    hudelem destroy();
  }
}

function cleanuppropcontrolshud() {
  safedestroy(self.changepropkey);
  safedestroy(self.spinpropkey);
  safedestroy(self.lockpropkey);
  safedestroy(self.matchslopekey);
  safedestroy(self.abilitykey);
  safedestroy(self.zoomkey);
  safedestroy(self.spectatekey);
  safedestroy(self.clonekey);
  safedestroy(self.var_6f16621b);
}

function updatetextongamepadchange() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  if(level.console) {
    return;
  }
  waittillframeend();
  var_85e0f0fe = self is_player_gamepad_enabled();
  while(true) {
    var_521408c = self is_player_gamepad_enabled();
    if(var_521408c != var_85e0f0fe) {
      var_85e0f0fe = var_521408c;
      if(var_521408c) {
        if(!(isDefined(self.slopelocked) && self.slopelocked)) {
          self.matchslopekey.label = &"MP_PH_SLOPE";
        } else {
          self.matchslopekey.label = &"MP_PH_SLOPED";
        }
        self.spinpropkey.label = &"MP_PH_SPIN";
      } else {
        if(!(isDefined(self.slopelocked) && self.slopelocked)) {
          self.matchslopekey.label = &"MP_PH_SLOPE_PC";
        } else {
          self.matchslopekey.label = &"MP_PH_SLOPED_PC";
        }
        self.spinpropkey.label = &"MP_PH_SPIN_PC";
      }
    }
    wait(0.05);
  }
}

function propinputwatch() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isai(self)) {
    return;
  }
  self.lock = 0;
  self.slopelocked = 0;
  prop::function_45c842e9();
  self thread propmoveunlock();
  self thread propcamerazoom();
  self.debugnextpropindex = 1;
  while(true) {
    msg = self util::waittill_any_return("lock", "spin", "changeProp", "setToSlope", "propAbility", "cloneProp", "hide");
    if(!isDefined(msg)) {
      continue;
    }
    waittillframeend();
    if(msg == "lock") {
      self proplockunlock();
    } else {
      if(msg == "spin") {
        self function_90ce903e();
      } else {
        if(msg == "changeProp") {
          self propchange();
        } else {
          if(msg == "setToSlope") {
            self propmatchslope();
          } else {
            if(msg == "propAbility") {
              self propability();
            } else {
              if(msg == "cloneProp") {
                self propclonepower();
              } else if(msg == "hide") {
                self function_8b7be7e3();
              }
            }
          }
        }
      }
    }
  }
}

function proplockunlock() {
  if(self ismantling()) {
    return;
  }
  if(self.lock) {
    self unlockprop();
  } else {
    self lockprop();
  }
}

function function_90ce903e() {
  self.propent unlink();
  self.propent.angles = self.propent.angles + vectorscale((0, 1, 0), 45);
  self.propent.origin = self.propanchor.origin;
  if(self.slopelocked && (isDefined(self.lock) && self.lock)) {
    self.propent set_pitch_roll_for_ground_normal(self.prop);
  }
  self.propent linkto(self.propanchor);
}

function registerpreviousprop(var_bc9de76b) {
  var_771596a5 = 3;
  if(!isDefined(var_bc9de76b.usedpropsindex)) {
    var_bc9de76b.usedpropsindex = 0;
  }
  var_bc9de76b.usedprops[var_bc9de76b.usedpropsindex] = var_bc9de76b.prop.info;
  var_bc9de76b.usedpropsindex++;
  if(var_bc9de76b.usedpropsindex >= var_771596a5) {
    var_bc9de76b.usedpropsindex = 0;
  }
}

function propchange() {
  if(!self prophaschangesleft()) {
    return;
  }
  if(!level.console) {
    var_6f5743e8 = 300;
    if(isDefined(self.lastpropchangetime) && (gettime() - self.lastpropchangetime) < var_6f5743e8) {
      return;
    }
    self.lastpropchangetime = gettime();
  }
  self notify("hash_a603bd25");
  registerpreviousprop(self);
  self.prop.info = prop::getnextprop(self);
  if(getdvarint("", 0) != 0) {
    self.prop.info = level.proplist[self.debugnextpropindex];
    self.debugnextpropindex++;
    if(self.debugnextpropindex >= level.proplist.size) {
      self.debugnextpropindex = 0;
    }
  }
  self propchangeto(self.prop.info);
  if(level.phsettings.var_e332c699) {
    playFXOnTag("player/fx_plyr_clone_reaper_appear", self.prop, "tag_origin");
  }
  self.maxhealth = int(prop::getprophealth(self.prop.info));
  self setnormalhealth(1);
  self setnewabilitycount(self.currentability);
  self setnewabilitycount("CLONE");
  if(prop::useprophudserver()) {
    self.abilitykey.alpha = 1;
    self.clonekey.alpha = 1;
  }
  if(getdvarint("", 0) != 0) {
    return;
  }
  self propdeductchange();
}

function prophaschangesleft() {
  if(isDefined(self.var_c4494f8d) && self.var_c4494f8d) {
    return 1;
  }
  return self.changesleft > 0;
}

function propdeductchange() {
  if(isDefined(self.var_c4494f8d) && self.var_c4494f8d) {
    return;
  }
  propsetchangesleft(self.changesleft - 1);
}

function propsetchangesleft(newvalue) {
  self.changesleft = newvalue;
  if(prop::useprophudserver()) {
    self.changepropkey setvalue(self.changesleft);
    if(self.changesleft <= 0) {
      self.changepropkey.alpha = 0.5;
    }
  }
}

function propchangeto(info) {
  self.prop.info = info;
  self.propinfo = info;
  if(level.phsettings.var_e332c699) {
    var_5e63b8b5 = self.propent.angles;
    var_345eaa38 = self.prop.angles;
    var_9b6a4a66 = self.angles;
  }
  self.prop setModel(info.modelname);
  self.prop.xyzoffset = info.xyzoffset;
  self.prop.anglesoffset = info.anglesoffset;
  self.prop setscale(info.var_bbac36c8, 1);
  self.prop unlink();
  self.propent unlink();
  self.propent.origin = self.propanchor.origin;
  self.prop.origin = self.propent.origin;
  self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
  self.prop.angles = self.propent.angles;
  if(isDefined(self.isangleoffset) && self.isangleoffset) {
    self.prop.angles = self.angles;
    self.isangleoffset = 0;
  }
  self prop::applyxyzoffset();
  self prop::applyanglesoffset();
  if(level.phsettings.var_e332c699) {
    self.propent.angles = var_5e63b8b5;
    self.prop.angles = var_345eaa38;
    self.angles = var_9b6a4a66;
  }
  self.prop linkto(self.propent);
  if(self.slopelocked && (isDefined(self.lock) && self.lock)) {
    self.propent set_pitch_roll_for_ground_normal(self.prop);
  }
  self.propent linkto(self.propanchor);
  self.thirdpersonrange = info.proprange;
  self.thirdpersonheightoffset = info.propheight;
  self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
}

function propmatchslope() {
  if(!(isDefined(self.slopelocked) && self.slopelocked)) {
    self.slopelocked = 1;
    if(isDefined(self.lock) && self.lock) {
      self.propent unlink();
      self.propent set_pitch_roll_for_ground_normal(self.prop);
      self.propent linkto(self.propanchor);
    }
    if(prop::useprophudserver()) {
      if(self is_player_gamepad_enabled()) {
        self.matchslopekey.label = &"MP_PH_SLOPED";
      } else {
        self.matchslopekey.label = &"MP_PH_SLOPED_PC";
      }
    }
  } else {
    self.slopelocked = 0;
    if(isDefined(self.lock) && self.lock) {
      self.propent unlink();
      self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
      self.propent.origin = self.propanchor.origin;
      self.propent linkto(self.propanchor);
    }
    if(prop::useprophudserver()) {
      if(self is_player_gamepad_enabled()) {
        self.matchslopekey.label = &"MP_PH_SLOPE";
      } else {
        self.matchslopekey.label = &"MP_PH_SLOPE_PC";
      }
    }
  }
}

function propability() {
  if(!level flag::get("props_hide_over")) {
    return;
  }
  if(self prophasflashesleft()) {
    self thread flashenemies();
    self propdeductflash();
  }
}

function propclonepower() {
  if(prophasclonesleft()) {
    self thread cloneprop();
    self thread propdeductclonechange();
  }
}

function prophasclonesleft() {
  if(isDefined(self.var_b53602f4) && self.var_b53602f4) {
    return 1;
  }
  return self.clonesleft > 0;
}

function propdeductclonechange() {
  if(isDefined(self.var_b53602f4) && self.var_b53602f4) {
    return;
  }
  propsetclonesleft(self.clonesleft - 1);
}

function propsetclonesleft(newvalue) {
  self.clonesleft = newvalue;
  if(prop::useprophudserver() && isDefined(self) && isalive(self) && isDefined(self.clonekey)) {
    self.clonekey setvalue(self.clonesleft);
    if(self.clonesleft <= 0) {
      self.clonekey.alpha = 0.5;
    } else {
      self.clonekey.alpha = 1;
    }
  }
}

function prophasflashesleft() {
  if(isDefined(self.var_2f1101f4) && self.var_2f1101f4) {
    return 1;
  }
  return self.abilityleft > 0;
}

function propdeductflash() {
  if(isDefined(self.var_2f1101f4) && self.var_2f1101f4) {
    return;
  }
  propsetflashesleft(self.abilityleft - 1);
}

function propsetflashesleft(newvalue) {
  self.abilityleft = newvalue;
  if(prop::useprophudserver()) {
    self.abilitykey setvalue(self.abilityleft);
    if(self.abilityleft <= 0) {
      self.abilitykey.alpha = 0.5;
    }
  }
}

function set_pitch_roll_for_ground_normal(var_a84e1ffa) {
  groundnormal = get_ground_normal(var_a84e1ffa, 0);
  if(!isDefined(groundnormal)) {
    return;
  }
  var_a8f94d84 = anglesToForward(self.angles);
  ovr = anglestoright(self.angles);
  new_angles = vectortoangles(groundnormal);
  pitch = angleclamp180(new_angles[0] + 90);
  new_angles = (0, new_angles[1], 0);
  var_7001e881 = anglesToForward(new_angles);
  mod = vectordot(var_7001e881, ovr);
  if(mod < 0) {
    mod = -1;
  } else {
    mod = 1;
  }
  dot = vectordot(var_7001e881, var_a8f94d84);
  var_4ef8701 = dot * pitch;
  var_676ea8f0 = ((1 - abs(dot)) * pitch) * mod;
  self.angles = (var_4ef8701, self.angles[1], var_676ea8f0);
}

function function_b811663a(var_32d4bb6a) {
  foreach(player in level.players) {
    if(isDefined(player.prop)) {
      if(var_32d4bb6a) {
        player.prop notsolid();
        continue;
      }
      player.prop solid();
    }
  }
}

function function_af3207f6(var_32d4bb6a) {
  foreach(player in level.players) {
    if(isDefined(player.propclones)) {
      foreach(clone in player.propclones) {
        if(isDefined(clone)) {
          if(var_32d4bb6a) {
            clone notsolid();
            continue;
          }
          clone solid();
        }
      }
    }
  }
}

function get_ground_normal(var_a84e1ffa, debug) {
  if(!isDefined(var_a84e1ffa)) {
    ignore = self;
  } else {
    ignore = var_a84e1ffa;
  }
  var_4f9e9c19 = array(self.origin);
  if(getdvarint("scr_ph_useBoundsForGroundNormal", 1)) {
    i = -1;
    while(i <= 1) {
      j = -1;
      while(j <= 1) {
        corner = ignore getpointinbounds(i, j, 0);
        corner = (corner[0], corner[1], self.origin[2]);
        var_4f9e9c19[var_4f9e9c19.size] = corner;
        j = j + 2;
      }
      i = i + 2;
    }
  }
  function_b811663a(1);
  var_d54ec402 = (0, 0, 0);
  var_6146aef8 = 0;
  foreach(point in var_4f9e9c19) {
    trace = bulletTrace(point + vectorscale((0, 0, 1), 4), point + (vectorscale((0, 0, -1), 16)), 0, ignore);
    tracehit = trace["fraction"] > 0 && trace["fraction"] < 1;
    if(tracehit) {
      var_d54ec402 = var_d54ec402 + trace["normal"];
      var_6146aef8++;
    }
    if(debug) {
      if(tracehit) {
        line(point, point + (trace[""] * 30), (0, 1, 0));
        continue;
      }
      sphere(point, 3, (1, 0, 0));
    }
  }
  function_b811663a(0);
  if(var_6146aef8 > 0) {
    var_d54ec402 = var_d54ec402 / var_6146aef8;
    if(debug) {
      line(self.origin, self.origin + (var_d54ec402 * 20), (1, 1, 1));
    }
    return var_d54ec402;
  }
  if(debug) {
    sphere(self.origin, 5, (1, 0, 0));
  }
  return undefined;
}

function propmoveunlock() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_f98cbcda = 0;
  var_bc31618a = 0;
  var_449744f5 = 0;
  while(true) {
    wait(0.05);
    movement = self getnormalizedmovement();
    jumping = self jumpbuttonpressed();
    if(!isDefined(movement)) {
      continue;
    }
    ismoving = movement[0] != 0 || movement[1] != 0 || jumping;
    if(self.lock && var_449744f5 && !ismoving) {
      var_449744f5 = 0;
    } else {
      if(self.lock && !var_f98cbcda && ismoving) {
        var_449744f5 = 1;
      } else if(self.lock && ismoving && !var_449744f5) {
        self unlockprop();
      }
    }
    var_f98cbcda = self.lock;
    var_bc31618a = ismoving;
  }
}

function unlockprop() {
  self unlink();
  self resetdoublejumprechargetime();
  if(self.slopelocked) {
    self.propent unlink();
    self.propent.angles = (self.angles[0], self.propent.angles[1], self.angles[2]);
    self.propent.origin = self.propanchor.origin;
    self.propent linkto(self.propanchor);
  }
  self.propanchor linkto(self);
  self.lock = 0;
  if(prop::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH_LOCK";
    self thread flashlockpropkey();
  }
}

function lockprop() {
  if(!canlock()) {
    return;
  }
  self.propanchor unlink();
  self.propanchor.origin = self.origin;
  self playerlinkto(self.propanchor);
  if(self.slopelocked) {
    self.propent unlink();
    self.propent set_pitch_roll_for_ground_normal(self.prop);
    self.propent.origin = self.origin;
    self.propent linkto(self.propanchor);
  }
  self.lock = 1;
  self notify("locked");
  if(prop::useprophudserver()) {
    self.lockpropkey.label = &"MP_PH_LOCKED";
    self thread flashlockpropkey();
  }
}

function flashlockpropkey() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("flashlockpropkey");
  self endon("flashlockpropkey");
  var_ec404e3d = self.lockpropkey.startfontscale + 0.75;
  self.lockpropkey changefontscaleovertime(0.1);
  self.lockpropkey.fontscale = var_ec404e3d;
  wait(0.1);
  if(isDefined(self.lockpropkey)) {
    self.lockpropkey changefontscaleovertime(0.1);
    self.lockpropkey.fontscale = self.lockpropkey.startfontscale;
  }
}

function function_fd824ee5() {
  assert(isplayer(self));
  start = self.origin;
  end = start + (vectorscale((0, 0, -1), 2000));
  return playerphysicstrace(start, end);
}

function function_b9733d59() {
  assert(isplayer(self));
  start = self.origin;
  end = start + (vectorscale((0, 0, -1), 2000));
  trace = bulletTrace(start, end, 0, self.prop);
  return trace;
}

function function_2dff88ca(success, type, player, origin1, text1, origin2, text2, origin3, text3) {
  if(!isDefined(level.var_ec1690fd)) {
    level.var_ec1690fd = spawnStruct();
  }
  level.var_ec1690fd.success = success;
  level.var_ec1690fd.type = type;
  level.var_ec1690fd.playerorg = player.origin;
  level.var_ec1690fd.playerangles = player.angles;
  level.var_ec1690fd.playermins = player getmins();
  level.var_ec1690fd.playermaxs = player getmaxs();
  level.var_ec1690fd.origin1 = origin1;
  level.var_ec1690fd.text1 = text1;
  level.var_ec1690fd.origin2 = origin2;
  level.var_ec1690fd.text2 = text2;
  level.var_ec1690fd.origin3 = origin3;
  level.var_ec1690fd.text3 = text3;
}

function canlock() {
  killtriggers = getEntArray("trigger_hurt", "classname");
  oobtriggers = getEntArray("trigger_out_of_bounds", "classname");
  triggers = arraycombine(killtriggers, oobtriggers, 0, 0);
  var_40aa9cbd = getEntArray("prop_no_lock", "targetname");
  if(var_40aa9cbd.size > 0) {
    triggers = arraycombine(triggers, var_40aa9cbd, 0, 0);
  }
  foreach(trigger in triggers) {
    if(trigger istouchingvolume(self.origin, self getmins(), self getmaxs())) {
      function_2dff88ca(0, "", self, trigger.origin, trigger.classname);
      return false;
    }
  }
  if(self isplayerswimming()) {
    function_2dff88ca(1, "", self);
    return true;
  }
  if(!self isonground() || self iswallrunning()) {
    trace1 = self function_b9733d59();
    frac = trace1["fraction"];
    org1 = trace1["position"];
    if(frac == 1) {
      function_2dff88ca(0, "", self, org1, "");
      return false;
    }
    foreach(trigger in triggers) {
      if(trigger istouchingvolume(org1, self getmins(), self getmaxs())) {
        function_2dff88ca(0, "", self, trigger.origin, trigger.classname);
        return false;
      }
    }
    point = getnearestpathpoint(org1, 256);
    if(!isDefined(point)) {
      function_2dff88ca(0, "", self, org1);
      return false;
    }
    distz = point[2] - org1[2];
    if(distz > 50) {
      point2 = getnearestpathpoint(org1, 50);
      if(!isDefined(point2)) {
        function_2dff88ca(0, "", self, org1, "", point, "");
        return false;
      }
    }
    dist2d = distance2d(point, org1);
    if(dist2d > 100) {
      function_2dff88ca(0, "", self, org1, "", point, "");
      return false;
    }
    org2 = self function_fd824ee5();
    foreach(trigger in triggers) {
      if(trigger istouchingvolume(org2, self getmins(), self getmaxs())) {
        function_2dff88ca(0, "", self, trigger.origin, trigger.classname);
        return false;
      }
    }
    function_2dff88ca(1, "", self, org1, "", org2, "", point, "" + distance(org1, point));
    return true;
  }
  function_2dff88ca(1, "", self);
  return true;
}

function propcamerazoom() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_8ea3acea = 10;
  self.thirdpersonrange = self.prop.info.proprange;
  while(true) {
    zoom = self util::waittill_any_return("zoomin", "zoomout");
    if(!isDefined(zoom)) {
      continue;
    }
    if(zoom == "zoomin") {
      if((self.thirdpersonrange - var_8ea3acea) < 50) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange - var_8ea3acea;
      self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    } else if(zoom == "zoomout") {
      var_b751fa63 = math::clamp(self.prop.info.proprange + 50, 50, 360);
      if((self.thirdpersonrange + var_8ea3acea) > var_b751fa63) {
        continue;
      }
      self.thirdpersonrange = self.thirdpersonrange + var_8ea3acea;
      self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    }
  }
}

function setnewabilityhud() {
  switch (self.currentability) {
    case "FLASH": {
      self.abilitykey.label = &"MP_PH_FLASH";
      break;
    }
    default: {
      assertmsg("");
      break;
    }
  }
}

function setnewabilitycount(var_9c968389, count) {
  switch (var_9c968389) {
    case "FLASH": {
      if(!isDefined(count)) {
        count = level.phsettings.propnumflashes;
      }
      propsetflashesleft(count);
      break;
    }
    case "CLONE": {
      if(!isDefined(count)) {
        count = level.phsettings.propnumclones;
      }
      propsetclonesleft(count);
      break;
    }
    default: {
      assertmsg("" + var_9c968389);
      break;
    }
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function flashtheprops(var_e967d644) {
  level endon("game_ended");
  var_e967d644 endon("disconnect");
  self thread endondeath();
  self endon("end_explode");
  self waittill("explode", position);
  if(!isDefined(var_e967d644)) {
    return;
  }
  flashenemies(var_e967d644, position);
}

function flashenemies(var_e967d644 = self, position = self.origin) {
  playFX(fx::get("propFlash"), position + vectorscale((0, 0, 1), 4));
  playsoundatposition("mpl_emp_equip_stun", position);
  foreach(otherplayer in level.players) {
    if(otherplayer == var_e967d644) {
      continue;
    }
    if(isDefined(otherplayer.flashimmune) && otherplayer.flashimmune) {
      continue;
    }
    if(!isDefined(otherplayer) || !isalive(otherplayer) || !isDefined(otherplayer.team) || otherplayer.team != game["attackers"]) {
      continue;
    }
    vec = (position + vectorscale((0, 0, 1), 4)) - otherplayer getEye();
    dist = length(vec);
    var_6df9e8b8 = 500;
    var_88ef1466 = 150;
    if(dist <= var_6df9e8b8) {
      if(dist <= var_88ef1466) {
        var_bdf6b2ee = 1;
      } else {
        var_bdf6b2ee = 1 - (dist - var_88ef1466) / (var_6df9e8b8 - var_88ef1466);
      }
      dir = vectornormalize(vec);
      fwd = anglesToForward(otherplayer getplayerangles());
      var_b02fb38d = vectordot(fwd, dir);
      otherplayer notify("flashbang", var_bdf6b2ee, var_b02fb38d, var_e967d644);
      var_e967d644 thread damagefeedback::update();
    }
  }
}

function deletepropsifatmax() {
  var_b793211e = 9;
  if(level.phsettings.var_78280ce0) {
    var_b793211e = 27;
  }
  if((self.propclones.size + 1) <= var_b793211e) {
    return;
  }
  var_b76d0af5 = 0;
  foreach(clone in self.propclones) {
    if(isDefined(clone)) {
      var_b76d0af5++;
    }
  }
  if((var_b76d0af5 + 1) <= var_b793211e) {
    return;
  }
  clones = [];
  var_1292f83e = undefined;
  for(i = 0; i < self.propclones.size; i++) {
    clone = self.propclones[i];
    if(!isDefined(clone)) {
      continue;
    }
    if(!isDefined(var_1292f83e)) {
      var_1292f83e = clone;
      continue;
    }
    clones[clones.size] = clone;
  }
  assert(isDefined(var_1292f83e));
  var_1292f83e notify("hash_63ce821c");
  var_1292f83e delete();
  self.propclones = clones;
}

function cloneprop() {
  if(!isDefined(self.propclones)) {
    self.propclones = [];
  } else {
    deletepropsifatmax();
  }
  var_a20cbf64 = spawn("script_model", self.prop.origin);
  var_a20cbf64.targetname = "propClone";
  var_a20cbf64 setModel(self.prop.model);
  var_a20cbf64 setscale(self.prop.info.var_bbac36c8, 1);
  var_a20cbf64.angles = self.prop.angles;
  var_a20cbf64 setCanDamage(1);
  var_a20cbf64.fakehealth = 50;
  var_a20cbf64.health = 99999;
  var_a20cbf64.maxhealth = 99999;
  var_a20cbf64.playerowner = self;
  var_a20cbf64 thread prop::function_500dc7d9(&damageclonewatch);
  var_a20cbf64 setplayercollision(0);
  var_a20cbf64 makesentient();
  var_a20cbf64 notsolidcapsule();
  var_a20cbf64 setteam(self.team);
  var_a20cbf64 clientfield::set("enemyequip", 2);
  if(prop::function_503c9413()) {
    var_a20cbf64 hidefromteam(game["attackers"]);
    var_a20cbf64 notsolid();
  }
  if(level.phsettings.var_78280ce0) {
    var_a20cbf64.fakehealth = 100;
  }
  self.propclones[self.propclones.size] = var_a20cbf64;
}

function damageclonewatch(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
  if(!isDefined(attacker)) {
    return;
  }
  if(isplayer(attacker)) {
    if(isDefined(self.isdying) && self.isdying) {
      return;
    }
    if(isDefined(weapon) && weapon.rootweapon.name == "concussion_grenade" && isDefined(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      function_770b4cfa(attacker, undefined, meansofdeath, damage, point, weapon);
    }
    attacker thread damagefeedback::update();
    self.lastattacker = attacker;
    self.fakehealth = self.fakehealth - damage;
    if(self.fakehealth <= 0) {
      self function_a40d8853();
      return;
    }
  }
  self.health = self.health + damage;
}

function function_8e6b5244() {
  self.var_86fdc107.alpha = 1;
  self.var_86fdc107 fadeovertime(3);
  self.var_86fdc107.alpha = 0;
}

function function_de01cce2() {
  self.var_86fdc107 = hud::createfontstring("objective", 1);
  self.var_86fdc107.label = &"SCORE_DECOY_KILLED";
  self.var_86fdc107.x = 0;
  self.var_86fdc107.y = 20;
  self.var_86fdc107.alignx = "center";
  self.var_86fdc107.aligny = "middle";
  self.var_86fdc107.horzalign = "user_center";
  self.var_86fdc107.vertalign = "middle";
  self.var_86fdc107.archived = 1;
  self.var_86fdc107.fontscale = 1;
  self.var_86fdc107.alpha = 0;
  self.var_86fdc107.glowalpha = 0.5;
  self.var_86fdc107.hidewheninmenu = 0;
}

function function_7a923efa(var_8847a584, attacker) {
  if(isDefined(var_8847a584)) {
    if(!isDefined(var_8847a584.var_86fdc107)) {
      var_8847a584 function_de01cce2();
    }
    var_8847a584 function_8e6b5244();
  }
  if(isDefined(attacker)) {
    if(!isDefined(attacker.var_86fdc107)) {
      attacker function_de01cce2();
    }
    attacker function_8e6b5244();
  }
}

function function_a40d8853() {
  if(level.phsettings.var_78280ce0) {
    thread function_7a923efa(self.playerowner, self.lastattacker);
    if(isDefined(self.playerowner)) {
      self.playerowner propsetclonesleft(self.playerowner.clonesleft + 1);
    }
  } else if(isDefined(self.lastattacker)) {
    scoreevents::processscoreevent("clone_destroyed", self.lastattacker);
    if(isDefined(self.playerowner)) {
      scoreevents::processscoreevent("clone_was_destroyed", self.playerowner);
    }
  }
  if(!isDefined(self.isdying)) {
    self.isdying = 1;
  }
  playsoundatposition("wpn_flash_grenade_explode", self.origin + vectorscale((0, 0, 1), 4));
  playFX(fx::get("propDeathFX"), self.origin + vectorscale((0, 0, 1), 4));
  if(isDefined(self)) {
    self delete();
  }
}

function function_7244ebc6(var_ad5f9a75, fade_in_time, fade_out_time) {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(var_ad5f9a75)) {
    var_ad5f9a75 = 5;
  }
  if(!isDefined(fade_in_time)) {
    fade_in_time = 1;
  }
  if(!isDefined(fade_out_time)) {
    fade_out_time = 1;
  }
  assert((fade_out_time + fade_in_time) < var_ad5f9a75);
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
  wait(0.05);
  if(fade_in_time > 0) {
    overlay fadeovertime(fade_in_time);
  }
  overlay.alpha = 1;
  self setclientuivisibilityflag("hud_visible", 0);
  self prop::function_da184fd(fade_in_time);
  self useservervisionset(1);
  self setvisionsetforplayer("blackout_ph", fade_in_time);
  self prop::function_da184fd((var_ad5f9a75 - fade_out_time) - fade_in_time);
  if(fade_out_time > 0) {
    overlay fadeovertime(fade_out_time);
  }
  overlay.alpha = 0;
  self useservervisionset(0);
  self setvisionsetforplayer("blackout_ph", fade_out_time);
  self prop::function_da184fd(fade_out_time);
  self setclientuivisibilityflag("hud_visible", 1);
  wait(0.05);
  safedestroy(overlay);
}

function watchspecialgrenadethrow() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("watchspecialgrenadethrow");
  self endon("watchspecialgrenadethrow");
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    self thread function_899a39ec(grenade);
    self.thrownspecialcount = self.thrownspecialcount + 1;
  }
}

function function_899a39ec(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  weapon = grenade.weapon;
  grenade waittill("explode", damageorigin);
  if(!isDefined(level.var_56d3e86e)) {
    level.var_56d3e86e = [];
  }
  index = function_913d23(damageorigin);
  if(!isDefined(index)) {
    index = function_141daf3d(self, damageorigin, weapon, 1, "MOD_GRENADE_SPLASH");
  }
  wait(0.05);
  wait(0.05);
  self function_af4e8351(index);
  wait(0.05);
  level.var_56d3e86e[index] = undefined;
}

function function_141daf3d(attacker, damageorigin, weapon, damage, meansofdeath) {
  index = level.var_56d3e86e.size;
  level.var_56d3e86e[index] = spawnStruct();
  level.var_56d3e86e[index].players = [];
  level.var_56d3e86e[index].attacker = self;
  level.var_56d3e86e[index].damageorigin = damageorigin;
  level.var_56d3e86e[index].damage = damage;
  level.var_56d3e86e[index].meansofdeath = meansofdeath;
  level.var_56d3e86e[index].weapon = weapon;
  return index;
}

function function_770b4cfa(attacker, var_bf500123, meansofdeath, damage, damageorigin, weapon) {
  if(!isDefined(level.var_56d3e86e)) {
    level.var_56d3e86e = [];
  }
  index = function_913d23(damageorigin);
  if(!isDefined(index)) {
    index = function_141daf3d(attacker, damageorigin, weapon, damage, meansofdeath);
  }
  if(isDefined(var_bf500123)) {
    playerindex = level.var_56d3e86e[index].players.size;
    level.var_56d3e86e[index].players[playerindex] = var_bf500123;
  }
}

function function_913d23(damageorigin) {
  if(!isDefined(level.var_56d3e86e)) {
    return;
  }
  foreach(index, event in level.var_56d3e86e) {
    if(event.damageorigin == damageorigin) {
      return index;
    }
  }
}

function function_af4e8351(index) {
  if(!isDefined(level.var_56d3e86e) || !isDefined(level.var_56d3e86e[index].attacker)) {
    return;
  }
  weapon = level.var_56d3e86e[index].weapon;
  damageorigin = level.var_56d3e86e[index].damageorigin;
  var_cb673c8c = weapon.explosionradius;
  var_6a573904 = var_cb673c8c * var_cb673c8c;
  foreach(player in level.players) {
    if(!player util::isprop() || !isalive(player) || player function_fde936b5(index)) {
      continue;
    }
    distsq = distancesquared(damageorigin, player.origin);
    if(distsq <= var_6a573904) {
      function_73052bdb(0);
      function_564fbbef(0);
      function_b7d2b256(1);
      function_56938929(0);
      damage = level.var_56d3e86e[index].damage;
      attacker = level.var_56d3e86e[index].attacker;
      meansofdeath = level.var_56d3e86e[index].meansofdeath;
      attacker radiusdamage(damageorigin, var_cb673c8c, damage, damage, attacker, meansofdeath, weapon);
      function_73052bdb(1);
      function_564fbbef(1);
      function_b7d2b256(0);
      function_56938929(1);
      break;
    }
  }
}

function function_73052bdb(var_d18ea86a) {
  foreach(player in level.players) {
    if(isDefined(player.prop)) {
      if(var_d18ea86a) {
        if(isDefined(player.prop.var_42c57e68)) {
          player.prop setcontents(player.prop.var_42c57e68);
        }
        player.prop solid();
        continue;
      }
      if(!isDefined(player.prop.var_42c57e68)) {
        player.prop.var_42c57e68 = player.prop setcontents(0);
      } else {
        player.prop setcontents(0);
      }
      player.prop notsolid();
    }
  }
}

function function_564fbbef(var_d18ea86a) {
  foreach(player in level.players) {
    if(isDefined(player.propclones)) {
      foreach(clone in player.propclones) {
        if(isDefined(clone)) {
          if(var_d18ea86a) {
            if(isDefined(clone.var_edad31da)) {
              clone setcontents(clone.var_edad31da);
            }
            clone solid();
            continue;
          }
          if(!isDefined(clone.var_edad31da)) {
            clone.var_edad31da = clone setcontents(0);
          } else {
            clone setcontents(0);
          }
          clone notsolid();
        }
      }
    }
  }
}

function function_b7d2b256(var_d18ea86a) {
  foreach(player in level.players) {
    if(!player util::isprop() || !isalive(player)) {
      continue;
    }
    if(var_d18ea86a) {
      player setcontents(level.phsettings.var_8f9d0c7c);
      player solid();
      continue;
    }
    player setcontents(0);
    player notsolid();
  }
}

function function_56938929(var_d18ea86a) {
  foreach(player in level.players) {
    if(!player prop::function_e4b2f23() || !isalive(player)) {
      continue;
    }
    if(var_d18ea86a) {
      player setcontents(level.phsettings.var_8f9d0c7c);
      player solid();
      continue;
    }
    player setcontents(0);
    player notsolid();
  }
}

function function_94e1618c(damageorigin) {
  index = function_913d23(damageorigin);
  if(isDefined(index)) {
    return self function_fde936b5(index);
  }
  return 0;
}

function function_fde936b5(index) {
  foreach(var_f07e80d9 in level.var_56d3e86e[index].players) {
    if(isDefined(var_f07e80d9) && var_f07e80d9 == self) {
      return true;
    }
  }
  return false;
}

function safesetalpha(hudelem, var_9a1ea53a) {
  if(isDefined(hudelem)) {
    hudelem.alpha = var_9a1ea53a;
  }
}

function propabilitykeysvisible(visible, override) {
  if(isDefined(visible) && visible) {
    var_4d23023a = 1;
  } else {
    var_4d23023a = 0;
  }
  if(prop::useprophudserver() || (isDefined(override) && override)) {
    safesetalpha(self.changepropkey, var_4d23023a);
    safesetalpha(self.spinpropkey, var_4d23023a);
    safesetalpha(self.lockpropkey, var_4d23023a);
    safesetalpha(self.matchslopekey, var_4d23023a);
    safesetalpha(self.abilitykey, var_4d23023a);
    safesetalpha(self.clonekey, var_4d23023a);
    safesetalpha(self.zoomkey, var_4d23023a);
    safesetalpha(self.var_6f16621b, var_4d23023a);
    if(!(isDefined(level.nopropsspectate) && level.nopropsspectate)) {
      safesetalpha(self.spectatekey, var_4d23023a);
    }
  }
}

function function_8b7be7e3() {
  if(!isDefined(self.var_4a35819e)) {
    self.var_4a35819e = 1;
  } else {
    self.var_4a35819e = !self.var_4a35819e;
  }
  if(self.var_4a35819e) {
    self.prop clientfield::set("retrievable", 1);
    if(prop::useprophudserver()) {
      self.var_6f16621b.label = &"MP_PH_SHOWPROP";
    }
  } else {
    self.prop clientfield::set("retrievable", 0);
    if(prop::useprophudserver()) {
      self.var_6f16621b.label = &"MP_PH_HIDEPROP";
    }
  }
}

function function_bf45ce54() {
  assert(!isDefined(self.var_b47d9b7e));
  if(self issplitscreen()) {
    self.currenthudy = -50;
  } else {
    self.currenthudy = -100;
  }
  self.var_b47d9b7e = addupperrighthudelem(&"MP_PH_PING");
}

function function_227409a5() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  self thread function_b4c19c50();
  self thread function_7fd4f3ae();
}

function function_7fd4f3ae() {
  safedestroy(self.var_b47d9b7e);
}

function function_b6740059() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("ping", "+smoke");
}

function function_b4c19c50() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommandremove("ping", "+smoke");
}

function function_5951cacf() {
  if(isDefined(self.var_74ca9cd1) && self.var_74ca9cd1) {
    return 1;
  }
  return self.var_292246d3 > 0;
}

function function_2c53f5e6() {
  if(isDefined(self.var_74ca9cd1) && self.var_74ca9cd1) {
    return;
  }
  function_afeda2bf(self.var_292246d3 - 1);
}

function function_afeda2bf(newvalue) {
  self.var_292246d3 = newvalue;
  if(prop::useprophudserver()) {
    self.var_b47d9b7e setvalue(self.var_292246d3);
    if(self.var_292246d3 <= 0) {
      self.var_b47d9b7e.alpha = 0.5;
    }
  }
}

function function_1abcc66() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isai(self)) {
    return;
  }
  prop::function_45c842e9();
  while(true) {
    msg = self util::waittill_any_return("ping");
    if(!isDefined(msg)) {
      continue;
    }
    if(msg == "ping") {
      self function_38543493();
    }
  }
}

function function_38543493() {
  if(!level flag::get("props_hide_over")) {
    return;
  }
  if(isDefined(self.var_ad7b9a66) && self.var_ad7b9a66) {
    return;
  }
  if(self function_5951cacf()) {
    self thread function_aac4667c();
    self function_2c53f5e6();
  }
}

function function_aac4667c() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self.var_ad7b9a66 = 1;
  if(prop::useprophudserver()) {
    self.var_b47d9b7e.alpha = 0.5;
  }
  var_6f71e4e9 = gameobjects::get_next_obj_id();
  objective_add(var_6f71e4e9, "active");
  objective_team(var_6f71e4e9, game["attackers"]);
  objective_position(var_6f71e4e9, self.origin);
  objective_icon(var_6f71e4e9, "t7_hud_waypoints_safeguard_location");
  objective_setcolor(var_6f71e4e9, &"FriendlyBlue");
  objective_onentity(var_6f71e4e9, self);
  self thread function_41584b4b(var_6f71e4e9);
  self clientfield::set("pingHighlight", 1);
  foreach(player in level.players) {
    if(isalive(player) && player.team == self.team) {
      player playlocalsound("evt_hacker_raise");
    }
  }
  hostmigration::waitlongdurationwithhostmigrationpause(4);
  self clientfield::set("pingHighlight", 0);
  gameobjects::release_obj_id(var_6f71e4e9);
  if(prop::useprophudserver() && isDefined(self.var_b47d9b7e)) {
    self.var_b47d9b7e.alpha = 1;
  }
  self.var_ad7b9a66 = 0;
  self notify("hash_9c5a8370");
}

function function_41584b4b(var_6f71e4e9) {
  level endon("game_ended");
  self endon("hash_9c5a8370");
  self util::waittill_either("disconnect", "death");
  gameobjects::release_obj_id(var_6f71e4e9);
}