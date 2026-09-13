/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_660791de0bef12f.gsc
***********************************************/

_id_42B7D23D72665D9C() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "rat";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_2352723132C4D2EF;
  _id_AED74300DAF62896.spawnfunc = ::_id_DA23594216AB9FCA;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_DA23594216AB9FCA;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_74CBC6B1338C93EF;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_2352723132C4D2EF(_id_AED74300DAF62896) {
  if(!isDefined(level._id_0C14F8CF1B31CFB8)) {
    level._id_0C14F8CF1B31CFB8 = [];
    level._id_B4420D543F36C77E = [];
    level._id_B16229D528DC058D = [];
    level._id_E04D2392C9AE2D06 = 0;
  }

  level._id_CF76BBED85100C74 = getdvarint("dvar_03360EBA121AEAF9", 100);
  level._id_2BF2A3E61447DF6C = getdvarint("dvar_295F73C6D4FDC617", 0);
  level._id_1EA103DAF0286B7C = getdvarint("dvar_E599D1A91F8D7ECD", 30);
  level._id_3C8665B74457162A = getdvarint("dvar_224B99BC89295D9D", 240);
  level._id_150A820DF9DEAB78 = getdvarint("dvar_9870A426490A97FB", 2000);
  level._id_F9D18CEB86739CBF = getdvarint("dvar_9BA57707813C69C4", 1500);
  level._id_599ED4AA128674B3 = getdvarint("dvar_D326CB69FA84F368", 200);
  level._id_7ED76C5119E6155E = getdvarint("dvar_1B1B2D14BABE50A3", 300);
  level._id_7FF2DEDFB3B173A4 = getdvarint("dvar_AAA3DA7262B08FBD", 2000);
  level._id_062755FDE9148651 = getdvarint("dvar_E91546BACB37766E", 30) * 1000;
  level._id_82888CB2F96BF77D = int(level._id_062755FDE9148651 * 0.4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dmz_bosses", "onPlayerSquadWiped", ::_id_C48BECE5C7B41C9E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("dmz_bosses", "onBackpackOpen", ::_id_E6C3E4A20A07702A);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("drone_deployable_kiosk", ::_id_144BEA0AAEF512E1);
  level._effect["deployable_kiosk_explosion"] = loadfx("vfx/iw9/prop/scriptables/vfx_military_deployable_buystation.vfx");
  level thread _id_DF5029FFB8D686B7();
}

_id_144BEA0AAEF512E1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(istrue(player.disguised))
    _id_57CE8F0135B8B312::_id_208501A7029AB500(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
  else {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_DISGUISED_KIOSK");
  }
}

_id_2F9AC61179DC1FEB(_id_E2958F412A7425C0) {
  level _id_FCC53BAE7CBC2FE6();
  _id_D166A502030D425E = _id_E2958F412A7425C0.origin + scripts\engine\utility::_id_6174330574A2A273() * 200;
  _id_D166A502030D425E = getclosestpointonnavmesh(_id_D166A502030D425E);
  level._id_E7F184D0828989B5 = spawn("script_model", _id_D166A502030D425E);
  level._id_E7F184D0828989B5 setModel("military_deployable_buystation");
  level._id_E7F184D0828989B5.scriptable = level._id_E7F184D0828989B5 getlinkedscriptableinstance();
  level._id_E7F184D0828989B5.scriptable._id_7940DCDE72827AF7 = 159;
  level._id_E7F184D0828989B5.scriptable._id_DED92CCB217BBAEB = 95;
  level._id_E7F184D0828989B5.scriptable._id_AC9AFF06FCBD2B98 = 1;
  _id_342E51952B63E594::_id_45EEFC63956143ED(level._id_E7F184D0828989B5.scriptable, "barter_recipe_list_iw9_scavenger");
  _id_57CE8F0135B8B312::_id_313D9044D8E6F53C(level._id_E7F184D0828989B5);
}

_id_FCC53BAE7CBC2FE6() {
  level notify("rat_kioskDestroy");
  level endon("rat_kioskDestroy");

  if(isDefined(level._id_E7F184D0828989B5)) {
    foreach(_id_AC0E424AC96A7113 in level.players) {
      if(isDefined(_id_AC0E424AC96A7113.br_kiosk) && isDefined(_id_AC0E424AC96A7113.br_kiosk.entity) && _id_AC0E424AC96A7113.br_kiosk.entity == level._id_E7F184D0828989B5)
        _id_AC0E424AC96A7113 _id_4384ABBF498DF6A7::_closepurchasemenuwithresponse(2);
    }

    playFX(scripts\engine\utility::getfx("deployable_kiosk_explosion"), level._id_E7F184D0828989B5.origin, anglesToForward(level._id_E7F184D0828989B5.angles), anglestoup(level._id_E7F184D0828989B5.angles));
    level._id_E7F184D0828989B5 playSound("br_deployable_kiosk_explode");
    wait 1.4;
    level._id_E7F184D0828989B5 delete();
  }
}

_id_FDAE198DF31FEB2D(index) {
  return level._id_0C14F8CF1B31CFB8[level._id_B16229D528DC058D[index]];
}

_id_47BA9CA8BAA703CF(team) {
  if(!isDefined(level._id_B4420D543F36C77E[team]))
    return undefined;

  return level._id_0C14F8CF1B31CFB8[level._id_B16229D528DC058D[level._id_B4420D543F36C77E[team]]];
}

_id_14164D4E4F77E264() {
  self endon("death");

  for(;;) {
    self playsoundonmovingent("dx_br_dbos_dbli_dbsc_btau");
    wait 15;
  }
}

_id_DA23594216AB9FCA() {
  level thread _id_070665A2AE85B4CC();
}

_id_0B956A9BCFB2D36C(loc) {
  magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(loc.origin), (0, 0, -10), 0.1);
  wait 0.3;
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "absolute", "bosses", "ratBoss", undefined, undefined, undefined, loc._id_B205D90302DA2F07, 1, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("rat");
  instance.agent = _id_E2958F412A7425C0;
  instance._id_E2958F412A7425C0 = _id_E2958F412A7425C0;
  instance._id_9329E0D3CE1D5CA8 = "rat";
  instance._id_5367386F4C42FFC6 = [loc.origin];
  instance._id_840F3BCECFD333FC = [];
  _id_E2958F412A7425C0._id_0566868292EE2A1B = instance;
  _id_E2958F412A7425C0 _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("rat");
  _id_E2958F412A7425C0._id_9329E0D3CE1D5CA8 = "rat";
  _id_E2958F412A7425C0.flashbangimmunity = 1;
  _id_E2958F412A7425C0._id_65771500F49956C1 = 1;
  _id_E2958F412A7425C0.health = 500;
  armor = 1000;
  helmet = 20;
  _id_E2958F412A7425C0._id_668B72F41E87C75A = 1;
  _id_48814951E916AF89::_id_63A043D47490F90D(_id_E2958F412A7425C0, "brloot_backpack_scav", undefined, undefined, 1);
  _id_E2958F412A7425C0 _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_dmz_scavenger_boss", "head_dmz_scavenger_boss", undefined, undefined, undefined, armor, helmet, 1);
  _id_E2958F412A7425C0 _meth_8ABE5A968CC3C220("milhvygr");
  _id_E2958F412A7425C0 setclothtype("ghillie");
  _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_8D20D8D705F02228;
  _id_E2958F412A7425C0.baseaccuracy = 1.5;

  if(istrue(level._id_22405C0E11052FFF))
    _id_E2958F412A7425C0 thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(2000);

  _id_E2958F412A7425C0._id_F78A17463EEBCB84 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_0F2C6E7B3FC1C38A = scripts\engine\utility::_id_6174330574A2A273() * 200;
    magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(loc.origin + _id_0F2C6E7B3FC1C38A), (0, 0, -10), 0.1);
    wait 0.3;
    _id_3138C7EBA9B7AA1F = _id_86B85A4E45B18546(getclosestpointonnavmesh(loc.origin + _id_0F2C6E7B3FC1C38A), loc.angles, loc._id_B205D90302DA2F07);

    if(isDefined(_id_3138C7EBA9B7AA1F))
      _id_E2958F412A7425C0._id_F78A17463EEBCB84[_id_E2958F412A7425C0._id_F78A17463EEBCB84.size] = _id_3138C7EBA9B7AA1F;
  }

  if(isagent(_id_E2958F412A7425C0))
    instance _id_FE59EB72DFC23733(_id_E2958F412A7425C0);

  level thread _id_2F9AC61179DC1FEB(_id_E2958F412A7425C0);
  _id_E2958F412A7425C0 thread _id_14164D4E4F77E264();
  instance notify("boss_spawned");
  instance thread _id_8CDCB0FC0ECC0B9E();
  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["", 0.0];
  _id_985AE874212B863E["combat"] = ["dmz_boss_scav_combat", 1.5];
  _id_6B9A0DBBF039DECE = 1;
  instance thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(instance, _id_985AE874212B863E, level._id_82888CB2F96BF77D, level._id_062755FDE9148651, _id_6B9A0DBBF039DECE);
  return instance;
}

_id_FE59EB72DFC23733(agent) {
  _id_2FDEB8023287BE67::_id_8002B09B8348902C(agent.origin, "ui_map_icon_boss_scavenger");
}

_id_8D20D8D705F02228(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self._id_8691447FAFD9E727)) {
    if(gettime() - self._id_8691447FAFD9E727 > level._id_7FF2DEDFB3B173A4) {
      self._id_8691447FAFD9E727 = gettime();

      if(isDefined(eattacker))
        _id_0F07EADDA045D4A0(eattacker.origin);
    }
  } else {
    self._id_8691447FAFD9E727 = gettime();

    if(isDefined(eattacker))
      _id_0F07EADDA045D4A0(eattacker.origin);
  }

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_86B85A4E45B18546(pos, angles, _id_B205D90302DA2F07) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, pos, angles, "absolute", "bossMinions", "ratBossMinion", undefined, undefined, undefined, _id_B205D90302DA2F07, 1, 0, 0);

  if(!isDefined(agent))
    return undefined;

  agent._id_B582B10663B5B2A9 = 0;
  agent._id_685390C6753C2CC7 = 0;
  agent.battlechatterallowed = 0;
  armor = 500;
  helmet = 10;
  [body, head] = _id_383B9A24EA52C393();
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, undefined, undefined, undefined, armor, helmet);
  return agent;
}

_id_383B9A24EA52C393() {
  body = "body_mp_opforce_al_qatala_elite_sniper_1_1";
  head = "head_mp_opforce_al_qatala_elite_sniper_1_1";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    body = "body_sp_opforce_shadow_company_elite_1_1";
    head = "head_sp_opforce_shadow_company_elite_1_1";
  } else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    body = "body_dmz_opforce_unidentified_iw9_tier_3_2_1";
    head = "head_dmz_opforce_unidentified_iw9_tier_3_2_1";
  }

  return [body, head];
}

_id_3513046F9FB53097(index) {
  instance = level._id_6A4C9FBD7AA58544["rat"].instances[0];
  info = level._id_0C14F8CF1B31CFB8[index];

  if(!isDefined(instance)) {
    loc = spawnStruct();
    loc.origin = getclosestpointonnavmesh(info.location);
    loc.angles = (0, 0, 0);
    instance = _id_0B956A9BCFB2D36C(loc);
  } else {
    instance scripts\mp\objidpoolmanager::update_objective_position(instance.objidnum, info.location);
    magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(instance._id_E2958F412A7425C0.origin), (0, 0, -10), 0.1);
    magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(info.location), (0, 0, -10), 0.1);
    wait 0.3;
    instance._id_E2958F412A7425C0.origin = getclosestpointonnavmesh(info.location);
    level thread _id_2F9AC61179DC1FEB(instance._id_E2958F412A7425C0);

    foreach(_id_3138C7EBA9B7AA1F in instance._id_E2958F412A7425C0._id_F78A17463EEBCB84) {
      _id_0F2C6E7B3FC1C38A = scripts\engine\utility::_id_6174330574A2A273() * 200;
      magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(_id_3138C7EBA9B7AA1F.origin), (0, 0, -10), 0.1);
      magicgrenademanual("smoke_grenade_mp", scripts\engine\utility::drop_to_ground(info.location + _id_0F2C6E7B3FC1C38A), (0, 0, -10), 0.1);
      wait 0.3;
      _id_3138C7EBA9B7AA1F.origin = getclosestpointonnavmesh(info.location + _id_0F2C6E7B3FC1C38A);
    }

    instance._id_5367386F4C42FFC6[instance._id_5367386F4C42FFC6.size] = info.location;
  }

  instance._id_7D8AD21E5DFD7C94 = [];
  instance scripts\mp\objidpoolmanager::objective_playermask_hidefromall(instance.objidnum);
  instance _id_33348530AA314E92(index);
}

_id_C44BBDC244B33F4E(_id_455E764D8C345441) {
  path = [];

  foreach(pos in _id_455E764D8C345441) {
    node = spawnStruct();
    node.origin = pos;
    path[path.size] = node;
  }

  level thread _id_A063C83C6C5A459C(path);
  pathstruct = spawnStruct();
  pathstruct.path = path;
  pathstruct.claimed = 0;
  pathstruct._id_4437E81F60B6B5A0 = 1;
  return pathstruct;
}

_id_A063C83C6C5A459C(_id_D76B59299A263FE5) {}

_id_0F07EADDA045D4A0(_id_86C1C8628B1D55F8) {
  _id_248ACD682F7FF8B1 = ["smoke_grenade_mp", "decoy_grenade_mp", "gas_grenade_mp", "molotov_mp"];
  _id_2FDA8CDAB3F467BC = ["smoke_grenade_mp", "gas_grenade_mp", "molotov_mp", "concussion_grenade_mp", "flash_grenade_mp", "decoy_grenade_mp"];
  _id_195927E09B405481 = scripts\engine\utility::random(scripts\engine\utility::ter_op(distancesquared(_id_86C1C8628B1D55F8, self.origin) < 250000, _id_2FDA8CDAB3F467BC, _id_248ACD682F7FF8B1));
  dir = (vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) + (0, 0, 0.5)) * (randomint(level._id_7ED76C5119E6155E) + level._id_599ED4AA128674B3);
  _id_33071C5CA19FBB3F = self launchgrenade(_id_195927E09B405481, self.origin, dir);
  _id_33071C5CA19FBB3F.team = self.team;
}

_id_E6C3E4A20A07702A(_id_69E96A4CAA72D794) {
  if(istrue(level._id_966008444CD3B4AC)) {
    return;
  }
  if(isDefined(_id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F)) {
    if(_id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F >= level._id_B4420D543F36C77E[self.team]) {
      dist = level._id_B16229D528DC058D.size - _id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F - 1;

      if(dist > 1)
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_hint_old", self.team);
      else if(dist > 0)
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_hint_med", self.team);

      if(_id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F + 1 < level._id_B16229D528DC058D.size) {
        _id_921A13367F73AB4D = _id_FDAE198DF31FEB2D(_id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F + 1);
        _id_DC15A8BCF1A43E8D(_id_921A13367F73AB4D, self.team, 0);
      }
    }

    info = _id_FDAE198DF31FEB2D(_id_69E96A4CAA72D794._id_FF3FBC5BFE0C589F);
    return 1;
  }
}

_id_DF5029FFB8D686B7() {
  level endon("dmz_bosses_rat_killed");

  for(;;) {
    foreach(info in level._id_0C14F8CF1B31CFB8) {
      if(istrue(info._id_F2982F79DD4F09F2) && isDefined(info._id_D23FD193DB7F1946)) {
        players = scripts\mp\utility\player::getplayersinradius(info.location, level._id_150A820DF9DEAB78 * 2);

        foreach(player in players) {
          if(isDefined(level._id_B4420D543F36C77E[player.team])) {
            if(level._id_B4420D543F36C77E[player.team] < info._id_D23FD193DB7F1946)
              _id_DC15A8BCF1A43E8D(info, player.team, 1);

            continue;
          }

          _id_DC15A8BCF1A43E8D(info, player.team, 1);
        }
      }
    }

    wait 1;
  }
}

_id_C056BBAD6C47842C(info, team, _id_BFB58038E978DE80) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(istrue(_id_BFB58038E978DE80)) {
      info scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
      continue;
    }

    info scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  }
}

_id_DC15A8BCF1A43E8D(info, team, _id_17556723977D2905) {
  if(isDefined(level._id_B4420D543F36C77E[team])) {
    _id_CBDF8CFEF968846A = _id_47BA9CA8BAA703CF(team);
    _id_C056BBAD6C47842C(_id_CBDF8CFEF968846A, team, 0);
  }

  _id_C056BBAD6C47842C(info, team, 1);
  level._id_B4420D543F36C77E[team] = info._id_D23FD193DB7F1946;

  if(_id_17556723977D2905)
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_hint_near", team);
}

_id_070665A2AE85B4CC() {
  level notify("rat_scavCheck");
  level endon("rat_scavCheck");

  for(;;) {
    if(isDefined(level._id_6A4C9FBD7AA58544["rat"].instances[0]) && isDefined(level._id_6A4C9FBD7AA58544["rat"].instances[0]._id_E2958F412A7425C0) && _func_7C093AAEC980131B(level._id_6A4C9FBD7AA58544["rat"].instances[0]._id_E2958F412A7425C0.origin) > level._id_2BF2A3E61447DF6C) {
      wait(level._id_1EA103DAF0286B7C);
      continue;
    }

    index = _id_DA6F07EC9FFA37E8();

    if(isDefined(index)) {
      _id_3513046F9FB53097(index);
      wait(level._id_3C8665B74457162A);
    } else
      wait(level._id_1EA103DAF0286B7C);
  }
}

_id_DA6F07EC9FFA37E8() {
  _id_A61C75B156FC1EE0 = level._id_0C14F8CF1B31CFB8.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++) {
    if(level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8]._id_F2982F79DD4F09F2) {
      continue;
    }
    if(gettime() - level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8].time < level._id_CF76BBED85100C74) {
      continue;
    }
    pos = level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8].location;
    _id_4E333F60B3B1F754 = _func_7C093AAEC980131B(pos);

    if(_id_4E333F60B3B1F754 <= level._id_2BF2A3E61447DF6C) {
      level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8]._id_F2982F79DD4F09F2 = 1;
      return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_33348530AA314E92(index) {
  _id_C79916C8DF58D478 = [];
  info = level._id_0C14F8CF1B31CFB8[index];
  info._id_D23FD193DB7F1946 = level._id_B16229D528DC058D.size;
  level._id_B16229D528DC058D[info._id_D23FD193DB7F1946] = index;
  pos = info.location;
  _id_3F664A80375B0CFF = level._id_F9D18CEB86739CBF;
  _id_FAFD64B272244139 = getlootscriptablearrayinradius(undefined, undefined, pos, _id_3F664A80375B0CFF);
  group = [self._id_E2958F412A7425C0];

  foreach(_id_3138C7EBA9B7AA1F in self._id_E2958F412A7425C0._id_F78A17463EEBCB84)
  group[group.size] = _id_3138C7EBA9B7AA1F;

  if(isDefined(_id_FAFD64B272244139) && _id_FAFD64B272244139.size > 0) {
    weapons = [];
    _id_5BD25ECE337A80E3 = [];
    _id_628427FD45116A66 = [];

    foreach(scriptable in _id_FAFD64B272244139) {
      if(!isDefined(scriptable.origin)) {
        continue;
      }
      lootid = undefined;
      iscustomweapon = 0;

      if(isDefined(scriptable.type) && scriptable getscriptablehaspart(scriptable.type) && isDefined(scriptable getscriptablepartstate(scriptable.type, 1)) && scriptable getscriptablepartstate(scriptable.type, 1) == "hidden") {
        continue;
      }
      if(isDefined(scriptable._id_BF23A60678978C19)) {
        scriptable._id_FF3FBC5BFE0C589F = info._id_D23FD193DB7F1946;

        foreach(index, item in scriptable._id_BF23A60678978C19) {
          if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(item["lootID"])) {
            _id_48814951E916AF89::_id_63A043D47490F90D(self._id_E2958F412A7425C0, _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(item["lootID"]), item["lootID"], undefined, item["quantity"]);
            scriptable._id_BF23A60678978C19[index]["lootID"] = 26140;
            scriptable._id_BF23A60678978C19[index]["quantity"] = 1;
          }
        }

        if(isDefined(scriptable._id_A0E9FEF038504BD0)) {
          weaponobj = scriptable._id_A0E9FEF038504BD0;

          if(isDefined(weaponobj.basename)) {
            attachments = _func_6527364C1ECCA6C6(weaponobj.basename);
            _id_0DFC21B4E4EFDFAD = 0;

            foreach(attachment in weaponobj.attachments) {
              if(!scripts\engine\utility::array_contains(attachments, attachment))
                _id_0DFC21B4E4EFDFAD++;
            }

            index = weapons.size;
            weapons[index] = weaponobj;
            _id_5BD25ECE337A80E3[index] = _id_0DFC21B4E4EFDFAD;
            scriptable._id_A06E7128C001851D = undefined;
            scriptable._id_A0E9FEF038504BD0 = undefined;
          }
        }

        continue;
      }

      if(_id_7E52B56769FA7774::isweaponpickup(scriptable.type)) {
        weaponobj = _id_7E52B56769FA7774::getfullweaponobjforpickup(scriptable);

        if(isDefined(scriptable.customweaponname))
          weaponobj = makeweaponfromstring(scriptable.customweaponname);

        attachments = _func_6527364C1ECCA6C6(weaponobj.basename);
        _id_0DFC21B4E4EFDFAD = 0;

        foreach(attachment in weaponobj.attachments) {
          if(!scripts\engine\utility::array_contains(attachments, attachment))
            _id_0DFC21B4E4EFDFAD++;
        }

        index = weapons.size;
        weapons[index] = weaponobj;
        _id_5BD25ECE337A80E3[index] = _id_0DFC21B4E4EFDFAD;
        _id_628427FD45116A66[index] = scriptable;
      }
    }

    if(weapons.size > 0) {
      foreach(agent in group) {
        if(!isDefined(agent) || !isalive(agent)) {
          continue;
        }
        agent._id_DE3DA60C62E53D2C = 0;

        foreach(index, _id_AC0E474AC96A7C12 in weapons) {
          if(!isDefined(agent._id_5F382A0D917848A8) && _id_5BD25ECE337A80E3[index] >= 0) {
            agent._id_DE3DA60C62E53D2C = 1;
            agent._id_5F382A0D917848A8 = _id_AC0E474AC96A7C12;
            agent._id_2FFD8A6107B9152D = _id_5BD25ECE337A80E3[index];
            _id_5BD25ECE337A80E3[index] = -1;

            if(isDefined(_id_628427FD45116A66[index]))
              _id_7E52B56769FA7774::loothide(_id_628427FD45116A66[index]);

            continue;
          }

          if(isDefined(agent._id_2FFD8A6107B9152D) && agent._id_2FFD8A6107B9152D < _id_5BD25ECE337A80E3[index]) {
            agent._id_DE3DA60C62E53D2C = 1;
            prevweapon = agent._id_5F382A0D917848A8;
            _id_FBF1DB1A98513D19 = agent._id_2FFD8A6107B9152D;
            agent._id_5F382A0D917848A8 = _id_AC0E474AC96A7C12;
            agent._id_2FFD8A6107B9152D = _id_5BD25ECE337A80E3[index];
            weapons[index] = prevweapon;
            _id_5BD25ECE337A80E3[index] = _id_FBF1DB1A98513D19;

            if(isDefined(_id_628427FD45116A66[index]))
              _id_7E52B56769FA7774::loothide(_id_628427FD45116A66[index]);
          }
        }

        if(istrue(agent._id_DE3DA60C62E53D2C)) {
          if(isalive(agent))
            agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, agent._id_5F382A0D917848A8);

          agent._id_DE3DA60C62E53D2C = 0;
        }
      }
    }
  }

  if(_id_C79916C8DF58D478.size < 6) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 6 - _id_C79916C8DF58D478.size; _id_AC0E5C4AC96AAA41++)
      _id_C79916C8DF58D478[_id_C79916C8DF58D478.size] = getclosestpointonnavmesh(pos + vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) * level._id_F9D18CEB86739CBF);
  }

  _id_E0C08758EB0006BE = _id_C44BBDC244B33F4E(_id_C79916C8DF58D478);
  level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(group, _id_E0C08758EB0006BE);
}

_id_C48BECE5C7B41C9E(player) {
  if(istrue(player._id_067D6BF9D0FF637F)) {
    return;
  }
  _id_3F664A80375B0CFF = level._id_F9D18CEB86739CBF;

  foreach(info in level._id_0C14F8CF1B31CFB8) {
    if(!isDefined(info.location) || !isDefined(player.origin)) {
      return;
    }
    if(distancesquared(info.location, player.origin) < _id_3F664A80375B0CFF * _id_3F664A80375B0CFF)
      return;
  }

  if(isDefined(player._id_DA28916E7827AF7C) && _id_4480C6CE37B2BDF3::_id_7A7AA3B5455F0412(player._id_DA28916E7827AF7C)) {
    return;
  }
  index = level._id_0C14F8CF1B31CFB8.size;
  level._id_0C14F8CF1B31CFB8[index] = spawnStruct();
  level._id_0C14F8CF1B31CFB8[index].location = player.origin;
  level._id_0C14F8CF1B31CFB8[index] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Boss_Dmz_Rat", player.origin, 1000);
  level._id_0C14F8CF1B31CFB8[index]._id_7D8AD21E5DFD7C94 = [];
  level._id_0C14F8CF1B31CFB8[index].time = gettime();
  level._id_0C14F8CF1B31CFB8[index]._id_F2982F79DD4F09F2 = 0;
  level._id_0C14F8CF1B31CFB8[index].index = index;
}

_id_E5A8FEF1CC5EA344(struct) {}

_id_8CDCB0FC0ECC0B9E() {
  self._id_E2958F412A7425C0 waittill("death", _id_6181DE250AFA5BB6);
  level notify("rat_scavCheck");
  scripts\mp\gameobjects::releaseid();

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(self, _id_6181DE250AFA5BB6, "dmz_boss_scav_win", 2.5, "", 0.0);
    _id_74B5B12BB6514385 = 5.0;
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_eliminated", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }

  _id_89E775D924A987DB(_id_6181DE250AFA5BB6);
  _id_FCC53BAE7CBC2FE6();
}

_id_89E775D924A987DB(_id_6181DE250AFA5BB6) {
  level notify("dmz_bosses_rat_killed");
  level._id_966008444CD3B4AC = 1;

  foreach(team in getarraykeys(level._id_B4420D543F36C77E)) {
    _id_C056BBAD6C47842C(_id_47BA9CA8BAA703CF(team), team, 0);

    if(_id_6181DE250AFA5BB6.team != team)
      level _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_lost", team);
  }
}

_id_31AB9278DA3C23BF(time) {}

_id_74CBC6B1338C93EF(player, showicon) {
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

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_rat_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_rat_nearby", team, 3.0);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_scav_approach", 1.5, _id_6B9A0DBBF039DECE);
  return 1;
}

_id_87B9D0DBD01F4612() {
  level.laststand = 2;

  foreach(player in level.players) {
    if(player == level.players[0]) {
      continue;
    }
    pos = level.players[0].origin + scripts\engine\utility::_id_6174330574A2A273() * (randomint(10000) + 10000);
    pos = getclosestpointonnavmesh(pos);
    player setOrigin(pos);
    wait 0.1;
    player dodamage(999999, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  }
}

_id_A4022EA57791A2C3() {
  interval = 1;
  r = (1, 0, 0);
  g = (0, 1, 0);

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_0C14F8CF1B31CFB8.size; _id_AC0E594AC96AA3A8++)
      level thread scripts\mp\utility\debug::drawsphere(level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8].location, 32, interval, scripts\engine\utility::ter_op(level._id_0C14F8CF1B31CFB8[_id_AC0E594AC96AA3A8]._id_F2982F79DD4F09F2, r, g));

    wait(interval);
  }
}