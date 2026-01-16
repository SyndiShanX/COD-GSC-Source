/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\flashed.gsc
********************************/

#using_animtree("generic_human");

init_animset_flashed() {
  var_0 = [];
  var_0["flashed"] = [ % exposed_flashbang_v2, % exposed_flashbang_v4];
  var_0["flashed"] = common_scripts\utility::array_randomize(var_0["flashed"]);
  anim.archetypes["soldier"]["flashed"] = var_0;
  anim.flashanimindex["soldier"] = 0;
}

getnextflashanim() {
  var_0 = "soldier";

  if(isdefined(self.animarchetype) && isdefined(anim.flashanimindex[self.animarchetype]))
    var_0 = self.animarchetype;

  anim.flashanimindex[var_0]++;

  if(anim.flashanimindex[var_0] >= anim.archetypes[var_0]["flashed"]["flashed"].size) {
    anim.flashanimindex[var_0] = 0;
    anim.archetypes[var_0]["flashed"]["flashed"] = common_scripts\utility::array_randomize(anim.archetypes[var_0]["flashed"]["flashed"]);
  }

  return anim.archetypes[var_0]["flashed"]["flashed"][anim.flashanimindex[var_0]];
}

flashbanganim(var_0) {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", var_0, % body, 0.2, randomfloatrange(0.9, 1.1));
  animscripts\shared::donotetracks("flashed_anim");
}

main() {
  self endon("death");
  self endon("killanimscript");
  animscripts\utility::initialize("flashed");
  var_0 = maps\_utility::flashbanggettimeleftsec();

  if(var_0 <= 0) {
    return;
  }
  animscripts\face::saygenericdialogue("flashbang");

  if(isdefined(self.specialflashedfunc)) {
    self[[self.specialflashedfunc]]();
    return;
  }

  var_1 = getnextflashanim();
  flashbangedloop(var_1, var_0);
}

flashbangedloop(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");

  if(self.a.pose == "prone")
    animscripts\utility::exitpronewrapper(1);

  self.a.pose = "stand";
  self.allowdeath = 1;
  thread flashbanganim(var_0);
  wait(var_1);
  self notify("stop_flashbang_effect");
  self.flashed = 0;
}