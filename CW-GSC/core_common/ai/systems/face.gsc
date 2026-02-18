/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\face.gsc
***********************************************/

#using scripts\core_common\math_shared;
#namespace face;

function playfacethread(facialanim, str_script_alias, importance, notifystring, waitornot, timetowait, player_or_team) {
  self endon(#"death");

  if(!isDefined(notifystring)) {
    wait 1;
    self notify(timetowait);
    return;
  }

  str_notify_alias = notifystring;

  if(!isDefined(level.numberofimportantpeopletalking)) {
    level.numberofimportantpeopletalking = 0;
  }

  if(!isDefined(level.talknotifyseed)) {
    level.talknotifyseed = 0;
  }

  if(!isDefined(timetowait)) {
    timetowait = "PlayFaceThread " + notifystring;
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
      if(waitornot < self.a.currentdialogimportance) {
        wait 1;
        self notify(timetowait);
        return;
      } else if(waitornot == self.a.currentdialogimportance) {
        if(self.a.facialsoundalias == notifystring) {
          return;
        }

        println("<dev string:x38>" + self.a.facialsoundalias + "<dev string:x54>" + notifystring);

        while(self.istalking) {
          self waittill(#"done speaking");
        }
      }
    } else {
      println("<dev string:x61>" + self.a.facialsoundalias + "<dev string:x54>" + notifystring);

      if(isscriptfunctionptr(level.var_4ceaaaf5)) {
        self thread[[level.var_4ceaaaf5]](self.a.facialsoundalias);
      } else {
        self stopsound(self.a.facialsoundalias);
      }

      self notify(#"cancel speaking");

      while(self.istalking) {
        self waittill(#"done speaking");
      }
    }
  }

  assert(self.a.facialsounddone);
  assert(self.a.facialsoundalias == undefined);
  assert(self.a.facialsoundnotify == undefined);
  assert(self.a.currentdialogimportance == undefined);
  assert(!self.istalking);
  self notify(#"bc_interrupt");
  self.istalking = 1;
  self.a.facialsounddone = 0;
  self.a.facialsoundnotify = timetowait;
  self.a.facialsoundalias = notifystring;
  self.a.currentdialogimportance = waitornot;

  if(waitornot == 1) {
    level.numberofimportantpeopletalking += 1;
  }

  if(level.numberofimportantpeopletalking > 1) {
    println("<dev string:x81>" + notifystring);
  }

  uniquenotify = timetowait + " " + level.talknotifyseed;
  level.talknotifyseed += 1;

  if(isDefined(level.scr_sound) && isDefined(level.scr_sound[# "generic"])) {
    str_vox_file = level.scr_sound[# "generic"][notifystring];
  }

  if(!isDefined(str_vox_file) && soundexists(notifystring)) {
    str_vox_file = notifystring;
  }

  if(isDefined(str_vox_file)) {
    if(soundexists(str_vox_file)) {
      if(isscriptfunctionptr(level.var_94934cfc)) {
        self thread[[level.var_94934cfc]](str_vox_file, uniquenotify, player_or_team);
      } else if(isDefined(player_or_team)) {
        self thread _play_sound_to_player_with_notify(str_vox_file, player_or_team, uniquenotify);
      } else if(isDefined(self gettagorigin("j_head"))) {
        self playsoundwithnotify(str_vox_file, uniquenotify, "j_head");
      } else {
        self playsoundwithnotify(str_vox_file, uniquenotify);
      }
    } else {
      println("<dev string:xc3>" + notifystring + "<dev string:xe2>");
      self thread _missing_dialog(notifystring, str_vox_file, uniquenotify);
    }
  } else {
    self thread _temp_dialog(notifystring, uniquenotify);
  }

  ret = self waittill(#"death", #"cancel speaking", uniquenotify);

  if(ret._notify === "cancel speaking" && isDefined(str_vox_file)) {
    self stopsound(str_vox_file);
  }

  if(waitornot == 1) {
    level.numberofimportantpeopletalking -= 1;
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

  self notify(#"done speaking", {
    #vo_line: str_notify_alias
  });
  self notify(timetowait);
}

function _play_sound_to_player_with_notify(soundalias, player_or_team, uniquenotify) {
  self endon(#"death");

  if(isPlayer(player_or_team)) {
    player_or_team endon(#"death");
    self playsoundtoplayer(soundalias, player_or_team);
  } else if(isstring(player_or_team)) {
    self playsoundtoteam(soundalias, player_or_team);
  }

  n_playbacktime = soundgetplaybacktime(soundalias);

  if(n_playbacktime > 0) {
    wait n_playbacktime * 0.001;
  } else {
    wait 1;
  }

  self notify(uniquenotify);
}

function private _temp_dialog(str_line, uniquenotify, b_missing_vo = 0) {
  setDvar(#"bgcache_disablewarninghints", 1);

  if(!b_missing_vo && isDefined(self.propername)) {
    str_line = self.propername + ": " + str_line;
  }

  foreach(player in level.players) {
    if(!isDefined(player getluimenu("TempDialog"))) {
      player openluimenu("TempDialog");
    }

    player setluimenudata(player getluimenu("TempDialog"), #"dialogtext", str_line);

    if(b_missing_vo) {
      player setluimenudata(player getluimenu("TempDialog"), #"title", "MISSING VO SOUND");
      continue;
    }

    player setluimenudata(player getluimenu("TempDialog"), #"title", "TEMP VO");
  }

  n_wait_time = (strtok(str_line, " ").size - 1) / 2;
  n_wait_time = math::clamp(n_wait_time, 2, 5);
  self waittilltimeout(n_wait_time, #"death", #"cancel speaking");

  foreach(player in level.players) {
    if(isDefined(player getluimenu("TempDialog"))) {
      player closeluimenu(player getluimenu("TempDialog"));
    }
  }

  setDvar(#"bgcache_disablewarninghints", 0);
  self notify(uniquenotify);
}

function private _missing_dialog(str_script_alias, str_vox_file, uniquenotify) {
  _temp_dialog("script id: " + str_script_alias + " sound alias: " + str_vox_file, uniquenotify, 1);
}