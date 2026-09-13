/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ac1b431c0f54d19.gsc
***********************************************/

_id_4C60C607A6E7B9AE() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "mi8jugg";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_D05835744FF53415;
  _id_AED74300DAF62896._id_649245B52DBF88A9 = getdvarint("dvar_ACEA1DDA9CB3EFE0", 1);
  _id_AED74300DAF62896._id_4EA49A8926593523 = ::_id_B7F860050D8813BA;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_D616981B69C0AC49;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_FF8FACA7F9BA72CA;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_D05835744FF53415(_id_AED74300DAF62896) {
  level._id_7D967B9B6BB9F893 = getdvarint("dvar_6FED3B4AAB176FE6", 2);
  level._id_E533AB5AC1BA434B = 0;
  level._id_C03D5E749122F962 = getdvarfloat("dvar_CC4BF03BB4E7DF93", 0.05);
  level._id_851E7F7986C65F92 = getdvarfloat("dvar_F187251C0C77A93B", 0.02);
  level._id_01AB6CF2D7F3A688 = getdvarfloat("dvar_1099EBA3FC541217", 0);
  level._id_F9AF98AF7999B6B3 = getdvarint("dvar_B1C8778478F8CDB8", 3);
  level._id_C5D63564CA1319F5 = getdvarfloat("dvar_C13D8622F63D745E", 180) * 1000;
  level._id_BED696D2FF90F3F5 = getdvarfloat("dvar_3D6CAE74BE8BE42E", 120) * 1000;
  level._id_01AB6CF2D7F3A688 = level._id_01AB6CF2D7F3A688 * level._id_01AB6CF2D7F3A688;
  level._id_3592F67E3F4A6517 = getdvarint("dvar_4F71145C48A2769E", 1) == 1;
  level._id_7DBC2BB968D412AE = getdvarint("dvar_831358870679BA5F", 5000);
  level._id_8B082D73DBD8E395 = getdvarint("dvar_5A1E8F008C6957E4", 30) * 1000;
  level._id_BAFC83699E626C69 = int(level._id_8B082D73DBD8E395 * 0.4);
  _id_47FC06D4BB326007::_id_A414FBF48AE645F4();
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_jugg"])) {
    _id_9577902B42FBD7F6 = undefined;

    if(level.mapname == "mp_br_mechanics")
      _id_9577902B42FBD7F6 = [(-6307, 5336, 602)];
    else if(level.mapname == "mp_saba" || level.mapname == "mp_saba2" || level.mapname == "mp_saba_pm")
      _id_9577902B42FBD7F6 = [(-1354, -15088, 5106), (-9442, 7985, 498), (21154, -15594, 3756)];
    else if(level.mapname == "mp_sealion")
      _id_9577902B42FBD7F6 = [(-1020, -6084, 1288)];

    if(!isDefined(_id_9577902B42FBD7F6)) {
      return;
    }
    foreach(loc in _id_9577902B42FBD7F6) {
      struct = spawnStruct();
      struct.origin = loc;
      struct.angles = (0, 0, 0);
      struct._id_0032A16E8A7495D3 = 1;
      _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = struct;
    }
  } else {
    foreach(node in level.struct_class_names["script_noteworthy"]["boss_jugg"]) {
      _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;
      node._id_0032A16E8A7495D3 = 1;
    }
  }
}

_id_5F67707F4AC175E8() {
  level._id_B08B4D8A5FEDEBDB = ::_id_907EBCA277DD6F57;
}

_id_7F6818BE5068DD4E(loc) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("jugg");
  _id_E21279FA90BDF012 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "absolute", "bosses", "jugg", undefined, undefined, undefined, loc._id_B205D90302DA2F07, 1, 0, 0);

  if(!isDefined(_id_E21279FA90BDF012)) {
    return;
  }
  _id_371B4C2AB5861E62::_id_E43F4000CAC35BA2(_id_E21279FA90BDF012);
  _id_E21279FA90BDF012 _id_47FC06D4BB326007::_id_1CBB19FC0CAEAB00();
  _id_E21279FA90BDF012 setscriptablepartstate("loop_sounds", "music", 0);
  self.agent = _id_E21279FA90BDF012;
  self._id_9329E0D3CE1D5CA8 = "mi8jugg";
  _id_E21279FA90BDF012._id_0566868292EE2A1B = self;
  _id_2FDEB8023287BE67::_id_8002B09B8348902C(_id_E21279FA90BDF012.origin, "ui_map_icon_boss_juggernaut");
  thread _id_058BEC31C44DF07A();

  if(getdvarint("dvar_49B37FC622A4D585", 0) == 1)
    _id_E21279FA90BDF012 _meth_3DE79443C911D4A5(1, 4, "MP_DMZ_MISSIONS/DMZ_BOSS_JUGG_NAME");

  thread _id_F365641C010B0F74();
  _id_E21279FA90BDF012._id_A4738C70736D3A61 = ::_id_9188F360F73C894A;
  _id_E21279FA90BDF012._id_9329E0D3CE1D5CA8 = "mi8jugg";
  _id_E21279FA90BDF012._id_3092984EC59269C2 = 1;
  _id_E21279FA90BDF012.disablereload = 1;
  _id_E21279FA90BDF012._id_51642E27C7E7D224 = 0;
  _id_918249FD5219A579 = scripts\engine\utility::ter_op(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "boss" && level._id_7F7B9B8BB18CC33C == "mi8jugg", "brloot_weaponcase", undefined);
  _id_E21279FA90BDF012 _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("mi8jugg", 0, _id_918249FD5219A579);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(_id_E21279FA90BDF012, "dropWeapon", 0);
  _id_E21279FA90BDF012 aisetdesiredspeed(40);

  if(istrue(level._id_22405C0E11052FFF))
    _id_E21279FA90BDF012 thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(2000);

  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["dmz_boss_jugg_escape", 0.0];
  _id_985AE874212B863E["combat"] = ["dmz_boss_jugg_combat", 1.5];
  _id_6B9A0DBBF039DECE = 1;
  thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(self, _id_985AE874212B863E, level._id_BAFC83699E626C69, level._id_8B082D73DBD8E395, _id_6B9A0DBBF039DECE);
  return _id_E21279FA90BDF012;
}

_id_058BEC31C44DF07A() {
  self.agent endon("death");

  for(;;) {
    scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.agent.origin + (0, 0, 80));
    waitframe();
  }
}

_id_9188F360F73C894A(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_47FC06D4BB326007::_id_1AB798A528080DB2(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_1742A7111D144796() {
  level endon("game_ended");
  juggcontext = self.juggcontext;
  _id_CBCC20CC563590C7 = "agentObjective";
  self._id_68C43B3FFEE58999 = "mi8jugg_fatal_damage";
  scripts\cp_mp\killstreaks\juggernaut::createjuggobjective(_id_CBCC20CC563590C7);
  self waittill(self._id_68C43B3FFEE58999);
  scripts\cp_mp\killstreaks\juggernaut::cleanupjuggobjective(juggcontext, _id_CBCC20CC563590C7);
}

_id_FF8FACA7F9BA72CA(struct) {
  _id_E21279FA90BDF012 = _id_7F6818BE5068DD4E(struct);
  _id_E21279FA90BDF012 _id_120270BD0A747A35::_id_304DA84D9A815C01(_id_E21279FA90BDF012.origin, 4000);
}

_id_B7F860050D8813BA() {
  if(!level._id_3592F67E3F4A6517) {
    return;
  }
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("mi8jugg");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  _id_4673B0931E86514C = "Boss_Focus_Dmz";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    _id_4673B0931E86514C = "Boss_Focus_SM_Dmz";

  if(istrue(_id_0BAA08EA813E9752._id_0032A16E8A7495D3)) {
    instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("mi8jugg");
    instance._id_FB1DEF007972B25A = _id_0BAA08EA813E9752.origin;
    instance._id_E2958F412A7425C0 = instance _id_7F6818BE5068DD4E(_id_0BAA08EA813E9752);
    instance notify("boss_spawned");

    if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "boss" && level._id_7F7B9B8BB18CC33C == "mi8jugg") {
      instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_4673B0931E86514C, _id_0BAA08EA813E9752.origin, level._id_7DBC2BB968D412AE);
      instance scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
      instance thread _id_2FDEB8023287BE67::_id_3C9B7EA5BE9B4602(instance._id_E2958F412A7425C0);
    }

    instance._id_E2958F412A7425C0 _id_120270BD0A747A35::_id_304DA84D9A815C01(_id_0BAA08EA813E9752.origin, level._id_7DBC2BB968D412AE);
  } else {
    instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("mi8jugg");

    if(isDefined(_id_0BAA08EA813E9752.target)) {
      _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");
      instance.nodes = [];

      foreach(node in _id_A942AE9112CD6BDE) {
        if(!isDefined(instance.nodes[node.script_noteworthy]))
          instance.nodes[node.script_noteworthy] = [];

        instance.nodes[node.script_noteworthy][instance.nodes[node.script_noteworthy].size] = node;
      }

      instance._id_E2958F412A7425C0 = instance _id_7F6818BE5068DD4E(instance.nodes["boss_jugg_patrolPath"][0]);
      instance notify("boss_spawned");

      if(!isDefined(instance._id_E2958F412A7425C0)) {
        return;
      }
      pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(instance.nodes["boss_jugg_patrolPath"][0]);
      level thread _id_120270BD0A747A35::_id_25CC93D439C3033A([instance._id_E2958F412A7425C0], pathstruct);
    } else {
      instance._id_E2958F412A7425C0 = instance _id_7F6818BE5068DD4E(_id_0BAA08EA813E9752);
      instance notify("boss_spawned");
    }
  }
}

_id_907EBCA277DD6F57(_id_C5E7FCE963586EC0, team, _id_171F90B9C4C76D44) {
  if(!isDefined(level.starttime))
    return undefined;

  if(gettime() - level.starttime < level._id_C5D63564CA1319F5)
    return undefined;

  if(isDefined(level._id_6EDB015297C88122) && gettime() - level._id_6EDB015297C88122 < level._id_BED696D2FF90F3F5)
    return undefined;

  if(level._id_E533AB5AC1BA434B < level._id_7D967B9B6BB9F893 && randomfloat(1) < level._id_C03D5E749122F962) {
    level._id_E533AB5AC1BA434B = level._id_E533AB5AC1BA434B + 1;
    level._id_C03D5E749122F962 = getdvarfloat("dvar_CC4BF03BB4E7DF93", 0.05);
    level._id_6EDB015297C88122 = gettime();
    return _id_68CC535C0FFC6294(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  }

  level._id_C03D5E749122F962 = level._id_C03D5E749122F962 + level._id_851E7F7986C65F92;
  return undefined;
}

_id_68CC535C0FFC6294(pos, _id_171F90B9C4C76D44) {
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(pos, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = getclosestpointonnavmesh(_id_C5E7FCE963586EC0);
  _id_9E334397541DCA8E = [[level._id_04EB71F2B8CBA5CB]](_id_C5E7FCE963586EC0, undefined);

  if(isDefined(_id_9E334397541DCA8E)) {
    _id_9E334397541DCA8E.node._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;
    vehicle = level _id_60F7007F85DDF50D(_id_9E334397541DCA8E.node);

    if(isDefined(vehicle)) {
      level thread _id_94C71415F3E1292E(_id_9E334397541DCA8E.node.origin);
      return vehicle.riders;
    }
  }

  return undefined;
}

_id_60F7007F85DDF50D(_id_A4E4A71852A83D8F) {
  _id_BC676A8C07563150 = 2;

  if(isDefined(_id_A4E4A71852A83D8F.spawngroup)) {
    riders = [];
    _id_E2958F412A7425C0 = _id_7F6818BE5068DD4E(_id_A4E4A71852A83D8F);

    if(!isDefined(_id_E2958F412A7425C0)) {
      return;
    }
    _id_E2958F412A7425C0.script_startingposition = 2;
    _id_E2958F412A7425C0.vehicle_position = _id_E2958F412A7425C0.script_startingposition;
    _id_E2958F412A7425C0 thread _id_E7D3411DB935E99B(2);
    riders[0] = _id_E2958F412A7425C0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F9AF98AF7999B6B3; _id_AC0E594AC96AA3A8++) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, undefined, undefined, 3);
      guard = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_A4E4A71852A83D8F.origin, _id_A4E4A71852A83D8F.angles, "high", "bossMinions", "juggGuards", undefined, undefined, undefined, _id_A4E4A71852A83D8F._id_B205D90302DA2F07);

      if(!isDefined(guard)) {
        continue;
      }
      guard.script_startingposition = 3 + _id_AC0E594AC96AA3A8;
      guard.vehicle_position = guard.script_startingposition;
      guard thread _id_E7D3411DB935E99B(guard.vehicle_position);
      riders[riders.size] = guard;
    }

    waitframe();
    _id_A4E4A71852A83D8F._id_F16652E1462A3739 = 1;
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", _id_A4E4A71852A83D8F);
    vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
    vehicle _meth_247AD6A91F6A4FFE(1);
    vehicle._id_B205D90302DA2F07 = _id_A4E4A71852A83D8F._id_B205D90302DA2F07;
    vehicle endon("death");
    vehicle.riders = riders;

    foreach(rider in riders) {
      _id_B87E69DF003B39F5 = vehicle scripts\common\vehicle_aianim::get_availablepositions();
      pos = vehicle scripts\common\vehicle_aianim::choose_vehicle_position(rider, _id_B87E69DF003B39F5, 0);
      rider scripts\vehicle\vehicle_common::entervehicle(vehicle, 1, pos, scripts\common\vehicle_aianim::anim_pos(vehicle, pos.vehicle_position));
      rider.vehicle_position = pos.vehicle_position;
    }

    wait 1;
    level thread _id_2BC0B0102F9B7751::_id_BBFEB6CFDBC102A1(vehicle, _id_A4E4A71852A83D8F, "lbravo_infil_cp");
    return vehicle;
  }
}

_id_F365641C010B0F74() {
  self.agent waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(self, _id_6181DE250AFA5BB6, "dmz_boss_jugg_win", 2.5, "dmz_boss_jugg_escape", 0.0);
    _id_74B5B12BB6514385 = 5.0;
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_juggernaut_eliminated", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }

  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  scripts\mp\gameobjects::releaseid();
}

_id_E7D3411DB935E99B(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

_id_94C71415F3E1292E(_id_EB4D81FD840007E2) {
  if(level._id_01AB6CF2D7F3A688 < 0) {
    return;
  }
  if(level._id_01AB6CF2D7F3A688 > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, _id_EB4D81FD840007E2) < level._id_01AB6CF2D7F3A688)
        playerlist[playerlist.size] = player;
    }
  } else
    playerlist = level.players;

  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_EB4D81FD840007E2, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_boss_juggernaut_inbound", playerlist, _id_171F90B9C4C76D44);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("boss_juggernaut_near", playerlist, 2.0);
}

_id_6B89DF10A0A88C5B(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 endon("death");
  level endon("game_ended");

  for(;;) {
    _id_E21279FA90BDF012 setscriptablepartstate("backpack", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("forearmpad_l", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("forearmpad_r", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("neckguard", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("shoulderpad_l", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("shoulderpad_r", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("thighpad_l", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("thighpad_r", "damaged");
    _id_E21279FA90BDF012 setscriptablepartstate("helmet", "damaged");
    wait 3;
    _id_E21279FA90BDF012 setscriptablepartstate("backpack", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("forearmpad_l", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("forearmpad_r", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("neckguard", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("shoulderpad_l", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("shoulderpad_r", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("thighpad_l", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("thighpad_r", "pristine");
    _id_E21279FA90BDF012 setscriptablepartstate("helmet", "pristine");
    wait 3;
  }
}

_id_D616981B69C0AC49(player, showicon) {
  team = player.team;

  if(!isDefined(self.agent) || !isalive(self.agent) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  if(!istrue(showicon) && scripts\engine\utility::array_contains(self._id_673ECECEE90D036E, team))
    return 0;

  if(istrue(showicon)) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
    self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  }

  self._id_673ECECEE90D036E = scripts\engine\utility::array_add(self._id_673ECECEE90D036E, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.agent.origin, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_jugg_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_juggernaut_near", team, 2.0);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_jugg_approach", 1.5, _id_6B9A0DBBF039DECE);
  return 1;
}