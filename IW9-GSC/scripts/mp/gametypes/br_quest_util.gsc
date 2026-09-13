/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_quest_util.gsc
**************************************************/

init_quest_util() {
  if(!getdvarint("scr_br_quests_enabled", 1)) {
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
  level.questinfo.unlockables = [];
  level.questinfo.defaultfilter = [];
  level.questinfo.defaultfilter[0] = ::filtercondition_isdead;
  level.questinfo.defaultfilter[1] = ::filtercondition_ingulag;
  level.questinfo.getactiveforteam = ::getallactivequestsforteam;
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(7, ::dangercircletick);

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("brQuests")) {
    return;
  }
  loadtables();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  _id_6A297C1028F46524::init();

  if(getdvarint("dvar_82BDE055B11E6698", 0)) {
    _id_110FD2130C2ED1FE::init();
    _id_404DF4D3A3B8CD80::init();
    _id_1C3DAC686AA675CC::init();
    _id_6388860E9E2A83BD::init();
    _id_6AB78610E79A4AEC::init();
  }

  if(getdvarint("dvar_B91A7EBB801D5968", 1) == 1)
    _id_7D625073C6379D53::disablelootbunkercachelocations();

  if(getdvarint("dvar_FD6B014836F663E0", 1) == 1)
    _id_7D625073C6379D53::disablebunker11cachelocations();

  thread inittablets();
  thread setupcirclepeek();
  game["dialog"]["mission_gen_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_misc_success"] = "contract_misc_success";
  game["dialog"]["mission_obj_change"] = "mission_mission_obj_change";
  game["dialog"]["mission_obj_moved"] = "mission_mission_obj_moved";
  game["dialog"]["mission_obj_next_ptarget"] = "mission_mission_obj_next_ptarget";
  game["dialog"]["mission_obj_next_nptarget"] = "mission_mission_obj_next_nptarget";
  game["dialog"]["mission_obj_warning_time"] = "mission_mission_obj_warning_time";
  game["dialog"]["mission_obj_warning_capture"] = "mission_mission_obj_warning_capture";
  game["dialog"]["mission_obj_circle_fail"] = "mission_mission_obj_circle_fail";
  game["dialog"]["mission_gen_fail"] = "mission_mission_gen_fail";
  game["dialog"]["mission_teammate_down"] = "mission_teammate_down";
  game["dialog"]["mission_enemy_down"] = "mission_enemy_down";

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");

  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  level.brmodevariantrewardcullfunc = undefined;
}

loadtables() {
  _id_CB89110314447B2F = 0;

  for(;;) {
    unlockableindex = tablelookupbyrow("mp/brmission_unlockables.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(unlockableindex) || unlockableindex == "") {
      break;
    }

    if(int(tablelookup("mp/brmission_unlockables.csv", 0, unlockableindex, 3)) == 1) {
      continue;
    }
    _id_A03D4FE1F134DB01 = spawnStruct();
    _id_A03D4FE1F134DB01.unlockableindex = int(unlockableindex);
    _id_A03D4FE1F134DB01.lootid = int(tablelookup("mp/brmission_unlockables.csv", 0, unlockableindex, 1));
    _id_A03D4FE1F134DB01.extractunlockablechance = int(tablelookup("mp/brmission_unlockables.csv", 0, unlockableindex, 2));
    level.questinfo.unlockables[_id_A03D4FE1F134DB01.lootid] = _id_A03D4FE1F134DB01;
    _id_CB89110314447B2F++;
  }
}

inittablets() {
  level.questinfo.activetablets = [];
  _id_64D2F24DF5D49616 = getdvarfloat("dvar_4EC62B4599196026", 0.667);
  _id_294684D6A0DEEF46 = [];

  foreach(type, info in level.questinfo.tabletinfo) {
    _id_A1093166DE09E6B8 = getlootname(type);
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(_id_A1093166DE09E6B8);

    if(!info.enabled) {
      continue;
    }
    _id_6D130EBB53AD2136 = getdvarfloat("dvar_08D46517B8DA8688", 1200.0);

    if(_id_6D130EBB53AD2136 > 0) {
      _id_7BEA6D9F75C96CEF = 0;

      foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
        _id_7BA908D45C350CA4 = getlootscriptablearrayinradius(_id_A1093166DE09E6B8, undefined, _id_15B89FF206500554.origin, _id_6D130EBB53AD2136);

        foreach(_id_EDBA0A1C91AB84BF in _id_7BA908D45C350CA4) {
          if(istrue(_id_EDBA0A1C91AB84BF.startdisabled)) {
            continue;
          }
          _id_EDBA0A1C91AB84BF.startdisabled = 1;
          _id_7BEA6D9F75C96CEF++;
        }
      }

      for(_id_AC0E594AC96AA3A8 = _id_E0D1E3A2B6F5323A.size - 1; _id_AC0E594AC96AA3A8 >= 0 && _id_7BEA6D9F75C96CEF; _id_AC0E594AC96AA3A8--) {
        if(istrue(_id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8].startdisabled)) {
          _id_E0D1E3A2B6F5323A[_id_AC0E594AC96AA3A8] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
          _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
          _id_7BEA6D9F75C96CEF--;
        }
      }
    }

    if(istrue(level.lowpopstart) && _id_1E4A61DB11011446::lowpopallowtweaks()) {
      _id_0984F974FA5F11F8 = getdvarfloat("dvar_CC6BB1E27A91186F", 0.8);
      _id_4038CDE6712B9F81 = int(min(_id_E0D1E3A2B6F5323A.size, _id_E0D1E3A2B6F5323A.size * (1.0 - _id_0984F974FA5F11F8) + 0.5));

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4038CDE6712B9F81; _id_AC0E594AC96AA3A8++) {
        _id_2ADBA961C731BAF6 = randomintrange(0, _id_E0D1E3A2B6F5323A.size);
        _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6].startdisabled = 1;
        _id_E0D1E3A2B6F5323A[_id_2ADBA961C731BAF6] = _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1];
        _id_E0D1E3A2B6F5323A[_id_E0D1E3A2B6F5323A.size - 1] = undefined;
      }
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

  zones = getarraykeys(level.calloutglobals.namelocations);
  _id_6B7736374856505C = [];
  _id_7B18BF75C63CF8BE = getdvarint("dvar_96DB0B0E9378AD40", 1);

  if(_id_7B18BF75C63CF8BE > 0) {
    foreach(zone in zones)
    _id_6B7736374856505C[zone] = _id_7B18BF75C63CF8BE;
  }

  _id_007CA789CBF8098E = 0;

  foreach(type, info in level.questinfo.tabletinfo) {
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(getlootname(type));
    _id_007CA789CBF8098E = _id_007CA789CBF8098E + _id_E0D1E3A2B6F5323A.size;

    if(info.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A) {
        if(istrue(tablet.startdisabled)) {
          tablet tablethide();
          continue;
        }

        tablet tabletshow();

        if(_id_6B7736374856505C.size > 0) {
          _id_EA19C4E9489CD7BF = _id_7502DF3A967E1664::getlocationnameforpoint(tablet.origin);

          if(isDefined(_id_6B7736374856505C[_id_EA19C4E9489CD7BF])) {
            _id_6B7736374856505C[_id_EA19C4E9489CD7BF]--;

            if(!_id_6B7736374856505C[_id_EA19C4E9489CD7BF])
              _id_6B7736374856505C[_id_EA19C4E9489CD7BF] = undefined;
          }
        }
      }

      continue;
    }

    foreach(tablet in _id_E0D1E3A2B6F5323A)
    tablet tablethide();
  }

  if(_id_6B7736374856505C.size) {
    _id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(_id_294684D6A0DEEF46);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++) {
      tablet = _id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
      _id_EA19C4E9489CD7BF = _id_7502DF3A967E1664::getlocationnameforpoint(tablet.origin);

      if(isDefined(_id_6B7736374856505C[_id_EA19C4E9489CD7BF])) {
        tablet tabletshow();
        _id_6B7736374856505C[_id_EA19C4E9489CD7BF]--;

        if(!_id_6B7736374856505C[_id_EA19C4E9489CD7BF]) {
          _id_6B7736374856505C[_id_EA19C4E9489CD7BF] = undefined;

          if(!_id_6B7736374856505C.size) {
            break;
          }
        }
      }
    }
  }

  activequests = level.questinfo.activetablets.size;
  _id_9AFE8D8A9AED972A = _id_294684D6A0DEEF46.size;
  _id_715028F54BAD19A1::branalytics_inittablets(_id_007CA789CBF8098E, activequests, _id_9AFE8D8A9AED972A, _id_64D2F24DF5D49616);

  if(_id_362C58E8BB39BCDA::isfeatureenabled("tabletReplace"))
    thread tabletreplace(_id_294684D6A0DEEF46);
  else
    thread delayedshowtablets(_id_294684D6A0DEEF46);
}

setobjectivetypesomvarbit(type) {
  index = getquestindex(type);
  setomnvarbit("ui_br_objective_types", index, 1);
}

tabletreplace(_id_294684D6A0DEEF46) {
  if(!isDefined(level.br_level)) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(_id_294684D6A0DEEF46);
  _id_FB4145CF6A25541E = 0;
  _id_40FB495A4451D505 = level.tabletreplacefrequency;
  _id_AC0E594AC96AA3A8 = 0;

  while(_id_AC0E594AC96AA3A8 < _id_294684D6A0DEEF46.size) {
    tablet = _id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
    level waittill("quest_started");

    if(isDefined(level.tabletreplacefrequency) && level.tabletreplacefrequency != -1) {
      _id_FB4145CF6A25541E++;

      if(_id_FB4145CF6A25541E >= _id_40FB495A4451D505) {
        tablet tabletshow();
        _id_40FB495A4451D505 = _id_40FB495A4451D505 + level.tabletreplacefrequency;
        _id_AC0E594AC96AA3A8++;
      }

      continue;
    }

    tablet tabletshow();
    _id_AC0E594AC96AA3A8++;
  }
}

delayedshowtablets(_id_294684D6A0DEEF46) {
  if(!isDefined(level.br_level)) {
    return;
  }
  _id_0046599DAB79A549 = level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_96878DA693689CCD", 4);
  _id_F5F66E7F9CB52C09 = getdvarfloat("dvar_743253D28CD0D1F7", 0.3);
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_0495D2ED937E965E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++) {
    tablet = _id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];
    tablet.circleindex = _id_2695A20D4011076D::getcircleindexforpoint(tablet.origin);

    if(tablet.circleindex >= 0)
      _id_0495D2ED937E965E[_id_0495D2ED937E965E.size] = tablet;
  }

  _id_294684D6A0DEEF46 = scripts\engine\utility::array_randomize(_id_0495D2ED937E965E);

  for(;;) {
    level waittill("br_circle_set");

    if(!level.br_circle.circleindex) {
      _id_715028F54BAD19A1::branalytics_delayedshowtablets(0, _id_F5F66E7F9CB52C09, _id_0495D2ED937E965E.size, 0);
      continue;
    }

    _id_0495D2ED937E965E = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_294684D6A0DEEF46.size; _id_AC0E594AC96AA3A8++) {
      tablet = _id_294684D6A0DEEF46[_id_AC0E594AC96AA3A8];

      if(tablet.circleindex >= level.br_circle.circleindex)
        _id_0495D2ED937E965E[_id_0495D2ED937E965E.size] = tablet;
    }

    _id_8FA722572853FFB7 = int(ceil(_id_0495D2ED937E965E.size * _id_F5F66E7F9CB52C09));
    _id_CF6DC40CA9D1B393 = int(max(0, getdvarint("dvar_6CD10C5D6E2A6220", 100) - level.questinfo.activetablets.size));
    _id_8FA722572853FFB7 = int(min(_id_8FA722572853FFB7, _id_CF6DC40CA9D1B393));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8FA722572853FFB7; _id_AC0E594AC96AA3A8++) {
      tablet = _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8];
      tablet tabletshow();
    }

    _id_294684D6A0DEEF46 = [];

    for(_id_AC0E594AC96AA3A8 = _id_8FA722572853FFB7; _id_AC0E594AC96AA3A8 < _id_0495D2ED937E965E.size; _id_AC0E594AC96AA3A8++)
      _id_294684D6A0DEEF46[_id_294684D6A0DEEF46.size] = _id_0495D2ED937E965E[_id_AC0E594AC96AA3A8];

    _id_715028F54BAD19A1::branalytics_delayedshowtablets(level.br_circle.circleindex, _id_F5F66E7F9CB52C09, _id_0495D2ED937E965E.size, _id_8FA722572853FFB7);

    if(level.br_circle.circleindex >= _id_0046599DAB79A549) {
      break;
    }
  }
}

disablealltablets() {
  foreach(type, info in level.questinfo.tabletinfo) {
    _id_E0D1E3A2B6F5323A = getlootscriptablearray(getlootname(type));

    if(info.enabled) {
      foreach(tablet in _id_E0D1E3A2B6F5323A)
      tablet tablethide();
    }
  }
}

tablethide() {
  thread _tablethide();
}

_tablethide() {
  self endon("show");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_7E52B56769FA7774::loothide(self);
}

tabletshow() {
  self notify("show");
  part = self.type;
  self setscriptablepartstate(part, "visible");
  level.questinfo.activetablets["" + self.index] = self;
  _id_715028F54BAD19A1::branalytics_spawntablet(self);
}

tabletinit(type) {
  if(isDefined(self.init)) {
    return;
  }
  self.init = 1;
  self.tablettype = type;
  tabletinit = level.questinfo.quests[type].funcs["tabletInit"];

  if(isDefined(tabletinit)) {
    self.init = self[[tabletinit]]();

    if(!self.init)
      _id_715028F54BAD19A1::branalytics_invalidtablet(self);
  }
}

onquesttablethide(instance) {
  if(isDefined(level.questinfo.activetablets["" + instance.index]))
    level.questinfo.activetablets["" + instance.index] = undefined;
}

_id_8E57889AC5DDA0BC(instance) {
  level.questinfo.activetablets["" + instance.index] = instance;
}

getlootname(category) {
  _id_A1093166DE09E6B8 = "brloot_" + category + "_tablet";

  if(getdvarint("mgl") != 0)
    _id_A1093166DE09E6B8 = _id_A1093166DE09E6B8 + "_mgl";

  return _id_A1093166DE09E6B8;
}

registerteamonquest(team, player) {
  _id_715028F54BAD19A1::branalytics_missionstart(self, player);
  level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, team);

  if(!isDefined(level.questinfo.maxperkbonustier))
    level.questinfo.maxperkbonustier = [];

  level.questinfo.maxperkbonustier[team] = getquestperkbonus(team, 1);
  level notify("quest_started", team);
}

releaseteamonquest(team) {
  if(isDefined(level.questinfo.maxperkbonustier))
    level.questinfo.maxperkbonustier[team] = undefined;

  level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, team);
  _id_89EDDDE3DA46BC8D = getquestrewardtier(team);
  results = [];

  if(isDefined(self.result) && self.result == "success") {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
        continue;
      }
      player.brmissionscompleted = _id_1E4A61DB11011446::get_int_or_0(player.brmissionscompleted) + 1;

      if(level._id_58ADCE74179AB9EF) {
        player scripts\mp\utility\stats::incpersstat("objectivesCompleted", 1);
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player scripts\mp\utility\stats::getpersstat("objectivesCompleted"));
      } else
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);

      player scripts\mp\utility\stats::incpersstat("contracts", 1);

      if(!isDefined(player.brmissiontypescompleted))
        player.brmissiontypescompleted = [];

      player.brmissiontypescompleted[self.questcategory] = _id_1E4A61DB11011446::get_int_or_0(player.brmissiontypescompleted[self.questcategory]) + 1;
      player _id_43828ADD0312B6BF::challengeevaluator("br_mastery_fiveContracts");
    }

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      results = givequestrewardsinstance(team, self.rewardorigin, self.rewardangles, self.rewardscriptable, self.contributingplayers);
  }

  if(isDefined(self.result)) {
    _id_A4BC9AD7065C48E9 = scripts\engine\utility::ter_op(self.result == "success", 1, 2);
    _id_1BBEB265EF74BC60 = self.category;

    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
        continue;
      }
      _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(self.category);
      player scripts\cp_mp\challenges::oncontractend(_id_591000CB6EF11522, _id_A4BC9AD7065C48E9 == 1, 1);
      player notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self.targetteam)) {
      _id_C0CBB1ECD0D11AFD = scripts\engine\utility::ter_op(self.result == "success", 2, 1);

      foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players")) {
        if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
          continue;
        }
        _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(self.category);
        player scripts\cp_mp\challenges::oncontractend(_id_591000CB6EF11522, _id_C0CBB1ECD0D11AFD == 1, 2);
      }
    }
  }

  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_EF08909F6CBF35FC = _id_A6AB8D0FDA441DC2.size;
  _id_715028F54BAD19A1::branalytics_missionend(self, _id_89EDDDE3DA46BC8D, results, _id_EF08909F6CBF35FC);
  self notify("questEnded");

  if(isDefined(self.rewardscriptable))
    self.rewardscriptable notify("questEnded", team, self.result);
}

startteamcontractchallenge(category, _id_A705A5A5884EBF9C, team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(category);
    player scripts\cp_mp\challenges::oncontractstart(_id_591000CB6EF11522, _id_A705A5A5884EBF9C);
  }
}

takequesttablet(instance) {
  if(getdvarint("dvar_82BDE055B11E6698", 0)) {
    switch (instance.type) {
      case "brloot_assassination_tablet_mgl":
        _id_110FD2130C2ED1FE::takequestitem(instance);
        break;
      case "brloot_domination_tablet_mgl":
        _id_404DF4D3A3B8CD80::takequestitem(instance);
        break;
      case "brloot_scavenger_tablet_mgl":
        _id_1C3DAC686AA675CC::takequestitem(instance);
        break;
      case "brloot_vip_tablet_mgl":
        _id_6388860E9E2A83BD::takequestitem(instance);
        break;
      case "brloot_timedrun_tablet_mgl":
        _id_6AB78610E79A4AEC::takequestitem(instance);
        break;
    }
  }

  _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;

  foreach(tablet in level.questinfo.activetablets) {
    if(distance2dsquared(_id_819EDACDACB810E4, tablet.origin) > _id_52D59C928EB97C81 * _id_52D59C928EB97C81) {
      _id_7E52B56769FA7774::loothide(tablet);
      _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
    }
  }

  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    if(isDefined(_id_12461E617D024EF9.funcs["circleTick"])) {
      foreach(instance in _id_12461E617D024EF9.instances)
      instance[[_id_12461E617D024EF9.funcs["circleTick"]]](_id_819EDACDACB810E4, _id_52D59C928EB97C81);
    }
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

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("missions"))
    enabled = 0;

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

registerinitquestvars(category, func) {
  _registerquestfunc(category, func, "initQuestVars");
  level.questinfo.quests[category].hasinitfunc = 1;
}

registerquestthink(category, func, thinkrate) {
  if(!isDefined(level.questinfo.quests[category].numthinkfuncs))
    level.questinfo.quests[category].numthinkfuncs = 0;

  _id_3D29D068E46CB221 = int(thinkrate * 20);
  level.questinfo.quests[category].thinkrates[level.questinfo.quests[category].numthinkfuncs] = _id_3D29D068E46CB221;
  _id_6B9F4C30D54F0F83 = "questThink" + level.questinfo.quests[category].numthinkfuncs;
  _registerquestfunc(category, func, _id_6B9F4C30D54F0F83);
  level.questinfo.quests[category].numthinkfuncs = level.questinfo.quests[category].numthinkfuncs + 1;
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

_clearregisters(category) {
  _id_1F8F4A275423B76C = [];
}

onplayerkilled(attacker, victim) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    if(isDefined(_id_12461E617D024EF9.funcs["onPlayerKilled"])) {
      foreach(instance in _id_12461E617D024EF9.instances)
      instance[[_id_12461E617D024EF9.funcs["onPlayerKilled"]]](attacker, victim);
    }
  }
}

onplayerconnect(player) {
  if(!isDefined(player.team) || !isDefined(level.questinfo)) {
    return;
  }
  setquestrewardtier(player.team, getquestrewardtier(player.team));
}

onplayerdisconnect(player) {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    if(isDefined(_id_12461E617D024EF9.funcs["onPlayerDisconnect"])) {
      foreach(instance in _id_12461E617D024EF9.instances)
      instance[[_id_12461E617D024EF9.funcs["onPlayerDisconnect"]]](player);
    }
  }
}

onplayerentergulag() {
  if(!isDefined(level.questinfo)) {
    return;
  }
  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    if(isDefined(_id_12461E617D024EF9.funcs["onEnterGulag"])) {
      foreach(instance in _id_12461E617D024EF9.instances)
      instance[[_id_12461E617D024EF9.funcs["onEnterGulag"]]](self);
    }
  }
}

onplayerrespawn() {
  if(!isDefined(level.questinfo)) {
    return;
  }
  self setclientomnvar("ui_player_spawned_notify", gettime());

  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    if(isDefined(_id_12461E617D024EF9.funcs["onRespawn"])) {
      foreach(instance in _id_12461E617D024EF9.instances)
      instance[[_id_12461E617D024EF9.funcs["onRespawn"]]](self);
    }
  }
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
      _id_6206D739138B8BE8 = getunusedlootcachepoints(_id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax, 0, 1);
      return _id_6206D739138B8BE8;
    case "questPointsArray":
      return getquestpoints(_id_354D1457278B342C.questtypes, _id_354D1457278B342C.searchcircleorigin, _id_354D1457278B342C.searchradiusmax, 0, 1);
    case "getKiosks":
      _id_86EEDE4334852D70 = _id_4384ABBF498DF6A7::getallspawninstances();
      _id_CED8A1F62AE2956B = [];

      foreach(_id_15B89FF206500554 in level.br_armory_kiosk.scriptables) {
        if(!istrue(_id_15B89FF206500554.disabled))
          _id_CED8A1F62AE2956B[_id_CED8A1F62AE2956B.size] = _id_15B89FF206500554;
      }

      return _id_CED8A1F62AE2956B;
    case "getInactiveHelipads":
      if(isDefined(level.br_plunder_sites)) {
        _id_B86AA807B6CF37E3 = _id_6AFF3948CF4CCA03::getplunderextractionsites();
        _id_680D985DDBBC9B72 = [];

        foreach(site in _id_B86AA807B6CF37E3) {
          if(istrue(site getscriptablepartstate(site.type) == "hidden"))
            _id_680D985DDBBC9B72[_id_680D985DDBBC9B72.size] = site;
        }

        if(_id_680D985DDBBC9B72.size == 0)
          return _id_B86AA807B6CF37E3;

        return _id_680D985DDBBC9B72;
      }
    default:
  }
}

_findnewlocaleplacement(_id_2AAB8569152EDFAC, _id_354D1457278B342C) {
  _id_2AAB8569152EDFAC = scripts\engine\utility::array_randomize(_id_2AAB8569152EDFAC);

  if(!isDefined(_id_354D1457278B342C.mintime))
    _id_354D1457278B342C.mintime = 0;

  if(!isDefined(_id_354D1457278B342C.travelspeed))
    _id_354D1457278B342C.travelspeed = 190;

  _id_EC522787BBCAAB24 = isDefined(_id_354D1457278B342C.searchradiusidealmax) && isDefined(_id_354D1457278B342C.searchradiusidealmin);

  if(istrue(_id_354D1457278B342C.searchforcecirclecenter))
    _id_F55F0723DFA08B99 = _id_2695A20D4011076D::getmintimetillpointindangercircle(_id_354D1457278B342C.searchcircleorigin);
  else
    _id_F55F0723DFA08B99 = 0;

  debug = spawnStruct();
  _id_02ED718E1DA0B965 = undefined;
  _id_BE0F4D48FA40793F = _id_354D1457278B342C.searchradiusmax;

  foreach(_id_AC0E594AC96AA3A8, loc in _id_2AAB8569152EDFAC) {
    dist = distance2d(loc.origin, _id_354D1457278B342C.searchcircleorigin);

    if(dist < _id_354D1457278B342C.searchradiusmin) {
      continue;
    }
    _id_CC748B6D457627FE = _id_2695A20D4011076D::getmintimetillpointindangercircle(loc.origin);

    if(!level.br_circle_disabled && _id_CC748B6D457627FE >= 0) {
      if(_id_CC748B6D457627FE < _id_F55F0723DFA08B99) {
        continue;
      }
      if(_id_354D1457278B342C.travelspeed > 0) {
        _id_42F65B4B53C1F5D4 = dist / _id_354D1457278B342C.travelspeed;
        _id_CC748B6D457627FE = _id_CC748B6D457627FE - _id_42F65B4B53C1F5D4;
      }

      if(_id_CC748B6D457627FE < _id_354D1457278B342C.mintime)
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
  if(!isDefined(level.questinfo) || !isDefined(level.questinfo.quests))
    return undefined;

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

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(_validateplayer(player, _id_18176E8F61BB2E83))
      return 1;
  }

  return 0;
}

isentireteamvalid(team, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(!_validateplayer(player, _id_18176E8F61BB2E83))
      return 0;
  }

  return 1;
}

getvalidplayersinteam(team, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);
  players = [];

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(_validateplayer(player, _id_18176E8F61BB2E83))
      players[players.size] = player;
  }

  return players;
}

getvalidplayersinarray(group, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _validateplayerfilter(_id_1F4E8B926C213A9A);
  players = [];

  foreach(player in group) {
    if(_validateplayer(player, _id_18176E8F61BB2E83))
      players[players.size] = player;
  }

  return players;
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

getteamcenter(team, _id_18176E8F61BB2E83) {
  center = (0, 0, 0);
  validplayers = getvalidplayersinteam(team, _id_18176E8F61BB2E83);

  if(validplayers.size <= 0)
    return center;

  foreach(player in validplayers)
  center = center + player.origin;

  center = center / validplayers.size;
  return center;
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

filtercondition_ingulag(player) {
  if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
    return 0;

  return 1;
}

filtercondition_hasbeeningulag(player) {
  if(isDefined(player.gulag))
    return 0;

  return 1;
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
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params);
}

displaysplashtoplayers(players, _id_E9AE765E2C4FE816, params) {
  foreach(player in players) {
    if(player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      continue;
    }
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
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
  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    return;
  }
  if(isDefined(params) && isDefined(params.packedbits))
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816, params.packedbits);
  else if(isDefined(params) && isDefined(params.intvar))
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816, params.intvar);
  else
    player thread scripts\mp\hud_message::showsplash(_id_E9AE765E2C4FE816);
}

displaysplashtoplayersinradius(_id_E9AE765E2C4FE816, origin, radius, _id_132557E1F59A234B, params) {
  _id_C17ED6DB14EBC007 = radius * radius;
  _id_BFC65A378A6D8EFE = [];

  foreach(player in level.players) {
    _id_AF833C45B0E3FCB3 = distancesquared(origin, player.origin);

    if(_id_AF833C45B0E3FCB3 > _id_C17ED6DB14EBC007) {
      continue;
    }
    if(isDefined(params.excludedteams) && scripts\engine\utility::array_contains(params.excludedteams, player.team)) {
      continue;
    }
    if(isDefined(params.excludedplayers) && scripts\engine\utility::array_contains(params.excludedplayers, player)) {
      continue;
    }
    if(!isplayervalid(player, _id_132557E1F59A234B)) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = player;
  }

  if(_id_BFC65A378A6D8EFE.size > 0) {
    foreach(player in _id_BFC65A378A6D8EFE)
    displayplayersplash(player, _id_E9AE765E2C4FE816, params);
  }
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
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

displaysquadmessagetoteam(team, _id_939B8E8818BFD5AE, state, missionid) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid);
}

giveplayerpoints(player, ref) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(ref);
}

giveteampoints(team, ref) {
  if(scripts\mp\utility\game::getsubgametype() == "champion") {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(ref);
}

calldropbag(player, location) {
  _id_B29198C6C1093A6B = _id_4D5A55FCA0ED1835::getdropbagspawntypeenum(0, 0, 0, 1, 0, 0);
  player _id_4D5A55FCA0ED1835::spawndropbagatposition(_id_B29198C6C1093A6B);
  level thread _id_4D5A55FCA0ED1835::managedropbags();
}

giveteamplunderflat(team, amount, _id_6463A610D995BAB9) {
  _id_8E3C5F90E4F80A58 = getdvarfloat("dvar_7165DAD703502609", 0.4);
  _id_2CEFA8F8A2BA6BFE = 0;

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    _id_36773A58EB035BFF = amount;

    if(!scripts\mp\utility\player::isreallyalive(player) && isDefined(_id_6463A610D995BAB9))
      _id_36773A58EB035BFF = int(amount * _id_8E3C5F90E4F80A58);

    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_36773A58EB035BFF);
    level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_36773A58EB035BFF;
    _id_715028F54BAD19A1::trackcashevent(player, "mission", _id_36773A58EB035BFF);
    player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_36773A58EB035BFF);
  }
}

giveteamplunderdistributive(players, amount) {
  _id_6EEBCDA719CD18A1 = int(amount / players.size);

  foreach(player in players) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    player _id_6AFF3948CF4CCA03::playerplunderpickup(_id_6EEBCDA719CD18A1);
    level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + _id_6EEBCDA719CD18A1;
    _id_715028F54BAD19A1::trackcashevent(player, "mission", _id_6EEBCDA719CD18A1);
    player _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(1, _id_6EEBCDA719CD18A1);
  }
}

dropplunder(amount, _id_5B7BF3433D244CDF, _id_76212928FED46301, _id_41271DE03A84A690) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_5C2AD86C68EAB7E9 = 0;
  _id_168EA84F2950FE38 = 1;
  _id_B590C41D9F9CE9F3 = 2;
  _id_82C3FC1E774A5A35[0] = ["brloot_plunder_cash_uncommon_3", level.br_plunder.quantityepic, getdvarfloat("dvar_53DD15287F7DF644", 0.2)];
  _id_82C3FC1E774A5A35[1] = ["brloot_plunder_cash_uncommon_2", level.br_plunder.quantityrare, getdvarfloat("dvar_8FA17586AC872DA9", 0.3)];
  _id_82C3FC1E774A5A35[2] = ["brloot_plunder_cash_uncommon_1", level.br_plunder.quantitycommon, getdvarfloat("dvar_30BF1DD438567DB0", 0.5)];
  _id_403ADFAFCE8E54AE = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    _id_403ADFAFCE8E54AE = _id_403ADFAFCE8E54AE + info[_id_B590C41D9F9CE9F3];
  }

  plundertotal = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    info[_id_B590C41D9F9CE9F3] = info[_id_B590C41D9F9CE9F3] / _id_403ADFAFCE8E54AE;
    plundertotal = plundertotal + info[_id_168EA84F2950FE38] * info[_id_B590C41D9F9CE9F3];
  }

  _id_0CE1BD3FDF0FCECF = amount / plundertotal;
  _id_F278EB5EB7F1E8BE = amount;
  _id_C75B43B86B00CB9D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
    info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
    _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] = int(_id_0CE1BD3FDF0FCECF * info[_id_B590C41D9F9CE9F3]);
    _id_F278EB5EB7F1E8BE = _id_F278EB5EB7F1E8BE - _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] * info[_id_168EA84F2950FE38];
  }

  if(_id_F278EB5EB7F1E8BE > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_82C3FC1E774A5A35.size; _id_AC0E594AC96AA3A8++) {
      info = _id_82C3FC1E774A5A35[_id_AC0E594AC96AA3A8];
      extra = int(_id_F278EB5EB7F1E8BE / info[_id_168EA84F2950FE38]);
      _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] = _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8] + extra;
      _id_F278EB5EB7F1E8BE = _id_F278EB5EB7F1E8BE - extra * info[_id_168EA84F2950FE38];
    }
  }

  _id_1473580AC7CFA299 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C75B43B86B00CB9D.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_C75B43B86B00CB9D[_id_AC0E594AC96AA3A8]; _id_AC0E5C4AC96AAA41++)
      _id_1473580AC7CFA299[_id_1473580AC7CFA299.size] = _id_AC0E594AC96AA3A8;
  }

  _id_1473580AC7CFA299 = scripts\engine\utility::array_randomize(_id_1473580AC7CFA299);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1473580AC7CFA299.size; _id_AC0E594AC96AA3A8++) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_5B7BF3433D244CDF, _id_76212928FED46301, _id_41271DE03A84A690);
    _id_7E52B56769FA7774::spawnpickup(_id_82C3FC1E774A5A35[_id_1473580AC7CFA299[_id_AC0E594AC96AA3A8]][_id_5C2AD86C68EAB7E9], _id_CB4FAD49263E20C4, _id_82C3FC1E774A5A35[_id_1473580AC7CFA299[_id_AC0E594AC96AA3A8]][_id_168EA84F2950FE38], 1);
  }

  level.br_plunder.plunder_awarded_by_missions_total = level.br_plunder.plunder_awarded_by_missions_total + amount;
  level thread _id_6AFF3948CF4CCA03::dropplundersounds(_id_5B7BF3433D244CDF, _id_1473580AC7CFA299.size);
}

getquestindex(ref) {
  return level.questinfo.tablevalues[ref].index;
}

getquesttableindex(ref) {
  index = int(tablelookup("mp/brmissions.csv", 1, ref, 0));
  return index;
}

uiobjectiveshow(ref) {
  index = getquestindex(ref);
  setquestindexomnvar(index);
}

uiobjectiveshowtoteam(ref, team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player uiobjectiveshow(ref);
}

uiobjectivehide() {
  setquestindexomnvar(0);
}

uiobjectivehidefromteam(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player uiobjectivehide();
}

uiobjectivesetparameter(value) {
  self setclientomnvar("ui_br_objective_param", value);
}

uiobjectivesetlootid(value) {
  self setclientomnvar("ui_br_objective_loot_id", value);
}

createquestobjicon(_id_CB8E582431CF1641, state, _id_38116998DF9814D4) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, state, (0, 0, 0), _id_CB8E582431CF1641);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      objective_removeallfrommask(self.objectiveiconid);

    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(_id_38116998DF9814D4))
      movequestobjicon(_id_38116998DF9814D4);
  } else {}
}

movequestobjicon(_id_A9706ADAF7C52E27) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, _id_A9706ADAF7C52E27);
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
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

utilflare_shootflare(spawn_origin, _id_1DA50610F94E1BFB) {
  level endon("game_ended");
  _id_3E146ED5E207E635 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  new_position = scripts\engine\trace::ray_trace(spawn_origin + (0, 0, 4000), spawn_origin, undefined, _id_3E146ED5E207E635, undefined, 1)["position"];
  flare = spawn("script_model", new_position);

  if(!isDefined(flare)) {
    return;
  }
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

  if(!_id_935C70547A6790A9.usequesttimer) {
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
  foreach(player in scripts\mp\utility\teams::getteamdata(self.id, "players"))
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

_id_8ACF00B423DCA1E6() {
  if(getdvarint("dvar_82BDE055B11E6698", 0))
    return level.questinfo;
  else
    return level._id_41F4BC9EE8C7C9C6;
}

givequestrewardsinstance(team, rewardorigin, rewardangles, rewardscriptable, players) {
  if(!isDefined(players))
    players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.missionparticipation))
      player.missionparticipation = 1;
    else
      player.missionparticipation++;

    player _id_6AFF3948CF4CCA03::packextrascore0();
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

  if(!isDefined(players))
    players = scripts\mp\utility\teams::getteamdata(team, "players");

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
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("giveQuestReward")) {
    [_id_0AF8D4CC519C65DE, value] = _id_362C58E8BB39BCDA::_id_D72AF9CCEDFC923B("giveQuestReward", type, value, team, rewardorigin, rewardangles, rewardscriptable, players);

    if(_id_0AF8D4CC519C65DE)
      return value;
  }

  switch (type) {
    case "plunder":
      if(istrue(level.br_plunder_enabled)) {
        participantplunder = isDefined(rewardscriptable) && istrue(rewardscriptable.participantplunder);

        if(getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk" && !participantplunder)
          giveteamplunderflat(team, value);
        else if(players.size > 0) {
          if(!scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E() && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
            giveteamplunderflat(team, value, 1);
          else
            giveteamplunderdistributive(players, value);
        } else
          value = 0;
      } else
        value = 0;

      break;
    case "xp":
      if(isDefined(rewardscriptable) && istrue(rewardscriptable.participantxp))
        _id_2329E2336D8412BC = players;
      else
        _id_2329E2336D8412BC = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in _id_2329E2336D8412BC) {
        player thread scripts\mp\events::killeventtextpopup("stat_607CD099425B81C7", 0);
        player scripts\mp\rank::giverankxp("stat_607CD099425B81C7", value, undefined, undefined, undefined, 1);
        _id_CC603E175ABFEF2D = int(value * 0.2);
        lastweaponobj = player.lastnormalweaponobj;
        player _id_1E4A61DB11011446::givebrweaponxp("stat_0000000000000000", _id_CC603E175ABFEF2D, lastweaponobj, 0, 0);
        player.br_contractxpearned = _id_1E4A61DB11011446::get_int_or_0(player.br_contractxpearned) + value;
      }

      break;
    case "weapon_xp":
      if(isDefined(rewardscriptable) && istrue(rewardscriptable.participantweaponxp))
        _id_2329E2336D8412BC = players;
      else
        _id_2329E2336D8412BC = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in _id_2329E2336D8412BC) {
        lastweaponobj = player.lastnormalweaponobj;
        player _id_1E4A61DB11011446::givebrweaponxp("stat_0000000000000000", value, lastweaponobj, 0, 0);
      }

      break;
    case "loot_table":
      if(getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk") {
        items = getscriptablelootcachecontents(rewardscriptable, value);
        questrewarddropitems(team, items, rewardorigin, rewardangles, 0);
      }

      break;
    case "loot_cache":
      items = getscriptablelootcachecontents(rewardscriptable, value);
      questrewarddropitems(team, items, rewardorigin, rewardangles, 1);
      break;
    case "loot_items":
      items = strtok(value, " ");
      questrewarddropitems(team, items, rewardorigin, rewardangles, 0);
      break;
    case "drop_bag":
      _id_736D8D9188CCBD45 = scripts\mp\utility\teams::getteamdata(team, "players")[0];
      calldropbag(_id_736D8D9188CCBD45, rewardorigin);
      break;
    case "circle_peek":
      questrewardcirclepeek(team);
      break;
    case "reward_tier":
      thread addquestrewardtierframeend(team, value);
      break;
    case "blueprint_chance":
      if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
        _id_21D8D4C91A02F62D = _id_6A297C1028F46524::blueprintextract_trygetreward(rewardorigin);

        if(isDefined(_id_21D8D4C91A02F62D)) {
          _id_6A297C1028F46524::blueprintextract_beforepickupspawned(team);
          items = [_id_21D8D4C91A02F62D];
          questrewarddropitems(team, items, rewardorigin, rewardangles, 0);
          displayteamsplash(team, "br_blueprint_extract_quest_spawned");
        }
      }

      break;
    case "uav":
      _id_5935FE3B4986AFA2 = getclosestplayerforreward(team, players, rewardorigin);

      if(isDefined(_id_5935FE3B4986AFA2))
        _id_5935FE3B4986AFA2 thread questrewarduav(value);

      break;
    case "fire_sale":
      _id_62471111AE6A1489(team, players, rewardorigin);
      break;
    case "juggernaut":
      dropcircle = spawnStruct();
      dropcircle.origin = rewardorigin;
      dropcircle.dropradius = 300;
      dropcircle.nodropanim = 1;
      level thread _id_29C32B7117E01180::dropdeliveryatpos(dropcircle, "quest_reward");
      break;
    case "none":
      break;
    default:
      break;
  }

  return value;
}

getclosestplayerforreward(team, players, rewardorigin) {
  if(isDefined(players) && players.size > 0)
    _id_AFC2F18CDAA6C9CC = players;
  else
    _id_AFC2F18CDAA6C9CC = scripts\mp\utility\teams::getteamdata(team, "players");

  closestplayer = undefined;
  _id_14F2E41BC5CED509 = undefined;

  foreach(player in _id_AFC2F18CDAA6C9CC) {
    dist = distance2d(player.origin, rewardorigin);

    if(!isDefined(_id_14F2E41BC5CED509) || dist < _id_14F2E41BC5CED509) {
      _id_14F2E41BC5CED509 = dist;
      closestplayer = player;
    }
  }

  return closestplayer;
}

setupcirclepeek() {
  if(istrue(level.br_circle_disabled) || istrue(level.br_level.staticcircle)) {
    return;
  }
  level.circlepeeks = [];
  level.teamswithcirclepeek = [];

  for(index = 1; index < level.br_level.br_circleradii.size; index++) {
    circleradius = level.br_level.br_circleradii[index];
    circleorigin = level.br_level.br_circlecenters[index];
    level.circlepeeks[index] = spawnStruct();
    level.circlepeeks[index] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("PeekCircle_Br", circleorigin, circleradius);
    level.circlepeeks[index] scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  }

  level thread circlepeekcleanup();
}

circlepeekcleanup() {
  self endon("game_ended");
  level endon("CirclePeekCleanup");

  for(;;) {
    level waittill("br_circle_set");
    level.circlepeeks[level.br_circle.circleindex + 1] scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

    foreach(team in getarraykeys(level.teamswithcirclepeek)) {
      level.teamswithcirclepeek[team]--;

      if(level.teamswithcirclepeek[team] < 0)
        level.teamswithcirclepeek[team] = 0;
    }
  }
}

questrewardcirclepeek(team) {
  if(getdvarint("dvar_82BDE055B11E6698", 0)) {
    if(istrue(level.br_circle_disabled)) {
      return;
    }
    if(!isDefined(level.teamswithcirclepeek[team]))
      level.teamswithcirclepeek[team] = 0;

    level.teamswithcirclepeek[team]++;
    index = level.teamswithcirclepeek[team] + level.br_circle.circleindex + 1;

    if(!isDefined(level.circlepeeks[index])) {
      foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
      player scripts\mp\utility\lower_message::setlowermessageomnvar("circle_peek_limit", undefined, 5);

      return;
    }

    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
    level.circlepeeks[index] scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  } else
    _id_5238DEE479BBF7FB::_id_647A8C40104E4866(team);
}

_id_D282041688C032B5(category) {
  _id_1BBEB265EF74BC60 = tablelookup("mp/brmissions.csv", 1, category, 18);
  _id_723B8F7CB71CEB11 = tablelookup("mp/br_contracts.csv", 0, _id_1BBEB265EF74BC60, 3);

  if(!isDefined(_id_723B8F7CB71CEB11) || _id_723B8F7CB71CEB11 == "")
    return 0;

  return int(_id_723B8F7CB71CEB11);
}

getquesttablerewardgroup(category) {
  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  group = _id_2EDAB15F93691DE8.rewards.categorytogroup[category];

  if(!isDefined(group)) {
    group = tablelookup("mp/brmissions.csv", 1, category, 7);
    _id_2EDAB15F93691DE8.rewards.categorytogroup[category] = group;
  }

  return group;
}

getquestrewardgroupstablerewards(group) {
  _id_4C90CB0F1E0CD03A = getquestrewardsgrouptable();
  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  rewards = _id_2EDAB15F93691DE8.rewards.grouptorewards[group];

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

    _id_2EDAB15F93691DE8.rewards.grouptorewards[group] = rewards;
  }

  return rewards;
}

getquestrewardstabletype(reward) {
  _id_8519CE2870B094D2 = _id_29C4F14EE8C99D3F();

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_8519CE2870B094D2 = "mp/brmission_rewards_dmz.csv";

  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  type = _id_2EDAB15F93691DE8.rewards.rewardtotype[reward];

  if(!isDefined(type)) {
    type = tablelookup(_id_8519CE2870B094D2, 0, reward, 1);
    _id_2EDAB15F93691DE8.rewards.rewardtotype[reward] = type;
  }

  return type;
}

getquestrewardstablevalue(_id_EA0DDAE1258E9ACF) {
  _id_8519CE2870B094D2 = _id_29C4F14EE8C99D3F();

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "risk")
    _id_8519CE2870B094D2 = "mp/brmission_rewards_dmz.csv";

  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  value = _id_2EDAB15F93691DE8.rewards.rewardtovalue[_id_EA0DDAE1258E9ACF];

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
    _id_2EDAB15F93691DE8.rewards.rewardtovalue[_id_EA0DDAE1258E9ACF] = value;
  }

  _id_5954E45EE18B578D = getdvarint("dvar_82BDE055B11E6698", 0) && issubstr(_id_EA0DDAE1258E9ACF, "loot_cache");

  if(istrue(level.bmoovertime) && !isstring(value) && !_id_5954E45EE18B578D)
    value = int(value * level.overtimecashmultiplier);

  if(_id_337BD370F7C5E6F9::ispubliceventoftypeactive(15) && !isstring(value) && !_id_5954E45EE18B578D)
    value = int(value * level.br_pe_data[15]._id_046A451F9012BD1C);

  return value;
}

getquestrewardstablevaluecolumnindex() {
  _id_0774C9CA5D1D6221 = level.maxteamsize;

  if(_id_2CEDCC356F1B9FC8::istutorial())
    _id_0774C9CA5D1D6221 = 1;

  switch (_id_0774C9CA5D1D6221) {
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
  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  info = _id_2EDAB15F93691DE8.rewards.scalertoscaleinfo[ref];

  if(!isDefined(info)) {
    info = [];
    _id_33F38025CF1BB801 = 1;
    _id_8201E3609F801081 = 2;

    for(;;) {
      tier = tablelookup("mp/brmission_reward_scalers.csv", 0, ref, _id_33F38025CF1BB801);

      if(tier == "") {
        break;
      }

      tier = int(tier);
      _id_B7AB28868F552DF5 = float(tablelookup("mp/brmission_reward_scalers.csv", 0, ref, _id_8201E3609F801081));
      info[tier] = _id_B7AB28868F552DF5;
      _id_33F38025CF1BB801 = _id_33F38025CF1BB801 + 2;
      _id_8201E3609F801081 = _id_8201E3609F801081 + 2;
    }

    _id_2EDAB15F93691DE8.rewards.scalertoscaleinfo[ref] = info;
  }

  return info;
}

getquestplunderrewardinstance(tier) {
  return getquestplunderreward(self.questcategory, tier, self.modifier, self.rewardmodifier);
}

getquestxprewardinstance(tier) {
  return getquestxpreward(self.questcategory, tier, self.modifier, self.rewardmodifier);
}

getquestweaponxprewardinstance(tier) {
  return getquestweaponxpreward(self.questcategory, tier, self.modifier, self.rewardmodifier);
}

getquestplunderreward(category, tier, _id_7D42B5952D47067C, rewardmodifier) {
  if(!level.br_plunder_enabled)
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

getquestperkbonus(team, _id_DE16A768392AEEA5) {
  if(!isDefined(_id_DE16A768392AEEA5))
    _id_DE16A768392AEEA5 = 0;

  _id_F6426590C29D7AB0 = 0;

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(istrue(player.hasbettermissionrewards))
      _id_F6426590C29D7AB0++;
  }

  if(!_id_DE16A768392AEEA5 && isDefined(level.questinfo.maxperkbonustier) && isDefined(level.questinfo.maxperkbonustier[team]))
    _id_F6426590C29D7AB0 = int(min(_id_F6426590C29D7AB0, level.questinfo.maxperkbonustier[team]));

  return _id_F6426590C29D7AB0;
}

questrewarddropitems(team, items, origin, angles, _id_A6293F3144240B99, _id_3BBE1192172D43FD, _id_77BD0639072486AC) {
  if(!isDefined(items)) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = spawnStruct();
  _id_CB4FAD49263E20C4.origin = origin;
  _id_CB4FAD49263E20C4.angles = angles;
  _id_CB4FAD49263E20C4.itemsdropped = 0;

  if(isDefined(level.currentrewarddropindex))
    _id_CB4FAD49263E20C4.itemsdropped = level.currentrewarddropindex;

  _id_605079299D001231 = _id_CB4FAD49263E20C4 _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, items, _id_A6293F3144240B99, undefined, _id_3BBE1192172D43FD, _id_77BD0639072486AC);

  foreach(item in _id_605079299D001231)
  item.team = team;

  if(isDefined(level.currentrewarddropindex))
    level.currentrewarddropindex = _id_CB4FAD49263E20C4.itemsdropped;
}

questrewarduav(uavtype) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(uavtype, self);
  streakinfo.skipequippedstreakcheck = 1;
  scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct(streakinfo);
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
    case "drop_bag":
    case "loot_table":
    case "loot_cache":
    case "circle_peek":
    case "reward_tier":
    case "weapon_xp":
    case "xp":
    case "plunder":
    case "juggernaut":
    case "none":
      return "int";
    case "fire_sale":
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
  _id_4C90CB0F1E0CD03A = getDvar("dvar_85BA512AED5CE540", "mp/brmission_reward_groups.csv");

  if(_id_4C90CB0F1E0CD03A == "")
    _id_4C90CB0F1E0CD03A = "mp/brmission_reward_groups.csv";

  return _id_4C90CB0F1E0CD03A;
}

_id_29C4F14EE8C99D3F() {
  _id_122320381EA5BBE9 = getDvar("br_mission_reward_filename", "mp/brmission_rewards.csv");

  if(_id_122320381EA5BBE9 == "")
    return "mp/brmission_rewards.csv";

  return _id_122320381EA5BBE9;
}

getquestrewardgroupindex(group) {
  _id_4C90CB0F1E0CD03A = getquestrewardsgrouptable();
  return int(tablelookup(_id_4C90CB0F1E0CD03A, 0, group, 1));
}

_id_0004F93B5D0C1953(team, players, rewardorigin) {
  _id_86EEDE4334852D70 = level.br_armory_kiosk.scriptables;
  _id_CED8A1F62AE2956B = [];

  if(!isDefined(_id_86EEDE4334852D70) || _id_86EEDE4334852D70.size == 0) {
    return;
  }
  foreach(_id_15B89FF206500554 in _id_86EEDE4334852D70) {
    if(!istrue(_id_15B89FF206500554.disabled))
      _id_CED8A1F62AE2956B[_id_CED8A1F62AE2956B.size] = _id_15B89FF206500554;
  }

  locations = scripts\engine\utility::array_randomize(_id_CED8A1F62AE2956B);
  _id_1D1479E278AB33DB = undefined;
  _id_00BF97AF9158BCF3 = undefined;

  foreach(_id_15B89FF206500554 in locations) {
    _id_556B31282ABCB132 = distance2d(_id_15B89FF206500554.origin, rewardorigin);

    if(!isDefined(_id_00BF97AF9158BCF3) || _id_00BF97AF9158BCF3 > _id_556B31282ABCB132) {
      _id_00BF97AF9158BCF3 = _id_556B31282ABCB132;
      _id_1D1479E278AB33DB = _id_15B89FF206500554;
    }
  }

  return _id_1D1479E278AB33DB;
}

_id_62471111AE6A1489(team, players, rewardorigin) {
  _id_15B89FF206500554 = _id_0004F93B5D0C1953(team, players, rewardorigin);

  if(!isDefined(_id_15B89FF206500554)) {
    return;
  }
  foreach(player in players) {
    if(isDefined(player) && !istrue(player.br_iseliminated))
      _id_4384ABBF498DF6A7::kiosksetupfiresaleforplayer(_id_15B89FF206500554, player);
  }
}

getquestrewardtier(team) {
  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  tier = _id_2EDAB15F93691DE8.tiers[team];

  if(!isDefined(tier))
    tier = 1;

  return tier;
}

setquestrewardtier(team, tier) {
  _id_2EDAB15F93691DE8 = _id_8ACF00B423DCA1E6();
  _id_2EDAB15F93691DE8.tiers[team] = tier;
  setquestrewardtierteamomnvar(team, tier);
}

addquestrewardtier(team, value) {
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

addquestrewardtierframeend(team, value) {
  waittillframeend;
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

setquestindexteamomnvar(team, _id_5E9B1036A4CAE82F) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player setquestindexomnvar(_id_5E9B1036A4CAE82F);
}

setquestindexomnvar(_id_5E9B1036A4CAE82F) {
  self setclientomnvar("ui_br_objective_index", _id_5E9B1036A4CAE82F);
}

setquestrewardtierteamomnvar(team, tier) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
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
      if(isquestinstancealocale(instance)) {
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
        case "history":
          break;
        case "x1stash":
          break;
        case "x1fin":
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

getquestunlockableindexfromlootid(lootid) {
  _id_A03D4FE1F134DB01 = level.questinfo.unlockables[lootid];

  if(!isDefined(_id_A03D4FE1F134DB01))
    return 0;

  return _id_A03D4FE1F134DB01.unlockableindex;
}

getrandomextractunlockablelootid() {
  _id_0DB4D4D3DCAE5375 = 0;

  foreach(_id_A03D4FE1F134DB01 in level.questinfo.unlockables)
  _id_0DB4D4D3DCAE5375 = _id_0DB4D4D3DCAE5375 + _id_A03D4FE1F134DB01.extractunlockablechance;

  _id_D80612AE080F4B21 = randomfloatrange(0, _id_0DB4D4D3DCAE5375);
  _id_B4F3205E2A8C0862 = 0;

  foreach(_id_A03D4FE1F134DB01 in level.questinfo.unlockables) {
    _id_B4F3205E2A8C0862 = _id_B4F3205E2A8C0862 + _id_A03D4FE1F134DB01.extractunlockablechance;

    if(_id_D80612AE080F4B21 <= _id_B4F3205E2A8C0862)
      return _id_A03D4FE1F134DB01.lootid;
  }

  return level.questinfo.unlockables[0].lootid;
}