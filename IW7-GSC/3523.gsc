/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3523.gsc
***************************************/

init() {}

_meth_819B(var_00, var_01) {
  scripts\engine\utility::allow_usability(0);
  self setscriptablepartstate("killstreak", "visor_active", 0);
  scripts\mp\utility\game::func_1254();
  scripts\mp\utility\game::func_1C47(0);
  var_02 = undefined;

  if(var_0.streakname == "dronedrop")
    var_02 = "deploy_dronepackage_mp";
  else if(var_0.streakname == "remote_c8")
    var_02 = "deploy_rc8_mp";
  else
    var_02 = "deploy_warden_mp";

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

    if(var_3.string == "equip_deploy_failed")
      continue;
    else if(var_3.string == "equip_deploy_succeeded") {
      if(isDefined(var_01)) {
        if(!self[[var_01]]())
          continue;
        else
          break;
      } else
        break;
    } else
      break;
  }

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_3.func_1349C = spawn("script_model", var_3.location);
    var_3.func_1349C setModel("ks_marker_mp");
    var_3.func_1349C setotherent(self);
    var_3.func_1349C setscriptablepartstate("target", "placed", 0);
    var_3.func_1349C _meth_85C8(1);
  }

  if(scripts\mp\utility\game::isreallyalive(self))
    self notify("killstreak_finished_with_weapon_" + var_02);

  self setscriptablepartstate("killstreak", "neutral", 0);
  scripts\mp\utility\game::func_11DB();
  scripts\mp\utility\game::func_1C47(1);
  thread scripts\engine\utility::delaythread(0.05, scripts\engine\utility::allow_usability, 1);
  return var_03;
}

func_13A47(var_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_00);

  for(;;) {
    if(self getcurrentweapon() != var_00) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_13A2F(var_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_00);
  var_01 = self getweaponammoclip(var_00);

  for(;;) {
    self waittill("weapon_fired", var_02);

    if(var_02 == var_00)
      self setweaponammoclip(var_02, var_01);
  }
}

watchforphaseshiftuse(var_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_00);

  for(;;) {
    if(self isinphase()) {
      self notify("equip_deploy_end");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watchforempapply(var_00) {
  self endon("disconnect");
  self endon("killstreak_finished_with_weapon_" + var_00);
  self waittill("apply_player_emp");
  self notify("equip_deploy_end");
}

func_13808(var_00, var_01, var_02) {
  var_03 = spawnStruct();

  if(isDefined(var_00))
    childthread func_137F9(var_00, var_03);

  if(isDefined(var_01))
    childthread func_137F9(var_01, var_03);

  if(isDefined(var_02))
    childthread func_137F9(var_02, var_03);

  childthread func_137F9("death", var_03);
  var_03 waittill("returned", var_04, var_05, var_06, var_07);
  var_03 notify("die");
  var_08 = spawnStruct();
  var_8.weapon = var_04;
  var_8.location = var_05;
  var_8.angles = var_06;
  var_8.string = var_07;
  return var_08;
}

func_137F9(var_00, var_01) {
  if(var_00 != "death")
    self endon("death");

  var_01 endon("die");
  self waittill(var_00, var_02, var_03, var_04);
  var_01 notify("returned", var_02, var_03, var_04, var_00);
}