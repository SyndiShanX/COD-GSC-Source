/*******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_player_boost_jump_mp.gsc
*******************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

boost_jump_wrapper() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  gameFlagWait("prematch_done");

  self thread play_boost_sound();
}

play_boost_sound() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  was_jumping = self IsJumping();
  while(1) {
    is_jumping = self IsJumping();
    if(is_jumping) {
      if(is_jumping != was_jumping) {
        self PlayRumbleOnEntity("damage_heavy");
        playSoundinSpace("boost_jump_plr_mp", self.origin);
      }
    }

    was_jumping = is_jumping;
    wait(0.05);
  }
}

playerBoostJumpPrecaching() {}