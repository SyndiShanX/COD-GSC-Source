/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_suit.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

getGroundSlamMinHeight() {
  return 120;
}

getGroundSlamMaxHeight() {
  return 380;
}

getGroundSlamMinDamage() {
  return 50;
}

getGroundSlamMaxDamage() {
  return 110;
}

getGroundSlamMinRadius() {
  return 75;
}

getGroundSlamMaxRadius() {
  return 125;
}

init() {
  SetDevDvarIfUninitialized("ground_slam_min_height", getGroundSlamMinHeight());
  SetDevDvarIfUninitialized("ground_slam_max_height", getGroundSlamMaxHeight());
  SetDevDvarIfUninitialized("ground_slam_min_damage", getGroundSlamMinDamage());
  SetDevDvarIfUninitialized("ground_slam_max_damage", getGroundSlamMaxDamage());
  SetDevDvarIfUninitialized("ground_slam_min_radius", getGroundSlamMinRadius());
  SetDevDvarIfUninitialized("ground_slam_max_radius", getGroundSlamMaxRadius());

  level._effect["exo_slam_kneeslide_fx"] = LoadFX("vfx/code/slam_jetpack_kneeslide");
  level thread onPlayerConnect();
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player thread monitorGroundSlam();
    player thread monitorGroundSlamHitPlayer();
  }
}

monitorGroundSlam() {
  self endon("disconnect");

  time = 10;
  origin_size = 4;
  forward = (1, 0, 0);
  right = (0, 1, 0);
  up = (0, 0, 1);

  bounding_box_radius_offset = 16;

  while(1) {
    self waittill("ground_slam", height);

    if(isDefined(level.groundSlam) && self[[level.groundSlam]](height)) {
      continue;
    }

    min_height = GetDvarFloat("ground_slam_min_height", getGroundSlamMinHeight());
    max_height = GetDvarFloat("ground_slam_max_height", getGroundSlamMaxHeight());

    min_damage = GetDvarFloat("ground_slam_min_damage", getGroundSlamMinDamage());
    max_damage = GetDvarFloat("ground_slam_max_damage", getGroundSlamMaxDamage());

    min_radius = GetDvarFloat("ground_slam_min_radius", getGroundSlamMinRadius());
    max_radius = GetDvarFloat("ground_slam_max_radius", getGroundSlamMaxRadius());

    if(height < min_height) {
      continue;
    }

    scale = (height - min_height) / (max_height - min_height);
    scale = clamp(scale, 0.0, 1.0);

    radius = ((max_radius - min_radius) * scale) + min_radius;
    concussion_radius = radius + 60;
    concussion_radius_sq = concussion_radius * concussion_radius;

    self RadiusDamage(self.origin, radius, max_damage, min_damage, self, "MOD_TRIGGER_HURT", "boost_slam_mp");

    if(self _hasPerk("specialty_exo_slamboots")) {
      playFXOnTag(level._effect["exo_slam_kneeslide_fx"], self, "j_knee_ri");
      PhysicsExplosionSphere(self.origin, radius, 20, 1);

      foreach(player in level.players) {
        if(isReallyAlive(player) && player != self && (!level.teamBased || player.team != self.team) && !player isUsingRemote()) {
          if(DistanceSquared(self.origin, player.origin) < concussion_radius_sq) {
            player ShellShock("concussion_grenade_mp", 1.5);
            self maps\mp\gametypes\_missions::processChallenge("ch_perk_overcharge");
          }
        }
      }
    } else {
      PhysicsExplosionSphere(self.origin, radius, 20, 0.9);
    }

    if(GetDvarInt("ground_slam_debug")) {
      thread draw_circle_for_time(self.origin, radius + bounding_box_radius_offset, (0, 1, 0), false, 16, time);

      player_health = 100;

      kill_radius = ((player_health - min_damage) * radius) / (max_damage - min_damage);

      thread draw_circle_for_time(self.origin, kill_radius + bounding_box_radius_offset, (1, 0, 0), false, 16, time);

      foreach(player in level.players) {
        line(player.origin, player.origin + (forward * origin_size), forward, 1.0, false, int(time / .05));
        line(player.origin, player.origin + (right * origin_size), right, 1.0, false, int(time / .05));
        line(player.origin, player.origin + (up * origin_size), up, 1.0, false, int(time / .05));
      }
    }
  }
}

draw_circle_for_time(center, radius, color, depthTest, segments, time) {
  loops = time / .05;
  for(i = 0; i < loops; i++) {
    maps\mp\bots\_bots_util::bot_draw_circle(center, radius, color, depthTest, segments);
    wait .05;
  }
}

monitorGroundSlamHitPlayer() {
  self endon("disconnect");

  while(1) {
    self waittill("ground_slam_hit_player", victim);

    if(isDefined(level.groundSlamHitPlayer) && self[[level.groundSlamHitPlayer]](victim)) {
      continue;
    }

    victim DoDamage(victim.health, self.origin, self, self, "MOD_CRUSH", "boost_slam_mp");
  }
}

exo_power_cooldown(cooldown_time_sec)

{
  cooldown_ms = int(cooldown_time_sec * 1000);

  self SetClientOmnvar("ui_exo_cooldown_time", cooldown_ms);
  wait cooldown_time_sec;
  self SetClientOmnvar("ui_exo_cooldown_time", 0);

  self PlayLocalSound("exo_power_recharged");
}