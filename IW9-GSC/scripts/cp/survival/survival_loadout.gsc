/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\survival\survival_loadout.gsc
****************************************************/

init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.custom_giveloadout = ::givedefaultloadout;
  level.move_speed_scale = ::updatemovespeedscale;
  level.registerplayercharfunc = ::registerplayercharacter;

  if(!isDefined(level.loadoutsgroup))
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();

  initnightvisionheadoverrides();
}

initnightvisionheadoverrides() {
  if(!scripts\cp\utility::_id_6AAFBDD00B977115()) {
    return;
  }
  level.nvgheadoverrides = [];
  _id_962EF6817910EC78 = 0;

  for(;;) {
    head = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 5);
    _id_8CAF1716B3192F8F = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 17);
    _id_F164251D2631366A = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 16);

    if(!isDefined(head) || head == "") {
      break;
    }

    if(_id_8CAF1716B3192F8F != "")
      level.nvgheadoverrides[head]["up"] = _id_8CAF1716B3192F8F;

    if(_id_F164251D2631366A != "")
      level.nvgheadoverrides[head]["down"] = _id_F164251D2631366A;

    _id_962EF6817910EC78++;
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_3"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_4"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["down"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["up"] = "none";
}

givedefaultloadout(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126, _id_9B02313FE7FF70DA) {
  self setclientomnvar("ui_options_menu", 0);

  if(istrue(self.is_doing_infil)) {
    thread giveloadoutafterinfil(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126);
    return;
  }

  player = self;
  player.changingweapon = undefined;
  player scripts\cp\cp_accessories::clearplayeraccessory();
  player takeallweapons();

  if(!istrue(player.keep_perks))
    player scripts\cp\utility::_clearperks();

  player thread delayreturningperks(player);

  if(istrue(_id_9B02313FE7FF70DA))
    player scripts\cp\utility::_detachall(1);
  else {
    player scripts\cp\utility::_detachall();

    if(isDefined(player.headmodel))
      player.headmodel = undefined;

    _id_17BD52F2B320F1CA = get_player_character_num();

    if(isDefined(_id_185EA69B2FE37360))
      _id_17BD52F2B320F1CA = _id_185EA69B2FE37360;

    player thread setmodelfromcustomization(_id_17BD52F2B320F1CA);
    _id_962EF6817910EC78 = player lookupcurrentoperatorskin(player.team);
    _id_E89FD4C2E2E797B9 = player getplayerfoleytype(_id_962EF6817910EC78);

    if(_id_E89FD4C2E2E797B9 == "")
      _id_E89FD4C2E2E797B9 = "vestlight";

    player setclothtype(_id_E89FD4C2E2E797B9);
  }

  if(istestclient(player)) {
    _id_7CB3CE39E2414126 = 1;
    player thread testclient_run_funcs();
  }

  player.spawnperk = 0;
  scripts\engine\utility::flag_wait("introscreen_over");

  if(isDefined(level.move_speed_scale))
    self[[level.move_speed_scale]]();
  else
    updatemovespeedscale();

  player.primaryweapon = nullweapon();
  player thread _id_74502A9E0EF1F19C::setweaponlaser_internal();
  player notify("giveLoadout");
  player scripts\cp\utility::giveperk("specialty_pistoldeath");

  if(isDefined(_id_86DB2022C4F0F4BF) && _id_86DB2022C4F0F4BF) {
    return;
  }
  _id_144130378B339AB7 = player.melee_weapon;
  player.default_starting_melee_weapon = _id_144130378B339AB7;
  player.currentmeleeweapon = _id_144130378B339AB7;

  if(allow_super(self)) {
    if(!istrue(self.changing_loadout))
      _id_56EF8D52FE1B48A1::give_player_super(_id_7CB3CE39E2414126);
  }

  scripts\cp\cp_loadout::give_weapons_from_loadout(self, _id_7CB3CE39E2414126);

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  if(isundefinedweapon(player.default_starting_pistol)) {
    if(!isundefinedweapon(player.starting_weapon))
      player.default_starting_pistol = player.starting_weapon;
    else if(isDefined(level.default_weapon))
      player.default_starting_pistol = _id_2669878CF5A1B6BC::buildweapon(level.default_weapon, [], "none", "none", -1);
    else
      player.default_starting_pistol = _id_2669878CF5A1B6BC::buildweapon("iw8_pi_decho_mp", [], "none", "none", -1);
  }

  player.last_stand_pistol = player.default_starting_pistol;

  if(!isundefinedweapon(player.starting_weapon) && player.starting_weapon == player.default_starting_pistol) {} else {
    _id_EA6BEFBE838B7BE0 = scripts\cp\utility::getrawbaseweaponname(player.default_starting_pistol);
    player.default_starting_pistol = return_wbk_version_of_weapon(player, _id_EA6BEFBE838B7BE0, player.default_starting_pistol);
    player scripts\cp\utility::_giveweapon(player.default_starting_pistol, undefined, undefined, 1);
  }

  if(!isundefinedweapon(player.starting_weapon)) {
    _id_EA6BEFBE838B7BE0 = scripts\cp\utility::getrawbaseweaponname(player.starting_weapon);
    player.starting_weapon = return_wbk_version_of_weapon(player, _id_EA6BEFBE838B7BE0, player.starting_weapon);
    player scripts\cp\utility::_giveweapon(player.starting_weapon, undefined, undefined, 0);
  }

  baseweapon = scripts\cp\utility::getrawbaseweaponname(player.default_starting_pistol);
  player[[level.move_speed_scale]]();
  player giveweapon("super_default_zm");
  player assignweaponoffhandspecial("super_default_zm");
  player.specialoffhandgrenade = "super_default_zm";
  starting_weapon = player.default_starting_pistol;

  if(!isundefinedweapon(player.starting_weapon))
    starting_weapon = player.starting_weapon;

  player thread wait_and_force_weapon_switch(starting_weapon);
  player set_player_perks();

  if(!scripts\cp\utility::is_wave_gametype()) {
    if(!isDefined(player.enabledbasejumping)) {
      player.enabledbasejumping = 0;
      player scripts\cp\utility::allow_player_basejumping(1);
    } else if(player.enabledbasejumping == 0)
      player scripts\cp\utility::allow_player_basejumping(1);
  }

  if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.execution))
    player scripts\cp_mp\execution::_giveexecution(player.operatorcustomization.execution);

  if(istrue(level.disable_nvg))
    player setactionslot(2, "");

  player setactionslot(3, "altmode");
  player notify("loadout_given");
  player.changing_loadout = undefined;
  player thread notify_when_loadout_given();
}

notify_when_loadout_given() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!scripts\cp\utility::is_raid_gamemode() && !istrue(level.dogtag_revive) && !scripts\cp\utility::is_wave_gametype()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_set("player_spawned_with_loadout");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_set("player_spawned_with_loadout");
  scripts\cp\calloutmarkerping_cp::setuppingspecificvars(self);
  thread _id_644C18834356D9DC::clear_legacy_pickup_munitions();
}

giveloadoutafterinfil(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126) {
  self notify("giveLoadoutAfterInfil");
  self endon("disconnect");
  self endon("giveLoadoutAfterInfil");
  self waittill("player_finished_infil");
  givedefaultloadout(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126);
}

allow_super(player) {
  if(isDefined(level.allow_super))
    return [[level.allow_super]](player);

  return 1;
}

return_wbk_version_of_weapon(player, _id_EA6BEFBE838B7BE0, objweapon) {
  level endon("game_ended");
  player endon("disconnect");
  return objweapon;
}

delayreturningperks(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("spawned_player");
  wait 1;

  if(istrue(player.keep_perks)) {
    if(isDefined(player.zombies_perks)) {
      _id_37D6720284E968A1 = getarraykeys(player.zombies_perks);

      foreach(perk in _id_37D6720284E968A1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[perk]) && isDefined(level.coop_perk_callbacks[perk].set))
          player[[level.coop_perk_callbacks[perk].set]]();
      }
    }

    player.keep_perks = undefined;
  }
}

release_character_number(player) {
  _id_74E9C58EF0ACED0C = player.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, _id_74E9C58EF0ACED0C) && _id_74E9C58EF0ACED0C != 5)
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, _id_74E9C58EF0ACED0C);
}

get_baseweapon_pap_level(player, baseweapon) {
  if(isDefined(player.pap[baseweapon]))
    return player.pap[baseweapon].lvl;
  else
    return 1;
}

setmodelfromcustomization(_id_17BD52F2B320F1CA) {
  level endon("game_ended");
  self.melee_weapon = "iw8_knife_mp";
  _id_3EDA0EF65C9478AC = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);
  operatorskinindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");
  _id_56E7CF38A4910BA2 = getoperatorcustomization();
  body = _id_56E7CF38A4910BA2[0];
  head = _id_56E7CF38A4910BA2[1];
  self.setcustomization_body = body;
  self.setcustomization_head = head;
  self setcustomization(body, head);
  wait 0.05;
  _id_56E7CF38A4910BA2 = getoperatorcustomization();
  body = _id_56E7CF38A4910BA2[0];
  head = _id_56E7CF38A4910BA2[1];
  suit = _id_56E7CF38A4910BA2[2];

  if(level.script == "cp_raid_complex") {
    if(self ishost()) {
      body = "body_mp_eastern_geist_1_1_lod1";
      head = "head_mp_eastern_geist_1_1";
      suit = "iw9_suit_mp_nikto";
    } else {
      body = "body_mp_eastern_roze_1_1_lod1";
      head = "head_mp_eastern_roze_1_1";
      suit = undefined;
    }
  }

  if(!isagent(self)) {
    self setcustomization(body, head);
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_0E69FCB0BB9E108B = self getcustomizationviewmodel();
    _id_41BD2EEDA1C033D2 = getplayerviewmodelfrombody(body);
  } else {
    bodymodelname = "body_opforce_london_terrorist_1_2";
    headmodelname = "head_male_bc_03";
    _id_0E69FCB0BB9E108B = "viewmodel_mp_base_iw8";
    _id_41BD2EEDA1C033D2 = "viewmodel_mp_base_iw8";
  }

  operatorref = lookupcurrentoperator(self.team);
  _id_5864EA4E21A60CD4 = lookupcurrentoperatorskin(self.team);
  operatorcustomization = spawnStruct();
  operatorcustomization.operatorref = operatorref;
  operatorcustomization.skinref = _id_5864EA4E21A60CD4;
  operatorcustomization.body = body;
  operatorcustomization.defaultbody = bodymodelname;
  operatorcustomization.head = head;
  operatorcustomization.defaulthead = headmodelname;
  operatorcustomization.vm = _id_41BD2EEDA1C033D2;
  operatorcustomization.defaultvm = _id_0E69FCB0BB9E108B;
  operatorcustomization.gender = getoperatorgender(operatorref);
  operatorcustomization.voice = getoperatorvoice(operatorref, _id_5864EA4E21A60CD4);
  operatorcustomization.clothtype = getoperatorclothtype(_id_5864EA4E21A60CD4);
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  operatorcustomization.execution = getoperatorexecution(operatorref);
  operatorcustomization.executionquip = getoperatorexecutionquip(operatorref);
  operatorcustomization.suit = suit;
  operatorcustomization.rebuild = 0;
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  self.operatorcustomization = operatorcustomization;
  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  self.vehiclecustomization = scripts\cp_mp\vehicles\vehicle::_id_1CD6D75165ECBC48();

  if(self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else
    self _meth_555E2D32E2756625("");

  if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](self))
    self[[level.change_to_terrorist_model_func]](self);

  if(isDefined(level.post_customization_func))
    self[[level.post_customization_func]]();
}

getplayerbodymodel() {
  _id_56E7CF38A4910BA2 = getoperatorcustomization();
  return _id_56E7CF38A4910BA2[0];
}

getplayerviewmodelfrombody(_id_C993EC5D5206D3C6) {
  viewmodel = tablelookup("mp/cac/bodies.csv", 1, _id_C993EC5D5206D3C6, 3);

  if(!isDefined(viewmodel) || viewmodel == "")
    viewmodel = "viewhands_mp_base_iw8";

  return viewmodel;
}

lookupcurrentoperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  _id_1F9F9C5D4663030C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
  _id_3EDA0EF65C9478AC = _id_1F9F9C5D4663030C;
  _id_498A2226E5AA47EE = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(!level.teambased || _id_498A2226E5AA47EE) {
    _id_1F9F9C5D4663030C = undefined;

    if(isai(self))
      _id_1F9F9C5D4663030C = self.botoperatorteam;
    else
      _id_1F9F9C5D4663030C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");

    _id_3EDA0EF65C9478AC = _id_1F9F9C5D4663030C;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(_id_3EDA0EF65C9478AC == 0)
        self.defaultoperatorteam = "allies";
      else
        self.defaultoperatorteam = "axis";
    }
  }

  if(!isDefined(level.playercustomizationdata))
    level.playercustomizationdata = [];

  clientnum = self getentitynumber();
  level.playercustomizationdata[clientnum] = [];
  operatorref = undefined;

  if(!isDefined(level.playercustomizationdata[clientnum][team])) {
    data = spawnStruct();

    if(isai(self))
      data.operatorref = self.botoperatorref;
    else
      data.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);

    level.playercustomizationdata[clientnum][team] = data;
  }

  operatorref = level.playercustomizationdata[clientnum][team].operatorref;

  if(getdvarint("dvar_338DA2F6C53885E2", 1) == 1 && self isplayerheadless()) {
    _id_A35E0C377810107E = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.headlesscustomizationops)) {
      foreach(_id_7C578F2F3EBFDD97 in _id_A35E0C377810107E) {
        _id_EA61DCDCEDF141E7 = getarraykeys(level.operatorcustomization[_id_7C578F2F3EBFDD97]);

        if(!isDefined(level.headlessopindex))
          level.headlessopindex = [];

        if(!isDefined(level.headlessopindex[_id_7C578F2F3EBFDD97]) || level.headlessopindex[_id_7C578F2F3EBFDD97] > _id_EA61DCDCEDF141E7.size)
          level.headlessopindex[_id_7C578F2F3EBFDD97] = 0;

        for(_id_FBAF0295A16D4C79 = _id_EA61DCDCEDF141E7[level.headlessopindex[_id_7C578F2F3EBFDD97]]; isDefined(_id_FBAF0295A16D4C79) && (_id_FBAF0295A16D4C79 == "default_western" || _id_FBAF0295A16D4C79 == "default_eastern"); _id_FBAF0295A16D4C79 = _id_EA61DCDCEDF141E7[level.headlessopindex[_id_7C578F2F3EBFDD97]]) {
          level.headlessopindex[_id_7C578F2F3EBFDD97] = level.headlessopindex[_id_7C578F2F3EBFDD97] + 1;

          if(level.headlessopindex[_id_7C578F2F3EBFDD97] > _id_EA61DCDCEDF141E7.size)
            level.headlessopindex[_id_7C578F2F3EBFDD97] = 0;
        }

        level.headlessopindex[_id_7C578F2F3EBFDD97] = level.headlessopindex[_id_7C578F2F3EBFDD97] + 1;
        level.playercustomizationdata[clientnum][_id_7C578F2F3EBFDD97] = spawnStruct();
        level.playercustomizationdata[clientnum][_id_7C578F2F3EBFDD97].operatorref = _id_FBAF0295A16D4C79;
      }

      self.headlesscustomizationops = 1;
    }

    if(isDefined(level.operatorcustomization[team]))
      operatorref = level.playercustomizationdata[clientnum][team].operatorref;
    else {
      if(!isDefined(self.botoperatorteam))
        self.botoperatorteam = scripts\engine\utility::random(_id_A35E0C377810107E);

      operatorref = level.playercustomizationdata[clientnum][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(operatorref) || operatorref == "") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[clientnum][team].operatorref))
          operatorref = level.playercustomizationdata[clientnum][team].operatorref;
        else
          operatorref = self.botoperatorref;
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            _id_A35E0C377810107E = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(_id_A35E0C377810107E);
          }
        }

        team = self.botoperatorteam;

        if(!isDefined(self.pers["operatorIndex"])) {
          _id_1F9F9C5D4663030C = randomint(level.operatorcustomization[team].size);
          self.pers["operatorIndex"] = _id_1F9F9C5D4663030C;
        } else
          _id_1F9F9C5D4663030C = self.pers["operatorIndex"];

        currentindex = 0;

        foreach(_id_257DF77381FCCC70, _id_EEF96DCED6DD39F1 in level.operatorcustomization[team]) {
          if(currentindex == _id_1F9F9C5D4663030C) {
            self.botoperatorref = _id_257DF77381FCCC70;
            operatorref = _id_257DF77381FCCC70;
            break;
          }

          currentindex++;
        }
      }
    } else
      operatorref = "wyatt_western";
  }

  return operatorref;
}

lookupcurrentoperatorskin(team) {
  operatorref = lookupcurrentoperator(team);
  operatorskinindex = undefined;
  clientnum = self getentitynumber();

  if(getdvarint("dvar_338DA2F6C53885E2", 1) == 1 && self isplayerheadless()) {
    if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinindex)) {
      if(!isDefined(level.headlessoperatorcustomization))
        initheadlessoperatorcustomization();

      _id_9A6BA9F5A0E705C7 = level.headlessoperatorcustomization[operatorref]["curIndex"];
      level.playercustomizationdata[clientnum][team].operatorskinindex = level.headlessoperatorcustomization[operatorref]["lootIDs"][_id_9A6BA9F5A0E705C7];
      level.headlessoperatorcustomization[operatorref]["curIndex"] = level.headlessoperatorcustomization[operatorref]["curIndex"] + 1;

      if(level.headlessoperatorcustomization[operatorref]["curIndex"] >= level.headlessoperatorcustomization[operatorref]["maxIndex"])
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
    }
  } else if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinindex)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid))
        botpickskinid(operatorref);

      level.playercustomizationdata[clientnum][team].operatorskinindex = self.botskinid;
    } else
      level.playercustomizationdata[clientnum][team].operatorskinindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");
  }

  operatorskinindex = level.playercustomizationdata[clientnum][team].operatorskinindex;

  if(isai(self) && (!isDefined(operatorskinindex) || operatorskinindex == 0) || !isDefined(operatorskinindex) || operatorskinindex == 0) {
    if(isai(self)) {
      if(isDefined(self.botskinid))
        operatorskinindex = self.botskinid;
      else
        botpickskinid(operatorref);
    } else
      operatorskinindex = 1;
  }

  return operatorskinindex;
}

botpickskinid(operatorref) {
  team = self.team;

  if(isDefined(self.botoperatorteam))
    team = self.botoperatorteam;

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    _id_C645029CC8549E3F = randomint(level.operatorcustomization[team][operatorref].size);
    self.pers["operatorSkinIndex"] = _id_C645029CC8549E3F;
  } else
    _id_C645029CC8549E3F = self.pers["operatorSkinIndex"];

  currentindex = 0;

  foreach(skinref, _id_56E7CF38A4910BA2 in level.operatorcustomization[team][operatorref]) {
    if(currentindex == _id_C645029CC8549E3F) {
      lootid = int(tablelookup("operatorskins.csv", 1, skinref, 0));
      self.botskinid = lootid;
      operatorskinindex = lootid;
      break;
    }

    currentindex++;
  }
}

initheadlessoperatorcustomization() {
  if(isDefined(level.headlessoperatorcustomization)) {
    return;
  }
  level.headlessoperatorcustomization = [];
  _id_F87730061DCB36C4 = tablelookupgetnumrows("operatorskins.csv");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F87730061DCB36C4; _id_AC0E594AC96AA3A8++) {
    if(tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 18) != "") {
      operatorref = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 2);
      lootid = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 0);

      if(!isDefined(level.headlessoperatorcustomization[operatorref])) {
        level.headlessoperatorcustomization[operatorref]["lootIDs"] = [];
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
        level.headlessoperatorcustomization[operatorref]["maxIndex"] = 0;
      }

      level.headlessoperatorcustomization[operatorref]["lootIDs"][level.headlessoperatorcustomization[operatorref]["lootIDs"].size] = int(lootid);
      level.headlessoperatorcustomization[operatorref]["maxIndex"] = level.headlessoperatorcustomization[operatorref]["maxIndex"] + 1;
    }
  }
}

lookupotheroperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  _id_3EDA0EF65C9478AC = scripts\engine\utility::ter_op(team == "allies", 1, 0);
  clientnum = self getentitynumber();
  operatorref = "";
  team = scripts\engine\utility::ter_op(team == "allies", "axis", "allies");

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[clientnum][team])) {
        data = spawnStruct();
        data.operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);
        level.playercustomizationdata[clientnum][team] = data;
      }

      operatorref = level.playercustomizationdata[clientnum][team].operatorref;
    }
  }

  return operatorref;
}

initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }
  level.operatorcustomization = [];
  setDvar("dvar_2B669AD6C3E1D864", 1);
  _id_91CB23E7AB33F8EF = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 1);
    superfaction = getoperatorsuperfaction(operatorref);
    team = scripts\engine\utility::ter_op(superfaction == 0, "allies", "axis");

    if(!isDefined(operatorref) || operatorref == "") {
      break;
    }

    _id_7BE8B486A10B3DE8 = int(tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 8));

    if(_id_7BE8B486A10B3DE8) {
      if(!isDefined(level.operatorcustomization[team]))
        level.operatorcustomization[team] = [];

      level.operatorcustomization[team][operatorref] = [];
    }

    _id_91CB23E7AB33F8EF++;
  }

  _id_962EF6817910EC78 = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 2);
    skinref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 1);
    body = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 4);
    head = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 5);

    if(!isDefined(skinref) || skinref == "") {
      break;
    }

    team = getoperatorteambyref(operatorref);

    if(!isDefined(team)) {
      _id_962EF6817910EC78++;
      continue;
    }

    _id_56E7CF38A4910BA2 = [];
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
    level.operatorcustomization[team][operatorref][skinref] = _id_56E7CF38A4910BA2;
    _id_962EF6817910EC78++;
  }
}

getoperatorteambyref(operatorref) {
  foreach(team, _id_B6217B906C6BE73E in level.operatorcustomization) {
    foreach(operator, _id_0BFBF0D4002DD345 in _id_B6217B906C6BE73E) {
      if(operator == operatorref)
        return team;
    }
  }

  return undefined;
}

pickdefaultoperatorskin(team) {
  _id_F26451879315CADC = 0;
  weapon = self.primaryweapon;

  if(isDefined(weapon)) {
    _id_CF4209C200F8BBF4 = _id_74502A9E0EF1F19C::getweapongroup(weapon);

    switch (_id_CF4209C200F8BBF4) {
      case "weapon_battle":
      case "weapon_assault":
        _id_F26451879315CADC = 0;
        break;
      case "weapon_smg":
        _id_F26451879315CADC = 1;
        break;
      case "weapon_sniper":
      case "weapon_dmr":
        _id_F26451879315CADC = 2;
        break;
      case "weapon_lmg":
        _id_F26451879315CADC = 3;
        break;
      case "weapon_shotgun":
        _id_F26451879315CADC = 4;
        break;
      default:
        _id_F26451879315CADC = 1;
        break;
    }
  }

  return _id_F26451879315CADC;
}

getoperatorcustomization() {
  _id_91CB23E7AB33F8EF = lookupcurrentoperator(self.team);
  operatorskinindex = lookupcurrentoperatorskin(self.team);
  body = undefined;
  head = undefined;
  suit = undefined;

  if((_id_91CB23E7AB33F8EF == "default_western" || _id_91CB23E7AB33F8EF == "default_eastern") && (operatorskinindex == 274 || operatorskinindex == 275)) {
    initdefaultoperatorskins();
    _id_3060E7B91E020425 = level.teambased && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

    if(!isDefined(self.defaultoperatorteam) || _id_3060E7B91E020425 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
      team = "allies";

      if(_id_91CB23E7AB33F8EF == "default_eastern")
        team = "axis";

      self.defaultoperatorteam = team;

      if(self.team != "allies" && self.team != "axis")
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"]))
      self.pers["defaultOperatorSkinIndex"] = 0;

    body = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"]))
      self.pers["defaultOperatorHeadIndex"] = scripts\engine\utility::random(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]]);

    head = self.pers["defaultOperatorHeadIndex"];
    suit = "iw9_suit_generic_west_mp";
  } else {
    body = tablelookup("operatorskins.csv", 0, operatorskinindex, 4);
    head = tablelookup("operatorskins.csv", 0, operatorskinindex, 5);
    suit = tablelookup("operators.csv", 1, _id_91CB23E7AB33F8EF, 19);
  }

  self.bodymodelname = body;
  self.backuphead = head;
  self.backupsuit = suit;
  _id_56E7CF38A4910BA2 = [];
  _id_56E7CF38A4910BA2[0] = body;
  _id_56E7CF38A4910BA2[1] = head;
  _id_56E7CF38A4910BA2[2] = suit;
  return _id_56E7CF38A4910BA2;
}

initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
  level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1"];
  level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
  level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
  level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
  level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
  level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
  level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
  level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_nvg_1"];
  level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
}

getoperatorexecution(operatorref) {
  _id_90B23EDBB5FCA35C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "execution");

  if(_id_90B23EDBB5FCA35C == 0)
    self.loadoutexecution = tablelookup("operators.csv", 1, operatorref, 24);
  else
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, _id_90B23EDBB5FCA35C, 1);

  return self.loadoutexecution;
}

getoperatorexecutionquip(operatorref) {
  _id_635CB55857199A8D = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "taunt");

  if(_id_635CB55857199A8D == 0)
    self.loadoutexecutionquip = tablelookup("operators.csv", 1, operatorref, 23);
  else
    self.loadoutexecutionquip = tablelookup("operatorquips.csv", 0, _id_635CB55857199A8D, 6);

  return self.loadoutexecutionquip;
}

getoperatorsuperfaction(operatorref) {
  faction = tablelookup("operators.csv", 1, operatorref, 3);
  return int(faction);
}

getoperatorvoice(operatorref, _id_5864EA4E21A60CD4) {
  if(operatorref == "default_eastern" || operatorref == "default_western") {
    voice = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 24);

    if(isDefined(voice) && voice != "")
      return voice;
  }

  voice = tablelookup("operators.csv", 1, operatorref, 10);
  return voice;
}

getoperatorclothtype(_id_962EF6817910EC78) {
  clothtype = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 22);
  return clothtype;
}

getoperatorgender(operatorref) {
  gender = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, operatorref, 11) == "0", "male", "female");
  return gender;
}

get_player_character_num() {
  if(isDefined(self.player_character_num))
    return self.player_character_num;

  _id_DC061F521C45D732 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = _id_DC061F521C45D732;
  return _id_DC061F521C45D732;
}

setplayerhudphoto(player, _id_F8892FD366226EB7) {
  player endon("disconnect");
  entity_number = player getentitynumber();

  if(entity_number == 4)
    entity_number = 0;

  player.bit_position = get_bit_position(entity_number);
  player.player_character_index = _id_F8892FD366226EB7;

  if(isDefined(level.skip_playerhudphoto)) {
    player.player_character_index = 1;
    _id_F8892FD366226EB7 = 1;
  }

  wait 5.0;
}

set_player_photo_status(player, status) {
  set_player_photo_option(player, "zm_player_status", get_status_bit_value(status));
}

set_player_photo_option(player, omnvar, _id_072A171E8A486A66) {
  if(isDefined(player.bit_position)) {
    setomnvarbit(omnvar, player.bit_position.bit_3, _id_072A171E8A486A66.bit_3);
    setomnvarbit(omnvar, player.bit_position.bit_2, _id_072A171E8A486A66.bit_2);
    setomnvarbit(omnvar, player.bit_position.bit_1, _id_072A171E8A486A66.bit_1);
    player.photosetup = 1;
  }
}

get_bit_position(entity_number) {
  bit_position = spawnStruct();

  switch (entity_number) {
    case 3:
      bit_position.bit_3 = 11;
      bit_position.bit_2 = 10;
      bit_position.bit_1 = 9;
      break;
    case 2:
      bit_position.bit_3 = 8;
      bit_position.bit_2 = 7;
      bit_position.bit_1 = 6;
      break;
    case 1:
      bit_position.bit_3 = 5;
      bit_position.bit_2 = 4;
      bit_position.bit_1 = 3;
      break;
    case 0:
      bit_position.bit_3 = 2;
      bit_position.bit_2 = 1;
      bit_position.bit_1 = 0;
      break;
  }

  return bit_position;
}

get_character_bit_value(photo_index) {
  _id_072A171E8A486A66 = spawnStruct();

  switch (photo_index) {
    case 0:
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 0;
      _id_072A171E8A486A66.bit_1 = 0;
      break;
    case 1:
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 0;
      _id_072A171E8A486A66.bit_1 = 1;
      break;
    case 2:
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 1;
      _id_072A171E8A486A66.bit_1 = 0;
      break;
    case 3:
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 1;
      _id_072A171E8A486A66.bit_1 = 1;
      break;
    case 4:
      _id_072A171E8A486A66.bit_3 = 1;
      _id_072A171E8A486A66.bit_2 = 0;
      _id_072A171E8A486A66.bit_1 = 0;
      break;
  }

  return _id_072A171E8A486A66;
}

get_status_bit_value(status) {
  _id_072A171E8A486A66 = spawnStruct();

  switch (status) {
    case "healthy":
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 0;
      _id_072A171E8A486A66.bit_1 = 0;
      break;
    case "damaged":
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 0;
      _id_072A171E8A486A66.bit_1 = 1;
      break;
    case "laststand":
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 1;
      _id_072A171E8A486A66.bit_1 = 0;
      break;
    case "afterlife":
      _id_072A171E8A486A66.bit_3 = 0;
      _id_072A171E8A486A66.bit_2 = 1;
      _id_072A171E8A486A66.bit_1 = 1;
      break;
  }

  return _id_072A171E8A486A66;
}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2, hairmodel) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);
  self attach(headmodelname, "", 1);
  self.bodymodel = bodymodelname;
  self.headmodel = headmodelname;
  self.viewmodel = _id_41BD2EEDA1C033D2;
}

getplayermodelindex() {
  return 0;
}

getplayerfoleytype(_id_962EF6817910EC78) {
  return tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 22);
}

updatemovespeedscale() {
  _id_8F053B6F8634C100 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    _id_8F053B6F8634C100 = 1.0;
    _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.playerstreakspeedscale;
  } else {
    _id_8F053B6F8634C100 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      _id_8F053B6F8634C100 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      _id_8F053B6F8634C100 = self.siege_speedscale;
    else if(isDefined(self.overrideweaponspeed_speedscale))
      _id_8F053B6F8634C100 = self.overrideweaponspeed_speedscale;

    _id_F30C40867C01E4F9 = self.chill_data;

    if(isDefined(_id_F30C40867C01E4F9) && isDefined(_id_F30C40867C01E4F9.speedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + _id_F30C40867C01E4F9.speedmod;

    if(isDefined(self.speedstripmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedonkillmod;

    _id_8F053B6F8634C100 = min(1.5, _id_8F053B6F8634C100);
  }

  self.weaponspeed = _id_8F053B6F8634C100;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(_id_8F053B6F8634C100 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(player) {
  weaponspeed = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on")
    return 1.0;

  if(!self.weaponlist.size)
    weaponspeed = 0.9;
  else {
    weapon = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(weapon))
      weaponspeed = level.superweapons[getcompleteweaponname(weapon)].movespeed;
    else {
      _id_A6852F8E66761E58 = weaponinventorytype(weapon);

      if(_id_A6852F8E66761E58 != "primary" && _id_A6852F8E66761E58 != "altmode") {
        if(isDefined(self.saved_lastweapon))
          weapon = self.saved_lastweapon;
        else
          weapon = undefined;
      }

      if(!isDefined(weapon) || !self hasweapon(weapon))
        weaponspeed = getweaponspeedslowest();
      else
        weaponspeed = getweaponspeed(weapon);
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

getweaponspeed(weapon) {
  rootweapon = scripts\cp\utility::getbaseweaponname(weapon);
  weaponspeed = level.weaponmapdata[rootweapon].speed;
  return weaponspeed;
}

getweaponspeedslowest() {
  _id_6155FF1652D3374F = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      weaponspeed = getweaponspeed(weapon);

      if(weaponspeed == 0) {
        continue;
      }
      if(weaponspeed < _id_6155FF1652D3374F)
        _id_6155FF1652D3374F = weaponspeed;
    }
  } else
    _id_6155FF1652D3374F = 0.9;

  _id_6155FF1652D3374F = clampweaponspeed(_id_6155FF1652D3374F);
  return _id_6155FF1652D3374F;
}

clampweaponspeed(value) {
  return clamp(value, 0.0, 1.0);
}

getweaponheaviestvalue() {
  _id_8A6F4E6A2246D381 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      _id_40253EE32D687D41 = getweaponweight(weapon);

      if(_id_40253EE32D687D41 == 0) {
        continue;
      }
      if(_id_40253EE32D687D41 < _id_8A6F4E6A2246D381)
        _id_8A6F4E6A2246D381 = _id_40253EE32D687D41;
    }
  } else
    _id_8A6F4E6A2246D381 = 8;

  _id_8A6F4E6A2246D381 = clampweaponweightvalue(_id_8A6F4E6A2246D381);
  return _id_8A6F4E6A2246D381;
}

getweaponweight(weapon) {
  baseweapon = scripts\cp\utility::getbaseweaponname(weapon);
  weaponspeed = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(baseweapon, "stat_BAA7982E38A124A2");

  if(!isDefined(weaponspeed) || weaponspeed < 1)
    weaponspeed = float(tablelookup(level.game_mode_statstable, 4, baseweapon, 8));

  if(!isDefined(weaponspeed) || weaponspeed < 1)
    weaponspeed = 10;

  return weaponspeed;
}

clampweaponweightvalue(value) {
  return clamp(value, 0.0, 11.0);
}

wait_and_force_weapon_switch(starting_weapon) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

  if(!self hasweapon(starting_weapon))
    starting_weapon = _id_BC9DA38A4BAB4CE2[0];

  add_ammo_if_needed(_id_BC9DA38A4BAB4CE2);
  self setspawnweapon(starting_weapon);
}

add_ammo_if_needed(_id_BC9DA38A4BAB4CE2) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["weapons_have_full_ammo"])) {
    foreach(weapon in _id_BC9DA38A4BAB4CE2)
    self givemaxammo(weapon);
  }
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.perksetfuncs["specialty_momentum"] = ::setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = ::unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = ::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = ::unsetfreefall;
}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(_id_51438B11657961CC = 0; _id_51438B11657961CC < 0.08; _id_51438B11657961CC = _id_51438B11657961CC + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

unsetmomentum() {
  self notify("momentum_unset");
}

setfreefall() {}

unsetfreefall() {}

set_player_perks() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    _id_0AD84ADCB356CFCE = 4;
    _id_97CA3D05716B420D = 0;
    _id_9CE56EBBDEC8A388 = 0;
    _id_9CE56EBBDEC8A388 = _id_0AD84ADCB356CFCE;

    if(isDefined(level.player_suit))
      scripts\cp\utility\player::_setsuit(level.player_suit);
    else
      scripts\cp\utility\player::_setsuit("iw9_suit_cp");

    self.suit = "iw9_suit_cp";
    self allowdoublejump(0);
    self allowslide(_id_9CE56EBBDEC8A388 &_id_0AD84ADCB356CFCE);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);
  self notify("set_player_perks");
}

registerplayercharacter(_id_F8892FD366226EB7, _id_80D695139E2AD462, body_model, view_model, head_model, hair_model, vo_prefix, vo_suffix, pap_gesture, revive_gesture, photo_index, fate_card_weapon, intro_music, intro_gesture, melee_weapon, post_setup_func, starting_weapon) {
  _id_0E060043AC076039 = spawnStruct();
  _id_0E060043AC076039.body_model = body_model;
  _id_0E060043AC076039.view_model = view_model;
  _id_0E060043AC076039.head_model = head_model;
  _id_0E060043AC076039.hair_model = hair_model;
  _id_0E060043AC076039.vo_prefix = vo_prefix;
  _id_0E060043AC076039.vo_suffix = vo_suffix;
  _id_0E060043AC076039.pap_gesture = pap_gesture;
  _id_0E060043AC076039.revive_gesture = revive_gesture;
  _id_0E060043AC076039.photo_index = photo_index;
  _id_0E060043AC076039.fate_card_weapon = fate_card_weapon;
  _id_0E060043AC076039.intro_music = intro_music;
  _id_0E060043AC076039.intro_gesture = intro_gesture;
  _id_0E060043AC076039.melee_weapon = makeweaponfromstring(melee_weapon);
  _id_0E060043AC076039.starting_weapon = makeweaponfromstring(starting_weapon);
  _id_0E060043AC076039.post_setup_func = post_setup_func;
  level.player_character_info[_id_F8892FD366226EB7] = _id_0E060043AC076039;

  if(!isDefined(level.available_player_characters))
    level.available_player_characters = [];

  if(_id_80D695139E2AD462 == "yes")
    level.available_player_characters[level.available_player_characters.size] = _id_F8892FD366226EB7;
}

respawnitems_assignrespawnitems(respawnitems) {
  self.respawnitems = respawnitems;
}

testclient_run_funcs() {
  if(!istestclient(self)) {
    return;
  }
  if(getdvarint("dvar_A31A2982A3EB161D", 0) > 0) {
    return;
  }
  thread scripts\cp\utility::notify_delay("loadout_given", 7);
  thread testclient_dev_laststand();
}

testclient_dev_laststand() {
  level endon("game_ended");
  self endon("disconnect");
  _id_B9C45882C66B8295 = 0;

  if(getdvarint("dvar_42E908DD6C9A5170", 0) > 0)
    _id_B9C45882C66B8295 = 1;

  wait 5;
  announcement("^2Testclient setting loadout...");
  wait 5;

  for(;;) {
    if(getdvarint("dvar_42E908DD6C9A5170", 0) == 0) {
      waitframe();
      continue;
    }

    if(_id_B9C45882C66B8295 == 2) {
      scripts\engine\utility::waittill_any_3("landed_after_respawn", "revive_done", "revive");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("^1TestClient Downed");
    }

    if(_id_B9C45882C66B8295 == 0)
      setDvar("dvar_42E908DD6C9A5170", 0);

    if(_id_B9C45882C66B8295 == 1)
      _id_B9C45882C66B8295 = 2;
  }
}

getcustomization() {
  _id_56E7CF38A4910BA2 = [];

  if(isDefined(self.operatorcustomization)) {
    _id_56E7CF38A4910BA2["body"] = self.operatorcustomization.body;
    _id_56E7CF38A4910BA2["head"] = self.operatorcustomization.head;
  } else {
    data = getoperatorcustomization();
    _id_56E7CF38A4910BA2["body"] = data[0];
    _id_56E7CF38A4910BA2["head"] = data[1];
  }

  return _id_56E7CF38A4910BA2;
}