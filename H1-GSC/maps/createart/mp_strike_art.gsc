/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_strike_art.gsc
********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_strike_fog_hdr::setupfog();
  else
    maps\createart\mp_strike_fog::setupfog();

  visionsetnaked("mp_strike", 0);
}