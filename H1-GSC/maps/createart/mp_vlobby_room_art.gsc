/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_vlobby_room_art.gsc
*************************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_vlobby_room_fog_hdr::main();
  else
    maps\createart\mp_vlobby_room_fog::main();

  visionsetnaked("mp_vlobby_room", 0);
}