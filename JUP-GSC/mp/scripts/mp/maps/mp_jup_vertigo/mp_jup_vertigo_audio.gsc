/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_audio.gsc
**********************************************************************/

#using scripts\engine\utility;
#namespace mp_jup_vertigo_audio;

function main() {}

function function_c8f303cb5ce4d4f1(forward_mover) {
  forward_mover playsoundonmovingent("sfx_mp_vertigo_moving_block_forward_start");
  forward_mover waittill("movedone");
  forward_mover playsoundonmovingent("sfx_mp_vertigo_moving_block_forward_stop");
}

function function_15f3cb16ea85459b(back_mover) {
  back_mover playsoundonmovingent("sfx_mp_vertigo_moving_block_back_start");
  back_mover waittill("movedone");
  back_mover playsoundonmovingent("sfx_mp_vertigo_moving_block_back_stop");
}

function function_a98ceea0b676d81a(forward_mover) {
  forward_mover waittill("movedone");
  forward_mover playsoundonmovingent("sfx_mp_vertigo_moving_block_push_stop");
}

function function_f182f4bfb0416785(rotater) {
  rotater play_loop_sound_on_entity("sfx_mp_vertigo_rotate");
}

function rotatestopsound(rotater) {
  rotater playsoundonmovingent("sfx_mp_vertigo_rotate_stop");
}