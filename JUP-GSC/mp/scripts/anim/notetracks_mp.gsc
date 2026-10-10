/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\notetracks_mp.gsc
***********************************************/

#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace notetracks_mp;

function registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }

  anim.notetracks = [];
  registernotetracks();
}

function registernotetracks() {
  level._defaultnotetrackhandler = &handlenotetrack;
  level.fnnotetrackprefixhandler = &function_6d9ff7d18e45dc9c;
  scripts\anim\notetracks::registernotetracks();
  anim.notetracks["anim_pose = stand"] = &notetrackposestand;
  anim.notetracks["anim_pose = crouch"] = &notetrackposecrouch;
  anim.notetracks["anim_pose = prone"] = &notetrackposeprone;
  anim.notetracks["gun drop"] = &notetrackgundrop;
  anim.notetracks["dropgun"] = &notetrackgundrop;
}

function handlenotetrack(note, flagname, customfunction, customparams) {
  if(scripts\anim\notetracks::hascustomnotetrackhandler(note)) {
    return scripts\anim\notetracks::handlecustomnotetrackhandler(note, flagname, customfunction, customparams);
  }

  retval = scripts\anim\notetracks::handlecommonnotetrack(note, flagname, customfunction, customparams);

  if(isDefined(retval) && retval == "__unhandled") {
    retval = undefined;

    switch (note) {
      case #"hash_88cce8d6571fe7e1":
        if(weaponclass(self.weapon) == "rocketlauncher") {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(customfunction)) {
          if(isDefined(customparams)) {
            return [[customfunction]](note, customparams);
          } else {
            return [[customfunction]](note);
          }
        }

        break;
    }
  }

  return retval;
}

function function_6d9ff7d18e45dc9c(notetrack) {
  prefix = getsubstr(notetrack, 0, 3);

  if(prefix == "as_") {
    alias = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](alias);
    }

    return 1;
  }

  if(prefix == "vm_") {
    animation = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playvm_func)) {
      self thread[[self.anim_playvm_func]](animation);
    }

    return 1;
  }

  if(prefix == "ws_") {
    state = getsubstr(notetrack, 3);

    if(isDefined(self.weapon_state_func)) {
      self thread[[self.weapon_state_func]](state);
    }

    return 1;
  }

  if(prefix == "cm_") {
    var_d8958445ed7ab829 = getsubstr(notetrack, 3);

    if(isDefined(self.cinematic_motion_override)) {
      self thread[[self.cinematic_motion_override]](var_d8958445ed7ab829);
    }

    return 1;
  }

  if(prefix == "df_") {
    doftype = getsubstr(notetrack, 3);

    if(isDefined(self.dof_func)) {
      self thread[[self.dof_func]](doftype);
    }

    return 1;
  }

  return scripts\anim\notetracks::notetrack_prefix_handler_common(notetrack);
}

function notetrackrocketlauncherammoattach() {
  assert(isDefined(self));

  if(!isalive(self)) {
    return;
  }

  if(!usingrocketlauncher()) {
    return;
  }

  if(self tagexists("tag_rocket")) {
    self showpart("tag_rocket");
  }
}

function notetrackgundrop(note, flagname) {
  if(!isai(self)) {
    println("<dev string:x1c>" + function_a2eaafb222316a2(self) + "<dev string:x31>" + note + "<dev string:x47>");
    return;
  }

  if(isDefined(self.fndropweapon)) {
    self[[self.fndropweapon]]();
  }
}

function setpose(pose) {
  self.currentpose = pose;
  scripts\asm\asm_bb::bb_requeststance(pose);
  self notify("entered_pose" + pose);
}

function notetrackposestand(note, flagname) {
  setpose("stand");
}

function notetrackposecrouch(note, flagname) {
  setpose("crouch");
}

function notetrackposeprone(note, flagname) {
  setpose("prone");
}