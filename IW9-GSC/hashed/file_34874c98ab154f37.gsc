/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_34874c98ab154f37.gsc
***********************************************/

_id_918A46F20ADDF647() {
  scripts\engine\utility::flag_init("weapon_unholstered");
  scripts\engine\utility::flag_set("weapon_unholstered");

  if(isDefined(level._id_53025D9816FE4C04)) {
    return;
  }
  level._id_53025D9816FE4C04 = 1;
  level.agent_funcs["civilian"]["on_damaged"] = ::_id_9F22513C237365A7;
  level.agent_funcs["civilian"]["on_damaged_finished"] = ::_id_1EC45CFCAFE23FA1;
  level._id_D96498742CFC8242 = getdvarint("dvar_7F7F3E4F27363C65", 4);
  _id_94368422A679C17B = getdvarint("dvar_A199CE36EBA582C6", 1024);
  level._id_1D0F7527B2FFF2A2 = _id_94368422A679C17B * _id_94368422A679C17B;
  _id_94137A22A65363C5 = getdvarint("dvar_A1BCE036EBCBF214", 3072);
  level._id_1CEC5F27B2D97A88 = _id_94137A22A65363C5 * _id_94137A22A65363C5;
  _id_D9A5084E1BCC12D9();
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_2DCA426BA427FF57();
}

_id_D9A5084E1BCC12D9() {
  level._id_2489811B7F5F3DB3 = _id_BE00A6EA8C66D625();
  level._id_4F97AEEEDC49636A = _id_5C0BB5166C0BABE0(0);
  level._id_C0163A9EFDC36902 = _id_5C0BB5166C0BABE0(1);
  level._id_AB017D8436D7F265 = [];

  if(getdvarint("dvar_580B92E548153095", 1) == 1)
    level._id_AB017D8436D7F265 = _id_5D0C8CE44D66AF45();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("civSpawnLocs");

    foreach(loc in level._id_2489811B7F5F3DB3)
    _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(loc._id_B205D90302DA2F07, "civSpawnLocs", loc);

    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("civInteractionSpawnLocs");

    foreach(loc in level._id_AB017D8436D7F265)
    _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(loc._id_B205D90302DA2F07, "civInteractionSpawnLocs", loc);

    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("civFleeLocs_exterior");

    foreach(loc in level._id_4F97AEEEDC49636A)
    _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(loc._id_B205D90302DA2F07, "civFleeLocs_exterior", loc);

    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("civFleeLocs_interior");

    foreach(loc in level._id_C0163A9EFDC36902)
    _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(loc._id_B205D90302DA2F07, "civFleeLocs_interior", loc);
  }
}

_id_BE00A6EA8C66D625() {
  _id_B586C70B173DD02B = scripts\engine\utility::getStructArray("civilian_spawn_loc", "targetname");
  _id_B586C70B173DD02B = scripts\engine\utility::array_combine(scripts\engine\utility::getStructArray("civilian_spawn_loc", "script_noteworthy"), _id_B586C70B173DD02B);
  _id_B586C70B173DD02B = scripts\engine\utility::array_randomize(_id_B586C70B173DD02B);
  return _id_B586C70B173DD02B;
}

_id_5D0C8CE44D66AF45() {
  _id_B586C70B173DD02B = scripts\engine\utility::getStructArray("civilian_interaction_spawn_loc", "targetname");
  _id_B586C70B173DD02B = scripts\engine\utility::array_randomize(_id_B586C70B173DD02B);
  return _id_B586C70B173DD02B;
}

_id_5C0BB5166C0BABE0(interior) {
  _id_259B58D8D085F172 = [];
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("civilian_flee_loc", "targetname");
  _id_CF43C0073346699E = 5;
  _id_4A1830F604C82B9F = 0;

  foreach(struct in _id_9577902B42FBD7F6) {
    if(_id_4948CDF739393D2D::_id_2CDE636A73AEAD3D(struct.origin))
      struct._id_C79DCA57049C64D4 = 1;

    _id_438D0DD780C02F69 = isDefined(struct.script_noteworthy) && struct.script_noteworthy == "interior";

    if(istrue(interior)) {
      if(_id_438D0DD780C02F69)
        _id_259B58D8D085F172[_id_259B58D8D085F172.size] = struct;
    } else if(!_id_438D0DD780C02F69)
      _id_259B58D8D085F172[_id_259B58D8D085F172.size] = struct;

    _id_4A1830F604C82B9F++;

    if(_id_4A1830F604C82B9F == _id_CF43C0073346699E) {
      _id_4A1830F604C82B9F = 0;
      waitframe();
    }
  }

  return _id_259B58D8D085F172;
}

_id_2DCA426BA427FF57() {
  if(!isDefined(level._id_54CED3F63493D9DE))
    level._id_54CED3F63493D9DE = [];

  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    foreach(_id_FB1DEF007972B25A in level._id_AB017D8436D7F265) {
      ai = _id_5FAE75AF200A8054(_id_FB1DEF007972B25A, undefined, undefined, undefined, undefined, 1);
      level._id_54CED3F63493D9DE[level._id_54CED3F63493D9DE.size] = ai;
    }

    foreach(_id_FB1DEF007972B25A in level._id_2489811B7F5F3DB3) {
      ai = _id_5FAE75AF200A8054(_id_FB1DEF007972B25A, undefined, undefined, undefined, undefined, 1);
      level._id_54CED3F63493D9DE[level._id_54CED3F63493D9DE.size] = ai;
    }
  } else {
    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      foreach(_id_FB1DEF007972B25A in _id_B205D90302DA2F07["civInteractionSpawnLocs"]) {
        ai = _id_5FAE75AF200A8054(_id_FB1DEF007972B25A, undefined, _id_171F90B9C4C76D44, undefined, undefined, 1);
        level._id_54CED3F63493D9DE[level._id_54CED3F63493D9DE.size] = ai;
      }
    }

    _id_9A6ECBE35C09C506 = [];

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      if(scripts\engine\utility::array_contains(level._id_AB20B3A256911579, _id_171F90B9C4C76D44) || !isDefined(_id_B205D90302DA2F07["civSpawnLocs"])) {
        continue;
      }
      foreach(_id_FB1DEF007972B25A in _id_B205D90302DA2F07["civSpawnLocs"])
      _id_9A6ECBE35C09C506[_id_9A6ECBE35C09C506.size] = _id_FB1DEF007972B25A;
    }

    foreach(_id_FB1DEF007972B25A in scripts\engine\utility::array_randomize(_id_9A6ECBE35C09C506)) {
      ai = _id_5FAE75AF200A8054(_id_FB1DEF007972B25A, undefined, _id_FB1DEF007972B25A._id_B205D90302DA2F07, undefined, undefined, 1);
      level._id_54CED3F63493D9DE[level._id_54CED3F63493D9DE.size] = ai;
    }
  }
}

_id_5FAE75AF200A8054(struct, path, _id_171F90B9C4C76D44, _id_0DE371E340BD266D, _id_9B2697384ED3425E, _id_E195245ABF56681B, _id_46C6E189D91AA34C, _id_81FEE161ED3B0CCD) {
  _id_5B1D6F1E7985DC04 = 0;
  _id_DCF5E15C58C4152A = scripts\engine\utility::ter_op(_id_5B1D6F1E7985DC04, "civilian_mp_dmz_male", "civilian_mp_dmz_female");
  _id_D2664652FB0CB884 = "civilian";

  if(isDefined(_id_46C6E189D91AA34C))
    _id_D2664652FB0CB884 = _id_46C6E189D91AA34C;

  priority = "filler";

  if(isDefined(_id_81FEE161ED3B0CCD))
    priority = _id_81FEE161ED3B0CCD;

  ai = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_DCF5E15C58C4152A, getclosestpointonnavmesh(struct.origin), struct.angles, priority, _id_D2664652FB0CB884, undefined, "civs", "civilian", undefined, _id_171F90B9C4C76D44);

  if(!isDefined(ai)) {
    return;
  }
  ai.ignoreme = 1;
  ai.health = 1;
  ai.maxhealth = 1;
  ai.combatmode = "no_cover";
  ai.gender = scripts\engine\utility::ter_op(_id_5B1D6F1E7985DC04, "male", "female");

  if(istrue(_id_E195245ABF56681B)) {
    ai.goalradius = 1536;
    ai _meth_0236BB8DE012BBAE();
    return ai;
  }

  ai scripts\asm\asm_bb::bb_setcivilianstate("casual");
  waitframe();
  ai thread _id_2824BC477DCB2798();

  if(isDefined(path)) {
    ai forceteleport(path.origin, path.angles);
    ai setgoalpos(path.origin);
  }

  return ai;
}

_id_32DE403142A7242E(agent, spawnorigin) {
  agent endon("death");
  interval = 0.05;

  for(;;) {
    thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, interval, (1, 0, 0));
    thread scripts\mp\utility\debug::drawsphere(spawnorigin, 32, interval, (0, 1, 0));
    thread scripts\cp_mp\utility\debug_utility::drawline(spawnorigin, agent.origin, interval, (0, 0, 1));
    wait(interval);
  }
}

_id_B9C9324BE6322DDF(text, offset, tag, duration) {}

_id_A1206D7251DBA753() {
  self endon("death");
  self notify("civ_sayDialogue");
  self endon("civ_sayDialogue");

  if(!isDefined(level._id_FA6EF45D45ED4496)) {
    aliases = [];
    aliases[aliases.size] = "dx_vom_cvm1_civ_ambush_civ_10";
    aliases[aliases.size] = "dx_vom_cvm1_civ_ambush_civ_20";
    aliases[aliases.size] = "dx_vom_cvm1_civ_ambush_civ_30";
    aliases[aliases.size] = "dx_vom_cvm1_intro_clearance_150";
    aliases[aliases.size] = "dx_vom_cvm2_alley_triage_40";
    aliases[aliases.size] = "dx_vom_cvm1_alley_triage_50";
    aliases[aliases.size] = "dx_vom_cvm2_alley_triage_60";
    aliases[aliases.size] = "dx_vom_cvm1_poppies_start_fields_120";
    aliases[aliases.size] = "dx_vom_cvm1_poppies_start_fields_300";
    aliases[aliases.size] = "dx_vom_aqm2_2nd_floor_hallway_22";
    aliases[aliases.size] = "dx_vom_aqm3_2nd_floor_hallway_23";
    aliases[aliases.size] = "dx_vom_aqm2_2nd_floor_hallway_24";
    aliases[aliases.size] = "dx_vom_cvm2_reception_bulletproof_90";
    aliases[aliases.size] = "dx_vom_cvm1_reception_bulletproof_100";
    aliases[aliases.size] = "dx_vom_cvm2_reception_bulletproof_103";
    aliases[aliases.size] = "dx_vom_cvm2_breach_offices_140";
    aliases[aliases.size] = "dx_vom_cvm1_alley_moving_120";
    aliases[aliases.size] = "dx_vom_cvm1_market_rations_20";
    aliases[aliases.size] = "dx_vom_cvm1_infil_thief_20";
    aliases[aliases.size] = "dx_vom_cvm1_infil_thief_110";
    level._id_FA6EF45D45ED4496 = scripts\engine\utility::create_deck(aliases, 1, 1);
    aliases = [];
    aliases[aliases.size] = "dx_vom_ucm4_right_underground_rescue_40";
    aliases[aliases.size] = "dx_vom_rcm2_entrance_civs_30";
    aliases[aliases.size] = "dx_vom_rcm3_entrance_civs_40";
    level._id_E80E768C655A9BED = scripts\engine\utility::create_deck(aliases, 0, 0);
  }

  wait(randomfloatrange(0.5, 2));

  if(isDefined(self._id_6542BCC8942334DA) && gettime() < self._id_6542BCC8942334DA) {
    return;
  }
  _id_8E399D0D86DB13ED = 0;

  if(scripts\engine\utility::_id_51D76700600CEBE3(75) && self pathdisttogoal() > 512) {
    alias = level._id_E80E768C655A9BED scripts\engine\utility::deck_draw();
    thread _id_50AC20187F26A0DC();
  } else {
    alias = level._id_FA6EF45D45ED4496 scripts\engine\utility::deck_draw();
    _id_8E399D0D86DB13ED = 1;
  }

  self playSound(alias, undefined, self);
  _id_40CDBACDA5CCA105 = lookupsoundlength(alias, 1);
  self._id_6542BCC8942334DA = gettime() + _id_40CDBACDA5CCA105 + 3000;
  _id_3FC6453968C77B59 = getaiarrayinradius(self.origin, 300, "team_five");

  foreach(_id_A5638903B40C5A21 in _id_3FC6453968C77B59) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(30))
      _id_A5638903B40C5A21._id_6542BCC8942334DA = self._id_6542BCC8942334DA;
  }

  if(!_id_8E399D0D86DB13ED) {
    return;
  }
  wait(_id_40CDBACDA5CCA105 / 1000);
  wait(randomfloatrange(0.5, 2));

  if(self pathdisttogoal() < 512) {
    return;
  }
  alias = level._id_E80E768C655A9BED scripts\engine\utility::deck_draw();
  thread _id_50AC20187F26A0DC();
  self playSound(alias, undefined, self);
  _id_40CDBACDA5CCA105 = lookupsoundlength(alias, 1);
  self._id_6542BCC8942334DA = gettime() + _id_40CDBACDA5CCA105 + 3000;
}

_id_9F22513C237365A7(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!_id_24FBEDBA9A7A1EF4::_id_84A1AEC445B03580(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
    return;
  }
  scripts\mp\mp_agent::default_on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_1EC45CFCAFE23FA1(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D) {
  self stopsounds();
  thread _id_38C7182B89AF7000(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D);
}

_id_38C7182B89AF7000(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D) {
  self endon("death");
  waitframe();
  scripts\mp\mp_agent::default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D);
}

_id_50AC20187F26A0DC() {
  self endon("death");
  self notify("stopSoundsIfNotMoving");
  self endon("stopSoundsIfNotMoving");

  for(;;) {
    wait 0.2;

    if(!self codemoverequested()) {
      alias = level._id_FA6EF45D45ED4496 scripts\engine\utility::deck_draw();
      self playSound(alias, undefined, self);
      _id_40CDBACDA5CCA105 = lookupsoundlength(alias, 1);
      self._id_6542BCC8942334DA = gettime() + _id_40CDBACDA5CCA105 + 3000;
      return;
    }
  }
}

_id_8AA10423B6476FE0() {
  self waittill("death");
  [[level._id_BBD8A18655D9495B]](self);
}

_id_016C1A389394A217() {
  self endon("death");
  self endon("goal");
  contents = scripts\engine\trace::create_solid_ai_contents(1);

  for(;;) {
    _id_44736CEE8AFAD49B = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(self.origin, 60, 20);

    foreach(door in _id_44736CEE8AFAD49B) {
      _id_F85F26257033C0F2 = anglesToForward(door.angles);
      doorcenter = door.origin + _id_F85F26257033C0F2 * 30 + (0, 0, 40);
      _id_98AD6B267EB7431B = door.origin + _id_F85F26257033C0F2 * 30;
      _id_FC2967588AA0E4D7 = anglesToForward(self.angles);

      if(isDefined(door._id_D2214BE976945FDE) && gettime() < door._id_D2214BE976945FDE + 1000) {
        continue;
      }
      _id_3FA343010C76893C = scripts\engine\trace::ray_trace(self getEye(), doorcenter, self, contents);

      if(_id_3FA343010C76893C["fraction"] < 0.7) {
        continue;
      }
      if(vectordot(_id_FC2967588AA0E4D7, vectorNormalize(_id_98AD6B267EB7431B - self.origin)) < 0.6) {
        continue;
      }
      right = anglestoright(door.angles);
      normal = vectorNormalize(self.origin - door.origin);
      dot = vectordot(right, normal);
      _id_DA2D1A382C620732 = dot > 0;

      if(istrue(_id_DA2D1A382C620732))
        _id_E470D9AF31C8E97C = "bash_left_90";
      else
        _id_E470D9AF31C8E97C = "bash_right_90";

      currentstate = door getscriptablepartstate("door");

      if(currentstate != _id_E470D9AF31C8E97C) {
        door setscriptablepartstate("door", _id_E470D9AF31C8E97C, 0);
        door._id_D2214BE976945FDE = gettime();
      }
    }

    waitframe();
  }
}

_id_2824BC477DCB2798() {
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", attacker, dist, position);

    if(istrue(self._id_950C1AB89C9C4E2A)) {
      continue;
    }
    event = spawnStruct();
    event._id_4D337BD758CD7286 = "civilian";
    event._id_655FF8A25D65DF4B = attacker;
    event.position = scripts\engine\utility::ter_op(isDefined(position), position, self.origin);
    event.time = gettime();
    event.type = "gunshot";
    self[[level._id_F29702DDC09D1002]](event);
  }
}

_id_656EADA20254E131() {
  self endon("death");
  self notify("fleeFromPlayerProximity");
  self endon("fleeFromPlayerProximity");
  _id_2E0D80DAAAB7F018 = getdvarint("scr_dmz_civ_player_flee_dist", 768);
  _id_B8C1899ADC1A8760 = _id_2E0D80DAAAB7F018 * _id_2E0D80DAAAB7F018;

  for(;;) {
    if(!istrue(self._id_950C1AB89C9C4E2A)) {
      closestplayer = [[level._id_0FFA48A6A79A7224]](self.origin);

      if(isDefined(closestplayer)) {
        _id_3C6C89C6E3183FE4 = distancesquared(closestplayer.origin, self.origin);

        if(_id_3C6C89C6E3183FE4 < _id_B8C1899ADC1A8760) {
          self._id_DD25F55F775FA187 = closestplayer.origin;
          break;
        }
      }
    }

    wait 0.25;
  }

  self._id_7AFD86C1AF40885B = "panicked";
}

_id_414E92DE6D8A19AD() {
  level _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_2D6FA894E261F129);
  level._id_329506C1D6753E87 = getdvarint("dvar_1ED01A3AC2E46A7C", 3);
  level._id_80038FC2CAC83ED1 = getdvarint("dvar_4E05813BA09E44E2", 5);
  level._id_0DCFD97311EE632B = getdvarint("dvar_4C5A379275261110", 10);
  level._id_68CECB730A9D965B = getdvarint("dvar_50C71A1B6ECF22C7", 15);
  level._id_FDC5C47200603515 = getdvarint("dvar_9E35A31C63222311", 10);
  level._id_A6E41F71A686369F = getdvarint("dvar_F4083999D389CA6B", 3);
}

_id_2D6FA894E261F129(agent, _id_6181DE250AFA5BB6) {
  if(isDefined(agent.unittype) && agent.unittype == "civilian" && isDefined(_id_6181DE250AFA5BB6) && _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "category") != "mission") {
    player = undefined;

    if(isPlayer(_id_6181DE250AFA5BB6))
      player = _id_6181DE250AFA5BB6;
    else if(_id_6181DE250AFA5BB6 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(_id_6181DE250AFA5BB6.owners) && isDefined(_id_6181DE250AFA5BB6.owners[0]))
      player = _id_6181DE250AFA5BB6.owners[0];

    if(isDefined(player)) {
      if(!isDefined(player._id_18CCF3F412948903))
        player._id_18CCF3F412948903 = 0;

      player._id_18CCF3F412948903++;
      player _id_DA0C4E190EE1DA89();
    }
  }
}

_id_DA0C4E190EE1DA89() {
  _id_84E6118FF48D6FED = scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A, 1);
  _id_14B4A525D116FC52 = scripts\engine\utility::array_remove(_id_84E6118FF48D6FED, self);

  if(self._id_18CCF3F412948903 == 1)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_civ_kill_frst_warning", _id_84E6118FF48D6FED);
  else if(self._id_18CCF3F412948903 == 2)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_civ_kill_second_warning", _id_84E6118FF48D6FED);
  else if(self._id_18CCF3F412948903 == level._id_329506C1D6753E87) {
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("player_civ_kill_third_warning", [self]);
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_civ_bounty", _id_14B4A525D116FC52);
    level _id_6231F251A918F35F(self);
    self.objpingdelay = level._id_68CECB730A9D965B;
    _id_E4A099B25F255D6C();
    showassassinationtargethud(self, 3);
    level thread _id_1214AAD9FB9087CC(self);

    foreach(team in level.teamnamelist) {
      if(team != self.team) {
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_them", scripts\mp\utility\teams::getteamdata(team, "players"));
        continue;
      }

      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_us", scripts\mp\utility\teams::getteamdata(team, "players"));
    }
  } else if(self._id_18CCF3F412948903 == level._id_80038FC2CAC83ED1) {
    self.objpingdelay = level._id_FDC5C47200603515;
    showassassinationtargethud(self, 4);
    self iprintlnbold("WARNING: Your bounty has increased!");

    foreach(team in level.teamnamelist) {
      if(team != self.team) {
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_them_inc", scripts\mp\utility\teams::getteamdata(team, "players"));
        continue;
      }

      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_us_inc", scripts\mp\utility\teams::getteamdata(team, "players"));
    }
  } else if(self._id_18CCF3F412948903 == level._id_0DCFD97311EE632B) {
    self.objpingdelay = level._id_A6E41F71A686369F;
    showassassinationtargethud(self, 5);
    self iprintlnbold("WARNING: Maximum bounty has been placed on you!");

    foreach(team in level.teamnamelist) {
      if(team != self.team) {
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_them_inc", scripts\mp\utility\teams::getteamdata(team, "players"));
        continue;
      }

      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_us_inc", scripts\mp\utility\teams::getteamdata(team, "players"));
    }
  }
}

_id_E4A099B25F255D6C() {
  self._id_5F6D702BC79161F8 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  objid = self._id_5F6D702BC79161F8;
  objective_setlabel(objid, "MP_INGAME_ONLY/OBJ_TARGET_CAPS");
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 90);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_bounty");
  objective_setplayintro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 2);
  scripts\mp\objidpoolmanager::update_objective_position(objid, self.origin + (0, 0, 100));
  scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
  scripts\mp\objidpoolmanager::update_objective_onentity(objid, self);

  foreach(team in level.teamnamelist) {
    if(team != self.team)
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(objid, team);
  }

  thread updatetargetlocation();
}

updatetargetlocation() {
  level endon("game_ended");
  self endon("task_endon_trigger_removed");
  objective_setpings(self._id_5F6D702BC79161F8, 1);

  for(;;) {
    if(isDefined(self) && isDefined(self.origin)) {
      scripts\mp\objidpoolmanager::update_objective_position(self._id_5F6D702BC79161F8, self.origin + (0, 0, 100));
      objective_ping(self._id_5F6D702BC79161F8);
    } else
      break;

    wait(self.objpingdelay);
  }
}

_id_E2A9A038FA6830D5(dialog) {
  if(soundexists(dialog))
    self queuedialogforplayer(dialog, dialog, 2);
}

_id_6231F251A918F35F(_id_58396A92B07F08B3) {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(_id_58396A92B07F08B3.team) && _id_58396A92B07F08B3.team == _id_F90358454413407F) {
      foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players")) {
        if(player != _id_58396A92B07F08B3)
          player queuedialogforplayer("dx_bra_uktl_mission_mission_ass_hunted", "dx_bra_uktl_mission_mission_ass_hunted", 2);
      }

      break;
    }
  }
}

_id_1214AAD9FB9087CC(_id_58396A92B07F08B3) {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(isDefined(_id_58396A92B07F08B3.team) && _id_58396A92B07F08B3.team != _id_F90358454413407F) {
      foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players"))
      player queuedialogforplayer("dx_mpa_uktl_enmy_kills_multi_civs_bounty", "dx_mpa_uktl_enmy_kills_multi_civs_bounty", 2);
    }
  }
}

updateassassinationdataomnvar(targetplayer, threatlevel) {
  if(isDefined(self.aq_targethudenabled) && self.aq_targethudenabled)
    entitynumber = targetplayer getentitynumber();
  else
    entitynumber = -1;

  entitynumber = targetplayer getentitynumber();
  entitynumber = entitynumber + 1;
  value = threatlevel << 8 | entitynumber;
  self setclientomnvar("ui_br_assassination_target", value);
}

updateassassinationthreatlevel(targetteam) {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players"))
  player updateassassinationdataomnvar(self.targetplayer, self.threat_level);
}

showassassinationtargethud(targetplayer, threatlevel) {
  self.aq_targethudenabled = 1;
  updateassassinationdataomnvar(targetplayer, threatlevel);
}

hideassassinationtargethud() {
  self.aq_targethudenabled = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

_id_A5D597201278C71C(victim) {
  attacker = self;

  if(isDefined(attacker) && !isagent(attacker) && isDefined(attacker.team) && attacker.team != victim.team) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_enemy_down", attacker.team, 1);

    if(isDefined(level._id_52781BE0B4E8A959))
      level[[level._id_52781BE0B4E8A959]](attacker.team);

    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_civ_bounty_complete", scripts\mp\utility\teams::getteamdata(attacker.team, "players"));

    foreach(player in scripts\mp\utility\teams::getteamdata(attacker.team, "players"))
    player _id_6AFF3948CF4CCA03::playerplunderpickup(getdvarint("dvar_4F221C528DDDEE47", 100), undefined, 1);

    victim setclientomnvar("ui_br_assassination_target", 0);
    scripts\mp\objidpoolmanager::returnobjectiveid(victim._id_5F6D702BC79161F8);
  }
}

_id_5E94057030AE86C4(_id_438D0DD780C02F69, _id_171F90B9C4C76D44) {
  if(!_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(istrue(_id_438D0DD780C02F69))
      return level._id_C0163A9EFDC36902;
    else
      return level._id_4F97AEEEDC49636A;
  } else if(istrue(_id_438D0DD780C02F69))
    return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["civFleeLocs_interior"];
  else
    return level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["civFleeLocs_exterior"];
}