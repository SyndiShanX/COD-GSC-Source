/*******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_highrise_xmas\mp_jup_highrise_xmas_audio.gsc
*******************************************************************************/

#namespace mp_jup_highrise_xmas_audio;

function main() {
  thread function_96aaa35375c864db();
}

function function_96aaa35375c864db() {
  if(istrue(level.snowballfight)) {
    level endon("game_ended");
    level.var_d13ed50cfe72fa6a = spawn("script_model", (109, 292, 3913));
    level.var_d13ed50cfe72fa6a playLoopSound("amb_highrise_emt_xmas_music_lp");
    return;
  }

  return;
}