/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_plunder.gsc
***********************************************/

init() {
  level.br_plunder_enabled = getdvarint("dvar_D541BE8CE632EAC6", 1) != 0;
  thread setupplunderextractionsites();

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  initheliextractanims();
  inithelipropanims();
  level._effect["vfx_extract_smoke"] = loadfx("vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker");
  level._effect["vfx_br_cashLeaderBag"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx");
  level.br_plunder_lobby = getdvarint("dvar_A17AADC2E70FAAD1", 0) != 0 && istrue(level.allowprematchdamage);
  level.br_plunder = spawnStruct();
  level.br_plunder.plunderlimit = 131071;
  level.br_plunder.plunder_items_picked_up = 0;
  level.br_plunder.plunder_value_picked_up = 0;
  level.br_plunder.plunder_items_dropped = 0;
  level.br_plunder.plunder_value_dropped = 0;
  level.br_plunder.kiosk_spent_total = 0;
  level.br_plunder.kiosk_num_purchases = 0;
  level.br_plunder.extraction_balloon_total_plunder = 0;
  level.br_plunder.extraction_balloon_num_completed = 0;
  level.br_plunder.extraction_helicoptor_total_plunder = 0;
  level.br_plunder.extraction_helicoptor_num_completed = 0;
  level.br_plunder.plunder_awarded_by_missions_total = 0;
  level.br_plunder.itemsinworld = [];
  level.br_plunder.itemsinworld["brloot_plunder_cash_common_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_common_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_uncommon_3"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_uncommon_3");
  level.br_plunder.itemsinworld["brloot_plunder_cash_rare_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_rare_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_rare_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_rare_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_epic_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_epic_1");
  level.br_plunder.itemsinworld["brloot_plunder_cash_epic_2"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_epic_2");
  level.br_plunder.itemsinworld["brloot_plunder_cash_legendary_1"] = getscriptablelootspawnedcountbyname("brloot_plunder_cash_legendary_1");
  level.br_plunder.itemsinworld["br_loot_cache"] = getscriptablelootspawnedcountbyname("br_loot_cache");
  level.br_plunder.itemsinworld["brloot_mission_tablet"] = getscriptablelootspawnedcountbyname("brloot_mission_tablet");
  setupquantities();
  initvo();
  initplunderpads();

  if(!isDefined(level.minplunderdropondeath))
    level.minplunderdropondeath = 0;

  level.br_depots = [];
  level thread plunder_economy_shapshot_loop();
  level thread plunder_infils_ready();

  if(inplunderlivelobby()) {
    level.br_plunder_ents = [];
    thread plunderlivelobby();
  }

  initplayerplunderevents();
  plunder_initrepositories();
  scripts\mp\equipment\fulton::fulton_init();
  initteamdatafields();
  inithelirepository();

  if(getdvarint("dvar_91FBC1BBAC0C27D7", 0) == 1)
    processcashpilevalueoverrides();

  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(0, ::dangercircletick, ::_id_1A1709943670772A);

  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("eqp_extraction_balloon");
}

plunder_economy_shapshot_loop(duration, safecircleent, _id_FB3B2613D6F0EB05) {
  level endon("game_ended");
  level waittill("prematch_started");

  for(;;) {
    level waittill("br_circle_started");
    activeplayers = [];

    foreach(player in level.players) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player))
        activeplayers[activeplayers.size] = player;
    }

    _id_715028F54BAD19A1::branalytics_economy_snapshot(activeplayers);
  }
}

plunder_infils_ready() {
  _id_DC4FDC0D3E50E80B = getdvarint("dvar_611D72C9417EE39E", 0);
  _id_D437BEA518F94DD0 = getdvarint("dvar_B26DA3EE25C25A6C", _id_DC4FDC0D3E50E80B);

  if(!_id_DC4FDC0D3E50E80B && !_id_D437BEA518F94DD0) {
    return;
  }
  level waittill("infils_ready");

  foreach(player in level.players)
  player playersetplundercount(scripts\engine\utility::ter_op(isbot(player), _id_D437BEA518F94DD0, _id_DC4FDC0D3E50E80B));
}

modify_plunder_itemsinworld(itemname, _id_BC23CE7464AA4861) {
  if(level.br_plunder_enabled)
    level.br_plunder.itemsinworld[itemname] = level.br_plunder.itemsinworld[itemname] + _id_BC23CE7464AA4861;
}

setupquantities() {
  level.br_plunder.quantity = [];
  level.br_plunder.names = [];
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_common_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_uncommon_3";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_rare_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_rare_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_epic_1";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_epic_2";
  level.br_plunder.names[level.br_plunder.names.size] = "brloot_plunder_cash_legendary_1";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder.names.size; _id_AC0E594AC96AA3A8++) {
    level.br_plunder.quantity[_id_AC0E594AC96AA3A8] = level.br_pickups.counts[level.br_plunder.names[_id_AC0E594AC96AA3A8]];

    if(isDefined(level.br_plunder.quantity[_id_AC0E594AC96AA3A8 - 1])) {}
  }
}

initvo() {
  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    game["dialog"]["plunder_extract_requested"] = "perq_wzan_plnd";
    game["dialog"]["plunder_extract_chopper_arrive"] = "peca_wzan_plnd";
    game["dialog"]["plunder_extract_chopper_leave"] = "pecl_wzan_plnd";
    game["dialog"]["plunder_extract_success"] = "pecl_wzan_plnd";
    game["dialog"]["plunder_extract_fail_chopper"] = "pefc_wzan_plnd";
  } else {
    game["dialog"]["plunder_extract_requested"] = "plunder_plunder_extract_requested";
    game["dialog"]["plunder_extract_chopper_arrive"] = "plunder_plunder_extract_chopper_arrive";
    game["dialog"]["plunder_extract_chopper_leave"] = "plunder_plunder_extract_chopper_leave";
    game["dialog"]["plunder_extract_success"] = "plunder_plunder_extract_success";
    game["dialog"]["plunder_extract_fail_chopper"] = "plunder_plunder_extract_fail_chopper";
  }
}

initplunderpads() {
  level.plunderpads = getEntArray("extract_pad", "targetname");
}

playerplaybankanim() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
    return;
  }
  _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_cash_handoff", 1.84);
}

playerremoveplunderfrominventory() {
  foreach(index, item in self.br_inventory_slots) {
    if(item.scriptablename == "brloot_plunder_cash_uncommon_1") {
      _id_2CEDCC356F1B9FC8::removeitemfrominventory(index);
      return;
    }
  }
}

disablealldepotsforplayer(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_depots.size; _id_AC0E594AC96AA3A8++) {
    _id_FB7C65E67A8EED31 = level.br_depots[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_FB7C65E67A8EED31) && !istrue(_id_FB7C65E67A8EED31.disabled))
      _id_FB7C65E67A8EED31 depotmakeunusabletoplayer(player);
  }
}

enablealldepotsforplayer(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_depots.size; _id_AC0E594AC96AA3A8++) {
    _id_FB7C65E67A8EED31 = level.br_depots[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_FB7C65E67A8EED31) && !istrue(_id_FB7C65E67A8EED31.disabled))
      _id_FB7C65E67A8EED31 depotmakeusabletoplayer(player);
  }
}

depotmakeusabletoplayer(player) {
  self enableplayeruse(player);

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
}

depotmakeunusabletoplayer(player) {
  self disableplayeruse(player);

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
}

depotmakeunsabletoall() {
  self makeunusable();

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  }
}

initplayer(_id_9156B53BCF7CE573) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  if(!isDefined(self.plunderbanked))
    self.plunderbanked = 0;

  if(!isDefined(self.haspickedupplunderyet))
    self.haspickedupplunderyet = 0;

  if(self.plundercount == 0) {
    _id_DC4FDC0D3E50E80B = 0;

    if(!istrue(_id_9156B53BCF7CE573) && _id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
      _id_0B7A9CE0A2282B79::_id_7D760EDC2A7E9B8F(self);
      _id_DC4FDC0D3E50E80B = _id_0B7A9CE0A2282B79::_id_56EC0560843AA9A4(self);
      _id_DC4FDC0D3E50E80B = scripts\engine\utility::_id_53C4C53197386572(_id_DC4FDC0D3E50E80B, 0);
    }

    playersetplundercount(_id_DC4FDC0D3E50E80B);
  }
}

playerdropplunder() {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  playersetplundercount(0);
}

bankplunderongameended() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(isDefined(player.plundercount) && player.plundercount > 0)
      player playerplunderbank(player.plundercount);
  }
}

playerdropplunderondeath(dropstruct, attacker, _id_1AD2DB70C8D01F51) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("playerDropPlunderOnDeath", dropstruct, attacker))) {
    return;
  }
  _id_CB4FAD49263E20C4 = _id_79275E2FAB13F54D();
  _id_6AEE9C9054F09ED5 = _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5;
  _id_B64F283113C99581 = _id_CB4FAD49263E20C4._id_B64F283113C99581;
  self.plundercountondeath = _id_6AEE9C9054F09ED5;
  playersetplundercount(_id_6AEE9C9054F09ED5);

  if(_id_B64F283113C99581 <= 0) {
    return;
  }
  dropcondensedplunder(_id_B64F283113C99581, dropstruct, _id_1AD2DB70C8D01F51);
}

_id_79275E2FAB13F54D() {
  _id_2927ED03B21BB4FD = getdvarfloat("dvar_ACCA41B38E6BA772", 1.2);
  save = getdvarfloat("dvar_5AD499326624AFF9", 10.0);
  _id_E9B068032AC9D846 = getdvarfloat("dvar_CF0D31CCF65B3F19", 0.0);
  _id_920F4173513EB6B8 = getdvarfloat("dvar_AB0B2C9B32A636B9", 10.0);

  if(_id_7E52B56769FA7774::_id_E351A4B1C26EC991("life_insurance")) {
    _id_A15A2585E2A11EEB = getdvarfloat("dvar_8C811D887E1F3FA0", 10.0);
    save = save + _id_A15A2585E2A11EEB;
  }

  _id_2CE07AC87B732035 = save + _id_E9B068032AC9D846 + _id_920F4173513EB6B8;
  _id_781B96DA8B886296 = save / _id_2CE07AC87B732035;
  _id_5770AB9FF77A3D04 = _id_E9B068032AC9D846 / _id_2CE07AC87B732035;
  _id_745A0BA506902BFA = _id_920F4173513EB6B8 / _id_2CE07AC87B732035;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    _id_258681915091F653 = self.plundercount * _id_2927ED03B21BB4FD;
  else
    _id_258681915091F653 = 0;

  if(isDefined(level.gulag) && _id_2CEDCC356F1B9FC8::isplayeringulag()) {
    _id_6AEE9C9054F09ED5 = int(_id_258681915091F653);
    _id_B64F283113C99581 = 0;
  } else {
    _id_6AEE9C9054F09ED5 = int(min(_id_258681915091F653, max(2, int(_id_258681915091F653 * _id_781B96DA8B886296))) + 0.5);
    _id_B64F283113C99581 = int(max(level.minplunderdropondeath, int(_id_258681915091F653 * _id_745A0BA506902BFA)));
  }

  if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "resurgence_mgl" || scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "champion") {
    _id_2F4D746A1FB62B86 = getdvarint("dvar_2F4425BB12BFE827", 0);

    if(_id_6AEE9C9054F09ED5 < _id_2F4D746A1FB62B86)
      _id_6AEE9C9054F09ED5 = _id_2F4D746A1FB62B86;
  }

  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4._id_6AEE9C9054F09ED5 = _id_6AEE9C9054F09ED5;
  _id_CB4FAD49263E20C4._id_B64F283113C99581 = _id_B64F283113C99581;
  return _id_CB4FAD49263E20C4;
}

takeplunderpickup(pickupent) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  amount = 1;

  if(isDefined(pickupent.count))
    amount = pickupent.count;

  if(scripts\engine\utility::array_contains(level.br_plunder.names, pickupent.scriptablename)) {
    playerplunderpickup(amount, undefined, undefined, 1);
    level.br_plunder.plunder_items_picked_up = level.br_plunder.plunder_items_picked_up + 1;
    level.br_plunder.plunder_value_picked_up = level.br_plunder.plunder_value_picked_up + amount;
    modify_plunder_itemsinworld(pickupent.scriptablename, -1);
    type = "loot";

    if(isDefined(pickupent.instance) && isDefined(pickupent.instance.lootsource))
      type = pickupent.instance.lootsource;

    _id_715028F54BAD19A1::trackcashevent(self, type, amount);

    if(isDefined(pickupent.instance) && istrue(pickupent.instance._id_6216E086379DEF7D)) {
      return;
    }
    _id_05A2284274D70F7D(0, amount);
  } else
    _id_7E52B56769FA7774::trypickupitem(pickupent.scriptablename, amount);

  level notify("collect_cash_" + self.team, self, pickupent.count);
}

_id_5EFEFF555D3C3AB4(itemname) {
  switch (itemname) {
    case "credit_card":
      return 0;
    case "life_insurance":
      return 1;
  }

  scripts\mp\utility\script::demoforcesre("Persistent item \"" + itemname + "\" does not have a corresponding omnvar bit.");
}

initplayerplunderevents() {
  omnvars = [];
  omnvars[1] = "ui_cash_pickedup";
  omnvars[2] = "ui_cash_pickedup";
  level.playerplundereventomnvars = omnvars;
  callbacks = [];
  callbacks[1] = ::playerplunderpickupcallback;
  callbacks[2] = ::playerplunderdepositcallback;
  callbacks[3] = ::playerplunderbankcallback;
  callbacks[4] = ::playerplunderlosecallback;
  callbacks[5] = ::playerplunderbankdepositcallback;
  callbacks[6] = ::playerplunderlosedepositcallback;
  level.playerplundereventcallbacks = callbacks;
}

playerplunderpickup(amount, data, _id_3108C5D4E33B7014, _id_CC1314400858994C) {
  data = playerplunderevent(amount, 1, undefined, data, _id_3108C5D4E33B7014);

  if(!istrue(_id_CC1314400858994C) && isDefined(data) && isDefined(data.plunderdelta) && data.plunderdelta > 0)
    scripts\cp_mp\challenges::_id_563606223EF09517(self, data.plunderdelta);
}

playerplunderdeposit(amount, entity, data) {
  return playerplunderevent(amount, 2, entity, data);
}

playerplunderbank(amount, entity, data) {
  return playerplunderevent(amount, 3, entity, data);
}

playerplunderlose(amount, data) {
  return playerplunderevent(amount, 4, undefined, data);
}

playerplunderbankdeposit(amount, entity, data) {
  return playerplunderevent(amount, 5, entity, data);
}

playerplunderlosedeposit(amount, entity, data) {
  return playerplunderevent(amount, 6, entity, data);
}

playerplunderkioskpurchase(amount, data) {
  _id_B44212E15FCE8588 = playerplunderevent(amount, 4, undefined, data);

  if(isDefined(_id_B44212E15FCE8588)) {
    _id_B70C878DE3673730 = "highestPurchaseCost";

    if(!isDefined(self.pers[_id_B70C878DE3673730]) || self.pers[_id_B70C878DE3673730] < amount)
      self.pers[_id_B70C878DE3673730] = amount;
  }

  if(_id_7E52B56769FA7774::_id_E351A4B1C26EC991("credit_card")) {
    _id_071620739FFD8161 = amount * getdvarfloat("dvar_81E74D71F032F681", 0.1);
    playerplunderpickup(int(_id_071620739FFD8161));
    _id_05A2284274D70F7D(0, _id_071620739FFD8161);
  }

  _id_05A2284274D70F7D(4, amount);
  return _id_B44212E15FCE8588;
}

playerplunderdrop(amount, data) {
  return playerplunderevent(amount, 4, undefined, data);
}

_id_2334BCC55C8A6242(amount, data) {
  return playerplunderevent(amount, 1, undefined, data);
}

playerplunderevent(amount, type, entity, data, _id_3108C5D4E33B7014) {
  if(!istrue(level.br_plunder_enabled) || !isDefined(self.plundercount)) {
    return;
  }
  if(istrue(_id_3108C5D4E33B7014) && amount <= 0) {
    return;
  }
  if(type == 2 || type == 3 || type == 4)
    amount = int(min(self.plundercount, amount));

  if(!isDefined(self.plundereventtime))
    self.plundereventtime = [];

  if(!isDefined(self.plundereventtotal))
    self.plundereventtotal = [];

  if(!isDefined(self.lastplundereventtype))
    self.lastplundereventtype = 0;

  _id_26641D000F48954A = scripts\engine\utility::ter_op(type == 5, 3, type);
  omnvar = level.playerplundereventomnvars[_id_26641D000F48954A];
  plundereventtotal = self.plundereventtotal[type];
  plundereventtime = self.plundereventtime[type];

  if(!isDefined(plundereventtime) || gettime() - plundereventtime > 2000)
    plundereventtotal = 0;

  plundereventtotal = plundereventtotal + amount;

  if(isPlayer(self) && isDefined(omnvar)) {
    _id_5C9DDCF56D36F133 = int(min(plundereventtotal, self.plundercount + amount));
    self setclientomnvar(omnvar, _id_5C9DDCF56D36F133);
  }

  self.lastplundereventtype = type;
  self.plundereventtime[type] = gettime();
  self.plundereventtotal[type] = plundereventtotal;
  _id_8CD4523B06660D98 = level.playerplundereventcallbacks[type];

  if(isDefined(_id_8CD4523B06660D98))
    data = self[[_id_8CD4523B06660D98]](amount, entity, data);

  if(isDefined(data)) {
    if(isDefined(data.player)) {
      if(isDefined(data.playersplash) && data.playersplash != "none" && !data.player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        if(data.playersplash != "br_plunder_first_pickup" || !istrue(data.player.haspickedupplunderyet)) {
          if(!scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
            data.player thread scripts\mp\hud_message::showsplash(data.playersplash, undefined, undefined, undefined, undefined, data._id_D07EE9EE6561C7B6);

          if(data.playersplash == "br_plunder_first_pickup")
            data.player.haspickedupplunderyet = 1;
        }
      }

      if(isDefined(data.playerscoreeventref) && (!isDefined(data.playerscoreeventvalue) || data.playerscoreeventvalue > 0))
        data.player thread scripts\mp\utility\points::_id_0366980B6A8796AE(data.playerscoreeventref, undefined, data.playerscoreeventvalue);
    }

    if(istrue(data.playanimation)) {
      if(type == 3)
        thread playerplaybankanim();
      else if(type == 2)
        thread playerplaydepositanim();
    }

    if(isDefined(data.amount))
      amount = data.amount;

    if(istrue(data.playplundersound)) {
      _id_644A1BA14DC91834 = scripts\engine\utility::ter_op(isDefined(data.plundersoundamount), data.plundersoundamount, amount);
      playplundersoundbyamount(self, _id_644A1BA14DC91834);
    }
  }

  switch (type) {
    case 4:
    case 3:
    case 2:
      amount = amount * -1;
      break;
    case 6:
    case 5:
      amount = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(amount)) {
    data.plunderdelta = amount;
    thread playersetplundercount(self.plundercount + amount, data);
  }

  packextrascore0();
  return data;
}

_id_05A2284274D70F7D(_id_CB99E7B595819C28, amount) {
  if(scripts\mp\utility\game::getsubgametype() != "plunder") {
    return;
  }
  if(!isDefined(self._id_DB548FC480C33EAC)) {
    self._id_DB548FC480C33EAC = [];
    self._id_DB548FC480C33EAC[0] = 0;
    self._id_DB548FC480C33EAC[1] = 0;
    self._id_DB548FC480C33EAC[2] = 0;
    self._id_DB548FC480C33EAC[3] = 0;
    self._id_DB548FC480C33EAC[4] = 0;
  }

  self._id_DB548FC480C33EAC[_id_CB99E7B595819C28] = self._id_DB548FC480C33EAC[_id_CB99E7B595819C28] + amount;
}

packextrascore0(data) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(_id_FAF0D2FAC3F47583 == "kingslayer" || _id_FAF0D2FAC3F47583 == "resurgence" || _id_FAF0D2FAC3F47583 == "resurgence_mgl" || _id_FAF0D2FAC3F47583 == "zonecontrol" || _id_FAF0D2FAC3F47583 == "zxp") {
    return;
  }
  _id_081DAB8953B9DF82 = 0;
  _id_B87F7FAE01CE754F = 0;

  if(isDefined(self.plundercount))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.plundercount;

  if(isDefined(self.plunderbanked))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.plunderbanked;

  _id_B87F7FAE01CE754F = int(_id_B87F7FAE01CE754F / 10);

  if(_id_B87F7FAE01CE754F > 4095)
    _id_B87F7FAE01CE754F = 4095;

  _id_081DAB8953B9DF82 = _id_B87F7FAE01CE754F;
  _id_C5C0C138D608BE6A = 0;

  if(isDefined(self.brmissionscompleted))
    _id_C5C0C138D608BE6A = _id_C5C0C138D608BE6A + self.brmissionscompleted;

  if(_id_C5C0C138D608BE6A > 15)
    _id_C5C0C138D608BE6A = 15;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_C5C0C138D608BE6A << 12);
  scripts\mp\utility\stats::setextrascore0(_id_081DAB8953B9DF82);
}

validateplundereventtype(type) {
  if(!isDefined(type))
    return 0;

  switch (type) {
    case 6:
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
      return 1;
    default:
      return 0;
  }
}

playerplunderpickupcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  if(!istrue(self.haspickedupplunderyet)) {
    data.playersplash = "br_plunder_first_pickup";
    thread _id_4384ABBF498DF6A7::showdiscountsplash();
  }

  return data;
}

playerplunderdepositcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  if(!isDefined(data.playplundersound)) {
    data.playplundersound = 1;
    data.plundersoundamount = undefined;
  }

  if(!isDefined(data.playanimation))
    data.playanimation = 1;

  if(isDefined(entity)) {
    _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

    if(isDefined(_id_464EB48901113EB0.capacity) && _id_464EB48901113EB0.capacity > 0) {
      _id_80A8390CD1D9716F = entity.plundertotal + amount - _id_464EB48901113EB0.capacity;

      if(_id_80A8390CD1D9716F >= 0) {
        amount = amount - _id_80A8390CD1D9716F;

        if(!istrue(entity.plunderatcapacity))
          plunder_repositoryatcapacity(entity);
      }
    }

    _id_5F29F5B939C96795 = 1;

    foreach(_id_F90358454413407F in entity.plunder) {
      player = _id_F90358454413407F.player;

      if(isDefined(player) && player == self) {
        _id_F90358454413407F.plundercount = _id_F90358454413407F.plundercount + amount;
        _id_5F29F5B939C96795 = 0;
        break;
      }
    }

    if(_id_5F29F5B939C96795) {
      _id_F90358454413407F = spawnStruct();
      _id_F90358454413407F.player = self;
      _id_F90358454413407F.team = self.team;
      _id_F90358454413407F.plundercount = amount;
      entity.plunder[entity.plunder.size] = _id_F90358454413407F;
    }
  }

  data.amount = amount;
  entity.plundertotal = entity.plundertotal + amount;

  if(!isDefined(level.teamdata[self.team]["plunderInDeposit"]))
    level.teamdata[self.team]["plunderInDeposit"] = int(amount);
  else
    level.teamdata[self.team]["plunderInDeposit"] = level.teamdata[self.team]["plunderInDeposit"] + int(amount);

  return data;
}

playerplunderbankcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  if(!isDefined(data.playersplash))
    data.playersplash = "br_plunder_banked";

  if(scripts\mp\utility\game::getsubgametype() == "plunder")
    data._id_D07EE9EE6561C7B6 = "splash_list_br_plunder_iw9_mp";

  if(!isDefined(data.playerscoreeventref))
    data.playerscoreeventref = scripts\engine\utility::ter_op(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk", "stat_70C9F312B8E0BF01", "stat_CA22F5B52C0AB105");

  if(!isDefined(data.playerscoreeventvalue))
    data.playerscoreeventvalue = int(scripts\mp\rank::getscoreinfovalue(data.playerscoreeventref) * (amount / 10));

  if(!isDefined(data.playplundersound)) {
    data.playplundersound = 1;
    data.plundersoundamount = undefined;
  }

  if(!isDefined(data.playanimation))
    data.playanimation = 1;

  self.plunderbanked = self.plunderbanked + amount;

  if(self.plunderbanked > level.br_plunder.plunderlimit)
    self.plunderbanked = level.br_plunder.plunderlimit;

  if(!isDefined(level.teamdata[self.team]["plunderBanked"]))
    level.teamdata[self.team]["plunderBanked"] = amount;
  else
    level.teamdata[self.team]["plunderBanked"] = level.teamdata[self.team]["plunderBanked"] + amount;

  return data;
}

playerplunderlosecallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  return data;
}

playerplunderbankdepositcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  if(!isDefined(data.plundersoundamount))
    data.plundersoundamount = 0;

  data.setplunderifunchanged = 1;
  team = self.team;

  if(isDefined(entity) && isDefined(entity.plunder)) {
    foreach(id, _id_F90358454413407F in entity.plunder) {
      if(isDefined(_id_F90358454413407F.player) && _id_F90358454413407F.player == self) {
        team = _id_F90358454413407F.team;

        if(!isDefined(amount))
          amount = _id_F90358454413407F.plundercount;
        else
          amount = min(amount, _id_F90358454413407F.plundercount);

        _id_F90358454413407F.plundercount = _id_F90358454413407F.plundercount - amount;

        if(_id_F90358454413407F.plundercount == 0)
          entity.plunder[id] = undefined;

        self.plunderbanked = self.plunderbanked + amount;

        if(self.plunderbanked > level.br_plunder.plunderlimit)
          self.plunderbanked = level.br_plunder.plunderlimit;

        break;
      }
    }

    if(!isDefined(data.playerscoreeventref))
      data.playerscoreeventref = scripts\engine\utility::ter_op(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk", "stat_70C9F312B8E0BF01", "stat_CA22F5B52C0AB105");

    if(!isDefined(data.playerscoreeventvalue))
      data.playerscoreeventvalue = int(scripts\mp\rank::getscoreinfovalue(data.playerscoreeventref) * (amount / 10));
  }

  amount = int(amount);
  level.teamdata[team]["plunderInDeposit"] = level.teamdata[team]["plunderInDeposit"] - amount;
  level.teamdata[team]["plunderBanked"] = level.teamdata[team]["plunderBanked"] + amount;
  return data;
}

playerplunderlosedepositcallback(amount, entity, data) {
  if(!isDefined(data))
    data = createplayerplundereventdata(self);

  data.setplunderifunchanged = 1;
  team = self.team;

  if(isDefined(entity) && isDefined(entity.plunder)) {
    foreach(id, _id_F90358454413407F in entity.plunder) {
      if(isDefined(_id_F90358454413407F.player) && _id_F90358454413407F.player == self) {
        team = _id_F90358454413407F.team;

        if(!isDefined(amount))
          amount = _id_F90358454413407F.plundercount;
        else
          amount = min(amount, _id_F90358454413407F.plundercount);

        _id_F90358454413407F.plundercount = _id_F90358454413407F.plundercount - amount;

        if(_id_F90358454413407F.plundercount == 0)
          entity.plunder[id] = undefined;

        break;
      }
    }
  }

  amount = int(amount);
  level.teamdata[team]["plunderInDeposit"] = level.teamdata[team]["plunderInDeposit"] - amount;
  return data;
}

entityplunderbankalldeposited(data) {
  if(!isDefined(self.plunder)) {
    return;
  }
  if(!isDefined(data))
    data = createplayerplundereventdata();

  data.amounttotal = 0;
  data.teams = [];
  data.numdepositers = 0;

  foreach(id, _id_F90358454413407F in self.plunder) {
    if(isDefined(_id_F90358454413407F.player) || _id_F90358454413407F.plundercount <= 0) {
      continue;
    }
    team = _id_F90358454413407F.team;
    amount = _id_F90358454413407F.plundercount;
    level.teamdata[team]["plunderInDeposit"] = level.teamdata[team]["plunderInDeposit"] - amount;
    level.teamdata[team]["plunderBanked"] = level.teamdata[team]["plunderBanked"] + amount;
    data.amounttotal = data.amounttotal + amount;
    data.teams[data.teams.size] = team;
    self.plunder[id] = undefined;
  }

  foreach(_id_F90358454413407F in self.plunder) {
    if(_id_F90358454413407F.plundercount <= 0) {
      continue;
    }
    player = _id_F90358454413407F.player;
    team = _id_F90358454413407F.team;
    amount = _id_F90358454413407F.plundercount;
    _id_84DCD1AB2AE1DFFA = undefined;

    if(isDefined(data))
      _id_84DCD1AB2AE1DFFA = copyplayerplundereventdata(data, player, team);

    _id_84DCD1AB2AE1DFFA.dontcallpostplunder = 1;
    _id_84DCD1AB2AE1DFFA = player playerplunderbankdeposit(amount, self, _id_84DCD1AB2AE1DFFA);

    if(isDefined(_id_84DCD1AB2AE1DFFA) && isDefined(_id_84DCD1AB2AE1DFFA.amount))
      amount = _id_84DCD1AB2AE1DFFA.amount;

    data.amounttotal = data.amounttotal + amount;
    data.teams[data.teams.size] = team;
    data.numdepositers++;
  }

  _id_3EAA9F644DBE7834 = "fulton";

  if(isDefined(self.classname) && self.classname == "script_vehicle")
    _id_3EAA9F644DBE7834 = "little_bird";

  data.teams = scripts\engine\utility::array_remove_duplicates(data.teams);
  _id_D9F59DCE4A1FC81A = 0;

  if(data.teams.size > 1)
    _id_D9F59DCE4A1FC81A = 1;
  else if(data.teams.size == 1 && data.teams[0] != self.team)
    _id_D9F59DCE4A1FC81A = 1;

  _id_464EB48901113EB0 = plunder_getleveldataforrepository(self.plunderrepositoryref, undefined, 1);

  if(isDefined(_id_464EB48901113EB0) && isDefined(_id_464EB48901113EB0.extractionmethod))
    _id_715028F54BAD19A1::branalytics_plunder_extraction_success(data.numdepositers, data.amounttotal, _id_464EB48901113EB0.extractionmethod, _id_D9F59DCE4A1FC81A, self.origin);

  if(!isDefined(data) || !istrue(data.dontcallpostplunder))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("postPlunder", data);

  self.plunder = [];
  return data;
}

entityplunderlosealldeposited(dropplunder, data) {
  if(!isDefined(self.plunder)) {
    return;
  }
  if(!isDefined(data))
    data = createplayerplundereventdata();

  data.amounttotal = 0;
  data.teams = [];
  _id_96C4A8C24E604CAD = 0;

  foreach(id, _id_F90358454413407F in self.plunder) {
    if(isDefined(_id_F90358454413407F.player) || _id_F90358454413407F.plundercount <= 0) {
      continue;
    }
    team = _id_F90358454413407F.team;
    amount = _id_F90358454413407F.plundercount;
    level.teamdata[team]["plunderInDeposit"] = level.teamdata[team]["plunderInDeposit"] - amount;
    data.amounttotal = data.amounttotal + amount;
    data.teams[data.teams.size] = team;
    self.plunder[id] = undefined;
  }

  foreach(_id_F90358454413407F in self.plunder) {
    if(_id_F90358454413407F.plundercount <= 0) {
      continue;
    }
    player = _id_F90358454413407F.player;
    team = _id_F90358454413407F.team;
    amount = _id_F90358454413407F.plundercount;
    _id_84DCD1AB2AE1DFFA = undefined;

    if(isDefined(data))
      _id_84DCD1AB2AE1DFFA = copyplayerplundereventdata(data, player, team);

    _id_84DCD1AB2AE1DFFA.dontcallpostplunder = 1;
    player playerplunderlosedeposit(amount, self, _id_84DCD1AB2AE1DFFA);

    if(isDefined(_id_84DCD1AB2AE1DFFA) && isDefined(_id_84DCD1AB2AE1DFFA.amount))
      amount = _id_84DCD1AB2AE1DFFA.amount;

    data.amounttotal = data.amounttotal + amount;
    data.teams[data.teams.size] = team;
    _id_96C4A8C24E604CAD = _id_96C4A8C24E604CAD + amount;
  }

  if(!isDefined(data) || !istrue(data.dontcallpostplunder))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("postPlunder", data);

  self.plunder = [];

  if(istrue(dropplunder)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    dropplunderbyrarity(data.amounttotal, dropstruct);
  }

  return data;
}

createplayerplundereventdata(player, team) {
  data = spawnStruct();
  data.player = undefined;

  if(isDefined(player))
    data.player = player;

  data.playersplash = undefined;
  data.playerscoreeventref = undefined;
  data.playerscoreeventvalue = undefined;
  data.setplunderifunchanged = undefined;
  data.playplundersound = undefined;
  data.plundersoundamount = undefined;
  data.playanimation = undefined;
  return data;
}

copyplayerplundereventdata(_id_F58EE9FF02B66E9D, player, team) {
  data = createplayerplundereventdata();

  if(isDefined(_id_F58EE9FF02B66E9D.player)) {
    data.player = _id_F58EE9FF02B66E9D.player;
    player = _id_F58EE9FF02B66E9D.player;
  } else if(isDefined(player))
    data.player = player;

  if(isDefined(_id_F58EE9FF02B66E9D.playersplash))
    data.playersplash = _id_F58EE9FF02B66E9D.playersplash;

  if(isDefined(_id_F58EE9FF02B66E9D.playerscoreeventref))
    data.playerscoreeventref = _id_F58EE9FF02B66E9D.playerscoreeventref;

  if(isDefined(_id_F58EE9FF02B66E9D.playerscoreeventvalue))
    data.playerscoreeventvalue = _id_F58EE9FF02B66E9D.playerscoreeventvalue;

  if(isDefined(_id_F58EE9FF02B66E9D.setplunderifunchanged))
    data.setplunderifunchanged = _id_F58EE9FF02B66E9D.setplunderifunchanged;

  if(isDefined(_id_F58EE9FF02B66E9D.playplundersound))
    data.playplundersound = _id_F58EE9FF02B66E9D.playplundersound;

  if(isDefined(_id_F58EE9FF02B66E9D.plundersoundamount))
    data.plundersoundamount = _id_F58EE9FF02B66E9D.plundersoundamount;

  if(isDefined(_id_F58EE9FF02B66E9D.playanimation))
    data.playanimation = _id_F58EE9FF02B66E9D.playanimation;

  return data;
}

playersetplundercount(plundercount, data) {
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  plunderdelta = plundercount - self.plundercount;

  if((!isDefined(data) || !istrue(data.setplunderifunchanged)) && plunderdelta == 0) {
    return;
  }
  self.plundercount = plundercount;

  if(self.plundercount > level.br_plunder.plunderlimit) {
    scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED");
    self.plundercount = level.br_plunder.plunderlimit;
  }

  if(isDefined(self.petwatch))
    scripts\cp_mp\pet_watch::onplayergetsplunder();

  amount = self.plundercount;
  playersetplunderomnvar(amount);

  if(plundercount > 0) {
    if(istrue(level.plunderusedisabledwhenempty) && plunderdelta != 0)
      plunder_allowallrepositoryuseforplayer(self, 1, 1);

    enablealldepotsforplayer(self);

    if(inplunderlivelobby() && plundercount >= 10)
      thread playerdelayautobankplunder();
  } else {
    if(istrue(level.plunderusedisabledwhenempty) && plunderdelta != 0)
      plunder_allowallrepositoryuseforplayer(self, 0, 1);

    disablealldepotsforplayer(self);
  }

  if(isDefined(data) && isDefined(data.plunderdelta))
    plunderdelta = data.plunderdelta;

  if(plunderdelta != 0) {
    if(!isDefined(level.teamdata[self.team]["plunderTeamTotal"]))
      level.teamdata[self.team]["plunderTeamTotal"] = 0;

    level.teamdata[self.team]["plunderTeamTotal"] = level.teamdata[self.team]["plunderTeamTotal"] + plunderdelta;
  }

  if(!isDefined(data) || !istrue(data.dontcallpostplunder))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("postPlunder", data);
}

playersetplunderomnvar(value) {
  _id_FF986C1C69CC1CD6 = value / 100;
  scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(19, _id_FF986C1C69CC1CD6);
  _id_03F1B6713CA4C9C7::playersetplunderomnvar(value);
}

getpackeddata(value, _id_7009DA06A8A620CB, _id_64571E3AECCD1A07, _id_8534515023AFC188) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_ED711AEAF5E8CB76 = _id_7009DA06A8A620CB &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  return _id_82A90E56E416FA55;
}

playergetplunderomnvarbitpackinginfo() {
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;
  _id_8E90FA6D5789AD63 = "";

  switch (self._id_3F78C6A0862F9E25) {
    case 1:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [0, 17, "ui_br_plunder_count"];
      break;
    case 2:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [17, 17, "ui_br_plunder_count"];
      break;
    case 3:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [0, 17, "ui_br_plunder_count2"];
      break;
    case 4:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63] = [17, 17, "ui_br_plunder_count2"];
      break;
    default:
      break;
  }

  return [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63];
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;
  _id_D16B5E09EE5DDE91 = _id_52D59C928EB97C81 * _id_52D59C928EB97C81;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_depots.size; _id_AC0E594AC96AA3A8++) {
    _id_FB7C65E67A8EED31 = level.br_depots[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_FB7C65E67A8EED31) && !istrue(_id_FB7C65E67A8EED31.disabled) && distance2dsquared(_id_819EDACDACB810E4, _id_FB7C65E67A8EED31.origin) > _id_D16B5E09EE5DDE91)
      _id_FB7C65E67A8EED31 _id_028F5F133CA1F9D8();
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder_sites.size; _id_AC0E594AC96AA3A8++) {
    site = level.br_plunder_sites[_id_AC0E594AC96AA3A8];

    if(isDefined(site) && !istrue(site.disabled) && distance2dsquared(_id_819EDACDACB810E4, site.origin) > _id_D16B5E09EE5DDE91)
      site _id_8682A8796FD4B35F();
  }
}

_id_1A1709943670772A() {
  if(!istrue(level.br_plunder_enabled) || !istrue(level._id_2DF69B8E552238B6)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_depots.size; _id_AC0E594AC96AA3A8++) {
    _id_FB7C65E67A8EED31 = level.br_depots[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_FB7C65E67A8EED31) && !istrue(_id_FB7C65E67A8EED31.disabled) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_FB7C65E67A8EED31.origin))
      _id_FB7C65E67A8EED31 _id_028F5F133CA1F9D8();
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder_sites.size; _id_AC0E594AC96AA3A8++) {
    site = level.br_plunder_sites[_id_AC0E594AC96AA3A8];

    if(isDefined(site) && !istrue(site.disabled) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(site.origin))
      site _id_8682A8796FD4B35F();
  }
}

_id_028F5F133CA1F9D8() {
  _id_FB7C65E67A8EED31 = self;
  _id_FB7C65E67A8EED31.disabled = 1;
  _id_FB7C65E67A8EED31 depotmakeunsabletoall();
}

_id_8682A8796FD4B35F() {
  site = self;
  site.disabled = 1;
  site setscriptablepartstate(site.type, site.disabledstate);
}

playerplaydepositanim() {
  self endon("death_or_disconnect");

  if(!_id_2CEDCC356F1B9FC8::playercanplaynotcriticalgesture() || self isgestureplaying()) {
    return;
  }
  _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_cash_handoff", 1.84);
}

cratedropplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }
  amount = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.plunder.size; _id_AC0E594AC96AA3A8++)
    amount = amount + self.plunder[_id_AC0E594AC96AA3A8].plundercount;

  self.angles = (0, 0, 0);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  dropplunderbyrarity(amount, dropstruct);
}

dropplundersounds(droporigin, _id_0CE1BD3FDF0FCECF) {
  if(_id_0CE1BD3FDF0FCECF <= 0) {
    return;
  }
  _id_31D840EB00BD7F1E = droporigin + (0, 0, 24);
  _id_57EEFE0CA5DB9070 = "";
  wait 0.5;

  switch (_id_0CE1BD3FDF0FCECF) {
    case 0:
      break;
    case 1:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_01";
      break;
    case 2:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_02";
      break;
    case 3:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_03";
      break;
    case 4:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_04";
      break;
    case 5:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_05";
      break;
    case 6:
    default:
      _id_57EEFE0CA5DB9070 = "br_drop_plunder_06";
      break;
  }

  playsoundatpos(_id_31D840EB00BD7F1E, _id_57EEFE0CA5DB9070);
}

dropplunderbyrarity(amount, dropstruct, numitems) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_E05413A53B5D9167 = [];
  _id_E3232613C46AEB6B = [];
  _id_EE9DE3C34A771918 = 0;
  maxcount = 6;

  if(isDefined(numitems))
    maxcount = numitems;

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] = int(amount / level.br_plunder.quantity[_id_AC0E594AC96AA3A8]);
    _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] = int(clamp(_id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8], 0, maxcount - _id_EE9DE3C34A771918));
    _id_EE9DE3C34A771918 = _id_EE9DE3C34A771918 + _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8];

    if(amount <= 0 || _id_EE9DE3C34A771918 >= maxcount) {
      break;
    } else
      amount = amount - _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] * level.br_plunder.quantity[_id_AC0E594AC96AA3A8];
  }

  for(_id_F90D0E006A1F717B = level.br_plunder.quantity.size - 1; _id_F90D0E006A1F717B >= 0; _id_F90D0E006A1F717B--) {
    if(!isDefined(_id_E3232613C46AEB6B[_id_F90D0E006A1F717B])) {
      continue;
    }
    for(_id_3793828403C6873E = 0; _id_3793828403C6873E < _id_E3232613C46AEB6B[_id_F90D0E006A1F717B]; _id_3793828403C6873E++) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      pickupent = _id_7E52B56769FA7774::spawnpickup(level.br_plunder.names[_id_F90D0E006A1F717B], _id_CB4FAD49263E20C4, level.br_plunder.quantity[_id_F90D0E006A1F717B], 1);
      modify_plunder_itemsinworld(level.br_plunder.names[_id_F90D0E006A1F717B], 1);

      if(isDefined(pickupent)) {
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = pickupent;

        if(inplunderlivelobby())
          level.br_plunder_ents[level.br_plunder_ents.size] = pickupent;
      }
    }
  }

  level.br_plunder.plunder_items_dropped = level.br_plunder.plunder_items_dropped + _id_EE9DE3C34A771918;
  level.br_plunder.plunder_value_dropped = level.br_plunder.plunder_value_dropped + amount;
  level thread dropplundersounds(self.origin, _id_E05413A53B5D9167.size);
  return _id_E05413A53B5D9167;
}

dropcondensedplunder(amount, dropstruct, _id_1AD2DB70C8D01F51) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_E05413A53B5D9167 = [];
  _id_E3232613C46AEB6B = [];
  _id_8E0B722357754D9E = 0;

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.names.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(amount >= level.br_plunder.quantity[_id_AC0E594AC96AA3A8]) {
      _id_8E0B722357754D9E = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
  _id_307BCADB5A20BD5E = isalive(self) || istrue(_id_1AD2DB70C8D01F51) || getdvarint("dvar_56A4511198080C62", 0);
  pickupent = _id_7E52B56769FA7774::spawnpickup(level.br_plunder.names[_id_8E0B722357754D9E], _id_CB4FAD49263E20C4, amount, 1, undefined, _id_307BCADB5A20BD5E);
  modify_plunder_itemsinworld(level.br_plunder.names[_id_8E0B722357754D9E], 1);

  if(isDefined(pickupent)) {
    _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = pickupent;

    if(inplunderlivelobby())
      level.br_plunder_ents[level.br_plunder_ents.size] = pickupent;

    _id_7E52B56769FA7774::_id_2F4E0022C686DBE6(pickupent);
  }

  level.br_plunder.plunder_items_dropped++;
  level.br_plunder.plunder_value_dropped = level.br_plunder.plunder_value_dropped + amount;
  level thread dropplundersounds(self.origin, _id_E05413A53B5D9167.size);
  return _id_E05413A53B5D9167;
}

isplunderextractionenabled() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("plunderSites"))
    return 0;

  return istrue(level.br_plunder_enabled) && level.br_plunder_sites.size != 0 && getdvarint("scr_br_plunder_sites", 1) != 0;
}

#using_animtree("mp_vehicles_always_loaded");

initheliextractanims() {
  level.scr_anim["plunder_extract_heli"]["heli_in"] = % iw8_br_plunder_heli_in;
  level.scr_anim["plunder_extract_heli"]["heli_loop"] = % iw8_br_plunder_heli_loop;
  level.scr_anim["plunder_extract_heli"]["heli_out"] = % iw8_br_plunder_heli_out;
}

#using_animtree("script_model");

inithelipropanims() {
  level.scr_animtree["plunder_extract_heli"] = #animtree;
  level.scr_anim["plunder_extract_heli"]["rope_in"] = % iw8_br_plunder_heli_rope_in;
  level.scr_animname["plunder_extract_heli"]["rope_in"] = "iw8_br_plunder_heli_rope_in";
  level.scr_anim["plunder_extract_heli"]["rope_loop"] = % iw8_br_plunder_heli_rope_loop;
  level.scr_animname["plunder_extract_heli"]["rope_loop"] = "iw8_br_plunder_heli_rope_loop";
  level.scr_anim["plunder_extract_heli"]["rope_out"] = % iw8_br_plunder_heli_rope_out;
  level.scr_animname["plunder_extract_heli"]["rope_out"] = "iw8_br_plunder_heli_rope_out";
  level.scr_anim["plunder_extract_heli"]["bag_in"] = % iw8_br_plunder_heli_bag_in;
  level.scr_animname["plunder_extract_heli"]["bag_in"] = "iw8_br_plunder_heli_bag_in";
  level.scr_anim["plunder_extract_heli"]["bag_loop"] = % iw8_br_plunder_heli_bag_loop;
  level.scr_animname["plunder_extract_heli"]["bag_loop"] = "iw8_br_plunder_heli_bag_loop";
  level.scr_anim["plunder_extract_heli"]["bag_out"] = % iw8_br_plunder_heli_bag_out;
  level.scr_animname["plunder_extract_heli"]["bag_out"] = "iw8_br_plunder_heli_bag_out";
}

inithelirepository() {
  _id_D2F87019E8A38F04 = [];
  _id_464EB48901113EB0 = plunder_getleveldataforrepository("plunderHelipad1", 1);
  _id_464EB48901113EB0.scriptableusepart = "brloot_plunder_extraction_site_01";
  _id_D2F87019E8A38F04[_id_D2F87019E8A38F04.size] = _id_464EB48901113EB0;
  _id_464EB48901113EB0 = plunder_getleveldataforrepository("plunderHelipad2", 1);
  _id_464EB48901113EB0.scriptableusepart = "brloot_plunder_extraction_site_02";
  _id_D2F87019E8A38F04[_id_D2F87019E8A38F04.size] = _id_464EB48901113EB0;
  _id_464EB48901113EB0 = plunder_getleveldataforrepository("extractHelipadPlunder", 1);
  _id_464EB48901113EB0.scriptableusepart = "brloot_quest_extract_site_plunder";
  _id_D2F87019E8A38F04[_id_D2F87019E8A38F04.size] = _id_464EB48901113EB0;
  _id_464EB48901113EB0 = plunder_getleveldataforrepository("extractHelipadBR", 1);
  _id_464EB48901113EB0.scriptableusepart = "brloot_quest_extract_site_br";
  _id_D2F87019E8A38F04[_id_D2F87019E8A38F04.size] = _id_464EB48901113EB0;

  foreach(_id_464EB48901113EB0 in _id_D2F87019E8A38F04) {
    _id_464EB48901113EB0.type = 1;
    _id_464EB48901113EB0.usetime = 0;
    _id_464EB48901113EB0.useeventtype = 3;
    _id_464EB48901113EB0.useeventamount = getdvarint("scr_plunderHeliUseAmount", 20000);
    _id_464EB48901113EB0.teamuseonly = 0;
    _id_464EB48901113EB0.usefailcapacitymsg = "MP/CANNOT_DEPOSIT_CASH_HELI_FULL";
    _id_464EB48901113EB0.usefailextractingmsg = "MP/CANNOT_DEPOSIT_CASH_HELI_LEAVING";
    _id_464EB48901113EB0.scriptableusestate = "activedepositcurrent";
    _id_464EB48901113EB0.scriptablenousestate = "visiblecurrent";
    _id_464EB48901113EB0.extractcountdown = 0;
    _id_464EB48901113EB0.extractsilentcountdown = getdvarint("scr_plunderHeliCountdown", 30);
    _id_464EB48901113EB0.extractcountdownmsg = "MP/CASH_HELI_LEAVING_IN_N";
    _id_464EB48901113EB0.capacity = 0;
    _id_464EB48901113EB0.countdownendcallback = ::helicountdownendcallback;
    _id_464EB48901113EB0.extractcallback = ::heliextractcallback;
    _id_464EB48901113EB0.atcapacitycallback = ::heliatcapacitycallback;
    _id_464EB48901113EB0.extractionmethod = "little_bird";
  }
}

getplunderextractionsites() {
  sites = [];

  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    sites = getentitylessscriptablearray("extract_pad", "targetname");
    _id_C3FC8AA938C22936 = getentitylessscriptablearray("extract_pad_boneyard", "targetname");

    if(_id_C3FC8AA938C22936.size > 0)
      sites = scripts\engine\utility::array_combine(sites, _id_C3FC8AA938C22936);
  } else {
    _id_6F1B16A6B8446C60 = getentitylessscriptablearray("plunder_extraction_01", "targetname");
    _id_6F1B19A6B84472F9 = getentitylessscriptablearray("plunder_extraction_02", "targetname");
    sites = scripts\engine\utility::array_combine(_id_6F1B16A6B8446C60, _id_6F1B19A6B84472F9);
  }

  if(sites.size > 0) {
    foreach(site in sites) {
      site.activestate = "active";
      site.activecurrstate = "activeCurrent";
      site.disabledstate = "visible";
      site.disabledcurrstate = "visible";
    }

    return sites;
  } else {
    sites = getentitylessscriptablearray("plunder_extraction", "targetname");

    foreach(site in sites) {
      site.activestate = "visible";
      site.activecurrstate = "visibleCurrent";
      site.disabledstate = "hidden";
    }

    return sites;
  }
}

_id_C383497E5F14E368(_id_B8E5CA4F7DAB36EF) {
  if(!isDefined(level._id_88E8C04E60A1092C))
    level._id_88E8C04E60A1092C = [];

  level._id_88E8C04E60A1092C[level._id_88E8C04E60A1092C.size] = _id_B8E5CA4F7DAB36EF;
  return _id_B8E5CA4F7DAB36EF;
}

setupplunderextractionsites() {
  level.br_plunder_sites = getplunderextractionsites();
  level.br_plunder_site_use_parts = [];
  level.br_plunder_site_use_parts[level.br_plunder_site_use_parts.size] = "brloot_plunder_extraction_site";
  level.br_plunder_site_use_parts[level.br_plunder_site_use_parts.size] = "brloot_plunder_extraction_site_01";
  level.br_plunder_site_use_parts[level.br_plunder_site_use_parts.size] = "brloot_plunder_extraction_site_02";
  level.br_plunder_site_use_parts[level.br_plunder_site_use_parts.size] = "brloot_quest_extract_site_br";
  level.br_plunder_site_use_parts[level.br_plunder_site_use_parts.size] = "brloot_quest_extract_site_plunder";
  level.br_plunder_site_use_states = [];
  level.br_plunder_site_use_states[level.br_plunder_site_use_states.size] = "active";
  level.br_plunder_site_use_states[level.br_plunder_site_use_states.size] = "active2";
  level.br_plunder_site_use_states[level.br_plunder_site_use_states.size] = "activecurrent";
  level.br_plunder_site_use_states[level.br_plunder_site_use_states.size] = "visiblecurrent";

  if(isplunderextractionenabled() && getdvarint("dvar_28DF7F89E6EAB57C", 0) && getdvarint("scr_ssc_enabled", 0)) {
    foreach(site in level.br_plunder_sites)
    site setscriptablepartstate(site.type, "hidden");

    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("extraction_site", ::getallextractspawninstances);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("extraction_site", ::_id_C383497E5F14E368);
  } else if(!isplunderextractionenabled()) {
    _id_CDA8506E90CB3B70 = getEntArray("plunder_extraction_visual", "targetname");

    foreach(ent in _id_CDA8506E90CB3B70)
    ent delete();

    foreach(site in level.br_plunder_sites)
    site setscriptablepartstate(site.type, "hidden");

    level.br_plunder_sites = [];
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallback(::plundersiteused);

  if(isDefined(level.matchstartextractsitedelay) && level.matchstartextractsitedelay > 0 && !istrue(level.usemilestonephases))
    wait(level.matchstartextractsitedelay);
  else if(istrue(level.usemilestonephases))
    scripts\mp\flags::gameflagwait("activate_cash_lzs");

  if(getdvarint("dvar_B3F1F3B65E2DCDB4", 0)) {
    foreach(player in level.players) {
      if(isDefined(player)) {
        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          player scripts\mp\hud_message::showsplash("bm_extract_heli_start", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp");
      }
    }
  }

  sites = level.br_plunder_sites;

  if(getdvarint("dvar_28DF7F89E6EAB57C", 0) && getdvarint("scr_ssc_enabled", 0)) {
    sites = level._id_88E8C04E60A1092C;
    level._id_88E8C04E60A1092C = undefined;
  }

  foreach(site in sites) {
    scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), site.activecurrstate, site.activestate);
    site setscriptablepartstate(site.type, scriptablestate);
  }
}

getallextractspawninstances() {
  if(!isplunderextractionenabled()) {
    return;
  }
  instances = getplunderextractionsites();
  return instances;
}

setextractspawninstances(instances) {
  foreach(site in level.br_plunder_sites) {
    if(!scripts\engine\utility::array_contains(instances, site))
      site setscriptablepartstate(site.type, "hidden");
  }

  level.br_plunder_sites = instances;
}

debugextractsite(site) {
  _id_DF35D1A64F3859C7 = spawn("script_model", site.origin + (0, 0, 1000));
  modelname = "veh8_mil_air_mindia8_plunder_x";
  vehiclename = "veh_apache_plunder_mp";

  if(istrue(level._id_A83A4E71446BFEF7)) {
    modelname = "veh9_mil_air_heli_blima_mp_x";
    vehiclename = "veh9_mil_air_heli_blima_nophysics_br";
  }

  _id_DF35D1A64F3859C7 setModel(modelname);
  _id_0FCFB56E6D8CC156 = site.origin[0];
  _id_0FCFB66E6D8CC389 = site.origin[1];
  _id_DC8BB6300463CF1E = 800;
  _id_E7A7D619F927D791 = _id_DF35D1A64F3859C7 tracegroundpoint(_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_1DC672CFE0F0128E);
  _id_DF35D1A64F3859C7.origin = _id_6C53D859D582A421;

  for(;;)
    waitframe();
}

plundersiteused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(player)) {
    return;
  }
  if(!isDefined(level.br_plunder_site_use_parts) || !isDefined(level.br_plunder_site_use_states)) {
    return;
  }
  _id_5553FD245655E4C4 = 1;

  foreach(_id_B80803C68C80386B in level.br_plunder_site_use_parts) {
    if(_id_B80803C68C80386B != part) {
      continue;
    }
    _id_5553FD245655E4C4 = 0;
    break;
  }

  if(_id_5553FD245655E4C4) {
    return;
  }
  _id_5553FD245655E4C4 = 1;

  foreach(_id_6B838B4DFD91FC9F in level.br_plunder_site_use_states) {
    if(_id_6B838B4DFD91FC9F != state) {
      continue;
    }
    _id_5553FD245655E4C4 = 0;
    break;
  }

  if(_id_5553FD245655E4C4) {
    return;
  }
  thread plundersiteusedinternal(instance, part, state, player);
}

plundersiteusedinternal(instance, part, state, player) {
  if(isDefined(instance.disabled)) {
    return;
  }
  if(isDefined(instance.heli)) {
    player playerdenyextraction(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return;
  }

  scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), "inuseCurrent", "inuse");
  instance setscriptablepartstate(instance.type, scriptablestate);
  _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, player.team);
  instance.team = _id_3EDA0EF65C9478AC;
  instance _meth_FCA5BDBE24070D20(instance.type, _id_3EDA0EF65C9478AC);
  _id_01230EA36A300368 = getgroundposition(instance.origin, 1) + (0, 0, scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587(), 2, -9));
  heli = player playerspawnextractchopper(_id_01230EA36A300368, instance);

  if(isDefined(heli)) {
    heli.site = instance;
    instance.heli = heli;
    instance.team = player.team;
    thread createsmokesignalfx(_id_01230EA36A300368);
    player playerthrowsmokesignal();

    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_requested", player.team, 1);

    level thread _id_1E4A61DB11011446::teamsplashbr("br_extract_heli_incoming", player, player.team, undefined, "splash_list_br_plunder_iw9_mp");
    heli thread heligotoplunderrepository(instance);
  } else {
    playerdenyextraction(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), instance.activecurrstate, instance.activestate);
    instance setscriptablepartstate(instance.type, scriptablestate);
    return;
  }

  if(istrue(level.plunderextractalertnearby)) {
    _id_EF269077A28646EB = scripts\common\utility::playersincylinder(instance.origin, 15000);
    _id_4725E52B7C3AA25C = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(playerent in _id_EF269077A28646EB) {
      if(!scripts\engine\utility::array_contains(_id_4725E52B7C3AA25C, playerent))
        playerent thread scripts\mp\hud_message::showsplash("br_extract_heli_incoming_them", undefined, player, undefined, undefined, "splash_list_br_plunder_iw9_mp");
    }
  }

  if(istrue(level.moveplunderextractionsitesonuse)) {
    instance.disabled = 1;
    scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), instance.disabledcurrstate, instance.disabledstate);
    instance setscriptablepartstate(instance.type, scriptablestate);
    level thread findnewplunderextractsite(instance);
  }
}

_getsingleplunderextractlocations(_id_532388C61E12B9DF, _id_E296217C9FCD337F) {
  if(_id_532388C61E12B9DF.size == 0 || _id_E296217C9FCD337F == 0) {
    return;
  }
  site = undefined;

  if(_id_532388C61E12B9DF.size > 0) {
    _id_532388C61E12B9DF = scripts\engine\utility::array_randomize(_id_532388C61E12B9DF);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_532388C61E12B9DF.size; _id_AC0E594AC96AA3A8++) {
      if(!scripts\engine\utility::array_contains(level.br_plunder_sites, _id_532388C61E12B9DF[_id_AC0E594AC96AA3A8])) {
        site = _id_532388C61E12B9DF[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  return site;
}

findnewplunderextractsite(_id_EEDC39992A492091) {
  _id_179AC3ACEE8F7AF6 = _getsingleplunderextractlocations(getallextractspawninstances(), level.maxplunderextractions);
  _id_179AC3ACEE8F7AF6.disabled = undefined;
  _id_179AC3ACEE8F7AF6.helidisabled = undefined;
  scriptablestate = scripts\engine\utility::ter_op(level.showplunderextracticonsinworld && !level.shownonscriptableextracticons, _id_179AC3ACEE8F7AF6.activecurrstate, _id_179AC3ACEE8F7AF6.activestate);
  _id_179AC3ACEE8F7AF6 setscriptablepartstate(_id_179AC3ACEE8F7AF6.type, scriptablestate);

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons) {
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_EEDC39992A492091.locale.objectiveiconid);
    _id_EEDC39992A492091.locale.objectiveiconid = -1;
    locale = spawnStruct();
    locale _id_3ACF1C0EBAF602F2::createquestobjicon("ui_mp_br_mapmenu_icon_atm", "current", _id_179AC3ACEE8F7AF6.origin + (0, 0, 200));
    _id_179AC3ACEE8F7AF6.locale = locale;
  }

  level.br_plunder_sites = scripts\engine\utility::array_remove(level.br_plunder_sites, _id_EEDC39992A492091);
  level.br_plunder_sites = scripts\engine\utility::array_add(level.br_plunder_sites, _id_179AC3ACEE8F7AF6);
}

playerthrowsmokesignal() {
  self endon("death_or_disconnect");
  _id_2CEDCC356F1B9FC8::playerplaygestureweaponanim("iw8_ges_plyr_plunder_smoke", 1.867);
}

playerdenyextraction(_id_06B62DB6EEC868E2, _id_734564FF3D4FD467) {
  self iprintlnbold(_id_734564FF3D4FD467);
  self playlocalsound("br_pickup_deny");

  if(isDefined(_id_06B62DB6EEC868E2)) {
    ammo = self getweaponammoclip(_id_06B62DB6EEC868E2);
    self setweaponammoclip(_id_06B62DB6EEC868E2, ammo + 1);
  }
}

createsmokesignalfx(position) {
  wait 1.35;
  fxent = spawn("script_model", position);
  fxent setModel("scr_smoke_grenade");
  fxent.angles = (0, 90, 90);
  fxent playSound("smoke_carepackage_expl_trans");
  fxent playLoopSound("smoke_carepackage_smoke_lp");
  fxent setscriptablepartstate("smoke", "on");
  wait 17;
  fxent endon("death");
  fxent setscriptablepartstate("smoke", "dissipate");
  fxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  fxent stoploopsound();
  wait 4.5;
  fxent delete();
}

playerspawnextractchopper(position, site) {
  extractgroundpos = position;
  _id_DB4ADBA9675A31AA = extractgroundpos + (0, 0, 2000);
  _id_CC089176A2D8AB71 = extractgroundpos + (0, 0, 8000);
  _id_7CE2EF2A1EFE71A6 = extractgroundpos + (0, 0, 800);
  flightyaw = 0;
  _id_FDA870B32AB92C1F = (0, 0, 0);
  _id_D7C5FF139C995BA6 = getdvarint("dvar_F38B8E35F5C48796", 0);

  if(_id_D7C5FF139C995BA6) {
    _id_7B021C6FFBDB9959 = getextractionpadent(extractgroundpos);

    if(isDefined(_id_7B021C6FFBDB9959)) {
      _id_D43B7286BF6E17A3 = _id_7B021C6FFBDB9959.script_noteworthy;
      _id_FDA870B32AB92C1F = _id_D43B7286BF6E17A3.angles;
    } else {
      flightyaw = getclearpathflightyaw(site, _id_CC089176A2D8AB71, _id_DB4ADBA9675A31AA);
      _id_FDA870B32AB92C1F = (0, flightyaw, 0);
    }
  } else {
    flightyaw = getclearpathflightyaw(site, _id_CC089176A2D8AB71, _id_DB4ADBA9675A31AA);
    _id_FDA870B32AB92C1F = (0, flightyaw, 0);
  }

  if(getdvarint("dvar_D5878CA9E558DD32", 0) == 1) {
    _id_CB2DC60F7CAFC6D4 = -100;
    _id_F0DB3D408327DB23 = 60;
    _id_67C2F437706DE4A1 = anglesToForward(_id_FDA870B32AB92C1F);
    _id_954350C43B0BCBC2 = anglestoright(_id_FDA870B32AB92C1F);
    extractgroundpos = extractgroundpos + _id_67C2F437706DE4A1 * _id_CB2DC60F7CAFC6D4 + _id_954350C43B0BCBC2 * _id_F0DB3D408327DB23;
    _id_DB4ADBA9675A31AA = extractgroundpos + (0, 0, 2000);
    _id_7CE2EF2A1EFE71A6 = extractgroundpos + (0, 0, 800);
  }

  _id_16CEDB94FAF4D596 = _id_CC089176A2D8AB71 - anglesToForward(_id_FDA870B32AB92C1F) * 20000;
  heli = spawnheli(self, _id_16CEDB94FAF4D596, _id_DB4ADBA9675A31AA, _id_7CE2EF2A1EFE71A6, extractgroundpos);
  return heli;
}

getextractionpadent(_id_26A6F862062E4340) {
  _id_26E41B62067100FB = undefined;

  foreach(_id_B1D9D00302A9B4D6 in level.plunderpads) {
    if(isDefined(_id_B1D9D00302A9B4D6) && distance2dsquared(_id_B1D9D00302A9B4D6.origin, _id_26A6F862062E4340) <= 10000) {
      _id_26E41B62067100FB = _id_B1D9D00302A9B4D6;
      break;
    }
  }

  return _id_26E41B62067100FB;
}

getclearpathflightyaw(site, _id_E58119F7C6EB5B4D, _id_D3970A3E6C77212E) {
  if(isDefined(site) && isDefined(site.flightyaw))
    return site.flightyaw;

  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  _id_3674D96C61E2DD0D = 0;

  for(yaw = 0; yaw < 360; yaw = yaw + _id_3FB4A86293ED25A6) {
    _id_3674D96C61E2DD0D = _id_3674D96C61E2DD0D + yaw;
    _id_211FC11F4C8566F5 = (0, _id_3674D96C61E2DD0D, 0);
    _id_29006F80487A7787 = _id_E58119F7C6EB5B4D - anglesToForward(_id_211FC11F4C8566F5) * 20000;
    _id_DD77D0A6D708AC18 = _id_D3970A3E6C77212E;
    _id_D4EB961F60968A16 = scripts\engine\trace::sphere_trace(_id_29006F80487A7787, _id_DD77D0A6D708AC18, 100, undefined, contents, 1);

    if(_id_D4EB961F60968A16["fraction"] == 1) {
      if(isDefined(site))
        site.flightyaw = _id_3674D96C61E2DD0D;

      return _id_3674D96C61E2DD0D;
    }

    if(yaw % 3 == 0)
      waitframe();
  }

  return _id_3674D96C61E2DD0D;
}

drophelicrate(heli) {
  if(!isDefined(heli.plunder)) {
    return;
  }
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_fail_chopper", self.team, 1);
  plunder_allowrepositoryuse(self.crate, 0);
  crate = self.crate;
  self.crate = undefined;
  crate.plunder = heli.plunder;
  _id_D917428537562C1F = crate.origin;
  end = (_id_D917428537562C1F[0], _id_D917428537562C1F[1], -12000);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  trace = scripts\engine\trace::ray_trace(_id_D917428537562C1F, end, heli, contents);
  _id_01230EA36A300368 = trace["position"];
  dist = _id_D917428537562C1F[2] - _id_01230EA36A300368[2];

  if(dist > 0) {
    time = sqrt(2 * dist / 800);
    crate moveTo(_id_01230EA36A300368, time, time, 0);
    wait(time);
  }

  crate.origin = _id_01230EA36A300368;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact_ground"), _id_01230EA36A300368);
  entityplunderlosealldeposited(crate, 1);
  crate thread helicratedelete(heli);
}

calculatehelitimetoflysec(_id_C45865D4C48493C1, _id_88125F10D2B34AA3, _id_B2BDD90249635576) {
  _id_3D0EC1C05F1E1001 = _id_C45865D4C48493C1 * 0.0000157828;
  a = 0.5 * _id_B2BDD90249635576;
  b = _id_88125F10D2B34AA3;
  c = -1 * _id_3D0EC1C05F1E1001;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / (2 * a);
  flytime = flytime * 3600;
  flytime = flytime + 1.5;
  return flytime;
}

calculatehelitimetoarrive(_id_625180CE8D2F8F77) {
  _id_5301EBED8D610FDB = calculatehelitimetoflysec(20000, 100, 125);
  _id_EB0FAE3483A10D88 = calculatehelitimetoflysec(_id_625180CE8D2F8F77, 25.0, 31.25);
  totaltime = _id_5301EBED8D610FDB + _id_EB0FAE3483A10D88;
  return totaltime;
}

heligotoplunderrepository(_id_930DA2D55099A285) {
  self endon("death");
  self endon("leaving");
  groundz = self.extractgroundpos[2];
  _id_625180CE8D2F8F77 = self.descendpos[2] - groundz;
  self.flytime = calculatehelitimetoarrive(_id_625180CE8D2F8F77);
  thread heliwatchgameendleave();
  self.preventleave = 1;
  helidescend();
  self.preventleave = undefined;
  self setscriptablepartstate("vector_field", "on");

  if(!istrue(level.gameended)) {
    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_arrive", self.team, 1);

    thread heliwaitatplunderrepository(_id_930DA2D55099A285);
    return;
  }

  thread helileave(1);
}

heliwaitatplunderrepository(_id_930DA2D55099A285) {
  plunderrepositoryref = undefined;

  if(_id_930DA2D55099A285.type == "brloot_plunder_extraction_site_01")
    plunderrepositoryref = "plunderHelipad1";
  else if(_id_930DA2D55099A285.type == "brloot_plunder_extraction_site_02")
    plunderrepositoryref = "plunderHelipad2";
  else if(_id_930DA2D55099A285.type == "brloot_quest_extract_site_plunder")
    plunderrepositoryref = "extractHelipadPlunder";
  else if(_id_930DA2D55099A285.type == "brloot_quest_extract_site_br")
    plunderrepositoryref = "extractHelipadBR";
  else {}

  plunder_registerrepositoryinstance(_id_930DA2D55099A285, plunderrepositoryref);
  players = undefined;

  if(isDefined(self.team))
    players = scripts\mp\utility\teams::getfriendlyplayers(self.team);

  thread plunder_repositorywatchcountdown(_id_930DA2D55099A285, players);
  plunder_updateanchoredwidgetforplayers(_id_930DA2D55099A285, players);
}

helibankplunder(_id_930DA2D55099A285) {
  if(!istrue(level.gameended) && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_success", self.team, 1);

  data = _id_930DA2D55099A285 entityplunderbankalldeposited();

  if(isDefined(data) && isDefined(data.amounttotal) && data.amounttotal > 0) {
    level.br_plunder.extraction_helicoptor_total_plunder = level.br_plunder.extraction_helicoptor_total_plunder + data.amounttotal;
    level.br_plunder.extraction_helicoptor_num_completed++;
  }
}

spawnropeandbag(heli) {
  _id_F145946A5DBE4871 = spawn("script_model", (0, 0, 0));
  _id_F145946A5DBE4871 setModel("tag_origin");
  _id_F145946A5DBE4871 linkTo(heli, "origin_animate_jnt", scripts\engine\utility::ter_op(istrue(level._id_A83A4E71446BFEF7), (-142.719, 0, 22.931), (0, 0, 0)), (0, 0, 0));
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("misc_rapelling_rope_01_fiber_br");
  rope linkTo(_id_F145946A5DBE4871, "tag_origin");
  rope.animname = heli.animname;
  rope scripts\common\anim::setanimtree();
  _id_F145946A5DBE4871 scripts\common\anim::anim_first_frame_solo(rope, "rope_in", "tag_origin");
  crate = spawn("script_model", (0, 0, 0));

  if(istrue(level._id_A83A4E71446BFEF7))
    crate setModel("br_plunder2_extraction_delivery_bag");
  else
    crate setModel("br_plunder_extraction_delivery_bag");

  crate linkTo(_id_F145946A5DBE4871, "tag_origin");
  crate.animname = heli.animname;
  crate scripts\common\anim::setanimtree();
  _id_F145946A5DBE4871 scripts\common\anim::anim_first_frame_solo(crate, "bag_in", "tag_origin");
  heli.rope = rope;
  heli.crate = crate;
  heli._id_F145946A5DBE4871 = _id_F145946A5DBE4871;
}

spawnheli(owner, enterpos, descendpos, hoverpos, extractgroundpos) {
  _id_87CEF10BF5729579 = 1;
  _id_1D4278103BA47A16 = vectortoangles(descendpos * (1, 1, 0) - enterpos * (1, 1, 0));
  modelname = "veh8_mil_air_mindia8_plunder_x";
  vehiclename = "veh_apache_plunder_mp";
  _id_86DBA443A811DAEB = (0, 0, 0);

  if(istrue(level._id_A83A4E71446BFEF7)) {
    modelname = "veh9_mil_air_heli_blima_mp_x";
    vehiclename = "veh9_mil_air_heli_blima_nophysics_br";
    _id_86DBA443A811DAEB = (126, 0, -20);
  }

  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, enterpos, _id_1D4278103BA47A16, vehiclename, modelname);

  if(!isDefined(heli)) {
    return;
  }
  heli.damagecallback = ::callback_vehicledamage;
  heli.speed = 100;
  heli.accel = 125;
  heli.health = scripts\engine\utility::ter_op(scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk", level.extractplunderhelihealth, 1000);
  heli.maxhealth = heli.health;
  heli.team = owner.team;
  heli.owner = owner;
  heli.lifeid = 0;
  heli.flaresreservecount = _id_87CEF10BF5729579;
  heli.enterpos = enterpos;
  heli.descendpos = descendpos;
  heli.hoverpos = hoverpos;
  heli.extractgroundpos = extractgroundpos;
  heli.sceneangles = _id_1D4278103BA47A16;
  heli.vehiclename = "magma_plunder_chopper";
  heli.animname = "plunder_extract_heli";
  heli setCanDamage(1);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(1, 1, 1);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  heli setvehicleteam(heli.team);
  heli setscriptablepartstate("engine", "on");

  if(!istrue(level._id_A83A4E71446BFEF7)) {
    heli setscriptablepartstate("tail_light", "red");
    heli setscriptablepartstate("cockpit_light", "on");
  }

  heli setscriptablepartstate("infil_lights", "on");
  heli.scenenode = spawn("script_model", heli.extractgroundpos + _id_86DBA443A811DAEB);
  heli.scenenode.angles = heli.sceneangles;
  heli.scenenode setModel("tag_origin");
  heli.scenenode scripts\common\anim::anim_first_frame_solo(heli, "heli_in");
  spawnropeandbag(heli);
  return heli;
}

helicratedelete(heli) {
  plunder_deregisterrepositoryinstance(self);
  self hide();

  if(isDefined(heli))
    heli.crate = undefined;

  waitframe();
  self delete();
}

helidestroyed() {
  self endon("heli_gone");
  owner = self.owner;
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  _id_A8EEB94DCC610B78 = 0;

  if(isDefined(self.plunder)) {
    foreach(item in self.plunder)
    _id_A8EEB94DCC610B78 = _id_A8EEB94DCC610B78 + item.plundercount;
  }

  _id_715028F54BAD19A1::branalytics_plunder_extraction_failure(_id_A8EEB94DCC610B78, "little_bird", self.extractgroundpos, self.origin);
  thread drophelicrate(self);
  helicleanup();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread helicrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  heliexplode(attacker);
}

helicleanup() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate thread helicratedelete(self);

  if(isDefined(self.scenenode))
    self.scenenode delete();

  if(isDefined(self._id_F145946A5DBE4871))
    self._id_F145946A5DBE4871 delete();
}

heliexplode(attacker) {
  _id_240A4F3D560753FF = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(_id_240A4F3D560753FF, 256, 140, 70, attacker, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), _id_240A4F3D560753FF, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(_id_240A4F3D560753FF, "veh_chopper_support_crash");
  earthquake(0.8, 1.5, _id_240A4F3D560753FF, 384);
  playrumbleonposition("grenade_rumble", _id_240A4F3D560753FF);
  physicsexplosionsphere(_id_240A4F3D560753FF, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread _id_1E4A61DB11011446::teamsplashbr("br_extract_heli_shot_down", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp");
  helidelete();
}

helidelete() {
  helicleanup();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

helicrash(speed) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if(istrue(level.extractplunderheliinvulnerable)) {
    return;
  }
  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname);
}

helileave(_id_C76F5BA0AD745444) {
  if(istrue(self.tryingtoleave) || istrue(self.leaving)) {
    return;
  }
  self endon("death");
  self notify("try_to_leave");
  self.tryingtoleave = 1;

  if(!istrue(level.gameended) && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_leave", self.team, 1);

  _id_930DA2D55099A285 = self.site;

  if(isDefined(_id_930DA2D55099A285)) {
    plunder_repositoryclearcountdown(_id_930DA2D55099A285);
    helibankplunder(_id_930DA2D55099A285);

    if(isDefined(_id_930DA2D55099A285.heli) && _id_930DA2D55099A285.heli == self) {
      _id_930DA2D55099A285.heli = undefined;
      _id_930DA2D55099A285.team = undefined;
      _id_930DA2D55099A285 notify("heli_left");
    }

    _id_930DA2D55099A285 thread heli_delayedpadstateupdate(self.site.type);
    self.site = undefined;
  }

  self.readytoleave = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self.leaving = 1;
  self.tryingtoleave = undefined;
  _id_DBEE990416F1879A = getanimlength(level.scr_anim[self.animname]["heli_out"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_out");
  self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "tag_origin");
  self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.crate, "bag_out", "tag_origin");
  thread _id_2BBE8AF3E7FA2471(self, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_DBEE990416F1879A);
  self stoploopsound();
  self notify("heli_gone");
  helidelete();
}

_id_2BBE8AF3E7FA2471(vehicle, _id_927B3199642B75FC) {
  switch (_id_927B3199642B75FC) {
    case 0:
      vehicle setscriptablepartstate("plunder_sfx", "heli_in");
      break;
    case 1:
      vehicle setscriptablepartstate("plunder_sfx", "heli_loop");
      break;
    case 2:
      vehicle setscriptablepartstate("plunder_sfx", "heli_out");
      break;
  }
}

heli_delayedpadstateupdate(type) {
  scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), "inuseCurrent", "inuse");
  self setscriptablepartstate(type, scriptablestate);
  wait 6;

  if(isDefined(self)) {
    scriptablestate = scripts\engine\utility::ter_op(istrue(level.showplunderextracticonsinworld) && !istrue(level.shownonscriptableextracticons), self.activecurrstate, self.activestate);
    self setscriptablepartstate(type, scriptablestate);
  }
}

helidescend() {
  self endon("death");
  thread _id_2BBE8AF3E7FA2471(self, 0);
  _id_228083B1CC503599 = getanimlength(level.scr_anim[self.animname]["heli_in"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "tag_origin");
  self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.crate, "bag_in", "tag_origin");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_228083B1CC503599);
  thread heliplayloopanim();
  thread heliplayloopropeanim();
  thread heliplayloopbadanim();
}

heliplayloopanim() {
  self endon("death");
  self.scenenode endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.animname]["heli_loop"]);

  for(;;) {
    self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_loop");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave) && !istrue(self.preventleave)) {
      self notify("ready_to_leave");
      break;
    }
  }
}

heliplayloopropeanim() {
  self endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.animname]["rope_loop"]);

  for(;;) {
    self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.rope, "rope_loop", "tag_origin");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

heliplayloopbadanim() {
  self endon("death");
  _id_EB5B1F36E255152D = getanimlength(level.scr_anim[self.animname]["bag_loop"]);

  for(;;) {
    self._id_F145946A5DBE4871 thread scripts\common\anim::anim_single_solo(self.crate, "bag_loop", "tag_origin");
    wait(_id_EB5B1F36E255152D);

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

helidestroyvehiclestouchnotify() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", vehicle);

    if(isDefined(vehicle) && vehicle entisalivevehicle())
      vehicle dodamage(vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH");
  }
}

helidestroyvehiclestouchtrace() {
  self endon("leaving");
  self endon("death");
  radius = 70;
  _id_7CFE8395A8CF5836 = -80;
  forward = 150;
  _id_63E26D5A86AC531C = 25;
  back = -100;

  for(;;) {
    vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(vehicles.size <= 1) {
      wait 0.5;
      continue;
    }

    _id_7346EB0E818B60C5 = scripts\engine\trace::create_vehicle_contents();
    dir = anglesToForward(self.angles);
    origin = self.origin + dir * getdvarfloat("test_f", forward) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_m", _id_63E26D5A86AC531C) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_b", back) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

tracegroundheight(start) {
  _id_DC8BB6300463CF1E = 800;
  _id_E7A7D619F927D791 = tracegroundpoint(start);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(start) {
  self endon("death");
  self endon("leaving");
  _id_379FF849B3CDA7D7 = -99999;
  end = (start[0], start[1], _id_379FF849B3CDA7D7);
  ignorelist = [self];
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 1, 1, 0);
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(start, end, 100, ignorelist, contents, 1);
  _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];
  return _id_0FA83E3A4C4E6902;
}

heliwatchgameendleave() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread helileave(0);
}

helicountdownendcallback(entity, _id_C76F5BA0AD745444) {
  plunder_repositoryextract(entity);
}

heliextractcallback(entity) {
  if(isDefined(entity.heli))
    entity.heli thread helileave(1);
}

heliatcapacitycallback(entity) {}

plunderlivelobby() {
  thread autopickupplunder();
}

inplunderlivelobby() {
  return istrue(level.br_plunder_enabled) && istrue(level.br_plunder_lobby) && !scripts\mp\flags::gameflag("prematch_done");
}

autopickupplunder() {
  _id_D818DC2E4C3F6146 = 0.1;
  _id_4BC125B68D3F84A8 = 25;
  _id_6635EA180B2DBE19 = _id_4BC125B68D3F84A8 * _id_4BC125B68D3F84A8;

  while(inplunderlivelobby()) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder_ents.size; _id_AC0E594AC96AA3A8++) {
      pickupent = level.br_plunder_ents[_id_AC0E594AC96AA3A8];

      if(!isDefined(pickupent)) {
        continue;
      }
      _id_7AE23D8BD45FD01C = pickupent.origin;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.players.size; _id_AC0E5C4AC96AAA41++) {
        player = level.players[_id_AC0E5C4AC96AAA41];

        if(!isalive(player)) {
          continue;
        }
        distsq = distancesquared(player.origin, _id_7AE23D8BD45FD01C);

        if(distsq < _id_6635EA180B2DBE19) {
          player _id_7E52B56769FA7774::brpickupsusecallback(pickupent, player);
          break;
        }
      }
    }

    wait(_id_D818DC2E4C3F6146);
  }
}

playerdelayautobankplunder() {
  self notify("playerDelayAutoBankPlunder");
  self endon("playerDelayAutoBankPlunder");
  self endon("death");
  level endon("prematch_done");
  level endon("game_ended");
  wait 2;
  playerplunderbank(self.plundercount);
}

playerplunderlivelobbydropondeath(smeansofdeath) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(inplunderlivelobby()) {
    _id_53AAAE2C915F815B = smeansofdeath == "MOD_MELEE";
    amount = 1;

    if(_id_53AAAE2C915F815B && isDefined(self.plundercount) && self.plundercount > 1) {
      amount = self.plundercount;
      playersetplundercount(0);
    }

    if(amount <= 0) {
      return;
    }
    if(level.br_plunder_ents.size > 0)
      level.br_plunder_ents = scripts\engine\utility::array_removeundefined(level.br_plunder_ents);

    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    return dropcondensedplunder(amount, dropstruct);
  }
}

initteamdatafields() {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["plunderTeamTotal"] = 0;
    level.teamdata[team]["plunderInDeposit"] = 0;
    level.teamdata[team]["plunderBanked"] = 0;
  }

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
    foreach(team in level.teamnamelist) {
      level.teamdata[team]["tokensTeamTotal"] = 0;
      level.teamdata[team]["tokensInDeposit"] = 0;
      level.teamdata[team]["tokensBanked"] = 0;
    }
  }
}

getteamplunder(team) {
  plundercount = 0;

  if(!level.scorerequiresbanking) {
    plundercount = plundercount + level.teamdata[team]["plunderTeamTotal"];
    plundercount = plundercount + level.teamdata[team]["plunderInDeposit"];
  }

  plundercount = plundercount + level.teamdata[team]["plunderBanked"];
  return plundercount;
}

getteamcarriedplunder(team) {
  return level.teamdata[team]["plunderTeamTotal"];
}

getbankedplunder(team) {
  return level.teamdata[team]["plunderBanked"];
}

getplundernamebyamount(amount) {
  _id_3466C10973E9C476 = level.br_plunder.names[0];

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    if(amount >= level.br_plunder.quantity[_id_AC0E594AC96AA3A8]) {
      _id_3466C10973E9C476 = level.br_plunder.names[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return _id_3466C10973E9C476;
}

playplundersoundbyamount(player, amount) {
  if(amount == 0) {
    return;
  }
  _id_3466C10973E9C476 = getplundernamebyamount(amount);
  soundalias = _id_7E52B56769FA7774::getcashsoundaliasforplayer(player, _id_3466C10973E9C476);
  player playsoundtoplayer(soundalias, self);
}

processcashpilevalueoverrides() {
  _id_0A2137920FF428A1 = getdvarint("dvar_3C33B53363A2FB48", 1);

  if(_id_0A2137920FF428A1 <= 1) {
    return;
  }
  foreach(name, value in level.br_pickups.counts) {
    if(!issubstr(name, "brloot_plunder_cash")) {
      continue;
    }
    _id_AA82E6D1B3760575 = level.br_pickups.counts[name];
    _id_8F617FFD000EB682 = _id_AA82E6D1B3760575 * _id_0A2137920FF428A1;
    level.br_pickups.counts[name] = _id_8F617FFD000EB682;
    scriptables = getentitylessscriptablearray(name);

    if(scriptables.size >= 1) {
      foreach(scriptable in scriptables)
      scriptable.count = _id_8F617FFD000EB682;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_plunder.names.size; _id_AC0E594AC96AA3A8++)
    level.br_plunder.quantity[_id_AC0E594AC96AA3A8] = level.br_pickups.counts[level.br_plunder.names[_id_AC0E594AC96AA3A8]];
}

processcashpileovertimemultiplier(_id_98EA5AFB293A76A2) {
  foreach(index, name in level.br_plunder.names) {
    level.br_plunder.quantity[index] = int(float(level.br_plunder.quantity[index]) * _id_98EA5AFB293A76A2);
    level.br_pickups.counts[name] = level.br_plunder.quantity[index];
    scriptables = getentitylessscriptablearray(name);

    foreach(scriptable in scriptables)
    scriptable.count = level.br_plunder.quantity[index];

    waitframe();
  }
}

debug_calculatecashonground() {
  total = 0;

  foreach(index, name in level.br_plunder.names) {
    scriptables = getentitylessscriptablearray(name);
    total = total + scriptables.size * level.br_pickups.counts[name];
  }

  total = total * 100;
  level.totalcashongroundatstart = total;
}

plunder_initrepositories() {
  level.plunderrepositories = spawnStruct();
  level.plunderrepositories.data = [];
  level.plunderrepositories.instances = [];
  level.plunderrepositories.uniqueinstanceid = 0;
  level.plunderrepositories.teamanchoredwidgetinstances = [];
  level.plunderrepositories.teamanchoredentomnvars = [];
  level.plunderrepositories.teamanchoredinfoomnvars = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
    level.plunderrepositories.teamanchoredentomnvars[_id_AC0E594AC96AA3A8] = "ui_br_plunder_repo_ent_" + _id_AC0E594AC96AA3A8;
    level.plunderrepositories.teamanchoredinfoomnvars[_id_AC0E594AC96AA3A8] = "ui_br_plunder_repo_info_" + _id_AC0E594AC96AA3A8;
  }

  scripts\common\interactive::interactive_addusedcallback(::plunder_repositoryusecallback, "plunderRepository");
  scripts\engine\scriptable::scriptable_addusedcallback(::plunder_repositoryusescriptablecallback);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::plunder_playerspawnedcallback);
  level.plunderusedisabledwhenempty = getdvarint("dvar_EB449C46ED5955E6", 0) > 0;
}

plunder_getleveldataforrepository(ref, create, _id_6ECB77FD1F27C667) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;
  _id_464EB48901113EB0 = _id_962A30A9BB8C0F09.data[ref];

  if(!isDefined(_id_464EB48901113EB0)) {
    if(istrue(create)) {
      _id_464EB48901113EB0 = spawnStruct();
      _id_962A30A9BB8C0F09.data[ref] = _id_464EB48901113EB0;
      _id_464EB48901113EB0.usetime = 0.75;
      _id_464EB48901113EB0.useeventtype = 2;
      _id_464EB48901113EB0.useeventamount = 250;
      _id_464EB48901113EB0.teamuseonly = 1;
      _id_464EB48901113EB0.teamanchoredwidget = 0;
      _id_464EB48901113EB0.usefaillaststandmsg = "MP/CANNOT_DEPOSIT_LS";
      _id_464EB48901113EB0.usefailvehiclemsg = "MP/CANNOT_DEPOSIT_VEHICLE";
      _id_464EB48901113EB0.usefailcapacitymsg = "MP/PLACEHOLDER_CANNOT_DEPOSIT_FULL";
      _id_464EB48901113EB0.usefailnoplundermsg = "MP/CANNOT_DEPOSIT_NO_CASH";
      _id_464EB48901113EB0.usefailextractingmsg = "MP/PLACEHOLDER_CANNOT_DEPOSIT_LEAVING";
      _id_464EB48901113EB0.scriptableusepart = undefined;
      _id_464EB48901113EB0.scriptableusestate = undefined;
      _id_464EB48901113EB0.scriptablenousestate = undefined;
      _id_464EB48901113EB0.extractcountdown = 60;
      _id_464EB48901113EB0.extractsilentcountdown = 0;
      _id_464EB48901113EB0.extractcountdownmsg = "MP/PLACEHOLDER_LEAVING_IN_N";
      _id_464EB48901113EB0.capacity = 2000;
      _id_464EB48901113EB0.useshouldsucceedcallback = undefined;
      _id_464EB48901113EB0.usecallback = ::plunder_repositoryplayerplundereventcallback;
      _id_464EB48901113EB0.countdownendcallback = undefined;
      _id_464EB48901113EB0.extractcallback = undefined;
      _id_464EB48901113EB0.extractionmethod = undefined;
    } else {}
  }

  return _id_464EB48901113EB0;
}

plunder_registerrepositoryinstance(entity, ref) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(ref);
  entity.plunderrepositoryref = ref;
  entity.startorigin = entity.origin;
  entity.plunder = [];
  entity.plundertotal = 0;
  entity.plunderinstanceid = level.plunderrepositories.uniqueinstanceid;
  level.plunderrepositories.uniqueinstanceid++;
  entity.playersusing = [];
  _id_962A30A9BB8C0F09.instances[entity.plunderinstanceid] = entity;
  plunder_addanchoredwidgettorepositoryinstance(entity);

  if(!isDefined(_id_464EB48901113EB0.scriptableusepart))
    entity scripts\common\interactive::interactive_addusedcallbacktoentity("plunderRepository");

  plunder_allowrepositoryuse(entity, 1);
}

plunder_deregisterrepositoryinstance(entity) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;
  entity notify("plunder_instance_deregistered");
  plunder_allowrepositoryuse(entity, 0, 1);
  entity.plunderrepositoryref = undefined;
  entity.plunderusable = undefined;
  entity.plunderatcapacity = undefined;
  entity.startorigin = undefined;
  entity.plunder = undefined;
  entity.plundertotal = undefined;
  plunder_repositoryclearcountdown(entity);
  entity.playersusing = undefined;

  if(isDefined(entity.plunderinstanceid))
    _id_962A30A9BB8C0F09.instances[entity.plunderinstanceid] = undefined;

  plunder_removeanchoredwidgetfromrepositoryinstance(entity);
  entity scripts\common\interactive::interactive_removeusedcallbackfromentity();
}

plunder_repositoryinstanceisregistered(entity) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;

  if(!isDefined(_id_962A30A9BB8C0F09))
    return 0;

  instance = undefined;

  if(isDefined(entity.plunderinstanceid))
    instance = _id_962A30A9BB8C0F09.instances[entity.plunderinstanceid];

  return isDefined(instance) && instance == entity;
}

plunder_allowrepositoryuse(entity, _id_E3108E412AFB3811, _id_6ECB77FD1F27C667) {
  entity notify("plunder_allowRepositoryUse");
  _id_464EB48901113EB0 = undefined;

  if(isDefined(entity.plunderrepositoryref))
    _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref, undefined, _id_6ECB77FD1F27C667);

  if(isDefined(_id_464EB48901113EB0)) {
    if(isDefined(_id_464EB48901113EB0.scriptableusepart)) {
      if(_id_E3108E412AFB3811)
        entity setscriptablepartstate(_id_464EB48901113EB0.scriptableusepart, _id_464EB48901113EB0.scriptableusestate, 0);
      else
        entity setscriptablepartstate(_id_464EB48901113EB0.scriptableusepart, _id_464EB48901113EB0.scriptablenousestate, 0);
    } else if(_id_E3108E412AFB3811)
      entity makeusable();
    else
      entity makeunusable();

    _id_BE40DCF3D84912F6 = istrue(entity.plunderusable);
    entity.plunderusable = scripts\engine\utility::ter_op(_id_E3108E412AFB3811, _id_E3108E412AFB3811, undefined);

    if(!_id_BE40DCF3D84912F6) {
      if(_id_E3108E412AFB3811) {
        foreach(player in level.players)
        plunder_allowrepositoryuseforplayer(entity, player, plunder_playercanuserepository(entity, player));
      }
    } else if(!_id_E3108E412AFB3811)
      entity notify("repository_use_disabled");
  }
}

plunder_allowrepositoryuseforplayer(entity, player, _id_E3108E412AFB3811, _id_6ECB77FD1F27C667) {
  _id_464EB48901113EB0 = undefined;

  if(isDefined(entity.plunderrepositoryref))
    _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref, undefined, _id_6ECB77FD1F27C667);

  if(isDefined(_id_464EB48901113EB0)) {
    if(isDefined(_id_464EB48901113EB0.scriptableusepart)) {
      if(_id_E3108E412AFB3811)
        entity enablescriptablepartplayeruse(_id_464EB48901113EB0.scriptableusepart, player);
      else
        entity disablescriptablepartplayeruse(_id_464EB48901113EB0.scriptableusepart, player);
    } else if(_id_E3108E412AFB3811)
      entity enableplayeruse(player);
    else
      entity disableplayeruse(player);
  }

  if(!_id_E3108E412AFB3811)
    entity notify("repository_use_disabled_for_" + player getentitynumber());
}

plunder_allowallrepositoryuseforplayer(player, _id_E3108E412AFB3811, _id_6ECB77FD1F27C667) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;

  foreach(instance in _id_962A30A9BB8C0F09.instances)
  plunder_allowrepositoryuseforplayer(instance, player, _id_E3108E412AFB3811, 1);
}

plunder_playercanuserepository(entity, player) {
  if(player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(scripts\mp\utility\player::isinlaststand(player))
    return 0;

  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(istrue(_id_464EB48901113EB0.teamuseonly) && isDefined(entity.team) && player.team != entity.team)
    return 0;

  return 1;
}

plunder_playerrepositoryuseshouldsucceed(entity, player, _id_D7F72825D583F8FE) {
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(!istrue(entity.plunderusable))
    return 0;

  if(_id_464EB48901113EB0.useeventtype == 2 || _id_464EB48901113EB0.useeventtype == 3) {
    if(player.plundercount <= 0 && (!isDefined(player.extractquest_alwaysallowdeposit) || player.extractquest_helipadid != entity.index)) {
      if(istrue(_id_D7F72825D583F8FE) && isDefined(_id_464EB48901113EB0.usefailnoplundermsg) && _id_464EB48901113EB0.usefailnoplundermsg != "") {
        player playlocalsound("br_plunder_atm_cancel");
        player scripts\mp\hud_message::showerrormessage(_id_464EB48901113EB0.usefailnoplundermsg);
      }

      return 0;
    } else if(istrue(entity.plunderatcapacity)) {
      if(istrue(_id_D7F72825D583F8FE) && isDefined(_id_464EB48901113EB0.usefailcapacitymsg) && _id_464EB48901113EB0.usefailcapacitymsg != "") {
        player playlocalsound("br_plunder_atm_cancel");
        player scripts\mp\hud_message::showerrormessage(_id_464EB48901113EB0.usefailcapacitymsg);
      }

      return 0;
    }
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(istrue(_id_D7F72825D583F8FE) && isDefined(_id_464EB48901113EB0.usefailvehiclemsg) && _id_464EB48901113EB0.usefailvehiclemsg != "") {
      player playlocalsound("br_plunder_atm_cancel");
      player scripts\mp\hud_message::showerrormessage(_id_464EB48901113EB0.usefailvehiclemsg);
    }

    return 0;
  }

  if(scripts\mp\utility\player::isinlaststand(player)) {
    if(istrue(_id_D7F72825D583F8FE) && isDefined(_id_464EB48901113EB0.usefaillaststandmsg) && _id_464EB48901113EB0.usefaillaststandmsg != "") {
      player playlocalsound("br_plunder_atm_cancel");
      player scripts\mp\hud_message::showerrormessage(_id_464EB48901113EB0.usefaillaststandmsg);
    }

    return 0;
  }

  if(player isparachuting() || player isskydiving())
    return 0;

  if(player isinexecutionattack() || player isinexecutionvictim())
    return 0;

  if(isDefined(_id_464EB48901113EB0.useshouldsucceedcallback))
    return [[_id_464EB48901113EB0.useshouldsucceedcallback]](entity, player, _id_D7F72825D583F8FE);

  return 1;
}

plunder_repositoryusescriptablecallback(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance)) {
    return;
  }
  entity = instance.entity;

  if(!isDefined(entity) || isDefined(entity.forceextractscriptable))
    entity = instance;

  if(!plunder_repositoryinstanceisregistered(entity)) {
    return;
  }
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(!isDefined(_id_464EB48901113EB0.scriptableusepart)) {
    return;
  }
  if(part != _id_464EB48901113EB0.scriptableusepart) {
    return;
  }
  if(state != _id_464EB48901113EB0.scriptableusestate) {
    return;
  }
  if(!plunder_playerrepositoryuseshouldsucceed(entity, player, 1)) {
    return;
  }
  thread plunder_repositoryusecallbackinternal(entity, player);
}

plunder_repositoryusecallback(entity, player) {
  if(!plunder_repositoryinstanceisregistered(entity)) {
    return;
  }
  if(!plunder_playerrepositoryuseshouldsucceed(entity, player, 1)) {
    return;
  }
  thread plunder_repositoryusecallbackinternal(entity, player);
}

plunder_repositoryusecallbackinternal(entity, player) {
  entnum = player getentitynumber();
  timestamp = gettime();
  plunder_repositoryenableuserestrictions(player, 1);
  plunder_allowrepositoryuseforplayer(entity, player, 0);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player setclientomnvar("ui_br_plunder_balloon_extract_state", 1);

  plunder_repositorywatchuse(entity, player);

  if(isDefined(player)) {
    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      player setclientomnvar("ui_br_plunder_balloon_extract_state", 0);

    if(isDefined(entity))
      plunder_allowrepositoryuseforplayer(entity, player, 1);

    if(player scripts\cp_mp\utility\player_utility::_isalive())
      plunder_repositoryenableuserestrictions(player, 0);

    player.plunderrepositoryrestricted = undefined;

    if(isPlayer(player)) {
      _id_F812B18D7FAD2339 = 0;
      _id_776DF703E8901349 = undefined;

      if(!_id_F812B18D7FAD2339 && player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\cp_mp\utility\player_utility::isinvehicle() && !scripts\mp\utility\player::isinlaststand(player)) {
        if(istrue(entity.extracting))
          _id_776DF703E8901349 = 2;
        else if(isDefined(player.plunderrepositorywidget) && isDefined(player.plunderrepositorywidget.useeventtimestamp) && player.plunderrepositorywidget.useeventtimestamp - gettime() <= 1.5)
          _id_776DF703E8901349 = 1.5;
      }

      thread plunder_clearrepositorywidgetforplayer(player, _id_776DF703E8901349);
    }
  }

  if(isDefined(entity) && isDefined(entity.playersusing))
    entity.playersusing[entnum] = undefined;

  if(isDefined(player) && isPlayer(player))
    plunder_updateanchoredwidgetforplayers(entity, player);
}

_id_C219B1AF900D42BD(player, value) {
  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    return;
  }
  player setclientomnvar("ui_br_plunder_repo_use_once", value);
}

_id_3E921FF2120932CF(player, value) {
  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    return;
  }
  player setclientomnvar("ui_br_plunder_can_deposit", value);
}

_id_5EA8EC55A8559B6F(entity, player) {
  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    return;
  }
  _id_50DB038E099FD669 = plunder_playerrepositoryuseshouldsucceed(entity, player, 0);
  _id_3E921FF2120932CF(player, scripts\engine\utility::ter_op(_id_50DB038E099FD669, 1, 0));
}

plunder_repositorywatchuse(entity, player) {
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  entity endon("death");
  entity endon("repository_use_disabled");
  entity endon("repository_use_disabled_for_" + player getentitynumber());
  level endon("game_ended");
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);
  entity.playersusing[player getentitynumber()] = player;
  plunder_updaterepositorywidgetforplayer(player, entity.plunderinstanceid, _id_464EB48901113EB0.type, 1, entity.plundercountdownendtime, entity.plundertotal);
  plunder_sendrepositorywidgetomnvar(player);
  plunder_updateanchoredwidgetforplayers(entity, player);
  _id_5EA8EC55A8559B6F(entity, player);
  _id_F34424646F122CF3 = 0;
  usetime = 0;
  _id_ABA405F695679ED8 = _id_464EB48901113EB0.usetime;

  for(_id_585743C445B80CE6 = 0; player useButtonPressed(); usetime = usetime + 0.05) {
    showmessage = undefined;

    if(_id_F34424646F122CF3) {
      _id_F34424646F122CF3 = 0;
      showmessage = 0;
    } else
      showmessage = 1;

    _id_C219B1AF900D42BD(player, 0);

    if(!plunder_playerrepositoryuseshouldsucceed(entity, player, showmessage)) {
      _id_3E921FF2120932CF(player, 0);
      return;
    }

    _id_3E921FF2120932CF(player, 1);

    if(usetime >= _id_ABA405F695679ED8) {
      _id_975E20B8BD98753A = int(min(player.plundercount, _id_464EB48901113EB0.useeventamount));

      if(isDefined(_id_464EB48901113EB0.usecallback))
        thread[[_id_464EB48901113EB0.usecallback]](entity, player, _id_975E20B8BD98753A);
      else {}

      _id_C219B1AF900D42BD(player, 1);
      _id_585743C445B80CE6 = usetime;
      _id_ABA405F695679ED8 = usetime + _id_464EB48901113EB0.usetime;

      if(isDefined(player.plunderrepositorywidget))
        player.plunderrepositorywidget.useeventtimestamp = gettime();

      _id_F34424646F122CF3 = 1;
    }

    wait 0.05;
  }
}

plunder_repositoryplayerplundereventcallback(entity, player, amount) {
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);
  data = player playerplunderevent(amount, _id_464EB48901113EB0.useeventtype, entity);

  if(isDefined(data) && isDefined(data.amount))
    amount = data.amount;

  if(amount > 0) {
    plunder_updaterepositorywidgetforplayer(player, undefined, undefined, undefined, undefined, entity.plundertotal, amount);
    plunder_sendrepositorywidgetomnvar(player);
  }
}

plunder_repositoryenableuserestrictions(player, _id_E3108E412AFB3811) {
  restrictions = ["allow_movement", "usability", "weapon_switch", "equipment_primary", "equipment_secondary", "supers", "killstreaks", "fire", "melee", "reload", "ads", "mantle", "mount_top", "mount_side", "execution_attack", "vehicle_use", "cough_gesture"];

  if(istrue(player.plunderrepositoryrestricted) && _id_E3108E412AFB3811) {
    return;
  }
  if(!istrue(player.plunderrepositoryrestricted) && !_id_E3108E412AFB3811) {
    return;
  }
  if(_id_E3108E412AFB3811)
    player _id_3B64EB40368C1450::_id_59C053B89257BC95("plunder", restrictions, 0);
  else
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("plunder");

  if(_id_E3108E412AFB3811)
    player.plunderrepositoryrestricted = 1;
  else
    player.plunderrepositoryrestricted = undefined;
}

plunder_repositorywatchcountdown(entity, players) {
  entity endon("death");
  entity endon("plunder_instance_deregistered");
  entity notify("plunder_repositoryWatchCountdown");
  entity endon("plunder_repositoryWatchCountdown");
  level endon("game_ended");
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(!isDefined(entity.plundercountdownplayers)) {
    entity.plundercountdownplayers = [];
    entity.plundercountdownupdatetime = 0;
    _id_B68D7884CBAACA3B = scripts\engine\utility::ter_op(isDefined(_id_464EB48901113EB0.extractsilentcountdown), _id_464EB48901113EB0.extractsilentcountdown, 0);
    _id_792ED6BAA73AE134 = scripts\engine\utility::ter_op(isDefined(_id_464EB48901113EB0.extractcountdown), _id_464EB48901113EB0.extractcountdown, 0);
    entity.plundersilentcountdownendtime = gettime() + _id_B68D7884CBAACA3B * 1000;
    entity.plundercountdownendtime = gettime() + (_id_B68D7884CBAACA3B + _id_792ED6BAA73AE134) * 1000;
  }

  if(isDefined(players)) {
    if(!isarray(players))
      players = [players];

    foreach(player in players) {
      if(isDefined(player) && isPlayer(player))
        entity.plundercountdownplayers[player getentitynumber()] = player;
    }
  }

  while(gettime() <= entity.plundercountdownendtime) {
    if(gettime() - entity.plundercountdownupdatetime >= 1000) {
      if(gettime() > entity.plundersilentcountdownendtime) {
        _id_44C653D588DB89A7 = int(max(0, (entity.plundercountdownendtime - gettime()) / 1000));

        foreach(player in entity.plundercountdownplayers) {
          if(isDefined(player))
            thread plunder_repositorysendcountdownmessage(player, entity, _id_44C653D588DB89A7);
        }
      }

      entity.plundercountdownupdatetime = gettime();
    }

    wait 0.05;
  }

  thread plunder_repositoryendcountdown(entity, 1);
}

plunder_repositoryendcountdown(entity, _id_C76F5BA0AD745444) {
  plunder_repositoryclearcountdown(entity);
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(isDefined(_id_464EB48901113EB0.countdownendcallback))
    [[_id_464EB48901113EB0.countdownendcallback]](entity, _id_C76F5BA0AD745444);
}

plunder_repositoryclearcountdown(entity) {
  entity notify("plunder_repositoryWatchCountdown");
  entity.plundercountdownplayers = undefined;
  entity.plundercountdownendtime = undefined;
  entity.plundercountdownupdatetime = undefined;
}

plunder_repositorysendcountdownmessage(player, entity, value) {
  player endon("disconnect");
  player notify("plunder_repositorySendCountdownMessage");
  player endon("plunder_repositorySendCountdownMessage");
  level endon("game_ended");

  if(!isDefined(player.plundercountdownmessagedata))
    player.plundercountdownmessagedata = [];

  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(isDefined(_id_464EB48901113EB0.extractcountdownmsg)) {
    data = spawnStruct();
    data.origin = entity.origin;
    data.msg = _id_464EB48901113EB0.extractcountdownmsg;
    data.value = value;
    player.plundercountdownmessagedata[player.plundercountdownmessagedata.size] = data;
  }

  waittillframeend;

  if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && player scripts\cp_mp\utility\player_utility::_isalive()) {
    _id_939BDF45CE71425B = undefined;
    _id_6795239569233693 = 2147483647;

    foreach(data in player.plundercountdownmessagedata) {
      _id_3321F7BDE264CBF9 = distance2dsquared(player.origin, data.origin);

      if(_id_3321F7BDE264CBF9 < _id_6795239569233693) {
        _id_6795239569233693 = _id_3321F7BDE264CBF9;
        _id_939BDF45CE71425B = data;
      }
    }
  }

  player.plundercountdownmessagedata = undefined;
}

plunder_repositoryextract(entity) {
  entity.extracting = 1;
  plunder_repositoryclearcountdown(entity);
  plunder_allowrepositoryuse(entity, 0);
  plunder_removeanchoredwidgetfromrepositoryinstance(entity);
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(isDefined(_id_464EB48901113EB0.extractcallback))
    [[_id_464EB48901113EB0.extractcallback]](entity);
}

plunder_repositoryatcapacity(entity) {
  entity.plunderatcapacity = 1;
  plunder_allowrepositoryuse(entity, 0);
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(isDefined(_id_464EB48901113EB0.atcapacitycallback))
    [[_id_464EB48901113EB0.atcapacitycallback]](entity);
}

plunder_playerspawnedcallback() {
  plunder_allowallrepositoryuseforplayer(self, 1, 1);
}

plunder_updaterepositorywidgetforplayer(player, plunderinstanceid, type, visible, endtime, plundertotal, plundereventamount) {
  if(isDefined(visible) && !visible) {
    plunder_clearrepositorywidgetforplayer(player);
    return;
  }

  data = player.plunderrepositorywidget;

  if(!isDefined(data)) {
    data = spawnStruct();
    player.plunderrepositorywidget = data;
    data.plunderinstanceid = plunderinstanceid;
    data.type = type;
    data.visible = 0;
    data.endtime = undefined;
    data.plundertotal = undefined;
    data.plundereventamount = undefined;
    data.timestamp = undefined;
  } else if(isDefined(plunderinstanceid) && isDefined(data.plunderinstanceid) && plunderinstanceid != data.plunderinstanceid) {
    return;
  }
  _id_90AE65DD73557A80 = 0;

  if(istrue(visible)) {
    _id_90AE65DD73557A80 = !data.visible;
    data.visible = 1;
  }

  if(isDefined(endtime))
    data.endtime = endtime;

  if(isDefined(plundertotal))
    data.plundertotal = plundertotal;

  if(isDefined(plundereventamount)) {
    data.plundereventamount = plundereventamount;
    entity = level.plunderrepositories.instances[data.plunderinstanceid];

    foreach(_id_41FC74D8AF75C523 in entity.playersusing) {
      if(_id_41FC74D8AF75C523 != player) {
        plunder_updaterepositorywidgetforplayer(player, undefined, undefined, undefined, undefined, plundertotal, undefined);
        plunder_sendrepositorywidgetomnvar(player);
      }
    }

    if(isDefined(entity.team))
      plunder_updateanchoredwidgetforplayers(entity, scripts\mp\utility\teams::getfriendlyplayers(entity.team));
  } else if(isDefined(data.timestamp) && data.timestamp < gettime())
    data.plundereventamount = undefined;

  data.timestamp = gettime();
}

plunder_clearrepositorywidgetforplayer(player, delay) {
  player endon("disconnect");
  player endon("plunder_sendRepositoryWidgetOmnvar");
  player.plunderrepositorywidget = undefined;

  if(isDefined(delay) && delay > 0)
    wait(delay);

  player setclientomnvar("ui_br_plunder_repository", 0);
}

plunder_sendrepositorywidgetomnvar(player) {
  player notify("plunder_sendRepositoryWidgetOmnvar");
  data = player.plunderrepositorywidget;

  if(!isDefined(data)) {
    player setclientomnvar("ui_br_plunder_repository", 0);
    return;
  }

  value = 0;
  _id_B5C99E03C0C2DC5C = 0;
  payload = data.visible;
  _id_AEBF7845CFDDB470 = 1;

  if(isDefined(payload))
    value = value | int(payload) << _id_B5C99E03C0C2DC5C;

  _id_B5C99E03C0C2DC5C = _id_B5C99E03C0C2DC5C + _id_AEBF7845CFDDB470;
  payload = data.type;
  _id_AEBF7845CFDDB470 = 1;

  if(isDefined(payload))
    value = value | int(payload) << _id_B5C99E03C0C2DC5C;

  _id_B5C99E03C0C2DC5C = _id_B5C99E03C0C2DC5C + _id_AEBF7845CFDDB470;
  payload = data.endtime;
  _id_AEBF7845CFDDB470 = 14;

  if(isDefined(payload)) {
    payload = int(payload / 250);
    payload = payload & 16383;
    value = value | int(payload) << _id_B5C99E03C0C2DC5C;
  }

  _id_B5C99E03C0C2DC5C = _id_B5C99E03C0C2DC5C + _id_AEBF7845CFDDB470;

  if(data.type == 0) {
    payload = data.plundertotal;
    _id_AEBF7845CFDDB470 = 10;

    if(isDefined(payload)) {
      payload = int(payload / 5);
      payload = payload & 1023;
      value = value | int(payload) << _id_B5C99E03C0C2DC5C;
    }
  }

  _id_08661D51D71F341F = data.plundereventamount;

  if(isDefined(_id_08661D51D71F341F)) {
    _id_08661D51D71F341F = int(_id_08661D51D71F341F / 5);
    player setclientomnvar("ui_br_plunder_repository_event_amount", _id_08661D51D71F341F);
  }

  player setclientomnvar("ui_br_plunder_repository", value);
}

plunder_addanchoredwidgettorepositoryinstance(entity) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;
  _id_464EB48901113EB0 = plunder_getleveldataforrepository(entity.plunderrepositoryref);

  if(!istrue(_id_464EB48901113EB0.teamanchoredwidget)) {
    return;
  }
  if(!isDefined(_id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team]))
    _id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team] = [];

  _id_BD73CC979462CAC0 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    _id_BD73CC979462CAC0[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  foreach(instance in _id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team])
  _id_BD73CC979462CAC0[instance.anchoredwidgetid] = undefined;

  foreach(anchoredwidgetid in _id_BD73CC979462CAC0) {
    entity.anchoredwidgetid = anchoredwidgetid;
    break;
  }

  if(isDefined(entity.anchoredwidgetid)) {
    _id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team] = scripts\engine\utility::array_add(_id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team], entity);
    _id_62AAE91E274E22D5 = _id_962A30A9BB8C0F09.teamanchoredentomnvars[entity.anchoredwidgetid];

    foreach(player in scripts\mp\utility\teams::getfriendlyplayers(entity.team))
    player setclientomnvar(_id_62AAE91E274E22D5, entity getentitynumber());
  } else {}
}

plunder_removeanchoredwidgetfromrepositoryinstance(entity) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;
  id = entity.anchoredwidgetid;

  if(!isDefined(id)) {
    return;
  }
  entity.anchoredwidgetid = undefined;
  _id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team] = scripts\engine\utility::array_remove(_id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team], entity);

  if(_id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team].size == 0)
    _id_962A30A9BB8C0F09.teamanchoredwidgetinstances[entity.team] = undefined;

  _id_62AAE91E274E22D5 = _id_962A30A9BB8C0F09.teamanchoredentomnvars[id];
  _id_634E557AA9552052 = _id_962A30A9BB8C0F09.teamanchoredinfoomnvars[id];

  foreach(player in scripts\mp\utility\teams::getfriendlyplayers(entity.team)) {
    player setclientomnvar(_id_62AAE91E274E22D5, -1);
    player setclientomnvar(_id_634E557AA9552052, 0);
  }
}

plunder_updateanchoredwidgetforplayers(entity, players) {
  _id_962A30A9BB8C0F09 = level.plunderrepositories;

  if(!isDefined(entity.anchoredwidgetid)) {
    return;
  }
  if(!isarray(players))
    players = [players];

  if(players.size == 0) {
    return;
  }
  value = 0;
  _id_B5C99E03C0C2DC5C = 0;
  payload = 1;
  _id_AEBF7845CFDDB470 = 1;
  value = value + payload;
  _id_B5C99E03C0C2DC5C = _id_B5C99E03C0C2DC5C + _id_AEBF7845CFDDB470;
  payload = entity.plundercountdownendtime;
  _id_AEBF7845CFDDB470 = 14;

  if(isDefined(payload)) {
    payload = payload / 250;
    payload = int(min(payload, 16383));
    value = value + (payload << _id_B5C99E03C0C2DC5C);
  }

  _id_B5C99E03C0C2DC5C = _id_B5C99E03C0C2DC5C + _id_AEBF7845CFDDB470;
  payload = entity.plundertotal;
  _id_AEBF7845CFDDB470 = 10;

  if(isDefined(payload)) {
    payload = payload / 5;
    payload = int(min(payload, 1023));
    value = value + (payload << _id_B5C99E03C0C2DC5C);
  }

  _id_634E557AA9552052 = _id_962A30A9BB8C0F09.teamanchoredinfoomnvars[entity.anchoredwidgetid];

  foreach(player in players) {
    if(scripts\engine\utility::array_contains(entity.playersusing, player)) {
      player setclientomnvar(_id_634E557AA9552052, value &~1);
      continue;
    }

    player setclientomnvar(_id_634E557AA9552052, value);
  }
}