/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agent_damage.gsc
***********************************************/

register_ai_damage_callbacks() {
  level.agent_funcs["soldier_agent"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0;
  level.agent_funcs["soldier_agent"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier_agent"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["soldier"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0;
  level.agent_funcs["soldier"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["civilian"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0;
  level.agent_funcs["civilian"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["civilian"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut_agent"]["on_damaged"] = _id_47FC06D4BB326007::_id_1AB798A528080DB2;
  level.agent_funcs["juggernaut_agent"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut_agent"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut"]["on_damaged"] = _id_47FC06D4BB326007::_id_1AB798A528080DB2;
  level.agent_funcs["juggernaut"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["suicidebomber"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0;
  level.agent_funcs["suicidebomber"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["suicidebomber"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["dog"]["on_damaged"] = _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0;
  level.agent_funcs["dog"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["dog"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "handleDamageFeedback", _id_354C862768CFE202::_id_04E514DCD8E549D1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "agentPers_getAgentPersData", _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai_mp_controller", "agentPers_setAgentPersData", _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE);
}

_id_0F06B8EBF23E5F9F(shitloc) {
  if(shitloc == "shield")
    return 0;

  return 1;
}

process_events_and_challenges_on_death(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_E851FFA44B7E0D54 = self;
  _id_E851FFA44B7E0D54 endon("death");

  if(!isPlayer(eattacker)) {
    if(isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner))
      eattacker = eattacker.owner;
    else
      return;
  }

  if(!_id_0F06B8EBF23E5F9F(shitloc)) {
    return;
  }
  if(idamage >= _id_E851FFA44B7E0D54.health) {
    if(isDefined(eattacker.longdeathtracker) && eattacker.longdeathtracker.size > 0) {
      if(istrue(eattacker.longdeathtracker[_id_E851FFA44B7E0D54 getentitynumber()]))
        return;
    }

    eattacker thread _id_293BC33BD79CABD1::killedenemy(undefined, _id_E851FFA44B7E0D54, objweapon, smeansofdeath, einflictor, 0, shitloc);
    _id_E851FFA44B7E0D54 thread scripts\cp\cp_challenge::onplayerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, shitloc, eattacker.modifiers);
  }
}

adjust_damage_based_on_weaponclass(idamage, sweapon, weaponclass, type, attacker) {
  _id_702BFC08FABD86CB = idamage;

  switch (weaponclass) {
    case "rifle":
      _id_702BFC08FABD86CB = min(idamage, 84);
      break;
    case "smg":
      _id_702BFC08FABD86CB = min(idamage, 110);
      break;
    case "mg":
      _id_702BFC08FABD86CB = min(idamage, 105);
      break;
    case "spread":
      _id_702BFC08FABD86CB = min(idamage, 84);
      break;
    case "pistol":
      _id_702BFC08FABD86CB = min(idamage, 75);
      break;
    case "sniper":
      _id_702BFC08FABD86CB = min(idamage, 130);
      break;
    default:
      _id_702BFC08FABD86CB = idamage;
      break;
  }

  return idamage;
}

is_exploder() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

check_for_damage_scalar_change() {
  level endon("game_ended");
  level.bullet_damage_scalar = 1;

  for(;;) {
    _id_B79930868F410231 = getdvarfloat("dvar_2FB4F33570E8AB26", 1.0);

    if(level.bullet_damage_scalar != _id_B79930868F410231)
      level.bullet_damage_scalar = _id_B79930868F410231;

    wait 1;
  }
}

register_ai_drop_funcs() {
  register_drop_func("weapon", ::drop_weapon_func, ::should_drop_weapon, 0);
}

register_drop_func(_id_3D4263CA1AB2CC7A, func, chance_func, delay_time) {
  if(!isDefined(level.ai_drop_info))
    level.ai_drop_info = [];

  struct = spawnStruct();
  struct.name = _id_3D4263CA1AB2CC7A;
  struct.chance_func = chance_func;
  struct.func = func;
  struct.score = 0;
  struct.delay = delay_time;
  struct.next_chance = 0;
  level.ai_drop_info[level.ai_drop_info.size] = struct;
}

ai_drop_func(_id_4D8D96D547DF2E9F) {
  if(!isDefined(level.ai_drop_info)) {
    return;
  }
  if(isDefined(level.updatedroprelicsfunc))
    [[level.updatedroprelicsfunc]](self.origin, _id_4D8D96D547DF2E9F);

  if(isDefined(self.force_drop)) {
    func = get_func_by_name(self.force_drop);
    self thread[[func]](_id_4D8D96D547DF2E9F);
  } else
    _id_5C0ED12BDB833AD9 = check_for_drop(_id_4D8D96D547DF2E9F);
}

get_func_by_name(_id_3D4263CA1AB2CC7A) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ai_drop_info.size; _id_AC0E594AC96AA3A8++) {
    if(level.ai_drop_info[_id_AC0E594AC96AA3A8].name == _id_3D4263CA1AB2CC7A)
      return level.ai_drop_info[_id_AC0E594AC96AA3A8].func;
  }
}

drop_ready_item(_id_B681301677CF6180, _id_4D8D96D547DF2E9F) {
  _id_4FB72B720667636B = gettime();
  self thread[[_id_B681301677CF6180.func]](_id_4D8D96D547DF2E9F);
  _id_B681301677CF6180.score = 0;
  _id_B681301677CF6180.next_chance = _id_4FB72B720667636B + _id_B681301677CF6180.delay * 1000;
}

check_for_drop(_id_4D8D96D547DF2E9F) {
  _id_4FB72B720667636B = gettime();
  _id_5C0ED12BDB833AD9 = 0;
  _id_8001E3B53133F6DD = scripts\engine\utility::array_randomize(level.ai_drop_info);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8001E3B53133F6DD.size; _id_AC0E594AC96AA3A8++) {
    _id_B681301677CF6180 = _id_8001E3B53133F6DD[_id_AC0E594AC96AA3A8];

    if(!_id_5C0ED12BDB833AD9) {
      if(_id_4FB72B720667636B > _id_B681301677CF6180.next_chance) {
        if(_id_B681301677CF6180.score > 99) {
          drop_ready_item(_id_B681301677CF6180, _id_4D8D96D547DF2E9F);
          _id_5C0ED12BDB833AD9 = 1;
          continue;
        }

        if([[_id_B681301677CF6180.chance_func]](_id_4D8D96D547DF2E9F)) {
          drop_ready_item(_id_B681301677CF6180, _id_4D8D96D547DF2E9F);
          _id_5C0ED12BDB833AD9 = 1;
        }
      }
    }
  }

  return _id_5C0ED12BDB833AD9;
}

drop_weapon_func(_id_4D8D96D547DF2E9F) {
  if(!istrue(_id_4D8D96D547DF2E9F.eattacker.no_enemy_weapon_drops))
    self.dropweapon = 1;

  if(istrue(level._id_624BA233506A543E))
    self.dropweapon = 0;

  if(istrue(self._id_CED8415AAAD3FF6D))
    self.dropweapon = 1;

  if(!isPlayer(_id_4D8D96D547DF2E9F.eattacker)) {
    return;
  }
  if(getdvarint("dvar_386D724E52893AC9"))
    self.dropweapon = 0;

  if(isDefined(_id_4D8D96D547DF2E9F.eattacker.class) && _id_4D8D96D547DF2E9F.eattacker.class == "crusader" || isDefined(level.ai_dropgren_override_hide)) {
    if(should_drop_grenade_pickup(_id_4D8D96D547DF2E9F.eattacker))
      drop_grenade(_id_4D8D96D547DF2E9F);
  }

  if(_id_4D8D96D547DF2E9F.eattacker scripts\cp\utility::_hasperk("specialty_scavenger")) {
    if(should_drop_scavenger_bag(_id_4D8D96D547DF2E9F.eattacker)) {
      org = self.origin - (10, 10, 0);
      drop_scavenger_bag(_id_4D8D96D547DF2E9F, org);
    }
  }
}

should_drop_scavenger_bag(player) {
  if(isDefined(self.chute))
    return 0;

  if(!self isonground())
    return 0;

  if(isDefined(self.ridingvehicle))
    return 0;

  if(!isDefined(player.last_bag_drop_time)) {
    player.last_bag_drop_time = gettime();
    return 1;
  }

  _id_3C3F83B87D62B244 = 10000;
  _id_FFA1FAA3C8A198AA = gettime() - player.last_bag_drop_time;

  if(_id_FFA1FAA3C8A198AA > _id_3C3F83B87D62B244) {
    player.last_bag_drop_time = gettime();
    return 1;
  }

  return 0;
}

drop_scavenger_bag(_id_4D8D96D547DF2E9F, _id_165B8600CF984332) {
  loc = self.origin;

  if(isDefined(_id_165B8600CF984332))
    loc = _id_165B8600CF984332;

  _id_44CBAEE7CD9E94C3 = spawn("script_model", loc);
  _id_44CBAEE7CD9E94C3 thread activate_scavenger_bag(_id_4D8D96D547DF2E9F.eattacker);
}

activate_scavenger_bag(_id_9401EB9DD9E3163B) {
  self endon("death");

  foreach(_id_B212D40302E8388D in level.players) {
    if(_id_B212D40302E8388D != _id_9401EB9DD9E3163B)
      self hidefromplayer(_id_B212D40302E8388D);
  }

  self setModel("equipment_scavenger_bag");
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 10);
  thread scripts\cp\utility::delayentdelete(20);
  self.trigger thread scripts\cp\utility::delayentdelete(20);

  for(;;) {
    self.trigger waittill("trigger", player);

    if(player == _id_9401EB9DD9E3163B) {
      player playlocalsound("weap_ammo_pickup");
      player give_ammo_to_stock();
      player thread _id_354C862768CFE202::hudicontype("scavenger");
      self.trigger delete();
      self delete();
    }
  }
}

give_clip_of_ammo() {
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(weapon) == "riotshield") {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(weapon)) {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_launcher(weapon)) {
      continue;
    }
    if(cangive_ammo()) {
      _id_A153D989920D03BC = self getweaponammoclip(weapon);
      _id_02422F12C129670C = self getweaponammostock(weapon);
      _id_7FC9076882EE98FF = weaponclipsize(weapon);
      _id_DEAB3AF8D6303B6C = _id_A153D989920D03BC + _id_02422F12C129670C + _id_7FC9076882EE98FF;

      if(_id_DEAB3AF8D6303B6C == _id_7FC9076882EE98FF)
        self setweaponammoclip(weapon, _id_DEAB3AF8D6303B6C);
      else {
        self setweaponammoclip(weapon, _id_7FC9076882EE98FF);
        _id_7D676154ADB1E7A8 = _id_DEAB3AF8D6303B6C - _id_7FC9076882EE98FF;
        self setweaponammostock(weapon, _id_7D676154ADB1E7A8);
      }
    }
  }
}

give_ammo_to_stock() {
  _id_6E98D61FBAD956E0 = 30;
  _id_CFDAE360ABFE2A6D = 0;
  weapon = self getcurrentprimaryweapon();

  if(!scripts\cp\utility::is_valid_player())
    _id_CFDAE360ABFE2A6D = 1;

  if(weapontype(weapon) == "riotshield")
    _id_CFDAE360ABFE2A6D = 1;

  if(_id_74502A9E0EF1F19C::is_incompatible_weapon(weapon))
    _id_CFDAE360ABFE2A6D = 1;

  if(_id_74502A9E0EF1F19C::is_launcher(weapon))
    _id_CFDAE360ABFE2A6D = 1;

  if(!_id_CFDAE360ABFE2A6D) {
    if(cangive_ammo()) {
      _id_6E98D61FBAD956E0 = getammooverride(weapon);
      _id_02422F12C129670C = self getweaponammostock(weapon);
      _id_0A862B844906A7C8 = scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon);
      _id_94994668098464F4 = _id_02422F12C129670C + _id_6E98D61FBAD956E0;
      _id_7D676154ADB1E7A8 = int(min(_id_0A862B844906A7C8, _id_94994668098464F4));
      self setweaponammostock(weapon, _id_7D676154ADB1E7A8);
      return 1;
    }
  }

  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(weapon) == "riotshield") {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_incompatible_weapon(weapon)) {
      continue;
    }
    if(_id_74502A9E0EF1F19C::is_launcher(weapon)) {
      continue;
    }
    if(cangive_ammo()) {
      _id_6E98D61FBAD956E0 = getammooverride(weapon);
      _id_02422F12C129670C = self getweaponammostock(weapon);
      _id_0A862B844906A7C8 = scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon);
      _id_94994668098464F4 = _id_02422F12C129670C + _id_6E98D61FBAD956E0;
      _id_7D676154ADB1E7A8 = int(min(_id_0A862B844906A7C8, _id_94994668098464F4));
      self setweaponammostock(weapon, _id_7D676154ADB1E7A8);
      return 1;
    }
  }

  return 0;
}

getammooverride(weaponobj) {
  baseweapon = weaponobj getbaseweapon();
  clipsize = weaponclipsize(baseweapon);
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  _id_EA03E2062E30FF1A = 30;
  _id_6C79B6B69A253E2B = _id_EA03E2062E30FF1A;

  if(weaponobj.isalternate) {} else {
    switch (weaponobj.classname) {
      case "spread":
        switch (_id_AB501F397D3CD312) {
          case "iw8_sh_charlie725":
            _id_6C79B6B69A253E2B = 6;
            break;
          case "iw8_sh_dpapa12":
            _id_6C79B6B69A253E2B = 8;
            break;
          default:
            _id_6C79B6B69A253E2B = int(min(clipsize, _id_EA03E2062E30FF1A));
            break;
        }

        break;
      case "sniper":
        switch (_id_AB501F397D3CD312) {
          case "iw9_dm_crossbow":
            _id_6C79B6B69A253E2B = 3;
            break;
          default:
            _id_6C79B6B69A253E2B = int(min(clipsize, _id_EA03E2062E30FF1A));
            break;
        }

        break;
      default:
        _id_6C79B6B69A253E2B = int(min(clipsize, _id_EA03E2062E30FF1A));
    }
  }

  return _id_6C79B6B69A253E2B;
}

cangive_ammo() {
  currentweapon = scripts\cp\utility::getvalidtakeweapon();
  _id_0DE8A9EAD75A0581 = self getweaponammoclip(currentweapon);
  _id_C56BBE615F626CC8 = weaponclipsize(currentweapon);
  _id_0A862B844906A7C8 = scripts\cp\utility::_id_ED18A118C6FA5C4F(currentweapon);
  _id_82068CA6D5B3C991 = self getweaponammostock(currentweapon);

  if(_id_82068CA6D5B3C991 < _id_0A862B844906A7C8 || _id_0DE8A9EAD75A0581 < _id_C56BBE615F626CC8)
    return 1;
  else
    return 0;
}

should_drop_grenade_pickup(player) {
  if(isDefined(self.chute))
    return 0;

  if(!self isonground())
    return 0;

  if(isDefined(self.ridingvehicle))
    return 0;

  if(!isDefined(player.last_gren_drop_time)) {
    player.last_gren_drop_time = gettime();
    return 1;
  }

  _id_3C3F83B87D62B244 = 10000;
  _id_FFA1FAA3C8A198AA = gettime() - player.last_gren_drop_time;

  if(_id_FFA1FAA3C8A198AA > _id_3C3F83B87D62B244) {
    player.last_gren_drop_time = gettime();
    return 1;
  }

  return 0;
}

drop_grenade(_id_4D8D96D547DF2E9F) {
  org = self.origin + (10, 10, 0);
  drop_grenade_internal(_id_4D8D96D547DF2E9F, org);
}

drop_grenade_internal(_id_4D8D96D547DF2E9F, _id_165B8600CF984332, _id_770DA53BE8991660) {
  loc = self.origin;

  if(isDefined(_id_165B8600CF984332))
    loc = _id_165B8600CF984332;

  grenade_obj = scripts\cp\utility::createhintobject(loc, "HINT_BUTTON", "cp_crate_icon_lethalrefill", &"COOP_GAME_PLAY/PICK_GRENADE", 5, "duration_short", "show", 200, undefined, 100, 360);
  grenade_obj setModel("offhand_wm_grenade_mike67");
  grenade_obj thread activate_grenade_object();
  grenade_obj thread scripts\cp\utility::delayentdelete(30);

  if(isDefined(_id_770DA53BE8991660)) {
    foreach(_id_B212D40302E8388D in level.players) {
      if(_id_B212D40302E8388D != _id_770DA53BE8991660)
        grenade_obj hidefromplayer(_id_B212D40302E8388D);
    }
  }
}

activate_grenade_object() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);
    player forceplaygestureviewmodel("iw9_ges_pickup");
    player playlocalsound("weap_ammo_pickup");

    foreach(_id_19C112C446B560D6 in player.powers) {
      if(_id_19C112C446B560D6.slot == "primary") {
        player notify("pickup_equipment", _id_19C112C446B560D6.weaponuse);
        waitframe();
      }
    }

    self delete();
  }
}

is_wearing_armor() {
  if(self.unittype == "juggernaut")
    return 1;
  else if(_id_18A73A64992DD07D::is_armored())
    return 1;
  else
    return 0;
}

_id_476C576900BFB449() {
  if(self.unittype == "juggernaut")
    return 1;
  else if(istrue(self.wearing_helmet))
    return 1;
  else
    return 0;
}

should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim, partname, _id_B17964B5DA7540EA) {
  if(!isDefined(sweapon))
    return 0;
  else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim))
    return 0;
  else if(isDefined(self._id_71C1911E983F326D))
    return [[self._id_71C1911E983F326D]](idamage, smeansofdeath, sweapon, partname, _id_B17964B5DA7540EA);

  if(isDefined(level.should_do_damage_check_func_relics)) {
    if(isarray(level.should_do_damage_check_func_relics) && level.should_do_damage_check_func_relics.size > 0) {
      foreach(func in level.should_do_damage_check_func_relics) {
        if(![[func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim))
          return 0;
      }
    }
  }

  return 1;
}

ishighdamageweapon(objweapon) {
  return objweapon.classname == "sniper" || objweapon.classname == "dmr";
}

should_drop_weapon(_id_4D8D96D547DF2E9F) {
  _id_94C7BEB63EF70F85 = getdvarint("dvar_6AE5D6C07E3E8C81");

  if(_id_94C7BEB63EF70F85)
    return 1;

  if(!isDefined(level.weapon_drop_cooldown))
    return 0;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 0;

  if(!isDefined(_id_4D8D96D547DF2E9F.eattacker))
    return 0;

  cooldown = 5;
  _id_4FB72B720667636B = gettime();
  _id_4269518899253F17 = _id_4D8D96D547DF2E9F.eattacker getentitynumber();

  if(!isDefined(level.weapon_drop_cooldown[_id_4269518899253F17])) {
    level.weapon_drop_cooldown[_id_4269518899253F17] = _id_4FB72B720667636B + cooldown * 1000;
    return 1;
  }

  if(_id_4FB72B720667636B > level.weapon_drop_cooldown[_id_4269518899253F17]) {
    level.weapon_drop_cooldown[_id_4269518899253F17] = _id_4FB72B720667636B + cooldown * 1000;
    return 1;
  }

  return 0;
}

is_flashbang(weaponname, objweapon, inflictor) {
  return weaponname == "flash_grenade_mp";
}

is_gas(weaponname) {
  return weaponname == "gas_mp";
}

callbacksoldieragentgametypedamagefinished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  idflags = 0;

  if(!isDefined(self.painsound)) {
    return;
  }
  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound))
      self playSound(self.painsound);

    self.next_dmg_sound = gettime() + 500;
  }
}

_id_7D9BBF6BBC649BBF(eattacker, agent, smeansofdeath, sweapon) {
  if(isPlayer(eattacker)) {
    scripts\cp\challenges_cp::_id_A4F684E73D9EC4C6(eattacker);

    if(sweapon.basename == "bunkerbuster_mp" && (isDefined(agent.aitype) && agent.aitype == "juggernaut"))
      scripts\cp\challenges_cp::_id_472E90D2E14C4B53(eattacker);
  }

  if(!isPlayer(eattacker.owner)) {
    return;
  }
  if(!isDefined(eattacker.team)) {
    return;
  }
  if(eattacker.team != "allies") {
    return;
  }
  if(isDefined(eattacker._id_50C39E58AF7F7018))
    scripts\cp\challenges_cp::_id_38154B1C06023442(eattacker.owner);
}

callbacksoldieragentgametypekilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  scripts\cp\cp_agent_utils::deactivateagent();
  thread _id_7D9BBF6BBC649BBF(eattacker, self, smeansofdeath, sweapon);

  if(isDefined(level.updateonkillrelicsfunc))
    level thread[[level.updateonkillrelicsfunc]](sweapon, eattacker, self, smeansofdeath, shitloc);

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    thread _id_0598E0C00C8151F7::_id_7BAC8EE72285298E();

  if(isDefined(level.spawnloopupdatefunc))
    [[level.spawnloopupdatefunc]](eattacker, sweapon);

  if(scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, eattacker)) {
    if(!istrue(self._id_AD799295A6692B29)) {}
  }

  _id_17CA3AF80F14CE7E::_id_3B55A5779A740DF1();

  if(!istrue(self._id_AD799295A6692B29) && !istrue(level._id_AD799295A6692B29))
    thread _id_703FDBB02501D31E::_id_C568B761A7F0B678(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);

  if(is_exploder()) {
    if(!istrue(self.died_poorly))
      level notify("grenade_exploded_during_stealth", self.origin, "suicide_vest", get_stealth_breaking_guilty_player_name(einflictor, eattacker, self.origin));
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  if(istrue(self.marked_for_death))
    self.marked_for_death = undefined;

  if(isDefined(self.death_info_func)) {
    _id_4D8D96D547DF2E9F = spawnStruct();
    _id_4D8D96D547DF2E9F.einflictor = einflictor;
    _id_4D8D96D547DF2E9F.eattacker = eattacker;
    _id_4D8D96D547DF2E9F.idamage = idamage;
    _id_4D8D96D547DF2E9F.smeansofdeath = smeansofdeath;
    _id_4D8D96D547DF2E9F.sweapon = sweapon;
    _id_4D8D96D547DF2E9F.vdir = vdir;
    _id_4D8D96D547DF2E9F.shitloc = shitloc;
    _id_4D8D96D547DF2E9F.timeoffset = timeoffset;
    _id_4D8D96D547DF2E9F.deathanimduration = deathanimduration;
    thread[[self.death_info_func]](_id_4D8D96D547DF2E9F);
  }

  if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
    eattacker = eattacker.owner;

  if(isPlayer(eattacker)) {
    level notify("enemy_killed", eattacker, self);
    level thread handle_death_sounds(eattacker, self, smeansofdeath);
    self.died_poorly = undefined;
    _id_DB24F499F4608B0D = 1;
    scripts\cp\cp_analytics::logevent_kill(eattacker, self, sweapon);
    thread scripts\cp_mp\challenges::_id_5A0AE8BC2B80C0C0(einflictor, eattacker, idamage, smeansofdeath, sweapon, shitloc, eattacker.modifiers);

    if(isDefined(eattacker.perk_data) && eattacker scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
      _id_199C16FDBEB2C72B = 10;
      amount = _id_199C16FDBEB2C72B * eattacker.perk_data["super_fill_scalar"];
      eattacker _id_56EF8D52FE1B48A1::increase_super_progress(amount);
    }
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc))
    level thread[[level.removefromtargetmarkeronkillfunc]](self);

  if(isDefined(self.attackers)) {
    foreach(player in self.attackers) {
      if(!isDefined(_validateattacker(player))) {
        continue;
      }
      if(player == eattacker) {
        continue;
      }
      if(self == player) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      _id_907BB577FE481752 = undefined;

      if(isDefined(self.attackerdata)) {
        attackerdata = self.attackerdata[player.guid];

        if(isDefined(attackerdata))
          _id_907BB577FE481752 = attackerdata.objweapon;
      }

      _id_54351D786449EE9E = 0;

      if(self.attackerdata[player.guid].damage >= 35)
        _id_54351D786449EE9E = 1;

      if(self.attackerdata[player.guid].damage >= 70)
        _id_54351D786449EE9E = 2;

      player thread scripts\cp\cp_gamescore::processassist(self, _id_907BB577FE481752, _id_54351D786449EE9E);
    }
  }

  give_attacker_kill_rewards(einflictor, eattacker, shitloc, smeansofdeath, sweapon);
  idflags = 0;
  _id_354C862768CFE202::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, shitloc, timeoffset, self);
  scripts\cp\cp_merits::process_agent_on_killed_merits(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
  level thread scripts\cp\utility::add_to_notify_queue("ai_killed", self.origin, sweapon, smeansofdeath, eattacker, self, self.team);
}

track_consecutive_kills() {
  self endon("death_or_disconnect");
  self notify("stop_tracking_consec_kills");
  self endon("stop_tracking_consec_kills");

  for(;;) {
    level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker, _id_E851FFA44B7E0D54, team);

    if(!isDefined(self.consecutive_kills))
      self.consecutive_kills = 1;
    else
      self.consecutive_kills = self.consecutive_kills + 1;

    thread timeout_consec_kills();
  }
}

timeout_consec_kills() {
  self endon("death_or_disconnect");
  self notify("stop_timeout_consec_kills");
  self endon("stop_timeout_consec_kills");
  wait(get_consecutive_def());
  self.consecutive_kills = undefined;
}

get_consecutive_def() {
  time = 3;

  if(scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak"))
    time = time + 3;

  return time;
}

handle_death_sounds(attacker, victim, smeansofdeath) {
  if(!scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    return;
  }
  if(isDefined(victim.deathsound) && soundexists(victim.deathsound))
    playsoundatpos(victim.origin, victim.deathsound);

  ent = victim;

  if(smeansofdeath == "MOD_HEAD_SHOT") {
    ent playsoundtoplayer("bullet_impact_headshot", attacker);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoplayer("mp_kill_alert", attacker);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);
  }
}

give_attacker_kill_rewards(einflictor, attacker, shitloc, smeansofdeath, sweapon) {
  if(!isDefined(attacker)) {
    return;
  }
  if(isDefined(self.team) && isDefined(attacker.team) && self.team == attacker.team) {
    return;
  }
  if(!isDefined(self.agent_type)) {
    return;
  }
  isjuggernaut = isDefined(self.unittype) && self.unittype == "juggernaut";
  agent_type = self.agent_type;
  agent_type = getsubstr(agent_type, 6, agent_type.size);
  _id_4AD66E8A50624BDB = undefined;
  _id_52DBB00E33375345 = 0;

  if(isDefined(level.agent_definition[agent_type])) {
    if(isDefined(level.agent_definition[agent_type]["reward"]))
      _id_4AD66E8A50624BDB = level.agent_definition[agent_type]["reward"];

    if(isDefined(level.agent_definition[agent_type]["xp"]))
      _id_52DBB00E33375345 = level.agent_definition[agent_type]["xp"];
  }

  if(!isDefined(_id_4AD66E8A50624BDB))
    _id_4AD66E8A50624BDB = 10;

  if(isjuggernaut)
    _id_4AD66E8A50624BDB = getdvarint("dvar_702794F158DE82B3", _id_4AD66E8A50624BDB);
  else
    _id_4AD66E8A50624BDB = getdvarint("dvar_697B2DEB810DA53B", _id_4AD66E8A50624BDB);

  _id_33242CA76A448F6B = 0;
  _id_62F91D5269545D20 = is_exploder();
  amount = undefined;

  if(isDefined(attacker.classname) && attacker.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar))
      amount = _id_4AD66E8A50624BDB * (level.cash_scalar + level.consumable_cash_scalar);
    else
      amount = _id_4AD66E8A50624BDB * level.cash_scalar;

    foreach(player in level.players) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(isDefined(level.zombie_xp))
        player _id_3BCAA2CBAF54ABDD::give_player_xp(int(_id_52DBB00E33375345));

      if(istrue(level.special_event)) {
        continue;
      }
      _id_A61C75B156FC1EE0 = "large";
      shitloc = "none";
      player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, _id_A61C75B156FC1EE0, shitloc, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(attacker) && (!isDefined(attacker.owner) || !isPlayer(attacker.owner))) {
    return;
  }
  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
    _id_33242CA76A448F6B = 1;
  }

  if(!isjuggernaut) {
    if(scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, attacker) && !_id_33242CA76A448F6B && scripts\engine\utility::isbulletdamage(smeansofdeath) && !_id_62F91D5269545D20)
      _id_4AD66E8A50624BDB = 75;
    else if(smeansofdeath == "MOD_MELEE")
      _id_4AD66E8A50624BDB = 75;
  }

  if(isPlayer(attacker)) {
    if(!istrue(attacker.pers["ignoreWeaponMatchBonus"]) && (_id_74502A9E0EF1F19C::iscacprimaryweapon(sweapon) || _id_74502A9E0EF1F19C::iscacsecondaryweapon(sweapon))) {
      if(!isDefined(attacker.pers["weaponMatchBonusKills"]))
        attacker.pers["weaponMatchBonusKills"] = 1;
      else
        attacker.pers["weaponMatchBonusKills"]++;

      if(attacker.pers["weaponMatchBonusKills"] > scripts\cp\cp_weaponrank::getgametypekillspermatchmaximum()) {
        attacker.pers["ignoreWeaponMatchBonus"] = 1;
        attacker.pers["weaponMatchBonusKills"] = undefined;
        attacker.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(attacker.pers["killsPerWeapon"]))
          attacker.pers["killsPerWeapon"] = [];

        _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(sweapon);
        _id_B590DD50C4FE1F77 = 0;

        foreach(_id_5DC27A5BF459C504, data in attacker.pers["killsPerWeapon"]) {
          if(_id_5DC27A5BF459C504 == _id_AB501F397D3CD312) {
            data.killcount++;
            _id_B590DD50C4FE1F77 = 1;
            break;
          }
        }

        if(!_id_B590DD50C4FE1F77) {
          data = spawnStruct();
          data.killcount = 1;
          data.basename = sweapon.basename;
          data.orderindex = attacker.pers["killsPerWeapon"].size;
          attacker.pers["killsPerWeapon"][_id_AB501F397D3CD312] = data;
        }
      }
    }
  }

  if(isDefined(level.kill_reward_func))
    _id_4AD66E8A50624BDB = [[level.kill_reward_func]](einflictor, attacker, shitloc, smeansofdeath, sweapon, agent_type, _id_4AD66E8A50624BDB);

  if(isDefined(_id_4AD66E8A50624BDB))
    givekillreward(einflictor, attacker, _id_4AD66E8A50624BDB, _id_52DBB00E33375345, "large", shitloc, sweapon, smeansofdeath);
}

givekillreward(einflictor, eattacker, amount, _id_52DBB00E33375345, _id_A61C75B156FC1EE0, shitloc, sweapon, smeansofdeath) {
  if(isDefined(level.consumable_cash_scalar))
    amount = amount * (level.cash_scalar + level.consumable_cash_scalar);
  else
    amount = amount * level.cash_scalar;

  eattacker thread giveplayerbonuscash(einflictor, eattacker, amount, _id_52DBB00E33375345, _id_A61C75B156FC1EE0, shitloc, sweapon, smeansofdeath);
  eattacker _id_3BCAA2CBAF54ABDD::record_player_kills(sweapon, shitloc, smeansofdeath, eattacker);

  if(isDefined(einflictor.owner) && istrue(einflictor._id_10F81A6BF4F5CE9A))
    eattacker thread _id_293BC33BD79CABD1::killeventtextpopup("assist", 1);

  if(isDefined(self.shared_damage_points)) {
    foreach(player in level.players) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(level.special_event)) {
        continue;
      }
      player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, _id_A61C75B156FC1EE0, shitloc, 1, "crafted");
    }
  } else if(should_get_currency_from_kill(einflictor, eattacker, sweapon))
    eattacker _id_3BCAA2CBAF54ABDD::give_player_currency(amount, _id_A61C75B156FC1EE0, shitloc, 1);

  if(!scripts\cp\utility::is_specops_gametype())
    eattacker thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_EF9582D72160F199", sweapon, undefined, _id_52DBB00E33375345, self);
}

giveplayerbonuscash(einflictor, eattacker, amount, _id_52DBB00E33375345, _id_A61C75B156FC1EE0, shitloc, sweapon, smeansofdeath) {
  if(should_get_currency_from_kill(einflictor, eattacker, sweapon)) {
    if(eattacker scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(smeansofdeath) && sweapon.classname == "weapon_sniper" && checkaltmodestatus(sweapon)) {
      _id_79EF81FE4A4AFC5C = 300;

      if(sweapon == "iw7_shared_fate_weapon")
        eattacker scripts\cp\utility::notify_used_consumable("extra_sniping_points");
      else {
        eattacker scripts\cp\utility::notify_used_consumable("extra_sniping_points");
        eattacker thread delaygivecurrency(_id_79EF81FE4A4AFC5C, _id_A61C75B156FC1EE0, shitloc, "bonus", 0.15);
      }
    }

    if(isPlayer(eattacker) && isDefined(eattacker.cash_scalar)) {
      if(isDefined(eattacker.cash_scalar_weapon) && eattacker.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(sweapon)) {
        _id_74B7503D62E925EA = int(amount * eattacker.cash_scalar - amount);
        eattacker thread delaygivecurrency(_id_74B7503D62E925EA, _id_A61C75B156FC1EE0, shitloc, "bonus", 0.25);
      }

      if(isDefined(eattacker.cash_scalar_alt_weapon) && eattacker.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(sweapon) && istrue(sweapon.isalternate) && istrue(eattacker.alt_mode_passive)) {
        _id_74B7503D62E925EA = int(amount * eattacker.cash_scalar - amount);
        eattacker thread delaygivecurrency(_id_74B7503D62E925EA, _id_A61C75B156FC1EE0, shitloc, "bonus", 0.25);
      }
    }
  }
}

delaygivecurrency(_id_79EF81FE4A4AFC5C, _id_A61C75B156FC1EE0, shitloc, _id_800A3FD1E25BFD08, _id_74B5B12BB6514385) {
  self endon("disconnect");
  wait(_id_74B5B12BB6514385);
  _id_3BCAA2CBAF54ABDD::give_player_currency(_id_79EF81FE4A4AFC5C, _id_A61C75B156FC1EE0, shitloc, 1, _id_800A3FD1E25BFD08);
}

should_get_currency_from_kill(einflictor, eattacker, sweapon) {
  if(isPlayer(eattacker) && _id_0AFB7E332AEE4BF2::player_in_laststand(eattacker))
    return 0;

  if(scripts\cp\utility::is_trap(einflictor, sweapon))
    return 0;

  if(istrue(level.special_event))
    return 0;

  return 1;
}

checkaltmodestatus(sweapon) {
  if(!isDefined(sweapon) || sweapon == "none")
    return 0;

  baseweapon = scripts\cp\utility::getbaseweaponname(sweapon);

  switch (baseweapon) {
    case "iw7_m8":
      if(scripts\cp\utility::isaltmodeweapon(sweapon))
        return 0;
      else
        return 1;
    default:
      return 1;
  }
}

addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath) {
  if(!isDefined(victim.attackerdata))
    victim.attackerdata = [];

  if(!isDefined(eattacker.guid) && (isagent(eattacker) || isPlayer(eattacker)))
    eattacker.guid = eattacker scripts\cp\utility\player::getuniqueid();

  if(!isDefined(eattacker.guid)) {
    return;
  }
  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = gettime();
    victim.attackerdata[eattacker.guid].hitcount = 1;
  } else
    victim.attackerdata[eattacker.guid].hitcount++;

  if(_id_74502A9E0EF1F19C::iscacprimaryweapon(objweapon) && !_id_74502A9E0EF1F19C::iscacsecondaryweapon(objweapon))
    victim.attackerdata[eattacker.guid].diddamagewithprimary = 1;

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_MELEE")
    victim.attackerdata[eattacker.guid].didnonmeleedamage = 1;

  _id_11D2F075E9A0E643 = scripts\cp\utility::getequipmenttype(objweapon.basename);

  if(isDefined(_id_11D2F075E9A0E643)) {
    if(_id_11D2F075E9A0E643 == "lethal")
      victim.attackerdata[eattacker.guid].diddamagewithlethalequipment = 1;

    if(_id_11D2F075E9A0E643 == "tactical")
      victim.attackerdata[eattacker.guid].diddamagewithtacticalequipment = 1;
  }

  victim.attackerdata[eattacker.guid].damage = victim.attackerdata[eattacker.guid].damage + idamage;
  victim.attackerdata[eattacker.guid].weapon = getcompleteweaponname(objweapon);
  victim.attackerdata[eattacker.guid].objweapon = objweapon;
  victim.attackerdata[eattacker.guid].vpoint = vpoint;
  victim.attackerdata[eattacker.guid].vdir = vdir;
  victim.attackerdata[eattacker.guid].shitloc = shitloc;
  victim.attackerdata[eattacker.guid].psoffsettime = psoffsettime;
  victim.attackerdata[eattacker.guid].smeansofdeath = smeansofdeath;
  victim.attackerdata[eattacker.guid].attackerent = eattacker;
  victim.attackerdata[eattacker.guid].lasttimedamaged = gettime();

  if(isDefined(einflictor) && !isPlayer(einflictor) && isDefined(einflictor.primaryweapon))
    victim.attackerdata[eattacker.guid].sprimaryweapon = einflictor.primaryweapon;
  else if(isDefined(eattacker) && isPlayer(eattacker) && !isnullweapon(eattacker getcurrentprimaryweapon()))
    victim.attackerdata[eattacker.guid].sprimaryweapon = getcompleteweaponname(eattacker getcurrentprimaryweapon());
  else
    victim.attackerdata[eattacker.guid].sprimaryweapon = undefined;
}

get_stealth_breaking_guilty_player_name(einflictor, eattacker, loc) {
  if(isPlayer(eattacker))
    return eattacker.name;

  if(isPlayer(einflictor))
    return einflictor.name;

  if(isDefined(einflictor.owner) && isPlayer(einflictor.owner))
    return einflictor.owner.name;

  _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(loc, level.players);
  return _id_C729D49D406ACED8.name;
}

_validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive))
    return undefined;

  if(isagent(eattacker) && !isDefined(eattacker.classname))
    return undefined;

  return eattacker;
}

_id_020B668EA2DCBA3C(_id_4D8D96D547DF2E9F) {
  _id_94C7BEB63EF70F85 = getdvarint("dvar_898730D6375934BC");

  if(_id_94C7BEB63EF70F85)
    return 1;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 0;

  if(!istrue(level._id_8FDE5731BB1BA3BB))
    return 0;

  return 1;
}

_id_9CED4705330673A7(_id_2C0F7E4E3DACE539) {
  amount = 100;

  if(istrue(level._id_006ED343C3FF7515)) {
    return;
  }
  _id_52C67624A2BB680E = spawn("script_model", _id_2C0F7E4E3DACE539 + (0, 0, 40));
  _id_52C67624A2BB680E.angles = (-180, 0, 0);
  _id_52C67624A2BB680E setModel("cp_cash_drop");
  _id_52C67624A2BB680E thread _id_34DC33AF893513B2(amount);
}

_id_34DC33AF893513B2(amount) {
  self endon("death");
  self endon("auto_pickedup");
  self makeusable();
  amount = 100;
  self setHintString(&"CP_WEAPON_BUY/PICKUP_CASH");
  self sethintstringparams(amount);
  self setCursorHint("HINT_BUTTON");
  self sethinticon("hud_icon_br_plunder");
  self setuserange(92);
  self sethintdisplayrange(192);
  thread _id_EB65FA1997289E2E();
  thread _id_25F6C853B336372F(amount);
  self hudoutlineenable("outlinefill_depth_cyan");
  self moveTo(self.origin + (0, 0, -35), 0.25);

  for(;;) {
    self waittill("trigger", player);
    self notify("pickedup");
    player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, undefined, undefined, undefined, "cash_pickup");
    player playlocalsound("weap_pickup");
    self delete();
  }
}

_id_EB65FA1997289E2E() {
  self endon("pickedup");
  self endon("auto_pickedup");
  wait 30;
  self notify("timeout");
  self delete();
}

_id_25F6C853B336372F(amount) {
  self endon("pickedup");
  self endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < squared(16)) {
        self notify("auto_pickedup");
        player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, undefined, undefined, undefined, "cash_pickup");
        player playlocalsound("weap_pickup");
        self delete();
      }
    }

    wait 0.05;
  }
}