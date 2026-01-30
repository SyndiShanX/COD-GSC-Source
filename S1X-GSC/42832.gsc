/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42832.gsc
**************************************/

init() {
  snd_message_init();
  register_common_mp_snd_messages();
  thread snd_mp_mix_init();
}

snd_mp_mix_init() {
  level._snd.dynamic_event_happened = 0;

  if(isDefined(level.players) && level.players.size > 0) {
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

  if(isDefined(level.players) && level.players.size > 0) {
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

  if(!isDefined(level._snd.dynamic_event_happened) || !level._snd.dynamic_event_happened) {
    self clientaddsoundsubmix("mp_pre_event_mix");
  } else {
    self clientclearsoundsubmix("mp_pre_event_mix");
    self clientaddsoundsubmix("mp_post_event_mix");
  }
}

snd_message_init() {
  if(!isDefined(level._snd)) {
    level._snd = spawnStruct();
  }

  if(!isDefined(level._snd.messages)) {
    level._snd.messages = [];
  }
}

snd_register_message(var_0, var_1) {
  level._snd.messages[var_0] = var_1;
}

snd_music_message(var_0, var_1, var_2) {
  level notify("stop_other_music");
  level endon("stop_other_music");

  if(isDefined(var_2)) {
    childthread snd_message("snd_music_handler", var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    childthread snd_message("snd_music_handler", var_0, var_1);
  } else {
    childthread snd_message("snd_music_handler", var_0);
  }
}

snd_message(var_0, var_1, var_2, var_3) {
  if(isDefined(level._snd.messages[var_0])) {
    if(isDefined(var_3)) {
      thread[[level._snd.messages[var_0]]](var_1, var_2, var_3);
    } else if(isDefined(var_2)) {
      thread[[level._snd.messages[var_0]]](var_1, var_2);
    } else if(isDefined(var_1)) {
      thread[[level._snd.messages[var_0]]](var_1);
    } else {
      thread[[level._snd.messages[var_0]]]();
    }
  }
}

register_common_mp_snd_messages() {
  snd_register_message("mp_exo_cloak_activate", ::mp_exo_cloak_activate);
  snd_register_message("mp_exo_cloak_deactivate", ::mp_exo_cloak_deactivate);
  snd_register_message("mp_exo_health_activate", ::mp_exo_health_activate);
  snd_register_message("mp_exo_health_deactivate", ::mp_exo_health_deactivate);
  snd_register_message("mp_regular_exo_hover", ::mp_regular_exo_hover);
  snd_register_message("mp_suppressed_exo_hover", ::mp_suppressed_exo_hover);
  snd_register_message("mp_exo_mute_activate", ::mp_exo_mute_activate);
  snd_register_message("mp_exo_mute_deactivate", ::mp_exo_mute_deactivate);
  snd_register_message("mp_exo_overclock_activate", ::mp_exo_overclock_activate);
  snd_register_message("mp_exo_overclock_deactivate", ::mp_exo_overclock_deactivate);
  snd_register_message("mp_exo_ping_activate", ::mp_exo_ping_activate);
  snd_register_message("mp_exo_ping_deactivate", ::mp_exo_ping_deactivate);
  snd_register_message("mp_exo_repulsor_activate", ::mp_exo_repulsor_activate);
  snd_register_message("mp_exo_repulsor_deactivate", ::mp_exo_repulsor_deactivate);
  snd_register_message("mp_exo_repulsor_repel", ::mp_exo_repulsor_repel);
  snd_register_message("mp_exo_shield_activate", ::mp_exo_shield_activate);
  snd_register_message("mp_exo_shield_deactivate", ::mp_exo_shield_deactivate);
  snd_register_message("goliath_pod_burst", ::mp_ks_goliath_pod_burst);
  snd_register_message("goliath_death_explosion", ::mp_ks_goliath_death_explosion);
  snd_register_message("goliath_self_destruct", ::mp_ks_goliath_self_destruct);
  snd_register_message("exo_knife_player_impact", ::mp_wpn_exo_knife_player_impact);
}

mp_exo_cloak_activate() {
  self playSound("mp_exo_cloak_activate");
}

mp_exo_cloak_deactivate() {
  self playSound("mp_exo_cloak_deactivate");
}

mp_exo_health_activate() {
  self playSound("mp_exo_stim_activate");
}

mp_exo_health_deactivate() {
  self playSound("mp_exo_stim_deactivate");
}

mp_regular_exo_hover() {
  self playlocalsound("mp_exo_hover_activate");
  self playlocalsound("mp_exo_hover_fuel");
  self waittill("stop_exo_hover_effects");
  self playlocalsound("mp_exo_hover_deactivate");
  self stoplocalsound("mp_exo_hover_sup_fuel");
}

mp_suppressed_exo_hover() {
  self playlocalsound("mp_exo_hover_sup_activate");
  self playlocalsound("mp_exo_hover_sup_fuel");
  self waittill("stop_exo_hover_effects");
  self playlocalsound("mp_exo_hover_sup_deactivate");
  self stoplocalsound("mp_exo_hover_sup_fuel");
}

mp_exo_mute_activate() {
  self playlocalsound("mp_exo_mute_activate");
}

mp_exo_mute_deactivate() {
  self playlocalsound("mp_exo_mute_deactivate");
}

mp_exo_overclock_activate() {
  self playSound("mp_exo_overclock_activate");
}

mp_exo_overclock_deactivate() {
  self playSound("mp_exo_overclock_deactivate");
}

mp_exo_ping_activate() {
  self playlocalsound("mp_exo_ping_activate");
}

mp_exo_ping_deactivate() {
  self playSound("mp_exo_ping_deactivate");
}

mp_exo_repulsor_activate() {
  self playSound("mp_exo_trophy_activate");
}

mp_exo_repulsor_deactivate() {
  self playSound("mp_exo_trophy_deactivate");
}

mp_exo_repulsor_repel() {
  playsoundatpos(self.origin, "mp_exo_trophy_intercept");
}

mp_exo_shield_activate() {
  self playSound("mp_exo_shield_activate");
}

mp_exo_shield_deactivate() {
  self playSound("mp_exo_shield_deactivate");
}

mp_wpn_exo_knife_player_impact() {
  playsoundatpos(self.origin, "wpn_combatknife_stab_npc");
}

mp_ks_goliath_pod_burst() {
  self playlocalsound("goliath_suit_up_pod_burst");
}

mp_ks_goliath_death_explosion() {
  self playSound("goliath_death_destruct");
}

mp_ks_goliath_self_destruct() {
  self playSound("goliath_death_destruct");
}