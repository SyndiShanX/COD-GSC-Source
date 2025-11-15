/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_target_marker.gsc
*****************************************************/

init() {}

_meth_819B(param_00, param_01) {
  scripts\engine\utility::allow_usability(0);
  self setscriptablepartstate("killstreak", "visor_active", 0);
  scripts\mp\utility::func_1254();
  scripts\mp\utility::func_1C47(0);
  var_02 = undefined;
  if(param_00.streakname == "dronedrop") {
    var_02 = "deploy_dronepackage_mp";
  } else if(param_00.streakname == "remote_c8") {
    var_02 = "deploy_rc8_mp";
  } else {
    var_02 = "deploy_warden_mp";
  }

  var_03 = undefined;
  thread func_13A47(var_02);
  thread func_13A2F(var_02);
  thread watchforphaseshiftuse(var_02);
  thread watchforempapply(var_02);
  if(!isai(self)) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 4");
    if(!level.console) {
      self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
    }
  }

  for(;;) {
    var_03 = func_13808("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end");
    if(var_03.string == "equip_deploy_failed") {
      continue;
    } else {
      if(var_03.string == "equip_deploy_succeeded") {
        if(isDefined(param_01)) {
          if(!self[[param_01]]()) {
            continue;
          } else {
            break;
          }
        } else {
          break;
        }

        continue;
      }

      break;
    }
  }

  if(isDefined(var_03.location) && isDefined(var_03.angles)) {
    var_03.var_1349C = spawn("script_model", var_03.location);
    var_03.var_1349C setModel("ks_marker_mp");
    var_03.var_1349C setotherent(self);
    var_03.var_1349C setscriptablepartstate("target", "placed", 0);
    var_03.var_1349C _meth_85C8(1);
  }

  if(scripts\mp\utility::isreallyalive(self)) {
    self notify("killstreak_finished_with_weapon_" + var_02);
  }

  self setscriptablepartstate("killstreak", "neutral", 0);
  scripts\mp\utility::func_11DB();
  scripts\mp\utility::func_1C47(1);
  thread scripts\engine\utility::delaythread(0.05, ::scripts\engine\utility::allow_usability, 1);
  return var_03;
}

func_13A47(param_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + param_00);
  for(;;) {
    if(self getcurrentweapon() != param_00) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_13A2F(param_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + param_00);
  var_01 = self getweaponammoclip(param_00);
  for(;;) {
    self waittill("weapon_fired", var_02);
    if(var_02 == param_00) {
      self setweaponammoclip(var_02, var_01);
    }
  }
}

watchforphaseshiftuse(param_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + param_00);
  for(;;) {
    if(self isinphase()) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watchforempapply(param_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + param_00);
  self waittill("apply_player_emp");
  self notify("equip_deploy_end");
}

func_13808(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  if(isDefined(param_00)) {
    childthread func_137F9(param_00, var_03);
  }

  if(isDefined(param_01)) {
    childthread func_137F9(param_01, var_03);
  }

  if(isDefined(param_02)) {
    childthread func_137F9(param_02, var_03);
  }

  childthread func_137F9("death", var_03);
  var_03 waittill("returned", var_04, var_05, var_06, var_07);
  var_03 notify("die");
  var_08 = spawnStruct();
  var_08.var_394 = var_04;
  var_08.location = var_05;
  var_08.angles = var_06;
  var_08.string = var_07;
  return var_08;
}

func_137F9(param_00, param_01) {
  if(param_00 != "death") {
    self endon("death");
  }

  param_01 endon("die");
  self waittill(param_00, var_02, var_03, var_04);
  param_01 notify("returned", var_02, var_03, var_04, param_00);
}