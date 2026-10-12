/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\target_marker.gsc
****************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#namespace target_marker;

function init() {
  val::group_register("target_marker", ["usability", "gesture", "sprint", "weapon_switch", "offhand_weapons", "melee", "execution_attack", "ladder_placement", "supers"]);
}

function gettargetmarker(streakinfo, ignoreplayercommand, var_99514d9b932ce768) {
  assertex(isPlayer(self), "<dev string:x1c>");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  val::group_set("target_marker", 0);
  _enableequipdeployvfx();

  if(ignoreplayercommand) {
    self notify("target_marker_begin_non_cancellable");
  }

  assertex(isDefined(streakinfo.weaponname), "<dev string:x53>" + streakinfo.streakname + "<dev string:x7c>");
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

  if(namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
    self setclientomnvar("ui_br_inventory_disabled", 1);
  }

  while(true) {
    markerinfo = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start");

    if(markerinfo.string == "equip_deploy_cancel") {
      break;
    }

    if(markerinfo.string == "equip_deploy_end") {
      if(!istrue(ignoreplayercommand)) {
        break;
      } else {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");
      }

      continue;
    }

    if(markerinfo.string == "equip_deploy_failed") {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
      continue;
    }

    if(isDefined(markerinfo) && markerinfo.string == "equip_deploy_succeeded") {
      if(isplacementplayerobstructed(markerinfo)) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_PLAYER");
        continue;
      } else if(!self isonground() || self isonladder()) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_AIR");
        continue;
      } else if(isDefined(level.var_ca4e08767cbdae12)) {
        canplant = self[[level.var_ca4e08767cbdae12]](markerinfo.location);

        if(!canplant) {
          scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
          continue;
        }
      } else if(isDefined(var_99514d9b932ce768) && self[[var_99514d9b932ce768]](markerinfo)) {
        continue;
      }
    }

    break;
  }

  if(isDefined(markerinfo.location) && isDefined(markerinfo.angles)) {
    starttrace = markerinfo.location + (0, 0, 80);
    endtrace = markerinfo.location + (0, 0, -1000);
    contentsplacement = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item"];
    contentsoverride = physics_createcontents(contentsplacement);
    platformtrace = scripts\engine\trace::sphere_trace(starttrace, endtrace, 20, undefined, contentsoverride);
    moving_platform = platformtrace["entity"];

    if(function_fcd42ee510c535fc(moving_platform)) {
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
        thread scripts\cp_mp\utility\debug_utility::drawsphere(platformtrace["<dev string:x90>"], 5, 30, (0, 1, 0));

        anchorzoffset = (0, 0, 0);

        if(distancesquared(markerinfo.location, platformtrace["position"]) >= 100) {
          anchorzoffset = (0, 0, 10);
        }

        markerinfo.location = (markerinfo.location[0], markerinfo.location[1], platformtrace["position"][2]) - anchorzoffset;
      }
    }
  }

  if(namespace_aead94004cf4c147::isbackpackinventoryenabled()) {
    self setclientomnvar("ui_br_inventory_disabled", 0);
  }

  if(isreallyalive(self)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    val::reset_all("watchPlacement");
  }

  _disableequipdeployvfx();
  thread delaythread(0.05, &val::group_reset, "target_marker");

  if(ignoreplayercommand) {
    thread delaythread(0.05, &send_notify, "target_marker_end_non_cancellable");
  }

  return markerinfo;
}

function function_fcd42ee510c535fc(movingplatform) {
  if(!isDefined(movingplatform)) {
    return false;
  }

  if(isDefined(movingplatform.helperdronetype)) {
    return false;
  }

  if(movingplatform scripts\cp_mp\vehicles\vehicle::isvehicle() && movingplatform.vehiclename == "veh9_acv_6x6") {
    return false;
  }

  return true;
}

function isplacementplayerobstructed(marker) {
  placementobstructed = 0;
  placementposition = marker.location;
  var_70ed0cd3a7facca8 = getdvarint(@ "hash_3164f71dec5da145", 100);

  if(!scripts\engine\trace::sphere_trace_passed(placementposition + (0, 0, 100), placementposition, var_70ed0cd3a7facca8, self, scripts\engine\trace::create_character_contents())) {
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
  self waittill("emp_applied");
  self notify("equip_deploy_end");
}

function function_4f304cc560c066ae(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isswimming()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED_WATER");
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
  self waittill("last_stand_start");
  scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
  self notify("equip_deploy_cancel");
}

function function_9a5aedfd9a5ca5e6(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isparachuting()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
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
  self notify("equip_deploy_failed");
}

function function_a3234162c515654f(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  while(true) {
    if(self isinexecutionattack() || self isinexecutionvictim()) {
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

function watchforplacementfirestate(streakinfo, endonnotify, weaponobj) {
  self endon(endonnotify);
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  if(isDefined(weaponobj) && !killstreakdeploy::candeploykillstreak(streakinfo, weaponobj)) {
    return;
  }

  allowplacement = 0;
  val::set("watchPlacement", "fire", 0);
  val::set("watchPlacement", "usability", 0);
  thread watchforplacementfirestateend(streakinfo, endonnotify);

  while(true) {
    self waittill("deploy_equip_valid_changed", placementstate);

    if(!istrue(placementstate)) {
      if(istrue(allowplacement)) {
        allowplacement = 0;
        val::set("watchPlacement", "fire", 0);
      }

      continue;
    }

    if(!touchingoobtrigger()) {
      if(!istrue(allowplacement)) {
        allowplacement = 1;
        val::set("watchPlacement", "fire", 1);
      }
    }
  }
}

function watchforplacementfirestateend(streakinfo, endonnotify) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill(endonnotify);
  val::reset_all("watchPlacement");
}

function waittill_succeed_fail_end(confirmstring, failstring, endstring, cancelstring, classswitchstring) {
  ent = spawnStruct();

  if(isDefined(confirmstring)) {
    childthread waittill_return(confirmstring, ent);
  }

  if(isDefined(failstring)) {
    childthread waittill_return(failstring, ent);
  }

  if(isDefined(endstring)) {
    childthread waittill_return(endstring, ent);
  }

  if(isDefined(cancelstring)) {
    childthread waittill_return(cancelstring, ent);
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