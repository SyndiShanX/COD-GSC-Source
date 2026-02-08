/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_stand.gsc
***************************************/

#include animscripts\Combat_utility;
#include animscripts\Utility;
#include common_scripts\Utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");

  if(self usingGasWeapon()) {
    self animscripts\stop::main();
    return;
  }

  self trackScriptState("Cover Stand Main", "code");
  animscripts\utility::initialize("cover_stand");

  self animscripts\cover_wall::cover_wall_think("stand");
}