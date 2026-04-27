/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_anim.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\shared;
#include animscripts\utility;
#include animscripts\face;

CONST_anim_end_time = 0.25;

init() {
  if(!isDefined(level.scr_notetrack))
    level.scr_notetrack = [];
  if(!isDefined(level.scr_face))
    level.scr_face = [];
  if(!isDefined(level.scr_look))
    level.scr_look = [];
  if(!isDefined(level.scr_animSound))
    level.scr_animSound = [];
  if(!isDefined(level.scr_sound))
    level.scr_sound = [];
  if(!isDefined(level.scr_radio))
    level.scr_radio = [];
  if(!isDefined(level.scr_text))
    level.scr_text = [];
  if(!isDefined(level.scr_anim))
    level.scr_anim[0][0] = 0;
  if(!isDefined(level.scr_radio))
    level.scr_radio = [];
}

endonRemoveAnimActive(endonString, guyPackets) {
  self endon("newAnimActive");
  self waittill(endonString);
  foreach(guyPacket in guyPackets) {
    guy = guyPacket["guy"];
    if(!isDefined(guy)) {
      continue;
    }
    guy._animActive--;
    guy._lastAnimTime = GetTime();
    Assert(guy._animactive >= 0);
  }
}

anim_first_frame(guys, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  array_levelthread(guys, ::anim_first_frame_on_guy, anime, org, angles);
}

anim_generic_first_frame(guy, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  thread anim_first_frame_on_guy(guy, anime, org, angles, "generic");
}

anim_generic(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, 0, "generic");
}

anim_generic_gravity(guy, anime, tag) {
  pain = guy.allowPain;
  guy disable_pain();

  self anim_generic_custom_animmode(guy, "gravity", anime, tag);

  if(pain)
    guy enable_pain();
}

anim_generic_run(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, CONST_anim_end_time, "generic");
}

anim_generic_reach(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_reach(guys, anime, tag, "generic");
}

anim_generic_reach_and_arrive(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_reach_with_funcs(guys, anime, tag, "generic", ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end);
}

anim_reach_and_plant(guys, anime, tag) {
  anim_reach_with_funcs(guys, anime, tag, undefined, ::reach_with_planting, ::reach_with_standard_adjustments_end);
}

anim_reach_and_plant_and_arrive(guys, anime, tag) {
  anim_reach_with_funcs(guys, anime, tag, undefined, ::reach_with_planting_and_arrivals, ::reach_with_standard_adjustments_end);
}

anim_generic_loop(guy, anime, ender, tag) {
  packet = [];
  packet["guy"] = guy;
  packet["entity"] = self;
  packet["tag"] = tag;
  guyPackets[0] = packet;

  anim_loop_packet(guyPackets, anime, ender, "generic");
}

anim_custom_animmode(guys, custom_animmode, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  aguy = undefined;
  foreach(guy in guys) {
    aguy = guy;
    assertex(isDefined(guy.animname), "Guy wants to do animmode custom but has no animname");
    thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, guy.animname, false);
  }

  AssertEx(isDefined(aguy), "anim_custom_animmode called without a guy in the array");
  aguy wait_until_anim_finishes(anime);

  self notify(anime);
}

anim_custom_animmode_loop(guys, custom_animmode, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  foreach(guy in guys) {
    thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, guy.animname, true);
  }

  AssertEx(isDefined(guys[0]), "anim_custom_animmode called without a guy in the array");
  guys[0] wait_until_anim_finishes(anime);

  self notify(anime);
}

wait_until_anim_finishes(anime) {
  self endon("finished_custom_animmode" + anime);
  self waittill("death");
}

anim_generic_custom_animmode(guy, custom_animmode, anime, tag, thread_func) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, "generic", false, thread_func);
  guy wait_until_anim_finishes(anime);
  self notify(anime);
}

anim_generic_custom_animmode_loop(guy, custom_animmode, anime, tag, thread_func) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, "generic", true, thread_func);
  guy wait_until_anim_finishes(anime);
  self notify(anime);
}

anim_custom_animmode_solo(guy, custom_animmode, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_custom_animmode(guys, custom_animmode, anime, tag);
}

anim_first_frame_solo(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_first_frame(guys, anime, tag);
}

assert_existance_of_anim(anime, animname) {
  if(!isDefined(animname))
    animname = self.animname;

  AssertEx(isDefined(animname), "Animating character of type " + self.classname + " has no animname.");

  has_anim = false;
  if(isDefined(level.scr_anim[animname])) {
    has_anim = true;
    if(isDefined(level.scr_anim[animname][anime])) {
      return;
    }
  }

  has_sound = false;
  if(isDefined(level.scr_sound[animname])) {
    has_sound = true;
    if(isDefined(level.scr_sound[animname][anime])) {
      return;
    }
  }

  if(has_anim || has_sound) {
    if(has_anim) {
      array = GetArrayKeys(level.scr_anim[animname]);
      PrintLn("Legal anime scenes for " + animname + ":");
      foreach(member in array) {
        PrintLn(member);
      }
    }
    if(has_sound) {
      array = GetArrayKeys(level.scr_sound[animname]);
      PrintLn("Legal scr_sound scenes for " + animname + ":");
      foreach(member in array) {
        PrintLn(member);
      }
    }
    PrintLn("Guy with animname " + animname + " is trying to do scene " + anime + " there is no level.scr_anim or level.scr_sound for that animname");
    AssertMsg("That scene doesn't exist! See above in console log for details.");
    return;
  }

  keys = GetArrayKeys(level.scr_anim);
  keys = array_combine(keys, GetArrayKeys(level.scr_sound));
  foreach(key in keys) {
    PrintLn(key);
  }
  AssertMsg("Animname " + animname + " is not setup to do animations. See above for list of legal animnames.");
}

anim_first_frame_on_guy(guy, anime, org, angles, animname_override) {
  guy.first_frame_time = GetTime();

  if(isDefined(animname_override))
    animname = animname_override;
  else
    animname = guy.animname;

  guy set_start_pos(anime, org, angles, animname);

  guy assert_existance_of_anim(anime, animname);

  if(IsAI(guy)) {
    guy._first_frame_anim = anime;
    guy._animname = animname;
    guy AnimCustom(animscripts\first_frame::main);
  } else {
    guy StopAnimScripted();
    guy SetAnimKnob(level.scr_anim[animname][anime], 1, 0, 0);
  }
}

anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, animname_override, loop, thread_func) {
  if(IsAI(guy) && guy doingLongDeath()) {
    return;
  }
  animname = undefined;
  if(isDefined(animname_override))
    animname = animname_override;
  else
    animname = guy.animname;

  guy assert_existance_of_anim(anime, animname);

  AssertEx(IsAI(guy), "Tried to do custom_animmode on a non ai");

  guy set_start_pos(anime, org, angles, animname_override, loop);

  guy._animmode = custom_animmode;
  guy._custom_anim = anime;
  guy._tag_entity = self;
  guy._anime = anime;
  guy._animname = animname;
  guy._custom_anim_loop = loop;
  guy._custom_anim_thread = thread_func;
  guy AnimCustom(animscripts\animmode::main);
}

anim_loop(guys, anime, ender, tag) {
  guyPackets = [];
  foreach(guy in guys) {
    packet = [];
    packet["guy"] = guy;
    packet["entity"] = self;
    packet["tag"] = tag;
    guyPackets[guyPackets.size] = packet;
  }

  anim_loop_packet(guyPackets, anime, ender);
}

anim_loop_packet_solo(singleGuyPacket, anime, ender) {
  loopPacket = [];
  loopPacket[0] = singleGuyPacket;
  anim_loop_packet(loopPacket, anime, ender);
}

anim_loop_packet(guyPackets, anime, ender, animname_override) {
  foreach(guyPacket in guyPackets) {
    guy = guyPacket["guy"];
    if(!isDefined(guy)) {
      continue;
    }
    if(!isDefined(guy._animActive))
      guy._animActive = 0;

    guy endon("death");
    guy._animActive++;
  }

  baseGuy = guyPackets[0]["guy"];

  if(!isDefined(baseGuy.loops)) {
    baseGuy.loops = 0;
  }

  thread printloops(baseGuy, anime);

  if(!isDefined(ender))
    ender = "stop_loop";

  thread endonRemoveAnimActive(ender, guyPackets);

  self endon(ender);

  self thread looping_anim_ender(baseGuy, ender);

  anim_string = "looping anim";

  base_animname = undefined;
  if(isDefined(animname_override))
    base_animname = animname_override;
  else
    base_animname = baseGuy.animname;

  idleanim = 0;
  lastIdleanim = 0;
  while(1) {
    idleanim = anim_weight(base_animname, anime);
    while((idleanim == lastIdleanim) && (idleanim != 0))
      idleanim = anim_weight(base_animname, anime);
    lastIdleanim = idleanim;

    scriptedAnimationIndex = undefined;
    scriptedAnimationTime = 999999;

    scriptedSoundIndex = undefined;
    guy = undefined;
    foreach(i, guyPacket in guyPackets) {
      entity = guyPacket["entity"];
      guy = guyPacket["guy"];
      pos = entity get_anim_position(guyPacket["tag"]);
      org = pos["origin"];
      angles = pos["angles"];

      if(isDefined(guy.remove_from_animloop)) {
        guy.remove_from_animloop = undefined;
        guyPackets[i] = undefined;
        continue;
      }

      doFacialanim = false;
      doDialogue = false;
      doAnimation = false;
      doText = false;
      facialAnim = undefined;
      dialogue = undefined;
      animname = undefined;
      if(isDefined(animname_override))
        animname = animname_override;
      else
        animname = guy.animname;

      if((isDefined(level.scr_face[animname])) && (isDefined(level.scr_face[animname][anime])) && (isDefined(level.scr_face[animname][anime][idleanim]))) {
        doFacialanim = true;
        facialAnim = level.scr_face[animname][anime][idleanim];
      }

      if((isDefined(level.scr_sound[animname])) && (isDefined(level.scr_sound[animname][anime])) && (isDefined(level.scr_sound[animname][anime][idleanim]))) {
        doDialogue = true;
        dialogue = level.scr_sound[animname][anime][idleanim];
      }

      if(isDefined(level.scr_animSound[animname]) && isDefined(level.scr_animSound[animname][idleanim + anime])) {
        guy playSound(level.scr_animSound[animname][idleanim + anime]);
      }

      if(GetDebugDvar("animsound") == "on") {
        guy thread animsound_start_tracker_loop(anime, idleanim, animname);
      }

      if((isDefined(level.scr_anim[animname])) && (isDefined(level.scr_anim[animname][anime])) && (!isAI(guy) || !guy doingLongDeath()))
        doAnimation = true;

      if((isDefined(level.scr_text[animname])) && (isDefined(level.scr_text[animname][anime])))
        doText = true;

      if(doAnimation) {
        guy last_anim_time_check();
        guy AnimScripted(anim_string, org, angles, level.scr_anim[animname][anime][idleanim]);

        animtime = GetAnimLength(level.scr_anim[animname][anime][idleanim]);
        if(animtime < scriptedAnimationTime) {
          scriptedAnimationTime = animtime;
          scriptedAnimationIndex = i;
        }

        thread start_notetrack_wait(guy, anim_string, anime, animname);

        thread animscriptDoNoteTracksThread(guy, anim_string, anime);
      }

      if((doFacialanim) || (doDialogue)) {
        if(IsAI(guy)) {
          if(doAnimation)
            guy SaySpecificDialogue(facialAnim, dialogue, 1.0);
          else
            guy SaySpecificDialogue(facialAnim, dialogue, 1.0, anim_string);
        } else {
          guy play_sound_on_entity(dialogue);
        }

        scriptedSoundIndex = i;
      }

      if(doText && !doDialogue)
        IPrintLnBold(level.scr_text[animname][anime]);
    }

    if(!isDefined(guy)) {
      break;
    }

    if(isDefined(scriptedAnimationIndex))
      guyPackets[scriptedAnimationIndex]["guy"] waittillmatch(anim_string, "end");
    else
    if(isDefined(scriptedSoundIndex))
      guyPackets[scriptedSoundIndex]["guy"] waittill(anim_string);
  }
}

start_notetrack_wait(guy, anim_string, anime, animname) {
  guy notify("stop_sequencing_notetracks");

  thread notetrack_wait(guy, anim_string, self, anime, animname);
}

anim_single_failsafeOnGuy(owner, anime) {
  if(GetDebugDvar("debug_grenadehand") != "on") {
    return;
  }
  owner endon(anime);
  owner endon("death");
  self endon("death");
  name = self.classname;
  num = self GetEntNum();
  wait(60);
  PrintLn("Guy had classname " + name + " and entnum " + num);
  waittillframeend;
  AssertEx(0, "Animation '" + anime + "' did not finish after 60 seconds. See note above");
}

anim_single_failsafe(guys, anime) {
  foreach(guy in guys)
  guy thread anim_single_failsafeOnGuy(self, anime);
}

anim_single(guys, anime, tag, anim_end_time, animname_override) {
  if(!isDefined(anim_end_time))
    anim_end_time = 0;
  anim_single_internal(guys, anime, tag, anim_end_time, animname_override);
}

anim_single_run(guys, anime, tag, animname_override) {
  anim_single_internal(guys, anime, tag, CONST_anim_end_time, animname_override);
}

anim_single_internal(guys, anime, tag, anim_end_time, animname_override) {
  entity = self;

  thread anim_single_failsafe(guys, anime);

  foreach(guy in guys) {
    if(!isDefined(guy))
      continue;
    if(!isDefined(guy._animActive))
      guy._animActive = 0;
    guy._animActive++;
  }

  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  scriptedAnimationIndex = undefined;
  scriptedAnimationTime = 999999;

  scriptedSoundIndex = undefined;
  scriptedFaceIndex = undefined;
  scriptedFaceAnim = undefined;
  anim_string = "single anim";

  foreach(i, guy in guys) {
    doFacialanim = false;
    doDialogue = false;
    doAnimation = false;
    doText = false;

    dialogue = undefined;
    facialAnim = undefined;

    animname = undefined;
    if(isDefined(animname_override))
      animname = animname_override;
    else
      animname = guy.animname;

    guy assert_existance_of_anim(anime, animname);

    if((isDefined(level.scr_face[animname])) && (isDefined(level.scr_face[animname][anime]))) {
      doFacialanim = true;
      facialAnim = level.scr_face[animname][anime];
      scriptedFaceAnim = facialAnim;
    }

    if((isDefined(level.scr_sound[animname])) && (isDefined(level.scr_sound[animname][anime]))) {
      doDialogue = true;
      dialogue = level.scr_sound[animname][anime];
    }

    if((isDefined(level.scr_anim[animname])) && (isDefined(level.scr_anim[animname][anime])) && (!isAI(guy) || !guy doingLongDeath()))
      doAnimation = true;

    if(isDefined(level.scr_animSound[animname]) && isDefined(level.scr_animSound[animname][anime])) {
      guy playSound(level.scr_animSound[animname][anime]);
    }

    if(GetDebugDvar("animsound") == "on") {
      guy thread animsound_start_tracker(anime, animname);
    }

    if((isDefined(level.scr_text[animname])) && (isDefined(level.scr_text[animname][anime])))
      doText = true;

    if(doAnimation) {
      guy last_anim_time_check();
      if(isPlayer(guy)) {
        root_animation = level.scr_anim[animname]["root"];
        guy SetAnim(root_animation, 0, 0.2);

        animation = level.scr_anim[animname][anime];
        guy SetFlaggedAnim(anim_string, animation, 1, 0.2);
      } else
      if(guy.code_classname == "misc_turret") {
        animation = level.scr_anim[animname][anime];
        guy SetFlaggedAnim(anim_string, animation, 1, 0.2);
      } else {
        guy AnimScripted(anim_string, org, angles, level.scr_anim[animname][anime]);
      }

      animtime = GetAnimLength(level.scr_anim[animname][anime]);
      if(animtime < scriptedAnimationTime) {
        scriptedAnimationTime = animtime;
        scriptedAnimationIndex = i;
      }

      thread start_notetrack_wait(guy, anim_string, anime, animname);
      thread animscriptDoNoteTracksThread(guy, anim_string, anime);
    }

    if((doFacialanim) || (doDialogue)) {
      println("**dialog alias playing locally: " + dialogue);

      if(doFacialAnim) {
        if(doDialogue)
          guy thread delayedDialogue(anime, doFacialanim, dialogue, level.scr_face[animname][anime]);
        AssertEx(!doanimation, "Can't play a facial anim and fullbody anim at the same time. The facial anim should be in the full body anim. Occurred on animation " + anime);
        thread anim_facialAnim(guy, anime, level.scr_face[animname][anime]);
        scriptedFaceIndex = i;
      } else {
        if(IsAI(guy)) {
          if(doAnimation)
            guy SaySpecificDialogue(facialAnim, dialogue, 1.0);
          else {
            guy thread anim_facialFiller("single dialogue");
            guy SaySpecificDialogue(facialAnim, dialogue, 1.0, "single dialogue");
          }
        } else {
          guy thread play_sound_on_entity(dialogue, "single dialogue");
        }
      }

      scriptedSoundIndex = i;
    }
    AssertEx(doAnimation || doFacialanim || doDialogue || doText, "Tried to do anim scene " + anime + " on guy with animname " + animname + ", but he didn't have that anim scene.");

    if(doText && !doDialogue) {
      IPrintLnBold(level.scr_text[animname][anime]);
      wait 1.5;
    }
  }

  if(isDefined(scriptedAnimationIndex)) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[scriptedAnimationIndex], anime);
    ent thread anim_animationEndNotify(guys[scriptedAnimationIndex], anime, scriptedAnimationTime, anim_end_time);
    ent waittill(anime);
  } else
  if(isDefined(scriptedFaceIndex)) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[scriptedFaceIndex], anime);
    ent thread anim_facialEndNotify(guys[scriptedFaceIndex], anime, scriptedFaceAnim);
    ent waittill(anime);
  } else
  if(isDefined(scriptedSoundIndex)) {
    ent = spawnStruct();
    ent thread anim_deathNotify(guys[scriptedSoundIndex], anime);
    ent thread anim_dialogueEndNotify(guys[scriptedSoundIndex], anime);
    ent waittill(anime);
  }

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    if(isPlayer(guy)) {
      animname = undefined;
      if(isDefined(animname_override))
        animname = animname_override;
      else
        animname = guy.animname;

      if(isDefined(level.scr_anim[animname][anime])) {
        root_animation = level.scr_anim[animname]["root"];
        guy setanim(root_animation, 1, 0.2);

        animation = level.scr_anim[animname][anime];
        guy ClearAnim(animation, 0.2);
      }
    }

    guy._animActive--;
    guy._lastAnimTime = GetTime();
    Assert(guy._animactive >= 0);
  }
  self notify(anime);
}

anim_deathNotify(guy, anime) {
  self endon(anime);
  guy waittill("death");
  self notify(anime);
}

anim_facialEndNotify(guy, anime, scriptedFaceAnim) {
  self endon(anime);
  time = getanimlength(scriptedFaceAnim);
  wait(time);

  self notify(anime);
}

anim_dialogueEndNotify(guy, anime) {
  self endon(anime);
  guy waittill("single dialogue");
  self notify(anime);
}

anim_animationEndNotify(guy, anime, scriptedAnimationTime, anim_end_time) {
  self endon(anime);
  guy endon("death");
  scriptedAnimationTime -= anim_end_time;
  if(anim_end_time > 0 && scriptedAnimationTime > 0) {
    guy waittill_match_or_timeout("single anim", "end", scriptedAnimationTime);
    guy StopAnimScripted();
  } else {
    guy waittillmatch("single anim", "end");
  }
  self notify(anime);
}

animscriptDoNoteTracksThread(guy, animstring, anime) {
  if(isDefined(guy.dontdonotetracks) && guy.dontdonotetracks)
    return;
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

animSound_exists(anime, notetrack) {
  notetrack = ToLower(notetrack);

  keys = GetArrayKeys(self.animSounds);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(self.animSounds[key].anime != anime)
      continue;
    if(self.animSounds[key].notetrack != notetrack) {
      continue;
    }
    self.animSounds[key].end_time = GetTime() + 60000;
    return true;
  }
  return false;
}

animsound_tracker(anime, notetrack, animname) {
  notetrack = ToLower(notetrack);

  add_to_animsound();

  if(notetrack == "end") {
    return;
  }
  if(animSound_exists(anime, notetrack)) {
    return;
  }
  newTrack = spawnStruct();
  newTrack.anime = anime;
  newTrack.notetrack = notetrack;
  newTrack.animname = animname;
  newTrack.end_time = GetTime() + 60000;

  add_animsound(newTrack);
}

animsound_start_tracker(anime, animname) {
  add_to_animsound();

  newSound = spawnStruct();
  newSound.anime = anime;
  newSound.notetrack = "#" + anime;
  newSound.animname = animname;
  newSound.end_time = GetTime() + 60000;

  if(animSound_exists(anime, newSound.notetrack)) {
    return;
  }
  add_animsound(newSound);
}

animsound_start_tracker_loop(anime, loop, animname) {
  add_to_animsound();

  anime = loop + anime;
  newSound = spawnStruct();
  newSound.anime = anime;
  newSound.notetrack = "#" + anime;
  newSound.animname = animname;
  newSound.end_time = GetTime() + 60000;

  if(animSound_exists(anime, newSound.notetrack)) {
    return;
  }
  add_animsound(newSound);
}

notetrack_wait(guy, msg, tag_entity, anime, animname_override) {
  guy endon("stop_sequencing_notetracks");
  guy endon("death");

  if(isDefined(tag_entity))
    tag_owner = tag_entity;
  else
    tag_owner = self;

  animname = undefined;
  if(isDefined(animname_override))
    animname = animname_override;
  else
    animname = guy.animname;

  dialogue_array = spawnStruct();
  dialogue_array.dialog = [];
  scripted_notetracks = [];

  if(isDefined(animname) && isDefined(level.scr_notetrack[animname])) {
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
        if(isDefined(scr_notetrack["dialog"]))
          dialogue_array.dialog[scr_notetrack["dialog"]] = true;
      }
    }
  }

  while(1) {
    dialogue_array.dialogueNotetrack = false;

    notetrack = undefined;
    guy waittill(msg, notetrack);

    if(GetDebugDvar("animsound") == "on") {
      guy thread animsound_tracker(anime, notetrack, animname);
    }

    if(notetrack == "end") {
      return;
    }
    foreach(anime_key, _ in scripted_notetracks) {
      if(isDefined(level.scr_notetrack[animname][anime_key][notetrack])) {
        foreach(scr_notetrack in level.scr_notetrack[animname][anime_key][notetrack]) {
          anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner);
        }
      }
    }

    prefix = GetSubStr(notetrack, 0, 3);

    if(prefix == "ps_") {
      alias = GetSubStr(notetrack, 3);

      guy thread play_sound_on_tag(alias, undefined, true);
      continue;
    }

    switch (notetrack) {
      case "ignoreall true":
        self.ignoreall = true;
        break;
      case "ignoreall false":
        self.ignoreall = false;
        break;
      case "ignoreme true":
        self.ignoreme = true;
        break;
      case "ignoreme false":
        self.ignoreme = false;
        break;
      case "allowdeath true":
        self.allowdeath = true;
        break;
      case "allowdeath false":
        self.allowdeath = false;
        break;
    }
  }
}

anim_handle_notetrack(scr_notetrack, guy, dialogue_array, tag_owner) {
  if(isDefined(scr_notetrack["function"]))
    self thread[[scr_notetrack["function"]]](guy);

  if(isDefined(scr_notetrack["flag"])) {
    flag_set(scr_notetrack["flag"]);
  }

  if(isDefined(scr_notetrack["flag_clear"])) {
    flag_clear(scr_notetrack["flag_clear"]);
  }

  if(isDefined(scr_notetrack["attach gun left"])) {
    guy gun_pickup_left();
    return;
  }

  if(isDefined(scr_notetrack["attach gun right"])) {
    guy gun_pickup_right();
    return;
  }

  if(isDefined(scr_notetrack["detach gun"])) {
    self gun_leave_behind(guy, scr_notetrack);
    return;
  }

  if(isDefined(scr_notetrack["attach model"])) {
    if(isDefined(scr_notetrack["selftag"]))
      guy Attach(scr_notetrack["attach model"], scr_notetrack["selftag"]);
    else
      tag_owner Attach(scr_notetrack["attach model"], scr_notetrack["tag"]);

    return;
  }

  if(isDefined(scr_notetrack["detach model"])) {
    waittillframeend;
    if(isDefined(scr_notetrack["selftag"]))
      guy Detach(scr_notetrack["detach model"], scr_notetrack["selftag"]);
    else
      tag_owner Detach(scr_notetrack["detach model"], scr_notetrack["tag"]);
  }

  if(isDefined(scr_notetrack["sound"]))
    guy thread play_sound_on_tag(scr_notetrack["sound"], undefined, true);

  if(!dialogue_array.dialogueNotetrack) {
    if(isDefined(scr_notetrack["dialog"]) && isDefined(dialogue_array.dialog[scr_notetrack["dialog"]])) {
      guy SaySpecificDialogue(undefined, scr_notetrack["dialog"], 1.0);
      dialogue_array.dialog[scr_notetrack["dialog"]] = undefined;
      dialogue_array.dialogueNotetrack = true;
    }
  }

  if(isDefined(scr_notetrack["create model"]))
    anim_addModel(guy, scr_notetrack);
  else
  if(isDefined(scr_notetrack["delete model"]))
    anim_removeModel(guy, scr_notetrack);

  if((isDefined(scr_notetrack["selftag"])) && (isDefined(scr_notetrack["effect"]))) {
    playFXOnTag(level._effect[scr_notetrack["effect"]], guy, scr_notetrack["selftag"]);
  }

  if(isDefined(scr_notetrack["tag"]) && isDefined(scr_notetrack["effect"])) {
    playFXOnTag(level._effect[scr_notetrack["effect"]], tag_owner, scr_notetrack["tag"]);
  }
}

anim_addModel(guy, array) {
  if(!isDefined(guy.ScriptModel))
    guy.ScriptModel = [];

  index = guy.ScriptModel.size;
  guy.ScriptModel[index] = spawn("script_model", (0, 0, 0));
  guy.ScriptModel[index] setModel(array["create model"]);
  guy.ScriptModel[index].origin = guy GetTagOrigin(array["selftag"]);
  guy.ScriptModel[index].angles = guy GetTagAngles(array["selftag"]);
}

anim_removeModel(guy, array) {
  if(!isDefined(guy.ScriptModel))
    AssertMsg("Tried to remove a model with delete model before it was create model'd on guy: " + guy.animname);

  for(i = 0; i < guy.ScriptModel.size; i++) {
    if(isDefined(array["explosion"])) {
      forward = anglesToForward(guy.scriptModel[i].angles);
      forward = vector_multiply(forward, 120);
      forward += guy.scriptModel[i].origin;
      playFX(level._effect[array["explosion"]], guy.scriptModel[i].origin);
      RadiusDamage(guy.scriptModel[i].origin, 350, 700, 50);
    }
    guy.scriptModel[i] Delete();
  }
}

gun_pickup_left() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground Delete();
  self.DropWeapon = true;

  self animscripts\shared::placeWeaponOn(self.weapon, "left");
}

gun_pickup_right() {
  if(!isDefined(self.gun_on_ground)) {
    return;
  }
  self.gun_on_ground Delete();
  self.DropWeapon = true;

  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}

gun_leave_behind(guy, scr_notetrack) {
  if(isDefined(guy.gun_on_ground)) {
    return;
  }
  link = true;

  if(self == guy)
    link = false;

  gun = spawn("weapon_" + guy.weapon, (0, 0, 0));

  guy.gun_on_ground = gun;
  gun.origin = self GetTagOrigin(scr_notetrack["tag"]);
  gun.angles = self GetTagAngles(scr_notetrack["tag"]);

  if(link)
    gun LinkTo(self, scr_notetrack["tag"], (0, 0, 0), (0, 0, 0));
  else {
    org = spawn("script_origin", (0, 0, 0));
    org.origin = gun.origin;
    org.angles = gun.angles;
    level thread gun_killOrigin(gun, org);
  }

  guy animscripts\shared::placeWeaponOn(self.weapon, "none");
  guy.DropWeapon = false;
}

gun_killOrigin(gun, org) {
  gun waittill("death");
  org Delete();
}

anim_weight(animname, anime) {
  AssertEx(isDefined(level.scr_anim[animname][anime]), "There is no animation scene \"" + anime + "\" for animname " + animname);
  AssertEx(IsArray(level.scr_anim[animname][anime]), "the animation entry for level.scr_anim[ " + animname + " ][ " + anime + " ] needs to be an array of looping animations, not a single animation");
  total_anims = level.scr_anim[animname][anime].size;
  idleanim = RandomInt(total_anims);
  if(total_anims > 1) {
    weights = 0;
    anim_weight = 0;

    for(i = 0; i < total_anims; i++) {
      if(isDefined(level.scr_anim[animname][anime + "weight"])) {
        if(isDefined(level.scr_anim[animname][anime + "weight"][i])) {
          weights++;
          anim_weight += level.scr_anim[animname][anime + "weight"][i];
        }
      }
    }

    if(weights == total_anims) {
      anim_play = RandomFloat(anim_weight);
      anim_weight = 0;

      for(i = 0; i < total_anims; i++) {
        anim_weight += level.scr_anim[animname][anime + "weight"][i];
        if(anim_play < anim_weight) {
          idleanim = i;
          break;
        }
      }
    }
  }

  return idleanim;
}

anim_reach_and_idle(guys, anime, anime_idle, ender, tag) {
  thread anim_reach(guys, anime, tag);

  ent = spawnStruct();
  ent.reachers = 0;
  foreach(guy in guys) {
    ent.reachers++;
    thread idle_on_reach(guy, anime_idle, ender, tag, ent);
  }

  for(;;) {
    ent waittill("reached_position");
    if(ent.reachers <= 0)
      return;
  }
}

wait_for_guy_to_die_or_get_in_position() {
  self endon("death");
  self waittill("anim_reach_complete");
}

idle_on_reach(guy, anime_idle, ender, tag, ent) {
  guy wait_for_guy_to_die_or_get_in_position();
  ent.reachers--;
  ent notify("reached_position");

  if(IsAlive(guy))
    anim_loop_solo(guy, anime_idle, ender, tag);
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

anim_reach_together(guys, anime, tag, animname_override) {
  thread modify_moveplaybackrate_together(guys);

  anim_reach_with_funcs(guys, anime, tag, animname_override, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end);
}

modify_moveplaybackrate_together(ai) {
  max_playback = 0.3;

  waittillframeend;
  for(;;) {
    ai = remove_dead_from_array(ai);

    dists = [];
    average_dist = 0;
    foreach(index, guy in ai) {
      pos = guy.goalpos;
      if(isDefined(guy.reach_goal_pos)) {
        pos = guy.reach_goal_pos;
      }

      dist = Distance(guy.origin, pos);
      dists[guy.unique_id] = dist;

      if(dist <= 4) {
        ai[index] = undefined;
        continue;
      }

      average_dist += dist;
    }

    if(ai.size <= 1) {
      break;
    }

    average_dist /= ai.size;

    foreach(guy in ai) {
      dif = dists[guy.unique_id] - average_dist;
      playback = dif * 0.003;
      if(playback > max_playback)
        playback = max_playback;
      else
      if(playback < max_playback * -1)
        playback = max_playback * -1;
      guy.moveplaybackrate = 1 + playback;
    }
    wait(0.05);
  }

  foreach(guy in ai) {
    if(IsAlive(guy))
      guy.moveplaybackrate = 1;
  }
}

anim_reach(guys, anime, tag, animname_override) {
  anim_reach_with_funcs(guys, anime, tag, animname_override, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end);
}

anim_reach_with_funcs(guys, anime, tag, animname_override, start_func, end_func, arrival_type) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];

  if(isDefined(arrival_type)) {
    AssertEx(!isDefined(self.type), "type already defined");
    self.type = arrival_type;
    self.arrivalStance = "stand";
  }

  ent = spawnStruct();
  debugStartpos = false;

  debugStartpos = GetDebugDvar("debug_animreach") == "on";

  threads = 0;
  foreach(guy in guys) {
    if(isDefined(arrival_type))
      guy.scriptedarrivalent = self;

    if(isDefined(animname_override))
      animname = animname_override;
    else
      animname = guy.animname;

    if(isDefined(level.scr_anim[animname][anime])) {
      if(IsArray(level.scr_anim[animname][anime]))
        startorg = GetStartOrigin(org, angles, level.scr_anim[animname][anime][0]);
      else
        startorg = GetStartOrigin(org, angles, level.scr_anim[animname][anime]);
    } else {
      startorg = org;
    }

    if(debugStartpos)
      thread debug_message_clear("x", startorg, 1000, "clearAnimDebug");

    threads++;
    guy thread begin_anim_reach(ent, startOrg, start_func, end_func);
  }

  while(threads) {
    ent waittill("reach_notify");
    threads--;
  }

  if(debugStartpos)
    level notify("x" + "clearAnimDebug");

  foreach(guy in guys) {
    if(!isalive(guy)) {
      continue;
    }
    guy.goalradius = guy.oldgoalradius;
    guy.scriptedarrivalent = undefined;
    guy.stopAnimDistSq = 0;
  }

  if(isDefined(arrival_type))
    self.type = undefined;
}

anim_teleport(guys, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    startorg = GetStartOrigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = GetStartAngles(org, angles, level.scr_anim[guy.animname][anime]);
    if(IsAI(guy))
      guy Teleport(startorg);
    else {
      guy.origin = startorg;
      guy.angles = startang;
    }
  }
}

anim_generic_teleport(guy, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  startorg = GetStartOrigin(org, angles, level.scr_anim["generic"][anime]);
  startang = GetStartAngles(org, angles, level.scr_anim["generic"][anime]);
  if(IsAI(guy)) {
    guy Teleport(startorg);
  } else {
    guy.origin = startorg;
    guy.angles = startang;
  }
}

anim_spawn_generic_model(model, anime, tag) {
  return anim_spawn_model(model, "generic", anime, tag);
}

anim_spawn_model(model, animname, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  startorg = GetStartOrigin(org, angles, level.scr_anim[animname][anime]);
  startangles = GetStartOrigin(org, angles, level.scr_anim[animname][anime]);

  spawned = spawn("script_model", startorg);
  spawned setModel(model);
  spawned.angles = startangles;
  return spawned;
}

anim_spawn_tag_model(model, tag) {
  self Attach(model, tag);
}

anim_link_tag_model(model, tag) {
  org = self GetTagOrigin(tag);
  spawned = spawn("script_model", org);
  spawned setModel(model);
  spawned LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  return spawned;
}

anim_spawner_teleport(guys, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  ent = spawnStruct();

  foreach(guy in guys) {
    startorg = GetStartOrigin(org, angles, level.scr_anim[guy.animname][anime]);
    guy.origin = startorg;
  }
}

reach_death_notify(ent) {
  self waittill_either("death", "goal");
  ent notify("reach_notify");
}

begin_anim_reach(ent, startOrg, start_func, end_func) {
  self endon("death");
  self endon("new_anim_reach");
  thread reach_death_notify(ent);
  startorg = [[start_func]](startorg);

  self set_goal_pos(startorg);
  self.reach_goal_pos = startorg;
  self.goalradius = 0;
  self.stopAnimDistSq = squared(64);

  self waittill("goal");

  self notify("anim_reach_complete");

  [[end_func]]();

  self notify("new_anim_reach");
}

reach_with_standard_adjustments_begin(startorg) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyFightdist = self.pathenemyFightdist;
  self.oldpathenemyLookahead = self.pathenemyLookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  disable_ai_color();
  self anim_changes_pushplayer(true);
  self.nododgemove = true;
  self.fixedNodeWasOn = self.fixedNode;
  self.fixednode = false;

  if(!isDefined(self.scriptedArrivalEnt)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = true;
  }
  self.reach_goal_pos = undefined;
  return startorg;
}

reach_with_standard_adjustments_end() {
  self anim_changes_pushplayer(false);

  self.nododgemove = false;
  self.fixednode = self.fixedNodeWasOn;
  self.fixedNodeWasOn = undefined;

  self.pathenemyfightdist = self.oldpathenemyFightdist;
  self.pathenemylookahead = self.oldpathenemyLookahead;
  self.disablearrivals = self.old_disablearrivals;
}

anim_changes_pushplayer(value) {
  if(isDefined(self.dontchangepushplayer))
    assert(self.dontchangepushplayer == true);
  else
    self pushplayer(value);
}

reach_with_arrivals_begin(startorg) {
  startorg = reach_with_standard_adjustments_begin(startorg);
  self.disablearrivals = false;
  return startorg;
}

reach_with_planting(startorg) {
  newOrigin = self GetDropToFloorPosition(startorg);
  Assert(isDefined(newOrigin));
  startorg = newOrigin;

  startorg = reach_with_standard_adjustments_begin(startorg);
  self.disablearrivals = true;
  return startorg;
}

reach_with_planting_and_arrivals(startorg) {
  newOrigin = self GetDropToFloorPosition(startorg);
  Assert(isDefined(newOrigin));
  startorg = newOrigin;

  startorg = reach_with_standard_adjustments_begin(startorg);
  self.disablearrivals = false;
  return startorg;
}

printloops(guy, anime) {
  if(!isDefined(guy)) {
    return;
  }
  guy endon("death");
  waittillframeend;

  guy.loops++;
  if(guy.loops > 1)
    AssertMsg("guy with name " + guy.animname + " has " + guy.loops + " looping animations played, anime: " + anime);
}

looping_anim_ender(guy, ender) {
  guy endon("death");
  self waittill(ender);
  guy.loops--;
}

get_animtree(guys) {
  foreach(guy in guys)
  guy UseAnimTree(level.scr_animtree[guy.animname]);
}

SetAnimTree() {
  self UseAnimTree(level.scr_animtree[self.animname]);
}

anim_single_solo(guy, anime, tag, anim_end_time, animname_override) {
  self endon("death");

  newguy[0] = guy;
  if(!isDefined(anim_end_time))
    anim_end_time = 0;
  anim_single(newguy, anime, tag, anim_end_time, animname_override);
}

anim_single_solo_run(guy, anime, tag) {
  self endon("death");
  newguy[0] = guy;
  anim_single(newguy, anime, tag, CONST_anim_end_time);
}

anim_single_run_solo(guy, anime, tag, anim_end_time) {
  self endon("death");

  newguy[0] = guy;
  anim_single(newguy, anime, tag, CONST_anim_end_time);
}

anim_reach_and_idle_solo(guy, anime, anime_idle, ender, tag) {
  self endon("death");

  newguy[0] = guy;
  anim_reach_and_idle(newguy, anime, anime_idle, ender, tag);
}

anim_reach_solo(guy, anime, tag) {
  self endon("death");

  newguy[0] = guy;
  anim_reach(newguy, anime, tag);
}

anim_reach_and_approach_solo(guy, anime, tag, arrival_type) {
  self endon("death");

  newguy[0] = guy;
  anim_reach_and_approach(newguy, anime, tag, arrival_type);
}

anim_reach_and_approach_node_solo(guy, anime, tag) {
  self endon("death");

  newguy[0] = guy;

  arrivalEnt = spawn("script_origin", self.origin);
  arrivalEnt.type = self.type;
  arrivalEnt.angles = self.angles;
  arrivalEnt.arrivalStance = self GetHighestNodeStance();

  guy.scriptedarrivalent = arrivalEnt;
  anim_reach_and_approach(newguy, anime, tag);
  guy.scriptedarrivalent = undefined;

  arrivalEnt Delete();

  while(guy.a.movement != "stop")
    wait 0.05;
}

anim_reach_and_approach(guys, anime, tag, arrival_type) {
  self endon("death");

  anim_reach_with_funcs(guys, anime, tag, undefined, ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end, arrival_type);
}

anim_loop_solo(guy, anime, ender, tag) {
  self endon("death");
  guy endon("death");

  newguy[0] = guy;
  anim_loop(newguy, anime, ender, tag);
}

anim_teleport_solo(guy, anime, tag) {
  self endon("death");

  newguy[0] = guy;
  anim_teleport(newguy, anime, tag);
}

add_animation(animname, anime) {
  if(!isDefined(level.completedAnims))
    level.completedAnims[animname][0] = anime;
  else {
    if(!isDefined(level.completedAnims[animname]))
      level.completedAnims[animname][0] = anime;
    else {
      for(i = 0; i < level.completedAnims[animname].size; i++) {
        if(level.completedAnims[animname][i] == anime)
          return;
      }

      level.completedAnims[animname][level.completedAnims[animname].size] = anime;
    }
  }
}

anim_single_queue(guy, anime, tag, anim_end_time) {
  if(!isDefined(anim_end_time))
    anim_end_time = 0;
  AssertEx(isDefined(anime), "Tried to do anim_single_queue without passing a scene name (anime)");

  if(isDefined(guy.last_queue_time)) {
    wait_for_buffer_time_to_pass(guy.last_queue_time, 0.5);
  }

  function_stack(::anim_single_solo, guy, anime, tag, anim_end_time);

  if(IsAlive(guy))
    guy.last_queue_time = GetTime();
}

anim_generic_queue(guy, anime, tag, anim_end_time, timeout) {
  guy endon("death");
  if(!isDefined(anim_end_time))
    anim_end_time = 0;
  AssertEx(isDefined(anime), "Tried to do anim_single_queue without passing a scene name (anime)");

  if(isDefined(guy.last_queue_time)) {
    wait_for_buffer_time_to_pass(guy.last_queue_time, 0.5);
  }

  if(isDefined(timeout))
    function_stack_timeout(timeout, ::anim_single_solo, guy, anime, tag, anim_end_time, "generic");
  else
    function_stack(::anim_single_solo, guy, anime, tag, anim_end_time, "generic");

  if(IsAlive(guy))
    guy.last_queue_time = GetTime();
}

anim_dontPushPlayer(guys) {
  foreach(guy in guys) {
    guy PushPlayer(false);
  }
}

anim_pushPlayer(guys) {
  foreach(guy in guys) {
    guy PushPlayer(true);
  }
}

addNotetrack_dialogue(animname, notetrack, anime, soundalias) {
  notetrack = ToLower(notetrack);

  assertex(AnimHasNotetrack(level.scr_anim[animname][anime], notetrack), "Animation lacks notetrack " + notetrack);

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["dialog"] = soundalias;
}

add_notetrack_and_get_index(animname, notetrack, anime) {
  notetrack = ToLower(notetrack);
  add_notetrack_array(animname, notetrack, anime);
  return level.scr_notetrack[animname][anime][notetrack].size;
}

add_notetrack_array(animname, notetrack, anime) {
  notetrack = ToLower(notetrack);

  if(!isDefined(level.scr_notetrack))
    level.scr_notetrack = [];

  if(!isDefined(level.scr_notetrack[animname]))
    level.scr_notetrack[animname] = [];

  if(!isDefined(level.scr_notetrack[animname][anime]))
    level.scr_notetrack[animname][anime] = [];

  if(!isDefined(level.scr_notetrack[animname][anime][notetrack]))
    level.scr_notetrack[animname][anime][notetrack] = [];
}

addNotetrack_sound(animname, notetrack, anime, soundalias) {
  notetrack = ToLower(notetrack);

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["sound"] = soundalias;
}

get_generic_anime(anime) {
  if(!isDefined(anime))
    return "any";
  return anime;
}

addOnStart_animSound(animname, anime, soundalias) {
  if(!isDefined(level.scr_animSound[animname]))
    level.scr_animSound[animname] = [];

  level.scr_animSound[animname][anime] = soundalias;
}

addNotetrack_animSound(animname, anime, notetrack, soundalias) {
  notetrack = ToLower(notetrack);

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["sound"] = soundalias;
  array["created_by_animSound"] = true;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addNotetrack_attach(animname, notetrack, model, tag, anime) {
  notetrack = ToLower(notetrack);

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["attach model"] = model;
  array["selftag"] = tag;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addNotetrack_detach(animname, notetrack, model, tag, anime) {
  notetrack = ToLower(notetrack);

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["detach model"] = model;
  array["selftag"] = tag;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addNotetrack_customFunction(animname, notetrack, function, anime) {
  notetrack = ToLower(notetrack);

  if(isDefined(anime)) {
    if(isDefined(level.scr_anim[animname][anime]))
      assertex(AnimHasNotetrack(level.scr_anim[animname][anime], notetrack), "Animation lacks notetrack " + notetrack);
  }

  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["function"] = function;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addNotetrack_flag(animname, notetrack, theFlag, anime) {
  notetrack = ToLower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["flag"] = theFlag;

  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(!isDefined(level.flag) || !isDefined(level.flag[theFlag])) {
    flag_init(theFlag);
  }
}

addNotetrack_flag_clear(animname, notetrack, theFlag, anime) {
  notetrack = ToLower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);

  array = [];
  array["flag_clear"] = theFlag;

  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(!isDefined(level.flag) || !isDefined(level.flag[theFlag])) {
    flag_init(theFlag);
  }
}

#using_animtree("generic_human");

anim_facialAnim(guy, anime, faceanim) {
  guy endon("death");
  self endon(anime);
  changeTime = 0.05;

  guy notify("newLookTarget");

  waittillframeend;

  guy SetAnim(%scripted_talking, 5, 0.2);
  guy SetFlaggedAnimKnobRestart("face_done_" + anime, faceanim, 1, 0, 1);
  thread force_face_anim_to_play(guy, anime, faceanim);

  thread clearFaceAnimOnAnimdone(guy, "face_done_" + anime, anime);
}

force_face_anim_to_play(guy, anime, faceanim) {
  guy endon("death");
  guy endon("stop_loop");
  self endon(anime);

  for(;;) {
    guy SetAnim(%scripted_talking, 5, 0.4);
    guy SetFlaggedAnimKnobLimited("face_done_" + anime, faceanim, 1, 0, 1);
    wait(0.05);
  }
}

anim_facialFiller(msg, lookTarget) {
  self endon("death");

  changeTime = 0.05;

  self notify("newLookTarget");
  self endon("newLookTarget");

  waittillframeend;

  if(!isDefined(looktarget) && isDefined(self.looktarget))
    looktarget = self.looktarget;

  talkAnim = % generic_talker_allies;
  if(self IsBadGuy())
    talkAnim = % generic_talker_axis;

  Assert(IsAlive(self));
  self SetAnimKnobLimitedRestart(talkAnim, 1, 0, 1);
  self SetAnim(%scripted_talking, 5, 0.4);

  self set_talker_until_msg(msg, talkanim);

  changeTime = 0.3;
  self ClearAnim(%scripted_talking, 0.2);
}

set_talker_until_msg(msg, talkanim) {
  self endon(msg);
  for(;;) {
    wait(0.2);

    self SetAnimKnobLimited(talkAnim, 1, 0, 1);
    self SetAnim(%scripted_talking, 5, 0.4);
  }
}

talk_for_time(timer) {
  self endon("death");
  talkAnim = % generic_talker_allies;
  if(self IsBadGuy())
    talkAnim = % generic_talker_axis;

  self SetAnimKnobLimitedRestart(talkAnim, 1, 0, 1);
  self SetAnim(%scripted_talking, 5, 0.4);

  wait(timer);
  changeTime = 0.3;
  self ClearAnim(%scripted_talking, 0.2);
}

GetYawAngles(angles1, angles2) {
  yaw = angles1[1] - angles2[1];
  yaw = AngleClamp180(yaw);
  return yaw;
}

lookLine(org, msg) {
  self notify("lookline");
  self endon("lookline");
  self endon(msg);
  self endon("death");
  for(;;) {
    Line(self getEye(), org + (0, 0, 60), (1, 1, 0), 1);
    wait(0.05);
  }
}

anim_reach_idle(guys, anime, idle) {
  ent = spawnStruct();
  ent.count = guys.size;
  foreach(guy in guys)
  thread reachIdle(guy, anime, idle, ent);
  while(ent.count)
    ent waittill("reached_goal");

  self notify("stopReachIdle");
}

reachIdle(guy, anime, idle, ent) {
  anim_reach_solo(guy, anime);
  ent.count--;
  ent notify("reached_goal");
  if(ent.count > 0)
    anim_loop_solo(guy, idle, "stopReachIdle");
}

delayedDialogue(anime, doAnimation, dialogue, animationName) {
  if(AnimHasNotetrack(animationName, "dialog")) {
    self waittillmatch("face_done_" + anime, "dialog");
  }

  if(doAnimation)
    self SaySpecificDialogue(undefined, dialogue, 1.0);
  else
    self SaySpecificDialogue(undefined, dialogue, 1.0, "single dialogue");
}

clearFaceAnimOnAnimdone(guy, msg, anime) {
  guy endon("death");

  guy waittillmatch(msg, "end");
  changeTime = 0.3;
  guy ClearAnim(%scripted_talking, 0.2);
}

anim_start_pos(guyArray, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  array_thread(guyArray, ::set_start_pos, anime, org, angles);
}

anim_start_pos_solo(guy, anime, tag) {
  newguy[0] = guy;
  anim_start_pos(newguy, anime, tag);
}

set_start_pos(anime, org, angles, animname_override, anim_array) {
  animname = undefined;
  if(isDefined(animname_override))
    animname = animname_override;
  else
    animname = self.animname;

  if(isDefined(anim_array) && anim_array)
    animation = level.scr_anim[animname][anime][0];
  else
    animation = level.scr_anim[animname][anime];

  if(IsAI(self)) {
    neworg = GetStartOrigin(org, angles, animation);
    newangles = GetStartAngles(org, angles, animation);

    if(isDefined(self.anim_start_at_groundpos)) {
      neworg = groundpos(neworg);
    }

    self ForceTeleport(neworg, newangles);
  } else {
    self.origin = GetStartOrigin(org, angles, animation);
    self.angles = GetStartAngles(org, angles, animation);
  }
}

anim_at_self(entity, tag) {
  packet = [];
  packet["guy"] = self;
  packet["entity"] = self;
  return packet;
}

anim_at_entity(entity, tag) {
  packet = [];
  packet["guy"] = self;
  packet["entity"] = entity;
  packet["tag"] = tag;
  return packet;
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

anim_set_rate_single(guy, anime, rate) {
  guy thread anim_set_rate_internal(anime, rate);
}

anim_set_rate(guys, anime, rate) {
  array_thread(guys, ::anim_set_rate_internal, anime, rate);
}

anim_set_rate_internal(anime, rate, animname_override) {
  animname = undefined;
  if(isDefined(animname_override))
    animname = animname_override;
  else
    animname = self.animname;

  self SetFlaggedAnim("single anim", getanim_from_animname(anime, animname), 1, 0, rate);
}

anim_set_time(guys, anime, time) {
  array_thread(guys, ::anim_self_set_time, anime, time);
}

anim_self_set_time(anime, time) {
  animation = self getanim(anime);
  self SetAnimTime(animation, time);
}

last_anim_time_check() {
  if(!isDefined(self.last_anim_time)) {
    self.last_anim_time = GetTime();
    return;
  }

  time = GetTime();

  if(self.last_anim_time == time) {
    self endon("death");
    wait(0.05);
  }
  self.last_anim_time = time;
}

set_custom_move_start_transition(guy, anime) {
  guy assert_existance_of_anim(anime, guy.animname);

  guy.customMoveTransition = animscripts\cover_arrival::customMoveTransitionFunc;
  guy.startMoveTransitionAnim = level.scr_anim[guy.animname][anime];
}