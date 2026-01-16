/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_showdown_art.gsc
**********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_showdown_fog_hdr::setupfog();
  else
    maps\createart\mp_showdown_fog::setupfog();

  visionsetnaked("mp_showdown", 0);
}