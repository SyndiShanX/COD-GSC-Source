/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\af_chase_zodiac.gsc
********************************************************/

#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include common_scripts\utility;
#include maps\_hud_util;
#include maps\_vehicle_spline_zodiac;

clear_all_ai_grenades() {
  add_global_spawn_function("axis", ::no_grenades);
  ai = getaiarray("axis");
  foreach(guy in ai) {
    guy no_grenades();
  }
}

no_grenades() {
  self.grenadeammo = 0;
}

zodiac_main() {
  thread enemy_zodiacs_wipe_out();

  init_vehicle_splines();

  clear_all_ai_grenades();

  level.enemy_snowmobiles_max = 1;

  flag_wait("player_on_boat");

  level.longRegenTime = 2000;

  if(level.player.deathInvulnerableTime > 2000) {
    level.player.deathInvulnerableTime = 2000;
  }

  zodiac = level.players_boat;
  assert(isDefined(zodiac));

  level.player thread track_player_progress(zodiac.origin);

  flag_wait("exit_caves");

  level.player.baseIgnoreRandomBulletDamage = true;
  level.ignoreRandomBulletDamage = true;

  level.doPickyAutosaveChecks = false;
  level.autosave_threat_check_enabled = false;

  level.bike_score = 0;
  thread enemy_zodiacs_spawn_and_attack();
}

player_path_trigger_think() {
  self waittill("trigger");
  node = getvehiclenode(self.target, "targetname");

  level.player.vehicle.veh_pathType = "follow";
  level.player.vehicle startPath(node);
}

enemy_zodiacs_spawn_and_attack() {
  if(flag("enemy_zodiacs_wipe_out")) {
    return;
  }
  level endon("enemy_zodiacs_wipe_out");
  wait_time = 3;
  wait(2);
  for(;;) {
    thread spawn_enemy_bike();
    wait(wait_time);
    wait_time -= 0.5;
    if(wait_time < 0.5) {
      wait_time = 0.5;
    }
  }
}

trigger_enemy_zodiacs_wipe_out() {
  self waittill("trigger");
  flag_set("enemy_zodiacs_wipe_out");
}

enemy_zodiacs_wipe_out() {
  flag_wait("enemy_zodiacs_wipe_out");
  foreach(enemy in level.enemy_snowmobiles) {
    enemy thread wipeout_soon();
  }
}

wipeout_soon() {
  self endon("death");
  wait(randomfloatrange(2, 4));
  if(!isDefined(self)) {
    return;
  }
  self.wipeout = true;
}