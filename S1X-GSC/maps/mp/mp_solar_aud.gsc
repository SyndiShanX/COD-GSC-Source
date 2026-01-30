/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_solar_aud.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {}

watchForLaserMovement(normal) {
  array_sound_start();

  self endon("solar_reflector_player_removed");

  tolerance = 0.05;
  is_moving = false;

  last_vec = self GetPlayerAngles();
  sound_ent = spawn("script_origin", level.solar_reflector_cam_tag.origin);
  sound_ent LinkTo(level.solar_reflector_cam_tag);
  self thread wait_for_laser_end(sound_ent);

  while(1) {
    cur_vec = self GetPlayerAngles();
    dist = Distance2D(cur_vec, last_vec);

    if(dist > tolerance) {
      if(!is_moving) {
        sound_ent playLoopSound("mp_solar_array_player_move");
        sound_ent ScaleVolume(.7, 0.1);
        is_moving = true;
      }
    } else {
      if(is_moving) {
        sound_ent ScaleVolume(0, 0.3);
        sound_ent StopLoopSound();
        is_moving = false;
      }
    }

    last_vec = cur_vec;
    wait(0.05);
  }
}

array_sound_start() {
  playSoundAtPos((1423.67, 1543.22, 64.4061), "mp_solar_array_generator");
}

wait_for_laser_end(ent) {
  self waittill("solar_reflector_player_removed");
  ent StopLoopSound();
  wait(0.25);
  ent delete();
}