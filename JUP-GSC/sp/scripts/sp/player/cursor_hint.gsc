/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\player\cursor_hint.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace cursor_hint;

function init_cursor_hint() {
  setdvarifuninitialized(@ "hash_7925a1f90294e6e8", 0);
  precacheshader("cursor_hint_circle");
  precacheshader("cursor_hint_x");
  precacheshader("cursor_hint_square");
  precacheshader("alien_dpad_none");
  precacheshader("hud_arrow_up");
  precacheshader("hud_interaction_prompt_center_ammo");
  precacheshader("hud_scrap_medium_icon_test");
  precacheshader("hud_interaction_prompt_center_heavy");
  precacheshader("hud_interaction_prompt_center_steel_dragon");
  level.cursor_hints = [];
  level.cursor_hints_max = 1;
}

function function_31a9edf082d398f5(bundlename, hintstring, linktag, offsetorigin) {
  bundle = getscriptbundle("cursorhint:" + bundlename);
  return function_5c79b14fd1f528b0(bundle, hintstring, linktag, offsetorigin);
}

function function_5c79b14fd1f528b0(parms, hintstring, linktag, offsetorigin) {
  if(!isDefined(parms)) {
    parms = spawnStruct();

    iprintln("<dev string:x1c>");
  }

  if(!isDefined(hintstring)) {
    hintstring = parms.hintstring;
  }

  if(!isDefined(linktag)) {
    linktag = parms.linktag;
  }

  if(!isDefined(offsetorigin)) {
    offsetorigin = parms.offsetorigin;

    if(isstruct(offsetorigin)) {
      offsetorigin = (default_to(offsetorigin.x, 0), default_to(offsetorigin.y, 0), default_to(offsetorigin.z, 0));
    }
  }

  return create_cursor_hint(linktag, offsetorigin, hintstring, parms.var_df024a1642f13910, parms.var_1d15541035909a45, parms.var_2312d6385ae695a8, parms.ignoretrace, parms.blinkhint, parms.var_9e9b6d24b7a157f0, parms.uniqueicon, parms.holdduration, parms.usecommand, parms.lockmovement, parms.var_40d4d7a8ad6420e3, parms.var_7cff52334740fd08, parms.var_429e3ca51e37df3c);
}

function create_cursor_hint(linktag, originoffset, hintstring, var_df024a1642f13910, var_1d15541035909a45, var_2312d6385ae695a8, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, var_40d4d7a8ad6420e3, var_7cff52334740fd08, var_429e3ca51e37df3c) {
  hintent = self;

  if(isstruct(hintent) || is_equal(hintent.code_classname, "script_origin") || isDefined(originoffset)) {
    hintent = spawn("script_origin", self.origin);
    self.cursor_hint_ent = hintent;
  }

  hintent makeusable();

  if(isDefined(originoffset)) {
    tag = "tag_origin";

    if(isDefined(linktag)) {
      tag = linktag;
      hintent.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "script_model" && self tagexists(tag)) {
      hintent linkTo(self, tag, originoffset, (0, 0, 0));
    } else if(isDefined(linktag)) {
      hintent linkTo(self, tag, originoffset, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      hintent.origin += rotatevector(originoffset, self.angles);

      if(isent(self)) {
        hintent linkTo(self);
      }
    } else {
      hintent.origin += originoffset;

      if(isent(self)) {
        hintent linkTo(self);
      }
    }
  } else if(isDefined(linktag)) {
    hintent sethinttag(linktag);
  }

  if(isDefined(var_9e9b6d24b7a157f0) && var_9e9b6d24b7a157f0) {
    hintent setCursorHint("HINT_NOICON");
  } else {
    hintent setCursorHint("HINT_BUTTON");
  }

  if(isDefined(hintstring) && !in_realism_mode()) {
    hintent setHintString(hintstring);
  }

  displayfov = 360;

  if(isDefined(var_df024a1642f13910)) {
    displayfov = var_df024a1642f13910;
  }

  hintent sethintdisplayfov(displayfov);
  usefov = 65;

  if(isDefined(var_40d4d7a8ad6420e3)) {
    usefov = var_40d4d7a8ad6420e3;
  }

  hintent setusefov(usefov);
  displayrange = 500;

  if(isDefined(var_1d15541035909a45)) {
    displayrange = var_1d15541035909a45;
  }

  hintent sethintdisplayrange(displayrange);
  userange = 80;

  if(isDefined(var_2312d6385ae695a8)) {
    userange = var_2312d6385ae695a8;
  }

  hintent setuserange(userange);

  if(isDefined(ignoretrace) && ignoretrace) {
    hintent sethintonobstruction("show");
  } else {
    hintent sethintonobstruction("hide");
  }

  if(isDefined(blinkhint) && blinkhint) {
    hintent sethintrequiresmashing(blinkhint);
  }

  if(!isDefined(holdduration)) {
    holdduration = "duration_short";
  }

  hintent setuseholdduration(holdduration);

  if(holdduration != "duration_none" && holdduration != "duration_short") {
    hintent sethintrequiresholding(1);
  }

  if(!istrue(self.var_2962af1b05702467)) {
    thread hint_delete_on_trigger();
  }

  if(isDefined(uniqueicon)) {
    hintent sethinticon(uniqueicon);
  }

  if(isDefined(usecommand)) {
    hintent setusecommand(usecommand);
  }

  hintent sethintlockplayermovement(istrue(lockmovement));
  hintent setusewhenhandsoccupied(istrue(var_429e3ca51e37df3c));

  if(isDefined(var_7cff52334740fd08)) {
    thread internal_hint_toggle_use_by_angles(hintent, var_7cff52334740fd08, userange);
  }
}

function create_cursor_hint_forced(linktag, originoffset, hintstring, var_df024a1642f13910, var_1d15541035909a45, var_2312d6385ae695a8, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, var_40d4d7a8ad6420e3, var_7cff52334740fd08) {
  hintent = self;

  if(isstruct(hintent) || hintent.code_classname == "script_origin" || isDefined(originoffset)) {
    hintent = spawn("script_origin", self.origin);
    self.cursor_hint_ent = hintent;
  }

  hintent makeusable();

  if(isDefined(originoffset)) {
    tag = "tag_origin";

    if(isDefined(linktag)) {
      tag = linktag;
      hintent.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "script_model" && hastag(self.model, tag)) {
      hintent linkTo(self, tag, originoffset, (0, 0, 0));
    } else if(isDefined(linktag)) {
      hintent linkTo(self, tag, originoffset, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      hintent.origin += rotatevector(originoffset, self.angles);

      if(isent(self)) {
        hintent linkTo(self);
      }
    } else {
      hintent.origin += originoffset;

      if(isent(self)) {
        hintent linkTo(self);
      }
    }
  } else if(isDefined(linktag)) {
    hintent sethinttag(linktag);
  }

  if(isDefined(var_9e9b6d24b7a157f0) && var_9e9b6d24b7a157f0) {
    hintent setCursorHint("HINT_NOICON");
  } else {
    hintent setCursorHint("HINT_BUTTON");
  }

  if(isDefined(hintstring)) {
    hintent setHintString(hintstring);
  }

  displayfov = 360;

  if(isDefined(var_df024a1642f13910)) {
    displayfov = var_df024a1642f13910;
  }

  hintent sethintdisplayfov(displayfov);
  usefov = 65;

  if(isDefined(var_40d4d7a8ad6420e3)) {
    usefov = var_40d4d7a8ad6420e3;
  }

  hintent setusefov(usefov);
  displayrange = 500;

  if(isDefined(var_1d15541035909a45)) {
    displayrange = var_1d15541035909a45;
  }

  hintent sethintdisplayrange(displayrange);
  userange = 80;

  if(isDefined(var_2312d6385ae695a8)) {
    userange = var_2312d6385ae695a8;
  }

  hintent setuserange(userange);

  if(isDefined(ignoretrace) && ignoretrace) {
    hintent sethintonobstruction("show");
  } else {
    hintent sethintonobstruction("hide");
  }

  if(isDefined(blinkhint) && blinkhint) {
    hintent sethintrequiresmashing(blinkhint);
  }

  if(!isDefined(holdduration)) {
    holdduration = "duration_short";
  }

  hintent setuseholdduration(holdduration);

  if(holdduration != "duration_none" && holdduration != "duration_short") {
    hintent sethintrequiresholding(1);
  }

  thread hint_delete_on_trigger();

  if(isDefined(uniqueicon)) {
    hintent sethinticon(uniqueicon);
  }

  if(isDefined(usecommand)) {
    hintent setusecommand(usecommand);
  }

  if(isDefined(lockmovement)) {
    hintent sethintlockplayermovement(1);
  } else {
    hintent sethintlockplayermovement(0);
  }

  if(isDefined(var_7cff52334740fd08)) {
    thread internal_hint_toggle_use_by_angles(hintent, var_7cff52334740fd08, userange);
  }
}

function function_fa06de21f8aaee3b(anime, scriptednode, linktag, originoffset, hintstring, var_df024a1642f13910, var_1d15541035909a45, var_4e6ef8fe3c3a2fbb, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, var_40d4d7a8ad6420e3, var_94370a44392f701b) {
  if(!isDefined(var_4e6ef8fe3c3a2fbb)) {
    var_4e6ef8fe3c3a2fbb = 0;
  }

  if(!isDefined(var_94370a44392f701b)) {
    var_94370a44392f701b = 0;
  }

  if(!isDefined(var_40d4d7a8ad6420e3)) {
    var_40d4d7a8ad6420e3 = 45;
  }

  rig = spawn_anim_model("player_rig", self.origin, self.angles);
  rig hide();
  startpositions = scriptednode function_6d41ac1c3d718a62(anime, rig);

  hintfloor = self.origin;

  foreach(position in startpositions) {
    if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
      if(isDefined(linktag)) {
        hintfloor = utility::groundpos(self gettagorigin(linktag));
      }

      line(hintfloor, position, (1, 1, 1), 1, 0, 1000);
    }
  }

  lastdiff = 0;
  furthestpositions = [];
  var_d85cc836998c34dd = [];

  foreach(i, startposition in startpositions) {
    var_d85cc836998c34dd[var_d85cc836998c34dd.size] = distance2d(self.origin, startposition);

    if(i + 1 == startpositions.size) {
      startdiff = distance2d(startposition, startpositions[0]);

      if(startdiff > lastdiff) {
        lastdiff = startdiff;
        furthestpositions[1] = startpositions[i];
        furthestpositions[0] = startpositions[0];
      }

      continue;
    }

    startdiff = distance2d(startposition, startpositions[i + 1]);

    if(startdiff > lastdiff) {
      lastdiff = startdiff;
      furthestpositions[0] = startpositions[i];
      furthestpositions[1] = startpositions[i + 1];
    }
  }

  distave = array_average(var_d85cc836998c34dd);
  var_3a1cff486b7956dc = 60 + distave + var_4e6ef8fe3c3a2fbb;

  if(startpositions.size > 1) {
    var_11257a1ff69c8cf6 = 30;
    sharedpoint = self.origin;

    if(isDefined(linktag)) {
      sharedpoint = self gettagorigin(linktag);
    }

    angle = math::anglebetweenvectors(sharedpoint - furthestpositions[0], sharedpoint - furthestpositions[1]);
  } else {
    var_11257a1ff69c8cf6 = 65;
    angle = 0;
  }

  var_b22fa04e81595347 = var_11257a1ff69c8cf6 + angle + var_94370a44392f701b;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x53>" + distave);
    iprintln("<dev string:x66>" + var_3a1cff486b7956dc);
    iprintln("<dev string:x73>" + angle);
    iprintln("<dev string:x89>" + var_b22fa04e81595347);
  }

  rig delete();
  create_cursor_hint(linktag, originoffset, hintstring, var_df024a1642f13910, var_1d15541035909a45, var_3a1cff486b7956dc, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, var_40d4d7a8ad6420e3, var_b22fa04e81595347);
}

function private internal_hint_toggle_use_by_angles(hintent, useangles, userange) {
  assert(isDefined(self.angles), "Trying to limit use angles for cursor hint on an ent without .angles");
  self endon("death");
  self endon("hint_destroyed");
  level.player endon("death");
  could_use = 1;
  desired_dot = cos(useangles);

  setdvarifuninitialized(@ "hash_7925a1f90294e6e8", 0);

  while(true) {
    origin = self.origin;
    angles = self.angles;
    fwd = anglesToForward(angles);
    nml = vectorNormalize(level.player getEye() - origin);
    dot = vectordot(fwd, nml);
    can_use = dot >= desired_dot;

    if(can_use != could_use) {
      if(can_use) {
        hintent setuserange(userange);
      } else {
        hintent setuserange(1);
      }

      could_use = can_use;
    }

    if(getdvarint(@ "hash_7925a1f90294e6e8")) {
      thread draw_line_for_time(origin, origin + fwd * 100, 1, 1, 0, 0.05);
      thread draw_line_for_time(origin, origin + nml * 100, ter_op(can_use, 0, 1), ter_op(can_use, 1, 0), 0, 0.05);
      print3d(origin, acos(dot));
    }

    waitframe();
  }
}

function function_29589fff42be0668(linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842) {
  thread function_c5ecfe572bd65fd0(linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842);
}

function private function_c5ecfe572bd65fd0(linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842) {
  thread create_cursor_hint(linktag, originoffset, hintstring);
  triggered = function_4d0a70b3e87a01cd();

  if(!istrue(triggered)) {
    return;
  }

  thread function_1202cd03e8123816(hintstringheld, duration, var_4a4268457b600842);
}

function private function_1202cd03e8123816(hintstringheld, duration, var_4a4268457b600842) {
  waittillframeend();

  if(isDefined(var_4a4268457b600842)) {
    showhint = function_b8de3859f8626aaa(var_4a4268457b600842);

    if(!istrue(showhint)) {
      return;
    }
  }

  function_cbb6e098f3e2d086(duration);
}

function private function_b8de3859f8626aaa(var_4a4268457b600842) {
  self endon("hint_destroyed");
  self waittill(var_4a4268457b600842);
  return true;
}

function private function_cbb6e098f3e2d086(duration) {
  self endon("hint_destroyed");
  self.holding = undefined;
  counter = 0;
  holdcounter = 15;

  while(true) {
    washolding = istrue(self.holding);

    if(level.player useButtonPressed()) {
      counter += 1;
    } else {
      counter = 0;
    }

    if(isDefined(duration) && counter >= duration * 20 + holdcounter) {
      break;
    }

    if(counter >= holdcounter) {
      self.holding = 1;
      level.player playRumbleOnEntity("light_1s");
    } else {
      self.holding = undefined;
    }

    if(istrue(self.holding) && !washolding) {
      self notify("hold_start");
    } else if(!istrue(self.holding) && washolding) {
      self notify("hold_stop");
    }

    waitframe();
  }

  self notify("hold_complete");
}

function hint_delete_on_trigger() {
  self endon("hint_destroyed");
  hintent = self;

  if(isDefined(self.cursor_hint_ent)) {
    hintent = self.cursor_hint_ent;
  }

  function_7ac69d749cd3da7a(hintent);

  if(isDefined(self)) {
    remove_cursor_hint();
  }
}

function function_7ac69d749cd3da7a(hintent) {
  self endon("entitydeleted");
  hintent waittill("trigger", other);

  if(hintent != self) {
    self notify("trigger", other);
  }
}

function remove_cursor_hint() {
  hintent = self;

  if(isDefined(self.cursor_hint_ent)) {
    hintent = self.cursor_hint_ent;
    hintent delete();
    self notify("hint_destroyed");
    return;
  }

  if(!isstruct(hintent)) {
    hintent makeunusable();
  }

  self notify("hint_destroyed");
}

function hint_waittill_trigger() {
  triggerent = monitor_interact_delay(self, "stand");
  return triggerent;
}

function function_4d0a70b3e87a01cd() {
  self endon("hint_destroyed");

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent waittill("trigger");
  } else {
    self waittill("trigger");
  }

  return true;
}