/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\mugger.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_9707038CB6";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 7);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 2500);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    level.mugger_bank_limit = getdvarint("_encstr_AA44162B71265F7D80FF5F25ADA9C6EF40E8616298717FF3", 10);
  }

  setteammode("_encstr_AC18045DF6D6");
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  level.ontimelimit = ::ontimelimit;
  level.onsuicidedeath = ::onsuicidedeath;
  level.onxpevent = ::onxpevent;
  level.assists_disabled = 1;
  level.mugger_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AC0C165715C32959094F22CB183F3C5171DB25D738342C5D");
  level.mugger_fx["_encstr_BE7206A2D07B1322"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level.mugger_targetfxid = loadfx("_encstr_88C41512E87E4705780BBF8E29F0DF9BAF436AB913DD13");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_840817A357F607E89377473F93D6ED288D3DA7FF5B835B1238", 0);
  scripts\mp\utility\game::registerroundswitchdvar("_encstr_95730738C30F3CA01A", 0, 0, 9);
  setdynamicdvar("_encstr_B24B16EF386B77FADB84E71F76E7431FD3F80B1BF06089B3", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_95730738C30F3CA01A", 1);
  setdynamicdvar("_encstr_83B914EBC03D01676374A7DD964E47D45D10F28208D9", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_95730738C30F3CA01A", 1);
  setdynamicdvar("_encstr_ADFE142B43AB488D30BF3F6FAE1140A9CC52957B77B1", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_95730738C30F3CA01A", 0);
  setdynamicdvar("_encstr_A557136E1B397D6BEAD9B395C9EB074E7BADED9159", 0);
  level.mugger_bank_limit = getmatchrulesdata("_encstr_843E0B7F2374B2A5283DF6BBB1", "_encstr_8FF30AB23BEBD85933FD6754");
  setdynamicdvar("_encstr_AA44162B71265F7D80FF5F25ADA9C6EF40E8616298717FF3", level.mugger_bank_limit);
  level.mugger_jackpot_limit = getmatchrulesdata("_encstr_843E0B7F2374B2A5283DF6BBB1", "_encstr_87780D5A591B705F3D73B160F51255");
  setdynamicdvar("_encstr_8ECC1963506D78CF4DAF17951A4728732F30DBE0493F0C93290465", level.mugger_jackpot_limit);
  level.mugger_throwing_knife_mug_frac = getmatchrulesdata("_encstr_843E0B7F2374B2A5283DF6BBB1", "_encstr_A1890FEB7A88289BFBB2FBE3DDD9F0A0D1");
  setdynamicdvar("_encstr_865A233B10EDD1B75344978DE63E1BA455D8E31273AF9997E8BB9E8568AD47AFE7083BEAC0", level.mugger_throwing_knife_mug_frac);
}

onprecachegametype() {
  precachemodel("_encstr_9AFE108CDEB31DB0ECE6FA96EE6ED799DBCA");
  precachemodel("_encstr_B228183493F844E7518643AA683A0F718825B58E33204F5784F8");
  precachempanim("_encstr_845B0F80326F10804A938B9F27535730E6");
  precacheshader("_encstr_B61512E406CBB9B839F3E0C1A347F1F9122F5ECE");
  precacheshader("_encstr_934515735787BB1D904D1BF12C32EFEB4FD0C9C7D4684D");
  precacheshader("_encstr_A11D11EE0BBC83F65AE68EEB4D16C66D38F6D1");
  precacheshader("_encstr_91F10D60BD897FE33BC8DA12700DDB");
  precachestring(&"_encstr_87B514A41A4559B8C877A7BF2F61E00929A6EC9F75EC");
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_920C126D9E55908B479983F771104D59978467D2");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_920C126D9E55908B479983F771104D59978467D2");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_879D181D85998DF0952BEBBF079758D5498D07D2DEB95308CE5B");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_A9D917D5269D58539F517B3FA9D80501EFCC2F1A3021509667");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.dogtags = [];
  level.mugger_timelimit = getdvarint("_encstr_86E01537B1C9AFDAAE3BECCA93FA8ED26B2B36B4D69647", 7);
  setdynamicdvar("_encstr_86E01537B1C9AFDAAE3BECCA93FA8ED26B2B26B4D69647", level.mugger_timelimit);
  scripts\mp\utility\game::registertimelimitdvar("_encstr_95730738C30F3CA01A", level.mugger_timelimit);
  level.mugger_scorelimit = getdvarint("_encstr_87BA16F34710513F3579EAF2E3180F16A00D9D64CB406483", 2500);

  if(level.mugger_scorelimit == 0)
    level.mugger_scorelimit = 2500;

  setdynamicdvar("_encstr_87BA16F34710513F3579EAF2E3180F16A00D9D44CB406483", level.mugger_scorelimit);
  scripts\mp\utility\game::registerscorelimitdvar("_encstr_95730738C30F3CA01A", level.mugger_scorelimit);
  level.mugger_bank_limit = getdvarint("_encstr_AA44162B71265F7D80FF5F25ADA9C6EF40E8616298717FF3", 10);
  level.mugger_muggernaut_window = getdvarint("_encstr_92351D878F7EB12D90D9F77F53E965AB5C2F470B6D2FDB0C99A36C858990A7", 3000);
  level.mugger_muggernaut_muggings_needed = getdvarint("_encstr_97A72637B127FA6BD576ECB2397D6BEAB376959C9BB0D5E8FA6BBA3B9D5ADCB3CDF5732B591995C8", 3);
  level.mugger_min_spawn_dist_sq = squared(getdvarfloat("_encstr_A52816F8452FCF671041C212CD703BCBB79B58B9F8021778", 350));
  level.mugger_jackpot_limit = getdvarint("_encstr_8ECC1963506D78CF4DAF17951A4728732F30DBE0493F0C93290465", 0);
  level.mugger_jackpot_wait_sec = getdvarfloat("_encstr_AF1D1CEFE726E975B8E1DFA7BB118AC2766F6B2761D8133170ABD92A71D8", 10);
  level.mugger_throwing_knife_mug_frac = getdvarfloat("_encstr_865A233B10EDD1B75344978DE63E1BA455D8E31273AF9997E8BB9E8568AD47AFE7083BEAC0", 1.0);
  level mugger_init_tags();
  level thread mugger_monitor_tank_pickups();
  level thread mugger_monitor_remote_uav_pickups();
  level.jackpot_zone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  level.jackpot_zone.origin = (0, 0, 0);
  level.jackpot_zone.angles = (90, 0, 0);
  level.jackpot_zone setModel("_encstr_B228183493F844E7518643AA683A0F718825B58E33204F5784F8");
  level.jackpot_zone hide();
  level.jackpot_zone.mugger_fx_playing = 0;
  level thread mugger_jackpot_watch();
}

onplayerconnect(var_0) {
  var_0.tags_carried = 0;
  var_0.total_tags_banked = 0;
  var_0.assists = var_0.total_tags_banked;
  var_0.pers["_encstr_A1F308589BCD96CD476E"] = var_0.total_tags_banked;
  var_0.game_extrainfo = var_0.tags_carried;
  var_0.muggings = [];

  if(isPlayer(var_0) && !isbot(var_0)) {
    var_0.dogtagsicon = var_0 scripts\mp\hud_util::createicon("_encstr_91F10D60BD897FE33BC8DA12700DDB", 48, 48);
    var_0.dogtagsicon scripts\mp\hud_util::setpoint("_encstr_BE6409FBC7C7E763112893", "_encstr_BE6409FBC7C7E763112893", 200, 0);
    var_0.dogtagsicon.alpha = 1;
    var_0.dogtagsicon.hidewheninmenu = 1;
    var_0.dogtagsicon.archived = 1;
    level thread hidehudelementongameend(var_0.dogtagsicon);
    var_0.dogtagstext = var_0 scripts\mp\hud_util::createfontstring("_encstr_932509FD51EF339BCB7291", 1.0);
    var_0.dogtagstext scripts\mp\hud_util::setparent(var_0.dogtagsicon);
    var_0.dogtagstext scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", -24);
    var_0.dogtagstext setvalue(var_0.tags_carried);
    var_0.dogtagstext.alpha = 1;
    var_0.dogtagstext.color = (1, 1, 0.5);
    var_0.dogtagstext.glowalpha = 1;
    var_0.dogtagstext.sort = 1;
    var_0.dogtagstext.hidewheninmenu = 1;
    var_0.dogtagstext.archived = 1;
    var_0.dogtagstext scripts\mp\hud::fontpulseinit(3.0);
    level thread hidehudelementongameend(var_0.dogtagstext);
  }
}

onspawnplayer() {
  self.muggings = [];

  if(!isagent(self))
    thread waitreplaysmokefxfornewplayer();
}

hidehudelementongameend(var_0) {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    var_0.alpha = 0;
}

getspawnpoint() {
  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "_encstr_8BBA05185F8B99", "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");
  return var_0;
}

onxpevent(var_0) {}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  level thread spawndogtags(var_0, var_1);
}

mugger_init_tags() {
  level.mugger_max_extra_tags = getdvarint("_encstr_B2E61AB0A75ACEFB4BCFBCB5620133F1A8BF986043F241E70376A446", 50);
  level.mugger_extra_tags = [];
}

spawndogtags(var_0, var_1) {
  if(isagent(var_1))
    var_1 = var_1.owner;

  var_2 = 0;
  var_3 = 0;

  if(isDefined(var_1)) {
    if(var_0 == var_1) {
      if(var_0.tags_carried > 0) {
        var_2 = var_0.tags_carried;
        var_0.tags_carried = 0;
        var_0.game_extrainfo = 0;

        if(isPlayer(var_0) && !isbot(var_0)) {
          var_0.dogtagstext setvalue(var_0.tags_carried);
          var_0.dogtagstext thread scripts\mp\hud::fontpulse(var_0);
          var_0 thread scripts\mp\hud_message::showsplash("_encstr_8DEB0F31FD17615B0A6938AB22661B5977", var_2);
        }
      }
    } else if(isDefined(var_0.attackerdata) && var_0.attackerdata.size > 0) {
      if(isPlayer(var_1) && isDefined(var_0.attackerdata) && isDefined(var_1.guid) && isDefined(var_0.attackerdata[var_1.guid])) {
        var_4 = var_0.attackerdata[var_1.guid];

        if(isDefined(var_4) && isDefined(var_4.attackerent) && var_4.attackerent == var_1) {
          if(isDefined(var_4.smeansofdeath) && (var_4.smeansofdeath == "_encstr_8DED0A21C79B660BC7588981" || var_4.weapon == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83" && level.mugger_throwing_knife_mug_frac > 0.0)) {
            var_3 = 1;

            if(var_0.tags_carried > 0) {
              var_2 = var_0.tags_carried;

              if(var_4.weapon == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83" && level.mugger_throwing_knife_mug_frac < 1.0)
                var_2 = int(ceil(var_0.tags_carried * level.mugger_throwing_knife_mug_frac));

              var_0.tags_carried = var_0.tags_carried - var_2;
              var_0.game_extrainfo = var_0.tags_carried;

              if(isPlayer(var_0) && !isbot(var_0)) {
                var_0.dogtagstext setvalue(var_0.tags_carried);
                var_0.dogtagstext thread scripts\mp\hud::fontpulse(var_0);
                var_0 thread scripts\mp\hud_message::showsplash("_encstr_96240F8F986A45C8B3F357ADAFC7A9C211", var_2);
                var_0 playlocalsound("_encstr_93B112C07FCF496BBB413C306381B3F337DF1823");
              }

              playsoundatpos(var_0.origin, "_encstr_8A6A0F5B5D3B7656E4AF5B57ECB3D2B99D");
              var_1 thread scripts\mp\hud_message::showsplash("_encstr_83240FE8779C6037B3C378799BCA7F09EA", var_2);

              if(var_4.weapon == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83")
                var_1 playlocalsound("_encstr_B88112B02B57473DD6213787ADCE6D5382F7511A");
            }

            var_1.muggings[var_1.muggings.size] = gettime();
            var_1 thread mugger_check_muggernaut();
          }
        }
      }
    }
  }

  if(isagent(var_0)) {
    var_5 = var_0.origin + (0, 0, 14);
    playsoundatpos(var_5, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
    level notify("_encstr_8C6A1968935F0C902AEF7D63FB5483C0BBA960F01AD3B59887A659");
    var_6 = mugger_tag_temp_spawn(var_0.origin, 40, 160);
    var_6.victim = var_0.owner;

    if(isDefined(var_1) && var_0 != var_1)
      var_6.attacker = var_1;
    else
      var_6.attacker = undefined;

    return;
  } else if(isDefined(level.dogtags[var_0.guid])) {
    playFX(level.mugger_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_0.guid].curorigin);
    level.dogtags[var_0.guid] notify("_encstr_88F20627959BCAE8");
  } else {
    var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_7[0] setModel("_encstr_9AFE108CDEB31DB0ECE6FA96EE6ED799DBCA");
    var_8 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
    var_8.targetname = "_encstr_AF980F150AAA1F2765EB36231FA2BB97C0";
    var_8 hide();
    level.dogtags[var_0.guid] = scripts\mp\gameobjects::createuseobject("_encstr_9A19040BCDBC", var_8, var_7, (0, 0, 16));
    level.dogtags[var_0.guid] scripts\mp\gameobjects::setusetime(0);
    level.dogtags[var_0.guid].onuse = ::onuse;
    var_8.dogtag = level.dogtags[var_0.guid];
    level.dogtags[var_0.guid].victim = var_0;
    level.dogtags[var_0.guid].objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(level.dogtags[var_0.guid].objid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(level.dogtags[var_0.guid].objid, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
      scripts\mp\objidpoolmanager::update_objective_icon(level.dogtags[var_0.guid].objid, "_encstr_B61512E406CBB9B839F3E0C1A347F1F9122F5ECE");
    }

    level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
    level thread clearonvictimdisconnect(var_0);
  }

  var_5 = var_0.origin + (0, 0, 14);
  level.dogtags[var_0.guid].curorigin = var_5;
  level.dogtags[var_0.guid].trigger.origin = var_5;
  level.dogtags[var_0.guid].visuals[0].origin = var_5;
  level.dogtags[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var_0.guid] scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  level.dogtags[var_0.guid].visuals[0] show();

  if(isDefined(var_1) && var_0 != var_1)
    level.dogtags[var_0.guid].attacker = var_1;
  else
    level.dogtags[var_0.guid].attacker = undefined;

  level.dogtags[var_0.guid] thread timeout();

  if(var_2 < 5) {
    scripts\mp\objidpoolmanager::update_objective_position(level.dogtags[var_0.guid].objid, var_5);
    scripts\mp\objidpoolmanager::update_objective_state(level.dogtags[var_0.guid].objid, "_encstr_930B07BB1B6B3854FF");
  } else
    mugger_tag_pile_notify(var_5, "_encstr_A21410225B4467A790B77D7DEF202F8BF853", var_2, var_0, var_1);

  playsoundatpos(var_5, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
  level.dogtags[var_0.guid].temp_tag = 0;

  if(var_2 == 0)
    level notify("_encstr_8C6A1968935F0C902AEF7D63FB5483C0BBA960F01AD3B59887A659");

  for(var_9 = 0; var_9 < var_2; var_9++) {
    var_6 = mugger_tag_temp_spawn(var_0.origin, 40, 160);
    var_6.victim = var_0;

    if(isDefined(var_1) && var_0 != var_1) {
      var_6.attacker = var_1;
      continue;
    }

    var_6.attacker = undefined;
  }
}

mugger_tag_pickup_wait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_B28E07392BAECD9532");
  self endon("_encstr_8BE208E31FA8E1631D65");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote() || isDefined(var_0.spawningafterremotedeath)) {
      continue;
    }
    if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    thread onuse(var_0);
    return;
  }
}

mugger_add_extra_tag(var_0) {
  var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1[0] setModel("_encstr_9AFE108CDEB31DB0ECE6FA96EE6ED799DBCA");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
  var_2.targetname = "_encstr_AF980F150AAA1F2765EB36231FA2BB97C0";
  var_2 hide();
  level.mugger_extra_tags[var_0] = spawnStruct();
  var_3 = level.mugger_extra_tags[var_0];
  var_3.type = "_encstr_8CC00AABB9599E984D2BD81D";
  var_3.curorigin = var_2.origin;
  var_3.entnum = var_2 getentitynumber();
  var_3.trigger = var_2;
  var_3.triggertype = "_encstr_83650AB19BA26B100D3CE35A";
  var_3 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_1[0].baseorigin = var_1[0].origin;
  var_3.visuals = var_1;
  var_3.offset3d = (0, 0, 16);
  var_3.temp_tag = 1;
  var_3.last_used_time = 0;
  var_3.visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
  var_3 thread mugger_tag_pickup_wait();
  return var_3;
}

mugger_first_unused_or_oldest_extra_tag() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.mugger_extra_tags) {
    if(var_3.interactteam == "_encstr_8BBA05185F8B99") {
      var_3.last_used_time = gettime();
      var_3.visuals[0] show();
      return var_3;
    }

    if(!isDefined(var_0) || var_3.last_used_time < var_1) {
      var_1 = var_3.last_used_time;
      var_0 = var_3;
    }
  }

  if(level.mugger_extra_tags.size < level.mugger_max_extra_tags) {
    var_5 = mugger_add_extra_tag(level.mugger_extra_tags.size);

    if(isDefined(var_5)) {
      var_5.last_used_time = gettime();
      return var_5;
    }
  }

  var_0.last_used_time = gettime();
  var_0 notify("_encstr_B28E07392BAECD9532");
  playFX(level.mugger_fx["_encstr_8BE007AB0FE8607F9B"], var_0.curorigin);
  return var_0;
}

mugger_tag_temp_spawn(var_0, var_1, var_2) {
  var_3 = mugger_first_unused_or_oldest_extra_tag();
  var_4 = var_0 + (0, 0, 14);
  var_5 = (0, randomfloat(360), 0);
  var_6 = anglesToForward(var_5);
  var_7 = randomfloatrange(40, 160);
  var_8 = var_4 + var_7 * var_6;
  var_8 = var_8 + (0, 0, 40);
  var_9 = playerphysicstrace(var_4, var_8);
  var_4 = var_9;
  var_8 = var_4 + (0, 0, -100);
  var_9 = playerphysicstrace(var_4, var_8);

  if(var_9[2] != var_8[2])
    var_9 = var_9 + (0, 0, 14);

  var_3.curorigin = var_9;
  var_3.trigger.origin = var_9;
  var_3.visuals[0].origin = var_9;
  var_3 scripts\mp\gameobjects::initializetagpathvariables();
  var_3 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_3 thread mugger_tag_pickup_wait();
  var_3 thread timeout();
  return var_3;
}

mugger_tag_pile_notify(var_0, var_1, var_2, var_3, var_4) {
  level notify("_encstr_824E1081135FDFB806374CDBA0E1595879C1", var_0);
  var_5 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_5, "_encstr_930B07BB1B6B3854FF", var_0);
    scripts\mp\objidpoolmanager::update_objective_icon(var_5, "_encstr_934515735787BB1D904D1BF12C32EFEB4FD0C9C7D4684D");
  }

  level scripts\engine\utility::delaythread(5, ::mugger_pile_icon_remove, var_5);

  if(var_2 >= 10) {
    level.mugger_last_mega_drop = gettime();
    level.mugger_jackpot_num_tags = 0;

    foreach(var_7 in level.players) {
      var_7 playsoundtoplayer("_encstr_8C0D0E85D321BC82FC0F7F030F107AF5", var_7);

      if(isDefined(var_3) && var_7 == var_3) {
        continue;
      }
      if(isDefined(var_4) && var_7 == var_4) {
        continue;
      }
      var_7 thread scripts\mp\hud_message::showsplash(var_1, var_2);
    }

    var_9 = newhudelem();
    var_9 setshader("_encstr_934515735787BB1D904D1BF12C32EFEB4FD0C9C7D4684D", 10, 10);
    var_9 setwaypoint(0, 1, 0, 0);
    var_9.x = var_0[0];
    var_9.y = var_0[1];
    var_9.z = var_0[2] + 32;
    var_9.alpha = 1;
    var_9 fadeovertime(5);
    var_9.alpha = 0;
    var_9 scripts\engine\utility::delaythread(5, ::hudelemdestroy);
  }
}

hudelemdestroy() {
  if(isDefined(self))
    self destroy();
}

mugger_monitor_tank_pickups() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = getEntArray("_encstr_A3AC0C1A9D50B2D162C0E3B0C28A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = getEntArray("_encstr_AF980F150AAA1F2765EB36231FA2BB97C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_3 in level.players) {
      if(isDefined(var_3.using_remote_tank) && var_3.using_remote_tank == 1) {
        foreach(var_5 in var_0) {
          if(isDefined(var_5) && isDefined(var_5.owner) && var_5.owner == var_3) {
            foreach(var_7 in var_1) {
              if(isDefined(var_7) && isDefined(var_7.dogtag)) {
                if(isDefined(var_7.dogtag.interactteam) && var_7.dogtag.interactteam != "_encstr_8BBA05185F8B99") {
                  if(var_5 istouching(var_7))
                    var_7.dogtag onuse(var_5.owner);
                }
              }
            }
          }
        }
      }
    }

    wait 0.2;
  }
}

mugger_monitor_remote_uav_pickups() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = getEntArray("_encstr_AF980F150AAA1F2765EB36231FA2BB97C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && isDefined(var_2.remoteuav)) {
        foreach(var_4 in var_0) {
          if(isDefined(var_4) && isDefined(var_4.dogtag)) {
            if(isDefined(var_4.dogtag.interactteam) && var_4.dogtag.interactteam != "_encstr_8BBA05185F8B99") {
              if(var_2.remoteuav istouching(var_4))
                var_4.dogtag onuse(var_2);
            }
          }
        }
      }
    }

    wait 0.2;
  }
}

mugger_check_muggernaut() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AF171438A27FEF4097568CE83D8F89BF27ABE8A0EBD3");
  self endon("_encstr_AF171438A27FEF4097568CE83D8F89BF27ABE8A0EBD3");
  wait 2;

  if(self.muggings.size < level.mugger_muggernaut_muggings_needed) {
    return;
  }
  var_0 = self.muggings[self.muggings.size - 1];
  var_1 = var_0 - level.mugger_muggernaut_window;
  var_2 = [];

  foreach(var_4 in self.muggings) {
    if(var_4 >= var_1)
      var_2[var_2.size] = var_4;
  }

  if(var_2.size >= level.mugger_muggernaut_muggings_needed) {
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E6F0BF11B328F914A8B2088CB");
    mugger_bank_tags(1, 1);
    self.muggings = [];
  } else
    self.muggings = var_2;
}

mugger_pile_icon_remove(var_0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

_hidefromplayer(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    if(var_2 != var_0)
      self showtoplayer(var_2);
  }
}

onuse(var_0) {
  if(isDefined(var_0.owner))
    var_0 = var_0.owner;

  if(self.temp_tag)
    self.trigger playSound("_encstr_8B87194A804F1F52CD40A960587D7C4E09270DFF7A4F28C1584B7B");
  else if(isDefined(self.attacker) && var_0 == self.attacker) {
    self.trigger playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
  } else {
    self.trigger playSound("_encstr_8B87194A804F1F52CD40A960587D7C4E09270DFF7A4F28C1584B7B");
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B64E070F391562989D", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", var_0.pers["_encstr_B64E070F391562989D"]);
  }

  var_0 thread onpickup();
  resettags(1);
}

onpickup(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.pers))
    waitframe();

  thread mugger_delayed_banking();
}

mugger_delayed_banking() {
  self notify("_encstr_993F082A0BD5DCA73044");
  self endon("_encstr_993F082A0BD5DCA73044");
  level endon("_encstr_8FBD0C2A2138BF4C68EF7751E120");
  self.tags_carried++;
  self.game_extrainfo = self.tags_carried;

  if(isPlayer(self) && !isbot(self)) {
    self.dogtagstext setvalue(self.tags_carried);
    self.dogtagstext thread scripts\mp\hud::fontpulse(self);
  }

  wait 1.5;
  var_0 = level.mugger_bank_limit - self.tags_carried;

  if(var_0 > 0 && var_0 <= 5) {
    var_1 = undefined;

    switch (var_0) {
      case 1:
        var_1 = "_encstr_B2D40D8AF3ECFF3FF8CF49ED5793C7";
        break;
      case 2:
        var_1 = "_encstr_95F40DE20397E0D768AF2635F002E2";
        break;
      case 3:
        var_1 = "_encstr_A9020DBBB712D44002A11B2855EA88";
        break;
      case 4:
        var_1 = "_encstr_A29A0D08E0045F1A3AC6475A9ABBFF";
        break;
      case 5:
        var_1 = "_encstr_B4D70DB657ECB3B2E4EBA96B7BC9AC";
        break;
    }

    if(isDefined(var_1))
      self playsoundtoplayer(var_1, self);
  }

  wait 0.5;
  mugger_bank_tags(0);
}

mugger_bank_tags(var_0, var_1) {
  var_2 = 0;

  if(var_0 == 1)
    var_2 = self.tags_carried;
  else {
    var_3 = self.tags_carried % level.mugger_bank_limit;
    var_2 = self.tags_carried - var_3;
  }

  if(var_2 > 0) {
    self.tags_to_bank = var_2;

    if(!isDefined(var_1))
      thread scripts\mp\hud_message::showsplash("_encstr_BD0214BB67586315236049F3A06F4AF731DF0E3B8DA1", var_2);

    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B8960C3A0BCE6EBEC458375B5623", undefined, self.tags_to_bank * scripts\mp\rank::getscoreinfovalue("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C"));
    self.total_tags_banked = self.total_tags_banked + var_2;
    self.tags_carried = self.tags_carried - var_2;
    self.game_extrainfo = self.tags_carried;

    if(isPlayer(self) && !isbot(self)) {
      self.dogtagstext setvalue(self.tags_carried);
      self.dogtagstext thread scripts\mp\hud::fontpulse(self);
    }

    self.assists = self.total_tags_banked;
    self.pers["_encstr_A1F308589BCD96CD476E"] = self.total_tags_banked;
  }
}

onplayerscore(var_0, var_1) {
  if(var_0 == "_encstr_B8960C3A0BCE6EBEC458375B5623" && isDefined(var_1) && isDefined(var_1.tags_to_bank) && var_1.tags_to_bank > 0) {
    var_2 = var_1.tags_to_bank * scripts\mp\rank::getscoreinfovalue("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
    var_1.tags_to_bank = 0;
    return var_2;
  }

  return 0;
}

resettags(var_0) {
  if(!var_0)
    level notify("_encstr_8C6A1968935F0C902AEF7D63FB5483C0BBA960F01AD3B59887A659");

  self.attacker = undefined;
  self notify("_encstr_88F20627959BCAE8");
  self.visuals[0] hide();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(isDefined(self.jackpot_tag) && self.jackpot_tag == 1)
    level.mugger_jackpot_tags_spawned--;

  if(!self.temp_tag)
    scripts\mp\objidpoolmanager::update_objective_state(self.objid, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
}

timeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8BE208E31FA8E1631D65");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_B28E07392BAECD9532");
  self notify("_encstr_84440EE9A7D2B570650BF64B3359D075");
  self endon("_encstr_84440EE9A7D2B570650BF64B3359D075");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(27.0);

  for(var_0 = 3.0; var_0 > 0.0; var_0 = var_0 - 0.5) {
    self.visuals[0] hide();
    wait 0.25;
    self.visuals[0] show();
    wait 0.25;
  }

  playFX(level.mugger_fx["_encstr_8BE007AB0FE8607F9B"], self.curorigin);
  thread resettags(0);
}

clearonvictimdisconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.guid;
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.dogtags[var_1])) {
    level.dogtags[var_1] scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    playFX(level.mugger_fx["_encstr_8BE007AB0FE8607F9B"], level.dogtags[var_1].curorigin);
    level.dogtags[var_1] notify("_encstr_88F20627959BCAE8");
    waitframe();

    if(isDefined(level.dogtags[var_1])) {
      scripts\mp\objidpoolmanager::returnobjectiveid(level.dogtags[var_1].objid);
      level.dogtags[var_1].trigger delete();

      for(var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++)
        level.dogtags[var_1].visuals[var_2] delete();

      level.dogtags[var_1] notify("_encstr_8BE208E31FA8E1631D65");
      level.dogtags[var_1] = undefined;
    }
  }
}

ontimelimit() {
  level notify("_encstr_8FBD0C2A2138BF4C68EF7751E120");

  foreach(var_1 in level.players)
  var_1 mugger_bank_tags(1);

  wait 0.1;
  scripts\mp\gamelogic::default_ontimelimit();
}

mugger_jackpot_watch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8F510D5316C6D6E0F61DEBCDA3DB0E");

  if(level.mugger_jackpot_limit <= 0) {
    return;
  }
  level.mugger_jackpot_num_tags = 0;
  level.mugger_jackpot_tags_unspawned = 0;
  level.mugger_jackpot_num_tags = 0;
  level thread mugger_jackpot_timer();

  for(;;) {
    level waittill("_encstr_8C6A1968935F0C902AEF7D63FB5483C0BBA960F01AD3B59887A659");
    var_0 = 1;

    if(var_0) {
      level.mugger_jackpot_num_tags++;
      var_1 = clamp(float(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit), 0.0, 1.0);

      if(level.mugger_jackpot_num_tags >= level.mugger_jackpot_limit) {
        if(isDefined(level.mugger_jackpot_text))
          level.mugger_jackpot_text thread scripts\mp\hud::fontpulse(level.players[0]);

        level.mugger_jackpot_num_tags = 15 + randomintrange(0, 3) * 5;
        level thread mugger_jackpot_drop();
        break;
      }
    }
  }
}

mugger_jackpot_timer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8F510D5316C6D6E0F61DEBCDA3DB0E");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    wait(level.mugger_jackpot_wait_sec);
    level notify("_encstr_8C6A1968935F0C902AEF7D63FB5483C0BBA960F01AD3B59887A659");
  }
}

mugger_jackpot_drop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_968B0EC9ACCD59E8EB58B49C4627F61C");
  level endon("_encstr_968B0EC9ACCD59E8EB58B49C4627F61C");
  var_0 = level.mugger_dropzones[level.script][randomint(level.mugger_dropzones[level.script].size)];
  var_0 = var_0 + (randomintrange(-50, 50), randomintrange(-50, 50), 0);

  for(;;) {
    var_1 = level.players[0];
    var_2 = 1;

    if(isDefined(var_1) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_2 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      foreach(var_4 in level.players)
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_B89218B5AED9CE5927BEA6B036B6E0F6E8EBD29B1BDBB5B4B9CE");

      break;
    } else {
      wait 0.5;
      continue;
    }
  }

  level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
  level thread mugger_jackpot_run(var_0);
}

mugger_jackpot_pile_notify(var_0, var_1, var_2) {
  if(!isDefined(level.jackpotpileobjid)) {
    level.jackpotpileobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(level.jackpotpileobjid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(level.jackpotpileobjid, "_encstr_930B07BB1B6B3854FF", var_0);
      scripts\mp\objidpoolmanager::update_objective_icon(level.jackpotpileobjid, "_encstr_A11D11EE0BBC83F65AE68EEB4D16C66D38F6D1");
    }
  } else if(level.jackpotpileobjid != -1)
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var_0);

  if(var_2 >= 10) {
    foreach(var_4 in level.players)
    var_4 playlocalsound(game["_encstr_813F06832D8A18FE"]["_encstr_B864094BF8C8A43AFE33C7" + var_4.pers["_encstr_8AEF05472BC2D6"]]);

    if(!isDefined(level.jackpotpileicon)) {
      level.jackpotpileicon = newhudelem();
      level.jackpotpileicon setshader("_encstr_A11D11EE0BBC83F65AE68EEB4D16C66D38F6D1", 64, 64);
      level.jackpotpileicon setwaypoint(0, 1, 0, 0);
    }

    level.jackpotpileicon.x = var_0[0];
    level.jackpotpileicon.y = var_0[1];
    level.jackpotpileicon.z = var_0[2] + 12;
    level.jackpotpileicon.alpha = 0.75;
  }
}

mugger_jackpot_pile_notify_cleanup() {
  if(level.jackpotpileobjid != -1)
    scripts\mp\objidpoolmanager::update_objective_state(level.jackpotpileobjid, "_encstr_A2BE0AB4DC3BB46E5A981BAC");

  level.jackpotpileicon fadeovertime(2);
  level.jackpotpileicon.alpha = 0;
  level.jackpotpileicon scripts\engine\utility::delaythread(2, ::hudelemdestroy);
}

mugger_jackpot_fx(var_0) {
  mugger_jackpot_fx_cleanup();
  var_1 = var_0 + (0, 0, 30);
  var_2 = var_0 + (0, 0, -1000);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, undefined, scripts\engine\trace::create_default_contents(1));
  level.jackpot_zone.origin = var_3["_encstr_BD260953AA97E3F014279D"] + (0, 0, 1);
  level.jackpot_zone show();
  var_4 = vectortoangles(var_3["_encstr_820E07FAE8780B3A4C"]);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  thread spawnfxdelay(var_3["_encstr_BD260953AA97E3F014279D"], var_5, var_6, 0.5);
  wait 0.1;
  playFXOnTag(level.mugger_fx["_encstr_BE7206A2D07B1322"], level.jackpot_zone, "_encstr_B2BF0708BA770F795B");

  foreach(var_8 in level.players)
  var_8.mugger_fx_playing = 1;

  level.jackpot_zone.mugger_fx_playing = 1;
}

mugger_jackpot_fx_cleanup() {
  stopFXOnTag(level.mugger_fx["_encstr_BE7206A2D07B1322"], level.jackpot_zone, "_encstr_B2BF0708BA770F795B");
  level.jackpot_zone hide();

  if(isDefined(level.jackpot_targetfx))
    level.jackpot_targetfx delete();

  if(level.jackpot_zone.mugger_fx_playing) {
    level.jackpot_zone.mugger_fx_playing = 0;
    stopFXOnTag(level.mugger_fx["_encstr_BE7206A2D07B1322"], level.jackpot_zone, "_encstr_B2BF0708BA770F795B");
    waitframe();
  }
}

spawnfxdelay(var_0, var_1, var_2, var_3) {
  if(isDefined(level.jackpot_targetfx))
    level.jackpot_targetfx delete();

  wait(var_3);
  level.jackpot_targetfx = spawnfx(level.mugger_targetfxid, var_0, var_1, var_2);
  triggerfx(level.jackpot_targetfx);
}

waitreplaysmokefxfornewplayer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 0.5;

  if(level.jackpot_zone.mugger_fx_playing == 1 && !isDefined(self.mugger_fx_playing)) {
    playfxontagforclients(level.mugger_fx["_encstr_BE7206A2D07B1322"], level.jackpot_zone, "_encstr_B2BF0708BA770F795B", self);
    self.mugger_fx_playing = 1;
  }
}

mugger_jackpot_run(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BD0210B267B97FD2176049F3E07BCF37D355");
  level notify("_encstr_8F510D5316C6D6E0F61DEBCDA3DB0E");
  mugger_jackpot_pile_notify(var_0, "_encstr_8E450FB5AECED9B24EF5A916365B1CDEA3", level.mugger_jackpot_tags_unspawned);
  level thread mugger_jackpot_fx(var_0);
  level thread mugger_jackpot_abort_after_time(30);
  level waittill("_encstr_961017A770EB883D4F70674322C69A536073BF997070A9D242", var_0);

  if(level.jackpotpileobjid != -1)
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var_0);

  level.jackpotpileicon.x = var_0[0];
  level.jackpotpileicon.y = var_0[1];
  level.jackpotpileicon.z = var_0[2] + 32;

  foreach(var_2 in level.players) {
    var_2 playsoundtoplayer("_encstr_8C0D0E85D321BC82FC0F7F030F107AF5", var_2);
    var_2 thread scripts\mp\hud_message::showsplash("_encstr_8E450FB5AECED9B24EF5A916365B1CDEA3", level.mugger_jackpot_tags_unspawned);
  }

  level.mugger_jackpot_tags_spawned = 0;

  while(level.mugger_jackpot_tags_unspawned > 0) {
    if(level.mugger_jackpot_tags_spawned < 10) {
      level.mugger_jackpot_tags_unspawned--;
      var_4 = mugger_tag_temp_spawn(var_0, 0, 400);
      var_4.jackpot_tag = 1;
      level.mugger_jackpot_tags_spawned++;
      level thread mugger_jackpot_abort_after_time(90);
      wait 0.1;
      continue;
    }

    wait 0.5;
  }

  level.mugger_jackpot_num_tags = 0;

  while(level.mugger_jackpot_tags_spawned > 0)
    wait 1;

  mugger_jackpot_cleanup();
}

mugger_jackpot_cleanup() {
  level notify("_encstr_99FC10AC19285B2B90C9679FD14DE28670C3");
  mugger_jackpot_pile_notify_cleanup();
  mugger_jackpot_fx_cleanup();
  level thread mugger_jackpot_watch();
}

mugger_jackpot_abort_after_time(var_0) {
  level endon("_encstr_99FC10AC19285B2B90C9679FD14DE28670C3");
  level notify("_encstr_B4B719682AE6974BF724F8EF0ACF336141B28060827A47838755FD");
  level endon("_encstr_B4B719682AE6974BF724F8EF0ACF336141B28060827A47838755FD");
  wait(var_0);
  level notify("_encstr_BD0210B267B97FD2176049F3E07BCF37D355");
}

muggercratethink(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level notify("_encstr_961017A770EB883D4F70674322C69A536073BF997070A9D242", self.origin);
  wait 0.5;
  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

createdropzones() {
  level.mugger_dropzones = [];
  var_0 = undefined;

  if(isDefined(var_0) && var_0.size) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      level.mugger_dropzones[level.script][var_1] = var_3.origin;
      var_1++;
    }
  } else {
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][0] = (-665, -209, 226);
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][1] = (-2225, 1573, 260);
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][2] = (1275, -747, 292);
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][3] = (1210, 963, 225);
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][4] = (-2343, -811, 226);
    level.mugger_dropzones["_encstr_B15B0BCD41597A3F1F3B4AB3CD"][5] = (-1125, -1610, 184);
    level.mugger_dropzones["_encstr_B6D50802506FD777680D"][0] = (649, 1096, -250);
    level.mugger_dropzones["_encstr_B6D50802506FD777680D"][1] = (953, -501, -328);
    level.mugger_dropzones["_encstr_B6D50802506FD777680D"][2] = (-37, 2099, -231);
    level.mugger_dropzones["_encstr_B6D50802506FD777680D"][3] = (-716, 1100, -296);
    level.mugger_dropzones["_encstr_B6D50802506FD777680D"][4] = (-683, -51, -352);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][0] = (266, -212, 708);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][1] = (295, 1842, 668);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][2] = (-1449, 1833, 692);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][3] = (835, -1815, 668);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][4] = (-1116, 76, 729);
    level.mugger_dropzones["_encstr_A7560A35F0C8134C569B86DF"][5] = (-399, 951, 676);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][0] = (552, 1315, 8);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][1] = (990, 3248, 144);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][2] = (-879, 2643, 135);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][3] = (-68, -995, 16);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][4] = (1499, -1206, 15);
    level.mugger_dropzones["_encstr_AA220D883A77409842BF899B9FDADD"][5] = (2387, 1786, 61);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][0] = (-150, -80, 63);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][1] = (-947, -1088, 107);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][2] = (1052, -614, 50);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][3] = (1886, 648, 24);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][4] = (628, 2096, 30);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][5] = (-2033, 1082, 308);
    level.mugger_dropzones["_encstr_B2D009935829FBF9C64137"][6] = (-1230, 1836, 295);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][0] = (904, 441, -77);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][1] = (-1056, 1435, 141);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][2] = (800, 1543, 148);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][3] = (2423, 1368, 141);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][4] = (596, -1870, 89);
    level.mugger_dropzones["_encstr_86E30CD6387DB2F06C432CDC3B2B"][5] = (-1241, -821, 30);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][0] = (-444, -114, -8);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][1] = (1053, -1051, -13);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][2] = (889, 1184, -28);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][3] = (-994, 1877, -41);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][4] = (-1707, -1333, 63);
    level.mugger_dropzones["_encstr_A76C0B6B1CF531B7B747639576"][5] = (-334, -2155, 61);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][0] = (-1791, -3892, 3813);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][1] = (-338, -4978, 3964);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][2] = (-82, -2941, 3990);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][3] = (-3198, -2829, 3809);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][4] = (-3673, -3893, 3610);
    level.mugger_dropzones["_encstr_9AF20A6B38D7B1859313DBE6"][5] = (-2986, -4863, 3648);
    level.mugger_dropzones["_encstr_992B0BABB3814370F29F80B983"][0] = (1187, -322, 238);
    level.mugger_dropzones["_encstr_992B0BABB3814370F29F80B983"][1] = (2010, -1379, 357);
    level.mugger_dropzones["_encstr_992B0BABB3814370F29F80B983"][2] = (1615, 1245, 366);
    level.mugger_dropzones["_encstr_992B0BABB3814370F29F80B983"][3] = (-371, 825, 436);
    level.mugger_dropzones["_encstr_992B0BABB3814370F29F80B983"][4] = (-820, -927, 348);
    level.mugger_dropzones["_encstr_A38E0960437141C25380AF"][0] = (-239, 1315, 52);
    level.mugger_dropzones["_encstr_A38E0960437141C25380AF"][1] = (-1678, -219, 55);
    level.mugger_dropzones["_encstr_A38E0960437141C25380AF"][2] = (235, -369, 60);
    level.mugger_dropzones["_encstr_A38E0960437141C25380AF"][3] = (-201, 2138, 60);
    level.mugger_dropzones["_encstr_A38E0960437141C25380AF"][4] = (-1903, 2433, 198);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][0] = (990, -821, 331);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][1] = (658, 2155, 337);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][2] = (-559, 1882, 310);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][3] = (-1999, 1184, 343);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][4] = (215, -2875, 384);
    level.mugger_dropzones["_encstr_8D7B0BF853CF435B4265C7DC3F"][5] = (1731, -483, 290);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][0] = (712, 217, -196);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][1] = (1719, -1095, -196);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][2] = (2843, 1034, -269);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][3] = (1251, 2645, -213);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][4] = (-1114, 1301, -200);
    level.mugger_dropzones["_encstr_85950BDDBF374AF13888377BF0"][5] = (-693, -823, -132);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][0] = (-5052, 2371, 1223);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][1] = (-4550, 4199, 1268);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][2] = (-7149, 4449, 1376);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][3] = (-6350, 1528, 1302);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][4] = (-3333, 992, 1222);
    level.mugger_dropzones["_encstr_B1E4095B387D39168C2C9C"][5] = (-4040, -361, 1222);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][0] = (662, -513, 142);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][1] = (674, 1724, 112);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][2] = (-1003, 1103, 30);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][3] = (385, -2910, 209);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][4] = (2004, -1760, 144);
    level.mugger_dropzones["_encstr_BECD0F1D7FF7DA3EDB70ABE73051E6E26B"][5] = (2458, -300, 147);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][0] = (31, 1319, -196);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][1] = (165, -940, 60);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][2] = (-747, 143, 4);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][3] = (-1671, 1666, -216);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][4] = (-631, 3158, -68);
    level.mugger_dropzones["_encstr_B8170F4D5F0E231879393BD7DD208F5B22"][5] = (500, 2865, -89);
    level.mugger_dropzones["_encstr_BAF009B50ED7989CB0ECED"][0] = (-39, -119, 1280);
    level.mugger_dropzones["_encstr_BAF009B50ED7989CB0ECED"][1] = (1861, -563, 1229);
    level.mugger_dropzones["_encstr_BAF009B50ED7989CB0ECED"][2] = (-1548, -366, 1007);
    level.mugger_dropzones["_encstr_BAF009B50ED7989CB0ECED"][3] = (-678, 1272, 1273);
    level.mugger_dropzones["_encstr_BAF009B50ED7989CB0ECED"][4] = (1438, 842, 1272);
  }
}

onsuicidedeath(var_0) {
  level thread spawndogtags(var_0, var_0);
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonsuicidedeath(var_0);
}