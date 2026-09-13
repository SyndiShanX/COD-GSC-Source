/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\inventory_utility.gsc
*******************************************************/

_giveweapon(weapon, _id_6794F7417ED0B5A2, _id_D509F41064F6C716, _id_2E5C1E9548E8884F) {
  if(!isDefined(_id_6794F7417ED0B5A2))
    _id_6794F7417ED0B5A2 = -1;

  if(!isDefined(_id_2E5C1E9548E8884F))
    _id_2E5C1E9548E8884F = 0;

  self giveweapon(weapon, _id_6794F7417ED0B5A2, istrue(_id_D509F41064F6C716), -1, _id_2E5C1E9548E8884F);
}

_switchtoweapon(weapon) {
  self switchtoweapon(weapon);
}

_switchtoweaponimmediate(weapon) {
  self switchtoweaponimmediate(weapon);
}

_takeweapon(weapon) {
  _id_FA1A9E12F5788A39 = 0;

  if(isweapon(weapon))
    _id_FA1A9E12F5788A39 = self gethighpriorityweapon() == weapon;
  else
    _id_FA1A9E12F5788A39 = getcompleteweaponname(self gethighpriorityweapon()) == weapon;

  if(_id_FA1A9E12F5788A39) {
    _id_C094DB262CE4DFA0 = weapon;

    if(!isstring(_id_C094DB262CE4DFA0) && isweapon(weapon))
      _id_C094DB262CE4DFA0 = getcompleteweaponname(weapon);

    self clearhighpriorityweapon(weapon);
  }

  self takeweapon(weapon);
}

takeweaponwhensafe(weapon) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    _id_8DCC03BECA90A5DE = 0;

    if(!iscurrentweapon(weapon)) {
      _id_91EDE5F353376127 = self getweaponmeleeslot();

      if(!isnullweapon(_id_91EDE5F353376127) && self.currentweapon == _id_91EDE5F353376127)
        _id_8DCC03BECA90A5DE = 0;
      else
        _id_8DCC03BECA90A5DE = 1;
    }

    if(_id_8DCC03BECA90A5DE) {
      break;
    }

    waitframe();
  }

  _takeweapon(weapon);
}

getcurrentmonitoredweaponswitchweapon() {
  validatehighpriorityflag();
  _id_D93FAF2B91E9B072 = self gethighpriorityweapon();

  if(isnullweapon(_id_D93FAF2B91E9B072))
    return undefined;

  return _id_D93FAF2B91E9B072;
}

isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

isswitchingtoweaponwithmonitoring(weapon) {
  if(isstring(weapon))
    weapon = makeweaponfromstring(weapon);

  _id_93FAAADF57D54DE6 = getcurrentmonitoredweaponswitchweapon();
  return isDefined(_id_93FAAADF57D54DE6) && _id_93FAAADF57D54DE6 == weapon && !iscurrentweapon(weapon);
}

candomonitoredswitchtoweapon(weapon, _id_026CA36763FA5B82) {
  if(!self hasweapon(weapon))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon"))
    return 0;

  if(!istrue(_id_026CA36763FA5B82) && !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch") && !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("script_weapon_switch"))
    return 0;

  _id_D93FAF2B91E9B072 = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(_id_D93FAF2B91E9B072)) {
    _id_5C3F9357F11D2223 = getweaponbasename(weapon);
    _id_958B9A25C5911D97 = 0;

    if(_id_5C3F9357F11D2223 == "briefcase_bomb_mp" || _id_5C3F9357F11D2223 == "briefcase_bomb_mp_nuke" || _id_5C3F9357F11D2223 == "briefcase_bomb_defuse_mp" || _id_5C3F9357F11D2223 == "iw9_cyberemp_mp" || _id_5C3F9357F11D2223 == "iw7_tdefball_mp")
      _id_958B9A25C5911D97 = 1;
    else if(weaponinventorytype(_id_D93FAF2B91E9B072) == "primary")
      _id_958B9A25C5911D97 = 1;

    if(!_id_958B9A25C5911D97)
      return 0;
  }

  if(iscurrentweapon(weapon))
    return 0;

  return 1;
}

abortmonitoredweaponswitch(weapon) {
  if(self gethighpriorityweapon() == weapon)
    self clearhighpriorityweapon(weapon);

  _takeweapon(weapon);
  return;
}

domonitoredweaponswitch(weapon, _id_4EFC0EF0C515E782, _id_026CA36763FA5B82) {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(weapon))
    return 0;

  if(!candomonitoredswitchtoweapon(weapon, _id_026CA36763FA5B82))
    return 0;

  if(isanymonitoredweaponswitchinprogress())
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());

  self sethighpriorityweapon(weapon);

  if(istrue(_id_4EFC0EF0C515E782))
    _switchtoweaponimmediate(weapon);

  for(;;) {
    if(iscurrentweapon(weapon)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(weapon) || !self hasweapon(weapon))
      return 0;

    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon") || !istrue(_id_026CA36763FA5B82) && !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon_switch") && !_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("script_weapon_switch")) {
      self clearhighpriorityweapon(weapon);
      return 0;
    }

    waitframe();
  }
}

_id_ED0DD95E839CD2A9() {
  return "iw9_gunless_mp";
}

_id_3D5C51904FD25773() {
  return "iw9_gunless_quickdrop_mp";
}

_id_FC6A5B145563BE33(_id_4EFC0EF0C515E782) {
  return _id_6D53276BD8E3C46D(_id_4EFC0EF0C515E782, _id_ED0DD95E839CD2A9());
}

_id_F1E9D0C09F38006B(_id_4EFC0EF0C515E782) {
  return _id_6D53276BD8E3C46D(_id_4EFC0EF0C515E782, _id_3D5C51904FD25773());
}

_id_6D53276BD8E3C46D(_id_4EFC0EF0C515E782, weaponname) {
  self endon("death_or_disconnect");

  if(!isDefined(weaponname)) {
    return;
  }
  if(isDefined(self.gunnlessweapon)) {
    return;
  }
  gunless = makeweapon(weaponname);
  _giveweapon(gunless, undefined, undefined, 1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gunless");
  _id_3B64EB40368C1450::set("gunless", "script_weapon_switch", 1);

  if(!isDefined(_id_4EFC0EF0C515E782))
    _id_4EFC0EF0C515E782 = 0;

  success = domonitoredweaponswitch(gunless, _id_4EFC0EF0C515E782);

  if(success)
    self.gunnlessweapon = gunless;
  else {
    _takeweapon(gunless);
    forcevalidweapon();
  }

  _id_3B64EB40368C1450::set("gunless", "script_weapon_switch", 0);
  return success;
}

_id_9897D143C3FEEE05() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  if(scripts\engine\utility::ent_flag_exist("swapLoadout_pending") && scripts\engine\utility::ent_flag("swapLoadout_pending"))
    scripts\engine\utility::ent_flag_wait("swapLoadout_complete");

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gunless");
  _id_3B64EB40368C1450::set("gunless", "script_weapon_switch", 1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!iscurrentweapon(self.gunnlessweapon))
      abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      _takeweapon(self.gunnlessweapon);
      forcevalidweapon();
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  _id_3B64EB40368C1450::set("gunless", "script_weapon_switch", 0);
}

validatehighpriorityflag() {
  currentweapon = self getcurrentweapon();

  if(self ishighpriorityweapon(currentweapon))
    self clearhighpriorityweapon(currentweapon);
}

getridofweapon(weapon, _id_4EFC0EF0C515E782) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(weapon))
    return 0;

  if(!iscurrentweapon(weapon)) {
    _takeweapon(weapon);
    return 1;
  }

  while(isanymonitoredweaponswitchinprogress())
    waitframe();

  if(!iscurrentweapon(weapon)) {
    _takeweapon(weapon);
    return 1;
  }

  _id_41BF9BF4918115AC = domonitoredweaponswitch(self.lastdroppableweaponobj, _id_4EFC0EF0C515E782);

  if(isbot(self)) {
    self switchtoweaponimmediate(nullweapon());
    _id_41BF9BF4918115AC = 1;
  }

  _takeweapon(weapon);
  self notify("bomb_allow_offhands");

  if(!_id_41BF9BF4918115AC)
    forcevalidweapon();

  return 1;
}

forcevalidweapon(_id_A6A71521CAEEB8C8) {
  self endon("death");
  self endon("disconnect");

  while(isnullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    _id_78660C26E2D18376 = _id_A6A71521CAEEB8C8;

    if(istrue(self.isjuggernaut)) {
      _id_D5A7E66722DF9836 = undefined;

      if(scripts\common\utility::iscp())
        _id_D5A7E66722DF9836 = "iw9_lm_dblmg2_cp";
      else
        _id_D5A7E66722DF9836 = "iw9_minigunksjugg_mp";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "getMinigunWeapon"))
        _id_D5A7E66722DF9836 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "getMinigunWeapon")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        _id_32593FDCD227DBD9 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(_id_32593FDCD227DBD9)) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj))
            _id_D5A7E66722DF9836 = self.lastdroppableweaponobj;
          else {
            _id_9111B9A018285894 = getcurrentprimaryweaponsminusalt();

            if(_id_9111B9A018285894.size > 0)
              _id_D5A7E66722DF9836 = _id_9111B9A018285894[0];
          }
        }
      }

      if(isstring(_id_D5A7E66722DF9836))
        _id_78660C26E2D18376 = makeweapon(_id_D5A7E66722DF9836);
      else
        _id_78660C26E2D18376 = _id_D5A7E66722DF9836;
    } else {
      _id_9111B9A018285894 = getcurrentprimaryweaponsminusalt();

      if(!isDefined(_id_78660C26E2D18376) || !self hasweapon(_id_78660C26E2D18376)) {
        if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") {
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj))
          _id_78660C26E2D18376 = self.lastdroppableweaponobj;
        else if(_id_9111B9A018285894.size > 0)
          _id_78660C26E2D18376 = _id_9111B9A018285894[0];
      }

      if(isDefined(_id_78660C26E2D18376) && getweaponbasename(_id_78660C26E2D18376) == "iw7_axe_mp" && self getweaponammoclip(_id_78660C26E2D18376) == 0 && _id_9111B9A018285894.size == 1)
        _id_78660C26E2D18376.basename = "iw9_me_fists_mp";
      else if(self hasweapon("iw9_me_fists_mp")) {
        if(_id_9111B9A018285894.size == 1)
          _id_78660C26E2D18376 = _id_9111B9A018285894[0];
        else if(_id_9111B9A018285894.size == 2 && (self hasweapon("iw9_knifestab_mp") || self hasweapon("iw8_throwingknife_fire_melee_mp") || self hasweapon("iw8_throwingknife_electric_melee_mp"))) {
          if(_id_9111B9A018285894[0].basename == "iw9_me_fists_mp")
            _id_78660C26E2D18376 = _id_9111B9A018285894[0];
          else
            _id_78660C26E2D18376 = _id_9111B9A018285894[1];
        }
      }
    }

    domonitoredweaponswitch(_id_78660C26E2D18376);
    waitframe();
  }
}

iscurrentweapon(weapon) {
  if(isstring(weapon))
    weapon = makeweaponfromstring(weapon);

  return issameweapon(self getcurrentweapon(), weapon, 1);
}

getcurrentprimaryweaponsminusalt() {
  primaryweapons = [];
  _id_849C1DF4114E0A37 = self getweaponslistprimaries();

  foreach(weapon in _id_849C1DF4114E0A37) {
    if(!weapon.isalternate)
      primaryweapons[primaryweapons.size] = weapon;
  }

  return primaryweapons;
}