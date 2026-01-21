/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_flashed.gsc
**********************************************/

#include animscripts\Combat_utility;
#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  self endon("stop_flashbang_effect");
  wait RandomFloatRange(0, 0.4);
  self ClearAnim(%root, 0.1);
  duration = self startFlashBanged() * 0.001;
  if(duration > 2 && randomInt(100) > 60) {
    self SetFlaggedAnimRestart("flashed_anim", %zombie_dog_run_pain, 1, 0.2, self.animplaybackrate * 0.75);
  } else {
    self SetFlaggedAnimRestart("flashed_anim", %zombie_dog_run_flashbang, 1, 0.2, self.animplaybackrate);
  }
  animLength = getanimlength(%zombie_dog_run_flashbang) * self.animplaybackrate;
  if(duration < animLength) {
    self animscripts\zombie_shared::DoNoteTracksForTime(duration, "flashed_anim");
  } else {
    self animscripts\zombie_shared::DoNoteTracks("flashed_anim");
  }
  self SetFlashBanged(false);
  self.flashed = false;
  self notify("stop_flashbang_effect");
}