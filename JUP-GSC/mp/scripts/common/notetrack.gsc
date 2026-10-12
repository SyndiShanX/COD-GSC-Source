/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\notetrack.gsc
***********************************************/

#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace notetrack;

function function_11f8c6d6f5ba948() {
  level thread function_9ce792d127499205();
}

function agent_notetrack_redirect(guy, msg) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");
  guy endon("stop_agent_notetrack_redirect");

  while(true) {
    self waittill("animscripted", notetracks);
    self notify(msg, notetracks);

    foreach(note in notetracks) {
      if(note == "end") {
        return;
      }
    }
  }
}

function start_notetrack_wait(guy, anim_string, anime, animname, animation, var_173bdb8ba434651d) {
  guy notify("stop_sequencing_notetracks");
  thread notetrack_wait(guy, anim_string, self, anime, animname, animation, var_173bdb8ba434651d);
}

function notetrack_wait(guy, msg, tag_entity, anime, animname_override, animation, var_173bdb8ba434651d) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");

  if(istrue(var_173bdb8ba434651d)) {
    thread agent_notetrack_redirect(guy, msg);
  }

  if(isDefined(tag_entity)) {
    tag_owner = tag_entity;
  } else {
    tag_owner = self;
  }

  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }

  dialogue_array = spawnStruct();
  dialogue_array.dialog = [];
  scripted_notetracks = [];

  if(isDefined(animname) && isDefined(level.scr_notetrack[animname]) && isDefined(anime)) {
    if(isDefined(level.scr_notetrack[animname][anime])) {
      scripted_notetracks[anime] = level.scr_notetrack[animname][anime];
    }

    if(isDefined(level.scr_notetrack[animname]["any"])) {
      scripted_notetracks["any"] = level.scr_notetrack[animname]["any"];
    }
  }

  foreach(anime_key, _ in scripted_notetracks) {
    foreach(notetrack_array in level.scr_notetrack[animname][anime_key]) {
      foreach(scr_notetrack in notetrack_array) {
        if(isDefined(scr_notetrack["dialog"])) {
          dialogue_array.dialog[scr_notetrack["dialog"]] = 1;
        }
      }
    }
  }

  var_1247cd0fbe324a41 = 0;
  var_a5fb509f15a76960 = 0;

  while(true) {
    dialogue_array.dialoguenotetrack = 0;
    notetrack = undefined;

    if(!var_1247cd0fbe324a41 && isDefined(animname) && isDefined(anime)) {
      var_1247cd0fbe324a41 = 1;
      start_notetrack = undefined;
      var_a5fb509f15a76960 = isDefined(level.scr_notetrack[animname]) && isDefined(level.scr_notetrack[animname][anime]) && isDefined(level.scr_notetrack[animname][anime]["start"]);

      if(!var_a5fb509f15a76960) {
        continue;
      }

      notetracks = ["start"];
    } else {
      guy waittill(msg, notetracks);
    }

    if(!isarray(notetracks)) {
      notetracks = [notetracks];
    }

    guy printnotetracks(notetracks);
    validatenotetracks(msg, notetracks, animation);
    end = undefined;

    foreach(note in notetracks) {
      notetrack_handler(guy, anime, note, animname, scripted_notetracks, tag_owner, dialogue_array);

      if(note == "end") {
        end = 1;
      }
    }

    if(isDefined(end)) {
      break;
    }
  }

  if(istrue(var_173bdb8ba434651d)) {
    guy notify("stop_agent_notetrack_redirect");
  }
}

function function_e2bc0c9e826cf659() {
  thread function_392d5e426b4896d2();
}

function function_392d5e426b4896d2() {
  self endon("entitydeleted");
  noteflag = "scriptable";

  while(true) {
    self waittill(noteflag, notetracks);
    printnotetracks(notetracks);
    validatenotetracks(noteflag, notetracks);
    end = undefined;

    foreach(note in notetracks) {
      notetrack_handler(self, undefined, note);

      if(note == "end") {
        end = 1;
      }
    }

    if(isDefined(end)) {
      break;
    }
  }
}

function notetrack_handler(guy, anime, notetrack, animname, scripted_notetracks, tag_owner, dialogue_array) {
  if(getDvar(@ "animsound") == "<dev string:x1c>") {
    guy thread animsound_tracker(anime, notetrack, animname);
  }

  if(notetrack == "end") {
    if(isDefined(anim.callbacks["EntityHandleNotetrackAnimEnd"])) {
      [[anim.callbacks["EntityHandleNotetrackAnimEnd"]]](guy, notetrack);
    }

    return 1;
  }

  if(isDefined(scripted_notetracks)) {
    foreach(anime_key, _ in scripted_notetracks) {
      if(isDefined(level.scr_notetrack[animname][anime_key][notetrack])) {
        foreach(scr_notetrack in level.scr_notetrack[animname][anime_key][notetrack]) {
          [[anim.callbacks["AnimHandleNotetrack"]]](scr_notetrack, guy, dialogue_array, tag_owner);
        }
      }
    }
  }

  if(isDefined(anim.callbacks["EntityHandleNotetrack"])) {
    [[anim.callbacks["EntityHandleNotetrack"]]](guy, notetrack);
  }
}

function anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner) {
  if(isDefined(scr_notetrack["function"])) {
    self thread[[scr_notetrack["function"]]](guy);
  }

  if(isDefined(scr_notetrack["notify"])) {
    level notify(scr_notetrack["notify"]);
  }

  if(isDefined(scr_notetrack["attach model"])) {
    if(isDefined(scr_notetrack["selftag"])) {
      guy attach(scr_notetrack["attach model"], scr_notetrack["selftag"]);
      return;
    }

    tag_owner attach(scr_notetrack["attach model"], scr_notetrack["tag"]);
    return;
  }

  if(isDefined(scr_notetrack["detach model"])) {
    if(isDefined(scr_notetrack["selftag"])) {
      guy detach(scr_notetrack["detach model"], scr_notetrack["selftag"]);
    } else {
      tag_owner detach(scr_notetrack["detach model"], scr_notetrack["tag"]);
    }
  }

  if(!dialogue_array.dialoguenotetrack) {
    if(isDefined(scr_notetrack["dialog"]) && isDefined(dialogue_array.dialog[scr_notetrack["dialog"]])) {
      guy sayspecificdialogue(scr_notetrack["dialog"]);
      dialogue_array.dialog[scr_notetrack["dialog"]] = undefined;
      dialogue_array.dialoguenotetrack = 1;
    }
  }

  if(isDefined(scr_notetrack["create model"])) {
    anim_addmodel(guy, scr_notetrack);
  } else if(isDefined(scr_notetrack["delete model"])) {
    anim_removemodel(guy, scr_notetrack);
  }

  if(isDefined(scr_notetrack["selftag"])) {
    if(isDefined(scr_notetrack["effect"])) {
      level thread notetrack_effect(guy, scr_notetrack);
    }

    if(isDefined(scr_notetrack["stop_effect"])) {
      stopFXOnTag(level._effect[scr_notetrack["stop_effect"]], guy, scr_notetrack["selftag"]);
    }

    if(isDefined(scr_notetrack["swap_part_to_efx"])) {
      playFXOnTag(level._effect[scr_notetrack["swap_part_to_efx"]], guy, scr_notetrack["selftag"]);
      guy hidepart(scr_notetrack["selftag"]);
    }

    if(isDefined(scr_notetrack["trace_part_for_efx"])) {
      water_effect = undefined;
      effect = getfx(scr_notetrack["trace_part_for_efx"]);

      if(isDefined(scr_notetrack["trace_part_for_efx_water"])) {
        water_effect = getfx(scr_notetrack["trace_part_for_efx_water"]);
      }

      deletedepth = 0;

      if(isDefined(scr_notetrack["trace_part_for_efx_delete_depth"])) {
        deletedepth = scr_notetrack["trace_part_for_efx_delete_depth"];
      }

      guy thread trace_part_for_efx(scr_notetrack["selftag"], effect, water_effect, deletedepth);
    }

    if(isDefined(scr_notetrack["trace_part_for_efx_canceling"])) {
      guy thread trace_part_for_efx_cancel(scr_notetrack["selftag"]);
    }
  }

  if(isDefined(scr_notetrack["tag"]) && isDefined(scr_notetrack["effect"])) {
    playFXOnTag(level._effect[scr_notetrack["effect"]], tag_owner, scr_notetrack["tag"]);
  }

  if(isDefined(scr_notetrack["selftag"]) && isDefined(scr_notetrack["effect_looped"])) {
    playFXOnTag(level._effect[scr_notetrack["effect_looped"]], guy, scr_notetrack["selftag"]);
  }
}

function anim_addmodel(guy, array) {
  if(!isDefined(guy.scriptmodel)) {
    guy.scriptmodel = [];
  }

  index = guy.scriptmodel.size;
  guy.scriptmodel[index] = spawn("script_model", (0, 0, 0));
  guy.scriptmodel[index] setModel(array["create model"]);
  guy.scriptmodel[index].origin = guy gettagorigin(array["selftag"]);
  guy.scriptmodel[index].angles = guy gettagangles(array["selftag"]);
}

function anim_removemodel(guy, array) {
  if(!isDefined(guy.scriptmodel)) {
    assertmsg("<dev string:x22>" + guy.animname);
  }

  for(i = 0; i < guy.scriptmodel.size; i++) {
    if(isDefined(array["explosion"])) {
      forward = anglesToForward(guy.scriptmodel[i].angles);
      forward *= 120;
      forward += guy.scriptmodel[i].origin;
      playFX(level._effect[array["explosion"]], guy.scriptmodel[i].origin);
      radiusdamage(guy.scriptmodel[i].origin, 350, 700, 50);
    }

    guy.scriptmodel[i] delete();
  }
}

function notetrack_effect(guy, scr_notetrack) {
  var_863c90262c71c1b7 = isDefined(scr_notetrack["moreThanThreeHack"]);

  if(var_863c90262c71c1b7) {
    lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[scr_notetrack["effect"]], guy, scr_notetrack["selftag"]);

  if(var_863c90262c71c1b7) {
    unlock("moreThanThreeHack");
  }
}

function trace_part_for_efx_cancel(part) {
  self notify("cancel_trace_for_part_" + part);
}

function trace_part_for_efx(part, effect, water_effect, delete_depth) {
  lock_string = "trace_part_for_efx";
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
    lock(lock_string);
    test_trace_tag(struct);
    unlock_wait(lock_string);

    if(struct.stationary == 1 && gettime() - struct.last_motion_time > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(water_effect) && struct.hit_water) {
    effect = water_effect;
  }

  playFX(effect, struct.last_pos);

  if(delete_depth == 0) {
    self hidepart(part);
    return;
  }

  thread hidepartatdepth(struct.last_pos[2] - delete_depth, part);
}

function hidepartatdepth(depth, part) {
  self endon("entitydeleted");

  while(self gettagorigin(part)[2] > depth) {
    wait 0.05;
  }

  self hidepart(part);
}

function test_trace_tag(struct) {
  linecolor = undefined;

  if(!isDefined(self)) {
    return;
  }

  struct.current_pos = self gettagorigin(struct.part);

  if(struct.current_pos != struct.last_pos) {
    struct.last_motion_time = gettime();
    struct.stationary = 0;

    linecolor = (1, 1, 1);

    if(!scripts\engine\trace::_bullet_trace_passed(struct.last_pos, struct.current_pos, 0, self)) {
      trace = scripts\engine\trace::_bullet_trace(struct.last_pos, struct.current_pos, 0, self);

      if(trace["fraction"] < 1) {
        linecolor = (1, 0, 0);

        struct.last_pos = trace["position"];
        struct.hit_water = trace["surfacetype"] == "water";

        if(getdvarint(@ "hash_b46df2b57cc019b") == 1) {
          stringname = "<dev string:x75>";

          foreach(key, value in level._effect) {
            if(struct.effect != value) {
              continue;
            }

            stringname = key;
            break;
          }

          print3d(_add_z(struct.last_pos, 6), "<dev string:x79>" + struct.part, (1, 1, 1), 1, 1, 100);
          print3d(struct.last_pos, "<dev string:x82>" + stringname, (1, 1, 1), 1, 1, 100);
        }

        struct.hit_surface = 1;
        return;
      } else {
        if(getdvarint(@ "hash_b46df2b57cc019b") == 1) {
          if(isDefined(trace["<dev string:x8e>"])) {
            print3d(_add_z(struct.last_pos, 6), "<dev string:x98>" + trace["<dev string:x8e>"].classname, (0, 0, 1), 1, 1, 100);
          }
        }

      }
    }

    if(getdvarint(@ "hash_b46df2b57cc019b") == 1) {
      line(struct.last_pos, struct.current_pos, linecolor, 1, 0, 60);
      sphere(struct.current_pos, 8, (0, 1, 0));
      print3d(_add_z(struct.last_pos, 6), struct.part, (0, 1, 0), 1, 1, 1);
    }
  } else {
    struct.stationary = 1;

    if(getdvarint(@ "hash_b46df2b57cc019b") == 1) {
      print3d(struct.current_pos, "<dev string:xa4>" + struct.part, (1, 0, 0));
    }
  }

  struct.last_pos = struct.current_pos;
}

function _add_z(vec, zplus) {
  return (vec[0], vec[1], vec[2] + zplus);
}

function validatenotetracks(flagname, notes, animation) {
  if(isDefined(animation)) {
    assertex(notes.size <= 4, "<dev string:xb6>" + notes.size + "<dev string:xcf>" + getxhashsourcename(getanimname(animation)));
  } else {
    assertex(notes.size <= 4, "<dev string:xb6>" + notes.size + "<dev string:x119>" + flagname + "<dev string:x16d>");
  }

  for(i = 0; i < notes.size; i++) {
    found = 0;

    for(j = i + 1; j < notes.size; j++) {
      if(notes[i] == notes[j]) {
        found = 1;

        if(isDefined(animation)) {
          println("<dev string:x172>" + getxhashsourcename(getanimname(animation)) + "<dev string:x18c>" + flagname + "<dev string:x1a1>" + notes[i] + "<dev string:x1c7>");
        } else {
          println("<dev string:x1cc>" + flagname + "<dev string:x1a1>" + notes[i] + "<dev string:x1c7>");
        }
      }

      if(found) {
        break;
      }
    }
  }

  notes = undefined;
}

function printnotetracks(notes) {
  if(getdvarint(@ "hash_a19781010239d2e6") != 1 && getdvarint(@ "hash_a19781010239d2e6") != self getentitynumber()) {
    return;
  }

  msg = notes[0];

  for(i = 1; i < notes.size; i++) {
    msg += "<dev string:x1f4>" + notes[i];
  }

  println("<dev string:x1fa>" + gettime() + "<dev string:x1ff>" + self getentitynumber() + "<dev string:x205>" + msg);
}

function animsound_start_tracker(anime, animname) {
  add_to_animsound();
  newsound = spawnStruct();
  newsound.anime = anime;
  newsound.notetrack = "#" + anime;
  newsound.animname = animname;
  newsound.end_time = gettime() + 60000;

  if(animsound_exists(anime, newsound.notetrack)) {
    return;
  }

  add_animsound(newsound);
}

function animsound_start_tracker_loop(anime, loop, animname) {
  add_to_animsound();
  anime = loop + anime;
  newsound = spawnStruct();
  newsound.anime = anime;
  newsound.notetrack = "#" + anime;
  newsound.animname = animname;
  newsound.end_time = gettime() + 60000;

  if(animsound_exists(anime, newsound.notetrack)) {
    return;
  }

  add_animsound(newsound);
}

function animsound_tracker(anime, notetrack, animname) {
  notetrack = tolower(notetrack);
  add_to_animsound();

  if(notetrack == "end") {
    return;
  }

  if(animsound_exists(anime, notetrack)) {
    return;
  }

  newtrack = spawnStruct();
  newtrack.anime = anime;
  newtrack.notetrack = notetrack;
  newtrack.animname = animname;
  newtrack.end_time = gettime() + 60000;
  add_animsound(newtrack);
}

function animsound_exists(anime, notetrack) {
  notetrack = tolower(notetrack);
  keys = getarraykeys(self.animsounds);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];

    if(self.animsounds[key].anime != anime) {
      continue;
    }

    if(self.animsounds[key].notetrack != notetrack) {
      continue;
    }

    self.animsounds[key].end_time = gettime() + 60000;
    return true;
  }

  return false;
}

function add_animsound(newsound) {
  for(i = 0; i < level.animsound_hudlimit; i++) {
    if(isDefined(self.animsounds[i])) {
      continue;
    }

    self.animsounds[i] = newsound;
    return;
  }

  keys = getarraykeys(self.animsounds);
  index = keys[0];
  timer = self.animsounds[index].end_time;

  for(i = 1; i < keys.size; i++) {
    key = keys[i];

    if(self.animsounds[key].end_time < timer) {
      timer = self.animsounds[key].end_time;
      index = key;
    }
  }

  self.animsounds[index] = newsound;
}

function add_to_animsound() {
  if(!isDefined(self.animsounds)) {
    self.animsounds = [];
  }

  isinarray = 0;

  for(i = 0; i < level.animsounds.size; i++) {
    if(self == level.animsounds[i]) {
      isinarray = 1;
      break;
    }
  }

  if(!isinarray) {
    level.animsounds[level.animsounds.size] = self;
  }
}

function function_9ce792d127499205() {
  level endon("game_ended");

  while(true) {
    vmnotetracks = [];
    self waittill("vm_sv_note", vmnotetracks);

    if(vmnotetracks.size > 0) {
      foreach(notetrackinfo in vmnotetracks) {
        if(notetrackinfo.size > 0) {
          notetrackname = notetrackinfo[1];
          notetrackfunc = anim.notetracks[notetrackname];

          if(isDefined(notetrackfunc)) {
            [[notetrackfunc]](notetrackname, undefined, notetrackinfo);
          }
        }
      }
    }
  }
}