/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\teamrevive.gsc
***********************************************/

init() {
  level.laststand = scripts\mp\tweakables::gettweakablevalue("player", "laststand");
  setomnvar("ui_last_stand_type", level.laststand);

  if(!scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  level._id_1A52552BE0B92C9B = getdvarint("dvar_CAAA48448A7F3558", 0) == 1;
  level._id_76F92A587185677C = getdvarint("dvar_AA7DBB144027705F", 0) == 1;
  level.onteamchangedeath = ::onteamchangedeath;
  level.revivetriggers = [];
  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
  level.numrevives = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numRevives"), 0);
  level.disablespawncamera = 1;
  level._id_B961DD6C88E9A008 = getdvarint("dvar_E6C178413AF5A02E", 1) == 1;
  level._id_5ECF502DC8C87BBB = getdvarfloat("dvar_D3C774C21F7F21F7", 30);

  if(isusingmatchrulesdata()) {
    setdynamicdvar("dvar_A8543004B97470B5", getmatchrulesdata("commonOption", "teamReviveHealth"));
    setdynamicdvar("dvar_AF65C14C83826CFA", getmatchrulesdata("commonOption", "teamReviveTime"));
    setdynamicdvar("dvar_E47F7F1502E4292E", getmatchrulesdata("commonOption", "teamReviveTimeout"));
  } else {
    scripts\mp\utility\game::_id_65C4CAE95D0C833B(40);
    scripts\mp\utility\game::_id_C2BD90FF953A0CE4(3);
    scripts\mp\utility\game::_id_2597B9CD72447CB6(0);
  }

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_DF4A3CFF3137D441);

  level._id_EF6D59592ED101F3 = scripts\mp\utility\dvars::getoverridedvarintexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_teamReviveHealth"), "dvar_A8543004B97470B5");

  if(level._id_EF6D59592ED101F3 > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth"))
    level._id_EF6D59592ED101F3 = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

  level._id_04B91C5DB6B16C58 = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_teamReviveTime"), "dvar_AF65C14C83826CFA");
  level._id_D25ED114F4EC6F9C = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_teamReviveTimeout"), "dvar_E47F7F1502E4292E");

  if(_id_68AC13D2D66B844A()) {
    level._id_C7D5CDE0CEA88517 = 0;
    level._id_36A249F46F4464A8 = 0;
    setomnvar("ui_num_reviving_allies", 0);
    setomnvar("ui_num_reviving_axis", 0);
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("cyber_revive_icon", ::_id_301C4EC489F9BD39);
  level thread onplayerconnect();
}

_id_DF4A3CFF3137D441(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player thread _id_3DBFC03B90783F06();
  _id_3A46F9EC9762DAD9(_id_8A04AA0E0755E7E3);
}

_id_3A46F9EC9762DAD9(team) {
  foreach(_id_B25CA392892D7A80 in level.revivetriggers) {
    if(_id_B25CA392892D7A80.owner.team == team)
      _id_B25CA392892D7A80 makereviveteamusable(team);
  }
}

_id_3DBFC03B90783F06() {
  self._id_A23F35F8460D8857 = 1;
  waitframe();
  waittillframeend;

  if(isDefined(self))
    self._id_A23F35F8460D8857 = undefined;
}

_id_692CDF5F87A8667B() {
  return "cyber_revive_icon";
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player.numrevives = level.numrevives;
  }
}

onteamchangedeath(player) {}

_id_EA0F473582299981(ref, _id_CE174178F5680DFC) {
  if(!scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  if(!isDefined(level._id_CD9C5304B9D93C1F))
    level._id_CD9C5304B9D93C1F = [];

  if(!isDefined(level._id_CD9C5304B9D93C1F[ref]))
    level._id_CD9C5304B9D93C1F[ref] = _id_CE174178F5680DFC;
}

_id_C1E0BE976B081620(ref) {
  if(!scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  if(isDefined(level._id_423C8D4F74C71873) && isDefined(level._id_423C8D4F74C71873[ref]))
    level._id_423C8D4F74C71873[ref] = undefined;
}

_id_4880FB2B58A49F48(icon, victim, team) {
  if(!isDefined(level._id_CD9C5304B9D93C1F)) {
    return;
  }
  foreach(_id_46260B6EEE9C6E62 in level._id_CD9C5304B9D93C1F)
  thread[[_id_46260B6EEE9C6E62]](icon, victim, team);
}

_id_5343ECB486B66BF1(ref, _id_CE174178F5680DFC) {
  if(!isDefined(level._id_423C8D4F74C71873))
    level._id_423C8D4F74C71873 = [];

  if(!isDefined(level._id_423C8D4F74C71873[ref]))
    level._id_423C8D4F74C71873[ref] = _id_CE174178F5680DFC;
}

_id_34727D1CDC47572E(ref) {
  if(isDefined(level._id_423C8D4F74C71873) && isDefined(level._id_423C8D4F74C71873[ref]))
    level._id_423C8D4F74C71873[ref] = undefined;
}

updaterevivetriggerspawnposition() {
  if(istrue(level._id_B961DD6C88E9A008)) {
    return;
  }
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    self waittill("spawned_player");
  else if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    if(scripts\mp\flags::gameflag("infil_will_run")) {
      level scripts\engine\utility::waittill_any_3("prematch_done", "start_mode_setup", "infil_started");
      time = int(max(level.prematchperiodend - 5, 5));
      wait(time);
    } else
      level scripts\engine\utility::waittill_any_3("prematch_done", "start_mode_setup", "match_start_real_countdown");
  }

  while(scripts\mp\utility\player::isreallyalive(self) || istrue(self._id_C4C8B91E0B16AA5E)) {
    if(isvalidrevivetriggerspawnposition())
      setvalidreviveposition();

    wait 1;
  }
}

setvalidreviveposition() {
  if(istrue(level._id_B961DD6C88E9A008)) {
    return;
  }
  revivepos = self.origin;
  _id_E6874E9B453D7005 = undefined;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    revivepos = self.origin;
  else if(isbot(self)) {
    _id_E6874E9B453D7005 = self getnearestnode();

    if(!isDefined(_id_E6874E9B453D7005))
      revivepos = self.origin;
    else
      revivepos = _id_E6874E9B453D7005.origin;
  } else {
    _id_E6874E9B453D7005 = self getnearestnode();

    if(!isDefined(_id_E6874E9B453D7005))
      _id_E6874E9B453D7005 = self.origin;
    else
      _id_E6874E9B453D7005 = _id_E6874E9B453D7005.origin;
  }

  if(!isDefined(self.revivetriggerspawnposition))
    self.prevrevivepos = revivepos;
  else
    self.prevrevivepos = self.revivetriggerspawnposition;

  self.revivetriggerspawnposition = revivepos;
  self.nearestrevivenodepos = _id_E6874E9B453D7005;
  self._id_EB67C9FA9E738FFC = self _meth_E40102956C887F7C();
  stance = self getstance();

  if(stance == "prone")
    self.faux_spawn_stance = stance;
  else
    self.faux_spawn_stance = "crouch";
}

isvalidrevivetriggerspawnposition() {
  spawnpos = self.origin + (0, 0, 3);

  if(istrue(self._id_C4C8B91E0B16AA5E) || istrue(level._id_B961DD6C88E9A008))
    return 1;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_C9CA2508E55C330A = 1;
  else
    _id_C9CA2508E55C330A = canspawn(spawnpos);

  if(_id_C9CA2508E55C330A && (self isonground() || self _meth_E40102956C887F7C()) && !scripts\mp\outofbounds::isoob(self))
    return 1;
  else
    return 0;
}

spawnrevivetrigger(victim, attacker, _id_1202C39784B176E2, meansofdeath) {
  level endon("game_ended");
  victim endon("spawned");
  victim endon("disconnect");
  _id_58EBB947ACC56BF2 = victim.origin;

  if(isDefined(victim.revivecount) && isDefined(level._id_37BAAB13A0CF00E3) && victim.revivecount >= level._id_37BAAB13A0CF00E3) {
    return;
  }
  victim.pers["useNVG"] = 0;

  if(victim isnightvisionon())
    victim.pers["useNVG"] = 1;

  _id_94EC982AECF9A63C = !isDefined(attacker) || !isDefined(attacker.classname) || attacker.classname != "trigger_hurt";

  if(istrue(_id_94EC982AECF9A63C) && istrue(level.numlifelimited)) {
    waitframe();
    _id_94EC982AECF9A63C = !scripts\mp\utility\player::isreallyalive(victim) && !istrue(victim.inlaststand) && !istrue(victim.switching_teams);

    if(scripts\mp\utility\game::getsubgametype() == "dmz")
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_teammate_down", victim.team, 1);
    else
      _id_94EC982AECF9A63C = _id_94EC982AECF9A63C && !victim scripts\mp\playerlogic::mayspawn();
  }

  _id_8DD9F2EB8215A139 = scripts\engine\utility::_id_53C4C53197386572(level._id_D25ED114F4EC6F9C, 0);

  if(isDefined(_id_8DD9F2EB8215A139) && _id_8DD9F2EB8215A139 != 0)
    victim._id_D25ED114F4EC6F9C = _id_8DD9F2EB8215A139;

  if(victim scripts\mp\utility\player::isusingremote()) {
    victim.revivetriggerblockedinremote = 1;
    victim waittill("stopped_using_remote");
    victim.revivetriggeravailable = 1;
  } else {
    victim.revivetriggeravailable = 1;
    wait 3;
  }

  if(istrue(victim._id_D25ED114F4EC6F9C))
    victim thread revivetimeoutthink(_id_8DD9F2EB8215A139);

  _id_F2D86B895BBE2C87 = isDefined(level._id_DBBD13CC9AD757C1) && !istrue(level._id_DBBD13CC9AD757C1._id_0AB651CB230F0D65);
  _id_94EC982AECF9A63C = _id_94EC982AECF9A63C && !(_id_F2D86B895BBE2C87 && _id_957A13A14CDAB289(victim));

  if(!_id_94EC982AECF9A63C) {
    return;
  }
  if(isagent(victim) || !isDefined(victim))
    return;
  else {
    if(!isDefined(victim.revive_chosenclass))
      victim.revive_chosenclass = victim.class;

    struct = victim scripts\mp\class::loadout_getorbuildclassstruct(victim.revive_chosenclass);
    _id_1583B947947AD005 = victim scripts\mp\playerlogic::getplayerassets(struct);
    victim scripts\mp\playerlogic::loadplayerassets([_id_1583B947947AD005], 1);
  }

  if(isDefined(attacker) && isagent(attacker))
    attacker = attacker.owner;

  usetime = scripts\engine\utility::_id_53C4C53197386572(level._id_04B91C5DB6B16C58, 3);

  if(istrue(level._id_B961DD6C88E9A008))
    _id_58EBB947ACC56BF2 = victim.origin + (0, 0, level._id_5ECF502DC8C87BBB);
  else {
    if(isDefined(victim.attacker) && isDefined(victim.attacker.classname) && victim.attacker.classname == "trigger_hurt" && isDefined(victim.nearestrevivenodepos))
      _id_58EBB947ACC56BF2 = victim.nearestrevivenodepos;
    else if(isDefined(victim.revivetriggerspawnposition)) {
      if(!istrue(victim._id_EB67C9FA9E738FFC))
        _id_58EBB947ACC56BF2 = scripts\engine\utility::drop_to_ground(victim.revivetriggerspawnposition, 50, undefined, undefined, scripts\engine\trace::create_world_contents()) + (0, 0, 8);
    } else {
      node = victim getnearestnode();

      if(isDefined(node))
        _id_58EBB947ACC56BF2 = node.origin;
      else
        _id_58EBB947ACC56BF2 = victim.origin;
    }

    _id_C56207BDA09B3A36 = scripts\engine\trace::create_playerclip_contents();
    trace = scripts\engine\trace::sphere_trace(_id_58EBB947ACC56BF2 + (0, 0, 10), _id_58EBB947ACC56BF2 + (0, 0, 30), 2.0, undefined, _id_C56207BDA09B3A36, 1);
    _id_58EBB947ACC56BF2 = trace["position"];
  }

  icon = spawnscriptable("cyber_revive_icon", _id_58EBB947ACC56BF2);
  victim thread addtriggerdeathicon(icon, victim, victim.team);
  icon.victim = victim;
  icon.curorigin = _id_58EBB947ACC56BF2;
  icon._id_F99D56BCB582A8BA = victim;
  icon.owner = victim;
  icon.ownerteam = victim.team;
  icon.curprogress = 0;
  icon.id = "laststand_reviver";
  icon._id_DBC472744080C5D7 = 1;
  icon.waitforweapononuse = 0;
  icon.interactteam = "friendly";
  icon.resetprogress = 0;
  icon.defaultusetime = usetime;
  icon.userate = 1;
  icon.exclusiveuse = 0;
  icon.exclusiveclaim = 1;
  icon.skiptouching = 1;
  icon.skipminimapids = 1;
  icon.useweapon = makeweapon("teammate_revive_stim_mp");
  icon._id_B9ABE6BDF97E9A79 = 14400;

  if(istrue(level._id_B961DD6C88E9A008))
    icon scripts\common\utility::_id_6E506F39F121EA8A(victim, (0, 0, level._id_5ECF502DC8C87BBB));

  icon scripts\mp\gameobjects::setusetime(usetime);
  icon _id_9CDCE27AF3D1224C(victim.team, istrue(level.numrevives));
  icon.onbeginuse = ::revivetriggerholdonusebegin;
  icon.onuse = ::revivetriggerholdonuse;
  icon.onenduse = ::revivetriggerholdonuseend;
  icon._id_A03A7B21F00EAE66 = ::revivetriggeroncantuse;

  if(isDefined(attacker)) {
    icon.attacker = attacker;
    icon.attackerteam = attacker.team;
  }

  level.revivetriggers[victim.guid] = icon;
  victim.forcespawnorigin = _id_58EBB947ACC56BF2;
  victim.forcespawnangles = victim.angles;
  victim thread revivetriggerteamupdater(level.revivetriggers[victim.guid]);
  victim thread revivetriggerspectateteamupdater(level.revivetriggers[victim.guid]);
  victim thread _id_4A3B25B6B877FE73(victim, level.revivetriggers[victim.guid]);
  level notify(_id_1202C39784B176E2, icon);
  level notify("player_last_stand");
  victim scripts\mp\utility\player::setbeingrevivedinternal(0);

  if(isDefined(level.numlifelimited) && level.numlifelimited)
    victim.statusicon = "hud_status_revive_wh";

  if(isDefined(level._id_423C8D4F74C71873)) {
    foreach(_id_CE174178F5680DFC in level._id_423C8D4F74C71873) {
      if(isDefined(_id_CE174178F5680DFC))
        icon[[_id_CE174178F5680DFC]]();
    }
  }
}

makereviveteamusable(team, _id_E4E6FA072697205D) {
  thread _id_9CDCE27AF3D1224C(team, _id_E4E6FA072697205D);
}

_id_9CDCE27AF3D1224C(team, _id_E4E6FA072697205D, _id_6B8279C8C2796CD4) {
  if(!isDefined(self)) {
    return;
  }
  self.ownerteam = team;

  foreach(player in level.players) {
    if(!_id_E4E6FA072697205D)
      player.numrevives = 1;

    if(player.team == team && player.numrevives) {
      if(isDefined(_id_6B8279C8C2796CD4) && player == _id_6B8279C8C2796CD4)
        thread _id_3679AE96CC4F6706(_id_6B8279C8C2796CD4);
      else
        self enablescriptableplayeruse(player);

      continue;
    }

    self disablescriptableplayeruse(player);
  }
}

_id_3679AE96CC4F6706(player) {
  if(!isDefined(player) || !isDefined(self) || !isDefined(self._id_F99D56BCB582A8BA)) {
    return;
  }
  self._id_F99D56BCB582A8BA endon("trigger_removed");
  self endon("death");
  level endon("game_ended");
  self disablescriptableplayeruse(player);
  wait(getdvarfloat("dvar_5562E729A78ADFC4", 0.5));

  if(!isDefined(player) || !isDefined(self) || !isDefined(self._id_F99D56BCB582A8BA)) {
    return;
  }
  self enablescriptableplayeruse(player);
}

revivetimeoutthink(_id_8DD9F2EB8215A139) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("trigger_removed");
  self endon("spawned");
  level endon("game_ended");
  self endon("team_eliminated");

  if(_id_8DD9F2EB8215A139 == 0) {
    return;
  }
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_revive", scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A, 1));
  _id_687528866D09EB2F = level.revivetriggers[self.guid];
  level waittill("new_trigger_spawned", _id_687528866D09EB2F);
  _id_ED7A934B078BD477 = _id_8DD9F2EB8215A139;

  for(;;) {
    waitframe();
    _id_3495C59984396C4D = _id_8DD9F2EB8215A139;

    if(!istrue(scripts\mp\utility\player::getbeingrevivedinternal())) {
      _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - level.framedurationseconds;
      self.timelefttospawnaction = _id_8DD9F2EB8215A139;
      self setclientomnvar("ui_securing_progress", min(_id_8DD9F2EB8215A139 / _id_3495C59984396C4D, 0.01));
      self setclientomnvar("ui_securing", 0);
    }

    if(level.teamdata[self.team]["aliveCount"] > 0) {
      time = int(gettime() + _id_8DD9F2EB8215A139 * 1000);
      scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait", time);
      _id_FD4841A123583725(self, self.team, time);
    }

    if(istrue(self.eliminated)) {
      thread removetrigger(self.guid, 1);
      self.timelefttospawnaction = 0;
      self notify("task_endon_trigger_removed");
      return;
    }

    if(_id_8DD9F2EB8215A139 <= level.framedurationseconds) {
      self notify("last_stand_bleedout");
      thread removetrigger(self.guid, 1, 1);

      if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk" || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() == "dmz") {
        scripts\mp\utility\lower_message::setlowermessageomnvar("player_eliminated");
        thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
        thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
      }

      self.timelefttospawnaction = 0;
      self notify("task_endon_trigger_removed");
      break;
    } else if(istrue(self.beingrallyrespawned)) {
      thread removetrigger(self.guid, 1);
      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      break;
    }
  }

  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_mate_eliminated", scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A, 1));
}

_id_FD4841A123583725(player, team, time, squadmemberindex) {
  if(isDefined(player._id_3F78C6A0862F9E25) && player._id_3F78C6A0862F9E25 < _id_76CC264B397DB9CB::_id_9BE60342A8BABBA5() && isDefined(team)) {
    foreach(_id_B2810E8D06E0A042 in level.teamdata[team]["players"])
    _id_B2810E8D06E0A042 setclientomnvar("ui_cyber_revive_timeout_squad_index_" + player._id_3F78C6A0862F9E25, time);
  }
}

removetrigger(guid, _id_3737240CEFE2C793, _id_EFC3F7A85CDEDB9B, team, squadmemberindex) {
  if(!isDefined(team))
    team = self.team;

  if(isDefined(self.statusicon))
    self.statusicon = "";

  _id_FD4841A123583725(self, team, 0, squadmemberindex);
  self.revivetriggeravailable = undefined;
  self notify("trigger_removed");

  if(isDefined(level.revivetriggers[guid])) {
    scriptable = level.revivetriggers[guid];

    if(isDefined(scriptable.objidnum))
      scripts\mp\objidpoolmanager::returnobjectiveid(level.revivetriggers[guid].objidnum);

    if(isDefined(scriptable.reviver)) {
      scriptable notify("disabled");
      waitframe();
    }

    level.revivetriggers[guid] notify("death");
    level.revivetriggers[guid] freescriptable();
    level.revivetriggers[guid] = undefined;

    if(isDefined(_id_EFC3F7A85CDEDB9B)) {
      self.forcespawnorigin = undefined;
      self.forcespawnangles = undefined;
    }
  }
}

relocatetrigger(pos) {
  org = pos + (0, 0, 5);
  icon = level.revivetriggers[self.guid];
  icon.destination = org;
  icon.curorigin = org;
  icon.origin = org;
  self.forcespawnorigin = org;
}

_id_4A3B25B6B877FE73(player, _id_B25CA392892D7A80) {
  level endon("game_ended");
  player endon("trigger_removed");
  _id_B25CA392892D7A80 endon("death");

  for(;;) {
    player scripts\engine\utility::waittill_any_2("joined_team", "refresh_revives");

    if(!isDefined(_id_B25CA392892D7A80)) {
      return;
    }
    _id_B25CA392892D7A80 _id_0FFC734BC64E389B(player.team);
  }
}

_id_0FFC734BC64E389B(team) {
  self disableplayeruseforallplayers();
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_F4BD04319D625E44 in _id_A6AB8D0FDA441DC2) {
    if(isDefined(_id_F4BD04319D625E44)) {
      if(_id_F4BD04319D625E44 != self.owner)
        self enableplayeruse(_id_F4BD04319D625E44);
    }
  }
}

revivetriggerteamupdater(_id_B25CA392892D7A80) {
  level endon("game_ended");
  self endon("trigger_removed");
  _id_B25CA392892D7A80 endon("death");
  team = self.team;
  squadmemberindex = self._id_3F78C6A0862F9E25;
  guid = self.guid;

  for(;;) {
    scripts\engine\utility::waittill_any_2("disconnect", "spawned");
    thread removetrigger(guid, 1, 1, team, squadmemberindex);
  }
}

revivetriggerspectateteamupdater(_id_B25CA392892D7A80) {
  level endon("game_ended");
  self endon("trigger_removed");
  _id_B25CA392892D7A80 endon("death");

  for(;;) {
    self waittill("joined_spectators");

    if(self.team == "spectator")
      thread removetrigger(self.guid, 1, 1);
  }
}

onrevivepickupevent(event, victim) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers))
    waitframe();

  points = scripts\mp\rank::getscoreinfovalue(event);

  if(isDefined(victim) && istrue(victim.suicidespawndelay))
    points = 0;

  if(isDefined(victim) && self.team == victim.team)
    thread scripts\mp\utility\points::_id_0366980B6A8796AE(event, undefined, points);
}

lifelimitedallyonuse(player) {
  if(istrue(level.numrevives))
    player.numrevives--;

  if(isDefined(player.pers["rescues"])) {
    player.pers["rescues"]++;
    player scripts\mp\persistence::statsetchild("round", "rescues", player.pers["rescues"]);

    switch (scripts\mp\utility\game::getgametype()) {
      case "ko":
      case "cyber":
      case "siege":
      case "sr":
        player scripts\mp\utility\stats::setextrascore1(player.pers["rescues"]);
    }
  }

  _id_4725E52B7C3AA25C = [];
  _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = self.victim;

  if(isDefined(self.victim)) {
    level notify("tr_player_respawned", self.victim);
    self.victim notify("tr_respawned", player);
    self.victim thread scripts\mp\rank::scoreeventpopup("stat_AB2FB342759B6ABC");
    self.victim scripts\mp\utility\dialog::leaderdialogonplayer("revived");

    if(!level.gameended) {
      self.victim scripts\mp\utility\player::_freezecontrols(0, undefined, "teamRevive");

      if(istrue(self.laststanding))
        scripts\mp\utility\stats::incpersstat("clutchRevives", 1);

      _id_E95E29F24BF04C1B(self.victim);
    }

    self.victim.revivetriggeravailable = undefined;
    self.victim.statusicon = "";
    scripts\cp_mp\challenges::onplayerteamrevive(player, self.victim);
  }

  player thread onrevivepickupevent("stat_AB2FA142759B4C26", self.victim);

  if(!isDefined(player.rescuedplayers))
    player.rescuedplayers = [];

  player.rescuedplayers[self.victim.guid] = 1;
  scripts\mp\events::revivedplayer(player, self.victim);
  self.victim scripts\mp\killstreaks\killstreaks::_id_B7492842AAD6FE82();
}

_id_E95E29F24BF04C1B(player) {
  if(istrue(level._id_76F92A587185677C) && player _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
    player thread scripts\mp\laststand::laststandthink();
  else {
    player scripts\mp\utility\player::setbeingrevivedinternal(0);
    player thread respawn();
  }
}

lifelimitedenemyonuse(player) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  _id_4725E52B7C3AA25C = [];
  _id_4725E52B7C3AA25C[_id_4725E52B7C3AA25C.size] = self.victim;
  scripts\mp\hud_message::notifyteam("sr_ally_eliminated", "sr_enemy_eliminated", self.victim.team, _id_4725E52B7C3AA25C);

  if(isDefined(self.victim)) {
    if(!level.gameended) {
      self.victim scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
      self.victim thread scripts\mp\playerlogic::removespawnmessageshortly(3.0);
    }

    self.victim.revivetriggeravailable = undefined;
    self.victim.statusicon = "hud_status_dead";
  }

  if(isDefined(self.attacker) && self.attacker != player)
    self.attacker thread onrevivepickupevent("stat_E24741BA71BBB56B");

  player thread onrevivepickupevent("stat_E24741BA71BBB56B");
  player scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed");
}

respawn() {
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::incrementalivecount(self.team, 1, "teamrevive");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);

  thread scripts\mp\playerlogic::waittillcanspawnclient(1);
}

revivetriggerholdonuse(player) {
  if(isDefined(player.owner))
    player = player.owner;

  if(player.pers["team"] == self.ownerteam || istrue(self._id_C0EE3288DBEC12C6)) {
    if(isDefined(self.victim) && isDefined(self.victim.body) && !istrue(self.victim._id_C4C8B91E0B16AA5E))
      self.victim.body delete();

    player scripts\mp\utility\stats::incpersstat("denied", 1);
    player scripts\mp\persistence::statsetchild("round", "denied", player.pers["denied"]);

    if(istrue(level.numlifelimited))
      lifelimitedallyonuse(player);
    else
      lifelimitedallyonuse(player);
  } else if(istrue(level.numlifelimited)) {
    lifelimitedenemyonuse(player);
    player scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
  }

  player setclientomnvar("ui_securing", 0);
  player setclientomnvar("ui_securing_progress", 0.01);
  player.ui_securing = undefined;
  self.victim thread removetrigger(self.victim.guid);
}

_id_301C4EC489F9BD39(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(instance._id_F99D56BCB582A8BA) || !isDefined(player) || part != "cyber_revive_icon") {
    return;
  }
  if(!player isonground()) {
    if(!(istrue(instance._id_DBC472744080C5D7) && player _meth_E40102956C887F7C()))
      return;
  }

  if(player _meth_E5BF22923D0004BC()) {
    return;
  }
  if(!scripts\engine\trace::ray_trace_detail_passed(player getEye(), instance.origin, [player, instance._id_F99D56BCB582A8BA], scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 1))) {
    player scripts\mp\hud_message::showerrormessage("MP/REVIVE_BLOCKED");
    return;
  }

  player scripts\mp\laststand::_id_D9BD056C79A6077B(instance._id_F99D56BCB582A8BA);
  instance thread scripts\mp\gameobjects::useholdloop(player);
}

revivetriggerholdonusebegin(player, _id_F5A0530CE8D587B1) {
  thread _id_877AEE1F2CDAE81C(player);
  _id_F99D56BCB582A8BA = self._id_F99D56BCB582A8BA;

  if(!_id_F99D56BCB582A8BA _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF())
    player thread _id_C86CF00D5859CE10(_id_F99D56BCB582A8BA.origin);

  if(_id_68AC13D2D66B844A()) {
    if(_id_F99D56BCB582A8BA.team == "allies") {
      level._id_C7D5CDE0CEA88517++;
      setomnvar("ui_num_reviving_allies", level._id_C7D5CDE0CEA88517);
    } else if(_id_F99D56BCB582A8BA.team == "axis") {
      level._id_36A249F46F4464A8++;
      setomnvar("ui_num_reviving_axis", level._id_36A249F46F4464A8);
    }
  }

  if(player scripts\mp\utility\perk::_hasperk("specialty_medic"))
    level.revivetriggers[_id_F99D56BCB582A8BA.guid].usetime = level.revivetriggers[_id_F99D56BCB582A8BA.guid].usetime * getdvarfloat("perk_medicReviveSpeedRatio");

  self setscriptablepartstate("cyber_revive_icon", "unusable");
  _id_F99D56BCB582A8BA.reviver = player;
  self.reviver = player;
  _id_F99D56BCB582A8BA scripts\mp\utility\player::setbeingrevivedinternal(1);
  _id_8D4C493E675E384E = _id_F99D56BCB582A8BA _id_556B8AEAA691317F::_id_F0D1C9C39359EFFF();
  self.reviver setlaststandreviving(1, _id_8D4C493E675E384E);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(player, "stat_572347275DFB41AB");

  if(!istrue(_id_F5A0530CE8D587B1) && !_id_8D4C493E675E384E)
    player thread allowedwhilereviving(0);

  _id_F99D56BCB582A8BA scripts\mp\utility\player::printspawnmessage("teamrevive::reviveTriggerHoldOnUseBegin() Killcam SKIPPED");
  _id_F99D56BCB582A8BA notify("abort_killcam");
  _id_F99D56BCB582A8BA.cancelkillcam = 1;
  _id_F99D56BCB582A8BA scripts\mp\utility\player::_freezecontrols(1, undefined, "teamRevive");
  objidnum = level.revivetriggers[_id_F99D56BCB582A8BA.guid].objidnum;

  if(isDefined(objidnum))
    scripts\mp\objidpoolmanager::update_objective_icon(objidnum, "hud_icon_cyber_reviving");

  thread _id_C164FED51C204630(_id_F99D56BCB582A8BA, player);
}

_id_C164FED51C204630(_id_F99D56BCB582A8BA, reviver) {
  _id_F99D56BCB582A8BA endon("disconnect");
  _id_379DE5A38F0E582A = getrevivecameradata(_id_F99D56BCB582A8BA, reviver);
  camerapos = _id_379DE5A38F0E582A.origin;
  cameraang = _id_379DE5A38F0E582A.angles;
  _id_F99D56BCB582A8BA.forcespawnangles = (0, cameraang[1], 0);
  waitframe();
  _id_F99D56BCB582A8BA.forcespectatorclient = _id_F99D56BCB582A8BA getentitynumber();
  waitframe();
  cameraent = spawn("script_model", camerapos);
  cameraent setModel("tag_origin");
  cameraent.angles = cameraang;
  _id_F99D56BCB582A8BA.revivecameraent = cameraent;
  _id_F99D56BCB582A8BA cameralinkTo(cameraent, "tag_origin", 1);

  if(!scripts\mp\utility\player::isreallyalive(_id_F99D56BCB582A8BA))
    _id_F99D56BCB582A8BA thread revivecamerapullin();

  if(istrue(_id_F99D56BCB582A8BA.pers["useNVG"]))
    _id_F99D56BCB582A8BA thread applynvgforrevive();

  _id_F99D56BCB582A8BA thread runslamzoomonspawn();
}

_id_C86CF00D5859CE10(target) {
  if(!isDefined(self) || !isPlayer(self) || !isDefined(target)) {
    return;
  }
  if(getdvarint("dvar_72771711644C3F78", 1) == 0) {
    return;
  }
  if(self _meth_E40102956C887F7C()) {
    return;
  }
  if(isDefined(self._id_88F59C89F67E4385))
    self._id_88F59C89F67E4385 delete();

  startangles = self getplayerangles();
  _id_B98CF035C97EDEE9 = vectortoangles(vectorNormalize(target - self getEye()));
  _id_B98CF035C97EDEE9 = _id_B98CF035C97EDEE9 * (0, 1, 0);
  _id_88F59C89F67E4385 = spawn("script_model", self.origin);
  _id_88F59C89F67E4385.angles = startangles * (0, 1, 1);
  _id_88F59C89F67E4385 setModel("tag_origin");
  _id_88F59C89F67E4385 rotateTo(_id_B98CF035C97EDEE9, 0.4, 0.05);
  _id_88F59C89F67E4385 thread _id_7F0AEBB7AD935939(self);
  self._id_88F59C89F67E4385 = _id_88F59C89F67E4385;
  _id_11153410E53783B6 = target - self getEye();
  _id_AE9D358478054782 = (target - self getEye()) * (1, 1, 0);
  _id_0EF1F66CEBC32A99 = scripts\engine\math::anglebetweenvectors(_id_AE9D358478054782, _id_11153410E53783B6);
  mover = self getmovingplatformparent();

  if(isDefined(mover)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_3DFE65E73A7D0C86(self, mover);
    _id_88F59C89F67E4385 linkTo(mover);
  }

  self playerlinktodelta(_id_88F59C89F67E4385, "", 1.0, 30, 30, -1 * _id_0EF1F66CEBC32A99 + 30, _id_0EF1F66CEBC32A99 + 30, 0, 0, 0, 1, 0.0, 0.3, 0.3);

  if(isDefined(mover))
    thread _id_34FD10B9791B7BB2(mover);
  else {
    thread _id_1012E32B79F1E975(target);
    thread _id_D75BBD43C2E29F0C();
  }
}

_id_34FD10B9791B7BB2(mover) {
  self endon("death_or_disconnect");
  self endon("stop_revive_pos_lerp");
  contents = physics_createcontents(["physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip"]);

  while(isDefined(self) && isDefined(self.origin)) {
    ignore = [];

    if(isDefined(mover)) {
      ignore[ignore.size] = mover;
      parent = mover getlinkedparent();

      if(isDefined(parent))
        ignore[ignore.size] = parent;

      ignore = scripts\engine\utility::array_combine_unique(ignore, mover getlinkedchildren());
    }

    if(!scripts\engine\trace::player_trace_passed(self.origin, self.origin, undefined, ignore, contents)) {
      self._id_A23F35F8460D8857 = 1;
      return;
    }

    waitframe();
  }
}

_id_D75BBD43C2E29F0C() {
  self endon("death_or_disconnect");
  self endon("stop_revive_pos_lerp");

  for(;;) {
    self waittill("touch", vehicle);

    if(isDefined(vehicle) && vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle_collision::_id_6EB1FBA746B72F46(vehicle) > 1 && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, self)) {
      self._id_A23F35F8460D8857 = 1;
      return;
    }
  }
}

_id_1012E32B79F1E975(target) {
  self endon("death");
  self endon("disconnect");
  self endon("stop_revive_pos_lerp");

  if(!getdvarint("dvar_4E3B17EA9FDA1521", 1)) {
    return;
  }
  radius = 30;
  radiussq = radius * radius;

  while(isDefined(self._id_88F59C89F67E4385) && distance2dsquared(target, self.origin) > radiussq) {
    dir = _func_767CEA82B001F645(target - self.origin);
    _id_D0DE0DB1760B9C5B = 3.0;
    _id_7DCA7B54862A5286 = self._id_88F59C89F67E4385.origin + dir * _id_D0DE0DB1760B9C5B;
    halfsize = self getboundshalfsize();
    radius = halfsize[0];
    height = 2.0 * halfsize[2];

    if(capsuletracepassed(_id_7DCA7B54862A5286 + (0, 0, 1), radius, height, self, 0, 0))
      self._id_88F59C89F67E4385.origin = _id_7DCA7B54862A5286;

    waitframe();
  }
}

_id_7F0AEBB7AD935939(player) {
  self endon("death");
  player waittill("disconnect");

  if(isDefined(self))
    self delete();
}

_id_00A3FFE1D08888C2() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(self._id_88F59C89F67E4385)) {
    return;
  }
  if(getdvarint("dvar_72771711644C3F78", 1) == 0) {
    return;
  }
  self notify("stop_revive_pos_lerp");
  self unlink();
  scripts\mp\utility\player::_id_5471A04FAAD16A00();
  mover = self._id_88F59C89F67E4385 getlinkedparent();
  self._id_88F59C89F67E4385 delete();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_069F266AF27C2689(self, mover);
}

_id_849E441CB5BE1BDA() {
  self endon("death_or_disconnect");

  while(!scripts\mp\utility\player::isreallyalive(self))
    waitframe();

  self notify("revivedAlive");
}

_id_877AEE1F2CDAE81C(player) {
  if(!isDefined(player._id_D969D13F6BCD0830)) {
    player._id_D969D13F6BCD0830 = spawn("script_origin", player.origin);
    player._id_D969D13F6BCD0830 linkTo(player);
    player._id_D969D13F6BCD0830 playLoopSound("br_reviver_use_lp");
    player scripts\engine\utility::waittill_any_3("stop_revive_sfx", "enter_live_ragdoll", "death_or_disconnect");
    player._id_D969D13F6BCD0830 stoploopsound("br_reviver_use_lp", 1);
    player._id_D969D13F6BCD0830 playSound("br_reviver_use_end");
    player._id_D969D13F6BCD0830 delete();
  }
}

revivetriggerholdonuseend(team, player, success, _id_F5A0530CE8D587B1) {
  player notify("stop_revive_sfx");
  self.reviver setlaststandreviving(0);
  self.reviver = undefined;
  player _id_00A3FFE1D08888C2();

  if(isDefined(self))
    self._id_A23F35F8460D8857 = undefined;

  if(isDefined(player))
    player._id_A23F35F8460D8857 = undefined;

  player scripts\mp\laststand::_id_42D99E200AA9762A(self._id_F99D56BCB582A8BA);

  if(isDefined(self._id_F99D56BCB582A8BA) && isDefined(level.revivetriggers) && isDefined(level.revivetriggers[self._id_F99D56BCB582A8BA.guid])) {
    _id_F99D56BCB582A8BA = self._id_F99D56BCB582A8BA;

    if(_id_68AC13D2D66B844A()) {
      if(_id_F99D56BCB582A8BA.team == "allies") {
        level._id_C7D5CDE0CEA88517--;

        if(level._id_C7D5CDE0CEA88517 < 0)
          level._id_C7D5CDE0CEA88517 = 0;

        setomnvar("ui_num_reviving_allies", level._id_C7D5CDE0CEA88517);
      } else if(_id_F99D56BCB582A8BA.team == "axis") {
        level._id_36A249F46F4464A8--;

        if(level._id_36A249F46F4464A8 < 0)
          level._id_36A249F46F4464A8 = 0;

        setomnvar("ui_num_reviving_axis", level._id_36A249F46F4464A8);
      }
    }

    defaultusetime = level.revivetriggers[_id_F99D56BCB582A8BA.guid].defaultusetime;
    level.revivetriggers[_id_F99D56BCB582A8BA.guid] scripts\mp\gameobjects::setusetime(defaultusetime);
    _id_F99D56BCB582A8BA.forcespectatorclient = -1;

    if(success) {
      if(!isDefined(_id_F99D56BCB582A8BA.revivecount))
        _id_F99D56BCB582A8BA.revivecount = 1;
      else
        _id_F99D56BCB582A8BA.revivecount++;

      if(isDefined(level._id_37BAAB13A0CF00E3))
        _id_F99D56BCB582A8BA scripts\mp\hud_message::showerrormessage("MP/NUM_REVIVES_LEFT", level._id_37BAAB13A0CF00E3 - _id_F99D56BCB582A8BA.revivecount);

      _id_A776F097EB36E500 = scripts\mp\utility\dvars::getwatcheddvar("teamReviveHealth");
      scripts\mp\analyticslog::logevent_playerhealed(_id_F99D56BCB582A8BA, _id_A776F097EB36E500, player);

      if(isDefined(level._id_36827F5D10328424) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        _id_F99D56BCB582A8BA thread _id_849E441CB5BE1BDA();
        _id_F99D56BCB582A8BA thread[[level._id_36827F5D10328424]]();
      }

      _id_F99D56BCB582A8BA playsoundtoteam("npc_breath_revive", _id_F99D56BCB582A8BA.team, _id_F99D56BCB582A8BA, _id_F99D56BCB582A8BA);
      _id_F99D56BCB582A8BA thread _id_7DCE7A3AF5B0CE26();
      _id_F99D56BCB582A8BA setclientomnvar("ui_reviver_id", -1);
      _id_F99D56BCB582A8BA setclientomnvar("ui_securing", 0);

      if(_id_396A814D39E7044F::_id_7BA31CB6B21C346F() && player != _id_F99D56BCB582A8BA)
        _id_F99D56BCB582A8BA thread _id_396A814D39E7044F::_id_36EDF91561322753(2);
    } else {
      _id_F99D56BCB582A8BA scripts\mp\utility\player::setbeingrevivedinternal(0);
      level.revivetriggers[_id_F99D56BCB582A8BA.guid] setscriptablepartstate("cyber_revive_icon", "usable");
      _id_9CDCE27AF3D1224C(_id_F99D56BCB582A8BA.team, istrue(level.numrevives), player);
      objidnum = level.revivetriggers[_id_F99D56BCB582A8BA.guid].objidnum;

      if(isDefined(objidnum)) {
        scripts\mp\objidpoolmanager::objective_show_progress(objidnum, 0);
        scripts\mp\objidpoolmanager::update_objective_icon(objidnum, "hud_icon_revive_cyber");
      }

      _id_F99D56BCB582A8BA scripts\mp\utility\player::_freezecontrols(0, undefined, "teamRevive");
      _id_F99D56BCB582A8BA scripts\mp\utility\player::updatesessionstate("spectator");

      if(isDefined(_id_F99D56BCB582A8BA.revivecameraent)) {
        _id_F99D56BCB582A8BA cameraunlink();
        _id_F99D56BCB582A8BA.revivecameraent delete();
      }

      if(isDefined(_id_F99D56BCB582A8BA.team) && _id_F99D56BCB582A8BA.team != "spectator") {
        _id_F99D56BCB582A8BA allowspectateteam(_id_F99D56BCB582A8BA.team, 1);

        foreach(_id_F90358454413407F in level.teamnamelist) {
          if(_id_F90358454413407F != _id_F99D56BCB582A8BA.team)
            _id_F99D56BCB582A8BA allowspectateteam(_id_F90358454413407F, 0);
        }

        _id_F99D56BCB582A8BA spectateclientnum(player getentitynumber());
      }
    }
  }

  if(!istrue(_id_F5A0530CE8D587B1))
    player thread allowedwhilereviving(1);

  if(isPlayer(player)) {
    player setclientomnvar("ui_securing", 0);
    player setclientomnvar("ui_securing_progress", 0.01);
    player.ui_securing = undefined;
  }

  if(success) {
    player scripts\mp\utility\stats::incpersstat("revives", 1);

    if(istrue(player.laststanding))
      player scripts\mp\utility\stats::incpersstat("clutchRevives", 1);

    player thread _id_189B67B2735B981D::_id_BD70B31DD13292BC(player);

    if(isDefined(self._id_F99D56BCB582A8BA))
      self._id_F99D56BCB582A8BA thread _id_189B67B2735B981D::_id_BD70A21DD1326D59(self._id_F99D56BCB582A8BA);
  }
}

revivetriggeroncantuse(player) {
  player scripts\mp\hud_message::showerrormessage("MP/PLAYER_ALREADY_BEING_REVIVED");
}

getrevivecameradata(_id_F99D56BCB582A8BA, reviver) {
  _id_7E773EA54FFA645F = level.revivetriggers[_id_F99D56BCB582A8BA.guid].curorigin;

  if(istrue(level._id_B961DD6C88E9A008) && isDefined(_id_F99D56BCB582A8BA) && isDefined(_id_F99D56BCB582A8BA.origin))
    _id_7E773EA54FFA645F = _id_F99D56BCB582A8BA.origin;

  _id_530640BC408681DD = _id_7E773EA54FFA645F;
  fwd = vectorNormalize(reviver.origin - _id_530640BC408681DD);
  radius = 2;
  _id_F03302C066639995 = 30;
  _id_519305604D8E28E4 = 360 / _id_F03302C066639995;
  _id_40088284FA4B02C0 = 1;
  _id_AD3FD9A25605F892 = 1;
  _id_C030A8A33647FEEE = 200;
  _id_D4EBDDC5067723C4 = generateaxisanglesfromforwardvector(fwd, (0, 0, 1));
  _id_634E1A5FDA766CAA = 0;
  _id_E95D8B067BE88B21 = undefined;
  passed = 0;
  _id_12B614F64A9BA025 = _id_530640BC408681DD;
  _id_ABB06648E9DB3FFE = _id_D4EBDDC5067723C4;
  _id_C56207BDA09B3A36 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1);

  while(_id_40088284FA4B02C0 < _id_519305604D8E28E4) {
    if(_id_634E1A5FDA766CAA) {
      _id_634E1A5FDA766CAA = 0;
      _id_E95D8B067BE88B21 = anglesToForward(_id_D4EBDDC5067723C4);
    } else {
      _id_E95D8B067BE88B21 = anglesToForward(_id_D4EBDDC5067723C4 + (0, scripts\engine\utility::ter_op(_id_AD3FD9A25605F892, _id_F03302C066639995, _id_F03302C066639995 * -1) * _id_40088284FA4B02C0, 0));
      _id_AD3FD9A25605F892 = !_id_AD3FD9A25605F892;

      if(_id_AD3FD9A25605F892 == 1)
        _id_40088284FA4B02C0++;
    }

    startpos = _id_530640BC408681DD + (0, 0, 12);
    endpos = _id_530640BC408681DD + _id_E95D8B067BE88B21 * _id_C030A8A33647FEEE + (0, 0, 100);
    _id_2FC7B90001702E5C = [];
    _id_2FC7B90001702E5C[0] = _id_F99D56BCB582A8BA;
    _id_2FC7B90001702E5C[1] = reviver;
    trace = scripts\engine\trace::sphere_trace(startpos, endpos, radius, _id_2FC7B90001702E5C, _id_C56207BDA09B3A36);
    _id_47D735016BAE708E = 30;
    _id_41302AFFD456FCB3 = trace["position"];
    _id_9406FD672E3B3B43 = 0;

    if(trace["fraction"] < 1) {
      _id_41302AFFD456FCB3 = _id_41302AFFD456FCB3 + _id_E95D8B067BE88B21 * radius;
      _id_9406FD672E3B3B43 = 1;
    }

    if(trace["fraction"] > 0.99) {
      _id_12B614F64A9BA025 = _id_41302AFFD456FCB3;
      _id_ABB06648E9DB3FFE = vectortoangles(_id_E95D8B067BE88B21);
      break;
    }
  }

  _id_379DE5A38F0E582A = spawnStruct();
  _id_379DE5A38F0E582A.origin = _id_12B614F64A9BA025;
  _id_3FE9488A68F80E54 = vectorNormalize(_id_530640BC408681DD - _id_12B614F64A9BA025);
  _id_379DE5A38F0E582A.angles = vectortoangles(_id_3FE9488A68F80E54);
  return _id_379DE5A38F0E582A;
}

revivecamerapullin(cameraent) {
  _id_522749E2B770767F = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 3.0;
  _id_8569CBED694EC300 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 50.0;
  _id_BEAF249485A20BB7 = scripts\engine\trace::sphere_trace(_id_522749E2B770767F, _id_8569CBED694EC300, 2.0, undefined)["position"];
  duration = level.revivetriggers[self.guid].usetime / 1000;
  self.revivecameraent moveTo(_id_BEAF249485A20BB7, duration, duration * 0.3, duration * 0.3);
}

applynvgforrevive() {
  self notify("stopNVGOnRevive");
  self endon("stopNVGOnRevive");
  wait 1;
  self nightvisionviewon(1);
}

deleteonspawn(cameraent) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  cameraent delete();
}

allowedwhilereviving(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("reviving", "melee", 0);
    _id_3B64EB40368C1450::set("reviving", "allow_jump", 0);
    _id_3B64EB40368C1450::set("reviving", "gesture", 0);
    _id_3B64EB40368C1450::set("reviving", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("reviving", "stance_change", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("reviving");
}

movecameratorevivepos(_id_9813182985677B23, finalangles, player) {
  movetime = 1.0;
  _id_CC5BC42930ABBC4F = 1.0;
  self moveTo(_id_9813182985677B23, 1.0, 0.5, 0.5);
  finalangles = (-9.5111, player.angles[1], 0);
  self rotateTo(finalangles, 1.0, 0.5, 0.5);
}

_id_7DCE7A3AF5B0CE26() {
  self endon("death_or_disconnect");
  wait 0.15;
  self.deathsdoorsfx = 0;
  self playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::isfemale(), "Fem_breathing_better", "breathing_better"));
  self stoplocalsound("deaths_door_in");
  self clearsoundsubmix("deaths_door_mp");
  self setentitysoundcontext("atmosphere", "");
  self enableplayerbreathsystem(1);
}

addtriggerdeathicon(icon, _id_FDF2150B2EE00667, team) {
  _id_FDF2150B2EE00667 endon("spawned_player");
  _id_FDF2150B2EE00667 endon("disconnect");

  if(!level.teambased) {
    return;
  }
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(!isDefined(icon)) {
    return;
  }
  if(!isDefined(self) || !isDefined(_id_FDF2150B2EE00667) || _func_96D228FA8E72A818(self) || _func_96D228FA8E72A818(_id_FDF2150B2EE00667)) {
    return;
  }
  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  self notify("revived_death_icon");

  if(!isDefined(team) || team == "spectator") {
    return;
  }
  objid = icon scripts\mp\objidpoolmanager::createobjective("hud_icon_revive_cyber");
  scripts\mp\objidpoolmanager::update_objective_position(objid, icon.origin);
  scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
  scripts\mp\objidpoolmanager::objective_teammask_single(objid, team);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);
  scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(objid, 14);
  objective_sethideelevation(objid, 1);
  icon.objidnum = objid;

  if(istrue(level._id_B961DD6C88E9A008)) {
    objective_onentity(objid, self);
    objective_setzoffset(objid, level._id_5ECF502DC8C87BBB);
  }

  _id_4880FB2B58A49F48(icon, self, team);
}

runslamzoomonspawn() {
  self notify("end_spawn_zoom");
  self endon("end_spawn_zoom");
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\mp\utility\player::isreallyalive(self))
    self waittill("spawned_player");

  targetpos = self getEye();
  targetangles = self.angles;
  self cameralinkTo(self.revivecameraent, "tag_origin", 1);
  self.revivecameraent moveTo(targetpos, 0.25, 0.1, 0.1);
  self.revivecameraent rotateTo(targetangles, 0.25, 0.1, 0.1);
  wait 0.25;
  self visionsetnakedforplayer("", 0.1);
  self cameraunlink();
  self.revivecameraent delete();
  wait 0.5;

  if(!_id_396A814D39E7044F::_id_7BA31CB6B21C346F())
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_1F1F4FE800E03B33", undefined, 1.25);
}

playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.4);
  overlay.alpha = 0.0;
  wait 0.4;
  overlay destroy();
}

cleanuprevivetriggericons() {
  if(!isDefined(level) || !isDefined(level.revivetriggers)) {
    return;
  }
  foreach(trigger in level.revivetriggers) {
    if(isDefined(trigger))
      trigger freescriptable();
  }

  level.revivetriggers = undefined;
}

updatetimerwaitforjoined() {}

assigntimervisibleteam(teams) {
  self.interactteams = teams;

  foreach(player in level.players)
  applytimervisibleteam(player);
}

applytimervisibleteam(player) {
  if(player.team == self.ownerteam)
    self.visuals[0] showtoplayer(player);
  else
    self.visuals[0] hidefromplayer(player);
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("started_spawnPlayer");
  self endon("team_eliminated");
  _id_DDF8E09B2A81DD37 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      while(self useButtonPressed()) {
        _id_DDF8E09B2A81DD37 = _id_DDF8E09B2A81DD37 + 0.05;

        if(_id_DDF8E09B2A81DD37 >= 1.0) {
          break;
        }

        wait 0.05;
      }

      if(_id_DDF8E09B2A81DD37 >= 0.5)
        _id_DDF8E09B2A81DD37 = _id_DDF8E09B2A81DD37 + 0.05;
    }

    _id_DDF8E09B2A81DD37 = 0;
    wait 0.05;
  }
}

_id_68AC13D2D66B844A() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "rescue":
    case "ko":
    case "cyber":
    case "sd":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_855B084A3F053964(pos, _id_7136191B4291791A) {
  _id_114AB88507847C50 = undefined;
  _id_42CA41C7DADAE0C0 = undefined;

  if(!isDefined(level.revivetriggers))
    return undefined;

  foreach(_id_B25CA392892D7A80 in level.revivetriggers) {
    if(!isDefined(_id_B25CA392892D7A80._id_F99D56BCB582A8BA)) {
      continue;
    }
    if(_id_B25CA392892D7A80._id_F99D56BCB582A8BA.team != self.team) {
      continue;
    }
    if(!_id_B25CA392892D7A80 _id_BB57ED6218A82D1C()) {
      continue;
    }
    dist = distance2d(pos, _id_B25CA392892D7A80.origin);

    if(isDefined(_id_7136191B4291791A) && dist > _id_7136191B4291791A) {
      continue;
    }
    if(!isDefined(_id_114AB88507847C50)) {
      _id_114AB88507847C50 = _id_B25CA392892D7A80;
      _id_42CA41C7DADAE0C0 = dist;
      continue;
    }

    if(dist < _id_42CA41C7DADAE0C0) {
      _id_114AB88507847C50 = _id_B25CA392892D7A80;
      _id_42CA41C7DADAE0C0 = dist;
    }
  }

  return _id_114AB88507847C50;
}

_id_15933E1583288208() {
  if(!isDefined(level.revivetriggers))
    return undefined;

  foreach(_id_B25CA392892D7A80 in level.revivetriggers) {
    if(_id_B25CA392892D7A80.owner.team != self.team) {
      continue;
    }
    if(_id_B25CA392892D7A80.owner == self)
      return _id_B25CA392892D7A80;
  }

  return undefined;
}

_id_BB57ED6218A82D1C() {
  return self getscriptablepartstate("cyber_revive_icon") == "usable";
}

_id_9341574D596E9D36(player, contents, _id_46A3A8565AC0C17C, _id_846A20D8E6F30B8E, _id_04F6CDE716E0C3D7, _id_6FB67C8525B1D79E, _id_3EF503345DC57957, _id_86B32AFF94B5714E, _id_275F4441AB7920C8, _id_094333580DC2B96B, _id_BF23A60678978C19, _id_C299C08E4B8A8E56, _id_A0E9FEF038504BD0, _id_FD8A9B46F4A1E27C, _id_9D09471027604346, _id_C31356A794D8CB46, _id_00AD7897ECDBCB63) {
  corpse = spawnscriptable("cyber_revive_pillage", player.origin + (0, 0, level._id_5ECF502DC8C87BBB));
  corpse scripts\common\utility::_id_6E506F39F121EA8A(player, (0, 0, level._id_5ECF502DC8C87BBB));
  _id_7E52B56769FA7774::registerscriptableinstance(corpse);
  corpse.contents = contents;
  corpse._id_46A3A8565AC0C17C = _id_46A3A8565AC0C17C;
  corpse._id_846A20D8E6F30B8E = _id_846A20D8E6F30B8E;
  corpse.owner = player;
  corpse._id_04F6CDE716E0C3D7 = _id_04F6CDE716E0C3D7;
  corpse._id_6FB67C8525B1D79E = _id_6FB67C8525B1D79E;
  corpse._id_3EF503345DC57957 = _id_3EF503345DC57957;
  corpse._id_275F4441AB7920C8 = _id_275F4441AB7920C8;
  corpse._id_4E479E14D0837E84 = _id_FD8A9B46F4A1E27C;
  corpse._id_86B32AFF94B5714E = _id_86B32AFF94B5714E;
  corpse._id_00AD7897ECDBCB63 = _id_00AD7897ECDBCB63;
  corpse._id_342175A1B9F9067E = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player);
  corpse._id_BF23A60678978C19 = _id_BF23A60678978C19;

  if(isDefined(_id_C299C08E4B8A8E56) && isDefined(_id_A0E9FEF038504BD0)) {
    corpse._id_A06E7128C001851D = _id_C299C08E4B8A8E56;
    corpse._id_A0E9FEF038504BD0 = _id_A0E9FEF038504BD0;
    corpse._id_BB6791B7369EF71A = _id_9D09471027604346;
    corpse._id_C31356A794D8CB46 = _id_C31356A794D8CB46;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    corpse._id_BBC200BC77C5DB2B = 1;

  foreach(item in corpse.contents)
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item["lootID"], "addedToContainer", corpse, player);

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(player.team, "players"))
  corpse disablescriptableplayeruse(_id_B2810E8D06E0A042);

  player._id_6A4360DCF2A8F3D4 = corpse;
  player._id_6A4360DCF2A8F3D4._id_386694991BE029A0 = 1;
  level thread _id_D5C44AF2144B00B3(player, player.attached_bag, corpse);
}

_id_D5C44AF2144B00B3(_id_F99D56BCB582A8BA, model, corpse) {
  _id_F99D56BCB582A8BA endon("revivedAlive");
  corpse endon("death");

  if(isDefined(level._id_D25ED114F4EC6F9C) && level._id_D25ED114F4EC6F9C > 0) {
    _id_F99D56BCB582A8BA scripts\engine\utility::waittill_any_2("disconnect", "trigger_removed");

    if(isDefined(_id_F99D56BCB582A8BA) && !istrue(_id_F99D56BCB582A8BA.isdisconnecting) && isDefined(_id_F99D56BCB582A8BA.timelefttospawnaction) && _id_F99D56BCB582A8BA.timelefttospawnaction > 0)
      return;
  } else
    _id_F99D56BCB582A8BA waittill("disconnect");

  if(!isDefined(corpse)) {
    return;
  }
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_A9706ADAF7C52E27 = scripts\engine\utility::drop_to_ground(corpse.origin) + (0, 0, 2);
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_A9706ADAF7C52E27, corpse.angles);
  scriptablename = _id_2D9D24F7C63AC143::_id_432475069C798DDC(scripts\engine\utility::_id_53C4C53197386572(model, "parts_backpack_inventory_small"));
  _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, 1);
  _id_85B5BECFEBDC7B62(corpse, _id_87583859F07B58E3);

  if(isDefined(corpse.opener)) {
    _id_87583859F07B58E3 setscriptablepartstate("body", "partially_opening_unusable");

    if(isDefined(corpse.opener._id_F2AA9AE949179907) && isDefined(corpse.opener.origin))
      corpse.opener._id_F2AA9AE949179907 = corpse.opener.origin;

    scripts\mp\loot::_id_30F5EA60517F9E06(corpse.opener, _id_87583859F07B58E3);
  } else
    _id_87583859F07B58E3 setscriptablepartstate("body", "closed_usable");

  _id_7E52B56769FA7774::loothide(corpse, "body");

  if(_id_957A13A14CDAB289(_id_F99D56BCB582A8BA))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pleaForHelp", "UpdatePlayerPleaForAll")]](_id_F99D56BCB582A8BA);
}

_id_85B5BECFEBDC7B62(corpse, _id_51BE4043D33594E7) {
  _id_51BE4043D33594E7.contents = corpse.contents;
  _id_51BE4043D33594E7._id_46A3A8565AC0C17C = corpse._id_46A3A8565AC0C17C;
  _id_51BE4043D33594E7._id_846A20D8E6F30B8E = corpse._id_846A20D8E6F30B8E;
  _id_51BE4043D33594E7.owner = corpse.player;
  _id_51BE4043D33594E7._id_04F6CDE716E0C3D7 = corpse._id_04F6CDE716E0C3D7;
  _id_51BE4043D33594E7._id_6FB67C8525B1D79E = corpse._id_6FB67C8525B1D79E;
  _id_51BE4043D33594E7._id_3EF503345DC57957 = corpse._id_3EF503345DC57957;
  _id_51BE4043D33594E7._id_D636075065504B2B = corpse._id_D636075065504B2B;
  _id_51BE4043D33594E7._id_275F4441AB7920C8 = corpse._id_275F4441AB7920C8;
  _id_51BE4043D33594E7._id_4E479E14D0837E84 = corpse._id_FD8A9B46F4A1E27C;
  _id_51BE4043D33594E7._id_86B32AFF94B5714E = corpse._id_86B32AFF94B5714E;
  _id_51BE4043D33594E7._id_342175A1B9F9067E = corpse._id_342175A1B9F9067E;
  _id_51BE4043D33594E7._id_BF23A60678978C19 = corpse._id_BF23A60678978C19;

  if(isDefined(corpse._id_A06E7128C001851D) && isDefined(corpse._id_A0E9FEF038504BD0)) {
    _id_51BE4043D33594E7._id_A06E7128C001851D = corpse._id_A06E7128C001851D;
    _id_51BE4043D33594E7._id_A0E9FEF038504BD0 = corpse._id_A0E9FEF038504BD0;
    _id_51BE4043D33594E7._id_BB6791B7369EF71A = corpse._id_BB6791B7369EF71A;
    _id_51BE4043D33594E7._id_C31356A794D8CB46 = corpse._id_C31356A794D8CB46;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_51BE4043D33594E7._id_BBC200BC77C5DB2B = 1;

  foreach(item in _id_51BE4043D33594E7.contents)
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(item["lootID"], "addedToContainer", _id_51BE4043D33594E7);
}

_id_5B55070C02328EA7(corpse) {
  return isDefined(corpse) && isDefined(corpse.type) && corpse.type == "cyber_revive_pillage";
}

_id_957A13A14CDAB289(player) {
  return _id_362C58E8BB39BCDA::isfeatureenabled("pleaForHelp") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("pleaForHelp", "isPleading")]](player);
}

_id_7127253A02AF37C6(player) {
  return isDefined(level.revivetriggers) && isDefined(level.revivetriggers[player.guid]);
}