/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_pentagon_amb.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;
#include maps\_ambientpackage;

main() {
  level thread setup_phone_audio();
}

setup_phone_audio() {
  wait(1);
  level.phone_counter = 0;
  array_thread(getEntArray("secret_phone_trig", "targetname"), ::phone_egg);
}

phone_egg() {
  if(!isDefined(self)) {
    return;
  }
  phone = getEnt(self.target, "targetname");
  if(isDefined(phone)) {
    blinky = playFXOnTag(level._effect["fx_zombie_light_glow_telephone"], phone, "tag_light");
  }
  self UseTriggerRequireLookAt();
  self SetCursorHint("HINT_NOICON");
  self playLoopSound("zmb_egg_phone_loop");
  self waittill("trigger", player);
  self stopLoopSound(1);
  player playSound("zmb_egg_phone_activate");
  level.phone_counter = level.phone_counter + 1;
  if(level.phone_counter == 3) {
    level pentagon_unlock_doa();
    playsoundatposition("evt_doa_unlock", (0, 0, 0));
    wait(5);
    level thread play_music_easter_egg();
  }
}

play_music_easter_egg() {
  level.music_override = true;
  if(is_mature()) {
    level thread maps\_zombiemode_audio::change_zombie_music("egg");
  } else {
    level.music_override = false;
    return;
  }
  wait(265);
  level.music_override = false;
  level thread maps\_zombiemode_audio::change_zombie_music("wave_loop");
}

play_pentagon_announcer_vox(alias, defcon_level) {
  if(!isDefined(alias))
    return;
  if(!isDefined(level.pentann_is_speaking)) {
    level.pentann_is_speaking = 0;
  }
  if(isDefined(defcon_level))
    alias = alias + "_" + defcon_level;
  if(level.pentann_is_speaking == 0) {
    level.pentann_is_speaking = 1;
    level play_initial_alarm();
    level play_sound_2D(alias);
    level.pentann_is_speaking = 0;
  }
}

play_initial_alarm() {
  structs = getstructarray("defcon_alarms", "targetname");
  for(i = 0; i < structs.size; i++) {
    playsoundatposition("evt_thief_alarm_single", structs[i].origin);
  }
  wait(.5);
}

pentagon_unlock_doa() {
  level.ZOMBIE_PENTAGON_PLAYER_CF_UPDATEPROFILE = 0;
  players = get_players();
  array_thread(players, ::pentagon_delay_update);
}

pentagon_delay_update() {
  self endon("death");
  self endon("disconnect");
  self SetClientDvars("zombietron_discovered", 1);
  wait(0.2);
  self SetClientFlag(level.ZOMBIE_PENTAGON_PLAYER_CF_UPDATEPROFILE);
}