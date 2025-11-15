/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\flashed.gsc
*****************************************************/

#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_utility;
#include maps\_anim;
#include maps\_utility;
#using_animtree("generic_human");

initFlashed() {
  assert(0);
  randomizeFlashAnimArray();
  anim.flashAnimIndex = 0;
}

randomizeFlashAnimArray() {
  for(i = 0; i < anim.flashAnimArray.size; i++) {
    switchwith = randomint(anim.flashAnimArray.size);
    temp = anim.flashAnimArray[i];
    anim.flashAnimArray[i] = anim.flashAnimArray[switchwith];
    anim.flashAnimArray[switchwith] = temp;
  }
}

getNextFlashAnim() {
  anim.flashAnimIndex++;
  if(anim.flashAnimIndex >= anim.flashAnimArray.size) {
    anim.flashAnimIndex = 0;
    randomizeFlashAnimArray();
  }
  return anim.flashAnimArray[anim.flashAnimIndex];
}

flashBangAnim() {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", getNextFlashAnim(), % body);
  self animscripts\shared::DoNoteTracks("flashed_anim");
}

main() {
  assert(0);
  self endon("killanimscript");
  animscripts\utility::initialize("flashed");
  if(self.a.pose == "prone")
    self ExitProneWrapper(1);
  self.a.pose = "stand";
  self startFlashBanged();
  self animscripts\face::SayGenericDialogue("flashbang");
  self.allowdeath = true;
  if(isDefined(self.flashedanim))
    self setanimknoball(self.flashedanim, % body);
  else
    self thread flashBangAnim();
  for(;;) {
    time = gettime();
    if(time > self.flashendtime) {
      self notify("stop_flashbang_effect");
      self setFlashBanged(false);
      self.flashed = false;
      break;
    }
    wait(0.05);
  }
}