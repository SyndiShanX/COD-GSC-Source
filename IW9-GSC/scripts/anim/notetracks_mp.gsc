/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\notetracks_mp.gsc
***********************************************/

registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }
  anim.notetracks = [];
  registernotetracks();
}

registernotetracks() {
  level._defaultnotetrackhandler = ::handlenotetrack;
  level.fnnotetrackprefixhandler = ::notetrack_prefix_handler_mp;
  _id_357B9A54DFEDBD4A::registernotetracks();
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
  anim.notetracks["anim_pose = stand"] = ::notetrackposestand;
  anim.notetracks["anim_pose = crouch"] = ::notetrackposecrouch;
  anim.notetracks["anim_pose = prone"] = ::notetrackposeprone;
  anim.notetracks["gun drop"] = ::notetrackgundrop;
  anim.notetracks["dropgun"] = ::notetrackgundrop;
}

notetrackfootstep(_id_A234A65C378F3289, flagname) {
  _id_AE6DB4AB3762FF57 = issubstr(_id_A234A65C378F3289, "left");
  _id_7DDBE22A1278C165 = issubstr(_id_A234A65C378F3289, "large");
  foot = "right";

  if(_id_AE6DB4AB3762FF57)
    foot = "left";

  if(_id_7DDBE22A1278C165)
    self notify("large_footstep");

  self.asm.footsteps.foot = foot;
  self.asm.footsteps.time = gettime();
}

handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  if(_id_357B9A54DFEDBD4A::hascustomnotetrackhandler(_id_A234A65C378F3289))
    return _id_357B9A54DFEDBD4A::handlecustomnotetrackhandler(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);

  _id_EAABF9463637080F = _id_357B9A54DFEDBD4A::handlecommonnotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);

  if(isDefined(_id_EAABF9463637080F) && _id_EAABF9463637080F == "__unhandled") {
    _id_EAABF9463637080F = undefined;

    switch (_id_A234A65C378F3289) {
      case "attach_clip_left":
        if(weaponclass(self.weapon) == "rocketlauncher")
          notetrackrocketlauncherammoattach();

        break;
      default:
        if(isDefined(_id_ED9FB5D37A4C823E)) {
          if(isDefined(_id_35CE7799B701C978))
            return [[_id_ED9FB5D37A4C823E]](_id_A234A65C378F3289, _id_35CE7799B701C978);
          else
            return [[_id_ED9FB5D37A4C823E]](_id_A234A65C378F3289);
        }

        break;
    }
  }

  return _id_EAABF9463637080F;
}

notetrack_prefix_handler_mp(notetrack) {
  return _id_357B9A54DFEDBD4A::notetrack_prefix_handler_common(notetrack);
}

notetrackrocketlauncherammoattach() {
  if(!isalive(self)) {
    return;
  }
  if(!_id_2B79931B08683E0A::usingrocketlauncher()) {
    return;
  }
  if(self tagexists("tag_rocket"))
    self showpart("tag_rocket");
}

notetrackgundrop(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fndropweapon))
    self[[self.fndropweapon]]();
}

setpose(_id_5CAA9F9F456B4040) {
  self.currentpose = _id_5CAA9F9F456B4040;
  scripts\asm\asm_bb::bb_requeststance(_id_5CAA9F9F456B4040);
  self notify("entered_pose" + _id_5CAA9F9F456B4040);
}

notetrackposestand(_id_A234A65C378F3289, flagname) {
  setpose("stand");
}

notetrackposecrouch(_id_A234A65C378F3289, flagname) {
  setpose("crouch");
}

notetrackposeprone(_id_A234A65C378F3289, flagname) {
  setpose("prone");
}