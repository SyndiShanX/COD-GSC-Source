/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_58639610b96bfaa6.gsc
***********************************************/

init() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_radioactive_object_1", ::_id_5BC57C3A339EBA95);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_radioactive_object_2", ::_id_5BC57C3A339EBA95);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_radioactive_object_3", ::_id_5BC57C3A339EBA95);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_secret_stash", ::_id_5BC57C3A339EBA95);
}

_id_8A49992A2E6901E6(_id_EFA8EF05B190D7D0, _id_6756BD882736E8BC, _id_276AC5E84835EA87, _id_40DBDB41F33299F7) {
  if(!isDefined(_id_6756BD882736E8BC))
    _id_6756BD882736E8BC = 1;

  if(!isDefined(_id_40DBDB41F33299F7))
    _id_40DBDB41F33299F7 = 0;

  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_A41A8966906F798D;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_A6FF88151CF5542B;
  _id_B8EBE3F71A08AB40.ref = scripts\engine\utility::ter_op(isDefined(_id_276AC5E84835EA87), "dmz_fortress_search_bads", "dmz_search_bads");
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40._id_6756BD882736E8BC = _id_6756BD882736E8BC;
  _id_B8EBE3F71A08AB40._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  _id_B8EBE3F71A08AB40._id_40DBDB41F33299F7 = _id_40DBDB41F33299F7;
  _id_EFA8EF05B190D7D0._id_75DED47B03386E57 = 1;
  return _id_B8EBE3F71A08AB40;
}

_id_A41A8966906F798D(_id_FABF84450735DD93) {
  level._id_D648ED8ECA1DFB3C = spawnStruct();
  level._id_D648ED8ECA1DFB3C._id_B8EBE3F71A08AB40 = self;
  _id_27F9050017807D8A();
  _id_5982D93EA6BD26CD();
}

_id_5D8BEE83697787CC() {
  return level._id_D648ED8ECA1DFB3C._id_B8EBE3F71A08AB40;
}

_id_4B0B660ECAB607E6() {
  return scripts\mp\utility\teams::getteamdata(_id_5D8BEE83697787CC().team, "players");
}

_id_A6FF88151CF5542B(_id_FABF84450735DD93) {
  locations = undefined;
  locations = scripts\engine\utility::getStructArray("intel_loc", "targetname");
  self._id_8C956C79A693924E = locations.size;
  self._id_1AE1BE9CA33B1A87 = 0;
  self._id_4DBF4CABDBCEDF5B = [];

  foreach(location in locations) {
    _id_187E63A5CF6D992A = _id_111EC726EAA1CE68(location);
    _id_67E00B8D4251C284(_id_187E63A5CF6D992A.origin, _id_187E63A5CF6D992A.angles, _id_FABF84450735DD93, self, self._id_40DBDB41F33299F7, _id_187E63A5CF6D992A.script_noteworthy);
  }

  _id_F934392AA6995070 = _id_56F0FE0080C4F01E();
  _id_E2DB801FC08BBFCA(_id_F934392AA6995070, _id_FABF84450735DD93);
  scripts\mp\utility\dialog::leaderdialog("dmz_mission_search_assigned", _id_FABF84450735DD93);

  foreach(index, circle in self._id_B0F4BF8621B96C0A)
  circle thread _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(circle.mapcircle.origin + (0, 0, 500));
}

_id_E2DB801FC08BBFCA(_id_F934392AA6995070, _id_FABF84450735DD93) {
  foreach(index, _id_532EC2CD26095DA3 in _id_F934392AA6995070) {
    _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Explore_Dmz", [_id_532EC2CD26095DA3.origin], 1500, _id_FABF84450735DD93);
    self._id_4DBF4CABDBCEDF5B[_id_532EC2CD26095DA3.script_noteworthy] = self._id_B0F4BF8621B96C0A[index];
  }
}

_id_56F0FE0080C4F01E(_id_7F0F9AD360500E73) {
  _id_9E4E1482CB40C9C5 = [];

  foreach(location in scripts\engine\utility::getStructArray("objective_location", "targetname")) {
    if(istrue(_id_7F0F9AD360500E73))
      location.origin = location.origin + scripts\engine\utility::_id_6174330574A2A273() * 200;

    _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = location;
  }

  return _id_9E4E1482CB40C9C5;
}

_id_C15EF1BB5DD116A0(_id_FABF84450735DD93) {
  if(isDefined(self._id_276AC5E84835EA87))
    _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  else {
    foreach(index, circle in self._id_B0F4BF8621B96C0A)
    circle _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

    _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_search_complete", _id_FABF84450735DD93);
  }

  scripts\common\create_script_utility::cleanup_cs_file_objects("mp_dmz_hydro_bads_create_script");
}

_id_5BC57C3A339EBA95(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if((part == "dmz_radioactive_object_1" || part == "dmz_radioactive_object_2" || part == "dmz_radioactive_object_3") && state == "usable") {
    _id_CF54F4DE9E8D2608(instance, player);
    _id_BB50FB4B09B7F165(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
    instance setscriptablepartstate(part, "unusable");
  }
}

_id_CF54F4DE9E8D2608(instance, player) {
  if(!isDefined(instance._id_B8EBE3F71A08AB40)) {
    return;
  }
  _id_B8EBE3F71A08AB40 = instance._id_B8EBE3F71A08AB40;

  if(isDefined(_id_B8EBE3F71A08AB40.teams) && scripts\engine\utility::array_contains(_id_B8EBE3F71A08AB40.teams, player.team)) {
    _id_479E458F6F530F0D::_id_A67007B5AF86FF0B(instance);
    _id_B8EBE3F71A08AB40 _id_EC727A26A8B9DB8F();
    _id_B8EBE3F71A08AB40 _id_DB7E4AB290B642C1(instance, player.team);

    if(_id_B8EBE3F71A08AB40 _id_3710F7EB08295551()) {
      if(isDefined(_id_B8EBE3F71A08AB40._id_AA1ED8F12D71A7A5.next))
        _id_B8EBE3F71A08AB40._id_AA1ED8F12D71A7A5.next.instance = instance;

      _id_C15EF1BB5DD116A0(player.team);
      _id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    }
  }
}

_id_DB7E4AB290B642C1(instance, _id_FABF84450735DD93) {
  foreach(_id_CF1F227589F2ACDA, circle in self._id_4DBF4CABDBCEDF5B) {
    if(_id_CF1F227589F2ACDA == instance._id_72D392767C3B7B23)
      circle _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  }
}

_id_EC727A26A8B9DB8F() {
  self._id_1AE1BE9CA33B1A87++;
}

_id_3710F7EB08295551() {
  return self._id_8C956C79A693924E == self._id_1AE1BE9CA33B1A87;
}

_id_BB50FB4B09B7F165(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_60291DFCE2923372();
}

_id_B9BEB2BB0E6B4941(_id_F41C9D9347D0911A) {
  switch (_id_F41C9D9347D0911A) {
    case "a":
      return "dmz_radioactive_object_1";
    case "b":
      return "dmz_radioactive_object_2";
    case "c":
      return "dmz_radioactive_object_3";
    default:
      return "dmz_radioactive_object_3";
  }
}

_id_67E00B8D4251C284(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6, _id_FABF84450735DD93, _id_B8EBE3F71A08AB40, _id_40DBDB41F33299F7, _id_F41C9D9347D0911A) {
  _id_B038ED928EC17A81 = undefined;
  _id_7E05C139FBBD8374 = _id_7E05C139FBBD8374 + anglestoright(_id_5B9C864B21207FF6) * -10;
  _id_5B9C864B21207FF6 = (_id_5B9C864B21207FF6[0], _id_5B9C864B21207FF6[1] + 180, _id_5B9C864B21207FF6[2]);
  _id_91839BABD32261F4 = _id_B9BEB2BB0E6B4941(_id_F41C9D9347D0911A);
  _id_B038ED928EC17A81 = spawnscriptable(_id_91839BABD32261F4, _id_7E05C139FBBD8374, _id_5B9C864B21207FF6);
  _id_479E458F6F530F0D::_id_F0D61E14DFDE9CCD(_id_B038ED928EC17A81);
  playerlist = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_7F599ACCB72658D1 = playerlist[0];
  _id_B038ED928EC17A81._id_FABF84450735DD93 = _id_FABF84450735DD93;
  _id_B038ED928EC17A81._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  _id_B038ED928EC17A81._id_72D392767C3B7B23 = _id_F41C9D9347D0911A;
  _id_B038ED928EC17A81._id_534E0CF170A981B7 = ::_id_CF54F4DE9E8D2608;
  _id_B038ED928EC17A81.contents = [];
  _id_B038ED928EC17A81.contents[0]["quantity"] = randomintrange(50, 84);
  _id_B038ED928EC17A81.contents[0]["lootID"] = 8395;
  _id_B038ED928EC17A81.contents[1]["quantity"] = randomintrange(50, 85);
  _id_B038ED928EC17A81.contents[1]["lootID"] = 8395;
  _id_B038ED928EC17A81.contents[2]["quantity"] = randomintrange(50, 84);
  _id_B038ED928EC17A81.contents[2]["lootID"] = 8395;
  _id_B038ED928EC17A81.contents[3]["quantity"] = 1;
  _id_B038ED928EC17A81.contents[3]["lootID"] = 549;
  _id_B038ED928EC17A81.contents[4]["quantity"] = 1;
  _id_B038ED928EC17A81.contents[4]["lootID"] = 9230;
  _id_B038ED928EC17A81.contents[5]["quantity"] = 1;
  _id_B038ED928EC17A81.contents[5]["lootID"] = 9224;
  _id_B038ED928EC17A81.contents = scripts\engine\utility::array_randomize(_id_B038ED928EC17A81.contents);

  foreach(player in level.players) {
    if(player != _id_7F599ACCB72658D1 && (_id_7F599ACCB72658D1.team == "none" || player.team != _id_7F599ACCB72658D1.team))
      _id_B038ED928EC17A81 disablescriptableplayeruse(player);
  }
}

_id_111EC726EAA1CE68(parentstruct) {
  struct = undefined;

  if(isDefined(parentstruct.target)) {
    _id_0BAE65FF0227A539 = scripts\engine\utility::getStructArray(parentstruct.target, "targetname");
    _id_97F1BD927537DDFD = getdvarint("dvar_EB2F6D009F65CB77", 1);

    switch (_id_97F1BD927537DDFD) {
      case 1:
        struct = scripts\engine\utility::random(_id_0BAE65FF0227A539);
        break;
      case 2:
        struct = _id_AE7F38910A49197E("a", _id_0BAE65FF0227A539);
        break;
      case 3:
        struct = _id_AE7F38910A49197E("b", _id_0BAE65FF0227A539);
        break;
      case 4:
        struct = _id_AE7F38910A49197E("c", _id_0BAE65FF0227A539);
        break;
    }
  }

  return struct;
}

_id_AE7F38910A49197E(script_noteworthy, array) {
  foreach(interactionstruct in array) {
    if(interactionstruct.script_noteworthy == script_noteworthy)
      return interactionstruct;
  }

  return undefined;
}

_id_27F9050017807D8A() {
  level._id_A3A9959B0A31F7BC = spawnStruct();
  level._id_A3A9959B0A31F7BC._id_7B274724A9E5FAEC = 1;
  level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2 = [];
  level._id_A3A9959B0A31F7BC._id_106A0C25C537A585 = "";
  _id_D6DA0DD209B341C9(::_id_880A372A0FA8755D, 1);
  _id_D6DA0DD209B341C9(::_id_880A372A0FA8755D, 2);
  _id_D6DA0DD209B341C9(::_id_880A372A0FA8755D, 3);
}

_id_9691DFEF872DD7E4() {
  return getdvarint("dvar_2967FDD4515A6756", level._id_A3A9959B0A31F7BC._id_7B274724A9E5FAEC);
}

_id_880A372A0FA8755D() {}

_id_D6DA0DD209B341C9(function, _id_D2B4BF70079CBEDE) {
  level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2["escalation_" + _id_D2B4BF70079CBEDE] = function;
}

_id_60291DFCE2923372() {
  level._id_A3A9959B0A31F7BC._id_7B274724A9E5FAEC++;

  if(level._id_A3A9959B0A31F7BC._id_7B274724A9E5FAEC > 3)
    level._id_A3A9959B0A31F7BC._id_7B274724A9E5FAEC = 3;

  _id_7B274724A9E5FAEC = _id_9691DFEF872DD7E4();
  thread[[level._id_A3A9959B0A31F7BC._id_E830EBCF792A5EF2["escalation_" + _id_7B274724A9E5FAEC]]]();
}

_id_07A888A38FCE76E9(_id_EB7B7D47D5339C45, objname) {
  spawn_group = "";

  if(isDefined(_id_EB7B7D47D5339C45) && isstring(_id_EB7B7D47D5339C45))
    spawn_group = _id_EB7B7D47D5339C45 + "_" + _id_9691DFEF872DD7E4();
  else {
    if(getdvarint("dvar_E410C11BCB9D47E6", 0) == _id_9691DFEF872DD7E4())
      return "";

    if(objname == "stealth_a")
      spawn_group = "spawner_obj_a_exterior_reinforcement_" + _id_9691DFEF872DD7E4();
    else if(objname == "stealth_b")
      spawn_group = "spawner_obj_b_exterior_reinforcement_" + _id_9691DFEF872DD7E4();
    else if(objname == "stealth_c")
      spawn_group = "spawner_obj_c_exterior_reinforcement_" + _id_9691DFEF872DD7E4();
    else
      spawn_group = "exfil_exterior_reinforcement_" + _id_9691DFEF872DD7E4();
  }

  return spawn_group;
}

_id_3645D8AEE174AFB3(spawngroup, objname) {
  agents = [];
  _id_AA2B4ADF749CCBEE = [];
  _id_EB096A9D4E8A54D2 = _id_07A888A38FCE76E9(spawngroup, objname);

  if(!isDefined(_id_EB096A9D4E8A54D2) || _id_EB096A9D4E8A54D2 == "") {
    return;
  }
  _id_3A64877D8DDFDD1C = _id_43AE814062C7741B(_id_EB096A9D4E8A54D2);

  foreach(_id_756A07C77406000B in _id_3A64877D8DDFDD1C) {
    _id_92DB85C8DCF21152 = _id_00471352520E6468(_id_756A07C77406000B);
    _id_AA2B4ADF749CCBEE[_id_AA2B4ADF749CCBEE.size] = _id_92DB85C8DCF21152;
  }

  foreach(_id_756A07C77406000B in _id_AA2B4ADF749CCBEE) {
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_756A07C77406000B.script_noteworthy, _id_756A07C77406000B.origin, _id_756A07C77406000B.angles, "high", "mission", "badSituation");
    agent.group = _id_756A07C77406000B;
    agent.group.group_name = _id_756A07C77406000B.targetname;
    agent.spawnpoint = _id_756A07C77406000B;
    agent thread _id_09648829771FB344(_id_756A07C77406000B);
    agent.spawnpoint = _id_756A07C77406000B;
    agents[agents.size] = agent;
  }
}

_id_43AE814062C7741B(spawngroup) {
  _id_4CC7F98C522A7843 = scripts\engine\utility::getStructArray(spawngroup, "targetname");
  return _id_4CC7F98C522A7843;
}

_id_00471352520E6468(struct) {
  _id_1EAB94309F7B587E = undefined;
  aitype = struct.script_noteworthy;

  switch (aitype) {
    case "shotgun":
      struct.script_noteworthy = "enemy_mp_dmz_base_shotgun";
      break;
    case "sniper":
      struct.script_noteworthy = "enemy_mp_dmz_base_sniper";
      break;
    case "lmg":
      struct.script_noteworthy = "enemy_mp_dmz_base_lmg";
      break;
    case "smg":
      struct.script_noteworthy = "enemy_mp_dmz_base_smg";
      break;
    case "ar_laser":
    case "ar":
      struct.script_noteworthy = "enemy_mp_dmz_base_ar";
      break;
    case "juggernaut":
      struct.script_noteworthy = "enemy_mp_dmz_base_ar";
      break;
    default:
      struct.script_noteworthy = "enemy_mp_dmz_base_ar";
      break;
  }

  _id_1EAB94309F7B587E = struct;
  return _id_1EAB94309F7B587E;
}

_id_09648829771FB344(_id_AC7930C851FE41C2) {
  _id_05ADD58433814DBC(_id_AC7930C851FE41C2);
}

_id_5982D93EA6BD26CD() {
  level._id_8332A0D90935D5E8 = [];
  level._id_8332A0D90935D5E8["stealth_a"] = 0;
  level._id_8332A0D90935D5E8["stealth_b"] = 0;
  level._id_8332A0D90935D5E8["stealth_c"] = 0;
  level._id_8332A0D90935D5E8["exfil_area"] = 0;
  level._id_A359CB3E2BFA1964 = [];
  level._id_9EEAB63C54988C55 = [];
  level._id_359C318944444B78 = [];
  level._id_A359CB3E2BFA1964["stealth_a"] = 0;
  level._id_9EEAB63C54988C55["stealth_a"] = 0;
  level._id_359C318944444B78["stealth_a"] = 0;
  level._id_A359CB3E2BFA1964["stealth_b"] = 0;
  level._id_9EEAB63C54988C55["stealth_b"] = 0;
  level._id_359C318944444B78["stealth_b"] = 0;
  level._id_A359CB3E2BFA1964["stealth_c"] = 0;
  level._id_9EEAB63C54988C55["stealth_c"] = 0;
  level._id_359C318944444B78["stealth_c"] = 0;
  level._id_359C318944444B78["exfil_area"] = 0;
  _id_E26037E34403828D();
  level thread _id_73A70E82F50954FA();
}

_id_E26037E34403828D() {
  level.ambientgroups = [];
  _id_94A20F1E012AE23B("bs_exfil_stealth_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("bs_exfil_stealth_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("bs_exfil_stealth_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_1", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_2", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_3", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_vehicle_1", ::_id_2B1D55F8D82CEF07);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_vehicle_2", ::_id_2B1D55F8D82CEF07);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_vehicle_3", ::_id_2B1D55F8D82CEF07);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_vehicle_4", ::_id_2B1D55F8D82CEF07);
  _id_94A20F1E012AE23B("exfil_exterior_reinforcement_vehicle_5", ::_id_2B1D55F8D82CEF07);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_smg_1", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_smg_2", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_smg_3", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_2_smg_1", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_2_smg_2", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_interior_2_smg_3", ::_id_1B3E1D52186F7026);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_roof_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_roof_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_roof_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_patrol_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_patrol_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_patrol_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_reinforcement_1", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_reinforcement_2", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_b_exterior_reinforcement_3", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_1", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_2", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_3", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_smg_1", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_smg_2", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("spawner_obj_b_ambush_smg_3", ::_id_2D5B628E330541CB);
  _id_94A20F1E012AE23B("techo_patroller_b", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("techo_patroller_a", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_1", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_2", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_3", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_smg_1", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_smg_2", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_upstairs_smg_3", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_smg_1", ::_id_1B3E1C52186F6DF3);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_smg_2", ::_id_1B3E1C52186F6DF3);
  _id_94A20F1E012AE23B("spawner_obj_a_interior_smg_3", ::_id_1B3E1C52186F6DF3);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_roof_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_roof_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_patrol_roof_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_reinforcement_1", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_reinforcement_2", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_a_exterior_reinforcement_3", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_a_upstairs_ambush_1", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_upstairs_ambush_2", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("spawner_obj_a_upstairs_ambush_3", ::_id_08855B1BA1FE3E2C);
  _id_94A20F1E012AE23B("techo_patroller_c", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_patrol_1", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_patrol_2", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_patrol_3", ::_id_50418629D296C51D);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_upstairs_1", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_upstairs_2", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_upstairs_3", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_1", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_2", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_interior_3", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_upstairs_ambush_1", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_upstairs_ambush_2", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_upstairs_ambush_3", ::_id_08855D1BA1FE4292);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_reinforcement_1", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_reinforcement_2", ::_id_F2D1DFD7A8CE1EC3);
  _id_94A20F1E012AE23B("spawner_obj_c_exterior_reinforcement_3", ::_id_F2D1DFD7A8CE1EC3);
}

_id_C5793C2004AFCBCC(group_name, func) {
  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    self.ignoreall = 1;

  self.sightmaxdistance = 1000;
  self laseron();
  self.maxfacenewenemydist = 4000;
}

_id_FFD832F03F6EBB80() {
  players = _id_4B0B660ECAB607E6();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++)
    self getenemyinfo(players[_id_AC0E594AC96AA3A8]);
}

_id_2B1D55F8D82CEF07(group_name, func) {
  if(scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("dog"))
    thread _id_45A008CA8959297F();

  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_53004420672F13FA();
  self.stealth.funcs["event_investigate"] = ::_id_62615FDC150BAA1A;
  self.stealth.funcs["event_cover_blown"] = ::_id_62615FDC150BAA1A;
  self.stealth.funcs["event_combat"] = ::_id_62615FDC150BAA1A;
}

_id_1B3E1D52186F7026(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_877AB7A7D5ED8172();
  self.stealth.funcs["event_investigate"] = ::_id_BC28E12F0C1C8364;
  self.stealth.funcs["event_cover_blown"] = ::_id_BC28E12F0C1C8364;
  self.stealth.funcs["event_combat"] = ::_id_BC28E12F0C1C8364;

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");
    _id_FFD832F03F6EBB80();
    self.goalradius = 300;
    self.dont_enter_combat = 1;
    self.script_combatmode = "ambush";
    self.combatmode = self.script_combatmode;
    scripts\common\ai::find_and_teleport_to_cover();
  } else {
    if(_id_DCF52ED792CD5571()) {
      if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
        return;
      }
      self[[self.fnsetstealthstate]]("hunt");
    }

    self.goalradius = 300;
    self.dont_enter_combat = 1;
    self.script_combatmode = "ambush";
    self.combatmode = self.script_combatmode;
    scripts\common\ai::find_and_teleport_to_cover();
  }

  thread _id_B558B6DBCA1A6491();
}

_id_877AB7A7D5ED8172() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    objname = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.script), "stealth_container");
    _id_E61AF03C9E384F0F = 0;
    _id_E7758D1CEF59FBF6 = 0;
    _id_E4189F6142F280F1 = 0;
    _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
    _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
    _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");

    if(self istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(self istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(self istouching(_id_867B6418DD3354E1))
      _id_94A36A51659A7A2E = 1;

    if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1) {
      _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

      if(!isDefined(_id_C837AD627899C30C)) {
        continue;
      }
      objname = _id_C837AD627899C30C.script_noteworthy;
    } else {
      if(_id_E61AF03C9E384F0F)
        objname = "stealth_a";

      if(_id_E7758D1CEF59FBF6)
        objname = "stealth_b";

      if(_id_E4189F6142F280F1)
        objname = "stealth_c";
    }

    if(objname == "stealth_a")
      thread _id_3D5706B7F6E25709("downstairs", 0.1, "stealth_a");

    if(objname == "stealth_b")
      thread _id_3D5706B7F6E25709("downstairs", 0.1, "stealth_b");

    if(objname == "stealth_c")
      thread _id_3D5706B7F6E25709("downstairs", 0.1, "stealth_c");
  }
}

_id_DCF52ED792CD5571() {
  _id_CD5E9D1ECB0BCBD3 = "";
  players = _id_4B0B660ECAB607E6();

  foreach(player in players) {
    _id_CD5E9D1ECB0BCBD3 = _id_3A45F1C5E142D0F3(player);

    switch (_id_CD5E9D1ECB0BCBD3) {
      case "stealth_a":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "stealth_b":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "stealth_c":
        if(level._id_A359CB3E2BFA1964[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_9EEAB63C54988C55[_id_CD5E9D1ECB0BCBD3] < 1 && level._id_359C318944444B78[_id_CD5E9D1ECB0BCBD3] < 1)
          return 0;

        break;
      case "exfil_area":
        break;
      default:
        break;
    }
  }

  return 1;
}

_id_3A45F1C5E142D0F3(player) {
  _id_E61AF03C9E384F0F = 0;
  _id_E7758D1CEF59FBF6 = 0;
  _id_E4189F6142F280F1 = 0;
  _id_2795910EA142BEBD = 0;
  _id_5EAD7CD5BD2A23C3 = getEnt("interior_ai_spawn_trigger_objA", "targetname");
  _id_046CF58102043E30 = getEnt("interior_ai_spawn_trigger_objB", "targetname");
  _id_867B6418DD3354E1 = getEnt("interior_ai_spawn_trigger_objC", "targetname");
  _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");

  if(isDefined(player.recondronesuper)) {
    if(player.recondronesuper istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(player.recondronesuper istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(player.recondronesuper istouching(_id_867B6418DD3354E1))
      _id_E4189F6142F280F1 = 1;

    if(player.recondronesuper istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;
  }

  if(isDefined(player.vehicle)) {
    if(player.vehicle istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(player.vehicle istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(player.vehicle istouching(_id_867B6418DD3354E1))
      _id_E4189F6142F280F1 = 1;

    if(player.vehicle istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;
  }

  if(player istouching(_id_5EAD7CD5BD2A23C3))
    _id_E61AF03C9E384F0F = 1;

  if(player istouching(_id_046CF58102043E30))
    _id_E7758D1CEF59FBF6 = 1;

  if(player istouching(_id_867B6418DD3354E1))
    _id_E4189F6142F280F1 = 1;

  if(player istouching(_id_A5AE61DD930BF2A5))
    _id_2795910EA142BEBD = 1;

  if(_id_E61AF03C9E384F0F)
    return "stealth_a";

  if(_id_E7758D1CEF59FBF6)
    return "stealth_b";

  if(_id_E4189F6142F280F1)
    return "stealth_c";

  if(_id_2795910EA142BEBD)
    return "exfil_area";

  return "";
}

_id_B558B6DBCA1A6491() {
  self endon("death");
  _id_7B64EABBDC923F61 = ["footstep", "footstep_walk", "silenced_shot", "seek_backup", "window_open"];

  for(;;) {
    self waittill("ai_events", events);

    if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }
    if(self.ignoreall || self isragdoll()) {
      continue;
    }
    foreach(event in events) {
      if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.type)) {
        continue;
      }
      self.script_combatmode = "cover";
      self.combatmode = self.script_combatmode;
      return;
    }
  }
}

_id_08855D1BA1FE4292(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_948291BD95F7C96A("stealth_c");
  self.stealth.funcs["event_investigate"] = ::_id_7EBC4AE7009F4C41;
  self.stealth.funcs["event_cover_blown"] = ::_id_7EBC4AE7009F4C41;
  self.stealth.funcs["event_combat"] = ::_id_7EBC4AE7009F4C41;
  self.goalradius = 64;
  self setgoalpos(self.origin);

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");
    _id_FFD832F03F6EBB80();
  } else if(_id_DCF52ED792CD5571()) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_F2D1DFD7A8CE1EC3(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);

  if(scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("juggernaut")) {
    self.ballowexecutions = 1;
    return;
  }

  _id_52B755330EF9AF41(group_name);

  if(issubstr(self.group.group_name, "vehicle")) {
    thread _id_53004420672F13FA();
    thread scripts\mp\movers::player_unresolved_collision_watch();
    self.stealth.funcs["event_investigate"] = ::_id_62615FDC150BAA1A;
    self.stealth.funcs["event_cover_blown"] = ::_id_62615FDC150BAA1A;
    self.stealth.funcs["event_combat"] = ::_id_62615FDC150BAA1A;
    self.maxfacenewenemydist = 4000;
  }

  if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
    return;
  }
  self[[self.fnsetstealthstate]]("hunt");
}

_id_53004420672F13FA() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    objname = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.script), "stealth_container");
    _id_E61AF03C9E384F0F = 0;
    _id_E7758D1CEF59FBF6 = 0;
    _id_E4189F6142F280F1 = 0;
    _id_2795910EA142BEBD = 0;
    _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
    _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
    _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");
    _id_A5AE61DD930BF2A5 = getEnt("exfil_area", "script_noteworthy");

    if(self istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(self istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(self istouching(_id_867B6418DD3354E1))
      _id_94A36A51659A7A2E = 1;

    if(self istouching(_id_A5AE61DD930BF2A5))
      _id_2795910EA142BEBD = 1;

    if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1 && !_id_2795910EA142BEBD) {
      _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

      if(!isDefined(_id_C837AD627899C30C)) {
        continue;
      }
      objname = _id_C837AD627899C30C.script_noteworthy;
    } else {
      if(_id_E61AF03C9E384F0F)
        objname = "stealth_a";

      if(_id_E7758D1CEF59FBF6)
        objname = "stealth_b";

      if(_id_E4189F6142F280F1)
        objname = "stealth_c";

      if(_id_2795910EA142BEBD)
        objname = "exfil_area";
    }

    if(objname == "stealth_a")
      thread _id_3D5706B7F6E25709("exterior", 0.05, "stealth_a");

    if(objname == "stealth_b")
      thread _id_3D5706B7F6E25709("exterior", 0.05, "stealth_b");

    if(objname == "stealth_c")
      thread _id_3D5706B7F6E25709("exterior", 0.05, "stealth_c");

    if(objname == "exfil_area")
      thread _id_3D5706B7F6E25709("exterior", 0.05, "exfil_area");

    level._id_26678298A0072160 = 1;
  }
}

_id_3D5706B7F6E25709(region, delay, obj) {
  wait(delay);

  switch (region) {
    case "exterior":
      level._id_359C318944444B78[obj]++;
      break;
    case "downstairs":
      level._id_A359CB3E2BFA1964[obj]++;
      break;
    case "upstairs":
      level._id_9EEAB63C54988C55[obj]++;
      break;
  }
}

_id_1B3E1C52186F6DF3(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_877AB7A7D5ED8172();
  self.stealth.funcs["event_investigate"] = ::_id_C9B04B362B0B8B88;
  self.stealth.funcs["event_cover_blown"] = ::_id_C9B04B362B0B8B88;
  self.stealth.funcs["event_combat"] = ::_id_C9B04B362B0B8B88;

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");
    _id_FFD832F03F6EBB80();
  } else if(_id_DCF52ED792CD5571()) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_08855B1BA1FE3E2C(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_948291BD95F7C96A("stealth_a");
  self.stealth.funcs["event_investigate"] = ::_id_7EBC4AE7009F4C41;
  self.stealth.funcs["event_cover_blown"] = ::_id_7EBC4AE7009F4C41;
  self.stealth.funcs["event_combat"] = ::_id_7EBC4AE7009F4C41;
  self.goalradius = 16;
  self setgoalpos(self.origin);

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");
    _id_FFD832F03F6EBB80();
  } else if(_id_DCF52ED792CD5571()) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_2D5B628E330541CB(group_name, func) {
  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_877AB7A7D5ED8172();
  self.stealth.funcs["event_investigate"] = ::_id_BC28E12F0C1C8364;
  self.stealth.funcs["event_cover_blown"] = ::_id_BC28E12F0C1C8364;
  self.stealth.funcs["event_combat"] = ::_id_BC28E12F0C1C8364;

  if(_func_EAC0CD99C9C6D8EE() == "spotted") {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("combat");
    _id_FFD832F03F6EBB80();
  } else if(_id_DCF52ED792CD5571()) {
    if(self[[self.fnisinstealthcombat]]() || self[[self.fnisinstealthhunt]]()) {
      return;
    }
    self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_50418629D296C51D(group_name, func) {
  if(scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("dog"))
    thread _id_45A008CA8959297F();

  _id_C5793C2004AFCBCC(group_name, func);
  thread _id_53004420672F13FA();
  self.stealth.funcs["event_investigate"] = ::_id_62615FDC150BAA1A;
  self.stealth.funcs["event_cover_blown"] = ::_id_62615FDC150BAA1A;
  self.stealth.funcs["event_combat"] = ::_id_62615FDC150BAA1A;
  self.maxfacenewenemydist = 4000;
}

_id_45A008CA8959297F() {
  self endon("death");

  for(;;) {
    message = scripts\engine\utility::waittill_any_return_3("stealth_investigate", "stealth_combat", "stealth_idle");

    switch (message) {
      case "stealth_investigate":
        break;
      case "stealth_combat":
        self.soundent scripts\engine\utility::playsoundonentity("anml_dog_growl", "dog_growl");
        break;
      case "stealth_idle":
        break;
    }
  }
}

_id_948291BD95F7C96A(_id_C78FD6612D780DA3) {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    objname = getDvar(_func_2EF675C13CA1C4AF("dvar_287B3B75F2C14FE9", level.script), "stealth_container");
    _id_E61AF03C9E384F0F = 0;
    _id_E7758D1CEF59FBF6 = 0;
    _id_E4189F6142F280F1 = 0;
    _id_5EAD7CD5BD2A23C3 = getEnt("stealth_a", "script_noteworthy");
    _id_046CF58102043E30 = getEnt("stealth_b", "script_noteworthy");
    _id_867B6418DD3354E1 = getEnt("stealth_c", "script_noteworthy");

    if(self istouching(_id_5EAD7CD5BD2A23C3))
      _id_E61AF03C9E384F0F = 1;

    if(self istouching(_id_046CF58102043E30))
      _id_E7758D1CEF59FBF6 = 1;

    if(self istouching(_id_867B6418DD3354E1))
      _id_94A36A51659A7A2E = 1;

    if(!_id_E61AF03C9E384F0F && !_id_E7758D1CEF59FBF6 && !_id_E4189F6142F280F1) {
      _id_C837AD627899C30C = scripts\engine\utility::getclosest(self.origin, getEntArray("objective_trigger", "targetname"));

      if(!isDefined(_id_C837AD627899C30C)) {
        continue;
      }
      objname = _id_C837AD627899C30C.script_noteworthy;
    } else {
      if(_id_E61AF03C9E384F0F)
        objname = "stealth_a";

      if(_id_E7758D1CEF59FBF6)
        objname = "stealth_b";

      if(_id_E4189F6142F280F1)
        objname = "stealth_c";
    }

    if(isDefined(_id_C78FD6612D780DA3)) {
      level thread _id_3D5706B7F6E25709("upstairs", 0.05, _id_C78FD6612D780DA3);
      continue;
    }

    if(objname == "stealth_a")
      level thread _id_3D5706B7F6E25709("upstairs", 0.05, "stealth_a");

    if(objname == "stealth_b")
      level thread _id_3D5706B7F6E25709("upstairs", 0.05, "stealth_b");

    if(objname == "stealth_c")
      level thread _id_3D5706B7F6E25709("upstairs", 0.05, "stealth_c");

    level._id_D02CC581558B702B = 1;
  }
}

_id_52B755330EF9AF41(group) {
  if(scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("juggernaut") || scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("dog")) {
    if(scripts\mp\agents\agent_utility::_id_7956DFD1302CDDFF("dog"))
      thread _id_45A008CA8959297F();

    return;
  }

  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sm_uzulu_mp", ["thermal_west01", "none", "none", "none", "silencer_uzulu", "laserrange_smg"], "none", "none");
  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  _id_F9FA10E07F13F5FD = self.spawner.script_noteworthy;

  switch (_id_F9FA10E07F13F5FD) {
    case "shotgun":
      body = "body_mp_eastern_nikto_2_1";
      head = "head_mp_eastern_nikto_3_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sh_dpapa12_mp", ["none", "none", "none", "muzzlemelee_dpapa12", "caldb_dpapa12", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_mp_eastern_azur_8_1";
      head = "head_mp_eastern_azur_8_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sn_alpha50_mp", ["vzscope_alpha50", "laserbalancedsnpr", "pistolgrip02_alpha50", "xmags_alpha50", "barlong_alpha50"], "none", "none");
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "lmg":
      body = "body_mp_eastern_velikan_1_1";
      head = "head_mp_eastern_velikan_1_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_lm_mgolf36_mp", ["thermal_west01", "none", "none", "none", "none", "none"], "none", "none");
      _id_A664AAD02EE98BD2 = "semtex_mp";
      break;
    case "smg":
      body = "body_mp_eastern_rodion_7_1";
      head = "head_mp_eastern_rodion_7_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_sm_uzulu_mp", ["thermal_west01", "none", "none", "none", "silencer_uzulu", "laserrange_smg"], "none", "none");
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    case "ar_laser":
    case "ar":
      body = "body_mp_western_milsim_jw_grom_1_1";
      head = "head_mp_western_milsim_jw_grom_1_1";
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_ar_mike4_mp", ["thermal_west01", "none", "none", "none", "silencer_west01", "laserbalanced_mike4"], "none", "none");
      _id_A664AAD02EE98BD2 = "flash_mp";
      break;
    default:
      break;
  }

  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  _id_08D7211588560DD1(body, head, weapon, _id_A664AAD02EE98BD2);
}

_id_08D7211588560DD1(body, head, weapon, _id_A664AAD02EE98BD2) {
  self setModel(body);

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach(head, "", 1);
  self.headmodel = head;
  self.allowpain = 0;
  self.equip_armor = 1;
  self.armorhealth = 840;
  self.goalradius = 2048;

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = weapon;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  thread _id_31CE456A217691D0();
}

_id_31CE456A217691D0() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      _id_6C8ECA00EBAC031C(objweapon);

    self waittill("weapon_change");
  }
}

_id_6C8ECA00EBAC031C(objweapon) {
  scripts\mp\weapons::updatelauncherusage();
}

_id_94A20F1E012AE23B(group_name, func, _id_FABF84450735DD93) {
  if(!isDefined(level.ambientgroups[group_name]))
    level.ambientgroups[group_name] = spawnStruct();

  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8]._id_51AB71B549B8E798))
          level.ambientgroups[group_name][_id_AC0E594AC96AA3A8]._id_51AB71B549B8E798 = [];

        if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].team))
          level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].team = _id_FABF84450735DD93;

        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8]._id_51AB71B549B8E798[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8]._id_51AB71B549B8E798.size] = func;
      }
    } else {
      if(!isDefined(level.ambientgroups[group_name]._id_51AB71B549B8E798))
        level.ambientgroups[group_name]._id_51AB71B549B8E798 = [];

      if(!isDefined(level.ambientgroups[group_name].team))
        level.ambientgroups[group_name].team = _id_FABF84450735DD93;

      level.ambientgroups[group_name]._id_51AB71B549B8E798[level.ambientgroups[group_name]._id_51AB71B549B8E798.size] = func;
    }
  }
}

_id_DC3E57164F1A2EB9(group_name) {
  if(isDefined(level.ambientgroups[group_name]))
    return 1;

  return 0;
}

_id_05ADD58433814DBC(_id_AC7930C851FE41C2) {
  if(_id_DC3E57164F1A2EB9(_id_AC7930C851FE41C2.targetname)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[_id_AC7930C851FE41C2.targetname]._id_51AB71B549B8E798.size; _id_AC0E594AC96AA3A8++)
      thread _id_0420E3F1DB78AAC7(level.ambientgroups[_id_AC7930C851FE41C2.targetname], level.ambientgroups[_id_AC7930C851FE41C2.targetname]._id_51AB71B549B8E798[_id_AC0E594AC96AA3A8], undefined, self);
  }

  if(isDefined(_id_AC7930C851FE41C2._id_51AB71B549B8E798)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AC7930C851FE41C2._id_51AB71B549B8E798.size; _id_AC0E594AC96AA3A8++)
      thread _id_0420E3F1DB78AAC7(_id_AC7930C851FE41C2, _id_AC7930C851FE41C2._id_51AB71B549B8E798[_id_AC0E594AC96AA3A8], undefined, self);
  }
}

_id_0420E3F1DB78AAC7(group, _id_06B5C8034010B9BA, _id_4E62F8D216C2816B, _id_A9C4D551B42AF0FB) {
  level endon("game_ended");
  group endon("death");
  self endon("var_param_race_timeout");

  if(!isDefined(_id_06B5C8034010B9BA))
    return "empty";

  _id_43E4442D6EA9B20D = _id_06B5C8034010B9BA;

  if(isstring(_id_06B5C8034010B9BA))
    return _id_06B5C8034010B9BA;
  else if(_id_33B2F6BD50628C64(_id_06B5C8034010B9BA))
    return _id_06B5C8034010B9BA;
  else if(isarray(_id_06B5C8034010B9BA)) {
    if(isarray(_id_06B5C8034010B9BA[0])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_06B5C8034010B9BA.size; _id_AC0E594AC96AA3A8++)
        _id_43E4442D6EA9B20D = _id_0420E3F1DB78AAC7(group, _id_06B5C8034010B9BA[_id_AC0E594AC96AA3A8], _id_4E62F8D216C2816B);
    } else if(isfunction(_id_06B5C8034010B9BA[0])) {
      func = _id_06B5C8034010B9BA[0];
      var_params = [];
      _id_8A69877EF3D6E5CA = _id_91FA2F936230F998(group, _id_06B5C8034010B9BA);
      _id_43E4442D6EA9B20D = group _id_31B0F98A06DA6B4F(func, _id_8A69877EF3D6E5CA, _id_A9C4D551B42AF0FB);
    } else
      _id_43E4442D6EA9B20D = _id_06B5C8034010B9BA;
  } else if(isfunction(_id_06B5C8034010B9BA)) {
    if(istrue(_id_4E62F8D216C2816B))
      return _id_06B5C8034010B9BA;
    else
      _id_43E4442D6EA9B20D = [[_id_06B5C8034010B9BA]](group);
  }

  return _id_43E4442D6EA9B20D;
}

_id_33B2F6BD50628C64(param1) {
  if(isDefined(param1) && isnumber(param1) && param1 > 0)
    return 1;
  else
    return 0;
}

_id_91FA2F936230F998(group, _id_06B5C8034010B9BA) {
  var_params = [];

  if(_id_06B5C8034010B9BA.size < 2)
    return var_params;
  else {
    _id_8A69877EF3D6E5CA = spawnStruct();
    _id_8A69877EF3D6E5CA.var_params = [];
    _id_BAE8297148C7F7E8 = min(_id_06B5C8034010B9BA.size, 9);

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_BAE8297148C7F7E8; _id_AC0E594AC96AA3A8++) {
      _id_5B6F016C0007CA2C = _id_06B5C8034010B9BA[_id_AC0E594AC96AA3A8];
      _id_8A69877EF3D6E5CA thread _id_DF50D8FCD21E9646("var_param_race_timeout");
      _id_8A69877EF3D6E5CA.var_params[_id_AC0E594AC96AA3A8 - 1] = _id_8A69877EF3D6E5CA _id_0420E3F1DB78AAC7(group, _id_5B6F016C0007CA2C, 1);
    }
  }

  return _id_8A69877EF3D6E5CA;
}

_id_DF50D8FCD21E9646(_id_7239F8830EF22B43) {
  self endon("death");
  waittillframeend;
  self notify(_id_7239F8830EF22B43);
}

_id_31B0F98A06DA6B4F(func, params, _id_A9C4D551B42AF0FB) {
  if(isDefined(_id_A9C4D551B42AF0FB))
    _id_84DAE085357E37AD = _id_A9C4D551B42AF0FB;
  else
    _id_84DAE085357E37AD = self;

  if(!isDefined(params.var_params))
    return _id_84DAE085357E37AD[[func]](self);
  else if(params.var_params.size == 1)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]));
  else if(params.var_params.size == 2)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]));
  else if(params.var_params.size == 3)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]));
  else if(params.var_params.size == 4)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]), _id_86FDCC8C2D170E42(params.var_params[3]));
  else if(params.var_params.size == 5)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]), _id_86FDCC8C2D170E42(params.var_params[3]), _id_86FDCC8C2D170E42(params.var_params[4]));
  else if(params.var_params.size == 6)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]), _id_86FDCC8C2D170E42(params.var_params[3]), _id_86FDCC8C2D170E42(params.var_params[4]), _id_86FDCC8C2D170E42(params.var_params[5]));
  else if(params.var_params.size == 7)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]), _id_86FDCC8C2D170E42(params.var_params[3]), _id_86FDCC8C2D170E42(params.var_params[4]), _id_86FDCC8C2D170E42(params.var_params[5]), _id_86FDCC8C2D170E42(params.var_params[6]));
  else if(params.var_params.size == 8)
    return _id_84DAE085357E37AD[[func]](self, _id_86FDCC8C2D170E42(params.var_params[0]), _id_86FDCC8C2D170E42(params.var_params[1]), _id_86FDCC8C2D170E42(params.var_params[2]), _id_86FDCC8C2D170E42(params.var_params[3]), _id_86FDCC8C2D170E42(params.var_params[4]), _id_86FDCC8C2D170E42(params.var_params[5]), _id_86FDCC8C2D170E42(params.var_params[6]), _id_86FDCC8C2D170E42(params.var_params[7]));
  else
    return undefined;
}

_id_86FDCC8C2D170E42(_id_06B5C8034010B9BA) {
  if(isDefined(_id_06B5C8034010B9BA)) {
    if(isstring(_id_06B5C8034010B9BA) && _id_06B5C8034010B9BA == "empty")
      return undefined;
    else
      return _id_06B5C8034010B9BA;
  } else
    return undefined;
}

_id_73A70E82F50954FA() {
  _id_08FB1722D1B30262 = getEntArray("objective_trigger", "targetname");

  foreach(trigger in _id_08FB1722D1B30262)
  trigger thread _id_BD500B5E688CCE2C();
}

_id_BD500B5E688CCE2C() {
  self notify("_dmzTask_watchForTriggerEntered");
  self endon("_dmzTask_watchForTriggerEntered");
  self endon("death");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objective = self.script_noteworthy;

    switch (objective) {
      case "stealth_a":
        thread _id_1537C5052A90679C();
        break;
      case "stealth_b":
        thread _id_23191A0B3361E1B1();
        break;
      case "stealth_c":
        thread _id_FD6C72301C76F7A2();
        break;
      case "exfil_area":
        break;
    }
  }
}

_id_1537C5052A90679C() {
  if(istrue(level._id_C60247DAEC61ED67)) {
    return;
  }
  level._id_C60247DAEC61ED67 = 1;
  _id_3645D8AEE174AFB3("spawner_obj_a_exterior", "stealth_container");
  _id_3645D8AEE174AFB3("spawner_obj_a_exterior_patrol", "stealth_container");
  _id_3645D8AEE174AFB3("spawner_obj_a_exterior_patrol_roof", "stealth_container");
  level thread _id_E4D159155F43A954();
  level thread _id_4548D071950D3C0F();
}

_id_E4D159155F43A954() {
  level endon("obj_a_interior_spawned");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger_objA", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_a";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_shotgun", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
    } else {
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_smg", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_upstairs_smg", "stealth_container");
    }

    _id_3645D8AEE174AFB3("spawner_obj_a_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_upstairs_thread");
    level notify("obj_a_interior_spawned");
    break;
  }
}

_id_4548D071950D3C0F() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_upstairs_objA", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_C657C349AF2FE650();
}

_id_C657C349AF2FE650() {
  level endon("kill_upstairs_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_a";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_shotgun", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
    } else {
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_smg", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_a_interior_upstairs_smg", "stealth_container");
    }

    _id_3645D8AEE174AFB3("spawner_obj_a_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("obj_a_interior_spawned");
    level notify("kill_upstairs_thread");
    break;
  }
}

_id_23191A0B3361E1B1() {
  if(istrue(level._id_B681A67C472F3E22)) {
    return;
  }
  level._id_B681A67C472F3E22 = 1;
  _id_3645D8AEE174AFB3("spawner_obj_b_exterior", "stealth_container");
  _id_3645D8AEE174AFB3("spawner_obj_b_exterior_patrol", "stealth_container");
  _id_3645D8AEE174AFB3("spawner_obj_b_exterior_roof", "stealth_container");
  level thread _id_C657C649AF2FECE9();
}

_id_C657C649AF2FECE9() {
  level notify("kill_objb_spawner_thread");
  level endon("kill_objb_spawner_thread");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger_objB", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_b";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_3645D8AEE174AFB3("spawner_obj_b_interior_shotgun", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_b_ambush_shotgun", "stealth_container");
    } else {
      _id_3645D8AEE174AFB3("spawner_obj_b_interior_smg", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_b_interior_2_smg", "stealth_container");
      _id_3645D8AEE174AFB3("spawner_obj_b_ambush_smg", "stealth_container");
    }

    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objb_spawner_thread");
    break;
  }
}

_id_FD6C72301C76F7A2() {
  if(istrue(level._id_C58764B80FED93A9)) {
    return;
  }
  level._id_C58764B80FED93A9 = 1;

  if(getdvarint("dvar_99BB5C2C4F003E2B", 0) == 0) {
    _id_3645D8AEE174AFB3("spawner_obj_c_exterior", "stealth_container");
    _id_3645D8AEE174AFB3("spawner_obj_c_exterior_patrol", "stealth_container");
  }

  level thread _id_E4D15B155F43ADBA();
}

_id_E4D15B155F43ADBA() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_objC", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_C657C549AF2FEAB6();
}

_id_C657C549AF2FEAB6() {
  level endon("kill_objC_spawner_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    _id_3645D8AEE174AFB3("spawner_obj_c_interior", "stealth_container");
    _id_3645D8AEE174AFB3("spawner_obj_c_interior_upstairs", "stealth_container");
    _id_3645D8AEE174AFB3("spawner_obj_c_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objC_spawner_thread");
    break;
  }
}

_id_32D6FA230BA2316F(ent) {
  return abs(ent.origin[2] - self.origin[2]) > 120;
}

_id_62615FDC150BAA1A(event) {
  if(event.type == "combat") {
    self laseron();
    self.goalradius = 1024;
    self setgoalpos(event.origin);
    return 0;
  }

  return 0;
}

_id_BC28E12F0C1C8364(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1))
        return 1;
      else {}
    }

    if(_id_32D6FA230BA2316F(event))
      return 1;
  }

  self laseron();

  if(getdvarint("dvar_A025B8F10A93A908", 0) == 0) {
    self.goalradius = 64;
    self setgoalpos(self.origin);
  }

  return 0;
}

_id_7EBC4AE7009F4C41(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1))
        return 1;
      else {}
    }

    if(_id_32D6FA230BA2316F(event))
      return 1;
  }

  self laseron();

  if(getdvarint("dvar_A025B8F10A93A908", 0) == 0) {
    self.goalradius = 64;
    self setgoalpos(self.origin);
  }

  return 0;
}

_id_C9B04B362B0B8B88(event) {
  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1))
        return 1;
      else {}
    }

    if(_id_32D6FA230BA2316F(event))
      return 1;
  }

  if(event.typeorig == "ally_killed") {}

  self laseron();

  if(getdvarint("dvar_A025B8F10A93A908", 0) != 0) {
    self.goalradius = 64;
    self setgoalpos(self.origin);
  }

  return 0;
}