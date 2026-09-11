/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\notetracks_mp.gsc
***********************************************/

function registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }

  anim.notetracks = [];
  registernotetracks();
}

function registernotetracks() {
  level._defaultnotetrackhandler = &handlenotetrack;
  level.fnnotetrackprefixhandler = &notetrack_prefix_handler_mp;
  scripts\anim\notetracks::registernotetracks();
  anim.notetracks["footstep_right_large"] = &notetrackfootstep;
  anim.notetracks["footstep_right_small"] = &notetrackfootstep;
  anim.notetracks["footstep_left_large"] = &notetrackfootstep;
  anim.notetracks["footstep_left_small"] = &notetrackfootstep;
  anim.notetracks["anim_pose = stand"] = &notetrackposestand;
  anim.notetracks["anim_pose = crouch"] = &notetrackposecrouch;
  anim.notetracks["anim_pose = prone"] = &notetrackposeprone;
  anim.notetracks["gun drop"] = &notetrackgundrop;
  anim.notetracks["dropgun"] = &notetrackgundrop;
}

function notetrackfootstep(var0, var1) {
  var2 = issubstr(var0, "left");
  var3 = issubstr(var0, "large");
  var4 = "right";

  if(var2) {
    var4 = "left";
  }

  if(var3) {
    self notify("large_footstep");
  }

  self.asm.footsteps.foot = var4;
  self.asm.footsteps.time = gettime();
}

function handlenotetrack(var0, var1, var2, var3) {
  if(scripts\anim\notetracks::hascustomnotetrackhandler(var0)) {
    return scripts\anim\notetracks::handlecustomnotetrackhandler(var0, var1, var2, var3);
  }

  var4 = scripts\anim\notetracks::handlecommonnotetrack(var0, var1, var2, var3);

  if(isDefined(var4) && var4 == "__unhandled") {
    var4 = undefined;

    switch (var0) {
      case "attach_clip_left":
        if(weaponclass(self.weapon) == "rocketlauncher") {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(var2)) {
          if(isDefined(var3)) {
            return [[var2]](var0, var3);
          } else {
            return [[var2]](var0);
          }
        }

        break;
    }
  }

  return var4;
}

function notetrack_prefix_handler_mp(var0) {
  return scripts\anim\notetracks::notetrack_prefix_handler_common(var0);
}

function notetrackrocketlauncherammoattach() {
  if(!isalive(self)) {
    return;
  }

  if(!scripts\anim\utility_common::usingrocketlauncher()) {
    return;
  }

  if(self tagexists("tag_rocket")) {
    self showpart("tag_rocket");
    return;
  }
}

function notetrackgundrop(var0, var1) {
  if(isDefined(self.playercleanupentondisconnect)) {
    self[[self.playercleanupentondisconnect]]();
    return;
  }
}

function setpose(var0) {
  self.currentpose = var0;
  scripts\asm\asm_bb::bb_requeststance(var0);
  self notify("entered_pose" + var0);
}

function notetrackposestand(var0, var1) {
  setpose("stand");
}

function notetrackposecrouch(var0, var1) {
  setpose("crouch");
}

function notetrackposeprone(var0, var1) {
  setpose("prone");
}