/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\survival\survival_loadout.gsc
***********************************************/

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
  if(!_encstr_868025B3E9BE2F92307F8FCB51C21F576941BB9B139D8F9D7061C7C3237063BF0C79B276596E77::allow_nvg()) {
    return;
  }
  level.nvgheadoverrides = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 5);
    var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 17);
    var_3 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 16);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    if(var_2 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_87070365F7"] = var_2;

    if(var_3 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_9767056D0FBFA8"] = var_3;

    var_0++;
  }

  level.nvgheadoverrides["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_AFB023862B2C8CBEDAE0FAB20BCDD1CA39E6EB99B49CB2D1CA85D6AFAC0BB9D1F55827F566"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693"]["_encstr_87070365F7"] = "_encstr_9BB20673D9CEF546";
  level.nvgheadoverrides["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_8652241227682C9780830EB20A2F3817F86DE1DA93E8A235E25F4D1151267B9B7F5D9EC9B7D2"]["_encstr_9767056D0FBFA8"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_8652241227682C9780830EB20A2F3817F86DE1DA93E8A235E25F4D1151267B9B7F5D9EC9B7D2"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
}

givedefaultloadout(var_0, var_1, var_2, var_3) {
  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);

  if(istrue(self.is_doing_infil)) {
    thread giveloadoutafterinfil(var_0, var_1, var_2);
    return;
  }

  var_4 = self;
  var_4.changingweapon = undefined;
  var_4 scripts\cp\cp_accessories::clearplayeraccessory();
  var_4 takeallweapons();

  if(!istrue(var_4.keep_perks))
    var_4 scripts\cp\utility::_clearperks();

  var_4 thread delayreturningperks(var_4);

  if(istrue(var_3))
    var_4 scripts\cp\utility::_detachall(1);
  else {
    var_4 scripts\cp\utility::_detachall();

    if(isDefined(var_4.headmodel))
      var_4.headmodel = undefined;

    var_5 = get_player_character_num();

    if(isDefined(var_1))
      var_5 = var_1;

    var_4 thread setmodelfromcustomization(var_5);
    var_6 = var_4 lookupcurrentoperatorskin(var_4.team);
    var_7 = var_4 getplayerfoleytype(var_6);

    if(var_7 == "_encstr_B40101")
      var_7 = "_encstr_BEE00A93594E2BE548C7786C";

    var_4 setclothtype(var_7);
  }

  if(initmaxspeedforpathlengthtable(var_4)) {
    var_2 = 1;
    var_4 thread _id_13B0F();
  }

  var_4.spawnperk = 0;
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(isDefined(level.move_speed_scale))
    self[[level.move_speed_scale]]();
  else
    updatemovespeedscale();

  var_4.primaryweapon = isundefinedweapon();
  var_4 thread scripts\cp\cp_weapon::setweaponlaser_internal();
  var_4 notify("_encstr_B2030CA0C91D2F44C0B314F8836B");
  var_4 scripts\cp\utility::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  var_4 scripts\cp\utility::giveperk("_encstr_82E61BB90795365A85C68EE5FA2B3C07C2CD23958CD7B54BCD2DB58507");

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_4 set_player_perks();
  var_8 = var_4.melee_weapon;
  var_4.default_starting_melee_weapon = var_8;
  var_4.currentmeleeweapon = var_8;

  if(allow_super(self)) {
    if(!istrue(self.getc130knownsafeheight))
      scripts\cp\coop_super::give_player_super(var_2);

    scripts\cp\classes\cp_class_progression::give_player_class(var_2);
  }

  scripts\cp\cp_loadout::give_weapons_from_loadout(self, var_2);

  if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  if(getqueuedspleveltransients(var_4.default_starting_pistol)) {
    if(!getqueuedspleveltransients(var_4.starting_weapon))
      var_4.default_starting_pistol = var_4.starting_weapon;
    else if(isDefined(level.default_weapon))
      var_4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon(level.default_weapon, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    else
      var_4.default_starting_pistol = scripts\cp\cp_weapon::buildweapon("_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  }

  var_4.last_stand_pistol = var_4.default_starting_pistol;

  if(!getqueuedspleveltransients(var_4.starting_weapon) && var_4.starting_weapon == var_4.default_starting_pistol) {} else {
    var_9 = scripts\cp\utility::getrawbaseweaponname(var_4.default_starting_pistol);
    var_4.default_starting_pistol = return_wbk_version_of_weapon(var_4, var_9, var_4.default_starting_pistol);
    var_4 scripts\cp\utility::_giveweapon(var_4.default_starting_pistol, undefined, undefined, 1);
  }

  if(!getqueuedspleveltransients(var_4.starting_weapon)) {
    var_9 = scripts\cp\utility::getrawbaseweaponname(var_4.starting_weapon);
    var_4.starting_weapon = return_wbk_version_of_weapon(var_4, var_9, var_4.starting_weapon);
    var_4 scripts\cp\utility::_giveweapon(var_4.starting_weapon, undefined, undefined, 0);
  }

  var_10 = scripts\cp\utility::getrawbaseweaponname(var_4.default_starting_pistol);
  var_4[[level.move_speed_scale]]();
  var_4 giveweapon("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  var_4 assignweaponoffhandspecial("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
  var_4.specialoffhandgrenade = "_encstr_BEB611F03B72BB3B07E435BCF9772051117388";
  var_11 = var_4.default_starting_pistol;

  if(!getqueuedspleveltransients(var_4.starting_weapon))
    var_11 = var_4.starting_weapon;

  var_4 thread wait_and_force_weapon_switch(var_11);

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    if(!isDefined(var_4.move_door_to_pos)) {
      var_4.move_door_to_pos = 0;
      var_4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
    } else if(var_4.move_door_to_pos == 0)
      var_4 scripts\cp\utility::brjugg_playerwelcomesplashes(1);
  }

  if(isDefined(var_4.operatorcustomization) && isDefined(var_4.operatorcustomization.execution))
    var_4 scripts\cp_mp\execution::_giveexecution(var_4.operatorcustomization.execution);

  if(istrue(level.disable_nvg))
    var_4 setactionslot(2, "_encstr_B40101");

  var_4 setactionslot(3, "_encstr_B4DC085639F9C2779108");
  var_4 notify("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  var_4.getc130knownsafeheight = undefined;
  var_4 thread _id_11EC9();
}

_id_11EC9() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");

  if(!scripts\cp\utility::try_start_driving_func() && !istrue(level.dogtag_revive) && !scripts\cp\utility::turn_off_sniper_laser()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  if(!scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  scripts\engine\utility::flag_set("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(!scripts\engine\utility::ent_flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::ent_flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  scripts\engine\utility::ent_flag_set("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(level._id_12376)
    scripts\cp\whizby::_id_13263(self);

  thread scripts\cp\cp_munitions::hasmaxammo();
}

giveloadoutafterinfil(var_0, var_1, var_2) {
  self notify("_encstr_926C1634DCE34BF417F748188F246DF56B47365B75BA1B38");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_926C1634DCE34BF417F748188F246DF56B47365B75BA1B38");
  self waittill("_encstr_88DC164073A192739379942B0D1A67780DCBB170937E2829");
  givedefaultloadout(var_0, var_1, var_2);
}

allow_super(var_0) {
  if(isDefined(level.allow_super))
    return [[level.allow_super]](var_0);

  return 1;
}

return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0.weapon_build_models[var_1]))
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  else
    return var_2;
}

delayreturningperks(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(istrue(var_0.keep_perks)) {
    if(isDefined(var_0.zombies_perks)) {
      var_1 = getarraykeys(var_0.zombies_perks);

      foreach(var_3 in var_1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[var_3]) && isDefined(level.coop_perk_callbacks[var_3].set))
          var_0[[level.coop_perk_callbacks[var_3].set]]();
      }
    }

    var_0.keep_perks = undefined;
  }
}

release_character_number(var_0) {
  var_1 = var_0.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, var_1) && var_1 != 5)
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, var_1);
}

get_baseweapon_pap_level(var_0, var_1) {
  if(isDefined(var_0.pap[var_1]))
    return var_0.pap[var_1].lvl;
  else
    return 1;
}

setmodelfromcustomization(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.melee_weapon = "_encstr_BED80D7C9C59D95BF870DBDFA9F018";
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_B483160271B8BDE2F50353875115BBF12098FA048810458B");
  var_2 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_AA5C0AFFB72143DE697B535B", var_1);
  var_3 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_2, "_encstr_8D18056EADA59B");
  var_4 = getoperatorcustomization();
  var_5 = var_4[0];
  var_6 = var_4[1];
  self.setcustomization_body = var_5;
  self.setcustomization_head = var_6;
  self setcustomization(var_5, var_6);
  wait 0.05;
  var_4 = getoperatorcustomization();
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = var_4[2];

  if(!isagent(self)) {
    self setcustomization(var_5, var_6);
    var_8 = self getcustomizationbody();
    var_9 = self getcustomizationhead();
    var_10 = self getcustomizationviewmodel();
    var_11 = getplayerviewmodelfrombody(var_5);
  } else {
    var_8 = "_encstr_9BB12213BDC897EBB70733BDC9362B7D1BEDE6237B73FAE8599393F6932DB9E8F589D746";
    var_9 = "_encstr_B1BB1014B72AFA0761C250022FAEB0C8AA0B";
    var_10 = "_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707";
    var_11 = "_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707";
  }

  var_2 = lookupcurrentoperator(self.team);
  var_12 = lookupcurrentoperatorskin(self.team);
  var_13 = spawnStruct();
  var_13.operatorref = var_2;
  var_13.skinref = var_12;
  var_13.body = var_5;
  var_13.defaultbody = var_8;
  var_13.head = var_6;
  var_13.defaulthead = var_9;
  var_13.vm = var_11;
  var_13.defaultvm = var_10;
  var_13.gender = getoperatorgender(var_2);
  var_13.voice = getoperatorvoice(var_2, var_12);
  var_13.clothtype = resetplayermovespeedscale(var_12);
  var_13.superfaction = getoperatorsuperfaction(var_2);
  var_13.execution = getoperatorexecution(var_2);
  var_13.oic_rewardammo = resetposition(var_2);
  var_13.suit = var_7;
  var_13.rebuild = 0;
  var_13.superfaction = getoperatorsuperfaction(var_2);
  self.operatorcustomization = var_13;
  setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
  var_14 = spawnStruct();
  var_14.apc = runbrgametypefunc6("_encstr_8C1904676089");
  var_14.c4_pick_up_listener = rundomplateskybeam("_encstr_8C1904676089");
  var_14.check_cannot_spawn_tank = runbrgametypefunc6("_encstr_8C190467402B");
  var_14.get_extra_focus_fire_multipler = runbrgametypefunc6("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6");
  var_14.vehicle_damage_endburndown = runbrgametypefunc6("_encstr_85DE05A6B2AC0E");
  var_14.x1opsenableelimination = runbrgametypefunc6("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");
  var_14._id_139F7 = runbrgametypefunc6("_encstr_9A120A1D8536F5E4ED3BB293");
  var_14._id_13A47 = runbrgametypefunc6("_encstr_967E0A830E45C7671D993353");
  var_14._id_13A48 = rundomplateskybeam("_encstr_967E0A830E45C7671D993353");
  var_14._id_13A52 = runbrgametypefunc6("_encstr_A9F00A8E85CD6DEBBBCAE6D1");
  var_14._id_13A53 = rundomplateskybeam("_encstr_A9F00A8E85CD6DEBBBCAE6D1");
  var_14.c130airdrop_heightoverride = runcircles("_encstr_8C1904676089", 4);
  var_14.check_carrier_status = runcircles("_encstr_8C190467402B", 6);
  var_14.get_fake_digit_from_pool = runcircles("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 8);
  var_14.vehicle_damage_enginevisualclearcallback = runcircles("_encstr_85DE05A6B2AC0E", 10);
  var_14.x1opsendgame = runcircles("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", 12);
  var_14._id_139F8 = runcircles("_encstr_9A120A1D8536F5E4ED3BB293", 14);
  var_14.check_for_damage_scalar_change = runcontrolledcallback("_encstr_8C190467402B");
  var_14._id_139FC = runcontrolledcallback("_encstr_9A120A1D8536F5E4ED3BB293");
  var_14.zombieingas = runcontrolledcallback("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");
  self._id_14238 = var_14;

  if(self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](self))
    self[[level.change_to_terrorist_model_func]](self);

  if(isDefined(level._id_127F3))
    self[[level._id_127F3]]();
}

runbrgametypefunc6(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");
  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 4);
  return var_2;
}

runcontrolledcallback(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");
  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 10);
  return var_2;
}

rundomplateskybeam(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");
  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 5);
  return var_2;
}

runcircles(var_0, var_1) {
  var_2 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_A9CC0534F64EB9");
  var_3 = tablelookup("_encstr_A5951722A33F9A5302F372F0873E4369EAB86BD02BD8FECF0B", 0, var_2, var_1);
  return var_3;
}

getplayerbodymodel() {
  var_0 = getoperatorcustomization();
  return var_0[0];
}

getplayerviewmodelfrombody(var_0) {
  var_1 = tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_0, 3);

  if(!isDefined(var_1) || var_1 == "_encstr_B40101")
    var_1 = "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C";

  return var_1;
}

lookupcurrentoperator(var_0) {
  if(!isPlayer(self) && !isai(self))
    return "_encstr_B40101";

  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_B483160271B8BDE2F50353875115BBF12098FA048810458B");
  var_2 = var_1;
  var_3 = scripts\cp\utility::getgametype() == "_encstr_B607038AAB";

  if(!level.teambased || var_3) {
    var_1 = undefined;

    if(isai(self))
      var_1 = self.botoperatorteam;
    else
      var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_B483160271B8BDE2F50353875115BBF12098FA048810458B");

    var_2 = var_1;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(var_2 == 0)
        self.defaultoperatorteam = "_encstr_9A8507BA4040188D08";
      else
        self.defaultoperatorteam = "_encstr_8E8405EA382B2A";
    }
  }

  if(!isDefined(level.playercustomizationdata))
    level.playercustomizationdata = [];

  var_4 = self getentitynumber();
  level.playercustomizationdata[var_4] = [];
  var_5 = undefined;

  if(!isDefined(level.playercustomizationdata[var_4][var_0])) {
    var_6 = spawnStruct();

    if(isai(self))
      var_6.operatorref = self.botoperatorref;
    else
      var_6.operatorref = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_AA5C0AFFB72143DE697B535B", var_2);

    level.playercustomizationdata[var_4][var_0] = var_6;
  }

  var_5 = level.playercustomizationdata[var_4][var_0].operatorref;

  if(getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && self calloutmarkerping_getEnt()) {
    initoperatorcustomization();
    var_7 = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.showempminimap)) {
      foreach(var_9 in var_7) {
        var_10 = getarraykeys(level.operatorcustomization[var_9]);

        if(!isDefined(level.showing_ui_record))
          level.showing_ui_record = [];

        if(!isDefined(level.showing_ui_record[var_9]) || level.showing_ui_record[var_9] > var_10.size)
          level.showing_ui_record[var_9] = 0;

        for(var_11 = var_10[level.showing_ui_record[var_9]]; isDefined(var_11) && (var_11 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65" || var_11 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B"); var_11 = var_10[level.showing_ui_record[var_9]]) {
          level.showing_ui_record[var_9] = level.showing_ui_record[var_9] + 1;

          if(level.showing_ui_record[var_9] > var_10.size)
            level.showing_ui_record[var_9] = 0;
        }

        level.showing_ui_record[var_9] = level.showing_ui_record[var_9] + 1;
        level.playercustomizationdata[var_4][var_9] = spawnStruct();
        level.playercustomizationdata[var_4][var_9].operatorref = var_11;
      }

      self.showempminimap = 1;
    }

    if(isDefined(level.operatorcustomization[var_0]))
      var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
    else {
      if(!isDefined(self.botoperatorteam))
        self.botoperatorteam = scripts\engine\utility::random(var_7);

      var_5 = level.playercustomizationdata[var_4][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(var_5) || var_5 == "_encstr_B40101") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[var_4][var_0].operatorref))
          var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
        else
          var_5 = self.botoperatorref;
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var_7 = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(var_7);
          }
        }

        var_0 = self.botoperatorteam;

        if(!isDefined(self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"])) {
          var_1 = randomint(level.operatorcustomization[var_0].size);
          self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"] = var_1;
        } else
          var_1 = self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"];

        var_13 = 0;

        foreach(var_16, var_15 in level.operatorcustomization[var_0]) {
          if(var_13 == var_1) {
            self.botoperatorref = var_16;
            var_5 = var_16;
            break;
          }

          var_13++;
        }
      }
    } else
      var_5 = "_encstr_81A10E47316A2385D183BD4E35859620";
  }

  return var_5;
}

lookupcurrentoperatorskin(var_0) {
  var_1 = lookupcurrentoperator(var_0);
  var_2 = undefined;
  var_3 = self getentitynumber();

  if(getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && self calloutmarkerping_getEnt()) {
    if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
      if(!isDefined(level.showing_bomb_wire_pair_to_player))
        thermite_doradiusdamage();

      var_4 = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"];
      level.playercustomizationdata[var_3][var_0].operatorskinindex = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A18C08D8F67B1D52116E"][var_4];
      level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] + 1;

      if(level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] >= level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A39D0918EEC0F188825F21"])
        level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] = 0;
    }
  } else if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid))
        debug_interaction_toggle(var_1);

      level.playercustomizationdata[var_3][var_0].operatorskinindex = self.botskinid;
    } else
      level.playercustomizationdata[var_3][var_0].operatorskinindex = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_1, "_encstr_8D18056EADA59B");
  }

  var_2 = level.playercustomizationdata[var_3][var_0].operatorskinindex;

  if(isai(self) && (!isDefined(var_2) || var_2 == 0) || !isDefined(var_2) || var_2 == 0) {
    if(isai(self)) {
      if(isDefined(self.botskinid))
        var_2 = self.botskinid;
      else
        debug_interaction_toggle(var_1);
    } else
      var_2 = 1;
  }

  return var_2;
}

debug_interaction_toggle(var_0) {
  var_1 = self.team;

  if(isDefined(self.botoperatorteam))
    var_1 = self.botoperatorteam;

  if(!isDefined(self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"])) {
    var_2 = randomint(level.operatorcustomization[var_1][var_0].size);
    self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"] = var_2;
  } else
    var_2 = self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"];

  var_3 = 0;

  foreach(var_8, var_5 in level.operatorcustomization[var_1][var_0]) {
    if(var_3 == var_2) {
      var_6 = int(tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 1, var_8, 0));
      self.botskinid = var_6;
      var_7 = var_6;
      break;
    }

    var_3++;
  }
}

thermite_doradiusdamage() {
  if(isDefined(level.showing_bomb_wire_pair_to_player)) {
    return;
  }
  level.showing_bomb_wire_pair_to_player = [];
  var_0 = tablelookupgetnumrows("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 18) != "_encstr_B40101") {
      var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 2);
      var_3 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 0);

      if(!isDefined(level.showing_bomb_wire_pair_to_player[var_2])) {
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"] = [];
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A25B092863AAABF0D32D73"] = 0;
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] = 0;
      }

      level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"][level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"].size] = int(var_3);
      level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] = level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] + 1;
    }
  }
}

lookupotheroperator(var_0) {
  if(!isPlayer(self) && !isai(self))
    return "_encstr_B40101";

  var_1 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", 1, 0);
  var_2 = self getentitynumber();
  var_3 = "_encstr_B40101";
  var_0 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  if(scripts\cp\utility::getgametype() != "_encstr_B607038AAB") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[var_2][var_0])) {
        var_4 = spawnStruct();
        var_4.operatorref = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_AA5C0AFFB72143DE697B535B", var_1);
        level.playercustomizationdata[var_2][var_0] = var_4;
      }

      var_3 = level.playercustomizationdata[var_2][var_0].operatorref;
    }
  }

  return var_3;
}

initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }
  level.operatorcustomization = [];
  setDvar("_encstr_A7F7191B36BECD8E4EAC58D6D45EB936AF462BEC93B762C247C6D0", 1);
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_0, 1);
    var_2 = getoperatorsuperfaction(var_1);
    var_3 = scripts\engine\utility::ter_op(var_2 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_4 = int(tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_0, 8));

    if(var_4) {
      if(!isDefined(level.operatorcustomization[var_3]))
        level.operatorcustomization[var_3] = [];

      level.operatorcustomization[var_3][var_1] = [];
    }

    var_0++;
  }

  var_5 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_5, 2);
    var_6 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_5, 1);
    var_7 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_5, 4);
    var_8 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_5, 5);

    if(!isDefined(var_6) || var_6 == "_encstr_B40101") {
      break;
    }

    var_3 = getoperatorteambyref(var_1);

    if(!isDefined(var_3)) {
      var_5++;
      continue;
    }

    var_9 = [];
    var_9[0] = var_7;
    var_9[1] = var_8;
    level.operatorcustomization[var_3][var_1][var_6] = var_9;
    var_5++;
  }
}

getoperatorteambyref(var_0) {
  foreach(var_6, var_2 in level.operatorcustomization) {
    foreach(var_5, var_4 in var_2) {
      if(var_5 == var_0)
        return var_6;
    }
  }

  return undefined;
}

pickdefaultoperatorskin(var_0) {
  var_1 = 0;
  var_2 = self.primaryweapon;

  if(isDefined(var_2)) {
    var_3 = scripts\cp\cp_weapon::getweapongroup(var_2);

    switch (var_3) {
      case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        var_1 = 0;
        break;
      case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        var_1 = 1;
        break;
      case "_encstr_A1710B57AD31DBCDCDF1422A60":
      case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
        var_1 = 2;
        break;
      case "_encstr_A3710BEEACC2E0B737EB36B676":
        var_1 = 3;
        break;
      case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        var_1 = 4;
        break;
      default:
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

getoperatorcustomization() {
  var_0 = lookupcurrentoperator(self.team);
  var_1 = lookupcurrentoperatorskin(self.team);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if((var_0 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65" || var_0 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B") && (var_1 == 274 || var_1 == 275)) {
    initdefaultoperatorskins();
    var_5 = level.teambased && scripts\cp\utility::getgametype() != "_encstr_B607038AAB";

    if(!isDefined(self.defaultoperatorteam) || var_5 && self.defaultoperatorteam != self.team && (self.team == "_encstr_9A8507BA4040188D08" || self.team == "_encstr_8E8405EA382B2A")) {
      var_6 = "_encstr_9A8507BA4040188D08";

      if(var_0 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B")
        var_6 = "_encstr_8E8405EA382B2A";

      self.defaultoperatorteam = var_6;

      if(self.team != "_encstr_9A8507BA4040188D08" && self.team != "_encstr_8E8405EA382B2A")
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
    }

    if(!isDefined(self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]))
      self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"] = 0;

    var_2 = level.defaultoperatorskins[self.defaultoperatorteam]["_encstr_AD9B0589ED9197"][self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]];

    if(!isDefined(self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"]))
      self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"] = scripts\engine\utility::random(level.defaultoperatorskins[self.defaultoperatorteam]["_encstr_81CC0586952C91"][self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]]);

    var_3 = self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"];
    var_4 = "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939";
  } else {
    var_2 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 4);
    var_3 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 5);
    var_4 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 19);
  }

  self.bodymodelname = var_2;
  self.backuphead = var_3;
  self.backupsuit = var_4;
  var_7 = [];
  var_7[0] = var_2;
  var_7[1] = var_3;
  var_7[2] = var_4;
  return var_7;
}

initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"] = [];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042", "_encstr_95262B26B752B8BF803331575D2ADB5F5A5E3FC5BB33BDA4B937F9A940CF427019C22D322F7EA0CBEF19D0B55B", "_encstr_9A7C2B4CDE235EF5DAC1FADD2BE63AB293CDD7335AE49547CA165BF5DD59E6D1D7325B27EBC4EB62AFD8B79198", "_encstr_81AC2B6AB089E72923701993F037DB2FE3A8CFE6DB13DF2BEB0B2229786352A3BE01759F7893EF22F7400A9222", "_encstr_91E02ACEE0C52BE7AFE3FE1BD7C389833B884F8D68F875E3FF83DDA7DB81372B60A77FA1BF8FB7E660D00149"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][0] = ["_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_9A5F25A4F1AB408942B079FC7D83331A36E55FCC10509513A217D9BF3347D3B9C9B10A485B5962"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][1] = ["_encstr_AF192683EBAF5A477803D12359709482FE65D7035B4E32241009552133E8DBCBC0B7878F4F5759B9", "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][2] = ["_encstr_828F26F8AF99D850D2CBAFF7B71B0D6822C586B1D4D298FD8A77D39FE702D628F7DF484BF1799117", "_encstr_958F26A159C232D7B51CBEEE2BB9D195C973D7999627561D560BB57DEE95DC47D7196B9CEB64FA62"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][3] = ["_encstr_81252698DBD087891D5BE9EB45EB5DD03D5A39CA135B822CCF63281F309043F410C0704707CB9957", "_encstr_9B25263219072B69A8298FAF2B70EB9736D0D95A6066E79BB073A5BF1738F29BC80872B20E1E5702"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][4] = ["_encstr_84522581C74265A10D7A869B27FB302D8B0377154FDBBD805D16C8964BD550DDF1EF8FDF46515F", "_encstr_9B522558FB382F47894BB923F1DEA3271845F7DE1B48B7D3A50192A99B3D67DB19E7471F0579EA"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_8419056EBAB41D"] = ["_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"] = [];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_9A3126886A87534E1FC0180DA91F53236AE2E910A2DA93E317F91968857F7BD9997A18510A35D913", "_encstr_8874272A9768102FE153913A59C65BCF306D9FB633605FCB9D698A8121170FC301FF553FC7F865739F", "_encstr_850327137B235EBE6BC1AFB216CDA32B4E73BE335AC9ACA3CA58ADFACA0BDCA3EB19DAC9BEB1BD8C4C", "_encstr_9932279DE71AE39905729ED1DEE33815937B6F2D5723A588250EC06EC7D948D5F99B93A7F76A78D029", "_encstr_8B2A2658BA57A3BEEF10C8DD194F03533A5239E0726AC393A729E9D8F52FAB09292B3BA1BA4509C3"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][0] = ["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103", "_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA", "_encstr_AFB023862B2C8CBEDAE0FAB20BCDD1CA39E6EB99B49CB2D1CA85D6AFAC0BB9D1F55827F566", "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][1] = ["_encstr_A7042418FD5BBB57D25B09E880C7EB0D6D1E17CAAA823F890D3F3FC1452F17E5D78E6D47B7B1", "_encstr_9B042463FD20DC21ED8B56F7E37BD0A2AA630F69F38BEF88B86769719279E3D391C657472992", "_encstr_9904241047412388FAF3878BCF6365400A1D7E69ECBAF0D5529FEBF7F76A2E108F32A0C19943"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][2] = ["_encstr_8C20225CF58B0A0FF8D81FFF7813FCC2459869576B15526C8148EF0FA089B39B47256DCA"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][3] = ["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839", "_encstr_8652241227682C9780830EB20A2F3817F86DE1DA93E8A235E25F4D1151267B9B7F5D9EC9B7D2"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][4] = ["_encstr_8FBA218AA1BF83C170C17755FBD853CF5EB871F2888E5FC3D8CB4D679B605A7310B38A"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_8419056EBAB41D"] = ["_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939", "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939"];
}

getoperatorexecution(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_0, "_encstr_B1100A561EACC6AB3AB47BCD");

  if(var_1 == 0)
    self.loadoutexecution = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 24);
  else
    self.loadoutexecution = tablelookup("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", 0, var_1, 1);

  return self.loadoutexecution;
}

resetposition(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_0, "_encstr_AD2906FBFA7593E3");

  if(var_1 == 0)
    self._id_1195C = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 23);
  else
    self._id_1195C = tablelookup("_encstr_8887127B0759E42C8EBD4E17574B0EE6C5D89B3B", 0, var_1, 6);

  return self._id_1195C;
}

getoperatorsuperfaction(var_0) {
  var_1 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 3);
  return int(var_1);
}

getoperatorvoice(var_0, var_1) {
  if(var_0 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B" || var_0 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65") {
    var_2 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 24);

    if(isDefined(var_2) && var_2 != "_encstr_B40101")
      return var_2;
  }

  var_2 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 10);
  return var_2;
}

resetplayermovespeedscale(var_0) {
  var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 22);
  return var_1;
}

getoperatorgender(var_0) {
  var_1 = scripts\engine\utility::ter_op(tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 11) == "_encstr_934C0218", "_encstr_A6A205ADB0632B", "_encstr_B82907C2887BC62B39");
  return var_1;
}

get_player_character_num() {
  if(isDefined(self.player_character_num))
    return self.player_character_num;

  var_1 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = var_1;
  return var_1;
}

setplayerhudphoto(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0 getentitynumber();

  if(var_2 == 4)
    var_2 = 0;

  var_0.bit_position = get_bit_position(var_2);
  var_0.player_character_index = var_1;

  if(isDefined(level.skip_playerhudphoto)) {
    var_0.player_character_index = 1;
    var_1 = 1;
  }

  wait 5.0;
}

set_player_photo_status(var_0, var_1) {
  set_player_photo_option(var_0, "_encstr_A71411BB38BE289AA3DB37EAD06FD3C1231007", get_status_bit_value(var_1));
}

set_player_photo_option(var_0, var_1, var_2) {
  if(isDefined(var_0.bit_position)) {
    setomnvarbit(var_1, var_0.bit_position.bit_3, var_2.bit_3);
    setomnvarbit(var_1, var_0.bit_position.bit_2, var_2.bit_2);
    setomnvarbit(var_1, var_0.bit_position.bit_1, var_2.bit_1);
    var_0.photosetup = 1;
  }
}

get_bit_position(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 3:
      var_1.bit_3 = 11;
      var_1.bit_2 = 10;
      var_1.bit_1 = 9;
      break;
    case 2:
      var_1.bit_3 = 8;
      var_1.bit_2 = 7;
      var_1.bit_1 = 6;
      break;
    case 1:
      var_1.bit_3 = 5;
      var_1.bit_2 = 4;
      var_1.bit_1 = 3;
      break;
    case 0:
      var_1.bit_3 = 2;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
  }

  return var_1;
}

get_character_bit_value(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case 0:
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
    case 1:
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 1;
      break;
    case 2:
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
    case 3:
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 1;
      break;
    case 4:
      var_1.bit_3 = 1;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
  }

  return var_1;
}

get_status_bit_value(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "_encstr_ADD308E8E3E8690D1180":
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 0;
      break;
    case "_encstr_93C508AF0763AAA769E8":
      var_1.bit_3 = 0;
      var_1.bit_2 = 0;
      var_1.bit_1 = 1;
      break;
    case "_encstr_A5510A30AA778D28B3C97D51":
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 0;
      break;
    case "_encstr_8E190AB1FC435F5A19F0D2FA":
      var_1.bit_3 = 0;
      var_1.bit_2 = 1;
      var_1.bit_1 = 1;
      break;
  }

  return var_1;
}

setcharactermodels(var_0, var_1, var_2, var_3) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(var_0);
  self setviewmodel(var_2);
  self attach(var_1, "_encstr_B40101", 1);
  self.bodymodel = var_0;
  self.headmodel = var_1;
  self.viewmodel = var_2;
}

getplayermodelindex() {
  return 0;
}

getplayerfoleytype(var_0) {
  return tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 22);
}

updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1.0;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      var_0 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      var_0 = self.siege_speedscale;
    else if(isDefined(self.overrideweaponspeed_speedscale))
      var_0 = self.overrideweaponspeed_speedscale;

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod))
      var_0 = var_0 + var_1.speedmod;

    if(isDefined(self.speedstripmod))
      var_0 = var_0 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      var_0 = var_0 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      var_0 = var_0 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      var_0 = var_0 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      var_0 = var_0 + self.weaponpassivespeedonkillmod;

    var_0 = min(1.5, var_0);
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(var_0 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("_encstr_862C19C5E885B209E03893177138CFCB73718F7DCDB72B40E970E3", "_encstr_AB0703DBB9") == "_encstr_AB0703DBB9")
    return 1.0;

  if(!self.weaponlist.size)
    var_1 = 0.9;
  else {
    var_2 = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(var_2))
      var_1 = level.superweapons[createheadicon(var_2)].movespeed;
    else {
      var_3 = weaponinventorytype(var_2);

      if(var_3 != "_encstr_BA7F0830B3A7859B60B0" && var_3 != "_encstr_B4DC085639F9C2779108") {
        if(isDefined(self.saved_lastweapon))
          var_2 = self.saved_lastweapon;
        else
          var_2 = undefined;
      }

      if(!isDefined(var_2) || !self hasweapon(var_2))
        var_1 = getweaponspeedslowest();
      else
        var_1 = getweaponspeed(var_2);
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

getweaponspeed(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = level.weaponmapdata[var_1].speed;
  return var_2;
}

getweaponspeedslowest() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponspeed(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 0.9;

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

clampweaponspeed(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

getweaponheaviestvalue() {
  var_0 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      var_3 = getweaponweight(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 8;

  var_0 = clampweaponweightvalue(var_0);
  return var_0;
}

getweaponweight(var_0) {
  var_1 = undefined;
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_1 = float(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = float(tablelookup(level.game_mode_statstable, 4, var_2, 8));

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = 10;

  return var_1;
}

clampweaponweightvalue(var_0) {
  return clamp(var_0, 0.0, 11.0);
}

wait_and_force_weapon_switch(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;
  var_1 = self getweaponslistprimaries();

  if(!self hasweapon(var_0))
    var_0 = var_1[0];

  add_ammo_if_needed(var_1);
  self setspawnweapon(var_0);
}

add_ammo_if_needed(var_0) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["_encstr_A7FC1707DF3703BAA890F740C923B5A8F6C5500B5709985870"])) {
    foreach(var_2 in var_0)
    self givemaxammo(var_2);
  }
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = 1;
  level.scriptperks["_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F"] = 1;
  level.scriptperks["_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F"] = 1;
  level.scriptperks["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = 1;
  level.perksetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::setmomentum;
  level.perkunsetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::unsetmomentum;
  level.perksetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::setfreefall;
  level.perkunsetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::unsetfreefall;
}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

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
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait 0.4375;
  }

  self playlocalsound("_encstr_8ED00D32E85178BB50A33F95512BA8");
  self notify("_encstr_A92313E83FEDD1A53333D1F00D5AB1DE5BDB20D07B");
  thread momentum_endaftermax();
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

momentum_endaftermax() {
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self playlocalsound("_encstr_B2600E507538875308214A770FDADBB4");
}

momentum_monitormovement() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B2BE0788BAF573592F");
  self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

unsetmomentum() {
  self notify("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
}

setfreefall() {}

unsetfreefall() {}

set_player_perks() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_ACE709DA22939BA8075060") {
    wait 0.1;
    var_0 = 4;
    var_1 = 0;
    var_2 = 0;
    var_2 = var_0;

    if(isDefined(level.player_suit))
      self setsuit(level.player_suit);
    else
      self setsuit("_encstr_AB6C0C1784D2171608824D4727A0");

    self.suit = "_encstr_AB6C0C1784D2171608824D4727A0";
    self allowdoublejump(0);
    self allowslide(var_2 &var_0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);
  self notify("_encstr_9342113355B349DAB88E587F3A31C1AF03B00B");
}

registerplayercharacter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = spawnStruct();
  var_17.body_model = var_2;
  var_17.view_model = var_3;
  var_17.head_model = var_4;
  var_17.hair_model = var_5;
  var_17.vo_prefix = var_6;
  var_17.vo_suffix = var_7;
  var_17.pap_gesture = var_8;
  var_17.revive_gesture = var_9;
  var_17.photo_index = var_10;
  var_17.fate_card_weapon = var_11;
  var_17.intro_music = var_12;
  var_17.intro_gesture = var_13;
  var_17.melee_weapon = asmdevgetallstates(var_14);
  var_17.starting_weapon = asmdevgetallstates(var_16);
  var_17.post_setup_func = var_15;
  level.player_character_info[var_0] = var_17;

  if(!isDefined(level.available_player_characters))
    level.available_player_characters = [];

  if(var_1 == "_encstr_AC190463F552")
    level.available_player_characters[level.available_player_characters.size] = var_0;
}

respawnitems_assignrespawnitems(var_0) {
  self.respawnitems = var_0;
}

_id_13B0F() {
  if(!initmaxspeedforpathlengthtable(self)) {
    return;
  }
  if(getdvarint("_encstr_AAA3194790C3CFD35326BB7681139AB66B0993AF50BB3B5BB33C05", 0) > 0) {
    return;
  }
  thread scripts\cp\utility::notify_delay("_encstr_B4C40E582257FDB09BB4077FC103B8B0", 7);
  thread _id_13B0D();
}

_id_13B0D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0;

  if(getdvarint("_encstr_8CBC165E3EC35F53BD1F68D80BD90945CBA95DEF152AE7B9", 0) > 0)
    var_0 = 1;

  wait 5;
  announcement("_encstr_AC04200EEDCCA9239C31D8035F90582E42DD13631BF0C02E5A1097635AD04506C608");
  wait 5;

  for(;;) {
    if(getdvarint("_encstr_8CBC165E3EC35F53BD1F68D80BD90945CBA95DEF152AE7B9", 0) == 0) {
      waitframe();
      continue;
    }

    if(var_0 == 2) {
      scripts\engine\utility::_id_143A6("_encstr_BD3B15285AD599F9CB3FD75C0C17C3273AE25850F22BD5", "_encstr_86660C9CCAEC969DACF58C7BCDB2", "_encstr_9695073995D94BD959");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("_encstr_A1D714BC628ACA6E3AA18D9695E61D04447B7737598C");
    }

    if(var_0 == 0)
      setDvar("_encstr_8CBC165E3EC35F53BD1F68D80BD90945CBA95DEF152AE7B9", 0);

    if(var_0 == 1)
      var_0 = 2;
  }
}

getcustomization() {
  var_0 = [];

  if(isDefined(self.operatorcustomization)) {
    var_0["_encstr_AD9B0589ED9197"] = self.operatorcustomization.body;
    var_0["_encstr_81CC0586952C91"] = self.operatorcustomization.head;
  } else {
    var_1 = getoperatorcustomization();
    var_0["_encstr_AD9B0589ED9197"] = var_1[0];
    var_0["_encstr_81CC0586952C91"] = var_1[1];
  }

  return var_0;
}