/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\balloon_extract.gsc
****************************************************/

_id_9B095D72F2911EC8() {
  game["dialog"]["plunder_extract_fail_fulton"] = "plunder_plunder_extract_fail_fulton";
  level._effect["vfx_fulton_explode"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("balloon_extract_use", _id_048614492EF09B23::_id_CF1B1F86951A9209);
  level._id_392F3323920E27F8 = getdvarint("dvar_780B498909AD7B76", 4) - 1;
  level._id_3B87EF46EE857A23 = [];
}

_id_231A038D18C51203(grenade) {
  self endon("death_or_disconnect");
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    _id_F4DACBD721B7C845(grenade, stuckto);

    if(!isDefined(grenade.moving_platform)) {
      self playlocalsound("br_pickup_deny");
      scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_CANNOT_PLACE");

      if(isDefined(self.super))
        _id_28C5995798975A53();

      grenade delete();
      return;
    }
  }

  if(!_id_07ABACA741B57CEC(grenade)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_BLOCKED");

    if(isDefined(self.super))
      _id_28C5995798975A53();

    grenade delete();
    return;
  } else if(1 && isDefined(self._id_3F4415B5819AB778)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_TOO_MANY");

    if(isDefined(self.super))
      _id_28C5995798975A53();

    grenade delete();
    return;
  }

  if(isDefined(self.super))
    scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);

  _id_91BCBEABA08B3C76(grenade);

  if(isDefined(grenade))
    grenade delete();
}

_id_91BCBEABA08B3C76(grenade) {
  _id_3F4415B5819AB778 = spawn("script_model", grenade.origin);
  _id_3F4415B5819AB778 setautoboxcalculationusingdobj(1);
  _id_3F4415B5819AB778 setModel("military_skyhook_far_mp_ballon_extract");
  _id_3F4415B5819AB778.angles = grenade.angles * (0, 1, 0);
  _id_3F4415B5819AB778.owner = self;
  _id_3F4415B5819AB778.team = self.team;

  if(isDefined(grenade.moving_platform))
    _id_3F4415B5819AB778.moving_platform = grenade.moving_platform;

  self._id_3F4415B5819AB778 = _id_3F4415B5819AB778;
  _id_3F4415B5819AB778 _id_5B3519AD8F058A26();
}

_id_5B3519AD8F058A26() {
  playsoundatpos(self.origin, "iw9_extraction_balloon_drop");
  thread _id_1E4A61DB11011446::teamsplashbr("br_fulton_device_placed", self.owner, self.team);

  if(isDefined(self.moving_platform))
    self linkTo(self.moving_platform);

  thread _id_9F3765A323F6212A();
}

_id_9F3765A323F6212A() {
  level endon("game_ended");
  scriptable = self getlinkedscriptableinstance();
  scriptable._id_FEBE9AACDD2E47B2 = !getdvarint("dvar_1D7F857B2CD9DBA2", 0);
  self setscriptablepartstate("anims", "opening");
  self setscriptablepartstate("balloon_extract_use", "usable");
  _id_C0BC9948AAB59AC2 = [];

  foreach(player in level.players) {
    if(player.team == self.team) {
      _id_C0BC9948AAB59AC2[_id_C0BC9948AAB59AC2.size] = player;
      player scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_TIP");
      continue;
    }

    scriptable disablescriptableplayeruse(player);
  }

  wait(_id_D55141FE77FA88E8());
  self setscriptablepartstate("anims", "open");
  thread _id_26E3EDE964CF78D9(_id_C0BC9948AAB59AC2);
  wait 30;
  self setscriptablepartstate("balloon_extract_use", "unusable");
  self setscriptablepartstate("effects", "neutral");

  foreach(player in scriptable._id_2BC73315BD31809C) {
    if(isalive(player))
      player setclientomnvar("loot_container_open", 0);
  }

  self setscriptablepartstate("anims", "takeoff");
  wait(_id_529ACF4763E6ABC7());
  scriptable _id_8E5AAB643E51AAF9();
  self notify("death");
  self delete();
}

_id_8E5AAB643E51AAF9() {
  foreach(player in self._id_2BC73315BD31809C) {
    if(!isDefined(self._id_556DB0B72A96514E)) {
      continue;
    }
    player _id_2D9D24F7C63AC143::_id_F1F10297297D06C8();
    _id_E1CF43F3AE9D77E7 = _id_9E02F22DECAAAF1F(self._id_556DB0B72A96514E[player.guid].contents);
    _id_BBAC576AADE31A1E = player _id_6FC415FF6A905DC1::_id_E2F4F470C55123B8(_id_E1CF43F3AE9D77E7, 1);

    foreach(item in self._id_556DB0B72A96514E[player.guid].contents) {
      ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item["lootID"]);
      _id_25978461C6E4F61B = level.br_pickups._id_838863C4848D4C26[ref];
      itemtype = undefined;

      if(isDefined(_id_25978461C6E4F61B))
        itemtype = level.br_pickups.br_itemtype[_id_25978461C6E4F61B];

      if(isDefined(itemtype) && (itemtype == "valuable" || itemtype == "dogtag")) {
        continue;
      }
      player _id_6FC415FF6A905DC1::_id_C324D060CDE743E3(item["lootID"], item["quantity"]);
    }

    _id_98F7CE981BB1F93C = player scripts\mp\loot::_id_D6A3266145BAB76D("loot_container_weapon");

    if(istrue(_id_98F7CE981BB1F93C))
      player _id_6FC415FF6A905DC1::_id_C324D060CDE743E3(_id_98F7CE981BB1F93C, 1);

    player _id_2D9D24F7C63AC143::_id_F1F10297297D06C8();
    _id_68C58FC50DB46DC6 = player getplayerdata(level._id_5D69837CF4DB0407, "dmzBankedCash");
    player setplayerdata(level._id_5D69837CF4DB0407, "dmzBankedCash", _id_68C58FC50DB46DC6 + _id_BBAC576AADE31A1E);
    _id_B8F5D813D9E1194E = undefined;

    if(istrue(_id_98F7CE981BB1F93C)) {
      _id_B8F5D813D9E1194E = spawnStruct();
      _id_B8F5D813D9E1194E.lootid = _id_98F7CE981BB1F93C;
      _id_B8F5D813D9E1194E.quantity = 1;
      _id_E1CF43F3AE9D77E7[_id_E1CF43F3AE9D77E7.size] = _id_B8F5D813D9E1194E;
    }

    _id_6A8EC730B2BFA844::_id_B0537EE3A491B4DD(player, _id_E1CF43F3AE9D77E7, _id_BBAC576AADE31A1E);

    if(!istrue(self._id_FEBE9AACDD2E47B2))
      player setclientomnvar("loot_container_weapon", 0);

    player._id_3EEDB8574BAE470A = undefined;
  }
}

_id_D55141FE77FA88E8() {
  return [[level._id_74320167A9D0ECAC]]("wm_skyhook_ground_open");
}

_id_529ACF4763E6ABC7() {
  return [[level._id_74320167A9D0ECAC]]("wm_skyhook_ground_takeoff");
}

_id_F4DACBD721B7C845(grenade, stuckto) {
  if(isDefined(stuckto.linked_brush)) {
    if(isDefined(stuckto.linked_brush.targetname)) {
      if(stuckto.linked_brush.targetname == "train_wz")
        grenade.moving_platform = stuckto;
    }
  } else if(isDefined(stuckto.targetname) && stuckto.targetname == "train_wz")
    grenade.moving_platform = stuckto;
}

_id_28C5995798975A53() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::setsuperisinuse(0);
  scripts\mp\supers::setsuperexpended(0);
  _id_19163E14365D9264.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}

_id_07ABACA741B57CEC(grenade) {
  _id_57F6E7D1BE00D5F9 = 25;
  _id_76AB620FD7CC70BD = scripts\cp_mp\parachute::getc130height();
  start = grenade.origin + (0, 0, _id_57F6E7D1BE00D5F9 + 1);
  end = (grenade.origin[0], grenade.origin[1], _id_76AB620FD7CC70BD);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(start, end, _id_57F6E7D1BE00D5F9, grenade, contents);
  return _id_E96577032A7740FC["fraction"] == 1.0;
}

_id_9E02F22DECAAAF1F(contents) {
  _id_1C1DD30A3C77139C = [];

  foreach(key, item in contents) {
    _id_1C1DD30A3C77139C[key] = spawnStruct();
    _id_1C1DD30A3C77139C[key].lootid = item["lootID"];
    _id_1C1DD30A3C77139C[key].quantity = item["quantity"];
    _id_1C1DD30A3C77139C[key].index = item["index"];
  }

  return _id_1C1DD30A3C77139C;
}

_id_CBCA59C109AE17AF(itemtype, _id_3793828403C6873E) {
  switch (itemtype) {
    case 0:
      return [8395, 5];
    case 1:
      if(_id_3793828403C6873E == 2) {
        if(!_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self))
          return [0, 0, undefined];

        lootid = self getplayerdata(level._id_5D69837CF4DB0407, "dmzWeapon", "lootItemID");
        _id_0EC22A950F210E39 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(self);
        return [lootid, 1, _id_0EC22A950F210E39];
      }

      _id_0EC22A950F210E39 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_3793828403C6873E);

      if(!isDefined(_id_0EC22A950F210E39))
        return [0, 0, undefined];

      _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(_id_0EC22A950F210E39);
      variantid = _id_0EC22A950F210E39.variantid;

      if(!isDefined(_id_0EC22A950F210E39.variantid))
        variantid = 0;

      lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);
      return [lootid, 1, _id_0EC22A950F210E39];
    case 10:
      lootid = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_3793828403C6873E);
      quantity = 1;

      if(_id_7E52B56769FA7774::_id_D345EEC68E01361F(lootid))
        quantity = _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_3793828403C6873E);

      return [lootid, quantity];
    case 2:
      slot = scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E);

      if(!isDefined(self.equipment[slot]))
        return [0, 0];

      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      return [lootid, 1];
    case 3:
      if(!isDefined(self.streakdata.streaks[1]))
        return [0, 0];

      scriptable = level.br_pickups._id_838863C4848D4C26[self.streakdata.streaks[1].streakname];
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptable);
      return [lootid, 1];
    case 4:
      if(!isDefined(self.equipment["super"]))
        return [0, 0];

      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_FEB782334DD23A66);
      return [lootid, 1];
    default:
      return;
  }
}

_id_26E3EDE964CF78D9(players) {
  if(players.size <= 0) {
    level notify("balloon_extract_takeoff");
    return;
  }

  if(!isDefined(level._id_3B87EF46EE857A23))
    level._id_3B87EF46EE857A23 = [];

  if(isDefined(level._id_3B87EF46EE857A23[self.team]))
    level._id_3B87EF46EE857A23[self.team] notify("balloon_extract_countdown_started");

  level._id_3B87EF46EE857A23[self.team] = self;
  self endon("balloon_extract_countdown_started");
  level endon("game_ended");
  currenttime = gettime();
  endtime = currenttime + 30000;

  while(currenttime < endtime) {
    if(gettime() - currenttime >= 1000) {
      _id_44C653D588DB89A7 = int(max(0, (endtime - gettime()) / 1000));

      foreach(player in players) {
        if(isDefined(player) && isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayeringulag())
          player scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_LEAVING_IN", _id_44C653D588DB89A7);
      }

      currenttime = gettime();
    }

    wait 0.05;
  }

  level._id_3B87EF46EE857A23[self.team] = undefined;
}

_id_6DE1128240216723(itemtype, lootid) {
  if(itemtype == 1)
    return 1;

  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(scriptablename == "brloot_durable_loot" || isDefined(level._id_A98214B4BDC952CD) && scripts\engine\utility::array_contains(level._id_A98214B4BDC952CD, scriptablename))
    return 1;

  return 0;
}

_id_F71F8470E2FB527C(player) {
  _id_CCC0DF5641A7616B = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player);
  _id_BB778D2BE7708CFC = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CCC0DF5641A7616B; _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(!isDefined(_id_F1CBC68C79EBF1EA)) {
      continue;
    }
    _id_A1093166DE09E6B8 = _id_2D9D24F7C63AC143::_id_91C1BE871300A518(_id_F1CBC68C79EBF1EA);

    if(!isDefined(_id_A1093166DE09E6B8)) {
      continue;
    }
    if(_id_A1093166DE09E6B8 == "brloot_durable_loot") {
      player _id_F184AE16FB9720F3(_id_AC0E594AC96AA3A8);
      _id_BB778D2BE7708CFC = 1;
      return;
    }
  }

  if(_id_BB778D2BE7708CFC)
    player _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(1, "extractionBalloonDeposit");
}

_id_F184AE16FB9720F3(_id_93C2531ABECB92E3) {
  thread _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_93C2531ABECB92E3, 1);
  thread scripts\mp\hud_message::showsplash("br_durable_loot_item_extracted");
}