/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\civilian.gsc
********************************/

#using_animtree("generic_human");

cover() {
  self endon("killanimscript");
  self clearanim( % animscript_root, 0.2);
  animscripts\utility::updateisincombattimer();

  if(animscripts\utility::isincombat())
    var_0 = "idle_combat";
  else
    var_0 = "idle_noncombat";

  var_1 = undefined;

  if(isdefined(self.animname) && isdefined(level.scr_anim[self.animname]))
    var_1 = level.scr_anim[self.animname][var_0];

  if(!isdefined(var_1)) {
    if(!isdefined(level.scr_anim["default_civilian"])) {
      return;
    }
    var_1 = level.scr_anim["default_civilian"][var_0];
  }

  thread move_check();

  for (;;) {
    self setflaggedanimknoball("idle", common_scripts\utility::random(var_1), % animscript_root, 1, 0.2, 1);
    self waittillmatch("idle", "end");
  }
}

move_check() {
  self endon("killanimscript");

  while (!isdefined(self.champion))
    wait 1;
}

stop() {
  cover();
}

get_flashed_anim() {
  return anim.civilianflashedarray[randomint(anim.civilianflashedarray.size)];
}