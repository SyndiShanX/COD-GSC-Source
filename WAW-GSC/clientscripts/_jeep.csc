/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_jeep.csc
**************************************/

#include clientscripts\_vehicle;

main(model, type) {
  if(!isDefined(type)) {
    type = "jeep";
  }

  one_exhaust = undefined;
  if(type == "horch") {
    one_exhaust = true;
  }

  build_exhaust(model, "vehicle/exhaust/fx_exhaust_horch", one_exhaust);
  build_treadfx(type);
}