/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\face.gsc
**************************************/

#include common_scripts\utility;

SayGenericDialogue(typeString) {
  switch (typeString) {
    case "kill_melee":
      importance = 0.5;
      break;
    case "flashbang":
      importance = 0.7;
      break;
    case "pain":
      importance = 0.4;
      break;
    case "death":
      wait(.01);
      importance = 1.5;
      break;
    default:
      println("Unexpected generic dialog string: " + typeString);
      importance = 0.3;
      break;
  }
  SayGenericDialogueWithImportance(typeString, importance);
}

SayGenericDialogueWithImportance(typeString, importance) {
  soundAlias = "dds_";
  if(isDefined(self.dds_characterID)) {
    soundAlias += self.dds_characterID;
  } else {
    printLn("this AI does not have a dds_characterID");
    return;
  }
  soundAlias += "_" + typeString;
  if(SoundExists(soundAlias)) {
    self thread PlayFaceThread(undefined, soundAlias, importance);
  }
}

SetIdleFaceDelayed(facialAnimationArray) {
  self.a.idleFace = facialAnimationArray;
}

SetIdleFace(facialAnimationArray) {
  if(!anim.useFacialAnims) {
    return;
  }
  self.a.idleFace = facialAnimationArray;
  self PlayIdleFace();
}

SaySpecificDialogue(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait) {
  self thread PlayFaceThread(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait);
}

ChooseAnimFromSet(animSet) {
  return;
}

PlayIdleFace() {
  return;
}

PlayFaceThread(facialanim, soundAlias, importance, notifyString, waitOrNot, timeToWait) {
  if(!isDefined(soundAlias)) {
    wait(1);
    self notify(notifyString);
    return;
  }
  if(!isDefined(level.NumberOfImportantPeopleTalking)) {
    level.NumberOfImportantPeopleTalking = 0;
  }
  if(!isDefined(level.TalkNotifySeed)) {
    level.TalkNotifySeed = 0;
  }
  if(!isDefined(notifyString)) {
    notifyString = "PlayFaceThread " + soundAlias;
  }
  if(!isDefined(self.a)) {
    self.a = spawnStruct();
  }
  if(!isDefined(self.a.facialSoundDone)) {
    self.a.facialSoundDone = true;
  }
  if(!isDefined(self.isTalking)) {
    self.isTalking = false;
  }
  if(self.isTalking) {
    if(importance < self.a.currentDialogImportance) {
      wait(1);
      self notify(notifyString);
      return;
    } else if(importance == self.a.currentDialogImportance) {
      if(self.a.facialSoundAlias == soundAlias) {
        return;
      }
      println("WARNING: delaying alias " + self.a.facialSoundAlias + " to play " + soundAlias);
      while(isDefined(self) && self.isTalking) {
        self waittill("done speaking");
      }
      if(!isDefined(self)) {
        return;
      }
    } else {
      println("WARNING: interrupting alias " + self.a.facialSoundAlias + " to play " + soundAlias);
      self stopSound(self.a.facialSoundAlias);
      self notify("cancel speaking");
      while(isDefined(self) && self.isTalking) {
        self waittill("done speaking");
      }
      if(!isDefined(self)) {
        return;
      }
    }
  }
  assert(self.a.facialSoundDone);
  assert(self.a.facialSoundAlias == undefined);
  assert(self.a.facialSoundNotify == undefined);
  assert(self.a.currentDialogImportance == undefined);
  assert(!self.isTalking);
  self.isTalking = true;
  self.a.facialSoundDone = false;
  self.a.facialSoundNotify = notifyString;
  self.a.facialSoundAlias = soundAlias;
  self.a.currentDialogImportance = importance;
  if(importance == 1.0) {
    level.NumberOfImportantPeopleTalking += 1;
  }
  if(level.NumberOfImportantPeopleTalking > 1) {
    println("WARNING: multiple high priority dialogs are happening at once " + soundAlias);
  }
  uniqueNotify = notifyString + " " + level.TalkNotifySeed;
  level.TalkNotifySeed += 1;
  play_sound = true;
  if(!SoundExists(soundAlias)) {
    println("Warning: " + soundAlias + " does not exist");
    if(IsString(soundAlias) && ("vox_" != GetSubStr(soundAlias, 0, 4))) {
      play_sound = false;
      self thread display_vo(soundAlias, uniqueNotify);
    }
  }
  if(play_sound) {
    self playSound(soundAlias, uniqueNotify, true);
  }
  self waittill_any("death", "cancel speaking", uniqueNotify);
  if(importance == 1.0) {
    level.NumberOfImportantPeopleTalking -= 1;
    level.ImportantPeopleTalkingTime = GetTime();
  }
  if(isDefined(self)) {
    self.isTalking = false;
    self.a.facialSoundDone = true;
    self.a.facialSoundNotify = undefined;
    self.a.facialSoundAlias = undefined;
    self.a.currentDialogImportance = undefined;
    self.lastSayTime = GetTime();
  }
  self notify("done speaking");
  self notify(notifyString);
}

display_vo(vo_string, uniqueNotify) {
  if(!isDefined(level.vo_hud)) {
    level.vo_hud = NewHudElem();
    level.vo_hud.fontscale = 2;
    level.vo_hud.horzAlign = "center";
    level.vo_hud.vertAlign = "middle";
    level.vo_hud.alignX = "center";
    level.vo_hud.alignY = "middle";
    level.vo_hud.y = 180;
  }
  name = "";
  if(isDefined(self.name)) {
    name = self.name;
  } else if(isDefined(self.animname)) {
    name = self.animname;
  }
  level.vo_hud SetText(name + ": " + vo_string);
  wait(vo_string.size / 6);
  level.vo_hud SetText("");
  self notify(uniqueNotify);
}

temp_dialogue_print(soundAlias) {
  self endon("death");
  new_string = "";
  if(IsSubStr(soundAlias, "print:")) {
    if(isDefined(self.name)) {
      name = self.name + ": ";
    } else {
      name = "NO-NAMER: ";
    }
    for(i = 6; i < soundAlias.size; i++) {
      new_string = new_string + soundAlias[i];
    }
    println("^3TEMP DIALOGUE - " + name + new_string);
  } else {
    new_string = soundAlias;
  }
  self notify("stop_temp_dialogue_print");
  self endon("stop_temp_dialogue_print");
  size = new_string.size;
  time = GetTime() + 3000;
  if(size > 25) {
    time = GetTime() + (size * 0.1 * 1000);
  }
  while(GetTime() < time) {
    Print3d(self.origin + (0, 0, 72), new_string);
    wait(0.05);
  }
}

PlayFace_WaitForNotify(waitForString, notifyString, killmeString) {
  self endon("death");
  self endon(killmeString);
  self waittill(waitForString);
  self.a.faceWaitForResult = "notify";
  self notify(notifyString);
}

PlayFace_WaitForTime(time, notifyString, killmeString) {
  self endon("death");
  self endon(killmeString);
  wait(time);
  self.a.faceWaitForResult = "time";
  self notify(notifyString);
}

#using_animtree("generic_human");
InitLevelFace() {}