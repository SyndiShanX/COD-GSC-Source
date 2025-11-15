/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_vest_init.gsc
*********************************************/

initdogvestanimations() {
  if(isDefined(anim.notfirsttimedogvests)) {
    return;
  }
  anim.notfirsttimedogvests = 1;
  animscripts\dog\dog_init::initdoganimations();
}