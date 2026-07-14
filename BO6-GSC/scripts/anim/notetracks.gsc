/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\notetracks.gsc
***************************************/

#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\shared\utility;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace notetracks;

function shownotetrack(note) {
  if(!isDefined(self) || getdvarint(@ "hash_a19781010239d2e6") != 1 && getdvarint(@ "hash_a19781010239d2e6") != self getentitynumber()) {
    return;
  }

  self endon("<dev string:x24>");
  anim.shownotetrackspeed = 30;
  anim.shownotetrackduration = 20;
  duration = anim.shownotetrackduration + int(20 / anim.shownotetrackspeed);
  color = (0.5, 0.75, 1);

  if(note == "<dev string:x2d>" || note == "<dev string:x34>") {
    color = (0.25, 0.4, 0.5);
  } else if(note == "<dev string:x3e>") {
    color = (1, 0.5, 0.5);
  }

  for(i = 0; i < duration; i++) {
    if(duration - i <= anim.shownotetrackduration) {
      amnt = 1 * (i - duration - anim.shownotetrackduration) / anim.shownotetrackduration;
    } else {
      amnt = 0;
    }

    time = 1 * i / 20;
    alpha = 1 - amnt * amnt;

    if(isai(self)) {
      pos = self getEye() + (0, 0, 20 + anim.shownotetrackspeed * time);
    } else {
      pos = self.origin;
    }

    print3d(pos, note, color, alpha, 0.5);
    waitframe();
  }
}

function registernotetracks() {
  thread function_1e1c9872f59f63f6();
  anim.notetracks["\xe3\xc4\xfeR\xfc\x8d\xbf\xce\x89\x18\xe3\xabj\xfam\xdc]\xfc\xb9\xec\x1c\x96"] = &notetrackmovementstop;
  anim.notetracks["\xba\xaa\x80\xe3uMy\x88\x02\xd4\xa2xGj,\xca\xca\xd2(\xfd%\xee"] = &notetrackmovementwalk;
  anim.notetracks["7\xdb\x81\x12\x93\xaa\x03d\xa8,=1\xd9*\x81\x83\xb4\xd2\xd8\xe4\xce"] = &notetrackmovementrun;
  anim.notetracks["\x9fP\xb4\xf5p\x99?n;?\xaf\xd4\xf7\x8f\xc5GX!\xee\x04"] = &notetrackmovementstop;
  anim.notetracks["X\xe6\xd2\xd6_\xado\x9d\xb2m\xb2\xb9\xe8\b\xa7\x10\xbb\x85\xb1m"] = &notetrackmovementwalk;
  anim.notetracks["{\x89l\x89\x9f@.\xc4\x1d\v)\xe9wJ\xc4\\\xaa\xef,"] = &notetrackmovementrun;
  anim.notetracks["&\xa4t\xee\xa5l\x17\xc3g\xf0m\xa0}/\xbaN$\xef\tj\n\xb3\xaf\x99\xd4<)x@\xc3\x95S\xb1\x92}\xc0\xf4\xb8\x9cMuZ\xd9jD\x95"] = &notetrackmovementgunposeoverride;
  anim.notetracks["\xf3\x1c\xc0\xd3\xd0\xf9\x8e\xefsr\x85\xf4\xd7B\x95\x1b)|\xc0?%u:Q^\x97\x05"] = &notetrackcoverposerequest;
  anim.notetracks["\r\x1b\x84\xd2s\x18\xc1\xe8\xbb\xc4\xbc\xff\x90n\xba\x85\xcdw\xf8\f\xe5~\xb8\xf2\xe7\x8aV\xe9"] = &notetrackcoverposerequest;
  anim.notetracks["SBb\xd2 \xe0\xbe\xe3\x8fr\xe0\xe5\xd0*\xe3<+\xc5\xd1\xe7\n\xf2>G\xbd\x88\x19\xf8N"] = &notetrackcoverposerequest;
  anim.notetracks["\x16\x95z%\xa9\xc0\xc6Q\xf0Vy\x87\xcb)ZX\xe0\xff\x18&\xf6\xce\xb7\a\xbe1\xb6V"] = &notetrackcoverposerequest;
  anim.notetracks["\x98.\xf0\x9fM&\xab\x9b\x7f\x8aA\xda\xc3\xf5\xb3\x9f\xfd\x16Q\xbe\x8f\x8c\xf9'\x8b\xab\xc1\x9c\xc3\xf0\x8a\x99+\xa2"] = &notetrackcoverposerequest;
  anim.notetracks["\xd4c(\x97\xdf{\x99\xb6\xf3~0\x17\x7f#\x87\xcf\x80\xaf*k9b\xed\xb7\xf0/pq\xbf'\xbeW\xd1\xa7."] = &notetrackcoverposerequest;
  anim.notetracks["\xad48\xb0\xbc\xa2G\x05\xdb\xff`\xfaX\xc0\xfdT\xc4\xac\xce\xea\x9b\f\x819"] = &notetrackcoverposerequest;
  anim.notetracks["]\xb6=\xb6\xcc\xe6\xa3\x8dRU\xa7\xe9o~\xd9\xcdR\xe4X\x18\x91\xc0Q\xae$7\xd6\xe2\xa1\xfcq"] = &notetrackcoverposerequest;
  anim.notetracks["\xf0\x80\xb6\a0eB\x05\x9d\xaa\xbd\xc1w\xc6\x92\xf2\x1a0v\x90\xb9\x15"] = &notetrackcoverposerequest;
  anim.notetracks["*5\v\xe7T,?@\b\x8c\x1fWZ\x8d~"] = &notetrackalertnessaiming;
  anim.notetracks["\x81\xc9*\xf3\xa3\\\x05\x1f\xc9u<\\\xf6n\x18"] = &notetrackalertnessalert;
  anim.notetracks["\x9f^\x97\x98\x87f\x82`\xc0\x1b\xfd\xbb\x13G\xb89\xa7\xab_C\xe7N\xea"] = &notetrackalertnesscasual;
  anim.notetracks["\x87\xf0\x02\xdeN\x10x\x95\xb5\x85A5o&\xdd\x94\x9d\xcb5\x1b\xae\x05"] = &notetrackalertnessalert;
  anim.notetracks["\xa8\x13\xb5\x9d\xc9{$\xfa\x94k\x97\x1a\x03\xdd\xc0F\xef\xd4\x14]\xc2\xc5\v"] = &notetrackalertnessaiming;
  anim.notetracks["\xc7\x1f=\xa4\xc1\x06\r\xf9\x14\xe9"] = &notetrackgravity;
  anim.notetracks["1\x1b\x8f\xce\xd0|\xc9J\xb0\x0f\xb6"] = &notetrackgravity;
  anim.notetracks["\xa3\xcf7t\xcc\xe3\"\xf6\x9fR\xd02f}"] = &notetrackbodyfall;
  anim.notetracks[">uF\xb2Z+s\xf9\xd7b&\xb5\x02\xf3"] = &notetrackbodyfall;
  anim.notetracks["f\x97\xb9`\xd1~\x80(\xca"] = &notetrackcodemove;
  anim.notetracks["\x99A\xde\xe5}\xf9\xc0s\x91\xb4"] = &notetrackfaceenemy;
  anim.notetracks["s1\x82P\xa5r\x87j\x9fLt^\b\x93p\xf2"] = &notetrackpistolrechamber;
  anim.notetracks["\x88EF\x03\xec\xd3S&O\x7f"] = &notetrackloadshell;
  anim.notetracks["H=\xb0g\xaf\x01b\x14\x85\x12\a\x9d\v}"] = &function_dc6c5b480d700913;
  anim.notetracks["\xcciN\xca"] = &notetrackfire;
  anim.notetracks["3\xa5\x93V\xf5spNa\xe5"] = &notetrackfirespray;
  anim.notetracks["\x9f\xeb0\x1f\x1f\x98\xf7\x8b\xb7\xff5"] = &notetrackguntochest;
  anim.notetracks["\xcc\xae\x81\r\xe5\x9e\xe4Q4I"] = &notetrackguntoback;
  anim.notetracks["\xf9\xef\xb2\x9b&\xaf#\xf8\xdf\xc0\xcf"] = &notetrackguntoright;
  anim.notetracks["Ll\x98@\xfb\xc7HR\xd7\\"] = &function_ac723cdd5ddb4b93;
  anim.notetracks["x\x95\t\xa8\xbb=\x1fM\xab\v\x0fw\xac\x994\x7f"] = &function_19188ae9ac8c7e8f;
  anim.notetracks["\x96\xb4\x03%z\x9dM\xf4\xed\xa2\xfb\xb91\xe0\x02AY"] = &function_9ff4418a01fd0ae0;
  anim.notetracks["\x16\x02[\xe1\x9b\x87\xf3\x85\xac\xff0L\xcd"] = &notetrackpistolpickup;
  anim.notetracks["\xf1J\xd8\xac\x9a6\a\xf1\xfbq$\xaa\xbe\xec"] = &notetrackpistolputaway;
  anim.notetracks["8]\xd8L\f\xc8Vd\xbfK\x98"] = &notetrackrefillclip;
  anim.notetracks["\xc9\xca\x1boX\x8c\x10\xc8on\xca"] = &notetrackrefillclip;
  anim.notetracks["4\xd1\xfa\xf6\xe6"] = &notetrackhton0;
  anim.notetracks["\xaa\xe8\b|m\xe0$"] = &notetrackhton0;
  anim.notetracks["4\xd1\xd7\xf6\xb9\xf51"] = &notetrackhton1;
  anim.notetracks["\xd3d`\xc7\x91I"] = &notetrackhtoff;
  anim.notetracks["h2=1\xd6"] = &function_4ad08fff6ee80c9e;
  anim.notetracks["\xd0\x1c\xf5\xf6\xb9\xaf\a\xde7"] = &function_5b216536d0d4e9f2;
  anim.notetracks["\xe0\xe9\x87\x05P\xc8"] = &function_276055623dff55fa;
  anim.notetracks["\xcd\xbdtZ\x99\xbc"] = &notetracknotify;
  anim.notetracks["g\xd2\x95\xbb\xba\xe6\xc6-\x9bmk\xed\x91V\xd8"] = &function_ac398d33e4cd915a;
  anim.notetracks["/\xac\xbf:3\xfa\x15\xd8\xd5\x1c\xf9U"] = &function_b72d7596e1a219fb;
  anim.notetracks["\xa3<\x93\x94\x1e\xb2,Op\x9b\t"] = &function_6291b3a3d9aae417;

  if(isDefined(level._notetrackfx)) {
    keys = getarraykeys(level._notetrackfx);

    foreach(key in keys) {
      anim.notetracks[key] = &customnotetrackfx;
    }
  }
}

function notetrackstopanim(note, flagname) {}

function notetrackcoverposerequest(note, flagname) {
  assert(issubstr(note, "<dev string:x4b>"));
  coverpose = strtok(note, "@O\b")[1];

  switch (coverpose) {
    case #"hash_175771022bc5e75d":
    case #"hash_4ddb655e251e06c8":
    case #"hash_9d76c99eddd14433":
    case #"hash_c475427a998ee26c":
    case #"hash_d165cddb82d41e6a":
    case #"hash_d44cb989edc40ab3":
    case #"hash_d91940431ed7c605":
    case #"hash_e7aface284179b3b":
    case #"hash_f1676baca0ae608b":
      self.coverposerequest = coverpose;
      break;
    default:
      assertmsg("<dev string:x60>");
      break;
  }
}

function notetrackmovementstop(note, flagname) {
  self.a.movement = "\x04M\xed\xab";
}

function notetrackmovementwalk(note, flagname) {
  self.a.movement = "\x82}\xeb\x93";
}

function notetrackmovementrun(note, flagname) {
  self.a.movement = "\x14+`";
}

function notetrackmovementgunposeoverride(note, flagname) {
  self.asm.movementgunposeoverride = "\xe5\xedX\x14\xfe\xd0\xd1_va\xb7\x04";
}

function notetrackalertnessaiming(note, flagname) {}

function notetrackalertnesscasual(note, flagname) {}

function notetrackalertnessalert(note, flagname) {}

function function_412c18ccd76c27b1(note, flagname) {
  setdvarifuninitialized(@ "hash_d54f2997c58912ce", "<dev string:x83>");

  if(getdvarint(@ "hash_d54f2997c58912ce") < 1) {
    return;
  }

  if(!isDefined(flagname)) {
    flagname = "<dev string:x88>";
  }

  if(issubstr(note, "<dev string:x8d>")) {
    println("<dev string:x92>" + note + "<dev string:xc5>" + flagname);
  }
}

function notetrackloadshell(note, flagname) {}

function notetrackpistolrechamber(note, flagname) {}

function notetrackgravity(note, flagname) {
  if(issubstr(note, "\xb8\"")) {
    self animmode("\x1b\x9e\x86\xecr\x97\xa2");
    return;
  }

  if(issubstr(note, "\xf8\x88m")) {
    self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
  }
}

function customnotetrackfx(note, flagname) {
  assert(isDefined(level._notetrackfx[note]));

  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "Ee\x12\x18";
  }

  struct = undefined;

  if(isDefined(level._notetrackfx[note][groundtype])) {
    struct = level._notetrackfx[note][groundtype];
  } else if(isDefined(level._notetrackfx[note]["\xc0\xc6J"])) {
    struct = level._notetrackfx[note]["\xc0\xc6J"];
  }

  if(!isDefined(struct)) {
    return;
  }

  if(isai(self) && isDefined(struct.fx)) {
    playFXOnTag(struct.fx, self, struct.tag);
  }

  if(!isDefined(struct.sound_prefix) && !isDefined(struct.sound_suffix)) {
    return;
  }

  alias = "" + struct.sound_prefix + groundtype + struct.sound_suffix;

  if(soundexists(alias)) {
    self playSound(alias);
  }
}

function notetrackcodemove(note, flagname) {
  return "f\x97\xb9`\xd1~\x80(\xca";
}

function notetrackfaceenemy(note, flagname) {
  self orientmode("A\x14N5f\xcd6t\x04\xe6");
}

function notetrackbodyfall(note, flagname) {
  suffix = "N'j\x9f\xe0\xc4";

  if(issubstr(note, "\n\x7fk\x84\x8e")) {
    suffix = " \x18O\x8d\x7f\x7f";
  }

  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "Ee\x12\x18";
  }

  if(suffix == " \x18O\x8d\x7f\x7f") {
    self playsurfacesound("$\xeb\xdf.\xea\xadv\"\x96\x1b\x87Z\xe2/", groundtype);
    return;
  }

  self playsurfacesound("l\x89\x14h\xcc8\xcc\x14\xe7\xe0O\xeab\xd4@\xacu\xa8\xc4", groundtype);
}

function donotetracks(flagname, customfunction, debugidentifier) {
  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes)) {
      notes = ["\xed\x1d\va\x1e\xf6\xe5\x88\x8a"];
    }

    if(!isarray(notes)) {
      notes = [notes];
    }

    notetrack::validatenotetracks(flagname, notes);

    foreach(note in notes) {
      val = handlenotetrack(note, flagname, customfunction);

      if(isDefined(val)) {
        return val;
      }
    }
  }
}

function handlenotetrack(note, flagname, customfunction, customparams) {
  if(isDefined(self.fnasm_handlenotetrack)) {
    return [[self.fnasm_handlenotetrack]](note, flagname, customfunction, customparams);
  }

  if(isDefined(level._defaultnotetrackhandler)) {
    return [[level._defaultnotetrackhandler]](note, flagname, customfunction, customparams);
  }

  assertmsg("<dev string:xd0>" + self getentitynumber());
}

function hascustomnotetrackhandler(note) {
  notetrackfunc = anim.notetracks[note];

  if(isDefined(notetrackfunc)) {
    return true;
  }

  if(isDefined(self.customnotetrackhandler)) {
    return true;
  }

  return false;
}

function handlecustomnotetrackhandler(note, flagname, customfunction, customparams) {
  assert(hascustomnotetrackhandler(note));
  notetrackfunc = anim.notetracks[note];

  function_412c18ccd76c27b1(note, flagname);

  if(isDefined(notetrackfunc)) {
    return [[notetrackfunc]](note, flagname);
  }

  if(isDefined(self.customnotetrackhandler)) {
    if(isDefined(customparams)) {
      return [[self.customnotetrackhandler]](note, flagname, customfunction, customparams);
    }

    return [[self.customnotetrackhandler]](note, flagname, customfunction);
  }
}

function handlecommonnotetrack(note, flagname, customfunction, customparams) {
  thread shownotetrack(note);

  switch (note) {
    case #"hash_b61583709daf623":
    case #"hash_247cc07ab83949f2":
    case #"hash_2a91eda16e3944d1":
    case #"hash_ed49946bfff8e78a":
      return note;
    case #"hash_1962676868099dfd":
      if(isDefined(self.enemy)) {
        return note;
      }

      break;
    case #"hash_49af0c46b8bd5fb2":
      thread utility::play_sound_in_space("$D\xd3\x90\xb6,\r\x91\xc9{\x1f\xcf\xa4\xf4?s\x85", self gettagorigin("\x1a\xe2mW`\xf2$\xbb48\xb8\x10c\xdd\xfc\x1c"));
      break;
    case #"hash_466ca7b853d8962e":
      thread utility::play_sound_in_space("C\xfd\x8d\xb8=\xf7\xb3\x93X\x8a\xff\xf8(fB\xef\xdb", self gettagorigin("\x1a\xe2mW`\xf2$\xbb48\xb8\x10c\xdd\xfc\x1c"));
      break;
    case #"hash_e01205bce6c9351c":
      self.a.nodeath = 1;
      break;
    case #"hash_96585dbff62202c2":
      self.allowpain = 0;
      break;
    case #"hash_fc9342b5a91869ea":
      self.allowpain = 1;
      break;
    case #"hash_39305061b0d59e1e":
    case #"hash_83ed1371a36bf0b6":
      self.a.meleestate = "o0\xee\xc1\x8c";
      break;
    case #"hash_d97e6d5be66b4c5":
    case #"hash_31521d11dde26e47":
      self.a.meleestate = "=\xff0b";
      break;
    case #"hash_7701f1d5cbc5085d":
      if(isDefined(self.hatmodel)) {
        if(isDefined(self.helmetsidemodel)) {
          self detach(self.helmetsidemodel, "GB\xb8\x8ew\x9efpP~\xff\xd7TX");
          self.helmetsidemodel = undefined;
        }

        self detach(self.hatmodel, "");
        self attach(self.hatmodel, "\xa8\xa0\xe8\xfa\xeaQ\x05A\xd39\xfa\x89\xa2\x8c\xa2");
        self.hatmodel = undefined;
      }

      break;
    case #"hash_6f55d0ff4f5a774":
      level notify("\x83\xd4}G}wh\xbaXq5", self);
      break;
    case #"hash_275f5641f230746b":
      level notify("\x83\xd4}G}wh\xbaXq5", self);
      break;
    case #"hash_ff2ad0514dabb22b":
      if(!self.fixednode) {
        self animmode("\xdf7Q\x05uR.q\xc2.\xb2\x015");
      }

      break;
    default:
      return "\xa9PS\x99\x84XByiuW";
  }
}

function donotetracksintercept(flagname, interceptfunction, debugidentifier) {
  assert(isDefined(interceptfunction));

  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes)) {
      notes = ["\xed\x1d\va\x1e\xf6\xe5\x88\x8a"];
    }

    if(!isarray(notes)) {
      notes = [notes];
    }

    notetrack::validatenotetracks(flagname, notes);
    intercepted = [[interceptfunction]](notes);

    if(isDefined(intercepted) && intercepted) {
      continue;
    }

    defined_val = undefined;

    foreach(note in notes) {
      val = handlenotetrack(note, flagname);

      if(isDefined(val)) {
        defined_val = val;
        break;
      }
    }

    if(isDefined(defined_val)) {
      return defined_val;
    }
  }
}

function donotetrackspostcallback(flagname, postfunction) {
  assert(isDefined(postfunction));

  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes)) {
      notes = ["\xed\x1d\va\x1e\xf6\xe5\x88\x8a"];
    }

    if(!isarray(notes)) {
      notes = [notes];
    }

    notetrack::validatenotetracks(flagname, notes);
    defined_val = undefined;

    foreach(note in notes) {
      val = handlenotetrack(note, flagname);

      if(isDefined(val)) {
        defined_val = val;
        break;
      }
    }

    [[postfunction]](notes);

    if(isDefined(defined_val)) {
      return defined_val;
    }
  }
}

function donotetracksfortimeout(flagname, killstring, customfunction, debugidentifier) {
  donotetracks(flagname, customfunction, debugidentifier);
}

function donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
  donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, debugidentifier);
}

function donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
  donotetracksforeverproc(&donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
}

function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, debugidentifier) {
  if(isDefined(killstring)) {
    self endon(killstring);
  }

  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");

  if(!isDefined(debugidentifier)) {
    debugidentifier = "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
  }

  for(;;) {
    time = gettime();
    returnednote = [[notetracksfunc]](flagname, customfunction, debugidentifier);
    timetaken = gettime() - time;

    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [[notetracksfunc]](flagname, customfunction, debugidentifier);
      timetaken = gettime() - time;

      if(timetaken < 0.05) {
        println(gettime() + "<dev string:xf2>" + debugidentifier + "<dev string:xf7>" + flagname + "<dev string:x153>" + returnednote + "<dev string:x162>");
        wait 0.05 - timetaken;
      }
    }
  }
}

function donotetrackswithtimeout(flagname, time, customfunction, debugidentifier) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksfortimeout, flagname, customfunction, debugidentifier, ent);
}

function donotetracksfortime(time, flagname, customfunction, debugidentifier) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforever, flagname, customfunction, debugidentifier, ent);
}

function donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforeverintercept, flagname, interceptfunction, debugidentifier, ent);
}

function donotetracksfortimeproc(donotetracksforeverfunc, flagname, customfunction, debugidentifier, ent) {
  ent endon("3\xb8\x16/v0\x8fEj;*\xc3\xf7\xba\xc0");
  [[donotetracksforeverfunc]](flagname, undefined, customfunction, debugidentifier);
}

function donotetracksfortimeendnotify(time) {
  wait time;
  self notify("3\xb8\x16/v0\x8fEj;*\xc3\xf7\xba\xc0");
}

function notetrack_prefix_handler(notetrack) {
  assert(isDefined(level.fnnotetrackprefixhandler));
  return [[level.fnnotetrackprefixhandler]](notetrack);
}

function function_687d6da8dbe521c0(guy, notetrack) {
  function_e61646a657c2ffe4(notetrack);
}

function function_8242b090bfb71e4d() {
  if(utility::ismp()) {
    linked_children = self getlinkedchildren();

    foreach(ent in linked_children) {
      if(isPlayer(ent)) {
        return ent;
      }
    }
  }

  return level.player;
}

function notetrack_prefix_handler_common(notetrack) {
  prefix3 = getsubstr(notetrack, 0, 3);

  if(prefix3 == "P\xce\xd3") {
    model = cleanup_string(getsubstr(notetrack, 3));
    self setModel(model);
  } else if(prefix3 == "#\x81\xba") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);
    fade_data = strtok(notetrack, "w");
    fade_action = tolower(fade_data[1]);
    var_bcc2bd6eae0bc869 = undefined;
    var_1b5b15c9d105e99d = undefined;
    var_c627bec3e47af84e = undefined;

    if(fade_action == "\xf1\xcc") {
      var_bcc2bd6eae0bc869 = float(fade_data[2]);
    } else if(fade_action == "w&\xea\x18") {
      var_c627bec3e47af84e = float(fade_data[2]);
    } else if(fade_action == "\xca?\x86[\x96\xde") {
      var_bcc2bd6eae0bc869 = float(fade_data[2]);
      var_1b5b15c9d105e99d = float(fade_data[3]);
      var_c627bec3e47af84e = float(fade_data[4]);
    }

    player thread function_d24a5e76bf65ddf4(var_bcc2bd6eae0bc869, var_1b5b15c9d105e99d, var_c627bec3e47af84e);
    return 1;
  } else if(prefix3 == "\xd5\xb9\xc2") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);
    rumble = getsubstr(notetrack, 3);
    player playRumbleOnEntity(rumble);
    return 1;
  } else if(prefix3 == "Uf\x04") {
    function_f31621facb3d11ad(getsubstr(notetrack, 3));
    return 1;
  } else if(prefix3 == "0\x98\xe6") {
    params = getsubstr(notetrack, 3);

    if(params == "\xc0\xc6J") {
      function_89223e3577ffe6f0();
    } else {
      function_919d2382b32b15c7(params);
    }

    return 1;
  } else if(prefix3 == "\xde\x1e\x9d") {
    function_82104525d00a39cb(getsubstr(notetrack, 3));
    return 1;
  } else if(prefix3 == "\xfa\x94\xe8") {
    function_198475d7ea0d03a3(getsubstr(notetrack, 3));
    return 1;
  } else if(prefix3 == "\xe2n\xaf") {
    utility::flag_set(getsubstr(notetrack, 3));
    return 1;
  } else if(prefix3 == "\"\xcd\xf3") {
    utility::flag_clear(getsubstr(notetrack, 3));
    return 1;
  }

  prefix4 = getsubstr(notetrack, 0, 4);

  if(prefix4 == "\xccs\xcc\xbe") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);
    var_96734369e22f6233 = strtok(notetrack, "w");
    var_1d37a3b421f5df06 = float(var_96734369e22f6233[1]);
    var_9dea69d0e1d0a27c = float(var_96734369e22f6233[2]);
    player lerpfovscalefactor(var_1d37a3b421f5df06, var_9dea69d0e1d0a27c);
    return 1;
  } else if(prefix4 == "\xe4kn\xfa") {
    rumble = function_392b47556c2846fe(notetrack, prefix4);

    if(rumble == "\xc0\xc6J") {
      stopallrumbles();
    } else {
      player = function_8242b090bfb71e4d();
      assert(isDefined(player), "<dev string:x167>" + notetrack);
      player stoprumble(rumble);
    }

    return 1;
  } else if(prefix4 == "7\xd0x\x14") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);
    rumble = function_392b47556c2846fe(notetrack, prefix4);
    player playrumblelooponentity(rumble);
    return 1;
  } else if(prefix4 == "\xaf\x03\xcf\x98") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);

    if(!isDefined(player)) {
      return 1;
    }

    fov_data = strtok(notetrack, "w");
    fov_action = tolower(fov_data[1]);
    fov_value = undefined;
    fov_time = undefined;
    var_e46ca4b11c056ccd = undefined;
    var_d09100feb34d017a = undefined;
    ease_param_offset = undefined;

    if(fov_action == "\x17\xad\v\xde8") {
      fov_value = float(fov_data[2]);

      if(isDefined(fov_data[3])) {
        fov_time = float(fov_data[3]);
      }

      ease_param_offset = 4;
    } else {
      fov_value = 65;

      if(isDefined(fov_data[2])) {
        fov_time = float(fov_data[2]);
      }

      ease_param_offset = 3;
    }

    var_d9fc8476c244db0b = fov_data[ease_param_offset];

    if(isDefined(var_d9fc8476c244db0b)) {
      if(var_d9fc8476c244db0b == "\x0f\xaa\x01\xdb\x18\xbe") {
        var_e46ca4b11c056ccd = float(fov_data[ease_param_offset + 1]);
        var_81385cb805caeec2 = fov_data[ease_param_offset + 2];

        if(isDefined(var_81385cb805caeec2) && var_81385cb805caeec2 == "m\xa29\xe3A\xe8D") {
          var_d09100feb34d017a = float(fov_data[ease_param_offset + 3]);
        }
      } else if(var_d9fc8476c244db0b == "m\xa29\xe3A\xe8D") {
        var_d09100feb34d017a = float(fov_data[ease_param_offset + 1]);
      }
    }

    player modifybasefov(fov_value, fov_time, var_e46ca4b11c056ccd, var_d09100feb34d017a);
    return 1;
  } else if(prefix4 == "\xcev\xf2\xc3") {
    player = function_8242b090bfb71e4d();
    assert(isDefined(player), "<dev string:x167>" + notetrack);
    dof_tokens = strtok(notetrack, "\x16");
    dof_action = tolower(dof_tokens[0]);

    if(dof_action == "\xc0a\xb1/\x9a\x16\x96\xa1") {
      if(!isDefined(dof_tokens[1])) {
        assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x1a4>");
        return;
      }

      fstop = float(dof_tokens[1]);
      var_cdb7d4fa9961cac8 = function_9b9c40a6624e6197(dof_tokens[2]);
      var_fa874f70c27478a = function_9b9c40a6624e6197(dof_tokens[3]);
      player utility::dof_enable_autofocus(fstop, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a);
    } else if(dof_action == "Ew\xc6\xe9\x17\xe0h" || dof_action == "\xbe[\x9cA]\xa8\x87\x85") {
      if(!isDefined(dof_tokens[1])) {
        assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x1a4>");
        return;
      }

      fstop = float(dof_tokens[1]);
      var_cdb7d4fa9961cac8 = function_9b9c40a6624e6197(dof_tokens[2]);
      var_fa874f70c27478a = function_9b9c40a6624e6197(dof_tokens[3]);
      override_bone = undefined;

      if(isDefined(dof_tokens[4])) {
        override_bone = cleanup_string(dof_tokens[4]);

        if(isDefined(override_bone) && !self tagexists(override_bone)) {
          assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x1cd>");
          return;
        }
      }

      var_8134253b3916733 = function_b56b2822e669b396(dof_tokens[5]);
      focus_ent = self;

      if(dof_action == "Ew\xc6\xe9\x17\xe0h") {
        player utility::dof_enable_autofocus(fstop, focus_ent, var_cdb7d4fa9961cac8, var_fa874f70c27478a, undefined, override_bone, undefined, var_8134253b3916733, 1);
      } else {
        focus_distance = distance(player getEye(), focus_ent.origin);
        player utility::dof_enable(fstop, focus_distance, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a, undefined, override_bone);
      }
    } else if(dof_action == "\x91\xde\x99_\x19\xd2sG\xc2\x9bc+" || dof_action == "\x1d\x1d\xea{\xac\xbf\xc9w}K\xf8\r\xdb") {
      if(!isDefined(dof_tokens[1])) {
        assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x21e>");
        return;
      }

      focus_distance = float(dof_tokens[1]);

      if(!isDefined(dof_tokens[2])) {
        assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x1a4>");
        return;
      }

      fstop = float(dof_tokens[2]);
      var_cdb7d4fa9961cac8 = function_9b9c40a6624e6197(dof_tokens[3]);
      var_fa874f70c27478a = function_9b9c40a6624e6197(dof_tokens[4]);

      if(dof_action == "\x91\xde\x99_\x19\xd2sG\xc2\x9bc+") {
        player utility::dof_enable_autofocus(fstop, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a, undefined, focus_distance, undefined, 1);
      } else {
        player utility::dof_enable(fstop, focus_distance, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a);
      }
    } else if(dof_action == "\xc8\xdbf}\x83{\x9b" || dof_action == "W\xc9\xa6G\xfc\xc7\xa9i") {
      focus_pos = function_42fb3500f47f31c0(dof_tokens[1], dof_tokens[2], dof_tokens[3]);

      if(!isDefined(focus_pos)) {
        assertmsg("<dev string:x250>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x25f>");
        return;
      }

      if(!isDefined(dof_tokens[4])) {
        assertmsg("<dev string:x18a>" + notetrack + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x1a4>");
        return;
      }

      fstop = float(dof_tokens[4]);
      var_cdb7d4fa9961cac8 = function_9b9c40a6624e6197(dof_tokens[5]);
      var_fa874f70c27478a = function_9b9c40a6624e6197(dof_tokens[6]);

      if(dof_action == "\xc8\xdbf}\x83{\x9b") {
        player utility::dof_enable_autofocus(fstop, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a, undefined, focus_pos, undefined, 1);
      } else {
        focus_distance = distance(player getEye(), focus_pos);
        player utility::dof_enable(fstop, focus_distance, undefined, var_cdb7d4fa9961cac8, var_fa874f70c27478a, focus_pos);
      }
    } else if(dof_action == "\\\x95\xda\xae\x1a\xefv;") {
      player utility::dof_disable_autofocus();
    } else {
      assertmsg("<dev string:x18a>" + notetrack + "<dev string:x2d5>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x2df>");
    }

    return 1;
  }

  if(isstartstr(notetrack, "eP\b\x13\xa2\xd8\xa1\xf7\xeb")) {
    params = getsubstr(notetrack, 10);
    function_5182a7d4e8b80220(params);
    return 1;
  } else if(isstartstr(notetrack, "&T6\x0e0f\xcf\x91F\xa4\x9c")) {
    params = getsubstr(notetrack, 12);

    if(params == "\xc0\xc6J") {
      function_14a1aaadb8aff4a8();
    } else {
      function_412669e114549b8f(params);
    }

    return 1;
  } else if(isstartstr(notetrack, "\x19b\xc2y")) {
    params = getsubstr(notetrack, 5);
    var_90e2390c9a13a25 = strtok(params, "\x16");
    tag = var_90e2390c9a13a25[0];

    if(isDefined(tag)) {
      if(utility::issp()) {
        if(isDefined(var_90e2390c9a13a25[1])) {
          self hidepart(tag, var_90e2390c9a13a25[1]);
        } else {
          self hidepart(tag);
        }
      }
    } else {
      self hide();
    }

    return 1;
  } else if(isstartstr(notetrack, "\xf1\xba\x8f\x9d")) {
    params = getsubstr(notetrack, 5);
    var_90e2390c9a13a25 = strtok(params, "\x16");
    tag = var_90e2390c9a13a25[0];

    if(isDefined(tag)) {
      if(utility::issp()) {
        params = getsubstr(notetrack, 5);
        var_42553e7a8dfdd648 = strtok(params, "\x16");

        if(isDefined(var_42553e7a8dfdd648[1])) {
          self showpart(tag, var_42553e7a8dfdd648[1]);
        } else {
          self showpart(tag);
        }
      }
    } else {
      self show();
    }

    return 1;
  }

  return 0;
}

function shootnotetrack() {
  waittillframeend();

  if(isDefined(self) && isalive(self) && gettime() > self._blackboard.shootparams_lastshoottime) {
    if(istrue(self._blackboard.shootparams_valid)) {
      var_453a9125941da98 = self._blackboard.shootparams_shotsperburst == 1;
    } else {
      var_453a9125941da98 = 1;
    }

    utility_common::shootenemywrapper(var_453a9125941da98);
    utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "\x03\xb0\xa1\xa9\x04\xac\x88\x82\x88\x18\xb6\xed\xe1\x82") {
      self.rocketammo--;
    }
  }
}

function function_dc6c5b480d700913(note, flagname) {
  if(self.bulletsinclip) {
    notetrackfire(note, flagname);
  }
}

function notetrackfire(note, flagname) {
  if(isDefined(self.script) && isDefined(anim.fire_notetrack_functions[self.script])) {
    thread[[anim.fire_notetrack_functions[self.script]]]();
    return;
  }

  thread shootnotetrack();
}

function notetrackfirespray(note, flagname) {
  if(!isalive(self) && self isbadguy()) {
    if(isDefined(self.changed_team)) {
      return;
    }

    self.changed_team = 1;
    teams["?\xb1\xc0\x9a"] = "\x8c\x1b\xab)\xd1";
    teams["\x8c\x1b\xab)\xd1"] = "?\xb1\xc0\x9a";
    assert(isDefined(teams[self.team]), "<dev string:x36e>" + self.team);
    self.team = teams[self.team];
  }

  if(!issentient(self)) {
    self notify("\xcciN\xca");
    return;
  }

  if(isundefinedweapon(self.a.weaponpos["o0\xee\xc1\x8c"])) {
    return;
  }

  weaporig = self getmuzzlepos();
  dir = anglesToForward(self getmuzzleangle());
  ang = 10;

  if(isDefined(self.isrambo)) {
    ang = 20;
  }

  hitenemy = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    enemydir = vectorNormalize(self.enemy getEye() - weaporig);

    if(vectordot(dir, enemydir) > cos(ang)) {
      hitenemy = 1;
    }
  }

  if(hitenemy) {
    utility_common::shootenemywrapper();
  } else {
    dir += ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    pos = weaporig + dir * 1000;
    self[[anim.shootposwrapper_func]](pos);
  }

  utility::decrementbulletsinclip();
}

function notetrackrefillclip(note, flagname) {
  weaponlist::refillclip();
}

function notetracknotify(note, flagname, customparams) {
  player = level.players[customparams[0]];

  if(customparams.size == 3 && isDefined(player)) {
    player notify(customparams[2]);
  }
}

function function_ac398d33e4cd915a(note, flagname, customparams) {
  if(customparams.size == 3) {
    params = strtok(customparams[2], "\x16");

    if(params.size >= 1) {
      entitytargetname = params[0];
      var_a2deb13ae780a25d = getEnt(entitytargetname, #targetname);

      if(isDefined(var_a2deb13ae780a25d)) {
        var_a2deb13ae780a25d delete();
      }
    }
  }
}

function getpreferredweapon() {
  if(self._blackboard.weaponrequest == weaponclass(self.primaryweapon)) {
    return self.primaryweapon;
  } else if(self._blackboard.weaponrequest == weaponclass(self.secondaryweapon)) {
    return self.secondaryweapon;
  }

  return self.primaryweapon;
}

function notetrackguntochest(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "\xd8\r\xb2\x9b\x1d");
  }
}

function notetrackguntoback(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "\x8a+\xf04");
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackpistolpickup(note, flagname) {
  pistolposition = "o0\xee\xc1\x8c";

  if(!isDefined(self.sidearm) || isnullweapon(self.sidearm) || self.weapon == self.sidearm && isDefined(self.a.weaponpos[pistolposition]) && self.a.weaponpos[pistolposition] == self.weapon) {
    return;
  }

  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.sidearm, pistolposition);
  }

  if(isDefined(self.stowsidearmposition)) {
    self.a.weaponpos[self.stowsidearmposition] = undefined;
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("\xe5\x06\xb0\bE\x16<\xba\xb3\xc3\x96]\x1e9!\xf7[#");
}

function notetrackpistolputaway(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    if(isDefined(self.stowsidearmposition)) {
      self[[self.fnplaceweaponon]](self.sidearm, self.stowsidearmposition);
    } else {
      self[[self.fnplaceweaponon]](self.sidearm, "\r+x5");
    }
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function function_19188ae9ac8c7e8f(note, flagname) {
  pistolposition = "o0\xee\xc1\x8c";
  assert(isDefined(self.secondaryweapon));

  if(!isDefined(self.secondaryweapon) || isnullweapon(self.secondaryweapon) || self.weapon == self.secondaryweapon && isDefined(self.a.weaponpos[pistolposition]) && self.a.weaponpos[pistolposition] == self.secondaryweapon) {
    return;
  }

  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.secondaryweapon, pistolposition);
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("\xe5\x06\xb0\bE\x16<\xba\xb3\xc3\x96]\x1e9!\xf7[#");
}

function function_9ff4418a01fd0ae0(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    if(isDefined(self.var_8ee540b72602494)) {
      self[[self.fnplaceweaponon]](self.secondaryweapon, self.var_8ee540b72602494);
    } else {
      self[[self.fnplaceweaponon]](self.secondaryweapon, "\r+x5");
    }
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackguntoright(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "o0\xee\xc1\x8c");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
}

function function_ac723cdd5ddb4b93(note, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "\xf3\xc4\xbe\x92\xef\x84");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackhton0(note, flagname) {
  if(!isai(self)) {
    return;
  }
}

function notetrackhton1(note, flagname) {
  if(!isai(self)) {
    return;
  }
}

function notetrackhtoff(note, flagname) {
  if(!isai(self)) {
    return;
  }
}

function function_4ad08fff6ee80c9e(note, flagname) {
  if(isai(self)) {
    self setlookatstate("\xf7x\xb7\xf3\xdf\xf3\x13");

    if(utility::issp()) {
      self setlookatplayer(level.player);
    }
  }
}

function function_5b216536d0d4e9f2(note, flagname) {
  if(isai(self)) {
    self setlookatstate("\xf7x\xb7\xf3\xdf\xf3\x13");
    self setlookatpos();
  }
}

function function_276055623dff55fa(note, flagname) {
  if(isai(self)) {
    self setlookatstate("Y\xd5\x8e\r7$\xfc5");
    self setlookatentity();
  }
}

function function_b72d7596e1a219fb(note, flagname) {
  if(isai(self)) {
    self asmfireevent(self.asmname, note);
  }
}

function function_6291b3a3d9aae417(note, flagname) {
  if(isDefined(self.var_42b8323e845b6f1d)) {
    return [[self.var_42b8323e845b6f1d]](note, flagname);
  }
}

function function_c3dbb684647b38e8(var_60e746fa8a3c2508) {
  info = strtok(var_60e746fa8a3c2508, "\x16", 1);
  model = info[0];
  tag = info[1];
  boolstring = info[2];
  var_cb9f33cb96298704 = info[3];
  var_cd19c8bf36181cf3 = info[4];
  var_73053e2efe050f36 = info[5];
  var_f83d4c0846ecd114 = info[6];
  var_f663e87d6c4c1219 = info[7];
  var_9d1672888b78d80b = info[8];

  if(!isDefined(model)) {
    return [undefined, undefined, undefined, undefined, undefined];
  }

  if(isDefined(level.fnnotetrackmodeltranslate)) {
    model = [[level.fnnotetrackmodeltranslate]](model);
  }

  if(isDefined(model)) {
    model = cleanup_string(model);
  }

  if(isDefined(tag)) {
    tag = cleanup_string(tag);
  }

  var_b4ac6e26cef60eb6 = function_b56b2822e669b396(boolstring);
  offs_pos = function_42fb3500f47f31c0(var_cb9f33cb96298704, var_cd19c8bf36181cf3, var_73053e2efe050f36);
  offs_ang = function_42fb3500f47f31c0(var_f83d4c0846ecd114, var_f663e87d6c4c1219, var_9d1672888b78d80b);

  if(!isDefined(tag) || tag == "") {
    tag = "";
  } else if(isent(self) && !self tagexists(tag)) {
    assertmsg("<dev string:x18a>" + var_60e746fa8a3c2508 + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x37e>" + tag + "<dev string:x397>");
    return undefined;
  }

  if(!isDefined(model)) {
    assertmsg("<dev string:x18a>" + var_60e746fa8a3c2508 + "<dev string:x19b>" + debug::function_b1e5617ba9e542b(self) + "<dev string:x3d6>");
    return undefined;
  }

  return [model, tag, var_b4ac6e26cef60eb6, offs_pos, offs_ang];
}

function function_f31621facb3d11ad(attachinfo) {
  [model, tag, var_b4ac6e26cef60eb6] = function_c3dbb684647b38e8(attachinfo);

  if(isDefined(self.notetrackattach) && isDefined(self.notetrackattach[tag])) {
    function_ef089e6171f81bc8(tag);
  }

  if(model != "\r+x5" && model != "") {
    self attach(model, tag, 1);
    self.notetrackattach[tag] = model;
    self.var_19a051898a867387[tag] = var_b4ac6e26cef60eb6;
  }
}

function function_5182a7d4e8b80220(attachinfo) {
  [model, tag, var_b4ac6e26cef60eb6, offs_org, offs_ang] = function_c3dbb684647b38e8(attachinfo);

  if(isDefined(self.var_8f6309d28b2e71aa) && isDefined(self.var_8f6309d28b2e71aa[tag])) {
    function_68b96bc9c1b2b525(tag);
  }

  spawned = undefined;

  if(model != "\r+x5" && model != "") {
    spawned = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
    spawned setModel(model);

    if(!isDefined(offs_org)) {
      offs_org = (0, 0, 0);
    }

    if(!isDefined(offs_ang)) {
      offs_ang = (0, 0, 0);
    }

    tagactual = tag;

    if(tagactual == "") {
      tagactual = spawned function_b33afc5e24ff3bf6(0);

      if(!self tagexists(tagactual)) {
        tagactual = self function_b33afc5e24ff3bf6(0);
      }
    }

    spawned linkTo(self, tagactual, offs_org, offs_ang);
    self.var_8f6309d28b2e71aa[tag] = spawned;
    self.var_8431f4ccff37a749[tag] = var_b4ac6e26cef60eb6;
    utility::script_func("6\x95\xf6\xec\xcf\x05\x92\xce\xe7\x96$Y\x01\x05\xd8\b\xdc\xf4>g5\x8ca\xe3\x1b\xde@\x9b", spawned);
  }

  return spawned;
}

function function_919d2382b32b15c7(attachinfo) {
  [model, tag] = function_c3dbb684647b38e8(attachinfo);

  if(isDefined(self.notetrackattach) && isDefined(self.notetrackattach[tag])) {
    function_ef089e6171f81bc8(tag);
    return;
  }

  self detach(model, tag);
}

function private function_ef089e6171f81bc8(tag) {
  self detach(self.notetrackattach[tag], tag);
  self.notetrackattach[tag] = undefined;
  self.var_19a051898a867387[tag] = undefined;
}

function function_412669e114549b8f(attachinfo) {
  [model, tag] = function_c3dbb684647b38e8(attachinfo);

  if(isDefined(self.var_8f6309d28b2e71aa) && isDefined(self.var_8f6309d28b2e71aa[tag])) {
    function_68b96bc9c1b2b525(tag);
    return;
  }

  children = self getlinkedchildren();

  foreach(child in children) {
    if(isDefined(child.model) && child.model == model) {
      child delete();
    }
  }
}

function private function_68b96bc9c1b2b525(tag) {
  self.var_8f6309d28b2e71aa[tag] delete();
  self.var_8f6309d28b2e71aa[tag] = undefined;
  self.var_8431f4ccff37a749[tag] = undefined;
}

function function_82104525d00a39cb(attachinfo) {
  [modelname, tag] = function_c3dbb684647b38e8(attachinfo);
  model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self gettagorigin(tag));
  model.angles = self gettagangles(tag);
  model setModel(modelname);

  if(!isDefined(self.var_5a432bcc2e918675)) {
    self.var_5a432bcc2e918675 = [];
  }

  self.var_5a432bcc2e918675[self.var_5a432bcc2e918675.size] = model;
  function_919d2382b32b15c7(attachinfo);
}

function function_198475d7ea0d03a3(info) {
  info = strtok(info, "\x16");
  tag = info[0];
  index = self.var_5a432bcc2e918675.size - 1;
  ent = self.var_5a432bcc2e918675[index];
  self.var_5a432bcc2e918675[index] = undefined;
  self attach(ent.model, tag, 1);
  self.notetrackattach[tag] = ent.model;
  ent delete();
}

function function_89223e3577ffe6f0(var_6274046f2ebdec82) {
  if(isDefined(self.notetrackattach)) {
    tags = getarraykeys(self.notetrackattach);

    foreach(tag in tags) {
      if(!istrue(var_6274046f2ebdec82) || istrue(self.var_19a051898a867387[tag])) {
        function_ef089e6171f81bc8(tag);
      }
    }

    if(self.notetrackattach.size == 0) {
      self.notetrackattach = undefined;
      self.var_19a051898a867387 = undefined;
    }
  }
}

function function_14a1aaadb8aff4a8(var_6274046f2ebdec82) {
  if(isDefined(self.var_8f6309d28b2e71aa)) {
    tags = getarraykeys(self.var_8f6309d28b2e71aa);

    foreach(tag in tags) {
      if(!istrue(var_6274046f2ebdec82) || istrue(self.var_8431f4ccff37a749[tag])) {
        function_68b96bc9c1b2b525(tag);
      }
    }

    if(self.var_8f6309d28b2e71aa.size == 0) {
      self.var_8f6309d28b2e71aa = undefined;
      self.var_8431f4ccff37a749 = undefined;
    }
  }
}

function function_e61646a657c2ffe4(note) {
  function_89223e3577ffe6f0(1);
  function_14a1aaadb8aff4a8(1);
}

function function_d24a5e76bf65ddf4(var_bcc2bd6eae0bc869, var_1b5b15c9d105e99d, var_c627bec3e47af84e) {
  if(isDefined(var_bcc2bd6eae0bc869)) {
    fadetoblack(var_bcc2bd6eae0bc869);
  }

  if(isDefined(var_1b5b15c9d105e99d)) {
    wait var_1b5b15c9d105e99d;
  }

  if(isDefined(var_c627bec3e47af84e)) {
    fadefromblack(var_c627bec3e47af84e);
  }
}

function fadetoblack(fadetime) {
  self notify("R\xaa{p:b\xf3 J\x16%\xeeq\x7fI-\xa3\"");
  self notify("\x94\x0eP\xc5\x9c\x83}w\"\xf3s[\xf5_2d");
  self endon("\x94\x0eP\xc5\x9c\x83}w\"\xf3s[\xf5_2d");

  if(!isDefined(self.var_60ea8abd17f6e3cc)) {
    self.var_60ea8abd17f6e3cc = newclienthudelem(self);
    self.var_60ea8abd17f6e3cc setshader("\x8a-\v\xa1\xbd", 640, 480);
    self.var_60ea8abd17f6e3cc.sort = 1;
    self.var_60ea8abd17f6e3cc.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    self.var_60ea8abd17f6e3cc.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    self.var_60ea8abd17f6e3cc.foreground = 1;
  }

  if(fadetime > 0) {
    self.var_60ea8abd17f6e3cc.alpha = 0;
    self.var_60ea8abd17f6e3cc fadeovertime(fadetime);
  }

  self.var_60ea8abd17f6e3cc.alpha = 1;
  wait fadetime;
}

function fadefromblack(fadetime) {
  self notify("R\xaa{p:b\xf3 J\x16%\xeeq\x7fI-\xa3\"");
  self notify("\x94\x0eP\xc5\x9c\x83}w\"\xf3s[\xf5_2d");
  self endon("R\xaa{p:b\xf3 J\x16%\xeeq\x7fI-\xa3\"");

  if(!isDefined(self.var_60ea8abd17f6e3cc)) {
    self.var_60ea8abd17f6e3cc = newclienthudelem(self);
    self.var_60ea8abd17f6e3cc setshader("\x8a-\v\xa1\xbd", 640, 480);
    self.var_60ea8abd17f6e3cc.sort = 1;
    self.var_60ea8abd17f6e3cc.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    self.var_60ea8abd17f6e3cc.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
    self.var_60ea8abd17f6e3cc.foreground = 1;
  }

  if(fadetime > 0) {
    self.var_60ea8abd17f6e3cc.alpha = 1;
    self.var_60ea8abd17f6e3cc fadeovertime(fadetime);
  }

  self.var_60ea8abd17f6e3cc.alpha = 0;
  wait fadetime;
  self.var_60ea8abd17f6e3cc destroy();
}

function function_9b9c40a6624e6197(numberstring) {
  if(isDefined(numberstring)) {
    numberstring = cleanup_string(numberstring);

    if(isstartstr(numberstring, "\xf3\xad\x10\xcc\xb5")) {
      return undefined;
    }

    time = float(numberstring);
    magic_time = utility::function_9d840719e46c2b09(time);
    return magic_time;
  }

  return undefined;
}

function function_b56b2822e669b396(boolstring) {
  if(isDefined(boolstring)) {
    boolstring = tolower(boolstring);

    if(issubstr(boolstring, "\xb7")) {
      return 0;
    } else if(issubstr(boolstring, "\xbe")) {
      return 1;
    }
  }

  return undefined;
}

function function_42fb3500f47f31c0(stringx, stringy, stringz) {
  if(isDefined(stringy) && isDefined(stringx) && isDefined(stringz)) {
    vector = (float(stringx), float(stringy), float(stringz));
    return vector;
  }

  return undefined;
}

function cleanup_string(string) {
  string = tolower(string);
  len = string.size;

  if(isstartstr(string, "\xda") || isendstr(string, "\xda")) {
    [string] = strtok(string, "\xda");
  }

  return string;
}

function function_392b47556c2846fe(notetrack, note_prefix) {
  return getsubstr(notetrack, note_prefix.size);
}

function function_1e1c9872f59f63f6() {
  if(!utility::issp()) {
    return;
  }

  waittillframeend();

  if(!isDefined(level.scr_anim)) {
    return;
  }

  var_6c690a0e2f3e13fb[0] = "Uf\x04";
  var_6c690a0e2f3e13fb[1] = "\xe80\xdaX\x85p\xc3\xa8\xe5N";
  var_6c690a0e2f3e13fb[2] = "P\xce\xd3";
  var_6c690a0e2f3e13fb[3] = "0\x98\xe6";
  var_6c690a0e2f3e13fb[4] = "\x8b\r\xda\xf7\xfb\xc5v\xa7\xfb\xc8p-";
  var_40113c59f7d7a644[0] = "\xd5\xb9\xc2";
  var_40113c59f7d7a644[1] = "7\xd0x\x14";
  var_40113c59f7d7a644[2] = "\xe4kn\xfa";
  prefix_array = utility::array_combine(var_6c690a0e2f3e13fb, var_40113c59f7d7a644);

  foreach(var_6eae9468340937d8 in level.scr_anim) {
    foreach(var_735f89a3ef88aa33 in var_6eae9468340937d8) {
      if(!isarray(var_735f89a3ef88aa33)) {
        var_735f89a3ef88aa33 = [var_735f89a3ef88aa33];
      }

      foreach(animation in var_735f89a3ef88aa33) {
        foreach(note_prefix in prefix_array) {
          if(!isanimation(animation)) {
            continue;
          }

          searchresults = getnotetracks(animation, note_prefix, 1);

          foreach(result in searchresults) {
            if(isstartstr(note_prefix, "{\x17")) {
              rumble = function_392b47556c2846fe(result["\xf4\x1f\x13\xee"], note_prefix);

              if(isDefined(rumble)) {
                precacherumble(rumble);
              }

              continue;
            }

            notetrack_substring = getsubstr(result["\xf4\x1f\x13\xee"], note_prefix.size);
            [model, tag] = function_c3dbb684647b38e8(notetrack_substring);

            if(isDefined(model)) {
              if(model != "\xc0\xc6J") {
                precachemodel(model);
              }
            }
          }
        }
      }
    }
  }
}