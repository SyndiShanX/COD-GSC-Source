/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\gas_grenade.gsc
************************************************/

gas_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  team = grenade.owner.team;
  scripts\mp\utility\print::printgameaction("gasGrenade spawn", grenade.owner);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  thread gas_watchexplode(grenade, team);
  thread _id_60397906A6EB5A4F(grenade);
}

gas_watchexplode(grenade, team) {
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  owner = grenade.owner;
  grenade waittill("explode", position);
  duration = getdvarfloat("dvar_6CF4A762721DE876", 7);
  thread gas_createtrigger(position, owner, team, duration);
}

_id_60397906A6EB5A4F(grenade) {
  grenade endon("explode");
  grenade waittill("missile_water_impact", _id_7842E9E94384087B);
  grenade notify("end_explode");
  thread _id_DA09131C75AD4B63(grenade);
}

_id_DA09131C75AD4B63(grenade) {
  grenade waittill("missile_stuck", _id_A681B7890CD017C7);
  owner = grenade.owner;
  team = grenade.team;
  position = grenade.origin;
  grenade thread gas_createtrigger(position + (0, 0, 10), owner, team);
}

gas_onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  if(data.attacker == data.victim) {
    if(distancesquared(data.point, data.victim.origin) > 30625)
      return 0;
  } else if(isPlayer(data.attacker)) {
    data.attacker scripts\mp\damage::combatrecordtacticalstat("equip_gas_grenade");
    data.attacker scripts\mp\utility\stats::incpersstat("gasHits", 1);
    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_gas_grenade", data.attacker, undefined, 1);

    if(data.victim scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist"))
      data.attacker _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
  }

  if(data.attacker != data.victim && !istrue(data.attacker.iszombie))
    data.attacker _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "gasGrenadeHit");

  data.victim thread gas_applycough(data.attacker, 1);
  return 1;
}

gas_clear(_id_FCEF8D217A441961) {
  gas_clearspeedredux(_id_FCEF8D217A441961);
  gas_clearblur(_id_FCEF8D217A441961);
  gas_clearcough(_id_FCEF8D217A441961);

  if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(!isDefined(trigger)) {
        continue;
      }
      trigger.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

gas_createtrigger(position, owner, team, duration, scale) {
  if(!isDefined(position)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onGasGrenadeExplode"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onGasGrenadeExplode")]](position, owner, team);

  if(!isDefined(duration))
    duration = 7;

  if(!isDefined(scale))
    scale = 1;

  if(getdvarint("mgl", 0))
    thread scripts\common\ai::_id_F8903387EA945165(position, 0);

  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 0, int(256 * scale), int(175 * scale));
  trigger scripts\cp_mp\ent_manager::registerspawn(1, ::sweepgas);
  badplace = createnavbadplacebybounds(position + (0, 0, int(-57.75 * scale)), (int(256 * scale), int(256 * scale), int(175 * scale)), (0, 0, 0));
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.playersintrigger = [];
  trigger._id_AEECA2BC23F59EA4 = [];
  trigger.badplace = badplace;
  trigger thread gas_watchtriggerenter();
  trigger thread gas_watchtriggerexit();
  wait(duration);
  trigger thread gas_destroytrigger();
}

sweepgas() {
  thread gas_destroytrigger();
}

gas_destroytrigger() {
  foreach(player in self.playersintrigger) {
    if(!isDefined(player)) {
      continue;
    }
    self.playersintrigger[player getentitynumber()] = undefined;
    player thread gas_onexittrigger(self getentitynumber());
  }

  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self.badplace))
    destroynavobstacle(self.badplace);

  self delete();
}

gas_onentertrigger(trigger) {
  if(!isDefined(self.gastriggerstouching))
    self.gastriggerstouching = [];

  entnum = trigger getentitynumber();
  self.gastriggerstouching[entnum] = trigger;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size >= 1) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }

  if(self.gastriggerstouching.size == 1) {
    thread gas_applycough(trigger.owner, 0);
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  scripts\mp\utility\player::_id_8B23D28B1D38CB39("gas", -1);
  return entnum;
}

gas_onexittrigger(_id_B2907A4520674F1A) {
  if(!isDefined(self.gastriggerstouching)) {
    return;
  }
  self.gastriggerstouching[_id_B2907A4520674F1A] = undefined;
  self.lastgastouchtime = gettime();

  if(self.gastriggerstouching.size == 0) {
    scripts\mp\utility\player::_id_8B23D28B1D38CB39("gas", 0);
    thread gas_removespeedredux();
    thread gas_removeblur();
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    self notify("gas_exited");
  }
}

gas_watchtriggerenter() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isDefined(player)) {
      continue;
    }
    if(istrue(player._id_F8E21465665E3F81)) {
      continue;
    }
    if(!isPlayer(player)) {
      if(isagent(player)) {
        if(!scripts\engine\utility::array_contains(self._id_AEECA2BC23F59EA4, player) || isDefined(player.flashendtime) && player.flashendtime < gettime()) {
          self._id_AEECA2BC23F59EA4[self._id_AEECA2BC23F59EA4.size] = player;

          if(isDefined(player._id_65771500F49956C1) && player._id_65771500F49956C1) {
            continue;
          }
          player notify("flashbang", player.origin, 1, 1, self.owner, "axis", 9);
        }
      }

      continue;
    }

    if(player scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }
    if(_id_DA8A31143B88E833(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }
    if(level.teambased) {
      if(isDefined(self.owner) && isalive(self.owner)) {
        if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))
          continue;
      } else if(scripts\mp\utility\player::isfriendly(self.team, player))
        continue;
    }

    self.playersintrigger[player getentitynumber()] = player;
    player thread gas_onentertrigger(self);
  }
}

gas_watchtriggerexit() {
  self endon("death");

  for(;;) {
    foreach(id, player in self.playersintrigger) {
      if(!isDefined(player)) {
        self.playersintrigger[id] = undefined;
        continue;
      }

      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(player istouching(self) && !_id_DA8A31143B88E833(player)) {
        continue;
      }
      self.playersintrigger[player getentitynumber()] = undefined;
      player thread gas_onexittrigger(self getentitynumber());
    }

    waitframe();
  }
}

_id_DA8A31143B88E833(player) {
  if(player _meth_7EE20CF3C0390E21())
    return 1;

  return 0;
}

gas_applycough(attacker, _id_E81764066EB9BACB) {
  _id_A15FFAC7E41222A2 = scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist");
  _id_8907F741F3A7B3F7 = isDefined(attacker) && self == attacker;

  if(!_id_8907F741F3A7B3F7 && _id_A15FFAC7E41222A2) {
    return;
  }
  if(istrue(self._id_F8E21465665E3F81)) {
    return;
  }
  _id_DD1CF0B2B3066ED4 = 0;

  if(istrue(_id_E81764066EB9BACB)) {
    _id_DD1CF0B2B3066ED4 = 1;

    if(_id_8907F741F3A7B3F7)
      _id_DD1CF0B2B3066ED4 = 0;
  }

  if(!istrue(self.gascoughinprogress) || istrue(_id_E81764066EB9BACB))
    thread gas_queuecough(_id_DD1CF0B2B3066ED4);
}

gas_queuecough(_id_DD1CF0B2B3066ED4) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self endon("gas_exited");
  self notify("gas_queue_cough");
  self endon("gas_queue_cough");
  _id_FFF525B27A42FC40 = gettime() + 1000;

  while(gas_coughisblocked())
    waitframe();

  if(_id_DD1CF0B2B3066ED4 && gettime() > _id_FFF525B27A42FC40)
    _id_DD1CF0B2B3066ED4 = 0;

  _id_81B4070B5858078D = getdvarint("dvar_0827901421AD0679", 1) == 1;

  if(_id_81B4070B5858078D)
    thread gas_begincoughing(_id_DD1CF0B2B3066ED4);
  else {
    self endon("gas_begin_coughing");
    self.gascoughinprogress = 1;

    if(_id_DD1CF0B2B3066ED4) {
      self playgestureviewmodel("iw9_ges_gas_cough_long");
      wait 3.33;
    } else {
      self playgestureviewmodel("iw9_ges_gas_cough");
      wait 1.833;
    }

    self.gascoughinprogress = undefined;
  }
}

gas_begincoughing(_id_DD1CF0B2B3066ED4) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self notify("gas_begin_coughing");
  self endon("gas_begin_coughing");

  if(!isnullweapon(self getheldoffhand()))
    childthread gas_takeheldoffhand();

  self.gascoughinprogress = 1;

  if(self hasweapon(makeweapon("gas_cough_light_mp")))
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_light_mp");

  if(self hasweapon(makeweapon("gas_cough_heavy_mp")))
    scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_heavy_mp");

  weaponobj = scripts\engine\utility::ter_op(istrue(_id_DD1CF0B2B3066ED4), makeweapon("gas_cough_heavy_mp"), makeweapon("gas_cough_light_mp"));
  duration = scripts\engine\utility::ter_op(istrue(_id_DD1CF0B2B3066ED4), 3.33, 1.833);
  _id_3B64EB40368C1450::set("gas_grenade", "supers", 0);
  self giveandfireoffhand(weaponobj);
  childthread gas_monitorcoughweaponfired(weaponobj);
  childthread gas_monitorcoughweapontaken(weaponobj);
  childthread gas_monitorcoughduration(duration);
  scripts\engine\utility::waittill_any_3("gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration");
  _id_3B64EB40368C1450::_id_462E6336A0DC84A8("gas_grenade", "supers");

  if(self hasweapon(weaponobj))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(weaponobj);

  self.gascoughinprogress = undefined;
}

gas_removecough(_id_FCEF8D217A441961) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(_id_FCEF8D217A441961)) {
    if(isDefined(self.gastakenweaponobj))
      gas_restoreheldoffhand();
  }
}

gas_clearcough(_id_FCEF8D217A441961) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self.gascoughinprogress = undefined;

  if(!istrue(_id_FCEF8D217A441961)) {
    _id_81B4070B5858078D = getdvarint("dvar_0827901421AD0679", 1) == 1;

    if(_id_81B4070B5858078D) {
      if(self hasweapon(makeweapon("gas_cough_light_mp")))
        scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_light_mp");

      if(self hasweapon(makeweapon("gas_cough_heavy_mp")))
        scripts\cp_mp\utility\inventory_utility::_takeweapon("gas_cough_heavy_mp");

      if(isDefined(self.gastakenweaponobj))
        gas_restoreheldoffhand();
    } else {
      self stopgestureviewmodel("iw9_ges_gas_cough");
      self stopgestureviewmodel("iw9_ges_gas_cough_long");
    }
  }
}

gas_monitorcoughweaponfired(_id_33F644489E4F15AE) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  for(;;) {
    self waittill("offhand_fired", weaponobj);

    if(issameweapon(weaponobj, _id_33F644489E4F15AE)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

gas_monitorcoughweapontaken(_id_33F644489E4F15AE) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(_id_33F644489E4F15AE))
    waitframe();

  self notify("gas_coughWeaponTaken");
}

gas_monitorcoughduration(_id_DC7D7DB6D1535605) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughWeaponFired");
  wait(_id_DC7D7DB6D1535605);
  self notify("gas_coughDuration");
}

gas_takeheldoffhand() {
  if(isDefined(self.gastakenweaponobj))
    gas_restoreheldoffhand();

  self endon("gas_restoreHeldOffhand");
  self.gastakenweaponobj = self getheldoffhand();
  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && scripts\mp\equipment::hasequipment(equipmentref)) {
    self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(equipmentref);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    wait 0.05;
    thread gas_restoreheldoffhand();
  }

  _id_EBEC497FF8B18A45 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(_id_EBEC497FF8B18A45)) {
    _id_75630A54FF140EC2 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(_id_75630A54FF140EC2) && _id_75630A54FF140EC2 == _id_EBEC497FF8B18A45) {
      self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
      wait 0.05;
      thread gas_restoreheldoffhand();
    }
  }

  isgesture = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    wait 0.05;
    thread gas_restoreheldoffhand();
  }

  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
  wait 0.05;
  thread gas_restoreheldoffhand();
}

gas_restoreheldoffhand() {
  self notify("gas_restoreHeldOffhand");
  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && scripts\mp\equipment::hasequipment(equipmentref)) {
    if(scripts\mp\equipment::hasequipment(equipmentref)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      slot = scripts\mp\equipment::findequipmentslot(equipmentref);

      if(slot == "primary")
        self assignweaponoffhandprimary(self.gastakenweaponobj);
      else if(slot == "secondary")
        self assignweaponoffhandsecondary(self.gastakenweaponobj);

      scripts\mp\equipment::setequipmentammo(equipmentref, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  _id_EBEC497FF8B18A45 = scripts\mp\supers::getsuperrefforsuperoffhand(self.gastakenweaponobj);

  if(isDefined(_id_EBEC497FF8B18A45)) {
    _id_75630A54FF140EC2 = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(_id_75630A54FF140EC2) && _id_75630A54FF140EC2 == _id_EBEC497FF8B18A45) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self assignweaponoffhandspecial(self.gastakenweaponobj);
      self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
      self.gastakenweaponobj = undefined;
      self.gastakenweaponammo = undefined;
    }

    return;
  }

  isgesture = scripts\mp\utility\weapon::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    if(isDefined(self.gestureweapon) && self.gestureweapon == self.gastakenweaponobj.basename) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self.gastakenweaponobj = undefined;
    }

    return;
  }

  _id_869D09B2FFBC5A27 = scripts\mp\supers::_id_A465412785D4C550(self.gastakenweaponobj);

  if(_id_869D09B2FFBC5A27) {
    self.gastakenweaponobj = undefined;
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
  self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
  self.gastakenweaponobj = undefined;
  self.gastakenweaponammo = undefined;
}

gas_applyspeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(isDefined(self.gasspeedmod)) {
    if(self.gasspeedmod < -0.15) {
      if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
        scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_tac_resist");
        self.gasspeedmod = -0.15;
        scripts\mp\weapons::updatemovespeedscale();
        return;
      }

      if(isDefined(self.gastriggerstouching)) {
        foreach(trigger in self.gastriggerstouching) {
          if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
            self.gasspeedmod = -0.15;
            scripts\mp\weapons::updatemovespeedscale();
            return;
          }
        }
      }
    }
  } else
    self.gasspeedmod = 0;

  _id_D255A8B6D0EF299D = -0.35;

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist"))
    _id_D255A8B6D0EF299D = -0.15;
  else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self)
        _id_D255A8B6D0EF299D = -0.15;
    }
  }

  gas_modifyspeed(_id_D255A8B6D0EF299D);
  self.gasspeedmod = _id_D255A8B6D0EF299D;
  scripts\mp\weapons::updatemovespeedscale();
}

gas_removespeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(!isDefined(self.gasspeedmod)) {
    return;
  }
  gas_modifyspeed(0);
  self.gasspeedmod = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

gas_modifyspeed(_id_D255A8B6D0EF299D) {
  timeelapsed = 0;

  while(timeelapsed <= 0.65) {
    timeelapsed = timeelapsed + 0.05;
    self.gasspeedmod = scripts\engine\math::lerp(self.gasspeedmod, _id_D255A8B6D0EF299D, min(1, timeelapsed / 0.65));
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.05;
  }
}

gas_clearspeedredux(_id_FCEF8D217A441961) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(_id_FCEF8D217A441961))
    scripts\mp\weapons::updatemovespeedscale();
}

gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  _id_22F87C8BF7C4616B = "gas_grenade_heavy_mp";

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist"))
    _id_22F87C8BF7C4616B = "gas_grenade_light_mp";
  else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self)
        _id_22F87C8BF7C4616B = "gas_grenade_light_mp";
    }
  }

  for(;;) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock(_id_22F87C8BF7C4616B, "gas", 0.5, 0);
    wait 0.2;
  }
}

gas_removeblur() {
  self notify("gas_modify_blur");
}

gas_clearblur(_id_FCEF8D217A441961) {
  self notify("gas_modify_blur");

  if(!istrue(_id_FCEF8D217A441961))
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
}

gas_shouldtakeheldoffhand() {
  switch (self getheldoffhand().basename) {
    case "super_delay_mp":
      return 0;
    default:
      return 1;
  }

  return 0;
}

gas_coughisblocked() {
  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("cough_gesture"))
    return 1;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("offhand_weapons"))
    return 1;

  if(!isnullweapon(self getheldoffhand()) && !gas_shouldtakeheldoffhand())
    return 1;

  return 0;
}

gas_isintrigger() {
  if(!isDefined(self.gastriggerstouching))
    return 0;

  if(self.gastriggerstouching.size == 0)
    return 0;

  return 1;
}

gas_updateplayereffects() {
  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    gas_clear();
    return;
  }

  if(gas_isintrigger()) {
    thread gas_applyspeedredux();
    thread gas_applyblur();
  }
}

gas_getblurinterruptdelayms(duration) {
  return 200.0;
}