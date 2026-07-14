/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\cursor_hint.gsc
*********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace cursor_hint;

function init_cursor_hint() {
  setdvarifuninitialized(@ "hash_7925a1f90294e6e8", 0);
  precacheshader("{\xee\xd1\xc1\x14\xa6\x85 Q\xa9t\x91\x04\n\xc8\xef\xf3\xae");
  precacheshader("!\x13\"\xc8\xe0{\x1f\xb9\xa3\xc3\xc3 X");
  precacheshader("\x9e\xbf4\f\x91g\xc0\x03\x90u\x1cGP9\xaa=/\x95");
  precacheshader("\x01\x7f\xfb\xad[\xc1\xe0 \xaa\xdc\xf1[\xe5\xc27");
  precacheshader("r\xef\x8b\x8f\xd8]m\xe1\x83\x1c\x14k");
  precacheshader("4\xea2\xbe\xd27\xa3\xac\x93\x85c\x8eZ\xde7_p\xc9\xed\xb6\xe0t\xebcY\x9bGY\x93}\xc2[\xd6\xdb");
  precacheshader("\x8c~\x8d3\x9a\x97\xee15\"\x02\x9f\xf6\xef>\xc9Ey\xad6]\x8e\xefp6k");
  precacheshader("\x90afS\x953\x9e\xc0!>{\xabd\x18v\x935\x9c\xd7\x8a\xf8\xbd\xc1u\xe9Y\xef\xbeP|\x19\x8d\xca\xc7$");
  precacheshader(")\xd96\xc0\n8\xd5V9\x1c\x8e\xf8\xb7\x9f\xebMd\xfa\xcb\x91\xe9\xcd\x85\x94\xdd\x1do\xa7\x97\xdf\xf6\x15\xf1\xf6\xe7\xa57\x80\xf6;WZ");
  level.cursor_hints = [];
  level.cursor_hints_max = 1;
  utility::registersharedfunc(#"cursor_hint", #"create", &create_cursor_hint);
  utility::registersharedfunc(#"cursor_hint", #"remove", &remove_cursor_hint);
}

function function_c63b4e299f9d1e4(bundlename, hintstring, linktag, offsetorigin, index, var_7818a8fa0045753) {
  bundle = getscriptbundle("\xd8\xea'n\xb7\xe4hi\x9b\x1d:" + bundlename);
  return function_2b9474820aa9d4a1(bundle, hintstring, linktag, offsetorigin, index, var_7818a8fa0045753);
}

function function_2b9474820aa9d4a1(parms, hintstring, linktag, offsetorigin, index, var_7818a8fa0045753) {
  if(!isDefined(parms)) {
    parms = spawnStruct();

    iprintln("<dev string:x24>");
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
      offsetorigin = (offsetorigin.x ?? 0, offsetorigin.y ?? 0, offsetorigin.z ?? 0);
    }
  }

  if(istrue(var_7818a8fa0045753) && offsetorigin === (0, 0, 0)) {
    offsetorigin = undefined;
  }

  if(isDefined(self.displayfovoverride)) {
    parms.displayfovoverride = self.displayfovoverride;
  }

  if(isDefined(self.displaydistoverride)) {
    parms.displaydistoverride = self.displaydistoverride;
  }

  if(isDefined(self.usedistoverride)) {
    parms.usedistoverride = self.usedistoverride;
  }

  return create_cursor_hint(linktag, offsetorigin, hintstring, parms.displayfovoverride, parms.displaydistoverride, parms.usedistoverride, parms.ignoretrace, parms.blinkhint, parms.var_143c3d64dc2e6cd5, parms.uniqueicon, parms.holdduration, parms.usecommand, parms.lockmovement, parms.usefovoverride, parms.useanglesoverride, parms.whileencumbered, index);
}

function create_cursor_hint(linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistoverride, ignoretrace, blinkhint, var_143c3d64dc2e6cd5, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesoverride, whileencumbered, lootindex) {
  hintent = self;
  hintent.cursorhintstring = hintstring;

  if(isstruct(hintent) || hintent.code_classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc" || isDefined(originoffset)) {
    hintent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    self.cursor_hint_ent = hintent;
  }

  hintent makeusable();

  if(isDefined(originoffset)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";

    if(isDefined(linktag)) {
      tag = linktag;
      hintent.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6" && self tagexists(tag)) {
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

  if(isDefined(var_143c3d64dc2e6cd5) && var_143c3d64dc2e6cd5) {
    hintent setCursorHint("\xda\xc1Tx]8\xc1y1\x1fe");
  } else if(isDefined(self.hinttypeoverride)) {
    hintent setCursorHint(self.hinttypeoverride);
  } else {
    hintent setCursorHint("\xb2\xd3\xaffR\xcf\xddI1\xc0o");
  }

  if(isDefined(hintstring) && !utility_sp::in_realism_mode()) {
    hintent setHintString(hintstring);
  }

  displayfov = 360;

  if(isDefined(displayfovoverride)) {
    displayfov = displayfovoverride;
  }

  hintent sethintdisplayfov(displayfov);
  usefov = 65;

  if(isDefined(usefovoverride)) {
    usefov = usefovoverride;
  }

  hintent setusefov(usefov);
  displayrange = 500;

  if(isDefined(displaydistoverride)) {
    displayrange = displaydistoverride;
  }

  hintent sethintdisplayrange(displayrange);
  userange = 80;

  if(isDefined(usedistoverride)) {
    userange = usedistoverride;
  }

  hintent setuserange(userange);

  if(isDefined(ignoretrace) && ignoretrace) {
    hintent sethintonobstruction("\xf1\xba\x8f\x9d");
  } else {
    hintent sethintonobstruction("\x19b\xc2y");
  }

  if(isDefined(blinkhint) && blinkhint) {
    hintent sethintrequiresmashing(blinkhint);
  }

  if(!isDefined(holdduration)) {
    holdduration = "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96";
  }

  hintent setuseholdduration(holdduration);

  if(holdduration != "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a" && holdduration != "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96") {
    hintent sethintrequiresholding(1);
  }

  if(!istrue(self.var_e703a981d06a1192)) {
    thread hint_delete_on_trigger();
  }

  hintent function_525dce275d69452d(lootindex);

  if(isDefined(uniqueicon)) {
    hintent sethinticon(uniqueicon);
  }

  if(isDefined(usecommand)) {
    hintent setusecommand(usecommand);
  }

  hintent sethintlockplayermovement(istrue(lockmovement));
  hintent setusewhenhandsoccupied(istrue(whileencumbered));

  if(isDefined(useanglesoverride)) {
    thread internal_hint_toggle_use_by_angles(hintent, useanglesoverride, userange);
  }
}

function create_cursor_hint_forced(linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistoverride, ignoretrace, blinkhint, var_143c3d64dc2e6cd5, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesoverride) {
  hintent = self;

  if(isstruct(hintent) || hintent.code_classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc" || isDefined(originoffset)) {
    hintent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    self.cursor_hint_ent = hintent;
  }

  hintent makeusable();

  if(isDefined(originoffset)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";

    if(isDefined(linktag)) {
      tag = linktag;
      hintent.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6" && utility::hastag(self.model, tag)) {
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

  if(isDefined(var_143c3d64dc2e6cd5) && var_143c3d64dc2e6cd5) {
    hintent setCursorHint("\xda\xc1Tx]8\xc1y1\x1fe");
  } else {
    hintent setCursorHint("\xb2\xd3\xaffR\xcf\xddI1\xc0o");
  }

  if(isDefined(hintstring)) {
    hintent setHintString(hintstring);
  }

  displayfov = 360;

  if(isDefined(displayfovoverride)) {
    displayfov = displayfovoverride;
  }

  hintent sethintdisplayfov(displayfov);
  usefov = 65;

  if(isDefined(usefovoverride)) {
    usefov = usefovoverride;
  }

  hintent setusefov(usefov);
  displayrange = 500;

  if(isDefined(displaydistoverride)) {
    displayrange = displaydistoverride;
  }

  hintent sethintdisplayrange(displayrange);
  userange = 80;

  if(isDefined(usedistoverride)) {
    userange = usedistoverride;
  }

  hintent setuserange(userange);

  if(isDefined(ignoretrace) && ignoretrace) {
    hintent sethintonobstruction("\xf1\xba\x8f\x9d");
  } else {
    hintent sethintonobstruction("\x19b\xc2y");
  }

  if(isDefined(blinkhint) && blinkhint) {
    hintent sethintrequiresmashing(blinkhint);
  }

  if(!isDefined(holdduration)) {
    holdduration = "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96";
  }

  hintent setuseholdduration(holdduration);

  if(holdduration != "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a" && holdduration != "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96") {
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

  if(isDefined(useanglesoverride)) {
    thread internal_hint_toggle_use_by_angles(hintent, useanglesoverride, userange);
  }
}

function function_a876fc8165d204e6(anime, scriptednode, linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistadjustment, ignoretrace, blinkhint, var_143c3d64dc2e6cd5, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesadjustment) {
  if(!isDefined(usedistadjustment)) {
    usedistadjustment = 0;
  }

  if(!isDefined(useanglesadjustment)) {
    useanglesadjustment = 0;
  }

  if(!isDefined(usefovoverride)) {
    usefovoverride = 45;
  }

  rig = utility_sp::spawn_anim_model("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce", self.origin, self.angles);
  rig hide();
  startpositions = scriptednode utility::getanim_starts(anime, rig);

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
  var_f11e88aa9989fbf8 = [];

  foreach(i, startposition in startpositions) {
    var_f11e88aa9989fbf8[var_f11e88aa9989fbf8.size] = distance2d(self.origin, startposition);

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

  distave = utility::array_average(var_f11e88aa9989fbf8);
  newusedist = 60 + distave + usedistadjustment;

  if(startpositions.size > 1) {
    var_8d8f8eb4647f4f87 = 30;
    sharedpoint = self.origin;

    if(isDefined(linktag)) {
      sharedpoint = self gettagorigin(linktag);
    }

    angle = math::anglebetweenvectors(sharedpoint - furthestpositions[0], sharedpoint - furthestpositions[1]);
  } else {
    var_8d8f8eb4647f4f87 = 65;
    angle = 0;
  }

  var_1da87794e14351fa = var_8d8f8eb4647f4f87 + angle + useanglesadjustment;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x5e>" + distave);
    iprintln("<dev string:x74>" + newusedist);
    iprintln("<dev string:x84>" + angle);
    iprintln("<dev string:x9d>" + var_1da87794e14351fa);
  }

  rig delete();
  create_cursor_hint(linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, newusedist, ignoretrace, blinkhint, var_143c3d64dc2e6cd5, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, var_1da87794e14351fa);
}

function private internal_hint_toggle_use_by_angles(hintent, useangles, userange) {
  assert(isDefined(self.angles), "<dev string:xae>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  hint_ent = self.cursor_hint_ent ?? self;

  if(hint_ent != self) {
    hint_ent endon("\x1e\xfd\xd1\xa2\a", "\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  }

  could_use = 1;
  desired_dot = cos(useangles);

  setdvarifuninitialized(@ "hash_7925a1f90294e6e8", 0);

  while(true) {
    origin = hint_ent.origin;
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
      thread utility::draw_line_for_time(origin, origin + fwd * 100, 1, 1, 0, 0.05);
      thread utility::draw_line_for_time(origin, origin + nml * 100, can_use ? 0 : 1, can_use ? 1 : 0, 0, 0.05);
      print3d(origin, acos(dot));
    }

    waitframe();
  }
}

function function_292988dabdf8ab19(linktag, originoffset, hintstring, hintstringheld, duration, var_8142e6f1f29504d7) {
  thread function_575a40eb41528af5(linktag, originoffset, hintstring, hintstringheld, duration, var_8142e6f1f29504d7);
}

function private function_575a40eb41528af5(linktag, originoffset, hintstring, hintstringheld, duration, var_8142e6f1f29504d7) {
  thread create_cursor_hint(linktag, originoffset, hintstring);
  triggered = function_977ea6560fcf433c();

  if(!istrue(triggered)) {
    return;
  }

  thread function_5d38ca6e09cbda13(hintstringheld, duration, var_8142e6f1f29504d7);
}

function private function_5d38ca6e09cbda13(hintstringheld, duration, var_8142e6f1f29504d7) {
  waittillframeend();

  if(isDefined(var_8142e6f1f29504d7)) {
    showhint = function_2106ac79f3441517(var_8142e6f1f29504d7);

    if(!istrue(showhint)) {
      return;
    }
  }

  function_fb2f126ba558f9b7(duration);
}

function private function_2106ac79f3441517(var_8142e6f1f29504d7) {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  self waittill(var_8142e6f1f29504d7);
  return true;
}

function private function_fb2f126ba558f9b7(duration) {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
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
      level.player playRumbleOnEntity("\xadxR\xb6\v\xaf%\xb7");
    } else {
      self.holding = undefined;
    }

    if(istrue(self.holding) && !washolding) {
      self notify("\xc2\x98\x12\xedm\xde`\n\xa5\xc1");
    } else if(!istrue(self.holding) && washolding) {
      self notify("\x98\xca\xd6\xc7\xfd0\a\xd6'");
    }

    waitframe();
  }

  self notify("\x1a\xc8|>\x87Pk-Y\xe0^\xbb3");
}

function hint_delete_on_trigger() {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
  hintent = self;

  if(isDefined(self.cursor_hint_ent)) {
    hintent = self.cursor_hint_ent;
  }

  function_fdfd4ca84179557(hintent);

  if(isDefined(self)) {
    remove_cursor_hint();
  }
}

function function_fdfd4ca84179557(hintent) {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  hintent waittill("\x91`\xb1\xe7T\x97>", other);

  if(hintent != self) {
    self notify("\x91`\xb1\xe7T\x97>", other);
  }
}

function remove_cursor_hint() {
  hintent = self;

  if(isDefined(self.cursor_hint_ent)) {
    hintent = self.cursor_hint_ent;
    hintent delete();
    self notify("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
    return;
  }

  if(!isstruct(hintent)) {
    hintent makeunusable();
  }

  self notify("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");
}

function hint_waittill_trigger() {
  triggerent = utility_sp::monitor_interact_delay(self, "\x8b\x90\xb5\xc4W");
  return triggerent;
}

function function_977ea6560fcf433c() {
  self endon("\x96\xe8i\x01\xbeg/\xfc\xd8\xba\xfc\x97\b:");

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent waittill("\x91`\xb1\xe7T\x97>");
  } else {
    self waittill("\x91`\xb1\xe7T\x97>");
  }

  return true;
}

function make_cursorhint(displayrange, usedist, originoffset, linktag, var_143c3d64dc2e6cd5) {
  hintent = self;

  if(isstruct(hintent) || hintent.code_classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc" || isDefined(originoffset)) {
    hintent = utility::spawn_script_origin();
    self.cursor_hint_ent = hintent;
  }

  hintent makeusable();
  function_8a45875e72e88d90(var_143c3d64dc2e6cd5);
  set_position(hintent, originoffset, linktag);
  set_distances(displayrange, usedist);
  set_fov();
  set_presentation();
  set_logic();
  set_player();
  thread hint_delete_on_trigger();
}

function private set_position(hintent, originoffset, linktag) {
  if(isDefined(originoffset)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";

    if(isDefined(linktag)) {
      tag = linktag;
      hintent.origin = self gettagorigin(tag);
    }

    if(isDefined(self.model) && self.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6" && self tagexists(tag)) {
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

    return;
  }

  if(isDefined(linktag)) {
    hintent sethinttag(linktag);
  }
}

function function_8a45875e72e88d90(var_143c3d64dc2e6cd5 = "\xb2\xd3\xaffR\xcf\xddI1\xc0o") {
  hintent = function_180f8351e141ee8f();
  hintent setCursorHint(var_143c3d64dc2e6cd5);
}

function set_distances(displayrange = 500, usedistoverride) {
  hintent = function_180f8351e141ee8f();
  hintent sethintdisplayrange(displayrange);

  if(isDefined(usedistoverride)) {
    self.userange = usedistoverride;
    userange = usedistoverride;
  } else {
    userange = 80;
  }

  hintent setuserange(userange);
}

function set_fov(displayfov = 360, usefov = 65, var_fb5410efe7f154c1) {
  hintent = function_180f8351e141ee8f();
  hintent sethintdisplayfov(displayfov);
  hintent setusefov(usefov);

  if(istrue(var_fb5410efe7f154c1)) {
    userange = isDefined(self.userange) ? self.userange : 80;
    thread internal_hint_toggle_use_by_angles(hintent, var_fb5410efe7f154c1, userange);
  }
}

function set_logic(holdduration = "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96", needsmashing, usecommand) {
  hintent = function_180f8351e141ee8f();
  hintent setuseholdduration(holdduration);

  if(isstring(holdduration) && holdduration != "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a" && holdduration != "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96") {
    hintent sethintrequiresholding(1);
  } else if(isint(holdduration) && holdduration > 250) {
    hintent sethintrequiresholding(1);
  }

  if(istrue(needsmashing)) {
    hintent sethintrequiresmashing(needsmashing);
  }

  if(isDefined(usecommand)) {
    hintent setusecommand(usecommand);
  }
}

function set_presentation(hintstring, uniqueicon, ignoretrace, forcehintstring = 0) {
  hintent = function_180f8351e141ee8f();
  displayhintstring = 1;

  if(utility_sp::in_realism_mode() && !istrue(forcehintstring)) {
    displayhintstring = 0;
  }

  if(isDefined(hintstring) && displayhintstring) {
    hintent setHintString(hintstring);
  }

  if(isDefined(uniqueicon)) {
    hintent sethinticon(uniqueicon);
  }

  value = istrue(ignoretrace) ? "\xf1\xba\x8f\x9d" : "\x19b\xc2y";
  hintent sethintonobstruction(value);
}

function set_player(lockmovement = 0, whileencumbered = 0) {
  hintent = function_180f8351e141ee8f();
  hintent sethintlockplayermovement(lockmovement);
  hintent setusewhenhandsoccupied(whileencumbered);
}

function function_180f8351e141ee8f() {
  if(isDefined(self.cursor_hint_ent)) {
    return self.cursor_hint_ent;
  }

  assert(isent(self), "<dev string:xf6>");
  return self;
}