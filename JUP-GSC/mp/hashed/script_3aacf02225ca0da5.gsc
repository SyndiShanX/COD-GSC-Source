/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3aacf02225ca0da5.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_f3c34c81dcc60eda;

function autoexec init() {
  wcenabled = getmatchrulesdata("brData", "wcEnabled");

  if(!istrue(wcenabled)) {
    return;
  }

  wcdata = getmatchrulesdata("brData", "wcData");

  if(!isDefined(wcdata) || wcdata == "") {
    return 0;
  }

  wcbundlename = hashcat(%"hash_31706c654b9d3b54", wcdata);
  var_53f1209f53f48f29 = getscriptbundle(wcbundlename);
  level.var_53f1209f53f48f29 = var_53f1209f53f48f29;
  level.var_71710256253c76be = gettime();
  level.var_bfcb6f843adf3368 = gettime();
  level.var_e2b5942176a926a = getdvarint(@ "hash_34c8c5cc6250285a", 7) * 1000;
  callback::add(#"hash_c15c682d6a5dcae0", &onplayerentergulag);
  callback::add(#"hash_438552ad6e5b08a0", &function_3b3d0d8621983ff4);
  game["dialog"]["weaponcase_myTeam_found"] = "flyb_grav_brwe";
}

function function_94b502046c767cd1() {
  if(isDefined(level.var_94b502046c767cd1)) {
    return level.var_94b502046c767cd1;
  }

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    level.var_94b502046c767cd1 = "no_one";
    return level.var_94b502046c767cd1;
  }

  if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702() || level.mapname == "mp_br_mechanics") {
    trainchance = getdvarint(@ "hash_5c2cb9fc4042e027", 40);

    if(trainchance > 0 && randomint(100) < trainchance) {
      level.var_94b502046c767cd1 = "train";
      return level.var_94b502046c767cd1;
    }
  }

  level.var_94b502046c767cd1 = "boss";
  return level.var_94b502046c767cd1;
}

function function_1bafb1f579534ef6(dropinfo, player, scriptablename) {
  if(isDefined(level.var_b220727281972841)) {
    return undefined;
  }

  function_f9ec88c3d71324cd(scriptablename);
  weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup(level.var_1e8771caf5122101, dropinfo, 1, 1);

  if(!isDefined(weaponcase)) {
    return undefined;
  }

  function_3e7ee85cb0d3504c(weaponcase, dropinfo.instance);
}

function function_3e7ee85cb0d3504c(scriptable, instance) {
  if(isDefined(level.var_b220727281972841)) {
    return;
  }

  function_f9ec88c3d71324cd(scriptable.type);
  level.var_b220727281972841 = spawnStruct();
  level.var_b220727281972841.scriptable = scriptable;
  level.var_b220727281972841.instance = instance;
  scriptable.criticalitem = 1;

  if(level.var_86b2cfc21b9abcf8) {
    function_9b0ef508769a0a0f(scriptable.origin);
  } else {
    level.var_b220727281972841.objidnum = -1;
  }

  function_147936bfe8fd8d7e(scriptable.origin);
}

function function_f9ec88c3d71324cd(scriptablename) {
  if(isDefined(level.var_1e8771caf5122101)) {
    return;
  }

  scriptablename = default_to(scriptablename, level.var_53f1209f53f48f29.scriptablename);
  level.var_1e8771caf5122101 = scriptablename;

  if(scriptablename == "brloot_weaponcase_black") {
    level.var_9a327d6ca5e25308 = 1;
  }

  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  scripts\engine\utility::registersharedfunc(scriptablename, "delete", &function_fbaa37f0a39a0d07);
  scripts\engine\utility::registersharedfunc(scriptablename, "dropped", &function_f69e3d324a1172c6);
  scripts\engine\utility::registersharedfunc(lootid, "addedToContainer", &function_22e6cb66ccb56285);
  scripts\engine\utility::registersharedfunc(lootid, "pickedUp", &function_803a95e4e6cd2538);
}

function private function_fbaa37f0a39a0d07() {
  if(isDefined(self.linkedparent) && self.linkedparent scripts\cp_mp\vehicles\vehicle::isvehicle() && self.linkedparent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() == "veh9_palfa") {
    return false;
  }

  contents = scripts\engine\trace::create_itemclip_contents();
  trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 10000), undefined, contents);

  if(!isDefined(trace["position"]) || !isDefined(trace["fraction"]) || trace["fraction"] >= 0.99 || scripts\mp\outofbounds::ispointinoutofbounds(trace["position"])) {
    onnavmesh = getclosestpointonnavmesh(self.origin);
    trace = scripts\engine\trace::ray_trace(onnavmesh, onnavmesh - (0, 0, 1000), undefined, contents);
  }

  if(!isDefined(trace["position"]) || !isDefined(trace["normal"]) || !isDefined(trace["fraction"]) || trace["fraction"] >= 0.99) {
    return false;
  }

  utility::function_cefc758e6b25a243();
  self.origin = trace["position"];
  return true;
}

function spawnweaponcase(player, dropstruct) {
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup(level.var_1e8771caf5122101, dropinfo, 1);
  function_f69e3d324a1172c6(weaponcase, player, dropinfo.origin);
  return weaponcase;
}

function private function_f69e3d324a1172c6(scriptable, owner, finalorigin) {
  assert(isDefined(owner));

  if(!isDefined(level.var_b220727281972841)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  level.var_b220727281972841.currentowner = undefined;
  level.var_b220727281972841.scriptable = scriptable;
  scriptable.criticalitem = 1;

  if(level.var_86b2cfc21b9abcf8 && level.var_b220727281972841.objidnum != -1) {
    level notify("interuptWeaponCaseShow");
    objective_setplayintro(level.var_b220727281972841.objidnum, 0);
    objective_disableping(level.var_b220727281972841.objidnum, istrue(level.var_53f1209f53f48f29.var_6342a4ff1d4cd212));
    scripts\mp\objidpoolmanager::function_df6a3e032fa07d22(level.var_b220727281972841.objidnum);
  }

  if(level.var_509664f56a31278f) {
    splash = level.var_53f1209f53f48f29.var_370a2e386a4e87c5;

    if(isDefined(splash) && splash != "") {
      teammates = array_remove(level.teamdata[owner.team]["players"], owner);
      showdmzsplash(splash, teammates, undefined, undefined, owner);
    }

    splash = level.var_53f1209f53f48f29.var_eb67bce2db34d570;

    if(isDefined(splash) && splash != "") {
      if(level.var_bfcb6f843adf3368 + level.var_e2b5942176a926a < gettime()) {
        level.var_bfcb6f843adf3368 = gettime();
        showdmzsplash(splash, [owner]);
      }
    }
  }

  function_d88e40b4707fdabd(owner, owner.health <= 0);
}

function private function_22e6cb66ccb56285(container, owner) {
  if(!isDefined(level.var_b220727281972841)) {
    assertmsg("<dev string:x5b>");
    return;
  }

  level.var_b220727281972841.currentowner = undefined;
  level.var_b220727281972841.scriptable = container;

  if(level.var_b220727281972841.objidnum != -1) {
    level notify("interuptWeaponCaseShow");
    objective_setplayintro(level.var_b220727281972841.objidnum, 0);
    objective_disableping(level.var_b220727281972841.objidnum, istrue(level.var_53f1209f53f48f29.var_10ba92c5298ab10b) || istrue(level.var_53f1209f53f48f29.var_6342a4ff1d4cd212));
    scripts\mp\objidpoolmanager::function_df6a3e032fa07d22(level.var_b220727281972841.objidnum);
  }
}

function private function_803a95e4e6cd2538(scriptable, player) {
  if(!isDefined(level.var_b220727281972841)) {
    function_f9ec88c3d71324cd("brloot_weaponcase_black");
    level.var_b220727281972841 = spawnStruct();
    level.var_b220727281972841.currentowner = player;

    if(level.var_86b2cfc21b9abcf8) {
      function_9b0ef508769a0a0f(player.origin);
    }
  }

  objid = level.var_b220727281972841.objidnum;
  var_2db2f4dfa0a0d05f = 0;

  if(!isDefined(level.var_b220727281972841.lastteam) || isDefined(player.team) && player.team != level.var_b220727281972841.lastteam) {
    if(objid != -1) {
      objective_setownerteam(objid, player.team);
      objective_setprogressteam(objid, player.team);
      objective_setpulsate(objid, 1);
    }

    if(level.var_509664f56a31278f) {
      var_2db2f4dfa0a0d05f = 1;
      defaultsplash = level.var_53f1209f53f48f29.pickedupsplash;

      if(isDefined(level.var_9d7687867d52ac75)) {
        defaultsplash = [[level.var_9d7687867d52ac75]]();
      }

      splash = ter_op(istrue(level.var_b220727281972841.pickedupbefore), level.var_53f1209f53f48f29.transfersplash, defaultsplash);
      level.var_b220727281972841.pickedupbefore = 1;

      if(isDefined(splash) && splash != "") {
        players = level.players;

        if(isDefined(level.var_53f1209f53f48f29.var_77e9cba9da41c3a1) && level.var_53f1209f53f48f29.var_77e9cba9da41c3a1 != "") {
          players = array_remove(level.players, player);
        }

        showdmzsplash(splash, players, scripts\mp\poi::function_6cc445c02b5effac(player.origin, undefined, undefined, 1));
      }

      level thread function_31a079a1fe9caa2(player);
    }

    if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1() && scripts\mp\pmc_missions::function_bebcefbd95a287ec(player)) {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("faction_e_fearless_on_weaponcase_pickup", player.team);
    } else {
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("weapon_case_pickup_self", player.team);
    }

    if(level.mapname != "mp_bio_lab") {
      scripts\cp_mp\overlord::playevent("weapon_case_pickup_enemy", array_difference(level.players, getteamdata(player.team, "players")));
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      exfils = getteamdata(player.team, "exfils");

      if(exfils.size > 0) {
        var_ef5c2361236a6ba9 = sortbydistance(exfils, player.origin)[0].ent;

        if(isDefined(var_ef5c2361236a6ba9)) {
          player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(18, var_ef5c2361236a6ba9.origin, < error objectid > .index, var_ef5c2361236a6ba9 getlinkedscriptableinstance());
        }
      }
    }
  }

  if(objid != -1) {
    if(istrue(level.var_53f1209f53f48f29.var_10ba92c5298ab10b) || istrue(level.var_53f1209f53f48f29.var_6342a4ff1d4cd212)) {
      objective_disableping(objid, istrue(level.var_53f1209f53f48f29.var_10ba92c5298ab10b) || istrue(level.var_53f1209f53f48f29.var_6342a4ff1d4cd212));
      scripts\cp_mp\calloutmarkerping::function_cd96f73dbca496b8(objid);
    }
  }

  if(level.var_509664f56a31278f) {
    splash = level.var_53f1209f53f48f29.var_a57c046cc112e52e;

    if(isDefined(splash) && splash != "") {
      teammates = array_remove(getteamdata(player.team, "players"), player);
      showdmzsplash(splash, teammates, undefined, undefined, player);
    }

    splash = level.var_53f1209f53f48f29.var_77e9cba9da41c3a1;

    if(isDefined(splash) && splash != "") {
      if(level.var_71710256253c76be + level.var_e2b5942176a926a < gettime()) {
        level.var_71710256253c76be = gettime();
        showdmzsplash(splash, [player]);
      }
    }
  }

  if(objid != -1 && !var_2db2f4dfa0a0d05f) {
    scripts\mp\objidpoolmanager::function_df6a3e032fa07d22(objid);
  }

  if(!isDefined(level.var_b220727281972841.lastteam) || level.var_b220727281972841.lastteam != player.team) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("weaponcase_myTeam_found", player.team, 1, 2, undefined);
  }

  level.var_b220727281972841.currentowner = player;
  level.var_b220727281972841.lastteam = player.team;
  level.var_b220727281972841.scriptable = undefined;
  function_ab9f38ae158a284c(player);
}

function isweaponcase(lootid) {
  if(!isDefined(level.var_1e8771caf5122101)) {
    return false;
  }

  wclootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(level.var_1e8771caf5122101);
  return lootid == wclootid;
}

function function_c320904c58171311() {
  if(hasweaponcase(self) && isalive(self) && !istrue(self.extracted) && !istrue(self.var_ded04cdd264a7e00)) {
    dropweaponcase();
  }
}

function dropweaponcase() {
  if(istrue(self.extracted)) {
    return;
  }

  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(self.origin, self.angles);
  weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup(level.var_1e8771caf5122101, dropinfo, 1);
  function_f69e3d324a1172c6(weaponcase, self, dropinfo.origin);
}

function private function_31a079a1fe9caa2(var_480f8576be141bb4) {
  objid = level.var_b220727281972841.objidnum;

  if(level.var_86b2cfc21b9abcf8 && objid != -1) {
    objective_setplayintro(level.var_b220727281972841.objidnum, 0);
    level notify("interuptWeaponCaseShow");
    level endon("interuptWeaponCaseShow");
    scripts\mp\objidpoolmanager::function_f5862ad1ad967602(objid);
    wait 3.8;
    objective_setplayintro(objid, 1);
    scripts\mp\objidpoolmanager::function_df6a3e032fa07d22(objid);
    waitframe();
    objective_setplayintro(objid, 0);
  }
}

function function_5704ab2a9381630f(player) {
  if(hasweaponcase(player)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level.var_b220727281972841.objidnum);
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("weapon_case_extract_self", player.team);
    scripts\cp_mp\overlord::playevent("weapon_case_extract_enemy", array_difference(level.players, getteamdata(player.team, "players")));
    level notify("weaponCase_extracted");
  }
}

function function_5a7168b0b511bec3(player) {
  return isDefined(level.var_8fc589b1edff1fb2) && istrue(level.var_8fc589b1edff1fb2[player.guid]);
}

function function_25a4b6a2083e2ab(players) {
  if(!isDefined(level.var_b220727281972841)) {
    return;
  }

  if(!isDefined(level.var_8fc589b1edff1fb2)) {
    level.var_8fc589b1edff1fb2 = [];
  }

  owner = level.var_b220727281972841.currentowner;

  if(isDefined(owner) && array_contains(players, owner)) {
    foreach(teammember in players) {
      if(!isDefined(teammember)) {
        continue;
      }

      if(!is_equal(teammember.team, owner.team)) {
        continue;
      }

      level.var_8fc589b1edff1fb2[teammember.guid] = 1;
    }

    var_d64bef4dd271a622 = array_remove_array(level.players, players);

    if(isDefined(level.var_b220727281972841.instance) && isDefined(level.var_b220727281972841.instance.bosstype)) {
      showdmzsplash("dmz_lootbox_extracted_" + level.var_b220727281972841.instance.bosstype, var_d64bef4dd271a622, owner.closestpoi);
      return;
    }

    showdmzsplash("dmz_lootbox_extracted_generic", var_d64bef4dd271a622, owner.closestpoi);
  }
}

function function_baf5e17d7033a223(player) {
  if(!isDefined(level.var_8fc589b1edff1fb2)) {
    level.var_8fc589b1edff1fb2 = [];
  }

  var_5b6d15e33cb2eb51 = level.var_8fc589b1edff1fb2[player.guid];
  var_f260f6aff9ac7f06 = ter_op(isDefined(function_84d052fbd32e9c5b(player)), 1, 0);

  if(!isDefined(var_5b6d15e33cb2eb51)) {
    return 0;
  }

  assert(var_5b6d15e33cb2eb51 >= var_f260f6aff9ac7f06, "<dev string:xb0>");

  if(isDefined(level.var_8fc589b1edff1fb2[player.guid])) {
    return ((var_5b6d15e33cb2eb51 - var_f260f6aff9ac7f06) * level.br_pickups.br_value[level.var_1e8771caf5122101]);
  }

  return 0;
}

function function_8f6753648e94e7ec(player) {
  if(!isDefined(level.var_8fc589b1edff1fb2)) {
    level.var_8fc589b1edff1fb2 = [];
  }

  var_5b6d15e33cb2eb51 = level.var_8fc589b1edff1fb2[player.guid];

  if(!isDefined(var_5b6d15e33cb2eb51) || var_5b6d15e33cb2eb51 == 0) {
    return [];
  }

  if(!isDefined(level.br_pickups) || !isDefined(level.br_pickups.br_weapontoscriptable)) {
    assertmsg("<dev string:xfb>");
    return [];
  }

  if(!isDefined(level.var_4cb4bde4ae44acba)) {
    level.var_4cb4bde4ae44acba = array_randomize(array_convert_keys_to_ints(level.br_pickups.br_weapontoscriptable));
  }

  if(!isDefined(level.randomweaponindex)) {
    level.randomweaponindex = 0;
  }

  rewards = [];
  rewards[0] = level.br_pickups.var_7b2bff2d04ee1017[level.var_4cb4bde4ae44acba[level.randomweaponindex]];
  level.randomweaponindex = (level.randomweaponindex + 1) % level.var_4cb4bde4ae44acba.size;
  return rewards;
}

function function_fc1ce25282bcba83() {
  return isDefined(level.var_b220727281972841);
}

function hasweaponcase(player) {
  return isDefined(function_84d052fbd32e9c5b(player));
}

function function_84d052fbd32e9c5b(player) {
  if(isDefined(level.var_b220727281972841) && is_equal(level.var_b220727281972841.currentowner, player)) {
    return level.var_b220727281972841;
  }
}

function private function_9b0ef508769a0a0f(origin) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.var_b220727281972841.objidnum = objid;

  if(objid == -1) {
    return;
  }

  objective_setlabel(objid, level.var_53f1209f53f48f29.targetlabel);
  objective_setpings(objid, 1);
  objective_setzoffset(objid, (0, 0, 80)[2]);
  objective_icon(objid, level.var_53f1209f53f48f29.var_ad643c538be8b717);
  function_a13e72e0427ecad2(objid, function_c87fc2417a4251fa());
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_position(objid, origin + (0, 0, 30) - (0, 0, 80));
  objective_setownerteam(objid, undefined);
  objective_setprogressteam(objid, undefined);
  function_c047d7ffe7a83501(objid, level.var_53f1209f53f48f29.var_a7c6c5d6c3d369aa, level.var_53f1209f53f48f29.var_467f4d9b8d9063b);
  objective_disableping(objid, istrue(level.var_53f1209f53f48f29.var_6342a4ff1d4cd212));
  scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(objid, 16);
  objective_setplayintro(objid, 0);
  scripts\mp\objidpoolmanager::function_df6a3e032fa07d22(objid);
  level thread function_3de46c194ccd92d8();
}

function private onplayerentergulag(options) {
  if(!isDefined(level.var_b220727281972841)) {
    return;
  }

  objid = level.var_b220727281972841.objidnum;

  if(!isDefined(objid) || objid == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objid, options.player);
}

function private function_3b3d0d8621983ff4(options) {
  if(!isDefined(level.var_b220727281972841)) {
    return;
  }

  objid = level.var_b220727281972841.objidnum;

  if(!isDefined(objid) || objid == -1) {
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, options.player);
}

function private function_3de46c194ccd92d8() {
  level endon("game_ended");
  level endon("weaponCase_extracted");
  pingtime = ter_op(istrue(level.var_9a327d6ca5e25308), getdvarfloat(@ "hash_886c13ade3501edf", 6), level.var_53f1209f53f48f29.pingdelay);

  while(true) {
    if(isDefined(level.var_b220727281972841.currentowner)) {
      if(istrue(level.var_9a327d6ca5e25308)) {
        objective_position(level.var_b220727281972841.objidnum, level.var_b220727281972841.currentowner.origin + (0, 0, 30) - (0, 0, 80));
      } else {
        objective_onentity(level.var_b220727281972841.objidnum, level.var_b220727281972841.currentowner);
      }
    } else if(isDefined(level.var_b220727281972841.scriptable)) {
      objective_position(level.var_b220727281972841.objidnum, level.var_b220727281972841.scriptable.origin + (0, 0, 30) - (0, 0, 80));
    } else {
      scripts\mp\objidpoolmanager::returnobjectiveid(level.var_b220727281972841.objidnum);
      return;
    }

    objective_ping(level.var_b220727281972841.objidnum);
    wait pingtime;
  }
}

function function_95d2129bcec4692(origin) {
  anyone = level.players[0];
  anyone function_c20b29a0d9d6ccaf("init", origin);
}

function private function_147936bfe8fd8d7e(origin) {
  anyone = level.players[0];
  anyone function_c20b29a0d9d6ccaf("spawned", origin);
}

function private function_ab9f38ae158a284c(player) {
  player function_c20b29a0d9d6ccaf("pickup", player.origin);
}

function private function_d88e40b4707fdabd(player, var_76941f891909e174) {
  player function_c20b29a0d9d6ccaf("drop", player.origin, var_76941f891909e174);
}

function private function_c20b29a0d9d6ccaf(type, position, var_76941f891909e174) {
  var_76941f891909e174 = default_to(var_76941f891909e174, 0);
  eventparams = [];
  eventparams[eventparams.size] = "event_type";
  eventparams[eventparams.size] = type;
  assert(isstring(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "team_name";
  eventparams[eventparams.size] = self.team;
  assert(isstring(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "playlist_name";
  eventparams[eventparams.size] = getplaylistname();
  assert(isstring(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "circle_index";
  eventparams[eventparams.size] = getcircleindex();
  assert(isnumber(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "map_name";
  eventparams[eventparams.size] = level.mapname;
  assert(isstring(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "position_x";
  eventparams[eventparams.size] = position[0];
  assert(isnumber(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "position_y";
  eventparams[eventparams.size] = position[1];
  assert(isnumber(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "position_z";
  eventparams[eventparams.size] = position[2];
  assert(isnumber(eventparams[eventparams.size - 1]));
  eventparams[eventparams.size] = "owner_killed";
  eventparams[eventparams.size] = var_76941f891909e174;
  assert(function_c86457bdd073e07b(eventparams[eventparams.size - 1]));
  self dlog_recordplayerevent("dlog_event_br_weapon_case", eventparams);
}

function private getcircleindex() {
  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    circleindex = level.br_circle.circleindex;
  }

  return circleindex;
}

function private function_c86457bdd073e07b(value) {
  return isnumber(value) && (value == 1 || value == 0);
}