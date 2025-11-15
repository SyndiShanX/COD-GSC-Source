/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_shipment_ns_art.gsc
*************************************************/

main() {
  level.tweakfile = true;
  level.parse_fog_func = maps\createart\mp_shipment_ns_fog::main;

  setDevDvar("scr_fog_disable", 0);
  VisionSetNaked("mp_shipment_ns", 0);
}