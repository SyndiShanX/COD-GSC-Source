/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_target_marker.gsc
*****************************************************/

init() {}

func_819B(var_0, var_1) {
  scripts\engine\utility::allow_usability(0);
  self setscriptablepartstate("killstreak", "visor_active", 0);
  scripts\mp\utility::func_1254();
  scripts\mp\utility::func_1C47(0);
  var_2 = undefined;
  if(var_0.streakname == "dronedrop") {
    var_2 = "deploy_dronepackage_mp";
  } else if(var_0.streakname == "remote_c8") {
    var_2 = "deploy_rc8_mp";
  } else {
    var_2 = "deploy_warden_mp";
  }

  var_3 = undefined;
  thread func_13A47(var_2);
  thread func_13A2F(var_2);
  thread watchforphaseshiftuse(var_2);
  thread watchforempapply(var_2);
  if(!isai(self)) {
    self notifyonplayercommand("equip_deploy_end", "+actionslot 4");
    if(!level.console) {
      self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
    }
  }

  for(;;) {
    var_3 = func_13808("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end");
    if(var_3.string == "equip_deploy_failed") {
      continue;
    } else {
      if(var_3.string == "equip_deploy_succeeded") {
        if(isDefined(var_1)) {
          if(!self[[var_1]]()) {
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

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_3.var_1349C = spawn("script_model", var_3.location);
    var_3.var_1349C setModel("ks_marker_mp");
    var_3.var_1349C setotherent(self);
    var_3.var_1349C setscriptablepartstate("target", "placed", 0);
    var_3.var_1349C func_85C8(1);
  }

  if(scripts\mp\utility::isreallyalive(self)) {
    self notify("killstreak_finished_with_weapon_" + var_2);
  }

  self setscriptablepartstate("killstreak", "neutral", 0);
  scripts\mp\utility::func_11DB();
  scripts\mp\utility::func_1C47(1);
  thread scripts\engine\utility::delaythread(0.05, ::scripts\engine\utility::allow_usability, 1);
  return var_3;
}

func_13A47(var_0) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_0);
  for(;;) {
    if(self getcurrentweapon() != var_0) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_13A2F(var_0) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_0);
  var_1 = self getweaponammoclip(var_0);
  for(;;) {
    self waittill("weapon_fired", var_2);
    if(var_2 == var_0) {
      self setweaponammoclip(var_2, var_1);
    }
  }
}

watchforphaseshiftuse(var_0) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_0);
  for(;;) {
    if(self isinphase()) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watchforempapply(var_0) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_0);
  self waittill("apply_player_emp");
  self notify("equip_deploy_end");
}

func_13808(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  if(isDefined(var_0)) {
    childthread func_137F9(var_0, var_3);
  }

  if(isDefined(var_1)) {
    childthread func_137F9(var_1, var_3);
  }

  if(isDefined(var_2)) {
    childthread func_137F9(var_2, var_3);
  }

  childthread func_137F9("death", var_3);
  var_3 waittill("returned", var_4, var_5, var_6, var_7);
  var_3 notify("die");
  var_8 = spawnStruct();
  var_8.var_394 = var_4;
  var_8.location = var_5;
  var_8.angles = var_6;
  var_8.string = var_7;
  return var_8;
}

func_137F9(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4);
  var_1 notify("returned", var_2, var_3, var_4, var_0);
}