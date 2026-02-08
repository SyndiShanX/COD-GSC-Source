/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_artillery.csc
****************************************/

#include clientscripts\_vehicle;

main(model, type) {
  if(!isDefined(type)) {
    type = "at47";
  }

  build_treadfx(type);
}