/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\intel\cp_intel.gsc
***********************************************/

intel_init() {
  level._id_364C64AC310725A0 = 1;
  level.intel_pieces = [];
  level._id_513DADE59614F0D7 = [];
  _id_479E458F6F530F0D::_id_58BF160252F94E21();
  _id_FE2F023D5E916D98();
  _id_73A0B19D74034096();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("intel_interaction", ::_id_D38777774E6E1884);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cp_intel_found", ::_id_8EE46D8DD9B85EB4);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("key_interaction", ::_id_C67A2A3C68F962A1);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Intel / Show Intel Positions\" \"set intel_outline 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Intel / Give All Intel For Level\" \"set intel_giveall 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_FE2F023D5E916D98() {
  level._id_513DADE59614F0D7 = [];
  index = 0;

  for(;;) {
    val = tablelookup("cp/cp_intel.csv", 0, index, 1);

    if(val == "") {
      break;
    }

    level._id_513DADE59614F0D7[index] = val;
    index++;
  }
}

_id_73A0B19D74034096() {
  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  wait 2;
  _id_3004DA8038B93D37 = scripts\engine\utility::getStructArray("cp_intel", "targetname");

  foreach(_id_C0C4728DA43FFC9E in _id_3004DA8038B93D37) {
    if(!isDefined(level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3]))
      level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3] = [];

    if(!isDefined(level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3][_id_C0C4728DA43FFC9E.script_noteworthy]))
      level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3][_id_C0C4728DA43FFC9E.script_noteworthy] = [];

    level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3][_id_C0C4728DA43FFC9E.script_noteworthy][level.intel_pieces[_id_C0C4728DA43FFC9E._id_D056801AAF3E50C3][_id_C0C4728DA43FFC9E.script_noteworthy].size] = _id_C0C4728DA43FFC9E;
  }

  _id_B3DDE316D267F803 = [];
  _id_5F9F112A3D6A73AF = [];
  keys = getarraykeys(level.intel_pieces);

  foreach(key in keys) {
    foreach(_id_F90358454413407F in level.intel_pieces[key]) {
      if(isarray(_id_F90358454413407F)) {
        _id_B3DDE316D267F803[_id_B3DDE316D267F803.size] = _id_F90358454413407F;
        continue;
      }

      _id_5F9F112A3D6A73AF[_id_5F9F112A3D6A73AF.size] = _id_F90358454413407F;
    }
  }

  foreach(_id_38E30F6F71988282 in _id_B3DDE316D267F803) {
    _id_38E30F6F71988282 = scripts\engine\utility::array_randomize(_id_38E30F6F71988282);
    _id_5F9F112A3D6A73AF[_id_5F9F112A3D6A73AF.size] = _id_38E30F6F71988282[0];
  }

  foreach(_id_F90358454413407F in _id_5F9F112A3D6A73AF) {
    _id_F90358454413407F._id_96477DA1695E035B = spawn("script_model", _id_F90358454413407F.origin);
    _id_F90358454413407F._id_96477DA1695E035B.angles = _id_F90358454413407F.angles;
    _id_F90358454413407F._id_96477DA1695E035B setModel(_id_F90358454413407F.scriptablename);
    _id_F90358454413407F._id_96477DA1695E035B._id_D056801AAF3E50C3 = _id_F90358454413407F._id_D056801AAF3E50C3;
    _id_F90358454413407F._id_96477DA1695E035B.info = _id_F90358454413407F.script_noteworthy;
    _id_F90358454413407F._id_96477DA1695E035B._id_681FC3D70CDD28DD = spawnscriptable("cp_intel_found", _id_F90358454413407F.origin, _id_F90358454413407F.angles);

    if(isDefined(_id_F90358454413407F.target)) {
      linkedent = getEnt(_id_F90358454413407F.target, "targetname");
      _id_F90358454413407F._id_96477DA1695E035B linkTo(linkedent);
      _id_F90358454413407F._id_96477DA1695E035B.linkedent = linkedent;
      offset = rotatevectorinverted(_id_F90358454413407F._id_96477DA1695E035B._id_681FC3D70CDD28DD.origin - linkedent.origin, linkedent.angles);
      _id_F90358454413407F._id_96477DA1695E035B._id_681FC3D70CDD28DD scripts\common\utility::_id_6E506F39F121EA8A(linkedent, offset);
    }

    if(_id_F90358454413407F._id_D056801AAF3E50C3 == "geiger" || _id_F90358454413407F._id_D056801AAF3E50C3 == "burried") {
      _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_F90358454413407F._id_96477DA1695E035B);
      _id_F90358454413407F._id_96477DA1695E035B._id_681FC3D70CDD28DD.origin = _id_F90358454413407F.origin + (0, 0, 18);
    }
  }

  if(getdvarint("intel_hud", 0) > 0) {
    foreach(player in level.players) {
      if(_id_5F9F112A3D6A73AF.size > 1)
        continue;
    }
  }

  level._id_ED3F685FFF07E56C = _id_5F9F112A3D6A73AF.size;
  level._id_7BED7FD13ABBBC9C = _id_5F9F112A3D6A73AF;
  setomnvar("ui_aar_intel_items_total", level._id_ED3F685FFF07E56C);
  level thread _id_7614FF4FF60038DB(_id_5F9F112A3D6A73AF);
  level thread _id_9F807F191F427B48();
  level thread _id_C27FBA0661CDCEE8();
}

_id_C27FBA0661CDCEE8() {
  foreach(struct in level._id_7BED7FD13ABBBC9C) {
    entity = struct._id_96477DA1695E035B;
    scriptable = entity._id_681FC3D70CDD28DD;
    scriptable.keepinmap = 1;
    scriptable._id_BBC200BC77C5DB2B = 1;
  }
}

_id_7614FF4FF60038DB(_id_5F9F112A3D6A73AF) {
  _id_B722E45993ECCB2A = 0;

  for(;;) {
    if(getdvarint("intel_outline", 0) > 0) {
      foreach(_id_96477DA1695E035B in _id_5F9F112A3D6A73AF) {
        if(!isDefined(_id_96477DA1695E035B._id_96477DA1695E035B))
          continue;
      }
    }

    if(getdvarint("dvar_FB385E7C0068A335", 0) > 0) {
      foreach(_id_96477DA1695E035B in level._id_7BED7FD13ABBBC9C) {
        if(!isDefined(_id_96477DA1695E035B._id_96477DA1695E035B.uses))
          _id_96477DA1695E035B._id_96477DA1695E035B.uses = 0;

        _id_96477DA1695E035B._id_96477DA1695E035B.uses++;
        _id_99676FB4E1A06631(_id_96477DA1695E035B, level.players[0]);
        _id_96477DA1695E035B._id_96477DA1695E035B disablescriptablepartplayeruse("intel_interaction", level.players[0]);
        _id_96477DA1695E035B._id_96477DA1695E035B hidefromplayer(level.players[0]);
        _id_96477DA1695E035B._id_96477DA1695E035B._id_681FC3D70CDD28DD enablescriptablepartplayeruse("cp_intel_found", level.players[0]);
        _id_96477DA1695E035B._id_96477DA1695E035B._id_681FC3D70CDD28DD setscriptablepartstate("cp_intel_found", "usable");
      }

      iprintlnbold("Gave All Intel For The Level");
      setDvar("dvar_FB385E7C0068A335", 0);
    }

    wait 1;
  }
}

_id_C67A2A3C68F962A1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
  wait 0.35;
  player playlocalsound("iw9_br_pickup_key");
  player._id_D203B9037BCF0441 = 1;
  instance.entity hide();
}

_id_D38777774E6E1884(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");

  if(!isDefined(instance.uses))
    instance.uses = 0;

  instance.uses++;
  _id_D056801AAF3E50C3 = instance._id_D056801AAF3E50C3;
  player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
  player playlocalsound("cp_generic_pickup_intel");
  _id_99676FB4E1A06631(instance, player);

  if(getdvarint("intel_hud", 0) > 0) {}

  player _id_D1C29EEBB4179B49(instance);
  player _id_3D5DC66341D1ED92::_id_1CAA50F367871948();
  player _id_3D5DC66341D1ED92::_id_5DA13CAC404268CB();
  player _id_0998572FF3C96EE5::_id_96AB127821B24D8F();
  instance disablescriptablepartplayeruse(part, player);
  wait 0.35;
  instance.entity hidefromplayer(player);

  foreach(playerent in level.players) {
    if(playerent != player) {
      if(!playerent _id_6FB0C700A7AAF634(instance))
        instance.entity._id_681FC3D70CDD28DD disablescriptablepartplayeruse("cp_intel_found", playerent);
    }
  }

  wait 5;
  instance.entity._id_681FC3D70CDD28DD enablescriptablepartplayeruse("cp_intel_found", player);
  instance.entity._id_681FC3D70CDD28DD setscriptablepartstate("cp_intel_found", "usable");

  foreach(playerent in level.players) {
    if(playerent != player) {
      if(!playerent _id_6FB0C700A7AAF634(instance))
        instance.entity._id_681FC3D70CDD28DD disablescriptablepartplayeruse("cp_intel_found", playerent);
    }
  }
}

_id_807054CFA320FF66() {
  if(!istrue(level._id_364C64AC310725A0)) {
    return;
  }
  player = self;

  if(!isDefined(player._id_023F0673432D1890)) {
    player._id_023F0673432D1890 = newclienthudelem(player);
    player._id_023F0673432D1890.alignx = "left";
    player._id_023F0673432D1890.location = 0;
    player._id_023F0673432D1890.foreground = 1;
    player._id_023F0673432D1890.fontscale = 0.8;
    player._id_023F0673432D1890.sort = 20;
    player._id_023F0673432D1890.alpha = 1;
    player._id_023F0673432D1890.x = 50;
    player._id_023F0673432D1890.y = 40;

    if(getdvarint("intel_hud", 0) > 0)
      return;
  }
}

_id_383BBAC10494B5FF() {
  if(istrue(self._id_383BBAC10494B5FF)) {
    return;
  }
  self._id_383BBAC10494B5FF = 1;
  thread _id_1B529F27946812EF();
}

_id_1B529F27946812EF() {
  self endon("disconnect");
  self setclientomnvar("ui_aar_intel_items_found", 0);

  if(!istrue(level._id_364C64AC310725A0)) {
    return;
  }
  while(!isDefined(level._id_7BED7FD13ABBBC9C))
    wait 1;

  foreach(_id_96477DA1695E035B in level._id_7BED7FD13ABBBC9C) {
    if(_id_6FB0C700A7AAF634(_id_96477DA1695E035B)) {
      if(!isDefined(_id_96477DA1695E035B._id_96477DA1695E035B.uses))
        _id_96477DA1695E035B._id_96477DA1695E035B.uses = 0;

      _id_96477DA1695E035B._id_96477DA1695E035B.uses++;
      _id_99676FB4E1A06631(_id_96477DA1695E035B, self);

      if(getdvarint("intel_hud", 0) > 0) {}

      _id_96477DA1695E035B._id_96477DA1695E035B disablescriptablepartplayeruse("intel_interaction", self);
      _id_96477DA1695E035B._id_96477DA1695E035B hidefromplayer(self);
      _id_96477DA1695E035B._id_96477DA1695E035B._id_681FC3D70CDD28DD enablescriptablepartplayeruse("cp_intel_found", self);
      _id_96477DA1695E035B._id_96477DA1695E035B._id_681FC3D70CDD28DD setscriptablepartstate("cp_intel_found", "usable");
      continue;
    }

    _id_96477DA1695E035B._id_96477DA1695E035B enablescriptablepartplayeruse("intel_interaction", self);
    _id_96477DA1695E035B._id_96477DA1695E035B._id_681FC3D70CDD28DD disablescriptablepartplayeruse("cp_intel_found", self);
  }
}

_id_99676FB4E1A06631(_id_96477DA1695E035B, player) {
  _id_0F5D35734C484490 = _id_96477DA1695E035B;

  if(isDefined(_id_96477DA1695E035B.entity))
    _id_0F5D35734C484490 = _id_96477DA1695E035B.entity;
  else if(isDefined(_id_96477DA1695E035B._id_96477DA1695E035B))
    _id_0F5D35734C484490 = _id_96477DA1695E035B._id_96477DA1695E035B;

  if(!isDefined(player._id_681FC3D70CDD28DD)) {
    player._id_681FC3D70CDD28DD = [];
    player._id_131E879B6BB142AC = 0;
  }

  if(!isDefined(player._id_681FC3D70CDD28DD[_id_0F5D35734C484490._id_D056801AAF3E50C3]))
    player._id_681FC3D70CDD28DD[_id_0F5D35734C484490._id_D056801AAF3E50C3] = [];

  player._id_681FC3D70CDD28DD[_id_0F5D35734C484490._id_D056801AAF3E50C3][player._id_681FC3D70CDD28DD[_id_0F5D35734C484490._id_D056801AAF3E50C3].size] = _id_0F5D35734C484490.info;
  player._id_131E879B6BB142AC++;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cp_intel", "givetoplayer")) {
    _id_FA03AB34CBDAECE2 = scripts\cp_mp\utility\script_utility::getsharedfunc("cp_intel", "givetoplayer");
    player thread[[_id_FA03AB34CBDAECE2]](_id_96477DA1695E035B);
  }

  if(isDefined(_id_0F5D35734C484490._id_D056801AAF3E50C3) && _id_0F5D35734C484490._id_D056801AAF3E50C3 == "geiger")
    level notify("geigerIntelGiven", player);

  player setclientomnvar("ui_aar_intel_items_found", player._id_131E879B6BB142AC);
}

_id_6FB0C700A7AAF634(_id_96477DA1695E035B) {
  _id_30CC48F18631B05A = _id_DE2EC54AE00C7B1E(_id_96477DA1695E035B);
  return self getplayerdata("cp", "cpIntel", _id_30CC48F18631B05A);
}

_id_D1C29EEBB4179B49(_id_96477DA1695E035B) {
  _id_30CC48F18631B05A = 1;
  _id_30CC48F18631B05A = _id_DE2EC54AE00C7B1E(_id_96477DA1695E035B);

  if(!_id_6FB0C700A7AAF634(_id_96477DA1695E035B)) {
    _id_3334275BE5515BDA = _id_0998572FF3C96EE5::_id_34819F005DAD50A9();
    self setplayerdata("cp", "totalIntel", _id_3334275BE5515BDA + 1);
    _id_3334275BE5515BDA = _id_0998572FF3C96EE5::_id_34819F005DAD50A9();

    if(_id_3334275BE5515BDA >= 20)
      scripts\cp\cp_achievement::_id_5979446EE216F232();
  }

  self setplayerdata("cp", "cpIntel", _id_30CC48F18631B05A, 1);
  thread _id_DB99538B03B9907C(_id_96477DA1695E035B, _id_30CC48F18631B05A);
  thread scripts\cp\cp_hud_message::showsplash("cp_intel_found_" + self._id_131E879B6BB142AC, level._id_7BED7FD13ABBBC9C.size, self);
}

_id_DB99538B03B9907C(_id_96477DA1695E035B, _id_30CC48F18631B05A) {
  if(!isDefined(_id_30CC48F18631B05A))
    _id_30CC48F18631B05A = 1;

  _id_238978CE0BF4DDB7 = scripts\cp\cp_analytics::_id_032900C5A73179B4();
  _id_841E07BE2EDA74B2 = scripts\cp\cp_analytics::_id_512417BDDBE63792();
  _id_1C7DBF040C780003 = _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = scripts\cp\cp_analytics::_id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  self dlog_recordplayerevent("dlog_event_cpdata_plr_found_intel", ["levelname", level.script, "name", self.name, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "intel_table_ref", "" + _id_30CC48F18631B05A, "player_kit", _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "sharedaccount_uid", _id_841E07BE2EDA74B2, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

_id_DE2EC54AE00C7B1E(_id_96477DA1695E035B) {
  foreach(index, _id_513DADE59614F0D7 in level._id_513DADE59614F0D7) {
    if(isstruct(_id_96477DA1695E035B)) {
      if(_id_513DADE59614F0D7 == _id_96477DA1695E035B._id_96477DA1695E035B.info)
        return index;
    } else if(_id_513DADE59614F0D7 == _id_96477DA1695E035B.entity.info)
      return index;
  }

  return undefined;
}

_id_0E6685BDE2112E37() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(player _id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter") || player _id_80E71AE6DD99CF74(self)) {
        self enablescriptablepartplayeruse("intel_interaction", player);
        self._id_681FC3D70CDD28DD enablescriptablepartplayeruse("cp_intel_found", player);
      } else {
        self disablescriptablepartplayeruse("intel_interaction", player);
        self._id_681FC3D70CDD28DD disablescriptablepartplayeruse("cp_intel_found", player);
      }

      waitframe();
    }

    wait 1;
  }
}

_id_80E71AE6DD99CF74(_id_96477DA1695E035B) {
  _id_F7F9975C75F63C8B = 0;

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(!player _id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter")) {
      continue;
    }
    if(distancesquared(player.origin, _id_96477DA1695E035B.origin) < 1048576)
      return 1;
  }

  return 0;
}

_id_9F807F191F427B48() {
  _id_0BA078DABF837C81 = getEnt("deskdrawer", "targetname");

  if(!isDefined(_id_0BA078DABF837C81)) {
    return;
  }
  _id_0BA078DABF837C81._id_884DD6B790DB5582 = spawn("script_model", _id_0BA078DABF837C81.origin + (0, 0, 2) + anglesToForward(_id_0BA078DABF837C81.angles + (0, -90, 0)) * 2);
  _id_0BA078DABF837C81._id_884DD6B790DB5582 setModel("tag_origin");
  _id_0BA078DABF837C81._id_884DD6B790DB5582 makeusable();
  _id_0BA078DABF837C81._id_884DD6B790DB5582 setHintString(&"CP_INTEL_IW9/OPEN_DRAWER");
  _id_0BA078DABF837C81._id_884DD6B790DB5582 setCursorHint("HINT_BUTTON");
  _id_0BA078DABF837C81._id_884DD6B790DB5582 sethintdisplayrange(150);
  _id_0BA078DABF837C81._id_884DD6B790DB5582 sethintdisplayfov(65);
  _id_0BA078DABF837C81._id_884DD6B790DB5582 setusefov(65);
  _id_0BA078DABF837C81._id_884DD6B790DB5582 setuserange(65);
  _id_0BA078DABF837C81._id_884DD6B790DB5582 sethintonobstruction("hide");
  _id_0BA078DABF837C81 thread _id_D6793FF179C0374B();
}

_id_D6793FF179C0374B(_id_23D618C7053F6873) {
  for(;;) {
    self._id_884DD6B790DB5582 waittill("trigger", ent);

    if(!ent scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self._id_884DD6B790DB5582 disableplayeruseforallplayers();

    if(!istrue(ent._id_D203B9037BCF0441)) {
      ent scripts\cp\cp_hud_message::tutorialprint(&"CP_INTEL_IW9/LOCKED", 2);
      self._id_884DD6B790DB5582 enableplayeruseforallplayers();
      continue;
    }

    break;
  }

  self._id_884DD6B790DB5582 delete();

  if(soundexists("cp_hydro_open_drawer"))
    self playSound("cp_hydro_open_drawer");

  self moveTo(self.origin + anglesToForward(self.angles + (0, -90, 0)) * 12, 1);
}

_id_659EEDA1BB608163() {
  level._id_1B411690973E8AFF = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("interact_main", ::_id_C5C7693371E9EBFC);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("interact_radio", ::_id_C5C7693371E9EBFC);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("interact_radar", ::_id_C5C7693371E9EBFC);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("interact_antenna", ::_id_C5C7693371E9EBFC);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("sat_interaction", ::_id_22B1DDDC0C1DAADC);
  _id_BE31E7030AEADF43 = getEnt("sat_main", "targetname");
  _id_BE31E7030AEADF43.antennae = getEnt("sat_antennae", "targetname");
  _id_BE31E7030AEADF43.radar = getEnt("sat_radar", "targetname");
  _id_BE31E7030AEADF43.radio = getEnt("sat_radio", "targetname");
  level._id_BE31E7030AEADF43 = _id_BE31E7030AEADF43;
  level._id_1B411690973E8AFF = [_id_BE31E7030AEADF43.antennae, _id_BE31E7030AEADF43.radar, _id_BE31E7030AEADF43.radio];
  level._id_E319F9BCB1DCC775 = 0;
}

_id_22B1DDDC0C1DAADC(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
  player playlocalsound("cp_generic_pickup");
  instance.entity hide();

  if(instance.entity == level._id_BE31E7030AEADF43.antennae) {
    level._id_BE31E7030AEADF43.antennae linkTo(level._id_BE31E7030AEADF43, "j_antenna_pivot", (0, 0, 0), (0, 0, 0));
    player._id_F9C2AA6BB00DBD44 = 1;
  } else if(instance.entity == level._id_BE31E7030AEADF43.radio) {
    level._id_BE31E7030AEADF43.radio linkTo(level._id_BE31E7030AEADF43, "j_controller_01", (0, 0, 0), (0, 0, 0));
    player._id_2C77748D45BD1B70 = 1;
  } else if(instance.entity == level._id_BE31E7030AEADF43.radar) {
    level._id_BE31E7030AEADF43.radar linkTo(level._id_BE31E7030AEADF43, "j_radar_rot_01", (0, 0, 0), (0, 0, 0));
    player._id_2C9A618D45E3395F = 1;
  }

  instance setscriptablepartstate(part, "unusable");
}

_id_C5C7693371E9EBFC(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_565DA6844875937A = 0;

  if(part == "interact_radio" && istrue(player._id_2C77748D45BD1B70)) {
    _id_565DA6844875937A = 1;
    level._id_BE31E7030AEADF43.radio show();
  } else if(part == "interact_antenna" && istrue(player._id_2C9A618D45E3395F)) {
    _id_565DA6844875937A = 1;
    level._id_BE31E7030AEADF43.radar show();
  } else if(part == "interact_radar" && istrue(player._id_F9C2AA6BB00DBD44)) {
    _id_565DA6844875937A = 1;
    level._id_BE31E7030AEADF43.antennae show();
  }

  if(!_id_565DA6844875937A) {
    return;
  }
  instance setscriptablepartstate(part, "unusable");
  level._id_E319F9BCB1DCC775++;

  if(level._id_E319F9BCB1DCC775 == 3) {
    level._id_BE31E7030AEADF43 setModel("military_deployable_satellite_rig_skeleton");
    level._id_BE31E7030AEADF43.antennae delete();
    level._id_BE31E7030AEADF43.radio delete();
    level._id_BE31E7030AEADF43.radar delete();
    level._id_BE31E7030AEADF43 setscriptablepartstate("base", "unfold");
    wait 7;
    level._id_BE31E7030AEADF43 setscriptablepartstate("base", "rotation_loop");
  }
}

_id_4F08AFA61F734625() {
  level._id_1462DC4EBE91527E = getEntArray("geiger_counter", "targetname");

  if(getdvarint("dvar_E45EBE94A1AC60BD", 0) != 0) {
    scripts\engine\utility::array_call(level._id_1462DC4EBE91527E, ::delete);
    return;
  }

  foreach(ent in level._id_1462DC4EBE91527E) {
    ent makeusable();
    ent setHintString(&"COOP_GAME_PLAY/GEIGER_COUNTER_INTERACTION");
    ent setCursorHint("HINT_BUTTON");
    ent sethinticon("hud_icon_equipment_geiger");
    ent sethintdisplayrange(150);
    ent sethintdisplayfov(65);
    ent setusefov(65);
    ent setuserange(65);
    ent sethintonobstruction("hide");
    ent thread _id_052D31DB6D260FBC();
  }
}

_id_052D31DB6D260FBC() {
  self notify("geigerCounterUseLoop");
  self endon("geigerCounterUseLoop");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player _id_7EF95BBA57DC4B82::hasequipment("equip_geigercounter")) {
      continue;
    }
    player thread scripts\cp\utility::playerplaypickupanim("iw9_ges_pickup");
    player playlocalsound("cp_generic_pickup");
    _id_3DA70B8624E508A3 = player _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
    _id_6C8A4DA181CD7A25 = undefined;

    if(isDefined(_id_3DA70B8624E508A3))
      _id_6C8A4DA181CD7A25 = player _id_7EF95BBA57DC4B82::getequipmentammo(_id_3DA70B8624E508A3);

    if(isDefined(_id_3DA70B8624E508A3) && isDefined(_id_6C8A4DA181CD7A25) && _id_6C8A4DA181CD7A25 > 0 && player _id_66122A002AFF5D57::_id_8A160D9935D47F5E(_id_3DA70B8624E508A3, "equipment", _id_6C8A4DA181CD7A25))
      player _id_66122A002AFF5D57::_id_9D094FAC5AE6454E(_id_3DA70B8624E508A3, "equipment", _id_6C8A4DA181CD7A25);

    player thread _id_7EF95BBA57DC4B82::giveequipment("equip_geigercounter", "secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo("equip_geigercounter", 1);
    level notify("geiger_given", player);
    self hidefromplayer(player);
  }
}

_id_8EE46D8DD9B85EB4(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");

  if(isDefined(player._id_0E278C25F33B395D)) {
    if(gettime() - player._id_0E278C25F33B395D < 4000)
      return;
  }

  player._id_0E278C25F33B395D = gettime();
  _id_6755441CC24E975B = level._id_ED3F685FFF07E56C - player._id_131E879B6BB142AC;

  if(isDefined(_id_6755441CC24E975B) && _id_6755441CC24E975B > 0)
    player thread scripts\cp\cp_hud_message::showsplash("cp_intel_already_found", _id_6755441CC24E975B, player);
  else
    player thread scripts\cp\cp_hud_message::showsplash("cp_intel_found_20", level._id_ED3F685FFF07E56C, player);

  wait 3;

  if(_id_6755441CC24E975B > 0) {
    _id_47402759F3DF2DF6 = [];

    foreach(_id_96477DA1695E035B in level._id_7BED7FD13ABBBC9C) {
      if(!player _id_6FB0C700A7AAF634(_id_96477DA1695E035B))
        _id_47402759F3DF2DF6[_id_47402759F3DF2DF6.size] = _id_96477DA1695E035B;
    }

    _id_3AED03D71CA95F80 = scripts\engine\utility::getclosest(player.origin, _id_47402759F3DF2DF6);
    _id_633CF60160097A37 = distance(player.origin, _id_3AED03D71CA95F80.origin);
    _id_633CF60160097A37 = _id_C3F45DE79D11B744(_id_633CF60160097A37);
    player thread scripts\cp\cp_hud_message::showsplash("cp_intel_already_found_proximity", _id_633CF60160097A37, player);
  }
}

_id_C3F45DE79D11B744(_id_CBF327F6DA336A3D) {
  return int(int(_id_CBF327F6DA336A3D) * 0.0254);
}