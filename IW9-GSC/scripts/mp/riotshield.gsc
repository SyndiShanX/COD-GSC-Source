/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\riotshield.gsc
***********************************************/

riotshield_hasweapon() {
  result = 0;
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon)) {
      result = 1;
      break;
    }
  }

  return result;
}

riotshield_hastwo() {
  count = 0;
  weapons = self getweaponslistprimaries();

  foreach(weapon in weapons) {
    if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon))
      count++;

    if(count == 2) {
      break;
    }
  }

  return count == 2;
}

riotshield_attach(_id_F8EE3E194415C066, _id_A6EF975DA2DDFF4B) {
  _id_8F79D15EFB6089C2 = undefined;

  if(_id_F8EE3E194415C066) {
    self.riotshieldmodel = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "tag_shield_back";
  }

  self attachshieldmodel(_id_A6EF975DA2DDFF4B, _id_8F79D15EFB6089C2, 0, !_id_F8EE3E194415C066);
  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(_id_F8EE3E194415C066) {
  _id_A6EF975DA2DDFF4B = undefined;
  _id_8053D7B86373D568 = undefined;

  if(_id_F8EE3E194415C066) {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodel;
    _id_8053D7B86373D568 = "j_shield_ri";
  } else {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodelstowed;
    _id_8053D7B86373D568 = "tag_shield_back";
  }

  self detachshieldmodel(_id_A6EF975DA2DDFF4B, _id_8053D7B86373D568);

  if(_id_F8EE3E194415C066)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(_id_9A9844B3A758C1C9) {
  _id_2FB5A158F53218ED = undefined;
  _id_C5E1BE4D30CC7D74 = undefined;
  _id_A6EF975DA2DDFF4B = undefined;

  if(_id_9A9844B3A758C1C9) {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodel;
    _id_2FB5A158F53218ED = "j_shield_ri";
    _id_C5E1BE4D30CC7D74 = "tag_shield_back";
  } else {
    _id_A6EF975DA2DDFF4B = self.riotshieldmodelstowed;
    _id_2FB5A158F53218ED = "tag_shield_back";
    _id_C5E1BE4D30CC7D74 = "j_shield_ri";
  }

  self moveshieldmodel(_id_A6EF975DA2DDFF4B, _id_2FB5A158F53218ED, _id_C5E1BE4D30CC7D74, _id_9A9844B3A758C1C9);

  if(_id_9A9844B3A758C1C9) {
    self.riotshieldmodelstowed = _id_A6EF975DA2DDFF4B;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = _id_A6EF975DA2DDFF4B;
    self.riotshieldmodelstowed = undefined;
  }
}

riotshield_clear() {
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

riotshield_getmodel() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    switch (weapon.basename) {
      case "iw9_me_riotshield_mp":
        return "weapon_wm_riotshield_p34";
      case "iw8_me_riotshield_mpv7":
        return "weapon_wm_riotshield_v7";
      case "iw8_me_riotshield_mpv6":
        return "weapon_wm_riotshield_v6";
      case "iw8_me_riotshield_mpv5":
        return "weapon_wm_riotshield_v5";
      case "iw8_me_riotshield_mpv4":
        return "weapon_wm_riotshield_v4";
      case "iw8_me_riotshield_mpv3":
        return "weapon_wm_riotshield_v3";
      case "iw8_me_riotshield_mpv2":
        return "weapon_wm_riotshield_v2";
      case "iw8_me_riotshield_mp":
        return "weapon_wm_riotshield";
    }
  }
}

setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}