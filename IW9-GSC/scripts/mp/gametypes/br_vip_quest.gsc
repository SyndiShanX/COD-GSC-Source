/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vip_quest.gsc
*************************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_9462BDE338826062 = spawnStruct();

  if(getdvarint("dvar_857923DD420FCA71", 0) != 0)
    level._id_9462BDE338826062.time = getdvarint("dvar_857923DD420FCA71", 0);
  else
    level._id_9462BDE338826062.time = _id_64ACB6CE534155B7::_id_B891F0C9814330EB("vip");

  level._id_9462BDE338826062._id_C2C8C3079F1AEC6D = getdvarint("dvar_E56F8B72F908D508", 10);
  level._id_9462BDE338826062._id_117657C0F68E1BC9 = getdvarint("dvar_7516DC47CAE07042", 5);
  level._id_9462BDE338826062._id_89C35EB8C5FACCED = getdvarint("dvar_1C2F5C6B8B707647", 5000);
  level._id_9462BDE338826062._id_82CDD9A952D2158F = getdvarfloat("dvar_AE31AB19DC1F419F", 2.0);
  level._id_9462BDE338826062._id_F7DD2C06F9C5E900 = getdvarvector("dvar_BCF9637617EBFF0F", (0, 0, 100));
  level._id_020A27CB632A1025 = getdvarint("dvar_80075250030DE146", 1);
  level._id_1AB43167AEA344DE = [];
  game["dialog"]["hvt_accept"] = "chw2_wzan_tmmm";
  game["dialog"]["mission_hvt_accept_first_person"] = "chw2_wzan_plmr";
  game["dialog"]["mission_hvt_success_third_person"] = "chw2_wzan_tmma";
  game["dialog"]["mission_hvt_success_first_person"] = "chw2_wzan_plal";
  game["dialog"]["mission_hvt_failure"] = "chw2_wzan_plfl";
  game["dialog"]["mission_hvt_eliminated"] = "chw2_wzan_tmsc";
  game["dialog"]["mission_hvt_attacker"] = "chw2_wzan_plsc";
  data.funcs["onInit"] = ::_id_56EFD5B49CF193C6;
  data.funcs["onTeamAssigned"] = ::_id_91DD8857CC89DC9D;
  data.funcs["onEnterGulag"] = ::_id_CA07A6CA5C3C8AF5;
  data.funcs["onPlayerRespawn"] = ::_id_F6755BD234F8E261;
  data.funcs["onPlayerTearDown"] = ::_id_83D3732A571F142A;
  data.funcs["onPlayerAssimilated"] = ::_id_75B53AD947495F9C;
  data.funcs["onPlayerKilled"] = ::_id_A2045D8CAF0F792F;
  data.funcs["onPlayerDisconnect"] = ::_id_319BA124F0EC457C;
  data.funcs["onCancel"] = ::_id_AFD4BF63773CD7AD;
  data.funcs["onTimerExpired"] = ::_id_CA105FBCFD06AFE0;
  data.funcs["onCacheLooted"] = ::_id_18D88924744A578B;
  data.funcs["onAIKilled"] = ::_id_21A950B07D1782A1;

  if(getdvarint("dvar_6507162DEBBEA8B1", 1)) {
    level._id_D26F170F2A84A12D = getdvarint("dvar_DFB936C58DCA50FE", 0) == 1;
    level._id_E0AB98FE607C2C4A = ::_id_FB2C20EE6AF70024;
    level.brgametype._id_18D6D995986CA7BE = getdvarint("dvar_BA328273947A14B9", 3);

    if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse"))
      scripts\cp_mp\utility\script_utility::registersharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse", _id_261E315C49E5E4EF::_id_3241AFDFEC957CB9);
  }
}

_id_56EFD5B49CF193C6() {
  return 1;
}

_id_91DD8857CC89DC9D() {
  self.category = "vip";
  self.vip = self._id_0D154AC2657C5F44;
  self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(1);
  level._id_1AB43167AEA344DE[level._id_1AB43167AEA344DE.size] = self.vip;
  _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.vip.origin + level._id_9462BDE338826062._id_F7DD2C06F9C5E900);
  _func_D76CC64B205084A3(self.objectiveiconid, 1);
  viphud_setupvisibility();
  time = level._id_9462BDE338826062.time;
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_A4907641A754C6A8();

  if(istrue(level._id_020A27CB632A1025))
    _id_23BADE24BA278B75(self.vip);

  _id_6D5ED003AF1F9612 = scripts\engine\utility::array_remove(scripts\mp\utility\teams::getteamdata(self.vip.team, "players"), self.vip);
  _id_64ACB6CE534155B7::displaysplashtoplayers(_id_6D5ED003AF1F9612, "br_vip_quest_start_vip_team");
  _id_64ACB6CE534155B7::displayplayersplash(self.vip, "br_vip_quest_start_tablet_finder");
  _id_AC4C51BF033F6323 = [];

  foreach(player in level.players) {
    if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player) && player.team != self.vip.team && distance2d(player.origin, self.vip.origin) <= level._id_9462BDE338826062._id_89C35EB8C5FACCED)
      _id_AC4C51BF033F6323[_id_AC4C51BF033F6323.size] = player;
  }

  _id_64ACB6CE534155B7::displaysplashtoplayers(_id_AC4C51BF033F6323, "br_vip_quest_vip_spawn_alert");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("hvt_accept", 1, _id_6D5ED003AF1F9612, undefined, 2);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_hvt_accept_first_person", self.vip, 1, undefined, 2);
}

_id_CA07A6CA5C3C8AF5(player) {
  if(!_id_42A0806457EA8039(player))
    _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
}

_id_F6755BD234F8E261(player) {
  if(!_id_42A0806457EA8039(player))
    _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
  else
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(self.vip getentitynumber());
}

_id_83D3732A571F142A(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    player _id_64ACB6CE534155B7::uiobjectivehide();
    _id_64ACB6CE534155B7::showquestobjicontoplayer(player);

    if(isDefined(self.vip)) {
      if(player == self.vip) {
        if(self.teams[0].size > 0) {
          _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_vip_quest_failure");
          level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", _id_8A04AA0E0755E7E3, 1, 2);
        }

        self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
        thread _id_761664D012E7F359(0);
      }
    }
  }
}

_id_75B53AD947495F9C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_EB06B338608EF354 == self.teams[0]) {
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
    player _id_64ACB6CE534155B7::uiobjectiveshow("vip");
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(self.vip getentitynumber());
    _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  }
}

_id_A2045D8CAF0F792F(attacker, victim) {
  if(isDefined(attacker)) {
    if(_id_42A0806457EA8039(attacker)) {
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B39BBFEF37B546C7");
      thread _id_64ACB6CE534155B7::_id_234C4428A084CA58(25);
    }
  }

  if(isDefined(self.vip)) {
    if(victim == self.vip) {
      if(isDefined(attacker)) {
        if(_id_42A0806457EA8039(attacker)) {
          _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_vip_quest_failure");
          self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
          level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);
          thread _id_761664D012E7F359(0);
          return;
        }

        rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("vip_killer", attacker.team, attacker);

        if(isDefined(rewards) && isDefined(rewards["plunder"]))
          _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_vip_quest_you_killed_the_vip", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("vip"), rewards["plunder"], attacker.team);

        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_hvt_eliminated", attacker.team, attacker, 1, undefined, 2);
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_hvt_attacker", attacker, 1, undefined, 2);
      }

      _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_vip_quest_failure");
      self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);

      if(getdvarint("dvar_6925BC8A469C1B7C", 1) == 1) {
        if(!istrue(level._id_D26F170F2A84A12D) || istrue(level._id_D26F170F2A84A12D) && isDefined(attacker) && attacker.team == victim.team) {
          if(isDefined(level._id_E0AB98FE607C2C4A))
            self thread[[level._id_E0AB98FE607C2C4A]](self.vip, 1);
        }
      }

      thread _id_761664D012E7F359(0);
    }
  }
}

_id_319BA124F0EC457C(player) {
  if(isDefined(self.vip)) {
    if(player == self.vip) {
      _id_64ACB6CE534155B7::displayteamsplash(self.teams[0], "br_vip_quest_failure");
      self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);
      thread _id_761664D012E7F359(0);
    }
  }
}

_id_18D88924744A578B(player, type) {
  if(_id_42A0806457EA8039(player)) {
    if(type != 2 && type != 6 && !(type >= 7 && type <= 12)) {
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_397015FA876E62B2");
      thread _id_64ACB6CE534155B7::_id_234C4428A084CA58(10);
    }
  }
}

_id_21A950B07D1782A1(player, agent) {
  if(_id_42A0806457EA8039(player) && isDefined(agent)) {
    if(agent.basearchetype == "juggernaut") {
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_72B19A656FDA2AD3");
      thread _id_64ACB6CE534155B7::_id_234C4428A084CA58(60);
    } else {
      player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_02B7F8B5419ED72E");
      thread _id_64ACB6CE534155B7::_id_234C4428A084CA58(10);
    }
  }
}

_id_42A0806457EA8039(player) {
  if(!isDefined(player.team) || !isDefined(self.teams[0]))
    return 0;

  if(player.team == self.teams[0])
    return 1;

  return 0;
}

_id_761664D012E7F359(success, results) {
  self notify("task_ended");
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);

  if(istrue(level._id_020A27CB632A1025) && isDefined(self.vip))
    self.vip _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();

  level._id_1AB43167AEA344DE = scripts\engine\utility::array_remove(level._id_1AB43167AEA344DE, self.vip);
  wait 1.0;
  self notify("task_ended");
  viphud_deletehud();
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined), results);
}

_id_CA105FBCFD06AFE0() {
  self endon("task_ended");
  level endon("game_ended");

  if(istrue(self._id_BCE96A69EC46B30A)) {
    return;
  }
  self._id_BCE96A69EC46B30A = 1;
  params = spawnStruct();
  params.intvar = 0;
  rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("vip", self.teams[0], self.vip);

  if(isDefined(rewards) && isDefined(rewards["plunder"]))
    _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_vip_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("vip"), rewards["plunder"], self.teams[0]);

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_hvt_success_third_person", self.teams[0], self.vip, 1, undefined, 2);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_hvt_success_first_person", self.vip, 1, undefined, 2);
  self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  vip_respawnplayer(player, self.vip, "vip");

  if(isDefined(level._id_E0AB98FE607C2C4A))
    self[[level._id_E0AB98FE607C2C4A]](self.vip, 1);

  thread _id_761664D012E7F359(1, rewards);
}

_id_AFD4BF63773CD7AD(team) {
  if(istrue(self.teams[0] == team)) {
    self.vip _id_2CEDCC356F1B9FC8::setplayermostwantedextrainfo(0);
    thread _id_761664D012E7F359(0);
  }
}

_id_A4907641A754C6A8() {
  self endon("task_ended");
  self.vip endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    wait(level._id_9462BDE338826062._id_82CDD9A952D2158F);
    _id_64ACB6CE534155B7::movequestobjicon(self.vip.origin + level._id_9462BDE338826062._id_F7DD2C06F9C5E900);
  }
}

viphud_setupvisibility() {
  foreach(player in level.players)
  _id_64ACB6CE534155B7::showquestobjicontoplayer(player);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players")) {
    if(!player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      viphud_showtoplayer(player);

    _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
  }
}

viphud_showtoplayer(player) {
  player _id_64ACB6CE534155B7::uiobjectiveshow("vip");
  player _id_64ACB6CE534155B7::uiobjectivesetparameter(self.vip getentitynumber());
  _id_64ACB6CE534155B7::showquestobjicontoplayer(player);
}

viphud_hidefromplayer(player) {
  player _id_64ACB6CE534155B7::uiobjectivehide();
  _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);
}

viphud_deletehud() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.teams[0], "players"))
  _id_64ACB6CE534155B7::hidequestobjiconfromplayer(player);

  _id_64ACB6CE534155B7::deletequestobjicon();
}

vip_respawnplayer(player, _id_4AC881E2A39322A5, _id_DF2FBB13C226BE75) {
  if(istrue(player.inlaststand))
    player scripts\mp\laststand::finishreviveplayer("use_hold_revive_success", player);
  else {
    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("vipRespawnPlayer")) {
      player thread _id_362C58E8BB39BCDA::runbrgametypefunc("vipRespawnPlayer", _id_4AC881E2A39322A5);
      return;
    }

    if(!isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      player thread _id_67708F418B1FAC79::playergulagautowin("vipRespawn", _id_4AC881E2A39322A5);
      return;
    }

    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      player thread _id_67708F418B1FAC79::playerpulloutofgulagwin(_id_4AC881E2A39322A5, _id_DF2FBB13C226BE75);
  }
}

_id_5F352FB76C54705C() {
  if(isDefined(level._id_1AB43167AEA344DE))
    return scripts\engine\utility::array_contains(level._id_1AB43167AEA344DE, self);

  return undefined;
}

_id_FB2C20EE6AF70024(player, delay) {
  playerorigin = player.origin;
  _id_3C70A7175FBFA3FC = player.angles;
  playerteam = player.team;
  _id_6677F0332E233970 = _id_89DD39B233D0A42D(player);

  if(isDefined(delay))
    wait(delay);

  if(isDefined(player)) {
    playerorigin = player.origin;
    _id_3C70A7175FBFA3FC = player.angles;
    playerteam = player.team;
  }

  forward = anglesToForward(_id_3C70A7175FBFA3FC);
  _id_88B83B0D7A43EA72 = randomfloatrange(0, 360);
  offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72) + (0, 200, 0);
  _id_FD12DA3B28ECEE11 = getclosestpointonnavmesh(playerorigin + offset);
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, playerteam, "legendary_supply_drop", _id_FD12DA3B28ECEE11 + (0, 0, 4096), (0, randomfloat(360), 0), _id_FD12DA3B28ECEE11, undefined, 1);
  crate.source = "vip_quest";
  crate._id_08C5EE84D75AB881 = _id_6677F0332E233970;
  id = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(id > -1) {
    _id_700AF519E13CDF9D = getdvarint("dvar_3F485FE18A08DE25", 4921);
    _id_508EFA10779D9FE4 = getdvarint("dvar_18160829D60F2E3C", 5906);
    scripts\mp\objidpoolmanager::objective_add_objective(id, "current", crate.origin, "ui_map_icon_supply_drop_yellow");
    objective_addalltomask(id);
    objective_showtoplayersinmask(id);
    objective_setbackground(id, 1);
    objective_onentity(id, crate);
    objective_setzoffset(id, 55);
    objective_setdescription(id, &"MP_BR_INGAME/REWARD_ICON_NAME_VIP");
    _func_C047D7FFE7A83501(id, _id_700AF519E13CDF9D, _id_508EFA10779D9FE4);
    _func_865F9C5D005F9A08(id, 1);
    crate.obj_id = id;
    level.brgametype thread _id_A7AE732B33F02A88(crate);

    if(!level.br_circle_disabled)
      crate thread _id_CA2A33089F625649(_id_FD12DA3B28ECEE11);
  }
}

_id_89DD39B233D0A42D(player) {
  rewards = [];
  _id_BCADD51D0CF0C1C3 = randomintrange(0, 10);

  if(_id_BCADD51D0CF0C1C3 > 5)
    rewards[rewards.size] = "brloot_killstreak_supply_sweep";
  else
    rewards[rewards.size] = "brloot_killstreak_scramblerdrone";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() == "plunder") {
    _id_2F360E8A02E0A672 = randomintrange(0, 20);

    if(_id_2F360E8A02E0A672 > 14)
      rewards[rewards.size] = "brloot_plunder_cash_uncommon_2";
    else if(_id_2F360E8A02E0A672 > 9)
      rewards[rewards.size] = "brloot_plunder_cash_uncommon_3";
    else if(_id_2F360E8A02E0A672 > 4)
      rewards[rewards.size] = "brloot_plunder_cash_rare_1";
    else
      rewards[rewards.size] = "brloot_plunder_cash_rare_2";
  }

  rewards[rewards.size] = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() == "plunder")
    _id_B1F627237929640E = ["brloot_self_revive", "brloot_plunder_extract", "brloot_valuable_goldbar"];
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() == "zxp")
    _id_B1F627237929640E = ["brloot_super_reinforcementflare", "brloot_self_revive"];
  else
    _id_B1F627237929640E = ["brloot_super_reinforcementflare", "brloot_equip_gasmask", "brloot_equip_gasmask_durable"];

  rewards[rewards.size] = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_B1F627237929640E);
  _id_28AEBE3DD6733ED3 = _id_724736FCF0FB6604::br_ammo_type_for_weapon(player.primaryweaponobj);

  if(!isDefined(_id_28AEBE3DD6733ED3)) {
    _id_AC384A310FB79ED9 = randomint(5);
    _id_28AEBE3DD6733ED3 = _id_724736FCF0FB6604::_id_5A80DBA504420037(_id_AC384A310FB79ED9);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype._id_18D6D995986CA7BE; _id_AC0E594AC96AA3A8++)
    rewards[rewards.size] = _id_28AEBE3DD6733ED3;

  return scripts\engine\utility::array_randomize(rewards);
}

_id_A7AE732B33F02A88(crate) {
  level endon("game_ended");
  id = crate.obj_id;

  while(isDefined(crate))
    waitframe();

  if(isDefined(id))
    scripts\mp\objidpoolmanager::returnobjectiveid(id);

  crate notify("vip_crate_gas");
}

_id_CA2A33089F625649(origin) {
  level endon("game_ended");
  self endon("vip_crate_gas");
  _id_B68217195E5CF6D2 = _id_58F20490049AF6AC::_id_60951B84C58915AB(origin);
  _id_6CD08FE827AF3392 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_B68217195E5CF6D2);
  wait(_id_6CD08FE827AF3392);

  if(isDefined(self.obj_id))
    scripts\mp\objidpoolmanager::update_objective_state(self.obj_id, "active");
}

_id_2410E069C697BA3C(player) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  foreach(item in self._id_08C5EE84D75AB881) {
    if(_id_552B8E4EA5FF7DF1::canspawnitemname(item)) {
      _id_A69FFF5222862F26 = level.br_pickups.br_itemrarity[item];
      legendary = 0;

      if(isDefined(_id_A69FFF5222862F26) && _id_A69FFF5222862F26 == 4)
        legendary = 1;

      _id_552B8E4EA5FF7DF1::lootspawnitem(item, dropstruct, self.origin, self.angles, 0, legendary);
    }
  }

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F396D39FEE1A8054");
  player playsoundtoplayer("uin_loot_container_open_epic", player);
}

_id_23BADE24BA278B75(player) {
  _id_67572A1BE4AEE419 = scripts\cp_mp\utility\player_utility::isinvehicle();

  if(!istrue(_id_67572A1BE4AEE419))
    player _id_1E4A61DB11011446::_id_8D739EC62C568C41("prop_zc_game_flag");

  thread _id_27A664F8E34CADD7(_id_67572A1BE4AEE419, player);
}

_id_27A664F8E34CADD7(_id_67572A1BE4AEE419, player) {
  level endon("game_ended");
  self endon("task_ended");
  player endon("death_or_disconnect");

  for(;;) {
    if(!istrue(_id_67572A1BE4AEE419)) {
      player waittill("vehicle_enter");
      player _id_1E4A61DB11011446::_id_96D6B5E51DD4A63B();
    }

    player waittill("vehicle_exit");
    _id_67572A1BE4AEE419 = 0;
    player _id_1E4A61DB11011446::_id_8D739EC62C568C41("prop_zc_game_flag");
  }
}