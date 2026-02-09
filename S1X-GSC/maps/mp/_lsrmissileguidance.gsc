/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_lsrmissileguidance.gsc
***************************************************/

CONST_lsr_weaponname = "maaws";

monitor_lsr_missile_launch() {
  Assert(isPlayer(self) || IsAgent(self));
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(true) {
    self waittill("missile_fire", projectile, weaponName);
    if(IsSubStr(weaponName, CONST_lsr_weaponname)) {
      if(!isDefined(self.lsr_target_ent)) {
        self.lsr_target_ent = spawn("script_origin", self.origin);

        self.lsr_target_ent.targetname = "lsr_missile";
      }

      self.lsr_target_ent thread lsr_target_monitor_and_cleanup(projectile);
      projectile thread lsr_rocket_think(self);
    }
  }
}

lsr_rocket_think(firing_player) {
  self endon("death");

  firing_player endon("death");
  firing_player endon("disconnect");
  firing_player endon("faux_spawn");

  while(true) {
    if(firing_player PlayerAds() > 0.3) {
      firing_player_forward = anglesToForward(firing_player GetPlayerAngles());
      firing_player_eye = firing_player getEye();
      firing_player_eye_lookat = firing_player_eye + firing_player_forward * 15000;

      traceinfo = bulletTrace(firing_player_eye, firing_player_eye_lookat, true, firing_player, true, false, false, false, false);
      firing_player.lsr_target_ent.origin = traceinfo["position"];
      self Missile_SetTargetEnt(firing_player.lsr_target_ent);
    }

    wait(0.05);
  }
}

lsr_target_monitor_and_cleanup(projectile) {
  if(!isDefined(self.lsr_rocket_count)) {
    self.lsr_rocket_count = 1;
  } else {
    self.lsr_rocket_count++;
  }

  projectile waittill("death");
  self.lsr_rocket_count--;

  if(self.lsr_rocket_count == 0) {
    self Delete();
  }
}