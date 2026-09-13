/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29458c0b233be34.gsc
***********************************************/

init_quest_util() {
  level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");
  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  scripts\engine\utility::flag_init("tablets_initted");
  scripts\engine\utility::flag_init("tablets_initted_spawned");
  level waittill("player_spawned_with_loadout");
  wait 2;

  if(!getdvarint("dvar_90A3DFD557408611", 1)) {
    return;
  }
  level.questinfo = spawnStruct();
  level.questinfo.quests = [];
  level.questinfo.thinkers = [];
  level.questinfo.tabletinfo = [];
  level.questinfo.teamsonquests = [];
  level.questinfo.thinkindex = 0;
  level.questinfo.tablevalues = [];
  level.questinfo.rewards = spawnStruct();
  level.questinfo.rewards.categorytogroup = [];
  level.questinfo.rewards.grouptorewards = [];
  level.questinfo.rewards.scalertoscaleinfo = [];
  level.questinfo.rewards.rewardtotype = [];
  level.questinfo.rewards.rewardtovalue = [];
  level.questinfo.tiers = [];
  level.questinfo.unlockables = spawnStruct();
  level.questinfo.unlockables.lootidtoindex = [];
  level.questinfo._id_90FAACD5E5307EC0 = spawnStruct();
  _id_191417401F979FB4[0] = "DOMINATION";
  _id_191417401F979FB4[1] = "DOMINATION_SMALL";
  _id_191417401F979FB4[2] = "DOMINATION_LARGE";
  _id_191417401F979FB4[3] = "SEARCH_AND_DESTROY";
  _id_2484093A170DF905 = [];
  _id_2484093A170DF905["ALL"] = 0;

  foreach(_id_B5C99E03C0C2DC5C, str in _id_191417401F979FB4) {
    _id_2484093A170DF905[str] = 1 << _id_B5C99E03C0C2DC5C;
    _id_2484093A170DF905["ALL"] = _id_2484093A170DF905["ALL"] | 1 << _id_B5C99E03C0C2DC5C;
  }

  _id_2484093A170DF905["ALL_DOMINATION"] = _id_2484093A170DF905["DOMINATION"] | _id_2484093A170DF905["DOMINATION_SMALL"] | _id_2484093A170DF905["DOMINATION_LARGE"];
  level.questinfo._id_90FAACD5E5307EC0._id_191417401F979FB4 = _id_191417401F979FB4;
  level.questinfo._id_90FAACD5E5307EC0._id_2484093A170DF905 = _id_2484093A170DF905;
  level.questinfo._id_90FAACD5E5307EC0._id_A001E7B664EAEE73 = 0;
  level.questinfo.defaultfilter = [];
  level.questinfo.defaultfilter[0] = ::filtercondition_isdead;
  level.questinfo.getactiveforteam = ::getallactivequestsforteam;
  loadtables();
  level _id_7ADC95A4FDF40DC2::init();
  level _id_5E283D8830C94B26::init();
  level _id_6D7A5191B485700D::init();
  level _id_4924F90A6F7DC739::init();
  thread inittablets();
  level.brmodevariantrewardcullfunc = undefined;
}

loadtables() {
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_4430D62E25161AA9 = tablelookupbyrow("cp/cpmission_unlockables.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(_id_4430D62E25161AA9) || _id_4430D62E25161AA9 == "") {
      break;
    }

    lootid = int(tablelookup("cp/cpmission_unlockables.csv", 0, _id_4430D62E25161AA9, 1));
    level.questinfo.unlockables.lootidtoindex[lootid] = int(_id_4430D62E25161AA9);
    _id_CB89110314447B2F++;
  }
}

_id_657499D8A97F47D4(_id_B5BD219CF262EEC6, _id_CDAE842FE62ABA20) {
  objindex = scripts\cp\cp_objectives::requestworldid(_id_B5BD219CF262EEC6);
  _id_E429B49263CF416A = _id_47B406752C0A7162(_id_B5BD219CF262EEC6);

  if(objindex != -1) {
    objective_state(objindex, "active");
    objective_position(objindex, _id_CDAE842FE62ABA20);
    objective_icon(objindex, _id_E429B49263CF416A);
    objective_setminimapiconsize(objindex, "icon_regular");
    self.objindex = objindex;
  }
}

_id_ECE50F98E32DCFC2() {
  if(isDefined(self.objindex)) {
    objective_state(self.objindex, "done");
    objective_delete(self.objindex);
    scripts\cp\cp_objectives::freeworldidbyobjid(self.objindex);
  }
}

_id_47B406752C0A7162(drop_type) {
  icon = "ui_mp_br_mapmenu_backing_tablet";

  switch (drop_type) {
    case "brloot_assassination_tablet":
      icon = "ui_mp_br_mapmenu_icon_assassin_tablet";
      break;
    case "brloot_domination_tablet":
      icon = "ui_mp_br_mapmenu_icon_dom_tablet";
      break;
    case "brloot_scavenger_tablet":
      icon = "ui_mp_br_mapmenu_icon_scavengerhunt_tablet";
      break;
    case "brloot_vip_tablet":
      icon = "ui_mp_br_mapmenu_icon_vip_tablet";
      break;
    case "brloot_timedrun_tablet":
      icon = "ui_mp_br_mapmenu_icon_timedrun_tablet";
      break;
    case "brloot_blueprintextract_tablet":
      icon = "ui_mp_br_mapmenu_icon_extraction_tablet";
      break;
    case "brloot_intel_tablet":
      icon = "ui_mp_br_mapmenu_icon_extraction_tablet";
      break;
  }

  return icon;
}

inittablets() {
  level.questinfo.activetablets = [];
  _id_64D2F24DF5D49616 = 0;
  _id_294684D6A0DEEF46 = [];

  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(_id_A1093166DE09E6B8);
    _id_E0D1E3A2B6F5323A = getentitylessscriptablearray(_id_A1093166DE09E6B8);

    if(!info.enabled) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = _id_E0D1E3A2B6F5323A.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      tablet = _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8];
      tablet tabletinit(type);

      if(!tablet.init) {
        _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8].startdisabled = 1;
        _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
        _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
      }
    }

    if(_id_E0D1E3A2B6F5323A.size)
      setobjectivetypesomvarbit(type);

    _id_2C3363605ABB4836 = _id_E0D1E3A2B6F5323A.size * _id_64D2F24DF5D49616;
    _id_5731F7181809474A = int(_id_2C3363605ABB4836);
    _id_C678B652D11243B9 = _id_2C3363605ABB4836 - _id_5731F7181809474A;

    if(randomfloat(1.0) < _id_C678B652D11243B9)
      _id_5731F7181809474A++;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5731F7181809474A; _id_AC0E594AC96AA3A8++) {
      _id_2ADBA961C731BAF6 = randomintrange(0, _id_E0D1E3A2B6F5323A.size);
      tablet = _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6];
      _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6].startdisabled = 1;
      _id_294684D6A0DEEF46[_id_294684D6A0DEEF46.size] = _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6];
      _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
      _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
    }
  }

  _id_6B7736374856505C = [];
  _id_7B18BF75C63CF8BE = getdvarint("dvar_96DB0B0E9378AD40", 1);
  _id_007CA789CBF8098E = 0;

  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(_id_A1093166DE09E6B8);
    _id_E0D1E3A2B6F5323A = getentitylessscriptablearray(_id_A1093166DE09E6B8);
    _id_007CA789CBF8098E = _id_007CA789CBF8098E + _id_E0D1E3A2B6F5323A.size;

    if(info.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A) {
        if(istrue(tablet.startdisabled)) {
          tablet tablethide();
          continue;
        }

        tablet tabletshow();
      }

      continue;
    }

    foreach(tablet in _id_E0D1E3A2B6F5323A)
    tablet tablethide();
  }

  activequests = level.questinfo.activetablets.size;
  _id_9AFE8D8A9AED972A = _id_294684D6A0DEEF46.size;
  thread delayedshowtablets(_id_294684D6A0DEEF46);
  scripts\engine\utility::flag_set("tablets_initted");
  level notify("tablets_initted");
}

setobjectivetypesomvarbit(type) {
  index = getquestindex(type);
  setomnvarbit("ui_br_objective_types", index, 1);
}

delayedshowtablets(_id_294684D6A0DEEF46) {
  if(!isDefined(level.br_level)) {
    return;
  }
  _id_0046599DAB79A549 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_96878DA693689CCD", 4);
  _id_F5F66E7F9CB52C09 = getdvarfloat("dvar_743253D28CD0D1F7", 0.3);
  _id_0495D2ED937E965E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++)
    tablet = _id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
}

disablealltablets() {
  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);
    _id_E0D1E3A2B6F5323A = getentitylessscriptablearray(_id_A1093166DE09E6B8);

    if(info.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A)
      tablet tablethide();
    }
  }
}

_id_DEA5A69FA3301FEA() {
  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);
    _id_E0D1E3A2B6F5323A = getentitylessscriptablearray(_id_A1093166DE09E6B8);

    if(info.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A)
      tablet tabletshow();
    }
  }
}

tablethide() {
  thread _tablethide();
}

_tablethide() {
  self endon("show");
  self setscriptablepartstate(self.type, "hidden");
  _id_ECE50F98E32DCFC2();
}

tabletshow() {
  self notify("show");
  part = self.type;
  self setscriptablepartstate(part, "visible");
  level.questinfo.activetablets["" + self.index] = self;
  _id_657499D8A97F47D4(self.type, self.origin);
}

tabletinit(type) {
  if(isDefined(self.init)) {
    return;
  }
  self.init = 1;
  self.tablettype = type;
  tabletinit = level.questinfo.quests[type].funcs["tabletInit"];

  if(isDefined(tabletinit))
    self.init = self[[tabletinit]]();
}

onquesttablethide(instance) {
  if(isDefined(level.questinfo.activetablets["" + instance.index]))
    level.questinfo.activetablets["" + instance.index] = undefined;
}

getlootname(category) {
  return "brloot_" + category + "_tablet";
}

registerteamonquest(team, player) {
  level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, team);
}

releaseteamonquest(team) {
  level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, team);
  _id_89EDDDE3DA46BC8D = getquestrewardtier(team);
  results = [];

  if(isDefined(self.result) && self.result == "success") {
    foreach(player in scripts\cp\utility::getplayersinteam(team)) {
      if(!isDefined(player.brmissionscompleted))
        player.brmissionscompleted = 0;
      else
        player.brmissionscompleted++;

      if(!isDefined(player.brmissiontypescompleted))
        player.brmissiontypescompleted = [];

      player.brmissiontypescompleted[self.questcategory] = scripts\engine\utility::ter_op(isDefined(player.brmissionscompleted), player.brmissionscompleted + 1, 0);
    }

    results = givequestrewardsinstance(team, self.rewardorigin, self.rewardangles, self.rewardscriptable, self.contributingplayers);
  }

  if(isDefined(self.result)) {
    _id_A4BC9AD7065C48E9 = scripts\engine\utility::ter_op(self.result == "success", 1, 2);
    _id_1BBEB265EF74BC60 = self.category;

    foreach(player in scripts\cp\utility::getplayersinteam(team)) {
      player scripts\cp_mp\challenges::oncontractend(self.category, _id_A4BC9AD7065C48E9, 1);
      player notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self.targetteam)) {
      _id_C0CBB1ECD0D11AFD = scripts\engine\utility::ter_op(self.result == "success", 2, 1);

      foreach(player in scripts\cp\utility::getplayersinteam(team))
      player scripts\cp_mp\challenges::oncontractend(self.category, _id_C0CBB1ECD0D11AFD, 2);
    }
  }

  _id_A6AB8D0FDA441DC2 = scripts\cp\utility::getplayersinteam(team);
  _id_EF08909F6CBF35FC = _id_A6AB8D0FDA441DC2.size;
  self notify("questEnded");

  if(isDefined(self.rewardscriptable))
    self.rewardscriptable notify("questEnded");
}

startteamcontractchallenge(category, _id_A705A5A5884EBF9C, team) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player scripts\cp_mp\challenges::oncontractstart(category, _id_A705A5A5884EBF9C);
}

takequesttablet(instance) {
  switch (instance.type) {
    case "brloot_domination_tablet":
      _id_4924F90A6F7DC739::takequestitem(instance);
      break;
    case "brloot_scavenger_tablet":
      _id_7ADC95A4FDF40DC2::takequestitem(instance);
      break;
    case "brloot_vip_tablet":
      _id_6D7A5191B485700D::takequestitem(instance);
      break;
    case "brloot_intel_tablet":
      _id_5E283D8830C94B26::takequestitem(instance);
      break;
  }
}

createquestinstance(category, _id_FB5FDFAFC29F4513, missionid, rewardscriptable) {
  instance = spawnStruct();
  instance.questcategory = category;
  instance.enabled = 1;
  instance.category = category;
  instance.id = _id_FB5FDFAFC29F4513;
  instance.missionid = "" + missionid;
  instance.rewardscriptable = rewardscriptable;
  instance _assignthinkoffset();
  return instance;
}

addquestinstance(category, _id_02C1F354CFD7716E) {
  if(!istrue(level.questinfo.ismanagerthreadthinking)) {
    _initmanagerquestthread();
    level.questinfo thread _questmanagerthread();
  }

  if(!_isquestthreaded(category) && isDefined(level.questinfo.quests[category].numthinkfuncs)) {
    if(_checkforregister(category, "initQuestVars"))
      level.questinfo.quests[category] _runinitquestvars(category);

    _runaddquestinstance(category, _id_02C1F354CFD7716E);
    _runaddquestthread(category);
  } else
    _runaddquestinstance(category, _id_02C1F354CFD7716E);
}

_id_DEAE0E47B5BDD68D(amount, _id_17E26989B6C2ECC1, _id_58F4C2689A771220) {
  if(isstring(_id_17E26989B6C2ECC1))
    _id_17E26989B6C2ECC1 = [_id_17E26989B6C2ECC1];

  _id_A5B2C541413AA895 = getdvarint("dvar_9925F8AD1812F844", 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_AC0E594AC96AA3A8, self.origin, self.angles);
    _id_61B9F69B3FA78156 = scripts\engine\utility::random(_id_17E26989B6C2ECC1);
    item = _id_66122A002AFF5D57::spawnpickup(_id_61B9F69B3FA78156, _id_06FE80416B4BE165, _id_58F4C2689A771220, 1, undefined, _id_A5B2C541413AA895);
  }
}

_id_20739E471AE0C29B(team, amount) {
  if(!isDefined(amount)) {
    return;
  }
  players = scripts\cp\utility::getplayersinteam(team);

  foreach(player in players)
  player _id_3BCAA2CBAF54ABDD::give_player_currency(amount, "large", undefined, undefined, "cash_pickup");
}

removequestinstance() {
  if(istrue(self.removed)) {
    return;
  }
  self.removed = 1;
  category = self.questcategory;
  _runremovequestinstance(category);

  if(isDefined(self.subscribedlocale))
    leavequestlocale();

  if(_questinstancesactive(category) <= 0) {
    if(_checkforregister(category, "clearQuestVars"))
      level.questinfo.quests[category] _runclearquestvars(category);

    if(_questthreadsactive() <= 0)
      _removemanagerquestthread();
  }
}

_id_7BCB36BCE60B1F7A(instance) {
  level endon("game_ended");

  if(istrue(level._id_2C0C44E689DEA99E)) {
    _id_2A54ADD44D7DDF42 = undefined;

    switch (instance.questcategory) {
      case "domination":
      case "intel":
      case "scavenger":
        _id_2A54ADD44D7DDF42 = undefined;
        break;
      case "assassination":
      case "vip":
        _id_2A54ADD44D7DDF42 = 180;
        break;
    }

    if(isDefined(_id_2A54ADD44D7DDF42)) {
      wait(_id_2A54ADD44D7DDF42);
      instance.tablet tabletshow();
    }
  }
}

isquestinstancealocale(instance) {
  return isDefined(instance.subscribedinstances);
}

_initmanagerquestthread() {
  level.questinfo.ismanagerthreadthinking = 1;
}

_removemanagerquestthread() {
  level notify("end_quest_manager_thread");
  level.questinfo.ismanagerthreadthinking = 0;
}

_questmanagerthread() {
  level endon("game_ended");
  level endon("end_quest_manager_thread");

  for(;;) {
    wait 0.05;
    level.questinfo.thinkindex++;

    foreach(_id_29B3D4262D4B443C in level.questinfo.thinkers) {
      if(!level.questinfo.quests[_id_29B3D4262D4B443C].enabled) {
        continue;
      }
      foreach(instance in level.questinfo.quests[_id_29B3D4262D4B443C].instances) {
        if(instance.enabled)
          instance _runquestthinkfunctions(_id_29B3D4262D4B443C);
      }
    }
  }
}

_runquestthinkfunctions(_id_29B3D4262D4B443C) {
  for(index = 0; index < level.questinfo.quests[_id_29B3D4262D4B443C].numthinkfuncs; index++) {
    if((level.questinfo.thinkindex - (self.thinkoffset + self.firstthink)) % level.questinfo.quests[_id_29B3D4262D4B443C].thinkrates[index] == 0) {
      _id_6B9F4C30D54F0F83 = "questThink" + index;
      [[level.questinfo.quests[_id_29B3D4262D4B443C].funcs[_id_6B9F4C30D54F0F83]]]();
    }
  }
}

_assignthinkoffset() {
  if(!isDefined(level.questinfo.thinkoffset))
    level.questinfo.thinkoffset = 0;

  self.thinkoffset = level.questinfo.thinkoffset;
  self.firstthink = level.questinfo.thinkindex;
  level.questinfo.thinkoffset++;
}

_registerquestfunc(category, func, _id_6B9F4C30D54F0F83) {
  level.questinfo.quests[category].funcs[_id_6B9F4C30D54F0F83] = func;
}

_checkforregister(category, _id_6B9F4C30D54F0F83) {
  return isDefined(level.questinfo.quests[category].funcs[_id_6B9F4C30D54F0F83]);
}

registerquestcategory(category, _id_4C43A06A2D630DFD) {
  enabled = getdvarint(_func_2EF675C13CA1C4AF("dvar_71622BBA3F9292F4", category, "_quest"), _id_4C43A06A2D630DFD);
  info = spawnStruct();
  info.enabled = enabled;
  level.questinfo.tabletinfo[category] = info;

  if(!enabled)
    return 0;

  _registerquestcategory(category);
  return 1;
}

registerquestlocale(category) {
  _registerquestcategory(category);
}

_registerquestcategory(category) {
  if(!isDefined(level.questinfo.quests[category])) {
    level.questinfo.quests[category] = spawnStruct();
    level.questinfo.quests[category].initflag = 0;
    level.questinfo.quests[category].hasinitfunc = 0;
    level.questinfo.quests[category].funcs = [];
    level.questinfo.quests[category].instances = [];
    level.questinfo.quests[category].enabled = 1;
    registerquestcategorytablevalues(category);
  }
}

registerquestcategorytablevalues(category) {
  level.questinfo.tablevalues[category] = spawnStruct();
  level.questinfo.tablevalues[category].index = getquesttableindex(category);
}

registerquestcircletick(category, func) {
  _registerquestfunc(category, func, "circleTick");
}

registerremovequestinstance(category, func) {
  _registerquestfunc(category, func, "removeInstance");
}

registerclearquestvars(category, func) {
  _registerquestfunc(category, func, "clearQuestVars");
}

registerplayerfilter(category, _id_9E41235AC60933D8, _id_ABCD53565564FC79) {
  if(!isDefined(level.questinfo.quests[category].filters))
    level.questinfo.quests[category].filters = [];

  if(isDefined(_id_ABCD53565564FC79))
    level.questinfo.quests[category].filters[_id_ABCD53565564FC79] = _id_9E41235AC60933D8;
  else {
    count = level.questinfo.quests[category].filters.size;
    level.questinfo.quests[category].filters[count] = _id_9E41235AC60933D8;
  }
}

registeronplayerkilled(category, func) {
  _registerquestfunc(category, func, "onPlayerKilled");
}

registeronplayerdisconnect(category, func) {
  _registerquestfunc(category, func, "onPlayerDisconnect");
}

registeronentergulag(category, func) {
  _registerquestfunc(category, func, "onEnterGulag");
}

registeronrespawn(category, func) {
  _registerquestfunc(category, func, "onRespawn");
}

registerontimerupdate(category, func) {
  _registerquestfunc(category, func, "onTimerUpdate");
}

registerontimerexpired(category, func) {
  _registerquestfunc(category, func, "onTimerExpired");
}

registertabletinit(category, func) {
  _registerquestfunc(category, func, "tabletInit");
}

_runinitquestvars(category) {
  [[level.questinfo.quests[category].funcs["initQuestVars"]]]();
}

_runaddquestthread(category) {
  if(!_isquestthreaded(category)) {
    count = level.questinfo.thinkers.size;
    level.questinfo.thinkers[count] = category;
    level.questinfo.quests[category].enabled = 1;
  } else {}
}

_runaddquestinstance(category, _id_02C1F354CFD7716E) {
  level.questinfo.quests[category].instances[_id_02C1F354CFD7716E.id] = _id_02C1F354CFD7716E;
}

_runremovequestinstance(category) {
  self[[level.questinfo.quests[category].funcs["removeInstance"]]]();
  self notify("removed");
  level.questinfo.quests[category].instances[self.id] = undefined;
}

_runclearquestvars(category) {
  [[level.questinfo.quests[category].funcs["clearQuestVars"]]]();
  level.questinfo.thinkers = scripts\engine\utility::array_remove(level.questinfo.thinkers, category);
  level.questinfo.quests[category].enabled = 0;
}

_isquestthreaded(category) {
  if(scripts\engine\utility::array_contains(level.questinfo.thinkers, category))
    return 1;

  return 0;
}

_questinstancesactive(category) {
  if(isDefined(level.questinfo.quests[category].instances))
    return level.questinfo.quests[category].instances.size;

  return 0;
}

_questthreadsactive() {
  if(isDefined(level.questinfo.thinkers))
    return level.questinfo.thinkers.size;

  return 0;
}

createlocaleinstance(category, _id_58CF9831F1C92E24, _id_FB5FDFAFC29F4513) {
  locale = createquestinstance(category, _id_FB5FDFAFC29F4513, "invalid");
  locale.subscriber_type = _id_58CF9831F1C92E24;
  getquestdata(_id_58CF9831F1C92E24).locale_type = category;
  locale.subscribedinstances = [];
  return locale;
}

registercreatequestlocale(category, func) {
  _registerquestfunc(category, func, "create_locale");
}

registermovequestlocale(category, func) {
  _registerquestfunc(category, func, "move_locale");
}

registercheckiflocaleisavailable(category, func) {
  _registerquestfunc(category, func, "check_available");
}

_determinelocationarray(_id_354D1457278B342C) {
  switch (_id_354D1457278B342C.searchfunc) {
    case "GetEntitylessScriptableArray":
      return getentitylessscriptablearray(_id_354D1457278B342C.itemname, "classname", _id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax);
    case "getUnusedLootCacheArray":
      _id_6206D739138B8BE8 = _id_2635862DF634011A();
      return _id_6206D739138B8BE8;
    case "getUnusedLootCacheArrayRegion":
      _id_6206D739138B8BE8 = _id_3B8C875BF5039B17(_id_354D1457278B342C);
      return _id_6206D739138B8BE8;
    case "questPointsArray":
      return getquestpoints(_id_354D1457278B342C.questtypes, _id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax, 0, 1);
    case "questDomPointsArray":
      _id_0C8265398A13EC22 = _id_1B7365E36333389E(_id_354D1457278B342C);
      return _id_0C8265398A13EC22;
    default:
  }
}

_id_2635862DF634011A() {
  if(isDefined(level._id_0168BB07D29F44CB))
    return level._id_0168BB07D29F44CB;

  _id_22D4D19EDABDD9C5 = scripts\engine\utility::getStructArray("incursion_loot_point", "script_noteworthy");
  _id_97E811638CF0585D = [];
  _id_AC0E594AC96AA3A8 = 0;

  foreach(point in _id_22D4D19EDABDD9C5) {
    if(!isDefined(point.angles))
      point.angles = (0, 0, 0);

    point.index = _id_AC0E594AC96AA3A8;
    _id_AC0E594AC96AA3A8++;
    point.spawnflags = 0;

    if(!istrue(point.disabled)) {
      point.disabled = 0;
      _id_97E811638CF0585D[_id_97E811638CF0585D.size] = point;
    }
  }

  level._id_0168BB07D29F44CB = _id_97E811638CF0585D;
  return level._id_0168BB07D29F44CB;
}

_id_3B8C875BF5039B17(_id_354D1457278B342C) {
  _id_22D4D19EDABDD9C5 = scripts\engine\utility::getStructArray("incursion_loot_point", "script_noteworthy");
  _id_97E811638CF0585D = [];
  _id_40B53E86B632009C = squared(_id_354D1457278B342C.searchradiusidealmax);
  _id_AC0E594AC96AA3A8 = 0;

  foreach(point in _id_22D4D19EDABDD9C5) {
    if(!isDefined(point.angles))
      point.angles = (0, 0, 0);

    point.index = _id_AC0E594AC96AA3A8;
    _id_AC0E594AC96AA3A8++;
    point.spawnflags = 0;

    if(!istrue(point.disabled)) {
      if(distance2dsquared(point.origin, _id_354D1457278B342C.searchcircleorigin) <= _id_40B53E86B632009C) {
        point.disabled = 0;
        _id_97E811638CF0585D[_id_97E811638CF0585D.size] = point;
      }
    }
  }

  level._id_0168BB07D29F44CB = _id_97E811638CF0585D;
  return level._id_0168BB07D29F44CB;
}

_id_645F05D6B8A3A257(index) {
  if(!isDefined(level._id_0168BB07D29F44CB)) {
    return;
  }
  foreach(point in level._id_0168BB07D29F44CB) {
    if(point.index == index) {
      point.disabled = 1;
      scripts\engine\utility::array_remove(level._id_0168BB07D29F44CB, point);
      return;
    }
  }
}

_id_1B7365E36333389E(_id_354D1457278B342C) {
  _id_BDE3EF37A7EC8B1B = scripts\engine\utility::getStructArray("incursion_dom_point", "script_noteworthy");
  _id_10E42241ECBD95EA = [];
  _id_40B53E86B632009C = squared(_id_354D1457278B342C.searchradiusidealmax);

  foreach(point in _id_BDE3EF37A7EC8B1B) {
    if(distance2dsquared(point.origin, _id_354D1457278B342C.searchcircleorigin) <= _id_40B53E86B632009C) {
      point.disabled = 0;
      point.spawnflags = 1;
      _id_10E42241ECBD95EA[_id_10E42241ECBD95EA.size] = point;
    }
  }

  level._id_58DEE113A2C65CB6 = _id_10E42241ECBD95EA;
  return _id_10E42241ECBD95EA;
}

_findnewlocaleplacement(_id_2AAB8569152EDFAC, _id_354D1457278B342C) {
  _id_2AAB8569152EDFAC = scripts\engine\utility::array_randomize(_id_2AAB8569152EDFAC);

  if(!isDefined(_id_354D1457278B342C.mintime))
    _id_354D1457278B342C.mintime = 0;

  if(!isDefined(_id_354D1457278B342C.travelspeed))
    _id_354D1457278B342C.travelspeed = 190;

  _id_EC522787BBCAAB24 = isDefined(_id_354D1457278B342C.searchradiusidealmax) && isDefined(_id_354D1457278B342C.searchradiusidealmin);
  _id_F55F0723DFA08B99 = 0;
  debug = spawnStruct();
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = _id_354D1457278B342C.searchradiusmax;

  foreach(_id_AC0E594AC96AA3A8, loc in _id_2AAB8569152EDFAC) {
    dist = distance2d(loc.origin, _id_354D1457278B342C.searchcircleorigin);

    if(dist < _id_354D1457278B342C.searchradiusmin) {
      continue;
    }
    if(_id_EC522787BBCAAB24) {
      if(dist < _id_354D1457278B342C.searchradiusidealmax) {
        if(dist >= _id_354D1457278B342C.searchradiusidealmin)
          _id_5435995E95681B89 = 0;
        else
          _id_5435995E95681B89 = _id_354D1457278B342C.searchradiusidealmin - dist;
      } else
        _id_5435995E95681B89 = dist - _id_354D1457278B342C.searchradiusidealmax;

      if(_id_5435995E95681B89 < _id_BE0F4D48FA40793F) {
        _id_BE0F4D48FA40793F = _id_5435995E95681B89;
        _id_02ED718E1DA0B965 = _id_AC0E594AC96AA3A8;

        if(_id_5435995E95681B89 <= 0) {
          break;
        }
      }

      continue;
    }

    _id_02ED718E1DA0B965 = _id_AC0E594AC96AA3A8;
  }

  _id_B70EF58C802ABDDF = undefined;

  if(isDefined(_id_02ED718E1DA0B965))
    _id_B70EF58C802ABDDF = _id_2AAB8569152EDFAC[_id_02ED718E1DA0B965];
  else {}

  return _id_B70EF58C802ABDDF;
}

_id_F42FBF313EBAEC27(_id_2AAB8569152EDFAC, _id_02ED718E1DA0B965, _id_354D1457278B342C, _id_90FAACD5E5307EC0) {
  dvar = "dvar_B88AF237972348E6";
  _id_3F70BD89393F0882 = 0;

  if(!getdvarint(dvar, _id_3F70BD89393F0882)) {
    return;
  }
  _id_00A3DB3D7F49E8C9(dvar, _id_3F70BD89393F0882, _id_2AAB8569152EDFAC, _id_02ED718E1DA0B965, _id_354D1457278B342C, _id_90FAACD5E5307EC0);
}

_id_3C30C102BA44EC57(_id_2AAB8569152EDFAC, _id_02ED718E1DA0B965, _id_354D1457278B342C, _id_90FAACD5E5307EC0, _id_3D99DD8FB4AB7D8F) {
  dvar = "dvar_B4CB045FDE16721F";
  _id_3F70BD89393F0882 = -2;
  _id_3DF45BD0D60106A4 = -1;
  _id_3D99DD8FB4AB7D8F = level.questinfo._id_90FAACD5E5307EC0._id_A001E7B664EAEE73;
  level.questinfo._id_90FAACD5E5307EC0._id_A001E7B664EAEE73++;

  for(;;) {
    for(;;) {
      _id_6686D1519FD59C8D = getdvarint(dvar, _id_3F70BD89393F0882);

      if(_id_6686D1519FD59C8D == _id_3DF45BD0D60106A4) {
        waitframe();
        continue;
      }

      if(_id_6686D1519FD59C8D == _id_3D99DD8FB4AB7D8F) {
        break;
      }

      wait 0.2;
    }

    _id_00A3DB3D7F49E8C9(dvar, _id_3D99DD8FB4AB7D8F, _id_2AAB8569152EDFAC, _id_02ED718E1DA0B965, _id_354D1457278B342C, _id_90FAACD5E5307EC0);
  }
}

_id_00A3DB3D7F49E8C9(dvar, _id_6686D1519FD59C8D, _id_2AAB8569152EDFAC, _id_02ED718E1DA0B965, _id_354D1457278B342C, _id_90FAACD5E5307EC0) {
  if(!isDefined(_id_90FAACD5E5307EC0.dist))
    _id_90FAACD5E5307EC0.dist = [];

  if(!isDefined(_id_90FAACD5E5307EC0._id_975B4BE3F9205374))
    _id_90FAACD5E5307EC0._id_975B4BE3F9205374 = [];

  if(!isDefined(_id_90FAACD5E5307EC0._id_42F65B4B53C1F5D4))
    _id_90FAACD5E5307EC0._id_42F65B4B53C1F5D4 = [];

  if(!isDefined(_id_90FAACD5E5307EC0._id_9F896722B457F938))
    _id_90FAACD5E5307EC0._id_9F896722B457F938 = [];

  level notify("findLocaleOriginPlacedDebug");
  level endon("findLocaleOriginPlacedDebug");
  _id_CBA41E031462F3D0 = (1, 0, 0);
  _id_AC1BD900D1AABE1D = (1, 1, 0);
  _id_CAAE05637AC7AE10 = (0, 1, 0);
  _id_06CF05C5255E7157 = (0.5, 1, 0.5);
  _id_D6348C41222908A1 = (0, 0, 1);
  _id_5E7F14654E78AF92 = (1, 1, 1);
  _id_7B830592BC29FEB8 = (0, 0, 15);

  while(getdvarint(dvar) == _id_6686D1519FD59C8D) {
    if(!isDefined(_id_02ED718E1DA0B965)) {}

    scripts\engine\utility::draw_circle(_id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmin, _id_CAAE05637AC7AE10, 1, 0, 0);
    scripts\engine\utility::draw_circle(_id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax, _id_CBA41E031462F3D0, 1, 0, 0);

    if(isDefined(_id_354D1457278B342C.searchradiusidealmin))
      scripts\engine\utility::draw_circle(_id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusidealmin, _id_AC1BD900D1AABE1D, 1, 0, 0);

    if(isDefined(_id_354D1457278B342C.searchradiusidealmax))
      scripts\engine\utility::draw_circle(_id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusidealmax, _id_AC1BD900D1AABE1D, 1, 0, 0);

    foreach(_id_AC0E594AC96AA3A8, loc in _id_2AAB8569152EDFAC) {
      _id_0A38ECF8A40FD912 = isDefined(_id_90FAACD5E5307EC0.dist[_id_AC0E594AC96AA3A8]);

      if(isDefined(_id_02ED718E1DA0B965) && _id_AC0E594AC96AA3A8 == _id_02ED718E1DA0B965) {
        color = _id_CAAE05637AC7AE10;
        _id_A61C75B156FC1EE0 = 50;
      } else if(_id_0A38ECF8A40FD912) {
        color = _id_D6348C41222908A1;
        _id_A61C75B156FC1EE0 = 20;
      } else {
        color = _id_5E7F14654E78AF92;
        _id_A61C75B156FC1EE0 = 10;
      }

      if(_id_0A38ECF8A40FD912) {
        dist = _id_90FAACD5E5307EC0.dist[_id_AC0E594AC96AA3A8];

        if(dist <= _id_354D1457278B342C.searchradiusmin) {
          color = _id_CBA41E031462F3D0;
          _id_616E15980F379EC4 = _id_CBA41E031462F3D0;
        } else {
          color = _id_CAAE05637AC7AE10;
          _id_616E15980F379EC4 = _id_CAAE05637AC7AE10;
        }

        if(istrue(_id_90FAACD5E5307EC0._id_9F896722B457F938[_id_AC0E594AC96AA3A8]))
          _id_616E15980F379EC4 = _id_AC1BD900D1AABE1D;

        _id_730F0CB692C45946 = loc.origin;
        _id_730F0CB692C45946 = _id_730F0CB692C45946 + _id_7B830592BC29FEB8;
        _id_975B4BE3F9205374 = _id_90FAACD5E5307EC0._id_975B4BE3F9205374[_id_AC0E594AC96AA3A8];

        if(isDefined(_id_975B4BE3F9205374)) {
          str = "circleTime: " + _id_975B4BE3F9205374;
          _id_42F65B4B53C1F5D4 = _id_90FAACD5E5307EC0._id_42F65B4B53C1F5D4[_id_AC0E594AC96AA3A8];

          if(!isDefined(_id_42F65B4B53C1F5D4))
            _id_42F65B4B53C1F5D4 = 0.0;

          str = "" + _id_975B4BE3F9205374 + " - " + _id_42F65B4B53C1F5D4;

          if(_id_975B4BE3F9205374 - _id_42F65B4B53C1F5D4 < _id_354D1457278B342C.mintime) {
            color = _id_CBA41E031462F3D0;
            str = str + " < ";
          } else {
            color = _id_CAAE05637AC7AE10;
            str = str + " >= ";
          }

          str = str + _id_354D1457278B342C.mintime;
        }
      }
    }

    waitframe();
  }
}

_runcreatequestlocale(category, params) {
  if(isDefined(params))
    locale = self[[level.questinfo.quests[category].funcs["create_locale"]]](params);
  else
    locale = self[[level.questinfo.quests[category].funcs["create_locale"]]]();

  return locale;
}

_runmovequestlocale(category, params) {
  if(isDefined(params))
    self[[level.questinfo.quests[category].funcs["move_locale"]]](params);
  else
    self[[level.questinfo.quests[category].funcs["move_locale"]]]();
}

_runcheckiflocaleisavailable(category) {
  return self[[level.questinfo.quests[category].funcs["check_available"]]]();
}

_findexisitingquestlocale(category, _id_354D1457278B342C) {
  _id_935C70547A6790A9 = getquestdata(category);

  if(!isDefined(_id_935C70547A6790A9) || !isDefined(_id_935C70547A6790A9.instances))
    return undefined;

  foreach(instance in _id_935C70547A6790A9.instances) {
    dist = distance2d(_id_354D1457278B342C.searchcircleorigin, instance.curorigin);

    if(dist > _id_354D1457278B342C.searchradiusmax) {
      continue;
    }
    if(!instance _runcheckiflocaleisavailable(category)) {
      continue;
    }
    return instance;
  }

  return undefined;
}

findquestplacement(category, _id_354D1457278B342C) {
  if(isDefined(_id_354D1457278B342C.reservedplacement))
    placement = _id_354D1457278B342C.reservedplacement;
  else {
    _id_2AAB8569152EDFAC = _determinelocationarray(_id_354D1457278B342C);
    placement = _findnewlocaleplacement(_id_2AAB8569152EDFAC, _id_354D1457278B342C);
  }

  return placement;
}

requestquestlocale(category, _id_354D1457278B342C, _id_50803249D3868E7A) {
  locale = undefined;

  if(!isDefined(_id_50803249D3868E7A) || !_id_50803249D3868E7A)
    locale = _findexisitingquestlocale(category, _id_354D1457278B342C);

  if(!isDefined(locale)) {
    placement = findquestplacement(category, _id_354D1457278B342C);
    locale = _runcreatequestlocale(category, placement);
  }

  subscribetoquestlocale(locale);
  return locale;
}

subscribetoquestlocale(locale) {
  self.subscribedlocale = locale;
  locale.subscribedinstances = scripts\engine\utility::array_add(locale.subscribedinstances, self);
}

movequestlocale(category, _id_354D1457278B342C) {
  placement = findquestplacement(category, _id_354D1457278B342C);
  _runmovequestlocale(category, placement);
}

leavequestlocale() {
  _id_7011F22FD8734B8B = getquestdata(self.questcategory).locale_type;
  locale = self.subscribedlocale;
  locale.subscribedinstances = scripts\engine\utility::array_remove(locale.subscribedinstances, self);

  if(locale.subscribedinstances.size <= 0)
    locale removequestinstance();
}

getquestdata(category) {
  return level.questinfo.quests[category];
}

getquestinstancedata(category, _id_56150F88EEFB0135) {
  return level.questinfo.quests[category].instances[_id_56150F88EEFB0135];
}

getquestinstancedatasafe(category, _id_56150F88EEFB0135) {
  instance = undefined;

  if(isDefined(level.questinfo) && isDefined(level.questinfo.quests[category]))
    instance = level.questinfo.quests[category].instances[_id_56150F88EEFB0135];

  return instance;
}

checkforinstance(category, _id_FB5FDFAFC29F4513) {
  if(isDefined(level.questinfo.quests[category].instances[_id_FB5FDFAFC29F4513]))
    return 1;

  return 0;
}

_validateplayerfilter(_id_1F4E8B926C213A9A) {
  if(isDefined(_id_1F4E8B926C213A9A)) {
    if(isint(_id_1F4E8B926C213A9A))
      return level.questinfo.quests[self.questcategory].filters[_id_1F4E8B926C213A9A];

    if(isarray(_id_1F4E8B926C213A9A))
      return _id_1F4E8B926C213A9A;
  } else if(isDefined(level.questinfo.quests[self.questcategory].filters))
    return level.questinfo.quests[self.questcategory].filters[0];
  else
    return level.questinfo.defaultfilter;
}

_validateplayer(player, _id_18176E8F61BB2E83) {
  foreach(_id_46260B6EEE9C6E62 in _id_18176E8F61BB2E83) {
    if(![[_id_46260B6EEE9C6E62]](player))
      return 0;
  }

  return 1;
}

isplayervalid(player, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);
  return _validateplayer(player, _id_18176E8F61BB2E83);
}

isteamvalid(team, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);

  foreach(player in scripts\cp\utility::getplayersinteam(team)) {
    if(_validateplayer(player, _id_18176E8F61BB2E83))
      return 1;
  }

  return 0;
}

sortvalidplayersinarray(group, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);
  players = [];
  players["valid"] = [];
  players["invalid"] = [];

  foreach(player in group) {
    if(_validateplayer(player, _id_18176E8F61BB2E83)) {
      players["valid"][players["valid"].size] = player;
      continue;
    }

    players["invalid"][players["invalid"].size] = player;
  }

  return players;
}

filtercondition_isdead(player) {
  if(!isalive(player))
    return 0;

  return 1;
}

filtercondition_isdowned(player) {
  if(istrue(player.inlaststand))
    return 0;

  return 1;
}

_id_2DAB18ED103A9C6A(maxcount) {
  foreach(player in level.players)
  player setclientomnvar("ui_br_objective_param_max_override", maxcount);
}

_id_91BEF971C660791F() {
  foreach(player in level.players)
  player setclientomnvar("ui_br_objective_param_max_override", 0);
}

packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2, unlockableindex) {
  if(!isDefined(_id_11D65784F0B6AFA2))
    _id_11D65784F0B6AFA2 = 0;

  if(!isDefined(unlockableindex))
    unlockableindex = 0;

  value = unlockableindex;
  value = value << 6 | _id_11D65784F0B6AFA2;
  value = value << 5 | rewardtier;
  value = value << 5 | missionid;
  return value;
}

displayteamsplash(team, _id_E9AE765E2C4FE816, params) {
  players = scripts\cp\utility::getplayersinteam(team);
  displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params);
}

displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params) {
  foreach(player in players) {
    if(isDefined(params)) {
      if(isDefined(params.excludedplayers)) {
        if(scripts\engine\utility::array_contains(params.excludedplayers, player))
          continue;
      }
    }

    displayplayersplash(player, _id_E9AE765E2C4FE816, params);
  }
}

displayplayersplash(player, _id_E9AE765E2C4FE816, params) {
  if(isDefined(params) && isDefined(params.packedbits))
    player thread scripts\cp\cp_hud_message::showsplash(_id_E9AE765E2C4FE816, params.packedbits);
  else if(isDefined(params) && isDefined(params.intvar))
    player thread scripts\cp\cp_hud_message::showsplash(_id_E9AE765E2C4FE816, params.intvar);
  else
    player thread scripts\cp\cp_hud_message::showsplash(_id_E9AE765E2C4FE816);
}

displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid) {
  player = _id_939B8E8818BFD5AE getentitynumber();

  if(!isDefined(state))
    state = 0;

  if(!isDefined(player))
    player = 0;

  if(!isDefined(missionid))
    missionid = 0;

  value = 0;
  value = missionid << 12 | player << 4 | state;
}

displaysquadmessagetoteam(team, _id_939B8E8818BFD5AE, state, missionid) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid);
}

calldropbag(player, location) {}

giveteamplunderflat(team, amount) {
  _id_8E3C5F90E4F80A58 = getdvarfloat("dvar_7165DAD703502609", 0.4);
  _id_2CEFA8F8A2BA6BFE = 0;

  foreach(player in scripts\cp\utility::getplayersinteam(team)) {
    _id_36773A58EB035BFF = amount;

    if(!isalive(player))
      _id_36773A58EB035BFF = int(amount * _id_8E3C5F90E4F80A58);

    level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_36773A58EB035BFF;
  }
}

giveteamplunderdistributive(players, amount) {
  _id_6EEBCDA719CD18A1 = int(amount / players.size);

  foreach(player in players)
  level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_6EEBCDA719CD18A1;
}

getquestindex(ref) {
  return level.questinfo.tablevalues[ref].index;
}

getquesttableindex(ref) {
  index = int(tablelookup("cp/incursion_missions.csv", 1, ref, 0));
  return index;
}

uiobjectiveshow(ref) {
  index = getquestindex(ref);
  setquestindexomnvar(index);
}

uiobjectiveshowtoteam(ref, team) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player uiobjectiveshow(ref);

  if(scripts\cp\utility::getplayersinteam(team).size <= 0)
    return;
}

uiobjectivehide() {
  setquestindexomnvar(0);
}

uiobjectivehidefromteam(team) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player uiobjectivehide();
}

uiobjectivesetparameter(value) {
  self setclientomnvar("ui_br_objective_param", value);
}

uiobjectivesetlootid(value) {
  self setclientomnvar("ui_br_objective_loot_id", value);
}

createquestobjicon(_id_CB8E582431CF1641, state, _id_38116998DF9814D4) {
  self.objectiveiconid = scripts\cp\cp_objectives::requestworldid(self.missionid);

  if(self.objectiveiconid != -1) {
    objective_state(self.objectiveiconid, state);
    objective_position(self.objectiveiconid, (0, 0, 0));
    objective_icon(self.objectiveiconid, _id_CB8E582431CF1641);
    objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    objective_setplayintro(self.objectiveiconid, 1);

    if(isDefined(_id_38116998DF9814D4))
      movequestobjicon(_id_38116998DF9814D4);
  } else {}
}

movequestobjicon(_id_A9706ADAF7C52E27) {
  objective_position(self.objectiveiconid, _id_A9706ADAF7C52E27);
}

showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

showquestobjicontoall(objid) {
  objective_addalltomask(objid);
}

hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

checkforactiveobjicon() {
  return isDefined(self.objectiveiconid);
}

deletequestobjicon() {
  if(self.objectiveiconid == -1) {
    return;
  }
  scripts\cp\cp_objectives::freeworldidbyobjid(self.objectiveiconid);
}

createuseobject(ownerteam, trigger, visuals, offset, _id_3C2389BA69E5822B, _id_08B9949739F4E0F6, showoncompass) {
  if(istrue(trigger.isuseobject))
    useobject = trigger;
  else
    useobject = spawnStruct();

  useobject.type = "useObject";
  useobject.curorigin = trigger.origin;
  useobject.ownerteam = ownerteam;
  useobject.entnum = trigger getentitynumber();
  useobject.keyobject = undefined;

  if(issubstr(trigger.classname, "use") || istrue(trigger.usetype))
    useobject.triggertype = "use";
  else
    useobject.triggertype = "proximity";

  trigger.gameobject = useobject;
  useobject.trigger = trigger;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  useobject.offset3d = offset;
  useobject.compassicons = [];

  if(!istrue(_id_08B9949739F4E0F6))
    useobject requestid(1, 1, _id_3C2389BA69E5822B, showoncompass);

  useobject.interactteam = "any";
  useobject.visibleteam = "any";
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.curprogress = 0;
  useobject.majoritycapprogress = 0;
  useobject.wasmajoritycapprogress = 0;
  useobject.stalemate = 0;
  useobject.wasstalemate = 0;
  useobject.exclusiveuse = 1;
  useobject.teamprogress = [];
  useobject.teamprogress["none"] = 0;

  if(useobject.triggertype == "proximity") {
    useobject.teamusetimes = [];
    useobject.teamusetexts = [];
    useobject.numtouching["neutral"] = 0;
    useobject.touchlist["neutral"] = [];
    useobject.numtouching["none"] = 0;
    useobject.touchlist["none"] = [];

    foreach(name in level.teamnamelist) {
      useobject.teamprogress[name] = 0;
      useobject.numtouching[name] = 0;
      useobject.touchlist[name] = [];
      useobject.assisttouchlist[name] = [];
    }

    useobject.userate = 0;
    useobject.useratemultiplier = 1.0;
    useobject.claimteam = "none";
    useobject.claimplayer = undefined;
    useobject.lastclaimteam = "none";
    useobject.lastclaimtime = 0;
    useobject.mustmaintainclaim = 0;
    useobject.cancontestclaim = 0;
    useobject thread useobjectproxthink();
  } else {
    foreach(team in level.teamnamelist)
    useobject.teamprogress[team] = 0;

    useobject.userate = 1;
    useobject.useratemultiplier = 1.0;
    useobject thread useobjectusethink();
  }

  return useobject;
}

getcapturebehavior() {
  if(!isDefined(self.capturebehavior))
    setcapturebehavior("normal");

  return self.capturebehavior;
}

setcapturebehavior(type) {
  self.capturebehavior = type;
}

setclaimteam(_id_EB06B338608EF354) {
  if(getcapturebehavior() == "normal") {
    if(!isDefined(self.claimgracetime))
      self.claimgracetime = 1000;

    if(!istrue(self.ignorestomp) && scripts\cp\utility::isgameplayteam(_id_EB06B338608EF354)) {
      if(self.lastclaimteam != "none") {
        if(!isDefined(self.lastprogressteam))
          self.lastprogressteam = self.lastclaimteam;
      }
    }
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = _id_EB06B338608EF354;
  updateuserate();
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  starttime = gettime();
  level waittill("host_migration_end");
  return gettime() - starttime;
}

setobjectivestatusicons(friendlyicon, _id_30F120A1EFC1DCBE, objid, ownerteam, _id_3B41B9A0EA9AF087) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }
  if(!isDefined(friendlyicon))
    friendlyicon = _id_30F120A1EFC1DCBE;

  if(!isDefined(_id_30F120A1EFC1DCBE))
    _id_30F120A1EFC1DCBE = friendlyicon;

  if(!isDefined(self.iconname))
    self.iconname = "";

  self.compassicons["friendly"] = friendlyicon + self.iconname;
  self.compassicons["enemy"] = _id_30F120A1EFC1DCBE + self.iconname;
}

isteamtouching() {
  _id_687E3456E754E3E1 = "none";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(self.numtouching[_id_F90358454413407F]) {
      _id_687E3456E754E3E1 = _id_F90358454413407F;
      break;
    }
  }

  return _id_687E3456E754E3E1 != "none";
}

getnumtouchingforteam(team) {
  return self.numtouching[team];
}

updateuserate() {
  if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any")
    team = self.ownerteam;
  else
    team = self.claimteam;

  _id_672A08AAEFB8DE3B = self.numtouching[team];
  _id_65218754A3CA92DB = 0;
  _id_CC0DA48E9A204A66 = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(team != _id_FABF84450735DD93)
      _id_65218754A3CA92DB = _id_65218754A3CA92DB + self.numtouching[_id_FABF84450735DD93];
  }

  foreach(struct in self.touchlist[team]) {
    if(!isDefined(struct.player)) {
      continue;
    }
    if(struct.player.pers["team"] != team) {
      continue;
    }
    if(struct.player.objectivescaler == 1) {
      continue;
    }
    _id_672A08AAEFB8DE3B = _id_672A08AAEFB8DE3B * struct.player.objectivescaler;
    _id_CC0DA48E9A204A66 = struct.player.objectivescaler;
  }

  self.stalemate = scripts\engine\utility::ter_op(istrue(self.alwaysstalemate), _id_672A08AAEFB8DE3B && _id_65218754A3CA92DB, _id_672A08AAEFB8DE3B && _id_65218754A3CA92DB && _id_672A08AAEFB8DE3B == _id_65218754A3CA92DB);

  if(!_id_672A08AAEFB8DE3B && !_id_65218754A3CA92DB)
    self.majoritycapprogress = 0;

  self.userate = 0;

  if(_id_672A08AAEFB8DE3B) {
    if(_id_672A08AAEFB8DE3B > _id_65218754A3CA92DB) {
      self.userate = min(_id_672A08AAEFB8DE3B - _id_65218754A3CA92DB, scripts\engine\utility::ter_op(isDefined(level.objectivescaler), level.objectivescaler, 4));

      if(self.userate > 1.0)
        self.userate = self.userate * self.useratemultiplier;
    }
  }

  if(isDefined(self.isarena) && self.isarena && _id_CC0DA48E9A204A66 != 0)
    self.userate = 1 * _id_CC0DA48E9A204A66;
  else if(isDefined(self.isarena) && self.isarena)
    self.userate = 1;
}

useobjectproxthink() {
  level endon("game_ended");
  self endon("deleted");
  thread proxtriggerthink();

  if(!isDefined(self.ignorestomp))
    self.ignorestomp = 0;

  for(;;) {
    if(self.interactteam == "none") {
      waitframe();
      waittillhostmigrationdone();
      continue;
    }

    self.wasuncontested = 0;

    if(self.cancontestclaim) {
      if(self.stalemate != self.wasstalemate) {
        if(self.stalemate) {
          if(isDefined(self.oncontested))
            self[[self.oncontested]]();
        } else {
          team = "none";

          foreach(_id_F90358454413407F in level.teamnamelist) {
            if(self.numtouching[_id_F90358454413407F]) {
              team = _id_F90358454413407F;
              break;
            }
          }

          if(team == "none" && self.ownerteam != "neutral")
            team = self.ownerteam;

          setclaimteam("none");
          self.claimplayer = undefined;

          foreach(team in level.teamnamelist) {
            if(self.touchlist[team].size) {
              touchlist = self.touchlist[team];
              _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

              for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                player = touchlist[_id_59DB5D0F4E3000A7[index]].player;
                player setclientomnvar("ui_objective_pinned_text_param", 0);
              }

              break;
            }
          }

          if(isDefined(self.onuncontested))
            self[[self.onuncontested]](team);

          self.wasuncontested = 1;
        }

        self.wasstalemate = self.stalemate;
      }

      if(!self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress)
        self.wasmajoritycapprogress = self.majoritycapprogress;
    }

    if(!self.stalemate && !self.majoritycapprogress && !self.wasuncontested) {
      if(self.mustmaintainclaim && !istrue(self.isunoccupied)) {
        if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam]) {
          if(isDefined(self.onunoccupied))
            self[[self.onunoccupied]]();

          self.isunoccupied = 1;
          setclaimteam("none");
          self.claimplayer = undefined;
        } else if(self.ownerteam == "neutral") {
          if(!isteamtouching()) {
            if(isDefined(self.onunoccupied))
              self[[self.onunoccupied]]();

            self.isunoccupied = 1;
            setclaimteam("none");
            self.claimplayer = undefined;
          } else if(isDefined(self.numtouchrequireduse))
            self[[self.numtouchrequireduse]](self.claimplayer.team);
        }
      } else if(!istrue(self.isunoccupied) && isDefined(self.onunoccupied)) {
        team = "none";

        foreach(_id_F90358454413407F in level.teamnamelist) {
          if(self.numtouching[_id_F90358454413407F]) {
            team = _id_F90358454413407F;
            break;
          }
        }

        if(team == "none") {
          self.isunoccupied = 1;
          self[[self.onunoccupied]]();
        }
      }
    }

    allowcapture = 1;

    if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
      allowcapture = 0;

    if(self.claimteam != "none" && allowcapture) {
      if(!self.usetime) {
        if(!self.stalemate) {
          _id_58E8D1412BC688CD = getearliestclaimplayer();
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onuse))
            self[[self.onuse]](_id_58E8D1412BC688CD);
        }
      } else if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
        self.curprogress = 0.0;
        self.teamprogress[self.claimteam] = self.curprogress;
        _id_58E8D1412BC688CD = getearliestclaimplayer();
        setclaimteam("none");
        self.claimplayer = undefined;

        if(isDefined(self.onenduse))
          self[[self.onenduse]](self.claimteam, _id_58E8D1412BC688CD, isDefined(_id_58E8D1412BC688CD));

        if(isDefined(_id_58E8D1412BC688CD) && isDefined(self.onuse))
          self[[self.onuse]](_id_58E8D1412BC688CD);
      } else if(!self.stalemate && self.usetime && (self.ownerteam != self.claimteam || istrue(self.majoritycapprogress))) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse))
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);
        } else if(canstompprogresswithstalemate(self.claimteam) && self.ownerteam == "neutral") {
          if(self.lastclaimteam == self.claimteam && istrue(self.majoritycapprogress)) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam) {
          if(self.lastclaimteam != self.claimteam) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == self.claimteam) {
          if(isDefined(self.lastprogressteam) && self.lastprogressteam == self.claimteam && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
          else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
        } else if(self.ownerteam != self.claimteam) {
          self.setblocking = 0;
          self.setdefending = 0;
          applycaptureprogressanduseupdate();
        } else if(self.ownerteam == self.claimteam && istrue(self.majoritycapprogress)) {
          _id_351B93A4DE4CF1CE = 0;

          if(_id_351B93A4DE4CF1CE && !istrue(self.setblocking)) {
            self.setblocking = 1;
            self.setdefending = 0;
            objective_setfriendlylabel(self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
            objective_setenemylabel(self.objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
          } else if(!_id_351B93A4DE4CF1CE && !istrue(self.setdefending)) {
            self.setblocking = 0;
            self.setdefending = 1;
            setobjectivestatusicons(level.icondefending, level.iconcapture);
          }
        }
      }
    } else if(canstompprogress(self.ownerteam) && self.ownerteam != "neutral")
      stompenemyteamprogress(self.ownerteam);

    waitframe();
    waittillhostmigrationdone();
  }
}

_id_8DD7B0157EFB558A(origin, radius, time) {
  level endon("game_ended");
  scripts\cp\utility::drawsphere(origin, radius, 1000, (1, 1, 1));
}

init_player_gameobjects() {
  self.touchtriggers = [];
  self.canpickupobject = 1;
  self.initialized_gameobject_vars = 1;
}

proxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  entitynumber = self.entnum;

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(istrue(self.trigger.trigger_off)) {
      continue;
    }
    if(isagent(player)) {
      continue;
    }
    if(!scripts\cp_mp\utility\game_utility::isgameparticipant(player)) {
      continue;
    }
    if(isDefined(self.carrier)) {
      continue;
    }
    if(istrue(player.inlaststand)) {
      continue;
    }
    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }
    if(!isDefined(player.initialized_gameobject_vars))
      player init_player_gameobjects();

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](player))
        continue;
    }

    _id_EDD687A0AB26D9F0 = getrelativeteam(player.pers["team"]);

    if(isDefined(self.teamusetimes[_id_EDD687A0AB26D9F0]) && self.teamusetimes[_id_EDD687A0AB26D9F0] < 0) {
      continue;
    }
    if(isalive(player) && !isDefined(player.touchtriggers[entitynumber])) {
      team = player.pers["team"];
      self.numtouching[team]++;
      _id_597108FD5F20988F = player.guid;
      struct = spawnStruct();
      struct.player = player;
      struct.starttime = gettime();
      self.touchlist[team][_id_597108FD5F20988F] = struct;

      if(isDefined(self.assisttouchlist)) {
        if(!isDefined(self.assisttouchlist[team][_id_597108FD5F20988F]))
          self.assisttouchlist[team][_id_597108FD5F20988F] = struct;
      }
    }

    if(self.cancontestclaim) {
      numtouching = getnumtouchingforteam(player.pers["team"]);
      _id_65218754A3CA92DB = getnumtouchingexceptteam(player.pers["team"]);

      if(numtouching && !_id_65218754A3CA92DB || numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB) {
        self.majoritycapprogress = 1;
        self.isunoccupied = 0;
      }
    }

    if(self.claimteam == "none" || !istrue(self.allowcapture) || istrue(self.majoritycapprogress)) {
      if(caninteractwith(player.pers["team"], player)) {
        if(canclaim(player)) {
          if(!proxtriggerlos(player)) {
            continue;
          }
          if(istrue(self.majoritycapprogress)) {
            if(isDefined(self.mostnumtouching) && isDefined(self.mostnumtouchingteam)) {
              setclaimteam(self.mostnumtouchingteam);
              claimplayer = getearliestclaimplayer();
              self.claimplayer = claimplayer;
            }
          } else {
            setclaimteam(player.pers["team"]);
            self.claimplayer = player;
          }

          if(isDefined(self.teamusetimes[_id_EDD687A0AB26D9F0]))
            self.usetime = self.teamusetimes[_id_EDD687A0AB26D9F0];

          self.allowcapture = 1;

          if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
            self.allowcapture = 0;

          if(self.usetime && isDefined(self.onbeginuse) && self.allowcapture && self.ownerteam != self.claimteam) {
            self.isunoccupied = 0;

            if(isDefined(self.didstatusnotify) && !self.didstatusnotify)
              self[[self.onbeginuse]](self.claimplayer);
            else if(!isDefined(self.didstatusnotify))
              self[[self.onbeginuse]](self.claimplayer);
          }
        } else if(isDefined(self.oncantuse))
          self[[self.oncantuse]](player);
      }
    }

    if(isalive(player) && !isDefined(player.touchtriggers[entitynumber]))
      player thread triggertouchthink(self);
  }
}

proxtriggerlos(player) {
  if(!isDefined(self.requireslos))
    return 1;

  tracestart = player getEye();
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  ignoreents = [];
  _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 32);
  _id_6C31025C58CD1AD8 = 1;
  ignoreents[0] = self.visuals;
  ignoreents[1] = self.carrier;
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);

  if(trace["fraction"] != 1 && _id_6C31025C58CD1AD8) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 16);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);
  }

  if(trace["fraction"] != 1) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 0);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);
  }

  return trace["fraction"] == 1;
}

getnumtouchingexceptteam(_id_21AEBAA767023F1E) {
  numtouching = 0;
  _id_E7AD7F306D72799C = 0;
  self.mostnumtouching = 0;
  self.mostnumtouchingteam = "none";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_E7AD7F306D72799C = _id_E7AD7F306D72799C + self.numtouching[_id_F90358454413407F];

    if(_id_E7AD7F306D72799C > 0 && _id_E7AD7F306D72799C > self.mostnumtouching) {
      self.mostnumtouching = _id_E7AD7F306D72799C;
      self.mostnumtouchingteam = _id_F90358454413407F;
      _id_E7AD7F306D72799C = 0;
    }

    if(_id_F90358454413407F != _id_21AEBAA767023F1E)
      numtouching = numtouching + self.numtouching[_id_F90358454413407F];
  }

  return numtouching;
}

caninteractwith(team, player) {
  if(isDefined(player) && isDefined(self.interactsquads))
    return isDefined(self.interactsquads[player.team]) && scripts\engine\utility::array_contains(self.interactsquads[player.team], player._id_0FF97225579DE16A);
  else {
    switch (self.interactteam) {
      case "none":
        return 0;
      case "any":
        return 1;
      case "friendly":
        if(team == self.ownerteam)
          return 1;
        else
          return 0;
      case "enemy":
        if(team != self.ownerteam)
          return 1;
        else
          return 0;
      default:
        return 0;
    }
  }
}

canclaim(player) {
  if(isDefined(self.carrier))
    return 0;

  if(self.cancontestclaim) {
    numtouching = getnumtouchingforteam(player.pers["team"]);
    _id_65218754A3CA92DB = getnumtouchingexceptteam(player.pers["team"]);

    if(numtouching && !_id_65218754A3CA92DB || numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB) {
      self.majoritycapprogress = 1;
      self.wasmajoritycapprogress = 0;
      return 1;
    }

    if(numtouching && _id_65218754A3CA92DB && numtouching == _id_65218754A3CA92DB) {
      self.stalemate = 1;
      self.majoritycapprogress = 0;
      self.wasmajoritycapprogress = 1;
      return 0;
    }
  }

  if(!isDefined(self.keyobject))
    return 1;

  if(isDefined(self.nocarryobject)) {
    if(checkobjectiskeyobject(player))
      return 1;
  }

  if(isDefined(player.carryobject)) {
    if(checkplayercarrykeyobject(player))
      return 1;
  }

  return 0;
}

triggertouchthink(object) {
  team = self.pers["team"];
  guid = self.guid;

  if(object scripts\cp\cp_objectives::_id_9A19CCF8DC6C3CAF()) {
    scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
    self.pinnedobjid = object.objidnum;

    if(isDefined(object.onpinnedstate))
      object[[object.onpinnedstate]](self);
  } else if(object scripts\cp\cp_objectives::_id_DC06030CEB03363B()) {
    scripts\mp\objidpoolmanager::objective_pin_player(object.trigger.objidnum, self);
    self.pinnedobjid = object.trigger.objidnum;

    if(isDefined(object.onpinnedstate))
      object[[object.onpinnedstate]](self);
  }

  if(!isDefined(self.touchinggameobjects))
    self.touchinggameobjects = [];

  _id_9D22374A99144826 = object.trigger getentitynumber();
  self.touchinggameobjects[_id_9D22374A99144826] = object;

  if(!isDefined(object.nousebar))
    object.nousebar = 0;

  self.touchtriggers[object.entnum] = object.trigger;
  object updateuserate();

  while(scripts\cp\utility\player::isreallyalive(self) && isDefined(object.trigger) && (self istouching(object.trigger) || isDefined(self.vehicle) && self.vehicle istouching(object.trigger)) && !level.gameended) {
    if(isDefined(object.checkinteractteam) && object.team != team) {
      break;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(isDefined(object.interactsquads) && !isDefined(object.interactsquads[self.team]) || isDefined(object.interactsquads) && !scripts\engine\utility::array_contains(object.interactsquads[self.team], self._id_0FF97225579DE16A)) {
      break;
    }

    if(istrue(object.trigger.trigger_off)) {
      break;
    }

    if(istrue(object.checkuseconditioninthink) && isDefined(object.usecondition) && !object[[object.usecondition]](self)) {
      break;
    }

    if(object scripts\cp\cp_objectives::_id_9A19CCF8DC6C3CAF() && !scripts\cp\utility::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
      self.remoteunpinned = undefined;
    } else if(object scripts\cp\cp_objectives::_id_DC06030CEB03363B() && !scripts\cp\utility::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
      self.remoteunpinned = undefined;
    }

    if((isPlayer(self) || isagent(self) && istrue(self._id_599B158D152C358D)) && object.usetime > 50)
      scripts\cp\utility::updateuiprogress(object, 1);

    waitframe();
  }

  if(isDefined(self)) {
    if(object.usetime > 50) {
      if(isPlayer(self) || isagent(self) && istrue(self._id_599B158D152C358D))
        scripts\cp\utility::updateuiprogress(object, 0);

      if(isDefined(self.touchtriggers))
        self.touchtriggers[object.entnum] = undefined;
    } else if(isDefined(self.touchtriggers))
      self.touchtriggers[object.entnum] = undefined;

    if(isDefined(self.touchtriggers))
      self.touchinggameobjects[_id_9D22374A99144826] = undefined;
  }

  if(level.gameended) {
    return;
  }
  object.oldtouchlist = object.touchlist;

  if(isDefined(self))
    object.touchlist[team][guid] = undefined;
  else {
    _id_B05A747EA1537870 = [];

    foreach(guid, _id_76FF2376B27F4085 in object.touchlist[team]) {
      if(!isDefined(_id_76FF2376B27F4085.player) || !isalive(_id_76FF2376B27F4085.player))
        _id_B05A747EA1537870[_id_B05A747EA1537870.size] = guid;
    }

    foreach(guid in _id_B05A747EA1537870)
    object.touchlist[team][guid] = undefined;
  }

  if(isDefined(self) && isDefined(object.trigger) && isDefined(object.trigger.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(object.trigger.objidnum, self);
    self.pinnedobjid = undefined;

    if(object.lastclaimteam == "none") {
      if(isDefined(object.capturebehavior) && object.capturebehavior == "persistent")
        scripts\mp\objidpoolmanager::objective_show_progress(object.trigger.objidnum, 0);
    }
  }

  if(isDefined(self) && isDefined(object.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(object.objidnum, self, object.showoncompass);
    self.pinnedobjid = undefined;

    if(object.lastclaimteam == "none") {
      if(isDefined(object.capturebehavior) && object.capturebehavior == "persistent")
        scripts\mp\objidpoolmanager::objective_show_progress(object.objidnum, 0);
    }
  }

  object.numtouching[team]--;
  object updateuserate();

  if(isDefined(object.onunpinnedstate))
    object[[object.onunpinnedstate]](self);
}

checkobjectiskeyobject(player) {
  _id_9DC8B39B9DC38EF4 = self.keyobject;

  if(!isarray(_id_9DC8B39B9DC38EF4))
    _id_9DC8B39B9DC38EF4 = [_id_9DC8B39B9DC38EF4];

  foreach(key in _id_9DC8B39B9DC38EF4) {
    if(key istouching(self.trigger))
      return 1;
  }

  return 0;
}

checkplayercarrykeyobject(player) {
  _id_9DC8B39B9DC38EF4 = self.keyobject;

  if(!isarray(_id_9DC8B39B9DC38EF4))
    _id_9DC8B39B9DC38EF4 = [_id_9DC8B39B9DC38EF4];

  foreach(key in _id_9DC8B39B9DC38EF4) {
    if(key == player.carryobject)
      return 1;
  }

  return 0;
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isalive(player)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(player scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(player getcurrentweapon()) && !istrue(player.isjuggernaut)) {
      continue;
    }
    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](player))
        continue;
    }

    if(isDefined(self.keyobject) && (!isDefined(player.carryobject) || player.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);

      continue;
    }

    if(isDefined(self.useweapon) && player hasweapon(self.useweapon)) {
      continue;
    }
    if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon")) {
      continue;
    }
    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(player);
      continue;
    }

    useholdloop(player);
  }
}

useholdloop(player) {}

utilflare_shootflare(spawn_origin, _id_1DA50610F94E1BFB) {
  level endon("game_ended");
  _id_3E146ED5E207E635 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  new_position = scripts\engine\trace::ray_trace(spawn_origin + (0, 0, 4000), spawn_origin, undefined, _id_3E146ED5E207E635, undefined, 1)["position"];
  flare = spawn("script_model", new_position);
  flare.angles = vectortoangles((0, 0, 1));
  flare setModel("equip_flare_br");
  wait 0.5;
  flare setscriptablepartstate("launch", "start", 0);
  _id_3FC3DAADE1C87824 = "start";

  if(_id_1DA50610F94E1BFB == "revive")
    _id_3FC3DAADE1C87824 = "start_revive";

  flare setscriptablepartstate("travel", _id_3FC3DAADE1C87824, 0);
  flare thread _utilflare_lerpflare(_id_1DA50610F94E1BFB);
}

_utilflare_lerpflare(_id_1DA50610F94E1BFB) {
  self endon("death");
  level endon("game_ended");
  movetime = 3.125;
  self moveTo(self.origin + (0, 0, 2500), movetime);
  wait(movetime);
  _utilflare_flareexplode(_id_1DA50610F94E1BFB);
}

_utilflare_flareexplode(_id_1DA50610F94E1BFB) {
  if(!isDefined(_id_1DA50610F94E1BFB))
    _id_1DA50610F94E1BFB = "<undefined>";

  self setscriptablepartstate("travel", "off", 0);

  if(!_utilflare_isvalidflaretype(_id_1DA50610F94E1BFB)) {
    return;
  }
  _id_44A98E57FEB74898 = "start_" + _id_1DA50610F94E1BFB;
  self setscriptablepartstate("explode", _id_44A98E57FEB74898, 0);
  thread sfx_br_flare_phosphorus();
}

_utilflare_isvalidflaretype(_id_1DA50610F94E1BFB) {
  _id_03BA45E0E07877B7 = 0;

  if(isDefined(_id_1DA50610F94E1BFB)) {
    switch (_id_1DA50610F94E1BFB) {
      case "revive":
      case "dom":
        _id_03BA45E0E07877B7 = 1;
        break;
    }
  }

  return _id_03BA45E0E07877B7;
}

sfx_br_flare_phosphorus() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);
  wait 12;
  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

applycaptureprogressanduseupdate() {
  applycaptureprogress(self.claimteam, level.frameduration * self.userate);

  if(isDefined(self.onuseupdate))
    self[[self.onuseupdate]](self.claimteam, self.teamprogress[self.claimteam] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
}

applycaptureprogress(team, _id_3777ECE6A73EADA5) {
  _id_B0C33D224B825287 = scripts\cp\utility::getenemyteams(team);

  switch (getcapturebehavior()) {
    case "persistent":
      self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
      self.curprogress = self.teamprogress[team];
      break;
    case "contest_only":
      if(!isDefined(self.ownerteam) || self.ownerteam == team) {
        return;
      }
      break;
    case "neutralize":
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

        if(_id_75016344BDEE1D3A > 0) {
          if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
            self.teamprogress[_id_F90358454413407F] = 0;
            _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
            continue;
          }

          self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
          _id_3777ECE6A73EADA5 = 0;
          self.curprogress = self.teamprogress[_id_F90358454413407F];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(_id_3777ECE6A73EADA5 > 0) {
        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
      }

      break;
    case "only_associated_teams":
      if(!isDefined(self.associatedteams) || !scripts\engine\utility::array_contains(self.associatedteams, team)) {
        return;
      }
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

        if(_id_75016344BDEE1D3A > 0) {
          if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
            self.teamprogress[_id_F90358454413407F] = 0;
            _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
            continue;
          }

          self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
          _id_3777ECE6A73EADA5 = 0;
          self.curprogress = self.teamprogress[_id_F90358454413407F];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(_id_3777ECE6A73EADA5 > 0) {
        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
      }

      break;
    case "one_way_contest_only":
      if(team != self.team) {
        return;
      }
      if(team == self.team) {
        foreach(enemyteam in _id_B0C33D224B825287) {
          if(self.numtouching[enemyteam] > 0)
            return;
        }
      }

      self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
      self.curprogress = self.teamprogress[team];
      break;
    default:
      progress = self.teamprogress[team];
      progress = progress + _id_3777ECE6A73EADA5;
      _id_6736D41E2AF881DE = 0;
      numtouching = getnumtouchingforteam(team);
      _id_65218754A3CA92DB = getnumtouchingexceptteam(team);

      if(numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB)
        _id_6736D41E2AF881DE = 1;

      if(istrue(self.majoritycapprogress) && progress >= self.usetime * 0.95 && istrue(_id_6736D41E2AF881DE)) {
        if(self.ownerteam == "neutral") {
          foreach(team in level.teamnamelist) {
            if(self.touchlist[team].size) {
              touchlist = self.touchlist[team];
              _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

              for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                player = touchlist[_id_59DB5D0F4E3000A7[index]].player;
                player setclientomnvar("ui_objective_pinned_text_param", 4);
              }

              break;
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        } else {
          foreach(team in level.teamnamelist) {
            if(team == self.ownerteam) {
              if(self.touchlist[team].size) {
                touchlist = self.touchlist[team];
                _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

                for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                  player = touchlist[_id_59DB5D0F4E3000A7[index]].player;
                  player setclientomnvar("ui_objective_pinned_text_param", 4);
                }

                break;
              }
            }
          }

          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        }
      } else {
        if(self.ownerteam != "neutral") {
          if(self.ownerteam != team)
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
        }

        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
      }

      break;
  }
}

canstompprogress(_id_C8200ACBB85AC41F) {
  return !istrue(self.ignorestomp) && self.touchlist[_id_C8200ACBB85AC41F].size > 0 && !istrue(self.stalemate) && self.curprogress > 0;
}

getrelativeteam(team) {
  if(team == self.ownerteam)
    return "friendly";
  else
    return "enemy";
}

getearliestclaimplayer() {
  team = self.claimteam;
  _id_0257DC7B0ABCB815 = self.claimplayer;

  if(self.touchlist[team].size > 0) {
    _id_E300F983791236B9 = undefined;
    players = getarraykeys(self.touchlist[team]);

    for(index = 0; index < players.size; index++) {
      _id_E29BB013735AF9BC = self.touchlist[team][players[index]];

      if(isalive(_id_E29BB013735AF9BC.player) && (!isDefined(_id_E300F983791236B9) || _id_E29BB013735AF9BC.starttime < _id_E300F983791236B9)) {
        _id_0257DC7B0ABCB815 = _id_E29BB013735AF9BC.player;
        _id_E300F983791236B9 = _id_E29BB013735AF9BC.starttime;
      }
    }
  }

  return _id_0257DC7B0ABCB815;
}

canstompprogresswithstalemate(_id_C8200ACBB85AC41F) {
  return !istrue(self.ignorestomp) && self.touchlist[_id_C8200ACBB85AC41F].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

stompenemyteamprogress(team) {
  if(isDefined(self.stompeenemyprogressupdate))
    self[[self.stompeenemyprogressupdate]](team);

  _id_3777ECE6A73EADA5 = level.frameduration * self.userate;
  _id_B0C33D224B825287 = scripts\cp\utility::getenemyteams(team);

  foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
    _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

    if(_id_75016344BDEE1D3A > 0) {
      if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
        self.teamprogress[_id_F90358454413407F] = 0;
        self.curprogress = self.teamprogress[_id_F90358454413407F];
        scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
        scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
        _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
        continue;
      }

      self.isunoccupied = 0;
      self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
      _id_3777ECE6A73EADA5 = 0;
      self.curprogress = self.teamprogress[_id_F90358454413407F];
      scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, _id_F90358454413407F);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS");
    }
  }

  if(self.curprogress <= 0) {
    foreach(_id_AC0E424AC96A7113 in self.touchlist[self.ownerteam]) {
      if(isDefined(self.stompprogressreward))
        [[self.stompprogressreward]](_id_AC0E424AC96A7113.player);
    }

    self.lastprogressteam = undefined;
  }
}

questpointgetradius(point) {
  radius = 0;

  if(point.spawnflags & 4)
    radius = 256;
  else if(point.spawnflags & 2)
    radius = 128;
  else if(point.spawnflags & 1)
    radius = 168;

  return radius;
}

questtimerinit(category, _id_3E871B4B1EF67D52) {
  _id_935C70547A6790A9 = getquestdata(category);
  _id_935C70547A6790A9.usequesttimer = getdvarint(_func_2EF675C13CA1C4AF("dvar_71622BBA3F9292F4", category, "_enableQuestTime"), _id_3E871B4B1EF67D52);
}

questtimerset(time, _id_09707FF10D99D386) {
  if(!isDefined(_id_09707FF10D99D386))
    _id_09707FF10D99D386 = 0;

  totaltime = time + _id_09707FF10D99D386;
  _id_935C70547A6790A9 = getquestdata(self.category);

  if(!istrue(_id_935C70547A6790A9.usequesttimer)) {
    return;
  }
  self.missiontime = gettime() + totaltime * 1000;
  questtimerupdate();
}

questtimeradd(time) {
  _id_935C70547A6790A9 = getquestdata(self.category);

  if(!_id_935C70547A6790A9.usequesttimer) {
    return;
  }
  self.missiontime = self.missiontime + time * 1000;
  questtimerupdate();
}

questtimerupdate() {
  foreach(player in scripts\cp\utility::getplayersinteam(self.id))
  player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

  _id_935C70547A6790A9 = getquestdata(self.category);
  updatefunc = _id_935C70547A6790A9.funcs["onTimerUpdate"];

  if(isDefined(updatefunc))
    [[updatefunc]]();

  thread _questtimerwait();
}

_questtimerwait() {
  self notify("updateQuestTimer");
  self endon("game_ended");
  self endon("updateQuestTimer");
  self endon("questEnded");
  waittime = (self.missiontime - gettime()) / 1000;
  wait(waittime);
  _id_935C70547A6790A9 = getquestdata(self.category);
  _id_73EEDCA966115848 = _id_935C70547A6790A9.funcs["onTimerExpired"];

  if(isDefined(_id_73EEDCA966115848))
    [[_id_73EEDCA966115848]]();

  self.result = "timeout";
  thread removequestinstance();
}

registercontributingplayers(player) {
  if(!isDefined(self.contributingplayers))
    self.contributingplayers = [];

  if(!scripts\engine\utility::array_contains(self.contributingplayers, player))
    self.contributingplayers[self.contributingplayers.size] = player;
}

givequestrewardsinstance(team, rewardorigin, rewardangles, rewardscriptable, players) {
  if(!isDefined(players))
    players = scripts\cp\utility::getplayersinteam(team);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.missionparticipation)) {
      player.missionparticipation = 1;
      continue;
    }

    player.missionparticipation++;
  }

  return givequestrewards(self.questcategory, self.rewardmodifier, self.modifier, team, rewardorigin, rewardangles, rewardscriptable, players);
}

givequestrewards(category, _id_50B7F9E171376862, _id_395D6DF5C468CE77, team, rewardorigin, rewardangles, rewardscriptable, players) {
  group = getquestrewardbuildgroupref(category, _id_50B7F9E171376862, _id_395D6DF5C468CE77);
  return givequestrewardgroup(group, team, rewardorigin, rewardangles, rewardscriptable, players);
}

givequestrewardgroup(group, team, rewardorigin, rewardangles, rewardscriptable, players) {
  results = [];
  level.currentrewarddropindex = 0;
  rewards = getquestrewardgroupstablerewards(group);

  foreach(_id_EA0DDAE1258E9ACF, _id_A816505FFFA5EBD2 in rewards) {
    [reward, value] = givequestrewardref(_id_EA0DDAE1258E9ACF, _id_A816505FFFA5EBD2, team, rewardorigin, rewardangles, rewardscriptable, players);

    if(isDefined(results[reward])) {
      if(isstring(results[reward]))
        results[reward] = results[reward] + "," + value;
      else
        results[reward] = results[reward] + value;

      continue;
    }

    results[reward] = value;
  }

  level.currentrewarddropindex = undefined;
  return results;
}

givequestrewardref(_id_EA0DDAE1258E9ACF, _id_A816505FFFA5EBD2, team, rewardorigin, rewardangles, rewardscriptable, players) {
  tier = getquestrewardtier(team);
  _id_0F0B26F5F8DB069E = getquestrewardstabletype(_id_EA0DDAE1258E9ACF);
  value = getquestrewardstablevalue(_id_EA0DDAE1258E9ACF);

  if(!isstring(value)) {
    scale = getquestscalervalue(_id_A816505FFFA5EBD2, tier);

    if(scale != 1.0) {
      value = value * scale;
      value = castrewardvalue(_id_0F0B26F5F8DB069E, value);
    }
  }

  value = givequestreward(_id_0F0B26F5F8DB069E, value, team, rewardorigin, rewardangles, rewardscriptable, players);
  return [_id_0F0B26F5F8DB069E, value];
}

givequestreward(type, value, team, rewardorigin, rewardangles, rewardscriptable, players) {
  switch (type) {
    case "plunder":
      if(istrue(level.br_plunder_enabled)) {
        participantplunder = isDefined(rewardscriptable) && istrue(rewardscriptable.participantplunder);

        if(getDvar("dvar_7611A2790A0BF7FE", "") != "dmz" && getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk" && !participantplunder)
          giveteamplunderflat(team, value);
        else if(players.size > 0)
          giveteamplunderdistributive(players, value);
        else
          value = 0;
      } else
        value = 0;

      break;
    case "xp":
      if(isDefined(rewardscriptable) && istrue(rewardscriptable.participantxp))
        _id_2329E2336D8412BC = players;
      else
        _id_2329E2336D8412BC = scripts\cp\utility::getplayersinteam(team);

      foreach(player in _id_2329E2336D8412BC) {
        if(!isDefined(player.br_contractxpearned)) {
          player.br_contractxpearned = value;
          continue;
        }

        player.br_contractxpearned = player.br_contractxpearned + value;
      }

      break;
    case "loot_table":
      if(getDvar("dvar_7611A2790A0BF7FE", "") != "dmz" && getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk") {
        items = getscriptablelootcachecontents(rewardscriptable, value);
        questrewarddropitems(items, rewardorigin, rewardangles, 0);
      }

      break;
    case "loot_cache":
      items = getscriptablelootcachecontents(rewardscriptable, value);
      questrewarddropitems(items, rewardorigin, rewardangles, 1);
      break;
    case "loot_items":
      items = strtok(value, " ");
      questrewarddropitems(items, rewardorigin, rewardangles, 0);
      break;
    case "drop_bag":
      _id_736D8D9188CCBD45 = scripts\cp\utility::getplayersinteam(team)[0];
      calldropbag(_id_736D8D9188CCBD45, rewardorigin);
      break;
    case "reward_tier":
      break;
    case "uav":
      break;
    case "juggernaut":
      dropcircle = spawnStruct();
      dropcircle.origin = rewardorigin;
      dropcircle.dropradius = 300;
      dropcircle.nodropanim = 1;
      break;
    case "none":
      break;
    default:
      break;
  }

  return value;
}

getquesttablerewardgroup(category) {
  group = level.questinfo.rewards.categorytogroup[category];

  if(!isDefined(group)) {
    group = tablelookup("cp/incursion_missions.csv", 1, category, 7);
    level.questinfo.rewards.categorytogroup[category] = group;
  }

  return group;
}

getquestrewardgroupstablerewards(group) {
  _id_4C90CB0F1E0CD03A = getquestrewardsgrouptable();
  rewards = level.questinfo.rewards.grouptorewards[group];

  if(!isDefined(rewards)) {
    rewards = [];
    _id_E1E297E1DBA915DC = 2;
    _id_8201E3609F801081 = 3;

    for(;;) {
      ref = tablelookup(_id_4C90CB0F1E0CD03A, 0, group, _id_E1E297E1DBA915DC);

      if(ref == "") {
        break;
      }

      _id_B7AB28868F552DF5 = tablelookup(_id_4C90CB0F1E0CD03A, 0, group, _id_8201E3609F801081);
      rewards[ref] = _id_B7AB28868F552DF5;
      _id_E1E297E1DBA915DC = _id_E1E297E1DBA915DC + 2;
      _id_8201E3609F801081 = _id_8201E3609F801081 + 2;
    }

    if(isDefined(level.brmodevariantrewardcullfunc))
      rewards = [[level.brmodevariantrewardcullfunc]](rewards);

    level.questinfo.rewards.grouptorewards[group] = rewards;
  }

  return rewards;
}

getquestrewardstabletype(reward) {
  _id_8519CE2870B094D2 = "cp/cpmission_rewards.csv";

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_8519CE2870B094D2 = "mp/brmission_rewards_dmz.csv";

  type = level.questinfo.rewards.rewardtotype[reward];

  if(!isDefined(type)) {
    type = tablelookup(_id_8519CE2870B094D2, 0, reward, 1);
    level.questinfo.rewards.rewardtotype[reward] = type;
  }

  return type;
}

getquestrewardstablevalue(_id_EA0DDAE1258E9ACF) {
  _id_8519CE2870B094D2 = "cp/cpmission_rewards.csv";

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_8519CE2870B094D2 = "mp/brmission_rewards_dmz.csv";

  value = level.questinfo.rewards.rewardtovalue[_id_EA0DDAE1258E9ACF];

  if(!isDefined(value)) {
    _id_3ED4153889607866 = getquestreward_checkforvalueoverride(_id_EA0DDAE1258E9ACF);

    if(isDefined(_id_3ED4153889607866))
      value = _id_3ED4153889607866;
    else {
      _id_4E1C45C2B343B551 = getquestrewardstablevaluecolumnindex();
      value = tablelookup(_id_8519CE2870B094D2, 0, _id_EA0DDAE1258E9ACF, _id_4E1C45C2B343B551);
    }

    type = getquestrewardstabletype(_id_EA0DDAE1258E9ACF);
    value = castrewardvalue(type, value);
    level.questinfo.rewards.rewardtovalue[_id_EA0DDAE1258E9ACF] = value;
  }

  if(istrue(level.bmoovertime) && !isstring(value))
    value = int(value * level.overtimecashmultiplier);

  return value;
}

getquestrewardstablevaluecolumnindex() {
  switch (level.maxteamsize) {
    case 4:
      return 10;
    case 3:
      return 9;
    case 2:
      return 8;
    case 1:
      return 7;
    default:
      return 9;
  }
}

getquestreward_checkforvalueoverride(_id_EA0DDAE1258E9ACF) {
  value = getdvarint(_func_2EF675C13CA1C4AF("dvar_A6BEB3CD8862ACC1", _id_EA0DDAE1258E9ACF), -1);

  if(value > -1)
    return value;

  return undefined;
}

getquestrewardscalerstablescaleinfo(ref) {
  info = level.questinfo.rewards.scalertoscaleinfo[ref];

  if(!isDefined(info)) {
    info = [];
    _id_33F38025CF1BB801 = 1;
    _id_8201E3609F801081 = 2;

    for(;;) {
      tier = tablelookup("cp/cpmission_reward_scalers.csv", 0, ref, _id_33F38025CF1BB801);

      if(tier == "") {
        break;
      }

      tier = int(tier);
      _id_B7AB28868F552DF5 = float(tablelookup("cp/cpmission_reward_scalers.csv", 0, ref, _id_8201E3609F801081));
      info[tier] = _id_B7AB28868F552DF5;
      _id_33F38025CF1BB801 = _id_33F38025CF1BB801 + 2;
      _id_8201E3609F801081 = _id_8201E3609F801081 + 2;
    }

    level.questinfo.rewards.scalertoscaleinfo[ref] = info;
  }

  return info;
}

getquestplunderrewardinstance(tier) {
  return getquestplunderreward(self.questcategory, tier, self.modifier, self.rewardmodifier);
}

getquestplunderreward(category, tier, _id_7D42B5952D47067C, rewardmodifier) {
  if(!istrue(level.br_plunder_enabled))
    return 0;

  return getquestscaledvalue(category, tier, "plunder", _id_7D42B5952D47067C, rewardmodifier);
}

getquestxpreward(category, tier, _id_7D42B5952D47067C, rewardmodifier) {
  return getquestscaledvalue(category, tier, "xp", _id_7D42B5952D47067C, rewardmodifier);
}

getquestweaponxpreward(category, tier, _id_7D42B5952D47067C, rewardmodifier) {
  return getquestscaledvalue(category, tier, "weapon_xp", _id_7D42B5952D47067C, rewardmodifier);
}

getquestscaledvalue(category, tier, type, _id_7D42B5952D47067C, rewardmodifier) {
  group = getquesttablerewardgroup(category);
  getquestrewardbuildgroupref(category, rewardmodifier, _id_7D42B5952D47067C);
  rewards = getquestrewardgroupstablerewards(group);
  value = 0;

  foreach(_id_EA0DDAE1258E9ACF, _id_A816505FFFA5EBD2 in rewards) {
    _id_0F0B26F5F8DB069E = getquestrewardstabletype(_id_EA0DDAE1258E9ACF);

    if(_id_0F0B26F5F8DB069E == type) {
      _id_AA82E6D1B3760575 = getquestrewardstablevalue(_id_EA0DDAE1258E9ACF);
      scale = getquestscalervalue(_id_A816505FFFA5EBD2, tier);
      value = value + _id_AA82E6D1B3760575 * scale;
    }
  }

  value = castrewardvalue(type, value);
  return value;
}

getquestscalervalue(_id_A816505FFFA5EBD2, tier) {
  _id_B7AB28868F552DF5 = 1.0;
  info = getquestrewardscalerstablescaleinfo(_id_A816505FFFA5EBD2);
  add = 0.0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= tier; _id_AC0E594AC96AA3A8++) {
    if(isDefined(info[_id_AC0E594AC96AA3A8]))
      add = info[_id_AC0E594AC96AA3A8];

    _id_B7AB28868F552DF5 = _id_B7AB28868F552DF5 + add;
  }

  return _id_B7AB28868F552DF5;
}

questrewarddropitems(items, origin, angles, _id_A6293F3144240B99) {
  if(!isDefined(items)) {
    return;
  }
  itemsdropped = 0;

  if(isDefined(level.currentrewarddropindex))
    itemsdropped = level.currentrewarddropindex;

  _id_17B34CF2DD66912F = 0;

  foreach(itemname in items) {
    _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[itemname];

    if(isDefined(_id_A69FFF5222862F26) && _id_A69FFF5222862F26 == 4 && _id_17B34CF2DD66912F == 0) {
      itemsdropped++;
      _id_17B34CF2DD66912F = 1;
      continue;
    }

    itemsdropped++;
  }

  if(isDefined(level.currentrewarddropindex))
    level.currentrewarddropindex = itemsdropped;
}

getquestrewardbuildgroupref(category, _id_50B7F9E171376862, _id_395D6DF5C468CE77) {
  _id_C077500984233D8D = getquesttablerewardgroup(category);
  group = _id_C077500984233D8D;

  if(isDefined(_id_395D6DF5C468CE77))
    group = group + _id_395D6DF5C468CE77;

  if(isDefined(_id_50B7F9E171376862))
    group = group + _id_50B7F9E171376862;

  if(questrewardgroupexist(group))
    return group;

  group = _id_C077500984233D8D;

  if(isDefined(_id_50B7F9E171376862))
    group = group + _id_50B7F9E171376862;

  if(questrewardgroupexist(group))
    return group;

  return _id_C077500984233D8D;
}

questrewardgroupexist(_id_2F0B8C1F978FD835) {
  _id_4C90CB0F1E0CD03A = getquestrewardsgrouptable();
  ref = tablelookup(_id_4C90CB0F1E0CD03A, 0, _id_2F0B8C1F978FD835, 0);
  return ref != "";
}

getrewardvaluetype(_id_0F0B26F5F8DB069E) {
  switch (_id_0F0B26F5F8DB069E) {
    case "blueprint_chance":
    case "weapon_xp":
    case "reward_tier":
    case "drop_bag":
    case "loot_cache":
    case "loot_table":
    case "circle_peek":
    case "xp":
    case "plunder":
    case "none":
    case "juggernaut":
      return "int";
    case "loot_items":
    case "uav":
      return "string";
    default:
      break;
  }
}

castrewardvalue(_id_0F0B26F5F8DB069E, value) {
  type = getrewardvaluetype(_id_0F0B26F5F8DB069E);

  switch (type) {
    case "int":
      value = int(value);
      break;
    case "float":
      value = float(value);
      break;
    case "string":
      value = "" + value;
      break;
    default:
      break;
  }

  return value;
}

getquestrewardsgrouptable() {
  _id_4C90CB0F1E0CD03A = getDvar("dvar_85BA512AED5CE540", "cp/cpmission_reward_groups.csv");

  if(_id_4C90CB0F1E0CD03A == "")
    _id_4C90CB0F1E0CD03A = "cp/cpmission_reward_groups.csv";

  return _id_4C90CB0F1E0CD03A;
}

getquestrewardgroupindex(group) {
  _id_4C90CB0F1E0CD03A = getquestrewardsgrouptable();
  return int(tablelookup(_id_4C90CB0F1E0CD03A, 0, group, 1));
}

getquestrewardtier(team) {
  tier = level.questinfo.tiers[team];

  if(!isDefined(tier))
    tier = 1;

  return tier;
}

setquestindexteamomnvar(team, _id_5E9B1036A4CAE82F) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player setquestindexomnvar(_id_5E9B1036A4CAE82F);
}

setquestindexomnvar(_id_5E9B1036A4CAE82F) {
  self setclientomnvar("ui_br_objective_index", _id_5E9B1036A4CAE82F);
}

setquestrewardtierteamomnvar(team, tier) {
  foreach(player in scripts\cp\utility::getplayersinteam(team))
  player setquestrewardtieromnvar(tier);
}

setquestrewardtieromnvar(tier) {
  self setclientomnvar("ui_br_objective_reward_tier", tier);
}

cancelallmissions() {
  foreach(type, _id_12461E617D024EF9 in level.questinfo.quests) {
    foreach(instance in _id_12461E617D024EF9.instances) {
      instance.result = "cancel";
      instance removequestinstance();
    }
  }
}

getallactivequestsforteam(team) {
  results = [];

  foreach(type, _id_12461E617D024EF9 in level.questinfo.quests) {
    foreach(id, instance in _id_12461E617D024EF9.instances) {
      if(id != team) {
        continue;
      }
      questinfo = spawnStruct();
      questinfo.instance = instance;

      switch (instance.category) {
        case "assassination":
          if(isDefined(instance.targetplayer))
            questinfo.origin = instance.targetplayer.origin;

          break;
        case "domination":
          if(isDefined(instance.subscribedlocale) && isDefined(instance.subscribedlocale.domflag) && isDefined(instance.subscribedlocale.domflag.curorigin))
            questinfo.origin = instance.subscribedlocale.domflag.curorigin + (0, 0, 60);

          break;
        case "scavenger":
          if(isDefined(instance.subscribedlocale.cacheentity.origin) && isDefined(instance.subscribedlocale.cacheentity))
            questinfo.origin = instance.subscribedlocale.cacheentity.origin + (0, 0, 50);

          break;
        case "timedrun":
          break;
        case "secretstash":
          if(isDefined(instance.cacheentity) && isDefined(instance.cacheentity.origin))
            questinfo.origin = instance.cacheentity.origin + (0, 0, 50);

          break;
        case "smokinggun":
          break;
        case "collection":
          break;
        case "vip":
          break;
        case "blueprintextract":
          break;
        default:
          break;
      }

      results[results.size] = questinfo;
    }
  }

  return results;
}

_id_D3F36D304927A068(drop_type, _id_1BE1C3126E9508F6, _id_F4F7CEB1B8D0BB38, payload) {
  _id_CB4FAD49263E20C4 = spawnStruct();

  if(!isDefined(_id_1BE1C3126E9508F6))
    _id_CB4FAD49263E20C4.origin = self.origin;
  else
    _id_CB4FAD49263E20C4.origin = _id_1BE1C3126E9508F6;

  if(!isDefined(_id_F4F7CEB1B8D0BB38))
    _id_CB4FAD49263E20C4.angles = self.angles;
  else
    _id_CB4FAD49263E20C4.angles = _id_F4F7CEB1B8D0BB38;

  if(!isDefined(payload))
    _id_CB4FAD49263E20C4.payload = 0;

  item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_CB4FAD49263E20C4);

  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);

    if(_id_A1093166DE09E6B8 == drop_type) {
      item tabletinit(type);
      item tabletshow();
    }
  }

  return item;
}

_id_47F93C30E2251B61(_id_3EE8AD672D0B559F) {
  scripts\engine\utility::flag_wait("tablets_initted");
  _id_3D4263CA1AB2CC7A = "tablet_spawn";

  if(isDefined(_id_3EE8AD672D0B559F))
    _id_3D4263CA1AB2CC7A = _id_3EE8AD672D0B559F;

  _id_5D99A225CB875DDA = scripts\engine\utility::getStructArray(_id_3D4263CA1AB2CC7A, "targetname");

  foreach(struct in _id_5D99A225CB875DDA) {
    if(isDefined(struct.script_noteworthy))
      struct _id_D3F36D304927A068("brloot_" + struct.script_noteworthy + "_tablet");
  }

  scripts\engine\utility::flag_set("tablets_initted_spawned");
}

_id_AFB3C7102E36A404(instance) {
  instance.notifies = spawnStruct();

  if(isDefined(instance._id_A52C81F5E957AA03) && isDefined(instance._id_A52C81F5E957AA03.script_parameters)) {
    _id_6EABDF0F72D92B81 = strtok(instance._id_A52C81F5E957AA03.script_parameters, ",");
    instance.notifies._id_1FB633181B50CF5E = _id_6EABDF0F72D92B81[0];
    instance.notifies._id_FF8E35622C1CD1C3 = _id_6EABDF0F72D92B81[1];
  } else {}
}

_id_5B04CC6859711D68(instance) {
  if(isDefined(instance._id_A52C81F5E957AA03)) {
    _id_987C142D0107D65E = undefined;
    _id_F099E5D6D03AB553 = scripts\engine\utility::getStructArray(instance._id_A52C81F5E957AA03.target, "targetname");

    foreach(target in _id_F099E5D6D03AB553) {
      if(isDefined(target.script_noteworthy) && target.script_noteworthy == "quest_carepackage_prox") {
        _id_987C142D0107D65E = target;
        break;
      }
    }

    if(isDefined(_id_987C142D0107D65E)) {
      instance._id_A52C81F5E957AA03._id_2AED9BD3E1B340C3 = _id_987C142D0107D65E;
      instance.notifies._id_53A503FD95AAA00D = _id_987C142D0107D65E.origin;
    }
  }
}

_id_2247D0E9C5C2A383(instance) {
  if(isDefined(instance.notifies) && isDefined(instance.notifies._id_1FB633181B50CF5E))
    level notify(instance.notifies._id_1FB633181B50CF5E);

  _id_F4C6AB030DBCB027(instance);
}

_id_0F4FA3A0202D55F8(instance) {
  if(isDefined(instance.notifies) && isDefined(instance.notifies._id_FF8E35622C1CD1C3)) {
    _id_DC3D45349E773D1C = undefined;

    if(isDefined(instance.notifies._id_53A503FD95AAA00D))
      _id_DC3D45349E773D1C = instance.notifies._id_53A503FD95AAA00D;
    else
      _id_DC3D45349E773D1C = instance._id_A52C81F5E957AA03.origin;

    level notify(instance.notifies._id_FF8E35622C1CD1C3, _id_DC3D45349E773D1C);
  }
}

_id_F4C6AB030DBCB027(instance) {
  _id_988C3FD02BCBD450 = scripts\engine\utility::getStructArray("tablet_spawn", "targetname");

  if(!isDefined(_id_988C3FD02BCBD450) || _id_988C3FD02BCBD450.size == 0) {
    return;
  }
  if(!isDefined(instance.notifies) || !isDefined(instance.notifies._id_53A503FD95AAA00D)) {
    return;
  }
  foreach(_id_B95BCB61A9C33A7E in level.questinfo.activetablets) {
    if(_id_B95BCB61A9C33A7E == instance.tablet) {
      continue;
    }
    _id_E5108B81E236473A = scripts\engine\utility::getclosest(_id_B95BCB61A9C33A7E.origin, _id_988C3FD02BCBD450);
    _id_2B285F305E39E481 = _id_61816329786A4614(_id_E5108B81E236473A, "quest_carepackage_prox");
    _id_93EC5B028BD8D7DB = _id_2B285F305E39E481[0];

    if(!isDefined(_id_93EC5B028BD8D7DB)) {
      continue;
    }
    if(instance.notifies._id_53A503FD95AAA00D == _id_93EC5B028BD8D7DB.origin)
      _id_B95BCB61A9C33A7E tablethide();
  }
}

_id_61816329786A4614(current_struct, _id_E32BB3802E18D65E) {
  _id_3BE7636E00EE14B2 = [];

  while(isDefined(current_struct) && isDefined(current_struct.target)) {
    _id_F099E5D6D03AB553 = scripts\engine\utility::getStructArray(current_struct.target, "targetname");
    current_struct = undefined;

    foreach(target in _id_F099E5D6D03AB553) {
      if(isDefined(target.script_noteworthy) && target.script_noteworthy == _id_E32BB3802E18D65E) {
        current_struct = target;
        break;
      }
    }

    if(isDefined(current_struct))
      _id_3BE7636E00EE14B2[_id_3BE7636E00EE14B2.size] = current_struct;
  }

  return _id_3BE7636E00EE14B2;
}

_id_AA756DC58E1DA2C1(_id_EDD687A0AB26D9F0) {
  self.interactteam = _id_EDD687A0AB26D9F0;
}

_id_58281AC4DA450DED(_id_EDD687A0AB26D9F0) {
  self.interactteam = _id_EDD687A0AB26D9F0;
  _id_1F279540A91692B0();
}

_id_1F279540A91692B0() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch") {
    return;
  }
  if(self.interactteam == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "script_model")
      self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(scripts\engine\utility::array_contains(level.teamnamelist, self.ownerteam))
      self.trigger setteamfortrigger(self.ownerteam);
    else
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
  } else if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies")
      self.trigger setteamfortrigger("axis");
    else if(self.ownerteam == "axis")
      self.trigger setteamfortrigger("allies");
    else
      self.trigger setteamfortrigger("none");
  }
}

_id_D2CAA40694D469AB() {
  _id_8FF83BDD5420AE28("instance");
}

_id_8B0829A8CE24F0AA() {
  _id_8FF83BDD5420AE28("locale");
}

_id_8FF83BDD5420AE28(type) {
  _id_62F1998D4CCBBD13 = self.debugtype;

  if(!isDefined(_id_62F1998D4CCBBD13))
    _id_62F1998D4CCBBD13 = "<undefined>";
}

_id_132B6261E829FA9C() {
  _id_6736E9C4965502D1("instance", "locale");
}

_id_6736E9C4965502D1(_id_54764E985D3D2029, _id_54764B985D3D1990) {
  _id_62F1998D4CCBBD13 = self.debugtype;

  if(!isDefined(_id_62F1998D4CCBBD13))
    _id_62F1998D4CCBBD13 = "<undefined>";
}

_id_FE3B51CFBF0F97C5() {}

requestid(_id_11584E4650A8CDC0, world, _id_AA530B7C5AEFA0B4, showoncompass, dointro) {
  if(isDefined(_id_AA530B7C5AEFA0B4))
    self.objidnum = scripts\mp\objidpoolmanager::requestreservedid(_id_AA530B7C5AEFA0B4);
  else
    self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.objidnum != -1) {
    _id_024C76FC549F7FD9 = "done";

    if(_id_11584E4650A8CDC0 && world)
      _id_024C76FC549F7FD9 = "current";
    else if(_id_11584E4650A8CDC0)
      _id_024C76FC549F7FD9 = "active";
    else if(world)
      _id_024C76FC549F7FD9 = "invisible";

    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, _id_024C76FC549F7FD9, self.curorigin + self.offset3d);

    if(getdvarint("scr_game_objOnNavBar", 0) == 1) {
      if(isDefined(showoncompass) && showoncompass == 0) {
        objective_setshowoncompass(self.objidnum, 0);
        self.showoncompass = 0;
      } else
        objective_setshowoncompass(self.objidnum, 1);
    }

    if(isDefined(dointro)) {
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, dointro);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, dointro);
    }

    self.showworldicon = 0;
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);

    if(world)
      self.showworldicon = 1;
  }
}

releaseid(_id_321E7A51D3237066, _id_301EC764DD09B364) {
  if(istrue(_id_321E7A51D3237066))
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.objidnum, _id_301EC764DD09B364);
  else
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);

  self.objidnum = -1;
}