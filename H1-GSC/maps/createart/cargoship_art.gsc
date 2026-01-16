/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\cargoship_art.gsc
********************************************/

main() {
  level.tweakfile = 1;
  level.player = getentarray("player", "classname")[0];

  if(isusinghdr())
    maps\createart\cargoship_fog_hdr::main();
  else
    maps\createart\cargoship_fog::main();
}