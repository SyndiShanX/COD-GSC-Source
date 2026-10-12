/*******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_shipment_xmas\mp_jup_shipment_xmas_audio.gsc
*******************************************************************************/

#namespace mp_jup_shipment_xmas_audio;

function main() {
  thread function_7144210e1f4103e8();
}

function function_7144210e1f4103e8() {
  if(istrue(level.snowballfight)) {
    level endon("game_ended");
    level.var_d13ed50cfe72fa6a = spawn("script_model", (1953, -199, 412));
    level.var_d13ed50cfe72fa6a playLoopSound("amb_shipment_emt_xmas_music_lp");
    return;
  }

  return;
}