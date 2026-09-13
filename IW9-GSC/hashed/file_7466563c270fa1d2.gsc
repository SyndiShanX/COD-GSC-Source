/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7466563c270fa1d2.gsc
***********************************************/

_id_4A755326CD53D3B3() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.armor = getdvarfloat("dvar_60A6F859CC67B71B", 5000);
  _id_AED74300DAF62896.maxdamage = getdvarint("dvar_C35DE7777481DF06", 100);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];
  _id_AED74300DAF62896.name = "pyro";
  _id_AED74300DAF62896._id_649245B52DBF88A9 = getdvarint("dvar_F454D60A0AC05167", 2);
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_9A5C6E540A2F3340;
  _id_AED74300DAF62896._id_4EA49A8926593523 = ::_id_54E8128B3D5CC8AB;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_4108074415ABC816;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_15E3559F29693C1F;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_9A5C6E540A2F3340(_id_AED74300DAF62896) {
  level._id_C8C9FE6038E69B34 = getdvarint("dvar_6968AB4B0D874C4D", 30) * 1000;
  level._id_AD758BDA532F9152 = int(level._id_C8C9FE6038E69B34 * 0.4);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_pyro"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_pyro"])
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;

  _id_03A246920C9288C4::trophy_init();
}

_id_B9AF1A95F5D7A50B() {
  level thread _id_54E8128B3D5CC8AB();
}

_id_4108074415ABC816(_id_58C817414D96DE59, _id_4DDD755385BF05CF) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("riotshield", 3);
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_58C817414D96DE59.origin, _id_58C817414D96DE59.angles, "absolute", "bosses", " pyroBoss", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  _id_E2958F412A7425C0._id_B582B10663B5B2A9 = 0;
  _id_FB62BCEF7FAB15FB(_id_E2958F412A7425C0);
  _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_153057A89F66A0F9;
  _id_E2958F412A7425C0 thread _id_120270BD0A747A35::_id_C7307D56A1A61172(_id_E2958F412A7425C0);
  return _id_E2958F412A7425C0;
}

_id_FB62BCEF7FAB15FB(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "molotov_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = level.br_lootiteminfo["brloot_weapon_sh_vecho_lege"].fullweaponobj;
  armor = 3000;
  helmet = 10;
  agent._id_668B72F41E87C75A = 1;
  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;

  if(getdvarint("dvar_2F83E02F5B876153", 1) == 1)
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_plate_carrier_tempered", undefined, undefined, 1);

  _id_48814951E916AF89::_id_63A043D47490F90D(agent, ",brloot_pyro_intel", undefined, undefined, 1);
  _id_918249FD5219A579 = scripts\engine\utility::ter_op(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "boss" && level._id_7F7B9B8BB18CC33C == "pyro", "brloot_weaponcase", undefined);
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_sp_opforce_al_qatala_boss_pyro", "head_sp_opforce_al_qatala_boss_pyro", weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("pyro", 0, _id_918249FD5219A579);
  agent thread _id_371B4C2AB5861E62::_id_0036613FFB5EBE56(agent);
  agent _meth_8ABE5A968CC3C220("scubagr");
  agent setclothtype("vestheavy");
}

_id_F040EFE2F90B41FB() {}

_id_153057A89F66A0F9(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!istrue(self._id_E6AF4BA7CF5CC852) && isDefined(shitloc) && shitloc == "shield") {
    time = gettime();

    if(!isDefined(self._id_E494707422B1CFE6))
      self._id_E494707422B1CFE6 = time;

    if(isDefined(self._id_F35DE24A74B2DD14) && time - self._id_F35DE24A74B2DD14 > self._id_A7AAE99DA4C9E990) {
      self._id_E494707422B1CFE6 = time;
      self._id_BA2F6374446E1525 = 0;
    }

    self._id_F35DE24A74B2DD14 = time;
    self._id_BA2F6374446E1525 = self._id_BA2F6374446E1525 + idamage;

    if(self._id_BA2F6374446E1525 > self._id_D38FB77455B25729 && time - self._id_E494707422B1CFE6 > self._id_62482B4F67666074) {
      self.bhasthermitestucktoshield = 1;
      self.thermitestuckpains = 4;
      thread _id_0E44C53E48F00CCE(eattacker);
    }
  } else if(self._id_7528BDD4F8EA8811 - gettime() > self._id_0A83B580F45A7120)
    thread _id_0E44C53E48F00CCE(eattacker);

  self.lastattackedtime = gettime();
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_0E44C53E48F00CCE(attacker) {
  self._id_7528BDD4F8EA8811 = gettime();
  wait 1;
  _id_371B4C2AB5861E62::_id_AE99616202575E39(attacker.origin, "molotov_mp", 128);
}

_id_96323C515C3294BF() {
  self endon("death");

  for(;;) {
    if(isDefined(self.lastattackedtime)) {
      if(gettime() - self.lastattackedtime > self._id_2808079B46AE6650 && gettime() - self._id_7528BDD4F8EA8811 > self._id_0A83B580F45A7120) {
        self._id_7528BDD4F8EA8811 = gettime();
        players = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
        self.lastattackedtime = undefined;
      }
    }

    wait 0.1;
  }
}

_id_08168A2FFF2FEE79(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    icon.origin = self.origin;
  }
}

_id_54E8128B3D5CC8AB() {
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("pyro");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");
  _id_58C817414D96DE59 = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("pyro");
  _id_58C817414D96DE59.nodes = [];

  foreach(node in _id_A942AE9112CD6BDE) {
    if(isDefined(node.script_noteworthy)) {
      if(!isDefined(_id_58C817414D96DE59.nodes[node.script_noteworthy]))
        _id_58C817414D96DE59.nodes[node.script_noteworthy] = [];

      _id_58C817414D96DE59.nodes[node.script_noteworthy][_id_58C817414D96DE59.nodes[node.script_noteworthy].size] = node;
    }
  }

  _id_58C817414D96DE59._id_E2958F412A7425C0 = _id_58C817414D96DE59 _id_4108074415ABC816(_id_58C817414D96DE59.nodes["boss_pyro_spawn"][0]);
  _id_58C817414D96DE59 thread _id_CF3C7E089F9EE957();
  _id_58C817414D96DE59._id_E2958F412A7425C0._id_0566868292EE2A1B = _id_58C817414D96DE59;
  _id_58C817414D96DE59 notify("boss_spawned");
  _id_47E9B099C2D0B060 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_58C817414D96DE59._id_E2958F412A7425C0.origin);
  pos = _id_58C817414D96DE59._id_E2958F412A7425C0.origin;

  if(isDefined(_id_47E9B099C2D0B060))
    pos = _id_47E9B099C2D0B060.origin;

  _id_58C817414D96DE59 _id_2FDEB8023287BE67::_id_8002B09B8348902C(pos, "ui_map_icon_boss_pyro");

  if(!isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0)) {
    return;
  }
  _id_58C817414D96DE59._id_E2958F412A7425C0 _id_5938B1C7E9CF6DDD::go_to_node_set_goal(_id_58C817414D96DE59.nodes["boss_pyro_spawn"]);

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_minion"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_minion"]) {
      aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("firebug", 1);
      _id_3138C7EBA9B7AA1F = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, node.origin, node.angles, "absolute", "bossMinions", "pyroBossMinion", undefined, undefined, undefined, "bossArea", 0, 0, 0);
    }
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_barrel"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_barrel"])
    thread _id_72D6AF97CFC97305::_id_BE9B3BA9656F790B(node);
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_oilslick"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_oilslick"])
    thread _id_72D6AF97CFC97305::_id_ABFA9FC534304BAC(node);
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_externaldoor"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_externaldoor"]) {}
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_trophy"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_trophy"])
    thread _id_03A246920C9288C4::_id_233602CC27D9FCF8(node, 1, 10, 200, _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("aq"));
  }

  level._id_6ACF5C6209798CBF = spawnStruct();
  level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81 = [];
  level._id_6ACF5C6209798CBF._id_EE046853EFB85853 = [];

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_interiorSpeakers"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_interiorSpeakers"])
    level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81[level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81.size] = spawnscriptable("dmz_loudspeaker_boss_pyro", node.origin, node.angles);
  }

  if(isDefined(_id_58C817414D96DE59.nodes["boss_pyro_exteriorSpeakers"])) {
    foreach(node in _id_58C817414D96DE59.nodes["boss_pyro_exteriorSpeakers"])
    level._id_6ACF5C6209798CBF._id_EE046853EFB85853[level._id_6ACF5C6209798CBF._id_EE046853EFB85853.size] = spawnscriptable("dmz_loudspeaker_boss_pyro", node.origin, node.angles);
  }

  if(level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81.size > 0 || level._id_6ACF5C6209798CBF._id_EE046853EFB85853.size > 0)
    _id_D17BAEFDB9086879(_id_58C817414D96DE59._id_E2958F412A7425C0);

  _id_4673B0931E86514C = "Boss_Focus_Dmz";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    _id_4673B0931E86514C = "Boss_Focus_SM_Dmz";

  if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "boss" && level._id_7F7B9B8BB18CC33C == "pyro") {
    _id_58C817414D96DE59 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_4673B0931E86514C, _id_0BAA08EA813E9752.origin, level._id_7DBC2BB968D412AE);
    _id_58C817414D96DE59 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    _id_58C817414D96DE59 thread _id_2FDEB8023287BE67::_id_3C9B7EA5BE9B4602(_id_58C817414D96DE59._id_E2958F412A7425C0);
  }

  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["", 0.0];
  _id_985AE874212B863E["combat"] = ["dmz_boss_pyro_combat", 1.5];
  _id_6B9A0DBBF039DECE = 1;
  _id_58C817414D96DE59 thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(_id_58C817414D96DE59, _id_985AE874212B863E, level._id_AD758BDA532F9152, level._id_C8C9FE6038E69B34, _id_6B9A0DBBF039DECE);
}

_id_D17BAEFDB9086879(_id_B50D9E77221817C0) {
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946 = [];
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["exteriorSpeaker"] = ["RatFire", "SneakingAround", "ComeCloser", "FaceFire", "OnlyHell", "FlameConsume"];
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["lairDiscoverd"] = ["HeardInside", "RatFound", "SecureChannel"];
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["allPlayersDead"] = ["NotComeHere", "LetThemBurn"];
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["interiorSpeaker"] = ["PlayerInside", "InsideBuilding", "DeadNow", "HuntDown"];
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["fuelTanks"] = ["NotSoBad"];
  level._id_6ACF5C6209798CBF._id_36F2875FEA52186F = 45;
  level._id_6ACF5C6209798CBF._id_36CF755FEA2BA921 = 75;
  level._id_6ACF5C6209798CBF._id_FE9994F598775D8E = scripts\engine\utility::getStructArray("oilField_steamTunnels_enterLocs", "script_noteworthy");
  level._id_6ACF5C6209798CBF._id_70B17F4A2562E50E = scripts\engine\utility::getStructArray("oilField_steamTunnels_exitLocs", "script_noteworthy");
  level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A = [];
  _id_B50D9E77221817C0 thread _id_18B7326F21933E99();
  _id_B50D9E77221817C0 thread _id_E59E5FD9F20AA5BB();
  _id_B50D9E77221817C0 thread _id_C275DF1C35B9B1ED();

  if(getdvarint("dvar_1CE0FCC1847735A7", 1) == 1)
    _id_B50D9E77221817C0 thread _id_E63EEF21B7ACD619();
}

_id_E63EEF21B7ACD619() {
  _id_B50D9E77221817C0 = self;

  if(!isDefined(_id_B50D9E77221817C0._id_276AC5E84835EA87)) {
    return;
  }
  _id_B50D9E77221817C0 endon("death");
  level endon("game_ended");
  level._id_6ACF5C6209798CBF._id_9559116321E7FD23 = 0;
  _id_B50D9E77221817C0._id_276AC5E84835EA87 waittill("barrelExploded");
  level._id_6ACF5C6209798CBF._id_DF89B78D72D185BE = 1;
  level notify("pyro_interruptLine");
}

_id_18B7326F21933E99() {
  level endon("game_ended");
  self endon("death");
  level._id_6ACF5C6209798CBF._id_586089E93C31E302 = 0;
  _id_4FA709D9B5888570 = 0;

  foreach(loc in level._id_6ACF5C6209798CBF._id_FE9994F598775D8E)
  thread _id_311675E0E527056E(loc, "entrance");

  foreach(loc in level._id_6ACF5C6209798CBF._id_70B17F4A2562E50E)
  thread _id_311675E0E527056E(loc, "exit");

  thread _id_4C83B618A85A20D4();

  for(;;) {
    if(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A.size > 0 && _id_4FA709D9B5888570 == 0) {
      level._id_6ACF5C6209798CBF._id_586089E93C31E302 = 1;
      level notify("pyro_interruptLine");
    }

    _id_4FA709D9B5888570 = level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A.size;
    wait 1;
  }
}

_id_311675E0E527056E(loc, _id_54EB774CE5928D09) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    playersinrange = scripts\mp\utility\player::getplayersinradius(loc.origin, 128);

    foreach(player in playersinrange) {
      if(isPlayer(player) && !isagent(player) && isalive(player)) {
        if(_id_54EB774CE5928D09 == "entrance" && !scripts\engine\utility::array_contains(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A, player)) {
          level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A[level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A.size] = player;
          continue;
        }

        if(_id_54EB774CE5928D09 == "exit" && scripts\engine\utility::array_contains(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A, player))
          level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A = scripts\engine\utility::array_remove(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A, player);
      }
    }

    wait 1;
  }
}

_id_4C83B618A85A20D4() {
  level endon("game_ended");
  self endon("death");
  _id_E2230B99EB0E3695 = 0;
  level._id_6ACF5C6209798CBF._id_D26C58335F7071E3 = 0;

  for(;;) {
    if(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A.size > 0) {
      foreach(player in level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A) {
        if(isPlayer(player) && !isagent(player) && isalive(player)) {
          _id_E2230B99EB0E3695 = 1;
          break;
        }

        _id_E2230B99EB0E3695 = 0;
      }

      if(!_id_E2230B99EB0E3695) {
        level._id_6ACF5C6209798CBF._id_D26C58335F7071E3 = 1;
        level notify("pyro_interruptLine");
      }
    }

    wait 1;
  }
}

_id_E59E5FD9F20AA5BB() {
  level endon("game_ended");
  self endon("death");
  _id_9AF7B191480E275A = scripts\engine\utility::array_randomize(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["exteriorSpeaker"]);
  _id_1AC5567418CDA22C = scripts\engine\utility::array_randomize(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["interiorSpeaker"]);

  for(;;) {
    level scripts\engine\utility::waittill_any_timeout_1(randomintrange(level._id_6ACF5C6209798CBF._id_36F2875FEA52186F, level._id_6ACF5C6209798CBF._id_36CF755FEA2BA921), "pyro_interruptLine");
    waitframe();

    if(istrue(level._id_6ACF5C6209798CBF._id_4C3CA90902817A60)) {
      continue;
    }
    if(istrue(level._id_6ACF5C6209798CBF._id_586089E93C31E302) && !istrue(level._id_6ACF5C6209798CBF._id_CD60190A928766E5)) {
      level thread _id_849E91FFCA0EA8F9();
      _id_A2FBA0AD15837370 = scripts\engine\utility::random(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["lairDiscoverd"]);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_EE046853EFB85853)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      continue;
    }

    if(istrue(level._id_6ACF5C6209798CBF._id_D26C58335F7071E3) && !istrue(level._id_6ACF5C6209798CBF._id_DCDA673CFDC479EE)) {
      level thread _id_47D853050E7FD48C();
      _id_A2FBA0AD15837370 = scripts\engine\utility::random(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["allPlayersDead"]);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_EE046853EFB85853)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      continue;
    }

    if(istrue(level._id_6ACF5C6209798CBF._id_DF89B78D72D185BE) && !istrue(level._id_6ACF5C6209798CBF._id_9559116321E7FD23)) {
      level._id_6ACF5C6209798CBF._id_9559116321E7FD23 = 1;
      _id_A2FBA0AD15837370 = scripts\engine\utility::random(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["fuelTanks"]);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_EE046853EFB85853)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370);

      continue;
    }

    if(level._id_6ACF5C6209798CBF._id_D6973FA130CFC76A.size == 0) {
      if(_id_9AF7B191480E275A.size <= 0)
        _id_9AF7B191480E275A = scripts\engine\utility::array_randomize(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["exteriorSpeaker"]);

      foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_EE046853EFB85853)
      _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_9AF7B191480E275A[0]);

      _id_9AF7B191480E275A = scripts\engine\utility::array_remove(_id_9AF7B191480E275A, _id_9AF7B191480E275A[0]);
      continue;
    }

    if(_id_1AC5567418CDA22C.size <= 0)
      _id_1AC5567418CDA22C = scripts\engine\utility::array_randomize(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["interiorSpeaker"]);

    foreach(_id_7D2852D02216C876 in level._id_6ACF5C6209798CBF._id_DC4C04B0A1570A81)
    _id_41A6AF89537C5780(_id_7D2852D02216C876, _id_1AC5567418CDA22C[0]);

    _id_1AC5567418CDA22C = scripts\engine\utility::array_remove(_id_1AC5567418CDA22C, _id_1AC5567418CDA22C[0]);
  }
}

_id_849E91FFCA0EA8F9() {
  level._id_6ACF5C6209798CBF._id_586089E93C31E302 = 0;
  level._id_6ACF5C6209798CBF._id_CD60190A928766E5 = 1;
  wait 45;
  level._id_6ACF5C6209798CBF._id_CD60190A928766E5 = 0;
}

_id_47D853050E7FD48C() {
  level._id_6ACF5C6209798CBF._id_D26C58335F7071E3 = 0;
  level._id_6ACF5C6209798CBF._id_DCDA673CFDC479EE = 1;
  wait 45;
  level._id_6ACF5C6209798CBF._id_DCDA673CFDC479EE = 0;
}

_id_6A63A1DD553A4EF7() {
  _id_7D2852D02216C876 = spawnscriptable("dmz_loudspeaker_boss_pyro", (1327, 1827, 200), (0, 0, 0));

  for(;;) {
    _id_7D2852D02216C876 setscriptablepartstate("speaker", "ImInControl");
    wait 5;
    _id_7D2852D02216C876 setscriptablepartstate("speaker", "off");
    waitframe();
  }
}

_id_41A6AF89537C5780(_id_7D2852D02216C876, _id_A2FBA0AD15837370, _id_CD40AC65A2951F58, _id_CD63C265A2BB9772) {
  if(!isDefined(_id_CD40AC65A2951F58))
    _id_CD40AC65A2951F58 = 0.05;

  if(!isDefined(_id_CD63C265A2BB9772))
    _id_CD63C265A2BB9772 = 0.07;

  wait(randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772));
  _id_7D2852D02216C876 setscriptablepartstate("speaker", _id_A2FBA0AD15837370);
}

_id_C275DF1C35B9B1ED() {
  _id_B50D9E77221817C0 = self;
  level endon("game_ended");
  _id_B50D9E77221817C0 endon("death");
  level._id_6ACF5C6209798CBF._id_4C3CA90902817A60 = 0;
  level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["playerClose"] = ["dx_br_dbos_dbli_dbpy_bitr", "dx_br_dbos_dbli_dbpy_btau"];
  _id_CD40AC65A2951F58 = 12;
  _id_CD63C265A2BB9772 = 18;

  for(;;) {
    if(scripts\common\utility::playersincylinder(_id_B50D9E77221817C0.origin, 1024, undefined, 400).size > 0) {
      level._id_6ACF5C6209798CBF._id_4C3CA90902817A60 = 1;
      alias = scripts\engine\utility::random(level._id_6ACF5C6209798CBF._id_779B3A41E3E7E946["playerClose"]);
      _id_B50D9E77221817C0 playsoundonmovingent(alias);
      wait(randomfloatrange(_id_CD40AC65A2951F58, _id_CD63C265A2BB9772));
    } else
      level._id_6ACF5C6209798CBF._id_4C3CA90902817A60 = 0;

    wait 1;
  }
}

_id_C6434D5C21B8F943() {
  wait 10;
  origin = (974, 1932, 186);
  _id_DDC4E4BDECFF28CD = spawnscriptable("decor_barrels_gameplay_flammable_noent", origin, (0, 0, 0));
  origin = (990, 2135, 100);
  playFX(scripts\engine\utility::getfx("vfx_dmz_gas_puddle_1"), origin, undefined, (0, 0, 1));
  playFX(scripts\engine\utility::getfx("vfx_mtov_pool_imp_burn_stnd"), origin, undefined, (0, 0, 1));
  origin = (1230, 2339, 145);
  playFX(scripts\engine\utility::getfx("vfx_cp_steampipe_exp_fire"), origin, anglesToForward((0, 180, 0)));
}

_id_CF3C7E089F9EE957() {
  self._id_E2958F412A7425C0 waittill("death", _id_6181DE250AFA5BB6);
  scripts\mp\gameobjects::releaseid();

  if(isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(self, _id_6181DE250AFA5BB6, "dmz_boss_pyro_win", 2.5, "", 0.0);
    _id_74B5B12BB6514385 = 5.0;
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_juggernaut_eliminated", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }

  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
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
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("boss_juggernaut_near", playerlist);
}

_id_15E3559F29693C1F(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self._id_E2958F412A7425C0) || !isalive(self._id_E2958F412A7425C0) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self._id_E2958F412A7425C0.origin, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_pyro_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_pyro_near", team, 2.0);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_pyro_approach", 1.5, _id_6B9A0DBBF039DECE);
  return 1;
}