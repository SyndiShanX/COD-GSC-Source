/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_jukebox.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace wz_jukebox;

autoexec __init__system__() {
  system::register(#"wz_jukebox", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_8b13d130 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6935c178012cf77e")) ? getgametypesetting(#"hash_6935c178012cf77e") : 0);
}

__init__() {
  level thread function_2bf3c36e();
}

function_2bf3c36e() {
  dynents = getdynentarray("dynent_jukebox");

  foreach(jukebox in dynents) {
    jukebox.songs = [];
  }

  if(!level.var_8b13d130) {
    waitframe(1);

    foreach(dynent in dynents) {
      setdynentenabled(dynent, 0);
    }

    item_world::function_4de3ca98();

    foreach(dynent in dynents) {
      setdynentenabled(dynent, 0);
    }
  }
}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(isDefined(level.var_8b13d130) && !level.var_8b13d130) {
    if(eventstruct.ent.targetname === "dynent_jukebox") {
      setdynentenabled(eventstruct.ent, 0);
    }

    return;
  }

  if(eventstruct.ent.targetname === "dynent_jukebox") {
    if(eventstruct.state == 0 || eventstruct.state == 3) {
      eventstruct.ent thread jukebox_off();
      return;
    }

    if(eventstruct.state == 2) {
      eventstruct.ent thread jukebox_on();
    }
  }
}

jukebox_off() {
  self notify(#"jukebox_off");

  if(isDefined(self.var_14da73bd)) {
    stopsound(self.var_14da73bd);
    self.var_14da73bd = undefined;
  }
}

jukebox_on() {
  self endon(#"jukebox_off");
  var_96748cfb = (self.origin[0] + 32, self.origin[1] - 16, self.origin[2] + 64);

  if(isDefined(self.var_14da73bd)) {
    stopsound(self.var_14da73bd);
    self.var_14da73bd = undefined;
    waitframe(1);
  }

  if(isDefined(self.songs) && self.songs.size > 0) {
    random_num = randomint(self.songs.size);
    song = self.songs[random_num];
    arrayremoveindex(self.songs, random_num);
  } else {
    songs = array(#"hash_38b88ac8a1bb9bca", #"hash_38b88bc8a1bb9d7d", #"hash_38b888c8a1bb9864", #"hash_38b889c8a1bb9a17", #"hash_38b886c8a1bb94fe", #"hash_38b887c8a1bb96b1");
    self.songs = array::randomize(songs);
    random_num = randomint(self.songs.size);
    song = self.songs[random_num];
    arrayremoveindex(self.songs, random_num);
  }

  self.var_14da73bd = playSound(0, song, var_96748cfb);
}