/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\flashed.gsc
***********************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace flashed;

function init_animset_flashed() {}

function getnextflashanim() {
  archetype = "soldier";
  assert(isDefined(anim.flashanimindex));

  if(isDefined(self.animarchetype) && isDefined(anim.flashanimindex[self.animarchetype])) {
    archetype = self.animarchetype;
  }

  anim.flashanimindex[archetype]++;
  assert(isDefined(anim.archetypes[archetype]["flashed"]["flashed"]) && anim.archetypes[archetype]["flashed"]["flashed"].size > 0);

  if(anim.flashanimindex[archetype] >= anim.archetypes[archetype]["flashed"]["flashed"].size) {
    anim.flashanimindex[archetype] = 0;
    anim.archetypes[archetype]["flashed"]["flashed"] = array_randomize(anim.archetypes[archetype]["flashed"]["flashed"]);
  }

  return anim.archetypes[archetype]["flashed"]["flashed"][anim.flashanimindex[archetype]];
}

#using_animtree("generic_human");

function flashbanganim(animation) {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", animation, %body, 0.2, randomfloatrange(0.9, 1.1));
  scripts\anim\notetracks::donotetracks("flashed_anim");
}

function main() {
  self endon("death");
  self endon("killanimscript");
  scripts\anim\utility::initialize("flashed");
  flashduration = flashbanggettimeleftsec();

  if(flashduration <= 0) {
    return;
  }

  scripts\anim\face::saygenericdialogue("flashbang");

  if(isDefined(self.specialflashedfunc)) {
    self[[self.specialflashedfunc]]();
    return;
  }

  animation = getnextflashanim();
  flashbangedloop(animation, flashduration);
}

function flashbangedloop(animation, duration) {
  self endon("death");
  self endon("killanimscript");
  assert(isDefined(animation));
  assert(isDefined(duration));
  assert(duration > 0);

  if(self.currentpose == "prone") {
    exitpronewrapper(1);
  }

  self.currentpose = "stand";
  self.allowdeath = 1;
  thread flashbanganim(animation);
  wait duration;
  self notify("stop_flashbang_effect");
  self.flashed = 0;
}