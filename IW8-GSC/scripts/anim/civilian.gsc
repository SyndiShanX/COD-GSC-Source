/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\civilian.gsc
***********************************************/

#using_animtree("");

function cover() {
  self endon("killanimscript");
  self clearanim(%root, 0.2);
  scripts\anim\utility::updateisincombattimer();

  if(scripts\anim\utility::isincombat()) {
    var_0 = "idle_combat";
  } else {
    var_0 = "idle_noncombat";
  }

  var_1 = undefined;

  if(isDefined(self.animname) && isDefined(level.scr_anim[self.animname])) {
    var_1 = level.scr_anim[self.animname][var_0];
  }

  if(!isDefined(var_1)) {
    if(!isDefined(level.scr_anim["default_civilian"])) {
      return;
    }

    var_1 = level.scr_anim["default_civilian"][var_0];
  }

  thread move_check();

  for(;;) {
    self setflaggedanimknoball("idle", scripts\engine\utility::random(var_1), $root, 1, 0.2, 1);
    self waittillmatch("idle", "end");
  }
}

function move_check() {
  self endon("killanimscript");

  while(!isDefined(self.champion)) {
    wait 1;
  }
}

function stop() {
  cover();
}

function get_flashed_anim() {
  return anim.civilianflashedarray[randomint(anim.civilianflashedarray.size)];
}