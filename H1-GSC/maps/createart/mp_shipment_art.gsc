/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_shipment_art.gsc
**********************************************/

main() {
  level.tweakfile = 1;

  if(isusinghdr())
    maps\createart\mp_shipment_fog_hdr::main();
  else
    maps\createart\mp_shipment_fog::main();

  visionsetnaked("mp_shipment", 0);
}