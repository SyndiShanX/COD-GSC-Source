/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1796.gsc
*************************************************/

_id_16D3() {
  var_0 = spawnStruct();
  var_0._id_7C8C = "ammo_crate";
  var_0.weaponinfo = "iw8_ammo_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox_ammunition";
  var_0._id_0224 = &"COOP_CRAFTING/AMMO_CRATE_TAKE";
  var_0.streakname = "ammo_crate";
  var_0._id_E419 = "used_support_box";
  var_0._id_D968 = "compass_objpoint_deploy_friendly";
  var_0._id_75E9 = "cp_crate_icon_ammo";
  var_0._id_75F5 = 20;
  var_0._id_9371 = 90.0;
  var_0._id_FEF7 = 50;
  var_0._id_ABD3 = "ammo_crate_use";
  var_0._id_47E9 = "ammo_crate_use";
  var_0._id_4421 = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_ammunition_timeout.vfx");
  var_0._id_ABCD = ::_id_EB7F;
  var_0._id_3201 = ::_id_EB60;
  var_0._id_47EB = ::_id_6EC2;
  var_0._id_FEE7 = 1000;
  var_0.maxhealth = 100;
  var_0._id_9CB7 = 4;
  var_0._id_31BD = 0;
  var_0._id_15C1 = 1;
  var_0._id_42FD = "";
  var_0._id_7185 = ::_id_EB6C;
  var_0._id_AAAF = _id_071D::_id_EB79;
  var_0._id_47E7 = _id_071D::_id_EB67();
  level._id_298E["ammo_crate"] = var_0;
  level._id_47DD["ammo_crate"] = [];
}

_id_10DE2(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_EB97(var_0);
  }
}

_id_F7A0(var_0, var_1) {
  return 1;
}

_id_EB60(var_0) {
  return 1;
}

_id_EB6C(var_0) {
  var_1 = self gettagorigin("tag_accessory_left");
  var_2 = 400;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  var_4 = var_4 * 0.6;
  var_5 = vectornormalize(var_3 + var_4);
  var_6 = var_5 * var_2;
  var_7 = _func_0143("iw8_ammocrate_marker_zm", var_1, var_1 + var_6, self);
  self notify("grenade_fire", var_7);
}

_id_EB7F(var_0) {
  self endon("disconnect");

  if(_id_3184()) {
    _id_6EC2();
    return 1;
  } else {
    scripts\cp\utility::_id_7970("max_ammo", 1, 3);
    return 0;
  }

  return 1;
}

_id_EB97(var_0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::_id_10898("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == "cancel_deploy") {
    self switchtoweapon(self._id_8FC2);
  }

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != var_0.objweapon) {
      self notify("killstreak_finished_with_weapon_" + var_0._id_04FE);
      break;
    }

    waitframe();
  }
}

_id_EB6D() {
  var_0 = level._id_298E[self._id_2991];
}

_id_EB6E(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = level._id_298E[self._id_2991];
  var_1 notify("destroyed_equipment");
}

_id_EB78(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_7 = level._id_298E[self._id_2991];
  return var_6;
}

_id_EB8F(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = spawnStruct();
  thread _id_EB8E(var_0, var_2);
  thread _id_EB8E(var_1, var_2);
  var_2 waittill("returned", var_3, var_4);
  var_2 notify("die");
  var_5 = spawnStruct();
  var_5._id_A2B9 = var_3;
  var_5._id_AE3F = var_4;
  return var_5;
}

_id_EB8E(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("die");
  self waittill(var_0, var_2);
  var_1 notify("returned", var_0, var_2);
}

_id_3184() {
  var_0 = scripts\cp\utility::_id_6E34();
  var_1 = istrue(var_0._id_0216);
  var_2 = istrue(var_0._id_0245);

  if(var_1 || var_2) {
    if(_id_9C06(var_0)) {
      var_3 = _id_6345(var_0);

      if(isDefined(var_3)) {
        if(_id_9C06(var_3)) {
          return 0;
        }

        return 1;
      }

      return 0;
    }
  } else if(_id_9C06(var_0))
    return 0;

  return 1;
}

_id_6345(var_0) {
  var_1 = var_0.basename;
  var_2 = self getweaponslistprimaries();
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_5.basename == var_1 && var_5 != var_0) {
      var_3 = var_5;
      break;
    }
  }

  if(isDefined(var_3)) {
    return var_3;
  }
}

_id_9C06(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);

  if(istrue(var_0._id_0245)) {
    if(isDefined(var_0._id_04B7) && var_0._id_04B7 == "ubshtgn") {
      var_3 = 0;
    }
  }

  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2) {
    return 0;
  }

  return 1;
}

_id_6EC2() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(weapontype(var_2) == "riotshield") {
      continue;
    }
    if(weapontype(var_2) == "projectile") {
      continue;
    }
    if(isDefined(var_2.classname) && var_2.classname == "grenade") {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    if(_id_10D18(var_2)) {
      continue;
    }
    if(var_2._id_0241 == "altmode") {
      if(isDefined(var_2._id_04B7) && var_2._id_04B7 == "ubshtgn") {
        self setweaponammoclip(var_2, weaponclipsize(var_2));
        self setweaponammostock(var_2, 0);
      }

      continue;
    }

    self givemaxammo(var_2);
    self setweaponammoclip(var_2, 999, "left");
    self setweaponammoclip(var_2, 999, "right");
  }

  self playlocalsound("weap_ammo_pickup");
}

_id_10D18(var_0) {
  var_1 = var_0.basename;

  switch (var_1) {
    case "s4_mg_streak_mp":
    case "s4_mg_juniform_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_118E(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = weaponmaxammo(var_1);
    var_6 = var_0 getweaponammostock(var_1);
    var_7 = var_5 - var_6;
    var_8 = scripts\engine\utility::ter_op(var_7 >= var_3, var_6 + var_3, var_5);
    var_0 setweaponammostock(var_1, var_8);
  }

  var_9 = var_0 getweaponammoclip(var_1, var_2);
  var_10 = var_3 - var_9;
  var_11 = min(var_9 + var_10, var_3);
  var_0 setweaponammoclip(var_1, int(var_11), var_2);
}

_id_F0BC(var_0) {
  var_0 thread _id_10A2B();
  var_0 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::_id_D19E("crafted_autosentry", ::_id_6ED9, var_0);
}

_id_6ED9(var_0, var_1) {
  var_1 thread _id_10A2B();
  var_1 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::_id_D19E("crafted_autosentry", ::_id_6ED9, var_1);
}

_id_10A2B() {
  self endon("disconnect");
  self endon("death");
  self endon("remove_sentry");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 4");

  for(;;) {
    self waittill("pullout_sentry");

    if(istrue(self._id_87A7)) {
      continue;
    }
    if(istrue(self._id_9500)) {
      continue;
    }
    if(isDefined(self._id_1529) && self._id_1529 == 0) {
      continue;
    }
    if(scripts\cp\utility::_id_8708()) {
      break;
    }
  }
}