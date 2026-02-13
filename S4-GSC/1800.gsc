/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1800.gsc
*************************************************/

_id_1B2B() {
  var_0 = spawnStruct();
  var_0._id_7C8C = "armor";
  var_0.weaponinfo = "iw8_armor_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox_armor";
  var_0._id_0224 = &"COOP_CRAFTING/ARMOR_TAKE";
  var_0.streakname = "armor";
  var_0._id_E419 = "used_support_box";
  var_0._id_D968 = "compass_objpoint_deploy_friendly";
  var_0._id_75E9 = "cp_crate_icon_armor";
  var_0._id_75F5 = 20;
  var_0._id_9371 = 90.0;
  var_0._id_FEF7 = 50;
  var_0._id_ABD3 = "ammo_crate_use";
  var_0._id_47E9 = "ammo_crate_use";
  var_0._id_4421 = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_armor_timeout.vfx");
  var_0._id_ABCD = ::_id_1B49;
  var_0._id_3201 = ::_id_1B48;
  var_0._id_47EB = ::_id_1B49;
  var_0._id_FEE7 = 1000;
  var_0.maxhealth = 100;
  var_0._id_9CB7 = 4;
  var_0._id_31BD = 0;
  var_0._id_15C1 = 1;
  var_0._id_42FD = "";
  var_0._id_7185 = ::_id_EB6C;
  var_0._id_AAAF = _id_071D::_id_EB79;
  var_0._id_47E7 = _id_071D::_id_EB67();
  level._id_298E["armor"] = var_0;
  level._id_47DD["armor"] = [];
}

_id_10DE2(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_EB97(var_0);
  }
}

_id_F7A0(var_0, var_1) {
  return 1;
}

_id_1B48(var_0) {
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

_id_1B49(var_0) {
  self endon("disconnect");

  if(_id_0707::_id_B4C7(self)) {
    scripts\cp\utility::_id_7970("max_armor", 1, 3);
    return 0;
  }

  _id_0707::_id_6F80(self, 100, 1);
  self playlocalsound("weap_ammo_pickup");
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
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2) {
    return 1;
  } else {
    return 0;
  }
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
    if(scripts\cp\cp_weapon::_id_8607(var_2)) {
      continue;
    }
    var_3 = weaponclipsize(var_2);
    self givemaxammo(var_2);
  }

  self playlocalsound("weap_ammo_pickup");
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