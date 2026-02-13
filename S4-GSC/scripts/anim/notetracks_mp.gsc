/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\notetracks_mp.gsc
*************************************************/

_id_C27D() {
  if(isDefined(anim._id_A64F)) {
    return;
  }
  anim._id_A64F = [];
  _id_C27C();
}

_id_C27C() {
  level._id_0BB2 = ::_id_7476;
  level._id_5DAC = ::_id_A606;
  scripts\anim\notetracks::_id_C27C();
  anim._id_A64F["footstep_right_large"] = ::_id_A629;
  anim._id_A64F["footstep_right_small"] = ::_id_A629;
  anim._id_A64F["footstep_left_large"] = ::_id_A629;
  anim._id_A64F["footstep_left_small"] = ::_id_A629;
  anim._id_A64F["anim_pose = stand"] = ::_id_A647;
  anim._id_A64F["anim_pose = crouch"] = ::_id_A645;
  anim._id_A64F["anim_pose = prone"] = ::_id_A646;
  anim._id_A64F["gun drop"] = ::_id_A62B;
  anim._id_A64F["dropgun"] = ::_id_A62B;
}

_id_A629(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  var_4 = "right";

  if(var_2) {
    var_4 = "left";
  }

  if(var_3) {
    self notify("large_footstep");
  }

  self._id_1C30._id_5E3A._id_5E36 = var_4;
  self._id_1C30._id_5E3A._id_F1E8 = gettime();
}

_id_7476(var_0, var_1, var_2, var_3) {
  if(scripts\anim\notetracks::_id_7550(var_0)) {
    return scripts\anim\notetracks::_id_742E(var_0, var_1, var_2, var_3);
  }

  var_4 = scripts\anim\notetracks::_id_742C(var_0, var_1, var_2, var_3);

  if(isDefined(var_4) && var_4 == "__unhandled") {
    var_4 = undefined;

    switch (var_0) {
      case "attach_clip_left":
        if(weaponclass(self._id_04F6) == "rocketlauncher") {
          _id_A64E();
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

_id_A606(var_0) {
  return scripts\anim\notetracks::_id_A605(var_0);
}

_id_A64E() {
  if(!isalive(self)) {
    return;
  }
  if(!scripts\anim\utility_common::_id_FF1B()) {
    return;
  }
  if(self tagexists("tag_rocket")) {
    self showpart("tag_rocket");
  }
}

_id_A62B(var_0, var_1) {
  if(isDefined(self._id_5D7A)) {
    self[[self._id_5D7A]]();
  }
}

_id_D683(var_0) {
  self._id_0131 = var_0;
  _id_06BD::_id_23F7(var_0);
  self notify("entered_pose" + var_0);
}

_id_A647(var_0, var_1) {
  _id_D683("stand");
}

_id_A645(var_0, var_1) {
  _id_D683("crouch");
}

_id_A646(var_0, var_1) {
  _id_D683("prone");
}