/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29c0c8893a21a756.gsc
***********************************************/

_id_2C8A5E12A23B3A6E(_id_AED74300DAF62896) {
  if(!scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_init("strike_init_done");

  scripts\engine\utility::flag_wait("strike_init_done");

  if(!scripts\engine\utility::flag_exist("create_script_initialized"))
    scripts\engine\utility::flag_init("create_script_initialized");

  scripts\engine\utility::flag_wait("create_script_initialized");

  if(scripts\engine\utility::flag_exist("boss_swampmonster_init")) {
    return;
  }
  scripts\engine\utility::flag_init("boss_swampmonster_init");
  level._id_443257CB09E657F4 = getdvarint("dvar_F22C3722D56ECED7", 30) * 1000;
  level._id_B42AFFD5C0498412 = int(level._id_443257CB09E657F4 * 0.4);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

  if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_swampmonster"])) {
    return;
  }
  foreach(node in level.struct_class_names["script_noteworthy"]["boss_swampmonster"]) {
    _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;
    _id_A942AE9112CD6BDE = [];

    if(isDefined(node.target))
      _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(node.target, "targetname");

    node.nodes = [];

    foreach(_id_306CB412722A32D9 in _id_A942AE9112CD6BDE) {
      if(isDefined(_id_306CB412722A32D9.script_noteworthy)) {
        if(!isDefined(node.nodes[_id_306CB412722A32D9.script_noteworthy]))
          node.nodes[_id_306CB412722A32D9.script_noteworthy] = [];

        node.nodes[_id_306CB412722A32D9.script_noteworthy][node.nodes[_id_306CB412722A32D9.script_noteworthy].size] = _id_306CB412722A32D9;
      }
    }
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("tiara_deposit", ::_id_C539B2018A507656);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::_id_D992DC1D7F6E2F55);
  _id_552B8E4EA5FF7DF1::_id_BB85AADE9D4A5515(::_id_C85DC71BA7876ABB);
  level._id_3EADE5004C2D0F4D = spawnStruct();
  level._id_3EADE5004C2D0F4D._id_3EB5BB6097F65DF0 = 0;
  level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = 0;
  level._id_3EADE5004C2D0F4D._id_92237C040F7537FE = 0;
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_end", ::_id_281E2D13A766756C);
  _id_4DC42849FA9B701C = [(17898.2, 900.801, 230.255)];
  level thread _id_42A7F92B67241D66(_id_4DC42849FA9B701C);
}

_id_9C2A8EB1E6C87138(_id_7E05C139FBBD8374, _id_5B9C864B21207FF6, _id_95068F46E5A1AEC2) {
  _id_B038ED928EC17A81 = spawnscriptable(_id_95068F46E5A1AEC2, _id_7E05C139FBBD8374, _id_5B9C864B21207FF6);
  _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
  _id_74EF4CA4734D1033 = createnavbadplacebybounds(_id_7E05C139FBBD8374, (25, 25, 100), (0, 0, 0));

  if(_id_95068F46E5A1AEC2 == "br_loot_swamp_eggmound_cache") {
    _id_B038ED928EC17A81 thread _id_5438D139F96B5BFE();
    _id_B038ED928EC17A81 thread _id_E4DB177671E883DE(_id_7E05C139FBBD8374 + (0, 0, 220));
  }

  return _id_B038ED928EC17A81;
}

_id_5438D139F96B5BFE() {
  level endon("game_ended");
  level waittill("swamp_monster_reset");
  wait 1;
  self setscriptablepartstate("body", "fully_open_unusable_no_collision");
  wait 2;
  self freescriptable();
}

_id_D992DC1D7F6E2F55(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance.type == "br_loot_swamp_eggmound_cache")
    player thread _id_C3E5FAADD2C5E2EF();

  if(instance.type == "br_loot_swamp_eggmound_cache_small" && randomint(10) <= 2)
    player thread _id_C3E5FAADD2C5E2EF();
}

_id_C85DC71BA7876ABB(instance) {
  _id_3EC9E84D0F7C4708 = undefined;

  if(!istrue(level._id_7BF4234FE2B5B3DF)) {
    return;
  }
  if(!isDefined(level._id_3ACC2F923AFBA95C))
    level._id_3ACC2F923AFBA95C = getdvarint("dvar_9CB4D59B9BAFD522", randomintrange(3, 5));

  if(instance.type == "br_loot_swamp_eggmound_cache" && !scripts\engine\utility::flag("golden_tiara_appeared_in_egg")) {
    if(!isDefined(level._id_A6C5822580945265))
      level._id_A6C5822580945265 = 1;
    else
      level._id_A6C5822580945265++;

    if(level._id_A6C5822580945265 >= level._id_3ACC2F923AFBA95C) {
      scripts\engine\utility::flag_set("golden_tiara_appeared_in_egg");
      level thread _id_99D7A760418528F6();

      if(scripts\mp\utility\game::getsubgametype() != "DMZ")
        level thread _id_8E305DEB364559A9(instance.origin);

      _id_3EC9E84D0F7C4708 = "brloot_valuable_gold_swamp_tiara";
    }
  }

  return _id_3EC9E84D0F7C4708;
}

_id_20849791CB0ABFBD() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("golden_tiara_appeared_in_egg");
  scripts\engine\utility::flag_init("golden_tiara_given");
  scripts\engine\utility::flag_init("golden_tiara_deposited");

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_2638C588EC0CFCD9::_id_4FF27C88E74047B5();
    level thread _id_E54437F7279D93CD();
  }
}

_id_829BCA7DC0ADC6D9() {
  level thread _id_E54437F7279D93CD();
}

_id_63243DAE8DBFEEFA(playerlist) {
  if(isDefined(playerlist)) {
    foreach(_id_F90358454413407F in playerlist) {
      if(isPlayer(_id_F90358454413407F[0]) && _id_F90358454413407F[1] >= 1)
        scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_F90358454413407F[0], "swampmonster_killed", 1, 0);
    }
  }
}

_id_6581326A6869EF0D() {
  level endon("game_ended");
  _id_58C817414D96DE59 = self._id_0566868292EE2A1B;
  self waittill("death", _id_6181DE250AFA5BB6);
  level thread _id_79712F2E14778875(self.origin);
  scripts\mp\gameobjects::releaseid();
  _id_9DC2394FEE4A29EA = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

  if(isDefined(_id_9DC2394FEE4A29EA))
    _id_63243DAE8DBFEEFA(_id_9DC2394FEE4A29EA.attackers);

  level._id_CAFAB962CCAE1309++;

  if(level._id_CAFAB962CCAE1309 < level._id_EC5D7D7C03465F96) {
    if(!scripts\engine\utility::flag("golden_tiara_deposited")) {
      foreach(_id_D9D652F486829BCD in _id_58C817414D96DE59._id_94F42DC3D13C82DA) {
        if(isalive(_id_D9D652F486829BCD)) {
          _id_D9D652F486829BCD._id_712C4F862927DE81 = 1;
          _id_D9D652F486829BCD.unarmedmeleedamageoverride = 60;
          _id_D9D652F486829BCD.meleedamageoverride = 60;
          _id_D9D652F486829BCD._id_2A3891ADA6ABEA80 = 60;
        }
      }
    }

    if(level._id_CAFAB962CCAE1309 == level._id_EC5D7D7C03465F96 - 1) {
      foreach(_id_D9D652F486829BCD in _id_58C817414D96DE59._id_94F42DC3D13C82DA) {
        if(isalive(_id_D9D652F486829BCD)) {
          if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "zxp") {
            _id_48814951E916AF89::_id_63A043D47490F90D(_id_D9D652F486829BCD, "brloot_plate_carrier_tempered", undefined, undefined, 1);
            _id_48814951E916AF89::_id_63A043D47490F90D(_id_D9D652F486829BCD, "brloot_valuable_prized_tiara", undefined, undefined, 1);
            continue;
          }

          _id_48814951E916AF89::_id_63A043D47490F90D(_id_D9D652F486829BCD, "brloot_plate_carrier_3_medic", undefined, undefined, 1);
          _id_48814951E916AF89::_id_63A043D47490F90D(_id_D9D652F486829BCD, "brloot_plate_carrier_tempered", undefined, undefined, 1);
        }
      }
    }

    return;
  }

  thread _id_7AB5B649FA408138::_id_FDD0934F1A32F70D(self.origin, 5000, "mx_dmz_boss_swampmonster_win", undefined, undefined, "mx_dmz_boss_swampmonster_win");
  thread _id_7AB5B649FA408138::_id_42A8A4F269E8483C(self.origin, 5000, 1);
  level thread _id_2FDEB8023287BE67::_id_3E409004EDF37731("swampmonster");
  level notify("swampmonster_killed");
  level._id_A6C5822580945265 = 0;

  if(isDefined(level._id_D0EB742034589336)) {
    level._id_D0EB742034589336 setscriptablepartstate("tiara_deposit", "unusable");
    level._id_D0EB742034589336 setscriptablepartstate("tiara_effects", "off");
  }

  if(istrue(level._id_BF9426DBDF5FAA3B)) {
    return;
  }
  _id_171F90B9C4C76D44 = "saba_marshland";
  _id_AC4C51BF033F6323 = level.players;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_swampmonster_killed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  level thread _id_70EB61A04ABEB268();
}

_id_70EB61A04ABEB268() {
  level endon("game_ended");
  wait(getdvarint("dvar_DC95D37637846BE1", 2));
  level._id_7BF4234FE2B5B3DF = 0;
  _id_AB03AF24C170319A = 1;

  while(istrue(_id_AB03AF24C170319A)) {
    _id_F47DD9D668CC52E2 = _id_7CAD7AF3334B53B9(undefined, 3000);
    _id_AB03AF24C170319A = _id_F47DD9D668CC52E2.size > 0;
    wait 2;
  }

  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  _id_885AD6B3C9D47759 = 1;

  if(_id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(_id_B2B24BB9E0275FBA))
    _id_885AD6B3C9D47759 = 0;

  if(istrue(_id_885AD6B3C9D47759)) {
    level notify("swamp_monster_reset");
    scripts\engine\utility::flag_clear("golden_tiara_deposited");
    scripts\engine\utility::flag_clear("golden_tiara_appeared_in_egg");
    wait 5;
    _id_171F90B9C4C76D44 = "saba_marshland";
    _id_AC4C51BF033F6323 = level.players;
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_swampmonster_respawned", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
    level thread _id_E54437F7279D93CD();
  }
}

_id_D179ABC58F83AE22(agent) {
  level endon("game_ended");
  agent endon("death");
  wait 3;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return;
  }
  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);

  for(;;) {
    if(_id_2695A20D4011076D::_id_024C5A8D31AE262F(_id_B2B24BB9E0275FBA))
      level notify("swampmonster_area_covered_by_circle");

    wait 2;
  }
}

_id_1A2E678EAE631777() {
  level endon("game_ended");
  self endon("death");
  _id_2EFE5529D8C9E37A(self, "pre_combat_hunting");

  while(!isDefined(self._id_B6656956EA57A8D8))
    wait 1;

  _id_78122E18403A8DC4 = _id_1067A1F83551E4BB(self);

  if(!isarray(_id_78122E18403A8DC4)) {
    _id_2EFE5529D8C9E37A(self, undefined);
    return 0;
  } else if(_id_78122E18403A8DC4.size <= 0) {
    _id_2EFE5529D8C9E37A(self, undefined);
    return 0;
  }

  targetplayer = _id_1A9E1A48F8D66F9E(self, _id_78122E18403A8DC4);

  if(!isDefined(targetplayer) || !isPlayer(targetplayer) || !_id_B3AAC6982108DF0B(self, targetplayer) || istrue(targetplayer.inlaststand) || !isalive(targetplayer)) {
    _id_2EFE5529D8C9E37A(self, undefined);
    return 0;
  }

  _id_0B5A4396E8058103(targetplayer, 1);
  yoffset = scripts\engine\utility::ter_op(randomint(10) <= 5, -1, 1);
  self._id_F44C9CEDE4FB20D6 = 0;
  _id_48AAECD532669820 = 0;
  _id_3F5B2378B114E1EE = 0;
  _id_7293D10E7BE2FA41 = 20;

  if(targetplayer.health < targetplayer.maxhealth)
    _id_3F5B2378B114E1EE = 1;
  else
    _id_3F5B2378B114E1EE = randomint(100) < _id_7293D10E7BE2FA41;

  if(getdvarint("dvar_960D1721E9C4371A", 0) < 1 && istrue(_id_3F5B2378B114E1EE))
    _id_48AAECD532669820 = _id_0CC6049C4560E8C4(targetplayer, yoffset);
  else
    _id_357FAFC4F0B92AAF(targetplayer, yoffset);

  _id_0B5A4396E8058103(targetplayer, 0);

  if(_id_AF89FB0FC9B8712E(self))
    _id_8A5DE523783CC38C(self);
  else
    _id_449508F8B0C7A85B();

  if(!scripts\engine\utility::flag("golden_tiara_deposited")) {
    _id_2EFE5529D8C9E37A(self, "waiting_between_precombat");
    self setgoalpos(self.origin, 10);
    wait(randomintrange(3, 4));
  }

  return _id_48AAECD532669820;
}

_id_357FAFC4F0B92AAF(player, yoffset) {
  self endon("death");
  level endon("game_ended");

  if(!istrue(self.ishidden) || !_id_AF89FB0FC9B8712E(self))
    return 0;

  _id_0F06CDAB0AAC6787(self, 0, 0);
  _id_2EFE5529D8C9E37A(self, "precombat melee");
  self.ignoreall = 0;
  self.dontevershoot = 0;
  waitframe();
  self setthreatsight(player, 1.0);
  self.favoriteenemy = player;
  self.goalradius = 200;
  wait 5;
}

_id_0CC6049C4560E8C4(player, yoffset) {
  self endon("death");
  level endon("game_ended");

  if(!istrue(self.ishidden) || !_id_AF89FB0FC9B8712E(self))
    return 0;

  destination = _id_3EED0B8EB85B1061(player, (0, 32 * yoffset, 0));
  destination = getclosestpointonnavmesh(scripts\engine\utility::drop_to_ground(destination, 100));

  if(!_id_A99572E621A19DBE(self, destination))
    self.origin = destination;

  if(!_id_AF89FB0FC9B8712E(self)) {
    _id_9D4D84F5EFD3E1D3 = _id_84BE5BCD62C9A89F(self);
    destination = scripts\engine\utility::getclosest(player.origin, _id_9D4D84F5EFD3E1D3);
    destination._id_950511821B7A2895 = 1;
    self.origin = destination.origin;
    level thread _id_D3610373DEACB91E(destination, 2);
  }

  self._id_F44C9CEDE4FB20D6 = 0;
  _id_0F06CDAB0AAC6787(self, 0, 0, 0);
  _id_2EFE5529D8C9E37A(self, "attempting execution");
  self.ignoreall = 0;
  self.dontevershoot = 0;
  waitframe();
  self._id_B0DE97037A47640C = 1;
  thread _id_79DCE7BD89108AF5();
  self setthreatsight(player, 1.0);
  self.favoriteenemy = player;
  self.goalradius = 20;
  self setgoalentity(player);
  _id_48AAECD532669820 = 0;
  wait 5;

  while(self isinexecutionattack()) {
    _id_48AAECD532669820 = 1;
    waitframe();
  }

  level._id_3EADE5004C2D0F4D._id_92237C040F7537FE = level._id_3EADE5004C2D0F4D._id_92237C040F7537FE + 1;
  self._id_B0DE97037A47640C = 0;
  _id_2EFE5529D8C9E37A(self, undefined);
  return _id_48AAECD532669820;
}

_id_79DCE7BD89108AF5() {
  level endon("game_ended");
  self endon("death");

  while(istrue(self._id_B0DE97037A47640C)) {
    if(!_id_AF89FB0FC9B8712E(self))
      self._id_B0DE97037A47640C = 0;

    waitframe();
  }
}

_id_B3AAC6982108DF0B(agent, player) {
  if(!isDefined(agent._id_B6656956EA57A8D8) || !isDefined(agent._id_B6656956EA57A8D8.nodes))
    return 0;

  if(level.script == "mp_br_mechanics")
    return 0;

  _id_07E59B71E80A4EEE = agent._id_B6656956EA57A8D8.nodes["shore_marker"];
  _id_8922F30412A7BCD4 = 200;

  foreach(marker in _id_07E59B71E80A4EEE) {
    if(distance2d(marker.origin, player.origin) <= _id_8922F30412A7BCD4)
      return 0;
  }

  _id_3DA3A6BAAC919477 = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner1"][0];
  _id_E43F4FCD4098F7FA = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner2"][0];
  _id_F22CDAD2A71426FB = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner1"][0];
  _id_4D0F2D8665A0751E = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner2"][0];
  _id_3F0D8BCA76BE4113 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner1"][0];
  _id_62E7631E973CCD36 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner2"][0];
  return !player _id_85708E6738014787(_id_E43F4FCD4098F7FA, _id_3DA3A6BAAC919477) && !player _id_85708E6738014787(_id_4D0F2D8665A0751E, _id_F22CDAD2A71426FB) && !player _id_85708E6738014787(_id_62E7631E973CCD36, _id_3F0D8BCA76BE4113);
}

_id_B9B8F6C50C7C85B4(agent) {
  if(!_id_AF89FB0FC9B8712E(agent))
    return 1;

  _id_07E59B71E80A4EEE = agent._id_B6656956EA57A8D8.nodes["shore_marker"];
  _id_8922F30412A7BCD4 = 200;

  foreach(marker in _id_07E59B71E80A4EEE) {
    if(distance2d(agent.origin, marker.origin) <= _id_8922F30412A7BCD4)
      return 1;
  }

  dist = _id_248A764376D7285B(agent, agent.origin);
  return dist <= 100;
}

_id_AF89FB0FC9B8712E(agent) {
  if(!isDefined(agent._id_B6656956EA57A8D8) || !isDefined(agent._id_B6656956EA57A8D8.nodes))
    return 0;

  if(_id_059DAF59E3F693CE(agent))
    return 0;

  if(level.script == "mp_br_mechanics")
    return 1;

  _id_07E59B71E80A4EEE = agent._id_B6656956EA57A8D8.nodes["shore_marker"];
  _id_8922F30412A7BCD4 = 200;

  foreach(marker in _id_07E59B71E80A4EEE) {
    if(distance2d(agent.origin, marker.origin) <= _id_8922F30412A7BCD4)
      return 0;
  }

  _id_3DA3A6BAAC919477 = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner1"][0];
  _id_E43F4FCD4098F7FA = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner2"][0];
  _id_F22CDAD2A71426FB = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner1"][0];
  _id_4D0F2D8665A0751E = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner2"][0];
  _id_3F0D8BCA76BE4113 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner1"][0];
  _id_62E7631E973CCD36 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner2"][0];
  return !agent _id_85708E6738014787(_id_E43F4FCD4098F7FA, _id_3DA3A6BAAC919477) && !agent _id_85708E6738014787(_id_4D0F2D8665A0751E, _id_F22CDAD2A71426FB) && !agent _id_85708E6738014787(_id_62E7631E973CCD36, _id_3F0D8BCA76BE4113);
}

_id_85708E6738014787(_id_E43F4FCD4098F7FA, _id_3DA3A6BAAC919477) {
  _id_3D9B4679B8D7E8FA = _id_E43F4FCD4098F7FA.origin[0];
  _id_3D9B4779B8D7EB2D = _id_E43F4FCD4098F7FA.origin[1];
  _id_3D9B4479B8D7E494 = _id_E43F4FCD4098F7FA.origin[2];
  _id_4C69B2E8A053C33F = _id_3DA3A6BAAC919477.origin[0];
  _id_4C69B1E8A053C10C = _id_3DA3A6BAAC919477.origin[1];
  _id_4C69B4E8A053C7A5 = _id_3DA3A6BAAC919477.origin[2];

  if((!isDefined(_id_3D9B4679B8D7E8FA) || self.origin[0] < _id_3D9B4679B8D7E8FA) && (!isDefined(_id_4C69B2E8A053C33F) || self.origin[0] > _id_4C69B2E8A053C33F) && (!isDefined(_id_3D9B4779B8D7EB2D) || self.origin[1] < _id_3D9B4779B8D7EB2D) && (!isDefined(_id_4C69B1E8A053C10C) || self.origin[1] > _id_4C69B1E8A053C10C) && (!isDefined(_id_3D9B4479B8D7E494) || self.origin[2] < _id_3D9B4479B8D7E494) && (!isDefined(_id_4C69B4E8A053C7A5) || self.origin[2] > _id_4C69B4E8A053C7A5))
    return 1;

  return 0;
}

_id_059DAF59E3F693CE(agent) {
  if(level.script == "mp_br_mechanics")
    return 0;

  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  return distance2d(_id_B2B24BB9E0275FBA, agent.origin) > 1650;
}

_id_A99572E621A19DBE(agent, point) {
  if(level.script == "mp_br_mechanics")
    return 0;

  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  return distance2d(_id_B2B24BB9E0275FBA, point) > 1650;
}

_id_E4DB177671E883DE(position) {
  level endon("game_ended");
  level endon("swamp_monster_reset");

  for(;;) {
    _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(position, 64);

    if(isDefined(_id_78122E18403A8DC4) && _id_78122E18403A8DC4.size > 0) {
      foreach(player in _id_78122E18403A8DC4)
      player setvelocity((0, 300, 50));
    }

    wait 2;
  }
}

_id_3B0A4BD73F24C35B(player) {
  _id_20F9B288FF19E7D7 = getclosestpointonnavmesh(player.origin);
  return distance2d(_id_20F9B288FF19E7D7, player.origin) > 70;
}

_id_29B8AC405D06B088(agent) {
  level endon("game_ended");
  agent endon("death");
  _id_2EFE5529D8C9E37A(agent, "returning to play area");
  destinations = _id_84BE5BCD62C9A89F(agent);
  _id_E3386FD69D01ECF5 = scripts\engine\utility::random(destinations);
  agent.invulnerable = 1;
  agent.ignoreall = 1;
  agent.dontevershoot = 1;
  _id_E3386FD69D01ECF5._id_950511821B7A2895 = 1;
  agent setgoalpos(_id_E3386FD69D01ECF5.origin);
  msg = agent scripts\engine\utility::waittill_any_timeout_1(7, "goal");
  _id_E3386FD69D01ECF5._id_950511821B7A2895 = 0;
  _id_2EFE5529D8C9E37A(self, undefined);
  _id_8A5DE523783CC38C(self);
}

_id_1067A1F83551E4BB(agent) {
  _id_B2B24BB9E0275FBA = agent._id_B6656956EA57A8D8.nodes["island_marker"][0];
  _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(_id_B2B24BB9E0275FBA.origin, 1650);

  foreach(_id_6EE5484560EC747C in _id_78122E18403A8DC4) {
    if(_id_A99572E621A19DBE(agent, _id_6EE5484560EC747C.origin) || _id_6EE5484560EC747C.origin[2] > _id_B2B24BB9E0275FBA.origin[2] || !_id_B3AAC6982108DF0B(agent, _id_6EE5484560EC747C))
      _id_78122E18403A8DC4 = scripts\engine\utility::array_remove(_id_78122E18403A8DC4, _id_6EE5484560EC747C);
  }

  return _id_78122E18403A8DC4;
}

_id_7CAD7AF3334B53B9(agent, _id_3ED6410766006A6B) {
  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);

  if(isDefined(agent) && isDefined(agent._id_B6656956EA57A8D8) && isDefined(agent._id_B6656956EA57A8D8.nodes))
    _id_B2B24BB9E0275FBA = agent._id_B6656956EA57A8D8.nodes["island_marker"][0].origin;

  if(level.script == "mp_br_mechanics")
    _id_B2B24BB9E0275FBA = agent.origin;

  _id_397EB484DFDDD2DA = scripts\engine\utility::ter_op(isDefined(_id_3ED6410766006A6B), _id_3ED6410766006A6B, 1650);
  _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(_id_B2B24BB9E0275FBA, _id_397EB484DFDDD2DA);
  return _id_78122E18403A8DC4;
}

_id_449508F8B0C7A85B() {
  self endon("death");
  level endon("game_ended");
  self endon("abort_submerge");
  self notify("single_submerge");
  self endon("single_submerge");

  if(istrue(self.ishidden) || istrue(self._id_B0DE97037A47640C) || self isinexecutionattack() || istrue(self._id_6A7C53BFA7695667)) {
    return;
  }
  _id_2EFE5529D8C9E37A(self, "submerging");
  destinations = _id_84BE5BCD62C9A89F(self);
  _id_E3386FD69D01ECF5 = scripts\engine\utility::getclosest(self.origin, destinations);
  _id_E3386FD69D01ECF5._id_950511821B7A2895 = 1;
  self._id_B582B10663B5B2A9 = 0;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self playSound("iw9_swmpmon_teleport_out");

  if(!_id_AF89FB0FC9B8712E(self)) {
    self.goalradius = 2000;
    _id_B438D545147CE640 = self getclosestreachablepointonnavmesh(_id_E3386FD69D01ECF5.origin, 0);

    for(msg = ""; isDefined(_id_B438D545147CE640) && !_id_AF89FB0FC9B8712E(self) && distance2d(_id_B438D545147CE640, self.origin) > 30; msg = scripts\engine\utility::waittill_any_timeout_1(10, "goal")) {
      self.cannotmelee = 1;
      self setgoalpos(_id_B438D545147CE640, 10);
    }
  }

  _id_E3386FD69D01ECF5._id_950511821B7A2895 = 0;
  self playSound("iw9_swmpmon_teleport_in");
  _id_2EFE5529D8C9E37A(self, undefined);
  _id_8A5DE523783CC38C(self);
  self.cannotmelee = 0;
}

_id_E54437F7279D93CD() {
  level endon("game_ended");

  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("swampmonster");
  level thread _id_CD2E704148E58F96(_id_0BAA08EA813E9752);
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(level._id_6A4C9FBD7AA58544["swampmonster"]) || !isDefined(level._id_6A4C9FBD7AA58544["swampmonster"]._id_BFE291B401A9BF2A)) {
    return;
  }
  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("create_script_initialized");
  _id_1435F6F97C873063 = 0;

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    _id_58C817414D96DE59 = _id_2636152C566D6C64::_id_2E6E2B664DFE3186("swampmonster", _id_1435F6F97C873063);

    while(!scripts\mp\flags::gameflagexists("prematch_done"))
      waitframe();

    scripts\mp\flags::gameflagwait("prematch_done");
    _id_2636152C566D6C64::_id_F7B1205F52BED8EB();
  } else {
    _id_58C817414D96DE59 = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("swampmonster", _id_1435F6F97C873063);
    _id_48814951E916AF89::_id_2FC80954FA70D153();
  }

  level._id_B0F20C131FB4C970 = max(1, getdvarint("dvar_7A060740BB61540D", 3));
  _id_58C817414D96DE59._id_E2958F412A7425C0 = _id_58C817414D96DE59 _id_1FE51EC5B74709B8(_id_0BAA08EA813E9752);

  if(!isDefined(_id_58C817414D96DE59._id_E2958F412A7425C0))
    return 0;

  _id_58C817414D96DE59._id_94F42DC3D13C82DA = [];
  level._id_CAFAB962CCAE1309 = 0;
  level._id_EC5D7D7C03465F96 = 1;
  _id_58C817414D96DE59._id_E2958F412A7425C0._id_0566868292EE2A1B = _id_58C817414D96DE59;
  _id_58C817414D96DE59._id_E2958F412A7425C0._id_B6656956EA57A8D8 = _id_0BAA08EA813E9752;
  _id_58C817414D96DE59._id_47BDE44B1ACEC603 = "swampmonster";
  _id_58C817414D96DE59._id_7D8AD21E5DFD7C94 = [];
  _id_9D4D84F5EFD3E1D3 = _id_58C817414D96DE59._id_E2958F412A7425C0._id_B6656956EA57A8D8.nodes["swampmonster_submerge_dest"];
  _id_A46CFB9A07B1E96E = max(level._id_B0F20C131FB4C970, 0);
  _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_58C817414D96DE59._id_94F42DC3D13C82DA.size] = _id_58C817414D96DE59._id_E2958F412A7425C0;
  _id_58C817414D96DE59._id_E2958F412A7425C0 thread _id_6581326A6869EF0D();

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_A46CFB9A07B1E96E; _id_AC0E594AC96AA3A8++) {
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8] = _id_58C817414D96DE59 _id_1FE51EC5B74709B8(_id_9D4D84F5EFD3E1D3[_id_AC0E594AC96AA3A8]);
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8]._id_BC7E45BE78F95FAE = randomintrange(5, 12);
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8]._id_0566868292EE2A1B = _id_58C817414D96DE59;
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8]._id_B6656956EA57A8D8 = _id_0BAA08EA813E9752;
    _id_58C817414D96DE59._id_47BDE44B1ACEC603 = "swampmonster";
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8]._id_05BFB286781D06AF = 1;
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8]._id_712C4F862927DE81 = 0;
    _id_58C817414D96DE59._id_94F42DC3D13C82DA[_id_AC0E594AC96AA3A8] thread _id_6581326A6869EF0D();
    level._id_EC5D7D7C03465F96++;
  }

  level._id_019E7FA2B6A9A517 = _id_58C817414D96DE59;

  if(scripts\mp\utility\game::getsubgametype() == "zxp")
    level._id_019E7FA2B6A9A517 thread _id_B1D4BF18FFCBD3C6();

  _id_58C817414D96DE59 notify("boss_spawned");
  _id_3F2BB11B0923652C = _id_58C817414D96DE59._id_E2958F412A7425C0._id_B6656956EA57A8D8.nodes["swampmonster_egg_mound"];

  foreach(_id_3997B0AD4A969257 in _id_3F2BB11B0923652C) {
    level thread _id_9C2A8EB1E6C87138(_id_3997B0AD4A969257.origin, _id_3997B0AD4A969257.angles, "br_loot_swamp_eggmound_cache");
    waitframe();
  }

  if(!istrue(level._id_365AAA4F88184EC5)) {
    _id_0675F35EA00F7699 = _id_58C817414D96DE59._id_E2958F412A7425C0._id_B6656956EA57A8D8.nodes["swampmonster_egg_mound_small"];

    foreach(_id_520634B7DEA2D070 in _id_0675F35EA00F7699) {
      level thread _id_9C2A8EB1E6C87138(_id_520634B7DEA2D070.origin, _id_520634B7DEA2D070.angles, "br_loot_swamp_eggmound_cache_small");
      waitframe();
    }

    level._id_365AAA4F88184EC5 = 1;
  }

  if(!isDefined(level._id_D0EB742034589336)) {
    foreach(_id_8FFE8998D8EDCE39 in _id_58C817414D96DE59._id_E2958F412A7425C0._id_B6656956EA57A8D8.nodes["tiara_placement"]) {
      level._id_D0EB742034589336 = spawnscriptable("dmz_boss_swamp_deposit", _id_8FFE8998D8EDCE39.origin, _id_8FFE8998D8EDCE39.angles);
      waitframe();
    }
  }

  level._id_D0EB742034589336 setscriptablepartstate("tiara_deposit", "usable");
  level._id_D0EB742034589336 setscriptablepartstate("tiara_effects", "tiara_not_deposited");
  pos = _id_58C817414D96DE59._id_E2958F412A7425C0.origin;
  _id_58C817414D96DE59.origin = _id_58C817414D96DE59._id_E2958F412A7425C0.origin;
  level thread _id_940CE727AFAF46D1(_id_0BAA08EA813E9752.nodes["island_marker"][0].origin);

  if(getdvarint("dvar_E86C8640A9F24AED", 0) > 0)
    level thread _id_D45A23AF31EFD881(_id_0BAA08EA813E9752.nodes["island_marker"][0].origin);

  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  _id_58C817414D96DE59 thread _id_E2188A435D3F9D14(_id_B2B24BB9E0275FBA);
  _id_58C817414D96DE59._id_E2958F412A7425C0.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
  level thread _id_D179ABC58F83AE22(_id_58C817414D96DE59._id_E2958F412A7425C0);
  level thread _id_F489EC026DF946F6();

  if(_id_5C0ACA19C49C82C6())
    level thread _id_1D8B87E922D77A4E(5);
}

_id_CD2E704148E58F96(_id_C83DB2AA8491016D) {
  level endon("game_ended");

  if(istrue(level._id_568C31045B16759B)) {
    return;
  }
  level._id_568C31045B16759B = 1;

  if(!isDefined(_id_C83DB2AA8491016D) || !isDefined(_id_C83DB2AA8491016D.nodes)) {
    return;
  }
  foreach(_id_A553863F30E41A58 in _id_C83DB2AA8491016D.nodes["swampmonster_egg_mound"]) {
    _id_6980C0907835BF84 = _id_A553863F30E41A58 scripts\engine\utility::spawn_tag_origin();
    _id_6980C0907835BF84 setModel("art_hlwn_swamp_monster_egg");
    _id_6980C0907835BF84 thread _id_4919D22A21BC5EF1();
  }

  foreach(_id_520634B7DEA2D070 in _id_C83DB2AA8491016D.nodes["swampmonster_egg_mound_small"]) {
    _id_6980C0907835BF84 = _id_520634B7DEA2D070 scripts\engine\utility::spawn_tag_origin();
    _id_6980C0907835BF84 setModel("art_hlwn_swamp_monster_egg");
    _id_6980C0907835BF84 thread _id_4919D22A21BC5EF1();
  }
}

_id_4919D22A21BC5EF1() {
  level endon("game_ended");
  self show();
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 0.5;
  self delete();
}

_id_1D8B87E922D77A4E(_id_8B83995B351FC9B9) {
  level endon("game_ended");
  wait(_id_8B83995B351FC9B9);
  scripts\engine\utility::flag_set("golden_tiara_deposited");
}

_id_1FE51EC5B74709B8(_id_0BAA08EA813E9752) {
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("create_script_initialized");
  aitype = "enemy_mp_boss_swampmonster";
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_0BAA08EA813E9752.origin, _id_0BAA08EA813E9752.angles, "absolute", "bosses", "swampBoss", undefined, undefined, undefined, "bossArea", 1, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  level._id_7BF4234FE2B5B3DF = 1;
  _id_E2958F412A7425C0.disabledodge = 1;
  _id_E2958F412A7425C0._id_B3FA6C20CA52B960 = 0;
  _id_E2958F412A7425C0._id_CD251FBF5563EB4A = 0;
  _id_E2958F412A7425C0._id_F44C9CEDE4FB20D6 = 1;
  _id_E2958F412A7425C0.meleechargedistvsplayer = 125;
  _id_E2958F412A7425C0._id_384C9CC6CD2605D0 = 1;
  _id_E2958F412A7425C0.pathenemyfightdist = 0;
  _id_E2958F412A7425C0._id_47BDE44B1ACEC603 = "swampmonster";
  _id_E2958F412A7425C0._id_E0C57AF70D480252 = 1;
  _id_E2958F412A7425C0 _meth_4CA9518DC8BEF142("all", 0);
  _id_E2958F412A7425C0.meleestopattackdistsq = 6400;
  _id_E2958F412A7425C0.meleemaxzdiff = 150;
  _id_E2958F412A7425C0._id_8F438EA9E6AE83A2 = 6400;
  _id_E2958F412A7425C0.meleebashmaxdistsq = 14400;
  _id_E2958F412A7425C0.meleetryhard = 1;
  _id_E2958F412A7425C0.meleerangesq = 6400;
  _id_E2958F412A7425C0.meleetargetallowedoffmeshdistsq = 30625;
  _id_E2958F412A7425C0.meleeignorefinalzdiff = 1;
  _id_E2958F412A7425C0.meleeignoreplayerstance = 1;
  _id_E2958F412A7425C0.meleeallowoffground = 1;
  _id_E2958F412A7425C0._id_B582B10663B5B2A9 = 0;
  _id_E2958F412A7425C0.ignoreall = 1;
  _id_E2958F412A7425C0.dontevershoot = 1;
  _id_E2958F412A7425C0.allowstrafe = 0;
  _id_E2958F412A7425C0._id_DF41B7F76F62D9A2 = 0;
  _id_E2958F412A7425C0._id_F891E067B8802C0D = 1;
  _id_E2958F412A7425C0._id_274D3A7704E351EF = 1;
  _id_E2958F412A7425C0.flashbangimmunity = 1;
  _id_E2958F412A7425C0._id_09584776529FB7F6 = "execution_boss_swamp_monster_00";
  _id_E2958F412A7425C0 scripts\cp_mp\execution::_giveexecution(_id_E2958F412A7425C0._id_09584776529FB7F6);
  _id_E2958F412A7425C0._id_2D8D11A34BE5B244 = ::_id_13CE59DA416A7BDF;
  _id_E2958F412A7425C0._id_922C14FABBF684D5 = ::_id_993B445D491824A0;
  _id_E2958F412A7425C0._id_CDBC6EE27C5C2856 = ::_id_7CDC6F5456555D9D;
  _id_E2958F412A7425C0._id_AB96E6AE80B66789 = ::_id_4985FB0FA7468558;
  _id_5A5F8C8EC99C525D(_id_E2958F412A7425C0);
  _id_E2958F412A7425C0.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
  return _id_E2958F412A7425C0;
}

_id_4985FB0FA7468558(attacker, objweapon, smeansofdeath, _id_24DF708F286B0562, _id_BE4285B26ED99AB1) {
  maxdamage = 2000;

  if(_id_24DF708F286B0562 > maxdamage)
    _id_24DF708F286B0562 = maxdamage;

  return _id_24DF708F286B0562;
}

_id_4B9CD56D06F116CC(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_CCCD6F66C0CAF114 = isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  _id_FACFECFAC4909D65 = _id_CCCD6F66C0CAF114 && isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH";

  if(istrue(_id_FACFECFAC4909D65))
    idamage = 0;

  self.lastattackedtime = gettime();

  if(!scripts\engine\utility::flag("golden_tiara_deposited"))
    idamage = int(idamage / 3);

  if(_id_BCB39287B2494544(self) == "submerging")
    idamage = 1;

  if(!isDefined(_id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers")))
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "haunting_attackers", spawnStruct());

  if(isPlayer(eattacker)) {
    self._id_9E8FCAC6728AA14F = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "haunting_attackers");

    if(isDefined(self._id_9E8FCAC6728AA14F)) {
      if(!isDefined(self._id_9E8FCAC6728AA14F.attackers))
        self._id_9E8FCAC6728AA14F.attackers = [];

      if(!isDefined(self._id_9E8FCAC6728AA14F.attackers[eattacker.guid]))
        self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, 0];

      [_, _id_535FD96FD1B3C9BC] = self._id_9E8FCAC6728AA14F.attackers[eattacker.guid];
      self._id_9E8FCAC6728AA14F.attackers[eattacker.guid] = [eattacker, _id_535FD96FD1B3C9BC + idamage];
    }
  }

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(istrue(self._id_E870C27D6E431A3B)) {
    self._id_8392C47BCDD3138A = self._id_8392C47BCDD3138A + idamage;
    _id_12C56D891BFE7EBF = getdvarint("dvar_145DB17EBE132FB4", 500);

    if(self._id_8392C47BCDD3138A >= _id_12C56D891BFE7EBF) {
      _id_0430056385102FBD = 2.0;
      self shellshock("flashbang_mp", _id_0430056385102FBD);
      self notify("flashbang", self.origin, 1, 1, eattacker, undefined, _id_0430056385102FBD);
    }
  }
}

_id_993B445D491824A0() {
  self._id_E870C27D6E431A3B = 1;

  if(isDefined(self.enemy)) {
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "executeVictim", self.enemy);
    self.enemy.ignoreme = 1;
    self._id_4882EE0CD4E52575 = createnavbadplacebybounds(self.enemy.origin, (50, 50, 50), (0, 0, 0));
  }
}

_id_7CDC6F5456555D9D() {
  self._id_E870C27D6E431A3B = 0;
  self._id_B0DE97037A47640C = 0;
  self._id_8392C47BCDD3138A = 0;
  _id_74257B521753F376 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(self, "executeVictim");

  if(isDefined(_id_74257B521753F376)) {
    destroynavobstacle(self._id_4882EE0CD4E52575);
    _id_74257B521753F376.ignoreme = 0;
  }
}

_id_DBDDAC9A330ACF90(agent) {
  level endon("game_ended");
  agent endon("death");
  level waittill("dmz_ai_removed_ignoreall_after_initialtime");
  agent.ignoreall = 1;
}

_id_5A5F8C8EC99C525D(agent) {
  level endon("game_ended");

  if(!isDefined(agent)) {
    return;
  }
  agent endon("death");

  if(!istrue(agent._id_E5A5F53BE7F94F72)) {
    level thread _id_DBDDAC9A330ACF90(agent);
    agent._id_E5A5F53BE7F94F72 = 1;
  }

  agent._id_A4738C70736D3A61 = ::_id_4B9CD56D06F116CC;
  agent thread _id_120270BD0A747A35::_id_C7307D56A1A61172(agent);
  maxhealth = int(13000 / level._id_B0F20C131FB4C970);
  _id_388CDEBC14DD4AA4 = int(3000 / level._id_B0F20C131FB4C970);
  maxhealth = getdvarint("dvar_2A00183F0059AF8C", maxhealth);
  _id_A664AAD02EE98BD2 = "gas_mp";
  agent.health = maxhealth;
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  weapon = undefined;
  armor = _id_388CDEBC14DD4AA4;
  helmet = 0;
  agent._id_668B72F41E87C75A = 1;
  agent._id_65771500F49956C1 = 1;
  agent._id_EF3BFD0243258E2F = 1;
  agent._id_9DFC77CE3CD9E879 = 0;
  agent._id_8392C47BCDD3138A = 0;
  agent scripts\engine\utility::set_movement_speed(150);

  if(getdvarint("dvar_49999CDD38F3A9AE", 0) > 0) {
    armor = 2;
    agent.health = 2;
  }

  agent._id_D38FB77455B25729 = 4000;
  agent._id_BA2F6374446E1525 = 0;
  agent._id_E6AF4BA7CF5CC852 = 0;
  agent._id_62482B4F67666074 = 10000;
  agent._id_A7AAE99DA4C9E990 = 60000;
  agent._id_2808079B46AE6650 = 3000;
  agent._id_7528BDD4F8EA8811 = 0;
  agent._id_0A83B580F45A7120 = 20000;
  agent._id_0D42CFFB8DAA15E0 = 1;
  agent.a.disablepain = 1;
  agent.meleestopattackdistsq = 6400;
  agent.stopanimdistsq = 6400;
  agent.meleemaxzdiff = 200;
  agent._id_8F438EA9E6AE83A2 = 250000;
  agent.meleebashmaxdistsq = 250000;
  agent.meleetryhard = 1;
  agent.meleerangesq = 4096;
  agent.meleetargetallowedoffmeshdistsq = 30625;
  agent.agentname = &"MP/SWAMP_MONSTER";

  if(scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "zxp")
    agent thread _id_9AC3FCB0DF626212(agent);

  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  headmodel = undefined;
  bodymodel = undefined;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(bodymodel, headmodel, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("swampmonster", 0, undefined);
  agent takeallweapons(1);
  agent.unarmedmeleedamageoverride = 60;
  agent.meleedamageoverride = 60;
  agent._id_2A3891ADA6ABEA80 = 40;
  agent thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(5000);
  agent setclothtype("wetsuit");
  agent setentitysoundcontext("gender", "swmpmon");
  agent thread _id_B537B87E1E9D4B35();
  _id_120270BD0A747A35::_id_1670C315976C767B();

  while(!isDefined(agent._blackboard))
    waitframe();

  _id_8A5DE523783CC38C(agent);
  agent thread _id_8CF657CAB070FB6E(agent);
  agent.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
}

_id_A618ABCD648D31F2(agent) {
  level endon("game_ended");
  agent endon("death");

  for(;;) {
    _id_3188E119DCAD9617 = getdvarint("dvar_806E29EA6B2515AA", 80);
    agent.meleestopattackdistsq = _id_3188E119DCAD9617 * _id_3188E119DCAD9617;
    stopanimdistsq = getdvarint("stopanimdistsq", 80);
    agent.stopanimdistsq = _id_3188E119DCAD9617 * _id_3188E119DCAD9617;
    meleemaxzdiff = getdvarint("meleemaxzdiff", 200);
    agent.meleemaxzdiff = meleemaxzdiff;
    _id_F10569B9FA122F4B = getdvarint("dvar_643452DAC2497244", 500);
    agent._id_8F438EA9E6AE83A2 = _id_F10569B9FA122F4B * _id_F10569B9FA122F4B;
    _id_4952A40DFC3FE1AD = getdvarint("dvar_AEC397D6B3749BB8", 500);
    agent.meleebashmaxdistsq = _id_4952A40DFC3FE1AD * _id_4952A40DFC3FE1AD;
    agent.meleetryhard = 1;
    meleerangesq = getdvarint("meleerangesq", 64);
    agent.meleerangesq = meleerangesq * meleerangesq;
    _id_87551B1BFCF31747 = getdvarint("dvar_273B9726D5C51664", 80);
    agent.meleetargetallowedoffmeshdistsq = _id_87551B1BFCF31747 * _id_87551B1BFCF31747;
    wait 2;
  }
}

_id_22A9B8E81451C261(agent) {
  level endon("game_ended");
  agent endon("death");

  for(;;) {
    if(isDefined(agent._id_3C2E0CFAE3F59DA6)) {} else {}

    waitframe();
  }
}

_id_BCB39287B2494544(agent) {
  if(!isDefined(agent._id_3C2E0CFAE3F59DA6))
    return "";
  else
    return agent._id_3C2E0CFAE3F59DA6;
}

_id_5DD4017756C10045(agent) {
  level endon("game_ended");
  agent endon("death");

  for(;;) {
    dist = _id_248A764376D7285B(agent, level.players[0].origin);
    wait 3;
  }
}

_id_248A764376D7285B(agent, point) {
  if(!isDefined(agent._id_B6656956EA57A8D8) || !isDefined(agent._id_B6656956EA57A8D8.nodes))
    return 0;

  _id_DC8EC88E32BC7530 = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner1"][0];
  _id_72FF98B70CC50641 = agent._id_B6656956EA57A8D8.nodes["marsh_island_corner2"][0];
  _id_F22CDAD2A71426FB = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner1"][0];
  _id_4D0F2D8665A0751E = agent._id_B6656956EA57A8D8.nodes["marsh_secondisland_corner2"][0];
  _id_3F0D8BCA76BE4113 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner1"][0];
  _id_62E7631E973CCD36 = agent._id_B6656956EA57A8D8.nodes["marsh_topisland_corner2"][0];
  _id_630D43DA7F95F8FB = _id_2050467F56750143(_id_72FF98B70CC50641, _id_DC8EC88E32BC7530, point);
  _id_37460D7564C32F23 = _id_2050467F56750143(_id_4D0F2D8665A0751E, _id_F22CDAD2A71426FB, point);
  _id_7D3C50A1C7A9247B = _id_2050467F56750143(_id_62E7631E973CCD36, _id_3F0D8BCA76BE4113, point);
  return _id_4FF374E6AC6E5C03(_id_630D43DA7F95F8FB, _id_37460D7564C32F23, _id_7D3C50A1C7A9247B);
}

_id_2050467F56750143(_id_E43F4FCD4098F7FA, _id_3DA3A6BAAC919477, point) {
  _id_3D9B4679B8D7E8FA = _id_E43F4FCD4098F7FA.origin[0];
  _id_3D9B4779B8D7EB2D = _id_E43F4FCD4098F7FA.origin[1];
  _id_4C69B2E8A053C33F = _id_3DA3A6BAAC919477.origin[0];
  _id_4C69B1E8A053C10C = _id_3DA3A6BAAC919477.origin[1];
  _id_CE253D78F5784CB5 = _id_1DB416820755B85D(_id_4C69B2E8A053C33F - point[0], 0, point[0] - _id_3D9B4679B8D7E8FA);
  _id_CE253C78F5784A82 = _id_1DB416820755B85D(_id_4C69B1E8A053C10C - point[1], 0, point[1] - _id_3D9B4779B8D7EB2D);
  return sqrt(_id_CE253D78F5784CB5 * _id_CE253D78F5784CB5 + _id_CE253C78F5784A82 * _id_CE253C78F5784A82);
}

_id_1DB416820755B85D(a, b, c) {
  _id_38CA0CB5DE042DB4 = max(a, b);
  return max(_id_38CA0CB5DE042DB4, c);
}

_id_4FF374E6AC6E5C03(a, b, c) {
  _id_447D5759F09B80EC = min(a, b);
  return min(_id_447D5759F09B80EC, c);
}

_id_7CEF8015C093D5AF(agent) {
  level endon("game_ended");
  agent endon("death");

  for(;;) {
    if(_id_AF89FB0FC9B8712E(agent)) {} else {}

    if(_id_B3AAC6982108DF0B(agent, level.players[0])) {} else {}

    waitframe();
  }
}

_id_2EFE5529D8C9E37A(agent, _id_9B1941CB7354665E) {
  if(isDefined(_id_9B1941CB7354665E))
    agent._id_3C2E0CFAE3F59DA6 = _id_9B1941CB7354665E;
  else
    agent._id_3C2E0CFAE3F59DA6 = undefined;
}

_id_8CF657CAB070FB6E(agent) {
  level endon("game_ended");
  agent endon("death");
  agent thread _id_A8AD22B6BA0F7076(agent);

  while(!isDefined(agent._id_B6656956EA57A8D8))
    wait 1;

  agent._id_B582B10663B5B2A9 = 0;
  agent._id_8FD71E47F0BFAFC4 = 1;

  if(getdvarint("dvar_37F23717A2BBE6FE", 0) > 0)
    level thread _id_7CEF8015C093D5AF(agent);

  if(getdvarint("dvar_B1E08524AE9ACA80", 0) > 0)
    level thread _id_5DD4017756C10045(agent);

  if(getdvarint("dvar_2D8935FC0202BC04", 0) > 0)
    level thread _id_22A9B8E81451C261(agent);

  wait 1;

  if(isDefined(agent._id_BC7E45BE78F95FAE))
    wait(agent._id_BC7E45BE78F95FAE);

  for(;;) {
    if(!scripts\engine\utility::flag("golden_tiara_deposited") && !istrue(agent._id_712C4F862927DE81)) {
      if(!istrue(agent._id_05BFB286781D06AF)) {
        if(!_id_AF89FB0FC9B8712E(agent) && istrue(agent.ishidden)) {
          destinations = _id_84BE5BCD62C9A89F(agent);
          _id_E3386FD69D01ECF5 = scripts\engine\utility::getclosest(agent.origin, destinations);
          agent.origin = _id_E3386FD69D01ECF5.origin;
          agent setgoalpos(self.origin, 10);
          _id_E3386FD69D01ECF5._id_950511821B7A2895 = 1;
          level thread _id_D3610373DEACB91E(_id_E3386FD69D01ECF5, 2);
        }

        _id_AFBDA071364C0505 = agent _id_1A2E678EAE631777();
      } else {
        _id_2EFE5529D8C9E37A(self, "minion_waiting_on_precombat");
        self setgoalpos(self.origin, 10);
        wait(randomintrange(3, 4));
      }
    } else {
      if(_id_059DAF59E3F693CE(agent)) {
        _id_0F06CDAB0AAC6787(agent, 1, 0);
        agent _id_29B8AC405D06B088(agent);
      }

      _id_78122E18403A8DC4 = _id_7CAD7AF3334B53B9(agent);
      _id_78122E18403A8DC4 = _id_F38F124EDF1C44D9(_id_78122E18403A8DC4);

      if(_id_78122E18403A8DC4.size > 0) {
        agent._id_B7B6858949A9FEB8 = 0;
        _id_B0435C622CE575D5 = _id_1A9E1A48F8D66F9E(agent, _id_78122E18403A8DC4);

        if(isDefined(_id_B0435C622CE575D5) && isalive(_id_B0435C622CE575D5)) {
          if(istrue(agent.ishidden) && isDefined(agent._id_B6656956EA57A8D8.nodes)) {
            destinations = _id_84BE5BCD62C9A89F(agent);
            _id_E3386FD69D01ECF5 = scripts\engine\utility::getclosest(_id_B0435C622CE575D5.origin, destinations);
            agent.origin = _id_E3386FD69D01ECF5.origin;
            agent setgoalpos(self.origin, 10);
            _id_E3386FD69D01ECF5._id_950511821B7A2895 = 1;
            level thread _id_D3610373DEACB91E(_id_E3386FD69D01ECF5, 2);
          }

          wait(randomintrange(3, 5));
          _id_45E00B56E373EC98 = 0;

          if(getdvarint("dvar_F1C490897C29AB5C", 0) >= 1) {
            if(!_id_B3AAC6982108DF0B(agent, _id_B0435C622CE575D5))
              _id_45E00B56E373EC98 = 1;
          } else {
            _id_F931906A6CAFF80E = 40;
            _id_45E00B56E373EC98 = randomint(100) < _id_F931906A6CAFF80E;
          }

          if(getdvarint("dvar_9BE9E6F2B609B921", 0) > 0)
            _id_45E00B56E373EC98 = 1;

          if(getdvarint("dvar_D8FC4F40AA0F13F1", 0) > 0)
            _id_45E00B56E373EC98 = 0;

          if(istrue(_id_B0435C622CE575D5.inlaststand))
            _id_45E00B56E373EC98 = 1;

          if(_id_5B7978DFF89C94C5())
            _id_45E00B56E373EC98 = 0;

          if(istrue(_id_45E00B56E373EC98)) {
            if(_id_B9B8F6C50C7C85B4(agent) || !_id_AF89FB0FC9B8712E(agent)) {
              if(istrue(agent.ishidden)) {
                destinations = _id_84BE5BCD62C9A89F(agent);
                _id_E3386FD69D01ECF5 = scripts\engine\utility::random(destinations);
                _id_B572C59B4A46082F = getclosestpointonnavmesh(_id_E3386FD69D01ECF5.origin);
                agent.origin = scripts\engine\utility::drop_to_ground(_id_B572C59B4A46082F);
                _id_E3386FD69D01ECF5._id_950511821B7A2895 = 1;
                level thread _id_D3610373DEACB91E(_id_E3386FD69D01ECF5, 2);
                waitframe();
              } else
                agent _id_449508F8B0C7A85B();
            } else if(istrue(agent.ishidden))
              agent.origin = scripts\engine\utility::drop_to_ground(agent.origin);

            _id_0F06CDAB0AAC6787(agent, 1, 0);

            if(isPlayer(_id_B0435C622CE575D5))
              agent getenemyinfo(_id_B0435C622CE575D5);
            else
              agent.ignoreall = 1;

            agent _id_22DDA6FABB7F5B90(agent, _id_B0435C622CE575D5);
            agent _id_449508F8B0C7A85B();
          } else {
            _id_7293D10E7BE2FA41 = getdvarint("dvar_979EC15FE0E76D11", 80);

            if(getdvarint("dvar_6F5B561700F553EC", 0) > 0)
              _id_7293D10E7BE2FA41 = 100;

            if(_id_B0435C622CE575D5.health < _id_B0435C622CE575D5.maxhealth)
              _id_7293D10E7BE2FA41 = 100;

            _id_EB32D7A20B140383 = randomint(100) < _id_7293D10E7BE2FA41;
            _id_48AAECD532669820 = 0;

            if(getdvarint("dvar_F1C490897C29AB5C", 0) < 1) {
              if(!_id_B3AAC6982108DF0B(agent, _id_B0435C622CE575D5)) {
                _id_EB32D7A20B140383 = 0;
                agent._id_F44C9CEDE4FB20D6 = 0;
              } else
                agent._id_F44C9CEDE4FB20D6 = 1;
            }

            _id_0B5A4396E8058103(_id_B0435C622CE575D5, 1);

            if(istrue(_id_EB32D7A20B140383)) {
              yoffset = scripts\engine\utility::ter_op(randomint(2) == 1, -1, 1);
              _id_48AAECD532669820 = _id_0CC6049C4560E8C4(_id_B0435C622CE575D5, yoffset);
            }

            if(istrue(_id_48AAECD532669820))
              wait(randomintrange(2, 3));
            else {
              if(istrue(agent.ishidden))
                _id_0F06CDAB0AAC6787(agent, 1, 0);

              _id_2EFE5529D8C9E37A(self, "combat melee");

              if(isPlayer(_id_B0435C622CE575D5)) {
                agent getenemyinfo(_id_B0435C622CE575D5);
                agent.dontevershoot = 0;
                agent setthreatsight(_id_B0435C622CE575D5, 1.0);
                agent.goalradius = 20;
                agent setgoalentity(_id_B0435C622CE575D5);
                agent.favoriteenemy = _id_B0435C622CE575D5;
                agent thread _id_7EA079FBAB4E69E7(agent);
                _id_FA58D2B1AAE7508B = agent.health;
                _id_430870F09B5449E4 = max(agent.health - agent.maxhealth / 4, 0);
                _id_64A0E5BF72D8DF37 = 0;

                while(!_id_64A0E5BF72D8DF37) {
                  msg = agent scripts\engine\utility::waittill_any_timeout_1(3, "monster_stepped_out_of_play_area");

                  if(!_id_B3AAC6982108DF0B(agent, _id_B0435C622CE575D5))
                    agent._id_F44C9CEDE4FB20D6 = 0;
                  else
                    agent._id_F44C9CEDE4FB20D6 = 1;

                  if(msg == "monster_stepped_out_of_play_area")
                    _id_64A0E5BF72D8DF37 = 1;

                  if(agent.health <= _id_430870F09B5449E4 && _id_AF89FB0FC9B8712E(agent))
                    _id_64A0E5BF72D8DF37 = 1;

                  if(istrue(_id_B0435C622CE575D5.inlaststand) || !isalive(_id_B0435C622CE575D5))
                    _id_64A0E5BF72D8DF37 = 1;

                  if(_id_3B0A4BD73F24C35B(_id_B0435C622CE575D5))
                    _id_64A0E5BF72D8DF37 = 1;

                  _id_0B5A4396E8058103(_id_B0435C622CE575D5, 0);
                  _id_B0435C622CE575D5 = agent _id_A0FD2D7EF0641C42(agent);

                  if(!isDefined(_id_B0435C622CE575D5) || !isPlayer(_id_B0435C622CE575D5)) {
                    _id_64A0E5BF72D8DF37 = 1;
                    continue;
                  }

                  _id_0B5A4396E8058103(_id_B0435C622CE575D5, 1);
                  agent getenemyinfo(_id_B0435C622CE575D5);
                  agent.dontevershoot = 0;
                  agent setthreatsight(_id_B0435C622CE575D5, 1.0);
                  agent.goalradius = 20;
                  agent setgoalentity(_id_B0435C622CE575D5);
                  agent.favoriteenemy = _id_B0435C622CE575D5;
                }

                _id_2EFE5529D8C9E37A(self, undefined);
                agent notify("finished_combat_melee_sequence");
              } else
                agent.ignoreall = 1;

              wait(randomintrange(1, 3));
            }

            agent _id_449508F8B0C7A85B();
          }
        }

        waitframe();
      } else {
        agent._id_B7B6858949A9FEB8 = 1;
        _id_2EFE5529D8C9E37A(agent, "waiting_for_players");

        if(!istrue(self.ishidden))
          agent _id_449508F8B0C7A85B();

        agent setgoalpos(agent.origin, 8);
        wait(randomintrange(1, 3));
        _id_2EFE5529D8C9E37A(agent, undefined);
      }
    }

    waitframe();
  }
}

_id_A0FD2D7EF0641C42(agent) {
  _id_78122E18403A8DC4 = _id_7CAD7AF3334B53B9(agent);
  _id_B0435C622CE575D5 = _id_1A9E1A48F8D66F9E(agent, _id_78122E18403A8DC4);

  if(isPlayer(_id_B0435C622CE575D5) && !istrue(_id_B0435C622CE575D5.inlaststand)) {
    agent getenemyinfo(_id_B0435C622CE575D5);
    agent.dontevershoot = 0;
    agent setthreatsight(_id_B0435C622CE575D5, 1.0);
    agent.goalradius = 20;
    agent setgoalentity(_id_B0435C622CE575D5);
    agent.favoriteenemy = _id_B0435C622CE575D5;
    return _id_B0435C622CE575D5;
  }

  return undefined;
}

_id_7EA079FBAB4E69E7(agent) {
  level endon("game_ended");
  agent endon("death");
  agent endon("finished_combat_melee_sequence");

  for(;;) {
    if(_id_059DAF59E3F693CE(agent))
      agent notify("monster_stepped_out_of_play_area");

    waitframe();
  }
}

_id_F38F124EDF1C44D9(_id_78122E18403A8DC4) {
  if(!isDefined(level.activesentients) || !isDefined(level.activesentients["Killstreak_Ground"]))
    return _id_78122E18403A8DC4;

  _id_F9468AD15EA9075D = [];

  foreach(_id_CC1496DD4AB3851B in level.activesentients["Killstreak_Ground"]) {
    if(isDefined(_id_CC1496DD4AB3851B.weapon_name) && _id_CC1496DD4AB3851B.weapon_name == "deployed_decoy_mp" && _id_8066F03F6D950E19(_id_CC1496DD4AB3851B.origin))
      _id_F9468AD15EA9075D[_id_F9468AD15EA9075D.size] = _id_CC1496DD4AB3851B;

    waitframe();
  }

  return scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_F9468AD15EA9075D);
}

_id_8066F03F6D950E19(point) {
  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  _id_1F08AA393E5981B5 = 1048576;
  return distance2dsquared(point, _id_B2B24BB9E0275FBA) <= _id_1F08AA393E5981B5;
}

_id_1A9E1A48F8D66F9E(agent, _id_78122E18403A8DC4) {
  if(_id_78122E18403A8DC4.size == 1)
    return _id_78122E18403A8DC4[0];

  _id_2EF52DCF0611C1A3 = [];

  foreach(player in _id_78122E18403A8DC4) {
    if(_id_B3AAC6982108DF0B(agent, player))
      _id_2EF52DCF0611C1A3[_id_2EF52DCF0611C1A3.size] = player;

    if(isDefined(player.weapon_name) && player.weapon_name == "deployed_decoy_mp")
      _id_2EF52DCF0611C1A3[_id_2EF52DCF0611C1A3.size] = player;
  }

  _id_A682E84261A6B971 = _id_2EF52DCF0611C1A3;

  if(_id_2EF52DCF0611C1A3.size <= 0)
    _id_A682E84261A6B971 = _id_78122E18403A8DC4;

  _id_3B7354544F9CA969 = 9999;
  bestplayer = _id_A682E84261A6B971[0];

  foreach(player in _id_A682E84261A6B971) {
    if(player.health < _id_3B7354544F9CA969) {
      _id_3B7354544F9CA969 = player.health;
      bestplayer = player;
    }

    if(distance2d(player.origin, agent.origin) < distance2d(bestplayer.origin, agent.origin))
      bestplayer = player;
  }

  return bestplayer;
}

_id_0B5A4396E8058103(player, _id_41D8BF229CF29051) {
  player._id_238796ED49B04ACF = _id_41D8BF229CF29051;
}

_id_DCA244646149119C(_id_BAB0D10E51188531) {
  if(_id_BAB0D10E51188531.size <= 1)
    return _id_BAB0D10E51188531;

  _id_BFC65A378A6D8EFE = [];

  foreach(player in _id_BAB0D10E51188531) {
    if(!istrue(player._id_238796ED49B04ACF))
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = player;
  }

  if(_id_BFC65A378A6D8EFE.size > 0)
    return _id_BFC65A378A6D8EFE;
  else
    return _id_BAB0D10E51188531;
}

_id_5C0ACA19C49C82C6() {
  if(getdvarint("dvar_9BE9E6F2B609B921", 0) > 0)
    return 1;

  if(getdvarint("dvar_D8FC4F40AA0F13F1", 0) > 0)
    return 1;

  if(getdvarint("dvar_6F5B561700F553EC", 0) > 0)
    return 1;

  return 0;
}

_id_5B7978DFF89C94C5() {
  if(getdvarint("dvar_D8FC4F40AA0F13F1", 0) > 0)
    return 1;

  if(getdvarint("dvar_6F5B561700F553EC", 0) > 0)
    return 1;

  return 0;
}

_id_F489EC026DF946F6() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("golden_tiara_deposited");
  wait 2;
  earthquake(0.75, 3, level._id_D0EB742034589336.origin, 300);
  _id_171F90B9C4C76D44 = "saba_marshland";
  _id_AC4C51BF033F6323 = level.players;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_swampmonster_activated", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  scripts\engine\utility::delaythread(1, _id_7AB5B649FA408138::_id_FE75A89529DD0FD0, _id_AC4C51BF033F6323, "mx_dmz_boss_swampmonster_surprise", undefined, undefined, undefined);
}

_id_A8AD22B6BA0F7076(agent) {
  level endon("game_ended");
  agent endon("death");
  scripts\engine\utility::flag_wait("player_deposited_tiara");
  agent notify("entered_combat_phase");
  agent playsoundonmovingent("iw9_swmpmon_yell_vo");
  wait 2;
  agent.unarmedmeleedamageoverride = 60;
  agent.meleedamageoverride = 60;
  agent._id_2A3891ADA6ABEA80 = 60;
}

_id_8A5DE523783CC38C(agent, _id_D153C3A40B959FE7) {
  level endon("game_ended");
  agent endon("death");
  _id_2EFE5529D8C9E37A(agent, "hiding");
  agent.cannotmelee = 1;

  if(!istrue(_id_D153C3A40B959FE7)) {
    agent scripts\asm\asm_bb::bb_setanimScripted();
    agent asmsetstate(agent.asmname, "animscripted");
    agent animmode("noclip");
    agent dontinterpolate();
    _id_1C082BC94C051CC3 = ["swamp_exposed_stand_despawn_01", "swamp_exposed_stand_despawn_02"];
    _id_557242BD0F4C33B6 = randomint(_id_1C082BC94C051CC3.size);
    animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", _id_1C082BC94C051CC3[_id_557242BD0F4C33B6]);
    xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
    agent aisetanim("animscripted", animindex);
    animlength = getanimlength(xanim);
    wait(animlength);
    agent scripts\asm\asm_bb::bb_clearanimScripted();
  }

  agent._id_B582B10663B5B2A9 = 0;
  agent.ignoreall = 1;
  agent.dontevershoot = 1;
  agent.invulnerable = 1;
  agent.ishidden = 1;
  agent _meth_68A2305FCD0FE054();
  agent setgoalpos(agent.origin, 8);
  agent.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
  _id_2EFE5529D8C9E37A(agent, undefined);
}

_id_0F06CDAB0AAC6787(agent, _id_515E0AB8E3171486, _id_D153C3A40B959FE7, _id_7A21B65B17064C21) {
  level endon("game_ended");
  agent endon("death");
  _id_2EFE5529D8C9E37A(agent, "emerging");

  if(!istrue(_id_D153C3A40B959FE7)) {
    agent setgoalpos(agent.origin, 64);

    if(!isDefined(_id_7A21B65B17064C21))
      _id_7A21B65B17064C21 = 5;

    wait(_id_7A21B65B17064C21);
    agent.invulnerable = 0;
    agent _meth_E7D001043BD5012C();
    agent scripts\asm\asm_bb::bb_setanimScripted();

    if(agent.asmname != "cap_swamp_monster_ranged") {
      agent asmsetstate(agent.asmname, "animscripted");
      agent animmode("noclip");
      agent dontinterpolate();
      _id_DDC7222935C2FF2A = ["swamp_exposed_stand_spawn_01", "swamp_exposed_stand_spawn_02"];
      _id_A9F550936864F6E3 = randomint(_id_DDC7222935C2FF2A.size);
      animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", _id_DDC7222935C2FF2A[_id_A9F550936864F6E3]);
      xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
      agent aisetanim("animscripted", animindex);
      animlength = getanimlength(xanim);
      wait(animlength);
    }

    agent scripts\asm\asm_bb::bb_clearanimScripted();
  } else {
    agent _meth_E7D001043BD5012C();
    agent.invulnerable = 0;
  }

  agent.cannotmelee = 0;
  agent.ishidden = 0;

  if(istrue(_id_515E0AB8E3171486)) {
    agent.ignoreall = 0;
    agent.dontevershoot = 0;
    agent thread _id_8BFFC88F6869BD31();
  }

  agent.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
  _id_2EFE5529D8C9E37A(agent, undefined);
}

_id_8BFFC88F6869BD31() {
  _id_78122E18403A8DC4 = _id_1067A1F83551E4BB(self);

  if(_id_78122E18403A8DC4.size > 0) {
    _id_137CC0FFDF383E20 = sortbydistance(_id_78122E18403A8DC4, self.origin)[0];
    self getenemyinfo(_id_137CC0FFDF383E20);
    self.dontevershoot = 0;
    self setthreatsight(_id_137CC0FFDF383E20, 1.0);
    self setgoalentity(_id_137CC0FFDF383E20);
    self.favoriteenemy = _id_137CC0FFDF383E20;
  }
}

_id_B537B87E1E9D4B35() {
  level endon("game_ended");
  self endon("death");
  waitframe();
  _id_48F4848895A48C18 = scripts\engine\utility::spawn_tag_origin();
  _id_48F4848895A48C18 show();
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_swamp_monster_bubbles"), _id_48F4848895A48C18, "tag_origin");
  _id_48F4848895A48C18 show();
  level thread _id_6248A5356B863F48(self, _id_48F4848895A48C18);
  _id_37F33375888AC380 = self.origin[2];
  _id_8C3365E27E09E8A1 = self.origin;

  for(;;) {
    _id_01A1887690C8A5AE = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 100), 200, -200, (0, 0, 1));
    _id_01A1887690C8A5AE = _id_01A1887690C8A5AE + (0, 0, 50);

    if(abs(_id_01A1887690C8A5AE[2] - _id_37F33375888AC380) > 100 || !_id_AF89FB0FC9B8712E(self))
      _id_01A1887690C8A5AE = _id_8C3365E27E09E8A1;
    else
      _id_8C3365E27E09E8A1 = _id_01A1887690C8A5AE;

    waitframe();
    _id_48F4848895A48C18.origin = _id_01A1887690C8A5AE;
    waitframe();
    _id_48F4848895A48C18 show();
    waitframe();
    waitframe();
  }
}

_id_6248A5356B863F48(agent, _id_48F4848895A48C18) {
  level endon("game_ended");
  agent waittill("death");
  _id_48F4848895A48C18 delete();
}

_id_79712F2E14778875(origin) {
  level endon("game_ended");
  waitframe();
  vfx = scripts\engine\utility::spawn_tag_origin(origin, (0, 0, 0));
  vfx show();
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_swamp_monster_death"), vfx, "tag_origin");
  vfx show();
  wait 10;
  vfx delete();
}

_id_F7794629B4AC7829(_id_1CFCCAC3E5778BBB) {
  if(isDefined(_id_1CFCCAC3E5778BBB) && isvector(_id_1CFCCAC3E5778BBB)) {
    if(isDefined(self.origin) && isvector(self.origin)) {
      _id_AFE9E823907C4FDE = distance2d(_id_1CFCCAC3E5778BBB, self.origin);
      return _id_AFE9E823907C4FDE < 1200;
    }
  }

  return 0;
}

_id_B1D4BF18FFCBD3C6() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(_id_F7794629B4AC7829(player.origin)) {
        if(!istrue(player._id_CDF78370EC5496AF)) {
          _id_171F90B9C4C76D44 = undefined;

          if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
            _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);

          _id_A16496B2C1676F85(player, 1);
          player._id_CDF78370EC5496AF = 1;
        }

        continue;
      }

      if(!istrue(_id_F7794629B4AC7829(player.origin)))
        player._id_CDF78370EC5496AF = 0;
    }

    wait 1;
  }
}

_id_A16496B2C1676F85(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self._id_E2958F412A7425C0) || !isalive(self._id_E2958F412A7425C0) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  _id_AC4C51BF033F6323 = players;

  if(isDefined(self._id_E2958F412A7425C0.objidnum) && self._id_E2958F412A7425C0.objidnum > -1) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self._id_E2958F412A7425C0.objidnum, team);
    objective_state(self._id_E2958F412A7425C0.objidnum, "active");
    objective_position(self._id_E2958F412A7425C0.objidnum, (18565.5, 2661.25, 168.5));
  }

  _id_171F90B9C4C76D44 = undefined;
  _id_171F90B9C4C76D44 = "saba_marshland";

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC((18565.5, 2661.25, 168.5), 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_swampmonster_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  scripts\engine\utility::delaythread(1, _id_7AB5B649FA408138::_id_FE75A89529DD0FD0, _id_AC4C51BF033F6323, "mx_dmz_boss_swampmonster_approach", undefined, undefined, undefined);
  return 1;
}

_id_8E305DEB364559A9(origin) {
  level endon("game_ended");
  _id_068A826F7C6EECC3 = spawnStruct();
  _id_068A826F7C6EECC3.origin = origin;
  _id_068A826F7C6EECC3.curorigin = origin;
  _id_068A826F7C6EECC3.offset3d = (0, 0, 1500);
  _id_068A826F7C6EECC3 scripts\mp\gameobjects::requestid(1, 0, undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(_id_068A826F7C6EECC3.objidnum, "hud_icon_loot_swamp_tiara");
  objective_setbackground(_id_068A826F7C6EECC3.objidnum, 1);
  objective_state(_id_068A826F7C6EECC3.objidnum, "active");
  objective_position(_id_068A826F7C6EECC3.objidnum, origin + (0, 0, 100));
  level scripts\engine\utility::waittill_any_3("golden_tiara_given", "swampmonster_area_covered_by_circle", "swampmonster_killed");
  scripts\mp\objidpoolmanager::update_objective_state(_id_068A826F7C6EECC3.objidnum, "done");
  scripts\mp\gameobjects::releaseid(_id_068A826F7C6EECC3.objidnum);
}

_id_B516BF3480A4D791(player) {
  level endon("game_ended");
  _id_068A826F7C6EECC3 = spawnStruct();
  _id_068A826F7C6EECC3.origin = player.origin;
  _id_068A826F7C6EECC3.curorigin = player.origin;
  _id_068A826F7C6EECC3.offset3d = (0, 0, 1500);
  _id_068A826F7C6EECC3 scripts\mp\gameobjects::requestid(1, 0, undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(_id_068A826F7C6EECC3.objidnum, "hud_icon_loot_swamp_tiara");
  objective_setbackground(_id_068A826F7C6EECC3.objidnum, 1);
  objective_state(_id_068A826F7C6EECC3.objidnum, "active");
  objective_onentity(_id_068A826F7C6EECC3.objidnum, player);
  player scripts\engine\utility::waittill_any_4("player_deposited_tiara", "player_lost_tiara", "death_or_disconnect", "deaths_door_exit");
  scripts\mp\objidpoolmanager::update_objective_state(_id_068A826F7C6EECC3.objidnum, "done");
  scripts\mp\gameobjects::releaseid(_id_068A826F7C6EECC3.objidnum);
}

_id_D45A23AF31EFD881(_id_D83CA5E4517EB74E) {
  level endon("game_ended");
  wait 5;

  for(;;) {
    _id_940CE727AFAF46D1(_id_D83CA5E4517EB74E, 1);
    wait 5;
  }
}

_id_940CE727AFAF46D1(_id_D83CA5E4517EB74E, _id_6B4578883C4B6667) {
  level endon("game_ended");

  if(!isDefined(_id_6B4578883C4B6667))
    _id_6B4578883C4B6667 = 0;

  _id_B243306D75CC8719 = spawn("script_model", _id_D83CA5E4517EB74E);
  _id_B243306D75CC8719 setModel("mp_saba_pm_tag_transition_sphere");
  _id_B243306D75CC8719.angles = (0, 0, 0);
  wait 1;
  _id_B243306D75CC8719 setscriptablepartstate("transition_sphere", "rest");
  _id_B243306D75CC8719 forcenetfieldhighlod(1);
  _id_61ABD737E5E02526 = 0;
  level._id_C35012BF4D1D0320 = _id_B243306D75CC8719;

  if(!istrue(_id_6B4578883C4B6667))
    level waittill("swamp_monster_reset");
  else
    wait 2;

  _id_78122E18403A8DC4 = scripts\common\utility::playersinsphere(_id_D83CA5E4517EB74E, 600);
  _id_B243306D75CC8719 setscriptablepartstate("transition_sphere", "expand");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8]))
      _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8] visionsetnakedforplayer("mp_saba_pm_transition_sphere");
  }

  wait 5;
  _id_B243306D75CC8719 setscriptablepartstate("transition_sphere", "rest");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8]))
      _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8] visionsetnakedforplayer("mp_saba_pm");
  }

  _id_B243306D75CC8719 delete();
}

_id_22DDA6FABB7F5B90(agent, targetplayer) {
  level endon("game_ended");
  agent endon("death");
  agent.fnasm_handlenotetrack = ::_id_6BD7D1119138452D;
  _id_2EFE5529D8C9E37A(agent, "spit attack");
  agent._id_45C4FCCEB2F5FB1C = 1;
  agent setlookat(targetplayer.origin);
  _id_D5CE8B821ABA4929 = scripts\engine\math::_id_C5B0D1646EBC8EB3(agent.origin, targetplayer.origin, 5, agent.angles[1]);
  self orientmode("face point", targetplayer.origin);
  self setgoalpos(self.origin, 16);
  agent thread _id_C8EBF279C9E56152(agent);
  wait 1;
  _id_D1482A0C4F2A93FE(agent, targetplayer);
  agent waittill("cap_exit_completed");
  agent stoplookat();

  while(istrue(agent._id_6A7C53BFA7695667))
    waitframe();

  _id_2EFE5529D8C9E37A(agent, undefined);
}

_id_C8EBF279C9E56152(agent) {
  level endon("game_ended");
  agent endon("death");
  agent._id_6A7C53BFA7695667 = 1;
  agent _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_swamp_monster_ranged", "caps/common/cap_swamp_monster_ranged");
  agent waittill("cap_exit_completed");
  agent._id_6A7C53BFA7695667 = undefined;
}

_id_D1482A0C4F2A93FE(agent, target) {
  level endon("game_ended");
  agent endon("death");

  if(!isalive(agent) || !isalive(target) || !isDefined(target.origin) || !isDefined(agent.origin)) {
    return;
  }
  _id_3704EE4B52EEBCFA = _id_EB11CAB62F6F11C0(agent.origin + (0, 0, 50), target.origin + (0, 0, 50), target);
  thread _id_EE5EEBC449C0CB61(_id_3704EE4B52EEBCFA, agent, target, agent.origin + (0, 0, 50), target.origin + (0, 0, 50));
  return;
}

_id_EB11CAB62F6F11C0(start, end, targetplayer) {
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0);
  traceresults = scripts\engine\trace::ray_trace(start, end, [self], _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0)
    groundentity = traceresults["entity"];

  return traceresults;
}

_id_EE5EEBC449C0CB61(_id_3704EE4B52EEBCFA, agent, targetplayer, start, end) {
  level endon("game_ended");
  _id_44F8A3BCD427CBB3 = 1;

  if(isDefined(_id_3704EE4B52EEBCFA["fraction"]) && _id_3704EE4B52EEBCFA["fraction"] < 0.8) {
    if(isDefined(_id_3704EE4B52EEBCFA["hittype"]) && _id_3704EE4B52EEBCFA["hittype"] == "hittype_world" && isDefined(_id_3704EE4B52EEBCFA["position"])) {
      end = _id_3704EE4B52EEBCFA["position"];
      _id_44F8A3BCD427CBB3 = 0;
    }
  }

  _id_E57BE04A89770B1D = spawn("script_model", start);
  _id_E57BE04A89770B1D.angles = agent.angles;
  _id_E57BE04A89770B1D setModel("tag_origin");
  _id_E57BE04A89770B1D show();
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_swamp_monster_spit"), _id_E57BE04A89770B1D, "tag_origin");
  waitframe();
  _id_E57BE04A89770B1D show();
  dist = distance(start, end);
  _id_42F65B4B53C1F5D4 = dist / 900;
  _id_E57BE04A89770B1D moveTo(end, _id_42F65B4B53C1F5D4, 0);
  waitframe();
  _id_E57BE04A89770B1D show();
  wait(_id_42F65B4B53C1F5D4);
  _id_E57BE04A89770B1D delete();

  if(!istrue(_id_44F8A3BCD427CBB3)) {
    return;
  }
  damageradius = 200;

  if(isPlayer(targetplayer) && isalive(targetplayer) && distance2d(targetplayer.origin, end) <= damageradius && !_id_33ED3B60C624202E(agent, targetplayer, end, damageradius)) {
    targetplayer playSound("iw9_swmpmon_spit_impact");

    if(!_id_B3AAC6982108DF0B(agent, targetplayer)) {
      targetplayer thread _id_C3E5FAADD2C5E2EF();

      if(getdvarint("dvar_4CDC02B5CA6B10F9", 0) > 0) {
        inflictor = spawnStruct();
        inflictor.origin = targetplayer.origin;
        inflictor._id_D442547D75DFFD09 = spawnStruct();
        inflictor._id_D442547D75DFFD09._id_F2FB099C7B7B0A1F = 0.6;
        inflictor._id_D442547D75DFFD09._id_C5A6A953A99CEA74 = 0.6;
        targetplayer thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, agent);
      }
    }

    if(targetplayer _id_07C40FA80892A721::_id_AC266FC218266D08() > 0) {
      targetplayer _id_07C40FA80892A721::breakarmor();
      targetplayer _id_07C40FA80892A721::_id_8832743697109F0D();
    } else
      targetplayer dodamage(200, agent.origin, agent, undefined, "MOD_UNKNOWN");
  }
}

_id_3EED0B8EB85B1061(root, offset) {
  _id_5D6805EF12F78AE7 = root.origin;

  if(!isDefined(root.angles)) {
    if(!isPlayer(root))
      root setplayerangles((0, 0, 0));
    else
      root.angles = (0, 0, 0);
  }

  _id_616A6ECC2C2A4EB0 = anglestoup(root.angles);
  _id_66B10616A68F00F9 = anglestoleft(root.angles);
  _id_B842CC1147BDB416 = anglesToForward(root.angles);
  _id_F7CD955C75C5D1BF = offset[0] * _id_B842CC1147BDB416[0] + offset[1] * _id_66B10616A68F00F9[0] + offset[2] * _id_616A6ECC2C2A4EB0[0] + _id_5D6805EF12F78AE7[0];
  _id_F7CD945C75C5CF8C = offset[0] * _id_B842CC1147BDB416[1] + offset[1] * _id_66B10616A68F00F9[1] + offset[2] * _id_616A6ECC2C2A4EB0[1] + _id_5D6805EF12F78AE7[1];
  _id_F7CD975C75C5D625 = offset[0] * _id_B842CC1147BDB416[2] + offset[1] * _id_66B10616A68F00F9[2] + offset[2] * _id_616A6ECC2C2A4EB0[2] + _id_5D6805EF12F78AE7[2];
  _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_F7CD975C75C5D625);
  return _id_6C53D859D582A421;
}

_id_33ED3B60C624202E(agent, targetplayer, end, damageradius) {
  _id_641978C4AD3B22D4 = [];

  foreach(mine in level.mines) {
    if(isDefined(mine.equipmentref) && mine.equipmentref == "equip_tac_cover")
      _id_641978C4AD3B22D4[_id_641978C4AD3B22D4.size] = mine;
  }

  if(_id_641978C4AD3B22D4.size <= 0)
    return 0;

  _id_641978C4AD3B22D4 = sortbydistance(_id_641978C4AD3B22D4, end);
  _id_18D9FB42DCBC6006 = _id_641978C4AD3B22D4[0];

  if(distance2d(_id_18D9FB42DCBC6006.origin, end) <= damageradius) {
    if(distance2d(_id_18D9FB42DCBC6006.origin, agent.origin) < distance2d(end, agent.origin))
      return 1;
  }

  return 0;
}

_id_E2188A435D3F9D14(origin) {
  level endon("Game_ended");
  self._id_E2958F412A7425C0 _id_2FDEB8023287BE67::_id_8002B09B8348902C(self.origin, "hud_icon_minimap_haunting_swamp_monster_radius");
  objidnum = self._id_E2958F412A7425C0.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objidnum, "hud_icon_minimap_haunting_swamp_monster_radius");
  scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objidnum);
  objective_state(self._id_E2958F412A7425C0.objidnum, "active");
  objective_position(self._id_E2958F412A7425C0.objidnum, (18565.5, 2661.25, 168.5));
  objective_setbackground(objidnum, 1);
  objective_setdescription(self._id_E2958F412A7425C0.objidnum, &"MP_BR_INGAME/SWAMPMONSTER_DEFAULT");
  _func_865F9C5D005F9A08(self._id_E2958F412A7425C0.objidnum, 1);
  scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Boss_Swampmonster_Circle", origin, 4080, self);
  waitframe();
  scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  level waittill("swampmonster_killed");
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  objective_delete(objidnum);
}

_id_92F1AD2FED51CFFC(player) {
  player endon("disconnect");
  player notify("mummy_waitUntilCannotDeposit");
  player endon("mummy_waitUntilCannotDeposit");

  for(;;) {
    player scripts\engine\utility::waittill_any_4("death", "player_deposited_tiara", "ping_inv_drop_valuable", "quickDropCleanupCache");

    if(!_id_816D66A98589F173(player)) {
      player thread _id_AA494144A7273DED();
      return;
    }
  }
}

_id_AA494144A7273DED() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("boss_swampmonster_init");
  level._id_D0EB742034589336 disablescriptableplayeruse(self);
}

_id_C539B2018A507656(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");

  if(!isDefined(instance.uses))
    instance.uses = 0;

  instance.uses++;

  if(!_id_816D66A98589F173(player))
    player thread _id_FDF2BE75684E80AA(player);
  else {
    if(player _id_2D9D24F7C63AC143::_id_6F39F9916649AC48(36295, 1)) {
      level childthread _id_76EA263E1C6E7DC1(instance, player);
      level._id_3EADE5004C2D0F4D._id_3EB5BB6097F65DF0 = level._id_3EADE5004C2D0F4D._id_3EB5BB6097F65DF0 + 1;
      return;
    }

    logstring("Failed to use 36295 although it is in player's backpack");
  }
}

_id_FDF2BE75684E80AA(player) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  player scripts\mp\hud_message::showerrormessage("MISC_MESSAGES_MP/NO_TIARA_HELD");
}

_id_76EA263E1C6E7DC1(instance, player) {
  instance setscriptablepartstate("tiara_deposit", "unusable");
  instance setscriptablepartstate("tiara_effects", "tiara_deposited");
  level thread _id_B63A77C62DD13E51(instance.origin);

  if(isDefined(player)) {
    player notify("player_deposited_tiara");
    scripts\engine\utility::flag_set("golden_tiara_deposited");
    scripts\engine\utility::flag_clear("golden_tiara_given");
  }

  _id_171F90B9C4C76D44 = "stat_22A0E850ADD468A3";

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);

  player thread _id_2FDEB8023287BE67::_id_9483543F1B1BFA73("swampmonster", _id_171F90B9C4C76D44, player, level._id_019E7FA2B6A9A517, 1000);
}

_id_B63A77C62DD13E51(origin) {
  level endon("game_ended");
  level endon("swampmonster_killed");
  _id_A874A440CB322C1D = scripts\engine\utility::spawn_tag_origin(origin + (0, 0, 25), (0, 0, 0));
  _id_A874A440CB322C1D setModel("accessory_hlwn_swamp_tiara");
  _id_A874A440CB322C1D show();
  _id_A874A440CB322C1D thread _id_E8713E6C0B86EE36();
  _id_3572671D48FB48AB = 40;
  timetomove = 3;

  for(;;) {
    _id_A874A440CB322C1D moveTo(_id_A874A440CB322C1D.origin + (0, 0, _id_3572671D48FB48AB), timetomove);
    wait(timetomove);
    _id_A874A440CB322C1D moveTo(_id_A874A440CB322C1D.origin + (0, 0, _id_3572671D48FB48AB * -1), timetomove);
    wait(timetomove);
  }
}

_id_E8713E6C0B86EE36() {
  level endon("game_ended");
  level waittill("swampmonster_killed");
  wait 0.5;
  self delete();
}

_id_99D7A760418528F6() {
  level endon("game_ended");
  level endon("abort_watch_for_tiara_being_looted");
  level notify("single_watch_for_tiara_being_looted");
  level endon("single_watch_for_tiara_being_looted");

  for(;;) {
    level waittill("br_loot_item_added_to_backpack", lootid, pickup, player);

    if(lootid == 36295) {
      scripts\engine\utility::flag_set("golden_tiara_given");
      level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E + 1;
      level thread _id_B516BF3480A4D791(player);
      level thread _id_27DBD896AD5567DE(player);
      level thread _id_351D5080CC93D4CC(player);
      level thread _id_25D46B41446D22FA(player);
      level thread _id_05B1BEDF8AE3939E(player);
      player thread _id_1AC0356DFCA5EEDC();
      player thread _id_FB43A68DE8AED7B9();
      return;
    }
  }
}

_id_27DBD896AD5567DE(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_lost_tiara");

  for(;;) {
    player waittill("backpack_item_sold", lootid);

    if(lootid == 36295) {
      player notify("player_sold_tiara");
      scripts\engine\utility::flag_clear("golden_tiara_given");
      level thread _id_09F84ABBE3BF95B5();
      player notify("player_lost_tiara");
      return;
    }
  }
}

_id_05B1BEDF8AE3939E(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("player_lost_tiara");

  for(;;) {
    player waittill("item_added_to_cache", itemtype, _id_3793828403C6873E, lootid, _id_DFAB44D4D8D10B36);

    if(lootid == 36295) {
      scripts\engine\utility::flag_clear("golden_tiara_given");
      level thread _id_09F84ABBE3BF95B5();
      player notify("player_lost_tiara");
      return;
    }
  }
}

_id_25D46B41446D22FA(player) {
  level endon("game_ended");
  player endon("player_lost_tiara");
  player endon("death_or_disconnect");
  player waittill("deaths_door_exit");
  scripts\engine\utility::flag_clear("golden_tiara_given");
  level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E - 1;
  level thread _id_8E305DEB364559A9(player.origin);
  level thread _id_99D7A760418528F6();
  level thread _id_DE1C5821CF0A9ECB(player);
  self notify("player_lost_tiara");
}

_id_DE1C5821CF0A9ECB(player) {
  level endon("game_ended");
  player endon("disconnect");
  level endon("golden_tiara_given");
  player waittill("revivedAlive");
  level notify("abort_watch_for_tiara_being_looted");
  level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E + 1;
  level thread _id_B516BF3480A4D791(player);
  level thread _id_27DBD896AD5567DE(player);
  level thread _id_351D5080CC93D4CC(player);
  level thread _id_25D46B41446D22FA(player);
  level thread _id_05B1BEDF8AE3939E(player);
  player thread _id_1AC0356DFCA5EEDC();
  player thread _id_FB43A68DE8AED7B9();
  scripts\engine\utility::flag_set("golden_tiara_given");
}

_id_351D5080CC93D4CC(player) {
  level endon("game_ended");
  player endon("player_lost_tiara");
  player scripts\engine\utility::waittill_any_2("successful_exfil", "death_or_disconnect");
  scripts\engine\utility::flag_clear("golden_tiara_given");
  level thread _id_09F84ABBE3BF95B5();
  player notify("player_lost_tiara");
}

_id_09F84ABBE3BF95B5() {
  _id_B2B24BB9E0275FBA = (18565.5, 2661.25, 168.5);
  _id_920F4173513EB6B8 = "brloot_valuable_gold_swamp_tiara";
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_B2B24BB9E0275FBA, (0, 0, 0));
  item = _id_7E52B56769FA7774::spawnpickup(_id_920F4173513EB6B8, _id_CB4FAD49263E20C4, 1, 0, undefined, 0);
  level thread _id_8E305DEB364559A9(_id_B2B24BB9E0275FBA);
  level thread _id_99D7A760418528F6();
}

_id_FB43A68DE8AED7B9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("player_lost_tiara");
  self waittill("swapped_item_on_full_backpack", _id_76F4143215683892);

  if(_id_76F4143215683892 == "brloot_valuable_gold_swamp_tiara") {
    scripts\engine\utility::flag_clear("golden_tiara_given");
    level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E - 1;
    level thread _id_8E305DEB364559A9(self.origin);
    level thread _id_99D7A760418528F6();
    self notify("player_lost_tiara");
  }
}

_id_1AC0356DFCA5EEDC() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("player_lost_tiara");
  self waittill("dropped_backpack_item", _id_76F4143215683892);
  wait 0.5;

  if(_id_76F4143215683892 == "brloot_valuable_gold_swamp_tiara") {
    scripts\engine\utility::flag_clear("golden_tiara_given");
    level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E = level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E - 1;
    level thread _id_8E305DEB364559A9(self.origin);
    level thread _id_99D7A760418528F6();
    self notify("player_lost_tiara");
  }
}

_id_816D66A98589F173(player) {
  lootid = 36295;
  return player _id_2D9D24F7C63AC143::_id_D63A7299C6203BF9(lootid);
}

_id_C3E5FAADD2C5E2EF() {
  self endon("disconnect");

  if(!isalive(self) || istrue(self.inlaststand)) {
    return;
  }
  if(istrue(self._id_35DADE814E13D3CE)) {
    return;
  }
  if(!isDefined(self._id_07C250239954E901))
    self._id_07C250239954E901 = gettime();

  if(gettime() - self._id_07C250239954E901 > 2000) {
    if(_id_2C3C990BA58FA6F5::_id_5A758C8D306F92ED())
      _id_44B8991C2B01716A::_id_0F7FE427D574911C("ingame_haunting_slime", self, 1, 1);

    self._id_07C250239954E901 = gettime();
  }
}

_id_13CE59DA416A7BDF() {
  if(getdvarint("dvar_6F5B561700F553EC", 0) > 0)
    return 1;

  if(getdvarint("dvar_960D1721E9C4371A", 0) > 0)
    return 0;

  if(!_id_AF89FB0FC9B8712E(self) || istrue(self.ishidden))
    return 0;

  if(isDefined(self.enemy) && istrue(self.enemy.inlaststand))
    return 0;

  if(istrue(self._id_B0DE97037A47640C))
    return 1;
  else
    return 0;
}

_id_281E2D13A766756C(data) {
  if(isDefined(level._id_3EADE5004C2D0F4D))
    dlog_recordevent("dlog_event_haunting_bog", ["tiaras_placed", level._id_3EADE5004C2D0F4D._id_3EB5BB6097F65DF0, "tiaras_looted", level._id_3EADE5004C2D0F4D._id_2C9E598475FF1E3E, "executions_performed", level._id_3EADE5004C2D0F4D._id_92237C040F7537FE]);
}

_id_42A7F92B67241D66(_id_4DC42849FA9B701C) {
  level endon("game_ended");
  minplayerdist = 64;
  cooldown = 1;

  for(;;) {
    wait 1;

    foreach(position in _id_4DC42849FA9B701C) {
      _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(position, minplayerdist);

      if(isDefined(_id_78122E18403A8DC4) && _id_78122E18403A8DC4.size > 0) {
        _id_78122E18403A8DC4 = sortbydistance(_id_78122E18403A8DC4, position);
        nearbyplayer = _id_78122E18403A8DC4[0];

        if(!isDefined(nearbyplayer)) {
          continue;
        }
        if(distance(nearbyplayer.origin, position) <= minplayerdist)
          nearbyplayer setvelocity((0, 300, 50));
      }

      wait(cooldown);
    }
  }
}

_id_6BD7D1119138452D(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  _id_A18C779A48D376F8 = issubstr(_id_A234A65C378F3289, "footstep");
  _id_A816E83245CE18D2 = issubstr(_id_A234A65C378F3289, "melee_attack_sfx");

  if(_id_A18C779A48D376F8) {
    if(!self.ishidden)
      self playSound("iw9_swmpmon_step");
    else
      self playSound("iw9_swmpmon_bubble_slither");
  } else if(_id_A816E83245CE18D2) {
    self playSound("iw9_swmpmon_swipe");
    _id_4F57E90811AA8900::handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
  } else
    _id_4F57E90811AA8900::handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
}

_id_9AC3FCB0DF626212(agent) {
  agent endon("death");
  level waittill("br_ending_start");
  level._id_BF9426DBDF5FAA3B = 1;
  agent kill();
}

_id_84BE5BCD62C9A89F(agent) {
  _id_9D4D84F5EFD3E1D3 = self._id_B6656956EA57A8D8.nodes["swampmonster_submerge_dest"];
  _id_ED23975CB77E4020 = [];

  foreach(point in _id_9D4D84F5EFD3E1D3) {
    if(!istrue(point._id_950511821B7A2895))
      _id_ED23975CB77E4020[_id_ED23975CB77E4020.size] = point;
  }

  if(_id_ED23975CB77E4020.size <= 0)
    return _id_9D4D84F5EFD3E1D3;

  return _id_ED23975CB77E4020;
}

_id_D3610373DEACB91E(destination, waittime) {
  level endon("game_ended");
  wait(waittime);
  destination._id_950511821B7A2895 = 0;
}