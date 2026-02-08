/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_truck.csc
**************************************/

#include clientscripts\_vehicle;

main(model, type) {
  if(!isDefined(type)) {
    type = "model94";
  }

  one_exhaust = undefined;
  if(type == "model94" || type == "opel") {
    one_exhaust = true;
  }

  build_exhaust(model, "vehicle/exhaust/fx_exhaust_generic_truck", one_exhaust);
  build_treadfx(type);
}