/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\traverse\through_hole_42.gsc
************************************************************/

#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\utility;

main() {
  self endon("killanimscript");
  self traverseMode("nogravity");
  self traverseMode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self OrientMode("face angle", startnode.angles[1]);
  realHeight = startnode.traverse_height - startnode.origin[2];
  self thread teleportThread(realHeight);
  debug_anim_print("traverse::through_hole()");
  self setanimstate("traverse_through_hole_42");
  maps\mp\animscripts\shared::DoNoteTracksForTime(1.0, "done");
  debug_anim_print("traverse::through_hole()");
  self.traverseComplete = true;
}