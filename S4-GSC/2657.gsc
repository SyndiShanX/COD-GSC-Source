/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2657.gsc
*************************************************/

init() {
  scripts\mp\playeractions::_id_C23B("target_marker", ["usability", "gesture"]);
}

_id_6DBE(var_0, var_1) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\playeractions::_id_1596("target_marker", 0);
  scripts\mp\utility\entity::_id_0BD7();
  var_2 = makeweaponfromstring(var_0._id_04FE);
  var_3 = undefined;
  thread _id_10B19(var_2, var_0);
  thread _id_10AF1(var_2, var_0);
  thread _id_10B0C(var_2, var_0);

  if(!istrue(var_1)) {
    if(!isai(self)) {
      self notifyonplayercommand("equip_deploy_end", "+weapnext");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

      if(!self _meth_8684()) {
        self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
      }
    }
  }

  for(;;) {
    var_3 = _id_1092F("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start");

    if(var_3._id_EA52 == "equip_deploy_cancel") {
      break;
    } else {
      if(var_3._id_EA52 == "equip_deploy_end") {
        if(!istrue(var_1)) {
          break;
        } else
          scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_SWITCH");

        continue;
      }

      if(var_3._id_EA52 == "equip_deploy_failed") {
        scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_PLACED");
        continue;
      }

      if(isDefined(var_3) && var_3._id_EA52 == "equip_deploy_succeeded") {
        if(_id_8984(var_3)) {
          scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_PLACED_PLAYER");
          continue;
        } else if(!self isonground() || self isonladder()) {
          scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_PLACED_AIR");
          continue;
        }
      }

      break;
    }
  }

  if(isDefined(var_3._id_96CF) && isDefined(var_3.angles)) {
    var_3._id_04ED = spawn("script_model", var_3._id_96CF + var_3._id_6097);
    var_3._id_04ED.angles = var_3.angles;

    if(var_0.streakname == "toma_strike") {
      var_3._id_04ED setModel("ks_toma_strike_marker_mp");
    }

    if(isDefined(var_3._id_04ED.model) && var_3._id_04ED.model != "") {
      var_3._id_04ED setotherent(self);
      var_3._id_04ED setscriptablepartstate("target", "placed", 0);
    }
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
  }

  scripts\mp\utility\entity::_id_0BC1();
  thread scripts\engine\utility::delaythread(0.05, scripts\mp\playeractions::_id_1596, "target_marker", 1);
  return var_3;
}

_id_8984(var_0) {
  var_1 = 0;
  var_2 = var_0._id_96CF;

  if(!scripts\engine\trace::_id_E40D(var_2 + (0, 0, 100), var_2, 20, undefined, scripts\engine\trace::_id_3EE0())) {
    var_1 = 1;
  }

  return var_1;
}

_id_10B19(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("killstreak_finished_with_deploy_weapon");

  for(;;) {
    if(self getcurrentweapon() != var_0) {
      self notify("equip_deploy_end");
      break;
    }

    waitframe();
  }
}

_id_10AF1(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("killstreak_finished_with_deploy_weapon");
  var_2 = self getweaponammoclip(var_0);

  for(;;) {
    self waittill("weapon_fired", var_3);

    if(var_3 == var_0) {
      self setweaponammoclip(var_3, var_2);
    }
  }
}

_id_10B0C(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("killstreak_finished_with_deploy_weapon");
  self waittill("emp_applied");
  self notify("equip_deploy_end");
}

_id_1092F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_1091E(var_0, var_5);
  }

  if(isDefined(var_1)) {
    childthread _id_1091E(var_1, var_5);
  }

  if(isDefined(var_2)) {
    childthread _id_1091E(var_2, var_5);
  }

  if(isDefined(var_3)) {
    childthread _id_1091E(var_3, var_5);
  }

  if(isDefined(var_4)) {
    childthread _id_1091E(var_4, var_5);
  }

  childthread _id_1091E("death", var_5);
  var_5 waittill("returned", var_6, var_7, var_8, var_9, var_10);
  var_5 notify("die");
  var_11 = spawnStruct();
  var_11._id_04F6 = var_7;
  var_11._id_96CF = var_8;
  var_11.angles = var_9;
  var_11._id_EA52 = var_10;
  var_11._id_6097 = var_6;
  return var_11;
}

_id_1091E(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5);
  var_1 notify("returned", var_2, var_3, var_4, var_5, var_0);
}