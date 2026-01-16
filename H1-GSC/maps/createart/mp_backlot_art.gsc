/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_backlot_art.gsc
*********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_backlot_fog_hdr::setupfog();
  else
    maps\createart\mp_backlot_fog::setupfog();

  visionsetnaked("mp_backlot", 0);
}