/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_sherman.gsc
**************************************/

#include maps\mp\_vehicles;

main(model, type) {
  build_template("sherman", model, type);
  build_exhaust("vehicle/exhaust/fx_exhaust_sherman");
  build_treadfx(type);
  build_rumble("tank_rumble_mp", 0.1, 2, 500, 0.1, 0);
}