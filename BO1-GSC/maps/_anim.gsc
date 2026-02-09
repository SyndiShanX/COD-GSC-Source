/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_anim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\shared;
#include animscripts\utility;
#include animscripts\face;

anim_reach(ents, scene, animname_override) {
  ents = build_ent_array(ents);
  do_anim_reach(ents, scene, undefined, animname_override, false);
}
anim_reach_aligned(ents, scene, tag, animname_override) {
  ents = build_ent_array(ents);
  do_anim_reach(ents, scene, tag, animname_override, true);
}
anim_generic_reach(ents, scene) {
  anim_reach(ents, scene, "generic");
}
anim_generic_reach_aligned(ents, scene, tag) {
  anim_reach_aligned(ents, scene, tag, "generic");
}
anim_reach_idle(guys, scene, idle) {
  guys = build_ent_array(guys);
  ent = spawnStruct();
  ent.count = guys.size;
  for(i = 0; i < guys.size; i++) {
    thread reach_idle(guys[i], scene, idle, ent);
  }
  while(ent.count) {
    ent waittill("reach_idle_goal");
  }
}
anim_teleport(ents, scene, tag, animname_override) {
  ents = build_ent_array(ents);
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  for(i = 0; i < ents.size; i++) {
    ent = ents[i];
    startorg = GetStartOrigin(org, angles, ent get_anim(scene, animname_override));
    if(IsSentient(ent)) {
      ent Teleport(startorg);
    } else {
      ent.origin = startorg;
    }
  }
}
anim_single(ents, scene, animname_override) {
  ents = build_ent_array(ents);
  do_anim_single(ents, scene, undefined, animname_override, false);
}
anim_single_aligned(ents, scene, tag, animname_override) {
  ents = build_ent_array(ents);
  do_anim_single(ents, scene, tag, animname_override, true);
}
anim_first_frame(ents, scene, tag, animname_override) {
  pos_array = get_anim_position(tag);
  org = pos_array["origin"];
  angles = pos_array["angles"];
  ents = build_ent_array(ents);
  array_levelthread(ents, ::anim_first_frame_on_guy, scene, org, angles, animname_override);
}
anim_generic(ents, scene) {
  anim_single(ents, scene, "generic");
}
anim_generic_aligned(ents, scene, tag) {
  anim_single_aligned(ents, scene, tag, "generic");
}
anim_loop(ents, scene, ender, animname_override) {
  ents = build_ent_array(ents);
  guyPackets = [];
  for(i = 0; i < ents.size; i++) {
    packet = [];
    packet["guy"] = ents[i];
    packet["entity"] = packet["guy"];
    guyPackets[guyPackets.size] = packet;
  }
  anim_loop_packet(guyPackets, scene, ender, animname_override);
}
anim_generic_loop(ents, scene, ender) {
  anim_loop(ents, scene, ender, "generic");
}
anim_loop_aligned(ents, scene, tag, ender, animname_override) {
  ents = build_ent_array(ents);
  guyPackets = [];
  for(i = 0; i < ents.size; i++) {
    packet = [];
    packet["guy"] = ents[i];
    packet["entity"] = self;
    packet["tag"] = tag;
    guyPackets[guyPackets.size] = packet;
  }
  Assert(isDefined(self.angles), "Alignment node does not have angles specified.");
  anim_loop_packet(guyPackets, scene, ender, animname_override);
}
anim_generic_loop_aligned(ents, scene, tag, ender) {
  anim_loop_aligned(ents, scene, tag, ender, "generic");
}
anim_custom_animmode(ents, custom_animmode, scene, tag, animname_override) {
  ents = build_ent_array(ents);
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  for(i = 0; i < ents.size; i++) {
    thread anim_custom_animmode_on_guy(ents[i], custom_animmode, scene, org, angles, animname_override);
  }
  assertex(isDefined(ents[0]), "anim_custom_animmode called without a guy in the array");
  ents[0] wait_until_anim_finishes(scene);
  self notify(scene);
}
anim_generic_custom_animmode(ents, custom_animmode, scene, tag) {
  anim_custom_animmode(ents, custom_animmode, scene, tag, "generic");
}
anim_set_time(guys, scene, time) {
  array_thread(guys, ::anim_self_set_time, scene, time);
}
addNotetrack_dialogue(animname, notetrack, scene, soundalias, pg_soundalias) {
  num = 0;
  if(isDefined(level.scr_notetrack[animname])) {
    num = level.scr_notetrack[animname].size;
  }
  level.scr_notetrack[animname][num]["notetrack"] = notetrack;
  level.scr_notetrack[animname][num]["dialog"] = soundalias;
  level.scr_notetrack[animname][num]["pg_dialog"] = pg_soundalias;
  level.scr_notetrack[animname][num]["scene"] = scene;
}
removeNotetrack_dialogue(animname, notetrack, scene, soundalias) {
  assertex(isDefined(level.scr_notetrack[animname]), "Animname not found in scr_notetrack.");
  tmp_array = [];
  for(i = 0; i < level.scr_notetrack[animname].size; i++) {
    if(level.scr_notetrack[animname][i]["notetrack"] == notetrack) {
      dialog = level.scr_notetrack[animname][i]["dialog"];
      if(!isDefined(dialog)) {
        dialog = level.scr_notetrack[animname][i]["dialogue"];
      }
      if(isDefined(dialog) && dialog == soundalias) {
        if(isDefined(scene) && isDefined(level.scr_notetrack[animname][i]["scene"])) {
          if(level.scr_notetrack[animname][i]["scene"] == scene) {
            continue;
          }
        } else {
          continue;
        }
      }
    }
    num = tmp_array.size;
    tmp_array[num] = level.scr_notetrack[animname][i];
  }
  assertex(tmp_array.size < level.scr_notetrack[animname].size, "Notetrack not found.");
  level.scr_notetrack[animname] = tmp_array;
}
addNotetrack_sound(animname, notetrack, scene, soundalias) {
  array = [];
  array["notetrack"] = notetrack;
  array["sound"] = soundalias;
  if(!isDefined(scene)) {
    scene = "any";
  }
  array["scene"] = scene;
  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack = [];
    level.scr_notetrack[animname] = [];
  } else {
    if(!isDefined(level.scr_notetrack[animname])) {
      level.scr_notetrack[animname] = [];
    }
  }
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = array;
}
addOnStart_animSound(animname, scene, soundalias) {
  if(!isDefined(level.scr_animSound[animname])) {
    level.scr_animSound[animname] = [];
  }
  level.scr_animSound[animname][scene] = soundalias;
}
addNotetrack_animSound(animname, scene, notetrack, soundalias) {
  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  array = [];
  array["notetrack"] = notetrack;
  array["sound"] = soundalias;
  array["created_by_animSound"] = true;
  array["scene"] = scene;
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = array;
}
addNotetrack_attach(animname, notetrack, model, tag, scene) {
  num = 0;
  if(isDefined(level.scr_notetrack[animname])) {
    num = level.scr_notetrack[animname].size;
  }
  level.scr_notetrack[animname][num]["notetrack"] = notetrack;
  level.scr_notetrack[animname][num]["attach model"] = model;
  level.scr_notetrack[animname][num]["selftag"] = tag;
  if(!isDefined(scene)) {
    scene = "any";
  }
  level.scr_notetrack[animname][num]["scene"] = scene;
}
addNotetrack_detach(animname, notetrack, model, tag, scene) {
  num = 0;
  if(isDefined(level.scr_notetrack[animname])) {
    num = level.scr_notetrack[animname].size;
  }
  level.scr_notetrack[animname][num]["notetrack"] = notetrack;
  level.scr_notetrack[animname][num]["detach model"] = model;
  level.scr_notetrack[animname][num]["selftag"] = tag;
  if(!isDefined(scene)) {
    scene = "any";
  }
  level.scr_notetrack[animname][num]["scene"] = scene;
}
addNotetrack_fov(animname, notetrack, scene) {
  num = 0;
  if(isDefined(level.scr_notetrack[animname])) {
    num = level.scr_notetrack[animname].size;
  }
  level.scr_notetrack[animname][num]["notetrack"] = notetrack;
  level.scr_notetrack[animname][num]["change fov"] = notetrack;
  if(!isDefined(scene)) {
    scene = "any";
  }
  level.scr_notetrack[animname][num]["scene"] = scene;
}
addNotetrack_customFunction(animname, notetrack, function, scene) {
  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack[animname] = [];
  }
  num = 0;
  if(isDefined(level.scr_notetrack[animname])) {
    num = level.scr_notetrack[animname].size;
  }
  level.scr_notetrack[animname][num]["notetrack"] = notetrack;
  level.scr_notetrack[animname][num]["function"] = function;
  if(!isDefined(scene)) {
    scene = "any";
  }
  level.scr_notetrack[animname][num]["scene"] = scene;
}
notetrack_customfunction_exists(animname, notetrack, function, scene) {
  if(isDefined(level.scr_notetrack) && isDefined(level.scr_notetrack[animname])) {
    keys = GetArrayKeys(level.scr_notetrack[animname]);
    for(i = 0; i < keys.size; i++) {
      if(isDefined(level.scr_notetrack[animname][keys[i]]) &&
        isDefined(level.scr_notetrack[animname][keys[i]]["notetrack"]) &&
        isDefined(level.scr_notetrack[animname][keys[i]]["scene"]) &&
        isDefined(level.scr_notetrack[animname][keys[i]]["function"]) &&
        level.scr_notetrack[animname][keys[i]]["notetrack"] == notetrack &&
        level.scr_notetrack[animname][keys[i]]["scene"] == scene &&
        level.scr_notetrack[animname][keys[i]]["function"] == function) {
        return true;
      }
    }
  }
  return false;
}
addNotetrack_flag(animname, notetrack, flag, scene) {
  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  addNote = [];
  addNote["notetrack"] = notetrack;
  addNote["flag"] = flag;
  if(!isDefined(scene)) {
    scene = "any";
  }
  addNote["scene"] = scene;
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = addNote;
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
}
addNotetrack_FXOnTag(animname, scene, notetrack, effect, tag, on_threader) {
  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  add_note = [];
  add_note["notetrack"] = notetrack;
  add_note["scene"] = scene;
  add_note["effect"] = effect;
  if(isDefined(on_threader) && on_threader) {
    add_note["tag"] = tag;
  } else {
    add_note["selftag"] = tag;
  }
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = add_note;
}
addNotetrack_exploder(animname, notetrack, exploder, scene) {
  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  addNote = [];
  addNote["notetrack"] = notetrack;
  addNote["exploder"] = exploder;
  if(!isDefined(scene)) {
    scene = "any";
  }
  addNote["scene"] = scene;
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = addNote;
}
addNotetrack_stop_exploder(animname, notetrack, exploder, scene) {
  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  addNote = [];
  addNote["notetrack"] = notetrack;
  addNote["stop_exploder"] = exploder;
  if(!isDefined(scene)) {
    scene = "any";
  }
  addNote["scene"] = scene;
  level.scr_notetrack[animname][level.scr_notetrack[animname].size] = addNote;
}
set_animname(ents, animname) {
  for(i = 0; i < ents.size; i++) {
    ents[i].animname = animname;
  }
}
anim_set_blend_in_time(time) {
  self._anim_blend_in_time = time;
}
anim_set_blend_out_time(time) {
  self._anim_blend_out_time = time;
}
get_anim(scene, animname) {
  if(!isDefined(animname)) {
    animname = self.animname;
  }
  if(isDefined(level.scr_anim[animname])) {
    if(IsArray(level.scr_anim[animname][scene])) {
      total_anims = level.scr_anim[animname][scene].size;
      anim_index = RandomInt(total_anims);
      return level.scr_anim[animname][scene][anim_index];
    }
    return level.scr_anim[animname][scene];
  }
}
init() {
  if(!isDefined(level.scr_special_notetrack)) {
    level.scr_special_notetrack = [];
  }
  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack = [];
  }
  if(!isDefined(level.scr_face)) {
    level.scr_face = [];
  }
  if(!isDefined(level.scr_look)) {
    level.scr_look = [];
  }
  if(!isDefined(level.scr_animSound)) {
    level.scr_animSound = [];
  }
  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }
  if(!isDefined(level.scr_radio)) {
    level.scr_radio = [];
  }
  if(!isDefined(level.scr_text)) {
    level.scr_text = [];
  }
  if(!isDefined(level.scr_anim)) {
    level.scr_anim[0][0] = 0;
  }
  if(!isDefined(level.scr_radio)) {
    level.scr_radio = [];
  }
}
build_ent_array(ents) {
  ent_array = [];
  if(IsArray(ents)) {
    ent_array = ents;
  } else {
    ent_array[0] = ents;
  }
  return ent_array;
}
wait_until_anim_finishes(scene) {
  self endon("finished_custom_animmode" + scene);
  self waittill("death");
}
endonRemoveAnimActive(endonString, guyPackets) {
  self endon("newAnimActive");
  self waittill(endonString);
  for(i = 0; i < guyPackets.size; i++) {
    guy = guyPackets[i]["guy"];
    if(!isDefined(guy)) {
      continue;
    }
    guy = guy get_anim_ent();
    guy._animActive--;
    guy._lastAnimTime = GetTime();
    assert(guy._animactive >= 0);
  }
}
debug_check(ents, scene, animname_override) {}
is_a_sound_only_scene(scene, animname) {
  if(!isDefined(animname)) {
    animname = self.animname;
  }
  if(!isDefined(animname)) {
    assertmsg("Animating character of type " + self.classname + " has no animname.");
    return false;
  }
  has_anim = false;
  has_sound = true;
  if(isDefined(level.scr_anim[animname])) {
    if(isDefined(level.scr_anim[animname][scene])) {
      has_anim = true;
    }
  }
  if(isDefined(level.scr_sound[animname])) {
    if(isDefined(level.scr_sound[animname][scene])) {
      has_sound = true;
    }
  }
  if(has_anim) {
    return (false);
  }
  return (has_sound);
}
assert_existance_of_anim(scene, animname) {}
anim_first_frame_on_guy(guy, scene, org, angles, animname_override) {
  guy.first_frame_time = GetTime();
  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }
  guy set_start_pos(scene, org, angles, animname);
  animation = guy get_anim(scene, animname);
  if(IsAI(guy)) {
    guy AnimScripted("anim_first_frame", org, angles, animation, "normal", guy.root_anim, 0, 0);
  } else {
    guy SetAnimKnob(animation, 1, 0, 0);
  }
}
anim_custom_animmode_on_guy(guy, custom_animmode, scene, org, angles, animname_override) {
  animname = undefined;
  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }
  assertex(IsAI(guy), "Tried to do custom_animmode on a non ai");
  guy set_start_pos(scene, org, angles, animname_override);
  guy._animmode = custom_animmode;
  guy._custom_anim = scene;
  guy._tag_entity = self;
  guy._scene = scene;
  guy._animname = animname;
  guy AnimCustom(get_overloaded_func("animscripts\animmode", "main"));
}
anim_loop_packet(guyPackets, scene, ender, animname_override) {
  if(!isDefined(ender)) {
    ender = "stop_loop";
  }
  baseGuy = undefined;
  for(i = 0; i < guyPackets.size; i++) {
    guy = guyPackets[i]["guy"];
    if(!isDefined(guy)) {
      continue;
    }
    guy = guy get_anim_ent();
    if(i == 0) {
      baseGuy = guy;
    }
    if(!isDefined(guy._animActive)) {
      guy._animActive = 0;
    }
    if(isDefined(guy.anim_loop_ender)) {
      guy notify(guy.anim_loop_ender);
    }
    guy.anim_loop_ender = ender;
    guy endon(ender);
    guy endon("death");
    guy._animActive++;
  }
  self endon(ender);
  thread endonRemoveAnimActive(ender, guyPackets);
  anim_string = "looping anim";
  base_animname = undefined;
  if(isDefined(animname_override)) {
    base_animname = animname_override;
  } else {
    base_animname = baseGuy.animname;
  }
  assertex(isarray(level.scr_anim[base_animname][scene]), "Looping anims must have an array entry in level.scr_anim! i.e. [animname][scene][0]");
  idleanim = 0;
  lastIdleanim = 0;
  while(1) {
    idleanim = anim_weight(base_animname, scene);
    while((idleanim == lastIdleanim) && (idleanim != 0)) {
      idleanim = anim_weight(base_animname, scene);
    }
    lastIdleanim = idleanim;
    scriptedAnimationIndex = -1;
    scriptedAnimationTime = 999999;
    scriptedSoundIndex = -1;
    for(i = 0; i < guyPackets.size; i++) {
      guy = guyPackets[i]["guy"];
      if(!isDefined(guy)) {
        return;
      }
      guy = guy get_anim_ent();
      pos = get_anim_position(guyPackets[i]["tag"]);
      org = pos["origin"];
      angles = pos["angles"];
      entity = guyPackets[i]["entity"];
      if(!isDefined(org)) {
        org = guy.origin;
      }
      if(!isDefined(angles)) {
        angles = guy.angles;
      }
      doFacialanim = false;
      doDialogue = false;
      doAnimation = false;
      doText = false;
      facialAnim = undefined;
      dialogue = undefined;
      animname = undefined;
      if(isDefined(animname_override)) {
        animname = animname_override;
      } else {
        animname = guy.animname;
      }
      if((isDefined(level.scr_face[animname])) &&
        (isDefined(level.scr_face[animname][scene])) &&
        (isDefined(level.scr_face[animname][scene][idleanim]))) {
        doFacialanim = true;
        facialAnim = level.scr_face[animname][scene][idleanim];
      }
      if(is_mature() || !pg_loopanim_sound_exists(animname, scene, idleanim)) {
        if(loopanim_sound_exists(animname, scene, idleanim)) {
          doDialogue = true;
          dialogue = level.scr_sound[animname][scene][idleanim];
        }
      } else if(pg_loopanim_sound_exists(animname, scene, idleanim)) {
        doDialogue = true;
        dialogue = level.scr_sound[animname][scene + "_pg"][idleanim];
      }
      if(isDefined(level.scr_animSound[animname]) &&
        isDefined(level.scr_animSound[animname][idleanim + scene])) {
        guy playSound(level.scr_animSound[animname][idleanim + scene]);
      }
      if((isDefined(level.scr_anim[animname])) &&
        (isDefined(level.scr_anim[animname][scene]))) {
        doAnimation = true;
      }
      if(doAnimation) {
        if(guy.classname == "script_vehicle" &&
          (!isDefined(guy.supportsAnimScripted) || !guy.supportsAnimScripted)) {
          guy.origin = org;
          guy.angles = angles;
          guy SetFlaggedAnimKnobRestart(anim_string, level.scr_anim[animname][scene][idleanim], 1, 0.2, 1);
        } else {
          guy last_anim_time_check();
          guy AnimScripted(anim_string, org, angles, level.scr_anim[animname][scene][idleanim]);
        }
        guy notify("_anim_playing");
        animtime = GetAnimLength(level.scr_anim[animname][scene][idleanim]);
        if(animtime < scriptedAnimationTime) {
          scriptedAnimationTime = animtime;
          scriptedAnimationIndex = i;
        }
        thread start_notetrack_wait(guy, anim_string, scene, animname);
        thread animscriptDoNoteTracksThread(guy, anim_string, scene);
      }
      if((doFacialanim) || (doDialogue)) {
        if(doAnimation) {
          guy SaySpecificDialogue(facialAnim, dialogue, 1.0);
        } else {
          guy SaySpecificDialogue(facialAnim, dialogue, 1.0, anim_string);
        }
        scriptedSoundIndex = i;
      }
    }
    if(scriptedAnimationIndex != -1) {
      guyPackets[scriptedAnimationIndex]["guy"] get_anim_ent() waittillmatch(anim_string, "end");
    } else if(scriptedSoundIndex != -1) {
      guyPackets[scriptedSoundIndex]["guy"] get_anim_ent() waittill(anim_string);
    }
  }
}
start_notetrack_wait(guy, anim_string, scene, animname) {
  guy notify("stop_sequencing_notetracks");
  thread notetrack_wait(guy, anim_string, scene, animname);
}
anim_single_failsafeOnGuy(owner, scene) {}
anim_single_failsafe(guy, scene) {
  for(i = 0; i < guy.size; i++) {
    guy[i] thread anim_single_failsafeOnGuy(self, scene);
  }
}
do_anim_single(guys, scene, tag, animname_override, aligned) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  tracker = spawnStruct();
  tracker.scriptedAnimationTime = 999999;
  tracker.scriptedAnimationIndex = -1;
  tracker.scriptedSoundIndex = -1;
  tracker.scriptedFaceIndex = -1;
  for(i = 0; i < guys.size; i++) {
    if(!isDefined(guys[i])) {
      AssertMsg("_anim::do_anim_single - trying to play animation on undefined ent.");
      return;
    }
    thread anim_single_thread(guys, i, scene, org, angles, animname_override, aligned, tracker);
  }
  if(tracker.scriptedAnimationIndex != -1) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[tracker.scriptedAnimationIndex], scene);
    ent thread anim_animationEndNotify(guys[tracker.scriptedAnimationIndex], scene);
    ent waittill(scene);
  } else if(tracker.scriptedFaceIndex != -1) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[tracker.scriptedFaceIndex], scene);
    ent thread anim_facialEndNotify(guys[tracker.scriptedFaceIndex], scene);
    ent waittill(scene);
  } else if(tracker.scriptedSoundIndex != -1) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[tracker.scriptedSoundIndex], scene);
    ent thread anim_dialogueEndNotify(guys[tracker.scriptedSoundIndex], scene);
    ent waittill(scene);
  }
  for(i = 0; i < guys.size; i++) {
    if(!isDefined(guys[i])) {
      continue;
    }
    guys[i]._animActive--;
    guys[i]._lastAnimTime = GetTime();
    assert(guys[i]._animactive >= 0);
  }
  self notify(scene);
}
anim_single_thread(guys, index, scene, org, angles, animname_override, aligned, tracker) {
  guy = guys[index];
  guy endon("death");
  if(guy is_a_sound_only_scene(scene, animname_override)) {} else {
    guy notify("stop_loop");
    guy notify("stop_single");
  }
  blend_in = guy._anim_blend_in_time;
  blend_out = guy._anim_blend_out_time;
  guy = guy get_anim_ent();
  if(!isDefined(guy._animActive)) {
    guy._animActive = 0;
  }
  guy._animActive++;
  doFacialanim = false;
  doDialogue = false;
  doAnimation = false;
  doText = false;
  doLook = false;
  dialogue = undefined;
  facialAnim = undefined;
  anim_string = "single anim";
  animname = undefined;
  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }
  if((isDefined(level.scr_face[animname])) &&
    (isDefined(level.scr_face[animname][scene]))) {
    doFacialanim = true;
    facialAnim = level.scr_face[animname][scene];
  }
  if(is_mature() || !pg_sound_exists(animname, scene)) {
    if(sound_exists(animname, scene)) {
      doDialogue = true;
      dialogue = level.scr_sound[animname][scene];
    }
  } else if(pg_sound_exists(animname, scene)) {
    doDialogue = true;
    dialogue = level.scr_sound[animname][scene + "_pg"];
  }
  if((isDefined(level.scr_look[animname])) &&
    (isDefined(level.scr_look[animname][scene]))) {
    doLook = true;
  }
  if(isDefined(level.scr_animSound[animname]) &&
    isDefined(level.scr_animSound[animname][scene])) {
    guy playSound(level.scr_animSound[animname][scene]);
  }
  animation = guy get_anim(scene, animname_override);
  if(isDefined(animation)) {
    if(isDefined(guy.a)) {
      guy.a.coverIdleOnly = false;
    }
    animtime = GetAnimLength(animation);
    if(animtime < tracker.scriptedAnimationTime) {
      tracker.scriptedAnimationTime = animtime;
      tracker.scriptedAnimationIndex = index;
    }
    if(guy.classname == "script_vehicle" &&
      (!isDefined(guy.supportsAnimScripted) || !guy.supportsAnimScripted)) {
      veh_org = GetStartOrigin(org, angles, animation);
      veh_ang = GetStartAngles(org, angles, animation);
      guy.origin = veh_org;
      guy.angles = veh_ang;
      guy SetFlaggedAnimKnobRestart(anim_string, animation, 1, 0.2, 1);
    } else {
      if(!isDefined(aligned) || !aligned) {
        if(isDefined(guy.a) && (guy.a.state == "move")) {
          guy wait_for_foot_sync();
        }
        guy AnimScripted(anim_string, guy.origin, guy.angles, animation, "normal", undefined, 1, blend_in);
      } else {
        Assert(isDefined(angles), "Alignment node does not have angles specified.");
        guy AnimScripted(anim_string, org, angles, animation, "normal", undefined, 1, blend_in);
      }
      guy last_anim_time_check();
      cut_time = 0.0;
      if(isDefined(blend_out)) {
        cut_time = blend_out;
      }
      guy thread earlyout_animscripted(animation, cut_time);
    }
    guy notify("_anim_playing");
    thread start_notetrack_wait(guy, anim_string, scene, animname);
    thread animscriptDoNoteTracksThread(guy, anim_string, scene);
  }
  if(doLook) {
    assertex(isDefined(animation), "Look animation \"" + scene + "\" for animname \"" + animname + "\" does not have a base animation");
    thread anim_look(guy, scene, level.scr_look[animname][scene]);
  }
  if((doFacialanim) || (doDialogue)) {
    if(doFacialAnim) {
      if(doDialogue) {
        guy thread delayedDialogue(scene, doFacialanim, dialogue, level.scr_face[animname][scene]);
      }
      assertex(!doanimation, "Can't play a facial anim and fullbody anim at the same time. The facial anim should be in the full body anim. Occurred on animation \"" + scene + "\"");
      thread anim_facialAnim(guy, scene, level.scr_face[animname][scene]);
      tracker.scriptedFaceIndex = index;
    } else {
      if(isDefined(animation)) {
        guy SaySpecificDialogue(facialAnim, dialogue, 1.0);
      } else {
        if(IsAI(guy)) {
          guy thread anim_facialFiller("single dialogue");
        }
        guy SaySpecificDialogue(facialAnim, dialogue, 1.0, "single dialogue");
      }
    }
    tracker.scriptedSoundIndex = index;
  }
  assertex(isDefined(animation) || doLook || doFacialanim || doDialogue || doText, "Tried to do anim scene " + scene + " on guy with animname " + animname + ", but he didn't have that anim scene.");
}
wait_for_foot_sync() {
  self endon("death");
  self endon("foot_sync_timeout");
  self thread wait_for_foot_sync_timeout();
  self waittillmatch("runanim", "footstep_left_large");
  self notify("foot_sync");
}
wait_for_foot_sync_timeout() {
  self endon("foot_sync");
  self endon("death");
  while(self.a.state == "move") {
    wait .05;
  }
  self notify("foot_sync_timeout");
}
anim_deathNotify(guy, scene) {
  self endon(scene);
  guy waittill("death");
  self notify(scene);
}
anim_facialEndNotify(guy, scene) {
  self endon(scene);
  guy waittillmatch("face_done_" + scene, "end");
  self notify(scene);
}
anim_dialogueEndNotify(guy, scene) {
  self endon(scene);
  guy waittill("single dialogue");
  self notify(scene);
}
anim_animationEndNotify(guy, scene) {
  self endon(scene);
  guy waittillmatch("single anim", "end");
  self notify(scene);
}
animscriptDoNoteTracksThread(guy, animstring, scene) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");
  guy DoNoteTracks(animstring);
}
add_animsound(newSound) {
  for(i = 0; i < level.animsound_hudlimit; i++) {
    if(isDefined(self.animsounds[i])) {
      continue;
    }
    self.animSounds[i] = newSound;
    return;
  }
  keys = GetArrayKeys(self.animsounds);
  index = keys[0];
  timer = self.animsounds[index].end_time;
  for(i = 1; i < keys.size; i++) {
    key = keys[i];
    if(self.animsounds[key].end_time < timer) {
      timer = self.animsounds[key].end_time;
      index = key;
    }
  }
  self.animSounds[index] = newSound;
}
animSound_exists(scene, notetrack) {
  keys = GetArrayKeys(self.animSounds);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(self.animSounds[key].scene != scene) {
      continue;
    }
    if(self.animSounds[key].notetrack != notetrack) {
      continue;
    }
    self.animSounds[key].end_time = GetTime() + 60000;
    return true;
  }
  return false;
}
animsound_tracker(scene, notetrack, animname) {
  add_to_animsound();
  if(notetrack == "end") {
    return;
  }
  if(animSound_exists(scene, notetrack)) {
    return;
  }
  newTrack = spawnStruct();
  newTrack.scene = scene;
  newTrack.notetrack = notetrack;
  newTrack.animname = animname;
  newTrack.end_time = GetTime() + 60000;
  add_animsound(newTrack);
}
animsound_start_tracker(scene, animname) {
  add_to_animsound();
  newSound = spawnStruct();
  newSound.scene = scene;
  newSound.notetrack = "#" + scene;
  newSound.animname = animname;
  newSound.end_time = GetTime() + 60000;
  if(animSound_exists(scene, newSound.notetrack)) {
    return;
  }
  add_animsound(newSound);
}
animsound_start_tracker_loop(scene, loop, animname) {
  add_to_animsound();
  scene = loop + scene;
  newSound = spawnStruct();
  newSound.scene = scene;
  newSound.notetrack = "#" + scene;
  newSound.animname = animname;
  newSound.end_time = GetTime() + 60000;
  if(animSound_exists(scene, newSound.notetrack)) {
    return;
  }
  add_animsound(newSound);
}
notetrack_wait(guy, msg, scene, animname_override) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");
  tag_owner = self;
  animname = undefined;
  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }
  dialogue_array = [];
  has_scripted_notetracks = isDefined(level.scr_notetrack[animname]);
  if(has_scripted_notetracks) {
    for(i = 0; i < level.scr_notetrack[animname].size; i++) {
      scr_notetrack = level.scr_notetrack[animname][i];
      if(isDefined(scr_notetrack["dialog"])) {
        dialogue_array[scr_notetrack["dialog"]] = true;
      }
    }
  }
  while(1) {
    dialogueNotetrack = false;
    guy waittill(msg, notetrack);
    if(notetrack == "end") {
      return;
    }
    if(has_scripted_notetracks) {
      for(i = 0; i < level.scr_notetrack[animname].size; i++) {
        scr_notetrack = level.scr_notetrack[animname][i];
        if(notetrack == ToLower(scr_notetrack["notetrack"])) {
          if(scr_notetrack["scene"] != "any" && scr_notetrack["scene"] != scene) {
            continue;
          }
          if(isDefined(scr_notetrack["function"])) {
            self thread[[scr_notetrack["function"]]](guy);
          }
          if(isDefined(level.scr_notetrack[animname][i]["flag"])) {
            flag_set(level.scr_notetrack[animname][i]["flag"]);
          }
          if(isDefined(level.scr_notetrack[animname][i]["exploder"])) {
            exploder(level.scr_notetrack[animname][i]["exploder"]);
          }
          if(isDefined(level.scr_notetrack[animname][i]["stop_exploder"])) {
            stop_exploder(level.scr_notetrack[animname][i]["stop_exploder"]);
          }
          if(isDefined(scr_notetrack["attach gun left"])) {
            guy gun_pickup_left();
            continue;
          }
          if(isDefined(scr_notetrack["attach gun right"])) {
            guy gun_pickup_right();
            continue;
          }
          if(isDefined(scr_notetrack["detach gun"])) {
            guy gun_leave_behind(scr_notetrack);
            continue;
          }
          if(isDefined(scr_notetrack["swap from"])) {
            guy Detach(guy.swapWeapon, scr_notetrack["swap from"]);
            guy Attach(guy.swapWeapon, scr_notetrack["self tag"]);
            continue;
          }
          if(isDefined(scr_notetrack["attach model"])) {
            if(isDefined(scr_notetrack["selftag"])) {
              guy Attach(scr_notetrack["attach model"], scr_notetrack["selftag"]);
            } else {
              tag_owner Attach(scr_notetrack["attach model"], scr_notetrack["tag"]);
            }
            continue;
          }
          if(isDefined(scr_notetrack["detach model"])) {
            waittillframeend;
            if(isDefined(scr_notetrack["selftag"])) {
              guy detach(scr_notetrack["detach model"], scr_notetrack["selftag"]);
            } else {
              tag_owner detach(scr_notetrack["detach model"], scr_notetrack["tag"]);
            }
          }
          if(isDefined(scr_notetrack["change fov"])) {
            tokens = StrTok(scr_notetrack["change fov"], "_");
            Assert(ToLower(tokens[0]) == "fov");
            if(tokens[1] != "reset") {
              new_fov = Int(Int(tokens[1]) * 1.27);
              level notify("stop_lerping_thread");
              if(tokens.size > 2) {
                lerp_time = Int(tokens[2]);
                get_players()[0] thread lerp_fov_overtime(lerp_time, new_fov, 1);
              } else {
                get_players()[0] SetClientDvar("cg_fov", new_fov);
              }
            } else {
              Assert(ToLower(tokens[1]) == "reset");
              level notify("stop_lerping_thread");
              if(tokens.size > 2) {
                lerp_time = Int(tokens[2]);
                get_players()[0] thread lerp_fov_overtime(lerp_time, 65, 1);
              } else {
                get_players()[0] SetClientDvar("cg_fov", 65);
              }
            }
          }
          if(isDefined(scr_notetrack["sound"])) {
            guy thread play_sound_on_tag(scr_notetrack["sound"], undefined, true);
          }
          if(!dialogueNotetrack) {
            if(isDefined(scr_notetrack["dialog"]) && isDefined(dialogue_array[scr_notetrack["dialog"]])) {
              anim_facial(guy, i, "dialog", animname);
              dialogue_array[scr_notetrack["dialog"]] = undefined;
              dialogueNotetrack = true;
            }
          }
          if(isDefined(scr_notetrack["create model"])) {
            anim_addModel(guy, scr_notetrack);
          } else if(isDefined(scr_notetrack["delete model"])) {
            anim_removeModel(guy, scr_notetrack);
          }
          if((isDefined(scr_notetrack["selftag"])) &&
            (isDefined(scr_notetrack["effect"]))) {
            playFXOnTag(
              level._effect[scr_notetrack["effect"]], guy, scr_notetrack["selftag"]);
          }
          if(isDefined(scr_notetrack["tag"]) && isDefined(scr_notetrack["effect"])) {
            playFXOnTag(level._effect[scr_notetrack["effect"]], tag_owner, scr_notetrack["tag"]);
          }
          if(isDefined(level.scr_special_notetrack[animname])) {
            tag = random(level.scr_special_notetrack[animname]);
            if(isDefined(tag["tag"])) {
              playFXOnTag(level._effect[tag["effect"]], tag_owner, tag["tag"]);
            } else if(isDefined(tag["selftag"])) {
              playFXOnTag(level._effect[tag["effect"]], self, tag["tag"]);
            }
          }
        }
      }
    }
    prefix = GetSubStr(notetrack, 0, 3);
    if(prefix == "ps_") {
      alias = GetSubStr(notetrack, 3);
      guy thread play_sound_on_tag(alias, undefined, true);
    }
  }
}
anim_addModel(guy, array) {
  if(!isDefined(guy.ScriptModel)) {
    guy.ScriptModel = [];
  }
  index = guy.ScriptModel.size;
  guy.ScriptModel[index] = spawn("script_model", (0, 0, 0));
  guy.ScriptModel[index] setModel(array["create model"]);
  guy.ScriptModel[index].origin = guy GetTagOrigin(array["selftag"]);
  guy.ScriptModel[index].angles = guy GetTagAngles(array["selftag"]);
}
anim_removeModel(guy, array) {
  for(i = 0; i < guy.ScriptModel.size; i++) {
    if(isDefined(array["explosion"])) {
      forward = anglesToForward(guy.scriptModel[i].angles);
      forward = vector_scale(forward, 120);
      forward += guy.scriptModel[i].origin;
      playFX(level._effect[array["explosion"]], guy.scriptModel[i].origin);
      RadiusDamage(guy.scriptModel[i].origin, 350, 700, 50);
    }
    guy.scriptModel[i] delete();
  }
}
anim_facial(guy, i, dialogueString, animname) {
  facialAnim = undefined;
  if(isDefined(level.scr_notetrack[animname][i]["facial"])) {
    facialAnim = level.scr_notetrack[animname][i]["facial"];
  }
  dialogue = undefined;
  if(is_mature() || !isDefined(level.scr_notetrack[animname][i]["pg_" + dialogueString])) {
    dialogue = level.scr_notetrack[animname][i][dialogueString];
  } else if(isDefined(level.scr_notetrack[animname][i]["pg_" + dialogueString])) {
    dialogue = level.scr_notetrack[animname][i]["pg_" + dialogueString];
  }
  guy SaySpecificDialogue(facialAnim, dialogue, 1.0);
}
gun_pickup_left() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground delete();
  self.dropWeapon = true;
  self animscripts\shared::placeWeaponOn(self.weapon, "left");
}
gun_pickup_right() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground delete();
  self.dropWeapon = true;
  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}
gun_leave_behind(scr_notetrack) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }
  gun = spawn("script_model", (0, 0, 0));
  model = GetWeaponModel(self.weapon);
  gun setModel(model);
  self.gun_on_ground = gun;
  gun.origin = self GetTagOrigin(scr_notetrack["tag"]);
  gun.angles = self GetTagAngles(scr_notetrack["tag"]);
  self animscripts\shared::placeWeaponOn(self.weapon, "none");
  self.dropWeapon = false;
}
anim_weight(animname, scene) {
  total_anims = level.scr_anim[animname][scene].size;
  idleanim = RandomInt(total_anims);
  if(total_anims > 1) {
    weights = 0;
    anim_weight = 0;
    for(i = 0; i < total_anims; i++) {
      if(isDefined(level.scr_anim[animname][scene + "weight"])) {
        if(isDefined(level.scr_anim[animname][scene + "weight"][i])) {
          weights++;
          anim_weight += level.scr_anim[animname][scene + "weight"][i];
        }
      }
    }
    if(weights == total_anims) {
      anim_play = randomfloat(anim_weight);
      anim_weight = 0;
      for(i = 0; i < total_anims; i++) {
        anim_weight += level.scr_anim[animname][scene + "weight"][i];
        if(anim_play < anim_weight) {
          idleanim = i;
          break;
        }
      }
    }
  }
  return idleanim;
}
get_anim_position(tag) {
  org = undefined;
  angles = undefined;
  if(isDefined(tag)) {
    org = self GetTagOrigin(tag);
    angles = self GetTagAngles(tag);
  } else {
    org = self.origin;
    angles = self.angles;
  }
  array = [];
  array["angles"] = angles;
  array["origin"] = org;
  return array;
}
do_anim_reach(guys, scene, tag, animname_override, aligned) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  debugStartpos = false;
  threads = 0;
  tracker = spawnStruct();
  if(!IsArray(guys)) {
    guys = array_add(guys, guys);
  }
  for(i = 0; i < guys.size; i++) {
    guy = guys[i];
    animation = guy get_anim(scene, animname_override);
    if(isDefined(animation)) {
      startorg = GetStartOrigin(org, angles, animation);
    } else {
      startorg = org;
    }
    threads++;
    disablearrivals = true;
    if(!is_true(guy.disablearrivals)) {
      notetracks = GetNotetracksInDelta(animation, 0, 1);
      if(notetracks.size) {
        if((notetracks[0][1] == "anim_movement = \"stop\"") && (notetracks[0][2] == 0)) {
          disablearrivals = false;
        }
      }
    }
    self thread begin_anim_reach(guy, tracker, startorg, disablearrivals, aligned);
  }
  while(threads) {
    tracker waittill("reach_notify");
    threads--;
  }
}
anim_spawner_teleport(guy, scene, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  for(i = 0; i < guy.size; i++) {
    animation = guy[i] get_anim(scene);
    startorg = GetStartOrigin(org, angles, animation);
    guy[i].origin = startorg;
  }
}
reach_death_notify(guy) {
  self endon("reach_notify");
  self waittill_any("death", "_anim_reach", "_anim_playing", "_anim_stopped");
  self notify("reach_notify");
}
begin_anim_reach(guy, tracker, startorg, disablearrivals, aligned) {
  guy endon("death");
  guy notify("stop_going_to_node");
  guy notify("_anim_reach");
  guy endon("_anim_reach");
  waittillframeend;
  tracker thread reach_death_notify(guy);
  guy._anim_old_disablearrivals = guy.disablearrivals;
  guy._anim_old_fixednode = guy.fixednode;
  goal = startorg;
  if(vector_compare(self.origin, startorg) &&
    isDefined(self.type) && GetSubStr(self.type, 0, 5) == "Cover") {
    guy.a.coverIdleOnly = true;
    disablearrivals = false;
    goal = self;
    aligned = true;
    guy.fixednode = true;
  } else {
    guy.fixednode = false;
  }
  if(disablearrivals) {
    guy.stopanimdistsq = 0.0001;
  } else {
    guy.stopanimdistsq = 0;
  }
  guy.disablearrivals = disablearrivals;
  goal_radius = 50;
  if(aligned) {
    goal_radius = 0;
  }
  guy thread force_goal(goal, goal_radius, true, "anim_reach_done");
  guy thread end_anim_reach();
  guy waittill("goal");
  tracker notify("reach_notify");
}
end_anim_reach() {
  self endon("death");
  self waittill_any("_anim_reach", "_anim_playing", "_anim_stopped");
  self notify("anim_reach_done");
  self.disablearrivals = self._anim_old_disablearrivals;
  self.fixednode = self._anim_old_fixednode;
  self.stopanimdistsq = 0;
  self._anim_old_fixednode = undefined;
  self._anim_old_disablearrivals = undefined;
}
get_animtree(guy) {
  for(i = 0; i < guy.size; i++) {
    guy[i] UseAnimTree(level.scr_animtree[guy[i].animname]);
  }
}
SetAnimTree() {
  self UseAnimTree(level.scr_animtree[self.animname]);
}
anim_single_queue(guy, scene, tag) {
  assertex(isDefined(scene), "Tried to do anim_single_queue without passing a scene name (scene)");
  if(isDefined(guy.last_queue_time)) {
    wait_for_buffer_time_to_pass(guy.last_queue_time, 0.5);
  }
  function_stack(::anim_single_aligned, guy, scene, tag);
  guy.last_queue_time = GetTime();
}
anim_pushPlayer(guy) {
  for(i = 0; i < guy.size; i++) {
    guy[i] PushPlayer(true);
  }
}
addNotetrack_custom(animname, scene, notetrack, index1_str, index1_val, index2_str, index2_val) {
  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }
  num = level.scr_notetrack[animname].size;
  add_note = [];
  add_note["notetrack"] = notetrack;
  add_note["scene"] = scene;
  add_note[index1_str] = index1_val;
  if(isDefined(index2_str) && isDefined(index2_val)) {
    add_note[index2_str] = index2_val;
  }
  level.scr_notetrack[animname][num] = add_note;
}
anim_ents(ents, scene, tag, animname) {
  ents = build_ent_array(ents);
  pos = get_anim_position(tag);
  origin = pos["origin"];
  angles = pos["angles"];
  parent_model = undefined;
  if(!isDefined(animname) && isDefined(ents[0].animname)) {
    animname = ents[0].animname;
  }
  assertex(isDefined(animname), "_anim::anim_ents() - Animname is not defined");
  if(isDefined(level.scr_model[animname])) {
    parent_model = spawn("script_model", origin);
    parent_model.angles = angles;
    parent_model.animname = animname;
    parent_model SetAnimTree();
    parent_model setModel(level.scr_model[animname]);
  }
  for(i = 0; i < ents.size; i++) {
    if(isDefined(parent_model)) {
      assertex(isDefined(ents[i].script_linkto), "_anim::anim_ents() - Entity at " + ents[i].origin + " does not have a script_linkto Key/Value");
      ents[i] LinkTo(parent_model, ents[i].script_linkto);
    } else {
      ents[i] SetAnimTree();
      ents[i] SetFlaggedAnimKnob("ent_anim", get_anim(scene, animname), 1.0, 0.2, 1.0);
      thread start_notetrack_wait(ents[i], "ent_anim", scene, animname);
    }
    ents[i] notify("_anim_playing");
  }
  if(isDefined(parent_model)) {
    parent_model SetFlaggedAnimKnob("ent_anim", get_anim(scene, animname), 1.0, 0.2, 1.0);
    thread start_notetrack_wait(parent_model, "ent_anim", scene, animname);
    parent_model waittillmatch("ent_anim", "end");
    self notify(scene);
  }
}
#using_animtree("generic_human");

anim_look(guy, scene, array) {
  guy endon("death");
  self endon(scene);
  changeTime = 0.05;
  wait(0.05);
  guy setflaggedanimknobrestart("face_done_" + scene, array["left"], 1, 0.2, 1);
  thread clearFaceAnimOnAnimdone(guy, "face_done_" + scene, scene);
  guy SetAnimKnobRestart(array["right"], 1, 0.2, 1);
  guy SetAnim(%scripted, 0.01, 0.3, 1);
  closeToZero = 0.01;
  for(;;) {
    destYaw = guy GetYawToOrigin(level.player.origin);
    if(destYaw <= array["left_angle"]) {
      animWeights["left"] = 1;
      animWeights["right"] = closeToZero;
    } else if(destYaw < array["right_angle"]) {
      middleFraction = (array["right_angle"] - destYaw) / (array["right_angle"] - array["left_angle"]);
      if(middleFraction < closeToZero) {
        middleFraction = closeToZero;
      }
      if(middleFraction > 1 - closeToZero) {
        middleFraction = 1 - closeToZero;
      }
      animWeights["left"] = middleFraction;
      animWeights["right"] = (1 - middleFraction);
    } else {
      animWeights["left"] = closeToZero;
      animWeights["right"] = 1;
    }
    wait(changeTime);
  }
}
anim_facialAnim(guy, scene, faceanim) {
  guy endon("death");
  self endon(scene);
  changeTime = 0.05;
  guy notify("newLookTarget");
  waittillframeend;
  closeToZero = 0.3;
  guy SetAnim(%scripted_look_straight, 0, 0);
  guy SetAnim(%scripted_look_straight, 1, 0.5);
  guy setflaggedanimknobrestart("face_done_" + scene, faceanim, 1, 0, 1);
  thread clearFaceAnimOnAnimdone(guy, "face_done_" + scene, scene);
}
anim_facialFiller(msg, lookTarget) {
  self endon("death");
  changeTime = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;
  closeToZero = 0.3;
  if(!isDefined(looktarget) && isDefined(self.looktarget)) {
    looktarget = self.looktarget;
  }
  if(isDefined(looktarget)) {
    thread chatAtTarget(msg, lookTarget);
    return;
  }
  self set_talker_until_msg(msg);
  changeTime = 0.3;
  self ClearAnim(%scripted_look_straight, changeTime);
}
set_talker_until_msg(msg, talkanim) {
  self endon(msg);
  for(;;) {
    self SendFaceEvent("face_talk");
    wait(0.05);
  }
}
talk_for_time(timer) {
  self endon("death");
  talkAnim = % generic_talker_allies;
  if(self.team == "axis") {
    talkAnim = % generic_talker_axis;
  }
  self SetAnimKnobRestart(talkAnim, 1, 0, 1);
  self SetAnim(%scripted_talking, 1, 0.1);
  wait(timer);
  changeTime = 0.3;
  self ClearAnim(%scripted_talking, 0.1);
  self ClearAnim(%scripted_look_straight, changeTime);
}
GetYawAngles(angles1, angles2) {
  yaw = angles1[1] - angles2[1];
  yaw = AngleClamp180(yaw);
  return yaw;
}
chatAtTarget(msg, lookTarget) {
  self endon(msg);
  self endon("death");
  self thread lookRecenter(msg);
  array["right"] = % generic_lookupright;
  array["left"] = % generic_lookupleft;
  array["left_angle"] = -65;
  array["right_angle"] = 65;
  closeToZero = 0.01;
  org = looktarget.origin;
  moveRange = 2.0;
  changeTime = 0.3;
  for(;;) {
    if(isalive(looktarget)) {
      org = looktarget.origin;
    }
    angles = AnglesToRight(self GetTagAngles("J_Spine4"));
    angles = vector_scale(angles, 10);
    angles = VectorToAngles((0, 0, 0) - angles);
    yaw = angles[1] - GetYaw(org);
    destyaw = AngleClamp180(yaw);
    moveRange = abs(destYaw - self.a.lookAngle) * 1;
    if(destYaw > self.a.lookangle + moveRange) {
      self.a.lookangle += moveRange;
    } else if(destYaw < self.a.lookangle - moveRange) {
      self.a.lookangle -= moveRange;
    } else {
      self.a.lookangle = destYaw;
    }
    destYaw = self.a.lookangle;
    if(destYaw <= array["left_angle"]) {
      animWeights["left"] = 1;
      animWeights["right"] = closeToZero;
    } else if(destYaw < array["right_angle"]) {
      middleFraction = (array["right_angle"] - destYaw) / (array["right_angle"] - array["left_angle"]);
      if(middleFraction < closeToZero) {
        middleFraction = closeToZero;
      }
      if(middleFraction > 1 - closeToZero) {
        middleFraction = 1 - closeToZero;
      }
      animWeights["left"] = middleFraction;
      animWeights["right"] = (1 - middleFraction);
    } else {
      animWeights["left"] = closeToZero;
      animWeights["right"] = 1;
    }
    self SetAnim(array["left"], animWeights["left"], changeTime);
    self SetAnim(array["right"], animWeights["right"], changeTime);
    wait(changeTime);
  }
}
lookRecenter(msg) {
  self endon("newLookTarget");
  self endon("death");
  self waittill(msg);
  self ClearAnim(%scripted_talking, 0.1);
  self SetAnim(%generic_lookupright, 1, 0.3);
  self SetAnim(%generic_lookupleft, 1, 0.3);
  self SetAnim(%scripted_look_straight, 0.2, 0.1);
  wait(0.2);
  self ClearAnim(%scripted_look_straight, 0.2);
}
lookLine(org, msg) {
  self notify("lookline");
  self endon("lookline");
  self endon(msg);
  self endon("death");
  for(;;) {
    line(self getEye(), org + (0, 0, 60), (1, 1, 0), 1);
    wait(0.05);
  }
}
reach_idle(guy, scene, idle, ent) {
  anim_reach_aligned(guy, scene);
  ent.count--;
  ent notify("reach_idle_goal");
  anim_loop(guy, idle);
}
delayedDialogue(scene, doAnimation, dialogue, animationName) {
  assertex(animhasnotetrack(animationName, "dialog"), "Animation " + scene + " does not have a dialog notetrack.");
  self waittillmatch("face_done_" + scene, "dialog");
  if(doAnimation) {
    self SaySpecificDialogue(undefined, dialogue, 1.0);
  } else {
    self SaySpecificDialogue(undefined, dialogue, 1.0, "single dialogue");
  }
}
clearFaceAnimOnAnimdone(guy, msg, scene) {
  guy endon("death");
  guy waittillmatch(msg, "end");
  changeTime = 0.3;
  guy ClearAnim(%scripted_look_straight, changeTime);
}
anim_start_pos(ents, scene, tag) {
  ents = build_ent_array(ents);
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  array_thread(ents, ::set_start_pos, scene, org, angles);
}
set_start_pos(scene, org, angles, animname_override) {
  if(IsSentient(self)) {
    origin = GetStartOrigin(org, angles, get_anim(scene, animname_override));
    angles = GetStartAngles(org, angles, get_anim(scene, animname_override));
    self ForceTeleport(origin, angles);
  } else {
    self.origin = GetStartOrigin(org, angles, get_anim(scene, animname_override));
    self.angles = GetStartAngles(org, angles, get_anim(scene, animname_override));
  }
}
add_to_animsound() {
  if(!isDefined(self.animSounds)) {
    self.animSounds = [];
  }
  isInArray = false;
  for(i = 0; i < level.animSounds.size; i++) {
    if(self == level.animSounds[i]) {
      isInArray = true;
      break;
    }
  }
  if(!isInArray) {
    level.animSounds[level.animSounds.size] = self;
  }
}
anim_self_set_time(scene, time) {
  self SetAnimTime(self getanim(scene), time);
}
last_anim_time_check() {
  if(!isDefined(self.last_anim_time)) {
    self.last_anim_time = GetTime();
    return;
  }
  time = GetTime();
  if(self.last_anim_time == time) {
    wait(0.05);
  }
  self.last_anim_time = time;
}
loopanim_sound_exists(animname, scene, idleanim) {
  if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][scene]) && isDefined(level.scr_sound[animname][scene][idleanim])) {
    return true;
  }
  return false;
}
pg_loopanim_sound_exists(animname, scene, idleanim) {
  if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][scene + "_pg"]) && isDefined(level.scr_sound[animname][scene + "_pg"][idleanim])) {
    return true;
  }
  return false;
}
sound_exists(animname, scene) {
  if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][scene])) {
    return true;
  }
  return false;
}
animation_exists(animname, scene) {
  if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][scene])) {
    return true;
  }
  return false;
}
pg_sound_exists(animname, scene) {
  if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][scene + "_pg"])) {
    return true;
  }
  return false;
}
earlyout_animscripted(animation, cut_time, blend_time) {
  DEFAULT_CUT_TIME = 0.3;
  self endon("death");
  self endon("stop_single");
  if(!isDefined(cut_time)) {
    cut_time = DEFAULT_CUT_TIME;
  }
  if(!isDefined(blend_time)) {
    blend_time = cut_time;
  }
  if(cut_time <= 0) {
    return;
  }
  anim_time = GetAnimLength(animation);
  wait(anim_time - cut_time);
  self anim_stopanimscripted(blend_time);
}