/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\step_up_12.gsc
***********************************************/

#include common_scripts\utility;
#include animscripts\traverse\shared;

main() {
  self endon("killanimscript");
  preparefortraverse();
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  realheight = startnode.traverse_height - startnode.origin[2];
  destination = realheight;
  offset = (0, 0, destination / 6);
  self traversemode("noclip");

  for(i = 0; i < 6; i++) {
    self teleport(self.origin + offset);
    wait 0.05;
  }

  self traversemode("gravity");
}