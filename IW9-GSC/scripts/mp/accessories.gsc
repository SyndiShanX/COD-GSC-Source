/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\accessories.gsc
***********************************************/

init() {
  level.accessoryinfo = [];
  level.accessoryinfobyindex = [];
  level.accessorylogicbyindex = [];
  level.accessoryattachment = [];
  level.accessorylogic = [];
  level.accessoryfullweapon = [];
  level.accessoryweaponbyindex = [];
  level.accessorybig = [];
  level.accessoryfem = [];
  level.accessoryattachmentfem = [];
  level.accessoryface = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    data = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 1);

    if(!isDefined(data) || data == "") {
      _id_CB89110314447B2F++;
      continue;
    }

    weapon = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 2);

    if(!isDefined(weapon) || weapon == "") {
      _id_CB89110314447B2F++;
      continue;
    }

    attachment = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 3);

    if(isDefined(attachment) && attachment == "")
      attachment = undefined;

    index = int(tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 10));

    if(isDefined(index))
      level.accessoryinfobyindex[index] = data;

    _id_ED9438247C546A7D = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 15);

    if(_id_ED9438247C546A7D != "") {
      level.accessorylogic[ref] = _id_ED9438247C546A7D;
      level.accessorylogicbyindex[index] = _id_ED9438247C546A7D;
    }

    _id_931DC91B635A1CA2 = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 17);

    if(_id_931DC91B635A1CA2 != "")
      level.accessorybig[weapon] = _id_931DC91B635A1CA2;

    _id_F5E34639B2AAA260 = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 18);

    if(_id_F5E34639B2AAA260 != "")
      level.accessoryfem[weapon] = _id_F5E34639B2AAA260;

    _id_EE77BB99805F2CD8 = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 16);

    if(_id_EE77BB99805F2CD8 != "")
      level.accessoryface[weapon] = _id_EE77BB99805F2CD8;

    _id_A68BF7CB10163268 = tablelookupbyrow("mp/accessorytable.csv", _id_CB89110314447B2F, 21);

    if(_id_A68BF7CB10163268 != "")
      level.accessoryfemband[weapon] = _id_A68BF7CB10163268;

    level.accessoryinfo[ref] = data;
    level.accessoryattachment[ref] = attachment;

    if(_id_EE77BB99805F2CD8 != "") {
      if(isDefined(attachment) && attachment != "") {
        level.accessoryfullweapon[ref] = weapon + "+" + _id_EE77BB99805F2CD8 + "+" + attachment;
        level.accessoryweaponbyindex[index] = weapon + "+" + _id_EE77BB99805F2CD8 + "+" + attachment;
      } else {
        level.accessoryfullweapon[ref] = weapon + "+" + _id_EE77BB99805F2CD8;
        level.accessoryweaponbyindex[index] = weapon + "+" + _id_EE77BB99805F2CD8;
      }
    } else if(isDefined(attachment) && attachment != "") {
      level.accessoryfullweapon[ref] = weapon + "+" + attachment;
      level.accessoryweaponbyindex[index] = weapon + "+" + attachment;
    } else {
      level.accessoryfullweapon[ref] = weapon;
      level.accessoryweaponbyindex[index] = weapon;
    }

    _id_CB89110314447B2F++;
  }
}

getaccessorylogic(ref) {
  if(!isDefined(level.accessorylogic))
    return undefined;

  return level.accessorylogic[ref];
}

getaccessorydata(ref) {
  if(!isDefined(level.accessoryinfo))
    return undefined;

  return level.accessoryinfo[ref];
}

getaccessoryweapon(ref) {
  if(!isDefined(level.accessoryfullweapon))
    return undefined;

  return level.accessoryfullweapon[ref];
}

getaccessoryweaponbyindex(index) {
  if(isDefined(level.accessoryweaponbyindex))
    return level.accessoryweaponbyindex[index];

  return "none";
}

getaccessorydatabyindex(index) {
  if(isDefined(level.accessoryinfobyindex))
    return level.accessoryinfobyindex[index];

  return "none";
}

getaccessorylogicbyindex(index) {
  if(isDefined(level.accessorylogicbyindex))
    return level.accessorylogicbyindex[index];

  return "none";
}

giveplayeraccessory(accessorydata, _id_D830F6C01B6D5949, accessorylogic) {
  clearplayeraccessory();
  _id_62681577C5058EE1 = getoperatorspecificaccessoryweapon(_id_D830F6C01B6D5949);

  if(!isDefined(_id_62681577C5058EE1)) {
    return;
  }
  self.accessorydata = accessorydata;
  self.accessorylogic = accessorylogic;
  self.accessoryfullweapon = _id_62681577C5058EE1;
  _id_BB9EEE998D441815 = shouldoperatorhideaccessoryworldmodel();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.accessoryfullweapon);
  self giveaccessory(self.accessorydata, self.accessoryfullweapon, _id_BB9EEE998D441815);

  if(isDefined(accessorylogic)) {
    switch (accessorylogic) {
      case "pet":
      case "pet_turbo":
      case "pet_black":
        break;
      case "heartbeat":
        break;
      case "thermometer":
        initthermometerwatch();
        break;
      case "holo":
        scripts\cp_mp\gestures::startholowatchvfx();
        break;
      default:
        break;
    }
  }
}

shouldoperatorhideaccessoryworldmodel() {
  _id_56E7CF38A4910BA2 = scripts\mp\teams::getcustomization();
  _id_5864EA4E21A60CD4 = _id_56E7CF38A4910BA2["body"];
  _id_0F3E1A92DD1178DA = tablelookup("mp/cac/bodies.csv", 1, _id_5864EA4E21A60CD4, 22);
  return isDefined(_id_0F3E1A92DD1178DA) && _id_0F3E1A92DD1178DA == "1";
}

getoperatorspecificaccessoryweapon(_id_D830F6C01B6D5949) {
  _id_56E7CF38A4910BA2 = scripts\mp\teams::getcustomization();
  _id_5864EA4E21A60CD4 = _id_56E7CF38A4910BA2["body"];
  _id_C235B5CBFDAA44C1 = tablelookup("mp/cac/bodies.csv", 1, _id_5864EA4E21A60CD4, 23);

  if(isDefined(_id_C235B5CBFDAA44C1)) {
    switch (_id_C235B5CBFDAA44C1) {
      case "fem":
        _id_F5E34639B2AAA260 = level.accessoryfem[_id_D830F6C01B6D5949];
        _id_BF171B605F5AD2A2 = level.accessoryattachmentfem[_id_D830F6C01B6D5949];

        if(isDefined(_id_F5E34639B2AAA260)) {
          _id_D830F6C01B6D5949 = _id_D830F6C01B6D5949 + _id_F5E34639B2AAA260;

          if(isDefined(_id_BF171B605F5AD2A2))
            _id_D830F6C01B6D5949 = _id_D830F6C01B6D5949 + _id_BF171B605F5AD2A2;
        }

        break;
      case "big":
        _id_931DC91B635A1CA2 = level.accessorybig[_id_D830F6C01B6D5949];

        if(isDefined(_id_931DC91B635A1CA2))
          _id_D830F6C01B6D5949 = _id_D830F6C01B6D5949 + _id_931DC91B635A1CA2;

        break;
      case "hide":
        _id_D830F6C01B6D5949 = undefined;
        break;
    }
  }

  if(isDefined(_id_D830F6C01B6D5949)) {
    attachment = level.accessoryattachment[_id_D830F6C01B6D5949];

    if(isDefined(attachment))
      _id_D830F6C01B6D5949 = _id_D830F6C01B6D5949 + attachment;
  }

  return _id_D830F6C01B6D5949;
}

testaccessoryvfx() {
  scripts\cp_mp\gestures::startbluntwatchvfx();
}

clearplayeraccessory() {
  self clearaccessory();

  if(isDefined(self.accessoryfullweapon) && self.accessoryfullweapon != "none") {
    if(self hasweapon(self.accessoryfullweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.accessoryfullweapon);

    self.gestureweapon = "none";
  }
}

initthermometerwatch() {
  if(!isDefined(self.thermometerwatch)) {
    self.thermometerwatch = 1;
    temp = getmapbaselinetempurature();
    self setclientomnvar("ui_pet_watch_state", temp);
  }
}

getmapbaselinetempurature() {
  switch (level.mapname) {
    case "cp_donetsk":
      return 74;
    case "mp_aniyah":
      return 81;
    case "mp_cave":
      return 80;
    case "mp_cave_am":
      return 40;
    case "mp_deadzone":
      return 36;
    case "mp_euphrates":
      return 95;
    case "mp_hackney_yard":
      return 49;
    case "mp_hackney_am":
      return 30;
    case "mp_petrograd":
      return 35;
    case "mp_piccadilly":
      return 55;
    case "mp_raid":
      return 65;
    case "mp_runner":
      return 50;
    case "mp_runner_pm":
      return 42;
    case "mp_spear":
      return 92;
    case "mp_spear_pm":
      return 82;
    case "mp_shipment":
      return 100;
    case "mp_m_exclusion":
      return 80;
    case "mp_m_hill":
      return 54;
    case "mp_m_hook":
      return 64;
    case "mp_m_king":
      return 68;
    case "mp_m_king_pm":
      return 68;
    case "mp_m_overunder":
      return 72;
    case "mp_m_pine":
      return 88;
    case "mp_rust":
      return 90;
    case "mp_m_speed":
      return 72;
    case "mp_m_speedball":
      return 79;
    case "mp_m_stack":
      return 65;
    case "mp_m_showers":
      return 38;
    case "mp_m_cargo":
      return 68;
    case "mp_m_cage":
      return 96;
    case "mp_quarry2":
      return 57;
    case "mp_downtown_gw":
      return 60;
    case "mp_farms2_gw":
      return 78;
    case "mp_m_overwinter":
      return 12;
    case "mp_port_gw":
      return 79;
    case "mp_vacant":
      return 80;
    case "mp_tenement":
      return 55;
    case "mp_aniyah_tac":
      return 81;
    default:
      return 68;
  }
}