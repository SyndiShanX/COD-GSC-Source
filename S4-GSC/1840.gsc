/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1840.gsc
*************************************************/

_id_7140() {
  var_0 = spawnStruct();
  var_0._id_7C8C = "grenade_crate";
  var_0.weaponinfo = "iw8_health_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox_explosives";
  var_0._id_0224 = &"COOP_CRAFTING/GRENADE_TAKE";
  var_0.streakname = "grenade_crate";
  var_0._id_E419 = "used_support_box";
  var_0._id_D968 = "compass_objpoint_deploy_friendly";
  var_0._id_75E9 = "cp_crate_icon_lethalrefill";
  var_0._id_75F5 = 20;
  var_0._id_9371 = 90.0;
  var_0._id_FEF7 = 50;
  var_0._id_ABD3 = "ammo_crate_use";
  var_0._id_47E9 = "ammo_crate_use";
  var_0._id_4421 = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx");
  var_0._id_ABCD = ::_id_7639;
  var_0._id_3201 = ::_id_7637;
  var_0._id_47EB = ::_id_7639;
  var_0._id_FEE7 = 1000;
  var_0.maxhealth = 100;
  var_0._id_9CB7 = 4;
  var_0._id_31BD = 0;
  var_0._id_15C1 = 1;
  var_0._id_42FD = "";
  var_0._id_7185 = ::_id_7638;
  var_0._id_AAAF = _id_071D::_id_EB79;
  var_0._id_47E7 = _id_071D::_id_EB67();
  level._id_298E["grenade_crate"] = var_0;
  level._id_47DD["grenade_crate"] = [];
}

_id_10DE2(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_EB97(var_0);
  }
}

_id_F7A0(var_0, var_1) {
  return 1;
}

_id_7637(var_0) {
  return 1;
}

_id_7638(var_0) {
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

_id_7639(var_0) {
  self endon("disconnect");
  var_1 = 1;
  var_2 = 1;
  var_3 = self getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(weapontype(var_5) == "projectile") {
      if(var_5.basename == "iw8_la_mike32_mp") {
        if(self._id_700E == "thermite") {
          continue;
        }
      }

      if(!_id_9C2D(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self givemaxammo(var_5);
      }
    }

    if(var_5._id_0241 == "altmode" && isDefined(var_5._id_04B7) && var_5._id_04B7 == "ubshtgn") {
      if(!_id_9C2D(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self setweaponammostock(var_5, 0);
      }
    }
  }

  foreach(var_8 in self._id_BADE) {
    if(var_8._id_3411 < var_8._id_9C5C) {
      var_1 = 0;
    }
  }

  if(var_1 && var_2) {
    scripts\cp\utility::_id_7970("max_grenades", 1, 3);
    return 0;
  }

  thread _id_C18E(self);
  return 1;
}

_id_9C2D(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  var_4 = weaponmaxammo(var_0);

  if(var_2 < var_4 || var_1 < var_3) {
    return 0;
  }

  return 1;
}

_id_C18E(var_0) {
  var_0 notify("stop_restock_recharge");

  foreach(var_3, var_2 in var_0._id_BADE) {
    var_0 notify("scavenged_ammo", var_2._id_10DE9);
    var_0 playlocalsound("weap_ammo_pickup");
    waitframe();
  }
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