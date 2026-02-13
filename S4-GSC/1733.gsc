/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1733.gsc
*************************************************/

_id_D215() {
  if(isDefined(self._id_D214)) {
    return;
  }
  self._id_AA2B = self._id_0321;
  self._id_AA32 = self._id_0322;
  self._id_AA33 = self._id_02A0;
  self._id_0321 = 8;
  self._id_0322 = 8;
  self._id_02A0 = 1;
  self._id_D214 = 1;
}

_id_F9BB() {
  if(!isDefined(self._id_D214)) {
    return;
  }
  self._id_0321 = self._id_AA2B;
  self._id_0322 = self._id_AA32;
  self._id_02A0 = self._id_AA33;
  self._id_D214 = undefined;
}

_id_49FC() {
  self._id_4AB5 = 1;
}

_id_51F5() {
  self._id_4AB5 = 0;
}

_id_4A63() {
  self._id_A6C1 = 1;
}

_id_5232() {
  self._id_A6C1 = undefined;
}

_id_49D9() {
  self._id_4A7F = 1;
}

_id_51DA() {
  self endon("death");
  waittillframeend;
  self._id_4A7F = 0;
}

_id_D371(var_0) {
  self._id_0B67._id_89EF = var_0;
}

_id_D28C(var_0) {
  self._id_029A = var_0;
}

_id_38E7() {
  self._id_029A = -1;
}

_id_6597() {
  if(self._id_029A < 0) {
    return self._id_0500;
  } else {
    return self._id_029A;
  }
}

_id_E137(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(scripts\common\utility::issp() && !isDefined(var_0._id_5B18)) {
    var_0 scripts\engine\utility::_id_108C5("finished spawning", "death");
  }

  if(isalive(var_0)) {
    return 0;
  }

  return 1;
}

_id_72A1() {
  if(isai(self)) {
    scripts\engine\utility::_id_CD61("anim_placeweaponon", self._id_04F6, "none");
  } else if(isDefined(self._id_590D)) {
    _id_72A2();
  } else {
    self _meth_8419();
  }
}

_id_72A2() {
  if(isDefined(self._id_590D)) {
    for(var_0 = self._id_590D.size - 1; var_0 >= 0; var_0--) {
      self detach(self._id_590D[var_0]);
    }

    self._id_590D = undefined;
  }
}

_id_7292(var_0) {
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "toprail") || issubstr(var_2, "railcust")) {
      if(var_0.size > 1) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
        var_0 = scripts\engine\utility::_id_1BB3(var_0, var_2, 1);
      }
    }
  }

  foreach(var_2 in var_0) {
    self attach(var_2);
  }

  self._id_590D = var_0;
}

_id_72A0() {
  if(isai(self)) {
    scripts\engine\utility::_id_CD61("anim_placeweaponon", self._id_04F6, "right");
  } else {
    scripts\engine\utility::_id_CD61("fa_reattach_gun");
  }
}

_id_D23C(var_0, var_1) {
  if(var_0 == "automatic") {
    var_0 = undefined;
  }

  self._id_0212 = var_0;
  self._id_0211 = isDefined(var_1) && var_1;
}

_id_C5BE() {
  self._id_0212 = undefined;
  self._id_0211 = 1;
}

_id_B996(var_0, var_1, var_2, var_3) {
  _id_08F1::_id_F2C9(var_0, var_1, var_2, var_3);
}

_id_B997(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_08F1::_id_F2CA(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_B994(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_3E37)) {
    level._id_3E37 = [];
  }

  if(_func_0107(var_0)) {
    level._id_3E37 = scripts\engine\utility::_id_1B9D(level._id_3E37, var_0);
  } else {
    level._id_3E37[level._id_3E37.size] = var_0;
  }
}

get_turret_tag() {
  return "tag_gunner";
}

_id_FE18(var_0, var_1, var_2, var_3) {
  _id_06BD::_id_23FA(var_0);
  _id_06BD::_id_23FB(var_1);
  _id_FE1B(var_0, var_2, var_3);
}

_id_FE1B(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "tag_gunner";
  }

  if(self _meth_81CC()) {
    self unlink();
  }

  if(_id_06BD::_id_23CE()) {
    self _meth_83EC();
  }

  if(var_0 tagexists(var_1)) {
    var_3 = var_0 gettagorigin(var_1);

    if(isDefined(var_0._id_ADB4) && !istrue(var_0._id_CFC4)) {
      var_4 = var_3;
    } else {
      var_4 = _func_0198(var_3 + (0, 0, 50), var_3 - (0, 0, 50));
    }

    var_5 = var_0 gettagangles(var_1);

    if(isDefined(var_0._id_72BB)) {
      var_6 = rotatevector(var_0._id_72BB, var_5);
      self _meth_80F9(var_4 + var_6, var_5, 10000);
    } else
      self _meth_80F9(var_4, var_5, 10000);

    if(!isDefined(var_2)) {
      var_2 = var_0._id_72BA;
    }

    if(istrue(var_2)) {
      do_stance_based_linkto(var_0, var_1);
      return;
    }

    do_stance_based_linkto(var_0);
    return;
  } else {
    self _meth_80F9(var_0.origin, var_0.angles, 10000);
    do_stance_based_linkto(var_0);
  }
}

do_stance_based_linkto(var_0, var_1) {
  if(!isDefined(var_0._id_ADB4)) {
    if(isDefined(var_1)) {
      self linkto(var_0, var_1);
    } else {
      self linkto(var_0);
    }
  } else if(isDefined(var_1))
    self _meth_820E(var_0, var_1);
  else {
    self _meth_820E(var_0);
  }
}

_id_E8EC(var_0) {
  self notify("stop_use_turret");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self unlink();
  }

  self._id_0B67._id_C574 = undefined;
  self._id_0B67._id_C575 = undefined;
}

_id_67F4(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(self tagexists("tag_pitch")) {
    var_2 = self gettagorigin("tag_pitch");
  } else if(self tagexists("tag_turret_pitch")) {
    var_2 = self gettagorigin("tag_turret_pitch");
  } else {
    var_2 = self.origin;
  }

  var_3 = anglesToForward((0, self.angles[1], 0));
  var_4 = var_2 - var_3 * 20;
  var_5 = var_4 - (0, 0, 100);
  var_6 = _func_0198(var_4, var_5, self);
  var_7 = var_4[2] - var_6[2];

  if(var_7 < 25.5) {
    var_1 = "prone";
  } else if(var_7 < 34.97) {
    var_1 = "crouch";
  } else if(var_7 < 46.97) {
    var_1 = "stand";
  } else {
    var_1 = "stand_high";
  }

  if(istrue(var_0)) {
    return [var_1, var_2, var_4, var_6, var_7];
  } else {
    return var_1;
  }
}

_id_E8B9() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    if(isDefined(self._id_AA0A)) {
      self._id_0074 = self._id_AA0A;
      self._id_AA0A = undefined;
    } else
      self._id_0074 = 1;
  }

  self._id_992D = undefined;
  self._id_014C = 0;
  self notify("internal_stop_magic_bullet_shield");
}

_id_E8BA() {
  if(!isDefined(self._id_992D)) {
    return;
  }
  _id_E8B9();
}

_id_992B() {}

_id_992D(var_0) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self._id_AA0A = self._id_0074;
    self._id_0074 = 0.1;
  }

  self notify("magic_bullet_shield");
  self._id_992D = 1;
  self._id_014C = 1;
}

_id_992E(var_0) {
  if(isDefined(self._id_992D)) {
    return;
  }
  _id_992D(var_0);
}

_id_5E54(var_0) {
  self._id_5EB1 = 4;

  if(istrue(var_0)) {
    self._id_DDAC = 1;
  }

  self _meth_85CA(self._id_1CB8, "choose_long_death");
}

_id_5E53() {
  self._id_5EB1 = 3;
}

_id_5E56() {
  self._id_5EB1 = 2;
}

_id_5AB5(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1;
  var_4 = self _meth_80EC(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    var_5 = var_4.angles;
    var_6 = var_4.origin;

    if(!issubstr(var_4.type, "Prone")) {
      if(issubstr(var_4.type, "Left")) {
        var_5 = var_5 + (0, 90, 0);
      } else if(issubstr(var_4.type, "Right") || issubstr(var_4.type, "Cover Crouch") || issubstr(var_4.type, "Conceal") || issubstr(var_4.type, "Cover Stand")) {
        var_5 = var_5 - (0, 90, 0);
      }
    }

    self _meth_80F9(var_6, var_5);
    self _meth_8423(var_4, 1);
    self _meth_8324(var_4);
    return 1;
  }

  return 0;
}

_id_131D(var_0) {
  if(!isDefined(self._id_0B67._id_131F)) {
    self._id_0B67._id_131F = 1;
    self._id_0B67._id_131E = var_0;
    return 1;
  }

  return 0;
}

_id_131C() {
  if(isDefined(self._id_0B67._id_131F) && self._id_0B67._id_131F == 1) {
    self._id_0B67._id_131F = 2;
  }
}

_id_131A() {
  if(isDefined(self._id_0B67._id_131F)) {
    if(self._id_0B67._id_131F == 1) {
      self._id_0B67._id_131F = undefined;
      self._id_0B67._id_131E = undefined;
      return 1;
    } else if(self._id_0B67._id_131F == 2) {
      self._id_0B67._id_131F = 3;
      return 1;
    }
  }

  return 0;
}

_id_131B() {
  if(isDefined(self._id_0B67._id_131F) && self._id_0B67._id_131F == 3) {
    self._id_0B67._id_131F = undefined;
    self._id_0B67._id_131E = undefined;
  }
}

_id_12C3(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_2 = var_0 _id_131D(var_1);

  if(var_2) {
    var_0._id_0229 = 1;
    var_0.ignoreme = 1;
  }
}

_id_1253(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_1 = var_0 _id_131A();

  if(var_1) {
    var_0._id_0229 = 0;
    var_0.ignoreme = 0;
  }
}

set_time_between_expose_lost_enemy_override(var_0, var_1) {
  self.mintimebetweenpeekslostenemyoverride = var_0;
  self.maxtimebetweenpeekslostenemyoverride = var_1;
}

clear_time_between_expose_lost_enemy_override() {
  self.mintimebetweenpeekslostenemyoverride = undefined;
  self.maxtimebetweenpeekslostenemyoverride = undefined;
}

set_time_between_expose_override(var_0, var_1) {
  self.mintimebetweenpeeksoverride = var_0;
  self.maxtimebetweenpeeksoverride = var_1;
}

clear_time_between_expose_override() {
  self.mintimebetweenpeeksoverride = undefined;
  self.maxtimebetweenpeeksoverride = undefined;
}