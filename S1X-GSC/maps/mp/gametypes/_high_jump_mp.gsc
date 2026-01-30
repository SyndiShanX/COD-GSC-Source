/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_high_jump_mp.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init()

{
  if(!isAugmentedGameMode()) {
    return;
  }

  level.map_border_trig_array = getEntArray("boost_jump_border_trig", "targetname");

  high_jump_enable();

  thread high_jump_host_migration();
  thread high_jump_on_player_spawn();
}

high_jump_enable()

{
  SetDevDvar("slide_hold_change_stance_time_ms", 1);
  SetDevDvar("power_slide_cooldown_time_sec", 1);
  SetDevDvar("power_slide_on_radar", 1);
  SetDevDvar("power_slide_on_tactical", 0);
  SetDevDvar("power_slide_no_friction_time", 50);
  SetDevDvar("power_slide_speed_scale", 1.3);

  SetDevDvarIfUninitialized("exo_dodge_weapon_disable_time", 0.2);

  SetDevDvar("ground_slam_min_height", maps\mp\_exo_suit::getGroundSlamMinHeight());
  SetDevDvar("ground_slam_max_height", maps\mp\_exo_suit::getGroundSlamMaxHeight());
  SetDevDvar("ground_slam_min_damage", maps\mp\_exo_suit::getGroundSlamMinDamage());
  SetDevDvar("ground_slam_max_damage", maps\mp\_exo_suit::getGroundSlamMaxDamage());
  SetDevDvar("ground_slam_min_radius", maps\mp\_exo_suit::getGroundSlamMinRadius());
  SetDevDvar("ground_slam_max_radius", maps\mp\_exo_suit::getGroundSlamMaxRadius());
}

high_jump_on_player_spawn()

{
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    player thread map_border_hud_updater();
    player playerAllowHighJump(true);
    player playerAllowHighJumpDrop(true);
    player playerAllowBoostJump(true);
    player playerAllowPowerSlide(true);
    player playerAllowDodge(true);
    player thread exo_dodge_think();

    player SetClientOmnvar("ui_border_warning_toggle", 0);
  }
}

high_jump_host_migration()

{
  level endon("game_ended");

  while(true) {
    level waittill("host_migration_end");

    high_jump_enable();
  }
}

map_border_hud_updater()

{
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");

  self.touching_border = undefined;

  while(true) {
    if(isDefined(level.map_border_trig_array)) {
      touching_border = false;
      foreach(trigger in level.map_border_trig_array) {
        touching = self isTouching(trigger);
        if(touching) {
          touching_border = true;
          break;
        }
      }

      if(!isDefined(self.touching_border) || self.touching_border != touching_border) {
        if(touching_border) {
          self SetClientOmnvar("ui_border_warning_toggle", 1);
        } else {
          self SetClientOmnvar("ui_border_warning_toggle", 0);
        }

        self.touching_border = touching_border;
      }
    }

    wait 0.05;
  }
}

exo_dodge_think()

{
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(true) {
    self waittill("exo_dodge");

    cooldown_sec = GetDvarFloat("dodge_cooldown_time_sec", 0.2);

    thread exo_dodge_cooldown();
    maps\mp\_exo_suit::exo_power_cooldown(cooldown_sec);
  }
}

exo_dodge_cooldown()

{
  canUseWeapon = GetDvarFloat("dodge_weapon_enable", true);

  if(!canUseWeapon) {
    weapon_disable_time = GetDvarInt("exo_dodge_weapon_disable_time", 0.2);

    self _disableWeapon();
    wait weapon_disable_time;
    self _enableWeapon();
  }
}