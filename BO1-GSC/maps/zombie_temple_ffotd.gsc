/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_ffotd.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

main_start() {
  SetSavedDvar("sm_sunShadowSmallScriptPS3OnlyEnable", true);
  PreCacheModel("p_glo_corrugated_metal1");
  level thread spikemore_delete_all_on_end_game();
}

main_end() {
  seam_debris = spawn("script_model", (-574, -1108.5, -415));
  seam_debris setModel("p_glo_corrugated_metal1");
  seam_debris.angles = (359.542, 192.199, 89.6195);
  level.timed_killbrush_in_start_area_geyser = maps\_zombiemode::spawn_kill_brush((-25, -1025, -175), 90, 170);
  level.timed_killbrush_in_minecart_area_geyser = maps\_zombiemode::spawn_kill_brush((1092, -1000, -100), 60, 90);
  level.player_out_of_playable_area_monitor_callback = ::zombie_temple_player_out_of_playable_area_monitor_callback;
}

spikemore_delete_all_on_end_game() {
  level waittill("end_game");
  if(!isDefined(level.spikemores)) {
    return;
  }
  for(i = level.spikemores.size - 1; i >= 0; i--) {
    level.spikemores[i] delete();
  }
}

zombie_temple_player_out_of_playable_area_monitor_callback() {
  if(is_true(self.on_slide)) {
    return false;
  }
  if(is_true(self.riding_geyser)) {
    return false;
  }
  if(is_true(self.is_on_minecart)) {
    return false;
  }
  if(self istouching(level.timed_killbrush_in_start_area_geyser)) {
    for(i = 0; i < 60; i++) {
      wait(0.05);
      if(!self istouching(level.timed_killbrush_in_start_area_geyser)) {
        return false;
      }
    }
  }
  if(self istouching(level.timed_killbrush_in_minecart_area_geyser)) {
    for(i = 0; i < 60; i++) {
      wait(0.05);
      if(!self istouching(level.timed_killbrush_in_minecart_area_geyser)) {
        return false;
      }
    }
  }
  return true;
}