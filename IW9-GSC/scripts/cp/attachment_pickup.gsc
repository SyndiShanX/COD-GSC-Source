/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\attachment_pickup.gsc
***********************************************/

_id_8B7DAE212F7FF902() {
  level._id_005FF8E03EB9E6B4 = "reflex,therm, acog, hybrid,holo ,magazine,gl,ubsh,brake,comp,grip,cash";
  level._id_005FF8E03EB9E6B4 = _id_8CECD5DD91836BBA(level._id_005FF8E03EB9E6B4);
  _id_845600FAB0A4A95B();
  _id_1361F1A11BA15C7E = getEntArray("attachment_pickup", "targetname");

  foreach(pickup in _id_1361F1A11BA15C7E)
  pickup thread _id_ABA2DA3A3EA77C90();
}

_id_8CECD5DD91836BBA(_id_3BC79ACDA463A258) {
  _id_A6A1F6FE2990C155 = strtok(_id_3BC79ACDA463A258, " ");
  _id_B483444CA727BAD7 = undefined;

  if(_id_A6A1F6FE2990C155.size > 1) {
    _id_B483444CA727BAD7 = _id_A6A1F6FE2990C155[0];

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_A6A1F6FE2990C155.size; _id_AC0E594AC96AA3A8++)
      _id_B483444CA727BAD7 = _id_B483444CA727BAD7 + _id_A6A1F6FE2990C155[_id_AC0E594AC96AA3A8];

    return _id_B483444CA727BAD7;
  } else
    return _id_3BC79ACDA463A258;
}

_id_ABA2DA3A3EA77C90() {
  _id_77460031AE8E47A4 = level._id_005FF8E03EB9E6B4;

  if(isDefined(self.script_noteworthy)) {
    _id_77460031AE8E47A4 = self.script_noteworthy;
    _id_77460031AE8E47A4 = _id_8CECD5DD91836BBA(_id_77460031AE8E47A4);
  }

  _id_3E930A0A758406F3 = strtok(_id_77460031AE8E47A4, ",");

  if(_id_3E930A0A758406F3.size == 1)
    _id_0D75739E39BC74E9 = _id_3E930A0A758406F3[0];
  else
    _id_0D75739E39BC74E9 = _id_17C409FD49D47C84(_id_3E930A0A758406F3);

  if(_id_0D75739E39BC74E9 == "cash") {
    _id_8D01902B9D93B4C6();
    self delete();
    return;
  }

  _id_8058E47866D8AC53 = _id_D8E20B4DB8AA13DF(_id_0D75739E39BC74E9);

  if(isDefined(_id_8058E47866D8AC53))
    self setModel(_id_8058E47866D8AC53);

  self._id_607D8B932B767CD1 = _id_0DE6F178182BA85A(_id_0D75739E39BC74E9);
  self._id_0D75739E39BC74E9 = _id_0D75739E39BC74E9;
  hint_string = _id_4B8D9FCB8AF000F9(_id_0D75739E39BC74E9);
  self makeusable();
  self setHintString(hint_string);
  self sethintdisplayrange(512);
  self setCursorHint("HINT_BUTTON");
  self setuserange(75);

  for(;;) {
    self waittill("trigger", player);
    _id_674582F0E7CE1160 = _id_9E4552C702A237C5(player, _id_0D75739E39BC74E9);

    if(!isDefined(_id_674582F0E7CE1160.attachment)) {
      break;
    } else if(_id_674582F0E7CE1160.attachment == "failed") {} else if(issubstr(_id_674582F0E7CE1160.attachment, "iron")) {
      break;
    } else {
      _id_0D75739E39BC74E9 = _id_674582F0E7CE1160.attachment;
      _id_8058E47866D8AC53 = _id_D8E20B4DB8AA13DF(_id_0D75739E39BC74E9);

      if(isDefined(_id_8058E47866D8AC53))
        self setModel(_id_8058E47866D8AC53);

      _id_3E930A0A758406F3 = _id_5FBCC7FC1266B377(self._id_607D8B932B767CD1);

      foreach(attachment in _id_3E930A0A758406F3) {
        if(issubstr(_id_0D75739E39BC74E9, attachment)) {
          _id_0D75739E39BC74E9 = attachment;
          break;
        }
      }

      hint_string = _id_4B8D9FCB8AF000F9(_id_0D75739E39BC74E9);
      self setHintString(hint_string);
      self._id_0D75739E39BC74E9 = _id_0D75739E39BC74E9;

      if(isDefined(_id_674582F0E7CE1160._id_42006C656A8F39FB)) {
        self._id_87FD41FFD79D9072 = _id_674582F0E7CE1160._id_42006C656A8F39FB;
        self._id_0E2D00B1889EB04A = _id_674582F0E7CE1160._id_F24C44FF50730D8B;
      }
    }

    wait 0.25;
  }

  self delete();
}

_id_17C409FD49D47C84(list) {
  array = [];
  _id_C01D5A3093AC1E22 = 0;

  foreach(_id_F7806D4CF24AACD3 in list) {
    weight = _id_306995537187BEE2(_id_F7806D4CF24AACD3);

    if(weight > 0) {
      _id_C01D5A3093AC1E22 = _id_C01D5A3093AC1E22 + weight;
      array[_id_C01D5A3093AC1E22] = _id_F7806D4CF24AACD3;
    }
  }

  rand_num = randomint(_id_C01D5A3093AC1E22);
  _id_0EB7EF060BAFC3E3 = _id_C01D5A3093AC1E22;

  foreach(key, value in array) {
    if(key > rand_num) {
      if(key < _id_0EB7EF060BAFC3E3)
        _id_0EB7EF060BAFC3E3 = key;
    }
  }

  return array[_id_0EB7EF060BAFC3E3];
}

_id_845600FAB0A4A95B() {
  level._id_B03FAA157DEBD02A = [];
  level._id_B03FAA157DEBD02A["reflex"] = 20;
  level._id_B03FAA157DEBD02A["therm"] = 10;
  level._id_B03FAA157DEBD02A["acog"] = 10;
  level._id_B03FAA157DEBD02A["hybrid"] = 10;
  level._id_B03FAA157DEBD02A["holo"] = 10;
  level._id_B03FAA157DEBD02A["scope"] = 10;
  level._id_B03FAA157DEBD02A["silencer"] = 10;
  level._id_B03FAA157DEBD02A["brake"] = 20;
  level._id_B03FAA157DEBD02A["comp"] = 20;
  level._id_B03FAA157DEBD02A["flash"] = 10;
  level._id_B03FAA157DEBD02A["melee"] = 10;
  level._id_B03FAA157DEBD02A["choke"] = 10;
  level._id_B03FAA157DEBD02A["grip"] = 20;
  level._id_B03FAA157DEBD02A["gl"] = 20;
  level._id_B03FAA157DEBD02A["ubsh"] = 20;
  level._id_B03FAA157DEBD02A["magazine"] = 30;
  level._id_B03FAA157DEBD02A["mags"] = 30;
  level._id_B03FAA157DEBD02A["drum"] = 20;
  level._id_B03FAA157DEBD02A["cal"] = 20;
  level._id_B03FAA157DEBD02A["trig"] = 10;
  level._id_B03FAA157DEBD02A["pistol"] = 10;
  level._id_B03FAA157DEBD02A["cash"] = 10;
}

_id_306995537187BEE2(_id_EE036B90CFF337EB) {
  if(isDefined(level._id_B03FAA157DEBD02A[_id_EE036B90CFF337EB]))
    return level._id_B03FAA157DEBD02A[_id_EE036B90CFF337EB];
  else
    return 10;
}

_id_8D01902B9D93B4C6() {
  drop_type = "brloot_plunder_cash_common_1";
  amount = 100;
  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4.origin = self.origin;
  _id_CB4FAD49263E20C4.angles = self.angles;
  _id_CB4FAD49263E20C4.payload = 13827;
  _id_CB4FAD49263E20C4.payload = 0;
  item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4, amount, 1, undefined, 1);
}

_id_D8E20B4DB8AA13DF(_id_8C3C8CE6ACCB8243) {
  return "container_ammo_box_01_nophysics";
}

_id_9E4552C702A237C5(player, _id_0D75739E39BC74E9) {
  _id_674582F0E7CE1160 = spawnStruct();
  _id_607D8B932B767CD1 = _id_0DE6F178182BA85A(_id_0D75739E39BC74E9);

  if(!isDefined(_id_607D8B932B767CD1)) {
    iprintlnbold("Cannot use this " + _id_0D75739E39BC74E9 + " attachment");
    _id_674582F0E7CE1160.attachment = "failed";
    return _id_674582F0E7CE1160;
  }

  _id_8C3C8CE6ACCB8243 = undefined;

  if(!_id_BD75D13C13984BD0(_id_0D75739E39BC74E9))
    _id_8C3C8CE6ACCB8243 = [_id_0D75739E39BC74E9];

  _id_2869A3A20D48E6AD = player getcurrentweapon();
  player._id_8EBBA13CC4B90346 = player _id_FB5497098DA5DB2A(_id_2869A3A20D48E6AD, _id_607D8B932B767CD1);

  if(!isDefined(player._id_8EBBA13CC4B90346) || player._id_8EBBA13CC4B90346.size == 0) {
    iprintlnbold("Cannot use this " + _id_0D75739E39BC74E9 + " attachment");
    _id_674582F0E7CE1160.attachment = "failed";
    return _id_674582F0E7CE1160;
  }

  _id_EFFB4AE1788A8B10 = player _id_BEA1EF4192C7C497(_id_2869A3A20D48E6AD, player._id_8EBBA13CC4B90346, _id_8C3C8CE6ACCB8243);

  if(isDefined(_id_EFFB4AE1788A8B10)) {
    _id_8A604011CF4BC484 = tablelookupistring("mp/attachmenttable.csv", 4, _id_EFFB4AE1788A8B10, 3);
    iprintlnbold(_id_EFFB4AE1788A8B10 + " / " + _id_EFFB4AE1788A8B10);
    iprintln(_id_8A604011CF4BC484);
    _id_87FD41FFD79D9072 = undefined;
    _id_0E2D00B1889EB04A = undefined;

    if(isDefined(self._id_87FD41FFD79D9072)) {
      _id_87FD41FFD79D9072 = self._id_87FD41FFD79D9072;
      _id_0E2D00B1889EB04A = self._id_0E2D00B1889EB04A;
    }

    _id_674582F0E7CE1160 = player _id_60FDADC426DB6334(_id_2869A3A20D48E6AD, _id_EFFB4AE1788A8B10, _id_87FD41FFD79D9072, _id_0E2D00B1889EB04A);
    return _id_674582F0E7CE1160;
  }

  iprintlnbold("Cannot use this " + _id_0D75739E39BC74E9 + " attachment");
  _id_674582F0E7CE1160.attachment = "failed";
  return _id_674582F0E7CE1160;
}

_id_BD75D13C13984BD0(_id_0D75739E39BC74E9) {
  switch (_id_0D75739E39BC74E9) {
    case "undermount":
    case "unique":
    case "optic":
    case "extra":
    case "reargrip":
    case "magazine":
    case "backpiece":
    case "muzzle":
    case "frontpiece":
    case "trigger":
      return 1;
  }

  return 0;
}

_id_0DE6F178182BA85A(_id_0D75739E39BC74E9) {
  switch (_id_0D75739E39BC74E9) {
    case "hybrid":
    case "optic":
    case "holo":
    case "reflex":
    case "therm":
    case "scope":
    case "acog":
      return "optic";
    case "choke":
    case "silencer":
    case "comp":
    case "brake":
    case "muzzle":
      return "muzzle";
    case "undermount":
    case "ubsh":
    case "gl":
    case "grip":
      return "undermount";
    case "cal":
    case "mags":
    case "magazine":
    case "drum":
      return "magazine";
    case "hammer":
    case "trig":
    case "trigger":
      return "trigger";
    case "reargrip":
    case "pistol":
      return "reargrip";
    case "unique":
      return "unique";
    default:
      return "optic";
  }

  return undefined;
}

_id_5FBCC7FC1266B377(_id_607D8B932B767CD1) {
  switch (_id_607D8B932B767CD1) {
    case "optic":
      return ["reflex", "therm", "acog", "hybrid", "holo", "scope"];
    case "muzzle":
      return ["silencer", "brake", "comp", "choke"];
    case "undermount":
      return ["grip", "gl", "ubsh"];
    case "magazine":
      return ["mags", "drum", "cal"];
    case "trigger":
      return ["trig", "hammer"];
    case "reargrip":
      return ["pistol"];
    case "unique":
      return ["unique"];
  }

  return undefined;
}

_id_4B8D9FCB8AF000F9(_id_0D75739E39BC74E9) {
  switch (_id_0D75739E39BC74E9) {
    case "optic":
      return &"CP_WEAPON_BUY/ATTACHMENT_OPTIC";
    case "reflex":
      return &"CP_WEAPON_BUY/ATTACHMENT_REFLEX";
    case "therm":
      return &"CP_WEAPON_BUY/ATTACHMENT_THERMAL";
    case "acog":
      return &"CP_WEAPON_BUY/ATTACHMENT_ACOG";
    case "hybrid":
      return &"CP_WEAPON_BUY/ATTACHMENT_HYBRID";
    case "holo":
      return &"CP_WEAPON_BUY/ATTACHMENT_HOLO";
    case "scope":
      return &"CP_WEAPON_BUY/ATTACHMENT_SNIPERSCOPE";
    case "choke":
    case "silencer":
    case "muzzle":
    case "flash":
    case "melee":
      return &"CP_WEAPON_BUY/ATTACHMENT_MUZZLE";
    case "brake":
      return &"CP_WEAPON_BUY/ATTACHMENT_BRAKE";
    case "comp":
      return &"CP_WEAPON_BUY/ATTACHMENT_COMP";
    case "undermount":
    case "bipod":
      return &"CP_WEAPON_BUY/ATTACHMENT_UNDERMOUNT";
    case "gl":
      return &"CP_WEAPON_BUY/ATTACHMENT_UBGL";
    case "ubsh":
      return &"CP_WEAPON_BUY/ATTACHMENT_UBSH";
    case "grip":
      return &"CP_WEAPON_BUY/ATTACHMENT_GRIP";
    case "cal":
    case "mags":
    case "magazine":
    case "drum":
      return &"CP_WEAPON_BUY/ATTACHMENT_MAGAZINE";
    case "stock":
    case "backpiece":
      return &"CP_WEAPON_BUY/ATTACHMENT_BACK";
    case "frontpiece":
    case "bar":
      return &"CP_WEAPON_BUY/ATTACHMENT_FRONT";
    case "hammer":
    case "trig":
    case "trigger":
      return &"CP_WEAPON_BUY/ATTACHMENT_TRIGGER";
    case "reargrip":
    case "pistol":
      return &"CP_WEAPON_BUY/ATTACHMENT_GRIP";
    case "unique":
      return &"CP_WEAPON_BUY/ATTACHMENT_UNIQUE";
  }

  return &"CP_WEAPON_BUY/ATTACHMENT_DEFAULT";
}

_id_FB5497098DA5DB2A(weapon, category) {
  weapon = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

  if(!isDefined(category) || category == "1")
    category = _id_2669878CF5A1B6BC::attachmentmap_tocategory(level.weaponattachments[weapon][0]);

  _id_28E5FD1571FAEC86 = [];

  if(!isDefined(level.weaponattachments[weapon]))
    return undefined;

  foreach(attachment in level.weaponattachments[weapon]) {
    if(scripts\engine\utility::string_starts_with(attachment, "pistolgrip")) {
      if(category == "reargrip")
        _id_28E5FD1571FAEC86[_id_28E5FD1571FAEC86.size] = attachment;

      continue;
    }

    if(_id_2669878CF5A1B6BC::attachmentmap_tocategory(attachment) == category)
      _id_28E5FD1571FAEC86[_id_28E5FD1571FAEC86.size] = attachment;
  }

  return _id_28E5FD1571FAEC86;
}

_id_BEA1EF4192C7C497(weapon, attachments, _id_8C3C8CE6ACCB8243) {
  if(isDefined(_id_8C3C8CE6ACCB8243)) {
    _id_055F75D9F16D814F = [];

    foreach(_id_88392C40E907845C in _id_8C3C8CE6ACCB8243) {
      foreach(attachment in attachments) {
        if(issubstr(attachment, _id_88392C40E907845C))
          _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = attachment;
      }
    }

    if(_id_055F75D9F16D814F.size == 0)
      return undefined;
    else
      attachments = _id_055F75D9F16D814F;
  }

  attachments = scripts\engine\utility::array_randomize(attachments);
  self._id_D1786583FCE8A543 = attachments[0];
  return self._id_D1786583FCE8A543;
}

_id_60FDADC426DB6334(weapon, attachment, _id_87FD41FFD79D9072, _id_0E2D00B1889EB04A) {
  attachments = getweaponattachments(weapon);
  _id_4F63AC1A66A909C3 = attachments;
  _id_3CEC9A92A775752E = 0;

  if(scripts\engine\utility::array_contains(attachments, attachment))
    _id_3CEC9A92A775752E = 1;

  attachments = scripts\engine\utility::array_add(attachments, attachment);
  attachments = scripts\engine\utility::array_remove_duplicates(attachments);
  _id_7312A46FA51227E3 = attachment;
  _id_0AA4E219EAFAA4D9 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  _id_74FFF52B1E2C1BFB = 0;

  if(weapon.inventorytype == "altmode")
    _id_74FFF52B1E2C1BFB = 1;

  clip_ammo = self getweaponammoclip(weapon);
  stock_ammo = self getweaponammostock(weapon);
  _id_58A72877A2D03F1A = undefined;
  _id_3EF7A96ABDE76230 = undefined;
  _id_7589F78D5D7BA855 = undefined;
  primary_weapons = self getweaponslistprimaries();

  foreach(_id_B71257AAAC24C36A in primary_weapons) {
    if(_id_B71257AAAC24C36A.basename == weapon.basename) {
      if(_id_B71257AAAC24C36A.inventorytype == "altmode") {
        _id_58A72877A2D03F1A = self getweaponammoclip(_id_B71257AAAC24C36A);
        _id_3EF7A96ABDE76230 = self getweaponammostock(_id_B71257AAAC24C36A);
        continue;
      }

      clip_ammo = self getweaponammoclip(_id_B71257AAAC24C36A);
      stock_ammo = self getweaponammostock(_id_B71257AAAC24C36A);
    }
  }

  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(weapon), attachments);
  _id_9009BFBC354A4C09 = getweaponattachments(_id_DD515FCF025B2E79);
  _id_4E5FDCB7F54380F7 = undefined;

  foreach(attachment in _id_4F63AC1A66A909C3) {
    found = 0;

    foreach(obj in _id_9009BFBC354A4C09) {
      if(attachment == obj)
        found = 1;
    }

    if(!found)
      _id_4E5FDCB7F54380F7 = attachment;
  }

  _id_2C9E4AC6987F5630 = _id_DD515FCF025B2E79.basename;
  _id_42006C656A8F39FB = undefined;
  _id_F24C44FF50730D8B = undefined;

  if(isDefined(_id_4E5FDCB7F54380F7)) {
    if(issubstr(_id_4E5FDCB7F54380F7, "gl") || issubstr(_id_4E5FDCB7F54380F7, "ubsh")) {
      _id_42006C656A8F39FB = _id_58A72877A2D03F1A;
      _id_F24C44FF50730D8B = _id_3EF7A96ABDE76230;
    } else
      _id_7589F78D5D7BA855 = 1;
  } else if(issubstr(_id_7312A46FA51227E3, "gl") || issubstr(_id_7312A46FA51227E3, "ubsh")) {
    if(_id_3CEC9A92A775752E) {
      _id_42006C656A8F39FB = _id_58A72877A2D03F1A;
      _id_F24C44FF50730D8B = _id_3EF7A96ABDE76230;
    }
  } else
    _id_7589F78D5D7BA855 = 1;

  self takeweapon(weapon);
  self giveweapon(_id_DD515FCF025B2E79);
  self switchtoweapon(_id_DD515FCF025B2E79);
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapon.basename == _id_2C9E4AC6987F5630) {
      if(weapon.inventorytype == "altmode") {
        if(isDefined(weapon.underbarrel)) {
          if(istrue(_id_7589F78D5D7BA855)) {
            self setweaponammoclip(weapon, _id_58A72877A2D03F1A);
            self setweaponammostock(weapon, _id_3EF7A96ABDE76230);
          } else {
            if(isDefined(_id_87FD41FFD79D9072))
              self setweaponammoclip(weapon, _id_87FD41FFD79D9072);
            else
              self setweaponammoclip(weapon, weaponclipsize(weapon));

            if(weapon.underbarrel == "ubshtgn")
              self setweaponammostock(weapon, 0);
            else if(isDefined(_id_0E2D00B1889EB04A))
              self setweaponammostock(weapon, _id_0E2D00B1889EB04A);
            else
              self setweaponammostock(weapon, scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon));
          }
        } else {
          self setweaponammoclip(weapon, clip_ammo);
          self setweaponammostock(weapon, stock_ammo);
        }

        continue;
      }

      self setweaponammoclip(weapon, clip_ammo);
      self setweaponammostock(weapon, stock_ammo);
    }
  }

  _id_674582F0E7CE1160 = spawnStruct();
  _id_674582F0E7CE1160.attachment = _id_4E5FDCB7F54380F7;

  if(isDefined(_id_42006C656A8F39FB)) {
    _id_674582F0E7CE1160._id_42006C656A8F39FB = int(float(_id_42006C656A8F39FB));
    _id_674582F0E7CE1160._id_F24C44FF50730D8B = int(float(_id_F24C44FF50730D8B));
  }

  return _id_674582F0E7CE1160;
}

_id_F0474C520F02DF01() {}