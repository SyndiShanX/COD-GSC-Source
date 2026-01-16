/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_snd_common_mp.gsc
********************************/

init() {
  snd_message_init();
  register_common_mp_snd_messages();
  thread snd_mp_mix_init();
}

snd_mp_mix_init() {
  level._snd.dynamic_event_happened = 0;

  if(isdefined(level.players) && level.players.size > 0) {
    foreach(var_1 in level.players) {
      var_1 clientaddsoundsubmix("mp_init_mix");
      wait 0.05;
      var_1 clientaddsoundsubmix("mp_pre_event_mix");
      wait 0.05;
    }
  }
}

snd_mp_mix_post_event() {
  level._snd.dynamic_event_happened = 1;

  if(isdefined(level.players) && level.players.size > 0) {
    foreach(var_1 in level.players) {
      var_1 clientclearsoundsubmix("mp_pre_event_mix");
      wait 0.05;
      var_1 clientaddsoundsubmix("mp_post_event_mix");
      wait 0.05;
    }
  }
}

snd_mp_player_join() {
  self clientaddsoundsubmix("mp_init_mix");

  if(!isdefined(level._snd.dynamic_event_happened) || !level._snd.dynamic_event_happened)
    self clientaddsoundsubmix("mp_pre_event_mix");
  else {
    self clientclearsoundsubmix("mp_pre_event_mix");
    self clientaddsoundsubmix("mp_post_event_mix");
  }
}

snd_message_init() {
  if(!isdefined(level._snd))
    level._snd = spawnstruct();

  if(!isdefined(level._snd.messages))
    level._snd.messages = [];
}

snd_register_message(var_0, var_1) {
  level._snd.messages[var_0] = var_1;
}

snd_music_message(var_0, var_1, var_2) {
  level notify("stop_other_music");
  level endon("stop_other_music");

  if(isdefined(var_2))
    childthread snd_message("snd_music_handler", var_0, var_1, var_2);
  else if(isdefined(var_1))
    childthread snd_message("snd_music_handler", var_0, var_1);
  else
    childthread snd_message("snd_music_handler", var_0);
}

snd_message(var_0, var_1, var_2, var_3) {
  if(isdefined(level._snd.messages[var_0])) {
    if(isdefined(var_3))
      thread[[level._snd.messages[var_0]]](var_1, var_2, var_3);
    else if(isdefined(var_2))
      thread[[level._snd.messages[var_0]]](var_1, var_2);
    else if(isdefined(var_1))
      thread[[level._snd.messages[var_0]]](var_1);
    else
      thread[[level._snd.messages[var_0]]]();
  }
}

register_common_mp_snd_messages() {
  snd_register_message("exo_knife_player_impact", ::mp_wpn_exo_knife_player_impact);
}

mp_wpn_exo_knife_player_impact() {
  playsoundatpos(self.origin, "wpn_combatknife_stab_npc");
}