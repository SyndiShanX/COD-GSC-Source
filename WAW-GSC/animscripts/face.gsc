/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\face.gsc
*****************************************************/

#include common_scripts\utility;

InitCharacterFace() {
  if(!anim.useFacialAnims) {
    return;
  }
  if(!isDefined(self.a.currentDialogImportance)) {
    self.a.currentDialogImportance = 0;
    self.a.idleFace = anim.alertface;
    self.faceWaiting = [];
    self.faceLastNotifyNum = 0;
  }
}

SayGenericDialogue(typeString) {
  switch (typeString) {
    case "meleecharge":
    case "meleeattack":
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
  voice = self.voice;
  if(!isDefined(voice))
    voice = "american";
  soundAlias = "generic_" + typeString + "_" + voice;
  if(SoundExists(soundAlias))
    self thread PlayFaceThread(undefined, soundAlias, importance);
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
  if(!isDefined(soundAlias) || !soundExists(soundAlias)) {
    if(!soundExists(soundAlias)) {
      println("ERROR missing sound alias:" + soundAlias);
    }
    if(isDefined(notifyString)) {
      wait(1);
      self notify(notifyString);
    }
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
      while(isDefined(self) && self.isTalking)
        self waittill("done speaking");
      if(!isDefined(self))
        return;
    } else {
      println("WARNING: interrupting alias " + self.a.facialSoundAlias + " to play " + soundAlias);
      self stopSound(self.a.facialSoundAlias);
      self notify("cancel speaking");
      while(isDefined(self) && self.isTalking)
        self waittill("done speaking");
      if(!isDefined(self))
        return;
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
  self thread temp_dialogue_print(soundAlias);
  uniqueNotify = notifyString + " " + level.TalkNotifySeed;
  level.TalkNotifySeed += 1;
  if(!SoundExists(soundAlias))
    println("Warning: " + soundAlias + " does not exist");
  self playSound(soundAlias, uniqueNotify, true);
  self waittill_any("death", "cancel speaking", uniqueNotify);
  if(importance == 1.0) {
    level.NumberOfImportantPeopleTalking -= 1;
    level.ImportantPeopleTalkingTime = gettime();
  }
  if(isDefined(self)) {
    self.isTalking = false;
    self.a.facialSoundDone = true;
    self.a.facialSoundNotify = undefined;
    self.a.facialSoundAlias = undefined;
    self.a.currentDialogImportance = undefined;
    self.lastSayTime = gettime();
  }
  self notify("done speaking");
  self notify(notifyString);
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
    iprintln(name + new_string);
    println("^3TEMP DIALOGUE - " + name + new_string);
  }
  self notify("stop_temp_dialogue_print");
  self endon("stop_temp_dialogue_print");
  size = new_string.size;
  time = GetTime() + 3000;
  if(size > 25) {
    time = GetTime() + (size * 0.1 * 1000);
  }
  while(GetTime() < time) {
    print3d(self.origin + (0, 0, 72), new_string);
    wait(0.05);
  }
}

WaitForFacialAnim() {
  self endon("death");
  self endon("end current face");
  self animscripts\shared::DoNoteTracks("animscript faceanim");
  self.a.facialAnimDone = true;
  self notify("animscript facedone");
}

WaitForFaceSound(msg) {
  self endon("death");
  self waittill("animscript facesound" + msg);
  self.a.facialSoundDone = false;
  self notify(msg);
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