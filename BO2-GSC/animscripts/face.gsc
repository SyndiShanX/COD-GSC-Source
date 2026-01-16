/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\face.gsc
**************************************/

#include common_scripts\utility;

saygenericdialogue(typestring) {
  if(level.disablegenericdialog) {
    return;
  }
  switch (typestring) {
    case "attack":
      importance = 0.5;
      break;
    case "swing":
      importance = 0.5;
      typestring = "attack";
      break;
    case "flashbang":
      importance = 0.7;
      break;
    case "pain_small":
      importance = 0.4;
      break;
    case "pain_bullet":
      wait 0.01;
      importance = 0.4;
      break;
    default:

      println("Unexpected generic dialog string: " + typestring);

      importance = 0.3;
      break;
  }

  saygenericdialoguewithimportance(typestring, importance);
}

saygenericdialoguewithimportance(typestring, importance) {
  soundalias = "dds_";

  if(isDefined(self.dds_characterid))
    soundalias = soundalias + self.dds_characterid;
  else {
    println("this AI does not have a dds_characterID");

    return;
  }

  soundalias = soundalias + ("_" + typestring);

  if(soundexists(soundalias))
    self thread playfacethread(undefined, soundalias, importance);
}

setidlefacedelayed(facialanimationarray) {
  self.a.idleface = facialanimationarray;
}

setidleface(facialanimationarray) {
  if(!anim.usefacialanims) {
    return;
  }
  self.a.idleface = facialanimationarray;
  self playidleface();
}

sayspecificdialogue(facialanim, soundalias, importance, notifystring, waitornot, timetowait) {
  self thread playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait);
}

playidleface() {
}

playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait) {
  if(!isDefined(soundalias)) {
    wait 1;
    self notify(notifystring);
    return;
  }

  if(!isDefined(level.numberofimportantpeopletalking))
    level.numberofimportantpeopletalking = 0;

  if(!isDefined(level.talknotifyseed))
    level.talknotifyseed = 0;

  if(!isDefined(notifystring))
    notifystring = "PlayFaceThread " + soundalias;

  if(!isDefined(self.a))
    self.a = spawnstruct();

  if(!isDefined(self.a.facialsounddone))
    self.a.facialsounddone = 1;

  if(!isDefined(self.istalking))
    self.istalking = 0;

  if(self.istalking) {
    if(importance < self.a.currentdialogimportance) {
      wait 1;
      self notify(notifystring);
      return;
    } else if(importance == self.a.currentdialogimportance) {
      if(self.a.facialsoundalias == soundalias) {
        return;
      }
      println("WARNING: delaying alias " + self.a.facialsoundalias + " to play " + soundalias);

      while(isDefined(self) && self.istalking)
        self waittill("done speaking");

      if(!isDefined(self))
        return;
    } else {
      println("WARNING: interrupting alias " + self.a.facialsoundalias + " to play " + soundalias);

      self stopsound(self.a.facialsoundalias);
      self notify("cancel speaking");

      while(isDefined(self) && self.istalking)
        self waittill("done speaking");

      if(!isDefined(self))
        return;
    }
  }

  assert(self.a.facialsounddone);
  assert(self.a.facialsoundalias == undefined);
  assert(self.a.facialsoundnotify == undefined);
  assert(self.a.currentdialogimportance == undefined);
  assert(!self.istalking);
  self.istalking = 1;
  self.a.facialsounddone = 0;
  self.a.facialsoundnotify = notifystring;
  self.a.facialsoundalias = soundalias;
  self.a.currentdialogimportance = importance;

  if(importance == 1.0)
    level.numberofimportantpeopletalking = level.numberofimportantpeopletalking + 1;

  if(level.numberofimportantpeopletalking > 1)
    println("WARNING: multiple high priority dialogs are happening at once " + soundalias);

  uniquenotify = notifystring + " " + level.talknotifyseed;
  level.talknotifyseed = level.talknotifyseed + 1;
  play_sound = 1;

  if(!soundexists(soundalias)) {
    println("Warning: " + soundalias + " does not exist");

    if(isstring(soundalias) && "vox_" != getsubstr(soundalias, 0, 4))
      play_sound = 0;
  }

  if(play_sound) {
    if(isDefined(self.type) && self.type == "human")
      self playsoundontag(soundalias, "J_Head", uniquenotify);
    else
      self playsound(soundalias, uniquenotify);
  }

  self waittill_any("death", "cancel speaking", uniquenotify);

  if(importance == 1.0) {
    level.numberofimportantpeopletalking = level.numberofimportantpeopletalking - 1;
    level.importantpeopletalkingtime = gettime();
  }

  if(isDefined(self)) {
    self.istalking = 0;
    self.a.facialsounddone = 1;
    self.a.facialsoundnotify = undefined;
    self.a.facialsoundalias = undefined;
    self.a.currentdialogimportance = undefined;
    self.lastsaytime = gettime();
  }

  self notify("done speaking");
  self notify(notifystring);
}

playface_waitfornotify(waitforstring, notifystring, killmestring) {
  self endon("death");
  self endon(killmestring);
  self waittill(waitforstring);
  self.a.facewaitforresult = "notify";
  self notify(notifystring);
}

playface_waitfortime(time, notifystring, killmestring) {
  self endon("death");
  self endon(killmestring);
  wait(time);
  self.a.facewaitforresult = "time";
  self notify(notifystring);
}