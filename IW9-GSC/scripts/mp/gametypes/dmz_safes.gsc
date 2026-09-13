/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_safes.gsc
***********************************************/

_id_3E18070E9C4C07DB() {
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", ::_id_7C5EEFD0CBCE6520);
  script_model_anims();
  level._id_AC29BBE3A85FC5FA = spawnStruct();
  level._id_AC29BBE3A85FC5FA._id_EA60F992B9BED16C = getdvarint("dvar_6C64E4ED1B2661B0", 1);
  level._id_AC29BBE3A85FC5FA._id_A7208B64E85E109E = getdvarint("dvar_4AE9BE8B66F04D02", 0);
  level._id_AC29BBE3A85FC5FA._id_A4186F089A36D2F0 = getdvarint("dvar_20AD09D3184793F8", 2);
  level._id_AC29BBE3A85FC5FA.capturetime = getdvarint("dvar_40D76DD47F1FFBC5", 75);
  level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B = getdvarint("dvar_8FD341AD9E996D3A", 800);
  level._id_AC29BBE3A85FC5FA._id_01E2B29129476352 = getdvarint("dvar_E5C47808565489F1", 24000);
  level._id_AC29BBE3A85FC5FA._id_96DC0BDED5D12406 = level._id_AC29BBE3A85FC5FA._id_01E2B29129476352 * level._id_AC29BBE3A85FC5FA._id_01E2B29129476352;
  level._id_AC29BBE3A85FC5FA._id_3C1656D0DE196C00 = getdvarint("dvar_D0B1D795F6610EB5", 4);
  level._id_AC29BBE3A85FC5FA._id_3BF36CD0DDF354AA = getdvarint("dvar_D0D4C195F687260B", 5);
  level._id_AC29BBE3A85FC5FA._id_F73C5AA20A9C44D5 = getdvarint("dvar_0D8C8E09D145B3AA", 1);
  level._id_AC29BBE3A85FC5FA._id_83DA016BAFBAFEF6 = getdvarint("dvar_FE63EEF908E3EBD7", 1);

  if(!level._id_AC29BBE3A85FC5FA._id_EA60F992B9BED16C) {
    return;
  }
  while(!isDefined(level.struct_class_names) || !isDefined(level._id_41670C1C65F3D3CF) || _func_9A83377C98BCE82A("everybody") <= 0)
    waitframe();

  level._id_0E6BF347FCA0E305 = [];
  scripts\mp\flags::_id_1240434F4201AC9D("radiation_initialized");
  _id_AB2BE8088C0A7C90 = scripts\engine\utility::getStructArray("dmz_safe", "script_noteworthy");
  validlocations = [];

  foreach(_id_2A438B0332B8A143 in _id_AB2BE8088C0A7C90) {
    _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_2A438B0332B8A143.origin);

    if(!isDefined(_id_276AC5E84835EA87) && _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_2A438B0332B8A143._id_B205D90302DA2F07) && !_id_1174ABEDBEFE9ADA::_id_26879895DB23C779(_id_2A438B0332B8A143.origin)) {
      if(!isDefined(validlocations[_id_2A438B0332B8A143._id_B205D90302DA2F07]))
        validlocations[_id_2A438B0332B8A143._id_B205D90302DA2F07] = [];

      validlocations[_id_2A438B0332B8A143._id_B205D90302DA2F07][validlocations[_id_2A438B0332B8A143._id_B205D90302DA2F07].size] = _id_2A438B0332B8A143;
    }
  }

  foreach(_id_B205D90302DA2F07, _id_8B462903A1F84F9C in validlocations) {
    _id_FC617751F654A141 = min(randomintrange(level._id_AC29BBE3A85FC5FA._id_A7208B64E85E109E, level._id_AC29BBE3A85FC5FA._id_A4186F089A36D2F0 + 1), _id_8B462903A1F84F9C.size);
    _id_9577902B42FBD7F6 = scripts\engine\utility::array_randomize(_id_8B462903A1F84F9C);

    for(_id_0279B7817564584C = 0; _id_0279B7817564584C < _id_FC617751F654A141; _id_0279B7817564584C++)
      _id_D2441B457FA14419(_id_9577902B42FBD7F6[_id_0279B7817564584C]);
  }
}

_id_D2441B457FA14419(node, _id_CAA1515C4AD207EB) {
  if(!isDefined(node)) {
    return;
  }
  _id_B66875EAF0848550 = "dmz_safe";

  if(isDefined(level._id_1789643B227CF471))
    _id_B66875EAF0848550 = [[level._id_1789643B227CF471]](node);

  _id_32605DB102447D94 = spawnscriptable(_id_B66875EAF0848550, node.origin, node.angles);
  _id_32605DB102447D94.curorigin = _id_32605DB102447D94.origin;
  _id_32605DB102447D94.offset3d = (0, 0, 15);
  _id_32605DB102447D94 scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = _id_32605DB102447D94.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, _id_32605DB102447D94.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);

  if(level._id_AC29BBE3A85FC5FA._id_F73C5AA20A9C44D5)
    scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(objid);
  else
    scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);

  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
  _id_32605DB102447D94.node = node;
  node._id_32605DB102447D94 = _id_32605DB102447D94;
  _id_32605DB102447D94 setscriptablepartstate("safe", "usable_not_open");

  if(isDefined(_id_CAA1515C4AD207EB)) {
    _id_32605DB102447D94.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(getscriptablelootcachecontents(_id_32605DB102447D94));
    _id_32605DB102447D94.contents = _id_552B8E4EA5FF7DF1::_id_848E20CF1D6CAB8F(_id_32605DB102447D94.contents, 1, _id_CAA1515C4AD207EB);
    _id_32605DB102447D94.contents = scripts\engine\utility::array_randomize(_id_32605DB102447D94.contents);
  }

  _id_32605DB102447D94.trigger = spawn("trigger_radius", _id_32605DB102447D94.node.origin, 0, int(level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B), int(level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B));
  _id_32605DB102447D94.trigger scripts\engine\utility::trigger_off();
  _id_32605DB102447D94.capturetime = level._id_AC29BBE3A85FC5FA.capturetime;
  _id_32605DB102447D94._id_4E29111F80D17365 = [];

  if(level._id_AC29BBE3A85FC5FA._id_83DA016BAFBAFEF6)
    _id_32605DB102447D94 _id_A17B754D1372F83E(2);

  _id_32605DB102447D94 thread _id_474E2E9B4A997564(_id_32605DB102447D94.trigger, level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B);
  level._id_0E6BF347FCA0E305[level._id_0E6BF347FCA0E305.size] = _id_32605DB102447D94;
  _id_32605DB102447D94._id_CEB543956C7203E7 = ::_id_9618CC73546D253D;
  return _id_32605DB102447D94;
}

_id_9618CC73546D253D(_id_69E96A4CAA72D794, player) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(player)) {
    return;
  }
  if(_id_69E96A4CAA72D794 getscriptableparthasstate("safe", "open_usable"))
    _id_69E96A4CAA72D794 setscriptablepartstate("safe", "open_usable");
}

_id_20D58C7FB1074FC6(_id_FABF84450735DD93) {
  if(istrue(self._id_7BE8B486A10B3DE8)) {
    return;
  }
  self notify("safe_unlocked");
  self._id_7BE8B486A10B3DE8 = 1;
}

_id_7C5EEFD0CBCE6520(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(player.team)) {
    return;
  }
  if(isDefined(instance._id_AB0E150EDA2B5E13))
    self[[instance._id_AB0E150EDA2B5E13]](instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
  else {
    if(!_id_9AB4D7EA05385788(player)) {
      player scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
      return;
    }

    if(state == "usable_not_open") {
      instance setscriptablepartstate(part, "unusable");
      instance._id_B14A331BA425C286 = 0;
      instance thread _id_24765A7AABF0093E(player);
      instance _id_7F10E8E120314F4B(player, part);

      if(istrue(instance._id_B14A331BA425C286)) {
        instance.teams = [player.team];
        instance.trigger scripts\engine\utility::trigger_on();
        _id_5307834CD39B435C::_id_1C2BD1696D29935B(player.team, "dmz_mission_safe_opening");
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(player.team, "dmz_trap_drill", 0.5, "dmz_trap_drill_classic");
        scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "current");
        scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
        instance thread _id_A765843F381AD171();
        wait 1.0;
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_safe_defend_started", scripts\mp\utility\teams::getteamdata(player.team, "players"), instance.node._id_B205D90302DA2F07);
        return;
      }

      instance setscriptablepartstate(part, "usable_not_open");
      return;
      return;
    }

    if(state == "open_usable") {
      if(instance getscriptableparthasstate("safe", "unusable"))
        instance setscriptablepartstate("safe", "unusable");

      if(!isDefined(instance.contents)) {
        _id_9256A8C4667BAA69 = getdvarint("dvar_4C9B0494A5FFAC13", 2);
        items = _id_552B8E4EA5FF7DF1::_id_A76B46F057488CC0(instance, player.team, 23, _id_9256A8C4667BAA69);
        instance._id_46A3A8565AC0C17C = 4;
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
        instance _id_20D58C7FB1074FC6(player.team);
      } else
        instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
    }
  }
}

_id_A17B754D1372F83E(_id_6E6EE0D9F73A2999) {
  self.agents = [];
  aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range", undefined, 2);
  _id_F945F5534FFEDF42 = anglesToForward(self.angles) * 80;
  origin = getclosestpointonnavmesh(self.origin + _id_F945F5534FFEDF42);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, self.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 1);

  if(isDefined(agent)) {
    self.agents[0] = agent;
    thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 0);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6E6EE0D9F73A2999; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range");
    _id_50FBAC14DA970AE7 = randomfloatrange(144, 360);
    forward = anglesToForward(self.angles) * _id_50FBAC14DA970AE7;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / _id_6E6EE0D9F73A2999 * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = getclosestpointonnavmesh(self.origin + offset);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_CB88E484EB1A3A92, "high", "mission", "safe", undefined, undefined, undefined, self.node._id_B205D90302DA2F07, 0, undefined, 0);

    if(isDefined(agent)) {
      self.agents[self.agents.size] = agent;
      thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    }
  }
}

_id_A765843F381AD171() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.progress = 0;
  _id_A81135442EE1A731 = 0;
  _id_306804C6C85C36B0 = undefined;
  _id_94947EF251BF06D8 = 0;
  _id_F7D8DF490BD332C3 = 512;
  _id_7CC37D084D5E863C = 0;
  _id_90FB369A18926018 = [];

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(_id_306804C6C85C36B0))
        _id_306804C6C85C36B0 = [0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75];

      if(self._id_78122E18403A8DC4.size > 0) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
      }

      progress = self.progress / self.capturetime;
      _id_90FB369A18926018 = _id_075A1596E8181156(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        _id_67ABFC6A70AF2CCC();

        if(isDefined(level._id_67ABFC6A70AF2CCC))
          self[[level._id_67ABFC6A70AF2CCC]]();
      } else if(level._id_AC29BBE3A85FC5FA._id_83DA016BAFBAFEF6 && self._id_78122E18403A8DC4.size > 0 && isDefined(_id_306804C6C85C36B0[_id_94947EF251BF06D8]) && self.progress >= _id_306804C6C85C36B0[_id_94947EF251BF06D8]) {
        _id_94947EF251BF06D8++;
        _id_F7D8DF490BD332C3 = _id_F7D8DF490BD332C3 + 768;

        if(_id_F7D8DF490BD332C3 > 2816)
          _id_F7D8DF490BD332C3 = 2816;

        agents = _id_48814951E916AF89::_id_353FECD1549F5F42(self.origin, _id_F7D8DF490BD332C3, undefined, 3, undefined, 64, 128);

        if(isDefined(agents)) {
          self.agents = scripts\engine\utility::array_combine(self.agents, agents);
          _id_A81135442EE1A731 = _id_A81135442EE1A731 + agents.size;
        }

        if(!_id_7CC37D084D5E863C && _id_94947EF251BF06D8 == 1 && _id_A81135442EE1A731 < 4) {
          _id_DA117CA38EFAC51B = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node._id_B205D90302DA2F07, "Helicopter", 32, 64);

          if(isDefined(_id_DA117CA38EFAC51B) && _id_DA117CA38EFAC51B.size > 0) {
            _id_7CC37D084D5E863C = 1;
            self.agents = scripts\engine\utility::array_combine(self.agents, _id_DA117CA38EFAC51B);
          }
        }
      } else if(self._id_78122E18403A8DC4.size == 0 && _id_94947EF251BF06D8 > 0) {
        _id_94947EF251BF06D8 = 0;
        _id_F7D8DF490BD332C3 = 512;
      }
    }

    waitframe();
  }
}

_id_075A1596E8181156(_id_78122E18403A8DC4, _id_90FB369A18926018, progress) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.team) && !scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.objidnum, player, 1, 2, &"MP_DMZ_MISSIONS/OPENING_SAFE")) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_67ABFC6A70AF2CCC() {
  self.trigger delete();

  foreach(team in self.teams) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);

      if(!isDefined(player._id_35B94C88CC1CEA97))
        player._id_35B94C88CC1CEA97 = 0;

      player._id_35B94C88CC1CEA97++;
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C02C8C802F07C908");
    }

    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_safe_defend_unlocked", scripts\mp\utility\teams::getteamdata(team, "players"));
    _id_5307834CD39B435C::_id_1C2BD1696D29935B(team, "dmz_mission_safe_unlocked");
    _id_6A8EC730B2BFA844::_id_A9F8FA06A358585B(team, "safe", 1, self.node._id_B205D90302DA2F07, 1);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "", 1.5);
  }

  self.opened = 1;
  scripts\mp\gameobjects::releaseid();
  self setscriptablepartstate("safe", "opening");
}

_id_474E2E9B4A997564(trigger, radius) {
  level endon("game_ended");
  self endon("safe_unlocked");
  self._id_78122E18403A8DC4 = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, player);
    thread _id_D5720AE15E13FF51(trigger, player, radius);
  }
}

_id_D5720AE15E13FF51(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2)
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["safe_drill_player"] = #animtree;
  level.scr_anim["safe_drill_player"]["safedrill_enter"] = % iw9_dmz_safedrill_enter_sdr;
  level.scr_animname["safe_drill_player"]["safedrill_enter"] = "iw9_dmz_safedrill_enter_sdr";
  level.scr_eventanim["safe_drill_player"]["safedrill_enter"] = "safedrill_enter";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_enter"] = "iw9_dmz_safedrill_enter_sdr";
  level.scr_anim["safe_drill_player"]["safedrill_exit"] = % iw9_dmz_safedrill_exit_sdr;
  level.scr_animname["safe_drill_player"]["safedrill_exit"] = "iw9_dmz_safedrill_exit_sdr";
  level.scr_eventanim["safe_drill_player"]["safedrill_exit"] = "safedrill_exit";
  level.scr_viewmodelanim["safe_drill_player"]["safedrill_exit"] = "iw9_dmz_safedrill_exit_sdr";
}

_id_680B501EB7141C84(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("drilling", "allow_jump", 0);
    _id_3B64EB40368C1450::set("drilling", "gesture", 0);
    _id_3B64EB40368C1450::set("drilling", "melee", 0);
    _id_3B64EB40368C1450::set("drilling", "mantle", 0);
    _id_3B64EB40368C1450::set("drilling", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("drilling", "allow_movement", 0);
    _id_3B64EB40368C1450::set("drilling", "sprint", 0);
    _id_3B64EB40368C1450::set("drilling", "fire", 0);
    _id_3B64EB40368C1450::set("drilling", "reload", 0);
    _id_3B64EB40368C1450::set("drilling", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("drilling", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("drilling", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("drilling", "execution_victim", 0);
    _id_3B64EB40368C1450::set("drilling", "vehicle_use", 0);
    _id_3B64EB40368C1450::set("drilling", "supers", 0);
    self setclientomnvar("ui_br_inventory_disabled", 1);
    self _meth_35501B42058D4DE9();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("drilling");
    self setclientomnvar("ui_br_inventory_disabled", 0);
    self _meth_BB04491D50D9E43E();
  }
}

_id_7F10E8E120314F4B(player, part) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player _id_680B501EB7141C84(0);
  _id_BF8E5F003146AF44 = self._id_BF8E5F003146AF44;
  goalpos = self.origin + rotatevector((50.586, -6.262, 0), self.angles);
  forward = (0, 0, 0) - anglesToForward(self.angles);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  _id_8003B0D4F9FBEE0E = axistoangles(forward, right, up);

  if(!isDefined(_id_BF8E5F003146AF44)) {
    _id_A66FD1B124C32F51 = player getplayerangles();
    player.linktoent = player scripts\engine\utility::spawn_tag_origin(player.origin, player._id_A66FD1B124C32F51);
    player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
    player setstance("stand");
    _id_57C87883AE437750 = 0.5;
    player.linktoent moveTo(goalpos, _id_57C87883AE437750, 0.1, 0.1);
    player.linktoent rotateTo(_id_8003B0D4F9FBEE0E, _id_57C87883AE437750, 0.1, 0.1);
    player setstance("stand");
    _id_CD9982ADB17761A8 = gettime();
    player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
    _id_698CC218E4ADE75F = gettime();
    _id_218F64CB035D54BE = _id_57C87883AE437750 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0;
    waittime = max(0, _id_218F64CB035D54BE);
    wait(waittime);
  } else {
    player setstance("stand");
    player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  }

  player setOrigin(goalpos);
  player setplayerangles(_id_8003B0D4F9FBEE0E);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("safe_drill_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);

  if(isDefined(_id_BF8E5F003146AF44))
    player.player_rig linkTo(_id_BF8E5F003146AF44);

  self setscriptablepartstate(part, "unusable_intro_drilling");
  scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_enter");

  if(scripts\mp\utility\player::isreallyalive(player))
    scripts\mp\anim::anim_player_solo(player, player.player_rig, "safedrill_exit");

  if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player))
    player notify("interact_finished");

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(player)) {
    player notify("remove_rig");

    if(scripts\mp\utility\player::isreallyalive(player))
      player _id_680B501EB7141C84(1);
  }

  self._id_B14A331BA425C286 = 1;
}

_id_24765A7AABF0093E(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player _id_680B501EB7141C84(1);
}

_id_9967799221F8DD5E(team, origin) {
  wait 4;
  _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_55CF921EFA4CBD09(origin, 0, 0, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_safes_revealed", scripts\mp\utility\teams::getteamdata(team, "players"), _id_B205D90302DA2F07);
  _id_DFDD438871090D04 = sortbydistance(level._id_0E6BF347FCA0E305, origin);
  _id_26F0C58CF64AB613 = 0;
  _id_D4266812B99539B6 = _id_0B7A9CE0A2282B79::_id_E860C1BE7FF11F5B(team, 21);
  _id_6451409D2BFDDB20 = randomintrange(level._id_AC29BBE3A85FC5FA._id_3C1656D0DE196C00, level._id_AC29BBE3A85FC5FA._id_3BF36CD0DDF354AA + 1) + _id_D4266812B99539B6;

  foreach(_id_32605DB102447D94 in _id_DFDD438871090D04) {
    if(!istrue(_id_32605DB102447D94.opened) && !scripts\engine\utility::array_contains(_id_32605DB102447D94._id_4E29111F80D17365, team)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(_id_32605DB102447D94.objidnum, team);
      _id_32605DB102447D94._id_4E29111F80D17365[_id_32605DB102447D94._id_4E29111F80D17365.size] = team;
      _id_26F0C58CF64AB613++;

      if(_id_26F0C58CF64AB613 >= _id_6451409D2BFDDB20) {
        break;
      }
    }
  }
}

_id_9AB4D7EA05385788(player) {
  if(isDefined(player) && istrue(player._id_859654E0445A36D9))
    return 0;

  return 1;
}