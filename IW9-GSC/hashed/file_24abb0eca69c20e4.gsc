/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_24abb0eca69c20e4.gsc
***********************************************/

init() {
  level._effect["vfx_killmonger_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_killmonger_scrnfx");
  level._effect["vfx_killmonger_blood_trail"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_marked_blood_trail");
  level._effect["vfx_killmonger_smoke_trail"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_killmonger_trail");
  level._effect["vfx_killmonger_victim_explosion"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_victim_explosion");
  game["dialog"]["powerup_killmonger"] = "power_up_killmonger";
  _id_1185B37199B6EDF8 = spawnStruct();
  _id_1185B37199B6EDF8._id_04CDDC1583171DAE = "killmonger";
  _id_1185B37199B6EDF8._id_19C0658A705F4A94 = getdvarfloat("dvar_64D088729642CAC2", 45);
  _id_1185B37199B6EDF8._id_2E9CED8AD0E2DECD = getdvarfloat("dvar_9970A528F39EDFBC", 2.0);
  _id_1185B37199B6EDF8._id_4E54207E689BDD81 = getdvarint("dvar_CE945013162A3674", 2500);
  _id_1185B37199B6EDF8._id_B5260C87438F0C9C = getdvarfloat("dvar_2AB73C3695A9DABB", 1.8);
  _id_1185B37199B6EDF8._id_549D815702442B2A = getdvarfloat("dvar_D85DFCE3AFDB957C", 1.8);
  _id_1185B37199B6EDF8._id_2B65725ECD17D33A = ::_id_2B65725ECD17D33A;
  _id_1185B37199B6EDF8._id_115CFFC870AD0973 = ::_id_115CFFC870AD0973;
  _id_1185B37199B6EDF8._id_40243F80136FAB27 = ::_id_40243F80136FAB27;
  _id_1185B37199B6EDF8._id_97183CB1A6E6C08B = ::_id_97183CB1A6E6C08B;
  _id_7FEAED3F883FE324::_id_591D2B2DB731B2D7(_id_1185B37199B6EDF8);
}

_id_2B65725ECD17D33A() {
  self._id_56416B76461EFA9B = 0;
  self._id_98EA5AFB293A76A2 = 2;
  self.player._id_3508A66C8F4C18A3 = 1;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("powerup_killmonger", self.player);
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  self.player scripts\mp\utility\perk::giveperk("specialty_quickswap");
  self.player scripts\mp\utility\perk::giveperk("specialty_stalker");
  self.player scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  _id_BF86BD0E43660F38();
  self.player playlocalsound("mp_powerup_activate_killmonger_plr");
  _id_7FEAED3F883FE324::_id_AD38C0594F257A1D(self.player, "br_rumble_powerup_killmonger_activated");
}

_id_40243F80136FAB27() {
  level endon("game_ended");
  self endon("death");
  self.player endon("death_or_disconnect");
  self endon("stop_powerup");
  _id_7A9FC84F0DA5A515 = 0;

  while(gettime() < self._id_A7F29930A5DD5069) {
    _id_DE20130BA0323CE1 = gettime();

    if(_id_DE20130BA0323CE1 - _id_7A9FC84F0DA5A515 >= self._id_02FA928445372D72._id_2E9CED8AD0E2DECD * 1000) {
      thread _id_AE0DDCC0422FB0EF();
      thread _id_4E5DA3144591864D();
      _id_7A9FC84F0DA5A515 = gettime();
    }

    waitframe();
  }
}

_id_97183CB1A6E6C08B() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
  self.player scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  self.player scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.player scripts\mp\utility\perk::removeperk("specialty_stalker");
  self.player scripts\mp\utility\perk::removeperk("specialty_sprintfire");
  self.player._id_3508A66C8F4C18A3 = 0;
  self.player lerpfovbypreset("default_2seconds");
  _id_05135FCE82CC142D();

  if(isalive(self.player))
    self.player playlocalsound("mp_powerup_deactivate_killmonger_plr");
}

_id_115CFFC870AD0973() {
  _id_1BD8558F1AEF50BD(self._id_02FA928445372D72._id_19C0658A705F4A94);
  self.player playlocalsound("mp_powerup_reactivate_killmonger_plr");
  self.player lerpfovbypreset("zombiedefault");
}

_id_FA66101B60F4D9BC(data) {
  if(isDefined(data.attacker._id_3508A66C8F4C18A3)) {
    if(data.attacker._id_3508A66C8F4C18A3) {
      playFX(scripts\engine\utility::getfx("vfx_killmonger_victim_explosion"), data.victim.origin);
      _id_C40F543B5CAD5C1E = spawnscriptable("brloot_rumble_powerup_sfx", data.victim.origin);
      _id_C40F543B5CAD5C1E setscriptablepartstate("sfx", "killmonger_victim_death_3D");
      data.attacker playlocalsound("mp_powerup_victim_death_killmonger_plr");
      _id_E74300DFB04B35EB = data.attacker _id_7FEAED3F883FE324::_id_9925A4BF8196071A("killmonger");
      _id_E74300DFB04B35EB._id_56416B76461EFA9B++;

      if(_id_E74300DFB04B35EB._id_56416B76461EFA9B % 3 == 0) {
        _id_AB5F7D9B98D86732 = clamp(_id_E74300DFB04B35EB._id_98EA5AFB293A76A2 + 1, 2, 2);
        _id_E74300DFB04B35EB._id_98EA5AFB293A76A2 = _id_AB5F7D9B98D86732;
      }

      _id_3B9C5EE38CC10966 = (_id_E74300DFB04B35EB._id_98EA5AFB293A76A2 - 1) * 75;
      _id_E74300DFB04B35EB.player thread scripts\mp\rank::giverankxp("br_rumble_killmonger_kill_bonus", _id_3B9C5EE38CC10966, data.objweapon);
      _id_E74300DFB04B35EB.player thread scripts\mp\rank::scoreeventpopup("br_rumble_killmonger_kill_bonus");
    }
  }
}

_id_1BD8558F1AEF50BD(_id_CEBDB0E614D4D7D2) {
  self._id_A7F29930A5DD5069 = gettime() + _id_CEBDB0E614D4D7D2 * 1000;
  self.player thread _id_7FEAED3F883FE324::_id_86DC7FCF1ACCBCBF(undefined, 3, 2);
}

_id_BF86BD0E43660F38() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4");
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4", self.player);
}

_id_05135FCE82CC142D() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_killmonger_smoke_trail"), self.player, "j_spine4");
  self.player playlocalsound("mp_powerup_deactivate_killmonger_plr");
}

_id_4E5DA3144591864D() {
  level endon("game_ended");
  self.player endon("remove_tracker_perk");
  self.player endon("disconnect");
  self.player thread _id_75A70933E138DD72();
  self.player scripts\mp\utility\perk::giveperk("specialty_tracker");
  wait(self._id_02FA928445372D72._id_549D815702442B2A);
  self.player scripts\mp\utility\perk::removeperk("specialty_tracker");
  self.player notify("remove_tracker_perk");
}

_id_75A70933E138DD72() {
  level endon("game_ended");
  self endon("remove_tracker_perk");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "joined_team", "joined_spectators");
  scripts\mp\utility\perk::removeperk("specialty_tracker");
  self notify("remove_tracker_perk");
}

_id_AE0DDCC0422FB0EF() {
  owner = self.player;
  position = self.player.origin;
  angles = self.player.angles;
  _id_7AA1FF687CFC30D1 = _id_5929683A27E399B1(owner, position);
  _id_AC93BF0580BB0A75 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_F835339FB0E0E6E2 = scripts\common\utility::playersinsphere(position, self._id_02FA928445372D72._id_4E54207E689BDD81);
  self._id_FC7975078DCD23FA = _id_F835339FB0E0E6E2;

  if(_id_F835339FB0E0E6E2.size > 0)
    _id_FF8BD721AF677C90 = scripts\engine\utility::ter_op(self.player.team == "axis", "allies", "axis");

  foreach(player in _id_F835339FB0E0E6E2) {
    if(!scripts\mp\utility\player::isreallyalive(player) || !scripts\cp_mp\utility\player_utility::playersareenemies(owner, player)) {
      continue;
    }
    thread _id_5E2EB732DA110B5C(player, owner, _id_7AA1FF687CFC30D1);
    thread _id_DAC1A60F5B9197E3(player, owner);
  }

  triggerportableradarping(position, owner, self._id_02FA928445372D72._id_4E54207E689BDD81, 500, "specialty_snapshot_immunity");
}

_id_DAC1A60F5B9197E3(victim, attacker) {
  level endon("game_ended");
  self.player endon("disconnect");

  if(isagent(victim)) {
    return;
  }
  if(isDefined(victim) && isDefined(attacker))
    _id_9449EA2BD6997780 = playfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), victim, "j_spine4", attacker);

  wait(self._id_02FA928445372D72._id_B5260C87438F0C9C / 1.8);

  if(isDefined(victim) && isDefined(attacker))
    stopfxontagforclients(scripts\engine\utility::getfx("vfx_killmonger_blood_trail"), victim, "j_spine4", attacker);
}

_id_5E2EB732DA110B5C(victim, attacker, _id_7AA1FF687CFC30D1) {
  victim scripts\mp\outline::hudoutline_add_channel_internal("equipment", 3, "killmonger_snapshot");
  entnum = victim getentitynumber();
  _id_7AA1FF687CFC30D1.targets[entnum] = victim;
  _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + self._id_02FA928445372D72._id_B5260C87438F0C9C * 1000.0;
  _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\mp\utility\outline::outlineenableforplayer(victim, attacker, "killmonger_snapshot", "equipment");

  if(isPlayer(victim) || isbot(victim)) {}

  _id_7AA1FF687CFC30D1 thread _id_6A8D6208EB6EE8F9();
  victim.lastsnapshotgrenadetime = gettime();
  attacker scripts\mp\damage::combatrecordtacticalstat("equip_snapshot_grenade");
  attacker scripts\mp\utility\stats::incpersstat("snapshotHits", 1);
}

_id_5929683A27E399B1(owner, position) {
  _id_7AA1FF687CFC30D1 = undefined;

  if(1) {
    _id_7AA1FF687CFC30D1 = spawnStruct();
    _id_7AA1FF687CFC30D1.owner = owner;
    _id_7AA1FF687CFC30D1.position = position;
    _id_7AA1FF687CFC30D1.isalive = 1;
    _id_7AA1FF687CFC30D1.targets = [];
    _id_7AA1FF687CFC30D1.endtimes = [];
    _id_7AA1FF687CFC30D1.outlineids = [];
  }

  return _id_7AA1FF687CFC30D1;
}

_id_6A8D6208EB6EE8F9() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");

  if(!istrue(self.isalive)) {
    return;
  }
  self notify("update");
  self endon("update");
  thread _id_7BA1E061CBB0C287();

  while(self.targets.size > 0) {
    foreach(id, target in self.targets) {
      target = self.targets[id];
      endtime = self.endtimes[id];
      outlineid = self.outlineids[id];

      if(!scripts\mp\utility\player::isreallyalive(target) || gettime() >= endtime) {
        scripts\mp\utility\outline::outlinedisable(outlineid, target);
        _id_1904D367790F05EA = isPlayer(target);

        if(isDefined(target) && _id_1904D367790F05EA)
          target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

        self.targets[id] = undefined;
        self.endtimes[id] = undefined;
        self.outlineids[id] = undefined;
      }
    }

    waitframe();
  }

  thread _id_D48690D1E1E118D3();
}

_id_7BA1E061CBB0C287() {
  self endon("death");
  self endon("update");
  self endon("stop_powerup");
  _id_7F2B7E6EDECA55D6();
  thread _id_D48690D1E1E118D3();
}

_id_7F2B7E6EDECA55D6() {
  self endon("stop_powerup");
  level endon("game_ended");

  for(;;)
    waitframe();
}

_id_D48690D1E1E118D3() {
  self notify("death");
  self.isalive = 0;

  foreach(id, target in self.targets) {
    target = self.targets[id];
    outlineid = self.outlineids[id];
    scripts\mp\utility\outline::outlinedisable(outlineid, target);

    if(isDefined(target) && (isPlayer(target) || isbot(target)))
      target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }
}

_id_59B361B4522EB994(point, radius) {
  agents = _id_F9BE7C5A6BCBED61(point, radius);
  _id_15503470668BF60A = [];
  _id_8FA87D2C8780E014 = radius * radius;

  foreach(agent in agents) {
    _id_457471485336C961 = distancesquared(agent.origin, point);

    if(_id_457471485336C961 < _id_8FA87D2C8780E014)
      _id_15503470668BF60A[_id_15503470668BF60A.size] = agent;
  }

  return _id_15503470668BF60A;
}

_id_F9BE7C5A6BCBED61(point, distance) {
  contents = physics_createcontents(["physicscontents_characterproxy"]);
  _id_B65B7AEAB526E1AC = (distance, distance, distance);
  _id_80745CF3E2877DF5 = point - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = point + _id_B65B7AEAB526E1AC;
  hits = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, contents, []);
  return hits;
}

_id_82BB896A0ADA90E7() {
  _id_2902155747C5C4FE::registerhandlecommand(::_id_B50BE56905600239);
  level thread _id_DB5C75F2A84FF03D();
}

_id_DB5C75F2A84FF03D() {
  level endon("game_ended");

  while(!isDefined(level.player))
    waitframe();
}

_id_B50BE56905600239(_id_10D8148F3496F8DE, _id_434809FD34BABEE0) {
  _id_15A18DD2DD7ED5DA = "";

  switch (_id_10D8148F3496F8DE) {
    case "rmbl_give_killmonger_powerup":
      level.player _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("killmonger");
      break;
    case "rmbl_spawn_killmonger_powerup":
      _id_2AE01F9836C08415 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      spawnscriptable("brloot_rumble_powerup_killmonger", _id_2AE01F9836C08415);
      break;
    case "rmbl_give_teammate_killmonger_powerup":
      _id_A369F87F8A7A9868 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      _id_A369F87F8A7A9868 = scripts\engine\utility::array_remove(_id_A369F87F8A7A9868, level.player);
      _id_A369F87F8A7A9868[randomintrange(0, _id_A369F87F8A7A9868.size)] _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("killmonger");
      break;
    case "rmbl_give_enemy_killmonger_powerup":
      _id_FF8BD721AF677C90 = scripts\engine\utility::ter_op(level.player.team == "axis", "allies", "axis");
      _id_A369F87F8A7A9868 = scripts\mp\utility\teams::getteamdata(_id_FF8BD721AF677C90, "players");
      _id_A369F87F8A7A9868[randomintrange(0, _id_A369F87F8A7A9868.size)] _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("killmonger");
      break;
  }
}