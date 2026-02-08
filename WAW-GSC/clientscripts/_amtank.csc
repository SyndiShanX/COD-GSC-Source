/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_amtank.csc
**************************************/

#include clientscripts\_vehicle;

main(model, type) {
  build_exhaust(model, "vehicle/exhaust/fx_exhaust_lvt");
  build_treadfx("amtank");
  build_rumble("amtank", "tank_rumble", 0.15, 4.5, 600, 1, 1);
}