/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\target_marker.gsc
****************************************************/

init() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("target_marker", ["usability", "gesture", "sprint", "weapon_switch", "offhand_weapons", "melee", "execution_attack", "ladder_placement", "supers"]);
}

gettargetmarker(streakinfo, _id_281C85042194C88F) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("target_marker", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  weapon = makeweaponfromstring(streakinfo.weaponname);
  _id_E7DB3D4387BC5207 = undefined;
  thread watchforinvalidweapon(weapon, streakinfo);
  thread watchforammouse(weapon, streakinfo);
  thread watchforempapply(weapon, streakinfo);
  thread _id_4F304CC560C066AE(streakinfo);
  thread watchforlaststand(streakinfo);
  thread _id_9A5AEDFD9A5CA5E6(streakinfo);
  thread _id_046B5BEC68EECB29(streakinfo);
  thread _id_A3234162C515654F(streakinfo);

  if(!istrue(_id_281C85042194C88F)) {
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

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
    self setclientomnvar("ui_br_inventory_disabled", 1);

  for(;;) {
    _id_E7DB3D4387BC5207 = waittill_succeed_fail_end("equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start");

    if(_id_E7DB3D4387BC5207.string == "equip_deploy_cancel") {
      break;
    } else {
      if(_id_E7DB3D4387BC5207.string == "equip_deploy_end") {
        if(!istrue(_id_281C85042194C88F)) {
          break;
        } else
          scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_SWITCH");

        continue;
      }

      if(_id_E7DB3D4387BC5207.string == "equip_deploy_failed") {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
        continue;
      }

      if(isDefined(_id_E7DB3D4387BC5207) && _id_E7DB3D4387BC5207.string == "equip_deploy_succeeded") {
        if(isplacementplayerobstructed(_id_E7DB3D4387BC5207)) {
          scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_PLAYER");
          continue;
        } else if(!self isonground() || self isonladder()) {
          scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED_AIR");
          continue;
        } else if(isDefined(level._id_CA4E08767CBDAE12)) {
          _id_425925A45729DEAE = self[[level._id_CA4E08767CBDAE12]](_id_E7DB3D4387BC5207.location);

          if(!_id_425925A45729DEAE) {
            scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_PLACED");
            continue;
          }
        }
      }

      break;
    }
  }

  if(isDefined(_id_E7DB3D4387BC5207.location) && isDefined(_id_E7DB3D4387BC5207.angles)) {
    _id_22C4300CE1D248E8 = _id_E7DB3D4387BC5207.location + (0, 0, 80);
    _id_98C6610C2907BA2B = _id_E7DB3D4387BC5207.location + (0, 0, -1000);
    _id_86C927742FE0F6AE = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item"];
    _id_C3FBB6661B91750F = physics_createcontents(_id_86C927742FE0F6AE);
    _id_361673325F14226B = scripts\engine\trace::sphere_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, 20, undefined, _id_C3FBB6661B91750F);
    moving_platform = _id_361673325F14226B["entity"];

    if(_id_FCD42EE510C535FC(moving_platform)) {
      _id_E7DB3D4387BC5207.moving_platform = moving_platform;
      _id_F3589428C6EE8C59 = _id_E7DB3D4387BC5207.location - moving_platform.origin;
      _id_1DF3E0C98E18CB08 = vectordot(_id_F3589428C6EE8C59, anglesToForward(moving_platform.angles));
      _id_1DF3E1C98E18CD3B = -1.0 * vectordot(_id_F3589428C6EE8C59, anglestoright(moving_platform.angles));
      _id_1DF3E2C98E18CF6E = vectordot(_id_F3589428C6EE8C59, anglestoup(moving_platform.angles));
      _id_E7DB3D4387BC5207.moving_platform_offset = (_id_1DF3E0C98E18CB08, _id_1DF3E1C98E18CD3B, _id_1DF3E2C98E18CF6E);
      _id_E7DB3D4387BC5207.moving_platform_angles_offset = combineangles(invertangles(moving_platform.angles), _id_E7DB3D4387BC5207.angles);
    } else if(getdvarint("dvar_50998D037E0D13B9", 0)) {
      if(_id_361673325F14226B["hittype"] != "hittype_none" && isDefined(_id_361673325F14226B["position"])) {
        _id_C49AC9441D2C5419 = (0, 0, 0);

        if(distancesquared(_id_E7DB3D4387BC5207.location, _id_361673325F14226B["position"]) >= 100)
          _id_C49AC9441D2C5419 = (0, 0, 10);

        _id_E7DB3D4387BC5207.location = (_id_E7DB3D4387BC5207.location[0], _id_E7DB3D4387BC5207.location[1], _id_361673325F14226B["position"][2]) - _id_C49AC9441D2C5419;
      }
    }
  }

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
    self setclientomnvar("ui_br_inventory_disabled", 0);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("watchPlacement");
  }

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, _id_3B64EB40368C1450::_id_588F2307A3040610, "target_marker");
  return _id_E7DB3D4387BC5207;
}

_id_FCD42EE510C535FC(_id_A2731E6D9AF15254) {
  if(!isDefined(_id_A2731E6D9AF15254))
    return 0;

  if(isDefined(_id_A2731E6D9AF15254.helperdronetype))
    return 0;

  if(_id_A2731E6D9AF15254 scripts\cp_mp\vehicles\vehicle::isvehicle() && _id_A2731E6D9AF15254.vehiclename == "veh9_acv_6x6")
    return 0;

  return 1;
}

isplacementplayerobstructed(marker) {
  _id_5866E1790A4C2F2D = 0;
  _id_9673C988F7266C67 = marker.location;

  if(!scripts\engine\trace::sphere_trace_passed(_id_9673C988F7266C67 + (0, 0, 100), _id_9673C988F7266C67, 20, undefined, scripts\engine\trace::create_character_contents()))
    _id_5866E1790A4C2F2D = 1;

  return _id_5866E1790A4C2F2D;
}

watchforinvalidweapon(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  for(;;) {
    if(self getcurrentweapon() != weapon) {
      self notify("equip_deploy_end");
      break;
    }

    waitframe();
  }
}

watchforammouse(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  _id_450EBD9F1229ACA5 = self getweaponammoclip(weapon);

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(objweapon == weapon)
      self setweaponammoclip(objweapon, _id_450EBD9F1229ACA5);
  }
}

watchforempapply(weapon, streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("emp_applied");
  self notify("equip_deploy_end");
}

_id_4F304CC560C066AE(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  for(;;) {
    if(self _meth_E40102956C887F7C()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED_WATER");
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

watchforlaststand(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("last_stand_start");
  scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
  self notify("equip_deploy_cancel");
}

_id_9A5AEDFD9A5CA5E6(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  for(;;) {
    if(self isparachuting()) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

_id_046B5BEC68EECB29(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("oob_cooldown_end");
  scripts\mp\hud_message::showerrormessage("KILLSTREAKS/PLACEMENT_CANCELED");
  self notify("equip_deploy_cancel");
}

_id_A3234162C515654F(streakinfo) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");

  for(;;) {
    if(self isinexecutionattack() || self isinexecutionvictim()) {
      self notify("equip_deploy_cancel");
      break;
    }

    waitframe();
  }
}

_id_ECCFD4B7CD6B40B3(streakinfo, _id_374D7614ECBD032A) {
  self endon(_id_374D7614ECBD032A);
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  _id_D5EFE0DC4421B041 = 0;
  _id_3B64EB40368C1450::set("watchPlacement", "fire", 0);
  _id_3B64EB40368C1450::set("watchPlacement", "usability", 0);
  thread _id_502F817C790DEC40(streakinfo, _id_374D7614ECBD032A);

  for(;;) {
    self waittill("deploy_equip_valid_changed", _id_226B8D81BC032929);

    if(!istrue(_id_226B8D81BC032929)) {
      if(istrue(_id_D5EFE0DC4421B041)) {
        _id_D5EFE0DC4421B041 = 0;
        _id_3B64EB40368C1450::set("watchPlacement", "fire", 0);
      }

      continue;
    }

    if(!istrue(_id_D5EFE0DC4421B041)) {
      _id_D5EFE0DC4421B041 = 1;
      _id_3B64EB40368C1450::set("watchPlacement", "fire", 1);
    }
  }
}

_id_502F817C790DEC40(streakinfo, _id_374D7614ECBD032A) {
  self endon("death_or_disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill(_id_374D7614ECBD032A);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("watchPlacement");
}

waittill_succeed_fail_end(_id_12E3586B64301806, _id_56FD0C716F6BE894, _id_0CD73FF319D57C07, _id_9BA4FCFEB48763BA, _id_BD92CE9529BD1F2E) {
  ent = spawnStruct();

  if(isDefined(_id_12E3586B64301806))
    childthread waittill_return(_id_12E3586B64301806, ent);

  if(isDefined(_id_56FD0C716F6BE894))
    childthread waittill_return(_id_56FD0C716F6BE894, ent);

  if(isDefined(_id_0CD73FF319D57C07))
    childthread waittill_return(_id_0CD73FF319D57C07, ent);

  if(isDefined(_id_9BA4FCFEB48763BA))
    childthread waittill_return(_id_9BA4FCFEB48763BA, ent);

  if(isDefined(_id_BD92CE9529BD1F2E))
    childthread waittill_return(_id_BD92CE9529BD1F2E, ent);

  childthread waittill_return("death", ent);
  ent waittill("returned", _id_2FD23E27096DA380, weaponname, location, angle, string);
  ent notify("die");
  _id_6E586A99FA56A20F = spawnStruct();
  _id_6E586A99FA56A20F.weapon = weaponname;
  _id_6E586A99FA56A20F.location = location;
  _id_6E586A99FA56A20F.angles = angle;
  _id_6E586A99FA56A20F.string = string;
  _id_6E586A99FA56A20F.fxoffset = _id_2FD23E27096DA380;
  return _id_6E586A99FA56A20F;
}

waittill_return(_id_12E3586B64301806, ent) {
  if(_id_12E3586B64301806 != "death")
    self endon("death");

  ent endon("die");
  self waittill(_id_12E3586B64301806, _id_2FD23E27096DA380, weapon, location, angle);
  ent notify("returned", _id_2FD23E27096DA380, weapon, location, angle, _id_12E3586B64301806);
}