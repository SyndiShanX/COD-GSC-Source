/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\inventory\cp_target_marker.gsc
*****************************************************/

function init() {
  scripts\mp\playeractions::registeractionset("target_marker", ["usability", "gesture"]);
}

function gettargetmarker(var_0, var_1) {
  self endon("last_stand");
  scripts\mp\playeractions::allowactionset("target_marker", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var_2 = asmdevgetallstates(var_0.weaponname);
  var_3 = undefined;
  thread watchforinvalidweapon(var_2, var_0);
  thread watchforlaststand(var_0);
  thread watchforammouse(var_2, var_0);
  thread watchforempapply(var_2, var_0);

  if(!istrue(var_1)) {
    if(!isai(self)) {
      self notifyonplayercommand("equip_deploy_end", "+weapnext");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

      if(!self isconsoleplayer()) {
        self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
      }
    }
  }

  for(;;) {
    var_3 = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end");

    if(var_3.string == "equip_deploy_end") {
      if(!istrue(var_1)) {
        break;
      } else {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(var_3.string == "equip_deploy_failed") {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    break;
  }

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_3.visual = spawn("script_model", var_3.location + var_3.fxoffset);
    var_3.visual.angles = var_3.angles;

    if(var_0.streakname == "toma_strike") {
      var_3.visual setModel("ks_toma_strike_marker_mp");
    } else if(var_0.streakname == "manual_turret" || var_0.streakname == "sentry_gun") {
      var_3.visual setModel("ks_manual_turret_marker_mp");
    } else {
      var_3.visual setModel("ks_marker_mp");
    }

    var_3.visual setotherent(self);
    var_3.visual setscriptablepartstate("target", "placed", 0);
  }

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
  }

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);
  return var_3;
}

function watchforinvalidweapon(var_0, var_1) {
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

function watchforammouse(var_0, var_1) {
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

function watchforlaststand(var_0) {
  self endon("disconnect");
  var_0 endon("killstreak_finished_with_deploy_weapon");
  self waittill("last_stand");
  scripts\mp\utility\entity::_disableequipdeployvfx();
  self.bgivensentry = 0;
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return;
  }
}

function watchforempapply(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("killstreak_finished_with_deploy_weapon");
  self waittill("apply_emp_player");
  self notify("equip_deploy_end");
}

function waittill_succeed_fail_end(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_3);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_3);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_3);
  }

  GscBinSkip4(0x35, "death", var_3);
}

function waittill_return(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5);
  var_1 notify("returned", var_2, var_3, var_4, var_5, var_0);
}