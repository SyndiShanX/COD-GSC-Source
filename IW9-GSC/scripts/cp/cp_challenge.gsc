/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_challenge.gsc
***********************************************/

init() {
  if(!challengesenabled()) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level setupchallengelocales();
}

setupchallengelocales() {
  level.localetriggers = [];
  _id_D09AECDB0D855501 = getEntArray("locale_area_trigger", "targetname");

  if(isDefined(_id_D09AECDB0D855501) && _id_D09AECDB0D855501.size > 0) {
    foreach(area in _id_D09AECDB0D855501) {
      if(!isDefined(area.script_noteworthy)) {
        continue;
      }
      switch (area.script_noteworthy) {
        case "downtown":
          area.localeid = 0;
          break;
        case "stadium":
          area.localeid = 1;
          break;
        case "tvstation":
          area.localeid = 2;
          break;
        case "hospital":
          area.localeid = 3;
          break;
        case "airport":
          area.localeid = 4;
          break;
        case "dam":
          area.localeid = 5;
          break;
        case "scrapyard":
          area.localeid = 6;
          break;
        case "trainstation":
          area.localeid = 7;
          break;
        case "quarry":
          area.localeid = 8;
          break;
        case "lumbermill":
          area.localeid = 9;
          break;
        case "port":
          area.localeid = 10;
          break;
        case "gulag":
          area.localeid = 11;
          break;
      }
    }

    level.localetriggers = _id_D09AECDB0D855501;
  }
}

challengesenabled() {
  if(getdvarint("dvar_F0C3671383D467F8", 0) != 0)
    return 0;

  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled())
    return 0;

  if(!isPlayer(self) || isai(self))
    return 0;

  return 1;
}

onplayerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(!scripts\cp\utility\player::isfriendly(attacker.team, victim)) {
    _id_F4692D0892428480 = scripts\cp\cp_equipment::getequipmentreffromweapon(objweapon);

    if(!isDefined(_id_F4692D0892428480))
      _id_F4692D0892428480 = scripts\cp\utility::getdefaultweaponbasename(objweapon.basename);

    switch (_id_F4692D0892428480) {
      case "iw8_armor_marker_cp":
      case "iw8_ammo_marker_cp":
        _id_F4692D0892428480 = "support_box_mp";
        break;
      default:
        break;
    }

    _id_6747B178B5FC3B95 = "";

    if(isDefined(attacker.secondaryweaponobj)) {
      if(objweapon == attacker.primaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);
      else if(objweapon == attacker.secondaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);
    }

    weapons = [_id_F4692D0892428480, _id_6747B178B5FC3B95];
    _id_425D52C81F1883FC = 0;
    _id_425D55C81F188A95 = 0;

    if(isDefined(modifiers)) {
      _id_425D52C81F1883FC = modifiers["mask"];
      _id_425D55C81F188A95 = modifiers["mask2"];
    }

    _id_B6217B906C6BE73E = [attacker _id_12E2FB553EC1605E::lookupcurrentoperator(attacker.team), attacker _id_12E2FB553EC1605E::lookupotheroperator(attacker.team)];

    if(!getdvarint("dvar_78653010D584AA6E")) {
      _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

      if(!isDefined(_id_C8F690457A04A764))
        _id_C8F690457A04A764 = getDvar("g_gametype");

      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
    } else
      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

    _id_349E390338192305 = "";
    _id_C832CC337856ACA8 = 1;

    if(isDefined(objweapon.attachments)) {
      _id_7208E21EA18240FB = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope"))
          _id_7208E21EA18240FB = 1;

        if(_id_74502A9E0EF1F19C::attachmentisselectable(objweapon, attachment)) {
          if(!_id_C832CC337856ACA8)
            _id_349E390338192305 = _id_349E390338192305 + "|";

          _id_349E390338192305 = _id_349E390338192305 + attachment;
          _id_C832CC337856ACA8 = 0;
        }
      }

      if(_id_7208E21EA18240FB) {
        if(!_id_C832CC337856ACA8)
          _id_349E390338192305 = _id_349E390338192305 + "|";

        _id_349E390338192305 = _id_349E390338192305 + "default_sniper_scope";
      }
    }

    _id_D064B7165A057B5D = "";
    _id_0A4B6D9CAA65995D = 1;

    if(isDefined(attacker.classstruct) && isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks) {
        if(!_id_0A4B6D9CAA65995D)
          _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

        _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
        _id_0A4B6D9CAA65995D = 0;
      }
    }

    _id_B5EEC3B49CF346D2 = [damage, 0];
    _id_C5B28F88D9B3BFD7 = 0;

    if(isPlayer(victim))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
    else if(isagent(victim))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

    _id_4C20E5ABF3CE9872 = 0;
    _id_AE8EB6D66C120397 = 0;
    _id_B786822D9A87AB34 = 0;
    _id_B93834C5C289DCDC = 0;

    if(isDefined(victim.streakinfo)) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 2;
      _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
      _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

      switch (_id_D8061F26B5ECA018) {
        case "sentry_gun":
        case "manual_turret":
        case "bradley":
        case "pac_sentry":
        case "juggernaut":
          _id_4C20E5ABF3CE9872 = 1;
          break;
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
        case "nuke":
          _id_AE8EB6D66C120397 = 1;
          break;
        case "directional_uav":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
        case "uav":
          _id_AE8EB6D66C120397 = 1;
          _id_B786822D9A87AB34 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          _id_B786822D9A87AB34 = 1;
          break;
      }

      if(_id_4C20E5ABF3CE9872)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;

      if(_id_AE8EB6D66C120397)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 4;

      if(_id_B786822D9A87AB34)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 16;
    }

    if(isDefined(victim.vehiclename) || _id_B93834C5C289DCDC) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 32;

      if(!_id_4C20E5ABF3CE9872 && isDefined(victim.vehiclename) && !istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;
    }

    if(isDefined(victim.equipmentref))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 64;

    _id_A5958DC7369199C7 = "";

    if(_id_C5B28F88D9B3BFD7 == 512)
      juggernaut_kill_assists_included(attacker, victim, _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7);
    else
      attacker reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(attacker, victim));
  }
}

return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim) {
  type = victim.aitype;

  if(!isDefined(victim.aitype)) {
    if(isDefined(victim.unittype))
      type = victim.unittype;
  }

  switch (type) {
    case "soldier":
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 128;
      break;
    case "juggernaut":
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 512;
      break;
    case "suicidebomber":
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1024;
      break;
    case "riotshield":
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 256;
      break;
    default:
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 128;
      break;
  }

  return _id_C5B28F88D9B3BFD7;
}

juggernaut_kill_assists_included(attacker, victim, _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7) {
  if(_id_C5B28F88D9B3BFD7 != 512)
    return 0;

  if(isDefined(victim.attackers)) {
    foreach(player in victim.attackers) {
      if(!isDefined(_id_6F1E07CE9FF97D5F::_validateattacker(player))) {
        continue;
      }
      if(victim == player) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      _id_907BB577FE481752 = undefined;

      if(isDefined(victim.attackerdata)) {
        attackerdata = victim.attackerdata[player.guid];

        if(isDefined(attackerdata))
          _id_907BB577FE481752 = attackerdata.objweapon;
      }

      _id_54351D786449EE9E = 0;

      if(self.attackerdata[player.guid].damage >= victim.maxhealth * 0.1)
        _id_54351D786449EE9E = 1;

      if(self.attackerdata[player.guid].damage >= victim.maxhealth * 0.2)
        _id_54351D786449EE9E = 2;

      if(_id_54351D786449EE9E >= 1)
        player reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(player, victim));
    }

    return 1;
  }

  return 0;
}

ondeath(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("death", 0);
}

onplayerkillassist(victim) {
  attacker = self;

  if(!attacker challengesenabledforplayer()) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(attacker.team, victim)) {
    primaryweapon = "";

    if(isDefined(attacker.primaryweaponobj))
      primaryweapon = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);

    secondaryweapon = "";

    if(isDefined(attacker.secondaryweaponobj))
      secondaryweapon = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);

    weapons = [primaryweapon, secondaryweapon];
    _id_B5EEC3B49CF346D2 = [0, 0];
    _id_C5B28F88D9B3BFD7 = 0;

    if(isPlayer(victim))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
    else if(isagent(victim))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

    _id_B6217B906C6BE73E = attacker getoperators();
    attacker reportchallengeuserevent("assist", _id_B5EEC3B49CF346D2, weapons, _id_B6217B906C6BE73E);
  }
}

onkillstreakend(ref, duration, currenttime, _id_77F3CA6D2F0AAE12, _id_EED18A862D3F3954, _id_EED18D862D3F3FED, _id_EED18C862D3F3DBA) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_F406BE343AB9CC93 = ref;
  _id_F178B5249C7541C0 = duration;
  _id_B951C0C77A5A6D08 = currenttime;
  _id_BDBCBE6DDF9167E7 = _id_77F3CA6D2F0AAE12;
  _id_4B45015A9A8707E4 = _id_EED18A862D3F3954;
  _id_4B45045A9A870E7D = _id_EED18D862D3F3FED;
  _id_4B45035A9A870C4A = _id_EED18C862D3F3DBA;
  _id_B6217B906C6BE73E = scripts\cp_mp\challenges::getoperators();

  if(!isDefined(_id_BDBCBE6DDF9167E7))
    _id_BDBCBE6DDF9167E7 = 0;

  switch (_id_F406BE343AB9CC93) {
    case "cp_used_armor":
    case "cp_used_ammo_crate":
    case "cp_used_adrenaline":
    case "cp_used_grenade_crate":
      _id_F406BE343AB9CC93 = "support_box_mp";

      if(_id_BDBCBE6DDF9167E7 == 0)
        _id_BDBCBE6DDF9167E7++;

      break;
    default:
      break;
  }

  self reportchallengeuserevent("killstreak_end", _id_F406BE343AB9CC93, _id_F178B5249C7541C0, _id_B951C0C77A5A6D08, _id_BDBCBE6DDF9167E7, _id_4B45015A9A8707E4, _id_4B45045A9A870E7D, _id_4B45035A9A870C4A, _id_B6217B906C6BE73E);
}

onfieldupgradeendbuffer(ref, value) {
  _id_D647223842F24DA0 = ref;

  if(ref == "super_recon_drone" && isDefined(self.recondronesuper)) {
    if(isDefined(self.recondronesuper.usedcountinveh))
      value = self.recondronesuper.usedcountinveh;
  }

  scripts\cp_mp\challenges::_id_BD59AA7E8CECE1AB(ref, value);
}

onfieldupgradeend(ref, value) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_D647223842F24DA0 = ref;
  amount = value;
  self reportchallengeuserevent("field_end", _id_D647223842F24DA0, amount);
}

oncapture(modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;

  if(isDefined(modifiers)) {
    _id_425D52C81F1883FC = modifiers["mask"];
    _id_425D55C81F188A95 = modifiers["mask2"];
  }

  if(!getdvarint("dvar_78653010D584AA6E")) {
    _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

    if(!isDefined(_id_C8F690457A04A764))
      _id_C8F690457A04A764 = getDvar("g_gametype");

    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
  } else
    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

  self reportchallengeuserevent("capture", _id_E37D5A134143CC83, _id_425D52C81F1883FC, _id_425D55C81F188A95);
}

ondefuse(modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;

  if(isDefined(modifiers)) {
    _id_425D52C81F1883FC = modifiers["mask"];
    _id_425D55C81F188A95 = modifiers["mask2"];
  }

  if(!getdvarint("dvar_78653010D584AA6E")) {
    _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

    if(!isDefined(_id_C8F690457A04A764))
      _id_C8F690457A04A764 = getDvar("g_gametype");

    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
  } else
    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

  self reportchallengeuserevent("defuse", _id_E37D5A134143CC83, _id_425D52C81F1883FC, _id_425D55C81F188A95);
}

onplant(modifiers) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;

  if(isDefined(modifiers)) {
    _id_425D52C81F1883FC = modifiers["mask"];
    _id_425D55C81F188A95 = modifiers["mask2"];
  }

  gametype = scripts\cp_mp\challenges::_id_17C5D7FEB226E256();
  _id_B6217B906C6BE73E = getoperators();
  self reportchallengeuserevent("defuse", gametype, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E);
}

onstun(equipment) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("stun", equipment);
}

onstim(_id_6C53F7D5FC456351) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent("stim", _id_6C53F7D5FC456351);
}

onhack(equipment) {
  if(!challengesenabledforplayer()) {
    return;
  }
  _id_D064B7165A057B5D = "";
  _id_0A4B6D9CAA65995D = 1;

  if(isDefined(self.classstruct) && isDefined(self.classstruct.loadoutperks)) {
    foreach(perk in self.classstruct.loadoutperks) {
      if(!_id_0A4B6D9CAA65995D)
        _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

      _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
      _id_0A4B6D9CAA65995D = 0;
    }
  }

  self reportchallengeuserevent("hack", equipment, _id_D064B7165A057B5D);
}

gettouchinglocaletriggers(attacker, victim) {
  _id_750C94BA41F40A47 = "";

  if(!isDefined(level.localetriggers))
    return _id_750C94BA41F40A47;

  found = 0;

  foreach(trigger in level.localetriggers) {
    if(attacker istouching(trigger) || victim istouching(trigger)) {
      if(isDefined(trigger.localeid)) {
        if(found)
          _id_750C94BA41F40A47 = _id_750C94BA41F40A47 + "|";

        _id_750C94BA41F40A47 = _id_750C94BA41F40A47 + trigger.localeid;
        found = 1;
      }
    }
  }

  return _id_750C94BA41F40A47;
}

onplayerteamrevive(reviver, _id_22F7E3F7E360775B) {}

onsuccessfulhit(objweapon) {}

onspawn() {}

updatesuperweaponkills(objweapon, inflictor) {}

updatesuperkills(_id_EBEC497FF8B18A45, meansofdeath, _id_B34CDA8A56DD46C5) {}

resistedstun(attacker) {}

triggereddelayedexplosion() {}

minedestroyed(mine, attacker, type) {}

roundbegin() {}

roundend(_id_8415802B3CFB809B) {}

playerdamaged(inflictor, attacker, damage, meansofdeath, objweapon, shitloc) {}

processuavassist(owner, uavtype) {}

killstreakdamaged(_id_D8061F26B5ECA018, owner, attacker, weapon, damage) {}

killstreakkilled(_id_D8061F26B5ECA018, owner, _id_168CF91A2552500C, attacker, damage, _id_D95DA0355CF4CCB4, objweapon, _id_92D090CE35588AD2) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    return;
  }
  if(!isDefined(victim.owner)) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(attacker.team, victim.owner)) {
    _id_F4692D0892428480 = scripts\cp\cp_equipment::getequipmentreffromweapon(objweapon);

    if(!isDefined(_id_F4692D0892428480))
      _id_F4692D0892428480 = scripts\cp\utility::getdefaultweaponbasename(objweapon.basename);

    _id_6747B178B5FC3B95 = "";

    if(isDefined(attacker.secondaryweaponobj)) {
      if(objweapon == attacker.primaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);
      else if(objweapon == attacker.secondaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);
    }

    weapons = [_id_F4692D0892428480, _id_6747B178B5FC3B95];
    _id_425D52C81F1883FC = 0;
    _id_425D55C81F188A95 = 0;

    if(isDefined(attacker.modifiers)) {
      _id_425D52C81F1883FC = attacker.modifiers["mask"];
      _id_425D55C81F188A95 = attacker.modifiers["mask2"];
    }

    _id_B6217B906C6BE73E = [attacker _id_12E2FB553EC1605E::lookupcurrentoperator(attacker.team), attacker _id_12E2FB553EC1605E::lookupotheroperator(attacker.team)];

    if(!getdvarint("dvar_78653010D584AA6E")) {
      _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

      if(!isDefined(_id_C8F690457A04A764))
        _id_C8F690457A04A764 = getDvar("g_gametype");

      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
    } else
      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

    _id_349E390338192305 = "";
    _id_C832CC337856ACA8 = 1;

    if(isDefined(objweapon.attachments)) {
      _id_7208E21EA18240FB = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope"))
          _id_7208E21EA18240FB = 1;

        if(_id_74502A9E0EF1F19C::attachmentisselectable(objweapon, attachment)) {
          if(issubstr(attachment, "snprscope"))
            attachment = "default_sniper_scope";

          if(!_id_C832CC337856ACA8)
            _id_349E390338192305 = _id_349E390338192305 + "|";

          _id_349E390338192305 = _id_349E390338192305 + attachment;
          _id_C832CC337856ACA8 = 0;
        }
      }

      if(_id_7208E21EA18240FB) {
        if(!_id_C832CC337856ACA8)
          _id_349E390338192305 = _id_349E390338192305 + "|";

        _id_349E390338192305 = _id_349E390338192305 + "default_sniper_scope";
      }
    }

    _id_D064B7165A057B5D = "";
    _id_0A4B6D9CAA65995D = 1;

    if(isDefined(attacker.classstruct) && isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks) {
        if(!_id_0A4B6D9CAA65995D)
          _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

        _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
        _id_0A4B6D9CAA65995D = 0;
      }
    }

    _id_B5EEC3B49CF346D2 = [damage, 0];
    _id_C5B28F88D9B3BFD7 = 0;

    if(isPlayer(victim))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
    else if(isagent(victim))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

    _id_4C20E5ABF3CE9872 = 0;
    _id_AE8EB6D66C120397 = 0;
    _id_B786822D9A87AB34 = 0;
    _id_B93834C5C289DCDC = 0;

    if(isDefined(victim.streakinfo)) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 2;
      _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
      _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

      switch (_id_D8061F26B5ECA018) {
        case "sentry_gun":
        case "manual_turret":
        case "bradley":
        case "pac_sentry":
        case "juggernaut":
          _id_4C20E5ABF3CE9872 = 1;
          break;
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
        case "nuke":
          _id_AE8EB6D66C120397 = 1;
          break;
        case "directional_uav":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
        case "uav":
          _id_AE8EB6D66C120397 = 1;
          _id_B786822D9A87AB34 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          _id_B786822D9A87AB34 = 1;
          break;
      }

      if(_id_4C20E5ABF3CE9872)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;

      if(_id_AE8EB6D66C120397)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 4;

      if(_id_B786822D9A87AB34)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 16;
    }

    if(isDefined(victim.vehiclename) || _id_B93834C5C289DCDC) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 32;

      if(!_id_4C20E5ABF3CE9872 && isDefined(victim.vehiclename) && !istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;
    }

    if(isDefined(victim.equipmentref))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 64;

    _id_A5958DC7369199C7 = "";
    attacker reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(attacker, victim));
  }
}

iskillstreakvehicle(_id_D8061F26B5ECA018) {
  switch (_id_D8061F26B5ECA018) {
    case "cruise_predator":
    case "sentry_gun":
    case "manual_turret":
    case "juggernaut":
      return 0;
  }

  return 1;
}

equipmentdestroyed(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(!isDefined(victim.owner)) {
    return;
  }
  if(!scripts\cp\utility\player::isfriendly(attacker.team, victim.owner)) {
    _id_F4692D0892428480 = scripts\cp\cp_equipment::getequipmentreffromweapon(objweapon);

    if(!isDefined(_id_F4692D0892428480))
      _id_F4692D0892428480 = scripts\cp\utility::getdefaultweaponbasename(objweapon.basename);

    _id_6747B178B5FC3B95 = "";

    if(objweapon == attacker.primaryweaponobj)
      _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);
    else if(objweapon == attacker.secondaryweaponobj)
      _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);

    weapons = [_id_F4692D0892428480, _id_6747B178B5FC3B95];
    _id_425D52C81F1883FC = 0;
    _id_425D55C81F188A95 = 0;

    if(isDefined(modifiers)) {
      _id_425D52C81F1883FC = modifiers["mask"];
      _id_425D55C81F188A95 = modifiers["mask2"];
    }

    _id_B6217B906C6BE73E = [attacker _id_12E2FB553EC1605E::lookupcurrentoperator(attacker.team), attacker _id_12E2FB553EC1605E::lookupotheroperator(attacker.team)];

    if(!getdvarint("dvar_78653010D584AA6E")) {
      _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

      if(!isDefined(_id_C8F690457A04A764))
        _id_C8F690457A04A764 = getDvar("g_gametype");

      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
    } else
      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

    _id_349E390338192305 = "";
    _id_C832CC337856ACA8 = 1;

    if(isDefined(objweapon.attachments)) {
      _id_7208E21EA18240FB = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope"))
          _id_7208E21EA18240FB = 1;

        if(_id_74502A9E0EF1F19C::attachmentisselectable(objweapon, attachment)) {
          if(!_id_C832CC337856ACA8)
            _id_349E390338192305 = _id_349E390338192305 + "|";

          _id_349E390338192305 = _id_349E390338192305 + attachment;
          _id_C832CC337856ACA8 = 0;
        }
      }

      if(_id_7208E21EA18240FB) {
        if(!_id_C832CC337856ACA8)
          _id_349E390338192305 = _id_349E390338192305 + "|";

        _id_349E390338192305 = _id_349E390338192305 + "default_sniper_scope";
      }
    }

    _id_D064B7165A057B5D = "";
    _id_0A4B6D9CAA65995D = 1;

    if(isDefined(attacker.classstruct) && isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks) {
        if(!_id_0A4B6D9CAA65995D)
          _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

        _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
        _id_0A4B6D9CAA65995D = 0;
      }
    }

    _id_B5EEC3B49CF346D2 = [damage, 0];
    _id_C5B28F88D9B3BFD7 = 0;

    if(isPlayer(victim))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
    else if(isagent(victim))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

    _id_4C20E5ABF3CE9872 = 0;
    _id_AE8EB6D66C120397 = 0;
    _id_B786822D9A87AB34 = 0;
    _id_B93834C5C289DCDC = 0;

    if(isDefined(victim.streakinfo)) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 2;
      _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
      _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

      switch (_id_D8061F26B5ECA018) {
        case "sentry_gun":
        case "manual_turret":
        case "bradley":
        case "pac_sentry":
        case "juggernaut":
          _id_4C20E5ABF3CE9872 = 1;
          break;
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
        case "nuke":
          _id_AE8EB6D66C120397 = 1;
          break;
        case "directional_uav":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
        case "uav":
          _id_AE8EB6D66C120397 = 1;
          _id_B786822D9A87AB34 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          _id_B786822D9A87AB34 = 1;
          break;
      }

      if(_id_4C20E5ABF3CE9872)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;

      if(_id_AE8EB6D66C120397)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 4;

      if(_id_B786822D9A87AB34)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 16;
    }

    if(isDefined(victim.vehiclename) || _id_B93834C5C289DCDC) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 32;

      if(!_id_4C20E5ABF3CE9872 && isDefined(victim.vehiclename) && !istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;
    }

    if(isDefined(victim.equipmentref))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 64;

    _id_A5958DC7369199C7 = "";
    attacker reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(attacker, victim));
  }
}

vehiclekilled(vehicle, attacker, damage, objweapon) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = vehicle;
  _id_F4692D0892428480 = scripts\cp\cp_equipment::getequipmentreffromweapon(objweapon);

  if(!isDefined(_id_F4692D0892428480))
    _id_F4692D0892428480 = scripts\cp\utility::getdefaultweaponbasename(objweapon.basename);

  _id_6747B178B5FC3B95 = "";

  if(objweapon == attacker.primaryweaponobj)
    _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);
  else if(objweapon == attacker.secondaryweaponobj)
    _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);

  weapons = [_id_F4692D0892428480, _id_6747B178B5FC3B95];
  _id_425D52C81F1883FC = 0;
  _id_425D55C81F188A95 = 0;

  if(isDefined(attacker.modifiers)) {
    _id_425D52C81F1883FC = attacker.modifiers["mask"];
    _id_425D55C81F188A95 = attacker.modifiers["mask2"];
  }

  _id_B6217B906C6BE73E = [attacker _id_12E2FB553EC1605E::lookupcurrentoperator(attacker.team), attacker _id_12E2FB553EC1605E::lookupotheroperator(attacker.team)];

  if(!getdvarint("dvar_78653010D584AA6E")) {
    _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

    if(!isDefined(_id_C8F690457A04A764))
      _id_C8F690457A04A764 = getDvar("g_gametype");

    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
  } else
    _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

  _id_349E390338192305 = "";
  _id_C832CC337856ACA8 = 1;

  if(isDefined(objweapon.attachments)) {
    _id_7208E21EA18240FB = 0;

    foreach(attachment in objweapon.attachments) {
      if(issubstr(attachment, "snprscope"))
        _id_7208E21EA18240FB = 1;

      if(_id_74502A9E0EF1F19C::attachmentisselectable(objweapon, attachment)) {
        if(issubstr(attachment, "snprscope"))
          attachment = "default_sniper_scope";

        if(!_id_C832CC337856ACA8)
          _id_349E390338192305 = _id_349E390338192305 + "|";

        _id_349E390338192305 = _id_349E390338192305 + attachment;
        _id_C832CC337856ACA8 = 0;
      }
    }

    if(_id_7208E21EA18240FB) {
      if(!_id_C832CC337856ACA8)
        _id_349E390338192305 = _id_349E390338192305 + "|";

      _id_349E390338192305 = _id_349E390338192305 + "default_sniper_scope";
    }
  }

  _id_D064B7165A057B5D = "";
  _id_0A4B6D9CAA65995D = 1;

  if(isDefined(attacker.classstruct) && isDefined(attacker.classstruct.loadoutperks)) {
    foreach(perk in attacker.classstruct.loadoutperks) {
      if(!_id_0A4B6D9CAA65995D)
        _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

      _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
      _id_0A4B6D9CAA65995D = 0;
    }
  }

  _id_B5EEC3B49CF346D2 = [damage, 0];
  _id_C5B28F88D9B3BFD7 = 0;

  if(isPlayer(victim))
    _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
  else if(isagent(victim))
    _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

  _id_4C20E5ABF3CE9872 = 0;
  _id_AE8EB6D66C120397 = 0;
  _id_B786822D9A87AB34 = 0;
  _id_B93834C5C289DCDC = 0;

  if(isDefined(victim.streakinfo)) {
    _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 2;
    _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
    _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

    switch (_id_D8061F26B5ECA018) {
      case "sentry_gun":
      case "manual_turret":
      case "bradley":
      case "pac_sentry":
      case "juggernaut":
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "white_phosphorus":
      case "toma_strike":
      case "precision_airstrike":
      case "hover_jet":
      case "gunship":
      case "cruise_predator":
      case "chopper_support":
      case "chopper_gunner":
      case "nuke":
        _id_AE8EB6D66C120397 = 1;
        break;
      case "directional_uav":
      case "radar_drone_overwatch":
      case "scrambler_drone_guard":
      case "uav":
        _id_AE8EB6D66C120397 = 1;
        _id_B786822D9A87AB34 = 1;
        break;
      case "airdrop_multiple":
      case "airdrop":
        _id_B786822D9A87AB34 = 1;
        break;
    }

    if(_id_4C20E5ABF3CE9872)
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;

    if(_id_AE8EB6D66C120397)
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 4;

    if(_id_B786822D9A87AB34)
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 16;
  }

  if(isDefined(victim.vehiclename) || _id_B93834C5C289DCDC) {
    _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 32;

    if(!_id_4C20E5ABF3CE9872 && isDefined(victim.vehiclename) && !istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;
  }

  if(isDefined(victim.equipmentref))
    _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 64;

  _id_A5958DC7369199C7 = "";
  attacker reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(attacker, victim));
}

processfinalkillchallenges(attacker, victim) {}

usedkillstreak(streakname) {}

getoperators() {
  _id_B6217B906C6BE73E = [];
  _id_B6217B906C6BE73E[0] = _id_12E2FB553EC1605E::lookupcurrentoperator(self.team);
  _id_B6217B906C6BE73E[1] = _id_12E2FB553EC1605E::lookupotheroperator(self.team);
  return _id_B6217B906C6BE73E;
}

onplayerkillednew(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, hitloc, modifiers) {
  if(!attacker challengesenabledforplayer()) {
    return;
  }
  victim = self;

  if(!isPlayer(attacker)) {
    if(isDefined(inflictor) && isPlayer(inflictor))
      attacker = inflictor;
    else
      return;
  }

  if(!scripts\cp\utility\player::isfriendly(attacker.team, victim)) {
    _id_F4692D0892428480 = scripts\cp\cp_equipment::getequipmentreffromweapon(objweapon);

    if(!isDefined(_id_F4692D0892428480))
      _id_F4692D0892428480 = scripts\cp\utility::getdefaultweaponbasename(objweapon.basename);

    _id_6747B178B5FC3B95 = "";

    if(isDefined(attacker.secondaryweaponobj)) {
      if(objweapon == attacker.primaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.secondaryweaponobj.basename);
      else if(objweapon == attacker.secondaryweaponobj)
        _id_6747B178B5FC3B95 = scripts\cp\utility::getdefaultweaponbasename(attacker.primaryweaponobj.basename);
    }

    weapons = [_id_F4692D0892428480, _id_6747B178B5FC3B95];
    _id_425D52C81F1883FC = 0;
    _id_425D55C81F188A95 = 0;

    if(isDefined(modifiers)) {
      _id_425D52C81F1883FC = modifiers["mask"];
      _id_425D55C81F188A95 = modifiers["mask2"];
    }

    _id_B6217B906C6BE73E = [attacker _id_12E2FB553EC1605E::lookupcurrentoperator(attacker.team), attacker _id_12E2FB553EC1605E::lookupotheroperator(attacker.team)];

    if(!getdvarint("dvar_78653010D584AA6E")) {
      _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

      if(!isDefined(_id_C8F690457A04A764))
        _id_C8F690457A04A764 = getDvar("g_gametype");

      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[_id_C8F690457A04A764];
    } else
      _id_E37D5A134143CC83 = level.challengeandeventglobals.game_type_col[level._id_62F6F7640E4431E3._id_D20ACAD05758F0D8];

    _id_349E390338192305 = "";
    _id_C832CC337856ACA8 = 1;

    if(isDefined(objweapon.attachments)) {
      _id_7208E21EA18240FB = 0;

      foreach(attachment in objweapon.attachments) {
        if(issubstr(attachment, "snprscope"))
          _id_7208E21EA18240FB = 1;

        if(_id_74502A9E0EF1F19C::attachmentisselectable(objweapon, attachment)) {
          if(!_id_C832CC337856ACA8)
            _id_349E390338192305 = _id_349E390338192305 + "|";

          _id_349E390338192305 = _id_349E390338192305 + attachment;
          _id_C832CC337856ACA8 = 0;
        }
      }

      if(_id_7208E21EA18240FB) {
        if(!_id_C832CC337856ACA8)
          _id_349E390338192305 = _id_349E390338192305 + "|";

        _id_349E390338192305 = _id_349E390338192305 + "default_sniper_scope";
      }
    }

    _id_D064B7165A057B5D = "";
    _id_0A4B6D9CAA65995D = 1;

    if(isDefined(attacker.classstruct) && isDefined(attacker.classstruct.loadoutperks)) {
      foreach(perk in attacker.classstruct.loadoutperks) {
        if(!_id_0A4B6D9CAA65995D)
          _id_D064B7165A057B5D = _id_D064B7165A057B5D + "|";

        _id_D064B7165A057B5D = _id_D064B7165A057B5D + perk;
        _id_0A4B6D9CAA65995D = 0;
      }
    }

    _id_B5EEC3B49CF346D2 = [damage, 0];
    _id_C5B28F88D9B3BFD7 = 0;

    if(isPlayer(victim))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 1;
    else if(isagent(victim))
      _id_C5B28F88D9B3BFD7 = return_enemy_type_mask(_id_C5B28F88D9B3BFD7, victim);

    _id_4C20E5ABF3CE9872 = 0;
    _id_AE8EB6D66C120397 = 0;
    _id_B786822D9A87AB34 = 0;
    _id_B93834C5C289DCDC = 0;

    if(isDefined(victim.streakinfo)) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 2;
      _id_D8061F26B5ECA018 = victim.streakinfo.streakname;
      _id_B93834C5C289DCDC = iskillstreakvehicle(_id_D8061F26B5ECA018);

      switch (_id_D8061F26B5ECA018) {
        case "sentry_gun":
        case "manual_turret":
        case "bradley":
        case "pac_sentry":
        case "juggernaut":
          _id_4C20E5ABF3CE9872 = 1;
          break;
        case "white_phosphorus":
        case "toma_strike":
        case "precision_airstrike":
        case "hover_jet":
        case "gunship":
        case "cruise_predator":
        case "chopper_support":
        case "chopper_gunner":
        case "nuke":
          _id_AE8EB6D66C120397 = 1;
          break;
        case "directional_uav":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
        case "uav":
          _id_AE8EB6D66C120397 = 1;
          _id_B786822D9A87AB34 = 1;
          break;
        case "airdrop_multiple":
        case "airdrop":
          _id_B786822D9A87AB34 = 1;
          break;
      }

      if(_id_4C20E5ABF3CE9872)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;

      if(_id_AE8EB6D66C120397)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 4;

      if(_id_B786822D9A87AB34)
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 16;
    }

    if(isDefined(victim.vehiclename) || _id_B93834C5C289DCDC) {
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 32;

      if(!_id_4C20E5ABF3CE9872 && isDefined(victim.vehiclename) && !istrue(victim scripts\cp_mp\vehicles\vehicle::vehiclecanfly()))
        _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 8;
    }

    if(isDefined(victim.equipmentref))
      _id_C5B28F88D9B3BFD7 = _id_C5B28F88D9B3BFD7 | 64;

    _id_A5958DC7369199C7 = "";
    attacker reportchallengeuserevent("kill", _id_B5EEC3B49CF346D2, weapons, _id_425D52C81F1883FC, _id_425D55C81F188A95, _id_B6217B906C6BE73E, _id_E37D5A134143CC83, _id_349E390338192305, _id_D064B7165A057B5D, _id_C5B28F88D9B3BFD7, _id_A5958DC7369199C7, gettouchinglocaletriggers(attacker, victim));
  }
}