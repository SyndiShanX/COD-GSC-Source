/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_pipeline_art.gsc
**********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_pipeline_fog_hdr::setupfog();
  else
    maps\createart\mp_pipeline_fog::setupfog();

  visionsetnaked("mp_pipeline", 0);
}