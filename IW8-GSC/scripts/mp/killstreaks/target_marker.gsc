/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\target_marker.gsc
****************************************************/

function init() {
  scripts\mp\playeractions::registeractionset("target_marker", ["usability", "gesture"]);
}

function gettargetmarker(var_0, var_1) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  scripts\mp\playeractions::allowactionset("target_marker", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var_2 = asmdevgetallstates(var_0.weaponname);
  var_3 = undefined;
  thread watchforinvalidweapon(var_2, var_0);
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
    var_3 = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start");

    if(var_3.string == "equip_deploy_cancel") {
      break;
    }

    if(var_3.string == "equip_deploy_end") {
      if(!istrue(var_1)) {
        break;
      } else {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(var_3.string == "equip_deploy_failed") {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    if(isDefined(var_3) && var_3.string == "equip_deploy_succeeded") {
      if(updatecallback(var_3)) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_PLAYER");
        continue;
      } else if(!self isonground() || self isonladder()) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_AIR");
        continue;
      } else if(_calloutmarkerping_handleluinotify_enemyrepinged::updateleaders()) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_SUBWAY");
        continue;
      }
    }

    break;
  }

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_4 = var_3.location + (0, 0, 20);
    var_5 = var_3.location + (0, 0, -1000);
    var_6 = ["physicscontents_solid", "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item"];
    var_7 = physics_createcontents(var_6);
    var_8 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_7);

    if(isDefined(var_8["entity"])) {
      var_9 = var_8["entity"];
      var_3.moving_platform = var_9;
      var_10 = var_3.location - var_9.origin;
      var_11 = vectordot(var_10, anglesToForward(var_9.angles));
      var_12 = -1 * vectordot(var_10, anglestoright(var_9.angles));
      var_13 = vectordot(var_10, anglestoup(var_9.angles));
      var_3.ref_11dbe = (var_11, var_12, var_13);
      var_3.ref_11dbd = combineangles(invertangles(var_9.angles), var_3.angles);
    }

    var_3.visual = spawn("script_model", var_3.location + var_3.fxoffset);
    var_3.visual.angles = var_3.angles;

    if(var_0.streakname == "toma_strike") {
      var_3.visual setModel("ks_toma_strike_marker_mp");
    }

    if(isDefined(var_3.visual.model) && var_3.visual.model != "") {
      var_3.visual setotherent(self);
      var_3.visual setscriptablepartstate("target", "placed", 0);
    }
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
  }

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);
  return var_3;
}

function updatecallback(var_0) {
  var_1 = 0;
  var_2 = var_0.location;

  if(!scripts\engine\trace::sphere_trace_passed(var_2 + (0, 0, 100), var_2, 20, undefined, scripts\engine\trace::create_character_contents())) {
    var_1 = 1;
  }

  return var_1;
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

function watchforempapply(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("killstreak_finished_with_deploy_weapon");
  self waittill("emp_applied");
  self notify("equip_deploy_end");
}

function waittill_succeed_fail_end(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    GscBinSkip4(0x35, var_0, var_5);
  }

  if(isDefined(var_1)) {
    GscBinSkip4(0x35, var_1, var_5);
  }

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_2, var_5);
  }

  if(isDefined(var_3)) {
    GscBinSkip4(0x35, var_3, var_5);
  }

  if(isDefined(var_4)) {
    GscBinSkip4(0x35, var_4, var_5);
  }

  GscBinSkip4(0x35, "death", var_5);
}

function waittill_return(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5);
  var_1 notify("returned", var_2, var_3, var_4, var_5, var_0);
}