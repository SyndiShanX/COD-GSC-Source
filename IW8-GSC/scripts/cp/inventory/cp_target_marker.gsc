/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\inventory\cp_target_marker.gsc
*****************************************************/

function init() {
  scripts\mp\playeractions::registeractionset("target_marker", ["usability", "gesture"]);
}

function gettargetmarker(var0, var1) {
  self endon("last_stand");
  scripts\mp\playeractions::allowactionset("target_marker", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var2 = asmdevgetallstates(var0.weaponname);
  var3 = undefined;
  thread watchforinvalidweapon(var2, var0);
  thread watchforlaststand(var0);
  thread watchforammouse(var2, var0);
  thread watchforempapply(var2, var0);

  if(!istrue(var1)) {
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
    var3 = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end");

    if(var3.string == "equip_deploy_end") {
      if(!istrue(var1)) {
        break;
      } else {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(var3.string == "equip_deploy_failed") {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    break;
  }

  if(isDefined(var3.location) && isDefined(var3.angles)) {
    var3.visual = spawn("script_model", var3.location + var3.fxoffset);
    var3.visual.angles = var3.angles;

    if(var0.streakname == "toma_strike") {
      var3.visual setModel("ks_toma_strike_marker_mp");
    } else if(var0.streakname == "manual_turret" || var0.streakname == "sentry_gun") {
      var3.visual setModel("ks_manual_turret_marker_mp");
    } else {
      var3.visual setModel("ks_marker_mp");
    }

    var3.visual setotherent(self);
    var3.visual setscriptablepartstate("target", "placed", 0);
  }

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 notify("killstreak_finished_with_deploy_weapon");
  }

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);
  return var3;
}

function watchforinvalidweapon(var0, var1) {
  self endon("disconnect");
  var1 endon("killstreak_finished_with_deploy_weapon");

  for(;;) {
    if(self getcurrentweapon() != var0) {
      self notify("equip_deploy_end");
      break;
    }

    waitframe();
  }
}

function watchforammouse(var0, var1) {
  self endon("disconnect");
  var1 endon("killstreak_finished_with_deploy_weapon");
  var2 = self getweaponammoclip(var0);

  for(;;) {
    self waittill("weapon_fired", var3);

    if(var3 == var0) {
      self setweaponammoclip(var3, var2);
    }
  }
}

function watchforlaststand(var0) {
  self endon("disconnect");
  var0 endon("killstreak_finished_with_deploy_weapon");
  self waittill("last_stand");
  scripts\mp\utility\entity::_disableequipdeployvfx();
  self.bgivensentry = 0;
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return;
  }
}

function watchforempapply(var0, var1) {
  self endon("disconnect");
  var1 endon("killstreak_finished_with_deploy_weapon");
  self waittill("apply_emp_player");
  self notify("equip_deploy_end");
}

function waittill_succeed_fail_end(var0, var1, var2) {
  var3 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var3);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var3);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var3);
  }

  GscBinSkip4(0x35, "death", var3);
}

function waittill_return(var0, var1) {
  if(var0 != "death") {
    self endon("death");
  }

  var1 endon("die");
  self waittill(var0, var2, var3, var4, var5);
  var1 notify("returned", var2, var3, var4, var5, var0);
}