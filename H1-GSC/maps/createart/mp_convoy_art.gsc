/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_convoy_art.gsc
********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_convoy_fog_hdr::main();
  else
    maps\createart\mp_convoy_fog::main();

  visionsetnaked("mp_convoy", 0);
}