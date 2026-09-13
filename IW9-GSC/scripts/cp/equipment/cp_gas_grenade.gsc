/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_gas_grenade.gsc
***************************************************/

gas_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  team = grenade.owner.team;
  thread gas_watchexplode(grenade, team);
  thread _id_60397906A6EB5A4F(grenade);
}

gas_watchexplode(grenade, team) {
  grenade thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  grenade endon("end_explode");
  owner = undefined;

  if(isDefined(grenade.owner))
    owner = grenade.owner;

  grenade waittill("explode", position);
  thread gas_createtrigger(position, owner, team);
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
  } else {}

  if(data.attacker != data.victim) {}

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
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onGasGrenadeExplode"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onGasGrenadeExplode")]](position, owner, team);

  if(!isDefined(duration))
    duration = 7;

  if(isDefined(level._id_3F0D398EA9B0E906))
    duration = level._id_3F0D398EA9B0E906;

  if(!isDefined(scale))
    scale = 1;

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
  trigger thread gas_badplace(duration, scale);
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

  if(isPlayer(self)) {
    if(self.gastriggerstouching.size >= 1) {
      thread gas_applyspeedredux();
      thread gas_applyblur();
    }

    if(self.gastriggerstouching.size == 1) {
      thread gas_applycough(trigger.owner, 0);
      scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();

      if(isDefined(level._id_128B1F12D77A7EEB))
        self[[level._id_128B1F12D77A7EEB]](trigger);
    }
  } else {
    if(istrue(self._id_4438D881D79DF85B))
      return entnum;

    _id_DE88CD14114C1E24 = makeweapon("gas_mp");
    self dodamage(1, self.origin, trigger.owner, trigger, "MOD_GRENADE_SPLASH", _id_DE88CD14114C1E24);
    self notify("flashbang", self.origin, 1, 1, trigger.owner, "axis", 9);
  }

  return entnum;
}

gas_onexittrigger(_id_B2907A4520674F1A) {
  if(!isDefined(self.gastriggerstouching)) {
    return;
  }
  self.gastriggerstouching[_id_B2907A4520674F1A] = undefined;
  self.lastgastouchtime = gettime();

  if(isPlayer(self)) {
    if(self.gastriggerstouching.size == 0) {
      thread gas_removespeedredux();
      thread gas_removeblur();
      scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
    }
  } else {}

  self notify("gas_exited");
}

gas_watchtriggerenter() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player) && !isagent(player)) {
      continue;
    }
    if(istrue(player.isjuggernaut)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }
    if(isDefined(self.owner) && isalive(self.owner)) {
      if(player != self.owner && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner)))
        continue;
    } else
      continue;

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

gas_badplace(duration, scale) {
  if(!isDefined(self)) {
    return;
  }
  _id_E786FA50656BC2FF = 0.66;
  _id_537D92090ED07C1E = duration * 0.15;
  _id_B98C5B49ED782FE5 = duration * 0.25;
  wait(_id_537D92090ED07C1E);
  _id_F369D822D2AF09E5 = 256 * scale * _id_E786FA50656BC2FF;
  _id_DBDBAD4A509C08E8 = 175 * scale * _id_E786FA50656BC2FF;
  _id_48E1C3E32A05C3BF = (0, 0, 0);
  navobstacle = createnavbadplacebyshape(self.origin, _id_48E1C3E32A05C3BF, 8, _id_F369D822D2AF09E5, _id_DBDBAD4A509C08E8);
  wait(max(0.05, duration - _id_537D92090ED07C1E - _id_B98C5B49ED782FE5));

  if(isDefined(navobstacle))
    destroynavobstacle(navobstacle);
}

gas_applycough(attacker, _id_E81764066EB9BACB) {
  _id_A15FFAC7E41222A2 = scripts\cp\utility::_hasperk("specialty_gas_grenade_resist");
  _id_8907F741F3A7B3F7 = isDefined(attacker) && self == attacker;

  if(!_id_8907F741F3A7B3F7 && _id_A15FFAC7E41222A2) {
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
  self giveandfireoffhand(weaponobj);
  childthread gas_monitorcoughweaponfired(weaponobj);
  childthread gas_monitorcoughweapontaken(weaponobj);
  childthread gas_monitorcoughduration(duration);
  scripts\engine\utility::waittill_any_3("gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration");

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
  equipmentref = _id_7EF95BBA57DC4B82::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && _id_7EF95BBA57DC4B82::hasequipment(equipmentref)) {
    self.gastakenweaponammo = _id_7EF95BBA57DC4B82::getequipmentammo(equipmentref);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  isgesture = scripts\cp\utility::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
    waitframe();
    thread gas_restoreheldoffhand();
  }

  self.gastakenweaponammo = self getammocount(self.gastakenweaponobj);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gastakenweaponobj);
  waitframe();
  thread gas_restoreheldoffhand();
}

gas_restoreheldoffhand() {
  self notify("gas_restoreHeldOffhand");
  equipmentref = _id_7EF95BBA57DC4B82::getequipmentreffromweapon(self.gastakenweaponobj);

  if(isDefined(equipmentref) && _id_7EF95BBA57DC4B82::hasequipment(equipmentref)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
    slot = _id_7EF95BBA57DC4B82::findequipmentslot(equipmentref);

    if(slot == "primary")
      self assignweaponoffhandprimary(self.gastakenweaponobj);
    else if(slot == "secondary")
      self assignweaponoffhandsecondary(self.gastakenweaponobj);

    _id_7EF95BBA57DC4B82::setequipmentammo(equipmentref, self.gastakenweaponammo);
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
    return;
  }

  isgesture = scripts\cp\utility::isgesture(self.gastakenweaponobj);

  if(isgesture) {
    if(isDefined(self.gestureweapon) && self.gestureweapon == self.gastakenweaponobj.basename) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
      self.gastakenweaponobj = undefined;
    }

    return;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.gastakenweaponobj);
  self setweaponammoclip(self.gastakenweaponobj, self.gastakenweaponammo);
  self.gastakenweaponobj = undefined;
  self.gastakenweaponammo = undefined;
}

get_power_ref_from_weapon(objweapon) {
  ref = objweapon.basename;

  foreach(key, struct in level.powers) {
    if(isDefined(struct.weaponuse)) {
      if(ref == struct.weaponuse)
        return key;
    }
  }

  return undefined;
}

gas_applyspeedredux() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(isDefined(self.gasspeedmod)) {
    if(self.gasspeedmod < -0.15) {
      if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist")) {
        self.gasspeedmod = -0.15;
        self[[level.move_speed_scale]]();
        return;
      }

      if(isDefined(self.gastriggerstouching)) {
        foreach(trigger in self.gastriggerstouching) {
          if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
            self.gasspeedmod = -0.15;
            self[[level.move_speed_scale]]();
            return;
          }
        }
      }
    }
  } else
    self.gasspeedmod = 0;

  _id_D255A8B6D0EF299D = -0.35;

  if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist"))
    _id_D255A8B6D0EF299D = -0.15;
  else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self)
        _id_D255A8B6D0EF299D = -0.15;
    }
  }

  gas_modifyspeed(_id_D255A8B6D0EF299D);
  self.gasspeedmod = _id_D255A8B6D0EF299D;
  self[[level.move_speed_scale]]();
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
  self[[level.move_speed_scale]]();
}

gas_modifyspeed(_id_D255A8B6D0EF299D) {
  timeelapsed = 0;

  while(timeelapsed <= 0.65) {
    timeelapsed = timeelapsed + 0.05;
    self.gasspeedmod = scripts\engine\math::lerp(self.gasspeedmod, _id_D255A8B6D0EF299D, min(1, timeelapsed / 0.65));
    self[[level.move_speed_scale]]();
    wait 0.05;
  }
}

gas_clearspeedredux(_id_FCEF8D217A441961) {
  self notify("gas_modify_speed");
  self.gasspeedmod = undefined;

  if(!istrue(_id_FCEF8D217A441961))
    self[[level.move_speed_scale]]();
}

gas_applyblur() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  _id_22F87C8BF7C4616B = "gas_grenade_heavy_mp";

  if(scripts\cp\utility::_hasperk("specialty_gas_grenade_resist"))
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
  if(istrue(self.isjuggernaut)) {
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