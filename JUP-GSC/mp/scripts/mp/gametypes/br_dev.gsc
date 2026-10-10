/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_dev.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_188008b85f8b14d4;
#using script_239a365a92ee4476;
#using script_263974019a8ba3fa;
#using script_303fd53078a244f1;
#using script_55e418c5cc946593;
#using script_64acb6ce534155b7;
#using script_6893a0a79807f057;
#using script_6981400abfcd765c;
#using script_728ffcee8cbf30ee;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using script_fea74ca25a69884;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\engine\dev;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\carriable;
#using scripts\mp\class;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_callouts;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_helicopters;
#using scripts\mp\gametypes\br_keypad_util;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_multi_circle;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_rewards;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace br_dev;

function init() {
  registerhandlecommand(&function_c96d7535862e245c);
  level thread function_7c57dd42429eb995();
  level thread function_fe99ab4dc900865e();
  thread commandwatcher(@ "hash_97cda940cb7bd182", &handlecommand);

  namespace_ed19ace3eeb2e4::init();
}

function commandwatcher(dvarname, var_d4bb121b87421c8) {
  level notify("commandWatcher_" + function_f28fd66285fa2c9(dvarname));
  level endon("commandWatcher_" + function_f28fd66285fa2c9(dvarname));
  setDvar(dvarname, "");

  while(true) {
    waitframe();
    dvarvalue = getDvar(dvarname);

    if(dvarvalue == "") {
      continue;
    }

    setDvar(dvarname, "");
    tokens = strtok(dvarvalue, " ");

    if(!isDefined(tokens) || tokens.size < 1) {
      continue;
    }

    command = tokens[0];
    arglist = array_slice(tokens, 1);
    [[var_d4bb121b87421c8]](command, arglist);
  }
}

function handlecommand(command, args) {
  if(!isDefined(level.handlecommandfuncs)) {
    return;
  }

  foreach(func in level.handlecommandfuncs) {
    [[func]](command, args);
  }
}

function registerhandlecommand(func) {
  if(!isDefined(level.handlecommandfuncs)) {
    level.handlecommandfuncs = [];
  }

  level.handlecommandfuncs[level.handlecommandfuncs.size] = func;
}

function handledevcommand(command, args) {
  if(!isDefined(level.var_e06803212476eb2a)) {
    return;
  }

  foreach(func in level.var_e06803212476eb2a) {
    [[func]](command, args);
  }
}

function function_c96d7535862e245c(command, args) {
  firstplayer = level.players[0];

  if(!isDefined(firstplayer)) {
    return;
  }

  switch (command) {
    case #"hash_2546668b41b70df2":
      if(args.size < 1) {
        iprintlnbold("<dev string:x29>");
        break;
      }

      defname = args[0];

      if(!isscriptabledefined(defname)) {
        iprintlnbold("<dev string:x48>");
        break;
      }

      function_4d1c100badcf41a8(firstplayer, defname);
      break;
    case #"hash_fa47ccf6bd7c59c1":
      scripts\mp\gametypes\br_vehicles::brvehiclesreset();
      break;
    case #"hash_fa11c2f6bd5168fc":
      resetglass();
      break;
    case #"hash_fa37ccf6bd6f8dce":
      if(args.size < 1) {
        iprintlnbold("<dev string:x70>");
      }

      victimname = args[0];
      attackername = args[1];
      function_5b5ab8ab53c49d4d(victimname, attackername);
      break;
    case #"hash_fa34c6f6bd6d45c5":
      if(args.size < 2) {
        iprintlnbold("<dev string:x97>");
      }

      var_6cca86b6634aa67e = args[0];
      victimname = args[1];
      attackername = args[2];
      function_53a0f5e4d6bbc7a4(victimname, attackername, var_6cca86b6634aa67e);
      break;
    case #"hash_30b20a099c3735ec":
      if(args.size < 1) {
        iprintlnbold("<dev string:xc9>");
      }

      playername = args[0];
      function_72c1806e62a9bd10(playername);
      break;
    case #"hash_543cf0bb67313e3a":
      if(args.size < 1) {
        iprintlnbold("<dev string:xf3>");
      }

      playername = args[0];
      function_72c1806e62a9bd10(playername, 1);
      break;
    case #"hash_425434cf8e59e2f1":
      level thread function_2729e9ab8a4ec44e();
      break;
    case #"hash_d7404b430bfb6e59":
      firstplayer thread scripts\mp\hud_message::showsplash("<dev string:x12e>");
      break;
    case #"hash_4c34e58a34face70":
      level thread function_9bb9422480e6aa6d();
      break;
    case #"hash_6201f99dbadb9e66":
      if(args.size < 1) {
        iprintlnbold("<dev string:x153>");
      }

      winningteam = args[0];
      function_429110eb5af4a19c();

      if(isDefined(level.teamswithplayers) && array_contains(level.teamswithplayers, winningteam)) {
        level thread function_c3b8a31470635593(winningteam);
      }

      break;
    case #"hash_9a4940566b4804d1":
      firstplayer scripts\mp\gametypes\br_pickups::droponplayerdeath();
      break;
    case #"hash_59a2b6aee1837a39":
      setomnvar("<dev string:x18b>", 1);
      wait 5;
      setomnvar("<dev string:x18b>", -1);
      break;
    case #"hash_65f1ac7ad95daf95":
      firstplayer scripts\mp\gametypes\br_pickups::function_874048c58e96731();
      break;
    case #"hash_23b3bc8a2f9265f7":
      if(args.size < 3) {
        iprintlnbold("<dev string:x1b1>");
      }

      playeridx = int(args[0]);

      foreach(candidate in level.players) {
        if(playeridx == candidate getentitynumber()) {
          candidate scripts\mp\gametypes\br_public::updatebrscoreboardstat(args[1], int(args[2]));
          break;
        }
      }

      break;
    case #"hash_ec91a685aa7f22c0":
      bunkeridx = int(args[0]);
      firstplayer thread function_9cbddfdef8f1125b(bunkeridx);
      break;
    case #"hash_fe9c87c407e02cfd":
      if(args.size > 0) {
        minradius = undefined;
        bdistance2d = undefined;
        maxradius = float(args[0]);

        if(args.size > 1) {
          minradius = float(args[1]);

          if(args.size > 2) {
            bdistance2d = int(args[2]) != 0;
            points = getunusedlootcachepoints(firstplayer.origin, maxradius, minradius, bdistance2d);
          } else {
            points = getunusedlootcachepoints(firstplayer.origin, maxradius, minradius);
          }
        } else {
          points = getunusedlootcachepoints(firstplayer.origin, maxradius);
        }
      } else {
        points = getunusedlootcachepoints();
      }

      foreach(point in points) {
        debugstar(point.origin, (1, 0, 1), 100);
      }

      break;
    case #"hash_3622bda090e50ce6":
      if(args.size < 1) {
        iprintlnbold("<dev string:x1fc>");
        return;
      }

      pointtype = int(args[0]);
      origin = undefined;
      maxradius = undefined;
      minradius = undefined;
      bdistance2d = undefined;

      if(args.size > 1) {
        origin = firstplayer.origin;
        maxradius = float(args[1]);

        if(args.size > 2) {
          minradius = float(args[2]);

          if(args.size > 3) {
            bdistance2d = int(args[3]) != 0;
            points = getquestpoints(pointtype, origin, maxradius, minradius, bdistance2d);
          } else {
            points = getquestpoints(pointtype, origin, maxradius, minradius);
          }
        } else {
          points = getquestpoints(pointtype, origin, maxradius);
        }
      } else {
        points = getquestpoints(pointtype);
      }

      foreach(point in points) {
        debugstar(point.origin, (0, 1, 1), 100);
      }

      break;
    case #"hash_f458016c03940942":
      if(args.size < 1) {
        iprintlnbold("<dev string:x240>");
        return;
      }

      pointindex = int(args[0]);
      disablelootspawnpoint(pointindex);
      break;
    case #"hash_31f1df2db98384de":
      if(args.size < 4) {
        iprintlnbold("<dev string:x26b>");
      }

      testloc = (float(args[0]), float(args[1]), float(args[2]));
      yaw = float(args[3]);
      firstplayer notify("<dev string:x29d>", testloc, yaw);
      break;
    case #"hash_6d84033b4c81f07":
      level thread scripts\mp\gametypes\br::brclosealldoors();
      break;
    case #"hash_22cf50efb1690259":
      level thread scripts\mp\gametypes\br_circle::function_9eb173d6a8fed181();
      break;
    case #"hash_b4f4ef49f66ee87e":
      exclusion_zones::function_afa41ee45eb3172f();
      break;
    case #"hash_94c57f2ff385d10c":
      exclusion_zones::function_7176642fe2ed10cd(0);
      break;
    case #"hash_88184c9f0929a28e":
      exclusion_zones::function_7176642fe2ed10cd(1);
      break;
    case #"hash_f9203276319358ff":
      exclusion_zones::function_14767b88f55e26e0();
      break;
    case #"hash_66f6a40540298feb":
      if(args.size < 1) {
        iprintlnbold("<dev string:x317>");
        break;
      }

      circle = int(args[0]);
      level thread scripts\mp\gametypes\br_multi_circle::function_5d9c9221653df2f3(circle);
      break;
    case #"hash_35d376d7e454979a":
      level thread scripts\mp\gametypes\br_multi_circle::function_154cd3a077d16782();
      break;
    case #"hash_6a1fabe3febface6":
      level thread scripts\mp\gametypes\br_circle::function_46097952cff4dc2e();
      break;
    case #"hash_286b6adaa1a6599":
      level thread scripts\mp\gametypes\br_circle::function_e5958529715b6395();
      break;
    case #"hash_89b2c6b04528a2a":
      level thread scripts\mp\gametypes\br_circle::function_6a6e7f489e42bcda();
      break;
    case #"hash_f968160ea226d84e":
      level thread scripts\mp\gametypes\br_multi_circle::function_cdabf323178aabc6();
      break;
    case #"hash_399f8b169219d209":
      level thread scripts\mp\gametypes\br_multi_circle::function_295e765fd8265c81();
      break;
    case #"hash_c6f80af9a8bb0804":
      level thread scripts\mp\gametypes\br_multi_circle::function_f5b9be543604d16c();
      break;
    case #"hash_4141324cc8142ab":
      level thread scripts\mp\gametypes\br_multi_circle::function_613d3dc4f3fd44d3();
      break;
    case #"hash_f484096c03b6a81c":
      points = args[0];

      if(isDefined(points)) {
        points = float(points);
      }

      areacount = args[1];

      if(isDefined(areacount)) {
        areacount = int(areacount);
      }

      circleindex = args[2];

      if(isDefined(circleindex)) {
        circleindex = int(circleindex);
      }

      level thread scripts\mp\gametypes\br_circle::function_907a72325980713f(points, areacount, circleindex);
      break;
    case #"hash_fa53d3f6bd855f22":
      scripts\mp\gametypes\br_circle::applycirclesettings();
      level thread scripts\mp\gametypes\br_multi_circle::function_f92da29572a7dc78();
      level thread scripts\mp\gametypes\br_circle::_precalcsafecirclecenters();
      level thread scripts\mp\gametypes\br_multi_circle::function_e71987651701448a();
      break;
    case #"hash_1a92216c17e9696e":
      if(isDefined(level.player)) {
        scripts\mp\gametypes\br_circle::applycirclesettings();
        level thread scripts\mp\gametypes\br_multi_circle::function_f92da29572a7dc78();
        level thread scripts\mp\gametypes\br_circle::_precalcsafecirclecenters(level.player.origin);
        level thread scripts\mp\gametypes\br_multi_circle::function_e71987651701448a();
      }

      break;
    case #"hash_3671f92e8779a2d":
      scripts\mp\gametypes\br_circle_util::savecircles();
      break;
    case #"hash_b15d9bc5054a8bdc":
      scripts\mp\gametypes\br_circle_util::function_d12a7c7251710cbf();
      break;
    case #"hash_e6cefeebcbd5658d":
      level thread scripts\mp\gametypes\br_circle::function_184d1e23ec969c18(10);
      break;
    case #"hash_f4a2ff6c03ce9d44":
      if(isDefined(level.player)) {
        if(isDefined(level.var_2bec641aeb4e5980)) {
          foreach(index in level.var_2bec641aeb4e5980) {
            scripts\mp\objidpoolmanager::returnobjectiveid(index);
          }

          level.var_2bec641aeb4e5980 = undefined;
        } else {
          foreground = args[0];

          if(!isDefined(foreground)) {
            foreground = "<dev string:x421>";
          }

          var_48094c816bbd08e0 = 6;
          level.var_2bec641aeb4e5980 = [];

          for(i = 0; i < var_48094c816bbd08e0; i++) {
            objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

            if(objectiveiconid != -1) {
              level.var_2bec641aeb4e5980[level.var_2bec641aeb4e5980.size] = objectiveiconid;
              origin = level.player.origin + (1, i - int(var_48094c816bbd08e0 / 2), 0) * 400;
              scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "<dev string:x445>", origin, foreground);
              scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, i);
            }
          }
        }
      }

      break;
    case #"hash_81ebf88ef0730994":
      player = level.players[0];
      player.var_859654e0445a36d9 = !istrue(player.var_859654e0445a36d9);
      break;
    case #"hash_13432d1b64f9f725":
      scripts\mp\gametypes\br_pickups::spawndebugpickupfromdevgui(args[0]);
      break;
    case #"hash_88aa1ef1a7274457":
      scripts\mp\gametypes\br_pickups::spawndebugpickupfromdevgui(args[0], 0, args[1]);
      break;
    case #"hash_6f2d097b3165fadb":
      scripts\mp\gametypes\br_pickups::spawndebugpickupfromdevgui(args[0], 1);
      break;
    case #"hash_d156118a517dec2e":
      scripts\mp\gametypes\br_pickups::function_c87696a022a2c6fc();
      break;
    case #"hash_f50dad861a606d48":
      scripts\mp\gametypes\br_pickups::function_c87696a022a2c6fc(1);
      break;
    case #"hash_d50c079dfca42a66":
      scripts\mp\gametypes\br_pickups::function_510f82785bd2c148();
      break;
    case #"hash_ce57e2eaa93aa441":
      scripts\mp\gametypes\br_pickups::function_b158d838449b637e(args[0]);
      break;
    case #"hash_91bce2b64809c686":
      scripts\mp\gametypes\br_pickups::function_e2d83df8b282b199(args[0]);
      break;
    case #"hash_c715dc4c34c07470":
      for(index = 0; index < 20; index++) {
        scripts\mp\gametypes\br_pickups::spawndebugpickupfromdevgui(args[0]);
        wait 0.3;
      }

      break;
    case #"hash_bb2e498025a5100":
      foreach(player in level.players) {
        player thread scripts\mp\gametypes\br_pickups::function_849640d4a4d5ae98();
      }

      break;
    case #"hash_ee0dc7e8340124b0":
      itemslotindex = int(args[0]);

      foreach(player in level.players) {
        player thread scripts\mp\gametypes\br_pickups::quickdropitem(itemslotindex);
      }

      break;
    case #"hash_55977e57b7d74172":
      host = scripts\mp\gamelogic::gethostplayer();

      if(isDefined(host)) {
        cachetype = isDefined(args[0]) ? int(args[0]) : 0;
        scripts\mp\gametypes\br_lootcache::spawnlootcache(host.origin, host.angles, cachetype);
      }

      break;
    case #"hash_543d105aa3e01d5f":
      host = scripts\mp\gamelogic::gethostplayer();

      if(isDefined(host)) {
        spawnorigin = host.origin + anglesToForward(host.angles) * 100 + (0, 0, 10);

        if(issharedfuncdefined("<dev string:x585>", "<dev string:x59a>")) {
          [[getsharedfunc("<dev string:x585>", "<dev string:x59a>")]](spawnorigin, host.angles);
        }
      }

      break;
    case #"hash_3fd5c20ad5fdf076":
      host = scripts\mp\gamelogic::gethostplayer();

      if(isDefined(host)) {
        if(issharedfuncdefined("<dev string:x5c8>", "<dev string:x5e2>")) {
          spawnorigin = host.origin + anglesToForward(host.angles) * 100 + (0, 0, 10);
          level thread[[getsharedfunc("<dev string:x5c8>", "<dev string:x5e2>")]](spawnorigin, host.angles);
        }
      }

      break;
    case #"hash_f58f1372dbe5cafd":
      host = scripts\mp\gamelogic::gethostplayer();

      if(isDefined(host)) {
        if(issharedfuncdefined("<dev string:x611>", "<dev string:x61f>")) {
          spawnorigin = host.origin + anglesToForward(host.angles) * 100 + (0, 0, 10);
          level thread[[getsharedfunc("<dev string:x611>", "<dev string:x61f>")]](spawnorigin, host.angles, "<dev string:x635>");
        }
      }

      break;
    case #"hash_21d7c416f08db3ca":
      if(issharedfuncdefined("<dev string:x661>", "<dev string:x66f>")) {
        level thread[[getsharedfunc("<dev string:x661>", "<dev string:x66f>")]](8, int(args[0]));
      }

      break;
    case #"hash_4a7dcc9be6321a31":
      if(issharedfuncdefined("<dev string:x661>", "<dev string:x66f>")) {
        level thread[[getsharedfunc("<dev string:x661>", "<dev string:x66f>")]](int(args[0]));
      }

      break;
    case #"hash_e67849f9be3e5694":
      if(issharedfuncdefined("<dev string:x661>", "<dev string:x6d0>")) {
        level thread[[getsharedfunc("<dev string:x661>", "<dev string:x6d0>")]]();
      }

      break;
    case #"hash_f4bfffd3aac18802":
      scripts\mp\gametypes\br_helicopters::forceejectall();
      break;
    case #"hash_e13779c2ed7bb949":
      foreach(player in level.players) {
        player thread scripts\mp\gametypes\br_rewards::function_efb496dab102df58();
        break;
      }

      break;
    case #"hash_fa8ca7ecbb266177":
      level thread scripts\mp\gametypes\br_rewards::precomputedropbagpositions(0);
      break;
    case #"hash_7c2b8c824464365d":
      foreach(player in level.players) {
        player setOrigin((0, 0, 24000));
        player thread scripts\cp_mp\parachute::startfreefall(5, 0, undefined, (1, 0, 0) * scripts\mp\gametypes\br_c130::getc130speed());
        break;
      }

      break;
    case #"hash_a6aaa6d4367207ed":
      amount = int(args[0]);

      foreach(player in level.players) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(amount);
      }

      break;
    case #"hash_18ff195f73506428":
      foreach(player in level.players) {
        player scripts\mp\gametypes\br_plunder::playerthrowsmokesignal();
      }

      break;
    case #"hash_a369d55fee4139a4":
      testcase = int(args[0]);
      level thread scripts\mp\gametypes\br::debugtestcirclevfx(testcase);
      break;
    case #"hash_2d711ba89ea418a":
      level thread scripts\mp\gametypes\br_analytics::branalytics_endgame();
      break;
    case #"hash_f484066c03b6a363":
      level thread scripts\mp\gametypes\br_callouts::function_1d1637db14bbc7d1();
      break;
    case #"hash_d5d3012bbaba6238":
      thread scripts\mp\gametypes\br_c130::function_6fd27619248c2584();
      break;
    case #"hash_4e4776a3fadda5df":
      thread scripts\mp\gametypes\br_c130::function_c6f09ac70af3c7cb();
      break;
    case #"hash_ac9fc9d4872c3163":
      thread scripts\mp\gametypes\br_c130::function_22c604d143e3eb87(args[0]);
      break;
    case #"hash_8ff3986c5518a2e3":
      if(args.size < 2) {
        iprintlnbold("<dev string:x7cb>");
        return;
      }

      type = args[0];

      if(type == "<dev string:x7e9>") {
        var_9714ddda6a6df159 = int(max(0, int(args[1]) / 100));
        firstplayer scripts\mp\gametypes\br_plunder::playersetplundercount(var_9714ddda6a6df159);
      }

      break;
    case #"hash_ba72800f31a3607c":
      if(args.size < 1) {
        iprintlnbold("<dev string:x7fc>");
        return;
      }

      functable["<dev string:x828>"] = &devgivemaxammo;
      functable["<dev string:x830>"] = &function_bc261c1a1cb59524;
      functable["<dev string:x7e9>"] = &function_28dc06904e18e469;
      functable["<dev string:x839>"] = &function_5377fd507f9ea057;
      functable["<dev string:x847>"] = &function_c41e8bac1d7f3bc8;
      functable["<dev string:x850>"] = &function_a2fdd1067da9ff6e;
      functable["<dev string:x858>"] = &function_26ab41fd72f1c761;

      if(args[0] == "<dev string:x85f>") {
        args = getarraykeys(functable);
      }

      foreach(type in args) {
        foreach(player in level.players) {
          utility::trycall(functable[type], player);
        }
      }

      break;
    case #"hash_1447f46e153fa1b6":
      if(args.size < 1) {
        iprintlnbold("<dev string:x86e>");
        return;
      }

      functable["<dev string:x839>"] = &function_559b4cb8f64848b5;

      if(args[0] == "<dev string:x85f>") {
        args = getarraykeys(functable);
      }

      foreach(type in args) {
        foreach(player in level.players) {
          utility::trycall(functable[type], player);
        }
      }

      break;
    case #"hash_fa11c4f6bd516c22":
      ammount = int(args[0]);

      if(args.size == 3) {
        team = args[1];
        index = int(args[2]);
        level.teamdata[team]["<dev string:x8a0>"][index] scripts\mp\gametypes\br_plunder::playerplunderpickup(ammount);
      } else if(args.size == 2) {
        team = args[1];

        foreach(player in level.teamdata[team]["<dev string:x8a0>"]) {
          player scripts\mp\gametypes\br_plunder::playerplunderpickup(ammount);
        }
      } else {
        foreach(team, data in level.teamdata) {
          foreach(player in data["<dev string:x8a0>"]) {
            player scripts\mp\gametypes\br_plunder::playerplunderpickup(ammount);
          }
        }
      }

      break;
    case #"hash_39157f6520b45cf3":
      thread scripts\mp\gametypes\br_c130::function_7d4cd5dc8e9151a0();
      break;
    case #"hash_70cd4cd3fcb23ac2":
      thread function_4c35185bbc6a8506();
      break;
    case #"hash_6d0d996c43611d83":
      level thread function_7a26b30793922b87();
      break;
    case #"hash_fa21b3f6bd5e1d52":
      level thread scripts\mp\gametypes\br_circle::function_acc901c78fe65b94(args);
      break;
    case #"hash_ca0d86eadeeb0f28":
      scripts\mp\carriable::function_a1a40eb763fdd549(args[0]);
      break;
    case #"hash_262e09660f30b224":
      scripts\mp\carriable::function_a6ec7bb20c89f0e8();
      break;
    case #"hash_f9b86a90368cfa3e":
      level thread function_29e8c83db696b457();
      break;
    case #"hash_1b126254bb5a3b99":
      level thread function_820b8302ada04c55();
      break;
    case #"hash_520d2a58ee102c35":
      level thread scripts\mp\carriable::function_a48e852b0f6a3295(args[0]);
      break;
    case #"hash_c902de6620bec3c9":
      host = scripts\mp\gamelogic::gethostplayer();

      if(isDefined(host)) {
        host scripts\mp\gametypes\br_armory_kiosk::playerhandlecirclepickitem();
      }

      break;
    case #"hash_9f5c4b24b1adbf08":
      thread function_d671c39a7867f243(args);
      break;
    case #"hash_eeb8782d88cce2a1":
      if(isDefined(level.var_802eea8e2cbeb0)) {
        level thread[[level.var_802eea8e2cbeb0]](args[0]);
      }

      break;
    case #"hash_ee1f628b0f38b069":
      if(args[0].size > 0) {
        value = int(args[0]);
        host = scripts\mp\gamelogic::gethostplayer();
        host function_179a8d5a185dfb56(value);
      }

      break;
    case #"hash_ba0e165f0eb1239f":
      host = scripts\mp\gamelogic::gethostplayer();
      victim = host function_5718089fc75809c3();

      if(isDefined(victim) && isbot(victim)) {
        attacker = victim;

        if(host.team != victim.team) {
          attacker = host;
        }

        victim.var_add7dba6d7dab7d9 = 1;
        victim dodamage(999999, victim.origin, attacker, attacker, "<dev string:x98b>");
        victim.var_add7dba6d7dab7d9 = undefined;
      }

      break;
    case #"hash_a95269034d36f9c":
      host = scripts\mp\gamelogic::gethostplayer();
      bot = host function_5718089fc75809c3();

      if(isDefined(bot) && isbot(bot)) {
        botnum = bot getentitynumber();
        kick(botnum);
      }

      break;
    case #"hash_3da52d78f16a33d":
      foreach(player in level.players) {
        player thread namespace_a38a2e1fe7519183::function_c563bbc48f1dd3d2(player);
      }

      break;
    case #"hash_73d6df617868209":
      foreach(player in level.players) {
        player namespace_a38a2e1fe7519183::function_e64d9a42c66018c9(player);
      }

      break;
    case #"hash_d3e042390aa07110":
      namespace_bf7e4ac48f40185::activate();
      break;
    case #"hash_b4d8c64baa74a93":
      namespace_bf7e4ac48f40185::activate_enemy();
      break;
    case #"hash_9a14147eba150d7":
      level thread function_9503654ca3380f8a(args);
      break;
    case #"hash_67690a8767af2434":
      if(args.size == 1) {
        function_237b71faf9fb62d9(firstplayer, args[0]);
      }

      break;
    case #"hash_f3962c3d914738f7":
      if(args.size == 2) {
        player = devgetplayerbyname(args[1]);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:xa70>");
          break;
        }

        namespace_1eb3c4e0e28fac71::function_22671614e8f79513(player, args[0]);
      } else if(args.size == 1) {
        namespace_1eb3c4e0e28fac71::function_22671614e8f79513(firstplayer, args[0]);
      }

      break;
    case #"hash_f8cd0b61d913bc46":
      host = scripts\mp\gamelogic::gethostplayer();
      [highestteam, highestscore] = scripts\mp\gamescore::gethighestscore();
      scripts\mp\gamescore::_setteamscore(host.team, highestscore + 1);
      scripts\mp\gamelogic::forceend();
      break;
    case #"hash_ce1f2c196fa400a8":
      if(args[0] == "<dev string:xac0>") {
        var_99bcf6bdf31a0e49 = 1;
      } else if(args[0] == "<dev string:xac6>") {
        var_99bcf6bdf31a0e49 = 0;
      } else {
        iprintlnbold("<dev string:xace>");
        break;
      }

      if(args.size == 2) {
        player = devgetplayerbyname(args[1]);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:xb03>");
          break;
        }

        if(issharedfuncdefined("<dev string:xb35>", "<dev string:xb42>")) {
          [[getsharedfunc("<dev string:xb35>", "<dev string:xb42>")]](player, var_99bcf6bdf31a0e49);
        }
      } else if(args.size == 1) {
        if(issharedfuncdefined("<dev string:xb35>", "<dev string:xb42>")) {
          [[getsharedfunc("<dev string:xb35>", "<dev string:xb42>")]](firstplayer, var_99bcf6bdf31a0e49);
        }
      }

      break;
    case #"hash_e155e96b5e579879":
      if(args.size != 2) {
        iprintlnbold("<dev string:xb74>");
        break;
      }

      initialplayer = devgetplayerbyname(args[0]);
      var_784c8ada1184ff89 = devgetplayerbyname(args[1]);

      if(!isDefined(initialplayer) || !isDefined(var_784c8ada1184ff89)) {
        iprintlnbold("<dev string:xbab>");
        break;
      }

      if(issharedfuncdefined("<dev string:xb35>", "<dev string:xbdf>")) {
        [[getsharedfunc("<dev string:xb35>", "<dev string:xbdf>")]](initialplayer, var_784c8ada1184ff89, 0);
      }

      break;
    case #"hash_a739340327e3089e":
      var_99bcf6bdf31a0e49 = 1;

      if(isDefined(args[0])) {
        if(args[0] == "<dev string:xac0>") {
          var_99bcf6bdf31a0e49 = 1;
        } else if(args[0] == "<dev string:xac6>") {
          var_99bcf6bdf31a0e49 = 0;
        }
      }

      host = scripts\mp\gamelogic::gethostplayer();
      var_1a115880d69eba7d = host function_bfe726b5e0b35c27();

      if(!isDefined(var_1a115880d69eba7d)) {
        break;
      }

      if(issharedfuncdefined("<dev string:xb35>", "<dev string:xc0e>")) {
        [[getsharedfunc("<dev string:xb35>", "<dev string:xc0e>")]](host, var_1a115880d69eba7d, var_99bcf6bdf31a0e49, 0);
      }

      break;
    case #"hash_cdd3d19e11186e13":
      var_1ebfd0ce882dbcc6 = level.player;

      if(args.size >= 1) {
        var_1ebfd0ce882dbcc6 = function_b2dcd958dd436171(tolower(args[0]));
      }

      if(isDefined(var_1ebfd0ce882dbcc6)) {
        var_1ebfd0ce882dbcc6 dodamage(var_1ebfd0ce882dbcc6.health, var_1ebfd0ce882dbcc6.origin, var_1ebfd0ce882dbcc6);
      }

      break;
    case #"hash_dddecc2751311914":
    case #"hash_d542616c7a17d00d":
    case #"hash_663b0900ff0e81c7":
    case #"hash_51e0c8a1f4d5a8c":
    case #"hash_779e498488e0fd4f":
    case #"hash_fa4dbef6bd80c0e5":
    case #"hash_fa50aaf6bd82e000":
    case #"hash_5549fae4e940416f":
      if(issharedfuncdefined(command, "<dev string:xc82>")) {
        level thread[[getsharedfunc(command, "<dev string:xc82>")]](args);
      }

      break;
    case #"hash_4bbfcf4e978d515f":
      duration = int(ter_op(isDefined(args[0]), args[0], 60));
      suffix = ter_op(isDefined(args[1]), args[1], "<dev string:xca1>");
      replacevisionset(duration, suffix);
      break;
    case #"hash_54601a5ea45e2833":
      showsplash(args[0], args[1]);
      break;
    case #"hash_b9253a7e780b5cc4":
      if(args.size < 1) {
        iprintlnbold("<dev string:xcca>");
        break;
      }

      player = firstplayer;

      if(args.size == 2) {
        player = devgetplayerbyname(args[1]);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:xd0a>");
          break;
        }
      }

      if(args[0] == "<dev string:xd3e>") {
        player scripts\cp_mp\challenges::function_ca0ab723ebcf6d79();
      } else if(args[0] == "<dev string:xd47>") {
        player scripts\cp_mp\challenges::function_8935e658d461fc50();
      } else if(args[0] == "<dev string:xd51>") {
        tokencount = player scripts\cp_mp\challenges::function_3d871e989c0bdb6d();
        println("<dev string:xd5a>" + player.name + "<dev string:xd7d>" + tokencount);
      }

      break;
    case #"hash_163baee3917a3974":
      player = firstplayer;

      if(args.size == 1) {
        playername = args[1];
        player = devgetplayerbyname(playername);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:xda0>" + playername);
          break;
        }
      }

      player scripts\cp_mp\challenges::function_5f8b4216068156b5(0, 0);
      break;
    case #"hash_57b31e67cbff6b45":
      if(args.size < 3) {
        iprintlnbold("<dev string:xde0>");
        break;
      }

      player = firstplayer;

      if(args.size == 4) {
        playername = args[3];
        player = devgetplayerbyname(playername);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:xda0>" + playername);
          break;
        }
      }

      command = args[0];

      if(command != "<dev string:x7c4>" && command != "<dev string:xe2c>") {
        iprintlnbold("<dev string:xe35>" + command);
        break;
      }

      var_8a6d55b19a5a2a1c = args[1];
      var_c410829a7b9a79d6 = args[2];

      if(!scripts\cp_mp\challenges::function_3a54cb391f6b8cf8(function_1823ff50bb28148d(var_8a6d55b19a5a2a1c))) {
        iprintlnbold("<dev string:xe59>" + var_8a6d55b19a5a2a1c);
      }

      if(command == "<dev string:x7c4>") {
        player scripts\cp_mp\challenges::function_b7793133df5fb0df(function_1823ff50bb28148d(var_8a6d55b19a5a2a1c), function_1823ff50bb28148d(var_c410829a7b9a79d6));
      } else if(command == "<dev string:xe2c>") {
        player scripts\cp_mp\challenges::function_5b58181f4c00ba56(function_1823ff50bb28148d(var_8a6d55b19a5a2a1c), function_1823ff50bb28148d(var_c410829a7b9a79d6));
      }

      break;
    case #"hash_26072a9c395b034d":
      if(!isDefined(level.arrow)) {
        return;
      }

      level.arrow.dvars.skiptoken = 1;
      host = scripts\mp\gamelogic::gethostplayer();
      tablet = namespace_6c622b52017c6808::function_3ff56f0ba058501a(host.origin, (0, 0, 0));
      level.arrow.props.tablets[level.arrow.props.tablets.size] = tablet;

      if(issharedfuncdefined("<dev string:xe9b>", "<dev string:xea9>")) {
        level thread[[getsharedfunc("<dev string:xe9b>", "<dev string:xea9>")]](tablet);
      }

      namespace_6c622b52017c6808::function_cd4ce58be10fb51d();
      break;
    case #"hash_f5a6eea7650767e2":
      if(args.size < 1) {
        iprintlnbold("<dev string:xed3>");
        break;
      }

      circleid = args[0];

      if(isDefined(args[1])) {
        size = int(args[1]);
      } else {
        size = 6000;
      }

      var_1592c280e0665445 = spawnStruct();
      var_1592c280e0665445 scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522(circleid, level.players[0].origin, size);
      var_1592c280e0665445 scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
      break;
    case #"hash_b2e3447c4867d691":
      if(isDefined(level.var_ed20ae31a47f989f) && isDefined(level.var_ed20ae31a47f989f.debug_spawn)) {
        [[level.var_ed20ae31a47f989f.debug_spawn]]();
      } else {
        iprintlnbold("<dev string:xf25>");
      }

      break;
    case #"hash_99831dfe2bc2e9a5":
      amount = 10;

      if(args.size > 0) {
        amount = int(args[0]);
      }

      function_548e30d6072b85e9(firstplayer, amount);
      break;
    case #"hash_6631f1880c4f8339":
      namespace_a5b4009d7c2e0b3d::addscore();
      break;
    case #"hash_aa98a879ea5c1a8b":
      function_510cb3df7efc44a7(firstplayer);
      break;
    case #"hash_ac6e596ee6823fff":
      firstplayer scripts\mp\gametypes\br::givestandardtableloadout(0, 1);
      break;
    case #"hash_1872556a49857987":
      if(isDefined(firstplayer.classstruct) && isDefined(firstplayer.classstruct.var_91e10e152b08ec1d) && !firstplayer hasweapon(firstplayer.classstruct.var_91e10e152b08ec1d)) {
        firstplayer scripts\mp\class::function_4ffce833ce15363c(firstplayer.classstruct);
      }

      break;
    case #"hash_34260c14fedd5a2e":
      if(args.size < 2) {
        iprintlnbold("<dev string:xfc9>");
        break;
      }

      player = firstplayer;

      if(args.size == 3) {
        player = devgetplayerbyname(args[2]);

        if(!isDefined(player)) {
          iprintlnbold("<dev string:x1009>");
          break;
        }
      }

      if(args[0] == "<dev string:x7f4>") {
        player scripts\mp\gametypes\br_pickups::function_7cb3c8630787467e(args[1]);
      }

      if(args[0] == "<dev string:x866>") {
        player scripts\mp\gametypes\br_pickups::function_b53322f9aca1b83b(args[1]);
      }

      break;
    case #"hash_87532133ab44aca2":
      lootid = undefined;
      platelevel = ter_op(args.size > 1 && isDefined(args[1]), args[1], "<dev string:x1054>");

      if(!isDefined(args) || !isDefined(args[0]) || args[0] == "<dev string:xca1>") {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1059>" + platelevel);
      } else if(issubstr(args[0], "<dev string:x1072>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1059>" + platelevel + "<dev string:x107b>");
      } else if(issubstr(args[0], "<dev string:x1085>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1059>" + platelevel + "<dev string:x108e>");
      } else if(issubstr(args[0], "<dev string:x1098>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1059>" + platelevel + "<dev string:x10a3>");
      } else if(issubstr(args[0], "<dev string:x10af>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x10bb>");
      } else if(issubstr(args[0], "<dev string:x10dc>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x10ed>");
      }

      if(!isDefined(lootid)) {
        break;
      }

      foreach(player in level.players) {
        if(!isbot(player)) {
          continue;
        }

        player.avoidkillstreakonspawntimer = undefined;
        player lootitem(lootid, 1);
        player scripts\cp_mp\armor::setarmorhealth(player.maxarmorhealth);
      }

      break;
    case #"hash_ad34b62d6259eff9":
      lootid = undefined;

      if(issubstr(args[0], "<dev string:x1128>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1130>");
      } else if(issubstr(args[0], "<dev string:x1148>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1152>");
      } else if(issubstr(args[0], "<dev string:x116c>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1175>");
      } else if(issubstr(args[0], "<dev string:x118e>")) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("<dev string:x1198>");
      }

      if(!isDefined(lootid)) {
        break;
      }

      foreach(player in level.players) {
        if(!isbot(player)) {
          continue;
        }

        player lootitem(lootid, 1);
      }

      break;
    case #"hash_a500569760927bb6":
      foreach(player in level.players) {
        if(isbot(player)) {
          continue;
        }

        player scripts\mp\menus::handleteamchange("<dev string:x11c4>", 3);
        break;
      }

      break;
    case #"hash_f43300f0e110f9f7":
      foreach(player in level.players) {
        if(isbot(player)) {
          continue;
        }

        if(isDefined(level.var_4358d3a0ee13b0f9)) {
          [[level.var_4358d3a0ee13b0f9]](player, player.origin);
        }

        break;
      }

      break;
    case #"hash_d729000c152b2477":
      if(isDefined(level.deployablekiosks) && isDefined(level.deployablekiosks.drones)) {
        level.deployablekiosks.drones = array_removeundefined(level.deployablekiosks.drones);

        foreach(deployablekiosk in level.deployablekiosks.drones) {
          if(isDefined(level.var_ae0244c4c517ba75)) {
            deployablekiosk thread[[level.var_ae0244c4c517ba75]](level.players[0]);
          }
        }
      }

      break;
    case #"hash_b60a10a83e46ca28":
      function_5263a8371400329b();
      break;
    case #"hash_e3a60bc0c0aa07ff":
      part = args[0];
      state = args[1];
      ent = function_274ba9ea825a3b5f(level.player);

      if(isDefined(ent)) {
        result = ent scripts\common\utility::function_3677f2be30fdd581(part, state);

        if(result) {
          color = (0, 1, 0);
          text = "<dev string:x122c>";
        } else {
          color = (1, 0, 0);
          text = "<dev string:x1237>";
        }

        iprintlnbold(text);
        drawentitybounds(ent, color, 1, 20);
      } else {
        iprintlnbold("<dev string:x1241>");
      }

      break;
    case #"hash_bf920f1431fc58e7":
      level.players[0] nightvisionviewon();
      break;
    case #"hash_8f2d4dcab02be48b":
      level.players[0] nightvisionviewoff();
      break;
    case #"hash_77cdec786733416b":
      if(!isDefined(level.var_ec572828f01f1c6d)) {
        break;
      }

      blacksite = undefined;

      if(isDefined(firstplayer.blacksites) && firstplayer.blacksites.size > 0) {
        blacksite = firstplayer.blacksite[0];
      } else if(isDefined(level.var_f1073fbd45b59a06.blacksites)) {
        var_e880c9b9e22eb6c1 = randomint(level.var_f1073fbd45b59a06.blacksites.size);
        blacksite = level.var_f1073fbd45b59a06.blacksites[var_e880c9b9e22eb6c1];
      }

      firstplayer[[level.var_ec572828f01f1c6d]](blacksite);
      break;
    case #"hash_5bfe76ac355e2867":
      if(!isDefined(level.var_91044985cdb24c8b)) {
        break;
      }

      blacksite = undefined;

      if(isDefined(firstplayer.blacksites) && firstplayer.blacksites.size > 0) {
        blacksite = firstplayer.blacksite[0];
      } else if(isDefined(level.var_f1073fbd45b59a06.blacksites)) {
        var_e880c9b9e22eb6c1 = randomint(level.var_f1073fbd45b59a06.blacksites.size);
        blacksite = level.var_f1073fbd45b59a06.blacksites[var_e880c9b9e22eb6c1];
      }

      firstplayer[[level.var_91044985cdb24c8b]](blacksite);
      break;
    case #"hash_9ae0f27e349cd333":
      var_eb88a0310ff63e64 = scripts\mp\dev::function_42b151a494105e10();

      if(level.players.size <= 1) {
        setDvar(@ "hash_2d5236cbe9894aff", 5);
        wait 5;
      }

      players = level.players;
      players = array_remove(players, var_eb88a0310ff63e64);
      var_9df309bd9117ce5f = 250;
      var_8a045fb3b3ee60b9 = 3;
      forwardoffset = anglesToForward(var_eb88a0310ff63e64.angles) * var_9df309bd9117ce5f;
      rightoffset = anglestoright(var_eb88a0310ff63e64.angles) * var_9df309bd9117ce5f;
      var_16ec8ffc50cefb81 = forwardoffset + (0, 0, 75);

      for(i = 0; i < players.size; i++) {
        player = players[i];

        if(!isalive(player)) {
          continue;
        }

        var_fb17e52b2262b64f = var_16ec8ffc50cefb81;
        var_fb17e52b2262b64f += rightoffset * ceil(i % var_8a045fb3b3ee60b9 / 2) * ter_op(i % 2, 1, -1);
        var_fb17e52b2262b64f += forwardoffset * floor(i / var_8a045fb3b3ee60b9);
        player setOrigin(var_eb88a0310ff63e64.origin + var_fb17e52b2262b64f);
      }

      wait 5;

      if(issharedfuncdefined("<dev string:x12ab>", "<dev string:x12b8>")) {
        [[getsharedfunc("<dev string:x12ab>", "<dev string:x12b8>")]](players, args);
      }

      break;
    case #"hash_70f3163baf120876":
      var_477bd548940c3a78 = args[0];
      omnvarvalue = undefined;

      if(args.size > 1) {
        omnvarvalue = int(args[1]);
      }

      if(!isDefined(omnvarvalue)) {
        omnvarvalue = 1;
      }

      firstplayer preloadcinematicforplayer(var_477bd548940c3a78);
      firstplayer playcinematicforplayer(var_477bd548940c3a78);
      firstplayer setclientomnvar("<dev string:x12dd>", omnvarvalue);
      wait 5;
      firstplayer setclientomnvar("<dev string:x12dd>", 0);
      firstplayer stopcinematicforplayer();
      break;
    case #"hash_8673ffe7cf06c3b1":
      player = firstplayer;
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
      blacksite = level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d[0];
      blacksite notify("<dev string:x130d>");
      waitframe();
      boss = blacksite.var_837c4b569aa8a376[0];
      [firstguard] = function_7eb04ca16d045775("<dev string:x1327>");
      scripts\mp\agents\agent_utility::killagent(firstguard);
      wait 1;
      aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("<dev string:x1339>")[0];
      namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype, boss.origin, (0, 0, 0), boss.team);
      break;
    case #"hash_259e6db48da06ba7":
      if(args.size > 1) {
        attacker = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[0]);
        victim = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[1]);

        if(isDefined(attacker) && isDefined(victim) && isDefined(level.var_d1df695cab85185c)) {
          victim thread[[level.var_d1df695cab85185c]](attacker);
          attacker function_758ee105bdf0c62d();
        }
      }

      break;
    case #"hash_78bd6494a4d6e599":
      if(args.size > 0) {
        perk = args[0];
        player = level.players[0];

        if(args.size > 1) {
          player = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[1]);
        }

        if(isDefined(player) && isDefined(perk)) {
          player giveperk(perk);
        }
      }

      break;
    case #"hash_3ed5eb31dd5ed16c":
      if(args.size > 0) {
        var_84a5decdc6b5a4c0 = args[0];
        weaponobj = function_fb77bd36161c7d9b(var_84a5decdc6b5a4c0);
        player = level.players[0];

        if(args.size > 1) {
          player = devgetplayerbyname(args[1]);
        }

        if(isDefined(weaponobj)) {
          maxammo = weaponmaxammo(weaponobj);
          dropstruct = function_7b9f3966a7a42003();
          dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
          scripts\mp\gametypes\br_pickups::spawnpickup(var_84a5decdc6b5a4c0, dropinfo, maxammo, 1, weaponobj, 0, 0);
        }
      }

      break;
    case #"hash_cf9a6afff924db7d":
      reviver = undefined;
      revivee = undefined;
      var_b1ba82194643d11d = 1;
      itemdata = ["<dev string:x13a2>": ["<dev string:x866>": [], "<dev string:x7f4>": []], "<dev string:x1397>": ["<dev string:x866>": [], "<dev string:x7f4>": []]];

      if(args.size > 0) {
        foreach(arg in args) {
          var_a6bf85cbfade3e88 = tolower(arg);
          multival = strtok(var_a6bf85cbfade3e88, "<dev string:x13ad>");

          switch (multival.size) {
            case 2:
              player = scripts\mp\gametypes\br_dev::devgetplayerbyname(multival[1]);

              if(isDefined(player)) {
                switch (multival[0]) {
                  case #"hash_94a335b456789386":
                    reviver = player;
                    break;
                  case #"hash_94a348b45678b16f":
                    revivee = player;
                    break;
                }
              }

              break;
            case 1:
              var_f56523e4e60d3b68 = issubstr(var_a6bf85cbfade3e88, "<dev string:x13a2>");
              var_f5651ae4e60d279d = issubstr(var_a6bf85cbfade3e88, "<dev string:x1397>");
              takeitem = getsubstr(var_a6bf85cbfade3e88, 0, 2) == "<dev string:x13b2>";
              var_47b75bbc48a0809a = issubstr(var_a6bf85cbfade3e88, "<dev string:x13b8>");
              var_e74398cf5ec73470 = issubstr(var_a6bf85cbfade3e88, "<dev string:x13c5>");
              playerkey = undefined;

              if(istrue(var_f56523e4e60d3b68)) {
                playerkey = "<dev string:x13a2>";
              } else if(istrue(var_f5651ae4e60d279d)) {
                playerkey = "<dev string:x1397>";
              }

              if(isDefined(playerkey)) {
                arrkey = undefined;
                itemval = undefined;

                if(istrue(takeitem)) {
                  arrkey = "<dev string:x866>";
                } else {
                  arrkey = "<dev string:x7f4>";
                }

                if(istrue(var_47b75bbc48a0809a)) {
                  itemval = "<dev string:x13d5>";
                } else if(istrue(var_e74398cf5ec73470)) {
                  itemval = "<dev string:x13f5>";
                }

                if(isDefined(itemval)) {
                  var_2473e092f49eb0d6 = itemdata[playerkey][arrkey].size;
                  var_80d10756b23df0bf = 1;
                  itemdata[playerkey][arrkey][var_2473e092f49eb0d6] = itemval;
                }
              }

              if(!istrue(var_80d10756b23df0bf)) {
                switch (var_a6bf85cbfade3e88) {
                  case #"hash_285e1562bf1a1d13":
                    var_e1407db69ba9775f = 1;
                    break;
                  default:
                    player = scripts\mp\gametypes\br_dev::devgetplayerbyname(var_a6bf85cbfade3e88);

                    if(isDefined(player)) {
                      if(!isDefined(reviver)) {
                        reviver = player;
                      }
                    }

                    break;
                }
              }

              break;
            default:
              break;
          }
        }
      }

      if(!isDefined(reviver)) {
        reviver = level.players[0];
      }

      attacker = undefined;

      foreach(player in level.players) {
        if(!isDefined(attacker) && player.team != reviver.team && isreallyalive(player) && !isinlaststand(player)) {
          attacker = player;
        }

        if(!isDefined(revivee) && player != reviver && (!istrue(var_b1ba82194643d11d) || isbot(player)) && player.team == reviver.team && isreallyalive(player) && !isinlaststand(player)) {
          revivee = player;
        }

        if(isDefined(revivee) && isDefined(attacker)) {
          break;
        }
      }

      if(!isDefined(revivee)) {
        return;
      }

      itemdata["<dev string:x13a2>"]["<dev string:x141f>"] = revivee;
      itemdata["<dev string:x1397>"]["<dev string:x141f>"] = reviver;

      if(istrue(var_e1407db69ba9775f) && !revivee br_public::hasselfrevivetoken()) {
        revivee function_aaaa1b3dfe18885c(1, 8548);
      }

      foreach(playerarr in itemdata) {
        foreach(item in ["<dev string:x13f5>", "<dev string:x13d5>"]) {
          player = playerarr["<dev string:x141f>"];
          isperk = issubstr(item, "<dev string:x1429>");
          var_4aa12e0ed3f6b745 = issubstr(item, "<dev string:x1437>");

          if(array_contains(playerarr["<dev string:x7f4>"], item)) {
            if(isperk) {
              if(!player _hasperk(item)) {
                player giveperk(item);
              }
            } else if(var_4aa12e0ed3f6b745) {
              player function_9a34cb51ac957c0(item);
            }
          }

          if(array_contains(playerarr["<dev string:x866>"], item)) {
            if(isperk) {
              if(player _hasperk(item)) {
                player removeperk(item);
              }

              continue;
            }

            if(var_4aa12e0ed3f6b745) {
              if(isDefined(player.var_4045f099f3da4bd) && player.var_4045f099f3da4bd == item) {
                player function_f5e211bdcc0d8f79();
              }
            }
          }
        }
      }

      lookpos = getplayerlookatpos(reviver);
      revivee setOrigin(lookpos);

      if(isreallyalive(revivee)) {
        if(!isinlaststand(revivee)) {
          revivee dodamage(99999, attacker.origin, attacker, attacker, "<dev string:x98b>");
        } else if(isDefined(revivee.var_65a2b57b2b474c00)) {
          revivee.var_65a2b57b2b474c00.curprogress = 0;
        }
      }

      if(isbot(revivee) && istrue(var_e1407db69ba9775f)) {
        level.var_78184ec36f669844 = 1;
        revivee.var_f932828585d0926c = 1;
      }

      thread function_1eaac96384e4a9d7(revivee);
      break;
    case #"hash_f8135c74ca6027b2":
      revivee = level.players[0];

      if(args.size > 0) {
        foreach(arg in args) {
          var_a6bf85cbfade3e88 = tolower(arg);

          if(var_a6bf85cbfade3e88 == "<dev string:x145c>") {
            var_757d32718dcfc4e6 = 1;
            continue;
          }

          if(var_a6bf85cbfade3e88 == "<dev string:x146c>") {
            var_9bf3bd9792819eec = 1;
            continue;
          }

          player = scripts\mp\gametypes\br_dev::devgetplayerbyname(var_a6bf85cbfade3e88);

          if(isDefined(player)) {
            revivee = player;
          }
        }
      }

      if(!isDefined(revivee)) {
        return;
      }

      attacker = undefined;

      foreach(player in level.players) {
        if(!isDefined(attacker) && player.team != revivee.team && isreallyalive(player) && !isinlaststand(player)) {
          attacker = player;
          break;
        }
      }

      if(!revivee br_public::hasselfrevivetoken()) {
        revivee function_aaaa1b3dfe18885c(1, 8548);
      }

      if(istrue(var_757d32718dcfc4e6) && !revivee _hasperk("<dev string:x13f5>")) {
        revivee giveperk("<dev string:x13f5>");
      }

      if(istrue(var_9bf3bd9792819eec)) {
        revivee function_9a34cb51ac957c0("<dev string:x13d5>");
      }

      if(isDefined(attacker)) {
        damagepos = attacker.origin;
      } else {
        damagepos = revivee.origin;
      }

      if(isreallyalive(revivee) && !isinlaststand(revivee)) {
        revivee dodamage(99999, damagepos, attacker, attacker, "<dev string:x98b>");
      } else if(isDefined(revivee.var_65a2b57b2b474c00)) {
        revivee.var_65a2b57b2b474c00.curprogress = 0;
      }

      thread function_1eaac96384e4a9d7(revivee);
      break;
    case #"hash_ad336c5f44b99d2e":
      player = level.players[0];

      if(args.size > 0) {
        argplayer = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[0]);

        if(isDefined(argplayer)) {
          player = argplayer;
        }
      }

      player namespace_708f627020de59d3::function_19868614946c4df4();
      player function_e98a5a4e0e001ac3(player);
      defaultperks = scripts\mp\class::function_87c3b562f2b366ee(player);

      if(isDefined(player.perks)) {
        foreach(perk, count in player.perks) {
          if(isDefined(player.loadoutperks) && array_contains(player.loadoutperks, perk)) {
            player.loadoutperks = array_remove(player.loadoutperks, perk);
          }

          if(!array_contains(defaultperks, perk)) {
            player scripts\mp\perks\perks::_unsetperk(perk);
          }
        }

        player function_df87366a6b9bc3a0(player.loadoutperks);
      }

      break;
    case #"hash_1f46336a51f2920c":
      thread function_d3b9dc1b6f956ff8();
      break;
    case #"hash_cb39bf247f39251f":
      if(args.size > 0) {
        victim = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[0]);
        attacker = undefined;

        if(args.size > 1) {
          attacker = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[0]);
        } else {
          foreach(player in level.players) {
            if(player.team != victim.team && isreallyalive(player)) {
              attacker = player;
              break;
            }
          }
        }

        if(isDefined(attacker) && isDefined(victim)) {
          var_629cef8d43ca621b = namespace_708f627020de59d3::function_fb59c1d91c97a058(attacker);

          if(!isDefined(var_629cef8d43ca621b) || function_43044da0ed44d79f(var_629cef8d43ca621b)) {
            var_a746cf0b1aac05a1 = getarraykey(level.var_952400f520b7f68d, randomint(level.var_952400f520b7f68d.size));
            lootref = level.br_pickups.var_838863c4848d4c26[var_a746cf0b1aac05a1];
            fakeent = spawnStruct();
            fakeent.scriptablename = lootref;
            attacker namespace_708f627020de59d3::function_c3023358dc648bf1(fakeent, 0, 0, undefined, 0);
          }

          if(victim _hasperk("<dev string:x14c4>")) {
            victim removeperk("<dev string:x14c4>");
          }

          player.var_15da77dc195bd80a = 0;
          victim.var_add7dba6d7dab7d9 = 1;
          victim dodamage(999999, attacker.origin, attacker, attacker, "<dev string:x98b>");
          victim.var_add7dba6d7dab7d9 = undefined;
        }
      }

      break;
    case #"hash_8ffd6bd28ea1c5bc":
      if(args.size > 0) {
        equipref = args[0];
        [type, scriptbundle] = function_94c116c69c037a47(equipref, ["<dev string:x14f6>", "<dev string:x1503>", "<dev string:x150c>", "<dev string:x151d>"]);

        if(!isDefined(type) || !isDefined(scriptbundle)) {
          return;
        }

        switch (type) {
          case #"hash_93c71e7b6c0b81d7":
            equipmentref = scriptbundle.ref;
            equipmentbundle = scriptbundle;
            grenadeweaponref = scriptbundle.useweapon;
            grenadeweaponbundle = getscriptbundle("<dev string:x152e>", grenadeweaponref);
            break;
          case #"hash_e534fd8ec73eafb4":
            grenadeweaponref = scriptbundle.offhandweapon;
            grenadeweaponbundle = getscriptbundle("<dev string:x152e>", grenadeweaponref);
            superref = equipref;
            superbundle = scriptbundle;
            break;
          case #"hash_a30c9a25c758a239":
            grenadeweaponref = equipref;
            grenadeweaponbundle = scriptbundle;
            break;
          case #"hash_9c153fb2a039b16f":
            equipmentref = scriptbundle.baseweapon;
            equipstruct = ter_op(array_contains_key(level.equipment.table, equipmentref), level.equipment.table[equipmentref], undefined);

            if(!isDefined(equipstruct)) {
              return;
            }

            equipbundle = equipstruct.bundle;
            grenadeweaponref = equipstruct.weaponname;
            grenadeweaponbundle = getscriptbundle("<dev string:x152e>", grenadeweaponref);
            break;
          default:
            return;
        }

        if(!isDefined(equipmentref)) {
          foreach(equip, item in level.equipment.table) {
            if(item.weaponname == grenadeweaponref) {
              equipmentref = equip;
              equipmentbundle = item.bundle;
              break;
            }
          }
        }

        if(!isDefined(equipmentref)) {
          return;
        }

        if(isDefined(equipmentbundle)) {
          switch (equipmentbundle.equipmenttype) {
            case #"hash_b5ec22be8111413a":
            case #"hash_e534fd8ec73eafb4":
              if(!isDefined(superref)) {
                superref = scripts\mp\supers::getsuperrefforsuperuseweapon(grenadeweaponref);
                superbundle = getscriptbundle(hashcat("<dev string:x1553>", superref));
              }

              break;
          }
        }

        victim = level.players[0];

        if(args.size > 1) {
          argplayer = scripts\mp\gametypes\br_dev::devgetplayerbyname(args[1]);

          if(isDefined(argplayer)) {
            victim = argplayer;
          }
        }

        attacker = function_5da181c6905a7a49(victim);
        spawnpos = getplayerlookatpos(victim);

        if(!isDefined(attacker)) {
          return;
        }

        if(isDefined(superref)) {
          var_5d7589bf09bdf4d8 = getscriptbundle(level.supertable);

          foreach(item in var_5d7589bf09bdf4d8.super_list) {
            if(isDefined(item.bundle) && item.bundle == superref) {
              basesuper = item.ref;
              break;
            }
          }

          if(isDefined(basesuper)) {
            attacker givesuper(basesuper);
            attacker setOrigin(spawnpos);
            waitframe();
            attacker scripts\mp\perks\perkpackage::perkpackage_forceusesuper();
          }
        } else {
          grenade = attacker _launchgrenade(grenadeweaponref, spawnpos + (0, 0, 5), (0, 0, 0), undefined, 0);
          attacker scripts\mp\weapons::grenadeused(grenade);
        }
      }

      break;
    case #"hash_a9ac0a5962cdb952":
      isfriendly = 1;

      if(args.size > 0) {
        isfriendly = int(args[0]);
      }

      airstrikeowner = undefined;

      if(isfriendly) {
        teammates = scripts\mp\utility\teams::getteamdata(firstplayer.team, "<dev string:x8a0>");

        if(teammates.size > 1) {
          foreach(teammate in teammates) {
            if(teammate != firstplayer) {
              airstrikeowner = teammate;
              break;
            }
          }
        }
      } else {
        foreach(teamname, teamdata in level.teamdata) {
          if(teamname == firstplayer.team) {
            continue;
          }

          teammembers = scripts\mp\utility\teams::getteamdata(teamname, "<dev string:x8a0>");

          if(teammembers.size > 0) {
            airstrikeowner = teammembers[0];
            break;
          }
        }
      }

      if(isDefined(airstrikeowner)) {
        streakinfo = spawnStruct();
        streakinfo.streakname = "<dev string:x1578>";
        streakinfo.debug_state = "<dev string:x158f>";
        streakinfo.shots_fired = 0;
        location = firstplayer.origin;
        animname = level.scr_anim[streakinfo.streakname]["<dev string:x159c>"];
        strikeanimlength = getanimlength(animname);
        var_7225662d8217d65a = get_notetrack_time(animname, "<dev string:x15af>");
        var_b333ee8fea365230 = strikeanimlength - 5;
        airstrikeid = scripts\cp_mp\killstreaks\airstrike::airstrike_addactivestrike(location, airstrikeowner, var_b333ee8fea365230);
        airstrikeowner thread airstrike_watchkills(streakinfo, var_7225662d8217d65a * 2, airstrikeid);
        airstrikeowner thread watchairstrikeowner(airstrikeid);
        airstrikeowner thread airstrike_watchgameend(streakinfo, airstrikeid);
        airstrikeowner finishairstrikeusage(location, undefined, undefined, streakinfo, animname, airstrikeid);
        level thread function_7893c28cfbf65865(airstrikeowner, airstrikeid, var_b333ee8fea365230);
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(strikeanimlength);
        level scripts\common\callbacks::callback("<dev string:x15b9>", {
          #streakinfo: streakinfo
        });
      }

      break;
    case #"hash_19160383ea61c1b5":
      var_742e3b452c9bb9b0 = 0;

      if(args.size > 0) {
        var_742e3b452c9bb9b0 = int(args[0]);
      }

      level thread function_533bda33b99fab22(firstplayer, var_742e3b452c9bb9b0);
      break;
    case #"hash_42ad8d3fb508a6fa":
      firstplayer armor::setarmorhealth(0, 1);
      break;
    case #"hash_fe06721ae7b3b1b9":
      if(!isDefined(level.var_523ee9a874d0430b)) {
        level.var_523ee9a874d0430b = 0;
      }

      for(var_3b7bea3004fd87b7 = 0; var_3b7bea3004fd87b7 < level.characters.size; var_3b7bea3004fd87b7++) {
        characterindex = level.var_523ee9a874d0430b % level.characters.size;
        character = level.characters[characterindex];
        level.var_523ee9a874d0430b++;

        if(isDefined(character) && isbot(character) && isalive(character) && character.sessionstate == "<dev string:x160c>" && character.team == firstplayer.team) {
          br_forcegivecustompickupitem(character, "<dev string:x1617>", 1);
          break;
        }
      }
    case #"hash_6a211d2111ca0512":
      var_5c44f11f3a4f25ee = 31;

      if(args.size > 0) {
        var_5c44f11f3a4f25ee = int(args[0]);
      }

      firstplayer namespace_b97271dc63a81cc0::function_a25d14ecf8dcb49e(var_5c44f11f3a4f25ee);
      break;
    case #"hash_2e720b32adac25d0":
      if(args.size > 0) {
        var_4ac7b6bdde12a915 = function_1823ff50bb28148d(args[0]);
        firstplayer.var_657f5a0d17435bc.completed[var_4ac7b6bdde12a915] = 0;
        firstplayer.var_657f5a0d17435bc.var_5eb1da668993b439[var_4ac7b6bdde12a915] = 0;
        firstplayer namespace_91fad7208d9cd856::function_28f32fc9e57814f6(var_4ac7b6bdde12a915);
      }

      break;
    case #"hash_71eb73729a5d32e":
      foreach(player in level.players) {
        if(player == firstplayer || !isbot(player)) {
          continue;
        }

        player setstance("<dev string:x166d>", 0, 1, 1);
        superref = player getcurrentsuperref();

        if(isDefined(superref)) {
          superweapon = level.superglobals.staticsuperdata[superref].weapon;
          var_354f8655b711b4b1 = makeweapon(superweapon);
          player scripts\mp\supers::trysuperusebegin(var_354f8655b711b4b1);
        }
      }

      break;
    case #"hash_1b06b29b865f7498":
      if(!(args.size == 2 || args.size == 3)) {
        var_5830e0fe041611e4 = "<dev string:x1688>";
        iprintlnbold(var_5830e0fe041611e4);
        println(var_5830e0fe041611e4);
        return;
      }

      animname = args[0];
      var_d1bec1cd8223b6e4 = int(args[1]);
      var_deca4c4385b27256 = 1;

      if(isDefined(args[2])) {
        var_deca4c4385b27256 = int(args[2]);
      }

      if(!(isstring(animname) && isDefined(var_d1bec1cd8223b6e4) && isDefined(var_deca4c4385b27256) && var_deca4c4385b27256 >= 0)) {
        var_4af8047bfd3d32e9 = "<dev string:x16c6>";
        iprintlnbold(var_4af8047bfd3d32e9);
        println(var_4af8047bfd3d32e9);
        return;
      }

      if(var_d1bec1cd8223b6e4 == 0) {
        firstplayer notify("<dev string:x1712>" + animname);
      } else {
        firstplayer thread function_af939b4dfd7f0769(animname, var_d1bec1cd8223b6e4, var_deca4c4385b27256);
      }

      break;
    case #"hash_c86c74c954b6f1e6":
      if(!isDefined(level.var_fd4ccfdbe4fe025)) {
        var_79a95c318068740d = "<dev string:x1748>";
        iprintlnbold(var_79a95c318068740d);
        println(var_79a95c318068740d);
        return;
      }

      if(args.size != 1) {
        var_5830e0fe041611e4 = "<dev string:x1770>";
        iprintlnbold(var_5830e0fe041611e4);
        println(var_5830e0fe041611e4);
        return;
      }

      var_5d92e0911522c004 = int(args[0]);

      if(!isDefined(var_5d92e0911522c004)) {
        var_4af8047bfd3d32e9 = "<dev string:x17a1>";
        iprintlnbold(var_4af8047bfd3d32e9);
        println(var_4af8047bfd3d32e9);
        return;
      }

      if(var_5d92e0911522c004 == 0) {
        firstplayer notify("<dev string:x17e8>");
      } else {
        firstplayer thread function_bc3a107bcc4124a9(var_5d92e0911522c004 - 1);
      }

      break;
    default:
      break;
  }
}

function givesuper(superref) {
  if(!isDefined(superref) || !array_contains_key(level.br_pickups.var_838863c4848d4c26, superref)) {
    return;
  }

  var_a06806243448e2c7 = level.br_pickups.var_838863c4848d4c26[superref];
  fakeent = spawnStruct();
  fakeent.scriptablename = var_a06806243448e2c7;
  fakeent.count = 1;
  scripts\mp\gametypes\br_pickups::takesuperpickup(fakeent);
}

function function_94c116c69c037a47(refname, typearr) {
  foreach(type in typearr) {
    bundlestr = type + "<dev string:x180b>" + refname;
    bundle = getscriptbundle(bundlestr);

    if(isDefined(bundle)) {
      return [type, bundle];
    }
  }

  return [undefined, undefined];
}

function function_5da181c6905a7a49(targetplayer, botsonly) {
  if(!isDefined(botsonly)) {
    botsonly = 0;
  }

  if(!isDefined(targetplayer)) {
    return;
  }

  if(isstring(targetplayer)) {
    targetplayer = scripts\mp\gametypes\br_dev::devgetplayerbyname(targetplayer);
  }

  if(!isDefined(targetplayer) || !isPlayer(targetplayer)) {
    return;
  }

  foreach(player in level.players) {
    if(player.team != targetplayer.team && isreallyalive(player) && !isinlaststand(player) && (isbot(player) || !istrue(botsonly))) {
      return player;
    }
  }
}

function function_fb77bd36161c7d9b(scriptable, lootweaponlist) {
  if(!isDefined(lootweaponlist)) {
    lootweaponlist = "<dev string:x1810>";
  }

  var_97f1b48fd49a7224 = getscriptbundle(hashcat(%"hash_36fa976a8ae12763", lootweaponlist));

  if(isDefined(var_97f1b48fd49a7224) && isDefined(var_97f1b48fd49a7224.var_890049f984dd3e53)) {
    foreach(data in var_97f1b48fd49a7224.var_890049f984dd3e53) {
      lootitemdef = data.loot_item_def;

      if(isDefined(lootitemdef)) {
        lootitem = getscriptbundle(hashcat(%"loot_item_def:", lootitemdef));

        if(isDefined(lootitem)) {
          if(lootitem.name == scriptable) {
            lootid = lootitem.lootid;
            weaponroot = function_1cc3fd00b6ccc3ba(lootid);
            var_25152a36c536d7f = loot::function_793e8a72cedb8ef3(lootid);
            attachmentlistbundle = lootitem.attachmentlist;
            attachmentlist = getscriptbundle(hashcat(%"hash_6ab26ee9c0dc2c2f", attachmentlistbundle));
            attachmenttoidmap = [];

            if(isDefined(attachmentlist)) {
              foreach(data in attachmentlist.attachment_list) {
                if(isDefined(data.attachmentid)) {
                  attachmenttoidmap[data.attachment] = data.attachmentid;
                  continue;
                }

                attachmenttoidmap[data.attachment] = 0;
              }
            }

            baseweaponname = weaponroot;
            camo = undefined;

            if(isDefined(lootitem.camo)) {
              camo = lootitem.camo;
            }

            fullweaponobj = undefined;

            if(!isDefined(attachmenttoidmap)) {
              fullweaponobj = scripts\cp_mp\weapon::buildweapon_attachmentidmap(weaponroot, camo, undefined, undefined);
            } else {
              fullweaponobj = scripts\cp_mp\weapon::buildweapon_attachmentidmap(weaponroot, attachmenttoidmap, camo, undefined, undefined);
            }

            return fullweaponobj;
          }
        }
      }
    }
  }
}

function function_9a34cb51ac957c0(var_19cadf7d520f4072, maxwaittimems) {
  function_e98a5a4e0e001ac3(self, var_19cadf7d520f4072);
  waittime = 0;
  maxwaittime = 1000;

  if(isDefined(maxwaittimems)) {
    maxwaittime = maxwaittimems;
  }

  while(self.var_4045f099f3da4bd != var_19cadf7d520f4072) {
    if(waittime >= maxwaittime) {
      return;
    }

    waitframe();
    waittime += level.frameduration;
  }

  return 1;
}

function function_f5e211bdcc0d8f79() {
  var_2e1d1af8afe39ba8 = getdvarint(@ "scr_br_plate_carrier_start_level", 3);
  var_347aa4935f42810 = scripts\mp\gametypes\br_public::function_c2f2bb9e0ae9a454(var_2e1d1af8afe39ba8);
  function_9a34cb51ac957c0(var_347aa4935f42810);
}

function function_1eaac96384e4a9d7(revivee) {
  level endon("<dev string:x1828>");
  revivee endon("<dev string:x1836>");
  revivee notify("<dev string:x1844>");
  revivee.revivetimems = 0;
  revivee.var_4ab61a57453e2816 = 1;
  notifycalled = revivee waittill_any_return_4("<dev string:x185f>", "<dev string:x1875>", "<dev string:x188c>", "<dev string:x1844>");

  if((notifycalled == "<dev string:x185f>" || notifycalled == "<dev string:x1875>") && isalive(revivee) && isDefined(revivee.revivetimems) && revivee.revivetimems > 0) {
    targetms = 3000;
    framecount = int(targetms / level.frameduration + 0.5);
    revivetimestr = "<dev string:x1895>" + revivee.revivetimems + "<dev string:x18a9>";
    printtoscreen2d(800, 300, revivetimestr, (1, 1, 1), 2, framecount);
  }

  if(notifycalled != "<dev string:x1844>") {
    revivee.var_4ab61a57453e2816 = undefined;
    revivee.revivetimems = undefined;
    revivee.var_f932828585d0926c = undefined;
  }
}

function function_4d1c100badcf41a8(player, defname) {
  playerorigin = player.origin;
  playerangles = player getplayerangles();
  playerforward = anglesToForward(playerangles);
  tracestart = (playerorigin[0], playerorigin[1], playerorigin[2] + player getplayerviewheight());
  traceend = tracestart + playerforward * 5000;
  tracecontents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, player, tracecontents);
  spawnorigin = tracestart + playerforward * 100;

  if(trace["<dev string:x18b0>"] < 1) {
    spawnorigin = trace["<dev string:x18bc>"];
  }

  spawnorigin += (0, 0, 5);
  scriptable = spawnscriptable(defname, spawnorigin, (0, 0, 0));
  scripts\mp\gametypes\br_pickups::registerscriptableinstance(scriptable);
  return scriptable;
}

function function_5d92949cc218ebdd(playername) {
  return strtok(playername, "<dev string:x18c8>")[0];
}

function function_b2dcd958dd436171(name) {
  foreach(player in level.players) {
    shortname = function_5d92949cc218ebdd(player.name);

    if(tolower(shortname) == name) {
      return player;
    }
  }

  return undefined;
}

function function_5b5ab8ab53c49d4d(victimname, attackername) {
  attacker = undefined;
  victimname = tolower(victimname);
  victim = function_b2dcd958dd436171(victimname);

  if(isDefined(attackername)) {
    attackername = tolower(attackername);

    foreach(player in level.players) {
      shortname = function_5d92949cc218ebdd(player.name);

      if(tolower(shortname) == attackername) {
        attacker = player;
        break;
      }
    }
  } else {
    foreach(player in level.players) {
      if(victim.team != player.team) {
        attacker = player;
        break;
      }
    }
  }

  if(isDefined(victim)) {
    victim.var_add7dba6d7dab7d9 = 1;
    victim dodamage(999999, victim.origin, attacker, attacker, "<dev string:x98b>");
    victim.var_add7dba6d7dab7d9 = undefined;
  }
}

function function_53a0f5e4d6bbc7a4(victimname, attackername, damage) {
  victim = undefined;
  attacker = undefined;
  victimname = tolower(victimname);
  attackerweapon = undefined;

  foreach(player in level.players) {
    shortname = function_5d92949cc218ebdd(player.name);

    if(tolower(shortname) == victimname) {
      victim = player;
      break;
    }
  }

  if(isDefined(attackername)) {
    attackername = tolower(attackername);

    foreach(player in level.players) {
      shortname = function_5d92949cc218ebdd(player.name);

      if(tolower(shortname) == attackername) {
        attacker = player;
        attackerweapon = attacker.primaryweapon;
        break;
      }
    }
  } else {
    foreach(player in level.players) {
      if(victim.team != player.team) {
        attacker = player;
        break;
      }
    }
  }

  if(isDefined(victim)) {
    victim dodamage(float(damage), victim.origin, attacker, attacker);
  }
}

function function_72c1806e62a9bd10(playername, var_6be1bd68cd41dbbd) {
  playername = tolower(playername);

  foreach(player in level.players) {
    shortname = function_5d92949cc218ebdd(player.name);

    if(tolower(shortname) == playername) {
      clientnum = player getentitynumber();

      if(istrue(var_6be1bd68cd41dbbd)) {
        kick(clientnum, "<dev string:x18cd>", 1);
      } else {
        kick(clientnum);
      }

      break;
    }
  }
}

function function_5718089fc75809c3() {
  start = self getEye();
  dir = anglesToForward(self getplayerangles());
  end = start + 8000 * dir;
  trace = scripts\engine\trace::_bullet_trace(start, end, 1, self);
  player = undefined;

  if(isDefined(trace["<dev string:x18ea>"]) && isPlayer(trace["<dev string:x18ea>"]) && isreallyalive(trace["<dev string:x18ea>"])) {
    player = trace["<dev string:x18ea>"];
  }

  return player;
}

function function_78ec4accff5f158b(player) {
  angles = player getplayerangles();
  fwd = anglesToForward(angles);
  eye = player getEye();
  end = eye + fwd * 10000;
  traces = scripts\engine\trace::ray_trace_get_all_results(eye, end);

  foreach(trace in traces) {
    if(!isDefined(trace["<dev string:x18ea>"])) {
      return trace["<dev string:x18bc>"];
    }
  }

  return undefined;
}

function function_274ba9ea825a3b5f(player) {
  angles = player getplayerangles();
  fwd = anglesToForward(angles);
  eye = player getEye();
  end = eye + fwd * 10000;
  traces = scripts\engine\trace::ray_trace_get_all_results(eye, end);

  foreach(trace in traces) {
    if(isDefined(trace["<dev string:x18ea>"])) {
      return trace["<dev string:x18ea>"];
    }
  }

  return undefined;
}

function function_c3b8a31470635593(winningteam) {
  setDvar(@ "hash_31bfb430e958888c", 2);
  wait 2;

  foreach(team in level.teamswithplayers) {
    if(team != winningteam) {
      teamplayers = getteamdata(team, "<dev string:x8a0>");

      foreach(player in teamplayers) {
        if(isalive(player)) {
          player.var_add7dba6d7dab7d9 = 1;
          player dodamage(999999, player.origin, player, player, "<dev string:x98b>");
          player.var_add7dba6d7dab7d9 = undefined;
          wait 1;
        }
      }
    }
  }
}

function function_429110eb5af4a19c() {
  foreach(team in level.teamnamelist) {
    teamcount = getteamdata(team, "<dev string:x18f4>");

    if(teamcount && !array_contains(level.teamswithplayers, team)) {
      level.teamswithplayers[level.teamswithplayers.size] = team;
    }
  }
}

function function_9bb9422480e6aa6d() {
  level endon("<dev string:x1828>");

  if(istrue(level.var_4887475a9fd2c26)) {
    return;
  }

  level.var_4887475a9fd2c26 = 1;
  hudtext = function_1ce3276d3ef55a0a("<dev string:x1901>", 0.8);
  hudtext setpoint("<dev string:x190c>", "<dev string:x190c>", 200, 160);
  hudtext setdevtext("<dev string:x1917>");

  for(lastmessage = "<dev string:xca1>"; true; lastmessage = nameinfo) {
    wait 0.1;

    if(!isDefined(level.players) || !level.players.size) {
      continue;
    }

    nameinfo = "<dev string:xca1>";
    function_429110eb5af4a19c();

    foreach(teamname in level.teamswithplayers) {
      var_6428e68df37399d3 = "<dev string:x192d>";

      if(isDefined(level.var_8f337a661bccb9f) && isDefined(level.var_8f337a661bccb9f[teamname])) {
        var_6428e68df37399d3 = level.var_8f337a661bccb9f[teamname];
      }

      nameinfo += "<dev string:x1937>" + teamname + "<dev string:x193d>" + var_6428e68df37399d3 + "<dev string:x1945>";
    }

    if(nameinfo != lastmessage) {
      hudtext setdevtext(nameinfo);
    }
  }
}

function function_2729e9ab8a4ec44e() {
  level endon("<dev string:x1828>");

  if(istrue(level.var_5f61ffe168666863)) {
    return;
  }

  level.var_5f61ffe168666863 = 1;
  hudtext = function_1ce3276d3ef55a0a("<dev string:x1901>", 0.8);
  hudtext setpoint("<dev string:x190c>", "<dev string:x190c>", 20, 160);
  hudtext setdevtext("<dev string:x194c>");

  for(lastmessage = "<dev string:xca1>"; true; lastmessage = nameinfo) {
    waitframe();

    if(!isDefined(level.players) || !level.players.size) {
      continue;
    }

    nameinfo = "<dev string:xca1>";
    function_429110eb5af4a19c();

    foreach(teamname in level.teamswithplayers) {
      nameinfo += "<dev string:x1937>" + teamname + "<dev string:x1964>";

      foreach(player in getteamarray(teamname)) {
        entnum = player getentitynumber();
        print3d(player.origin + (0, 0, 70), "<dev string:x196c>" + entnum + "<dev string:x1971>" + player.name, (1, 1, 1), 1, 0.4, 1);
        print3d(player.origin + (0, 0, 65), teamname + "<dev string:x1977>" + player.health + player.armorhealth, (1, 1, 1), 1, 0.3, 1);
        isplayeralive = isalive(player) && !istrue(player.gulag);
        var_2e74464713803f2f = get_int_or_0(player.gulaguses);
        playername = ter_op(isDefined(player.name), player.name, "<dev string:x197d>") + "<dev string:x1987>" + var_2e74464713803f2f + "<dev string:x198d>";

        if(isplayeralive) {
          nameinfo += "<dev string:x1992>" + playername + "<dev string:x199a>";
        } else if(!istrue(level.br_prematchstarted)) {
          nameinfo += "<dev string:x19a5>" + playername + "<dev string:x19ad>";
        } else if(scripts\mp\gametypes\br_spectate::isvalidspectatetarget(player)) {
          nameinfo += "<dev string:x19b7>" + playername + "<dev string:x19bf>";
        } else if(istrue(player.br_iseliminated)) {
          nameinfo += "<dev string:x19a5>" + playername + "<dev string:x19ca>";
          namecolor = ter_op(istrue(player.killcam), "<dev string:x19da>", "<dev string:x1937>");
          spectatingplayer = player getspectatingplayer();

          if(isDefined(spectatingplayer)) {
            nameinfo += "<dev string:x19e0>" + namecolor + spectatingplayer.name + "<dev string:x19e8>";
          }

          if(isDefined(level.var_8f337a661bccb9f) && isDefined(level.var_8f337a661bccb9f[player.team])) {
            nameinfo += "<dev string:x19ef>" + level.var_8f337a661bccb9f[player.team] + "<dev string:x19e8>";
          }
        } else {
          nameinfo += "<dev string:x1992>" + playername + "<dev string:x19f9>";
        }

        nameinfo += "<dev string:x1945>";
      }
    }

    if(nameinfo.size > 1000) {
      nameinfo = getsubstr(nameinfo, 0, 1000);
    }

    if(nameinfo != lastmessage) {
      hudtext setdevtext(nameinfo);
    }
  }
}

function function_1ce3276d3ef55a0a(font, fontscale) {
  hudelem = newhudelem();
  hudelem.elemtype = "<dev string:x1a06>";
  hudelem.font = font;
  hudelem.fontscale = fontscale;
  hudelem.basefontscale = fontscale;
  hudelem.x = 0;
  hudelem.y = 0;
  hudelem.width = 0;
  hudelem.height = int(level.fontheight * fontscale);
  hudelem.xoffset = 0;
  hudelem.yoffset = 0;
  hudelem.children = [];
  hudelem setparent(level.uiparent);
  hudelem.hidden = 0;
  return hudelem;
}

function function_69dffe7a5cb1b4b9() {
  foreach(player in level.players) {
    if(!isbot(player) && !istestclient(player)) {
      return player;
    }
  }
}

function function_7a26b30793922b87() {
  notbot = function_69dffe7a5cb1b4b9();

  if(!isDefined(notbot)) {
    iprintlnbold("<dev string:x1a0e>");
    return;
  }

  if(!istrue(level.br_prematchstarted)) {
    level notify("<dev string:x1a2f>");
    wait 3;
  }

  var_d3a4d4e30c0118d3 = [[getsharedfunc("<dev string:x1a42>", "<dev string:x1a4a>")]](notbot.team, 1);

  if(var_d3a4d4e30c0118d3.size < 2) {
    if(level.maxteamsize < 2) {
      level.maxteamsize = 2;
    }

    setDvar(@ "hash_9e5da81386e98d36", notbot.team);
    setDvar(@ "hash_955d9d2c8102c6bc", 1);

    while(var_d3a4d4e30c0118d3.size < 2) {
      waitframe();
      var_d3a4d4e30c0118d3 = [[getsharedfunc("<dev string:x1a42>", "<dev string:x1a4a>")]](notbot.team, 1);
    }

    frameswaited = 0;

    while(true) {
      if(frameswaited > 100) {
        iprintlnbold("<dev string:x1a60>");
        return;
      }

      friendlyready = 0;

      foreach(player in var_d3a4d4e30c0118d3) {
        if(player == notbot) {
          continue;
        }

        if(player.sessionstate != "<dev string:x1a8d>") {
          friendlyready = 1;
          break;
        }
      }

      if(friendlyready) {
        break;
      }

      frameswaited++;
      waitframe();
    }
  }

  waittillframeend();
  setDvar(@ "hash_12d23346fbacee91", 2);
  setDvar(@ "bot_disableattack", 1);
  notbot.gulagloser = 1;
  notbot scripts\mp\gametypes\br::sendafksquadmembertogulag();
}

function function_9cbddfdef8f1125b(bunkerindex) {
  player = self;
  player playersetkeypadstateindex(1);
  player playersetkeypadcodelengthindex(8);

  while(true) {
    player waittill("<dev string:x1a9a>", message, value);

    if(isDefined(message)) {
      if(message == "<dev string:x1aad>") {
        if(verifybunkercode(bunkerindex, value)) {
          player playersetkeypadstateindex(2);
          wait 2;
          iprintlnbold("<dev string:x1ac1>");
          break;
        } else {
          player playersetkeypadstateindex(3);
          waitframe();
          iprintlnbold("<dev string:x1ae9>");
          player playersetkeypadstateindex(1);
        }

        continue;
      }

      if(message == "<dev string:x1b11>") {
        break;
      }
    }
  }

  player playersetkeypadstateindex(0);
}

function devgetplayerbyname(playername) {
  playername = tolower(playername);

  foreach(player in level.players) {
    shortname = function_5d92949cc218ebdd(player.name);

    if(tolower(shortname) == playername) {
      return player;
    }
  }

  return undefined;
}

function function_bc261c1a1cb59524(player) {
  br_forcegivecustompickupitem(player, "<dev string:x1b23>", 1, level.br_pickups.maxcounts["<dev string:x1b23>"]);
}

function devgivemaxammo(player) {
  foreach(ammotype, maxcount in level.br_ammo_max) {
    br_ammo_give_type(player, ammotype, maxcount, 0);
  }
}

function function_28dc06904e18e469(player) {
  player scripts\mp\gametypes\br_plunder::playerplunderpickup(level.br_plunder.plunderlimit);
}

function function_c41e8bac1d7f3bc8(player) {
  player addrespawntoken();
}

function function_5377fd507f9ea057(player) {
  player addselfrevivetoken();
}

function function_559b4cb8f64848b5(player) {
  if(!isDefined(player.inlaststand)) {
    player removeselfrevivetoken();
  }
}

function function_a2fdd1067da9ff6e(player) {
  br_forcegivecustompickupitem(player, "<dev string:x1617>", 1);
}

function function_26ab41fd72f1c761(player) {
  lootweapon = scripts\mp\gametypes\br_weapons::br_getrandomlootweapon();
  br_forcegivecustompickupitem(player, lootweapon, 1);
}

function function_fe99ab4dc900865e() {
  killtriggers = getEntArray("<dev string:x1b39>", "<dev string:x1b49>");

  foreach(trigger in killtriggers) {
    trigger.targetname = "<dev string:x1b56>";
  }
}

function function_4c35185bbc6a8506() {
  host = scripts\mp\gamelogic::gethostplayer();

  foreach(player in level.players) {
    if(isDefined(player) && !isalive(player) && !istrue(player.br_iseliminated) && !istrue(player.gulag)) {
      if(isDefined(host)) {
        host iprintlnbold("<dev string:x1b65>" + player.name + "<dev string:x1b70>");
      }
    }
  }
}

function function_7c57dd42429eb995() {
  level endon("<dev string:x1828>");
  setdvarifuninitialized(@ "hash_5ec38dd7bdfbfe50", 0);

  while(true) {
    if(getdvarint(@ "hash_5ec38dd7bdfbfe50", 0)) {
      squadleaderlist = [];

      foreach(player in level.players) {
        if(player scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
          squadleaderlist = array_add(squadleaderlist, player);
        }
      }

      foreach(player in squadleaderlist) {
        player scripts\mp\gametypes\br::abandonbrsquadleader();
      }

      setDvar(@ "hash_5ec38dd7bdfbfe50", 0);
    }

    wait 1;
  }
}

function function_29e8c83db696b457() {
  player = function_69dffe7a5cb1b4b9();

  if(!isDefined(player)) {
    iprintlnbold("<dev string:x1a0e>");
    return;
  }

  spawndata = spawnStruct();
  spawndata.origin = player.origin + (100, 0, 0);
  spawndata.angles = player.angles;
  spawndata.modelname = "<dev string:x1b7f>";
  spawndata.vehicletype = "<dev string:x1b90>";
  spawndata.targetname = "<dev string:x1b9f>";
  spawndata.cannotbesuspended = 1;
  faildata = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);
  player setusingremote("<dev string:x1bab>");
  vehicle setotherent(player);
  vehicle setentityowner(player);
  player controlslinkTo(vehicle);
}

function function_820b8302ada04c55() {
  player = function_69dffe7a5cb1b4b9();
  player function_968fe965d3e8c967();
}

function function_d671c39a7867f243(args) {
  var_a3f2c8b5048491c9 = 5000;
  var_177fceb85436c082 = 100;
  var_fe52faf102ebf57b = 1000;
  var_e0be8bb269d1b3ee = -2400;

  if(isDefined(level.br_level) && isDefined(level.br_level.var_540c681a924e2df2)) {
    var_e0be8bb269d1b3ee = level.br_level.var_540c681a924e2df2;
  }

  var_3b5ad6f63af5e57a = 10000;
  var_e25c6801a01f7fce = 5000;
  var_befd185e0007a7b8 = -18000 + var_e0be8bb269d1b3ee;
  var_e89346b6c5bfd043 = 15;
  resolution = 1000;
  precision = 5;
  var_1c8f7cdf53fa7b1f = 8000;

  if(args.size == 1 && int(args[0]) == 0) {
    if(istrue(level.var_90a078e35115c032)) {
      level notify("<dev string:x1bb3>");
      level notify("<dev string:x1bc7>");
      level.var_90a078e35115c032 = undefined;
      level.holesa = [];
      level.holesb = [];
      level.var_ca369ce88e799edd = [];
      level.var_ca3699e88e799844 = [];
      level.var_ca369ae88e799a77 = [];
      level.var_fce03ebb07aa6a47 = [];
      level.var_fce03fbb07aa6c7a = [];
      level.var_8fd311aaa85b95cf = [];
      level.var_8fd312aaa85b9802 = [];
      return;
    }
  } else if(args.size > 0 && int(args[0]) > 1) {
    resolution = int(args[0]);

    if(args.size > 1) {
      precision = int(max(1, int(args[1])));
    }

    if(args.size > 2) {
      var_1c8f7cdf53fa7b1f = int(max(1, int(args[1])));
    }
  }

  level endon("<dev string:x1bb3>");
  level.var_90a078e35115c032 = 1;
  host = scripts\mp\gamelogic::gethostplayer();
  origin = host.origin;
  level.holesa = [];
  level.holesb = [];
  level.var_ca369ce88e799edd = [];
  level.var_ca3699e88e799844 = [];
  level.var_ca369ae88e799a77 = [];
  level.var_fce03ebb07aa6a47 = [];
  level.var_fce03fbb07aa6c7a = [];
  level.var_8fd311aaa85b95cf = [];
  level.var_8fd312aaa85b9802 = [];
  thread function_f474574f5e52f583();
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  org = scripts\engine\trace::sphere_trace(origin + (0, 0, var_e25c6801a01f7fce), origin + (0, 0, var_befd185e0007a7b8), var_e89346b6c5bfd043, undefined, contents)["<dev string:x18bc>"];
  checkheight = org[2] - var_fe52faf102ebf57b;
  count = 0;
  countglobal = 0;
  total = pow(2 * resolution / precision, 2) * 1;
  x = -1 * resolution;

  while(x <= resolution) {
    host iprintlnbold("<dev string:x1bd4>" + int(countglobal / total * 100));
    y = -1 * resolution;

    while(y <= resolution) {
      countglobal++;
      nextorg = (x + origin[0], y + origin[1], origin[2]);
      nextorg2 = droptogroundmultitrace(nextorg);
      count++;

      if(count >= var_1c8f7cdf53fa7b1f) {
        waitframe();
        count = 0;
      }

      if(nextorg2[2] < var_e0be8bb269d1b3ee) {
        if(level.holesa.size > var_a3f2c8b5048491c9) {
          break;
        }

        level.holesa[level.holesa.size] = nextorg + (0, 0, var_e25c6801a01f7fce);
        level.holesb[level.holesb.size] = nextorg2;
      } else {
        count++;

        if(count >= var_1c8f7cdf53fa7b1f) {
          waitframe();
          count = 0;
        }

        var_e1acc589eb122473 = scripts\engine\utility::drop_to_ground(nextorg, var_e25c6801a01f7fce, var_befd185e0007a7b8, undefined, contents);

        if(var_e1acc589eb122473[2] < var_e0be8bb269d1b3ee) {
          if(level.var_ca369ce88e799edd.size > var_a3f2c8b5048491c9) {
            break;
          }

          level.var_ca369ce88e799edd[level.var_ca369ce88e799edd.size] = nextorg + (0, 0, var_e25c6801a01f7fce);
          level.var_ca3699e88e799844[level.var_ca3699e88e799844.size] = nextorg2;
          level.var_ca369ae88e799a77[level.var_ca369ae88e799a77.size] = var_e1acc589eb122473;
        } else if(var_e1acc589eb122473[2] < checkheight && level.var_fce03ebb07aa6a47.size < var_177fceb85436c082) {
          level.var_fce03ebb07aa6a47[level.var_fce03ebb07aa6a47.size] = nextorg + (0, 0, var_e25c6801a01f7fce);
          level.var_fce03fbb07aa6c7a[level.var_fce03fbb07aa6c7a.size] = var_e1acc589eb122473;
        } else if((abs(x) == abs(resolution) || x + precision > resolution) && (abs(y) == abs(resolution) || y + precision > resolution)) {
          level.var_8fd311aaa85b95cf[level.var_8fd311aaa85b95cf.size] = nextorg + (0, 0, var_e25c6801a01f7fce);
          level.var_8fd312aaa85b9802[level.var_8fd312aaa85b9802.size] = nextorg2;
        }
      }

      y += precision;
    }

    if(level.holesa.size > var_a3f2c8b5048491c9 || level.var_ca369ce88e799edd.size > var_a3f2c8b5048491c9) {
      break;
    }

    x += precision;
  }

  host iprintlnbold("<dev string:x1be1>" + level.holesa.size + "<dev string:x1bec>" + level.var_ca369ce88e799edd.size + "<dev string:x1bff>" + level.var_fce03ebb07aa6a47.size);
}

function function_f474574f5e52f583() {
  level notify("<dev string:x1bc7>");
  level endon("<dev string:x1bc7>");

  while(true) {
    for(i = 0; i < level.holesa.size; i++) {
      orga = level.holesa[i];
      orgb = level.holesb[i];
      line(orga, orgb, (1, 0, 0), 1, 1, 1);
    }

    for(i = 0; i < level.var_ca369ce88e799edd.size; i++) {
      orga = level.var_ca369ce88e799edd[i];
      orgb = level.var_ca3699e88e799844[i];
      orgc = level.var_ca369ae88e799a77[i];
      line(orga, orgb, (1, 1, 0), 1, 1, 1);
      line(orgb, orgc, (1, 0, 0), 1, 1, 1);
    }

    for(i = 0; i < level.var_fce03ebb07aa6a47.size; i++) {
      orga = level.var_fce03ebb07aa6a47[i];
      orgb = level.var_fce03fbb07aa6c7a[i];
      line(orga, orgb, (1, 0, 1), 1, 1, 1);
    }

    for(i = 0; i < level.var_8fd311aaa85b95cf.size; i++) {
      orga = level.var_8fd311aaa85b95cf[i];
      orgb = level.var_8fd312aaa85b9802[i];
      line(orga, orgb, (0, 1, 0), 1, 1, 1);
    }

    waitframe();
  }
}

function function_237b71faf9fb62d9(player, contractref) {
  if(!isDefined(player)) {
    return;
  }

  playerorigin = player.origin;
  playerangles = player getplayerangles();
  playerforward = anglesToForward(playerangles);
  tracestart = (playerorigin[0], playerorigin[1], playerorigin[2] + player getplayerviewheight());
  traceend = tracestart + playerforward * 5000;
  tracecontents = scripts\engine\trace::create_default_contents(0);
  trace = scripts\engine\trace::ray_trace(tracestart, traceend, player, tracecontents);

  if(isDefined(trace["<dev string:x18ea>"]) || isalive(trace["<dev string:x18ea>"])) {
    namespace_1eb3c4e0e28fac71::function_22671614e8f79513(trace["<dev string:x18ea>"], contractref);
    return;
  }

  closestplayer = undefined;
  closestdist = 0;

  foreach(otherplayer in level.players) {
    if(otherplayer == player) {
      continue;
    }

    dist = distance2dsquared(otherplayer.origin, trace["<dev string:x18bc>"]);

    if(closestdist == 0 || dist < closestdist) {
      closestdist = dist;
      closestplayer = otherplayer;
    }
  }

  if(isDefined(closestplayer)) {
    namespace_1eb3c4e0e28fac71::function_22671614e8f79513(closestplayer, contractref);
    return;
  }
}

function function_9503654ca3380f8a(args) {
  skin = undefined;

  if(args.size > 0) {
    skin = args[0];
  } else {
    skins = ["<dev string:x1c0c>", "<dev string:x1c20>", "<dev string:x1c34>", "<dev string:x1c48>", "<dev string:x1c5c>", "<dev string:x1c70>", "<dev string:x1c84>", "<dev string:x1c98>"];
    skin = array_random(skins);
  }

  body = scripts\cp_mp\operator::function_8eba78e65f4be793(skin);
  head = scripts\cp_mp\operator::function_223061772e2a61b9(skin);

  if(body == "<dev string:xca1>" || head == "<dev string:xca1>") {
    return;
  }

  host = scripts\mp\gamelogic::gethostplayer();
  start = host getEye();
  dir = anglesToForward(host getplayerangles());
  end = start + 8000 * dir;
  trace = scripts\engine\trace::_bullet_trace(start, end, 1, host);

  if(trace["<dev string:x18b0>"] >= 1) {
    return;
  }

  neworigin = trace["<dev string:x18bc>"];
  newent = spawn("<dev string:x1cac>", neworigin);
  newent function_dd6d30b9ec87c1b3(body, head, "<dev string:x1cbc>");
}

function showsplash(splash, var_42b1e877ab187c6) {
  scripts\mp\hud_util::showsplashtoall(splash, undefined, undefined, undefined, undefined, var_42b1e877ab187c6);
}

function function_548e30d6072b85e9(player, amount) {
  var_affbd0043656d928 = ["<dev string:x1cd8>", "<dev string:x1ceb>", "<dev string:x1cfe>", "<dev string:x1d11>", "<dev string:x1d26>", "<dev string:x1198>", "<dev string:x1175>", "<dev string:x1d3c>", "<dev string:x1d55>", "<dev string:x1d78>", "<dev string:x1da1>", "<dev string:x1db7>", "<dev string:x1617>", "<dev string:x1dd1>", "<dev string:x1dee>"];
  remainingloot = arraycopy(var_affbd0043656d928);
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  for(i = 0; i < amount - 2; i++) {
    if(remainingloot.size == 0) {
      remainingloot = array_combine(var_affbd0043656d928);
    }

    lootname = random(remainingloot);
    remainingloot = array_remove(remainingloot, lootname);
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    scripts\mp\gametypes\br_pickups::spawnpickup(lootname, dropinfo);
  }

  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  scripts\mp\gametypes\br_pickups::spawnpickup("<dev string:x1e07>", dropinfo);
  weapon = player getcurrentprimaryweapon();
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  scripts\mp\gametypes\br_pickups::spawnpickup(weapon.basename, dropinfo, 1, undefined, weapon);
}

function function_510cb3df7efc44a7(player) {
  teammate = undefined;
  closestdist = 0;

  foreach(otherplayer in level.players) {
    if(isbot(otherplayer) && otherplayer.team == player.team) {
      dist = distance2dsquared(otherplayer.origin, player.origin);

      if(closestdist == 0 || dist < closestdist) {
        closestdist = dist;
        teammate = otherplayer;
      }
    }
  }

  if(!isDefined(teammate)) {
    return;
  }

  pingindex = undefined;
  pingdist = 0;
  playerorigin = player.origin;
  playerangles = player getplayerangles();
  playerforward = anglesToForward(playerangles);
  var_6e226a212b12f77f = (playerorigin[0], playerorigin[1], playerorigin[2] + player getplayerviewheight());
  var_b2e0a2db9493ce49 = 5000;
  var_1bd3970314fa9aea = var_6e226a212b12f77f + playerforward * var_b2e0a2db9493ce49;

  for(var_abc56346e63aa2e3 = 0; var_abc56346e63aa2e3 < 10; var_abc56346e63aa2e3++) {
    isowner = player scripts\cp_mp\calloutmarkerping::function_1e008bf9d31b2b01(var_abc56346e63aa2e3);

    if(isowner && player calloutmarkerping_getactive(var_abc56346e63aa2e3)) {
      pingorigin = player calloutmarkerping_getorigin(var_abc56346e63aa2e3);
      var_c8fb4167ea618ba8 = pointonsegmentnearesttopoint(var_6e226a212b12f77f, var_1bd3970314fa9aea, pingorigin);
      var_3a8a224f346d546f = distance(pingorigin, var_c8fb4167ea618ba8);

      if(!isDefined(pingindex) || var_3a8a224f346d546f < pingdist) {
        pingindex = var_abc56346e63aa2e3;
        pingdist = var_3a8a224f346d546f;
      }
    }
  }

  if(!isDefined(pingindex)) {
    return;
  }

  if(player function_9482e9c50b5fe82(teammate, pingindex)) {
    player function_69aa7fcdcfff4e0a(teammate, pingindex, 0);
    return;
  }

  player function_69aa7fcdcfff4e0a(teammate, pingindex, 1);
}

function function_5263a8371400329b() {
  level endon("<dev string:x1828>");
  namespace_27cdbf2464b21c84::function_ed4c2d913d203bf(level.players, "<dev string:x1e27>");
  waitframe();
  namespace_27cdbf2464b21c84::function_ed4c2d913d203bf(level.players, "<dev string:x1e3e>");
}

function function_bfe726b5e0b35c27() {
  start = self getEye();
  dir = anglesToForward(self getplayerangles());
  end = start + 8000 * dir;
  trace = scripts\engine\trace::_bullet_trace(start, end, 1, self);
  player = undefined;

  if(isDefined(trace["<dev string:x18ea>"]) && isPlayer(trace["<dev string:x18ea>"]) && isreallyalive(trace["<dev string:x18ea>"])) {
    player = trace["<dev string:x18ea>"];
  }

  return player;
}

function function_d3b9dc1b6f956ff8() {
  host = scripts\mp\gamelogic::gethostplayer();

  if(isDefined(host.savedloadout)) {
    host scripts\mp\gametypes\br::playerloadoutrestore();
    return;
  }

  host scripts\mp\gametypes\br::function_10ffa1071b1c2681();
}

function function_533bda33b99fab22(victim, var_742e3b452c9bb9b0) {
  level endon("<dev string:x1828>");
  victim scripts\cp_mp\armor::function_13caa305c839a278("<dev string:x1e54>", var_742e3b452c9bb9b0);
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  function_53a0f5e4d6bbc7a4(victim.name, undefined, 300);
}

function function_af939b4dfd7f0769(var_90ac04838df7e429, var_d1bec1cd8223b6e4, var_81abad5fa1e318d5) {
  player = self;
  player notify("<dev string:x1712>" + var_90ac04838df7e429);
  player endon("<dev string:x1712>" + var_90ac04838df7e429);

  if(var_d1bec1cd8223b6e4 == 0) {
    return;
  }

  while(true) {
    player waittill("<dev string:x1e69>", _anime, _duration);

    if(_anime != var_90ac04838df7e429) {
      continue;
    }

    var_28281bdcf431feb4 = var_81abad5fa1e318d5 * function_676cfe2ab64ea758() / 1000;

    if(var_28281bdcf431feb4) {
      wait var_28281bdcf431feb4;
    }

    switch (var_d1bec1cd8223b6e4) {
      case 1:
        player scripts\cp_mp\armor::setarmorhealth(0, 1);
        var_8a2afee27c81fff7 = player dodamage(player.health / 2, player.origin, player, player);
        break;
      case 2:
        player scripts\cp_mp\armor::setarmorhealth(0, 1);
        var_8a2afee27c81fff7 = player dodamage(player.health, player.origin, player, player);
        break;
      case 3:
        player kill();
        break;
      case 4:
        player scripts\cp_mp\armor::setarmorhealth(0, 1);
        var_8a2afee27c81fff7 = player dodamage(player.health, player.origin, player, player);
        wait var_28281bdcf431feb4;
        player kill();
        break;
      case 5:
        player scripts\cp_mp\armor::setarmorhealth(0, 1);
        var_8a2afee27c81fff7 = player dodamage(player.health / 2, player.origin, player, player);
        wait var_28281bdcf431feb4;
        var_8a2afee27c81fff7 = player dodamage(player.health, player.origin, player, player);
        wait var_28281bdcf431feb4;
        player kill();
        break;
    }

    iprintln("<dev string:x1e87>" + var_90ac04838df7e429 + "<dev string:x1e97>" + var_28281bdcf431feb4 + "<dev string:x1ea2>");
  }
}

function function_bc3a107bcc4124a9(var_5d92e0911522c004) {
  player = self;
  player notify("<dev string:x17e8>");
  player endon("<dev string:x17e8>");

  if(isDefined(level.var_fd4ccfdbe4fe025) && isDefined(level.var_fd4ccfdbe4fe025[var_5d92e0911522c004])) {
    scanner = level.var_fd4ccfdbe4fe025[var_5d92e0911522c004].var_7599776c4d607964;
  } else {
    return;
  }

  iprintln("<dev string:x1ea7>" + var_5d92e0911522c004);
  wait 2;
  playerorigin = scanner.origin + 30 * anglesToForward(scanner.angles);
  playerangles = invertangles(scanner.angles);
  player setOrigin(playerorigin);
  player setplayerangles(playerangles);
  player.health = player.maxhealth;
  iprintln("<dev string:x1ecb>");
  wait 3;

  while(true) {
    if(!isreallyalive(player)) {
      player waittill("<dev string:x1f02>");
      player setOrigin(playerorigin);
      player setplayerangles(playerangles);
      wait 1;
    }

    if(!player hasweapon("<dev string:x1f16>")) {
      player giveweapon("<dev string:x1f16>");
    }

    wait 0.05;
    scripts\engine\scriptable::scriptable_engineused(scanner, "<dev string:x1f85>", "<dev string:x1f9a>", player);

    while(scanner getscriptablepartstate("<dev string:x1f85>") != "<dev string:x1f9a>") {
      wait 0.1;
    }

    wait 1;

    if(isinlaststand(player)) {
      setdevdvar(@ "hash_a28e203d53e8292d", 1);
    }

    wait 1;

    if(isreallyalive(player)) {
      player.health = player.maxhealth;
    }
  }
}

# /