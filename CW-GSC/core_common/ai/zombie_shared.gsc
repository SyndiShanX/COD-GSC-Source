/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_shared.gsc
***********************************************/

#using scripts\core_common\sound_shared;
#namespace zombie_shared;

function handlenotetrack(note, flagname, customfunction, var1) {
  switch (flagname) {
    case # "undefined":
    case # "end":
    case # "finish":
      return flagname;
    case # "hash_701bc5c059dfaa52":
      self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case # "hash_5f5e275b9f3b93ee":
      self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case # "no death":
      self.a.nodeath = 1;
      break;
    case # "no pain":
      self.allowpain = 0;
      break;
    case # "hash_50c6c08f5de3ec2a":
      self.allowpain = 1;
      break;
    case # "anim_melee = right":
    case # "hash_39ec7b0969bab796":
      self.a.meleestate = "right";
      break;
    case # "anim_melee = left":
    case # "hash_6b554a9080ec8b07":
      self.a.meleestate = "left";
      break;
    case # "swap taghelmet to tagleft":
      if(isDefined(self.hatmodel)) {
        if(isDefined(self.helmetsidemodel)) {
          self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
          self.helmetsidemodel = undefined;
        }

        self detach(self.hatmodel, "");
        self attach(self.hatmodel, "TAG_WEAPON_LEFT");
        self.hatmodel = undefined;
      }

      break;
    default:
      if(isDefined(customfunction)) {
        if(!isDefined(var1)) {
          return [[customfunction]](flagname);
        } else {
          return [[customfunction]](flagname, var1);
        }
      }

      break;
  }
}

function donotetracks(flagname, customfunction, var1) {
  for(;;) {
    waitresult = self waittill(flagname);
    note = waitresult.notetrack;

    if(!isDefined(note)) {
      note = "undefined";
    }

    val = self handlenotetrack(note, flagname, customfunction, var1);

    if(isDefined(val)) {
      return val;
    }
  }
}

function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, var1) {
  if(isDefined(killstring)) {
    self endon(killstring, #"killanimscript");
  }

  for(;;) {
    time = gettime();
    returnednote = [[notetracksfunc]](flagname, customfunction, var1);
    timetaken = gettime() - time;

    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [[notetracksfunc]](flagname, customfunction, var1);
      timetaken = gettime() - time;

      if(timetaken < 0.05) {
        println(gettime() + "<dev string:x38>" + flagname + "<dev string:x88>" + returnednote + "<dev string:x97>");
        wait 0.05 - timetaken;
      }
    }
  }
}

function donotetracksforever(flagname, killstring, customfunction, var1) {
  donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1) {
  ent endon(#"stop_notetracks");
  [[time]](flagname, undefined, customfunction, var1);
}

function donotetracksfortime(time, flagname, customfunction, var1) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

function donotetracksfortimeendnotify(time) {
  wait time;
  self notify(#"stop_notetracks");
}