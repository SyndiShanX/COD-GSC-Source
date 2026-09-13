/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\notetrack.gsc
***********************************************/

_id_011F8C6D6F5BA948() {
  level thread _id_9CE792D127499205();
}

start_notetrack_wait(guy, _id_314C4455B996B224, anime, animname, animation) {
  guy notify("stop_sequencing_notetracks");
  thread notetrack_wait(guy, _id_314C4455B996B224, self, anime, animname, animation);
}

notetrack_wait(guy, msg, tag_entity, anime, _id_8E3B87ACAAD3DE58, animation) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");

  if(isDefined(tag_entity))
    _id_F20E2B3859E05E9F = tag_entity;
  else
    _id_F20E2B3859E05E9F = self;

  animname = undefined;

  if(isDefined(_id_8E3B87ACAAD3DE58))
    animname = _id_8E3B87ACAAD3DE58;
  else
    animname = guy.animname;

  _id_966821FC90C3CA9D = spawnStruct();
  _id_966821FC90C3CA9D.dialog = [];
  _id_484FDE7E47AF1F20 = [];

  if(isDefined(animname) && isDefined(level.scr_notetrack[animname]) && isDefined(anime)) {
    if(isDefined(level.scr_notetrack[animname][anime]))
      _id_484FDE7E47AF1F20[anime] = level.scr_notetrack[animname][anime];

    if(isDefined(level.scr_notetrack[animname]["any"]))
      _id_484FDE7E47AF1F20["any"] = level.scr_notetrack[animname]["any"];
  }

  foreach(_id_2C62C57192ED45CB, _ in _id_484FDE7E47AF1F20) {
    foreach(_id_039B955B6EA2A96E in level.scr_notetrack[animname][_id_2C62C57192ED45CB]) {
      foreach(scr_notetrack in _id_039B955B6EA2A96E) {
        if(isDefined(scr_notetrack["dialog"]))
          _id_966821FC90C3CA9D.dialog[scr_notetrack["dialog"]] = 1;
      }
    }
  }

  _id_1247CD0FBE324A41 = 0;
  _id_A5FB509F15A76960 = 0;

  for(;;) {
    _id_966821FC90C3CA9D.dialoguenotetrack = 0;
    notetrack = undefined;

    if(!_id_1247CD0FBE324A41 && isDefined(animname) && isDefined(anime)) {
      _id_1247CD0FBE324A41 = 1;
      _id_95EFB52EE0303F87 = undefined;
      _id_A5FB509F15A76960 = isDefined(level.scr_notetrack[animname]) && isDefined(level.scr_notetrack[animname][anime]) && isDefined(level.scr_notetrack[animname][anime]["start"]);

      if(!_id_A5FB509F15A76960) {
        continue;
      }
      notetracks = ["start"];
    } else
      guy waittill(msg, notetracks);

    if(!isarray(notetracks))
      notetracks = [notetracks];

    guy printnotetracks(notetracks);
    validatenotetracks(msg, notetracks, animation);
    end = undefined;

    foreach(_id_A234A65C378F3289 in notetracks) {
      notetrack_handler(guy, anime, _id_A234A65C378F3289, animname, _id_484FDE7E47AF1F20, _id_F20E2B3859E05E9F, _id_966821FC90C3CA9D);

      if(_id_A234A65C378F3289 == "end")
        end = 1;
    }

    if(isDefined(end)) {
      break;
    }
  }
}

_id_E2BC0C9E826CF659() {
  thread _id_392D5E426B4896D2();
}

_id_392D5E426B4896D2() {
  self endon("entitydeleted");
  _id_3257C8F346FF26D3 = "scriptable";

  for(;;) {
    self waittill(_id_3257C8F346FF26D3, notetracks);
    printnotetracks(notetracks);
    validatenotetracks(_id_3257C8F346FF26D3, notetracks);
    end = undefined;

    foreach(_id_A234A65C378F3289 in notetracks) {
      notetrack_handler(self, undefined, _id_A234A65C378F3289);

      if(_id_A234A65C378F3289 == "end")
        end = 1;
    }

    if(isDefined(end)) {
      break;
    }
  }
}

notetrack_handler(guy, anime, notetrack, animname, _id_484FDE7E47AF1F20, _id_F20E2B3859E05E9F, _id_966821FC90C3CA9D) {
  if(notetrack == "end")
    return 1;

  if(isDefined(_id_484FDE7E47AF1F20)) {
    foreach(_id_2C62C57192ED45CB, _ in _id_484FDE7E47AF1F20) {
      if(isDefined(level.scr_notetrack[animname][_id_2C62C57192ED45CB][notetrack])) {
        foreach(scr_notetrack in level.scr_notetrack[animname][_id_2C62C57192ED45CB][notetrack])[[anim.callbacks["AnimHandleNotetrack"]]](scr_notetrack, guy, _id_966821FC90C3CA9D, _id_F20E2B3859E05E9F);
      }
    }
  }

  if(isDefined(anim.callbacks["EntityHandleNotetrack"]))
    [[anim.callbacks["EntityHandleNotetrack"]]](guy, notetrack);
}

anim_handle_notetrack(scr_notetrack, guy, _id_966821FC90C3CA9D, _id_F20E2B3859E05E9F) {
  if(isDefined(scr_notetrack["function"]))
    self thread[[scr_notetrack["function"]]](guy);

  if(isDefined(scr_notetrack["notify"]))
    level notify(scr_notetrack["notify"]);

  if(isDefined(scr_notetrack["attach model"])) {
    if(isDefined(scr_notetrack["selftag"]))
      guy attach(scr_notetrack["attach model"], scr_notetrack["selftag"]);
    else
      _id_F20E2B3859E05E9F attach(scr_notetrack["attach model"], scr_notetrack["tag"]);

    return;
  }

  if(isDefined(scr_notetrack["detach model"])) {
    if(isDefined(scr_notetrack["selftag"]))
      guy detach(scr_notetrack["detach model"], scr_notetrack["selftag"]);
    else
      _id_F20E2B3859E05E9F detach(scr_notetrack["detach model"], scr_notetrack["tag"]);
  }

  if(!_id_966821FC90C3CA9D.dialoguenotetrack) {
    if(isDefined(scr_notetrack["dialog"]) && isDefined(_id_966821FC90C3CA9D.dialog[scr_notetrack["dialog"]])) {
      guy _id_4ADE3AE5C138C8B3::sayspecificdialogue(scr_notetrack["dialog"]);
      _id_966821FC90C3CA9D.dialog[scr_notetrack["dialog"]] = undefined;
      _id_966821FC90C3CA9D.dialoguenotetrack = 1;
    }
  }

  if(isDefined(scr_notetrack["create model"]))
    anim_addmodel(guy, scr_notetrack);
  else if(isDefined(scr_notetrack["delete model"]))
    anim_removemodel(guy, scr_notetrack);

  if(isDefined(scr_notetrack["selftag"])) {
    if(isDefined(scr_notetrack["effect"]))
      level thread notetrack_effect(guy, scr_notetrack);

    if(isDefined(scr_notetrack["stop_effect"]))
      stopFXOnTag(level._effect[scr_notetrack["stop_effect"]], guy, scr_notetrack["selftag"]);

    if(isDefined(scr_notetrack["swap_part_to_efx"])) {
      playFXOnTag(level._effect[scr_notetrack["swap_part_to_efx"]], guy, scr_notetrack["selftag"]);
      guy hidepart(scr_notetrack["selftag"]);
    }

    if(isDefined(scr_notetrack["trace_part_for_efx"])) {
      _id_BB4A24ED17627810 = undefined;
      effect = scripts\engine\utility::getfx(scr_notetrack["trace_part_for_efx"]);

      if(isDefined(scr_notetrack["trace_part_for_efx_water"]))
        _id_BB4A24ED17627810 = scripts\engine\utility::getfx(scr_notetrack["trace_part_for_efx_water"]);

      _id_8ADA18B58BD64E3F = 0;

      if(isDefined(scr_notetrack["trace_part_for_efx_delete_depth"]))
        _id_8ADA18B58BD64E3F = scr_notetrack["trace_part_for_efx_delete_depth"];

      guy thread trace_part_for_efx(scr_notetrack["selftag"], effect, _id_BB4A24ED17627810, _id_8ADA18B58BD64E3F);
    }

    if(isDefined(scr_notetrack["trace_part_for_efx_canceling"]))
      guy thread trace_part_for_efx_cancel(scr_notetrack["selftag"]);
  }

  if(isDefined(scr_notetrack["tag"]) && isDefined(scr_notetrack["effect"]))
    playFXOnTag(level._effect[scr_notetrack["effect"]], _id_F20E2B3859E05E9F, scr_notetrack["tag"]);

  if(isDefined(scr_notetrack["selftag"]) && isDefined(scr_notetrack["effect_looped"]))
    playFXOnTag(level._effect[scr_notetrack["effect_looped"]], guy, scr_notetrack["selftag"]);
}

anim_addmodel(guy, array) {
  if(!isDefined(guy.scriptmodel))
    guy.scriptmodel = [];

  index = guy.scriptmodel.size;
  guy.scriptmodel[index] = spawn("script_model", (0, 0, 0));
  guy.scriptmodel[index] setModel(array["create model"]);
  guy.scriptmodel[index].origin = guy gettagorigin(array["selftag"]);
  guy.scriptmodel[index].angles = guy gettagangles(array["selftag"]);
}

anim_removemodel(guy, array) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guy.scriptmodel.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(array["explosion"])) {
      forward = anglesToForward(guy.scriptmodel[_id_AC0E594AC96AA3A8].angles);
      forward = forward * 120;
      forward = forward + guy.scriptmodel[_id_AC0E594AC96AA3A8].origin;
      playFX(level._effect[array["explosion"]], guy.scriptmodel[_id_AC0E594AC96AA3A8].origin);
      radiusdamage(guy.scriptmodel[_id_AC0E594AC96AA3A8].origin, 350, 700, 50);
    }

    guy.scriptmodel[_id_AC0E594AC96AA3A8] delete();
  }
}

notetrack_effect(guy, scr_notetrack) {
  _id_863C90262C71C1B7 = isDefined(scr_notetrack["moreThanThreeHack"]);

  if(_id_863C90262C71C1B7)
    scripts\engine\utility::lock("moreThanThreeHack");

  playFXOnTag(level._effect[scr_notetrack["effect"]], guy, scr_notetrack["selftag"]);

  if(_id_863C90262C71C1B7)
    scripts\engine\utility::unlock("moreThanThreeHack");
}

trace_part_for_efx_cancel(part) {
  self notify("cancel_trace_for_part_" + part);
}

trace_part_for_efx(part, effect, _id_BB4A24ED17627810, _id_420B93892AD918C4) {
  _id_21BE60CD60D4A696 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + part);
  last_pos = self gettagorigin(part);
  hit_water = 0;
  struct = spawnStruct();
  struct.last_pos = self gettagorigin(part);
  struct.hit_surface = 0;
  struct.part = part;
  struct.hit_water = 0;
  struct.effect = effect;
  struct.stationary = 0;
  struct.last_motion_time = gettime();

  while(isDefined(self) && !struct.hit_surface) {
    scripts\engine\utility::lock(_id_21BE60CD60D4A696);
    test_trace_tag(struct);
    scripts\engine\utility::unlock_wait(_id_21BE60CD60D4A696);

    if(struct.stationary == 1 && gettime() - struct.last_motion_time > 3000)
      return;
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(_id_BB4A24ED17627810) && struct.hit_water)
    effect = _id_BB4A24ED17627810;

  playFX(effect, struct.last_pos);

  if(_id_420B93892AD918C4 == 0)
    self hidepart(part);
  else
    thread hidepartatdepth(struct.last_pos[2] - _id_420B93892AD918C4, part);
}

hidepartatdepth(_id_FBEA67E67B07F196, part) {
  self endon("entitydeleted");

  while(self gettagorigin(part)[2] > _id_FBEA67E67B07F196)
    wait 0.05;

  self hidepart(part);
}

test_trace_tag(struct) {
  _id_E493C57DBE9B82EA = undefined;

  if(!isDefined(self)) {
    return;
  }
  struct.current_pos = self gettagorigin(struct.part);

  if(struct.current_pos != struct.last_pos) {
    struct.last_motion_time = gettime();
    struct.stationary = 0;

    if(!scripts\engine\trace::_bullet_trace_passed(struct.last_pos, struct.current_pos, 0, self)) {
      trace = scripts\engine\trace::_bullet_trace(struct.last_pos, struct.current_pos, 0, self);

      if(trace["fraction"] < 1.0) {
        struct.last_pos = trace["position"];
        struct.hit_water = trace["surfacetype"] == "water";
        struct.hit_surface = 1;
        return;
      } else {}
    }
  } else
    struct.stationary = 1;

  struct.last_pos = struct.current_pos;
}

_add_z(_id_06A3A1033FFC2699, _id_541DA76E22452661) {
  return (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], _id_06A3A1033FFC2699[2] + _id_541DA76E22452661);
}

validatenotetracks(flagname, notes, animation) {}

printnotetracks(notes) {}

animsound_start_tracker(anime, animname) {
  add_to_animsound();
  _id_B0CC5E81B9B00CDC = spawnStruct();
  _id_B0CC5E81B9B00CDC.anime = anime;
  _id_B0CC5E81B9B00CDC.notetrack = "#" + anime;
  _id_B0CC5E81B9B00CDC.animname = animname;
  _id_B0CC5E81B9B00CDC.end_time = gettime() + 60000;

  if(animsound_exists(anime, _id_B0CC5E81B9B00CDC.notetrack)) {
    return;
  }
  add_animsound(_id_B0CC5E81B9B00CDC);
}

animsound_start_tracker_loop(anime, loop, animname) {
  add_to_animsound();
  anime = loop + anime;
  _id_B0CC5E81B9B00CDC = spawnStruct();
  _id_B0CC5E81B9B00CDC.anime = anime;
  _id_B0CC5E81B9B00CDC.notetrack = "#" + anime;
  _id_B0CC5E81B9B00CDC.animname = animname;
  _id_B0CC5E81B9B00CDC.end_time = gettime() + 60000;

  if(animsound_exists(anime, _id_B0CC5E81B9B00CDC.notetrack)) {
    return;
  }
  add_animsound(_id_B0CC5E81B9B00CDC);
}

animsound_tracker(anime, notetrack, animname) {
  notetrack = tolower(notetrack);
  add_to_animsound();

  if(notetrack == "end") {
    return;
  }
  if(animsound_exists(anime, notetrack)) {
    return;
  }
  _id_358F85058EBE3994 = spawnStruct();
  _id_358F85058EBE3994.anime = anime;
  _id_358F85058EBE3994.notetrack = notetrack;
  _id_358F85058EBE3994.animname = animname;
  _id_358F85058EBE3994.end_time = gettime() + 60000;
  add_animsound(_id_358F85058EBE3994);
}

animsound_exists(anime, notetrack) {
  notetrack = tolower(notetrack);
  keys = getarraykeys(self.animsounds);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    key = keys[_id_AC0E594AC96AA3A8];

    if(self.animsounds[key].anime != anime) {
      continue;
    }
    if(self.animsounds[key].notetrack != notetrack) {
      continue;
    }
    self.animsounds[key].end_time = gettime() + 60000;
    return 1;
  }

  return 0;
}

add_animsound(_id_B0CC5E81B9B00CDC) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.animsound_hudlimit; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.animsounds[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    self.animsounds[_id_AC0E594AC96AA3A8] = _id_B0CC5E81B9B00CDC;
    return;
  }

  keys = getarraykeys(self.animsounds);
  index = keys[0];
  timer = self.animsounds[index].end_time;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    key = keys[_id_AC0E594AC96AA3A8];

    if(self.animsounds[key].end_time < timer) {
      timer = self.animsounds[key].end_time;
      index = key;
    }
  }

  self.animsounds[index] = _id_B0CC5E81B9B00CDC;
}

add_to_animsound() {
  if(!isDefined(self.animsounds))
    self.animsounds = [];

  isinarray = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.animsounds.size; _id_AC0E594AC96AA3A8++) {
    if(self == level.animsounds[_id_AC0E594AC96AA3A8]) {
      isinarray = 1;
      break;
    }
  }

  if(!isinarray)
    level.animsounds[level.animsounds.size] = self;
}

_id_9CE792D127499205() {
  level endon("game_ended");

  for(;;) {
    _id_75B06ED286EE08E8 = [];
    self waittill("vm_sv_note", _id_75B06ED286EE08E8);

    if(_id_75B06ED286EE08E8.size > 0) {
      foreach(_id_0AF6D507D6183C7C in _id_75B06ED286EE08E8) {
        if(_id_0AF6D507D6183C7C.size > 0) {
          _id_2EB9987D197DE143 = _id_0AF6D507D6183C7C[1];
          _id_C08639C41DC7EEB6 = anim.notetracks[_id_2EB9987D197DE143];

          if(isDefined(_id_C08639C41DC7EEB6))
            [[_id_C08639C41DC7EEB6]](_id_2EB9987D197DE143, undefined, _id_0AF6D507D6183C7C);
        }
      }
    }
  }
}