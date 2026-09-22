/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\474.gsc
**************************************/

main() {
  wait 0;

  if(isDefined(self)) {
    self delete();
  }
}

codecallback_entityoutofworld() {
  self endon("death");
  waitframe();
  self delete();
}