/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\dog_flashed.gsc
***********************************************/

#include maps\mp\animscripts\shared;

main() {
  self endon("killanimscript");
  self endon("stop_flashbang_effect");
  wait(randomfloatrange(0, 0.4));
  duration = self startflashbanged() * 0.001;
  self setanimstate("flashed");
  self maps\mp\animscripts\shared::donotetracks("done");
  self setflashbanged(0);
  self.flashed = 0;
  self notify("stop_flashbang_effect");
}

startflashbanged() {
  if(isDefined(self.flashduration))
    duration = self.flashduration;
  else
    duration = self getflashbangedstrength() * 1000;

  self.flashendtime = gettime() + duration;
  self notify("flashed");
  return duration;
}