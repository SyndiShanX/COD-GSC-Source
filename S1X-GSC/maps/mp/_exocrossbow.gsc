/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exocrossbow.gsc
***************************************************/

#include common_scripts\utility;

CONST_exocrossbow_weaponname = "iw5_exocrossbow";
CONST_explosion_delay_time = 1.5;

monitor_exocrossbow_launch() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  level._effect["exocrossbow_sticky_explosion"] = LoadFx("vfx/explosion/frag_grenade_default");
  level._effect["exocrossbow_sticky_blinking"] = LoadFx("vfx/lights/light_beacon_crossbow");

  Assert(isPlayer(self) || IsAgent(self));

  while(true) {
    self waittill("missile_fire", projectile, weaponName);

    if(!IsSubStr(weaponName, CONST_exocrossbow_weaponname)) {
      continue;
    }

    projectile setOtherEnt(self);
    projectile.ch_crossbow_player_jumping = self IsHighJumping();

    self thread wait_for_stuck(projectile);
  }
}

wait_for_stuck(projectile) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  projectile endon("death");

  projectile waittill("missile_stuck", stuckTo);

  projectile thread determine_sticky_position(self, stuckTo);
}

determine_sticky_position(firing_player, stuckTo) {
  self endon("death");
  firing_player endon("disconnect");
  firing_player endon("faux_spawn");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(stuckTo) && !maps\mp\_utility::inVirtualLobby() && isPlayer(stuckTo)) {
    self.ch_crossbow_victim_jumping = stuckTo IsHighJumping();

    if(firing_player maps\mp\gametypes\_weapons::isStuckToFriendly(stuckTo)) {
      self.isStuck = "friendly";
    } else {
      self.isStuck = "enemy";
      self.stuckEnemyEntity = stuckTo;

      firing_player maps\mp\_events::crossbowStickEvent(stuckTo);
      firing_player notify("process", "ch_bullseye");
    }
  }

  self thread sticky_timer(firing_player);
  self thread sticky_fx(firing_player);
  self thread remove_sticky_on_explosion(firing_player);
  self thread cleanup_sticky_on_death();
  self thread maps\mp\gametypes\_weapons::stickyHandleMovers("detonate");
}

sticky_timer(firing_player) {
  self endon("death");

  wait(CONST_explosion_delay_time);

  self notify("exocrossbow_exploded");
}

sticky_fx(firing_player) {
  self endon("exocrossbow_exploded");
  self endon("death");

  self.fx_origin = spawn_tag_origin();
  self.fx_origin.origin = self.origin;
  self.fx_origin.angles = self.angles;
  self.fx_origin Show();

  self.fx_origin LinkTo(self);

  wait(0.1);

  playFXOnTag(getfx("exocrossbow_sticky_blinking"), self.fx_origin, "tag_origin");

  self playSound("exocrossbow_warning");
}

remove_sticky_on_explosion(firing_player) {
  self endon("death");

  self waittill("exocrossbow_exploded");

  self cleanup_sticky();
}

cleanup_sticky_on_death() {
  self endon("exocrossbow_exploded");

  self waittill("death");

  self cleanup_sticky();
}

cleanup_sticky() {
  stopFXOnTag(getfx("exocrossbow_sticky_blinking"), self.fx_origin, "tag_origin");
  self.fx_origin delete();
}