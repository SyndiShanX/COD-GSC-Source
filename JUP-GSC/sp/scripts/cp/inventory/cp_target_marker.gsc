/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\inventory\cp_target_marker.gsc
*****************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_target_marker;

function init() {
  val::group_register("target_marker", ["usability", "gesture", "sprint", "weapon_switch", "offhand_weapons", "melee", "execution_attack", "ladder_placement"]);
}

function gettargetmarker(streakinfo, ignoreplayercommand, var_99514d9b932ce768) {
  assertex(isPlayer(self), "this function needs to be called on a player Entity");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  self endon("last_stand");
  val::group_set("target_marker", 0);
  function_4d76a37e9c3e2095();
  weapon = makeweaponfromstring(streakinfo.weaponname);
  markerinfo = undefined;
  thread watchforinvalidweapon(weapon, streakinfo);
  thread watchforammouse(weapon, streakinfo);
  thread watchforempapply(weapon, streakinfo);
  thread function_4f304cc560c066ae(streakinfo);
  thread watchforlaststand(streakinfo);
  thread function_9a5aedfd9a5ca5e6(streakinfo);
  thread function_46b5bec68eecb29(streakinfo);
  thread function_a3234162c515654f(streakinfo);

  if(!istrue(ignoreplayercommand)) {
    if(!isai(self)) {
      self notifyonplayercommand("equip_deploy_end", "+weapnext");
      self notifyonplayercommand("equip_deploy_end", "+weapprev");
      self notifyonplayercommand("equip_deploy_end", "+actionslot 4");

      if(!self isconsoleplayer()) {
        self notifyonplayercommand("equip_deploy_end", "+actionslot 5");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 6");
        self notifyonplayercommand("equip_deploy_end", "+actionslot 7");
      }
    }
  }

  while(true) {
    markerinfo = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_cancel", "equip_deploy_failed", "equip_deploy_end", "giveLoadout_start");

    if(markerinfo.string == "equip_deploy_cancel") {
      break;
    }

    if(markerinfo.string == "equip_deploy_end") {
      if(!istrue(ignoreplayercommand)) {
        break;
      } else {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(markerinfo.string == "equip_deploy_failed") {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    if(isDefined(markerinfo) && markerinfo.string == "equip_deploy_succeeded") {
      if(isplacementplayerobstructed(markerinfo)) {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
        continue;
      } else if(!self isonground() || self isonladder()) {
        scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_AIR");
        continue;
      } else if(isDefined(level.var_ca4e08767cbdae12)) {
        canplant = self[[level.var_ca4e08767cbdae12]](markerinfo.location);

        if(!canplant) {
          scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
          continue;
        }
      } else if(isDefined(var_99514d9b932ce768) && self[[var_99514d9b932ce768]](markerinfo)) {
        continue;
      }
    }

    break;
  }

  if(isDefined(markerinfo.location) && isDefined(markerinfo.angles)) {
    starttrace = markerinfo.location + (0, 0, 20);
    endtrace = markerinfo.location + (0, 0, -1000);
    contentsplacement = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item"];
    contentsoverride = physics_createcontents(contentsplacement);
    platformtrace = scripts\engine\trace::ray_trace(starttrace, endtrace, undefined, contentsoverride);
    moving_platform = platformtrace["entity"];

    if(isDefined(moving_platform) && !isDefined(moving_platform.helperdronetype)) {
      markerinfo.moving_platform = moving_platform;
      var_f3589428c6ee8c59 = markerinfo.location - moving_platform.origin;
      var_1df3e0c98e18cb08 = vectordot(var_f3589428c6ee8c59, anglesToForward(moving_platform.angles));
      var_1df3e1c98e18cd3b = -1 * vectordot(var_f3589428c6ee8c59, anglestoright(moving_platform.angles));
      var_1df3e2c98e18cf6e = vectordot(var_f3589428c6ee8c59, anglestoup(moving_platform.angles));
      markerinfo.moving_platform_offset = (var_1df3e0c98e18cb08, var_1df3e1c98e18cd3b, var_1df3e2c98e18cf6e);
      markerinfo.moving_platform_angles_offset = combineangles(invertangles(moving_platform.angles), markerinfo.angles);
    } else if(getdvarint(@ "hash_50998d037e0d13b9", 0)) {
      if(platformtrace["hittype"] != "hittype_none" && isDefined(platformtrace["position"])) {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(markerinfo.location, 5, 30, (1, 0, 0));
        thread scripts\cp_mp\utility\debug_utility::drawsphere(platformtrace["<dev string:x1c>"], 5, 30, (0, 1, 0));

        anchorzoffset = (0, 0, 0);

        if(distancesquared(markerinfo.location, platformtrace["position"]) >= 100) {
          anchorzoffset = (0, 0, 10);
        }

        markerinfo.location = platformtrace["position"] - anchorzoffset;
      }
    }
  }

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    val::reset_all("watchPlacement");
  }

  function_7566dc51064a3048();
  thread delaythread(0.05, &val::group_reset, "target_marker");
  return markerinfo;
}

function isplacementplayerobstructed(marker) {
  placementobstructed = 0;
  placementposition = marker.location;

  if(!scripts\engine\trace::sphere_trace_passed(placementposition + (0, 0, 100), placementposition, 20, undefined, scripts\engine\trace::create_character_contents())) {
    placementobstructed = 1;
  }

  return placementobstructed;
}

function watchforinvalidweapon(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self getcurrentweapon() != weapon) {
      self notify("equip_deploy_end");
      break;
    }

    waitframe();
  }
}

function watchforammouse(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  totalclipammo = self getweaponammoclip(weapon);

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(objweapon == weapon) {
      self setweaponammoclip(objweapon, totalclipammo);
    }
  }
}

function watchforempapply(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("apply_emp_player");
  self notify("equip_deploy_end");
}

function function_4f304cc560c066ae(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isswimming()) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED_WATER");
      self.bgivensentry = 0;
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

function watchforlaststand(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("last_stand");
  scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
  self.bgivensentry = 0;
  self notify("equip_deploy_cancel");
}

function function_9a5aedfd9a5ca5e6(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isparachuting()) {
      scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
      self.bgivensentry = 0;
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

function function_46b5bec68eecb29(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("oob_cooldown_end");
  scripts\cp\cp_hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
  self.bgivensentry = 0;
  self notify("equip_deploy_cancel");
}

function function_a3234162c515654f(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isinexecutionattack() || self isinexecutionvictim()) {
      self notify("equip_deploy_cancel");
      self.bgivensentry = 0;
      break;
    }

    waitframe();
  }
}

function watchforplacementfirestate(streakinfo, endonnotify) {
  self endon(endonnotify);
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  allowplacement = 0;
  val::set("watchPlacement", "fire", 0);
  thread watchforplacementfirestateend(streakinfo, endonnotify);

  while(true) {
    placementstate = function_1b5bee429041e503(1, streakinfo, endonnotify);

    if(is_equal(placementstate, "equip_0")) {
      if(istrue(allowplacement)) {
        allowplacement = 0;
        val::set("watchPlacement", "fire", 0);
      }

      continue;
    }

    if(is_equal(placementstate, "equip_1")) {
      if(!istrue(allowplacement)) {
        allowplacement = 1;
        val::set("watchPlacement", "fire", 1);
      }

      continue;
    }

    if(is_equal(placementstate, "timeout")) {
      if(self function_ade2dd3ec6873d9c() && !istrue(allowplacement)) {
        allowplacement = 1;
        val::set("watchPlacement", "fire", 1);
        continue;
      }

      if(!self function_ade2dd3ec6873d9c() && istrue(allowplacement)) {
        allowplacement = 0;
        val::set("watchPlacement", "fire", 0);
      }
    }
  }
}

function function_1b5bee429041e503(timer, streakinfo, endonnotify) {
  self endon(endonnotify);
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  notifystruct = spawnStruct();
  childthread function_ee6bdce84e25df19(notifystruct);
  childthread function_d56d5627730f5eeb(notifystruct, timer);
  notifystruct waittill("waittill_proc", result);
  return result;
}

function function_ee6bdce84e25df19(notifystruct) {
  notifystruct endon("waittill_proc");
  notifymessage = undefined;
  self waittill("deploy_equip_valid_changed", placementstate);

  if(istrue(placementstate)) {
    notifymessage = "equip_1";
  } else {
    notifymessage = "equip_0";
  }

  notifystruct notify("waittill_proc", notifymessage);
}

function function_d56d5627730f5eeb(notifystruct, timeout) {
  notifystruct endon("waittill_proc");
  wait timeout;
  notifystruct notify("waittill_proc", "timeout");
}

function watchforplacementfirestateend(streakinfo, endonnotify) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill(endonnotify);
  val::reset_all("watchPlacement");
}

function waittill_succeed_fail_end(confirmstring, cancelstring, var_37069a8f8e660499, endstring, classswitchstring) {
  ent = spawnStruct();

  if(isDefined(confirmstring)) {
    childthread waittill_return(confirmstring, ent);
  }

  if(isDefined(cancelstring)) {
    childthread waittill_return(cancelstring, ent);
  }

  if(isDefined(var_37069a8f8e660499)) {
    childthread waittill_return(var_37069a8f8e660499, ent);
  }

  if(isDefined(endstring)) {
    childthread waittill_return(endstring, ent);
  }

  if(isDefined(classswitchstring)) {
    childthread waittill_return(classswitchstring, ent);
  }

  childthread waittill_return("death", ent);
  ent waittill("returned", vfxoffset, weaponname, location, angle, string);
  ent notify("die");
  returninfo = spawnStruct();
  returninfo.weapon = weaponname;
  returninfo.location = location;
  returninfo.angles = angle;
  returninfo.string = string;
  returninfo.fxoffset = vfxoffset;
  return returninfo;
}

function waittill_return(confirmstring, ent) {
  if(confirmstring != "death") {
    self endon("death");
  }

  ent endon("die");
  self waittill(confirmstring, vfxoffset, weapon, location, angle);
  ent notify("returned", vfxoffset, weapon, location, angle, confirmstring);
}

function function_4d76a37e9c3e2095() {
  if(!isDefined(self.enabledequipdeployvfx)) {
    self.enabledequipdeployvfx = 0;
  }

  if(self.enabledequipdeployvfx == 0) {
    self enableequipdeployvfx(1);
  }

  self.enabledequipdeployvfx++;
}

function function_7566dc51064a3048() {
  assert(isDefined(self.enabledequipdeployvfx) && self.enabledequipdeployvfx > 0, "_disableEquipDeployVFX called when vfx are disabled.");

  if(self.enabledequipdeployvfx == 1) {
    self enableequipdeployvfx(0);
  }

  self.enabledequipdeployvfx--;
}