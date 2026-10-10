/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_vip_quest.gsc
****************************************************/

#using script_261e315c49e5e4ef;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_vip_quest;

function getcontractdata(data) {
  level.vipprops = spawnStruct();
  var_ad60abb5340e959d = getdvarint(@ "hash_857923dd420fca71", 0);
  level.vipprops.time = var_ad60abb5340e959d != 0 ? var_ad60abb5340e959d : function_ea591c2a379e3424("vip");
  level.vipprops.var_c2c8c3079f1aec6d = getdvarint(@ "hash_e56f8b72f908d508", 10);
  level.vipprops.var_117657c0f68e1bc9 = getdvarint(@ "hash_7516dc47cae07042", 5);
  level.vipprops.notifyrange = getdvarint(@ "hash_1c2f5c6b8b707647", 5000);
  level.vipprops.var_82cdd9a952d2158f = getdvarfloat(@ "hash_ae31ab19dc1f419f", 2);
  level.vipprops.var_f7dd2c06f9c5e900 = getdvarvector(@ "hash_bcf9637617ebff0f", (0, 0, 100));
  level.vipprops.var_7f9ddce547423dbb = 21;
  level.vipprops.var_5c606368d744097d = 0;
  level.var_20a27cb632a1025 = getdvarint(@ "hash_80075250030de146", 1);
  level.var_1ab43167aea344de = [];
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["hvt_accept"] = "mstw_grav_tmrr";

  if(getDvar(@ "ui_gametype", "") != "limbo") {
    game["dialog"]["mission_hvt_accept_first_person"] = "mstw_grav_plmr";
  }

  game["dialog"]["mission_hvt_success_third_person"] = "mstw_grav_tmml";
  game["dialog"]["mission_hvt_success_first_person"] = "mstw_grav_plrs";
  game["dialog"]["mission_hvt_success_first_person_crate"] = "mstw_grav_srwr";
  game["dialog"]["mission_hvt_failure"] = "mstw_grav_tmfl";
  game["dialog"]["mission_hvt_eliminated"] = "mstw_grav_tmsr";
  game["dialog"]["mission_hvt_attacker"] = "mstw_grav_plsr";
  data.funcs["onInit"] = &function_56efd5b49cf193c6;
  data.funcs["onTeamAssigned"] = &function_91dd8857cc89dc9d;
  data.funcs["onEnterGulag"] = &function_ca07a6ca5c3c8af5;
  data.funcs["onPlayerRespawn"] = &function_f6755bd234f8e261;
  data.funcs["onPlayerTearDown"] = &function_83d3732a571f142a;
  data.funcs["onPlayerAssimilated"] = &function_75b53ad947495f9c;
  data.funcs["onPlayerKilled"] = &quest_onplayerkilled;
  data.funcs["onPlayerDisconnect"] = &quest_onplayerdisconnect;
  data.funcs["onCancel"] = &quest_oncancel;
  data.funcs["onTimerExpired"] = &function_ca105fbcfd06afe0;
  data.funcs["onCacheLooted"] = &function_18d88924744a578b;
  data.funcs["onAIKilled"] = &function_21a950b07d1782a1;
  data.funcs["onFinishContract"] = &function_68046efe0486e9b;
  data.basetime = level.vipprops.time;

  if(getdvarint(@ "hash_6507162debbea8b1", 1)) {
    level.var_d26f170f2a84a12d = getdvarint(@ "hash_dfb936c58dca50fe", 0) == 1;
    level.var_e0ab98fe607c2c4a = &function_fb2c20ee6af70024;
    level.brgametype.var_18d6d995986ca7be = getdvarint(@ "hash_ba328273947a14b9", 3);

    if(!scripts\engine\utility::issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse")) {
      scripts\engine\utility::registersharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse", &namespace_f51c41a139e03299::function_3241afdfec957cb9);
    }
  }
}

function function_56efd5b49cf193c6() {
  return true;
}

function function_91dd8857cc89dc9d() {
  self.category = "vip";
  self.vip = self.var_d154ac2657c5f44;
  self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(1);
  level.var_1ab43167aea344de[level.var_1ab43167aea344de.size] = self.vip;
  createquestobjicon("ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.vip.origin + level.vipprops.var_f7dd2c06f9c5e900);
  objective_disableping(self.objectiveiconid, 1);
  viphud_setupvisibility();
  time = level.vipprops.time;
  time = function_9b6275085fbcb8f4(time);
  function_5a15174d34f0670c(time);
  thread function_a4907641a754c6a8();

  if(istrue(level.var_20a27cb632a1025)) {
    function_23bade24ba278b75(self.vip);
  }

  teammates = array_remove(getteamdata(self.vip.team, "players"), self.vip);
  displaysplashtoplayers(teammates, "br_vip_quest_start_vip_team");
  displayplayersplash(self.vip, "br_vip_quest_start_tablet_finder");
  var_ac4c51bf033f6323 = [];

  foreach(player in level.players) {
    if(!player scripts\mp\gametypes\br_public::isplayeringulag() && isreallyalive(player) && player.team != self.vip.team && distance2d(player.origin, self.vip.origin) <= level.vipprops.notifyrange) {
      var_ac4c51bf033f6323[var_ac4c51bf033f6323.size] = player;
    }
  }

  displaysplashtoplayers(var_ac4c51bf033f6323, "br_vip_quest_vip_spawn_alert");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("hvt_accept", 1, teammates, undefined, 2, undefined, "dx_br_jpbm_");
  level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_hvt_accept_first_person", self.vip, 1, undefined, 2, undefined, "dx_br_jpbm_");
}

function function_ca07a6ca5c3c8af5(player) {
  if(!function_42a0806457ea8039(player)) {
    hidequestobjiconfromplayer(player);
  }
}

function function_f6755bd234f8e261(player) {
  if(!function_42a0806457ea8039(player)) {
    showquestobjicontoplayer(player);
    return;
  }

  player uiobjectivesetparameter(self.vip getentitynumber());
}

function function_83d3732a571f142a(player, oldteam, newteam) {
  if(oldteam == self.teams[0]) {
    player uiobjectivehide();
    showquestobjicontoplayer(player);

    if(isDefined(self.vip)) {
      if(player == self.vip) {
        if(self.teams[0].size > 0) {
          displayteamsplash(self.teams[0], "br_vip_quest_failure");
          level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_gen_fail", oldteam, 1, 2);
        }

        self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
        thread function_761664d012e7f359(0, undefined, "Assimilation");
      }
    }
  }
}

function function_75b53ad947495f9c(player, oldteam, newteam) {
  if(newteam == self.teams[0]) {
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
    player uiobjectiveshow("vip");
    player uiobjectivesetparameter(self.vip getentitynumber());
    hidequestobjiconfromplayer(player);
  }
}

function quest_onplayerkilled(attacker, victim) {
  if(isDefined(attacker)) {
    if(function_42a0806457ea8039(attacker)) {
      attacker thread scripts\mp\utility\points::doscoreevent(#"hash_b39bbfef37b546c7");
      thread function_234c4428a084ca58(25);
    }
  }

  if(isDefined(self.vip)) {
    if(victim == self.vip) {
      if(isDefined(attacker)) {
        if(function_42a0806457ea8039(attacker)) {
          displayteamsplash(self.teams[0], "br_vip_quest_failure");
          self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
          level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);
          thread function_761664d012e7f359(0, undefined, "Suicide");
          return;
        }

        rewards = function_6ddd1eecbe562acf("vip" + "_killer", attacker.team, attacker);

        if(isDefined(rewards) && isDefined(rewards["plunder"])) {
          function_878ebcc241b54505("br_vip_quest_you_killed_the_vip", function_3d262d56274bd22e("vip"), rewards["plunder"], attacker.team);
        }

        level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("mission_hvt_eliminated", attacker.team, attacker, 1, undefined, 2, undefined, "dx_br_jpbm_");
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_hvt_attacker", attacker, 1, undefined, 2, undefined, "dx_br_jpbm_");
      }

      displayteamsplash(self.teams[0], "br_vip_quest_failure");
      self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);

      if(getdvarint(@ "hash_6925bc8a469c1b7c", 1) == 1) {
        if(!istrue(level.var_d26f170f2a84a12d) || istrue(level.var_d26f170f2a84a12d) && isDefined(attacker) && attacker.team == victim.team) {
          if(isDefined(level.var_e0ab98fe607c2c4a)) {
            self thread[[level.var_e0ab98fe607c2c4a]](self.vip, 1);
          }
        }
      }

      thread function_761664d012e7f359(0, undefined, "Killed");
    }
  }
}

function quest_onplayerdisconnect(player) {
  if(isDefined(self.vip)) {
    if(player == self.vip) {
      displayteamsplash(self.teams[0], "br_vip_quest_failure");
      self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_hvt_failure", self.teams[0], 1, 2);
      thread function_761664d012e7f359(0, undefined, "Vanished");
    }
  }
}

function function_18d88924744a578b(player, type) {
  if(function_42a0806457ea8039(player)) {
    if(type != 2 && type != 6 && !(type >= 7 && type <= 12)) {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_397015fa876e62b2");
      thread function_234c4428a084ca58(10);
    }
  }
}

function function_21a950b07d1782a1(player, agent) {
  if(function_42a0806457ea8039(player) && isDefined(agent)) {
    if(agent.basearchetype == "juggernaut") {
      player thread scripts\mp\utility\points::doscoreevent(#"hash_72b19a656fda2ad3");
      thread function_234c4428a084ca58(60);
      return;
    }

    player thread scripts\mp\utility\points::doscoreevent(#"hash_2b7f8b5419ed72e");
    thread function_234c4428a084ca58(10);
  }
}

function function_761664d012e7f359(success, results, endstate) {
  self notify("task_ended");
  level notify("calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid);

  if(istrue(level.var_20a27cb632a1025) && isDefined(self.vip)) {
    self.vip scripts\mp\gametypes\br::function_96d6b5e51dd4a63b();
  }

  level.var_1ab43167aea344de = array_remove(level.var_1ab43167aea344de, self.vip);
  wait 1;
  self notify("task_ended");
  viphud_deletehud();
  endcontract(ter_op(istrue(success), self.teams[0], undefined), results, undefined, endstate);
}

function function_ca105fbcfd06afe0() {
  self endon("task_ended");
  level endon("game_ended");

  if(istrue(self.timerended)) {
    return;
  }

  self.timerended = 1;

  if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "plunder" || istrue(level.maxteamsize == 1)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("mission_hvt_success_third_person", self.teams[0], self.vip, 1, undefined, 2);
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_hvt_success_first_person_crate", self.vip, 1, undefined, 2, undefined, "dx_br_jpbm_");
  } else {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("mission_hvt_success_third_person", self.teams[0], self.vip, 1, undefined, 2);
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_hvt_success_first_person", self.vip, 1, undefined, 2, undefined, "dx_br_jpbm_");
  }

  self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
  finishcontract(self);
}

function quest_oncancel(team) {
  if(istrue(self.teams[0] == team)) {
    self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo(0);
    thread function_761664d012e7f359(0, undefined, "Cancel");
  }
}

function function_68046efe0486e9b(contract, instance, team) {
  rewards = function_d212a5e7a40d7c8d("vip", contract.teams[0], contract.vip, contract);

  if(isDefined(rewards) && isDefined(rewards["plunder"])) {
    function_878ebcc241b54505("br_vip_quest_complete", function_3d262d56274bd22e("vip"), rewards["plunder"], contract.teams[0]);
  }

  foreach(player in getteamdata(contract.teams[0], "players")) {
    vip_respawnplayer(player, contract.vip, "vip");
  }

  if(isDefined(level.var_e0ab98fe607c2c4a)) {
    contract[[level.var_e0ab98fe607c2c4a]](contract.vip, 1);
  }

  contract thread function_761664d012e7f359(1, rewards, "Win");
}

function function_a4907641a754c6a8() {
  self endon("task_ended");
  self.vip endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    wait level.vipprops.var_82cdd9a952d2158f;
    movequestobjicon(self.vip.origin + level.vipprops.var_f7dd2c06f9c5e900);
  }
}

function viphud_setupvisibility() {
  foreach(player in level.players) {
    showquestobjicontoplayer(player);
  }

  foreach(player in getteamdata(self.teams[0], "players")) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      viphud_showtoplayer(player);
    }

    hidequestobjiconfromplayer(player);
  }
}

function viphud_showtoplayer(player) {
  player uiobjectiveshow("vip");
  player uiobjectivesetparameter(self.vip getentitynumber());
  showquestobjicontoplayer(player);
}

function viphud_hidefromplayer(player) {
  player uiobjectivehide();
  hidequestobjiconfromplayer(player);
}

function viphud_deletehud() {
  foreach(player in getteamdata(self.teams[0], "players")) {
    hidequestobjiconfromplayer(player);
  }

  deletequestobjicon();
}

function vip_respawnplayer(player, sponsor, var_df2fbb13c226be75) {
  if(istrue(player.inlaststand)) {
    player scripts\mp\laststand::finishreviveplayer("use_hold_revive_success", player);
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("vipRespawnPlayer")) {
    player thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("vipRespawnPlayer", sponsor);
    return;
  }

  if(!isalive(player) && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    player thread scripts\mp\gametypes\br_gulag::playergulagautowin("vipRespawn", sponsor, undefined, undefined, undefined, undefined, undefined, "vipRespawn");
    return;
  }

  if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    player thread scripts\mp\gametypes\br_gulag::playerpulloutofgulagwin(sponsor, var_df2fbb13c226be75);
  }
}

function function_5f352fb76c54705c() {
  if(isDefined(level.var_1ab43167aea344de)) {
    return array_contains(level.var_1ab43167aea344de, self);
  }

  return undefined;
}

function function_fb2c20ee6af70024(player, delay) {
  playerorigin = player.origin;
  playerangles = player.angles;
  playerteam = player.team;

  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(player)) {
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
  }

  forward = anglesToForward(playerangles);
  var_88b83b0d7a43ea72 = randomfloatrange(0, 360);
  offset = rotatepointaroundvector((0, 0, 1), forward, var_88b83b0d7a43ea72) + (0, 200, 0);
  drop_point = getclosestpointonnavmesh(playerorigin + offset);
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, playerteam, "legendary_supply_drop", drop_point + (0, 0, 4096), (0, randomfloat(360), 0), drop_point);
  crate.source = "vip_quest";
  crate.skipminimapicon = 1;
  crate.item_rewards = getscriptcachecontents("br_quest_vip_crate", level.vipprops.var_5c606368d744097d);

  if(level.maxteamsize == 1 && getdvarint(@ "hash_eeda2ab8e7d694fb", 1)) {
    for(i = 0; i < crate.item_rewards.size; i++) {
      if(crate.item_rewards[i] == "brloot_gulag_token") {
        crate.item_rewards[i] = "brloot_redeploy_token";
      }
    }
  }

  level.vipprops.var_5c606368d744097d += 1;

  if(level.vipprops.var_5c606368d744097d >= level.vipprops.var_7f9ddce547423dbb) {
    level.vipprops.var_5c606368d744097d = 0;
  }

  id = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(id > -1) {
    crate setscriptablepartstate("objective_map", "hidden");
    fadestart = getdvarint(@ "hash_3f485fe18a08de25", 4921);
    fadeend = getdvarint(@ "hash_18160829d60f2e3c", 5906);
    scripts\mp\objidpoolmanager::objective_add_objective(id, "current", crate.origin, "ui_map_icon_supply_drop_yellow");
    objective_addalltomask(id);
    objective_showtoplayersinmask(id);
    objective_setbackground(id, 1);
    objective_onentity(id, crate);
    objective_setzoffset(id, 75);
    objective_setdescription(id, &"MP_BR_INGAME/REWARD_ICON_NAME_VIP");
    function_c047d7ffe7a83501(id, fadestart, fadeend);
    function_865f9c5d005f9a08(id, 1);
    crate.scriptedobjid = id;
    level.brgametype thread function_a7ae732b33f02a88(crate);

    if(!level.br_circle_disabled) {
      crate thread function_ca2a33089f625649(drop_point);
    }
  }
}

function function_89dd39b233d0a42d(player) {
  rewards = [];
  var_bcadd51d0cf0c1c3 = randomintrange(0, 10);

  if(var_bcadd51d0cf0c1c3 > 5) {
    rewards[rewards.size] = "brloot_killstreak_supply_sweep";
  } else {
    rewards[rewards.size] = "brloot_killstreak_scramblerdrone";
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() == "plunder") {
    var_2f360e8a02e0a672 = randomintrange(0, 20);

    if(var_2f360e8a02e0a672 > 14) {
      rewards[rewards.size] = "brloot_plunder_cash_uncommon_2";
    } else if(var_2f360e8a02e0a672 > 9) {
      rewards[rewards.size] = "brloot_plunder_cash_uncommon_3";
    } else if(var_2f360e8a02e0a672 > 4) {
      rewards[rewards.size] = "brloot_plunder_cash_rare_1";
    } else {
      rewards[rewards.size] = "brloot_plunder_cash_rare_2";
    }
  }

  rewards[rewards.size] = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() == "plunder") {
    poweritems = ["brloot_self_revive", "brloot_plunder_extract", "brloot_valuable_goldbar"];
  } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() == "zxp") {
    poweritems = ["brloot_super_reinforcement_flare", "brloot_self_revive"];
  } else {
    poweritems = ["brloot_self_revive", "brloot_equip_gasmask", "brloot_equip_gasmask_durable"];
  }

  rewards[rewards.size] = array_random(poweritems);
  var_28aebe3dd6733ed3 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(player.primaryweaponobj);

  if(!isDefined(var_28aebe3dd6733ed3)) {
    ammoindex = randomint(5);
    var_28aebe3dd6733ed3 = scripts\mp\gametypes\br_weapons::function_5a80dba504420037(ammoindex);
  }

  for(i = 0; i < level.brgametype.var_18d6d995986ca7be; i++) {
    rewards[rewards.size] = var_28aebe3dd6733ed3;
  }

  return array_randomize(rewards);
}

function function_a7ae732b33f02a88(crate) {
  level endon("game_ended");
  id = crate.scriptedobjid;

  while(isDefined(crate)) {
    waitframe();
  }

  crate notify("vip_crate_gas");
}

function function_ca2a33089f625649(origin) {
  level endon("game_ended");
  self endon("vip_crate_gas");
  crate_timeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab(origin);
  var_6cd08fe827af3392 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852(crate_timeline);
  wait var_6cd08fe827af3392;

  if(isDefined(self.scriptedobjid)) {
    scripts\mp\objidpoolmanager::update_objective_state(self.scriptedobjid, "active");
  }
}

function function_2410e069c697ba3c(player) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  if(isDefined(self.item_rewards)) {
    foreach(item in self.item_rewards) {
      if(scripts\mp\gametypes\br_lootcache::canspawnitemname(item)) {
        raritynum = level.br_pickups.br_itemrarity[item];
        legendary = 0;

        if(isDefined(raritynum) && raritynum == 4) {
          legendary = 1;
        }

        scripts\mp\gametypes\br_lootcache::lootspawnitem(item, dropstruct, self.origin, self.angles, 0, legendary);
      }
    }
  }

  player thread scripts\mp\utility\points::doscoreevent(#"hash_f396d39fee1a8054");
  player playsoundtoplayer("uin_loot_container_open_epic", player);
}

function function_23bade24ba278b75(player) {
  playerisinvehicle = scripts\cp_mp\utility\player_utility::isinvehicle();

  if(!istrue(playerisinvehicle)) {
    player scripts\mp\gametypes\br::function_8d739ec62c568c41("prop_zc_game_flag");
  }

  thread function_27a664f8e34cadd7(playerisinvehicle, player);
  thread function_2d8bc1d8c7610a55(player);
}

function function_27a664f8e34cadd7(playerisinvehicle, player) {
  level endon("game_ended");
  self endon("task_ended");
  player endon("death_or_disconnect");

  while(true) {
    if(!istrue(playerisinvehicle)) {
      player waittill("vehicle_enter");
      player scripts\mp\gametypes\br::function_96d6b5e51dd4a63b();
    }

    player waittill("vehicle_exit");
    playerisinvehicle = 0;
    player scripts\mp\gametypes\br::function_8d739ec62c568c41("prop_zc_game_flag");
  }
}

function function_2d8bc1d8c7610a55(player) {
  self endon("task_ended");
  player endon("death_or_disconnect");
  level waittill("game_ended");
  player scripts\mp\gametypes\br::function_96d6b5e51dd4a63b();
}