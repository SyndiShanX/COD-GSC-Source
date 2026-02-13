/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2708.gsc
*************************************************/

_id_6ABA(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    if(istrue(level._id_83A9)) {
      if(isDefined(var_3._id_039B) && var_3._id_039B == "interactive") {
        return var_3;
      }
    } else if(!isDefined(var_3._id_039B) || var_3._id_039B != "interactive")
      return var_3;
  }
}

_id_B616(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  if(var_1 _meth_81CC()) {
    var_1 unlink();
  }
}

_id_B47E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  if(var_1 _meth_81CC()) {
    var_1 _meth_820B(0, 0, 0, 45, 45, 45, 45);
  }
}

_id_B479(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8577("80_instant");
}

_id_B47B(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8577("zombiearcade");
}

_id_B47C(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8577("default_2seconds");
}

_id_B53F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  if(var_1 _meth_81CC()) {
    var_1 _meth_820B(1, 0.25, 0.25, 0, 0, 0, 0);
  }
}

_id_B540(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  if(var_1 _meth_81CC()) {
    var_1 _meth_820B(2, 0.5, 0.5, 0, 0, 0, 0);
  }
}

_id_B541(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  if(var_1 _meth_81CC()) {
    var_1 _meth_820B(0, 0, 0, 0, 0, 0, 0);
  }
}

_id_C996(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_FD27(undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1);
}

_id_2FEC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_FD27(0.06, 0.075, 2, var_1.origin, 8000, "mig_rumble", 0.05, 0.1);
}

_id_2FEF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_FD27(0.09, 0.115, 2, var_1.origin, 8000, undefined, 0.15, 0.5);
}

_id_2FEE(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_FD27(0.065, 0.09, 0.5, var_1.origin, 8000, undefined, 0.15, 0.5);
}

_id_2FED(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 notify("stop_cam_shake");
}

_id_FD27(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(level._id_83A9) && istrue(self._id_83A5)) {
    return;
  }
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  level endon("prematch_over");
  level endon("infil_done");
  self endon("death_or_disconnect");

  while(isDefined(self)) {
    if(isDefined(var_0) && isDefined(var_1)) {
      self earthquakeforplayer(randomfloatrange(var_0, var_1), var_2, var_3, var_4);
    }

    if(isDefined(var_5)) {
      self _meth_827A(var_5, self.origin);
    }

    wait(randomfloatrange(var_6, var_7));
  }
}

_id_78E2() {
  if(!isDefined(self._id_0F7F)) {
    return;
  }
  foreach(var_1 in self._id_0F7F) {
    var_1 hide();
  }
}

_id_DC7E() {
  if(!isDefined(self._id_0F7F)) {
    return;
  }
  foreach(var_1 in self._id_0F7F) {
    var_1 show();
  }
}

_id_D4C2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8638("player_heli_ride");
}

_id_D4CF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8638("iw8_playermotion_mp");
}

_id_D4C1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8638("disabled");
}

_id_D186(var_0) {
  self setclientomnvar("handheld_camera_rotation_move_mod_override", var_0);
  self setclientomnvar("handheld_camera_rotation_view_mod_override", var_0);
  self setclientomnvar("handheld_camera_translation_move_mod_override", var_0);
  self setclientomnvar("handheld_camera_translation_view_mod_override", var_0);
}

_id_D187(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  var_3 = gettime();
  var_2 = var_2 * 1000;
  var_4 = int(var_3 + var_2);
  var_5 = abs(var_0 - var_1);

  for(;;) {
    var_3 = gettime();
    var_6 = clamp(1.0 - (var_4 - var_3) / var_2, 0.0, 1.0);
    var_7 = scripts\engine\utility::ter_op(var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6);
    _id_D186(var_7);

    if(var_6 == 1.0) {
      break;
    }

    waitframe();
  }
}

_id_D4C8(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _id_D186(1.0);
}

_id_D4C3(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(0.0, 1.0, 1.0);
}

_id_D4C4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(0.0, 1.0, 2.0);
}

_id_D4C5(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(0.0, 1.0, 3.0);
}

_id_D4C6(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(0.0, 1.0, 4.0);
}

_id_D4C7(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(0.0, 1.0, 5.0);
}

_id_D4CE(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _id_D186(0.0);
}

_id_D4C9(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(1.0, 0.0, 1.0);
}

_id_D4CA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(1.0, 0.0, 2.0);
}

_id_D4CB(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(1.0, 0.0, 3.0);
}

_id_D4CC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(1.0, 0.0, 4.0);
}

_id_D4CD(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 thread _id_D187(1.0, 0.0, 5.0);
}

_id_B43E(var_0) {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_1 _meth_8249();
}

_id_6A7F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  } else {
    var_1 = var_0;
  }

  var_2 = var_1.origin[2];
  var_3 = scripts\engine\trace::_id_3F70(1);
  var_4 = var_1.origin + (0, 0, 12);
  var_5 = var_1.origin - (0, 0, 24);
  var_6 = scripts\engine\trace::_id_B607(var_4, var_5, var_1.angles, [var_1, var_1._id_7E24._id_9515], var_3)["position"];
  var_7 = var_6[2];
  var_1._id_7E6C = var_7 - var_2;
}

_id_3B0B() {
  level endon("prematch_over");
  self endon("death_or_disconnect");
  var_0 = 0.0;
  self._id_B029 unlink();

  while(isDefined(self._id_B029)) {
    _id_6A7F(self._id_B5A4);
    var_1 = (self._id_B029.origin[0], self._id_B029.origin[1], self._id_B029.origin[2] + self._id_7E6C);

    if(abs(var_0 - self._id_7E6C) > 0.01) {
      var_0 = self._id_7E6C;
      self._id_B029 moveto(var_1, 0.25, 0.05, 0.2);
    }

    waitframe();
  }
}

#using_animtree("script_model");

_id_7E52(var_0, var_1, var_2) {
  self._id_18AF = var_0;

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  self _meth_8282(var_1);

  if(!getdvarint("#x35787e796ac190df6", 1)) {
    var_3 = spawn("script_model", var_1, 0, 0, self);
    var_3 setModel("tag_player");
  } else
    var_3 = spawn("script_arms", var_1, 0, 0, self);

  var_3.angles = var_2;
  var_3.player = self;
  self._id_B5A4 = var_3;
  self._id_B5A4 hide(1);
  self._id_B5A4._id_18AF = var_0;
  self._id_B5A4 useanimtree(#animtree);
  self._id_B5A4._id_FC55 = 1;
  self._id_B5A4._id_10D19 = ::_id_74B4;
  self._id_B5A4._id_3717 = ::_id_7427;
  self._id_B5A4._id_4C9C = ::_id_7436;
  self playerlinktodelta(self._id_B5A4, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread _id_EDC3();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_7436(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  switch (var_0) {
    case "blima_interior":
      self.player _meth_865D();

      switch (self._id_18AF) {
        case "slot_0":
          self.player _meth_8660(1.8, 40, 20, 20);
          break;
        case "slot_1":
          self.player _meth_8660(1.8, 60, 20, 20);
          break;
        case "slot_2":
          self.player _meth_8660(1.9, 50, 20, 20);
          break;
      }

      break;
    case "blima_exit":
      self.player _meth_865D();
      self.player _meth_8660(2.8, 500, 4, 4);
      break;
    case "umike_interior":
      self.player _meth_865D();

      switch (self._id_18AF) {
        case "slot_0":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
        case "slot_1":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
        case "slot_2":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
        case "slot_3":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
        case "slot_4":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
        case "slot_5":
          self.player _meth_8660(2.4, 50, 20, 20);
          break;
      }

      break;
    case "umike_exit":
      self.player _meth_865D();
      self.player _meth_8660(2.8, 500, 4, 4);
      break;
    case "van_interior":
      self.player _meth_865D();

      switch (self._id_18AF) {
        case "slot_0":
          self.player _meth_8660(2.1, 40, 20, 20);
          break;
        case "slot_1":
          self.player _meth_8660(2.1, 40, 20, 20);
          break;
        case "slot_2":
          self.player _meth_8660(2.1, 40, 20, 20);
          break;
        case "slot_3":
          self.player _meth_8660(2.1, 40, 20, 20);
          break;
        case "slot_4":
          self.player _meth_8660(2.3, 60, 20, 20);
          break;
        case "slot_5":
          self.player _meth_8660(2.3, 60, 20, 20);
          break;
      }

      break;
    case "van_exit":
      self.player _meth_865D();
      self.player _meth_8660(2.8, 500, 4, 4);
      break;
  }
}

_id_7427(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  var_1 = _func_00D6(var_0, 0, 4);

  if(var_1 == "set_") {
    var_2 = _func_00D6(var_0, 4);
    self.player _meth_8638(var_2);
    return;
  }

  switch (var_0) {
    case "max_instant":
      _id_D4C8(self);
      break;
    case "max_1":
      _id_D4C3(self);
      break;
    case "max_2":
      _id_D4C4(self);
      break;
    case "max_3":
      _id_D4C5(self);
      break;
    case "max_4":
      _id_D4C6(self);
      break;
    case "max_5":
      _id_D4C7(self);
      break;
    case "min_instant":
      _id_D4CE(self);
      break;
    case "min_1":
      _id_D4C9(self);
      break;
    case "min_2":
      _id_D4CA(self);
      break;
    case "min_3":
      _id_D4CB(self);
      break;
    case "min_4":
      _id_D4CC(self);
      break;
    case "min_5":
      _id_D4CD(self);
      break;
  }
}

_id_74B4(var_0) {
  if(!isDefined(self) || !isDefined(self.player)) {
    return;
  }
  switch (var_0) {
    case "drop":
      self.player _meth_84AC("normal");
      self.player scripts\engine\utility::_id_5473("swapLoadout_blocked");
      self.player scripts\engine\utility::_id_5473("swapLoadout_pending");
      self.player scripts\engine\utility::_id_5473("swapLoadout_complete");
      self.player scripts\engine\utility::_id_5474("swapLoadout_blocked");
      self.player thread _id_389F();

      if(!isai(self.player)) {
        self.player _id_6FA0();
      }

      if(istrue(self._id_FC55)) {
        self _meth_83CA(self.player);
      }

      break;
    case "raise":
      if(isDefined(self.player._id_7E81) && self.player hasweapon(self.player._id_7E81)) {
        self.player scripts\cp_mp\utility\inventory_utility::_takeweapon(self.player._id_7E81);
      }

      self.player._id_7E82 = 1;

      if(self.player scripts\engine\utility::_id_5472("swapLoadout_blocked") && self.player scripts\engine\utility::_id_546E("swapLoadout_blocked")) {
        self.player scripts\engine\utility::_id_5470("swapLoadout_blocked");
      }

      self.player _meth_84AC("normal");

      if(!istrue(self._id_FC55)) {
        self.player _meth_8656();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "loadout_finalizeWeapons")) {
        self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "loadout_finalizeWeapons")]]();
      }

      if(!isai(self.player)) {
        self.player _id_EDC3();
      }

      if(istrue(self._id_FC55) && self.player _meth_81CC()) {
        self.player _meth_8264(0);
      }

      break;
    case "safe":
      self.player _meth_84AC("safe", "iw8_ges_demeanor_safe");
      break;
    case "normal":
      self.player _meth_84AC("normal");
      break;
    case "free":
      self.player scripts\common\utility::_id_153E(1);
      self.player scripts\common\utility::_id_151F(1);
      self.player scripts\common\utility::_id_1575(1);
      break;
    case "hold":
      self.player scripts\common\utility::_id_153E(0);
      self.player scripts\common\utility::_id_151F(0);
      self.player scripts\common\utility::_id_1575(0);
      break;
  }
}

_id_389F() {
  self endon("disconnect");
  scripts\engine\utility::_id_10888(self, "death", level, "prematch_over");
  scripts\engine\utility::_id_5470("swapLoadout_blocked", 1);
  scripts\engine\utility::_id_5470("swapLoadout_pending", 1);
  scripts\engine\utility::_id_5470("swapLoadout_complete", 1);
}

_id_EDC3() {
  self endon("death_or_disconnect");

  if(!isDefined(self._id_72C3) || !self hasweapon(self._id_72C3)) {
    return;
  }
  if(scripts\engine\utility::_id_5472("swapLoadout_pending") && scripts\engine\utility::_id_546E("swapLoadout_pending")) {
    scripts\engine\utility::_id_5476("swapLoadout_complete");
  }

  if(!scripts\common\utility::_id_86AC()) {
    scripts\common\utility::_id_157A(1);
  }

  while(self hasweapon(self._id_72C3)) {
    if(!scripts\cp_mp\utility\inventory_utility::_id_87E0(self._id_72C3)) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C(self._id_72C3);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_72C3);
      scripts\cp_mp\utility\inventory_utility::_id_5ED6();
    }

    waitframe();
  }

  self._id_72C3 = undefined;
  scripts\common\utility::_id_157A(0);
}

_id_6FA0() {
  self endon("death_or_disconnect");

  if(isDefined(self._id_72C3)) {
    return;
  }
  var_0 = makeweapon("s4_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::_id_86AC()) {
    scripts\common\utility::_id_157A(1);
  }

  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self._id_72C3 = var_0;
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_id_5ED6();
  }

  scripts\common\utility::_id_157A(0);
  return var_1;
}