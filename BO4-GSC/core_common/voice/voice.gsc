/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\voice\voice.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace voice;

autoexec __init__system__() {
  system::register(#"voice", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  level.var_3e8bd5c = [];

  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }

  if(!isprofilebuild()) {
    setdvar(#"hash_5a4f3b089c68658f", 1);
  }

}

on_player_connect() {
  self init_character(undefined, "J_Head");

  if(isDefined(level.var_151fd2ac)) {
    self thread[[level.var_151fd2ac]]();
  }
}

function_4c866f3d(table) {}

add(chrname, scriptkey, alias) {}

add_igc(scriptid, alias) {}

init_character(chrname, var_bd68a08e, var_f4aa7514 = 0) {
  assert(isentity(self), "<dev string:x38>");
  assert(isplayer(self) || isDefined(chrname), "<dev string:x5c>");

  if(isDefined(self)) {
    self.var_3975c22 = chrname;
    self.var_bd68a08e = var_bd68a08e;
    self.var_556f910a = [];
    self.var_78566c82 = 0;
    self.var_46b25f4f = var_f4aa7514;
  }
}

set_portrait(portraitid) {
  self.var_54d07407 = portraitid;
}

playing() {
  if(!isDefined(self.var_556f910a)) {
    return false;
  }

  return isDefined(self.var_47282775);
}

pending() {
  if(!isDefined(self.var_556f910a)) {
    return false;
  }

  return self.var_556f910a.size > 0;
}

stop() {
  if(self playing()) {
    self notify(#"voice_stop");
  }
}

stop_all(team) {
  stop = [];

  foreach(speaker in level.var_3e8bd5c) {
    if(isDefined(team) && team != #"any" && team != speaker.team) {
      continue;
    }

    stop[stop.size] = speaker;
  }

  foreach(speaker in stop) {
    speaker stop();
  }
}

play(scriptkey, var_17ee4803 = undefined, var_7f436309 = 0) {
  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    return false;
  }

  assert(isDefined(self.var_556f910a), "<dev string:x8e>");

  if(isstring(scriptkey)) {
    scriptkey = tolower(scriptkey);
  }

  alias = undefined;

  if(var_7f436309) {
    assert(isDefined(self.var_46b25f4f) && self.var_46b25f4f, "<dev string:xbe>");
    a_aliases = self function_5f8e1b94(scriptkey);

    if(isDefined(self.var_6946d662)) {
      var_ae215d05 = a_aliases.size == 1 && a_aliases[0] == self.var_6946d662;

      if(var_ae215d05) {
        alias = self.var_6946d662;
      } else {
        a_aliases = array::exclude(a_aliases, self.var_6946d662);
        alias = array::random(a_aliases);
      }
    } else {
      alias = array::random(a_aliases);
    }
  } else {
    alias = self get_chr_alias(scriptkey);
  }

  voice = spawnStruct();
  voice.scriptkey = scriptkey;
  voice.params = function_73613736(scriptkey);
  voice.alias = alias;
  voice.var_17ee4803 = var_17ee4803;

  if(isDefined(self.var_46b25f4f) && self.var_46b25f4f && isDefined(alias)) {
    self.var_6946d662 = alias;
  }

  if(!playing() && !pending()) {
    self thread start_pending();
  }

  function_93932552(voice);
  return isDefined(alias);
}

private start_pending() {
  self endoncallback(&function_9db28e7, #"death", #"entering_last_stand", #"disconnect", #"voice_stop");
  level endon(#"game_ended");
  level.var_3e8bd5c[level.var_3e8bd5c.size] = self;

  while(isDefined(self.var_78566c82) && self.var_78566c82) {
    waitframe(1);
  }

  waittillframeend();

  if(isDefined(self)) {
    self thread play_next();
  }
}

private play_next() {
  self endoncallback(&end_play_next, #"death", #"entering_last_stand", #"disconnect", #"voice_stop");
  level endon(#"game_ended");
  voice = function_777704ce();

  if(!isDefined(voice)) {
    self end_play_next();
    return;
  }

  self function_7924f3ca();
  self.var_47282775 = voice;

  if(isDefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"human_riotshield" || self.archetype == #"human_rpg" || self.archetype == #"civilian")) {
    self clientfield::set("facial_dial", 1);
  }

  if(isDefined(voice.alias) && getdvarint(#"hash_49f50ad33517adfd", 1) == 1) {
    soundent = self playsoundwithnotify(voice.alias, "voice_done", self.var_bd68a08e);
    self mask_sound(soundent, voice.params, voice.var_17ee4803);
    self waittill(#"voice_done");
    self notify(voice.scriptkey);
  } else if(isDefined(voice.alias)) {
    self notify(#"voice_done");
    self notify(voice.scriptkey);
  }

  if(!isDefined(voice.alias) && getdvarint(#"hash_5a4f3b089c68658f", 0) == 1 || getdvarint(#"hash_71fefd466102ebff", 0) == 1) {
    tempname = self.var_3975c22;

    if(!isDefined(tempname) && isplayer(self)) {
      tempname = self getchrname();
    }

    if(!isDefined(tempname)) {
      tempname = "Unknown";
    }

    str_line = tempname + ": " + voice.scriptkey;
    n_wait_time = (strtok(voice.scriptkey, " ").size - 1) / 2;
    n_wait_time = math::clamp(n_wait_time, 2, 5);

    if(isDefined(voice.var_17ee4803) && isentity(voice.var_17ee4803)) {
      voice.var_17ee4803 thread function_9b502d8d(str_line, n_wait_time);
    } else {
      a_e_teammates = getplayers(self.team);

      foreach(e_player in a_e_teammates) {
        if(isbot(e_player)) {
          continue;
        }

        e_player thread function_9b502d8d(str_line, n_wait_time);
      }
    }

    self notify(#"voice_done");
    self notify(voice.scriptkey);
  }

  self end_play_next();
}

private function_9b502d8d(str_line, n_wait_time) {
  self endon(#"disconnect");
  self notify(#"hash_3a2cea55af16657f");
  self endon(#"hash_3a2cea55af16657f");

  if(!isDefined(self getluimenu("TempDialog"))) {
    self openluimenu("TempDialog");
  }

  self waittilltimeout(n_wait_time, #"death");

  if(isDefined(self getluimenu("TempDialog"))) {
    self closeluimenu(self getluimenu("TempDialog"));
  }
}

private function_9db28e7(notifyhash) {
  if(isDefined(notifyhash)) {
    self function_7924f3ca();
    self notify(#"voice_done");
  }

  arrayremovevalue(level.var_3e8bd5c, self);
}

private end_play_next(notifyhash) {
  self function_9db28e7();

  if(isDefined(notifyhash)) {
    self thread stop_playing();
    self notify(#"voice_done");

    if(isDefined(self.var_47282775) && isstring(self.var_47282775.scriptkey)) {
      self notify(self.var_47282775.scriptkey);
    }
  }

  self.var_47282775 = undefined;

  if(isactor(self) && isDefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"human_riotshield" || self.archetype == #"human_rpg" || self.archetype == #"civilian")) {
    self clientfield::set("facial_dial", 0);
  }

  if(isDefined(self.var_556f910a) && self.var_556f910a.size > 0) {
    play_next();
    return;
  }

  self notify(#"hash_296a16c4cf068a53");
}

private stop_playing() {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self.var_78566c82 = 1;
  self stopsounds();
  waitframe(1);

  if(isDefined(self)) {
    self.var_78566c82 = 0;
  }
}

private clear_queue() {
  array::delete_all(self.var_556f910a);
  self.var_556f910a = [];
}

private function_7924f3ca() {
  self endon(#"death", #"disconnect");

  if(isDefined(self.var_556f910a)) {
    for(i = 0; i < self.var_556f910a.size; i++) {
      if(isDefined(self.var_556f910a[i]) && isDefined(self.var_556f910a[i].scriptkey)) {
        b_queue = isDefined(self.var_556f910a[i].params) ? self.var_556f910a[i].params.queue : 0;

        if(!b_queue) {
          arrayremoveindex(self.var_556f910a, i);
          continue;
        }
      }
    }
  }
}

private mask_sound(soundent, params, var_17ee4803) {
  mask = isDefined(params) ? params.mask : #"all";

  if(mask == #"all") {
    if(isDefined(self.var_54d07407)) {
      foreach(player in getplayers()) {
        self show_portrait_to(player);
      }
    }

    return;
  }

  soundent hide();

  if(mask == #"friendly") {
    foreach(player in getplayers()) {
      if(player.team == self.team) {
        self play_to(soundent, player);
      }
    }
  } else if(mask == #"enemy") {
    foreach(player in getplayers()) {
      if(player.team != self.team) {
        self play_to(soundent, player);
      }
    }
  } else if(mask == #"self") {
    if(isplayer(self)) {
      self play_to(soundent, player);
    }
  }

  if(isDefined(var_17ee4803) && isplayer(var_17ee4803)) {
    self play_to(soundent, var_17ee4803);
  }
}

private play_to(soundent, player) {
  if(isDefined(soundent)) {
    soundent showtoplayer(player);
  }

  if(isDefined(self.var_54d07407)) {
    self show_portrait_to(player);
  }
}

private show_portrait_to(player) {
  player luinotifyevent(#"offsite_comms_message", 1, self.var_54d07407);
  player thread close_portrait(self);
}

private close_portrait(speaker) {
  self endon(#"disconnect");
  level endon(#"game_ended");
  speaker waittill(#"death", #"entering_last_stand", #"disconnect", #"voice_stop", #"voice_done");
  self luinotifyevent(#"offsite_comms_complete");
}

play_notetrack(scriptid) {
  alias = function_7897846a(scriptid);

  if(!isDefined(alias)) {
    return;
  }

  if(isDefined(self gettagorigin("J_Head"))) {
    soundent = self playsoundwithnotify(alias, "voice_done", "J_Head");
  } else {
    soundent = self playsoundwithnotify(alias, "voice_done");
  }

  if(!self flagsys::get(#"scene")) {
    return;
  }

  if(isDefined(self._scene_object) && isDefined(self._scene_object._o_scene) && isDefined(self._scene_object._o_scene._str_team)) {
    str_team = self._scene_object._o_scene._str_team;
  } else {
    str_team = self._scene_object._str_team;
  }

  if(isDefined(str_team) && str_team != #"any") {
    soundent hide();

    foreach(player in getplayers()) {
      if(isDefined(player._scene_object) && isDefined(player._scene_object._o_scene) && isDefined(self._scene_object._o_scene) && player._scene_object._o_scene == self._scene_object._o_scene) {
        self play_to(soundent, player);
        continue;
      }

      if(!isDefined(player._scene_object) && isDefined(player.var_e3d6d713) && isDefined(self._scene_object._o_scene) && player.var_e3d6d713 == self._scene_object._o_scene._str_name) {
        self play_to(soundent, player);
        continue;
      }

      if(self flagsys::get(#"hash_e2ce599b208682a") && self util::is_on_side(player.team) || self flagsys::get(#"hash_f21f320f68c0457") && !self util::is_on_side(player.team)) {
        self play_to(soundent, player);
      }
    }
  }
}

function_29b858dc() {
  chrname = self.var_3975c22;

  if(!isDefined(chrname) && isplayer(self)) {
    chrname = self getchrname();
  }

  return chrname;
}

get_chr_alias(scriptkey) {
  chrname = self function_29b858dc();

  if(!isDefined(chrname)) {
    return undefined;
  }

  aliases = function_b7854c63(chrname, scriptkey);

  if(aliases.size == 0) {
    return undefined;
  }

  return array::random(aliases);
}

function_5f8e1b94(scriptkey) {
  chrname = self function_29b858dc();

  if(!isDefined(chrname)) {
    return undefined;
  }

  return function_b7854c63(chrname, scriptkey);
}

function_e2a07e55() {
  return isDefined(level.handlers) && isDefined(level.handlers[#"allies"]) && isDefined(level.handlers[#"axis"]);
}

function_42a109b9() {
  return isDefined(level.commanders) && isDefined(level.commanders[#"allies"]) && isDefined(level.commanders[#"axis"]);
}

function_a36ee9b7() {
  if(isDefined(self.var_556f910a) && self.var_556f910a.size > 0) {
    return self.var_556f910a[0];
  }

  return undefined;
}

function_17945809() {
  if(isDefined(self.var_556f910a) && self.var_556f910a.size > 0) {
    return self.var_556f910a[self.var_556f910a.size - 1];
  }

  return undefined;
}

function_93932552(s_voice) {
  if(isDefined(self.var_556f910a)) {
    interrupt = isDefined(s_voice.params) ? s_voice.params.interrupt : 0;
    priority = function_8e0c80fb(s_voice);

    if(isDefined(interrupt) && interrupt && isDefined(self.var_47282775)) {
      if(priority > function_8e0c80fb(self.var_47282775)) {
        self stop();
        arrayinsert(self.var_556f910a, s_voice, 0);
        return;
      }
    }

    if(self.var_556f910a.size == 0) {
      arrayinsert(self.var_556f910a, s_voice, 0);
      return;
    }

    if(priority > function_8e0c80fb(function_a36ee9b7())) {
      arrayinsert(self.var_556f910a, s_voice, 0);
      return;
    }

    if(priority <= function_8e0c80fb(function_17945809())) {
      arrayinsert(self.var_556f910a, s_voice, self.var_556f910a.size);
      return;
    }

    for(i = 0; i < self.var_556f910a.size; i++) {
      if(priority <= function_8e0c80fb(self.var_556f910a[i]) && priority > function_8e0c80fb(self.var_556f910a[i + 1])) {
        arrayinsert(self.var_556f910a, s_voice, i + 1);
        break;
      }
    }
  }
}

function_777704ce() {
  voice = undefined;

  if(isDefined(self.var_556f910a) && self.var_556f910a.size > 0) {
    voice = function_a36ee9b7();
    arrayremoveindex(self.var_556f910a, 0);
  }

  return voice;
}

function_8e0c80fb(s_voice) {
  if(!isDefined(s_voice.params) || !isDefined(s_voice.params.priority)) {
    return 0;
  }

  return s_voice.params.priority;
}