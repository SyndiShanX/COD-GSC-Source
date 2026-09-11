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

function notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  var_4 = "right";

  if(var_2) {
    var_4 = "left";
  }

  if(var_3) {
    self notify("large_footstep");
  }

  self.asm.footsteps.foot = var_4;
  self.asm.footsteps.time = gettime();
}

function handlenotetrack(var_0, var_1, var_2, var_3) {
  if(scripts\anim\notetracks::hascustomnotetrackhandler(var_0)) {
    return scripts\anim\notetracks::handlecustomnotetrackhandler(var_0, var_1, var_2, var_3);
  }

  var_4 = scripts\anim\notetracks::handlecommonnotetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_4) && var_4 == "__unhandled") {
    var_4 = undefined;

    switch (var_0) {
      case "attach_clip_left":
        if(weaponclass(self.weapon) == "rocketlauncher") {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(var_2)) {
          if(isDefined(var_3)) {
            return [[var_2]](var_0, var_3);
          } else {
            return [[var_2]](var_0);
          }
        }

        break;
    }
  }

  return var_4;
}

function notetrack_prefix_handler_mp(var_0) {
  return scripts\anim\notetracks::notetrack_prefix_handler_common(var_0);
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

function notetrackgundrop(var_0, var_1) {
  if(isDefined(self.playercleanupentondisconnect)) {
    self[[self.playercleanupentondisconnect]]();
    return;
  }
}

function setpose(var_0) {
  self.currentpose = var_0;
  scripts\asm\asm_bb::bb_requeststance(var_0);
  self notify("entered_pose" + var_0);
}

function notetrackposestand(var_0, var_1) {
  setpose("stand");
}

function notetrackposecrouch(var_0, var_1) {
  setpose("crouch");
}

function notetrackposeprone(var_0, var_1) {
  setpose("prone");
}