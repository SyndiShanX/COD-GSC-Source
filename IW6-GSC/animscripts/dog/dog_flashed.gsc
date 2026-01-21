/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_flashed.gsc
*******************************************/

#using_animtree("dog");

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["flashed"]]]();
      return;
    }
  }

  self endon("killanimscript");
  self endon("stop_flashbang_effect");
  wait(randomfloatrange(0, 0.4));
  self clearanim(%body, 0.1);
  var_0 = maps\_utility::flashbanggettimeleftsec();

  if(var_0 > 2 && randomint(100) > 60)
    self setflaggedanimrestart("flashed_anim", getdogflashedanim("flash_long"), 1, 0.2, self.animplaybackrate * 0.75);
  else
    self setflaggedanimrestart("flashed_anim", getdogflashedanim("flash_short"), 1, 0.2, self.animplaybackrate);

  var_1 = getanimlength(getdogflashedanim("flash_short")) * self.animplaybackrate;

  if(var_0 < var_1)
    animscripts\notetracks::donotetracksfortime(var_0, "flashed_anim");
  else
    animscripts\shared::donotetracks("flashed_anim");

  self.flashed = 0;
  self notify("stop_flashbang_effect");
}

getdogflashedanim(var_0) {
  var_1 = animscripts\utility::lookupdoganim("reaction", var_0);
  return var_1;
}