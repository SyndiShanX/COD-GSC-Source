/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\face.gsc
*************************************************/

#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace face;

function saygenericdialogue(typestring) {
  if(level.disablegenericdialog) {
    return;
  }
  switch (typestring) {
    case "attack": {
      importance = 0.5;
      break;
    }
    case "swing": {
      importance = 0.5;
      typestring = "attack";
      break;
    }
    case "flashbang": {
      importance = 0.7;
      break;
    }
    case "pain_small": {
      importance = 0.4;
      break;
    }
    case "pain_bullet": {
      wait(0.01);
      importance = 0.4;
      break;
    }
    default: {
      println("" + typestring);
      importance = 0.3;
      break;
    }
  }
  saygenericdialoguewithimportance(typestring, importance);
}

function saygenericdialoguewithimportance(typestring, importance) {
  soundalias = "dds_";
  if(isDefined(self.dds_characterid)) {
    soundalias = soundalias + self.dds_characterid;
  } else {
    println("");
    return;
  }
  soundalias = soundalias + ("_" + typestring);
  if(soundexists(soundalias)) {
    self thread playfacethread(undefined, soundalias, importance);
  }
}

function setidlefacedelayed(facialanimationarray) {
  self.a.idleface = facialanimationarray;
}

function setidleface(facialanimationarray) {
  if(!anim.usefacialanims) {
    return;
  }
  self.a.idleface = facialanimationarray;
  self playidleface();
}

function sayspecificdialogue(facialanim, soundalias, importance, notifystring, waitornot, timetowait, toplayer) {
  self thread playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait, toplayer);
}

function playidleface() {}

function playfacethread(facialanim, str_script_alias, importance, notifystring, waitornot, timetowait, toplayer) {
  self endon("death");
  if(!isDefined(str_script_alias)) {
    wait(1);
    self notify(notifystring);
    return;
  }
  str_notify_alias = str_script_alias;
  if(!isDefined(level.numberofimportantpeopletalking)) {
    level.numberofimportantpeopletalking = 0;
  }
  if(!isDefined(level.talknotifyseed)) {
    level.talknotifyseed = 0;
  }
  if(!isDefined(notifystring)) {
    notifystring = "PlayFaceThread " + str_script_alias;
  }
  if(!isDefined(self.a)) {
    self.a = spawnStruct();
  }
  if(!isDefined(self.a.facialsounddone)) {
    self.a.facialsounddone = 1;
  }
  if(!isDefined(self.istalking)) {
    self.istalking = 0;
  }
  if(self.istalking) {
    if(isDefined(self.a.currentdialogimportance)) {
      if(importance < self.a.currentdialogimportance) {
        wait(1);
        self notify(notifystring);
        return;
      }
      if(importance == self.a.currentdialogimportance) {
        if(self.a.facialsoundalias == str_script_alias) {
          return;
        }
        println((("" + self.a.facialsoundalias) + "") + str_script_alias);
        while(self.istalking) {
          self waittill("hash_90f83311");
        }
      }
    } else {
      println((("" + self.a.facialsoundalias) + "") + str_script_alias);
      self stopsound(self.a.facialsoundalias);
      self notify("hash_ad4a3c97");
      while(self.istalking) {
        self waittill("hash_90f83311");
      }
    }
  }
  assert(self.a.facialsounddone);
  assert(self.a.facialsoundalias == undefined);
  assert(self.a.facialsoundnotify == undefined);
  assert(self.a.currentdialogimportance == undefined);
  assert(!self.istalking);
  self notify("bc_interrupt");
  self.istalking = 1;
  self.a.facialsounddone = 0;
  self.a.facialsoundnotify = notifystring;
  self.a.facialsoundalias = str_script_alias;
  self.a.currentdialogimportance = importance;
  if(importance == 1) {
    level.numberofimportantpeopletalking = level.numberofimportantpeopletalking + 1;
  }
  if(level.numberofimportantpeopletalking > 1) {
    println("" + str_script_alias);
  }
  uniquenotify = (notifystring + " ") + level.talknotifyseed;
  level.talknotifyseed = level.talknotifyseed + 1;
  if(isDefined(level.scr_sound) && isDefined(level.scr_sound["generic"])) {
    str_vox_file = level.scr_sound["generic"][str_script_alias];
  }
  if(isDefined(str_vox_file)) {
    if(soundexists(str_vox_file)) {
      if(isplayer(toplayer)) {
        self thread _play_sound_to_player_with_notify(str_vox_file, toplayer, uniquenotify);
      } else {
        if(isDefined(self gettagorigin("J_Head"))) {
          self playsoundwithnotify(str_vox_file, uniquenotify, "J_Head");
        } else {
          self playsoundwithnotify(str_vox_file, uniquenotify);
        }
      }
    } else {
      println(("" + str_script_alias) + "");
      self thread _missing_dialog(str_script_alias, str_vox_file, uniquenotify);
    }
  } else {
    self thread _temp_dialog(str_script_alias, uniquenotify);
  }
  self util::waittill_any("death", "cancel speaking", uniquenotify);
  if(importance == 1) {
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
  self notify("hash_90f83311", str_notify_alias);
  self notify(notifystring);
}

function _play_sound_to_player_with_notify(soundalias, toplayer, uniquenotify) {
  self endon("death");
  toplayer endon("death");
  self playsoundtoplayer(soundalias, toplayer);
  n_playbacktime = soundgetplaybacktime(soundalias);
  if(n_playbacktime > 0) {
    wait(n_playbacktime * 0.001);
  } else {
    wait(1);
  }
  self notify(uniquenotify);
}

function private _temp_dialog(str_line, uniquenotify, b_missing_vo = 0) {
  setdvar("bgcache_disablewarninghints", 1);
  if(!b_missing_vo && isDefined(self.propername)) {
    str_line = (self.propername + ": ") + str_line;
  }
  foreach(player in level.players) {
    if(!isDefined(player getluimenu("TempDialog"))) {
      player openluimenu("TempDialog");
    }
    player setluimenudata(player getluimenu("TempDialog"), "dialogText", str_line);
    if(b_missing_vo) {
      player setluimenudata(player getluimenu("TempDialog"), "title", "MISSING VO SOUND");
      continue;
    }
    player setluimenudata(player getluimenu("TempDialog"), "title", "TEMP VO");
  }
  n_wait_time = (strtok(str_line, " ").size - 1) / 2;
  n_wait_time = math::clamp(n_wait_time, 2, 5);
  util::waittill_any_timeout(n_wait_time, "death", "cancel speaking");
  foreach(player in level.players) {
    if(isDefined(player getluimenu("TempDialog"))) {
      player closeluimenu(player getluimenu("TempDialog"));
    }
  }
  setdvar("bgcache_disablewarninghints", 0);
  self notify(uniquenotify);
}

function private _missing_dialog(str_script_alias, str_vox_file, uniquenotify) {
  _temp_dialog((("script id: " + str_script_alias) + " sound alias: ") + str_vox_file, uniquenotify, 1);
}

function playface_waitfornotify(waitforstring, notifystring, killmestring) {
  self endon("death");
  self endon(killmestring);
  self waittill(waitforstring);
  self.a.facewaitforresult = "notify";
  self notify(notifystring);
}

function playface_waitfortime(time, notifystring, killmestring) {
  self endon("death");
  self endon(killmestring);
  wait(time);
  self.a.facewaitforresult = "time";
  self notify(notifystring);
}