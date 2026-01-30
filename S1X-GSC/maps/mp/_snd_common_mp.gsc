/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_snd_common_mp.gsc
***************************************************/

#include common_scripts\utility;
#include common_scripts\_exploder;
#include maps\mp\_audio;

init() {
  snd_message_init();
  register_common_mp_snd_messages();
  thread snd_mp_mix_init();
}

snd_mp_mix_init() {
  level._snd.dynamic_event_happened = false;

  if(isDefined(level.players) && level.players.size > 0) {
    foreach(player in level.players) {
      AssertEx(isDefined(player), "isDefined( player )");
      player clientaddsoundsubmix("mp_init_mix");
      wait(0.05);
      player clientaddsoundsubmix("mp_pre_event_mix");
      wait(0.05);
    }
  }
}

snd_mp_mix_post_event() {
  level._snd.dynamic_event_happened = true;
  if(isDefined(level.players) && level.players.size > 0) {
    foreach(player in level.players) {
      AssertEx(isDefined(player), "isDefined( player )");
      player clientclearsoundsubmix("mp_pre_event_mix");
      wait(0.05);
      player clientaddsoundsubmix("mp_post_event_mix");
      wait(0.05);
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

snd_register_message(message, callback) {
  assertEx(isDefined(level._snd), "Need to call snd_message_init() before calling this function.");
  assert(IsArray(level._snd.messages));
  level._snd.messages[message] = callback;
}

snd_music_message(message, arg1, arg2) {
  level notify("stop_other_music");
  level endon("stop_other_music");

  if(isDefined(arg2)) {
    childthread snd_message("snd_music_handler", message, arg1, arg2);
  } else if(isDefined(arg1)) {
    childthread snd_message("snd_music_handler", message, arg1);
  } else {
    childthread snd_message("snd_music_handler", message);
  }
}

snd_message(message, arg1, arg2, arg3) {
  AssertEx(isDefined(level._snd), "Need to call snd_message_init() before calling this function.");
  Assert(IsArray(level._snd.messages));

  if(isDefined(level._snd.messages[message])) {
    if(isDefined(arg3)) {
      thread[[level._snd.messages[message]]](arg1, arg2, arg3);
    } else if(isDefined(arg2)) {
      thread[[level._snd.messages[message]]](arg1, arg2);
    } else if(isDefined(arg1)) {
      thread[[level._snd.messages[message]]](arg1);
    } else {
      thread[[level._snd.messages[message]]]();
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
  self PlaylocalSound("mp_exo_hover_activate");
  self PlaylocalSound("mp_exo_hover_fuel");

  self waittill("stop_exo_hover_effects");

  self PlaylocalSound("mp_exo_hover_deactivate");
  self StopLocalSound("mp_exo_hover_sup_fuel");
}

mp_suppressed_exo_hover() {
  self PlaylocalSound("mp_exo_hover_sup_activate");
  self PlaylocalSound("mp_exo_hover_sup_fuel");

  self waittill("stop_exo_hover_effects");

  self PlaylocalSound("mp_exo_hover_sup_deactivate");
  self StopLocalSound("mp_exo_hover_sup_fuel");
}

mp_exo_mute_activate() {
  self PlayLocalSound("mp_exo_mute_activate");
}

mp_exo_mute_deactivate() {
  self PlayLocalSound("mp_exo_mute_deactivate");
}

mp_exo_overclock_activate() {
  self playSound("mp_exo_overclock_activate");
}

mp_exo_overclock_deactivate() {
  self playSound("mp_exo_overclock_deactivate");
}

mp_exo_ping_activate() {
  self PlayLocalSound("mp_exo_ping_activate");
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
  playSoundAtPos(self.origin, "mp_exo_trophy_intercept");
}

mp_exo_shield_activate() {
  self playSound("mp_exo_shield_activate");
}

mp_exo_shield_deactivate() {
  self playSound("mp_exo_shield_deactivate");
}

mp_wpn_exo_knife_player_impact() {
  playSoundAtPos(self.origin, "wpn_combatknife_stab_npc");
}

mp_ks_goliath_pod_burst() {
  self PlayLocalSound("goliath_suit_up_pod_burst");
}

mp_ks_goliath_death_explosion() {
  self playSound("goliath_death_destruct");
}

mp_ks_goliath_self_destruct() {
  self playSound("goliath_death_destruct");
}