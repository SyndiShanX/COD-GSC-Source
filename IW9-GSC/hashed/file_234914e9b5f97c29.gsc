/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_234914e9b5f97c29.gsc
***********************************************/

_id_C247624CDECDD6EE() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "jailer";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_B310C0EEE2621955;
  _id_AED74300DAF62896.spawnfunc = ::_id_5C0398AF5E2A0028;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_5C0398AF5E2A0028;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_A506F775CD7816D5;
  _id_AED74300DAF62896.disabled = 1;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_B310C0EEE2621955(_id_AED74300DAF62896) {
  level._id_990BF75476CC1DA1 = getdvarint("dvar_69F8A0DE540EE53E", 200);
  level._id_3DBB9F55CA1F8CFC = getdvarint("dvar_08249E69D229FE09", 300);
  level._id_EA4A03E8962BCB3E = getdvarint("dvar_B7C377B48E36B1D7", 2000);
}

_id_84A7A4B31B26D78E() {
  self endon("death");

  for(;;) {
    self playsoundonmovingent("dx_br_dbos_dbli_dbsc_btau");
    wait 15;
  }
}

_id_5C0398AF5E2A0028() {
  wait 1;

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    _id_F48274F57122CA5A();
}

_id_15007FDF4255338E(loc) {
  aitype = "enemy_mp_baton_base";
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "absolute", "bosses", "jailerBoss", undefined, undefined, undefined, loc._id_B205D90302DA2F07, 1, 0, 0);
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("jailer");
  instance.agent = _id_E2958F412A7425C0;
  instance._id_E2958F412A7425C0 = _id_E2958F412A7425C0;
  instance._id_9329E0D3CE1D5CA8 = "jailer";
  _id_E2958F412A7425C0._id_0566868292EE2A1B = instance;
  _id_E2958F412A7425C0 _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("jailer");
  _id_E2958F412A7425C0._id_9329E0D3CE1D5CA8 = "jailer";
  _id_E2958F412A7425C0.flashbangimmunity = 1;
  _id_E2958F412A7425C0._id_65771500F49956C1 = 1;
  _id_E2958F412A7425C0.health = 500;
  armor = 1000;
  helmet = 20;
  _id_E2958F412A7425C0._id_668B72F41E87C75A = 1;
  _id_E2958F412A7425C0 _id_371B4C2AB5861E62::_id_C37C4F9D687074FF("body_mp_pizza_rat_iw9_1_1", "head_mp_pizza_rat_iw9_1_1", undefined, undefined, undefined, armor, helmet, 1);
  _id_E2958F412A7425C0 attach("misc_wm_baton", "tag_accessory_right");
  _id_E2958F412A7425C0._id_C833409FB72D15FB = 0;
  _id_E2958F412A7425C0._id_CBDA25FEF016B253 = 0;
  _id_E2958F412A7425C0._id_A4738C70736D3A61 = ::_id_5653B2F2FFC9FA8A;
  _id_E2958F412A7425C0.baseaccuracy = 1.5;

  if(istrue(level._id_22405C0E11052FFF))
    _id_E2958F412A7425C0 thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(2000);

  if(isagent(_id_E2958F412A7425C0))
    instance _id_E5C394B154B9D3AD(_id_E2958F412A7425C0);

  _id_E2958F412A7425C0 thread _id_84A7A4B31B26D78E();
  instance notify("boss_spawned");
  instance thread _id_FE8122F5D8FDFEB4();
  return instance;
}

_id_E5C394B154B9D3AD(agent) {
  _id_2FDEB8023287BE67::_id_8002B09B8348902C(agent.origin, "ui_map_icon_boss_scavenger");
}

_id_5653B2F2FFC9FA8A(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_D310124057BB94B4(pos, angles, _id_B205D90302DA2F07) {
  aitype = "enemy_mp_baton_base";
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, pos, angles, "absolute", "bossMinions", "jailerBossMinion", undefined, undefined, undefined, _id_B205D90302DA2F07, 1, 0, 0);

  if(!isDefined(agent))
    return undefined;

  agent._id_B582B10663B5B2A9 = 0;
  agent._id_685390C6753C2CC7 = 0;
  agent.battlechatterallowed = 0;
  agent.a.disablepain = 1;
  armor = 50;
  helmet = 1;
  [body, head] = _id_C0B3CC13554ED7F9();
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, undefined, undefined, undefined, armor, helmet);
  agent attach("misc_wm_baton", "tag_accessory_right");
  agent._id_C833409FB72D15FB = 0;
  agent._id_CBDA25FEF016B253 = 0;
  agent._id_65771500F49956C1 = 1;
  agent thread _id_0CA1EC01BF303505();
  return agent;
}

_id_C0B3CC13554ED7F9() {
  body = "body_mp_gulag_jugg_light_basebody";
  head = "head_mp_gulag_jugg_minotavr";
  return [body, head];
}

_id_DCBC1EBC710A33C6(_id_86C1C8628B1D55F8) {
  _id_248ACD682F7FF8B1 = ["smoke_grenade_mp", "decoy_grenade_mp", "gas_grenade_mp", "molotov_mp"];
  _id_2FDA8CDAB3F467BC = ["smoke_grenade_mp", "gas_grenade_mp", "molotov_mp", "concussion_grenade_mp", "flash_grenade_mp", "decoy_grenade_mp"];
  _id_195927E09B405481 = scripts\engine\utility::random(scripts\engine\utility::ter_op(distancesquared(_id_86C1C8628B1D55F8, self.origin) < 250000, _id_2FDA8CDAB3F467BC, _id_248ACD682F7FF8B1));
  dir = (vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) + (0, 0, 0.5)) * (randomint(level._id_3DBB9F55CA1F8CFC) + level._id_990BF75476CC1DA1);
  _id_33071C5CA19FBB3F = self launchgrenade(_id_195927E09B405481, self.origin, dir);
  _id_33071C5CA19FBB3F.team = self.team;
}

_id_5D79B19B1032AD0A(struct) {}

_id_850BE40381F86A39(pos, player, dist) {}

_id_C1C33AF6AE3FA5A3(pos, dist) {
  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 0, 0);
  startpos = pos + (0, 0, 32);
  _id_3674D96C61E2DD0D = 0;
  _id_620D11141D49A3AF = [];
  maxdist = [0, 0];

  for(yaw = 0; yaw < 180; yaw = yaw + _id_3FB4A86293ED25A6) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 190; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 180) {
      index = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 > 0, 1, 0);
      _id_1792D04BE4030407 = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 > 0, 0, 1);
      _id_3674D96C61E2DD0D = yaw;
      _id_211FC11F4C8566F5 = (0, _id_3674D96C61E2DD0D + _id_AC0E594AC96AA3A8, 0);
      endpos = getclosestpointonnavmesh(startpos + anglesToForward(_id_211FC11F4C8566F5) * dist) + (0, 0, 32);
      trace = scripts\engine\trace::sphere_trace(startpos, endpos, 10, undefined, contents, 1);

      if(trace["fraction"] > 0) {
        if(maxdist[index] < trace["fraction"]) {
          maxdist[index] = trace["fraction"];
          _id_620D11141D49A3AF[index] = trace["position"];
        } else if(maxdist[index] == trace["fraction"]) {
          _id_6B40B4C28ABE0A05 = distance(_id_620D11141D49A3AF[0], _id_620D11141D49A3AF[1]);

          if(_id_6B40B4C28ABE0A05 < distance(_id_620D11141D49A3AF[_id_1792D04BE4030407], trace["position"]))
            _id_620D11141D49A3AF[index] = trace["position"];
        }

        continue;
      }
    }
  }

  return _id_620D11141D49A3AF;
}

_id_0CA1EC01BF303505(time) {
  if(!isDefined(time))
    time = 2;

  self.flashbangimmunity = 1;
  wait(time);

  if(isalive(self))
    self.flashbangimmunity = 0;
}

_id_91004CE66C2B8EEA(_id_9577902B42FBD7F6, target) {
  _id_FFC85C5CB04468C5 = randomint(3);

  foreach(loc in _id_9577902B42FBD7F6)
  magicgrenademanual("smoke_grenade_mp", getclosestpointonnavmesh(loc), (0, 0, -10), 0.1);

  wait 0.8;

  foreach(loc in _id_9577902B42FBD7F6) {
    _id_7F96D62F3ABBF9B9 = target.origin - loc;
    agent = undefined;
    _id_8552A9E15C8D61C6 = randomint(2) + 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8552A9E15C8D61C6; _id_AC0E594AC96AA3A8++)
      agent = _id_D310124057BB94B4(loc, (0, 0, 0), undefined);

    switch (_id_FFC85C5CB04468C5) {
      case 0:
        agent launchgrenade("concussion_grenade_mp", loc, _id_7F96D62F3ABBF9B9);
        break;
      case 1:
        agent launchgrenade("flash_grenade_mp", loc, _id_7F96D62F3ABBF9B9);
        break;
      case 2:
        agent launchgrenade("gas_grenade_mp", loc, _id_7F96D62F3ABBF9B9);
        break;
      case 3:
        break;
      default:
        break;
    }
  }
}

_id_FE8122F5D8FDFEB4() {
  self._id_E2958F412A7425C0 waittill("death", _id_6181DE250AFA5BB6);
  level notify("jailer_scavCheck");
  scripts\mp\gameobjects::releaseid();

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(self, _id_6181DE250AFA5BB6, "dmz_boss_scav_win", 2.5, "", 0.0);
    _id_74B5B12BB6514385 = 5.0;
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_jailer_eliminated", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }
}

_id_3BFD509D4CCD9725(time) {}

_id_A506F775CD7816D5(player, showicon) {
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

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_jailer_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_jailer_nearby", team, 3.0);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_scav_approach", 1.5, _id_6B9A0DBBF039DECE);
  return 1;
}

_id_F48274F57122CA5A() {
  pos = (18937, -51976, 566);
  loc = spawnStruct();
  loc.origin = pos;
  loc.angles = (0, 0, 0);
  _id_58C817414D96DE59 = _id_15007FDF4255338E(loc);
  _id_58C817414D96DE59._id_A96E35EA3FD4B685 = [];
  _id_47E9B099C2D0B060 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(pos);
  _id_58C817414D96DE59._id_47E9B099C2D0B060 = _id_47E9B099C2D0B060;

  foreach(volume in _id_47E9B099C2D0B060._id_AA7C37B8B3EC1F46) {
    volume._id_58C817414D96DE59 = _id_58C817414D96DE59;
    volume._id_E2F9CB96D8A5C8D1 = ::_id_12E9201423064522;
    volume._id_3177443FCF724AF1 = ::_id_0607676D4F26C270;
  }

  _id_58C817414D96DE59 thread _id_7117B6B33498F2A7();
}

_id_12E9201423064522(player) {
  struct = self._id_58C817414D96DE59;

  if(!isDefined(struct._id_A96E35EA3FD4B685[player.guid]))
    struct._id_A96E35EA3FD4B685[player.guid] = player;
}

_id_0607676D4F26C270(player) {
  struct = self._id_58C817414D96DE59;

  if(isDefined(struct._id_A96E35EA3FD4B685[player.guid]))
    struct._id_A96E35EA3FD4B685[player.guid] = undefined;
}

_id_7117B6B33498F2A7() {
  level endon("game_ended");

  for(;;) {
    foreach(player in self._id_A96E35EA3FD4B685) {
      _id_9577902B42FBD7F6 = _id_C1C33AF6AE3FA5A3(player.origin, 400);
      _id_91004CE66C2B8EEA(_id_9577902B42FBD7F6, player);
    }

    wait 10;
  }
}

_id_AB1388F98F025238(pos) {
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(pos, 75, 75);

  foreach(door in doors) {
    door scriptabledoorclose();
    _id_57D3850A12CF1D8F::_id_FBBFE6F05EDA5EB1(door);
  }
}

_id_B8359C1D37072D39() {
  interval = 1;
  r = (1, 0, 0);
  g = (0, 1, 0);

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_7B30C08C8B5796EE.size; _id_AC0E594AC96AA3A8++)
      level thread scripts\mp\utility\debug::drawsphere(level._id_7B30C08C8B5796EE[_id_AC0E594AC96AA3A8].location, 32, interval, scripts\engine\utility::ter_op(level._id_7B30C08C8B5796EE[_id_AC0E594AC96AA3A8]._id_F2982F79DD4F09F2, r, g));

    wait(interval);
  }
}