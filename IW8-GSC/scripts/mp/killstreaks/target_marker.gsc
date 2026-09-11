/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\target_marker.gsc
****************************************************/

function init() {
  scripts\mp\playeractions::registeractionset("target_marker", ["usability", "gesture"]);
}

function gettargetmarker(var0, var1) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  scripts\mp\playeractions::allowactionset("target_marker", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var2 = asmdevgetallstates(var0.weaponname);
  var3 = undefined;
  thread watchforinvalidweapon(var2, var0);
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
    var3 = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start");

    if(var3.string == "equip_deploy_cancel") {
      break;
    }

    if(var3.string == "equip_deploy_end") {
      if(!istrue(var1)) {
        break;
      } else {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(var3.string == "equip_deploy_failed") {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    if(isDefined(var3) && var3.string == "equip_deploy_succeeded") {
      if(updatecallback(var3)) {
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

  if(isDefined(var3.location) && isDefined(var3.angles)) {
    var4 = var3.location + (0, 0, 20);
    var5 = var3.location + (0, 0, -1000);
    var6 = ["physicscontents_solid", "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item"];
    var7 = physics_createcontents(var6);
    var8 = scripts\engine\trace::ray_trace(var4, var5, undefined, var7);

    if(isDefined(var8["entity"])) {
      var9 = var8["entity"];
      var3.moving_platform = var9;
      var10 = var3.location - var9.origin;
      var11 = vectordot(var10, anglesToForward(var9.angles));
      var12 = -1 * vectordot(var10, anglestoright(var9.angles));
      var13 = vectordot(var10, anglestoup(var9.angles));
      var3.ref_11dbe = (var11, var12, var13);
      var3.ref_11dbd = combineangles(invertangles(var9.angles), var3.angles);
    }

    var3.visual = spawn("script_model", var3.location + var3.fxoffset);
    var3.visual.angles = var3.angles;

    if(var0.streakname == "toma_strike") {
      var3.visual setModel("ks_toma_strike_marker_mp");
    }

    if(isDefined(var3.visual.model) && var3.visual.model != "") {
      var3.visual setotherent(self);
      var3.visual setscriptablepartstate("target", "placed", 0);
    }
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    var0 notify("killstreak_finished_with_deploy_weapon");
  }

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, &scripts\mp\playeractions::allowactionset, "target_marker", 1);
  return var3;
}

function updatecallback(var0) {
  var1 = 0;
  var2 = var0.location;

  if(!scripts\engine\trace::sphere_trace_passed(var2 + (0, 0, 100), var2, 20, undefined, scripts\engine\trace::create_character_contents())) {
    var1 = 1;
  }

  return var1;
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

function watchforempapply(var0, var1) {
  self endon("disconnect");
  var1 endon("killstreak_finished_with_deploy_weapon");
  self waittill("emp_applied");
  self notify("equip_deploy_end");
}

function waittill_succeed_fail_end(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();

  if(isDefined(var0)) {
    GscBinSkip4(0x35, var0, var5);
  }

  if(isDefined(var1)) {
    GscBinSkip4(0x35, var1, var5);
  }

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var2, var5);
  }

  if(isDefined(var3)) {
    GscBinSkip4(0x35, var3, var5);
  }

  if(isDefined(var4)) {
    GscBinSkip4(0x35, var4, var5);
  }

  GscBinSkip4(0x35, "death", var5);
}

function waittill_return(var0, var1) {
  if(var0 != "death") {
    self endon("death");
  }

  var1 endon("die");
  self waittill(var0, var2, var3, var4, var5);
  var1 notify("returned", var2, var3, var4, var5, var0);
}