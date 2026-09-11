/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\flashed.gsc
***********************************************/

function init_animset_flashed() {}

function getnextflashanim() {
  var_0 = "soldier";

  if(isDefined(self.animarchetype) && isDefined(anim.flashanimindex[self.animarchetype])) {
    var_0 = self.animarchetype;
  }

  anim.flashanimindex[var_0]++;

  if(anim.flashanimindex[var_0] >= anim.archetypes[var_0]["flashed"]["flashed"].size) {
    anim.flashanimindex[var_0] = 0;
    anim.archetypes[var_0]["flashed"]["flashed"] = scripts\engine\utility::array_randomize(anim.archetypes[var_0]["flashed"]["flashed"]);
  }

  return anim.archetypes[var_0]["flashed"]["flashed"][anim.flashanimindex[var_0]];
}

#using_animtree("generic_human");

function flashbanganim(var_0) {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", var_0, %body, 0.2, randomfloatrange(0.9, 1.1));
  scripts\anim\notetracks::donotetracks("flashed_anim");
}

function main() {
  self endon("death");
  self endon("killanimscript");
  scripts\anim\utility::initialize("flashed");
  var_0 = scripts\engine\utility::flashbanggettimeleftsec();

  if(var_0 <= 0) {
    return;
  }

  scripts\anim\face::saygenericdialogue("flashbang");

  if(isDefined(self.specialflashedfunc)) {
    self[[self.specialflashedfunc]]();
    return;
  }

  var_1 = getnextflashanim();
  flashbangedloop(var_1, var_0);
}

function flashbangedloop(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");

  if(self.currentpose == "prone") {
    scripts\anim\utility::exitpronewrapper(1);
  }

  self.currentpose = "stand";
  self.allowdeath = 1;
  thread flashbanganim(var_0);
  wait var_1;
  self notify("stop_flashbang_effect");
  self.flashed = 0;
}