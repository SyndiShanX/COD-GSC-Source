/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64acb6ce534155b7.gsc
*************************************************/

#using script_135f13d8aa1c1f19;
#using script_1c9fa9bfb0a2fd44;
#using script_2190c693b7121ab3;
#using script_28a1eb678d22e4e3;
#using script_29e75e5ebeca383d;
#using script_3ff2458477d23489;
#using script_4948cdf739393d2d;
#using script_4e77eb48df5875ee;
#using script_5238dee479bbf7fb;
#using script_728ffcee8cbf30ee;
#using script_7cf8223c43bbe80b;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_assassination_quest;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dom_quest;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_scavenger_quest;
#using scripts\mp\gametypes\br_timedrun_quest;
#using scripts\mp\gametypes\br_vip_quest;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_c133516bfc1d803c;

function function_bf4fd0b5a7c2f528() {
  var_aafa18af5febbc3d = utility::function_ee26a62ef3d1372d(@ "hash_56d4c1121bffcdf1", 1, istrue(level.gametypebundle.var_3f9b0fde4d94c4e1));

  if(!var_aafa18af5febbc3d) {
    thread function_a469ee97eed72149();
    return;
  }

  if(game_utility::getsubgametype() == "dmz" || game_utility::getsubgametype() == "exgm") {
    return;
  }

  level.contractmanager = spawnStruct();
  function_7630fa0c7b8a8999();
  inittablets();
  disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  namespace_1a2fa2b6ae5d223c::setupcirclepeek();
  team_assimilation::registerteamassimilatecallback(&function_6bdc6f56944dc3aa);
  lui_game_event_aggregator::registeronluieventcallback(&function_7871e27c25160f63);
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_gen_accept"] = "gnrc_grav_msns";
  game["dialog"]["mission_misc_success"] = "gnrc_grav_msnc";
  game["dialog"]["mission_obj_change"] = "gnrc_grav_bjcn";
  game["dialog"]["mission_obj_moved"] = "gnrc_grav_bjcr";
  game["dialog"]["mission_obj_next_ptarget"] = "gnrc_grav_trgn";
  game["dialog"]["mission_obj_next_nptarget"] = "gnrc_grav_bjcn";
  game["dialog"]["mission_obj_warning_time"] = "gnrc_grav_mstw";
  game["dialog"]["mission_obj_warning_capture"] = "mission_mission_obj_warning_capture";
  game["dialog"]["mission_obj_circle_fail"] = "gnrc_grav_msfr";
  game["dialog"]["mission_gen_fail"] = "gnrc_grav_msnf";
  game["dialog"]["mission_gen_fail_time"] = "gnrc_grav_mstt";
  game["dialog"]["mission_teammate_down"] = "tmmd_grav_mssn";
  game["dialog"]["mission_enemy_down"] = "nmyd_grav_mssn";
  level._effect["vfx_dom_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_dom");
  level._effect["vfx_revive_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_revive");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/iw8_br/gameplay/vfx_br_flare_smktrail");
  level._effect["vfx_marker_base_orange_pulse"] = loadfx("vfx/iw8_br/gameplay/vfx_br_tr_marker.vfx");
  level.brmodevariantrewardcullfunc = undefined;
  br_circle::registercirclecallbacks(3, &dangercircletick, &function_1a1709943670772a, &function_6ac289b030b7cabe);

  thread function_870ec8b83fc533fd();
}

function function_7630fa0c7b8a8999() {
  level.contractmanager.contractdata = [];
  level.contractmanager.var_766f9de01948c219 = [];
  level.contractmanager.var_8764d5e454e66ea3 = [];
  level.contractmanager.var_b6fae9c9655c73bf = [];
  level.contractmanager.var_ab841cfaca2f23ad = [];
  level.contractmanager.var_8f51bbe0d6629b2c = [];
  level.contractmanager.currenttasks = [];
  level.contractmanager.defaultfilter = [];
  level.contractmanager.defaultfilter[0] = &filtercondition_isdead;
  level.contractmanager.defaultfilter[1] = &filtercondition_ingulag;
  level.contractmanager.var_2bdaf97f6bfeab76 = getdvarint(@ "hash_f6a77ffd2ac4d6d1", 1);
  level.contractmanager.rewards = spawnStruct();
  level.contractmanager.rewards.categorytogroup = [];
  level.contractmanager.rewards.grouptorewards = [];
  level.contractmanager.rewards.scalertoscaleinfo = [];
  level.contractmanager.rewards.rewardtotype = [];
  level.contractmanager.rewards.rewardtovalue = [];
  level.contractmanager.tiers = [];
  level.contractmanager.var_5c6031bde94872a7 = "MP_BR_INGAME/CONTRACT_CANCEL_TIME";
  level.contractmanager.cancelmessage = "MP_BR_INGAME/CONTRACT_CANCEL";
  level.contractmanager.var_3c3c5b819ea01809 = [];
  level.contractmanager.var_5041655a5e1a439e = [];
  var_b9d8076b5d12a487 = getDvar(@ "hash_ef2cf60c13db433f", "");

  if(var_b9d8076b5d12a487 != "" || !isDefined(level.gametypebundle)) {
    var_a52e57a689222a7c = "contractlist:" + default_to(var_b9d8076b5d12a487, "br_contractlist");
  } else {
    var_a52e57a689222a7c = level.gametypebundle.contractlist;
  }

  contractlist = getscriptbundle(var_a52e57a689222a7c).contractlist;

  for(contractidx = 0; contractidx < contractlist.size; contractidx++) {
    if(!isDefined(contractlist[contractidx].contract)) {
      continue;
    }

    contractbundle = getscriptbundle(contractlist[contractidx].contract);
    contractdata = spawnStruct();
    contractdata.index = contractidx;
    contractdata.enabled = contractbundle.enabled;
    contractdata.ref = contractbundle.name;
    contractdata.lootref = contractbundle.starterloot;
    contractdata.funcs = [];
    contractdata.var_8d4889067c776936 = function_854eaac890bc7c17(contractdata.ref, 22, -1);
    contractdata.var_839e7395b90ff0ec = function_854eaac890bc7c17(contractdata.ref, 23, -1);
    contractdata.var_a517ddce5d9509a8 = function_854eaac890bc7c17(contractdata.ref, 24, 0);
    contractdata.var_17e740da24ef39aa = function_854eaac890bc7c17(contractdata.ref, 25, -1);

    if(issharedfuncdefined(contractdata.ref, "get_contract_data")) {
      function_f3bb4f4911a1beb2(contractdata.ref, "get_contract_data", contractdata);
    } else {
      switch (contractdata.ref) {
        case #"hash_f4a9126c03d3385b":
          scripts\mp\gametypes\br_dom_quest::getcontractdata(contractdata);
          break;
        case #"hash_96e641d7fe5b1cf1":
          scripts\mp\gametypes\br_assassination_quest::getcontractdata(contractdata);
          break;
        case #"hash_f81960af7095fbde":
          scripts\mp\gametypes\br_assassination_quest::getcontractdata(contractdata, "master");
          break;
        case #"hash_7b0c576c4a7e4890":
          scripts\mp\gametypes\br_vip_quest::getcontractdata(contractdata);
          break;
        case #"hash_5c57b61aa79410db":
          scripts\mp\gametypes\br_scavenger_quest::getcontractdata(contractdata);
          break;
        case #"hash_d0eb63c46c25ef55":
          scripts\mp\gametypes\br_timedrun_quest::getcontractdata(contractdata);
          break;
        case #"hash_cf3abe09f0094696":
          namespace_78324ffeb3033698::getcontractdata(contractdata);
          break;
        case #"hash_bf5597954aaed3d7":
          namespace_a12ab42942591824::getcontractdata(contractdata);
          break;
        case #"hash_d22bc78737d8a069":
          namespace_cc15148f4ce22771::getcontractdata(contractdata);
          break;
        case #"hash_69146251ab5ca13a":
          namespace_6c622b52017c6808::getcontractdata(contractdata);
          break;
        case #"hash_4aae0f3e58abb932":
          namespace_522ef15f95ed6589::getcontractdata(contractdata);
          break;
        case #"hash_9bcbe04c85a6a767":
          namespace_6a760ad730220f95::getcontractdata(contractdata);
          break;
        case #"hash_73f686029a5278dc":
          namespace_97c4e054660113b7::getcontractdata(contractdata);
          break;
        case #"hash_74ed0c0772e5616":
        case #"hash_3684a21686064f80":
        case #"hash_55cbaf99a55ad833":
        case #"hash_74becfc3db09261d":
        case #"hash_c13e659fe3bd1db3":
        case #"hash_d055a3a4707f4721":
        case #"hash_e2589cebce7ef39c":
          break;
        default:
          assertmsg("<dev string:x26>" + contractdata.ref);
          break;
      }
    }

    level.contractmanager.contractdata[level.contractmanager.contractdata.size] = contractdata;
    level.contractmanager.var_766f9de01948c219[contractdata.ref] = contractdata;
    level.contractmanager.var_8764d5e454e66ea3[contractdata.lootref] = contractdata;
  }

  numstates = tablelookupgetnumrows("mp/brmissions.csv");

  for(stateidx = 0; stateidx < numstates; stateidx++) {
    state = spawnStruct();
    state.index = int(tablelookupbyrow("mp/brmissions.csv", stateidx, 0));
    state.ref = tablelookupbyrow("mp/brmissions.csv", stateidx, 1);
    state.contractref = tablelookupbyrow("mp/brmissions.csv", stateidx, 18);
    level.contractmanager.var_8f51bbe0d6629b2c[state.ref] = state;
  }
}

function inittablets() {
  level.contractmanager.activetablets = [];
  level.contractmanager.hiddentablets = [];
  level.contractmanager.var_a140d7e8412b4051 = [];
  level.contractmanager.var_546b3948246e4aa3 = [];
  level.contractmanager.var_b6012b6ffdb53601 = [];
  hidepercent = 0;
  var_d1358da240d157c5 = getdvarfloat(@ "hash_4ec62b4599196026", 0.667);
  var_18d89c513b75caf6 = [];
  locationmin = getdvarint(@ "hash_61d045aa9b2d5565", 3);
  var_4c41f1d284a449f2 = getdvarint(@ "hash_3b86f15e6ab5c0b0", 0);

  if(locationmin > 0 && isDefined(level.poi_names)) {
    foreach(poi in level.poi_names) {
      poiname = scripts\mp\poi::function_150af7f3a2874667(poi);
      var_18d89c513b75caf6[poiname] = locationmin;
    }
  }

  totalcontracts = 0;

  foreach(type in level.contractmanager.contractdata) {
    if(!isDefined(type.var_57bedc271771b7a6) || !istrue(type.var_57bedc271771b7a6)) {
      tablets = getentitylessscriptablearray(type.lootref);
    } else {
      tablets = [[type.funcs["spawnScriptables"]]]();
    }

    tablets = array_removeundefined(tablets);

    if(!type.enabled) {
      foreach(tablet in tablets) {
        function_2aa2583aa4c84697(tablet);
      }

      continue;
    }

    level.contractmanager.var_546b3948246e4aa3[type.lootref] = 0;
    level.contractmanager.var_b6012b6ffdb53601[type.lootref] = 0;

    if(isDefined(type.var_2f8b14dbb63cc32a)) {
      hidepercent = type.var_2f8b14dbb63cc32a;
    } else {
      hidepercent = var_d1358da240d157c5;
    }

    var_6d130ebb53ad2136 = getdvarfloat(@ "hash_341fd6b76f01c2e8", 1200);

    if(var_6d130ebb53ad2136 > 0 && tablets.size > 0) {
      foreach(kiosk in level.br_armory_kiosk.scriptables) {
        closetablets = getlootscriptablearrayinradius(type.lootref, undefined, kiosk.origin, var_6d130ebb53ad2136);

        foreach(closetablet in closetablets) {
          closetablet.hideme = 1;
        }
      }

      for(i = tablets.size - 1; i >= 0; i--) {
        if(!istrue(tablets[i].hideme)) {
          continue;
        }

        tablets[i].hideme = undefined;
        result = function_2aa2583aa4c84697(tablets[i]);
        assertex(result, "<dev string:x43>");
        tablets[i] = tablets[tablets.size - 1];
        tablets[tablets.size - 1] = undefined;
      }
    }

    for(i = tablets.size - 1; i >= 0; i--) {
      tablet = tablets[i];
      tablet tabletinit(type);

      if(!tablet.init || namespace_6c6c9cbca3ea8e6e::function_f0201365c368cf88(tablet.origin) || !br_circle::ispointwithininitialdangercircle(tablet.origin) || function_60094dbeee6e39b0(tablet.origin)) {
        result = function_2aa2583aa4c84697(tablet);
        assertex(result, "<dev string:x43>");
        tablets[i] = tablets[tablets.size - 1];
        tablets[tablets.size - 1] = undefined;
      }
    }

    totalcontracts += tablets.size;

    if(tablets.size) {
      setobjectivetypesomvarbit(type);
    }

    if(type.var_8d4889067c776936 > 0) {
      var_5731f7181809474a = tablets.size;
    } else {
      var_2c3363605abb4836 = tablets.size * hidepercent;
      var_5731f7181809474a = int(var_2c3363605abb4836);
      extrachance = var_2c3363605abb4836 - var_5731f7181809474a;

      if(randomfloat(1) < extrachance) {
        var_5731f7181809474a++;
      }
    }

    for(i = 0; i < var_5731f7181809474a; i++) {
      randindex = randomintrange(0, tablets.size);
      tablet = tablets[randindex];
      level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size] = tablets[randindex];
      tablets[randindex] = tablets[tablets.size - 1];
      tablets[tablets.size - 1] = undefined;
    }

    foreach(tablet in tablets) {
      if(var_18d89c513b75caf6.size > 0) {
        poi = poi::function_6cc445c02b5effac(tablet.origin);
        poiname = scripts\mp\poi::function_150af7f3a2874667(poi);

        if(isDefined(poiname) && isDefined(var_18d89c513b75caf6[poiname])) {
          var_18d89c513b75caf6[poiname]--;

          if(!var_18d89c513b75caf6[poiname]) {
            var_18d89c513b75caf6[poiname] = undefined;
          }
        }
      }
    }

    foreach(tablet in tablets) {
      if(var_4c41f1d284a449f2 > 0) {
        if(br_circle::ispointwithininitialdangercircle(tablet.origin)) {
          var_4c41f1d284a449f2--;
        }
      }
    }

    foreach(tablet in tablets) {
      tablet tabletshow();
    }
  }

  if(var_18d89c513b75caf6.size) {
    level.contractmanager.hiddentablets = utility::array_randomize(level.contractmanager.hiddentablets);

    for(i = level.contractmanager.hiddentablets.size - 1; i >= 0; i--) {
      tablet = level.contractmanager.hiddentablets[i];
      poi = poi::function_6cc445c02b5effac(tablet.origin);
      poiname = scripts\mp\poi::function_150af7f3a2874667(poi);

      if(isDefined(poiname) && isDefined(var_18d89c513b75caf6[poiname]) && function_d857e2fd8227f1bd(tablet.task.type, 1) == 1) {
        level.contractmanager.hiddentablets[i] = level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1];
        level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1] = undefined;
        tablet tabletshow();
        var_18d89c513b75caf6[poiname]--;

        if(!var_18d89c513b75caf6[poiname]) {
          var_18d89c513b75caf6[poiname] = undefined;

          if(!var_18d89c513b75caf6.size) {
            break;
          }
        }
      }
    }
  }

  if(var_4c41f1d284a449f2 > 0) {
    level.contractmanager.hiddentablets = utility::array_randomize(level.contractmanager.hiddentablets);

    for(i = level.contractmanager.hiddentablets.size - 1; i >= 0; i--) {
      tablet = level.contractmanager.hiddentablets[i];

      if(br_circle::ispointwithininitialdangercircle(tablet.origin) && function_d857e2fd8227f1bd(tablet.task.type, 1) == 1) {
        level.contractmanager.hiddentablets[i] = level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1];
        level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1] = undefined;
        tablet tabletshow();
        var_4c41f1d284a449f2--;

        if(var_4c41f1d284a449f2 == 0) {
          break;
        }
      }
    }
  }

  var_391489a137dd38a1 = squared(getdvarint(@ "hash_526a7311f94ae394", 0));

  if(var_391489a137dd38a1 > 0) {
    var_380e9cbe80c1f6ca = 0;
    var_65462a5df4649b45 = [];

    for(i = level.contractmanager.activetablets.size - 1; i >= 0; i--) {
      tablet = level.contractmanager.activetablets[i];

      if(tablet function_26073a27a7bc12e1(var_391489a137dd38a1, level.contractmanager.activetablets)) {
        level.contractmanager.activetablets[i] = level.contractmanager.activetablets[level.contractmanager.activetablets.size - 1];
        level.contractmanager.activetablets[level.contractmanager.activetablets.size - 1] = undefined;
        var_65462a5df4649b45[var_65462a5df4649b45.size] = tablet;
        var_380e9cbe80c1f6ca++;
      }
    }

    level.contractmanager.hiddentablets = utility::array_randomize(level.contractmanager.hiddentablets);

    for(i = level.contractmanager.hiddentablets.size - 1; i >= 0; i--) {
      if(var_380e9cbe80c1f6ca == 0) {
        break;
      }

      tablet = level.contractmanager.hiddentablets[i];

      if(!tablet function_26073a27a7bc12e1(var_391489a137dd38a1, level.contractmanager.activetablets) && function_d857e2fd8227f1bd(tablet.task.type, 1) == 1) {
        tablet tabletshow();
        level.contractmanager.hiddentablets[i] = level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1];
        level.contractmanager.hiddentablets[level.contractmanager.hiddentablets.size - 1] = undefined;
        var_380e9cbe80c1f6ca--;
      }
    }

    level.contractmanager.hiddentablets = utility::array_combine(level.contractmanager.hiddentablets, var_65462a5df4649b45);
  }

  level thread function_968df0af5e2d28ea();
  activecontracts = level.contractmanager.activetablets.size;
  hiddencontracts = level.contractmanager.hiddentablets.size;

  level thread function_2651277c09935bde(160000);

  br_analytics::branalytics_inittablets(totalcontracts, activecontracts, hiddencontracts, hidepercent);

  if(br_gametypes::isfeatureenabled("tabletReplace")) {
    level.contractmanager thread tabletreplace();
  } else {
    level.contractmanager thread delayedshowtablets();
  }

  level notify("contractmanager_inittablets_done");
}

function function_a469ee97eed72149() {
  var_d1c571c1e3ed81ca = getdvarint(@ "hash_88cc8ac36a3c2863", 32);
  tablet_throttle = throttle::function_af33edfaf05fc572("tablet", var_d1c571c1e3ed81ca);
  var_b9d8076b5d12a487 = getDvar(@ "hash_ef2cf60c13db433f", "");

  if(var_b9d8076b5d12a487 != "" || !isDefined(level.gametypebundle)) {
    var_a52e57a689222a7c = "contractlist:" + default_to(var_b9d8076b5d12a487, "br_contractlist");
  } else {
    var_a52e57a689222a7c = level.gametypebundle.contractlist;
  }

  contractlist = getscriptbundle(var_a52e57a689222a7c).contractlist;
  flags::gameflagwait("prematch_done");

  for(contractidx = 0; contractidx < contractlist.size; contractidx++) {
    if(!isDefined(contractlist[contractidx].contract)) {
      continue;
    }

    contractbundle = getscriptbundle(contractlist[contractidx].contract);
    tablets = getentitylessscriptablearray(contractbundle.starterloot);

    foreach(tablet in tablets) {
      throttle::function_6f7b33660ae155ef(tablet_throttle);
      br_pickups::loothide(tablet);
    }
  }
}

function function_531ddda805acc45a(var_4073dfe8bf38ba47, var_a682e84261a6b971) {
  if(!isDefined(var_a682e84261a6b971)) {
    var_a682e84261a6b971 = level.contractmanager.activetablets;
  }

  i_distance = sqrt(var_4073dfe8bf38ba47);
  var_a682e84261a6b971 = sortbydistancecullbyradius(var_a682e84261a6b971, self.origin, i_distance);

  foreach(tablet in var_a682e84261a6b971) {
    if(tablet == self) {
      continue;
    }

    return tablet;
  }

  return undefined;
}

function function_26073a27a7bc12e1(var_4073dfe8bf38ba47, var_a682e84261a6b971) {
  nearbytablet = function_531ddda805acc45a(var_4073dfe8bf38ba47, var_a682e84261a6b971);
  return isDefined(nearbytablet);
}

function setobjectivetypesomvarbit(type) {
  index = function_3d262d56274bd22e(type.ref);
  assertex(index < 32, "<dev string:x81>" + type.ref + "<dev string:x90>");
  setomnvarbit("ui_br_objective_types", index, 1);
}

function tabletreplace() {
  if(!isDefined(level.br_level)) {
    return;
  }

  flags::gameflagwait("prematch_done");
  level.contractmanager.hiddentablets = utility::array_randomize(level.contractmanager.hiddentablets);
  var_fb4145cf6a25541e = 0;
  var_40fb495a4451d505 = level.tabletreplacefrequency;

  for(i = 0; i < level.contractmanager.hiddentablets.size; i++) {
    tablet = level.contractmanager.hiddentablets[i];
    level waittill("quest_started");

    if(isDefined(level.tabletreplacefrequency) && level.tabletreplacefrequency != -1) {
      var_fb4145cf6a25541e++;

      if(var_fb4145cf6a25541e >= var_40fb495a4451d505) {
        tablet tabletshow();
        var_40fb495a4451d505 += level.tabletreplacefrequency;
        i++;
      }

      continue;
    }

    tablet tabletshow();
  }
}

function function_fe5d4d0a6a530b1e(contractref, origin, angles, iselite) {
  foreach(data in level.contractmanager.contractdata) {
    ref = data.ref;

    if(ref == contractref) {
      newtablet = spawnscriptable(data.lootref, origin, angles);
      br_pickups::registerscriptableinstance(newtablet);
      newtablet tabletinit(data, iselite);
      newtablet tabletshow();
      return newtablet;
    }
  }
}

function delayedshowtablets() {
  if(!isDefined(level.br_level)) {
    return;
  }

  flags::gameflagwait("prematch_done");
  var_4d2a2e6906d0f90e = !br_gametypes::isfeaturedisabled("circle");
  lastcircle = level.br_level.br_circledelaytimes.size - 1 - getdvarint(@ "hash_96878da693689ccd", 4);
  showpercent = getdvarfloat(@ "hash_743253d28cd0d1f7", 0.3);
  validtablets = [];

  for(i = 0; i < level.contractmanager.hiddentablets.size; i++) {
    tablet = level.contractmanager.hiddentablets[i];
    tablet.circleindex = br_circle_util::function_d5cf183ee258befb(tablet.origin);

    if(tablet.circleindex >= 0 || !var_4d2a2e6906d0f90e) {
      validtablets[validtablets.size] = tablet;
    }
  }

  level.contractmanager.hiddentablets = utility::array_randomize(validtablets);

  while(true) {
    if(var_4d2a2e6906d0f90e) {
      level waittill("br_circle_set");
    }

    if(var_4d2a2e6906d0f90e && !level.br_circle.circleindex) {
      br_analytics::branalytics_delayedshowtablets(0, showpercent, validtablets.size, 0);
      continue;
    }

    var_391489a137dd38a1 = squared(getdvarint(@ "hash_526a7311f94ae394", 0));
    var_842f8fcc3ce6073 = [];
    var_91c73aa76ed988d0 = [];

    foreach(type in level.contractmanager.contractdata) {
      var_91c73aa76ed988d0[type.lootref] = 0;

      if(function_d857e2fd8227f1bd(type, !var_4d2a2e6906d0f90e) != 1) {
        var_842f8fcc3ce6073[type.lootref] = 0;
        continue;
      }

      var_842f8fcc3ce6073[type.lootref] = type.var_a517ddce5d9509a8;
    }

    validtablets = [];
    prioritytablets = [];
    skippedtablets = [];

    for(i = 0; i < level.contractmanager.hiddentablets.size; i++) {
      tablet = level.contractmanager.hiddentablets[i];

      if(!isDefined(tablet)) {
        continue;
      }

      if(!var_4d2a2e6906d0f90e || tablet.circleindex >= level.br_circle.circleindex) {
        if(!function_ebdf8f6e61c84882(tablet)) {
          continue;
        }

        result = function_d857e2fd8227f1bd(tablet.task.type, !var_4d2a2e6906d0f90e);

        if(result == -1) {
          continue;
        } else if(result == 0) {
          skippedtablets[skippedtablets.size] = tablet;
          continue;
        }

        if(var_391489a137dd38a1 > 0) {
          if(tablet function_26073a27a7bc12e1(var_391489a137dd38a1, level.contractmanager.activetablets)) {
            skippedtablets[skippedtablets.size] = tablet;
            continue;
          }

          if(tablet function_26073a27a7bc12e1(var_391489a137dd38a1, validtablets)) {
            skippedtablets[skippedtablets.size] = tablet;
            continue;
          }

          if(getdvarint(@ "hash_fd90bec9ce1c7d5c", 1)) {
            if(tablet function_26073a27a7bc12e1(var_391489a137dd38a1, prioritytablets)) {
              skippedtablets[skippedtablets.size] = tablet;
              continue;
            }
          }
        }

        if(var_842f8fcc3ce6073[tablet.type] > 0) {
          prioritytablets[prioritytablets.size] = tablet;
          var_842f8fcc3ce6073[tablet.type]--;
          continue;
        }

        validtablets[validtablets.size] = tablet;
      }
    }

    circleindex = isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) ? level.br_circle.circleindex : -1;
    showcount = int(ceil(validtablets.size * showpercent));
    var_cf6dc40ca9d1b393 = int(max(0, getdvarint(@ "hash_6cd10c5d6e2a6220", 100) - level.contractmanager.activetablets.size) - getdvarint(@ "hash_48094445b4d0cade", 20) * circleindex);
    showcount = int(min(showcount, var_cf6dc40ca9d1b393));
    var_c03697880b987159 = 0;

    foreach(tablet in prioritytablets) {
      if(!isDefined(tablet)) {
        continue;
      }

      tablet tabletshow();
      var_91c73aa76ed988d0[tablet.type]++;
      var_c03697880b987159++;
    }

    foreach(tablet in validtablets) {
      if(var_c03697880b987159 >= showcount) {
        skippedtablets[skippedtablets.size] = tablet;
        continue;
      }

      if(var_91c73aa76ed988d0[tablet.type] >= level.contractmanager.var_8764d5e454e66ea3[tablet.type].var_17e740da24ef39aa && level.contractmanager.var_8764d5e454e66ea3[tablet.type].var_17e740da24ef39aa >= 0) {
        skippedtablets[skippedtablets.size] = tablet;
        continue;
      }

      tablet tabletshow();
      var_91c73aa76ed988d0[tablet.type]++;
      var_c03697880b987159++;
    }

    level.contractmanager.hiddentablets = skippedtablets;
    br_analytics::branalytics_delayedshowtablets(circleindex, showpercent, validtablets.size, var_c03697880b987159);

    if(circleindex >= lastcircle) {
      break;
    }

    if(!var_4d2a2e6906d0f90e) {
      break;
    }
  }
}

function function_ebdf8f6e61c84882(tablet) {
  if(isDefined(tablet.task.type.funcs["validateContractNotInStronghold"])) {
    return tablet.task[[tablet.task.type.funcs["validateContractNotInStronghold"]]]();
  }

  return 1;
}

function function_1c1f9f1aa4944459() {
  self endon("game_ended");

  while(!isDefined(level.lockedvolumes) || level.lockedvolumes.size < 1) {
    wait 0.5;
  }

  foreach(tablet in level.contractmanager.activetablets) {
    if(isDefined(tablet.task.type.funcs["validateContractNotInStronghold"])) {
      tablet.task[[tablet.task.type.funcs["validateContractNotInStronghold"]]]();
    }
  }
}

function disablealltablets() {
  foreach(type in level.contractmanager.contractdata) {
    tablets = getlootscriptablearray(type.lootref);

    if(type.enabled) {
      foreach(tablet in tablets) {
        tablet tablethide();
      }
    }
  }
}

function function_2aa2583aa4c84697(tablet) {
  if(flags::gameflag("prematch_done")) {
    assertmsg("<dev string:xa4>");
    return;
  }

  if(istrue(tablet.var_f1d383d9d3b40188)) {
    return 0;
  }

  count = level.contractmanager.var_a140d7e8412b4051.size;
  level.contractmanager.var_a140d7e8412b4051[count] = tablet;
  tablet.var_f1d383d9d3b40188 = 1;
  return 1;
}

function function_968df0af5e2d28ea() {
  flags::gameflagwait("prematch_done");
  var_d1c571c1e3ed81ca = getdvarint(@ "hash_88cc8ac36a3c2863", 32);
  tablet_throttle = throttle::function_af33edfaf05fc572("tablet", var_d1c571c1e3ed81ca);

  foreach(tablet in level.contractmanager.var_a140d7e8412b4051) {
    throttle::function_6f7b33660ae155ef(tablet_throttle);
    tablet thread tablethide();
    tablet.var_f1d383d9d3b40188 = undefined;
  }

  level.contractmanager.var_a140d7e8412b4051 = undefined;

  foreach(tablet in level.contractmanager.hiddentablets) {
    throttle::function_6f7b33660ae155ef(tablet_throttle);
    tablet thread tablethide();
  }

  foreach(tablet in level.contractmanager.activetablets) {
    if(istrue(tablet.startdisabled)) {
      throttle::function_6f7b33660ae155ef(tablet_throttle);
      tablet.startdisabled = undefined;
      tablet thread tablethide();
    }
  }

  throttle::throttle_destroy(tablet_throttle);
}

function tablethide(hideforever) {
  self endon("show");

  if(istrue(hideforever)) {
    self.hiddenforever = 1;
  }

  if(isDefined(level.contractmanager.var_b6012b6ffdb53601) && isDefined(level.contractmanager.var_b6012b6ffdb53601[self.type])) {
    level.contractmanager.var_b6012b6ffdb53601[self.type]++;
  }

  flags::gameflagwait("prematch_done");
  br_pickups::loothide(self);
}

function function_6ac289b030b7cabe(obj) {
  if(isDefined(obj.tablettype) && !istrue(obj.hiddenforever)) {
    allowshow = 1;

    if(isDefined(obj.tablettype.funcs["onShowAgain"])) {
      allowshow = obj.task[[obj.tablettype.funcs["onShowAgain"]]]();
    }

    if(allowshow) {
      obj tabletshow(1);
    }
  }
}

function tabletshow(var_132f5385c2f23a96) {
  assert(isDefined(self.init));

  if(isDefined(level.contractmanager.var_546b3948246e4aa3) && isDefined(level.contractmanager.var_546b3948246e4aa3[self.type])) {
    level.contractmanager.var_546b3948246e4aa3[self.type]++;
  }

  self notify("show");
  part = self.type;
  self setscriptablepartstate(part, "visible");

  if(!utility::array_contains(level.contractmanager.activetablets, self)) {
    level.contractmanager.activetablets[level.contractmanager.activetablets.size] = self;
  }

  if(!istrue(var_132f5385c2f23a96)) {
    br_analytics::branalytics_spawntablet(self);
  }
}

function tabletinit(type, iselite) {
  if(isDefined(self.init)) {
    return;
  }

  self.init = 1;
  self.tablettype = type;
  tabletinit = type.funcs["onInit"];

  if(isDefined(tabletinit)) {
    task = spawnStruct();
    task.teams = [];
    task.type = type;
    task.iselite = iselite;
    self.task = task;
    task.tablet = self;
    self.init = task[[tabletinit]]();

    if(!self.init) {
      br_analytics::branalytics_invalidtablet(self);
    }
  }

  return self.init;
}

function oncontracttablethide(instance) {
  if(!isDefined(level.contractmanager)) {
    return;
  }

  level.contractmanager.activetablets = utility::array_remove(level.contractmanager.activetablets, instance);

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onContractTabletHide")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onContractTabletHide", instance.task);
  }

  instance notify("onTabletHidden");

  if(isDefined(instance) && isDefined(instance.tablettype) && isDefined(instance.tablettype.ref)) {
    contractdata = function_2a81be592adacdaa(instance.tablettype.ref);

    if(isDefined(contractdata) && isDefined(contractdata.funcs["onTabletHidden"])) {
      [[contractdata.funcs["onTabletHidden"]]](instance);
    }
  }
}

function function_8ad1b4ddc1fd852a(team, player) {
  if(!istrue(self.var_132f5385c2f23a96)) {
    br_analytics::branalytics_missionstart(self, player);
  }

  level.contractmanager.var_b6fae9c9655c73bf[team] = self;
  level.contractmanager.currenttasks[level.contractmanager.currenttasks.size] = self;

  if(!isDefined(self.teams)) {
    self.teams = [];
  }

  self.teams[self.teams.size] = team;
  self.var_d154ac2657c5f44 = player;

  if(isDefined(player) && isDefined(player.closestpoi)) {
    self.startingpoi = player.closestpoi;
  }

  function_473ab9452660e60f(self.type.ref);

  if(br_gametypes::isbrgametypefuncdefined("setActiveContractStatusOmnvar")) {
    br_gametypes::runbrgametypefunc("setActiveContractStatusOmnvar", team, self);
  }

  players = teams::getteamdata(team, "players");

  foreach(teamplayer in players) {
    if(!istrue(self.var_132f5385c2f23a96)) {
      teamplayer challenges::oncontractstart(self.type.index, player);
    }

    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(teamplayer, "contract_start");
  }

  level notify("quest_started", team);
}

function endcontract(var_5e671fc71e72d5e8, results, var_752106078fe9b8fc, endstate) {
  if(br_gametypes::isbrgametypefuncdefined("contractEnd")) {
    br_gametypes::function_d72afdccedfc9b07("contractEnd", self, self.teams[0], isDefined(var_5e671fc71e72d5e8) && var_5e671fc71e72d5e8 == self.teams[0]);
  }

  var_c893965b0b5cc806 = isDefined(var_5e671fc71e72d5e8);
  numteamplayers = 0;

  foreach(team in self.teams) {
    assertex(isDefined(level.contractmanager.var_b6fae9c9655c73bf[team]), "<dev string:xd5>" + team + "<dev string:x10a>");
    var_da1e4a8f39765732 = var_c893965b0b5cc806 && var_5e671fc71e72d5e8 == team;
    islegendarycontract = istrue(self.islegendarycontract);

    if(br_gametypes::isbrgametypefuncdefined("setActiveContractStatusOmnvar")) {
      br_gametypes::runbrgametypefunc("setActiveContractStatusOmnvar", team);
    }

    if(!istrue(self.iselite)) {
      uiobjectivehidefromteam(team);
      level.contractmanager.var_b6fae9c9655c73bf[team] = undefined;
    }

    players = teams::getteamdata(team, "players");

    foreach(player in players) {
      player setclientomnvar("ui_br_objective_duration_time", 0);
    }

    if(istrue(self.var_132f5385c2f23a96)) {
      continue;
    }

    if(var_da1e4a8f39765732) {
      numteamplayers = players.size;

      foreach(player in players) {
        if(!isDefined(player.brmissionscompleted)) {
          player.brmissionscompleted = 0;
        }

        player.brmissionscompleted++;

        if(level.var_58adce74179ab9ef) {
          player stats::incpersstat("objectivesCompleted", 1);
          player br_public::updatebrscoreboardstat("missionsCompleted", player stats::getpersstat("objectivesCompleted"));
        } else {
          player br_public::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);
        }

        var_497e8b601a6f12f6 = 0;

        if(!isDefined(player.var_9efefb8078921209)) {
          player.var_9efefb8078921209 = [];
        }

        if(!array_contains(player.var_9efefb8078921209, self.type.ref)) {
          player.var_9efefb8078921209 = array_add(player.var_9efefb8078921209, self.type.ref);
          var_497e8b601a6f12f6 = 1;
        }

        player scripts\cp_mp\challenges::oncontractend(self.type.index, 1, 1, self.startingpoi, self.type.ref, var_497e8b601a6f12f6, islegendarycontract);
      }

      if(!isDefined(level.contractmanager.var_ab841cfaca2f23ad[team])) {
        level.contractmanager.var_ab841cfaca2f23ad[team] = 0;
      }

      level.contractmanager.var_ab841cfaca2f23ad[team]++;

      if(br_gametypes::isbrgametypefuncdefined("giveContractAdditionalRewards")) {
        br_gametypes::runbrgametypefunc("giveContractAdditionalRewards", team, self);
      }

      continue;
    }

    foreach(player in players) {
      player challenges::oncontractend(self.type.index, 0, 1, self.startingpoi, self.type.ref, 0, islegendarycontract);
    }

    if(isDefined(var_752106078fe9b8fc)) {
      var_da60ac7aae847d8 = teams::getteamdata(var_752106078fe9b8fc, "players");

      foreach(var_c92902ad553e3854 in var_da60ac7aae847d8) {
        var_c92902ad553e3854 challenges::oncontractend(self.type.index, 1, 2, self.startingpoi, self.type.ref, 0, islegendarycontract);
      }
    }
  }

  if(!istrue(self.var_132f5385c2f23a96)) {
    instanceholder = spawnStruct();
    instanceholder.questcategory = self.category;
    instanceholder.islegendarycontract = self.islegendarycontract;

    if(var_c893965b0b5cc806) {
      instanceholder.result = "success";
    } else {
      instanceholder.result = "failure";
    }

    if(isDefined(self.tablet)) {
      instanceholder.missionid = utility::string(self.tablet.index);
      instanceholder.endstate = endstate;

      if(!isDefined(results)) {
        results = [];
      }

      br_analytics::branalytics_missionend(instanceholder, 1, results, numteamplayers);
    }
  }

  if(!istrue(self.iselite)) {
    level.contractmanager.currenttasks = utility::array_remove(level.contractmanager.currenttasks, self);
  }
}

function function_bb413728bc5231d0(instance) {
  lootref = instance.type;

  if(isDefined(level.contractmanager.var_8764d5e454e66ea3[lootref].funcs["onTeamAssigned"])) {
    if(function_7094c7010c5e3827(self.team)) {
      assertmsg(self.team + "<dev string:x10f>");
      return;
    }

    if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"contractor")) {
      instance.task.contractoractive = 1;
    }

    giveteampoints(self.team, #"hash_67eb4b642067882a");

    if(br_gametypes::isbrgametypefuncdefined("additionalRewardsOnContractPickup")) {
      br_gametypes::runbrgametypefunc("additionalRewardsOnContractPickup", self.team, instance.task);
    }

    instance tablethide();
    instance.task function_8ad1b4ddc1fd852a(self.team, self);
    instance.task.var_7ca287a82f54e4f6 = self;
    instance.task[[level.contractmanager.var_8764d5e454e66ea3[lootref].funcs["onTeamAssigned"]]]();
    br_plunder::modify_plunder_itemsinworld("brloot_mission_tablet", -1);

    if(br_gametypes::isbrgametypefuncdefined("contractStart")) {
      br_gametypes::runbrgametypefunc("contractStart", instance.task, self.team);
    }

    if(br_gametypes::isbrgametypefuncdefined("playAdditionalContractVOOnPickup")) {
      br_gametypes::runbrgametypefunc("playAdditionalContractVOOnPickup", self.team, instance.task);
    }

    return;
  }

  assertmsg("<dev string:x152>" + instance.type.ref);
}

function function_2938430ff02a6256(team, shouldforce) {
  if(!isDefined(level.contractmanager.var_a95d6fd3530c86db)) {
    level.contractmanager.var_a95d6fd3530c86db = [];
  }

  level.contractmanager.var_a95d6fd3530c86db[team] = shouldforce;
}

function function_e98c0791b051398(team) {
  return isDefined(level.contractmanager) && isDefined(level.contractmanager.var_a95d6fd3530c86db) && istrue(level.contractmanager.var_a95d6fd3530c86db[team]);
}

function function_7094c7010c5e3827(team) {
  return isDefined(level.contractmanager) && isDefined(level.contractmanager.var_b6fae9c9655c73bf) && isDefined(level.contractmanager.var_b6fae9c9655c73bf[team]);
}

function function_22239d4cff05d0a1(team) {
  if(isDefined(level.contractmanager) && isDefined(level.contractmanager.var_b6fae9c9655c73bf)) {
    return level.contractmanager.var_b6fae9c9655c73bf[team];
  }

  return undefined;
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;
  activetablets = [];

  if(!game_utility::function_fa7bfcc1d68b7b73()) {
    if(!isDefined(level.contractmanager) || !isDefined(level.contractmanager.activetablets)) {
      return;
    } else {
      activetablets = level.contractmanager.activetablets;
    }

    foreach(contract in level.contractmanager.contractdata) {
      if(isDefined(contract.funcs["circleTick"])) {
        foreach(task in level.contractmanager.currenttasks) {
          if(contract.ref == task.type.ref) {
            task[[contract.funcs["circleTick"]]](dangercircleorigin, var_52d59c928eb97c81);
          }
        }
      }
    }
  } else {
    if(!isDefined(level.questinfo)) {
      return;
    } else {
      activetablets = level.questinfo.activetablets;
    }

    foreach(quest in level.questinfo.quests) {
      if(isDefined(quest.funcs["circleTick"])) {
        foreach(instance in quest.instances) {
          instance[[quest.funcs["circleTick"]]](dangercircleorigin, var_52d59c928eb97c81);
        }
      }
    }
  }

  foreach(tablet in activetablets) {
    if(distance2dsquared(dangercircleorigin, tablet.origin) > var_52d59c928eb97c81 * var_52d59c928eb97c81) {
      br_pickups::loothide(tablet);
      br_plunder::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
    }
  }
}

function function_1a1709943670772a() {
  if(!isDefined(level.contractmanager)) {
    return;
  }

  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["circleTick"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["circleTick"]]]();
        }
      }
    }
  }

  hiddentablets = [];

  foreach(tablet in level.contractmanager.activetablets) {
    if(!isDefined(tablet) || !isDefined(tablet.type)) {
      continue;
    }

    if(!br_pickups::isquesttablet(tablet.type)) {
      continue;
    }

    if(!isDefined(tablet.origin)) {
      logstring("br_contract_manager::dangerMultiCircleTick tablet does not have an origin! " + tablet.type);
      continue;
    }

    if(!br_circle_util::ispointinmulticircledanger(tablet.origin)) {
      hiddentablets[hiddentablets.size] = tablet;
      br_pickups::loothide(tablet);
      br_plunder::modify_plunder_itemsinworld("brloot_mission_tablet", -1);
    }
  }

  return hiddentablets;
}

function onplayerkilled(attacker, victim) {
  if(!isDefined(level.contractmanager) || !isDefined(victim)) {
    return;
  }

  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["onPlayerKilled"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["onPlayerKilled"]]](attacker, victim);
        }
      }
    }
  }
}

function function_74e0aae435a09a51(victim) {
  if(!isDefined(level.contractmanager) || !isDefined(victim)) {
    return;
  }

  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["onMarkPlayerAsEliminated"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["onMarkPlayerAsEliminated"]]](victim);
        }
      }
    }
  }
}

function onplayerconnect(player) {
  if(!isDefined(player.team) || !isDefined(level.contractmanager)) {
    return;
  }

  setquestrewardtier(player.team, getquestrewardtier(player.team));
  player function_ab19a58fc4be9ce2();
}

function onplayerdisconnect(player) {
  if(!isDefined(level.contractmanager) || !isDefined(player)) {
    return;
  }

  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["onPlayerDisconnect"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["onPlayerDisconnect"]]](player);
        }
      }
    }
  }
}

function onplayerentergulag() {
  if(!isDefined(level.contractmanager)) {
    return;
  }

  if(function_7094c7010c5e3827(self.team)) {
    task = function_22239d4cff05d0a1(self.team);

    if(isDefined(task.type.funcs["onEnterGulag"])) {
      task[[task.type.funcs["onEnterGulag"]]](self);
    }

    if(isDefined(task.var_972eddbdcf30619c)) {
      function_1e64ea5eb68d8119();
    }
  }

  onglobalplayerentergulag();
}

function onglobalplayerentergulag() {
  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["onGlobalPlayerEnterGulag"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["onGlobalPlayerEnterGulag"]]](self);
        }
      }
    }
  }
}

function onplayerrespawn() {
  if(!isDefined(level.contractmanager)) {
    return;
  }

  self setclientomnvar("ui_player_spawned_notify", gettime());

  if(function_7094c7010c5e3827(self.team)) {
    task = function_22239d4cff05d0a1(self.team);

    if(isDefined(task.type.funcs["onPlayerRespawn"])) {
      task[[task.type.funcs["onPlayerRespawn"]]](self);
    }

    if(isDefined(task.var_972eddbdcf30619c)) {
      function_1e64ea5eb68d8119();
    }
  }

  onglobalplayerrespawn();
}

function onglobalplayerrespawn() {
  foreach(contract in level.contractmanager.contractdata) {
    if(isDefined(contract.funcs["onGlobalPlayerRespawn"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(contract.ref == task.type.ref) {
          task[[contract.funcs["onGlobalPlayerRespawn"]]](self);
        }
      }
    }
  }
}

function packsplashparambits(contractindex, rewardcash) {
  assert(contractindex >= 0 && contractindex < 64);
  assert(rewardcash >= 0 && rewardcash < 8192);
  value = contractindex;
  value |= rewardcash << 5;
  return value;
}

function function_878ebcc241b54505(splashref, contractindex, rewardcash, team, delay, var_42b1e877ab187c6) {
  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  params = packsplashparambits(contractindex, rewardcash);
  players = teams::getteamdata(team, "players");

  foreach(player in players) {
    player thread hud_message::showsplash(splashref, params, undefined, undefined, undefined, var_42b1e877ab187c6);
  }
}

function displayteamsplash(team, splash_key, params, var_42b1e877ab187c6) {
  assertex(isDefined(splash_key), "<dev string:x187>" + team);
  players = teams::getteamdata(team, "players");
  displaysplashtoplayers(players, splash_key, params, var_42b1e877ab187c6);
}

function displaysplashtoplayers(players, splash_key, params, var_42b1e877ab187c6) {
  assertex(isDefined(splash_key), "<dev string:x1c1>");

  foreach(player in players) {
    if(player br_public::isplayeringulag()) {
      continue;
    }

    if(isbot(player) && br_public::istutorial()) {
      continue;
    }

    if(isDefined(params)) {
      if(isDefined(params.excludedplayers)) {
        if(utility::array_contains(params.excludedplayers, player)) {
          continue;
        }
      }
    }

    displayplayersplash(player, splash_key, params, var_42b1e877ab187c6);
  }
}

function displayplayersplash(player, splash_key, params, var_42b1e877ab187c6) {
  assertex(isDefined(splash_key), "<dev string:x187>" + player.name);

  if(isDefined(params) && isDefined(params.packedbits)) {
    player thread hud_message::showsplash(splash_key, params.packedbits, undefined, undefined, undefined, var_42b1e877ab187c6);
    return;
  }

  if(isDefined(params) && isDefined(params.intvar)) {
    player thread hud_message::showsplash(splash_key, params.intvar, undefined, undefined, undefined, var_42b1e877ab187c6);
    return;
  }

  player thread hud_message::showsplash(splash_key, undefined, undefined, undefined, undefined, var_42b1e877ab187c6);
}

function function_4bcd7c36b22b9bec(splash_key) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getContractSplashRefOverride")) {
    splash_key = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getContractSplashRefOverride", self, splash_key);
  }

  return splash_key;
}

function displaysquadmessagetoplayer(player_ref, state, missionid) {
  player = player_ref getentitynumber();

  if(!isDefined(state)) {
    state = 0;
  }

  if(!isDefined(player)) {
    player = 0;
  }

  if(!isDefined(missionid)) {
    missionid = 0;
  }

  value = 0;
  value = missionid << 12 | player << 4 | state;
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

function displaysquadmessagetoteam(team, player_ref, state, missionid) {
  foreach(player in teams::getteamdata(team, "players")) {
    player displaysquadmessagetoplayer(player_ref, state, missionid);
  }
}

function giveplayerpoints(player, ref) {
  player thread points::doscoreevent(ref);
}

function giveteampoints(team, ref) {
  foreach(player in teams::getteamdata(team, "players")) {
    player thread points::doscoreevent(ref);
  }
}

function giveteamplunderflat(team, amount) {
  var_8e3c5f90e4f80a58 = getdvarfloat(@ "hash_7165dad703502609", 0.4);
  var_2cefa8f8a2ba6bfe = 0;

  foreach(player in teams::getteamdata(team, "players")) {
    if(isbot(player) && br_public::istutorial()) {
      continue;
    }

    var_36773a58eb035bff = amount;

    if(!player::isreallyalive(player)) {
      var_36773a58eb035bff = int(amount * var_8e3c5f90e4f80a58);
    } else {
      var_36773a58eb035bff = int(var_36773a58eb035bff * function_fd4c76c90a1a0333(player));
    }

    player br_plunder::playerplunderpickup(var_36773a58eb035bff);
    level.br_plunder.plunder_awarded_by_missions_total += var_36773a58eb035bff;
  }
}

function giveteamplunderdistributive(players, amount) {
  amountperplayer = int(amount / players.size);

  foreach(player in players) {
    if(isbot(player) && br_public::istutorial()) {
      continue;
    }

    var_18417c862feb0b9e = int(amountperplayer * function_fd4c76c90a1a0333(player));
    player br_plunder::playerplunderpickup(var_18417c862feb0b9e);
    level.br_plunder.plunder_awarded_by_missions_total += var_18417c862feb0b9e;
    br_analytics::trackcashevent(player, "mission", var_18417c862feb0b9e);
  }
}

function dropplunder(ammount, var_5b7bf3433d244cdf, var_76212928fed46301, var_41271de03a84a690) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  info_name = 0;
  info_scale = 1;
  info_percent = 2;
  var_82c3fc1e774a5a35[0] = ["brloot_plunder_cash_uncommon_3", level.br_plunder.quantityepic, getdvarfloat(@ "hash_53dd15287f7df644", 0.2)];
  var_82c3fc1e774a5a35[1] = ["brloot_plunder_cash_uncommon_2", level.br_plunder.quantityrare, getdvarfloat(@ "hash_8fa17586ac872da9", 0.3)];
  var_82c3fc1e774a5a35[2] = ["brloot_plunder_cash_uncommon_1", level.br_plunder.quantitycommon, getdvarfloat(@ "hash_30bf1dd438567db0", 0.5)];
  totalpercent = 0;

  for(i = 0; i < var_82c3fc1e774a5a35.size; i++) {
    info = var_82c3fc1e774a5a35[i];
    totalpercent += info[info_percent];
  }

  plundertotal = 0;

  for(i = 0; i < var_82c3fc1e774a5a35.size; i++) {
    info = var_82c3fc1e774a5a35[i];
    info[info_percent] /= totalpercent;
    plundertotal += info[info_scale] * info[info_percent];
  }

  numdrops = ammount / plundertotal;
  rewardremaining = ammount;
  plunderdrops = [];

  for(i = 0; i < var_82c3fc1e774a5a35.size; i++) {
    info = var_82c3fc1e774a5a35[i];
    plunderdrops[i] = int(numdrops * info[info_percent]);
    rewardremaining -= plunderdrops[i] * info[info_scale];
  }

  if(rewardremaining > 0) {
    for(i = 0; i < var_82c3fc1e774a5a35.size; i++) {
      info = var_82c3fc1e774a5a35[i];
      extra = int(rewardremaining / info[info_scale]);
      plunderdrops[i] += extra;
      rewardremaining -= extra * info[info_scale];
    }
  }

  droptypes = [];

  for(i = 0; i < plunderdrops.size; i++) {
    for(j = 0; j < plunderdrops[i]; j++) {
      droptypes[droptypes.size] = i;
    }
  }

  droptypes = utility::array_randomize(droptypes);
  dropstruct = br_pickups::function_7b9f3966a7a42003();

  for(i = 0; i < droptypes.size; i++) {
    dropinfo = br_pickups::getitemdroporiginandangles(dropstruct, var_5b7bf3433d244cdf, var_76212928fed46301, var_41271de03a84a690);
    br_pickups::spawnpickup(var_82c3fc1e774a5a35[droptypes[i]][info_name], dropinfo, var_82c3fc1e774a5a35[droptypes[i]][info_scale], 1);
  }

  level.br_plunder.plunder_awarded_by_missions_total += ammount;
  level thread br_plunder::dropplundersounds(var_5b7bf3433d244cdf, droptypes.size);
}

function function_d282041688c032b5(category) {
  contractref = tablelookup("mp/brmissions.csv", 1, category, 18);
  contractbundle = function_99b5f579a15f808d(contractref);
  cashreward = contractbundle.cashreward;

  if(!isDefined(cashreward)) {
    return 0;
  }

  return cashreward;
}

function function_854eaac890bc7c17(category, column, nullreturn) {
  if(category == "intel") {
    category = "intel_upload";
  }

  data = tablelookup("mp/brmissions.csv", 1, category, column);

  if(!isDefined(data) || data == "") {
    return nullreturn;
  }

  return int(data);
}

function function_d857e2fd8227f1bd(type, nocircle) {
  mincircle = type.var_8d4889067c776936;
  maxcircle = type.var_839e7395b90ff0ec;

  if(istrue(nocircle)) {
    if(mincircle <= 0) {
      return 1;
    } else {
      return 0;
    }
  }

  if(level.br_circle.circleindex < mincircle) {
    return 0;
  }

  if(level.br_circle.circleindex > maxcircle && maxcircle != -1) {
    return -1;
  }

  return 1;
}

function function_d212a5e7a40d7c8d(contractname, team, rewardposition, contract) {
  contractbundle = function_99b5f579a15f808d(contractname);
  groupref = contractbundle.rewardgroup;

  if(isDefined(groupref) && groupref != "") {
    return function_6ddd1eecbe562acf(groupref, team, rewardposition, contract);
  }
}

function function_6ddd1eecbe562acf(groupref, team, rewardposition, contract) {
  if(isDefined(groupref) && groupref != "") {
    rewards = br_quest_util::givequestrewardgroup(groupref, team, rewardposition.origin, rewardposition.angles);

    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("modifyBaseContractRewards")) {
      scripts\mp\gametypes\br_gametypes::function_d72afdccedfc9b07("modifyBaseContractRewards", team, contract, rewards);
    }

    return rewards;
  }
}

function finishcontract(task, instance, team) {
  if(isDefined(task.type.funcs["onFinishContract"])) {
    task thread[[task.type.funcs["onFinishContract"]]](task, instance, team);
    return true;
  }

  return false;
}

function function_3d262d56274bd22e(ref) {
  return level.contractmanager.var_766f9de01948c219[ref].index;
}

function getquestindex(ref) {
  return level.contractmanager.var_8f51bbe0d6629b2c[ref].index;
}

function getquesttableindex(ref) {
  index = int(tablelookup("mp/brmissions.csv", 1, ref, 0));
  return index;
}

function uiobjectiveshow(ref) {
  assert(isPlayer(self));
  index = getquestindex(ref);
  setquestindexomnvar(index);
}

function uiobjectiveshowtoteam(ref, team) {
  foreach(player in teams::getteamdata(team, "players")) {
    player uiobjectiveshow(ref);
  }
}

function uiobjectivehide() {
  assert(isPlayer(self));
  setquestindexomnvar(0);
}

function uiobjectivehidefromteam(team) {
  foreach(player in teams::getteamdata(team, "players")) {
    player uiobjectivehide();
  }
}

function function_e2aa45e2c6b5dec1(value, value2) {
  foreach(player in teams::getteamdata(self.teams[0], "players")) {
    player uiobjectivesetparameter(value, value2);
  }
}

function uiobjectivesetparameter(value, value2) {
  assert(isPlayer(self));
  self setclientomnvar("ui_br_objective_param", value);

  if(isDefined(value2)) {
    assertex(isDefined(value), "<dev string:x1f6>");
    self setclientomnvar("ui_br_objective_extraParam", value2);
  }
}

function uiobjectivesetlootid(value) {
  assert(isPlayer(self));
  self setclientomnvar("ui_br_objective_loot_id", value);
}

function createquestobjicon(iconref, state, var_38116998df9814d4) {
  self.objectiveiconid = objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    objidpoolmanager::objective_add_objective(self.objectiveiconid, state, (0, 0, 0), iconref);
    objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 4);
    objective_showtoplayersinmask(self.objectiveiconid);
    objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_38116998df9814d4)) {
      movequestobjicon(var_38116998df9814d4);
    }

    return;
  }

  println(self.category + "<dev string:x23b>");
}

function movequestobjicon(neworigin) {
  objidpoolmanager::update_objective_position(self.objectiveiconid, neworigin);
}

function showquestobjicontoplayer(player) {
  objective_addclienttomask(self.objectiveiconid, player);
}

function showquestobjicontoall(objid) {
  objective_addalltomask(objid);
}

function hidequestobjiconfromplayer(player) {
  objective_removeclientfrommask(self.objectiveiconid, player);
}

function checkforactiveobjicon() {
  return isDefined(self.objectiveiconid);
}

function deletequestobjicon() {
  objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

function function_425f0abdafad5a76(objectiveidnum, teamname, iselite) {
  players = getteamdata(teamname, "players");

  foreach(player in players) {
    if(isreallyalive(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
      if(istrue(iselite)) {
        questchain = namespace_b11d742e70949af1::function_c6ec58a3c19cd74d(teamname);

        if(isDefined(questchain)) {
          objective_addclienttomask(objectiveidnum, player);
        }

        continue;
      }

      objective_addclienttomask(objectiveidnum, player);
    }
  }
}

function function_42a0806457ea8039(player) {
  if(!isDefined(player.team) || !isDefined(self.teams[0])) {
    return false;
  }

  if(player.team == self.teams[0]) {
    return true;
  }

  return false;
}

function utilflare_shootflare(spawn_origin, flaretype, var_30a49dc77e377647, var_ff51d4e9d2fae932) {
  level endon("game_ended");
  content_filter = trace::create_contents(0, 1, 0, 1, 0, 0, 0);
  new_position = trace::ray_trace(spawn_origin + (0, 0, 4000), spawn_origin, undefined, content_filter, undefined, 1)["position"];

  if(!isDefined(var_30a49dc77e377647)) {
    var_30a49dc77e377647 = 0;
  }

  if(istrue(var_30a49dc77e377647)) {
    flare = spawn("script_model", spawn_origin);
  } else {
    flare = spawn("script_model", new_position);
  }

  if(!isDefined(flare)) {
    return;
  }

  start_pos = flare.origin;
  flare.angles = vectortoangles((0, 0, 1));

  if(isDefined(var_ff51d4e9d2fae932)) {
    flare setModel("equip_flare_ob");
  } else {
    flare setModel("equip_flare_br");
  }

  wait 0.5;
  start_state = isDefined(flaretype) && flare getscriptableparthasstate("launch", "start_" + flaretype) ? "start_" + flaretype : "start";
  flare setscriptablepartstate("launch", start_state, 0);
  travel_state = isDefined(flaretype) && flare getscriptableparthasstate("travel", "start_" + flaretype) ? "start_" + flaretype : "start";

  if(isDefined(flaretype)) {
    if(flaretype == "4th_july") {
      playsoundatpos(start_pos, "mus_iw9_flare_launch_stinger_july4");
    }
  }

  flare setscriptablepartstate("travel", travel_state, 0);
  flare thread _utilflare_lerpflare(flaretype);
}

function _utilflare_lerpflare(flaretype) {
  self endon("death");
  level endon("game_ended");
  movetime = 3.125;
  self moveTo(self.origin + (0, 0, 2500), movetime);
  wait movetime;
  _utilflare_flareexplode(flaretype);
}

function _utilflare_flareexplode(flaretype) {
  if(!isDefined(flaretype)) {
    flaretype = "<undefined>";
  }

  self setscriptablepartstate("travel", "off", 0);

  if(!_utilflare_isvalidflaretype(flaretype)) {
    assertmsg("<dev string:x25a>" + flaretype + "<dev string:x10a>");
    return;
  }

  fxstate = "start_" + flaretype;
  self setscriptablepartstate("explode", fxstate, 0);
  thread sfx_br_flare_phosphorus(flaretype);
}

function _utilflare_isvalidflaretype(flaretype) {
  validflaretype = 0;

  if(isDefined(flaretype)) {
    switch (flaretype) {
      case #"hash_81d3708cb9f6fbd":
      case #"hash_3d59be23329d4272":
      case #"hash_46a03ade8d786057":
      case #"hash_b06d15a59bd8ea50":
      case #"hash_c03ed6f6f4fe9dad":
      case #"hash_f4a9126c03d3385b":
        validflaretype = 1;
        break;
    }
  }

  return validflaretype;
}

function sfx_br_flare_phosphorus(flaretype) {
  self endon("death");
  level endon("game_ended");
  var_779efa68800909d1 = isDefined(flaretype) && self getscriptableparthasstate("phosphorus", "start_" + flaretype) ? "start_" + flaretype : "start";
  var_7593f454aad2cf18 = isDefined(flaretype) && self getscriptableparthasstate("phosphorus_loop", "start_" + flaretype) ? "start_" + flaretype : "start";
  var_c18aafa4107a3316 = isDefined(flaretype) && self getscriptableparthasstate("phosphorus", "end_" + flaretype) ? "end_" + flaretype : "end";
  self setscriptablepartstate("phosphorus", var_779efa68800909d1, 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", var_7593f454aad2cf18, 0);

  switch (flaretype) {
    case #"hash_46a03ade8d786057":
      wait 40;
      break;
    case #"hash_f4a9126c03d3385b":
      break;
    case #"hash_81d3708cb9f6fbd":
      wait 2;
      break;
    default:
      wait 12;
      break;
  }

  self setscriptablepartstate("phosphorus", var_c18aafa4107a3316, 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

function questpointgetradius(point) {
  radius = 0;

  if(point.spawnflags & 4) {
    radius = 256;
  } else if(point.spawnflags & 2) {
    radius = 128;
  } else if(point.spawnflags & 1) {
    radius = 168;
  }

  return radius;
}

function function_99b5f579a15f808d(contractname) {
  return getscriptbundle(hashcat(%"hash_371be13214f11a56", contractname));
}

function function_ea591c2a379e3424(category) {
  contractbundle = function_99b5f579a15f808d(category);
  contracttime = contractbundle.contracttime;
  var_fe0b0c4257304fd0 = contractbundle.var_fe0b0c4257304fd0;
  var_e3ff9548e1cedc29 = int(contractbundle.var_92e42e850baa0f1f);

  if(istrue(var_fe0b0c4257304fd0) && istrue(var_e3ff9548e1cedc29 > 0) && scripts\mp\utility\game::getsubgametype() == "resurgence") {
    contracttime = var_e3ff9548e1cedc29;
  }

  if(!isDefined(contracttime)) {
    return 0;
  }

  return contracttime;
}

function function_2a81be592adacdaa(contractref) {
  if(!isDefined(level.contractmanager) || !isDefined(level.contractmanager.var_766f9de01948c219)) {
    return undefined;
  }

  return level.contractmanager.var_766f9de01948c219[contractref];
}

function function_5a15174d34f0670c(time, animbuffer) {
  if(!isDefined(animbuffer)) {
    animbuffer = 0;
  }

  self.totaltime = time + animbuffer;

  foreach(player in teams::getteamdata(self.teams[0], "players")) {
    player setclientomnvar("ui_br_objective_duration_time", self.totaltime * 1000);
  }

  self.missionstarttime = gettime();
  self.missiontime = self.missionstarttime + self.totaltime * 1000;
  function_51d3a2b4cde79545();
}

function function_5606274c76b4a2df(time) {
  self.missiontime += time * 1000;
  remainingtime = self.missiontime - gettime();

  foreach(player in teams::getteamdata(self.teams[0], "players")) {
    player setclientomnvar("ui_br_objective_duration_time", remainingtime);
  }

  function_51d3a2b4cde79545();
}

function function_234c4428a084ca58(time) {
  if(self.missiontime - gettime() <= 1000) {
    return;
  }

  if(self.missiontime - gettime() - time * 1000 <= 0) {
    self.missiontime = gettime() + 1000;
  } else {
    self.missiontime -= time * 1000;
  }

  remainingtime = self.missiontime - gettime();

  foreach(player in teams::getteamdata(self.teams[0], "players")) {
    player setclientomnvar("ui_br_objective_duration_time", remainingtime);
  }

  function_51d3a2b4cde79545();
}

function function_51d3a2b4cde79545() {
  foreach(player in teams::getteamdata(self.teams[0], "players")) {
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }

  contractdata = function_2a81be592adacdaa(self.category);
  updatefunc = contractdata.funcs["onTimerUpdate"];

  if(isDefined(updatefunc)) {
    [[updatefunc]]();
  }

  thread function_b58cd7d548d363b4();
}

function function_b58cd7d548d363b4() {
  self notify("updatecontractTimer");
  self endon("game_ended");
  self endon("updatecontractTimer");
  self endon("task_ended");
  waittime = (self.missiontime - gettime()) / 1000;

  if(waittime < 0) {
    self.missiontime = gettime() + 1000;
    waittime = (self.missiontime - gettime()) / 1000;
  }

  wait waittime;
  contractdata = function_2a81be592adacdaa(self.category);
  expiredfunc = contractdata.funcs["onTimerExpired"];

  if(isDefined(expiredfunc)) {
    [[expiredfunc]]();
  }
}

function questrewardcirclepeek(team) {
  namespace_1a2fa2b6ae5d223c::function_647a8c40104e4866(team);
}

function function_496ed653faacacd2(rewardteam) {
  var_20bf70e9bc435ed5 = self;

  if(isDefined(var_20bf70e9bc435ed5) && player::isreallyalive(var_20bf70e9bc435ed5) && !var_20bf70e9bc435ed5 br_public::isplayeringulag()) {
    var_20bf70e9bc435ed5 br_pickups::forcegivesuper("super_supply_drop", 1, 0, 0, 0);
    return;
  }

  foreach(player in teams::getteamdata(rewardteam, "players")) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(var_20bf70e9bc435ed5) && player == var_20bf70e9bc435ed5) {
      continue;
    }

    if(!player::isreallyalive(player)) {
      continue;
    }

    if(player br_public::isplayeringulag()) {
      continue;
    }

    player br_pickups::forcegivesuper("super_supply_drop", 1, 0, 0, 0);
    break;
  }
}

function function_9b6275085fbcb8f4(time) {
  if(br_gametypes::isbrgametypefuncdefined("contractTimeModify")) {
    time = br_gametypes::runbrgametypefunc("contractTimeModify", self, time);
  }

  if(br_gametypes::isbrgametypefuncdefined("getSpecialContractTime")) {
    time = br_gametypes::runbrgametypefunc("getSpecialContractTime", self, time);
  }

  return time;
}

function function_f69c3e487b364f2f(time) {
  if(br_gametypes::isbrgametypefuncdefined("contractTimeAddModify")) {
    time = br_gametypes::runbrgametypefunc("contractTimeAddModify", self, time);
  }

  return time;
}

function getquestrewardtier(team) {
  tier = level.contractmanager.tiers[team];

  if(!isDefined(tier)) {
    tier = 1;
  }

  return tier;
}

function setquestrewardtier(team, tier) {
  if(isDefined(level.contractmanager)) {
    level.contractmanager.tiers[team] = tier;
  }

  setquestrewardtierteamomnvar(team, tier);
}

function addquestrewardtier(team, value) {
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

function addquestrewardtierframeend(team, value) {
  waittillframeend();
  setquestrewardtier(team, getquestrewardtier(team) + value);
}

function function_473ab9452660e60f(ref) {
  index = getquesttableindex(ref);

  foreach(team in self.teams) {
    players = teams::getteamdata(team, "players");

    foreach(player in players) {
      player setquestindexomnvar(index);
    }
  }
}

function setquestindexteamomnvar(team, questindex) {
  foreach(player in teams::getteamdata(team, "players")) {
    player setquestindexomnvar(questindex);
  }
}

function setquestindexomnvar(questindex) {
  self setclientomnvar("ui_br_objective_index", questindex);
}

function setquestrewardtierteamomnvar(team, tier) {
  foreach(player in teams::getteamdata(team, "players")) {
    player setquestrewardtieromnvar(tier);
  }
}

function setquestrewardtieromnvar(tier) {
  self setclientomnvar("ui_br_objective_reward_tier", tier);
}

function function_19582ba0dbcc0ab0(targetplayer, threatlevel) {
  if(isDefined(self.aq_targethudenabled) && self.aq_targethudenabled && isDefined(targetplayer)) {
    entitynumber = targetplayer getentitynumber();
  } else {
    entitynumber = -1;
  }

  entitynumber += 1;
  value = threatlevel << 8 | entitynumber;
  self setclientomnvar("ui_br_assassination_target", value);
}

function function_ab19a58fc4be9ce2() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(!level.contractmanager.var_2bdaf97f6bfeab76 || isbot(player)) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_animatic_complete");

  while(level.contractmanager.activetablets.size > 0) {
    player waittill("calloutmarkerping_notifyhandled", notification);

    if(notification != "custom_loot_card_update") {
      continue;
    }

    if(!isreallyalive(player)) {
      continue;
    }

    closestphone = function_c1ac85f526f2b937(level.contractmanager.activetablets, player.origin, 400);

    if(isDefined(closestphone)) {
      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("setCloseByContractStatusOmnvar")) {
        scripts\mp\gametypes\br_gametypes::runbrgametypefunc("setCloseByContractStatusOmnvar", player, closestphone.task);
      }

      if(istrue(player.canhackcontracts)) {
        namespace_735f8af4d2aa34fb::function_4f6916c4e48cc55(closestphone, player);
      }
    }
  }
}

function private function_2651277c09935bde(mindistancesq) {
  level endon("<dev string:x291>");
  level waittill("<dev string:x29f>");

  foreach(phone in level.contractmanager.activetablets) {
    if(!isDefined(phone)) {
      continue;
    }

    foreach(otherphone in level.contractmanager.activetablets) {
      if(!isDefined(otherphone)) {
        continue;
      }

      if(phone == otherphone) {
        continue;
      }

      if(distancesquared(phone.origin, otherphone.origin) <= mindistancesq) {
        println("<dev string:x2af>");
      }
    }
  }
}

function function_6bdc6f56944dc3aa(player, oldteam, newteam) {
  foreach(task in level.contractmanager.currenttasks) {
    if(task.type.ref == "assassination") {
      if(task.targetplayer == player) {
        if(isDefined(task.type.funcs["onTargetAssimilated"])) {
          task[[task.type.funcs["onTargetAssimilated"]]](player, oldteam, newteam);
        }

        continue;
      }

      if(task.targetplayer.team == oldteam) {
        if(isDefined(task.type.funcs["onTargetTeamTearDown"])) {
          task[[task.type.funcs["onTargetTeamTearDown"]]](player, oldteam, newteam);
        }

        continue;
      }

      if(task.targetplayer.team == newteam) {
        if(isDefined(task.type.funcs["onTargetTeamAssimilated"])) {
          task[[task.type.funcs["onTargetTeamAssimilated"]]](player, oldteam, newteam);
        }
      }
    }
  }

  if(isDefined(level.contractmanager.var_b6fae9c9655c73bf[oldteam])) {
    if(isDefined(level.contractmanager.var_b6fae9c9655c73bf[oldteam].type.funcs["onPlayerTearDown"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(level.contractmanager.var_b6fae9c9655c73bf[oldteam].teams[0] == task.teams[0]) {
          task[[task.type.funcs["onPlayerTearDown"]]](player, oldteam, newteam);
        }
      }
    }
  }

  if(isDefined(level.contractmanager.var_b6fae9c9655c73bf[newteam])) {
    if(isDefined(level.contractmanager.var_b6fae9c9655c73bf[newteam].type.funcs["onPlayerAssimilated"])) {
      foreach(task in level.contractmanager.currenttasks) {
        if(level.contractmanager.var_b6fae9c9655c73bf[newteam].teams[0] == task.teams[0]) {
          task thread function_17d78a198feb85d5(player, oldteam, newteam);
        }
      }
    }
  }

  namespace_1a2fa2b6ae5d223c::function_b8022b0e5e976f66(oldteam, newteam);
}

function function_17d78a198feb85d5(player, oldteam, newteam) {
  level endon("game_ended");
  self endon("task_ended");
  waitframe();
  self[[self.type.funcs["onPlayerAssimilated"]]](player, oldteam, newteam);
}

function function_8a25384bacdd7b79(newtablet, lootref) {
  if(!isDefined(level.contractmanager.contractdata)) {
    return;
  }

  foreach(data in level.contractmanager.contractdata) {
    if(data.lootref == lootref) {
      newtablet tabletinit(data);
      break;
    }
  }
}

function function_870ec8b83fc533fd() {
  level endon("<dev string:x291>");

  while(true) {
    foreach(data in level.contractmanager.contractdata) {
      ref = data.ref;
      dvar = hashcat(@ "hash_1fbd753c98c4b8b4", ref);

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);

        foreach(tablet in level.contractmanager.activetablets) {
          if(tablet.type == data.lootref) {
            level.players[0] function_bb413728bc5231d0(tablet);
            break;
          }
        }
      }

      dvar = @ "hash_79cdeeba217bc3d8";

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);
        task = level.contractmanager.var_b6fae9c9655c73bf[level.players[0].team];
        task endcontract(task.teams[0]);
      }

      dvar = @ "hash_99194b03dd977e5";

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);
        task = level.contractmanager.var_b6fae9c9655c73bf[level.players[0].team];
        task endcontract(undefined);
      }

      dvar = hashcat(@ "hash_8f2895efe9ecd943", ref);

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);
        tablet = spawnscriptable(data.lootref, level.players[0].origin);
        br_pickups::registerscriptableinstance(tablet);
        tablet tabletinit(data);
        tablet tabletshow();
      }

      dvar = hashcat(@ "hash_511c5d962c539aa8", ref);

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);

        foreach(teamdata in level.teamdata) {
          if(istrue(teamdata["<dev string:x351>"].size > 0)) {
            if(teamdata["<dev string:x351>"][0].team != level.players[0].team) {
              function_22671614e8f79513(teamdata["<dev string:x351>"][0], ref);
            }
          }
        }
      }

      dvar = hashcat(@ "hash_7b9d7f89b65a3054", ref);

      if(getdvarint(dvar, 0)) {
        setDvar(dvar, 0);

        foreach(teamdata in level.teamdata) {
          if(istrue(teamdata["<dev string:x351>"].size > 0)) {
            if(isDefined(level.contractmanager) && isDefined(level.contractmanager.var_b6fae9c9655c73bf)) {
              if(isDefined(level.contractmanager.var_b6fae9c9655c73bf[teamdata["<dev string:x351>"][0].team])) {
                continue;
              }
            }

            if(teamdata["<dev string:x351>"][0].team != level.players[0].team) {
              function_22671614e8f79513(teamdata["<dev string:x351>"][0], ref);
              break;
            }
          }
        }
      }
    }

    var_6be853beafdcc6f2 = getdvarint(@ "hash_86d0a6d671419333", 0);

    if(var_6be853beafdcc6f2 > 0) {
      setDvar(@ "hash_86d0a6d671419333", 0);
      var_6be853beafdcc6f2 = min(var_6be853beafdcc6f2, level.contractmanager.activetablets.size);

      foreach(tablet in level.contractmanager.activetablets) {
        tablet tablethide();
        var_6be853beafdcc6f2 -= 1;

        if(var_6be853beafdcc6f2 <= 0) {
          break;
        }
      }
    }

    wait 0.5;
  }
}

function function_22671614e8f79513(player, contractref) {
  if(!isDefined(player.team) || !isDefined(level.contractmanager.contractdata) || !isDefined(level.contractmanager.var_766f9de01948c219[contractref])) {
    return;
  }

  newtablet = undefined;

  foreach(data in level.contractmanager.contractdata) {
    ref = data.ref;

    if(ref == contractref) {
      newtablet = spawnscriptable(data.lootref, (0, 0, 0), (0, 0, 0));
      br_pickups::registerscriptableinstance(newtablet);
      newtablet tabletinit(data);
      break;
    }
  }

  if(!isDefined(newtablet)) {
    return;
  }

  newtablet.task function_8ad1b4ddc1fd852a(player.team, player);
  newtablet.task[[level.contractmanager.var_766f9de01948c219[contractref].funcs["<dev string:x361>"]]]();
}

function function_94a8dc26f5353759(player, defaultfilter) {
  filter = undefined;

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getContractManagerFilter")) {
    filter = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getContractManagerFilter", player);
  }

  if(!isDefined(filter)) {
    filter = defaultfilter;
  }

  return filter;
}

function filtercondition_isdead(player) {
  if(!isalive(player)) {
    return false;
  }

  return true;
}

function filtercondition_ingulag(player) {
  if(player br_public::isplayerinorgoingtogulag()) {
    return false;
  }

  return true;
}

function function_40cb2b7beb4efff1(player) {
  if(istrue(player.br_iseliminated)) {
    return false;
  }

  return true;
}

function function_eb0a92e43754af9f(team) {
  validplayers = [];

  foreach(player in teams::getteamdata(team, "players")) {
    if(!player br_public::isplayerinorgoingtogulag() && player::isreallyalive(player)) {
      validplayers[validplayers.size] = player;
    }
  }

  return validplayers;
}

function function_581c09aed5aa4ed7(team) {
  var_f67f078b2693e6c8 = getdvarint(@ "hash_9d25d6735879edd5", 1);
  var_e2fcc37fccc34974 = getdvarint(@ "hash_896b3c10c7a229fa", 1);
  var_ddb222c7faf5ab50 = getdvarint(@ "hash_6d95fadfacaba24f", 60);

  if(!isDefined(level.teamdata[team]["currentContractCancels"])) {
    level.teamdata[team]["currentContractCancels"] = 0;
  }

  if(var_f67f078b2693e6c8 > 0) {
    if(level.teamdata[team]["currentContractCancels"] == var_f67f078b2693e6c8 - 1 && var_e2fcc37fccc34974) {
      level.teamdata[team]["cancelDelayTime"] = gettime() + var_ddb222c7faf5ab50 * 1000;
      level.teamdata[team]["currentContractCancels"]++;
      return true;
    } else if(level.teamdata[team]["currentContractCancels"] >= var_f67f078b2693e6c8) {
      if(var_e2fcc37fccc34974) {
        if(gettime() < level.teamdata[team]["cancelDelayTime"]) {
          self.var_972eddbdcf30619c = [];
          playersonteam = function_eb0a92e43754af9f(team);

          foreach(player in playersonteam) {
            n = (level.teamdata[team]["cancelDelayTime"] - gettime()) / 1000;
            n = int(max(0, ceil(n)));
            player hud_message::showerrormessage(level.contractmanager.var_5c6031bde94872a7, n);
          }

          return false;
        }

        level.teamdata[team]["cancelDelayTime"] = gettime() + var_ddb222c7faf5ab50 * 1000;
        level.teamdata[team]["currentContractCancels"]++;
        return true;
      } else {
        self.var_972eddbdcf30619c = [];
        playersonteam = function_eb0a92e43754af9f(team);

        foreach(player in playersonteam) {
          player hud_message::showerrormessage(level.contractmanager.cancelmessage);
        }

        return false;
      }
    }
  }

  level.teamdata[team]["currentContractCancels"]++;
  return true;
}

function function_31378ee55a2fb527(team) {
  if(isDefined(self.type.funcs["onCancel"])) {
    self thread[[self.type.funcs["onCancel"]]](team);
  }
}

function function_c142d6b260f19ee7(team) {
  if(!isDefined(self.var_972eddbdcf30619c)) {
    self.var_972eddbdcf30619c = [];
  }

  numplayers = 0;
  playersonteam = function_eb0a92e43754af9f(team);

  foreach(player in playersonteam) {
    if(utility::array_contains(self.var_972eddbdcf30619c, player)) {
      numplayers++;
    }
  }

  return numplayers;
}

function function_1d3d389050ddce74(team) {
  if(!isDefined(self.var_972eddbdcf30619c)) {
    self.var_972eddbdcf30619c = [];
  }

  playersonteam = function_eb0a92e43754af9f(team);

  if(function_c142d6b260f19ee7(team) == playersonteam.size && function_581c09aed5aa4ed7(team)) {
    level thread overlord::function_9793a81bc3bc19e9("mission_cancel_complete", team, 1);
    function_31378ee55a2fb527(team);

    foreach(player in playersonteam) {
      player setclientomnvar("ui_br_contract_cancellation_state", 0);
    }

    level thread br_public::brleaderdialogteam("mission_gen_fail", team, 1, 2);
    displayteamsplash(team, "br_contract_cancelled_" + self.type.ref);
    return true;
  }

  return false;
}

function function_db96249c7bfdec0b() {
  if(isDefined(self) && isDefined(self.team) && function_7094c7010c5e3827(self.team)) {
    contract = function_22239d4cff05d0a1(self.team);

    if(!isDefined(contract)) {
      assertmsg("<dev string:x373>");
      return;
    }

    if(!isDefined(contract.type.funcs["onCancel"])) {
      assertmsg("<dev string:x3c0>");
      return;
    }

    if(!isDefined(contract.var_972eddbdcf30619c)) {
      contract.var_972eddbdcf30619c = [];
    }

    if(utility::array_contains(contract.var_972eddbdcf30619c, self)) {
      contract function_1d3d389050ddce74(self.team);
      return;
    }

    contract.var_972eddbdcf30619c[contract.var_972eddbdcf30619c.size] = self;

    if(!contract function_1d3d389050ddce74(self.team)) {
      squadmates = function_eb0a92e43754af9f(self.team);
      overlord::playevent("mission_cancel_request", utility::array_remove_array(squadmates, contract.var_972eddbdcf30619c));
      var_7aa06be6f06bef26 = contract function_c142d6b260f19ee7(self.team);
      totalplayers = squadmates.size;
      combineddata = var_7aa06be6f06bef26 | totalplayers << 3;

      foreach(player in squadmates) {
        player setclientomnvar("ui_br_contract_cancellation_state", combineddata);
      }

      if(contract.var_972eddbdcf30619c.size > 0) {
        foreach(player in squadmates) {
          if(!utility::array_contains(contract.var_972eddbdcf30619c, player)) {
            displayplayersplash(player, "br_" + contract.type.ref + "_quest_pending");
          }
        }
      }
    }
  }
}

function function_1e64ea5eb68d8119() {
  if(isDefined(self) && isDefined(self.team) && function_7094c7010c5e3827(self.team)) {
    contract = function_22239d4cff05d0a1(self.team);
    squadmates = function_eb0a92e43754af9f(self.team);

    if(!isDefined(contract)) {
      assertmsg("<dev string:x373>");
      return;
    }

    if(!isDefined(contract.var_972eddbdcf30619c)) {
      return;
    }

    if(utility::array_contains(contract.var_972eddbdcf30619c, self)) {
      if(br_public::isplayerinorgoingtogulag() || !player::isreallyalive(self)) {
        contract.var_972eddbdcf30619c = utility::array_remove(contract.var_972eddbdcf30619c, self);
      }
    }

    if(!contract function_1d3d389050ddce74(self.team)) {
      overlord::playevent("mission_cancel_request", utility::array_remove_array(squadmates, contract.var_972eddbdcf30619c));
      var_7aa06be6f06bef26 = contract function_c142d6b260f19ee7(self.team);
      totalplayers = squadmates.size;
      combineddata = var_7aa06be6f06bef26 | totalplayers << 3;

      foreach(player in squadmates) {
        player setclientomnvar("ui_br_contract_cancellation_state", combineddata);
      }
    }
  }
}

function function_7871e27c25160f63(notification, value) {
  if(isDefined(notification)) {
    switch (notification) {
      case #"hash_9fd64c8b171158f":
        function_db96249c7bfdec0b();
        break;
    }
  }
}

function private function_60094dbeee6e39b0(tabletorigin) {
  isunderwater = 0;
  waterheightz = function_b81e710fd636efab(tabletorigin);

  if(isDefined(waterheightz)) {
    diffz = tabletorigin[2] - waterheightz;
    isunderwater = diffz < 0;
  }

  return isunderwater;
}

function function_bef688acd85ee3a3(origin, mindistsq, maxdistsq, var_1755f8f0fbb09238, var_b5e1bcfc83fba4ff) {
  var_7ba061ecae669f17 = getunusedlootcachepoints();
  var_666f1f70ea459696 = undefined;
  var_3c45d8fe5590f798 = [];
  circlecenter = scripts\mp\gametypes\br_circle::getnextsafecircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getnextsafecircleradius();

  foreach(point in var_7ba061ecae669f17) {
    if(function_60094dbeee6e39b0(point.origin)) {
      continue;
    }

    if(namespace_9823ee6035594d67::function_2cde636a73aead3d(point.origin)) {
      continue;
    }

    if(scripts\mp\gametypes\br_scavenger_quest::function_c096a9a3d859cfce(point.origin)) {
      continue;
    }

    if(scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245(point.origin)) {
      continue;
    }

    if(scripts\mp\locksandkeys::function_64332f29e2409e55(point.origin)) {
      continue;
    }

    if(istrue(var_1755f8f0fbb09238) && isDefined(circlecenter) && isDefined(circleradius)) {
      if(distance2dsquared(circlecenter, point.origin) > circleradius * circleradius) {
        continue;
      }
    }

    if(istrue(var_b5e1bcfc83fba4ff)) {
      var_3c45d8fe5590f798[var_3c45d8fe5590f798.size] = point;
    }

    dist = distance2dsquared(origin, point.origin);

    if(dist > mindistsq && dist < maxdistsq) {
      var_666f1f70ea459696 = point;
      break;
    }
  }

  if(!isDefined(var_666f1f70ea459696)) {
    if(var_3c45d8fe5590f798.size > 0) {
      var_666f1f70ea459696 = var_3c45d8fe5590f798[randomint(var_3c45d8fe5590f798.size)];
    } else {
      var_666f1f70ea459696 = var_7ba061ecae669f17[randomint(var_7ba061ecae669f17.size)];
    }
  }

  return var_666f1f70ea459696;
}