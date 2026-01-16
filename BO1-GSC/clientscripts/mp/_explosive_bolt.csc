/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_explosive_bolt.csc
************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_rewindobjects;

main() {
  level._effect["crossbow_enemy_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level._effect["crossbow_friendly_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
  PrintLn("crossbow_enemy_light :" + level._effect["crossbow_enemy_light"]);
  PrintLn("crossbow_friendly_light :" + level._effect["crossbow_friendly_light"]);
}
spawned(localClientNum, play_sound) {
  self endon("entityshutdown");
  friend = self friendNotFoe(localClientNum);
  self.fxTagName = "tag_origin";
  if(!friend) {
    if(play_sound) {
      self thread loop_local_sound(localClientNum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_enemy_light"]);
    } else {
      PlayFXOnTag(localClientNum, level._effect["crossbow_enemy_light"], self, self.fxTagName);
    }
  } else {
    if(play_sound) {
      self thread loop_local_sound(localClientNum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_friendly_light"]);
    } else {
      PlayFXOnTag(localClientNum, level._effect["crossbow_friendly_light"], self, self.fxTagName);
    }
  }
}
loop_local_sound(localClientNum, alias, interval, fx) {
  self endon("entityshutdown");
  while (1) {
    self waittill_dobj(localClientNum);
    self PlaySound(localClientNum, alias);
    PlayFXOnTag(localClientNum, fx, self, self.fxTagName);
    owner = self GetOwner(localClientNum);
    self.stuckToPlayer = self GetParentEntity();
    localPlayer = GetLocalPlayer(localClientNum);
    if(isDefined(self.stuckToPlayer) && self.stuckToPlayer IsPlayer() && isDefined(owner.team)) {
      if(isDefined(self.stuckToPlayer.team)) {
        if(self.stuckToPlayer.team == "free" || self.stuckToPlayer.team != owner.team) {
          self.stuckToPlayer PlayRumbleOnEntity(localClientNum, "buzz_high");
          if((localPlayer == self.stuckToPlayer) && !(localPlayer IsDriving(localClientNum))) {
            if(IsSplitscreen())
              AnimateUI(localClientNum, "sticky_grenade_overlay" + localClientNum, "overlay", "pulse", 0);
            else
              AnimateUI(localClientNum, "sticky_grenade_overlay", "overlay", "pulse", 0);
            if(!IsSplitscreen() && GetDvarInt(#"ui_hud_hardcore") == 0)
              AnimateUI(localClientNum, "stuck", "explosive_bolt", "pulse", 0);
          }
        }
      }
    }
    serverWait(localClientNum, interval);
    interval = (interval / 1.2);
    if(interval < .1) {
      interval = .1;
    }
  }
}